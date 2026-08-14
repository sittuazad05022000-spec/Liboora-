# PRD-008 — REVENUE & FINANCE (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-008_REVENUE-AND-FINANCE.md` |
| **Module** | Revenue & Finance |
| **Bounded Context** | **`BC-05` Fee & Collection** |
| **Classification** | `[CORE]` — Library Management cluster |
| **Release** | **V1** |
| **Version** | **v0.1 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT frozen. NOT approved. NOT architecture-reviewed.** Status is *conferred* by admission to the baseline, never claimed by a document about itself; [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.1 still records `PRD-008` as **`PLANNED`** and **this document does not change that row**. Moving `PLANNED` → `DRAFT` is a registry act requiring the Governance Owner. |
| **Baseline** | Written **against** `BASELINE-2026-08-05-A`. **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD), the rank `PRD-004`…`PRD-007` hold |
| **Owns** | `FeeLedger` *(per student)* — BC Map §8 L374 |
| **Consumes** | `BC-06` Library Policy (`E-06`) · `BC-02` Membership (`E-07`) · `BC-01` Enrollment (`E-09`) · `BC-21` Entitlement (`E-17`) · `BC-19` Tenancy (`E-18`) · `BC-25` Configuration (`E-19`) |
| **Publishes to** | `BC-02` Membership (`E-10`) · `BC-24` Audit Trail (`E-20`) · `BC-22` Notification Delivery (`E-23`) |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ADR-0015` **Accepted** (Rank 2) · `PRD-004` v1.2 **FROZEN**, `PRD-005` v1.4 **FROZEN**, Library PRD v1.1 **FROZEN** (Rank 3) · **BC Map v1.7**, Module Dependency Matrix v1.3 (Rank 4) · Enterprise Architecture v2.1 (Rank 6, **descriptive only**) |
| **Blocking governance gaps** | **5 block Stage 4** (`FEE-GAP-001`, `002`, `004`, `005`, `006`) · **10 block Freeze** (all except `FEE-GAP-008`, `010`). Measured from §37, not asserted |
| **Recommendation** | **REQUIRES CORRECTIONS — GOVERNANCE BLOCKED on 6 gaps.** See §K of the covering report |

> ### ⚠️ Read this before treating any statement here as settled
>
> This document is a **Stage 2 draft**. It has **not** passed Stage 3 (Architecture Review) or Stage 4
> (Requirements Review). Nothing in it is approved.
>
> **Six governance gaps block progress**, and they are not stylistic. Two of them — `FEE-GAP-001` (is
> Refund V1 or V2?) and `FEE-GAP-002` (BC-05 has **no** declared architectural path to a payment
> gateway) — mean that **the online-payment and refund portions of this module cannot be specified
> without a decision from a named authority**. This draft therefore **states the conflict and stops**,
> rather than choosing a side and calling it a requirement.
>
> **Normative language.** **MUST** / **MUST NOT** = absolute obligation. **SHOULD** = strong
> recommendation, deviation requires recorded justification. **MAY** = genuinely optional.
> **⛔ BLOCKED** = cannot be specified until a gap is resolved.

---

## 0. Identifier registers — declared up front

`PRD_LIFECYCLE.md` §2 Stage 2 requires registers *"declared **up front** with ranges — publishing the ranges
as a promise"*. §5 requires prefixes checked against every existing register **before** writing.

### 0.1 Prefix collision check — performed, not assumed

| Candidate prefix | Occurrences found across `docs/` before this document | Verdict |
|---|---|---|
| `FEE-*` | **0** | ✅ **free — adopted** |

Measured by `grep -rhoE "\bFEE-[A-Z]+-[0-9]+" docs/ | sort -u | wc -l` → `0`. No collision with `MP-*`,
`AUTH-*`, `LIB-*`, `SID-*`, `SM-*`, `MM-*`, `ATT-*` or `SEAT-*`.

### 0.2 The registers

| Register | Meaning | Count | Range |
|---|---|---|---|
| `FEE-FR-*` | Functional requirement | **58** | `FEE-FR-001` … `FEE-FR-058` |
| `FEE-BR-*` | Business rule | **24** | `FEE-BR-001` … `FEE-BR-024` |
| `FEE-INV-*` | Invariant | **9** | `FEE-INV-001` … `FEE-INV-009` |
| `FEE-EVT-*` | Domain event published by `BC-05` | **3** | `FEE-EVT-001` … `FEE-EVT-003` |
| `FEE-XC-*` | Explicit exclusion — what this module MUST NOT do | **16** | `FEE-XC-001` … `FEE-XC-016` |
| `FEE-PO-*` | Port / integration obligation | **8** | `FEE-PO-001` … `FEE-PO-008` |
| `FEE-AC-*` | Acceptance criterion | **70** | `FEE-AC-001` … `FEE-AC-070` |
| `FEE-GAP-*` | Governance gap / open question — **not a requirement** | **12** | `FEE-GAP-001` … `FEE-GAP-012` |
| **Total** | | **200** | |

**Obligation-bearing** = 58 + 24 + 9 + 3 + 16 + 8 = **118**. `FEE-AC-*` are *verified by* tests and
`FEE-GAP-*` are *open questions*; neither is an obligation, exactly as `PRD-006` §0.3 treats `ATT-AC-*`
and `ATT-GAP-*`.

> **No configuration register is declared.** `PRD-006` §10A.7a refused to register a configurable for
> which *"no allowed range has been approved"*. The same restraint applies here: **no `FEE-CFG-*`
> register exists**, because no source document approves a single default, range or authority for any
> finance configurable. Creating one would be inventing configuration ranges. See `FEE-GAP-007`.

---

## 1. Document Control

| Item | Value |
|---|---|
| **Product Owner** | Product Owner — Library Domain ([`PRD_OWNERSHIP_MODEL.md`](../../00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md) L165) |
| **Architecture authority** | ARB / Architecture Owner (same row) |
| **Implementation owner** | Platform Engineering (same row) |
| **Roadmap position** | Wave **2.5**, after `PRD-005` and `PRD-004` ([`PRODUCT_IMPLEMENTATION_ROADMAP.md`](../../00-governance/prd-ecosystem/PRODUCT_IMPLEMENTATION_ROADMAP.md) L131), edges `E-07`, `E-09`, `E-10` |
| **Stage 3 status** | **NOT PERFORMED** |
| **Stage 4 status** | **NOT PERFORMED** |
| **Stage 5/6/7** | **NOT PERFORMED.** No traceability gate, no task file, no freeze |

---

## 2. Executive Summary

`BC-05` Fee & Collection owns one thing: **money owed by a student to the library**, and the record of
whether it was paid. Rank 4 states its scope in a single sentence — *"Owns money owed by a **student to
the library**: fee structures, dues, receipts, discounts, refunds, cash reconciliation"* (BC Map L100).

V1 is a **fee-collection and financial-record module**, not an accounting system. It has one aggregate,
`FeeLedger`, one balance rule, and an immutability guarantee inherited from Rank 1.

What makes this module unusual is not its features but its **prohibitions**. It is the only context
permitted to hold a monetary ledger; the frozen Membership PRD is explicitly forbidden from holding a
second one (`MM-XC-004`). Financial records may never be rewritten (`MP-GBR-12`). A student may never be
charged twice (BC Map L478). And the money a *student owes a library* may never share a model, table or
metric with the money a *library owes LIBOORA* (`MP-GBR-24`).

**This draft is blocked.** BC-05 has exactly **four** declared architectural edges, and **none of them
reaches a payment gateway, an offline queue, or the analytics read model.** Online payment, offline cash
capture and refunds therefore cannot be specified without governance decisions. Those are recorded as
gaps, not resolved by assumption.

---

## 3. Vision

A library owner in India should be able to state what a student owes, take the money in whatever form the
student actually has — cash at the desk, UPI on a phone — hand over a receipt that cannot later be
altered, and see at any moment who has paid and who has not, without those figures ever disagreeing with
each other or leaking to another library.

---

## 4. Goals

| ID | Goal | Source |
|---|---|---|
| `G-1` | One authoritative financial record per student per tenant | BC Map L374 `FeeLedger` *(per student)* |
| `G-2` | Fee obligations arise from membership facts, never invented locally | `E-07`, `MM-BR-003` |
| `G-3` | Collection at reception in the forms Indian students actually use | EA L1395–1398 Cash/UPI/Card (V1) |
| `G-4` | A receipt that is immutable once issued | `MP-GBR-12` |
| `G-5` | No student ever charged twice | BC Map L478, `MP-GBR-18` |
| `G-6` | Outstanding and overdue dues visible without a second ledger | BC Map L374 balance rule |
| `G-7` | Every financially sensitive act auditable | `E-20` |
| `G-8` | Absolute tenant isolation of financial data | `E-18`, `MP-GBR-24` |

---

## 5. Non-Goals (V1)

| ID | Not in V1 | Authority |
|---|---|---|
| `NG-1` | Expenses, Profit & Loss, Cash Flow | EA L824–826 **(V2)** |
| `NG-2` | Tax reports, GST, tax engine | EA L828–829 **(V3)** |
| `NG-3` | Financial forecasting | EA L830 **(Future)** |
| `NG-4` | Partial payments | EA L1400 **(V2)** — see §13.6 |
| `NG-5` | Split payments | EA L1401 **(V3)** |
| `NG-6` | Proration engine, dunning, credit/debit notes | EA L1415–1419 **(V2)** |
| `NG-7` | Revenue recognition | EA L1417 **(V3)** |
| `NG-8` | Cash reconciliation *as a reconciliation feature* | EA L827 **(V2)** — see §42 note in §34 |
| `NG-9` | Payment retry, multiple gateways | EA L1409–1410 **(V2/V3)** |
| `NG-10` | SaaS subscription revenue | `BC-20` owns it — `MP-GBR-24` |
| `NG-11` | A general ledger, chart of accounts, journal entries, double-entry bookkeeping | **No source document contains any of these.** Inventing them would be ERP bloat |

> **`NG-4` and `NG-8` are recorded against a Rank 6 document.** EA is *descriptive only* (`MP-CON-08`).
> Where Rank 6 disagrees with Ranks 1–4, the higher rank wins. For Partial Payments and Cash
> Reconciliation **no higher-ranked document says anything at all**, so EA's tiering is the only
> evidence available and is followed. This is recorded as `FEE-GAP-008` so that the Product Owner can
> confirm rather than inherit it silently.

---

## 6. V1 Scope

### 6.1 In scope — each traced to a source

| Capability | Source | Tier |
|---|---|---|
| Fee structures | EA L822 `Fee Structures (V1)` · BC Map L100 | V1 |
| Fee obligations (`FeeDue`) | BC Map L374 · `E-07` | V1 |
| Fee collection | EA L821 `Fee Collection (V1)` | V1 |
| Cash payment | EA L1396 · BC Map L202 *"cash/UPI collected from a student at reception"* | V1 |
| UPI payment | EA L1397 · BC Map L202 | V1 |
| Card payment | EA L1398 | V1 |
| Online payment | EA L1395 | V1 — **⛔ partly BLOCKED, `FEE-GAP-002`** |
| Payment idempotency | EA L1399 · `MP-GBR-18` · BC Map L478 | V1 |
| Payment verification | EA L1407 | V1 — **⛔ partly BLOCKED, `FEE-GAP-002`** |
| Webhook reconciliation | EA L1408 | V1 — **⛔ BLOCKED, `FEE-GAP-002`** |
| Invoice generation | EA L1413 | V1 |
| Receipt generation | EA L1414 | V1 |
| Discounts | EA L823 · BC Map L374 *"discount requires an authorised approver role"* | V1 |
| Financial history | BC Map L100 (implied by ledger) | V1 |
| Outstanding / overdue dues | BC Map L374 balance rule | V1 |
| Financial reports | EA L1424 `Financial Reports (V1)` | V1 — as **read models**, §22 |
| Refunds | **CONFLICT** — BC Map L100/L374/L422 vs EA L823 | **⛔ BLOCKED, `FEE-GAP-001`** |
| Bank transfer | **NO SOURCE** | **⛔ BLOCKED, `FEE-GAP-003`** |

### 6.2 Requested in the brief but absent from every source

The brief asks this PRD to cover **admission fee, membership fee, renewal fee, joining/registration fee,
deposit, other approved charges**, and to check whether they are *"already approved"*.

**Measured answer: none of them is named in any source document.**

```
grep -rniE "admission fee|joining fee|registration fee|security deposit|deposit" \
     docs/30-product/ docs/10-architecture/   →  0 matches
```

What the sources *do* provide is a generic mechanism: a **fee structure** (EA L822) that raises a
**`FeeDue`** (BC Map L374) from a membership price snapshot (`MM-EVT-001` `priceSnapshot`). There is no
approved taxonomy of fee *types*.

Therefore this PRD specifies a **fee-type mechanism that is open by configuration** (§10) and **does
not enumerate admission/joining/deposit as named V1 fee types**, because doing so would be inventing
requirements. Recorded as **`FEE-GAP-004`** for the Product Owner.

> **This is a scope-preservation finding, not a scope reduction.** Nothing previously approved is being
> removed — there was never an approved fee-type list to remove. §C of the covering report states this
> explicitly.

---

## 7. Domain Ownership

### 7.1 What `BC-05` owns

| Owns | Authority |
|---|---|
| Fee structures | BC Map L100 |
| Fee obligations / dues (`FeeDue`) | BC Map L374 |
| Payments (`FeePayment`) | BC Map L202 |
| Receipts (`Receipt`) | BC Map L374 |
| Discounts (`Discount`) | BC Map L374 |
| Refund records (`RefundRecord`) | BC Map L374 — *tier disputed, `FEE-GAP-001`* |
| `Money` value object | BC Map L374 |
| Outstanding financial balance (**derived, never stored**) | BC Map L374 |
| Financial history | BC Map L100 |

### 7.2 What `BC-05` MUST NOT own

| Not owned | Owner | Edge |
|---|---|---|
| Student identity, profile, enrollment | `BC-01` (`PRD-004`, FROZEN) | `E-09` |
| Membership lifecycle, plans, entitlement conferred | `BC-02` (`PRD-005`, FROZEN) | `E-07` / `E-10` |
| Attendance and presence | `BC-03` (`PRD-006`, FROZEN) | none |
| Seat allocation and occupancy | `BC-04` (`PRD-007`, FROZEN) | none |
| Holiday calendar / branch policy | `BC-06` | `E-06` |
| Tenant record and context | `BC-19` | `E-18` |
| Entitlement checks | `BC-21` | `E-17` |
| Notification channel, template, dispatch | `BC-22` | `E-23` |
| Audit store | `BC-24` | `E-20` |
| Typed configuration values | `BC-25` | `E-19` |
| Metric definitions, read models, reports | `BC-26` | **no numbered edge** — §27 |
| Gateway credentials, vendor contracts | `BC-31` via `BC-20` | **not BC-05** — `FEE-GAP-002` |
| **LIBOORA SaaS subscription revenue** | **`BC-20`** | §9.3 |

---

## 8. Bounded Context

`BC-05` Fee & Collection · `[CORE]` · Library Management cluster · V1 · BC Map L100.

Member of the **Core Library cluster** with `BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-06`. Rank 4
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) L89:
*"Only the edges `E-01`…`E-10` listed in the context map. **Enforced as an explicit allow-list, not
'anything within the cluster'**."*

Master PRD L253 explains why the cluster is not split: *"Splitting Enrollment from Membership from Fee
introduces distributed transactions across invariants that genuinely need strong consistency. **They stay
together.**"*

`FEE-BR-001` — This module **MUST NOT** create, propose or rely on any intra-cluster edge outside
`E-01`…`E-10`. *(This is the exact rule that forced `E-27`'s withdrawal under `ADR-0033`.)*

---

## 9. Architecture Boundaries

### 9.1 The four declared edges — measured, complete

```
grep -E "^\| E-[0-9]+ \|" LIBOORA_BOUNDED_CONTEXT_MAP.md | grep "BC-05"   →  4 rows
```

| Edge | Direction | Mode | Mechanism | Contract (verbatim) |
|---|---|---|---|---|
| `E-06` | `BC-06` → **`BC-05`** | `CF` | Sync port | `HolidayCalendar` for proration and freeze-day computation |
| `E-07` | `BC-02` → **`BC-05`** | `C/S` | Event | `MembershipCreated/Renewed/Upgraded/Frozen` → generates or adjusts `FeeDue` |
| `E-09` | `BC-01` → **`BC-05`** | `C/S` | Event | `StudentArchived` → Fee context asserts no outstanding dues, else blocks with a domain error |
| `E-10` | **`BC-05`** → `BC-02` | `C/S` | Event | `FeePaymentReceived` → may activate a pending membership (saga in V2, direct handler in V1) |

### 9.2 The generic capability edges — available without invention

BC Map L326–332 declare these with source *"All contexts"* or *"All write paths"*, so `BC-05` may use
them without a new numbered edge:

| Edge | Target | Use here |
|---|---|---|
| `E-17` | `BC-21` Entitlement | `check()` **before** the aggregate mutates |
| `E-18` | `BC-19` Tenancy | Ambient `TenantContext` — *"propagated, never passed as a parameter through domain methods"* |
| `E-19` | `BC-25` Configuration | Typed config accessors, *"no raw string lookups in domain code"* |
| `E-20` | `BC-24` Audit Trail | Event, *"fire-and-forget, outbox-backed"*; *"domain never calls audit synchronously"* |
| `E-23` | `BC-22` Notification | *"Domain emits **facts** … never 'send an SMS'"* |

### 9.3 `BC-05` ≠ `BC-20` — the load-bearing separation

`MP-GBR-24` (Rank 1): *"Money owed by a **student to the library** (`BC-05`) is a different concept from
money owed by a **library to LIBOORA** (`BC-20`). **They must never share a model, a table or a
metric.**"*

BC Map L202–204 makes the vocabulary collision explicit:

| Term | In `BC-05` | In `BC-20` | Distinct names |
|---|---|---|---|
| **Payment** | cash/UPI collected from a student at reception | a card charge from a library owner to LIBOORA | `FeePayment` vs `SubscriptionCharge` |
| **Plan** | (`BC-02`) a library's membership offering | LIBOORA's SaaS tier | `MembershipPlan` vs `SubscriptionPlan` |
| **Invoice** | a fee demand issued to a student | a tax invoice issued to a library | `FeeDue` vs `SubscriptionInvoice` |

`ADR-0015` (**Accepted**) exists solely because three Library PRD rows collapsed these two contexts into
one citation; it records that *"a single citation collapsing both into one range is therefore not merely
wrong, it **erases a distinction the map treats as load-bearing**."*

`FEE-BR-002` — `BC-05` **MUST** name its aggregate members `FeePayment`, `FeeDue` and `Receipt`. It
**MUST NOT** use the bare terms `Payment`, `Plan` or `Invoice` as storage or API identifiers.
`FEE-BR-003` — No table, model, projection or metric **MAY** contain both `BC-05` and `BC-20` money.
`FEE-XC-001` — Reading, writing or aggregating `BC-20` subscription revenue.
`FEE-XC-002` — Reporting a figure named "revenue" that mixes student fees and SaaS revenue
(`MP-SM-06` requires every revenue metric to state which it means).

---

## 10. Fee Structure

A **Fee Structure** is the library's definition of *what a thing costs*. It is a **template**, not a debt.

`FEE-FR-001` — A tenant **MUST** be able to define one or more fee structures.
`FEE-FR-002` — A fee structure **MUST** carry: a tenant scope, a name, a `Money` amount, a currency, an
active flag, and effective dating.
`FEE-FR-003` — A fee structure **MUST** be scoped to exactly one tenant (`E-18`).
`FEE-FR-004` — Creating, amending, activating or deactivating a fee structure **MUST** emit an audit fact
via `E-20`.
`FEE-FR-005` — A fee structure **MUST** be effective-dated. `BC-06` propagates policy change by
`policy.BranchPolicyChanged` with the note *"**effective-dated rule propagation**"* (BC Map L423), so
effective dating is the architecture's stated mechanism, not a preference.
`FEE-FR-006` — Fee-type classification **MUST** be a configurable value obtained through `E-19`, not a
hard-coded enumeration. *(Because no source approves a fee-type list — §6.2, `FEE-GAP-004`.)*

`FEE-BR-004` — A fee structure **MUST NOT** be a financial record. It creates no debt and appears in no
balance.
`FEE-INV-001` — A fee structure amount **MUST** be a non-negative `Money` in the tenant's currency.

### 10.1 Fee structure change after an obligation exists — the mutation rule

The brief asks this to be decided explicitly. It **is** decidable from Rank 1 and Rank 3 without invention.

| Evidence | Statement |
|---|---|
| `MP-GBR-12` (Rank 1) | *"Financial records are immutable."* |
| `MM-FR-027` (Rank 3, FROZEN) | *"makes the **price snapshot immutable**"* (`PRD-005` L695) |
| `MM-EVT-001` payload (Rank 3, FROZEN) | carries `priceSnapshot` — the amount is **captured at the event**, not looked up later |

`FEE-BR-005` — **A fee structure change MUST NOT alter any existing `FeeDue`.** An obligation is created
from a **snapshot** of the amount at the moment it arises and is thereafter immutable.
`FEE-BR-006` — A fee structure change **MUST** apply only to obligations raised **after** its effective
date.
`FEE-INV-002` — For any `FeeDue`, the amount **MUST** equal the snapshot taken at creation, for the whole
life of the obligation.

> **Why this is not a guess.** The frozen Membership PRD already makes the price snapshot immutable and
> already ships that snapshot inside the very event (`E-07`) that causes a `FeeDue`. A mutable
> obligation would contradict a frozen Rank 3 requirement *and* `MP-GBR-12`. There is no ambiguity to
> defer here — so no gap is raised for the **rule**. A gap **is** raised for the *correction* path a
> library needs when a genuine pricing mistake was made: see `FEE-GAP-005`.

---

## 11. Fee Obligations

A **Fee Obligation** (`FeeDue`) is *what a specific student owes*. It is a financial record.

`FEE-FR-007` — A `FeeDue` **MUST** be raised on receipt of `membership.MembershipCreated`,
`MembershipRenewed`, `MembershipUpgraded` or `MembershipFrozen` via `E-07`.
`FEE-FR-008` — A `FeeDue` **MUST** carry: `StudentRecordId` reference, tenant, `Money` amount snapshot,
currency, a due date, a status (§29.1), and the originating event reference.
`FEE-FR-009` — A `FeeDue` **MUST** be idempotent on the originating `eventId`. BC Map L449: *"Delivery:
At-least-once. Therefore **every consumer must be idempotent** — keyed on `eventId`."*
`FEE-FR-010` — On `membership.MembershipUpgraded`, dues **MUST** be **adjusted** using
`priceDifference` from the event payload, which `PRD-005` `MM-EVT-004` already supplies.
`FEE-FR-011` — This module **MUST NOT** create a `FeeDue` from its own initiative for a membership
event it did not receive. `MM-BR-003`: *"It **MUST NOT** create the `FeeDue` itself"* is the mirror
obligation on `BC-02`; the pair means `FeeDue` creation is **caused by** `E-07` and **performed by**
`BC-05`.
`FEE-FR-012` — Manual creation of a `FeeDue` by an authorised staff role **MAY** be supported for
charges that arise outside a membership event, and if supported **MUST** be audited with actor and
reason via `E-20`. **⛔ Scope of "other approved charges" is `FEE-GAP-004`.**

`FEE-XC-003` — Deriving a fee obligation from attendance, presence or seat occupancy.
`FEE-INV-003` — A `FeeDue` **MUST** belong to exactly one tenant and one student record.

### 11.1 Due dates

`FEE-FR-013` — A `FeeDue` **MUST** carry a due date.
`FEE-FR-014` — Due-date computation **MUST** consult `BC-06`'s `HolidayCalendar` through `E-06`, whose
declared purpose is *"proration and freeze-day computation"*.
`FEE-BR-007` — The due-date **rule** (offset, grace, calendar arithmetic) is **not specified in any
source document** and **MUST NOT** be invented here. See **`FEE-GAP-006`**.

> `PRD-006` set the precedent: it refused to invent the periodic-check interval and wrote *"Do not
> invent the periodic-check interval"* rather than pick a plausible number.

### 11.2 Enrollment archival interaction

`FEE-FR-015` — On `StudentArchived` via `E-09`, this module **MUST** assert that the student has no
outstanding dues, and **MUST** block the archival with a **domain error** if any remain. This is the
verbatim `E-09` contract.
`FEE-INV-004` — A student **MUST NOT** be archivable while `outstanding balance > 0`.

---

## 12. Invoices

`FEE-FR-016` — An invoice **MUST** represent a **demand for payment issued to a student**. BC Map L204
names this concept `FeeDue` in `BC-05`.
`FEE-FR-017` — An invoice **MUST** be immutable once issued (`MP-GBR-12`).
`FEE-FR-018` — Cancelling an invoice **MUST** be recorded as a state transition (§29.3), never as a
deletion.
`FEE-BR-008` — **Invoice ≠ Payment.** An issued invoice moves no money and **MUST NOT** change the
ledger balance except as a due.

> **Terminology caution, recorded rather than resolved.** BC Map L204 treats *"Invoice"* in `BC-05` as
> **`FeeDue`** — i.e. the demand *is* the obligation. EA L1413 lists *"Invoice Generation (V1)"* as a
> separate capability from receipts. This draft treats the invoice as the **issued representation of a
> `FeeDue`** and does **not** create a second aggregate, because BC Map §8 L374 lists exactly five
> members of `FeeLedger` and *"Invoice"* is **not** among them. Recorded as **`FEE-GAP-009`**.

---

## 13. Payments

A **Payment** (`FeePayment`) is *money actually received*.

`FEE-FR-019` — A payment **MUST** carry: tenant, `StudentRecordId` reference, `Money` amount, currency,
method, an idempotency key, a status (§29.2), the recording actor, and a timestamp.
`FEE-FR-020` — A payment **MUST** be linked to the obligation(s) it settles.
`FEE-FR-021` — A payment **MUST NOT** be editable after it reaches a confirmed state (`MP-GBR-12`).
`FEE-BR-009` — **Payment ≠ Receipt.** The payment is the money event; the receipt is the issued proof
(§16).

### 13.1 Cash

`FEE-FR-022` — Cash payment **MUST** be recordable by an authorised staff role at reception (BC Map L202).
`FEE-FR-023` — A cash payment **MUST** record the collecting actor identity.
`FEE-BR-010` — A cash payment is **verified at the moment of recording** — there is no external
authority to confirm it. Its trustworthiness rests on the actor identity and the audit record, not on a
verification callback.

### 13.2 UPI

`FEE-FR-024` — UPI payment **MUST** be supported (EA L1397, BC Map L202).
`FEE-BR-011` — Where UPI is collected **out of band** (student pays to a library UPI handle and staff
records it), the record is a **staff-attested** payment and **MUST** be treated as `FEE-BR-010` does for
cash, including the actor identity and audit fact. Where UPI is collected **through the platform**, it is
an online payment and §14 applies. **⛔ Which of the two V1 supports is `FEE-GAP-002`.**

### 13.3 Card

`FEE-FR-025` — Card payment **MUST** be supported (EA L1398).
`FEE-BR-012` — A card payment executed through a gateway is an online payment; §14 applies.
**⛔ `FEE-GAP-002`.**

### 13.4 Bank transfer

**⛔ BLOCKED.** Bank transfer is named in **no** source document — not the BC Map, not the Master PRD,
not the EA capability tree, not any frozen PRD. The brief lists it among features to check as *"already
approved"*; measurement says it is **not**. Specifying it would be inventing a requirement.
Recorded as **`FEE-GAP-003`**.

### 13.5 Online payment

See §14 and §15. **⛔ partly BLOCKED by `FEE-GAP-002`.**

### 13.6 Partial payments — V2, and therefore absent

EA L1400 tiers *"Partial Payments"* at **(V2)**. No higher-ranked document mentions them at all.

`FEE-XC-004` — Accepting, modelling, storing or displaying a partial settlement of a `FeeDue` in V1.
`FEE-BR-013` — In V1 a `FeeDue` is settled **in full or not at all**. There is **no** `PARTIALLY_PAID`
status, and §29.1 deliberately does not contain one.

> The brief instructs: *"If Partial Payment is V2, do NOT create V1 partial-payment semantics."* That is
> exactly what is done. Note the consequence, stated plainly rather than hidden: **a library that takes
> ₹500 against a ₹2000 due has no V1-legal way to record it.** That is a real product limitation
> flowing from a Rank 6 tiering; it is surfaced in `FEE-GAP-008` so the Product Owner can decide with
> full sight of the cost.

---

## 14. Payment Verification

`FEE-FR-026` — A payment **MUST NOT** be treated as financially successful on the strength of a
client-side success signal alone.
`FEE-BR-014` — Client-side success is a **hint**, never a financial fact. The authoritative confirmation
**MUST** come from the payment rails.
`FEE-FR-027` — Until confirmation arrives, a payment **MUST** remain in `PENDING` (§29.2) and **MUST NOT**
settle a `FeeDue`, generate a receipt, or emit `FEE-EVT-002`.

`FEE-BR-015` — A **visible reconciliation queue MUST exist** for payments whose rail state and ledger
state disagree. This is not invention: BC Map L465 mandates for the V1 fee/membership flow *"a **visible
reconciliation queue for failures** — deliberately not hidden behind a fake atomic button"*, and frozen
`MM-BR-004` requires the same queue on the membership side.

### 14.1 ⛔ Webhook / gateway reconciliation — BLOCKED

EA L1408 lists *"Webhook Reconciliation (V1)"*. **But the architecture gives `BC-05` no path to a
gateway.** Measured:

| Fact | Measurement |
|---|---|
| `E-25` Integration edge | `BC-20` Billing → `BC-31` Integration — **source is `BC-20`, not `BC-05`** (BC Map L334) |
| Edges from `BC-05` to `BC-31` | **0** |
| `D-14` in `PRD_DEPENDENCY_GRAPH.md` L116 | *"`PRD-008`/`PRD-020` → `PRD-019` `BC-31` Integration, `API`, **`E-25`**"* — asserts `PRD-008` uses `E-25` |
| Rank 4 Dependency Matrix L167 | `LIBRARY MANAGEMENT → INTEGRATION` = **`✖`** — *"The domain must not know that Razorpay … exist. Integration is reached only via BUSINESS (payments) or COMMUNICATION"* |
| Rank 4 violation `X-03` L352 | *"Just call Razorpay from the payment service"* → *"Call `business.payment_intent` port"* |

So: a Rank 5-adjacent governance document (`D-14`) claims an edge that the **Rank 4 BC Map assigns to a
different context**, while the **Rank 4 Dependency Matrix forbids the direct route entirely** and names
the correct one — a **`business.payment_intent` port through BUSINESS**. No numbered edge for that
port from `BC-05` exists in BC Map §7.

`FEE-PO-001` — Online payment execution **MUST** be reached through a port to the Business Platform, and
**MUST NOT** call a gateway or hold a gateway credential.
`FEE-XC-005` — Holding, reading or transmitting a payment-gateway credential.
`FEE-XC-006` — Naming a payment vendor in domain code, an event payload, a table or an API contract.
`FEE-FR-028` — **⛔ BLOCKED.** The webhook/reconciliation contract cannot be specified until
`FEE-GAP-002` is resolved by the **Architecture Owner**.

> **No webhook schema, no provider contract and no endpoint is written in this document**, because the
> brief forbids inventing them and no source supplies them. EA L1405 names *"Razorpay (V1)"* — but only
> inside the **BUSINESS PLATFORM** capability tree, and Master PRD L232 records Payments as *"`BC-20` via
> `BC-31`"* with the gateway *"**Not named in EA** — candidate only"*. Two Rank 6/Rank 1 statements
> disagree about whether a vendor is chosen. `FEE-GAP-010` records it; this PRD names no vendor.

---

## 15. Payment Idempotency

This is one of the few areas where the sources are complete and unambiguous.

| Authority | Statement |
|---|---|
| `MP-GBR-18` (Rank 1) | *"Payment capture is **idempotent by gateway reference**."* |
| BC Map L478 (Rank 4) | Risk *"Duplicate payment capture"* — *"**Charging a student twice is unrecoverable trust damage**"* → control: *"**Idempotency key at API edge + gateway reference uniqueness + reconciliation job**"* |
| `MP-RSK-04` (Rank 1) | *"DB constraints, pessimistic locks, idempotency keys, reconciliation"* |
| `MM-BR-005` (Rank 3, FROZEN) | *"Duplicate payment capture protection **MUST** rely on the gateway reference uniqueness and idempotency key … **Enforcement of the payment side is `BC-05`'s**"* |

`FEE-FR-029` — Every payment-recording operation **MUST** accept an idempotency key at the API edge.
`FEE-FR-030` — A repeated request with the same idempotency key **MUST** return the original result and
**MUST NOT** create a second payment, a second receipt or a second `FEE-EVT-002`.
`FEE-FR-031` — For rail-executed payments, the **gateway reference MUST be unique** and enforced as such.
`FEE-FR-032` — A reconciliation job **MUST** exist to detect and surface duplicate or orphaned captures.
`FEE-INV-005` — For a given tenant, **no two confirmed payments MAY share an idempotency key**; and no
two **MAY** share a gateway reference.
`FEE-BR-016` — Enforcement of payment-side duplicate protection is **this module's responsibility**, as
frozen `MM-BR-005` explicitly assigns it here.

---

## 16. Receipts

`FEE-FR-033` — A receipt **MUST** be generated for a confirmed payment (EA L1414).
`FEE-FR-034` — A receipt **MUST** be **immutable once issued**. This is `MP-GBR-12` *and* the BC Map
`FeeLedger` invariant *"receipt is immutable once issued"* — stated twice, at Rank 1 and Rank 4.
`FEE-FR-035` — A receipt **MUST** identify: tenant, student record, amount, currency, method, payment
reference, issue timestamp, and issuing actor.
`FEE-FR-036` — A receipt **MUST NOT** be issued for a `PENDING` payment.
`FEE-FR-037` — Correction of an issued receipt **MUST** be effected by a **compensating record**, never
by editing or deleting (`MP-GBR-12`).
`FEE-INV-006` — A receipt, once issued, **MUST NOT** change in any field, ever.
`FEE-XC-007` — Updating or deleting an issued receipt.

### 16.1 Receipt states

Per the brief: *"define only states supported by authoritative sources."* The sources support exactly one
positive state and no lifecycle beyond it — see §29.4.

---

## 17. Discounts

`FEE-FR-038` — A discount **MUST** be applicable to a `FeeDue` before settlement.
`FEE-FR-039` — A discount **MUST** require an **authorised approver role**. BC Map L374 states it as a
`FeeLedger` invariant: *"discount requires an authorised approver role"*.
`FEE-FR-040` — A discount **MUST** record: the approver identity, the reason, the original amount, the
discount amount, and the resulting payable.
`FEE-FR-041` — Applying a discount **MUST** emit an audit fact via `E-20`.
`FEE-INV-007` — A discount **MUST NOT** exceed the original amount, and the final payable **MUST NOT**
be negative.

### 17.1 The discount arithmetic — stated, not invented

```
Original Amount  −  Discount  =  Final Payable  →  Payment settles Final Payable
```

`FEE-BR-017` — The discount **MUST NOT** mutate the original `FeeDue` amount. The original amount, the
discount and the payable **MUST** all remain independently visible, because `MP-GBR-12` forbids rewriting
a financial record and an audit trail that cannot show *what changed* is not an audit trail.

`FEE-BR-018` — **No maximum discount percentage, ceiling or range is specified**, because no source
document approves one. Inventing one is explicitly forbidden by the brief and by the `PRD-006`
precedent. The **authorised approver role** is the control the architecture actually names. Recorded as
**`FEE-GAP-007`**.

---

## 18. Refunds / Corrections

### 18.1 ⛔ Refund tier — BLOCKED, `FEE-GAP-001`

**The sources conflict, and this PRD does not choose.**

| Rank | Document | Line | Says |
|---|---|---|---|
| **1** | Master PRD `MP-GBR-12` | L353 | *"a refund is a **compensating entry, never a mutation**"* — defines refund semantics as a **global rule** |
| **4** | BC Map — context | L100 | `BC-05` *"Owns … refunds"*, in a row whose Release column reads **V1** |
| **4** | BC Map — aggregate | L374 | `FeeLedger` members include **`RefundRecord`**; invariant *"**refund ≤ received**"* |
| **4** | BC Map — events | L422 | `BC-05` publishes **`fee.RefundIssued`** → `BC-26`, `BC-24` |
| **3** | `PRD-005` FROZEN | L942 | *"surfaced in the reconciliation queue **for a refund decision by `BC-05`**"* — a frozen PRD depends on BC-05 making refund decisions |
| **6** | EA capability tree | L823 | **`Refunds (V2)`** |
| **6** | EA capability tree | L1409 | **`Refund Management (V2)`** |

**Impact if resolved as V1:** three requirements and a state transition must be written, plus
`FEE-EVT-003`.
**Impact if resolved as V2:** `fee.RefundIssued` must be marked V2 in the BC Map's own event table, and
frozen `PRD-005` L942's expectation of *"a refund decision by `BC-05`"* has **no V1 counterpart** —
which is a cross-PRD hole, not a tidy deferral.

**Authority required: Product Owner (tier) + Architecture Owner (BC Map event table).** Blocks Stage 4.
Blocks Freeze.

Accordingly:

`FEE-FR-042` — **⛔ BLOCKED.** Refund behaviour is not specified pending `FEE-GAP-001`.
`FEE-BR-019` — **If** refunds are V1, a refund **MUST** be a **compensating entry, never a mutation**
(`MP-GBR-12`), and **MUST NOT** exceed the amount received (`refund ≤ received`, BC Map L374). *This rule
is stated conditionally so that no reader mistakes it for an approved V1 obligation.*
`FEE-XC-008` — Implementing refund as an edit or deletion of a payment or receipt, under any tier.

### 18.2 Corrections and adjustments

`FEE-FR-043` — A correction to a financial record **MUST** be an **append-only compensating record**
carrying actor, timestamp and reason.
`FEE-FR-044` — A correction **MUST NOT** alter or remove the record it corrects.
`FEE-BR-020` — The correction model is the one the architecture already uses: `BC-03`'s aggregate row
(BC Map L372) specifies *"corrections are append-only with actor + reason"*, and `MP-GBR-12` forbids
in-place edits — its own changelog notes that v1.0's *"except through approved workflows"* was *"a
loophole that permits in-place edits"* and was **removed**.
`FEE-INV-008` — The financial history of a student **MUST** be append-only.

> **A pricing-mistake correction path is NOT specified.** §10.1 makes obligations immutable; a library
> that entered ₹2000 instead of ₹1200 needs *some* legal route. Cancel-and-reissue is the obvious
> candidate but **no source document authorises it**, so it is recorded as **`FEE-GAP-005`** rather than
> invented.

---

## 19. Student Financial Profile

`FEE-FR-045` — A student's financial profile **MUST** be composed at read time from the `FeeLedger`.
`FEE-FR-046` — It **MUST** expose: obligations with status, payments with status, receipts, discounts,
and the derived outstanding balance.
`FEE-BR-021` — The profile **MUST NOT** be a stored aggregate of balances. BC Map L374: the balance is
*"**never stored independently**"*.
`FEE-XC-009` — Storing a materialised per-student balance as authoritative state.
`FEE-XC-010` — Holding student identity attributes. Identity is `BC-01`'s (`PRD-004`, FROZEN); this
module holds a **`StudentRecordId` reference only**, the same discipline `PRD-006` §19 applies.

---

## 20. Outstanding Dues

`FEE-FR-047` — Outstanding balance **MUST** be **derived** as `Σ dues − Σ receipts`.
`FEE-INV-009` — `balance = Σ dues − Σ receipts`, and it **MUST NOT** be stored independently. *(BC Map
L374, verbatim; also the reason `MM-XC-004` forbids `BC-02` from holding a second ledger.)*
`FEE-FR-048` — Overdue **MUST** be determined by comparing a `DUE` obligation's due date to the current
date — a **predicate over recorded facts**, not a stored flag written by a timer.
`FEE-BR-022` — No scheduled job **MAY** be the authority for overdue status. *(This mirrors the frozen
`PRD-006` §10A.4 discipline: *"**No server timer implements this rule**"* — the state is a predicate over
observations. Applying the same principle here keeps the ledger recomputable.)*

> Whether `OVERDUE` is additionally **persisted** as a status value for query performance is an
> implementation choice; §29.1 lists it as a status because the brief names it, and `FEE-FR-048` fixes
> its **meaning** as derived. If persistence is chosen it **MUST** be recomputable and **MUST NOT**
> disagree with the predicate.

---

## 21. Financial History

`FEE-FR-049` — A complete, append-only financial history **MUST** be available per student per tenant.
`FEE-FR-050` — History **MUST** show obligations, payments, receipts, discounts and corrections with
actor and timestamp.
`FEE-FR-051` — History **MUST NOT** be editable or deletable.
`FEE-XC-011` — Purging or rewriting financial history. **Retention is not defined by any source
document** and **MUST NOT** be invented — recorded as **`FEE-GAP-011`**.

---

## 22. Revenue Dashboard / Reports

`FEE-FR-052` — `BC-05` **MUST** expose financial **facts**. It **MUST NOT** own metric definitions.
`FEE-BR-023` — `MP-GBR-36` (Rank 1): *"**No dashboard may define its own metric formula.** All metrics
come from the Metric (Semantic) Layer as Certified Metrics."* `BC-26` owns *"the metric/semantic layer,
read-model store, projections, reports, exports"* (BC Map L135).
`FEE-XC-012` — Defining, computing or publishing a certified metric.
`FEE-XC-013` — Building a reporting store inside `BC-05`.

### 22.1 The V1 reports the brief asks about — and where each belongs

| Report | Facts owned by `BC-05` | Metric/read model |
|---|---|---|
| Today's collection | payments with timestamps | `BC-26` |
| Date-range collection | payments with timestamps | `BC-26` |
| Collection by payment method | payment `method` field | `BC-26` |
| Collection by fee type | obligation fee-type value | `BC-26` |
| Outstanding dues | dues − receipts (derived) | `BC-26` |
| Overdue dues | due-date predicate | `BC-26` |
| Student financial history | **`BC-05` — owned directly** (§21) | not a metric |

`FEE-BR-024` — Any report named "revenue" **MUST** state whether it means `BC-05` student fees or
`BC-20` SaaS revenue (`MP-SM-06`, `MP-GBR-24`).

> **`Financial Reports` is tiered twice in EA and the two disagree** — L814 `Financial Reports (V2)`
> under Dashboards, L1424 `Financial Reports (V1)` under Business Platform. This draft claims **no
> report as a V1 deliverable of `BC-05`**; it delivers **facts**. The tier conflict belongs to whoever
> owns the dashboard, and is recorded as **`FEE-GAP-012`**.

---

## 23. Roles & Permissions

The role vocabulary is **fixed** by Master PRD §6 L105–111 and **MUST NOT** be extended
(`ATT-FR-118` set this precedent for `BC-03`).

| Role | Enum | Master PRD description (verbatim, L107–111) |
|---|---|---|
| Library Owner | `owner` | *"Complete business control."* |
| Manager | `manager` | *"Daily operations management."* |
| Reception Staff | `reception` | *"Student onboarding, attendance, memberships, seat allocation and support."* |
| Student | `student` | *"Attendance, membership, profile, AI assistant, notifications and self-service."* |
| Parent | `parent` | *"Attendance visibility, **fee updates** and important notifications."* |

### 23.1 Financial permissions — least privilege

| Operation | Role(s) | Basis |
|---|---|---|
| Define / amend fee structure | `owner` | *"Complete business control"*; pricing is a business act |
| Approve discount | `owner` — **⛔ whether `manager` also, `FEE-GAP-007`** | BC Map L374 *"authorised approver role"* |
| Record cash / UPI / card payment at desk | `reception`, `manager` | Reception's stated duties incl. memberships and support |
| Issue receipt | `reception`, `manager` | Follows from recording |
| Record correction / adjustment | `owner`, `manager` — **⛔ `FEE-GAP-005`** | Correction is a supervisory act |
| Refund decision | **⛔ BLOCKED — `FEE-GAP-001`** | `PRD-005` L942 assigns the *decision* to `BC-05` |
| View own financial history | `student` (self only) | *"self-service"* |
| View guarded student's fee updates | `parent` (scoped to guarded students) | L111 verbatim, incl. *"fee updates"* |
| View tenant financial facts | `owner`, `manager` | Operations |

`FEE-FR-053` — Every financial write **MUST** be authorised against the acting role **and** tenant scope.
`FEE-FR-054` — A `student` **MUST NOT** be able to record, confirm, discount, correct or refund any
payment. Self-service is **read**, plus initiating an online payment **if** `FEE-GAP-002` permits one.
`FEE-FR-055` — A `parent`'s access **MUST** be limited to **fee updates for guarded students only**, per
`guardianOf` scoping.
`FEE-XC-014` — Creating any new role, or granting a financial capability by dashboard visibility.

> **Dashboard access ≠ financial permission**, as the brief requires. Master PRD L113 states RBAC is
> *"extended with attribute-based scoping"*; visibility of a screen confers nothing.

---

## 24. Audit

`FEE-FR-056` — Financially sensitive acts **MUST** emit an audit fact via `E-20` — *"Event
(fire-and-forget, outbox-backed)"*, and *"Domain never calls audit synchronously"* (BC Map L329).

Auditable acts: fee-structure create/amend/activate/deactivate · obligation raise/adjust/cancel ·
discount approval · payment record · payment confirmation · payment failure · receipt issue · correction ·
refund *(if V1)* · any permission-sensitive financial action.

`FEE-PO-002` — `E-20` to `BC-24`. `BC-05` **MUST NOT** hold an audit store.
`FEE-XC-015` — Storing audit records locally, or making an audit write synchronous or blocking.

> `PRD_DEPENDENCY_GRAPH.md` L109 records `D-09` as **Unsatisfied** with *"`X-10` audit-mutation check
> **not implemented**"*. So audit obligations here are **specified but not yet enforceable** — stated
> rather than assumed, per `SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet."*

---

## 25. Security & Tenant Isolation

`FEE-FR-057` — Every financial record **MUST** carry `tenantId`, obtained from ambient `TenantContext`
via `E-18` — *"propagated, never passed as a parameter through domain methods"* (BC Map L327).
`FEE-INV-003` *(restated)* — one tenant, one student record, per obligation.
`FEE-FR-058` — A query, projection, export or report **MUST NOT** return financial data across tenants.
`FEE-PO-003` — `E-18` ambient tenancy. A consumer processing an event *"without establishing tenant
context must **fail loudly, not default**"* (BC Map L451).
`FEE-XC-016` — Any cross-tenant financial read, write, aggregate or export.

**No cryptographic implementation detail is specified** — no algorithm, key length, token format or
hashing scheme — because no source document supplies one for this context and the brief forbids
inventing them.

---

## 26. Notifications

`FEE-PO-004` — `E-23` to `BC-22`: *"Domain emits **facts** … never 'send an SMS'"*.

Financial facts available for consumption, **each traced to the BC Map's own event table**:

| ID | Fact | Event | BC Map consumers (L420–422) |
|---|---|---|---|
| `FEE-EVT-001` | A due was raised | `fee.FeeDueRaised` | `BC-22`, `BC-26`, `BC-28` — *"Reminder + revenue analytics"* |
| `FEE-EVT-002` | A payment was received | `fee.FeePaymentReceived` | `BC-02`, `BC-26`, `BC-24`, `BC-22` |
| `FEE-EVT-003` | A refund was issued | `fee.RefundIssued` | `BC-26`, `BC-24` — **⛔ tier disputed, `FEE-GAP-001`** |

The three events are **normative register entries**, not prose:

`FEE-EVT-001` — `BC-05` **MUST** publish `fee.FeeDueRaised` when an obligation is created, through the
transactional outbox (`FEE-PO-008`), carrying tenant, student reference, amount and due date. Verified by
`FEE-AC-062`, `FEE-AC-065`.

`FEE-EVT-002` — `BC-05` **MUST** publish `fee.FeePaymentReceived` **only** when a payment reaches
`CONFIRMED` (§29.2). It **MUST NOT** be published for a `PENDING` payment (`FEE-AC-034`) and **MUST NOT**
be published twice for one idempotency key (`FEE-AC-039`). This is the event `E-10` carries to `BC-02`.
Verified by `FEE-AC-034`, `FEE-AC-039`, `FEE-AC-062`.

`FEE-EVT-003` — **⛔ BLOCKED.** `fee.RefundIssued` appears in the BC Map's `BC-05` row (L422), but its
release tier is disputed (`FEE-GAP-001`). Its payload is **not** specified here. Verified by
`FEE-AC-062` only (the count constraint), deliberately not by a behavioural criterion.

`FEE-BR-025`*(reserved — see note)* — **not allocated.** *Due reminder* and *overdue* notifications, and
a *payment failed* notification, are **not** backed by any event in the BC Map's `BC-05` row. The brief
lists them as candidates *"only if supported by authoritative sources"*; they are **not**. No fourth,
fifth or sixth `fee.*` event is created here.

> **Exactly three `fee.*` events exist.** This mirrors the frozen `PRD-006` discipline of *"exactly four
> attendance events … no fifth event"*. A *"payment failed"* notification would require a new event and
> therefore an ADR and a BC Map amendment — neither exists.

`FEE-XC-017`*(reserved — not allocated; §32 register closes at `FEE-XC-016`)*

---

## 27. Analytics Boundary

`FEE-PO-005` — Analytics consumes `fee.*` events. **There is no numbered edge from `BC-05` to `BC-26`** —
measured: `grep "^| E-[0-9]* |" | grep BC-26` returns only `E-26` (`BC-27` AI → `BC-26`).

`BC-26` appears as a **consumer** in BC Map §9's event table (L420–422) but has no `E-*` edge from
`BC-05` in §7. Frozen `PRD-005` hit exactly this and refused to paper over it: its header says
*"**`BC-26` Analytics is deliberately not listed**; see `MM-BR-035` and `MM-GAP-010`"*.

This PRD follows that precedent: `BC-26` is **not** listed in the *Publishes to* header row, and the
tension is recorded as part of **`FEE-GAP-012`** for the Architecture Owner. No edge is invented.

---

## 28. Offline / Reliability

### 28.1 ⛔ Offline financial write — BLOCKED, `FEE-GAP-002`(b)

| Fact | Measurement |
|---|---|
| `E-24` Offline Sync edge | **`BC-03` Attendance** → `BC-30` (BC Map L333) — *"Attendance defines the conflict-resolution policy; Sync executes it"* |
| Edges from `BC-05` to `BC-30` | **0** |
| `D-13` dependency row | `PRD-006` → `PRD-018` `BC-30`, *"Both unwritten"* |

`BC-05` has **no declared offline write path**. The brief is explicit: *"Do NOT invent an offline
financial write strategy."*

`FEE-FR-059`*(not allocated — register closes at `FEE-FR-058`)*
`FEE-BR-026`*(not allocated — register closes at `FEE-BR-024`)*

Instead, two obligations that need **no** new architecture:

`FEE-PO-006` — Online payment **MUST NOT** be treated as successful because the device is offline or the
confirmation could not be fetched. Absence of confirmation is **not** confirmation. *(This is the direct
analogue of frozen `PRD-006`'s rule that absence of observation is never evidence of an exit.)*
`FEE-PO-007` — Where a payment's outcome is unknown, it **MUST** remain `PENDING` and **MUST** appear in
the reconciliation queue (`FEE-BR-015`).

**Offline cash collection is recorded as an open gap, routed to the Architecture Owner** — the brief's
instruction for precisely this case.

---

## 29. Financial State Machines

Canonical. Each state is listed **only** where a source supports it.

### 29.1 `FeeDue` (Fee Obligation)

| State | Meaning | Entered from | Source |
|---|---|---|---|
| `DUE` | Owed, not yet past due date | creation via `E-07` | Brief; BC Map `FeeDue` |
| `OVERDUE` | `DUE` and due date has passed | `DUE` | Brief; derived per `FEE-FR-048` |
| `PAID` | Settled in full | `DUE`, `OVERDUE` | Brief; balance rule |
| `CANCELLED` | Withdrawn without payment | `DUE`, `OVERDUE` | Brief |

**Transitions:** `DUE → OVERDUE` (date predicate) · `DUE → PAID` · `OVERDUE → PAID` · `DUE → CANCELLED` ·
`OVERDUE → CANCELLED`.
**Forbidden:** `PAID → DUE` · `PAID → OVERDUE` · `PAID → CANCELLED` · `CANCELLED → *` · any transition
that rewrites the amount (`FEE-INV-002`).
**No `PARTIALLY_PAID` state exists** (§13.6).

### 29.2 `FeePayment`

| State | Meaning | Source |
|---|---|---|
| `PENDING` | Recorded, not yet financially confirmed | Brief; `FEE-FR-027` |
| `CONFIRMED` | Financially authoritative | Brief |
| `FAILED` | Rail or process declined it | Brief |
| `CANCELLED` | Abandoned before confirmation | Brief |

**Transitions:** `PENDING → CONFIRMED` · `PENDING → FAILED` · `PENDING → CANCELLED`.
**Forbidden:** `CONFIRMED → *` (immutability, `MP-GBR-12`) · `FAILED → CONFIRMED` (a new payment is
required) · any edit of a `CONFIRMED` payment.
**Cash note:** a cash payment enters `CONFIRMED` directly at recording (`FEE-BR-010`); it has no external
rail to wait for.

### 29.3 Invoice

| State | Meaning | Source |
|---|---|---|
| `ISSUED` | Demand issued to the student | Brief; EA L1413 |
| `PAID` | Settled | Brief |
| `CANCELLED` | Withdrawn | Brief; `FEE-FR-018` |

**Forbidden:** editing an `ISSUED` invoice; deleting any invoice; `PAID → ISSUED`.
*(See §12's note: the invoice is the issued representation of a `FeeDue`, not a sixth `FeeLedger` member —
`FEE-GAP-009`.)*

### 29.4 Receipt — deliberately minimal

| State | Meaning | Source |
|---|---|---|
| `ISSUED` | Proof of a confirmed payment exists | EA L1414; `MP-GBR-12` |

**There is no second receipt state.** No source document defines a receipt lifecycle, and
`MP-GBR-12` plus BC Map L374 make a receipt *immutable once issued* — a `VOID` or `CANCELLED` receipt
state would contradict both. A wrongly issued receipt is addressed by a **compensating record**
(`FEE-FR-037`), not by a state change. The brief's instruction — *"define only states supported by
authoritative sources"* — is followed literally.

### 29.5 Refund — ⛔ BLOCKED

No state table is written. Tier unresolved (`FEE-GAP-001`).

---

## 30. Business Rules

`FEE-BR-001` … `FEE-BR-024` are stated inline at their point of use. Index:

| Rule | Subject | § |
|---|---|---|
| `FEE-BR-001` | No intra-cluster edge outside `E-01`…`E-10` | 8 |
| `FEE-BR-002` | `FeePayment`/`FeeDue`/`Receipt` naming | 9.3 |
| `FEE-BR-003` | No `BC-05`+`BC-20` shared model/table/metric | 9.3 |
| `FEE-BR-004` | Fee structure is not a financial record | 10 |
| `FEE-BR-005` | Structure change never mutates an existing obligation | 10.1 |
| `FEE-BR-006` | Change applies only after effective date | 10.1 |
| `FEE-BR-007` | Due-date rule not invented | 11.1 |
| `FEE-BR-008` | Invoice ≠ Payment | 12 |
| `FEE-BR-009` | Payment ≠ Receipt | 13 |
| `FEE-BR-010` | Cash is verified at recording | 13.1 |
| `FEE-BR-011` | Out-of-band UPI is staff-attested | 13.2 |
| `FEE-BR-012` | Gateway card payment is an online payment | 13.3 |
| `FEE-BR-013` | Full settlement only in V1 | 13.6 |
| `FEE-BR-014` | Client success is a hint, never a fact | 14 |
| `FEE-BR-015` | Visible reconciliation queue MUST exist | 14 |
| `FEE-BR-016` | Payment-side duplicate protection is BC-05's | 15 |
| `FEE-BR-017` | Discount never mutates the original amount | 17.1 |
| `FEE-BR-018` | No discount ceiling invented | 17.1 |
| `FEE-BR-019` | *(conditional)* refund = compensating entry, ≤ received | 18.1 |
| `FEE-BR-020` | Corrections append-only with actor + reason | 18.2 |
| `FEE-BR-021` | No stored balance aggregate | 19 |
| `FEE-BR-022` | No timer owns overdue status | 20 |
| `FEE-BR-023` | No self-defined metric formula | 22 |
| `FEE-BR-024` | "Revenue" must state which money it means | 22.1 |

---

## 31. Invariants

| ID | Invariant | Source |
|---|---|---|
| `FEE-INV-001` | Fee structure amount is non-negative `Money` in tenant currency | Derived from `Money` VO |
| `FEE-INV-002` | A `FeeDue` amount equals its creation snapshot, for life | `MP-GBR-12`, `MM-FR-027` |
| `FEE-INV-003` | Every financial record belongs to exactly one tenant and one student record | `E-18`, BC Map L374 |
| `FEE-INV-004` | A student is not archivable while outstanding > 0 | `E-09` verbatim |
| `FEE-INV-005` | No two confirmed payments share an idempotency key or gateway reference | `MP-GBR-18`, BC Map L478 |
| `FEE-INV-006` | An issued receipt never changes | `MP-GBR-12`, BC Map L374 |
| `FEE-INV-007` | Discount ≤ original; payable ≥ 0 | BC Map L374 |
| `FEE-INV-008` | Financial history is append-only | `MP-GBR-12` |
| `FEE-INV-009` | `balance = Σ dues − Σ receipts`, never stored independently | BC Map L374 verbatim |

---

## 32. Explicit Exclusions

| ID | This module MUST NOT |
|---|---|
| `FEE-XC-001` | Read, write or aggregate `BC-20` subscription revenue |
| `FEE-XC-002` | Report "revenue" mixing student fees and SaaS revenue |
| `FEE-XC-003` | Derive a fee obligation from attendance, presence or seat occupancy |
| `FEE-XC-004` | Accept or model a partial settlement in V1 |
| `FEE-XC-005` | Hold, read or transmit a payment-gateway credential |
| `FEE-XC-006` | Name a payment vendor in code, event, table or contract |
| `FEE-XC-007` | Update or delete an issued receipt |
| `FEE-XC-008` | Implement refund as an edit or deletion |
| `FEE-XC-009` | Store a materialised balance as authoritative state |
| `FEE-XC-010` | Hold student identity attributes beyond a `StudentRecordId` reference |
| `FEE-XC-011` | Purge or rewrite financial history |
| `FEE-XC-012` | Define, compute or publish a certified metric |
| `FEE-XC-013` | Build a reporting store inside `BC-05` |
| `FEE-XC-014` | Create a new role, or infer permission from dashboard visibility |
| `FEE-XC-015` | Store audit records locally or make audit synchronous |
| `FEE-XC-016` | Perform any cross-tenant financial read, write, aggregate or export |

**Also excluded by Rank 4 Dependency Matrix L167** (`LIBRARY MANAGEMENT → INTEGRATION` = `✖`): direct
integration access. And by `MM-XC-004`'s mirror: this module is the **only** ledger holder, so it must
not tolerate a second ledger elsewhere either.

---

## 33. Cross-Module Dependencies

| Edge | Counterpart | Status of counterpart | Risk |
|---|---|---|---|
| `E-07` | `BC-02` (`PRD-005` v1.4 **FROZEN**) | ✅ contract settled | Low |
| `E-10` | `BC-02` (**FROZEN**) | ✅ settled; V1 = *direct handler*, saga is V2 | Low |
| `E-09` | `BC-01` (`PRD-004` v1.2 **FROZEN**) | ✅ settled | Low |
| `E-06` | `BC-06` Library Policy (`PRD-002`) | ⚠ policy PRD not frozen | Medium — due-date arithmetic depends on it (`FEE-GAP-006`) |
| `E-17` | `BC-21` Entitlement | ❌ `D-08` *"Unsatisfied — no specification"* | Medium |
| `E-18` | `BC-19` Tenancy | ⚠ specification maturity unverified | High if absent — tenancy is mandatory |
| `E-19` | `BC-25` Configuration | ⚠ | Medium |
| `E-20` | `BC-24` Audit | ❌ `D-09` *"Unsatisfied"*, `X-10` not implemented | Medium |
| `E-23` | `BC-22` Notification | ❌ `D-12` *"Unsatisfied"* | Low for V1 facts |
| **gateway** | `BC-20`/`BC-31` | ❌ **no edge from `BC-05`**; `D-14` *"Both unwritten"* | **BLOCKING — `FEE-GAP-002`** |
| **offline** | `BC-30` | ❌ **no edge from `BC-05`**; `D-13` *"Both unwritten"* | **BLOCKING — `FEE-GAP-002`(b)** |
| **analytics** | `BC-26` | ⚠ consumer in §9, no `E-*` in §7 | Medium — `FEE-GAP-012` |

Cycle note: Dependency Matrix L382 — *"This resolves `E-07` / `E-10` in the context map, which would
otherwise be a cycle between `BC-02` and `BC-05`"* — the **transactional outbox** is what breaks it.
`FEE-PO-008` — `E-10` **MUST** be published through the transactional outbox in the same DB transaction
as the ledger mutation, *"never published from application code after commit"* (BC Map L446).

---

## 34. Edge Cases

Deterministic outcomes. Rows marked ⛔ cannot be resolved without a gap decision.

| Scenario | Required outcome |
|---|---|
| Payment confirmed, membership activation fails | Payment **stands**; `BC-05`'s ledger is authoritative. Membership stays `PendingPayment` and appears in the reconciliation queue. **Payment MUST NOT be reversed.** *(frozen `PRD-005` L937, verbatim obligation)* |
| Payment received for a voided membership | Activation refused by `BC-02`; event recorded and surfaced for a **refund decision by `BC-05`** ⛔ `FEE-GAP-001` |
| Duplicate payment callback | Second callback produces **no** second payment, receipt or event (`FEE-FR-030`) |
| Client shows success, rail never confirms | Payment stays `PENDING`; no receipt; reconciliation queue |
| Device offline at collection | ⛔ `FEE-GAP-002`(b). Online payment **MUST NOT** succeed by default (`FEE-PO-006`) |
| Fee structure changed after obligation raised | Existing obligation **unchanged** (`FEE-BR-005`) |
| Wrong amount entered on an obligation | ⛔ `FEE-GAP-005` — no authorised correction path exists |
| Student archived with outstanding dues | Archival **blocked with a domain error** (`E-09`, `FEE-INV-004`) |
| Discount exceeds original amount | Rejected (`FEE-INV-007`) |
| Two staff record the same cash payment | Idempotency key at API edge (`FEE-FR-029`); duplicate surfaced by reconciliation (`FEE-FR-032`) |
| Student pays ₹500 of a ₹2000 due | **No V1-legal representation** (`FEE-XC-004`, `FEE-GAP-008`) |
| Cash drawer count disagrees with ledger | **Out of V1 scope** — Cash Reconciliation is EA (V2) `NG-8`. The ledger remains authoritative |
| Event arrives twice from `E-07` | Idempotent on `eventId` (`FEE-FR-009`) |
| Event arrives with no tenant context | **Fail loudly, never default** (BC Map L451, `FEE-PO-003`) |

---

## 35. Acceptance Criteria

**70 criteria, `FEE-AC-001` … `FEE-AC-070`.** Each is *verified by* a test; none is an obligation.
**None is proven** — no test exists, no task file exists. Per `SID-4.56`, every one **is currently unmet**.

### 35.1 Fee structure (`FEE-AC-001`…`006`)
| ID | Criterion |
|---|---|
| `FEE-AC-001` | A fee structure can be created with tenant, name, amount, currency, active flag, effective date |
| `FEE-AC-002` | A fee structure created in tenant A is invisible in tenant B |
| `FEE-AC-003` | Creating a fee structure emits an audit fact |
| `FEE-AC-004` | Amending a fee structure emits an audit fact |
| `FEE-AC-005` | A fee structure with a negative amount is rejected |
| `FEE-AC-006` | A fee structure carries no balance and appears in no ledger total |

### 35.2 Fee applicability & structure change (`FEE-AC-007`…`011`)
| ID | Criterion |
|---|---|
| `FEE-AC-007` | Changing a fee structure leaves every existing `FeeDue` amount unchanged |
| `FEE-AC-008` | An obligation raised after the effective date uses the new amount |
| `FEE-AC-009` | An obligation raised before the effective date keeps the old amount |
| `FEE-AC-010` | A `FeeDue` amount cannot be edited by any API path |
| `FEE-AC-011` | Fee type is read through configuration, not a hard-coded enum |

### 35.3 Obligation creation (`FEE-AC-012`…`018`)
| ID | Criterion |
|---|---|
| `FEE-AC-012` | `membership.MembershipCreated` raises a `FeeDue` with the event's `priceSnapshot` |
| `FEE-AC-013` | `membership.MembershipRenewed` raises or adjusts a `FeeDue` |
| `FEE-AC-014` | `membership.MembershipUpgraded` adjusts dues using `priceDifference` |
| `FEE-AC-015` | The same membership event delivered twice raises exactly **one** `FeeDue` |
| `FEE-AC-016` | `BC-05` never creates a `FeeDue` for a membership event it did not receive |
| `FEE-AC-017` | A `FeeDue` references a `StudentRecordId` and stores no identity attributes |
| `FEE-AC-018` | An event without tenant context fails loudly and creates nothing |

### 35.4 Due / overdue transitions (`FEE-AC-019`…`024`)
| ID | Criterion |
|---|---|
| `FEE-AC-019` | A new obligation is `DUE` |
| `FEE-AC-020` | An obligation past its due date reports `OVERDUE` |
| `FEE-AC-021` | `OVERDUE` is reproducible from recorded facts with no scheduled job having run |
| `FEE-AC-022` | `PAID` never returns to `DUE` or `OVERDUE` |
| `FEE-AC-023` | `CANCELLED` has no outgoing transition |
| `FEE-AC-024` | No state named `PARTIALLY_PAID` exists anywhere in the model |

### 35.5 Payment recording (`FEE-AC-025`…`031`)
| ID | Criterion |
|---|---|
| `FEE-AC-025` | A cash payment recorded at reception is `CONFIRMED` and records the collecting actor |
| `FEE-AC-026` | A UPI payment can be recorded with method `UPI` |
| `FEE-AC-027` | A card payment can be recorded with method `CARD` |
| `FEE-AC-028` | A payment stores tenant, student reference, amount, currency, method, idempotency key, actor, timestamp |
| `FEE-AC-029` | A `CONFIRMED` payment cannot be edited by any API path |
| `FEE-AC-030` | Recording a payment emits an audit fact |
| `FEE-AC-031` | A `student` role cannot record or confirm a payment |

### 35.6 Payment verification (`FEE-AC-032`…`036`)
| ID | Criterion |
|---|---|
| `FEE-AC-032` | A client-side success signal alone does not move a payment out of `PENDING` |
| `FEE-AC-033` | A `PENDING` payment settles no obligation and generates no receipt |
| `FEE-AC-034` | A `PENDING` payment emits no `fee.FeePaymentReceived` |
| `FEE-AC-035` | A payment with an unknown outcome appears in the reconciliation queue |
| `FEE-AC-036` | An offline device cannot cause an online payment to be recorded `CONFIRMED` |

### 35.7 Duplicate prevention (`FEE-AC-037`…`041`)
| ID | Criterion |
|---|---|
| `FEE-AC-037` | The same idempotency key returns the original result and creates no second payment |
| `FEE-AC-038` | The same idempotency key creates no second receipt |
| `FEE-AC-039` | The same idempotency key emits no second `fee.FeePaymentReceived` |
| `FEE-AC-040` | Two confirmed payments cannot share a gateway reference |
| `FEE-AC-041` | A reconciliation routine surfaces duplicate or orphaned captures |

### 35.8 Invoice & receipt (`FEE-AC-042`…`048`)
| ID | Criterion |
|---|---|
| `FEE-AC-042` | An issued invoice cannot be edited |
| `FEE-AC-043` | An invoice is cancelled by state transition, never deleted |
| `FEE-AC-044` | Issuing an invoice moves no money and creates no receipt |
| `FEE-AC-045` | A receipt is generated for a `CONFIRMED` payment |
| `FEE-AC-046` | No receipt is generated for a `PENDING` payment |
| `FEE-AC-047` | An issued receipt cannot be updated or deleted through any path |
| `FEE-AC-048` | A receipt correction appears as a new compensating record, leaving the original intact |

### 35.9 Discounts (`FEE-AC-049`…`052`)
| ID | Criterion |
|---|---|
| `FEE-AC-049` | A discount without an authorised approver is rejected |
| `FEE-AC-050` | A discount records approver, reason, original amount, discount and payable |
| `FEE-AC-051` | A discount greater than the original amount is rejected |
| `FEE-AC-052` | After a discount, the original amount remains independently visible |

### 35.10 History & outstanding (`FEE-AC-053`…`057`)
| ID | Criterion |
|---|---|
| `FEE-AC-053` | Outstanding balance equals `Σ dues − Σ receipts` computed at read time |
| `FEE-AC-054` | No stored field is the authority for a student's balance |
| `FEE-AC-055` | Financial history is append-only — no path edits or deletes an entry |
| `FEE-AC-056` | History shows actor and timestamp for every entry |
| `FEE-AC-057` | Archiving a student with outstanding dues fails with a domain error |

### 35.11 Roles & tenancy (`FEE-AC-058`…`061`)
| ID | Criterion |
|---|---|
| `FEE-AC-058` | A `parent` sees fee updates only for guarded students |
| `FEE-AC-059` | A `student` sees only their own financial history |
| `FEE-AC-060` | No financial query returns data from another tenant |
| `FEE-AC-061` | Dashboard visibility alone grants no financial write capability |

### 35.12 Events, reporting & BC separation (`FEE-AC-062`…`064`)
| ID | Criterion |
|---|---|
| `FEE-AC-062` | Exactly **three** `fee.*` events exist; no fourth is published |
| `FEE-AC-063` | No table, projection or metric contains both `BC-05` and `BC-20` money |
| `FEE-AC-064` | `BC-05` publishes financial facts and defines no metric formula |

### 35.13 Ports, outbox & boundary enforcement (`FEE-AC-065`…`070`)

*Added during the adversarial self-review. §36.1 previously asserted coverage that the criteria did not
supply; these six close the arithmetic honestly rather than by re-wording the claim.*

| ID | Criterion |
|---|---|
| `FEE-AC-065` | Every `fee.*` event is written to the outbox **inside** the same DB transaction as the state change, and is never published from application code after commit |
| `FEE-AC-066` | A `fee.*` event redelivered with the same `eventId` causes no second state change in any consumer path owned here |
| `FEE-AC-067` | No code path in `BC-05` references a payment-vendor name, credential or SDK symbol |
| `FEE-AC-068` | Online payment execution is reachable only through the Business Platform port; no direct `BC-31` call exists |
| `FEE-AC-069` | A due date is computed only via the `E-06` `HolidayCalendar` port; no local calendar table exists |
| `FEE-AC-070` | A manually created `FeeDue` records actor and reason and emits an audit fact |

**Not covered by any criterion, deliberately:** refunds (⛔ `FEE-GAP-001`), webhook reconciliation
(⛔ `FEE-GAP-002`), offline cash capture (⛔ `FEE-GAP-002`(b)), bank transfer (⛔ `FEE-GAP-003`),
due-date arithmetic (⛔ `FEE-GAP-006`). **Writing criteria for undecided behaviour would be fabricating
verification.**

---

## 36. Traceability

### 36.1 Coverage

> **Self-review correction.** The first draft of this section asserted *"113 = 95.8%"* while the criteria
> tables in §35 contained **no requirement back-links at all** — the figure was therefore not measurable
> and not true. It is replaced below by an explicit per-identifier mapping. The defect and its correction
> are recorded in the changelog (§41) and in finding **J-2** of the covering report.

**Forward trace — every obligation-bearing identifier to its verifying criterion:**

*One row per identifier — deliberately not collapsed into ranges, so that a future `prd008_traceability.py` can verify it mechanically.*

| Requirement | Verified by | Note |
|---|---|---|
| `FEE-FR-001` | `FEE-AC-001` |  |
| `FEE-FR-002` | `FEE-AC-001`, `FEE-AC-005` |  |
| `FEE-FR-003` | `FEE-AC-002` |  |
| `FEE-FR-004` | `FEE-AC-003`, `FEE-AC-004` |  |
| `FEE-FR-005` | `FEE-AC-008`, `FEE-AC-009` |  |
| `FEE-FR-006` | `FEE-AC-011` |  |
| `FEE-FR-007` | `FEE-AC-012`, `FEE-AC-013` |  |
| `FEE-FR-008` | `FEE-AC-017`, `FEE-AC-028` |  |
| `FEE-FR-009` | `FEE-AC-015` |  |
| `FEE-FR-010` | `FEE-AC-014` |  |
| `FEE-FR-011` | `FEE-AC-016` |  |
| `FEE-FR-012` | `FEE-AC-070` |  |
| `FEE-FR-013` | `FEE-AC-019` |  |
| `FEE-FR-014` | `FEE-AC-069` |  |
| `FEE-FR-015` | `FEE-AC-057` |  |
| `FEE-FR-016` | `FEE-AC-044` |  |
| `FEE-FR-017` | `FEE-AC-042` |  |
| `FEE-FR-018` | `FEE-AC-043` |  |
| `FEE-FR-019` | `FEE-AC-028` |  |
| `FEE-FR-020` | `FEE-AC-033`, `FEE-AC-053` |  |
| `FEE-FR-021` | `FEE-AC-029` |  |
| `FEE-FR-022` | `FEE-AC-025` |  |
| `FEE-FR-023` | `FEE-AC-025` |  |
| `FEE-FR-024` | `FEE-AC-026` |  |
| `FEE-FR-025` | `FEE-AC-027` |  |
| `FEE-FR-026` | `FEE-AC-032` |  |
| `FEE-FR-027` | `FEE-AC-033`, `FEE-AC-034` |  |
| `FEE-FR-028` | **⛔ none** | BLOCKED — `FEE-GAP-002` |
| `FEE-FR-029` | `FEE-AC-037` |  |
| `FEE-FR-030` | `FEE-AC-037`, `FEE-AC-038` |  |
| `FEE-FR-031` | `FEE-AC-040` |  |
| `FEE-FR-032` | `FEE-AC-041` |  |
| `FEE-FR-033` | `FEE-AC-045` |  |
| `FEE-FR-034` | `FEE-AC-047` |  |
| `FEE-FR-035` | `FEE-AC-050`, `FEE-AC-056` |  |
| `FEE-FR-036` | `FEE-AC-046` |  |
| `FEE-FR-037` | `FEE-AC-048` |  |
| `FEE-FR-038` | `FEE-AC-049` |  |
| `FEE-FR-039` | `FEE-AC-049` |  |
| `FEE-FR-040` | `FEE-AC-050` |  |
| `FEE-FR-041` | `FEE-AC-030` |  |
| `FEE-FR-042` | **⛔ none** | BLOCKED — `FEE-GAP-001` |
| `FEE-FR-043` | `FEE-AC-048` |  |
| `FEE-FR-044` | `FEE-AC-055` |  |
| `FEE-FR-045` | `FEE-AC-053`, `FEE-AC-054` |  |
| `FEE-FR-046` | `FEE-AC-059` |  |
| `FEE-FR-047` | `FEE-AC-053` |  |
| `FEE-FR-048` | `FEE-AC-020`, `FEE-AC-021` |  |
| `FEE-FR-049` | `FEE-AC-055` |  |
| `FEE-FR-050` | `FEE-AC-056` |  |
| `FEE-FR-051` | `FEE-AC-055` |  |
| `FEE-FR-052` | `FEE-AC-064` |  |
| `FEE-FR-053` | `FEE-AC-031`, `FEE-AC-060` |  |
| `FEE-FR-054` | `FEE-AC-031` |  |
| `FEE-FR-055` | `FEE-AC-058` |  |
| `FEE-FR-056` | `FEE-AC-030` |  |
| `FEE-FR-057` | `FEE-AC-060` |  |
| `FEE-FR-058` | `FEE-AC-060` |  |
| `FEE-BR-001` | `FEE-AC-068` |  |
| `FEE-BR-002` | `FEE-AC-063` |  |
| `FEE-BR-003` | `FEE-AC-063` |  |
| `FEE-BR-004` | `FEE-AC-006` |  |
| `FEE-BR-005` | `FEE-AC-007`, `FEE-AC-010` |  |
| `FEE-BR-006` | `FEE-AC-008`, `FEE-AC-009` |  |
| `FEE-BR-007` | **⛔ none** | BLOCKED — `FEE-GAP-006` |
| `FEE-BR-008` | `FEE-AC-044` |  |
| `FEE-BR-009` | `FEE-AC-045`, `FEE-AC-046` |  |
| `FEE-BR-010` | `FEE-AC-025` |  |
| `FEE-BR-011` | `FEE-AC-026` |  |
| `FEE-BR-012` | `FEE-AC-027`, `FEE-AC-032` |  |
| `FEE-BR-013` | `FEE-AC-024` |  |
| `FEE-BR-014` | `FEE-AC-032` |  |
| `FEE-BR-015` | `FEE-AC-035` |  |
| `FEE-BR-016` | `FEE-AC-040`, `FEE-AC-041` |  |
| `FEE-BR-017` | `FEE-AC-052` |  |
| `FEE-BR-018` | `FEE-AC-051` |  |
| `FEE-BR-019` | **⛔ none** | BLOCKED — `FEE-GAP-001` |
| `FEE-BR-020` | `FEE-AC-048` |  |
| `FEE-BR-021` | `FEE-AC-054` |  |
| `FEE-BR-022` | `FEE-AC-021` |  |
| `FEE-BR-023` | `FEE-AC-064` |  |
| `FEE-BR-024` | `FEE-AC-063` |  |
| `FEE-INV-001` | `FEE-AC-005` |  |
| `FEE-INV-002` | `FEE-AC-007`, `FEE-AC-010` |  |
| `FEE-INV-003` | `FEE-AC-002`, `FEE-AC-017` |  |
| `FEE-INV-004` | `FEE-AC-057` |  |
| `FEE-INV-005` | `FEE-AC-037`, `FEE-AC-040` |  |
| `FEE-INV-006` | `FEE-AC-047` |  |
| `FEE-INV-007` | `FEE-AC-051` |  |
| `FEE-INV-008` | `FEE-AC-055` |  |
| `FEE-INV-009` | `FEE-AC-053`, `FEE-AC-054` |  |
| `FEE-EVT-001` | `FEE-AC-062`, `FEE-AC-065` |  |
| `FEE-EVT-002` | `FEE-AC-034`, `FEE-AC-039`, `FEE-AC-066` |  |
| `FEE-EVT-003` | `FEE-AC-062` | count only — behaviour ⛔ `FEE-GAP-001` |
| `FEE-XC-001` | `FEE-AC-063` |  |
| `FEE-XC-002` | `FEE-AC-063` |  |
| `FEE-XC-003` | `FEE-AC-012`, `FEE-AC-016` |  |
| `FEE-XC-004` | `FEE-AC-024` |  |
| `FEE-XC-005` | `FEE-AC-067` |  |
| `FEE-XC-006` | `FEE-AC-067` |  |
| `FEE-XC-007` | `FEE-AC-047` |  |
| `FEE-XC-008` | `FEE-AC-047`, `FEE-AC-048` |  |
| `FEE-XC-009` | `FEE-AC-054` |  |
| `FEE-XC-010` | `FEE-AC-017` |  |
| `FEE-XC-011` | `FEE-AC-055` |  |
| `FEE-XC-012` | `FEE-AC-064` |  |
| `FEE-XC-013` | `FEE-AC-064` |  |
| `FEE-XC-014` | `FEE-AC-061` |  |
| `FEE-XC-015` | `FEE-AC-030` |  |
| `FEE-XC-016` | `FEE-AC-060` |  |
| `FEE-PO-001` | `FEE-AC-068` |  |
| `FEE-PO-002` | `FEE-AC-030` |  |
| `FEE-PO-003` | `FEE-AC-018`, `FEE-AC-060` |  |
| `FEE-PO-004` | `FEE-AC-062` |  |
| `FEE-PO-005` | `FEE-AC-064` |  |
| `FEE-PO-006` | `FEE-AC-036` |  |
| `FEE-PO-007` | `FEE-AC-035` |  |
| `FEE-PO-008` | `FEE-AC-065`, `FEE-AC-066` |  |

**Measured coverage:**

| Register | Allocated | Traced | Untraced (all ⛔ BLOCKED) |
|---|---|---|---|
| `FEE-FR-*` | 58 | 56 | `FEE-FR-028`, `FEE-FR-042` |
| `FEE-BR-*` | 24 | 22 | `FEE-BR-007`, `FEE-BR-019` |
| `FEE-INV-*` | 9 | 9 | — |
| `FEE-EVT-*` | 3 | 3 | — *(`FEE-EVT-003` count-only)* |
| `FEE-XC-*` | 16 | 16 | — |
| `FEE-PO-*` | 8 | 8 | — |
| **Total** | **118** | **114** | **4 = 96.6%** |

**This does not meet the 100% bar** that `PRD-006` cleared (285/285). The shortfall is **exactly** the four
requirements whose behaviour is governed by an unresolved gap. Writing criteria for undecided behaviour
would be fabricating verification, so the shortfall is reported, not closed.

### 36.2 Upstream traceability

| Requirement group | Traces to |
|---|---|
| Ledger, balance, immutability | `MP-GBR-12`, BC Map L374 |
| Idempotency | `MP-GBR-18`, `MP-RSK-04`, BC Map L478, `MM-BR-005` |
| `BC-05`/`BC-20` separation | `MP-GBR-24`, BC Map L202–204, `ADR-0015` |
| Metric boundary | `MP-GBR-36`, `MP-SM-06` |
| Obligation creation | `E-07`, `MM-BR-003`, `MM-EVT-001`/`003`/`004` |
| Payment outcome → membership | `E-10`, `MM-BR-002` |
| Archival block | `E-09` |
| Holiday calendar | `E-06` |
| Reconciliation queue | BC Map L465, `MM-BR-004` |
| Roles | Master PRD L105–111 |
| Cluster edge law | Dependency Matrix L89 |
| Capability ports | `E-17`…`E-23` |

### 36.3 No gate exists

`PRD-006` has `tool/docs_check/prd006_traceability.py` and `prd006_task_coverage.py`. **No equivalent
`prd008_*` gate has been written**, so every count in §36.1 is **hand-measured and unverified by
machine**. Recorded as part of `FEE-GAP-012`. No gate was weakened — none exists to weaken.

---

## 37. Governance Gap Ledger

**12 gaps. 5 block Stage 4. 10 block Freeze.** None is resolved by assumption. *(These two counts were
stated inconsistently in the first draft — `6/6` here and `6/9` in §39. Both were wrong; the values below
are derived by reading the `Stage 4` and `Freeze` row of every gap block. Self-review finding **J-3**.)*

### `FEE-GAP-001` — Is Refund V1 or V2?
| Field | Value |
|---|---|
| **Question** | Is refund functionality in scope for `BC-05` V1? |
| **Conflict** | **Rank 4** BC Map L100 (`BC-05` owns refunds, row Release = V1), L374 (`RefundRecord` in `FeeLedger`, invariant `refund ≤ received`), L422 (`fee.RefundIssued` published) · **Rank 3 FROZEN** `PRD-005` L942 (*"a refund decision by `BC-05`"*) **vs Rank 6** EA L823 `Refunds (V2)`, L1409 `Refund Management (V2)` |
| **Impact** | If V1: 3+ requirements, a state table and `FEE-EVT-003` must be written. If V2: the BC Map's own event table must mark `fee.RefundIssued` V2, and frozen `PRD-005` L942 is left depending on a capability that does not exist in V1 |
| **Owner** | Product Owner — Library Domain |
| **Authority** | **Product Owner** (tier) **+ Architecture Owner** (BC Map event table) |
| **Status** | **OPEN — REQUIRES PRODUCT OWNER + REQUIRES ARCHITECTURE OWNER** |
| **Stage 4** | **BLOCKS** |
| **Freeze** | **BLOCKS** |
| **Recommended** | Rank 4 outranks Rank 6, and a frozen Rank 3 PRD already depends on the decision existing. Recommend **refund IS V1**, minimal: owner-approved, compensating-entry-only, `refund ≤ received`, no partial-refund arithmetic. EA to be corrected to match (`MP-CON-08`: *"the Enterprise Architecture is updated to match — never the reverse"*) |

### `FEE-GAP-002` — `BC-05` has no declared path to a payment gateway *(and none to offline sync)*
| Field | Value |
|---|---|
| **Question** | Through which declared architectural edge does `BC-05` execute and reconcile an online payment? And through which does it queue an offline financial write? |
| **Conflict** | `E-25` is **`BC-20` → `BC-31`** (BC Map L334) · edges `BC-05`→`BC-31` = **0** · `E-24` is **`BC-03` → `BC-30`** (L333) · edges `BC-05`→`BC-30` = **0** · **but** `PRD_DEPENDENCY_GRAPH.md` L116 `D-14` asserts *"`PRD-008` … `E-25`"* · **and** Rank 4 Dependency Matrix L167 sets `LIBRARY MANAGEMENT → INTEGRATION` = **`✖`**, routing payments *"only via BUSINESS"*, with `X-03` naming the port `business.payment_intent` — which has **no numbered edge** from `BC-05` |
| **Impact** | Online payment, payment verification, webhook reconciliation and offline cash capture **cannot be specified**. This is the largest functional hole in the draft |
| **Owner** | Architecture Owner |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** — a BC Map §7 amendment or an explicit no-edge ruling |
| **Status** | **OPEN — BLOCKED** |
| **Stage 4** | **BLOCKS** |
| **Freeze** | **BLOCKS** |
| **Recommended** | Do **not** widen the Core-cluster allow-list (`E-01`…`E-10`) — that is the error `ADR-0033` refused. Prefer the `ADR-0033` **precedent**: ratify `business.payment_intent` as an **already-permitted port pattern requiring no numbered edge**, or add a numbered edge `BC-05` → `BC-20`/`BC-31` **outside** the intra-cluster range by ADR. Correct `D-14` either way |

### `FEE-GAP-003` — Bank transfer has no source
| Field | Value |
|---|---|
| **Question** | Is bank transfer a V1 payment method? |
| **Absence** | Named in **no** source: not BC Map L202 (*"cash/UPI"*), not EA L1395–1401 (Online/Cash/UPI/Card), not the Master PRD, not any frozen PRD |
| **Impact** | Indian libraries do receive NEFT/IMPS. If omitted, staff will record it as cash and corrupt method-based reporting |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block *(clean omission)* |
| **Freeze** | **BLOCKS** — a method used in practice but unrepresentable is a V1 defect |
| **Recommended** | Approve bank transfer as a **staff-attested** method (same class as out-of-band UPI, `FEE-BR-011`), needing no gateway and therefore not entangled with `FEE-GAP-002` |

### `FEE-GAP-004` — No approved fee-type taxonomy
| Field | Value |
|---|---|
| **Question** | Which fee types are V1: admission, membership, renewal, joining/registration, deposit, "other charges"? |
| **Absence** | `grep` for these terms across `docs/30-product/` and `docs/10-architecture/` = **0 matches**. Sources provide only a generic fee structure (EA L822) and `FeeDue` |
| **Impact** | Fee-type reporting (§22.1) has no defined domain. Deposits especially: a refundable deposit is a **liability**, not revenue, and would change the ledger model |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | **BLOCKS** — §22.1 cites a report over an undefined dimension |
| **Freeze** | **BLOCKS** |
| **Recommended** | Approve a minimal V1 list. **Decide `deposit` separately** — if refundable it is not revenue and interacts with `FEE-GAP-001` |

### `FEE-GAP-005` — No authorised correction path for a mis-entered obligation
| Field | Value |
|---|---|
| **Question** | How is a genuinely wrong `FeeDue` amount corrected, given `FEE-BR-005`/`FEE-INV-002` immutability? |
| **Absence** | `MP-GBR-12` forbids in-place edits and **deliberately removed** the *"except through approved workflows"* loophole. No source authorises cancel-and-reissue |
| **Impact** | Staff face an uncorrectable error, and will work around it — the classic driver of shadow ledgers |
| **Owner** | Product Owner + Architecture Owner |
| **Authority** | **REQUIRES PRODUCT OWNER + REQUIRES ARCHITECTURE OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | **BLOCKS** |
| **Freeze** | **BLOCKS** |
| **Recommended** | Authorise `CANCELLED` + new obligation, both audited with actor and reason, as a **compensating pair** — consistent with `MP-GBR-12` and with `BC-03`'s append-only correction model |

### `FEE-GAP-006` — Due-date computation rule undefined
| Field | Value |
|---|---|
| **Question** | How is a `FeeDue`'s due date computed, and what grace applies before `OVERDUE`? |
| **Absence** | `E-06` supplies a `HolidayCalendar` *"for proration and freeze-day computation"* but **no offset, grace or arithmetic** is specified anywhere. `BC-06`'s PRD (`PRD-002`) is not frozen |
| **Impact** | `OVERDUE` (§29.1) has no computable boundary; `FEE-AC-020`/`021` cannot be implemented deterministically |
| **Owner** | Product Owner *(policy)* + `BC-06` owner *(calendar semantics)* |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | **BLOCKS** |
| **Freeze** | **BLOCKS** |
| **Recommended** | Approve an explicit rule with a stated range. **Do not** default it silently — `PRD-006` §10A.4 set the precedent that a temporal rule must be *"not derived, inferred, or defaulted"* |

### `FEE-GAP-007` — No approved discount authority set or ceiling; no config register
| Field | Value |
|---|---|
| **Question** | Which roles are "authorised approvers" for discounts, and is there a maximum? |
| **Absence** | BC Map L374 says *"an authorised approver role"* without naming it. No source approves a percentage, ceiling or range |
| **Impact** | §23.1's discount row is partly unresolved; no `FEE-CFG-*` register can be opened |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block — the **approver-role requirement** is specified (`FEE-FR-039`); only its membership and any ceiling are open |
| **Freeze** | **BLOCKS** |
| **Recommended** | Name the roles explicitly. Add a ceiling **only** if the Product Owner approves a range; otherwise rely on the approver control, as `PRD-006` did when it refused an unapproved configurable |

### `FEE-GAP-008` — Partial payments V2 has a real V1 cost
| Field | Value |
|---|---|
| **Question** | Confirm partial payments are excluded from V1, knowing Indian libraries routinely take part payment |
| **Evidence** | **Only** EA L1400 `Partial Payments (V2)` — a **Rank 6 descriptive** document. No Rank 1–4 statement exists |
| **Impact** | A ₹500 payment against a ₹2000 due is **unrepresentable** (`FEE-XC-004`). Staff will under-record or fabricate a second structure |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN — VALIDLY DEFERRED pending confirmation** |
| **Stage 4** | Does not block — exclusion is coherent and stated |
| **Freeze** | Does not block *(if consciously confirmed)* |
| **Recommended** | Confirm explicitly, with the cost on the record. This draft follows EA because nothing higher speaks — but a Rank 6 document should not silently decide a core collection behaviour |

### `FEE-GAP-009` — Is Invoice a distinct aggregate or the issued form of `FeeDue`?
| Field | Value |
|---|---|
| **Conflict** | BC Map L204 equates `BC-05`'s *"Invoice"* with **`FeeDue`**; BC Map L374 lists **five** `FeeLedger` members and *Invoice* is **not** one — **but** EA L1413 lists *"Invoice Generation (V1)"* as a capability separate from receipts |
| **Impact** | Determines whether §29.3 is a real state machine or a projection of §29.1 |
| **Owner** | Architecture Owner |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block — this draft takes the Rank 4 reading and says so |
| **Freeze** | **BLOCKS** — two state machines for one concept is a modelling defect |
| **Recommended** | Confirm the Rank 4 reading: invoice = issued representation of `FeeDue`, **no sixth aggregate member** |

### `FEE-GAP-010` — Is a payment vendor chosen?
| Field | Value |
|---|---|
| **Conflict** | EA L1405 lists **`Razorpay (V1)`** and L79 calls it *"Single gateway (Razorpay) = vendor lock-in"* · **Master PRD L232** records Payments as *"`BC-20` via `BC-31`"* with gateway *"**Not named in EA** — candidate only"* |
| **Impact** | None for this PRD's text — `FEE-XC-006` forbids naming a vendor regardless — but it blocks `FEE-GAP-002`'s resolution |
| **Owner** | Architecture Owner |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | Does not block **this** PRD — the vendor lives behind `BC-20`/`BC-31` |
| **Recommended** | Resolve inside `BC-20`'s PRD. `BC-05` **MUST** stay vendor-blind either way (Dependency Matrix L167) |

### `FEE-GAP-011` — Financial retention undefined
| Field | Value |
|---|---|
| **Question** | How long must financial records be retained, and may anything ever be purged? |
| **Absence** | No source document states a retention period for `BC-05`. `FEE-XC-011` therefore forbids purging entirely |
| **Impact** | Indian statutory retention may apply; an absolute never-purge rule may itself be non-compliant |
| **Owner** | Product Owner + Security/Compliance |
| **Authority** | **REQUIRES PRODUCT OWNER + REQUIRES SECURITY** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | **BLOCKS** — a financial module frozen with no retention position is not production-safe |
| **Recommended** | Obtain a compliance position before freeze. *(`PRD-006` left retention explicitly undefined for the same reason.)* |

### `FEE-GAP-012` — Registry status, analytics edge, report tier, and the missing gate
| Field | Value |
|---|---|
| **Questions** | (a) `PRD_REGISTRY.md` records `PRD-008` **`PLANNED`**; who moves it to `DRAFT`? (b) `BC-26` is a `fee.*` **consumer** in BC Map §9 but has **no `E-*` edge** in §7 — same defect class as `MM-GAP-010`. (c) `Financial Reports` is **(V2)** at EA L814 and **(V1)** at EA L1424. (d) No `prd008_traceability` gate exists, so §36.1's counts are hand-measured |
| **Impact** | (a) status legitimacy · (b) an undeclared transport · (c) unclear deliverable · (d) unverified traceability |
| **Owner** | Governance Owner (a, d) · Architecture Owner (b) · Product Owner (c) |
| **Authority** | **REQUIRES GOVERNANCE + REQUIRES ARCHITECTURE OWNER + REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | **BLOCKS** — `PRD-006` could not freeze without gates at exit 0 |
| **Recommended** | Registry update by the Governance Owner; write `prd008_traceability.py` before Stage 5; follow the `MM-GAP-010` precedent for `BC-26` — **do not list it as a publish target** until an edge exists |

---

## 38. Risks

| ID | Risk | Severity | Mitigation |
|---|---|---|---|
| `FEE-RSK-01` | Duplicate payment capture — *"unrecoverable trust damage"* | **Critical** | `FEE-FR-029`…`032`, `FEE-INV-005` (`MP-RSK-04`) |
| `FEE-RSK-02` | A second ledger appears in another module | High | `FEE-INV-009`, `MM-XC-004` mirror |
| `FEE-RSK-03` | `BC-05` and `BC-20` money mixed in a report | High | `FEE-BR-003`, `FEE-XC-001`/`002`, `MP-GBR-24` |
| `FEE-RSK-04` | Online payment accepted on a client-side signal | High | `FEE-BR-014`, `FEE-FR-026`/`027` |
| `FEE-RSK-05` | Staff workaround because partial payment is unrepresentable | High | `FEE-GAP-008` — surfaced, not hidden |
| `FEE-RSK-06` | Uncorrectable data-entry error drives a shadow ledger | High | `FEE-GAP-005` |
| `FEE-RSK-07` | Cross-tenant financial leakage | **Critical** | `FEE-FR-057`/`058`, `FEE-XC-016`, fail-loud tenancy |
| `FEE-RSK-08` | Gateway vendor leaks into domain code | Medium | `FEE-XC-005`/`006`, Dependency Matrix `X-03` |
| `FEE-RSK-09` | Audit obligations unenforceable (`X-10` not implemented) | Medium | Disclosed in §24; `D-09` |
| `FEE-RSK-10` | Building to this draft as if approved | **Critical** | This header; 5 Stage-4-blocking gaps |

---

## 39. Open Decisions

| Gap | Decision needed | Owner | Blocks Stage 4 | Blocks Freeze |
|---|---|---|---|---|
| `FEE-GAP-001` | Refund V1 or V2 | Product Owner + Architecture Owner | ✅ | ✅ |
| `FEE-GAP-002` | Gateway path + offline path | Architecture Owner | ✅ | ✅ |
| `FEE-GAP-003` | Bank transfer | Product Owner | — | ✅ |
| `FEE-GAP-004` | Fee-type taxonomy (incl. deposit) | Product Owner | ✅ | ✅ |
| `FEE-GAP-005` | Obligation correction path | Product Owner + Architecture Owner | ✅ | ✅ |
| `FEE-GAP-006` | Due-date rule and grace | Product Owner | ✅ | ✅ |
| `FEE-GAP-007` | Discount approvers / ceiling | Product Owner | — | ✅ |
| `FEE-GAP-008` | Confirm partial payments V2 | Product Owner | — | — |
| `FEE-GAP-009` | Invoice aggregate or projection | Architecture Owner | — | ✅ |
| `FEE-GAP-010` | Vendor named or not | Architecture Owner | — | — |
| `FEE-GAP-011` | Retention | Product Owner + Security | — | ✅ |
| `FEE-GAP-012` | Registry / `BC-26` / report tier / gate | Governance + Architecture + Product | — | ✅ |

**5 block Stage 4. 10 block Freeze.** *(Corrected during self-review — see §37.)*

---

## 40. V1 Success Criteria

`PRD-008` V1 is successful when **all** hold:

1. Every `FeeDue` traces to a membership event or an audited manual act — none invented.
2. Balance is always `Σ dues − Σ receipts`, computed, never stored.
3. No student is charged twice, under retry, duplicate callback or double staff entry.
4. No issued receipt has ever changed.
5. No financial record was edited or deleted; every correction is a compensating entry.
6. No financial datum crossed a tenant boundary.
7. No report mixes `BC-05` and `BC-20` money.
8. Every financially sensitive act has an audit fact.
9. No online payment succeeded on a client signal alone.
10. `BC-05` defined no metric formula and holds no reporting store.
11. Exactly **three** `fee.*` events exist.
12. **All twelve gaps are closed by their named authority** — six before Stage 4.

**None is currently met.** No implementation exists; `FROZEN`/`VERIFIED` are not claimed.

---

## 41. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | *(this draft)* | **First draft. Stage 2 only.** Created from Rank 1–6 sources: Master PRD v1.7, `ADR-0015` (**Accepted**), BC Map v1.7, Module Dependency Matrix v1.3, frozen `PRD-004` v1.2 / `PRD-005` v1.4 / Library PRD v1.1, `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD_LIFECYCLE.md`, `PRD_DEPENDENCY_GRAPH.md`, `PRODUCT_IMPLEMENTATION_ROADMAP.md`, `PRD_GAP_ANALYSIS.md`, Enterprise Architecture v2.1 (Rank 6, descriptive). Registers `FEE-*` opened after a measured collision check (0 pre-existing occurrences): 58 FR, 24 BR, 9 INV, 3 EVT, 16 XC, 8 PO, 70 AC, 12 GAP = **200 identifiers**, 118 obligation-bearing. During the mandatory adversarial self-review two defects in this draft were found and corrected before issue: (a) §36.1 claimed *"113 = 95.8%"* traceability while the §35 criteria carried no requirement back-links — replaced with a measured per-identifier matrix showing **114/118 = 96.6%**; (b) `FEE-EVT-001`/`002`/`003` were declared in §0.2 but never defined normatively — now defined in §26. Six criteria (`FEE-AC-065`…`070`) were added to close coverage that the earlier percentage had merely asserted. **No `FEE-CFG-*` register opened** — no source approves any range. **No requirement, event, edge, endpoint, table, schema, vendor contract or configuration range was invented.** **12 governance gaps recorded; 5 block Stage 4, 10 block Freeze** (measured from the ledger rows; the first draft stated these inconsistently). `PRD_REGISTRY.md`'s `PLANNED` row for `PRD-008` is **unchanged** by this document. No other PRD, ADR, ranked document or source file was modified. |

---

*End of `PRD-008_REVENUE-AND-FINANCE.md` **v0.1 — DRAFT**. Not frozen. Not approved. Not architecture-reviewed.*
