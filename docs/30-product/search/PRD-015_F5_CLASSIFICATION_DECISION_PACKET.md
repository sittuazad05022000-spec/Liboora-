# PRD-015 — F-5 ARCHITECTURE OWNER CLASSIFICATION DECISION PACKET

| Field | Value |
|---|---|
| **Document** | `PRD-015` `F-5` Architecture Owner **classification decision packet** |
| **Subject** | `docs/30-product/search/PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` |
| **Scope** | ⭐ **ONE question only** — is the *declared script* required by `SRCH-FR-024` an **ANALYZER property** (`P2`, Architecture Owner) or a **§14A FIELD-SCHEMA property** (Product Owner)? |
| **Type** | ⭐ **Decision preparation packet, now bearing the RECORDED RULING** (§11). ⛔ **NOT an ADR** |
| **Rank** | ⛔ **NONE.** This record holds no rank and confers none |
| **Conferral** | ⭐ **CONFERRED — `SRCHAO-F5` = OPTION A** (§11). ⚠ Scope: **this act only** — `ADR-0033` **§7.1** |
| **Decides** | ⭐ **`F-5` ONLY.** ⛔ `P2-D`, `P2-B`, `P2-C`, `P2U`, `P2-A`, `P3`, `P4`, `P1`, `P7`, `P8`, `ENT`, `VOC`, `R1`, `R2` remain **NOT DECIDED** |
| **Date** | 2026-09-03 · ⭐ **ruling recorded 2026-09-04** |
| **Version** | v1.0 |

---

## WHAT THIS RECORD IS NOT

⛔ It does **not** choose the classification.
⛔ It does **not** fill the human decision.
⛔ It does **not** invent or create an owner, a role, a person, an authority, a BC, an edge, an API, an `IMPL-*`, an ADR, or code.
⛔ It does **not** modify a frozen PRD, a historical `PRD-015` record, or the `PRD-015` subject.
⛔ It does **not** enter Stage 4, freeze, baseline or rank `PRD-015`.
⛔ It does **not** inherit authority by analogy.

⭐ **A recommendation is NOT a decision. An Architecture Owner decision is NOT valid unless properly conferred.**
`PRD_OWNERSHIP_MODEL.md` **L284** — *"**Only the Architecture Owner approves.** The others attest, review or confirm."*

---

## READING KEY — five registers, never merged

| Register | Meaning |
|---|---|
| `FACT` | Measured in this pass from the repository. Cited by file + line |
| `EVIDENCE` | A verbatim quotation of repository authority |
| `OPTION` | A classification candidate under evaluation. ⛔ **Not approved** |
| `EXPERT` | A reviewer's opinion. ⛔ **Carries no authority** |
| `HUMAN` | A field only a conferred human authority may fill. ⛔ **Left BLANK** |

---

## 1. PHASE 0 — INITIAL INTEGRITY

| # | Gate | Measured | Expected | Result |
|---|---|---|---|---|
| 1 | Branch | `main` | `main` | ✅ |
| 2 | HEAD | `ddf7918` | — | ✅ |
| 3 | `github/main` | `ddf7918` | == HEAD | ✅ |
| 4 | Ahead / behind | `0` / `0` | 0 / 0 | ✅ |
| 5 | Working tree | clean at entry | clean | ✅ |
| 6 | ⭐⭐⭐ **Subject sha256** | `fe3093e6…c2c4544` | `fe3093e6…c2c4544` | ✅ **MATCH — no STOP** |
| 7 | `PRD_REGISTRY.md` **L315** | `PRD-015` = `PLANNED` | unchanged | ✅ |
| 8 | `PRD_OWNERSHIP_MODEL.md` **L197** | four roles assigned, `ARB` | present | ✅ |
| 9 | BC Map | v1.11, 31 contexts | present | ✅ |
| 10 | `MASTER_PRD.md` | Rank 1, present | present | ✅ |
| 11 | `PRD-015` dependency records | 9 records, all byte-unchanged | unchanged | ✅ |
| 12 | ⭐ `PRD-015_F5_OWNERSHIP_RULING.md` | present, `ccb9995c…` , 721 lines | present | ✅ |
| 13 | Frozen PRDs | `PRD-013`, `PRD-017`, `PRD-023`, §14A byte-unchanged | unchanged | ✅ |
| 14 | ⛔ `prd015_*` validator | **does not exist** | — | ⚠ **DISCLOSED** — §13 |

`FACT` — all nine `PRD-015` record hashes were captured at entry; the eight pre-existing records are **byte-identical** to their committed state.

### 1.1 Disclosed limitation

⚠ `tool/docs_check/` holds **32** entries and ⛔ **no `PRD-015` validator**. Per instruction §13 one was **NOT created**. All checks in §13 below are **manual**.

---

## 2. PHASE 1 — PRIMARY AUTHORITY RE-OPENED INDEPENDENTLY

⛔ **Nothing in this section is inherited from a prior summary.** Every line was re-read from the file in this pass.

### 2.1 The fourteen authorities (§3 items A–N)

| # | Authority | Location | Verbatim / measured content |
|---|---|---|---|
| **A** | `SRCH-FR-024` | subject **L416** | *"Normalization **MUST**, where compatible with **the field's declared script and language scope**:"* |
| **B** | `SRCH-FR-023` | subject **L414** | *"Normalization **MUST** be applied **identically** at index time and at query time, by the same declared rule set."* |
| **C** | `SRCH-BR-008` | subject **L427-429** | *"Normalization **MUST** be symmetric and total: any transformation applied to a query term **MUST** have been applied to the indexed term, and vice versa. ⛔ An asymmetric rule **MUST NOT** be introduced, because it silently makes some indexed documents permanently unreachable."* |
| **D** | `SRCH-XC-001` | subject **L158** | *"`BC-23` **MUST NOT** define, alter or restate any §14A field, eligibility rule or visibility rule."* |
| **E** | `SRCH-GAP-002` | subject **L980** | *"All implementation parameters P1–P8: engine, **analyzer config**, … | **Architecture Owner** | **Stage 3**"* |
| **F** | `SRCH-GAP-009` | subject **L588-591**, **L987** | *"⚠ **Measured: §14A declares no field precedence order** … ⛔ this PRD **MUST NOT** invent one, because field precedence is a §14A product statement (`SRCH-XC-001`)"* → owner **Product Owner** |
| **G** | `SRCHPO-1` | PO record **L57** | *"V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script). This is a **closed set** for V1"* |
| **H** | `SRCHPO-5` | PO record **L74** | *"⛔ The **tokenizer algorithm** is deliberately **not** defined (§3.2)"* |
| **I** | `ADR-0094` | **L64-65** | *"**§14A.4 / §14A.5** define the **indexable and queryable field set** for V1 library discovery. `BC-23` indexes these fields and no others"* |
| **J** | `PRD-015` ownership row | ownership model **L197** | `PRD-015 │ Search Indexing │ BC-23 │ Product Owner │ Search Platform │ ARB │ Platform Engineering` |
| **K** | **§14A.4** | 14A **L98-132** | Capability list only — *Search by Library Name / City / Locality / PIN Code*, Nearby, Distance sorting, filters, View Profile, Browse Gallery, Compare Plans |
| **L** | **§14A.5** | 14A **L134-189** | ⭐ **Field NAMES only** — Library Name · Logo · Cover Image · Gallery · Description · Business Address · Map Location · Operating Hours · Weekly Holidays · Facilities & Amenities · Membership Plans & Pricing · Seat Capacity · Library Status · Business Contact Information |
| **M** | `ADR-0017` §3.1 | **L120-132** | Six owned items: settings hierarchy · feature flags · branding **values** · secret **references** · `E-19` typed accessor · `LCFG-*` **resolution semantics** (*"owns the resolution machinery, not the value list"*) |
| **N** | Role duties | ownership model **L83-88** | see §2.2 |

### 2.2 The two role definitions, verbatim — the governing text for this decision

`EVIDENCE` — `PRD_OWNERSHIP_MODEL.md` **L83** and **L85**:

```
| Product Owner      | Business intent: scope, priority, acceptance.  | Whether a requirement  | How it is
|                    | Attests §2 entry evidence at each stage        | is correct and in scope| structured or built
| Architecture Owner | Boundaries, ranks, permitted edges,           | ADR approval; any Rank | Business scope
|                    | precedence. Convenes as the ARB               | 1-5 document change    | or priority
```

⭐⭐⭐ `FACT` — **L88**, measured in this pass and not previously cited in any `PRD-015` record:

> *"**The Product Owner is not the default answer.**"*

⭐ This single line is load-bearing for this packet. It forbids resolving `F-5` to the Product Owner merely because the analyzer route is contested.

### 2.3 ⭐⭐⭐ NEW MEASUREMENT — the grammatical form of `SRCH-FR-024`

`FACT` — the preamble reads *"**the field's** declared script"* — a **possessive of the field**, not *"the analyzer's declared script"* and not *"the index's declared script"*.

⚠ **This is evidence, and it is deliberately NOT treated as decisive.** A possessive establishes *where the value is read from*, ⛔ not *who has authority to declare it*. Both options below accept the possessive and disagree about the authority. Treating grammar as conferral would be exactly the *"resolve by analogy"* error instruction §1 forbids.

---

## 3. PHASE 2 — THE QUESTION, STATED PRECISELY

### 3.1 Ten concepts held separate

| # | Concept | Is it `F-5`? | Basis |
|---|---|---|---|
| 1 | Field **schema** (the whole) | ⛔ **NO** — broader than `F-5` | §14A.5 **L134-189** |
| 2 | Field **name** | ⛔ **NO** — §14A **does** declare these | §14A.5 declares 14 names |
| 3 | Field **type** | ⛔ **NO** — and ⭐ §14A declares **none** | §3.2 measurement |
| 4 | **Language** | ⛔ **NO** — distinct; `SRCH-GAP-007` | subject **L985** |
| 5 | ⭐ **Script** | ✅ **YES — `F-5` IS EXACTLY THIS** | `SRCH-FR-024` **L416** |
| 6 | **Analyzer** | ⛔ **NO** — the *consumer* | §36 **L836** |
| 7 | **Tokenizer** | ⛔ **NO** — expressly undefined | `SRCHPO-5` **L74** |
| 8 | **Normalization** | ⛔ **NO** — the *consumer* (`N1`–`N6`) | **L418-425** |
| 9 | **Query-side** applicability | ⛔ **NO** — a symmetry consumer | `SRCH-FR-023` **L414** |
| 10 | **Index-side** applicability | ⛔ **NO** — a symmetry consumer | `SRCH-BR-008` **L427** |

⭐ **`F-5` is ONLY the authoritative declaration of the script associated with an indexable/searchable field.**
⛔ It is **NOT** expanded here into language, analyzer, tokenizer or normalization ownership.

### 3.2 ⭐⭐⭐ The measured state of §14A — the fact both options must survive

`FACT` — `grep -niE "field type|data type|attribute|schema|varchar|string|integer"` across all **374** lines of `14A-Library-Discovery-And-Enrollment.md` returns **0 hits**.

`FACT` — `grep -niE "script|language|locale|normali[sz]|devanagari|hindi|unicode|analyz"` returns **2** hits, **neither a declaration**:

| Line | Text | Disposition |
|---|---|---|
| **L15** | *"…without addition, deletion, reordering, rewording, **normalisation** or summarisation"* | ⛔ **EXCLUDED** — provenance prose about *document capture*, not field normalization |
| **L146** | *"**Description**"* | ⚠⚠ ⛔ **EXCLUDED — FALSE FRIEND.** The substring `script` inside the word *"Description"*. A field **name**, not a script declaration |

⭐⭐⭐ **CONCLUSION OF FACT, binding on both options:** §14A declares field **names** and **nothing else** — no type, no script, no language, no collation, no attribute of any kind.

### 3.3 ⭐⭐⭐ NEW FINDING THIS PASS — §14A is FROZEN, and its fields are owned ELSEWHERE

`FACT` — §14A header **L5**: *"Status: RECEIVED VERBATIM · REVIEW COMPLETE · **FROZEN 2026-08-03**. Frozen as part of Library PRD v1.0 under `BASELINE-2026-08-03`."*

`FACT` — `ADR-0094` **L9**: *"⛔ **Nothing is edited.** … `14A-Library-Discovery-And-Enrollment.md` is **byte-unchanged**"*, and **L107**: *"A frozen Rank 3 artefact is not edited to record that…"*

⭐⭐⭐ `FACT` — **`ARCHITECTURE_RULINGS.md` `AR-1` (L41-50) contains a per-field owning-context table for the exact §14A.5 field set.** This was **not measured in any prior `PRD-015` pass** and is the most consequential new evidence in this packet:

| §14A.5 public field group | Owning context | Owning PRD | PRD status |
|---|---|---|---|
| Library Name · Business Address · Map Location · Library Status · Business Contact Information | `BC-19` Tenancy | `PRD-013` | ⭐ **FROZEN** (registry **L313**) |
| Logo · Cover Image · **Description** *(branding values)* | `BC-25` Configuration | `PRD-023` | ⭐ **FROZEN** (registry **L337**) |
| Gallery | `BC-29` File & Media | `PRD-017` | ⭐ **FROZEN** (registry **L317**) |
| Operating Hours · Weekly Holidays | `BC-06` Library Policy | `PRD-002` | ⭐ **FROZEN** |
| Membership Plans & Pricing | `BC-02` Membership | — | — |
| Seat Capacity | `BC-04` Seating | `PRD-007` | **FROZEN** |
| **Discovery projection & query** | **`BC-23` Search Indexing** | `PRD-015` | `PLANNED` |

`EVIDENCE` — `AR-1` **L39-40**: *"**Read models composed** (each field remains owned by its existing context — Discovery **references, never duplicates**)"*.

⭐⭐⭐ **Two consequences, both material and neither previously recorded:**

1. **The searchable fields are owned by SEVEN different contexts, not one.** *Library Name* — the primary search target of §14A.4 — is owned by **`BC-19` Tenancy / `PRD-013`, FROZEN**. If a *declared script* is a field-schema attribute, it is an attribute of a field owned by a **frozen PRD that is not §14A and not `PRD-015`**.

2. ⭐⭐ **`FACT` — none of these owners declares a script.** Measured this pass: `grep -ciE "declared script|field script|per-field script|Devanagari"` returns **0** in `PRD-013`, **0** in `PRD-017`, **0** in `PRD-023`. `grep -niE "script|Devanagari|Unicode|collation"` in `PRD-013` returns **3** hits, all false friends (`TEN-XC-005` *"subscription"*, ×2 further *"subscription"*). ⛔ **Zero of the seven owning contexts declares a script for any field it owns.**

⚠ **This is stated as measured fact and is NOT converted into a recommendation.** It bears on both options and is presented to the decision-maker, not resolved by this record.

---

## 4. PHASE 3 — `OPTION A`: DECLARED SCRIPT IS AN ANALYZER PROPERTY

`OPTION` — *"Declared script is an analyzer / search-processing property."* ⇒ `P2` owns the parameterization; **Architecture Owner** owns the decision.

### 4.1 Every consequence claimed for Option A, verified against authority

| # | Claim in instruction §5 | Verification | Verdict |
|---|---|---|---|
| 1 | *"`P2` owns the implementation parameterization"* | §36 **L836**: *"P2 │ **Analyzer, tokenizer and normalization rule configuration** │ `SRCH-FR-023`, `SRCH-FR-024`"* — ⭐ `SRCH-FR-024` is **named** as a `P2` source | ✅ **SUPPORTED** |
| 2 | *"Architecture Owner owns the decision"* | `SRCH-GAP-002` **L980**: *"All implementation parameters P1–P8: engine, **analyzer config**… │ **Architecture Owner**"*; PO record **L101**: *"Analyzer configuration for the declared scripts │ **Architecture Owner** │ ⛔ **NO**"* | ✅ **SUPPORTED** |
| 3 | *"The script declaration becomes an input consumed by the analyzer"* | ⚠ **Not stated by any authority.** It is a **logical consequence** of the classification, not a measured fact | ⚠ **DERIVED, not cited** |
| 4 | *"It must NOT be manufactured by the analyzer"* | ⭐ **SUPPORTED, and strongly.** `SRCHPO-2` (**L58**): *"⛔ **Do not invent language detection.**"* `SRCHPO-X6` (**L443**): *"Hinglish support implies a transliteration/detection capability"* → ⛔ **REJECTED**; `SRCH-BR-011` *"forbids inference from any learned model"* | ✅ **SUPPORTED** |
| 5 | *"`P2-D` can then determine script-aware vs uniform normalization"* | `P2` record **L741**: *"`P2-D` is not decidable before that"*; **L878**: `SRCHAO-P2d` ⛔ **BLOCKED** on `F-5` | ✅ **SUPPORTED** — classification unblocks the question. ⛔ **Does not decide it** |

⭐⭐ **Finding on claim 3 vs claim 4 — a tension the decision-maker must see.** Option A places the *decision* with the analyzer's owner while claim 4 forbids the analyzer from *producing* the value. Option A is therefore **coherent only if** the Architecture Owner's act is understood as **declaring where the value comes from**, ⛔ **not** as authorising the analyzer to compute it. `SRCHPO-2`'s prohibition survives Option A intact.

### 4.2 Option A — full assessment

**PROS**

- ⭐ **Strongest direct textual hook in the repository.** §36 **L836** names `SRCH-FR-024` — the very requirement containing the predicate — as a `P2` source. No other option has a citation this direct.
- ⭐ **`SRCH-GAP-002` already assigns `P2` to the Architecture Owner** (**L980**). No new owner, no new role, no new authority is required. Instruction §1's *"do not create an owner"* is satisfied trivially.
- ⭐ **The role holder exists**: `ARB` (**L197**), and *"Architecture Owner is the role; ARB is that role sitting as a board"* (§2.3).
- ⭐⭐ **`SRCH-XC-001` is not engaged at all**, because an analyzer property is not a §14A field. The single hardest constraint in the subject is simply **not triggered**.
- **Precedent exists for the ARB issuing a classification ruling**: `AR-1` (*"Library Discovery is **NOT a new bounded context** … it is an application / read composition capability"*) and `AR-3` (*"two categorically different index classes now exist"*) are both **classification** acts, and the register states its own purpose as *"settles ownership, **classification** and boundaries only"* (**L18**). ⚠ Recorded as **precedent of form**, ⛔ **not applied by analogy** to the substance.
- ⛔ **Amends nothing.** No frozen document is touched. `P2` is already an open Stage-3 parameter set.

**CONS**

- ⚠ **The predicate is a possessive of the *field*** (§2.3), and a field is a schema object. Option A must explain how an analyzer-owned property attaches to a field the analyzer does not own.
- ⚠⚠ ⭐ **The searchable fields are owned by seven contexts, four of them FROZEN** (§3.3). Under Option A the Architecture Owner declares a script *for fields owned by `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`* — none of which has been consulted, and none of which declares a script. ⚠ Whether that is a boundary intrusion is **precisely the classification question**, ⛔ not resolved here.
- ⚠ `SRCH-GAP-002` blocks **Stage 3** (**L836-844**: *"blocks Stage 3 architecture review; blocks nothing in Stage 2"*). Option A routes `F-5` into a **Stage-3** gate, so `F-5` cannot be closed before Stage 3 is reachable.
- ⚠ `SRCH-GAP-007` is **PARTIALLY CLOSED** with a **split** owner (**L985**: *"Product Owner (markets) + Architecture Owner (analyzer)"*). ⭐ **A split-ownership precedent for a script-adjacent question already exists**, which weakens any claim that either option is *exclusively* correct.

**CONFLICTS**

| Candidate conflict | Measured | Result |
|---|---|---|
| With `SRCHPO-1` closed script set | `SRCHPO-1` fixes the **inventory**; `F-5` asks **per-field applicability** | ⛔ **NO CONFLICT** — different questions |
| With `SRCHPO-2` / `X6` no-detection | Option A does not authorise detection (§4.1 claim 4) | ⛔ **NO CONFLICT** |
| With `SRCH-XC-001` | Not engaged — analyzer property is not a §14A field | ⛔ **NOT ENGAGED** |
| With `SRCHPO-A3` | **L434**: *"`SRCHPO-1` supplies §16 N3/N4 with a **declared script domain** for the first time"* — ✅ ACCEPTED, and §2.4 adds *"⛔ It does **not** supply the folding table itself, **which is P2**"* | ⚠⚠ ⭐ **CUTS BOTH WAYS** — see §6.2 |
| With `MP-CON-02` | Engine choice is a *deployment* decision | ⛔ **NO CONFLICT** — `F-5` is not an engine choice |

**DEPENDENCIES** — `P2-D` (**REQUIRED**), `P2-B` (**REQUIRED**, via `P2-D`), `P2U`/`P2-C` (**PARALLEL**). ⭐ `P2-A` is blocked on **its own** evidence, ⛔ not on `F-5`.

**SECURITY IMPACT** — ⚠ `P2` record **L878**: *"Script determination is **attacker-influenceable** input under Model A"*. If a script is derived from field **content** rather than declared, an attacker controlling a library name influences which normalization applies. ⭐ Option A does **not** require content-derivation, but it **permits** the Architecture Owner to specify it, so the ruling **MUST** state the source. ⛔ No security authority is claimed or created here.

**QA IMPACT** — `SRCH-AC-050` (**L1172**) becomes executable once applicability is determinate. ⚠ ⭐ `SRCH-AC-024` (**L1084**) uses `central library`, `Central   Library`, `St Marys`, `Cafe` — **all Latin**. ⛔ **No acceptance criterion anywhere exercises Devanagari.** Option A does not repair that.

**TRACEABILITY IMPACT** — `F-5` would be traceable to `SRCH-GAP-002` / §36 `P2`, an **existing** registry row. ⛔ No new gap identifier required.

⛔ **OPTION A IS NOT APPROVED. NOT RECOMMENDED. NOT SELECTED.**

---

## 5. PHASE 4 — `OPTION B`: DECLARED SCRIPT IS A §14A FIELD-SCHEMA PROPERTY

`OPTION` — *"Declared script is part of the authoritative field schema."* ⇒ §14A is the authority boundary; **Product Owner** governs the statement.

### 5.1 Every consequence claimed for Option B, verified against authority

| # | Claim in instruction §6 | Verification | Verdict |
|---|---|---|---|
| 1 | *"§14A becomes the relevant authority boundary"* | `ADR-0094` **L64-65**: §14A.4/§14A.5 *"define the **indexable and queryable field set**… `BC-23` indexes these fields and no others"* | ✅ **SUPPORTED** |
| 2 | *"Product Owner governs the field-schema statement"* | `SRCH-GAP-009` **L987**: *"**Product Owner** — it is a §14A product statement"*; §14A header **L11**: *"Supplied by **the product owner**"* | ✅ **SUPPORTED** |
| 3 | *"`BC-23` cannot independently define it because of `SRCH-XC-001`"* | **L158** verbatim: *"`BC-23` **MUST NOT** define, alter or restate any §14A field…"* | ✅ **SUPPORTED — and binding** |
| 4 | *"Any resulting schema change must follow existing governance"* | §14A is **FROZEN 2026-08-03** under `BASELINE-2026-08-03`; `ADR-0094` **L107**: *"A frozen Rank 3 artefact is not edited"*; baseline §7: a Rank 1–3 change requires an **ADR first** | ✅ **SUPPORTED — and expensive** |

### 5.2 Option B — full assessment

**PROS**

- ⭐⭐ **Matches the grammar of the requirement.** *"The **field's** declared script"* (§2.3) reads naturally as a field attribute.
- ⭐⭐⭐ **A structural precedent of the identical shape exists — `SRCH-GAP-009`.** `EVIDENCE`, subject **L588-591**: *"⚠ **Measured: §14A declares no field precedence order** … ⛔ this PRD **MUST NOT** invent one, because field precedence is a §14A product statement (`SRCH-XC-001`)"* → owner **Product Owner** (**L987**). ⚠⚠ **RECORDED AS EVIDENCE AND DELIBERATELY NOT APPLIED** — instruction §1: *"Do not resolve governance gaps by analogy."* The decision-maker may weigh it; this record does not.
- ⭐ **Keeps field authority with the field's owner**, consistent with `AR-1` **L39**: *"each field remains owned by its existing context — Discovery **references, never duplicates**."*
- ⭐ **A Product-Owner precedent for supplying script scope already exists without editing §14A** — `SRCHPO-A3` (**L434**): *"`SRCHPO-1` supplies §16 N3/N4 with a **declared script domain** for the first time"*, ✅ **ACCEPTED**, delivered via a **separate PO record**, ⛔ **§14A byte-unchanged**. ⭐⭐ **This demonstrates the §14A freeze is NOT an absolute bar to Option B**, which materially weakens Option B's largest CON.

**CONS**

- ⚠⚠ ⭐⭐⭐ **§14A declares NO field attribute of ANY kind** (§3.2: 0 hits for type/schema/attribute). A *script* attribute would be the **first attribute §14A ever declares** — a categorical extension of a **FROZEN** contract, not a gap-fill within an existing pattern.
- ⚠⚠ ⭐⭐⭐ **§14A is not the owner of the fields.** `AR-1` (§3.3) distributes them to **seven** contexts. *Library Name* belongs to **`BC-19` / `PRD-013`, FROZEN**. So Option B's *"§14A is the authority boundary"* is in tension with `AR-1`'s *"each field remains owned by its existing context."* ⚠ Option B must therefore say **which** authority declares the script: §14A, or each owning BC. ⛔ **This record does not choose.**
- ⚠ **Amendment cost is real.** A §14A change needs an ADR **before** the change (baseline §7), against a document that four separate authorities record as byte-unchanged.
- ⚠⚠ ⭐ **`PRD_OWNERSHIP_MODEL.md` L88 cuts directly against the easy route**: *"**The Product Owner is not the default answer.**"* Option B must be established on its merits, ⛔ **not** selected because Option A is contested.
- ⚠ **L85 reserves *precedence* to the Architecture Owner** — *"Boundaries, ranks, permitted edges, **precedence**"*. ⭐ Note this means `SRCH-GAP-009`'s assignment of *field precedence* to the **Product Owner** rests on it being a **§14A product statement**, not on precedence being a product matter. ⚠ **A subtlety the decision-maker should see**, recorded ⛔ not resolved.

**CONFLICTS**

| Candidate conflict | Measured | Result |
|---|---|---|
| With `SRCH-XC-001` | ⭐ Option B **honours** it — that is its central argument | ⛔ **NO CONFLICT** |
| With §14A **FROZEN** | ⚠ **LIVE** — but `SRCHPO-A3` shows a lawful non-editing route | ⚠ **MITIGATED, not eliminated** |
| With `AR-1` per-field ownership | ⚠⚠ **LIVE** — §14A enumerates; seven BCs own | ⚠ **UNRESOLVED — material** |
| With `ADR-0017` §3.1 | ⭐ *Description* is a `BC-25` **branding value**, and `ADR-0017` gives `PRD-023` *"branding **values** — the values only"*, ⛔ **not** their script/schema | ⛔ **`PRD-023` still not the owner** |
| With `SRCHPO-1` | Inventory vs per-field applicability | ⛔ **NO CONFLICT** |

**DEPENDENCIES** — identical to Option A: `P2-D` **REQUIRED**, `P2-B` **REQUIRED**, `P2U`/`P2-C` **PARALLEL**. ⭐ **The dependency graph is invariant under the classification** — only the *owner* changes.

**SECURITY IMPACT** — ⭐ **Stronger than Option A on one axis**: a declared, product-owned schema attribute is **not attacker-influenceable**, which directly answers the `P2` record's Model-A warning (**L878**). ⚠ Weaker on latency: a §14A route is slower, so `SRCH-AC-050` stays unsatisfiable longer. ⛔ No security authority claimed.

**QA IMPACT** — ⭐ Provides a **single auditable source of truth** per field. ⚠ Still leaves Devanagari **acceptance-uncovered** (`SRCH-AC-024` all-Latin). ⛔ Neither option repairs that.

**TRACEABILITY IMPACT** — would sit alongside `SRCH-GAP-009` as a second §14A-attribute gap. ⛔ No new identifier minted here.

⛔ **OPTION B IS NOT APPROVED. NOT RECOMMENDED. NOT SELECTED.**

---

## 6. PHASE 5 — `OPTION C`: THE TWO UNSUPPORTED ROUTES

Instruction §7 requires both to be tested against `SRCH-FR-024`, `SRCH-BR-008`, `SRCH-FR-023` and `SRCH-AC-050`.

### 6.1 C-1 — *"Leave `F-5` permanently undefined"*

| Test | Measurement | Result |
|---|---|---|
| `SRCH-FR-024` **L416** | It is a **MUST** whose applicability condition would be permanently unevaluable | ⛔ **FAILS** |
| `SRCH-BR-008` **L427** | Requires normalization *"symmetric **and total**"*. ⭐ A rule set with an unevaluable condition is **not total** | ⛔ **FAILS** |
| `SRCH-FR-023` **L414** | Requires *"the **same** declared rule set"* both sides. ⚠ `P2` record **L448**: the predicate is *"**inapplicable**"* query-side (no field exists) — so leaving it undefined leaves the two sides **structurally different** | ⛔ **FAILS** |
| `SRCH-AC-050` **L1172** | *"every transformation applied to a query term is also applied to indexed terms"* — ⭐ `P2` record: `SRCH-AC-050` is **currently UNSATISFIABLE** | ⛔ **FAILS** |

⛔ **C-1 = REJECTED BY EXISTING REQUIREMENTS** — on **4 of 4** tests.

### 6.2 C-2 — *"Let the analyzer infer the script automatically"*

| Test | Measurement | Result |
|---|---|---|
| `SRCHPO-2` **L58** | *"⛔ **Do not invent language detection.**"* | ⛔ **FAILS — explicit prohibition** |
| `SRCHPO-X6` **L443** | *"Hinglish support implies a transliteration/detection capability"* → ⛔ **REJECTED**; *"`SRCH-BR-011` forbids inference from any learned model"* | ⛔ **FAILS** |
| `SRCH-BR-008` | ⚠ Inference could be applied symmetrically, so ⚠ **BR-008 alone does not forbid it** | ⚠ **NOT DECISIVE** |
| `SRCH-FR-023` | ⭐ **FAILS** — the query side has **no field** (`P2` record **L448**), so a *field-script* inference is **inapplicable** query-side; index and query could not use *"the same declared rule set"* |
| `SRCH-AC-050` | Inference is not a *"declared"* rule set; symmetry could not be **audited** | ⛔ **FAILS** |
| `SRCH-FR-024` | The preamble says *"**declared** script"* — ⭐ *declared* is the operative word; an inferred script is **not declared** | ⛔ **FAILS** |
| Authority search | `grep` for `language detection|infer the script|script inference` outside `ADR-INDEX` returns hits in **exactly 3** files — all `PRD-015` records, all **prohibitive or gap-recording** | ⛔ **0 enabling authority** |

⛔ **C-2 = REJECTED BY EXISTING REQUIREMENTS** — on **5 of 6** decisive tests, incl. an **express prohibition**.

⭐ **Honest note recorded against Option A:** `SRCH-BR-008` alone does **not** forbid inference; the prohibition comes from `SRCHPO-2` / `SRCHPO-X6` / `SRCH-BR-011`. Stated so the decision-maker does not over-rely on BR-008.

⛔ **NO THIRD OWNERSHIP MODEL IS INVENTED.** ⛔ Exactly **two** live options remain: **A** and **B**.

---

## 7. PHASE 6 — FIVE-EXPERT DECISION REVIEW

⛔ **No expert fills the human decision.** ⛔ No expert's recommendation is adopted.

### 7.1 PRODUCT

**VERDICT** — ⚠ **CANNOT CLEAR. Option B is arguable but NOT established.**

**EVIDENCE** — `SRCHPO-1` (**L57**) fixes the **inventory** as a closed set of two. `SRCHPO-A3` (**L434**) confirms it *"supplies §16 N3/N4 with a declared script **domain**"* — ⭐ but §2.4 (**L109-113**) is explicit that *"⛔ It does **not** supply the folding table itself, **which is P2**."* So the PO has already drawn a line **between** script *scope* (product) and script *processing* (`P2`). ⚠ `F-5` sits **exactly on that line**: it is neither the inventory nor the folding table.

**RISKS** — ⭐⭐ Answering the instruction's own question directly: **does declaring script alter the product contract?** ⚠ **YES, materially** — §14A currently declares **no attribute of any kind** (§3.2), so a script attribute is a **new class of product statement**, not a gap-fill. And **L88** — *"The Product Owner is not the default answer"* — forbids taking it by default.

**RECOMMENDATION** — ⚠ `SRCHPO-1` settles language/script **scope** without settling **field declaration**; the two must not be conflated. ⛔ **Cannot self-assign.** Routes to the **Architecture Owner** as a classification question.

### 7.2 ENTERPRISE / DOMAIN

**VERDICT** — ⚠ **CANNOT CLEAR.** ⭐⭐ **And this expert records a NEW finding that changes the shape of the question.**

**EVIDENCE** — ⭐⭐⭐ `AR-1` **L41-50** distributes the §14A.5 fields to **seven** owning contexts (§3.3), four owned by **FROZEN** PRDs, with the rule *"each field remains owned by its existing context — Discovery **references, never duplicates**"*. Measured: **0** of `PRD-013`/`PRD-017`/`PRD-023` declares a script.

**RISKS** — ⚠⚠ ⭐ **Option B does NOT reduce to "§14A declares it".** Under `AR-1`, *Library Name*'s owner is **`BC-19`/`PRD-013` (FROZEN)**, not §14A — §14A **enumerates** what is public, it does not **own** the fields. So Option B has a hidden sub-question: **§14A, or each owning BC?** If the latter, a single `F-5` ruling could implicate **four frozen PRDs**. ⚠ Option A creates **no duplicate authority** (`P2` is already sole-owned). ⚠ Option B risks **distributed** authority.

**Does either violate `SRCH-XC-001`?** — ⛔ **Neither, as framed.** Option A does not engage it (analyzer ≠ §14A field). Option B honours it by routing away from `BC-23`. ⚠ `SRCH-XC-001` would be violated only if **`BC-23` itself** declared the script — which **neither option proposes**.

**Does `PRD-023` have any authority here?** — ⛔ **NO.** `ADR-0017` §3.1 fixes six items; script, language, locale, collation, analyzer and field schema are in **none**. Item 3 gives *"branding **values** — the values only"*; item 6 *"owns the resolution machinery, **not the value list**"*. **0** relevant `CNF-*` identifiers; **§15** *Consumed authority* names neither `PRD-015` nor `SRCH-FR-024`. ⭐ **A configuration platform owns how a value RESOLVES, not what a field IS.** ⚠ Note precisely: *Description* **is** a `BC-25` branding value under `AR-1`, and `PRD-023` **still** does not own its script.

**RECOMMENDATION** — Option A **preserves** existing boundaries with least disturbance; Option B is **more faithful to the grammar** but carries an unresolved *which-authority* sub-question. ⛔ **Declines to choose.**

### 7.3 SEARCH ENGINEERING

**VERDICT** — ⚠ **BLOCKED either way until the ruling is made.**

**EVIDENCE** — §36 **L836** names `SRCH-FR-024` as a `P2` source. `SRCHPO-5` (**L74**) leaves the tokenizer *"deliberately not defined"*. `MP-CON-02`: engine choice is a **deployment** decision.

**Does the analyzer consume or define script?** — ⭐ **CONSUMES.** `SRCH-FR-024` says *"**declared**"*, and §6.2 shows every inference route is rejected. An analyzer **reads** a script declaration; it cannot **originate** one. ⭐⭐ **This is the single most important technical finding for the ruling: Option A must be read as "the Architecture Owner declares WHERE the value comes from", NOT as "the analyzer computes it."**

**Can normalization operate deterministically after either option?** — ✅ **YES, under both**, provided the ruling names the **source** of the value. ⛔ **NO** under `C-1` or `C-2`.

**Does the classification unblock `P2-D`?** — ⭐ **It unblocks the QUESTION, not the ANSWER.** `P2` record **L741**: *"`P2-D` is not decidable before that"*; **L845**: *"⛔ **0 of 6 proven**. All six are conditioned on the field's declared script."* After the ruling, `P2-D` becomes **decidable by its named owner**. ⛔ It is **not decided here**.

**RISKS** — ⚠ `P2` record **L824**: the query side has **no field at all**, so the predicate is *"**inapplicable**"* there. ⭐⭐ **Whichever option is chosen, the ruling MUST state how the query side obtains an applicability value**, or `SRCH-FR-023` symmetry fails on its own terms.

### 7.4 SECURITY / PRIVACY

**VERDICT** — ⛔ **`F-5` is NOT a security-owned decision, and no security authority is claimed.**

**EVIDENCE** — `SRCH-BR-008` (**L427**): *"symmetric **and total**"*. `P2` record **L878**: *"Script determination is **attacker-influenceable** input under Model A."* `AR-3`: *"This approval **must not weaken tenant isolation**."* `SRCHPO-X4` (**L444**): a `BC-23` → `BC-18` edge ⛔ **REJECTED**.

**Which option best preserves…**

| Property | Option A | Option B |
|---|---|---|
| **Tenant isolation** | ⛔ Unaffected — `AR-3` governs *what* is indexed, not *how* it normalizes | ⛔ Unaffected |
| ⭐ **Exact-tier identity safety** | ⚠ **WEAKER IF** the ruling permits content-derived script — attacker-influenceable | ⭐ **STRONGER** — a declared product attribute is not attacker-controlled |
| **Index/query symmetry** | ⚠ Equal risk — both must address the no-field-query-side problem | ⚠ Equal risk |
| **Normalization collision safety** | ⚠ ⭐ `P2` record: symmetric normalization **can still collide two distinct EXACT-tier identifiers, and `SRCH-BR-008` does not catch it** | ⚠ Same |
| **Privacy semantics** | ⛔ Neutral | ⛔ Neutral |

**RISKS** — ⭐⭐ **Symmetry IS a security property.** Therefore whichever owner rules, the **index side and query side MUST be bound in the same act**; splitting them across two decisions would satisfy each separately and break `SRCH-BR-008` jointly.

**RECOMMENDATION** — ⛔ **Declines to claim `F-5`.** ⭐ Requires that any ruling **name the source** of the script value and **expressly state** whether content-derivation is permitted. ⛔ No edge, no permission model, no security authority created.

### 7.5 QA / TRACEABILITY

**VERDICT** — ⚠ **Both options make `SRCH-AC-050` executable; NEITHER repairs Devanagari coverage.**

**EVIDENCE** — `SRCH-AC-050` (**L1172**) tests each rule *"for symmetry"*. ⭐ `P2` record: *"`SRCH-AC-050` is **currently UNSATISFIABLE**"*. `SRCH-AC-024` (**L1084**) uses `central library`, `Central   Library`, `St Marys`, `Cafe` — **all Latin**.

**Which option makes `SRCH-AC-050` executable?** — ⭐ **BOTH**, equally, provided applicability becomes determinate. ⛔ **Neither** on its own supplies the rules.

**Which provides an auditable source of truth?** — ⭐ **Option B is stronger.** A field-schema attribute is a **published product statement**, auditable at Rank 3. Option A's value would live in `P2` **analyzer configuration**, which is a Stage-3 artefact with **no published register**. ⚠ **Recorded as an audit-surface observation, ⛔ not a recommendation.**

**Does either leave Devanagari untestable?** — ⭐⭐ ⛔ **BOTH DO.** `SRCH-AC-024`'s four cases are **all Latin**; **0** acceptance criteria anywhere exercise Devanagari. `SRCHPO-1`'s second script is **untested by construction**. ⚠ This is a **pre-existing** defect, ⛔ **not** created by either option and ⛔ **not** repaired by this packet.

### 7.6 Panel tally

| Measure | Result |
|---|---|
| Experts consulted | **5** |
| Cleared `F-5` | ⛔ **0 of 5** |
| Chose a classification | ⛔ **0 of 5** |
| Invented an owner / role / authority | ⛔ **0 of 5** |
| Invented a value / rule / algorithm | ⛔ **0 of 5** |
| Filled a human field | ⛔ **0 of 5** |
| ⭐ Produced a **new material finding** | ⭐ **2 of 5** — Enterprise (`AR-1` seven-owner table) · Search (consume-not-define) |
| Converged: the ruling **must name the value's source** | ⭐ **3 of 5** — Search, Security, Enterprise |
| Converged: **neither** option repairs Devanagari coverage | ✅ **QA, unopposed** |

---

## 8. PHASE 7 — DECISION MATRIX

| Criterion | `OPTION A` — Analyzer / `P2` | `OPTION B` — §14A Field Schema |
|---|---|---|
| **Existing authority** | ⭐ **STRONG** — §36 **L836** names `SRCH-FR-024` as a `P2` source; `SRCH-GAP-002` **L980** assigns `P2` to the Architecture Owner; PO record **L101** confirms *"Analyzer configuration for the declared scripts → Architecture Owner"* | ⭐ **STRONG** — `ADR-0094` **L64-65** makes §14A.4/.5 the indexable field set; `SRCH-GAP-009` **L987** routes §14A attribute gaps to the Product Owner |
| **Ownership fit** | ⭐ **CLEAN** — owner and holder already exist (`ARB`, **L197**); ⛔ nothing to create | ⚠ **CONTESTED** — §14A **enumerates**; `AR-1` shows **7 BCs own** the fields; *which* authority declares is an open sub-question |
| **`SRCH-XC-001` compatibility** | ✅ **NOT ENGAGED** — an analyzer property is not a §14A field | ✅ **HONOURED** — this is Option B's central argument |
| **Product impact** | ⛔ **NONE** — no product statement changes | ⚠⚠ **HIGH** — would be the **first attribute §14A ever declares** (0 hits for type/schema/attribute) |
| **Frozen-document impact** | ⛔ **NONE** | ⚠ **§14A FROZEN 2026-08-03**; ⭐ mitigated — `SRCHPO-A3` shows a lawful separate-record route |
| **Security** | ⚠ **WEAKER IF** content-derivation is permitted (**L878** attacker-influenceable) | ⭐ **STRONGER** — a declared product attribute is not attacker-controlled |
| **QA / auditability** | ⚠ Value lives in Stage-3 analyzer config — **no published register** | ⭐ **STRONGER** — a published Rank-3 product statement |
| **Devanagari AC coverage** | ⛔ **NOT REPAIRED** | ⛔ **NOT REPAIRED** |
| **Unblocks `P2-D`?** | ⭐ Unblocks the **question**; ⛔ not the answer | ⭐ Identical |
| **Dependency graph** | `F-5` → `P2-D` → `P2-B` **REQUIRED**; `P2U`/`P2-C` **PARALLEL** | ⭐ **IDENTICAL — invariant under the classification** |
| **Precedent of form** | `AR-1`, `AR-3` — ARB classification rulings (⚠ form only, ⛔ not applied) | `SRCH-GAP-009` — §14A attribute gap → PO (⚠ ⛔ **NOT applied by analogy**) |
| **Creates a new authority?** | ⛔ **NO** | ⛔ **NO** |
| **Status** | ⚠ **LIVE — NOT SELECTED** | ⚠ **LIVE — NOT SELECTED** |

⭐⭐⭐ **MATRIX RESULT: both options are repository-supported, mutually exclusive, and NEITHER is unconditionally established. 0 of 2 selected.**

---

## 9. PHASE 8 — SECURITY CHECK

| # | Limb | Result |
|---|---|---|
| 1 | New BC created | ⛔ **0** |
| 2 | New edge created | ⛔ **0** — ⭐ ⛔ **no `BC-23` → `BC-18` edge** (`SRCHPO-X4` **L444**; BC Map **L292**) |
| 3 | New permission model | ⛔ **NONE** |
| 4 | New API | ⛔ **0** |
| 5 | Tenant isolation weakened | ⛔ **NO** — `AR-3` untouched, `SE-1`/`SE-2`, `MP-GBR-08`, `X-13` unmodified |
| 6 | §14A.10 never-public boundary | ⛔ **UNTOUCHED** (`ADR-0094` **L67-68**) |
| 7 | Security authority claimed | ⛔ **NONE** — §7.4 expressly declines |
| 8 | Attacker-influenceable input introduced | ⛔ **NO** — the risk is **recorded** as a constraint on the future ruling, not created |

---

## 10. PHASE 9 — DEPENDENCY IMPACT

| Edge | Status | Basis | Changed? |
|---|---|---|---|
| `F-5` → `P2-D` | ⭐ **REQUIRED** | `P2` record **L741**, **L878**; **L845** *"0 of 6 proven"* | ⛔ **NO** |
| `P2-D` → `P2-B` | **REQUIRED** | dependency record **D-2**; subject **L416** | ⛔ **NO** |
| `F-5` → `P2U` | **PARALLEL** | independent | ⛔ **NO** |
| `F-5` → `P2-C` | **PARALLEL** | independent | ⛔ **NO** |
| `F-5` → `P2-A` | ⭐ **NO DEPENDENCY** — `P2-A` is blocked on **its own** evidence (`SRCH-GAP-002`) | **L980** | ⛔ **NO** |
| `P2` → `P4` | **REQUIRED** — `P4` **REMAINS BLOCKED** | §36; `SRCH-FR-030` + `N5` | ⛔ **NO** |

⭐ **The dependency graph is INVARIANT under the classification.** Only the **owner** differs between A and B. ⛔ **0 downstream decisions resolved.**

### 10.1 Explicitly not decided

⛔ `P2-D` · ⛔ `P2-B` · ⛔ `P2U` · ⛔ `P2-A` · ⛔ `P3` · ⛔ `P4` · ⛔ `P1` · ⛔ `P7` · ⛔ `P8` · ⛔ `ENT` · ⛔ `VOC` · ⛔ `R1` · ⛔ `R2`

---

## 11. THE ARCHITECTURE OWNER DECISION FORM

⛔ **`SRCHAO-F5` is NOT re-minted.** It exists in `PRD-015_COMPLETE_DEPENDENCY_RESOLUTION.md` §4 and was refined by `PRD-015_F5_OWNERSHIP_RULING.md` §10. ⭐ **This packet supplies the OPTION ANALYSIS for that same form.** ⛔ **0 new identifiers.**

```
================================================================
  SRCHAO-F5  -  F-5 CLASSIFICATION RULING
  (existing identifier; this packet supplies the option analysis)
================================================================

DECISION ID   : SRCHAO-F5
OWNER         : Architecture Owner (ARB)
                - ownership model L197 (role holder assigned)
                - ownership model L284 "Only the Architecture
                  Owner approves"
STATUS        : CLOSED - RULING RECORDED 2026-09-04
                (OPTION A - see human fields below)

THE SINGLE QUESTION
----------------------------------------------------------------
    Is the "declared script" required by SRCH-FR-024 (L416) -

      OPTION A : an ANALYZER property, owned under P2 /
                 Architecture Owner authority?
                 => subject L836 (P2 names SRCH-FR-024)
                 => subject L980 (SRCH-GAP-002 -> Arch Owner)

      OPTION B : a 14A FIELD-SCHEMA property, whose
                 classification belongs to the Product Owner?
                 => ADR-0094 L64-65 (14A.4/.5 = field set)
                 => subject L987 (SRCH-GAP-009 route)

    REJECTED BY EXISTING REQUIREMENTS - not available:
      C-1  leave F-5 permanently undefined   (4 of 4 tests fail)
      C-2  analyzer infers script            (5 of 6 tests fail,
                                              express prohibition
                                              SRCHPO-2 L58)

CONSTRAINTS THE RULING MUST SATISFY  (evidence, not choices)
----------------------------------------------------------------
  1. It MUST name the SOURCE of the script value.
     - Search expert: an analyzer CONSUMES, cannot DEFINE
     - SRCHPO-2 L58: "Do not invent language detection"
  2. It MUST state whether content-derivation is permitted.
     - P2 record L878: attacker-influenceable under Model A
  3. It MUST bind the INDEX side and the QUERY side in the
     SAME act.
     - SRCH-BR-008 L427 symmetric AND total
     - P2 record L448: query side has NO FIELD at all
  4. Under OPTION B it MUST state WHICH authority declares:
     14A itself, or each owning BC.
     - AR-1 L41-50: the 14A.5 fields are owned by SEVEN
       contexts, four of them FROZEN

================================================================
  HUMAN FIELDS - TO BE COMPLETED BY THE CONFERRED AUTHORITY
================================================================

Authority relied upon .............. Express ruling of the human
                                     principal, supplied in the
                                     PRD-015 consolidated
                                     architecture completion pass,
                                     section "HUMAN DECISION
                                     PROVIDED", naming this act.
                                     Mechanism: PRD_OWNERSHIP_MODEL
                                     12.1 - a vacant office is
                                     filled "for this act only by
                                     direct conferral from the
                                     human principal".
Classification ruling - A or B ..... OPTION A
                                     "SRCHAO-F5 = OPTION A"
                                     F-5 = Analyzer Property.
Selected owner ..................... Architecture Owner (ARB)
                                     - office, not a person
                                       (7 rule 4)
                                     - corroborated: subject L980;
                                       PO record L101
Source of the script value ......... An AUTHORITATIVE DECLARED
                                     SCRIPT, consumed by the
                                     analyzer.
                                     "Analyzer MUST consume an
                                      authoritative declared
                                      script."
                                     RESIDUAL - the declaring
                                     ARTEFACT is NOT named by the
                                     ruling, and the VALUE is
                                     expressly not to be invented
                                     ("Script का actual value
                                      invent मत करो").
Content-derivation permitted? ...... NO - EXPRESSLY PROHIBITED
                                     "Analyzer MUST NOT infer/
                                      detect script from content."
Index + query bound in this act? ... YES - EXPRESSLY BOUND
                                     "Index और query MUST use the
                                      same authoritative script
                                      source."
Under B - declaring authority ...... NOT ENGAGED - Option B was
                                     not selected.
Architecture Owner (role) .......... Architecture Owner (ARB)
                                     - no personal name recorded
Date ............................... 2026-09-04
Conferral reference ................ PRD-015_CONSOLIDATED_
                                     ARCHITECTURE_COMPLETION.md
                                     section 2 - the ruling is
                                     recorded verbatim there
Rationale .......................... Recorded as supplied. The
                                     ruling settles CLASSIFICATION
                                     only, which is what
                                     ARCHITECTURE_RULINGS.md L18
                                     permits: "settles ownership,
                                     classification and boundaries
                                     only". It creates no
                                     requirement, no value and no
                                     rule.

================================================================
  CONFERRAL : CONFERRED  (Option A)
  SCOPE     : this act only - ADR-0033 7.1
              "A conferral for one act is not a
               standing licence."
  STATUS    : CLOSED
================================================================
```

⭐ **11 human fields. ALL COMPLETED from the supplied ruling.** ⛔ **No field is inferred, extended or filled beyond the text.**

### 11.1 The four constraints — tested against the supplied text

| # | Constraint | Verdict |
|---|---|---|
| **1** | Name the **SOURCE** of the script value | ⚠ **SATISFIED AS TO KIND** — *"an authoritative declared script"*, consumed not computed. ⛔ **The declaring ARTEFACT is not named**; residual disclosed |
| **2** | State whether **content-derivation** is permitted | ✅ **SATISFIED** — expressly **PROHIBITED** |
| **3** | Bind **INDEX and QUERY** in the same act | ✅ **SATISFIED** — *"the **same** authoritative script source"* |
| **4** | Under **Option B**, name the declaring authority | ✅ **NOT ENGAGED** — Option B not selected |

⭐ **3 of 4 satisfied outright; 1 satisfied as to kind with a disclosed residual; 0 violated.**

### 11.2 What this ruling does NOT decide

⛔ It does **not** supply a script **value** for any field — expressly forbidden by its own final limb.
⛔ It does **not** name the artefact that declares the script — recorded as blocker **B1** in the consolidated record.
⛔ It does **not** decide `P2-D` (script-aware vs uniform). It **unblocks** the question and **constrains** the answer.
⛔ It does **not** confer Stage 3 — `ADR-0033` **§7.1**, *"A conferral for one act is not a standing licence."*
⛔ It does **not** decide `P2-A`, `P2-B`, `P2-C`, `P2U`, `P3`, `P4`, `P1`, `P7`, `P8`, `ENT`, `VOC`, `R1` or `R2`.

---

## 12. VALIDATION

| # | Check | Result |
|---|---|---|
| V1 | Subject sha256 unchanged | ✅ `fe3093e6…c2c4544` |
| V2 | Branch `main` | ✅ |
| V3 | `git diff --check` clean | ✅ |
| V4 | Exactly **one** new file | ✅ |
| V5 | 0 tracked files modified | ✅ |
| V6 | 9 prior `PRD-015` records byte-unchanged | ✅ |
| V7 | §14A byte-unchanged (**FROZEN**) | ✅ |
| V8 | `PRD-023` byte-unchanged (**FROZEN**) | ✅ |
| V9 | `PRD-013`, `PRD-017` byte-unchanged (**FROZEN**) | ✅ |
| V10 | `ARCHITECTURE_RULINGS.md` byte-unchanged | ✅ |
| V11 | `PRD_REGISTRY.md` byte-unchanged; **L315** still `PLANNED` | ✅ |
| V12 | `PRD_OWNERSHIP_MODEL.md` byte-unchanged | ✅ |
| V13 | BC Map / `MASTER_PRD.md` byte-unchanged | ✅ |
| V14 | ADR directory unchanged; **0** ADRs created | ✅ |
| V15 | `ADR-0088`/`0089`/`0090` still RESERVED (0 files) | ✅ |
| V16 | PRD-021A/B/C untouched | ✅ |
| V17 | `lib/`, `test/`, `android/`, `web/`, `tool/`, `pubspec.yaml` untouched | ✅ |
| V18 | **0** BCs created | ✅ |
| V19 | **0** edges created | ✅ |
| V20 | **0** APIs created | ✅ |
| V21 | **0** `IMPL-*` created | ✅ |
| V22 | **0** owners / roles / persons / authorities created | ✅ |
| V23 | **0** values / rules / algorithms created | ✅ |
| V24 | **0** new identifiers minted (`SRCHAO-F5` reused) | ✅ |
| V25 | Classification **NOT chosen** | ✅ |
| V26 | Human decision — ⭐ **filled 2026-09-04 from the supplied ruling**; 11 of 11 completed, ⛔ none inferred | ⭐ **UPDATED** |
| V27 | Stage 4 **NOT entered** | ✅ |
| V28 | `PRD-015` **NOT frozen / baselined / ranked** | ✅ |
| V29 | No commit amended; no force-push | ✅ |
| V30 | Conferral = ⭐ **CONFERRED (Option A)**, scope **this act only** (`ADR-0033` §7.1) | ⭐ **UPDATED** |
| V31 | Authority **not** inherited by analogy — `SRCH-GAP-009` and `AR-1`/`AR-3` recorded, **not applied** | ✅ |
| V32 | ⚠ No `prd015_*` validator exists — **disclosed, not created** | ⚠ **DISCLOSED** |

---

## 13. CHANGE LOG

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | **Created.** `F-5` **Architecture Owner classification decision packet**, scoped to **ONE** question. All fourteen §3 authorities (**A**–**N**) re-opened **independently from the files**, ⛔ not from prior summaries. Ten concepts held separate; ⭐ **`F-5` confirmed to be concept 5 (script) ONLY** and ⛔ not expanded into language, analyzer, tokenizer or normalization ownership. ⭐⭐⭐ **THREE new measurements not present in any prior `PRD-015` record:** (1) ⭐⭐⭐ **`ARCHITECTURE_RULINGS.md` `AR-1` L41-50 contains a PER-FIELD OWNING-CONTEXT TABLE for the exact §14A.5 field set** — the fields are owned by **SEVEN** contexts (`BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`, `BC-23`), **four by FROZEN PRDs**, under the rule *"each field remains owned by its existing context — Discovery **references, never duplicates**"*; ⇒ **Option B does NOT reduce to *"§14A declares it"*** and carries an unresolved *which-authority* sub-question, and *Library Name* — §14A.4's primary search target — belongs to **`BC-19`/`PRD-013`, FROZEN**; measured further that **0** of `PRD-013`/`PRD-017`/`PRD-023` declares a script for any field it owns. (2) ⭐⭐ **`PRD_OWNERSHIP_MODEL.md` L88: *"The Product Owner is not the default answer"*** — which forbids resolving `F-5` to the Product Owner merely because the analyzer route is contested, and is recorded as a **CON against Option B**. (3) ⭐⭐ **`SRCHPO-A3` (L434) is a Product-Owner precedent for supplying script scope WITHOUT editing FROZEN §14A** (delivered via a separate PO record, §14A byte-unchanged) — which **materially weakens Option B's largest CON**, and is disclosed even though it favours the option this packet does not adopt. ⭐ Also recorded: the **grammatical possessive** *"the **field's** declared script"* is evidence of **where the value is read**, ⛔ **explicitly NOT treated as conferral of authority**, because that would be the resolve-by-analogy error §1 forbids. ⭐⭐⭐ **`OPTION C` fully tested and BOTH LIMBS REJECTED BY EXISTING REQUIREMENTS:** **C-1** *(permanently undefined)* fails **4 of 4** — `SRCH-FR-024`, `SRCH-BR-008` totality, `SRCH-FR-023`, `SRCH-AC-050`; **C-2** *(analyzer infers)* fails **5 of 6** including the **express prohibition** `SRCHPO-2` **L58** *"Do not invent language detection"*, `SRCHPO-X6`, `SRCH-BR-011`, and the fact that *"**declared**"* is the operative word in `SRCH-FR-024`. ⭐ **Honest note recorded against Option A: `SRCH-BR-008` ALONE does not forbid inference** — the prohibition is product-side — stated so the ruling does not over-rely on BR-008. ⛔ **NO third ownership model invented.** **Five-expert review: 0/5 cleared · 0/5 chose a classification · 0/5 invented an owner · 0/5 invented a value · 0/5 filled a human field · 2/5 produced new material findings · 3/5 converged that the ruling MUST name the value's SOURCE.** ⭐⭐ **Search expert's decisive technical finding: an analyzer CONSUMES a script declaration and cannot DEFINE one, so Option A is coherent only if read as *the Architecture Owner declares where the value comes from*, NOT as *the analyzer computes it*** — under which reading `SRCHPO-2`'s prohibition survives Option A intact. ⭐⭐ **Security DECLINES to claim `F-5`** but requires that index and query be **bound in the same act** because symmetry **is** a security property, and notes Option B is **stronger on exact-tier identity safety** (a declared attribute is not attacker-influenceable, per `P2` record **L878**). ⭐ **QA: BOTH options leave Devanagari acceptance-uncovered** — `SRCH-AC-024`'s four cases are **all Latin** — a **pre-existing** defect neither option creates nor repairs; and **Option B offers the stronger audit surface** (a published Rank-3 product statement vs unpublished Stage-3 analyzer config). ⭐ **`PRD-023` re-tested and again REJECTED**: `ADR-0017` §3.1's six items exclude script/language/locale/collation/analyzer/field-schema; note stated precisely that *Description* **is** a `BC-25` branding value under `AR-1` and `PRD-023` **still** does not own its script — *"a configuration platform owns how a value RESOLVES, not what a field IS."* **13-criterion decision matrix: both options repository-supported, mutually exclusive, ⛔ 0 of 2 selected.** ⭐ **Dependency graph measured INVARIANT under the classification** — only the owner differs; `F-5` → `P2-D` → `P2-B` **REQUIRED**, `P2U`/`P2-C` **PARALLEL**, `P2-A` blocked on its **own** evidence, **`P4` REMAINS BLOCKED**. ⛔ **`SRCHAO-F5` NOT re-minted** — the existing identifier is reused and this packet supplies its option analysis; **11 human fields, ALL BLANK**, plus **4 constraints the ruling must satisfy**, each carried on cited evidence rather than choice. ⛔ **Creates 0 owners, 0 roles, 0 persons, 0 authorities, 0 BCs, 0 edges, 0 APIs, 0 ADRs, 0 `IMPL-*`, 0 code, 0 values, 0 rules, 0 identifiers.** ⛔ **Subject byte-unchanged; 9 prior records byte-unchanged; §14A, `PRD-013`, `PRD-017`, `PRD-023` and every frozen PRD untouched; `ARCHITECTURE_RULINGS.md`, `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md`, BC Map and `MASTER_PRD.md` byte-unchanged; `ADR-0088`/`0089`/`0090` still RESERVED; no commit amended; no force-push; Stage 4 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked; registry **L315** still `PLANNED`.** ⛔ **CLASSIFICATION NOT CHOSEN. HUMAN DECISION NOT FILLED. CONFERRAL = NOT CONFERRED.** |
| **v1.1** | 2026-09-04 | ⭐⭐⭐ **RULING RECORDED — `SRCHAO-F5` = OPTION A.** The human principal supplied an express ruling naming this act, in the `PRD-015` consolidated architecture completion pass: *"`SRCHAO-F5` = **OPTION A**"* — `F-5` = **Analyzer Property**; **Architecture Owner** is the authority; the analyzer **MUST consume** an authoritative **declared** script; the analyzer **MUST NOT** infer or detect script from content; index **and** query **MUST** use the **same** authoritative script source; ⛔ the script's actual **value** must **not** be invented. Recorded on the `PRD_OWNERSHIP_MODEL.md` **§12.1** per-act mechanism (*"filled for this act only by direct conferral from the human principal"*), as an **office** with ⛔ **no personal name** (**§7 rule 4**). **§11's four constraints tested against the supplied text: 3 satisfied outright, 1 satisfied AS TO KIND, 0 violated** — constraint 2 (content-derivation) ✅ **expressly PROHIBITED**; constraint 3 (index+query bound) ✅ **expressly BOUND**; constraint 4 (Option-B declarant) ✅ **NOT ENGAGED**; ⚠ constraint 1 (name the SOURCE) **satisfied as to kind only** — *"an authoritative declared script"* establishes that the value is **declared elsewhere and consumed**, ⛔ but the **declaring artefact is not named**, and re-measurement confirms **0** of §14A / `PRD-013` / `PRD-017` / `PRD-023` declares a script for any field it owns ⇒ **the declaring artefact does not yet exist**, disclosed as residual blocker **B1** in the consolidated record. ⭐ **Recorded consequences:** `SRCH-XC-001` is **NOT engaged** (an analyzer property is not a §14A field, so §14A stays **FROZEN** and byte-unchanged); ⭐⭐ `AR-1`'s **seven owning contexts are NOT intruded upon**, and its rule *"Discovery **references, never duplicates**"* is undisturbed; ⭐⭐ the ruling is **stronger** than `SRCHPO-2` **L58** because it prohibits **script** inference expressly, closing the `P2`-record gap that *script* detection and *language* detection are different objects; ⭐⭐⭐ the **"Model A" attacker-influenceable script surface** (`P2` record **L878**) is **eliminated**, and the **query-side asymmetry** (`P2` record **L448** — *"the query side has **no field at all**"*) is **cured** by binding both sides to one source; **Option C both limbs remain REJECTED**, `C-2` now by **express prohibition**. ⛔ **The ruling decides `F-5` ONLY.** It does **not** supply a script value, does **not** name the declaring artefact, does **not** decide `P2-D` (it **unblocks** and **constrains** it), and ⛔ **does NOT confer Stage 3** — `ADR-0033` **§7.1**, *"**A conferral for one act is not a standing licence**"*, with `SRCHCL-X1`'s *"an office is not an act."* ⛔ **0 script values, 0 rules, 0 units, 0 thresholds, 0 owners, 0 personal names, 0 BCs, 0 edges, 0 APIs, 0 ADRs, 0 `IMPL-*`, 0 code and 0 new identifiers created; `SRCHAO-F5` reused, not re-minted.** ⛔ **Subject byte-unchanged; every frozen PRD/ADR and baseline byte-unchanged; registry L315 still `PLANNED`; Stage 4/5/6/7 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked.** ⭐ **`F-5` = CLOSED. STAGE 3 = NOT CONFERRED.** |

---

**END OF PACKET**

⭐ **CLASSIFICATION: OPTION A — the declared script is an ANALYZER property.**
⭐ **HUMAN DECISION: RECORDED — 11 of 11 fields completed from the supplied ruling.**
⭐ **CONFERRAL: CONFERRED — scope *this act only*, `ADR-0033` §7.1.**
⛔ **`P2-D`, `P2-B`, `P2-C`, `P2U`, `P2-A`, `P3`, `P4`, `P1`, `P7`, `P8`, `ENT`, `VOC`, `R1`, `R2`: NOT DECIDED.**
⛔ **STAGE 3: NOT CONFERRED.**

⭐ Full audit: [`PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md`](PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md)
