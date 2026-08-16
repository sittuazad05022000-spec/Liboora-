# PRD-019 — INTEGRATION (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-019_INTEGRATION.md` |
| **PRD** | `PRD-019` |
| **Module** | Integration |
| **Bounded Context** | **`BC-31` Integration** |
| **Classification** | `[GENERIC]` — Integration platform |
| **Release** | **V1** |
| **Version** | **v0.3 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT approved. NOT architecture-reviewed. NOT frozen.** Status is *conferred* by the register, never claimed by a document about itself; the `PLANNED` → `DRAFT` movement is recorded in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.2 by the Governance Owner under [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md) |
| **Date** | 2026-08-16 |
| **Baseline** | Written **against** `BASELINE-2026-08-05-A`. **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD) — **not held today**, because admission is a baseline act |
| **Owns** | Outbound third-party contracts, credentials, retries, idempotent delivery — **BC Map L140**, verbatim and unextended |
| **Identifier prefix** | **`ITG-*`** — **111 identifiers issued at v0.3** (54 obligation-bearing + **54 `ITG-AC-*`** + 3 `ITG-GAP-*`), every range **contiguous from 001**. **Counted by script, not asserted** — see §5 |
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

### 4.10 Acceptance criteria — `ITG-AC-001` … `ITG-AC-054`

**This section closes `Q-B31-AC`.** At v0.2 this register was published **EMPTY** and §6 recorded Stage 4 as not
runnable for exactly that reason: *"no criterion to test with"*. Every one of the **54** obligation-bearing
identifiers in §4.1–§4.6 now carries **exactly one** criterion.

> #### The three rules this register is built to satisfy, and how each is made structurally true rather than asserted
>
> | Rule | How it is enforced here |
> |---|---|
> | **Every requirement is testable** (Stage 4 check 1) | The map is **bijective**: 54 obligations, 54 criteria, one each. An uncovered obligation is therefore not merely absent — it is **arithmetically impossible** without the count changing, and §4.11 computes the count with a script |
> | **Every criterion maps to exactly one requirement** (Stage 4 check 4) | Each row's **Verifies** cell names **one** identifier. No criterion verifies two obligations, so an orphan cannot hide behind a shared row |
> | **No `PRD-008` rule is re-tested** (Stage 4 check 5, `ADR-0040` **L166**) | Every criterion below asserts a **transport or evidence** fact. **Not one asserts a financial outcome** — no ledger balance, no receipt, no due, no confirmation. Where a financial consequence is the real point, the criterion stops at the boundary and tests **that the handoff happened**, leaving what happens next to `FEE-AC-085`…`089`, which are **cited and never restated** |
>
> ⚠ **What "testable" is NOT taken to mean here.** Three criteria are satisfied by **static or configuration
> evidence** rather than a runtime assertion — `ITG-AC-013` (constant-time comparison), `ITG-AC-035` (secret not
> reachable from `BC-05`) and `ITG-AC-048` (no transcribed provider constants). That is deliberate and follows the
> repository's own precedent: Rank 4 BC Map enforces **`ID-1`** by *"Security review + schema scan in CI"*, not by a
> unit test. A timing-based test for constant-time comparison would be **flaky by construction**, and shipping a
> flaky test as proof is worse than naming the verification method honestly.

#### 4.10.1 Route and transport — verifies §4.1

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-001`** | `ITG-FR-001` | The deployed platform registers **exactly one** inbound payment-webhook route, and it answers at **`POST /webhooks/payments/gateway`**. A request to any other payment-webhook path returns **404**. The registered-route count is asserted as **`== 1`**, so a second route added later **fails** rather than silently coexisting |
| **`ITG-AC-002`** | `ITG-FR-002` | A `POST` with a JSON body is accepted for verification. `GET`, `PUT`, `PATCH` and `DELETE` on the route return **405**. A request carrying event data **only** in the query string with an empty body is rejected **non-`2xx`** and produces **no** evidence record |
| **`ITG-AC-003`** | `ITG-FR-003` | The configured webhook URL is `https` on port **443**. Startup/configuration validation **fails** for a URL that is `localhost`, `127.0.0.1`, a private-range host, or any port other than 443. ⚠ The rejection of port 80 is `ITG-BR-002`'s narrowing, verified by `ITG-AC-030`; this criterion tests only that the configured value satisfies both |
| **`ITG-AC-004`** | `ITG-FR-004` | Distinct route configuration and distinct webhook secrets exist for **Test** and **Live** mode. A delivery verified under the **Test** secret is marked test-mode and produces **no** record reachable by any production financial query path. A configuration in which the two modes share one secret **fails** validation |
| **`ITG-AC-029`** | `ITG-BR-001` | The endpoint negotiates **TLS 1.2** or **TLS 1.3**. A client offering **only** TLS 1.0 or only TLS 1.1 **fails** the handshake. Verified against the deployed listener, not against configuration intent |
| **`ITG-AC-030`** | `ITG-BR-002` | Port **80** does **not** accept a webhook payload for this route in any environment. Only **443** accepts. If 80 is bound at all it may only redirect, and a payload `POST`ed to 80 is **never** processed |
| **`ITG-AC-031`** | `ITG-BR-003` | Reachability is verified using the provider's **then-current published** source-IP list, **read from the provider's live documentation at test time** — never from a list copied into this repository (`ITG-XC-004`, `ITG-AC-048`). The deployment's security-group and firewall configuration is asserted to admit those ranges on 443 |
| **`ITG-AC-045`** | `ITG-XC-001` | **What must be impossible:** shipping the vendor's name in a route path, a database column name, a domain-event payload key or an internal API contract. An automated case-insensitive scan for the provider name across those four surfaces returns **zero** hits, and a deliberately introduced violation **fails CI**. ⚠ The name appearing in the `X-Razorpay-Signature` **request header** (`ITG-FR-010`) and in §4.9's citations is **not** a violation — those are the provider's own wire and its documentation, neither of which this platform names |

#### 4.10.2 Payload schema — verifies §4.2

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-005`** | `ITG-FR-005` | A delivery carrying `entity`, `account_id`, `event`, `contains`, `created_at` and `payload` is accepted. A delivery missing **`event`** is rejected as malformed with an audit record, and produces **no** evidence record and **no** `BC-05` interaction |
| **`ITG-AC-006`** | `ITG-FR-006` | For `contains: ["payment"]` the adapter reads the entity from **`payload.payment.entity`**. A delivery whose `contains` names an entity that is **absent** from `payload` is rejected as malformed — **never** defaulted, guessed, or read from a different key |
| **`ITG-AC-007`** | `ITG-FR-007` | Given the provider's **published `payment.captured` sample payload** (§4.9), the adapter extracts `id`, `order_id`, `amount`, `currency`, `status`, `method`, `captured`, `amount_refunded`, `fee`, `tax`, `error_code`, `error_description` and `notes` without error. ⚠ The sample is the fixture; **no field name in this criterion is invented, and none is added to the provider's list** |
| **`ITG-AC-008`** | `ITG-FR-008` | A delivery carrying **`null`** in `bank`, `fee`, `tax`, `token_id`, `vpa`, `wallet`, `refund_status` and `issuer`, **and** one additional field the adapter does not know, is processed successfully and answered **`2xx`**. An unknown or `null` optional field **never** causes a delivery failure |
| **`ITG-AC-009`** | `ITG-FR-009` | A `payment.authorized` snapshot showing `captured: false`, arriving **after** a capture has already been recorded, does **not** overwrite, downgrade or contradict the stored capture evidence. Each evidence record retains **its own** event `created_at`, and the store holds both snapshots rather than one mutable "current state" |
| **`ITG-AC-032`** | `ITG-BR-004` | Delivering `payment.captured` **before** `payment.authorized` for the same payment produces two correct evidence records, **no** error and **no** state regression. The test suite exercises the reversed order **deliberately**, because the provider states the documented order *"may not be followed at all times"* |
| **`ITG-AC-033`** | `ITG-BR-005` | An `amount` of `100` with `currency` `"SGD"` is handed to `BC-05` as the **integer `100`** together with `"SGD"`. Any division by 100, rounding, decimal cast or currency conversion at the wire boundary **fails** the criterion. ⚠ This tests **transport fidelity only**; what `BC-05` then does with the value is `PRD-008`'s and is not asserted here |
| **`ITG-AC-046`** | `ITG-XC-002` | **What must be impossible:** deriving financial state from the raw-payload store. No ledger balance, due, receipt or confirmation query reads the evidence table, and the evidence table is asserted to be **absent** from every financial read path. A query path added later that reads it **fails** the check |

#### 4.10.3 Signature verification — verifies §4.3

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-010`** | `ITG-FR-010` | The signature is read from **`X-Razorpay-Signature`**. A delivery carrying a **correct** HMAC value in any **other** header is **rejected**, proving the header name is not inferred from position or content |
| **`ITG-AC-011`** | `ITG-FR-011` | A body signed as **HMAC-SHA256** with the configured webhook secret as **key** and the request body as **message** verifies successfully. A body altered by a **single byte** — with the original signature retained — is **rejected**. A signature computed with a different secret is **rejected** |
| **`ITG-AC-012`** | `ITG-FR-012` | A body whose whitespace and key order are **non-canonical** verifies successfully, which is only possible if the **raw bytes as received** were used. Verification is performed on captured raw bytes, and a build in which the body is parsed, re-serialised, pretty-printed or re-encoded before verification **fails** |
| **`ITG-AC-013`** | `ITG-FR-013` | Signature comparison uses a **constant-time** primitive. Verified by **static check plus code review** — a mutation replacing it with `==` or a short-circuiting comparison **fails** the check. ⚠ **Deliberately not a timing test**: a statistical timing assertion is flaky by construction, and the repository's own precedent for this class is `ID-1`'s *"Security review + schema scan in CI"* |
| **`ITG-AC-014`** | `ITG-FR-014` | With a **previous** and a **current** webhook secret both configured, deliveries signed with **either** verify successfully. Once the previous secret's retention ends, a delivery signed with it is **rejected**. The window during which both are accepted covers the provider's retry period (`ITG-FR-022`) |
| **`ITG-AC-034`** | `ITG-BR-006` | With an **invalid** signature: instrumentation asserts **zero** business parses of the body, **zero** `BC-05` port calls, and **zero** state writes other than the rejection audit record of `ITG-FR-025`. Ordering is asserted by **observation**, not by reading the code's intent |
| **`ITG-AC-035`** | `ITG-BR-007` | The webhook secret is **not readable from `BC-05` or any domain module**. Verified by dependency and configuration scan: no domain module resolves the secret's configuration key, and a domain module that references it **fails** the boundary check. Aligns with `PRD-008` `FEE-XC-005`, which is **cited, not re-tested** |
| **`ITG-AC-047`** | `ITG-XC-003` | **What must be impossible:** acceptance on the strength of the sender's IP address. A delivery with a **missing** signature header is rejected. A delivery originating from a **genuine provider IP** but carrying an **invalid** signature is **also** rejected. No configuration flag exists that can disable verification for a trusted source |
| **`ITG-AC-048`** | `ITG-XC-004` | **What must be impossible:** a stale copy of a provider-controlled constant being trusted. A scan of this contract's artifacts finds **no** hardcoded provider IP list, SDK package pin, API version string or credential literal. Provider constants are read from the provider's live documentation or from configuration at run time |

#### 4.10.4 Replay protection and idempotency — verifies §4.4

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-015`** | `ITG-FR-015` | The dedup identity is derived from the **`x-razorpay-event-id`** header. Two deliveries carrying the same value resolve to **one** identity. A delivery in which the header is **absent** is rejected **non-`2xx`** with an audit record — **never** processed under a synthesised or derived identity, because an event that cannot be de-duplicated cannot satisfy `ITG-INV-003` |
| **`ITG-AC-016`** | `ITG-FR-016` | The first delivery of an event is processed exactly once. An identical redelivery produces **no** new evidence record and **no** new `BC-05` port call, and is answered **`2xx`** — so the provider stops retrying a duplicate rather than escalating it |
| **`ITG-AC-017`** | `ITG-FR-017` | A dedup record created at `T` is still present at **`T + 30 days`**, and a redelivery at `T + 29 days` is suppressed. ⚠ The criterion asserts the **floor** only. **No maximum retention is asserted**, because none is specified — see the Stage 4 check 3 finding in §6.1, which defers the ceiling to the retention-policy owner rather than inventing one here |
| **`ITG-AC-018`** | `ITG-FR-018` | The **same** `x-razorpay-event-id` presented under tenant **A** and tenant **B** is processed **twice** — once per tenant — producing two tenant-scoped records. A's dedup record **never** suppresses B's processing. Verified as a cross-tenant leak test, per `X-13`'s severity |
| **`ITG-AC-040`** | `ITG-INV-001` | A **uniqueness constraint** exists on `(tenant, provider_event_id)` **in the store**, not merely in application logic. Two concurrent identical deliveries produce **exactly one** record; the loser is rejected by the constraint. Asserted under real concurrency, because a check-then-write race is the failure this invariant exists to prevent |
| **`ITG-AC-042`** | `ITG-INV-003` | **N** redeliveries of one event identity produce **exactly one** evidence handoff attempt toward `BC-05`, for any N. Counted by instrumenting the port boundary |
| **`ITG-AC-043`** | `ITG-INV-004` | Every dedup, evidence and audit record carries a **non-null** resolved tenant. A delivery whose tenant cannot be resolved is rejected under `ITG-FR-025` and writes **no** record bearing a default, placeholder or fallback tenant. A schema-level `NOT NULL` on the tenant column is asserted |
| **`ITG-AC-036`** | `ITG-BR-008` | **The interface makes no duplicate-protection promise.** The payload handed across the port contains **no** field, flag or header asserting that payment-level uniqueness has been checked, and no `PRD-019` artifact documents one. ⚠ **Deliberately does not test `FEE-BR-016`.** That rule is `BC-05`'s and testing it here would create the second source of truth `ADR-0040` **L166** forbids; this criterion tests only that **this** layer claims nothing on `BC-05`'s behalf |
| **`ITG-AC-049`** | `ITG-XC-005` | **What must be impossible:** discarding a legitimate delivery for being old. A **valid, correctly signed, previously unseen** event whose `created_at` is **14 days** in the past is **accepted and processed**. No age-based rejection rule exists as a primary defence |

#### 4.10.5 Retry and failure handling — verifies §4.5

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-019`** | `ITG-FR-019` | **`2xx` if and only if durably accepted.** With the evidence store made to fail, the response is **non-`2xx`**. With it healthy, the response is **`2xx`** and the record is present after a process restart. **No** code path returns `2xx` without a durable record |
| **`ITG-AC-020`** | `ITG-FR-020` | Measured at the route, the **slowest** observed response under load completes in **under 5 000 ms**. A deliberately slowed downstream dependency does **not** extend the response beyond the window, because that work is asynchronous per `ITG-FR-021` |
| **`ITG-AC-021`** | `ITG-FR-021` | Verification, dedup and **durable persistence** all complete **before** the response is emitted; the `BC-05` port interaction occurs **after** it. Asserted by instrumenting both boundaries and comparing ordering — the port must **not** have been called at the moment the `2xx` was written |
| **`ITG-AC-022`** | `ITG-FR-022` | **No** platform-side scheduler, queue or job re-posts an inbound delivery. A component and configuration search for an inbound re-delivery loop returns **zero** results, and on failure the platform relies solely on the provider's retry |
| **`ITG-AC-023`** | `ITG-FR-023` | The provider's **Alert Email Address** resolves to a **monitored operational mailbox** (not an individual, not an unmonitored alias), and receipt of a disablement notification raises an **operational incident record**. ⚠ **Honest limit, stated in the criterion rather than behind it:** detection in V1 is **notification-driven, not programmatic**. The only provider API exposing a webhook `active` status that this pass could find published is documented under Razorpay's **Partner** APIs for sub-merchant accounts (`GET /v2/accounts/:account_id/webhooks`), whose availability to this account type is **not established** — so polling is **not** specified, and the residual is recorded as **`ITG-GAP-003`** instead of being invented |
| **`ITG-AC-024`** | `ITG-FR-024` | The webhook configuration carries a **non-empty** Alert Email Address. A configuration lacking one **fails** the pre-go-live checklist. ⚠ The provider does fall back to the account's own settings address, but a criterion resting on that fallback would be testing **the provider's** behaviour rather than **ours** |
| **`ITG-AC-025`** | `ITG-FR-025` | A delivery failing verification, or whose tenant cannot be resolved, returns **non-`2xx`** and writes an audit record containing the **reason** and the **event id if readable**. The record is asserted to contain **no** secret, **no** signature value and **no** full payload — a scan of the audit surface for those values returns **zero** hits |
| **`ITG-AC-037`** | `ITG-BR-009` | With persistence induced to fail, the route returns **non-`2xx`** so provider retry applies. **No** code path returns `2xx` from a caught persistence exception — asserted by fault injection, not by reading error-handling code |
| **`ITG-AC-050`** | `ITG-XC-006` | **What must be impossible:** the platform silently re-delivering an event to itself. **No** dead-letter queue, operator replay console or platform-side re-delivery component exists in the V1 deployment; a component inventory returns **zero**. ⚠ **This criterion does NOT close `ITG-GAP-001`.** It verifies that the **exclusion is honoured**; the gap records that the resulting failure path is **thin**, and only its named owners may close it |
| **`ITG-AC-051`** | `ITG-XC-007` | **What must be impossible:** a terminal outcome manufactured from webhook silence. With **no** webhook received, the adapter produces **no** evidence and **no** terminal state — it does not mark a payment failed, expired or unconfirmable. ⚠ The **existence** of an alternative confirmation path is `PRD-008`'s `FEE-FR-032`, **cited and not re-tested here** |

#### 4.10.6 Events and the money boundary — verifies §4.6

| ID | Verifies | Criterion |
|---|---|---|
| **`ITG-AC-026`** | `ITG-FR-026` | The active subscription set **includes `payment.captured`**, asserted against the provider's configured subscription rather than against a local constant. One captured delivery produces **exactly one** capture-evidence handoff |
| **`ITG-AC-027`** | `ITG-FR-027` | The subscription set **includes `payment.failed`**. A failed delivery produces failure evidence, so that a failed attempt is **distinguishable from a slow one** — the specific outcome `ITG-FR-027` exists to prevent |
| **`ITG-AC-028`** | `ITG-FR-028` | The subscription set **includes `payment.authorized`**. A delivery produces **authorisation** evidence, recorded under a type **distinct** from capture evidence |
| **`ITG-AC-038`** | `ITG-BR-010` | The adapter writes **no** payment, receipt, ledger entry or balance row — asserted at **schema-permission level**: the adapter's credentials have no write access to financial tables. Its only outbound money-touching call is the existing **`business.payment_intent`** port path (Matrix **`X-03`**). A direct financial write added later **fails** both the permission check and the boundary checker |
| **`ITG-AC-039`** | `ITG-BR-011` | Authorisation evidence is delivered with a type **distinct** from capture, and **no capture decision originates from the adapter** — asserted as **zero** outbound capture API calls from the wire layer, for **any** input. The decision is `BC-05`'s and this criterion proves only that the wire layer does not make it |
| **`ITG-AC-044`** | `ITG-INV-005` | **No** evidence record exists that no received event reported. There is no timer, inference, default or reconciliation path **inside this contract** that creates evidence in the absence of a delivery — asserted by review plus a test that an idle system with zero deliveries produces zero evidence records |
| **`ITG-AC-041`** | `ITG-INV-002` | **No** `BC-05`-visible effect occurs unless `ITG-FR-010`–`ITG-FR-014` succeeded first: **zero** port calls and **zero** evidence records for an unverified delivery, asserted under concurrency and on malformed input. ⚠ This is the **transport half** of verification-before-recording. The financial half is `PRD-008`'s and is **not** restated (§3) |
| **`ITG-AC-052`** | `ITG-XC-008` | **What must be impossible:** the same capture counted twice through a second event. `order.paid` is **absent** from the subscription set. Were it delivered regardless, it is answered **`2xx`** and produces **no** second capture evidence |
| **`ITG-AC-053`** | `ITG-XC-009` | **What must be impossible:** provider telemetry reaching financial state. The `payment.downtime.*` events are **absent** from the subscription set; if delivered, they are answered **`2xx`** and produce **no** evidence and **no** financial effect |
| **`ITG-AC-054`** | `ITG-XC-010` | **What must be impossible:** a refund, settlement, subscription, invoice or dispute action being triggered by a webhook in V1. Those events are **absent** from the subscription set; if delivered, they are answered **`2xx`** and produce **no** evidence, **no** financial effect and **no** refund action |

---

### 4.11 Coverage — computed, not asserted

| Measure | Value |
|---|---|
| Obligation-bearing identifiers in §4 | **54** (`ITG-FR-*` 28 + `ITG-BR-*` 11 + `ITG-INV-*` 5 + `ITG-XC-*` 10) |
| Obligations carrying **at least one** `ITG-AC-*` | **54** |
| **Coverage** | **54 / 54 = 100.0%** |
| `ITG-AC-*` issued | **54** — `ITG-AC-001` … `ITG-AC-054`, contiguous from 001 |
| Criteria verifying **more than one** obligation | **0** |
| Orphan criteria (verify nothing) | **0** |
| Criteria asserting a **financial** outcome | **0** |

⚠ **Why the coverage figure is stated as 100% here when this repository has been burned by exactly that claim.**
`PRD-006` v1.0 once published *"100% coverage"* against a true **49.1%**, and `TRACEABILITY_MATRIX.md` finding
`SR-01` records the same class. The difference is that this figure is **computed by script** over the register's own
rows and the map is **bijective by construction** — 54 obligations, 54 criteria, one **Verifies** identifier each —
so the two counts cannot drift without the script failing. **If the script is not run, the number should not be
trusted, and §6 records the run.**

⚠ **What 100% coverage does NOT mean, stated because the number invites the wrong inference.** It means every
obligation **has a criterion**. It does **not** mean any criterion has been **executed** — **0 of 54 are proven by a
passing test**, because no implementation exists (Stage 6 is not reached, `docs/40-implementation/integration/`
does not exist). This is the same distinction `PRD-007` was frozen under: *"`FROZEN`, not `VERIFIED`"*.

---

### 4.12 `Q-B31` does not block `PRD-008`, and the reason is a precedent rather than a convenience

`PRD-008` reaches its own boundary and stops. It specifies **its** obligation — verification — and it is
**testable**: `FEE-FR-028` carries `FEE-AC-085`…`089`, none of which names a wire element. The wire contract is
**another context's obligation**, and `PRD-008`'s **established disposition** for exactly that shape is
*"BLOCKS the **feature**, not this PRD"* — used at `FEE-GAP-013`, `FEE-GAP-014` and `FEE-GAP-017`, each of which
routes an obligation to `BC-20`, the Authorization owner or `PRD-022` without blocking `BC-05`.

⚠ **The honest statement of consequence:** the **feature** — an end-to-end gateway payment confirmed by webhook
— **cannot be built** until `Q-B31` is answered. **Creating this document did not make the platform buildable.**
It made the outstanding work *attributable*, which is the whole of what it claims.

---

## 5. Registers

| Register | Prefix | Range | Issued |
|---|---|---|---|
| Functional requirements | `ITG-FR-*` | **`ITG-FR-001` … `ITG-FR-028`** | **28** |
| Business rules | `ITG-BR-*` | **`ITG-BR-001` … `ITG-BR-011`** | **11** |
| Invariants | `ITG-INV-*` | **`ITG-INV-001` … `ITG-INV-005`** | **5** |
| Exclusions | `ITG-XC-*` | **`ITG-XC-001` … `ITG-XC-010`** | **10** |
| Open questions | `ITG-GAP-*` | **`ITG-GAP-001` … `ITG-GAP-003`** | **3** |
| **Acceptance criteria** | **`ITG-AC-*`** | **`ITG-AC-001` … `ITG-AC-054`** | **54** — ✅ §4.10 |
| **Total** | | | **111** (54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`) |

**Every range is contiguous from `001` to its stated maximum, and the figures above are computed rather than
asserted** — the failure mode this repository has already suffered twice (`TRACEABILITY_MATRIX.md` finding `SR-01`,
and `PRD-006` v1.0 publishing *"100% coverage"* against a true 49.1%).

✅ **`ITG-AC-*` is published with 54 members at v0.3, and the v0.2 shortfall it replaces is quoted rather than
deleted.** v0.2 recorded: *"`ITG-AC-*` is published as EMPTY … not one acceptance criterion is authored, so nothing
here is *verified* in the sense `PRD-008` §0.2 uses … it is **0/54 = 0%**."* That condition is **removed**: §4.10
authors **54** criteria, each naming **exactly one** obligation in its **Verifies** column, so every obligation is
now verified in the sense `PRD-008` §0.2 requires — *"verified **iff** the identifier appears in an `…-AC-*`
**Verifies** column — prose never counts"*. **Coverage is 54/54 = 100%, computed by script** (§4.11).

⚠ **What that 100% does NOT mean, stated here as well as in §4.11 because the number is the most misreadable
figure in this document.** It means every obligation **has a criterion**. It does **not** mean any criterion has
**passed** — **0 of 54 are proven by a passing test**, because no implementation exists. `PRD-007` was frozen under
the same distinction: *"`FROZEN`, not `VERIFIED`"*.
**The prefix was collision-checked before reservation**, per `PRD_LIFECYCLE.md` §5 rules 2 and 3: `ITG-` occurs
**0 times** repository-wide. **`INT-*` was considered and refused** — `Student_Identity_PRD_v1.md` §4.16 owns
`SID-INT-1`…`SID-INT-12`, so a bare `INT-12` would be a grep collision with `SID-INT-12`. Per §5 rule 3, *"on
collision, change the new prefix, never the existing one"* — so the **new** prefix moved.

✅ **Ranges are published at v0.2, in the same pass that issues the first identifier — exactly as v0.1 undertook.**
v0.1 withheld them because *"publishing a range with zero members would make it false"* (`PRD_LIFECYCLE.md`
Stage 2 rule 3: *"Ranges are contiguous. A gap makes the published range false."*). The condition that justified
withholding them has now been removed by issuing the identifiers, so the undertaking is **kept, not quietly
dropped**. ✅ **`ITG-AC-*`'s range is published at v0.3 on the identical principle** — it was withheld at v0.2
because it *"still has zero members"*, and it is published now because it has **54**, contiguous from `001`. The
rule was applied consistently in both directions rather than invoked only when it was convenient.

⚠ **`ITG-GAP-003` is minted by this pass** (§7). It is **not** an obligation and carries no criterion: gaps record
what is **unresolved**, and issuing a criterion for one would imply a specification that does not exist.

---

## 6. Lifecycle position — measured against the gates, not claimed

| Stage | Verdict |
|---|---|
| **Stage 1 — Discovery** | ✅ **PASSED.** `BC-31` is a context in the BC Map (**L140**) and is **not owned by another PRD** — `PRD_REGISTRY.md` §6 records no competing claim. It owns outbound contracts and idempotent delivery, so it is not a presentation composition. Release **V1** on Master PRD **L638** |
| **Stage 2 — Draft** | ✅ **PASSED at v0.2.** The version/status header exists, the prefix is collision-checked, and the gate's remaining requirement — *"identifier registers declared up front **with ranges**"* — is now met: §5 publishes **five ranges, each contiguous from 001**, covering **56** identifiers. This is the one verdict this pass upgrades, and it is upgraded because the stated deficiency was removed, not reinterpreted |
| **Stage 3 — Architecture Review** | ⚠ **RUN AT v0.3 — 6 of 6 checks MEASURED ALIGNED — and the stage verdict is NOT CONFERRED.** The gate's requirement, *"a written alignment record naming every conflict and its disposition"*, is met by [`PRD-019_ARCHITECTURE_ALIGNMENT.md`](PRD-019_ARCHITECTURE_ALIGNMENT.md): **3 conflicts** recorded with dispositions and **7 findings rejected with reasons**. ⛔ **Why this is not PASSED, and the reason is a role rather than a defect:** `PRD_LIFECYCLE.md` §6 assigns Stage 3 to the **architecture reviewer**, and `ADR-0047` **L183** confers only the **`BC-31` owner** role, for a **Stage 4** item. **Running the checks and conferring the stage are two acts**, and this pass performed only the first — *a green gate signed by the author of the thing being gated is not a gate*. The Architecture Owner's confirmation is carried in §7 |
| **Stage 4 — Requirements Review** | ⚠ **RUN AT v0.3 — 5 of 6 checks PASS, 1 check has a DEFERRED finding.** Both v0.2 reasons for not running it are gone: Stage 3 **has** now been run (row above), and `ITG-AC-*` is **no longer empty** — coverage is **54/54**, so there is something to review against. The six checks are measured in **§6.1**, mechanically where mechanically possible. ⛔ **Check 3 — *"every configurable has a default and a range"* — carries an open finding** (`ITG-FR-017` states a retention **floor** with **no ceiling**), **deferred with a reason and an owner** exactly as the gate permits, rather than closed by inventing a maximum. **The stage verdict is NOT CONFERRED**: `PRD_LIFECYCLE.md` §6 assigns Stage 4 to the **requirements reviewer** — see the Stage 3 row for the same distinction |
| **Stage 5 — Traceability** | ⛔ **NOT REACHED, and deliberately not attempted.** The gate requires prefixes *"registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically"*. The `ITG-*` registration **is** added by this pass so the identifiers are not left registered nowhere, but Stage 5 also demands the traceability *coverage* that `ITG-AC-*` cannot yet supply. **Registration performed; the stage is NOT claimed** |
| **Stage 6 — Implementation tasks** | ⛔ **NOT REACHED.** No `IMPL-*` range is allocated by this pass, `docs/40-implementation/integration/` does not exist, and this document allocates **0 numbered `IMPL-nnn` identifiers** — the token `IMPL-` does appear here, but only as the wildcard `IMPL-*` in sentences *denying* an allocation and as the literal `IMPL-nnn` in this sentence, so the claim is stated as **zero allocations**, never as *"zero tokens"*. ⚠ **This wording is deliberately count-free.** An earlier draft of this row asserted a hard `grep` total, which was **unstable by construction** — the correcting sentence contains the token it counts, so writing the number changed the number, and the asserted figure was stale the moment it was saved. A claim that cannot survive its own publication is not a measurement; the invariant distinction (**numbered allocation** vs **wildcard reference**) is asserted instead. ⚠ **The looser wording was in this section's own first draft and was corrected by measurement** — the `GCP-01` self-falsifying-statement class this repository tracks. `PRD_LIFECYCLE.md` Stage 6 rule 1 — *"Never reuse or reassign a number"* — means an allocation is not something to make speculatively |
| **Stages 7–9** | ⛔ **NOT REACHED** |
| **Freeze** | ⛔ **NOT FROZEN, and not a candidate.** Freeze is *conferred* by a row in `DOCUMENTATION_BASELINE.md` §3 (`PRD_LIFECYCLE.md` Stage 7), and **this document has no such row and does not request one** |

### 6.1 Stage 4 — the six checks, measured

**Measured at v0.3.** Checks 1, 2 and 4 are computed by script over §4.10's own rows; the script is the same one
that produced §4.11, so the two sections cannot disagree without it failing.

| # | Check | Verdict | Measurement |
|---|---|---|---|
| **1** | Every requirement testable | ✅ **PASS** | **54 of 54** obligations carry a criterion. **0 uncovered.** The gate's failure example is *"the system should be fast"* — the analogous risk here was `ITG-FR-020`'s 5-second limit, which is written as a **measured** assertion (*"the slowest observed response under load completes in under 5 000 ms"*), not as *"responds quickly"* |
| **2** | Every exclusion states what must be **impossible** | ✅ **PASS** | **10 of 10** `ITG-XC-*` criteria contain the phrase **"What must be impossible:"** and name the prohibited outcome — verified by script, not by reading. The gate's failure mode is *"an exclusion is not a deferral"*; each of the ten states a condition that must never hold, and the two genuine **deferrals** are `ITG-GAP-*` rows in §7, kept structurally separate from the exclusions |
| **3** | Every configurable has a default and a range | ⛔ **OPEN FINDING — DEFERRED, see below** | Three configurable values exist. Two are fully bounded. **`ITG-FR-017` is not** |
| **4** | Every acceptance criterion maps to a requirement | ✅ **PASS** | **0 orphans.** Each of the 54 rows names **exactly one** obligation; **0** obligations are verified twice. The map is **bijective**, so an orphan cannot hide behind a shared row |
| **5** | No requirement restates another PRD's | ✅ **PASS** | **13** distinct `FEE-*` identifiers are **cited**; a scan for an `ITG-*` obligation asserting a financial `MUST` (ledger, receipt, balance, invoice, refund amount) returns **NONE**. `PRD-008` is **byte-unchanged** (`d24832f33e600518`) |
| **6** | Business rules do not contradict Rank 1 | ✅ **PASS** | `MP-GBR-24` (financial truth) and `MP-GBR-08` (tenant partitioning) are both upheld, never narrowed: `ITG-BR-010`/`ITG-AC-038` keep financial state in `BC-05`, and `ITG-FR-018`/`ITG-INV-004`/`ITG-AC-018`/`ITG-AC-040`/`ITG-AC-043` enforce tenant scoping at schema, behaviour and absence level |

#### The check 3 finding, stated in full because a deferral without a reason is not a deferral

| Field | Value |
|---|---|
| **Finding** | **`ITG-FR-017` publishes a retention FLOOR and no CEILING.** It reads *"MUST be retained for **at least** 30 days"*. Its **default** is present and its **derivation** is shown — the smallest value strictly exceeding both published provider windows (24-hour retry, 15-day replay) — but *"at least 30 days"* **has no upper bound**, and the gate's failure text is *"unbounded configuration is a specification hole"* |
| **Why it is not closed here** | An **upper** bound on dedup-identity retention is a **data-retention and privacy** decision, not a webhook-transport one. It interacts with `ID-5` (retention under legal basis), the Data Privacy runbook, and storage cost — **none of which this document owns**. Razorpay publishes **no** maximum, so there is no provider value to cite. **Inventing "and at most 90 days" would satisfy the checker and specify a policy this role has no authority to set** — the exact failure this document's §4.0 labelling discipline exists to prevent |
| **Why it is not minted as an `ITG-GAP-*`** | The **floor** is specified and correct; what is missing is the **ceiling**, owned elsewhere. Minting an `ITG-*` identifier would imply `BC-31` owns a retention-policy decision it does not |
| **Owner** | **Architecture Owner** with the **Data Privacy / retention-policy owner** |
| **Reason for deferral** | Recorded above. `PRD_LIFECYCLE.md` Stage 4 gate: *"conflicts closed or explicitly deferred **with a reason and an owner**"* — this is deferred, **with both** |
| **Effect on the criterion** | `ITG-AC-017` asserts the **floor only**, and **says so in its own text**, so no reader can mistake it for a bounded specification |

⚠ **The two configurables that DO pass check 3, recorded so the finding is not read as systemic:** `ITG-FR-020`'s
response window is **exactly 5 seconds** — a provider-imposed ceiling, cited in §4.9, with no room for a range —
and `ITG-FR-004`'s Test/Live separation is an **enumerated** two-value configuration whose invalid states
(*shared secret across modes*) are specified to **fail validation** by `ITG-AC-004`.

---

## 7. Open items

| ID | Item | Owner | State |
|---|---|---|---|
| **`Q-B31`** | Author the payment-webhook wire contract (§4) | **`BC-31` owner** | ✅ **CLOSED at v0.2** — §4.8 |
| **`Q-B31-AC`** | **Author `ITG-AC-*` acceptance criteria for the 54 obligations in §4.** Coverage was **0/54** and Stage 4 could not run without them | **`BC-31` owner** | ✅ **CLOSED at v0.3** — §4.10 authors **`ITG-AC-001`…`ITG-AC-054`**, coverage **54/54** computed by script (§4.11). ⚠ **Closed as *authored*, not as *passing*** — **0 of 54** are proven by a passing test |
| **`ITG-GAP-003`** | **Webhook disablement is detected by NOTIFICATION, not programmatically, and V1 specifies no polling.** `ITG-FR-023` requires detection; the provider's documented signal is an **email** to the Alert Email Address (`ITG-FR-024`). The only published API exposing a webhook's `active` / `disabled_at` status that this pass could find is `GET /v2/accounts/:account_id/webhooks`, documented under the provider's **Partner APIs for sub-merchant accounts** — **whose availability to this account type is not established**. ⚠ **A polling rule was therefore NOT written.** Specifying a status poll against an endpoint this account may not be entitled to call would have produced a requirement that reads as complete and cannot be implemented — the §4.0 failure mode. **The residual is recorded instead of invented**, and `ITG-AC-023` states the limit inside the criterion rather than behind it | **Architecture Owner** / merchant account owner — **`BC-31` owner** may close it only if provider entitlement is established | ⛔ **OPEN** |
| **`ITG-GAP-001`** | **No dead-letter path, operator replay console or platform-side re-delivery exists in V1** (`ITG-XC-006`). If the provider's 24-hour retry window expires with the endpoint failing, the webhook is **disabled** by the provider (`ITG-FR-023`) and the affected events are recoverable **only** by a support-initiated replay of events ≤15 days old, or by `PRD-008`'s reconciliation (`FEE-FR-032`). **That is a thin V1 failure path and it is stated as thin** | **`BC-31` owner**, with **Architecture Owner** if a queue is introduced | ⛔ **OPEN — accepted risk for V1** |
| **`ITG-GAP-002`** | **This contract depends on the provider's Payment Capture setting, which it does not control.** Whether an authorised payment auto-captures — and therefore whether `payment.captured` (`ITG-FR-026`) ever fires for a given payment — is a merchant/provider configuration act. The provider documents that uncaptured authorised payments *"will be refunded automatically"* after the configured period. **No configuration identifier is created here** (rule 7); the dependency is recorded so it cannot be assumed away | **Architecture Owner** / merchant account owner | ⛔ **OPEN** |
| — | Specify `BC-31`'s remaining **BC Map L140** obligations: outbound third-party contracts in general, the wider credential lifecycle, **outbound** retry semantics, idempotent **outbound** delivery | **`BC-31` owner** | ⛔ **OPEN** — §4 specifies the **inbound payment webhook** slice only, and no identifier is minted for the remainder, because minting one would imply a specification that does not exist |
| — | **CONFER the Stage 3 verdict.** The six checks are **run and recorded** at v0.3 ([`PRD-019_ARCHITECTURE_ALIGNMENT.md`](PRD-019_ARCHITECTURE_ALIGNMENT.md), 6/6 measured ALIGNED), but the stage is assigned to the **architecture reviewer** by `PRD_LIFECYCLE.md` §6 and **this pass did not hold that role** | **Architecture Owner** | ⛔ **OPEN** — measurement done, **conferral outstanding** (§6) |
| — | **CONFER the Stage 4 verdict**, and resolve the **check 3** finding: `ITG-FR-017` publishes a retention **floor** with **no ceiling** (§6.1). A maximum was **not invented**, because retention policy is not this document's to set | **Requirements reviewer**; the ceiling itself to **Architecture Owner** + retention-policy owner | ⛔ **OPEN** — §6.1 |
| — | **Specify the `ID-1` / BC Map L140 credential boundary at Rank 4.** BC Map **L178** forbids a *"credential"* outside `BC-18`; **L140** grants `BC-31` *"credentials"*. Stage 3 check 5 measured ALIGNED on the **narrow** reading — a subject authentication factor is not a machine-to-machine signing key — **because the wide reading makes L140 unsatisfiable**. That reading is **derived, not published**, and only a Rank 1–5 change under a prior ADR can settle it (`DOCUMENTATION_BASELINE.md` §7 rule 1) | **Architecture Owner** | ⛔ **OPEN** — alignment record **A-2**. Deliberately **not** minted as an `ITG-GAP-*`: the under-specification is **Rank 4's**, and an `ITG-*` identifier would imply `BC-31` owns the fix |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v0.3** | 2026-08-16 | **THE 54 OBLIGATIONS BECOME TESTABLE, AND STAGE 3 AND STAGE 4 ARE RUN — `Q-B31-AC` IS CLOSED.** §4.10 authors **`ITG-AC-001`…`ITG-AC-054`**, one criterion for **each** of the 54 obligation-bearing identifiers in §4.1–§4.6, and §4.11 computes coverage at **54/54 = 100%**. **The map is bijective by construction** — 54 obligations, 54 criteria, exactly one identifier in each **Verifies** cell — so an **uncovered** obligation (Stage 4 check 1) and an **orphan** criterion (check 4) are not merely absent but **arithmetically impossible** without the script failing. Identifier count **56 → 111**. ⚠ **THE FIGURE MOST LIKELY TO BE MISREAD, AND IT IS LABELLED IN THREE PLACES:** *100% coverage* means every obligation **has a criterion**; it does **not** mean any criterion **passes**. **0 of 54 are proven by a passing test**, because no implementation exists — the distinction `PRD-007` was frozen under (*"`FROZEN`, not `VERIFIED`"*), and precisely the claim this repository has already got wrong once, when `PRD-006` v1.0 published *"100% coverage"* against a true **49.1%**. The number here is **computed by script over the register's own rows**, not asserted. **STAGE 3 IS RUN:** [`PRD-019_ARCHITECTURE_ALIGNMENT.md`](PRD-019_ARCHITECTURE_ALIGNMENT.md) measures all six checks against cited paths and lines — **6 of 6 ALIGNED**, with **3 conflicts disposed of** and **7 findings rejected with reasons**. Its most consequential finding is **A-1**: the `platform/integration` ingress reading that §2.1 already refuses would have put an **R5** adapter in dependency on the **R6** `business.payment_intent` port — an **`L2` violation** — which is a **stronger** reason for the refusal than the governance reason §2.1 gives, and is recorded so a future editor "simplifying" the adapter's location can discover that it breaks the rank ladder. **A-3** — no numbered `BC-31`↔`BC-05` edge exists — is closed by **existing** authority (`ADR-0035` **L610**, *"ingress needs none"*): the architecture asks for a **port** (`X-03`), and searching for an edge was the wrong instrument, the same diagnosis `PRD-008`'s own record reached. **STAGE 4 IS RUN** (§6.1): **5 of 6 checks PASS**, computed mechanically where possible — 10 of 10 exclusions state what must be **impossible**, 0 orphans, 0 double-verified obligations, and **no `ITG-*` obligation asserts a financial `MUST`**. ⛔ **THREE THINGS THIS PASS REFUSED TO DO, AND EACH REFUSAL COST SOMETHING:** **(1)** **Stage 3 and Stage 4 verdicts are NOT CONFERRED.** `PRD_LIFECYCLE.md` §6 assigns them to the **architecture reviewer** and the **requirements reviewer**; `ADR-0047` **L183** confers only the **`BC-31` owner** role, and only for a **Stage 4** item. **Running the checks and conferring the stage are two acts** — a green gate signed by the author of the thing being gated is not a gate — so §6 reads *MEASURED*, not *PASSED*, and §7 carries both conferrals as open. **(2)** **Stage 4 check 3 carries an OPEN finding rather than a fix:** `ITG-FR-017` publishes *"at least 30 days"* — a **floor with no ceiling**, and *"unbounded configuration is a specification hole"* is the gate's own failure text. Writing *"and at most 90 days"* would have turned the check green and **set a data-retention policy this role has no authority to set**; the provider publishes no maximum, so there was nothing to cite. It is **deferred with a reason and an owner**, which is what the gate permits, and `ITG-AC-017` asserts the **floor only** and **says so**. **(3)** **`ITG-GAP-003` is minted rather than papered over:** `ITG-FR-023` requires detection of webhook disablement, but the provider's documented signal is an **email**, and the only published status-bearing API found is a **Partner** API for sub-merchant accounts whose availability to this account type is **not established** — so **no polling rule was written**, because a requirement that reads as complete and cannot be implemented is worse than a recorded gap. ⚠ **`ITG-GAP-001` and `ITG-GAP-002` remain OPEN and were NOT closed.** `ITG-AC-050` verifies that `ITG-XC-006`'s exclusion is **honoured** and states in its own text that it **does not close `ITG-GAP-001`** — verifying an exclusion is not resolving the thinness of the failure path it creates. ⚠ **A pre-existing structural defect in this document's own v0.2 output was found and repaired rather than left:** there were **two** headings numbered `### 4.1` (the §4.1 route section and the §4.8 discussion subsection). The second is renumbered **`### 4.12`**, and a post-assertion now fails on any duplicate `### 4.x` heading line — disclosed here because a silent renumber changes section references without a record. ⚠ **Three criteria are verified by static or configuration evidence, not by a runtime assertion** — `ITG-AC-013` (constant-time comparison), `ITG-AC-035` (secret unreachable from `BC-05`), `ITG-AC-048` (no transcribed provider constants) — and **each states its verification method inside the criterion**. This follows Rank 4's own precedent: **`ID-1` is enforced by *"Security review + schema scan in CI"***, not by a unit test. A statistical timing assertion is **flaky by construction**, and shipping a flaky test as proof is worse than naming the method honestly. **BOUNDARIES UNCHANGED: `BC-05` remains the financial source of truth and no criterion asserts a financial outcome.** 13 `FEE-*` identifiers are **cited and never copied** (`ADR-0040` **L166**); `ITG-AC-036` tests only that this layer **makes no duplicate-protection promise** and explicitly **does not test `FEE-BR-016`**; `ITG-AC-051` stops at the boundary and leaves `FEE-FR-032` to `PRD-008`; **`PRD-008` is byte-unchanged (`d24832f33e600518`) and NOT frozen**. **NOTHING NEW WAS CREATED beyond `ITG-AC-*` and `ITG-GAP-003`:** no bounded context (count stays **31**), no `E-*` edge, no port, no permission, no configuration identifier, no API architecture, no provider value not already cited in §4.9, no numbered `IMPL-nnn` allocation and **no Dart source change**. **Recorded by** [`ADR-0048`](../../00-governance/adr/ADR-0048-prd-019-acceptance-criteria-and-stage-3-4-reviews.md). **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — no `DOCUMENTATION_BASELINE.md` §3 row is written or requested, and Rank 3 precedence is still **not held**. |
| **v0.2** | 2026-08-15 | **THE V1 PAYMENT WEBHOOK CONTRACT IS AUTHORED, AND `Q-B31` IS CLOSED — the act v0.1 assigned to this document but deliberately did not perform.** §4 replaces v0.1's *"deliberately NOT specified"* hole with the **minimum V1 contract**: route and transport (§4.1), payload schema (§4.2), signature verification (§4.3), replay protection and idempotency (§4.4), retry and failure handling (§4.5) and the required event set (§4.6) — all five elements `ACCEPTED` `ADR-0040` **§4 L165** assigns to the `BC-31` owner, plus the events. **56 `ITG-*` identifiers are minted (0 → 56)** and §5 publishes **five contiguous ranges**, keeping v0.1's explicit undertaking to publish them *"in the same pass that issues the first identifier"*. **What made this lawful, and it was checked before writing rather than after:** the provider prerequisite was supplied by `ACCEPTED` [`ADR-0046`](../../00-governance/adr/ADR-0046-v1-payment-gateway-provider-razorpay.md) (**Razorpay**), and the *values* by **Razorpay's own published documentation**, which `ACCEPTED` `ADR-0045` §5.2 had named as the one missing input — *"that provider's own published webhook documentation, **which this repository does not contain**"*. **Every provider-specific value carries a citation in §4.9 (26 rows); not one was inferred, rounded or recalled.** ⚠ **The distinction §4.0 exists to prevent a reader from blurring:** Razorpay publishes **no route path** — only constraints on one (public URL, ports 80/443, TLS 1.2+, not blacklisted, IPs reachable) — so `ITG-FR-001`'s path is labelled **`[LIB]`**, a LIBOORA value *constrained by* the provider, and **presenting it as a provider value would have been a false citation dressed as compliance**. Two further values are labelled `[LIB]` on the same principle: `ITG-FR-013` (constant-time comparison — a security obligation the provider does not publish) and `ITG-FR-017` (**30-day** dedup retention — **derived**, with the derivation shown, as the smallest value exceeding both published windows, 24-hour retry and 15-day replay). ⚠ **One `ADR-0040` element is answered in a shape different from the one its name implies, and this is disclosed rather than smoothed over:** *"replay window"* has **no** signed-timestamp tolerance, because **Razorpay sends no signed timestamp to bound** — the documented defence is `x-razorpay-event-id` dedup, so §4.4 implements that and §4.4's closing note states plainly that *"inventing a signed-timestamp tolerance that the provider does not send would have looked more complete and been false."* **BOUNDARIES: `BC-05` remains the financial source of truth and this document asserts NO financial rule.** `FEE-BR-014`, `FEE-BR-016`, `FEE-FR-028`, `FEE-INV-005`, `FEE-FR-032` and `FEE-AC-085`…`089` are **cited and never copied** — `ADR-0040` **L166**'s second-source-of-truth bar — and **`PRD-008` is byte-unchanged and NOT frozen**. `ITG-BR-010` routes every money-touching action through the **existing** `business.payment_intent` port (Matrix row `X-03`); `ITG-BR-008` keeps transport dedup explicitly **separate from** `FEE-BR-016`'s payment-side duplicate protection, *two layers with two owners, deliberately not merged*; `ITG-INV-002` states the **transport half** of verification-before-recording and is deliberately narrower than the financial half; `ITG-FR-018`/`ITG-INV-004` make tenant partitioning explicit for dedup, evidence and audit records; `ITG-XC-001` keeps the vendor name out of the route, columns, event payloads and internal API contracts (`FEE-XC-006`, Matrix **L167**); `ITG-BR-007` keeps the webhook secret out of `BC-05` (`FEE-XC-005`); and inbound **ingress** remains a `platform/business` capability (§2.1) — **owning the contract is not owning the ingress**. **NOTHING NEW WAS CREATED beyond `ITG-*` requirement identifiers:** no bounded context (count stays **31**), no `E-*` edge, no port, no permission, no configuration identifier, no API architecture, no provider, no duplicated financial rule, no `IMPL-*` allocation and no Dart source change. ⚠ **THREE HONEST SHORTFALLS, stated because omitting them would make this entry a better advertisement and a worse record.** **(1)** `ITG-AC-*` is **EMPTY** — coverage is **0/54**, no obligation here is *verified* in the sense `PRD-008` §0.2 requires (*"prose never counts"*), and the successor item **`Q-B31-AC`** is opened in §7 for it. **(2)** **Stage 4 is NOT run and Stage 3 was NOT performed**, so §6 upgrades **only Stage 2** — PARTIAL → **PASSED**, and only because the exact stated deficiency (unpublished ranges) was removed. **`Q-B31`'s Stage 4 blocker changed identity rather than vanishing**: from *"no requirement to test"* to *"no criterion to test with"*. **(3)** Two residual gaps are **minted rather than buried** — **`ITG-GAP-001`** (V1 has **no** dead-letter queue, replay console or platform-side re-delivery; after the provider's 24-hour retry the webhook is **disabled** and recovery falls to a ≤15-day support replay or `FEE-FR-032` reconciliation — *a thin failure path, stated as thin*) and **`ITG-GAP-002`** (this contract **depends on** the provider's Payment Capture setting, which it does not control, and uncaptured authorised payments are auto-refunded by the provider). **Three defects in this pass's own first draft were caught by its own counting script and repaired, not shipped:** a claimed *"52 identifiers"* against a measured **56**, `ITG-GAP-001`/`002` referenced while **undefined**, and `ITG-XC-004` emitted as a **stray table row with no header** — the `SR-01` class of defect this repository already tracks, which is why the count is computed rather than asserted. **Recorded by** `ACCEPTED` [`ADR-0047`](../../00-governance/adr/ADR-0047-prd-019-v1-webhook-contract-authority.md). **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — no `DOCUMENTATION_BASELINE.md` §3 row is written or requested, and Rank 3 precedence is still **not held**. |
| **v0.1** | 2026-08-15 | **Created `DRAFT` under `ACCEPTED` [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md), for one purpose: to give the payment-webhook wire contract a lawful owner.** §2 assigns the five wire elements enumerated by `ACCEPTED` `ADR-0040` **§4 L165** to **`BC-31`**, **recognising** an allocation BC Map **L140**, `PRD_REGISTRY.md` **L309**, `PRD-022`'s `SAAS-XC-006` and Matrix `X-03` already make — **no context, edge, port, module, role, permission or configuration identifier is created**, and the context count stays **31**. §3 fixes the boundary against `PRD-008`: **`BC-31` owns the wire, `BC-05` owns the money**, ingress remains a `platform/business` capability per `ACCEPTED` `ADR-0035` §5.5b as upheld by `ADR-0040` §1, and **`PRD-008` is not restated, amended or duplicated**. ⛔ **The contract itself is NOT authored, and that is stated as a hole rather than concealed:** not one endpoint, URL, payload field, signature algorithm, header, replay window, retry count or provider name appears in this file, because writing them would require inventing an API, a schema and a provider. The outstanding work is **`Q-B31`** — an identifier **already opened and routed** by `ACCEPTED` `ADR-0042` §8, **not minted here** — and §4.1 records honestly that the end-to-end gateway-webhook **feature** remains unbuildable, so creating this document made the work *attributable*, not *done*. §5 reserves prefix **`ITG-*`** with **0 identifiers issued** after a collision check (`ITG-` = 0 repository-wide; **`INT-*` refused** because `SID-INT-1`…`12` already exist, per `PRD_LIFECYCLE.md` §5 rule 3 — *"change the new prefix, never the existing one"*), and deliberately **publishes no ranges**, because a range with no members is a false promise. §6 measures this draft against the gates and records **Stage 2 as PARTIAL, not passed**, for exactly that reason. **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — and no baseline row is requested. No frozen document was touched, no `ACCEPTED` ADR was altered, no checker was weakened, and no Dart source was written. |
