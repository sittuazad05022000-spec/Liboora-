# PRD-014 — Entitlement

| Field | Value |
|---|---|
| **PRD ID** | `PRD-014` |
| **Name** | Entitlement |
| **Bounded context** | **`BC-21` Entitlement** |
| **Context type** | `[GENERIC]` |
| **Owning platform** | Business |
| **Module** | `platform/business` — **shared with `BC-20`**, rank 6 |
| **Aggregate** | **`EntitlementSet`** — exactly one |
| **Value objects** | `FeatureGate`, `UsageCounter`, `Limit` — exactly three |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** |
| **Date** | 2026-08-19 |
| **Identifier prefix** | **`ENT-`** |
| **Precedence rank sought** | Rank 3 (module PRD) — **not yet conferred** |
| **Rank 1 authority** | `MASTER_PRD.md` **§8.1 L191** — *"`BC-21` Entitlement \| Answers 'is this tenant allowed to do X, and how much is left?' Every paid gate depends on it."* |
| **Rank 4 authority** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L130** (the context), **L383** (the aggregate and its one invariant), **L326** (`E-17`), **L435–437** (the events consumed) |
| **Stage 1 record** | [`PRD-014_STAGE1_DISCOVERY.md`](PRD-014_STAGE1_DISCOVERY.md) — verdict **PASS** |
| **Owner** | **None named.** `PRD_LIFECYCLE.md` L283 records this as `PGA-08`, a product-wide governance gap. This PRD does not close it |

> **Status means status.** `DRAFT` is not a courtesy. `PRD_LIFECYCLE.md` L155–180 reserves `FROZEN` for a row
> in `DOCUMENTATION_BASELINE.md` §3 conferred through the baseline mechanism: *"Freeze is **conferred, not
> claimed**."* This document claims nothing.

---

## 0. Registers, conventions and what is deliberately absent

### 0.1 Normative language

| Term | Meaning in this document |
|---|---|
| **SHALL** / **MUST** | An obligation. Its absence is a defect |
| **SHALL NOT** / **MUST NOT** | A prohibition. Something that must be **impossible**, not merely undone |
| **SHOULD** | A recommendation. Departure requires a recorded reason |
| **MAY** | Permission. No obligation either way |
| *cited* | A statement whose authority lives elsewhere. Reproduced for navigation, **not** made true here |

Every obligation in this document carries an identifier. There are no unnumbered requirements.

### 0.2 Identifier registers — declared up front, with ranges

`PRD_LIFECYCLE.md` L79–86 requires the registers to be published *"up front, with ranges"*, and L82 rule 3
adds that ranges must be contiguous because *"a gap makes the published range false"*. The ranges below are a
promise: no identifier outside them exists in this document, and every identifier inside them is defined
exactly once.

**Class A — obligation-bearing registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `ENT-FR-` | Functional requirement | **28** | `ENT-FR-001` … `ENT-FR-028` | Yes |
| `ENT-BR-` | Business rule | **8** | `ENT-BR-001` … `ENT-BR-008` | Yes |
| `ENT-INV-` | Invariant | **6** | `ENT-INV-001` … `ENT-INV-006` | Yes |
| `ENT-EVT-` | Domain event published by this context | **0** | **DECLARED EMPTY** — see §0.3 | n/a |
| `ENT-XC-` | Exclusion — a prohibition with a named owner elsewhere | **12** | `ENT-XC-001` … `ENT-XC-012` | Yes |

**Class B — supporting registers**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `ENT-AC-` | Acceptance criterion | **26** | `ENT-AC-001` … `ENT-AC-026` | Yes |
| `ENT-CFG-` | Configurable parameter | **0** | **DECLARED EMPTY** — see §0.3 | n/a |

**Class C — finding register**

| Prefix | Meaning | Count | Range | Contiguous? |
|---|---|---|---|---|
| `ENT-GAP-` | Open gap this PRD records but cannot close | **8** | `ENT-GAP-001` … `ENT-GAP-008` | Yes |

**Totals: 88 identifiers declared across 8 registers, of which 2 are empty. 54 are obligation-bearing.
No identifier is retired; none has ever been issued before.**

The last claim is mechanical, not rhetorical. Before this document existed,
`grep -rhoE '\bENT-[A-Z0-9-]+' docs/ tool/ lib/ packages/ test/ | sort -u | wc -l` returned **0**. The prefix
`ENT-` was unused across the entire repository.

### 0.3 Two registers are deliberately EMPTY — and why that is a finding, not an omission

**`ENT-EVT-` is empty because `BC-21` publishes no events.**

BC Map §9 was read in full. `BC-21` appears in exactly three rows — **L435**, **L436**, **L437** — and in every
one of them it sits in the *consumer* column. There is no row in which `BC-21` is the publisher. A register of
published events would therefore have to invent its first entry.

This is the same shape `PRD-016` found for `BC-24`, whose `AUD-EVT-*` register is empty for the identical
reason. `ENT-FR-024` states the prohibition positively so that the emptiness is enforceable rather than
incidental.

**`ENT-CFG-` is empty because no document at any rank bounds an entitlement parameter.**

BC Map **L326** (`E-17`) says the per-feature fail disposition is *"decided per feature, **recorded in
Config**"*. The register it points at does not exist. `docs/20-configuration/CONFIGURATION_GUIDE.md` (Rank 7,
585 lines) was searched for `entitlement|BC-21|quota|feature.?gate|usage.?count`; it returns **7 hits, every
one of them an OTP/SMS value** (`CFG-1`…`CFG-4`, `INV-4`). There is no entitlement configurable anywhere in
the repository.

Populating `ENT-CFG-*` would mean choosing a default and a range for a value the platform has not decided —
and `Q-03`, the question that decides it, is **Open** at Rank 4 (BC Map L542) and at Rank 1
(`MASTER_PRD.md` L675). That is inventing a configuration value. The gap is recorded instead, as
**`ENT-GAP-001`** and **`ENT-GAP-002`**.

> An empty register that names its reason is a finding. An empty register that says nothing is an omission.

### 0.4 Citation discipline — three near-misses that would misattribute a requirement

| Risk | Correct usage |
|---|---|
| `Seat` vs `SeatQuota` | `Seat` is **`BC-04`**'s physical numbered position. `SeatQuota` is **`BC-21`**'s allowance count. BC Map **L211**, enforced by a CI lint rule: *"Ubiquitous language is not documentation — it is a compile-time constraint."* This document uses `SeatQuota` only |
| `INV-n` vs `ENT-INV-n` | `INV-1`…`INV-16` are **platform invariants** in `CONFIGURATION_GUIDE.md` §3, registered at `TRACEABILITY_MATRIX.md` L82. `INV-SEC-*` and `INV-XC-*` also exist. `ENT-INV-*` is a distinct register. Any scan must be **anchored** (`\bENT-INV-`), or a naive `grep 'INV-'` over-counts |
| `Q-03` the BC Map question vs any module's fail-closed statement | `Q-03` is **Open**. `PRD-005` `MM-BR-013` and `PRD-007` `SEAT-FR-296` assert fail-closed **for their own gates, on their own authority**. This document cites them; it does not generalise them into a `BC-21` platform rule. See `ENT-GAP-001` |

### 0.5 What this document deliberately does **not** restate

The user's instruction is explicit: *"Do not restate frozen PRDs; cite their authority where required."*
Restatement creates a second source of truth, which `PRD_LIFECYCLE.md` L118 names as a Stage 4 failure.

| Subject | Owner | This document's posture |
|---|---|---|
| Tenant lifecycle, `TenantTier`, `Quota`, residency | `BC-19` / `PRD-013` (FROZEN) | Cited as **inputs**. `ENT-XC-001` |
| Subscriptions, plans, invoices, gateway, dunning | `BC-20` / `PRD-022` (DRAFT) | Cited. `ENT-XC-002`, `ENT-XC-004` |
| The schema and emission of `billing.EntitlementChanged` | `BC-20` | Cited from BC Map L437. `ENT-XC-003` |
| Membership plans and the publication of `seatQuota` | `BC-02` / `PRD-005` (FROZEN) | Cited. `ENT-XC-006` |
| Seat allocation and its own fail-closed conduct | `BC-04` / `PRD-007` (FROZEN) | Cited, never generalised. `ENT-XC-007` |
| Feature-flag definition, evaluation, rollout | `BC-25` / `PRD-023` | Cited via `ADR-0017`. `ENT-XC-008` |
| Authorisation, credentials, OTP, sessions | `BC-18` | Cited. `ENT-XC-009` |
| Audit persistence (`AuditEntry`) | `BC-24` / `PRD-016` (FROZEN) | Cited. `ENT-XC-010` |
| The event delivery contract (outbox, at-least-once, envelope, ordering, replay) | BC Map **§9.1**, Rank 4 | **Cited, not reproduced.** Requirements state what this module must do *given* that contract |
| Tenant partitioning as a platform rule | `MP-GBR-08`, `MP-GBR-09`, Rank 1 | Cited. This module's obligations are `ENT-FR-021` and `ENT-INV-003` |

---

## 1. Purpose and scope

### 1.1 Purpose

`BC-21` Entitlement owns one question and its answer. BC Map **L130**, verbatim:

```
| **BC-21** | **Entitlement** | `[GENERIC]` | Business | V1 | Owns the answer to *"is tenant T allowed
to do X, and how much of it is left?"* Single source of truth for limits and gates. |
```

Two answers, therefore, not one: **allowed** (a gate) and **how much is left** (a counted allowance). Both are
requirements — `ENT-FR-016`, `ENT-FR-022`, `ENT-FR-023`.

### 1.2 Why this PRD exists

Three FROZEN PRDs already depend on `E-17`, and one of them records this document's absence as a defect with a
severity. `PRD-008` **L1620**, FROZEN v1.7:

```
| E-17 | BC-21 Entitlement | ❌ D-08 "Unsatisfied — no specification" | Medium |
```

`PRD-005` (L972, L1008) and `PRD-007` (L195, L551, L2128–2135) consume the edge. `PRD-013` **L321** and
`PRD-016` **L273** both exclude entitlement from themselves and name `BC-21` as the owner. The registry
reserved the identity `PRD-014` for this context at **L304**. This document is the discharge of a registered
plan, not a new claim.

### 1.3 Scope band — capability, not foundational

BC Map **L271** names the FOUNDATIONAL band as **exactly `BC-18`, `BC-19`, `BC-25`**. `BC-21` is the first line
of the **CAPABILITY & GENERIC** band (**L263**), whose preamble reads: *"These MUST NOT import any domain
context. They learn about the domain only via Published Language events and registered handler ports."*

`BC-21` is *consulted by* every write path (BC Map L326, `E-17`; `ADR-0035` L235). It does not sit beneath
them. The distinction governs `ENT-FR-027`, `ENT-XC-011` and `ENT-XC-012`.

### 1.4 Module identity — and the boundary inside it

| Property | Value | Authority |
|---|---|---|
| Module | `platform/business` | `tool/module_dependencies.yaml` |
| Rank | 6 | yaml; Matrix **L70** — *"BUSINESS (Subscription + Entitlement) · WORKFLOW · AI — Higher-order capabilities. Orchestrate and decide, **own no domain aggregate**"* |
| Contexts in the module | **Exactly two**: `BC-20`, `BC-21` | `ADR-0035` **L123** |
| Declared port for this context | `business.entitlement` | `PRD-013` **L107**; Matrix **L195**, **L306**; yaml L118, L342, L516; `ADR-0012` **L86** |

**The module is shared, so this PRD's claim over it is partial and says so.** The split, stated explicitly so
that no reader infers a blanket claim:

| Module artefact | Owner | Claimed here? |
|---|---|---|
| Assertion `BZ-1` — *"entitlement state is written only by `billing.EntitlementChanged` handlers"* (`X-11`) | **`BC-21`** | **Yes** — it is `ENT-BR-001` / `ENT-INV-002` |
| Assertion `BZ-2` — *"every gateway call carries an idempotency key"* | **`BC-20`** | **No** — `ENT-XC-004` |
| Port `platform/integration:payment_gateway` | **`BC-20`** | **No** — `ENT-XC-004` |
| `rank: 6`; `banned_imports: ["domain/**", "app/**"]` | Shared | Cited, not claimed — `ENT-FR-027` |

---

## 2. The aggregate

**`ENT-FR-001`** — The module **SHALL** own exactly one aggregate, **`EntitlementSet`**, instantiated **per
tenant** and **read-optimised**, as granted by BC Map **L383**. It **SHALL NOT** introduce a second aggregate.

**`ENT-FR-002`** — `EntitlementSet` **SHALL** be composed of exactly three value objects — **`FeatureGate`**,
**`UsageCounter`** and **`Limit`** — as granted by BC Map **L383**. No fourth value object may be added to this
register without an ADR.

BC Map **L383**, verbatim, is the whole of this section's authority:

```
| BC-21 Entitlement | `EntitlementSet` *(per tenant, read-optimised)* | `FeatureGate`, `UsageCounter`,
`Limit` | Derived state only — **never** hand-edited; recomputable from Subscription events
(rebuild-from-events must yield identical output) |
```

**`ENT-FR-003`** — `EntitlementSet` **SHALL** be **derived state only**. The module **SHALL NOT** expose any
interface — API, admin screen, migration, seed routine or repository method — by which an `EntitlementSet`,
`FeatureGate`, `UsageCounter` or `Limit` can be set directly. *(BC Map L383; Matrix `X-11`; yaml `BZ-1`.)*

**`ENT-FR-004`** — `EntitlementSet` **SHALL** be recomputable from the input event stream, and a rebuild
**MUST** yield output identical to the incrementally maintained state. *(BC Map L383: "rebuild-from-events must
yield identical output".)*

**`ENT-FR-005`** — The module **SHALL** treat `billing.EntitlementChanged` as the **only** writer of
entitlement inputs. *(BC Map **L437**: `| BC-20 | billing.EntitlementChanged | BC-21 | The only writer of
entitlement inputs |`.)*

---

## 3. Derivation and inputs

`BC-21` consumes; it does not originate. The three input rows in BC Map §9, verbatim:

```
| BC-19 | tenancy.TenantProvisioned / TenantSuspended | All, BC-21, BC-24 | Lifecycle gates |
| BC-20 | billing.SubscriptionActivated / Cancelled / PaymentFailed | BC-21, BC-22, BC-26, BC-24 | **Drives entitlement** |
| BC-20 | billing.EntitlementChanged | BC-21 | The only writer of entitlement inputs |
```

**`ENT-FR-006`** — The module **SHALL** consume `billing.SubscriptionActivated`, `billing.SubscriptionCancelled`
and `billing.PaymentFailed` as inputs to entitlement derivation. *(BC Map **L436**, whose note reads "Drives
entitlement".)*

**`ENT-FR-007`** — The module **SHALL** consume `tenancy.TenantProvisioned` and `tenancy.TenantSuspended` as
lifecycle inputs. *(BC Map **L435**.)*

**`ENT-FR-008`** — Every input handler **SHALL** be idempotent, keyed on the envelope's **`eventId`**.
*(BC Map **§9.1**: delivery is at-least-once, "therefore every consumer must be idempotent, keyed on
`eventId`". Reinforced at Rank 1 by `MP-GBR-18`.)*

**`ENT-FR-009`** — When an input event arrives without a `tenantId`, or with one for which no tenant context can
be established, the handler **SHALL** fail loudly and **SHALL NOT** default to any tier, limit or gate state.
*(BC Map **§9.1**: "`tenantId` is mandatory on every domain event. A consumer that processes an event without
establishing tenant context must **fail loudly, not default**." Rank 1: `MP-GBR-06`, `MP-GBR-07`.)*

**`ENT-FR-010`** — The module **SHALL NOT** assume global event ordering. It **MAY** rely only on ordering per
aggregate, guaranteed by the partition key `aggregateId`. *(BC Map **§9.1**: ordering is "guaranteed per
aggregate … **not** globally".)*

**`ENT-FR-011`** — Where an entitlement must be changed outside the ordinary subscription flow, the module
**SHALL** accept that change only as a `billing.EntitlementChanged` event carrying an **actor** and a
**reason**, and **SHALL NOT** provide any other override path. *(Matrix **L360 `X-11`**, whose stated remedy is
"Emit a `billing.EntitlementChanged` override event with actor + reason".)*

`X-11`, verbatim, because it is the anti-pattern this whole section exists to prevent:

```
| **X-11** | `BC-21 Entitlement` written by anything except Billing events | "Just grant this customer
the feature manually" | Entitlement stops being derivable; rebuild-from-events diverges; revenue
leakage is unauditable | Emit a `billing.EntitlementChanged` override event with actor + reason |
```

---

## 4. The synchronous decision port — `E-17`

BC Map **§7.3 L326**, verbatim:

```
| E-17 | All write paths | BC-21 Entitlement | `CF` | Sync port `check(tenantId, feature, delta)` |
Called **before** the aggregate mutates. Fail-closed on timeout for paid gates, fail-open for soft
limits — decided per feature, recorded in Config |
```

**`ENT-FR-012`** — The module **SHALL** expose its decision surface as the registered port
**`business.entitlement`**. It **SHALL NOT** rename the port. *(`PRD-013` **L107**; Matrix **L195**, **L306**;
yaml L118, L342, L516; `ADR-0012` **L86** confirms the port is already declared and directionally lawful.)*

**`ENT-FR-013`** — The port **SHALL** expose the operation **`check(tenantId, feature, delta)`** with those
three parameters. *(BC Map **L326**.)*

**`ENT-FR-014`** — `tenantId` **SHALL** be an **explicit argument** of `check`, not an ambient value read from
a context object. *(BC Map **L326** names it as a parameter. See §13 `D-014-02` — the existing implementation
omits it.)*

**`ENT-FR-015`** — The port **SHALL** be specified as a **pre-mutation** check: it is called before the calling
context's aggregate mutates. The module **SHALL NOT** offer a post-mutation compensation path in its place.
*(BC Map **L326**: "Called **before** the aggregate mutates." Corroborated in source at
`lib/domain/library/enrollment/enrollment.dart:79`.)*

**`ENT-FR-016`** — The port **SHALL** answer both halves of `BC-21`'s question: whether the tenant is **allowed**
to perform the action, and **how much of the allowance remains**. *(BC Map **L130**.)*

**`ENT-FR-017`** — The module **SHALL** expose the remaining allowance for every counted feature it governs, so
that a calling context has no need to hold a duplicate limit of its own. *(BC Map **L130** — "Single source of
truth for limits and gates". `PRD-007` **L2128–2135** independently forbids its own module from holding a
duplicate seat-count limit, citing the same phrase; this requirement is the supply side of that demand, stated
as this module's obligation and not as an obligation imposed on `BC-04`.)*

**`ENT-FR-018`** — The disposition of a `check` that times out — fail-open or fail-closed — **SHALL** be
resolved **per feature** from an external configured value. The module **SHALL NOT** define a default
disposition, and **SHALL NOT** derive one by generalising any other context's statement of its own conduct.
*(BC Map **L326** assigns the decision to Config per feature. The value does not exist — see `ENT-GAP-001` and
`ENT-GAP-002`. `Q-03` is **Open** at BC Map **L542** and `MASTER_PRD.md` **L675**. This requirement is
therefore **satisfiable only after `ENT-GAP-002` closes**, which is stated rather than hidden.)*

**`ENT-FR-019`** — A refused `check` **SHALL** be distinguishable by cause: an exceeded counted allowance and a
disabled gate are different outcomes. The contract vocabulary for this already exists as
`DomainErrorCode.entitlementExceeded` and `DomainErrorCode.featureNotEnabled`
(`packages/liboora_contracts/lib/src/errors/domain_error.dart:22–23`) and the module **SHALL** use it rather
than introduce a parallel one.

---

## 5. Business rules

**`ENT-BR-001`** — A manual grant of an entitlement is **prohibited**. The only lawful route to an
out-of-band change is a `billing.EntitlementChanged` event carrying actor and reason. *(Matrix `X-11`; yaml
`BZ-1`; BC Map L383 "never hand-edited".)*

**`ENT-BR-002`** — A divergence between the incrementally maintained `EntitlementSet` and a rebuild from
events is a **defect**, not a reconciliation opportunity. It **SHALL** be resolved by fixing the derivation,
never by editing the state. *(BC Map L383: "rebuild-from-events must yield identical output".)*

**`ENT-BR-003`** — `TenantTier` and `Quota` are **inputs** to entitlement derivation and are never outputs of
it. The module reads them and **SHALL NOT** define, store or recompute them. *(`PRD-013` **L157–159**
`TEN-FR-006`, FROZEN: the two value-object sets "are disjoint". `ENT-XC-001` states the prohibition.)*

**`ENT-BR-004`** — A feature flag being on does **not** confer entitlement, and an entitlement being present
does **not** imply a flag is on. *(`ADR-0017` **L125–126**: *"a flag says **is this on**; an entitlement says
**is this paid for**"*; **L137**: `PRD-023` owns "not entitlement decisions (`BC-21`)". Corroborated
descriptively at EA **L106**: "Configuration resolves the flag; Business decides the entitlement." Cited with
the caution recorded at `ENT-GAP-007`.)*

**`ENT-BR-005`** — Entitlement is consulted **before** a mutation, never after it. A mutation that has already
occurred is not made lawful by a subsequent check. *(BC Map **L326**.)*

**`ENT-BR-006`** — Entitlement is derived from money owed by a library **to LIBOORA** only. It **SHALL NOT** be
influenced by money owed by a student **to a library**. *(Rank 1 `MP-GBR-24`: the two "must never share a
model, a table or a metric." BC Map **L129** scopes `BC-20` to the former. `ADR-0035` §3.1 quotes the same
rule.)*

**`ENT-BR-007`** — Absence of tenant context is a **failure**, not a condition with a default. *(Rank 1
`MP-GBR-07`; BC Map §9.1. See §13 `D-014-03` — the existing implementation defaults silently.)*

**`ENT-BR-008`** — Tightening of gates following a downgrade is **eventually** consistent, and any grace
period is a **configured** value, never an implicit one. *(BC Map **L467**: `| Tenant subscription downgrade |
BC-20, BC-21, then all | **Eventual** | EntitlementChanged → recompute → gates tighten. Grace period
configured, not implicit |`. The configured value does not yet exist — `ENT-GAP-002`. This rule therefore
constrains the *shape* of a future configurable without asserting its value.)*

---

## 6. Invariants

**`ENT-INV-001`** — **Derivability.** For any tenant, replaying that tenant's complete input event stream
produces an `EntitlementSet` identical to the one maintained incrementally. *(BC Map L383.)*

**`ENT-INV-002`** — **No hand-edit path.** No code path outside a `billing.EntitlementChanged` handler writes
entitlement state. *(Matrix `X-11`; yaml `BZ-1`.)*

**`ENT-INV-003`** — **Tenant binding.** Every `EntitlementSet`, `FeatureGate`, `UsageCounter` and `Limit` is
bound to exactly one `tenantId`, and no read or write path can reach an instance belonging to a different
tenant. *(BC Map L383 "per tenant"; Rank 1 `MP-GBR-08`, `MP-GBR-09` — cross-tenant leakage is "the single
highest-severity failure mode in the architecture".)*

**`ENT-INV-004`** — **No independent state.** A `FeatureGate`'s state and a `Limit`'s value are functions of
consumed inputs alone. Neither holds state that inputs cannot reproduce. *(BC Map L383 "Derived state only".)*

**`ENT-INV-005`** — **No domain aggregate.** The module holds no domain entity. `EntitlementSet` may reference
a tenant identity; it stores no `Student`, `Seat`, `Membership` or other domain aggregate. *(Matrix **L70**:
rank R6 contexts "own no domain aggregate"; BC Map **L263** band preamble: capability contexts "MUST NOT
import any domain context". The apparent tension between L70 and L383's aggregate grant is recorded as
`ENT-GAP-006` rather than resolved here.)*

**`ENT-INV-006`** — **Idempotence.** Applying an input event whose `eventId` has already been applied leaves
`EntitlementSet` unchanged. *(BC Map §9.1; `MP-GBR-18`.)*

---

## 7. Events and integration

**`ENT-FR-024`** — The module **SHALL** publish **no** domain events. Introducing one requires an ADR and an
amendment to BC Map §7 and §9. *(Measured: BC Map §9 names `BC-21` in three rows — L435, L436, L437 — and in
every one it is a consumer. `ENT-EVT-*` is empty for this reason; §0.3.)*

**`ENT-FR-025`** — The module **SHALL NOT** create an integration edge. `E-17` is an edge it **receives**, not
one it creates. Any edge not present in BC Map §7 does not exist, and the module **SHALL** decline it rather
than assume it. *(BC Map **§7 preamble L292**: "If an edge is not in this table, it **does not exist** and
adding it requires an ADR." Posture inherited verbatim from `PRD-013` **L431 `H-1`**: "decline any edge not in
§7, never … invent one".)*

**`ENT-FR-026`** — The module **SHALL NOT** persist audit records of its own decisions. Whether an entitlement
decision **may** be published to `BC-24` is **undetermined**: BC Map §7.3 is *Domain → Capability*, `BC-21` is
capability-band (**L263**), and a capability→capability edge has no subsection in §7 — the taxonomy gap
`PRD-013` **L431** records as `H-1`. Until that is closed the module **SHALL** assume no such edge.
*(`ENT-GAP-005`. `ENT-XC-010` states the persistence prohibition.)*

**`ENT-FR-027`** — Entitlement code **SHALL** reside in `platform/business` at rank 6, **SHALL** import only
`contracts`, and **SHALL NOT** import any `domain/**` or `app/**` module. *(yaml `platform/business`:
`imports: [contracts]`, `banned_imports: ["domain/**", "app/**"]`; Matrix **L49 `L2`** — dependency direction
is downward only; BC Map **§7.4 `F-1`**: "**No capability context may import, reference, or query a domain
context.**")*

**`ENT-FR-028`** — The module **SHALL** use the term **`SeatQuota`** for an allowance count and **SHALL NOT**
use the term `Seat`, which denotes `BC-04`'s physical numbered position. *(BC Map **L211**, enforced by a CI
lint rule. Corroborated by `PRD-007` **L147** and `PRD-005` **L240** `MM-FR-014`.)*

### 7.1 The edge inventory — complete

| Edge | Direction | This module's role | Authority | Created here? |
|---|---|---|---|---|
| `E-17` | All write paths to `BC-21` | **Downstream** — it answers | BC Map L326 | No — received |
| `E-18` | `BC-19` to all | Consumer of ambient tenant context | BC Map §7.3 | No |
| `E-19` | `BC-25` to all | Consumer of typed config accessors | BC Map §7.3 | No |
| `billing.*` inputs | `BC-20` to `BC-21` | Consumer | BC Map L436, L437 | No — and see `ENT-GAP-005`: this pair is published in §9 while absent from §7 |
| `tenancy.*` inputs | `BC-19` to `BC-21` | Consumer | BC Map L435 | No |

**Edges added by this PRD: zero.**

---

## 8. Query and access

**`ENT-FR-020`** — Reads of entitlement state **SHALL** be served from the read-optimised `EntitlementSet`
projection and **SHALL NOT** require traversing `BC-20`'s subscription aggregates. *(BC Map L383
"read-optimised".)*

**`ENT-FR-021`** — Every read **SHALL** be scoped to a single tenant, and no read interface **SHALL** accept a
shape capable of returning another tenant's entitlement. *(Rank 1 `MP-GBR-08`, `MP-GBR-09`; Matrix `X-13`.)*

**`ENT-FR-022`** — The module **SHALL** expose, for a counted feature, the remaining allowance. *(BC Map L130 —
"how much of it is left".)*

**`ENT-FR-023`** — The module **SHALL** expose, for a gated feature, whether it is enabled for the tenant.
*(BC Map L130 — "is tenant T allowed to do X".)*

---

## 9. Exclusions

`PRD_LIFECYCLE.md` L112 requires that *"Every exclusion states what must be **impossible**"* and that *"An
exclusion is not a deferral."* Each row below names the owner that holds the excluded thing.

**`ENT-XC-001`** — The module **MUST NOT** define, store or compute `Tenant`, `TenantTier`, `Quota`,
`ResidencyRegion` or `TenantLifecycleState`. *Owner: **`BC-19`** Tenancy / `PRD-013` (FROZEN). Authority: BC
Map **L380**; `PRD-013` **L157–159 `TEN-FR-006`**, which states the two value-object sets are disjoint. The
reciprocal prohibition already exists as `PRD-013` **L321 `TEN-XC-006`**.*

**`ENT-XC-002`** — The module **MUST NOT** define `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`,
`PaymentAttempt` or `DunningState`. *Owner: **`BC-20`** / `PRD-022`. Authority: BC Map **L382**; `ADR-0035`
**L123**.*

**`ENT-XC-003`** — The module **MUST NOT** emit, define or version the event `billing.EntitlementChanged`, nor
decide when `BC-20` emits it. *Owner: **`BC-20`**. Authority: BC Map **L437** ("The only writer of entitlement
inputs"); **L382** (emission on every state transition is `BC-20`'s invariant); BC Map **§7.4 `F-2`** —
capability contexts learn about the domain "exclusively through Published Language events defined in
`liboora_contracts`".*

**`ENT-XC-004`** — The module **MUST NOT** hold money, call a payment gateway, produce an invoice or run
dunning; and it **MUST NOT** claim the module assertion `BZ-2` or the port
`platform/integration:payment_gateway`, both of which belong to `BC-20`. *Owner: **`BC-20`**. Authority: BC Map
**L129**; `tool/module_dependencies.yaml` `platform/business`; Rank 1 `MP-GBR-24`.*

**`ENT-XC-005`** — The module **MUST NOT** compute proration arithmetic nor move money as a consequence of a
plan change. *Owner: **undetermined** — `Q-06` names `BC-02` (entitlement delta) and the Business Platform
(money) as a **recommendation**, not a decision. Authority: BC Map **L545**; `MASTER_PRD.md` **L678**, both
reading "Open". `PRD-005` **L763–764** and `MM-FR-099` publish the **entitlement delta** and explicitly leave
the money elsewhere. Recorded as `ENT-GAP-003`.*

**`ENT-XC-006`** — The module **MUST NOT** define `MembershipPlan`, nor set or publish the value of a
`seatQuota`. It consumes the published value. *Owner: **`BC-02`** Membership / `PRD-005` (FROZEN). Authority:
`PRD-007` **L147** — `SeatQuota` is "owned by `BC-21` Entitlement / **published by `BC-02`**"; `PRD-005`
**L240 `MM-FR-014`**.*

**`ENT-XC-007`** — The module **MUST NOT** define `Seat`, allocate a seat, or hold a seating layout. *Owner:
**`BC-04`** Seat / `PRD-007` (FROZEN). Authority: BC Map **L211**.*

**`ENT-XC-008`** — The module **MUST NOT** define, evaluate or roll out a feature flag. *Owner: **`BC-25`**
Configuration / `PRD-023`. Authority: `ADR-0017` **L125–126**, **L137**.*

**`ENT-XC-009`** — The module **MUST NOT** decide authorisation, and **MUST NOT** hold, generate or validate
credential, OTP or session material. *Owner: **`BC-18`** Security. Authority: Matrix **`X-13`** — authorisation
decided outside `BC-18` is "**a security defect that passes its own tests**" — and **`ID-1`**.*

**`ENT-XC-010`** — The module **MUST NOT** define or store `AuditEntry`, nor operate an audit store. *Owner:
**`BC-24`** Audit / `PRD-016` (FROZEN). Authority: BC Map L383's `BC-24` row; the reciprocal prohibition
already exists as `PRD-016` **L273 `AUD-XC-007`**.*

**`ENT-XC-011`** — The module **MUST NOT** import, reference or query any domain context, and **MUST NOT**
import any `app/**` module. *Owner: the architecture itself. Authority: BC Map **§7.4 `F-1`**; the
CAPABILITY & GENERIC band preamble at **L259**; yaml `banned_imports`; Matrix **L49 `L2`**.*

**`ENT-XC-012`** — The module **MUST NOT** create, assume or rely upon an integration edge that is absent from
BC Map §7. *Authority: BC Map **§7 preamble L292**; posture inherited from `PRD-013` **L431 `H-1`**.*

---

## 10. Acceptance criteria

`PRD_LIFECYCLE.md` L116 requires that every criterion map to a requirement — an unmapped criterion is an
orphan. Every row below names the obligations it proves. **No criterion here is currently proven by a passing
test:** `find test -iname '*entitlement*'` returns nothing (§13 `D-014-05`). These are criteria, not results.

| ID | Criterion | Proves |
|---|---|---|
| `ENT-AC-001` | The module declares exactly one aggregate named `EntitlementSet` and exactly three value objects named `FeatureGate`, `UsageCounter`, `Limit`; a static scan of the entitlement source finds no fourth | `ENT-FR-001`, `ENT-FR-002` |
| `ENT-AC-002` | No public setter, admin endpoint, migration or seed routine can assign entitlement state; the only writer reachable in a call graph is a `billing.EntitlementChanged` handler | `ENT-FR-003`, `ENT-INV-002` |
| `ENT-AC-003` | For a tenant with a non-trivial event history, a rebuild from the full input stream produces an `EntitlementSet` equal to the incrementally maintained one | `ENT-FR-004`, `ENT-INV-001`, `ENT-BR-002` |
| `ENT-AC-004` | An attempt to change entitlement by any means other than `billing.EntitlementChanged` is rejected | `ENT-FR-005`, `ENT-BR-001` |
| `ENT-AC-005` | `billing.SubscriptionActivated`, `billing.SubscriptionCancelled` and `billing.PaymentFailed` each produce the derived change they imply, and no other | `ENT-FR-006` |
| `ENT-AC-006` | `tenancy.TenantProvisioned` and `tenancy.TenantSuspended` each produce the lifecycle gate change they imply | `ENT-FR-007` |
| `ENT-AC-007` | Delivering the same input event twice, identical `eventId`, leaves `EntitlementSet` byte-identical | `ENT-FR-008`, `ENT-INV-006` |
| `ENT-AC-008` | An input event with no `tenantId`, or an unresolvable one, raises an error; no tier, limit or gate is assigned by default | `ENT-FR-009`, `ENT-BR-007` |
| `ENT-AC-009` | Two input events for different aggregates delivered out of order still converge to the correct state; no handler depends on a global sequence | `ENT-FR-010` |
| `ENT-AC-010` | A `billing.EntitlementChanged` override lacking an actor or a reason is rejected | `ENT-FR-011`, `ENT-BR-001` |
| `ENT-AC-011` | The port is registered as `business.entitlement` and its operation signature is `check(tenantId, feature, delta)` with `tenantId` explicit | `ENT-FR-012`, `ENT-FR-013`, `ENT-FR-014` |
| `ENT-AC-012` | For every governed write path, `check` is invoked before the caller's aggregate mutates; no compensation path substitutes for it | `ENT-FR-015`, `ENT-BR-005` |
| `ENT-AC-013` | `check` returns both an allow/deny decision and, for a counted feature, the remaining allowance | `ENT-FR-016`, `ENT-FR-022`, `ENT-FR-023` |
| `ENT-AC-014` | An exceeded counted allowance yields `entitlementExceeded`; a disabled gate yields `featureNotEnabled`; the two are never conflated | `ENT-FR-019` |
| `ENT-AC-015` | A read of entitlement state resolves without loading any `BC-20` subscription aggregate | `ENT-FR-020` |
| `ENT-AC-016` | No read or write interface accepts a shape that can return or mutate another tenant's entitlement; a probe with a foreign `tenantId` fails | `ENT-FR-021`, `ENT-INV-003` |
| `ENT-AC-017` | The module's published-event register is empty; a scan of the entitlement source finds no event publication | `ENT-FR-024` |
| `ENT-AC-018` | Every integration edge the module relies upon appears in BC Map §7, or is explicitly declined; the count of edges the module adds is zero | `ENT-FR-025`, `ENT-XC-012` |
| `ENT-AC-019` | The module's imports resolve to `contracts` only; a boundary check reports no `domain/**` or `app/**` import from entitlement code | `ENT-FR-027`, `ENT-XC-011` |
| `ENT-AC-020` | The term `Seat` does not appear in entitlement code as an allowance; `SeatQuota` is used instead; the CI language lint passes | `ENT-FR-028` |
| `ENT-AC-021` | No aggregate or value-object name owned by `BC-19`, `BC-20`, `BC-02`, `BC-04` or `BC-24` is declared inside entitlement code | `ENT-XC-001`, `ENT-XC-002`, `ENT-XC-006`, `ENT-XC-007`, `ENT-XC-010` |
| `ENT-AC-022` | Entitlement code emits no `billing.*` event and makes no payment-gateway call; it references neither `BZ-2` nor the `payment_gateway` port | `ENT-XC-003`, `ENT-XC-004` |
| `ENT-AC-023` | Entitlement code performs no proration arithmetic and initiates no money movement | `ENT-XC-005` |
| `ENT-AC-024` | Entitlement code resolves no feature flag and makes no authorisation decision; a flag being on does not by itself cause `check` to allow | `ENT-XC-008`, `ENT-XC-009`, `ENT-BR-004` |
| `ENT-AC-025` | `TenantTier` and `Quota` are read but never written by entitlement code; every `FeatureGate` and `Limit` value is reproducible from consumed inputs alone | `ENT-BR-003`, `ENT-INV-004` |
| `ENT-AC-026` | No student-to-library payment influences entitlement; a downgrade tightens gates eventually rather than synchronously; no grace period is applied from a hardcoded value | `ENT-BR-006`, `ENT-BR-008`, `ENT-INV-005` |

### 10.1 Coverage — computed, not asserted

| Measure | Value |
|---|---|
| Obligation-bearing identifiers (`ENT-FR` + `ENT-BR` + `ENT-INV` + `ENT-XC`) | **54** |
| Obligations carrying at least one acceptance criterion | **51** |
| **Coverage** | **94.4 %** |
| Obligations **not** covered | **3** — `ENT-FR-017`, `ENT-FR-018`, `ENT-FR-026` |
| Orphan criteria (mapping to no obligation) | **0** |
| Criteria proven by a passing test today | **0** |

The three uncovered obligations are uncovered for stated reasons, not by oversight:

| Uncovered | Why no criterion can be written yet |
|---|---|
| `ENT-FR-017` | Proving that *no caller needs a duplicate limit* is a property of callers in other bounded contexts. A criterion asserted here would test `BC-04`'s and `BC-02`'s code, which this PRD does not govern |
| `ENT-FR-018` | The configured per-feature disposition does not exist (`ENT-GAP-002`) and the decision that would create it is Open (`ENT-GAP-001`). A criterion would have to name a value this document may not invent |
| `ENT-FR-026` | Depends on whether a `BC-21` to `BC-24` edge is lawful, which is `H-1` (`ENT-GAP-005`). Writing a criterion would presume the answer |

---

## 11. Configurables

**This register is empty. `ENT-CFG-*` has zero entries.**

BC Map **L326** assigns a per-feature configuration decision to Config. `CONFIGURATION_GUIDE.md` (Rank 7) has
no entitlement entry — all seven matches for entitlement, quota, feature gate or usage count are OTP/SMS
values (`CFG-1`…`CFG-4`, `INV-4`). `ARCHITECTURE_RULINGS.md` (Rank 5) has no entitlement ruling.

`PRD_LIFECYCLE.md` L114 requires that *"Every configurable has a default and a range"* and that *"Unbounded
configuration is a specification hole."* Declaring a configurable here would require choosing both — a
decision `Q-03` has not made. The hole is recorded as `ENT-GAP-001` and `ENT-GAP-002` rather than filled.

---

## 12. Open gaps

| ID | Gap | Evidence | Severity | Owner | Status |
|---|---|---|---|---|---|
| `ENT-GAP-001` | `Q-03` — whether a timed-out `check` fails open or closed — is **Open**. BC Map §13's fourth column is headed *"Recommendation"* and its preamble says *"Each should become an ADR"*; the struck-through `Q-05` shows closure's visible form, which `Q-03` lacks | BC Map **L542**; `MASTER_PRD.md` **L675** | **High** | Architecture Owner | **OPEN.** `ENT-FR-018` is unsatisfiable until an ADR closes it |
| `ENT-GAP-002` | `E-17` requires the per-feature disposition to be *"recorded in Config"*. **No entitlement configurable exists at any rank** | `CONFIGURATION_GUIDE.md` — 7 matches, all OTP/SMS | **High** | Governance Owner and `BC-25` / `PRD-023` | **OPEN.** `ENT-CFG-*` empty by finding |
| `ENT-GAP-003` | `Q-06` — whether proration arithmetic belongs to `BC-02` (rules) or the Business Platform (execution) — is **Open** | BC Map **L545**; `MASTER_PRD.md` **L678** | **Medium** | Architecture Owner | **OPEN.** `ENT-XC-005` excludes it with an undetermined owner |
| `ENT-GAP-004` | `PRD-022` (`BC-20`, 962 lines) contains **zero** mentions of entitlement or `BC-21`, yet BC Map L437 makes `billing.EntitlementChanged` the only writer of this module's inputs and L382 makes its emission a `BC-20` invariant. This module's sole lawful input is unspecified by its owning document | An anchored grep over all 962 lines of `PRD-022` returns 0 | **High** | Product owner, `PRD-022` | **OPEN.** This PRD cites the BC Map and **does not author `BC-20`'s event** |
| `ENT-GAP-005` | `H-1` — BC Map §7 has no capability-to-capability subsection, so the `BC-20` to `BC-21` edge is published in §9 while absent from §7 | `PRD-013` **L431**, FROZEN | **High**, pre-existing and product-wide | Architecture Owner | **OPEN, inherited.** Compliant posture per `PRD-013`: decline any edge not in §7 |
| `ENT-GAP-006` | BC Map **L383** grants `BC-21` an aggregate; Matrix **L70** says rank R6 contexts *"own no domain aggregate"*. Both are Rank 4. `ENT-INV-005` records the module's conduct without adjudicating the tension | BC Map L383; Matrix L70 | **Low** | Architecture reviewer | **OPEN.** Reconcilable, but not reconciled by this document |
| `ENT-GAP-007` | `ADR-0035` and `ADR-0036` headers read Status ACCEPTED while their own changelogs read PROPOSED — `ADR-0035`: *"Left `PROPOSED`: no conferral of Architecture Owner authority was given"*; `ADR-0036`: *"`PROPOSED` — not accepted, not in force"*. Rank 2 force depends on status | Both files, header versus changelog | **Medium** | Governance Owner | **OPEN.** Both are cited here **with caution** and never as sole authority for an obligation |
| `ENT-GAP-008` | `IMPLEMENTATION_ROADMAP.md` contains **zero** entitlement references. `BC-21` has no implementation phase, though every write path depends on it | An anchored grep over the roadmap returns 0 | **Low** | Implementation lead | **OPEN.** This PRD does not edit the roadmap |

**All eight gaps are OPEN.** None is closed by this document, and none is presented as closed.

---

## 13. Contradictions with existing code

`lib/platform/business/business.dart` (92 lines) already contains an `EntitlementService`, with ten call sites
across five files. It was read in full. **No file under `lib/`, `packages/`, `test/` or `tool/` was modified by
this PRD** — the divergences are recorded, not repaired.

| ID | Contradiction | Location | Authority contradicted | Severity |
|---|---|---|---|---|
| `D-014-01` | `_limits` and `_gates` are **hardcoded `static const` maps** keyed on `TenantTier`, not derived from subscription events. Entitlement is therefore not derivable and a rebuild cannot be meaningful | `business.dart` | BC Map **L383**; Matrix **`X-11`**; yaml **`BZ-1`**; `ENT-FR-003`, `ENT-FR-004`, `ENT-INV-001` | **High** |
| `D-014-02` | The `check` operation takes a feature and an optional delta but **omits `tenantId`**; the tenant is read from an injected ambient `TenantContext` | `business.dart` | BC Map **L326**; `ENT-FR-013`, `ENT-FR-014` | **Medium** |
| `D-014-03` | The tier getter falls back to `TenantTier.starter` — a **silent default** for an unknown tenant | `business.dart` | Rank 1 `MP-GBR-07`; BC Map §9.1; `ENT-FR-009`, `ENT-BR-007` | **High** — tenant-scoping class, adjacent to `MP-RSK-01` |
| `D-014-04` | Usage is an **in-memory map**: no persistence, no outbox, no replay path. Separately, `lib/bootstrap/seed.dart:95–96` writes entitlement state directly by registering tenants against tiers | `business.dart`; `seed.dart:95,96` | BC Map **L383**; `X-11`; `BZ-1`; `ENT-FR-003`, `ENT-INV-002` | **Medium.** Whether a demo-seed write is a lawful bootstrap or an `X-11` violation is an architecture judgement, deferred to Stage 3 |
| `D-014-05` | **No entitlement test exists.** A filename search across `test/` returns nothing; the only mention is incidental, in `authentication_conformance_test.dart` | `test/` | `ENT-AC-001` through `ENT-AC-026` — none is proven | **Medium** |
| `D-014-06` | Three acknowledged dependency findings involve `EntitlementService`, all under `ADR-0012` §3.4. The soonest, at yaml **L612**, expires **2026-10-31**: *"EntitlementService imports the tenancy barrel for the `TenantTier` enum."* The others (L663, L692) expire 2027-03-31 | `tool/module_dependencies.yaml` | `ADR-0012` §3.4 governs them; not a new defect | **Low** |

`D-014-01` through `D-014-04` are the substance of Stage 6's work. `D-014-05` means every obligation this PRD
finds *already implemented* is **satisfied-in-place, not proven**.

---

## 14. Lifecycle position

| Stage | Status at this version | Gate artefact |
|---|---|---|
| 1 — Discovery | **PASS** | [`PRD-014_STAGE1_DISCOVERY.md`](PRD-014_STAGE1_DISCOVERY.md) |
| 2 — Draft | **this document** | this document, with §0.2 registers declared up front |
| 3 — Architecture Review | not yet | `PRD-014_ARCHITECTURE_ALIGNMENT.md` |
| 4 — Requirements Review | not yet | `PRD-014_STAGE4_REQUIREMENTS_REVIEW.md` |
| 5 — Traceability | not yet | `TRACEABILITY_MATRIX.md` §2K plus `PRD-014_STAGE5_CONFERRAL.md` |
| 6 — Implementation Tasks | not yet | an `IMPL-*` range plus `PRD-014_IMPLEMENTATION_TASKS.md` |
| 7 — Freeze | not yet | a row in `DOCUMENTATION_BASELINE.md` §3 |

**Registry status:** `PRD_REGISTRY.md` **L304** reads `PLANNED`. This document does not change it. Status is
conferred by the registry and the baseline, not by the existence of a file.

---

## 15. References

| Rank | Document | Lines relied upon |
|---|---|---|
| 1 | `MASTER_PRD.md` | **L191** (§8.1, this PRD's Rank 1 authority), L638 (V1 scope), L675 (`Q-03` Open), L678 (`Q-06` Open), `MP-GBR-06` and `MP-GBR-07` L337–338, `MP-GBR-08` and `MP-GBR-09` L339–340, `MP-GBR-18` L359, `MP-GBR-24` L362 |
| 1 | `PRD_LIFECYCLE.md` | L41–42 (gates), L44–56 (the nine stages), L62–72 (Stage 1), L79–86 (Stage 2), L90–120 (Stages 3 and 4), L252–259 (§5 identifier rules), L283 (`PGA-08`) |
| 1 | `PRD_REGISTRY.md` | **L304** (this PRD's row), §6 **L452** (uncontested), §7 (counts) |
| 1 | `DOCUMENTATION_BASELINE.md` | §7 (the four baseline-change rules) |
| 2 | `ADR-0012` | **L86** (the `domain/library` to `platform/business` edge; ports already declared), §3.4 (acknowledged debt) |
| 2 | `ADR-0017` | **L125–126** (flag versus entitlement), **L137**, L182 |
| 2 caution | `ADR-0035` | **L123** (exactly two contexts in `platform/business`), **L125**, **L235**, §3.1. Cited **with caution** — `ENT-GAP-007` |
| 2 caution | `ADR-0036` | L84–102, **L94**. Cited **with caution** — `ENT-GAP-007` |
| 4 | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **L130** (the context), **L211** (`SeatQuota`), **L259–271** (the tier bands), **L292** (§7 preamble), **L326** (`E-17`), **L337–345** (§7.4 `F-1` through `F-4`), **L352**, **L380–383** (the aggregate table), **L435–437** (inputs), **§9.1 L441–452**, **L467**, **§13 L542 and L545** |
| 4 | `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **L49 `L2`**, **L70 R6**, L195, L201, L306, **L360 `X-11`**, `X-13`, `ID-1` |
| 6 | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **L106** only, as corroboration. **Rank 6 is descriptive** — no requirement here derives from it. `PRD-008` **L480** is the precedent for declining to promote EA content |
| 3 | `PRD-005` Membership (FROZEN v1.4) | L170, **L240 `MM-FR-014`**, L763–764, **L1008 `MM-BR-013`** — cited, not restated |
| 3 | `PRD-007` Seat (FROZEN v1.0) | **L147**, L551 `G4`, L1187–1199, **L2128–2135** — cited, not restated |
| 3 | `PRD-008` Revenue (FROZEN v1.7) | **L1620 `D-08`**, L480 — cited |
| 3 | `PRD-013` Tenancy (FROZEN v0.1) | L107, **L157–159 `TEN-FR-006`**, **L321 `TEN-XC-006`**, **L431 `H-1`** — cited |
| 3 | `PRD-016` Audit (FROZEN v0.1) | **L273 `AUD-XC-007`**, and §0 as the register-declaration precedent — cited |
| 3 | `PRD-022` SaaS Billing (DRAFT v0.3) | Cited for its **silence** — `ENT-GAP-004` |
| — | `tool/module_dependencies.yaml` | the `platform/business` block (`BZ-1`, `BZ-2`, imports, banned imports); L612, L663, L692 (acknowledged findings) |
| 7 | `CONFIGURATION_GUIDE.md` | Cited for **absence** — `ENT-GAP-002` |
| 5 | `ARCHITECTURE_RULINGS.md` | Cited for **absence** — no entitlement ruling exists |

---

## 16. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-08-19 | Initial draft. `ENT-` prefix registered after an anchored collision scan returning 0. **88 identifiers declared across 8 registers**: `ENT-FR-001` to `028`, `ENT-BR-001` to `008`, `ENT-INV-001` to `006`, `ENT-XC-001` to `012`, `ENT-AC-001` to `026`, `ENT-GAP-001` to `008`; **`ENT-EVT-*` and `ENT-CFG-*` declared EMPTY by finding**. One aggregate (`EntitlementSet`) and three value objects claimed, per BC Map L383; **zero integration edges added**; **zero events published**. Twelve exclusions with named owners. Acceptance coverage **51 of 54, 94.4 %**, the three uncovered obligations named with reasons. Eight open gaps recorded, all OPEN. Six contradictions with existing code recorded; **no code modified** |
