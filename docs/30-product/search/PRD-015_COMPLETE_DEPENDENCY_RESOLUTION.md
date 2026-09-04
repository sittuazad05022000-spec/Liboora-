# `PRD-015` — COMPLETE DEPENDENCY-ORDERED RESOLUTION RECORD

| Field | Value |
|---|---|
| **Document** | `PRD-015_COMPLETE_DEPENDENCY_RESOLUTION.md` |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](PRD-015_SEARCH_INDEXING.md) — `sha256 fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, ⛔ **byte-unchanged by this pass** |
| **Type** | ⚠ **Decision-PREPARATION record.** ⛔ **NOT** a decision. ⛔ **NOT** a conferral. ⛔ **NOT** an alignment record |
| **Scope** | The **complete lawful dependency order** across `F-5`, `P1`–`P8`, `P2-A`/`B`/`C`/`D`, `P2U`, `ENT`, `VOC`, `R1`, `R2`, `R7` and `SRCH-GAP-002`/`003`/`007`/`008` |
| **Date** | 2026-09-03 |
| **Rank** | ⛔ **None.** Rank is conferred by a baseline act; this record claims none |
| **`PRD-015` status** | **v0.1 — `DRAFT`**, Stage 2. `PRD_REGISTRY.md` **L315** reads **`PLANNED`** |
| **Conferral** | ⛔ **NOT CONFERRED** |

---

> ### ⛔ WHAT THIS RECORD IS NOT
>
> It does **not** decide any `P*` parameter. It does **not** choose a search engine, analyzer, tokenizer, Unicode
> form, counting unit, edit distance, prefix length, page size, projection lag, latency figure or rebuild posture.
> It creates **no** `ADR`, **no** `BC`, **no** `E-*` edge, **no** `IMPL-*`, **no** acceptance criterion and **no**
> new authority. Every Architecture Owner and Product Owner field in §12 is **BLANK** and must remain so until a
> real conferral occurs.
>
> **A recommendation is not a decision. A decision-preparation record is not conferral. A technical default is not
> repository authority.**

### READING KEY — five registers, never blended

| Register | Meaning |
|---|---|
| `FACT` | Measured from repository bytes. Cited by file and line |
| `EVIDENCE` | The exact citation supporting a `FACT` |
| `DEPENDENCY` | A relation between nodes, classified `REQUIRED` / `OPTIONAL` / `NO DEPENDENCY` / `UNKNOWN` |
| `EXPERT` | A reviewer finding. ⚠ Persuasive, **not** authoritative |
| `HUMAN` | ⛔ A field only a named owner may fill. **BLANK here, always** |

---

## 1. Phase 0 — integrity gates

| # | Gate | Expected | Measured | Verdict |
|---|---|---|---|---|
| 1 | Branch | `main` | `main` | ✅ |
| 2 | HEAD | — | `3cf47be` | ✅ |
| 3 | `github/main` | == HEAD | `3cf47be` | ✅ |
| 4 | Ahead / behind | 0 / 0 | **0 / 0** | ✅ |
| 5 | Working tree | clean | clean | ✅ |
| 6 | ⭐ Subject `sha256` | `fe3093e6…c2c4544` | `fe3093e6…c2c4544` | ✅ **UNCHANGED** |
| 7 | `PRD-015` version | v0.1 `DRAFT` Stage 2 | v0.1 `DRAFT` Stage 2 (**L11-12**) | ✅ |
| 8 | `PRD_REGISTRY.md` **L315** | `PLANNED` | `PLANNED` | ✅ |
| 9 | Prior `PRD-015` records | 7 on disk | 7 | ✅ |
| 10 | ⭐ `ADR-0088`/`0089`/`0090` | 0 files each | **0 / 0 / 0** by an **exact-filename loop, not a glob** | ✅ **RESERVED** |
| 11 | `ADR-0094` | present | `ADR-0094-section-14a-is-the-v1-bc-23-discovery-contract.md` | ✅ |
| 12 | `PRD-021A`/`B`/`C` | untouched | untouched | ✅ |
| 13 | Code changes | 0 | 0 | ✅ |

⚠ **Gate 10 method note, preserved because the register itself records the trap.** `ADR-INDEX.md` **L9** warns that
a character class such as `ADR-008[890]*` also matches `ADR-0080` and returns a **false positive**. This pass used
an exact-filename loop over `0088`, `0089`, `0090` and returned **0 files each**.

### 1.1 ⚠ Disclosed limitation — no `PRD-015` validator exists

`FACT` — `tool/docs_check/` holds **32 entries** and **none** is a `prd015_*` validator. `PRD-015` is not
registered in `alignment_record_freshness.py`'s `RECORDS` list. ⛔ **One was NOT fabricated.** All integrity
checks in this record are **manual** and are enumerated in §13.

---

## 2. Phase 1 — the dependency graph, re-verified from source

⚠ **No dependency below is inherited from a prior record.** Each was re-derived from the underlying repository
authority in this pass, because the instruction requires it and because a dependency that is only ever copied is
a rumour with a citation.

| # | Edge | Class | `EVIDENCE` (re-measured this pass) |
|---|---|---|---|
| D-1 | `F-5` → `P2-D` | ⭐ **REQUIRED** | A script-**aware** model presupposes a per-field script predicate. §3 measures that predicate at **0 authorities** |
| D-2 | `F-5` → `P2-B` | ⭐ **REQUIRED** | Devanagari case-folding applies *"where compatible with the field's declared script"* (**L416**) — the same absent predicate |
| D-3 | `P2-D` → `P2-B` | **REQUIRED** | Whether `N1` is script-conditioned at all is settled by the model choice |
| D-4 | `F-5` → `P2U` | **OPTIONAL** | A unit can be named without the predicate; but which unit is *correct* varies by script (packet **L196**) |
| D-5 | ⭐ `P2U` → `P4` | ⭐⭐ **REQUIRED** | `SRCH-FR-030` **L518** requires prefix matching; a *"minimum prefix length"* is a count, and a count needs a unit. §7 measures **0** unit authorities |
| D-6 | ⭐ `P2` (`N5` tokenization) → `P4` | ⭐⭐ **REQUIRED** | `SRCH-FR-030` **L518** is stated over a *"query **token**"*. `N5` defines the token. `SRCHPO-5` leaves the tokenizer *"deliberately not defined"* |
| D-7 | ⭐ `P2` (`N5`) → `P3` | ⭐ **REQUIRED** | `SRCH-BR-012` **C2** (**L567**): *"MUST NOT apply below a declared minimum **token** length"* — same undefined token |
| D-8 | `P2U` → `P3` | **REQUIRED** | C2's *"length"* is a count and needs the same unit as D-5 |
| D-9 | `P1` → `P2` | ⛔ **NO DEPENDENCY** | §8. `MP-CON-02` classifies engine choice as a **deployment** decision |
| D-10 | `P1` → `P3` / `P4` | ⛔ **NO DEPENDENCY** | §8, same basis |
| D-11 | `P5` → anything | ⛔ **NO DEPENDENCY** | §9. `LCFG-12` is an independent `LCFG-*` value |
| D-12 | `P6` → anything | ⛔ **NO DEPENDENCY** | §10. `LCFG-6` is an independent `LCFG-*` value |
| D-13 | `P7` → NFR Budgets doc | ⭐ **REQUIRED (external)** | §11. `LIB-20.1` routes the figures out of `PRD-015`; the destination document **does not exist** |
| D-14 | `P8`-duration → `P7` | **REQUIRED** | §12. A duration figure is an NFR figure and `LIB-20.1` catches it too |
| D-15 | `P8`-posture → `ENT` / privacy | ⭐ **REQUIRED** | §12. *"Serve stale"* must not outlive `SEV-9`'s **no-propagation-window** rule |
| D-16 | `ENT` → `SRCH-GAP-003` | **REQUIRED** | **L981**: the query-time entitlement **mechanism** is the gap |
| D-17 | ⭐ `ENT` → manifest port | ⭐⭐ **REQUIRED** | §13. `platform/search` declares **no `ports:` block at all** |
| D-18 | `VOC` → `SRCH-GAP-007` | **REQUIRED** | **L985**: variant/abbreviation vocabulary, Product **+** Architecture Owner |
| D-19 | `R2` → `SRCH-GAP-003` | **REQUIRED** | **L961**: residual is *"the entitlement-evaluation mechanism is undecided"* |
| D-20 | `R1` → `P2`/`P4` | ⛔ **NO DEPENDENCY** | **L960**: `R1`'s mitigations are `SRCH-INV-004`/`002`, `SRCH-FR-006`, `T-J` — none is a `P*` |
| D-21 | ⭐ `R7` → `P2` | ⚠ **REVERSE** | **L965**: *"Depends on `P2` honouring §22."* `R7` depends on `P2`; `P2` does not depend on `R7` |
| D-22 | `SRCH-GAP-002` → all `P1`–`P8` | **REQUIRED** | **L980**: the gap *is* the P-register |

⭐ **Dependency deliberately NOT propagated.** `P5`, `P6`, `R1` are `NO DEPENDENCY`; `P1` is `NO DEPENDENCY` on
the merits, not merely unproven. Forcing every node into one serial chain would manufacture blockage that the
repository does not support, and would make the real critical path harder to see.

---

## 3. `F-5` — the applicability predicate

### 3.1 The text under test

`FACT` — `PRD-015_SEARCH_INDEXING.md` **L416**, verbatim:

> `SRCH-FR-024` — Normalization **MUST**, where compatible with the field's **declared script and language scope**:

### 3.2 Independent re-verification

`FACT` — a repository-wide sweep of `docs/` and `tool/` for
`declared script|script of the field|per-field script|field script|script applicability|script scope`,
**excluding** the prior `P2` record so the finding is not self-confirming, returns **7 hits in 3 files**:

| Hit | Location | Is it an authority? |
|---|---|---|
| 1 | Subject **L416** | ⛔ **No** — this is the clause *needing* the predicate |
| 2 | PO record **L53** heading *"Language and script scope"* | ⛔ **No** — a section title |
| 3 | PO record **L101** *"Analyzer configuration for the declared scripts"* → Architecture Owner, **⛔ NO** | ⛔ **No** — records it as **unanswered** |
| 4 | PO record **L163** | ⛔ **No** — routes it to `SRCH-GAP-007` |
| 5 | PO record **L408** | ⛔ **No** — reasons *about* script scope |
| 6 | PO record **L434** `SRCHPO-A3` | ⚠ **Tested separately — see §3.3** |
| 7 | Packet **L143** *"Script scope"* column header | ⛔ **No** — a table header |

⭐ **0 of 7 hits define the predicate.** `F-5` is re-confirmed on fresh evidence.

### 3.3 ⭐⭐⭐ The one hit that had to be tested properly — `SRCHPO-A3`

`SRCHPO-A3` (**L434**) reads: *"`SRCHPO-1` supplies §16 N3/N4 with a **declared script domain** for the first
time — ✅ ACCEPTED."* Taken at face value this looks like `F-5`'s authority, and dismissing it without testing
would have been the single most likely error in this pass.

`FACT` — the PO record's own §2.4 (**L109-113**) states the limit in its own words:

> *"`SRCHPO-1` now supplies that scope — Latin and Devanagari — so **N3/N4 acquire a declared domain of
> application** for the first time. ⛔ **It does not supply the folding table itself, which is P2.**"*

⭐ **The distinction, stated precisely.** `SRCHPO-1` declares which scripts the **platform** supports — a set of
two. `SRCH-FR-024` **L416** asks which script a **given field** is in — a function from field to script. A set is
not a function. Knowing the platform supports `{Latin, Devanagari}` does not tell a normalizer which of the two
any particular field holds, and `SRCH-FR-024` conditions each rule on exactly that.

⇒ `SRCHPO-A3` is **true as written and does not supply `F-5`.** It closes the *market-scope* half of
`SRCH-GAP-007`, which is why `SRCHPO-A4` is also `ACCEPTED` and `SRCHPO-X2` still **REJECTS** the claim that
`SRCH-GAP-007` is closed.

### 3.4 The seven questions the instruction poses

| | Question | Answer | `EVIDENCE` |
|---|---|---|---|
| **A** | Does an authority define **field script**? | ⛔ **NO** | §3.2 — 0 of 7 hits |
| **B** | Does an authority define **language scope**? | ⚠ **PARTIALLY** — platform-level only | `SRCHPO-1`: V1 = English/Latin + Hindi/Devanagari, **closed set** |
| **C** | Does an authority define how rules determine **applicability**? | ⛔ **NO** | **L416** poses the test; nothing supplies it |
| **D** | **Query-side** script applicability? | ⛔ **NO — and worse** | ⭐ A query has **no field**. The predicate is not merely unset on this side; it is **inapplicable in kind** |
| **E** | **Index-side** script applicability? | ⛔ **NO** | A field exists but carries a **match role** (`SRCH-FR-018` **L375**), never a script |
| **F** | Can an existing authority lawfully be **referenced**? | ⚠ **PARTIALLY** — `SRCHPO-1` for the *domain*, nothing for the *predicate* | §3.3 |
| **G** | Who is the **lawful owner**? | ⭐ **Architecture Owner** | **L985**: `SRCH-GAP-007`'s analyzer half is *"Architecture Owner (analyzer)"*; PO record **L101** confirms and marks it **⛔ NO** |

### 3.5 ⭐⭐ Why `D` is the finding that governs

`SRCH-FR-023` (**L414**) requires normalization to be applied *"**identically** at index time and at query time,
by the same **declared rule set**."* `SRCH-BR-008` (**L428**) requires it to be **symmetric and total**.

⭐ But if rule applicability is a function of *the field*, and the query side has no field, then the two sides
cannot evaluate the same predicate **even in principle**. This is not an unset parameter awaiting a value — it is
a **type mismatch between the two sides of a MUST**. That is why `F-5` heads the critical chain and why no
downstream `P2` limb that depends on it can be decided first.

### 3.6 Status

> ⛔ **`F-5` = BLOCKED / DECISION REQUIRED.**
> Owner: **Architecture Owner**. Smallest lawful unblocking act: **§4's `SRCHAO-F5`**, and nothing larger.

⛔ **No authority was created for `F-5` by this record.**

---

## 4. `HUMAN` decision gate — `F-5`

⚠ **Identifier basis.** `SRCHAO-*` is the established Architecture Owner decision prefix for `PRD-015`
(`SRCHAO-P2a`…`P2U`, `PRD-015_P2_ARCHITECTURE_DECISION.md` §13). `SRCHAO-F5` is minted in that same series and
for the finding this pass re-verified. ⛔ It records a **question**, never an answer.

```
================================================================
DECISION ID   : SRCHAO-F5
OWNER         : Architecture Owner
STATUS        : OPEN - BLOCKED, NO AUTHORITY EXISTS
================================================================

QUESTION
  What authoritative predicate determines the declared script /
  language scope governing applicability of the PRD-015
  normalization rules N1-N6 (SRCH-FR-024, subject L416)?

WHY IT CANNOT BE ANSWERED BY THIS RECORD
  0 of 7 repository hits define it (section 3.2).
  SRCHPO-1 supplies a platform script SET, not a per-field
  script FUNCTION (section 3.3).
  The query side has no field at all (section 3.4 D).

WHAT DEPENDS ON IT
  P2-D  (REQUIRED)    P2-B (REQUIRED, via P2-D)
  P3, P4 downstream of P2.

----------------------------------------------------------------
Authority relied upon .......... BLANK
Selected option ................ BLANK
Architecture Owner (role) ...... BLANK
Date ........................... BLANK
Conferral reference ............ BLANK
Rationale ...................... BLANK
----------------------------------------------------------------
```

⛔ **6 fields. All BLANK. Not filled by this record.**

---

## 5. `P2-A` — analyzer / tokenizer configuration source

`FACT` — packet §5.2 (**L155-162**) asks the configuration questions and answers them itself:

| Packet question | Packet's own answer |
|---|---|
| *"Which library / configuration?"* | ⛔ **Absent** |
| *"Which stemmer?"* | ⛔ **Absent** |

`FACT` — `SRCHPO-5`: the tokenizer is *"**deliberately** not defined."* ⚠ The adverb matters — this is a
**withheld** decision, not an oversight, so it cannot be closed by finding an overlooked authority.

`FACT` — PO record **L101**: analyzer configuration → **Architecture Owner** → ⛔ **NO**.

### 5.1 False friends excluded before classification

⚠ Re-verified this pass so the sweep is not contaminated:

| Hit | Why excluded |
|---|---|
| `analyzer:` — Matrix **L548** | **Dart** `package:analyzer`, a static-analysis tool |
| `ADR-0044` tokenisation | **Identifier-stem** tokenisation, not text analysis |
| `PRD-012a` tokenization | **Security** tokenization (secret substitution), unrelated |

### 5.2 Can `P2-A` be resolved independently of `F-5`?

⚠ **Partially — and the split is the useful finding.** Naming *where* configuration lives (the source) is
separable from *what* it contains (the rules), which is `F-5`-dependent. But the packet measures **both halves
absent**, so `P2-A` is blocked on its own evidence regardless of `F-5`.

> ⛔ **`P2-A` = HUMAN DECISION REQUIRED / BLOCKED.** Owner: **Architecture Owner**.
> ⛔ **No engine, library or stemmer named.** `MP-CON-01` bars vendor names from domain code, and commonality is
> not authority.

---

## 6. `P2-D` and `P2-B`

### 6.1 `P2-D` — script-aware vs uniform

| Criterion | **A · SCRIPT-AWARE** | **B · UNIFORM** |
|---|---|---|
| `F-5` dependency | ⛔ **REQUIRED** — presupposes a per-field script | ✅ **None** — one rule set for all input |
| `SRCH-FR-024` **L416** fit | ✅ Matches the clause's own shape | ⚠ Makes the preamble vacuous — the condition never varies |
| `SRCH-BR-008` symmetry | ⛔ Fails while `F-5` is open (§3.5 type mismatch) | ⚠ Symmetric by construction — but see below |
| Determinism | ⛔ Undetermined until the predicate exists | ✅ Determined |
| Totality | ⛔ Partial — undefined for unclassified fields | ✅ Total |
| Testability | ⛔ `SRCH-AC-050` cannot iterate | ⚠ Testable in form |
| V1 scope fit (`SRCHPO-1`) | ✅ Two scripts genuinely differ | ⚠ Applies Latin-shaped rules to Devanagari |
| Extensibility | ✅ New script = new branch | ⚠ New script may force a rewrite |
| Security | ⚠ Per-script rules widen the collision surface | ⚠ Uniform rules may over-fold Devanagari |
| ⭐ `P4` unit problem | ⛔ **Not dissolved** | ⛔ **Not dissolved** |

⭐⭐ **The counter-intuitive result, restated because it is easy to get backwards.** Model B looks like it
escapes `F-5` — no per-field script, no missing predicate. It does not escape `P2U`: a uniform pipeline still
has to count *something* to give `P4` a number, and §7 measures zero counting-unit authorities. ⇒ **Choosing B
would unblock `P2-D` and leave `P4` blocked anyway.**

⚠ And Model B is not free: it makes `SRCH-FR-024`'s *"where compatible with the field's declared script"*
**inoperative text inside a frozen-track MUST**. Rendering a MUST's condition vacuous is an amendment in
substance, and this record has no authority to make it.

> ⛔ **`P2-D` = BLOCKED on `F-5` (D-1).** ⛔ **Neither model recommended.**

### 6.2 `P2-B` — Devanagari case-folding

`FACT` — packet **L145** records Devanagari as **unicameral**: it has no upper/lower case distinction.

| Question | Answer | Basis |
|---|---|---|
| Do case distinctions exist in Devanagari? | ⛔ **No** | Packet **L145** — unicameral |
| Is a case-folding operation required? | ⚠ **Cannot be answered before `P2-D`** | If A, `N1` is script-conditioned and may be *"not applicable"*; if B, `N1` applies uniformly and is a **no-op** on Devanagari |
| Is *"not applicable"* the correct technical state? | ⚠ **Plausible under A only** | ⛔ Not decidable while `P2-D` is open |
| Would a silent no-op violate `SRCH-AC-050`? | ⭐ **This is the real question** | See below |

⭐⭐ **The distinction the instruction asks for, stated in `SRCH-AC-050`'s own terms.** `SRCH-AC-050` (**L1172**)
requires that *"**each rule** is checked for symmetry."*

- **"Not applicable"** = the rule is **declared** out of scope for the script. `SRCH-AC-050` can *check* it and
  record that it does not apply. ✅ **Enumerable.**
- **Silent no-op** = the rule is **declared applicable** and happens to change nothing. ⚠ Indistinguishable at
  runtime from a correctly-applied rule — and indistinguishable from a rule that is **broken**.

⭐ The two are behaviourally identical **today** and diverge the moment a third script arrives or a Devanagari
casing convention is proposed. A record that conflates them hands the next reader a rule whose absence looks
like a success.

> ⛔ **`P2-B` = BLOCKED on `P2-D` (D-3), which is BLOCKED on `F-5` (D-2).**
> ⛔ **No Devanagari case-folding rule invented. `N1` NOT modified.**

---

## 7. `P2-C` and `P2U`

### 7.1 `P2-C` — `ZWJ` / `ZWNJ` — ⭐ the one limb that is decidable today

`FACT` — `N6` (**L423**): *"Removal of zero-width, control and formatting characters"*, rationale *"invisible
characters cannot create a distinct name."*
`FACT` — packet **L150** flags `ZWJ`/`ZWNJ` as **critical** for Devanagari.
`FACT` — `E6` (**L945**) already fixes `N6`'s **direction**.

⭐⭐ **Re-verified re-framing.** Because `E6` fixes the direction, the open question is **not** *"strip or keep?"*
It is *"is there a **named exception** for `U+200C`/`U+200D` inside Devanagari conjunct formation?"* — a narrower
question with a different owner-facing shape.

⭐ **And both candidate limbs are symmetric.** Strip-both-sides is symmetric; keep-both-sides is symmetric.
⇒ **`SRCH-BR-008` does not choose between them.** The real axis is:

| Limb | Risk it creates |
|---|---|
| **Strip** | ⚠ **Collision** — two visually distinct Devanagari conjuncts may normalize to one term |
| **Keep** | ⚠ **Spoofing** — invisible characters *can* create a distinct name, which is exactly what `N6`'s stated rationale forbids |

⚠ **Cross-check `N6` × `N4`.** §16 is a **table**, not a sequence. Whether `N6` runs before or after `N4`'s
canonical normalization is **unspecified**, and the two orders can produce different output for the same input.
⛔ This record **surfaces** the ordering gap and **does not close it**.

`P2-C` does not require `F-5`: `ZWJ`/`ZWNJ` are identifiable by code point without knowing the field's script.

> 🔓 **`P2-C` = OPEN — DECIDABLE NOW.** ⛔ **`N6` NOT modified.** ⛔ **No exception written.**

### 7.2 `P2U` — the counting unit

`FACT` — repository-wide sweep for `code point`, `Unicode scalar value`, `UTF-16`, `code unit`,
`grapheme cluster` across `docs/` and `tool/`: ⛔ **0 hits.**

| Candidate | Authority | Verdict |
|---|---|---|
| Code point | ⛔ none | Not authoritative |
| Unicode scalar value | ⛔ none | Not authoritative |
| UTF-16 code unit | ⛔ none | Not authoritative |
| Grapheme cluster | ⛔ none | Not authoritative |
| Normalized token unit | ⛔ none — `N5` itself undefined (`SRCHPO-5`) | Not authoritative |

> ## ⛔ **No authoritative `P2` counting unit exists.**

> ## ⛔ **`P4` remains blocked because its numeric value cannot be interpreted unambiguously.**

⭐ **Why this is not pedantry, in one measured example.** Packet **L196** records that a Devanagari *matra*-bearing
cluster spans **2–3 code points**. A "minimum prefix length of 2" therefore denotes:

| Under unit | What "2" admits |
|---|---|
| Code points | ⚠ Possibly **half a visible character** |
| Grapheme clusters | ✅ Two visible characters |
| UTF-16 code units | ⚠ Different again outside the BMP |

⇒ The same number specifies **three different behaviours**. ⛔ **No unit invented.**

> ⛔ **`P2U` = BLOCKED / HUMAN DECISION REQUIRED.** Owner: **Architecture Owner**.

---

## 8. `P3` — edit-distance bound and minimum token length

`FACT` — `SRCH-BR-012` **C2** (**L567**): typo tolerance *"**MUST NOT** apply below a declared minimum **token**
length."*
`FACT` — **C3** (**L568**): *"The permitted difference **MUST** be bounded and uniform across consumers."*
`FACT` — **L572**: *"C2's minimum length and C3's bound are `SRCH-GAP-002`, owner Architecture Owner. ⛔ Not
fabricated here."*
`FACT` — `SRCHPO-X5` ⛔ **REJECTED** the claim that approving typo tolerance decides `P3`; **0** repository hits
for `levenshtein|edit.distance|damerau|fuzziness`.

### 8.1 ⭐ Which portions of `P3` require `P2` — separated as instructed

| Aspect | Requires `P2`? | Basis |
|---|---|---|
| **Value** (the number) | ⛔ **No** — but see unit | A number can be named independently |
| ⭐ **Unit** | ⭐ **REQUIRED (D-8)** | C2's *"length"* is a count; §7.2 gives it no unit |
| ⭐ **Token semantics** | ⭐ **REQUIRED (D-7)** | C2 counts **tokens**; `N5` defines tokens; `SRCHPO-5` leaves it undefined |
| **Mechanism** (algorithm) | ⛔ **No** | `MP-CON-01`/`MP-CON-02` — a deployment concern |
| **Product behaviour** | ✅ **AUTHORITATIVE ALREADY** | `SRCH-BR-012` C1–C5 are pre-existing MUSTs |

⭐ **`P3` is blocked for the same two structural reasons as `P4`, and independently of it.** Both need a unit and
a determinate token. Neither needs the other. ⇒ They are **siblings**, not a chain — a correction worth stating,
because a serial reading would predict that deciding `P4` unblocks `P3`, and it would not.

> ⛔ **`P3` = BLOCKED.** ⛔ **No edit distance invented. No minimum token length invented.**

---

## 9. `P4` — minimum prefix length

`FACT` — `SRCH-FR-030` (**L518**): *"A query **token** MUST be able to match an indexed token by **prefix**."*
`FACT` — `SRCH-AC-030` (**L1103**): *"Given the query token `Lib` and an indexed token `Library`…"*

⚠ **`SRCH-AC-030` is an EXAMPLE, not a ceiling and not an approval.** `Lib` is three characters, which shows only
that **some** length ≤ 3 must work in Latin. ⛔ It approves **no** value.

| `P4` sub-question | State |
|---|---|
| Unit | ⛔ **BLOCKED** — §7.2 |
| Normalized token | ⛔ **BLOCKED** — `N5` undefined |
| Match role | ✅ **AUTHORITATIVE** — `SRCH-FR-030` **L519-520** bars suffix/infix on **exact**-role fields |
| English behaviour | ⚠ Illustrated by `SRCH-AC-030`; ⛔ no value conferred |
| Hindi / Devanagari behaviour | ⛔ **BLOCKED** — and ⭐ **acceptance-uncovered**: `SRCH-AC-024` (**L1084**)'s four cases are **all Latin** |
| Multi-word behaviour | ⚠ §19.3 exists; ⛔ interacts with the undefined tokenizer |
| Prefix semantics | ✅ Prefix-only, per **L519-520** |

> ⛔ **`P4` = BLOCKED, twice over** — no **unit** (`P2U`) **and** no determinate **token** (`N5`).
> ⛔ **`P4` VALUE = NOT DECIDED. 1, 2 and 3 are each expressly declined as a final value.**

---

## 10. The parallel track — `P1`, `P5`, `P6`, `P7`, `P8`

### 10.1 ⭐⭐ `P1` — engine selection — **does NOT block `P2`, `P3` or `P4`**

`FACT` — `MASTER_PRD.md` **L238**, `MP-CON-02`, verbatim:

> *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**. It must not collapse the
> 25 approved platforms into a vendor's feature list."*

`FACT` — `MASTER_PRD.md` **L219**: the EA is *"vendor-neutral by construction. It names no database, no
backend-as-a-service and no AI provider."*
`FACT` — `MP-CON-01` (**L237**): *"No vendor name may appear in domain code. Vendors live behind ports."*
`FACT` — Matrix **L50**, Dependency Law `L3`: domain code contains *"no vendor name, no SDK import."*

| Claim | Verdict | Reason |
|---|---|---|
| `P1` → `P2` | ⛔ **NO DEPENDENCY** | `SRCH-FR-023`/`024` state a **declared rule set**, not an engine's behaviour. An engine implements the rules; it does not authorise them |
| `P1` → `P3` | ⛔ **NO DEPENDENCY** | `SRCH-BR-012` C3 requires the bound be *"uniform across consumers"* — i.e. **engine-independent by construction** |
| `P1` → `P4` | ⛔ **NO DEPENDENCY** | `SRCH-FR-030` is a capability statement |
| Can an engine be chosen without changing the PRD contract? | ✅ **YES** | That is precisely `MP-CON-02`'s design |

⭐⭐ **The finding that inverts the intuitive reading.** It is tempting to think *"we cannot define normalization
until we know the engine."* The repository says the reverse: deriving normalization **from** an engine's defaults
would *"collapse the 25 approved platforms into a vendor's feature list"* — the exact act `MP-CON-02` forbids.
⇒ **`P2` must be decided independently of `P1`, and an engine that cannot honour the declared rule set is
disqualified — not consulted.**

⚠ **A second-order consequence, stated because it is easy to miss.** This also means `P1` cannot be used as an
*excuse* for `P2`'s blockage. `P2` is blocked by `F-5` and `P2U`, both of which are internal to `PRD-015`'s own
authority chain. Choosing an engine tomorrow would unblock **nothing**.

> ⚠ **`P1` = OPEN, as to POSTURE only, and PARALLEL.** ⛔ **No engine named.**
> ⭐ The lawful decision is *"declare the capability behind an abstraction"*, not *"pick a product."*

### 10.2 `P5` — page-size cap — ⭐ **AUTHORITATIVE VALUE EXISTS**

`FACT` — `CONFIGURATION_GUIDE.md` **L362**:

| ID | Item | Default | Range | Owner | Rationale |
|---|---|---|---|---|---|
| `LCFG-12` | Public search page size | **20** | 5 – 50 | **Security** | *"Bounds enumeration rate and page weight"* |

`FACT` — declared by `14B-Public-Library-Preview.md` **L342**, **L374**.
`FACT` — `SRCH-FR-039` (**L641**) requires pagination *"capped by the port, ⛔ never by the caller alone"* — a
**mechanism** requirement, compatible with `LCFG-12`'s **value**.
`FACT` — `SRCHPO-C1` / `SRCHCL-C2`: `PRD-015` cites `LCFG` **0 times** though `LCFG-12` supplies `P5`.

⚠ **Scope limit, stated rather than glossed.** `LCFG-12` is titled ***Public*** *search page size*. `PRD-015`
also serves **tenant-operational** surfaces. Whether `LCFG-12` governs those is ⛔ **not** established.

> ⚠ **`P5` = PARTIALLY AUTHORITATIVE — public surface only.** ⛔ **Value NOT duplicated. `LCFG-12` NOT modified.**
> The residue is a **traceability** gap (add the citation), not a value gap. Owner of the value: **Security**.

### 10.3 `P6` — projection lag — ⭐ **AUTHORITATIVE VALUE EXISTS, NARROWLY**

`FACT` — `CONFIGURATION_GUIDE.md` **L356**:

| ID | Item | Default | Range | Owner | Note |
|---|---|---|---|---|---|
| `LCFG-6` | Discovery index propagation | **60 s** | 0 – 300 s | **Security** | ⭐ *"**Removal latency only** — see below"* |

`FACT` — `CONFIGURATION_GUIDE.md` **L372** heads a section: *"`LCFG-6` — **the value most likely to be
misused**."*
`FACT` — `Library_PRD_v1.md` **L727**, `LIB-16.9` (**FROZEN**): `LCFG-6` *"**MUST NOT** be applied to any
authorization, membership,…"*
`FACT` — `Library_PRD_v1.md` **L721**: *"**Applies only to Public→Private removal latency.**"*

⛔ **`LCFG-6` MUST NOT be extended to** — enumerated because the instruction requires it and because the
repository itself predicts the error:

| Would-be extension | Verdict |
|---|---|
| All event classes | ⛔ **FORBIDDEN** — `P6` is *"per event class"* (**L840**); `LCFG-6` covers **one** |
| Rebuild | ⛔ **FORBIDDEN** — that is `P8` |
| Stale serving | ⛔ **FORBIDDEN** — that is `P8` posture |
| General indexing delay | ⛔ **FORBIDDEN** — removal ≠ addition |
| Authorization | ⛔ **FORBIDDEN** — `LIB-16.9`, FROZEN |
| Privacy semantics | ⛔ **FORBIDDEN** — `SEV-9` has **no propagation window** (**L355**, **L737**) |

⭐ **The `SEV-9` carve-out is already in the subject and must not be flattened.** §36 **L840** scopes `P6` as
*"per event class (**except `SEV-9`, which has none**)"*. A single 60-second figure applied across the board
would silently give privacy-mode changes a propagation window the BC Map says they do not have.

> ⚠ **`P6` = PARTIALLY AUTHORITATIVE — removal latency only.** ⛔ **`LCFG-6` NOT extended, NOT modified.**
> The remaining event classes are ⛔ **OPEN**. Owner: **Architecture Owner** (+ **Security** for the value).

### 10.4 `P7` — latency / throughput / availability — ⛔ **BLOCKED EXTERNALLY**

`FACT` — `Library_PRD_v1.md` **L862-864**, `LIB-20.1` (**FROZEN**, Rank 3):

> *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. This PRD
> **MUST NOT** state a competing latency or availability figure."*

`FACT` — ⭐⭐ **the NFR Budgets document DOES NOT EXIST.** `find docs -iname "*NFR*" -type f` returns exactly
**one** file — `docs/30-product/authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` — which is
`PRD-001`'s own chapter, **not** the platform budgets document.
`FACT` — EA **L339** lists `NFR Budgets (V1)` as a **planned node** (*"← NEW"*).
`FACT` — `MASTER_PRD.md` **L575**, `MP-DEP-08` registers *"NFR Budgets document"* as an internal dependency;
**L663**: *"Targets are deliberately not set here."*
`FACT` — `PRD-023`'s baseline row (**L191**) names *"NFR Budgets"* among its **five hard-external blockers**.

⭐ **`P7` is a ROUTING question, not a numbers question**, and the routing terminates at a document that does not
exist. ⚠ **This is platform-wide, not search-specific** — `PRD-023` and `PRD-007` are blocked on the same
absence, which means commissioning it is a **Governance / Architecture Owner** act well above `PRD-015`'s scope.

> ⛔ **`P7` = BLOCKED — hard-external.** ⛔ **No benchmark invented. NFR Budgets NOT created.**

### 10.5 `P8` — rebuild posture and duration — ⭐ split into four, as instructed

`FACT` — §34: `SRCH-INV-005` — every index *"MUST be fully rebuildable from the event log"*; BC Map **L453**
requires this *"tested quarterly, not assumed."*
`FACT` — §34: *"Rebuild **availability posture** — whether search degrades, serves stale, or is unavailable
during a rebuild — is an operational decision recorded in `SRCH-GAP-002`. ⛔ **Not decided here.**"*

| Limb | State | Basis |
|---|---|---|
| **A · Rebuildability / correctness** | ✅ **AUTHORITATIVE** | `SRCH-INV-005`; rebuilt index MUST be *equivalent*; replay MUST honour `SRCH-FR-011`/`012`/`013`/`014` |
| **B · Serve-stale posture** | ⛔ **BLOCKED — needs SECURITY clearance** | See below |
| **C · Rebuild duration** | ⛔ **BLOCKED on `P7`** (D-14) | A duration is an NFR figure; `LIB-20.1` forbids stating it here |
| **D · Full vs incremental** | ⚠ **OPEN** | §34 requires equivalence; ⛔ does not choose a strategy |

⭐⭐ **Limb B is the one with a safety edge, and §34 already carries the control.** *"Serve stale"* means serving
an index that has not yet applied recent events. But `SRCH-FR-013` privacy-mode changes carry **`SEV-9` — no
propagation window** (**L355**, **L783**), and rebuild *"**MUST NOT** re-admit removed documents."*

⇒ A serve-stale posture adopted without qualification would **silently bypass removal and privacy propagation**
during precisely the window when the index is least consistent. ⛔ **This record does not approve stale serving.**
⚠ It requires explicit **Security** review as a precondition, in line with `LCFG-6`'s and `LCFG-12`'s owner being
**Security** and with `R1` being *"the highest risk in the architecture"* (`AR-3`).

> ⚠ **`P8` = MIXED — A authoritative · B blocked (Security) · C blocked (`P7`) · D open.**

---

## 11. `ENT`, `VOC`, `R1` / `R2` / `R7`

### 11.1 ⭐⭐⭐ `ENT` — query-time entitlement

`FACT` — `SRCH-GAP-003` (**L981**): *"The **mechanism** by which a source system's entitlement decision is
evaluated for an index document **at query time**"* — owner **Architecture Owner**, blocks **Stage 3**.
`FACT` — **L707**: *"`BC-23` **consumes** the source system's decision"* — it never redefines it.
`FACT` — `SRCHPO-X4` ⛔ **REJECTED** minting a `BC-23` → `BC-18` edge.

⭐⭐⭐ **The measurement this pass made, which changes the shape of the remedy.** `tool/module_dependencies.yaml`,
`platform/search` block, read in full:

```
platform/search:
  rank: 5
  imports:
    - { target: contracts, mode: import }
  consumes_events: ["*"]
  banned_imports: ["domain/**", "app/**"]     # X-08
  assertions:
    - id: SE-1
      rule: "every index name is tenant-prefixed"
    - id: SE-2
      rule: "every index write carries a permission scope"
```

⭐ **`platform/search` declares NO `ports:` block at all** — measured, not inferred. It therefore holds **no**
`platform/identity:policy_decision`, the port that `domain/library`, `domain/social`, `platform/ai`,
`platform/analytics` and `platform/workflow` all hold (`ADR-0062` **L103**).

⭐⭐ **And the second half of the finding is sharper than the first.** `SE-2` reads *"every index **write**
carries a permission scope."* `SRCH-GAP-003` asks about **query time** — the **read** path. ⇒ The one assertion
that looks like it covers entitlement covers **the opposite path**. The read path has **no assertion and no
port**.

⚠ **The smallest lawful remedy — identified, ⛔ NOT executed.** The repository already contains the **house form**
for exactly this shape: `AMENDMENT A-2` (`platform/identity:account_directory` — *"Read-only, single-subject, no
listing, no lookup by number"*) and `AMENDMENT A-3` (`platform/identity:notification_address` — *"Resolves ONE
address for ONE queued delivery, at delivery time"*). Both are narrow, purpose-limited **manifest port
declarations** — not new BCs, not new APIs, not new authorization models.

⛔ **This record does NOT create that declaration.** The manifest is machine-enforced Rank 4; amending it
requires an ADR, and `SRCHPO-X4` already refused the adjacent move. ⭐ **Naming the form is not making the
amendment**, and the distinction is the whole reason this row is a gate and not an edit.

> ⛔ **`ENT` = BLOCKED / HUMAN DECISION REQUIRED.** Owner: **Architecture Owner**, with ⭐ **mandatory Security
> review of the read path**. ⛔ **No edge, no port, no API, no permission model created.**

### 11.2 `VOC` — variant / abbreviation vocabulary

`FACT` — `SRCH-GAP-007` (**L985**): *"the language/script inventory **and the declared variant/abbreviation
vocabulary**"* — **Product Owner** (markets) **+ Architecture Owner** (analyzer).
`FACT` — `SRCHPO-1`: V1 = English/Latin + Hindi/Devanagari, ⭐ a **closed set**.
`FACT` — `SRCHPO-2`: Hinglish is *"supported **query behaviour** where technically validated"* — explicitly
**NOT** a third canonical language, **not** a separate BC, index or system.
`FACT` — `SRCHPO-3`: *"where technically validated"* is **load-bearing** — permitted, **not required**.
`FACT` — `SRCHPO-X6` ⛔ **REJECTED** the inference that Hinglish implies a transliteration or detection
capability; `SRCH-BR-011` forbids inference from any learned model.

| Half of `SRCH-GAP-007` | State |
|---|---|
| Language / script **inventory** | ✅ **CLOSED** by `SRCHPO-1` |
| Variant / abbreviation **vocabulary** | ⛔ **OPEN** — `SRCHPO-X2` expressly rejects *"`SRCH-GAP-007` is CLOSED"* |

⚠ **No third canonical language is created**, and the vocabulary question is **not** the same as the language
question — collapsing them is precisely the error `SRCHPO-X2` rejects.

> ⚠ **`VOC` = OPEN, and DEFERRABLE.** ⛔ Nothing in V1 depends on it: `SRCHPO-3` makes Hinglish permissive.
> Only the **Product Owner** may set product scope. ⛔ **No vocabulary invented.**

### 11.3 `R1`, `R2`, `R7` — direction verified, not assumed

| Risk | Text | Direction | Verdict |
|---|---|---|---|
| **`R1`** | Tenant data reaching the public index — ⭐⭐ *"Highest in the architecture"* (`AR-3`) | Mitigated by `SRCH-INV-004`, `SRCH-INV-002`, `SRCH-FR-006`, `T-J` | ⛔ **NO DEPENDENCY on `P2`/`P4`** (D-20). ⚠ Residual: *"Implementation-verified, not document-verified"* |
| **`R2`** | Index becoming a silent authorisation bypass — ⭐⭐ Critical | Residual: *"`SRCH-GAP-003` — the entitlement-evaluation mechanism is undecided"* | ⭐ **Depends on `ENT`** (D-19), not on `P2` |
| **`R7`** | Cross-tenant leakage through relevance statistics | *"Depends on `P2` honouring §22"* | ⭐ **REVERSE** (D-21) — `R7` depends on `P2`; `P2` does **not** depend on `R7` |

⚠ **Latent obligations NOT activated.** `R1` and `R2` are **live risks under existing mitigations**, not new
work items. ⛔ `BC-18` authorization is not bypassed, `BC-13` Trust & Safety is not invoked, and no privacy or
identity requirement is relaxed. ⭐ `R7`'s direction is stated explicitly because reading it backwards would
manufacture a dependency **from** a risk register **into** a decision — which would let a mitigation masquerade
as an authority.

---

## 12. Five-expert panel

⚠ Each verdict is `EXPERT` — persuasive, ⛔ **never authoritative**. ⛔ **No expert produced a value.**

### 12.1 PRODUCT

| | |
|---|---|
| **Blockers** | `VOC`'s vocabulary half; `SRCH-GAP-009` (§14A declares **no field precedence order**, which `SRCH-FR-035` layer 2 requires) |
| **Dependencies** | `VOC` → `SRCH-GAP-007`; `SRCHPO-3` keeps Hinglish permissive |
| **Decisions available** | ⛔ **None new.** `SRCHPO-1`…`10` already answered the product half |
| **Risks** | ⚠ Treating `SRCHPO-1` as closing `SRCH-GAP-007` — `SRCHPO-X2` rejects it |
| ⭐ **Finding** | **The product surface is the LEAST blocked of the five.** The Product Owner has already answered; everything downstream now waits on **Architecture** |
| **Smallest lawful step** | ⛔ None required from Product to unblock `F-5` |

### 12.2 ENTERPRISE / DOMAIN

| | |
|---|---|
| **Blockers** | `F-5`; the `platform/search` read-path port absence |
| **Dependencies** | `P1` is **NOT** a blocker (`MP-CON-02`); the manifest is Rank 4 and machine-enforced |
| **Decisions available** | ⛔ None — every candidate needs an ADR first |
| **Risks** | ⚠ Minting the `BC-23` → `BC-18` edge informally (`SRCHPO-X4` refused it) |
| ⭐ **Finding** | ⭐⭐ **`F-5` is NOT a `PRD-015`-local defect.** *"The field's declared script"* presumes a **field-level metadata facility** that no BC claims. `BC-25` Configuration is the natural home and **has no registered claimant** (`PRD_REGISTRY.md` **L414**). ⇒ The predicate may have **no owner at all**, not merely no value |
| **Smallest lawful step** | Determine whether `F-5` is a `BC-23` property or a `BC-25` one — ⛔ **before** drafting any option list |

### 12.3 SEARCH ENGINEERING

| | |
|---|---|
| **Blockers** | `P2U`; `N5`; the `N6`×`N4` ordering gap |
| **Dependencies** | `P3` and `P4` are **siblings**, both children of `P2U` + `N5` |
| **Decisions available** | ⚠ `P2-C` only |
| **Risks** | ⚠ Adopting an engine's defaults as the specification — forbidden by `MP-CON-02` |
| ⭐ **Finding** | ⭐⭐ **A pipeline whose step ORDER is unspecified cannot be symmetric even if every step is.** `SRCH-FR-023` requires *"the same declared rule set"*; §16 is a **table**. Two implementations could apply `N1`–`N6` in different orders, both claim conformance, and produce **different indexes** |
| **Smallest lawful step** | Record the `N6`×`N4` ordering gap ⇒ ⭐ **done in §7.1** |

### 12.4 SECURITY / PRIVACY

| | |
|---|---|
| **Blockers** | `ENT` read path; `P8` limb B |
| **Dependencies** | `R2` → `ENT`; `P8`-B → `SEV-9` privacy semantics |
| **Decisions available** | ⛔ None without Architecture Owner action |
| **Risks** | ⚠ Serve-stale bypassing removal; ⚠ normalization collision at the EXACT tier |
| ⭐ **Finding** | ⭐⭐⭐ **`SE-2` creates a FALSE SENSE OF COVERAGE.** *"Every index **write** carries a permission scope"* is the only entitlement assertion `platform/search` holds, and `SRCH-GAP-003` asks about **reads**. A reviewer scanning the manifest for authorization sees `SE-2` and may conclude the path is covered. ⭐ **It covers the opposite direction.** Writes being scoped says nothing about whether a *query* re-evaluates entitlement — which is exactly `R2`, *"the index becoming a silent authorisation bypass"* |
| **Smallest lawful step** | ⭐ **Security review of the READ path specifically** — ⛔ not the write path, which `SE-2` already covers |

### 12.5 QA / TRACEABILITY

| | |
|---|---|
| **Blockers** | `SRCH-AC-050` unsatisfiable; Devanagari acceptance-uncovered |
| **Dependencies** | Every AC for `P3`/`P4` awaits a unit |
| **Decisions available** | ⛔ None |
| **Risks** | ⚠ A criterion that cannot run is indistinguishable from one that passes |
| ⭐ **Finding** | ⭐⭐ **The test suite CANNOT DETECT any of this.** `SRCH-AC-050` requires *"each rule is checked for symmetry"* — an iteration that cannot complete while `F-5` is open, so it never **fails**; it never **runs**. And `SRCH-AC-024`'s four cases are **all Latin**, so Devanagari has **zero** acceptance coverage. ⇒ ⭐ **The two hardest problems in `PRD-015` are both invisible to its own acceptance criteria** |
| **Smallest lawful step** | ⛔ Do **not** add ACs — they would inherit the same undefined predicate |

### 12.6 Tally

| Expert | Verdict | Produced a value? |
|---|---|---|
| Product | ⚠ **CLEAR on its own half; blocked downstream** | ⛔ No |
| Enterprise | ⛔ **BLOCKED** — `F-5` may be ownerless | ⛔ No |
| Search Engineering | ⛔ **BLOCKED** | ⛔ No |
| Security | ⛔ **BLOCKED** — read path uncovered | ⛔ No |
| QA | ⛔ **CANNOT CLEAR** | ⛔ No |

⛔ **5 of 5 blocked or unable to clear. 0 of 5 produced a value, rule, unit or form.**

---

## 13. MASTER DEPENDENCY ORDER

### 13.1 The complete order

| # | Node | Class | Depends on | Owner |
|---|---|---|---|---|
| **1** | ⭐⭐⭐ **`F-5`** | ⛔ **HUMAN DECISION — BLOCKED** | ⛔ nothing — **root of the critical chain** | Architecture Owner |
| **2** | `P2-D` | ⛔ **BLOCKED** | `F-5` (D-1) | Architecture Owner |
| **3** | `P2-B` | ⛔ **BLOCKED** | `P2-D` (D-3) → `F-5` (D-2) | Architecture Owner |
| **4** | `P2U` | ⛔ **HUMAN DECISION — BLOCKED** | ⚠ `F-5` **OPTIONAL** (D-4) — ⭐ **can start in PARALLEL with 1** | Architecture Owner |
| **5** | `P3` | ⛔ **BLOCKED** | `P2U` (D-8) + `N5` (D-7) | Architecture Owner |
| **5′** | `P4` | ⛔ **BLOCKED** | `P2U` (D-5) + `N5` (D-6) — ⭐ **SIBLING of 5, not downstream** | Architecture Owner |
| **P-a** | `P2-A` | ⛔ **HUMAN DECISION — BLOCKED** · **PARALLEL** | own evidence (packet §5.2) | Architecture Owner |
| **P-b** | 🔓 `P2-C` | ⚠ **HUMAN DECISION — DECIDABLE NOW** · **PARALLEL** | ⛔ nothing | Architecture Owner |
| **P-c** | `P1` | ⚠ **OPEN (posture)** · **PARALLEL** | ⛔ nothing (D-9/D-10) | Architecture Owner |
| **P-d** | `P5` | ✅ **PARTIALLY AUTHORITATIVE** · **PARALLEL** | ⛔ nothing (D-11) | Security (value) |
| **P-e** | `P6` | ✅ **PARTIALLY AUTHORITATIVE** · **PARALLEL** | ⛔ nothing (D-12) | Security + Architecture Owner |
| **P-f** | `P7` | ⛔ **BLOCKED — HARD-EXTERNAL** · **PARALLEL** | NFR Budgets doc, ⛔ **does not exist** (D-13) | Governance / Architecture Owner |
| **P-g** | `P8` A | ✅ **AUTHORITATIVE** | — | — |
| **P-h** | `P8` B | ⛔ **BLOCKED — Security** · **PARALLEL** | `SEV-9` privacy (D-15) | Architecture Owner + Security |
| **P-i** | `P8` C | ⛔ **BLOCKED** | `P7` (D-14) | — |
| **P-j** | `P8` D | ⚠ **OPEN** · **PARALLEL** | ⛔ nothing | Architecture Owner |
| **P-k** | ⭐ `ENT` | ⛔ **HUMAN DECISION — BLOCKED** · **PARALLEL** | `SRCH-GAP-003` (D-16) + manifest (D-17) | Architecture Owner + Security |
| **P-l** | `VOC` | ⚠ **OPEN — DEFERRABLE** · **PARALLEL** | `SRCH-GAP-007` (D-18) | Product + Architecture Owner |
| **P-m** | `R1` | ⚠ **MITIGATED — live** | ⛔ nothing (D-20) | — |
| **P-n** | `R2` | ⛔ **BLOCKED** | `ENT` (D-19) | — |
| **P-o** | `R7` | ⚠ **DOWNSTREAM of `P2`** | ⭐ reverse (D-21) | — |

### 13.2 ⭐ CRITICAL CHAIN — confirmed with one correction

The proposed chain was `F-5 → P2-D → P2-B → P2U → P4`.

> ✅ **CONFIRMED for `F-5 → P2-D → P2-B`.**
> ⚠ **CORRECTED at one link: `P2-B → P2U` is NOT a dependency.**

`EVIDENCE` — `P2U` asks *"in what unit is length counted?"*; `P2-B` asks *"does case folding apply to a
unicameral script?"* Neither answer constrains the other. `P2U`'s only upstream relation to `F-5` is **OPTIONAL**
(D-4): the unit can be *named* without the predicate, though which unit is *right* varies by script.

⭐ **The corrected shape:**

```
        F-5  (root, BLOCKED)
         |
         +--> P2-D --> P2-B          [sequential]
         |
         +~~~> P2U  (OPTIONAL link)  [can start in PARALLEL]
                |
                +--> P4   \  siblings, both also need N5
                +--> P3   /
```

⭐⭐ **Why the correction matters operationally.** Under the serial reading, `P2U` waits for `P2-B`, and `P4` is
four hops from the root. Under the measured graph, **`P2U` can be worked in parallel with `F-5`**, and `P4`
becomes reachable as soon as `P2U` **and** `N5` land. That is a materially shorter path to unblocking `P4` — and
it is only visible because the link was tested rather than inherited.

### 13.3 SECONDARY CHAIN — `P2 → P3`

> ✅ **CONFIRMED, and made precise.**

`P3` does not depend on all of `P2`. It depends on exactly two `P2` products:

| `P3` needs | From | Class |
|---|---|---|
| A counting **unit** | `P2U` | **REQUIRED** (D-8) |
| A determinate **token** | `N5` | **REQUIRED** (D-7) |

⛔ `P3` does **not** depend on `P2-B` (case folding), `P2-C` (`ZWJ`/`ZWNJ`) or `P2-A` (config source).
⭐ ⇒ **`P3` and `P4` have IDENTICAL upstream requirements.** They unblock **together** or not at all.

### 13.4 Sequential vs parallel

| Mode | Nodes |
|---|---|
| ⭐ **SEQUENTIAL** | `F-5` → `P2-D` → `P2-B` |
| ⭐ **SEQUENTIAL** | (`P2U` + `N5`) → { `P3`, `P4` } |
| **PARALLEL — can proceed now** | `P2-C` · `P1` (posture) · `P5` citation · `P6` remaining classes · `P8` D · `VOC` · `ENT` scoping |
| **PARALLEL — blocked externally** | `P7` · `P8` C |
| ⛔ **BLOCKED** | `F-5` · `P2-A` · `P2-B` · `P2-D` · `P2U` · `P3` · `P4` · `ENT` · `P8` B · `R2` |

⭐ **9 nodes can lawfully proceed in parallel today.** ⛔ Forcing them into the critical chain would invent
blockage the repository does not support.

---

## 14. Consolidated `HUMAN` decision packet

⚠ **Identifier discipline.** Only two families are used: `SRCHAO-P2a`…`P2U`, already established by
`PRD-015_P2_ARCHITECTURE_DECISION.md` §13, and `SRCHAO-F5`, minted in §4 for the re-verified root finding.
⛔ **`SRCHAO-P3`, `SRCHAO-P4`, `SRCHAO-P1`, `SRCHAO-P7`, `SRCHAO-P8`, `SRCHAO-ENT`, `SRCHAO-VOC` and
`SRCHAO-R1/R2` are NOT minted** — the repository does not yet establish them, and minting a decision identifier
creates the appearance of a live decision slot where none has been conferred. Those rows are carried by their
**existing** gap identifiers instead.

| # | ID | Question | Owner | Status | Blocked by | Unblocks |
|---|---|---|---|---|---|---|
| 1 | ⭐ **`SRCHAO-F5`** | Per-field script / language applicability predicate | Architecture Owner | ⛔ **BLOCKED** | ⛔ nothing — root | `P2-D`, `P2-B` |
| 2 | **`SRCHAO-P2a`** | Analyzer / tokenizer configuration source | Architecture Owner | ⛔ **BLOCKED** | own evidence | `N5` ⇒ `P3`, `P4` |
| 3 | **`SRCHAO-P2b`** | Devanagari case-folding — incl. *"not applicable"* | Architecture Owner | ⛔ **BLOCKED** | `P2-D` | `N1` completeness |
| 4 | 🔓 **`SRCHAO-P2c`** | `ZWJ`/`ZWNJ` named exception + `N6`×`N4` order | Architecture Owner | ⚠ **OPEN — decidable now** | ⛔ nothing | `N6` completeness |
| 5 | **`SRCHAO-P2d`** | Script-aware vs uniform | Architecture Owner | ⛔ **BLOCKED** | `F-5` | `P2-B` |
| 6 | ⭐ **`SRCHAO-P2U`** | Counting / measurement unit | Architecture Owner | ⛔ **BLOCKED** | ⚠ `F-5` (optional) | `P3`, `P4` |
| 7 | `SRCH-GAP-002` (`P1`) | Abstraction posture, ⛔ not an engine | Architecture Owner | ⚠ **OPEN — posture** | ⛔ nothing | — |
| 8 | `SRCH-GAP-002` (`P7`) | Route figures to NFR Budgets + commission it | Governance / Architecture Owner | ⛔ **BLOCKED — external** | doc absent | `P8` C |
| 9 | `SRCH-GAP-002` (`P8` B) | Serve-stale posture | Architecture Owner **+ Security** | ⛔ **BLOCKED** | `SEV-9` privacy | — |
| 10 | ⭐ `SRCH-GAP-003` (`ENT`) | Query-time entitlement mechanism + read-path port | Architecture Owner **+ Security** | ⛔ **BLOCKED** | manifest, ADR | `R2` |
| 11 | `SRCH-GAP-007` (`VOC`) | Variant / abbreviation vocabulary | Product **+** Architecture Owner | ⚠ **OPEN — deferrable** | ⛔ nothing in V1 | — |

**11 rows — 0 `AUTHORITATIVE` · 0 `CLOSED` · 3 `OPEN` · 1 `OPEN`-decidable-now · 7 `BLOCKED`.**

⛔ **Every human field in every form referenced above remains BLANK.**
Forms 2–6 live in `PRD-015_P2_ARCHITECTURE_DECISION.md` §13 (**29 BLANK fields**) and are ⛔ **not reproduced or
altered here**. Form 1 is §4 above (**6 BLANK fields**). ⇒ **35 BLANK fields total.**

---

## 15. Validation

### 15.1 ⚠ Disclosed limitation

⛔ **No `PRD-015` validator exists** (§1.1). ⛔ **One was not created.** All checks below are **manual**.

### 15.2 Manual integrity checks

| # | Check | Result |
|---|---|---|
| V1 | Subject `sha256` = `fe3093e6…c2c4544` | ✅ **UNCHANGED** |
| V2 | Subject byte-unchanged (`git diff`) | ✅ empty |
| V3 | 7 prior `PRD-015` records unchanged | ✅ |
| V4 | ⭐ `PRD-015_P2_ARCHITECTURE_DECISION.md` unchanged | ✅ — historical, not rewritten |
| V5 | ⭐ `PRD-015_P4_ARCHITECTURE_DECISION.md` unchanged | ✅ — historical, not rewritten |
| V6 | `PRD-021A`/`B`/`C` untouched | ✅ |
| V7 | Frozen `Library_PRD_v1.md` untouched | ✅ |
| V8 | `MASTER_PRD.md` untouched | ✅ |
| V9 | `CONFIGURATION_GUIDE.md` untouched — `LCFG-6`/`LCFG-12` not modified | ✅ |
| V10 | ⭐ `tool/module_dependencies.yaml` untouched — **no port added** | ✅ |
| V11 | BC Map untouched — **no BC, no edge** | ✅ |
| V12 | `ADR-0088`/`0089`/`0090` — 0 files, exact-filename loop | ✅ **RESERVED** |
| V13 | New ADRs created | ✅ **0** |
| V14 | `IMPL-*` created | ✅ **0** |
| V15 | Acceptance criteria created | ✅ **0** |
| V16 | Benchmarks / NFR figures stated | ✅ **0** |
| V17 | Values invented (unit, distance, prefix, page, lag, latency) | ✅ **0** |
| V18 | Engines / libraries / stemmers named | ✅ **0** |
| V19 | Normalization rules created or modified (`N1`–`N6`) | ✅ **0** |
| V20 | Code files touched | ✅ **0** |
| V21 | Stage 4 entered | ✅ **NO** |
| V22 | Stage 7 entered | ✅ **NO** |
| V23 | `PRD-015` frozen / baselined / ranked | ✅ **NO / NO / NO** |
| V24 | `PRD_REGISTRY.md` **L315** | ✅ still `PLANNED` |
| V25 | Human decision fields filled | ✅ **0 of 35** |
| V26 | Commits amended / history rewritten / force-pushed | ✅ **NO / NO / NO** |
| V27 | Files created by this pass | ✅ **exactly 1** |
| V28 | ⭐ Dependencies inherited without re-verification | ✅ **0** — all 22 re-derived (§2) |

### 15.3 What this record created

⭐ **One file.** ⛔ **0** values · **0** rules · **0** units · **0** engines · **0** `ADR`s · **0** `BC`s ·
**0** edges · **0** ports · **0** `IMPL-*` · **0** ACs · **0** benchmarks · **0** new authorities ·
**0** filled human fields.

---

## 16. Change log

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-03 | **Created.** Complete dependency-ordered resolution record for `PRD-015`, spanning `F-5`, `P1`–`P8`, `P2-A`/`B`/`C`/`D`, `P2U`, `ENT`, `VOC`, `R1`/`R2`/`R7`. **Phase 0:** 13 integrity gates, all PASS; `ADR-0088`/`0089`/`0090` verified 0 files by **exact-filename loop, not glob** (the false-positive trap `ADR-INDEX.md` **L9** records). **Phase 1:** ⭐ **all 22 dependency edges re-derived from source, 0 inherited**. **`F-5`:** independently re-verified — **0 of 7** repository hits define the predicate; ⭐⭐⭐ **`SRCHPO-A3` tested rather than dismissed and found NOT to supply it** — `SRCHPO-1` gives a platform script **SET**, `SRCH-FR-024` **L416** needs a per-field script **FUNCTION**, and the PO record's own §2.4 says so; ⭐⭐ **the query side has no field at all**, so the predicate is a **type mismatch across a MUST**, not an unset value. **`P1`:** ⭐⭐ **`MP-CON-02` INVERTS the intuitive reading** — engine choice is a **deployment** decision and deriving normalization from engine defaults is the exact act it forbids ⇒ **`P1` blocks nothing and excuses nothing**. **`P5`/`P6`:** authoritative values **found and preserved, not duplicated** (`LCFG-12` = 20; `LCFG-6` = 60 s **removal latency only**), with `LCFG-6`'s six forbidden extensions enumerated and the **`SEV-9` no-propagation-window** carve-out protected. **`P7`:** ⛔ **hard-external** — `LIB-20.1` routes figures to a document that **does not exist** (`find` returns only `PRD-001`'s own chapter). **`P8`:** split four ways — A authoritative, B ⛔ **blocked pending Security** because serve-stale would bypass `SEV-9` removal propagation, C blocked on `P7`, D open. **`ENT`:** ⭐⭐⭐ measured that **`platform/search` declares NO `ports:` block at all**, and ⭐⭐ that **`SE-2` covers index WRITES while `SRCH-GAP-003` asks about query-time READS** — the one assertion that looks like coverage covers the opposite path; the `A-2`/`A-3` house form is **named but ⛔ NOT executed**. **`VOC`:** inventory half **CLOSED** by `SRCHPO-1`, vocabulary half **OPEN** per `SRCHPO-X2`; ⛔ no third canonical language. **`R1`/`R2`/`R7`:** directions verified — `R1` independent, `R2` → `ENT`, ⭐ `R7` **reverse** (depends on `P2`). **Five-expert panel:** ⛔ **5/5 blocked or unable to clear, 0/5 produced a value**; ⭐⭐ Enterprise: **`F-5` may be OWNERLESS** (`BC-25` has no registered claimant); ⭐⭐ Security: **`SE-2` creates a false sense of coverage**; ⭐⭐ QA: **both hardest problems are invisible to `PRD-015`'s own acceptance criteria**; ⭐⭐ Search: **an unspecified pipeline ORDER defeats symmetry even if every step is symmetric**. **Master order:** ⭐⭐ critical chain **CONFIRMED for `F-5` → `P2-D` → `P2-B`** but **CORRECTED at one link — `P2-B` → `P2U` is NOT a dependency**, so `P2U` runs in **parallel** with `F-5` and `P4` is materially closer than a serial reading predicts; ⭐ `P3` and `P4` found to be **siblings with identical upstream needs**, not a chain; **9 nodes can lawfully proceed in parallel today**. **Decision packet:** 11 rows — **0 AUTHORITATIVE · 3 OPEN · 1 decidable-now · 7 BLOCKED**; ⛔ **only `SRCHAO-F5` minted**, and 8 candidate identifiers **deliberately NOT minted** because the repository does not establish them; **35 human fields, ALL BLANK**. ⛔ **Creates 0 values, 0 rules, 0 units, 0 engines, 0 ADRs, 0 BCs, 0 edges, 0 ports, 0 `IMPL-*`, 0 ACs, 0 benchmarks, 0 authorities.** ⛔ **Subject byte-unchanged; 7 prior records byte-unchanged; no frozen document touched; no commit amended; no force-push; Stage 4 NOT entered; Stage 7 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked; registry **L315** still `PLANNED`.** ⛔ **`F-5` = BLOCKED. `P4` = BLOCKED. CONFERRAL = NOT CONFERRED.** |
