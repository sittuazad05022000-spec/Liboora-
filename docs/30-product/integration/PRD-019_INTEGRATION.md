# PRD-019 — INTEGRATION (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-019_INTEGRATION.md` |
| **PRD** | `PRD-019` |
| **Module** | Integration |
| **Bounded Context** | **`BC-31` Integration** |
| **Classification** | `[GENERIC]` — Integration platform |
| **Release** | **V1** |
| **Version** | **v0.2 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT approved. NOT architecture-reviewed. NOT frozen.** Status is *conferred* by the register, never claimed by a document about itself; the `PLANNED` → `DRAFT` movement is recorded in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.2 by the Governance Owner under [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md) |
| **Date** | 2026-08-15 |
| **Baseline** | Written **against** `BASELINE-2026-08-05-A`. **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD) — **not held today**, because admission is a baseline act |
| **Owns** | Outbound third-party contracts, credentials, retries, idempotent delivery — **BC Map L140**, verbatim and unextended |
| **Identifier prefix** | **`ITG-*`** — **56 identifiers issued at v0.2** (54 obligation-bearing + 2 `ITG-GAP-*`), every range **contiguous from 001**. **Counted by script, not asserted** — see §5 |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ACCEPTED` `ADR-0040`, `ACCEPTED` `ADR-0043`, **`ACCEPTED` `ADR-0046`** (the V1 provider), **`ACCEPTED` `ADR-0047`** (the authority to author §4) (Rank 2) · **BC Map v1.7** (Rank 4) · Module Dependency Matrix v1.3 (Rank 4) |
| **Provider source** | **Razorpay's own published webhook documentation**, fetched and cited per value in §4.9. The repository contains none of it, so **every provider-specific value in §4 carries an external citation** — and every value that is *not* Razorpay's is labelled as such |

---

> ### ⚠️ Read this before treating any statement here as settled
>
> This is a **Stage 2 draft created for one purpose**: to give the payment-webhook **wire contract** a lawful
> owner, because `ACCEPTED` [`ADR-0040`](../../00-governance/adr/ADR-0040-webhook-ownership-authoritative-and-bc-05-verification-obligation.md)
> **§4 L165** assigns that contract to *"the `BC-31` owner, **once `PRD-019` exists**"* — and until this file was
> written, `PRD-019` did not exist.
>
> **At v0.1 this document assigned ownership without exercising it. At v0.2 it exercises it.** §4 now carries the
> **minimum V1 webhook contract**: route, transport and payload schema, signature verification, replay protection,
> retry and failure handling, and the required event set. **`Q-B31` is CLOSED** (§4.8).
>
> ⚠ **Three things that did NOT change, and must not be read into §4:**
> **(1)** `BC-05` / `PRD-008` remains the **financial source of truth** — §4 defines transport and evidence handling
> only, and asserts **no** financial rule (§3, §4.6). **(2)** Inbound **ingress** remains a `platform/business`
> capability — owning the contract is not owning the ingress (§2.1). **(3)** `PRD-008` is **byte-unchanged** and is
> **not** frozen by this pass.

---

## 0. Document control

### 0.1 What this document is

The Product Requirements Document for **`BC-31` Integration**. It was opened at **v0.1** with a single completed
act — the **ownership assignment** recorded in §2 — and at **v0.2** it performs the second: **§4 authors the
minimum V1 payment-webhook wire contract** that §2 assigns to `BC-31`, closing **`Q-B31`**.

### 0.2 What this document is NOT

It is **not** a complete specification of `BC-31`'s behaviour. **One** slice of it is specified — the payment
webhook wire contract in §4. `BC-31`'s remaining requirement set — outbound connectors in general, the wider
credential lifecycle, outbound retry semantics, idempotent *outbound* delivery — is **still unwritten**, and this
draft does not pretend otherwise (§7).

⚠ **What §4 necessarily does define, stated plainly rather than left for a reader to notice:** an **inbound route**,
a **wire payload schema**, and a **named provider** (`Razorpay`, by `ACCEPTED` `ADR-0046`). A wire contract cannot
exist without them. It still defines **no** database schema, no framework, no widget, no infrastructure choice, no
new API architecture and no configuration identifier.

**It does not restate, amend, weaken or duplicate `PRD-008`.** See §3.

---

## 1. Why this document exists now

Measured, not asserted. `ACCEPTED` `ADR-0040` **§2 L77–L83** established that **four** candidate authors were
each barred from writing the payment-webhook wire contract:

| Candidate author | Bar |
|---|---|
| `BC-20` / `PRD-022` | Its own **`SAAS-XC-006`** (L157-158) bars *"naming a payment provider, endpoint, **webhook schema**, signature algorithm, retry policy"* and assigns vendor knowledge to **`BC-31`** |
| `BC-31` / `PRD-019` | **The PRD did not exist** — `PRD_REGISTRY.md` **L309** recorded it `PLANNED` |
| `BC-05` / `PRD-008` | Forbids itself, at its own **§14.1** |
| An ADR | `ADR-0035` §5.5b forbids inventing an endpoint/schema; `ADR-0039` §7.2 bars an ADR from writing requirement text; `ADR-0040` **L166** holds that writing another PRD's content elsewhere *"would create a **second source of truth**"* |

**Three of those four bars are substantive and remain in force. The second was procedural** — a missing
document — and this file removes it. **Nothing else about the contract changed.**

> **This is the narrowest possible remedy.** The alternative considered and refused was to author the contract
> inside `PRD-008`, which `ADR-0040` **L166** forbids as a second source of truth, and which would have required
> inventing an endpoint, a schema, a signature algorithm, a replay window and a retry policy.

---

## 2. Ownership assignment — the payment webhook wire contract

**`BC-31` Integration owns the payment-gateway webhook *wire contract*.**

`ADR-0040` **§4 L165** enumerates that contract as exactly five elements:

| # | Element of the wire contract | Owner |
|---|---|---|
| 1 | Endpoint | **`BC-31`** — this document |
| 2 | Payload schema | **`BC-31`** — this document |
| 3 | Signature algorithm | **`BC-31`** — this document |
| 4 | Replay window | **`BC-31`** — this document |
| 5 | Retry policy | **`BC-31`** — this document |

**This assignment creates nothing.** It **recognises** an allocation three ranked sources already make:

- **BC Map L140** — `BC-31` *"Owns outbound third-party contracts, credentials, retries, idempotent delivery."*
- **`PRD_REGISTRY.md` L309** — `PRD-019` Integration, `BC-31`, V1, *"Outbound contracts, retries, idempotent delivery."*
- **`PRD-022`'s `SAAS-XC-006`** — assigns vendor knowledge to `BC-31` by excluding it from `BC-20`.
- **Dependency Matrix `X-03`** — *"no vendor knowledge"* outside `platform/integration`.

**No bounded context, edge, port, module, role, permission or configuration identifier is created by this
document.** The context count remains **31**. The BC Map, the Dependency Matrix and
`tool/module_dependencies.yaml` are **byte-unchanged**.

### 2.1 What ownership of the wire contract does NOT include

`ACCEPTED` `ADR-0040` **§1** settles, and this document does not disturb, that **inbound webhook ingress is a
capability of `platform/business`** — upholding `ACCEPTED` `ADR-0035` §5.5b unchanged. **Owning the wire
contract is not owning ingress**, and this document makes no claim on ingress.

> **The `platform/integration` reading of ingress is NOT adopted here.** `ADR-0035` **L442**, written
> pre-conferral, did propose an inbound adapter within `platform/integration` — but **§5.5b superseded L442**,
> and a superseded proposal is not authority (`ADR-0040` §1.2). Resurrecting it inside the very document that
> benefits from it would be the flattering direction.

---

## 3. The boundary against `PRD-008` — stated so it cannot be crossed by accident

| Concern | Owner | Authority |
|---|---|---|
| The webhook **wire contract** (the five elements in §2) | **`BC-31`** — this document | `ADR-0040` §4 L165 |
| Inbound webhook **ingress** | **`platform/business`** capability | `ADR-0035` §5.5b; `ADR-0040` §1 |
| Webhook **verification** — that a notification is genuine | **`BC-05` / `PRD-008`** | `ADR-0035` §5.5b: *"`BC-05` keeps payment intent, the **verification obligation** and student financial truth"* |
| **Financial truth** — what is owed, paid, confirmed, refunded | **`BC-05` / `PRD-008`** | BC Map **L374**; `MP-GBR-24` |
| Payment **intent** | **`BC-05` / `PRD-008`** | `ADR-0035` §5.5b |

**`ITG` owns the wire. `BC-05` owns the money.** A notification arriving on the wire is **evidence, never an
instruction** — `PRD-008`'s `FEE-BR-014`, tested by `FEE-AC-032`/`033`/`034` and `FEE-AC-085`…`089`. This
document **does not weaken, restate or duplicate any of them**, and asserts **no** financial rule.

> **Why the duplication bar matters more than it looks.** Had this document restated `PRD-008`'s verification
> behaviour "for completeness", the platform would have two documents describing one obligation — and the next
> editor to change one of them would silently fork financial truth. `ADR-0040` **L166** names that failure mode;
> the remedy is a **pointer**, not a copy.

---

## 4. The V1 payment webhook contract — `Q-B31` RESOLVED

**This section is the wire contract.** It is authored here and **nowhere else**: `ACCEPTED` `ADR-0040` **L166**
holds that writing another document's content elsewhere *"would create a **second source of truth**"*, so **`PRD-008`
is byte-unchanged by this pass** and contains no part of what follows.

### 4.0 The authority under which this section exists, and the two-value rule that governs every line of it

| Question | Answer |
|---|---|
| Who may author it? | The **`BC-31` owner** — `ACCEPTED` `ADR-0040` **§4 L165**, *"once `PRD-019` exists"*, and §2 of this document |
| What unblocked it? | `ACCEPTED` [`ADR-0046`](../../00-governance/adr/ADR-0046-v1-payment-gateway-provider-razorpay.md) — **the V1 payment gateway provider is `Razorpay`**. Every value below is a property of a *chosen* provider's wire format, so before that ADR none of them was knowable |
| What supplied the values? | **Razorpay's own published webhook documentation**, cited line by line in **§4.9**. `ACCEPTED` `ADR-0045` §5.2 named exactly this as the missing input: *"that provider's own published webhook documentation, **which this repository does not contain**"* |
| Recorded where? | `ACCEPTED` [`ADR-0047`](../../00-governance/adr/ADR-0047-prd-019-v1-webhook-contract-authority.md) — the governance record for this act |

> #### ⚠ The rule that keeps this section honest: **every value is labelled by its origin**
>
> A webhook contract is **two** kinds of value welded together, and blurring them is how invention gets smuggled in:
>
> | Kind | Who decides it | How it is marked below |
> |---|---|---|
> | **Provider-determined** — Razorpay dictates it; we may only obey | **Razorpay** | **`[RZP]`** + a citation in §4.9. **Not one of these is chosen, inferred or rounded by this document** |
> | **LIBOORA-determined** — Razorpay constrains the *shape* but names no value | **This document** (`BC-31` owner) | **`[LIB]`** + the constraint it must satisfy |
>
> **The route is the case that proves the distinction matters.** Razorpay does **not** publish a path for us to
> implement: it requires a *merchant-configured* URL that satisfies published constraints (public, ports 80/443,
> TLS 1.2+, not blacklisted, Razorpay IPs reachable). So the path in §4.1 is **`[LIB]`** — **a LIBOORA value
> constrained by Razorpay, not a Razorpay value**. Presenting it as `[RZP]` would be the exact invention rule 4
> forbids, dressed as compliance.

---

### 4.1 Endpoint / route — **`[LIB]` value under `[RZP]` constraints**

| ID | Requirement |
|---|---|
| **`ITG-FR-001`** | The platform **MUST** expose exactly **one** inbound payment-webhook route for V1. Its path **MUST** be `POST /webhooks/payments/gateway`. **`[LIB]`** — the path is this document's choice; §4.9 records that Razorpay publishes no path |
| **`ITG-FR-002`** | The route **MUST** accept **`POST`** with a **JSON** request body, and **MUST NOT** rely on query parameters for event data. **`[RZP]`** — *"Razorpay sends an HTTP POST request with JSON payload to your configured endpoint URL"* |
| **`ITG-FR-003`** | The route **MUST** be reachable on a **public URL** served on **port 443** (`80` is permitted by the provider and **excluded here** by `ITG-BR-002`), and **MUST NOT** be a `localhost` or tunnel address in any environment Razorpay is configured against. **`[RZP]` constraint** — *"Webhook URLs must use ports 80 or 443 only"*; *"You cannot use localhost directly … webhook delivery requires a public URL"* |
| **`ITG-FR-004`** | Separate route configuration **MUST** exist for Razorpay **Test** and **Live** modes, and a Test-mode delivery **MUST NOT** reach production financial state. **`[RZP]`** — *"configure separate URLs for Live mode and Test mode"* |
| **`ITG-BR-001`** | The route **MUST** be served over **TLS 1.2 or higher**. TLS 1.0 and 1.1 **MUST NOT** be offered. **`[RZP]`** — *"Razorpay Production environment does not support the older versions of TLS 1.0 and 1.1"* |
| **`ITG-BR-002`** | Although the provider permits port `80`, V1 **MUST** serve **443 only**. **`[LIB]`** — a narrowing, never a widening: it is the intersection of the provider's allow-list with `ITG-BR-001`, so it cannot conflict with `[RZP]` |
| **`ITG-BR-003`** | Razorpay's published webhook source IP addresses **MUST** be reachable by the route's network path. **`[RZP]` constraint** — *"Ensure Razorpay webhook IPs are whitelisted on your server … webhooks may still be blocked by cloud security groups"*. ⚠ **The IP list itself is deliberately NOT transcribed here** — see `ITG-XC-004` |
| **`ITG-XC-001`** | **Excluded:** naming `Razorpay` anywhere in the route path, in a database column, in a domain event payload or in an internal API contract. The path in `ITG-FR-001` is **provider-neutral by construction** — `PRD-008`'s `FEE-XC-006` and Dependency Matrix **L167** |

> **Why the path is vendor-neutral and not `/webhooks/razorpay`.** A route string is *"an API contract"* in the sense
> `FEE-XC-006` excludes, and Dependency Matrix **L167** holds that *"the domain must not know that Razorpay … exists."*
> A neutral path also means adding a second gateway (EA lists `Multiple Gateways (V3)`) needs no route migration.
> ⚠ **The honest cost, stated because a neutral path is not free:** one route that names no vendor cannot
> self-identify its sender from the URL. In V1 that costs nothing, because there is exactly **one** configured
> provider and therefore exactly one webhook secret to try (plus its predecessor during rotation,
> `ITG-FR-014`) against a single mode-scoped configuration (`ITG-FR-004`). **If a second gateway is ever added**
> (EA lists `Multiple Gateways (V3)`), sender resolution becomes a real design question that this contract does
> **not** answer — and it is `ITG-GAP-001`'s sibling rather than a hidden assumption: recorded here, in the
> paragraph that created the debt.

---

### 4.2 Request / payload schema — **`[RZP]`, transcribed not designed**

| ID | Requirement |
|---|---|
| **`ITG-FR-005`** | The receiver **MUST** accept the provider envelope with fields `entity` (constant `"event"`), `account_id`, `event`, `contains` (array), `created_at` (integer epoch seconds) and `payload`. **`[RZP]`** |
| **`ITG-FR-006`** | Entity data **MUST** be read at `payload.<entity>.entity`, where `<entity>` is a member of `contains` — e.g. `payload.payment.entity`. **`[RZP]`** |
| **`ITG-FR-007`** | For a `payment` entity the receiver **MUST** be able to read: `id` (`pay_…`), `order_id` (`order_…`), `amount` (**integer, minor currency unit**), `currency`, `status`, `method`, `captured` (boolean), `amount_refunded`, `fee`, `tax`, `error_code`, `error_description` and `notes`. **`[RZP]`** — transcribed from the published `payment.captured` sample |
| **`ITG-FR-008`** | The receiver **MUST** tolerate **`null`** in any optional entity field (the published sample carries `null` in `bank`, `fee`, `tax`, `token_id`, `vpa`, `wallet`, `refund_status`, `issuer`) and **MUST NOT** fail a delivery because an unused field is absent, `null`, or newly added. **`[RZP]`** |
| **`ITG-FR-009`** | The receiver **MUST NOT** treat the payload as the *current* state of the entity. It is a **snapshot at event time**. **`[RZP]`** — *"The payload for a Webhook is a snapshot of the entity when the event occurred … the payload for the `payment.authorized` event contains details of the events when the payment was authorised, not when it was captured"* |
| **`ITG-BR-004`** | Event delivery order **MUST NOT** be assumed. `payment.authorized` **MAY** arrive after `payment.captured`, or not at all in the expected sequence. **`[RZP]`** — *"The above order may not be followed at all times. You should configure your webhook URL to not expect delivery of these events in this order"* |
| **`ITG-BR-005`** | `amount` **MUST** be carried to `BC-05` in the **minor unit exactly as received**, with the `currency` field, and **MUST NOT** be rescaled, rounded or converted to a decimal on the wire boundary. **`[LIB]`** on an `[RZP]` fact (published sample: `"amount": 100` with `"currency": "SGD"`) |
| **`ITG-INV-001`** | For any accepted delivery, the tuple `(tenant, provider_event_id)` **MUST** be recorded **exactly once**. See §4.4 |
| **`ITG-XC-002`** | **Excluded:** persisting the raw provider payload as, or in place of, financial state. It is retained as **evidence** only, and financial state is `BC-05`'s (`ITG-BR-010`) |

> ⚠ **Deliberately NOT transcribed, and why that is a completeness limit rather than a gap in the contract:** the
> **full** Razorpay field list for every entity and every payment method. `ITG-FR-007` names the fields V1 reads;
> `ITG-FR-008` makes unknown fields non-fatal. Copying the provider's entire schema would create a **second copy of
> their documentation** that silently rots when they change it — the same failure mode `ADR-0040` L166 names, pointed
> at an external document instead of an internal one.

---

### 4.3 Signature verification — **`[RZP]`, and the ordering rule that makes it meaningful**

| ID | Requirement |
|---|---|
| **`ITG-FR-010`** | The signature **MUST** be read from the **`X-Razorpay-Signature`** request header. **`[RZP]`** |
| **`ITG-FR-011`** | Verification **MUST** compute **HMAC with SHA256**, using the configured **webhook secret** as the **key** and the **request body** as the **message**. **`[RZP]`** — *"The hash signature is calculated using HMAC with SHA256 algorithm; with your webhook secret set as the key and the webhook request body as the message"* |
| **`ITG-FR-012`** | The message **MUST** be the **raw request body exactly as received**. It **MUST NOT** be parsed, re-serialised, pretty-printed, re-encoded or cast before verification. **`[RZP]`** — *"ensure that the webhook body passed as an argument is the **raw webhook request body**. **Do not parse or cast the webhook request body**"* |
| **`ITG-FR-013`** | Comparison of computed and received signature **MUST** use a **constant-time** comparison. **`[LIB]`** — a general security obligation, not a provider value; Razorpay publishes no comparison rule |
| **`ITG-FR-014`** | During and after a webhook-secret rotation, verification **MUST** be attempted against the **previous** secret as well as the current one, for as long as older events may still be retried. **`[RZP]`** — *"If you have changed your webhook secret, remember to use the old secret for webhook signature validation while retrying older requests. Using the new secret will lead to a signature mismatch"* |
| **`ITG-BR-006`** | ⛔ **Verification precedes everything.** A delivery that fails `ITG-FR-011` **MUST** be rejected **before** its body is parsed for business meaning, **before** any `BC-05` interaction, and **before** any state is written other than an audit record of the rejection |
| **`ITG-BR-007`** | The webhook secret **MUST** be held only by the integration adapter and **MUST NOT** be readable by, or passed into, `BC-05` or any domain module — `PRD-008` `FEE-XC-005` |
| **`ITG-INV-002`** | **No** delivery may produce **any** effect visible to `BC-05` unless `ITG-FR-010`–`ITG-FR-014` succeeded first. **This invariant is the wire-side half of verification-before-recording**; the financial half is `PRD-008`'s and is **not** restated here |
| **`ITG-XC-003`** | **Excluded:** accepting an unsigned delivery, a delivery with a missing signature header, or any "trusted source IP" bypass of `ITG-BR-006`. Reachability (`ITG-BR-003`) is a network precondition, **never** an authentication substitute |

> **`ITG-INV-002` is a transport invariant and is deliberately narrower than it could be written.** It says nothing
> about *what* `BC-05` must then do — that is `FEE-FR-028`, `FEE-BR-014`, `FEE-BR-016` and `FEE-AC-085`…`089`, which
> this document **cites and does not copy** (§3). A verified webhook is still only **evidence**.

---

### 4.4 Replay protection and idempotency — **`[RZP]` identifier, `[LIB]` window**

| ID | Requirement |
|---|---|
| **`ITG-FR-015`** | The dedup identity of a delivery **MUST** be taken from the **`x-razorpay-event-id`** request header, whose value is **unique per event**. **`[RZP]`** — *"You can identify the duplicate webhooks using the `x-razorpay-event-id` header. The value for this header is unique per event"* |
| **`ITG-FR-016`** | Before processing, the receiver **MUST** check whether `(tenant, x-razorpay-event-id)` has already been processed; if so it **MUST** take **no** new action and **MUST** return **`2xx`** (`ITG-FR-019`). **`[RZP]`-derived** — duplicates are expected: *"Razorpay follows at-least-once delivery semantics"* |
| **`ITG-FR-017`** | Processed event identities **MUST** be retained for at least **30 days**. **`[LIB]`** — chosen as the **smallest** value that strictly exceeds both published provider windows: retries continue for **24 hours**, and a support-initiated replay may resend an event up to **15 days** old. Not a Razorpay-published value; **derived from two of them, and the derivation is stated so it can be checked** |
| **`ITG-FR-018`** | Dedup records **MUST** be partitioned by tenant. A `x-razorpay-event-id` seen for one tenant **MUST NOT** suppress processing for another |
| **`ITG-INV-003`** | For a given tenant, an inbound event identity **MUST NOT** cause more than one attempt to record evidence with `BC-05` — regardless of how many times the provider delivers it |
| **`ITG-INV-004`** | Every dedup record, evidence record and audit record written by this contract **MUST** carry the resolved tenant, and a delivery whose tenant **cannot** be resolved **MUST** be rejected under `ITG-FR-025` rather than defaulted to any tenant |
| **`ITG-BR-008`** | Idempotency here is **transport-level de-duplication only**. It **MUST NOT** be presented as, relied on as, or substituted for `PRD-008`'s payment-side duplicate protection, which `FEE-BR-016` assigns to `BC-05` — *"Enforcement of payment-side duplicate protection is **this module's responsibility**"*. **Two layers, two owners, deliberately not merged** |
| **`ITG-XC-005`** | **Excluded:** using a timestamp tolerance on `created_at` as the *primary* replay defence, or rejecting a delivery **solely** because `created_at` is old. The provider replays events up to **15 days** old on request, so an age-based rejection would discard legitimate deliveries |

> **Why there is no "replay window" in the signature sense, stated rather than silently omitted.** `ADR-0040` §4 L165
> lists *"replay window"* as one of the five elements, and the honest finding is that **Razorpay publishes no signed
> timestamp to bound**: its documented replay defence is the **event-id dedup** above. So the element **is** answered —
> by `ITG-FR-015`–`ITG-FR-018` — and the retention period in `ITG-FR-017` is the *closest true thing* to a window.
> **Inventing a signed-timestamp tolerance that the provider does not send would have looked more complete and been
> false.**

---

### 4.5 Retry and failure handling — **`[RZP]`**

| ID | Requirement |
|---|---|
| **`ITG-FR-019`** | The route **MUST** return an HTTP **`2xx`** status when, and only when, it has durably accepted the event. **`[RZP]`** — *"Razorpay considers any non-2xx response as an event delivery failure. Please make sure the API responds with 2xx when you successfully consume the event at your end"* |
| **`ITG-FR-020`** | The route **MUST** respond **within 5 seconds**. **`[RZP]`** — *"There could be situations where your server accepts the event but fails to respond in 5 seconds. In such cases, the session is marked timeout … and is sent again"* |
| **`ITG-FR-021`** | To satisfy `ITG-FR-020`, processing **MUST** be split: verification (§4.3), dedup (§4.4) and **durable persistence of the evidence** happen **inside** the response window; any further work — including the `BC-05` interaction of `ITG-BR-010` — **MAY** proceed asynchronously **after** the `2xx`. **`[LIB]`** design, forced by the `[RZP]` 5-second limit |
| **`ITG-FR-022`** | The receiver **MUST NOT** implement its own outbound re-delivery or polling loop for a failed inbound delivery. Retry is the **provider's**: *"we retry the delivery in exponential backoff policy for **24 hours** after event creation timestamp"*. **`[RZP]`** |
| **`ITG-FR-023`** | The platform **MUST** detect and alert on **webhook disablement**. After **24 hours** of continuous failure the provider **disables** the webhook, and re-enabling is a **manual Dashboard action**. **`[RZP]`** — *"If the webhooks continue to fail for 24 hours, the webhook is disabled. You need to enable the webhook from the Dashboard after fixing the errors at your end"* |
| **`ITG-FR-024`** | A **Alert Email Address** **MUST** be configured at webhook setup so disablement is notified. **`[RZP]`** — *"you are notified on your **Alert Email Address** as configured during webhook setup"* |
| **`ITG-FR-025`** | A delivery that fails verification (§4.3) or whose tenant cannot be resolved **MUST** be rejected with a **non-`2xx`** status and recorded in an audit log with the reason, the event id if readable, and **no** payload secret |
| **`ITG-BR-009`** | Returning `2xx` **MUST NOT** be used to suppress a genuine processing failure. If evidence cannot be durably persisted, the route **MUST** return non-`2xx` so provider retry applies — the platform **MUST NOT** silently absorb an event it did not store |
| **`ITG-XC-006`** | **Excluded from V1:** a dead-letter queue, an operator replay console, and any platform-side re-delivery mechanism. The 24-hour provider retry plus the disablement alert (`ITG-FR-023`) is the V1 failure path. ⚠ **The residual is named, not hidden** — see `ITG-GAP-001` |
| **`ITG-XC-007`** | **Excluded from V1:** treating the webhook as the *only* confirmation path. The provider recommends API verification for time-critical flows, and `PRD-008`'s reconciliation obligation (`FEE-FR-032`) already exists — **this document adds no financial reconciliation rule of its own** |

---

### 4.6 Required webhook events — **`[RZP]` names, `[LIB]` selection, kept minimal**

Per rule 8 the set is the **minimum that makes V1 work**, and each inclusion carries the reason it cannot be dropped.

| ID | Event | Required? | Why — and what would break without it |
|---|---|---|---|
| **`ITG-FR-026`** | **`payment.captured`** | ✅ **MUST subscribe** | The **only** event that means money is captured for a payment. It is the evidence `BC-05` verifies before confirming. **`[RZP]`** — *"Triggered when a payment is successfully captured"* |
| **`ITG-FR-027`** | **`payment.failed`** | ✅ **MUST subscribe** | Without it a failed attempt is indistinguishable from a slow one, and the payment sits `PENDING` forever. **`[RZP]`** — *"Triggered when a payment fails"* |
| **`ITG-FR-028`** | **`payment.authorized`** | ✅ **MUST subscribe** | Authorisation ≠ capture. This is the provider's **documented** remedy for the late-authorised payment whose client-side response was lost — *"Capturing payments for which you did not receive a response on the client-side is perhaps the most important use case for the `payment.authorized` event"*. ⚠ It **MUST NOT** be treated as money received (`ITG-BR-011`) |
| **`ITG-XC-008`** | **`order.paid`** | ⛔ **NOT subscribed in V1** | It would deliver the **same** capture fact a second time. Razorpay documents the difference precisely: `payment.captured` *"only contains the payment entity"*, while `order.paid` *"includes both order and payment entities"*. V1 needs the payment entity, which `ITG-FR-026` already carries — a second event for the same money is a **duplicate evidence path**, not extra safety |
| **`ITG-XC-009`** | `payment.downtime.started` / `.resolved` / `.updated` | ⛔ **NOT subscribed in V1** | Operational telemetry about the provider's payment methods. It settles nothing financial and V1 has no consumer for it |
| **`ITG-XC-010`** | Refund, settlement, subscription, invoice and dispute events | ⛔ **NOT subscribed in V1** | `PRD-008` places refunds outside V1 and the EA lists `Refund Management (V2)`. Subscribing to an event no V1 requirement consumes would be scope this document has no authority to add |
| **`ITG-BR-010`** | — | — | For **every** subscribed event, the adapter's only permitted action toward money is to **hand verified evidence to `BC-05`** through the existing `business.payment_intent` port path (Dependency Matrix row **`X-03`**). It **MUST NOT** write a payment, receipt, ledger entry or balance itself |
| **`ITG-BR-011`** | — | — | `payment.authorized` **MUST** be delivered to `BC-05` as **authorisation evidence**, explicitly distinct from capture evidence. The wire layer **MUST NOT** decide whether to capture: that is a financial decision and it is `BC-05`'s |
| **`ITG-INV-005`** | — | — | The adapter **MUST NOT** derive, infer or synthesise a payment state that no subscribed event reported. Absence of an event is **not** evidence of anything |

> ⚠ **A provider setting this contract depends on and does NOT control.** Razorpay's **Payment Capture** setting
> decides whether an authorised payment is auto-captured, and its documentation states that uncaptured authorised
> payments *"will be refunded automatically"* after the configured period. **That setting is a merchant/provider
> configuration act, not a wire value**, so it is **not** specified here and **no configuration identifier is
> created** (rule 7). It is recorded as **`ITG-GAP-002`** so the dependency is visible rather than assumed.

---

### 4.7 What this section deliberately does NOT do

| Not done | Why |
|---|---|
| **No financial rule is created, restated or weakened** | `BC-05` owns money (§3). This section asserts transport and evidence obligations only. `FEE-BR-014`, `FEE-BR-016`, `FEE-FR-028`, `FEE-INV-005`, `FEE-FR-032` and `FEE-AC-085`…`089` are **cited, never copied** |
| **`PRD-008` is byte-unchanged and NOT frozen** | Rule 1 and rule 10. Nothing here requires a `PRD-008` edit; the `FEE-GAP-010` Status transcription remains a `PRD-008` document-owner act (`ADR-0046` §6.2) |
| **No new bounded context, edge, permission, config ID, provider or API architecture** | Rule 7. Count stays **31**; ingress remains the existing `platform/business` capability (§2.1); the outbound call path is the **existing** `business.payment_intent` port (`X-03`); `ITG-FR-004`'s mode separation and `ITG-BR-003`'s IP reachability are **deployment facts**, not new configuration identifiers |
| **No Razorpay IP list, SDK name, package, API version or credential value** | `ITG-XC-004`. These change on the provider's schedule; transcribing them creates a stale copy that a reader may trust |
| **No signed-timestamp replay window** | §4.4 — the provider sends none. The element is answered by event-id dedup instead |
| **No dead-letter queue or replay console** | `ITG-XC-006`, and the residual is named as `ITG-GAP-001` |
| **The wider `BC-31` scope is still unwritten** | §7. This is the payment webhook slice only |

### 4.8 `Q-B31` — **✅ CLOSED**

| Field | Value |
|---|---|
| **Question** | Author the payment-webhook wire contract — endpoint, payload schema, signature algorithm, replay window, retry policy |
| **Opened by** | `ACCEPTED` `ADR-0042` §8, routed to *"the `BC-31` owner"* |
| **State** | ✅ **CLOSED at v0.2.** All five `ADR-0040` §4 L165 elements are specified above, plus the event set: endpoint §4.1 · schema §4.2 · signature §4.3 · replay §4.4 · retry §4.5 · events §4.6 |
| **What closed it** | The provider decision (`ACCEPTED` `ADR-0046`) supplying the prerequisite, and **the provider's own published documentation** supplying the values (§4.9) |
| **⚠ Honest scope of the closure** | `Q-B31` asked for the **contract**, and the contract exists. It does **not** mean the feature is built, reviewed or frozen: `PRD-019` Stage 3 has **not** been performed and Stage 4 has **not** been run (§6). **`Q-B31` closing is a specification delivered, not a stage passed** |
| **Residual, named not hidden** | **`ITG-GAP-001`** (no dead-letter/replay path in V1) and **`ITG-GAP-002`** (dependency on the provider's Payment Capture setting) — §7 |

### 4.9 Provider source citations — every `[RZP]` value, traceable to its published origin

Rule 2 requires verification before writing; this table is the record of it. Each value below was read from
Razorpay's published documentation at the cited page **during the pass that wrote this section**.

| Value used | Verified wording | Page |
|---|---|---|
| POST + JSON transport (`ITG-FR-002`) | *"Razorpay sends an HTTP POST request with JSON payload to your configured endpoint URL"* | About Webhooks |
| Ports 80/443 only (`ITG-FR-003`) | *"Webhook URLs must use ports 80 or 443 only"* | About Webhooks |
| Public URL, no localhost (`ITG-FR-003`) | *"webhook delivery requires a public URL"* | Validate & Test |
| Test/Live URL separation (`ITG-FR-004`) | *"configure separate URLs for Live mode and Test mode"* | About Webhooks |
| IP reachability (`ITG-BR-003`) | *"Ensure Razorpay webhook IPs are whitelisted on your server"* | About Webhooks |
| TLS 1.2+ (`ITG-BR-001`) | *"does not support the older versions of TLS 1.0 and 1.1"* | Best Practices |
| Signature header (`ITG-FR-010`) | *"passed with each request under the `X-Razorpay-Signature` header"* | Validate & Test |
| HMAC-SHA256, secret as key, body as message (`ITG-FR-011`) | *"calculated using HMAC with SHA256 algorithm; with your webhook secret set as the key and the webhook request body as the message"* | Validate & Test |
| Raw body, do not parse (`ITG-FR-012`) | *"ensure that the webhook body passed as an argument is the **raw webhook request body**. Do not parse or cast"* | Validate & Test |
| Old secret during rotation (`ITG-FR-014`) | *"remember to use the old secret for webhook signature validation while retrying older requests"* | Validate & Test |
| Dedup header (`ITG-FR-015`) | *"identify the duplicate webhooks using the `x-razorpay-event-id` header. The value for this header is unique per event"* | Validate & Test |
| At-least-once delivery (`ITG-FR-016`) | *"Razorpay follows at-least-once delivery semantics"* | Best Practices |
| Non-2xx = failure (`ITG-FR-019`) | *"Razorpay considers any non-2xx response as an event delivery failure"* | Best Practices |
| 5-second response window (`ITG-FR-020`) | *"fails to respond in 5 seconds. In such cases, the session is marked timeout"* | Best Practices |
| Exponential backoff, 24 hours (`ITG-FR-022`) | *"we retry the delivery in exponential backoff policy for 24 hours after event creation timestamp"* | Best Practices |
| Disablement after 24 h, manual re-enable (`ITG-FR-023`) | *"If the webhooks continue to fail for 24 hours, the webhook is disabled. You need to enable the webhook from the Dashboard"* | Best Practices |
| Alert Email Address (`ITG-FR-024`) | *"you are notified on your **Alert Email Address** as configured during webhook setup"* | Best Practices |
| Envelope + `payload.payment.entity` + field list (`ITG-FR-005`…`008`) | published `payment.captured` sample payload | Payments Payloads |
| Snapshot semantics (`ITG-FR-009`) | *"The payload for a Webhook is a snapshot of the entity when the event occurred"* | Payments Payloads |
| Order not guaranteed (`ITG-BR-004`) | *"The above order may not be followed at all times"* | Validate & Test |
| Event names (`ITG-FR-026`…`028`) | `payment.authorized`, `payment.captured`, `payment.failed` | Payments Payloads |
| `order.paid` payload difference (`ITG-XC-008`) | *"This payload only contains the payment entity"* vs *"includes both order and payment entities"* | Payments Payloads |
| Downtime events (`ITG-XC-009`) | `payment.downtime.started` / `.resolved` / `.updated` | Payments Payloads |
| Late-authorised capture use case (`ITG-FR-028`) | *"perhaps the most important use case for the `payment.authorized` event"* | About Webhooks |
| 15-day replay ceiling (`ITG-FR-017`, `ITG-XC-005`) | support-initiated replay limited to events up to 15 days old | Webhooks FAQs |
| Auto-refund of uncaptured authorised payments (`ITG-GAP-002`) | *"payments that are not captured within this period will be refunded automatically"* | Payment Capture Settings |

⚠ **The one value that is NOT in this table, and must not be looked for in it: the route path.** Razorpay publishes
**no** path — only the constraints in rows 2–5 above. `ITG-FR-001` is therefore marked **`[LIB]`**, and §4.0 states
why calling it a provider value would be a false citation.

#### 4.9.1 The exclusion that keeps this table from rotting

| ID | Requirement |
|---|---|
| **`ITG-XC-004`** | **Excluded:** transcribing Razorpay's webhook **IP address list**, SDK/package names, API versions or any credential value into this document. Each is provider-controlled and changes on their schedule; a copy here would become a stale value that a reader trusts. They are read from the provider's live documentation at implementation time (`ITG-BR-003`) |

### 4.1 `Q-B31` does not block `PRD-008`, and the reason is a precedent rather than a convenience

`PRD-008` reaches its own boundary and stops. It specifies **its** obligation — verification — and it is
**testable**: `FEE-FR-028` carries `FEE-AC-085`…`089`, none of which names a wire element. The wire contract is
**another context's obligation**, and `PRD-008`'s **established disposition** for exactly that shape is
*"BLOCKS the **feature**, not this PRD"* — used at `FEE-GAP-013`, `FEE-GAP-014` and `FEE-GAP-017`, each of which
routes an obligation to `BC-20`, the Authorization owner or `PRD-022` without blocking `BC-05`.

⚠ **The honest statement of consequence:** the **feature** — an end-to-end gateway payment confirmed by webhook
— **cannot be built** until `Q-B31` is answered. **Creating this document did not make the platform buildable.**
It made the outstanding work *attributable*, which is the whole of what it claims.

---

## 5. Registers — reserved, and empty

| Register | Prefix | Range | Issued |
|---|---|---|---|
| Functional requirements | `ITG-FR-*` | **`ITG-FR-001` … `ITG-FR-028`** | **28** |
| Business rules | `ITG-BR-*` | **`ITG-BR-001` … `ITG-BR-011`** | **11** |
| Invariants | `ITG-INV-*` | **`ITG-INV-001` … `ITG-INV-005`** | **5** |
| Exclusions | `ITG-XC-*` | **`ITG-XC-001` … `ITG-XC-010`** | **10** |
| Open questions | `ITG-GAP-*` | **`ITG-GAP-001` … `ITG-GAP-002`** | **2** |
| Acceptance criteria | `ITG-AC-*` | *not yet published* | **0** — ⛔ see the Stage 4 note below |
| **Total** | | | **56** (54 obligation-bearing + 2 `ITG-GAP-*`) |

**Every range is contiguous from `001` to its stated maximum, and the figures above are computed rather than
asserted** — the failure mode this repository has already suffered twice (`TRACEABILITY_MATRIX.md` finding `SR-01`,
and `PRD-006` v1.0 publishing *"100% coverage"* against a true 49.1%).

⚠ **`ITG-AC-*` is published as EMPTY, and that is a real Stage 4 shortfall rather than a formatting choice.** Every
one of the 54 obligations above is written to be testable, but **not one acceptance criterion is authored**, so
nothing here is *verified* in the sense `PRD-008` §0.2 uses — *"verified **iff** the identifier appears in an
`…-AC-*` **Verifies** column — prose never counts"*. Stating a coverage figure would therefore be false: it is
**0/54 = 0%**. Authoring the criteria is the next act on this document (§7, `Q-B31-AC`), and **§6 records Stage 4 as
NOT RUN because of it** — the register is not padded to make the section look finished.
**The prefix was collision-checked before reservation**, per `PRD_LIFECYCLE.md` §5 rules 2 and 3: `ITG-` occurs
**0 times** repository-wide. **`INT-*` was considered and refused** — `Student_Identity_PRD_v1.md` §4.16 owns
`SID-INT-1`…`SID-INT-12`, so a bare `INT-12` would be a grep collision with `SID-INT-12`. Per §5 rule 3, *"on
collision, change the new prefix, never the existing one"* — so the **new** prefix moved.

✅ **Ranges are published at v0.2, in the same pass that issues the first identifier — exactly as v0.1 undertook.**
v0.1 withheld them because *"publishing a range with zero members would make it false"* (`PRD_LIFECYCLE.md`
Stage 2 rule 3: *"Ranges are contiguous. A gap makes the published range false."*). The condition that justified
withholding them has now been removed by issuing the identifiers, so the undertaking is **kept, not quietly
dropped**. `ITG-AC-*` remains unpublished for the same reason it was before: it still has zero members.

---

## 6. Lifecycle position — measured against the gates, not claimed

| Stage | Verdict |
|---|---|
| **Stage 1 — Discovery** | ✅ **PASSED.** `BC-31` is a context in the BC Map (**L140**) and is **not owned by another PRD** — `PRD_REGISTRY.md` §6 records no competing claim. It owns outbound contracts and idempotent delivery, so it is not a presentation composition. Release **V1** on Master PRD **L638** |
| **Stage 2 — Draft** | ✅ **PASSED at v0.2.** The version/status header exists, the prefix is collision-checked, and the gate's remaining requirement — *"identifier registers declared up front **with ranges**"* — is now met: §5 publishes **five ranges, each contiguous from 001**, covering **56** identifiers. This is the one verdict this pass upgrades, and it is upgraded because the stated deficiency was removed, not reinterpreted |
| **Stage 3 — Architecture Review** | ⛔ **NOT PERFORMED.** No alignment record exists |
| **Stage 4 — Requirements Review** | ⛔ **NOT PERFORMED — but no longer BLOCKED.** `Q-B31` is closed (§4.8), so 54 testable obligations now exist where there were none. It is **not** run for two measurable reasons: **(a)** Stage 3 has not been performed, and Stage 4 follows it; **(b)** `ITG-AC-*` is **empty**, so coverage is **0/54** and there is nothing to review *against*. ⚠ **The blocker changed identity rather than disappearing** — it was *"no requirement to test"*, it is now *"no criterion to test with"* (`Q-B31-AC`, §7) |
| **Stage 5 — Traceability** | ⛔ **NOT REACHED, and deliberately not attempted.** The gate requires prefixes *"registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically"*. The `ITG-*` registration **is** added by this pass so the identifiers are not left registered nowhere, but Stage 5 also demands the traceability *coverage* that `ITG-AC-*` cannot yet supply. **Registration performed; the stage is NOT claimed** |
| **Stage 6 — Implementation tasks** | ⛔ **NOT REACHED.** No `IMPL-*` range is allocated by this pass, `docs/40-implementation/integration/` does not exist, and this document allocates **0 numbered `IMPL-nnn` identifiers** — the token `IMPL-` does appear here, but only as the wildcard `IMPL-*` in sentences *denying* an allocation and as the literal `IMPL-nnn` in this sentence, so the claim is stated as **zero allocations**, never as *"zero tokens"*. ⚠ **This wording is deliberately count-free.** An earlier draft of this row asserted a hard `grep` total, which was **unstable by construction** — the correcting sentence contains the token it counts, so writing the number changed the number, and the asserted figure was stale the moment it was saved. A claim that cannot survive its own publication is not a measurement; the invariant distinction (**numbered allocation** vs **wildcard reference**) is asserted instead. ⚠ **The looser wording was in this section's own first draft and was corrected by measurement** — the `GCP-01` self-falsifying-statement class this repository tracks. `PRD_LIFECYCLE.md` Stage 6 rule 1 — *"Never reuse or reassign a number"* — means an allocation is not something to make speculatively |
| **Stages 7–9** | ⛔ **NOT REACHED** |
| **Freeze** | ⛔ **NOT FROZEN, and not a candidate.** Freeze is *conferred* by a row in `DOCUMENTATION_BASELINE.md` §3 (`PRD_LIFECYCLE.md` Stage 7), and **this document has no such row and does not request one** |

---

## 7. Open items

| ID | Item | Owner | State |
|---|---|---|---|
| **`Q-B31`** | Author the payment-webhook wire contract (§4) | **`BC-31` owner** | ✅ **CLOSED at v0.2** — §4.8 |
| **`Q-B31-AC`** | **Author `ITG-AC-*` acceptance criteria for the 54 obligations in §4.** Coverage is **0/54** and Stage 4 cannot run without them (§6) | **`BC-31` owner** | ⛔ **OPEN** — the largest outstanding item on this document |
| **`ITG-GAP-001`** | **No dead-letter path, operator replay console or platform-side re-delivery exists in V1** (`ITG-XC-006`). If the provider's 24-hour retry window expires with the endpoint failing, the webhook is **disabled** by the provider (`ITG-FR-023`) and the affected events are recoverable **only** by a support-initiated replay of events ≤15 days old, or by `PRD-008`'s reconciliation (`FEE-FR-032`). **That is a thin V1 failure path and it is stated as thin** | **`BC-31` owner**, with **Architecture Owner** if a queue is introduced | ⛔ **OPEN — accepted risk for V1** |
| **`ITG-GAP-002`** | **This contract depends on the provider's Payment Capture setting, which it does not control.** Whether an authorised payment auto-captures — and therefore whether `payment.captured` (`ITG-FR-026`) ever fires for a given payment — is a merchant/provider configuration act. The provider documents that uncaptured authorised payments *"will be refunded automatically"* after the configured period. **No configuration identifier is created here** (rule 7); the dependency is recorded so it cannot be assumed away | **Architecture Owner** / merchant account owner | ⛔ **OPEN** |
| — | Specify `BC-31`'s remaining **BC Map L140** obligations: outbound third-party contracts in general, the wider credential lifecycle, **outbound** retry semantics, idempotent **outbound** delivery | **`BC-31` owner** | ⛔ **OPEN** — §4 specifies the **inbound payment webhook** slice only, and no identifier is minted for the remainder, because minting one would imply a specification that does not exist |
| — | Perform **Stage 3 architecture review** of §4 | **Architecture Owner** | ⛔ **OPEN** — §6 |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v0.2** | 2026-08-15 | **THE V1 PAYMENT WEBHOOK CONTRACT IS AUTHORED, AND `Q-B31` IS CLOSED — the act v0.1 assigned to this document but deliberately did not perform.** §4 replaces v0.1's *"deliberately NOT specified"* hole with the **minimum V1 contract**: route and transport (§4.1), payload schema (§4.2), signature verification (§4.3), replay protection and idempotency (§4.4), retry and failure handling (§4.5) and the required event set (§4.6) — all five elements `ACCEPTED` `ADR-0040` **§4 L165** assigns to the `BC-31` owner, plus the events. **56 `ITG-*` identifiers are minted (0 → 56)** and §5 publishes **five contiguous ranges**, keeping v0.1's explicit undertaking to publish them *"in the same pass that issues the first identifier"*. **What made this lawful, and it was checked before writing rather than after:** the provider prerequisite was supplied by `ACCEPTED` [`ADR-0046`](../../00-governance/adr/ADR-0046-v1-payment-gateway-provider-razorpay.md) (**Razorpay**), and the *values* by **Razorpay's own published documentation**, which `ACCEPTED` `ADR-0045` §5.2 had named as the one missing input — *"that provider's own published webhook documentation, **which this repository does not contain**"*. **Every provider-specific value carries a citation in §4.9 (26 rows); not one was inferred, rounded or recalled.** ⚠ **The distinction §4.0 exists to prevent a reader from blurring:** Razorpay publishes **no route path** — only constraints on one (public URL, ports 80/443, TLS 1.2+, not blacklisted, IPs reachable) — so `ITG-FR-001`'s path is labelled **`[LIB]`**, a LIBOORA value *constrained by* the provider, and **presenting it as a provider value would have been a false citation dressed as compliance**. Two further values are labelled `[LIB]` on the same principle: `ITG-FR-013` (constant-time comparison — a security obligation the provider does not publish) and `ITG-FR-017` (**30-day** dedup retention — **derived**, with the derivation shown, as the smallest value exceeding both published windows, 24-hour retry and 15-day replay). ⚠ **One `ADR-0040` element is answered in a shape different from the one its name implies, and this is disclosed rather than smoothed over:** *"replay window"* has **no** signed-timestamp tolerance, because **Razorpay sends no signed timestamp to bound** — the documented defence is `x-razorpay-event-id` dedup, so §4.4 implements that and §4.4's closing note states plainly that *"inventing a signed-timestamp tolerance that the provider does not send would have looked more complete and been false."* **BOUNDARIES: `BC-05` remains the financial source of truth and this document asserts NO financial rule.** `FEE-BR-014`, `FEE-BR-016`, `FEE-FR-028`, `FEE-INV-005`, `FEE-FR-032` and `FEE-AC-085`…`089` are **cited and never copied** — `ADR-0040` **L166**'s second-source-of-truth bar — and **`PRD-008` is byte-unchanged and NOT frozen**. `ITG-BR-010` routes every money-touching action through the **existing** `business.payment_intent` port (Matrix row `X-03`); `ITG-BR-008` keeps transport dedup explicitly **separate from** `FEE-BR-016`'s payment-side duplicate protection, *two layers with two owners, deliberately not merged*; `ITG-INV-002` states the **transport half** of verification-before-recording and is deliberately narrower than the financial half; `ITG-FR-018`/`ITG-INV-004` make tenant partitioning explicit for dedup, evidence and audit records; `ITG-XC-001` keeps the vendor name out of the route, columns, event payloads and internal API contracts (`FEE-XC-006`, Matrix **L167**); `ITG-BR-007` keeps the webhook secret out of `BC-05` (`FEE-XC-005`); and inbound **ingress** remains a `platform/business` capability (§2.1) — **owning the contract is not owning the ingress**. **NOTHING NEW WAS CREATED beyond `ITG-*` requirement identifiers:** no bounded context (count stays **31**), no `E-*` edge, no port, no permission, no configuration identifier, no API architecture, no provider, no duplicated financial rule, no `IMPL-*` allocation and no Dart source change. ⚠ **THREE HONEST SHORTFALLS, stated because omitting them would make this entry a better advertisement and a worse record.** **(1)** `ITG-AC-*` is **EMPTY** — coverage is **0/54**, no obligation here is *verified* in the sense `PRD-008` §0.2 requires (*"prose never counts"*), and the successor item **`Q-B31-AC`** is opened in §7 for it. **(2)** **Stage 4 is NOT run and Stage 3 was NOT performed**, so §6 upgrades **only Stage 2** — PARTIAL → **PASSED**, and only because the exact stated deficiency (unpublished ranges) was removed. **`Q-B31`'s Stage 4 blocker changed identity rather than vanishing**: from *"no requirement to test"* to *"no criterion to test with"*. **(3)** Two residual gaps are **minted rather than buried** — **`ITG-GAP-001`** (V1 has **no** dead-letter queue, replay console or platform-side re-delivery; after the provider's 24-hour retry the webhook is **disabled** and recovery falls to a ≤15-day support replay or `FEE-FR-032` reconciliation — *a thin failure path, stated as thin*) and **`ITG-GAP-002`** (this contract **depends on** the provider's Payment Capture setting, which it does not control, and uncaptured authorised payments are auto-refunded by the provider). **Three defects in this pass's own first draft were caught by its own counting script and repaired, not shipped:** a claimed *"52 identifiers"* against a measured **56**, `ITG-GAP-001`/`002` referenced while **undefined**, and `ITG-XC-004` emitted as a **stray table row with no header** — the `SR-01` class of defect this repository already tracks, which is why the count is computed rather than asserted. **Recorded by** `ACCEPTED` [`ADR-0047`](../../00-governance/adr/ADR-0047-prd-019-v1-webhook-contract-authority.md). **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — no `DOCUMENTATION_BASELINE.md` §3 row is written or requested, and Rank 3 precedence is still **not held**. |
| **v0.1** | 2026-08-15 | **Created `DRAFT` under `ACCEPTED` [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md), for one purpose: to give the payment-webhook wire contract a lawful owner.** §2 assigns the five wire elements enumerated by `ACCEPTED` `ADR-0040` **§4 L165** to **`BC-31`**, **recognising** an allocation BC Map **L140**, `PRD_REGISTRY.md` **L309**, `PRD-022`'s `SAAS-XC-006` and Matrix `X-03` already make — **no context, edge, port, module, role, permission or configuration identifier is created**, and the context count stays **31**. §3 fixes the boundary against `PRD-008`: **`BC-31` owns the wire, `BC-05` owns the money**, ingress remains a `platform/business` capability per `ACCEPTED` `ADR-0035` §5.5b as upheld by `ADR-0040` §1, and **`PRD-008` is not restated, amended or duplicated**. ⛔ **The contract itself is NOT authored, and that is stated as a hole rather than concealed:** not one endpoint, URL, payload field, signature algorithm, header, replay window, retry count or provider name appears in this file, because writing them would require inventing an API, a schema and a provider. The outstanding work is **`Q-B31`** — an identifier **already opened and routed** by `ACCEPTED` `ADR-0042` §8, **not minted here** — and §4.1 records honestly that the end-to-end gateway-webhook **feature** remains unbuildable, so creating this document made the work *attributable*, not *done*. §5 reserves prefix **`ITG-*`** with **0 identifiers issued** after a collision check (`ITG-` = 0 repository-wide; **`INT-*` refused** because `SID-INT-1`…`12` already exist, per `PRD_LIFECYCLE.md` §5 rule 3 — *"change the new prefix, never the existing one"*), and deliberately **publishes no ranges**, because a range with no members is a false promise. §6 measures this draft against the gates and records **Stage 2 as PARTIAL, not passed**, for exactly that reason. **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — and no baseline row is requested. No frozen document was touched, no `ACCEPTED` ADR was altered, no checker was weakened, and no Dart source was written. |
