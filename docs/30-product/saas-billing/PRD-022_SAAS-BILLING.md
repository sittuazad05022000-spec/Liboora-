# `PRD-022` — SaaS Billing & Platform Revenue

| Field | Value |
|---|---|
| **PRD** | `PRD-022` |
| **Bounded context** | **`BC-20` Subscription & Billing** — `[GENERIC]`, Business layer, **V1** |
| **Version** | **v0.1 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT frozen. NOT approved. NOT architecture-reviewed.** |
| **Authorised by** | `MASTER_PRD.md` **L169** — §8 **module 17**, *"SaaS Billing \| `BC-20` Subscription & Billing \| `[GENERIC]` \| V1"* · `PRD_REGISTRY.md` **L326** (`PRD-022`, `V1`, `PLANNED`) · `PRD_REGISTRY.md` **L427** (§6: `BC-20` → `PRD-022`, **not contested**) |
| **Identifier prefix** | `SAAS-*` — collision-checked against every existing register before use (`PRD_LIFECYCLE.md` §5 rule 2). Measured **0** pre-existing `SAAS-*` identifiers repository-wide |
| **Owns money** | **Library → LIBOORA only.** Every obligation in this document is money a **library owes LIBOORA** |
| **Owns NO student money** | This document defines **no** student fee, payment, receipt or ledger. That is `BC-05`/`PRD-008` |
| **Blocking governance gaps** | **6 gaps.** **6 block Stage 4** · **6 block Freeze** — see §12 |

---

## 0. How to read this document

### 0.1 Why this PRD exists now

`BC-20` has been a registered, uncontested, **V1** context since the register was created, and its PRD was one of
`PGA-05`'s *"nine module PRDs named in v1.0 and never written"*. It is written now because **three separate
governance findings all terminated here** and could not be resolved anywhere else:

| Finding | Where it was raised | Why it could only be answered here |
|---|---|---|
| `FEE-GAP-014` — the platform charge has no owning document | `PRD-008` v0.4 | `MP-GBR-24` bars `PRD-008` from owning library → LIBOORA money |
| `FEE-GAP-017` — a cash-only library has no lawful way to pay | `PRD-008` v0.8 | Same bar; and the missing aggregate is `BC-20`'s |
| SaaS free trial has no specification | Master PRD §8 module 17 | `BC-20` owns `Subscription`; nothing else may |

> **Creating this PRD is not "inventing a PRD to fill a gap."** The registry's own §4.3 note sets the test, in the
> course of registering `PRD-023`: a Master PRD §8 module row, a `[GENERIC]` classification and a V1 scope are what
> make something a module. `BC-20` is **module 17** — the row the note cites *as the precedent* — so authoring it
> applies a mechanism this repository already established rather than a new one. **No requirement is moved into
> existence by this act:** every obligation below is either newly specified here for the first time or explicitly
> deferred to a named gap.

### 0.2 The registers

| Register | Meaning | Count | Range |
|---|---|---|---|
| `SAAS-FR-*` | Functional requirement | **18** | `SAAS-FR-001` … `SAAS-FR-018` |
| `SAAS-BR-*` | Business rule | **9** | `SAAS-BR-001` … `SAAS-BR-009` |
| `SAAS-INV-*` | Invariant | **5** | `SAAS-INV-001` … `SAAS-INV-005` |
| `SAAS-XC-*` | Explicit exclusion — what this module MUST NOT do | **11** | `SAAS-XC-001` … `SAAS-XC-011` |
| `SAAS-AC-*` | Acceptance criterion | **21** | `SAAS-AC-001` … `SAAS-AC-021` |
| `SAAS-GAP-*` | Governance gap / open question — **not a requirement** | **6** | `SAAS-GAP-001` … `SAAS-GAP-006` |
| **Total** | | **70** | |

**Obligation-bearing** = 18 + 9 + 5 + 11 = **43**. `SAAS-AC-*` are *verified by* tests and `SAAS-GAP-*` are *open
questions*; neither is an obligation, exactly as `PRD-006` §0.3 treats `ATT-AC-*` and `ATT-GAP-*`.

> **No configuration register is declared.** `CONFIGURATION_GUIDE.md` §5 states that *"Adding a parameter"* requires
> *"a **PRD amendment** — the specification declares what is configurable, this guide does not."* This document
> therefore **declares which values are configurable and at what scope**, and creates **no** `CFG-*`, `LCFG-*`,
> `ICFG-*` or new configuration identifier of its own. Allocating identifiers in those closed registers is the
> owning PRD's act, not this one's — recorded as `SAAS-GAP-002`.

### 0.3 Normative language

**MUST** / **MUST NOT** — mandatory. **SHOULD** — recommended; a deviation is recorded. **MAY** — permitted.
A requirement with no verifying `SAAS-AC-*` is **incomplete**, not merely untested.

---

## 1. Terminology — the approved product term

**The official product term is `Platform Charge`, in full "LIBOORA Platform Charge".**

| Term | Meaning | Owner |
|---|---|---|
| **Platform Charge** | A percentage of eligible confirmed student collections that a **library owes LIBOORA** | **`BC-20`** — this document |
| **Platform Charge obligation** | A single accrued, dated, rated Platform Charge amount owed by one library | **`BC-20`** |
| **Outstanding Platform Charge** | The unsettled sum of a library's Platform Charge obligations | **`BC-20`** |
| **Settlement** | A library's payment to LIBOORA that reduces its Outstanding Platform Charge | **`BC-20`** |
| **Membership fee** | What a **student owes the library** | `BC-05` — `PRD-008`. **Not this document** |
| **Subscription** | What a library owes LIBOORA for the SaaS plan itself, independent of collections | **`BC-20`** |

### 1.1 The terminology transition from "commission"

**Measured before writing.** `Platform Charge` appeared **0** times repository-wide. The word `commission` appears
in fourteen files; **every occurrence outside `PRD-008`, its alignment record and `ADR-0035` is the English verb**
(*"Commission an anchored analysis"*, *"whoever the owner commissions"*, `SeatDecommissioned`). The financial sense
exists in exactly **three non-frozen documents**.

| Document | Status | Action |
|---|---|---|
| `PRD-008_REVENUE-AND-FINANCE.md` | `DRAFT` | Terminology note added at its v0.9; **prior text not rewritten** |
| `PRD-008_ARCHITECTURE_ALIGNMENT.md` | Working record | Left as the historical record of what was measured when |
| `ADR-0035` | `PROPOSED` | Left unchanged; an ADR records what was decided **when it was decided** |
| **Any frozen document** | — | **None affected.** No frozen document uses the financial sense |

> **Why the older text is not rewritten.** Two reasons, and the second matters more. First, the instruction is
> explicit: *"do NOT blindly rewrite frozen documents."* Second, and independently: `PRD-008`'s v0.4–v0.8 changelog
> entries are a **record of decisions taken on particular days**, and retroactively editing the vocabulary of a
> decision record makes it impossible to audit what was actually known at the time. The transition is therefore
> **forward-only** — new requirements use `Platform Charge`; historical entries keep their original wording and are
> reconciled by this section. `SAAS-BR-001` makes that binding.

`SAAS-BR-001` — All **new** requirements, UI strings, product documentation and platform-facing terminology **MUST**
use *Platform Charge*. The term *commission* **MUST NOT** be introduced into any new requirement, and **MUST NOT**
be removed from an existing decision record, changelog entry or `PROPOSED` ADR.

---

## 2. Financial boundary — `MP-GBR-24`, restated from this side

`MASTER_PRD.md` **L362**, Rank 1: *"Money owed by a **student to the library** (`BC-05`) is a different concept from
money owed by a **library to LIBOORA** (`BC-20`). They **must never share a model, a table or a metric**."*

`PRD-008` states this boundary as a set of prohibitions on itself (`FEE-XC-001`, `FEE-XC-002`, `FEE-XC-023`). This
document states the **mirror-image** prohibitions on `BC-20`:

`SAAS-XC-001` — Creating, holding, modifying, reducing or reading-for-write a **student's** `FeeDue`, `FeePayment`,
`Receipt`, `FeeLedger` entry or student balance.

`SAAS-XC-002` — Executing, initiating, confirming or verifying a **student → library** payment. Payment intent and
student financial truth are `BC-05`'s (`ADR-0035` `D-2`, option `O-3`).

`SAAS-XC-003` — Presenting any Platform Charge, subscription or settlement figure to a **student**, in any surface.
A student is not a party to the library's obligations to LIBOORA.

`SAAS-XC-004` — Deriving a Platform Charge from anything other than a **confirmed** student collection fact. An
unconfirmed, pending, failed or offline-recorded payment **MUST NOT** accrue a Platform Charge.

> **The direction of money is the whole distinction, and it is worth stating plainly.** Every payment path the
> architecture describes today is **inbound** — a student pays a library, or LIBOORA **pulls** from a library via
> `PaymentAttempt`/`DunningState` (BC Map **L382**). A cash-only settlement is **library-initiated outbound
> remittance**, and that shape appears nowhere in the architecture as measured. §7 is where that is confronted
> rather than assumed away.

---

## 3. What `BC-20` owns, and what it does not

| Concern | Owner | Authority |
|---|---|---|
| SaaS subscription, plan, invoice | **`BC-20`** | BC Map **L382** aggregates |
| SaaS free trial | **`BC-20`** | Master PRD §8 module 17; EA **L1355** *Free Trial (V1)* |
| Platform Charge, its rate, its history | **`BC-20`** | BC Map **L129** — *"money owed by a library to LIBOORA"* |
| Platform Charge obligation and outstanding balance | **`BC-20`** | Same |
| Library → LIBOORA settlement and its verification | **`BC-20`** | Same |
| Student fee obligation, payment, receipt, ledger | `BC-05` | `MP-GBR-24`; `PRD-008` |
| Payment **execution** (student → library) | Business Platform capability | `ADR-0035` `D-2` = `O-3` |
| Gateway vendor contracts, credentials, retries | `BC-31` | BC Map **L140** |
| Roles, permissions, authorisation decisions | `BC-18` / `PRD-001` | `X-13` — *"No authorisation decided outside `BC-18`"* |
| Configurable-parameter registers | `BC-25` / `PRD-023` | `ADR-0017`; `CONFIGURATION_GUIDE.md` §5 |

`SAAS-XC-005` — Declaring, granting, evaluating or naming a **permission** or a **role**. `X-13` makes an
authorisation decision taken outside `BC-18` *"a security defect that passes its own tests"*. Where this document
needs an authority to exist, it records a gap (§12) and **does not name an identifier**.

`SAAS-XC-006` — Naming a payment provider, endpoint, webhook schema, signature algorithm, retry policy, bank-account
structure or UPI flow. `BC-31` owns vendor knowledge; BC Map **L334** requires that *"Billing knows no vendor names."*

---

## 4. Platform Charge — calculation

**Product decision applied:** the default Platform Charge is **3%**.

`SAAS-FR-001` — The platform **MUST** hold a Platform Charge **rate** as a platform-scoped configurable value with a
default of **3%**.

`SAAS-FR-002` — A Platform Charge **MUST** be accrued only from a **confirmed** student collection fact produced by
`BC-05`. `BC-20` **MUST NOT** compute one from its own observation of a payment.

`SAAS-FR-003` — Each accrued Platform Charge obligation **MUST** record, at accrual time: the owning library/tenant,
the underlying confirmed-collection reference, the collection amount it was computed from, the **rate applied**, the
computed charge amount, and the accrual timestamp.

`SAAS-FR-004` — The computed charge amount **MUST** be **derived** from the recorded collection amount and recorded
rate. It **MUST NOT** be editable by a Library Owner, a Library Manager, or a Platform Administrator.

`SAAS-BR-002` — Worked example, normative as an illustration of §4's arithmetic only: a confirmed student membership
collection of **₹500** at a rate of **3%** accrues a Platform Charge obligation of **₹15**. One hundred such
collections accrue **₹1,500** against a **₹50,000** student → library collection total.

`SAAS-INV-001` — A Platform Charge obligation's `rateApplied` and `chargeAmount` are **immutable** once accrued.

> **`SAAS-FR-004` is the requirement the product brief cares most about and it is easy to get wrong.** "Not
> arbitrarily editable" is not the same as "read-only in the UI." A settlement screen that lets an Owner type an
> amount, and then settles *that* amount, has made the Owner the author of LIBOORA's revenue. The amount presented
> for settlement must be the **derived** outstanding figure, and `SAAS-AC-004` verifies that a submitted amount which
> disagrees with the derived figure is **rejected server-side**, not merely disabled client-side.

### 4.1 What "eligible" means — and what this document does not decide

`SAAS-FR-002` says *confirmed*. It does **not** say which confirmed collections are eligible. Whether the Platform
Charge applies to membership fees only, or also to deposits, late fees, or other fee types, depends on the fee-type
taxonomy that **`PRD-008` `FEE-GAP-004` has not settled**. Deciding it here would be deciding another module's open
question from the outside.

`SAAS-GAP-001` — **Platform Charge eligibility base is undecided.** Recorded, not guessed. See §12.

---

## 5. Historical rate — immutability

**Product decision applied:** a confirmed transaction keeps the rate it was confirmed at.

`SAAS-FR-005` — A change to the Platform Charge rate **MUST** apply only to obligations accrued **after** the change
becomes effective. It **MUST NOT** recompute, restate or adjust any already-accrued obligation.

`SAAS-BR-003` — Worked example, normative: obligation `A` accrues at **3%** on a **₹500** collection = **₹15**. The
rate later becomes **2.5%**. Obligation `A` **remains ₹15**. It **MUST NOT** become ₹12.50.

`SAAS-INV-002` — For every Platform Charge obligation, `chargeAmount` equals `collectionAmount × rateApplied` using
the **stored** `rateApplied`, and never the current configured rate.

`SAAS-XC-007` — Recomputing, back-dating or bulk-adjusting historical Platform Charge obligations, **including by a
Platform Administrator**. Part 7 of the product brief permits `PR-1` to change the **rate**; it does not permit
rewriting history, and `SAAS-INV-002` makes the distinction machine-checkable.

> **Where the historical rate is stored, and why not in `FeePayment`.** The immutable snapshot lives on the
> **Platform Charge obligation**, in `BC-20`. It **MUST NOT** be added to `BC-05`'s `FeePayment`: `MP-GBR-24` bars a
> shared model, and `PRD-008`'s `FEE-FR-060` deliberately carries no charge field, verified by its `FEE-AC-083`.
> `PRD-008` already provides the *rate-at-confirmation* immutability on its own side of the boundary via
> `FEE-FR-060` + `FEE-INV-010` + `FEE-BR-028`, so **no new `BC-05` identifier is needed** and none was created.

---

## 6. Platform Charge obligation lifecycle

`SAAS-FR-006` — The platform **MUST** maintain, per library, an **Outstanding Platform Charge** figure equal to the
sum of that library's accrued obligations less the sum of its **successfully verified** settlements.

`SAAS-FR-007` — An authorised library actor **MUST** be able to view: total confirmed collections the charge was
computed from, the rate applied **per obligation**, total already settled, outstanding charge, current payable,
settlement history and the status of each settlement.

`SAAS-FR-008` — A settlement **MUST** reduce the Outstanding Platform Charge **only** on successful server-side
verification (§8).

`SAAS-INV-003` — Outstanding Platform Charge is **never negative**, and is a **derived** figure — it is never
directly assignable.

`SAAS-XC-008` — Reducing, waiving or writing off an Outstanding Platform Charge other than by a verified settlement,
absent an authorised waiver capability. No waiver capability is specified here, and none is invented.

### 6.1 Reconciliation — what a settlement must leave untouched

`SAAS-BR-004` — A verified settlement reduces **only** the library's Outstanding Platform Charge. It **MUST NOT**
alter a student's fee obligation, a student's payment amount, a receipt amount, a `FeeLedger` balance, a student
balance, or the library's **student-revenue** figure.

`SAAS-AC-001` — After a completed settlement, every `BC-05` figure for every affected student is **byte-identical**
to its pre-settlement value, and no `BC-05` table has gained a row.

> This is the same fact `PRD-008` states from its side as `FEE-XC-023` / `FEE-AC-084`. It is stated on **both** sides
> deliberately: `PRD-008` must forbid *receiving* such a write, and `BC-20` must forbid *attempting* one. Neither
> statement alone closes the boundary, and the two are not duplicate identifiers — they constrain different modules.

---

## 7. Cash-only settlement — a first-class V1 requirement

**The scenario, restated as the requirement it is:** a library takes **100 memberships × ₹500 = ₹50,000** entirely in
cash, with **zero** online student payments, and owes a **₹1,500** Platform Charge. It **MUST** be able to pay.

`SAAS-FR-009` — The platform **MUST** support settlement of an Outstanding Platform Charge by a library that has
**zero** online student collections, present or future. Settlement **MUST NOT** depend on the existence of any
student online payment.

`SAAS-FR-010` — Where the authorised architecture and provider arrangement support it, a Platform Charge **MAY** be
settled by **net-off** against amounts otherwise payable to the library.

`SAAS-BR-005` — Net-off **MUST NOT** be the only settlement mechanism. A library with no online collections and no
expectation of future collections **MUST** still have a lawful settlement path.

`SAAS-XC-009` — Making settlement conditional on future online student collections, or on any projected future
revenue.

> **Why `SAAS-BR-005` is written as a prohibition on the platform rather than a feature.** `PRD-008`'s
> `FEE-GAP-014` recommended *"net-off against future collections"* — a reasonable default that **silently assumes
> online collections exist**. In a 100%-cash library that assumption is false, and a design that relies on it
> produces a receivable that can never be collected. Stating the prohibition prevents a future pass from
> re-deriving the same convenient assumption.

### 7.1 The settlement rail — what exists, and what is missing

**Measured, not assumed.** An outbound rail to a payment provider **already exists** and did not need inventing:

| Fact | Where measured |
|---|---|
| `E-25` — `BC-20 Billing` → `BC-31 Integration`, `CF`, sync port, *"Gateway abstraction; Billing knows no vendor names"* | BC Map **L334** |
| `platform/business` already declares `ports: [platform/integration:payment_gateway]` | `tool/module_dependencies.yaml` **L409** |
| `BC-31` scope is *"outbound third-party contracts, credentials, retries, idempotent delivery"* | BC Map **L140** |

`SAAS-FR-011` — A library-initiated settlement **MUST** reach its payment provider through the existing authorised
gateway path (`E-25` → `BC-31`). **No new edge, port, provider or endpoint is created by this document.**

`SAAS-XC-010` — Routing a Library → LIBOORA settlement through `BC-05`, or through any student-payment path.

**What is genuinely missing is not transport.** It is that every payment flow the architecture describes is
*inbound*: `BC-20`'s aggregates are `PaymentAttempt` and `DunningState` (BC Map **L382**) — LIBOORA **pulling** from
a library — and a **library-initiated outbound remittance** has no described shape. Whether the existing gateway
abstraction can carry that direction is an **architecture** question, not a product one.

`SAAS-GAP-003` — **Library-initiated outbound remittance has no described shape on the existing rail.** Recorded for
the Architecture Owner. See §12.

---

## 8. Settlement verification — client success is not financial truth

`SAAS-FR-012` — A settlement **MUST** hold exactly one of the states **`Pending`**, **`Successful`** or **`Failed`**.

`SAAS-FR-013` — A settlement **MUST** become `Successful` only on **server-side verification** through the authorised
verification mechanism. A button press, a client-reported success, a completed redirect or a closed payment page
**MUST NOT** transition a settlement to `Successful`.

`SAAS-FR-014` — A settlement **MUST** be **idempotent** with respect to its authorised reference, so that a retry,
a duplicate submission or a repeated callback cannot reduce the Outstanding Platform Charge twice.

`SAAS-BR-006` — `Pending` and `Failed` settlements **MUST NOT** reduce the Outstanding Platform Charge, and **MUST
NOT** be presented as settled.

`SAAS-INV-004` — The sum of `Successful` settlements for a library never exceeds the sum of its accrued obligations.

`SAAS-XC-011` — Treating any client-originated signal as financial truth, for any settlement state transition.

> **Three states only, deliberately.** The brief permits *"Pending, Successful, Failed"* and says not to invent more
> *"unless required by the existing architecture."* Measured: `BC-20` already owns a `PaymentAttempt` aggregate and a
> `DunningState` (BC Map **L382**), so richer states may already exist there — but their vocabulary is **not written
> down anywhere**, and inventing names for them would pre-empt the aggregate's own specification. Three states are
> declared; alignment with `PaymentAttempt` is recorded as part of `SAAS-GAP-003`.

### 8.1 Audit

`SAAS-FR-015` — Every settlement **MUST** be auditable such that the following are establishable: the library/tenant;
the Platform Charge amount; the underlying Platform Charge obligations it discharges; the settlement timestamp; the
**initiating** actor; the **authorised** actor; the settlement status; and an **immutable historical reference**.

`SAAS-INV-005` — A settlement's audit record is **append-only**. Once written it is never modified or deleted, and a
correction is a new record referencing the original.

`SAAS-AC-002` — For any completed settlement, all eight facts in `SAAS-FR-015` are retrievable, and the underlying
obligations it discharged can be enumerated exactly.

> **No schema is defined.** `SAAS-FR-015` states the facts that must be *establishable*, not the tables, columns,
> keys or types that establish them — the brief forbids inventing a schema, and the storage design belongs to
> implementation. The distinction between *initiating* and *authorised* actor is retained because the two may differ
> if a Manager ever becomes able to initiate what an Owner authorises (§9.2).

---

## 9. Settlement authority — measured, and unresolved

**This is the load-bearing constraint of the whole feature, and the measurement is worse than the brief assumed.**

### 9.1 What the authoritative role documents say

| Fact | Source |
|---|---|
| `TR-1` Owner: *"Complete operational authority within the library: configuration, staff role assignment and revocation, **financial and revenue visibility**, member administration, library closure."* | `prd-v2/02` **L159** |
| `TR-2` Manager: *"**Cannot alter library-level commercial configuration.** Cannot exceed Owner permissions."* | `prd-v2/02` **L169** |
| `TR-2` Manager scope: *"Operational only … Entire library, **excluding commercial configuration**"* | `prd-v2/02` **L200** |
| Tenant roles: *"Five, closed: `TR-1` … `TR-5`"* · Platform roles: *"Two, closed: `PR-1`, `PR-2`"* | `prd-v2/07` **L87**, **L79** |
| *"The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted, requested or evaluated."* | `prd-v2/07` **L124** (`AUTH-7.22`) |
| *"**Fail closed** — Where any input to a decision is unavailable, indeterminate or in error, the decision is refusal"* | `prd-v2/07` **L57** (`AP-9`) |
| **Financial** permission category examples: *"Viewing revenue; recording a payment"* — both **inbound** | `prd-v2/07` **L136** |
| `grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` → **0 results** | measured |

### 9.2 The consequence, stated without softening

**Neither `TR-1` nor `TR-2` can perform a Platform Charge settlement today.**

`TR-1` Owner is supportable **in principle** — L159 grants financial authority and commercial configuration, and
settling the library's own obligation is squarely within *"Complete operational authority."* But **no permission
identifier is enumerated anywhere in the repository**, and `AUTH-7.22` makes an undeclared permission unable to be
*"granted, requested or evaluated."* With `AP-9` failing closed, the settlement action resolves to **refusal** — for
the Owner as much as for anyone else.

`TR-2` Manager is additionally **barred on its own terms** by L169 and L200.

> **This is not a technicality that can be worked around here.** `X-13` makes an authorisation decision taken
> outside `BC-18` *"a security defect that passes its own tests"* — which is precisely what naming a plausible
> permission in this document would produce: a specification that looks complete, tests green, and grants an
> authority no authorisation model recognises. The brief's instruction — *"Do NOT invent a permission identifier"* —
> and `X-13` point the same way.

`SAAS-FR-016` — A Platform Charge settlement **MUST** be initiated and completed only by an actor holding an
authority **declared in the authoritative authorisation model** (`BC-18`/`PRD-001`). Until such an authority exists,
the action **MUST** fail closed per `AP-9`.

`SAAS-BR-007` — The **safe default is that `TR-2` Manager cannot settle.** Manager settlement **MUST NOT** be enabled
by inference, by convenience, or by treating settlement as an operational rather than commercial act.

`SAAS-BR-008` — A Platform Administrator (`PR-1`) **MUST NOT** settle a library's Platform Charge on its behalf as a
substitute for the library's own authorised act. Platform authority over configuration is not authority over a
tenant's payment.

`SAAS-GAP-004` — **No enumerated permission exists for Platform Charge settlement, for any role.** The single
highest-priority blocker. See §12.

---

## 10. SaaS free trial

**Product decision applied:** the default free trial is **14 days**.

`SAAS-FR-017` — The platform **MUST** hold a platform-wide SaaS free-trial duration as a platform-scoped configurable
value with a default of **14 days**.

`SAAS-BR-009` — A change to the platform-wide default **MUST NOT** retroactively alter the trial period of any
library whose trial is already in progress or already ended.

`SAAS-FR-018` — Trial eligibility **MUST** be determined against the **authoritative library/tenant identity**, such
that deleting and recreating an account does not yield a further trial.

`SAAS-AC-003` — A library that has consumed a trial and is then deleted and recreated does **not** receive a second
trial.

> **`SAAS-FR-018` states the requirement and deliberately stops short of the mechanism.** Tying eligibility to
> *"the authoritative library/tenant identity"* is a product requirement; deciding **which** identity survives a
> deletion — and whether a soft-deleted tenant is the same tenant — depends on the tenant lifecycle and the
> `CFG-10` soft-delete retention that **`PRD-001` and `BC-25` own**, not this document. Recorded as
> `SAAS-GAP-005` rather than resolved by asserting a rule about identity that another module owns.

**No minimum or maximum configurable range is declared** for either the trial duration or the Platform Charge rate.
The brief forbids inventing a range absent product-owner approval, and `CONFIGURATION_GUIDE.md` §5 treats a range as
*"part of the reasoning, not a formality."* Ranges are `SAAS-GAP-002`.

---

## 11. Configuration ownership — the four categories kept apart

| Category | Examples | Scope | Who may change |
|---|---|---|---|
| **Platform-level configuration** | Platform Charge rate; SaaS free-trial duration | Platform | `PR-1` via the authorised platform configuration mechanism |
| **Tenant-level configuration** | Renewal-protection window; membership policy; seat policy | One library | Library authority per the tenant configuration model |
| **Student-level financial facts** | `FeeDue`, `FeePayment`, `Receipt` | One student | `BC-05` only — **not this document** |
| **Library → LIBOORA financial facts** | Platform Charge, obligation, settlement | One library | `BC-20` — this document |

`SAAS-AC-004` — A settlement request whose submitted amount differs from the server-derived outstanding figure is
**rejected server-side**.

`SAAS-AC-005` — A `PR-1` actor cannot alter a **tenant-level** configuration value, and a library actor cannot alter
a **platform-level** value; both attempts fail closed.

> **The renewal-protection window is listed here as tenant-level and is specified nowhere in this document.** It is
> `BC-02`/`BC-06`/`BC-25` territory and is tracked by `PRD-008`'s `FEE-GAP-013`. Listing it in this table records the
> **category boundary**, which the brief asks for, without claiming the parameter.

---

## 12. Governance gap ledger

**6 gaps. 6 block Stage 4. 6 block Freeze.** None is closed by a plausible solution; each names an authority.

### `SAAS-GAP-001` — Platform Charge eligibility base

| Field | Value |
|---|---|
| **Question** | Which confirmed student collections accrue a Platform Charge — membership fees only, or also deposits, late fees and other fee types? |
| **Why it cannot be answered here** | It depends on the fee-type taxonomy, which is **`PRD-008` `FEE-GAP-004`** and undecided. `BC-05` owns the taxonomy |
| **Classification** | **REQUIRES PRODUCT OWNER** |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |
| **What was NOT invented** | No eligibility list, no fee-type enumeration, no default of *"everything"* |

### `SAAS-GAP-002` — Configurable ranges and parameter identifiers

| Field | Value |
|---|---|
| **Question** | What are the minimum/maximum ranges for the Platform Charge rate and the free-trial duration, and under which register are their parameter identifiers allocated? |
| **Measured** | `CONFIGURATION_GUIDE.md` v1.1 governs **35** parameters (`CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`) and holds **no** Platform Charge rate and **no** trial duration. §5: *"Adding a parameter — a **PRD amendment**"*, and this document supplies that amendment for **what** is configurable, not for the identifier |
| **Classification** | **REQUIRES PRODUCT OWNER** (ranges) + **`BC-25`/`PRD-023`** (identifier allocation) |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |
| **What was NOT invented** | No range, no default minimum or maximum, no `CFG-*`/`LCFG-*`/`ICFG-*` identifier, no new configuration register |

### `SAAS-GAP-003` — Library-initiated outbound remittance has no described shape

| Field | Value |
|---|---|
| **Question** | Can the existing `E-25` → `BC-31` gateway abstraction carry a **library-initiated outbound** remittance, and how does a settlement state relate to `BC-20`'s existing `PaymentAttempt`/`DunningState`? |
| **Measured** | The rail exists (BC Map **L334**; manifest **L409**) and `BC-31` is scoped to *"**outbound** third-party contracts"* (**L140**), so the direction is not obviously wrong — but every described flow is LIBOORA **pulling** (`PaymentAttempt`, `DunningState`, BC Map **L382**), never a library **pushing** |
| **Classification** | **REQUIRES ARCHITECTURE OWNER** |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |
| **What was NOT invented** | No provider, endpoint, webhook schema, signature algorithm, retry policy, bank-account structure, UPI flow, new edge, new port or new aggregate name |

### `SAAS-GAP-004` — No enumerated permission for settlement, for any role

| Field | Value |
|---|---|
| **Question** | Which declared authority permits `TR-1` Owner to initiate and complete a Platform Charge settlement, and is `TR-2` Manager to be permitted at all? |
| **Measured** | `AUTH-7.22` (`prd-v2/07` **L124**) closes the permission catalogue; `grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` → **0**; `AP-9` (**L57**) fails closed. **Therefore the action is refused for `TR-1` as well as `TR-2`** — this is not merely a Manager question. `TR-2` is additionally barred by **L169**/**L200**. The **Financial** category's examples (**L136**) are both *inbound* and do not evidently reach outbound remittance |
| **Classification** | **REQUIRES AUTHORIZATION OWNER** (`BC-18`/`PRD-001`) + **REQUIRES PRODUCT OWNER** (whether `TR-2` should be permitted) |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |
| **What was NOT invented** | No permission identifier, no sixth tenant role, no third platform role, no *"Super Admin"*, no inferred grant. `X-13` forbids deciding it here |
| **Safe default meanwhile** | `SAAS-BR-007` — Manager cannot settle |

### `SAAS-GAP-005` — Trial eligibility identity

| Field | Value |
|---|---|
| **Question** | Which authoritative identity anchors trial eligibility across tenant deletion and recreation, and does a soft-deleted tenant remain the same tenant? |
| **Measured** | `CFG-10` governs *"Soft-deleted account retention before permanent erasure"* and is **Authentication's** parameter, not `BC-20`'s. Tenant lifecycle is not `BC-20`'s aggregate |
| **Classification** | **REQUIRES ARCHITECTURE OWNER** + **`PRD-001`** |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |
| **What was NOT invented** | No identity rule, no fingerprinting, no device or contact-based matching — the last of which would also be a privacy decision this document may not take |

### `SAAS-GAP-006` — Stage 3 architecture review has not been performed

| Field | Value |
|---|---|
| **Question** | Does this PRD pass the six Stage 3 checks of `PRD_LIFECYCLE.md` §3 against Ranks 1–5? |
| **Status** | **Not attempted.** This document is Stage 2 output. Notably `SAAS-FR-011` asserts that no new edge is required, and **that assertion is exactly the kind of claim Stage 3 exists to test** |
| **Classification** | **REQUIRES ARCHITECTURE OWNER** |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |

### 12.1 Gap summary

| Gap | Subject | Authority | Blocks Stage 4 | Blocks Freeze |
|---|---|---|---|---|
| `SAAS-GAP-001` | Platform Charge eligibility base | Product Owner | ✅ | ✅ |
| `SAAS-GAP-002` | Configurable ranges + parameter ids | Product Owner + `BC-25` | ✅ | ✅ |
| `SAAS-GAP-003` | Outbound remittance shape on the rail | Architecture Owner | ✅ | ✅ |
| `SAAS-GAP-004` | Settlement permission for any role | Authorization Owner + Product Owner | ✅ | ✅ |
| `SAAS-GAP-005` | Trial eligibility identity | Architecture Owner + `PRD-001` | ✅ | ✅ |
| `SAAS-GAP-006` | Stage 3 not performed | Architecture Owner | ✅ | ✅ |

**6 gaps. 6 block Stage 4. 6 block Freeze.**

> **Every gap blocks, and that is the honest result of a first draft rather than a pessimistic one.** A V1 module
> whose central action cannot be authorised by any existing role, whose configurable values have no registered
> identifiers, and whose settlement direction has no described shape is not close to implementable. Recording fewer
> blockers would make this document look more finished than the platform is.

---

## 13. Acceptance criteria

**21 criteria, `SAAS-AC-001` … `SAAS-AC-021`.** Each is *verified by* a test; none is an obligation.

| ID | Criterion |
|---|---|
| `SAAS-AC-001` | After a completed settlement, every `BC-05` figure for every affected student is byte-identical, and no `BC-05` table gained a row |
| `SAAS-AC-002` | All eight `SAAS-FR-015` audit facts are retrievable for any completed settlement, and discharged obligations enumerable |
| `SAAS-AC-003` | A library that consumed a trial, was deleted and recreated does not receive a second trial |
| `SAAS-AC-004` | A settlement request whose submitted amount differs from the server-derived outstanding figure is rejected server-side |
| `SAAS-AC-005` | `PR-1` cannot alter a tenant-level value; a library actor cannot alter a platform-level value; both fail closed |
| `SAAS-AC-006` | A Platform Charge rate of 3% on a ₹500 confirmed collection accrues exactly ₹15 |
| `SAAS-AC-007` | 100 confirmed ₹500 collections accrue ₹1,500 outstanding against ₹50,000 collected |
| `SAAS-AC-008` | An obligation accrued at 3% still reads ₹15 after the rate is changed to 2.5% |
| `SAAS-AC-009` | An obligation accrued after the rate becomes 2.5% uses 2.5%, and obligations either side of the change coexist with different rates |
| `SAAS-AC-010` | No accrual is produced from a pending, failed, unconfirmed or offline-recorded student payment |
| `SAAS-AC-011` | A `Pending` settlement leaves the outstanding figure unchanged |
| `SAAS-AC-012` | A `Failed` settlement leaves the outstanding figure unchanged and is not presented as settled |
| `SAAS-AC-013` | A duplicate settlement submission against the same authorised reference reduces the outstanding figure exactly once |
| `SAAS-AC-014` | A client-reported success without server verification does not transition a settlement to `Successful` |
| `SAAS-AC-015` | A library with zero online student collections can reach a completed settlement |
| `SAAS-AC-016` | No settlement path requires, reads or waits for a future online student collection |
| `SAAS-AC-017` | The outstanding figure is never negative, and cannot be set directly |
| `SAAS-AC-018` | A settlement attempt by an actor with no declared settlement authority is refused |
| `SAAS-AC-019` | A `TR-2` Manager settlement attempt is refused while `SAAS-GAP-004` is open |
| `SAAS-AC-020` | A settlement audit record cannot be modified or deleted; a correction appears as a new record referencing the original |
| `SAAS-AC-021` | No student-facing surface displays a Platform Charge, subscription or settlement figure |

---

## 14. Traceability

**Forward trace — every obligation-bearing identifier to its verifying criterion:**

| Obligation | Verified by | Note |
|---|---|---|
| `SAAS-FR-001` | `SAAS-AC-006` | |
| `SAAS-FR-002` | `SAAS-AC-010` | |
| `SAAS-FR-003` | `SAAS-AC-002`, `SAAS-AC-008` | |
| `SAAS-FR-004` | `SAAS-AC-004` | |
| `SAAS-FR-005` | `SAAS-AC-008`, `SAAS-AC-009` | |
| `SAAS-FR-006` | `SAAS-AC-007`, `SAAS-AC-017` | |
| `SAAS-FR-007` | — | ⛔ **UNTRACED** — the display set depends on `SAAS-GAP-001` eligibility |
| `SAAS-FR-008` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-FR-009` | `SAAS-AC-015` | |
| `SAAS-FR-010` | — | ⛔ **UNTRACED** — net-off is `MAY`, and `SAAS-GAP-003` governs whether the rail supports it |
| `SAAS-FR-011` | — | ⛔ **UNTRACED** — blocked on `SAAS-GAP-003` |
| `SAAS-FR-012` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-FR-013` | `SAAS-AC-014` | |
| `SAAS-FR-014` | `SAAS-AC-013` | |
| `SAAS-FR-015` | `SAAS-AC-002` | |
| `SAAS-FR-016` | `SAAS-AC-018` | |
| `SAAS-FR-017` | — | ⛔ **UNTRACED** — no range declared; blocked on `SAAS-GAP-002` |
| `SAAS-FR-018` | `SAAS-AC-003` | |
| `SAAS-BR-001` | — | ⛔ **UNTRACED** — a terminology rule; verified by review, not by test |
| `SAAS-BR-002` | `SAAS-AC-006`, `SAAS-AC-007` | |
| `SAAS-BR-003` | `SAAS-AC-008` | |
| `SAAS-BR-004` | `SAAS-AC-001` | |
| `SAAS-BR-005` | `SAAS-AC-016` | |
| `SAAS-BR-006` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-BR-007` | `SAAS-AC-019` | |
| `SAAS-BR-008` | `SAAS-AC-018` | |
| `SAAS-BR-009` | — | ⛔ **UNTRACED** — blocked on `SAAS-GAP-005` trial identity |
| `SAAS-INV-001` | `SAAS-AC-008` | |
| `SAAS-INV-002` | `SAAS-AC-008`, `SAAS-AC-009` | |
| `SAAS-INV-003` | `SAAS-AC-017` | |
| `SAAS-INV-004` | `SAAS-AC-013` | |
| `SAAS-INV-005` | `SAAS-AC-020` | |
| `SAAS-XC-001` | `SAAS-AC-001` | |
| `SAAS-XC-002` | `SAAS-AC-001` | |
| `SAAS-XC-003` | `SAAS-AC-021` | |
| `SAAS-XC-004` | `SAAS-AC-010` | |
| `SAAS-XC-005` | `SAAS-AC-018` | |
| `SAAS-XC-006` | — | ⛔ **UNTRACED** — a documentation prohibition; verified by review |
| `SAAS-XC-007` | `SAAS-AC-008` | |
| `SAAS-XC-008` | `SAAS-AC-017` | |
| `SAAS-XC-009` | `SAAS-AC-016` | |
| `SAAS-XC-010` | `SAAS-AC-001` | |
| `SAAS-XC-011` | `SAAS-AC-014` | |

**Measured coverage:**

| Register | Allocated | Traced | Untraced (all ⛔ BLOCKED or review-verified) |
|---|---|---|---|
| `SAAS-FR-*` | 18 | 14 | `SAAS-FR-007`, `SAAS-FR-010`, `SAAS-FR-011`, `SAAS-FR-017` |
| `SAAS-BR-*` | 9 | 7 | `SAAS-BR-001`, `SAAS-BR-009` |
| `SAAS-INV-*` | 5 | 5 | — |
| `SAAS-XC-*` | 11 | 10 | `SAAS-XC-006` |
| **Total** | **43** | **36** | **7 = 83.7%** |

**This does not meet the 100% bar** that `PRD-006` cleared (285/285), and it is not presented as if it might.
**Four** of the seven are blocked on named gaps; **three** (`SAAS-BR-001`, `SAAS-XC-006`, and the review half of
`SAAS-FR-007`) are prohibitions on documentation and terminology that a runtime test cannot verify. Manufacturing
criteria for those would raise the percentage without raising the assurance — the same inflation this repository has
refused before.

---

## 15. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | *(this draft)* | **First draft. Stage 2 only.** Created to give `BC-20` the PRD it has been registered for since the register was created, and to be the lawful home for three findings that terminated outside their own module: **`FEE-GAP-014`** (the platform charge has no owning document), **`FEE-GAP-017`** (a cash-only library has no lawful way to pay) and the unspecified **SaaS free trial**. **Authorisation checked before authoring, not assumed:** Master PRD **L169** §8 module 17, `PRD_REGISTRY.md` **L326** (`V1`, `PLANNED`) and **L427** (§6, `BC-20` → `PRD-022`, uncontested) — and the registry's own §4.3 note names `BC-20` **module 17** *as the precedent* it used to register `PRD-023`, so authoring this applies an established mechanism rather than a new one. **Prefix collision-checked** per `PRD_LIFECYCLE.md` §5 rule 2: `SAAS-*` measured **0** pre-existing identifiers. **Terminology decision applied:** *Platform Charge* replaces *commission* in all new text — measured **0** pre-existing occurrences of *Platform Charge*, and the financial sense of *commission* confined to **three non-frozen** documents (`PRD-008`, its alignment record, `ADR-0035`), every other occurrence in the repository being the English verb. **The transition is forward-only and no historical text was rewritten** — editing the vocabulary of a decision record destroys the ability to audit what was known when, and **no frozen document uses the financial sense at all**. **Product decisions applied:** Platform Charge default **3%** (`SAAS-FR-001`), free trial default **14 days** (`SAAS-FR-017`), historical-rate immutability (`SAAS-FR-005`, `SAAS-BR-003`, `SAAS-INV-002` — ₹15 stays ₹15 when the rate becomes 2.5%), cash-only settlement as a **first-class V1 requirement** (`SAAS-FR-009`) with net-off explicitly **not** the only mechanism (`SAAS-BR-005`), three settlement states, server-side verification only (`SAAS-FR-013`), idempotency (`SAAS-FR-014`), and eight-fact auditability (`SAAS-FR-015`). **The `MP-GBR-24` boundary is stated as mirror-image prohibitions** (`SAAS-XC-001`…`004`, `SAAS-XC-010`) so that both sides of the boundary forbid the crossing rather than only `BC-05`. **Nothing was invented:** no bounded context, no `BC-32`, no dependency edge, no port, no endpoint, no webhook schema, no signature algorithm, no retry policy, no database schema, no queue, no payment provider, no settlement rail, no bank-account structure, no UPI flow, no tax rate, no gateway charge, no permission identifier, no role, no configuration identifier and no configurable range. **The hardest finding is recorded rather than solved:** `AUTH-7.22` closes the permission catalogue, **0** `PERM-*` identifiers exist repository-wide, and `AP-9` fails closed — so a settlement is refused **for `TR-1` Owner too**, not merely for `TR-2` Manager, and `X-13` makes naming a permission here *"a security defect that passes its own tests."* **Six gaps, all six blocking Stage 4 and Freeze**, each with a named authority. **Traceability reported honestly at 36/43 = 83.7%**, below the 100% bar, with four blocked on gaps and three verifiable only by review. **Stage 3 has NOT been performed** (`SAAS-GAP-006`) and this document is **NOT frozen and NOT approved**. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no ADR was authored or accepted; no Dart source was touched. |

---

*End of `PRD-022_SAAS-BILLING.md` **v0.1 — DRAFT**. Not frozen. Not approved. Not architecture-reviewed.*
