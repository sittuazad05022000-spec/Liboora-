# `PRD-015` — `P2` ANALYZER / NORMALIZATION ARCHITECTURE DECISION RECORD

| Field | Value |
|---|---|
| **Record type** | **Architecture Owner decision *preparation* record**, scoped to **`P2` ONLY** |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) — **v0.1 `DRAFT`**, Stage 2 |
| **Subject SHA256** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **verified unchanged** |
| **Parameter** | **`P2` — Analyzer, tokenizer and normalization rule configuration** (§36 **L836**) |
| **Owner of the parameter** | **Architecture Owner** (§36 **L844**; `SRCH-GAP-002` **L980**; `SRCH-GAP-007` **L985** analyzer half) |
| **`P2` STATUS** | ⛔ **BLOCKED** — see §4. Two limbs are blocked on an **undefined applicability predicate**, three are `OPEN` |
| **`P4` STATUS** | ⛔ **REMAINS BLOCKED.** ⛔ **No `P4` value is decided, proposed or recommended in this record** |
| **Conferral** | ⛔ **NOT CONFERRED.** This record prepares a decision; it does not take one |
| **Date** | 2026-09-03 |
| **Predecessor** | [`PRD-015_P4_ARCHITECTURE_DECISION.md`](./PRD-015_P4_ARCHITECTURE_DECISION.md) — established `P2` → `P4` = **REQUIRED** |

> ## ⛔ WHAT THIS RECORD IS NOT
>
> ⛔ It is **not** an approval. ⛔ It is **not** a conferral. ⛔ It does **not** advance `PRD-015` to Stage 4.
> ⛔ It does **not** freeze, baseline or rank `PRD-015`. ⛔ It creates **no** implementation task, `IMPL-*`,
> `ADR`, `BC`, event, edge, port or benchmark. ⛔ It modifies **no** prior `PRD-015` record and **no** frozen
> document. ⛔ **Every human decision field in §12 is BLANK and remains blank until an Architecture Owner fills it.**
>
> ⚠ **`SRCHPO-X5`'s discipline is carried forward:** *a recommendation is not an approval*, and an approval of a
> **behaviour** never implies the **value or rule** that implements it.

> ## 📐 READING KEY — the four registers this record keeps separate
>
> | Marker | Register | Weight |
> |---|---|---|
> | **`FACT`** | **REPOSITORY FACT** — quoted or measured from a repository document, with a citation | Binding as cited |
> | **`ANALYSIS`** | **EXPERT ANALYSIS** — reasoning performed in this record | ⚠ Not authority |
> | **`RECO`** | **RECOMMENDATION** | ⚠ **Not an approval** |
> | **`HUMAN`** | **HUMAN DECISION** | ⛔ **BLANK** |
>
> ⚠ **No sentence in this record mixes two registers.** Where analysis rests on a fact, the fact is cited.

---

## 1. Phase 0 — repository integrity gates

`FACT` — Eleven gates, executed before any analysis. **All PASS. 0 findings. No STOP condition arose.**

| # | Gate | Measured | Verdict |
|---|---|---|---|
| G1 | Branch | `main` | ✅ |
| G2 | `HEAD` | `7ff79f2e8ca7a99d6c02310dada1582c2f519b4d` | ✅ |
| G3 | Working tree | clean (`git status --porcelain` → empty) | ✅ |
| G4 | `github/main` parity | `7ff79f2e…`; `rev-list --left-right --count` → **0 / 0** | ✅ |
| G5 | **Subject SHA256** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` | ✅ **byte-identical** |
| G6 | Prior `PRD-015` records | **6** present + subject: `ARCHITECTURE_ALIGNMENT`, `ARCHITECTURE_OWNER_DECISION_PACKET`, `FINAL_ARCHITECTURE_DECISION_PREPARATION`, `P4_ARCHITECTURE_DECISION`, `PO_DECISION_RESOLUTION_RECORD`, `STAGE3_CLOSURE_ASSESSMENT` | ✅ |
| G7 | Subject version / status | **L11** `v0.1 — DRAFT`; **L12** `DRAFT` — Stage 2, *"NOT approved. NOT architecture-reviewed… NOT frozen. NOT baselined. No rank held"* | ✅ |
| G8 | `PRD_REGISTRY.md` **L315** | `PRD-015 │ Search Indexing │ BC-23 │ [GENERIC] │ V1 │ **`PLANNED`**` | ✅ unchanged |
| G9 | Frozen `PRD-021A/B/C` | last touched `16644ee` *"Stage 7 CONFERRED — PRD-021C C0-C8 FROZEN"* — historical, not this pass | ✅ untouched |
| G10 | Reserved `ADR-0088/0089/0090` | `ls … │ grep -E "0088│0089│0090" │ wc -l` → **0** files | ✅ still reserved & unwritten |
| G11 | Implementation code since `a5a2f1b` | `git diff --name-only a5a2f1b..HEAD -- lib/ tool/ pubspec.yaml` → **0** files | ✅ none |

`FACT` — **Bonus gate.** `SRCH-AC-050` confirmed present at **L1172-1174** and confirmed to test `SRCH-BR-008`.
This matters because §5 of this record makes `SRCH-AC-050` load-bearing.

⚠ `FACT` — **Disclosed limitation, not fabricated around.** `tool/docs_check/` contains **32** entries and
**no `prd015_*` validator exists** (`ls tool/docs_check/ │ grep -i "prd015\|search"` → **0 hits**). ⛔ **None was
created.** All integrity checks in §14 are **manual**, and are labelled as such. Additionally
`tool/docs_check/alignment_record_freshness.py` `RECORDS` (**L78-88**) registers only `PRD-008` and `PRD-019`, so
`PRD-015` **neither passes nor fails** that gate — it is **not covered**.

---

## 2. Phase 1 — `P2` authority audit

### 2.1 Scopes swept

`FACT` — Swept `docs/`, `tool/`, `lib/` for: `P2` · analyzer/analyser · tokenizer/tokenisation · normalization ·
Unicode · NFC/NFD/NFKC/NFKD · case folding · Devanagari · Latin · Hindi · Hinglish · ZWJ · ZWNJ · zero-width ·
combining mark · grapheme · code point · scalar value · UTF-16 · code unit · virama/halant · conjunct · danda ·
diacritic · script · normalized token · query/index normalization · symmetry · and the identifiers
`SRCH-FR-023`, `SRCH-FR-024`, `SRCH-BR-008`, `SRCH-AC-050`, `SRCH-AC-030`, `SRCHPO-1`, `SRCHPO-X5`,
`SRCH-GAP-002`, `SRCH-GAP-007`, `SRCH-GAP-008`.

### 2.2 ⭐⭐⭐ Two homonym traps — disarmed explicitly, before classification

`FACT` — Both were live in the raw sweep output and both would have produced a **false authority** if classified
naively. They are disarmed by name so that no later reader re-imports them.

| Trap | Raw hit | What it actually is | Disposition |
|---|---|---|---|
| ⚠⚠ **"NFC"** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L755** `NFC/BLE Attendance (V3)`; `PRD-006_ATTENDANCE-MANAGEMENT.md` **L177** *"RFID, NFC, BLE attendance"*, plus **L495**, **L2509**, **L3170**, `PRD-006_REQUIREMENTS_REVIEW.md` **L200**, `PRD-006_ARCHITECTURE_ALIGNMENT.md` **L421**, `PRD-006_ADDITIVE_WIFI_PRESENCE_IMPACT_REPORT.md` **L158**, `PRD-006_IMPLEMENTATION_TASKS.md` **L244**/**L499** | **Near Field Communication** — a physical attendance-capture radio, paired with BLE and RFID in every instance. ⛔ **Not** Unicode Normalization Form C | **Class D.** ⛔ **10 hits excluded.** ⭐ Had these been read as Unicode authority, this record would have reported a *"declared NFC form"* that does not exist |
| ⚠⚠ **"conjunct"** | repo-wide | **Governance-gate conjuncts** — logical AND across lifecycle gate conditions. ⛔ **Not** Devanagari consonant conjuncts | **Class D.** ⛔ Excluded |

`FACT` — **Three further false friends, same discipline:**

| Raw hit | What it is | Class |
|---|---|---|
| `module_dependencies.yaml` **L548** `analyzer:`; `BOUNDARY_CHECKER_DESIGN.md` **L48-53**; `ADR-0014` **L174** *"AST analysis (`package:analyzer`)"* | The **Dart `package:analyzer`** — a static-analysis library. ⛔ Not a search analyzer | **D** |
| `ADR-0044` **L110**/**L337** *"Tokenisation: does a search for `PO-n` reach `FEE-PO-n`?… `'FEE-PO-003'` → `['FEE-PO']`"*; `PRD-021B_B1` **L107**; `PRD-021B_B3` **L88** | **Identifier-stem tokenisation inside a docs-checker script.** ⛔ Not text analysis of user content | **D** |
| `PRD-012a_PART3` **L143**/**L150**, `PART4` **L94**, `PART8` **L220** *"Field-level encryption, tokenization"* | **Security tokenization** — substituting a surrogate for sensitive data, `V2/V3`, expressly excluded by `SECP-XC-021`. ⛔ A different concept sharing a word | **D** |

### 2.3 ⭐⭐⭐ The decisive Phase 1 measurement — `Devanagari` appears in **5 files, all `PRD-015` records**

`FACT` — `grep -rniE "devanagari|hindi|hinglish|romani[sz]ed" docs/ tool/ lib/ -l` returns **exactly five files**:

```
docs/30-product/search/PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md
docs/30-product/search/PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md
docs/30-product/search/PRD-015_P4_ARCHITECTURE_DECISION.md
docs/30-product/search/PRD-015_PO_DECISION_RESOLUTION_RECORD.md
docs/30-product/search/PRD-015_STAGE3_CLOSURE_ASSESSMENT.md
```

⚠⚠ **Four consequences, each stated because each is easy to get wrong:**

1. `FACT` — **The subject `PRD-015_SEARCH_INDEXING.md` is NOT in that list.** The subject document contains
   **zero** occurrences of *Devanagari*, *Hindi* or *Hinglish*. Its only script-related words are the generic
   *"the field's declared script and language scope"* (**L416**) and the `SRCH-GAP-007` note (**L434-436**).
2. `FACT` — **No Rank 1, Rank 4, Rank 5 or Rank 6 document mentions Devanagari.** `LIBOORA_ENTERPRISE_ARCHITECTURE.md`,
   `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, `ARCHITECTURE_RULINGS.md`,
   `CONFIGURATION_GUIDE.md`, `MASTER_PRD.md` — **0 hits each**.
3. `FACT` — Therefore **the entire Devanagari obligation rests on exactly one authority**, `SRCHPO-1`, recorded in
   a `PRD-015` decision record — and on **no** specification text.
4. `ANALYSIS` — ⭐⭐ **So `P2` is not a case of "the repository says how, but not which library".** The repository
   states **which scripts** (`SRCHPO-1`) and **what normalization must achieve** (`N1`–`N6`), and states
   **nothing whatsoever** about how either script is to be handled. This is the audit's central negative result
   and it is measured, not assumed.

`FACT` — Corroborating negative measurements, each executed independently:

| Sweep | Result outside `PRD-015_*` records |
|---|---|
| `code point` · `scalar value` · `UTF-16` · `code unit` · `grapheme` · `extended grapheme` | ⛔ **0 hits in `docs/`, `tool/`, `lib/`** |
| `NFC` / `NFD` / `NFKC` / `NFKD` as **Unicode forms** | ⛔ **0 hits** (all 10 raw hits are §2.2's Near-Field-Communication trap) |
| `ZWJ` · `ZWNJ` · `U+200C` · `U+200D` · `zero-width` | ⛔ **0 hits outside `PRD-015_*`** — the subject says *"zero-width"* once (`N6`, **L425**) and once at **E6** (**L945**), ⛔ naming **no code point** |
| `danda` · `।` | ⛔ **0 hits outside** `PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md` **L147** |
| `ARCHITECTURE_RULINGS.md` for unicode/normali*/token/analyz/grapheme/devanagari/case-fold/diacritic | ⛔ **0** (the single `script`-adjacent hit, **L45**, is a branding-value ownership row) |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` for normali*/analyz*/tokeni*/grapheme/devanagari/unicode/diacritic/zero-width | ⛔ **0 hits** |
| `CONFIGURATION_GUIDE.md` for any `SRCH-*` identifier | ⛔ **0 hits** *(measured in the `P4` pass, re-confirmed)* |

### 2.4 A–F classification of every relevant hit

⚠ **Classification rule applied throughout:** *"Never treat a technology default as repository authority."*
⛔ No row below is classified **A** because a search engine, a Unicode annex or a common practice does it that way.

#### Class A — AUTHORITATIVE (binding on `P2`)

| # | Authority | Location | What it binds |
|---|---|---|---|
| A1 | **`SRCH-FR-023`** | subject **L414-415** | *"Normalization **MUST** be applied **identically** at index time and at query time, by the same declared rule set."* ⭐ *"declared"* is load-bearing |
| A2 | **`SRCH-FR-024`** | subject **L416-425** | *"Normalization **MUST**, **where compatible with the field's declared script and language scope**:"* then **`N1`–`N6`** ⭐⭐ the conditional clause is load-bearing — see §5.2 |
| A3 | **`N1`** | **L420** | *"Case folding — matching is **case-insensitive**"* · illustration `central library` ≡ `Central Library` ≡ `CENTRAL LIBRARY` |
| A4 | **`N2`** | **L421** | *"Leading, trailing and repeated **whitespace** collapse"* |
| A5 | **`N3`** | **L422** | *"**Punctuation and separator** normalization"* · `St. Mary's` ≡ `St Marys`; `Co-operative` ≡ `Co operative` |
| A6 | **`N4`** | **L423** | *"Unicode canonical normalization and compatible **diacritic** folding"* · `Café` ≡ `Cafe` |
| A7 | **`N5`** | **L424** | *"**Tokenization** into terms on normalized separators"* · `Central Library` → `central` + `library` |
| A8 | **`N6`** | **L425** | *"Removal of zero-width, control and formatting characters"* · *"invisible characters cannot create a distinct name"* |
| A9 | **`SRCH-BR-008`** | **L427-429** | *"symmetric and total: any transformation applied to a query term **MUST** have been applied to the indexed term, and vice versa."* ⛔ *"An asymmetric rule **MUST NOT** be introduced, because it silently makes some indexed documents permanently unreachable"* |
| A10 | ⭐⭐⭐ **`SRCH-AC-050`** | **L1172-1174** | *"**Given** the normalization rule set, **when each rule is checked for symmetry**, **then** every transformation applied to a query term is also applied to indexed terms, and no indexed document is unreachable through its own indexed value."* ⭐ **iterates the rules** |
| A11 | **`SRCH-AC-023`** | **L1081-1082** | index-time and query-time application *"produce the same normalized form in both cases"* |
| A12 | **`SRCH-AC-024`** | **L1084-1086** | the **only** normalization test cases: `central library`, `Central   Library`, `St Marys`, `Cafe` → `Central Library`, `Central Library`, *St. Mary's*, *Café* at **T1** under `N1`–`N6`. ⚠⚠ **All four are Latin** |
| A13 | **`SRCH-BR-011`** | **L548-549** | Equivalence *"**MUST** be derived from a **declared** rule set or vocabulary, and **MUST NOT** be inferred from usage, click behaviour, co-occurrence or any learned model"* |
| A14 | **Normalization ≠ tolerance** | **L431-433** | *"`N1`–`N6` do not guess. Two strings that normalize identically **are** the same term at the **EXACT** tier (§18)"* ⭐⭐ so normalization reaches **exact**-role fields — see §11 Security |
| A15 | **§16 scope note** | **L434-436** | *"the **set of languages and scripts** whose diacritic and separator rules apply is **not stated by any repository authority**… ⛔ No inventory is asserted here"* |
| A16 | **`SRCH-FR-018`** | **L375-376** | Each eligible field **MUST** declare its **match role**: **text** / **exact** / **filter** |
| A17 | **`SRCH-BR-007`** | **L377-378** | ⛔ A field's match role **MUST NOT** be widened by `BC-23` |
| A18 | **`SRCH-FR-034`** | **L578-581** | Ordering **MUST** be *"deterministic and total"*; identical query + index + authorisation ⇒ identical order |
| A19 | **§36 `P2` definition** | **L836** | `P2` = *"Analyzer, tokenizer and normalization rule configuration"*, *"Required to exist by"* → **`SRCH-FR-023`, `SRCH-FR-024`** |
| A20 | **§36 owner line** | **L844** | *"**Owner: Architecture Owner.** ⛔ **Blocks Stage 3 architecture review; blocks nothing in Stage 2**"* |
| A21 | **`SRCH-GAP-002`** | **L980** | *"All implementation parameters `P1`–`P8`: engine, **analyzer config**, edit-distance bound, minimum token/prefix length…"* → **Architecture Owner**, **Stage 3** |
| A22 | **`SRCH-GAP-007`** | **L985** | *"The **language/script inventory** and the declared variant/abbreviation vocabulary for §16 and §20"* → **Product Owner** (markets) **+ Architecture Owner** (analyzer), **Stage 3** |
| A23 | **`SRCH-GAP-004`** | **L982** | keyword stuffing → *"⭐ **Architecture Owner** (analyzer) **+ Product Owner** (acceptable use)"*, ⛔ nothing in V1 |
| A24 | ⭐⭐⭐ **`SRCHPO-1`** | `PO_DECISION_RESOLUTION_RECORD` **L57** | *"**V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script).** This is a **closed set** for V1"* |
| A25 | **`SRCHPO-2`** | same **L58** | Hinglish/Romanized Hindi = *"supported **query behaviour** where technically validated. It is **NOT** a canonical third language"* |
| A26 | **`SRCHPO-3`** | same **L59** | *"the conditional… is **load-bearing**"* — *"permitted, not required"*; *"An implementation that cannot validate it **MUST NOT** claim it"* |
| A27 | **`SRCHPO-4`** | same **L73** | Case-insensitive matching **ENABLED** → ✅ **CONFIRMED — already a MUST** via `N1` (**L419**) |
| A28 | **`SRCHPO-5`** | same **L74** | Token-aware matching **ENABLED** → confirmed via `N5` + `SRCH-FR-029`. ⛔ *"The **tokenizer algorithm** is deliberately **not** defined"* |
| A29 | **BC Map **L132**** | Rank 4 | **`BC-23` Search Indexing** *"Owns indices, permission-aware indexing, tenant index isolation, relevance, query rewriting"* |
| A30 | **`E2`** | **L942** | *"Text term of only punctuation/whitespace │ Normalizes to no tokens ⇒ treated as `E1`, ⛔ never as 'match all at T3'"* |
| A31 | **`E6`** | **L945** | *"Indexed value containing an invisible/zero-width character │ **`N6` removes it** — ⛔ it cannot create an unmatchable name"* ⭐⭐ the **only** authority on zero-width **direction** |
| A32 | ⭐ **`R7`** | **L965** | *"Cross-tenant leakage through relevance statistics │ Medium │ §28 consequence 3; no corpus-statistic scoring │ **Depends on `P2` honouring §22**"* ⭐ the **only** risk row that names `P2` |
| A33 | **`SRCH-INV-004`** / **`SRCH-BR-004`** | **L324** / **L320** | Tenant Operational Data **MUST NEVER** enter the Platform Public Discovery Index; every tenant-operational index identity **MUST** include the tenant key |
| A34 | **`SRCH-FR-035`** | **L582-591** | Ordering = **tier → field precedence → declared stable tiebreak**; ⛔ *"There is no numeric relevance score in this model, and that is deliberate"* |
| A35 | **`SRCH-INV-006`** | **L379** | *"A field that is not declared eligible is not indexed, not matchable, and not returnable"* |

#### Class B — SUPPORTING (analysis that informs `P2`, ⚠ not itself authority)

| # | Source | Content carried forward |
|---|---|---|
| B1 | ⭐⭐ `ARCHITECTURE_OWNER_DECISION_PACKET` **§5.1**, **L143-152** | The **nine-row analyzer requirement table** — the packet's own words: *"the **requirement set is now complete**, even though the configuration is not."* ⛔ **Not re-derived here**, per its own instruction |
| B2 | packet **L145** | *"Latin. ⚠ **Devanagari is unicameral — it has no case.** A configuration that assumes case folding is universal is wrong for Hindi"* |
| B3 | packet **L147** | *"⚠ Both — Devanagari uses the **danda** (`।`) as a separator, not a full stop"* ⚠ **the only danda mention in the repository** |
| B4 | packet **L148** | *"⚠⚠ Both, and **NFC vs NFD matters more for Devanagari than for Latin** — matras and nukta forms have multiple encodings"* |
| B5 | packet **L149** | *"⚠ Both — ⛔ Devanagari word boundaries are **not** identical to Latin whitespace rules"* |
| B6 | ⭐⭐ packet **L150** | *"⚠⚠ **Critical for Devanagari** — ZWJ/ZWNJ (`U+200D`/`U+200C`) are **meaningful** in Indic conjuncts, so blanket removal may corrupt tokens while retention may permit invisible-character spoofing. ⭐ **This is a genuine tension the owner must resolve**"* |
| B7 | packet **L152** | *"⚠ **Hinglish tolerance where technically validated** │ ⛔ Permitted, **not required**; ⛔ no transliteration rule authorised"* |
| B8 | packet **§5.2** **L155-162** | Authority table: scripts ✅ `SRCHPO-1` · behaviour ✅ `N1`–`N6` · symmetry ✅ `BR-008` · learned equivalence ⛔ no · **library/configuration ⛔ Absent** · **stemmer ⛔ Absent** |
| B9 | ⭐⭐ packet **L196** | *"Devanagari's **matra** marks are separate code points, so a single visual \"letter\" may be **2–3 code points**. A bound measured in code points is therefore **not** equivalent in strictness across the two scripts"* |
| B10 | packet **L220** | *"⚠ Devanagari │ Same code-point-vs-grapheme caveat as §6"* — carried into the `P4` approach table |
| B11 | ⭐⭐⭐ `FINAL_ARCHITECTURE_DECISION_PREPARATION` **§5.2**, **L214-231** | *"`SRCH-AC-050` requires **each rule** to be checked. A rule set that is not enumerable in the repository cannot satisfy it. ⇒ **The normalization rule set MUST be a declared, `BC-23`-owned artefact.** An engine may *execute* it; the engine **MUST NOT be the definition of it**"* — and *"⭐ This also **de-couples `P2` from `P1`**"* |
| B12 | preparation **L242** (`P2-a`) | *"⚠ Devanagari is **unicameral**. Under `SRCH-AC-050`'s per-rule check these differ: *not applicable* is an auditable declaration; a silent no-op is an **unchecked** rule. ⛔ The distinction is invisible at runtime and only appears in review"* |
| B13 | preparation **L243** (`P2-b`) | *"⚠⚠ **Genuine tension, both directions harmful.**… ⛔ Neither limb is a default; ⛔ no policy is proposed"* |
| B14 | preparation **L244** (`P2-c`) | Hinglish — *"where technically validated"* load-bearing; ⛔ no transliteration rule, stemmer or language-detection method proposed |
| B15 | preparation **§5.4** **L248-254** | Recommendation (⚠ **recommendation only**): rule set as `BC-23`-owned engine-independent artefact; risk **(b)** *"⛔ `P2-b` left open means Devanagari indexing **cannot be implemented correctly yet** — this is a real V1 schedule risk and is stated rather than hidden"* |
| B16 | `PO_DECISION_RESOLUTION_RECORD` **§2.4**, **L110-113** | `SRCHPO-1` *"now supplies that scope — Latin and Devanagari — so **`N3`/`N4` acquire a declared** scope"*, discharging alignment **L1060**'s specific complaint |
| B17 | `PO_DECISION_RESOLUTION_RECORD` **L101** | *"**Analyzer configuration** for the declared scripts │ **Architecture Owner** │ ⛔ **NO**"* |
| B18 | `PO_DECISION_RESOLUTION_RECORD` **L434** (`SRCHPO-A3`) | *"`SRCHPO-1` supplies §16 `N3`/`N4` with a declared script domain for the first time"* — ✅ ACCEPTED |
| B19 | `ARCHITECTURE_ALIGNMENT` **L1050** | *"⭐⭐ **Normalization is correctly separated from tolerance** (§16): `N1`–`N6` *\"do not guess\"*"* |
| B20 | `STAGE3_CLOSURE_ASSESSMENT` **L208** | *"3. **It says nothing about scripts**, and `PRD-015` §16 **`N4`** requires **Unicode/diacritic** handling"* |

#### Class C — HISTORICAL (recorded, superseded or already discharged; ⛔ **not modified by this record**)

| # | Source | Status |
|---|---|---|
| C1 | packet **§5.3** four-item list (**L167-172**) | **Superseded in form** by preparation **§5.3**, which promoted items 2–4 to labelled sub-decisions `P2-a`/`P2-b`/`P2-c` and absorbed item 1 into `P1` gating. ⛔ Left standing; not edited |
| C2 | `P4_ARCHITECTURE_DECISION` **§4.1** | Established `P2` → `P4` = **REQUIRED**. ⭐ **Re-verified independently in §10**, not inherited |
| C3 | `P4_ARCHITECTURE_DECISION` **L286-288** | The `U1`/`U2`/`U3` unit findings from the `P4` pass. ⭐ Re-derived from primary sources in §6 |
| C4 | `ARCHITECTURE_ALIGNMENT` **L1060** | *"Without `SRCH-GAP-007`'s language inventory, `N3`/`N4`'s separator and diacritic rules have no declared"* scope — ✅ **discharged** by `SRCHPO-1` per **B16** |
| C5 | `STAGE3_CLOSURE_ASSESSMENT` **L206** | *"a **`P2`** property (case folding, diacritic folding, tokenization per script); `LCFG-2` is a Product locale"* — ⭐ the ruling that keeps `LCFG-2` **out** of `P2` (see **D1**) |
| C6 | `PO_DECISION_RESOLUTION_RECORD` **L141** | `P2` row: *"⚠ **Scope narrowed, not configured.**… ⛔ **OPEN** — Architecture Owner. ⭐ Now **better specified as a question**"* — the position this record advances from |
| C7 | `SRCHPO-X2` **L441** | *"`SRCH-GAP-007` is CLOSED"* → ⛔ **REJECTED**; it is **PARTIALLY CLOSED** |

#### Class D — NON-AUTHORITATIVE (⛔ **must not be imported as `P2` authority**)

| # | Hit | Why it is not `P2` authority |
|---|---|---|
| D1 | ⭐ **`LCFG-2`** — Language `en`, range *"Supported set"*, owner **Product**, *"Only locale with complete strings at V1"* (`CONFIGURATION_GUIDE.md` **L352**) | ⭐⭐ **Expressly ruled out already.** `STAGE3_CLOSURE_ASSESSMENT` **L206**: *"`LCFG-2` is a Product locale"*, contrasted against *"a `P2` property"*. ⚠ It is also a **UI-string locale**, not a **script inventory**, and `CONFIGURATION_GUIDE.md` contains **0** `SRCH-*` identifiers. ⛔ Importing it would mean `P2` = `en` only, which **contradicts** `SRCHPO-1` |
| D2 | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1524** `Tokenisation & Analysers (V2)` | ⛔ Rank 6, **descriptive**; and tagged **V2**, not V1. ⚠ `ADR-0046` §9 (**L255-258**) precedent: a Rank-6 descriptive line is *"corroboration, not grounds"*. ⛔ It names **no** analyzer, tokenizer, form or unit |
| D3 | EA **L1546-1547** `Multi-Language Support (V3)` · `Autocomplete (V3)` | ⛔ Rank 6 descriptive, **V3**. ⚠ And a **conflict already recorded**, not resolved here: `SRCHPO-1` places two scripts in **V1** while EA tags multi-language **V3**. Logged as **F-8** in §2.5 |
| D4 | EA **L339** `NFR Budgets (V1)` | ⛔ A planned node; the document **does not exist** |
| D5 | EA **L1057** `Tokenization & Rehydration (V3)` · **L2003** `Tokenization (V3)` | ⛔ Security tokenization, `V3`; and `SECP-XC-021` excludes it from V1 |
| D6 | §2.2's **10** Near-Field-Communication hits | ⛔ Homonym |
| D7 | `package:analyzer` hits · `ADR-0044` identifier tokenisation · `PRD-012a` security tokenization | ⛔ Homonyms (§2.2) |
| D8 | `PRD-021C_C2` **L27**, **L287**, **L317** (`LSD-XC-004`); `C0` **L342**, **L427** (`XPC-OD-009`), **L473** | ⭐ These are **prohibitions on C2/C6**, and they **point at** `P2` rather than supplying it: *"⛔ **MUST NOT** author `BC-23`'s index internals, **analyzers**, scoring or query-rewriting rules"*. Reclassified to **E** for the prohibition limb — listed here only to record that they contain **no** analyzer content |
| D9 | `Library_PRD_v1.md` **L212** Library Name *"2–120 characters"*; `SCFG-1` **L1335** username *"3–30"*; `IT-3` **L47** *"8-character"*; `SCFG-6` **L1340** bio *"300"* | ⭐⭐ **Important negative:** these are the repository's **only** character-count precedents, and **every one of them uses the bare word *"character"* with no unit definition** and none is a search authority. ⛔ They supply **no** `P2` counting unit — see §6 |

#### Class E — PROHIBITION (constrains what `P2` may contain)

| # | Prohibition | Source |
|---|---|---|
| E1 | ⛔ *"Do not claim universal transliteration support unless repository authority already establishes it."* — measured: **0** hits, so **no** such claim is made | `SRCHPO-1` constraint, **L57** |
| E2 | ⛔ *"Do not invent transliteration rules."* ⛔ *"Do not invent Hindi/English stemming algorithms."* ⛔ *"Do not invent language detection."* | `SRCHPO-2` constraint, **L58** |
| E3 | ⛔ Equivalence **MUST NOT** be inferred from usage, click behaviour, co-occurrence or any learned model | `SRCH-BR-011` **L548-549**; `SRCH-XC-005` **L167** |
| E4 | ⛔ `BC-23` **MUST NOT** hardcode any consumer's field names, surface or product vocabulary | `SRCH-XC-014` **L341** |
| E5 | ⛔ `BC-23` **MUST NOT** define, alter or restate any §14A field, eligibility rule or visibility rule | `SRCH-XC-001` **L158** |
| E6 | ⛔ No ML/AI ranking, learned relevance, behavioural personalisation, vector DB, semantic embedding or LLM retrieval | `SRCH-XC-003` **L163**; `SRCH-XC-004` **L165** |
| E7 | ⛔ No tunable ranking weight, boost or business-ordering parameter | `SRCH-XC-009` **L230** |
| E8 | ⛔ *"An undeclared abbreviation table is indistinguishable from invented product vocabulary, which `SRCH-XC-014` forbids"* | subject **L551-553** |
| E9 | ⛔ C2 and C6 **MUST NOT** author `BC-23`'s analyzers — so `PRD-021C` cannot supply `P2` even by consent | `LSD-XC-004`; `LSD-XC-002`; `XPC-OD-009` |
| E10 | ⛔ *"A recommendation is NOT an approval"*; ⛔ **an approved behaviour does not imply its value or rule** | `SRCHPO-X5`; `PRD_LIFECYCLE.md` **L161** *"Freeze is conferred, not claimed"* |
| E11 | ⛔ *"a further decision requires its own conferral"* — each `P2` limb needs its own act | `ADR-0046` §9, **L240-266** |
| E12 | ⛔ *"**Only the Architecture Owner approves.**"* A product answer is not an architecture approval | `SRCHPO-X1`, citing `PRD_OWNERSHIP_MODEL.md` §5 |
| E13 | ⛔ *"Never record a personal name"* — the owner field stays a **role** | `PRD_OWNERSHIP_MODEL.md` §7 rule 4, **L318** |
| E14 | ⛔ `ADR-0094` *"does not author `PRD-015`"* | `ADR-0094` |

#### Class F — UNKNOWN (⛔ **no authority anywhere — measured, not assumed**)

| # | Question | Measurement |
|---|---|---|
| **F-1** | Which **Unicode normalization form** — `NFC`, `NFD`, `NFKC` or `NFKD`? | ⛔ **0 authoritative hits.** `N4` says *"Unicode **canonical** normalization and compatible **diacritic** folding"* and names **no form** |
| **F-2** | What **unit** counts a normalized character/token length? | ⛔ **0 hits** for code point, scalar value, UTF-16, code unit, grapheme — see §6 |
| **F-3** | **ZWJ / ZWNJ** (`U+200D` / `U+200C`) policy | ⛔ **0 hits outside `PRD-015_*` records.** `N6` + `E6` name **no code point** |
| **F-4** | **Devanagari case-folding** treatment | ⛔ **0 hits.** ⚠ And see §9 — the question may be **malformed** |
| **F-5** | ⭐⭐ **Which script does any given field declare?** | ⛔ **0 hits repository-wide** for a per-field script declaration — see §5.2. ⚠ **This is the sharpest finding in this record** |
| **F-6** | **Tokenizer algorithm** / word-boundary rule, per script | ⛔ Absent, and `SRCHPO-5` records it as *"deliberately **not** defined"* |
| **F-7** | **Script detection** mechanism | ⛔ **0 hits**; `SRCHPO-2` forbids inventing language detection (**E2**) |
| **F-8** | ⚠ Rank-1/Rank-6 tension: `SRCHPO-1` puts **two scripts in V1**; EA **L1546** tags `Multi-Language Support` **V3** | ⚠ **Recorded, not resolved.** ⛔ Not this record's to resolve; routed in §12 as context to `SRCHAO-P2d` |
| **F-9** | **Normalized-token representation** (what an index stores after `N1`–`N6`) | ⛔ **0 hits** |
| **F-10** | Devanagari **separator inventory** (danda `।`, double danda `॥`) under `N3` | ⛔ **0 hits outside** packet **L147**, which is **Class B**, not authority |
| **F-11** | **Analyzer library / stemmer / product** | ⛔ Absent — packet **§5.2** records both as *"⛔ Absent"*; gated on `P1` |

### 2.5 Phase 1 tally

`FACT` — **A = 35 · B = 20 · C = 7 · D = 9 (covering 20+ raw hits) · E = 14 · F = 11.**

`ANALYSIS` — ⭐⭐ **The shape of the audit result is the finding.** Class **A** is unusually large — the
*behavioural* requirement on normalization is among the most fully specified in `PRD-015`. Class **F** is
simultaneously large, and **every member of F is a mechanism, unit or predicate**, not a behaviour. ⇒ `P2` is not
under-specified as to *what* normalization must achieve; it is **entirely unspecified as to what normalization
operates on and in what units** — and, per **F-5**, as to *when each rule applies at all*.

---

## 3. Phase 2 — what `P2` actually owns

⚠ **Method.** Every candidate is tested against repository evidence. ⛔ **A candidate is not assigned to `P2`
merely because an analyzer commonly performs it.** Where evidence assigns it elsewhere, it is recorded as
**NOT `P2`** with the owner named.

### 3.1 The four named limbs

#### `P2-A` — analyzer / tokenizer configuration **source**

| Field | Content |
|---|---|
| **OWNER** | **Architecture Owner** |
| **AUTHORITY** | `FACT` — §36 **L836** + **L844**; `SRCH-GAP-002` **L980**; `SRCH-GAP-007` **L985** *"+ **Architecture Owner** (analyzer)"*; BC Map **L132** places analysis inside `BC-23` |
| **STATUS** | ⛔ **OPEN** — with a **strong repository-derived constraint on the answer**, see below |
| **DEPENDENCIES** | `P1` = **OPTIONAL** (§10). ⭐ The *declaration* limb is `P1`-independent; the *executor binding* limb is not |
| **EVIDENCE** | `FACT` — packet **§5.2**: *"Which library / configuration? ⛔ **Absent**"*, *"Which stemmer? ⛔ **Absent**"*. ⛔ **0** hits for any engine or analyzer product across `docs/` |

⭐⭐ `ANALYSIS` — **The *location* half of `P2-A` is very tightly constrained by three Class-A authorities, and
the constraint is not a matter of taste.** `SRCH-FR-023` (**A1**) requires *"the same **declared** rule set"*;
`SRCH-BR-008` (**A9**) requires the set to be **total**, which is a proof obligation over the **whole** set;
and `SRCH-AC-050` (**A10**) says *"**when each rule is checked** for symmetry"* — an acceptance criterion that
**iterates the rules individually**. A rule set that exists only as a vendor analyzer's internal behaviour is not
*declared*, is not **enumerable**, and therefore cannot be *iterated* — so `SRCH-AC-050` would be **untestable**.
`SRCH-FR-034` (**A18**) sharpens it: a vendor analyzer upgrade would change normalization **with no repository
change**, breaking determinism silently.

`RECO` — ⚠ **Recommendation, not approval.** The normalization rule set should be a **declared, `BC-23`-owned,
engine-independent artefact**, with any engine acting as **executor and never as definition**. ⭐ This is the
same conclusion `FINAL_ARCHITECTURE_DECISION_PREPARATION` **§5.2** reached (**B11**); it is **re-derived here
from the Class-A sources**, not inherited. ⛔ **No library, stemmer, tokenizer, transliteration rule or
language-detection method is proposed.** ⛔ **This is not an approval** — see `SRCHAO-P2a`.

⚠ `ANALYSIS` — **The unavoidable residual risk of that recommendation, stated rather than hidden.** If the
declared rule set is applied in application code **and** an engine also applies its own internal analysis, the
two can diverge — and divergence between index-side and query-side processing is **exactly** the
`SRCH-BR-008` failure mode (*"silently makes some indexed documents permanently unreachable"*). ⇒ Any eventual
`P1` choice must be constrained so that engine-internal analysis is **disabled or provably equivalent**. That
constraint belongs to `P1`; ⛔ it is **not** imposed here.

#### `P2-B` — Devanagari case-folding behaviour

| Field | Content |
|---|---|
| **OWNER** | **Architecture Owner** |
| **AUTHORITY** | `FACT` — `N1` (**A3**) requires case folding; `SRCHPO-4` (**A27**) confirms case-insensitivity is *already a MUST*; `SRCHPO-1` (**A24**) puts Devanagari in the closed V1 set. ⛔ **No authority states any Devanagari behaviour** (**F-4**) |
| **STATUS** | ⛔ **BLOCKED** — see §9. ⚠ **The question as posed may be malformed**, and that must be resolved before it can be answered |
| **DEPENDENCIES** | **F-5** (per-field script declaration) = **REQUIRED**; `P2-D` (script-aware vs uniform) = **REQUIRED** |
| **EVIDENCE** | `FACT` — packet **L145**: *"⚠ **Devanagari is unicameral — it has no case.** A configuration that assumes case folding is universal is wrong for Hindi"*. `FACT` — preparation **L242**: *"not applicable"* is auditable, a silent no-op is **unchecked**; *"⛔ The distinction is invisible at runtime and only appears in review"* |

#### `P2-C` — `ZWJ` / `ZWNJ` policy

| Field | Content |
|---|---|
| **OWNER** | **Architecture Owner** ⭐ **+ Security** for the spoofing limb |
| **AUTHORITY** | `FACT` — `N6` (**A8**) *"Removal of zero-width, control and formatting characters"*; `E6` (**A31**) *"`N6` removes it — ⛔ it cannot create an unmatchable name"*. ⛔ **Neither names `U+200C`, `U+200D` or any Indic exception** (**F-3**) |
| **STATUS** | ⛔ **OPEN** — ⚠ and **materially more constrained than prior records recorded**, see §8 |
| **DEPENDENCIES** | `P2-D` = **REQUIRED**; **F-1** (Unicode form) = **OPTIONAL** |
| **EVIDENCE** | `FACT` — packet **L150** / preparation **L243**: *"⚠⚠ **Genuine tension, both directions harmful**… ⛔ Neither limb is a default; ⛔ no policy is proposed"* |

#### `P2-D` — script-aware vs uniform normalization

| Field | Content |
|---|---|
| **OWNER** | **Architecture Owner** |
| **AUTHORITY** | ⭐⭐ `FACT` — **`SRCH-FR-024`'s own preamble** (**A2**, **L416**): *"Normalization **MUST**, **where compatible with the field's declared script and language scope**"*. ⭐ **The conditional exists in the FROZEN-track requirement text**, so the *possibility* of script-conditional behaviour is already in the requirement — but **nothing states the condition's inputs** |
| **STATUS** | ⛔ **BLOCKED** — dependent on **F-5**, which has **0** authority |
| **DEPENDENCIES** | **F-5** = **REQUIRED**. `P2-B`, `P2-C` and §6's unit question all **depend on** `P2-D` |
| **EVIDENCE** | `FACT` — `SRCH-FR-018` (**A16**) declares **match roles** — *text*, *exact*, *filter* — and ⛔ **not scripts**. `FACT` — repository-wide sweep for a per-field script declaration → ⛔ **0 hits** |

⭐⭐⭐ `ANALYSIS` — **`P2-D` is logically prior to `P2-A`, `P2-B` and `P2-C`, and this ordering is forced, not
chosen.** `SRCH-FR-024` makes each of `N1`–`N6` apply *"where compatible with the field's declared script"*.
Until it is settled whether a field **has** a declared script — and, if so, who declares it — the applicability
of every rule is undetermined, and therefore the Devanagari limbs cannot be answered in isolation.

### 3.2 The nine additional candidate controls — tested, not assumed

| Candidate | Is it `P2`'s? | Evidence | Status |
|---|---|---|---|
| **Unicode normalization form** (`NFC`/`NFD`/`NFKC`/`NFKD`) | ✅ **YES — `P2`** | `FACT` — §36 **L836** binds `P2` to `SRCH-FR-024`, and `N4` (**A6**) is the clause requiring *"Unicode canonical normalization"*. No other parameter or owner claims it | ⛔ **OPEN** (**F-1**) |
| **Diacritic handling** | ✅ **YES — `P2`** | `FACT` — `N4` (**A6**) *"compatible **diacritic** folding"*; ✅ **scope now declared** by `SRCHPO-1` per **B16**/**B18** | ⛔ **OPEN** as to mechanism; ✅ **CLOSED** as to script scope |
| **Zero-width handling** | ✅ **YES — `P2`** | `FACT` — `N6` (**A8**) + `E6` (**A31**) | ⛔ **OPEN** for `ZWJ`/`ZWNJ` (**F-3**); ✅ **direction settled** for the generic case by `E6` |
| **Token boundaries** | ✅ **YES — `P2`** | `FACT` — `N5` (**A7**) *"Tokenization into terms on normalized separators"*; §36 **L836** names *"tokenizer"* explicitly | ⛔ **OPEN** (**F-6**) |
| **Punctuation / separator normalization** | ✅ **YES — `P2`** | `FACT` — `N3` (**A5**); `E2` (**A30**) fixes the degenerate case authoritatively | ⛔ **OPEN** for the Devanagari separator inventory (**F-10**); ✅ Latin illustrated by `N3` + `SRCH-AC-024` |
| **Whitespace normalization** | ✅ **YES — `P2`** | `FACT` — `N2` (**A4**); tested by `SRCH-AC-024` (`Central   Library`) | ⚠ **NARROWEST limb.** ✅ Latin behaviour is illustrated **and tested**; ⛔ Devanagari word-boundary interaction is **F-6** |
| **Script detection** | ⚠ **UNKNOWN — not assignable on evidence** | `FACT` — **0** hits (**F-7**). ⛔ And `SRCHPO-2` (**E2**) forbids inventing **language** detection. ⚠⚠ *Script* detection and *language* detection are **different objects**, and ⛔ **this record does not assume the prohibition transfers** | ⛔ **OPEN** — ⭐ routed as a **question**, per §12 `SRCHAO-P2d` |
| **Query / index symmetry** | ⚠⚠ **NO — NOT `P2`'s to decide** | ⭐⭐ `FACT` — `SRCH-FR-023` (**A1**) and `SRCH-BR-008` (**A9**) are **already MUSTs**, and `SRCH-AC-050` (**A10**) already tests it. ⇒ Symmetry is a **constraint `P2` must satisfy**, ⛔ **not a choice `P2` makes** | ✅ **CLOSED as a decision** · ⚠ **OPEN as a proof obligation** — see §5 |
| **Normalized-token representation** | ⚠ **UNKNOWN** | `FACT` — **0** hits (**F-9**). ⚠ It is implied by `N5` + `SRCH-BR-008` but **stated nowhere** | ⛔ **OPEN** — ⭐ material to §6's unit question |

⭐ `ANALYSIS` — **The eighth row is the one most likely to be mis-recorded, and it cuts the other way from the
rest.** Symmetry looks like a `P2` design choice and is not: it is a pre-existing MUST with a pre-existing
acceptance criterion. Recording it as a `P2` *decision* would have offered the Architecture Owner a choice the
repository has already removed — and, worse, would have implied that asymmetry is selectable. It is not:
*"⛔ An asymmetric rule **MUST NOT** be introduced"*.

---

## 4. `P2` status — consolidated

`FACT` + `ANALYSIS` — ⛔ **`P2` STATUS = BLOCKED.**

| Limb | Status | Blocking reason |
|---|---|---|
| `P2-A` analyzer configuration **source** | ⛔ **OPEN** | No library/configuration authority (**F-11**); `RECO` exists for the *location*, ⛔ unapproved |
| `P2-B` Devanagari case folding | ⛔ **BLOCKED** | Depends on **F-5** and `P2-D`; ⚠ and the question may be malformed (§9) |
| `P2-C` `ZWJ`/`ZWNJ` policy | ⛔ **OPEN** | **F-3**; depends on `P2-D` |
| `P2-D` script-aware vs uniform | ⛔ **BLOCKED** | ⭐⭐ **F-5** — `SRCH-FR-024`'s applicability predicate has **no** stated input anywhere in the repository |
| `P2-U` counting / measurement unit | ⛔ **BLOCKED** | **F-2** — see §6 |

⚠ `ANALYSIS` — **Why `BLOCKED` and not merely `OPEN`, and why the distinction is not pedantry.** An `OPEN`
decision can be taken by its owner today from the evidence on hand. A `BLOCKED` decision cannot, because a
**prerequisite input does not exist**. `P2-D` and `P2-U` are blocked in that stronger sense: `P2-D` asks whether
rules may differ by script, but `SRCH-FR-024` already conditions every rule on *"the field's **declared** script"*
and **no field declares one** — so the Architecture Owner would be choosing between two models while the
predicate that distinguishes them is undefined. ⇒ `P2` **as a whole** is `BLOCKED`, and the blocking item is
**F-5**, which is *smaller and more tractable* than the analyzer question everyone expected to be the blocker.

---

## 5. Phase 3 — the `SRCH-BR-008` symmetry check, rule by rule

`FACT` — The obligation under test, verbatim (**L427-429**):

> `SRCH-BR-008` — ⭐ Normalization **MUST** be symmetric and total: any transformation applied to a query term
> **MUST** have been applied to the indexed term, and vice versa. ⛔ An asymmetric rule **MUST NOT** be
> introduced, because it silently makes some indexed documents permanently unreachable.

`FACT` — And the criterion that tests it, verbatim (**L1172-1174**):

> `SRCH-AC-050` *(`SRCH-BR-008`)* — **Given** the normalization rule set, **when each rule is checked for
> symmetry**, **then** every transformation applied to a query term is also applied to indexed terms, and no
> indexed document is unreachable through its own indexed value.

### 5.1 The pipeline both sides must share

`FACT` — `SRCH-FR-023` (**A1**) requires the **same declared rule set** at index time and query time.

| Side | Required chain |
|---|---|
| **INDEX** | raw indexed value → `N1`…`N6` → tokens |
| **QUERY** | raw query → **same** `N1`…`N6` → **same** token semantics |

### 5.2 ⭐⭐⭐ THE DECISIVE FINDING — the applicability predicate is not symmetric-by-construction

`FACT` — `SRCH-FR-024`'s preamble (**L416**), quoted exactly:

> `SRCH-FR-024` — Normalization **MUST**, **where compatible with the field's declared script and language
> scope**:

`FACT` — Repository-wide measurement: `grep -rniE "declared script|script of the field|per-field script|field script" docs/`
returns **only** (a) **L416** itself, and (b) two `PRD-015_PO_DECISION_RESOLUTION_RECORD` lines (**L101**, **L434**)
that discuss *"the declared scripts"* as a **gap**, not a declaration. ⛔ **No field, anywhere in the repository,
declares a script.**

`FACT` — What fields **do** declare: `SRCH-FR-018` (**A16**, **L375-376**) — *"Each eligible field **MUST**
declare its match role: **text** … **exact** … or **filter**"*. `FACT` — `SRCH-FR-017` (**L373-374**) names the
owning contract as **§14A.4 / §14A.5** of the **FROZEN** `Library_PRD_v1.md`. `FACT` — A sweep of
`Library_PRD_v1.md` for *script* returns **6 hits, none of them a field-script declaration** (they are
*"descriptive"*, a `LXC-7` ownership row, and public-field lists). ⛔ **§14A declares no script for any field.**

⭐⭐⭐ `ANALYSIS` — **This breaks the symmetry proof in a specific and previously unrecorded way, and it is
structurally identical to a defect the repository has already ruled on once.**

The index side has a *field*. The query side has **no field** — a user types a query string, and matching is
then attempted across every eligible field. So:

| | Index side | Query side |
|---|---|---|
| Does a *field* exist to carry a declared script? | ⚠ **Yes** — but **§14A declares none** (**F-5**) | ⛔ **No.** A raw query string has **no field** at all |
| Can `SRCH-FR-024`'s condition *"where compatible with the field's declared script"* be evaluated? | ⛔ **No** — nothing declares it | ⛔ **No** — there is **no field** to read it from |

⇒ ⛔ **The applicability predicate of every one of `N1`–`N6` is undefined on both sides, and undefined
*differently* on each side.** And `SRCH-BR-008` requires symmetry of *"any transformation **applied**"* — which
presupposes a determinate answer to *"is this rule applied here?"*.

⚠ `ANALYSIS` — ⭐ **This is not an argument that the requirement is defective.** `SRCH-FR-024` is a *behavioural*
MUST and is sound as such; §16 **L434-436** already discloses that the script inventory is `SRCH-GAP-007`. The
finding is narrower and it is about `P2`: **the parameter `P2` cannot be configured until the predicate has a
defined input**, because a rule set whose applicability is undetermined cannot be shown **total**.

⭐ `ANALYSIS` — **Precedent, cited rather than invented.** `SRCH-FR-035` layer 2 faced the same shape of problem —
it requires *"the owning contract's declared field order"*, and §14A declares none. The subject did **not**
invent an order; it recorded **`SRCH-GAP-009`**, owner **Product Owner**, and stated that *"ordering degrades
gracefully to tier + stable tiebreak, which remains deterministic and total"* (**L582-591**). ⚠⚠ **The `N1`–`N6`
case admits no equivalent graceful degradation**, and that difference is the point: an undeclared *field order*
leaves ordering deterministic, whereas an undeclared *script* leaves **whether a rule fires at all** undetermined —
and `SRCH-BR-008` is a **totality** obligation, not an ordering preference.

### 5.3 Per-rule symmetry check — six properties each

⚠ **Legend.** **Enumerable** = the rule can be listed as a discrete, readable item. **Deterministic** = same
input always yields same output. **Total** = defined for **every** input in the V1 script set. **Symmetric** =
identically applied index-side and query-side. **Testable** = an acceptance criterion can check it *as an
individual rule*, per `SRCH-AC-050`. **Both sides** = applicable index-side **and** query-side.

| Rule | Enumerable | Deterministic | Total | Symmetric | Testable | Both sides | Verdict |
|---|---|---|---|---|---|---|---|
| **`N1`** case folding | ✅ | ⚠ **Latin ✅ / Devanagari UNDEFINED** — unicameral (**B2**) | ⛔ **NO** | ⚠ **UNPROVABLE** — cannot show a rule is symmetric while its Devanagari behaviour is undefined | ⛔ **NO** — `SRCH-AC-024` (**A12**) tests **Latin only**; no Devanagari case exists | ✅ | ⛔ **FAILS** |
| **`N2`** whitespace collapse | ✅ | ✅ | ⚠ **PROBABLE, not proven** — no whitespace inventory is declared; ⛔ this record does **not** supply one | ✅ | ✅ `SRCH-AC-024` (`Central   Library`) | ✅ | ⚠ **CONDITIONAL** — the narrowest failure |
| **`N3`** punctuation / separator | ✅ | ⚠ Latin ✅; ⛔ Devanagari separator inventory absent (**F-10**) | ⛔ **NO** | ⚠ **UNPROVABLE** | ⚠ Latin only (`St Marys`) | ✅ | ⛔ **FAILS** |
| **`N4`** Unicode canonical + diacritic folding | ⚠ **NOT YET** — *"canonical"* names **no form** (**F-1**) | ⛔ **NO** — `NFC` and `NFD` produce **different** outputs; ⛔ un-named ⇒ un-determined | ⛔ **NO** | ⛔ **NO** — ⭐⭐ if index side and query side resolve *"canonical"* differently, symmetry breaks **silently**, which is precisely `SRCH-BR-008`'s stated failure mode | ⚠ Latin only (`Cafe`/`Café`) | ✅ | ⛔ **FAILS — most severely** |
| **`N5`** tokenization | ⚠ **NOT YET** — algorithm *"deliberately not defined"* (**A28**) | ⛔ **NO** | ⛔ **NO** — ⛔ Devanagari word boundaries *"are **not** identical to Latin whitespace rules"* (**B5**) | ⚠ **UNPROVABLE** | ⚠ Latin only | ✅ | ⛔ **FAILS** |
| **`N6`** zero-width / control / formatting removal | ✅ | ⚠ **Direction is fixed** by `E6` (**A31**); ⛔ the **`ZWJ`/`ZWNJ` exception question is open** (**F-3**) | ⛔ **NO** | ⚠ **Symmetric as written** — ⭐ but see §8: symmetric removal can still be **semantically destructive** | ⛔ **NO** — no `ZWJ`/`ZWNJ` criterion exists | ✅ | ⛔ **FAILS** |

### 5.4 Phase 3 verdict

`FACT` + `ANALYSIS` — ⛔ **`P2` is BLOCKED under Phase 3's own stated rule** (*"If any rule cannot satisfy this,
mark `P2` BLOCKED"*). **5 of 6 rules FAIL; 1 is CONDITIONAL; 0 pass unconditionally.**

⚠ **Three disciplines observed in reaching that verdict:**

1. ⛔ **No engine default was used to rescue any rule.** The instruction *"Do NOT solve the problem by silently
   relying on engine defaults"* is the reason `N4` is marked **FAILS** rather than *"NFC, as is conventional"*.
   ⭐ **`NFC` is the near-universal default in search engines — and that is exactly why it must not be written
   here.** A convention is not a repository authority.
2. ⛔ **No rule was rewritten.** `N6` is reported as it stands. §8 analyses its interaction; ⛔ it does not
   change it.
3. ⭐ **`SRCH-AC-050` is currently UNSATISFIABLE, and that is a stronger statement than "`P2` is undecided".**
   The criterion iterates rules and checks each for symmetry. Five rules have undefined behaviour over half the
   V1 script set, so the iteration **cannot complete**. ⇒ ⛔ **`SRCH-AC-050` cannot pass today** — not because
   normalization is wrong, but because the rule set it iterates is not yet fully declared. Routed to QA in §11.

---

## 6. Phase 4 — the counting unit

⚠ **This phase exists because `P2` is a REQUIRED prerequisite of `P4`.** It asks one question only: does the
repository define the **unit** in which a normalized length is counted?

### 6.1 Candidates, each tested against measured evidence

| Candidate unit | Repository authority? | Measurement |
|---|---|---|
| **Unicode code point** | ⛔ **NONE** | `grep -rniE "code ?point" docs/ tool/ lib/` → **0 hits** outside `PRD-015_*` analysis records |
| **Unicode scalar value** | ⛔ **NONE** | `grep -rniE "scalar value"` → ⛔ **0 hits repository-wide** |
| **UTF-16 code unit** | ⛔ **NONE** | `grep -rniE "UTF-?16│code unit"` → ⛔ **0 hits repository-wide** |
| **Grapheme cluster** | ⛔ **NONE** | `grep -rniE "grapheme│extended grapheme"` → **0 hits** outside `PRD-015_*` |
| **Normalized token character** | ⛔ **NONE** | ⛔ **F-9** — normalized-token representation is stated nowhere |
| **Normalized token unit** | ⛔ **NONE** | ⛔ **F-9** |
| **Bare *"character"*, as used elsewhere** | ⚠ **USED, NEVER DEFINED** | `FACT` — `Library_PRD_v1.md` **L212** Library Name *"2–120 characters"*; `SCFG-1` **L1335** username *"3–30"* with *"Lower bound SHALL NOT go below 3"*; `SCFG-6` **L1340** bio *"300"*; `IT-3` **L47** *"8 characters"*. ⛔ **Not one of them defines *character***, and ⛔ **not one is a search authority** (**D9**) |

### 6.2 ⛔ STATEMENT REQUIRED BY PHASE 4

> ## ⛔ **No authoritative `P2` counting unit exists.**
>
> `FACT` — Measured, not inferred: the repository contains **zero** occurrences of *code point*, *scalar value*,
> *UTF-16*, *code unit* or *grapheme* outside the `PRD-015_*` analysis records that raised the question. `N4`
> (**A6**) says *"Unicode **canonical** normalization"* and names **no form**; `N5` (**A7**) says
> *"**Tokenization** into terms"* and defines **no token unit**; **F-9** records that the normalized-token
> representation is stated nowhere.
>
> ⛔ **No unit is invented by this record.**

### 6.3 ⛔ Consequence for `P4` — stated as Phase 4 requires

> ## ⛔ **`P4` remains blocked because its numeric value cannot be interpreted unambiguously.**
>
> `FACT` — `SRCH-FR-030` (**L520-522**) requires prefix matching; `SRCH-AC-030` (**L1103-1105**) tests it with
> `Lib` → *Library*; ⛔ **neither fixes a length.** `SRCHPO-6` (**L75**) approves the **behaviour** and
> ⛔ *"**No numeric prefix length invented**"*.
>
> `FACT` — `SRCHPO-1` (**A24**) makes **Devanagari** a V1 canonical script, and packet **L196** (**B9**) records
> that *"Devanagari's **matra** marks are separate code points, so a single visual \"letter\" may be **2–3 code
> points**"* — so ⛔ **the same integer denotes a different amount of user-visible text in each of the two V1
> scripts**, depending on which unit is meant.
>
> ⚠ `ANALYSIS` — ⭐⭐ **And a second, sharper reason that is specific to `P2` and is stronger than the unit
> ambiguity alone:** a prefix minimum is counted over a **normalized token**, and per §5 the normalization that
> produces that token is **not yet total** — `N4`'s form is un-named and `N5`'s tokenizer is undefined. ⇒ Even
> if a unit *were* named, the **object being measured** would still be undetermined. ⛔ `P4` is therefore blocked
> **twice over**: no unit (**F-2**) **and** no determinate token (**F-1**, **F-6**, **F-9**).
>
> ⛔ **No `P4` value is decided.** ⛔ **No `P4` value is recommended.** ⛔ **The integers 1, 2 and 3 are not
> proposed, ranked, preferred or hinted at, and this record deliberately contains no candidate `P4` value at
> all.**

---

## 7. Phase 5 — Devanagari analysis

⚠ **Method.** Everything in this section is `ANALYSIS` or `FACT`-with-citation. ⛔ **No Unicode behaviour is
prescribed.** Where the repository has no rule, the row says so and the item is routed to §12 as **OPEN**.

### 7.1 Independent verification of the V1 script scope

| Claim under test | Verified? | Evidence |
|---|---|---|
| V1 = English/Latin **+** Hindi/Devanagari | ✅ **VERIFIED** | `FACT` — `SRCHPO-1` **L57**, verbatim: *"**V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script).** This is a **closed set** for V1"* |
| Closed set | ✅ **VERIFIED** | same line, *"closed set"* |
| Hinglish is **not** a third canonical language | ✅ **VERIFIED** | `FACT` — `SRCHPO-2` **L58**: *"supported **query behaviour** where technically validated. It is **NOT** a canonical third language"*; *"Explicitly **NOT**: a third canonical language · a separate BC · a separate index · a separate search system"* |
| *"where technically validated"* is load-bearing | ✅ **VERIFIED** | `FACT` — `SRCHPO-3` **L59**: *"An implementation that cannot validate it **MUST NOT** claim it"*, mirroring `SRCH-BR-012`'s *"an implementation that cannot satisfy them **MUST NOT** enable it"* |
| ⚠ No universal transliteration claim exists | ✅ **VERIFIED** | `FACT` — `SRCHPO-1`'s own constraint records **0** prior hits; ⛔ none is made here |
| ⚠⚠ Devanagari appears in **no** specification text | ✅ **VERIFIED** — §2.3 | `FACT` — 5 files, **all** `PRD-015` decision records; ⛔ **not** the subject, ⛔ **not** EA, BC Map, Rulings, Configuration or `MASTER_PRD` |

### 7.2 Devanagari features vs repository authority

| Feature | What it means for `N1`–`N6` | Repository authority | Status |
|---|---|---|---|
| **Consonant + vowel signs (matra)** | `FACT` (**B9**) — matras are **separate code points**; one visual letter may be **2–3 code points** ⇒ *character* counts diverge by unit | ⛔ **NONE** | ⛔ **OPEN** — feeds **F-2** |
| **Combining marks** | `ANALYSIS` — the class `N4` *"canonical normalization"* is about; ⛔ but the **form** is un-named (**F-1**) | ⛔ **NONE** on the form | ⛔ **OPEN** |
| **Nukta forms** | `FACT` (**B4**) — *"matras and nukta forms have multiple encodings"* ⇒ ⭐⭐ two byte-different strings can be the **same** word, so the `N4` form choice is **correctness-critical**, not cosmetic | ⛔ **NONE** | ⛔ **OPEN** |
| **Conjuncts** | `ANALYSIS` — formed with virama and, in some renderings, `ZWJ`/`ZWNJ` ⇒ interacts with `N6` (§8) | ⛔ **NONE** — ⚠ and §2.2: every repo *"conjunct"* hit is a **governance-gate conjunct** | ⛔ **OPEN** |
| **Halant / virama** | `ANALYSIS` — a combining code point, not a separator ⇒ ⛔ must **not** be treated as `N3` punctuation | ⛔ **NONE** | ⛔ **OPEN** |
| **`ZWJ` / `ZWNJ`** | §8 | ⛔ **NONE** (**F-3**) | ⛔ **OPEN** — `P2-C` |
| **Case** | ⭐⭐ `FACT` (**B2**) — *"Devanagari is **unicameral** — it has no case"* | ⛔ **NONE** on treatment | ⛔ **BLOCKED** — §9 |
| **Grapheme boundaries** | `ANALYSIS` — differ from code-point boundaries far more than in Latin | ⛔ **NONE** (**F-2**) | ⛔ **OPEN** |
| **Token / word boundaries** | `FACT` (**B5**) — *"⛔ Devanagari word boundaries are **not** identical to Latin whitespace rules"* | ⛔ **NONE** (**F-6**); `SRCHPO-5` records the tokenizer as *"deliberately not defined"* | ⛔ **OPEN** |
| **Separators (danda `।`, double danda `॥`)** | `FACT` (**B3**) — *"Devanagari uses the **danda** (`।`) as a separator, not a full stop"* | ⛔ **NONE** — packet **L147** is **Class B**, ⛔ not authority; **0** other hits (**F-10**) | ⛔ **OPEN** |

### 7.3 ⭐⭐ The Devanagari acceptance-coverage gap — a **new** finding

`FACT` — `SRCH-AC-024` (**A12**, **L1084-1086**) is the **only** acceptance criterion that exercises `N1`–`N6`.
Verbatim, its inputs are: `central library`, `Central   Library`, `St Marys`, `Cafe` — against *Central Library*,
*Central Library*, *St. Mary's*, *Café*.

⚠⚠ `ANALYSIS` — **All four test cases are Latin. There is no Devanagari acceptance case anywhere in
`PRD-015`** — measured: the subject contains **zero** occurrences of *Devanagari*. Yet `SRCHPO-1` makes
Devanagari a **V1 canonical script**, co-equal with Latin.

⇒ `ANALYSIS` — Half of the V1 script surface is **behaviourally required and acceptance-uncovered**. ⛔ **This
record does not author an acceptance criterion** — authoring `SRCH-AC-*` identifiers is subject-document work and
the subject is byte-frozen for this pass. It is recorded as a **traceability finding** and routed to QA (§11) and
to §12 as context. ⭐ Note the honest ordering: an acceptance criterion for Devanagari **cannot** be written
before `P2-B`, `P2-C` and `P2-D` are decided, because there would be no declared behaviour to assert. ⇒ **The
coverage gap is a *consequence* of `P2` being open, not an independent defect.**

---

## 8. Phase 6 — `ZWJ` / `ZWNJ`

### 8.1 What the repository already specifies — and what it does not

| Question | Authority | Answer |
|---|---|---|
| Are zero-width characters removed? | `FACT` — `N6` (**A8**, **L425**) | ✅ **YES** — *"Removal of zero-width, control and formatting characters"* |
| Is the **direction** settled? | ⭐ `FACT` — `E6` (**A31**, **L945**) | ✅ **YES, and unusually explicitly**: *"`N6` **removes** it — ⛔ it cannot create an unmatchable name"*. ⇒ `N6` is **removal**, ⛔ not preservation and ⛔ not canonicalisation-in-place |
| Is `U+200C` / `U+200D` named? | `FACT` — sweep | ⛔ **NO** — **0** hits outside `PRD-015_*` records (**F-3**) |
| Is any Indic exception stated? | `FACT` — sweep | ⛔ **NO** |
| Is the **matching behaviour** of a stripped `ZWJ`/`ZWNJ` stated? | `FACT` | ⛔ **NO** |
| May `P2` create an exception? | ⚠ **That is the open question** — `P2-C` | ⛔ Undecided |

### 8.2 ⭐⭐ Cross-check: `N6` against `N4` and `SRCH-BR-008`

| Pairing | `ANALYSIS` |
|---|---|
| **`N6` × `N4`** | ⚠ **Ordering is unspecified and it is outcome-determining.** `N4` performs Unicode canonical normalization; `N6` strips format characters. Whether stripping happens **before** or **after** canonical composition can change the result for sequences where a format character sits between combining marks. ⛔ **The repository states no order** — §16 presents `N1`–`N6` as a **table of rules**, ⛔ not a declared pipeline sequence. ⭐ **A new sub-question, routed as context to `SRCHAO-P2c`.** ⛔ No order is asserted here |
| **`N6` × `SRCH-BR-008`** | ⭐⭐⭐ **The critical distinction, and the one prior records did not draw.** `N6` **is** symmetric as written — strip on both sides. ⇒ ⚠ **`SRCH-BR-008` is satisfied by blanket removal.** But `SRCH-BR-008`'s stated *purpose* is that *"no indexed document is unreachable through its own indexed value"* (`SRCH-AC-050`). ⚠⚠ **Symmetric removal can still corrupt a token**: if a legitimate Devanagari name depends on a `ZWNJ` to distinguish it, symmetric stripping makes two **genuinely different** names normalize to the **same** term — which is ⛔ **not** an `SRCH-BR-008` violation but **is** a *"Two strings that normalize identically **are** the same term at the **EXACT** tier"* consequence (**A14**, **L431-433**). ⇒ ⭐ **The `ZWJ`/`ZWNJ` risk is a correctness/collision risk, ⛔ NOT a symmetry risk** |
| **`N6` × `SRCH-FR-024` preamble** | ⚠ `N6` is also conditioned on *"where compatible with the field's declared script"* (**A2**) ⇒ **F-5** blocks it too |

⭐⭐⭐ `ANALYSIS` — **The re-framing this phase contributes, stated plainly because it changes what the
Architecture Owner is being asked.** Prior records (**B6**, **B13**) framed `ZWJ`/`ZWNJ` as
*"correctness versus spoofing"* — implying a choice between removal and retention. This record narrows it:

1. `FACT` — **`E6` already settles the *direction*.** `N6` **removes**. So the owner is **not** choosing between
   removal and retention as a general policy; that has been decided.
2. `ANALYSIS` — **The real question is whether `U+200C`/`U+200D` warrant a *named exception* to a rule whose
   general direction is already fixed** — and, if so, how the exception preserves `SRCH-BR-008` symmetry while
   avoiding the spoofing surface `E6` exists to close.
3. `ANALYSIS` — ⭐ **Both limbs are symmetric, so `SRCH-BR-008` does not choose between them.** Blanket removal is
   symmetric; a symmetric named exception is also symmetric. ⇒ The deciding criteria are **collision risk** (two
   distinct Devanagari names colliding) versus **spoofing risk** (invisible characters used to forge a
   near-identical name) — and ⛔ **the repository supplies no rule for either.**

### 8.3 ⛔ What this phase does **not** do

⛔ **`N6` is not changed, narrowed, widened, reordered or reinterpreted.** It is reported exactly as written
(**L425**) and analysed against `N4` and `SRCH-BR-008`. ⛔ **No `ZWJ`/`ZWNJ` policy is proposed.** ⛔ **No
exception is drafted.** ⛔ **No pipeline order is asserted.** `P2-C` is routed to §12 as `SRCHAO-P2c`.

---

## 9. Phase 7 — case folding

### 9.1 The two scripts, separately

| Script | Authority | Status |
|---|---|---|
| **Latin** | ✅ `FACT` — `N1` (**A3**) *"Case folding — matching is **case-insensitive**"*, illustrated `central library` ≡ `Central Library` ≡ `CENTRAL LIBRARY`; ✅ `SRCHPO-4` (**A27**) *"✅ **CONFIRMED** — already a MUST"*; ✅ **tested** by `SRCH-AC-024`; ✅ illustrated again at **L465** *"N1 case folding → **T1**"* | ✅ **AUTHORITATIVE and TESTED** |
| **Devanagari** | ⛔ `FACT` — **0** authority (**F-4**). `FACT` (**B2**) — *"Devanagari is **unicameral** — it has no case"* | ⛔ **BLOCKED** |

### 9.2 ⭐⭐⭐ Is *"case folding"* being incorrectly generalized across scripts?

`ANALYSIS` — **Yes, and this record answers the phase's own question directly rather than deferring it.**

`FACT` — `N1` is written as a single unconditional row: *"Case folding — matching is **case-insensitive**"*.
`FACT` — Its preamble (**A2**) does condition it: *"where compatible with the field's declared script and
language scope"*. `FACT` — **B2**: Devanagari has no case.

⇒ ⭐ `ANALYSIS` — **`SRCH-FR-024`'s preamble already anticipates exactly this situation, and it is the reason
`N1` is not defective.** The words *"where compatible with the field's declared script"* exist precisely so that
a rule need not apply to a script it cannot apply to. ⇒ **The generalization is not in the requirement — it is in
any *configuration* that would apply `N1` uniformly.** That configuration is `P2`. ⇒ ⛔ **`P2`, not
`SRCH-FR-024`, is where the error would be committed**, which is why this is a `P2` decision.

### 9.3 ⭐⭐ The *"not applicable"* distinction — documented as Phase 7 requires

`FACT` — Preparation **L242** (**B12**), verbatim: *"Under `SRCH-AC-050`'s per-rule check these differ:
*not applicable* is an auditable declaration; a silent no-op is an **unchecked** rule. ⛔ The distinction is
invisible at runtime and only appears in review."*

`ANALYSIS` — ⭐ **The distinction is real, and this record can state *why* it is real in `SRCH-AC-050`'s own
terms.** `SRCH-AC-050` says *"**when each rule is checked** for symmetry"*. For a rule to be *checked*, its scope
of application must be **readable**. Therefore:

| Formulation | Under `SRCH-AC-050` | Under `SRCH-BR-008` totality |
|---|---|---|
| **"`N1` is declared NOT APPLICABLE to Devanagari"** | ✅ **CHECKABLE** — the reviewer reads the declaration, confirms it on both sides, and the rule is **accounted for** | ✅ **Total** — every input has a defined disposition, including *"no transformation"* |
| **"`N1` runs on Devanagari and happens to no-op"** | ⛔ **NOT CHECKABLE as a rule** — there is nothing to read; the reviewer must **infer** behaviour from a Unicode property. ⚠ And a later engine or library change could alter that behaviour **with no repository change** — the `SRCH-FR-034` (**A18**) hazard exactly | ⚠ **Total in fact, unproven in the record** |

⭐⭐ `ANALYSIS` — ⇒ **On the repository's own acceptance criterion, the two formulations are not equivalent, and
the difference is auditability rather than runtime behaviour.** ⛔ **This is still NOT a decision.** Declaring
`N1` *"not applicable"* to Devanagari is an act with consequences this record has no authority to weigh — for
example whether *"not applicable"* is the right shape at all, given that a **mixed-script field value** (a Hindi
name containing a Latin acronym) would need `N1` to apply to **part** of a value. ⚠ **That sub-question is
itself unaddressed by any authority**, and it is recorded here rather than resolved.

### 9.4 ⛔ What this phase does **not** do

⛔ **No Devanagari case-folding rule is invented.** ⛔ **`N1` is not amended.** ⛔ **It is not asserted that
*"not applicable"* is the correct answer** — only that ⭐ **if** it is the correct answer, it must be *declared*
rather than left to a silent no-op, because `SRCH-AC-050` iterates rules and an undeclared rule cannot be
iterated. The choice is `SRCHAO-P2b`, ⛔ **BLANK**.

---

## 10. Phases 8 & 10 — normalization models, and the dependency graph

### 10.1 Phase 8 — script-aware vs uniform

`FACT` — ⛔ **Does repository authority already settle the model? NO.** `SRCH-FR-024`'s preamble (**A2**)
*permits* script-conditional behaviour (*"where compatible with the field's declared script"*) but ⛔ **does not
require it**, and ⛔ **F-5** means the condition has no defined input. ⇒ The model is **not** settled.

| Criterion | **A — SCRIPT-AWARE** | **B — UNIFORM** |
|---|---|---|
| `SRCH-FR-024` **A2** | ⭐ Uses the preamble's conditional as intended | ⚠ Renders the conditional inert — ⛔ but does **not** violate it |
| `SRCH-BR-008` symmetry | ⚠ Symmetric **iff** script determination is identical on both sides — ⛔ and **F-5** means it is undefined query-side (§5.2) | ⭐ **Symmetric by construction** — no predicate to diverge |
| `SRCH-BR-008` **totality** | ⚠ Requires a **total** script-determination function ⇒ needs **F-5** and **F-7** | ⭐ Total by construction |
| `N1` × Devanagari (**B2**) | ⭐ Can declare `N1` **not applicable** — the auditable form (§9.3) | ⛔ **Must** apply `N1` to a unicameral script, i.e. the silent no-op |
| `N5` × Devanagari (**B5**) | ⭐ Can honour non-Latin word boundaries | ⚠ Latin whitespace rules on Devanagari — ⛔ *"not identical"* |
| `N3` × danda (**B3**) | ⭐ Can treat `।` as a separator | ⚠ ⛔ danda is not Latin punctuation |
| **Determinism** (`SRCH-FR-034`) | ⚠ Deterministic **iff** script determination is deterministic | ⭐ Trivially deterministic |
| **QA testability** (`SRCH-AC-050`) | ⚠ **2× the rule surface** to enumerate and check | ⭐ Smallest checkable surface |
| ⭐⭐ **`P4` dependency** | ⚠⚠ **If rules differ by script, a *single* `P4` integer may not mean the same amount of text in each script** (**B9**) — and `SRCH-BR-012` **C3** requires the tolerance bound *"**bounded and uniform across consumers**"*. ⚠ Whether *uniform across consumers* is even the same test as *uniform across scripts* is ⛔ **undetermined** | ⭐ One unit, one meaning — ⚠ **but** per **B9** an identical integer is **still** not equally strict across the two scripts, because matras are multi-code-point. ⇒ ⛔ **Model B does NOT dissolve the `P4` unit problem** |
| **Extensibility** | ⭐ A third script is additive | ⚠ A third script may force a model change |
| **Security / privacy** | ⚠ Script determination is **attacker-influenced input** — a mixed-script value could steer which rules fire | ⭐ No steerable predicate |

⭐⭐ `ANALYSIS` — **Two findings that cut against the intuitive reading, recorded because both are easy to get
backwards:**

1. **Model B (uniform) does *not* solve `P4`.** It is tempting to conclude that one pipeline ⇒ one unit ⇒ `P4`
   becomes decidable. ⛔ **False.** **B9**'s multi-code-point matra observation is a property of **Devanagari**,
   ⛔ not of the pipeline. A uniform pipeline still counts `2`-of-something differently in the two scripts.
   ⇒ ⛔ **Neither model unblocks `P4` by itself; only a declared *unit* does** (§6).
2. **Model A is *not* automatically the more correct choice**, despite winning five behavioural rows. It
   **imports a new total-function requirement** — script determination — that the repository does not have
   (**F-5**, **F-7**), and that is *itself* a symmetry hazard (§5.2). ⇒ ⭐ **Model A trades known
   under-specification for a new, unowned mechanism**, and that trade is an Architecture Owner call.

`RECO` — ⚠ **Recommendation, and it is deliberately narrower than a model choice.** ⛔ **Neither model is
recommended.** ⭐ What is recommended is that **F-5 be resolved first** — i.e. that the Architecture Owner
establish, with the **Product Owner** where the field contract is a §14A product statement, *whether a field has
a declared script and who declares it*. ⭐ **`P2-D` is not decidable before that**, because both models are
defined in terms of that predicate. ⛔ **This is not an approval.**

### 10.2 Phase 10 — dependency graph

⚠ **Vocabulary: `REQUIRED` · `OPTIONAL` · `NO DEPENDENCY` · `UNKNOWN` only.**

| Relationship | Verdict | Evidence |
|---|---|---|
| `P2` → **`P1`** (engine/index technology) | **OPTIONAL** | ⭐ `FACT` — preparation **§5.2** (**B11**): the `SRCH-AC-050` argument *"**de-couples `P2` from `P1`**"* — the rule set can be declared before an engine exists. ⚠ **But** packet **§5.3** item 1 gates the *configuration* on `P1`. ⇒ **Declaration limb: `NO DEPENDENCY`. Executor-binding limb: `OPTIONAL`** |
| `P2` → **`P3`** (edit distance + min token length) | **NO DEPENDENCY** *(`P2` does not depend on `P3`)* | `FACT` — `SRCH-BR-012` **C2**/**C3** are tolerance bounds; ⛔ nothing in `N1`–`N6` consumes them. ⚠⚠ **The converse is a different question and is answered next** |
| **`P3` → `P2`** | ⚠⚠ **REQUIRED** — ⭐ **a finding, and it is symmetrical with `P4`** | `FACT` — `SRCH-BR-012` **C2** bounds tolerance by *"a declared **minimum token length**"*; a *token* is `N5`'s output (**A7**) and its length needs §6's **absent** unit. ⇒ ⛔ **`P3` is blocked by `P2` for the same two reasons `P4` is.** ⚠ **This record does not decide `P3`** — it is out of scope — ⭐ but the dependency is recorded because leaving it unstated would imply `P3` is independently decidable when it is not |
| ⭐⭐⭐ `P2` → **`P4`** | see below | independently verified in §10.3 |
| `P2` → **`P5`** (max page size) | **NO DEPENDENCY** | `FACT` — `LCFG-12` = **20**, range 5–50, owner **Security**; a result-count cap, ⛔ unrelated to text processing |
| `P2` → **`P6`** (projection lag) | **NO DEPENDENCY** | `FACT` — `LCFG-6` = **60 s**, *"Removal latency only"*; a temporal property |
| `P2` → **`P7`** (latency / throughput / availability) | **UNKNOWN** | `FACT` — **L826-827**: ⛔ no latency budget, throughput target, index-size limit, freshness SLO or availability target exists for `BC-23`. ⚠ `ANALYSIS` — normalization cost plainly *affects* latency, ⛔ but with **no** `P7` target there is nothing to depend on. ⇒ **`UNKNOWN`, ⛔ not `NO DEPENDENCY`** |
| `P2` → **`P8`** (rebuild posture) | ⚠ **OPTIONAL** | `ANALYSIS` — a change to a **declared** rule set implies a **reindex** to preserve `SRCH-FR-023` index/query identity. ⛔ **No repository authority states this**, so it is not `REQUIRED`. ⭐ Recorded as an `OPEN` consequence the owner should see, ⛔ not as an inherited dependency |
| `P2` → **`ENT`** (entitlement evaluation) | **NO DEPENDENCY** | `FACT` — `SRCH-GAP-003` (**L981**) asks for an **authorisation-evaluation mechanism**; ⛔ normalization has no authorisation limb. ⚠ **And a related hazard is separately barred**: `SRCH-BR-012` **C5** — tolerance *"never widens authorisation, tenant scope or field eligibility"* |
| `P2` → **`VOC`** (declared variant/abbreviation vocabulary, §20 V4) | ⚠ **OPTIONAL** | ⭐ `FACT` — **L551-553**: the vocabulary is `SRCH-GAP-007`, owner **Product Owner**; `SRCH-BR-011` (**A13**) requires it be **declared**. `ANALYSIS` — `VOC` operates on **normalized tokens**, so it consumes `P2`'s output ⇒ ⚠ **`VOC` → `P2` is the stronger direction**. ⛔ But §20 **V4** is out of V1 scope, so it is `OPTIONAL`, ⛔ not `REQUIRED` |
| `P2` → **`R1`** (tenant data reaching the public index) | **NO DEPENDENCY** | `FACT` — **L960**: mitigated by `SRCH-INV-004`, `SRCH-INV-002`, `SRCH-FR-006`, `T-J` — ⛔ **`P2` is named in none of them.** ⭐ ⚠ **Counter-intuitive but correct**: normalization changes *matching*, ⛔ never *which documents are present* |
| `P2` → **`R2`** (index as silent authorisation bypass) | **NO DEPENDENCY** | `FACT` — **L961**: mitigated by §27 query-time re-evaluation, `SRCH-FR-040`, `SRCH-FR-012`–`014`; residual is `SRCH-GAP-003`. ⛔ `P2` is named in none |
| ⭐ `P2` → **`R7`** *(not requested; recorded because it is the only risk row naming `P2`)* | ⚠ **REQUIRED — in the reverse direction** | ⭐⭐ `FACT` — **L965**, verbatim: *"Cross-tenant leakage through relevance statistics… Residual: **Depends on `P2` honouring §22**"*. ⇒ ⛔ **`R7` depends on `P2`**, not the converse. ⚠ Routed to Security (§11) |

### 10.3 ⭐⭐⭐ Independent verification of `P2` → `P4` = REQUIRED

⚠ **The prior `P4` record's conclusion is NOT inherited.** It is re-derived from primary sources.

| Step | Primary evidence | Conclusion |
|---|---|---|
| 1 | `FACT` — §36 **L839**: `P4` = *"Minimum prefix length for partial matching"*, required to exist by **`SRCH-FR-030`** | `P4` is a **length** |
| 2 | `FACT` — `SRCH-FR-030` (**L520-522**): *"A query **token MUST** be able to match an indexed **token** by **prefix**"* | The length is measured over a **token** |
| 3 | `FACT` — `N5` (**A7**, **L424**): *"**Tokenization** into terms on normalized separators"*; §36 **L836** assigns tokenization to **`P2`** | ⇒ ⭐ **The token `P4` measures is *produced by* `P2`** |
| 4 | `FACT` — §6: ⛔ **no** counting unit exists anywhere | ⇒ The length has **no unit** |
| 5 | `FACT` — **B9**: Devanagari matras are multi-code-point, and `SRCHPO-1` makes Devanagari **V1-canonical** | ⇒ The **unit choice changes the meaning** of any `P4` integer |
| 6 | `FACT` — §5: `N4`'s form is un-named and `N5`'s tokenizer undefined ⇒ the token is **not determinate** | ⇒ ⭐ Even **with** a unit, the **object measured** is undefined |

> ## ⭐⭐⭐ **`P2` → `P4` = REQUIRED — INDEPENDENTLY VERIFIED**
>
> `P4` is a length over a **normalized token**. Both the **token** (`N5`, `P2`) and the **unit** in which its
> length is counted (§6, `P2`) are `P2`'s outputs. ⇒ ⛔ **`P4` cannot be assigned a meaningful value before `P2`
> defines them.** ⭐ Verified from `SRCH-FR-030` + `N5` + §36 + `SRCHPO-1` directly, ⛔ **not** by citing the
> prior record's conclusion.

⚠ **This dependency is NOT propagated automatically.** `P5`, `P6`, `ENT`, `R1` and `R2` are `NO DEPENDENCY` on
measured evidence above; `P7` is `UNKNOWN`; `P1`, `P8` and `VOC` are `OPTIONAL`. ⭐ **`P3` → `P2` = `REQUIRED`
was derived on its own evidence** (`SRCH-BR-012` **C2**'s *"minimum token length"*), ⛔ **not** by analogy to `P4`.

---

## 11. Phase 9 — five-expert review

⚠ Each review is independent, states its own evidence, and reaches its **own** verdict.

### 11.1 PRODUCT

| Question | Finding |
|---|---|
| Does `P2` alter user-visible search behaviour? | ⚠ **YES — materially.** `ANALYSIS` — `P2` decides whether `Café`/`Cafe` match, whether two Devanagari spellings match, and how a name tokenizes. `FACT` — **A14** (**L431-433**): *"Two strings that normalize identically **are** the same term at the **EXACT** tier"* ⇒ ⭐ `P2` reaches **T1 exact** matching, ⛔ not merely tolerant matching |
| Does `P2` alter the approved V1 language scope? | ⛔ **NO — and it must not.** `FACT` — `SRCHPO-1` is a **closed set**; `P2` configures **how** those two scripts are handled, ⛔ never **which** |
| Does it accidentally expand language support? | ⚠ **ONE ROUTE, and it must be watched.** `ANALYSIS` — a *uniform* pipeline (Model B) would process **any** script's input without error, which could be **mistaken** for support for a third script. ⛔ **Processing without error is not support** — `SRCHPO-1`'s closed set governs and `SRCHPO-3` supplies the discipline: *"An implementation that cannot validate it **MUST NOT** claim it"* |
| Hinglish | ⚠ **Unchanged and unexpanded.** `FACT` — `SRCHPO-2`/`3`: permitted, **not required**; ⛔ no transliteration rule proposed here (**E2**) |
| **VERDICT** | ⛔ **BLOCKED on Product co-input.** ⭐ **F-5** is not purely architectural: `SRCH-FR-017` (**L373-374**) names **§14A.4/§14A.5** of the **FROZEN** `Library_PRD_v1.md` as the field contract, and `SRCH-XC-001` (**E5**) bars `BC-23` from defining §14A fields. ⇒ **If a field's script must be declared, the declaration may have to come from a §14A product statement** — exactly the shape of `SRCH-GAP-009`. ⛔ Not resolved here |

### 11.2 ENTERPRISE / DOMAIN

| Question | Finding |
|---|---|
| Who owns analyzer / normalization authority? | ✅ **UNAMBIGUOUS.** `FACT` — §36 **L844** *"Owner: Architecture Owner"*; `SRCH-GAP-002` **L980** *"analyzer config"*; `SRCH-GAP-007` **L985** *"+ **Architecture Owner** (analyzer)"*; `SRCH-GAP-004` **L982** *"Architecture Owner (analyzer)"*; BC Map **L132** places it in **`BC-23`** |
| Would creating a new authority duplicate an existing owner? | ⚠⚠ **YES — and that is the trap this phase exists to catch.** ⛔ **No new authority, register, gap, `ADR` or owner is created by this record.** `P2` **already** has an owner and an open gap; a new one would fragment it |
| Is `BC-25` Configuration a candidate owner? | ⛔ **NO.** `FACT` — BC Map **L134**: `BC-25` owns *"settings hierarchy, feature flags, branding values, secret **references**"*. `FACT` — `PRD_REGISTRY.md` **L414**: *"**`BC-25` Configuration has no registered claimant**"*. `FACT` — `CONFIGURATION_GUIDE.md` contains **0** `SRCH-*` identifiers. ⇒ ⛔ `LCFG-2` is **Class D** (**D1**) |
| Rank discipline | ✅ `FACT` — EA is **Rank 6, descriptive**; `ADR-0046` §9 (**L255-258**): a Rank-6 line is *"corroboration, not grounds"*. ⇒ ⛔ EA **L1524**/**L1546** cannot supply `P2` |
| Module manifest | ✅ `FACT` — `tool/module_dependencies.yaml` **L373-384**: `platform/search`, rank 5, `imports: [contracts]`, assertions `SE-1`, `SE-2`. ⛔ **No normalization parameter is expressible there** |
| **VERDICT** | ✅ **CLEAR on ownership** · ⛔ **BLOCKED on content.** ⚠ **One boundary caution:** `P2` is `BC-23`'s, but **F-5**'s answer may live in a **§14A product statement** ⇒ a **joint** act, per 11.1 |

### 11.3 SEARCH ENGINEERING

| Question | Finding |
|---|---|
| Index/query symmetry | ⛔ **NOT PROVABLE TODAY** — §5.2: the applicability predicate is undefined, and **differently** undefined on each side |
| Tokenization | ⛔ **UNDEFINED** — `SRCHPO-5`: *"deliberately **not** defined"*; **B5**: Devanagari boundaries *"not identical"* |
| Unicode behaviour | ⛔ **UNDEFINED** — `N4` says *"canonical"* and names ⛔ **no form**; **B4**: *"**NFC vs NFD matters more for Devanagari than for Latin**"* |
| ⚠ Was any engine default used? | ⛔ **NO.** ⭐ **Stated explicitly because it was the single largest temptation in this pass:** `NFC` is what virtually every search engine and text-processing library applies. ⛔ **It is not written as the answer**, because the instruction bars solving the problem by silently relying on engine defaults, and *"a technology commonly uses it"* is **not** repository authority |
| `P4` readiness | ⛔ **NOT READY** — blocked twice over (§6.3): no unit **and** no determinate token |
| ⭐ Anything **new** found here? | ⚠ **YES — two.** (1) §8.2: the `N6`×`N4` **ordering** is unspecified and outcome-determining — §16 is a *table*, ⛔ not a declared pipeline sequence. (2) §5.2: the query side **has no field at all**, so the *"field's declared script"* predicate is not merely unpopulated query-side — it is **inapplicable** there |
| **VERDICT** | ⛔ **CANNOT CLEAR.** ⛔ **0 values, 0 forms, 0 units, 0 algorithms produced** |

### 11.4 SECURITY / PRIVACY

| Risk | Finding |
|---|---|
| **Cross-tenant leakage** | ⭐⭐ **ONE REAL AND ALREADY-RECORDED EXPOSURE.** `FACT` — `R7` (**L965**): *"Cross-tenant leakage through relevance statistics… **Depends on `P2` honouring §22**"*. ⇒ **`P2` is named in a risk residual**, and any `P2` design using corpus-wide statistics could leak across tenants. ⛔ `SRCH-FR-035` (**A34**) already forbids a numeric score, which constrains the surface — ⚠ **but the `R7` residual stands as written** |
| **Identifier collisions** | ⚠⚠ **THE SHARPEST SECURITY FINDING, and it is `P2`-specific.** `FACT` — **A14** (**L431-433**): normalization reaches the **EXACT** tier; `FACT` — `SRCH-FR-018` (**A16**) defines *exact* as identifier-like; `FACT` — `SRCH-FR-027` (**L492-494**) restricts exact fields to *"exact or by prefix only"*. ⇒ ⭐ **An over-aggressive `P2` rule can make two *distinct identifiers* normalize to the **same** term** — and §8.2 shows blanket `ZWJ`/`ZWNJ` stripping is exactly such a rule for Devanagari. ⚠ **`SRCH-BR-008` does NOT catch this**, because symmetric collision is still symmetric |
| **Enumeration risk** | ⛔ **NOT MATERIALLY CHANGED by `P2`.** ⚠ Interacts with `SRCH-GAP-008` (**L770**) query-volume abuse — ⛔ *"**No owner exists**"*. ⭐ ⚠ **And a `P4` interaction is flagged rather than decided:** a shorter prefix minimum enlarges the enumeration surface. ⛔ **This is NOT a reason to prefer any `P4` value and no value is preferred** |
| **Authorization bypass** | ⛔ **NO ROUTE.** `FACT` — `SRCH-BR-012` **C5**: never widens authorisation, tenant scope or field eligibility; `SRCH-INV-006` (**A35**): an ineligible field is *"not indexed, not matchable, and not returnable"*; §27 re-evaluates at query time |
| **Privacy / removal consistency** | ⚠ **ONE CONSEQUENCE, recorded not decided.** `ANALYSIS` — `SRCH-FR-023` requires index-time and query-time normalization to be **identical**; a later `P2` change therefore implies a **reindex**, or old and new normalized forms coexist. ⛔ **No authority states a rebuild trigger** ⇒ recorded as the `P8` `OPTIONAL` link (§10.2) |
| **Spoofing** | ⚠ **OPEN — `P2-C`.** `FACT` — `E6` (**A31**) exists to stop invisible characters creating a distinct name; ⭐ a `ZWJ`/`ZWNJ` **exception** would partially reopen that surface (§8.2). ⛔ No policy proposed |
| **VERDICT** | ⛔ **BLOCKED.** ⭐ **Security is a NAMED CO-OWNER of `P2-C`** (packet **L150**; preparation **L243**), and `R7` makes Security an interested party in `P2-A` as well |

### 11.5 QA / TRACEABILITY

| Property | Finding |
|---|---|
| Enumerable | ⚠ **4 of 6.** `N1`, `N2`, `N3`, `N6` are enumerable as written; `N4` (form un-named) and `N5` (algorithm undefined) are ⛔ **not yet** |
| Deterministic | ⚠ **2 of 6** unconditionally (`N2`; `N6`'s direction). ⛔ 4 depend on **F-1**/**F-6**/**F-4** |
| **Total** | ⛔ **0 of 6 proven.** All six are conditioned on *"the field's declared script"* (**A2**), which ⛔ nothing declares (**F-5**) |
| Testable | ⚠ **Latin only.** `FACT` — `SRCH-AC-024` (**A12**) has **4 cases, all Latin**; ⛔ **0** Devanagari cases exist in the subject (§7.3) |
| Traceable to a requirement | ✅ **6 of 6** — every rule traces to `SRCH-FR-024`, tested by `SRCH-AC-024`; `SRCH-FR-023` → `SRCH-AC-023`; `SRCH-BR-008` → `SRCH-AC-050` |
| ⭐⭐⭐ **Can `SRCH-AC-050` be satisfied?** | ⛔ **NO — NOT TODAY.** `FACT` — it requires *"**when each rule is checked** for symmetry"*. §5.3: **5 of 6** rules have undefined behaviour over half the V1 script set ⇒ ⛔ **the per-rule iteration cannot complete.** ⭐ **`SRCH-AC-050` is currently UNSATISFIABLE**, and this is the single most consequential QA finding in this record |
| ⭐ Coverage finding | ⚠ **`SRCH-AC-024` is Latin-only while `SRCHPO-1` makes Devanagari V1-canonical** (§7.3). ⛔ **No `SRCH-AC-*` is authored here** — the subject is byte-frozen for this pass, and ⭐ a Devanagari criterion **cannot** be written before `P2-B`/`P2-C`/`P2-D` are decided |
| ⚠ Validator limitation | ⛔ **DISCLOSED, NOT FABRICATED.** `FACT` — no `prd015_*` validator exists in `tool/docs_check/` (32 entries, 0 matches); `alignment_record_freshness.py` `RECORDS` (**L78-88**) covers only `PRD-008`/`PRD-019`. ⇒ `PRD-015` is **not covered**; §14's checks are **manual** |
| **VERDICT** | ⛔ **BLOCKED.** ⭐ **QA is the phase that converts `P2` from *"undecided"* to *"BLOCKING an existing acceptance criterion"*** |

### 11.6 Five-expert tally

| Expert | Verdict | Produced a rule, form, unit or value? |
|---|---|---|
| **Product** | ⛔ **BLOCKED on Product co-input** (**F-5** may need §14A) | ⛔ **NO** |
| **Enterprise / Domain** | ✅ **CLEAR on ownership** · ⛔ **BLOCKED on content**; ⛔ no new authority created | ⛔ **NO** |
| **Search Engineering** | ⛔ **CANNOT CLEAR** | ⛔ **NO** |
| **Security / Privacy** | ⛔ **BLOCKED**; co-owner of `P2-C`; `R7` names `P2` | ⛔ **NO** |
| **QA / Traceability** | ⛔ **BLOCKED**; ⭐ **`SRCH-AC-050` UNSATISFIABLE** | ⛔ **NO** |

⛔ **5 of 5 BLOCKED or CANNOT CLEAR. 0 of 5 produced a normalization rule, Unicode form, counting unit or `P4`
value.**
