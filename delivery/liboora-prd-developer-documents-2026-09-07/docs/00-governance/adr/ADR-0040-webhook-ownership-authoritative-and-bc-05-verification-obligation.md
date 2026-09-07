# `ADR-0040` — Inbound payment webhook ownership: `ADR-0035` §5.5b **UPHELD**; and `BC-05`'s verification obligation is the testable part

| Field | Value |
|---|---|
| **ADR** | `ADR-0040` |
| **Title** | The `FEE-GAP-002` webhook-ownership conflict is **resolved by upholding `ADR-0035` §5.5b** (`platform/business`); and the measured finding that **no document may currently author the webhook contract**, which is why `FEE-FR-028`'s criterion must test `BC-05`'s own verification obligation instead |
| **Status** | **`ACCEPTED`** — recording a decision **conferred directly by the human principal acting as Architecture Owner**, who routed this conflict here for authoritative determination. `PRD_OWNERSHIP_MODEL.md` **L85** assigns *"Boundaries, ranks, permitted edges, precedence"* and *"ADR approval"* to the Architecture Owner; **L68** assigns *"a decision that changes structure, ownership, a boundary"* to the same role. This is that role's act, and it is accepted because **the authority that must decide it is the authority that gave it**. |
| **Date** | 2026-08-15 |
| **Decision by** | **Architecture Owner** — direct conferral. The principal's instruction was explicit: *"Route the conflict to the Architecture Owner and record the authoritative decision."* |
| **Amends** | **Nothing.** `ADR-0035` §5.5b is **UPHELD UNCHANGED** — this ADR adds no clause to it, removes none, and modifies **no byte** of that file. No frozen document, no Rank 1-5 document, no checker, no manifest is touched. |
| **Supersedes** | Nothing. It **closes** `ADR-0039` §2's reported conflict by determining it, and **confirms** `ADR-0039` §2's refusal to determine it as having been correct at the time. |

---

## §1 The decision, stated first and without hedging

> ### `ADR-0035` §5.5b **STANDS**. The inbound payment webhook is owned by **`platform/business`**.
>
> The alternative reading — `platform/integration` — is **NOT adopted**, **NOT recorded as a decision**,
> and **NOT applied to any document**.

**Nothing is created to achieve this.** No `BC-32`. No `E-*` edge. No `provides_ports:` entry. No module
re-declaration. `tool/module_dependencies.yaml` is **byte-unchanged**.

### 1.1 Why upheld rather than replaced — the reasoning is `ADR-0035`'s own, and it survives scrutiny

`ADR-0035` §5.5b, whose Status row reads **`ACCEPTED` … In force. Binding on all implementation**, gave a
reason that is architectural rather than administrative:

> *"**It places ingress with execution.** `D-2` already put student→library **payment execution** in the
> Business Platform. An inbound confirmation is the *return leg of the very call the same capability makes
> outbound*. Splitting the outbound request from the inbound confirmation across two owners would have been
> the architecturally worse answer, and no ranked document asked for it."*

That reason was **re-tested against the manifest, not taken on trust**. `tool/module_dependencies.yaml`
**L406** declares `platform/business` at **rank 6**; **L409** declares
`ports: [platform/integration:payment_gateway]`. The two modules therefore stand in a **caller → callee**
relation. Substituting the callee for the caller as the *owner of ingress* would place the **return leg** of a
call in a module that **does not initiate it** — which is precisely the split §5.5b rejected. **The reason
holds under re-measurement, so the decision is upheld on its merits and not merely on its rank.**

### 1.2 The evidence that cuts *against* upholding is recorded, not suppressed

`ADR-0035` **L442** — written **before** the conferral — itself proposed *"a capability declaration naming an
inbound-adapter owner within **`platform/integration`**"*. **The alternative reading is therefore not
arbitrary: it matches what `ADR-0035` originally proposed.** This ADR records that plainly because a
determination that hides the strongest argument against itself is not a determination.

**It is nonetheless not adopted, for a reason of governance form rather than preference:** §5.5b
**superseded** L442 by conferral. **A superseded proposal is not authority.** Were L442 resurrected to settle
the question, the repository would contain two live answers to one ownership question with no rule for
choosing between them — which is the *"two sources of truth"* defect `PRD_LIFECYCLE.md` Stage 4 check 5
exists to catch.

### 1.3 What was already agreed, and is confirmed rather than newly decided

`ADR-0039` §2.3 measured four clauses as **already settled**. They are **re-confirmed here unchanged**:

| Clause | Status | Source |
|---|---|---|
| **No `BC-32`** is created | ✅ Confirmed, not new | `ADR-0035` §5.5b: *"Count remains **31 (23 in V1)**"* |
| Webhook is **transport / evidence only** | ✅ Confirmed, not new | `FEE-BR-014`; §5.5b `AR-1`: *"an inbound message is **evidence, never instruction**"* |
| **`BC-05`** remains the financial source of truth | ✅ Confirmed, not new | §5.5b: *"`BC-05` keeps payment intent, the **verification obligation** and student financial truth"* |
| **Verification precedes recording** | ✅ Confirmed, not new | `FEE-BR-016`; `FEE-INV-005` |
| Routing owner | ✅ **NOW DETERMINED — `platform/business`** | This ADR §1, upholding `ADR-0035` §5.5b |

---

## §2 The measured finding that changes what `FEE-FR-028` can lawfully say

**This is the substantive contribution of this ADR, and it was discovered by measurement during this pass.**

`ADR-0039` §2.4 correctly observed that *"an owner is not a contract"*. What it did **not** establish — and
what is established here — is that **no document in this repository is currently *permitted* to author that
contract**. Four candidates were checked, and all four are barred:

| Candidate author of the webhook contract | Measured status | Verdict |
|---|---|---|
| **`platform/business` / `BC-20`** — §5.5b's own named owner | Its PRD, **`PRD-022` v0.3 `DRAFT`**, carries **`SAAS-XC-006`** (L157-158): *"Naming a payment provider, endpoint, **webhook schema**, signature algorithm, retry policy, bank-account structure or UPI flow. **`BC-31` owns vendor knowledge**; BC Map **L334** requires that *'Billing knows no vendor names.'*"* | ⛔ **EXCLUDES ITSELF** |
| **`BC-31` Integration** — named by `SAAS-XC-006` as the owner of vendor knowledge | **`PRD-019` is `PLANNED`** — the document **does not exist** (`PRD_REGISTRY.md` **L309**) | ⛔ **NO DOCUMENT** |
| **`BC-05` / `PRD-008`** | Its own **L863**: *"**No webhook schema, no provider contract and no endpoint is written in this document**"* | ⛔ **FORBIDS ITSELF** |
| **`ADR-0035` §5.5b** itself | *"Do not create a new BC or **invent an endpoint/schema**"* | ⛔ **FORBIDS INVENTION** |

### 2.1 The consequence, stated without softening

**A webhook wire contract cannot be written by anyone today, and this ADR does not write one.** Settling the
*owner* — which §1 does — **does not** produce an endpoint, payload schema, field list, signature algorithm,
header, replay window, retry policy or provider, and **inventing any of them here would be the exact act the
principal forbade**.

### 2.2 But this does **not** leave `FEE-FR-028` untestable — and that is the finding that unblocks

**The question `FEE-FR-028` must answer is not "what does the payload look like?" It is "what must `BC-05` do
with an inbound message?"** — and **`BC-05`'s obligation is the one thing §5.5b explicitly left with
`BC-05`**:

> *"| Does `BC-05` lose anything? | — | ✅ **No.** `BC-05` keeps payment intent, the **verification
> obligation** and student financial truth (`FEE-BR-016`, `FEE-INV-005`, `MP-GBR-24`) |"*

An obligation `BC-05` **indisputably owns** can be given a criterion **without naming a single vendor
artefact**. Concretely, the following are all testable with **no** schema:

- that an inbound message **alone** does not move a payment to `CONFIRMED`;
- that an **unverified** inbound message settles no obligation and issues no receipt;
- that a **replayed** inbound message produces no second confirmed payment (`FEE-INV-005`);
- that an inbound message for an **unknown** payment creates nothing and is surfaced for reconciliation.

**Each of these is a property of `BC-05`'s own behaviour.** None requires an endpoint, a field name, a
signature algorithm, a retry policy or a provider.

### 2.3 The precedent for this shape already exists in `PRD-008`, which is why it is not an invention

`PRD-008` §35.6 already tests the **identical** rule — *evidence, never instruction* — for the
**client-side-hint** case, at **L1555-1557**:

| Existing criterion | Text |
|---|---|
| `FEE-AC-032` | *A client-side success signal alone does not move a payment out of `PENDING`* |
| `FEE-AC-033` | *A `PENDING` payment settles no obligation and generates no receipt* |
| `FEE-AC-034` | *A `PENDING` payment emits no `fee.FeePaymentReceived`* |

**These three name no endpoint, no schema, no signature and no provider — and they are already accepted
criteria in this document.** Applying the same shape to the **server-side inbound** case is therefore
**extending an established pattern to its sibling case**, not creating a new one. `FEE-BR-014` — *"Client-side
success is a **hint**, never a financial fact"* — and the `AR-1` finding *"an inbound message is **evidence,
never instruction**"* are **the same rule applied to two different transports**.

### 2.4 What `FEE-FR-028` therefore may and may not assert — the boundary drawn explicitly

| May assert | May NOT assert |
|---|---|
| That `BC-05` **verifies server-side** before recording | The **endpoint / URL / route** |
| That an unverified inbound message **changes nothing** | The **payload schema** or any field name |
| That replay yields **one** confirmed payment | The **signature algorithm** or header name |
| That an unmatched message is **surfaced, not applied** | The **replay window** or **retry policy** |
| That ingress is **`platform/business`**'s (§1) | The **provider / vendor** name |

**This authorises `PRD-008` to make `FEE-FR-028` testable. It authorises no wire contract.**

---

## §3 What this ADR does NOT do

| Not done | Why |
|---|---|
| **No `BC-32`** | §5.5b: count *"remains **31 (23 in V1)**"*. Also expressly forbidden by the instruction |
| **No new dependency edge** | Expressly forbidden by the instruction. `BC-05`'s route is the already-declared **port** `business.payment_intent`; `ADR-0033` settled that not every dependency needs an edge |
| **No endpoint, schema, signature, header, replay window, retry policy or provider** | §2 proves **no document may author them**; inventing them is forbidden |
| **No change to `BC-31`'s scope** | §5.5b: `BC-31` *"remains **outbound**. Its scope is **unchanged and unwidened**"* |
| **No modification of `ADR-0035`** | It is `ACCEPTED` and is **upheld**; upholding requires changing nothing |
| **No `provides_ports:` entry, no manifest edit** | `tool/module_dependencies.yaml` is **byte-unchanged** |
| **No closing of `PRD-022`'s `SAAS-GAP-001`** | It belongs to the `BC-20` owner; closing it here is the ownership violation `FEE-XC-023` prevents |
| **No reopening of `ADR-0037` / `FEE-GAP-002`(c)** | `ACCEPTED` and `RESOLVED`; the principal's instruction is explicit |
| **No `FEE-CFG-*` register** | No range is approved; `FEE-GAP-007` stands |

---

## §4 Honest statement of what remains open after this ADR

**Upholding an ownership decision and authorising a behavioural criterion does NOT deliver a webhook
contract.** The following remain genuinely open and are **not** closed by this ADR:

| Still open | Owner | Why this ADR cannot close it |
|---|---|---|
| The webhook **wire contract** (endpoint, schema, signature, replay window, retry policy) | **`BC-31` owner**, once **`PRD-019`** exists | §2 — every candidate author is barred today; `PRD-019` is `PLANNED` |
| **`PRD-019`** does not exist | `PRD_REGISTRY.md` owner | Writing another PRD's content here would create a second source of truth |
| **`PRD-022` `SAAS-GAP-001`** and its other gaps | `BC-20` owner | Not this document's to close |
| **`FEE-GAP-002`(b)** offline capture | ✅ Already **DISSOLVED** by `ACCEPTED` `ADR-0037` — **not reopened** | — |

**`FEE-GAP-002` may therefore be recorded as having its *ownership conflict* CLOSED, while its *contract*
limb remains open with a named owner and a named reason** — which is exactly the disposition
`PRD_LIFECYCLE.md`'s Stage-4 gate permits: *"conflicts closed or explicitly deferred **with a reason and an
owner**."*

---

## §5 Objections, stated before they are raised

**"You upheld the `ACCEPTED` ADR because it was easier than reconciling it."**
The reasoning was **re-tested against the manifest** (§1.1), and the **contrary evidence at L442 is recorded
in full** (§1.2). An upholding that examines the case against itself is not deference.

**"Authorising a criterion for `FEE-FR-028` is inventing a contract by the back door."**
It is not, and §2.4 draws the line explicitly. The authorised criteria assert **`BC-05`'s own behaviour**,
which §5.5b **expressly left with `BC-05`**. **Not one names an endpoint, schema, signature, provider or retry
policy.** The pattern is `FEE-AC-032`/`033`/`034`, already in the document.

**"`FEE-GAP-002` should now be marked RESOLVED."**
**No.** Its **ownership** limb is closed; its **contract** limb is not, and §4 says so. Marking the whole gap
resolved would be *"claiming a gap is resolved merely because an ADR exists"* — the precise defect forbidden.

**"This ADR is self-accepted, which earlier ADRs refused."**
The distinction is **which authority is required**. `ADR-0038`/`ADR-0039` contained questions their author had
**no authority to answer**, so they were left `PROPOSED`. Here the principal **conferred Architecture Owner
authority and directed that the decision be recorded**. Leaving it `PROPOSED` would leave the conflict
unresolved after being told to resolve it.

---

## §6 Verification performed

| Check | Result |
|---|---|
| `ADR-0035` byte-unchanged | ✅ sha256 verified before and after |
| `ADR-0035` still `ACCEPTED` | ✅ leading declared token read, not substring-matched |
| `tool/module_dependencies.yaml` unchanged | ✅ `22e40ac3fe080387` |
| BC Map unchanged; `BC-32` occurrences | ✅ `81518f1bb251218b`; **0** |
| No new `E-*` edge | ✅ 26 edge rows, `E-01`…`E-27` unchanged |
| `PRD-022` unmodified | ✅ read-only; `SAAS-GAP-001` still open |
| `ADR-0037` unmodified / not reopened | ✅ |
| No endpoint / schema / signature / provider written here | ✅ measured |
| Zero Dart source touched | ✅ |

---

## §7 Change history

| Date | Change |
|---|---|
| 2026-08-15 | Created **`ACCEPTED`** under conferred **Architecture Owner** authority. **Upholds `ADR-0035` §5.5b unchanged** (`platform/business` owns inbound webhook ingress); **refuses** the `platform/integration` substitution and records why, including the contrary L442 evidence. **Establishes by measurement that no document may currently author the webhook wire contract** (`SAAS-XC-006` excludes `BC-20`; `PRD-019` is `PLANNED`; `PRD-008` L863 and §5.5b forbid invention) and therefore **authorises `PRD-008` to make `FEE-FR-028` testable against `BC-05`'s OWN verification obligation** in the shape of existing `FEE-AC-032`/`033`/`034`, naming no endpoint, schema, signature, provider or retry policy. **No `BC-32`, no edge, no manifest change, no frozen document modified, no `ACCEPTED` ADR altered, no checker weakened, no code touched.** |
