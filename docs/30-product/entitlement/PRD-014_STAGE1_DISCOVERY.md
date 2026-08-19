# PRD-014 Entitlement — Stage 1 Discovery Record

| Field | Value |
|---|---|
| **Document** | `PRD-014_STAGE1_DISCOVERY.md` |
| **Subject PRD** | `PRD-014` Entitlement |
| **Bounded context** | **`BC-21` Entitlement** |
| **Lifecycle stage** | **Stage 1 — Discovery** |
| **Registry status sought** | `DISCOVERY` |
| **Version** | v1.0 |
| **Date** | 2026-08-19 |
| **Gate under test** | `PRD_LIFECYCLE.md` L72 — *"a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6"* |
| **Verdict** | **PASS** — see §10 |
| **Authority of this record** | None. This is a stage record, not a specification. It confers no requirement, no ownership and no rank. |

> `PRD_LIFECYCLE.md` L41–42: *"Each transition has a **gate**: a named artefact that must exist. A gate is not an
> opinion — if the artefact does not exist, the stage has not been passed, however complete the work feels."*
> This document exists so that Stage 1 has been passed rather than merely felt complete.

---

## 1. The four Stage 1 questions, answered against authority

`PRD_LIFECYCLE.md` L64–70 poses four questions and states what makes each one fail. Each is answered below with
the document, line and verbatim text that decides it. No answer is derived from judgement alone.

| # | Question | Fails if | Answer | Deciding authority |
|---|---|---|---|---|
| 1 | Does a bounded context own this? | It is a presentation composition — dashboards, Parent Portal. **No PRD** | **Yes.** `BC-21` Entitlement is a registered bounded context, not a screen | BC Map **L130**: `| **BC-21** | **Entitlement** | [GENERIC] | Business | V1 | Owns the answer to "is tenant T allowed to do X, and how much of it is left?" Single source of truth for limits and gates. |` |
| 2 | Does another PRD already own the context? | It is an amendment to that PRD, not a new one | **No.** `BC-21` appears in the *unwritten* row of the ownership table; **Contested = No** | `PRD_REGISTRY.md` **§6 L452**: `| BC-01…BC-05, BC-11…BC-13, BC-21…BC-24, BC-26, BC-27, BC-30, BC-31 | *(unwritten PRD-004…021)* | No |` |
| 3 | Is it V1/V2/V3, or Future? | Future ⇒ **stop** | **V1.** Two independent Rank 1/Rank 4 statements agree | BC Map **L130** (`V` column = `V1`); `MASTER_PRD.md` **L638** lists Entitlement among *"recovered V1 essentials"* |
| 4 | Does it own an aggregate **and** an invariant? | Owning neither ⇒ it is a capability of an existing context | **Yes — one aggregate and one invariant, both granted explicitly** | BC Map **L383** (quoted in full in §4.1) |

**All four questions pass.** No question is answered by inference; each cites a line.

### 1.1 The aggregate-and-invariant grant, verbatim

BC Map **L383** is the single line that satisfies question 4. It is quoted here exactly because everything
`PRD-014` may own, and nothing more, is contained in it:

```
| BC-21 Entitlement | `EntitlementSet` *(per tenant, read-optimised)* | `FeatureGate`, `UsageCounter`,
`Limit` | Derived state only — **never** hand-edited; recomputable from Subscription events
(rebuild-from-events must yield identical output) |
```

Parsed against the table's own column headers:

| Column | Value | Consequence for `PRD-014` |
|---|---|---|
| Context | `BC-21 Entitlement` | The subject |
| **Aggregate** | **`EntitlementSet`** *(per tenant, read-optimised)* | **Exactly one.** The PRD may own no second aggregate |
| **Value objects** | `FeatureGate`, `UsageCounter`, `Limit` | **Exactly three.** Not `Seat`, not `Quota`, not `TenantTier`, not `SubscriptionPlan` |
| **Invariant** | Derived state only — never hand-edited; recomputable from Subscription events (rebuild-from-events must yield identical output) | **One invariant, and it is a strong one**: derivability. It is the same rule the Dependency Matrix enforces as `X-11` and `tool/module_dependencies.yaml` asserts as `BZ-1` |

The user's instruction — *"EntitlementSet is the BC-21 aggregate and must not claim aggregates owned by other
PRDs"* — is therefore not an additional constraint layered on top of the repository. It is a restatement of
L383. §5 enumerates the aggregates that L383 withholds.

---

## 2. Mechanical ordering — what was measured before anything was concluded

Every claim in this record was produced by a command, not by reading impressions. The commands and their
results are recorded so a reviewer can re-run them.

| # | Measurement | Command shape | Result |
|---|---|---|---|
| M-01 | `ENT-` prefix collisions, anchored | `grep -rhoE '\bENT-[A-Z0-9-]+' docs/ tool/ lib/ packages/ test/ \| sort -u \| wc -l` | **0** |
| M-02 | `ENT-` substring hazard (reverse direction) | `grep -rhoE '.ENT-[A-Z]' docs/ tool/` | only **`MENT-R`** — the tail of `MANAGEMENT-`, never token-initial |
| M-03 | Next free `IMPL-*` block | `grep -rhoE 'IMPL-[0-9]+' docs/ tool/ \| sort -n -u` | 489 distinct ids; numeric tail `…929, 930, 999, 1000`; **all 5 `IMPL-1000` hits are boundary labels or a rejected alternative, never an assignment** ⇒ `IMPL-1000`+ free |
| M-04 | Entitlement configurables at Rank 7 | `grep -niE 'entitlement\|BC-21\|quota\|feature.?gate\|usage.?count' docs/20-configuration/CONFIGURATION_GUIDE.md` | **7 hits, every one OTP/SMS** (`CFG-1`…`CFG-4`, `INV-4`) ⇒ **zero entitlement configurables exist** |
| M-05 | Entitlement rulings at Rank 5 | same pattern against `ARCHITECTURE_RULINGS.md` | **0 entitlement rulings** |
| M-06 | Entitlement in BC-20's own PRD | same pattern against `PRD-022_SAAS-BILLING.md` (962 lines) | **0 hits** |
| M-07 | Entitlement in the implementation roadmap | same pattern against `IMPLEMENTATION_ROADMAP.md` | **0 hits** |
| M-08 | ADRs touching entitlement | `grep -rliE 'entitlement\|BC-21' docs/00-governance/adr/` | **8 of 52 files** |
| M-09 | Events published by `BC-21` | BC Map §9 event register, read in full | **0 published.** `BC-21` appears only as a consumer (L435, L436, L437) |
| M-10 | Entitlement tests | `find test -iname '*entitlement*'`; `grep -rln -i entitlement test/` | **0 test files**; one incidental mention in `authentication_conformance_test.dart` |
| M-11 | Existing implementation surface | `lib/platform/business/business.dart` read in full (92 lines) + all call sites | `EntitlementService` exists with 10 call sites across 5 files |
| M-12 | `PRD-014` rows in the registry | `grep -n 'PRD-014' docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | **1** — §4.2 **L304**, status `PLANNED` |
| M-13 | Working tree containment | `git status --porcelain`; `git status --short lib/ packages/ test/ tool/` | **0** / **0 lines** at the start of Stage 1 |

Ordering matters and was observed: **M-01 and M-02 ran before any identifier was chosen**, per
`PRD_LIFECYCLE.md` L82 rule 2 — *"prefixes chosen against §5's collision procedure **before** writing"*.
**M-03 ran before any `IMPL-*` number was contemplated**, per L139 — *"Take the next free range."*

---

## 3. The ownership check in full

The Stage 1 gate has two halves. Both are tested separately.

### 3.1 Half one — the context is in the Bounded Context Map

`BC-21` is present at BC Map **L130** with a complete row: ID, name, type `[GENERIC]`, owning platform
Business, version V1, and a responsibility sentence. It is not a footnote, an aspiration or an EA-only entry.

Its position in the map's tier bands was checked, because that position constrains Stage 3:

| Band | Contents | `BC-21` present? | Authority |
|---|---|---|---|
| FOUNDATIONAL | `BC-18`, `BC-19`, `BC-25` — **only these three** | **No** | BC Map **L271** |
| CAPABILITY & GENERIC | opens *"These MUST NOT import any domain context. They learn about the domain only via Published Language events and registered handler ports."*; its **first line** is `║  BC-21 Entitlement ◄── consulted by every write path      BC-27 AI Assistance   ║` | **Yes** | BC Map **L259–267**, `BC-21` at **L263** |

**Finding recorded, not assumed:** `BC-21` is a **capability-band** context. It is *consulted by* every write
path; it does not *sit beneath* them as a foundation. The distinction is load-bearing — the band preamble
forbids importing any domain context, which becomes Stage 3's rank-direction check and §5's exclusion list.

### 3.2 Half two — no other PRD owns the context

Three independent registers were checked, because a single register could be stale.

| Register | What it says about `BC-21` | Reading |
|---|---|---|
| `PRD_REGISTRY.md` **§6 L452** | `BC-21` is inside the group mapped to *(unwritten `PRD-004`…`021`)*, **Contested = No** | Assigned to a PRD identity that does not yet exist on disk. Not owned by any written PRD |
| `PRD_REGISTRY.md` **§4.2 L304** | `| PRD-014 | Entitlement | BC-21 | [GENERIC] | V1 | PLANNED | "Every paid gate depends on it" |` | The identity `PRD-014` is **already reserved for this exact context**. Creating it is not inventing a PRD to fill a gap; it is discharging a registered plan |
| `PRD_REGISTRY.md` **§7 counts** | `PLANNED` = **11**, and that set contains `PRD-014`; *Documents that exist* = **15 files / 13 identities** | `PRD-014` is among the eleven planned, not among the fifteen existing |

**Both halves of the gate pass.** The gate is satisfiable and satisfied.

### 3.3 The near-miss that had to be excluded

`BC-20` Subscription & Billing sits at BC Map **L129**, immediately above `BC-21`, and shares the same module.
Its PRD, `PRD-022`, **exists** (v0.3 `DRAFT`). Had `PRD-022` claimed entitlement, question 2 would have
failed and this work would be an amendment to `PRD-022` rather than a new PRD.

Measurement **M-06** settles it: `grep -niE 'entitlement|BC-21'` against all 962 lines of `PRD-022` returns
**zero hits**. `PRD-022` does not claim entitlement. Question 2 passes on evidence, not on the absence of
suspicion. §7 records the same measurement as a **finding against `PRD-022`**, because that silence is also a
defect — see `F-04`.

---

## 4. What `BC-21` owns — discovered, not assumed

Everything in this section is transcribed from an authority. Nothing is added.

### 4.1 The aggregate and its parts

From BC Map **L383** (quoted verbatim in §1.1):

| Kind | Identifier | Qualifier from L383 |
|---|---|---|
| Aggregate | **`EntitlementSet`** | *per tenant, read-optimised* |
| Value object | `FeatureGate` | — |
| Value object | `UsageCounter` | — |
| Value object | `Limit` | — |

The *per tenant* qualifier is not decoration. It binds `EntitlementSet` to the tenant-partitioning global rules
(`MP-GBR-08`, `MP-GBR-09`) and makes cross-tenant leakage *"the single highest-severity failure mode in the
architecture"* (`MASTER_PRD.md` L340) a live concern for this PRD rather than a generic caution.

The *read-optimised* qualifier, read together with the invariant *"Derived state only — never hand-edited"*,
tells us `EntitlementSet` is a **projection**, not a source of truth about money or plans. That reading is
corroborated at Rank 4 by Dependency Matrix **L70**, which names rank R6 *"BUSINESS (Subscription +
Entitlement) · WORKFLOW · AI — Higher-order capabilities. Orchestrate and decide, **own no domain
aggregate**."*

> **A tension recorded rather than resolved.** BC Map L383 grants `BC-21` an aggregate; Matrix L70 says rank R6
> owns *no domain aggregate*. These are reconcilable — `EntitlementSet` is a derived capability-band projection,
> not a domain aggregate — but the reconciliation is *mine*, not the repository's. It is recorded as finding
> **`F-09`** for Stage 3 to dispose of against the BC Map, which outranks nothing here but is the same rank as
> the Matrix. Stage 1 does not decide it.

### 4.2 The one invariant

`BC-21`'s invariant, from L383, in three clauses:

1. **Derived state only** — its content is a function of inputs it does not own.
2. **Never hand-edited** — no manual write path is lawful.
3. **Recomputable from Subscription events; rebuild-from-events must yield identical output** — a testable
   property, and the only one L383 states.

The Dependency Matrix enforces clause 2 as an explicit anti-pattern, **L360 `X-11`**:

```
| **X-11** | `BC-21 Entitlement` written by anything except Billing events | "Just grant this customer
the feature manually" | Entitlement stops being derivable; rebuild-from-events diverges; revenue
leakage is unauditable | Emit a `billing.EntitlementChanged` override event with actor + reason |
```

And `tool/module_dependencies.yaml` asserts it mechanically for the module:

```yaml
    - id: BZ-1
      rule: "entitlement state is written only by billing.EntitlementChanged handlers"   # X-11
```

Three documents at three ranks say the same thing. This is the strongest-supported rule in `BC-21`'s
territory, and `PRD-014` will cite all three rather than restate any.

### 4.3 The one inbound synchronous edge — `E-17`

BC Map **§7.3 L326**, verbatim:

```
| E-17 | All write paths | BC-21 Entitlement | `CF` | Sync port `check(tenantId, feature, delta)` |
Called **before** the aggregate mutates. Fail-closed on timeout for paid gates, fail-open for soft
limits — decided per feature, recorded in Config |
```

Four facts, each load-bearing:

| Fact | Consequence |
|---|---|
| Upstream is **"All write paths"** | `BC-21` is consulted universally. `ADR-0035` **L235** names `business.entitlement` one of *"the three 'all contexts / all write paths' edges"* alongside `E-18` (tenancy) and `E-19` (config) |
| Signature is **`check(tenantId, feature, delta)`** | `tenantId` is an **explicit argument**, not ambient. See finding `F-06` — the existing code omits it |
| **"Called before the aggregate mutates"** | Pre-write, not post-write. Corroborated by a source comment at `lib/domain/library/enrollment/enrollment.dart:79` |
| **"decided per feature, recorded in Config"** | Points at a register. **M-04 proves that register does not exist.** Finding `F-02` |

`BC-21` also appears in §7.5's relationship distribution, **L352**: `| Customer/Supplier (C/S) | 8 |
Core↔Core lifecycle dependencies, **Entitlement** |` — the only §7.5 row naming Entitlement.

### 4.4 The three inbound events — and the zero outbound

BC Map §9, **L435–437**:

```
| BC-19 | tenancy.TenantProvisioned / TenantSuspended | All, BC-21, BC-24 | Lifecycle gates |
| BC-20 | billing.SubscriptionActivated / Cancelled / PaymentFailed | BC-21, BC-22, BC-26, BC-24 | **Drives entitlement** |
| BC-20 | billing.EntitlementChanged | BC-21 | The only writer of entitlement inputs |
```

**Measurement M-09: `BC-21` publishes zero events.** It is a consumer in every §9 row that names it. This is
the same shape `PRD-016` found for `BC-24`, whose `AUD-EVT-*` register was consequently declared empty. The
conclusion for Stage 2 is identical and is recorded here so Stage 2 does not have to re-derive it:
**`ENT-EVT-*` must be declared EMPTY by finding**, with `BC-21`'s consumption of `E-17` inputs expressed as
requirements against the *events it consumes*, never as events it emits.

Consumption is governed by BC Map **§9.1** (L441–452), which `PRD-014` will cite rather than restate:
transactional outbox for atomicity; **at-least-once delivery, therefore every consumer must be idempotent,
keyed on `eventId`**; ordering per aggregate via partition key `aggregateId`, **not globally**; a ten-field
envelope (`eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`,
`causationId`, `aggregateId`, `payload`); and *"`tenantId` is mandatory on every domain event. A consumer that
processes an event without establishing tenant context must **fail loudly, not default**."*

That last clause is `MP-GBR-07` at Rank 1 as well, and it collides with the existing implementation — finding
`F-07`.

### 4.5 The module — shared, and this is the structural difference from all precedent

| Property | Value | Authority |
|---|---|---|
| Module | **`platform/business`** | `tool/module_dependencies.yaml`; Matrix L70 |
| Rank | **6** | yaml rank map; Matrix L70 |
| Co-tenant context | **`BC-20` Subscription & Billing** | `ADR-0035` **L123**: *"Which contexts sit in `platform/business`? **Exactly two** — `BC-20` Subscription & Billing, `BC-21` Entitlement (BC Map L129–L130)"* |
| Declared imports | `contracts` only | yaml |
| Declared ports | `platform/integration:payment_gateway` | yaml |
| Banned imports | `domain/**`, `app/**` | yaml |
| Module assertions | **`BZ-1`** (entitlement written only by `billing.EntitlementChanged` handlers) and **`BZ-2`** (every gateway call carries an idempotency key) | yaml |

The yaml block, verbatim:

```yaml
platform/business:
  rank: 6
  imports:
    - { target: contracts, mode: import }
  ports: [platform/integration:payment_gateway]
  consumes_events: ["*"]
  banned_imports: ["domain/**", "app/**"]
  assertions:
    - id: BZ-1
      rule: "entitlement state is written only by billing.EntitlementChanged handlers"   # X-11
    - id: BZ-2
      rule: "every gateway call carries an idempotency key"
```

**This is the single largest departure from the `PRD-016` precedent and is recorded as finding `F-01`.**
`PRD-016` owned `platform/audit` outright — a dedicated rank-5 module whose every assertion (`AU-1`…`AU-4`)
was `BC-24`'s. `PRD-014` owns **part** of `platform/business`. Concretely:

| Module artefact | Owner | `PRD-014` may claim it? |
|---|---|---|
| `BZ-1` — entitlement written only by billing handlers | **`BC-21`** (it is `X-11`, an entitlement rule) | **Yes** |
| `BZ-2` — gateway idempotency | **`BC-20`** (gateways are subscription/billing) | **No** |
| `ports: [platform/integration:payment_gateway]` | **`BC-20`** | **No** |
| `banned_imports: ["domain/**", "app/**"]` | Shared — binds both contexts | Cite, do not claim |
| `rank: 6` | Shared | Cite, do not claim |

Any `PRD-014` statement about `platform/business` must therefore be **partial and explicit about its
partiality**. A blanket claim over the module would silently annex `BC-20`'s territory and violate the user's
ownership instruction as surely as claiming `Subscription` itself.

### 4.6 The port name

`PRD-013` **L107** establishes the port-naming convention and names this port: `business.entitlement`. It
appears in the Dependency Matrix at **L195** (`- business.entitlement  # limit check before mutation`, inside
the `domain/library` block), **L306** (another module's port list), and in the yaml at **L118**, **L342** and
**L516** as a declared port. `ADR-0012` **L86** confirms the edge's direction is already lawful:

```
| domain/library | platform/business | 8 → 6 | 2 | **Yes — :entitlement, :payment_intent** |
```

The port is **already declared, already named, already directionally correct**. `PRD-014` does not create it
and must not rename it.

### 4.7 The ubiquitous-language constraint

BC Map **L211**:

```
| **Seat** | BC-04: a physical numbered position in a layout | BC-02: an allowance count in a plan
("2 seats included") | `Seat` (BC-04) vs `SeatQuota` (BC-21 Entitlement) |
```

`SeatQuota` is `BC-21`'s term; `Seat` is `BC-04`'s. The map adds that this is enforced by **a CI lint rule** —
*"Ubiquitous language is not documentation — it is a compile-time constraint."* `PRD-007` **L147**
independently attributes `SeatQuota` to `BC-21` (*"owned by `BC-21` Entitlement / published by `BC-02`"*), and
`PRD-005` **L240** `MM-FR-014` states *"It is the `SeatQuota` of BC Map line 211."*

Three documents agree. `PRD-014` may use `SeatQuota`; it may **not** use `Seat` for an allowance, and it may
not define the membership plan that publishes the quota — that is `BC-02`'s.

### 4.8 The existing implementation, read in full

`lib/platform/business/business.dart` (92 lines) already contains an `EntitlementService`. It was read in
full, and ten call sites were located across five files. Nothing was modified. Structure:

| Element | Shape |
|---|---|
| `enum Feature` | 5 members: `students`, `seats`, `branches`, `aiInsights`, `advancedReports` |
| `EntitlementService(this._tenantContext)` | constructor takes ambient `TenantContext` |
| `static const _limits` | **hardcoded** map `TenantTier → Feature → int` (`-1` = unlimited); starter 50/25/1, growth 300/150/3, pro −1/−1/−1 |
| `static const _gates` | **hardcoded** map `TenantTier → Set<Feature>`; starter `{}`, growth `{advancedReports}`, pro `{advancedReports, aiInsights}` |
| `_tiers`, `_usage` | in-memory `Map`s |
| `_tier` getter | `_tiers[...] ?? TenantTier.starter` — **silent default** |
| `check(Feature f, {int delta = 1})` | throws `DomainErrorCode.entitlementExceeded`; **no `tenantId` parameter** |
| `requireFeature`, `isEnabled`, `limitFor`, `usageOf`, `remaining`, `recordUsage`, `registerTenant` | as named |

Call sites (all read-only; none touched):

| File | Lines | Use |
|---|---|---|
| `lib/bootstrap/di.dart` | 78, 210 | field declaration and construction |
| `lib/bootstrap/seed.dart` | **95, 96** | `registerTenant(kDemoTenant, TenantTier.growth)` / `(kOtherTenant, TenantTier.starter)` |
| `lib/domain/library/enrollment/enrollment.dart` | 53, **79**, 80, 105 | L79 comment *"Entitlement is checked BEFORE the aggregate mutates (edge E-17)."*; `check(Feature.students)`; `recordUsage(..., 1)` |
| `lib/domain/library/seating/seating.dart` | 107, 192, 229, 253 | `recordUsage(Feature.seats, ±1)` |
| `lib/app/dashboards/ops_page.dart` | 66, 78, 81, 359, 360, 366, 367 | `isEnabled`, `limitFor`, `usageOf` for display |
| `packages/liboora_contracts/.../domain_error.dart` | 22, 23, 290, 291 | `entitlementExceeded`, `featureNotEnabled` error codes |

Four divergences from authority are visible in this code. They are recorded as findings `F-05`…`F-08` in §7 and
are **not** fixed here — the user's boundary is explicit: *"Do not modify lib/, packages/, or test/ for
implementation."* They become §11 *"Contradictions with existing code"* content in the Stage 2 PRD.

### 4.9 What exists nowhere

Four measurements returned zero, and each zero is itself a discovery:

| Absence | Measurement | Why it matters at Stage 1 |
|---|---|---|
| No entitlement **configurable** | M-04 | `E-17` says the per-feature fail policy is *"recorded in Config"*. There is no such record. `ENT-CFG-*` cannot be populated without invention |
| No entitlement **architecture ruling** | M-05 | Rank 5 is silent. No ruling to cite, and none to contradict |
| No entitlement **roadmap phase** | M-07 | Implementation sequencing for `BC-21` is unplanned |
| No entitlement **test** | M-10 | Nothing about `BC-21` is currently proven. Anything Stage 6 finds "already implemented" is **satisfied-in-place, not proven** — the same posture `PRD-016` adopted |

---

## 5. What `BC-21` does **not** own — exclusion candidates with named owners

BC Map L383 grants one aggregate. Every neighbouring aggregate belongs to someone else, and each has an
identifiable owner. These are the candidates for the Stage 2 `ENT-XC-*` register. Each row cites the authority
that assigns it elsewhere, so that no exclusion is an opinion.

| Not owned | Owner | Authority |
|---|---|---|
| `Tenant`, and the value objects `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` | **`BC-19`** Tenancy / `PRD-013` | BC Map **L380**; `PRD-013` **L157–159 `TEN-FR-006`** — TenantTier and Quota are **inputs** to entitlement derivation, never derived outputs, and *"The two value-object sets are disjoint"* |
| `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`, `PaymentAttempt`, `DunningState` | **`BC-20`** Subscription & Billing / `PRD-022` | BC Map **L382**; `ADR-0035` **L123** |
| The event `billing.EntitlementChanged` itself — its schema, its emission, its triggers | **`BC-20`** | BC Map **L437** *"The only writer of entitlement inputs"*; **L382** BC-20's invariant *"entitlement change emitted on every state transition"* |
| Money owed by a library to LIBOORA (plans, invoices, gateway, dunning, revenue recognition) | **`BC-20`** | BC Map **L129**; `MP-GBR-24` — library→LIBOORA and student→library money *"must never share a model, a table or a metric"* |
| Proration **arithmetic** and the money movement it causes | **Open** — `Q-06` names `BC-02` (delta) and Business (money) as a *recommendation*, not a decision | BC Map **L545**; `MASTER_PRD.md` **L678** (*"Open"*). See finding `F-03` |
| `MembershipPlan`, and the publication of `seatQuota` | **`BC-02`** Membership / `PRD-005` | `PRD-007` **L147** — `SeatQuota` *"owned by `BC-21` Entitlement / **published by `BC-02`**"*; `PRD-005` **L240** |
| `Seat` — a physical numbered position | **`BC-04`** Seat / `PRD-007` | BC Map **L211**; CI-lint enforced |
| Feature-flag definition, evaluation and rollout | **`BC-25`** Configuration / `PRD-023` | `ADR-0017` **L125–126**: *"a flag says **is this on**; an entitlement says **is this paid for**"*; **L137**: `PRD-023` owns *"not entitlement decisions (`BC-21`)"* |
| Authorisation decisions, credentials, OTP, sessions | **`BC-18`** Security | Matrix `X-13`, `ID-1`; Stage 3 checks 4 and 5 |
| Audit persistence — the `AuditEntry` aggregate | **`BC-24`** Audit / `PRD-016` | BC Map L383's BC-24 row; `PRD-016` **L273 `AUD-XC-007`** already excludes entitlement outputs from `BC-24`, the mirror of what `PRD-014` must exclude |
| Search indexing, analytics, notification, AI, workflow | Their own capability contexts | BC Map **§7.4 `F-1`** — *"**No capability context may import, reference, or query a domain context.** Not AI, not Analytics, not Search, not Notification, not Workflow, not Audit"* |

### 5.1 The reciprocity check

Three PRDs already exclude entitlement from themselves and name `BC-21` as the owner. Their exclusions and
`PRD-014`'s inclusions must be exact complements, or two documents disagree about a boundary.

| Existing exclusion | Says | Complement required of `PRD-014` |
|---|---|---|
| `PRD-013` **L321 `TEN-XC-006`** | `BC-19` MUST NOT define, store or compute `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` — owner **`BC-21`** | `PRD-014` must own exactly those four names, and no `BC-19` name |
| `PRD-016` **L273 `AUD-XC-007`** | `BC-24` MUST NOT define entitlement outputs — owner **`BC-21`** | Same four names; `PRD-014` must not claim `AuditEntry` |
| `PRD-013` **L157–159 `TEN-FR-006`** | `TenantTier` and `Quota` are **inputs** to entitlement derivation, never derived outputs; the two value-object sets are **disjoint** | `PRD-014` may consume `TenantTier`/`Quota`; it may not define them |

**The complements are exact.** The four names excluded by others are precisely the four granted by L383. No
boundary disagreement exists. This is a positive Stage 1 result and is recorded as such.

### 5.2 Frozen PRDs that consume `E-17` — cite, never restate

Three FROZEN PRDs already state conduct at the `E-17` boundary **on their own authority, for their own
modules**. `PRD-014` must cite them and must not generalise them.

| Frozen source | Statement | `PRD-014`'s posture |
|---|---|---|
| `PRD-005` **L1008 `MM-BR-013`** | *"If `BC-21` Entitlement times out, the policy **MUST** follow `Q-03`'s per-gate rule — paid gates fail-closed. Membership creation is a paid gate and therefore **MUST** fail closed."* | Cite. This binds **membership creation**, not all gates |
| `PRD-007` **L2128–2135 `SEAT-FR-295`/`296`** | MUST use `E-17` before mutation; MUST NOT implement its own seat-count limit because `BC-21` is *"the single source of truth for limits and gates"*; hard-counted ⇒ fail **closed** on timeout; acquiring an existing seat is **not** entitlement-counted | Cite. Binds **seat acquisition** |
| `PRD-007` **L1187–1199 `SEAT-FR-152`–`154`** | fail-closed, with an explicit note on *"why it does not contradict `Q-03`"* | Cite |
| `PRD-008` **L1620** | `| E-17 | BC-21 Entitlement | ❌ D-08 "Unsatisfied — no specification" | Medium |` | Cite as evidence that `PRD-014` is warranted. See §6 |

> **The trap, stated plainly.** Two frozen PRDs assert fail-closed behaviour. It is tempting to conclude that
> `BC-21` therefore has a platform-wide fail-closed rule. **It does not.** Each frozen statement is scoped to
> its own module's gate and derives its force from `Q-03`'s *recommendation* plus that module's own judgement
> that its gate is paid. Generalising them into a `BC-21` platform rule would be **inventing a business rule**
> — the exact prohibition the user stated. `Q-03` remains Open; see `F-03`.

---

## 6. Why this PRD is warranted — the demand already recorded in frozen documents

Question 1 asks whether a context owns this. A separate, weaker question is whether the PRD is *needed now*.
The repository has already answered it, in documents that are frozen and therefore cannot be dismissed as
drafting noise.

| Evidence | Where | Force |
|---|---|---|
| `E-17` is recorded as an **unsatisfied edge with a severity** | `PRD-008` **L1620**, FROZEN v1.7 — `D-08` *"Unsatisfied — no specification"*, Medium | A frozen Rank 3 document names `PRD-014`'s absence as a defect |
| Two frozen PRDs **depend on** `E-17` for correctness | `PRD-005` L972/L1008; `PRD-007` L195/L551 `G4`/L2128–2135 | The dependency exists whether or not the specification does |
| A third frozen PRD **excludes** entitlement and names `BC-21` as owner | `PRD-013` L321; `PRD-016` L273 | Two documents point at an owner with no document |
| Rank 1 lists Entitlement in V1 scope | `MASTER_PRD.md` **L638** | V1 commitment |
| Rank 1 §8.1 assigns it requirements, budget and an owner | `MASTER_PRD.md` **L191**: `| BC-21 Entitlement | Answers "is this tenant allowed to do X, and how much is left?" Every paid gate depends on it. |` | This §8.1 row — **not** a §8 module row — is `PRD-014`'s Rank 1 authority |
| The registry already reserves the identity | `PRD_REGISTRY.md` **L304** | Planned, not invented |

### 6.1 The Rank 1 authority is §8.1, not §8

`MASTER_PRD.md` §8's nineteen-module table was read in full (L151–170). **Module 17 is
`| 17 | SaaS Billing | BC-20 Subscription & Billing | [GENERIC] | V1 |`. There is no module row for `BC-21`.**

§8.1 (L185–196) exists precisely for this case, introduced as *"Bounded contexts absent from the v1.0 module
list … Listed here so they receive requirements, budgets and owners."* **L191 is `BC-21`'s row.**

This is the same authority shape `PRD-016`/`BC-24` and `PRD-013`/`BC-19` relied on. It is recorded explicitly
so that no later reviewer mistakes the absence of a §8 module row for absence of Rank 1 authority.

### 6.2 What `PRD-014` will and will not close

| Item | Effect |
|---|---|
| `D-08` (`PRD-008` L1620) | **Closed as a specification gap** by `PRD-014` existing — but `PRD-008` is FROZEN and `PRD-014` **must not edit it**. The closure is an effect to be *recorded*, not a change to be *made*. Post-freeze amendment of `PRD-008` would need its own ADR (`DOCUMENTATION_BASELINE.md` §7 rule 1) |
| `H-1` (`PRD-013` L431) | **Not closed.** Pre-existing, product-wide, owner Architecture Owner. `PRD-014` inherits it |
| `Q-03`, `Q-06` | **Not closed.** Closing either requires an ADR by an authority `PRD-014` does not hold |
| The missing Config register | **Not created.** `PRD-014` records the gap |

---

## 7. Findings carried forward

Every finding below was produced by a measurement. Each carries **evidence, severity, owner and disposition**,
per the user's instruction. Findings I considered and **rejected** are in §7.1 with reasons — because
`PRD_LIFECYCLE.md` L104 holds that *"A review that records only accepted findings is indistinguishable from a
review that found nothing."*

| ID | Finding | Evidence | Severity | Owner | Disposition |
|---|---|---|---|---|---|
| **`F-01`** | `BC-21` **shares** module `platform/business` with `BC-20`; unlike `PRD-016`, which owned `platform/audit` outright. Module assertions are split: `BZ-1` is `BC-21`'s, `BZ-2` is `BC-20`'s | `ADR-0035` L123 (*"Exactly two"*); Matrix L70; yaml `platform/business` block | **High** (structural, affects every ownership claim) | Product owner, `PRD-014` | **Accepted.** Stage 2 must scope every module claim to `BC-21` explicitly and cite `BZ-2`/`payment_gateway` as `BC-20`'s. Stage 3 check 1 re-tests it |
| **`F-02`** | `E-17` states the per-feature fail-open/fail-closed choice is *"recorded in Config"*. **No entitlement configurable exists at Rank 7** | M-04: 7 hits in `CONFIGURATION_GUIDE.md`, all OTP/SMS (`CFG-1`…`CFG-4`, `INV-4`) | **High** | Governance owner + Product owner, `BC-25`/`PRD-023` | **Accepted.** Becomes an `ENT-GAP-*`. `ENT-CFG-*` declared **EMPTY by finding**, mirroring `AUD-CFG-*`. Inventing a default would be inventing a configuration value |
| **`F-03`** | `Q-03` (fail-open vs fail-closed) and `Q-06` (proration ownership) are **Open recommendations, not decisions**, at both Rank 4 and Rank 1 | BC Map L542, L545 — §13's fourth column is headed **"Recommendation"** and its preamble says *"Each should become an ADR"*; `~~Q-05~~` shows closure's visible form (struck through, *"CLOSED 2026-08-04 by ADR-0011"*), which neither has; `MASTER_PRD.md` L675, L678 both read **"Open"** | **High** | Architecture Owner | **Accepted.** Recorded as `ENT-GAP-*`. `PRD-014` **MUST NOT** adopt either recommendation as a rule. Frozen module-scoped assertions (`MM-BR-013`, `SEAT-FR-296`) are **cited, not generalised** |
| **`F-04`** | `PRD-022` (BC-20, 962 lines, v0.3 DRAFT) contains **zero** mentions of entitlement or `BC-21`, yet BC Map L437 makes `billing.EntitlementChanged` *"The only writer of entitlement inputs"* and L382 makes emission a `BC-20` invariant. `BC-21`'s sole lawful input event is unspecified by its owning document | M-06 | **High** | Product owner, `PRD-022` | **Accepted.** `PRD-014` cites the BC Map for the event and records the counterparty's silence as an `ENT-GAP-*`. It **may not author `BC-20`'s event** |
| **`F-05`** | `EntitlementService._limits` and `_gates` are **hardcoded `static const` maps**, not derived from Subscription events — against BC Map L383 (*"recomputable from Subscription events"*), `X-11` and `BZ-1` | `lib/platform/business/business.dart`, read in full | **High** | Implementation lead | **Accepted.** Stage 2 §11 *"Contradictions with existing code"*. **No code change at Stages 1–7** |
| **`F-06`** | `check()`'s signature is `check(Feature f, {int delta = 1})` — it **omits the `tenantId` argument** that `E-17` specifies | `business.dart`; BC Map L326 | **Medium** | Implementation lead | **Accepted.** Stage 2 §11; Stage 6 task |
| **`F-07`** | `_tier` returns `_tiers[...] ?? TenantTier.starter` — a **silent default** for an unknown tenant, against `MP-GBR-07` and BC Map §9.1 (*"fail loudly, not default"*) | `business.dart`; `MASTER_PRD.md` L338; BC Map §9.1 | **High** (tenant-scoping class; `MP-RSK-01` adjacency) | Implementation lead | **Accepted.** Stage 2 §11; Stage 3 check 6 re-tests tenant scoping |
| **`F-08`** | `_usage` is an **in-memory `Map`** — no persistence, no outbox, no rebuild path, so *"rebuild-from-events must yield identical output"* is untestable as built. **`lib/bootstrap/seed.dart:95–96` writes entitlement state directly** via `registerTenant`, an `X-11`/`BZ-1` candidate | `business.dart`; `seed.dart:95,96` | **Medium** | Implementation lead | **Accepted.** Stage 2 §11; Stage 6 task. Seed-path lawfulness is a judgement Stage 3 should make, not Stage 1 |
| **`F-09`** | BC Map L383 grants `BC-21` an **aggregate**; Matrix L70 says rank R6 contexts *"own no domain aggregate"*. Both are Rank 4 | BC Map L383; Matrix L70 | **Low** (reconcilable: `EntitlementSet` is a derived capability projection, not a domain aggregate) | Architecture reviewer | **Accepted as a question, not resolved.** The reconciliation above is *mine*, not the repository's. Stage 3 disposes of it |
| **`F-10`** | `ADR-0035` and `ADR-0036` headers read `Status | ACCEPTED` while their own changelogs say `PROPOSED` (`ADR-0035`: *"Left `PROPOSED`: no conferral of Architecture Owner authority was given"*; `ADR-0036`: *"`PROPOSED` — not accepted, not in force"*). Rank 2 force depends on status | Both ADR files, header vs changelog | **Medium** | Governance owner | **Accepted.** Recorded, **not silently resolved in either direction**. `PRD-014` cites both **with caution**, and never as sole authority for an obligation |
| **`F-11`** | **No entitlement test exists anywhere** | M-10 | **Medium** | Implementation lead | **Accepted.** Any obligation Stage 6 finds already implemented is **satisfied-in-place, not proven**; every such obligation still needs a task binding it to a test |
| **`F-12`** | `IMPLEMENTATION_ROADMAP.md` contains **zero** entitlement references — `BC-21` has no implementation phase, though every write path depends on it | M-07 | **Low** | Implementation lead | **Accepted.** Recorded. `PRD-014` **must not** edit the roadmap; §12 of the Stage 2 PRD notes the absence |
| **`F-13`** | `H-1` (`PRD-013` L431) — BC Map §7 has **no capability→capability subsection**, so `BC-20`→`BC-21` is *"published in §9 while absent from §7"*. `PRD-014`'s only lawful input arrives across exactly that missing taxonomy | `PRD-013` L431, FROZEN | **High**, but **pre-existing and inherited** | Architecture Owner | **Accepted as inherited.** Stage 3 will be **CONDITIONAL on `H-1`**, exactly as `PRD-013`'s was. The compliant posture is `PRD-013`'s: *"**decline** any edge not in §7, never invent one"* |
| **`F-14`** | The three acknowledged `EntitlementService` dependency findings in `module_dependencies.yaml` (all `adr: ADR-0012`) include one expiring **2026-10-31** — the soonest of the three | yaml L612 (TenantTier barrel, expires 2026-10-31), L663, L692 (both 2027-03-31) | **Low** | Implementation lead | **Accepted.** Recorded so Stage 6 can sequence against a real date. **Not repaired** — `ADR-0012` §3.4 is the governing mechanism |

### 7.1 Findings considered and **rejected**, with reasons

`PRD_LIFECYCLE.md` L104: *"**A rejected finding must be recorded as rejected, with its reason.**"*

| ID | Candidate finding | Why rejected |
|---|---|---|
| `R-01` | *"`ENT-` collides with `MANAGEMENT-`"* | Measurement M-02 shows the only substring match is `MENT-R`, the tail of `MANAGEMENT-`. It is never token-initial, so an anchored `\bENT-` scan cannot match it. **Not a collision.** The reverse-direction hazard is real but different, and is `R-02` |
| `R-02` | *"`ENT-INV-*` collides with the platform `INV-n` register"* | `INV-n` is indeed a live platform-invariant prefix (`TRACEABILITY_MATRIX.md` L82, `INV-1`…`INV-16`), and `INV-SEC-*`/`INV-XC-*` exist. But `ENT-INV-001` is a distinct token from `INV-1`; the prefixes are `ENT-INV-` and `INV-`. **Not a collision** — however the **scan must be anchored**, or a naive `grep 'INV-'` will over-count. Rejected as a collision; **carried as a Stage 5 scanning requirement** |
| `R-03` | *"`IMPL-1000` is already taken — five occurrences exist"* | All five were inspected. `ADR-0051:406` (*"`IMPL-1000`+ remains…"*), `PRD-016_STAGE6…:124` (*"`IMPL-900` is occupied; start at `IMPL-1000`"* — a **rejected alternative**), `PRD-016_IMPLEMENTATION_TASKS.md:89`, `:114` (`| IMPL-1000 + | Unallocated | — |`), `:404`. Every one is a **boundary label or a discarded option**, never an assignment. **Occurrence is not occupancy.** Rejected — but the reasoning is disclosed rather than filtered, because the distinction is exactly what a careless grep would get wrong |
| `R-04` | *"`Q-03` recommends per-gate fail-closed for paid features, so `PRD-014` should adopt it — two frozen PRDs already do"* | **Rejected as invention.** BC Map §13's column is headed *"Recommendation"*; its preamble says *"Each should become an ADR"*; `~~Q-05~~` demonstrates that closure has a visible form neither `Q-03` nor `Q-06` has; `MASTER_PRD.md` L675/L678 both read **"Open"**. The frozen assertions (`MM-BR-013`, `SEAT-FR-296`) bind **their own gates on their own authority** and are cited, not generalised. Adopting `Q-03` platform-wide would create a Rank 3 business rule from a Rank 4 suggestion |
| `R-05` | *"EA lists `Quota Tracking (V2)`, `Overage Handling (V3)`, `Grace Periods (V2)` under Entitlement Service, so `PRD-014` should specify them"* | **Rejected.** `LIBOORA_ENTERPRISE_ARCHITECTURE.md` is **Rank 6 — descriptive only** (`DOCUMENTATION_BASELINE.md` §4). Rank 6 cannot mint requirements. Precedent is explicit: `PRD-008` **L480** already ruled that EA's *"Grace Periods (V2)"* is a `BC-21` SaaS quota and *"a different concept"* from the fee-side notion. EA is cited as corroboration only, never as a source of obligation. Additionally V2/V3 items fail Stage 1 question 3 for V1 scope |
| `R-06` | *"`PRD-008` L1620's `D-08` should be marked closed, since `PRD-014` now specifies `E-17`"* | **Rejected as an action; accepted as an effect.** `PRD-008` is FROZEN v1.7. `DOCUMENTATION_BASELINE.md` §7 rule 1 requires an ADR **before** changing any Rank 1–5 document, and `PRD_LIFECYCLE.md` L180 states *"A frozen PRD is never silently modified."* The closure is recorded in §6.2 as an effect for a future controlled amendment |
| `R-07` | *"The stale `IMPL-227+` table in `PRD_LIFECYCLE.md` L147–153 should be corrected while we are here"* | **Rejected.** It is Rank 1. `IMPL-227` is in fact taken by Student Identity growth, so the table is wrong — but repairing it requires its own ADR, and both `ADR-0049` and `ADR-0051` derived their ranges **by measurement** rather than from the table. `PRD-014` does the same (M-03) and **leaves the table untouched**. Standing deferred |
| `R-08` | *"`ADR-0035`/`ADR-0036` should be corrected to whichever of header or changelog is right"* | **Rejected as an action.** Deciding which is authoritative is a Governance Owner act. Recorded as `F-10` with a named owner; `PRD-014` cites both with caution and never as sole authority. Silently "fixing" either would be a governance change disguised as tidying |
| `R-09` | *"`seed.dart:95–96` violates `BZ-1` and should be reported as a code defect"* | **Partially rejected.** The write is real and is recorded in `F-08`. But whether seeding a demo tenant is a lawful bootstrap operation or an `X-11` violation is an **architecture judgement**, and Stage 1 does not make architecture judgements. Recorded as a candidate; **disposition deferred to Stage 3** |
| `R-10` | *"`BC-21` is foundational, since every write path consults it"* | **Rejected on measurement.** BC Map **L271** names the FOUNDATIONAL band as **exactly `BC-18`, `BC-19`, `BC-25`**. `BC-21` is the first line of the **CAPABILITY & GENERIC** band (L263). *Consulted by* every write path is not the same as *beneath* every write path. The distinction changes Stage 3's rank-direction check, so getting it wrong would have propagated |
| `R-11` | *"`PRD-014` should specify `billing.EntitlementChanged`'s schema, since `PRD-022` does not (`F-04`)"* | **Rejected as invention of an event.** BC Map L437 assigns the event to `BC-20` as *"The only writer of entitlement inputs"*; §7.4 `F-2` requires capability contexts to learn about the domain *"exclusively through Published Language events defined in `liboora_contracts`"*. `PRD-014` may state what it **requires of** an event it consumes; it may not author the publisher's contract |
| `R-12` | *"`PRD-014` should own `SeatQuota`'s value, since `SeatQuota` is a `BC-21` term"* | **Rejected on a distinction the sources make explicitly.** `PRD-007` L147: `SeatQuota` is *"owned by `BC-21` Entitlement / **published by `BC-02`**"*. Owning the **concept and enforcement** is not owning the **plan that sets the number**. Conflating them would annex `BC-02`'s `MembershipPlan` |

---

## 8. Prerequisites verified before proceeding

| Prerequisite | Method | Result |
|---|---|---|
| Working tree clean at start | `git status --porcelain` | **0 lines** |
| No implementation code touched | `git status --short lib/ packages/ test/ tool/` | **0 lines** |
| `PRD-014` identity reserved for `BC-21` | `PRD_REGISTRY.md` L304 | Confirmed, `PLANNED` |
| `BC-21` uncontested | `PRD_REGISTRY.md` §6 L452 | Confirmed, **Contested = No** |
| Prefix `ENT-` free (anchored) | M-01 | **0** hits |
| `IMPL-1000`+ free | M-03 | Confirmed by measurement, not by the stale table |
| Target directories | `mkdir -p docs/30-product/entitlement docs/40-implementation/entitlement` | Created; neither previously existed |
| Stage 1 gate artefact | this file | Exists on disk |

---

## 9. What this record deliberately does **not** do

| Not done | Why |
|---|---|
| Issue any `ENT-*` identifier | Identifiers are Stage 2's, declared up front with ranges (`PRD_LIFECYCLE.md` L79–86) |
| Allocate `IMPL-1000`+ | Stage 6's gate. M-03 only establishes availability |
| Decide `Q-03` or `Q-06` | Requires an ADR by the Architecture Owner. `F-03` |
| Invent a fail-open/fail-closed default, or any Config value | `F-02`. No Rank 1–7 document bounds one |
| Author `billing.EntitlementChanged` | `BC-20`'s. `R-11` |
| Fix the four `EntitlementService` defects | `F-05`…`F-08`. The user's boundary forbids touching `lib/` |
| Edit `PRD-008` to close `D-08` | Frozen. `R-06` |
| Edit the stale `PRD_LIFECYCLE.md` `IMPL` table | Rank 1, needs its own ADR. `R-07` |
| Resolve the `ADR-0035`/`0036` status discrepancy | Governance Owner's. `R-08`, `F-10` |
| Restate any frozen PRD | The user's instruction, and `MP` two-sources-of-truth hygiene. §5.2 |
| Claim `platform/business` as `BC-21`'s | `F-01`. `BZ-2` and `payment_gateway` are `BC-20`'s |
| Confer any status on `PRD-014` | Status is conferred by the registry and the baseline, not by a stage record |

---

## 10. Verdict

| Gate element | Required | Actual | Result |
|---|---|---|---|
| Context identified in the Bounded Context Map | Yes | `BC-21`, BC Map **L130** | **PASS** |
| Not already owned in `PRD_REGISTRY.md` §6 | Yes | §6 **L452**, Contested = **No** | **PASS** |
| Q1 — a bounded context owns it | Yes | `BC-21` is a context, not a composition | **PASS** |
| Q2 — no other PRD owns the context | Yes | `PRD-022` measured silent (M-06); §6 uncontested | **PASS** |
| Q3 — V1/V2/V3, not Future | Yes | **V1** (BC Map L130; `MASTER_PRD.md` L638) | **PASS** |
| Q4 — owns an aggregate **and** an invariant | Yes | `EntitlementSet` + derivability, BC Map **L383** | **PASS** |
| Gate artefact exists on disk | Yes | this file | **PASS** |

### **Stage 1 verdict: PASS.**

`PRD-014` is warranted. `BC-21` Entitlement is a V1 bounded context that owns one aggregate and one invariant,
is claimed by no other PRD, and is already depended upon by three FROZEN PRDs — one of which (`PRD-008`
L1620) records its absence as a defect with a severity.

**14 findings accepted** (`F-01`…`F-14`), **12 candidate findings rejected with reasons** (`R-01`…`R-12`).
Four of the accepted findings (`F-02`, `F-03`, `F-04`, `F-13`) are specification gaps that `PRD-014` must
**record rather than fill**; four (`F-05`…`F-08`) are code contradictions it must **document rather than
fix**.

Stage 1 passing does **not** confer `DISCOVERY` status in the registry, and this record does not claim it.
Registry status is conferred by an edit to `PRD_REGISTRY.md`, which the lifecycle reserves for the controlled
Stage 7 update.

**Proceed to Stage 2 — Draft.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Stage 1 Discovery record created. Four Stage 1 questions answered against cited authority; gate tested in both halves; `BC-21`'s single aggregate, three value objects and one invariant transcribed from BC Map L383; eleven exclusion candidates named with owners; reciprocity with `TEN-XC-006`/`AUD-XC-007` verified exact; 13 mechanical measurements recorded; 14 findings accepted with evidence/severity/owner/disposition; 12 candidate findings recorded as rejected with reasons. Verdict **PASS** |
