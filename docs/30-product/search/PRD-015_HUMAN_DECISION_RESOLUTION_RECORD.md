# PRD-015 — Consolidated Human Decision Resolution Record (`HD-1` … `HD-16`)

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record. It records rulings that were **supplied by the human principal**, and states precisely what each does and does **not** authorise |
| **Not** | ⛔ Not a PRD · not an ADR · not an approval · not an ARB ruling · not a freeze · not a baseline · not a rank · not an implementation specification |
| **Version** | v1.0 |
| **Date** | 2026-09-04 |
| **Form** | Follows [`PRD-015_PO_DECISION_RESOLUTION_RECORD.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD.md), which in turn follows [`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md) — the repository's established shape for recording a supplied answer without letting it read as an architecture approval |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) **v0.1 `DRAFT`**, registry **`PLANNED`** — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, **byte-unchanged by this record** |
| **Resolves** | The **sixteen** human decisions `HD-1` … `HD-16` opened by [`PRD-015_FINAL_BLOCKER_RESOLUTION.md`](./PRD-015_FINAL_BLOCKER_RESOLUTION.md) |
| **Authority exercised** | ⭐ **The human principal of this engagement**, by express ruling supplied in the instruction this record executes. The mechanism is `PRD_OWNERSHIP_MODEL.md` **§12.1** — *"filled for this act only by direct conferral from the human principal"* |
| **ADRs created** | **1** — [`ADR-0099`](../../00-governance/adr/ADR-0099-bc-23-analyzer-and-tokenizer-configuration-is-architecture-governed.md), required by **`HD-6`** and by nothing else. ⛔ `ADR-0088` / `ADR-0089` / `ADR-0090` remain **RESERVED and UNWRITTEN** |
| **`F-5`** | ⛔ **NOT REOPENED.** `SRCHAO-F5 = OPTION A` stands as recorded at [`PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md`](./PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md) §11 |
| **Values invented** | ⛔ **ZERO.** No analyzer, tokenizer, engine, vendor, normalization table, `ZWJ`/`ZWNJ` exception list, edit-distance number, minimum token length, prefix threshold, performance figure, rebuild duration, trigger threshold, vocabulary content, API, BC edge or `IMPL-*` identifier |
| **Stage 3** | ⚠ **CONDITIONAL / NOT CONFERRED** — six checks re-run, **6 of 6 PASS**, conferral nonetheless withheld (§13) |
| **Lifecycle** | ⛔ `PRD-015` remains **`DRAFT`**, **NOT FROZEN**, **NOT BASELINED**, **NOT RANKED**. ⛔ Stages 4–7 NOT entered |

> ### ⭐⭐⭐ The one distinction this record exists to hold
>
> The principal's instruction states it directly, and it governs every row below:
>
> > *"Do NOT pretend that a human choice supplies missing implementation details."*
> > *"Where such detail is required, record the decision and its remaining implementation/authority dependency."*
>
> **A ruling can settle a *model* without settling its *content*.** `HD-2` chooses script-aware
> normalization — that is a complete answer to *which model*. It supplies **no** normalization
> rule. `HD-4` chooses strip-with-exceptions — a complete answer to *which policy*. It supplies
> **no** exception list, and expressly forbids inventing one.
>
> ⭐ **Eleven of the sixteen rulings are of this shape.** Recording them as fully closed would be
> the single most damaging error available to this pass, because each would silently mint an
> implementation detail nobody decided. Every row therefore carries a **Remaining dependency**
> column, and it is empty in only five cases.

---

## 1. Integrity — measured before any write

| # | Check | Result |
|---|---|---|
| **I-1** | Subject sha256 | ✅ `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **MATCH** |
| **I-2** | `HEAD` at pass start | ✅ `acd1c58` |
| **I-3** | Working tree at pass start | ✅ **clean**, 0 modified files |
| **I-4** | Local `HEAD` vs `github/main` | ✅ ahead/behind **0 / 0** |
| **I-5** | Remote in use | ✅ `github` = `https://github.com/sittuazad05022000-spec/Liboora-.git`. ⚠ `origin` **does not exist** |
| **I-6** | Next lawful ADR number | ✅ `ADR-0099` — `0088`/`0089`/`0090` **RESERVED**, verified **0 files each by exact-filename loop, not a glob** |

---

## 2. `HD-1` — the `F-5` source · **the per-field script binding mechanism**

### 2.1 The ruling, recorded

> **Use the existing PO-style declaration record mechanism, following the established
> `SRCHPO-A3` precedent, as the authoritative artefact carrying the per-field script binding.
> Do NOT modify frozen §14A merely to add the script attribute.**

**Status:** ✅ **MECHANISM CLOSED** · ⚠ **CONTENT OPEN**

### 2.2 Why this ruling is lawful on the repository's own terms

⭐ It is not merely permitted; it is the **only** one of the eleven audited candidates that
survives every existing constraint at once:

| Constraint | How the ruling satisfies it |
|---|---|
| `AR-1` **L39-50** — §14A.5 fields are owned by **seven** contexts, four FROZEN, and *"Discovery **references, never duplicates**"* | A declaration record **references** the fields; it adds no attribute to any owning context |
| §14A **FROZEN 2026-08-03** | ⛔ Expressly not modified — the ruling says so in terms |
| `ADR-0094` — §14A **is** the V1 `BC-23` discovery contract, and is **declaratory**, editing nothing | A declaration record beside it is the same shape, not a competing contract |
| `SRCHPO-A3` — *"`SRCHPO-1` supplies §16 `N3`/`N4` with a declared script domain **for the first time**"* | ⭐ The precedent is exact: a PO-style record has **already** supplied script-domain authority to this very PRD's normalization rules without touching a frozen document |
| `SRCHPO-X8` — ⛔ *"`PRD-015` should be edited to record the decision"* **REJECTED** on five grounds | The mechanism is a separate record, not a subject edit |

### 2.3 ⛔ What the ruling does NOT supply — stated plainly

The **mechanism** is now settled. The **binding values are not**, and cannot be derived:

- `PRD-015_FINAL_BLOCKER_RESOLUTION.md` §2.2 measured **0 hits repository-wide** for
  `declared script`, `script code`, `ISO 15924`, `Deva`, `Latn`, `script field`, `language tag`,
  `BCP-47`, `locale field` or `per-field script`.
- §14A.5 was measured to be a **bare field-name list** — no types, no schema, no attributes. Its
  only two lexical `script` hits are the substring inside *"De**script**ion"*.
- ⛔ `SRCHAO-F5 = Option A` **forbids** deriving the script from content, so the absence cannot be
  filled by inference.

⭐ **Therefore: which artefact carries the binding is decided; what the binding says is not.**
⛔ **This record does not create the declaration record**, because doing so would require writing
a script value per field — the exact act Option A's ruling forbids: *"Script का actual value
invent मत करो."*

**Remaining dependency:** a **Product-Owner-style declaration act** that binds each §14A.5
discovery field to a script from `SRCHPO-1`'s closed set of two. **Owner:** Product Owner
(domain) with Architecture Owner concurrence per `ADR-0099` `C-3`.

---

## 3. `HD-2` — the normalization model

### 3.1 The ruling, recorded

> **SCRIPT-AWARE NORMALIZATION.** Normalization rules MUST be applied according to the
> authoritative declared script associated with the field.

**Status:** ✅ **MODEL CLOSED** · ⚠ **RULE CONTENT OPEN**

### 3.2 What it settles, and what follows immediately

| Consequence | Basis |
|---|---|
| ⭐ **`P2-D` is resolved.** The uniform model is rejected | The ruling |
| `SRCH-FR-024`'s *"where compatible with the field's **declared script** and language scope"* (**L416**) now has a governing model rather than a conditional clause with no decided referent | Subject **L416** |
| ⭐ It is **coherent with `SRCHAO-F5 = Option A`, not merely compatible.** Option A already required the analyzer to *consume an authoritative declared script*; a script-aware model is the only normalization model that can use it | `F-5` §11 |
| `HD-3` becomes answerable — it was expressly gated behind this ruling | `PRD-015_FINAL_BLOCKER_RESOLUTION.md` §3.2 |
| Bound as constraint **`C-4`** on any analyzer configuration | `ADR-0099` §2.2 |

### 3.3 ⚠ The dependency this ruling creates rather than removes

⭐⭐ **Stated honestly: script-aware normalization is a decision that cannot execute yet.** It
requires a per-field declared script, which `HD-1` routes to a record that does not yet exist
with values that do not yet exist (§2.3).

⛔ **That is not a defect in the ruling.** A model must be chosen before the artefact that feeds
it can be specified — choosing the model *is* what makes `HD-1`'s record specifiable. But it
means `P2-D` is **decided, not deliverable**, and collapsing those would be the error
`SRCHPO-A2` warns of.

**Remaining dependency:** `HD-1` content · the rule content for each script (`HD-3`, `HD-4`).

---

## 4. `HD-3` — Devanagari case folding (`N1`)

### 4.1 The ruling, recorded

> **SCRIPT-CONDITIONAL.** Latin case folding applies where relevant to Latin-script content.
> Do NOT apply a fictional/meaningless Latin case-folding operation to Devanagari.
> **Do not claim this means "no normalization" for Devanagari**; other explicitly authorized
> normalization rules remain applicable.

**Status:** ✅ **`N1` SCOPE CLOSED** · ⚠ **DEVANAGARI RULE SET OPEN**

### 4.2 ⭐ The second sentence is the operative one, and it is a guard against me

The ruling could have been read as *"Devanagari is not normalized."* It expressly forecloses
that reading. The distinction it draws is precise:

| ⭐ What is ruled | ⛔ What is NOT ruled |
|---|---|
| **`N1` (case folding) has no meaningful application to Devanagari** and MUST NOT be applied there as a fiction | That Devanagari receives **no** normalization |
| Case folding remains in force for Latin-script content | Which rules **do** apply to Devanagari, or what they say |

⚠ **Why the guard matters, measured.** The subject's `N1`–`N6` (**L418-425**) is a **set**.
`SRCH-BR-008` (**L427-429**) requires the rule set to be *"symmetric and total"*. If `N1` is
inapplicable to Devanagari and nothing else is stated, a reader could conclude the Devanagari
branch is empty — and an empty branch is still **total** in form while being **substantively
absent**. The ruling's second sentence blocks that inference explicitly.

### 4.3 ⛔ Unicode is expressly NOT treated as product authority

The prior pass refused to let Unicode's unicameral property decide `P2-B`, on the principal's
instruction *"Unicode behavior को अपने-आप product authority मत मानो."*

⭐ **That refusal is unchanged and is now vindicated rather than superseded.** The principal
ruled the *scope* question, and Unicode is an **input** to whatever later act specifies the
Devanagari rules — never itself the decision.

**Remaining dependency:** the **content** of the *"other explicitly authorized normalization
rules"* the ruling refers to, for Devanagari. **Routed to** `ADR-0099` §2.3, evidence-bound.
⛔ No table is written here.

---

## 5. `HD-4` — `ZWJ` / `ZWNJ`

### 5.1 The ruling, recorded

> **STRIP-WITH-EXCEPTIONS.** The explicit exception set and ordering MUST be documented from
> the applicable Unicode/product authority **before implementation**.
> **Do NOT invent the exception list in this pass.** Preserve index/query symmetry.

**Status:** ✅ **POLICY CLOSED** · ⛔ **EXCEPTION SET AND ORDERING OPEN — expressly**

### 5.2 What is settled

| Settled | Basis |
|---|---|
| The **direction**: strip by default | `N6` already sets it (subject **L418-425**); the ruling confirms it |
| **Exceptions exist** — a bare strip-all is rejected | The ruling |
| **Symmetry is mandatory** | Subject `SRCH-FR-023` (**L414**); bound as `ADR-0099` `C-1` |
| The exception set MUST be **documented before implementation** | The ruling; and `ADR-INDEX.md` Process step 1 |

### 5.3 ⭐ This limb was, and remains, independent of `HD-2`

`PRD-015_FINAL_BLOCKER_RESOLUTION.md` §3.3 established that `P2-C` does not depend on `P2-D`
and — importantly — that **`SRCH-BR-008` cannot arbitrate it**, because *both* candidate limbs
(strip-all and strip-with-exceptions) are symmetric and total. That finding is why a human
ruling was required, and it is why the ruling settles the policy without settling the set: the
set is an **evidence** question, not a symmetry question.

### 5.4 ⛔ The list is not written here, and the `N6`×`N4` ordering is not fixed here

Both are expressly deferred by the ruling itself. ⚠ **The ordering matters materially** — `N4`
and `N6` applied in different sequences can produce different tokens for the same input, which
would breach `SRCH-BR-008`'s symmetry if index and query ordered them differently. That risk is
**named and left open**, not resolved by preference.

**Remaining dependency:** the exception set **and** the `N6`×`N4` order, from the applicable
Unicode/product authority. **Routed to** `ADR-0099` §2.3.

---

## 6. `HD-5` — the counting unit

### 6.1 The ruling, recorded

> **GRAPHEME CLUSTER.** Use grapheme clusters as the counting unit for length-bearing search
> rules. **Document that this is a product/architecture decision, not a reuse of `SCFG-1`,
> `SCFG-6`, or unrelated storage limits.**

**Status:** ✅ **CLOSED**

### 6.2 ⭐ Recorded as a decision, with the provenance disclaimer the ruling requires

⭐⭐ **This is one of only five rulings in this record that closes completely**, and the
disclaimer is why it can:

| ⛔ NOT the basis | What it actually is | Where |
|---|---|---|
| `SCFG-1` — *"Length \| 3–30 characters"* | **Username** storage length, a different PRD | `Student_Identity_PRD_v1.md` **L354** |
| `SCFG-6` — *"Bio maximum length \| 300 characters"* | **Bio** storage length, same foreign PRD | *ibid.* **L1340** |
| `IT-3` — *"≥ 40 bits"* | **Invitation code** entropy | `ADR-0009` **L83** |
| Library-name length | A field constraint, not a counting unit | `Library_PRD_v1.md` |

⭐ **The distinction is substantive, not formal.** A *storage* limit answers *"how much may be
stored"*; a *counting unit* answers *"what counts as one"*. Reusing the former as the latter is
the category error the prior pass refused seven times — and the ruling now supplies the answer
from **authority** instead of from a neighbouring constant.

### 6.3 ⚠ What choosing this unit implies — disclosed, not decided

A grapheme cluster is the **linguistically correct** unit for Devanagari, where a conjunct
renders as one user-perceived character while spanning several code points. That is why the
choice is coherent with `HD-2` and `HD-3`.

⛔ **But it decides no length.** `HD-7`'s minimum token length and `HD-8`'s minimum prefix
length remain **OPEN** — the unit is now known, the magnitudes are not. Bound as `ADR-0099`
`C-5`.

**Remaining dependency:** ⛔ **None** for the unit itself.

---

## 7. `HD-6` — analyzer / tokenizer authority ⇒ **`ADR-0099`**

### 7.1 The ruling, recorded

> **NEW ARCHITECTURE DECISION RECORD.** The analyzer/tokenizer configuration must be explicitly
> governed by a new architecture decision record.
> **Do NOT select an engine or tokenizer merely because it is popular.**

**Status:** ✅ **AUTHORITY CLOSED** — executed as **`ADR-0099`** · ⛔ **CONFIGURATION OPEN**

### 7.2 What `ADR-0099` does

| It does | It does NOT |
|---|---|
| Fixes the **governance locus**: the configuration is an Architecture-Owner-governed artefact requiring an express act **before** implementation | ⛔ Name an analyzer, tokenizer, engine or vendor |
| States **ten constraints `C-1`…`C-10`**, each **derived** from existing authority | ⛔ Supply any folding table, exception list, threshold, budget or vocabulary |
| Gives `SRCHAO-F5 = Option A` its **consuming side** (`C-3`) | ⛔ Close `SRCH-GAP-002` — that gap is defined over all eight of `P1`…`P8` |
| **Distinguishes** `BC-25` rather than excluding it (§2.4) | ⛔ Create any `LCFG-*`; `PRD-023` is byte-unchanged |
| Is **declaratory in effect** — amends only `ADR-INDEX.md` | ⛔ Edit `PRD-015` (honouring `SRCHPO-X8`) |

### 7.3 ⭐ Why the office was never the gap

`PRD-015_PO_DECISION_RESOLUTION_RECORD.md` **L101** already reads *"Analyzer configuration │
**Architecture Owner** │ ⛔ NO"*. The office was assigned. What was missing was an **act** —
precisely the distinction `SRCHCL-X1` draws: *"an office is not an act… Having an owner is limb
C's precondition, not limb C."* `ADR-0099` is that act.

**Remaining dependency:** the configuration itself — a later Architecture Owner act under
`ADR-0099` §2.1/§2.2, which in turn needs `HD-1` content, `HD-3` content and `HD-4`'s set.

---

## 8. `HD-7` and `HD-8` — typo parameters and prefix length

### 8.1 The rulings, recorded

> **`HD-7` — DEFER.** Do not invent edit-distance or minimum-token-length numbers. Keep typo
> tolerance behavior as a requirement, but mark numeric parameters **OPEN** pending
> authoritative values.
>
> **`HD-8` — DEFER.** Do not convert `Lib → Library` or any example into a numeric threshold.
> Minimum prefix length remains **OPEN** pending authoritative value.

**Status:** ⚠ **DEFERRED — recorded explicitly as OPEN, by ruling**

### 8.2 ⭐ What is preserved by deferring

⚠ **Deferral is not silence.** Both rulings expressly **preserve the behavioural requirement**
while withholding the parameter:

| Preserved | Withheld |
|---|---|
| `SRCH-BR-012` (**L561**) — typo tolerance and prefix matching remain required behaviours | The edit-distance bound; the minimum token length; the minimum prefix length |
| `SRCH-FR-030` (**L518**) | — |
| §22.3 **T4** — *"irrelevant means excluded, not ranked last"* (**L601**) | — |
| Obligation **`T-I`** — *"a typo cannot cross a tenant boundary"* (§33) | — |

### 8.3 ⛔ `SRCH-AC-030`'s example is expressly not a threshold

⭐ The ruling names this trap directly, and the prior pass had already refused it: the
`Lib` → `Library` illustration at subject **L1103** is an **acceptance-criterion example**.
Reading `3` out of it would mint a threshold from a worked example — the same class of error as
reading a counting unit out of a storage limit (§6.2).

### 8.4 ⚠ Consequence for verification, disclosed

`T-I` and `SRCH-AC-024` cannot be **executed** as tests while `HD-7` is open: a test for
*"a typo cannot cross a tenant boundary"* requires a defined typo tolerance. ⭐ The obligations
remain **registered and named** — which is a materially better position than unowned — but they
are **not dischargeable yet**, and this record does not pretend otherwise.

**Remaining dependency:** authoritative numeric values. **Owner:** Architecture Owner via
`SRCH-GAP-002`.

---

## 9. `HD-9` — engine selection

### 9.1 The ruling, recorded

> **VENDOR-NEUTRAL ARCHITECTURE; ENGINE SELECTION IS A DEPLOYMENT DECISION.**
> Do not put a vendor/engine name into domain architecture. Record the architecture as
> vendor-neutral and leave actual deployment engine selection to the appropriate deployment
> authority.

**Status:** ✅ **ARCHITECTURE CLOSED — vendor-neutral** · ⚠ **DEPLOYMENT SELECTION SEPARATE**

### 9.2 ⭐ The ruling coincides with Rank 1, and that resolves a disclosed tension

The prior pass disclosed a tension it could not resolve: subject **§36** lists `P1` as an
**architecture** blocker, while Rank 1 `MP-CON-02` (`MASTER_PRD.md` **L238**) states that
*"choosing a BaaS for V1 is a **deployment decision, not an architecture decision**."*

⭐ **The ruling resolves it in the direction Rank 1 already pointed**, and does so without
overruling §36: `P1`'s **architecture** limb (vendor-neutrality, ports, abstract data layer) is
closed by `MP-CON-01` / `MP-CON-03` and now expressly confirmed; the **selection** limb is
re-characterised as a deployment act outside this PRD's authority.

⚠ **§36's `P1` row is NOT edited.** The subject is byte-unchanged, and a `DRAFT` PRD's blocker
table is not amended by a resolution record. A reader must read §36 **beside** this record —
the same instruction pattern `SECP-FR-018` / `ADR-0063` established.

### 9.3 ⛔ No vendor named

**0** engines, **0** vendors, **0** hosted services named anywhere in this record or in
`ADR-0099`. Bound as `ADR-0099` `C-6`.

**Remaining dependency:** deployment-authority selection, **outside** `PRD-015`'s scope.

---

## 10. `HD-10`, `HD-11`, `HD-13` — propagation budgets, NFR values, rebuild duration

### 10.1 The rulings, recorded

> **`HD-10` — NO ADDITIONAL PROPAGATION BUDGET BY DEFAULT.** `LCFG-6` = 60 s remains
> specifically removal latency. Do not invent additional event-class latency values. `SEV-9`
> remains without a normal propagation window where its existing authority says so.
>
> **`HD-11` — DEFER TO EA NFR BUDGETS.** Do not create latency/throughput/availability values
> inside `PRD-015`. `LIB-20.1` remains authoritative for routing these values.
>
> **`HD-13` — DEFER UNTIL `HD-11`.** No rebuild-duration number may be invented in `PRD-015`.
> The value must follow the `LIB-20.1` → EA NFR Budget route.

**Status:** `HD-10` ✅ **CLOSED — no additional budget** · `HD-11` ⚠ **DEFERRED to EA NFR** ·
`HD-13` ⚠ **DEFERRED, dependent on `HD-11`**

### 10.2 ⭐ `HD-10` preserves two measurements exactly

| Preserved | Source, verified this pass |
|---|---|
| `LCFG-6` = **60 s**, range 0–300 s, tier **Security**, *"**Removal latency only**"* | `CONFIGURATION_GUIDE.md` **L356**; corroborated by `Library_PRD_v1.md` **L721** — *"Applies **only** to Public→Private removal latency"* |
| `SEV-9` has **no propagation window** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L427** |

⭐ **`SEV-9`'s absence is BY DESIGN, not a gap** — a finding the prior pass established and this
ruling now confirms. §36's `P6` row carries the same parenthetical. ⛔ `P6` is therefore **not
expanded** to other freshness or rebuild semantics.

### 10.3 ⭐⭐ `HD-11` and `LIB-20.1` — the route is closed and the destination is empty

This is the pass's most consequential measurement, and the ruling ratifies it:

- **`LIB-20.1`** (`Library_PRD_v1.md` **L862**): *"Platform-wide NFR budgets **MUST** be taken
  from the Enterprise Architecture NFR Budgets document. This PRD **MUST NOT** state a
  competing latency or availability figure."*
- Its rationale (**L878-880**): *"avoids a documentation trap… **Referencing is the durable
  choice.**"*
- The routing target **exists** — `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L339-344** — but a
  targeted search for `p95|p99|99.9|ms|latency budget` returned **one hit: the heading itself**.
  ⭐ **ZERO numeric budgets.**

⭐⭐ **Consequence: the subject's L823 refusal is `LIB-20.1`-COMPLIANT, not merely cautious.**
*"No performance target is stated in this document, and that is a deliberate refusal"* is the
subject **obeying a rule**, which is a materially stronger position than exercising discretion.

### 10.4 ⭐ Why `HD-13` follows `HD-11` necessarily, not merely conveniently

A **rebuild duration is a latency figure.** `LIB-20.1` therefore routes it to the EA NFR
document. Stating a rebuild duration in `PRD-015` would **breach `LIB-20.1` directly** — not
merely lack authority. That is why `HD-13` cannot be answered before `HD-11`, and the ruling
sequences them exactly so.

⚠ Subject **L805** independently agrees: *"Rebuild **availability posture**… is an operational
decision recorded in `SRCH-GAP-002`. ⛔ **Not decided here.**"*

**Remaining dependency:** population of the **EA NFR Budgets** document. **Owner:** Architecture
Owner / Principal Enterprise Architect. ⛔ Not created here.

---

## 11. `HD-12` and `HD-14` — serve-stale and rebuild mode

### 11.1 `HD-12`, recorded

> **HYBRID / SECURITY-CONSTRAINED.** Stale data may only be considered where it does not violate
> source-system visibility or revocation security. **For revoked/private subjects, fail closed.**
> Do not allow stale serving to override `SEV-9`, `SRCH-FR-013`, or source-system authorization.

**Status:** ✅ **POSTURE CLOSED — hybrid, security-constrained** · ⚠ **OPERATIONAL RULE OPEN**

⭐ **The ruling adopts, as its governing constraint, exactly the security finding this pass
measured.** The prior pass found that `SEV-9`'s no-propagation-window (BC Map **L427**) plus
`SRCH-FR-013` **prohibit** serving stale data for a withdrawn privacy subject. That was recorded
as a *constraint* that could not by itself decide the general posture. ⭐ The ruling now decides
the general posture **and elevates that constraint into its limiting condition** — so the
security floor is not merely compatible with the posture, it defines it.

| ✅ Closed | ⚠ Still open |
|---|---|
| Fail-closed is **mandatory** for revoked/private subjects | The staleness **window** for the permitted case (a latency figure ⇒ `LIB-20.1` ⇒ `HD-11`) |
| Stale serving may **never** override `SEV-9`, `SRCH-FR-013` or source-system authorization | The **mechanism** by which a request is classified revoked-vs-permitted (⇒ `HD-15`) |
| Consistent with subject **L818-820**: *"Fail closed is not a preference; it is forced"* | — |

### 11.2 `HD-14`, recorded

> **BOTH FULL AND INCREMENTAL, WITH AN EXPLICIT SELECTION RULE.** The architecture supports both
> modes. The selection rule and operational trigger must be explicitly documented before
> implementation. **Do not invent trigger thresholds.**

**Status:** ✅ **MODE SET CLOSED — both** · ⛔ **SELECTION RULE AND TRIGGERS OPEN — expressly**

| ✅ Closed | ⛔ Still open |
|---|---|
| Both modes are architecturally supported | The **selection rule** |
| A selection rule is **mandatory** and must be documented **before implementation** | Every **trigger threshold** — expressly not invented |
| Preserves `SRCH-INV-005` (**L798**) and BC Map **L453** — *"tested quarterly, not assumed"* | The rebuild **duration** (⇒ `HD-13`) |
| Preserves obligation **`T-M`** — rebuild equivalence | — |

⚠ **`P8-A` remains CLOSED and is untouched.** Rebuildability, equivalence and the no-re-admission
rule (**L801-804**) are preserved byte-for-byte; supporting both modes does not weaken them,
because equivalence is required of **whichever** mode runs.

**Remaining dependency:** `HD-12` → staleness window (`HD-11`) and classification mechanism
(`HD-15`). `HD-14` → selection rule + triggers, and duration (`HD-13`).

---

## 12. `HD-15` and `HD-16` — entitlement mechanism and vocabulary

### 12.1 `HD-15`, recorded

> **SOURCE-SYSTEM AUTHORIZATION AT QUERY TIME.** `BC-23` MUST NOT own entitlement truth.
> Visibility MUST be evaluated against the authoritative source system at query time and for
> every query/page as required by §27. **Do NOT create a `BC-23` → `BC-18` edge unless a
> separate authoritative requirement actually requires it. Do not move authorization authority
> into `BC-23`.** The exact technical mechanism must be documented **without inventing an
> unsupported API**.

**Status:** ✅ **RULE AND MODEL CLOSED** · ⛔ **TECHNICAL MECHANISM OPEN — expressly**

⭐ **The ruling matches §27 verbatim in substance**, which is why it closes the rule limb
completely. §27 already holds:

- *"`BC-23` holds no source of truth. It follows that `BC-23` also holds no **entitlement**
  truth"*
- *"Who decides: the **source system's** authorisation, **at query time**"* — *"on **every**
  query, and on **every** page (§25)"*
- The governing rule: ***"Being indexed does NOT make data searchable by everyone. Search
  results MUST NEVER bypass source-system authorization."***
- **Nine** enforcing requirements already registered: `SRCH-FR-001`, `SRCH-FR-007`,
  `SRCH-INV-002`, `SRCH-INV-004`, `SRCH-FR-020`/`SRCH-XC-016`, `SRCH-FR-040`, `SRCH-FR-013`,
  `SRCH-FR-042`

### 12.2 ⛔ The boundary is preserved, and no edge is minted

| ⛔ Refusal | Ground |
|---|---|
| **No `BC-23` → `BC-18` edge** | `SRCHPO-X4` **REJECTED** it; BC Map **L292** — *"if an edge is not in this table, it does not exist"*; the ruling repeats the prohibition; and `ADR-0096` §1.2 refuses to rest a fact on an absence |
| **No authorization authority in `BC-23`** | `BC-18` remains the sole holder; §27; the ruling |
| **No API invented** | The ruling: *"without inventing an unsupported API"*. **0** endpoints, **0** payloads, **0** contracts written |
| `X-13` / `SE-1` / `MP-GBR-08` | Verified **in force and untouched** — BC Map **L500**, **L505**, **L936**; `MASTER_PRD.md` **L339** |

**Remaining dependency:** the **technical mechanism** — routed to `SRCH-GAP-003`, **Architecture
Owner alone** (subject **L981**).

### 12.3 `HD-16`, recorded

> **ENGLISH + HINDI vocabulary scope.** Preserve the V1 language inventory already established.
> **Hinglish/Romanized Hindi may be supported only where the existing product behavior is
> technically validated; do not create a third canonical language/index.** Do not invent
> vocabulary contents or a language-detection engine.

**Status:** ✅ **SCOPE CLOSED** · ⛔ **VOCABULARY CONTENT OPEN**

| ✅ Closed / preserved | ⛔ Still open |
|---|---|
| `SRCHPO-1`'s **closed set of two** — preserved exactly | The variant/abbreviation **vocabulary content** |
| ⛔ **No third canonical language or index** | — |
| ⛔ **No language-detection engine** — `SRCHPO-2` in force | — |
| Hinglish permitted **only where technically validated** — coherent with `SRCHPO-3`'s permissive *"where technically validated"* and with `SRCHPO-X6`'s refusal to infer a transliteration capability | Whether Hinglish is in fact validated — ⚠ presently **UNSUPPORTED** |
| Bound as `ADR-0099` `C-8` / `C-9` | — |

**Remaining dependency:** vocabulary content — `SRCH-GAP-007`, split owner.

---

## 13. Stage 3 — the six Architecture Alignment checks, re-run

### 13.1 Results

| # | Check | Result | Evidence |
|---|---|---|---|
| **1** | Ownership is **exclusive** — no context claims what it does not own | ✅ **PASS** | `AR-1` per-field table intact; ⭐ **`ADR-0099` §2.4 strengthens this** by distinguishing `BC-25` rather than absorbing its role; `SRCH-GAP-008` remains expressly **unowned and NOT claimed by `BC-23`** |
| **2** | **Required edges** exist and no unauthorized edge is added | ✅ **PASS** | `E-19` / `E-21` present; **0 edges added, removed or amended**; BC Map **byte-unchanged**; ⛔ `BC-23` → `BC-18` refused again under `HD-15` |
| **3** | **Rank direction** — a lower-rank document cites upward, never rewrites upward | ✅ **PASS** | `ADR-0099` is Rank 2 and amends **only** `ADR-INDEX.md`; **0** Rank 1–3 documents modified; `PRD-015` (`DRAFT`) is byte-unchanged |
| **4** | **Authorization lives only in `BC-18`** | ✅ **PASS** | ⭐ `HD-15` **reinforces** this: *"`BC-23` MUST NOT own entitlement truth"*; §27's nine requirements intact |
| **5** | **Credential / OTP / session** concerns live only in `BC-18` | ✅ **PASS** | Subject contains **0** such requirements; **0** added by this pass |
| **6** | **Tenant scoping** is preserved throughout | ✅ **PASS** | `MP-GBR-08`, `SE-1`, `X-13`, `AR-3`, BC Map **L490**/**L500** all in force; bound forward as `ADR-0099` `C-7` |

**6 of 6 PASS.**

### 13.2 ⛔ Verdict: **CONDITIONAL / NOT CONFERRED**

⭐⭐ **Passing all six checks does not confer Stage 3, and the instruction for this pass says so
directly: *"Do NOT automatically confer Stage 3."*** Two independent grounds:

**Ground 1 — authority.** ⛔⛔ `ADR-0033` **§7.1**: *"A conferral for one act is not a standing
licence."* This pass received **two** express conferrals: the sixteen `HD-*` rulings, and the
instruction to create `ADR-0099`. **Neither is a Stage-3 conferral.** `SRCHCL-X1` (**L425**) is
directly on point — *"an office is not an act"* — and `PRD_OWNERSHIP_MODEL.md` **L284** holds
*"**Only the Architecture Owner approves.**"*

**Ground 2 — substantive gaps.** Three registered gaps expressly block Stage 3 and remain open:

| Gap | State after this pass |
|---|---|
| **`SRCH-GAP-002`** (all of `P1`…`P8`, Architecture Owner) | ⚠ **OPEN.** `P2`'s **authority** limb closed by `ADR-0099`; ⛔ the configuration, `P3`, `P4`, `P7`, `P8-B/C/D` values remain unsupplied |
| **`SRCH-GAP-003`** (entitlement **mechanism**) | ⚠ **OPEN.** `HD-15` closed the **rule**; the mechanism is expressly deferred |
| **`SRCH-GAP-007`** (vocabulary, split owner) | ⚠ **OPEN.** `HD-16` closed the **scope**; content unsupplied |

### 13.3 ⭐ The distinction that must not be collapsed

**The six checks measure ARCHITECTURE ALIGNMENT. `SRCH-GAP-002` measures PARAMETER
COMPLETENESS.** They are different instruments over different objects. A subject can be
perfectly aligned and materially incomplete — which is exactly the present state. ⛔ Conferring
Stage 3 on a 6/6 alignment result would confer it **on the wrong evidence**.

---

## 14. Dependency graph after this pass

| Item | State | Note |
|---|---|---|
| `F-5` | ✅ **CLOSED** | Option A; ⛔ not reopened |
| `B1-a` (script domain) | ✅ **CLOSED** | `SRCHPO-1` + `SRCHPO-A3` |
| `B1-b` / `HD-1` (per-field binding) | ⚠ **MECHANISM CLOSED / CONTENT OPEN** | PO-style declaration record; values absent |
| `P2-D` / `HD-2` | ✅ **MODEL CLOSED** | script-aware; not yet deliverable |
| `P2-B` / `HD-3` | ✅ **SCOPE CLOSED / RULES OPEN** | script-conditional |
| `P2-C` / `HD-4` | ✅ **POLICY CLOSED / SET OPEN** | strip-with-exceptions |
| `P2U` / `HD-5` | ✅ **CLOSED** | grapheme cluster |
| `P2-A` / `HD-6` | ✅ **AUTHORITY CLOSED** (`ADR-0099`) **/ CONFIG OPEN** | 0 engines named |
| `P3` / `HD-7` | ⚠ **DEFERRED — OPEN** | behaviour preserved |
| `P4` / `HD-8` | ⚠ **DEFERRED — OPEN** | behaviour preserved |
| `P1` / `HD-9` | ✅ **ARCHITECTURE CLOSED** (vendor-neutral) **/ deployment separate** | |
| `P5` | ✅ **CLOSED** | `LCFG-12` = 20 |
| `P6` / `HD-10` | ✅ **CLOSED — no additional budget** | `LCFG-6` = 60 s removal only |
| `P7` / `HD-11` | ⚠ **DEFERRED to EA NFR** | route closed (`LIB-20.1`), values absent |
| `P8-A` | ✅ **CLOSED** | preserved |
| `P8-B` / `HD-12` | ✅ **POSTURE CLOSED / window+mechanism OPEN** | hybrid, security-constrained |
| `P8-C` / `HD-13` | ⚠ **DEFERRED — blocked by `HD-11`** | |
| `P8-D` / `HD-14` | ✅ **MODES CLOSED / rule+triggers OPEN** | both |
| `ENT` / `HD-15` | ✅ **RULE CLOSED / mechanism OPEN** | ⛔ no edge, no API |
| `VOC` / `HD-16` | ✅ **SCOPE CLOSED / content OPEN** | English + Hindi |
| `R1` | ⚠ **DOCUMENT-CLOSED / execution pending** | `T-I`, `T-J`; BC Map **L453** quarterly. ⛔ Blocked in execution by `HD-7` (§8.4) |
| `R2` | ⛔ **BLOCKED BY `ENT` MECHANISM** | `HD-15` closed the rule; R2 needs the mechanism |
| **Stage 3** | ⛔ **CONDITIONAL / NOT CONFERRED** | 6/6 PASS; §13.2 |

⚠ **`R1` — processed only as far as authority permits**, per the instruction *"R1 process only if
current authority permits."* Its residual is a **named, registered obligation** (`T-I`, `T-J`)
with a quarterly cadence — but ⛔ **no test is run here** and `HD-7`'s deferral means `T-I` is
not yet executable. It is **not** marked CLOSED.

---

## 15. Validation

| # | Check | Result |
|---|---|---|
| **V1** | Subject sha256 unchanged | ✅ `fe3093e6…c2c4544`, verified before and after |
| **V2** | Frozen PRDs byte-identical | ✅ `Library_PRD_v1.md` (incl. **§14A**), `PRD-023`, `PRD-013`, `PRD-017`, `PRD-002`, `Student_Identity_PRD_v1.md` — **0** in `git diff` |
| **V3** | Frozen ADRs byte-identical | ✅ **0** existing ADR files modified; `ADR-0099` is **new** |
| **V4** | Baselines unchanged | ✅ `DOCUMENTATION_BASELINE.md` **byte-unchanged**; `BASELINE-2026-09-03-A` stands. ⚠ Its §4 Rank 2 count becomes stale **72 → 73** — **disclosed and routed as a new `GCP-25` instance, NOT edited** (`ADR-0099` §5.1) |
| **V5** | Ownership model unchanged | ✅ `PRD_OWNERSHIP_MODEL.md` byte-unchanged |
| **V6** | No duplicate BCs | ✅ contexts stay **31**; ⛔ no `BC-32` |
| **V7** | No unauthorized edges | ✅ BC Map byte-unchanged; **0** edges touched; ⛔ `BC-23` → `BC-18` refused |
| **V8** | No unauthorized APIs | ✅ **0** APIs, endpoints, events or payloads defined |
| **V9** | No `IMPL-*` | ✅ **0** created |
| **V10** | No code | ✅ **0** lines under `lib/`, `test/`, `web/`, `android/`, `packages/`, `tool/` |
| **V11** | No fabricated values | ✅ **0** analyzers · **0** tokenizers · **0** engines/vendors · **0** normalization tables · **0** `ZWJ`/`ZWNJ` lists · **0** edit distances · **0** token lengths · **0** prefix thresholds · **0** performance figures · **0** rebuild durations · **0** trigger thresholds · **0** vocabularies |
| **V12** | Registry unchanged | ✅ `PRD_REGISTRY.md` byte-unchanged; **L315** still `PLANNED` |
| **V13** | `ARCHITECTURE_RULINGS.md`, `MASTER_PRD.md`, EA, `PRD_LIFECYCLE.md` | ✅ all byte-unchanged |
| **V14** | Reserved ADR numbers | ✅ `0088`/`0089`/`0090` = **0 files each**, exact-filename loop |
| **V15** | ADR counts re-derived, not incremented | ✅ pre **86/72/13/1/0/0** → post **87/73/13/1/0/0**; sums close; unparsed **EMPTY** |
| **V16** | Unregistered-file enumeration after insert | ✅ `[]` |
| **V17** | `ADR-INDEX.md` citation anchors intact | ✅ **L50**, **L75**, **L84**, **L121** re-read after the insert and all resolve correctly; **0** valid citations invalidated |
| **V18** | Every identifier cited pre-exists | ✅ verified individually |
| **V19** | No requirement identifier minted or amended | ✅ **0** `SRCH-*`, `LCFG-*`, `SCFG-*` created or changed |
| **V20** | `F-5` not reopened | ✅ `PRD-015_F5_CLASSIFICATION_DECISION_PACKET.md` byte-unchanged |
| **V21** | Stage 3 not auto-conferred | ✅ **CONDITIONAL / NOT CONFERRED**, §13.2 |
| **V22** | Stages 4–7 not entered; nothing frozen, baselined or ranked | ✅ |
| **V23** | ⚠ **`PRD-015` validator** | ⚠ **LIMITATION DISCLOSED: none exists.** `tool/docs_check/` holds **32** entries and **no `prd015_*` script**; the one adjacent validator, `alignment_record_freshness.py`, does **not** list `PRD-015` in its `RECORDS`. ⛔ **No validator was created** — the instruction forbids it. Validation here is by **direct measurement** (SHA, `git diff --name-only`, per-identifier greps, the mechanical ADR classifier) |

---

## 16. Findings register for this pass

| ID | Finding | Disposition |
|---|---|---|
| **`HDR-A1`** | Eleven of sixteen rulings settle a **model or policy** without settling its **content**; the record's `Remaining dependency` column exists to prevent them reading as complete | ✅ **ACCEPTED** — the record's governing structure |
| **`HDR-A2`** | ⭐ `HD-3`'s second sentence pre-empts the inference *"Devanagari therefore receives no normalization"* — an inference `SRCH-BR-008`'s form would not have caught, since an empty branch is still *total* | ✅ **ACCEPTED** — §4.2 |
| **`HDR-A3`** | ⭐ `HD-12` **elevates** the pass's own `SEV-9` + `SRCH-FR-013` security finding into the posture's limiting condition, rather than merely coexisting with it | ✅ **ACCEPTED** — §11.1 |
| **`HDR-A4`** | ⭐ `HD-9` resolves the disclosed §36-vs-`MP-CON-02` tension in Rank 1's direction, **without** editing §36 | ✅ **ACCEPTED** — §9.2 |
| **`HDR-A5`** | ⚠ `HD-7`'s deferral makes obligations `T-I` and `SRCH-AC-024` **registered but not executable** | ⚠ **RAISED** — §8.4; Architecture Owner via `SRCH-GAP-002` |
| **`HDR-A6`** | ⚠ `ADR-0099` renders `DOCUMENTATION_BASELINE.md` §4's Rank 2 count stale (**72 → 73**) — a **new instance of OPEN class `GCP-25`** | ⚠ **RAISED, routed, NOT repaired** — the integrity clause requires baselines unchanged; both values named for a later one-edit repair |
| **`HDR-X1`** | *"All sixteen decisions are supplied, therefore `SRCH-GAP-002` is closed."* | ⛔ **REJECTED** — the gap is defined over **eight parameters**; five remain unvalued. Governance ≠ parameter |
| **`HDR-X2`** | *"6 of 6 alignment checks PASS, therefore Stage 3 is conferrable."* | ⛔ **REJECTED** — §13.3: alignment and completeness are different instruments; and `ADR-0033` §7.1 |
| **`HDR-X3`** | *"`HD-2` chose script-aware, so `SRCH-FR-024` is now executable."* | ⛔ **REJECTED** — §3.3: it needs the `HD-1` per-field binding, measured at **0 hits** |
| **`HDR-X4`** | *"`HD-6` was ruled, so `ADR-0099` may name a tokenizer to be useful."* | ⛔ **REJECTED** — the ruling forbids selection by popularity; `ADR-0051` §2.4: a default is a determination by a document with no standing |
| **`HDR-X5`** | *"`HD-15` closed `ENT`, so `R2` unblocks."* | ⛔ **REJECTED** — `R2` needs the **mechanism**, expressly deferred; `SRCH-GAP-003` remains OPEN |
| **`HDR-X6`** | *"`HD-14` supports both modes, so `P8-A`'s equivalence rule needs restating."* | ⛔ **REJECTED** — equivalence binds **whichever** mode runs; `SRCH-INV-005` is untouched |
| **`HDR-X7`** | *"`HD-5` chose grapheme clusters, so a minimum length can now be stated."* | ⛔ **REJECTED** — §6.3: the unit is known, the magnitudes are not (`HD-7`, `HD-8`) |
| **`HDR-X8`** | *"`HD-1` names the mechanism, so this record should write the declaration record."* | ⛔ **REJECTED** — writing it requires a script value per field, which `SRCHAO-F5` Option A expressly forbids inventing |

**8 rejected with reasons · 4 accepted · 2 raised.**

---

## 17. Change log

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-04 | **Created.** Records the **sixteen** human decisions `HD-1`…`HD-16` supplied by the principal, as **ONE consolidated record** rather than sixteen files. ⭐⭐⭐ **The record's central discipline is the separation of MODEL from CONTENT**: eleven of the sixteen rulings settle a model, policy or scope while expressly supplying no implementation detail, and each carries a **`Remaining dependency`** entry so that none reads as complete. **`HD-1`** mechanism CLOSED on the `SRCHPO-A3` precedent, ⛔ frozen §14A untouched, ⛔ content still absent at **0 hits repository-wide**. **`HD-2`** script-aware — ⭐ shown **coherent with `SRCHAO-F5` Option A rather than merely compatible**, and ⚠ disclosed as *decided but not yet deliverable*. **`HD-3`** script-conditional — ⭐ its second sentence recorded as a **guard against the empty-branch inference** that `SRCH-BR-008`'s form would not catch; ⛔ Unicode still refused as product authority. **`HD-4`** strip-with-exceptions — ⛔ exception set and `N6`×`N4` ordering expressly NOT invented, with the ordering risk **named**. **`HD-5`** grapheme cluster — ✅ fully CLOSED, with the ruling's mandated disclaimer distinguishing it from `SCFG-1`, `SCFG-6`, `IT-3` and library-name length, and ⚠ the note that a unit is not a magnitude. **`HD-6`** executed as **`ADR-0099`** — ⭐ recording that *the office was never the gap* (`L101` had assigned it; what was missing was an **act**, per `SRCHCL-X1`), with **ten derived constraints `C-1`…`C-10`**, ⭐ `BC-25` **distinguished not excluded**, and ⛔ **0 analyzers/tokenizers/engines named**. **`HD-7`**/**`HD-8`** DEFERRED with behaviour preserved and ⛔ the `Lib`→`Library` example refused again; ⚠ the consequence that `T-I` and `SRCH-AC-024` become *registered but not executable* is disclosed. **`HD-9`** vendor-neutral — ⭐ resolving the disclosed §36-vs-`MP-CON-02` tension in Rank 1's direction **without editing §36**. **`HD-10`** no additional budget — ⭐ `SEV-9`'s absent window confirmed **BY DESIGN**. **`HD-11`** deferred to EA NFR — ⭐⭐ recording that `LIB-20.1`'s route is CLOSED while its destination holds **ZERO values**, which makes the subject's **L823** refusal **`LIB-20.1`-compliant rather than merely cautious**. **`HD-12`** hybrid/security-constrained — ⭐ the pass's own `SEV-9` + `SRCH-FR-013` finding **elevated into the posture's limiting condition**. **`HD-13`** deferred — ⭐ with the reasoning that a duration **is** a latency figure, so stating one would **breach `LIB-20.1` directly**, not merely lack authority. **`HD-14`** both modes — ⛔ selection rule and every trigger threshold expressly open; `P8-A` equivalence preserved untouched. **`HD-15`** source-system authorization at query time — ✅ rule limb CLOSED against §27's nine registered requirements, ⛔ **no `BC-23` → `BC-18` edge** (`SRCHPO-X4` stays rejected; BC Map **L292**), ⛔ **no API invented**, ⛔ no authorization authority moved into `BC-23`. **`HD-16`** English + Hindi — ⛔ no third canonical language or index, ⛔ no detection engine, ⛔ no vocabulary content. **`R1`** processed only as far as authority permits and ⛔ **not** marked CLOSED; **`R2`** remains BLOCKED on the `ENT` **mechanism**. ⭐⭐ **Stage 3 re-run: 6 of 6 checks PASS — yet CONDITIONAL / NOT CONFERRED** on two independent grounds, and §13.3 records the distinction that **the six checks measure ARCHITECTURE ALIGNMENT while `SRCH-GAP-002` measures PARAMETER COMPLETENESS**, so conferring on a 6/6 result would confer on the wrong evidence. ⚠ **`HDR-A6` discloses that `ADR-0099` makes `DOCUMENTATION_BASELINE.md` §4's Rank 2 count stale (72 → 73)** and routes it to the Governance Owner with both values named **rather than editing a baseline this pass was told to leave unchanged**. **8 candidate over-reads rejected with reasons** (`HDR-X1`…`X8`). ⛔ **Creates: 0 analyzers, 0 tokenizers, 0 engines, 0 vendors, 0 normalization tables, 0 ZWJ/ZWNJ lists, 0 edit distances, 0 token lengths, 0 prefix thresholds, 0 performance figures, 0 rebuild durations, 0 trigger thresholds, 0 vocabularies, 0 APIs, 0 BC edges, 0 BCs, 0 events, 0 owners, 0 personal names, 0 `IMPL-*`, 0 code, 0 requirement identifiers.** ⚠ **Limitation disclosed: no `PRD-015` validator exists in `tool/docs_check/`; ⛔ none was created.** ⛔ **Subject byte-unchanged; every frozen PRD/ADR/baseline byte-unchanged; registry L315 still `PLANNED`; Stages 4–7 NOT entered; `PRD-015` NOT frozen, NOT baselined, NOT ranked.** |

---

**END OF RECORD.** ⭐ Sixteen rulings are recorded faithfully. **Five close completely; eleven
close a model and name what still blocks it.** ⛔ Nothing was invented to make the count look
better.

---
---

# PART II — FINAL CLOSURE & STAGE-3 READINESS PASS (appended 2026-09-04)

| Field | Value |
|---|---|
| **Act** | 🔍 **ASSESSMENT, not conferral** |
| **Subject** | `PRD-015_SEARCH_INDEXING.md` — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, **byte-unchanged** |
| **Predecessor** | `ffee6f7` — HD-1…HD-16 recorded; `ADR-0099` accepted |
| **Form** | ⭐ **APPENDED to this consolidated record**, ⛔ not a new file. `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L504** forbids editing itself in place (*"⛔ This record must not be edited in place either"*), and `PRD-015_ARCHITECTURE_ALIGNMENT.md` §17 forbids editing its findings; so the lawful locus for a *new* assessment is a supplement, and the instruction's *"prefer updating the existing consolidated record"* selects **this** one |
| **Verdict** | ⚠ **B — STAGE 3 CONDITIONAL** |

## 18. The decisive measurement: the subject's own `Blocks` column

⭐⭐⭐ **This pass's central question — whether the remaining items *legally* block Stage 3 — is answered by the subject itself, not by inference.** §42's gap register (**L977**) carries a column literally headed **`Blocks`**, and it is populated per row:

| Gap | Owner (as registered) | Its own `Blocks` value | ⇒ Stage-3 blocking? |
|---|---|---|---|
| `SRCH-GAP-002` | **Architecture Owner** | **"Stage 3**; nothing in Stage 2" (**L980**) | ✅ **YES — by the subject's own declaration** |
| `SRCH-GAP-003` | **Architecture Owner** | **"Stage 3**; and any tenant-operational surface" (**L981**) | ✅ **YES** |
| `SRCH-GAP-007` | **Product Owner** (markets) **+ Architecture Owner** (analyzer) | **"Stage 3"** (**L985**) | ✅ **YES** |
| `SRCH-GAP-008` | ⛔ **"No owner exists"** | ⛔ **"Nothing in V1"** (**L986**) | ⛔ **NO** |

⭐⭐ **This is the finding that decides the pass, and it cuts BOTH ways — which is why it is stated before any verdict.**

- It **refutes** the flattering reading that the deferred items are "merely implementation detail" and therefore non-blocking. They are implementation *content*, but the subject has **classified them as Stage-3 blocking**, and `SRCHCL-X2`'s standing reason applies: ⛔ **a review may not downgrade its own subject's declared blockers.** Doing so would let a reviewer manufacture readiness by re-labelling.
- It **also refutes** the pessimistic reading that `SRCH-GAP-008` blocks Stage 3. Its own row says **"Nothing in V1"**. ⛔ It must **not** be counted against Stage 3.

⛔ **The instruction's own guard is therefore satisfied in both directions:** *"Do not treat implementation details as architecture blockers unless repository governance explicitly says they block Stage 3."* Here governance **does** say so, in a column built for exactly this purpose.

## 19. Re-audit of all remaining blockers

Classification per the instruction's six categories. **`Blocks S3?`** is taken from §42 / §45.1 where the subject speaks, never from analogy.

| ID | Exact remaining issue | Authoritative evidence exists? | Prior blocker actually resolved? | Category | **Blocks S3?** | Minimum remedy |
|---|---|---|---|---|---|---|
| **B1** | Per-field script binding has no carrier artefact | ⚠ Mechanism yes (HD-1, `SRCHPO-A3`); content **0 hits repo-wide** | ⚠ **Partly** — mechanism CLOSED, content not | **IMPLEMENTATION DETAIL** (content) + **GOVERNANCE** (carrier unwritten) | **YES** — feeds `SRCH-GAP-002`/`-007` | PO-style declaration record naming a script per §14A.5 field |
| **P2-B** | Devanagari's positively-authorized rules | ⛔ None | ✅ Scope CLOSED by HD-3 | **IMPLEMENTATION DETAIL** | **YES** — inside `SRCH-GAP-002` | Rule enumeration under `ADR-0099` |
| **P2-C** | ZWJ/ZWNJ exception set **and ordering** | ⛔ None | ✅ Policy CLOSED by HD-4 | **EXTERNAL AUTHORITY** (Unicode/product) | **YES** — inside `SRCH-GAP-002` | Cite the exception table from the authority; ⛔ do not draft it |
| **P2-A** | Analyzer/tokenizer configuration values | ✅ **Authority** now closed by `ADR-0099` | ✅ **Authority limb YES**; config no | **IMPLEMENTATION DETAIL** | **YES** — the largest part of `SRCH-GAP-002` | Architecture Owner issues the config under `ADR-0099` |
| **P3** | Edit distance, minimum token length | ⛔ None | ⚠ DEFERRED by HD-7 | **IMPLEMENTATION DETAIL** | **YES** — named in `SRCH-GAP-002` **L980** | Architecture Owner decision |
| **P4** | Prefix threshold | ⛔ None | ⚠ DEFERRED by HD-8 | **IMPLEMENTATION DETAIL** | **YES** — named in **L980** | Architecture Owner decision |
| **P7** | Latency / availability targets | ✅ **Route** closed (`LIB-20.1`); destination holds **ZERO** values | ✅ Route YES; values no | **EXTERNAL AUTHORITY** (EA NFR doc) | **YES** — named in **L980** | Author the EA NFR budgets; ⛔ never here |
| **P8-B** | Stale-serving window | ⛔ None | ✅ **Posture** CLOSED by HD-12 (fail closed) | **IMPLEMENTATION DETAIL** | **YES** — "rebuild posture", **L980** | Architecture Owner sets the window |
| **P8-C** | Rebuild duration | ⛔ None | ⚠ DEFERRED, blocked by HD-11 | **EXTERNAL AUTHORITY** | **YES** | Follows P7 |
| **P8-D** | Full/incremental selection rule | ⛔ None | ✅ **Modes** CLOSED by HD-14 | **IMPLEMENTATION DETAIL** | **YES** | Architecture Owner states the rule |
| **ENT** | Query-time entitlement **mechanism** | ⛔ None — ⭐ `SRCHCL-A3`: **no `BC-23`→`BC-18` edge and no `search:` module block exist** | ✅ **Rule** CLOSED by HD-15 | ⭐⭐ **ARCHITECTURE BLOCKER** — needs a **Rank-4 act**, not a value | ✅ **YES** — `SRCH-GAP-003` | A Rank-4 act (BC Map edge **or** an ADR establishing the mechanism) |
| **VOC** | Variant/abbreviation vocabulary contents | ⛔ None — `SRCHCL-X3`: `LCFG-2`'s range is literally *"Supported set"*, which **defers** it | ✅ **Scope** CLOSED by HD-16 (English+Hindi) | **IMPLEMENTATION DETAIL** + **EXTERNAL AUTHORITY** (PO markets) | **YES** — `SRCH-GAP-007` | PO declares markets; AO declares analyzer inventory |
| **R1** | Tenant-isolation / public-purity verification | ✅ Registered as `T-I`, `T-J` (§33); cadence BC Map **L453** | ✅ **Document limb CLOSED** | ⭐ **EXECUTION PENDING** | ⛔ **NO** — a test run is Stage 8, not Stage 3 | Execute `T-I`/`T-J`; ⛔ not a Stage-3 gate |
| **`SRCH-GAP-008`** | Anonymous-surface query-volume abuse | ⛔ **No owner exists**; `XPC-OD-010` OPEN | ⛔ Never resolved | ⭐⭐ **GOVERNANCE BLOCKER** | ⛔ **NO** — its own row says **"Nothing in V1"** | See §20 |
| **`SRCH-GAP-002`** | All eight implementation parameters as **one** item | ⚠ 2 of 8 decided (`LCFG-12`, `LCFG-6`) | ⛔ **NO** — `SRCHCL-X2` bars part-closure | **IMPLEMENTATION DETAIL**, Stage-3-classified | ✅ **YES** (**L980**) | Architecture Owner decisions on the 6 undecided |
| **`SRCH-GAP-003`** | Entitlement mechanism | ⛔ None | ⛔ **NO** | ⭐ **ARCHITECTURE BLOCKER** | ✅ **YES** (**L981**) | Rank-4 act |
| **`SRCH-GAP-007`** | Language/script + vocabulary inventory | ⚠ Scope only (HD-16) | ⛔ **NO** — `SRCHCL-X3` | **EXTERNAL AUTHORITY** + detail | ✅ **YES** (**L985**) | PO + AO declaration |

⚠ **`SRCH-GAP-009` is noted for completeness though outside the named list:** §14A declares no field-precedence order; its `Blocks` value is **"Nothing"** (**L987**) ⇒ **NON-BLOCKING**, owner **Product Owner**.

## 20. Fresh ownership audit of the four gaps

⛔ **No owner assigned by analogy. ⛔ No `BC-` created to give a gap an owner.**

| Gap | Lawful owner found? | Evidence | Disposition |
|---|---|---|---|
| `SRCH-GAP-002` | ✅ **YES — Architecture Owner** | Registered **L980**; corroborated by `PRD_OWNERSHIP_MODEL.md` **L197** (`PRD-015` → Architecture Owner = **ARB**) | Owner exists; the **decisions** do not. ⇒ not a governance blocker |
| `SRCH-GAP-003` | ✅ **YES — Architecture Owner** | **L981**; **L197** | Owner exists; needs a **Rank-4 act** |
| `SRCH-GAP-007` | ✅ **YES — Product Owner + Architecture Owner** | **L985**; **L197** | Owner exists; needs a declaration |
| `SRCH-GAP-008` | ⛔ **NO** | **L986** *"No owner exists"*; **L770** *"recorded, not assigned"*; `XPC-OD-010` **OPEN** | ⭐⭐ **GOVERNANCE BLOCKER — see the finding below** |

### 20.1 ⭐⭐ `SRCH-GAP-008` — a NEW measurement corrects the standing record

⚠⚠ **The subject records `SRCH-GAP-008` as unowned. That is now measurably out of date, and the correction is reported rather than applied to the frozen-by-convention subject.**

**`ADR-0098` L222** — a **baselined Rank-2 ADR** — carries the row:

> `XPC-OD-010` bot/scraping defence │ ⛔ **OPEN** — *"NOT resolved by C7"* │ **Architecture Owner**

⭐ **`XPC-OD-010` — the very decision `SRCH-GAP-008` names as its basis — HAS an owner: the Architecture Owner.** Therefore:

- The **decision** `SRCH-GAP-008` waits on is **owned**. What is absent is the **decision**, not the office.
- ⭐ This is the **same shape** as `SRCHCL-X1`/`HD-6`: *an office is not an act*, and conversely **the absence of an act is not the absence of an office**.
- ⛔ **`SRCHCL-X6` is NOT reopened**, and its refusal stands undisturbed: it rejected borrowing an owner from the *invitation* rate limits `ICFG-7`…`ICFG-10`, an **adjacent register**. This finding is different in kind — it reads the owner off `SRCH-GAP-008`'s **own cited basis** (`XPC-OD-010`), not off a neighbour.

**Minimum lawful remedy:** record in the subject's §42 that `SRCH-GAP-008`'s basis decision `XPC-OD-010` is Architecture-Owner-owned per `ADR-0098` **L222**. ⛔ **NOT DONE HERE** — that is an edit to the subject, whose SHA this pass is required to preserve. **Routed to the Architecture Owner, disclosed with both the stale value and the corrected one named**, on the `GCP-25` precedent (*repair only what your own pass caused*). This pass did not cause it.

⭐ **And it changes no verdict:** `SRCH-GAP-008` blocks **nothing in V1** either way. Its status moves from *"unowned governance blocker"* to *"owned, undecided, non-blocking for Stage 3"* — a **narrowing**, recorded because it is true, not because it helps.

## 21. Stage-3 six checks — re-run

| # | Check | Authority | Result | Evidence |
|---|---|---|---|---|
| 1 | Context ownership exclusive | BC Map §3 | ✅ **PASS** | `BC-23` sole owner; `AR-1` L39-50 *"references, never duplicates"*; ⛔ 0 duplicate BCs |
| 2 | Every integration edge exists in §7 | BC Map §7 | ✅ **PASS** | Consumes `E-21`; ⛔ **0 edges minted** by this or any prior pass |
| 3 | Rank direction downward | Matrix `L2` | ✅ **PASS** | Rank 1 `MP-CON-02` respected by HD-9; `ADR-0099` at Rank 2 amends only `ADR-INDEX.md` |
| 4 | No authorisation outside `BC-18` | `X-13` | ✅ **PASS** | HD-15 **strengthens** it: `BC-23` holds no entitlement truth; `SRCH-FR-040` (**L644**) re-evaluates per page |
| 5 | No credential / OTP / session outside `BC-18` | `ID-1` | ✅ **PASS** | Subject contains **0** such requirements |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** | `SRCH-INV-002` (**L286**), `SRCH-INV-004` (**L324**) — tenant data *"MUST NEVER enter"* the public index |

### ✅ **6 of 6 PASS** — and the four things that result does NOT mean

⭐⭐⭐ **The instruction's central demand is that these four not be conflated. They are held apart here explicitly:**

| Dimension | Instrument | Result |
|---|---|---|
| **Architecture alignment** | The six checks above | ✅ **6/6 PASS** |
| **Parameter completeness** | `SRCH-GAP-002`/`-003`/`-007`, self-classified *"Stage 3"* | ⛔ **FAIL — 3 gaps open** |
| **Implementation readiness** | §45.1 gates 1–8 | ⛔ **FAIL — 8 of 8 not done** |
| **Stage-3 governance conferral** | §12 limbs **A/B/C/D** | ⛔ **FAIL — A, B, C each fail independently** |

⛔ **A 6/6 alignment result is evidence for exactly one of these four rows.** Conferring on it would confer on the wrong evidence.

## 22. The formal closure test, re-applied

⭐ Re-applied against `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` §12 — **the authoritative four-limb test**, ⛔ not a test invented by this pass.

| Limb | Requirement | Prior (2026-09-03) | **Now** | What changed |
|---|---|---|---|---|
| **A** | Blocking gaps resolved **or** lifecycle-classified non-blocking | ⛔ FAIL | ⛔ **FAIL** | ⚠ **Unchanged.** `SRCH-GAP-002`/`-003`/`-007` still OPEN and still self-classified *"Stage 3"*. ⭐ 2 of 8 P-parameters had authority before; now **3 of 8** — `P2-A`'s **authority** limb closed by `ADR-0099` — but its **values** did not, and `SRCHCL-X2` bars part-closing a whole item |
| **B** | Required Architecture / Product Owner decisions present | ⛔ FAIL (**0**) | ⚠ **FAIL — but materially narrowed** | ⭐⭐ **This is the real movement of the last two passes.** Sixteen rulings were supplied and `ADR-0099` was accepted, so it is no longer true that **0** decisions exist. What remains missing is **content**, and B asks for the *decisions the gaps name* — parameter values, the entitlement mechanism, the analyzer inventory — which are still **0** |
| **C** | A legitimate Architecture reviewer / conferrer exists | ⛔ FAIL | ⛔ **FAIL** | ⚠ **Unchanged, and decisive.** The office exists (**L197**, `ARB`) but is **VACANT** under §7 rule 4, fillable *"for this act only by direct conferral from the human principal"* (§12.1). ⛔ **No conferral naming Stage 3 for `PRD-015` exists.** `SRCHAO-F5` was spent on the F-5 classification; the sixteen rulings conferred **content decisions, not a stage**. `ADR-0033` **§7.1**: *"a conferral for one act is not a standing licence"* |
| **D** | Therefore formally conferrable | ⛔ FAIL | ⛔ **FAIL** | Follows from A + B + C |

⚠ **Limb C would fail even if A and B both passed**, because it is a governance limb and no substantive work can discharge it. That single fact is what makes the verdict **B**, not **A**.

## 23. ⛔ VERDICT: **B — STAGE 3 CONDITIONAL**

**Architecture is aligned; genuine governance and authority blockers remain.**

⭐ **Why not A (READY):** three gaps the subject **itself** classifies as *"Stage 3"* are open (**L980**, **L981**, **L985**), and limb **C** has no conferral. ⛔ *"Do NOT confer Stage 3 merely because 6/6 checks pass."*

⭐ **Why not C (BLOCKED):** the instruction's test for C is *"a material architecture / ownership / security dependency remains unresolved."* Measured against that:

- **Architecture:** ✅ 6/6 PASS; ⛔ 0 unauthorized edges; ⛔ 0 duplicate contexts; vendor-neutrality settled at Rank 1 by HD-9.
- **Ownership:** ✅ every Stage-3-blocking gap **has a registered owner** (§20). ⛔ **No unowned Stage-3 blocker exists** — and `SRCH-GAP-008`, the one item that *was* recorded unowned, is **non-blocking for V1** and its basis decision is in fact **owned** (§20.1).
- **Security:** ✅ checks 4, 5, 6 PASS; HD-12's **fail-closed** posture and HD-15's *no entitlement truth in `BC-23`* both **tighten** rather than weaken it.

⚠ **The one item that comes closest to C is `SRCH-GAP-003`/ENT**, and it is reported as the pass's most serious finding: per `SRCHCL-A3` it needs a **Rank-4 act** — *no `BC-23`→`BC-18` edge and no `search:` module block exist*. It is nonetheless **owned** (Architecture Owner) and **structurally identified**, which is the difference between *conditional* and *blocked*: the mechanism is undecided, not un-ownable. ⛔ **This pass did not mint that edge to make the verdict look better.**

## 24. Architecture closure — what is now CLOSED

| Closed | Instrument |
|---|---|
| `F-5` script classification = **Option A** | `SRCHAO-F5` conferral (not reopened) |
| `P2-A` **authority** locus | ⭐ **`ADR-0099`** (Rank 2, Accepted) |
| `P1` **architecture** limb — vendor-neutral | HD-9 + Rank 1 `MP-CON-02` |
| `P2U` length unit = **grapheme cluster** | HD-5 — the only ruling closed outright |
| `P2-D` normalization **model** = script-aware | HD-2 |
| `P2-B` **scope** = script-conditional | HD-3 |
| `P2-C` **policy** = strip-with-exceptions | HD-4 |
| `P5` page-size cap = `LCFG-12` (**20**) | Rank 3, Security-owned |
| `P6` = `LCFG-6` (**60 s**), removal latency only | Rank 3; `SEV-9`'s absent window **by design** (BC Map **L427**) |
| `P7` **route** = `LIB-20.1` → EA NFR | `Library_PRD_v1.md` **L862** |
| `P8-A` rebuild equivalence | `SRCH-INV-005`, `T-M` |
| `P8-B` **posture** = fail closed | HD-12 |
| `P8-D` **modes** = full + incremental | HD-14 |
| `ENT` **rule** = source-system authz at query time | HD-15, §27's nine requirements |
| `VOC` **scope** = English + Hindi | HD-16 |
| `R1` **document** limb — obligations registered as `T-I`, `T-J` | §33 |
| Six Stage-3 alignment checks | ✅ **6/6 PASS** |

## 25. Deferred implementation details — and why they still block

⚠⚠ **This section deliberately contradicts the most attractive available conclusion, and the reason is evidentiary.**

The instruction rightly warns: *"do NOT keep a blocker artificially OPEN if the architecture itself is already lawfully decided and the missing detail belongs to a later implementation stage."* Applying that faithfully required testing whether the repository classifies these details as later-stage. **It does not.**

| Item | Belongs to implementation? | Yet blocks Stage 3, because |
|---|---|---|
| P2-A config, P2-B rules, P2-C exceptions, P3, P4, P8-B window, P8-D rule | ✅ Yes, all content | ⛔ **`SRCH-GAP-002`'s own `Blocks` cell reads "Stage 3"** (**L980**), and it registers them as **ONE item over eight parameters**. `SRCHCL-X2` refused part-closure precisely so that *"six undecided parameters"* are not reported as decided |
| ENT mechanism | ⚠ Partly — but needs a **Rank-4 act** | ⛔ **`SRCH-GAP-003`: "Stage 3"** (**L981**). An edge/mechanism is architecture, not a parameter |
| VOC contents | ✅ Yes | ⛔ **`SRCH-GAP-007`: "Stage 3"** (**L985**) |
| P7 / P8-C values | ✅ Yes — and owned **externally** | ⛔ Named inside `SRCH-GAP-002` **L980**. ⚠ Stating a number here would **breach `LIB-20.1`** |

**Genuinely NON-blocking, and not counted against Stage 3:**

| Item | Why it does not block |
|---|---|
| `SRCH-GAP-008` | Its own row: ⛔ **"Nothing in V1"** (**L986**) |
| `SRCH-GAP-009` | Its own row: ⛔ **"Nothing"** (**L987**) |
| `R1` execution (`T-I`, `T-J`) | ⭐ **EXECUTION PENDING** — running a test is Stage 8. Registered obligations satisfy Stage 3 |
| `SRCH-GAP-004`/`-005`/`-006` | All ⛔ **"Nothing in V1"** |

⭐ **The honest summary: the deferral is lawful, but it is not free.** The subject chose to register its parameters as a Stage-3 blocking item. A reviewer may not undo that choice; only the **Architecture Owner** can, by deciding the parameters or by re-classifying the gap.

## 26. Security + QA — final compact review

| Area | Status | Evidence |
|---|---|---|
| Tenant isolation | ✅ **PASS** | `SRCH-INV-002` **L286**; `SRCH-INV-004` **L324**; `MP-GBR-08` |
| `BC-18` authorization | ✅ **PASS** | `X-13` intact; HD-15 keeps entitlement truth out of `BC-23`; ⛔ 0 edges minted |
| Query/index symmetry | ⚠ **PARTIAL** | Rule mandatory (`SRCH-FR-023`, `SRCH-BR-008`); ⛔ the symmetric rule set is un-authored |
| Declared-script trust | ⚠ **PARTIAL** | Option A bars inference; ⛔ no carrier artefact exists (B1) |
| Normalization collision | ⛔ **BLOCKED** | ⚠ **Unowned collision risk carried forward, not silently dropped**; depends on P2-B/P2-C |
| Entitlement | ⛔ **BLOCKED** | `SRCH-GAP-003`; `SRCHCL-A3` — Rank-4 act absent |
| Stale serving | ⚠ **PARTIAL** | ✅ Fail-closed for revoked/private (HD-12; `SEV-9` + `SRCH-FR-013`); ⛔ window undecided |
| English/Hindi scope | ✅ **PASS** | HD-16; `SRCHPO-1`/`-2`; ⛔ no third index, no detection engine |
| ZWJ/ZWNJ | ⛔ **BLOCKED** | HD-4 policy closed; ⛔ exception set **and ordering** absent — ordering is itself a correctness risk |
| Typo / prefix behaviour | ⚠ **PARTIAL** | Requirements preserved (`SRCH-BR-012`, T4); ⛔ parameters deferred ⇒ `T-I`, `SRCH-AC-024` registered but not yet executable |
| Anonymous-surface abuse | ⛔ **NON-BLOCKING** | `SRCH-GAP-008` — *"Nothing in V1"*; basis decision **owned** per §20.1 |

**PASS 4 · PARTIAL 4 · BLOCKED 3 · NON-BLOCKING 1.** ⛔ No security item was upgraded to make the verdict cleaner.

## 27. Integrity

| Item | Result |
|---|---|
| Subject SHA256 | ✅ `fe3093e6…c2c4544` — **byte-unchanged** before and after |
| Protected files | ✅ Frozen PRDs, frozen ADRs, baselines, ownership model, registry — **byte-unchanged** |
| Unauthorized BC | ✅ **0** — contexts stay **31**; ⛔ no `BC-32` |
| Unauthorized edge | ✅ **0** — ⛔ `BC-23`→`BC-18` **NOT** minted, though it would have discharged `SRCH-GAP-003` |
| Unauthorized API | ✅ **0** |
| Invented values | ✅ **0** — 0 thresholds, 0 exception tables, 0 normalization rules, 0 analyzers, 0 tokenizers, 0 vendors, 0 NFR numbers, 0 durations, 0 vocabularies |
| Invented script behaviour | ✅ **0** — Option A honoured; ⛔ no script inferred or assigned |
| `IMPL-*` | ✅ **0** |
| Code | ✅ **0 lines** |
| Stage | ⛔ Stages 4–7 **NOT** entered · ⛔ **NOT** frozen, baselined or ranked · registry **L315** still `PLANNED` |
| ⚠ Routed #1 | `SRCH-GAP-008` ownership correction (§20.1) — **disclosed, not applied**; would require editing the subject |
| ⚠ Routed #2 | `DOCUMENTATION_BASELINE.md` §4 **L248** still reads *"72 accepted"* vs the register's **73**. ⛔ **NOT repaired** — a protected baseline, and §4 confers rank by identifier, never by count |
| ⚠ Routed #3 | `SRCHCL-C1`, `SRCHCL-C2` remain OPEN — ⛔ not repaired by this pass |
| ⚠ Disclosed | ⛔ No `prd015_*` validator exists in `tool/docs_check/`; ⛔ none created |

## 28. Findings registered by this pass

| ID | Finding | Class |
|---|---|---|
| **`SRCHFC-A1`** | ⭐⭐⭐ §42 carries a per-row **`Blocks`** column; the Stage-3 question is answered by the subject's own classification, not by reviewer inference | **ACCEPTED** |
| **`SRCHFC-A2`** | ⭐⭐ `SRCH-GAP-008`'s basis decision `XPC-OD-010` **is owned** (Architecture Owner, `ADR-0098` **L222**); the *"no owner exists"* record is out of date — **routed, not applied** | **ACCEPTED** |
| **`SRCHFC-A3`** | ⭐ Limb **B** is materially narrowed but not discharged: sixteen rulings + `ADR-0099` mean decisions are no longer **0**, yet the decisions the gaps *name* remain **0** | **ACCEPTED** |
| **`SRCHFC-A4`** | ⭐ Limb **C** would fail even if A and B passed — no substantive work can discharge a conferral limb | **ACCEPTED** |
| **`SRCHFC-A5`** | `R1` is **EXECUTION PENDING**, not a Stage-3 blocker: registered obligations `T-I`/`T-J` satisfy Stage 3; running them is Stage 8 | **ACCEPTED** |
| **`SRCHFC-X1`** | *Proposed:* Stage 3 is **READY**, because every open item is implementation detail that belongs to a later stage | ⛔ **REJECTED** — the subject's own `Blocks` cells read *"Stage 3"* for `SRCH-GAP-002`/`-003`/`-007`. `SRCHCL-X2`: a review may not downgrade its subject's declared blockers |
| **`SRCHFC-X2`** | *Proposed:* Stage 3 is **BLOCKED**, because normalization, entitlement and ZWJ/ZWNJ are BLOCKED in §26 | ⛔ **REJECTED** — every one is **owned** and the six checks PASS. *Blocked* requires an unresolved **ownership or architecture** dependency; undecided-but-owned content is **conditional** |
| **`SRCHFC-X3`** | *Proposed:* `ADR-0099` closes `SRCH-GAP-002`'s `P2-A`, so the gap can be part-closed | ⛔ **REJECTED** — `ADR-0099` closes the **authority**, expressly not the values, and `SRCHCL-X2` bars part-closing a one-item, eight-parameter gap |
| **`SRCHFC-X4`** | *Proposed:* mint the `BC-23`→`BC-18` edge to discharge `SRCH-GAP-003` and reach READY | ⛔ **REJECTED** — `SRCHPO-X4`, `SRCHCL-X4`, `X-13`, BC Map **L292**. ⛔ Inventing the remedy to obtain the verdict is the exact failure the instruction's *"do not invent a solution merely to make it ready"* forbids |
| **`SRCHFC-X5`** | *Proposed:* `SRCH-GAP-008` blocks Stage 3, since it is unowned and security-relevant | ⛔ **REJECTED** — its own row reads **"Nothing in V1"** (**L986**). Severity is not the same as gate scope |
| **`SRCHFC-X6`** | *Proposed:* the sixteen rulings amount to a Stage-3 conferral | ⛔ **REJECTED** — `ADR-0033` **§7.1**; `SRCHCL-X1`. Content decisions are not a stage conferral |

⭐ **Six of eleven findings are rejections, each with its reason**, per `PRD_LIFECYCLE.md` **L104-106**: *"A review that records only accepted findings is indistinguishable from a review that found nothing."*

## 29. Minimum lawful path to **A — STAGE 3 READY**

⛔ **Recorded as a route, not as work performed. This pass performs none of it.**

1. **Architecture Owner** decides the six undecided `SRCH-GAP-002` parameters (P2-A config, P2-B, P2-C, P3, P4, P8-B, P8-D) under **`ADR-0099`** — ⇒ limb **A** partly, limb **B** partly.
2. **A Rank-4 act** (BC Map edge **or** an ADR) establishes the query-time entitlement mechanism ⇒ `SRCH-GAP-003`.
3. **Product Owner** declares markets; **Architecture Owner** declares the analyzer/vocabulary inventory ⇒ `SRCH-GAP-007`.
4. **EA NFR budgets** authored, so P7/P8-C route lawfully to values ⇒ `LIB-20.1` satisfied.
5. **B1's** carrier artefact written, binding a declared script per §14A.5 field.
6. ⭐ **A one-act conferral from the human principal, naming Stage 3 for `PRD-015`** ⇒ limb **C**. ⚠ **Steps 1–5 cannot substitute for step 6, and step 6 cannot substitute for steps 1–5.**

---

**END OF PART II.** ⚠ **VERDICT: B — STAGE 3 CONDITIONAL.** ✅ **6 of 6 alignment checks PASS.**
⛔ **NOT CONFERRED** — limbs **A**, **B**, **C** each fail independently.
⛔ **`PRD-015` remains v0.1 `DRAFT`, registry `PLANNED`. NOT frozen · NOT baselined · NOT ranked · Stages 4–7 NOT entered.**
⛔ **Nothing was invented to make Stage 3 reachable.**

---
---

# PART III — CONSOLIDATED GOVERNANCE RESOLUTION PASS (appended 2026-09-04)

| Field | Value |
|---|---|
| **Act** | 🔍 **AUDIT + ROUTING, not conferral** |
| **Subject** | sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — **byte-unchanged** |
| **Predecessor** | `e337aff` — Part II verdict **B** |
| **Verdict** | ⚠ **B — STAGE 3 CONDITIONAL** (unchanged) — ⭐ but **one blocker's remedy is now precisely identified**, and **one prior structural finding is FALSIFIED** |
| **Reopened** | ⛔ **Nothing.** `F-5` Option A, `HD-1`…`HD-16`, `P2U`, `P5`, `P6`, `P8-A`, ENT policy and the English+Hindi scope are all carried forward untouched |

## 30. ⭐⭐⭐ TASK 1 — `SRCH-GAP-003`: the mechanism EXISTS as a port, and a prior finding is FALSIFIED

⚠⚠ **This pass's most significant measurement contradicts a finding this engagement previously accepted, and the correction is reported against my own prior record.**

`PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L32** (finding **`F-3`**) and **L161** state:

> *"BC Map §7 contains **no `BC-23` → `BC-18` edge**, and there is **no `search:` module block**"* … *"⛔ **There is no `search:` block**"*

⭐ **The first half is TRUE. The second half is FALSE, and it is falsified by direct measurement:**

| Question | Measured evidence | Result |
|---|---|---|
| Does a search module block exist? | **`tool/module_dependencies.yaml` L373** — `platform/search:` with `rank: 5`, `banned_imports`, and assertions **`SE-1`**, **`SE-2`** | ✅ **IT EXISTS** |
| Is `SEARCH → IAM` a permitted direction? | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L140** — `R5 SEARCH` × `IDENTITY & ACCESS` = **`◇`** (permitted port use); rank **5 → 4** satisfies `L2` | ✅ **PERMITTED** |
| Does an authorization port already exist for exactly this purpose? | **`identity.policy_decision`** — declared at manifest **L443**; consumed by **six** modules at Matrix **L193** (*"authorisation check"*), **L220** (⭐ *"ask BC-18, never evaluate or cache"*), **L248**, **L272**, **L290**, **L305** | ✅ **EXISTS, NAMED, IN USE** |
| Is `platform/search` among its declared consumers? | Manifest **L443**: `[domain/library, domain/social, platform/ai, platform/analytics, platform/workflow]` | ⛔ **ABSENT** |
| Is a `BC-23`→`BC-18` **edge** required? | ⛔ **NO** — `ADR-0033`; `ADR-0035` **L238**/**L427**; `PRD-008` **L878**: **14 of 17** `library_management` ports have **no** numbered edge. ⭐ **Ports are not edges** | ⛔ **NOT REQUIRED** |

⭐⭐ **The consequence is a genuine narrowing, and it is the most useful output of this pass:** `SRCH-GAP-003` does **not** need a new mechanism, a new port name, a new API, a new event, or a BC Map edge. **The mechanism already exists** (`identity.policy_decision`), the **direction is already lawful** (Matrix `◇`, 5→4), the **write side is already enforced** (`SE-2`: *"every index write carries a permission scope"*), and the **declaring block already exists** (L373). What is missing is a **two-line declaration** in the manifest.

### 30.1 The minimum lawful governance act

| Field | Determination |
|---|---|
| **Category** | **(c) another existing governance artifact** — ⛔ **not (a) a BC Map edge**, ⛔ **not (b) an ADR** |
| **The act** | Add `platform/identity:policy_decision` to `platform/search`'s ports, and add `platform/search` to `provides_ports.policy_decision.consumers`. ⭐ Precedent form: amendments **`A-2`** (`account_directory`) and **`A-3`** (`notification_address`) in the **same file** |
| **Constraint to carry** | ⭐ The `person_identity` discipline **verbatim** (Matrix **L220**): ***"ask `BC-18` per request; never evaluate or cache"*** — reinforced by `MP-GBR-26` and `X-13` |
| **Authority** | ⭐ **Architecture Owner.** ⚠ **Security Platform should be informed** — this is an authorization gap |
| **Status here** | ⛔ **DECISION REQUIRED — NOT PERFORMED** |

⛔⛔ **This pass did NOT make that amendment, and the reason is stated rather than glossed:** `tool/module_dependencies.yaml` is **build-enforcing** — a malformed edit breaks CI for **every** module — and your instruction authorises no artefact creation absent an explicit human decision. ⭐ **The remedy is identified with citations so the owner can act in one step; it is not executed.**

⛔ **`BC-23`→`BC-18` edge: NOT created.** Shape (1) is refused on BC Map **L292**/**L453** and on the measurement that **ports are not edges**. ⛔ `E-27` remains permanently vacant and is not reusable.

⚠ **Honest limitation:** the mechanism is *available*, not *declared*. Until the two lines exist, `BC-23` has **no declared query-time authorization path** while `SE-2` already binds its **write** path — an asymmetry that is itself the finding. ⇒ **`SRCH-GAP-003` remains OPEN and still blocks Stage 3** per §42 **L981**.

## 31. TASK 2 — `SRCH-GAP-002`: all eight P-parameters

| P | Parameter | Classification | Authority / exact missing input |
|---|---|---|---|
| **P1** | Engine / index technology | ⭐ **CLOSED (architecture) by explicit human decision** + **DEFERRED (selection)** | HD-9 = vendor-neutral; Rank 1 `MP-CON-02` — selection is a **deployment** decision. ⛔ Measured **0** hits for any engine name across `docs/` |
| **P2** | Analyzer / tokenizer configuration | ⚠ **Authority CLOSED (`ADR-0099`) · content OPEN HUMAN DECISION** | **Missing:** the configuration itself — token boundaries, per-script rule bindings. Owner **Architecture Owner** under `ADR-0099` §2.3 |
| **P3** | Edit-distance bound + min token length | ⚠ **DEFERRED by explicit human decision (HD-7)** | **Missing:** two numbers. ⛔ Measured **0** hits for `levenshtein|edit.distance|damerau|fuzziness`. Owner **Architecture Owner** |
| **P4** | Minimum prefix length | ⚠ **DEFERRED by explicit human decision (HD-8)** | **Missing:** one number. ⛔ `SRCH-AC-030`'s `Lib`→`Library` is an **example, not a threshold** |
| **P5** | Page-size cap | ✅ **CLOSED by repository authority** | `LCFG-12` = **20**, range 5–50, owner **Security** — `CONFIGURATION_GUIDE.md` **L362**; `14B` **L342**/**L374**. ⚠ Residual is **traceability** (`SRCHCL-C2`), not decision |
| **P6** | Removal latency | ✅ **CLOSED by repository authority — removal latency ONLY** | `LCFG-6` = **60 s**, range 0–300 s, owner **Security** — `CONFIGURATION_GUIDE.md` **L356**; `Library_PRD_v1.md` **L721**. ⛔ **Not** a general propagation budget; `SEV-9` has none **by design** (BC Map **L427**) |
| **P7** | Latency / throughput / availability | ⚠ **BLOCKED by another unresolved dependency** | Route **CLOSED** (`LIB-20.1`, `Library_PRD_v1.md` **L862**). **Missing:** the **EA NFR Budgets** values — EA **L339-344** measured to hold **ZERO** numbers. ⛔ Stating one here would **breach `LIB-20.1`** |
| **P8-A** | Rebuildability / correctness | ✅ **CLOSED by repository authority** | `SRCH-INV-005`; BC Map **L453** (*"tested quarterly, not assumed"*); obligation `T-M` |
| **P8-B** | Stale-serving window | ⚠ **Posture CLOSED (HD-12) · window OPEN HUMAN DECISION** | **Missing:** the window value. ⭐ Revoked/private **fail closed** — `SEV-9` + `SRCH-FR-013` are the limiting condition |
| **P8-C** | Rebuild duration | ⚠ **BLOCKED by P7 / HD-11** | ⭐ A duration **is** a latency figure ⇒ routed by `LIB-20.1` to the empty EA document |
| **P8-D** | Full + incremental selection rule | ⚠ **Modes CLOSED (HD-14) · rule OPEN HUMAN DECISION** | **Missing:** the selection rule and its triggers. ⛔ Not invented |

⭐ **Tally: 3 of 8 rows carry authoritative values or closed architecture** (P5, P6, P8-A) — **up from 2**, because `ADR-0099` closed P2's *authority* and HD-9 closed P1's *architecture*. ⛔ **`SRCH-GAP-002` is NOT closed**, and ⛔ **not part-closed**: `SRCHCL-X2` bars part-closing a gap registered as **one item over eight parameters**. ⇒ **still blocks Stage 3** per **L980**.

## 32. TASK 3 — `SRCH-GAP-007`: language, script, analyzer, vocabulary

| # | Item | Established by repository authority? | Owner | Exact missing input |
|---|---|---|---|---|
| 1 | Per-field **script declaration carrier** | ⛔ **NO** — mechanism only (HD-1) | Product Owner (declaration) | The artefact **and** a script value per §14A.5 field — see §33 |
| 2 | Analyzer / tokenizer **configuration** | ⛔ **NO** — authority only (`ADR-0099`) | **Architecture Owner** | The configuration; ⛔ 0 analyzer/tokenizer names exist repo-wide |
| 3 | Exact **Unicode normalization rules** | ⛔ **NO** | **Architecture Owner** + **external Unicode authority** | The rule set. ⭐ Repository policy requires citing an authoritative Unicode/product source **before** claiming exact behaviour; ⛔ none is cited anywhere |
| 4 | **ZWJ/ZWNJ** exception set **and order** | ⛔ **NO** — policy only (HD-4) | **External authority** (Unicode/product), applied by Architecture Owner | The exception list **and its ordering**. ⚠ Ordering is itself a correctness risk (`N6`×`N4`) |
| 5 | **Vocabulary contents** | ⛔ **NO** — scope only (HD-16) | **Product Owner** (markets) **+ Architecture Owner** (analyzer) | The variant/abbreviation entries |

**Language scope — ✅ CLOSED and preserved exactly:**

| Aspect | Recorded position | Evidence |
|---|---|---|
| V1 canonical set | **English (Latin) + Hindi (Devanagari)** — a **closed set of two** | `SRCHPO-1` (**L57**); HD-16 |
| Hinglish / Romanized Hindi | ⭐ **Supported *query behaviour* where technically validated — NOT a third canonical language** | `SRCHPO-2` (**L58**); `SRCHPO-3` (**L59**): *"where technically validated"* is **permissive, not required** |
| ⛔ Not authorised | ⛔ No third canonical language · ⛔ no third index · ⛔ no transliteration engine · ⛔ no language-detection engine | `SRCHPO-X6` ⛔ REJECTED; `SRCH-BR-011` |
| Normalization applicability | **Script-aware** (HD-2), **script-conditional** case folding (HD-3) | ⛔ No fictional Devanagari case folding; ⚠ HD-3's guard against the **empty-branch** inference preserved |
| `F-5` Option A | ✅ **PRESERVED** — script is **consumed, never inferred** | ⛔ Not reopened |

⛔ **`LCFG-2` does NOT close this.** Measured at `CONFIGURATION_GUIDE.md` **L352**: default `en`, range literally **"Supported set"** — which **defers** the very inventory `SRCH-GAP-007` requires, and is a **locale default**, not an analyzer/script inventory. ⭐ `SRCHCL-X3` already rejected this route and **stands**. ⇒ **still blocks Stage 3** per **L985**.

## 33. TASK 4 — B1: the per-field script carrier

| Question | Finding |
|---|---|
| Does a mechanism exist that can carry it **without** touching frozen §14A? | ✅ **YES — the PO-style declaration record**, on the **`SRCHPO-A3`** precedent: *"`SRCHPO-1` supplies §16 N3/N4 with a declared script domain **for the first time**"* (PO record **L112**) |
| Why it does not require a §14A edit | ⭐ `AR-1` (**L39-50**): *"Discovery **references, never duplicates**"*. A declaration record **binds** a script to a field name that §14A already declares; it does **not** add an attribute to §14A |
| Is frozen §14A modified? | ⛔ **NO.** `14A-Library-Discovery-And-Enrollment.md` **byte-unchanged**; its only lexical `script` hit remains the substring inside *"Description"* (measured: **1**) |
| **Required content** | For each §14A.5 field: the field name (as §14A declares it) **+** exactly one declared script from the closed set `{Latin, Devanagari}` **+** the declaring authority |
| Can this pass write it? | ⛔ **NO** — writing it requires **a script value per field**, which is a **Product Owner** product statement. ⭐ `F-5` **Option A** forbids inferring script, so inventing the bindings is doubly barred |
| **Smallest governance remedy** | ⭐ **Product Owner** issues the declaration record (mechanism already precedented; ⛔ no new instrument needed) |

**Status: ⚠ MECHANISM CLOSED · ⛔ CONTENT OPEN — DECISION REQUIRED (Product Owner).** It feeds `SRCH-GAP-007` and `SRCH-GAP-002`, so it **contributes to** the Stage-3 block without being a separately registered gap.

## 34. TASK 5 — `SRCH-GAP-008`: routing confirmed, non-blocking preserved

| Check | Result |
|---|---|
| Does `ADR-0098` assign `XPC-OD-010` to the Architecture Owner? | ✅ **CONFIRMED** — `ADR-0098` **L222**: *"`XPC-OD-010` bot/scraping defence │ ⛔ **OPEN** — "NOT resolved by C7" │ **Architecture Owner**"* |
| Is `XPC-OD-010` itself closed? | ⛔ **NO** — `ADR-0098` **L13** admits it **OPEN**, one of six not closed by that baseline |
| Status of `SRCH-GAP-008` | ⭐ **OWNED / ROUTED — DECISION PENDING.** The *office* exists; the *decision* does not |
| ⛔ Forced closure? | ⛔ **NO.** Ownership is not a decision — the same discipline as `SRCHCL-X1` (*an office is not an act*) |
| **Does it block Stage 3?** | ⛔ **NO — EXPLICITLY PRESERVED.** §42 **L986**: `Blocks` = ⛔ *"Nothing in V1"*; §30 **L770**: *"recorded, not assigned"* |
| Subject text | ⚠ Still reads *"No owner exists"* — ⛔ **NOT edited** (subject SHA must hold). **Routed** to the Architecture Owner with both values named, on the `GCP-25` precedent |

⛔ **`SRCHCL-X6` is not reopened** — it refused borrowing an owner from the *invitation* rate limits (`ICFG-7`…`ICFG-10`), an adjacent register. This reads the owner off the gap's **own cited basis**.

## 35. TASK 6 — Stage-3 readiness, recomputed on four separate axes

### A. Architecture alignment — the six checks

| # | Check | Result | Evidence |
|---|---|---|---|
| 1 | Ownership exclusive | ✅ **PASS** | `BC-23` sole owner (BC Map **L132**); `AR-1` |
| 2 | Required edges present | ✅ **PASS** | `E-21` (**L330**) and `E-26` (**L335**) both inbound and declared; ⭐ the entitlement dependency is a **port**, and ports need no edge (`ADR-0033`); ⛔ **0 edges minted** |
| 3 | Rank direction | ✅ **PASS** | ⭐ `SEARCH` rank **5 → 4** `IAM` satisfies Matrix `L2`; Rank 1 `MP-CON-02` respected by HD-9 |
| 4 | Authorization only in `BC-18` | ✅ **PASS** | `X-13`; `identity.policy_decision` is **`BC-18`'s** port; HD-15 keeps entitlement truth out of `BC-23`; subject defines **0** permissions and **0** roles |
| 5 | Credential / OTP / session only `BC-18` | ✅ **PASS** | `ID-1`; subject holds **0** such requirements |
| 6 | Tenant scoping | ✅ **PASS** | `SRCH-INV-002` (**L286**), `SRCH-INV-004` (**L324**); ⭐ **`SE-1`** — *"every index name is tenant-prefixed"* — is **machine-enforced** at manifest **L379** |

### ✅ **6 of 6 PASS** — and the other three axes, held strictly apart

| Axis | Instrument | Result |
|---|---|---|
| **B. Parameter completeness** | `SRCH-GAP-002`/`-003`/`-007`, `Blocks` = *"Stage 3"* | ⛔ **FAIL — 3 gaps open** |
| **C. Implementation readiness** | §45.1 gates 1–8 | ⛔ **FAIL — 0 of 8 done** |
| **D. Governance conferral readiness** | Closure-test limbs **A/B/C/D** | ⛔ **FAIL — A, B, C fail independently** |

## 36. ⛔ FINAL VERDICT: **B — STAGE 3 CONDITIONAL / NOT CONFERRED**

⭐ **Unchanged from Part II — and unchanged *despite* this pass producing genuinely favourable evidence.** The `platform/search` discovery makes `SRCH-GAP-003` far cheaper to close than any prior record believed, but **cheap to close is not closed**:

| Why not **A (READY)** | Why not **C (BLOCKED)** |
|---|---|
| `SRCH-GAP-002`/`-003`/`-007` are open and **the subject itself** classifies each as blocking Stage 3 (**L980**, **L981**, **L985**). ⛔ A review may not downgrade its subject's declared blockers (`SRCHCL-X2`). Limb **C** additionally has **no conferral**: the office is `ARB` (**L197**) but **VACANT** under §7 rule 4, fillable *"for this act only"* (§12.1); `ADR-0033` §7.1 bars inheriting `SRCHAO-F5` | Every Stage-3 blocker **has a registered owner**; 6/6 alignment PASS; ⭐ **`SRCH-GAP-003`'s mechanism now proven to EXIST**, needing a two-line declaration rather than new architecture; security posture **tightened** by HD-12 and HD-15; ⛔ 0 unowned Stage-3 blockers |

⛔ **The verdict was not improved to reflect the good news, and it was not withheld to look rigorous.** It follows from the §42 `Blocks` column and the conferral limb.

## 37. Readiness statement for a future one-act conferral

⛔ **NOT READY — and therefore no readiness statement is issued.** Your instruction conditions it on *"if and ONLY IF all repository-defined Stage-3 blockers are genuinely closed"*; three are open. The **precise sequence** to reach READY:

| # | Act | Authority | Closes |
|---|---|---|---|
| 1 | Two-line manifest declaration (§30.1) — ⭐ **the single highest-value act available** | **Architecture Owner** (inform Security) | `SRCH-GAP-003` |
| 2 | Decide P2 config, P3, P4, P8-B window, P8-D rule under `ADR-0099` | **Architecture Owner** | most of `SRCH-GAP-002` |
| 3 | Author **EA NFR Budgets** values | EA NFR document owner | P7, P8-C |
| 4 | Cite the authoritative Unicode/product source for normalization + ZWJ/ZWNJ | **External authority** → Architecture Owner | `SRCH-GAP-007` (3, 4) |
| 5 | Issue the per-field script declaration record; declare markets + vocabulary | **Product Owner** | B1, `SRCH-GAP-007` (1, 5) |
| 6 | ⭐ **A one-act conferral from the human principal naming Stage 3 for `PRD-015`** | **Human principal** | limb **C** |

⚠ **Steps 1–5 cannot substitute for step 6, and step 6 cannot substitute for steps 1–5.**

## 38. Findings registered by this pass

| ID | Finding | Class |
|---|---|---|
| **`SRCHGR-A1`** | ⭐⭐⭐ **`platform/search` module block EXISTS** (manifest **L373**) with assertions `SE-1`/`SE-2`. `SRCHCL-A3`/`F-3`'s *"there is no `search:` module block"* is **FALSIFIED** | **ACCEPTED — corrects a prior record** |
| **`SRCHGR-A2`** | ⭐⭐ `SRCH-GAP-003` needs **no new mechanism**: `identity.policy_decision` exists (**L443**), is used by six modules, and `SEARCH→IAM` is `◇` at 5→4. The gap is a **two-line declaration**, not missing architecture | **ACCEPTED** |
| **`SRCHGR-A3`** | ⭐ **No BC Map edge and no ADR are required** for the entitlement path — ports are not edges (`ADR-0033`; 14 of 17 `library_management` ports lack one). Remedy category = **(c)** | **ACCEPTED** |
| **`SRCHGR-A4`** | ⚠ **Asymmetry named:** `SE-2` already binds `BC-23`'s **write** path to a permission scope while its **query** path has no declared authorization port | **ACCEPTED — security finding** |
| **`SRCHGR-A5`** | `SRCH-GAP-008` is **OWNED/ROUTED, decision pending** (`ADR-0098` **L222**), and remains ⛔ **non-blocking** | **ACCEPTED** |
| **`SRCHGR-A6`** | P-parameter tally rises **2 → 3 of 8** (P1 architecture, P2 authority added); ⛔ the gap still does not part-close | **ACCEPTED** |
| **`SRCHGR-X1`** | *Proposed:* since the port exists and the direction is lawful, `SRCH-GAP-003` is **effectively closed** ⇒ Stage 3 READY | ⛔ **REJECTED** — `platform/search` is **absent** from `policy_decision.consumers` (**L443**). *Available* is not *declared*; `PRD-023` **L963**/**L164** treat non-declaration as **forbidden by omission**, so the undeclared call would be unlawful, not merely undocumented |
| **`SRCHGR-X2`** | *Proposed:* make the two-line manifest amendment now, since it is small and precedented | ⛔ **REJECTED** — an **Architecture Owner** act on a **build-enforcing** file; your instruction bars artefact creation absent an explicit authorized decision. ⭐ Identified, cited, **not executed** |
| **`SRCHGR-X3`** | *Proposed:* Hinglish support implies a transliteration or detection capability may be specified | ⛔ **REJECTED** — `SRCHPO-2`/`-3`: *"where technically validated"* is permissive; `SRCHPO-X6` already rejected this; `SRCH-BR-011` forbids it |
| **`SRCHGR-X4`** | *Proposed:* `LCFG-2` closes the language inventory limb of `SRCH-GAP-007` | ⛔ **REJECTED** — its range is literally *"Supported set"*, which **defers** the set; and it is a locale default, not a script/analyzer inventory (`SRCHCL-X3` stands) |
| **`SRCHGR-X5`** | *Proposed:* `E-26` (`BC-27 AI → BC-23`, *"permission-aware ports only"*) already supplies the query-time entitlement mechanism | ⛔ **REJECTED** — `E-26` is **inbound to** `BC-23` and serves **`BC-27`'s** retrieval; it neither states how `BC-23` evaluates a **source system's** decision nor names `BC-18`. ⭐ An adjacent permission-aware port is not this mechanism |
| **`SRCHGR-X6`** | *Proposed:* write the per-field script declaration record now, since HD-1 named the mechanism | ⛔ **REJECTED** — it requires a script **value per field**, a Product Owner statement; `F-5` Option A forbids inferring it |

⭐ **Six of twelve are rejections, each with its reason** — `PRD_LIFECYCLE.md` **L104-106**.

## 39. Integrity

| Item | Result |
|---|---|
| Subject SHA256 | ✅ `fe3093e6…c2c4544` **byte-unchanged** |
| Frozen PRDs / ADRs / baselines / registries / ownership model | ✅ **byte-unchanged** |
| `tool/module_dependencies.yaml` | ✅ **byte-unchanged** — ⛔ the identified two-line amendment **NOT applied** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · BC Map | ✅ **byte-unchanged** |
| New BC | ✅ **0** — contexts stay **31** |
| New edge | ✅ **0** — ⛔ `BC-23`→`BC-18` **not** created, though it would have "helped" |
| New API / port / event | ✅ **0** — ⭐ the entitlement path reuses an **existing** port name |
| Invented values / Unicode rules / vendors / NFR numbers / thresholds / vocabulary | ✅ **0** |
| Invented script behaviour | ✅ **0** — `F-5` Option A honoured |
| `IMPL-*` / code | ✅ **0 / 0 lines** |
| Lifecycle | ⛔ v0.1 `DRAFT`, registry `PLANNED`; ⛔ Stages 4–7 not entered; ⛔ not frozen/baselined/ranked |
| ⚠ Routed, not repaired | `SRCH-GAP-008` owner text in the subject · `SRCHCL-A3`/`F-3` falsification (both prior records carry **no-in-place-edit** rules) · `DOCUMENTATION_BASELINE.md` **L248** *"72 accepted"* vs **73** · `SRCHCL-C1`, `SRCHCL-C2` |
| ⚠ Disclosed | ⛔ No `prd015_*` validator in `tool/docs_check/`; ⛔ none created |

---

**END OF PART III.** ⚠ **VERDICT: B — STAGE 3 CONDITIONAL / NOT CONFERRED.** ✅ **6/6 alignment PASS.**
⭐ **`SRCH-GAP-003`'s remedy is now precisely identified as a two-line manifest declaration — ⛔ and deliberately NOT performed.**
⛔ **Architecture Owner one-act conferral: NOT READY.**
⛔ **Nothing reopened · nothing invented · no frozen artefact touched.**

---
---

# PART IV — GOVERNANCE BLOCKER RESOLUTION PASS · `SRCH-GAP-003` ENACTED

| Field | Value |
|---|---|
| **Act** | ⚙ **ENACTMENT (one authorized manifest declaration) + AUDIT + ROUTING** — ⛔ **NOT a conferral** |
| **Predecessor commit** | `97d94a3` (Part III) |
| **Authorization for the write** | ⭐ Direct human instruction of this pass, §2: *"This is an authorized resolution for `SRCH-GAP-003`"*, naming the mechanism, the file and the constraints |
| **Verdict** | ⚠ **B — CONDITIONAL / NOT CONFERRED** (unchanged) |
| **Reopened** | ⛔ **Nothing** |

⭐⭐ **This is the first pass in this engagement to change a non-documentation file.** Part III §30.1 identified
the remedy and refused to perform it for want of authority. That authority was then given explicitly. ⛔ Nothing
else in the manifest was touched, and no second remedy was smuggled in alongside the authorized one.

---

## 40. `SRCH-GAP-003` — ENACTED · ✅ **CLOSED**

### 40.1 What was written

⭐ **The declaration is TWO-SIDED.** Part III recorded it as *"a two-line declaration"* on the provider side.
Direct measurement this pass corrected that: `platform/search` had **no `ports:` block at all**, so a
provider-side entry alone would have produced a **one-sided** declaration unlike every other consumer of this
port. Both sides were therefore required.

| # | Side | Path | Anchor | Content |
|---|---|---|---|---|
| 1 | **Consumer** | `tool/module_dependencies.yaml` | `platform/search:` block (was **L373**) | New `ports:` key declaring `platform/identity:policy_decision`, in the key position (`rank` → `imports` → `ports`) used by `platform/ai`, `platform/analytics` and `platform/workflow` |
| 2 | **Provider** | *ibid.* | `platform/identity.provides_ports.policy_decision` (was **L443**) | `platform/search` **appended** to the existing consumer list; a `constraint:` line added in the `A-2`/`A-3` form |

**Consumer-side comment carries the Matrix rule verbatim** (`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **L220**):
*"ask BC-18 per request; never evaluate locally; never cache (`MP-GBR-26`)"* — the identical trailing-comment
form already used at **L186** (`domain/person`).

**Provider-side `constraint:`** reads *"ask BC-18 per request; never evaluate locally; never cache entitlement
truth"* — the same key the file already uses for `account_directory` (`A-2`) and `notification_address` (`A-3`).

### 40.2 Why this is the smallest lawful mechanism

| Test | Result | Authority |
|---|---|---|
| Is a `BC-23`→`BC-18` **edge** required? | ⛔ **NO — and none was created** | Ports are not edges: `ADR-0033`; `ADR-0035` **L238**/**L427**; `PRD-008` **L878** (14 of 17 `library_management` ports carry no numbered edge) |
| Is the direction lawful? | ✅ **YES** | `platform/search` rank **5** (manifest **L38**) → `platform/identity` rank **4** (**L36**); strictly downward, law **`L2`** |
| Is the cell permitted? | ✅ **YES** | Matrix **L140** `R5 SEARCH` × `IDENTITY & ACCESS` = **`◇`** (permitted port use) |
| Is a new ADR required? | ⛔ **NO** | The mechanism was already decided; an ADR to re-decide it would be an ADR about an existing fact |
| Is a new BC / API / event required? | ⛔ **NO** | An existing named port is reused; **0** new names minted |
| Were unrelated consumers altered? | ⛔ **NO** | `auth`, `account_directory`, `notification_address` byte-identical; the five prior `policy_decision` consumers retained in their original order, `platform/search` **appended** |

### 40.3 Validation actually run

| Instrument | Result |
|---|---|
| YAML parse (`yaml.safe_load`) | ✅ **OK** — 23 top-level keys (unchanged); `platform/search.ports` = `['platform/identity:policy_decision']`; `policy_decision.consumers` = the five prior + `platform/search`; `SE-1`/`SE-2` intact |
| ⭐⭐ **Gate 3 — `dart run tool/check_module_boundaries.dart`** (Matrix §10.4; `X-10`, `X-13`) | ⭐ **Output BYTE-IDENTICAL before vs after** (`diff` of stashed vs working run = empty) ⇒ **zero new violations introduced** |
| Gate-3 exit code | `1` **before** and `1` **after** — the **pre-existing** `ADR-0012` red. `tool/gates.sh` header: *"gate 3 is expected to fail today on nine `app -> domain/library` violations… That is a correct red, not a broken script."* ⛔ **Not caused by, and not worsened by, this pass** |
| Diff scope | 2 hunks, 1 file, `13 insertions(+), 1 deletion(-)` — the single deletion is the consumers line, re-emitted with the sixth consumer |

⚠ **Gates 1, 2, 4, 5, 6 were NOT run.** They compile and test **application code**, which this pass does not
touch (`git diff` over `lib/ test/ android/ web/ pubspec.yaml ios/` = **empty**). Gate 3 is the only gate that
reads `tool/module_dependencies.yaml`. ⛔ Stated rather than implied, so no unrun gate is reported as passed.

### 40.4 ⚠ TWO PRE-EXISTING MANIFEST ASYMMETRIES — DISCLOSED, ⛔ NOT REPAIRED

Measuring the port's two sides exposed two inconsistencies that **predate this pass** and are **not mine to fix**
(`GCP-25`: *repair only what your own pass caused; disclose and route the rest*).

| # | Asymmetry | Evidence | Routed to |
|---|---|---|---|
| **`SRCHGB-D1`** | **`domain/person` consumes `policy_decision` but was never listed as a consumer.** There are **six** consumer-side declarations (**L116** `domain/library`, **L186** `domain/person`, **L245** `domain/social`, **L285** `platform/ai`, **L312** `platform/analytics`, **L341** `platform/workflow`) against **five** listed consumers | `domain/person` (rank **7.5**, `ADR-0011`) declares the port at **L186** yet is absent from `provides_ports.policy_decision.consumers` | **Architecture Owner** — ⛔ **NOT** added by this pass: only `platform/search` was authorized, and adding a seventh module unasked would be exactly the overreach this engagement has refused throughout |
| **`SRCHGB-D2`** | **`platform/search` declares no `provides_ports`, yet four modules consume its ports.** `platform/search:indexer` at **L117**/**L187**/**L246** and `platform/search:retrieval` at **L286** | `platform/search` block has `rank`, `imports`, `ports` (new), `consumes_events`, `banned_imports`, `assertions` — no `provides_ports` | **Architecture Owner** — ⛔ **NOT** added: it is a **separate** declaration gap (inbound, not the entitlement gap), and inventing `indexer`/`retrieval` consumer lists would decide who may index |

⭐ **`SRCHGB-D2` also means `SRCH-GAP-003`'s closure is not weakened by symmetry-of-form arguments**: the
repository already tolerates one-sided port declarations. The two-sided form was chosen because it is the
*majority* convention, not because a one-sided form would have been unlawful.

### 40.5 Downstream effect

| Consequence | Status |
|---|---|
| `SRCH-GAP-003` (§42 **L981**, `Blocks` = *"Stage 3; and any tenant-operational surface"*) | ✅ **CLOSED** — the declared, build-visible mechanism now exists |
| **R2** (entitlement mechanism → R2) | ✅ **UNBLOCKED** at the mechanism level |
| `SRCHCL-A3` / `F-3` second limb | ⛔ Remains **FALSIFIED** (Part III §30); the first limb (*no `BC-23`→`BC-18` edge*) remains **TRUE** and is now true **by design and by enactment** |
| `SRCHGR-A4` (write path bound by `SE-2`, query path unbound) | ✅ **RESOLVED** — the query path now has a declared authorization port |
| Stage 3 | ⚠ **STILL CONDITIONAL** — `SRCH-GAP-002` and `SRCH-GAP-007` remain `Blocks = Stage 3` |

---

## 41. `SRCH-GAP-002` — PARAMETER MATRIX (post-enactment)

Each parameter handled independently. P8 sub-decisions ⛔ **not collapsed**.

| P | Meaning (§36 **L833-842**) | Status | Authority / exact missing input |
|---|---|---|---|
| **P1** | Engine / index technology | ✅ **CLOSED — correctly, as vendor-neutral** | `MP-CON-01`/`MP-CON-03`; `MASTER_PRD.md` **L238**: *"Choosing a BaaS for V1 is a **deployment decision, not an architecture decision**"*. ⭐ Architecture is complete **without** an engine name; selection belongs to deployment/platform work. ⛔ No vendor invented |
| **P2-A** | Analyzer / tokenizer configuration | ⛔ **OPEN** | Authority route ✅ established (`ADR-0099`), but `ADR-0099` **§2.3 L107-108** expressly routes *"the analyzer, by name or by specification"* and *"the tokenizer"* to *"a later Architecture Owner act"*. **Missing:** the configuration itself, from the **Architecture Owner** |
| **P2-B** | Script-conditional Latin case folding | ✅ **CLOSED** | Human decision, preserved unaltered |
| **P2-C** | ZWJ/ZWNJ — *policy* | ✅ **CLOSED** (strip-with-exceptions) | Human decision, preserved |
| **P2-C** | ZWJ/ZWNJ — *exact exception set + `N6`×`N4` order* | ⛔ **OPEN** | `ADR-0099` **L110** routes this *"evidence-bound to the applicable **Unicode/product authority**"*. Repository search returns **0** authoritative citations — every hit (`ARCHITECTURE_OWNER_DECISION_PACKET.md` **L150**, `FINAL_ARCHITECTURE_DECISION_PREPARATION.md` **L243**) states the *tension*, not a resolution. **Missing:** Architecture Owner + **a cited Unicode/product source**. ⛔ No exception list invented; ⛔ no Unicode behaviour claimed without evidence |
| **P2-D** | Script-aware normalization | ✅ **CLOSED** | Human decision, preserved |
| **P2U** | Grapheme-cluster unit | ✅ **CLOSED** | Human decision, preserved |
| **P3** | Edit-distance bound **+** minimum token length | ⛔ **OPEN** | Repository holds only **placeholders**: `SRCH-BR-012` **C2** *"MUST NOT apply below a **declared** minimum token length"*; §36 **L837**. Measured: **0** authoritative values (`edit.distance|levenshtein|fuzzi|min.token` → placeholders and refusals only). **Missing:** two numeric bounds from the **Architecture Owner** (per `PO_DECISION_RESOLUTION_RECORD.md` **L257**). ⛔ No number invented |
| **P4** | Minimum prefix length | ⛔ **OPEN** | `SRCH-FR-030` (**L520**) makes prefix matching a **MUST** but declares no length; §36 **L838**. **Missing:** one numeric bound from the **Architecture Owner**. ⛔ No number invented |
| **P7** | Latency / throughput / availability | ⛔ **OPEN — route valid, destination EMPTY** | Route ✅ `LIB-20.1` (`Library_PRD_v1.md` **L862**) → EA NFR Budgets. Destination measured: `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L339-344** holds *Latency Budgets (V1)*, *Availability Targets (V1)*, *Throughput Targets (V2)* as **headings with zero values**; a numeric sweep of the whole EA returns **one** hit, unrelated prose at **L2485**. **Missing:** the values, from the **Architecture Owner**, written at the EA destination. ⛔ No NFR number invented |
| **P8-A** | Rebuildability | ✅ **CLOSED** | BC Map **L453** — rebuild *"tested quarterly, not assumed"* |
| **P8-B** | Serve-stale **posture** | ✅ **CLOSED** | Hybrid / security-constrained; revoked & private **fail closed**. Reinforced by subject **L793-794**: *"Staleness MUST NOT be resolved in the caller's favour on authorisation… the index never grants access"* |
| **P8-B** | Serve-stale **window (duration)** | ⛔ **OPEN** | §11 **L443** of this record already isolates *"the staleness **window** for the permitted case (a latency figure ⇒ `LIB-20.1` ⇒ `HD-11`)"*. It is therefore **BLOCKED BY P7** — same empty destination. **Missing:** P7 values first, then the window |
| **P8-C** | Rebuild duration | ⛔ **OPEN — BLOCKED BY P7** | Same EA NFR destination, same emptiness. **Missing:** a rebuild-duration budget from the **Architecture Owner**. ⛔ No duration invented |
| **P8-D** | Full **and** incremental rebuild supported | ✅ **CLOSED** (both modes) | Human decision, preserved |
| **P8-D** | The **selection rule** between modes | ⛔ **OPEN** | ⛔ Measured: no repository authority and no human decision supplies a criterion. **Missing:** an explicit rule from the **Architecture Owner**. ⛔ No operational criteria invented |

**Tally — 8 P-rows:** P1 ✅ · P2 ⛔ (P2-A open; P2-C content open) · P3 ⛔ · P4 ⛔ · **P5 ✅** (`LCFG-12` = 20) ·
**P6 ✅** (`LCFG-6` = 60 s, removal only) · P7 ⛔ · P8 ⛔ (B-window, C, D-rule open).
⇒ **3 of 8 rows fully closed.** ⛔ Unchanged by this pass — `SRCH-GAP-003`'s closure does not touch `-002`.

⛔ **`SRCH-GAP-002` remains OPEN and remains `Blocks = Stage 3`** (§42 **L980**).

---

## 42. `SRCH-GAP-007` + **B1** — SCRIPT / LANGUAGE / VOCABULARY

### 42.1 Preserved scope

| Item | Status |
|---|---|
| V1 canonical languages = **English + Hindi** | ✅ **CLOSED** — `SRCHPO-1` (**L57**), closed set of two |
| Hinglish / Romanized Hindi | ✅ **CLOSED** — `SRCHPO-2` (**L58**): supported **query behaviour**, ⛔ **not** a third canonical language. ⛔ No third language, index or BC created |
| *"where technically validated"* | ✅ Permissive, not required — `SRCHPO-3` (**L59**) |
| **F-5 = Option A** (script is **consumed**, never inferred) | ✅ Preserved. ⛔ No language detection introduced |

### 42.2 The five content sub-items

| # | Sub-item | Status | Exact missing input · authority |
|---|---|---|---|
| 1 | Per-field **script carrier** (mechanism) | ✅ **CLOSED** (B1) | See §42.3 |
| 2 | Per-field **script values** (content) | ⛔ **OPEN** | Measured **0** authoritative per-field values repository-wide; `F5_CLASSIFICATION_DECISION_PACKET.md` **L175**: *"**Zero** of the seven owning contexts declares a script for any field it owns"*. **Missing:** the values, from the **Product Owner**, per owning context under `AR-1`. ⛔ Script **not** inferred from field names |
| 3 | Analyzer / tokenizer configuration | ⛔ **OPEN** | = **P2-A**. `BC-23` **consumes** the declared script (`ADR-0099` `C-3`/`C-4`); ⛔ it does not infer it |
| 4 | Exact Unicode normalization rules incl. ZWJ/ZWNJ set + order | ⛔ **OPEN** | = **P2-C** content. Requires a **cited** Unicode/product authority; ⛔ none exists in-repo |
| 5 | Variant / abbreviation **vocabulary** | ⛔ **OPEN** | `ADR-0099` **L111** routes `HD-16` to *"`SRCH-GAP-007`, split owner"*; subject **L552**: *"the **vocabulary inventory** is [deferred]"*; `SRCH-BR-011` (**L548**) requires a **declared** rule set. **Missing:** the inventory, from the **Product Owner** (markets). ⛔ No vocabulary invented |

### 42.3 **B1** — the declaration mechanism

✅ **MECHANISM CLOSED · ⛔ CONTENT OPEN** — confirmed unchanged from Part III §33.

| Question | Answer |
|---|---|
| Can the PO-style declaration record carry per-field script **without modifying frozen §14A**? | ✅ **YES** |
| Mechanism | The `SRCHPO-A3` declaration-record precedent — a Product-Owner record that **declares** values referenced by, but not embedded in, the frozen contract |
| Why §14A need not change | `AR-1` (**L39-50**): *"Discovery **references, never duplicates**"*. `BC-23` references the source field; the owning context keeps ownership |
| Field ownership | ⛔ **NOT transferred to `BC-23`** — each field's script is declared by its **owning context** per `AR-1`; `BC-23` only discovers it |
| Frozen §14A | ✅ **byte-unchanged** this pass (SHA-verified) |
| Remaining need | The **content** — a Product Owner declaration record enumerating each searchable field and its script |

⛔ **`SRCH-GAP-007` remains OPEN and remains `Blocks = Stage 3`** (§42 **L985**).

---

## 43. `SRCH-GAP-008` — ⛔ **DOES NOT BLOCK STAGE 3** (preserved)

| Field | Value |
|---|---|
| Ownership | ✅ **CONFIRMED** — `ADR-0098` **L222**: `` | `XPC-OD-010` bot/scraping defence | ⛔ **OPEN** — *"NOT resolved by C7"* | **Architecture Owner** | `` |
| Status | ⚠ **OWNED / ROUTED — DECISION PENDING** |
| ⭐ Blocks Stage 3? | ⛔ **NO** — §42 **L986** `Blocks` = *"Nothing in V1"*. **Explicitly preserved**; this pass does **not** let it block Stage 3 |
| Force-closed? | ⛔ **NO** — ownership is not a decision (`SRCHCL-X1`: *"an office is not an act"*) |

---

## 44. DEPENDENCY GRAPH — RECOMPUTED

| Edge | Upstream state | Downstream state | ⚠ Model-vs-content check |
|---|---|---|---|
| **F-5 → P2-D** | ✅ Option A closed | ✅ P2-D closed | Both are **policy**; no content hidden behind either |
| **P2-D → P2-B** | ✅ closed | ✅ closed | Both policy |
| **P2U → P3 / P4** | ✅ P2U = grapheme cluster | ⛔ **P3, P4 OPEN** | ⭐ The **unit** is decided; the **bounds** are not. ⛔ Deciding the unit does not supply the numbers |
| **P2-A → N5 / P3 / P4** | ⛔ **P2-A OPEN** (authority routed, config absent) | ⛔ **BLOCKED** | ⭐ `ADR-0099` closed the **authority limb only** — its own §2.3 says so. ⛔ Not reported as closing N5/P3/P4 |
| **P7 → P8-C** | ⛔ **P7 OPEN** (route valid, destination empty) | ⛔ **P8-C BLOCKED**, and **P8-B window** likewise | ⭐ A valid **route** to an **empty** destination is not a value |
| **ENT mechanism → R2** | ✅ **CLOSED this pass** (§40) | ✅ **R2 UNBLOCKED** at mechanism level | ⭐ The one genuine forward movement of this pass |
| **`SRCH-GAP-007` → script / analyzer / vocabulary completeness** | ⛔ **OPEN** (scope closed, 5 content items: 1 closed, 4 open) | ⛔ **INCOMPLETE** | ⭐ Language **scope** closed ≠ script/vocabulary **content** closed |

⭐⭐ **The governing rule applied throughout:** *a MODEL decision is not automatically a CONTENT decision.*
**Zero** downstream items were closed on the strength of an upstream policy whose content is still missing.

---

## 45. STAGE-3 REASSESSMENT

### 45.1 Six architecture checks — **6 / 6 PASS**

| # | Check | Result | Evidence (post-enactment) |
|---|---|---|---|
| 1 | Exclusive ownership | ✅ **PASS** | `BC-23` sole owner of index artefacts; `AR-1` — Discovery *references, never duplicates* |
| 2 | Required integration edges exist in §7 | ✅ **PASS** | BC Map §7 still holds exactly `E-21` (**L330**) and `E-26` (**L335**) for `BC-23`. ⭐ The entitlement dependency is a **port**, so its absence from §7 is **correct** — and remains correct after enactment |
| 3 | Rank direction downward | ✅ **PASS** | ⭐ Now **machine-visible**: `platform/search` **5** → `platform/identity` **4**; gate 3 reports **no** new violation |
| 4 | Authorization only through `BC-18` | ✅ **PASS** | ⭐ **Strengthened** — the declaration names `policy_decision` and carries *"ask BC-18 per request; never evaluate locally; never cache"*. Subject **L793-794**: *"the index never grants access"* |
| 5 | No credential / OTP / session outside `BC-18` | ✅ **PASS** | No such data indexed; the new port returns a **decision**, not a credential |
| 6 | Tenant scoping | ✅ **PASS** | `SE-1` *"every index name is tenant-prefixed"* `# X-13` — machine-enforced; `SE-2` intact |

⛔ **6/6 does NOT make Stage 3 complete.** Recorded explicitly per the instruction.

### 45.2 Four axes, held apart

| Axis | Result | Basis |
|---|---|---|
| **A · Architecture alignment** | ✅ **PASS** | 6/6 above, each anchored; ⭐ checks 3 and 4 now machine-verified |
| **B · Parameter completeness** | ⛔ **FAIL** | 3 of 8 P-rows closed; `SRCH-GAP-002` `Blocks = Stage 3` (**L980**) |
| **C · Implementation readiness** | ⛔ **FAIL** | §45.1 gates 1-8 (**L1374-1383**) still OPEN — incl. gate 7 *"`SRCH-GAP-007` language/vocabulary inventory declared"* (**L1382**) |
| **D · Governance / conferral readiness** | ⛔ **FAIL** | §12 four-limb test: **A** fail (`-002`, `-007` open and lifecycle-classified blocking) · **B** fail (AO decisions absent) · **C** fail (no act-specific conferrer — `ADR-0033` §7.1) · **D** therefore fail |

### 45.3 ⚠ VERDICT — **B · CONDITIONAL / NOT CONFERRED**

⭐ **Unchanged — and unchanged despite this pass closing a real blocker.** One of three blocking gaps
(`SRCH-GAP-003`) is now genuinely **CLOSED** by an authorized, validated, build-visible declaration. Two remain:

| Remaining blocker | §42 `Blocks` | Why it cannot be waived here |
|---|---|---|
| **`SRCH-GAP-002`** | **L980** *"Stage 3; nothing in Stage 2"* | 5 of 8 P-rows lack values; `SRCHCL-X2` bars a review from downgrading its own subject's declared blockers |
| **`SRCH-GAP-007`** | **L985** *"Stage 3"* | 4 of 5 content sub-items open; ⛔ inventing any would breach the no-invention rule |

⛔ **The instruction's own condition is met literally:** *"If `SRCH-GAP-002` or `SRCH-GAP-007` remains classified
by PRD-015 §42 as blocking Stage 3, Stage 3 MUST remain CONDITIONAL / NOT CONFERRED."* Both do. It does.

⛔ **"Stage-3 readiness achieved" is therefore NOT reported.** ⛔ No conferral performed.
⛔ `PRD-015` remains `DRAFT` / `PLANNED` (`PRD_REGISTRY.md` **L315**).

---

## 46. FINDINGS

### 46.1 Accepted

| ID | Finding |
|---|---|
| **`SRCHGB-A1`** | ⭐⭐ **The entitlement declaration is two-sided, not one-sided.** `platform/search` had **no `ports:` key at all`**, so Part III's *"two-line"* estimate was structurally incomplete. Corrected by measurement before writing |
| **`SRCHGB-A2`** | ⭐⭐ **Gate 3's output is byte-identical before and after.** The strongest available evidence that an authorized manifest edit introduced **zero** new violations |
| **`SRCHGB-A3`** | ⭐ **Gate 3's exit code was already `1` before this pass** — the documented `ADR-0012` red. Reported so a pre-existing red is neither concealed nor misattributed |
| **`SRCHGB-A4`** | ⭐⭐ **`domain/person` consumes `policy_decision` but was never a listed consumer** (`SRCHGB-D1`) — a pre-existing asymmetry, disclosed and routed, ⛔ not repaired |
| **`SRCHGB-A5`** | ⭐⭐ **`platform/search` provides `indexer`/`retrieval` to four modules with no `provides_ports` block** (`SRCHGB-D2`) — pre-existing, disclosed, ⛔ not repaired |
| **`SRCHGB-A6`** | ⭐ **P8-B's window and P8-C are BLOCKED BY P7, not independently open.** All three await the same empty EA destination — one missing input, not three |
| **`SRCHGB-A7`** | ⭐ **The EA NFR destination is empty by measurement, not by assumption**: a numeric sweep of the entire Rank 6 EA yields one unrelated hit |

### 46.2 Rejected

| ID | Proposition | Disposition |
|---|---|---|
| **`SRCHGB-X1`** | *"`SRCH-GAP-003` is closed, so Stage 3 can be conferred."* | ⛔ **REJECTED** — `-002` and `-007` still carry `Blocks = Stage 3` |
| **`SRCHGB-X2`** | *"While editing the manifest, also add `domain/person` and `platform/search`'s `provides_ports`."* | ⛔ **REJECTED** — only `SRCH-GAP-003` was authorized; both are separate acts (`SRCHGB-D1`/`D2`) |
| **`SRCHGB-X3`** | *"`ADR-0099` exists, so P2-A is closed."* | ⛔ **REJECTED** — `ADR-0099` **§2.3** routes the analyzer and tokenizer to *"a later Architecture Owner act"* and its own header says it *"Does NOT close `SRCH-GAP-002`"* |
| **`SRCHGB-X4`** | *"`LCFG-2` (Language, `en`) supplies the language inventory."* | ⛔ **REJECTED** — `CONFIGURATION_GUIDE.md` **L352** Range = *"Supported set"*: it **defers** the inventory |
| **`SRCHGB-X5`** | *"P1 is an open blocker because no engine is named."* | ⛔ **REJECTED** — `MP-CON-02` (**L238**) makes engine choice a **deployment** decision; naming one would invent architecture |
| **`SRCHGB-X6`** | *"Prefix/typo tolerance being MUSTs means P3/P4 are decided."* | ⛔ **REJECTED** — `SRCHPO-X5`; `SRCH-BR-012` **C2**/**C3** require a **declared** minimum and bound, and **0** exist |
| **`SRCHGB-X7`** | *"Since ZWJ/ZWNJ policy is strip-with-exceptions, the exception set follows from Unicode."* | ⛔ **REJECTED** — `ADR-0099` **L110** requires the set to be *evidence-bound to the applicable Unicode/product authority*; ⛔ no Unicode behaviour may be claimed without a citation, and none is in-repo |
| **`SRCHGB-X8`** | *"Both rebuild modes being supported implies a selection rule."* | ⛔ **REJECTED** — support is a capability; the criterion is a separate, absent decision |

---

## 47. INTEGRITY

| Assertion | Status |
|---|---|
| Files changed | **2** — `tool/module_dependencies.yaml` (authorized, §40) + this record (Part IV, append-only) |
| Parts I-III | ✅ **byte-identical** to `97d94a3` (lines 1-1132) |
| Frozen / protected artefacts | ✅ **21 SHA-verified UNCHANGED** — incl. the subject `fe3093e6…c2c4544`, BC Map, Matrix, `ARCHITECTURE_RULINGS`, EA, baseline, both registries, `ADR-INDEX`, `ADR-0099`, `ADR-0098`, `CONFIGURATION_GUIDE`, frozen `14A`, `Library_PRD_v1`, `MASTER_PRD`, **and both validators** (`check_module_boundaries.dart`, `gates.sh`) |
| Application code | ⛔ **0 lines** — `git diff` over `lib/ test/ android/ web/ pubspec.yaml ios/` is empty |
| New BC | ⛔ **0** |
| New BC Map edge | ⛔ **0** — ⭐ `BC-23`→`BC-18` **deliberately not created**; §7 still holds only `E-21`, `E-26` |
| New ADR | ⛔ **0** |
| New API / event / port **name** | ⛔ **0** — an **existing** port was declared, not minted |
| `IMPL-*` | ⛔ **0** |
| Invented numbers / NFRs / Unicode rules / vocabulary / vendors | ⛔ **0** |
| Stages 4 / 5 / 6 / 7 | ⛔ **NOT entered** — no freeze, baseline, rank or approval |
| Conferral | ⛔ **NOT performed** |
| Reopened decisions | ⛔ **0** |

**END OF PART IV.** ✅ **`SRCH-GAP-003` CLOSED by authorized declaration; gate 3 shows zero new violations.**
⚠ **VERDICT: B — STAGE 3 CONDITIONAL / NOT CONFERRED** — `SRCH-GAP-002` and `SRCH-GAP-007` still block.
⛔ **Architecture Owner one-act conferral: NOT READY.**

---
---

# PART V — CONSOLIDATED HUMAN DECISION + GOVERNANCE RESOLUTION

| Field | Value |
|---|---|
| **Part** | **V** — appended to Parts I–IV; ⛔ **no earlier Part rewritten** |
| **Act performed** | 📋 **HUMAN DECISION RECORDING + EXTERNAL-EVIDENCE ACQUISITION + AUTHORITY CLASSIFICATION + ROUTING** |
| **Act NOT performed** | ⛔ **No Stage-3 conferral.** ⛔ No frozen artefact modified. ⛔ No Enterprise Architecture edit. ⛔ No value invented |
| **Predecessor commit** | `8eb3124` (Part IV — `SRCH-GAP-003` closed by authorized declaration) |
| **Input** | 14 human decision inputs `HD-PRD015-01` … `HD-PRD015-14`, supplied expressly as **human decisions**, ⛔ **not** as pre-existing repository authority |
| **Subject SHA (re-verified)** | `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` — byte-unchanged |
| **Reopened** | ⛔ **Nothing.** `F-5` Option A, `HD-1`…`HD-16`, `P2U`, `P2-B`, `P2-D`, `P5`, `P6`, `P8-A`, `ENT`, `SRCH-GAP-003 = CLOSED`, `GAP-008 = NON-BLOCKING` all stand |
| **Verdict** | ⚠ **B — STAGE 3 CONDITIONAL / NOT CONFERRED** *(unchanged from Part IV)* |

⭐⭐⭐ **The load-bearing sentence of Part V, written first so the flattering reading is unavailable.**
This pass received **fourteen** decisions and **could have reported fourteen closures.** It reports **five**
closures, **six** decisions that are recorded but **require a separate governance act to take effect**, **one**
deliberate non-closure the principal himself instructed, and **two** disclosed **stricter-authority conflicts**.
The reason is `§D` of the instruction: *"Do not pretend they were discovered in the repository."* A human decision
is **authority over its own content**; it is **not** authority over the **locus** in which that content must be
written when a **frozen Rank 3 rule** and a **Rank 6 descriptive artefact** already govern that locus.

---

## 48. The fourteen human decisions — recorded, classified, routed

### 48.0 Classification vocabulary used below

Per instruction `§D`, every value carries exactly one of:

| Class | Meaning |
|---|---|
**`HUMAN DECISION`** | Supplied by the principal this pass. Recorded as such. ⛔ Not represented as repository-discovered
**`REPOSITORY AUTHORITY`** | Already binding in the repository before this pass. The human input **confirms** it
**`EXTERNAL AUTHORITY`** | Supplied by a cited external normative source (here: Unicode)
**`CONFLICT`** | Contradicts a frozen or higher-authority rule. ⛔ Closure **stopped**, conflict reported
**`REQUIRES SEPARATE GOVERNANCE ACT`** | Content accepted, but the act that makes it binding belongs to a named office this pass does not hold

---

### 48.1 `HD-PRD015-01` — P2-A analyzer / tokenizer

| | |
|---|---|
**Exact human input** | Vendor-neutral logical pipeline: `QUERY → Unicode/script-aware normalization → grapheme-aware tokenization → exact/token/prefix/typo matching`. ⛔ No vendor or engine at architecture level. Engine selection remains a deployment/platform decision. Close architecture-level P2-A **if compatible with `ADR-0099`**; if `ADR-0099` requires a concrete engine-specific configuration, keep that portion OPEN
**Repository compatibility** | ✅ **Tested against all ten `ADR-0099` §2.2 constraints (L85-94), individually — see §48.1a. Zero contradictions.**
**Authority classification** | **`HUMAN DECISION`** for the pipeline **order and properties**; **`REQUIRES SEPARATE GOVERNANCE ACT`** for the concrete analyzer/tokenizer specification
**Downstream impact** | The **logical contract** `BC-23` must satisfy is now declared and testable in shape. `ADR-0099` §2.3's first two OPEN rows (*"The analyzer, by name or by specification"*, *"The tokenizer, by name or by specification"*) are **narrowed, not closed** |
**Closure status** | ⚠ **PARTIAL.** Architecture-level *logical pipeline* = **RECORDED**. Concrete configuration = **OPEN**, routed to the Architecture Owner under `ADR-0099` §2.1 |

#### 48.1a The ten-constraint compatibility test, run rather than asserted

| # | `ADR-0099` §2.2 constraint | Result against the proposed pipeline |
|---|---|---|
`C-1` | Index/query symmetry (`SRCH-FR-023` **L414**) | ✅ The pipeline is stated **once** and is silent on side, so it is applicable identically to both. ⚠ Note: symmetry is a property of *how it is applied*, not of the pipeline text — an implementing act can still violate `C-1` by accident, exactly as `ADR-0099` warns
`C-2` | Totality and symmetry (`SRCH-BR-008` **L427-429**) | ✅ No asymmetric stage is introduced
`C-3` | Script **consumed, never inferred** (`SRCHAO-F5` = Option A) | ✅ *"script-aware"* is read as **consuming an authoritative declared script**. ⛔ It is **NOT** read as detecting script. This reading is recorded expressly because the phrase is capable of the forbidden reading
`C-4` | Script-aware application (`HD-2`) | ✅ Directly restates `HD-2`
`C-5` | **Grapheme-cluster** counting unit (`HD-5`) | ✅ *"grapheme-aware tokenization"* is congruent; and `P3`/`P4` below count in grapheme clusters
`C-6` | Vendor-neutral expression (`MP-CON-01`, `MP-CON-03`) | ✅ **This is the decision's own express content.** ⛔ No vendor named
`C-7` | Tenant partitioning unweakened (`MP-GBR-08`, `SE-1`, `X-13`, `AR-3`, `SRCH-INV-002`/`-004`) | ✅ The pipeline is text-processing only; it touches no index-class or tenant-key rule
`C-8` | Closed set of two languages (`SRCHPO-1`, `HD-16`) | ✅ Presupposes no third language
`C-9` | ⛔ **No language detection** (`SRCHPO-2`) | ✅ *script*-aware ≠ *language* detection, and `C-3`'s consumed-declaration reading forecloses the drift
`C-10` | Declared, not emergent | ✅ The pipeline is a document statement

⚠ **Why this is PARTIAL and not CLOSED, stated plainly.** `ADR-0099` §2.1 holds that the configuration *"MUST be
established by an **express architecture act** before implementation"*, and lists among the things it is **not**
established by *"an implementer's choice at build time"*. A **human decision recorded in a resolution record is not
an Architecture Owner act.** Reporting P2-A as CLOSED would make this record the author of an authority
`ADR-0099` reserved elsewhere — the precise defect `ADR-0099` §2.3's closing note warns about.

---

### 48.2 `HD-PRD015-02` — P2-C Unicode / `ZWJ` / `ZWNJ`

| | |
|---|---|
**Exact human input** | Keep **STRIP-WITH-EXCEPTIONS**. Use authoritative Unicode evidence to define the exact exception behaviour. ⛔ *"The human decision does NOT authorize Claude to invent an exception list."* MUST consult authoritative Unicode material, distinguish Unicode **facts** from Liboora **product policy**, cite the exact source, record only what is supported; keep unsupported detail OPEN
**Repository compatibility** | ✅ Compatible. `N6` (**L425**) already requires removal of zero-width/control/formatting characters; `P2-C` policy was already decided; `ADR-0099` **L110** routes the exception set *"evidence-bound to the applicable Unicode/product authority"* |
**Authority classification** | **`EXTERNAL AUTHORITY`** for the Unicode facts in §49; **`REPOSITORY AUTHORITY`** for the strip default (`N6`); **`REQUIRES SEPARATE GOVERNANCE ACT`** for the exception **set content** |
**Downstream impact** | ⭐ `P2-C`'s policy shape moves from **asserted** to **evidenced** — the first time in this engagement that an external normative citation has been placed under it |
**Closure status** | ⚠ **PARTIAL.** Policy **shape** = **EVIDENCED / CLOSED**. Exception **set content** and the `N6`×`N4` **ordering** = **OPEN** |

⭐⭐ **What the evidence actually bought, and what it did not.** §49 establishes, from a citable normative
document, that (a) the joining controls **are** `Default_Ignorable_Code_Point`s, (b) the Unicode-recommended
default for a **comparison form** is to **ignore / remove** them, and (c) that default is expressly subject to a
carve-out — *"unless their use is required in a particular domain."* ⭐ **That carve-out is the exception limb of
strip-with-exceptions, and it is now sourced rather than invented.** ⛔ **What §49 does NOT supply:** any
enumeration of which Devanagari sequences require `ZWJ`/`ZWNJ`, and any ordering of a diacritic-folding stage
against a control-removal stage. Those remain `ADR-0099` **L110**, unresolved.

---

### 48.3 `HD-PRD015-03` — P3 typo tolerance

| | |
|---|---|
**Exact human input** | maximum edit distance = **1**; minimum token length for typo correction = **3** grapheme clusters. Exact matches remain higher priority. ⛔ *"Do not silently replace them with another number."* If a different authority is required for these values, **record that requirement** rather than pretending the value was repository-discovered |
**Repository compatibility** | ✅ **No contradiction found, by measurement — see §48.3a** |
**Authority classification** | **`HUMAN DECISION`** (values) + **`REQUIRES SEPARATE GOVERNANCE ACT`** (the act that makes them binding) |
**Downstream impact** | `SRCH-BR-012` `C2`/`C3` now have **proposed** values on record with a named provenance |
**Closure status** | ⚠ **RECORDED, NOT CLOSED.** `SRCH-GAP-002` `P3` stays OPEN pending an Architecture Owner act |

#### 48.3a The contradiction search, and its result

| Test | Method | Result |
|---|---|---|
Does any repository authority state a different edit-distance bound? | grep across `docs/` for edit-distance / fuzzy bounds | ⛔ **None.** §36 **L829** records the refusal expressly: *"⛔ No number is invented"*
Does any repository authority state a different minimum token length? | same | ⛔ **None**
Do the values satisfy `SRCH-BR-012` `C1`…`C5` (**L565-571**)? | read each constraint against the values | ✅ `C1` untouched (tolerance still excluded on exact-role fields); ✅ `C2` **satisfied** — 3 is *"a declared minimum token length"*, which is exactly what `C2` demands exist; ✅ `C3` **satisfied** — 1 is *"bounded and uniform across consumers"*; ✅ `C4` untouched (§22.2 tier order unchanged); ✅ `C5` untouched (no widening)
Does any **test** contradict them? | `find test -iname '*search*'` | ⛔ **Zero search tests exist.** `test/` holds `architecture/`, `domain/`, `authentication_conformance_test.dart`, `student_identity_conformance_test.dart`, `widget_test.dart`. ⭐ **Nothing in the test suite can contradict `P3` or `P4`** — stated as a measurement, not as a convenience
Does `SRCH-FR-033` (**L557-559**) permit distance 1? | read | ✅ It requires matching on *"a **bounded, minor** character difference — insertion, deletion, substitution or transposition"*. **1 is the minimum non-trivial bound** and is the most conservative value satisfying the requirement

⛔ **Why this is RECORDED and not CLOSED — the single most important line in §48.3.** The subject document states
its own ownership rule at **L574**, verbatim: *"⚠ **C2's minimum length and C3's bound are `SRCH-GAP-002`, owner
Architecture Owner.** ⛔ Not fabricated here."* The principal's own instruction anticipated this and directed the
honest outcome: *"If architecture/governance requires a different authority for these values, record that
requirement rather than pretending the value was repository-discovered."* ✅ **The requirement is recorded. The
value is not laundered into repository authority.**

---

### 48.4 `HD-PRD015-04` — P4 minimum prefix length

| | |
|---|---|
**Exact human input** | minimum prefix length = **3** grapheme clusters. `Lib` may match `Library`; `Li` is not required; `Central Lib` multi-word matching remains supported. Count in the already-decided grapheme-cluster unit |
**Repository compatibility** | ✅ **Corroborated by the subject's own illustration.** `SRCH-FR-030` (**L518-520**) makes prefix matching a **MUST** and illustrates it with **`Lib` → `Library`** — a **three**-grapheme-cluster prefix. ⭐ The proposed minimum is the exact length of the PRD's own worked example, so the value is congruent with the document rather than merely un-contradicted by it. Multi-word support is unaffected (`N5` tokenization, **L424**). Counting unit matches `C-5`/`HD-5` |
**Authority classification** | **`HUMAN DECISION`** (value) + **`REQUIRES SEPARATE GOVERNANCE ACT`** (binding act) |
**Downstream impact** | `SRCH-GAP-002` `P4` has a proposed value with named provenance and documentary corroboration |
**Closure status** | ⚠ **RECORDED, NOT CLOSED.** Same owner as `P3` (`SRCH-GAP-002`, Architecture Owner) |

⚠ **The corroboration is deliberately not overstated.** `SRCH-FR-030`'s example shows that 3 **works**; it does
not state that 3 is the **minimum**. An example is not a bound. ⛔ The value therefore remains a human decision,
not a repository discovery.

---

### 48.5 ⭐⭐⭐ `HD-PRD015-05` — P7 query latency — **CONFLICT OF LOCUS, CLOSURE STOPPED**

| | |
|---|---|
**Exact human input** | Target **≤ 2 s** for normal search queries; hard upper bound **≤ 5 s**. Record as a product/architecture NFR proposal **only if compatible with existing NFR governance**. If EA NFR Budgets is the required destination, record there **only if this pass is authorized to modify that artefact**. ⭐ *"If the EA artifact is frozen/protected or requires a separate Architecture Owner act: **DO NOT modify it.** Record the human decision and exact required follow-up."* |
**Repository compatibility** | ⛔ **The VALUES contradict nothing. The ACT of writing them here would contradict a frozen Rank 3 rule — see §48.5a** |
**Authority classification** | ⛔ **`REQUIRES SEPARATE GOVERNANCE ACT`** (Architecture Owner), with a **`CONFLICT`** disclosed as to locus |
**Downstream impact** | `P7`'s latency limb has a recorded human intent and a **named destination and office**. ⛔ It is not binding |
**Closure status** | ⛔ **NOT CLOSED. EA NOT MODIFIED.** Follow-up recorded at §55 |

#### 48.5a The frozen rule that stops this closure, quoted verbatim

`Library_PRD_v1.md` **L862-864**, `LIB-20.1`, **FROZEN**, Rank 3:

> *"Platform-wide NFR budgets **MUST** be taken from the Enterprise Architecture NFR Budgets document. This PRD
> **MUST NOT** state a competing latency or availability figure."*

Three measured facts complete the test:

| # | Measurement | Consequence |
|---|---|---|
1 | `DOCUMENTATION_BASELINE.md` **L139** classifies `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.3 as **Rank 6 — *"Descriptive — must follow the PRDs, never lead them."*** | The EA is not a scratchpad. Its own baseline row governs how it changes
2 | The same row records **every** precedent for changing it: `ADR-0042` §4 changed the EA **by exactly one token**, as an **Architecture Owner act**; `ADR-0079` appended below **L2404** and re-resolved **482 citations**; and for `ADR-0061` / `FIL-GAP-015` the conflicts were *"resolved **by precedence**"* — ⭐ *"**the EA was NOT edited**"* | An EA edit is an **Architecture Owner ADR act**. This pass holds no such office
3 | The destination itself was read: EA **L339-344** contains the NFR Budgets subtree — *Latency Budgets (V1)*, *Availability Targets (V1)*, *Throughput Targets (V2)*, *Cost Budgets (V2)*, *Mobile Performance Budgets (V1)* — and a numeric sweep of the file returned **one unrelated hit at L2485** | ⭐ The destination is **headings with no values**. Writing the first values into an empty Rank 6 budget tree is precisely the act that requires the office |

⚠ **The nuance that cuts against this record's convenience, disclosed rather than buried.** `LIB-20.1`'s **second**
sentence binds *"This PRD"* — the Library PRD — and not, on its face, `PRD-015`. ⭐ **It does not matter, and here
is why:** its **first** sentence is stated as a **platform-wide** rule, and `PRD-015` **§36 L826-829** independently
refuses the same thing in its own voice — *"⚠⚠ **No performance target is stated in this document, and that is a
deliberate refusal**"*, routing latency/availability to `SRCH-GAP-002`, **owner Architecture Owner**. **Two
independent authorities, one conclusion.** The closure would fail on either alone.

---

### 48.6 `HD-PRD015-06` — P7 throughput

| | |
|---|---|
**Exact human input** | ⛔ **Do NOT invent a QPS number.** Keep throughput as *"must support expected V1 tenant workload without violating the latency budget."* ⛔ Do not manufacture a number merely to close the gap. If a numeric value is mandatory for Stage 3, mark that specific numeric field **OPEN** |
**Repository compatibility** | ✅ Fully compatible, and congruent with `PRD-015` §36's own refusal. ⚠ Measured: EA **L343** names *Throughput Targets* as **V2**, so no V1 numeric throughput destination even exists |
**Authority classification** | **`HUMAN DECISION`** — a decision **not** to supply a value, which is itself a lawful decision |
**Downstream impact** | The qualitative statement stands; the numeric field is expressly OPEN |
**Closure status** | ⚠ **Qualitative limb RECORDED. Numeric field OPEN by express human instruction.** `P7` cannot close on this limb |

⭐ **This is the decision this pass is most pleased to record, because it costs the report a closure.** A number
here would have moved `P7` from OPEN to CLOSED with one sentence and no evidence. The principal declined, and the
declination is preserved as the reason `P7` still blocks.

---

### 48.7 `HD-PRD015-07` — P7 availability

| | |
|---|---|
**Exact human input** | **99.9% monthly** availability target for search retrieval. Validate against existing enterprise/platform NFR conventions. ⛔ Do not invent additional availability tiers |
**Repository compatibility** | ✅ **The value is an EXISTING repository convention, not a new tier — measured, see §48.7a.** ⛔ **But the locus problem of §48.5a applies identically** |
**Authority classification** | **`REPOSITORY AUTHORITY`** for the *form and tier* `99.9% monthly`; **`HUMAN DECISION`** for *applying it to `BC-23` retrieval*; ⛔ **`REQUIRES SEPARATE GOVERNANCE ACT`** for recording it in the EA |
**Downstream impact** | `P7`'s availability limb has a value that provably introduces **no new tier** |
**Closure status** | ⛔ **NOT CLOSED** — same `LIB-20.1` / Rank 6 locus conflict as `HD-PRD015-05` |

#### 48.7a The convention, measured

| Source | Line | Text |
|---|---|---|
`docs/30-product/authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` | **L67** | *"Authentication service availability \| **99.9% monthly**"* |
*ibid.* | **L68** | *"Session validation availability \| 99.95% monthly"* |
*ibid.* | **L69** | *"Authorization decision availability \| 99.95% monthly"* |
`docs/30-product/authentication/prd-v2/01-Purpose-and-Goals.md` | **L213**, **L231** | `KPI-4` ≥ 99.9%; `KPI-12` ≥ 99.9% **monthly** |
`docs/30-product/authentication/Authentication_PRD_v2.md` | **L320** | same convention |

✅ **`99.9% monthly` is therefore a re-use, not an invention**, and the instruction *"do not invent additional
availability tiers"* is satisfied **by measurement**: the proposal uses the **lower** of the two tiers already in
use and creates no third.

⭐⭐ **An unprompted coherence check, recorded because it strengthens the proposal and could have been omitted.**
`BC-23` asks `BC-18` for an authorization decision **per request** (the `SRCH-GAP-003` declaration closed at Part IV
§40). `BC-18`'s *authorization decision availability* is **99.95%** (**L69**). A dependent service proposed at
**99.9%** therefore sits **below** the availability of the dependency it calls — which is the **correct** direction.
Had the proposal been 99.99%, `BC-23` would have promised more availability than its own critical dependency, and
this record would have had to report that as a defect.

---

### 48.8 ⭐⭐ `HD-PRD015-08` — P8-B stale serving — **STRICTER EXISTING RULE FOUND AND APPLIED**

| | |
|---|---|
**Exact human input** | Maximum ordinary stale-search window = **60 seconds**. Security rule absolute: **REVOKED / PRIVATE / NO-LONGER-ENTITLED content MUST FAIL CLOSED**; stale serving MUST NOT override current entitlement truth; **no cached authorization decision may be used as entitlement truth**. ⭐ *"If the repository already has a stricter value, use the stricter authoritative rule and disclose the conflict"* |
**Repository compatibility** | ⚠ **Security limb: fully confirmed by existing authority. Window limb: a STRICTER existing rule exists for one event class — see §48.8a** |
**Authority classification** | Security limb = **`REPOSITORY AUTHORITY`** (the human input **confirms**, it does not create); window limb = **`HUMAN DECISION`** + **`CONFLICT`** (stricter rule for `SEV-9`) + **`REQUIRES SEPARATE GOVERNANCE ACT`** |
**Downstream impact** | `P8-B`'s security posture is now doubly grounded; the ordinary window carries a mandatory carve-out |
**Closure status** | ⚠ **Security limb CLOSED (it was already closed). Window limb RECORDED WITH A CARVE-OUT, NOT CLOSED** |

#### 48.8a The stricter rule, and the two false equivalences avoided

| # | Finding | Disposition |
|---|---|---|
⭐ **1** | **`SRCH-FR-013` (L354-355) is STRICTER and it is existing authority.** A privacy-mode change (`identity.PersonPrivacyModeChanged`) **MUST** be applied with **no propagation window** — the event is recorded as having **none** (`SEV-9`, BC Map **L427**). §31 **L737-738** reinforces it: *"**Privacy mode has no grace period** … `BC-23` **MUST NOT** define an eventual-consistency allowance for it"* | ✅ **The stricter rule governs.** Per the principal's own instruction, the 60 s ordinary window **MUST carve out `SEV-9`, whose window is ZERO.** Disclosed, not silently overwritten
⭐ **2** | **`MP-GBR-26`** (`MASTER_PRD.md` **L380**, Rank 1): session revocation is *"**immediate and global** — authoritative-or-absent, with **no propagation window**"* | ✅ Confirms the fail-closed limb at Rank 1. A 60 s window may **never** be read onto a revocation path
⛔ **3 — FALSE EQUIVALENCE AVOIDED.** `LCFG-6` is also **60 s**, and it would have been effortless to report *"the repository already says 60 s, so `P8-B` is closed by repository authority."* **That would have been wrong.** `CONFIGURATION_GUIDE.md` **L356** defines `LCFG-6` as *"Discovery index propagation"* — **"Removal latency only"** — and **L377** states it *"**must never be consulted on an authorization path**"*, because a propagation window wired into a permission check would breach `MP-GBR-26` *"using a Rank 7 configuration value"* | ⛔ `LCFG-6` (`P6`, **removal latency**, already closed) and `HD-PRD015-08` (`P8-B`, **stale-serving window**) are **different parameters that share a number.** Conflating them would be a category error and is expressly refused
⛔ **4 — SECOND FALSE EQUIVALENCE AVOIDED.** `LCFG-13` is a *"Public preview cache TTL"* of **300 s** whose rationale ends *"**Never** applies to an authorization decision"* | ⛔ Also not the same parameter. Not used
✅ **5** | The security limb's three clauses were each matched to pre-existing authority: fail-closed = §35 **L815** (*"⭐ **Fail closed.** ⛔ `BC-23` **MUST NOT** fall back to reading a domain table"*) + BC Map **L330** (*"Search never reads domain tables"*); stale-never-in-caller's-favour = §33 **L793** (*"Staleness **MUST NOT** be resolved in the caller's favour on authorisation … the index never grants access"*); no-cached-authorization = Matrix **L220** (*"ask BC-18, never evaluate or cache"*) + `MP-GBR-26` | ✅ **The human input adds no new security rule. It ratifies three that already bind.** Recorded as confirmation, ⛔ not as a new decision |
