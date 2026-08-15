# `ADR-0041` — `PRD-008` Freeze-blocker **preparation and routing**: `ADR-0039` made ripe for acceptance, one Rank 6 correction drafted, seven questions routed — and **nothing decided**

| Field | Value |
|---|---|
| **ADR** | `ADR-0041` |
| **Title** | Preparation, not decision: (i) the measured finding that `ACCEPTED` `ADR-0040` has removed the sole stated impediment to `ADR-0039`'s acceptance, (ii) the **minimum lawful correction** to the Rank 6 Enterprise Architecture for `Refunds (V2)`, **drafted and left unapplied**, and (iii) the exact decision questions for the seven `FEE-GAP-*` limbs that require a named authority |
| **Status** | **`PROPOSED`** — and **deliberately not self-accepted**, for a reason narrower and more important than caution. This ADR **contains no decision**. It records measurements and drafts instruments for other parties to execute. If it were `ACCEPTED` it would assert that its **preparations are themselves determinations**, which is precisely the substitution it exists to prevent. `PRD_OWNERSHIP_MODEL.md` **L85** reserves *"ADR approval"* to the **Architecture Owner**; **L68** reserves *"a decision that changes structure, ownership, a boundary"* to the same role. **Neither role was conferred for this pass.** |
| **Date** | 2026-08-15 |
| **Decision by** | **Nobody.** This is the first ADR in this series with an empty decision field, and the emptiness is the point. Every substantive question below is left with a **named authority** and an **exact question**. |
| **Amends** | **Nothing.** No frozen document, no Rank 1-6 document, no `ACCEPTED` ADR, no `PROPOSED` ADR, no checker, no manifest, no register. `ADR-0039`'s `Status` row is **byte-unchanged and still reads `PROPOSED`**. |
| **Supersedes** | Nothing. It **prepares** `ADR-0039` for a decision by its proper authority and **withdraws none** of `ADR-0039`'s reasoning. |

---

## §1 What this ADR is, and the one thing it must not be mistaken for

The instruction under which this ADR is written was explicit about its own limits:

> *"Resolve **only what is now lawfully actionable** … **Do NOT self-accept ADRs or invent authority decisions** … **Prepare** `ADR-0039` for Architecture Owner acceptance, but **DO NOT self-accept it** … **Prepare the minimum lawful correction** … but **DO NOT apply an Architecture Owner decision yourself** … Do **NOT** mark any gap `RESOLVED` without valid authority."*

**Preparation and decision are different acts, and the difference is not stylistic.** A prepared instrument is one an authority can execute in a single step without further analysis. A decision is the execution. This ADR does the first and refuses the second, and the refusal is recorded as a finding rather than an apology, because **the value of a routing record is destroyed the moment its author also answers the questions it routes.**

### 1.1 What is lawfully actionable in this pass — the honest answer is: two things, and neither closes a blocker

| Act | Lawful here? | Why |
|---|---|---|
| **Measure** whether `ADR-0040` removed `ADR-0039`'s stated impediment | ✅ Yes | Measurement of existing `ACCEPTED` text creates no obligation |
| **Draft** the Rank 6 EA correction as exact before/after text | ✅ Yes | A draft binds nothing; `DOCUMENTATION_BASELINE.md` **§7 step 1** requires *"an ADR **before** the change"*, and this is that ADR — **`PROPOSED`**, so the change may not yet be made |
| **Accept** `ADR-0039` | ⛔ **No** | Architecture Owner act (`PRD_OWNERSHIP_MODEL.md` L85) |
| **Apply** the EA correction | ⛔ **No** | Rank 1-5/6 document change; L85 assigns *"any Rank 1-5 document change"* to the Architecture Owner, and a Rank 6 correction mandated by Rank 1 `MP-CON-08` is that role's act |
| **Mark any gap `RESOLVED`** | ⛔ **No** | No authority was conferred; the instruction bars it twice |
| **Freeze `PRD-008`** | ⛔ **No** | `PRD_LIFECYCLE.md` **L152+**: *"Freeze is **conferred, not claimed**"* |

**Net effect on the Freeze blocker count: 10 → 10.** Stated first, before any of the work below, so that no reader mistakes volume of preparation for progress through the gate.

---

## §2 ✅ `ADR-0039` §2 is **fully resolved** by `ACCEPTED` `ADR-0040` — measured, not assumed

`ADR-0039` is `PROPOSED`. Governance practice would normally require an investigation into *why*. **It does not here, because `ADR-0039` stated its own impediment in one sentence**, at §9 (L291-L294):

> **"`ADR-0039` should be `ACCEPTED` — the principal gave the decisions."**
> *"The **decisions** are the principal's and are recorded as given. **Acceptance of the ADR is a separate act**, and **§2 contains an unresolved Architecture Owner question**. Accepting a record that contains an open architectural conflict would bind the parts that are settled *and* the part that is not."*

**The impediment is therefore a single, named, falsifiable condition: §2's Architecture Owner question must cease to be unresolved.** That is a measurable claim, and it was measured.

### 2.1 The question §2 actually asked

`ADR-0039` §2.4 (L88-L90) stated the required authority act in two parts:

> *"**Required authority:** **Architecture Owner** — **to state whether §5.5b stands (expected) or is amended**, and **separately to authorise a webhook contract**."*

**Two limbs, and they must be scored separately.** Conflating them is the trap: the first is an *ownership* question, the second a *contract* question, and `ADR-0039` itself insisted on the distinction — §2.4: *"**An owner is not a contract.**"*

### 2.2 Limb 1 — the ownership question: **CLOSED**

| Evidence | Location | Text |
|---|---|---|
| `ADR-0040` `Status` | L7 | *"**`ACCEPTED`** — recording a decision **conferred directly by the human principal acting as Architecture Owner**"* |
| `ADR-0040` `Supersedes` | **L11** | *"Nothing. It **closes** `ADR-0039` §2's reported conflict by determining it, and **confirms** `ADR-0039` §2's refusal to determine it as having been correct at the time."* |
| `ADR-0040` §1 | L17-L20 | *"`ADR-0035` §5.5b **STANDS**. The inbound payment webhook is owned by **`platform/business`**. The alternative reading — `platform/integration` — is **NOT adopted**"* |
| `ADR-0040` §1.3 | L65 | Routing owner: *"✅ **NOW DETERMINED — `platform/business`**"* |

**§2 asked the Architecture Owner "to state whether §5.5b stands (expected) or is amended". `ADR-0040` §1 states that it stands.** The question is answered in the exact terms in which it was asked, by the exact role `ADR-0039` named, in a document whose Status is `ACCEPTED`. **Limb 1 is closed.**

**Two further properties make this closure unusually clean, and both are recorded because they are the kind of thing a reviewer should not have to take on trust:**

1. **`ADR-0040` did not merely outrank the objection — it re-tested it.** §1.1 (L35-L40): §5.5b's reasoning *"was **re-tested against the manifest, not taken on trust**"*, confirming `platform/business` at rank 6 (`tool/module_dependencies.yaml` L406) with `ports: [platform/integration:payment_gateway]` (L409), a **caller → callee** relation. *"**The reason holds under re-measurement, so the decision is upheld on its merits and not merely on its rank.**"*
2. **`ADR-0040` preserved the evidence against itself.** §1.2 (L44-L47) records that `ADR-0035` **L442** — pre-conferral — itself proposed an inbound adapter *within* `platform/integration`, i.e. **the reading it declined**. A determination that suppressed its strongest counter-argument would be a weaker basis for closing §2 than one that published it.

### 2.3 Limb 2 — the contract question: **STILL OPEN, and `ADR-0040` says so itself**

This is the half a careless reading would lose. `ADR-0040` **§4** (L163-L165) is explicit:

| Still open | Owner | Why `ADR-0040` cannot close it |
|---|---|---|
| The webhook **wire contract** (endpoint, schema, signature, replay window, retry policy) | **`BC-31` owner**, once **`PRD-019`** exists | *"§2 — every candidate author is **barred today**; `PRD-019` is `PLANNED`"* |

**Re-measured at HEAD in this pass:** `PRD-019` **does not exist** — no file matches `docs/30-product/*/PRD-019*`. So limb 2 has no lawful author, which is the whole of §6 below.

### 2.4 The finding, stated exactly

> **`ADR-0039` §2's *conflict* is fully resolved. `ADR-0039` §2's *contract* observation remains true.**
>
> These are not in tension, because §2's own structure separated them. The **impediment to accepting `ADR-0039`** — recorded at its §9 as *"§2 contains an unresolved **Architecture Owner** question"* — **is removed**, because the question §2 routed to the Architecture Owner **has been answered by the Architecture Owner** in `ACCEPTED` `ADR-0040`.
>
> **The residual contract limb is not an impediment to acceptance**, for a reason that must be stated rather than assumed: `ADR-0039` §2 **never purported to decide the contract**. Accepting `ADR-0039` therefore binds a record whose §2 says *"a conflict is reported here and not resolved"* — and that statement, read together with `ADR-0040`, is now **historically accurate and complete**. `ADR-0040` L11 confirms exactly this: it *"**confirms** `ADR-0039` §2's refusal to determine it as having been **correct at the time**."*

### 2.5 ⚠ A second impediment, found in this pass, that `ADR-0039` did not know about — and it is a **defect in `ADR-0039`, not in `PRD-008`**

**This finding cuts against the convenience of this ADR and is recorded for that reason.** Had it not been measured, an Architecture Owner would have been invited to accept a record containing a table that is now **factually false**.

`ADR-0039` **§7.1** (L218-L227) asserts, as its measured Stage-4 position:

| `ADR-0039` §7.1 claim | Re-measured at HEAD (`PRD-008` v1.5, §36.1) | Verdict |
|---|---|---|
| `FEE-FR-028` — *"**`⛔ none`** (L1717)"* | **L1882**: `FEE-AC-085`, `086`, `087`, `088`, `089` | ⛔ **STALE** |
| `FEE-FR-042` — *"**`⛔ none`** (L1731)"* | **L1896**: `FEE-AC-090`, `091`, `092`, `093`, `095` | ⛔ **STALE** |
| `FEE-BR-019` — *"**`⛔ none`** (L1766)"* | **L1931**: `FEE-AC-091`, `093` | ⛔ **STALE** |
| `FEE-BR-007` — *"**`⛔ none`** (L1754)"* | **L1919**: `FEE-AC-096`, `097` | ⛔ **STALE** |
| *"**All four still carry `⛔ none`.** Check 1 therefore still fails, and **Stage 4 MUST NOT be run**"* (L227) | Stage 4 **was run** and **PASSED 6/6**; §36.1 rows containing `none` = **0** | ⛔ **SUPERSEDED BY EVENT** |

**Cause, and why this is not an error of authorship:** §7.1 was measured against `PRD-008` **v1.3**. The criteria it reports as absent were **written in v1.4/v1.5**, *"the `PRD-008` revision pass"* that §7.2 (L239) itself prescribed as the correct next step — *"decide (here) → specify in `PRD-008` → re-measure → then Stage 4."* **`ADR-0039` predicted its own supersession and named the mechanism.** The table is stale because the plan worked.

**Consequence for acceptance, and it is a real one:** `ADR-0039` §7's *verdict* (*"Stage 4 is still not runnable"*) is **no longer true**, while §3-§6's *decisions* are untouched and remain exactly as the Product Owner gave them. **An Architecture Owner asked to accept `ADR-0039` today must be told which parts they would be binding.** §4 below states it.

**⛔ This defect is NOT fixed here.** Editing another ADR's §7 to make it accurate would be (i) amending a record of a decision I did not make, and (ii) removing the evidence that the v1.4/v1.5 sequence occurred. `ADR-0039` is **byte-unchanged** at `59e31dc19013c125`.

---

## §3 The **minimum lawful correction** for the Rank 6 EA — DRAFTED, **NOT APPLIED**

`FEE-GAP-001`'s `Freeze` field (`PRD-008` **L2112**) states the blocker in terms that name the instrument, the authority and the prohibition:

> *"⛔ **STILL BLOCKS.** … The Rank 6 EA still reads **`Refunds (V2)`** at **L823**/**L1409** while Rank 4 BC Map **L100**/**L374**/**L422** reads V1, and **`MP-CON-08`** requires the **EA** to be corrected to match the higher rank, *"never the reverse"*. That is an **Architecture Owner** act, **not performed here**"*

### 3.1 Why a correction is *mandatory* and *not a choice* — the mechanical part, which is not a decision

| Source | Rank | Says |
|---|---|---|
| `MASTER_PRD.md` **L519** `MP-CON-08` | **1** | *"the higher-ranked document wins and **the Enterprise Architecture is updated to match** — never the reverse. A disagreement is a **defect to be raised**, not a choice to be made."* |
| `DOCUMENTATION_BASELINE.md` **L221** | — | Rank **6** = Enterprise Architecture v2.1 — *"**Descriptive only.** Update it to match 1-5; never the reverse"* |
| `DOCUMENTATION_BASELINE.md` **L139** | — | *"**Descriptive** — must follow the PRDs, never lead them"* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L100** | **4** | `BC-05` … *"Owns money owed by a **student to the library**: fee structures, dues, receipts, discounts, **refunds**, cash reconciliation."* Release **V1** |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L374** | **4** | `FeeLedger` members include **`RefundRecord`**; invariant *"**refund ≤ received**"* |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L422** | **4** | `BC-05` publishes **`fee.RefundIssued`** to `BC-26`, `BC-24` |
| `PRD-005` **L942** | **3, FROZEN** | a payment for a voided membership *"**MUST** be recorded and surfaced in the reconciliation queue for a **refund decision by `BC-05`**"* |

**The direction of correction is therefore mechanical: Rank 6 yields to Rank 4 and Rank 1.** `MP-CON-08` removes the discretion in terms (*"not a choice to be made"*). **What is NOT mechanical is the act of editing the file**, which `PRD_OWNERSHIP_MODEL.md` **L85** assigns to the **Architecture Owner** (*"any Rank 1-5 document change"*), and which `DOCUMENTATION_BASELINE.md` **§7 step 1** conditions on *"an ADR **before** the change"*.

### 3.2 The exact edit — one line, one token

Re-measured at HEAD. `LIBOORA_ENTERPRISE_ARCHITECTURE.md` is **131649 bytes, 2525 lines**, `v2.1`, Status *"Reviewed & Refined — Approved for Implementation"*, and **appears in no frozen baseline row**. The string `Refund` occurs **exactly twice** in the file, at **L823** and **L1408**.

**PROPOSED EDIT — one line only:**

| | Value |
|---|---|
| **File** | `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` |
| **Line** | **823** |
| **Enclosing block** | `LAYER 2 — DOMAIN PLATFORMS` (banner L677-L679) → `LIBRARY MANAGEMENT PLATFORM (V1)` (L681) → `Revenue & Finance (V1)` (**L818**) |
| **Before** (verbatim, box-drawing preserved) | `│   ├── Refunds (V2)` |
| **After** | `│   ├── Refunds (V1)` |
| **Delta** | **One character class: `V2` → `V1`.** No line added, none removed, no re-indentation, no `← NEW` marker, no annotation |

**That is the whole of the minimum correction.** Nothing else in the EA is proposed for change by this ADR.

### 3.3 ⚠ Why **L1408 is deliberately EXCLUDED** — and this is the most important paragraph in §3

`PRD-008` **L2112** names *"**L823**/**L1409**"* as the two offending lines. **Both citations were re-measured, and one is wrong while the other should not be corrected at all.**

**(i) The line number is wrong.** `Refund Management (V2)` is at EA **L1408**, not L1409. L1409 reads `│   ├── Payment Retry (V2)`. This is a pre-existing citation defect in `PRD-008` (the same class already disclosed at its L799), **left unfixed here** because `PRD-008` is not this ADR's to edit.

**(ii) More significantly, L1408 is in a different platform and is not obviously a conflict at all.** Measured by walking the enclosing tree structure inside the EA's single fenced block (L238-L2372):

| EA line | Text | Enclosing banner | Owning platform |
|---|---|---|---|
| **L823** | `│   ├── Refunds (V2)` | **L678 `LAYER 2 — DOMAIN PLATFORMS`** | **`LIBRARY MANAGEMENT PLATFORM (V1)`** (L681) → `Revenue & Finance (V1)` (L818) |
| **L1408** | `│   ├── Refund Management (V2)` | **L1349 `LAYER 4 — BUSINESS & ENGAGEMENT`** | **`BUSINESS PLATFORM (V1)`** (L1352), inside the gateway block: `Payment Gateway Abstraction (V1)` L1404, `Razorpay (V1)` L1405, `Payment Verification (V1)` L1406, `Webhook Reconciliation (V1)` L1407 |

**L823 is `BC-05`'s own domain capability.** Rank 4 BC Map L100 puts *"refunds"* inside `BC-05`, a **Library Management** context, at **V1**. L823 contradicts that directly. **This is the conflict, and correcting it is the minimum.**

**L1408 is a `BUSINESS PLATFORM` gateway capability** — *"Refund Management"* sitting beside `Payment Gateway Abstraction`, `Razorpay`, `Payment Verification` and `Webhook Reconciliation`. **Whether a payment **gateway** must expose a refund **API** in V1 is a different question from whether `BC-05` may issue a refund**, and no Rank 1-5 document this pass measured states the answer. Notably, `ADR-0039` §3's decided V1 refund scope is *"the original financial record is **immutable**; the refund is a **separate financial operation**"* and *"a **cash** refund must also be **server-recorded**"* — **a compensating ledger entry, which requires no gateway refund call at all**.

> **Therefore L1408 is NOT proposed for correction, and the omission is deliberate.** Changing it would (i) exceed the minimum, (ii) decide a **gateway capability tier** that no ranked document decides, and (iii) do so inside `platform/business`, whose ownership `ACCEPTED` `ADR-0040` has just settled — making it exactly the sort of quiet architectural act this pass is forbidden to perform.
>
> **It is instead ROUTED**, as `FEE-GAP-001`-adjacent question **Q-EA-2** in §4, to the same Architecture Owner who must apply the L823 edit. **If they determine that L1408 is also a defect, correcting it is one further token; if they determine it is a genuine V2 gateway capability, the EA is already right.** This ADR does not pre-empt either answer.

### 3.4 What executing §3.2 would and would not achieve

| | |
|---|---|
| ✅ Would remove | The Rank 6 vs Rank 4 contradiction on **`BC-05` refund tier** — the sole stated cause of `FEE-GAP-001`'s `Freeze` field |
| ⛔ Would **not** by itself close `FEE-GAP-001` | Its `Authority` row (**L2109**) reads *"**Product Owner** (tier) **+ Architecture Owner** (BC Map event table)"*. The Product Owner half is **already given** (`ADR-0039` §3). The Architecture Owner half is this edit **plus** confirmation that BC Map L422's `fee.RefundIssued` needs no V2 marking — which, on the V1 determination, it does not. **Both halves must be recorded by their owners before the gap's `Status` may move.** |
| ⛔ Would **not** be lawful today | `DOCUMENTATION_BASELINE.md` §7 step 1 — *"a change to any Rank 1-5 document requires an ADR **before** the change"*. **This ADR is `PROPOSED`. A `PROPOSED` ADR is not that ADR yet.** |
| Also required in the same commit, per §7 steps 2-3 | EA version increment + changelog entry, and a `DOCUMENTATION_BASELINE.md` §3.2 row update. **Both are Architecture Owner / Governance Owner acts and neither is drafted here**, because drafting a version bump for a decision that may not be taken would create a record of a change that never happened. |

---

## §4 Routing — the exact question each authority must answer

**Format note:** each question is stated so that it can be answered without further analysis, and each records *what is already settled* so no authority is asked to re-decide something. **No `Recommended` line below is a decision** — `PRD-005` §7.4: a recommendation inside an open question *"is not a decision"*.

### 4.1 → **Architecture Owner**

| # | Gap | Exact question | Already settled (do not re-decide) | Effect if answered |
|---|---|---|---|---|
| **Q-A1** | — | **Do you accept `ADR-0039`?** Specifically: its **§3-§6 decisions** (refund scope, fee types, append-only corrections, due-date offset `0`) and its **§2 report**. Note **§2.5 above**: its **§7.1 table is stale** and its §7 verdict *"Stage 4 MUST NOT be run"* is superseded by event — Stage 4 **ran and passed 6/6**. **Acceptance should therefore be recorded as binding §3-§6 and §2-as-a-report, with §7 noted as historical.** | The four decisions are the **Product Owner's**, already given and recorded. §2's conflict is **closed** by your own `ACCEPTED` `ADR-0040`. | `ADR-0039` `PROPOSED` → `ACCEPTED`; the recorded basis of `FEE-GAP-004`, `005`, `006` becomes binding |
| **Q-A2** | `FEE-GAP-001` | **Apply §3.2**: EA **L823** `Refunds (V2)` → `Refunds (V1)`, per `MP-CON-08` and baseline L221. Confirm also that BC Map **L422** `fee.RefundIssued` requires **no** V2 marking (on the V1 determination it does not) | Direction is **mechanical**, not discretionary (`MP-CON-08`: *"not a choice to be made"*). Product-Owner **tier** decision already given (`ADR-0039` §3) | Removes the sole stated cause of `FEE-GAP-001`'s `Freeze` field |
| **Q-EA-2** | `FEE-GAP-001`-adjacent | **Is EA L1408 `Refund Management (V2)` — a `BUSINESS PLATFORM` *gateway* capability — also a defect, or a correct V2 tier?** See §3.3: it is in a **different platform** from L823, and `ADR-0039` §3's compensating-entry model may need **no gateway refund API** in V1 | Nothing. **This question is genuinely open and is not answered anywhere.** | Either one further token in the EA, or a recorded finding that the EA is already correct — **and either way, `PRD-008` L2112's citation of *"L1409"* is a defect: the line is L1408** |
| **Q-A3** | `FEE-GAP-009` | **Is `Invoice` a distinct aggregate, or the issued form of `FeeDue`?** BC Map **L204** equates `BC-05`'s *"Invoice"* with **`FeeDue`**; BC Map **L374** lists **five** `FeeLedger` members and *Invoice* is **not** one; **but** EA **L1413** lists *"Invoice Generation (V1)"* as a capability separate from receipts. **Determines whether `PRD-008` §29.3 is a real state machine or a projection of §29.1.** | `PRD-008` already *"takes the Rank 4 reading and says so"* (L2220), which is why this does not block Stage 4 | Closes `FEE-GAP-009`'s `Freeze` field — *"two state machines for one concept is a modelling defect"* |
| **Q-A4** | `FEE-GAP-012`(b) | **`BC-26` is a `fee.*` consumer in BC Map §9 but has no `E-*` edge in §7. Add an edge, or apply the `MM-GAP-010` precedent?** | `ADR-0033` settled that BC Map L292 *"**governs edges** … does **not** state that every cross-context read must be an edge"* | Closes limb (b). **Note:** `PRD-008`'s own `Recommended` is *"follow the `MM-GAP-010` precedent — **do not list it as a publish target** until an edge exists"* — i.e. **no edge invented** |

**Recommended for Q-A3** *(recorded as `PRD-008` L2222 already recommends, and not as a decision)*: confirm the Rank 4 reading — invoice = issued representation of `FeeDue`, **no sixth aggregate member**.

### 4.2 → **Product Owner**

| # | Gap | Exact question | Already settled | Blocking |
|---|---|---|---|---|
| **Q-P1** | `FEE-GAP-003` | **Is bank transfer (NEFT/IMPS) a V1 payment method for `BC-05`?** Named in **no** source: not BC Map L202 (*"cash/UPI"*), not EA L1395-L1401 (Online/Cash/UPI/Card), not `MASTER_PRD.md`, not any frozen PRD. **If omitted, staff will record NEFT as cash and corrupt method-based reporting.** | Nothing — this is a **clean omission**, not a conflict, which is why it does not block Stage 4 | **Freeze** — *"a method used in practice but unrepresentable is a V1 defect"* |
| **Q-P2** | `FEE-GAP-007` | **Two parts. (a) Which named roles are "authorised approvers" for a discount?** BC Map **L374** requires *"an authorised approver role"* **without naming it**. **(b) Is there a maximum discount percentage, ceiling or range?** No source approves one. | The **approver-role requirement itself** is specified (`FEE-FR-039`), which is why Stage 4 is unaffected. **A `FEE-CFG-*` register cannot be opened without (b)** — `PRD-008` L85-L88: *"**No configuration register is declared**"* | **Freeze** |
| **Q-P3** | `FEE-GAP-012`(c) | **Is `Financial Reports` V1 or V2?** EA **L814** says **(V2)** — inside `LAYER 2` reporting, beside `Growth Reports (V2)`; EA **L1423** says **(V1)** — inside `LAYER 4 BUSINESS PLATFORM`, beside `Revenue Analytics (V1)`. **Both are Rank 6, so `MP-CON-08` cannot arbitrate: there is no higher-ranked statement to yield to.** | Nothing | **Freeze** (as part of `FEE-GAP-012`) |

**Recommended for Q-P1** *(`PRD-008` L2144, not a decision)*: approve bank transfer as a **staff-attested** method, same class as out-of-band UPI (`FEE-BR-011`) — needs no gateway, so **not entangled with `FEE-GAP-002`**.
**Recommended for Q-P2** *(`PRD-008` L2197, not a decision)*: name the roles explicitly; add a ceiling **only** if a range is approved — *"otherwise rely on the approver control, as `PRD-006` did when it refused an unapproved configurable"*.

### 4.3 → **Product Owner + Security / Compliance** *(jointly — neither alone suffices)*

| # | Gap | Exact question | Why joint |
|---|---|---|---|
| **Q-S1** | `FEE-GAP-011` | **(a) How long must `BC-05` financial records be retained? (b) May anything ever be purged, and under what condition?** No source states a retention period. **`FEE-XC-011` therefore currently forbids purging entirely — and that absolute rule may itself be non-compliant.** | Retention is a **compliance** determination with a **product** consequence. `PRD-008` L2242-L2243: *"Product Owner + Security/Compliance"* / *"**REQUIRES PRODUCT OWNER + REQUIRES SECURITY**"* |

**Recommended** *(`PRD-008` L2247, not a decision)*: obtain a compliance position **before** freeze. *(`PRD-006` left retention explicitly undefined for the same reason.)*
**Note for the Compliance authority:** Indian statutory retention may apply to fee records. **This ADR names no period, no statute and no jurisdiction rule** — doing so would be inventing a financial/compliance rule, which the instruction bars.

### 4.4 → **Governance Owner**

| # | Gap | Exact question | Effect |
|---|---|---|---|
| **Q-G1** | `FEE-GAP-012`(a) | **`PRD_REGISTRY.md` L245 records `PRD-008` as `PLANNED` while the document is a v1.5 DRAFT that has PASSED Stage 4. Who moves it to `DRAFT`, and will you record the move?** | Closes limb (a) — a **status-legitimacy** defect, not a content one |

### 4.5 ✅ `FEE-GAP-012`(d) — **already discharged, and recorded here so it is not re-routed**

| Limb | Status | Evidence |
|---|---|---|
| (d) *"No `prd008_traceability` gate exists, so §36.1's counts are hand-measured"* | ✅ **DISCHARGED** in commit `420467c` | `tool/docs_check/prd008_traceability.py` — **exit 0**. Reproduces every declared count: **134** obligation-bearing (`FR 62 + BR 28 + INV 10 + EVT 3 + XC 23 + PO 8`), **134** §36.1 rows, **98** acceptance criteria declared and used, **17** gap blocks, **10** blocking Freeze, **0** blocking Stage 4 |

**⛔ `FEE-GAP-012` as a whole remains OPEN**, because limbs (a), (b) and (c) are unanswered. **A gap with four limbs is not three-quarters closed; it is open.**

---

## §5 ⚠ The gap ledger is **NOT edited by this ADR** — and that is a deliberate refusal

**No `FEE-GAP-*` block's `Status`, `Stage 4` or `Freeze` field is touched.** `PRD-008` is **byte-unchanged** at `f85340a3c468e174`.

**Why, when routing is arguably "progress" worth recording in the ledger:** a gap's `Status` field asserts something about **authority**, not about effort. Writing *"ROUTED"* into ten blocks would make the ledger record my activity rather than the gaps' condition, and a reader scanning for *"what still needs a decision"* would have to subtract my annotations to find the answer. The gaps' **existing** `Owner` and `Authority` rows already name every party correctly — measured this pass, all ten agree with §4 above. **The ledger was already right; it needed routing, not editing.**

**This also preserves a property worth keeping:** `prd008_traceability.py` derives *"gaps blocking Freeze"* from each block's own leading `Freeze` verdict. It reports **10**. If routing notes were added and the count moved, the movement would be an artefact of prose, not of governance.

---

## §6 ⛔ `FEE-GAP-002` stays **OPEN** — no author exists, and one may not be appointed here

| Measurement | Result |
|---|---|
| `PRD-019` exists? | **NO** — `docs/30-product/*/PRD-019*` matches **0 files** |
| `PRD_REGISTRY.md` **L309** | `PRD-019` / `BC-31` = **`PLANNED`** |
| `ADR-0040` **§4** (L165) | Wire contract owner = *"**`BC-31` owner**, once **`PRD-019`** exists"*; *"every candidate author is **barred today**"* |
| `ADR-0040` **§4** (L166) | *"**`PRD-019`** does not exist … Writing another PRD's content here would create a **second source of truth**"* |

**The four barred authors, from `ADR-0040` §2, hold today:** `PRD-008` may not write another context's wire contract; an ADR may not carry a module's normative specification; `ADR-0040` itself declined; and `PRD-019` — the only lawful home — is unwritten.

> **`FEE-GAP-002` therefore remains OPEN, and its `Freeze` field (`PRD-008` L2130) stays as written:** *"⛔ **STILL BLOCKS** … The **webhook wire contract is still unwritten** and cannot be written by any existing document (`ADR-0040` §2/§4)."*
>
> **This is not a gap awaiting a decision. It is a gap awaiting a *document*.** No authority named in this repository can close it by ruling; the `BC-31` owner must first have somewhere to write. **Naming a provider, endpoint, schema, signature algorithm, header, replay window or retry policy here would be the exact prohibited act** — instruction clause 7: *"Add no BC, edge, permission, config ID, API, schema, provider or financial rule."*

**Correctly, `FEE-GAP-002` does NOT block Stage 4** — its ownership limb is closed by determination and its contract limb is *"explicitly deferred **with a reason and an owner**"*, which `PRD_LIFECYCLE.md`'s Stage-4 gate permits in terms.

---

## §7 What this ADR does **NOT** do — enumerated, because the negatives are the deliverable

| # | Not done | Why |
|---|---|---|
| 1 | **`ADR-0039` not accepted** | Architecture Owner act (`PRD_OWNERSHIP_MODEL.md` L85). Its `Status` row is **byte-unchanged** |
| 2 | **This ADR not self-accepted** | It contains **no decision**; accepting it would assert that preparations are determinations |
| 3 | **EA not modified** | Rank 6 change requires an **`ACCEPTED`** prior ADR (baseline §7 step 1). **`5ef1d63a36f9bd2f` unchanged** |
| 4 | **EA L1408 not corrected** | Different platform; would decide a gateway capability tier no ranked document decides (§3.3) |
| 5 | **No gap marked `RESOLVED`** | No authority conferred. Instruction bars it twice |
| 6 | **`PRD-008` not modified, not frozen** | Freeze is *"**conferred, not claimed**"* (`PRD_LIFECYCLE.md` L152+). **`f85340a3c468e174` unchanged** |
| 7 | **No BC, edge, permission, config ID, API, schema, provider or financial rule added** | Instruction clause 7. `BC` count stays **31**; no `E-*`; no `FEE-CFG-*` register (`PRD-008` L85-L88 still reads *"No configuration register is declared"*) |
| 8 | **No frozen document touched; no checker weakened** | 14 protected hashes verified; all 8 gates unchanged |
| 9 | **`ADR-0039` §7.1's stale table not fixed** | Amending another ADR's record of a decision I did not make, and it is **evidence** that the v1.4/v1.5 sequence occurred (§2.5) |
| 10 | **`PRD-008` L2112's *"L1409"* citation defect not fixed** | Disclosed in §3.3; `PRD-008` is not this ADR's to edit |
| 11 | **No retention period, discount ceiling, approver role or payment method named** | Each is the routed authority's to decide (§4.2, §4.3) |
| 12 | **`FEE-RSK-*` not added to `PRD-008` §0.2** | The undeclared-register defect found by `prd008_traceability.py` is a **document-owner** act; the gate **reports** it and keeps exit 0 |

---

## §8 Objections, stated before they are raised

**"`ADR-0040` closed §2, so `ADR-0039` is effectively accepted — just mark it."**
**No.** `ADR-0039` §9 anticipated this exact argument and answered it: *"**Acceptance of the ADR is a separate act**."* `ADR-INDEX.md`'s status vocabulary makes `PROPOSED` bind nothing; changing that binding is what acceptance *is*. **The impediment being removed makes acceptance *possible*, not *automatic*** — and §2.5 shows a second thing an Architecture Owner needs to know before signing, which they could only learn from being asked.

**"You drafted an EA edit but did not apply it — that is a wasted step."**
The instruction required exactly this: *"**Prepare** the minimum lawful correction … but **DO NOT apply** an Architecture Owner decision yourself."* It is also what `DOCUMENTATION_BASELINE.md` §7 step 1 requires: *"an ADR **before** the change"*. **A drafted edit with an exact line number, exact before/after text and a cited mandate is executable in one step by the authority who owns it.** That is the deliverable.

**"You excluded L1408 to reduce your own work."**
§3.3 gives the measurement: L823 is in **`LAYER 2 → LIBRARY MANAGEMENT PLATFORM → Revenue & Finance`**, L1408 in **`LAYER 4 → BUSINESS PLATFORM`** beside `Payment Gateway Abstraction`. Correcting L1408 would have been **one further token** — trivially less work than writing §3.3 to explain why it should not be. **It is excluded because "minimum" was specified, and because a gateway refund API is a genuinely different question** from whether `BC-05` may issue a compensating entry.

**"Routing seven questions closes nothing — the pass achieved nothing."**
**It closed nothing, and §1.1 says so before any of the work.** What it produced: one impediment measured as removed (§2), one stale table found that would have contaminated an acceptance (§2.5), one executable edit drafted with its mandate cited (§3), seven questions stated so their authorities need no further analysis (§4), and one gap confirmed as awaiting a **document** rather than a decision (§6). **The alternative — inventing answers — would have moved the count to zero and made every one of them unfounded.**

**"`FEE-GAP-012` has three of four limbs open but limb (d) is done — record it as partly resolved."**
Limb (d) **is** recorded as discharged, at §4.5, with its gate evidence. But the block's `Status` stays `OPEN`, because its `Freeze` field turns on *"`PRD-006` could not freeze without gates at exit 0"* **and** on registry legitimacy, an undeclared transport and a report tier. **A gap with four limbs is not three-quarters closed.**

---

## §9 Verification performed

| # | Check | Result |
|---|---|---|
| 1 | `ADR-0039` `Status` row read | **`PROPOSED`** — unchanged; `59e31dc19013c125` |
| 2 | `ADR-0039` §9 impediment read verbatim (L291-L294) | *"§2 contains an unresolved **Architecture Owner** question"* — single, named, falsifiable |
| 3 | `ADR-0039` §2.4 required-authority text read (L88-L90) | **Two limbs**: §5.5b stands-or-amended, **and separately** authorise a contract |
| 4 | `ADR-0040` `Status` + `Supersedes` (L7, **L11**) read | `ACCEPTED`; *"It **closes** `ADR-0039` §2's reported conflict by determining it"* |
| 5 | `ADR-0040` §1 read (L17-L20, L65) | §5.5b **STANDS**; owner **`platform/business`**; routing *"**NOW DETERMINED**"* |
| 6 | `ADR-0040` §4 read (L163-L166) | Wire contract **still open**; owner `BC-31` once `PRD-019` exists |
| 7 | **`ADR-0039` §7.1 re-measured against `PRD-008` v1.5 §36.1** | **All four "⛔ none" claims STALE** — L1882/L1896/L1919/L1931 carry criteria; §36.1 rows containing `none` = **0** |
| 8 | `PRD-019` existence | **0 files** — `FEE-GAP-002` has no lawful author |
| 9 | EA `Refund` occurrences | **Exactly 2** — L823, **L1408** (not L1409; L1409 = `Payment Retry (V2)`) |
| 10 | EA enclosing-tree walk for L823 / L1408 | **L678 `LAYER 2` / `LIBRARY MANAGEMENT`** vs **L1349 `LAYER 4` / `BUSINESS PLATFORM`** — different platforms |
| 11 | EA header + baseline rows | `v2.1`, *"Approved for Implementation"*, Rank **6**, *"Descriptive only"* (L221), *"never lead them"* (L139); **in no frozen baseline row** |
| 12 | `MP-CON-08` read verbatim (`MASTER_PRD.md` **L519**) | *"the Enterprise Architecture is updated to match — never the reverse … a **defect to be raised**, not a choice"* |
| 13 | Rank 4 BC Map L100 / L374 / L422 re-read | `BC-05` owns *"refunds"*, **V1**; `RefundRecord`, *"refund ≤ received"*; publishes `fee.RefundIssued` |
| 14 | `PRD_OWNERSHIP_MODEL.md` L68 / L85 read | Structural change **and** *"any Rank 1-5 document change"* / *"ADR approval"* = **Architecture Owner** |
| 15 | `DOCUMENTATION_BASELINE.md` §7 step 1 read (L295) | *"a change to any Rank 1-5 document requires an ADR **before** the change"* |
| 16 | All 10 Freeze-blocking gap blocks' `Owner` / `Authority` rows re-read | **All ten agree with §4's routing** — the ledger was already correct |
| 17 | `prd008_traceability.py` re-run | **exit 0** — 134/134, 98/98, 17 gaps, **10 blocking Freeze**, 0 blocking Stage 4 |
| 18 | `PRD-008` / EA / `ADR-0039` / `ADR-0040` hashes after this commit | **All unchanged** |
| 19 | New BCs, edges, registers, config IDs, providers, schemas | **None created** |
| 20 | Frozen documents, checkers | **Unmodified** — 14 hashes verified, 0 mismatches |

---

## §10 Change history

| Date | Change |
|---|---|
| 2026-08-15 | **`ADR-0041` created `PROPOSED`.** Records that `ACCEPTED` `ADR-0040` has removed the sole impediment `ADR-0039` §9 stated to its own acceptance; **finds a second impediment `ADR-0039` could not have known about** — its §7.1 table is stale because the v1.4/v1.5 pass it prescribed actually happened; **drafts the minimum lawful Rank 6 correction** (EA **L823** `Refunds (V2)` → `(V1)`, one token) and **deliberately excludes EA L1408** as a different platform's gateway capability, routing it instead as **Q-EA-2**; routes **seven** questions to Architecture, Product, Compliance and Governance Owners with exact wording; keeps **`FEE-GAP-002`** open for want of `PRD-019`. **Freeze blockers: 10 → 10.** **Nothing decided, nothing accepted, nothing frozen, no gap marked `RESOLVED`.** |
