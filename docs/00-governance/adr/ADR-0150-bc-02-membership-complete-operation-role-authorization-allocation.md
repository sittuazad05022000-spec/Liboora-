# ADR-0150 — The **complete `BC-02` Membership operation×role authorization allocation** is established for all eleven `MM-PO-*` protected operations, by **derived capability**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-09-19 |
| **Date** | 2026-09-19 |
| **Deciders** | **Product Owner** *(the substantive allocation: which role holds which capability, at which action and scope, for the nine previously uncovered operations)* **and Authorization (`BC-18` / `PRD-001`) Owner** *(review and formalisation of that allocation against the frozen authorization model)*, **jointly**, each under a **one-act conferral** of the human principal of this engagement, ⛔ **reverting on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*) |
| **Authority instrument** | ⭐⭐ The Product Owner's decision, recorded **verbatim** at §2.1, including the three conflict resolutions at §2.2 — *"`MM-PO-008` … TR-3 = DENY … Do NOT invent a new field restriction to make this operation allowable"*; *"`MM-PO-001` … TR-1 Owner = ALLOW … TR-2 Manager = DENY … Preserve the frozen commercial-configuration boundary"*; *"V1 does NOT authorize a new INITIATE action … Do NOT widen `MM-FR-119` in this act."* ⭐ The Authorization Owner conferral is recorded **in this ADR**, the instrument that exercises it — ⛔ **no standalone conferral artifact is created**, per the measured repository practice (**0** standalone conferral records) |
| **Amends** | ⛔⛔ **NOTHING IS EDITED BY THIS ADR.** No file outside this one changes. It is **declaratory and constitutive**: it records a decision and allocates authority under mechanisms that already exist (`ADR-0132` §5.3; the `prd-v2/07` action and scope classes). ⭐ Its **execution** into Rank 3 is a separate, governed `PRD-005` **v1.6** amendment under `PRD_LIFECYCLE.md` §4 — see §8 |
| **Baseline** | ⛔ **No baseline re-issue by this ADR.** No Rank 1–5 document changes here (`DOCUMENTATION_BASELINE.md` §7 **rule 4**). ⚠ The **v1.6** amendment that executes this ADR *does* move the baseline; that is recorded there, not here |
| **Closes** | ⭐⭐ **`G-8`** (`ADR-0149` §9 — the `MM-PO-003` / `AC-7.8` financial-exposure gap, resolved at §4.1 **in the negative**) · ⭐ **the `DD-0001` Declaration 3 blocker** — by supplying the whole-module source `D3` requires |
| **Does NOT close** | ⛔ **`MM-GAP-011`** — the deferred **Student self-service / request authority** gap this ADR *opens* (§5) · ⛔ `MM-GAP-004`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a` · ⛔ `DD-0001-GAP-001` · ⛔ `P-1`…`P-6` privacy items · ⛔ `SM-GAP-4`, `SM-GAP-5` |
| **Related** | `ADR-0149` *(the `MM-PO-002`/`MM-PO-011` allocation — **preserved unchanged**)* · `ADR-0132` *(`AUTH-7.22` audited at zero; derived capability the lawful route)* · `ADR-0043` *(**"do not invent a new permission ID"**)* · `ADR-0019` *(`PRD-005` v1.4 freeze; **L103** — `MM-PO-*` name operations *"without modelling a role"*)* · `ADR-0087` *(the 253 derived capabilities at Rank 3)* · `ADR-0033` §7.1 *(one-act conferral)* |

> ⭐⭐ **`AUTH-7.22` REMAINS CLOSED AT ZERO ENUMERATED PERMISSIONS.** ⛔ This ADR mints **no** permission
> identifier, **no** `PERM-*` token, **no** action class, **no** scope class, **no** role, **no** event, **no**
> aggregate, **no** BC Map row, **no** edge, **no** configuration identifier and **no** `MM-PO-*` register entry.
> ⛔ **`ADR-0132` is NOT reopened, amended or superseded, and NONE of its §7 prerequisites is engaged.**

---

## 1. Context

`PRD-005` **§16.3** (`FROZEN`, Rank 3) enumerates eleven protected operations `MM-PO-001`…`MM-PO-011` as a
**closed list**. `Accepted` `ADR-0149` allocated **two** of them — `MM-PO-002` and `MM-PO-011` — leaving **nine**
with no authoritative operation×role source.

⭐⭐ **The nine were not merely undocumented; they were UNRESOLVABLE without a decision, and that was measured
rather than assumed:**

| Operation | Existing `§16.3` Notes text | Why it could not be read as an allocation |
|---|---|---|
| `MM-PO-001` | *"Owner/Manager class"* | A **class noun**, not a `TR-n` identifier |
| `MM-PO-003`, `006`, `007` | *"Reception class **and above**"* | ⛔ *"and above"* presupposes a **role ordering**. `AP-4` / `AUTH-7.7`: *"No permission is derived from role naming, **hierarchy, seniority** or similarity to another permission."* `AUTH-7.28`: *"Permissions **MUST NOT** form a hierarchy"* |
| `MM-PO-004`, `005` | *"Elevated"* | ⛔ **Undefined** — measured **0** definitions of *"Elevated"* as a role set repository-wide |
| `MM-PO-008`, `009`, `010` | *"Includes price snapshot"*, *"§8"*, *"machine-to-machine"* | ⛔ **No role language at all** |

⭐ `ADR-0019` **L103** already disclaimed those Notes cells: `MM-PO-001`…`011` *"name the protected operations
**without modelling a role**."* ⛔ So there was nothing to interpret — **expanding *"and above"* or *"Elevated"*
into role sets would have been inventing an ordering, in breach of two frozen rules.**

⭐⭐ **This ADR does not solve that by cleverer reading. It records an explicit Product Owner decision**, which is
the only lawful source of the missing substance.

---

## 2. The Product Owner decision

### 2.1 The complete allocation — every operation, every role, every action, every scope

⭐⭐ **Expressed as a DERIVED CAPABILITY, not as an enumerated permission** — `ADR-0132` §5.3's mechanism, in the
form `LCM-AUTH-007` establishes (`PRD-021A`): **every role stated explicitly, no inheritance, deny where
authority is absent.**

| `MM-PO-*` | Operation | Action | Scope | `TR-1` Owner | `TR-2` Manager | `TR-3` Reception | `TR-4` Student | `TR-5` Parent |
|---|---|---|---|---|---|---|---|---|
| **`MM-PO-001`** | Create membership plan | **Create** | **`Tenant`** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** | ⛔ **DENY** |
| `MM-PO-002` | Edit / activate / deactivate plan | **Approve** / **Update** | **`Tenant`** | ⛔⛔ *pre-existing — `ADR-0149` `D-2`, **preserved unchanged*** | | | | |
| **`MM-PO-003`** | Create membership | **Create** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-004`** | **Manually activate** a `PendingPayment` membership | **Update** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-005`** | Void a pre-activation membership | **Update** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-006`** | Renew membership | **Create** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-007`** | Upgrade membership | **Create** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-008`** | View membership detail *(includes price snapshot)* | **Read** | see cells | ⭐ **ALLOW · `Tenant`** | ⭐ **ALLOW · `Tenant`** | ⛔⛔ **DENY** | ⭐ **ALLOW · `Self`** | ⭐ **ALLOW · `Linked`** |
| **`MM-PO-009`** | List operational membership views | **Read** | **`Tenant`** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⭐ **ALLOW** | ⛔ **DENY** | ⛔ **DENY** |
| **`MM-PO-010`** | Query validity for a student | **Read** | see cells | ⭐ **ALLOW · `Tenant`** | ⭐ **ALLOW · `Tenant`** | ⭐ **ALLOW · `Tenant`** | ⭐ **ALLOW · `Self`** | ⭐ **ALLOW · `Linked`** |
| `MM-PO-011` | Change a membership configurable | **Approve** / **Update** | **`Tenant`** | ⛔⛔ *pre-existing — `ADR-0149` `D-2`/`D-4`, **preserved unchanged*** | | | | |

⭐ **Legend.** **ALLOW** and **DENY** are stated per role **explicitly**; ⛔ nothing is implied, inherited or
derived from any other cell. The `MM-PO-002` and `MM-PO-011` rows are reproduced **for completeness of the
eleven** and carry **no new allocation** — `ADR-0149` governs them and is **not reopened**.

### 2.2 The three conflicts, resolved by the Product Owner — recorded verbatim

⚠️⚠️ **Each of these three was raised as a CONFLICT against frozen text BEFORE any document was written, and
each was returned to the Product Owner rather than resolved by reinterpretation.** ⭐ The resolutions are
recorded here in the deciding authority's own words, because the reasoning is the authority.

| # | Conflict raised | ⭐ Product Owner resolution, **verbatim** |
|---|---|---|
| **1** | `MM-PO-008` exposes the **price snapshot**, while `AC-7.8` denies `TR-3` financial permissions *"regardless of other roles held anywhere"* and frozen `prd-v2/02` §2.4.1 gives `TR-3` financial visibility **"None"** | *"**TR-3 = DENY.** … `MM-PO-008` includes the price snapshot. Frozen `AC-7.8` denies Reception financial permissions. Frozen §2.4.1 gives TR-3 no financial visibility. **Do NOT invent a new field restriction to make this operation allowable.**"* |
| **2** | `MM-PO-001` creates a **priced** plan, while §2.4.1 scopes `TR-2` to *"Entire library, **excluding commercial configuration**"* and `ADR-0149` `D-2` denied `TR-2` even the **approval** of a plan edit | *"**TR-1 Owner = ALLOW / Create / Tenant. TR-2 Manager = DENY. TR-3 Reception = DENY.** … Membership plans contain commercial configuration. **Preserve the frozen commercial-configuration boundary. Do not override that boundary merely to create an operation×role allocation.**"* |
| **3** | *"INITIATE REQUEST"* had **no lawful representation**: `MM-FR-119` closes the request target set at `MM-PO-002` **or** `MM-PO-011`, so it cannot carry a request against `001`/`003`/`005`/`006`/`007`; and an `Initiate` action would breach `AUTH-7.24` | *"**V1 does NOT authorize a new INITIATE action.** TR-4 Student is **DENY** for `MM-PO-001`, `MM-PO-003`, `MM-PO-005`, `MM-PO-006` and `MM-PO-007` under the current closed authorization vocabulary. **Do NOT widen `MM-FR-119` in this act.** Record the absence of student self-service/request authority as a deferred product gap … **Do not invent a request type, action, permission, or workflow.**"* |

⭐⭐ **All three resolutions are RESTRICTIVE.** ⛔ Not one widens a role, relaxes a frozen rule, or creates
vocabulary to make an allocation fit. ⭐ **Two of the nine operations ended MORE restricted than the first
draft of the decision proposed** (`MM-PO-001` lost `TR-2`/`TR-3`; `MM-PO-008` lost `TR-3`), and the Student
initiation limb was withdrawn entirely rather than represented by an invented mechanism.

### 2.3 What changed from the first draft of the decision, and why it is recorded

⚠️ The Product Owner's **first** allocation proposed `MM-PO-001` = ALLOW for `TR-1`/`TR-2`/`TR-3`, `MM-PO-008` =
ALLOW for `TR-3` *"subject to the already-established field restriction"*, and *"INITIATE REQUEST"* for `TR-4`
on five operations. ⭐ **Those were tested against frozen sources, found to conflict, reported, and superseded by
§2.2 — they are recorded here so the audit trail shows the decision was CHALLENGED before it was executed**, not
transcribed uncritically. ⛔ **The superseded draft carries no authority and is not the allocation.**

⚠️ **One further defect in the first draft is disclosed:** it assigned *"TR-4: INITIATE REQUEST — Self"* to
**`MM-PO-001`**, which creates a **plan** — a tenant-level catalogue object with **no `Self` resource**, so the
row was incoherent on its own terms as well as unrepresentable. ⛔ Resolved by conflict 3's blanket `TR-4` DENY.

---

## 3. Authorization treatment

### 3.1 Every invariant re-verified against this allocation

| Invariant | Holds | Authority |
|---|---|---|
| ⛔ No role inheritance; no *"and above"* | ✅ | Every cell in §2.1 states one role explicitly — `AUTH-7.35` · `AUTH-7.28` · `AP-7` |
| ⛔ No permission derived from hierarchy or seniority | ✅ | ⭐ **The decisive point:** the allocation is **decided**, not derived — `AP-4` / `AUTH-7.7` |
| ⛔ No permission implied by another | ✅ | `AUTH-7.24` · `AUTH-7.25` |
| ⭐ **Approve** and **Export** granted only explicitly | ✅ | ⛔ **This ADR grants NO Approve and NO Export to any role** — `AUTH-7.25` |
| ⭐ Every grant carries a scope | ✅ | `AUTH-7.26` — all 45 cells carry `Tenant`, `Self`, `Linked` or DENY |
| ⭐ Scopes narrow, never widen (`Self` ⊂ `Linked` ⊂ `Tenant`) | ✅ | `AUTH-7.29` — `TR-4` never exceeds `Self`; `TR-5` never exceeds `Linked` |
| ⛔ `TR-3` Reception receives **no** financial permission | ✅ | ⭐ **`MM-PO-008` = DENY** — `AC-7.8` upheld **literally**, not narrowed |
| ⛔ `TR-2` Manager crosses **no** commercial boundary | ✅ | ⭐ **`MM-PO-001` = DENY** — `prd-v2/02` §2.4.1 upheld |
| ⛔ `TR-5` Parent is **read-only** and reaches only linked students | ✅ | ⭐ `TR-5` appears **only** with **Read** at `Linked`, on `MM-PO-008`/`010`; ⛔ **DENY on all nine others** — `prd-v2/02` `TR-5` *"Read-only … Cannot act on a student's behalf"* |
| ⛔ `TR-4` Student holds no `Tenant` authority | ✅ | `TR-4` appears **only** with **Read** at `Self`; `AC-7.10` |
| ⭐ Deny-by-default for anything unstated | ✅ | `AP-3` — and ⭐ **every one of the 45 cells is stated**, so nothing rests on silence |
| ⭐ Action vocabulary unchanged | ✅ | Only **Create · Read · Update**, all in `prd-v2/07` — ⛔ **no `Initiate`, no new class** |
| ⭐ Scope vocabulary unchanged | ✅ | Only **`Self` · `Linked` · `Tenant`**, all in `prd-v2/07` — ⛔ **`Platform` deliberately unused** |

### 3.2 What is NOT created

⛔⛔ **Zero permission identifiers.** ⛔ No `PERM-*`, no dotted token, no category–action pair, no provisional
name, no placeholder, **no example**. `AUTH-7.22` remains **closed at zero enumerated permissions**, exactly as
`ADR-0132` retained it, and ⭐ **`ADR-0043` L177's *"do not invent a new permission ID"* is satisfied by
construction, not by exception.**

⛔ No new action class · no new scope class · no new role · no new `MM-PO-*` entry (**still 11**) · no new event
(**still 7**) · no new configurable (**still 9**) · no new aggregate · no bounded context · no edge · no rank.

### 3.3 ⭐ Why this is an *allocation*, not a *minting* — the distinction that keeps `ADR-0132` §7 closed

⭐⭐ **Minting** creates a **named permission** that must live in the `AUTH-7.22` catalogue and carry a category,
an action class and a mandatory scope as an **identifier**. ⭐ **Allocating** states, for a capability that
already exists as a **protected operation**, which existing role may exercise it at which existing action and
scope — evaluated at request time through `identity.policy_decision`, ⛔ **stored nowhere and named nothing**.

⛔ **`ADR-0132` §7's seven prerequisites govern the former and are NOT engaged here** — there is no naming
convention to decide (prerequisite 2), no catalogue home needed (3), no per-permission category to assign (5),
and ⛔ **no supersession of `ADR-0043` §5.1 is required (7, *"the hard gate"*), because nothing is minted.**
⭐ Prerequisite **6**'s burden — *"a demonstration, per permission, that the requirement **cannot** be met by the
§5.3 derived mechanism"* — is **inapplicable in the affirmative sense and satisfied in the negative**: all
eleven operations **are** met by the derived mechanism, which is precisely why no permission is needed.

---

## 4. `G-8` — CLOSED, in the negative

⭐⭐ **`ADR-0149` §9 raised `G-8`** and left it open with **Owner: Product Owner + Authorization (`BC-18`/`PRD-001`)
Owner**: `MM-PO-008` *"Includes price snapshot"* and `MM-PO-003` carried *"Reception class and above"*, while
`AC-7.8` denies Reception financial permissions.

### 4.1 The resolution

⭐ **`MM-PO-008` `TR-3` = DENY.** The gap is closed **by upholding `AC-7.8`, not by qualifying it.** ⛔ The
tempting route — allowing `TR-3` a field-restricted read that hides the price — was **expressly refused by the
Product Owner** (*"Do NOT invent a new field restriction to make this operation allowable"*), and it would have
been unlawful anyway: ⚠️ the `D-7` field restriction (`MM-FR-131`) is scoped to **change requests**, ⛔ **not to
`MM-PO-008` membership detail**, so extending it would have been a **new product decision disguised as a
preservation**.

⭐ **`MM-PO-003` `TR-3` = ALLOW is consistent with `AC-7.8`, and that was tested rather than assumed.**
`MM-PO-003` **creates** a membership; ⛔ it is not the operation that *"includes the price snapshot"* — that is
`MM-PO-008`, now denied to `TR-3`. ⚠️ **Disclosed honestly:** `MM-FR-040` persists a `priceSnapshot` on creation
and `PRD-005` **L1444** requires the creation flow to *"show the amount applicable"*. ⭐ **This ADR does not
decide what the creation surface may display to `TR-3`** — that is a **surface-composition** question for the
Design Doc and `BC-18` at request time, ⛔ **not an operation×role allocation** — and `AC-7.8` binds it
independently of anything decided here. ⭐ **The allocation grants `TR-3` the operation, not any field.**

⛔ **`AC-7.8` is NOT weakened, narrowed, qualified or reinterpreted, and `prd-v2/07` is byte-unchanged.**

---

## 5. `MM-GAP-011` — the deferred Student self-service gap, OPENED here

⭐⭐ **Recorded, not silently dropped.** The Product Owner's first draft intended Student *initiation* on five
operations; conflict 3 established that **no lawful representation exists in V1**. ⭐ The consequence is stated
as a **gap rather than concealed by a DENY that looks like a considered product position**:

| ID | Question | Owner | Blocking? |
|---|---|---|---|
| **`MM-GAP-011`** | **Student (`TR-4`) self-service / request authority for `MM-PO-001`, `MM-PO-003`, `MM-PO-005`, `MM-PO-006` and `MM-PO-007`.** V1 is **DENY** because the closed request workflow (`MM-FR-119`) admits only `MM-PO-002` and `MM-PO-011` as target operations, and ⛔ no `Initiate` action exists in the closed vocabulary. Whether V2 should widen that target set, and for which operations, is undecided | **Product Owner** + **Authorization (`BC-18`) Owner** | ⛔ **No — NON-BLOCKING.** `AP-3` deny-by-default already makes V1 behaviour safe and defined |

⭐ The identifier is **measured free**: `MM-GAP-011` returns **0** occurrences in `PRD-005`; the register runs
`MM-GAP-001`…`MM-GAP-010` plus three suffixed successors. ⛔ **It is allocated by the v1.6 amendment (§8), not
by this ADR**, which edits nothing.

---

## 6. Options considered and rejected

| Option | Rejected because |
|---|---|
| **Read *"Reception class and above"* as `TR-3`+`TR-2`+`TR-1`** | ⛔ **Forbidden outright.** `AP-4`/`AUTH-7.7` bars deriving permission from *"hierarchy, seniority"*; `AUTH-7.28` bars permission hierarchies. ⭐ It **looks** like reading and **is** inventing an ordering |
| **Read *"Elevated"* as `TR-1`-only** | ⛔ Measured **0** definitions of *"Elevated"* as a role set; any expansion invents one |
| **Give `TR-3` a field-restricted `MM-PO-008`** | ⛔ Expressly refused by the Product Owner; and `D-7`/`MM-FR-131` is scoped to **change requests**, not membership detail |
| **Add an `Initiate` action class** | ⛔ Breaches the closed action vocabulary and `AUTH-7.24`; expressly refused |
| **Widen `MM-FR-119`'s target set to carry student requests** | ⛔ Expressly refused *"in this act"*; deferred as `MM-GAP-011` |
| **Mint `PERM-*` identifiers for the eleven** | ⛔ `ADR-0043` L177; `ADR-0132` §7 prerequisite 7's hard gate; ⭐ and **unnecessary** — the derived mechanism carries it |
| **Record the allocation in `DD-0001`** | ⛔ A Design Doc is **UNRANKED** and *"never authority"*; ⭐ the allocation must be Rank 3 |
| **A new PRD for `BC-02` authorization** | ⛔ `PRD_LIFECYCLE.md` **L67** — *"It is an amendment to that PRD, not a new one"* |

---

## 7. What this ADR does NOT decide

⛔ It does **not** decide which **fields** any surface may display to any role — that is surface composition plus
`BC-18` at request time (§4.1).
⛔ It does **not** resolve `MM-GAP-011`, which it **opens** (§5).
⛔ It does **not** touch `MM-PO-002` or `MM-PO-011`, governed by `ADR-0149` (§2.1).
⛔ It does **not** amend `AUTH-7.22`, `ADR-0132`, `ADR-0043`, `ADR-0149`, `PRD-001`, `PRD-004`, `PRD-023` or the BC Map.
⛔ It does **not** confer implementation authority; ⛔ **0 lines of code** follow from it.
⛔ It does **not** close `DD-0001-GAP-001`, `MM-GAP-004`, `MM-GAP-005`, `MM-GAP-010`, `MM-GAP-010a`, `SM-GAP-4` or `SM-GAP-5`.
⛔ It does **not** mark `DD-0001` Declaration 3 `PASS` — ⭐ it supplies the **source**; the **declaration** is
`DD-0001`'s own act, and `PASS` requires *"declared **and** sourced"* (README §2B.5).

---

## 8. Execution — the `PRD-005` v1.6 amendment

⭐ This ADR is **Rank 2** and competent to allocate. ⛔ **A Design Doc cannot hold the allocation and an ADR is
not where module requirements live**, so it is executed into Rank 3 by a `PRD-005` **v1.5 → v1.6** successor
amendment under `PRD_LIFECYCLE.md` **§4**, whose seven steps are: ADR **first** → Accept → increment version →
changelog same commit → `DOCUMENTATION_BASELINE.md` same commit → `TRACEABILITY_MATRIX.md` **if identifiers
changed** → `PRD_REGISTRY.md`.

⭐ **L67 bars a new PRD** (*"It is an amendment to that PRD, not a new one"*); ⭐ **L177 bars only *silent*
modification**, which a seven-artifact governed route is the antithesis of; ⛔ **`FROZEN` and Rank 3 are
retained** — §4 amends a frozen PRD, it does not thaw one.

⭐ **What v1.6 adds:** a new **§16.3b** carrying the complete eleven-operation matrix, and **`MM-GAP-011`** in
§25.2. ⛔ **`MM-PO-*` stays 11 · `MM-EVT-*` stays 7 · `MM-CFG-*` stays 9 · `PERM-*` stays 0.**

---

## 9. Number allocation

⭐ **`ADR-0150` is allocated by measurement, not by assumption.** Highest file on disk: **`ADR-0149`**.
`ADR-0148` is consumed as a withdrawal-trail name (`ADR-0147` §2.3) and ⛔ **is not reused**. `ADR-0150` was
probed repository-wide: **1** occurrence, inspected at its line — `ADR-0149` **L581**, *"`ADR-0148` and
`ADR-0150` are **neither allocated nor reserved** by this act"* — ⭐ **an express non-allocation, therefore
free.** `ADR-INDEX` **L206**'s rule *"Never reuse a number"* is satisfied; **0** files named `ADR-0150` existed.

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The complete `BC-02` operation×role authorization allocation is established for all eleven `MM-PO-*` operations** — the nine previously uncovered ones decided explicitly by the **Product Owner**, formalised by the **Authorization (`BC-18`) Owner**, both under one-act conferrals ⛔ **reverting on completion**. ⭐⭐ **The allocation is DECIDED, not derived** — which is the whole point: *"Reception class and above"* and *"Elevated"* could **not** lawfully be read into role sets, because `AP-4`/`AUTH-7.7` bars deriving permission from *"hierarchy, seniority"* and `AUTH-7.28` bars permission hierarchies. ⚠️⚠️ **THREE CONFLICTS WERE RAISED AGAINST FROZEN TEXT BEFORE ANYTHING WAS WRITTEN, AND ALL THREE WERE RESOLVED RESTRICTIVELY** (§2.2): `MM-PO-008` `TR-3` → **DENY** (upholding `AC-7.8` literally rather than inventing a field restriction); `MM-PO-001` `TR-2`/`TR-3` → **DENY** (preserving the frozen commercial-configuration boundary and staying consistent with `ADR-0149` `D-2`); *"INITIATE REQUEST"* → **withdrawn**, `TR-4` DENY on five operations, ⛔ **no `Initiate` action invented and `MM-FR-119` NOT widened**. ⭐ **Two operations ended MORE restricted than first proposed**, and ⚠️ **the superseded first draft is recorded at §2.3** so the trail shows the decision was **challenged, not transcribed**. ⭐⭐ **`G-8` is CLOSED in the negative** (§4). ⭐ **`MM-GAP-011` is OPENED** (§5) — Student self-service authority deferred, **NON-BLOCKING** under `AP-3`. ⛔⛔ **`AUTH-7.22` closed at ZERO; 0 `PERM-*`; no action, scope or role vocabulary created; `ADR-0132` §7 NOT engaged** (§3.3 — allocation ≠ minting). ⛔ **`ADR-0149`'s `MM-PO-002`/`MM-PO-011` allocation preserved unchanged.** ⛔ **NOTHING IS EDITED BY THIS ADR** — execution is the governed `PRD-005` **v1.6** §4 amendment (§8). ⭐ Number allocated by measurement (§9). |
