# `PRD-022` — SaaS Billing & Platform Revenue

| Field | Value |
|---|---|
| **PRD** | `PRD-022` |
| **Bounded context** | **`BC-20` Subscription & Billing** — `[GENERIC]`, Business layer, **V1** |
| **Version** | ⭐ **v0.4.5 — DRAFT** (subject amendments under [`DP-0006`](../../00-governance/decisions/DP-0006-product-owner-decision-saas-gap-001-platform-charge-eligibility-base.md), [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md), [`DP-0008`](../../00-governance/decisions/DP-0008-configuration-owner-decision-saas-gap-002-d4-identifier-allocation-route.md) and the CONFERRED Stage 3 alignment record, 2026-09-25: `SAAS-GAP-001`/`002`/`007` decided/resolved; `SAAS-CFG-*` register declared + parameters declared + identifiers allocated (acts a–d); `SAAS-GAP-006` subject-reconciled to the already-CLOSED alignment record; ⛔ no new decision, no identifier invented) |
| **Status** | **`DRAFT`** — Stage 3 CONFERRED of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) performed (ALIGNED 6/6, Architecture Owner, V1 scope only). **NOT frozen. NOT approved.** ⭐ **Stage 3 CONFERRED ALIGNED 6/6** ([`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0). ⚠ **`SAAS-GAP-001` DECIDED 2026-09-25 (`DP-0006`)** · ⭐ **`SAAS-GAP-002` FULLY RESOLVED 2026-09-25** — ranges limb by `DP-0007` (rate 1–5% · trial 7–30 days · due-day closed set {10, 15, 25}); D-4 identifier-allocation limb by `CONFIGURATION_GUIDE.md` §2D under `DP-0008` Route A (`SAAS-CFG-001`/`002`/`003` allocated) · ⭐ **`SAAS-GAP-007` RESOLVED BY ELIMINATION (`DP-0007`)** · ✅ **`SAAS-GAP-006` CLOSED** (Stage 3 CONFERRED; subject cell reconciled 2026-09-25) · ⚠ **`SAAS-GAP-005` remains OPEN** (V1 blocker, count now 1) |
| **Authorised by** | `MASTER_PRD.md` **L169** — §8 **module 17**, *"SaaS Billing \| `BC-20` Subscription & Billing \| `[GENERIC]` \| V1"* · `PRD_REGISTRY.md` **L326** (`PRD-022`, `V1`, `PLANNED`) · `PRD_REGISTRY.md` **L427** (§6: `BC-20` → `PRD-022`, **not contested**) |
| **Identifier prefix** | `SAAS-*` — collision-checked against every existing register before use (`PRD_LIFECYCLE.md` §5 rule 2). Measured **0** pre-existing `SAAS-*` identifiers repository-wide |
| **Owns money** | **Library → LIBOORA only.** Every obligation in this document is money a **library owes LIBOORA** |
| **Owns NO student money** | This document defines **no** student fee, payment, receipt or ledger. That is `BC-05`/`PRD-008` |
| **Blocking governance gaps** | **7 gaps.** **5 block Stage 4 · 5 block Freeze for V1 purposes** (v0.4, `ADR-0130` re-classification) → ⭐ **Reconciled 2026-09-25 under `DP-0006`: `SAAS-GAP-001` DECIDED — now 4 block Stage 4 · 4 block Freeze for V1 purposes** (`SAAS-GAP-002`, `005`, `006`, `007` remain OPEN; `SAAS-GAP-003`/`004` remain V2/DEFERRED, ⛔ unchanged) → ⭐ **Reconciled 2026-09-25 (second amendment) under `DP-0007`: `SAAS-GAP-002` ranges limb DECIDED (rate 1–5%, trial 7–30 days, due-day closed set {10, 15, 25}) + `SAAS-GAP-007` RESOLVED BY ELIMINATION — now 3 block Stage 4 · 3 block Freeze for V1 purposes** (`SAAS-GAP-002` still blocks on its **D-4 identifier-allocation limb** (`BC-25`/`PRD-023` act, explicitly excluded from the `DP-0007` approval); `SAAS-GAP-005`/`006` remain OPEN; `SAAS-GAP-007` leaves the blocking set; `SAAS-GAP-003`/`004` remain V2/DEFERRED, ⛔ unchanged) → ⭐ **Reconciled 2026-09-25 (third amendment, `DP-0008` act (d)): `SAAS-GAP-002` D-4 identifier-allocation limb RESOLVED — `SAAS-CFG-001`/`002`/`003` allocated in `CONFIGURATION_GUIDE.md` §2D (v1.3) under `DP-0008` Route A; `SAAS-GAP-002` now FULLY RESOLVED (both limbs closed), leaves the V1-blocking set; now 2 block Stage 4 · 2 block Freeze for V1 purposes** (remaining V1 blockers: exactly `SAAS-GAP-005` and `SAAS-GAP-006`; `SAAS-GAP-003`/`004` remain V2/DEFERRED, ⛔ unchanged) → ⭐ **Reconciled 2026-09-25 (fourth amendment — `SAAS-GAP-006` subject reconciliation): `SAAS-GAP-006`'s §12 cell and §12.1 row now reflect the already-CLOSED alignment record** — the Stage 3 review was performed and its verdict CONFERRED (ALIGNED 6/6) by [`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0 (Architecture Owner, single-act conferral); this amendment is the **subject reconciliation of that recorded closure**, not a new decision. `SAAS-GAP-006` leaves the V1-blocking set; now **1 block Stage 4 · 1 block Freeze for V1 purposes** (remaining V1 blocker: exactly `SAAS-GAP-005` — trial-eligibility identity, Architecture Owner + `PRD-001`; `SAAS-GAP-003`/`004` remain V2/DEFERRED, ⛔ unchanged). ✅ **At v0.3 the platform-charge and settlement DEFAULTS this document already carried were RATIFIED by direct conferral of authority by the human principal** — **3%** Platform Charge, future-only rate changes with **historical charges immutable**, settlement due day **15th** changeable among **10/15/25** for **future** periods with **existing obligations never moving**, **14-day** free trial, `BC-20`/`PRD-022` **confirmed as owner** of the Library → LIBOORA Platform Charge and settlement lifecycle, and **cash-only libraries MUST have an independent settlement method** (net-off may not be the only one). ⛔ **AND THE GAP COUNT DOES NOT MOVE: still 7 / 7 / 7** *(v0.3-era statement, retained verbatim — the v0.3 ratifications did not close a gap)*. §12 asks which *collections* accrue a charge (`SAAS-GAP-001` — ⭐ **DECIDED 2026-09-25 by [`DP-0006`](../../00-governance/decisions/DP-0006-product-owner-decision-saas-gap-001-platform-charge-eligibility-base.md)**: all confirmed `BC-05` collection fee types, i.e. `BC-05`'s existing confirmed-collection boundary, consuming `Accepted` `ADR-0039` §4 without re-enumeration), what the *ranges* are and which register allocates their *identifiers* (`SAAS-GAP-002` — ⭐ **ranges DECIDED 2026-09-25 by [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md)**: rate **1%–5%** · trial **7–30 days** · due-day **closed set {10, 15, 25}**; ⚠ **identifier allocation (D-4) still open, `BC-25`/`PRD-023` act**), whether the `E-25` rail can carry a **library-initiated outbound push** at all (`SAAS-GAP-003`, V2/DEFERRED), which **enumerated permission** lets **any** role settle (`SAAS-GAP-004` — **0** `PERM-*` identifiers exist repository-wide, so the action **fails closed even for `TR-1`**; V2/DEFERRED), which identity anchors trial eligibility (`SAAS-GAP-005`, still open), Stage 3 (`SAAS-GAP-006` — ✅ **CONFERRED 2026-09-25** by the Architecture Owner via [`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0; the §12 cell text is preserved as recorded), and February behaviour for days 29–31 (`SAAS-GAP-007` — ⭐ **RESOLVED 2026-09-25 BY ELIMINATION via `DP-0007`'s closed set**: no day above 28 is permitted, so the question has no remaining case). **A default being ratified is not a gap being closed, and this row refuses to convert one into the other — but a decision record is not a ratification: `DP-0006` *answers* the `SAAS-GAP-001` question and `DP-0007` *answers* the `SAAS-GAP-002`-ranges and `SAAS-GAP-007` questions §12 asked, and this row now records those answers.** See §12 |

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
| `SAAS-CFG-*` | Configurable parameter — ⭐ **DECLARED 2026-09-25 under [`DP-0008`](../../00-governance/decisions/DP-0008-configuration-owner-decision-saas-gap-002-d4-identifier-allocation-route.md) (Configuration Owner, Route A)** | **3** | `SAAS-CFG-001` … `SAAS-CFG-003` (⚠ **identifiers not yet allocated** — allocation is `CONFIGURATION_GUIDE.md` §5 act (c), pending) |
| **Total** | | **105** | |

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
>
> ⭐ **Register DECLARED 2026-09-25 under [`DP-0008`](../../00-governance/decisions/DP-0008-configuration-owner-decision-saas-gap-002-d4-identifier-allocation-route.md) (Configuration Owner, Route A):** this document now declares a **new `SAAS-CFG-*` register** — the owning-PRD-declares-its-register pattern of the `FIL-CFG-*`/`ADR-0057` precedent — with its **three members published up front** (per `PRD_LIFECYCLE.md` L82 rule 2–3), each with its `DP-0007`-decided range/default and platform scope (`PR-1`-mutable, per `SAAS-AC-005`):
>
> | Member | Parameter | Range (per `DP-0007`) | Default | Scope | Mutability |
> |---|---|---|---|---|---|
> | `SAAS-CFG-001`* | Platform Charge rate | **1%–5%** | **3%** | platform | `PR-1` only (`SAAS-AC-005`) |
> | `SAAS-CFG-002`* | SaaS free-trial duration | **7–30 days** | **14 days** | platform | `PR-1` only |
> | `SAAS-CFG-003`* | Billing due day | **closed set {10, 15, 25}** | **the 15th** | platform | `PR-1` only |
>
> ⚠ ***Identifier labels `SAAS-CFG-001`/`002`/`003` are the register's published range slots only — the identifiers are NOT yet allocated.* `CONFIGURATION_GUIDE.md` §5 L863: *"Adding a parameter — a **PRD amendment** — the specification declares what is configurable, this guide does not."* The allocation is act **(c)** of the `DP-0008` §4 sequence, performed by the Configuration Owner / guide owner **after** this declaration; until then the `SAAS-CFG-*` members are **declared, not allocated**. ⛔ **No value, range, default or scope was re-decided here** — all three are consumed verbatim from `DP-0007`. ⛔ **`PRD-023`'s `CNF-CFG-*` register remains 0** (`ADR-0017` L132: *"PRD-023 owns the resolution machinery, not the value list"* — the new register is admitted to that machinery **by reference**, not by a `PRD-023` amendment).

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
default of **3%**. ⭐ **Declared as `SAAS-CFG-001`** (register declared under [`DP-0008`](../../00-governance/decisions/DP-0008-configuration-owner-decision-saas-gap-002-d4-identifier-allocation-route.md); range **1%–5%** per `DP-0007`): a configured value **outside 1%–5%** is *outside its declared range* and therefore routes to `CONFIGURATION_GUIDE.md` §5's *"An ADR"* path (L861). ⚠ **Identifier not yet allocated — act (c) of the `DP-0008` §4 sequence is pending**; the label is the register's published range slot, not an allocated identifier.

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
reason `SAAS-FR-022` declared no range. ⭐ **RESOLVED 2026-09-25 BY ELIMINATION — recorded in [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md):** the Product Owner decision made the due day a **closed set {10, 15, 25}** (default the 15th, set stated CLOSED). Because **only 10, 15 and 25 are permitted, and all three occur in every month including February**, the 29/30/31 question has **no remaining case**; no early-close or roll-forward rule is required. *Prior text, correct until v0.4.2: "…reason `SAAS-FR-022` declares no range. See §12."* See §12.

### 6A.3 Changing the due day — no silent retroactive movement

`SAAS-FR-022` — The due day **MUST** be a **platform-scoped configurable value** with a default of the **15th**,
changeable only by an authorised platform actor (`PR-1`) through the authorised platform configuration mechanism. A
Library Owner (`TR-1`), a Library Manager (`TR-2`) and every other tenant actor **MUST NOT** be able to change it.
⭐ **Declared as `SAAS-CFG-003`** (register declared under `DP-0008`; **closed set {10, 15, 25}** per `DP-0007`, set
stated CLOSED): a configured due day **other than 10, 15 or 25** is *outside the closed set* and therefore routes to
`CONFIGURATION_GUIDE.md` §5's *"An ADR"* path (L861). ⚠ **Identifier not yet allocated — act (c) of the `DP-0008`
§4 sequence is pending**; the label is the register's published range slot, not an allocated identifier.

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
the action **MUST** fail closed per `AP-9`. ⭐ **v0.4 — V1/V2 RECONCILIATION** (`Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §8; see **§14A**): ⛔ **this requirement is NOT amended, narrowed, weakened or reinterpreted.** Its authorization principle — that settlement requires an authority **declared in the authoritative authorisation model** (`BC-18`/`PRD-001`), failing closed per `AP-9` until one exists — is **preserved in full** and becomes **operative when V2 settlement is designed**. ⭐ The correct V1 reading is that **the settlement action does not exist as a V1 capability**, the LIBOORA platform charge being **out of V1 scope**; the requirement therefore creates **no V1 settlement obligation**, and its fail-closed limb is **correct and unchanged** with nothing in V1 able to reach it. ⛔ **No V1 authority is declared, and no permission is invented, to satisfy it.**

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
value with a default of **14 days**. ⭐ **Declared as `SAAS-CFG-002`** (register declared under `DP-0008`; range **7–30 days** per `DP-0007`): a configured duration **outside 7–30 days** is *outside its declared range* and therefore routes to `CONFIGURATION_GUIDE.md` §5's *"An ADR"* path (L861). ⚠ **Identifier not yet allocated — act (c) of the `DP-0008` §4 sequence is pending**; the label is the register's published range slot, not an allocated identifier.

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

**No minimum or maximum configurable range was declared at v0.1–v0.4** for either the trial duration or the Platform Charge rate.
The brief forbids inventing a range absent product-owner approval, and `CONFIGURATION_GUIDE.md` §5 treats a range as
*"part of the reasoning, not a formality."* Ranges are `SAAS-GAP-002`. ⭐ **DECIDED 2026-09-25 by [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md): rate **1%–5%** · trial **7–30 days** · due day **closed set {10, 15, 25}** — the ranges limb of `SAAS-GAP-002` is now DECIDED; ⚠ the identifier-allocation limb (D-4) remains the `BC-25`/`PRD-023` act.**

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
| **Why it cannot be answered here** | It depends on the fee-type taxonomy, which is **`PRD-008` `FEE-GAP-004`**. `BC-05` owns the taxonomy |
| **Classification** | **REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **DECIDED 2026-09-25 — recorded in [`DP-0006`](../../00-governance/decisions/DP-0006-product-owner-decision-saas-gap-001-platform-charge-eligibility-base.md) (Product Owner decision record): the Platform Charge applies to **all confirmed `BC-05` collection fee types — `BC-05`'s existing confirmed-collection boundary in full, consuming the decided `FEE-GAP-004` taxonomy of `Accepted` [`ADR-0039`](../../00-governance/adr/ADR-0039-prd-008-fee-blocker-resolutions.md) §4 without restating or re-enumerating it.** ⛔ **No fee type was invented, renamed or redefined; no *"everything"* default was minted** — the decision binds the base to `BC-05`'s *own* boundary. ⛔ **The 3% default and `PR-1` rate mutability are confirmed as already-required by `SAAS-FR-001`/§11, not new.** ⚠ **`SAAS-GAP-002` (rate min/max range) is NOT decided by this act and remains OPEN.** |
| **Blocks** | ✅ **No longer blocks Stage 4 / Freeze on the eligibility-base question** — the decision is recorded at `DP-0006`; the criterion `SAAS-AC-006`'s *"a rate without a base computes nothing"* condition (L802) is discharged. ⚠ **Deferral is not closure for the V2 rail/permission questions** — those remain `SAAS-GAP-003`/`004` (V2/DEFERRED, unchanged) |
| **What was NOT invented** | No eligibility list, no fee-type enumeration, no default of *"everything"* — **and the `DP-0006` decision honoured that: it bound the base to the existing `BC-05` boundary rather than writing a new list** |

### `SAAS-GAP-002` — Configurable ranges and parameter identifiers

| Field | Value |
|---|---|
| **Question** | What are the minimum/maximum ranges for the Platform Charge rate and the free-trial duration, and under which register are their parameter identifiers allocated? |
| **Measured** | `CONFIGURATION_GUIDE.md` v1.1 governs **35** parameters (`CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`) and holds **no** Platform Charge rate and **no** trial duration. §5: *"Adding a parameter — a **PRD amendment**"*, and this document supplies that amendment for **what** is configurable, not for the identifier |
| **Classification** | **REQUIRES PRODUCT OWNER** (ranges) + **`BC-25`/`PRD-023`** (identifier allocation) |
| **Status** | ⭐ **RANGES LIMB DECIDED 2026-09-25 — recorded in [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md) (Product Owner): Platform Charge rate range **1%–5%** (default 3% unchanged) · free-trial duration range **7–30 days** (default 14 days unchanged) · billing due day **closed set {10, 15, 25}** (default the 15th unchanged, set stated CLOSED). ⭐ **REGISTER DECLARED 2026-09-25 — recorded in [`DP-0008`](../../00-governance/decisions/DP-0008-configuration-owner-decision-saas-gap-002-d4-identifier-allocation-route.md) (Configuration Owner, Route A): new `SAAS-CFG-*` register, 3 members published up front at §0.2 (rate / trial / due-day, with `DP-0007` ranges and defaults), admitted to `PRD-023`'s resolution machinery by reference; ⛔ `CNF-CFG-*` remains 0; no ADR, no `PRD-023` amendment.** ✅ **IDENTIFIER-ALLOCATION LIMB (D-4) RESOLVED 2026-09-25** — act (c) of the `DP-0008` §4 sequence is COMPLETE: the three parameters are **formally allocated** in [`CONFIGURATION_GUIDE.md`](../../../20-configuration/CONFIGURATION_GUIDE.md) **§2D** (v1.3) under `DP-0008` Route A — `SAAS-CFG-001` = Platform Charge rate · `SAAS-CFG-002` = Free-trial duration · `SAAS-CFG-003` = Billing due day — each with the `DP-0007`-decided default/range consumed verbatim; ⛔ **0 identifiers invented beyond the three allocated; no other identifier minted.** |
| **Blocks** | ✅ **RESOLVED 2026-09-25** — both limbs are now closed: ranges limb by `DP-0007` (every configurable has a default and a range, satisfying `PRD_LIFECYCLE.md` L114), identifier-allocation limb by the `CONFIGURATION_GUIDE.md` §2D allocation under `DP-0008` Route A. `SAAS-GAP-002` **no longer blocks Stage 4 or Freeze** |
| **What was NOT invented** | No range, no default minimum or maximum *(v0.1-era statement, retained — superseded by the `DP-0007` ranges at the Status row above)*; the three `SAAS-CFG-*` identifiers are **allocated, not invented** — allocated in `CONFIGURATION_GUIDE.md` §2D for the parameters `PRD-022` §0.2 declared under `DP-0008` acts (a) + (b); no fourth identifier, no new register beyond `SAAS-CFG-*`, no `PRD-023` amendment, `CNF-CFG-*` remains 0 |

### `SAAS-GAP-003` — Library-initiated outbound remittance has no described shape

| Field | Value |
|---|---|
| **Question** | Can the existing `E-25` → `BC-31` gateway abstraction carry a **library-initiated outbound** remittance, and how does a settlement state relate to `BC-20`'s existing `PaymentAttempt`/`DunningState`? |
| **Measured** | The rail exists (BC Map **L334**; manifest **L409**) and `BC-31` is scoped to *"**outbound** third-party contracts"* (**L140**), so the direction is not obviously wrong — but every described flow is LIBOORA **pulling** (`PaymentAttempt`, `DunningState`, BC Map **L382**), never a library **pushing** |
| **Classification** | **REQUIRES ARCHITECTURE OWNER** — ⭐ **v0.4: RE-CLASSIFIED V2 / DEFERRED** by `Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §3. ⛔ **NOT claimed technically resolved.** The LIBOORA platform charge is **out of V1 scope**, so no V1 outbound remittance shape is required. ⭐ **Architecture determination recorded:** `ADR-0035`'s **`O-3` is scoped verbatim to *"Student → library payment execution"*** and therefore does ⛔ **NOT** cover library → LIBOORA movement; and **`E-25` is a *gateway abstraction*** (BC Map **L334**) whose `BC-20` objects (`PaymentAttempt`, `DunningState`, *"idempotent by gateway reference"*, **L382**) all describe **LIBOORA pulling via a gateway** — unusable under cash-only V1 without reintroducing a gateway dependency. ⛔ `ADR-0035` is **not extended by interpretation**; ⛔ **`E-25` is PRESERVED unchanged** and remains available to the V2 decision; ⛔ **no edge minted, `E-34` NOT allocated**, no port, no contract, no aggregate named. **Authority: Architecture Owner, V2 act** |
| **Blocks** | ⛔ *Prior, correct until v0.4:* Stage 4 ✅ · Freeze ✅. ⭐ **v0.4: V2 / DEFERRED — does NOT block V1** ([`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §3). ⚠ It **still blocks Stage 4 and Freeze for the V2 settlement capability**, which is **not designed** — deferral is not closure. |
| **What was NOT invented** | No provider, endpoint, webhook schema, signature algorithm, retry policy, bank-account structure, UPI flow, new edge, new port or new aggregate name |

### `SAAS-GAP-004` — No enumerated permission for settlement, for any role

| Field | Value |
|---|---|
| **Question** | Which declared authority permits `TR-1` Owner to initiate and complete a Platform Charge settlement, and is `TR-2` Manager to be permitted at all? |
| **Measured** | `AUTH-7.22` (`prd-v2/07` **L124**) closes the permission catalogue; `grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` → **0**; `AP-9` (**L57**) fails closed. **Therefore the action is refused for `TR-1` as well as `TR-2`** — this is not merely a Manager question. `TR-2` is additionally barred by **L169**/**L200**. The **Financial** category's examples (**L136**) are both *inbound* and do not evidently reach outbound remittance |
| **Classification** | **REQUIRES AUTHORIZATION OWNER** (`BC-18`/`PRD-001`) + **REQUIRES PRODUCT OWNER** (whether `TR-2` should be permitted) — ⭐ **v0.4: RE-CLASSIFIED V2 / DEFERRED** by `Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §4. Settlement is **not a V1 capability**, so ⛔ **no V1 settlement authority is required and the absence of one is NOT a V1 blocker.** ⛔ **`AUTH-7.22`'s closed catalogue is PRESERVED INTACT and NOT reinterpreted**; ⛔ **no permission created**, ⛔ **no `PERM-*` identifier** (measured: enumerated permissions **0**; `PERM-*` repo-wide **2**, both *withdrawal* records in `PRD-021A` — **no naming convention exists to extend**), ⛔ **no Authentication PRD v4.0**, ⛔ Authentication **v2.0/v3.0** byte-unchanged. ⛔ **No V1 settlement authority is assigned to `TR-1` or `TR-2`**; `SAAS-BR-007`'s safe default stands. ⚠ **Recorded for the V2 act, NOT decided here:** the choice lies between declaring a permission in `AUTH-7.22`'s catalogue and the `ADR-0043` §5.1 / `FEE-GAP-007` route (*"Do not invent a new permission ID"*, via `MP-GBR-20`/`21`/`23`) — noting that `TR-1`'s declared authority is *"financial and revenue **visibility**"* (`prd-v2/02` **L159**), **not** outbound remittance execution, and that `MP-GBR-21`'s closed scope register (`self`/`guardianOf`/`tenantWide`) does not obviously reach an act landing outside the tenant. **Authority: Authorization Owner + Product Owner, V2 act** |
| **Blocks** | ⛔ *Prior, correct until v0.4:* Stage 4 ✅ · Freeze ✅. ⭐ **v0.4: V2 / DEFERRED — does NOT block V1** ([`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §4). ⚠ It **still blocks Stage 4 and Freeze for the V2 settlement capability** — deferral is not closure. |
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
| **Status** | ✅ **CLOSED 2026-09-25 — the Stage 3 alignment review was performed and its verdict CONFERRED** under the Architecture Owner (single-act conferral, V1 scope only) via [`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0, which records **ALIGNED 6/6** and states *"performing and recording the review is the closure"* for this self-referential gap. ⚠ **This §12 cell had been preserved as "Not attempted" (the v0.1-era text) since the CONFERRED record was written** — the alignment record's §5/§7 closure of `SAAS-GAP-006` was the authoritative act; this amendment is the **subject reconciliation** of that already-recorded closure, not a new decision. *(Prior text, retained verbatim: "**Not attempted.** This document is Stage 2 output. Notably `SAAS-FR-011` asserts that no new edge is required, and **that assertion is exactly the kind of claim Stage 3 exists to test**.")* |
| **Classification** | **REQUIRES ARCHITECTURE OWNER** |
| **Blocks** | ✅ **No longer blocks Stage 4 / Freeze** — the Stage 3 act is performed and its verdict CONFERRED (ALIGNED 6/6) by the alignment record; the self-referential question *"has Stage 3 been performed?"* is answered |

### `SAAS-GAP-007` — A configured due day above 28 has no defined February behaviour

| Field | Value |
|---|---|
| **Question** | If the due day is configurable, what happens when the configured day (29, 30, 31) does not occur in a month? Does the period end early, roll forward, or is the range capped at 28? |
| **Why it is not decided here** | It is a **calendar-semantics** decision with customer-visible consequences for the due date, and `SAAS-GAP-002` already records that **no configurable range is declared** for any value in this document. Frozen `PRD-005` `MM-FR-059` sidesteps the identical problem by using *"day arithmetic alone"* so that *"there is **no** 'same day next month' rule"* — but a calendar **due day** is precisely such a rule, so that escape does not transfer |
| **Classification** | **REQUIRES PRODUCT OWNER** (+ `BC-25` for the range) |
| **Status** | ✅ **RESOLVED 2026-09-25 BY ELIMINATION — recorded in [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md) (Product Owner): the billing due day is a **closed set {10, 15, 25}** (default the 15th, set stated CLOSED). Because **only 10, 15 and 25 are permitted, and all three occur in every month including February**, the question *"what happens when the configured day (29, 30, 31) does not occur in a month?"* has **no remaining case**. No February early-close or roll-forward rule is required or declared. ⚠ **The v0.3 enumeration *"changeable among 10/15/25"* is now the closed set itself** — the §12.2 L804 caution (*"restricted the set without saying the set is closed"*) is discharged by this decision **stating the closure** |
| **Blocks** | ✅ **No longer blocks Stage 4 / Freeze** — resolved by elimination; the §6A.2 *"A configured due day above 28 has no defined behaviour"* question has no input |

> **The safe default is already in force and costs nothing:** the **15th** occurs in every month, so the V1 default is
> unaffected. The gap blocks only the *configurability* of days 29-31, which nothing yet requires.

### 12.1 Gap summary

| Gap | Subject | Authority | Blocks Stage 4 | Blocks Freeze |
|---|---|---|---|---|
| `SAAS-GAP-001` | Platform Charge eligibility base | Product Owner | ✅ **DECIDED 2026-09-25 — [`DP-0006`](../../00-governance/decisions/DP-0006-product-owner-decision-saas-gap-001-platform-charge-eligibility-base.md)** (no longer blocks) | ✅ **DECIDED 2026-09-25** |
| `SAAS-GAP-002` | Configurable ranges + parameter ids | Product Owner + `BC-25` | ✅ **RESOLVED 2026-09-25** — ranges limb by `DP-0007` (rate 1–5% · trial 7–30 days · due-day closed set {10, 15, 25}); identifier-allocation limb (D-4) by `CONFIGURATION_GUIDE.md` §2D under `DP-0008` Route A (`SAAS-CFG-001`/`002`/`003` allocated) — **no longer blocks** | ✅ **RESOLVED 2026-09-25** |
| `SAAS-GAP-003` | Outbound remittance shape on the rail | Architecture Owner | ⭐ **V2/DEFERRED** | ⭐ **V2/DEFERRED** |
| `SAAS-GAP-004` | Settlement permission for any role | Authorization Owner + Product Owner | ⭐ **V2/DEFERRED** | ⭐ **V2/DEFERRED** |
| `SAAS-GAP-005` | Trial eligibility identity | Architecture Owner + `PRD-001` | ✅ | ✅ |
| `SAAS-GAP-006` | Stage 3 not performed | Architecture Owner | ✅ **CLOSED 2026-09-25** — performed + verdict CONFERRED (ALIGNED 6/6) via [`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0; the §12 cell text was preserved as recorded until this reconciliation | ✅ **CLOSED 2026-09-25** |
| `SAAS-GAP-007` | Due day above 28 in February | Product Owner + `BC-25` | ✅ **RESOLVED 2026-09-25 BY ELIMINATION — [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md)** (closed set {10, 15, 25} contains no day above 28; no 29/30/31 case remains) | ✅ **RESOLVED 2026-09-25** |

⭐ **v0.4: 7 gaps remain registered. `SAAS-GAP-003` and `SAAS-GAP-004` are re-classified V2/DEFERRED by `Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md), so 5 block Stage 4 and 5 block Freeze for V1 purposes.** ⛔ **Neither re-classified gap is claimed resolved**, and ⛔ **`SAAS-GAP-001`, `002`, `005`, `006` and `007` remain OPEN and unchanged** — none is required by the cash-only V1 decision, and none is closed to make this document look finished. ⭐ **Reconciled 2026-09-25 (subject amendment under `DP-0006`): `SAAS-GAP-001` is now DECIDED — the Product Owner decision record `DP-0006` binds the eligibility base to `BC-05`'s existing confirmed-collection boundary (consuming `Accepted` `ADR-0039` §4 without re-enumeration). The V1-blocking count moves **5 → 4**: `SAAS-GAP-002`, `005`, `006`, `007` remain OPEN and blocking for V1; `SAAS-GAP-003`/`004` remain V2/DEFERRED (⛔ unchanged, not closure). `SAAS-GAP-006`'s "Stage 3 not performed" cell was in fact CLOSED by the Stage 3 CONFERRED alignment record (`PRD-022_ARCHITECTURE_ALIGNMENT.md` v1.0) — this amendment does not claim that closure here; the §12.1 row for `SAAS-GAP-006` is left as recorded.** ⭐ **Reconciled 2026-09-25 (second subject amendment under [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md)): `SAAS-GAP-002`'s RANGES LIMB is DECIDED (rate 1–5%, trial 7–30 days, due-day closed set {10, 15, 25}) and `SAAS-GAP-007` is **RESOLVED BY ELIMINATION** through that closed set (no day above 28 is permitted, so the 29/30/31 question has no remaining case). The V1-blocking count moves **4 → 3**: `SAAS-GAP-005` and `SAAS-GAP-006` remain OPEN and blocking for V1; `SAAS-GAP-002` **still blocks** on its **identifier-allocation limb (D-4)** — the `BC-25`/`PRD-023` owner act, explicitly excluded from `DP-0007`'s approval; `SAAS-GAP-007` leaves the blocking set; `SAAS-GAP-003`/`004` remain V2/DEFERRED (⛔ unchanged, not closure).** ⭐ **Reconciled 2026-09-25 (third subject amendment — `DP-0008` act (d)): `SAAS-GAP-002`'s D-4 identifier-allocation limb is now **RESOLVED** — the three parameters are formally allocated in `CONFIGURATION_GUIDE.md` §2D (v1.3) under `DP-0008` Route A: `SAAS-CFG-001` = Platform Charge rate · `SAAS-CFG-002` = Free-trial duration · `SAAS-CFG-003` = Billing due day, each with the `DP-0007`-decided default/range. `SAAS-GAP-002` leaves the V1-blocking set entirely (both limbs closed). The V1-blocking count moves **3 → 2**: the remaining V1 blockers are exactly `SAAS-GAP-005` (trial-eligibility identity, Architecture Owner + `PRD-001`) and `SAAS-GAP-006` (Stage 3 not performed — in fact CLOSED by the Stage 3 CONFERRED alignment record, but its §12.1 row is preserved as recorded). `SAAS-GAP-003`/`004` remain V2/DEFERRED (⛔ unchanged, not closure); `SAAS-GAP-007` remains resolved by elimination (⛔ unchanged).** ⭐ **Reconciled 2026-09-25 (fourth subject amendment — `SAAS-GAP-006` subject reconciliation): the `SAAS-GAP-006` §12 cell and §12.1 row now record the already-CLOSED alignment record — the Stage 3 review was performed and its verdict CONFERRED (ALIGNED 6/6) by `PRD-022_ARCHITECTURE_ALIGNMENT.md` v1.0 (Architecture Owner, single-act conferral). The closure was recorded by that record; this amendment is the subject-side reconciliation of the recorded closure, not a new decision. `SAAS-GAP-006` leaves the V1-blocking set. The V1-blocking count moves **2 → 1**: the sole remaining V1 blocker is exactly `SAAS-GAP-005` (trial-eligibility identity, Architecture Owner + `PRD-001`). `SAAS-GAP-003`/`004` remain V2/DEFERRED (⛔ unchanged, not closure); `SAAS-GAP-007` remains resolved by elimination (⛔ unchanged). *(Prior text, correct until v0.4: "7 gaps. 7 block Stage 4. 7 block Freeze. Re-derived at v0.3 from each gap block's own `Blocks` row — unchanged.")*

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
| `SAAS-FR-007` | `SAAS-AC-006`, `SAAS-AC-024` | ✅ **Traced 2026-09-25 — `DP-0006` decided the eligibility base** (`BC-05`'s confirmed-collection boundary, consuming `ADR-0039` §4); the viewing set now displays over the decided base *(prior: ⛔ UNTRACED — the display set depends on `SAAS-GAP-001` eligibility)* |
| `SAAS-FR-008` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-FR-009` | `SAAS-AC-015` | |
| `SAAS-FR-010` | — | ⛔ **UNTRACED** — net-off is `MAY`, and `SAAS-GAP-003` governs whether the rail supports it |
| `SAAS-FR-011` | — | ⛔ **UNTRACED** — blocked on `SAAS-GAP-003` |
| `SAAS-FR-012` | `SAAS-AC-011`, `SAAS-AC-012` | |
| `SAAS-FR-013` | `SAAS-AC-014` | |
| `SAAS-FR-014` | `SAAS-AC-013` | |
| `SAAS-FR-015` | `SAAS-AC-002` | |
| `SAAS-FR-016` | `SAAS-AC-018` | |
| `SAAS-FR-017` | `SAAS-AC-003` | ✅ **Traced 2026-09-25 — `DP-0007` decided the range** (7–30 days, default 14 days; `SAAS-GAP-002` ranges limb DECIDED) *(prior: ⛔ UNTRACED — no range declared; blocked on `SAAS-GAP-002`)* |
| `SAAS-FR-018` | `SAAS-AC-003` | |
| `SAAS-FR-019` | `SAAS-AC-029` | |
| `SAAS-FR-020` | `SAAS-AC-028` | |
| `SAAS-FR-021` | `SAAS-AC-029` | |
| `SAAS-FR-022` | `SAAS-AC-028`, `SAAS-AC-030` | ✅ **Traced 2026-09-25 — `DP-0007` decided the range** (closed set {10, 15, 25}, default the 15th; `SAAS-GAP-002` ranges limb DECIDED; `SAAS-GAP-007` RESOLVED BY ELIMINATION) *(prior: ⛔ UNTRACED — no range declared; blocked on `SAAS-GAP-002` and `SAAS-GAP-007`)* |
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
| `SAAS-FR-*` | 28 | 26 | `SAAS-FR-010`, `SAAS-FR-011` · ⚠ **`SAAS-FR-007` traced 2026-09-25 by `DP-0006`** · **`SAAS-FR-017`/`022` traced 2026-09-25 by `DP-0007`** (ranges decided) |
| `SAAS-BR-*` | 13 | 11 | `SAAS-BR-001`, `SAAS-BR-009` |
| `SAAS-INV-*` | 8 | 8 | — |
| `SAAS-XC-*` | 15 | 14 | `SAAS-XC-006` |
| **Total** | **64** | **59** | **5 = 92.2%** (was 57/64 = 89.1% pre-`DP-0007`) |

**This does not meet the 100% bar** that `PRD-006` cleared (285/285), and it is not presented as if it might.
**At v0.2 coverage moved from 36/43 = 83.7% to 56/64 = 87.5%** — it rose because the eleven new obligations
arrived with criteria attached, and **one new untraced obligation** (`SAAS-FR-022`, the due-day configurable) was
added rather than hidden, because `SAAS-GAP-007` blocks it. **At the 2026-09-25 subject amendment under `DP-0006`,
`SAAS-FR-007` moved UNTRACED → traced (56 → 57 = 89.1%)** — the `DP-0006` decision supplied the eligibility base
the viewing set depended on; **no new criterion was manufactured and no percentage inflated** (the criterion
`SAAS-AC-006`/`024` already existed and was previously blocked on the gap, not orphaned). **At the 2026-09-25
second subject amendment under `DP-0007`, `SAAS-FR-017` and `SAAS-FR-022` moved UNTRACED → traced
(57 → 59 = 92.2%)** — the `DP-0007` decision supplied the ranges those two obligations depended on; their
criteria (`SAAS-AC-003`/`028`/`030`) already existed and were previously blocked on the gap, not orphaned.
**Two** of the remaining 5 untraced are blocked on named gaps (`SAAS-FR-010`/`011` → `SAAS-GAP-003` V2/DEFERRED);
**three** (`SAAS-BR-001`, `SAAS-XC-006`, and the review half of
`SAAS-BR-009`) are prohibitions or review-verified rules that a runtime test cannot verify. Manufacturing
criteria for those would raise the percentage without raising the assurance — the same inflation this repository has
refused before.

## 14A. V1 / V2 payment and settlement boundary *(added v0.4)*

This section is **recording**, not deciding. Every entry is the consequence of `Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md), and nothing
below creates a requirement, an identifier, a provider, an instrument or a mechanism.

| # | Capability | **V1** | **V2** |
|---|---|---|---|
| 1 | Student pays the library in **cash** | ⭐ **YES — the V1 student payment method** (`ADR-0037`: supported, **server-authoritative**, ⛔ no offline write) | ✅ **YES — unchanged** |
| 2 | Student pays the library by **UPI** | ⛔ **NO** | ⚠ **DEFERRED — not designed** |
| 3 | Student pays the library by **card** | ⛔ **NO** | ⚠ **DEFERRED — not designed** |
| 4 | Student pays the library **online** | ⛔ **NO** | ⚠ **DEFERRED — not designed** |
| 5 | **Student payment gateway** | ⛔ **NO — no V1 gateway exists** | ⚠ **DEFERRED — not designed** |
| 6 | **Gateway provider** selection | ⛔ **NONE REQUIRED** — `ADR-0046` superseded for its **V1 limb only** ([`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md) §5), the ADR itself **byte-unchanged** | ⚠ **SEPARATE V2 DECISION — `Q-B31` remains OPEN**; ⛔ **no V2 provider is selected here** |
| 7 | **LIBOORA platform charge** levied on the library | ⛔ **NO — deliberately OUT OF V1 SCOPE** | ⚠ **DEFERRED — not designed** |
| 8 | **Library → LIBOORA settlement** | ⛔ **NO — deliberately OUT OF V1 SCOPE** | ⚠ **DEFERRED — not designed** |
| 9 | **Settlement instrument / rail** | ⛔ **NONE REQUIRED in V1**, and ⛔ **its absence is NOT a V1 blocker** | ⚠ **TO BE DESIGNED** (`SAAS-GAP-003`) |
| 10 | **Settlement authorization** | ⛔ **NONE REQUIRED in V1**; `AUTH-7.22`'s closed catalogue **PRESERVED INTACT**; ⛔ no permission, ⛔ no `PERM-*`, ⛔ no Authentication PRD v4.0 | ⚠ **TO BE GOVERNED** (`SAAS-GAP-004`) |
| 11 | **Outbound remittance architecture** | ⛔ **NONE REQUIRED in V1**; ⛔ `ADR-0035` **not extended**, ⛔ `E-25` **preserved**, ⛔ **`E-34` NOT allocated** | ⚠ **TO BE DESIGNED** by the **Architecture Owner** |
| 12 | Library's own **Platform Charge view** (`SAAS-FR-028`, §7A) | ✅ **Specification PRESERVED UNCHANGED** — it remains correct, and ⚠ it is **not exercised in V1** because no charge accrues | ✅ **Operative** |
| 13 | Student **online-payment dependency** for the library to meet an obligation | ⛔ **NO** — and `SAAS-BR-005`/§7B already established this independence | ⛔ **NO — must remain false** |

⚠⚠ **Read "⛔ NO" in the V1 column as *deliberately out of V1 scope* — NOT as broken, NOT as regressed, and NOT as
awaiting a V1 implementation.** ⭐ **V1 is intentionally limited, and the absence of a V2 design is therefore NOT a V1
defect and NOT a V1 blocker.** ⛔ Equally, **nothing here closes a V2 gap to make this document look complete**:
`SAAS-GAP-003` and `SAAS-GAP-004` are **deferred, not resolved**, and `SAAS-GAP-001`, `002`, `005`, `006` and `007`
**remain OPEN and untouched**.

⛔⛔ **`MP-GBR-24` is PRESERVED UNCHANGED.** Money owed by a **student to the library** (`BC-05`) and money owed by a
**library to LIBOORA** (`BC-20`) *"must never share a model, a table or a metric"*. ⭐ **These are two distinct flows,
which is precisely why the absence of the second does not invalidate the first** — a cash-only student payment flow is
complete in itself and does not await a settlement flow. ⛔ This section does **not** merge, couple or cross-reference
the two ledgers, and §2's mirror-image prohibitions (`SAAS-XC-001`…`004`, `SAAS-XC-010`) are untouched.

⭐ **PRESERVED UNCHANGED by this amendment** — every one of these remains exactly as drafted, because a capability
leaving V1 scope does not make its specification wrong:
`SAAS-FR-009` · `SAAS-FR-010` · `SAAS-FR-016` · `SAAS-FR-028` · `SAAS-BR-005` · `SAAS-BR-007` · `SAAS-BR-008` ·
`SAAS-BR-013` · `SAAS-XC-006` · `SAAS-XC-009` · `SAAS-AC-001` · `SAAS-AC-022` · `SAAS-AC-024`, and the whole of
**§7** (cash-only settlement), **§7A**, **§7B**, **§8** and **§9**. ⛔ **§7 is NOT duplicated, restated or weakened
here**, and ⛔ **no register gained, lost or renumbered an identifier** — `SAAS-FR-*` stays **28**, `SAAS-BR-*` **13**,
`SAAS-INV-*` **8**, `SAAS-XC-*` **15**, `SAAS-AC-*` **31**, `SAAS-GAP-*` **7**, so traceability remains **56/64 =
87.5%** and is **not inflated by this act**.

⛔ **`PRD-008` v1.7 is FROZEN and was NOT edited.** Its §6.1 V1 rows at **L209** (UPI), **L210** (card), **L211**
(online payment), **L213** (verification) and **L214** (webhook reconciliation) **contradict this decision and are
superseded IN EFFECT by rank** (`DOCUMENTATION_BASELINE.md` §4: Rank 2 ADR outranks a Rank 3 PRD). ⚠ This is a
**governed and temporary divergence**, recorded rather than repaired; its lawful repair is a **`PRD-008` successor**,
which is a **SEPARATE act and is NOT performed here**.

---

---

## 15. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐ **v0.4.5** | 2026-09-25 | ⭐ **Fifth subject amendment — `SAAS-GAP-006` subject reconciliation (no new decision).** The `SAAS-GAP-006` §12 cell and §12.1 row now record the **already-CLOSED** alignment record: the Stage 3 review was performed and its verdict **CONFERRED (ALIGNED 6/6)** by [`PRD-022_ARCHITECTURE_ALIGNMENT.md`](PRD-022_ARCHITECTURE_ALIGNMENT.md) v1.0 (Architecture Owner, single-act conferral, V1 scope only). That record's §5/§7 closure of `SAAS-GAP-006` was the authoritative act; **this amendment is the subject-side reconciliation of that recorded closure, not a new decision** — the v0.4.4-era §12 cell text ("Not attempted… Stage 2 output") was preserved verbatim since the CONFERRED record and is now updated in place, with the prior text retained verbatim. ⭐ **`SAAS-GAP-006` leaves the V1-blocking set**; the V1-blocking count moves **2 → 1**, the sole remaining V1 blocker being exactly `SAAS-GAP-005` (trial-eligibility identity, Architecture Owner + `PRD-001`). ⭐ **Cells amended strictly in place:** L7 (version → v0.4.5) · L8 (status: `SAAS-GAP-006` CLOSED, count 2→1) · L13 (V1-blocking count 2→1) · §12 `SAAS-GAP-006` block (Status/Blocks rows, prior text retained) · §12.1 summary row · §12.1 count sentence · this changelog row · footer. ⚠ **`SAAS-GAP-005` remains OPEN and untouched; `SAAS-GAP-003`/`004` remain V2/DEFERRED — ⛔ unchanged, not closure; `SAAS-GAP-007` remains resolved by elimination — ⛔ unchanged.** ⛔ **No new decision invented; no identifier minted; register counts unchanged** (SAAS-FR 28 · SAAS-BR 13 · SAAS-INV 8 · SAAS-XC 15 · SAAS-AC 31 · SAAS-GAP 7 · SAAS-CFG 3 = 105 total). ⛔ **Traceability/coverage unchanged at 59/64 = 92.2%** — the `SAAS-GAP-006` closure does not change any obligation's traceability status (it is a governance gap, not an obligation-bearing identifier). ⛔ **No `PRD-023` (FROZEN) change; `CONFIGURATION_GUIDE.md` byte-unchanged; `PRD-008`/`MASTER_PRD` byte-unchanged.** ⛔ **No Stage 4 verdict recorded; Stage 8 NOT entered; 0 criteria recorded as passing; no implementation.** |
| ⭐ **v0.4.4** | 2026-09-25 | ⭐ **Fourth subject amendment — `DP-0008` act (d): `SAAS-GAP-002` D-4 closure.** The identifier-allocation limb of `SAAS-GAP-002` is now **RESOLVED**: the three parameters are formally allocated in `CONFIGURATION_GUIDE.md` §2D (v1.3) under `DP-0008` Route A — `SAAS-CFG-001` = Platform Charge rate · `SAAS-CFG-002` = Free-trial duration · `SAAS-CFG-003` = Billing due day — each with the `DP-0007`-decided default/range consumed verbatim (rate 1–5%/3% · trial 7–30d/14d · due-day closed {10,15,25}/15th). ⭐ **`SAAS-GAP-002` is now FULLY RESOLVED** (both limbs closed) and **leaves the V1-blocking set**; the V1-blocking count moves **3 → 2**, the remaining blockers being exactly `SAAS-GAP-005` (trial-eligibility identity) and `SAAS-GAP-006` (Stage 3 not performed — in fact CLOSED by the Stage 3 CONFERRED alignment record, but its §12.1 row is preserved as recorded). ⭐ **Cells amended strictly in place:** L7 (version → v0.4.4) · L8 (status) · L13 (V1-blocking count 3→2) · §12 `SAAS-GAP-002` block (Status/Blocks/What-was-NOT-invented rows) · §12.1 summary row L797 · §12.1 count sentence L804 · this changelog row · footer. ⛔ **No identifier was invented beyond the three allocated in act (c); no new `SAAS-*` identifier minted; register counts unchanged** (SAAS-FR 28 · SAAS-BR 13 · SAAS-INV 8 · SAAS-XC 15 · SAAS-AC 31 · SAAS-GAP 7 · SAAS-CFG 3 declared/allocated = 105 total). ⛔ **Traceability/coverage unchanged at 59/64 = 92.2%** — the D-4 closure does not change any obligation's traceability status (the three `SAAS-FR-001`/`017`/`022` obligations were already traced via `DP-0007`'s ranges decision in v0.4.2; the identifier allocation is a registry act, not a traceability event). ⚠ **`SAAS-GAP-005`/`006` remain OPEN and untouched; `SAAS-GAP-003`/`004` remain V2/DEFERRED by `Accepted` `ADR-0130` — ⛔ unchanged, not closure; `SAAS-GAP-007` remains resolved by elimination — ⛔ unchanged.** ⛔ **No new decision invented; no `PERM-*`/`LCFG-*`/`ICFG-*`/`CFG-*` identifier minted; `PRD-023` (FROZEN, `CNF-CFG-*` = 0) byte-unchanged; `CONFIGURATION_GUIDE.md` §2D (the allocation) is the authority cited, not amended here; `PRD-008`/`MASTER_PRD` byte-unchanged.** ⛔ **No Stage 4 verdict recorded; Stage 8 NOT entered; 0 criteria recorded as passing; no implementation.** |
| ⭐ **v0.4.3** | 2026-09-25 | ⭐ **Third subject amendment — `DP-0008` acts (a) + (b) under the Configuration Owner Route-A decision.** **Act (a): register declaration** — §0.2 now declares a new `SAAS-CFG-*` register (3 members, published up front per `PRD_LIFECYCLE.md` L82 rule 2–3), admitted to `PRD-023`'s resolution machinery by reference; `SAAS-CFG-*` row added to the §0.2 register table (count 102 → 105, non-obligation-bearing — the register mirrors `SAAS-GAP-*`'s "not a requirement" class). **Act (b): parameter declaration** — `SAAS-FR-001`/`017`/`022` each now formally declare its configurable as `SAAS-CFG-001`/`002`/`003` with the `DP-0007`-decided range/default (rate 1–5%/3% · trial 7–30d/14d · due-day closed {10,15,25}/15th) and the §5 out-of-range → ADR routing (L861); ⚠ **each label is the register's published range slot — NOT an allocated identifier** (act (c) pending). ⭐ **Cells amended strictly in place:** L7 (version → v0.4.3) · §0.2 register table + declaration note · §3 `SAAS-FR-001`/`017`/`022` cells · §12 `SAAS-GAP-002` Status row · this changelog row · footer. ⚠ **`SAAS-GAP-002` D-4 limb (identifier allocation) remains OPEN — act (c) (`CONFIGURATION_GUIDE.md` §5 amendment, Configuration Owner / guide owner) is pending; act (d) (D-4 closure) is NOT performed.** ⚠ **`SAAS-GAP-005`/`006` remain OPEN; `SAAS-GAP-003`/`004` remain V2/DEFERRED by `Accepted` `ADR-0130` — ⛔ unchanged, not closure.** ⛔ **0 identifiers allocated — `SAAS-CFG-*` members are declared, not allocated; `CONFIGURATION_GUIDE.md` and `PRD-023` (FROZEN, `CNF-CFG-*` = 0) byte-unchanged; `PRD-008`/`MASTER_PRD` byte-unchanged.** ⛔ **No new decision invented — all ranges/defaults consumed verbatim from `DP-0007`; no value re-decided.** ⛔ **No Stage 4 verdict recorded; Stage 8 NOT entered; 0 criteria recorded as passing; no implementation.** |
| ⭐ **v0.4.2** | 2026-09-25 | ⭐ **Second subject amendment under [`DP-0007`](../../00-governance/decisions/DP-0007-product-owner-decision-saas-gap-002-configurable-ranges.md) — `SAAS-GAP-002` RANGES LIMB DECIDED + `SAAS-GAP-007` RESOLVED BY ELIMINATION.** The Product Owner decision record `DP-0007` decides: **D-1** Platform Charge rate range **1%–5%** (default 3% unchanged) · **D-2** free-trial duration range **7–30 days** (default 14 days unchanged) · **D-3** billing due day **closed set {10, 15, 25}** (default the 15th unchanged, set stated CLOSED). ⭐ **`SAAS-GAP-007` RESOLVED BY ELIMINATION** — because only 10, 15 and 25 are permitted and all three occur in every month including February, the *"configured due day above 28"* question has no remaining case; no early-close or roll-forward rule is required or declared. ⭐ **Cells amended strictly in place:** L7 (version → v0.4.2) · L8 (status) · L13 (blocking-gaps count 4→3 for V1) · §6A.2 `SAAS-GAP-007` reference · §10 range statement · §12 `SAAS-GAP-002` block (Status/Blocks rows) · §12 `SAAS-GAP-007` block (Status/Blocks rows) · §12.1 summary rows L780/L786 · §12.1 count sentence L788 · §14 traceability `SAAS-FR-017`/`022` rows L884/L890 + coverage table (57→59 = 92.2%) · footer. ⚠ **`SAAS-GAP-002` still blocks on its identifier-allocation limb (D-4, `BC-25`/`PRD-023` owner act, explicitly excluded from the `DP-0007` approval)** — 0 identifiers allocated here. ⚠ **`SAAS-GAP-005`/`006` remain OPEN; `SAAS-GAP-003`/`004` remain V2/DEFERRED by `Accepted` `ADR-0130` — ⛔ unchanged, not closure.** ⛔ **0 `PERM-*`, 0 `SAAS-*`, 0 `CFG-*`/`LCFG-*`/`ICFG-*` identifiers created.** ⛔ **`PRD-023` (FROZEN) byte-unchanged; `PRD-008` v1.7 byte-unchanged; `MASTER_PRD` v1.9 byte-unchanged; `CONFIGURATION_GUIDE.md` byte-unchanged.** ⛔ **No Stage 4 verdict recorded; Stage 8 NOT entered; 0 criteria recorded as passing; no implementation.** |
| ⭐ **v0.4.1** | 2026-09-25 | ⭐ **Subject amendment under [`DP-0006`](../../00-governance/decisions/DP-0006-product-owner-decision-saas-gap-001-platform-charge-eligibility-base.md) — `SAAS-GAP-001` DECIDED: the Product Owner decision record binds the Platform Charge eligibility base to `BC-05`'s existing confirmed-collection boundary, consuming `Accepted` `ADR-0039` §4's decided `FEE-GAP-004` taxonomy (membership, renewal, registration/admission, other approved fee = revenue; Security Deposit = refundable liability, NOT revenue) without restating or re-enumerating it.** ⛔ **No fee type invented, renamed or redefined; no "everything" default minted** — the decision *binds to the boundary*, which is the taxonomy's lawful home. ⭐ **Cells amended strictly in place:** L7 (version → v0.4.1) · L8 (status: Stage 3 CONFERRED + `SAAS-GAP-001` DECIDED) · L13 (blocking-gaps count 5→4 for V1) · §12 `SAAS-GAP-001` block (Status/Blocks rows) · §12.1 summary row L779 · §12.1 count sentence L787 · §14 traceability `SAAS-FR-007` row L873 + coverage table L935–950 (56→57 = 89.1%) · footer. ⚠ **`SAAS-GAP-002` (ranges), `SAAS-GAP-005` (trial identity), `SAAS-GAP-007` (Feb 29–31) remain OPEN; `SAAS-GAP-003`/`004` remain V2/DEFERRED by `Accepted` `ADR-0130` — ⛔ unchanged, not closure.** ⛔ **0 `PERM-*`, 0 `SAAS-*`, 0 `CFG-*`/`LCFG-*`/`ICFG-*` identifiers created.** ⛔ **`PRD-023` (FROZEN) byte-unchanged; `PRD-008` v1.7 byte-unchanged; `MASTER_PRD` v1.9 byte-unchanged.** ⛔ **No Stage 4 verdict recorded; Stage 8 NOT entered; 0 criteria recorded as passing; no implementation.** |
| ⭐ **v0.4** | 2026-09-10 | ⭐⭐ **V1 STUDENT PAYMENT IS CASH ONLY; the LIBOORA PLATFORM CHARGE and LIBRARY → LIBOORA SETTLEMENT are DEFERRED TO V2**, by `Accepted` [`ADR-0130`](../../00-governance/adr/ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md), decided **jointly** under a one-act conferral by the **Product Owner**, **Architecture Owner**, **`BC-20` Owner**, **Authorization (`BC-18`/`PRD-001`)** and **Governance Owner**; ⛔ every office **reverts on completion** (`ADR-0033` §7.1). ⭐ **Eleven cells amended STRICTLY IN PLACE** — **L7** (version), **L618** (`SAAS-FR-016` reconciliation), **L728**/**L729** (`SAAS-GAP-003` classification and blocking), **L738**/**L739** (`SAAS-GAP-004` classification and blocking), **L780**/**L781** (§12.1 summary rows), **L786** (§12.1 count sentence) and the footer — **plus** a new **§14A** and this row, both **appended below every cited line**. ⚠⚠ **CITATION COST: ZERO SHIFTED — measured before the write and verified after.** ⭐ **v0.4 CORRECTION (D-3), declared rather than buried:** an earlier v0.4 working draft measured *"0 inbound line-number citations"* using a pattern that required the **full filename** `PRD-022_SAAS-BILLING.md`; ⛔ **that figure was WRONG**, because this repository cites this document in **short form** (`` `PRD-022` **L802** ``). **Correct measurement, reproducible:** POSIX ERE `PRD-022`?(_SAAS-BILLING\.md`?)?('s)? ?[§0-9.]*\*{0,2}L[0-9]{1,4}` over `docs/` + `tool/` + `.github/` → **8 citations across 4 documents** — `ADR-0039` (**L131**, **L264**, **L307**), `PRD-008` (**L2215**), `PRD-013_TENANCY` (**L320**, **L414**, **L416**) and `PRD-013_ARCHITECTURE_ALIGNMENT` (**L449**) — pointing at **L29**, **L262**, **L277**, **L650–651**, **L749** and **L802**, the **highest being L802**. ⚠ **Two of the four citing documents are `FROZEN`** (`PRD-008`, `PRD-013`) and one is an **`ACCEPTED` ADR** (`ADR-0039`), so ⛔ **none of them may be repaired if broken** — which is exactly why the in-place discipline was mandatory rather than merely tidy. ⭐ **The working draft that relied on the wrong figure inserted prose ABOVE L802 and DID shift L650→L659, L749→L760 and L802→L815; it was DISCARDED, the file was restored BYTE-IDENTICAL to its v0.3 blob `b78c453e3fcf70fa9d560fa41fdc83029008ac82`, and the amendment was re-applied correctly.** ⭐ **All 8 citations were then re-verified by content, not by line number, and every one resolves to its intended text.** The file is **962 → 1013 lines**, every added line landing **at or below the foot of the document, beneath L802**, per the `ADR-0079` §8.5 append-not-insert doctrine. ⭐ **New §14A records the V1/V2 boundary as a 13-row matrix**: student **cash YES** in V1; ⛔ **UPI, card, online payment and student payment gateway NO** in V1 and ⚠ **DEFERRED, not designed**, in V2; ⭐⭐ the **LIBOORA platform charge** and **library → LIBOORA settlement** are ⛔ **deliberately OUT OF V1 SCOPE**, so ⛔ **no V1 settlement instrument, rail, authorization or architecture is required and their absence is NOT a V1 blocker**. ⚠ *"NO" in V1 means deliberately out of V1 scope — not broken, not regressed, not awaiting V1 implementation.* ⭐ **`SAAS-GAP-003` re-classified V2/DEFERRED** with the **architecture determination recorded**: `ADR-0035`'s **`O-3` is scoped verbatim to *"Student → library payment execution"*** and therefore does ⛔ **NOT** reach library → LIBOORA movement, and **`E-25` is a *gateway abstraction*** (BC Map **L334**) whose `BC-20` objects (**L382**) all describe **LIBOORA pulling** — unusable under cash-only V1 without reintroducing a gateway. ⛔ `ADR-0035` **not extended by interpretation**; ⛔ `E-25` **preserved**; ⛔ **no edge minted, `E-34` NOT allocated**; ⛔ no port, contract or aggregate named. ⭐ **`SAAS-GAP-004` re-classified V2/DEFERRED**: ⛔ **`AUTH-7.22`'s closed catalogue PRESERVED INTACT and NOT reinterpreted**, ⛔ **no permission created**, ⛔ **no `PERM-*` identifier** (measured: enumerated permissions **0**; `PERM-*` repo-wide **2**, both *withdrawal* records — **no naming convention exists to extend**), ⛔ **no Authentication PRD v4.0**, ⛔ Authentication **v2.0/v3.0** and `prd-v2/`/`prd-v3/` **byte-unchanged**, ⛔ **no V1 authority assigned to `TR-1` or `TR-2`**. ⛔⛔ **NEITHER GAP IS CLAIMED RESOLVED** — both still block **Stage 4 and Freeze for the V2 settlement capability**; deferral is not closure. ⛔ **`SAAS-FR-016` is NOT amended, narrowed, weakened or reinterpreted** — its authorization principle is **preserved in full** and becomes operative when V2 settlement is designed; the correct V1 reading is that **the settlement action does not exist as a V1 capability**, so it imposes **no V1 obligation** and nothing in V1 can reach its fail-closed limb. ⛔⛔ **`MP-GBR-24` PRESERVED UNCHANGED** — the two flows *"must never share a model, a table or a metric"*, which is why the absence of the second does not invalidate the first. ⭐ **`ADR-0046` is SUPERSEDED for its V1 limb ONLY and is BYTE-UNCHANGED** (`ADR-INDEX` **L206** — *"never edit an Accepted ADR's decision text"*); ⭐ Razorpay **was** properly selected on 2026-08-15 and that history is **preserved, not denied**; ⛔ **no V2 provider is selected** (`Q-B31` OPEN). ⛔ **`PRD-008` v1.7 FROZEN and NOT edited** — its §6.1 **L209**/**L210**/**L211**/**L213**/**L214** V1 rows **contradict this decision and are superseded IN EFFECT by rank**, a **governed and temporary divergence** whose lawful repair is a **`PRD-008` successor — a SEPARATE act, NOT performed here**; ⛔ its stale self-described *"DRAFT"* header is **NOT rewritten**. ⛔⛔ **NOTHING ELSE EXECUTED:** ⛔ **no register changed size** — `SAAS-FR-*` **28**, `SAAS-BR-*` **13**, `SAAS-INV-*` **8**, `SAAS-XC-*` **15**, `SAAS-AC-*` **31**, `SAAS-GAP-*` **7**; ⛔ **traceability unchanged at 56/64 = 87.5% and NOT inflated**; ⛔ **no new `SAAS-*` identifier minted** (next free remain `SAAS-FR-029`, `SAAS-BR-014`, `SAAS-XC-016`, `SAAS-AC-032`); ⛔ **§7, §7A, §7B, §8, §9 and §11 untouched**; ⛔ **no bounded context** (still **31**), no `CFG-*`/`LCFG-*`/`ICFG-*`, no role, no schema, no table, no screen, no route, no endpoint, no rail, no provider; ⛔ BC Map, Dependency Matrix, `tool/module_dependencies.yaml`, the EA, `ADR-0035`, `ADR-0037`, `ADR-0043`, `ADR-0045` and **all code, schema, API, UI, test, migration and deployment files unchanged**; ⛔ **`SAAS-GAP-001`/`002`/`005`/`006`/`007` remain OPEN**; ⛔ **Stage 3 still NOT performed** (`SAAS-GAP-006`); ⚠ **`FEE-GAP-017` is NOT closed** but **re-classified as V2 work**, its question concerning a charge that does not exist in V1; ⛔ **no blocker closed**; ⛔ **`A-9` not executed**; ⛔⛔ **this document remains `DRAFT` — NOT frozen, NOT approved, NOT architecture-reviewed**; ⛔ **not pushed**. |
| **v0.2** | 2026-08-05 | **Billing period, calendar due date, the library view and the two load tests specified; the renewal-protection authority corrected.** Registers move **70 → 102**: `SAAS-FR-*` 18 → **28**, `SAAS-BR-*` 9 → **13**, `SAAS-INV-*` 5 → **8**, `SAAS-XC-*` 11 → **15**, `SAAS-AC-*` 21 → **31**, `SAAS-GAP-*` 6 → **7**; obligation-bearing 43 → **64**; traceability **56/64 = 87.5%** (up from 83.7%, and **every figure recomputed from the document rather than incremented by hand**). **New §6A defines the billing period explicitly, as the brief requires:** a closed inclusive interval bounded by consecutive due days — `[15th of M, 14th of M+1]` at the default — with `SAAS-XC-012` **forbidding** the natural-but-wrong *"accrual date + 15 days"* derivation, which would give a 100-payment month up to 100 separate due dates. **The boundary ambiguity is resolved rather than left open:** the due day **opens** a period and closes the previous one, so a payment on the 15th is not due the same morning. **Month-end is not assumed.** Due day is **platform-scoped, default the 15th, `PR-1` only** (`SAAS-FR-022`), and a change is **non-retroactive in two separate ways** — `SAAS-FR-023` protects the **date**, `SAAS-FR-024` the **money**, because an implementation could satisfy one and violate the other; `SAAS-XC-013`/`SAAS-XC-014` state both as exclusions. The non-retroactivity principle is the **third** application of frozen `MM-FR-064`'s, not a new one. **`SAAS-FR-025` defines the statement's preserved facts** — period, rate, amount, generation date, due date, status, settlement history — with `SAAS-BR-011` forbidding a **period-level rate**, the statement shape that would silently restate obligations accrued before a rate change. **New §7A** gives the library view all seven required facts, **server-derived only**, and `SAAS-FR-028` requires it to be **fully populated for a 100%-cash library** — the case an online-payments feed renders as zeros. **New §7B works both load tests as arithmetic:** 100% cash → ₹50,000 revenue, ₹1,500 obligation, ₹0 online, ₹1,500 outstanding, lawful path independent of any future online collection; mixed 60/40 → the **identical** ₹1,500, with `SAAS-BR-013` making channel-invariance a rule so a channel-sensitive computation is a violation rather than a surprise. **What the tests do NOT prove is stated**: the rail direction (`SAAS-GAP-003`) and the authority (`SAAS-GAP-004`) stay open. **One correction, declared:** §11's note named `BC-25` as the renewal-protection authority; the deciding question is **`Q-01`**, owned by the **Architecture Owner + `BC-04` owner**, with `BC-25` involved only if the window is made configurable — which **`ADR-0036`** (`PROPOSED`) deliberately does not propose, since `CONFIGURATION_GUIDE.md` §5 requires *"an ADR **and** a PRD amendment"* and no `SEAT-CFG-*` exists. The rest of the row was right and is retained. **One new gap, `SAAS-GAP-007`** — a due day above 28 has no defined February behaviour; the **15th default is unaffected**, so the gap blocks only configurability. **7 gaps, all 7 blocking Stage 4 and Freeze.** **Nothing invented:** no bounded context (still **31**), no `CFG-*`/`LCFG-*`/`ICFG-*`/`SEAT-CFG-*` identifier, no permission, no role, no schema, no table, no screen, no route, no provider, no rail, no endpoint, no configurable **range**. **Nothing closed:** all six prior gaps remain open, Stage 3 is still not performed (`SAAS-GAP-006`), and this document is **NOT frozen and NOT approved**. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no ADR was accepted; no Dart source was touched. |
| **v0.1** | *(the first draft)* | **First draft. Stage 2 only.** Created to give `BC-20` the PRD it has been registered for since the register was created, and to be the lawful home for three findings that terminated outside their own module: **`FEE-GAP-014`** (the platform charge has no owning document), **`FEE-GAP-017`** (a cash-only library has no lawful way to pay) and the unspecified **SaaS free trial**. **Authorisation checked before authoring, not assumed:** Master PRD **L169** §8 module 17, `PRD_REGISTRY.md` **L326** (`V1`, `PLANNED`) and **L427** (§6, `BC-20` → `PRD-022`, uncontested) — and the registry's own §4.3 note names `BC-20` **module 17** *as the precedent* it used to register `PRD-023`, so authoring this applies an established mechanism rather than a new one. **Prefix collision-checked** per `PRD_LIFECYCLE.md` §5 rule 2: `SAAS-*` measured **0** pre-existing identifiers. **Terminology decision applied:** *Platform Charge* replaces *commission* in all new text — measured **0** pre-existing occurrences of *Platform Charge*, and the financial sense of *commission* confined to **three non-frozen** documents (`PRD-008`, its alignment record, `ADR-0035`), every other occurrence in the repository being the English verb. **The transition is forward-only and no historical text was rewritten** — editing the vocabulary of a decision record destroys the ability to audit what was known when, and **no frozen document uses the financial sense at all**. **Product decisions applied:** Platform Charge default **3%** (`SAAS-FR-001`), free trial default **14 days** (`SAAS-FR-017`), historical-rate immutability (`SAAS-FR-005`, `SAAS-BR-003`, `SAAS-INV-002` — ₹15 stays ₹15 when the rate becomes 2.5%), cash-only settlement as a **first-class V1 requirement** (`SAAS-FR-009`) with net-off explicitly **not** the only mechanism (`SAAS-BR-005`), three settlement states, server-side verification only (`SAAS-FR-013`), idempotency (`SAAS-FR-014`), and eight-fact auditability (`SAAS-FR-015`). **The `MP-GBR-24` boundary is stated as mirror-image prohibitions** (`SAAS-XC-001`…`004`, `SAAS-XC-010`) so that both sides of the boundary forbid the crossing rather than only `BC-05`. **Nothing was invented:** no bounded context, no `BC-32`, no dependency edge, no port, no endpoint, no webhook schema, no signature algorithm, no retry policy, no database schema, no queue, no payment provider, no settlement rail, no bank-account structure, no UPI flow, no tax rate, no gateway charge, no permission identifier, no role, no configuration identifier and no configurable range. **The hardest finding is recorded rather than solved:** `AUTH-7.22` closes the permission catalogue, **0** `PERM-*` identifiers exist repository-wide, and `AP-9` fails closed — so a settlement is refused **for `TR-1` Owner too**, not merely for `TR-2` Manager, and `X-13` makes naming a permission here *"a security defect that passes its own tests."* **Six gaps, all six blocking Stage 4 and Freeze**, each with a named authority. **Traceability reported honestly at 36/43 = 83.7%**, below the 100% bar, with four blocked on gaps and three verifiable only by review. **Stage 3 has NOT been performed** (`SAAS-GAP-006`) and this document is **NOT frozen and NOT approved**. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; no ADR was authored or accepted; no Dart source was touched. |

---

*End of `PRD-022_SAAS-BILLING.md` ⭐ **v0.4.5 — DRAFT**. Not frozen. Not approved. ⭐ **Stage 3 CONFERRED ALIGNED 6/6** (Architecture Owner, V1 scope only). ⭐ **`SAAS-GAP-001` DECIDED (`DP-0006`)** · ⭐ **`SAAS-GAP-002` FULLY RESOLVED** — ranges by `DP-0007` + D-4 by `CONFIGURATION_GUIDE.md` §2D under `DP-0008` Route A · ⭐ **`SAAS-GAP-007` RESOLVED BY ELIMINATION (`DP-0007`)** · ✅ **`SAAS-GAP-006` CLOSED** (Stage 3 CONFERRED; subject cell reconciled 2026-09-25) — rate 1–5%/3% · trial 7–30d/14d · due-day {10,15,25}/15th. `SAAS-GAP-005` OPEN · `SAAS-GAP-003`/`004` V2/DEFERRED · **1 block Stage 4 / Freeze for V1 purposes**.*
