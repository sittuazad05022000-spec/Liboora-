# ADR-0043 — `PRD-019` creation, and the closure of `PRD-008`'s six remaining Freeze blockers

| Field | Value |
|---|---|
| **ADR** | `ADR-0043` |
| **Title** | `PRD-019` creation, and the closure of `PRD-008`'s six remaining Freeze blockers |
| **Date** | 2026-08-15 |
| **Status** | **`ACCEPTED`** — by direct conferral of authority by the human principal: **Product Owner** for the scope decisions (FEE-GAP-003, 007, 011, 012(c)), **Architecture Owner** for the model determinations (FEE-GAP-002 ownership, FEE-GAP-009, `Q-A6`), **Governance Owner** for the register acts (`PRD-019` creation, `PRD-008` status). Same disclosure as `ADR-0032` §5.2, `ADR-0035`, `ADR-0037`, `ADR-0039` and `ADR-0042`: **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *a conferral for one act is not a standing licence* |
| **Supersedes** | Nothing |
| **Amends** | **`PRD_REGISTRY.md`** (Rank: **unranked** — §Precedence L11 places it *"below every document it lists"*; not a Rank 1–5 baseline document, so baseline §7 step 1 requires no prior ADR — this ADR is nonetheless written **first**) · **`ADR-INDEX.md`** (unranked register) · **`PRD-008`** (Rank 3-**registered**, not Rank 3-**holding** — `PLANNED`/`DRAFT`, never admitted to the baseline) |
| **Does NOT amend** | **`MASTER_PRD.md`** (Rank 1) · **BC Map** (Rank 4) · **Dependency Matrix** (Rank 4) · **the EA** (Rank 6) · **any frozen PRD** · **any `ACCEPTED` ADR** · **`tool/module_dependencies.yaml`** · **any gate under `tool/`** |
| **Affects** | `BC-05`, `BC-31`; `FEE-GAP-002`, `003`, `007`, `009`, `011`, `012`; `PRD-019` (created); `Q-A6` |
| **Outcome** | **`PRD-008` Freeze blockers 6 → 0.** ⛔ **`PRD-008` is NOT frozen by this ADR** — see §10 |

---

## 1. Context

`ACCEPTED` [`ADR-0042`](./ADR-0042-prd-008-freeze-blocker-execution-and-residual-routing.md) took `PRD-008`'s
Freeze blockers from **10 to 6** and did something more useful than clearing them: it **narrowed each survivor to
exactly one named residual with exactly one named owner**, and it **refused to perform two conferred
instructions** that could not be executed lawfully.

Those refusals were the point. The principal has now returned decisions that answer them.

### 1.1 The six decisions conferred, and what each actually required

| Gap | Decision conferred | Kind | Disposition |
|---|---|---|---|
| **`FEE-GAP-002`** | Create `PRD-019` as owner of the webhook wire contract; `PRD-008` owns verification and financial truth only; **do not duplicate the contract in `PRD-008`** | **Governance act** — it removes a *procedural* bar, not a substantive one | ✅ **CLOSED.** §3 |
| **`FEE-GAP-003`** | Bank transfer is **not** a V1 payment method; money arriving outside supported flows **must not automatically become a confirmed payment**; confirmation stays server-authoritative | **Product scope + a rule that already exists** | ✅ **CLOSED.** §4 |
| **`FEE-GAP-007`** | Owner is the ultimate approval authority; **Manager has NO approval access by default**; Owner may grant it **through the existing access-control mechanism**; **do not invent a permission ID** | **Product scope, expressible in existing vocabulary** | ✅ **CLOSED.** §5 |
| **`FEE-GAP-009`** | Invoice is an **issued document representation** of `FeeDue`, not a separate financial state machine; **correct the conflicting three-state Invoice documentation** | **Architecture ratification + a documentation repair** | ✅ **CLOSED.** §6 |
| **`FEE-GAP-011`** | **Do not invent a retention period.** Record that retention/purge policy requires Product + Security/Compliance approval and must follow approved legal/compliance policy | **A governance position, which is itself the answer** | ✅ **CLOSED.** §7 |
| **`FEE-GAP-012`** | Resolve registry status, the `BC-26` edge and the report tier using **existing** Governance/Product/Architecture authority and **existing precedents**; **do not invent a new edge or architecture** | **Three separate acts under three existing authorities** | ✅ **CLOSED.** §8 |

**Plus:** *"resolve `Q-A6` only through the proper authority: do not silently modify Rank-1 `MASTER_PRD`."* — §9.

### 1.2 The distinction this ADR is built on

`ADR-0042` refused two instructions because performing them would have **invented** things Rule 2 forbids. The
new decisions are executable for a reason worth naming precisely:

- **`FEE-GAP-002`** previously asked this pass to *author a wire contract*. It now asks only to **create the
  document that will own it**. Those are different acts. The contract is still unwritten — and this ADR says so.
- **`FEE-GAP-007`** previously rested on a **precondition measured FALSE** (that discounts were not V1). The new
  decision **supplies the missing approver fact** instead, so no precondition is needed.

> **What has NOT happened.** No decision here reverses a measurement. Where the previous pass reported a
> collision, this pass records that the principal **answered the underlying question** — it does not record that
> the collision was imaginary.

---

## 2. Decision — summary

1. **`PRD-019_INTEGRATION.md` is created at `v0.1 DRAFT`**, assigning the payment-webhook **wire contract** to
   `BC-31` and **authoring none of it**.
2. **Bank transfer is not V1.** Money arriving outside a supported flow **cannot** become a confirmed payment —
   already specified, now confirmed and pointed to.
3. **`owner` is the sole discount approver by default.** `manager` has none. Grants ride the **existing** RBAC +
   scope mechanism (`MP-GBR-20`/`21`/`23`). **No permission ID is minted.**
4. **`PRD-008` §29.3 is corrected** from a three-state table to a **projection of `FeeDue`**.
5. **Retention is a governance position**: no period invented; Product + Security/Compliance approval required;
   the approved legal/compliance policy governs.
6. **`FEE-GAP-012`**: `PRD-008` → `DRAFT` under existing registry authority · `BC-26` closed on the existing
   `MM-GAP-010` precedent with **no edge** · report tier resolved by the **existing** Rank-6-is-descriptive rule.
7. **`Q-A6` is decided by the Architecture Owner without touching `MASTER_PRD.md`.**

---

## 3. `FEE-GAP-002` — the webhook wire contract now has an owner

### 3.1 What was blocking

`ADR-0042` §7.1 reported the instruction *"create the `PRD-019` webhook contract"* as **unexecutable**, because
`ACCEPTED` `ADR-0040` **§4 L165** defines that contract as *"endpoint, schema, signature, replay window, retry
policy"* — **item for item the things Rule 2 forbids inventing** — and **L166** bars writing another PRD's
content into `PRD-008` as a *"second source of truth"*. `PRD-019` files on disk measured **0**.

### 3.2 The decision, and why it is executable

The principal's decision separates the two halves that the earlier instruction had fused:

> *"Create PRD-019 as the owner of the payment webhook wire contract. PRD-008 must only own webhook
> verification and financial truth. **Do not duplicate the webhook contract in PRD-008.**"*

**Creating an owner is not authoring a contract.** `ADR-0040` §2 listed four barred candidate authors; **three
bars were substantive and one was procedural** — `PRD-019` did not exist. Only the procedural bar is removed.

### 3.3 Executed

- **Created** `docs/30-product/integration/PRD-019_INTEGRATION.md` at **v0.1 `DRAFT`**. Its §2 assigns the five
  wire elements to `BC-31`, **recognising** BC Map **L140**, `PRD_REGISTRY.md` **L309**, `SAAS-XC-006` and
  Matrix `X-03` — creating **no** context, edge, port, module, role, permission or configuration identifier.
  Context count stays **31**.
- Its §4 records **`Q-B31`** — author the contract — as **⛔ OPEN**, owned by the `BC-31` owner. **`Q-B31` is not
  minted here**; `ADR-0042` §8 opened it.
- Its §5 reserves prefix **`ITG-*`** with **0 identifiers**, after a collision check (`ITG-` = **0**
  repository-wide; **`INT-*` refused** because `SID-INT-1`…`12` exist — `PRD_LIFECYCLE.md` §5 rule 3).
- **`PRD-008` gains no wire content.** Verified mechanically: **0** occurrences of endpoint/URL/signature
  algorithm/replay-window/retry-policy wire vocabulary added, and payment-provider mentions unchanged at **5**.

### 3.4 Why this closes the Freeze blocker when the contract is still unwritten

**Because the blocker was never "the contract is unwritten" — it was "an unwritten contract has no owner, and
freezing would bake an *unattributable* hole into a baseline."** `PRD-008` v1.6's own Freeze field states the
cause: the contract *"cannot be written by any existing document"*, so freezing would freeze *"a named, owned
hole"* — the objection being **ownerlessness**.

`BC-05`'s own obligation is **complete and testable**: `FEE-FR-028` carries `FEE-AC-085`…`089`, none naming a
wire element. The residue belongs to **`BC-31`**, and `PRD-008`'s **own established disposition** for another
context's obligation is *"BLOCKS the **feature**, not this PRD"* — used at `FEE-GAP-013`, `014` and `017`.

⚠ **This is the objection most worth stating against this section.** One could argue `PRD-008` should not freeze
while any part of its payment story is unwritten. **The answer is that the standard would freeze nothing**: by
the same test `PRD-007` could not have frozen — it is, in this register's own words, *"the first frozen PRD whose
own dependency is still unwritten."* **The precedent is not invented for this pass; it is applied to it.**

⚠ **And the honest cost:** the end-to-end gateway-webhook **feature** remains **unbuildable** until `Q-B31` is
answered. **Creating `PRD-019` made the work attributable, not done.**

---

## 4. `FEE-GAP-003` — bank transfer is not V1, and out-of-band money cannot self-confirm

### 4.1 The decision

> *"Bank transfer is NOT a V1 payment method. If money arrives outside supported payment flows, it **must NOT
> automatically become a confirmed payment**. Keep financial confirmation server-authoritative."*

### 4.2 The scope limb was already closed; the residual limb is what this answers

`ADR-0042` §6.3 recorded the NOT-V1 deferral and minted **no `FEE-XC-024`** — correctly, since `FEE-BR-011`
enumerates the attested methods and bank transfer is not among them, so an exclusion would have moved §0.2 from
**23 → 24** and **249 → 250** to record a fact twice.

The **residual** `ADR-0042` named was the operational one from the block's own `Impact` row: *"staff will record
it as cash and corrupt method-based reporting."* Two lawful answers existed — refuse to record, or record under
an existing attested method — and choosing either would have been **inventing a financial rule**.

### 4.3 The decision picks neither, and that is why it is executable

It answers a **third** question: *what may an out-of-band credit become?* Answer: **not a confirmed payment,
automatically.** And that rule **already exists in `PRD-008`, three times over**:

| Existing obligation | Line | What it already says |
|---|---|---|
| **`FEE-FR-061`** | **L1336** | A payment **MUST NOT** reach `CONFIRMED` except by a **server-side** recording |
| **`FEE-XC-022`** | **L1339** | Creating, queueing, mirroring or synchronising **any** financial write while offline is excluded |
| **`FEE-BR-014`** | §14 | An inbound notification is **evidence, never an instruction** |
| **`FEE-BR-011`** | §13 | The attested-method set is **enumerated**; bank transfer is not in it |
| Tested by | **L1761–L1762** | `FEE-AC-081`, `FEE-AC-082` |
| Ratified by | `ACCEPTED` `ADR-0037` | Financial recording is server-authoritative |

**Therefore: no requirement, rule, exclusion, criterion or identifier is written.** §0.2 stays **249 / 134 / 23**.
`PRD-008` §13.4 and the `FEE-GAP-003` block are updated to **point at** the obligations that already answer it.

> **Why this is a closure and not a dodge.** The gap asked *"is bank transfer V1?"* — answered **No** — and its
> residual asked *"then what happens when the money arrives?"* — answered **"it does not become a confirmed
> payment; only a server-side recording does that."** Both questions now have answers, and **neither answer
> required a new rule**, because the second was already specified and merely un-cited from this gap.

⚠ **What remains, and is NOT hidden:** whether a library **may** attest such a credit under an existing method
is a **V2 product question**. It is **not** a Freeze blocker for `BC-05`, because V1 behaviour is now fully
determined: the money **cannot** be confirmed automatically. **An undetermined V2 option is not an incomplete V1
specification** — the same reasoning `FEE-GAP-008` uses for partial payments, which blocks nothing.

---

## 5. `FEE-GAP-007` — `owner` is the sole discount approver by default

### 5.1 The decision

> *"Library Owner is the ultimate authority for approval access. **Manager has NO approval access by default.**
> Owner may explicitly grant approval access **using the existing permission/access-control mechanism**. **Do
> not invent a new permission ID.**"*

### 5.2 Why the previous instruction failed and this one does not

`ADR-0042` §7.2 measured the earlier *"if not required for V1, defer/exclude discounts"* precondition **FALSE** —
discounts are V1 on Rank 4 BC Map **L100**/**L374**, already specified (`FEE-FR-038`…`041`, `FEE-INV-007`) and
already testable (`FEE-AC-049`, L1893). Excluding them would have subordinated Rank 4 to a scope note.

**This decision does not need that precondition.** It supplies the **fact** BC Map **L374** left open — L374
requires *"an authorised approver role"* **without naming it**, and the Product Owner has now named it.

### 5.3 The existing mechanism, measured — no invention required

The decision says *"the existing permission/access-control mechanism"*. That mechanism is **`MASTER_PRD.md` §6.1
(L113–L123)**, and it is sufficient **as written**:

| Existing rule | Line | Why it carries the decision unaided |
|---|---|---|
| RBAC *"extended with attribute-based scoping"* | **L115** | The model is role-based; a role-level default is its native form |
| **`MP-GBR-20`** | **L119** | *"A permission grant is **scope-bearing**. Holding a permission is not the same as being able to exercise it on a given resource."* — a grant is already a first-class object |
| **`MP-GBR-21`** | **L121** | The scope register is **closed**: `self`, `guardianOf`, `tenantWide`. **`tenantWide` is the scope a library-level discount grant needs — so no fourth scope is introduced and no ADR is required for one** |
| **`MP-GBR-23`** | **L123** | One global account, **independent per-library grants** — which is exactly *"Owner may explicitly grant"*, per library |
| Roles table | **L105–L111** | `owner` = *"Complete business control."* — **the textual basis for "ultimate authority"**, already Rank 1 |

**And the bars are respected:**

- **No permission identifier is minted** — no `FEE-CFG-*`, no `FEE-PERM-*`, no new `FEE-*` of any register.
- **No role is created** — `PRD-008`'s own **`FEE-XC-014` (L1212)** forbids *"Creating any new role"*; the
  vocabulary stays the five roles of Master PRD §6, per the **`PRD-006` role-vocabulary precedent**
  cited at `PRD-008` **L1182–L1183**. *(That precedent is named here by its document rather than by its
  own requirement identifier: `tool/docs_check/prd006_traceability.py` treats a `PRD-006` identifier
  appearing outside `PRD-006` and the registry as a possible collision, and **the checker is right** — so
  this ADR changes its own wording rather than the gate.)*
- **No fourth scope** — `MP-GBR-21` stays closed.
- **No ceiling, range, minimum or maximum** — the `ADR-0042` §7.2 restraint is **preserved**, not reopened.
- **ABAC is untouched** — `MP-GBR-28` places it at **V3**; a role default plus an existing scope-bearing grant is
  RBAC, not ABAC.

### 5.4 Executed

`PRD-008` **§23.1 L1198** changes from a live unresolved marker to the decided state: **`owner` by default;
`manager` NOT by default; `owner` may grant via the existing `MP-GBR-20`/`21`/`23` mechanism.** `FEE-FR-039`
(L1001) is **not reworded** — it already requires *"an authorised approver role"*, and this fixes **who**, which
is what BC Map L374 delegated.

> **The strongest objection, stated.** *Does naming `owner` as the default "invent a permission"?* **No — and the
> distinction is precise.** Inventing a permission would mean creating an identifier, a new capability or a new
> scope. This **binds an existing invariant (L374's "authorised approver role") to an existing role (`owner`,
> "complete business control") through an existing grant mechanism (`MP-GBR-20`)**. Every element pre-exists at
> Rank 1 or Rank 4; the decision supplies only the **binding**, which is precisely what a Product Owner owns.

---

## 6. `FEE-GAP-009` — Invoice is a projection, and §29.3 is corrected

### 6.1 The decision

> *"Invoice is an issued/document representation of FeeDue, not a separate financial state machine. Keep
> financial truth in the existing FeeDue + confirmed-payment model. **Correct the conflicting three-state Invoice
> documentation.**"*

### 6.2 The reading was already ratified; the residual was a defect in `PRD-008` itself

`ADR-0042` §6.1 ratified the Rank 4 reading (BC Map **L204**, **L374**) and tested the only counter-evidence — EA
**L1413** *"Invoice Generation (V1)"* — measuring its parent as the **Rank 6** `Billing & Invoicing (V1)`
(L1412), which `DOCUMENTATION_BASELINE.md` §4 **L221** marks *"Descriptive only"*. **No sixth `FeeLedger` member
was added.**

What survived was a **documentation defect**: §29.3 (**L1409–L1419**) still printed a three-state table
(`ISSUED`/`PAID`/`CANCELLED`) with its own **Forbidden** row — a second state machine on the page — while its own
**L1418–L1419** stated the correct reading. **The document contradicted itself in adjacent lines.**

`ADR-0042` correctly declined to repair it, on `ADR-0039` §7.2's rule that an ADR *"deliberately writes no
requirement text"*. **The principal has now instructed the document's owner to make the correction**, which is
the authority §7.2 was waiting for.

### 6.3 Executed — and what makes it a repair rather than a change of substance

§29.3 is restated as an **explicit projection of §29.1**. The mapping is **derived from `FeeDue`'s existing
states, not invented**:

| Invoice label (presentation) | `FeeDue` state it projects | Source |
|---|---|---|
| `ISSUED` | **`DUE`** *(and `OVERDUE`, which is `DUE` past its date)* | §29.1 L1383–1384 |
| `PAID` | **`PAID`** | §29.1 L1385 |
| `CANCELLED` | **`CANCELLED`** | §29.1 L1386 |

**Verified before writing:** §29.1's states are `DUE`, `OVERDUE`, `PAID`, `CANCELLED` — so **every** Invoice
label maps onto an existing `FeeDue` state, and the projection is total.

- **No state value is created or deleted.** The three labels remain readable; they are **labels**, not states.
- **The `Forbidden` row is retained** — but re-attributed to §29.1's transition rules, where it always belonged,
  so it constrains **one** machine instead of implying a second.
- **`No `PARTIALLY_PAID` state exists"` (L1392) is untouched**, and `FEE-INV-002` is untouched.
- **§0.2 unchanged.** No `FEE-*` identifier added or removed.

> ⚠ **A pre-existing citation defect, disclosed and NOT silently repaired.** §29.3's `Source` column cites
> *"EA L1413"* as authority for `ISSUED`. That is a **Rank 6** capability line, ruled non-authoritative for this
> question by `ADR-0042` §6.1. The citation is left standing in the retained-superseded text and flagged, because
> **deleting the evidence that a wrong reading was once held would erase the record of correcting it.** Routed
> with the other citation defects in §11.

---

## 7. `FEE-GAP-011` — retention is a governance position, not a period

### 7.1 The decision

> *"**Do not invent a retention period.** Record that retention/purge policy requires Product +
> Security/Compliance approval and must follow the approved legal/compliance policy."*

### 7.2 Why this closes a blocker that `ADR-0042` correctly left open

`ADR-0042` §7.3 executed *"route it"* and said plainly that **a routed question is still an unanswered
question**, so Freeze's completeness bar was unmet. **That was right for the instruction it had.**

**This instruction is different in kind.** It does not ask for routing; it **states the position**: retention is
**governed by the approved legal/compliance policy**, and any change requires **Product + Security/Compliance
approval**. That is a **complete, actionable, auditable V1 position** — and it is the only *lawful* one, because
`PRD-008` is **not competent** to determine Indian statutory retention. **A specification that says "this is
determined by compliance policy, and here is who approves a change" is complete; one that invents "7 years" is
merely confident.**

### 7.3 Executed

- **No period, no purge rule, no minimum, no maximum.** `FEE-XC-011` (L1144, L1520) is **byte-unchanged** and
  still forbids purging entirely — which is now recorded as **the V1 position**: *purge nothing pending an
  approved policy*, not *an unanswered question*.
- The `Impact` row's warning is **preserved verbatim** — *"an absolute never-purge rule may itself be
  non-compliant"* — and is now correctly framed as **the trigger for the named approval**, not a defect.
- ⚠ **`Q-S1` is NOT closed as an operational item.** The **compliance approval itself is still outstanding**;
  what is closed is `PRD-008`'s **specification obligation**. Recorded in §11 and in the gap block.

> **The objection, stated against this section.** *Is "follow the policy" a specification, or a promise?* It is a
> specification **because it is falsifiable in both directions**: today `FEE-XC-011` forbids all purging, and any
> departure requires a named joint approval. An implementer knows exactly what to build (**no purge path**) and
> exactly what would change it. **That is more than most retention clauses deliver, and it invents nothing.**

---

## 8. `FEE-GAP-012` — three limbs, three existing authorities

### 8.1 The decision

> *"Resolve registry status, BC-26 edge, and report tier using the existing Governance/Product/Architecture
> authority and existing precedents. **Do not invent a new edge or architecture.**"*

Limbs **(b)** and **(d)** were already closed by `ADR-0042` §6.2 — (d) by the gate existing at exit 0, (b) by the
`ACCEPTED` `ADR-0019` §3.1 `MM-GAP-010` precedent with **no edge invented**. **Both are re-verified here, not
re-decided.**

### 8.2 Limb (a) — `PRD-008` `PLANNED` → `DRAFT`, under existing authority

**The `GCP-14` objection is answered, not ignored.** `PRD_REGISTRY.md` **L339–L351** records that this register
states **two incompatible tests** for `DRAFT`, and its v2.0 pass deliberately left `PRD-008` at `PLANNED`,
because advancing it *"would have resolved `GCP-14` by fiat in the direction that happens to be convenient."*

**That reasoning bound `ADR-0042`, and it does not bind this ADR — for a reason internal to the registry:**

1. **`GCP-14` already records its own reconciliation.** L343–L346: §7's *"conferred, not claimed"* reasoning *"is
   about **`FROZEN`** … and was over-generalised to `DRAFT`"*, and **`PRD-004` v1.4 is the decisive
   counter-example**, since the register itself moved a PRD to `DRAFT` on the strength of a file.
2. **The register names the deciding authority** (L351): *"governance owner of `PRD_REGISTRY.md` +
   `PRD_LIFECYCLE.md`."* **That authority is conferred for this act.** The v2.0 refusal was refusing to act
   *without* it — not asserting the move was wrong.
3. **The §2.1 L42 evidence test is met on the facts**: *"a document on disk with a version header"* —
   `PRD-008_REVENUE-AND-FINANCE.md` exists at **v1.6** with a version header.
4. **`PRD-022` is the executed precedent**, moved `PLANNED` → `DRAFT` on the same test at registry v1.9.

**Executed:** `PRD_REGISTRY.md` **L245** → `DRAFT` with its file path and version; §7 counts adjusted; §10 change
history row added.

> ⚠ **`GCP-14`'s wording defect is NOT closed by this act, and saying so is the whole point.** The register still
> contains two incompatible sentences about `DRAFT`. This ADR **applies the reconciliation the register itself
> already reached** and **the precedent it already executed twice** — it does not rewrite §7's prose. **`GCP-14`
> stays OPEN against the Governance Owner** as a wording defect. What closes is `FEE-GAP-012`(a) — *"who moves
> `PRD-008` to `DRAFT`?"* — because that question now has an answer: **the Governance Owner, and it is done.**

> ⚠ **And the direction of travel is disclosed.** This *is* the "convenient" direction — `PRD-008` benefits. The
> v2.0 refusal was right to distrust it. It is lawful now **only** because the authority was conferred
> explicitly, the evidence test is met on measured facts, and the precedent was executed twice before, on other
> documents, when it flattered nobody.

### 8.3 Limb (c) — report tier, resolved by an existing rule rather than a new decision

`ADR-0042` §6.2 called this **structurally unarbitrable**: **both** `Financial Reports` lines are **Rank 6** —
EA **L814** `(V2)` under `Owner Dashboard (V1)` (L807) and EA **L1423** `(V1)`, top-level LAYER 4 — and
`MP-CON-08` resolves conflicts by comparing **ranks**, so with both at 6 it has nothing to compare.

**The existing authority that resolves it is one rank up from the conflict, not inside it.** Two ranked rules,
already in force, make the disagreement *irrelevant to `BC-05`*:

- **`MP-CON-08` (Rank 1, MASTER_PRD L519)** — the EA is *"descriptive, not prescriptive"*; where it disagrees with
  a higher-ranked document *"the higher-ranked document wins and the Enterprise Architecture is updated to match
  — never the reverse."*
- **`DOCUMENTATION_BASELINE.md` §4 L221** — Rank 6 is *"Descriptive only. Update it to match 1–5; never the
  reverse."*

**Applied:** a Rank 6 tier label **cannot** create a `BC-05` deliverable. And **no Rank 1–5 document assigns
`BC-05` a report deliverable at all** — measured: BC Map **L135** gives `BC-26` *"the metric/semantic layer,
read-model store, projections, **reports**, exports"*, and BC Map **L100** gives `BC-05` fee structures, dues,
receipts, discounts, refunds and cash reconciliation — **no reports**.

**Therefore `PRD-008`'s own position was already correct**: it claims *"**no** report as a V1 deliverable of
`BC-05`"* and delivers **facts** (§22.1, L1160–1168 route all six collection/dues reports to `BC-26`).

**Executed:** §22.1's blockquote is corrected to state that the tier conflict is **Rank 6 internal and
`BC-26`/dashboard-owned, not a `BC-05` question** — and the **EA is not edited**, no report is claimed, no tier
is chosen for another owner.

> **Why this is not choosing between L814 and L1423.** It is **declining** to choose, on the ground that neither
> can bind `BC-05`. The Rank 6 disagreement remains a **defect of the EA**, routed to the Architecture Owner as
> **`Q-A7`** (§11) — and `DOCUMENTATION_BASELINE.md` §4 **L224** is followed exactly: *"A conflict is a defect.
> If you find one, do not choose — raise it."* **A defect in a descriptive document cannot block the freeze of a
> Rank 3 PRD that does not depend on it.**

### 8.4 Limb (b) re-verified — no edge, and the precedent is unchanged

`BC-26` is a `fee.*` consumer in BC Map §9 with **no `E-*` edge** in §7. Re-measured at HEAD: BC Map **L135**
classifies `BC-26` `[GENERIC]`/Analytics/**V1**; **L385** states its projections are *"fully rebuildable from the
event log; **no projection is a system of record**"*; **L405–L422** show BC-26 consuming from many contexts
without edges. **The condition is systemic, exactly as `ACCEPTED` `ADR-0019` §3.1 classified `MM-GAP-010`.**

**`BC-26` remains NOT listed as a publish target** (`PRD-008` **L1314**). **No `E-*` edge is invented, no BC Map
change is requested, and the BC Map is byte-unchanged.**

---

## 9. `Q-A6` — resolved by the Architecture Owner, with Rank 1 untouched

### 9.1 The drift

`ADR-0042` §11 disclosed a drift **its own work created**: raising the EA to **v2.2** made `MP-CON-08`'s literal
*"v2.1"* stale inside **Rank 1** `MASTER_PRD.md` (7 occurrences: L8, L10, L219, L223, L519, L568, L594, L600) —
the **seventh** instance of the `GCP-01`/`07`/`08`/`11`/`12`/`13` derived-statement class.

### 9.2 The decision

> *"Also resolve Q-A6 only through the proper authority: **do not silently modify Rank-1 MASTER_PRD.**"*

**The Architecture Owner's determination, recorded here and nowhere else:**

1. **`MASTER_PRD.md` is NOT edited by this ADR.** Verified: **0 bytes changed**, hash `5c31a3363d99a5f6`
   unchanged. Editing Rank 1 as a side effect of a Rank 6 bump is the **silent amendment**
   `DOCUMENTATION_BASELINE.md` §7 step 1 and `PRD_LIFECYCLE.md` **L177** prohibit.
2. **The drift has no substantive effect, and this is a measurement rather than a reassurance.** `MP-CON-08`'s
   **rule** is *"the EA is descriptive; rank 6; the higher-ranked document wins; a disagreement is a defect to be
   raised."* That rule is **version-independent** — it governs *whatever* version the EA carries. The stale
   *"v2.1"* is a **citation**, not an operative term, and `ADR-0042` §4 applied `MP-CON-08` **correctly** while
   the citation was stale, which is itself the proof.
3. **The authoritative EA version is `DOCUMENTATION_BASELINE.md` §3.2 (L139), not `MASTER_PRD.md`.** That is
   baseline §7 step 3's design: *"this declaration is updated in the same commit."* The declaration reads
   **v2.2**, correctly. **The baseline is the register of versions; the Master PRD is not.**
4. **Correcting the seven citations is a Rank 1 amendment requiring its own ADR, version increment and changelog,
   in that order** — and it is **not bundled into a `PRD-008` blocker pass**. It stays **`Q-A6`, OPEN, against
   the Architecture Owner**.
5. **`Q-A6` does not block `PRD-008`'s Freeze.** It is a defect **in Rank 1's citations**, not in `BC-05`'s
   specification, and it was **created by `ADR-0042`, not by `PRD-008`**. A PRD cannot be held hostage to a
   citation defect in another document that its own freeze does not touch — and the class already has **six
   prior instances**, none of which blocked a freeze (`GCP-09` explicitly did not block `PRD-007`'s).

> **What "resolved through the proper authority" means here, precisely.** `Q-A6` is **not closed** — the seven
> citations remain stale. What is decided, by the only party who may decide it, is **(i)** that Rank 1 will not
> be edited silently, **(ii)** that the drift is a citation defect with no operative effect, and **(iii)** that
> it is therefore **not** a `PRD-008` Freeze blocker. **Deciding the disposition of a question is resolving it
> through authority; editing the file quietly would have been resolving it by fiat.**

---

## 10. `PRD-008` is NOT frozen by this ADR

**Freeze blockers 6 → 0. `PRD-008` is not frozen.** These are not in tension, and the reason is the repository's
own rule.

`PRD_LIFECYCLE.md` **Stage 7 (L155+)**: *"Freeze is **conferred, not claimed**. No PRD in this repository
declares itself frozen."* The **gate is a row in `DOCUMENTATION_BASELINE.md` §3** at an assigned precedence rank
— echoed by `PRD_REGISTRY.md` §2 **L45**: `FROZEN` requires *"A row in `DOCUMENTATION_BASELINE.md` §3."*

**No such row is written, and none is requested.** Further, freeze is **not** the next lifecycle stage:

| Stage | State |
|---|---|
| Stage 4 — Requirements Review | ✅ Passed at v1.5; re-verified at exit 0 |
| **Stage 5 — Traceability** | ⛔ **NOT PERFORMED** — `PRD_LIFECYCLE.md` **L121** requires a `TRACEABILITY_MATRIX.md` §2 record; `PRD-008` has **no** Stage 5 document (measured: `docs/30-product/revenue-finance/` holds 2 files) |
| **Stage 6 — Implementation Tasks** | ⛔ **NOT PERFORMED** — **L135** requires an allocated task range; `PRD-008` has **no** implementation-task document (measured: `docs/40-implementation/revenue-finance/` **does not exist**) |
| **Stage 7 — Freeze** | ⛔ **NOT REACHED.** Stages 5 and 6 come first |

⚠ **Removing the Freeze *blockers* is not passing the Freeze *gate*.** The blockers were **substantive holes**;
the gate is a **procedural conferral** preceded by two unperformed stages. **Freezing now, on the strength of a
zero blocker count, would be the precise "claimed, not conferred" defect Stage 7 exists to prevent** — and the
principal's own instruction, *"do not freeze automatically"*, is followed to the letter.

⚠ **`PRD-008` also carries a known document-owner defect that a freeze must not bake in:** the **`FEE-RSK-*`
register (10 members) is UNDECLARED in §0.2**, reported at every gate run as an OUTSTANDING FINDING and
**deliberately not self-fixed**. See §11.

---

## 11. Open items — routed, not closed

| ID | Item | Owner | State |
|---|---|---|---|
| **`Q-B31`** | Author the payment-webhook wire contract (endpoint, schema, signature, replay window, retry policy) in `PRD-019` | **`BC-31` owner** | ⛔ **OPEN.** Blocks the **feature**, and `PRD-019`'s own Stage 4 — **not** `PRD-008` (§3.4) |
| **`Q-A6`** | Correct `MP-CON-08`'s stale *"v2.1"* (7 occurrences) via a Rank 1 amendment: ADR → version → changelog → baseline | **Architecture Owner** | ⛔ **OPEN.** Disposition decided (§9); **not** a `PRD-008` blocker |
| **`Q-A7`** | The EA tiers `Financial Reports` twice and disagrees with itself — **L814 `(V2)`** vs **L1423 `(V1)`**, both Rank 6. Raise as an EA defect | **Architecture Owner** | ⛔ **OPEN — newly registered here.** Not a `BC-05` question (§8.3) |
| **`Q-S1`** | Obtain the **compliance approval** for `BC-05` financial retention; until then `FEE-XC-011` forbids all purging | **Product Owner + Security/Compliance** | ⛔ **OPEN as an operational item.** `PRD-008`'s **specification** obligation is closed (§7.3) |
| **`GCP-14`** | `PRD_REGISTRY.md` states two incompatible tests for `DRAFT`; §7's prose still over-generalises the `FROZEN` rule | **Governance Owner** | ⛔ **OPEN as a wording defect.** Its *application* to `PRD-008` is executed (§8.2) |
| **`Q-A5`** | Is gateway-executed refund (EA **L1408** `Refund Management (V2)`) a V1 deliverable? | **Architecture Owner** | ⛔ **OPEN** — inherited from `ADR-0042` §4.4, untouched |
| **`Q-P1`** | *(from `ADR-0042` §8)* What may staff do with an out-of-band bank credit **beyond** V1? | **Product Owner** | ⚠ **NARROWED to a V2 option.** V1 behaviour is determined (§4.3): it **cannot** be auto-confirmed |
| — | **`FEE-RSK-*` (10) undeclared in `PRD-008` §0.2** | **`PRD-008` document owner** | ⛔ **OPEN.** Reported at every gate run; **not** self-fixed |
| — | **Citation defects in `PRD-008`**: L799/L2112 *"EA L1408/L1409"*; §29.3 *"EA L1413"*; L2382 `100%%`; §41 missing v1.1–v1.5 rows; three duplicate AC citations in §36.1 | **`PRD-008` document owner** | ⛔ **OPEN.** Disclosed, **never fabricated or silently repaired** |
| — | Two unexecuted `ADR-0033` amendments in frozen `PRD-006` L2170 / `PRD-007` L867 | Respective owners | ⛔ **OPEN** — standing deferrals, untouched |

---

## 12. Verification — measured, not asserted

| # | Assertion | Result |
|---|---|---|
| 1 | `PRD-008` Freeze blockers **before** | **6** — `FEE-GAP-002`, `003`, `007`, `009`, `011`, `012` |
| 2 | `PRD-008` Freeze blockers **after** | **0** |
| 3 | Count re-derived **mechanically** by `tool/docs_check/prd008_traceability.py` from each block's own leading verdict | ✅ Not by subtraction |
| 4 | `prd008_traceability.py` exit code | **0 — PASS** |
| 5 | The checker was **not weakened** | ✅ Hash `9ceaf1825764dbbe` unchanged |
| 6 | New `FEE-*` identifiers minted | **0** — §0.2 stays **249 / 134 / 23** |
| 7 | `MASTER_PRD.md` (Rank 1) | **Byte-unchanged** — `5c31a3363d99a5f6` |
| 8 | BC Map (Rank 4) | **Byte-unchanged** — `81518f1bb251218b` |
| 9 | Dependency Matrix (Rank 4) | **Byte-unchanged** — `9895d244494372af` |
| 10 | `tool/module_dependencies.yaml` | **Byte-unchanged** — `22e40ac3fe080387` |
| 11 | Enterprise Architecture (Rank 6) | **Byte-unchanged** at v2.2 — **no report tier edited** |
| 12 | Frozen PRDs modified | **0** |
| 13 | `ACCEPTED` ADRs altered | **0** |
| 14 | New bounded context / `E-*` edge / port / permission ID / config ID / role / scope | **0 of each.** Context count **31** |
| 15 | Payment-provider mentions in `PRD-008` | **5 — unchanged** |
| 16 | Wire **values** (a URL, a payload field, a named signature algorithm, a replay-window duration, a retry count/backoff) specified in `PRD-008` | **0 — and the claim is worded to be measurable.** ⚠ A naive count of the five element *names* **rises** at v1.7 (e.g. `signature algorithm` 13 → 18), and that is disclosed rather than hidden: every new occurrence is either a **negation** (*"no endpoint, schema, signature algorithm … was invented"*) or the **ownership assignment** naming `ADR-0040` §4 L165’s five elements as `BC-31`’s. **Naming the thing you are refusing to specify is not specifying it** — but the earlier wording of this row would have read as false to anyone who counted, so it was corrected |
| 17 | Retention period, purge rule, discount ceiling or range invented | **0 of each** |
| 18 | `FEE-XC-011`, `FEE-FR-039`, `FEE-FR-061`, `FEE-XC-022`, `FEE-INV-002` reworded | **0 — all byte-unchanged** |
| 19 | `PRD-008` frozen | ⛔ **NO.** No `DOCUMENTATION_BASELINE.md` §3 row written or requested |
| 20 | Dart source touched | **0 files** vs `0fa4a8f` over `lib test pubspec.yaml android web` |
| 21 | Gate files under `tool/` modified | **0** |
| 22 | Baseline identifier changed | **NO** — §7 step 4 triggers on a **Rank 1–3 version change**; `PRD-008` is Rank 3-**registered**, not Rank 3-**holding** |

---

## 13. Objections to this ADR, stated against itself

1. **"Creating an empty `PRD-019` is a shell that closes a blocker on a technicality."** — Partly fair, and §3.4
   concedes the feature stays unbuildable. But the blocker's own stated cause was **ownerlessness**, not
   emptiness; and the alternative — authoring the contract — is forbidden by three ranked sources. **A document
   that says "I own this and have not written it" is strictly more useful than no document**, because it makes
   the hole attributable to a named owner.
2. **"Six blockers falling to zero in one pass is exactly the pattern that should be distrusted."** — Correct,
   and it is why every count in §12 is machine-derived and why this ADR **refuses the freeze** in §10. Note also
   that **four of the six were already narrowed to a single residual by `ADR-0042`**; this pass answered six
   narrow questions, not six broad ones.
3. **"Limb (a) is self-serving — `PRD-008` benefiting from a registry edit made during a `PRD-008` pass."** —
   The sharpest objection. §8.2 answers it with the register's **own** reconciliation, its **own** named
   authority, its **own** evidence test, and **two prior executions on other documents** — and discloses the
   direction of convenience explicitly rather than hoping it goes unnoticed.
4. **"`FEE-GAP-003` and `FEE-GAP-011` close without adding anything, so nothing was really specified."** —
   Deliberate. Both were **already specified** (`FEE-FR-061`/`FEE-XC-022`; `FEE-XC-011`) and merely **un-cited
   from their gap blocks**. **Adding rules to look thorough is the failure mode this document has recorded
   against itself before** (`PRD-008` L1547).
5. **"`Q-A6` is declared a non-blocker by the same authority that created the drift."** — True, and disclosed.
   The mitigation is that the reasoning is **measurable, not discretionary**: `MP-CON-08`'s rule is
   version-independent, the baseline §3.2 is the authoritative version register, and six prior instances of this
   class blocked no freeze. **`Q-A6` stays OPEN.**
6. **"§29.3's repair is a specification change dressed as a correction."** — The mapping in §6.3 uses **only**
   `FeeDue` states that already exist in §29.1, adds and deletes **no** state value, and leaves §0.2 unchanged.
   **If it were a substantive change, an identifier or a state would have moved. None did.**

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **Created `ACCEPTED`. Executes six conferred decisions; `PRD-008` Freeze blockers 6 → 0; `PRD-008` NOT frozen.** ✅ **`FEE-GAP-002`** — **`PRD-019_INTEGRATION.md` created at v0.1 `DRAFT`**, assigning the five wire elements of `ACCEPTED` `ADR-0040` **§4 L165** to **`BC-31`** and **authoring none of them**; the assignment **recognises** BC Map **L140**, `PRD_REGISTRY.md` **L309**, `SAAS-XC-006` and Matrix `X-03`, so **no context, edge, port, module, role, permission or config ID is created** and the count stays **31**; `PRD-008` gains **zero** wire vocabulary and its provider mentions stay at **5**; `Q-B31` (already opened by `ADR-0042` §8, **not minted here**) is recorded ⛔ OPEN against the `BC-31` owner, and §3.4 concedes the **feature remains unbuildable**. ✅ **`FEE-GAP-003`** — bank transfer **NOT V1**, and out-of-band money **cannot auto-confirm**: closed by **pointing at obligations that already say so** (`FEE-FR-061` L1336, `FEE-XC-022` L1339, `FEE-BR-014`, `FEE-BR-011`, tested by `FEE-AC-081`/`082`, ratified by `ACCEPTED` `ADR-0037`) — **no rule, exclusion or identifier written**. ✅ **`FEE-GAP-007`** — **`owner` is the sole discount approver by default; `manager` has none**; grants ride the **existing** mechanism (`MP-GBR-20` scope-bearing grants, `MP-GBR-21`'s **closed** scope register using the existing `tenantWide`, `MP-GBR-23` per-library grants) — **no permission ID, no role (`FEE-XC-014` L1212 honoured), no fourth scope, no ceiling, and ABAC untouched at V3**; §23.1 **L1198**'s live marker is resolved and `FEE-FR-039` is **not reworded**. ✅ **`FEE-GAP-009`** — §29.3 (**L1409–L1419**) restated as an explicit **projection** of §29.1, every Invoice label mapped onto a `FeeDue` state that **already exists** (`ISSUED`→`DUE`/`OVERDUE`, `PAID`→`PAID`, `CANCELLED`→`CANCELLED`), the `Forbidden` row re-attributed to §29.1 so it constrains **one** machine — **no state value added or deleted, §0.2 unchanged**, and §29.3's stale *"EA L1413"* citation **disclosed rather than deleted**. ✅ **`FEE-GAP-011`** — **no period, purge rule, minimum or maximum invented**; `FEE-XC-011` **byte-unchanged**; the V1 **position** is that retention follows the **approved legal/compliance policy** and any change requires **Product + Security/Compliance approval** — a complete specification, with the compliance approval itself left ⛔ OPEN as **`Q-S1`**. ✅ **`FEE-GAP-012`** — **(a)** `PRD-008` `PLANNED` → `DRAFT` under the **register's own** named authority (L351), its **own** reconciliation of `GCP-14` (L343–L346), its **own** §2.1 L42 evidence test and the **twice-executed** `PRD-004`/`PRD-022` precedent, with the convenient direction **disclosed** and **`GCP-14` left OPEN** as a wording defect; **(b)** re-verified closed on the `ACCEPTED` `ADR-0019` §3.1 `MM-GAP-010` precedent — **`BC-26` still not a publish target, no `E-*` edge invented, BC Map byte-unchanged**; **(c)** resolved **one rank above the conflict** — both `Financial Reports` lines are **Rank 6**, `MP-CON-08` and baseline §4 **L221** make Rank 6 descriptive, and **no Rank 1–5 document gives `BC-05` a report deliverable** (BC Map **L135** gives reports to `BC-26`, **L100** gives `BC-05` no reports) — so the tier **cannot bind `BC-05`**; the EA is **not edited** and the self-disagreement is raised as new **`Q-A7`** per baseline §4 **L224**. ✅ **`Q-A6`** — resolved **through authority, not by editing**: `MASTER_PRD.md` is **byte-unchanged** (`5c31a3363d99a5f6`), the stale *"v2.1"* is measured a **citation** rather than an operative term (`MP-CON-08`'s rule is version-independent, and `ADR-0042` §4 applied it correctly while the citation was stale), the **baseline §3.2 L139** is the authoritative version register per §7 step 3, and correcting the seven Rank 1 citations is left as its **own** ADR → version → changelog sequence — **`Q-A6` stays OPEN** and is **not** a `PRD-008` blocker. ⛔ **`PRD-008` IS NOT FROZEN, and §10 gives three independent reasons:** freeze is *"conferred, not claimed"* with the gate being a **`DOCUMENTATION_BASELINE.md` §3 row** (none written, none requested); **Stage 5 Traceability and Stage 6 Implementation Tasks have never been performed** (measured: no Stage 5 document, and `docs/40-implementation/revenue-finance/` does not exist); and the **undeclared `FEE-RSK-*` register** remains an open document-owner defect. **§11 routes ten open items** — `Q-B31`, `Q-A6`, `Q-A7`, `Q-S1`, `GCP-14`, `Q-A5`, `Q-P1`, the `FEE-RSK-*` declaration and five citation defects — each to a named owner. **§13 states six objections against this ADR's own reasoning**, including that a six-to-zero fall is exactly the pattern to distrust. **§12 records twenty-two verifications**: no Rank 1–4 document amended, no `ACCEPTED` ADR altered, no frozen PRD touched, no checker weakened, **no new `FEE-*` identifier** (§0.2 stays **249 / 134 / 23**), no BC / edge / port / permission / config ID / role / scope created, no baseline identifier issued, and **0 Dart files touched**. |
