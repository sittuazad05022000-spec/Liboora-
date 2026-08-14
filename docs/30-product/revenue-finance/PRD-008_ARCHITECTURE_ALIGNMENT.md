# `PRD-008` Revenue & Finance v0.6 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 3) |
| **Subject** | [`PRD-008_REVENUE-AND-FINANCE.md`](PRD-008_REVENUE-AND-FINANCE.md) — `PRD-008`, `BC-05` Fee & Collection, **v0.6 `DRAFT`** |
| **Gate addressed by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) · [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Reviewed at** | `3d98330` — **second pass**. The first pass was written at `61e6950` against v0.5 and its check-2 reasoning is **superseded in part** by §3 and §10 below |
| **PRD hash at review** | `d6bb63d9ec83927bd21596fc0e7cabf8e24e1716a803af8bb0679da61b3664c8` — re-measured at v0.6, 2,316 lines *(prior record cited `3f91476a…` at v0.5; that hash is now stale and is retained only in the change note)* |
| **Companion ADR** | [`ADR-0035`](../../00-governance/adr/ADR-0035-bc-05-payment-gateway-path.md) — **`PROPOSED`, not accepted.** Binds nothing |
| **Mandate** | **Stage 3 only.** No PRD requirement added or changed by this record, **no ADR accepted**, no ranked document touched, no registry or baseline update, **no freeze**. Stages 4–7 not started |
| **Verdict** | ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 check BLOCKED.** Check 2 remains **BLOCKED**, but for a **narrower and now precisely-named reason** than the first pass gave: the *transport* by which `BC-05` may reach gateway capability is **already authorised** and needs no edge; the *counterparty* — which bounded context executes a **student → library** payment — is **undeclared**. 0 conflicts created by this PRD · **4** pre-existing defects raised, not chosen (§9.1) · 15 gaps, **4** blocking (§9.3) · **7** findings rejected with reasons, **1 of them superseding a prior rejection** (§10) |

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
> **`ADR-0035` therefore stays `PROPOSED` and check 2 stays ⛔ BLOCKED.** The decision is now materially
> smaller — *"confirm `O-3`, and name an owner for webhook ingress"* — but it is still a decision, and Stage 3
> alignment is not the act that takes it.

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

### 3.9 Result — ⛔ **BLOCKED**

Nine declared edges verified present. The gateway *transport* is **authorised and requires no edge** (§3.3–3.4).
The gateway *counterparty* is **undeclared** (§3.5), and Rank 1 bars the obvious candidate.
Online payment execution, server-side verification and reconciliation therefore **still cannot be specified**.
Offline financial capture via `BC-30` remains **wholly** unresolved — `E-24` is `BC-03` → `BC-30` only.

**Owner: Architecture Owner.** Tracked as **`FEE-GAP-002`**, now recorded in the PRD as
**`PARTLY RESOLVED`** — *(a) transport CLOSED by measurement · (b) counterparty OPEN and BLOCKING ·
(c) offline-sync path OPEN.*

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

### 9.3 Gaps — 15, with Stage 3 impact stated individually

| Gap | Blocks Stage 3? | Class | Owner |
|---|---|---|---|
| **`FEE-GAP-002`** — gateway path | **(a) transport — NO, closed by measurement** · **(b) counterparty — YES, the sole cause of NOT ALIGNED** · (c) offline sync — no | **A / D / C** | **Architecture Owner** |
| `FEE-GAP-001` — refund V1/V2 | No — a tier question, raised as `AA-C1` | E + D | Product Owner + Architecture Owner |
| `FEE-GAP-004`, `005`, `006` | No — requirement-level, Stage 4 concerns | E | Product Owner |
| `FEE-GAP-003`, `007`, `008`, `009`, `010`, `011`, `012` | No | C | Named per gap in §37 |
| `FEE-GAP-013` — renewal protection | No — `BC-05` owns none of the blocked parts | C + E | Product Owner, `BC-02`/`BC-06`, Architecture, Security |
| `FEE-GAP-014` — commission has no owning document | No — it is `BC-20`'s subject | C | `BC-20` owner / Architecture Owner |
| `FEE-GAP-015` — permission + parameter row | No — role question **CLOSED** by `PR-1`; remainder is outside `BC-05` | C | `BC-18`/`PRD-001`, `BC-25`/`PRD-023` |

**Standing condition (not a gap):** when `FEE-GAP-002`(b) is resolved, **tenant isolation across the payment rail
must be re-reviewed** (§7.2). This record can pass check 6 on what exists; it cannot pre-approve what does not.

**No gap is resolved into non-existence by this record, and none is invented.** `FEE-GAP-002` moved from OPEN to
**PARTLY RESOLVED** *by measurement of existing authority*, not by grant, and its blocking half is untouched.

---

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

---

## 12. Stage 3 verdict

⛔ **NOT ALIGNED — 5 of 6 checks PASS; check 2 BLOCKED.**

| Check | Result | Change since the first pass |
|---|---|---|
| 1 — Context ownership exclusive | ✅ **PASS** | Unchanged; `BC-05`/`BC-20` re-confirmed under gateway pressure |
| 2 — Every integration edge in BC Map §7 | ⛔ **BLOCKED** — `FEE-GAP-002`(b), Architecture Owner | **Reason narrowed and corrected.** Transport ✅ authorised; **counterparty ⛔ undeclared** |
| 3 — Rank direction downward | ✅ **PASS** | **Strengthened** — the port is a lawful rank 8 → 6 descent |
| 4 — No authorisation outside `BC-18` | ✅ **PASS** | Unchanged; no permission invented at v0.6 |
| 5 — No credential/OTP/session outside `BC-18` | ✅ **PASS** | Re-checked for gateway secrets — none |
| 6 — Tenant isolation | ✅ **PASS** | Unchanged, **with a standing re-review condition** (§7.2) |

**The single shortest path to ALIGNED — now stated exactly, where the first pass could only gesture at it.**
The Architecture Owner must answer **one question**: *which bounded context executes a student → library payment?*
`ADR-0035` §6 sets out three options and recommends none. Accepting `ADR-0035` `D-1` (transport) costs nothing
and grants nothing new — it recognises an authorisation four ranked documents already give. **Deciding `D-2`
(counterparty) is the whole of the remaining blocker.** Everything else in this record passes.

**What must NOT be done to clear it:** add an `E-*` edge (unnecessary — §3.3; and precedentially refused —
`ADR-0033`), widen the Core-cluster allow-list, or route student money through `BC-20`'s existing gateway without
resolving `MP-GBR-24` (`AA-R7`).

> **This record confers no status.** `PRD-008` is `DRAFT`, remains `PLANNED` in `PRD_REGISTRY.md`, and is not
> architecture-approved. **Stage 4 is not started and must not be.** Stage 3 is passed when the gate's own
> condition is met, not when a document says so — and it is not met.

---

*End of `PRD-008_ARCHITECTURE_ALIGNMENT.md` — Stage 3 record for `PRD-008` v0.6 `DRAFT`, second pass at `3d98330`. Not an approval.*
