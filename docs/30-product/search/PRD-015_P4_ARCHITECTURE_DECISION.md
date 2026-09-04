# `PRD-015` — `P4` MINIMUM PREFIX LENGTH — ARCHITECTURE DECISION RECORD

| Field | Value |
|---|---|
| **Document** | `PRD-015_P4_ARCHITECTURE_DECISION.md` |
| **Version** | **v1.0** |
| **Date** | 2026-09-03 |
| **Scope** | ⭐ **`P4` ONLY** — *minimum prefix length for partial matching*, `SRCH-GAP-002` row `P4` (`PRD-015` **L838**) |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](PRD-015_SEARCH_INDEXING.md) — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, **v0.1 `DRAFT`**, verified byte-identical before and after this pass |
| **Type** | **Decision-preparation record for one parameter.** It audits authority, classifies evidence, analyses dependency, and presents options |
| **Act** | 🔍 **PREPARATION.** ⛔ **Not** a PRD · **not** an ADR · **not** an approval · **not** an ARB ruling · **not** a freeze · **not** a baseline · **not** a conferral |
| **Decision authority exercised** | ⛔ **NONE.** **0** decisions are taken |
| **Values invented** | ⛔ **ZERO.** No prefix length, no character count, no grapheme count, no engine, no analyzer setting, no latency figure |
| **Benchmarks performed** | ⛔ **NONE.** No candidate value was measured. No performance claim in this document is a measurement |
| **New identifiers created** | ⛔ **Zero.** No `IMPL-*`, no `ADR-*`, no `E-*` edge, no `BC-*`, no new `SRCH-*` requirement, no new `SRCH-GAP-*` |
| **New authority created** | ⛔ **NONE.** `P4` is **already owned** by `SRCH-GAP-002` (**L980**, owner **Architecture Owner**). ⭐ This record deliberately does **NOT** duplicate that ownership into a second home |
| **Existing PRD-015 records** | ⛔ **0 modified.** All five are historical/supplementary and were read only |
| **`P4` status after this pass** | ⛔⛔ **BLOCKED** — see §5 |
| **Final status** | ⚠ **`PRD-015` remains v0.1 `DRAFT`. STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED. Stage 4 NOT entered.** |

> ⚠⚠ **READ THIS FIRST — THE ONE FINDING THAT CHANGES THE `P4` VERDICT.**
>
> Every prior `PRD-015` record — including my own `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` §7 —
> classified `P4` as **OPEN**: a missing number that the Architecture Owner could supply **alone, today**
> (§7.5: *"class A is the only class that can be decided by the Architecture Owner alone, today"*).
>
> ⭐⭐⭐ **That is now measured to be wrong, and in the safer direction. `P4` is not merely OPEN — it is
> `BLOCKED`, because the parameter has no defined UNIT.**
>
> `P4` is a **length**. A length requires a unit of measure. The repository states the unit **nowhere**, and it
> cannot be defaulted, because:
>
> 1. **`SRCHPO-1`** (`PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L57**) closes the V1 script set at **exactly
>    two** scripts — **Latin** and **Devanagari** — as a **closed set**. This is a *conferred Product Owner
>    decision*, not a candidate.
> 2. In **Devanagari**, *character*, *Unicode code point* and *user-perceived grapheme* are **three different
>    counts** for the same rendered text. A prefix of "two" is therefore **three different rules**.
> 3. **`SRCH-FR-024`** **N4** (**L421**) mandates diacritic folding and **N6** (**L424**) mandates removal of
>    zero-width, control and formatting characters — and **Devanagari's** conjunct forms are built with exactly
>    the class of joiner characters `N6` removes. ⭐ **The normalized token that `P4` would measure does not yet
>    exist**, because the rule set that produces it is `P2`.
> 4. **`SRCH-BR-008`** (**L426-428**) requires normalization to be **symmetric and total** — *"any transformation
>    applied to a query term **MUST** have been applied to the indexed term, and vice versa."* A prefix length
>    counted in a **pre**-normalization unit at query time and a **post**-normalization unit at index time would
>    breach it silently.
>
> ⭐⭐ **Therefore `P4` is NOT independently decidable. It has a `REQUIRED` dependency on `P2`** (analyzer /
> tokenizer / normalization rule configuration). Any number conferred before `P2` declares its unit would be
> **ambiguous across two of two supported scripts** — which is not a decision, it is a defect with a value in it.
>
> ⛔ **This document therefore proposes no number, and additionally declines to propose that a number be
> proposed yet.** §5 records `BLOCKED`, §6 records the *form* that is repository-supported, and §7 leaves every
> human field blank.
>
> ⚠ **Read as a refinement, not an amendment.** §7 of the preparation record remains a correct reading of the
> evidence *it opened*. It did not open `SRCH-FR-024` `N4`/`N6`, `SRCH-BR-008` or `SRCHPO-1` **against** `P4`.
> ⛔ That record is **not edited** — per the repository's own rule, *"a stale review is corrected by a dated
> re-run beside it, not by editing what it concluded"* (`tool/docs_check/alignment_record_freshness.py`,
> citing `PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md` **L8**). **This is that re-run.**

---

## 1. What `P4` is, quoted from its own authority

⭐ Reproduced verbatim so that no reader has to trust a paraphrase.

**The parameter, as registered** — `PRD-015` §36, **L838**:

> `| P4 | Minimum prefix length for partial matching | SRCH-FR-030 |`

**The requirement it serves** — `SRCH-FR-030`, `PRD-015` **L518-520**:

> `SRCH-FR-030` — A query token **MUST** be able to match an indexed token by **prefix**, so that an incomplete
> word matches the word it begins (`Lib` → `Library`). ⛔ Prefix matching **MUST NOT** be applied as a suffix or
> infix match on **exact**-role fields.

**The acceptance criterion that tests it** — `SRCH-AC-030`, `PRD-015` **L1103-1105**:

> **`SRCH-AC-030`** *(`SRCH-FR-030`)* — **Given** the query token `Lib` and an indexed token `Library`, **when**
> the query is executed against a **text**-role field, **then** the token matches by prefix; **and given** an
> **exact**-role field, **then** no suffix or infix match is produced.

**The refusal that created the parameter** — `PRD-015` **L496-499**:

> ⚠⚠ **The implementation-specific tolerance parameters are NOT decided here.** The *behaviour* above is
> required. The **edit-distance bound, minimum term length before tolerance applies, minimum prefix length, and
> analyzer configuration** are implementation parameters that **no repository authority states.** They are
> recorded as **`SRCH-GAP-002`**, owner **Architecture Owner**. ⛔ **No numeric value is invented in this
> document.**

⭐⭐ **Note what `SRCH-FR-030` does and does not say.** It requires that prefix matching be *possible*
(*"**MUST** be able to match"*). It fixes **no length**, states **no enabling condition**, and — unlike
`SRCH-BR-012` for typo tolerance — contains **no "MUST NOT enable" escape**. That asymmetry is the reason `P4`
matters, and it is unchanged by this pass.

⭐ **One scope correction, measured this pass.** `SRCH-FR-018` (**L375-376**) declares the three match roles and
states that **exact**-role fields are *"identifier-like; **exact/prefix only**"*. `SRCH-FR-027` (**L492-494**)
repeats it: identifier-like values *"**MUST** match exactly or **by prefix only**."* ⇒ **`P4` governs BOTH
`text`-role and `exact`-role fields.** It is not a `text`-role-only parameter. Any `P4` rule must therefore be
stated in a way that survives being applied to a PIN code and to a library name by the same engine.

---

## 2. `PHASE 1` — repository-first authority audit

### 2.1 The direct searches, with scope and result

⛔ Every row is a **measured** count from this pass, not a recollection from a prior record.

| # | Pattern | Scope | Result |
|---|---|---|---|
| 1 | `minimum prefix\|min_prefix\|minPrefix\|prefix length\|prefix_length\|prefixLength` | `docs/` `tool/` `lib/` **minus** `PRD-015_*` | ⛔ **0 hits** |
| 2 | `autocomplete\|auto-complete\|typeahead\|type-ahead\|as-you-type\|incremental search\|search suggestion` | `docs/` `tool/` | ⚠ hits exist — **all** non-authoritative, see §2.3 |
| 3 | `prefix` — unrestricted | `docs/` `tool/` minus `ADR-INDEX`, minus `PRD-015_*` | ⚠ hits exist — **all** about a *different* kind of prefix, see §2.4 |
| 4 | `LCFG-` — **full inventory**, all 13 | `docs/20-configuration/CONFIGURATION_GUIDE.md` | ⛔ **0** govern prefix length, see §2.5 |
| 5 | `minimum (query\|search\|characters\|char)\|at least N character\|min_chars\|minChars\|query length` | `docs/` `tool/` | ⚠ 4 real length constants found — **none** is `P4`, see §2.6 |
| 6 | `prefix\|partial\|fuzz\|typo\|autocomplete\|minimum` | `PRD-021C` C2 Library Search & Local Discovery draft | ⛔ **1 hit**, and it is the `LSD-*` **identifier** prefix row (**L51**) |
| 7 | `prefix\|search param\|minimum length\|min length\|token length` | `docs/10-architecture/ARCHITECTURE_RULINGS.md` | ⛔ **0 hits** |
| 8 | Search capability tree read in full | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1516-1560** | ⛔ **0** values of any kind |

### 2.2 A–F classification of every relevant hit

| Path + line | What it says | Class | Why |
|---|---|---|---|
| `PRD-015_SEARCH_INDEXING.md` **L518-520** — `SRCH-FR-030` | Prefix matching is an unconditional **MUST**; no suffix/infix on **exact** fields | **A. AUTHORITATIVE** — *for the behaviour* | It is the requirement `P4` exists to make implementable. ⛔ It states **no length** |
| **L1103-1105** — `SRCH-AC-030` | Tests `Lib` → `Library` on a **text** field; no suffix/infix on an **exact** field | **A. AUTHORITATIVE** — *for the test* | ⭐ `Lib` is **3** units long, which bounds `P4` **from above** (§3.5) but does not set it |
| **L375-376** — `SRCH-FR-018` | Three match roles; **exact** = *"exact/prefix only"* | **A. AUTHORITATIVE** — *for scope* | ⇒ `P4` applies to **exact**-role fields too |
| **L492-494** — `SRCH-FR-027` | Identifier-like values *"**MUST** match exactly or by prefix only"* | **A. AUTHORITATIVE** — *for scope* | Corroborates the row above |
| **L838** — `SRCH-GAP-002` row `P4` | *"Minimum prefix length for partial matching"* → `SRCH-FR-030` | **A. AUTHORITATIVE** — *for OWNERSHIP* | ⭐⭐ **This is the existing authority that owns `P4`.** ⛔ It must **not** be duplicated |
| **L980** — `SRCH-GAP-002` register row | Owner **Architecture Owner**; blocks **Stage 3**; nothing in Stage 2 | **A. AUTHORITATIVE** — *for OWNER + blast radius* | Fixes who decides and what is blocked |
| **L496-499** | *"minimum prefix length … no repository authority states"* + *"no numeric value is invented"* | **E. PROHIBITION** | ⛔ The subject **forbids itself** from carrying a value. A record that supplied one would contradict the document it supplements |
| **L421** `SRCH-FR-024` `N4` · **L424** `N6` | Diacritic folding; removal of zero-width/control/formatting characters | **B. SUPPORTING** — ⭐⭐ **and the source of the block** | Determines what a "character" **is** after normalization ⇒ `P4`'s unit |
| **L426-428** — `SRCH-BR-008` | Normalization **MUST** be symmetric and total | **E. PROHIBITION** | ⛔ Forbids counting prefix length in different units at index vs query time |
| **L435-436** + **L985** — `SRCH-GAP-007` | Language/script inventory; owner **Product Owner** + **Architecture Owner** | **B. SUPPORTING** | ⚠ Its Product-Owner half is **closed** by `SRCHPO-1`; its analyzer half is **not** |
| `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L57** — `SRCHPO-1` | V1 scripts = **Latin + Devanagari**, a **closed set** | **A. AUTHORITATIVE** — *conferred Product Owner decision* | ⭐⭐ Makes the unit question **unavoidable**: two scripts, two counting models |
| **L75** — `SRCHPO-6` | *"Bounded partial / prefix matching — **ENABLED**"* · *"⛔ **No numeric prefix length invented**"* | **A. AUTHORITATIVE** for the **behaviour**; **E. PROHIBITION** for the **value** | ⭐⭐ The Product Owner approved the **behaviour** and **explicitly withheld the number** |
| **L143** — `P4` row | *"⛔ **None.** `SRCHPO-6` approves the behaviour; the number is absent"* → **OPEN** | **C. HISTORICAL** | A prior measurement, consistent with this one |
| **L161** — label map | *"P3 — Partial/prefix"* → `SRCHPO-6` → *"⛔ **Not** P4 (min prefix length)"* | **E. PROHIBITION** | ⛔ Blocks the inference *"prefix matching was approved, so `P4` was approved"* |
| **L442** — `SRCHPO-X5` | *"Approving typo tolerance and prefix matching decides P3 and P4"* → ⛔ **REJECTED** | **E. PROHIBITION** | ⭐ The exact false-closure this workflow's Phase 6 forbids, **already rejected on the record** |
| `PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md` **L207-231** — §7 `SRCHAO-P4` | *"⛔ **0** authoritative hits"*; three approaches; *"⛔ **No number appears in this section**"* | **C. HISTORICAL** | The prior packet. ⛔ **Not edited by this pass** |
| `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L121** | `P4` → *"⛔ **0 hits. OPEN**"* | **C. HISTORICAL** | Consistent |
| `PRD-015_ARCHITECTURE_ALIGNMENT.md` **L875** | *"Minimum token / prefix length for T2 — ⛔ Not stated"* → `SRCH-GAP-002` | **C. HISTORICAL** | Consistent |
| `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` **§7** (**L318-374**) | `P4` is the real V1 blocker of the two; classes A/B/C; ⛔ no value | **C. HISTORICAL** | ⭐ Its `P4`-vs-`P3` asymmetry finding is **upheld**; its *"decidable alone, today"* line is **superseded** by §3.2 |
| `CONFIGURATION_GUIDE.md` **L351-363** — `LCFG-1`…`LCFG-13` | Full register, all 13 read | **D. NON-AUTHORITATIVE** *for `P4`* | ⛔ **Not one** governs prefix length — §2.5 |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1546-1547** | *"Search Suggestions **(V3)**"* → *"Autocomplete **(V3)**"* | **D. NON-AUTHORITATIVE**, ⚠ **and a trap** | §2.3 — different object, different release, Rank 6 descriptive |
| `Library_PRD_v1.md` **L862-864** — `LIB-20.1` | Platform NFR budgets come from the EA NFR Budgets document; a PRD **MUST NOT** state a competing figure | **E. PROHIBITION** | ⛔ Blocks justifying any `P4` value on a **latency** ground (§4.3) |
| `MASTER_PRD.md` **L237** `MP-CON-01`, **L238** `MP-CON-02` | Vendor-neutral by construction; choosing an implementation is a *deployment* decision | **E. PROHIBITION** | ⛔ Blocks *"engine X defaults to N, so N"* (§4.3) |
| `PRD-015` **L750** — `S2` | Enumeration; mitigated by page cap `SRCH-FR-039` + per-page auth `SRCH-FR-040` | **B. SUPPORTING** | Security frame for §4.4 |
| **L770** — `SRCH-GAP-008` | Query-volume abuse / rate limiting — *"⛔ **No owner exists** — `XPC-OD-010` is OPEN"* | **F. UNKNOWN** | ⛔ Cannot be relied on, cannot be closed here |
| **L589** — `SRCH-GAP-009` | §14A declares **no field precedence order**; owner **Product Owner** | **B. SUPPORTING** | ⚠ Constrains a *precedence*-based option, **not** a *role*-based one (§6.2) |
| `tool/module_dependencies.yaml` **L373-384** | `platform/search` rank 5, `imports: [contracts]`, `SE-1` tenant-prefixed index name, `SE-2` permission scope on every index write | **B. SUPPORTING** | ⭐ Machine-enforced. ⛔ Carries **no** matching parameter |
| `ADR-0094` | §14A **is** the V1 `BC-23` discovery contract; *"does **not** author `PRD-015`"* | **E. PROHIBITION** | ⛔ Confirms the contract decision did not decide the engine or its parameters |

**Totals: A = 8 · B = 6 · C = 5 · D = 2 · E = 7 · F = 1.**

### 2.3 ⚠ The `autocomplete` trap, disarmed explicitly

`LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1546-1547** tags *"Search Suggestions **(V3)**"* → *"Autocomplete
**(V3)**"*. A reader could reason: *autocomplete implies a minimum prefix; the EA names autocomplete; therefore
the EA governs `P4`.* ⛔ **Three independent reasons that fails:**

1. ⭐⭐ **Different objects.** Prefix **matching** (`SRCH-FR-030`) decides whether a **document matches** an
   incomplete token. **Autocomplete** decides whether the UI **suggests a completion**. `SRCH-FR-030` produces a
   T2 result-set membership decision; autocomplete produces a suggestion list. Neither implies the other.
2. ⭐ **Different releases.** Autocomplete is tagged **V3**. `SRCH-FR-030` is a **V1** `MUST`. A V3 capability
   cannot supply a parameter a V1 `MUST` needs.
3. **Different rank and different mode.** The EA is **Rank 6 and descriptive**. `ADR-0046` **L255-258** already
   settled this class of reasoning: a *"**descriptive rank 6 line**"* is *"corroboration, not grounds"*, and
   `MP-CON-08` forbids resolving a Rank 1 / Rank 6 disagreement by choosing.

⚠ The prior packet already flagged this interaction as **`SRCHAO-C1`** (**L224-227**). ⭐ **Recording it as
disarmed, not as new.** Two other `autocomplete`-family hits were inspected and are unrelated domains —
`ATT-BR-030` attendance auto-complete, and `TSF-FR-023` trust-&-safety discovery exclusion.

### 2.4 ⚠ The `prefix` homonym trap, disarmed explicitly

Search 3 returned many hits. ⛔ **Every one is a different meaning of the word:**

| Meaning | Example | Why it is not `P4` |
|---|---|---|
| **Requirement-identifier prefix** | `SRCH-`, `LSD-`, `TSF-`, `LCM-`, `FEE-` collision checks | A naming-collision procedure (`PRD_LIFECYCLE.md` §5 rule 2) |
| **Tenant-partitioned key prefix** | `SE-1` *"tenant-prefixed index name"*; anti-pattern `X-13` | An **isolation** rule. ⭐ Concerns *what the key starts with*, never *how many characters a query must supply* |
| **Event-name prefix** | `enrollment.` | Topic routing |

⭐⭐ **This is precisely the *"DO NOT infer authority merely because a number exists near the word prefix"*
hazard. It is measured, and it is clear: there is no such number.**

### 2.5 ⭐ The configuration question, answered directly

> *"Specifically check whether any existing configuration constant already governs minimum prefix length."*

**All 13 `LCFG-*` constants were read in full** (`CONFIGURATION_GUIDE.md` **L351-363**). ⛔ **Answer: NO.**

| Constant | Subject | Governs `P4`? |
|---|---|---|
| `LCFG-1` … `LCFG-4` | Time zone · Language · Currency · Date format | ⛔ No |
| `LCFG-5` | Member directory — **Disabled** by default | ⛔ No |
| `LCFG-6` | Discovery index propagation **60 s** — *"**Removal latency only**"* | ⛔ No — this is `P6` |
| `LCFG-7` … `LCFG-10` | Gallery images · Facilities · Floors · Zones | ⛔ No |
| `LCFG-11` | Preserved intent TTL **30 min** | ⛔ No |
| `LCFG-12` | Public search **page size 20**, range 5–50, owner **Security** | ⛔ No — this is `P5`. ⭐ It bounds **result volume**, never **query token length** |
| `LCFG-13` | Public preview cache TTL **300 s** | ⛔ No |

⭐ **The two search-adjacent constants are precisely the two `P`-rows the repository has already closed** —
`LCFG-12` = `P5`, `LCFG-6` = `P6` (`PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L144-145**). Their existence is
**evidence of the register's completeness**, and their subject matter is **evidence that `P4` is absent from
it**. ⛔ **No `SRCH-CFG-*` register exists.** The Configuration Guide contains **zero** `SRCH-*` identifiers
(measured: `SRCH-` = 0 occurrences).

⚠ **And note what `LCFG-12`'s owner column implies.** Its owner is **Security**, not Architecture — because it
*"Bounds enumeration rate and page weight"* (**L362**). ⭐ If `P4` were ever expressed as a *public-surface*
constant, `LCFG-12`'s precedent suggests its owner would be **Security**, not the Architecture Owner. ⛔ That is
an **observation about the precedent**, not a reassignment: `SRCH-GAP-002` **L980** assigns `P4` to the
**Architecture Owner**, and this record does not move it.

### 2.6 The four real length constants in the repository — and why none is `P4`

| Constant | Path + line | Value | Why it is not `P4` |
|---|---|---|---|
| `SCFG-1` | `Student_Identity_PRD_v1.md` **L1335** | Username length **3–30**, *"Lower bound **SHALL NOT** go below 3"* | ⭐ A **stored-field validity** bound in `BC-11`, not a **query-matching** bound in `BC-23` |
| `SCFG-6` | **L1340** | Bio maximum **300** | Field length |
| Library Name | `Library_PRD_v1.md` **L212** | **2–120** characters | ⭐⭐ **The closest false friend.** It bounds the **indexed value's** length, not the **query prefix's** |
| `IT-3` | `CONFIGURATION_GUIDE.md` **L47** | Access-code entropy ≥ 40 bits, **8** characters | Credential entropy |

⛔ **None is applicable, and importing any of them would be manufacturing a value by analogy.** ⚠ `SCFG-1`'s
*"**SHALL NOT** go below 3"* is the most seductive — it is a hard floor of **3** on a name-like string in a
sibling context, and `SRCH-AC-030`'s test token `Lib` is also **3**. ⛔ **That coincidence is not authority.**
`SCFG-1` governs what a `BC-11` username may **be**; `P4` governs what a `BC-23` query must **supply**. They are
different contexts, different owners, and different objects.

### 2.7 ⭐ Verdict of Phase 1, stated plainly

> ⛔⛔ **NO AUTHORITATIVE `P4` VALUE WAS FOUND ANYWHERE IN THE REPOSITORY.**
>
> Measured across `docs/`, `tool/` and `lib/`: **0** hits for any minimum-prefix-length expression; **0** of 13
> `LCFG-*` constants; **0** in the EA search tree; **0** in `ARCHITECTURE_RULINGS.md`; **0** in the `PRD-021C`
> C2 search draft; **0** in the machine-enforced module manifest.
>
> ⛔ **No number is chosen. No number is recommended. No number is proposed as a default.** The four length
> constants that do exist (§2.6) govern other objects in other contexts and are **rejected as sources**.

⭐ **And the ownership finding, which is the second half of the Phase 1 instruction:** `P4` **already has an
authority** — `SRCH-GAP-002`, `PRD-015` **L838** + **L980**, owner **Architecture Owner**, blocking **Stage 3**.
⛔ **This record therefore creates no new authority, no new gap ID and no new register row.** It is a
*preparation record for an existing gap*, which is the only lawful shape available to it.

---

## 3. `PHASE 2` — five-expert review

⚠ Each review is an **analysis**, ⛔ **not** a decision, ⛔ **not** an approval, and ⛔ **not** a role act by
the named role. The headings name **disciplines**, not people — `PRD_OWNERSHIP_MODEL.md` §7 rule 4: *"**Never**
record a personal name."*

### 3.1 `E1` — PRODUCT

| Question | Finding |
|---|---|
| **What user-visible behaviour does `SRCH-FR-030` actually require?** | That an **incomplete word matches the word it begins** — `Lib` → `Library` (**L518-519**). ⭐ Nothing more. It does **not** require suggestions, completions, or as-you-type behaviour |
| **Is `P4` product policy or implementation detail?** | ⭐⭐ **Implementation detail — and the repository has already ruled on exactly this.** `SRCHPO-6` (**L75**) is the Product Owner **approving the behaviour** while explicitly recording *"⛔ **No numeric prefix length invented**"*. ⭐ The Product Owner **had the opportunity to set it and declined**, and `SRCH-GAP-002` **L980** places it with the Architecture Owner |
| **Does the repository already express a user-facing threshold?** | ⛔ **No.** §2.5 and §2.6 |
| **Does changing `P4` change the product contract?** | ⛔ **No — provided it stays within `SRCH-AC-030`.** The contract is *"prefix matching exists"*. ⚠ **But there is a boundary**: a `P4` **greater than 3 units** would make `SRCH-AC-030`'s own example (`Lib`, 3 units) **fail**. ⇒ `P4` ≤ 3 is a **contract** constraint, not a preference (§3.5) |
| **Verdict** | ⛔ **NOT a product decision.** ⭐ Product's contribution is the **upper bound implied by `SRCH-AC-030`**, and the fact that a **conferred** Product Owner decision (`SRCHPO-1`) is what makes the unit question binding |

### 3.2 `E2` — ENTERPRISE / DOMAIN ARCHITECTURE

| Question | Finding |
|---|---|
| **Which existing authority should own `P4`?** | ⭐⭐ **`SRCH-GAP-002` already does** — `PRD-015` **L838** (the row) + **L980** (owner **Architecture Owner**, blocks **Stage 3**). ⛔ **Nothing needs assigning** |
| **Should `P4` live in `BC-23`, Configuration V1, NFR Budgets, or elsewhere?** | ⛔ **Not NFR Budgets** — `P4` is a **matching-semantics** parameter, not a latency/availability budget, and `LIB-20.1` (**L862-864**) routes only *budgets* there. ⛔ **Not Configuration V1 as a first act** — `LCFG-12`'s precedent shows a search constant *can* live there, but it arrived **owned by Security** for an enumeration reason. ⭐ **`BC-23` / `SRCH-GAP-002` is already the home.** A *later* transcription into a configuration register is a separate act with its own owner |
| **Would assigning a new authority create duplicate ownership?** | ⭐⭐ **YES — and this is the trap the instruction names.** Writing a `P4` value or a new gap ID into **this** document would create a **second home** for a parameter `SRCH-GAP-002` already owns, and the repository's recorded defect class `GCP-08`/`GCP-11` is exactly *"derived statements drifting"*. ⛔ **Refused** |
| **Does rank / baseline precedence affect it?** | ⭐ **Yes, twice, both as prohibitions.** `MP-CON-01`/`MP-CON-02` (**L237-238**) bar deriving `P4` from a vendor's default. `ADR-0046` **L255-258** bars treating the Rank 6 EA `Autocomplete (V3)` line as grounds |
| **Is a new edge required?** | ⛔ **No.** `P4` is a parameter **internal** to `platform/search`. The manifest block at `tool/module_dependencies.yaml` **L373-384** already exists with `imports: [contracts]`; ⛔ **no edge is created** |
| **Verdict** | ✅ **Owner is settled: Architecture Owner via `SRCH-GAP-002`.** ⛔ **No new authority, no new home, no new edge, no new gap ID** |

### 3.3 `E3` — SEARCH ENGINEERING

⛔ **No candidate numeric value is evaluated, because §2.7 measured that the repository contains none to
evaluate.** ⚠ **And no performance claim below is a benchmark** — none was run, and `LIB-20.1` forbids this
document from asserting a latency figure anyway.

⭐⭐ **The finding this discipline contributes is the unit problem, and it is decisive:**

| # | Finding | Evidence |
|---|---|---|
| **U1** | ⭐⭐⭐ **`P4` is a length with no defined unit.** *Characters*, *Unicode code points* and *user-perceived graphemes* are three distinct counts | `SRCHPO-1` **L57** closes V1 at **Latin + Devanagari** |
| **U2** | In **Devanagari**, a rendered syllable is routinely **multiple** code points (consonant + virama + consonant + vowel sign). ⇒ A prefix of *"N code points"* can cut a syllable **in half**; a prefix of *"N graphemes"* cannot | `SRCHPO-1`; ⛔ no repository authority states which count applies |
| **U3** | ⭐ The unit is determined by **`P2`**, not by `P4`. `SRCH-FR-024` `N4` (**L421**) folds diacritics and `N6` (**L424**) strips zero-width/control/formatting characters — the very joiner class Devanagari conjuncts use. ⇒ **the token `P4` would measure does not exist until `P2` is configured** | `SRCH-FR-024`; `SRCH-FR-023` (**L414-415**) requires the *same declared rule set* at index and query time |
| **U4** | ⛔ **A unit mismatch is not a tuning error — it is a `SRCH-BR-008` breach.** Symmetric-and-total normalization forbids one unit at query time and another at index time | `SRCH-BR-008` **L426-428** |
| **U5** | ⚠ **`SRCH-FR-009` makes the breach uniform, not local.** *"Matching behaviour **MUST NOT** vary by consumer identity"* ⇒ an ambiguous unit is ambiguous for **every** consumer simultaneously | `SRCH-FR-009` **L337** |

**The remaining engineering constraints, all repository-derived:**

| # | Constraint | Effect on `P4` | Evidence |
|---|---|---|---|
| **C-a** | ⭐⭐ **Multi-word queries are conjunctive** — every token must be satisfied | ⭐ A **short** minimum does **not** flood, because each extra token **narrows**. ⚠ This weakens the standard *"short prefixes are dangerous"* argument | `SRCH-BR-010` **L524-527** |
| **C-b** | Result **volume** is already capped at **20** | ⇒ The residual concern is **query cost**, not response size | `LCFG-12` **L362** |
| **C-c** | ⛔ **No numeric relevance score exists** | ⇒ A prefix hit **cannot be "ranked down"**. It is in the tier or it is **excluded** | `SRCH-FR-035` **L586-593**; `SRCH-BR-013` **L603-604** |
| **C-d** | ⛔ **No suffix/infix on `exact`-role fields**; and `exact` is *"exact/prefix only"* | ⇒ ⭐ `P4` **must** be statable for identifier-like fields too | `SRCH-FR-030` **L519-520**; `SRCH-FR-018` **L375-376** |
| **C-e** | Tier boundaries are **inviolable** | ⇒ `P4` cannot be softened by demoting short-prefix hits to T3 — that would breach *"a tier boundary **MUST NOT** be crossed by any other factor"* | `SRCH-FR-035` layer 1 **L588** |
| **C-f** | ⭐ **Hinglish is permitted, not required** | ⇒ `P4` **MUST NOT** be justified by Romanized-Hindi behaviour, since an implementation may lawfully not support it | `SRCHPO-2`, `SRCHPO-3` **L58-59** |
| **C-g** | Ordering must be **deterministic and total**, and every result **explainable** | ⇒ Whatever `P4` is, it must be a **declared rule**, not an engine heuristic | `SRCH-FR-034` **L580-582**; `SRCH-FR-036` **L595-596** |

**Can the engine deterministically enforce the rule?** ⭐ **Yes — once the unit exists.** `SRCH-FR-034`
determinism and `SRCH-FR-036` explainability are satisfiable by *"token length ≥ N, counted in unit U"*, which is
a total function on a normalized token. ⛔ **Until `U` is declared, the same rule is not a function** — it is
three functions wearing one name.

**Verdict:** ⛔⛔ **`BLOCKED`, not merely open.** ⭐ The block is **not** "we lack a number" — it is **"we lack
the unit the number would be expressed in, and `P2` owns the unit."**

### 3.4 `E4` — SECURITY / PRIVACY

⭐ Nothing in this section adjusts `BC-18` authorization authority or `BC-13` Trust & Safety authority.

| Question | Finding |
|---|---|
| **Does `P4` affect tenant isolation?** | ⛔ **No.** Isolation is **structural and prior to matching**: `SRCH-INV-002` (one index class per document) and `SRCH-INV-004` (tenant data never in the public index) — `PRD-015` **L689-691**. ⭐ Reinforced **mechanically** by `SE-1` (*"tenant-prefixed index name"*, anti-pattern `X-13`) at `tool/module_dependencies.yaml` **L373-384**, in the manifest whose violations **fail the build**. ⛔ A prefix rule cannot reach across an index class |
| **Can prefix matching leak the existence of another tenant's records?** | ⛔ **No, by three independent controls.** `SRCH-FR-042` (**L654-655**) — empty and authorisation-emptied results are **indistinguishable** by shape, error, **timing** or message. `SRCH-FR-040` (**L644**) — authorisation is re-evaluated **per page**. `SRCH-FR-038` (**L626**) — a filter on an ineligible field is **rejected**, never silently ignored |
| **Do short prefixes increase enumeration risk?** | ⚠ **Yes — in query volume, and that is the one real security interaction.** ⭐ **But not in result volume**: `LCFG-12` caps pages at **20** and `SRCH-FR-039`/`SRCH-FR-040` bound and re-authorise paging (`S2`, **L750**). ⛔⛔ **And the mitigation for the volume limb has NO OWNER** — `SRCH-GAP-008` (**L770**): *"⛔ **No owner exists** — `XPC-OD-010` is **OPEN**."* ⇒ ⭐⭐ **any `P4` conferral accepts residual `R8` risk rather than mitigating it, and the owner must be told so explicitly** |
| **Is query-time entitlement affected?** | ⛔ **No.** §27 (**L662-700**) makes the visibility decision the **source system's**, re-evaluated **at query time and on every page**. ⭐ Matching **breadth** and authorisation are orthogonal: a wider match set is filtered by the same gate |
| **Does `P4` interact with `ENT`?** | ⛔ **No dependency.** `ENT` = `SRCH-GAP-003`, the *mechanism* of query-time entitlement evaluation. `P4` determines **which documents are candidates**; `ENT` determines **which candidates are returned**. ⭐ The write-side half is already enforced law — `SE-2`, *"every index write carries a permission scope"* |
| **Are stale-index / removal semantics affected?** | ⛔ **No.** `LCFG-6`'s **60 s** is *"**Removal latency only**"* (**L356**), scoped by `LIB-16.9` (`Library_PRD_v1.md` **L721**/**L727**) and ⛔ **never** applicable to an authorization decision — `LCFG-13`'s rule, *"a cache is not a source of truth"*. `SRCH-FR-013` gives privacy-mode changes **no propagation window** (`SEV-9`) |
| **Verdict** | ⚠ **`P4` is security-relevant in exactly ONE limb — anonymous query volume — and that limb's owner does not exist.** ⛔ **Security cannot clear a `P4` value while `XPC-OD-010` is OPEN**, and ⭐ **this must be stated on the decision form, not buried** |

### 3.5 `E5` — QA / TRACEABILITY

| Question | Finding |
|---|---|
| **Which requirements are affected?** | `SRCH-FR-030` (**L518-520**) directly. Coupled: `SRCH-FR-018` (**L375-376**), `SRCH-FR-027` (**L492-494**), `SRCH-FR-029` (**L513-514**), `SRCH-BR-010` (**L524-527**), `SRCH-FR-023`/`024` (**L414-424**), `SRCH-BR-008` (**L426-428**), `SRCH-FR-034`/`035`/`036` (**L580-596**), `SRCH-FR-009` (**L337**) |
| **Which acceptance criteria are affected?** | ⭐ **`SRCH-AC-030`** (**L1103-1105**) — the only AC that tests `P4` |
| **Can `P4` be closed with existing authority?** | ⛔ **No.** §2.7 |
| **Is a new testable parameter required?** | ⭐⭐ **Two, not one** — and this is QA's decisive contribution. **(i)** the **minimum length `N`**, and **(ii)** the **unit `U`** in which `N` is counted. ⛔ **A test written against `N` alone is not deterministic across `SRCHPO-1`'s two scripts** |
| **⭐⭐ Can `SRCH-AC-030` become testable?** | ⚠ **PARTIALLY — and the split matters.** Its **`exact`-role limb** (*"no suffix or infix match is produced"*) is **testable today**: it is a pure negative, independent of `N` and `U`. ⛔ Its **`text`-role limb** (`Lib` → `Library`) is **NOT** testable, because it asserts that a **3-unit** token matches — which is `true` iff `N ≤ 3` **in the unit `U`**, and neither is declared |
| **⭐ The upper bound this yields** | `SRCH-AC-030` uses `Lib` — **3** units in **any** Latin counting model. ⇒ **`N` ≤ 3 for Latin**, or the frozen AC fails. ⭐⭐ **This is a genuine repository-derived CONSTRAINT on `P4`, and it is the only one.** ⛔ **It is a ceiling, not a value**: `N ∈ {1, 2, 3}` remains a **3-way open decision**, and Devanagari is **unconstrained** because `SRCH-AC-030` contains no Devanagari case |
| **Verdict** | ⛔ **`P4` cannot be closed.** ⭐ **QA can, however, state precisely what a conferral must contain to be testable: `N` *and* `U`, plus at least one Devanagari acceptance case** — because `SRCHPO-1` made Devanagari a **V1 canonical script**, and ⚠ **§20's AC set contains no Devanagari prefix example** |

### 3.6 Five-expert convergence

| Expert | Verdict on a `P4` **value** | Verdict on `P4` **ownership** |
|---|---|---|
| `E1` Product | ⛔ Not ours — `SRCHPO-6` already declined the number. ⭐ Contributes the `≤ 3` contract ceiling | ✅ Architecture Owner |
| `E2` Enterprise | ⛔ No value; ⛔ **no new authority** — `SRCH-GAP-002` owns it | ✅ Architecture Owner, **already assigned** |
| `E3` Search | ⛔⛔ **BLOCKED** — no unit; `P2` owns the unit | ✅ Architecture Owner (**and `P2` first**) |
| `E4` Security | ⚠ **Cannot clear** while `SRCH-GAP-008` has no owner | ✅ Architecture Owner, ⚠ with acknowledged residual `R8` |
| `E5` QA | ⛔ Not closable; ⭐ needs **`N` + `U`** + a Devanagari case | ✅ Architecture Owner |

⭐⭐ **5 of 5 converge on `BLOCKED` or `CANNOT CLEAR`. 5 of 5 converge that the owner is already assigned and
must not be re-assigned. 0 of 5 produce a number.**

---

## 4. `PHASE 3` — dependency analysis

⛔ **Dependency is asserted only where a repository rule creates it.** ⚠ Two parameters both affecting search is
**not** a dependency — the instruction warns against exactly that inference, and §4.2 records the four cases
where the intuitive answer is wrong.

### 4.1 The eleven determinations

| # | Item | Determination | Repository evidence |
|---|---|---|---|
| **`P1`** | Engine / index technology selection | ⭐ **NO DEPENDENCY** | ⭐⭐ **Counter-intuitive but load-bearing.** `MP-CON-02` (`MASTER_PRD.md` **L238**): choosing an implementation is *"a **deployment decision, not an architecture decision**."* `MP-CON-01` (**L237**) bars vendor names from domain code. ⇒ ⛔ **`P4` MUST NOT be derived from an engine's default**, so `P4` cannot *depend* on `P1`. ⭐ The dependency runs the **other way**: `P1`'s candidates must satisfy `P4`, not supply it |
| **`P2`** | Analyzer / tokenizer / normalization rule configuration | ⛔⛔ **REQUIRED** | ⭐⭐⭐ **THE BLOCKING DEPENDENCY, and the single most important row in this document.** `P4` is a **length**; a length needs a **unit**; the unit is a property of the **normalized token**, which `P2` produces. `SRCH-FR-023` (**L414-415**) — the *same declared rule set* at index and query time. `SRCH-FR-024` `N4` (**L421**) diacritic folding · `N5` (**L423**) tokenization · `N6` (**L424**) removal of zero-width/control/formatting characters. `SRCH-BR-008` (**L426-428**) — symmetric and total. `SRCHPO-1` (**L57**) — **Latin + Devanagari**, closed set. ⇒ ⛔ **A `P4` value conferred before `P2` declares its unit is ambiguous across 2 of 2 supported scripts** |
| **`P3`** | Edit-distance bound + minimum token length for tolerance | ⭐ **NO DEPENDENCY** | ⭐⭐ **Different tiers, and the tier boundary is inviolable.** `P4` governs **T2** (§19.2, **L516-520**); `P3` governs **T3** (`SRCH-BR-012`, **L561-572**). `SRCH-FR-035` layer 1 (**L588**): *"⭐ A tier boundary **MUST NOT** be crossed by any other factor."* `SRCH-FR-025` (**L445**) makes the ladder **ordered**, and `E5` of §40 (**L944**) records that a document matching at two tiers is recorded at its **strongest**. ⇒ Neither can compensate for the other. ⛔ **And `SRCHPO-X5` (`PO_DECISION_RESOLUTION_RECORD.md` **L442**) already REJECTED the claim that approving both behaviours decides both numbers** |
| **`P5`** | Maximum page size cap | ⭐ **NO DEPENDENCY** — ⚠ but **mitigating** | ✅ `P5` is **already closed**: `LCFG-12` = **20**, range 5–50, owner **Security** (`CONFIGURATION_GUIDE.md` **L362**). ⭐ It bounds **result volume**; `P4` bounds **match breadth**. ⚠ `P5` **mitigates** one `P4` risk (page weight) without **constraining** `P4`'s value. ⛔ Not a dependency |
| **`P6`** | Projection lag per event class | ⭐ **NO DEPENDENCY** | ✅ Also closed: `LCFG-6` = **60 s**, *"**Removal latency only**"* (**L356**), scoped by `LIB-16.9` (`Library_PRD_v1.md` **L721**/**L727**). ⭐ **Freshness** and **matching semantics** are orthogonal: `P6` decides *when* a document leaves the index, `P4` decides *whether* a token matches one that is in it |
| **`P7`** | Query latency / throughput / availability targets | ⭐ **NO DEPENDENCY** — ⛔ **and dependency is FORBIDDEN** | ⭐⭐ **The trap in this row.** Intuitively a shorter prefix costs more, so `P4` "depends on" the latency budget. ⛔ **`LIB-20.1` (`Library_PRD_v1.md` **L862-864**) forbids the reasoning**: *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. This PRD **MUST NOT** state a competing latency or availability figure."* ⛔⛔ **And that destination document DOES NOT EXIST** — `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L339** tags *"NFR Budgets (V1)"* as a planned node; `docs/10-architecture/` contains no such file (measured). ⇒ Making `P4` depend on `P7` would make it depend on a **non-existent document**, and would license this record to state a latency figure it is forbidden to state |
| **`P8`** | Rebuild availability posture and duration | ⭐ **NO DEPENDENCY** | `SRCH-INV-005` (rebuildable from the log) and `SRCH-FR-004` (events only) are **write-path** properties. ⭐ `P4` is a **read-path / query-semantics** property. ⚠ One indirect note: if `P2` changes the analyzer, a **reindex** is implied — but that is `P2` → `P8`, ⛔ **not** `P4` → `P8` |
| **`ENT`** | Query-time entitlement mechanism (`SRCH-GAP-003`, **L981**) | ⭐ **NO DEPENDENCY** | §27 (**L662-700**) separates the two decisions **by owner and by time**: indexing is the owning context's act; visibility is the **source system's**, re-evaluated **per query and per page** (`SRCH-FR-040`, **L644**). ⭐ `P4` selects **candidates**; `ENT` filters them. ⛔ A wider or narrower candidate set does not alter the gate. ⭐ Write-side already enforced: `SE-2` (`tool/module_dependencies.yaml` **L373-384**) |
| **`VOC`** | Variant / abbreviation vocabulary (`SRCH-GAP-007`, **L985**) | ⭐ **NO DEPENDENCY** — ⚠ **shares one parent with `P2`** | ⭐ **A distinction worth stating precisely.** `SRCH-GAP-007` has **two halves**: the **script inventory** (Product Owner — ✅ **closed** by `SRCHPO-1`) and the **declared vocabulary** (Architecture Owner, §20 V4 — still open). ⭐⭐ `P4` depends on the **closed** half only, and it depends on it **through `P2`**, not directly. ⛔ The **vocabulary** half is a §20 word-form/equivalence concern at **T3**; `P4` is at **T2**. ⇒ ⛔ **`P4` does NOT wait on `VOC`** |
| **`R1`** | Tenant data reaching the public index (**L960**) | ⭐ **NO DEPENDENCY** | Prevented **structurally, prior to matching**: `SRCH-INV-004`, `SRCH-INV-002`, `SRCH-FR-006`, test class `T-J`. ⭐ Mechanically reinforced by `SE-1` (*tenant-prefixed index name*, anti-pattern `X-13`) in the **build-failing** manifest. ⛔ A prefix rule operates **inside** one index class and cannot cross one |
| **`R2`** | Index becoming a silent authorisation bypass (**L961**) | ⭐ **NO DEPENDENCY** | Mitigated by §27 query-time re-evaluation + `SRCH-FR-040` + `SRCH-FR-012`–`014`. ⚠ Its residual is **`SRCH-GAP-003`** (= `ENT`), ⛔ **not** `P4`. ⭐ Even a `P4` of 1 unit cannot bypass a gate applied **after** candidate selection |

### 4.2 ⭐⭐ The four rows where the intuitive answer is wrong

⚠ Recorded explicitly, because each is a dependency a diligent reader would *assume* and the repository
*forbids* or *refutes*.

| Row | Intuition | Why the repository refutes it |
|---|---|---|
| **`P1`** | *"The engine's prefix implementation decides `P4`."* | ⛔ **Inverted.** `MP-CON-02` makes engine choice a **deployment** decision. `P4` is a **requirement** the engine must satisfy. Deriving `P4` from a vendor default is the `MP-CON-01` violation `ADR-0046` **L255-258** describes as treating corroboration as grounds |
| **`P3`** | *"Both are 'a minimum length in search', so one number serves both."* | ⛔ **Different tiers**, and `SRCH-FR-035` layer 1 makes the boundary uncrossable. ⛔ **`SRCHPO-X5` already REJECTED this exact inference** |
| **`P7`** | *"Shorter prefixes cost more, so the latency budget bounds `P4`."* | ⛔ **Forbidden reasoning** — `LIB-20.1`. ⛔ **And the target document does not exist** |
| **`VOC`** | *"`SRCHPO-1` is part of `SRCH-GAP-007`, so `P4` waits for `SRCH-GAP-007`."* | ⛔ **Half-wrong in the load-bearing direction.** `SRCHPO-1` **closed** the script half. `P4` needs that closure — and **already has it**. It does **not** need the vocabulary half |

### 4.3 ⭐⭐⭐ Can `P4` be resolved independently? — stated explicitly

> ⛔⛔ **NO.**
>
> **`P4` has exactly ONE `REQUIRED` dependency: `P2`.** 10 of 11 examined items are `NO DEPENDENCY`; **0** are
> `OPTIONAL`; **0** are `UNKNOWN`.
>
> ⭐⭐ **This is a material correction to `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` §7.5**, which
> recorded class A as *"the only class that can be decided by the Architecture Owner **alone, today**."* ⭐ The
> **owner** is right — it is the Architecture Owner, who owns `P2` as well. ⛔ The **"today"** is wrong: the
> conferral must state `P2`'s counting unit, or it states a length in no unit.
>
> ⭐ **The practical consequence is small and good:** `P4` and `P2` share **one owner** (`SRCH-GAP-002`,
> **L980**), so this is **sequencing within one owner's remit** — ⛔ **not** a cross-owner blockage like
> `SRCH-GAP-008`, whose owner does not exist. ⇒ ⭐ **`P4` is unblockable by a single decision session that
> declares the unit first.**

---

## 5. `PHASE 4` — candidate decision matrix

⛔⛔ **NO ROW CONTAINS A NUMBER.** ⛔ Rows are **classes of decision**, not values. ⛔ **No row is approved.**

| # | Candidate / existing authority | Repository evidence | Authority owner | Pros | Cons | Security impact | Product impact | Search impact | QA testability | Architecture impact | Dependency impact | **Status** |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **0** | ⭐ **An existing authority already determines `P4`** | ⛔ **0 hits** across `docs/` `tool/` `lib/`; **0** of 13 `LCFG-*`; **0** in EA search tree; **0** in `ARCHITECTURE_RULINGS`; **0** in `PRD-021C` C2; **0** in module manifest (§2.1) | — | Would need no decision | ⛔ **Does not exist** | — | — | — | — | — | — | ⛔ **REJECTED** — factually false |
| **1** | ⭐⭐ **Adopt a value common in search systems** (industry default) | ⛔ **None.** `MP-CON-01`/`MP-CON-02` **L237-238**; `ADR-0046` **L255-258** | ⛔ none | Fast | ⛔⛔ Fabrication; ⛔ vendor-derived; ⛔ breaches `PRD-015` **L496-499**'s own refusal | Unassessed | Unassessed | Unassessed | ⛔ Untraceable | ⛔ `MP-CON-01` breach | Ignores `P2` | ⛔ **REJECTED** — this is the exact act the instruction forbids |
| **2** | **Import a length constant from a sibling PRD** (`SCFG-1` 3–30 · Library Name 2–120 · `IC-3` 8) | `Student_Identity_PRD_v1.md` **L1335**/**L1340**; `Library_PRD_v1.md` **L212**; `CONFIGURATION_GUIDE.md` **L47** (§2.6) | Other BCs' owners | Values exist | ⛔⛔ **Different objects**: all bound a **stored field's** length, none a **query prefix's**; ⛔ different BCs, different owners; ⛔ analogy is not authority | Unassessed | ⛔ Alien contract | ⛔ Meaningless at T2 | ⛔ Fake trace | ⛔ Cross-BC value theft | Ignores `P2` | ⛔ **REJECTED** |
| **3** | **Derive `P4` from a latency budget** | ⛔ **Forbidden** — `LIB-20.1` **L862-864**; ⛔ target doc absent — EA **L339** (§4.1 `P7`) | SRE / OBSERVABILITY | — | ⛔⛔ Frozen-requirement breach **and** a non-existent destination | — | — | — | — | ⛔ `LIB-20.1` breach | ⛔ Invents a `P7` dependency | ⛔ **REJECTED** |
| **4** | ⭐ **Defer `P4` — leave it unresolved** | `SRCH-FR-030` **L518-520** is an unconditional **MUST** with ⛔ **no enabling condition and no disable clause**; `SRCH-BR-012`'s *"**MUST NOT** enable"* escape (**L561-562**) has ⛔ **no `SRCH-FR-030` counterpart** | Architecture Owner | Requires nothing | ⛔⛔ **A `MUST` stays unimplementable and `SRCH-AC-030`'s text limb keeps failing.** ⚠ `SRCH-GAP-002` **L980** already records it as **blocking Stage 3** | Neutral | ⛔ `SRCH-FR-030` unmet | ⛔ T2 incomplete | ⛔ `SRCH-AC-030` text limb fails | ⛔ Stage 3 stays blocked | Leaves `P2` gap visible | ⛔ **REJECTED as a resting state** — ⚠ **but see the honest note below** |
| **5** | ⭐⭐ **Class A — a single platform-wide minimum**, unit declared by `P2` | `SRCH-FR-009` **L337** uniform behaviour; `SRCH-FR-002` **L248** single query port; class B gated on `SRCH-GAP-009` (**L589**, **Product Owner**, OPEN); class C gated on `SRCH-GAP-008` (**L770**, ⛔ **no owner exists**) | **Architecture Owner** (`SRCH-GAP-002`) | ⭐ Simplest to audit; ⭐ **the only class not gated on another owner's open gap**; ⭐ satisfies `SRCH-FR-009` by construction | ⚠ One value must serve **text** and **exact** roles and **2 scripts**; ⚠ requires `P2`'s unit first | ⚠ Residual `R8` **accepted, not mitigated** — ⛔ `SRCH-GAP-008` ownerless | ⭐ Within contract iff `N ≤ 3` (§3.5) | ⭐ Deterministic once unit declared | ⭐ Testable once **`N` + `U`** stated; ⚠ needs a Devanagari case | ⛔ No new authority, no new edge, no new gap | ⛔⛔ **`REQUIRED`: `P2`** | ⭐ **RECOMMENDED as to FORM ONLY** — ⛔ **BLOCKED as to VALUE** |
| **6** | **Class B — per-field-role minimum** (`text` vs `exact`) | `SRCH-FR-018` **L375-376** declares the roles ⇒ ⭐ the **role** distinction exists independently of precedence; `SRCH-GAP-009` **L589** is about **precedence ORDER**, Product Owner, OPEN | Architecture Owner | ⭐ More precise; ⭐ recognises that a **PIN code** and a **library name** are different objects (`SRCH-FR-027` **L492-494**) | ⚠⚠ Two values, two units; ⚠ harder to keep uniform under `SRCH-FR-009`; ⚠ explainability burden under `SRCH-FR-036` | Same residual | Neutral | ⚠ More complex | ⚠ More cases | ⛔ No new authority needed | ⛔⛔ **`REQUIRED`: `P2`** (twice over) | ⚠ **DEFERRED** — ⭐ **lawful** (⛔ **correcting the prior record**, see note) but strictly larger than class A |
| **7** | **Class C — authenticated vs anonymous minimum** | `SRCH-GAP-008` **L770** — ⛔ *"**No owner exists** — `XPC-OD-010` is OPEN"*; ⚠ tension with `SRCH-FR-009` **L337** *"**MUST NOT** vary by consumer identity"* | ⛔ **No owner exists** | Would target the actual enumeration limb | ⛔⛔ **Cannot be conferred** — its security owner does not exist; ⚠ and it strains `SRCH-FR-009` | ⛔ Unclearable | Neutral | ⚠ Two semantics | ⚠ Doubled | ⛔ Would need `XPC-OD-010` closed | `REQUIRED`: `P2` **+ an owner that does not exist** | ⛔ **BLOCKED** |

### 5.1 ⭐⭐ Two corrections to the prior record, stated openly

⚠ **Correction 1 — class B is lawful, not barred.** `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` §7.4
recorded class B as gated on `SRCH-GAP-009`. ⭐ **Re-measured this pass: `SRCH-GAP-009` (L589) is about field
*precedence ORDER* for `SRCH-FR-035` layer 2 — not about field *ROLES*.** Roles are declared by `SRCH-FR-018`
(**L375-376**) and are **already available**. ⇒ ⛔ Class B is **not** blocked by `SRCH-GAP-009`; it is merely
**larger** than class A and carries a doubled unit problem. ⭐ Its status is therefore **`DEFERRED`, not
`BLOCKED`** — and this correction **widens** the owner's lawful choice rather than narrowing it.

⚠ **Correction 2 — row 4's rejection is narrower than it looks.** ⛔ Deferral is rejected as a **resting
state**, because `SRCH-FR-030` is a `MUST` and `SRCH-GAP-002` **L980** already records `P4` as blocking Stage 3.
⭐ **But deferral is the CURRENT lawful state**, precisely because `PRD-015` is **v0.1 `DRAFT` at Stage 2** and
`SRCH-GAP-002` blocks *"**Stage 3**; nothing in Stage 2."* ⇒ ⭐⭐ **`P4` being unresolved is lawful today and
unlawful at Stage 3 conferral.** Nothing in this record accelerates that boundary.

### 5.2 The matrix verdict

> ⭐ **1 row RECOMMENDED as to form only** (row 5, class A) · ⚠ **1 DEFERRED** (row 6) ·
> ⛔ **2 BLOCKED** (row 5's value limb, row 7) · ⛔ **4 REJECTED** (rows 0–3, and row 4 as a resting state).
>
> ⛔⛔ **`P4` OVERALL STATUS: `BLOCKED`.**
>
> ⭐ It is `BLOCKED` **as to value** by a `REQUIRED` dependency on `P2` (§4.1). It is `RECOMMENDED` **as to
> form** at class A. ⛔ **These are two different statements about two different limbs, and neither is an
> approval.**

---

## 6. `PHASE 5` — human Architecture Owner decision form

⛔⛔ **EVERY HUMAN FIELD BELOW IS DELIBERATELY BLANK.** ⛔ A blank form is **not** a conferral. ⛔ This record
**MUST NOT** be read as containing a decision.

---

> ### `SRCHAO-P4` — MINIMUM PREFIX LENGTH
>
> **Decision ID:** `SRCHAO-P4`
>
> ⭐ *Continues the identifier opened at `PRD-015_ARCHITECTURE_OWNER_DECISION_PACKET.md` §7 (**L207-231**).*
> ⛔ **No new ID is minted; that record is not edited.**
>
> **Question:**
> *"What minimum prefix length **SHALL** govern `SRCH-FR-030` for `PRD-015` V1?"*
>
> ⭐⭐ **Question as refined by this audit — the owner must answer BOTH limbs, in this order:**
> **(a)** In what **UNIT** is a prefix length counted on a `P2`-normalized token — *characters*, *Unicode code
> points*, or *user-perceived graphemes* — given that `SRCHPO-1` closes V1 at **Latin + Devanagari**?
> **(b)** What **minimum length**, in that unit, **SHALL** apply — and to which **match roles** (`text`,
> `exact`, or both)?
> ⛔ **Answering (b) without (a) does not close `P4`** (§4.3).
>
> **Repository evidence:**
> - `docs/30-product/search/PRD-015_SEARCH_INDEXING.md` **L518-520** — `SRCH-FR-030`, unconditional `MUST`,
>   no suffix/infix on `exact`-role fields
> - **L1103-1105** — `SRCH-AC-030`, the only AC that tests `P4`; its token `Lib` is **3** units
> - **L375-376** `SRCH-FR-018` · **L492-494** `SRCH-FR-027` — `exact` role is *"exact/prefix only"* ⇒ `P4`
>   governs `exact` fields too
> - **L838** + **L980** — `SRCH-GAP-002` row `P4`; owner **Architecture Owner**; blocks **Stage 3**
> - **L496-499** — the subject's own refusal to carry a value
> - **L414-424** `SRCH-FR-023`/`024` `N4`/`N5`/`N6` · **L426-428** `SRCH-BR-008` — the unit is a `P2` property
> - **L337** `SRCH-FR-009` — matching **MUST NOT** vary by consumer identity
> - **L524-527** `SRCH-BR-010` — conjunctive multi-word narrowing
> - **L586-596** `SRCH-FR-035`/`036` · **L603-604** `SRCH-BR-013` — no score; no-tier ⇒ excluded
> - **L750** `S2` · **L770** `SRCH-GAP-008` — enumeration; ⛔ **no owner exists** (`XPC-OD-010` OPEN)
> - `docs/30-product/search/PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L57** `SRCHPO-1` — Latin + Devanagari,
>   closed set · **L75** `SRCHPO-6` — behaviour ENABLED, ⛔ number withheld · **L442** `SRCHPO-X5` — ⛔ the
>   "approval implies the number" inference **REJECTED**
> - `docs/20-configuration/CONFIGURATION_GUIDE.md` **L351-363** — all 13 `LCFG-*`; ⛔ **none** governs `P4`
> - `docs/30-product/library/Library_PRD_v1.md` **L862-864** `LIB-20.1` — ⛔ no competing latency figure
> - `docs/30-product/MASTER_PRD.md` **L237-238** `MP-CON-01`/`MP-CON-02` — ⛔ no vendor-derived value
> - `tool/module_dependencies.yaml` **L373-384** — `platform/search`, `SE-1`, `SE-2`; ⛔ no matching parameter
>
> **Architecture recommendation:**
> ⛔⛔ **`BLOCKED` as to VALUE** — `REQUIRED` dependency on `P2` (the counting unit), §4.3.
> ⭐ **`RECOMMENDED` as to FORM ONLY** — **class A**, a single platform-wide minimum, because classes B and C are
> each strictly larger and class C is unconferrable (`SRCH-GAP-008` has no owner).
> ⛔ **NO NUMERIC VALUE IS RECOMMENDED.**
>
> **Options:**
>
> **A.** ⭐ **Declare `P2`'s counting unit, then set a single platform-wide minimum in that unit**
> (repository-supported **as to form**: `SRCH-FR-009` **L337**, `SRCH-FR-002` **L248**; ⛔ **value not supplied
> by any authority**; ⚠ constrained by `N ≤ 3` for Latin per `SRCH-AC-030`)
>
> **B.** ⚠ **Declare `P2`'s counting unit, then set per-match-role minima** (`text` vs `exact`)
> (repository-supported **as to form**: `SRCH-FR-018` **L375-376**, `SRCH-FR-027` **L492-494**; ⚠ doubles the
> unit and explainability burden under `SRCH-FR-036`)
>
> **C.** ⭐ **`DEFER` — lawful ONLY while `PRD-015` remains at Stage 2**
> (`SRCH-GAP-002` **L980**: blocks *"**Stage 3**; nothing in Stage 2"*. ⛔ **NOT lawful as a Stage 3 conferral
> state**, because `SRCH-FR-030` is an unconditional `MUST` with no disable clause and `SRCH-AC-030`'s text limb
> would be knowingly failing)
>
> **D.** **Other — human-specified, subject to repository compatibility review**
> (⚠ must satisfy: `SRCH-FR-030` · `SRCH-AC-030` incl. `Lib` at 3 units · `SRCH-BR-008` symmetry ·
> `SRCH-FR-009` uniformity · `SRCH-FR-034` determinism · `SRCH-FR-036` explainability · `SRCHPO-1` both
> scripts. ⛔ **MUST NOT** be derived from a vendor default (`MP-CON-01`) or from a latency figure
> (`LIB-20.1`))
>
> **Selected option:**
> ⬜ *(BLANK)*
>
> **Counting unit selected (limb a):**
> ⬜ *(BLANK)*
>
> **Minimum length selected (limb b):**
> ⬜ *(BLANK)*
>
> **Match roles it applies to:**
> ⬜ *(BLANK)*
>
> **Architecture Owner:**
> ⬜ *(BLANK)*
>
> **Conferral authority:**
> ⬜ *(BLANK)*
>
> **Decision date:**
> ⬜ *(BLANK)*
>
> **Rationale:**
> ⬜ *(BLANK)*
>
> ---
>
> ⚠⚠ **REQUIRED ACKNOWLEDGEMENTS — a conferral that omits these is incomplete (§3.4, §3.5):**
>
> | # | Acknowledgement | Why | Signed |
> |---|---|---|---|
> | **1** | ⛔ **`SRCH-GAP-008` has NO OWNER** (`XPC-OD-010` OPEN, **L770**). Any `P4` value **accepts** residual `R8` anonymous-query-volume risk rather than mitigating it | Security cannot clear `P4`; the owner accepts, not delegates | ⬜ *(BLANK)* |
> | **2** | ⭐ **`P2`'s counting unit is declared** — or `P4` is a length in no unit across 2 of 2 supported scripts | §4.3 | ⬜ *(BLANK)* |
> | **3** | ⭐ **At least one Devanagari prefix acceptance case will be added** — §20's AC set contains none, yet `SRCHPO-1` makes Devanagari a V1 canonical script | §3.5 | ⬜ *(BLANK)* |
> | **4** | ⭐ **The value is recorded against `SRCH-GAP-002`** (**L838**/**L980**) — ⛔ **not** duplicated into a new authority | §3.2 | ⬜ *(BLANK)* |

---

⛔ **The fields above are BLANK and were left BLANK deliberately.** ⛔ **No selection, no owner, no date, no
rationale, no signature has been supplied by this record.**

---

## 7. `PHASE 6` — no false closure

⭐ The rule, applied to this document and verified line by line.

| # | Test | Result |
|---|---|---|
| 1 | Does an authoritative `P4` value already exist? | ⛔ **NO** — §2.7, measured **0** hits across every scope |
| 2 | Has a properly conferred Architecture Owner explicitly decided a value? | ⛔ **NO** — §6 is **blank** |
| ⇒ | **Is `P4` CLOSED?** | ⛔⛔ **NO. `P4` is `BLOCKED`.** |

| Claim | Present in this document? |
|---|---|
| *"approved"* | ⛔ **NO** |
| *"conferred"* | ⛔ **NO** |
| *"closed"* | ⛔ **NO** |
| *"resolved"* | ⛔ **NO** |
| A numeric prefix length | ⛔ **NO** |
| A recommendation as to **form** (class A) | ⭐ **YES — and it is labelled a recommendation, in every one of the 4 places it appears** |

⭐⭐ **Three inheritance claims explicitly refused:**

1. ⛔ **`SRCHPO-6` does NOT decide `P4`.** The Product Owner approved *prefix matching* and recorded *"⛔ No
   numeric prefix length invented"* (**L75**). ⭐ `SRCHPO-X5` (**L442**) already **REJECTED** the contrary
   inference, and the label map (**L161**) states *"⛔ **Not** P4 (min prefix length)"*.
2. ⛔ **`ADR-0094` does NOT decide `P4`.** It decided the **contract** (§14A **is** the V1 `BC-23` discovery
   contract) and states it *"does **not** author `PRD-015`"*. ⭐ `PRD-015` **L827** repeats it: the ADR decided
   *"the **contract**, not the **engine**."*
3. ⛔ **`ADR-0046`'s conferral does NOT transfer.** It conferred **one** decision — the payment gateway — and
   §9 (**L240-266**) records that a further decision *"requires its own conferral."* ⭐ **That is the governing
   precedent for `P4`: conferral is per-decision, from outside the repository, recorded explicitly.**

⛔ **A decision-preparation document is not conferral.** ⭐ This document is a decision-preparation document.

---

## 8. `PHASE 8` — validation

### 8.1 Integrity of the subject and the frozen corpus

| # | Check | Result |
|---|---|---|
| 1 | `SRCH-FR-030` (**L518-520**) intact and byte-unchanged | ✅ **YES** — verified by whole-file sha256 |
| 2 | `SRCH-AC-030` (**L1103-1105**) intact and byte-unchanged | ✅ **YES** — same |
| 3 | `PRD-015` subject sha256 = `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` | ✅ **YES** — measured before **and** after |
| 4 | The other four `PRD-015` records unmodified | ✅ **YES** — **0** edits; read-only |
| 5 | `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` unmodified | ✅ **YES** — ⭐ corrected **beside** it (§5.1), ⛔ **never** by editing it |
| 6 | No frozen document modified | ✅ **YES** — `Library_PRD_v1.md`, `MASTER_PRD.md`, all ADRs read-only |
| 7 | `PRD-021A` / `PRD-021B` / `PRD-021C` unmodified | ✅ **YES** — last touched at historical commit `16644ee` |

### 8.2 Nothing created that must not be created

| # | Check | Result |
|---|---|---|
| 8 | No implementation code | ✅ **YES** — **0** files under `lib/` touched; **0** Dart, **0** YAML, **0** manifest edits |
| 9 | No `IMPL-*` identifier | ✅ **YES** — **0** concrete `IMPL-NNNN` identifiers. ⭐ The token `IMPL-*` appears **3** times, in **every** case as a wildcard inside a **negative declaration** (header row 13, this row, §9 row 6) |
| 10 | No ADR created | ✅ **YES** — `ADR-0088`/`0089`/`0090` remain **RESERVED and UNWRITTEN** (measured: **0** matching files) |
| 11 | No reserved ADR consumed | ✅ **YES** |
| 12 | No edge (`E-*`) created | ✅ **YES** |
| 13 | No bounded context (`BC-*`) created | ✅ **YES** |
| 14 | No new `SRCH-*` requirement, AC, BR, INV, XC or GAP minted | ✅ **YES** — ⭐ `SRCHAO-P4` **continues** the existing packet identifier; ⛔ nothing new is minted |
| 15 | No new authority for `P4` | ✅ **YES** — ⭐⭐ `SRCH-GAP-002` (**L838**/**L980**) remains the sole owner; ⛔ **not duplicated** |
| 16 | No fabricated benchmark | ✅ **YES** — **0** measurements claimed; §3.3 states this twice |
| 17 | ⭐⭐ **No numeric prefix length anywhere in this document** | ✅ **YES** — the only numerals in a `P4` context are **citations** (`SRCH-AC-030`'s `Lib` = 3 as a **ceiling derived from a frozen AC**; `LCFG-12` = 20; `LCFG-6` = 60 s; `SCFG-1` = 3–30 **as a REJECTED source**) |

### 8.3 No stage, rank or baseline movement

| # | Check | Result |
|---|---|---|
| 18 | No rank changed | ✅ **YES** |
| 19 | No baseline changed | ✅ **YES** |
| 20 | Stage 4 **NOT** entered | ✅ **YES** — **0** Stage-4 artefacts; `docs/30-product/search/` contains the subject + 5 records + this file |
| 21 | Stage 7 / freeze **NOT** entered | ✅ **YES** |
| 22 | `PRD-015` still v0.1 `DRAFT`; Stage 3 still **CONDITIONAL / NOT CONFERRED** | ✅ **YES** — header row 18 |
| 23 | `PRD_REGISTRY.md` **L315** still reads `PLANNED` | ✅ **YES** — unmodified |
| 24 | `PRD_OWNERSHIP_MODEL.md` §7 rule 4 — no personal name recorded | ✅ **YES** — §3 names **disciplines**; §6's owner field is **blank** |

### 8.4 Repository validators

| Validator | Result |
|---|---|
| `tool/docs_check/alignment_record_freshness.py` | ▶ **RUN.** ⭐ **`PRD-015` is not among its 2 registered `RECORDS`** (`PRD-008`, `PRD-019` — validator **L78-88**), so it neither passes nor fails on `PRD-015`. ⚠ Its **1 pre-existing problem** (`PRD-019_ARCHITECTURE_ALIGNMENT.md`: *"no 64-hex hash in the record chain"*) is **unchanged by this pass** and ⛔ **out of `P4` scope** |
| `tool/docs_check/prd0*_traceability.py` · `prd0*_stage5.py` · `prd0*_task_coverage.py` | ⛔ **Not applicable.** Measured: **no `prd015_*` validator exists**. ⭐ Consistent — those gates serve Stage 4/5 PRDs, and `PRD-015` is a Stage-2 draft |
| ⭐ **Manual gate substituted for the absent one** | The subject's sha256 was measured **before and after** this pass and is **identical** — the same anchor the freshness gate exists to protect |

⭐ **Stated plainly, per the validator's own words:** *"This gate reports drift. It does not confer, refresh or
repair a stage verdict."* ⛔ **Neither does this document.**

---

## 9. What this document does NOT do

⛔ Enumerated so that no future reader can over-read it.

| # | It does NOT |
|---|---|
| 1 | ⛔ Decide `P4`. ⛔ Recommend a numeric prefix length. ⛔ Supply a default |
| 2 | ⛔ Confer, approve, close or resolve anything |
| 3 | ⛔ Enter Stage 4. ⛔ Freeze, baseline or rank `PRD-015` |
| 4 | ⛔ Modify `PRD-015_SEARCH_INDEXING.md` or any of the 5 prior records |
| 5 | ⛔ Create a second authority for `P4` — `SRCH-GAP-002` keeps it |
| 6 | ⛔ Create an ADR, an edge, a BC, an `IMPL-*`, or any new `SRCH-*` identifier |
| 7 | ⛔ Decide `P1`, `P2`, `P3`, `P5`, `P6`, `P7`, `P8`, `ENT`, `VOC`, `R1` or `R2` — ⭐ it only measures whether `P4` **depends** on them |
| 8 | ⛔ Close `SRCH-GAP-002`, `SRCH-GAP-007`, `SRCH-GAP-008` or `SRCH-GAP-009` |
| 9 | ⛔ Assign an owner to `SRCH-GAP-008` — ⭐ it records that **none exists** |
| 10 | ⛔ Name a search engine, library, analyzer, stemmer or vendor |
| 11 | ⛔ State a latency, throughput, availability or index-size figure — `LIB-20.1` forbids it |
| 12 | ⛔ Record a personal name — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | ⭐ **Created.** Scope: **`P4` ONLY**. Phase 1 audited 8 search scopes and classified 29 hits **A–F** (A=8 · B=6 · C=5 · D=2 · E=7 · F=1); ⛔ **0 authoritative `P4` values found**, including **0 of 13** `LCFG-*` constants. Phase 2 ran five expert reviews — **5 of 5** converged on `BLOCKED`/`CANNOT CLEAR`, **0 of 5** produced a number. Phase 3 determined **1 `REQUIRED`** dependency (**`P2`**, the counting unit) and **10 `NO DEPENDENCY`**, with 4 counter-intuitive rows recorded explicitly. Phase 4 built a 12-column matrix: **4 REJECTED · 2 BLOCKED · 1 DEFERRED · 1 RECOMMENDED-as-to-form**. Phase 5 left **all** human fields **BLANK**. ⭐⭐ **Two corrections made beside — never inside — the prior record:** (i) `P4` is **`BLOCKED`, not merely OPEN**, because it is a length with no defined unit across `SRCHPO-1`'s two mandated scripts; (ii) **class B is lawful**, since `SRCH-GAP-009` governs field *precedence order*, not field *roles*. ⛔ **Values invented: ZERO.** ⛔ **Authorities created: ZERO.** |

---

⛔⛔ **END OF `P4` RECORD. `P4` IS `BLOCKED`. NO VALUE EXISTS. NO VALUE IS RECOMMENDED. NO CONFERRAL HAS
OCCURRED. `PRD-015` REMAINS v0.1 `DRAFT` AT STAGE 3 CONDITIONAL / NOT CONFERRED.**
