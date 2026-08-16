# PRD-019 — INTEGRATION (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-019_INTEGRATION.md` |
| **PRD** | `PRD-019` |
| **Module** | Integration |
| **Bounded Context** | **`BC-31` Integration** |
| **Classification** | `[GENERIC]` — Integration platform |
| **Release** | **V1** |
| **Version** | **v0.1 — DRAFT** |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT approved. NOT architecture-reviewed. NOT frozen.** Status is *conferred* by the register, never claimed by a document about itself; the `PLANNED` → `DRAFT` movement is recorded in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.2 by the Governance Owner under [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md) |
| **Date** | 2026-08-15 |
| **Baseline** | Written **against** `BASELINE-2026-08-05-A`. **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD) — **not held today**, because admission is a baseline act |
| **Owns** | Outbound third-party contracts, credentials, retries, idempotent delivery — **BC Map L140**, verbatim and unextended |
| **Identifier prefix** | **`ITG-*`** — **reserved, with ZERO identifiers issued.** See §5 |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ACCEPTED` `ADR-0040`, `ACCEPTED` `ADR-0043` (Rank 2) · **BC Map v1.7** (Rank 4) · Module Dependency Matrix v1.3 (Rank 4) |

---

> ### ⚠️ Read this before treating any statement here as settled
>
> This is a **Stage 2 draft created for one purpose**: to give the payment-webhook **wire contract** a lawful
> owner, because `ACCEPTED` [`ADR-0040`](../../00-governance/adr/ADR-0040-webhook-ownership-authoritative-and-bc-05-verification-obligation.md)
> **§4 L165** assigns that contract to *"the `BC-31` owner, **once `PRD-019` exists**"* — and until this file was
> written, `PRD-019` did not exist.
>
> **This document assigns ownership. It does not exercise it.** It contains **no** endpoint, URL, payload schema,
> field list, signature algorithm, header, replay window, retry policy or payment-provider name — see §4.

---

## 0. Document control

### 0.1 What this document is

The Product Requirements Document for **`BC-31` Integration**, opened at **v0.1** with a single completed act:
the **ownership assignment** recorded in §2.

### 0.2 What this document is NOT

It is **not** a specification of `BC-31`'s behaviour. `BC-31`'s full requirement set — outbound connectors,
credential custody, retry semantics, idempotent delivery — is **unwritten**, and this draft does not pretend
otherwise. It defines **no** database schema, API URL, framework, vendor, widget or infrastructure choice.

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

## 4. What is deliberately NOT specified — and by whom it must be

**This document specifies none of the five wire elements it owns.** Not one endpoint, URL, payload field,
signature algorithm, header name, replay window duration, retry count, backoff schedule or payment-provider
name appears anywhere in this file. That is **deliberate and it is a defect of completeness, disclosed rather
than concealed**:

| Open item | Question | Owner | Blocks |
|---|---|---|---|
| **`Q-B31`** | **Author the payment-webhook wire contract** — endpoint, payload schema, signature algorithm, replay window, retry policy | **`BC-31` owner** *(this document's owner)* | **`PRD-019`'s own Stage 4 and Freeze.** ⛔ **NOT `PRD-008`'s** — see §4.1 |

`Q-B31` is **not a new identifier**. It was opened and routed by `ACCEPTED` `ADR-0042` §8 during the `PRD-008`
governance pass, against *"the `BC-31` owner"* — a party that had no document to write in. **It now has one.**

**Why nothing was written to fill it:** authoring those five elements requires choosing a payment provider's
wire format, and no ranked document names a provider. Writing one would be inventing an API, a schema and a
provider. **A named hole is honest; an invented contract is not.**

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
| Functional requirements | `ITG-FR-*` | *not yet published* | **0** |
| Business rules | `ITG-BR-*` | *not yet published* | **0** |
| Invariants | `ITG-INV-*` | *not yet published* | **0** |
| Exclusions | `ITG-XC-*` | *not yet published* | **0** |
| Acceptance criteria | `ITG-AC-*` | *not yet published* | **0** |
| **Total** | | | **0** |

**The prefix was collision-checked before reservation**, per `PRD_LIFECYCLE.md` §5 rules 2 and 3: `ITG-` occurs
**0 times** repository-wide. **`INT-*` was considered and refused** — `Student_Identity_PRD_v1.md` §4.16 owns
`SID-INT-1`…`SID-INT-12`, so a bare `INT-12` would be a grep collision with `SID-INT-12`. Per §5 rule 3, *"on
collision, change the new prefix, never the existing one"* — so the **new** prefix moved.

⚠ **Ranges are deliberately unpublished, because publishing a range with zero members would make it false**
(`PRD_LIFECYCLE.md` Stage 2 rule 3: *"Ranges are contiguous. A gap makes the published range false."*). They are
published in the same pass that issues the first identifier.

---

## 6. Lifecycle position — measured against the gates, not claimed

| Stage | Verdict |
|---|---|
| **Stage 1 — Discovery** | ✅ **PASSED.** `BC-31` is a context in the BC Map (**L140**) and is **not owned by another PRD** — `PRD_REGISTRY.md` §6 records no competing claim. It owns outbound contracts and idempotent delivery, so it is not a presentation composition. Release **V1** on Master PRD **L638** |
| **Stage 2 — Draft** | ⚠ **PARTIAL.** The version/status header exists and the prefix is collision-checked, but the gate also requires *"identifier registers declared up front **with ranges**"* — and §5 publishes **no ranges**, because there are no identifiers. **Stated as partial rather than passed** |
| **Stage 3 — Architecture Review** | ⛔ **NOT PERFORMED.** No alignment record exists |
| **Stage 4 — Requirements Review** | ⛔ **NOT PERFORMED.** ⛔ **BLOCKED by `Q-B31`** — there is no requirement to test |
| **Stages 5–9** | ⛔ **NOT REACHED** |
| **Freeze** | ⛔ **NOT FROZEN, and not a candidate.** Freeze is *conferred* by a row in `DOCUMENTATION_BASELINE.md` §3 (`PRD_LIFECYCLE.md` Stage 7), and **this document has no such row and does not request one** |

---

## 7. Open items

| ID | Item | Owner | State |
|---|---|---|---|
| **`Q-B31`** | Author the payment-webhook wire contract (§4) | **`BC-31` owner** | ⛔ **OPEN** |
| — | Specify `BC-31`'s remaining L140 obligations: outbound contracts, credential custody, retries, idempotent delivery | **`BC-31` owner** | ⛔ **OPEN** — no identifier is minted for this, because a register with zero members cannot carry one |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-08-15 | **Created `DRAFT` under `ACCEPTED` [`ADR-0043`](../../00-governance/adr/ADR-0043-prd-019-creation-and-prd-008-freeze-blocker-closure.md), for one purpose: to give the payment-webhook wire contract a lawful owner.** §2 assigns the five wire elements enumerated by `ACCEPTED` `ADR-0040` **§4 L165** to **`BC-31`**, **recognising** an allocation BC Map **L140**, `PRD_REGISTRY.md` **L309**, `PRD-022`'s `SAAS-XC-006` and Matrix `X-03` already make — **no context, edge, port, module, role, permission or configuration identifier is created**, and the context count stays **31**. §3 fixes the boundary against `PRD-008`: **`BC-31` owns the wire, `BC-05` owns the money**, ingress remains a `platform/business` capability per `ACCEPTED` `ADR-0035` §5.5b as upheld by `ADR-0040` §1, and **`PRD-008` is not restated, amended or duplicated**. ⛔ **The contract itself is NOT authored, and that is stated as a hole rather than concealed:** not one endpoint, URL, payload field, signature algorithm, header, replay window, retry count or provider name appears in this file, because writing them would require inventing an API, a schema and a provider. The outstanding work is **`Q-B31`** — an identifier **already opened and routed** by `ACCEPTED` `ADR-0042` §8, **not minted here** — and §4.1 records honestly that the end-to-end gateway-webhook **feature** remains unbuildable, so creating this document made the work *attributable*, not *done*. §5 reserves prefix **`ITG-*`** with **0 identifiers issued** after a collision check (`ITG-` = 0 repository-wide; **`INT-*` refused** because `SID-INT-1`…`12` already exist, per `PRD_LIFECYCLE.md` §5 rule 3 — *"change the new prefix, never the existing one"*), and deliberately **publishes no ranges**, because a range with no members is a false promise. §6 measures this draft against the gates and records **Stage 2 as PARTIAL, not passed**, for exactly that reason. **NOT reviewed, NOT approved, NOT baselined, NOT frozen** — and no baseline row is requested. No frozen document was touched, no `ACCEPTED` ADR was altered, no checker was weakened, and no Dart source was written. |
