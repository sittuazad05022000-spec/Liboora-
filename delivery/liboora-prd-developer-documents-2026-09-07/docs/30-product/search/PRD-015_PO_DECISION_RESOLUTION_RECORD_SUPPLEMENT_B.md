# `PRD-015` — Product Owner Decision Resolution Record — **SUPPLEMENT B**

## ⭐ `H-B` — per-field script binding for the three `text`-role units

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record — **SUPPLEMENT** to `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` v1.0 |
| **Version** | v1.0 |
| **Date** | 2026-09-05 |
| **Predecessor** | `PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_A.md` v1.0 (`SRCHPO-16`, the `H-B0` match-role classification) |
| **Why a SUPPLEMENT and not an edit** | The parent record's own §14 forbids it: *"If a later decision supersedes it, the remedy is a **new record or a supplement** — ⛔ **never a silent rewrite of these answers**."* Supplement A was created on that ground; this record follows the same ground |
| **Form** | Follows `PRD-006_PO_DECISION_RESOLUTION_RECORD.md` — the **`SRCHPO-A3` precedent** selected by human ruling **`HD-1`** |
| **Mechanism** | ⭐ **`HD-1`, verbatim:** *"Use the existing PO-style declaration record mechanism, following the established `SRCHPO-A3` precedent, as the authoritative artefact carrying the per-field script binding. Do NOT modify frozen §14A merely to add the script attribute."* ⛔ **No new mechanism is created** |
| **Blocker addressed** | ⭐ **`H-B` ONLY** |
| **Units bound** | **3 of 3** — the `text`-role set fixed by `SRCHPO-16` |
| **Units NOT bound** | ⛔ **11 of 14** — every `exact`, `filter` and `none` unit. **0 scripts assigned to them** |
| **Architecture Owner concurrence** | ⚠⚠ **OPEN — NOT GIVEN, NOT MANUFACTURED.** See §6 |
| **Final decision** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** |

---

## 1. The decision as given

The Product Owner explicitly adopted the following per-field script binding for the three
`text`-role units established by `H-B0` / `SRCHPO-16`.

### `SRCHPO-17` — per-field script binding, `text`-role units

| # | Unit | Owning context | `SRCH-FR-018` role (`SRCHPO-16`) | ⭐ Declared script |
|---|---|---|---|---|
| 1 | **Library Name** | `BC-19` (`PRD-013`) | `text` | ⭐ **Latin + Devanagari** |
| 2 | **Business Address → City** | `BC-19` (`PRD-013`) | `text` | ⭐ **Latin + Devanagari** |
| 3 | **Map Location → Locality** | `BC-19` (`PRD-013`) | `text` | ⭐ **Latin + Devanagari** |

⭐ **3 of 3 `text`-role units are bound.** The denominator is **3**, fixed by `SRCHPO-16` §4 — not
the unverified 14 that preceded it.

### 1.1 The interpretation, as given

| # | Interpretive limb, as adopted |
|---|---|
| 1 | **Latin** supports English **and** Hinglish / Romanized Hindi *query behaviour* |
| 2 | **Devanagari** supports Hindi |
| 3 | ⛔ **Hinglish / Romanized Hindi is NOT a third canonical language** |
| 4 | The canonical V1 language/script scope **remains** English/Latin + Hindi/Devanagari |
| 5 | ⛔ **No separate "Hinglish" script or language value is created** |

### 1.2 ⭐ The interpretation is coherent with `SRCHPO-2` / `SRCHPO-3` / `HD-16`, measured

| Existing authority | What it says | ⭐ This adoption |
|---|---|---|
| `SRCHPO-2` | Hinglish is *"supported **query behaviour** where technically validated. It is **NOT** a canonical third language"*; explicitly not a separate BC, index or search system | ✅ **Identical** — limb 1 places Hinglish inside **Latin**, adding no value |
| `SRCHPO-3` | *"where technically validated"* is load-bearing; Hinglish is *"permitted, not required"* | ✅ **Untouched** — this record does not claim Hinglish is validated |
| `SRCHPO-1` | Closed set of exactly two: English (Latin), Hindi (Devanagari) | ✅ **Preserved** — both bound values are members; ⛔ **0 non-members introduced** |
| `HD-16` | *"do not create a third canonical language/index"* | ✅ **Satisfied** — limb 5 states the prohibition in terms |
| `ADR-0099` `C-8` | *"The configuration MUST NOT presuppose a third canonical language or index"* | ✅ **Satisfied** |

⭐⭐ **Limb 1 is the load-bearing one, and it is the reason this adoption does not breach `SRCHPO-2`.**
Placing Romanized Hindi inside the **Latin** binding is precisely what avoids a third value: a
Hinglish query is Latin characters, and it is matched by the Latin rule set. ⛔ **No transliteration
rule, no language detection and no third script is introduced by that placement** — and none is
invented here.

---

## 2. ⭐⭐⭐ The dual-script question — tested BEFORE recording, and cleared with a named residual

⚠⚠ **This section is placed before the authorisation section deliberately, because the adverse
reading had to be disposed of first.** The binding assigns **two** scripts to each unit, while three
separate authorities speak of *"**the** field's authoritative declared script"* in the **singular**.
That apparent conflict was tested rather than assumed away.

### 2.1 The apparent conflict, stated at its strongest

| Authority | Wording | Number |
|---|---|---|
| `ADR-0099` **`C-3`** (**L87**) | *"The configuration MUST consume **an** authoritative declared script"* | **singular** |
| `ADR-0099` **`C-4`** (**L88**) | *"Normalization rules are applied according to **the field's** authoritative declared script"* | **singular** |
| `HD-2` (record §3.1) | *"applied according to **the** authoritative declared script associated with the field"* | **singular** |

⭐ **And the escape routes are closed in advance:**

| Tempting resolution | ⛔ Why it is unavailable |
|---|---|
| Detect the script from the value | ⛔ `ADR-0099` `C-3`: *"it MUST NOT detect script from content"*; `C-9`: no language-detection capability; `SRCHPO-2`: *"Do not invent language detection"*; `SRCHAO-F5 = Option A`: *"Analyzer MUST NOT infer/detect script from content"* |
| Split the field across two indexes | ⛔ Parent record §2.3 — `SRCHPO-1` does **not** authorise *"a second index, a per-language index, or a per-script BC"* |
| Declare one script and drop the other | ⛔ Fails `SRCHPO-1`'s two-member inventory; and my own Part XIX §164 required that Devanagari be *"reachable somewhere"* |

### 2.2 ⭐⭐⭐ `SRCHPO-A9` — the conflict is NOT a conflict: cardinality-one is nowhere imposed on script

`FACT` — measured this pass, repository-wide over `docs/`:

| Measurement | Regex | Result |
|---|---|---|
| Any authority imposing one script per field | `exactly one script\|single script\|one script per\|only one script` | ⭐⭐⭐ **0 relevant hits** (the 1 hit is *"a single script"* meaning a shell script, in `PRD-007`) |
| How this repository **does** impose cardinality one | `exactly one` in the subject | **8 hits** — index class (`SRCH-INV-002`), ordering (`SRCH-BR-014`), implementation (**L1035**), ⭐ **match role (`SRCH-AC-018`, L1066)** |

⭐⭐⭐ `ANALYSIS` — **The contrast is the finding.** `SRCH-AC-018` states cardinality one **expressly**
for match roles: *"**then** exactly one match role — text, exact or filter — is declared for it."*
That is what a cardinality constraint looks like in this repository. **No equivalent sentence exists
for script anywhere.** ⇒ The singular articles in `C-3`, `C-4` and `HD-2` are **grammatical**, not
**normative**: they describe *which* declaration governs a normalization decision, not *how many*
scripts a field may declare.

⚠ **The honest limit of that finding, stated rather than hidden.** An absence of a cardinality rule
is an **absence**, and this record does not convert it into a permission. What it establishes is
narrower and sufficient: ⛔ **no authority is breached by a two-member binding.** The binding is
therefore not *unlawful*; it is *unaddressed as to mechanism* — which is §2.4.

### 2.3 ⭐⭐ `SRCHPO-A10` — the repository already contemplated multi-script values, and left the sub-question OPEN

`FACT` — `PRD-015_P2_ARCHITECTURE_DECISION.md` **L691**, verbatim:

> *"…whether *"not applicable"* is the right shape at all, given that a **mixed-script field value**
> (a Hindi name containing a Latin acronym) would need `N1` to apply to **part** of a value.
> ⚠ **That sub-question is itself unaddressed by any authority**, and it is recorded here rather
> than resolved."*

`FACT` — the same document's **Phase 8** table records, against Model **A — SCRIPT-AWARE**:
*"Script determination is **attacker-influenced input** — a mixed-script value could steer which
rules fire."*

⭐⭐ `ANALYSIS` — **Three consequences, and the third cuts against me:**

1. ⭐ **A field value spanning both scripts was already a live architectural fact**, independent of
   this adoption. `L691` names it as a *Hindi name containing a Latin acronym* — i.e. exactly a
   **Library Name**, unit 1 of this binding. ⇒ The adoption **describes the corpus** rather than
   complicating it.
2. ⭐ **Supplement A anticipated a combination binding.** Its §4 (**L175-176**) records: *"a lawful
   `H-B` act may bind these three units to either script, **in any combination**, subject to `HD-3`'s
   script-conditional rule and Architecture Owner concurrence."* ⇒ This act is the one that record
   contemplated, not a departure from it.
3. ⚠⚠ **But `P2` expressly left the sub-question OPEN, and this record cannot close it.** How `N1`
   applies to *part* of a value is an **analyzer** question. It belongs to `ADR-0099` §2.1 —
   *"an artefact governed by the Architecture Owner"* — and is listed in §2.3's OPEN items as the
   Devanagari rule content. ⇒ **§2.4.**

### 2.4 ⭐⭐⭐ `SRCHPO-A11` — the residual, named: a two-member binding requires a RULE-SELECTION mechanism, and that mechanism is Architecture-Owned

⭐ **What this record settles:** each of the three `text` units **admits** both members of
`SRCHPO-1`'s closed set. The *declaration* is complete and total for those units.

⛔ **What this record does NOT settle, and must not:** by what declared rule the analyzer selects
between the Latin and Devanagari rule sets for a given token, given that content-detection is
prohibited. That is a property of the **rule set**, not of the field:

| Requirement | Authority | Status after this record |
|---|---|---|
| The rule set must be **symmetric and total** | `SRCH-BR-008` (**L427-429**) | ⚠ **OPEN** — totality over a two-member script domain needs an evaluable disposition per rule |
| Rules applied per the field's declared script | `ADR-0099` `C-4`; `HD-2` | ⚠ **OPEN as to content** — `HD-2` is *"MODEL CLOSED · RULE CONTENT OPEN"* |
| `N1` has no meaningful Devanagari application | `HD-3` — SCRIPT-CONDITIONAL | ⭐ **Already ruled.** `HD-3` is the closest existing authority to a selection rule, and it is **per-rule**, not per-field — which is the shape a two-member binding needs |
| Script must never be derived from content | `C-3`, `C-9`, `SRCHAO-F5 = Option A` | ✅ **Preserved — 0 detection introduced here** |

⭐⭐⭐ `ANALYSIS` — **`HD-3` is why the two-member binding is coherent rather than incoherent.**
`HD-3` already applies normalization **script-conditionally at the rule level** — *"Latin case
folding applies where relevant to Latin-script content… Do NOT apply a fictional Latin case-folding
operation to Devanagari"* — while expressly forbidding the reading that Devanagari receives no
normalization. A rule-level conditional does not require the *field* to hold exactly one script; it
requires each **rule** to have a defined disposition. ⇒ A two-member field binding is the input that
`HD-3`'s shape already presupposes.

⛔ **That is a coherence finding, not a mechanism.** The disposition table itself remains **OPEN**,
routed at `ADR-0099` §2.3 to *"a later Architecture Owner act, evidence-bound"*. ⚠ **This record
creates no such table, names no analyzer, and writes no `N1`–`N6` disposition.**

---

## 3. ⭐ Why the Product Owner limb is independently lawful

`HD-1` §2.3's *Remaining dependency* line is the operative routing, verbatim:

> **Owner:** Product Owner (domain) **with Architecture Owner concurrence per `ADR-0099` `C-3`**.

⭐⭐ **The routing names two limbs and attributes them to two different offices.** The **domain**
limb — *which script a Liboora library name is written in* — is a product/market fact of exactly the
class `SRCHPO-1` already decided; `SRCH-GAP-007`'s Product-Owner half is defined as *"which markets
V1 serves."* ⇒ The PO limb does not depend on the Architecture limb for its **content**.

| Legality test | Result |
|---|---|
| Is the acting office the one the routing names for this limb? | ✅ **YES** — Product Owner (domain). `PRD-015`'s Product Owner is **not** recorded VACANT anywhere |
| Is the carrier the one the closed ruling selected? | ✅ **YES** — `HD-1`'s PO-style declaration record, `SRCHPO-A3` precedent. ⛔ 0 new mechanisms |
| Are the values drawn from existing authority rather than invented? | ✅ **YES** — both are members of `SRCHPO-1`'s closed set. ⛔ **0 new script or language values** |
| Is any frozen document amended? | ⛔ **NO** — §14A, §14B, `Library_PRD_v1.md` and the subject are byte-unchanged |
| Does it breach any measured authority? | ⛔ **NO** — §2.2 measured 0 cardinality rules; §1.2 measured coherence with 5 authorities |
| Does it complete the act `ADR-0099` `C-3` requires? | ⛔⛔ **NO** — concurrence is a **separate limb** and is **OPEN**. §6 |

⇒ ⭐ **The PO declaration is recorded. The act it belongs to is NOT complete.**

---

## 4. What this record authorises — and does not

### 4.1 ✅ Authorised

| # | Authorised |
|---|---|
| 1 | The three `text`-role units each **admit** Latin and Devanagari, per `SRCHPO-17` |
| 2 | `SRCH-FR-024`'s preamble — *"where compatible with the field's declared script and language scope"* — acquires a **declared input** for these three units for the first time |
| 3 | `ADR-0099` `C-3`'s *"authoritative declared script"* now has a **named carrier and a value** for 3 units — ⚠ subject to concurrence |
| 4 | Devanagari is **reachable** in the V1 index, satisfying the Part XIX §164 consistency test that the all-Latin proposal failed |

### 4.2 ⛔ NOT authorised — stated in the parent record's style

| # | ⛔ Not authorised |
|---|---|
| 1 | ⛔ **No script is assigned to any of the other 11 units** — every `exact`, `filter` and `none` unit in `SRCHPO-16` is untouched |
| 2 | ⛔ **No Architecture Owner concurrence** is claimed, implied or manufactured (§6) |
| 3 | ⛔ **No third language or script value** — no "Hinglish" script, language, locale or tag exists after this record |
| 4 | ⛔ **No transliteration rule**, Romanization table or Hinglish mapping |
| 5 | ⛔ **No language or script detection** capability |
| 6 | ⛔ **No analyzer, tokenizer or stemmer** is named or specified |
| 7 | ⛔ **No `N1`–`N6` disposition table** for either script |
| 8 | ⛔ **No rule-selection mechanism** for the two-member binding — `SRCHPO-A11`, Architecture-Owned |
| 9 | ⛔ **No second index, per-language index or per-script BC** |
| 10 | ⛔ **`HD-2`, `HD-3`, `HD-4`, `HD-7`, `HD-8`, `HD-11`, `HD-13` are not closed** by this record |
| 11 | ⛔ **`H-C`, `H-D`, `H-E` are not resolved** — corpus, ZWNJ fact, SRE office and reviewer are untouched |
| 12 | ⛔ **No `P4` value**, edit-distance bound or prefix length |
| 13 | ⛔ **No freeze, baseline, rank or Stage-3 conferral** |
| 14 | ⛔ **No `IMPL-*` task** and **no code** |

---

## 5. `H-B` gate — re-run

| # | `H-B` condition | Before | ⭐ After |
|---|---|---|---|
| 1 | The set of units requiring a script is authoritatively fixed | ✅ **3**, by `SRCHPO-16` | ✅ **3** |
| 2 | Every such unit carries a declared script | ⛔ **0 of 3** | ✅ **3 of 3** |
| 3 | Every value is a member of `SRCHPO-1`'s closed set | — | ✅ **2 of 2 members used; 0 non-members** |
| 4 | Devanagari is reachable somewhere in the V1 index | ⛔ **FAILED** (all-Latin proposal) | ✅ **PASSES** |
| 5 | An actual Product Owner act occurred | ⛔ **NO** | ✅ **YES** |
| 6 | Recorded through the lawful carrier (`HD-1` / `SRCHPO-A3`) | ⛔ not recorded | ✅ **this supplement** |
| 7 | Recorded without amending a frozen document | — | ✅ **0 frozen bytes** |
| 8 | No third language/script introduced | — | ✅ **0** |
| 9 | ⭐⭐ **Architecture Owner concurrence under `ADR-0099` `C-3`** | ⛔ **NOT SUPPLIED** | ⛔⛔ **STILL NOT SUPPLIED — OPEN** |

### ⚠⚠ `H-B` — **NOT CLOSED.** ⭐ **PO limb 8/8 · concurrence limb 0/1**

⛔ **Rule `X3` governs:** *"A gap closes on **all** limbs, not a majority."* ⇒ `H-B` remains **OPEN**
with its **script bindings complete at 3/3** and its **concurrence outstanding**.

---

## 6. ⛔⛔ Architecture Owner concurrence — **OPEN**, and why it could not lawfully be obtained

### 6.1 The office, measured

| Measurement | Source | Result |
|---|---|---|
| Who is `PRD-015`'s Architecture Owner? | `PRD_OWNERSHIP_MODEL.md` **L197** | ⭐ **`ARB`** |
| Is the ARB the role or a body? | *ibid.* **L107** | *"Architecture Owner is the role; **ARB** is that role sitting as approving body"* |
| Is the ARB seated? | `ARB is (now )?(seated\|constituted\|filled)` over `docs/` | ⛔ **0 hits** |
| Does any concurrence artefact exist for `H-B`? | `concurrence\|concurs\|concurred` over `docs/`, excluding my own record | **11 hits — 0 for this act.** 3 are Supplement A **stating the absence**; the rest are `ADR-0091` (`PYK-SRC-001`), `ADR-0101` (Security Architect), `PRD-006` (Security Platform), `PRD-021A` (unrelated) |

### 6.2 ⭐ The `H-D` dependency, re-measured this pass

| Measurement | Result |
|---|---|
| `SRE` / `Observability` in `PRD_OWNERSHIP_MODEL.md` | ⛔ **0** — the office is **not constituted** |
| ADR `Deciders` rows naming SRE/Observability (all 89) | ⛔ **0** — closes `ADR-0080`'s self-constitution route |
| Seated ARB | ⛔ **0** — closes `ADR-0077`'s derivation route |
| `PRD_OWNERSHIP_MODEL.md` §12.1 (**L578-600**) | ⚠ A **mechanism** for one-act conferral, **not itself a conferral** |

⭐⭐ `ANALYSIS` — **The coupling is my own prior finding, and it holds.** The human decision record
**L4804-4806** records: *"`H-B` requires a seated-or-conferred Architecture Owner too — which is
`H-D`'s blocker. **`H-B` and `H-D` are therefore COUPLED.**"* ⇒ The concurrence limb cannot be
obtained while `H-D` is unresolved.

### 6.3 ⛔ Three things I did NOT do

| # | ⛔ Refused |
|---|---|
| 1 | ⛔ **Did not manufacture concurrence.** No ADR was opened; `ADR-0102` = **0 files** |
| 2 | ⛔ **Did not treat `SRCHAO-F5 = Option A` as standing concurrence.** It is `SCOPE: this act only` — `ADR-0033` §7.1: *"a conferral for one act is not a standing licence"* — and its own §11.2 states it *"does not supply a script value for any field"* |
| 3 | ⛔ **Did not read `ADR-0099` as self-concurring.** ⭐ Measured: `concur` appears **0 times** in `ADR-0099`. `C-3` is a **constraint on the configuration**; the concurrence *requirement* is `HD-1` §2.3's routing. An ADR cannot supply concurrence to an act performed after it |

---

## 7. Findings register — this supplement

| ID | Finding | Status |
|---|---|---|
| **`SRCHPO-17`** | The `H-B` per-field script binding: 3 `text` units → Latin + Devanagari | ✅ **ADOPTED** (PO limb) |
| **`SRCHPO-A9`** | ⭐⭐⭐ No authority imposes script cardinality-one; `SRCH-AC-018` shows what cardinality-one looks like here, and it exists only for **match roles**. The singular articles in `C-3`/`C-4`/`HD-2` are grammatical, not normative | ✅ **ACCEPTED** |
| **`SRCHPO-A10`** | ⭐⭐ `P2` **L691** already contemplated a *"mixed-script field value (a Hindi name containing a Latin acronym)"* and left it *"unaddressed by any authority"* — a Library Name, i.e. unit 1 of this binding | ✅ **ACCEPTED** |
| **`SRCHPO-A11`** | ⭐⭐⭐ A two-member binding requires a **rule-selection mechanism**, which is Architecture-Owned and remains **OPEN** at `ADR-0099` §2.3. `HD-3`'s per-rule conditional is the shape it must take | ⚠ **RAISED — routed, not resolved** |
| **`SRCHPO-X13`** | ⛔ *"The two-member binding is unlawful because `C-3` says 'an' script"* | ⛔ **REJECTED** — `SRCHPO-A9`: 0 cardinality authority; the article is grammatical |
| **`SRCHPO-X14`** | ⛔ *"Resolve the ambiguity by detecting script from the value at index/query time"* | ⛔ **REJECTED** — `C-3`, `C-9`, `SRCHPO-2`, `SRCHAO-F5 = Option A` all prohibit it |
| **`SRCHPO-X15`** | ⛔ *"Split each dual-script field into a Latin index and a Devanagari index"* | ⛔ **REJECTED** — parent §2.3: `SRCHPO-1` does not authorise *"a second index, a per-language index, or a per-script BC"* |
| **`SRCHPO-X16`** | ⛔ *"Record concurrence, since `ADR-0099` `C-3` already anticipates it"* | ⛔ **REJECTED** — `concur` = **0 hits** in `ADR-0099`; ARB unseated; `H-D` blocked |

**Tally: 1 adopted · 2 accepted findings · 1 raised · 4 rejected.**

---

## 8. Validation performed

| # | Check | Result |
|---|---|---|
| 1 | Carrier is the `HD-1` / `SRCHPO-A3` mechanism | ✅ **YES** — ⛔ 0 new mechanisms |
| 2 | Parent record unmodified | ✅ `76b469cc…38643bd6`, `cmp`-verified |
| 3 | Supplement A unmodified | ✅ `cmp`-verified byte-identical |
| 4 | Subject `PRD-015_SEARCH_INDEXING.md` unmodified | ✅ `fe3093e6…c2c4544` |
| 5 | Frozen §14A / §14B / `Library_PRD_v1.md` / `ARCHITECTURE_RULINGS.md` unmodified | ✅ 14/14 protected baseline **OK** |
| 6 | Values drawn from `SRCHPO-1`'s closed set | ✅ 2 of 2 members; ⛔ 0 non-members |
| 7 | Third language/script introduced | ⛔ **0** |
| 8 | Scripts assigned to non-`text` units | ⛔ **0 of 11** |
| 9 | `SRCHPO-*` ID collision check before minting | ✅ `17`, `A9`, `A10`, `A11`, `X13`–`X16` → **0 hits each** |
| 10 | Cardinality-one authority for script | ⛔ **0** — `SRCHPO-A9` |
| 11 | Concurrence artefacts for this act | ⛔ **0** — §6.1 |
| 12 | `H-D` blocker re-measured | ⛔ SRE office **0** · `Deciders` **0/89** · seated ARB **0** |
| 13 | ADRs created | ⛔ **0** — count remains **89**; `ADR-0102` = 0 files |
| 14 | Code / `IMPL-*` / freeze / baseline / rank | ⛔ **0** of each |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-09-05 | ⭐ Created. Records `SRCHPO-17` — the Product Owner's explicit `H-B` per-field script binding for the **3** `text`-role units fixed by `SRCHPO-16`: **Library Name**, **Business Address → City**, **Map Location → Locality**, each **Latin + Devanagari**. Records the adopted interpretation placing Hinglish/Romanized Hindi inside **Latin** as *query behaviour*, with ⛔ **no third canonical language, script or value created** — coherent with `SRCHPO-2`, `SRCHPO-3`, `SRCHPO-1`, `HD-16` and `ADR-0099` `C-8`/`C-9`. ⭐⭐⭐ **Tests the dual-script question BEFORE recording** and clears it on a measurement: `exactly one script\|single script\|one script per\|only one script` returns **0 relevant hits**, while `SRCH-AC-018` shows this repository states cardinality-one **expressly** and does so **only for match roles** ⇒ the singular articles in `ADR-0099` `C-3`/`C-4` and `HD-2` are **grammatical, not normative** (`SRCHPO-A9`). Records that `P2` **L691** already contemplated a *"mixed-script field value (a Hindi name containing a Latin acronym)"* — i.e. a Library Name — and left it *"unaddressed by any authority"* (`SRCHPO-A10`), and that Supplement A §4 **L175-176** expressly contemplated a binding *"in any combination"*. ⚠⚠ **Names the residual rather than closing it:** a two-member binding needs a **rule-selection mechanism**, which is Architecture-Owned and OPEN at `ADR-0099` §2.3, with `HD-3`'s per-rule conditional identified as the shape it must take (`SRCHPO-A11`). ⛔⛔ **Architecture Owner concurrence under `ADR-0099` `C-3` is OPEN and was NOT manufactured** — `PRD-015`'s Architecture Owner is the **ARB** (`PRD_OWNERSHIP_MODEL.md` **L197**), seated-ARB hits = **0**, concurrence artefacts for this act = **0**, and `H-B`/`H-D` are **COUPLED** per the human decision record **L4804-4806**; `H-D` re-measured **BLOCKED** (SRE office 0, `Deciders` 0/89, seated ARB 0). ⭐ Measured that `concur` appears **0 times in `ADR-0099`**, so `C-3` is a constraint on the configuration and cannot self-supply concurrence (`SRCHPO-X16`). **`H-B` gate: PO limb 8/8 · concurrence limb 0/1 ⇒ NOT CLOSED** under rule `X3` (*"A gap closes on all limbs, not a majority"*). ⛔ **0 scripts assigned to the other 11 units**; ⛔ `H-C`, `H-D`, `H-E` untouched; ⛔ 0 frozen bytes, 0 ADRs, 0 code, 0 `IMPL-*`, 0 freeze/baseline/rank. ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED.** |

### 9.1 ⭐ This record's own amendment rule

This record states what was decided **on the date it was decided**. If a later decision supersedes
it, the remedy is a **new record or a further supplement** — ⛔ **never a silent rewrite of these
answers**, on the identical ground the parent record states at its §14 and Supplement A restates at
its §8: *a decision record that changes its own answers cannot be distinguished from one that never
had them.*
