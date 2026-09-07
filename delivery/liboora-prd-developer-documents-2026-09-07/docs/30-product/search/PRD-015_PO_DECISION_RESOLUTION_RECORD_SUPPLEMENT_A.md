# PRD-015 — Product Owner Decision Resolution Record — **SUPPLEMENT A**
## ⭐⭐⭐ `H-B0` — PER-FIELD **MATCH ROLE** DECLARATION FOR THE §14A.5 PUBLIC FIELD SET

| Field | Value |
|---|---|
| **Type** | Decision **resolution** record — **SUPPLEMENT** to [`PRD-015_PO_DECISION_RESOLUTION_RECORD.md`](./PRD-015_PO_DECISION_RESOLUTION_RECORD.md) v1.0 |
| **Not** | ⛔ Not a PRD · not an ADR · not an approval · not an ARB ruling · not a conferral · not a freeze · not a baseline · ⛔ **not a script declaration** |
| **Version** | v1.0 |
| **Date** | 2026-09-05 |
| **Why a SUPPLEMENT and not an edit** | ⭐⭐ The parent record's own **amendment rule** states: *"If a later decision supersedes it, the remedy is a **new record or a supplement** — ⛔ **never a silent rewrite of these answers**."* This record therefore **adds**; the parent is **byte-unchanged** |
| **Form** | Follows the parent, which itself follows [`PRD-006_PO_DECISION_RESOLUTION_RECORD.md`](../attendance-management/PRD-006_PO_DECISION_RESOLUTION_RECORD.md) — ⭐ the **`SRCHPO-A3` precedent** selected by human ruling **`HD-1`** as the authoritative carrier |
| **Subject** | [`PRD-015_SEARCH_INDEXING.md`](./PRD-015_SEARCH_INDEXING.md) **v0.1 `DRAFT`** — sha256 `fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544`, **byte-unchanged by this record** |
| **Decision authority exercised** | ⭐ **Product Owner only** |
| **Blocker addressed** | ⭐ **`H-B0` ONLY** — *which* §14A.5 fields/sub-fields receive a match role |
| **Blockers NOT addressed** | ⛔ **`H-B`** (which script) · ⛔ **`H-C`** (corpus / ZWNJ) · ⛔ **`H-D`** (availability governance) · ⛔ **`H-E`** (architecture reviewer) |
| **Approvals asserted** | ⛔ **None.** No ARB, Architecture Owner, Architecture Reviewer, Security Platform, Privacy Owner, Governance Owner or independent-reviewer approval is claimed |
| **ADRs created / amended / Accepted** | ⛔ **Zero** |
| **Scripts assigned** | ⛔ **ZERO.** ⭐ No field is bound to `Latin` or `Devanagari` by this record |
| **Formal conferral** | ⛔ **NOT CONFERRED** |
| **Final decision** | ⚠ **STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED** |

> **What this record is for.** `H-B0` asked a question that had **0 authority**: *which* of the §14A.5 public
> fields are eligible to carry a per-field script binding at all. The Product Owner has now answered it — and
> answered it in **the repository's own vocabulary**, `SRCH-FR-018`'s three **match roles**, rather than in the
> invented predicate *"script-bearing"* that a prior governance pass had coined and that appears **0 times**
> anywhere in this repository outside that pass's own text.
>
> ⭐⭐⭐ **This is the correct instrument for the question.** `SRCH-FR-017` states that *"a field **MUST** be
> indexable only where its owning contract declares it so. For library discovery, that contract is **§14A.4 /
> §14A.5**"*, and `SRCH-FR-018` states that *"each eligible field **MUST** declare its match role: **text**,
> **exact**, or **filter**"*. Those declarations did not exist. They now do.
>
> ⛔ **What this record does not do.** It does **not** say which script any field uses. That is `H-B`, it belongs
> to the Product Owner **with Architecture Owner concurrence** under `ADR-0099` `C-3`, and it is untouched here.

---

## 1. The decision as given

⭐ **`SRCHPO-16`** — **PER-FIELD MATCH ROLE DECLARATION.** For the fourteen fields of the §14A.5 *Public Library
Profile*, the declared `SRCH-FR-018` match role is as follows. Where a field is **composite**, the role is
declared at **sub-field** granularity, because `SRCH-FR-018` demands *"exactly one match role"* and a composite
field cannot satisfy that at field level.

| # | §14A.5 Field | Sub-field | ⭐ Declared match role |
|---|---|---|---|
| 1 | **Library Name** | — | **`text`** |
| 2 | **Logo** | — | **`none`** |
| 3 | **Cover Image** | — | **`none`** |
| 4 | **Gallery** | — | **`none`** |
| 5 | **Description** | — | **`none`** |
| 6 | **Business Address** | City | **`text`** |
| 6 | **Business Address** | PIN Code | **`exact`** |
| 6 | **Business Address** | State | **`filter`** |
| 6 | **Business Address** | Street line | **`none`** |
| 7 | **Map Location** | Geocoded coordinates | **`none`** |
| 7 | **Map Location** | Optional free-text locality | **`text`** |
| 8 | **Operating Hours** | — | **`filter`** |
| 9 | **Weekly Holidays** | — | **`filter`** |
| 10 | **Facilities & Amenities** | Controlled reference-list association | **`filter`** |
| 10 | **Facilities & Amenities** | Optional free-text note | **`none`** |
| 11 | **Membership Plans & Pricing** | Fee | **`filter`** |
| 11 | **Membership Plans & Pricing** | Plan name | **`none`** |
| 12 | **Seat Capacity** *(Optional)* | — | **`filter`** |
| 13 | **Library Status** | — | **`filter`** |
| 14 | **Business Contact Information** | — | **`none`** |

**Coverage: 14 of 14 §14A.5 fields · 20 declared role bindings · ⛔ 0 fields left UNRESOLVED.**

### 1.1 Role tally

| Role | Bindings | Which |
|---|---|---|
| **`text`** | **3** | Library Name · Business Address→City · Map Location→locality |
| **`exact`** | **1** | Business Address→PIN Code |
| **`filter`** | **7** | Operating Hours · Weekly Holidays · Facilities→reference list · Membership→Fee · Seat Capacity · Library Status · Business Address→State |
| **`none`** | **9** | Logo · Cover Image · Gallery · Description · Business Address→Street line · Map Location→coordinates · Facilities→note · Membership→Plan name · Business Contact Information |

⭐⭐ **`none` is a lawful outcome, not an omission.** `SRCH-FR-017` makes eligibility **opt-in** and
`SRCH-INV-006` states the consequence exactly: *"A field that is not declared eligible is not indexed, not
matchable, and not returnable."*

---

## 2. ⭐⭐⭐ The three composites, addressed explicitly

`SRCH-FR-018` requires *exactly one* match role per eligible field. Three §14A.5 entries are **not single-typed
values**, so a field-level role was **not available** for them. Each is resolved at sub-field level.

### 2.1 Business Address — four sub-parts, four different roles

| Sub-part | Role | Why the sub-part exists as a distinct unit |
|---|---|---|
| City | **`text`** | ⭐ §14A.4 declares *"**Search by City**"* — a search capability whose target is not a §14A.5 field name but a **sub-part of one** |
| PIN Code | **`exact`** | §14A.4 *"**Search by PIN Code**"*; `LIB-6` validation *"**Exactly 6 digits**"* ⇒ `SRCH-FR-018`'s *"identifier-like; exact/prefix only"* |
| State | **`filter`** | `LIB-6` validation *"Non-empty; **from a controlled list**"* ⇒ a closed vocabulary, equality semantics |
| Street line | **`none`** | ⛔ No §14A.4 capability targets it |

### 2.2 Map Location — **coordinates + optional free-text locality**

`LIB-6.5` (Rank 3, FROZEN): *"Map Location **MUST** be stored as **geocoded coordinates plus an optional
free-text locality**."*

| Sub-part | Role | Basis |
|---|---|---|
| **Geocoded coordinates** | **`none`** | ⭐ `SRCH-BR-014`: `BC-23` *"**MUST** offer exactly one ordering: **relevance**"* and *"§14A's distance sort… is applied by the authorised consumer **after** retrieval, under that consumer's own authority."* The coordinate pair therefore does not enter `BC-23` matching at all |
| **Optional free-text locality** | **`text`** | ⭐ §14A.4 *"**Search by Locality**"* — the one §14A.4 search whose target is a free-text **sub-part** |

⭐⭐ **The two halves of Map Location take different roles.** A single field-level role was structurally
impossible, which is precisely why `H-B0` could not be answered by inference.

### 2.3 Facilities & Amenities — **reference list + optional free-text note**

`LIB-13.1`: *"Facilities **MUST** be modelled as a **reference list** of facility definitions plus a per-branch
association. They **MUST NOT** be modelled as one boolean column per facility."*
`LIB-13.4`: *"A facility association **MAY** carry an **optional free-text note**."*

| Sub-part | Role | Basis |
|---|---|---|
| **Controlled reference-list association** | **`filter`** | ⭐ §14A.4 *"**Facility Filters**"* — declared as a filter, never as a search. `LCFG-8` bounds the list at 50 |
| **Optional free-text note** | **`none`** | ⛔ No §14A.4 capability searches notes |

---

## 3. What `SRCHPO-16` authorises, and what it does **not**

### 3.1 ✅ What it does

| # | Effect |
|---|---|
| 1 | ⭐ Supplies, for the first time, the **`SRCH-FR-018` match-role declarations** that `SRCH-AC-018` requires be inspectable — *"**then** exactly one match role — text, exact or filter — is declared for it"* |
| 2 | ⭐⭐ Establishes the **denominator** for any later per-field script binding: the **`text`-role set**, whose members are **Library Name**, **Business Address→City**, and **Map Location→locality** |
| 3 | Establishes that **9 bindings are `none`** and therefore, per `SRCH-INV-006`, are *"not indexed, not matchable, and not returnable"* |
| 4 | Resolves the **three composites** at the only granularity at which `SRCH-FR-018` can be satisfied |
| 5 | ⭐ **Closes `H-B0`** — the question *which* fields/sub-fields receive a match role |

### 3.2 ⛔ What it does **NOT** do

| # | ⛔ Not authorised by this record |
|---|---|
| 1 | ⛔ **No script is assigned.** Neither `Latin` nor `Devanagari` is bound to any field or sub-field. **`H-B` remains OPEN** |
| 2 | ⛔ **No Architecture Owner concurrence** is claimed. `ADR-0099` `C-3` requires it for the *script* binding; it is neither given nor implied here |
| 3 | ⛔ **`H-C` untouched** — the V1 operational corpus is still undefined and the `ZWNJ` corpus fact is still unestablished |
| 4 | ⛔ **`H-D` untouched** — the SRE/Observability office remains unconstituted; `99.9% monthly` remains unratified |
| 5 | ⛔ **`H-E` untouched** — no Architecture reviewer is appointed |
| 6 | ⛔ **No analyzer or tokenizer configuration** is decided. `ADR-0099` reserves that to the Architecture Owner |
| 7 | ⛔ **No `SRCH-GAP-002` / `SRCH-GAP-007` limb is closed** beyond what `H-B0` itself was blocking |
| 8 | ⛔ **No frozen document is amended.** §14A.5's field list is **byte-unchanged**; this record declares **roles for** those fields, it does not **add an attribute to** them — the distinction `HD-1` drew |
| 9 | ⛔ **No `Library Type` field is created.** §14A.4 names a *"Library Type Filter"* but §14A.5 has no such field and `REVIEW_14A` `R-D` records that it *"has no domain vocabulary"*. ⭐ **Out of scope for `H-B0`, and deliberately not invented** |
| 10 | ⛔ **Stage 3 is not conferred**, not ready, and not claimed to be either |

---

## 4. ⭐ The `text`-role set — the exact input `H-B` now needs

Because `ADR-0099` `C-4` applies normalization *"according to the field's authoritative declared script"*, and
`SRCH-FR-024` applies `N1`–`N6` *"where compatible with the field's declared script and language scope"*, the
script question arises **only** for `text`-role units.

| # | `text`-role unit | Owning context | Owning PRD |
|---|---|---|---|
| 1 | **Library Name** | `BC-19` | `PRD-013` |
| 2 | **Business Address → City** | `BC-19` | `PRD-013` |
| 3 | **Map Location → optional free-text locality** | `BC-19` | `PRD-013` |

⭐⭐⭐ **`H-B`'s denominator is therefore 3, not 14.** All three sit in **one** owning context (`BC-19`) and
**one** owning PRD (`PRD-013`) — where the prior 14-field ownership matrix spanned **six** frozen PRDs.

⚠⚠ **This retrospectively confirms why *"declare all 14 fields Latin"* was refused.** Eleven of the fourteen
fields take **no text role at all**; a script binding on them would have been meaningless, and on `Logo`,
`Cover Image` and `Gallery` it would have been a category error. ⛔ **The three-member `text` set is still
unbound to any script, and this record does not bind it.**

⭐ **Nothing in this record forecloses `H-B`'s answer.** With `SRCHPO-1`'s closed set of two — English (Latin)
and Hindi (Devanagari) — a lawful `H-B` act may bind these three units to either script, in any combination,
subject to `HD-3`'s script-conditional rule and Architecture Owner concurrence.

---

## 5. `H-B0` gate — re-run

| # | `H-B0` condition | Before | ⭐ After |
|---|---|---|---|
| 1 | The authoritative §14A.5 denominator is identified | ✅ **14** | ✅ **14** |
| 2 | A lawful predicate exists in repository vocabulary | ⛔ *"script-bearing"* = **0 hits** | ✅ **`SRCH-FR-018` match roles** |
| 3 | Every §14A.5 field is classified | ⛔ **0 of 14** | ✅ **14 of 14** |
| 4 | Composite fields resolved at a granularity `SRCH-FR-018` admits | ⛔ **0 of 3** | ✅ **3 of 3** |
| 5 | An actual Product Owner act occurred | ⛔ **NO** | ✅ **YES** |
| 6 | Recorded through the lawful carrier (`HD-1` / `SRCHPO-A3` precedent) | ⛔ not recorded | ✅ **this supplement** |
| 7 | Recorded without amending a frozen document | — | ✅ **0 frozen bytes** |

### ⭐⭐⭐ `H-B0` — ✅ **CLOSED**

⛔ **And `H-B0` only.** Its closure does **not** close `H-B`; it **specifies** `H-B` by reducing its denominator
from an unverified 14 to a measured **3**.

---

## 6. Findings register

| ID | Finding | Disposition |
|---|---|---|
| ⭐ **`SRCHPO-A5`** | `H-B0` was posed with the predicate *"script-bearing"*, which appears **0** times in this repository outside the governance pass that coined it. `SRCH-FR-018`'s **match roles** are the authoritative equivalent | ✅ **ACCEPTED** — this record uses the repository's vocabulary (§1) |
| ⭐⭐ **`SRCHPO-A6`** | §14A.4 declares searches and filters over **City**, **Locality**, **PIN Code** and **Library Type** — and **none** of the four is a §14A.5 field name. Three are **sub-parts** of §14A.5 fields | ✅ **ACCEPTED** — sub-field granularity adopted (§2) |
| ⭐⭐ **`SRCHPO-A7`** | The `text`-role set has **3** members, all in `BC-19`/`PRD-013` — not 14 across six PRDs | ✅ **ACCEPTED** — §4 |
| **`SRCHPO-A8`** | §14A.4's *"Library Type Filter"* has no §14A.5 field and no domain register (`REVIEW_14A` `R-D`) | ⚠ **RAISED** — not resolved here; out of `H-B0` scope |
| **`SRCHPO-X9`** | *"`H-B0` is closed, therefore the script values may now be inferred from the `text` set."* | ⛔ **REJECTED** — `ADR-0099` `C-3`: *"Script binding is **consumed, never inferred**."* A role is not a script |
| **`SRCHPO-X10`** | *"A `text` role implies Latin because the illustrations in `SRCH-FR-024` are Latin."* | ⛔ **REJECTED** — illustrations are not declarations; `SRCHPO-1` fixes a **two**-script set and `HD-3` is script-**conditional** |
| **`SRCHPO-X11`** | *"`H-B0` closing means Stage 3 may be conferred."* | ⛔ **REJECTED** — `PRD_OWNERSHIP_MODEL.md` §5: *"**Only the Architecture Owner approves.**"* Four blockers remain |
| **`SRCHPO-X12`** | *"§14A.5 should be edited to carry the match roles."* | ⛔ **REJECTED** — `HD-1`: *"⛔ **Do NOT modify frozen §14A** merely to add the script attribute"*; the same reasoning governs roles. §14A.5 is **byte-unchanged** |

**4 accepted · 1 raised · 4 rejected with reasons.**

---

## 7. Validation performed

| Check | Result |
|---|---|
| Parent record byte-unchanged | ✅ `76b469cc…38643bd6` — ⛔ **not rewritten**, per its own amendment rule |
| Subject `PRD-015_SEARCH_INDEXING.md` byte-unchanged | ✅ `fe3093e6…c2c4544` |
| Frozen documents amended | ⛔ **0** — `Library_PRD_v1.md` (incl. **§14A**), `14B`, `PRD-023`, `PRD-013`, `PRD-017`, `PRD-002`, `MASTER_PRD.md`, `ARCHITECTURE_RULINGS.md`, `PRD_OWNERSHIP_MODEL.md`, `DOCUMENTATION_BASELINE.md` all byte-unchanged |
| ADRs created / amended | ⛔ **0** (**89** numbered ADRs before and after; `ADR-0102` unopened) |
| `SRCHPO-` ID collisions | ⛔ **0** — `SRCHPO-16`, `A5`–`A8`, `X9`–`X12` measured unused before minting |
| New roles invented beyond `SRCH-FR-018` | ⛔ **0** — only `text`, `exact`, `filter`, plus `none` = *not declared eligible* (`SRCH-FR-017` / `SRCH-INV-006`) |
| New fields invented | ⛔ **0** — the 14 names are §14A.5's verbatim; sub-parts are `LIB-6`, `LIB-6.5`, `LIB-13.1`/`13.4` verbatim |
| Scripts assigned | ⛔ **0** |
| `IMPL-*` identifiers | ⛔ **0** |
| Application-code files | ⛔ **0** lines under `lib/`, `test/`, `tool/`, `android/`, `web/`, `ios/` |
| Freeze / baseline / rank changed | ⛔ **0** — `BASELINE-2026-09-03-A` unmoved; registry **L315** remains `DRAFT` |
| Stage 4–7 entered | ⛔ **NO** |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created as **Supplement A** to `PRD-015_PO_DECISION_RESOLUTION_RECORD.md` v1.0, under that record's own amendment rule (*"the remedy is a new record or a supplement — never a silent rewrite"*), and on the **`SRCHPO-A3` carrier precedent selected by `HD-1`**. ⭐⭐⭐ **Records `SRCHPO-16` — the per-field `SRCH-FR-018` match-role declaration for all 14 §14A.5 public fields**, at **sub-field granularity** for the three composites (Business Address, Map Location, Facilities & Amenities), giving **20 bindings**: **3 `text` · 1 `exact` · 7 `filter` · 9 `none`**. ⭐⭐ **Discovers that §14A.4 searches City/Locality/PIN Code — none of which is a §14A.5 field name** — and adopts sub-field granularity rather than inventing field-level roles. ⭐⭐ **Reduces `H-B`'s denominator from an unverified 14 to a measured 3**, all in `BC-19`/`PRD-013`. ⭐ **`H-B0` → CLOSED.** ⛔ `H-B`, `H-C`, `H-D`, `H-E` untouched. ⛔ **0 scripts assigned · 0 frozen bytes · 0 subject bytes · 0 parent-record bytes · 0 ADRs · 0 `IMPL-*` · 0 code · 0 freeze · 0 baseline · 0 rank change.** |

**Amendment rule.** This record states what was decided **on the date it was decided**. If a later decision
supersedes it, the remedy is a **new record or a further supplement** — ⛔ **never a silent rewrite of these
answers**.

---

**End of `PRD-015_PO_DECISION_RESOLUTION_RECORD_SUPPLEMENT_A.md`.**
**Product decision: ✅ RECORDED — `SRCHPO-16`, per-field match roles, 14 of 14 fields, 20 bindings.**
**⭐ `H-B0`: ✅ CLOSED. ⛔ `H-B` / `H-C` / `H-D` / `H-E`: OPEN.**
**⛔ Scripts assigned: ZERO. Formal conferral: ⛔ NOT CONFERRED.**
**⚠ STAGE 3 REMAINS CONDITIONAL / NOT CONFERRED.** `PRD-015` remains **v0.1 `DRAFT`**, registry **`PLANNED`**.
⛔ **STAGE 4 NOT ENTERED · IMPLEMENTATION IDs NOT CREATED · FREEZE NOT PERFORMED · BASELINE NOT PERFORMED · NO FROZEN DOCUMENTS MODIFIED.**
