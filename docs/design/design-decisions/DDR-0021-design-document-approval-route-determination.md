<!-- LIBOORA Design Documentation | Design Decision Record | 2026-09-19 -->

> This document is design governance and documentation. ⛔ It does **not** amend product
> requirements, architecture decisions, bounded-context ownership, permissions, roles,
> scopes or backend contracts. ⛔ It **approves no design artifact.**

# DDR-0021 — The design-document approval route already exists; ⛔ no governance amendment is required

| Field | Value |
|---|---|
| **Register** | ⭐ Filed under [`README.md`](README.md) §2's required template and §4 filing rules |
| **Status** | ⭐ **CONFIRMED** — ⭐ a **process determination**, recorded under `DESIGN_OWNERSHIP.md` §1 L19: the Design Governance Owner's approval basis is *"Founder/Product Authority for model; **governance record for process**"* |
| **Date** | 2026-09-19 |
| **Owner** | ⭐⭐ **Design Governance Owner** — ⭐ §1 L19 constitutes this office as owning *"design governance, gates, **status vocabulary**, and decision hygiene"* |
| **Approver** | ⭐ **The governance record itself**, for a **process** determination *(§1 L19)*. ⛔ **NOT** the Founder/Product Authority — ⭐ no governance *model* is changed here |
| **Scope** | ⭐ How a Design Doc (`DD-*`) lawfully leaves `PROPOSED`. ⛔ **Not** any individual artifact's approval |
| **Change class** | ⭐ **D1 — clarification** *(`DESIGN_CHANGE_MANAGEMENT.md` §1)*: ⛔ **0** behavioural impact, ⛔ **0** new rule |
| ⛔ **What this record does NOT do** | ⛔ Does **not** approve `DD-0008` or any `DD-*` · ⛔ does **not** modify `DD-0008` *(byte-unchanged, `9e0feb2e`)* · ⛔ does **not** amend `DESIGN_GOVERNANCE.md`, `DESIGN_OWNERSHIP.md`, `DESIGN_DEBT.md` or `README.md` · ⛔ does **not** record a gate · ⛔ does **not** close `DBT-008` · ⛔ **0** PRD, ADR, role, permission, scope or product decision touched |

---

## 1. ⭐⭐ Decision

⭐⭐ **An `APPROVED` design-document status IS intended by current governance, the route
to it ALREADY EXISTS, and ⛔ NO formal amendment is required to define it.**

⭐ The route is an **ownership** instrument, ⛔ **not** a gate outcome:

| Step | Source | Text |
|---|---|---|
| **1. The status exists** | `DESIGN_GOVERNANCE.md` §2 **L23** | ⭐ *"`APPROVED` — Accepted by the Founder/Product Authority **or the applicable repository authority**."* |
| **2. It applies to `DD-*`** | [`../../35-design/README.md`](../../35-design/README.md) §4 **L468** | ⭐⭐ *"`APPROVED` — Accepted by **the applicable authority**"* — ⭐ stated in the Design Doc status table, ⭐ expressly using *"the vocabulary already established by `DESIGN_GOVERNANCE.md` §2 **rather than a second competing set**"* |
| **3. Who the applicable authority is** | `DESIGN_OWNERSHIP.md` §1 **L20** | ⭐⭐ **UX Architecture Owner** — Authority: *"**Approves UX architecture artifacts**"* |
| **4. It must be conferred** | `../../35-design/README.md` §5.1 **L503** | ⛔ *"It cannot confer freeze, approval or baseline status. Those are **conferred, not claimed**."* |
| **5. Evidence form** | `DESIGN_OWNERSHIP.md` §3 | ⭐ Must name *"the artifact, version, decision status, approver role, date, and unresolved conditions"* |

⭐⭐ **A Design Doc is approved by the office that owns its subject matter, evidenced per
§3. That is the whole route, and it was operative before this record.**

---

## 2. ⭐⭐ The reasoning error this record corrects

⚠️⚠️ **The `DD-0008` G0 review reached a WRONG systemic conclusion, and it is corrected
here rather than quietly replaced.**

⭐ That review measured `DESIGN_GOVERNANCE.md` §4 **L42** correctly — gate `G0` carries
decision status **`CONFIRMED`**, ⛔ not `APPROVED` — and then inferred that **no gate
emits `APPROVED`, therefore no approval route exists for a design document.**

⛔⛔ **The inference does not follow.** ⭐ The error is a **column misreading**:

| Instrument | What §4's *"Decision status"* column states | What it does **not** state |
|---|---|---|
| ⭐ **Gate record** *(§4)* | ⭐ The status **the gate record itself** carries when the gate is recorded | ⛔ The status of the **artifact** that passed through it |
| ⭐ **Artifact status** *(§2 + 35-design §4)* | ⭐ The status **a document** carries: `PROPOSED` → `APPROVED` | ⛔ Anything about gates |

⭐⭐ **Gates certify evidence. Authorities approve artifacts.** ⭐ These are two registers
answering two questions, and ⛔ neither is the other's bottleneck. ⭐ Reading them as one
instrument produced a phantom deadlock — the appearance of a governance vacuum where
`DESIGN_GOVERNANCE.md` §2 **L23** had defined the status all along.

⭐ **The error was conservative in effect** *(it refused an approval rather than granting
one)*, ⛔ **but it was still an error**, and it mis-routed a systemic amendment question to
this office when the governance was already sufficient.

### 2.1 ⭐ The same misreading has a second, independent witness

⚠️ [`../LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md`](../LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK.md)
§10 refused to record `G0` — ⭐ **correctly**, on the Author-≠-Owner ground
*(`DESIGN_GOVERNANCE.md` §5 **L58** *"Design Documentation **Author**"* vs §4 **L42**
*"Design Documentation **Owner**"*; `DESIGN_OWNERSHIP.md` §2 *"separate **by design**"*)*.
⭐⭐ **That refusal stands and is not disturbed.** ⛔ But it too treated gate progress as the
approval path — §10 *"Consequences: Moves gates **0/6 → 1/6**"* — ⭐ which is why the
approval route went unnoticed twice.

---

## 3. ⭐⭐ The route is not theoretical — it has been exercised 14 times

⭐ Measured across [`DDR-0001…0011`](DDR-0001-to-0009-founder-product-authority-decisions.md)
and [`DDR-0017…0020`](DDR-0017-to-0020-founder-product-authority-closure-decisions.md):

| Measure | Value |
|---|---|
| DDR records existing | ⭐ **15** |
| ⭐ Carrying **`APPROVED`** in the Status field | ⭐⭐ **14** |
| ⛔ Not approved | ⭐ **1** — `DDR-0006` *(`PROPOSED`, provisional; approver **PENDING — Technical Owner**)* |
| ⚠️ Approved **with an open conflict** | **1** — `DDR-0010` |
| ⚠️ Approved **in part** | **1** — `DDR-0002` *(requirement `APPROVED`; family `TO BE DECIDED`)* |

⭐⭐ **`APPROVED` is therefore a live, exercised, operative status in this repository — ⛔
not an orphaned vocabulary entry.** ⭐ `DDR-0001` *(colour tokens)*, `DDR-0004`
*(accessibility minimums)* and `DDR-0005` *(breakpoints)* were each approved **without any
gate being recorded**, which is the clearest available proof that ⛔ **gate progress is not
a precondition of approval.**

⚠️ **One arithmetic discrepancy, disclosed and ⛔ NOT resolved here:** `DDR-0020` states
*"**13** are `APPROVED`"*; ⭐ direct measurement of the Status fields yields **14**
*(15 records − `DDR-0006`)*. ⭐ The likely cause is `DDR-0020` excluding `DDR-0010` for its
open conflict. ⛔ **Correcting that count is `DDR-0020`'s own execution act**, owned by the
**Design Documentation Owner**; ⛔ it is not taken here. ⭐ Either figure sustains this
determination.

---

## 4. ⭐ The six questions, answered

| # | Question | ⭐ Determination |
|---|---|---|
| **1** | Is an `APPROVED` design-document status actually intended? | ⭐⭐ **YES.** `DESIGN_GOVERNANCE.md` §2 **L23** defines it; `../../35-design/README.md` §4 **L468** applies it to `DD-*` by name; ⭐ **14** DDRs already carry it |
| **2** | Which existing gate/authority is authorized to produce it? | ⭐⭐ **No gate produces it — an *authority* does.** For a **UX architecture artifact** such as `DD-0008`: the **UX Architecture Owner** *(`DESIGN_OWNERSHIP.md` §1 **L20**: "Approves UX architecture artifacts")*. ⭐ Escalation: **Design Governance Owner**; ⭐ product-scope questions to **Founder/Product Authority** |
| **3** | If no — what mechanism instead? | ⭐ **Not reached.** ⛔ The premise fails at Q1 |
| **4** | Does governance need a formal amendment? | ⛔⛔ **NO.** ⭐ Status *(§2 L23)*, artifact applicability *(35-design §4 L468)*, competent office *(§1 L20)*, conferral rule *(§5.1 L503)* and evidence form *(§3)* are **all already in force**. ⭐⭐ **The gap was in reading, not in the rules** — ⛔ and amending sound governance to cure a misreading would be the worse remedy |
| **5** | Is independent review required, and who is constituted? | ⭐⭐ **YES, and the office exists.** `DESIGN_OWNERSHIP.md` §2: author, reviewer, implementation mechanism and final business authority are *"**separate by design**"*. ⭐ `DESIGN_GOVERNANCE.md` §5 constitutes **GPT-5.6 Luna — Independent Reviewer / Validator** *(may identify omissions, contradictions, broken links, traceability gaps; ⛔ "Cannot act as final authority")*. ⛔⛔ **It is NOT the Design Documentation Author** *(§5 L58 — Opus 5)*, which authored `DD-0008` |
| **6** | Should `DD-0008` remain `PROPOSED`? | ⭐⭐ **YES — but ⛔ NOT because anything systemic blocks it.** ⭐ It remains `PROPOSED` for the ordinary reason: ⛔ **the UX Architecture Owner has not acted.** ⭐ `../../35-design/README.md` §4 makes `PROPOSED` *"the default for a new Design Doc"* — ⭐ `DD-0008` is simply **awaiting its owner**, ⛔ not stranded |

---

## 5. ⭐ Alternatives considered and refused

| # | Option | ⛔ Why refused |
|---|---|---|
| **1** | ⛔ **Amend `DESIGN_GOVERNANCE.md` §4 to add an `APPROVED` gate outcome** | ⛔⛔ **Would invent a gate outcome** — expressly prohibited by this conferral, and ⛔ unnecessary: §2 L23 already defines the status. ⭐ It would also **corrupt** the gate table, whose `CONFIRMED`/`PROPOSED` values are correct as written |
| **2** | ⛔ **Add a `G6 Approval` gate** | ⛔ A **new gate** is a governance-model change requiring Founder/Product Authority, ⛔ to solve a problem that does not exist |
| **3** | ⛔ **Redefine `G0` or `G1` to emit `APPROVED`** | ⛔ Expressly prohibited *("Do not silently redefine G0/G1")*, and ⛔ it would destroy the evidence/authority distinction §2 above restores |
| **4** | ⛔ **Approve `DD-0008` here** | ⛔⛔ Expressly prohibited. ⭐ Also **not this office's act**: `DD-0008` is a **UX architecture artifact** *(§1 L20)*. ⭐ The Design Governance Owner owns the *process*, ⛔ **not the artifact** |
| **5** | ⛔ **Treat authorship as approval** | ⛔ Expressly prohibited; ⛔ barred by `DESIGN_OWNERSHIP.md` §2 and the §10 precedent at §2.1 above |
| **6** | ⛔ **Declare the route missing and STOP for an amendment authorization** | ⚠️⚠️ **The most tempting option** — ⭐ it would have looked rigorous. ⛔ **But it would have been FALSE.** ⭐ The conferral said *"Do NOT assume that `APPROVED` is the correct status if the repository defines another final status"*; ⭐ I tested that and found the repository defines **`APPROVED` itself**, in two places, for `DD-*` by name. ⛔ Escalating for an amendment would have asked an authority to legislate a rule it had **already made** |
| **7** | ⛔ **Fix the stale counts in `README.md` §3 and `DBT-008`** | ⛔ A **different act** — `DDR-0020`'s execution, owned by the **Design Documentation Owner**. ⛔ `DESIGN_DEBT.md` filing rule 5: *"A row is never closed by editing the document it indicts"* |
| **8** | ⛔ **Consume `DBT-009` for a new debt row** | ⛔ `DBT-009` is a **named candidate** for `FA-GAP-003` *(`LIBOORA_DESIGN_SYSTEM_FINAL_AUDIT.md` **L353**)*. ⛔ Taking it would collide with a reserved identifier |

---

## 6. ⭐ Consequences

* ⭐⭐ **`DD-0008` is unblocked as a matter of governance.** ⭐ Its next step is a **UX
  Architecture Owner** approval act, evidenced per `DESIGN_OWNERSHIP.md` §3. ⛔ **No
  amendment, no new gate and no Founder act stands in the way.**
* ⭐⭐ **This generalises to all 8 Design Docs.** ⭐ `DD-0001`…`DD-0008` all read `PROPOSED`;
  ⛔ none was blocked by a missing route. ⚠️ **Each remains blocked by its own substantive
  blockers** *(`DD-0004`: 5 hard blockers · `DD-0006`: 5 · `DD-0007`: not design-ready)* —
  ⛔ **this record clears none of those.**
* ⛔ **`DBT-008` is NOT closed.** ⭐ Its surviving limb — *"Gates `G0`–`G5` exist and none
  has been recorded as passed"* — ⭐ **remains true at 0 of 6**. ⭐ `DDR-0020` already
  directed that the row be **corrected, not closed**; ⭐ this record supplies a further
  reason it is **due for review** and ⛔ takes no closure.
* ⛔ **Gate `G0` remains unrecorded for every artifact.** ⭐ Recording it stays a **Design
  Documentation Owner** act *(`CP-F`, **READY**)*. ⭐⭐ **It is no longer on the critical
  path to approving a Design Doc** — ⛔ though `G5` still requires the gate record, so
  `CP-F` retains its value.
* ⚠️ **Approval of a Design Doc approves nothing else.** ⭐ `DESIGN_GOVERNANCE.md` §3 rule
  5: *"Design approval does not approve a PRD, architecture decision, implementation, or
  release."*

---

## 7. ⚠️ Open questions — ⛔ routed, NOT resolved

| # | Question | Owning office |
|---|---|---|
| **1** | ⭐ Whether `DESIGN_GOVERNANCE.md` §4 should carry a **one-line pointer** distinguishing *gate* decision status from *artifact* status. ⚠️ **Twice misread** — ⛔ a **documentation-clarity** question, not a rule gap; ⛔ deliberately not amended here | **Design Governance Owner** *(a later, separate act)* |
| **2** | ⭐ Register-count corrections in `README.md` §3 and `DBT-008`, incl. the **13 vs 14** discrepancy at §3 | **Design Documentation Owner** *(`DDR-0020` execution)* |
| **3** | ⭐ Whether `DBT-008` is re-scoped to its surviving gate limb | **Design Governance Owner** *(already open per `DDR-0020`)* |
| **4** | ⭐ Whether `DD-0008` approval requires the Independent Reviewer's pass **first**, or concurrently. ⛔ `DESIGN_OWNERSHIP.md` §2 requires separation; ⛔ it prescribes **no sequence** | **Design Governance Owner** *(sequence)* + **UX Architecture Owner** *(exercise)* |
| **5** | ⭐ Whether `DG-1`…`DG-7` must be resolved before approval, or may be carried as *"unresolved conditions"* under §3. ⭐ **Precedent favours carrying them**: `DDR-0002` and `DDR-0009` were approved **with named holes** | **UX Architecture Owner** |
| **6** | ⛔ No **gate-record template** exists — `templates/` holds component, screen and QA-evidence forms only *(`CP-F` field 6)* | **Design Governance Owner** |

⛔⛔ **Item 1 is deliberately left undone.** ⭐ The conferral permitted *"the minimum
necessary governance decision/finding"*; ⭐ a finding **is** the minimum. ⛔ Editing the
governance file itself would exceed it — and ⭐ §4 is **not wrong**, only terse.

---

## 8. ⭐ Review trigger

⭐ The first `DD-*` approval act · ⭐ any amendment to `DESIGN_GOVERNANCE.md` §2 or §4 ·
⭐ any amendment to `../../35-design/README.md` §4 · ⭐ the first recorded gate pass ·
⭐ constitution of any new artifact-approving office.

---

## 9. ⭐ Identifier hygiene

⭐ **`DDR-0021` measured free** — **0** repository-wide occurrences before this file.
⭐ `DDR-0012`…`DDR-0016` are **reserved** for other offices' future decisions
*(`DDR-0017…0020` identifier-hygiene note)* and ⛔ **remain unused**; ⭐ `DDR-0013` in
particular stays reserved for the layer-ratio reconciliation. ⛔ **`DDR-0022`…`0030`
measured free and NOT allocated.** ⛔ `DBT-009` **not consumed** *(§5 option 8)*.

⚠️ **Registration disclosure.** ⭐ `README.md` §4 requires a record be *"added to this
register"*; ⭐ §3 is **prose, not a table**, and its text is **factually stale**. ⭐ **All
15 prior DDR records were filed as files in this directory without editing §3** — ⛔ this
record follows that precedent exactly, and ⭐ routes the §3 correction at §7 item 2 rather
than performing another office's act to satisfy a filing formality.

---

## 10. ⭐⭐ Authority record

| Field | Value |
|---|---|
| **Office exercised** | ⭐⭐ **Design Governance Owner** — single act: resolving the systemic design-approval governance question |
| **Source of authority** | ⭐ Direct conferral from the human principal, this turn |
| **Basis for recording without Founder act** | ⭐ `DESIGN_OWNERSHIP.md` §1 **L19** — Design Governance Owner approval is *"Founder/Product Authority **for model**; **governance record for process**"*. ⭐⭐ This is a **process** determination: ⛔ **0** governance model changed |
| ⛔ **Not claimed** | ⛔ **No independent review is claimed** *(per the conferral)*. ⛔ Not the UX Architecture Owner, Design Documentation Owner, Founder/Product Authority, Product, Architecture or Accessibility Owner |
| ⛔ **Not reused** | ⛔ The `ADR-0167`/`0170` **Architecture Owner** conferrals · ⛔ `ADR-0168`/`0169` **Product Owner** exercises · ⛔ `ADR-0162`/`0164`/`0165`/`0166` **Authorization Owner** conferrals · ⛔ the `DD-0008` **UX Architecture Owner** conferral · ⛔ the `DD-0008` **Design Documentation Owner** conferral *(all spent)* |
| ⭐⭐ **Reversion** | ⭐⭐ **Reverts on completion of this act** — the issuance of this record. ⛔⛔ **Approving `DD-0008`, amending any governance file, or recording any gate requires a NEW conferral or the competent office** |

### 10.1 ⛔ Execution ledger

| Act | Result |
|---|---|
| Files created | ⭐ **1** — this record |
| Files modified | ⛔ **0** |
| `DD-0008` | ⛔ **Byte-unchanged** *(`9e0feb2e`)*, ⛔ **still `PROPOSED`**, ⛔ **not approved** |
| `DESIGN_GOVERNANCE.md` / `DESIGN_OWNERSHIP.md` / `DESIGN_DEBT.md` / `README.md` | ⛔ **Byte-unchanged** |
| Gates recorded | ⛔ **0** — ⭐ still **0 of 6** |
| Gate outcomes invented | ⛔ **0** · `G0`/`G1` redefined: ⛔ **0** |
| Debt rows closed | ⛔ **0** · Conflicts resolved: ⛔ **0** |
| PRD / ADR / architecture / role / permission / scope / product decision | ⛔ **0 touched** · ⛔ **0** `PERM-*` |
| Code / tests | ⛔ **0 lines** |
| Commit / push | ⛔ **Not performed** |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| ⭐ **v1.0** | 2026-09-19 | ⭐⭐ **Created as `CONFIRMED`. Determines that the design-document approval route ALREADY EXISTS and ⛔ NO governance amendment is required.** ⭐⭐ **The `DD-0008` G0 review's systemic conclusion is CORRECTED, not quietly replaced** *(§2)*: it measured §4 **L42** correctly — `G0` emits **`CONFIRMED`** — then wrongly inferred that **no route to `APPROVED` exists at all**. ⭐⭐ **The error was a COLUMN MISREADING** — §4's *"Decision status"* is the status **the gate record** carries, ⛔ **not** the status of the artifact passing through it. ⭐⭐ **GATES CERTIFY EVIDENCE; AUTHORITIES APPROVE ARTIFACTS** — two registers, two questions, ⛔ neither the other's bottleneck. ⭐ The route measured in **five** in-force clauses: `DESIGN_GOVERNANCE.md` §2 **L23** defines `APPROVED`; `35-design/README.md` §4 **L468** applies it to `DD-*` **by name**, expressly reusing §2's vocabulary *"rather than a second competing set"*; `DESIGN_OWNERSHIP.md` §1 **L20** names the **UX Architecture Owner** as competent for a UX architecture artifact; §5.1 **L503** requires it be *"conferred, not claimed"*; §3 fixes the evidence form. ⭐⭐ **THE ROUTE IS EXERCISED, NOT THEORETICAL — 14 of 15 DDRs CARRY `APPROVED`** *(§3)*, and ⭐⭐ `DDR-0001`/`0004`/`0005` were approved **with 0 gates recorded**, which is the clearest proof that ⛔ **gate progress is NOT a precondition of approval**. ⚠️ **A 13-vs-14 count discrepancy against `DDR-0020` is DISCLOSED and ⛔ NOT resolved** — that correction is the Design Documentation Owner's act. ⭐ **All six conferred questions answered** *(§4)*: `APPROVED` **is** intended · produced by an **authority, not a gate** · ⛔ **no amendment needed** · **independent review IS required** and is constituted as **GPT-5.6 Luna** *(`DESIGN_GOVERNANCE.md` §5)*, ⛔ **expressly not the Design Documentation Author that wrote `DD-0008`** · `DD-0008` **stays `PROPOSED`**, ⛔ but only because its owner has not acted — ⛔ **not because anything systemic blocks it**. ⭐ **EIGHT OPTIONS REFUSED** *(§5)*, ⚠️ the most tempting being **option 6** — declaring the route missing and stopping for an amendment authorization, ⛔ which would have looked rigorous and been **FALSE**: it would have asked an authority to legislate a rule it had **already made**. ⭐ **THE CONFERRAL'S OWN WARNING WAS DISPOSITIVE** — *"Do NOT assume `APPROVED` is correct if the repository defines another final status"*; ⭐ tested, and the repository defines **`APPROVED` itself**. ⭐ `LIBOORA_DESIGN_AUTHORITY_CLOSURE_PACK` §10's Author-≠-Owner refusal **STANDS UNDISTURBED** *(§2.1)* — ⭐ correct on its own ground, ⛔ and a second witness to the same misreading. ⭐ **SIX OPEN QUESTIONS ROUTED, ⛔ NONE RESOLVED** *(§7)*, ⭐ including a deliberate refusal to amend §4 for clarity when a **finding** was the stated minimum. ⛔ **`DBT-008` NOT closed** — its gate limb is still true at **0 of 6**. ⛔ **0 files modified** · ⛔ **0 gates recorded** · ⛔ **0 gate outcomes invented** · ⛔ **`G0`/`G1` NOT redefined** · ⛔ **0 debt rows closed** · ⛔ **0 PRD/ADR/role/permission/scope/product decisions** · ⛔ **0** `PERM-*` · ⛔ **0 code** · ⛔ **`DD-0008` byte-unchanged, `PROPOSED`, NOT approved** · ⛔ **no commit, no push**. ⭐⭐ **The conferral has REVERTED ON COMPLETION.** |
