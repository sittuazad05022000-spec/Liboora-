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
