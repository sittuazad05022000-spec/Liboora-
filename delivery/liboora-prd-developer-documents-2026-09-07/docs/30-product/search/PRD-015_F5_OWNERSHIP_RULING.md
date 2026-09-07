# PRD-015 — `F-5` Ownership Ruling

| Field | Value |
|---|---|
| **Document** | `F-5` ownership ruling — root-blocker / dependency-first audit |
| **Type** | ⛔ **Decision-PREPARATION record.** Not a requirement source, not an ADR, not a conferral |
| **Scope** | ⛔ **ONLY** the ownership question surrounding `PRD-015` finding **`F-5`** |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) — `v0.1 DRAFT`, Stage 2, sha256 `fe3093e6…c2c4544` |
| **Rank** | ⛔ **None.** Rank is conferred by a baseline act; this record claims none |
| **Conferral** | ⛔ **NOT CONFERRED** |
| **Version** | v1.0 — 2026-09-03 |

> ### ⛔ WHAT THIS RECORD IS NOT
>
> It does **not** decide `P2-D`, `P2-B`, `P2U`, `P2-A`, `P2-C`, `P3`, `P4`, `P1`, `P7`, `P8`, `ENT`, `VOC`, `R1`
> or `R2`. It creates **no** owner, **no** role, **no** person, **no** BC, **no** edge, **no** ADR, **no**
> `IMPL-*`, **no** configuration authority, **no** ranking, **no** baseline.
>
> **It answers one question and no other: who lawfully owns `F-5`.**
>
> ⚠ **Two prior claims are CORRECTED by measurement in this pass.** Both were re-verified from primary
> authority rather than inherited. See §2.3 and §4.4.

### READING KEY — registers never blended

| Register | Meaning |
|---|---|
| `FACT` | Measured from repository bytes. Cited by file and line |
| `EVIDENCE` | The exact citation supporting a `FACT` |
| `CANDIDATE` | An authority tested for ownership. Testing is not assigning |
| `EXPERT` | A reviewer finding. ⚠ Persuasive, **not** authoritative |
| `HUMAN` | ⛔ A field only a named owner may fill. **BLANK here, always** |

---

## 1. Phase 0 — repository integrity

| # | Gate | Expected | Measured | Verdict |
|---|---|---|---|---|
| 1 | Branch | `main` | `main` | ✅ |
| 2 | HEAD | — | `c519cd2` | ✅ |
| 3 | `github/main` | == HEAD | `c519cd2` | ✅ |
| 4 | Ahead / behind | 0 / 0 | **0 / 0** | ✅ |
| 5 | Working tree | clean | clean | ✅ |
| 6 | ⭐ **Subject sha256** | `fe3093e6…c2c4544` | **identical** | ✅ **PASS** |
| 7 | `PRD_REGISTRY.md` **L315** | `PLANNED` | `PLANNED` | ✅ unchanged |
| 8 | Subject header **L11-12** | `v0.1 DRAFT`, Stage 2 | *"NOT approved… NOT frozen. NOT baselined. No rank held"* | ✅ |
| 9 | Ownership model | exists | `PRD_OWNERSHIP_MODEL.md`, 644 lines, **v1.1 Active** | ✅ |
| 10 | BC Map | exists | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **v1.11**, 31 contexts | ✅ |
| 11 | `MASTER_PRD.md` | Rank 1 | present | ✅ |
| 12 | Architecture rulings | exists | `ARCHITECTURE_RULINGS.md`, 301 lines | ✅ |
| 13 | Configuration docs | exist | `CONFIGURATION_GUIDE.md` · ⭐ **`PRD-023`, 1457 lines, FROZEN** | ✅ |
| 14 | Prior `PRD-015` records | 8 | 8 (7 + the dependency-resolution record) | ✅ |

⛔ **Subject unchanged ⇒ no STOP condition triggered.**

### 1.1 Disclosed limitation

`FACT` — `tool/docs_check/` contains **32** entries and ⛔ **no `prd015_*` validator**. Per instruction **none was
created**. Manual integrity checks are used (§13) and this limitation is disclosed rather than papered over.

---

## 2. What `F-5` actually is — reconstructed from primary authority

### 2.1 The originating text

`FACT` — Subject **L416**, verbatim, re-read this pass:

```
SRCH-FR-024 — Normalization MUST, where compatible with the field's
declared script and language scope:
```

followed by rules `N1`–`N6` (**L418-425**).

`FACT` — Subject **L414**, `SRCH-FR-023`: *"Normalization **MUST** be applied **identically** at index time and at
query time, by the same declared rule set."*

`FACT` — Subject **L427**, `SRCH-BR-008`: *"Normalization **MUST** be symmetric and total."*

⇒ **`F-5` is the authoritative per-field script/language applicability predicate that `SRCH-FR-024`'s preamble
presupposes and no document supplies.**

### 2.2 The seven concepts, held separate

⚠ Instruction §3 requires these **not** be combined unless repository authority combines them. Measured
separately:

| | Concept | Does repository authority supply it? | Evidence |
|---|---|---|---|
| **A** | **Field schema declaration** | ⚠ **PARTIALLY** — a field **list** exists; no field **schema** | ⭐ §14A.4 / §14A.5 — see §2.4 |
| **B** | **Language declaration** | ⚠ **PARTIALLY** — platform-level **set** only | `SRCHPO-1`: English/Latin + Hindi/Devanagari, **closed set** |
| **C** | **Script declaration** | ⛔ **NO** — per-field, nowhere | ⭐ **0 hits** outside `PRD-015`'s own text — §2.3 |
| **D** | **Normalization-rule applicability** | ⛔ **NO** — this is exactly what is missing | `SRCH-FR-024` **L416** |
| **E** | **Query-side applicability** | ⛔ **NO — and there is no field at all** | A raw query string carries no field |
| **F** | **Index-side applicability** | ⛔ **NO** — a field exists but declares no script | §14A.4/§14A.5 |
| **G** | **Tokenization applicability** | ⛔ **NO** — and the tokenizer is deliberately undefined | `SRCHPO-5` (**L74**): *"the **tokenizer algorithm** is deliberately **not** defined"* |

⭐⭐ **A, B and C are three different things and only C is F-5's subject.** `SRCHPO-1` supplies a platform script
**SET**; `SRCH-FR-024` needs a per-field script **FUNCTION**. A set is not a function.

### 2.3 ⭐ Repository-wide measurement of the predicate

`FACT` — `grep -rniE "declared script" docs/ tool/` returns hits in **exactly three files**, all inside the
`PRD-015` family:

| File | Nature of hit |
|---|---|
| `PRD-015_SEARCH_INDEXING.md` **L416** | The requirement **asking** the question |
| `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101**, **L434** | Discusses it as a **gap**/**scope**, does not declare it |
| `PRD-015_P2_ARCHITECTURE_DECISION.md` (multiple) | Analyses it as a **blocker** |

`FACT` — Targeted authority searches, all **0 hits**:

```
grep -rniE "script (authority|owner)"                        →  0
grep -rniE "field.schema (owner|authority)|schema authority" →  0
grep -rniE "language authority"                              →  0 (outside PRD-015 family)
```

⛔ **No document outside `PRD-015` itself mentions a declared script at all.** The predicate is not
under-specified — it is **absent**.

### 2.4 ⭐⭐⭐ The decisive new measurement — `ADR-0094` §14A field set contains no script attribute

⚠ **This test was not run in prior passes and is the strongest evidence in this record.**

`FACT` — `ADR-0094` (**ACCEPTED**, Rank 2) **L64-65**: *"**§14A.4 / §14A.5** define the **indexable and queryable
field set** for V1 library discovery. `BC-23` indexes these fields and no others."*

⇒ If **any** document declares a per-field script, it must be §14A.4/§14A.5. Read verbatim:

`FACT` — `14A-Library-Discovery-And-Enrollment.md` **L98-132** (§14A.4) and **L134-189** (§14A.5) list field
**names only** — *Library Name · Logo · Cover Image · Gallery · Description · Business Address · Map Location ·
Operating Hours · Weekly Holidays · Facilities & Amenities · Membership Plans & Pricing · Seat Capacity ·
Library Status · Business Contact Information*.

`FACT` — `grep -niE "script|language|locale|normali[sz]|devanagari|hindi|unicode|analyz"` across that entire
374-line file returns **2 hits**, and ⭐ **neither is a declaration**: **L15** *"normalisation or summarisation"*
(prose about AI) and **L146** *"Description"* (matched on the substring `script` **inside the word
"Description"**) — ⚠ a **false friend**, excluded.

⭐⭐⭐ **The authoritative indexable field set declares field NAMES and nothing else — no type, no script, no
language, no collation.** `F-5` is therefore absent from the one document `ADR-0094` makes authoritative for it.

---

## 3. `CANDIDATE` authority discovery — every governance source searched

### 3.1 Sources inspected

| Source | Rank | Result |
|---|---|---|
| `PRD_OWNERSHIP_MODEL.md` | unranked | ⭐ **4 roles assigned to `PRD-015`** — §3.2 |
| `PRD_REGISTRY.md` | unranked | ⭐ **`BC-25` claim CORRECTED** — §4.4 |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | `BC-23` **L132**, `BC-25` **L134** — neither mentions script |
| `MASTER_PRD.md` | 1 | §8 module 18 = `BC-25`; no script/language authority |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | 6 | ⛔ *descriptive only*, cannot mint a requirement |
| `CONFIGURATION_GUIDE.md` | 7 | ⭐ `LCFG-2` Language — tested in §4.3 |
| `ARCHITECTURE_RULINGS.md` | — | **1 hit**, branding values → `BC-25`. ⛔ No script authority |
| `tool/module_dependencies.yaml` | 4 | `platform/search` rank 5; ⛔ no ports block, no script assertion |
| `ADR-0013`, **`ADR-0017`**, `ADR-0094` | 2 | ⭐ `ADR-0017` tested in §4.4 |
| `PRD-023_SETTINGS_AND_CONFIGURATION.md` | 3 | ⭐ **FROZEN.** Tested in §4.4 |
| `14A-Library-Discovery-And-Enrollment.md` | 3 | ⭐⭐⭐ **§2.4 — the decisive negative** |
| All 8 prior `PRD-015` records | — | Re-verified, not inherited |

### 3.2 ⭐ `FACT` — `PRD-015` has all four roles assigned

`EVIDENCE` — `PRD_OWNERSHIP_MODEL.md` **L197**, verbatim:

```
| PRD-015 | Search Indexing | BC-23 | Product Owner | Search Platform | ARB | Platform Engineering |
```

| Role | Holder | Status |
|---|---|---|
| Product Owner | **Product Owner** | ✅ assigned |
| Domain Owner | **Search Platform** | ✅ assigned |
| **Architecture Owner** | ⭐ **ARB** | ✅ **assigned — NOT vacant** |
| Technical Owner | Platform Engineering | ✅ assigned |

`FACT` — `PRD_OWNERSHIP_MODEL.md` **§2.2**: the Architecture Owner *"Decides ADR approval; any Rank 1–5 document
change; every §11 exception"* and is accountable for *"Boundaries, ranks, permitted edges, precedence."*

`FACT` — **§2.3**: *"**`ADR-INDEX` and Matrix §11 both name the Architecture Review Board as the approving body.**
Architecture Owner is the role; ARB is that role sitting as a board. **They are not two authorities.**"*

⭐⭐ **The Architecture Owner role EXISTS and HAS A HOLDER for `PRD-015`.**

### 3.3 ⭐ `FACT` — the repository names the owner of P2 directly

`EVIDENCE` — Subject **L980**, `SRCH-GAP-002`, verbatim:

```
| SRCH-GAP-002 | All implementation parameters P1–P8: engine, analyzer config,
edit-distance bound, minimum token/prefix length, page-size cap, projection lag,
latency/availability targets, rebuild posture, transport binding
| Architecture Owner | Stage 3; nothing in Stage 2 | §36; ADR-0094 §5 |
```

`EVIDENCE` — Subject **L836** (§36): *"P2 | Analyzer, tokenizer and normalization rule configuration |
`SRCH-FR-023`, `SRCH-FR-024`"*.

⭐⭐ **`SRCH-FR-024` — the requirement whose preamble contains `F-5` — is expressly inside `P2`, and `P2`'s owner
is expressly the Architecture Owner.**

`EVIDENCE` — Subject **L985**, `SRCH-GAP-007`: *"The language/script inventory … | **Product Owner** (markets)
**+ Architecture Owner** (analyzer)"* — ⭐ a **split** owner, and the analyzer half is the Architecture Owner.

`EVIDENCE` — `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101**: *"**Analyzer configuration** for the declared
scripts | **Architecture Owner** | ⛔ **NO**"* — the Product Owner **declined** it and named the Architecture
Owner.

---

## 4. `CANDIDATE` analysis — eight tests per candidate

⚠ Instruction §5: *"Do NOT assume any of these is correct."* Each candidate is tested against all eight
questions.

### 4.1 `CANDIDATE` — Architecture Owner (ARB)

| # | Test | Result |
|---|---|---|
| 1 | Repository explicitly grants authority? | ✅ **YES** — **L980** names it owner of `P2`; ownership model **§2.2** grants Rank 1–5 change authority |
| 2 | Scope includes per-field script/language declaration? | ✅ **YES** — `SRCH-FR-024` is inside `P2` (**L836**); **L985** assigns the *analyzer* half |
| 3 | Includes normalization applicability? | ✅ **YES** — `P2` is verbatim *"normalization rule configuration"* |
| 4 | Creates duplicate ownership? | ⛔ **NO** — no competing claimant measured (§4.2–§4.5) |
| 5 | Violates a frozen PRD? | ⛔ **NO** — declaring an analyzer predicate restates no §14A field ⇒ `SRCH-XC-001` (**L158**) intact |
| 6 | Creates a second source of truth? | ⛔ **NO** — it would be the **first** |
| 7 | Role has a registered holder? | ✅ **YES — `ARB`**, ownership model **L197** |
| 8 | Can lawfully decide under current governance? | ⚠ **PARTIALLY — see §4.1.1** |

#### 4.1.1 ⭐⭐ The residual limit on test 8

`FACT` — `SRCH-XC-001` (**L158**): *"`BC-23` **MUST NOT** define, alter or restate any §14A field, eligibility
rule or visibility rule."*

⚠ Two readings exist, and this record does **not** choose between them:

| Reading | Consequence |
|---|---|
| **(i)** A script attribute is an **analyzer** property of how `BC-23` processes a field | Architecture Owner may decide alone ⇒ `F-5` is **decidable by the assigned holder** |
| **(ii)** A script attribute is a **field schema** property of the §14A field itself | ⛔ `SRCH-XC-001` bars `BC-23`; it becomes a **§14A product statement** ⇒ Product Owner, on the `SRCH-GAP-009` pattern |

⛔ **The repository does not state which reading governs, and this record MUST NOT choose.** That choice is
itself the ownership ruling.

### 4.2 `CANDIDATE` — `BC-23` Search Indexing / `PRD-015` itself

| # | Test | Result |
|---|---|---|
| 1 | Explicit authority? | ⚠ **PARTIAL** — BC Map **L132** grants *"query rewriting"*, not field declaration |
| 2 | Scope includes per-field script declaration? | ⛔ **NO** |
| 5 | Violates a frozen PRD? | ⛔⭐ **YES if reading (ii)** — `SRCH-XC-001` self-bars |
| 6 | Second source of truth? | ⛔⭐ **YES** — would compete with §14A |
| 8 | Can lawfully decide? | ⛔ **NO.** ⭐ **`PRD-015` is `PLANNED`/Stage 2 and holds no rank** — it cannot confer authority on itself |

❌ **`BC-23` cannot own `F-5` by itself.**

### 4.3 `CANDIDATE` — `LCFG-2` Language

`FACT` — `CONFIGURATION_GUIDE.md` **L352**: *"`LCFG-2` | Language | `en` | Supported set | **Product** | Only
locale with complete strings at V1"*. Identical at `Library_PRD_v1.md` **L717**.

| # | Test | Result |
|---|---|---|
| 2 | Scope includes per-field script? | ⛔ **NO** — it is a **UI string locale**, tenant-scoped, default `en` |
| 3 | Includes normalization applicability? | ⛔ **NO** |
| 6 | Second source of truth? | ⛔⭐ **YES** — it would make search normalization follow a **UI display setting** |

❌ **Rejected.** ⭐ **`LCFG-2` is a false friend:** its value `en` and owner *Product* look like an answer, but a
tenant's interface language cannot determine the script of an indexed field — a tenant set to `en` may hold a
Devanagari library name, which is exactly the case `SRCHPO-1` admits.

### 4.4 ⭐⭐⭐ `CANDIDATE` — `BC-25` Configuration / `PRD-023` — **two prior claims CORRECTED**

⚠ **Instruction §2 requires re-verifying, not inheriting. Doing so overturned two statements.**

#### Correction 1 — `BC-25` **HAS** a registered claimant

`FACT` — `PRD_REGISTRY.md` **L414** does read *"`BC-25` Configuration has no registered claimant."* ⛔ **But
reading that line alone is a measurement error.** **L417-420**, immediately below it:

> *"**→ RESOLVED 2026-08-04 by `ADR-0017`.** … `PRD-023` is now allocated (§4.3). **The sentence above is
> preserved because the reasoning that produced it … is exactly what surfaced the question.**"*

`FACT` — Supporting measurements:

| Evidence | Measurement |
|---|---|
| `ADR-0017` | ⭐ **ACCEPTED** 2026-08-04, Rank 2 — *"`BC-25` Configuration is owned by `PRD-023`"* |
| `PRD_REGISTRY.md` **L337** | `PRD-023` = ⭐ **`FROZEN`**, **Rank 3**, `BASELINE-2026-08-20-A` |
| `PRD_REGISTRY.md` **L458** | *"`BC-25` \| **`PRD-023`** \| **No** — resolved 2026-08-04"* |
| `PRD_REGISTRY.md` **L550** | ⭐ *"**Contested bounded contexts: 0**"* |
| `PRD_OWNERSHIP_MODEL.md` **L205** | `PRD-023` → Domain Owner **Configuration Platform** |
| File | `PRD-023_SETTINGS_AND_CONFIGURATION.md`, **1457 lines**, FROZEN v0.1 |

⛔⛔ **CORRECTION: `BC-25` is NOT ownerless. It is owned by `PRD-023`, which is FROZEN at Rank 3.** L414 is a
**preserved historical finding**, explicitly marked RESOLVED four lines later. ⚠ **The prior record's Enterprise
expert finding — *"`F-5` may be OWNERLESS because `BC-25` has no registered claimant"* — is WITHDRAWN as founded
on a superseded line.**

#### Correction 2 — but `PRD-023` still does **not** own `F-5`

⭐ Having found the owner, the harder test: does that owner's scope reach `F-5`?

| # | Test | Result |
|---|---|---|
| 1 | Explicit authority for `BC-25`? | ✅ **YES** — `ADR-0017` §3 |
| 2 | ⭐ Scope includes per-field script/language declaration? | ⛔ **NO** — measured below |
| 3 | Includes normalization applicability? | ⛔ **NO** |
| 4 | Duplicate ownership? | ⛔ n/a — fails test 2 |
| 7 | Registered holder? | ✅ **YES** — Configuration Platform |
| 8 | Can lawfully decide? | ⛔ **NO** — outside its fixed scope |

`FACT` — `ADR-0017` **§3.1** fixes `PRD-023`'s scope to **six** items: settings hierarchy · feature flags ·
branding **values** · secret **references** · the `E-19` typed-accessor contract · `LCFG-*` **resolution
semantics**. ⛔ **Script, language, locale, collation, analyzer and field schema appear in none of the six.**

`FACT` — `ADR-0017` **§3.2**: *"No `LIB-*`, `LCFG-*`, `SID-*`, `SCFG-*` or `ICFG-*` requirement moves into it.
**This ADR moves no requirement.**"*

`FACT` — `ADR-0017` **§3.1 item 6**: `PRD-023` owns *"the **resolution machinery, not the value list**."*

`FACT` — Measured inside the FROZEN `PRD-023` (1457 lines): ⛔ **zero** `CNF-*` identifiers concerning script,
language, locale, normalization or analyzer. The only matches for those terms are a `subscript` typography
discussion and `CNF-GAP-006` about V1/V2 banding — ⚠ both **false friends**.

`FACT` — `PRD-023` **§15** *Consumed authority* names every document it depends on. ⛔ **`PRD-015`,
`SRCH-FR-024`, script and language appear nowhere in it.**

❌ **Rejected. ⭐⭐ `BC-25` is a *value-resolution* authority, not a *schema/linguistic* authority.** Even a frozen
Rank 3 configuration PRD cannot supply `F-5`, because `F-5` is not a configurable value — it is a **property of a
field's declaration**.

### 4.5 `CANDIDATE` — Product Owner

| # | Test | Result |
|---|---|---|
| 1 | Explicit authority? | ⚠ **PARTIAL** — owns *"which markets V1 serves"* (**L985**) and §14A product statements |
| 2 | Scope includes per-field script declaration? | ⚠ **CONDITIONAL** — ✅ under reading (ii), ⛔ under reading (i) |
| 3 | Includes normalization applicability? | ⛔ **NO** — expressly declined at PO record **L101** |
| 7 | Registered holder? | ✅ **YES** — ownership model **L197** |
| 8 | Can lawfully decide? | ⚠ **only under reading (ii)** |

⚠ **Cannot be excluded, and cannot be selected.** ⭐ The Product Owner already **declined** the analyzer half
(**L101**) — but §14A is a *product* document, so if a script attribute is a **field schema** property, it
returns to the Product Owner by the `SRCH-GAP-009` route.

### 4.6 ⭐⭐ The structural precedent — `SRCH-GAP-009`

`FACT` — Subject **L987**: *"§14A declares **no field precedence order**, which `SRCH-FR-035` layer 2 requires |
**Product Owner** — it is a §14A product statement."*

`FACT` — Subject **L588-591**: *"**Measured: §14A declares no field precedence order** … ⛔ this PRD **MUST NOT**
invent one, because field precedence is a §14A product statement (`SRCH-XC-001`)."*

⭐⭐⭐ **`SRCH-GAP-009` is the same defect shape as `F-5`:** a `SRCH-FR-*` requirement depends on a §14A field
**attribute** that §14A does not declare. There, `PRD-015` routed it to the **Product Owner** on `SRCH-XC-001`
grounds.

⛔⛔ **BUT instruction §1 states: *"Do not resolve governance gaps by analogy."* This precedent is therefore
RECORDED AS EVIDENCE FOR THE HUMAN DECISION AND NOT APPLIED.** It shows reading (ii) is *repository-plausible*,
not that it is correct — `SRCH-GAP-009` concerns **ordering between** fields, `F-5` concerns a **linguistic
property of** a field, and only an owner may rule that these are the same class.

### 4.7 Candidate summary

| `CANDIDATE` | Authority | Scope reaches `F-5` | Holder | Verdict |
|---|---|---|---|---|
| **Architecture Owner (ARB)** | ✅ **YES** — **L980** | ⚠ **YES under reading (i)** | ✅ **ARB** | ⭐ **STRONGEST — but conditional** |
| **Product Owner** | ⚠ partial | ⚠ **YES under reading (ii)** | ✅ | ⚠ **cannot be excluded** |
| `BC-25` / `PRD-023` | ✅ (for `BC-25`) | ⛔ **NO** — outside `ADR-0017` §3.1 | ✅ | ❌ rejected §4.4 |
| `BC-23` / `PRD-015` | ⚠ partial | ⛔ **NO** — `SRCH-XC-001` | — | ❌ rejected §4.2 |
| `LCFG-2` Language | ⛔ | ⛔ **NO** | — | ❌ rejected §4.3 — false friend |
| Enterprise Architecture | ⛔ Rank 6 | ⛔ *descriptive only* | — | ❌ cannot mint |

⛔ **0 of 6 candidates is unconditionally established. 2 remain live and are mutually exclusive.**

---

## 5. The critical distinction — §6 applied

⚠ Instruction §6: *"Do not collapse these."* Measured individually:

| | Category | `F-5` status | Evidence |
|---|---|---|---|
| **A** | Missing **VALUE** | ⛔ **NO** — not merely unset | No field carries the attribute at all |
| **B** | Missing **AUTHORITY** | ⚠ **PARTIALLY** — for `P2` authority EXISTS (**L980**); for the **predicate** none does | §3.3 vs §2.3 |
| **C** | Missing **OWNER** | ⛔ **NO** ⭐ — `P2`'s owner is named at **L980** | ⭐ **CORRECTED — see §5.1** |
| **D** | Missing **ROLE HOLDER** | ⛔ **NO** ⭐ — ARB is assigned | Ownership model **L197** |
| **E** | Missing **GOVERNANCE RULE** | ⭐⭐⭐ **YES — this is the core defect** | §5.2 |
| **F** | Combination | ✅ **YES — B (partial) + E** | — |

### 5.1 ⭐⭐ Why C and D are NO, stated precisely

Instruction §6's own worked example applies in reverse. *"If Architecture Owner is the lawful role but the role
holder is vacant, that is NOT the same as saying the Architecture Owner role does not exist."*

`FACT` — Here **neither** is missing. The role **exists** (ownership model §2.2), the role **has a holder** for
`PRD-015` (**L197**, `ARB`), and that holder is **already named as `P2`'s owner** (**L980**).

⛔ **`F-5` is therefore NOT an ownerless finding.** ⚠ The prior record's *"`F-5` may be OWNERLESS"* is
**WITHDRAWN**: it rested on `PRD_REGISTRY.md` **L414**, a preserved historical line superseded four lines later
by `ADR-0017` (§4.4).

### 5.2 ⭐⭐⭐ What IS missing — category E

`FACT` — What no document supplies is a **governance rule classifying the predicate**:

> Is a field's *declared script* an **analyzer property** (⇒ `P2`, Architecture Owner, **L980**) or a **field
> schema property** of a §14A field (⇒ `SRCH-XC-001` bars `BC-23`, ⇒ Product Owner, `SRCH-GAP-009` route)?

⛔ **Until that classification is ruled, two repository-supported owners both have a colourable claim and neither
can act without risking the other's boundary.** That is a **missing governance rule**, not a missing owner.

⭐ **This is a materially different — and narrower — defect than "no owner exists."** The remedy is a
**classification ruling**, not an owner registration.

---

## 6. Minimum-lawful-remedy test — §7 applied

| | Outcome | Verdict | Evidence |
|---|---|---|---|
| **A** | Existing authority already owns `F-5` | ⚠ **NEARLY** — Architecture Owner owns `P2`, and `SRCH-FR-024` is in `P2`. ⛔ Blocked only by the §4.1.1 ambiguity | **L980** + **L836** vs `SRCH-XC-001` |
| **B** | Existing role owns it, holder vacant | ❌ **NO** — holder is `ARB`, assigned | Ownership model **L197** |
| **C** | ⭐ **Governance permits a one-act conferral** | ✅ ⭐⭐ **MOST LIKELY** — a single classification ruling by the Architecture Owner resolves it | §6.1 |
| **D** | Requires a new claimant/owner registration | ❌ **NO** ⭐ — nothing needs registering; both candidates are already registered | §4.4, §5.1 |
| **E** | Governance insufficient, higher ruling needed | ⛔ **NOT ESTABLISHED** — cannot be excluded, but no evidence compels it | — |
| **F** | No lawful remedy determinable | ❌ **NO** — C is available | §6.1 |

### 6.1 ⭐ The smallest lawful remedy

`FACT` — The Architecture Owner's own granted competence (ownership model **§2.2**) is *"Boundaries … and
precedence"* and *"every §11 exception."* ⭐ **The question "is this an analyzer boundary or a §14A schema
boundary?" is precisely a boundary question**, and the Architecture Owner is the assigned holder for `PRD-015`.

⇒ **Minimum lawful remedy: ONE classification ruling by the Architecture Owner (ARB), scoped to the predicate's
category, deciding nothing about its value.**

⛔ **This record does NOT execute that remedy, does not pre-empt its outcome, and does not assert that the
Architecture Owner will rule for itself.** A boundary ruling may lawfully conclude that the boundary lies with
the Product Owner.

---

## 7. Five-expert review — §8 applied

⚠ Every expert distinguishes **ROLE EXISTS** vs **ROLE HAS HOLDER** vs **ROLE HAS AUTHORITY FOR `F-5`**.

### 7.1 `EXPERT` — Product

| Question | Finding |
|---|---|
| Does `F-5` affect product language scope? | ⚠ **It depends on it but does not decide it.** `SRCHPO-1` fixes the platform set; `F-5` asks per-field |
| Conflict with `SRCHPO-1`? | ⛔ **NO** — complementary. PO record **§2.4** already says `SRCHPO-1` *"does not supply the folding table itself"* |
| Would Product Owner ownership be justified? | ⚠ **Only under reading (ii).** ⭐ The PO **already declined** the analyzer half (**L101**) — but §14A is a **product** document |
| ROLE EXISTS / HAS HOLDER / HAS AUTHORITY | ✅ EXISTS · ✅ HOLDER (**L197**) · ⚠ **AUTHORITY CONDITIONAL** |

⚠ **Verdict: cannot clear.** Owning a *market set* is not owning a *per-field predicate*; but if the predicate is
a §14A field attribute, it is a product statement and returns here.

### 7.2 `EXPERT` — Enterprise / Domain

| Question | Finding |
|---|---|
| Who owns schema/configuration authority? | ⭐⭐ **`BC-25` → `PRD-023`, FROZEN Rank 3** — `ADR-0017`. ⛔ **PRIOR FINDING CORRECTED** |
| Does `BC-25` have an established ownership boundary? | ✅ **YES** — `ADR-0017` §3.1's six items and §3.2's exclusions |
| Does `F-5` belong to an existing BC? | ⛔ **NO** — it falls **between** `BC-23` (barred by `SRCH-XC-001`) and `BC-25` (outside §3.1) |
| ROLE EXISTS / HAS HOLDER / HAS AUTHORITY | ✅ EXISTS · ✅ HOLDER (Configuration Platform) · ⛔ **NO AUTHORITY for `F-5`** |

⭐⭐ **Verdict: I withdraw the prior "OWNERLESS" finding.** `BC-25` has an owner; that owner's scope simply does
not reach `F-5`. ⭐ **A configuration platform owns how a value RESOLVES, not what a field IS.** The finding is
narrower and truer: `F-5` is **unclassified**, not unowned.

### 7.3 `EXPERT` — Search Engineering

| Question | Finding |
|---|---|
| Is `F-5` a search-engine decision or a prerequisite schema decision? | ⭐⭐⭐ **PREREQUISITE.** An analyzer *consumes* a script declaration; it cannot *manufacture* one |
| Consequence | ⛔ Both `SRCH-FR-023` (identical at index+query) and `SRCH-BR-008` (symmetric and total) are **unprovable** while the predicate's inputs are undefined |
| ⭐ Sharpest point | **The query side has NO FIELD AT ALL.** Even a perfect per-field declaration on the index side leaves the query side with nothing to read — a **type mismatch across a MUST**, not an unset value |
| ROLE EXISTS / HAS HOLDER / HAS AUTHORITY | ✅ EXISTS (ARB) · ✅ HOLDER · ⚠ **AUTHORITY only under reading (i)** |

⛔ **Verdict: blocked.** ⭐ And engine selection (`P1`) cannot rescue it — `MP-CON-02` (**MASTER_PRD L238**) makes
engine choice a *deployment* decision, so importing an engine's default script detection would be the exact
collapse it forbids.

### 7.4 `EXPERT` — Security / Privacy

Could the wrong owner cause harm? Assessed per limb:

| Risk | Assessment |
|---|---|
| **Cross-tenant leakage** | ⛔ **NO** — `SE-1` (*"every index name is tenant-prefixed"*) and `X-13` are independent of `F-5` |
| **Inconsistent normalization** | ⭐⭐ **YES — the principal risk.** An owner who declares the predicate for the index side only breaks `SRCH-FR-023` **L414** silently: queries and documents would normalize differently and matching would fail *closed* in some scripts and *open* in others |
| **Exact-identifier collisions** | ⭐⭐ **YES.** Aggressive folding on an exact-tier identifier can make two distinct identifiers equal. ⚠ Collision ≠ spoofing and the two must not be conflated |
| **Privacy / removal inconsistency** | ⛔ **NO** — `LCFG-6` (**L356**) is *"Removal latency **only**"* and `SEV-9` has no propagation window; `F-5` does not touch either |
| **Authorization bypass** | ⛔ **NO** — that is `SRCH-GAP-003` / `ENT`, a separate finding |
| **Stale index behaviour** | ⛔ **NO** — `P8-B`, separate |
| **`BC-18` / `BC-13`** | ⛔ **NOT REACHED.** ⛔ **No `BC-23` → `BC-18` edge created; no permission model created** |
| ROLE EXISTS / HAS HOLDER / HAS AUTHORITY | ✅ EXISTS · ✅ HOLDER · ⚠ **not a security-owned decision** |

⚠ **Verdict: `F-5` is NOT a security-owned decision, and I decline to claim it.** ⛔ But **symmetry is a security
property**, so whichever owner rules **MUST** bind index and query sides in the **same** act. ⛔ **No existing
security authority owns `F-5`**, and none is invented here.

### 7.5 `EXPERT` — QA / Traceability

| Question | Finding |
|---|---|
| Can `F-5` be made deterministic and testable? | ✅ **YES — once classified.** The predicate is a total function on fields; nothing about it is inherently untestable |
| Can `SRCH-AC-050` become executable once `F-5` is owned? | ⚠ **PARTIALLY.** `SRCH-AC-050` (**L1172**) checks **per-rule** symmetry — it would become executable, ⛔ **but it still would not test rule ORDER**, so `SRCH-BR-008`'s *totality* stays unproven |
| ⭐ Sharpest point | **`SRCH-AC-024` (L1084) is all-Latin.** ⛔ **No acceptance criterion anywhere exercises Devanagari** — so `SRCHPO-1`'s second canonical script is **untested by construction**, and an `F-5` ruling would not by itself fix that |
| Minimum missing governance fact | ⭐⭐⭐ **A classification of the predicate's category** — analyzer property vs field-schema property. Not a value, not an owner registration |
| ROLE EXISTS / HAS HOLDER / HAS AUTHORITY | ✅ EXISTS · ✅ HOLDER · ⚠ **AUTHORITY ambiguous — that ambiguity IS the gap** |

⛔ **Verdict: blocked, and I name the smallest missing fact precisely** — one classification, not one value.

### 7.6 Panel tally

| | Count |
|---|---|
| Experts who cleared `F-5` | ⛔ **0 of 5** |
| Experts who invented an owner | ⛔ **0 of 5** |
| Experts who invented a value | ⛔ **0 of 5** |
| ⭐ Experts who **corrected** a prior finding | **1 of 5** — Enterprise (§7.2) |
| ⭐ Experts converging on **category E** (missing governance rule) | **4 of 5** — Enterprise, Search, QA, Product |

---

## 8. Security check — §9 applied

⛔ **Explicitly recorded:** this record creates **no** `BC-23` → `BC-18` edge, **no** new API, **no** new
permission model and **no** new authorization authority. §7.4 identifies existing authorities **only**, and
identifies **none** as owning `F-5`.

---

## 9. Dependency-graph impact — §10 applied

⚠ Only the four permitted relations are recalculated. ⛔ No downstream decision is resolved.

| Edge | Prior | Re-verified this pass | Basis |
|---|---|---|---|
| **`F-5` → `P2-D`** | REQUIRED | ✅ **REQUIRED — unchanged** | Script-aware vs uniform folding cannot be chosen without knowing whether a per-field script exists |
| **`P2-D` → `P2-B`** | REQUIRED | ✅ **REQUIRED — unchanged** | Whether Devanagari folding is *"not applicable"* follows from the script-aware/uniform choice |
| **`P2U` → `P4`** | REQUIRED | ✅ **REQUIRED — unchanged** | `SRCH-FR-030` (**L518-520**) and `SRCH-BR-012` C2 (**L567**) are stated in *tokens*; a bare number is uninterpretable |
| **`P2-A` → `N5` → `P3`/`P4`** | REQUIRED | ✅ **REQUIRED — unchanged** | ⭐ `SRCHPO-5` (**L74**): *"the **tokenizer algorithm** is deliberately **not** defined"* ⇒ `N5` undefined |

### 9.1 Independence assessments

| Node | Verdict | Basis |
|---|---|---|
| **`P2U`** | ⭐ **PARALLEL — can continue** | Its only upstream link to `F-5` is **OPTIONAL**. The counting unit (code point / code unit / grapheme) is a measurement question answerable without knowing a field's script |
| **`P2-C`** | ⭐ **PARALLEL — can continue** | `ZWJ`/`ZWNJ` are named characters; ⛔ nothing upstream blocks it. Still ⚠ **OPEN**, owner Architecture Owner |
| **`P2-A`** | ⚠ **PARALLEL in form, BLOCKED on its own evidence** | ⛔ Not blocked by `F-5`; blocked by `SRCH-GAP-002` (**L980**) — its own authority gap. ⭐ **A different blocker, not a downstream one** |
| **`P2-D`, `P2-B`** | ⛔ **BLOCKED — unchanged** | Via `F-5` |
| **`P4`** | ⛔ **REMAINS BLOCKED** | Needs `P2U` **and** `P2-D`/`P2-B` **and** `N5` |

⛔ **No downstream decision is made. `F-5`'s ownership ambiguity changes no edge direction.**

---

## 10. `HUMAN` decision gate — `SRCHAO-F5`

⚠ **Identifier basis.** `SRCHAO-F5` was minted in the established `SRCHAO-*` series
(`PRD-015_P2_ARCHITECTURE_DECISION.md` §13) by
[`PRD-015_COMPLETE_DEPENDENCY_RESOLUTION.md`](./PRD-015_COMPLETE_DEPENDENCY_RESOLUTION.md) §4. ⛔ **No new
identifier is minted here.** This section **refines the question** on new evidence; it does not create a second
decision slot.

`FACT` — Instruction §11's condition — *"If the repository already provides the answer, do NOT create a fake
human decision merely for ceremony"* — was **tested**, not assumed. §4.7 measures **0 of 6** candidates as
unconditionally established and **2** as live and mutually exclusive. ⇒ **A human ruling IS required.**

```
DECISION ID   : SRCHAO-F5   (existing; question refined by this record)
OWNER         : Architecture Owner (ARB) - ownership model L197
STATUS        : OPEN - AWAITING CLASSIFICATION RULING
================================================================

QUESTION (as refined by this record)
  Which existing authoritative role SHALL own the per-field
  script/language applicability predicate required by
  SRCH-FR-024 (subject L416)?

  Answering it requires first ruling the PRIOR question:

    Is a field's "declared script" -
      (i)  an ANALYZER property?
           => P2, Architecture Owner (subject L980 + L836)
      (ii) a FIELD SCHEMA property of a 14A field?
           => SRCH-XC-001 (L158) bars BC-23
           => Product Owner, on the SRCH-GAP-009 route (L987)

WHAT THIS RECORD ESTABLISHED
  - The Architecture Owner role EXISTS and HAS A HOLDER (ARB).
  - BC-25 IS owned - by PRD-023, FROZEN Rank 3 (ADR-0017).
    The prior "ownerless" reading of L414 is CORRECTED.
  - PRD-023's scope does NOT reach F-5 (ADR-0017 section 3.1's
    six items exclude script, language and field schema).
  - The gap is category E: a MISSING GOVERNANCE RULE,
    not a missing owner and not a vacant role.

WHAT THIS RECORD DID NOT DO
  - Did not choose between reading (i) and reading (ii).
  - Did not apply the SRCH-GAP-009 precedent by analogy,
    which instruction section 1 forbids.
  - Did not decide the predicate's VALUE.

WHAT DEPENDS ON IT
  P2-D (REQUIRED) -> P2-B (REQUIRED)
  P3, P4 downstream of P2.
  P2U, P2-C, P2-A are NOT blocked by it (section 9.1).

----------------------------------------------------------------
Authority relied upon .......... BLANK
Category ruling - (i) or (ii) .. BLANK
Selected owner ................. BLANK
Architecture Owner (role) ...... BLANK
Date ........................... BLANK
Conferral reference ............ BLANK
Rationale ...................... BLANK
================================================================
```

⛔ **7 fields. All BLANK. Not filled by this record.**

---

## 11. Ownership conclusion

`FACT` — Tested against instruction §15's five permitted verdicts:

| Verdict | Applies? | Why |
|---|---|---|
| EXISTING AUTHORITY CONFIRMED | ⚠ **NO — nearly** | Architecture Owner owns `P2` (**L980**) and `SRCH-FR-024` is in `P2` (**L836**), but `SRCH-XC-001` leaves the category unruled (§4.1.1) |
| EXISTING ROLE, HOLDER VACANT | ❌ **NO** | ⭐ Holder is `ARB`, assigned (**L197**) |
| ⭐ **HUMAN OWNERSHIP RULING REQUIRED** | ✅ **YES** | 2 live, mutually exclusive, repository-supported candidates; **0** unconditionally established |
| GOVERNANCE BLOCKED | ❌ **NO** | A one-act remedy exists (§6.1 outcome C) |
| NO LAWFUL OWNER DETERMINABLE | ❌ **NO** | ⭐ Two determinable candidates — the defect is **classification**, not absence |

### ⭐⭐⭐ **CONCLUSION: HUMAN OWNERSHIP RULING REQUIRED**

⚠ **And it is a materially narrower finding than the prior pass recorded.** `F-5` is **not ownerless**. The
Architecture Owner role exists, has a holder (`ARB`), and is already named as `P2`'s owner — and `SRCH-FR-024`
sits inside `P2`. What is missing is a **governance rule classifying the predicate**, because `SRCH-XC-001`
creates a genuine, unruled boundary between an analyzer property and a §14A field-schema property.

⛔ **The remedy is one classification ruling — not an owner registration, not a new authority, not a new BC.**

---

## 12. Downstream impact

| Item | Status | Change from prior pass |
|---|---|---|
| `F-5` | ⛔ **BLOCKED** — awaiting classification ruling | ⭐ **Reclassified**: category **E** (missing governance rule), not "ownerless" |
| `P2-D` | ⛔ **BLOCKED** via `F-5` | unchanged |
| `P2-B` | ⛔ **BLOCKED** via `P2-D` | unchanged |
| `P2U` | ⭐ **PARALLEL — may proceed** | unchanged |
| `P2-C` | ⭐ **PARALLEL — may proceed**, ⚠ still OPEN | unchanged |
| `P2-A` | ⚠ **BLOCKED on its own evidence**, ⛔ not on `F-5` | clarified |
| `P3` | ⛔ **BLOCKED** — needs `P2U` + `N5` | unchanged |
| `P4` | ⛔ **REMAINS BLOCKED** | unchanged |
| `BC-25` ownership | ✅ **`PRD-023`, FROZEN Rank 3** | ⭐⭐ **CORRECTED** |
| Architecture Owner holder | ✅ **`ARB`, assigned** | ⭐⭐ **CORRECTED** |

⛔ **No downstream decision is taken. `P2` remains BLOCKED. `P4` REMAINS BLOCKED.**

---

## 13. Validation — manual integrity checks

⚠ No `prd015_*` validator exists (§1.1). ⛔ None created. **28 manual checks:**

| # | Check | Result |
|---|---|---|
| V1 | Subject sha256 unchanged | ✅ `fe3093e6…c2c4544` |
| V2 | Subject byte-unchanged | ✅ |
| V3 | All 8 prior `PRD-015` records unchanged | ✅ |
| V4 | Frozen PRDs untouched | ✅ |
| V5 | `PRD-021A`/`B`/`C` untouched | ✅ 85 files |
| V6 | ⭐ `PRD-023` (FROZEN) untouched | ✅ |
| V7 | `Library_PRD_v1.md` untouched | ✅ |
| V8 | ⭐ `14A-…md` untouched | ✅ read-only |
| V9 | `MASTER_PRD.md` untouched | ✅ |
| V10 | `PRD_REGISTRY.md` untouched | ✅ |
| V11 | ⭐ `PRD_OWNERSHIP_MODEL.md` untouched | ✅ |
| V12 | BC Map untouched | ✅ |
| V13 | `tool/module_dependencies.yaml` untouched | ✅ |
| V14 | `ADR-0088`/`0089`/`0090` still reserved | ✅ **0 files each**, exact-filename loop |
| V15 | New BC created | ✅ **0** |
| V16 | New edge created | ✅ **0** |
| V17 | New ADR created | ✅ **0** |
| V18 | Code touched | ✅ **0** |
| V19 | `IMPL-*` created | ✅ **0** |
| V20 | ⭐ Owner fabricated | ✅ **0** |
| V21 | ⭐ Authority fabricated | ✅ **0** |
| V22 | ⭐ Role fabricated | ✅ **0** |
| V23 | Person named | ✅ **0** |
| V24 | Value invented | ✅ **0** |
| V25 | Stage 4 entered | ✅ **NO** |
| V26 | Freeze / baseline / rank | ✅ **NO / NO / NONE** |
| V27 | Downstream decision taken | ✅ **0** |
| V28 | ⭐ Human fields BLANK | ✅ **7 of 7** |

⛔ **Creates 0 owners · 0 roles · 0 authorities · 0 BCs · 0 edges · 0 ADRs · 0 `IMPL-*` · 0 values · 0
governance rules.**

---

## 14. Change log

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | **Created.** `F-5` ownership ruling, dependency-first. ⭐⭐⭐ **Two prior claims CORRECTED by re-measurement rather than inherited:** (1) **`BC-25` is NOT ownerless** — `PRD_REGISTRY.md` **L414**'s *"no registered claimant"* is a **preserved historical finding marked RESOLVED four lines later at L417-420**; `ADR-0017` (**ACCEPTED**, Rank 2) assigns `BC-25` → `PRD-023`, which is **FROZEN at Rank 3** (**L337**, 1457 lines), contested contexts **0** (**L550**) ⇒ the prior pass's *"`F-5` may be OWNERLESS"* is **WITHDRAWN**; (2) **the Architecture Owner role EXISTS and HAS A HOLDER** for `PRD-015` — `ARB`, `PRD_OWNERSHIP_MODEL.md` **L197**. ⭐⭐⭐ **Decisive new measurement not run in prior passes:** `ADR-0094` **L64-65** makes **§14A.4/§14A.5** the authoritative *"indexable and queryable field set"*, and those sections (**L98-189**) declare field **NAMES ONLY** — no type, no script, no language; the only two lexical hits in the whole 374-line file are *"normalisation"* in AI prose and ⚠ **the substring `script` inside the word "Description"**, a **false friend**, excluded. ⭐⭐ **`PRD-023` tested and REJECTED as `F-5`'s owner even though it owns `BC-25`:** `ADR-0017` **§3.1** fixes its scope to six items (settings hierarchy · feature flags · branding *values* · secret *references* · `E-19` · `LCFG-*` **resolution semantics**) — script, language, locale, collation, analyzer and field schema are in **none**; **0** `CNF-*` identifiers concern them; **§15** *Consumed authority* names neither `PRD-015` nor `SRCH-FR-024` ⇒ **a configuration platform owns how a value RESOLVES, not what a field IS**. ⭐ **`LCFG-2` Language tested and REJECTED as a false friend** — a tenant's UI locale cannot determine an indexed field's script, since a tenant set to `en` may hold a Devanagari name, exactly the case `SRCHPO-1` admits. ⭐⭐ **`SRCH-GAP-009` identified as the same defect shape** (a `SRCH-FR-*` requirement depending on a §14A field attribute §14A does not declare, routed to the **Product Owner** on `SRCH-XC-001` grounds) and ⛔ **DELIBERATELY NOT APPLIED**, because instruction §1 forbids resolving governance gaps by analogy — recorded as evidence for the human decision only. ⭐⭐⭐ **Category distinction resolved: the gap is E (missing GOVERNANCE RULE), not C (missing owner) and not D (vacant holder)** — `SRCH-XC-001` (**L158**) leaves genuinely unruled whether a *declared script* is an **analyzer** property (⇒ `P2`, Architecture Owner, **L980** + **L836**) or a **field-schema** property (⇒ Product Owner); **2 live, mutually exclusive, repository-supported candidates; 0 of 6 unconditionally established**. **Verdict: HUMAN OWNERSHIP RULING REQUIRED**, minimum lawful remedy = **outcome C, ONE classification ruling**, ⛔ not an owner registration. **Five-expert panel: 0/5 cleared, 0/5 invented an owner, 0/5 invented a value, 1/5 withdrew a prior finding, 4/5 converged on category E.** Security: ⛔ `F-5` is **NOT** a security-owned decision and none is claimed, but symmetry **is** a security property so index and query sides must be bound in the **same** act; ⛔ no `BC-23` → `BC-18` edge, no permission model. QA: ⛔ **`SRCH-AC-024` is all-Latin so no AC anywhere exercises Devanagari** — `SRCHPO-1`'s second script is untested by construction. **Dependency impact:** `F-5` → `P2-D` → `P2-B` **all REQUIRED, unchanged**; `P2U` and `P2-C` **PARALLEL**; ⭐ `P2-A` blocked on **its own** evidence (`SRCH-GAP-002`), not on `F-5`; **`P4` REMAINS BLOCKED**. ⛔ **`SRCHAO-F5` question refined, NOT re-minted; 7 human fields, ALL BLANK.** ⛔ **Creates 0 owners, 0 roles, 0 persons, 0 authorities, 0 BCs, 0 edges, 0 ADRs, 0 `IMPL-*`, 0 values, 0 governance rules.** ⛔ **Subject byte-unchanged; 8 prior records byte-unchanged; `PRD-023` and every frozen PRD untouched; no commit amended; no force-push; Stage 4 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked; registry **L315** still `PLANNED`.** ⛔ **CONFERRAL = NOT CONFERRED.** |
