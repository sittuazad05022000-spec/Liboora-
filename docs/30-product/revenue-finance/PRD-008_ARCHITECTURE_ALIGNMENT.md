# `PRD-008` Revenue & Finance v1.0 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 3) |
| **Subject** | [`PRD-008_REVENUE-AND-FINANCE.md`](PRD-008_REVENUE-AND-FINANCE.md) — `PRD-008`, `BC-05` Fee & Collection, **v1.2 `DRAFT`** *(reviewed at v1.0 and re-reviewed at v1.1; both verdicts retained below)* |
| **Gate addressed by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) · [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Reviewed at** | **`36bd461` — EIGHTH PASS (v1.2), the pass in which check 2 finally PASSES.** Re-measured after **`ADR-0037`** was `ACCEPTED` by conferral of **Product Owner** authority, closing `FEE-GAP-002`(c) — the last of check 2's three stated reasons. **Verdict ✅ ALIGNED 6/6**; all three prior verdicts are retained below, not overwritten. *Superseded:* **`995a4c8` — SEVENTH PASS (v1.1), the re-run requested after the conferral.** Re-measured after `ADR-0035` was **`ACCEPTED`** and `ADR-0036` **`PARTLY ACCEPTED`**, and after the PRD's gap ledger was updated to mark **`FEE-GAP-016` RESOLVED** and `FEE-GAP-002`(b) **in force**. **The verdict is UNCHANGED — ⛔ NOT ALIGNED, 5 of 6 — and the number of reasons check 2 fails falls from three to one.** See **§9.3d**, which states the surviving reason and why it is not enough to pass. `01a6da8` — **sixth pass** (v1.0). The sixth pass re-measured the PRD after a **documentation-only correction** that added **no identifier**: §39.2's v0.9 finding — that frozen rules *"forbid"* 3-day renewal protection — was **retracted and corrected**, because it conflated V1-forbidden **money arithmetic** and **entitlement extension** with the genuinely **open** question of **seat-release timing** (`Q-01`). **The verdict is unchanged.** A correction to a finding about *another module's* frozen rules cannot move a `BC-05` Stage 3 check: it touches no integration edge, no context boundary, no authorisation decision and no tenant isolation. See §9.3c. `914c543` — **fifth pass** (v0.9). The fifth pass re-measured the PRD after a **documentation-only** revision that added **no identifier**: a terminology note (`LIBOORA PLATFORM CHARGE` owned by `PRD-022`), two gap rows amended to record that a **home now exists while the question stays OPEN**, and two new subsections (§39.1 gap reconciliation, §39.2 frozen-rule findings). **The verdict is unchanged, and so is the reason.** Nothing in this revision touches an integration edge, a context boundary, an authorisation decision or tenant isolation, so **no check could change state**; see §9.3b. `407203e` — **fourth pass** (v0.8). The fourth pass reviewed the CB28 addition (`FEE-XC-023`, `FEE-AC-084`, `FEE-GAP-017`) and **did not change the verdict**; see §9.3a. The third pass was written at `ebf2440` (v0.7). The second pass was written at `3d98330` against v0.6; its §3.5.4 *"narrows the decision without taking it"* is **now superseded** — the decision **has been taken** and recorded (§3.5.5). The first pass was written at `61e6950` against v0.5. The first pass was written at `61e6950` against v0.5 and its check-2 reasoning is **superseded in part** by §3 and §10 below |
| **PRD hash at review** | `0b1a32b63ba70d2045e8d7677c71aa5a45bf55a64e95e166a87b099e0d00a297` — re-measured at **v1.2, 2,536 lines, 263,566 characters**. *(Measured with Python `len()` and a byte-level `sha256`; `wc -m` reports **bytes** under this locale and must not be used for a character count.)* *The v1.1 hash* `8972eed909b4a2198d644cdb256055d027f82660f2106198e3553656417258fc` *is superseded — it was re-measured at* **v1.1, 2,536 lines** *(the v1.0 hash `b3d51108…` at 2,512 lines is superseded)*. Earlier: `b3d5110824e3efb0588825aaf34890c650ea39f5f85c17d1eafecdebae300ea8` — measured at **v1.0, 2,512 lines** *(the v0.9 hash `dd4dc89e…` at 2,481 lines is superseded)*. Earlier: `dd4dc89ed52a7184fb784c57a491c3803747d3db4eccc4d8e31ccb3cbd2b219a` at **v0.9, 2,481 lines** *(the v0.8 hash `9f650ade…` at 2,411 lines is superseded)*. Earlier: `9f650ade436204ae52c0d58d3783756a1a86454bbe0b74f7e25ccd73d25fe006` at **v0.8, 2,411 lines** *(the v0.7 hash `b4113817…` at 2,350 lines is superseded)*. Earlier: **v0.7, 2,350 lines** *(the v0.6 hash `d6bb63d9…` at 2,316 lines and the v0.5 hash `3f91476a…` are now stale and are retained only in the change notes)* |
| **Companion ADR (v1.2)** | [`ADR-0037`](../../00-governance/adr/ADR-0037-cash-payment-server-authoritative-no-offline-write.md) — **`ACCEPTED`** by conferral of **Product Owner** authority, 2026-08-15. Closes `FEE-GAP-002`(c) by **dissolving** it: cash is supported, financial recording is **server-authoritative**, and there is **no** offline financial write, queue, local ledger or later sync — therefore **no `BC-05` → `BC-30` edge** and **no `BC-32`**. It **amends nothing**: `FEE-FR-061`, `FEE-XC-022`, `FEE-PO-006`, `FEE-PO-007` and `FEE-FR-029` already specified the behaviour and are unchanged. **This record does not accept that ADR** — it observes that an authority did. |
| **Companion ADR** | [`ADR-0035`](../../00-governance/adr/ADR-0035-bc-05-payment-gateway-path.md) — **`ACCEPTED` at v1.1** — *"In force. Binding on all implementation"* — **by direct conferral of Architecture Owner authority by the human principal**, disclosed on the `ADR-0032` §5.2 / `ADR-0033` pattern: **no ARB quorum, attendee list, sign-off date or Security review is asserted.** `D-1` and `D-2` therefore **now bind**, and `D-4` is answered in its new §5.5b. *Superseded text, retained so the earlier position stays readable:* *"**`PROPOSED`, not accepted.** Its `D-2` is now **DECIDED and recorded** (`O-3`), but a recorded decision in a `PROPOSED` ADR **is not in force and binds nothing**. **It was not self-accepted:** conferred Architecture Owner authority permits *recording* the decision; marking it `Accepted` was expressly withheld"*. **The withholding was correct at the time — what changed is not the reasoning but the arrival of a second, explicit conferral** (`ADR-0035` §7.2). Second companion: [`ADR-0036`](../../00-governance/adr/ADR-0036-three-day-renewal-protection-q01.md) — **`PARTLY ACCEPTED`, on its questions 1 and 3 only; question 2 remains OPEN.** It bears on `FEE-GAP-013`, **not** on any Stage 3 check of this PRD |
| **Mandate** | **Stage 3 only.** No PRD requirement added or changed by this record, no ranked document touched, no registry or baseline update, **no freeze**. Stages 4–7 not started. ⚠ **Amended at v1.1:** the phrase *"**no ADR accepted**"* is **withdrawn as a description of the surrounding pass, and retained as a description of THIS record.** `ADR-0035` and `ADR-0036` **were** accepted at v1.1 — **by conferral, in their own files, by their own authority** — and **this review neither performed nor authorised that acceptance.** A Stage 3 record must not accept the ADR it depends on; **it may only observe that someone with authority did.** That distinction is the whole reason this row is amended rather than deleted |
| **Verdict at v1.2 — THE PASS** | ✅ **ALIGNED — 6 of 6 checks PASS, 0 BLOCKED.** **The verdict moves for the first time in eight passes.** Check 2's third and last stated reason, `FEE-GAP-002`(c), is **CLOSED by `ADR-0037`** — and closed by **denying its premise**, not by declaring an edge: the limb asked through which edge `BC-05` *queues an offline financial write*, and the Product Owner decided that **`BC-05` never performs one**. **No `BC-05` → `BC-30` edge, no `BC-32`, no BC Map change** (`81518f1bb251218b`, byte-unchanged), **no requirement added or reworded**, **no checker touched**. ⛔ **AND THIS CHANGES NOTHING ELSE.** Stage 3 alignment is **not** a freeze, **not** Stage 4 entry and **not** a status change: `PRD-008` stays **`DRAFT`** and stays **`PLANNED`** in `PRD_REGISTRY.md`, so **`GCP-14` is preserved**; **5 gaps still block Stage 4** and **10 still block Freeze**; `FEE-GAP-002`'s own `Stage 4` field is **left at `BLOCKS`**. **The passing check is check 2 alone** — checks 1 and 3–6 pass for the reasons they always did, and check 6 keeps its **standing re-review condition** (§7.2). |
| **Verdict at v1.1 — THE RE-RUN, superseded, retained beside the new one per the `ADR-0034` precedent** | ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 check BLOCKED.** **The verdict does not move. What moves is the number of reasons it does not move for: three → one.** ✅ **Two of the three reasons recorded at §3 are now gone.** **(i)** `FEE-GAP-016` is **RESOLVED** — `ADR-0035` §5.5b, `ACCEPTED` by conferral, declares the **inbound payment webhook an existing Business Platform capability**, the return leg of the outbound call `O-3` already authorises; it passes `AR-1` on all four criteria, so the context count stays **31** and **no `BC-32` is created**. **(ii)** `ADR-0035` is no longer `PROPOSED` — it is **`ACCEPTED`**, so `D-1` and `D-2` **bind** rather than being merely recorded, and the objection *"a gate must not pass on a decision that does not yet bind"* is **satisfied, not waived**. ⛔ **THE THIRD REASON SURVIVES INTACT, AND IT IS SUFFICIENT ON ITS OWN TO BLOCK:** **(iii)** **`FEE-GAP-002`(c)** — **offline financial capture is still open.** `E-24` is `BC-03` → `BC-30` only; edges `BC-05` → `BC-30` = **0**; and **not one of the decisions given addressed it.** The decisions concerned payment execution, the inbound webhook, intent and verification ownership, gateway integration, settlement ownership, the 3% rate, the 15th due day, cash-only settlement, the 14-day trial and 3-day renewal protection. **Offline capture through `BC-30` was not among them.** **Therefore check 2 remains ⛔ BLOCKED and this record does NOT declare Stage 3 ALIGNED.** Marking it aligned would make the gate green on a decision **nobody made**. **Counts at v1.1, re-derived from the PRD's own §39.1 rather than decremented:** 17 gaps (none deleted; one now RESOLVED) · **5** blocking Stage 4 · **10** blocking Freeze · 0 conflicts created by this PRD · **4** pre-existing defects raised · **8** findings rejected with reasons. See **§9.3d**. ⚠ **A pre-existing internal inconsistency in this record, found during the re-run and disclosed rather than quietly overwritten:** the v1.0 verdict row below says check 2 fails for *"exactly **two** reasons"* while **§3 has listed three since v0.7**. **§3 was right and the verdict row was stale.** It is left standing below as written, because a superseded verdict is evidence and correcting it in place would erase the discrepancy instead of recording it |
| **Verdict at v1.0 — superseded, retained beside the new one per the `ADR-0034` precedent, not overwritten** | ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 check BLOCKED.** The verdict is unchanged but its **reason has changed twice over**. The *transport* was closed at v0.6 (already authorised, no edge needed). The *counterparty* is **closed at v0.7**: `ADR-0035` `D-2` decides **`O-3`** — payment execution is a **Business Platform capability, not a new bounded context** — passing the architecture's own **`AR-1`** test on all four criteria, with the context count staying **31**. **Check 2 nevertheless stays ⛔ BLOCKED, now for exactly two reasons, both stated rather than smoothed over:** **(i)** **`FEE-GAP-016`** — no source at any rank declares an owner for **inbound webhook transport**, so server-side confirmation still cannot be specified; and **(ii)** the deciding ADR is **`PROPOSED`**, so `D-2` is **recorded, not in force**. A gate does not pass on a decision that is not yet in force. 0 conflicts created by this PRD · **4** pre-existing defects raised, not chosen (§9.1) · **17** gaps, **6** blocking Stage 4 (§9.3) *(this figure read **16** from v0.7 through v0.8 while §9.3 correctly listed **17** — a stale count in this record, corrected at v0.9; the blocker count was always **6** and does not move)* · **7** findings rejected with reasons (§10). **At v1.0 an eighth finding is rejected — one of this review's own (§10.8):** the v0.9 reading that frozen Membership rules *"forbid"* renewal protection is **withdrawn**; the blocker is `Q-01`, an open question, and `ADR-0036` records the corrected position. **No check state, gap count or blocker count moves** — 17 gaps, 6 blocking Stage 4, 11 blocking Freeze, exactly as at v0.9 |

> **Why this record still says NOT ALIGNED after resolving half the blocker — and why that is the honest outcome.**
>
> The first pass asked one question — *"does `BC-05` have a path to a payment gateway?"* — searched for a numbered
> `E-` edge, found none, and reported BLOCKED. Re-measured at `3d98330`, that was **one question too few.**
> `FEE-GAP-002` is two:
>
> | | Question | Answer at this HEAD |
> |---|---|---|
> | **(a) Transport** | By what lawful *route* may `BC-05` reach gateway capability? | ✅ **Already authorised.** The `business.payment_intent` port, declared in the Dependency Matrix's own normative section. **Nothing to approve; nothing to invent** |
> | **(b) Counterparty** | Which bounded context *executes* a **student → library** payment at the far end of that route? | ⛔ **Undeclared.** No context owns it, and Rank 1 `MP-GBR-24` bars the only obvious candidate |
>
> Half of `FEE-GAP-002` never existed — it was an artefact of looking for an edge where the architecture asks for
> a port. The other half is a **genuine architectural hole** owned by the Architecture Owner. One resolved half
> does not pass a gate. **The verdict therefore stays ⛔ NOT ALIGNED at 5 of 6, and this record does not relabel
> it.** What changes is that the remaining blocker is now stated exactly, with the authority named — which is what
> the Stage 3 gate asks a record to do.

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line, re-read at its source at
`3d98330`. Nothing is asserted from memory, **and nothing is carried over from the first pass on trust** — the
prior record's own check-2 conclusion is one of the things re-measured, and §10 records where it was wrong.

Where the PRD conflicts with a higher-precedence document,
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
never which to ignore. Per §4: *"A conflict is a defect. If you find one, do not choose — raise it."*
That rule is applied literally in §3.6, where **two Rank 1 statements contradict each other** and this record
declines to pick a winner.

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD global rules | `docs/30-product/MASTER_PRD.md` | **1** |
| 2 | Accepted ADRs — incl. **`ADR-0012`**, **`ADR-0013`**, **`ADR-0015`**, **`ADR-0033`** | `docs/00-governance/adr/` | **2** |
| 3 | Authentication PRD v2 | `docs/30-product/authentication/prd-v2/` | **3** |
| 4 | Membership Management PRD v1.4 **FROZEN** | `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **3** |
| 5 | Student Identity PRD v1.0 | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` | **3** |
| 6 | Library PRD v1.1 **FROZEN** | `docs/30-product/library/Library_PRD_v1.md` | **3** |
| 7 | Seat Management PRD **FROZEN** — §3.4 no-edge precedent | `docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md` | **3** |
| 8 | Bounded Context Map v1.7 | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 9 | Module Dependency Matrix v1.3 — **incl. §6, its self-declared normative form** | `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 10 | Module manifest — the machine-checked form | `tool/module_dependencies.yaml` | **4** |
| 11 | Enterprise Architecture v2.1 | `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **6** — descriptive only |
| 12 | Configuration Guide v1.1 | `docs/20-configuration/CONFIGURATION_GUIDE.md` | **7** |
| 13 | PRD Dependency Graph — **self-declared *"Derived. Non-normative."*** | `docs/00-governance/prd-ecosystem/PRD_DEPENDENCY_GRAPH.md` | derived |

### 1.2 Classification scheme

| Mark | Meaning |
|---|---|
| ✅ **PASS** | The PRD conforms; evidence cited |
| ⛔ **BLOCKED** | Conformance cannot be established because an authoritative decision does not exist. Not a PRD defect |
| ⚠ **RAISED** | A defect in a *ranked* document, surfaced per §4. Not resolved here |
| ↺ **SUPERSEDED** | A conclusion of the **first pass** of this same record, replaced on evidence. Retained, not deleted |

---

## 2. Check 1 — Context ownership is exclusive

**Authority:** BC Map §3. **Failure:** two PRDs own one aggregate.

### 2.1 The claim

`PRD-008` claims exactly one aggregate: **`FeeLedger` (per student)**, matching BC Map **§8 L374** verbatim —
`FeeDue`, `Receipt`, `Discount`, `RefundRecord`, `Money`.

### 2.2 The boundary that matters most — `BC-05` vs `BC-20`

**Rank 1 `MP-GBR-24` (Master PRD L362):**

> *"Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by a **library to
> LIBOORA** (`BC-20`). They must never share a model, a table or a metric."*

Reinforced at BC Map **L202-204**, which pairs the three colliding nouns explicitly: `FeePayment` (BC-05) vs
`SubscriptionCharge` (BC-20); `MembershipPlan` (BC-02) vs `SubscriptionPlan` (BC-20); `FeeDue` (BC-05) vs
`SubscriptionInvoice` (BC-20).

**Verified in the PRD at v0.6.** `PRD-008` §42 refuses the platform-commission model outright and routes it to
`BC-20` via `FEE-GAP-014`. Critically, `FEE-FR-060`'s confirmed-payment snapshot **deliberately carries no
commission, gateway or tax field** — the PRD states that adding one *"would perform that merger **in the schema**,
which is where it matters."*

**This survived v0.6 intact, and it is the reason `FEE-GAP-002` could not be closed the easy way.** The cheapest
route to a working gateway would have been to let `BC-20` — which genuinely owns a gateway relationship (BC Map
**L129**) — execute the student payment too. §3.5 records why that is barred. **No commission concept entered the
`BC-05` model at v0.6 in order to make the gateway work.**

### 2.3 Adjacent ownership honoured

| Concept | Owner | PRD-008's position | Evidence |
|---|---|---|---|
| Membership term, `endDate`, duration | **`BC-02`** FROZEN | Consumes; never computes | `FEE-XC-020`; `MM-FR-057`, `MM-FR-058` |
| Seat allocation and availability | **`BC-04`** FROZEN | No seat obligation | §42.6; `FEE-XC-018`…`021` |
| Platform commission, settlement | **`BC-20`** | **Refused and routed** | `MP-GBR-24`; `FEE-GAP-014` |
| Roles, permissions, policy decisions | **`BC-18`** | Consumes decisions only | BC Map **L127**; `FEE-XC-014` |
| Renewal-protection *rule* | **`BC-06`** | Owns none of it | §11.3.2; BC Map L101 |
| Platform configuration values | **`BC-25`** / `PRD-023` | Owns none of it | `PRD_REGISTRY.md` L327, L424 |

### 2.4 Result — ✅ **PASS**

One aggregate, matching BC Map §8 exactly. No second PRD claims `FeeLedger`. The highest-risk boundary in the
platform (`BC-05`/`BC-20`) is enforced at model level, **and was not weakened at v0.6 under pressure to resolve
the gateway question.**

---

## 3. Check 2 — Every integration edge exists in BC Map §7

**Authority:** BC Map §7, L292 — *"Every edge that crosses a context boundary in V1. If an edge is not in this
table, it does not exist and adding it requires an ADR."*

### 3.1 Declared edges, verified line by line

| Edge | Direction | BC Map line | Verified |
|---|---|---|---|
| `E-06` | `BC-06` → `BC-05` | L303 | ✅ `HolidayCalendar` |
| `E-07` | `BC-02` → `BC-05` | L304 | ✅ Membership events → `FeeDue` |
| `E-09` | `BC-01` → `BC-05` | L306 | ✅ `StudentArchived` |
| `E-10` | `BC-05` → `BC-02` | L307 | ✅ `FeePaymentReceived` |
| `E-17` | all write paths → `BC-21` | L326 | ✅ Entitlement check |
| `E-18` | all → `BC-19` | L327 | ✅ Ambient `TenantContext` |
| `E-19` | all → `BC-25` | L328 | ✅ Typed config accessors |
| `E-20` | all → `BC-24` | L329 | ✅ Audit, outbox-backed |
| `E-23` | all → `BC-22` | L332 | ✅ Notification facts |

**The four `BC-05`-specific edges are exactly `E-06`, `E-07`, `E-09`, `E-10`** — inside the Core Library cluster
allow-list `E-01`…`E-10` that Dependency Matrix **L89** declares. No edge above `E-10` is claimed between two
Core-cluster contexts, which is precisely the violation `ADR-0033` withdrew `E-27` to avoid.
**`PRD-008` v0.6 adds no edge and claims no new one.** Verified: max `E-` reference in the PRD is `E-27`
(a citation of the *withdrawn* edge in prose), and no `E-` identifier above `E-31` exists anywhere in it.

### 3.2 The blocker, restated correctly — it is two questions

Measured at this HEAD, the raw edge counts are unchanged from the first pass:

| Fact | Measurement |
|---|---|
| Edges `BC-05` → `BC-31` Integration | **0** |
| Edges `BC-05` → `BC-30` Offline Sync | **0** |
| Edges `BC-05` ↔ `BC-20` | **0** |
| `E-25` | **`BC-20` → `BC-31`** (BC Map L334) — Billing's gateway abstraction, *not* `BC-05`'s |
| `E-24` | **`BC-03` → `BC-30`** (BC Map L333) — Attendance's offline sync, *not* `BC-05`'s |

The first pass stopped here and concluded *"no path."* **That inference does not follow, and §3.3 shows why.**
An absent edge proves an absent *edge*. It does not prove an absent *route*, because this architecture also has
**ports** — and the Dependency Matrix prescribes one for exactly this purpose, by name.

### 3.3 ✅ **(a) The transport is already authorised — four independent ranked sources**

| # | Source | Rank | What it establishes |
|---|---|---|---|
| **i** | Dependency Matrix **§6, L171** | 4 | The section declares its own authority: *"The matrix is the human-readable form. **This section is the normative form — what the lint rule checks.** Anything not listed is forbidden."* |
| **ii** | Dependency Matrix **L196** | 4 | Inside `library_management`'s `may_use_ports`, on its own line: `- business.payment_intent     # money rails`. **`BC-05` is a `library_management` context** — BC Map L100 gives its Owning Platform as Library Management, and `tool/module_dependencies.yaml` lists `contexts: [enrollment, membership, attendance, seating, fee, policy]` |
| **iii** | Dependency Matrix **L167** | 4 | Forbids the wrong route *and names the right one in the same sentence*: `LIBRARY MANAGEMENT → INTEGRATION | ✖ | The domain must not know that Razorpay, Twilio or FCM exist… Integration is reached only via BUSINESS (payments) or COMMUNICATION (messaging).` |
| **iv** | Dependency Matrix **L352, `X-03`** | 4 | Lists the anti-pattern *"Just call Razorpay from the payment service"* and gives the remedy as a direct instruction: **`Call business.payment_intent port`** |
| **v** | **`ADR-0012` L86 — ACCEPTED** | **2** | Already tabulates the relationship as a correctly-directed declared port: `| domain/library | platform/business | 8 → 6 | 2 | Yes — :entitlement, :payment_intent |` |

**The matrix cell was verified mechanically, not by eye.** The Dependency Matrix is fixed-width ASCII with grouped
column headers; an off-by-one in cell counting would be invisible and would invert the conclusion. Both relevant
rows were parsed programmatically against the header groups
`CTR | DAT SEC | CFG OBS PSV EVT | SHC IAM | AUD SRC COM INT | BUS WKF AI | ANL | LIB GST` and **19 data cells
aligned to 19 headers on each row**:

| Row | → `INT` | → `BUS` |
|---|---|---|
| `R8 LIBRARY MANAGEMENT` | **`✖`** forbidden | **`◇`** — port, no import — **PERMITTED** |
| `R6 BUSINESS` | **`◇`** — port, no import — permitted | — |

> **The two-hop route `LIBRARY MANAGEMENT → BUSINESS → INTEGRATION` is permitted at every hop; the one-hop
> shortcut is forbidden.** That is not an oversight in the matrix — it is the matrix's stated design intent,
> written out in prose at L167 and enforced as a named anti-pattern at L352.

**Conclusion (a):** `BC-05` has a **lawful, already-declared route** to gateway capability. It requires no new
edge, no allow-list widening and no ADR to *create* — only, at most, an ADR to *recognise*. This is recorded as
`ADR-0035` **`D-1`**, which remains **`PROPOSED`**.

### 3.4 Why "no numbered edge" is not a defect — the general measurement

The first pass treated the absence of an edge for `business.payment_intent` as disqualifying. Tested as a
**general rule** rather than a special plea, that premise collapses. All **17** ports declared for
`library_management` were measured against BC Map §7:

| Ports **with** a usable numbered edge — **3** | Edge |
|---|---|
| `configuration.settings` | `E-19` — all contexts → `BC-25` |
| `shared_core.tenant_context` | `E-18` — all contexts → `BC-19` |
| `business.entitlement` | `E-17` — all write paths → `BC-21` |

| Ports **without** one — **14** | Reason |
|---|---|
| `data.repository`, `security.crypto`, `observability.telemetry`, `platform_services.qr`, `platform_services.idempotency`, `platform_services.time`, **`identity.policy_decision`**, `ai.assist`, `analytics.read_model`, `workflow.process_trigger`, **`business.payment_intent`** | No edge exists at all |
| `platform_services.files` | `E-22` exists — but its consumer list is `BC-01`, `BC-10`, `BC-14`. **`BC-05` is not among them** |
| `search.indexer` | `E-21` exists — but its consumer list is `BC-01`, `BC-10`. **`BC-05` is not among them** |
| `platform_services.offline_sync` | `E-24` is `BC-03` → `BC-30` **only** |

> **Two of these look like coverage and are not.** `E-22` and `E-21` exist, but neither names `BC-05`. A coarser
> check — *"is there an edge to that context?"* — would have counted both as satisfied. They are counted as
> unsatisfied here.

**If a numbered edge were genuinely required for a declared port to be usable, then 14 of `BC-05`'s 17 lawful
dependencies would be illegal — including `identity.policy_decision`, the authorisation port that check 4 of this
very gate requires every context to call.** A reading that invalidates the gate's own prerequisite is the wrong
reading.

**And it is the reading an Accepted ADR has already rejected.** `ADR-0033` §3, verbatim:

> *"**What BC Map L292 does and does not say.** It says: 'Every edge that crosses a context boundary in V1. If an
> edge is not in this table, it does not exist and adding it requires an ADR.' **It governs edges.** It does
> **not** state that every cross-context read must be an edge — and `SEAT-FR-104` proves the map is not read that
> way."*

`ADR-0033` chose option `O-C` (withdraw `E-27`) over `O-A` (allow-list it), rejecting `O-A` because *"its only
effect would be to remove a documentation contradiction — which is precisely 'adding it to make the conflict go
away.'"* Its ratio is directly on point: **a lawful cross-boundary dependency does not require its own numbered
edge.**

Frozen Rank 3 `PRD-007` §3.4 records the same pattern in production form — three contexts consuming across a
boundary with no edge, `BC-05` among them, annotated *"None. No edge exists."*

### 3.5 ⛔ **(b) The counterparty is genuinely undeclared — and this is what still blocks**

A route needs something at the far end of it. Measured:

| Fact | Measurement |
|---|---|
| Contexts in `platform/business` | **Exactly two** — `BC-20` Subscription & Billing, `BC-21` Entitlement |
| `BC-21`'s scope (BC Map L130) | Limits and gates only. Executes no payment |
| `BC-20`'s scope (BC Map **L129**) | *"money owed by a **library to LIBOORA**: plans, subscriptions, invoices, **gateway**, dunning, revenue recognition"* |
| `grep -rn "PaymentIntent" docs/` | **0 occurrences repository-wide** |
| `payment_intent` in BC Map | **0 occurrences** |

**The port is declared in the Dependency Matrix and implemented by no declared context.** No bounded context in
this architecture owns the execution of a **student → library** payment.

**`BC-20` cannot silently become that context.** It is the only context with a gateway, which makes it the
tempting answer — and Rank 1 forbids it:

> `MP-GBR-24` (Master PRD **L362**) — *"Money owed by a **student to the library** (`BC-05`) is a different
> concept from money owed by a **library to LIBOORA** (`BC-20`). **They must never share a model, a table or a
> metric.**"*

Reinforced by BC Map **L202** (`FeePayment` vs `SubscriptionCharge`) and by Accepted **`ADR-0015`**, which exists
*solely* because three identifier rows collapsed these two finance contexts — an error it called *"not merely
wrong; it erases a distinction the map treats as load-bearing."* **Routing student money through `BC-20` to reach
a gateway would repeat exactly the defect `ADR-0015` was written to correct.**

`ADR-0035` §6 presents **three** options for the counterparty — `O-1` a new context · `O-2` `BC-20` executes the
rail while modelling no student money · `O-3` a platform capability owning no aggregate — and **recommends none**.
Each has a real cost, and choosing between them is an interpretation of a Rank 1 rule, which is not a Stage 3 act.

### 3.5.1 The `D-2` investigation — four concepts separated, four of six rows closed *(added at v0.7)*

The blocker was re-opened under a direct instruction not to assume that `BC-20`, `BC-31` or `BC-05` owns payment
execution, and to determine ownership from the authoritative architecture. Separating the concepts changed the
answer's shape: **`FEE-GAP-002` is not one ownership question but six, and four of them are already settled.**

| # | Concept | Owner | Rank | Evidence |
|---|---|---|---|---|
| 1 | Payment **intent** | ✅ **`BC-05`** | 3, 4 | BC Map L100 · frozen `PRD-005` L164 · EA L74 *"domain intent over Business Platform rails"* |
| 2 | Payment **execution** | ⛔ **undeclared** (context) / `platform/business` (module) | — | §3.5.2 |
| 3 | **Gateway integration** | ✅ **`BC-31`** | 4 | BC Map L140 · manifest L409 `ports: [platform/integration:payment_gateway]` |
| 4 | Payment **verification** | ✅ **`BC-05`** owns the obligation · ⛔ mechanism blocked | 1, 3 | `MP-GBR-18` · frozen `MM-BR-005` *"Enforcement of the payment side is `BC-05`'s"* |
| 5 | **Student financial truth** | ✅ **`BC-05`, exclusively** | 1, 4 | BC Map L374 `FeeLedger` · `MP-GBR-24` · L202 |
| 6 | **Webhook / reconciliation ingress** | ⛔ **NO OWNER EXISTS** | — | §3.5.3 |

**Row 5 is the one `MP-GBR-24` protects, and it was never actually in doubt.** Whatever executes the rail, the
confirmed financial record stays in `BC-05`'s `FeeLedger`. **No shared financial model, table or metric was created
or proposed** to resolve any of this — and the split is now known to be **mechanically enforced**: the rank-0 shared
kernel `packages/liboora_contracts` carries `banned_symbols` including `class Payment ` with the message
*"FeePayment (BC-05) or SubscriptionCharge (BC-20)"*.

### 3.5.2 Row 2 — the negative measurement that makes this a real gap

`tool/module_dependencies.yaml` is the machine-checked source `check_module_boundaries.dart` reads.

| Measurement | Result |
|---|---|
| Does the schema express *who implements* a port? | **Yes** — the key is `provides_ports:` |
| Which modules use it? | **Exactly two** — `domain/person` (L188), `platform/identity` (L442) |
| Does `platform/business` use it? | **No** — 0 occurrences in its block (L405–L416) |
| Is the onward hop declared? | **Yes** — L409, `ports: [platform/integration:payment_gateway]` |

**The manifest *can* name an implementer and does not name one here.** The chain
`domain/library` → `platform/business` → `platform/integration` → vendor is **fully authorised at every hop**;
what is missing is a named owner for the middle hop's behaviour. This confirms the gap is genuine and not an
artefact of having read the wrong document.

### 3.5.3 Row 6 — a gap wider than `D-2` was originally stated

| Measurement | Result |
|---|---|
| `webhook` in the Rank 4 BC Map | **0** |
| `inbound` in the Rank 4 BC Map | **0** |
| `BC-31`, verbatim (L140) | *"Owns **outbound** third-party contracts…"* |
| EA L165 | *"Integration Platform = **outbound** adapters, **API Platform = inbound** adapters"* |
| Does `API Platform` hold a `BC-` id? | **No** — a diagram band (L223) and the single OHS (L358); not one of the 31 contexts |

**A webhook is inbound; `BC-31` is outbound by definition; and the component the EA nominates for inbound is not a
bounded context.** The EA does list *"Webhook Reconciliation (V1)"* (L1407), but `DOCUMENTATION_BASELINE.md` L139
marks the EA **"Descriptive — must follow the PRDs, never lead them"**, so it records intent and confers no
ownership. **No webhook schema, endpoint or provider behaviour was invented** to fill this.

### 3.5.4 Why this narrows the decision without taking it

| Option | Status after measurement | Basis |
|---|---|---|
| `O-2` — `BC-20` executes | ⛔ **contradicted by Rank 1** | `MP-GBR-24`, now also CI-enforced via `banned_symbols` |
| `O-1` — create `BC-32` | ⚠ **evidentially disfavoured** | `AR-1` requires a new context to own *"an aggregate… an invariant… business state"*; a rail owns none — rows 4 and 5 keep both in `BC-05`. `PRD_REGISTRY.md` L355 applied this same test and created no `BC-32` |
| `O-3` — platform capability, no context | ✅ **uncontradicted** | Frozen `PRD-005` L164 attributes the subject to *"`BC-05` / **Business Platform**"* — the platform, not `BC-20`. EA L122 resolves the same duplication to *"**BUSINESS PLATFORM** (money movement) / Library (fee domain intent)"*. `ADR-0013`: *"a capability context is owned by its platform"* |

> ⚠ **Convergence is not authority, and check 2 does not pass on it.** Three sources name the **platform** and none
> names a **context** — but `PRD-005` L164 is a *"not mine"* scope table, authoritative about where the subject is
> **not** and only indicative about where it **is**; and the EA is **descriptive by designation**. Two things remain
> that measurement cannot supply: **(i)** the Rank 1 reading of `MASTER_PRD.md` L232 versus `MP-GBR-24` L362, on
> which `O-3`'s admissibility depends (§3.6); **(ii)** **row 6 has no candidate at any rank** — no source names an
> owner for webhook ingress, and `O-3` does not supply one.
>
> **⚠ SUPERSEDED AT v0.7 — point (i) is now resolved, point (ii) is not.** See §3.5.5. Point (i) dissolved on
> **scope**, not on override. Point (ii) became **`FEE-GAP-016`**. This note is retained unedited so the record
> shows what was known **before** the decision was taken.

### 3.5.5 The `D-2` decision — `O-3`, taken under conferred authority *(added at v0.7)*

**Authority.** `PRD_OWNERSHIP_MODEL.md` §2.2 vests in the **Architecture Owner** *"Boundaries, ranks, permitted
edges, precedence … ADR approval; any Rank 1–5 document change"* — the same authority that carried
`ADR-0012`, `ADR-0013` and `ADR-0033`. The decision below is **recorded** under that authority. **It is not
accepted**, because acceptance was expressly withheld.

**The test was applied before the conclusion was drawn.** `O-3`'s intuitive support was Accepted `ADR-0013`
(*"a capability context is owned by its platform"*). Measured, **that precedent does not reach this case**: its
Decision (L94–128) resolves ownership only for `BC-19`/`BC-25`/`BC-29` — contexts that **already hold `BC-`
identifiers** — and `grep -iE "no bounded context|owns no aggregate|without a bounded context"` over it returns
**0 matches**. It never contemplates a capability with **no** context. **That limit is recorded in `ADR-0035`
§5.2.2 so a future reader cannot over-read it.**

**The governing authority is `AR-1`** (`ARCHITECTURE_RULINGS.md` L23–37; BC Map **L86** and **L558**): a
capability is **not** a context when it owns *"no aggregate, no invariant and no business state"* and
*"delegates every domain operation."*

| `AR-1` criterion | Measured | Evidence |
|---|---|---|
| Owns an aggregate? | **No** | `FeeLedger` is `BC-05`'s — BC Map **L374** |
| Owns an invariant? | **No** | `FEE-INV-005`, `FEE-BR-016`, frozen `MM-BR-005` → all `BC-05` |
| Owns business state? | **No** | BC Map L374 · L202 · `MP-GBR-24` |
| Delegates every domain operation? | **Yes** | intent ← `BC-05` · vendor → `BC-31` · confirmation → `BC-05` |

**All four criteria pass, so `AR-1` does not merely permit `O-3` — it requires it**: a capability with this
profile **must not** become a context. Outcome precedent is `PRD_REGISTRY.md` **L355**, where the same test
produced *"no `BC-32` was created and the context count remains 31."*

**The Rank 1 tension (§3.6) dissolves by scope — and neither Rank 1 statement is amended, weakened or
reinterpreted.** `MASTER_PRD.md` **L232** sits inside **§10 Technology Stack**, whose own preamble declares its
subject to be *"capabilities with abstractions, with vendors recorded as candidate implementations behind
ports"*, and whose columns are *Capability / Architectural owner / Abstraction that must exist / Candidate
implementation (V1) / Approved in EA v2.1?*. **It is a vendor-abstraction table.** **L362** `MP-GBR-24` governs
the **financial model**. Read to their own declared scopes, they do not collide — so §3.6 requires **no**
override, **no** precedence ruling and **no** amendment. *(§3.6 is retained as written: the tension was real as
posed, and the resolution is a narrowing of scope, not a discovery that the disclosure was wrong.)*

**What the decision does NOT do.** It creates **no** bounded context and **no** `BC-` identifier · adds **no**
`E-*` edge · moves **no** aggregate · changes **no** Matrix or BC Map cell · gives `BC-20` **no** role in
student money · brings the **3% commission** no closer to `FeePayment` · and does **not** modify
`tool/module_dependencies.yaml`. On that last point specifically: the minimum `provides_ports:` declaration
`platform/business` would need is written into `ADR-0035` **as a proposal only**, because **applying** it is an
implementation act that requires acceptance first.

### 3.5.6 ⛔ Webhook ingress — NOT resolved, and not pretended to be *(added at v0.7)*

Resolving *who executes* exposed a narrower question that **no source at any rank answers**:

| Probe | Result |
|---|---|
| BC Map — `grep -c "webhook"` | **0** |
| BC Map — `grep -c "inbound"` | **0** |
| `BC-31` scope, BC Map **L140** | *"Owns **outbound** third-party contracts…"* — **outbound only** |
| EA **L165** | *"Integration Platform = outbound adapters, **API Platform = inbound adapters**"* |
| Does `API Platform` hold a `BC-` id? | **No** — diagram band L223 and a single OHS at L358 only |
| Is the EA able to confer it? | **No** — `DOCUMENTATION_BASELINE.md` **L139**: *"Descriptive — must follow the PRDs, never lead them"* |

**`BC-31` must not be assumed to own inbound**, and the one source that *describes* an inbound owner cannot
**confer** ownership. Recorded as **`FEE-GAP-016`**, with only the **minimum shape** of the required amendment:
a `provides_ports:` declaration on an **existing `platform/integration` capability** — **preferred over a new
bounded context**, per `AR-1`. **No endpoint, payload, signature scheme, retry policy, vendor contract,
permission or configuration identifier was invented.**

> **A webhook MUST NOT directly mutate `BC-05` truth.** Receiving a provider callback is **transport**;
> financial truth remains `BC-05`'s, written only by its own verification step. The gap concerns **who receives**,
> never **who decides**.

### 3.6 ⚠ **RAISED — a Rank 1 internal contradiction, disclosed and not resolved**

| Line | Text | Implication |
|---|---|---|
| `MASTER_PRD.md` **L232** | `| Payments | BC-20 via BC-31 | Payment Gateway Abstraction | Gateway | Not named in EA — candidate only |` | Routes *Payments* through `BC-20` |
| `MASTER_PRD.md` **L362** (`MP-GBR-24`) | Bars `BC-20` from student money entirely | Forbids that, **if** L232 covers student payments |

Both are **Rank 1**, so precedence cannot arbitrate between them — there is no higher document to appeal to.
Two readings exist: if L232 refers to **SaaS** payments only, the two are consistent (and `MP-DEP-04`'s pairing of
*"SaaS Billing, fee collection"* supports that reading) and the counterparty is simply **unassigned**; if it
covers **student** payments, the two Rank 1 statements **contradict**.

**This record does not choose.** Per `DOCUMENTATION_BASELINE.md` §4 — *"a conflict is a defect; do not choose,
raise it."* Recorded as **`AA-C3`**. Owner: **Product Owner** (which concept L232 names) with the
**Architecture Owner** (the consequent routing).

### 3.7 ⚠ **RAISED — `D-14` mis-attributes `E-25`, and the citation is not authoritative**

`PRD_DEPENDENCY_GRAPH.md` **L116**:

```
| **D-14** | PRD-008/PRD-020 | PRD-019 BC-31 Integration | API | E-25 | Both unwritten |
```

`E-25` is `BC-20` → `BC-31` (BC Map L334). **`PRD-008` owns `BC-05`, so it cannot be a party to `E-25`.**

**The register disclaims its own authority in its header:** *"**Derived. Non-normative.** Every edge below is read
from the Bounded Context Map §7… This document **adds no edge of its own**."* The citation is therefore **stale,
not authoritative** — it neither grants `PRD-008` a path nor denies it one, and it cannot be used as evidence in
either direction. It is a defect of the same class `ADR-0015` corrected.

**Not corrected here.** `ADR-0035` **`D-3`** recommends the correction and **does not execute it**;
`PRD_DEPENDENCY_GRAPH.md` is untouched at this HEAD. Recorded as **`AA-C2`** (carried from the first pass, now
with the additional finding that the register is self-declared non-normative).

### 3.8 Outbound restraint

`PRD-008` publishes exactly three `fee.*` events — `FeeDueRaised`, `FeePaymentReceived`, `RefundIssued` — and adds
no consumer edge. It does **not** claim `BC-26` Analytics as a subscriber, avoiding the systemic `MM-GAP-010`
defect where BC Map §9 names consumers §7 denies. **No webhook schema, vendor contract, endpoint, gateway payload
or provider name appears anywhere in the PRD** — re-verified by scan at v0.6.

### 3.9 Result — ⛔ **BLOCKED** *(two reasons remain, both narrower than at v0.6)*

Nine declared edges verified present. Three of the four questions this check once carried are now closed:

| Question | v0.5 | v0.6 | v0.7 |
|---|---|---|---|
| **(a)** Transport — lawful route to gateway capability | ⛔ assumed missing | ✅ **CLOSED** — already authorised, no edge needed | ✅ closed |
| **(b)** Counterparty — who *executes* a student→library payment | ⛔ open | ⛔ open | ✅ **CLOSED** — `ADR-0035` `D-2` = `O-3`, a Business Platform **capability** (§3.5.5) |
| **(c)** Offline financial write via `BC-30` | ⛔ open | ⛔ open | ✅ **CLOSED at v1.2 — `ADR-0037`, Product Owner.** **Dissolved, not answered:** `BC-05` performs **no** offline financial write, queue, local ledger or later sync, so there is no traffic for an edge to carry. `E-24` remains `BC-03` → `BC-30` **only**, and that is now **correct rather than deficient**. *v1.1 text superseded:* ⛔ **OPEN** — `E-24` is `BC-03` → `BC-30` only; **untouched this pass** |
| **(d)** Inbound webhook transport owner | *not yet asked* | *surfaced* | ⛔ **OPEN** — **`FEE-GAP-016`** (§3.5.6) |

**The lawful path is now fully named, with no new numbered edge:**
`BC-05` raises intent → `domain/library` → **`business.payment_intent`** port → `platform/business` **executes**
→ **`platform/integration:payment_gateway`** port (manifest L409) → `BC-31` → external provider. **Every hop was
already declared**; the decision named the executor, it did not create a route.

**Why the check still fails, stated without softening.** **(i)** `FEE-GAP-016` — with no declared inbound owner,
server-side confirmation and webhook reconciliation **cannot be specified**. **(ii)** `ADR-0035` is
**`PROPOSED`**, so `D-2` is **recorded, not in force**; a gate must not pass on a decision that does not yet
bind. **(iii)** `FEE-GAP-002`(c) offline capture is still open.

> **⚠ AMENDED AT v1.1 — the three reasons above are retained verbatim, and their v1.1 disposition is recorded
> beneath them rather than replacing them.** The paragraph above is what the sixth pass measured; it is left
> standing because **a superseded reason is evidence of how the gate moved.**
>
> | Reason, as written above | Disposition at v1.1 |
> |---|---|
> | **(i)** `FEE-GAP-016` — no declared inbound owner | ✅ **GONE.** `ADR-0035` **§5.5b**, `ACCEPTED` by conferral: the **inbound payment webhook is an existing Business Platform capability** — the return leg of the outbound call `O-3` already authorises. `AR-1` passes on all four criteria; count stays **31**; **no `BC-32`**. `FEE-FR-028` may now name its counterparty |
> | **(ii)** `ADR-0035` is `PROPOSED`, so `D-2` does not bind | ✅ **GONE.** The ADR is **`ACCEPTED`** — *"In force. Binding on all implementation"*. **The objection is satisfied, not waived:** the gate is not passing on a `Proposed` decision, because the decision is no longer `Proposed` |
> | **(iii)** `FEE-GAP-002`(c) offline capture is still open | ✅ **GONE at v1.2 — `ADR-0037`.** The limb is **dissolved, not answered**: cash payment is supported but financial recording is **server-authoritative**, so `BC-05` performs **no** offline financial write, queue, local ledger or sync — there is no traffic for an edge to carry. **No `BC-05` → `BC-30` edge; no `BC-32`.** `FEE-FR-061` and `FEE-XC-022` **already specified this** and are unchanged. *v1.1 disposition, retained verbatim because it was correct then and is the evidence of how this gate moved:* ⛔ **SURVIVES, UNTOUCHED, AND BLOCKS ON ITS OWN.** `E-24` is `BC-03` → `BC-30` only; edges `BC-05` → `BC-30` = **0**. **No decision was given on offline financial capture.** Owner: **Architecture Owner** |
>
> **Check 2 therefore remains ⛔ BLOCKED — for one reason instead of three.** That is real progress and it is
> recorded as such; **it is not a pass.**
>
> ✅ **SUPERSEDED AT v1.2 — and the sentence above is retained precisely because it was the right call at v1.1.** At v1.1 all three of check 2's stated reasons had been examined and one survived, so declaring a pass would have made the gate green *"on a decision nobody made"*. **At v1.2 that decision was made**, by the authority whose scope it was, and the check passes. **The refusal was not an obstacle that was worked around; it was a condition that was met.** This is the distinction the record exists to preserve, and it would be destroyed by editing the refusal out. Reason (iii) was never conditional on (i) or (ii), so removing them
> subtracts nothing from it. **Declaring this check PASS now would make the gate green on a decision nobody made.**

**Owner at v1.2: none — no open item blocks this check.** Tracked as **`FEE-GAP-002`** — *(a) CLOSED · (b) CLOSED **and in force** · (c) **CLOSED by `ADR-0037`, Product Owner*** — and **`FEE-GAP-016`** *(**RESOLVED**)*. **The authority that closed (c) was the Product Owner, not the Architecture Owner, and the change of route is disclosed rather than quietly re-labelled**: every prior pass routed (c) to the Architecture Owner and that was correct **while the question asked for an edge**. *“Through which edge does `BC-05` queue an offline write?”* is architectural; *“does it perform one at all?”* is product scope, and answering the second **removes** the first. *Superseded line, retained:* **Owner: Architecture Owner.** Tracked as **`FEE-GAP-002`** — *(a) CLOSED · (b) CLOSED at v0.7, recorded not in force · (c) **OPEN and blocking***  — and **`FEE-GAP-016`** *(new, blocking)*.

> **This check is one decision-in-force and one capability declaration away from PASS**, which is materially
> closer than v0.6 — but *closer* is not *passed*, and this record does not relabel it.
>
> ✅ **At v1.2 it is PASSED, and the count in the sentence above turned out to be short.** It named **two** outstanding things; there were in fact **three**, the third being the offline-capture limb this sentence omitted. **The sentence is retained with its error visible**, because this record has now under-counted check 2's blockers twice — *"exactly two reasons"* in the v1.0 verdict row against §3's three, and *"one decision and one declaration"* here — and a habit of arithmetic that consistently errs toward optimism is worth more as evidence than as a corrected number.

---

## 4. Check 3 — Rank direction is downward

**Authority:** Dependency Matrix `L2`. **Failure:** illegal import.

| Dependency | Direction | Lawful under |
|---|---|---|
| `BC-05` → `BC-06`, `BC-02`, `BC-01` | Intra-cluster | Matrix **L89** — Core Library cluster, allow-list `E-01`…`E-10` |
| `BC-05` → `BC-21`, `BC-19`, `BC-25`, `BC-24`, `BC-22` | Domain → platform/generic | Downward; `E-17`…`E-23` are declared *"all contexts"* edges |
| `BC-05` → `platform/business` **via port** | **Rank 8 → 6, downward** | Matrix cell `LIB → BUS` = `◇` (§3.3, verified mechanically) · manifest `may_use_ports` **L196** · Accepted `ADR-0012` **L86** |
| `BC-05` → `BC-31` Integration **direct** | **Not claimed** | Would be **illegal** — Matrix L167 `✖`, anti-pattern `X-03` |

**The v0.6 finding strengthens this check rather than weakening it.** Recognising the `business.payment_intent`
port confirms a **rank 8 → rank 6 descent**, which is the lawful direction. The route the architecture forbids —
`BC-05` reaching Integration directly — remains unclaimed, and `PRD-008` §22 was rewritten at v0.6 to say
precisely that: the module has *"a lawful route to gateway capability, but names no context at the far end of
it."* The manifest's `banned_imports` for `domain/library` still lists `platform/integration/**`, and nothing in
this PRD approaches it.

**Result — ✅ PASS.**

---

## 5. Check 4 — No authorisation decided outside `BC-18`

**Authority:** `X-13`. **Failure:** *"a security defect that passes its own tests."*

### 5.1 Decisions are consumed, never invented

BC Map **L127** — `BC-18` Identity & Access *"Owns credentials, sessions, devices, OTP, roles, permissions,
policy decisions, consent."*

| PRD-008 position | Identifier |
|---|---|
| Every financial write authorised against acting role **and** tenant scope | `FEE-FR-053` |
| Creating any role, or granting capability by dashboard visibility, is **excluded** | `FEE-XC-014` |
| Client-side success is *"a hint, never a financial fact"* | `FEE-BR-014`, `FEE-AC-032` |

### 5.2 `PR-1` — used as it exists, extended in no way *(re-confirmed at v0.6)*

Rank 3 `prd-v2/02` **L123-127**:

> `PR-1` Platform Administrator — **Purpose:** *"…provision and suspend tenants, **manage platform
> configuration**, administer platform-level security"* · **Scope:** *"platform-level objects only — tenants as
> entities, **platform configuration**, platform role assignments"*

| Requirement of the intent | Satisfied by | New rule needed? |
|---|---|---|
| A platform authority CAN change the commission rate / protection window | **`PR-1`**, existing | **No** |
| Owner / Manager / Reception / Student CANNOT | `AUTH-7.14` — a library role is scoped to one library and *"confers nothing in any other"* | **No** |
| Platform authority must not reach tenant data | `AUTH-7.13`, `AUTH-7.61`, `XC-7.13` | **No** |
| Provisioned internally, never self-registered | `AUTH-7.49` invite-only; `AUTH-2.6` | **No** |
| Attributable and auditable | `AUTH-2.7`, `AUTH-7.71`, `AUTH-7.40` | **No** |

**No new Platform Admin role is proposed, and *"Two, closed"* (`prd-v2/07` L79) stands untouched at v0.6.**
What remains open is narrower and is **not** an authorisation decision made here: a **named permission** in the
catalogue `AUTH-7.22` declares closed but never enumerates, and a **parameter row** in a configuration register.
**Neither was invented.** Both are carried by `FEE-GAP-015` to the `BC-18`/`PRD-001` and `BC-25`/`PRD-023` owners.
`AUTH-7.64` stands: the grant must be configuration authority, never authority over the policy model.

> **Explicitly checked at v0.6:** the gateway work introduced **no** new permission identifier, **no** new role,
> and **no** platform-authority concept. `ADR-0035` names `PR-1` nowhere as a grantee of anything new.

### 5.3 Result — ✅ **PASS**

`PRD-008` decides no authorisation, creates no role, enumerates no permission, and caches no decision.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

**Authority:** `ID-1`.

Exhaustive scan of `PRD-008` v0.6 for `password`, `OTP`, `credential`, `session token`, `secret`: **the module
stores, issues, validates and caches none.** `FEE-FR-053` names the *acting role*, which is a decision output
consumed from `BC-18`, not a credential.

**A gateway-specific risk was checked and is absent:** payment integrations commonly introduce API keys, webhook
signing secrets and merchant credentials. **None appears in `PRD-008` or in `ADR-0035`** — a direct consequence of
`ADR-0035` defining no gateway contract and no verification mechanism.

**Result — ✅ PASS.**

---

## 7. Check 6 — Tenant isolation

**Authority:** `MP-GBR-08`, `X-13`. **Failure:** cross-tenant leak — `MP-RSK-01`, Critical.

### 7.1 Every tenant-bearing surface

`E-18` supplies ambient `TenantContext`, *"propagated, never passed as a parameter through domain methods"* —
`PRD-008` consumes it and defines no tenant parameter of its own. `FEE-XC-016` already excludes cross-tenant
reach. **The v0.6 gateway finding adds no tenant-bearing surface**: a port declaration carries no data model, and
`ADR-0035` defines no payload, no correlation identifier and no reconciliation key.

### 7.2 The cross-library privacy question — prohibited unconditionally

| Rule | Text | Effect |
|---|---|---|
| **`SID-4.19`** | `BC-10` *"**SHALL NOT** answer, and **SHALL NOT** be capable of answering, 'which libraries does this person attend?'"* | Bars the **capability**, not merely the field |
| `SID-5.8` | names **`membership state`** as a field that *"**SHALL NEVER** exist"* in `BC-10` | Closes the obvious storage location |
| `ID-2` | *"`StudentRecordId` **never** leaves its tenant"* | **CI-enforced** — `banned_symbols`, `tool/module_dependencies.yaml` L216-218 |
| `ID-3` | global contexts must not resolve which library a person attends *"unless the person explicitly published it"* | The only lawful door is explicit consent — **no edge, no lawful basis, no revocation path exists** |
| BC Map L510 | an unregistered cross-tenant path is *"the single highest-severity failure mode in the entire architecture"* | Settles severity |

`PRD-008` builds none of it. `FEE-XC-019` and `FEE-XC-021` are unconditional prohibitions that hold however
`FEE-GAP-013` is later decided. **No fraud score, trust score, blacklist, risk label or punishment history appears
anywhere in the PRD** — re-verified by scan at v0.6.

> **A gateway-shaped tenant risk was checked.** A shared payment rail is a classic place for tenant identity to
> leak into a global namespace (merchant references, order IDs, customer records). Because **no counterparty
> context is declared and no contract is defined**, no such surface exists to review. When the Architecture Owner
> resolves `FEE-GAP-002`(b), **tenant isolation across the payment rail must be reviewed again** — this record
> cannot pre-approve it. Recorded as a standing condition in §9.3.

### 7.3 No index is created

`PRD-008` creates no cross-tenant index, satisfying `MP-GBR-08`'s index clause **by abstention**.

### 7.4 Result — ✅ **PASS**

---

## 8. The fifteen mandated topics — explicit disposition of each

Each row states the finding, the authority, and whether it **blocks Stage 3**.

| # | Topic | Disposition at v0.6 / `3d98330` | Authority | Blocks Stage 3? |
|---|---|---|---|---|
| **1** | **`BC-05` ownership** | Owns **fee obligation, student payment, receipt, student financial history**. One aggregate `FeeLedger`, matching BC Map §8 L374 exactly. §2 | BC Map §3, §8 | **No** — ✅ PASS |
| **2** | **Payment-gateway ownership** | **`BC-31` Integration** owns gateway *integration* (BC Map §7 `E-25` target). **`BC-20`** owns a *"gateway"* in its own scope line (**L129**) — but **only for library→LIBOORA money**. **No context owns student→library payment execution.** §3.5 | BC Map L129, L334; `MP-GBR-24` | **YES** — this is the blocker |
| **3** | **`business.payment_intent`** | ✅ **An already-approved, already-declared port.** Dependency Matrix **L196**, inside the section **L171** calls *"the normative form"*; prescribed by name in `X-03` **L352**; tabulated by Accepted **`ADR-0012` L86**. **Not invented here. No approval required to use it as transport.** §3.3 | Matrix §6 (Rank 4); `ADR-0012` (Rank 2) | **No** — resolved by measurement |
| **4** | **`E-25`** | Authorises **`BC-20` → `BC-31`** only (BC Map **L334**). It does **not** authorise `BC-05` anything. **Unchanged, uninvoked, unwidened by `PRD-008`.** | BC Map L334 | **No** — correctly not relied upon |
| **5** | **`D-14`** | ⚠ **Mis-attributes `E-25` to `PRD-008`** (`PRD_DEPENDENCY_GRAPH.md` **L116**). The register is **self-declared *"Derived. Non-normative."***, so the citation is **stale, not authoritative**. Correction **recommended** in `ADR-0035` `D-3`, **not executed**; the file is untouched. §3.7, `AA-C2` | `PRD_DEPENDENCY_GRAPH.md` header | **No** — a citation defect, not a grant |
| **6** | **Dependency Matrix** | **Unchanged. Hash re-verified `9895d244494372af`.** No allow-list widened, no cell altered, no port added. The Matrix is *relied upon as authority*, not amended. §3.3 | Rank 4 | **No** |
| **7** | **`BC-20` commission boundary** | **Held.** Commission, SaaS billing, library→LIBOORA relationship and platform settlement remain wholly `BC-20`'s, routed by `FEE-GAP-014`. **`FEE-FR-060`'s snapshot still carries no commission, gateway or tax field.** `BC-20` was explicitly **excluded** as the payment counterparty rather than co-opted. §2.2, §3.5 | `MP-GBR-24` (Rank 1); `ADR-0015` | **No** — ✅ PASS |
| **8** | **`PR-1`** | Used **exactly as it exists**. *"Manage platform configuration"* is already in its Purpose and Scope (`prd-v2/02` L123-127). **No new role. No invented permission identifier.** The open items are a named permission (`BC-18`) and a parameter row (`BC-25`), both routed by `FEE-GAP-015`. §5.2 | `PRD-001` v2 (Rank 3) | **No** — ✅ PASS |
| **9** | **3% commission intent** | Preserved as **product intent**, enacted **nowhere**. Measured: an approved `3%` default = **0 occurrences** in ranked sources. No `FEE-CFG-*` register opened, no default, no range, no maximum. Historical-rate immutability is held by `FEE-FR-060` + `FEE-INV-010` + `FEE-BR-028` — *a config change is never retroactive* — **without the rate itself living in `BC-05`** | `CONFIGURATION_GUIDE.md` §5; `ADR-0031` precedent | **No** — `FEE-GAP-014` |
| **10** | **3-day renewal protection** | Preserved as **product intent**, enacted **nowhere**. ⚠ The only *recorded* recommendation is **24h** (BC Map L540, Master PRD L673) and even that is *"Open"*. **No window value written.** `FEE-GAP-013`(a2) | `PRD-005` §7.4 — *a recommendation inside an open question "is not a decision"* | **No** — feature-blocking, not PRD-blocking |
| **11** | **`BC-02` boundary** | **Intact.** Membership term, `endDate` and duration consumed, never computed (`FEE-XC-020`; `MM-FR-057`/`058` FROZEN). The three-date ambiguity is closed by measurement without inventing arithmetic. **Lifecycle ownership stays `BC-02`.** | `PRD-002` FROZEN (Rank 3) | **No** — ✅ PASS |
| **12** | **`BC-04` boundary** | **Intact.** No seat obligation of any kind (§42.6; `FEE-XC-018`…`021`). **Seat ownership stays `BC-04`.** Frozen `PRD-007` untouched | `PRD-007` FROZEN (Rank 3) | **No** — ✅ PASS |
| **13** | **Tenant isolation** | ✅ **PASS.** Ambient `TenantContext` via `E-18`; no tenant parameter defined; no cross-tenant index; `SID-4.19`'s **capability** bar honoured. ⚠ **Standing condition:** a shared payment rail is a classic tenant-leak surface — because no counterparty and no contract exist, there is nothing to review, so **isolation across the rail must be re-reviewed when `FEE-GAP-002`(b) is resolved.** §7.2 | `MP-GBR-08`, `X-13`, `SID-4.19` | **No** — ✅ PASS, with a named future condition |
| **14** | **Online payment verification** | **Rule held, mechanism not invented.** `FEE-BR-014` + `FEE-AC-032`: a client-side success signal alone **does not** move a payment out of `PENDING`. `FEE-RSK-04` records the risk. **No webhook schema, no verification protocol, no signature scheme, no provider behaviour, no endpoint defined** — and none *can* be, until the counterparty exists. §3.5, §3.8 | PRD-008 `FEE-BR-014`, `FEE-AC-032` | **Rule ✅ · mechanism ⛔** — part of the blocker |
| **15** | **Offline financial-write prohibition** | ✅ **Held and strengthened.** `FEE-FR-061` — cash reaches `CONFIRMED` **only** by server-side recording. `FEE-XC-022` — **no offline financial write of any kind**, stated as an *exclusion* rather than a configurable so no offline mode can be switched on later. Consequences preserved: offline ⇒ no CONFIRMED cash, **no membership activation**, no final receipt, no ledger settlement. Consistent with `E-24` granting offline sync to `BC-03` **only** | PRD-008 §28.1; BC Map L333 | **No** — ✅ PASS |

**Nine ✅ PASS · four resolved-by-measurement or correctly-abstained · one ⚠ raised · one ⛔ blocking.**
The single blocking topic is **#2**, with **#14**'s mechanism as its direct consequence.

---

## 9. Conflicts, gaps and dispositions

### 9.1 ⚠ Conflicts RAISED — pre-existing defects in ranked documents, not created by this PRD

| # | Defect | Evidence | Owner | Class | Disposition |
|---|---|---|---|---|---|
| `AA-C1` | **Refund tier contradiction.** BC Map (**Rank 4**) L100/L374/L422 place refunds in `BC-05` at **V1**; EA (**Rank 6**) L823/L1408 say **V2**. FROZEN **Rank 3** `PRD-005` L942 routes a live flow to *"a refund decision by `BC-05`"* | Cited lines re-read at HEAD | **Product Owner** (scope) + **Architecture Owner** (EA correction) | **E + D** | **RAISED, not chosen.** Rank 1 `MP-CON-08`: the EA *"is updated to match — never the reverse."* `PRD-008` records the precedence and **declines to downgrade refund to V2**. `FEE-GAP-001` |
| `AA-C2` | **`D-14` mis-attributes `E-25`.** `PRD_DEPENDENCY_GRAPH.md` L116 assigns `E-25` to `PRD-008`; BC Map L334 makes `E-25` **`BC-20` → `BC-31`**. **New at this pass:** the register's header declares it *"Derived. Non-normative."*, so the row is a **stale citation**, not a grant | Both lines re-read | **Architecture Owner** | **D** | **RAISED; correction recommended in `ADR-0035` `D-3` and NOT executed.** The file is untouched |
| **`AA-C3`** | **NEW — Rank 1 internal contradiction.** `MASTER_PRD.md` **L232** routes *Payments* via `BC-20`→`BC-31`; **L362** `MP-GBR-24` bars `BC-20` from student money. **Both Rank 1 — precedence cannot arbitrate** | §3.6 | **Product Owner** (which concept L232 names) + **Architecture Owner** | **E + D** | **RAISED, deliberately not chosen.** `DOCUMENTATION_BASELINE.md` §4 — *"do not choose, raise it."* Disclosed identically in `ADR-0035` §3 |
| **`AA-C4`** | **NEW — a declared port with no implementing context.** Dependency Matrix **L196** declares `business.payment_intent` for `library_management`; `platform/business` holds only `BC-20` and `BC-21`, neither of which may execute student→library payment. `PaymentIntent` = **0 occurrences** in `docs/` | §3.5 | **Architecture Owner** | **D** | **RAISED.** This is the substance of `FEE-GAP-002`(b) and the sole cause of the NOT ALIGNED verdict |

**No conflict is created by `PRD-008` itself.** All four are contradictions or omissions *between existing
documents* that this PRD surfaces.

### 9.2 Governance classification of every open item — A to F

| Class | Meaning | Items in this record |
|---|---|---|
| **A** — already authorized | No further act needed | **`FEE-GAP-002`(a) transport** — authorised by Matrix §6 L196 + `X-03` L352 + `ADR-0012` L86 · **`PR-1`** platform-configuration authority · **`E-01`…`E-10`** intra-cluster use |
| **B** — resolvable from existing authority | Derivable without a new decision | **`AA-C2` / `D-14`** — a citation correction in a self-declared non-normative register; needs execution, not adjudication · **`ADR-0035` `D-1`** — *recognition* of an existing authorisation |
| **C** — validly deferred | Correctly out of scope now | `FEE-GAP-003`, `007`, `008`, `009`, `010`, `011`, `012` · `FEE-GAP-013`(a2) window value · `FEE-GAP-014` commission model → `PRD-022` · offline-sync path for `BC-05` (`BC-30`) |
| **D** — **Architecture Owner approval required** | | **`FEE-GAP-002`(b) — `AA-C4`, which context executes student→library payment** *(the blocker)* · **`ADR-0035` `D-2`**, choosing among `O-1`/`O-2`/`O-3` · webhook / verification-receipt ownership under the chosen option · **accepting `ADR-0035` itself** · `AA-C1`'s EA correction |
| **E** — **Product Owner approval required** | | **`AA-C3`** — which concept `MASTER_PRD.md` L232 names · `AA-C1` refund V1/V2 **scope** · the **3%** value · the **3-day** window value |
| **F** — frozen-document amendment required | | **None arising from this pass.** *(Two unexecuted `ADR-0033` amendments in frozen `PRD-006` L2170 / `PRD-007` L867 are pre-existing and out of scope)* |

> **`ADR-0035` is `PROPOSED`. A Proposed ADR is never called Accepted.** Its `D-1` is class **B** (recognition of
> an existing authorisation), but *recognising* it changes a Stage 3 verdict — and a document may not upgrade its
> own verdict on its own say-so. That restraint is `ADR-0033` §7.1: *"A conferral for one act is not a standing
> licence."*

### 9.3 Gaps — 17, with Stage 3 impact stated individually *(15 → 16 at v0.7: `FEE-GAP-016` added; 16 → 17 at v0.8: `FEE-GAP-017` added)*

| Gap | Blocks Stage 3? | Class | Owner |
|---|---|---|---|
| **`FEE-GAP-002`** — gateway path | ✅ **NO at v1.2 — ALL FOUR LIMBS CLOSED; this gap no longer blocks Stage 3.** (a) transport closed by measurement · (b) counterparty decided (`O-3`) and **in force** · **(c) offline sync CLOSED by `ADR-0037`** (Product Owner) — dissolved by denying its premise, **no `BC-05` → `BC-30` edge**, **no `BC-32`** · (d) inbound webhook resolved. ⛔ **It still BLOCKS Stage 4**, and that field is deliberately unchanged. *Superseded text retained:* **(a) transport — NO, closed by measurement** · **(b) counterparty — NO at v1.1: decided (`O-3`) and now IN FORCE** · **(c) offline sync — ⛔ YES at v1.1, and now the SOLE cause of NOT ALIGNED.** *Superseded reading, retained:* *"(b) counterparty — **YES, the sole cause of NOT ALIGNED**· (c) offline sync — no"*. **The blocking part moved from (b) to (c)** — not because (c) got worse, but because (b) was answered and (c) never was. `E-24` is `BC-03` → `BC-30` only; edges `BC-05` → `BC-30` = **0** | **A / D / C** | **Architecture Owner** |
| `FEE-GAP-001` — refund V1/V2 | No — a tier question, raised as `AA-C1` | E + D | Product Owner + Architecture Owner |
| `FEE-GAP-004`, `005`, `006` | No — requirement-level, Stage 4 concerns | E | Product Owner |
| `FEE-GAP-003`, `007`, `008`, `009`, `010`, `011`, `012` | No | C | Named per gap in §37 |
| **`FEE-GAP-016`** — inbound webhook owner *(added v0.7)* | ✅ **NO at v1.1 — RESOLVED.** It **did** block check 2 from v0.7 to v1.0; `ADR-0035` §5.5b, `ACCEPTED` by conferral, declares the receiver an **existing Business Platform capability**. **No `BC-32`**, count stays **31**. ⚠ **This gap had no row in this table before v1.1 — a pre-existing omission in a table headed *"17"* that listed sixteen, disclosed rather than silently filled** | **D** | **Architecture Owner — discharged** |
| `FEE-GAP-013` — renewal protection | No — `BC-05` owns none of the blocked parts. **At v1.1** (a2) and (f) are **answered by conferral** (`ADR-0036`, `PARTLY ACCEPTED`); (b), (c), (d), (g) and the window's **first day** remain open. **Still not a Stage 3 matter for `BC-05`** | C + E | Product Owner, `BC-02`/`BC-06`, Architecture, Security |
| `FEE-GAP-014` — commission has no owning document | No — it is `BC-20`'s subject | C | `BC-20` owner / Architecture Owner |
| `FEE-GAP-015` — permission + parameter row | No — role question **CLOSED** by `PR-1`; remainder is outside `BC-05` | C | `BC-18`/`PRD-001`, `BC-25`/`PRD-023` |
| **`FEE-GAP-017`** — library → LIBOORA commission settlement has no owning aggregate and no enumerated permission *(added v0.8)* | **No** — and this is a measured finding, not a convenience: **`BC-05` owns none of it.** Ownership of the receivable is **already determinate** (BC Map **L129**, `BC-20`), the outbound rail **already exists** (`E-25`, manifest **L409**), so nothing about `BC-05`'s boundary is in question. What is missing lives in **`BC-20`/`PRD-022`** (no commission or receivable aggregate — BC Map **L382**) and in **`PRD-001`** (no enumerated permission anywhere, so `AUTH-7.22` + `AP-9` fail-closed deny the action **even for `TR-1` Owner**) | C | `BC-20` owner / `PRD-022` author · `PRD-001` owner (permission) · Architecture Owner (basis-fact path) |

#### 9.3a Why `FEE-GAP-017` does **not** change the verdict *(added v0.8)*

The verdict stays ⛔ **NOT ALIGNED — 5 of 6**, and the **single** blocked check stays the same one (`FEE-GAP-002`(c) offline sync, plus the standing condition below). `FEE-GAP-017` is a **real and load-bearing product blocker** — a cash-only library genuinely cannot pay its ₹1,500 today — but it is **not a `BC-05` boundary defect**, and the distinction matters:

| Question a Stage 3 check could ask | Answer measured at v0.8 | Effect on verdict |
|---|---|---|
| Does `BC-05` claim money it does not own? | **No.** `FEE-XC-023` forbids a settlement entering any `BC-05` model; `FEE-FR-060` carries no commission field | None — strengthens check 2 |
| Is a new bounded context implied? | **No.** BC Map **L129** already assigns library → LIBOORA money to `BC-20` | None — no `BC-32` |
| Is a new edge implied? | **No.** `E-25` (`BC-20 → BC-31`) already exists, and the basis fact may travel on the existing `fee.FeePaymentReceived` event | None — edge count stays **26** |
| Is a register violated? | **No**, but only because nothing was minted: no permission identifier, no sixth tenant role, no third platform role | None |
| Can the feature ship? | **No** — `PRD-022` does not exist and no permission is enumerated | **Blocks `PRD-022` and the product feature, not `BC-05`** |

> **Recording this as a Stage 3 blocker would have been the flattering error in reverse** — it would make this record look stricter while mis-attributing another module's absence to `BC-05`. The honest statement is that **`BC-05` is aligned on this point and the platform is not yet capable of it.**

**Standing condition (not a gap):** when `FEE-GAP-002`(b) is resolved, **tenant isolation across the payment rail
must be re-reviewed** (§7.2). This record can pass check 6 on what exists; it cannot pre-approve what does not.

**No gap is resolved into non-existence by this record, and none is invented.** `FEE-GAP-002` moved from OPEN to
**PARTLY RESOLVED** *by measurement of existing authority*, not by grant, and its blocking half is untouched.

---

#### 9.3b Why the v0.9 revision does **not** change the verdict *(added v0.9)*

The verdict stays ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 check BLOCKED**, and the blocked check stays the same
one, for the same two reasons. This is a **stasis finding**, and it is worth stating explicitly because a revision
that *relocates* questions can easily be mistaken for one that *answers* them.

| What v0.9 changed | Could it move a Stage 3 check? | Measured effect |
|---|---|---|
| §1 terminology note naming `LIBOORA PLATFORM CHARGE` and pointing at `PRD-022` `SAAS-BR-001` | **No** | Vocabulary only. `FEE-XC-023` still **excludes** the charge from `BC-05`, so the note *withholds* the term from this module rather than importing it. No obligation added |
| `FEE-GAP-014` and `FEE-GAP-017` amended to record that **`PRD-022` now exists** (`DRAFT` v0.1) | **No** | A gap with a named owner is still an **open** gap. `PRD-022` carries **6 of 6** blocking gaps of its own, so the questions moved to a lawful home and **none was answered** |
| §39.1 — all 17 gaps reconciled into the nine mandated categories | **No** | Classification, not resolution. It records that **`FEE-GAP-004` is measurably worse** (it now also blocks `PRD-022` `SAAS-GAP-001`) and that `FEE-GAP-016` is **unchanged** |
| §39.2 — frozen `MM-XC-012` / `MM-FR-100` / `MM-FR-111` measured as **forbidding** the requested 3-day term deduction | **No** | Narrows `FEE-GAP-013` from *undecided* to *forbidden in V1 without an amendment*. A narrowing is not a resolution, and **no frozen document was modified** |
| `ADR-0035` §5.5a re-measures the inbound-webhook question *(⚠ every clause of this cell was overtaken at v1.1 — §9.3d; retained as the dated v0.9 measurement)* | **No** | The ADR remains **`PROPOSED`**, `D-4` remains **OPEN**, `FEE-GAP-016` remains the cause of check 2 being ⛔ BLOCKED |

**Two of the fifth pass's findings are corrections to *this* record, not to the PRD:** the verdict row had carried a
stale gap count of **16** since v0.7, and the footer had claimed **v0.6, second pass** since v0.6. Both are fixed
above, and both are **declared rather than quietly overwritten**, because *a record that silently repairs itself
cannot be audited*. **Neither affects the verdict**, and the Stage-4 blocker count remains **6**.

**Check 2 remains ⛔ BLOCKED on `FEE-GAP-002`(b)/(c) and `FEE-GAP-016`, and Stage 4 must not start.** *⚠ **Superseded in its reasons at v1.1 — see §9.3d — and retained unedited, because this is a dated v0.9 finding and rewriting it would make it describe a day it did not describe.** The **directive is still in force**: Stage 4 must not start. What no longer holds is the list of causes — `FEE-GAP-016` is **RESOLVED** and `FEE-GAP-002`(b) is **in force**, so the single live cause is **`FEE-GAP-002`(c)**. A reader acting on this line today would reach the **right conclusion by the wrong route**, which is exactly why the correction is pointed to rather than pasted over.*

#### 9.3c Why the v1.0 correction does **not** change the verdict *(added v1.0)*

The v1.0 revision **retracted a finding rather than adding one**, which is a case this record has not previously had
to assess. Measured the same way as §9.3a and §9.3b:

| What v1.0 changed | Could it move a Stage 3 check? | Measured effect |
|---|---|---|
| §39.2 heading and framing: *"what the frozen rules already forbid"* → *"what the frozen rules constrain, and the finding this section got wrong"* | **No** | A claim about **`BC-02`/`BC-04`** frozen rules. Stage 3 checks `BC-05`'s alignment; `PRD-008` owns neither rule |
| The `SeatHold` row corrected: no such aggregate exists, but **none is needed** because `SEAT-BR-024` already retains the allocation | **No** | Concerns `BC-04` seating. No `BC-05` edge, aggregate or boundary is involved |
| Closing note: the `SeatHold` half withdrawn, the `Q-01` half retained | **No** | Narrows a statement about another module's blocker |
| Changelog v1.0 row; header/footer version | **No** | Metadata |
| **`FEE-GAP-013` status** | **No** | **Still OPEN.** It never blocked `BC-05`'s Stage 4 or Freeze (it blocks the *feature*), and it still does not |

**Nothing in this revision touches an integration edge, a context boundary, an authorisation decision or tenant
isolation, so no check could change state.** Check 2 remains ⛔ **BLOCKED** for the two unchanged reasons:
`FEE-GAP-016` (inbound webhook transport has no declared owner) and `ADR-0035` being `PROPOSED` rather than in force.
*⚠ **Both of those reasons were removed at v1.1 by conferral — see §9.3d — and this sentence is retained unedited as the dated v1.0 finding it is.** `FEE-GAP-016` is **RESOLVED** and `ADR-0035` is **`ACCEPTED`**, so **neither** cause named here survives. Check 2 nevertheless **still fails**, on a third cause this sentence never listed — `FEE-GAP-002`(c) — which is the strongest available evidence that this record's habit of counting reasons was itself unreliable, and the reason §3 now carries an explicit three-reason disposition table instead of a prose count.*

> **A correction is not progress, and this record must not present it as such.** It would be easy to read *"a
> blocker was found to be softer than we thought"* as movement toward alignment. It is not. What changed is that a
> **wrong** statement in `PRD-008` became a **right** one; the architecture is exactly as unaligned as it was, and
> `ADR-0036` — which carries the corrected position — is **`PROPOSED`, not accepted**, so it cannot be counted
> either. **`ADR-0036` does not appear in this record's *Authorities applied* row** for that reason.

#### 9.3d Why the v1.1 conferral moves the *reasons* but not the *verdict* — the requested re-run *(added v1.1)*

This is the first pass in which a check's blocking reasons were **removed by decisions actually taken**, rather than
narrowed by measurement. It is therefore the pass most at risk of over-claiming, and it is measured the same way as
§9.3a–§9.3c.

| What v1.1 changed | Could it move a Stage 3 check? | Measured effect |
|---|---|---|
| `ADR-0035` **`PROPOSED` → `ACCEPTED`** by conferral | **YES — and it did** | `D-1` (transport) and `D-2` (`O-3` executor) now **bind**. Reason (ii) of check 2 is **gone**. No edge added, no Matrix change, no aggregate moved |
| `ADR-0035` **new §5.5b** answering `D-4` — inbound webhook = existing Business Platform capability | **YES — and it did** | Reason (i) of check 2 is **gone**. `FEE-GAP-016` **RESOLVED**. **No `BC-32`**; count stays **31**; `BC-31`'s **outbound** scope unchanged; **no endpoint, schema, signature scheme, retry policy or provider named** |
| `FEE-GAP-002` Status/Impact: (b) now **in force**, (c) **still OPEN** | **No — it is the reason the check still fails** | Reason (iii) is **untouched**. `E-24` is `BC-03` → `BC-30` only; edges `BC-05` → `BC-30` = **0** |
| PRD header counts **6 → 5** Stage 4, **11 → 10** Freeze | **No** | Re-derived from every gap block's own field (§39.1). Counts describe the ledger; they do not decide a check |
| `ADR-0036` **`PARTLY ACCEPTED`**; `FEE-GAP-013`(a2)/(f) answered; §39.2 records the 3-day decision | **No** | Concerns `BC-02`/`BC-04`/`BC-06` — membership term, seat release, library policy. **`PRD-008` owns none of it**, and `FEE-GAP-013` never blocked this PRD's Stage 4 or Freeze. **No frozen document modified** |
| `FEE-GAP-014`/`015`/`017` Status rows: 3%, the 15th, cash-only independence, `BC-20` ownership | **No** | All are **`BC-20`/`PRD-022`** subjects. `MP-GBR-24` still bars this PRD from specifying them, and **no permission or parameter identifier was allocated** |
| `FEE-RSK-10` stale *"5"* flagged; verdict-row *"two reasons"* inconsistency disclosed | **No** | Corrections to counts and to *this* record. Declared, not silently repaired |

**Only two of the seven changes could move a check, and both moved the same one, in the same direction, without
completing it.** Check 2 goes from **three** reasons to **one**.

> **The surviving reason, stated so it cannot be mistaken for a formality.** `FEE-GAP-002`(c) asks through which
> declared edge `BC-05` **queues an offline financial write**. `E-24` is `BC-03` → `BC-30`. Edges `BC-05` → `BC-30`
> are **0**. The ten decisions given at v1.1 concerned payment execution, the inbound webhook, payment intent and
> verification ownership, gateway integration, settlement ownership, the 3% Platform Charge, the 15th due day,
> cash-only settlement independence, the 14-day trial and 3-day renewal protection. **Offline financial capture
> appears in none of them.** It was not refused, deferred or narrowed — **it was not addressed**, and this record
> does not treat silence as assent.
>
> **Why this record does not pass the check anyway.** Two of three reasons falling is the largest single improvement
> in seven passes, and there would be a readable story in calling the remainder a detail. **That story would be
> false.** `FEE-GAP-002`(c) is the offline path for **financial writes** — the case where money is taken while the
> network is absent — and `PRD-008`'s own `FEE-BR-014` exists precisely because unverified capture is how financial
> truth is lost. A gate that passed here would certify an alignment **nobody decided**.

**Check 2 remains ⛔ BLOCKED. Stage 4 must not start. `PRD-008` is not re-statused and not frozen.**

> **What this pass deliberately did NOT do.** It did not create `BC-32` · did not add or renumber any `E-*` edge ·
> did not invent an endpoint, URL, payload schema, signature algorithm, replay window, retry policy or provider ·
> did not allocate a `PERM-*`, `CFG-*`, `LCFG-*`, `ICFG-*` or `SEAT-CFG-*` identifier · did not modify any frozen
> document · did not weaken any checker · did not accept an ADR from inside this record · did not change
> `PRD-008`'s registry status, which would resolve `GCP-14` by fiat · and wrote **no implementation code**.

## 10. Rejected findings — recorded as rejected, with reasons

Per Stage 3: *"A review that records only accepted findings is indistinguishable from a review that found
nothing."* And: *"A rejected finding must be recorded as rejected, with its reason."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `AA-R1` | *"`E-06`/`E-07`/`E-09`/`E-10` are same-rank Core dependencies and breach `L2` downward-only."* | Matrix **L89** declares the Core Library cluster a bounded `L2` exception with the explicit allow-list `E-01`…`E-10`. All four are inside it. `L2` is satisfied **by** the declared exception — the identical reasoning `PRD-007`'s `AR-R1` recorded |
| `AA-R2` | ↺ **SUPERSEDED — see `AA-R2′` below.** *(Original text, retained: "`PRD-008` should declare the `business.payment_intent` port as its gateway path and pass check 2." — Rejected because: "The port is real (Matrix L196, `X-03` L352) but has **no numbered edge**, and BC Map L292 is absolute. Adopting it here would resolve an Architecture Owner's question inside a Stage 3 review — and would be indistinguishable from inventing an edge.")* | **The rejection was half right and half wrong, and the wrong half was load-bearing.** See `AA-R2′` |
| **`AA-R2′`** | **NEW, replacing `AA-R2`.** *"The port has no numbered edge, and BC Map L292 is absolute, so it cannot be relied upon."* | **Rejected on three measurements the first pass did not make.** **(i)** L292 is **not** absolute in the sense assumed: Accepted **`ADR-0033` §3** holds verbatim that it *"governs edges"* and *"does not state that every cross-context read must be an edge."* **(ii)** Treating it as absolute would invalidate **14 of `library_management`'s 17 declared ports**, including `identity.policy_decision` — the port check 4 of this very gate requires (§3.4). A reading that voids the gate's own prerequisite is the wrong reading. **(iii)** Accepted **`ADR-0012` L86** already tabulates `domain/library → platform/business :payment_intent` as a correctly-directed declared port, so the relationship is not novel. **What the first pass got right is preserved:** relying on the port does **not** pass check 2 — because the *counterparty* is still undeclared (§3.5). **The verdict is unchanged at 5/6; only the reason is corrected.** Recorded in `ADR-0035` `D-1`, **`PROPOSED`** |
| **`AA-R2″`** | **NEW.** *"Since the transport is authorised, `FEE-GAP-002` can be closed and check 2 declared PASS."* | **Rejected.** A route with nothing at its far end executes no payment. `platform/business` holds only `BC-20` and `BC-21`; `PaymentIntent` = **0 occurrences** in `docs/`; and `MP-GBR-24` bars `BC-20` from student money. Closing the gap here would resolve an Architecture Owner's question inside a Stage 3 review and would make the PRD *look* complete while the architecture stayed wrong. **This is the finding most tempting to accept, and it is the one most important to refuse** |
| `AA-R3` | *"Adopt refund = V1 now, since Rank 4 outranks Rank 6, and write the refund requirements."* | The **precedence** is mechanical and is recorded; the **scope** of V1 refund is a Product Owner decision. `PRD-005` §7.4: a recommendation inside an open question *"is not a decision."* Writing a refund state table on this basis would be self-acceptance |
| `AA-R4` | *"`FEE-GAP-015` is a conflict with a closed register and blocks Stage 3."* | **Disproven by measurement.** `PR-1`'s Purpose and Scope already include *"manage platform configuration"* (`prd-v2/02` L123-127). No new role is needed; *"Two, closed"* is not challenged. Retracted in `PRD-008` v0.5 and unchanged at v0.6 |
| `AA-R5` | *"Set the commission rate at 3% and the protection window at 3 days as configuration defaults, since the product intent states them."* | `CONFIGURATION_GUIDE.md` §5 — adding a parameter requires *"a PRD amendment"*; the guide *"cannot change the envelope."* No register holds either value. `ADR-0031` is the standing precedent: *"a twenty-fifth configuration row was refused rather than invented"* |
| `AA-R6` | *"The EA listing `Refunds (V2)` conflicts with `BC-05` ownership and must be fixed for Stage 3 to pass."* | The EA is **Rank 6, descriptive only**, and Stage 3's scope is Ranks 1–5. A descriptive document trailing normative ones is a defect to raise (`AA-C1`), not a Stage 3 blocker |
| **`AA-R7`** | **NEW.** *"`BC-20` already owns a gateway (BC Map L129), so route the student payment through `BC-20` and the problem disappears."* | **Rejected on Rank 1.** `MP-GBR-24` forbids the two finance concepts sharing *"a model, a table or a metric."* Accepted **`ADR-0015`** exists *solely* because three rows collapsed these contexts, calling it *"not merely wrong; it erases a distinction the map treats as load-bearing."* This would repeat that exact defect at architecture level rather than identifier level. **`O-2` in `ADR-0035` §6 preserves a narrow variant** — `BC-20` operating the rail while modelling no student money — but that is a **Architecture Owner** choice, presented and **not recommended** |
| **`AA-R8`** | **NEW.** *"Add an `E-*` edge from `BC-05` to the gateway-bearing context; that is what BC Map L292 asks for."* | **Rejected twice over.** **(i)** It is unnecessary — §3.3 shows the transport is already authorised, so the edge would add no permission. **(ii)** It is precedentially barred: **`ADR-0033`** refused option `O-A` (allow-listing `E-27`) precisely because *"its only effect would be to remove a documentation contradiction — which is 'adding it to make the conflict go away.'"* **No `E-27`, no `E-32`, and no new edge of any number was created by this pass** |

---

## 11. Containment audit

| Constraint | Result |
|---|---|
| Frozen documents modified | **None.** `PRD-004`, `PRD-005`, `PRD-006`, `PRD-007`, Library PRD, Student Identity PRD unchanged — hashes re-verified |
| Ranked documents modified | **None.** BC Map, Dependency Matrix, Master PRD, `tool/module_dependencies.yaml`, `CONFIGURATION_GUIDE.md`, `PRD-001` read-only |
| `PRD_DEPENDENCY_GRAPH.md` modified | **None** — the `D-14` correction is **recommended and not executed** |
| ADRs **accepted** | **None.** `ADR-0035` is **`PROPOSED`** and binds nothing |
| ADRs authored | **One** — `ADR-0035`, the smallest ADR that states the finding. Amends no ranked document |
| Edges invented | **None.** No `E-*` created, no allow-list widened, no matrix cell altered |
| Bounded contexts invented | **None** |
| Gateway contracts, webhook schemas, endpoints, tables, provider behaviours invented | **None** — verified by scan of both the PRD and the ADR |
| Configuration ranges invented | **None** — no `FEE-CFG-*` register; 3% and 3 days recorded as **intent** |
| Roles or permissions invented | **None** — `PR-1` used as it already exists |
| Registry or baseline updated | **None** — `PRD-008` remains `PLANNED`; status is conferred at Stage 7 |
| Source code modified | **None** — zero Dart files touched |
| Gates weakened | **None** — the only tooling change was correcting `/tmp/verify008.py`'s hardcoded `v0.5` expectation to `v0.6`, which **tightens** the check against the current document. **No gate allow-list was widened** (see the disclosure below) |

### 11.1 ⚠ Disclosed side-effect — this pass added two files to a pre-existing gate finding

`prd007_traceability.py` fails (exit **1**) on, among other things, *"bare `SEAT-` substring found outside the
module"*. Measured across this pass rather than assumed:

| Measurement | Value |
|---|---|
| Offending files at baseline `3d98330` | **24** |
| Offending files at this HEAD | **26** |
| **Added** | `ADR-0035-bc-05-payment-gateway-path.md` · `PRD-008_ARCHITECTURE_ALIGNMENT.md` |
| Removed | none |
| Gate **exit code** | **1 → 1 — unchanged** |

**Cause.** Both documents quote Accepted `ADR-0033` §3 **verbatim**, and that sentence contains the token
`SEAT-FR-104`. The quotation is load-bearing — it is the precedent on which `AA-R2′` and `ADR-0035` `D-1` rest
(§3.4, §10) — so paraphrasing it to dodge a substring match would weaken the evidence to flatter a checker.

**Why nothing was changed to clear it.** The gate's own comment states the allow-list is *"deliberately
enumerated file by file rather than widened … so a stray `SEAT-` in any other governance document still
fails the run"*, and that **a citation is not a collision** — *"a collision would be another register
DEFINING a `SEAT-` identifier, which the duplicate-definition and form checks above still catch."* Verified:
**neither document defines any `SEAT-*` identifier**; each contains exactly one *citation*. Adding either file
to `ALLOWED` would be **gate weakening** and is refused. **Disclosed here for the Architecture Owner rather
than silenced.**

### 11.2 Gate results — each run independently, exit code captured immediately

| Gate | Exit | Baseline | Verdict |
|---|---|---|---|
| `prd004_traceability.py` | **1** | 1 | Unchanged — 13 untraced `SM-*`, 94.6% |
| `prd005_task_coverage.py` | **0** | 0 | PASS — 223/223 |
| `prd005_traceability.py` | **1** | 1 | Unchanged — 60.1% under the strict rule |
| `prd006_task_coverage.py` | **0** | 0 | PASS — 285/285 |
| `prd006_traceability.py` | **0** | 0 | PASS — and independently re-verified *"`PRD-008` … defines 0 `ATT-*` identifiers"* |
| `prd007_task_coverage.py` | **0** | 0 | PASS — 443/443 |
| `prd007_traceability.py` | **1** | 1 | Unchanged exit code; offender set 24 → 26, disclosed in §11.1 |
| `check_module_boundaries.dart` | **1** | 1 | Unchanged — 12 `ADR-0012` debts, red by design |
| `/tmp/verify008.py` (PRD-008 internal) | **0** | 72/3 | **75 passed, 0 failed** after the checker's `v0.5` expectation was corrected to `v0.6` |

> **The boundary gate corroborates the central finding independently of any document.**
> `check_module_boundaries.dart`, reading `tool/module_dependencies.yaml`, prints for `domain/library →
> platform/business`: *"Declared ports `platform/business:entitlement` and **`:payment_intent` are already
> correct**."* The port this record relies on is affirmed by the **machine-checked** form of the architecture,
> not only by the prose form. What the gate flags there is a *concrete-class injection* debt under `ADR-0012` —
> **the port itself is not in question.**
| Verdict relabelled | **No** — still ⛔ **NOT ALIGNED, 5 of 6** |

#### 9.3e Why the v1.2 decision moves the *verdict* — the first pass in eight to do so *(added v1.2)*

§9.3a–§9.3d each explained why a change did **not** move the verdict. This one did, so it is measured **more** strictly rather than less.

| What v1.2 changed | Could it move a Stage 3 check? | Measured effect |
|---|---|---|
| **`ADR-0037` `ACCEPTED`** — cash supported; financial recording server-authoritative; no offline write, queue, local ledger or sync | **YES — and it did** | Reason **(iii)** of check 2 is **GONE**. `FEE-GAP-002`(c) **CLOSED**. Check 2 → ✅ **PASS**. Verdict → ✅ **ALIGNED 6/6** |
| The explicit prohibition on a `BC-05` → `BC-30` edge | **No — it is why the check passes without one** | BC Map §7 **unchanged**; `E-24` still `BC-03` → `BC-30` only; map hash `81518f1bb251218b` byte-identical |
| The explicit prohibition on `BC-32` | **No** | `BC-32` register rows = **0**; context count stays **31**. Consistent with `AR-1` and `ADR-0035` `D-2` |
| `FEE-FR-061`, `FEE-XC-022`, `FEE-PO-006`, `FEE-PO-007`, `FEE-FR-029` | **No** | **None was added, reworded, widened or made configurable.** They already specified the decided behaviour; `FEE-AC-081`/`082` already verify it |
| `FEE-GAP-002` `Stage 4` field | **No** | **Deliberately left at `BLOCKS`.** No decision was given on its Stage-4 concerns |
| PRD version v1.1 → v1.2; counts re-derived | **No** | Stage-4 set unchanged at **5**, Freeze set unchanged at **10**. Metadata and arithmetic, not architecture |

**Exactly one of the six changes could move a check, and it moved exactly one check.**

> **The strongest objection to this pass, stated and answered.** *“A gate that failed for seven passes now passes without a single edge, requirement or line of architecture changing — is that a resolution or a redefinition?”* It is a resolution, and the test is who decided. Check 2 failed because a **required** integration had no declared edge. The requirement to integrate offline was **removed by the authority that owns product scope**, so the check's question — *is every integration edge declared?* — is now answered yes over a **smaller and correctly smaller** set. Had I reached the same conclusion myself by re-reading `FEE-XC-022`, it would have been **invalid** — a reviewer closing an Architecture Owner blocker by reinterpreting a requirement he wrote. **The conferral is the entire difference**, and it is why `ADR-0037` §2 states the objection against itself before answering it.

> ⛔ **What a reader must not take from this section.** Not that `PRD-008` may enter Stage 4 — **5 gaps block it**. Not that `PRD-008` may be frozen — **10 gaps block that**. Not that `FEE-GAP-002` is closed outright — **its Stage-4 limb is untouched**. Not that offline *attendance* changed — `E-24` and frozen `PRD-006` are **byte-unchanged**. And not that cash became unsupported — **physical cash may be collected offline; only the confirmed financial record must wait for the server**, exactly as `FEE-FR-061` already required.

---

## 12. Stage 3 verdict

✅ **ALIGNED — 6 of 6 checks PASS.** *(v1.2, EIGHTH PASS. Superseded verdict retained immediately below per the `ADR-0034` precedent, not overwritten.)*

> ⛔ **Superseded at v1.2, retained verbatim:** *"⛔ **NOT ALIGNED — 5 of 6 checks PASS; check 2 BLOCKED.**"* — the verdict of passes one through seven.
>
> **What changed, and what emphatically did not.** Check 2's last surviving blocker, `FEE-GAP-002`(c), is **CLOSED by `ADR-0037`** — `ACCEPTED` by conferral of **Product Owner** authority: cash payment is supported, financial recording **MUST remain online/server-authoritative**, and the app performs **no** offline financial write, queue, local financial ledger or later sync. **The limb is dissolved rather than answered**: it asked *through which declared edge `BC-05` queues an offline financial write*, and the decision denies that `BC-05` ever performs one. **No `BC-05` → `BC-30` edge and no `BC-32` were created**; `E-24` remains `BC-03` → `BC-30` only and the BC Map is byte-unchanged at `81518f1bb251218b`.
>
> **Stage 3 ALIGNED is NOT a freeze, NOT Stage 4 entry, and NOT a status change.** `PRD-008` remains **`DRAFT`** and remains **`PLANNED`** in `PRD_REGISTRY.md` — **`GCP-14` is preserved**. **5 gaps still block Stage 4** (`FEE-GAP-001`, `002`, `004`, `005`, `006`) and **10 still block Freeze**. `FEE-GAP-002`'s own `Stage 4` field is **deliberately left at `BLOCKS`**, because closing a gap for one gate does not close it for another and **no decision was given on its Stage-4 concerns**.
>
> **Why this is a pass and not a weakened gate.** Check 2 asks whether every integration edge is declared in BC Map §7. It failed because a **required** integration had no edge. It passes because **the integration is no longer required** — not because an edge was granted, and not because the check was relaxed. Every edge `BC-05` actually needs is declared: intent via `business.payment_intent`, execution by the Business Platform capability (`ADR-0035` `D-2`), gateway via `platform/integration:payment_gateway` → `BC-31`, inbound webhook via that same capability's return leg (`ADR-0035` §5.5b). **`BC-30` is not among them.** **No checker was modified to reach this verdict.**

| Check | Result | Change since the first pass |
|---|---|---|
| 1 — Context ownership exclusive | ✅ **PASS** | Unchanged; `BC-05`/`BC-20` re-confirmed under gateway pressure |
| 2 — Every integration edge in BC Map §7 | ✅ **PASS at v1.2** — `FEE-GAP-002`(c) **CLOSED** by `ADR-0037` (Product Owner). *Superseded: ⛔ **BLOCKED** — **`FEE-GAP-002`(c)** at v1.1, Architecture Owner; read `FEE-GAP-002`(b) from v0.7 to v1.0* | **Reason narrowed three times, and at v1.1 reduced from three causes to one.** Transport ✅ authorised (`D-1`, in force) · counterparty ✅ **declared and in force** (`D-2` = `O-3`) · inbound owner ✅ **declared** (`D-4`, `FEE-GAP-016` RESOLVED) · **offline financial capture ⛔ still undecided — and it alone blocks** |
| 3 — Rank direction downward | ✅ **PASS** | **Strengthened** — the port is a lawful rank 8 → 6 descent |
| 4 — No authorisation outside `BC-18` | ✅ **PASS** | Unchanged; no permission invented at v0.6 |
| 5 — No credential/OTP/session outside `BC-18` | ✅ **PASS** | Re-checked for gateway secrets — none |
| 6 — Tenant isolation | ✅ **PASS** | Unchanged, **with a standing re-review condition** (§7.2) |

**The single shortest path to ALIGNED — restated at v1.1, because the previous statement of it has been walked.**

> ⚠ **Superseded at v1.1, retained verbatim so the path already travelled stays visible:** *"The Architecture Owner
> must answer **one question**: which bounded context executes a student → library payment? `ADR-0035` §6 sets out
> three options and recommends none. Accepting `ADR-0035` `D-1` (transport) costs nothing and grants nothing new — it
> recognises an authorisation four ranked documents already give. **Deciding `D-2` (counterparty) is the whole of the
> remaining blocker.** Everything else in this record passes."*
>
> **All of that has now happened.** `D-1` is ratified, `D-2` is decided as `O-3` and in force, `D-4` is answered, and
> `ADR-0035` is `ACCEPTED`. **And the check still does not pass** — which is precisely why the old statement is left
> standing: it said *"the whole of the remaining blocker"*, and it was **wrong about that**, because
> `FEE-GAP-002`(c) was listed as a third reason at §3 the entire time. **The sentence over-promised, and being able
> to see that it did is worth more than a tidy record.**

**The shortest path to ALIGNED at v1.1 is exactly one question, and it is a different question:** *through which
declared architectural edge does `BC-05` queue an **offline** financial write?* `E-24` is `BC-03` → `BC-30`; edges
`BC-05` → `BC-30` = **0**. **Owner: Architecture Owner.** Tracked as **`FEE-GAP-002`(c)**.

**No decision on this was given at v1.1**, and this record does not guess one. Per the governing instruction, the
exact decision still required and its authority are recorded rather than invented:

| Decision still required | Authority | Why it cannot be settled here |
|---|---|---|
| Through which declared edge or port `BC-05` queues an **offline financial write**, and which context owns the offline capture/sync path | **Architecture Owner** | `E-24` is `BC-03` → `BC-30` only. Declaring a `BC-05` → `BC-30` route is a **boundary change**, and `ADR-INDEX` process step 1 requires an ADR **before** it. `ADR-0033` refused to invent an edge for exactly this kind of gap; **inventing one here would contradict an Accepted ADR** |

**Everything else in this record passes.**

**What must NOT be done to clear it:** add an `E-*` edge (unnecessary — §3.3; and precedentially refused —
`ADR-0033`), widen the Core-cluster allow-list, or route student money through `BC-20`'s existing gateway without
resolving `MP-GBR-24` (`AA-R7`).

> **This record confers no status.** `PRD-008` is `DRAFT`, remains `PLANNED` in `PRD_REGISTRY.md`, and is not
> architecture-approved. **Stage 4 is not started and must not be.** Stage 3 is passed when the gate's own
> condition is met, not when a document says so — and it is not met.

---

### 10.8 Rejected — this review's own v0.9 finding that renewal protection is forbidden *(added v1.0)*

| Field | Value |
|---|---|
| **The finding, as made at v0.9** | §39.2 of the PRD, written in this review's fifth pass, was titled *"what the frozen rules already **forbid**"* and concluded that 3-day renewal protection *"MUST NOT be implemented in V1"* and that a protected seat *"has no owning model"* |
| **Why it was rejected** | It read `MM-XC-012`, `MM-FR-100` and `MM-FR-111` as one prohibition. They are three different ones. **Money arithmetic** is V1-forbidden and **not needed**. **Entitlement extension** is V1-forbidden and **not conferred**. **Seat-release timing** is neither — it is `Q-01`, **open**, and frozen `PRD-005` **L820-823** says so in those words: `Q-01` *"is about **seat release** timing …, **not** about extending membership validity"* |
| **What proved it wrong** | Frozen `PRD-007` **L1166-1172**: that PRD is *"written to be correct under any resolution"* of `Q-01`, *"because the release action becomes a policy-driven trigger over an already-flagged allocation rather than a redesign."* And `SEAT-BR-024` **already retains** the allocation, so the *"no owning model"* premise was false — the model is `SeatAllocation`, unchanged |
| **How it was found** | By reading the surrounding prose rather than the identifier lines. The decisive evidence sits **900 lines** from the requirement, in `PRD-005` §24.3's *"Where my recommendation lost to an existing decision"* table — a location no grep for `MM-FR-111` would surface |
| **Disposition** | Corrected in the PRD at **v1.0**, with the superseded wording **quoted as evidence** rather than deleted. Recorded in full by **`ADR-0036`** (`PROPOSED`). **No gap closed, no count moved, no verdict changed** |

> **This is the second time this review has had to reject one of its own findings** — the first was the v0.8 blocker
> count retracted from *"stays at 5"* to **6**. Both errors ran in a self-flattering direction: the first made
> closing a question look free, the second made a hard product requirement look impossible, which is the more
> comfortable conclusion for a reviewer to reach. **Recording them in the *Rejected findings* section, alongside
> findings rejected from elsewhere, is deliberate.** A review that only rejects other people's conclusions is not
> auditing itself.

---

*End of `PRD-008_ARCHITECTURE_ALIGNMENT.md` — Stage 3 record for `PRD-008` v1.0 `DRAFT`, **sixth pass** at `01a6da8`. Not an approval. (This footer read *"v0.6 `DRAFT`, second pass at `3d98330`"* from v0.6 through v0.8 — a stale footer carried across three revisions, corrected at v0.9.)*
