# PRD-015 — FINAL CONSOLIDATED DECISION & BLOCKER-RESOLUTION PASS

| Field | Value |
|---|---|
| **Document** | `PRD-015` **final consolidated blocker-resolution record** — one record, dependency-ordered |
| **Subject** | `docs/30-product/search/PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` |
| **Order executed** | `B1` → `P2-D`/`P2-B`/`P2U`/`P2-C`/`P2-A` → `P3`/`P4` → `P1`/`P7`/`P8` → `ENT`/`VOC` → `R1`/`R2` → Stage 3 |
| **Predecessor** | `PRD-015_CONSOLIDATED_ARCHITECTURE_COMPLETION.md` (`b5fecf4`) — `SRCHAO-F5` = **OPTION A**, CONFERRED |
| **Type** | ⭐ **ONE consolidated decision record** (rule 13). ⛔ **NOT an ADR** |
| **Rank** | ⛔ **NONE.** Holds no rank, confers none |
| **Date** | 2026-09-04 |
| **Version** | v1.0 |

---

## WHAT THIS RECORD IS NOT

⛔ It does **not** invent a numeric value, threshold, analyzer, tokenizer, engine, performance target, script value or vocabulary.
⛔ It does **not** invent a BC, edge, API, event, owner or ADR.
⛔ It does **not** treat an existing **unrelated** constant as authority — `SCFG-1`, `SCFG-6`, `IT-3`, `LCFG-12`, `LCFG-6` and library-name lengths were each located and **expressly excluded** (§4.3).
⛔ It does **not** modify a frozen PRD, ADR or baseline, and does **not** touch the subject.
⛔ It does **not** enter Stage 4–7, freeze, baseline or rank.
⛔ It does **not** create implementation code or an `IMPL-*` identifier.

---

## 1. INTEGRITY

| # | Gate | Result |
|---|---|---|
| I1 | Subject sha256 | ✅ `fe3093e6…c2c4544` — **MATCH** |
| I2 | `HEAD` at pass start | ✅ `b5fecf4` |
| I3 | Working tree | ✅ **CLEAN** |
| I4 | `github/main` parity | ✅ **0 / 0** |
| I5 | Remote in use | ✅ `github` = `https://github.com/sittuazad05022000-spec/Liboora-.git` |
| I6 | `F-5` prior state | ✅ **CLOSED / CONFERRED** — Option A. ⛔ Not re-opened, not re-decided |

---

## 2. `B1` — THE AUTHORITATIVE SCRIPT DECLARATION SOURCE

### 2.1 The question

`F-5` settled that the declared script is an **analyzer property** consumed from an authoritative declaration, and expressly prohibited content inference. `B1` is the residual it left: **which existing artefact or context can lawfully declare it?**

### 2.2 Repository-wide audit — every candidate tested

`MEASURE` — executed this pass:

```
grep -rniE "declared script|script code|ISO 15924|Deva\b|Latn|script field|
            language tag|BCP.?47|locale field|per-field (script|language)"
     docs/ | grep -v "PRD-015_"
=> 0 HITS
```

⭐⭐ **Zero. No script-declaration mechanism of any kind exists anywhere in the repository outside the `PRD-015` decision records.**

| # | Candidate | Measured | Verdict |
|---|---|---|---|
| 1 | **§14A** (`14A-Library-Discovery-And-Enrollment.md`, **FROZEN** 2026-08-03) | §14A.5 **L134-160** is a **bare field-name list** — *Library Name, Logo, Cover Image, Gallery, Description, Business Address, Map Location, Operating Hours, Weekly Holidays, Facilities & Amenities, Membership Plans & Pricing, Seat Capacity*. ⛔ **No type, no schema, no attribute, no script.** The only two lexical `script` hits (**L15**, **L146**) are the substring inside *"De**script**ion"* | ⛔ **CANNOT DECLARE** — and it is **FROZEN**; adding an attribute is forbidden by rule 2 |
| 2 | **`BC-19` Tenancy** (`PRD-013`, **FROZEN**) — owns *Library Name*, the primary search target, per `AR-1` **L41-50** | ⛔ **0** script hits; its 3 `script` matches are all *"sub**scri**ption"* | ⛔ **CANNOT DECLARE** |
| 3 | **`BC-25` Configuration** (`PRD-023`, **FROZEN** Rank 3) — owns *Logo*, *Cover Image*, *Description* | ⛔ **0** script/language `CNF-*`. `ADR-0017` **§3.1**'s six owned items exclude script, language, locale, collation, analyzer and field schema | ⛔ **CANNOT DECLARE** |
| 4 | **`BC-29` File & Media** (`PRD-017`, **FROZEN**) — owns *Gallery* | ⛔ **0** script hits | ⛔ **CANNOT DECLARE** |
| 5 | **`BC-06` Library Policy** (`PRD-002`, **FROZEN**) — owns *Operating Hours*, *Weekly Holidays* | ⛔ **0** script hits | ⛔ **CANNOT DECLARE** |
| 6 | **`BC-02`**, **`BC-04`** — own *Membership Plans & Pricing*, *Seat Capacity* | ⛔ **0** script hits | ⛔ **CANNOT DECLARE** |
| 7 | **`BC-23`** itself (the subject) | ⛔ Barred by `SRCH-XC-001` — `BC-23` **MUST NOT** define, alter or restate any §14A field. ⭐ And under `F-5`/Option A the analyzer **consumes**, it does not define | ⛔ **CANNOT DECLARE** |
| 8 | **Configuration Guide** (Rank 7) | ⭐ Searched specifically: **no** `LCFG-*` for script. `LCFG-2 Language | en | Product` is a **UI locale default**, ⛔ not a per-field script declaration — a **false friend** | ⛔ **CANNOT DECLARE** |
| 9 | **`ARCHITECTURE_RULINGS.md`** (Rank 4) | ⭐ Its own **L18**: *"A ruling here does **not** create requirements. It settles **ownership, classification and boundaries only**."* ⇒ structurally incapable of carrying a field-level value | ⛔ **CANNOT DECLARE** |
| 10 | **ADRs** (Rank 2) | `ADR-0094` **§5** excludes implementation properties; `ADR-0017` §3.2 excludes field schema. ⛔ No ADR declares a script. `ADR-0088`/`0089`/`0090` are **RESERVED and UNWRITTEN** (0 files) and ⛔ must not be consumed | ⛔ **CANNOT DECLARE** |
| 11 | **`PRD-015` PO record** — ⭐ the strongest candidate | `SRCHPO-1` (**L57**) fixes the **V1 inventory**: *"exactly two: English (Latin script) and Hindi (Devanagari script) … a **closed set** for V1"*. `SRCHPO-A3` (**L434**) is the precedent that a PO **can** supply script scope **without** editing frozen §14A. ⚠⚠ **BUT** PO record **L109-113** states the limit in its own words: *"`SRCHPO-1` now supplies that **scope**… ⛔ It does **not** supply the folding table itself"* | ⚠ **DECLARES THE DOMAIN, NOT THE PER-FIELD VALUE** |

### 2.3 The finding, stated precisely

`ANALYSIS` — the audit separates two things that have been conflated:

| Object | Exists? | Where |
|---|---|---|
| ⭐ The **script DOMAIN** — *which scripts may be declared* | ✅ **YES** | `SRCHPO-1` — a **closed set of two** (Latin, Devanagari), plus `SRCHPO-A3`'s precedent that a PO may supply this without touching frozen §14A |
| ⛔ The **per-field script BINDING** — *which of the two applies to `Library Name`, to `Description`, …* | ⛔ **NO — 0 hits repository-wide** | Nowhere |

⭐⭐⭐ **Therefore `B1` splits into two limbs with different statuses, and reporting it as a single item would misstate the evidence.**

| Limb | Status | Authority |
|---|---|---|
| **B1-a** — the permissible script domain | ✅ **CLOSED** | `SRCHPO-1` (closed set of two) + `SRCHPO-A3` (delivery route that leaves §14A frozen) |
| **B1-b** — the artefact that binds a script to a field, and the binding itself | ⛔ **HUMAN DECISION REQUIRED** | ⛔ **0 authority.** No existing artefact can carry it; every one of the 11 candidates was tested and excluded |

⛔ **`B1-b` is NOT closable by this pass.** Choosing an artefact would create a field-schema authority the repository has not granted; choosing a value would breach the ruling's own *"Script का actual value invent मत करो"*. Recorded as human decision **HD-1** (§12).

⭐ **One structural constraint IS established by evidence and is recorded because it narrows `HD-1` without deciding it:** the declaring artefact **cannot** be §14A or any of the six frozen field-owning PRDs (rule 2), **cannot** be `BC-23` (`SRCH-XC-001`), and **cannot** be `ARCHITECTURE_RULINGS.md` (its **L18**). ⇒ Of the routes the repository has ever used, only a **new PO-style declaration record** on the `SRCHPO-A3` precedent, or a **new ADR**, remains structurally available. ⛔ **Neither is created here.**

---

## 3. `P2` — COMPLETE AUDIT, ALL FIVE ITEMS

### 3.1 `P2-D` — script-aware vs uniform normalization

| Field | Value |
|---|---|
| **Authority for the model** | ⛔ **ABSENT.** `SRCH-FR-024` **L416** *permits* script-conditional behaviour (*"where compatible with the field's declared script"*); ⛔ it does not **require** either model |
| **Effect of `F-5`** | ⭐ Authority question resolved (Architecture Owner); content-inference limb eliminated |
| **Effect of `B1`** | ⚠⚠ ⭐ **A script-aware model is NOT PRESENTLY IMPLEMENTABLE**, because `B1-b` supplies no per-field binding to key it off. A uniform model needs no binding. ⛔ **This is an observation about implementability, NOT a decision** — recording it as one would decide `P2-D` by side effect through a blocker |
| **Status** | ⛔ **HUMAN DECISION REQUIRED** (Architecture Owner) — **HD-2** |

### 3.2 `P2-B` — Devanagari case folding (`N1`)

| Field | Value |
|---|---|
| **Authority** | ⛔ **ABSENT.** `MEASURE`: `case fold|casefold|Devanagari` outside `PRD-015_*` → **0 files** |
| ⭐ **Unicode behaviour NOT treated as product authority** (instruction §2) | Devanagari being unicameral is a **property of the script**, ⛔ **not** a repository statement that `N1` is *declared not applicable*. The distinction matters because `SRCH-AC-050` iterates **per rule**: *"declared not applicable"* is **checkable**; a **silent no-op** is not |
| **Dependency** | `P2-D` = **REQUIRED** |
| **Status** | ⛔ **BLOCKED** on `P2-D` (**HD-2**), then **HUMAN DECISION REQUIRED** — **HD-3** |

### 3.3 `P2-C` — `ZWJ` / `ZWNJ` (independent limb)

| Field | Value |
|---|---|
| **Independence** | ✅ Confirmed — tested independently of `P2-D`, per instruction §2 |
| **Direction** | ✅ **SETTLED.** `N6` **L425** *"Removal of zero-width, control and formatting characters"*; `E6` **L945** *"`N6` removes it — ⛔ it cannot create an unmatchable name"* |
| **Named exception** | ⛔ **ABSENT.** `MEASURE`: `ZWJ|ZWNJ|zero.width` outside `PRD-015_*` → **0 files**. ⛔ **No code point named anywhere** |
| **`N6` × `N4` order** | ⛔ **ABSENT** — §16 is a table of rules, not a declared pipeline |
| ⭐ **Why `SRCH-BR-008` cannot arbitrate** | **Both limbs are symmetric.** Blanket removal is symmetric; an exception applied to both sides is symmetric. The real trade is **collision risk vs spoofing surface** |
| **Status** | ⚠ **PARTIALLY CLOSED** — direction closed on existing authority; exception + order **HUMAN DECISION REQUIRED** — **HD-4** |

### 3.4 `P2U` — the counting unit

| Field | Value |
|---|---|
| **Authority** | ⛔ **ABSENT.** `MEASURE`: `code point|codepoint|scalar value|UTF-16|code unit|grapheme` outside `PRD-015_*` → **0 files** |
| ⭐ **Storage field lengths expressly NOT reused** (instruction §2) | `SCFG-1` (*3–30 characters*, `Student_Identity_PRD_v1.md` **L354**) and `SCFG-6` (*Bio maximum 300 characters*, **L1340**) were **located and EXCLUDED**: they are **Student Identity storage limits** in a different PRD for a different purpose, and they do not define what a *character* **is** — they are the very *"undefined character"* precedent, not a resolution of it |
| **Status** | ⛔ **HUMAN DECISION REQUIRED** (Architecture Owner) — **HD-5** |

### 3.5 `P2-A` — analyzer / tokenizer configuration

| Field | Value |
|---|---|
| **Constraints (authoritative)** | `SRCH-FR-023` **L414** *"the same **declared rule set**"*; `SRCH-BR-008` totality; `SRCH-AC-050` *"each rule is checked"*; `SRCH-FR-034` determinism |
| ⭐ **Express withholding** | `SRCHPO-5` (PO record **L74**) — *"⛔ The **tokenizer algorithm** is deliberately **not** defined (§3.2)"* |
| **Stronger authority sought** | `MEASURE` — no ADR, no EA section and no configuration entry names an analyzer, tokenizer or analysis chain. ⇒ ⛔ **No authority stronger than `SRCHPO-5` exists** |
| ⛔ **No engine preference exercised** | Per instruction §2, ⛔ **no popular search engine or tokenizer is named, preferred or implied** |
| ⭐ **New constraint contributed by `F-5`** | Whatever source is chosen **MUST** consume the script declaration rather than compute it, and **MUST** be the **same** source on both sides. ⛔ Does not choose between a `BC-23`-declared set and engine delegation |
| **Status** | ⛔ **HUMAN DECISION REQUIRED** (Architecture Owner) — **HD-6** |

---

## 4. `P3` AND `P4`

### 4.1 `P3` — edit-distance bound + minimum token length

| Field | Value |
|---|---|
| **Required to exist by** | `SRCH-BR-012` **C2**, **C3** (subject **L561**, **L837**) |
| **Authority** | ⛔ **ABSENT.** `MEASURE`: `levenshtein|edit.distance|damerau|fuzziness|minimum token length` outside `PRD-015_*` → **0 files** |
| **Dependencies** | `P2-A` (token determinacy), `P2U` (what *length* counts) |
| **Status** | ⛔ **BLOCKED** on `P2-A`/`P2U`, and independently 0-authority — **HD-7** |

### 4.2 `P4` — minimum prefix length

| Field | Value |
|---|---|
| **Required to exist by** | `SRCH-FR-030` (subject **L518**, **L838**) |
| **Authority** | ⛔ **ABSENT.** `MEASURE`: `minimum prefix|prefix length` outside `PRD-015_*` → **0 files** |
| **Status** | ⛔ **BLOCKED** on `P2U`/`P2-D` — **HD-8** |

### 4.3 ⭐ Excluded sources — each located, then refused

| Source | Located at | Why refused |
|---|---|---|
| `SRCH-AC-030`'s `Lib` → `Library` | subject **L1103** | An **illustration**. Deriving `3` from it would be *deriving a number from an example* — expressly forbidden |
| `SCFG-1` (3–30 characters) | `Student_Identity_PRD_v1.md` **L354** | ⛔ **Unrelated** — a Student Identity **username** storage limit |
| `SCFG-6` (300 characters) | `Student_Identity_PRD_v1.md` **L1340** | ⛔ **Unrelated** — a Student Identity **bio** length |
| `IT-3` (≥ 40 bits, 24 h) | `ADR-0009` **L83** | ⛔ **Unrelated** — invitation **access-code entropy** |
| `LCFG-12` (20) | Guide **L362** | ⛔ **Unrelated to `P3`/`P4`** — a page-size cap. Authority for `P5` **only** |
| `LCFG-6` (60 s) | Guide **L356** | ⛔ **Unrelated to `P3`/`P4`** — removal latency. Authority for `P6` **only** |
| Library-name length | — | ⛔ Not a token-length or prefix-length authority |

⭐ **7 candidate numbers existed in the repository. All 7 refused. `P3` and `P4` remain without a value.**

---

## 5. `P1` — SEARCH ENGINE / INDEX TECHNOLOGY

| Field | Value |
|---|---|
| **Required to exist by** | §0.3 (subject **L836**) |
| ⭐⭐ **Rank-1 classification authority** | `MASTER_PRD.md` **L238** `MP-CON-02` — *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the 25 approved platforms into a vendor's feature list."* |
| **Binding architecture constraints — authoritative and satisfied** | `MP-CON-01` **L237** *"No vendor name may appear in domain code. Vendors live behind **ports**"*; `MP-CON-03` **L239** *"The Data Layer must remain abstract"* |
| **Engine named anywhere** | ⛔ **NONE.** ⛔ No engine is named, preferred or implied here (rule 4) |
| **Dependency** | ⛔ **NO DEPENDENCY** on `P2`/`P4` — dependency record **L100** |
| **Status** | ⚠ ⭐ **SPLIT — recorded honestly.** The **architecture** limb is ✅ **CLOSED** on `MP-CON-01`/`02`/`03` (an engine must sit behind a port and must not leak into domain code). The **selection** limb is ⛔ **HUMAN DECISION REQUIRED** — **HD-9** |

⚠ **Disclosed tension, not resolved:** §36 lists `P1` inside `SRCH-GAP-002` (Architecture Owner) while Rank-1 `MP-CON-02` classifies engine choice as **deployment**. Rank 1 outranks a Stage-2 draft's gap register, but ⛔ **no authority has reconciled the two texts**, so `P1` is not marked CLOSED. Carried as **B16**.

---

## 6. `P5` / `P6` — EXISTING AUTHORITY PRESERVED

| Item | Value | Authority | Status |
|---|---|---|---|
| **`P5`** | **20**, range **5–50**, owner **Security** | Guide **L362** `LCFG-12`; tiering **L804** | ✅ **CLOSED** — ⛔ **preserved exactly, not restated as new** |
| **`P6`** | **60 s**, range **0–300 s**, owner **Security** — ⭐ **removal latency ONLY** | Guide **L356** `LCFG-6`; **L372** *"the value most likely to be misused"*; `Library_PRD_v1.md` **L721** *"Applies **only** to Public→Private **removal latency**"* | ⚠ **PARTIALLY CLOSED** |

⛔⛔ **`P6` is expressly NOT expanded** to other freshness or rebuild semantics (instruction §5). Projection lag for **any other event class** has ⛔ **0 authority** → **HD-10**.
⭐ **`SEV-9` correctly excluded**: BC Map **L427** — `identity.PersonPrivacyModeChanged` carries *"Public ⇄ Private, **no propagation window** (`SEV-9`)"*. ⇒ `SEV-9` has **no** lag budget **by design**, matching §36 `P6`'s own parenthetical. ⛔ Not a gap.

---

## 7. `P7` AND `P8`

### 7.1 `P7` — latency / throughput / availability

⭐⭐⭐ **NEW MEASUREMENT THIS PASS — the routing rule was found, and it does not resolve `P7`.**

`FACT` — `Library_PRD_v1.md` **L862-864**, `LIB-20.1`:

> *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. This PRD **MUST NOT** state a competing latency or availability figure."*

`FACT` — **L878-880**, its own rationale: *"`LIB-20.1` avoids a documentation trap. A PRD that states '99.9% availability' creates a second source of truth that will diverge from the NFR budget. **Referencing is the durable choice.**"*

| Step | Measured | Result |
|---|---|---|
| 1 | Does the routing target exist? | ✅ **YES** — EA **L339-344** `NFR Budgets (V1)` → `Latency Budgets (V1)`, `Availability Targets (V1)`, `Throughput Targets (V2)`, `Cost Budgets (V2)`, `Mobile Performance Budgets (V1)` |
| 2 | Does it contain **values**? | ⛔ **NO.** `MEASURE`: `p95|p99|99.9|[0-9]+ ?ms|latency budget` across the EA → **1 hit, and it is the heading `Latency Budgets (V1)` itself**. ⛔ **Zero numeric budgets** |
| 3 | Corroboration | EA **L195** *"production readiness is **earned by execution**"*; **L210** *"No SLOs, no error budgets"*; **L87** *"missing SLO/error-budget engineering"*; **L322** Service SLAs **(V3)**; **L1277** SLA Tracking **(Future)** |

⭐ **Finding: `LIB-20.1` establishes the ROUTE but the destination is EMPTY.** This is a **stronger and more precise** result than *"no authority exists"*: the repository has decided **where** NFR values must come from, and that document holds **none**.

| Field | Value |
|---|---|
| **Route** | ✅ **CLOSED** — `LIB-20.1`: values **MUST** come from the EA NFR Budgets document, and `PRD-015` **MUST NOT** state a competing figure |
| **Values** | ⛔ **ABSENT — HUMAN DECISION REQUIRED** — **HD-11** |
| **Status** | ⚠ **PARTIALLY CLOSED (route only)** |

⭐⭐ **Consequence recorded:** subject **L823**'s *"deliberate refusal"* to state a performance target is now shown to be **`LIB-20.1`-compliant**, not merely cautious. ⛔ Inventing a `P7` value here would breach `LIB-20.1` directly.

### 7.2 `P8` — four limbs

| Limb | Authority | Status |
|---|---|---|
| ⭐ **`P8-A`** rebuildability | ✅ `SRCH-INV-005` **L798** *"every index **MUST** be fully rebuildable from the event log"*; BC Map **L453** *"Every projection (BC-26) and index (BC-23) must be rebuildable from the log. **This is tested quarterly, not assumed.**"*; **L801-802** equivalence + `SRCH-FR-034` determinism; **L803-804** MUST NOT re-admit removed documents; ⭐ trace obligation **`T-M`** *"Rebuild equivalence"* (**L933**) | ✅ **CLOSED** — ⛔ preserved, not restated |
| **`P8-B`** serve-stale | ⛔ Subject **L805**: *"Rebuild **availability posture** — whether search degrades, serves stale, or is unavailable — is an operational decision recorded in **`SRCH-GAP-002`**. ⛔ **Not decided here.**" ⭐ **Security audit performed:** the **`SEV-9` no-propagation-window rule** (BC Map **L427**) and `SRCH-FR-013` **prohibit serving stale data for a withdrawn privacy subject** — but that is a **revocation** constraint, ⛔ **not** a general stale-serving posture. ⚠ **`SEV-9` therefore CONSTRAINS `P8-B` without deciding it** | ⛔ **HUMAN DECISION REQUIRED** — **HD-12** ⭐ *with the `SEV-9` constraint recorded* |
| **`P8-C`** rebuild duration | ⛔ **ABSENT.** ⭐ And a duration is a **latency figure**, so `LIB-20.1` **routes it to the EA NFR document** — which holds no values (§7.1). ⛔ **A value here would breach `LIB-20.1`** | ⛔ **HUMAN DECISION REQUIRED** — **HD-13** |
| **`P8-D`** full vs incremental | ⚠ **L801-802** presuppose **both** modes exist and require **equivalence**; ⛔ no authority states when each is used | ⛔ **HUMAN DECISION REQUIRED** — **HD-14** |

---

## 8. `ENT` — QUERY-TIME ENTITLEMENT MECHANISM

### 8.1 What the repository DOES establish — more than prior passes recorded

⭐⭐ **New reading of §27 this pass.** The subject's §27 is not silent; it is **structurally complete on the RULE** and silent only on the **MECHANISM**.

| Established | Evidence |
|---|---|
| ⭐⭐⭐ The governing rule | §27 — *"**Being indexed does NOT make data searchable by everyone. Search results MUST NEVER bypass source-system authorization.**"* |
| ⭐⭐ **`BC-23` holds NO entitlement truth** | §27 — *"`SRCH-INV-001` established that `BC-23` holds no source of truth. It follows that `BC-23` also holds no **entitlement** truth."* |
| **Who decides visibility** | §27 table — *"the **source system's** authorisation, **at query time**"*, re-evaluated *"on **every** query, and on **every** page"* |
| Enforcing requirements (all registered) | `SRCH-FR-001` (single port, no skip path) · `SRCH-FR-007` (reject, never widen) · `SRCH-INV-002` · `SRCH-INV-004` · `SRCH-FR-020`/`SRCH-XC-016` · `SRCH-FR-040` (per page) · `SRCH-FR-013` (`SEV-9`, no window) · `SRCH-FR-042` (filtered-empty indistinguishable) |

### 8.2 The boundary — preserved, not moved

| Rule | Effect |
|---|---|
| `MP-GBR-08` (**L339**) | *"Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and permission-aware**."* |
| `X-13` forbidden edge · `SE-1` | BC Map **L500**, **L505**, **L936** — *"`MP-GBR-08`, `SE-1` and `X-13` remain in force"* / *"are **untouched**"* |
| `SRCHPO-X4` (PO record **L441**) | The claim *"a logical authorization dependency justifies minting the `BC-23` → `BC-18` edge"* → ⛔ **REJECTED**; BC Map **L292**; Rank 4 ⇒ **ADR first** |

⛔ **`BC-23` → `BC-18` edge NOT created.** No existing authoritative architecture *explicitly requires* it — and the one attempt to justify it was expressly rejected. ⛔ **No authorization authority placed in `BC-23`** — §27 already forbids it.

| Field | Value |
|---|---|
| **Rule limb** | ✅ **CLOSED** — §27 + `MP-GBR-08` + the nine registered requirements |
| **Mechanism limb** | ⛔ **HUMAN DECISION REQUIRED** — `SRCH-GAP-003` **L981**; Architecture Owner — **HD-15** |
| **Status** | ⚠ **PARTIALLY CLOSED (rule only)** |

---

## 9. `VOC`

| Limb | Status | Authority |
|---|---|---|
| **Inventory** | ✅ **CLOSED — preserved** | `SRCHPO-1` (**L57**) — *"exactly two: English (Latin script) and Hindi (Devanagari script) … a **closed set** for V1"* |
| **Variant / abbreviation vocabulary** | ⛔ **HUMAN DECISION REQUIRED** | ⛔ 0 authority. §16, §20 V4. ⛔ **No vocabulary invented** — **HD-16** |
| **Analyzer limb** | ⛔ Folds into `P2-A` (**HD-6**) | PO record **L109-113** — *"⛔ It does **not** supply the folding table itself, **which is `P2`**"* |
| **Prior over-claim** | `SRCHPO-X2` (**L439**) ⛔ **REJECTED** the claim that `SRCH-GAP-007` is closed | ⚠ **PARTIALLY CLOSED** stands |

---

## 10. `R1` / `R2`

### 10.1 `R1` — tenant data reaching the public index

⭐ **Independent audit performed, and the residual is re-characterised on new evidence.**

| Field | Value |
|---|---|
| **Severity** | *"**Highest in the architecture**"* (`AR-3`) — dependency record **L637** |
| **Mitigations (document level)** | `SRCH-INV-004` **L324** *"⭐⭐ Tenant Operational Data **MUST NEVER** enter the Platform Public Discovery Index"* · `SRCH-INV-002` **L286** · `SRCH-FR-006` · `AR-3` *"must not weaken tenant isolation"* · `MP-GBR-08`/`SE-1`/`X-13` in force · BC Map **L330** *"Search never reads domain tables"* |
| **Dependency** | ⛔ **NO DEPENDENCY** on `P2`/`P4` — `D-20` |
| ⭐⭐ **NEW: is the residual resolvable by an existing verification authority?** | **Partly — and this is a real advance.** `MEASURE`: the subject **§33** holds a **14-row test-obligation register `T-A`…`T-N`**, of which ⭐ **`T-I` *"Tenant isolation — including that a typo cannot cross a tenant boundary"*** and ⭐ **`T-J` *"Public-index purity — `SRCH-INV-004`, no tenant-private field ever present"*** are exactly `R1`'s residual, **already registered as named obligations**. And BC Map **L453** supplies a **cadence**: *"tested quarterly, not assumed"* |
| **Status** | ⚠ ⭐ **CLOSED AT THE DOCUMENT LEVEL — verification obligation NAMED, EXECUTION PENDING.** ⛔ **NOT fully CLOSED**, because `T-I`/`T-J` are obligations to be *executed*, and this pass writes **no code** and runs **no test** |

⭐ **Honest correction to the prior pass:** the earlier record called `R1`'s residual *"implementation-verified, not document-verified"* and implied no repository handle existed. **That was incomplete** — `T-I`, `T-J`, `T-M` and BC Map **L453**'s quarterly cadence **are** the handle. ⛔ `R1` still cannot be marked CLOSED, but the residual is now **owned and named** rather than merely open. ⛔ **No new test identifier created.**

### 10.2 `R2` — index as a silent authorisation bypass

| Field | Value |
|---|---|
| **Gate** | Instruction §9: process **only if `ENT` is resolved**. §8 measured `ENT` **mechanism = OPEN** |
| **Dependency** | `D-19` — **REQUIRED** on `SRCH-GAP-003` |
| ⭐ Recorded without processing | §27's rule limb + `SRCH-FR-040` (per-page re-evaluation) + `SRCH-FR-013` (`SEV-9`, no window) + `SRCH-FR-042` are `R2`'s **document-level** mitigations, and they are ✅ **in force**. ⛔ The residual is precisely the **undecided mechanism** |
| **Status** | ⛔ **BLOCKED BY `ENT`** — ⛔ not audited further, per the instruction's own gate |

---

## 11. CONSOLIDATED SECURITY + QA REVIEW

| # | Item | Classification | Basis |
|---|---|---|---|
| 1 | **`BC-18` authorization** | ⚠ **PARTIAL** | Rule ✅ closed (§27, `MP-GBR-08`); boundary ✅ preserved (`X-13`/`SE-1` untouched, edge not minted); ⛔ mechanism open (`HD-15`) |
| 2 | **Tenant isolation** | ⚠ **PARTIAL** | Requirements complete; ⭐ obligations `T-I`/`T-J` named with a quarterly cadence; ⛔ execution pending |
| 3 | **Index/query symmetry** | ⛔ **BLOCKED** | `SRCH-FR-023`/`SRCH-BR-008` authoritative; ⭐ `F-5` bound both sides to one source; ⛔ `SRCH-AC-050`'s per-rule totality still unprovable while `B1-b`, `P2-B`, `P2-C`, `P2U` are open |
| 4 | **Declared-script trust boundary** | ⚠ **PARTIAL** | ⭐⭐ Content inference **prohibited** by the `F-5` ruling ⇒ the *"attacker-influenceable"* surface (`P2` record **L878**) is **closed**; ⛔ the declaring artefact is unnamed (`HD-1`), so its own trust properties are unverifiable |
| 5 | **Normalization collisions** | ⛔ **UNSUPPORTED** | ⚠ Symmetry is **not injectivity**; two distinct strings may normalize identically. ⛔ **0 repository authority**; ⛔ **no owner measured**. Disclosed, ⛔ not invented |
| 6 | **Exact-tier identifiers** | ⚠ **PARTIAL** | ✅ `SRCH-FR-027` no tolerance on identifier-like fields, obligation **`T-D`**; ⛔ exposed to item 5's collision gap at the EXACT tier |
| 7 | **Entitlement** | ⛔ **BLOCKED** | `SRCH-GAP-003` (`HD-15`) |
| 8 | **Stale serving** | ⛔ **BLOCKED** | Subject **L805** *"⛔ Not decided here"*; ⭐ constrained (not decided) by `SEV-9`'s no-propagation-window + `SRCH-FR-013` (`HD-12`) |
| 9 | **English + Hindi** | ⚠ **PARTIAL** | Latin ✅ authoritative and tested (`SRCH-AC-024`); ⛔ Devanagari — **0** specification authorities across 10 features and **0** acceptance coverage (`SRCH-AC-024`'s four cases are all Latin). ⚠ **Pre-existing** |
| 10 | **Hinglish / Romanized Hindi** | ⚠ **PARTIAL** | ✅ Scope authoritative: `SRCHPO-2` — supported *query behaviour* *"where technically validated"*, ⛔ not a third canonical language/BC/index; `SRCHPO-X6` **REJECTED** the transliteration-capability inference (`SRCH-BR-011` forbids learned-model inference). ⛔ Mechanism: none |
| 11 | **`ZWJ` / `ZWNJ`** | ⚠ **PARTIAL** | ✅ Direction settled (`N6`+`E6`); ⛔ exception + `N6`×`N4` order open (`HD-4`) |
| 12 | **Prefix / typo / token behaviour** | ⛔ **BLOCKED** | `P2-A`, `P2U`, `P3`, `P4` all 0-authority; `SRCH-AC-054` (`SRCH-BR-012` C1–C5) not executable |
| 13 | **Irrelevant-query exclusion** | ✅ **PASS** | Subject **L487** *"An irrelevant document **MUST NOT** appear at any tier"*; §22.3 **L601** *"⭐⭐ T4 — irrelevant means **excluded, not ranked last**"*; `SRCH-BR-013`/`SRCH-BR-010`; obligation **`T-F`**; **L432**. ⛔ No `P*` dependency |

⭐ **Tally: PASS 1 · PARTIAL 7 · BLOCKED 4 · UNSUPPORTED 1.**
⚠ **Only item 13 is unconditionally PASS.** ⛔ No item was upgraded to produce a tidier table.

---

## 12. STAGE 3 REASSESSMENT — THE SIX CHECKS AS SPECIFIED

⚠ **Note on the check set.** This instruction specifies a **different six checks** from the ownership-model six re-run in the previous pass. Both were run; this section answers **the six named here**.

| # | Check | Measured | Result |
|---|---|---|---|
| **1** | **Ownership exclusive** | `PRD_OWNERSHIP_MODEL.md` **L197** — `PRD-015` → `BC-23`, all four roles assigned, Architecture Owner = `ARB`. `PRD_REGISTRY.md` **L550** — contested contexts = **0**; **L456-459** BC→PRD claims unique. ⭐ `AR-1` confirms `BC-23` owns *"Discovery projection & query"* only, and ⛔ **not** the §14A fields | ✅ **PASS** |
| **2** | **Required edges** | `E-21` is the authorised source route (`ADR-0093` admitted `BC-19`); `E-19` registered; ⛔ **0 new edges** required or created by any decision in this pass. ⛔ `BC-23` → `BC-18` **not** minted (`SRCHPO-X4` rejected) | ✅ **PASS** |
| **3** | **Rank direction** | ⭐ Verified in the strong direction: this pass **reads** Rank 1 (`MP-CON-02`), Rank 2 (`ADR-0017`, `ADR-0094`, `ADR-0033`), Rank 3 (frozen PRDs, `LIB-20.1`), Rank 4 (`AR-1`/`AR-3`, BC Map), Rank 6 (EA, descriptive), Rank 7 (Guide) as **authority**, and writes **only** rank-less `PRD-015` records. ⛔ **No lower-rank document overrides a higher one.** ⭐ `P7` is routed **upward** via `LIB-20.1` rather than decided locally | ✅ **PASS** |
| **4** | **Authorization only `BC-18`** | ⭐⭐ §27 — *"`BC-23` … holds **no entitlement truth**"*; visibility is *"the **source system's** authorisation, at query time"*. `MP-GBR-08` *"permission-aware"*; `X-13`/`SE-1` **in force and untouched** (BC Map **L500**, **L505**, **L936**). ⛔ **This pass placed no authorization authority in `BC-23`** | ✅ **PASS** |
| **5** | **Credential / OTP / session only `BC-18`** | `MEASURE` — the subject contains **0** credential, OTP, session or token-issuance requirements; ⛔ this pass created none. ⭐ `SRCH-GAP-008` (query-volume abuse / rate limiting) is expressly recorded as ⛔ *"**No owner exists**"* and is ⛔ **NOT claimed by `BC-23`**; `XPC-OD-010` remains OPEN. `LIB-20.3` puts public rate limiting on `CFG-3`, ⛔ not on `BC-23` | ✅ **PASS** |
| **6** | **Tenant scoping** | `SRCH-INV-004` (never enter public index) · `SRCH-INV-002` (exactly one index class) · `SRCH-FR-007` (reject, never widen) · `MP-GBR-08` (every index tenant-partitioned) · BC Map **L500** *"Tenant key in index name — **Mandatory**"* · **L490** capability-tier rule · `AR-3` *"must not weaken tenant isolation"* | ✅ **PASS** — ⚠ with `R1`'s **execution-pending** residual (`T-I`/`T-J`) |

### 12.1 Verdict

⭐ **All six checks as specified: PASS.** ⛔ **Stage 3 is nevertheless NOT CONFERRED**, on two independent grounds:

| Ground | Evidence |
|---|---|
| **1 — No conferral exists for this act** | ⛔⛔ `ADR-0033` **§7.1** — *"**A conferral for one act is not a standing licence.**"* The only conferral in this engagement named **`SRCHAO-F5`** and is **spent on `F-5`**. `SRCHCL-X1` (**L425**) ⛔ **REJECTED** the office-as-act argument: *"an office is not an act… **Having an owner is limb C's precondition, not limb C.**"* ⭐ The lawful form is an **express quoted grant naming the act** (`PRD-008_STAGE3_CONFERRAL.md` **L8**). ⛔ This instruction contains **no** Stage-3 grant |
| **2 — Substantive blockers remain, independently of any conferral** | Subject **L843-844** — *"⛔ **Blocks Stage 3 architecture review**"*. `SRCH-GAP-002` (**L980**) is **not closed**: of eight parameters, `P5` and `P8-A` closed, `P6`/`P7` partial, and **`P2`, `P3`, `P4`, `P8-B`/`C`/`D` open**. `SRCH-GAP-003` (**L981**) open. `SRCH-GAP-007` (**L985**) partial. ⭐ **Six alignment checks passing does not close a gap register that expressly blocks Stage 3** |

⭐⭐ **Recorded precisely: the six checks measure *architecture alignment*; `SRCH-GAP-002` measures *parameter completeness*. Passing the former does not satisfy the latter, and conflating them would confer Stage 3 on the wrong evidence.**

| Field | Value |
|---|---|
| Six checks | ✅ **6 / 6 PASS** |
| Stage 3 assessment | ⚠ **CONDITIONAL** |
| Stage 3 conferral | ⛔ **NOT CONFERRED** |
| `PRD-015` state | ⛔ **DRAFT · NOT FROZEN · NOT BASELINED · NOT RANKED** — registry **L315** `PLANNED`, unchanged |

---

## 13. CONSOLIDATED TRACEABILITY

⛔ **No duplicate identifier created.** Every identifier below already exists.

| Requirement | Authority | Decision | Dependency | AC impact |
|---|---|---|---|---|
| `SRCH-FR-024` | §36 `P2` **L836**; `F-5` ruling | `F-5` **CLOSED** (Option A) | `B1-b` open | `SRCH-AC-024` (Latin only) |
| `SRCH-FR-024` `N1` | ⛔ none (Devanagari) | `P2-B` **BLOCKED** | `P2-D` | `SRCH-AC-050` per-rule |
| `SRCH-FR-024` `N6` | `N6` + `E6` | `P2-C` **PARTIAL** | independent | ⛔ no `ZWJ` criterion |
| `SRCH-FR-023` | **L414** | symmetry authoritative | `P2-A` | `SRCH-AC-050` |
| `SRCH-BR-008` | **L427** | symmetric **and total** | `P2` complete | `SRCH-AC-050` **unsatisfiable** |
| `SRCH-BR-012` C2/C3 | ⛔ none | `P3` **BLOCKED** | `P2-A`, `P2U` | `SRCH-AC-054` |
| `SRCH-FR-030` | ⛔ none | `P4` **BLOCKED** | `P2U`, `P2-D` | `SRCH-AC-030` |
| `SRCH-FR-039` | Guide **L362** | `P5` ✅ **CLOSED** = 20 | ⛔ none | testable |
| §32 lag | Guide **L356**; `Library_PRD_v1` **L721** | `P6` ⚠ removal latency only | ⛔ none | ⭐ `SEV-9` = no window by design |
| §36 perf | ⭐ `LIB-20.1` → EA | `P7` ⚠ **route closed, values absent** | EA NFR doc | ⛔ none writable |
| `SRCH-INV-005` | **L798**; BC Map **L453** | `P8-A` ✅ **CLOSED** | ⛔ none | ⭐ `T-M` |
| §34 posture | **L805** | `P8-B`/`C`/`D` open | `SRCH-GAP-002` | ⛔ none |
| §27 / `MP-GBR-08` | §27; **L339** | `ENT` ⚠ rule closed, mechanism open | `SRCH-GAP-003` | `SRCH-FR-040`, `SRCH-FR-042` |
| §16 / §20 | `SRCHPO-1` | `VOC` ⚠ inventory closed | `P2-A` | ⛔ no vocabulary AC |
| `SRCH-INV-004`/`002` | **L324**, **L286** | `R1` ⚠ document-closed | ⛔ none | ⭐ `T-I`, `T-J` + quarterly |
| §27 bypass | §27 | `R2` ⛔ **BLOCKED BY `ENT`** | `SRCH-GAP-003` | `SRCH-FR-040` |
| `SRCH-BR-013` | **L487**, **L601** | ✅ **PASS** | ⛔ none | ⭐ `T-F` |

---

## 14. VALIDATION

| # | Check | Result |
|---|---|---|
| V1 | Subject sha256 unchanged | ✅ `fe3093e6…c2c4544` |
| V2 | Frozen files byte-identical — §14A, `PRD-013`, `PRD-017`, `PRD-023`, `Library_PRD_v1`, all ADRs, `DOCUMENTATION_BASELINE.md` | ✅ verified by `git diff --name-only` |
| V3 | Rank 1/4/6/7 unchanged — `MASTER_PRD.md`, `ARCHITECTURE_RULINGS.md`, BC Map, EA, `CONFIGURATION_GUIDE.md` | ✅ |
| V4 | `PRD_REGISTRY.md` unchanged; **L315** `PLANNED` | ✅ |
| V5 | `PRD_OWNERSHIP_MODEL.md` unchanged | ✅ |
| V6 | **0** BCs invented | ✅ |
| V7 | **0** edges invented — `BC-23` → `BC-18` **NOT** minted | ✅ |
| V8 | **0** APIs, **0** events invented | ✅ |
| V9 | **0** ADRs created; `ADR-0088`/`0089`/`0090` still RESERVED, unwritten, **not consumed** | ✅ |
| V10 | **0** `IMPL-*` created | ✅ |
| V11 | **0** code files touched | ✅ |
| V12 | **0** values invented — no script value, unit, edit distance, prefix length, latency, throughput, availability, duration, engine, tokenizer, vocabulary | ✅ |
| V13 | ⭐ Unrelated constants located and **refused** — `SCFG-1`, `SCFG-6`, `IT-3`, `LCFG-12`/`LCFG-6` (for `P3`/`P4`), `Lib`→`Library` | ✅ **7 refused** |
| V14 | **0** owners invented; **0** personal names recorded (§7 rule 4) | ✅ |
| V15 | **0** new identifiers minted; `HD-*` are report labels in this record, ⛔ not requirement identifiers | ✅ |
| V16 | Existing authority **preserved, not restated as new** — `P5`, `P6`, `P8-A`, `SRCHPO-1` | ✅ |
| V17 | `P6` **not** expanded beyond removal latency | ✅ |
| V18 | Stage 4–7 **NOT** entered; not frozen, baselined or ranked | ✅ |
| V19 | Stage 3 = **CONDITIONAL / NOT CONFERRED** | ✅ |
| V20 | No amend / rebase / force-push | ✅ |
| V21 | ⚠ **No `PRD-015` validator exists** in `tool/docs_check/` (32 entries) — **limitation DISCLOSED**; ⛔ **no new validator created** (instruction §14) | ⚠ **DISCLOSED** |

---

## 15. CHANGE LOG

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-04 | **Created.** `PRD-015` **final consolidated blocker-resolution** record, executed in the mandated dependency order `B1` → `P2` → `P3`/`P4` → `P1`/`P7`/`P8` → `ENT`/`VOC` → `R1`/`R2` → Stage 3, as **one** record (rule 13). ⭐⭐⭐ **`B1` RESOLVED INTO TWO LIMBS on an 11-candidate audit** — `B1-a` (permissible script **domain**) **CLOSED** on `SRCHPO-1`'s closed set of two plus `SRCHPO-A3`'s frozen-§14A-preserving delivery precedent; `B1-b` (the **per-field binding** and the artefact that carries it) **HUMAN DECISION REQUIRED** on a measured **0 hits repository-wide** for any script-declaration mechanism. ⭐ Each of the 11 candidates — §14A, `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`/`BC-04`, `BC-23`, the Configuration Guide, `ARCHITECTURE_RULINGS.md`, the ADRs, and the PO record — was tested and **excluded on its own evidence**, including the disclosure that §14A's only two lexical `script` hits are the substring inside *"Description"*. ⭐ Recorded the **structural narrowing** that follows (only a PO-style declaration record on the `SRCHPO-A3` precedent, or an ADR, remains available) ⛔ **without creating either**. **`P2` audited complete:** `P2-D` **HD-2** (⭐ noting that a script-aware model is not presently implementable absent `B1-b`, ⛔ expressly declining to let that decide `P2-D`); `P2-B` **BLOCKED** then **HD-3**, ⭐ with **Unicode unicameral behaviour expressly REFUSED as product authority** per instruction §2; `P2-C` **PARTIALLY CLOSED** (direction settled by `N6`+`E6`) then **HD-4**, ⭐ confirmed **independent** of `P2-D` and shown to be un-arbitrable by `SRCH-BR-008` because **both limbs are symmetric**; `P2U` **HD-5**, ⭐ with `SCFG-1`/`SCFG-6` **located and REFUSED** as storage lengths from a different PRD; `P2-A` **HD-6**, ⭐ with **no authority stronger than `SRCHPO-5` found** and ⛔ **no engine or tokenizer named or preferred**. **`P3`/`P4`:** both **BLOCKED** and 0-authority; ⭐⭐ **seven candidate numbers were located in the repository and ALL SEVEN REFUSED** — the `Lib`→`Library` example, `SCFG-1`, `SCFG-6`, `IT-3`, `LCFG-12`, `LCFG-6` and library-name length. **`P1` SPLIT honestly:** architecture limb **CLOSED** on `MP-CON-01`/`02`/`03`, selection limb **HD-9**, with the §36-vs-Rank-1 `MP-CON-02` tension **disclosed, not resolved**. **`P5`/`P6` PRESERVED exactly** (`LCFG-12` = 20; `LCFG-6` = 60 s **removal latency only**), ⛔ `P6` **not** expanded, and ⭐ **`SEV-9` correctly identified as having no propagation window BY DESIGN** (BC Map **L427**) rather than as a gap. ⭐⭐⭐ **`P7`: NEW MEASUREMENT — `LIB-20.1` (`Library_PRD_v1.md` L862) was found, requiring NFR budgets to be taken from the EA NFR Budgets document and forbidding a competing figure; the routing target EXISTS (EA L339-344) but was measured to contain ZERO numeric values** (a search for `p95|p99|99.9|ms|latency budget` returned only the heading itself) ⇒ `P7` **route CLOSED, values HD-11**, and the subject's **L823** *"deliberate refusal"* is now shown to be **`LIB-20.1`-compliant** rather than merely cautious. **`P8`:** `P8-A` **CLOSED** and preserved (`SRCH-INV-005` + BC Map **L453** quarterly + obligation `T-M`); `P8-B` **HD-12**, ⭐ with a **security audit finding that `SEV-9` + `SRCH-FR-013` CONSTRAIN stale serving for revoked subjects without deciding the general posture**; `P8-C` **HD-13**, ⭐ noting a duration **is** a latency figure and therefore routed by `LIB-20.1` to the empty EA document, so a value here would **breach `LIB-20.1`**; `P8-D` **HD-14**. ⭐⭐ **`ENT` RE-READ: §27 is structurally COMPLETE on the RULE and silent only on the MECHANISM** — *"`BC-23` holds **no entitlement truth**"*, visibility is the **source system's** decision **at query time**, enforced by nine already-registered requirements ⇒ rule limb **CLOSED**, mechanism **HD-15**; ⛔ **`BC-23`→`BC-18` edge NOT minted** (`SRCHPO-X4` rejected; `X-13`/`SE-1`/`MP-GBR-08` verified **in force and untouched**), ⛔ **no authorization authority placed in `BC-23`**. **`VOC`** inventory **CLOSED** and preserved; vocabulary **HD-16**; analyzer limb folded into `P2-A` ⛔ without inventing a vocabulary. ⭐⭐ **`R1` residual RE-CHARACTERISED on new evidence and a prior record CORRECTED:** the subject's **§33** holds a **14-row test-obligation register `T-A`…`T-N`** in which **`T-I` (tenant isolation) and `T-J` (public-index purity) are exactly `R1`'s residual, already registered as named obligations**, with BC Map **L453** supplying the *"tested quarterly, not assumed"* cadence ⇒ `R1` is **document-closed with a NAMED, execution-pending verification obligation**, not an unowned gap as the prior pass implied; ⛔ still **not** marked CLOSED, since this pass runs no test. **`R2` BLOCKED BY `ENT`** and ⛔ **not audited further, per the instruction's own gate**. **ONE consolidated Security+QA review over the 13 named items: PASS 1 · PARTIAL 7 · BLOCKED 4 · UNSUPPORTED 1**, with the ⚠ **unowned normalization-collision finding** and the ⚠ **pre-existing all-Latin acceptance-coverage defect** both disclosed rather than smoothed. ⭐⭐ **Stage 3 reassessed against the SIX CHECKS AS SPECIFIED HERE** (ownership exclusive · required edges · rank direction · authorization only `BC-18` · credential/OTP/session only `BC-18` · tenant scoping) — ⭐ **6 of 6 PASS**, including the measurement that the subject contains **0** credential/OTP/session requirements and that `SRCH-GAP-008` is expressly **unowned and NOT claimed by `BC-23`** — yet **CONDITIONAL / NOT CONFERRED** on two independent grounds: (1) ⛔⛔ `ADR-0033` **§7.1** *"a conferral for one act is not a standing licence"* with `SRCHCL-X1`'s *"an office is not an act"* — the only conferral in this engagement named `SRCHAO-F5` and is spent; (2) `SRCH-GAP-002`/`-003`/`-007` expressly **block Stage 3** and remain open. ⭐⭐ **Recorded the distinction that the six checks measure ARCHITECTURE ALIGNMENT while `SRCH-GAP-002` measures PARAMETER COMPLETENESS, and that conflating them would confer Stage 3 on the wrong evidence.** **16 human decisions consolidated into ONE table (`HD-1`…`HD-16`)** with exact question, allowed options, evidence and downstream impact, ⛔ so that no further per-decision prompt is required. ⛔ **Creates: 0 script values, 0 units, 0 thresholds, 0 NFR values, 0 durations, 0 engines, 0 tokenizers, 0 vocabularies, 0 owners, 0 personal names, 0 BCs, 0 edges, 0 APIs, 0 events, 0 ADRs, 0 `IMPL-*`, 0 code, 0 requirement identifiers.** ⚠ **Limitation disclosed: no `PRD-015` validator exists in `tool/docs_check/`; ⛔ none was created.** ⛔ **Subject byte-unchanged; every frozen PRD/ADR/baseline byte-unchanged; registry L315 still `PLANNED`; Stage 4–7 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked.** |

---

**END OF RECORD**

⭐ **CLOSED: `F-5`, `B1-a`, `P5`, `P8-A`, `VOC`-inventory, `P1`-architecture-limb, `ENT`-rule-limb, `P7`-route-limb**
⚠ **PARTIAL: `P2-C`, `P6`, `P7`, `ENT`, `VOC`, `R1`**
⛔ **HUMAN DECISION REQUIRED: `HD-1`…`HD-16`**
⛔ **BLOCKED: `R2` (by `ENT`)**
⛔ **STAGE 3: CONDITIONAL — NOT CONFERRED.**

---

## 16. FORWARD NOTE — `HD-1`…`HD-16` HAVE SINCE BEEN RULED (added 2026-09-04)

⚠ **The line above reading `⛔ HUMAN DECISION REQUIRED: HD-1…HD-16` is SUPERSEDED IN SCOPE, and its bytes are deliberately NOT overwritten.** It was true when written and is the evidence of what this pass actually asked. The retain-verbatim convention of `ADR-INDEX.md`'s `Count` cell and of `ADR-0035`'s `D-4` cell governs: a superseded statement is annotated, never deleted.

⭐ **All sixteen decisions were subsequently supplied by the human principal** and are recorded in **one** consolidated record — ⛔ not sixteen files:

> [`PRD-015_HUMAN_DECISION_RESOLUTION_RECORD.md`](./PRD-015_HUMAN_DECISION_RESOLUTION_RECORD.md)

⭐⭐ **This staleness was caused BY THE LATER PASS ITSELF, which is why it is repaired here rather than routed.** `GCP-25`'s standing rule is *repair only what your own pass caused, disclose and route the rest*; the human-decision pass caused exactly this one line to go stale, so repairing it is that pass's own obligation and not a drive-by edit of a neighbouring document.

⚠⚠ **DO NOT READ THIS NOTE AS CLOSURE OF THE UNDERLYING BLOCKERS.** The distinction the successor record makes its governing principle is that **a ruling can settle a MODEL without settling its CONTENT**, and **eleven of the sixteen rulings are of that shape**. Consequently:

| Still true after the rulings | Evidence |
|---|---|
| ⛔ **Stage 3 remains CONDITIONAL — NOT CONFERRED** | Re-run at 6/6 PASS and still withheld, on `ADR-0033` §7.1 (*"a conferral for one act is not a standing licence"*) and on `SRCH-GAP-002`/`-003`/`-007` |
| ⛔ **`SRCH-GAP-002` is NOT closed** | It measures **parameter completeness**; the six checks measure **architecture alignment**. The rulings closed models, not parameters |
| ⚠ **`HD-7`, `HD-8`, `HD-11`, `HD-13` are DEFERRED — still OPEN** | Ruled *"DEFER"* by the principal; ⛔ no numbers were minted |
| ⚠ **`R2` remains BLOCKED** | `HD-15` closed the ENT **rule**; the ENT **mechanism** is still open |
| ⚠ **`P2-B`/`P2-C`/`P2-D` rule sets, and the `BC-23` configuration, remain OPEN** | `HD-2`/`HD-3`/`HD-4` settled scope and policy; the exception set and rules are evidence-bound and were ⛔ not invented |

⭐ **Closed by the rulings, and only these:** `HD-5` outright (grapheme-cluster counting); the **authority** limb of `P2-A` (by **`ADR-0099`**, created for `HD-6`); the **architecture** limb of `P1` (`HD-9`, vendor-neutral); `P6`'s scope confirmed unchanged (`HD-10`); the **modes** of `P8-D` (`HD-14`); the **scope** of `VOC` (`HD-16`, English + Hindi).

⛔ **This note creates nothing.** 0 values, 0 thresholds, 0 durations, 0 analyzers, 0 tokenizers, 0 vendors, 0 vocabularies, 0 BCs, 0 edges, 0 APIs, 0 `IMPL-*`, 0 requirement identifiers, 0 lines of code. ⛔ **Subject byte-unchanged.** ⛔ **§1–§15 above are byte-unchanged; this section is APPENDED**, so every `§`-form citation into this file — the seven measured in `docs/` at §2.2 (×2), §3.2, §3.3, §3.5 and two whole-file links — still resolves, and **0 line-citations exist into this file** (enumerated across `docs/` and `tool/`, returning none).
