# ADR-0130 — Student payment in V1 is **cash only**; the LIBOORA platform charge and its settlement are **V2**

| Field | Value |
|---|---|
| **ADR** | `ADR-0130` |
| **Title** | Student payment in V1 is **cash only**; the LIBOORA platform charge and library → LIBOORA settlement are **deferred to V2** |
| **Date** | 2026-09-10 |
| **Status** | ⭐ **Accepted** — by direct, explicit conferral of the human principal of this engagement, jointly exercising **Product Owner**, **Architecture Owner**, **`BC-20` Owner**, **Authorization (`BC-18`/`PRD-001`)** and **Governance Owner** authority, scoped to this act and **nothing else**. Same disclosure as `ADR-0035`, `ADR-0037`, `ADR-0043`, `ADR-0046` and `ADR-0129`: ⛔ **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *"a conferral for one act is not a standing licence"* (`ADR-0033` §7.1) — every office ⛔ **reverts on completion** |
| **Supersedes** | ⭐ **`ADR-0046`** — **for its V1 limb only.** See §5 |
| **Amends** | **`MASTER_PRD.md`** (Rank 1) — `MP-GBR-18`, `MP-RSK-04`, `MP-DEP-04`, strictly in place · **`PRD-022_SAAS-BILLING.md`** (Rank 3 `DRAFT`) · **`DOCUMENTATION_BASELINE.md`** (§7 rules 2–4) |
| **Does NOT amend** | ⛔ **`PRD-008_REVENUE-AND-FINANCE.md`** (FROZEN — see §7) · ⛔ **`ADR-0046`** (byte-unchanged — see §5) · ⛔ `ADR-0035` · ⛔ `ADR-0037` · ⛔ `ADR-0043` · ⛔ `ADR-0045` · ⛔ `Authentication_PRD_v2.md` / `v3.md` / `prd-v2/` / `prd-v3/` · ⛔ BC Map (Rank 4) · ⛔ Dependency Matrix (Rank 4) · ⛔ `tool/module_dependencies.yaml` · ⛔ the EA (Rank 6) |
| **Governs** | V1/V2 student payment method scope · V1/V2 LIBOORA platform-charge scope · `SAAS-GAP-003` and `SAAS-GAP-004` classification · `SAAS-FR-016`'s V1 reading |
| **Outcome** | **Student payment in V1 is cash only. UPI, card, online payment and gateway are V2. The LIBOORA platform charge and library → LIBOORA settlement are V2.** ⛔ **No V2 provider is selected. No settlement mechanism is invented. No implementation is authorised** |

---

## 1. The decision

### 1.1 Student → library payment (flow **A**)

⭐ **In Version 1, a student pays a library in CASH ONLY.**

| Capability | V1 | V2 |
|---|---|---|
| Student **cash** payment | ⭐ **YES** | YES |
| Student **UPI** payment | ⛔ **NO** | **DEFERRED** |
| Student **card** payment | ⛔ **NO** | **DEFERRED** |
| Student **online** payment | ⛔ **NO** | **DEFERRED** |
| Student **payment gateway** | ⛔ **NO** | **DEFERRED** |

### 1.2 Library → LIBOORA platform charge and settlement (flow **B**)

⭐ **The LIBOORA platform charge / extra charge / commission mechanism is NOT part of Version 1.**

| Capability | V1 | V2 |
|---|---|---|
| LIBOORA platform / extra charge | ⛔ **NO — out of V1 scope** | **DEFERRED** |
| Library → LIBOORA settlement | ⛔ **NO — out of V1 scope** | **DEFERRED** |
| Settlement **instrument** | ⛔ **NONE REQUIRED in V1** | **TO BE DESIGNED** |
| Settlement **authorization** | ⛔ **NONE REQUIRED in V1** | **TO BE DESIGNED** |
| Settlement **architecture** (edge/port/contract) | ⛔ **NONE REQUIRED in V1** | **TO BE DESIGNED** |
| Gateway **provider** | ⛔ **NONE REQUIRED in V1** | ⛔ **SEPARATE V2 DECISION** |

⚠ **"NO" in the V1 column means the capability is DELIBERATELY OUT OF V1 SCOPE.** It does **not** mean the
capability is broken, missing, defective or awaiting a V1 implementation. ⛔ **No V1 blocker is created by its
absence.**

### 1.3 The two flows are distinct and must not be conflated

⭐ Flow **A** (student → library) and flow **B** (library → LIBOORA) are **separate business flows**, and Rank 1
**`MP-GBR-24`** already requires exactly that separation:

> *"Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by a **library to
> LIBOORA** (`BC-20`). They must never share a model, a table or a metric."*

⭐⭐ **Therefore the absence of a mechanism for B does NOT invalidate A.** This ADR records that reading
explicitly, because an earlier governance pass **wrongly treated a V1 settlement instrument as a prerequisite for
cash-only V1** — see §2. ⛔ **`MP-GBR-24` is NOT amended by this ADR** and remains intact.

---

## 2. The interpretation this ADR corrects

⚠ A prior read-only audit concluded that cash-only V1 could not be recorded because **no lawful V1 settlement
instrument exists**: bank transfer is expressly not V1 (`ADR-0043` §4.1), net-off may not be the sole mechanism
(`SAAS-BR-005`), and `SAAS-XC-006` forbids `PRD-022` from naming a bank-account structure. That measurement was
**correct on its own terms** and is ⛔ **not withdrawn**.

⭐ **What was wrong was the inference, not the measurement.** The audit treated flow **B** as a V1 prerequisite. The
Product Owner has now determined that **flow B is not in V1 at all**. Once B is out of V1 scope, the missing
instrument is **not a gap in V1** — it is **V2 design work that has not started**.

⛔ **This ADR therefore resolves the blocker by SCOPE, not by inventing a mechanism.** No instrument, rail,
provider or permission is created anywhere in this decision.

---

## 3. `SAAS-GAP-003` — reclassified **V2 / DEFERRED**

**Question, as `PRD-022` states it:** can `E-25` (`BC-20` → `BC-31`) and `ADR-0035`'s `O-3` carry a
**library-initiated outbound** remittance?

⭐ **Architecture determination, made on the evidence and recorded rather than assumed:**

| Source | Measured text | Consequence |
|---|---|---|
BC Map **L334** | `E-25 \| BC-20 Billing \| BC-31 Integration \| CF \| Sync port \| **Gateway abstraction**; Billing knows no vendor names` | `E-25` is a **gateway** abstraction |
BC Map **L382** | BC-20 holds `PaymentAttempt`, `DunningState`; *"payment idempotent **by gateway reference**"* | Every described flow is **LIBOORA pulling via a gateway** |
BC Map **L140** | `BC-31` owns *"**outbound** third-party contracts, credentials, retries"* | Direction is not obviously wrong, but vendor-mediated |
⭐ **`ADR-0035` §5.2 (`O-3`)** | *"**Student → library** payment execution is a capability of the Business Platform"* | ⛔ **Scoped to student → library — the OPPOSITE direction** |

⛔ **`O-3` does NOT cover library → LIBOORA movement**, and reading it as though it did would extend an
`Accepted` ADR by interpretation. ⛔ **`E-25` is not adopted for this purpose either**, because under cash-only V1
there is **no gateway**, and reusing a gateway abstraction would smuggle a V1 gateway dependency into the very
decision that removes one.

⭐ **Classification: `SAAS-GAP-003` = V2 / DEFERRED — library → LIBOORA settlement architecture.**

⛔ **It is NOT claimed to be technically resolved.** ⛔ No V1 edge is created · ⛔ **no `E-34` allocated** · ⛔ no
new port · ⛔ no contract · ⛔ `ADR-0035` is **not** extended, amended or superseded · ⛔ `E-25` is **preserved
unchanged** and remains available to a future V2 decision.

---

## 4. `SAAS-GAP-004` — reclassified **V2 / DEFERRED**

**Question:** which permission lets `TR-1` Owner settle a Platform Charge, and may `TR-2` Manager settle at all?

⭐ **Because settlement is not a V1 capability (§1.2), no V1 settlement authority is required.**

| Rule | Disposition |
|---|---|
**`AUTH-7.22`** — *"The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted"* | ⭐ **PRESERVED INTACT and NOT reinterpreted** |
New permission identifier | ⛔ **NOT created.** Measured: enumerated permissions in the catalogue = **0**; `PERM-*` repo-wide = **2**, both a *withdrawal* record in `PRD-021A`. **No naming convention exists to extend**, so inventing one was refused |
Authentication PRD **v4.0** | ⛔ **NOT created.** The route was **expressly revoked** by the conferral |
`Authentication_PRD_v2.md` / `v3.md` / `prd-v2/` / `prd-v3/` | ⛔ **BYTE-UNCHANGED** |
`TR-1` Owner V1 settlement authority | ⛔ **NOT assigned** |
`TR-2` Manager V1 settlement authority | ⛔ **NOT assigned.** `SAAS-BR-007`'s safe default (*"Manager cannot settle"*) stands unchanged |

⭐ **Classification: `SAAS-GAP-004` = V2 / DEFERRED — settlement authorization, to be governed when V2 settlement
is designed.**

⛔ **The absence of V1 settlement authorization is therefore NOT a V1 blocker.**

⚠ **Recorded for the future act, not acted on:** when V2 settlement is designed, the authority question is
genuinely open between (i) declaring a permission in `AUTH-7.22`'s catalogue, and (ii) the
`ADR-0043` §5.1 / `FEE-GAP-007` route — *"Owner may explicitly grant … **using the existing
permission/access-control mechanism**. **Do not invent a new permission ID**"* — via `MP-GBR-20`/`21`/`23`. ⛔ **This
ADR does not choose between them.** It also records the measured caution that `TR-1`'s declared authority
(`prd-v2/02` **L159**) is *"financial and revenue **visibility**"*, which is **not** outbound remittance execution,
and that `MP-GBR-21`'s scope register (`self`, `guardianOf`, `tenantWide`) does not obviously reach an act whose
effect lands outside the tenant.

---

## 5. `ADR-0046` — superseded **for its V1 limb only**

`ADR-0046` (**Accepted**, 2026-08-15) decided: *"**The V1 payment gateway provider is `Razorpay`**."*

⛔ **`ADR-0046` is NOT edited.** `ADR-INDEX.md` **L206**: *"**Never edit an Accepted ADR's decision text —
supersede it with a new ADR**"*; **L207**: *"An ADR supersedes; it does not delete."* Its file remains
byte-unchanged and its historical traceability is fully preserved.

| Limb of `ADR-0046` | Disposition under this ADR |
|---|---|
⭐ **"The V1 payment gateway provider is Razorpay"** | ⛔ **SUPERSEDED.** There is **no V1 payment gateway** for student payment, so there is **no V1 provider** to select |
Razorpay as a **V2** provider | ⛔ **NOT carried forward. NOT selected. NOT rejected.** A V2 provider selection is a **separate governed decision** (`ADR-0046` §7's `Q-B31` remains **OPEN**) |
*"No wire contract is created"* | ⭐ **Still true** — none is created here either |
Its record that Razorpay was the only provider ever named | ⭐ **Preserved as history** |

⭐⭐ **Stated plainly so no future reader is misled: Razorpay WAS selected as the V1 gateway provider, by a
properly Accepted ADR, on 2026-08-15.** ⛔ This ADR does **not** pretend otherwise. That decision is superseded
because **its subject — V1 gateway payment — has been removed from V1 scope**, not because it was wrong when made.

⚠ **This is the repository's FIRST ADR supersession.** Measured: 117 ADR files, **0** previously superseded. Two
further supersessions (`ADR-0002`, `ADR-0005`) are **already owed** by `ADR-0129` §7 and remain **OUTSTANDING** —
⛔ **this ADR does not execute them.**

---

## 6. `MASTER_PRD` — three Rank 1 cells amended, strictly in place

⭐ Each cell is amended **in place** with **zero line shift**, and prior text is **retained verbatim**.
Measured before the write: **416 line-number citations across 125 documents** point into `MASTER_PRD.md`, the
highest at **L678**, and ⭐ **none of L359, L554 or L571 is cited** — so no citation resolves differently after
this amendment.

| Line | ID | Prior text | v1.9 disposition |
|---|---|---|---|
**L359** | `MP-GBR-18` | *"Payment capture is idempotent **by gateway reference**."* | ⭐ **AMENDED.** Attendance idempotency **unchanged**. Payment-capture idempotency **by gateway reference** is **V2**, there being no V1 gateway; **V1 cash capture remains idempotent and server-authoritative** per `ADR-0037` |
**L554** | `MP-RSK-04` | *"Double seat allocation or duplicate payment capture."* | ⭐ **RE-SCOPED.** Duplicate **digital/gateway** payment capture is a **V2** risk. Double seat allocation is **unchanged** as a V1 risk; duplicate **cash** capture remains controlled by server-authoritative recording |
**L571** | `MP-DEP-04` | *"Payment gateway onboarding \| External \| SaaS Billing, fee collection"* | ⭐ **RE-SCOPED to V2.** ⛔ **Gateway onboarding is NOT a V1 external dependency** for student fee collection |

⛔ **`MP-GBR-24` is NOT amended** and its `BC-05`/`BC-20` boundary stands. ⛔ No other Rank 1 requirement is
touched — authentication, `AccountId`, `PersonId`, identity, tenancy, security and all other `MP-*` rules are
**unchanged**.

⚠ **`MP-DEP-03` (SMS provider + DLT) is NOT closed, changed or reinterpreted** by this ADR.

---

## 7. `PRD-008` — FROZEN, not edited; the conflict is recorded, not repaired

`PRD-008_REVENUE-AND-FINANCE.md` **v1.7** is **FROZEN** and **authoritative** — `ADR-0049` **L12** closes its
Stage 7 and moves the registry `DRAFT` → `FROZEN`; `PRD_REGISTRY.md` **L245** records `FROZEN`;
`DOCUMENTATION_BASELINE.md` **L175** records *"Authoritative — the Revenue & Finance baseline"*.

⛔ **It is NOT edited by this ADR — not one byte.** ⛔ Its stale self-description (*"v1.7 — DRAFT … NOT frozen"*)
is ⛔ **NOT rewritten**, on its own L11 rule that *"Status is **conferred** by admission to the baseline, **never
claimed by a document about itself**."*

⚠ **The exact conflict, recorded so it is not lost:** `PRD-008` §6.1 lists as **V1 in scope** — **L209** UPI
payment · **L210** Card payment · **L211** Online payment · **L213** Payment verification · **L214** Webhook
reconciliation. Those five rows **contradict §1.1 of this ADR**.

⭐ **Precedence resolves the contradiction without an edit.** `DOCUMENTATION_BASELINE.md` §4 ranks **Rank 2
Accepted ADRs above Rank 3 module PRDs**, so this ADR governs and `PRD-008`'s five V1 rows are
**superseded in effect for the V1 method scope**. ⚠ The divergence is **governed and temporary**, exactly as
`ADR-0129` §7's treatment of Authentication PRD v2.0.

⛔ **The lawful repair is a `PRD-008` successor (v1.8 or a v2 re-baseline) through the approved lifecycle — a
SEPARATE governed act, NOT authorised here.** It is recorded as **outstanding** in §9.

---

## 8. `SAAS-FR-016` — reconciled, not weakened

`SAAS-FR-016` reads: *"A Platform Charge settlement **MUST** be initiated and completed only by an actor holding
an authority **declared in the authoritative authorisation model** (`BC-18`/`PRD-001`). Until such an authority
exists, the action **MUST** fail closed per `AP-9`."*

⭐ **The underlying authorization principle is PRESERVED IN FULL and is NOT reinterpreted, narrowed or weakened.**

⭐ **The correct V1 reading is that the settlement action does not exist as a V1 capability**, so the requirement
creates **no V1 settlement obligation** and its fail-closed limb is **correct and unchanged** — with nothing in V1
able to reach it. The requirement becomes **operative when V2 settlement is designed**.

⭐ `PRD-022` carries the **minimum governed amendment** to state that V1/V2 boundary explicitly, per the
conferral's §5. ⛔ Nothing else in the requirement changes.

---

## 9. What this ADR does NOT do

⛔ Enumerated so nothing is inferred:

- ⛔ **No V2 gateway provider selected** — Razorpay neither carried forward nor rejected; `Q-B31` stays **OPEN**.
- ⛔ **No settlement instrument, rail, mechanism, bank-account structure, wallet, cheque, courier, net-off or
  gateway chosen** for V1 or V2.
- ⛔ **No permission created**; **no `PERM-*` identifier**; **no Authentication change**; **no Auth PRD v4.0**.
- ⛔ **No BC Map change · no `E-34` · no new edge/port/contract · `E-25` preserved · manifest unchanged.**
- ⛔ **`ADR-0035`, `ADR-0037`, `ADR-0043`, `ADR-0045` unchanged**; ⛔ **`ADR-0002`/`ADR-0005` supersessions still
  OUTSTANDING** (`ADR-0129` §7).
- ⛔ **`PRD-008` unchanged** — its successor act is **outstanding** (§7).
- ⛔ **`SAAS-GAP-001`, `002`, `005`, `006`, `007` remain OPEN** — none is required by this decision, and none is
  closed to make the document look finished.
- ⛔ **No blocker closed** — `MP-DEP-03`, `BLK-01`, `BLK-02`, `TASK-D10`, gate 3, `H1`–`H4`, `D3`, `FEE-GAP-*` all
  stand. ⚠ **`FEE-GAP-017`** (*"a cash-only library has no lawful way to pay its LIBOORA commission"*) is **NOT
  closed**; it is **re-classified as V2 work** by §1.2, its question being about a charge that does not exist in V1.
- ⛔ **No implementation**: no code, schema, API, UI, test, migration, Supabase change, dependency, deployment,
  credential or `A-9` secret custody.
- ⛔ **No push.** `github/main` remains `267f46e5c9b191da874553ffdfaf70dbfd3720cb`.

---

## 10. Consequential work outstanding — each its own governed act

| # | Work | Authority |
|---|---|---|
1 | **`PRD-008` successor** removing UPI/card/online/verification/webhook from §6.1's V1 set | Product + Architecture + Governance (frozen-PRD lifecycle) |
2 | **V2 LIBOORA platform-charge model** — basis, who owes, when due, reconciliation, audit, idempotency | Product + `BC-20` Owner |
3 | **V2 settlement instrument + architecture** (`SAAS-GAP-003`) | Architecture Owner |
4 | **V2 settlement authorization** (`SAAS-GAP-004`) | Authorization Owner + Product Owner |
5 | **V2 gateway provider selection** (`Q-B31`) | Architecture + Product |
6 | `SAAS-GAP-001`/`002`/`005`/`006`/`007` | as registered |
7 | `ADR-0002` / `ADR-0005` supersessions | Architecture Owner (`ADR-0129` §7) |
8 | **`PRD-019` Integration successor or scope note** — its §4 Razorpay webhook contract (**39 occurrences**, `[RZP]`/`[LIB]` value tables, `ADR-0047`/`ADR-0048` acceptance criteria) is predicated on a **V1** gateway that no longer exists in V1 | Product + Architecture + `BC-31` Owner |
9 | **Enterprise Architecture correction** — `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1395**–**L1398** lists *Online Payments (V1)*, *UPI Payments (V1)* and *Card Payments (V1)* under *Student Payments (V1)* | Architecture Owner |
10 | **BC Map §8 wording review** — **L202** illustrates the `MP-GBR-24` boundary with *"BC-05: cash/UPI collected from a student at reception"*; the **boundary** it draws is correct and unaffected, only its **UPI example** is now V2 | Architecture Owner |
11 | **`MM-XC-003` review** (`PRD-MEMBERSHIP-MANAGEMENT` **L182**, ⛔ **FROZEN**) — a **prohibition** on Membership processing *"a card/UPI/cash payment"*; ⭐ **it remains CORRECT and SAFE under cash-only V1** (a prohibition over-covering a capability that no longer exists forbids nothing wrongly), so this is a **wording review only, NOT a defect and NOT a blocker** | `BC-02` Owner, at its next successor |

## 10A. Repository-wide validation sweep — every payment occurrence classified

⭐ This section exists because a scope decision that is **recorded in three documents but contradicted in eight** is not
a decision. Every occurrence of *Razorpay*, *payment gateway*, *UPI*, *card*, *online payment*, *platform charge*,
*commission* and *settlement* was swept across `docs/`, `tool/`, `lib/`, `test/` and `.github/` and classified into
exactly one of four buckets. ⛔ **Nothing found by this sweep was silently edited.**

| Bucket | Meaning | Action taken |
|---|---|---|
| **A — Active V1 claim, now corrected** | Text asserting a V1 capability this ADR removes, in a document this act may lawfully amend | ⭐ **Amended in place** — `MASTER_PRD` **L359**/**L554**/**L571**, `PRD-022` gap dispositions |
| **B — Active V1 claim in a FROZEN or ACCEPTED artifact** | Same, but the document ⛔ **must not be edited** | ⛔ **Recorded as a governed divergence, superseded IN EFFECT by rank; repair routed to a successor act** |
| **C — Historical / provenance** | A record of what was decided when | ⛔ **Left verbatim.** Editing the vocabulary of a decision record destroys the ability to audit what was known when |
| **D — Explanatory / non-normative** | Descriptive, illustrative or prohibitive text that binds nothing V1 relies on | ⛔ **Left unchanged**, reviewed and recorded |

### 10A.1 Findings

| Location | Occurrences | Bucket | Determination |
|---|---|---|---|
| `MASTER_PRD.md` **L359**, **L554**, **L571** | 3 | **A** | ⭐ **Amended in place by §6.** The only Rank 1 text asserting gateway-dependent V1 payment |
| `PRD-022` `SAAS-GAP-003`/`004`, `SAAS-FR-016`, §12.1 | 8 cells | **A** | ⭐ **Amended / reconciled by §3, §4, §8.** `DRAFT`, so lawfully amendable |
| `PRD-008` §6.1 **L209**, **L210**, **L211**, **L213**, **L214** | 5 | **B** | ⛔ **FROZEN v1.7 — NOT edited.** Superseded **IN EFFECT** by rank (baseline §4: Rank 2 > Rank 3). Repair = `PRD-008` successor, §10 row 1 |
| `PRD-019_INTEGRATION.md` §4 Razorpay webhook contract | **39** | **B** | ⚠ **The largest single concentration in the repository.** `DRAFT`, but its contract is ratified by **`ACCEPTED` `ADR-0047`/`ADR-0048`**, so ⛔ **this act may NOT rewrite it** — the acceptance would have to be superseded first. ⭐ **Routed to §10 row 8. Recorded, not repaired.** ⚠ Its §4 values remain **factually correct about Razorpay**; what changed is that **V1 no longer needs them** |
| `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1395**–**L1398** | 4 | **B/D** | ⚠ *Online / UPI / Card Payments (V1)* under *Student Payments (V1)*. ⛔ **NOT edited** — the EA is **Rank 6 and DESCRIPTIVE** (baseline §3.2: *"must follow the PRDs, never lead them"*), so it **cannot** contradict a Rank 2 ADR, it can only be **stale**. ⭐ Measured **0 inbound citations** to L1390–L1400. Routed to §10 row 9 |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L202** | 1 | **D** | ⭐ *"BC-05: cash/UPI collected from a student at reception"* — this line's **purpose** is to draw the `MP-GBR-24` boundary between `BC-05` and `BC-20`, and ⭐ **that boundary is correct, load-bearing and unaffected**; only its **UPI example** is now V2. ⛔ **NOT edited** (Rank 4, and **L202 IS cited**). Routed to §10 row 10 |
| `PRD-MEMBERSHIP-MANAGEMENT.md` **L182** (`MM-XC-003`) | 1 | **D** | ⭐ A **PROHIBITION**: Membership must not process *"a card/UPI/cash payment"*. ⭐⭐ **It remains CORRECT and SAFE** — a prohibition that over-covers a capability which no longer exists forbids nothing wrongly, and its **cash** limb is **still fully operative in V1**. ⛔ **FROZEN, NOT edited, NOT a defect, NOT a blocker.** Routed to §10 row 11 as wording review only |
| `ADR-0035`, `ADR-0037`, `ADR-0040`…`ADR-0048`, `ADR-0116`, `ADR-0120`, `ADR-0124`, `ADR-INDEX` | ~80 | **C** | ⛔ **Left verbatim.** `ACCEPTED` ADRs and their index — `ADR-INDEX` **L207**: *"An ADR supersedes; it does not delete."* Only `ADR-0046`'s **V1 limb** is superseded, and even it is **byte-unchanged** |
| `PAYMENT_GOVERNANCE_RESOLUTION.md` | several | **D** | ⛔ **NOT edited.** Self-declared *"RECORD ONLY — binds nothing"* and **not ranked**; it cannot contradict a Rank 2 ADR |
| `IMPLEMENTATION_BLOCKER_REGISTER.md`, `IMPL-020`, `DEVELOPER_HANDOFF` and all of `40-implementation/` | several | **C/D** | ⛔ **NOT edited and ⛔ NO BLOCKER CLOSED.** Implementation records follow the specification; they do not amend it |
| `lib/`, `test/`, `packages/`, `tool/`, `.github/` | **0** | — | ⭐ **Measured zero payment-provider occurrences.** ⛔ **No code, schema, migration, test or CI file is touched by this act** |

### 10A.2 What the sweep proves, and what it does not

⭐ **Proves:** every V1-asserting occurrence is now either **corrected** (bucket A) or **explicitly recorded as a
governed divergence with a named repair route** (bucket B). ⛔ **Does NOT prove** that the repository is internally
consistent — ⚠ **it is knowingly NOT**, in the four places routed to §10 rows 8–11. ⭐ **That inconsistency is
disclosed rather than concealed, and none of it is a V1 implementation blocker**: buckets C and D bind nothing, and
bucket B is resolved **at read time** by the §4 precedence rule, which exists for exactly this situation.

⛔⛔ **No gap was closed, no blocker discharged, no frozen artifact edited and no V2 mechanism invented to make this
sweep terminate tidily.**

---

---

## 11. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-10 | Created and **Accepted** in the same governed act. Records: student payment V1 = **cash only**; UPI/card/online/gateway = **V2 deferred**; LIBOORA platform charge and library → LIBOORA settlement = **V2 deferred**; `SAAS-GAP-003` and `SAAS-GAP-004` = **V2/deferred**; `SAAS-FR-016` reconciled without weakening; **`ADR-0046` superseded for its V1 limb only, byte-unchanged**; `MASTER_PRD` `MP-GBR-18`/`MP-RSK-04`/`MP-DEP-04` amended in place. ⛔ No provider, instrument, mechanism, permission, edge or implementation created. |
