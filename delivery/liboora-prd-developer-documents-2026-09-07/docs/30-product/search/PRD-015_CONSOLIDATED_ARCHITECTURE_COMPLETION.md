# PRD-015 — CONSOLIDATED ARCHITECTURE COMPLETION PASS

| Field | Value |
|---|---|
| **Document** | `PRD-015` **consolidated architecture completion record** — one record for all remaining architecture decisions |
| **Subject** | `docs/30-product/search/PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` |
| **Scope** | `F-5` · `P2-D`/`P2-B`/`P2-C`/`P2U`/`P2-A` · `P3` · `P4` · `P1` · `P5` · `P6` · `P7` · `P8-A`/`B`/`C`/`D` · `ENT` · `VOC` · `R1` · `R2` · consolidated Security+QA · Stage 3 re-run |
| **Type** | ⭐ **ONE consolidated decision record** (rule 9). ⛔ **NOT an ADR.** ⛔ **NOT a freeze, baseline or rank act** |
| **Rank** | ⛔ **NONE.** This record holds no rank and confers none |
| **Records a conferred decision?** | ⭐ **YES — exactly one:** `SRCHAO-F5` = **OPTION A**, supplied by the human principal in this pass |
| **Date** | 2026-09-04 |
| **Version** | v1.0 |

---

## WHAT THIS RECORD IS NOT

⛔ It does **not** invent a script value, a normalization rule, a counting unit, a tokenizer, a numeric threshold, an NFR value, an engine, a vendor, an owner, a role, a person, a BC, an edge, an API, an event, an ADR, an `IMPL-*`, or code.
⛔ It does **not** modify a frozen PRD, a frozen ADR, a baseline, the registry, or the `PRD-015` subject.
⛔ It does **not** enter Stage 4, 5, 6 or 7. It does **not** freeze, baseline or rank `PRD-015`.
⛔ It does **not** confer Stage 3.
⛔ It does **not** treat the `F-5` conferral as a standing licence — `ADR-0033` **§7.1**: *"**A conferral for one act is not a standing licence.**"*

⭐ **Every decision below is marked `CLOSED` / `OPEN` / `BLOCKED` / `PARALLEL` with its repository authority.** Where authority is absent, the item is marked **HUMAN DECISION REQUIRED** rather than guessed (rule 8).

---

## READING KEY

| Register | Meaning |
|---|---|
| `FACT` | Quoted or measured directly from a repository file this pass |
| `MEASURE` | The result of a search executed this pass, reported whether or not it helps |
| `RULING` | The conferred human decision supplied in this pass, recorded verbatim |
| `ANALYSIS` | Reasoning over `FACT`/`MEASURE`. ⛔ Never a decision |
| `⛔ ABSENT` | Measured zero authority. ⛔ Not filled by invention |

---

## 1. STEP 1 — INTEGRITY

| # | Gate | Result |
|---|---|---|
| I1 | Subject sha256 | ✅ `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **MATCH** |
| I2 | Branch | ✅ `main` |
| I3 | `HEAD` at pass start | ✅ `b5aac07` — *"docs(PRD-015): F-5 architecture owner classification decision packet"* |
| I4 | Working tree at pass start | ✅ **CLEAN** |
| I5 | `github/main` parity at pass start | ✅ `b5aac07` — ahead/behind **0 / 0** |
| I6 | Remotes | ✅ `github` = `https://github.com/sittuazad05022000-spec/Liboora-.git`; `genspark`. ⛔ **No `origin`** |
| I7 | Prior `PRD-015` decision records enumerated | ✅ **10** records + subject; `F5_CLASSIFICATION_DECISION_PACKET` (604 L), `F5_OWNERSHIP_RULING` (721 L), `COMPLETE_DEPENDENCY_RESOLUTION` (890 L), `P2_ARCHITECTURE_DECISION` (1103 L), `P4_ARCHITECTURE_DECISION` (682 L), `STAGE3_CLOSURE_ASSESSMENT` (514 L), `PO_DECISION_RESOLUTION_RECORD` (511 L), `ARCHITECTURE_ALIGNMENT` (1239 L), `ARCHITECTURE_OWNER_DECISION_PACKET` (692 L), `FINAL_ARCHITECTURE_DECISION_PREPARATION` (757 L) |
| I8 | Registry status | ✅ `PRD_REGISTRY.md` **L315** — `PRD-015` still `PLANNED`. ⛔ Unchanged by this pass |

⭐ **Integrity: 8 of 8 PASS. 0 findings.**

---

## 2. STEP 2 — `F-5` — THE CONFERRED RULING, RECORDED

### 2.1 The ruling as supplied

`RULING` — the human principal's instruction in this pass, section *"HUMAN DECISION PROVIDED"*, recorded verbatim:

> **"SRCHAO-F5 = OPTION A"**
>
> - `F-5` = Analyzer Property
> - Architecture Owner is the authority.
> - Analyzer **MUST** consume an authoritative declared script.
> - Analyzer **MUST NOT** infer/detect script from content.
> - Index और query **MUST** use the same authoritative script source.
> - Script का actual value invent मत करो।

⭐ **This is an express grant naming its act.** It is the same form the repository has always used for a per-act conferral — `PRD_OWNERSHIP_MODEL.md` **§12.1** (*"filled for this act only by direct conferral from the human principal"*), on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 precedent, and the `PRD-008_STAGE3_CONFERRAL.md` **L8** pattern.

⛔ **No personal name is recorded**, per `PRD_OWNERSHIP_MODEL.md` **§7 rule 4** — *"**Never** record a personal name."* The authority is recorded as an **office**: Architecture Owner (ARB).

### 2.2 The four constraints the ruling had to satisfy — tested, not assumed

The `F-5` packet §11 fixed four constraints on any lawful ruling. Each is now tested against the supplied text.

| # | Constraint | Supplied text relied upon | Verdict |
|---|---|---|---|
| **1** | *"It MUST name the SOURCE of the script value."* | *"Analyzer MUST consume an **authoritative declared script**"* | ⚠ **SATISFIED AS TO KIND, NOT AS TO ARTEFACT.** The ruling establishes that the value is **declared elsewhere and consumed**, ⛔ but it does **not** identify **which** repository artefact declares it. See §2.4 |
| **2** | *"It MUST state whether content-derivation is permitted."* | *"Analyzer **MUST NOT** infer/detect script from content"* | ✅ **SATISFIED — expressly and negatively.** Content-derivation is **PROHIBITED** |
| **3** | *"It MUST bind the INDEX side and the QUERY side in the SAME act."* | *"Index और query **MUST** use the **same** authoritative script source"* | ✅ **SATISFIED — expressly.** Both sides bound in one clause |
| **4** | *"Under OPTION B it MUST state WHICH authority declares."* | Option B **not selected** | ✅ **NOT ENGAGED** — constraint is conditional on Option B |

⭐ **3 of 4 satisfied outright; 1 satisfied as to kind with a disclosed residual. 0 constraints violated.**

### 2.3 What the ruling closes

`ANALYSIS` — the `F-5` question as posed by the packet was a **classification** question: *is the declared script an analyzer property (Architecture Owner) or a §14A field-schema property (Product Owner)?* That question is now answered.

| Consequence | Basis |
|---|---|
| ⭐ **`F-5` classification = ANALYZER PROPERTY** | The ruling, limb 1 |
| ⭐ **Authority = Architecture Owner (ARB)** | The ruling, limb 2; corroborated by `SRCH-GAP-002` subject **L980** (*"analyzer config … Architecture Owner"*) and PO record **L101** (*"Analyzer configuration for the declared scripts │ **Architecture Owner**"*) |
| ⭐ **`SRCH-XC-001` is NOT engaged** | An analyzer property is not a §14A field, so `BC-23` is not defining, altering or restating a §14A field. §14A remains **byte-unchanged** and **FROZEN** |
| ⭐⭐ **`AR-1`'s seven owning contexts are NOT intruded upon** | Under Option A the script is an analyzer parameter, ⛔ not a field-schema addition to fields owned by `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`. `AR-1`'s rule *"each field remains owned by its existing context — Discovery **references, never duplicates**"* is **not disturbed** |
| ⭐⭐ **The `SRCHPO-2` prohibition survives intact** | The ruling's limb 4 is **stronger** than `SRCHPO-2` **L58** (*"⛔ Do not invent language detection"*): it prohibits **script** inference expressly, closing the gap the `P2` record flagged — that *script* detection and *language* detection are different objects and the prohibition could not be assumed to transfer |
| ⭐⭐ **`SRCHAO-P2d`'s "Model A" inference limb is ELIMINATED** | `P2` record **L878**: *"Script determination is **attacker-influenceable** input under Model A."* The ruling forbids content-derivation ⇒ **that attack surface is closed by the ruling itself.** See §6 limb 5 |
| ⭐ **Option C both limbs remain REJECTED** | `C-1` (permanently undefined) is inconsistent with a ruling that requires consumption of a declared script; `C-2` (analyzer infers) is now **expressly prohibited** by limb 4, in addition to the pre-existing `SRCHPO-2` / `SRCHPO-X6` / `SRCH-BR-011` grounds |

⭐ **`F-5` = CLOSED.**

### 2.4 What the ruling deliberately does NOT supply — recorded, not filled

`FACT` — the ruling's own final limb: *"Script का actual value invent मत करो।"*

| Residual | Status |
|---|---|
| ⭐ **The script VALUE for any field** | ⛔ **NOT SUPPLIED and NOT INVENTED.** Expressly prohibited by the ruling's own terms |
| ⭐⭐ **WHICH artefact is the "authoritative declared script" source** | ⛔ **NOT NAMED by the ruling.** `MEASURE` (re-run this pass): `PRD-013`, `PRD-017`, `PRD-023` and §14A declare **no** script for any field they own. ⇒ The declaring artefact **does not yet exist**. This is a **residual of `SRCHAO-F5`**, disclosed here; ⛔ **no artefact is nominated and no new identifier is minted** |
| **Script-aware vs uniform normalization** | ⛔ **NOT decided by the ruling** — that is `P2-D`'s question, not `F-5`'s. See §3.1 |

⚠⚠ ⭐ **Honest consequence.** Because the declaring artefact is unnamed, `SRCH-FR-024`'s predicate *"where compatible with the field's declared script and language scope"* is now **classified and constrained** but still **not evaluable** on any concrete field. `SRCH-AC-050` therefore remains unsatisfiable (§6 limb 3). ⛔ **This pass does not repair that by invention.**

### 2.5 Where the ruling is recorded

Per instruction step 2 (*"record the supplied Option A ruling in the existing F-5 record"*) and rule 9 (⛔ no new file per small decision), the ruling is recorded in **two** places and **no third file is created**:

1. **`PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md` §11** — the existing `SRCHAO-F5` form, its 11 human fields completed from the supplied text. ⛔ **No new identifier minted;** `SRCHAO-F5` is the existing identifier.
2. **This consolidated record** — §2, as the authority relied upon by §3–§7.

⛔ `PRD-015_F5_OWNERSHIP_RULING.md` is **not** modified — it is the historical category-E finding record and its content is unaffected by the ruling.

---

## 3. STEP 3 — `P2`, ALL ITEMS TOGETHER

⭐ **All five `P2` items are audited in one pass, as instructed.** The `F-5` ruling changes the status of some and not others; both outcomes are reported.

### 3.1 `P2-D` — script-aware vs uniform normalization

| Field | Value |
|---|---|
| **Question** | Is normalization **script-aware** or **uniform** across the V1 scripts? |
| **Prior status** | ⛔ **BLOCKED** on `F-5` — `P2` record **L878**, **L741** (*"`P2-D` is not decidable before that"*) |
| ⭐ **Effect of the ruling** | **UNBLOCKED as to authority.** `F-5` is answered; the Architecture Owner is the authority; the *inference* limb is eliminated (§2.3) |
| **Authority for the model choice itself** | ⛔ **ABSENT.** The ruling constrains the **source** of the script, ⛔ it does **not** choose script-aware vs uniform |
| **Status** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⭐ **Narrowing achieved by the ruling, recorded precisely.** Any script-aware model may now key **only** off an authoritative declared source, and **must** use the **same** source at index and query time. A model that derives script from content is **no longer available**. ⛔ **This is a constraint on the answer, not the answer.**

### 3.2 `P2-B` — Devanagari case folding (`N1`)

| Field | Value |
|---|---|
| **Question** | Is `N1` case folding **declared not applicable** to Devanagari, or allowed to silently no-op? |
| **Authority** | ⛔ **ABSENT.** `MEASURE` re-run this pass: `grep -rniE "case fold\|casefold\|Devanagari" docs/ -l \| grep -v PRD-015` → **0 files**. ⭐ *Devanagari* appears **only** in `PRD-015` decision records, ⛔ in **no specification text**, including ⛔ not the subject |
| **Dependency** | `P2-D` = **REQUIRED** (`P2` record **L876**). `P2-D` is `OPEN` ⇒ `P2-B` cannot resolve |
| **Status** | ⛔ **BLOCKED** on `P2-D` — **HUMAN DECISION REQUIRED** (Architecture Owner) |

⚠ `F-5` no longer blocks `P2-B`; `P2-D` does. ⛔ **No Devanagari case-folding rule is invented.**

### 3.3 `P2-C` — `ZWJ` / `ZWNJ` under `N6`

| Field | Value |
|---|---|
| **Question** | Blanket removal under `N6`, or a **named exception** for `U+200C`/`U+200D`? |
| **Authority — direction** | ⚠ **PARTIAL, and settled.** `N6` subject **L425** *"Removal of zero-width, control and formatting characters"*; `E6` **L945** *"`N6` removes it — ⛔ it cannot create an unmatchable name"* |
| **Authority — exception** | ⛔ **ABSENT.** `MEASURE` re-run: `grep -rniE "ZWJ\|ZWNJ\|zero.width" docs/ -l \| grep -v PRD-015` → **0 files**. ⛔ **No code point is named anywhere** |
| **Authority — `N6` × `N4` order** | ⛔ **ABSENT.** §16 is a **table of rules**, ⛔ not a declared pipeline sequence |
| ⭐ **Why `SRCH-BR-008` cannot decide it** | **Both limbs are symmetric.** Blanket removal is symmetric; a named exception applied to both sides is also symmetric. ⇒ `SRCH-BR-008` does **not** choose between them; the trade is **collision risk vs spoofing surface** |
| **Status** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner **+** Security) |

⛔ **`N6` is NOT modified. No code point, no exception and no pipeline order is asserted.**

### 3.4 `P2U` — the counting / measurement unit

| Field | Value |
|---|---|
| **Question** | What **unit** counts a normalized character or token length? |
| **Authority** | ⛔ **ABSENT — measured 0.** `MEASURE` re-run this pass: `grep -rniE "code point\|codepoint\|scalar value\|UTF-16\|code unit\|grapheme" docs/ -l \| grep -v PRD-015` → **0 files** |
| **Dependency** | `P2-D` = **REQUIRED** (`P2` record **L879**). `P2-D` is `OPEN` |
| **Status** | ⛔ **BLOCKED** on `P2-D`, **and independently 0-authority** — **HUMAN DECISION REQUIRED** (Architecture Owner) |

⭐ **Consequence carried forward:** `P3` and `P4` are numeric limits over a unit that does not exist. See §4.

### 3.5 `P2-A` — analyzer / tokenizer configuration source

| Field | Value |
|---|---|
| **Question** | Where do the normalization rules **live** — declared in `BC-23`, or delegated to an engine? |
| **Authority — constraints** | ⚠ **CONSTRAINING, not deciding.** `SRCH-FR-023` **L414** *"by the same **declared rule set**"*; `SRCH-BR-008` totality **L427**; `SRCH-AC-050` *"each rule is checked"*; `SRCH-FR-034` determinism |
| **Authority — tokenizer** | ⛔ **EXPRESSLY WITHHELD.** `SRCHPO-5` (PO record **L74**): *"⛔ The **tokenizer algorithm** is deliberately **not** defined (§3.2)"* |
| **Dependency on `F-5`** | ⛔ **NONE** — `P2-A` was blocked on **its own** evidence (`P2` record **L875**), not on `F-5` |
| **Status** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⭐ **The ruling does add one binding constraint to `P2-A`:** whatever configuration source is chosen, it **must** consume the script declaration rather than compute it, and **must** be the **same** source on both sides. ⛔ That does not choose between a `BC-23`-declared set and an engine-delegated set.

### 3.6 `P2` roll-up

`ANALYSIS` — the `P2` record's §13 handoff listed **7 of 7** items NOT DELIVERED. Re-tested this pass:

| # | Handoff item | Status after the `F-5` ruling |
|---|---|---|
| 1 | `N1`–`N6` enumerable, deterministic, **total** over both scripts | ⛔ **STILL NOT DELIVERED** — totality needs an evaluable predicate; the declaring artefact is unnamed (§2.4) |
| 2 | Tokenization boundary per script (`N5`) | ⛔ **STILL NOT DELIVERED** — `SRCHPO-5` withholds it |
| 3 | Counting unit | ⛔ **STILL NOT DELIVERED** — `P2U`, 0 authority |
| 4 | Index/query symmetry provable per rule | ⚠ ⭐ **MATERIALLY ADVANCED, not delivered.** The ruling binds both sides to the **same** source — which is exactly what `P2` record **L448** found missing (*"the query side has **no field at all**"*). ⛔ Still not provable while the source is unnamed |
| 5 | Devanagari treatment (10 features) | ⛔ **STILL NOT DELIVERED** — 0 authorities |
| 6 | `ZWJ`/`ZWNJ` + `N6`×`N4` order | ⛔ **STILL NOT DELIVERED** |
| 7 | ⭐ **Script policy — does a field have a declared script, and who declares it?** | ⭐ **PARTIALLY DELIVERED — the "who" is now ANSWERED.** `F-5` = analyzer property, Architecture Owner. ⛔ The **artefact** and the **value** remain absent |

⭐ **`P2` STATUS = BLOCKED, but one of seven handoff items is now partially delivered and item 4 is materially advanced. `P2` = 0 items CLOSED.**

---

## 4. STEP 4 — `P3` AND `P4`

⛔ **Rule applied literally:** *"Do not derive numbers from examples or unrelated constants."* `LCFG-12` = 20 and `LCFG-6` = 60 s are **unrelated constants** (page size and propagation latency) and are **not** used to derive `P3` or `P4`. The `SRCH-AC-030` illustration `Lib` → `Library` is an **example** and is **not** used to derive a minimum prefix length of 3.

### 4.1 `P3` — edit-distance bound and minimum token length

| Field | Value |
|---|---|
| **Required to exist by** | `SRCH-BR-012` **C2**, **C3** (subject **L837**, **L561**) |
| **Authority** | ⛔ **ABSENT — measured 0.** `MEASURE` re-run this pass: `grep -rniE "levenshtein\|edit.distance\|damerau\|fuzziness\|minimum token length\|min token length" docs/ -l \| grep -v PRD-015` → **0 files** |
| **Dependencies** | `P2` = **REQUIRED** (token determinacy); `P2U` = **REQUIRED** (what "length" counts) |
| **Status** | ⛔ **BLOCKED** on `P2` / `P2U`, **and independently 0-authority** — **HUMAN DECISION REQUIRED** (Architecture Owner) |

⛔ **No edit-distance bound and no minimum token length is decided, proposed or recommended.**

### 4.2 `P4` — minimum prefix length

| Field | Value |
|---|---|
| **Required to exist by** | `SRCH-FR-030` (subject **L838**, **L518**) |
| **Authority** | ⛔ **ABSENT — measured 0.** `MEASURE` re-run: `grep -rniE "minimum prefix\|prefix length" docs/ -l \| grep -v PRD-015` → **0 files** |
| **Dependencies** | `P2U` = **REQUIRED**; `P2-D` = **REQUIRED** |
| **Status** | ⛔ **BLOCKED — twice over** (no unit **and** no determinate token) — **HUMAN DECISION REQUIRED** (Architecture Owner) |

⛔ **`P4` VALUE: NOT DECIDED. `P4` remains blocked, exactly as `PRD-015_P4_ARCHITECTURE_DECISION.md` L11 recorded.**

---

## 5. STEP 5 — REMAINING ARCHITECTURE DECISIONS

### 5.1 `P1` — search engine / index technology

| Field | Value |
|---|---|
| **Required to exist by** | §0.3 (subject **L836**) |
| ⭐⭐ **Classification authority** | `MASTER_PRD.md` **L238** `MP-CON-02` — *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the 25 approved platforms into a vendor's feature list."* |
| **Binding architecture constraints (authoritative)** | `MP-CON-01` **L237** *"No vendor name may appear in domain code. Vendors live behind ports"*; `MP-CON-03` **L239** *"The Data Layer must remain abstract"* |
| **Engine named anywhere** | ⛔ **NONE.** ⛔ No engine is nominated by this record |
| **Dependency** | ⛔ **NO DEPENDENCY** on `P2`/`P4` — dependency record **L100**: *"`P1` is `NO DEPENDENCY` on the merits, not merely unproven"* |
| **Status** | ⭐ **PARALLEL** — the **architecture** limb is authoritative and satisfied (ports/abstraction); the **selection** limb is a **deployment** act per `MP-CON-02`, ⛔ not an architecture decision to be made here |

⚠ **Disclosed tension, not resolved by invention:** §36 lists `P1` inside `SRCH-GAP-002`, whose owner is the Architecture Owner, while `MP-CON-02` (Rank 1) classifies engine choice as **deployment**. Rank 1 outranks a Stage-2 draft's gap register. ⇒ `P1` is recorded **PARALLEL**, ⛔ **not CLOSED**, because the two texts have not been reconciled by an authority.

### 5.2 `P5` — maximum page size cap

| Field | Value |
|---|---|
| **Required to exist by** | `SRCH-FR-039` (subject **L839**) |
| ⭐ **Authority** | `CONFIGURATION_GUIDE.md` **L362** — `\| LCFG-12 \| Public search page size \| **20** \| 5 – 50 \| **Security** \| Bounds enumeration rate and page weight \|`; tiering corroborated at **L804**; monitoring at **L884-885** |
| **Value** | **20**, range **5–50**, owner **Security** |
| **Dependency** | ⛔ **NO DEPENDENCY** (dependency record **L100**) |
| **Status** | ✅ ⭐ **CLOSED** — the value **already exists** in a Rank-7 configuration authority. ⛔ **Nothing invented; the existing value is cited, not restated as new** |

### 5.3 `P6` — acceptable projection lag per event class

| Field | Value |
|---|---|
| **Required to exist by** | §32 (subject **L840**), *"except `SEV-9`, which has none"* |
| ⭐ **Authority** | `CONFIGURATION_GUIDE.md` **L356** — `\| LCFG-6 \| Discovery index propagation \| **60 s** \| 0 – 300 s \| **Security** \| Public index is eventually consistent. **Removal latency only** — see below \|`; **L372** *"`LCFG-6` — the value most likely to be misused"*; **L802** tiering |
| ⭐⭐ **Scope limit, quoted** | `Library_PRD_v1.md` **L721** — `LCFG-6` *"Applies **only** to Public→Private **removal latency**"* |
| **Value** | **60 s**, range **0–300 s**, owner **Security** — ⭐ **for the removal-latency class ONLY** |
| **Other event classes** | ⛔ **ABSENT.** No repository authority states a lag budget for any **other** event class |
| **Status** | ⚠ ⭐ **PARTIALLY CLOSED** — removal-latency limb **CLOSED** with authority; all other event classes **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⭐ **The instruction's own parenthetical — *"P6 existing `LCFG-6` (removal latency only)"* — is exactly what the repository supports.** ⛔ `LCFG-6` is **not** generalised to other event classes by this record.

### 5.4 `P7` — query latency, throughput and availability targets

| Field | Value |
|---|---|
| **Required to exist by** | §36 (subject **L841**) |
| **Subject's own position** | `FACT` subject **L823** — *"⚠⚠ **No performance target is stated in this document, and that is a deliberate refusal.**"* **L825** — *"no repository authority states a latency budget, throughput target, index-size limit, freshness SLO or availability target for `BC-23`"* |
| ⭐ **Enterprise Architecture re-measured** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L339-344** lists `NFR Budgets (V1)` → `Latency Budgets (V1)`, `Availability Targets (V1)`, `Throughput Targets (V2)`, `Cost Budgets (V2)`, `Mobile Performance Budgets (V1)`. ⭐⭐ **These are PLANNED CAPABILITY ENTRIES in a Rank-6 DESCRIPTIVE document. ⛔ They contain no values** |
| **Corroboration that no values exist** | EA **L195** *"production readiness is **earned by execution**"*; **L210** *"No SLOs, no error budgets"*; **L87** *"missing SLO/error-budget engineering"*; **L322** Service SLAs **(V3)**; **L1277** SLA Tracking **(Future)** |
| **Status** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⛔ **No latency, throughput, availability or freshness value is invented. Rule: *"Do not invent external NFR values."***

### 5.5 `P8` — rebuild posture and duration, four limbs

`FACT` — subject **L798-805**, §34 *Rebuild and recovery*.

| Limb | Question | Authority | Status |
|---|---|---|---|
| ⭐ **`P8-A`** | **Rebuildability** | ✅ `SRCH-INV-005` **L798** *"every index **MUST** be fully rebuildable from the event log"*, and BC Map **L453** requires this *"**tested quarterly, not assumed**"*. Reinforced by **L801-802** (a rebuilt index **MUST** be **equivalent** for matching and ordering; `SRCH-FR-034` determinism makes this checkable) and **L803-804** (rebuild **MUST NOT** re-admit removed documents — `SRCH-FR-011`/`012`/`013`/`014`) | ✅ ⭐ **CLOSED** — requirement, invariant, equivalence obligation and verification cadence all exist |
| **`P8-B`** | **Stale serving** during rebuild | ⛔ **EXPRESSLY WITHHELD.** Subject **L805**: *"Rebuild **availability posture** — whether search degrades, serves stale, or is unavailable during a rebuild — is an operational decision recorded in **`SRCH-GAP-002`**. ⛔ **Not decided here.**"* | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |
| **`P8-C`** | **Rebuild duration** | ⛔ **ABSENT.** §36 `P8` names *"rebuild availability posture **and duration**"* as a parameter required to **exist**; no duration is stated anywhere | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |
| **`P8-D`** | **Full vs incremental** rebuild policy | ⚠ **PARTIAL.** **L801-802** presuppose that **both** a rebuilt and an incrementally maintained index exist, and require them to be **equivalent**. ⛔ **No authority states when each is used** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⭐ **`P8` = 1 of 4 CLOSED (`P8-A`), 3 of 4 OPEN.** ⛔ **No posture, no duration and no rebuild-mode policy is invented.**

### 5.6 `ENT` — query-time entitlement mechanism

| Field | Value |
|---|---|
| **Authority** | `SRCH-GAP-003` subject **L981** — *"The mechanism by which a source system's entitlement decision is evaluated for an index document **at query time**"* │ **Architecture Owner** │ **Stage 3** │ §27 |
| **Mechanism stated** | ⛔ **NONE — expressly recorded as undecided** |
| **Related refusal** | `SRCHPO-X4` (PO record **L441**) — *"A logical authorization dependency justifies minting the `BC-23` → `BC-18` edge"* → ⛔ **REJECTED**; BC Map **L292**; Rank 4 ⇒ ADR first |
| **Status** | ⛔ **OPEN — HUMAN DECISION REQUIRED** (Architecture Owner) |

⛔ **No entitlement mechanism, no `BC-23` → `BC-18` edge, no API and no event is created.**

### 5.7 `VOC` — language/script inventory and vocabulary

| Field | Value |
|---|---|
| **Authority** | `SRCH-GAP-007` subject **L985** — *"The language/script inventory and the declared variant/abbreviation vocabulary for §16 and §20"* │ **Product Owner (markets) + Architecture Owner (analyzer)** │ **Stage 3** |
| ⭐ **Inventory limb** | ✅ **CLOSED** by `SRCHPO-1` (PO record **L57**) — *"V1 canonical supported languages/scripts = exactly two: English (Latin script) and Hindi (Devanagari script). This is a **closed set** for V1"* |
| **Vocabulary limb** | ⛔ **ABSENT** — no variant/abbreviation vocabulary exists |
| **Analyzer limb** | ⛔ **ABSENT** — PO record **L109-113**: *"`SRCHPO-1` now supplies that scope… ⛔ It does **not** supply the folding table itself, **which is `P2`**"* |
| **Prior over-claim refused** | `SRCHPO-X2` (PO record **L439**) — the claim that `SRCH-GAP-007` is **closed** was ⛔ **REJECTED** ⇒ **PARTIALLY CLOSED** |
| **Status** | ⚠ ⭐ **PARTIALLY CLOSED** — inventory limb closed; vocabulary and analyzer limbs **OPEN — HUMAN DECISION REQUIRED** (split: Product Owner + Architecture Owner) |

⛔ **No vocabulary, no synonym list, no abbreviation table and no transliteration rule is invented.**

### 5.8 `R1` — tenant data reaching the public index

| Field | Value |
|---|---|
| **Text** | Dependency record **L637** — *"Tenant data reaching the public index — ⭐⭐ **'Highest in the architecture'** (`AR-3`)"* |
| **Mitigations (all pre-existing)** | `SRCH-INV-004` subject **L324** *"⭐⭐ **Tenant Operational Data MUST NEVER enter the Platform Public Discovery Index**"*; `SRCH-INV-002` **L286** *"A document **MUST** exist in exactly one index class"*; `SRCH-FR-006`; trace `T-J` **L930** *"Public-index purity"* |
| **Governing ruling** | `ARCHITECTURE_RULINGS.md` `AR-3` **L95-124** — *"**This approval must not weaken tenant isolation**"*; does not relax `MP-GBR-08`, `SE-1`, `X-13` |
| **Dependency** | ⛔ **NO DEPENDENCY** on `P2`/`P4` — dependency record **L96** `D-20`: *"`R1`'s mitigations are `SRCH-INV-004`/`002`, `SRCH-FR-006`, `T-J` — none is a `P*`"* |
| **Residual** | ⚠ *"**Implementation-verified, not document-verified**"* |
| **Status** | ⭐ **PARALLEL** — mitigations authoritative and complete **at the document level**; ⛔ **NOT CLOSABLE by documentation**, because its residual is an implementation-verification obligation and this pass writes **no code** |

### 5.9 `R2` — index as a silent authorisation bypass

| Field | Value |
|---|---|
| **Text** | Dependency record **L638** — *"Index becoming a silent authorisation bypass — ⭐⭐ Critical"* |
| **Residual** | *"`SRCH-GAP-003` — the entitlement-evaluation mechanism is **undecided**"* |
| **Dependency** | **REQUIRED** on `ENT` — dependency record **L95** `D-19` |
| **Gate applied** | The instruction permits `R2` *"only if `ENT` is resolved."* §5.6 measured `ENT` = **OPEN** |
| **Status** | ⛔ **BLOCKED** on `ENT`. ⛔ **Not audited further, per the instruction's own condition** |

---

## 6. STEP 6 — ONE CONSOLIDATED SECURITY + QA REVIEW

⭐ **One review, twelve named limbs, honest separation.** ⛔ No limb is upgraded to PASS to produce a tidier table.

| # | Limb | Finding | Verdict |
|---|---|---|---|
| **1** | **`BC-18` authorization boundary** | ⛔ No `BC-23` → `BC-18` edge exists; `SRCHPO-X4` **REJECTED** minting one (BC Map **L292**; Rank 4 ⇒ ADR first). The authorization boundary for query-time entitlement is therefore unestablished | ⛔ **BLOCKED** — on `ENT` / an ADR act |
| **2** | **Tenant isolation** | ✅ `SRCH-INV-004`, `SRCH-INV-002`, `SRCH-FR-006`, `T-J`, plus `AR-3`'s *"must not weaken tenant isolation"* and BC Map **L330** *"Search never reads domain tables"*. ⭐ Complete at the document level | ✅ **PASS** ⚠ residual **implementation-verified** (`R1`) |
| **3** | **Index / query symmetry** | `SRCH-FR-023` **L414** (*identically*, *same declared rule set*) and `SRCH-BR-008` **L427** (*symmetric and total*) are authoritative MUSTs. ⭐⭐ **The `F-5` ruling materially strengthens this limb** — it binds both sides to the **same authoritative script source**, curing the defect at `P2` record **L448** (*"the query side has **no field at all**"*). ⛔ But `SRCH-AC-050` iterates **per rule**, and `N1`–`N6` totality is still unprovable while the declaring artefact is unnamed (§2.4) and `P2-B`/`P2-C`/`P2U` are unresolved | ⛔ **BLOCKED** ⭐ *materially advanced by the ruling* |
| **4** | **Normalization collision risk** | ⚠ ⭐ Symmetric normalization can still collide **two distinct EXACT-tier identifiers**, and `SRCH-BR-008` does **not** catch it — symmetry is not injectivity. ⛔ No repository authority addresses collision | ⛔ **UNSUPPORTED** — no authority exists; ⛔ none invented |
| **5** | ⭐⭐ **Script trust boundary** | ⭐⭐⭐ **The one limb the ruling UPGRADES.** `P2` record **L878** found *"Script determination is **attacker-influenceable** input under Model A."* The ruling expressly prohibits content-derived script (*"Analyzer **MUST NOT** infer/detect script from content"*) and requires a **single** authoritative source for both sides ⇒ **that attack surface is closed by the ruling** | ✅ **PASS** ⚠ residual: the declaring artefact is **unnamed**, so its own trust properties are unverifiable (§2.4) |
| **6** | **Entitlement** | ⛔ `SRCH-GAP-003` — mechanism undecided (**L981**) | ⛔ **BLOCKED** |
| **7** | **Stale serving** | ⛔ Subject **L805** — *"⛔ **Not decided here**"*, routed to `SRCH-GAP-002` | ⛔ **BLOCKED** |
| **8** | **English + Hindi/Devanagari** | Latin: authoritative and tested (`SRCH-AC-024`). ⭐⭐ Devanagari: **0 specification authorities** across 10 features, and **0 acceptance coverage** — `SRCH-AC-024`'s cases (`central library`, `Central   Library`, `St Marys`, `Cafe`) are **all Latin**. ⚠ A **pre-existing** defect; the `F-5` ruling neither creates nor repairs it | ⛔ **BLOCKED** (Devanagari limb) · ✅ **PASS** (Latin limb) |
| **9** | **Hinglish / Romanized Hindi** | ✅ **Scope boundary is authoritative**: `SRCHPO-2` (**L58**) — supported *query behaviour* *"where technically validated"*, ⛔ **not** a third canonical language, ⛔ not a separate BC/index/system; `SRCHPO-X6` (**L443**) **REJECTED** the claim that Hinglish implies a transliteration/detection capability (`SRCH-BR-011` forbids inference from any learned model). ⛔ **Mechanism**: none exists | ✅ **PASS** (scope) · ⛔ **UNSUPPORTED** (mechanism) |
| **10** | **`ZWJ` / `ZWNJ`** | Direction settled by `N6` + `E6`. ⛔ No code point named, ⛔ no exception decided, ⛔ `N6`×`N4` order unspecified. ⭐ Both limbs symmetric ⇒ `SRCH-BR-008` cannot arbitrate; the trade is **collision vs spoofing** | ⛔ **BLOCKED** |
| **11** | **Typo / prefix / token behaviour** | ⛔ `P3` (edit distance, min token length), `P4` (min prefix length) and `P2U` (unit) all measured **0 authority** this pass. `SRCH-AC-054` (`SRCH-BR-012` C1–C5) cannot be executed against undefined bounds | ⛔ **BLOCKED** |
| **12** | **Irrelevant-query exclusion** | ✅ Authoritative and requirement-complete: subject **L487** *"An irrelevant document **MUST NOT** appear at any tier"*; §22.3 **L601** *"⭐⭐ T4 — irrelevant means **excluded, not ranked last**"* (`SRCH-BR-013`); §19.3 `SRCH-BR-010`; trace `T-F` **L926** *"no low-ranked irrelevant residue"*; **L432** *"nothing is loosened, so nothing irrelevant is admitted"*. ⛔ No `P*` dependency | ✅ **PASS** |

⭐ **Consolidated tally: PASS 4 full + 2 partial · BLOCKED 6 + 1 partial · UNSUPPORTED 2 + 1 partial.**
⭐⭐ **Exactly one limb moved this pass — limb 5, the script trust boundary — and it moved because the ruling expressly prohibited content inference. ⛔ No other limb is credited to the ruling.**

---

## 7. STEP 7 — STAGE 3, SIX ARCHITECTURE ALIGNMENT CHECKS RE-RUN

### 7.1 The six checks

`FACT` — re-read this pass from `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L50-55**.

| # | Check | Evidence | Result |
|---|---|---|---|
| 1 | `PRD-015` has all four roles assigned; Architecture Owner = `ARB` | `PRD_OWNERSHIP_MODEL.md` **L197** | ✅ **PASS** |
| 2 | `PGA-08` closed in its role-assignment reading | ownership model header; `docs/README.md` **L67** | ✅ **PASS** |
| 3 | `ARB` and *Architecture Owner* are the **same** authority | §2.3 — *"**They are not two authorities.**"* | ✅ **PASS** |
| 4 | The Architecture Owner is the correct approving role | §5 / **L284** — *"**Only the Architecture Owner approves.**"* | ✅ **PASS** |
| 5 | The role reaches `PRD-015` without a further assignment act | §3 rule 2 — *"platform-wide by construction"* | ✅ **PASS** |
| 6 | `PLANNED` status does not deprive `PRD-015` of an owner | §3 rule 4 | ✅ **PASS** |

⭐ **6 of 6 PASS — on the OWNERSHIP question.** ⛔ **That is not Stage 3 conferral.**

### 7.2 Why Stage 3 is still NOT CONFERRED — two independent grounds

**Ground 1 — the conferral is per-act, and this act was `F-5`.**

`FACT` — `ADR-0033` **§7.1**: *"**A conferral for one act is not a standing licence.**"* Quoted again at `ADR-0050` **L291**, `ADR-0052` **L192**, `ADR-0098`.
`FACT` — `SRCHCL-X1` (Stage-3 assessment **L425**) was ⛔ **REJECTED**: *"an office is not an act… **Having an owner is limb C's precondition, not limb C.**"*

`ANALYSIS` — the ruling supplied in this pass is an express conferral **naming its act**: `SRCHAO-F5`. It is lawful and it is spent on `F-5`. ⛔ It does **not** name Stage 3, does **not** name Architecture Reviewer authority, and does **not** grant conferral of a lifecycle stage. Treating it as a Stage-3 grant would be exactly the standing-licence error `ADR-0033` §7.1 forbids.

**Ground 2 — the substantive Stage-3 blockers are still open, independently of any conferral.**

`FACT` — subject **L843-844**: *"**Owner: Architecture Owner.** ⛔ **Blocks Stage 3 architecture review**; blocks nothing in Stage 2."*
`FACT` — `SRCH-GAP-002` **L980** and `SRCH-GAP-003` **L981** both carry `Blocks` = **Stage 3**. `SRCH-GAP-007` **L985** likewise.

`ANALYSIS` — of the eight `SRCH-GAP-002` parameters, **`P5` is closed**, **`P6` is partially closed**, **`P8-A` is closed**, **`P1` is classified as a deployment act**, and **`P2`, `P3`, `P4`, `P7`, `P8-B`/`C`/`D` remain open**. `SRCH-GAP-002` is therefore **not closed**, and it expressly blocks Stage 3. `SRCH-GAP-003` is open. `SRCH-GAP-007` is partially closed. ⛔ **Even a lawful Stage-3 conferral could not be exercised to a PASS on this evidence.**

### 7.3 Stage 3 verdict

| Field | Value |
|---|---|
| **Six alignment checks** | ✅ **6 of 6 PASS** (ownership question) |
| **Stage 3 assessment** | ⚠ **CONDITIONAL** |
| **Stage 3 conferral** | ⛔ **NOT CONFERRED** |
| **Grounds** | (1) `ADR-0033` §7.1 — the `F-5` conferral is spent on `F-5`; (2) `SRCH-GAP-002`/`-003`/`-007` remain open and expressly block Stage 3 |

⛔ **Stage 3 is NOT conferred, NOT claimed and NOT implied. `PRD-015` is NOT frozen, NOT baselined, NOT ranked. Registry L315 remains `PLANNED`.**

---

## 8. CONSOLIDATED DECISION TABLE

| Decision | Status | Authority |
|---|---|---|
| ⭐ **`F-5`** | ✅ **CLOSED** | ⭐ The human principal's ruling this pass — *"`SRCHAO-F5` = **OPTION A**"*; per-act conferral form `PRD_OWNERSHIP_MODEL.md` §12.1; corroborated subject **L980**, PO record **L101** |
| **`P2-D`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | Unblocked by `F-5`; ⛔ model choice has **no** authority. Architecture Owner |
| **`P2-B`** | ⛔ **BLOCKED** on `P2-D` | ⛔ 0 Devanagari authority (measured 0 files) |
| **`P2-C`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | Direction fixed by `N6`+`E6`; ⛔ 0 code-point authority. Architecture Owner **+** Security |
| **`P2U`** | ⛔ **BLOCKED** on `P2-D` | ⛔ 0 authority (measured 0 files) |
| **`P2-A`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | `SRCH-FR-023`/`BR-008`/`AC-050`/`FR-034` constrain; `SRCHPO-5` withholds the tokenizer |
| **`P3`** | ⛔ **BLOCKED** on `P2`/`P2U` | ⛔ 0 authority (measured 0 files). Required to exist by `SRCH-BR-012` C2/C3 |
| **`P4`** | ⛔ **BLOCKED** on `P2U`/`P2-D` | ⛔ 0 authority (measured 0 files). Required to exist by `SRCH-FR-030` |
| **`P1`** | ⭐ **PARALLEL** | `MP-CON-01`/`02`/`03` — architecture limb satisfied; selection is a **deployment** decision (`MASTER_PRD.md` **L238**) |
| **`P5`** | ✅ **CLOSED** | `CONFIGURATION_GUIDE.md` **L362** — `LCFG-12` = **20**, 5–50, **Security** |
| **`P6`** | ⚠ **PARTIALLY CLOSED** | `CONFIGURATION_GUIDE.md` **L356** — `LCFG-6` = **60 s**, 0–300 s, **Security**, ⭐ *removal latency only*; `Library_PRD_v1.md` **L721**. Other event classes **OPEN** |
| **`P7`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | Subject **L823-825**; EA **L339-344** are **planned entries, no values**; EA **L195**/**L210** |
| **`P8-A`** | ✅ **CLOSED** | `SRCH-INV-005` **L798** + BC Map **L453** *"tested quarterly, not assumed"* + **L801-804** |
| **`P8-B`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | Subject **L805** — *"⛔ **Not decided here**"* |
| **`P8-C`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | §36 `P8` requires it to exist; ⛔ 0 authority |
| **`P8-D`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | **L801-802** presuppose both modes; ⛔ no selection policy |
| **`ENT`** | ⛔ **OPEN** — HUMAN DECISION REQUIRED | `SRCH-GAP-003` **L981**; `SRCHPO-X4` refused the `BC-18` edge |
| **`VOC`** | ⚠ **PARTIALLY CLOSED** | `SRCH-GAP-007` **L985**; inventory closed by `SRCHPO-1` **L57**; `SRCHPO-X2` refused full closure |
| **`R1`** | ⭐ **PARALLEL** | `SRCH-INV-004`/`002`, `SRCH-FR-006`, `T-J`, `AR-3`; `D-20` ⛔ no dependency; residual **implementation-verified** |
| **`R2`** | ⛔ **BLOCKED** on `ENT` | `D-19` **REQUIRED**; instruction's own gate not met |

⭐ **Tally: CLOSED 4 · PARTIALLY CLOSED 2 · PARALLEL 3 · OPEN 7 · BLOCKED 4.**

---

## 9. REMAINING BLOCKERS — ALL TOGETHER

| # | Blocker | Owner | Blocks |
|---|---|---|---|
| **B1** | ⭐⭐ **The artefact that supplies the "authoritative declared script" does not exist.** The `F-5` classification is settled; the declaring artefact is unnamed and the value is deliberately not supplied | Architecture Owner (residual of `SRCHAO-F5`) | `P2-D` evaluability · `SRCH-AC-050` · limb 3 |
| **B2** | `P2-D` — script-aware vs uniform normalization | Architecture Owner | `P2-B` · `P2U` · `P4` |
| **B3** | `P2-B` — Devanagari `N1` applicability (declared-not-applicable vs silent no-op) | Architecture Owner | Devanagari correctness · limb 8 |
| **B4** | `P2-C` — `ZWJ`/`ZWNJ` named exception **and** the `N6`×`N4` order | Architecture Owner + Security | limb 10 |
| **B5** | `P2U` — the counting unit | Architecture Owner | `P3` · `P4` |
| **B6** | `P2-A` — analyzer configuration source and the `N5` boundary | Architecture Owner | `SRCH-AC-050` enumerability |
| **B7** | `P3` — edit-distance bound and minimum token length | Architecture Owner | limb 11 · `SRCH-AC-054` |
| **B8** | `P4` — minimum prefix length | Architecture Owner | limb 11 |
| **B9** | `P6` — projection lag for event classes **other than** removal latency | Architecture Owner | §32 completeness |
| **B10** | `P7` — latency, throughput, availability | Architecture Owner | §36 · Stage 3 |
| **B11** | `P8-B`/`C`/`D` — stale-serving posture, duration, full-vs-incremental | Architecture Owner | §34 · limb 7 |
| **B12** | `ENT` — query-time entitlement mechanism (`SRCH-GAP-003`) | Architecture Owner | `R2` · limbs 1, 6 |
| **B13** | `VOC` — variant/abbreviation vocabulary and the analyzer limb | Product Owner + Architecture Owner | §16 · §20 |
| **B14** | ⚠ **Normalization collision on distinct EXACT-tier identifiers** — no authority addresses it; `SRCH-BR-008` does not catch it | ⛔ **No owner measured** | limb 4 |
| **B15** | ⚠ **Devanagari acceptance coverage** — `SRCH-AC-024`'s cases are all Latin | Architecture Owner + QA | limb 8 |
| **B16** | `P1` classification tension — §36 routes engine choice to the Architecture Owner while Rank-1 `MP-CON-02` calls it a **deployment** decision | Architecture Owner | `P1` closure |
| **B17** | `R1` residual — *"implementation-verified, not document-verified"* | Technical Owner | Not closable by documentation |
| **B18** | `SRCH-GAP-001` — `PLANNED` → `DRAFT` transition needs conferred authority | Governance Owner | Stage-2 conferral |
| **B19** | ⛔ **Stage 3 conferral itself** — no grant naming `PRD-015` Stage 3 exists (`ADR-0033` §7.1) | Human principal | Stage 3 |
| **B20** | ⚠ **No `prd015_*` validator exists** in `tool/docs_check/` (32 entries) — disclosed, ⛔ not created | Technical Owner | Automated record verification |

⭐ **20 blockers, listed together. ⛔ No further prompt is requested for any of them.**

---

## 10. VALIDATION

| # | Check | Result |
|---|---|---|
| V1 | Subject sha256 unchanged | ✅ `fe3093e6…c2c4544` |
| V2 | Branch `main`; no amend, no rebase, no force-push | ✅ |
| V3 | `git diff --check` clean | ✅ |
| V4 | Files created | ✅ **1** — this record |
| V5 | Files modified | ✅ **1** — `PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md` §11 form + consistency lines (the *existing* `F-5` record, per instruction step 2) |
| V6 | §14A byte-unchanged (**FROZEN**) | ✅ |
| V7 | `PRD-023`, `PRD-013`, `PRD-017`, `Library_PRD_v1` byte-unchanged (**FROZEN**) | ✅ |
| V8 | `ARCHITECTURE_RULINGS.md`, BC Map, `MASTER_PRD.md`, `CONFIGURATION_GUIDE.md`, EA byte-unchanged | ✅ |
| V9 | `PRD_REGISTRY.md` byte-unchanged; **L315** still `PLANNED` | ✅ |
| V10 | `PRD_OWNERSHIP_MODEL.md` byte-unchanged | ✅ |
| V11 | ADR directory unchanged; **0** ADRs created; `ADR-0088`/`0089`/`0090` still RESERVED | ✅ |
| V12 | `DOCUMENTATION_BASELINE.md` byte-unchanged | ✅ |
| V13 | Other `PRD-015` records byte-unchanged (`F5_OWNERSHIP_RULING`, `COMPLETE_DEPENDENCY_RESOLUTION`, `P2`, `P4`, `STAGE3_CLOSURE_ASSESSMENT`, `PO_DECISION_RESOLUTION_RECORD`, `ARCHITECTURE_ALIGNMENT`, `ARCHITECTURE_OWNER_DECISION_PACKET`, `FINAL_ARCHITECTURE_DECISION_PREPARATION`) | ✅ |
| V14 | **0** BCs created | ✅ |
| V15 | **0** edges created — `BC-23` → `BC-18` **NOT** minted | ✅ |
| V16 | **0** APIs, **0** events created | ✅ |
| V17 | **0** `IMPL-*` created | ✅ |
| V18 | **0** code files touched — `lib/`, `test/`, `android/`, `web/`, `tool/`, `pubspec.yaml` untouched | ✅ |
| V19 | **0** values invented — no script value, no normalization rule, no counting unit, no edit distance, no prefix length, no latency, no throughput, no availability, no duration, no engine, no vendor | ✅ |
| V20 | **0** owners, roles, persons or authorities invented; **0** personal names recorded (§7 rule 4) | ✅ |
| V21 | **0** new identifiers minted — `SRCHAO-F5` **reused** | ✅ |
| V22 | Existing values **cited, not restated as new** — `LCFG-12` = 20 and `LCFG-6` = 60 s are referenced to their Rank-7 source | ✅ |
| V23 | ⛔ No number derived from an example or an unrelated constant — `Lib`→`Library`, `LCFG-12`, `LCFG-6` expressly **not** used for `P3`/`P4` | ✅ |
| V24 | Stage 4/5/6/7 **NOT** entered | ✅ |
| V25 | `PRD-015` **NOT** frozen, **NOT** baselined, **NOT** ranked | ✅ |
| V26 | Stage 3 = **CONDITIONAL / NOT CONFERRED** | ✅ |
| V27 | The `F-5` conferral **NOT** treated as a standing licence (`ADR-0033` §7.1) | ✅ |
| V28 | Every `OPEN`/`BLOCKED` item marked **HUMAN DECISION REQUIRED** rather than guessed | ✅ |
| V29 | ⚠ No `prd015_*` validator exists — **disclosed, not created** | ⚠ **DISCLOSED** |

---

## 11. CHANGE LOG

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-04 | **Created.** `PRD-015` **consolidated architecture completion** record — **one** record for all remaining architecture decisions, per rule 9 (⛔ no separate file per decision). **Integrity:** 8 of 8 gates PASS; subject sha256 **MATCH**; `HEAD` `b5aac07`; tree clean; `github/main` parity **0/0**. ⭐⭐⭐ **`SRCHAO-F5` RECORDED AS CONFERRED = OPTION A** from the human principal's express ruling this pass, on the `PRD_OWNERSHIP_MODEL.md` §12.1 per-act conferral mechanism, as an **office** with ⛔ **no personal name** (§7 rule 4). ⭐ **All four packet constraints tested: 3 satisfied outright, 1 (*name the SOURCE*) satisfied AS TO KIND with the residual disclosed — the ruling requires consumption of an "authoritative declared script" but ⛔ does NOT name which artefact declares it, and ⛔ the value is expressly not to be invented.** ⭐⭐ **Recorded that the ruling ELIMINATES the "Model A" attacker-influenceable script-inference surface (`P2` record L878) and CURES the query-side asymmetry (`P2` record L448) by binding index and query to the SAME source** — the only Security/QA limb that moved this pass. ⭐ **Recorded that `SRCH-XC-001` is NOT engaged and `AR-1`'s seven owning contexts are NOT intruded upon**, because an analyzer property is not a §14A field. **`P2` audited as one unit:** `P2-D` **OPEN** (unblocked by `F-5`, model choice unauthoritative), `P2-B` **BLOCKED** on `P2-D`, `P2-C` **OPEN**, `P2U` **BLOCKED**, `P2-A` **OPEN**; the 7-item `P4` handoff re-tested — **item 7 partially delivered, item 4 materially advanced, 0 items closed**. **`P3`/`P4`:** re-measured **0 authority** repository-wide; ⛔ **no number derived from the `Lib`→`Library` example or from the unrelated constants `LCFG-12` / `LCFG-6`**. **Remaining decisions:** `P1` **PARALLEL** (Rank-1 `MP-CON-02` — engine choice is a **deployment** decision; tension with §36 disclosed as **B16**, ⛔ not resolved by invention); `P5` **CLOSED** (`LCFG-12` = **20**, 5–50, Security); `P6` **PARTIALLY CLOSED** (`LCFG-6` = **60 s**, 0–300 s, Security, ⭐ *removal latency only* per `Library_PRD_v1.md` **L721** — ⛔ **not generalised** to other event classes); `P7` **OPEN** (⭐ EA **L339-344** re-measured as **planned capability entries containing NO values** in a Rank-6 descriptive document); `P8-A` **CLOSED** (`SRCH-INV-005` + BC Map **L453** *"tested quarterly, not assumed"* + the equivalence and no-re-admission obligations), `P8-B`/`C`/`D` **OPEN** (subject **L805** — *"⛔ **Not decided here**"*); `ENT` **OPEN**; `VOC` **PARTIALLY CLOSED**; `R1` **PARALLEL** with an implementation-verification residual ⛔ not closable by documentation; `R2` **BLOCKED** on `ENT`, ⛔ not audited further per the instruction's own gate. **ONE consolidated Security+QA review over the 12 named limbs: PASS 4 full + 2 partial · BLOCKED 6 + 1 partial · UNSUPPORTED 2 + 1 partial**, including ⚠ **the unowned normalization-collision finding (B14)** and ⚠ **the pre-existing all-Latin acceptance coverage defect (B15)**, both disclosed rather than smoothed. **Stage 3:** six alignment checks re-run — **6 of 6 PASS on the ownership question** — yet **CONDITIONAL / NOT CONFERRED** on **two independent grounds**: (1) ⛔⛔ `ADR-0033` **§7.1** *"**A conferral for one act is not a standing licence**"* with `SRCHCL-X1`'s *"an office is not an act"* — the ruling is an express grant **naming `SRCHAO-F5`** and is spent on it; (2) `SRCH-GAP-002`/`-003`/`-007` expressly **block Stage 3** and remain open, so no conferral could be exercised to a PASS on this evidence. **20 blockers listed together (B1–B20).** ⛔ **Creates: 0 script values, 0 normalization rules, 0 counting units, 0 tokenizers, 0 thresholds, 0 NFR values, 0 engines, 0 vendors, 0 owners, 0 roles, 0 personal names, 0 BCs, 0 edges (`BC-23`→`BC-18` NOT minted), 0 APIs, 0 events, 0 ADRs, 0 `IMPL-*`, 0 code, 0 new identifiers.** ⛔ **Subject byte-unchanged; every frozen PRD/ADR and every baseline byte-unchanged; registry **L315** still `PLANNED`; 9 prior `PRD-015` records byte-unchanged; no commit amended; no force-push; Stage 4/5/6/7 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked.** ⭐ **`F-5` = CLOSED. Stage 3 = CONDITIONAL / NOT CONFERRED.** |

---

**END OF CONSOLIDATED RECORD**

⭐ **`SRCHAO-F5` = OPTION A — CONFERRED and RECORDED.**
✅ **CLOSED: `F-5`, `P5`, `P8-A` · PARTIALLY CLOSED: `P6`, `VOC` · PARALLEL: `P1`, `R1`**
⛔ **OPEN / BLOCKED — HUMAN DECISION REQUIRED: `P2-A`/`B`/`C`/`D`/`U`, `P3`, `P4`, `P7`, `P8-B`/`C`/`D`, `ENT`, `R2`**
⛔ **STAGE 3: CONDITIONAL — NOT CONFERRED.**
