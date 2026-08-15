# ADR-0035 — How `BC-05` reaches a payment gateway: the transport is already authorised; the counterparty is not

| Field | Value |
|---|---|
| **Status** | **PROPOSED** — *"Recorded, not in force"* (`ADR-INDEX.md` status vocabulary). **This ADR is not self-accepted.** It records a finding and asks one question of the **Architecture Owner**. Nothing below binds any implementation until that authority rules — see **§7** |
| **Date** | 2026-08-05 |
| **Raised by** | Stage 3 re-review of `PRD-008` Revenue & Finance — blocker `FEE-GAP-002`, recorded in [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](../../30-product/revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md) §3 |
| **Decision by** | **Architecture Owner** (`PRD_OWNERSHIP_MODEL.md` §2.2) — **not yet given** |
| **Supersedes / amends** | **Nothing.** No ranked document is amended by this ADR. **No edge is added. No allow-list is widened. No bounded context is created. No aggregate, contract, webhook schema, endpoint or table is defined.** The one corrective act it *recommends* (§5.3) is to a **Rank 5 derived, explicitly non-normative** document |
| **Governs** | `BC-05` → payment gateway transport · the `business.payment_intent` port · **student-payment execution ownership (`D-2`)** · `D-14` · `FEE-GAP-002` |

> **The question splits in two, and that is the whole finding.** Previous reviews asked *"does `BC-05` have a path
> to the gateway?"* as a single question and answered **no**, because they searched for a numbered `E-` edge and
> found none. Measured properly, the question is two questions with **two different answers**:
>
> | | Question | Answer |
> |---|---|---|
> | **(a) Transport** | By what lawful route may `BC-05` reach a gateway? | ✅ **Already authorised.** The `business.payment_intent` port. No new edge, no new permission, nothing to approve |
> | **(b) Counterparty** | Which bounded context *executes* a **student → library** payment at the far end of that port? | ⛔ **Undeclared.** No context in the repository owns it, and `MP-GBR-24` forbids the obvious candidate |
>
> **So `FEE-GAP-002` is neither resolvable by fiat nor wholly blocked. Half of it dissolves on measurement; the
> other half is a real, narrow question for the Architecture Owner.** Reporting only the first half would make
> `PRD-008` look complete. Reporting only the second would keep a resolved question artificially open.

---

## 1. The question

`PRD-008` must specify online fee payment. Stage 3's second check is *"every integration edge exists in BC Map §7"*,
whose stated failure mode is *"if an edge is not in this table, it does not exist and adding it requires an ADR."*

**Measured at `3d98330`:**

| Measurement | Result |
|---|---|
| Edges `BC-05` → `BC-31` Integration | **0** |
| Edges `BC-05` → `BC-20` Billing | **0** |
| Edges `BC-05` → `BC-30` Offline Sync | **0** |
| `BC-05`'s complete edge set | `E-06`, `E-07`, `E-09`, `E-10` (+ the "all contexts" edges `E-17`, `E-18`, `E-19`, `E-20`, `E-23`) |
| `E-25` (BC Map **L334**) | `BC-20 Billing → BC-31 Integration` — **source is `BC-20`, not `BC-05`** |

On that evidence alone the honest conclusion is *"blocked."* **It is the wrong conclusion, because it asks only
whether an `E-` edge exists, and an `E-` edge is not the only lawful way one module depends on another in this
repository.**

---

## 2. (a) The transport is already authorised — four independent Rank 1/2/4 sources

### 2.1 The Rank 4 Dependency Matrix declares the port, in its own normative section

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` §6 is introduced by the document itself as the binding form:

> *"The matrix is the human-readable form. **This section is the normative form — what the lint rule checks.**
> Anything not listed is forbidden."*

Inside that section, `library_management`'s `may_use_ports` list (**L196**) contains, verbatim:

```
    - business.payment_intent     # money rails
```

**`BC-05` is a `library_management` context** (BC Map L100: Owning Platform = *Library Management*; manifest
`contexts: [enrollment, membership, attendance, seating, fee, policy]`). **The port is therefore already declared
for the module that owns `BC-05`, in the section the Matrix calls normative.** Nothing needs to be added.

### 2.2 The same Rank 4 document forbids the wrong route and *names* this one

**L167**, in the section *"How to read three important cells"*:

> `LIBRARY MANAGEMENT` → `INTEGRATION` = `✖` — *"The domain must not know that Razorpay, Twilio or FCM exist. It
> emits facts and calls ports. **Integration is reached only via BUSINESS (payments)** or COMMUNICATION (messaging)."*

And **L352**, violation `X-03`, gives the remedy as a direct instruction:

| `X-03` | `domain → INTEGRATION` | *"Just call Razorpay from the payment service"* | Vendor lock-in inside the core domain | **Remedy: "Call `business.payment_intent` port"** |

**The Rank 4 document does not merely permit this route. It prohibits every alternative and prescribes this one by
name.** A PRD that used any other path would be violating `X-03`; a PRD that uses this one is doing exactly what
the Matrix instructs.

### 2.3 The matrix cell agrees — proven mechanically, not read by eye

The matrix is fixed-width ASCII, so a mis-count would be easy and invisible. Column alignment was therefore
verified programmatically rather than by inspection — **19 data cells against 19 column headers, exact match** on
both rows:

| Row → Column | Value | Meaning |
|---|---|---|
| `LIBRARY MANAGEMENT` → `INT` | `✖` | forbidden — consistent with L167 |
| **`LIBRARY MANAGEMENT` → `BUS`** | **`◇`** | **port, no import — PERMITTED** |
| `BUSINESS` → `INT` | `◇` | port — Business may reach Integration |

**The two-hop route `LIBRARY MANAGEMENT → BUSINESS → INTEGRATION` is permitted at every hop, and the one-hop
shortcut is forbidden. That is a deliberate design, not an accident of omission.**

### 2.4 An Accepted ADR already treats this exact port as a settled dependency

`ADR-0012` (**Accepted**, Rank 2) tabulates the scaffold's real dependency edges. **L86**:

| Consumer | Provider | Ranks | Sites | Already a declared port? |
|---|---|---|---|---|
| `domain/library` | `platform/business` | 8 → 6 | 2 | **Yes — `:entitlement`, `:payment_intent`** |

`ADR-0012` classifies `domain/library` → `platform/business` as an edge whose **direction is correct and whose port
is already declared** — its only complaint is that the interface was never *extracted* in code. **An Accepted ADR
has already reasoned about this dependency and found the architecture, not the dependency, to be sound.**

### 2.5 Rank 1 names the same shape

`MASTER_PRD.md` **L232**: `| Payments | `BC-20` via `BC-31` | Payment Gateway Abstraction | Gateway | Not named in EA |`.
**Rank 1 confirms that reaching a gateway goes *through* an intermediary and never direct** — the shape §2.2
prescribes. *(It also names `BC-20` as that intermediary, which is precisely the problem in §3.)*

---

## 3. (b) The counterparty is genuinely undeclared — and `MP-GBR-24` blocks the obvious answer

**The port has an approved caller and no declared callee.** Measured:

| Question | Measurement |
|---|---|
| Which contexts sit in `platform/business`? | **Exactly two** — `BC-20` Subscription & Billing, `BC-21` Entitlement (BC Map L129–L130) |
| What does `BC-20` own? | *"Money owed by a **library to LIBOORA**: plans, subscriptions, invoices, gateway, dunning, revenue recognition"* (L129) |
| What does `BC-21` own? | *"Is tenant T allowed to do X, and how much of it is left?"* — limits and gates (L130) |
| Does any context own a student-payment execution aggregate? | **No.** `grep -rn "PaymentIntent" docs/` → **0 occurrences repository-wide** |
| Is `payment_intent` named anywhere in the Rank 4 BC Map? | **No.** `grep -c "payment_intent"` → **0** |

### 3.1 Why `BC-20` cannot simply be the answer

`MP-GBR-24` (**Rank 1**, `MASTER_PRD.md` L362):

> *"Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by a **library to
> LIBOORA** (`BC-20`). **They must never share a model, a table or a metric.**"*

Reinforced by the Rank 4 ubiquitous-language table (**L202**): *"`FeePayment` (BC-05) **vs** `SubscriptionCharge`
(BC-20)"* — and `ADR-0015` (Accepted) exists **solely** because three rows once collapsed these two finance
contexts into one range, which it calls *"not merely wrong — it erases a distinction the map treats as
load-bearing."*

**So routing a student fee payment into `BC-20` would violate a Rank 1 global business rule and re-commit the exact
error an Accepted ADR was written to correct.** This ADR does **not** propose it.

> ⚠ **A tension inside Rank 1 is disclosed rather than resolved.** `MASTER_PRD.md` L232 routes *"Payments"* through
> `BC-20`, while `MP-GBR-24` at L362 forbids `BC-20` from touching student money. If L232 is read as covering
> **student** payments the two Rank 1 statements contradict each other; if it covers only **SaaS** payments —
> consistent with `MP-DEP-04`'s *"SaaS Billing, fee collection"* pairing — they agree and the student-payment
> counterparty is simply **unassigned**. **This ADR does not choose between those readings.** Per
> `DOCUMENTATION_BASELINE.md` §4, *"a conflict is a defect — do not choose, raise it."* It is raised here and in
> the alignment record as the substance of the Architecture Owner's decision.

### 3.2 The four concepts separated, and measured one at a time *(added by the `D-2` investigation)*

`FEE-GAP-002` was previously argued as a single ownership question. It is **four**, and they do **not** all resolve
to the same place. Each row below is measured, with the rank of the source that settles it.

| # | Concept | Owner | Rank | Authoritative evidence |
|---|---|---|---|---|
| **1** | **Payment intent** — deciding that a student owes money and that a payment should be attempted | **`BC-05`** | 3, 4 | BC Map **L100**: `BC-05` *"owns money owed by a **student to the library**: fee structures, dues, receipts, discounts, refunds, cash reconciliation"*. Frozen `PRD-005` **L164** places *"payment transaction, gateway, ledger, receipt, refund, reconciliation"* outside `BC-02` and with *"`BC-05` / Business Platform"*. EA **L74** describes library payments as *"**domain intent** over Business Platform rails"* |
| **2** | **Payment execution** — interacting with the money rail | ⛔ **UNDECLARED at context level.** Declared at **module** level as `platform/business` | — | See §3.3. No bounded context declares it; the module manifest declares the onward hop but names no implementer |
| **3** | **Gateway integration** — vendor protocol, credentials, retries | **`BC-31`** | 4 | BC Map **L140**: *"Owns **outbound** third-party contracts, credentials, retries, idempotent delivery"*. Reached from `platform/business` by the manifest-declared port at `tool/module_dependencies.yaml` **L409** — `ports: [platform/integration:payment_gateway]`. **Never reached by `BC-05` directly** (Matrix L167 `✖`, `X-03` L352) |
| **4** | **Payment verification** — server-side confirmation that money actually moved | **`BC-05`** *(the rule)* / ⛔ **undeclared** *(the mechanism)* | 1, 3 | `MP-GBR-18` (**Rank 1**): *"Payment capture is idempotent by gateway reference."* Frozen `MM-BR-005` (**Rank 3**): *"**Enforcement of the payment side is `BC-05`'s**."* `BC-05` therefore owns the **obligation**; but the *mechanism* — what a gateway response is verified **against** — cannot be specified while row 2 is open |
| **5** | **Student financial truth** — the confirmed, auditable record | **`BC-05`, exclusively** | 1, 4 | BC Map **L374**: the `FeeLedger` aggregate — *"balance = Σ dues − Σ receipts (never stored independently); receipt is immutable once issued"*. `MP-GBR-24` (**Rank 1**) bars `BC-20`. Ubiquitous-language table **L202**: `FeePayment` (BC-05) **vs** `SubscriptionCharge` (BC-20) |
| **6** | **Webhook / reconciliation ingress** — receiving and reconciling the rail's asynchronous callback | ⛔ **NO OWNER EXISTS** | — | See §3.4. This is a **wider** gap than `D-2` as originally stated |

**Row 5 is the load-bearing one, and it is not in doubt.** Whatever executes the rail, the *financial truth* stays
in `BC-05`. That is what `MP-GBR-24` protects, and no option in §6 disturbs it.

### 3.3 Row 2 — what *is* declared, measured in the machine-checked source

The module manifest `tool/module_dependencies.yaml` is not prose; it is the file
`tool/check_module_boundaries.dart` actually reads. Measured at HEAD:

| Measurement | Result |
|---|---|
| `platform/business` rank | **6** (L406) |
| `platform/business` declared ports | **`[platform/integration:payment_gateway]`** (L409) — **the second hop is declared** |
| Does the manifest schema express *who implements* a port? | **Yes** — the key is `provides_ports:` |
| Which modules use `provides_ports:`? | **Exactly two** — `domain/person` (L188) and `platform/identity` (L442) |
| Does `platform/business` declare `provides_ports:`? | **No** — measured `0` occurrences in its block (L405–L416) |

**This is the decisive negative measurement.** The manifest *can* name an implementer — `platform/identity` names
five, with consumer lists and constraints. `platform/business` names none. So the callee is undeclared **in the
machine-checked source as well as in the prose**, and its absence is a real gap rather than an artefact of reading
the wrong document.

**What this does settle:** the *chain* is complete at module level. `domain/library` → `platform/business`
(L119, declared port) → `platform/integration` (L409, declared port) → vendor. Every hop is authorised. **No edge is
missing anywhere along it.** What is missing is a **named owner** for the middle hop's behaviour.

### 3.4 Row 6 — webhook ingress has no owner anywhere in the map, and this is new

| Measurement | Result |
|---|---|
| `grep -c "webhook\|Webhook"` in the Rank 4 BC Map | **0** |
| `grep -c "inbound"` in the Rank 4 BC Map | **0** |
| What `BC-31` owns, verbatim (L140) | *"Owns **outbound** third-party contracts…"* |
| Where the EA puts inbound adapters (L165) | *"Integration Platform = **outbound** adapters, **API Platform = inbound adapters**"* |
| Does `API Platform` have a `BC-` identifier? | **No.** It appears in the BC Map only as a diagram band (L223) and as the single Open Host Service (L358). It is **not** one of the 31 contexts |

**A webhook is inbound.** `BC-31` is defined as outbound-only, so it does not own webhook receipt by its own
definition; and the component the EA nominates for inbound adapters is not a bounded context at all. The EA lists
*"Webhook Reconciliation (V1)"* at **L1407** under `Payment Gateway`, but the EA is marked in
`DOCUMENTATION_BASELINE.md` L139 as **"Descriptive — must follow the PRDs, never lead them"**, so it records an
intention and **cannot confer ownership**.

> **This finding widens `D-2` rather than closing it.** The original question asked who *executes*. Measured, the
> asynchronous *return path* has no owner either — and it is the path on which financial truth actually depends,
> because `FEE-BR-014` already holds that client-side success is never financial truth. The Architecture Owner's
> decision must name an owner for **both**.

---

## 4. Why the absence of a numbered edge is not, by itself, a defect

This is the reasoning previous reviews were missing, and it is **not novel** — it is an Accepted ADR's ratio.

### 4.1 `ADR-0033` (Accepted) settled what BC Map L292 governs

> *"**What BC Map L292 does and does not say.** It says: 'Every edge that crosses a context boundary in V1. If an
> edge is not in this table, it does not exist and adding it requires an ADR.' **It governs edges.** It does **not**
> state that every cross-context read must be an edge — and `SEAT-FR-104` proves the map is not read that way,
> since a frozen requirement performs a `BC-01` read that the table does not list."*

`ADR-0033` **withdrew** `E-27` rather than allow-listing it, on the finding that *"read-time composition across a
boundary is an **already-ratified pattern that needs no numbered edge**."* Frozen Rank 3 `PRD-007` §3 records three
further no-edge consumptions (`BC-10`, `BC-05`, `BC-18`) on the same footing.

### 4.2 Measured: 14 of `library_management`'s 17 declared ports have no usable numbered edge

If a declared port required a numbered edge, the model would already be broken in fourteen places:

| Declared port | Numbered edge? |
|---|---|
| `shared_core.tenant_context`, `configuration.settings`, `business.entitlement` | ✅ `E-18`, `E-19`, `E-17` — the three "all contexts / all write paths" edges |
| `identity.policy_decision`, `ai.assist`, `analytics.read_model`, `workflow.process_trigger`, `data.repository`, `security.crypto`, `observability.telemetry`, `platform_services.{qr,idempotency,time}` | ❌ **none** |
| `platform_services.files` | ❌ `E-22` exists but lists consumers `BC-01`, `BC-10`, `BC-14` — **`BC-05` is not among them** |
| `search.indexer` | ❌ `E-21` lists `BC-01`, `BC-10` — **`BC-05` is not among them** |
| `platform_services.offline_sync` | ❌ `E-24` is `BC-03` → `BC-30` **only** |
| **`business.payment_intent`** | ❌ **none** |

**3 of 17 have a usable edge; 14 do not.** Requiring one for `business.payment_intent` would, applied consistently,
invalidate thirteen other lawful dependencies — including `identity.policy_decision`, the authorisation port every
context must call. **The rule cannot mean that, and `ADR-0033` already held that it does not.**

---

## 5. Decision proposed

### 5.1 `D-1` — The `business.payment_intent` port is the authorised transport, and needs no numbered edge

`BC-05` reaches payment-gateway capability **exclusively** through the `business.payment_intent` port declared at
Dependency Matrix L196 and prescribed by `X-03` L352. This is an **existing** authorisation being *recognised*, not
a new one being granted. **No `E-*` edge is created. No allow-list is widened. `LIBOORA_BOUNDED_CONTEXT_MAP.md` and
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` are NOT amended.**

`BC-05` continues to be forbidden from: naming a vendor, holding a gateway credential, calling `BC-31` directly, or
knowing any gateway protocol detail (`X-03`, Matrix L167, `FEE-XC-005`, `FEE-XC-006`).

### 5.2 `D-2` — **DECIDED: `O-3`. Payment Execution is a Business Platform capability, not a new bounded context**

**Decision (Architecture Owner, acting as ARB).** **Student → library payment execution is a capability of the
Business Platform (`platform/business`, rank 6). It is NOT a bounded context, it receives NO `BC-` identifier, and
the context count remains 31.**

`PRD_OWNERSHIP_MODEL.md` §2.2 vests *"boundaries, ranks, permitted edges, precedence"* and *"ADR approval; any
Rank 1–5 document change"* in the **Architecture Owner**, convening as the **Architecture Review Board** — the same
authority that decided `ADR-0012`, `ADR-0013` and `ADR-0033`. `D-2` is squarely a boundary question, so it is
within that authority and no other.

**This selects `O-3` from §6 and rejects `O-1` and `O-2`.** The three were presented without recommendation in the
investigation phase; they are now decided, on the evidence below.

#### 5.2.1 Why `O-3` is admissible — the `AR-1` test, applied and passed

`AR-1` (Rank 4, authoritative, recorded at BC Map **L558** and applied at **L86**) is the architecture's own test
for whether a capability needs a bounded context. A capability is **not** a context when it *"owns **no aggregate,
no invariant and no business state**"* and *"delegates every domain operation to the owning module."* Applied here,
measured rather than asserted:

| `AR-1` criterion | Payment execution | Evidence |
|---|---|---|
| Owns an **aggregate**? | **No** — the aggregate is `FeeLedger`, and it is `BC-05`'s | BC Map **L374**: `BC-05` owns `FeeLedger` with `FeeDue`, `Receipt`, `Discount`, `RefundRecord`, `Money` |
| Owns an **invariant**? | **No** — the payment invariants are `BC-05`'s | `FEE-INV-005` (no two confirmed payments share an idempotency key or a gateway reference) · `FEE-BR-016` · frozen `MM-BR-005`: *"**Enforcement of the payment side is `BC-05`'s**"* |
| Owns **business state**? | **No** — confirmed financial truth is `BC-05`'s, exclusively | BC Map **L374** · `MP-GBR-24` · L202 (`FeePayment` vs `SubscriptionCharge`) |
| **Delegates** every domain operation? | **Yes** | Intent from `BC-05` (§3.2 row 1); vendor protocol to `BC-31` (BC Map L140); confirmation back to `BC-05` (row 4) |

**All four criteria are satisfied.** Payment execution is a *rail*: it moves money and returns a result. It decides
nothing, remembers nothing, and owns no record. **On the architecture's own test it is precisely the kind of thing
that must NOT be a bounded context.**

Precedent is exact, not analogical. BC Map **L86** records that Library Discovery & Enrollment *"is likewise **not**
a context … No `BC-` identifier is assigned; the context count remains 31."* `PRD_REGISTRY.md` **L355** applied the
same test to the Library Member Directory and recorded *"**no `BC-32` was created** and the context count remains
**31**."* **This decision is the third application of a settled rule, not a new rule.**

#### 5.2.2 Why the Business Platform is the right home

| Source | Rank | What it says |
|---|---|---|
| Dependency Matrix **L167** | 4 | `LIBRARY MANAGEMENT → INTEGRATION` = `✖`; *"Integration is reached **only via BUSINESS (payments)** or COMMUNICATION (messaging)"* |
| Dependency Matrix **L196**, `X-03` **L352** | 4 | `business.payment_intent` declared in `library_management`'s `may_use_ports`; the remedy names it: *"Call `business.payment_intent` port"* |
| Frozen `PRD-005` **L164** | 3 | *"Payment transaction, gateway, ledger, receipt, refund, reconciliation"* → *"`BC-05` / **Business Platform**"* — the **platform**, not `BC-20` |
| EA **L122** | descriptive | Resolves the same duplication to *"**BUSINESS PLATFORM** (money movement) / Library (fee **domain intent**)"* — again naming no context |
| EA **L74** | descriptive | Library payments are *"**domain intent** over Business Platform **rails**"* |
| `tool/module_dependencies.yaml` **L409** | machine-checked | `platform/business` already declares `ports: [platform/integration:payment_gateway]` — **the onward hop exists** |

Four ranked sources put money movement in the **Business Platform**; none puts it in a context. The two descriptive
EA rows are used here only as **corroboration**, never as authority — `DOCUMENTATION_BASELINE.md` **L139** marks the
EA *"Descriptive — must follow the PRDs, never lead them."*

**`ADR-0013` is cited with an explicit limit.** Its ratio — *"a capability context is owned by the platform module
that implements it"* — was decided for capabilities that **already had** a `BC-` identifier (`BC-19`, `BC-25`,
`BC-29`). Measured, it never contemplates a capability with **no** context: `grep -i "no bounded context|owns no
aggregate"` over `ADR-0013` returns **0**. It is therefore **adjacent precedent for platform-level ownership, and
not the authority for BC-less-ness.** That authority is `AR-1`, applied in §5.2.1. Recording this limit matters: a
future reader must not think `ADR-0013` decided more than it did.

#### 5.2.3 What this decision does NOT do

- It creates **no bounded context** and assigns **no `BC-` identifier**. Count stays **31**.
- It creates **no numbered dependency edge**. The lawful path is the already-declared port chain (§5.4).
- It makes **no change** to `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` or `LIBOORA_BOUNDED_CONTEXT_MAP.md`.
- It moves **no aggregate, no invariant and no requirement**. `FeeLedger` stays in `BC-05`.
- It gives `BC-20` **no role whatsoever** in student → library money (§5.2.4).
- It defines **no endpoint, schema, webhook payload, vendor contract, permission ID or configuration identifier**.
- It does **not** resolve webhook **ingress ownership** — that remains open as `FEE-GAP-016` (§5.5).

#### 5.2.4 Why `BC-20` is NOT the executor — `O-2` rejected

`MP-GBR-24` (**Rank 1**, `MASTER_PRD.md` L362) is binding: student→library money and library→LIBOORA money
*"**must never share a model, a table or a metric.**"* `BC-20` is defined as *"money owed by a **library to
LIBOORA**"* (BC Map L129). Making it the executor of a **student's** fee payment would put both financial domains in
one context — the exact conflation Accepted **`ADR-0015`** exists to correct, which it called *"not merely wrong — it
erases a distinction the map treats as **load-bearing**."*

This is no longer only a prose rule. The rank-0 shared kernel `packages/liboora_contracts` carries `banned_symbols`
including `class Payment ` with the message *"FeePayment (BC-05) or SubscriptionCharge (BC-20)"* — so
`tool/check_module_boundaries.dart` **mechanically enforces** the split. `O-2` is refused.

> **The Rank 1 tension of §3.6 is resolved by scope, not by overriding either statement.** `MASTER_PRD.md` L232
> sits in **§10 Technology Stack**, whose subject its own preamble states is *"**capabilities with abstractions**,
> with **vendors** recorded as candidate implementations behind ports"* — its columns are *Capability · Architectural
> owner · Abstraction · Candidate implementation · Approved in EA?*. It is a **vendor-abstraction** table, and its
> `Payments` row concerns which **SaaS** billing path reaches a gateway. `MP-GBR-24` governs the **financial model**.
> Read to their own declared scopes the two do not collide, and **neither is amended, weakened or reinterpreted by
> this decision.** No Rank 1 document is modified.

#### 5.2.5 Why `BC-32` MUST NOT be created — `O-1` rejected

`O-1` fails at the first `AR-1` criterion: a new context must own an aggregate, an invariant or business state, and
payment execution owns **none** (§5.2.1) — rows 4 and 5 of §3.2 keep both in `BC-05`. Creating `BC-32` would
therefore either (a) be an empty context, which `AR-1` forbids, or (b) require **moving `FeeLedger` out of `BC-05`**,
which `MP-GBR-24` and BC Map L374 forbid. Both branches are barred.

It would also contradict the standing instruction — the map *"has held **31** contexts since inception"* and
prefers *"a smaller number of clear bounded contexts over unnecessary fragmentation"* — and would break the
precedent of `PRD_REGISTRY.md` L355, which refused a `BC-32` on this same test. **`O-1` is refused. Should new
evidence ever show payment execution owning an aggregate or an invariant of its own, `O-1` may be reopened; on the
evidence measured at this HEAD it does not.**

### 5.3 The ownership table, in force on acceptance

Every row carries its authority. **Rows marked ⛔ are NOT decided by this ADR.**

| Responsibility | Owner | Authority |
|---|---|---|
| **Payment Intent** | **`BC-05`** | BC Map **L100** · frozen `PRD-005` **L164** · EA L74 (*"domain intent"*) |
| **Payment Financial Truth** | **`BC-05`**, exclusively | BC Map **L374** (`FeeLedger`) · `MP-GBR-24` (Rank 1) · L202 |
| **Payment Verification** | **`BC-05`** | `MP-GBR-18` (Rank 1) · frozen `MM-BR-005` (Rank 3) · `FEE-INV-005` · `FEE-BR-016` |
| **Payment Execution** | **Business Platform capability** — `platform/business`, rank 6. **No `BC-` id** | **§5.2** (this decision) · `AR-1` test passed · Matrix L167/L196 · `X-03` L352 · frozen `PRD-005` L164 |
| **Gateway Integration** | **`BC-31`** | BC Map **L140** · manifest **L409** |
| **External Gateway Contract** | **`BC-31`** | BC Map **L140** (*"outbound third-party contracts, credentials, retries"*) |
| **Inbound Webhook Transport** | ⛔ **UNDECLARED** — must be an authorised `platform/integration` capability, owner not yet named | **`FEE-GAP-016`**, §5.5. BC Map has **0** `webhook`, **0** `inbound`; `BC-31` is outbound-only |
| **Webhook Interpretation** | **`BC-05`** verification boundary | `FEE-BR-014` · `FEE-INV-005` · `FEE-BR-016` · frozen `MM-BR-005` |
| **Platform Commission** | **`BC-20`** | `MP-GBR-24` · BC Map **L129** · `FEE-GAP-014` · `FEE-XC-001`/`FEE-XC-002` |
| **Library → LIBOORA Settlement** | **`BC-20`** | `MP-GBR-24` · BC Map **L129** · `FEE-GAP-014` |
| **Student → Library Money** | **`BC-05`**, exclusively | `MP-GBR-24` (Rank 1) · BC Map **L100**/**L374** · L202 |

**The two money domains never meet.** Rows 1–3, 8 and 11 are `BC-05`. Rows 9–10 are `BC-20`. **No row is shared, and
no model, table or metric spans them** — `MP-GBR-24` is preserved structurally, not merely asserted.

### 5.3.1 Six concepts, held apart deliberately

The blocker persisted for as long as these were treated as one thing. They are six, with **five different owners**:

| Concept | Question it answers | Owner | May it write `FeeLedger`? |
|---|---|---|---|
| **Transport** | *By what lawful route does a request travel?* | The declared **ports** — `business.payment_intent`, then `platform/integration:payment_gateway` | **No.** A route is not an actor |
| **Execution** | *Who interacts with the money rail?* | **Business Platform capability** (§5.2) | **No.** Owns no aggregate — that is why it needs no context |
| **Verification** | *Did money actually move, proven server-side?* | **`BC-05`** | **Yes** — this is the only gate through which truth enters |
| **Financial truth** | *What does the library's record say is owed and paid?* | **`BC-05`** (`FeeLedger`) | **It is** the truth |
| **Settlement** | *What does the library owe LIBOORA?* | **`BC-20`** | **Never.** Different domain (`MP-GBR-24`) |
| **Webhook reconciliation** | *Who receives the rail's asynchronous callback, and who believes it?* | Receipt ⛔ **undeclared** (`FEE-GAP-016`) · interpretation **`BC-05`** | **Not directly.** Only via verification |

**The load-bearing separation is execution ≠ verification.** Executing a payment is an *attempt*; verifying it is a
*finding*. Keeping them apart is what lets execution be a context-less rail while financial truth stays sovereign in
`BC-05` — and it is why a webhook, which is transport, can never write a receipt.

### 5.3.2 Cash — unchanged, and confirmed against this decision

Cash never touches a rail, so the execution capability is **not** involved. `FEE-FR-061` and `FEE-XC-022` already
require server-side recording with **no offline financial write** of any kind, consistent with `E-24` granting
offline sync to `BC-03` **only**. This decision **adds nothing and relaxes nothing** here.

**Staff recording cash ≠ LIBOORA receiving money.** That gap is a `BC-20` settlement obligation, and it stays
outside `BC-05`'s model: `FEE-FR-060` deliberately carries **no commission, gateway or tax field**, because adding
one would perform the `MP-GBR-24` merger in the schema, where it would actually bite. **The settlement mechanism is
not invented here** — it remains `FEE-GAP-014`, routed to `BC-20`.

### 5.4 The lawful path — no new edge is created

The route was already fully authorised at every hop before this decision; §2 proved the first hop and the manifest
declares the second. Stated end to end, with the authority for each step:

| Step | From → To | Mechanism | Authority |
|---|---|---|---|
| 1 | `BC-05` → Business Platform | **`business.payment_intent` port** | Matrix **L196** (normative §6) · **L167** · `X-03` **L352** · Accepted `ADR-0012` **L86** |
| 2 | Business Platform → `platform/integration` | **`platform/integration:payment_gateway` port** | `tool/module_dependencies.yaml` **L409** — already declared |
| 3 | `BC-31` → payment provider | Outbound vendor contract | BC Map **L140** — *"owns **outbound** third-party contracts, credentials, retries"* |
| 4 | Result returns inbound | ⛔ **transport owner undeclared** | `FEE-GAP-016` (§5.5) — **not resolved here** |
| 5 | Verification of the result | `BC-05` verifies | `MP-GBR-18` · frozen `MM-BR-005` · `FEE-INV-005` · `FEE-BR-016` |
| 6 | Confirmed `FeePayment` / `Receipt` | `BC-05` writes financial truth | BC Map **L374** · `MP-GBR-24` |

**No `E-*` edge is added, and none is required.** Accepted `ADR-0033` settled that BC Map L292 *"**governs edges**…
It does **not** state that every cross-context read must be an edge"*, and the measurement in §4.2 stands: **14 of
`library_management`'s 17 declared ports have no usable numbered edge**, including `identity.policy_decision`.
Requiring one here would invalidate thirteen lawful dependencies. **The Dependency Matrix is unamended.**

`BC-05` remains forbidden from naming a vendor, holding a gateway credential, calling `BC-31` directly, or knowing
any gateway protocol detail (`X-03`, Matrix L167, `FEE-XC-005`, `FEE-XC-006`). **Step 1 is a port call, not
knowledge of a rail.**

### 5.5 `D-4` — Webhook ingress ownership is **NOT** resolved, and is recorded as a governance gap

The `D-2` investigation found that **inbound** transport has no owner anywhere in the architecture (§3.4):
`grep -c "webhook"` and `grep -c "inbound"` over the Rank 4 BC Map both return **0**; `BC-31` is defined
**outbound-only** (L140); and the component the EA nominates for inbound adapters — *"API Platform = inbound
adapters"* (EA L165) — **holds no `BC-` identifier** and is not one of the 31 contexts.

**This decision does not fill that gap, and deliberately so.** The minimum amendment that would be required is a
**capability declaration naming an inbound-adapter owner within `platform/integration`** — the same shape as step 2
above, preferring an existing platform capability over any new context, consistent with `AR-1` (a receiver that
validates and forwards owns no aggregate). **But no authoritative source names that owner**, and this ADR will not
invent one: no endpoint, no payload, no signature scheme, no vendor callback behaviour is written here.

Recorded as **`FEE-GAP-016`** in `PRD-008` §37. **Consequence, stated plainly:** `PRD-008` **MUST NOT** specify the
webhook contract or server-side confirmation *mechanism* until `FEE-GAP-016` is decided, and **Stage 3 check 2
therefore remains ⛔ BLOCKED.** What changed is that the blocker is now **one narrow, well-specified question**
instead of the whole payment architecture.

**What is nonetheless already settled and needs no further decision:** a webhook is **transport**, so it may never
write financial truth. `FEE-BR-014` already holds that client-side success is never financial truth; `FEE-INV-005`
and `FEE-BR-016` already require idempotency and server-side verification in `BC-05`. **An inbound message is
evidence to be verified, never an instruction to be obeyed** — and that rule exists today, independently of who
owns the receiver.

**What the `D-2` investigation added, without selecting.** Four of the six ownership rows in §3.2 are **closed by
measurement** — payment intent, gateway integration, the payment-verification *obligation*, and student financial
truth. Two remain open: **execution** (row 2) and **webhook/reconciliation ingress** (row 6). The investigation also
changed the shape of the remaining choice:

| Option | Status after measurement | Why |
|---|---|---|
| **`O-2`** — `BC-20` executes the rail | ⛔ **Contradicted by a Rank 1 rule** | `MP-GBR-24`. Unchanged from §3.1, and the shared kernel now **mechanically enforces** it: `packages/liboora_contracts` bans `class Payment ` with the message *"FeePayment (BC-05) or SubscriptionCharge (BC-20)"*. The split is CI-enforced, not merely prose |
| **`O-1`** — create `BC-32` for payment execution | ⚠ **Evidentially disfavoured** | `AR-1` (Rank 4, authoritative) supplies the test a new context must pass: it must own *"an aggregate… an invariant… business state"*. A rail that executes and returns owns **none** — §3.2 row 5 keeps the aggregate in `BC-05` and row 4 keeps the invariant there. `PRD_REGISTRY.md` L355 applied exactly this test and recorded *"**no `BC-32` was created** and the context count remains 31"* |
| **`O-3`** — a `platform/business` capability owning no context | ✅ **The only option no higher-ranked source contradicts** | Frozen `PRD-005` **L164** (Rank 3) attributes the subject to *"`BC-05` / **Business Platform**"* — the **platform**, not `BC-20`. EA **L122** independently resolves the same duplication to *"**BUSINESS PLATFORM** (money movement) / Library (fee *domain intent*)"*, again naming no context. `ADR-0013` (Accepted) supplies the precedent: *"a capability context is owned by its platform"* |

> ⚠ **This is convergence, not authority, and the distinction is the whole point.** Three sources independently
> name the **platform** and none names a **context**, which is what `O-3` asserts. But `PRD-005` L164 is a
> *"not mine"* scope table — it is authoritative about where the subject is **not** (`BC-02`), and only indicative
> about where it **is**; and the EA is **descriptive by baseline designation** and may not lead a PRD. **Converging
> indicative evidence is not a decision.** Two things still require the Architecture Owner and cannot be measured
> into existence:
>
> 1. **The Rank 1 reading.** `MASTER_PRD.md` L232 versus `MP-GBR-24` L362 (§3.1). Both are Rank 1, so precedence
>    cannot arbitrate, and `O-3`'s admissibility depends on which reading is correct.
> 2. **Row 6 has no candidate at all.** No source, at any rank, names an owner for webhook ingress. `O-3` does not
>    supply one either. **No amount of further measurement will produce this answer** — it does not exist in the
>    repository, and inventing it is precisely what this ADR must not do.
>
> **`D-2` therefore remains UNRESOLVED and this ADR remains `PROPOSED`.** The investigation narrowed the decision
> from *"who owns payments?"* to *"confirm `O-3`, and name an owner for webhook ingress"* — which is a materially
> smaller and better-specified question, but still a decision, and still not this document's to take.

### 5.3 `D-3` — `D-14` mis-attributes `E-25` and should be corrected

`PRD_DEPENDENCY_GRAPH.md` **L116** reads `| D-14 | PRD-008/PRD-020 | PRD-019 BC-31 Integration | API | E-25 |`.
**`E-25` is `BC-20 → BC-31`** (BC Map L334); `PRD-008` owns `BC-05`, not `BC-20`, so `PRD-008` cannot be a party to
`E-25`.

**This is a citation defect of exactly the class `ADR-0015` corrected**, and it is low-risk to fix because the
document disclaims its own authority in its header: *"**Derived. Non-normative.** Every edge below is read from the
Bounded Context Map §7 … This document **adds no edge of its own**."* A derived document asserting an edge its
source does not support is **stale, not authoritative**.

**Not executed by this ADR.** `PRD_DEPENDENCY_GRAPH.md` is untouched, because the correct replacement text depends
on the `D-2` outcome. Recommended once `D-2` is settled: remove the `E-25` citation from the `PRD-008` half of
`D-14`, and cite the `business.payment_intent` port instead.

---


### 5.6 The minimum manifest declaration — recorded as a **PROPOSAL ONLY**, not applied

`D-2` decides *who executes*. The machine-checked manifest, however, still does not **say so**: measured at
this HEAD, `provides_ports:` is used by **exactly two** modules — `domain/person` (L188) and
`platform/identity` (L442) — and **`platform/business` (L405–L416) declares none** (§3.3). So the callee of
`business.payment_intent` is undeclared **in the source the lint rule actually reads**, not merely in prose.

**This ADR does not fix that, and the distinction is deliberate.** Deciding an architecture is a *governance*
act; editing `tool/module_dependencies.yaml` is an **implementation** act that changes what CI enforces.
Performing the second while this ADR is `PROPOSED` would enact an unaccepted decision. **`tool/module_dependencies.yaml`
was therefore NOT modified by this pass** — verified by hash in §9.

**What follows is the minimum shape such a declaration would take, using only keys already present in the
manifest schema** (`name:`, `consumers:`, `constraint:` — exactly as `platform/identity` L442–L452 uses them).
It is offered so the approving authority can see the *whole* cost of `O-3` before accepting it:

```yaml
# PROPOSAL ONLY -- NOT APPLIED. Requires acceptance of ADR-0035 D-2 first.
platform/business:                     # existing block, L405-L416
  provides_ports:                      # key does not currently exist on this module
    - name: payment_intent
      consumers: [domain/library]
      constraint: "executes a student-to-library payment; owns no FeeLedger, no FeeDue,
                   no FeePayment and no financial invariant; confirmation is BC-05's"
```

**Three properties of this shape matter, and each is a restraint rather than a grant:**

| Property | Why it is written this way |
|---|---|
| `consumers: [domain/library]` — **not** `[*]` | `AR-1` permits a capability, not a general-purpose rail. Only `BC-05`'s module has a declared need |
| The `constraint:` **denies** ownership rather than granting capability | It is the `MP-GBR-24` boundary expressed where CI can see it. `platform/identity`'s `account_directory` constraint uses the same denying form |
| **No new module block, and no new port name** | `platform/integration:payment_gateway` already exists (L409) and `payment_intent` is already the name used at Matrix L196 and `X-03` L352. **Nothing is invented — an existing name is given an existing owner** |

> **`FEE-GAP-016` needs the same treatment and does NOT get it here.** The inbound owner would require a
> `provides_ports:` entry on **`platform/integration`** — and measured, **there is no `platform/integration:`
> module block in the manifest at all** (`grep -n "^platform/integration:"` → **rc=1**; it appears only in the
> rank list at L40 and as a port *target*). Creating that block is a larger act than adding a key, and
> **no port name, endpoint, payload, signature scheme or retry policy is proposed for it**, because none exists
> in any source to copy. That is precisely why `FEE-GAP-016` is a **gap awaiting a decision** and not a
> proposal awaiting application.
## 6. Options for `D-2` — **`O-3` SELECTED** *(this table records the choice as offered; the decision is §5.2)*

| # | Option | For | Against |
|---|---|---|---|
| **O-1** | A **new bounded context** for student-payment execution inside `platform/business` | Cleanly honours `MP-GBR-24`; the port gets a real owner | Creates `BC-32` — the map has held **31** contexts since inception, and the standing instruction prefers *"a smaller number of clear bounded contexts over unnecessary fragmentation"* |
| **O-2** | **`BC-20` implements the port but is barred from modelling student money** — it executes the rail only, holding no `FeeDue`, `Receipt` or student balance | No new context; `BC-20` already owns *"gateway"* and `PaymentAttempt` | Risks the `MP-GBR-24` breach in practice; needs an explicit, testable statement of what `BC-20` may **not** persist |
| **O-3** | `payment_intent` is a **`platform/business` capability with no context of its own** — a rail, like `data.repository`, owning no aggregate | Matches how the other 13 no-edge ports already work; smallest change; `ADR-0013`'s *"a capability context is owned by its platform"* is adjacent precedent | The BC Map's aggregate table would carry no owner for gateway references; reconciliation ownership still needs naming |

> **Resolution.** The table above is preserved **exactly as first written**, including its *"no recommendation"*
> framing, so the record shows what was offered before the choice was made. **`O-3` is now SELECTED** by the
> Architecture Owner in **§5.2**; `O-2` is refused on Rank 1 `MP-GBR-24` (§5.2.4) and `O-1` on the `AR-1` test
> (§5.2.5). The *"Against"* cell for `O-3` above noted two costs; both are addressed rather than dismissed —
> gateway-reference ownership stays with `BC-05` (`FEE-INV-005`, `FEE-BR-016`, frozen `MM-BR-005`), and
> **reconciliation ownership is exactly what remains open**, recorded as `FEE-GAP-016` in §5.5. The Architecture Owner should also state **who owns webhook/verification receipt** under
the chosen option, since `PRD-008` cannot specify server-side confirmation without it.

---

## 7. Authority — why this ADR is `PROPOSED`

`D-1` recognises an authorisation that four ranked documents already grant, and a reader may reasonably ask why it
needs an ADR at all. **The answer is that recognising it changes a Stage 3 verdict, and a document should not
upgrade its own verdict on its own say-so.** `ADR-0033` §7.1 records the same restraint, and it was right:

> *"A conferral for one act is not a standing licence."*

**No conferral of Architecture Owner authority has been given for this decision.** No ARB met; no quorum, attendee
list, sign-off date or Security review is asserted. `D-2` is in any case a genuine open question that **only** the
Architecture Owner can close.

**Consequently:**

| Claim | Status |
|---|---|
| `D-1` binds implementation | ❌ Not until Accepted |
| `D-2` is decided | ❌ **Explicitly not decided** |
| `D-3` is executed | ❌ Recommended only; `PRD_DEPENDENCY_GRAPH.md` untouched |
| Any ranked document is amended | ❌ **None** |
| `PRD-008` Stage 3 may be declared ALIGNED | ❌ **No** — check 2 stays BLOCKED while `D-2` is open |
| `FEE-GAP-002` may be closed | ❌ **No** — it moves to **PARTLY RESOLVED**, and stays open on `D-2` |

**What the Architecture Owner is asked to do:** ratify or reject `D-1`; decide `D-2` from §6 (or otherwise); and
authorise the `D-3` correction.

---

## 8. Consequences

**If Accepted:**
- `PRD-008`'s payment transport is settled and `FEE-XC-005`/`FEE-XC-006` gain a positive counterpart.
- Stage 3 check 2 is **still blocked** until `D-2` is answered — acceptance of `D-1` alone does not clear it.
- A reusable rule is confirmed: **a port declared in Matrix §6 is a lawful dependency without a numbered edge**,
  which is already true of 14 existing ports and would stop this question recurring for every one of them.

**If Rejected:** every one of the 14 no-edge ports needs an edge, `ADR-0033`'s ratio is overturned, and the Rank 4
allow-list must be widened substantially — a far larger change than this ADR proposes.

**Risks:**

| Risk | Mitigation |
|---|---|
| `D-1` read as licence for `BC-05` to call a gateway | §5.1 restates all four prohibitions; `X-03` unchanged |
| `D-2` settled by default toward `BC-20` because it is easiest | §3.1 states the `MP-GBR-24` breach explicitly; `ADR-0015` is cited as the precedent for why the distinction is load-bearing |
| This ADR treated as unblocking Stage 3 | §7's table states the opposite in terms |

---

## 9. Compliance

| # | Check | Expected |
|---|---|---|
| 1 | `grep -c "^| E-" LIBOORA_BOUNDED_CONTEXT_MAP.md` | **26**, unchanged — no edge added |
| 2 | `sha256sum LIBOORA_MODULE_DEPENDENCY_MATRIX.md \| cut -c1-16` | **`9895d244494372af`**, unchanged |
| 3 | `sha256sum LIBOORA_BOUNDED_CONTEXT_MAP.md \| cut -c1-16` | **`81518f1bb251218b`**, unchanged |
| 4 | `git diff --name-only -- lib test pubspec.yaml android web \| wc -l` | **0** |
| 5 | This ADR's Status row | **`PROPOSED`** — decided, **not** accepted |
| 6 | `sha256sum tool/module_dependencies.yaml \| cut -c1-16` | **`22e40ac3fe080387`**, unchanged — §5.6 is a **proposal**, not an application |
| 7 | `grep -c "^platform/integration:" tool/module_dependencies.yaml` | **0** — the block still does not exist; `FEE-GAP-016` is therefore a real gap, not an oversight |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-15 | **`D-2` DECIDED — `O-3`: payment execution is a Business Platform **capability**, not a new bounded context. Recorded under conferred Architecture Owner authority; **NOT self-accepted** — Status stays `PROPOSED`.** The decision was **tested before it was taken**. The intuitive precedent, Accepted `ADR-0013` (*capability contexts are owned by their platform*), was measured and **rejected as the authority**: its Decision (L94–128) only ever resolves ownership for `BC-19`/`BC-25`/`BC-29`, contexts that **already hold `BC-` identifiers**, and it contains **0 matches** for BC-less language. **That limit is now recorded in §5.2.2** so a later reader cannot over-read it. The governing authority is **`AR-1`** (`ARCHITECTURE_RULINGS.md` L23–37; BC Map L86/L558), whose four criteria were each measured and **all four pass** — no aggregate (`FeeLedger` is `BC-05`'s, L374), no invariant (`FEE-INV-005`/`FEE-BR-016`/frozen `MM-BR-005`), no business state, full delegation — so `AR-1` does not merely permit `O-3`, it **requires** it. Outcome precedent: `PRD_REGISTRY.md` L355, *"no `BC-32` was created … the context count remains 31"*. **`O-2` refused** on Rank 1 `MP-GBR-24`, now also **CI-enforced** by the rank-0 kernel's `banned_symbols` (`class Payment ` → *"FeePayment (BC-05) or SubscriptionCharge (BC-20)"*); **`O-1` refused** on `AR-1`. **The Rank 1 tension is dissolved by scope, and neither statement is amended, weakened or reinterpreted:** `MASTER_PRD.md` L232 sits in **§10 Technology Stack**, whose preamble declares its subject to be *"capabilities with abstractions, with vendors recorded as candidate implementations behind ports"* — a **vendor-abstraction** table — while L362 `MP-GBR-24` governs the **financial model**. Adds §5.3 (**11-row ownership table**, every row carrying its own authority), §5.3.1 (**six concepts held apart** — transport, execution, verification, financial truth, settlement, webhook reconciliation — with a *"may it write `FeeLedger`?"* column), §5.3.2 (cash: *"staff recording cash ≠ LIBOORA receiving money"*; the **3% stays wholly outside `FeePayment`**), §5.4 (**the lawful path in 6 steps with no new numbered edge** — every hop was already declared, incl. `platform/business` → `platform/integration:payment_gateway` at manifest L409), §5.5 (**`D-4` webhook ingress — NOT resolved**, recorded as **`FEE-GAP-016`**) and §5.6 (**the minimum `provides_ports:` declaration, as a PROPOSAL ONLY**). **Webhook ingress is not pretended to be settled:** BC Map `webhook`/`inbound` = **0**; `BC-31` L140 is **outbound** only; EA L165 names an *"API Platform"* for inbound adapters, but that band **holds no `BC-` identifier** and the EA is **descriptive** (`DOCUMENTATION_BASELINE.md` L139), so it **describes** an owner it cannot **confer**. **`BC-31` is not assumed to own inbound.** **What this version does NOT do:** it does not accept itself; creates no bounded context and no `BC-` id; adds no `E-*` edge; changes no Matrix or BC Map cell; moves no aggregate; gives `BC-20` no role in student money; and **does not modify `tool/module_dependencies.yaml`** — §5.6's declaration is a **proposal**, because applying it is an implementation act requiring acceptance first (manifest hash verified unchanged in §9). §6's original *"no recommendation"* options table is **preserved verbatim** with a resolution note, so the record shows what was offered **before** the choice. **No endpoint, payload, signature scheme, retry policy, vendor contract, permission or configuration identifier was invented. No frozen or ranked document was modified. No gate was weakened.** |
| **v1.0** | 2026-08-05 | Created by the `FEE-GAP-002` investigation ordered for `PRD-008` Stage 3. **Finds the blocker is two questions, not one.** The **transport** (a) is already authorised — Dependency Matrix **L196** declares `business.payment_intent` in `library_management`'s ports inside the section the Matrix itself calls *"the normative form"*; **L167** forbids the direct route and names this one; the matrix cell `LIB → BUS` is `◇` (verified by **mechanical 19/19 column alignment**, not by eye); `X-03` **L352** prescribes the port by name; and Accepted **`ADR-0012` L86** already records `domain/library → platform/business :payment_intent` as a correctly-directed declared port. The **counterparty** (b) is genuinely undeclared: `platform/business` holds only `BC-20` and `BC-21`, **`MP-GBR-24` (Rank 1) bars `BC-20` from student money**, and `PaymentIntent` appears **0 times** in the whole of `docs/`. Also finds that **14 of `library_management`'s 17 declared ports have no usable numbered edge**, so requiring one here would invalidate thirteen other lawful dependencies — consistent with Accepted **`ADR-0033`**, which held that BC Map L292 *"governs edges"* and does not require one for every cross-boundary dependency. Discloses a **Rank 1 internal tension** (`MASTER_PRD.md` L232 vs `MP-GBR-24` L362) and **raises it rather than choosing**, per `DOCUMENTATION_BASELINE.md` §4. Recommends correcting `D-14`'s mis-attribution of `E-25` — a citation defect of the class `ADR-0015` fixed — but **does not execute it**. **Three options for the counterparty are presented and none is recommended.** **No edge added, no allow-list widened, no context created, no aggregate/contract/webhook/endpoint/table defined, no ranked document amended, no Dart source touched.** **Left `PROPOSED`: no conferral of Architecture Owner authority was given, and `D-2` is a question only that authority can answer.** |
