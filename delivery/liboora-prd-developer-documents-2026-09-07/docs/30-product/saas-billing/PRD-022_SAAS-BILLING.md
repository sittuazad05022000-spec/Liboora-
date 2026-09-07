# `PRD-022` — SaaS Billing & Platform Revenue

| Field | Value |
|---|---|
| **PRD** | `PRD-022` |
| **Bounded context** | **`BC-20` Subscription & Billing** — `[GENERIC]`, Business layer, **V1** |
| **Version** | **v0.3 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT frozen. NOT approved. NOT architecture-reviewed.** |
| **Authorised by** | `MASTER_PRD.md` **L169** — §8 **module 17**, *"SaaS Billing \| `BC-20` Subscription & Billing \| `[GENERIC]` \| V1"* · `PRD_REGISTRY.md` **L326** (`PRD-022`, `V1`, `PLANNED`) · `PRD_REGISTRY.md` **L427** (§6: `BC-20` → `PRD-022`, **not contested**) |
| **Identifier prefix** | `SAAS-*` — collision-checked against every existing register before use (`PRD_LIFECYCLE.md` §5 rule 2). Measured **0** pre-existing `SAAS-*` identifiers repository-wide |
| **Owns money** | **Library → LIBOORA only.** Every obligation in this document is money a **library owes LIBOORA** |
| **Owns NO student money** | This document defines **no** student fee, payment, receipt or ledger. That is `BC-05`/`PRD-008` |
| **Blocking governance gaps** | **7 gaps.** **7 block Stage 4** · **7 block Freeze** — see §12. ✅ **At v0.3 the platform-charge and settlement DEFAULTS this document already carried were RATIFIED by direct conferral of authority by the human principal** — **3%** Platform Charge, future-only rate changes with **historical charges immutable**, settlement due day **15th** changeable among **10/15/25** for **future** periods with **existing obligations never moving**, **14-day** free trial, `BC-20`/`PRD-022` **confirmed as owner** of the Library → LIBOORA Platform Charge and settlement lifecycle, and **cash-only libraries MUST have an independent settlement method** (net-off may not be the only one). ⛔ **AND THE GAP COUNT DOES NOT MOVE: still 7 / 7 / 7.** Every one of those decisions ratifies a **value or an ownership** this document had already written down; **not one of them answers a question §12 asks.** §12 asks which *collections* accrue a charge (`SAAS-GAP-001`, still open on `FEE-GAP-004`'s taxonomy), what the *ranges* are and which register allocates their *identifiers* (`SAAS-GAP-002`), whether the `E-25` rail can carry a **library-initiated outbound push** at all (`SAAS-GAP-003`), which **enumerated permission** lets **any** role settle (`SAAS-GAP-004` — **0** `PERM-*` identifiers exist repository-wide, so the action **fails closed even for `TR-1`**), which identity anchors trial eligibility (`SAAS-GAP-005`), Stage 3 (`SAAS-GAP-006`, still not performed), and February behaviour for days 29–31 (`SAAS-GAP-007`). **A default being ratified is not a gap being closed, and this row refuses to convert one into the other.** See §12.2 |

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
| `SAAS-FR-*` | Functional requirement | **28** | `SAAS-FR-001` … `SAAS-FR-028` |
| `SAAS-BR-*` | Business rule | **13** | `SAAS-BR-001` … `SAAS-BR-013` |
| `SAAS-INV-*` | Invariant | **8** | `SAAS-INV-001` … `SAAS-INV-008` |
| `SAAS-XC-*` | Explicit exclusion — what this module MUST NOT do | **15** | `SAAS-XC-001` … `SAAS-XC-015` |
| `SAAS-AC-*` | Acceptance criterion | **31** | `SAAS-AC-001` … `SAAS-AC-031` |
| `SAAS-GAP-*` | Governance gap / open question — **not a requirement** | **7** | `SAAS-GAP-001` … `SAAS-GAP-007` |
| **Total** | | **102** | |

**Obligation-bearing** = 28 + 13 + 8 + 15 = **64**. `SAAS-AC-*` are *verified by* tests and `SAAS-GAP-*` are *open
questions*; neither is an obligation, on the same principle `PRD-006` §0.3 applies to its own acceptance and
gap registers. *(That precedent is cited by section rather than by quoting Attendance's identifiers:
`tool/docs_check/prd006_traceability.py` fails any Attendance-prefixed token found outside that module and
its enumerated allow-list, and it is right to do so. Widening a gate so this document could quote a foreign
register would be the wrong direction, so the citation was rephrased instead.)*

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

## 6A. Billing period and the calendar due date

**Product decision applied:** the Platform Charge is due on a **configurable calendar day, default the 15th of every
month** — **not** 15 days after each individual payment.

> **The wrong implementation is the one that reads most naturally, so it is prohibited first.** *"Payment received,
> so this charge is due in 15 days"* produces a **separate due date per student payment**. A library taking 100
> payments across August would owe 100 obligations on up to 100 different dates, each with its own dunning clock.
> That is not a billing cycle; it is 100 micro-invoices. `SAAS-XC-012` forbids it explicitly.

### 6A.1 The billing period boundary — stated explicitly, because the brief requires it

`SAAS-FR-019` — The platform **MUST** group accrued Platform Charge obligations into a **billing period**. A billing
period is a **closed inclusive interval of calendar dates** in the tenant's timezone.

`SAAS-FR-020` — A billing period **MUST** be bounded by consecutive occurrences of the configured **due day**, such
that the period **ends on the day before** the due day and **begins on the due day of the preceding month**. With the
default due day of the **15th**, the period is **`[15th of month M, 14th of month M+1]`**, and the charges accrued in
it fall due on the **15th of month M+1**.

`SAAS-FR-021` — An obligation **MUST** be assigned to the billing period containing its **accrual date**, and that
assignment **MUST** be immutable once made.

`SAAS-INV-006` — Every accrued obligation belongs to **exactly one** billing period. No obligation is unassigned, and
none appears in two.

`SAAS-BR-010` — Worked example, normative. Due day = **15th**. A student pays on **3 August**, another on **8
August**, another on **17 August** and another on **27 August**:

| Payment date | Billing period | Falls due |
|---|---|---|
| 3 August | `[15 Jul, 14 Aug]` | **15 August** |
| 8 August | `[15 Jul, 14 Aug]` | **15 August** |
| 17 August | `[15 Aug, 14 Sep]` | **15 September** |
| 27 August | `[15 Aug, 14 Sep]` | **15 September** |

**Charges accumulate into the period. They do not each start a 15-day clock.** The 3 August and 8 August charges
share one due date; the 17 August and 27 August charges share the next.

`SAAS-XC-012` — Deriving a due date as *"accrual date + 15 days"*, or as any fixed offset from an individual student
payment. **A due date is a property of the billing period, never of a single payment.**

> **Why the boundary is stated as an explicit formula rather than left to implementation.** The brief requires that
> *"the exact billing-period boundary MUST be explicitly defined."* Two plausible readings exist — a period ending
> **on** the due day, or ending **the day before** it — and they disagree about which period a payment made *on the
> 15th* belongs to. `SAAS-FR-020` resolves it: the due day **opens** a period and closes the previous one, so a
> payment on 15 August is in `[15 Aug, 14 Sep]` and is **not** due that same morning. A charge accruing hours before
> its own due date would otherwise be instantly overdue.
>
> **Month-end is deliberately not assumed.** The brief says *"do NOT assume month-end."* The 15th is the **default**
> for a configurable day, and nothing here derives a boundary from the last day of a month.

### 6A.2 Due days that do not exist in every month

`SAAS-GAP-007` — **A configured due day above 28 has no defined behaviour in February.** If the due day is
configurable across the full range 1-31, then days 29, 30 and 31 do not occur in every month, and this document
**does not decide** whether such a period ends early, rolls forward, or whether the range is simply capped at 28.
Frozen `PRD-005` `MM-FR-059` avoids the identical problem by using **day arithmetic only** — *"there is **no** 'same
day next month' rule and therefore no undefined 31 → 30 February case"* — but a calendar **due day** is exactly a
*"same day next month"* rule, so that escape is unavailable here. **Recorded rather than guessed**, and it is the
reason `SAAS-FR-022` declares no range. See §12.

### 6A.3 Changing the due day — no silent retroactive movement

`SAAS-FR-022` — The due day **MUST** be a **platform-scoped configurable value** with a default of the **15th**,
changeable only by an authorised platform actor (`PR-1`) through the authorised platform configuration mechanism. A
Library Owner (`TR-1`), a Library Manager (`TR-2`) and every other tenant actor **MUST NOT** be able to change it.

`SAAS-FR-023` — A change to the due day **MUST NOT** alter the due date of any **already-generated** statement, and
**MUST NOT** alter the billing-period assignment of any already-accrued obligation. It applies to periods beginning
**after** the change becomes effective.

`SAAS-FR-024` — A change to the due day **MUST NOT** reset, clear, recompute or discharge any Outstanding Platform
Charge. Outstanding balances survive a configuration change untouched.

`SAAS-INV-007` — For every generated statement, `dueDate` is **immutable** once generated.

`SAAS-XC-013` — Retroactively moving the due date of a historical obligation or statement, **including by a Platform
Administrator**, and **including** as an incidental effect of changing the configured day.

`SAAS-XC-014` — Resetting or zeroing an outstanding balance as a side effect of a due-day change.

> **`SAAS-FR-024` and `SAAS-XC-014` exist because the brief asks for them explicitly** — *"do NOT reset outstanding
> when the date changes."* They are separated from `SAAS-FR-023` deliberately: `SAAS-FR-023` protects the **date**,
> `SAAS-FR-024` protects the **money**. An implementation that regenerated statements on a configuration change could
> satisfy the first and violate the second.
>
> **The non-retroactivity principle is not invented here.** Frozen `PRD-005` `MM-FR-064` already holds that a
> timezone change *"**MUST NOT** retroactively alter the `startDate` or `endDate` of any existing membership"*, and
> `SAAS-BR-009` already applies the same rule to the trial duration. `SAAS-FR-023` is the third application of an
> established principle, not a new one.

### 6A.4 The statement — what every billing period must preserve

`SAAS-FR-025` — For each billing period in which a library accrued at least one obligation, the platform **MUST**
generate a **statement** preserving, at minimum: the **billing period** boundaries; the **rate applied**; the
**charge amount**; the **generation date**; the **due date**; the **status**; and the **settlement history** against
it.

`SAAS-INV-008` — A statement's billing period, rate, amount, generation date and due date are **immutable** once
generated. A correction is a **new** record referencing the original; nothing is edited in place.

`SAAS-BR-011` — A statement **MUST** preserve the **rate applied per obligation**, not a single period-level rate. If
the rate changes mid-period, obligations either side of the change keep their own rates (`SAAS-FR-005`,
`SAAS-INV-002`) and the statement total is their sum, **not** the period's collection total times the current rate.

`SAAS-XC-015` — Recomputing a historical statement's total from the **current** configured rate.

> **`SAAS-BR-011` is where historical-rate immutability and billing periods interact, and where a plausible
> implementation breaks both.** A statement that stores one `rateApplied` for the period, then displays
> `collections × rate`, is simpler and wrong: it silently restates every obligation accrued before a rate change.
> `SAAS-INV-002` already forbids the arithmetic; `SAAS-BR-011` forbids the **statement shape** that invites it.

**No schema is defined.** `SAAS-FR-025` states the facts a statement must **preserve**, not the tables, columns or
types that preserve them — the same restraint `SAAS-FR-015` applies to audit records.

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

## 7A. The library's Platform Charge view

`SAAS-FR-026` — An authorised library actor **MUST** be able to see, for their own library: the **Platform Charge**;
the **billing period** it belongs to; the **outstanding** amount; the **due date**; the amount already **paid**; the
**settlement status**; and the **settlement history**.

`SAAS-FR-027` — Every figure presented **MUST** be the **server-derived** value. A client **MUST NOT** compute,
recompute or adjust any Platform Charge, outstanding balance or due date for display.

`SAAS-FR-028` — The view **MUST** be fully populated for a library whose student collections are **100% cash** and
whose online collections are **zero**. No figure may be blank, zero-by-default, or unavailable because no online
payment exists.

`SAAS-BR-012` — The view **MUST NOT** present a student-facing figure: no student's dues, balance, receipt amount or
`FeeLedger` balance appears on it, and no Platform Charge appears on any student-facing surface (`SAAS-XC-003`).

`SAAS-AC-022` — For a library with 100 confirmed cash collections and zero online collections, all seven facts in
`SAAS-FR-026` are present and non-empty.

`SAAS-AC-023` — A client-side alteration of a displayed outstanding figure does not change the server-derived value,
and a settlement submitted against the altered figure is rejected (`SAAS-AC-004`).

> **`SAAS-FR-028` is the requirement most likely to be satisfied on paper and broken in practice.** A view built from
> an online-payments feed shows a cash-only library **zeros**, or an empty state reading *"no transactions"* — while
> the library genuinely owes ₹1,500. The figures must derive from **confirmed collections** (`SAAS-FR-002`),
> irrespective of the channel the collection arrived through, which is also why `SAAS-AC-022` is written against the
> cash-only library rather than a mixed one. **The harder case is the acceptance test.**

> **No screen, layout, route, widget or navigation entry is specified.** `SAAS-FR-026` states the facts that must be
> **available to an authorised actor**; where they appear is an application concern. The **authorisation** for viewing
> is `SAAS-FR-007`'s and remains subject to the same closed-catalogue problem as everything else in §9 — **viewing**
> is supportable under `TR-1`'s *"financial and revenue visibility"* (`prd-v2/02` **L159**), which **settlement** is
> not. That asymmetry is deliberate and is not smoothed over.

---

## 7B. The two load tests, worked

**Neither test is hypothetical.** Both are arithmetic over the requirements above, recorded so that an implementation
can be checked against them and so that a future pass cannot quietly reintroduce an online-payment assumption.

### 7B.1 Test 1 — the 100%-cash library

**Setup:** 100 memberships × **₹500**, **all cash**, all confirmed server-side per `SAAS-FR-002`. Rate **3%**. Due day
**15th**. All collections accrue in one billing period.

| Quantity | Value | Derived from |
|---|---|---|
| Student → library revenue (`BC-05`) | **₹50,000** | `BC-05` truth. **Not this document's figure** |
| Online student payments | **₹0** | — |
| Platform Charge per collection | **₹15** | `SAAS-BR-002` — ₹500 × 3% |
| Platform Charge obligation total | **₹1,500** | `SAAS-FR-006` — 100 × ₹15 |
| Settled | **₹0** | no settlement yet |
| **Outstanding Platform Charge** | **₹1,500** | `SAAS-FR-006` — accrued less verified settlements |
| Due | **15th of the following month** | `SAAS-FR-020`, `SAAS-BR-010` |
| Lawful settlement path exists | **Yes** | `SAAS-FR-009` — settlement **MUST NOT** depend on any online student payment |
| Net-off available | **Not applicable** — and not required | `SAAS-BR-005` — net-off **MUST NOT** be the only mechanism |

`SAAS-AC-024` — With 100 confirmed cash collections of ₹500 and **zero** online collections: student revenue reads
**₹50,000**, the Platform Charge obligation reads **₹1,500**, online collections read **₹0**, outstanding reads
**₹1,500**, and a settlement path is available that reads no online-collection figure.

**What the test proves, and what it does not.** It proves the **obligation is created and tracked** without any online
payment, and that the outstanding figure is correct and payable. It does **not** prove the money can be moved: the
rail direction is `SAAS-GAP-003` and the authority is `SAAS-GAP-004`. **Both remain open, and this test does not close
them.**

### 7B.2 Test 2 — the mixed library

**Setup:** 100 memberships × **₹500** = **₹50,000**. **60 cash**, **40 online**. Rate **3%**.

| Quantity | Value | Note |
|---|---|---|
| Student → library revenue | **₹50,000** | one figure, **not** split by channel |
| Cash collections | **₹30,000** (60 × ₹500) | `BC-05` |
| Online collections | **₹20,000** (40 × ₹500) | `BC-05` |
| Platform Charge — cash-originated | **₹900** (60 × ₹15) | `SAAS-FR-002` |
| Platform Charge — online-originated | **₹600** (40 × ₹15) | `SAAS-FR-002` |
| **Total obligation** | **₹1,500** | **identical to Test 1** |
| Outstanding | **₹1,500** | `SAAS-FR-006` |

`SAAS-AC-025` — For an identical collection total, the Platform Charge obligation is **₹1,500** whether collections
are 100% cash, 100% online, or any mixture. The **channel does not change the charge**.

`SAAS-BR-013` — The Platform Charge **MUST** be computed identically for a confirmed cash collection and a confirmed
online collection. Channel **MUST NOT** be an input to the rate, the amount, the billing period or the due date.

`SAAS-AC-026` — In a mixed library, a settlement is available that does **not** require net-off, and net-off — where
the authorised arrangement supports it — is available for the online portion **only as an option**, never as the sole
mechanism (`SAAS-BR-005`).

**The two truths stay separate throughout.** In both tests:

| | Student → library | Library → LIBOORA |
|---|---|---|
| Amount | ₹50,000 | ₹1,500 |
| Owner | `BC-05` / `PRD-008` | `BC-20` / this document |
| Model, table, ledger, metric | **separate** | **separate** |
| Effect of settling ₹1,500 | **none — byte-identical** (`SAAS-AC-001`) | outstanding → ₹0 |

`SAAS-AC-027` — After settling ₹1,500 in either test, the student-revenue figure still reads **₹50,000**, every
`FeeLedger` balance is unchanged, and no receipt amount has moved.

> **Why Test 2 is not simply Test 1 with different inputs.** A design that nets the Platform Charge off online
> collections produces the *same* ₹1,500 total and *looks* correct here — while being unable to serve Test 1 at all.
> Running both is what exposes that: **identical totals, different mechanisms, and only one of the two mechanisms
> works for every library.** `SAAS-BR-013` states the invariance as a rule so that a channel-sensitive computation is
> a specification violation rather than a discovered surprise.

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
>
> **⚠ Amended at v0.2 — the scope claim above was too loose in one respect.** The **3-day renewal protection** window
> is now known to turn on **`Q-01`** — *"does an expired membership release the seat immediately, at end-of-day, or
> after a grace period?"* — whose owners are the **Architecture Owner and the `BC-04` owner**, not `BC-25`. `BC-25`
> enters **only if** the window is made configurable, which
> [`ADR-0036`](../../00-governance/adr/ADR-0036-three-day-renewal-protection-q01.md) (`PROPOSED`) deliberately does
> **not** propose: `CONFIGURATION_GUIDE.md` §5 requires *"an ADR **and** a PRD amendment"* to promote a structural
> fact to configurable, and no `SEAT-CFG-*` identifier exists for it.
>
> **The row is otherwise correct and is retained:** the window is **not** a platform-level parameter, it is **not**
> this document's to specify, and `PR-1` has no authority over it. **`SAAS-AC-005` is unaffected.** What is corrected
> is only the naming of the deciding authority — recorded rather than quietly restated, because `PRD-008` §39.2 made
> the *opposite* error about the same requirement and had to be retracted at its v1.0.
>
> **This document does not specify a protection window, does not allocate an identifier for one, and does not price
> one.** The window computes no money, so no Platform Charge, statement, billing period or due date is affected by
> it — which is why it changes nothing in §§4-7B.

---

## 12. Governance gap ledger

**7 gaps. 7 block Stage 4. 7 block Freeze.** None is closed by a plausible solution; each names an authority.

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

### `SAAS-GAP-007` — A configured due day above 28 has no defined February behaviour

| Field | Value |
|---|---|
| **Question** | If the due day is configurable, what happens when the configured day (29, 30, 31) does not occur in a month? Does the period end early, roll forward, or is the range capped at 28? |
| **Why it is not decided here** | It is a **calendar-semantics** decision with customer-visible consequences for the due date, and `SAAS-GAP-002` already records that **no configurable range is declared** for any value in this document. Frozen `PRD-005` `MM-FR-059` sidesteps the identical problem by using *"day arithmetic alone"* so that *"there is **no** 'same day next month' rule"* — but a calendar **due day** is precisely such a rule, so that escape does not transfer |
| **Classification** | **REQUIRES PRODUCT OWNER** (+ `BC-25` for the range) |
| **Blocks** | Stage 4 ✅ · Freeze ✅ |

> **The safe default is already in force and costs nothing:** the **15th** occurs in every month, so the V1 default is
> unaffected. The gap blocks only the *configurability* of days 29-31, which nothing yet requires.

### 12.1 Gap summary

| Gap | Subject | Authority | Blocks Stage 4 | Blocks Freeze |
|---|---|---|---|---|
| `SAAS-GAP-001` | Platform Charge eligibility base | Product Owner | ✅ | ✅ |
| `SAAS-GAP-002` | Configurable ranges + parameter ids | Product Owner + `BC-25` | ✅ | ✅ |
| `SAAS-GAP-003` | Outbound remittance shape on the rail | Architecture Owner | ✅ | ✅ |
| `SAAS-GAP-004` | Settlement permission for any role | Authorization Owner + Product Owner | ✅ | ✅ |
| `SAAS-GAP-005` | Trial eligibility identity | Architecture Owner + `PRD-001` | ✅ | ✅ |
| `SAAS-GAP-006` | Stage 3 not performed | Architecture Owner | ✅ | ✅ |
| `SAAS-GAP-007` | Due day above 28 in February | Product Owner + `BC-25` | ✅ | ✅ |

**7 gaps. 7 block Stage 4. 7 block Freeze. Re-derived at v0.3 from each gap block's own `Blocks` row — unchanged.**

> **Every gap blocks, and that is the honest result of a first draft rather than a pessimistic one.** A V1 module
> whose central action cannot be authorised by any existing role, whose configurable values have no registered
> identifiers, and whose settlement direction has no described shape is not close to implementable. Recording fewer
> blockers would make this document look more finished than the platform is.

---

### 12.2 The v0.3 conferral — what it ratified, and why no gap closed *(added v0.3)*

Six decisions were given that bear on this document. Each is mapped to the identifier it touches and to the gap it
does **not** close. **The distinction being drawn throughout is between a *value* and a *mechanism*.**

| Decision given | What it ratifies here | Gap it does **not** close |
|---|---|---|
| **Platform Charge = 3% default** | `SAAS-BR-001`'s default, already written | **`SAAS-GAP-001`** — 3% *of what*? The eligible collection base still depends on `PRD-008` `FEE-GAP-004`'s undecided fee-type taxonomy. **A rate without a base computes nothing** |
| **Rate changes affect FUTURE transactions only; historical charges immutable** | The immutability this document already required | **`SAAS-GAP-002`** — still **no range**, **no minimum, no maximum**, and **no `CFG-*`/`LCFG-*`/`ICFG-*` identifier**. `CONFIGURATION_GUIDE.md` §5 requires *a PRD amendment* plus `BC-25` allocation, and neither is done here |
| **Settlement due day = 15th; changeable among 10/15/25 for future periods; existing obligations never move** | The **15th** default and the never-move rule | **`SAAS-GAP-007`** is **narrowed to nothing, and it still blocks.** All of 10, 15 and 25 occur in **every month**, so the February problem cannot arise from this enumeration — but the gap asks what happens **if the day is configurable to 29–31**, and the decision **restricted the set without saying the set is closed**. ⚠ **This document does NOT read a three-value enumeration as a closed range**: `SAAS-GAP-002` records that **no range is declared for any value here**, and turning an example list into an invariant is exactly the inference `X-13` forbids |
| **Free trial = 14 days default, Platform Owner/Admin configurable** | `SAAS-BR-011`'s 14-day default | **`SAAS-GAP-005`** — a duration is not an **identity**. Which authoritative identity anchors eligibility across tenant deletion and recreation is untouched, and `CFG-10` remains **Authentication's** parameter, not `BC-20`'s. **`SAAS-GAP-002`** also survives: *"configurable"* still has **no identifier and no range** |
| **`BC-20`/`PRD-022` owns the Platform Charge and settlement lifecycle** | §1's ownership claim, and `PRD-008` `FEE-GAP-014`/`017` route here | **`SAAS-GAP-003`** — ownership of a lifecycle is not a **described shape** for the movement. Every flow BC Map **L382** describes is LIBOORA **pulling** (`PaymentAttempt`, `DunningState`); a library **pushing** appears nowhere, and whether `E-25` → `BC-31` may carry it is the **Architecture Owner's** to say. **No provider, endpoint, schema, bank-account structure, UPI flow, new edge, new port or new aggregate is invented here** |
| **Cash-only libraries MUST have an independent settlement method; net-off cannot be the only one** | `SAAS-FR-009` recommendation 5, and `PRD-008` `FEE-GAP-017` recommendation 5 — **the same requirement stated in two documents, in the same direction, now decided** | **`SAAS-GAP-003` and `SAAS-GAP-004` together.** *"There must be an independent method"* is a **requirement to have a mechanism, not a mechanism.** And even once one exists, **`SAAS-GAP-004` denies it**: `AUTH-7.22` holds the permission catalogue **closed**, `grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` returns **0**, and `AP-9` **fails closed** — so a settlement is refused for **`TR-1` Owner** as well as `TR-2`. **The mandate is now in force and remains unexecutable until a permission is enumerated** |

> **The one thing that got harder, recorded because it would be easier to omit.** Decision 8 makes an independent
> cash settlement **mandatory**, and `SAAS-GAP-004` shows **no role can perform it**. Before the conferral that was a
> missing capability; now it is a **mandatory capability that fails closed**. **That is a worse position on paper and
> a better one in fact** — an obligation with a named owner is auditable, while an unstated need is not — but this
> document does not present the change as progress toward implementability.

> **Not done here, deliberately:** no `SAAS-*` identifier added, renumbered or deleted · no gap closed, downgraded or
> merged · no permission, parameter, range, endpoint, schema or provider invented · **Stage 3 still not performed**
> (`SAAS-GAP-006`) · registry status unchanged · **not frozen** · no frozen document touched · no code written.

---

## 13. Acceptance criteria

**31 criteria, `SAAS-AC-001` … `SAAS-AC-031`.** Each is *verified by* a test; none is an obligation.

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
| `SAAS-AC-022` | For a library with 100 confirmed cash collections and zero online collections, all seven `SAAS-FR-026` facts are present and non-empty |
| `SAAS-AC-023` | A client-side alteration of a displayed outstanding figure does not change the server-derived value, and a settlement against it is rejected |
| `SAAS-AC-024` | 100 cash collections of ₹500, zero online: revenue ₹50,000 · obligation ₹1,500 · online ₹0 · outstanding ₹1,500 · a settlement path reads no online figure |
| `SAAS-AC-025` | An identical collection total yields ₹1,500 whether 100% cash, 100% online, or mixed |
| `SAAS-AC-026` | In a mixed library a settlement is available that does not require net-off |
| `SAAS-AC-027` | After settling ₹1,500, student revenue still reads ₹50,000, every `FeeLedger` balance is unchanged, and no receipt amount moved |
| `SAAS-AC-028` | Charges accrued on 3 and 8 August share one due date; charges accrued on 17 and 27 August share the next; no charge is due 15 days after its own payment |
| `SAAS-AC-029` | Every accrued obligation belongs to exactly one billing period |
| `SAAS-AC-030` | Changing the configured due day leaves every already-generated statement's due date, every billing-period assignment and every outstanding balance unchanged |
| `SAAS-AC-031` | A statement whose period spans a rate change totals the sum of per-obligation amounts, not collections × current rate |

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
| `SAAS-FR-019` | `SAAS-AC-029` | |
| `SAAS-FR-020` | `SAAS-AC-028` | |
| `SAAS-FR-021` | `SAAS-AC-029` | |
| `SAAS-FR-022` | — | ⛔ **UNTRACED** — no range declared; blocked on `SAAS-GAP-002` and `SAAS-GAP-007` |
| `SAAS-FR-023` | `SAAS-AC-030` | |
| `SAAS-FR-024` | `SAAS-AC-030` | |
| `SAAS-FR-025` | `SAAS-AC-031` | |
| `SAAS-FR-026` | `SAAS-AC-022` | |
| `SAAS-FR-027` | `SAAS-AC-023` | |
| `SAAS-FR-028` | `SAAS-AC-022` | |
| `SAAS-BR-001` | — | ⛔ **UNTRACED** — a terminology rule; verified by review, not by test |
| `SAAS-BR-002` | `SAAS-AC-006`, `SAAS-AC-007` | |
| `SAAS-BR-003` | `SAAS-AC-008` | |
| `SAAS-BR-004` | `SAAS-AC-001` | |
| `SAAS-BR-005` | `SAAS-AC-016` | |
| `SAAS-BR-006` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-BR-007` | `SAAS-AC-019` | |
| `SAAS-BR-008` | `SAAS-AC-018` | |
| `SAAS-BR-009` | — | ⛔ **UNTRACED** — blocked on `SAAS-GAP-005` trial identity |
| `SAAS-BR-010` | `SAAS-AC-028` | |
| `SAAS-BR-011` | `SAAS-AC-031` | |
| `SAAS-BR-012` | `SAAS-AC-021` | |
| `SAAS-BR-013` | `SAAS-AC-025` | |
| `SAAS-INV-001` | `SAAS-AC-008` | |
| `SAAS-INV-002` | `SAAS-AC-008`, `SAAS-AC-009` | |
| `SAAS-INV-003` | `SAAS-AC-017` | |
| `SAAS-INV-004` | `SAAS-AC-013` | |
| `SAAS-INV-005` | `SAAS-AC-020` | |
| `SAAS-INV-006` | `SAAS-AC-029` | |
| `SAAS-INV-007` | `SAAS-AC-030` | |
| `SAAS-INV-008` | `SAAS-AC-031` | |
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
| `SAAS-XC-012` | `SAAS-AC-028` | |
| `SAAS-XC-013` | `SAAS-AC-030` | |
| `SAAS-XC-014` | `SAAS-AC-030` | |
| `SAAS-XC-015` | `SAAS-AC-031` | |

**Measured coverage:**

| Register | Allocated | Traced | Untraced (all ⛔ BLOCKED or review-verified) |
|---|---|---|---|
| `SAAS-FR-*` | 28 | 23 | `SAAS-FR-007`, `SAAS-FR-010`, `SAAS-FR-011`, `SAAS-FR-017`, `SAAS-FR-022` |
| `SAAS-BR-*` | 13 | 11 | `SAAS-BR-001`, `SAAS-BR-009` |
| `SAAS-INV-*` | 8 | 8 | — |
| `SAAS-XC-*` | 15 | 14 | `SAAS-XC-006` |
| **Total** | **64** | **56** | **8 = 87.5%** |

**This does not meet the 100% bar** that `PRD-006` cleared (285/285), and it is not presented as if it might.
**At v0.2 coverage moved from 36/43 = 83.7% to 56/64 = 87.5%** — it rose because the eleven new obligations
arrived with criteria attached, and **one new untraced obligation** (`SAAS-FR-022`, the due-day configurable) was
added rather than hidden, because `SAAS-GAP-007` blocks it.
**Five** of the 8 are blocked on named gaps; **three** (`SAAS-BR-001`, `SAAS-XC-006`, and the review half of
`SAAS-FR-007`) are prohibitions on documentation and terminology that a runtime test cannot verify. Manufacturing
criteria for those would raise the percentage without raising the assurance — the same inflation this repository has
refused before.

---

## 15. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.2** | 2026-08-05 | **Billing period, calendar due date, the library view and the two load tests specified; the renewal-protection authority corrected.** Registers move **70 → 102**: `SAAS-FR-*` 18 → **28**, `SAAS-BR-*` 9 → **13**, `SAAS-INV-*` 5 → **8**, `SAAS-XC-*` 11 → **15**, `SAAS-AC-*` 21 → **31**, `SAAS-GAP-*` 6 → **7**; obligation-bearing 43 → **64**; traceability **56/64 = 87.5%** (up from 83.7%, and **every figure recomputed from the document rather than incremented by hand**). **New §6A defines the billing period explicitly, as the brief requires:** a closed inclusive interval bounded by consecutive due days — `[15th of M, 14th of M+1]` at the default — with `SAAS-XC-012` **forbidding** the natural-but-wrong *"accrual date + 15 days"* derivation, which would give a 100-payment month up to 100 separate due dates. **The boundary ambiguity is resolved rather than left open:** the due day **opens** a period and closes the previous one, so a payment on the 15th is not due the same morning. **Month-end is not assumed.** Due day is **platform-scoped, default the 15th, `PR-1` only** (`SAAS-FR-022`), and a change is **non-retroactive in two separate ways** — `SAAS-FR-023` protects the **date**, `SAAS-FR-024` the **money**, because an implementation could satisfy one and violate the other; `SAAS-XC-013`/`SAAS-XC-014` state both as exclusions. The non-retroactivity principle is the **third** application of frozen `MM-FR-064`'s, not a new one. **`SAAS-FR-025` defines the statement's preserved facts** — period, rate, amount, generation date, due date, status, settlement history — with `SAAS-BR-011` forbidding a **period-level rate**, the statement shape that would silently restate obligations accrued before a rate change. **New §7A** gives the library view all seven required facts, **server-derived only**, and `SAAS-FR-028` requires it to be **fully populated for a 100%-cash library** — the case an online-payments feed renders as zeros. **New §7B works both load tests as arithmetic:** 100% cash → ₹50,000 revenue, ₹1,500 obligation, ₹0 online, ₹1,500 outstanding, lawful path independent of any future online collection; mixed 60/40 → the **identical** ₹1,500, with `SAAS-BR-013` making channel-invariance a rule so a channel-sensitive computation is a violation rather than a surprise. **What the tests do NOT prove is stated**: the rail direction (`SAAS-GAP-003`) and the authority (`SAAS-GAP-004`) stay open. **One correction, declared:** §11's note named `BC-25` as the renewal-protection authority; the deciding question is **`Q-01`**, owned by the **Architecture Owner + `BC-04` owner**, with `BC-25` involved only if the window is made configurable — which **`ADR-0036`** (`PROPOSED`) deliberately does not propose, since `CONFIGURATION_GUIDE.md` §5 requires *"an ADR **and** a PRD amendment"* and no `SEAT-CFG-*` exists. The rest of the row was right and is retained. **One new gap, `SAAS-GAP-007`** — a due day above 28 has no defined February behaviour; the **15th default is unaffected**, so the gap blocks only configurability. **7 gaps, all 7 blocking Stage 4 and Freeze.** **Nothing invented:** no bounded context (still **31**), no `CFG-*`/`LCFG-*`/`ICFG-*`/`SEAT-CFG-*` identifier, no permission, no role, no schema, no table, no screen, no route, no provider, no rail, no endpoint, no configurable **range**. **Nothing closed:** all six prior gaps remain open, Stage 3 is still not performed (`SAAS-GAP-006`), and this document is **NOT frozen and NOT approved**. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no ADR was accepted; no Dart source was touched. |
| **v0.1** | *(the first draft)* | **First draft. Stage 2 only.** Created to give `BC-20` the PRD it has been registered for since the register was created, and to be the lawful home for three findings that terminated outside their own module: **`FEE-GAP-014`** (the platform charge has no owning document), **`FEE-GAP-017`** (a cash-only library has no lawful way to pay) and the unspecified **SaaS free trial**. **Authorisation checked before authoring, not assumed:** Master PRD **L169** §8 module 17, `PRD_REGISTRY.md` **L326** (`V1`, `PLANNED`) and **L427** (§6, `BC-20` → `PRD-022`, uncontested) — and the registry's own §4.3 note names `BC-20` **module 17** *as the precedent* it used to register `PRD-023`, so authoring this applies an established mechanism rather than a new one. **Prefix collision-checked** per `PRD_LIFECYCLE.md` §5 rule 2: `SAAS-*` measured **0** pre-existing identifiers. **Terminology decision applied:** *Platform Charge* replaces *commission* in all new text — measured **0** pre-existing occurrences of *Platform Charge*, and the financial sense of *commission* confined to **three non-frozen** documents (`PRD-008`, its alignment record, `ADR-0035`), every other occurrence in the repository being the English verb. **The transition is forward-only and no historical text was rewritten** — editing the vocabulary of a decision record destroys the ability to audit what was known when, and **no frozen document uses the financial sense at all**. **Product decisions applied:** Platform Charge default **3%** (`SAAS-FR-001`), free trial default **14 days** (`SAAS-FR-017`), historical-rate immutability (`SAAS-FR-005`, `SAAS-BR-003`, `SAAS-INV-002` — ₹15 stays ₹15 when the rate becomes 2.5%), cash-only settlement as a **first-class V1 requirement** (`SAAS-FR-009`) with net-off explicitly **not** the only mechanism (`SAAS-BR-005`), three settlement states, server-side verification only (`SAAS-FR-013`), idempotency (`SAAS-FR-014`), and eight-fact auditability (`SAAS-FR-015`). **The `MP-GBR-24` boundary is stated as mirror-image prohibitions** (`SAAS-XC-001`…`004`, `SAAS-XC-010`) so that both sides of the boundary forbid the crossing rather than only `BC-05`. **Nothing was invented:** no bounded context, no `BC-32`, no dependency edge, no port, no endpoint, no webhook schema, no signature algorithm, no retry policy, no database schema, no queue, no payment provider, no settlement rail, no bank-account structure, no UPI flow, no tax rate, no gateway charge, no permission identifier, no role, no configuration identifier and no configurable range. **The hardest finding is recorded rather than solved:** `AUTH-7.22` closes the permission catalogue, **0** `PERM-*` identifiers exist repository-wide, and `AP-9` fails closed — so a settlement is refused **for `TR-1` Owner too**, not merely for `TR-2` Manager, and `X-13` makes naming a permission here *"a security defect that passes its own tests."* **Six gaps, all six blocking Stage 4 and Freeze**, each with a named authority. **Traceability reported honestly at 36/43 = 83.7%**, below the 100% bar, with four blocked on gaps and three verifiable only by review. **Stage 3 has NOT been performed** (`SAAS-GAP-006`) and this document is **NOT frozen and NOT approved**. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no ADR was authored or accepted; no Dart source was touched. |

---

*End of `PRD-022_SAAS-BILLING.md` **v0.2 — DRAFT**. Not frozen. Not approved. Not architecture-reviewed.*
