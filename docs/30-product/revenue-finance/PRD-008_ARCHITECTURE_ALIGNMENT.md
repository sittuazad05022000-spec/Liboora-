# `PRD-008` Revenue & Finance v0.5 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 3) |
| **Subject** | [`PRD-008_REVENUE-AND-FINANCE.md`](PRD-008_REVENUE-AND-FINANCE.md) — `PRD-008`, `BC-05` Fee & Collection, **v0.5 `DRAFT`** |
| **Gate addressed by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) · [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Reviewed at** | `61e6950` |
| **PRD hash at review** | `3f91476aa82dc798dcfe2e08d5d47bda871874a519910fee683a8e9c022047fd` — to be re-verified after this record is written |
| **Mandate** | **Stage 3 only.** No PRD requirement added or changed by this record, no ADR authored or accepted, no ranked document touched, no registry or baseline update, no freeze. Stages 4–7 not started |
| **Verdict** | ⛔ **NOT ALIGNED — 5 of 6 checks PASS, 1 check BLOCKED.** Check 2 (integration edges) is **BLOCKED** by `FEE-GAP-002`: the module has no declared path to a payment gateway. 0 conflicts created by this PRD · 2 pre-existing Rank-4/Rank-6 defects raised, not chosen (§8.1) · 15 gaps, 5 of them blocking, listed with owners (§8.3) · 6 findings rejected with reasons (§9) |

> **Why the verdict is NOT ALIGNED, and why that is the correct outcome rather than a failure of this review.**
> Stage 3's second check is *"every integration edge exists in BC Map §7"*, whose stated failure mode is
> *"if an edge is not in this table, it does not exist — needs an ADR."* `PRD-008` must execute online payments,
> and **no edge from `BC-05` to any gateway-bearing context exists**. That is a real architectural hole owned by
> the Architecture Owner. Declaring ALIGNED would require either inventing an edge or pretending the module has
> no online-payment obligation. Both are forbidden. The record therefore reports 5/6 and names the authority.

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line, re-read at its source at
`61e6950`. Nothing is asserted from memory, and no claim the PRD makes about a ranked document is taken on trust.

Where the PRD conflicts with a higher-precedence document,
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
never which to ignore. Per §4: *"A conflict is a defect. If you find one, do not choose — raise it."*

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD global rules | `docs/30-product/MASTER_PRD.md` | **1** |
| 2 | Accepted ADRs | `docs/00-governance/adr/` | **2** |
| 3 | Authentication PRD v2 | `docs/30-product/authentication/prd-v2/` | **3** |
| 4 | Membership Management PRD v1.4 **FROZEN** | `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **3** |
| 5 | Student Identity PRD v1.0 | `docs/30-product/student-identity/Student_Identity_PRD_v1.md` | **3** |
| 6 | Library PRD v1.1 **FROZEN** | `docs/30-product/library/Library_PRD_v1.md` | **3** |
| 7 | Bounded Context Map v1.7 | `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 8 | Module Dependency Matrix v1.3 | `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 9 | Enterprise Architecture v2.1 | `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **6** — descriptive only |
| 10 | Configuration Guide v1.1 | `docs/20-configuration/CONFIGURATION_GUIDE.md` | **7** |

### 1.2 Classification scheme

| Mark | Meaning |
|---|---|
| ✅ **PASS** | The PRD conforms; evidence cited |
| ⛔ **BLOCKED** | Conformance cannot be established because an authoritative decision does not exist. Not a PRD defect |
| ⚠ **RAISED** | A defect in a *ranked* document, surfaced per §4. Not resolved here |

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

**Verified in the PRD.** `PRD-008` §42 refuses the platform-commission model outright and routes it to `BC-20`
via `FEE-GAP-014`. Critically, `FEE-FR-060`'s confirmed-payment snapshot **deliberately carries no commission,
gateway or tax field** — the PRD states that adding one *"would perform that merger **in the schema**, which is
where it matters."* This is the strongest available evidence of compliance: the boundary is honoured in the data
model, not merely in prose.

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
platform (`BC-05`/`BC-20`) is enforced at model level.

---

## 3. Check 2 — Every integration edge exists in BC Map §7

**Authority:** BC Map §7, L292 — *"If an edge is not in this table, it does not exist."*

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

### 3.2 ⛔ **BLOCKED — the payment gateway has no lawful path**

Measured at HEAD:

| Fact | Measurement |
|---|---|
| Edges `BC-05` → `BC-31` Integration | **0** |
| Edges `BC-05` → `BC-30` Offline Sync | **0** |
| Edges `BC-05` ↔ `BC-20` | **0** |
| `E-25` | **`BC-20` → `BC-31`** (L334) — Billing's gateway abstraction, *not* `BC-05`'s |
| `E-24` | **`BC-03` → `BC-30`** (L333) — Attendance's offline sync, *not* `BC-05`'s |
| Dependency Matrix **L167** | `LIBRARY MANAGEMENT → INTEGRATION` = **`✖`** — *"Integration is reached only via BUSINESS (payments)"* |
| Dependency Matrix **L352** (`X-03`) | Anti-pattern *"just call Razorpay from the payment service"* → *"Call `business.payment_intent` port"* |
| `business.payment_intent` (L196) | A **named port**, with **no numbered edge** from `BC-05` |
| `PRD_DEPENDENCY_GRAPH.md` **L116** (`D-14`) | Asserts *"`PRD-008` … `E-25`"* — ⚠ **but `E-25`'s source is `BC-20`, not `BC-05`** |

**Two things follow, and the PRD gets both right.** First, the lawful shape is *not* `BC-05` → gateway; the
architecture already forbids it twice (L167, `X-03`). The candidate lawful shape is
`BC-05` → an approved business-layer payment port → `BC-31`. Second, **that port has no numbered edge**, so
under L292 it does not exist as an edge, and `PRD-008` correctly declines to specify online payment rather than
inventing one. **No webhook schema, vendor contract, endpoint or gateway payload appears anywhere in the PRD** —
verified by scan.

⚠ **RAISED (pre-existing, not created by this PRD):** `D-14` in `PRD_DEPENDENCY_GRAPH.md` L116 attributes `E-25`
to `PRD-008`. `E-25` is `BC-20` → `BC-31`. This is a defect in the dependency graph, raised per §4 and **not
corrected here** — correcting it is the Architecture Owner's act.

### 3.3 Outbound restraint

`PRD-008` publishes exactly three `fee.*` events and adds no consumer edge. It does **not** claim `BC-26`
Analytics as a subscriber, avoiding the systemic `MM-GAP-010` defect where BC Map §9 names consumers §7 denies.

### 3.4 Result — ⛔ **BLOCKED**

Nine declared edges all verified present. **One required capability — online payment — has no declared edge, and
the PRD refuses to invent one.** Owner: **Architecture Owner**. Tracked as **`FEE-GAP-002`**.

---

## 4. Check 3 — Rank direction is downward

**Authority:** Dependency Matrix `L2`. **Failure:** illegal import.

| Dependency | Direction | Lawful under |
|---|---|---|
| `BC-05` → `BC-06`, `BC-02`, `BC-01` | Intra-cluster | Matrix **L89** — Core Library cluster, allow-list `E-01`…`E-10` |
| `BC-05` → `BC-21`, `BC-19`, `BC-25`, `BC-24`, `BC-22` | Domain → platform/generic | Downward; `E-17`…`E-23` are declared *"all contexts"* edges |
| `BC-05` → `BC-31` Integration | **Not claimed** | Would be **illegal** — Matrix L167 `✖` |

**The forbidden upward direction is honoured by abstention**, which is the strongest form: the module does not
import Integration, and the one place it would want to (payments) it leaves unspecified rather than reaching.

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

### 5.2 The `PR-1` question — resolved *by consuming* the existing model, not by extending it

The product intent requires that a platform authority may change the commission rate and the renewal-protection
window, and that Owner, Manager, Reception and Student may not. Measured against Rank 3
`prd-v2/02` **L123-127**:

> `PR-1` Platform Administrator — **Purpose:** *"…provision and suspend tenants, **manage platform
> configuration**, administer platform-level security"* · **Scope:** *"platform-level objects only — tenants as
> entities, **platform configuration**, platform role assignments"*

**Managing platform configuration is already inside `PR-1`'s defined scope.** Therefore:

| Requirement of the intent | Satisfied by | New rule needed? |
|---|---|---|
| A platform authority CAN change it | **`PR-1`**, existing | **No** |
| Owner / Manager / Reception / Student CANNOT | `AUTH-7.14` — a library role is scoped to exactly one library and *"confers nothing in any other"*; a tenant role cannot reach a platform-level object | **No** |
| Platform authority must not reach tenant data | `AUTH-7.13`, `AUTH-7.61`, `XC-7.13` | **No** |
| Provisioned internally, never self-registered | `AUTH-7.49` invite-only, *"no self-service path may exist"*; `AUTH-2.6` assigned only by another Platform Administrator | **No** |
| Attributable and auditable | `AUTH-2.7`, `AUTH-7.71`, `AUTH-7.40` | **No** |

**No new platform role is proposed and *"Two, closed"* (`prd-v2/07` L79) stands untouched.** What remains open is
narrower and is **not** an authorisation decision made here: a **named permission** in the catalogue
`AUTH-7.22` declares closed but never enumerates, and a **parameter row** in a configuration register. Both are
carried by `FEE-GAP-015` to the `BC-18`/`PRD-001` and `BC-25`/`PRD-023` owners. `AUTH-7.64` is recorded as a
standing constraint: the grant must be configuration authority, never authority over the policy model.

### 5.3 Result — ✅ **PASS**

`PRD-008` decides no authorisation, creates no role, enumerates no permission, and caches no decision.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

**Authority:** `ID-1`.

Exhaustive scan of `PRD-008` for `password`, `OTP`, `credential`, `session token`, `secret`: **the module stores,
issues, validates and caches none.** `FEE-FR-053` names the *acting role*, which is a decision output consumed
from `BC-18`, not a credential.

**Result — ✅ PASS.**

---

## 7. Check 6 — Tenant isolation

**Authority:** `MP-GBR-08`, `X-13`. **Failure:** cross-tenant leak — `MP-RSK-01`, Critical.

### 7.1 Every tenant-bearing surface

`E-18` supplies ambient `TenantContext`, *"propagated, never passed as a parameter through domain methods"* —
`PRD-008` consumes it and defines no tenant parameter of its own. `FEE-XC-016` already excludes cross-tenant
reach.

### 7.2 The cross-library privacy question — prohibited, and the prohibition is unconditional

The product intent asks for a possible cross-library renewal/membership indicator. Measured:

| Rule | Text | Effect |
|---|---|---|
| **`SID-4.19`** | `BC-10` *"**SHALL NOT** answer, and **SHALL NOT** be capable of answering, 'which libraries does this person attend?'"* | Bars the **capability**, not merely the field — so a minimised projection does not escape it |
| `SID-5.8` | names **`membership state`** as a field that *"**SHALL NEVER** exist"* in `BC-10` | Closes the obvious storage location |
| `ID-2` | *"`StudentRecordId` **never** leaves its tenant"* | **CI-enforced** — `banned_symbols`, `tool/module_dependencies.yaml` L216-218 |
| `ID-3` | global contexts must not resolve which library a person attends *"unless the person explicitly published it"* | The only lawful door is explicit consent, which needs `BC-18`, a lawful basis, a revocation path and an edge — **none exist** |
| BC Map L510 | an unregistered cross-tenant path is *"the single highest-severity failure mode in the entire architecture"* | Settles severity |

`PRD-008` builds none of it. `FEE-XC-019` and `FEE-XC-021` are unconditional prohibitions that hold however
`FEE-GAP-013` is later decided. **No fraud score, trust score, blacklist, risk label or punishment history
appears anywhere in the PRD** — verified by scan; the intent's own prohibition on such concepts is satisfied by
their total absence rather than by a rule forbidding them.

### 7.3 No index is created

`PRD-008` creates no cross-tenant index, satisfying `MP-GBR-08`'s index clause **by abstention**.

### 7.4 Result — ✅ **PASS**

---

## 8. Conflicts, gaps and dispositions

### 8.1 ⚠ Conflicts RAISED — pre-existing defects in ranked documents, not created by this PRD

| # | Defect | Evidence | Owner | Disposition |
|---|---|---|---|---|
| `AA-C1` | **Refund tier contradiction.** BC Map (**Rank 4**) L100/L374/L422 place refunds in `BC-05` at **V1**; EA (**Rank 6**) L823/L1408 say **V2**. FROZEN **Rank 3** `PRD-005` L942 routes a live flow to *"a refund decision by `BC-05`"* | Cited lines re-read at HEAD | **Product Owner** (scope) + **Architecture Owner** (EA correction) | **RAISED, not chosen.** Rank 1 `MP-CON-08`: the EA *"is updated to match — never the reverse."* `PRD-008` records the precedence determination and **declines to downgrade refund to V2**; it writes no refund requirement pending the Product Owner. `FEE-GAP-001` |
| `AA-C2` | **`D-14` mis-attributes `E-25`.** `PRD_DEPENDENCY_GRAPH.md` L116 assigns `E-25` to `PRD-008`; BC Map L334 makes `E-25` **`BC-20` → `BC-31`** | Both lines re-read | **Architecture Owner** | **RAISED, not corrected here.** Correcting a Rank-4-adjacent register is not a Stage 3 act |

**No conflict is created by `PRD-008` itself.** Both entries are contradictions *between existing documents*
that this PRD surfaces.

### 8.2 Carried forward — no false positives to re-litigate

Unlike `PRD-007`, this review inherits no prior gap-verification verdict. Nothing is re-decided.

### 8.3 Gaps — 15, with Stage 3 impact stated individually

| Gap | Blocks Stage 3? | Owner |
|---|---|---|
| **`FEE-GAP-002`** — no gateway edge | **YES — this is the sole cause of the NOT ALIGNED verdict** | **Architecture Owner** |
| `FEE-GAP-001` — refund V1/V2 | No — a tier question, raised as `AA-C1` | Product Owner + Architecture Owner |
| `FEE-GAP-004`, `005`, `006` | No — requirement-level, Stage 4 concerns | Product Owner |
| `FEE-GAP-003`, `007`, `008`, `009`, `010`, `011`, `012` | No | Named per gap in §37 |
| `FEE-GAP-013` — renewal protection | No — `BC-05` owns none of the blocked parts | Product Owner, `BC-02`/`BC-06`, Architecture, Security |
| `FEE-GAP-014` — commission has no owning document | No — it is `BC-20`'s subject | `BC-20` owner / Architecture Owner |
| `FEE-GAP-015` — permission + parameter row | No — role question **CLOSED**; remainder is outside `BC-05` | `BC-18`/`PRD-001`, `BC-25`/`PRD-023` |

**No gap is resolved by this record, and none is invented.** `FEE-GAP-002` is neither closed nor worked around.

---

## 9. Rejected findings — recorded as rejected, with reasons

Per Stage 3: *"A review that records only accepted findings is indistinguishable from a review that found
nothing."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `AA-R1` | *"`E-06`/`E-07`/`E-09`/`E-10` are same-rank Core dependencies and breach `L2` downward-only."* | Matrix **L89** declares the Core Library cluster a bounded `L2` exception with the explicit allow-list `E-01`…`E-10`. All four are inside it. `L2` is satisfied **by** the declared exception — the identical reasoning `PRD-007`'s `AR-R1` recorded |
| `AA-R2` | *"`PRD-008` should declare the `business.payment_intent` port as its gateway path and pass check 2."* | The port is real (Matrix L196, `X-03` L352) but has **no numbered edge**, and BC Map L292 is absolute. Adopting it here would resolve an Architecture Owner's question inside a Stage 3 review — and would be indistinguishable from inventing an edge |
| `AA-R3` | *"Adopt refund = V1 now, since Rank 4 outranks Rank 6, and write the refund requirements."* | The **precedence** is mechanical and is recorded; the **scope** of V1 refund is a Product Owner decision. `PRD-005` §7.4: a recommendation inside an open question *"is not a decision."* Writing `FEE-EVT-003` and a refund state table on this basis would be self-acceptance |
| `AA-R4` | *"`FEE-GAP-015` is a conflict with a closed register and blocks Stage 3."* | **Disproven by measurement this pass.** `PR-1`'s Purpose and Scope already include *"manage platform configuration"* (`prd-v2/02` L123-127). No new role is needed; *"Two, closed"* is not challenged. This was **`PRD-008` v0.4's own framing, and it is retracted in v0.5** |
| `AA-R5` | *"Set the commission rate at 3% and the protection window at 3 days as configuration defaults, since the product intent states them."* | `CONFIGURATION_GUIDE.md` §5 — adding a parameter requires *"a PRD amendment"*; the guide *"cannot change the envelope."* No register holds either value. `ADR-0031` is the standing precedent: *"a twenty-fifth configuration row was refused rather than invented"* |
| `AA-R6` | *"The EA listing `Refunds (V2)` conflicts with `BC-05` ownership and must be fixed for Stage 3 to pass."* | The EA is **Rank 6, descriptive only**, and Stage 3's scope is Ranks 1–5. A descriptive document trailing normative ones is a defect to raise (`AA-C1`), not a Stage 3 blocker |

---

## 10. Containment audit

| Constraint | Result |
|---|---|
| Frozen documents modified | **None.** `PRD-004`, `PRD-005`, `PRD-006`, `PRD-007`, Library PRD, Student Identity PRD unchanged |
| Ranked documents modified | **None.** BC Map, Dependency Matrix, Master PRD, `CONFIGURATION_GUIDE.md`, `PRD-001` read-only |
| ADRs authored or accepted | **None** |
| Edges invented | **None** — `FEE-GAP-002` left open rather than closed by invention |
| Configuration ranges invented | **None** — no `FEE-CFG-*` register; 3% and 3 days recorded as **intent**, not configuration |
| Roles or permissions invented | **None** — `PR-1` used as it already exists |
| Registry or baseline updated | **None** — `PRD-008` remains `PLANNED`; status is conferred at Stage 7 |
| Source code modified | **None** |
| Gates weakened | **None** |

---

## 11. Stage 3 verdict

⛔ **NOT ALIGNED — 5 of 6 checks PASS; check 2 BLOCKED.**

| Check | Result |
|---|---|
| 1 — Context ownership exclusive | ✅ **PASS** |
| 2 — Every integration edge in BC Map §7 | ⛔ **BLOCKED** — `FEE-GAP-002`, Architecture Owner |
| 3 — Rank direction downward | ✅ **PASS** |
| 4 — No authorisation outside `BC-18` | ✅ **PASS** |
| 5 — No credential/OTP/session outside `BC-18` | ✅ **PASS** |
| 6 — Tenant isolation | ✅ **PASS** |

**The single shortest path to ALIGNED:** the Architecture Owner rules on how `BC-05` reaches a payment gateway —
either ratifying `business.payment_intent` as an already-permitted port pattern requiring no numbered edge (the
`ADR-0033` precedent), or adding a numbered edge **outside** the `E-01`…`E-10` intra-cluster range by ADR — and
corrects `D-14` either way. **Nothing else in this record blocks Stage 3.**

> **This record confers no status.** `PRD-008` is `DRAFT`, remains `PLANNED` in `PRD_REGISTRY.md`, and is not
> architecture-approved. Stage 3 is passed when the gate's own condition is met, not when a document says so.

---

*End of `PRD-008_ARCHITECTURE_ALIGNMENT.md` — Stage 3 record for `PRD-008` v0.5 `DRAFT`. Not an approval.*
