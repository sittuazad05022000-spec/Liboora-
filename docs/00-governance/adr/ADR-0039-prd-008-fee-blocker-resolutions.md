# `ADR-0039` — `PRD-008` fee-blocker resolutions: four decided, one CONFLICT reported

| Field | Value |
|---|---|
| **ADR** | `ADR-0039` |
| **Title** | `PRD-008` Stage-4 fee-blocker resolutions — refund scope, fee types, correction model, due-date offset; and one reported conflict on webhook routing |
| **Status** | **`PROPOSED`** — recording decisions **given by the human principal** acting as **Product Owner**, and **reporting one conflict rather than resolving it**. This ADR is **not self-accepted**: the four decisions it records are the principal's, not mine, and the fifth item is **escalated unchanged**. Where the instruction and an **`ACCEPTED`** ADR disagree, this ADR **reports the disagreement** — it does not pick a winner, because overriding an `ACCEPTED` Rank-governance decision is an **Architecture Owner** act. |
| **Date** | 2026-08-15 |
| **Decision by** | **Product Owner** — direct conferral by the human principal (`PRD_OWNERSHIP_MODEL.md` §2.2). Four decisions given. **One item (`FEE-GAP-002` webhook routing) is NOT decided here** — see §2. |
| **Amends** | **Nothing.** No frozen document, no Rank 1–4 document, no `ACCEPTED` ADR, no checker, no manifest. |
| **Supersedes** | Nothing. `ADR-0038`'s routing of these questions is **answered**, not withdrawn — its §3 tables stated the exact questions these decisions answer. |

---

## §1 What this ADR does, and the one thing it refuses to do

`ADR-0038` (`PROPOSED`) measured five `PRD-008` Stage-4 blockers and found that **four required a product
decision that no repository document contained**. Those decisions have now been **given**. This ADR records
them against their authoritative sources.

**It also reports a conflict, as instructed.** The instruction for `FEE-GAP-002` routes the webhook through
*"existing **`platform/integration`** capability"*. **`ADR-0035` §5.5b — which is `ACCEPTED`, i.e. "In force.
Binding on all implementation" — decided that owner is the Business Platform (`platform/business`).** These
are two different capabilities at two different module paths. The instruction's own terms were:

> *"If any proposed solution conflicts with a frozen rule or requires a new architectural edge, **STOP and
> report the conflict instead of inventing a workaround**."*

So §2 reports it and **decides nothing on that point**. Everything else in the `FEE-GAP-002` instruction
— no `BC-32`, webhook is transport/evidence only, `BC-05` remains financial source of truth — **agrees with
`ADR-0035` exactly** and is recorded as **confirmed**, not as new.

---

## §2 ⛔ `FEE-GAP-002` — CONFLICT REPORTED, NOT RESOLVED

### 2.1 The two statements, side by side

| Source | Rank / status | Names the inbound webhook owner as |
|---|---|---|
| **Instruction (this pass)** | Product Owner, given now | *"existing **`platform/integration`** capability"* |
| **`ADR-0035` §5.5b** | **`ACCEPTED`** — in force, binding | *"Inbound payment webhook = existing **Business Platform** capability"* — `platform/business`, **rank 6** |

`ADR-0035` §5.5b's reasoning is recorded verbatim in that document and is **not weakened here**:

> *"**It places ingress with execution.** `D-2` already put student→library **payment execution** in the
> Business Platform. An inbound confirmation is the *return leg of the very call the same capability makes
> outbound*. Splitting the outbound request from the inbound confirmation across two owners would have been
> the architecturally worse answer, and no ranked document asked for it."*

### 2.2 Why this is a real conflict and not a wording difference

`platform/business` and `platform/integration` are **distinct declared modules** in
`tool/module_dependencies.yaml`. `platform/business` sits at **rank 6** (L406) and already declares
`ports: [platform/integration:payment_gateway]` (L409) — so the two are in a **caller→callee** relationship,
not synonyms. Assigning ingress to `platform/integration` instead of `platform/business` would:

| Consequence | Measurement |
|---|---|
| Split the outbound call from its own return leg across two modules | `ADR-0035` §5.5b calls this *"the architecturally worse answer"* |
| Require `platform/integration` to declare a `provides_ports:` entry it does not have | `ADR-0035` L180: `platform/business` declares **no** `provides_ports:`; the inbound side is undeclared for **both** |
| Possibly require a **new declared route** back to `BC-05` | This is exactly the *"new architectural edge"* the instruction says to **stop** on |

**Interesting nuance, recorded because it cuts against my own report:** `ADR-0035` **L442** — written
*before* the conferral — itself proposed *"a capability declaration naming an inbound-adapter owner within
**`platform/integration`**"*. So the instruction matches what `ADR-0035` **originally proposed**. But that
sentence was **superseded** by §5.5b's conferral, which chose `platform/business` instead. **A superseded
proposal is not authority**, and I will not resurrect it to make the instruction fit.

### 2.3 What IS confirmed (agreement, not new decision)

| Instruction clause | Status | Source |
|---|---|---|
| Do **NOT** create `BC-32` | ✅ **Already decided, unchanged** | `ADR-0035` §5.5b: *"Count remains **31 (23 in V1)**"*; `AR-1` test |
| Webhook is **transport/evidence only** | ✅ **Already decided, unchanged** | `FEE-BR-014` — *"an inbound message is **evidence, never instruction**"* (§5.5b `AR-1` table) |
| `BC-05` remains **financial source of truth** | ✅ **Already decided, unchanged** | §5.5b: *"`BC-05` keeps payment intent, the **verification obligation** and student financial truth"* — `FEE-BR-016`, `FEE-INV-005`, `MP-GBR-24` |
| Verification step before `BC-05` records | ✅ **Already decided, unchanged** | `FEE-BR-016` server-side confirmation; `FEE-INV-005` idempotency |
| Routing owner = `platform/integration` | ⛔ **CONFLICT — not recorded, not applied** | Contradicts `ACCEPTED` `ADR-0035` §5.5b |

### 2.4 Consequence for Stage 4 — stated plainly

**`FEE-GAP-002` still blocks Stage 4, and `FEE-FR-028` still carries `⛔ none`.** The reason is
**unchanged from `ADR-0038`**: naming an owner does not produce a contract. Even taking `ADR-0035`'s owner as
settled, **no endpoint, payload schema, field list, signature algorithm, header, replay window, retry policy
or provider is decided by any source** — `ADR-0035` expressly declined to write them. **An owner is not a
contract.**

**Required authority:** **Architecture Owner** — to state whether §5.5b stands (expected) or is amended,
and separately to authorise a webhook contract. **Product Owner cannot settle this**: `PRD_OWNERSHIP_MODEL.md`
§2.2 assigns *"Boundaries, ranks, permitted edges, precedence… ADR approval"* to the Architecture Owner.

---

## §3 ✅ `FEE-GAP-001` — V1 REFUND SCOPE: **DECIDED**

**Decided by:** Product Owner (conferral). **The scope question `ADR-0038` §3.1 asked is now answered.**

| Decision | Existing source it rests on | New? |
|---|---|---|
| Only **confirmed** payments may be refunded | `FEE-BR-016` server-side confirmation; a payment that was never confirmed has no receipt to compensate | **No** — derived |
| Original financial record is **immutable** | **`MP-GBR-12`** (**Rank 1**), verbatim: *"Financial records are immutable. A receipt is immutable once issued; a refund is a **compensating entry, never a mutation**"* (`MASTER_PRD.md` **L353**) | **No** — restates Rank 1 |
| Refund recorded as a **separate financial operation** | Same — `MP-GBR-12`'s *"compensating entry"* | **No** — restates Rank 1 |
| **V1 = full refund only**; no partial | **Product decision.** Measured: `grep -rl "partial refund"` over `docs/` returns **0** authoritative requirements — the only two hits are `ADR-0038` and `PRD-008`'s own *recommendation* text, i.e. **no existing source requires partial refund**. The instruction's condition *"unless an existing authoritative source requires it"* is therefore **measurably not triggered** | **Yes** — the one genuinely new product choice |
| Cash refunds **also server-recorded** | **`ADR-0037`** (`ACCEPTED`) — cash is server-authoritative, no offline financial write. Applies to refunds by the same rule | **No** — follows `ADR-0037` |

**Why partial refund being absent matters.** `ADR-0038` §3.1 warned that partial refund is **proration
arithmetic**, and `MM-XC-012` places proration at **V2**. So *"full refund only"* is not merely a simplification
— it is the option that **avoids colliding with a frozen V2 boundary**. ✅ **No conflict.**

⚠ **What this decision does NOT do.** It does **not** write `FEE-FR-042`, `FEE-BR-019`, a refund state
machine, or `FEE-EVT-003`. Those are `PRD-008` **specification** acts. This ADR **decides scope**; the PRD must
then be updated in its own pass before `FEE-FR-042`/`FEE-BR-019` can carry acceptance criteria. Until that
happens **the two obligations still read `⛔ none`** — see §7.

---

## §4 ✅ `FEE-GAP-004` — V1 FEE TYPES: **DECIDED**

**Decided by:** Product Owner (conferral).

| V1 fee type | Revenue? |
|---|---|
| Membership Fee | ✅ Revenue |
| Renewal Fee | ✅ Revenue |
| Registration / Admission Fee | ✅ Revenue |
| Other approved library fee | ✅ Revenue |
| **Security Deposit** | ⛔ **NOT revenue** — a **refundable liability** |

### 4.1 The deposit ruling resolves a cross-PRD blocker, and that is worth stating

`PRD-022` **L802** records `SAAS-GAP-001` verbatim:

> *"**Platform Charge = 3% default** … 3% *of what*? The eligible collection base still depends on `PRD-008`
> `FEE-GAP-004`'s undecided fee-type taxonomy. **A rate without a base computes nothing**"*

The decision supplies the base: **the four revenue types, excluding Security Deposit.** This is coherent with
**`FEE-XC-023`**, which forbids `BC-05` from *recording, holding, reducing or reconciling* the
library→LIBOORA commission at all — `BC-05` **classifies** the money; `PRD-022`/`BC-20` **computes** the charge.
✅ **Platform Charge = 3% is preserved unchanged.**

⚠ **`SAAS-GAP-001` is NOT closed by this ADR.** It lives in `PRD-022`, owned by the `BC-20` owner, and
closing another PRD's gap from here would be exactly the ownership violation `FEE-XC-023` exists to prevent.
**Its dependency is discharged; the gap must be closed by its own document.**

### 4.2 Deposit-as-liability creates no new identifier

Measured: *"security deposit"* appears in `docs/` only **twice**, and **neither is a `FEE-*` identifier or a
declared fee type** — one is a grep command inside `PRD-008` § evidence. So the taxonomy is **new product
content, not a rename of anything**, and **no existing rule is contradicted**. **No `FEE-CFG-*` register is
opened** and **no ledger schema is written** — both remain `PRD-008` specification acts.

---

## §5 ✅ `FEE-GAP-005` — CORRECTIONS ARE APPEND-ONLY: **DECIDED**

**Decided by:** Product Owner **+ Architecture Owner** (`ADR-0038` §3.3 named both). The instruction supplies
the product half; the model it selects is **already mandated by Rank 1**, so no architectural change arises.

| Decision | Source |
|---|---|
| Original record remains **immutable** | **`MP-GBR-12`** (Rank 1) — *"a refund is a **compensating entry, never a mutation**"*; `FEE-BR-005`, `FEE-INV-002` |
| Correction/reversal **references the original** | Compensating-pair model — `MP-GBR-12` |
| Records **actor, reason, timestamp, corrected state** | `ADR-0038` §3.3's recommendation, now decided |
| **No edit/delete** of historical financial truth | `MP-GBR-12`; **`MP-GBR-24`** (tenant/model separation) |

### 5.1 The trap `ADR-0038` flagged is still refused, and the decision does not step in it

`ADR-0038` §3.3 warned: **do not justify append-only by analogy to `BC-03`**, because `MP-GBR-12` **deliberately
deleted** v1.0's *"except through approved workflows"* loophole, and analogical reasoning would re-insert it.

**This decision does not rely on that analogy.** It rests on `MP-GBR-12`'s own text — *"immutable… never a
mutation"* — which mandates append-only **directly**. The `BC-03` comparison is **not used as authority** and
`PRD-008`'s pre-existing *"consistent with … `BC-03`'s append-only correction model"* recommendation wording is
**left as the recommendation it always was**, not promoted to a reason. ✅ **No conflict.**

⚠ **`FEE-BR-007` still carries `⛔ none`** until `PRD-008` writes the correction requirement and its criteria.

---

## §6 ✅ `FEE-GAP-006` — V1 DUE-DATE OFFSET = **0 DAYS**: **DECIDED**

**Decided by:** Product Owner (conferral). `FEE-GAP-006`'s own Status row already reads *"**PARTLY RESOLVED**
— the three-concept ambiguity is CLOSED by measurement; **the offset value remains OPEN**"*. **This decision
closes exactly that remaining part** — the value — and nothing else.

| Decision | Why it is lawful |
|---|---|
| **V1 offset = 0 days** | An explicit, stated value — satisfying `PRD-006` §10A.4's precedent that a temporal rule must be *"not derived, inferred, or defaulted"*. **0 chosen explicitly is not 0 defaulted silently** |
| Configured settlement due date **is** the actual due date | Removes the *"hidden +N-day calculation"* the gap warned of |
| Future grace/offset needs **separate governance** | Matches `ADR-0031`'s precedent |

### 6.1 The `MP-GBR-24` trap is avoided — and this is the subtle part

`ADR-0038` §3.4 warned that **`PRD-022`'s ratified 15th must NOT be reused** for this offset, because the 15th
governs **library → LIBOORA** money (`BC-20`) while this governs **student → library** (`BC-05`), and
`MP-GBR-24` holds they *"must never share a model, a table or a metric"*.

**Offset = 0 does not import the 15th.** It states that **whatever due date `BC-05` is configured with is the
due date** — a rule about `BC-05`'s own anchor, borrowing no value from `BC-20`. Had the decision been
*"due on the 15th"*, it would have been an `MP-GBR-24` violation. **It is not, and the distinction is the
whole reason this is safe.** ✅ **`PRD-022`'s default settlement due day = 15th is preserved, untouched.**

⚠ **`FEE-AC-020`/`021` and `FEE-BR-007` remain non-deterministic** until `PRD-008` records the rule.

---

## §7 ⛔ STAGE 4 IS **STILL NOT RUNNABLE** — and this is the most important section

Four blockers now have **authoritative product decisions**. That is real progress. **It is not Stage-4
readiness, and claiming otherwise would be the exact defect the principal forbade:**

> *"Do not claim a blocker is resolved merely because it was documented. It must have authoritative resolution."*

The inverse is equally true and is the trap here: **a decision is not an implemented specification.**

### 7.1 The measured Stage-4 position

`PRD_LIFECYCLE.md` **L108–L120** check 1 requires *every requirement testable*. Measured **now**:

| Obligation | Acceptance criteria | Gap | Decision status |
|---|---|---|---|
| `FEE-FR-028` | **`⛔ none`** (L1717) | `FEE-GAP-002` | ⛔ **No decision** — conflict reported, contract still unwritten |
| `FEE-FR-042` | **`⛔ none`** (L1731) | `FEE-GAP-001` | ✅ Scope decided — **criteria not yet written** |
| `FEE-BR-019` | **`⛔ none`** (L1766) | `FEE-GAP-001` | ✅ Scope decided — **criteria not yet written** |
| `FEE-BR-007` | **`⛔ none`** (L1754) | `FEE-GAP-005`/`006` | ✅ Model + value decided — **criteria not yet written** |

**All four still carry `⛔ none`.** Check 1 therefore still fails, and **Stage 4 MUST NOT be run.**

### 7.2 Why this ADR does not write those criteria itself

Because it is an **ADR**, not a PRD. `PRD_OWNERSHIP_MODEL.md` makes `PRD-008` the owner of `FEE-*` requirements
and acceptance criteria. Writing `FEE-FR-042`'s criteria inside an ADR would:

- put an obligation's **normative text** outside the document that owns it — creating a **second divergable
  source of truth** for the same requirement;
- do it from a **`PROPOSED`** record, i.e. one that **does not bind** (`ADR-INDEX.md` status vocabulary);
- and let a Stage-4 gate pass on text no ranked document actually carries.

**The correct sequence is: decide (here) → specify in `PRD-008` → re-measure → then Stage 4.** Step 2 is a
`PRD-008` revision pass and has **not** been performed by this ADR.

### 7.3 What would make Stage 4 runnable

| Requirement | Owner | Blocking now? |
|---|---|---|
| `PRD-008` writes `FEE-FR-042`/`FEE-BR-019` refund criteria from §3 | `PRD-008` author | ✅ Yes |
| `PRD-008` writes the fee-type taxonomy and deposit-as-liability from §4 | `PRD-008` author | ✅ Yes |
| `PRD-008` writes `FEE-BR-007` correction + offset criteria from §5/§6 | `PRD-008` author | ✅ Yes |
| **Webhook contract for `FEE-FR-028`** | **Architecture Owner** | ✅ Yes — **and no decision exists** |
| This ADR accepted by the appropriate authority | Product / Architecture Owner | ✅ Yes — `PROPOSED` does not bind |

**Even if `PRD-008` were fully updated today, `FEE-FR-028` would still carry `⛔ none`**, because §2's conflict
is unresolved and no source supplies a webhook contract. **`FEE-GAP-002` alone is sufficient to block Stage 4.**

---

## §8 Preserved decisions — verified, not assumed

Each was **re-measured** this pass:

| Preserved decision | Verified |
|---|---|
| Platform Charge = **3%** | ✅ `PRD-022` `SAAS-BR-001`; untouched. `FEE-XC-023` still bars `BC-05` from holding it |
| Default settlement due day = **15th** | ✅ `PRD-022` L262/L277; **not reused** for `BC-05` (§6.1) |
| Owner/Admin may change **future** configuration | ✅ Unchanged — §6 governs a V1 **offset**, not who may configure |
| **Historical obligations never change** | ✅ **Strengthened** by §5's append-only ruling; `MP-GBR-12` |
| Cash-only settlement supported | ✅ `ADR-0037` (`ACCEPTED`), untouched — and §3 **extends** its rule to refunds |
| **No offline financial write** | ✅ `ADR-0037`; §3's *"cash refunds server-recorded"* is the same rule |
| **3-day renewal protection remains mandatory V1** | ✅ `ADR-0036`; **not touched** — its open question 2 is unrelated to these five gaps |

---

## §9 Objections, stated before they are raised

**"You were told to resolve `FEE-GAP-002` — you reported a conflict instead."**
The instruction's final paragraph **required** exactly that: *"If any proposed solution conflicts with a frozen
rule or requires a new architectural edge, STOP and report the conflict."* `ADR-0035` is **`ACCEPTED` — in
force, binding**. Silently routing ingress to a different module would have overridden a binding architectural
decision on my own authority. **Four of the five instruction clauses for that gap were confirmed as already
decided; only the routing owner is contested.**

**"Then the conflict is trivial — just use `platform/business`."**
That is the likely outcome and §2 says so. But it is **not mine to declare**, and it would **not unblock
Stage 4 anyway** — `FEE-FR-028` needs a **contract**, which neither module assignment supplies.

**"You recorded four decisions but no gap is marked RESOLVED."**
Correct, and deliberate. A gap's `Stage 4` field asserts something about **`PRD-008`'s testability**. Until
`PRD-008` carries the criteria, flipping those fields from a `PROPOSED` ADR would make the ledger claim a
testability the PRD does not have. **The gap ledger is left for the `PRD-008` pass that will earn the change.**

**"`ADR-0039` should be `ACCEPTED` — the principal gave the decisions."**
The **decisions** are the principal's and are recorded as given. **Acceptance of the ADR is a separate act**,
and §2 contains an unresolved **Architecture Owner** question. Accepting a record that contains an open
architectural conflict would bind the parts that are settled *and* the part that is not.

---

## §10 Verification performed

| # | Check | Result |
|---|---|---|
| 1 | `grep -rl "partial refund"` over `docs/` for an authoritative requirement | **0** — condition not triggered |
| 2 | `MP-GBR-12` read verbatim at `MASTER_PRD.md` **L353** | Mandates immutability + compensating entry |
| 3 | `ADR-0035` §5.5b read verbatim | Names **Business Platform** — conflict confirmed real |
| 4 | `ADR-0035` L442 (superseded proposal) checked | Named `platform/integration`; **superseded**, not authority |
| 5 | `FEE-GAP-006` Status row read | *"offset value remains OPEN"* — §6 closes exactly that |
| 6 | `PRD-022` L802 `SAAS-GAP-001` read | Base dependency discharged, gap left open for its owner |
| 7 | `FEE-XC-023` read | §4 stays inside it |
| 8 | The four obligations' criteria re-measured | **All still `⛔ none`** → Stage 4 not runnable |
| 9 | BC-32 / new edges / new registers | **None created** |
| 10 | Frozen documents, checkers | **Unmodified** — hashes verified |

## §11 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **Created `PROPOSED`.** Records **four** Product-Owner decisions (`FEE-GAP-001` refund scope, `FEE-GAP-004` fee types incl. Security Deposit as liability, `FEE-GAP-005` append-only corrections, `FEE-GAP-006` offset = 0 days) against their existing sources, and **reports one conflict** (`FEE-GAP-002` webhook routing: instruction says `platform/integration`, `ACCEPTED` `ADR-0035` §5.5b says `platform/business`) **rather than inventing a workaround**. **No gap's `Stage 4` field is flipped and no requirement text is written**, because those are `PRD-008` acts and this ADR does not bind. **Stage 4 remains NOT runnable** — all four named obligations still carry `⛔ none`. Creates **no** `BC-32`, edge, permission, config ID, role, API, endpoint, schema, provider or financial rule. Modifies **no** frozen document, **no** `ACCEPTED` ADR and **no** checker. Preserves 3% Platform Charge, the 15th settlement day, future-configuration authority, historical immutability, cash settlement, no-offline-write and mandatory V1 3-day renewal protection — **each re-measured, not assumed**. |
