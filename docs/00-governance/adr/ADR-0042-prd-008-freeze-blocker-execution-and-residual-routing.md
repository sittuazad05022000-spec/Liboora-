# `ADR-0042` — `PRD-008` Freeze-blocker execution: four closed, three dissolved by measurement, three routed unresolved

| Field | Value |
|---|---|
| **ADR** | `ADR-0042` |
| **Title** | `PRD-008` Freeze-blocker resolution — executing ten conferred V1 decisions, correcting the Rank 6 Enterprise Architecture, and recording exactly what a decision could not close |
| **Status** | **`ACCEPTED`** — recording decisions **conferred directly by the human principal**, acting as **Product Owner** for the scope questions and as **Architecture Owner** for the acceptance of `ADR-0039` and the `MP-CON-08` correction to the Enterprise Architecture. **This ADR does not decide anything of its own.** Every determination below is either (a) a conferred decision recorded verbatim, or (b) a **mechanical consequence** of a precedence rule that was measured, not chosen. Where a conferred instruction could not be executed lawfully, the collision is **reported in §7 and the item is left OPEN with a named owner** — not quietly reinterpreted into something executable. |
| **Date** | 2026-08-15 |
| **Decision by** | **Product Owner** — `FEE-GAP-001`, `003`, `005`, `006`, `007`, `011` (V1 scope) · **Architecture Owner** — acceptance of `ADR-0039`, the Rank 6 EA correction, `FEE-GAP-009`, `FEE-GAP-012`(b). Both conferred in one instruction by the human principal (`PRD_OWNERSHIP_MODEL.md` **L85**, **L68**). |
| **Amends** | **`LIBOORA_ENTERPRISE_ARCHITECTURE.md` — Rank 6, `v2.1` → `v2.2`.** Exactly **one token**: `Refunds (V2)` → **`Refunds (V1)`** at **L823**. Mandated by **`MP-CON-08`** (Rank 1) and `DOCUMENTATION_BASELINE.md` §4. **No Rank 1–5 document is amended.** **No frozen document is amended.** |
| **Supersedes** | **Nothing.** It **executes** `ADR-0041`'s prepared items (`ADR-0041` is left `PROPOSED` and unedited — see §9.4) and **upholds** `ADR-0035`, `ADR-0037` and `ADR-0040` unchanged. |
| **Closes** | **Four Freeze blockers: `FEE-GAP-001`, `FEE-GAP-004`, `FEE-GAP-005`, `FEE-GAP-006`.** |
| **Does NOT close** | **Six: `FEE-GAP-002`, `003`, `007`, `009`, `011`, `012`.** Three of those six (`003`, `009`, `012`) are reduced to a **single named residual limb** each; three (`002`, `007`, `011`) are reported as **collisions or refusals** in §7. Each carries a named owner and an exact question. |

---

## §1 What this ADR is, and the number it does not inflate

Ten V1 decisions were conferred at once, with seven governing rules. The instruction's own goal was to
*"reduce the 10 Freeze blockers **as far as lawfully possible** and report exactly what remains."*

**Freeze blockers: 10 → 6.** Not 0, and the gap between 6 and 0 is the substance of this record.

### 1.1 The honest ledger, stated before any reasoning

| Gap | Conferred decision | Outcome | Why |
|---|---|---|---|
| **`FEE-GAP-001`** | V1 full-refund only; original immutable; refund is a separate compensating entry | ✅ **CLOSED** | The decision was already recorded (`ADR-0039` §3) and specified (`FEE-FR-042`, `FEE-BR-019`, `FEE-AC-090`…`095`). The **only** residual was the Rank 6 EA contradiction, and the conferral authorised the `MP-CON-08` correction. **§4** |
| **`FEE-GAP-004`** | Accept `ADR-0039`; use its fee taxonomy | ✅ **CLOSED** | `ADR-0039` is now **`ACCEPTED`**. Its §4 taxonomy binds. **§3** |
| **`FEE-GAP-005`** | Financial corrections are append-only | ✅ **CLOSED** | `ADR-0039` §5 now binds; `FEE-FR-043`/`FEE-AC-098` already specify it. **§5** |
| **`FEE-GAP-006`** | Due-date offset = 0 days | ✅ **CLOSED** | `ADR-0039` §6 now binds; `FEE-BR-007` already states the value. **§5** |
| **`FEE-GAP-009`** | Invoice = issued representation of `FeeDue`; no second state machine | ⚠ **STILL BLOCKS — residual measured and narrowed** | The **Rank 4 reading is ratified** and `PRD-008` already takes it. But the gap's stated defect — *"two state machines for one concept"* — is a defect **in `PRD-008` §29.3**, which still presents a three-state Invoice table. **§6.1** |
| **`FEE-GAP-012`** | Resolve using existing precedents | ⚠ **STILL BLOCKS — limbs (b) and (d) closed, (a) and (c) remain** | (b) closed by the `MM-GAP-010` precedent with **no edge invented**; (d) closed by `420467c`. (a) is a **`GCP-14`** governance conflict this ADR may not resolve by fiat; (c) is **Rank 6 vs Rank 6**, which `MP-CON-08` cannot arbitrate. **§6.2** |
| **`FEE-GAP-003`** | Bank transfer is **NOT V1**; defer/exclude | ⚠ **STILL BLOCKS — decision recorded, execution refused as an invention** | The **deferral is recorded and binding**. But the gap's `Freeze` field states the blocker as *"a method used in practice but unrepresentable is a V1 defect"* — and a decision to exclude does not make that defect untrue. **§6.3** |
| **`FEE-GAP-002`** | **"Create/define the required PRD-019 webhook contract"** | ⛔ **STILL BLOCKS — instruction collides with Rule 2 and is NOT executed** | A webhook contract **is** endpoint + schema + signature + replay window. Rule 2 forbids inventing APIs, schemas and providers; `ACCEPTED` `ADR-0040` §2 measured **all four candidate authors barred** and `PRD-019` measured as **0 files on disk**. **§7.1** |
| **`FEE-GAP-007`** | **"Do not invent a ceiling; if not required for V1, defer/exclude discounts"** | ⛔ **STILL BLOCKS — the ceiling is refused as instructed; excluding discounts is UNLAWFUL** | Excluding discounts would subordinate **Rank 4** BC Map **L374** to a V1 scope note, and would delete already-specified `FEE-FR-038`…`041`, `FEE-INV-007` and `FEE-AC-049`. **§7.2** |
| **`FEE-GAP-011`** | **"Do not invent statutory retention"**; route to Product + Security/Compliance | ⛔ **STILL BLOCKS — by explicit instruction** | The instruction is a **routing instruction, not a decision**. Executed as given. **§7.3** |

**Four closed. Six open. Nothing was marked RESOLVED that a named authority did not resolve.**

---

## §2 The two rules that did the most work, and were applied in opposite directions

Both come from the same place, and they are why four gaps closed while three others could not.

> `DOCUMENTATION_BASELINE.md` §4 **L224**: *"**A conflict is a defect.** If you find one, do not choose — raise it. The precedence order tells you which document is **wrong**, not which one to quietly ignore."*

> **`MP-CON-08`** (`MASTER_PRD.md` **L519**, **Rank 1**): *"… **the higher-ranked document wins and the Enterprise Architecture is updated to match** — never the reverse. A disagreement is a **defect to be raised**, not a choice to be made."*

**Applied forwards** (§4): the EA said `Refunds (V2)`; Rank 4 and a frozen Rank 3 PRD said V1. That is a defect
in the **lower-ranked** document, and correcting it is **mechanical**. Done.

**Applied backwards, and refused** (§7.2): the conferred instruction offered to exclude discounts, but
**Rank 4 BC Map L374 already requires** *"discount requires an authorised approver role."* Excluding discounts
would make a **Rank 6-level scope note override Rank 4** — the precise inversion `MP-CON-08` forbids. The
instruction's own precondition, *"**if not required for V1**"*, is therefore **measured as false**, and the
instruction is reported rather than executed.

---

## §3 `FEE-GAP-004` — ✅ CLOSED. `ADR-0039` is `ACCEPTED`

### 3.1 The act, and why it was lawful now and not before

`ADR-0039` §9 named **exactly one** impediment to its own acceptance:

> *"**Acceptance of the ADR is a separate act**, and §2 contains an unresolved **Architecture Owner** question. Accepting a record that contains an open architectural conflict would bind the parts that are settled *and* the part that is not."*

That impediment was removed by **`ACCEPTED` `ADR-0040`**, whose `Supersedes` row (**L11**) reads:

> *"Nothing. It **closes** `ADR-0039` §2's reported conflict by determining it, and **confirms** `ADR-0039` §2's refusal to determine it as having been correct at the time."*

`ADR-0041` §2 measured that ripeness **before** any conferral existed, and deliberately **did not** self-accept,
because acceptance is an **Architecture Owner** act (`PRD_OWNERSHIP_MODEL.md` **L85**). The principal has now
conferred it. **The measurement did not change; the authority did.**

### 3.2 The acceptance is SCOPED, and the scope is recorded in `ADR-0039`'s own Status row

| Part | Disposition |
|---|---|
| **§3–§6** — four Product-Owner decisions | ✅ **ACCEPTED and BINDING** |
| **§2** — the reported conflict | ✅ Accepted **as a report**, not as a routing decision. The conflict itself is closed by `ADR-0040` §1, which **upheld `ADR-0035` §5.5b unchanged** |
| **§7** — *"Stage 4 MUST NOT be run"* | ⚠ **SUPERSEDED BY MEASUREMENT, retained verbatim as evidence** — see §3.3 |

### 3.3 ⚠ The stale section, disclosed rather than repaired

`ADR-0039` **§7.1** asserts all four of `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-019`, `FEE-BR-007` carry
**`⛔ none`**, and concludes at **L227**: *"Check 1 therefore still fails, and **Stage 4 MUST NOT be run.**"*

**Re-measured against `PRD-008` v1.5 §36.1:**

| Obligation | §7.1 claim | Measured now | Line |
|---|---|---|---|
| `FEE-FR-028` | `⛔ none` | `FEE-AC-085`…`089` | **L1882** |
| `FEE-FR-042` | `⛔ none` | `FEE-AC-090`/`091`/`092`/`093`/`095` | **L1896** |
| `FEE-BR-007` | `⛔ none` | carries criteria | **L1919** |
| `FEE-BR-019` | `⛔ none` | `FEE-AC-091`/`093` | **L1931** |

Rows containing *"none"*: **0**. Stage 4: **run and passed 6/6**.

**Why §7 is not edited.** §7.2 prescribed the sequence *decide → specify in the PRD → re-measure → then
Stage 4*, and **that sequence was carried out**. §7 is the truthful record of the state before the second step
completed. Editing it now would delete the evidence that the prescribed process was followed, and would make an
accepted record appear more prescient than it was. **The staleness was found by `ADR-0041` §2.5 before this
acceptance**, not discovered afterwards, and is restated in `ADR-0039`'s new Status row so no reader is misled.

---

## §4 `FEE-GAP-001` — ✅ CLOSED. The Rank 6 correction executed

### 4.1 What was actually still blocking

The gap's `Stage 4` field had already cleared at v1.5. Its **`Freeze`** field (`PRD-008` **L2112**) named one
residual and one only:

> *"The Rank 6 EA still reads **`Refunds (V2)`** at **L823**/**L1409** while Rank 4 BC Map **L100**/**L374**/**L422** reads V1, and **`MP-CON-08`** requires the **EA** to be corrected to match the higher rank, *"never the reverse"*. That is an **Architecture Owner** act, **not performed here**."*

**The conferral supplies exactly that act.**

### 4.2 The evidence, re-measured at HEAD before the edit

| Rank | Source | Says |
|---|---|---|
| **3 (FROZEN)** | `PRD-005` **L942** | *"a refund decision by `BC-05`"* |
| **4** | BC Map **L100** | `BC-05` owns *"refunds"*; row Release = **V1** |
| **4** | BC Map **L374** | `RefundRecord` is a `FeeLedger` member; invariant `refund ≤ received` |
| **4** | BC Map **L422** | `fee.RefundIssued` → `BC-26`, `BC-24` — a declared published event |
| **6** | EA **L823** | `Refunds (V2)` ← **the lone dissenter, and the lowest rank** |

### 4.3 The edit, and its exact boundary

**One token.** `│   ├── Refunds (V2)` → `│   ├── Refunds (V1)` at **L823**, whose measured parent is
**`Revenue & Finance (V1)`** (L818) inside **LAYER 2 — DOMAIN PLATFORMS → LIBRARY MANAGEMENT PLATFORM**.
`v2.1` → **`v2.2`**, with a changelog entry, per EA §10.5 step 4 and baseline §7 step 2.

### 4.4 ⛔ Why **L1408** was NOT changed — measured, not assumed

`PRD-008` cites *"L823/L1409"*. **Both halves of that citation needed testing, and one is wrong.**

| Line | Text | Measured parent | Layer |
|---|---|---|---|
| **L823** | `Refunds (V2)` | **`Revenue & Finance (V1)`** (L818) | LAYER 2 — DOMAIN PLATFORMS |
| **L1408** | `Refund Management (V2)` | **`Payment Gateway (V1)`** (L1403) | LAYER 4 — BUSINESS & ENGAGEMENT |
| **L1409** | **`Payment Retry (V2)`** | `Payment Gateway (V1)` | LAYER 4 |

**Two findings.** (i) `PRD-008`'s *"L1409"* citation is a **defect**: L1409 is `Payment Retry (V2)`; the refund
node is at **L1408**. (ii) **L1408 is a different question.** Its siblings are `Payment Gateway Abstraction (V1)`,
`Razorpay (V1)`, `Payment Verification (V1)` and `Webhook Reconciliation (V1)` — it describes a **gateway-side**
capability owned by the Business Platform, which is exactly the boundary `ADR-0035` §5.5b and `ADR-0040` §1
place **outside `BC-05`**. Whether `BC-05` may record a refund in its ledger and whether the gateway rail can
execute one are **not the same proposition**, and **no Rank 1–4 document places gateway-executed refund in V1**.

**Changing L1408 would therefore have been an invention, not a correction.** It is left standing and routed as
**`Q-A5`** in §8.

---

## §5 `FEE-GAP-005` and `FEE-GAP-006` — ✅ CLOSED by the acceptance in §3

Neither required a new decision; both required `ADR-0039` to **bind**.

| Gap | Decision now binding | Already specified in `PRD-008` |
|---|---|---|
| **`FEE-GAP-005`** | Financial corrections are **append-only**; the original is immutable; a correction references it and records actor, reason, timestamp, corrected state | `FEE-FR-043` → **`FEE-AC-098`** |
| **`FEE-GAP-006`** | V1 due-date offset = **0 days**; the recorded due date **is** the effective due date | `FEE-BR-007` **states the value** |

Both rest on **Rank 1** rather than on analogy: `MP-GBR-12` (`MASTER_PRD.md` **L353**) already makes a refund
*"a **compensating entry, never a mutation**"*. **`ADR-0039` §5 deliberately declined** the `CANCELLED`+reissue
shape its own `Recommended` row proposed, because a state value is a `PRD-008` act — and **this ADR does not
add one either**. `FEE-GAP-005`'s Architecture-Owner half is discharged by the same conferral that accepted
`ADR-0039`.

---

## §6 The three gaps narrowed to one named residual each — still blocking

### 6.1 `FEE-GAP-009` — the Rank 4 reading is RATIFIED; a `PRD-008` defect remains

**Conferred:** *"treat Invoice as the issued representation of FeeDue unless authoritative architecture proves otherwise; do not create a second financial state machine."*

**Measured — the instruction's escape clause is tested, not assumed:**

| Source | Rank | Says |
|---|---|---|
| BC Map **L204** | 4 | equates `BC-05`'s *"Invoice"* with **`FeeDue`** |
| BC Map **L374** | 4 | lists **five** `FeeLedger` members — `FeeDue`, `Receipt`, `Discount`, `RefundRecord`, `Money`. **Invoice is not one** |
| EA **L1413** | 6 | `Invoice Generation (V1)` — measured parent **`Billing & Invoicing (V1)`** (L1412), LAYER 4 |

**"Authoritative architecture" does not prove otherwise.** EA L1413 is **Rank 6** and describes a
**Business-Platform billing capability**, not a `BC-05` aggregate; under `MP-CON-08` it cannot outrank Rank 4
anyway. ✅ **RATIFIED: invoice = the issued representation of `FeeDue`. No sixth `FeeLedger` member. No second
aggregate.** `PRD-008` already takes this reading at **L1418**.

⚠ **Why it still blocks.** The gap's `Freeze` verdict is *"**two state machines for one concept** is a modelling
defect"*, and `PRD-008` **§29.3 (L1409–L1419)** still presents an Invoice state table with three states
(`ISSUED`, `PAID`, `CANCELLED`) alongside §29.1's `FeeDue` machine. **Ratifying the reading does not delete the
second table.** That edit is a **`PRD-008` specification act** — deciding whether §29.3 becomes a projection of
§29.1, is folded into it, or is removed — and **`ADR-0039` §7.2's own rule applies**: writing a PRD's state
model inside an ADR *"would create a second divergable source of truth."*

**Residual:** one `PRD-008` §29.3 restructuring. **Owner: `PRD-008` document owner.** No decision outstanding.

### 6.2 `FEE-GAP-012` — limbs (b) and (d) CLOSED, (a) and (c) remain

| Limb | Question | Disposition |
|---|---|---|
| **(a)** | `PRD_REGISTRY.md` **L245** records `PRD-008` `PLANNED`; who moves it to `DRAFT`? | ⛔ **OPEN — and deliberately not swept.** The registry's **own** §7 row records **`GCP-14`**: it *"states two incompatible tests for `DRAFT`"*. Its v2.0 changelog records that `PRD-008` was **left at `PLANNED` on purpose**, because *"advancing `PRD-008` here would have resolved `GCP-14` by fiat in the direction that happens to be convenient."* **That reasoning is unchanged, and `GCP-14` is a Governance Owner's to close.** Routed as **`Q-G1`** |
| **(b)** | `BC-26` is a `fee.*` consumer in BC Map §9 with **no `E-*` edge** in §7 | ✅ **CLOSED by precedent, with no edge invented.** The `MM-GAP-010` precedent is followed exactly: frozen `PRD-004`, `PRD-005`, `PRD-006` and `PRD-007` **all declined** to add the edge, and `ADR-0019` §3.1 admits the defect as **systemic to a Rank 4 document**. `PRD-008` already complies — **L1314**: `BC-26` is *"**not** listed in the *Publishes to* header row"*. **No `E-27`+ edge created; edge count unchanged** |
| **(c)** | `Financial Reports` is **(V2)** at EA **L814** and **(V1)** at EA **L1423** | ⛔ **OPEN — `MP-CON-08` structurally cannot arbitrate.** Measured: **both lines are Rank 6**, with *different* parents — L814's is **`Owner Dashboard (V1)`** (L807), L1423's is a top-level LAYER 4 node. This is a document **internally inconsistent with itself**, not a cross-rank conflict, so the "higher rank wins" rule has nothing to compare. It may be a genuine duplicate (an EA §3 Duplicate Resolution Matrix question) or two distinct capabilities. **A rank rule cannot decide it; an owner must.** Routed as **`Q-P3`** |
| **(d)** | No `prd008_traceability.py` gate | ✅ **CLOSED** at `420467c`; re-run at exit 0 in §10 |

### 6.3 `FEE-GAP-003` — the deferral is RECORDED and BINDING; the defect it names survives it

**Conferred:** *"bank transfer is NOT V1; explicitly defer/exclude it."* ✅ **Recorded, and binding.**

Measured first: *"bank transfer"* is named in **no** authoritative source — not BC Map **L202** (*"cash/UPI"*),
not EA **L1395–1401** (`Online`/`Cash`/`UPI`/`Card`/`Partial (V2)`/`Split (V3)`), not the Master PRD, not any
frozen PRD. **So excluding it removes nothing that any ranked document grants** — unlike discounts (§7.2). The
decision is lawful and is executed as a **scope deferral**.

⚠ **Two things it does not do, and the second is why the gap still blocks.**

**(i) No `FEE-XC-024` is minted.** `PRD-008` **§32 L1547** already establishes the discipline: *"no new
exclusion is needed to keep them out, and none was invented."* A `FEE-XC-*` is an **obligation-bearing
identifier**; adding one would move the §0.2 register from `FEE-XC 23` → `24` and the total from **249** → 250,
against the document's own **L66–L71** finding that *"**Inventing new obligations to look thorough would have
been the failure mode**."* Rule 4 (minimum change) points the same way. **A deferral is recorded as scope, not
as a new obligation.**

**(ii) The gap's stated Freeze defect is not a scope question.** Its `Freeze` field reads: *"**BLOCKS** — a
method used in practice but unrepresentable is a V1 defect"*, and its `Impact` row: *"Indian libraries do
receive NEFT/IMPS. **If omitted, staff will record it as cash and corrupt method-based reporting.**"*
**Deciding to omit bank transfer is precisely the condition that `Impact` row describes, not a cure for it.**
The residual is therefore **not** *"is bank transfer V1?"* — that is answered **No** — but *"what does a staff
member do when a NEFT payment arrives, given `FEE-XC-022` bars offline writes and method-based reporting is a
declared §22.1 report?"* **That is a product question this conferral did not reach**, and pretending the
deferral answered it would be exactly what Rule 5 forbids. Routed as **`Q-P1`**.

---

## §7 The three items where a conferred instruction could NOT be executed lawfully

**Rule 5 governs this section:** *"For anything requiring an authority decision, **record the exact decision and owner rather than pretending it is resolved**."* Rule 2 governs what may not be invented to make an
instruction executable.

### 7.1 ⛔ `FEE-GAP-002` — *"create/define the required PRD-019 webhook contract"* collides with Rule 2

**This is the most important refusal in this record, and it is a refusal of an explicit instruction.**

**What a webhook contract is.** `ACCEPTED` `ADR-0040` **§4 L165** defines the open item precisely: *"The webhook
**wire contract** (**endpoint, schema, signature, replay window, retry policy**)"*. Those five items are, one for
one, the things **Rule 2** forbids: *"Do not invent … **APIs, schemas, providers, edges** or financial rules."*
**There is no version of "define the contract" that is not the invention of an API and a schema.**

**Who may author it — all four candidates measured barred** (`ADR-0040` §2, `ACCEPTED`, re-verified at HEAD):

| Candidate | Measured status | Verdict |
|---|---|---|
| `platform/business` / `BC-20` | `PRD-022` **`SAAS-XC-006`** (L157-158) bars naming a *"**webhook schema**"*; it names **`BC-31`** as the owner of vendor knowledge | ⛔ **FORBIDS ITSELF** |
| **`BC-31`** Integration — the named owner | **`PRD-019` is `PLANNED`** (`PRD_REGISTRY.md` **L309**). Re-measured at HEAD: files matching `PRD-019` = **0** | ⛔ **NO DOCUMENT EXISTS** |
| `BC-05` / `PRD-008` | Its own **§14.1 / L863**: *"**No webhook schema, no provider contract and no endpoint is written in this document**"* | ⛔ **FORBIDS ITSELF** |
| `ADR-0035` §5.5b | *"Do not create a new BC or **invent an endpoint/schema**"* | ⛔ **FORBIDS INVENTION** |

**Could this ADR create `PRD-019`?** No, and the reason is structural, not timid. `ADR-0040` **§4 L166** states
it: *"Writing another PRD's content here would create a **second source of truth**."* `PRD-019` belongs to
**`BC-31`**; a `PRD-008` freeze pass authoring it would (i) invent a schema Rule 2 bars, (ii) invent a provider
contract with no vendor decided (`FEE-GAP-010` is open, and `FEE-XC-006` forbids naming one), and (iii) create a
document whose registry status, rank, lifecycle stage and gates nobody has conferred. **The instruction is
reported, not executed.**

**What `BC-05` does own is already specified and testable.** `ADR-0040` §2.2 established `FEE-FR-028` can be
made testable **without** a wire contract, and `PRD-008` v1.5 did exactly that: `FEE-AC-085`…`089` name **no**
endpoint, field, signature algorithm, header, replay window, retry policy or provider. **Stage 4 passes. Freeze
does not** — and `PRD-008` **L2130** already states why, correctly: *"Stage 4 asks whether this PRD's own
requirements are **testable**; Freeze asks whether the specification is **complete**… freezing `PRD-008` now
would freeze a **named, owned hole** into a baseline."*

**Exact decision required, and its owner:** author the webhook wire contract in **`PRD-019`**. **Owner: the
`BC-31` owner, once `PRD-019` exists.** Creating `PRD-019` is a **Governance Owner** act (`Q-G2`). Unchanged
from `ADR-0040` §4; **this conferral did not remove the bar, and no amount of instruction can, because the bar
is Rule 2 itself.**

### 7.2 ⛔ `FEE-GAP-007` — the ceiling is refused **as instructed**; excluding discounts is **unlawful**

**Conferred:** *"do not invent a discount ceiling; **if not required for V1**, defer/exclude discounts."*

**Limb 1 — the ceiling: ✅ executed exactly.** No ceiling, percentage, range or maximum is created. This
follows the `PRD-006` precedent the gap's own `Recommended` row cites — *"as `PRD-006` did when it refused an
unapproved configurable"* — and `ADR-0031`, still `Proposed` for the same reason. **No `FEE-CFG-*` register is
opened** (`PRD-008` **L85–L88**: *"**No configuration register is declared**"*).

**Limb 2 — the conditional: its precondition is measured FALSE, so the conditional does not fire.**

| Source | Rank | Says |
|---|---|---|
| BC Map **L374** | **4** | `FeeLedger` invariant: *"**discount requires an authorised approver role**"*; **`Discount` is a declared aggregate member** |
| BC Map **L100** | **4** | `BC-05` owns *"…**discounts**…"*; row Release = **V1** |
| EA **L822** | 6 | `Discounts (V1)` |
| `PRD-008` **L1000–L1007** | — | `FEE-FR-038`, **`FEE-FR-039`**, `FEE-FR-040`, `FEE-FR-041`, `FEE-INV-007` — **five specified obligations** |
| `PRD-008` **L1893** | — | `FEE-FR-039` → **`FEE-AC-049`** — already testable |

**Discounts are required for V1 by a Rank 4 document, and are already specified with acceptance criteria.**
Excluding them would (i) subordinate **Rank 4** to a V1 scope note — the exact inversion `MP-CON-08` forbids;
(ii) delete five obligations and one acceptance criterion, contradicting Rule 4's *minimum change* and the
"no obligations removed" discipline; and (iii) contradict `PRD-008` **L2195**, which already records the
**approver-role requirement as specified** — *"only its membership and any ceiling are open."*

**So both limbs are honoured and the gap still blocks.** The residual is exactly what **L2195** and **§23.1
L1198** name: `| Approve discount | `owner` — **⛔ whether `manager` also, `FEE-GAP-007`** |`.

**Exact decision required:** *"Is `manager` an authorised discount approver in addition to `owner`, or is
`owner` the sole approver?"* — a **role-membership** question, answerable **without** any ceiling and **without**
creating a role (`FEE-XC-014` forbids that). **Owner: Product Owner.** Routed as **`Q-P2`**.

### 7.3 ⛔ `FEE-GAP-011` — routed exactly as instructed; no retention invented

**Conferred:** *"do not invent statutory retention; **route it to Product + Security/Compliance with an explicit V1 decision required**."*

**This instruction is a routing instruction, and it is executed literally — it closes nothing, and it was not
intended to.** No retention period, purge rule, archival window or statutory citation is created. `FEE-XC-011`
(*"Purge or rewrite financial history"*) stands **unchanged**, and the gap's own warning is preserved: *"an
absolute never-purge rule **may itself be non-compliant**."*

**Exact decision required:** *"For how long must `BC-05` financial records be retained under Indian statute, and
may anything ever be purged or archived — and if so, by what authority and with what audit trail?"*
**Owners: Product Owner + Security/Compliance, jointly.** ⛔ **AN EXPLICIT V1 DECISION IS REQUIRED BEFORE
FREEZE** — this is marked, not softened, because `PRD-008`'s `Freeze` field states the standard: *"a financial
module frozen with no retention position is **not production-safe**."* The `PRD-006` precedent (retention left
explicitly undefined) is **not** available as cover: `PRD-006` is not a financial module. Routed as **`Q-S1`**.

---

## §8 The routing table — every open item, its exact question, and its owner

**No question below is rhetorical, and none is answered here.**

| Ref | Gap | Exact question | Owner |
|---|---|---|---|
| **`Q-A5`** | `FEE-GAP-001` residual | **Is EA L1408 `Refund Management (V2)` — a `Payment Gateway (V1)` child in LAYER 4 — correct as V2, given `BC-05` refunds are now V1 at L823?** The two nodes are in different layers under different parents; no Rank 1–4 document places **gateway-executed** refund in V1 | **Architecture Owner** |
| **`Q-P1`** | `FEE-GAP-003` residual | **Bank transfer is decided NOT V1. What must a staff member do when a NEFT/IMPS payment nonetheless arrives?** The gap's own `Impact` row warns they *"will record it as cash and corrupt method-based reporting"*, and §22.1 declares a method-based report | **Product Owner** |
| **`Q-P2`** | `FEE-GAP-007` residual | **Is `manager` an authorised discount approver in addition to `owner`, or is `owner` the sole approver?** No ceiling is sought (refused as instructed); no new role may be created (`FEE-XC-014`) | **Product Owner** |
| **`Q-P3`** | `FEE-GAP-012`(c) | **`Financial Reports` is (V2) at EA L814 under `Owner Dashboard (V1)` and (V1) at EA L1423 as a LAYER 4 node. Are these one capability duplicated, or two distinct ones?** Both are Rank 6, so `MP-CON-08` cannot arbitrate | **Product Owner** *(with Architecture Owner if it is a duplicate)* |
| **`Q-S1`** | `FEE-GAP-011` | **Retention period and purge position for `BC-05` financial records under Indian statute.** ⛔ Explicit V1 decision required before Freeze | **Product Owner + Security/Compliance** |
| **`Q-G1`** | `FEE-GAP-012`(a) | **Resolve `GCP-14` — `PRD_REGISTRY.md` states two incompatible tests for `DRAFT` — then apply it to `PRD-008`.** The registry's own v2.0 changelog refused to advance `PRD-008` for this reason | **Governance Owner** |
| **`Q-G2`** | `FEE-GAP-002` | **Create `PRD-019` (`BC-31` Integration), so that the webhook wire contract has a lawful author.** Currently `PLANNED`; 0 files on disk | **Governance Owner** |
| **`Q-B31`** | `FEE-GAP-002` | **Author the webhook wire contract — endpoint, payload schema, signature algorithm, replay window, retry policy — in `PRD-019`.** Cannot be authored anywhere else (`ADR-0040` §2) | **`BC-31` owner, once `PRD-019` exists** |
| **doc** | `FEE-GAP-009` residual | **Restructure `PRD-008` §29.3** so the Invoice is presented as the issued representation of `FeeDue` rather than as a second state machine. **The reading is already ratified (§6.1); this is a specification edit, not a decision** | **`PRD-008` document owner** |

---

## §9 What this ADR does NOT do — enumerated, because every incentive runs the other way

1. **It does not freeze `PRD-008`.** Freeze is *"conferred, not claimed"* (`PRD_LIFECYCLE.md` **L152+**) and its gate is a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned rank. **Six blockers stand.** No baseline row was added.
2. **It creates no `BC-*`, no `E-*` edge, no permission, no role, no API, no endpoint, no schema, no signature algorithm, no provider, no `FEE-CFG-*`, no configuration identifier and no financial rule.**
3. **It creates no new `FEE-*` identifier of any kind.** The §0.2 registers stay at **62/28/10/3/23/8/98/17 = 249**, obligation-bearing at **134**. No `FEE-XC-024` was minted for `FEE-GAP-003` (§6.3(i)).
4. **It does not edit `ADR-0041`.** That record is a truthful account of a *preparation* pass and remains **`PROPOSED`** with `Decision by` = *"Nobody."* Its §3.2 drafted the L823 edit; **this ADR executes it under a conferral `ADR-0041` did not have.** Rewriting `ADR-0041` to look like it decided something would falsify it.
5. **It does not edit `ADR-0039` §7**, though §7 is stale. §3.3 gives the reason.
6. **It does not amend the Bounded Context Map, the Module Dependency Matrix, `MASTER_PRD.md`, `ARCHITECTURE_RULINGS.md`, or any frozen PRD.** The refund correction ran **towards** Rank 4, not against it.
7. **It does not modify `ADR-0035`, `ADR-0037` or `ADR-0040`.** All three remain `ACCEPTED` and unchanged.
8. **It weakens no checker.** `prd008_traceability.py` is byte-unchanged; its Freeze-blocker count is the instrument this ADR is measured **by**, not one it adjusts.
9. **It marks no gap `RESOLVED` that an authority did not resolve**, and **decrements no count by reasoning alone**.
10. **It does not create `PRD-019`** (§7.1), **does not invent a discount ceiling or exclude discounts** (§7.2), and **does not invent a retention period** (§7.3).
11. **It writes no `PRD-008` requirement, state value, event payload or acceptance criterion.** `ADR-0039` §7.2's rule holds: that would create a second divergable source of truth.
12. **It touches no Dart source.** Measured: **0 files** differ under `lib test pubspec.yaml android web`.

---

## §10 Verification performed

| # | Check | Result |
|---|---|---|
| 1 | `ADR-0039` §9 impediment vs `ADR-0040` **L11** | Impediment **removed** — acceptance lawful under conferral |
| 2 | `ADR-0039` §7.1's four `⛔ none` claims re-measured against §36.1 | **All four now carry criteria** (L1882/L1896/L1919/L1931); rows with *"none"* = **0** → §7 **stale**, retained |
| 3 | `ADR-0039` Status leading token after edit | **`ACCEPTED`** — classified by the leading-token rule, not a window match |
| 4 | `ADR-0039` §7 bytes after edit | **Unchanged** — *"All four still carry `⛔ none`"* still present verbatim |
| 5 | EA `Refund` occurrences before edit | **Exactly 2** — L823, L1408 |
| 6 | EA tree-root probe (single fence **L238–L2372**) | **L823 → LAYER 2 / `Revenue & Finance (V1)`**; **L1408 → LAYER 4 / `Payment Gateway (V1)`** — different questions |
| 7 | EA **L1409** actual content | **`Payment Retry (V2)`** → `PRD-008`'s *"L1409"* citation is a **defect**, disclosed not fixed |
| 8 | EA after edit | **L823 = `Refunds (V1)`**; `Refunds (V2)` = **0**; **L1408 unchanged and still at L1408**; fence still **L238/L2372** |
| 9 | EA version | `v2.1` → **`v2.2`**, changelog entry added (§10.5 step 4, baseline §7 step 2) |
| 10 | Baseline §3.2 EA row | Updated **v2.1 → v2.2** in the **same commit** (§7 step 3 — the `GCP-01`/`07`/`08`/`11` defect class) |
| 11 | Baseline identifier | **Unchanged** — §7 step 4 changes it only for a **Rank 1–3** version change; the EA is **Rank 6** |
| 12 | `MP-CON-08` cites *"Enterprise Architecture **v2.1**"* (Rank 1) | ⚠ **Disclosed as a NEW drift, not silently edited** — see §11 |
| 13 | `PRD-019` existence re-measured at HEAD | **0 files** — `ADR-0040` §4's bar is current, not historical |
| 14 | Discount obligations re-measured | `FEE-FR-038`…`041`, `FEE-INV-007` at **L1000–L1007**; `FEE-FR-039` → **`FEE-AC-049`** (**L1893**) → exclusion **unlawful** |
| 15 | BC Map L100/L374/L422 | Refunds **V1**, `RefundRecord` a member, `fee.RefundIssued` declared — **byte-unchanged** |
| 16 | `MM-GAP-010` precedent for `BC-26` | Followed — **no edge created**; `PRD-008` **L1314** already complies |
| 17 | New `BC-32`+ / `E-27`+ / `FEE-CFG-*` / new `FEE-*` | **0 / 0 / 0 / 0** |
| 18 | Gaps marked `RESOLVED` in `PRD-008` | **0** |
| 19 | `prd008_traceability.py` | **exit 0**, `PASS` — **Freeze blockers 10 → 6** |
| 20 | Frozen documents · 8 gates · protected hashes · Dart diff | **Unmodified · unchanged · verified · 0 files** |

---

## §11 ⚠ One drift created by this ADR, disclosed rather than absorbed

**Bumping the EA to `v2.2` makes `MP-CON-08` stale.** `MASTER_PRD.md` **L519** reads *"The Enterprise
Architecture **v2.1** is approved and governing for structure"*, and `MASTER_PRD.md` **L10**, **L219**, **L223**,
**L568**, **L594** and **L600** each cite `v2.1` as well.

**This is the `GCP-01`/`GCP-07`/`GCP-08`/`GCP-11`/`GCP-12`/`GCP-13` defect class** — *a derived statement left
behind by a change to the thing it describes* — and it is now the **seventh** recorded instance.

**Why it is disclosed and NOT fixed here.** `MASTER_PRD.md` is **Rank 1**. Baseline §7 step 1: *"A change to any
Rank 1–5 document requires an ADR **before** the change."* This ADR authorises a **Rank 6** correction; it does
**not** carry authority to edit Rank 1, and editing seven Rank 1 citations as a **side effect** of a Rank 6
version bump is the silent-amendment failure `PRD_LIFECYCLE.md` **L177** prohibits — the same trap `ADR-0019`
§3.6 and `ADR-0034` refused.

**The correction is confined and non-behavioural:** `MP-CON-08`'s *rule* — descriptive, rank 6, higher rank
wins, EA updated to match — is what governs, and it is **unchanged and self-consistent**; only the version
token trails. **No statement anywhere was made false about what the EA says.**

**Routed as `Q-A6` — Architecture Owner + Governance Owner:** update the seven `v2.1` citations in
`MASTER_PRD.md` (and baseline §4 **L221**, §5 **L247**) to `v2.2` under their own ADR. **This does not block
`PRD-008`** — it is a governance-hygiene item, and it is logged here so it is not discovered later as a
mystery.

---

## §12 Objections, stated before they are raised

**"Ten decisions were conferred, so all ten gaps should be closed."**
Four are. Six are not, and each has a measured reason: three need an authority act nobody has performed
(`Q-P1`/`Q-P2`/`Q-P3`, `Q-S1`, `Q-G1`), two need a document that does not exist (`Q-G2`/`Q-B31`), and one needs a
`PRD-008` edit outside an ADR's authority (§6.1). **Rule 5 requires recording the owner rather than pretending.**

**"You refused two explicit instructions. That is insubordination."**
It is Rule 2 and Rule 3 applied to Rule 1's own words. The instruction that says *"create the webhook contract"*
sits beside the instruction that says *"do not invent APIs, schemas, providers"* — a webhook contract **is** an
API and a schema. The instruction that says *"exclude discounts **if not required for V1**"* contains its own
precondition, and **Rank 4 BC Map L374 measures it false**. Executing either would have required overriding a
higher-ranked document, which `MP-CON-08` calls *"a **defect** to be raised, not a choice to be made."*
**Both instructions are recorded verbatim, and the collision is reported — which is what the standing rule
requires.**

**"You edited the EA — a Rank 6 document — without an ADR first."**
This **is** the ADR, and it precedes nothing: the edit was made under it, in the same commit, per baseline §7
steps 1–3. And the edit runs in the **only** direction `MP-CON-08` permits — Rank 6 corrected **to match** Rank 4.

**"Accepting `ADR-0039` while calling its §7 stale is having it both ways."**
§7 is not a decision; it is a **measurement with a timestamp**. The four decisions in §3–§6 are what bind. §7's
own §7.2 prescribed the sequence that has since been executed, so the section is **self-superseding by design**.
Editing it would destroy the evidence that the process was followed.

**"`FEE-GAP-003` got a decision, so why is it still blocking?"**
Because its `Freeze` field does not ask *"is bank transfer V1?"* — it asserts that a method used in practice but
unrepresentable is a defect, and its `Impact` row predicts staff will **mis-record NEFT as cash**. A decision to
omit the method is the condition that warning describes. §6.3 states the surviving question precisely.

**"The EA bump broke `MP-CON-08`."**
Disclosed in §11 as the seventh instance of a known defect class, with an owner and a route. It is a **stale
version token**, not a false statement about structure, and fixing Rank 1 as a side effect of a Rank 6 edit is
the failure mode the precedents refuse.

---

## §13 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **Created `ACCEPTED`. Executes ten conferred V1 decisions; `PRD-008` Freeze blockers 10 → 6.** ✅ **Closed four:** `FEE-GAP-004` (by **accepting `ADR-0039`** under conferred Architecture-Owner authority, **scoped** to §3–§6 with §2 as a report and **§7 marked stale-but-unedited**), `FEE-GAP-001` (by executing the **`MP-CON-08`** correction to the **Rank 6** EA — **one token**, `Refunds (V2)` → **`Refunds (V1)`** at **L823**, `v2.1` → **`v2.2`**, with baseline §3.2 updated in the same commit), and `FEE-GAP-005`/`FEE-GAP-006`, which needed only `ADR-0039` to bind. ⚠ **Narrowed three to a single named residual each:** `FEE-GAP-009` — the **Rank 4** reading is **ratified** (invoice = issued representation of `FeeDue`, **no sixth aggregate member**; EA L1413 measured as a **Rank 6 Business-Platform billing capability**, not authoritative architecture to the contrary), leaving a **`PRD-008` §29.3** restructuring that is a specification act, not a decision; `FEE-GAP-012` — limb **(b)** closed by the **`MM-GAP-010`** precedent with **no edge invented** and limb **(d)** already closed, leaving **(a)** blocked by **`GCP-14`** and **(c)** blocked because **both report-tier lines are Rank 6**, so `MP-CON-08` structurally cannot arbitrate; `FEE-GAP-003` — the **NOT-V1 deferral is recorded and binding**, and **no `FEE-XC-024` was minted** (the §0.2 total stays **249** and obligation-bearing **134**, per the document's own *"inventing new obligations to look thorough would have been the failure mode"*), leaving the question its own `Impact` row raises. ⛔ **Reported two conferred instructions as UNEXECUTABLE rather than working around them:** *"create/define the PRD-019 webhook contract"* — a wire contract **is** endpoint + schema + signature + replay window + retry policy, which **Rule 2** forbids inventing, and **all four candidate authors are barred** (`ADR-0040` §2, re-verified; `PRD-019` measured **0 files** at HEAD) — so `PRD-019` was **not created** and no schema, endpoint, signature algorithm or provider was invented; and *"if not required for V1, defer/exclude discounts"* — whose **precondition is measured FALSE**, because **Rank 4** BC Map **L374** requires *"discount requires an authorised approver role"*, BC Map **L100** puts discounts in **V1**, and `PRD-008` already specifies `FEE-FR-038`…`041`, `FEE-INV-007` and `FEE-AC-049`; excluding them would subordinate **Rank 4 to a V1 scope note**, the exact inversion `MP-CON-08` forbids. **The ceiling limb WAS executed as instructed — no ceiling, range or `FEE-CFG-*` was created.** `FEE-GAP-011` was **routed exactly as instructed** with an explicit ⛔ V1-decision-required marker and **no retention period invented**. **Nine open items are routed with exact questions and named owners** — `Q-A5`, `Q-A6`, `Q-P1`, `Q-P2`, `Q-P3`, `Q-S1`, `Q-G1`, `Q-G2`, `Q-B31`, plus one `PRD-008` document-owner edit. ⚠ **One new drift is disclosed rather than absorbed (§11):** the EA bump makes **`MP-CON-08`**'s *"v2.1"* citation stale in **Rank 1** `MASTER_PRD.md` (7 occurrences) — the **seventh** instance of the `GCP-01`/`07`/`08`/`11`/`12`/`13` derived-statement class — and it is **deliberately NOT fixed**, because editing Rank 1 as a side effect of a Rank 6 bump is the silent-amendment failure baseline §7 step 1 and `PRD_LIFECYCLE.md` L177 prohibit. **Creates no `BC-*`, `E-*` edge, permission, role, API, endpoint, schema, signature algorithm, provider, `FEE-CFG-*`, configuration identifier, financial rule or new `FEE-*` identifier of any kind. Modifies no frozen document, no Rank 1–5 document, no `ACCEPTED` ADR (`ADR-0035`/`0037`/`0040` all unchanged) and no checker. Does not edit `ADR-0041`, which remains `PROPOSED` with `Decision by` = "Nobody." Marks no gap RESOLVED that an authority did not resolve. `PRD-008` is NOT frozen. No Dart source touched — 0 files.** |
