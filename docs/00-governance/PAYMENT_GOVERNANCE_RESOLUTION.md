# LIBOORA — Payment, Platform Charge, Settlement, Webhook & Renewal-Protection Governance Resolution

| Field | Value |
|---|---|
| **Document** | `PAYMENT_GOVERNANCE_RESOLUTION.md` |
| **Version** | **v1.0** |
| **Status** | **RECORD ONLY — binds nothing.** This document decides nothing, accepts no ADR, closes no gap, performs no Stage 3, freezes no PRD and creates no identifier. It records what measurement already settles and names the authority for everything it does not |
| **Rank** | **Not ranked.** It is a measurement record subordinate to every document it cites. Where it and a PRD/ADR differ, **the PRD/ADR wins** |
| **Scope** | Payment path · Platform Charge · settlement · inbound webhook ownership · 3-day renewal protection |
| **Authored by** | Documentation pass. **No authority is claimed.** `ADR-0035` and `ADR-0036` remain **PROPOSED** |
| **Code impact** | **None.** Zero Dart files were read for change or modified |

---

# Governance Resolution Record — Payment, Platform Charge, Settlement, Webhook, Renewal Protection

| Field | Value |
|---|---|
| **Type** | Governance resolution record — **not** an ADR, **not** a PRD, **not** an authority |
| **Status** | **RECORD ONLY.** Nothing here decides, accepts, freezes or closes anything |
| **Date** | 2026-08-05 |
| **Scope** | The V1 payment / Platform Charge / settlement / webhook / 3-day-renewal-protection governance surface |
| **Baseline** | `b570c5a`, working tree clean, 7 protected hashes verified, `PRD-006` frozen body md5 verified |
| **Authority held by this pass** | **None beyond measurement and drafting.** The instruction was explicit: *"Do not self-accept ADRs"* and *"If any decision still requires Architecture Owner/Product Owner approval, clearly mark it BLOCKED"* |
| **Governs** | Nothing. It **reports** state and **routes** decisions |

---

## 0. The finding, stated before the detail

The task asked me to **resolve** the remaining governance gaps in this surface. The honest measured
answer is:

> **Every one of the twelve product requirements is already specified in the repository. Not one of
> the remaining blockers is resolvable by measurement, drafting or reasoning — each requires a named
> human authority to make a decision that does not exist in the repository in any form.**

This is not a failure to find the answers. It is the answer. `ADR-0035` §5.5 states it in terms that
no further work can improve on:

> *"**No amount of further measurement will produce this answer** — it does not exist in the
> repository, and inventing it is precisely what this ADR must not do."*

The most valuable thing this pass can do is therefore **not** to produce movement. It is to state
precisely which decisions are outstanding, who owns each one, and what unblocks in each case — and
to refuse to manufacture the appearance of progress.

> **⚠ There is direct precedent for the failure mode being avoided here.** `ADR-0035` §5.5a records a
> previous governance pass that believed it had found the missing webhook-ingress owner, reported it
> as progress, and was **overturned**: the "discovery" was a line the same ADR had already measured
> and disposed of 200 lines earlier. That subsection exists precisely so a later pass — this one —
> does not repeat it. **I re-measured the same line and reproduced the same disposal; see §3.3.**

---

## 1. What IS resolved — the twelve product requirements

Each row below was **measured in the repository**, not assumed. "Specified" means an obligation
identifier exists and carries the rule; it does **not** mean implemented, reviewed or frozen.

| # | Product requirement | Where it lives | State |
|---|---|---|---|
| 1 | Platform Charge = **3%** by default | `SAAS-FR-001` (`PRD-022` §4) | ✅ **Specified** |
| 2 | Platform Owner/Admin may change the **future** rate | `SAAS-FR-001` + `PR-1` authority | ✅ **Specified** |
| 3 | **Historical charges never change** | `SAAS-FR-003` (rate snapshot at accrual) · `SAAS-FR-004` (derived) · `SAAS-FR-005` (future-only) · `SAAS-BR-003` · `SAAS-INV-002` | ✅ **Specified** |
| 4 | Settlement due day = **15th** by default | `SAAS-FR-020` · `SAAS-FR-022` (`PRD-022` §6A) | ✅ **Specified** |
| 5 | Platform Owner/Admin may change the **future** calendar day | `SAAS-FR-022`, `PR-1` only | ✅ **Specified** |
| 6 | Already-created obligations **must not move retroactively** | `SAAS-FR-023` (**date**) · `SAAS-FR-024` (**money**) · `SAAS-XC-013` · `SAAS-XC-014` · `SAAS-INV-007` | ✅ **Specified** |
| 7 | **Cash-only** libraries can pay even at ₹0 online | `SAAS-FR-009` · `SAAS-FR-028` · `SAAS-AC-024` · §7B.1 worked | ✅ **Specified** |
| 8 | Net-off may exist but **MUST NOT be the only** method | `SAAS-BR-005` · `SAAS-AC-026`; and independently by `FEE-GAP-017`'s own recommendation 5 — *"Do **not** make net-off the only mechanism; this gap exists precisely because a library may have nothing to net against"* | ✅ **Specified twice, in two documents, in the same direction** |
| 9 | Free trial **14 days**, Platform Owner/Admin only | `SAAS-FR-017` | ✅ **Specified** |
| 10 | **3-day renewal protection mandatory V1**, not downgraded | `ADR-0036` §1, §8.1 | ⚠ **Specified as V1 intent; BLOCKED on `Q-01`** — see §2 |
| 11 | No entitlement extension, penalty, fee, proration or term deduction | `ADR-0036` §3 (6-row table) · frozen `MM-FR-111` · `MM-XC-012` **unamended** | ✅ **Specified** |
| 12 | `BC-05` student truth · `BC-20` library→LIBOORA lifecycle · `BC-31` gateway · `O-3` execution | `MP-GBR-24` · `PRD-022` §2 · BC Map L140 · `ADR-0035` §5.3 | ✅ **Specified** |

**Requirement 3, worked, because it is the one most easily got wrong:** a ₹500 collection at 3%
accrues **₹15** and stores `rate = 3%` **on the obligation**. When the rate later becomes 2.5%, that
obligation still reads **₹15**, because `SAAS-FR-004` derives the amount from the **recorded**
collection and the **recorded** rate, and `SAAS-BR-011` forbids a **period-level** rate on a
statement — the statement shape that would silently restate history as `collections × current rate`.

**Requirement 6, worked, because one rule is not enough:** changing the due day from the 15th to the
25th must not move an existing statement's **due date** (`SAAS-FR-023`) *and* must not change any
existing **amount or outstanding balance** (`SAAS-FR-024`). An implementation can satisfy either one
while violating the other, which is why they are separate obligations with separate exclusions.

---

## 2. What remains BLOCKED, and the exact authority required

**Nothing in this section is resolvable by measurement.** Each item is a decision that does not exist
anywhere in the repository at any rank.

| Blocker | The precise question | **Required authority** | Unblocks |
|---|---|---|---|
| **`Q-01`** | Does an expired membership release the seat immediately, at end-of-day, or after a grace period? | **Architecture Owner + `BC-04` owner** (per `MM-GAP-001`; `MM-FR-112` assigns seat reclamation to `BC-04`) | The **3-day renewal protection** (`ADR-0036`), `SEAT-GAP-003`, `MM-GAP-001` |
| **`D-4` / `FEE-GAP-016`** | Who owns **inbound** webhook transport, before `BC-05` verifies? | **Architecture Owner** | `PRD-008` Stage 3 **check 2**; the server-side confirmation *mechanism* |
| **`D-2` confirmation** | Confirm `O-3` (execution = Business Platform capability) and the Rank 1 reading of `MASTER_PRD` L232 vs `MP-GBR-24` L362 | **Architecture Owner** | `ADR-0035` acceptance; `FEE-GAP-002` |
| **`FEE-GAP-002`(b)/(c)** | `BC-05` has no declared architectural path to a payment rail | **Architecture Owner** | Stage 3 check 2 |
| **`SAAS-GAP-001`** | Platform Charge **eligibility base** — exactly which collections accrue a charge | **Product Owner** | `PRD-022` §4 completeness |
| **`SAAS-GAP-002`** | Configurable **ranges** + parameter **identifier** allocation | **Product Owner** (ranges) + **`BC-25`/`PRD-023`** (identifiers) | `SAAS-FR-022`, `SAAS-FR-001`, `SAAS-FR-017` traceability |
| **`SAAS-GAP-003`** | Library-initiated **outbound remittance** has no described shape | **Architecture Owner** | Cash-only settlement **rail** (not the requirement) |
| **`FEE-GAP-017`** | The **same** cash-only question on the `PRD-008` side: which context owns the **commission receivable**, which capability executes the library's **outbound** settlement, and which role may initiate it, when there is nothing to net off | **Five, jointly** — **`BC-20` owner** (receivable aggregate, settlement obligation, historical-rate snapshot) + **Architecture Owner** (whether the `BC-05` → `BC-20` basis fact travels by event or port; whether `O-3` covers **outbound library-initiated** movement) + **`PRD-001` owner + `BC-18`** (the named permission, and `TR-2` explicitly) + **Governance Owner** (opening `PRD-022`) + **Product Owner** (the 3% value) | Cash-only settlement **execution**. Recorded at `PRD-008` **v0.8**, still **OPEN** at **v1.0** |
| **`SAAS-GAP-004`** | **No enumerated permission** for settlement, for any role | **Authorization owner** (`BC-18`/`PRD-001`) + **Product Owner** (whether `TR-2` qualifies) | `SAAS-FR-016` |
| **`SAAS-GAP-005`** | Trial **eligibility identity** | **Architecture Owner** + **`PRD-001`** | `SAAS-FR-018`, `SAAS-BR-009` |
| **`SAAS-GAP-006`** | **Stage 3 architecture review not performed** | **Architecture Owner** | `PRD-022` Stage 4 |
| **`SAAS-GAP-007`** | A configured due day **above 28** has no defined February behaviour | **Product Owner** (+ `BC-25` for the range) | *Configurability only.* The **15th default is unaffected** |

**Measured totals:** `PRD-022` **7 open gaps**, all 7 blocking Stage 4 and Freeze. `PRD-008`
**17 open gaps**, **6 blocking Stage 4**, **11 blocking Freeze**. **No gap was closed by this pass.**

> **A correction this pass made to its own first draft.** The first draft of this record answered requirements 7 and 8 from `PRD-022` alone and did **not** cite **`FEE-GAP-017`**. That was a defect: `FEE-GAP-017` was added to `PRD-008` at **v0.8** and is **still OPEN at v1.0**, and it asks the cash-only question in the one place `PRD-022` cannot — *whose money is the receivable*. It is now the row above. Two further carried-forward figures were re-measured and were **wrong in the flattering direction**: `PRD-008` is at **v1.0**, not v0.7, and the string `BC-32` occurs on **33 lines across 14 files** — measured at **`b570c5a`, before this record existed** — not zero. *(This record adds more, so the figure is pinned to that commit rather than left to rot: a count that includes the document doing the counting is not a measurement.)* Every one of those 33 was inspected: **all are denials** — *"No `BC-32`"*, *"count remains 31"*, *"`O-1` rejected"*. **No `BC-32` is declared anywhere, and none is declared here.** A count of zero would have been the easier claim to make and would have been false.

> **Why requirement 10 is listed as "specified but blocked" rather than resolved.** The **requirement**
> is preserved exactly as instructed — mandatory V1, 3 days, no downgrade, no penalty, no term
> deduction. What is blocked is not the requirement but the **seat-release timing** it depends on,
> which `MM-FR-112` places with `BC-04`. `ADR-0036` proposes the minimum amendment to **`PRD-007`
> only** and amends **`PRD-005` not at all** — but it remains **`PROPOSED`**, so it binds nothing.

---

---

## 3. The webhook question, resolved as far as the repository permits

The instruction was specific: *"Resolve webhook/inbound ownership using existing architecture; do NOT
create `BC-32` unless `AR-1` proves it is required."* That is exactly the right test, and it was
applied. The outcome has two halves, and they must not be conflated.

### 3.1 What `AR-1` actually settles — `BC-32` is REFUSED

`AR-1` (`ARCHITECTURE_RULINGS.md` L23-37, Rank 4, authoritative) supplies a four-criteria test for
whether something is a bounded context. Read verbatim, a thing is **not** a context when it:

- owns **no aggregate**
- owns **no invariant**
- owns **no business state**
- only orchestrates read models / delegates all domain operations to their owning modules

Applied to a webhook receiver, measured against the repository:

| `AR-1` criterion | Measured for inbound webhook transport | Source |
|---|---|---|
| Owns an aggregate? | **No.** `FeeLedger` is `BC-05`'s | BC Map **L374** |
| Owns an invariant? | **No.** Idempotency and server-side verification are already `BC-05`'s | `FEE-INV-005` (L887), `FEE-BR-016` (L889) |
| Owns business state? | **No.** An inbound message is **evidence**, never an instruction | `FEE-BR-014` (L804) — *"Client-side success is a hint, never a financial fact"* |
| Delegates all domain operations? | **Yes.** It validates and forwards; `BC-05` decides | `ADR-0035` §5.5 |

**Conclusion — and this half IS resolved:** `AR-1` does not merely fail to require `BC-32`, it
**affirmatively refuses** it. A receiver that owns no aggregate, no invariant and no business state is
a **capability**, not a context. Precedent is exact: `PRD_REGISTRY.md` **L355** applied this same test
and recorded *"**no `BC-32` was created** and the context count remains 31."*

**Measured confirmation:** `BC-32` occurrences in the Rank 4 BC Map = **0**. Context count = **31**.
**No `BC-32` was created by this pass, and `AR-1` is the reason.**

### 3.2 What `AR-1` cannot do — and this half stays BLOCKED

`AR-1` answers *"is it a context?"* (**no**). It does **not** answer *"then which existing capability
owns it?"* — and that second question is `D-4`.

| Candidate | Measured | Verdict |
|---|---|---|
| `BC-31` Integration | BC Map **L140**, quoted exactly as written — *"Owns outbound third-party contracts, credentials, retries, idempotent delivery."* **(The source carries no emphasis; an earlier draft of this record bolded "outbound" inside what it labelled a verbatim quote. Emphasis added silently to a quotation is a citation defect even when it does not change the meaning, so the quote is restored and the emphasis moved to this note.)** | ⛔ **Outbound only.** Inbound is outside its stated scope. **`BC-31` must not be assumed to own inbound** |
| BC Map, anywhere | `grep -ci webhook` = **0** · `grep -ci inbound` = **0** | ⛔ No candidate at Rank 4 |
| EA "API Platform" (L165) / `Webhook Reconciliation` (L1407) | Exists, and is nested under Business Platform — descriptively symmetric with `O-3` | ⛔ **Holds no `BC-` identifier**, and the EA is **descriptive** (`DOCUMENTATION_BASELINE.md` L139): it *describes* an owner it **cannot confer** |
| `platform/integration` manifest module block | **Absent.** The name appears only as a rank entry (`module_dependencies.yaml` L40) and as a port target (L409) | ⛔ Nothing to attach ownership to without a decision |

**`FEE-GAP-016` therefore remains OPEN, and Stage 3 check 2 remains ⛔ BLOCKED.**

### 3.3 The precedent trap, re-tested and reproduced

`ADR-0035` §5.5a records a prior pass that mistook EA **L1407** for the missing owner. I re-measured
**L1407** in this pass. The result reproduces §3.4's original disposal exactly: the line exists, it is
descriptively symmetric with `O-3`, and it **still cannot confer ownership** because the EA is
descriptive by baseline designation. **This is not a new finding and is not reported as one.**

### 3.4 What is already settled about webhooks and needs no decision at all

Worth stating, because it is easy to mistake an open **ownership** question for an open **safety**
question. They are not the same, and the safety half is already closed:

| Already binding today | Rule |
|---|---|
| A webhook may **never** write financial truth | `FEE-BR-014` — client/inbound success is a **hint** |
| Confirmation must be **server-side** | `FEE-BR-016` |
| Replay/duplicate protection is mandatory | `FEE-INV-005` — no two confirmed payments share an idempotency key |
| Financial truth stays in `BC-05` | `MP-GBR-24`, BC Map L374 |

So the open question is *"who receives the message?"* — **not** *"may an unverified message move
money?"*, which is already answered **no**, independently of who owns the receiver.

---

## 4. Boundary integrity — re-verified, unchanged

| Invariant | Measured state |
|---|---|
| `BC-05` owns student financial truth | ✅ Unchanged. `FeeLedger`/`FeePayment`/`Receipt` remain `BC-05`'s |
| `BC-20` owns library→LIBOORA billing/settlement lifecycle | ✅ Unchanged. `Subscription`, `SubscriptionInvoice` |
| `BC-31` owns gateway integration | ✅ Unchanged, **outbound** |
| `O-3` — execution is a Business Platform capability | ✅ Recorded in `ADR-0035` §5.3 · **still `PROPOSED`** |
| The two money flows never share a model | ✅ `MP-GBR-24`; `SAAS-XC-*`; `FEE-XC-023` |
| Context count | ✅ **31.** No `BC-32` |

**The student↔platform boundary, restated as arithmetic:** 100 cash collections of ₹500 produce
**₹50,000** of *student* revenue in `BC-05` and a **₹1,500** *platform* obligation in `BC-20`.
Settling the ₹1,500 leaves student revenue at ₹50,000, every `FeeLedger` balance unchanged, and no
receipt amount moved (`SAAS-AC-027`). The 3% never appears in `FeePayment`.

---

## 5. Stage status

| Stage | Document | Status | Cause |
|---|---|---|---|
| **Stage 3** (Architecture Review) | `PRD-008` | ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 BLOCKED** | Check 2 blocked on **`FEE-GAP-002`(b)/(c)** and **`FEE-GAP-016`** |
| **Stage 3** | `PRD-022` | ⛔ **NOT PERFORMED** | **`SAAS-GAP-006`** — requires Architecture Owner |
| **Stage 4** (Implementation) | `PRD-008` | ⛔ **MUST NOT START** | Stage 3 not passed; 6 gaps block Stage 4 |
| **Stage 4** | `PRD-022` | ⛔ **MUST NOT START** | Stage 3 not performed; 7 gaps block Stage 4 |

**Stage 3 cannot be performed by this pass**, and that is not a technicality: `PRD_LIFECYCLE.md`
**L277** assigns Stage 3 to the **Architecture reviewer**, *"authority to require an ADR"*. Performing
it here would be the exact act the instruction forbids.

---

## 6. What this pass deliberately did NOT do

| Not done | Why |
|---|---|
| Accept `ADR-0035` or `ADR-0036` | *"Do not self-accept ADRs."* Both remain **`PROPOSED`** |
| Create `BC-32` | `AR-1` **refuses** it (§3.1). Count stays **31** |
| Name a webhook-ingress owner | No source at any rank names one. Inventing it is forbidden |
| Write a webhook contract, endpoint, payload, signature scheme or retry policy | Forbidden, and blocked on `FEE-GAP-016` |
| Invent a permission for settlement | `SAAS-GAP-004` — belongs to `BC-18`/`PRD-001` |
| Invent a configuration ID (`CFG-*`, `SEAT-CFG-*`) or a configurable **range** | `SAAS-GAP-002`; `CONFIGURATION_GUIDE` §5 requires an ADR **and** a PRD amendment |
| Add a dependency edge or modify `module_dependencies.yaml` | `ADR-0035` §5.6's declaration is a **proposal**; applying it requires acceptance first |
| Perform Stage 3, freeze any PRD, or close any gap | Authority not held. **Gap count rose 6→7; nothing closed** |
| Downgrade the 3-day protection to V2 | Explicitly forbidden. It stays **mandatory V1 at 3 days** |
| Modify any frozen document | 7 protected hashes + `PRD-006` body md5 verified unchanged |
| Write or change any Dart source | Documentation-only pass |

---

## 7. Verification

| Gate | Exit | Classification |
|---|---|---|
| `prd004_traceability` | 1 | pre-existing |
| `prd005_task_coverage` | 0 | — |
| `prd005_traceability` | 1 | pre-existing |
| `prd006_task_coverage` | 0 | — |
| `prd006_traceability` | 0 | — |
| `prd007_task_coverage` | 0 | — |
| `prd007_traceability` | 1 | pre-existing |
| `check_module_boundaries.dart` | 1 | pre-existing — same **12** `ADR-0012` debts |
| `verify36.py` | 0 | 85 / 0 |
| `verify008.py` | 0 | 147 / 0 |
| `verify022.py` | 0 | 127 / 0 |

**No gate was weakened, relaxed, or had an expectation edited to suit an outcome.**

---

## 8. The three decisions that would unblock the most

Offered as **routing**, not as recommendation — each is the named authority's to take:

1. **`Q-01`** → Architecture Owner + `BC-04` owner. Unblocks the **3-day renewal protection**,
   `SEAT-GAP-003` and `MM-GAP-001` together. `ADR-0036` has already reduced the required amendment to
   `PRD-007` alone, over an allocation `SEAT-BR-024` **already** flags.
2. **`D-4` / `FEE-GAP-016`** → Architecture Owner. Unblocks **Stage 3 check 2** for `PRD-008`.
   `AR-1` has already excluded `BC-32`, so the remaining choice is *which existing capability*.
3. **`SAAS-GAP-006`** → Architecture Owner. Unblocks `PRD-022`'s Stage 3 entirely.

---

*End of governance resolution record. **RECORD ONLY** — nothing accepted, nothing frozen, nothing
closed, no gap resolved, no authority exercised beyond measurement. `AR-1` refuses `BC-32`; every
other blocker awaits a named human authority.*
