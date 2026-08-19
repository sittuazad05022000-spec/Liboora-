# PRD-014 Entitlement — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Document** | `PRD-014_ARCHITECTURE_ALIGNMENT.md` |
| **Subject** | `PRD-014` Entitlement v0.1 `DRAFT` |
| **Bounded context** | `BC-21` Entitlement |
| **Lifecycle stage** | **Stage 3 — Architecture Review** |
| **Registry status sought** | `IN_REVIEW` |
| **Version** | v1.0 |
| **Date** | 2026-08-19 |
| **Gate under test** | `PRD_LIFECYCLE.md` L106 — *"a written alignment record naming every conflict and its disposition"* |
| **Reviewer role** | Architecture reviewer (`PRD_LIFECYCLE.md` §6). **No named holder exists** — `PGA-08` |
| **Verdict** | **CONDITIONAL PASS** — see §9 |

> `PRD_LIFECYCLE.md` L104: *"**A rejected finding must be recorded as rejected, with its reason.** … A review
> that records only accepted findings is indistinguishable from a review that found nothing."*
> §7 of this record exists to satisfy that sentence.

---

## 1. The six checks, as the lifecycle states them

`PRD_LIFECYCLE.md` L90–102 defines Stage 3 as exactly six checks, each with a named authority and a named
failure mode. They are reproduced here verbatim so that this review can be audited against its own terms.

| # | Check | Authority | Failure |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate |
| 2 | Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR |
| 3 | Rank direction is downward | Dependency Matrix `L2` | Illegal import |
| 4 | No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, Critical |

Each is executed in §2 through §6 below (checks 4 and 5 share §5). Every check is answered by a measurement or
a citation, never by assurance.

---

## 2. Check 1 — Context ownership is exclusive

**Failure mode:** two PRDs own one aggregate.

### 2.1 What `PRD-014` claims

`ENT-FR-001` claims exactly one aggregate, `EntitlementSet`. `ENT-FR-002` claims exactly three value objects,
`FeatureGate`, `UsageCounter`, `Limit`. Both cite BC Map **L383**, which grants precisely those four names and
no others.

### 2.2 Mechanical test — does any other document claim them?

Each of the four names was searched across `docs/` for a competing ownership claim.

| Name | Claimed by `PRD-014` | Any competing claim? | Evidence |
|---|---|---|---|
| `EntitlementSet` | Yes (`ENT-FR-001`) | **No** | Appears in `PRD-013` **L321 `TEN-XC-006`** — but as an **exclusion** naming `BC-21` as owner, which is a concession, not a claim |
| `FeatureGate` | Yes (`ENT-FR-002`) | **No** | Same: `TEN-XC-006` cedes it |
| `UsageCounter` | Yes (`ENT-FR-002`) | **No** | Same |
| `Limit` | Yes (`ENT-FR-002`) | **No** | Same. BC Map L383 grants it |

### 2.3 The reciprocity test — are the complements exact?

An exclusive claim must be the exact complement of every neighbour's exclusion, or two documents disagree.

| Neighbour's exclusion | What it cedes | `PRD-014`'s claim | Exact complement? |
|---|---|---|---|
| `PRD-013` **L321 `TEN-XC-006`** — `BC-19` MUST NOT define, store or compute `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit`; owner `BC-21` | All four | All four, and only those | **Yes** |
| `PRD-016` **L273 `AUD-XC-007`** — `BC-24` MUST NOT define entitlement outputs; owner `BC-21` | Entitlement outputs | `ENT-XC-010` reciprocally cedes `AuditEntry` to `BC-24` | **Yes** |
| `PRD-013` **L157–159 `TEN-FR-006`** — `TenantTier` and `Quota` are **inputs**, never derived outputs; *"the two value-object sets are disjoint"* | Nothing; it asserts disjointness | `ENT-XC-001` cedes `TenantTier`, `Quota` and three more to `BC-19`; `ENT-BR-003` treats them as inputs | **Yes** |
| `PRD-007` **L147** — `SeatQuota` *"owned by `BC-21` … published by `BC-02`"* | The concept | `ENT-XC-006` cedes the plan and the published value to `BC-02`; `ENT-FR-028` adopts the term | **Yes**, and the split is honoured |

**No aggregate is claimed twice. No aggregate this PRD needs is claimed by two documents.**

### 2.4 The shared-module hazard — Finding `A-01`

This is the one place where check 1 is not trivially satisfied, and the reason is structural rather than
textual.

`BC-21` does not own its module. `ADR-0035` **L123**: *"Which contexts sit in `platform/business`? **Exactly
two** — `BC-20` Subscription & Billing, `BC-21` Entitlement (BC Map L129–L130)"*. The Dependency Matrix names
rank R6 *"BUSINESS (Subscription + Entitlement)"* at **L70**. The yaml block carries two assertions, and they
belong to different contexts:

| Module artefact | Owner | `PRD-014`'s treatment | Correct? |
|---|---|---|---|
| `BZ-1` — entitlement written only by `billing.EntitlementChanged` handlers | `BC-21` | Claimed, as `ENT-BR-001` and `ENT-INV-002` | **Yes** — `BZ-1`'s own comment cites `X-11`, an entitlement rule |
| `BZ-2` — every gateway call carries an idempotency key | `BC-20` | **Explicitly disclaimed** in `ENT-XC-004` | **Yes** |
| Port `platform/integration:payment_gateway` | `BC-20` | **Explicitly disclaimed** in `ENT-XC-004` | **Yes** |
| `rank: 6`, `banned_imports` | Shared | Cited in `ENT-FR-027`, not claimed | **Yes** |

`PRD-014` §1.4 publishes this split as a table before making any module statement. **Check 1 passes**, but the
hazard is real enough to record: a future amendment that says "this PRD governs `platform/business`" without
qualification would annex `BC-20`'s territory silently.

**Disposition of `A-01`: ACCEPTED and already mitigated** by §1.4 and `ENT-XC-004`. Carried forward as a
standing constraint on future amendments, not as a defect in v0.1.

### 2.5 Finding `A-02` — the L383 / L70 tension

BC Map **L383** grants `BC-21` an aggregate. Matrix **L70** says rank R6 contexts *"own no domain aggregate"*.
Both documents are **Rank 4**, so neither outranks the other.

`PRD-014` handles this by stating the module's **conduct** (`ENT-INV-005`: it holds no domain entity; it stores
no `Student`, `Seat` or `Membership`) and recording the tension as `ENT-GAP-006` rather than adjudicating it.

The plain reading is that `EntitlementSet` is a derived capability-band projection and not a *domain*
aggregate, which reconciles both lines. **But that reading is the reviewer's, not the repository's.** No
document states it.

**Disposition of `A-02`: ACCEPTED as an open question, NOT resolved.** Severity **Low** — the module's required
behaviour is identical under either reading, so no requirement changes. Owner: **Architecture Owner**. Closing
it would need an ADR, which this review has no authority to issue.

**Check 1 verdict: PASS**, with `A-01` mitigated and `A-02` recorded open.

---

## 3. Check 2 — Every integration edge exists in §7

**Authority:** BC Map §7. **Failure:** *"If an edge is not in this table, it does not exist"* — needs an ADR.

### 3.1 The complete edge inventory, tested row by row

`PRD-014` §7.1 publishes five edges it relies upon. Each was located in BC Map §7 or accounted for.

| Edge `PRD-014` relies on | Present in BC Map §7? | Where | Created by `PRD-014`? |
|---|---|---|---|
| `E-17` — all write paths to `BC-21`, sync `check(tenantId, feature, delta)` | **Yes** | §7.3 **L326** | No — received |
| `E-18` — `BC-19` to all, ambient `TenantContext` | **Yes** | §7.3 | No |
| `E-19` — `BC-25` to all, typed config accessors | **Yes** | §7.3 | No |
| `tenancy.*` events to `BC-21` | **Yes** in §9 (**L435**); `E-18`'s subsection covers the `BC-19` direction | §9 L435 | No |
| `billing.*` events `BC-20` to `BC-21` | **§9 yes (L436, L437); §7 NO** | — | No — **see `A-03`** |

**Edges created by this PRD: zero.** `ENT-FR-025` states the prohibition, and `ENT-XC-012` makes it an
exclusion.

### 3.2 Finding `A-03` — the `BC-20` to `BC-21` edge is absent from §7

This is the substantive finding of Stage 3, and it is **not new**.

BC Map **§7 preamble L292** is categorical: *"Every edge that crosses a context boundary in V1. If an edge is
not in this table, it **does not exist** and adding it requires an ADR."*

`billing.EntitlementChanged` crosses from `BC-20` to `BC-21`. It is published in **§9 L437** and described
there as *"The only writer of entitlement inputs."* It is **not** in §7. The reason is a taxonomy gap rather
than an oversight: §7's subsections run Domain→Domain, Domain→Capability, Capability→Domain — there is **no
capability→capability subsection**, and both `BC-20` and `BC-21` are capability-band contexts (BC Map
**L259–267**; `BC-21` at **L263**).

`PRD-013` recorded exactly this, at **L431**, and it is FROZEN:

> *"Bounded Context Map §7 has no capability→capability subsection. `BC-19`'s downstream edges and **`BC-20`→
> `BC-21`** are both published in §9 while absent from §7 | **Open, product-wide, pre-existing.** … This
> module's compliant posture is to **decline** any edge not in §7, never to invent one | **Architecture
> Owner**"*

`PRD-013`'s Stage 3 was therefore **CONDITIONAL on `H-1`**. `PRD-014` sits further into the same gap, because
its *sole lawful input* arrives across the missing taxonomy.

**Disposition of `A-03`: ACCEPTED as INHERITED, not created.** Severity **High**, but pre-existing and
product-wide. Owner **Architecture Owner**. `H-1` is `ENT-GAP-005` in the PRD.

**Compliant posture adopted, verbatim from `PRD-013`:** decline any edge not in §7, never invent one. Concretely
`PRD-014` does three things and no more:

1. It **cites** the `BC-20` events from BC Map §9 (`ENT-FR-005`, `ENT-FR-006`) rather than declaring a new §7 edge.
2. It **disclaims** authorship of `billing.EntitlementChanged` (`ENT-XC-003`).
3. It **declines** to assume any edge not in §7 (`ENT-FR-025`, `ENT-XC-012`) — including, explicitly, an
   entitlement-to-audit edge (`ENT-FR-026`).

This does not close `A-03`. It ensures `PRD-014` does not widen it.

### 3.3 Finding `A-04` — `ENT-FR-026` declines an edge it might be expected to want

Every other frozen module PRD publishes to `BC-24` Audit via `E-20` (BC Map L329, outbox). `PRD-014` does not,
and `ENT-FR-026` says why: `E-20` sits in **§7.3, which is Domain→Capability**, and `BC-21` is
**capability-band**. A `BC-21`-to-`BC-24` edge would be capability→capability — the same missing taxonomy as
`A-03`.

An entitlement decision log is plainly *desirable*: `X-11`'s stated harm is that *"revenue leakage is
unauditable."* But desirability is not authority. Asserting the edge would be inventing an integration edge,
which BC Map L292 forbids without an ADR.

**Disposition of `A-04`: ACCEPTED.** Severity **Medium**. Owner **Architecture Owner**, as part of `H-1`.
`PRD-014`'s posture — assume no such edge until `H-1` closes — is the compliant one, and the desirability is
recorded here rather than acted on.

**Check 2 verdict: CONDITIONAL** — conditional on `H-1` (`A-03`), with `A-04` recorded. **Zero edges added.**

---

## 4. Check 3 — Rank direction is downward

**Authority:** Dependency Matrix `L2`. **Failure:** an illegal import.

### 4.1 The rank facts

| Fact | Value | Authority |
|---|---|---|
| `platform/business` rank | **6** | yaml rank map; Matrix L70 |
| Declared imports | `contracts` only | yaml |
| Banned imports | `domain/**`, `app/**` | yaml |
| `domain/library` rank | 8 | yaml rank map |
| `platform/tenancy` rank | 4 | yaml rank map |
| `platform/audit` rank | 5 | yaml rank map |

`L2` requires dependency direction to be downward — a higher-ranked module may depend on a lower-ranked one,
never the reverse. Rank 8 (`domain/library`) importing rank 6 (`platform/business`) is **downward and lawful**;
`ADR-0012` **L86** confirms it and confirms the ports are already declared:

```
| domain/library | platform/business | 8 → 6 | 2 | **Yes — :entitlement, :payment_intent** |
```

### 4.2 What `PRD-014` requires

`ENT-FR-027` requires entitlement code to reside in `platform/business` at rank 6, import only `contracts`,
and import no `domain/**` or `app/**` module. `ENT-XC-011` makes the prohibition an exclusion, citing BC Map
**§7.4 `F-1`**: *"**No capability context may import, reference, or query a domain context.** Not AI, not
Analytics, not Search, not Notification, not Workflow, not Audit."*

These are the yaml's own constraints, restated as this module's obligations. **No new import is requested. No
rank is crossed upward.**

### 4.3 Finding `A-05` — the pre-existing rank-6-to-rank-4 import

The yaml records an acknowledged finding at **L612**, under `ADR-0012`:

> *"`EntitlementService` imports the tenancy barrel for the `TenantTier` enum. The `TenantContext` it also uses
> is already correctly taken from R0 contracts (§8.3). Fix: promote `TenantTier` to shared vocabulary, or
> declare a one-method `TenantTierSource` port."* — `expires: 2026-10-31`

Rank 6 importing rank 4 is downward, so `L2`'s *direction* is satisfied. What is violated is the module's own
declared import list (`imports: [contracts]`), which is why it is a recorded finding rather than a silent
allowance. Two further `EntitlementService` findings exist at **L663** and **L692**, both expiring 2027-03-31.

**Disposition of `A-05`: ACCEPTED as PRE-EXISTING, governed elsewhere.** Severity **Low**. `ADR-0012` §3.4 is
the acknowledged-debt mechanism and it already covers all three. `PRD-014` records the soonest expiry
(**2026-10-31**) as `D-014-06` so Stage 6 can sequence against a real date. **This review does not repair the
code and does not extend the expiry.**

**Check 3 verdict: PASS.** No upward dependency requested; `A-05` pre-existing and governed.

---

## 5. Checks 4 and 5 — Authorisation, and credential/OTP/session material

**Authorities:** Matrix `X-13` and `ID-1`. **Failures:** *"A security defect that passes its own tests"*, and
prohibited material.

### 5.1 The distinction that makes this check non-trivial

`BC-21` answers *"is tenant T allowed to do X"*. That sentence contains the word *allowed*, and an
insufficiently careful reading would make `BC-21` an authorisation authority — which `X-13` forbids for
anything outside `BC-18`.

The distinction is between two different questions:

| Question | Owner | Nature |
|---|---|---|
| *Is this **actor** permitted to perform this operation?* | **`BC-18`** Security | Authorisation. Actor, role, scope |
| *Has this **tenant** paid for this capability, and how much remains?* | **`BC-21`** Entitlement | Commercial entitlement. Tenant, plan, counter |

BC Map **L130** scopes `BC-21` to *"limits and gates"* — tenant-level commercial state. It says nothing about
actors, roles or scopes. `MP-GBR-21` closes the scope register at `self`, `guardianOf`, `tenantWide` and
forbids a fourth without an ADR; `PRD-014` introduces no scope at all.

`ADR-0017` **L125–126** sharpens the adjacent boundary from the other side: *"a flag says **is this on**; an
entitlement says **is this paid for**"*. Neither says *who may act*.

### 5.2 Check 4 — authorisation

| Test | Result |
|---|---|
| Does any `ENT-*` requirement decide whether an actor may act? | **No.** All 28 `ENT-FR-*` concern tenant-level limits, gates, counters and derivation |
| Does the PRD introduce a role, permission or scope? | **No.** `MP-GBR-21`'s closed register is untouched |
| Is authorisation explicitly ceded? | **Yes** — `ENT-XC-009` cedes authorisation decisions to `BC-18`, citing `X-13` verbatim |
| Could a caller mistake a `check` result for an authorisation decision? | **A real risk.** See `A-06` |

**Check 4 verdict: PASS**, with `A-06` recorded.

### 5.3 Check 5 — credential, OTP, session material

| Test | Result |
|---|---|
| Does the PRD hold, generate or validate a credential? | **No** |
| An OTP? | **No.** The only OTP material in the repository is `BC-18`'s, configured as `CFG-1`…`CFG-4` |
| A session? | **No** |
| Is the prohibition stated? | **Yes** — `ENT-XC-009` covers credential, OTP and session material, citing `ID-1` |

**Check 5 verdict: PASS.**

### 5.4 Finding `A-06` — the conflation risk at the call site

`ENT-BR-004` already states that a feature flag being on does not confer entitlement. The mirror risk —
treating an entitlement *allow* as an authorisation *permit* — is not stated as a requirement.

`ENT-XC-009` prohibits `BC-21` from **deciding** authorisation, which is the check that `X-13` actually
demands, and this PRD governs `BC-21` only. Requiring callers to also perform a `BC-18` authorisation check
would impose an obligation on other bounded contexts, which `PRD-014` has no authority to do.

**Disposition of `A-06`: ACCEPTED as a documentation finding, NOT converted into a requirement.** Severity
**Low**. Owner: Architecture reviewer. Reason for not raising it to a requirement: it would be an obligation on
`BC-04`, `BC-02` and every other write path — outside this PRD's ownership. Recorded here so the risk is
visible in the architecture record.

---

## 6. Check 6 — Tenant scoping

**Authorities:** `MP-GBR-08`, `X-13`. **Failure:** cross-tenant leak — `MP-RSK-01`, **Critical**.

This is the highest-severity check in the table. `MASTER_PRD.md` **L340** calls cross-tenant leakage *"the
single highest-severity failure mode in the architecture."*

### 6.1 What the PRD requires

| Requirement | Content | Authority cited |
|---|---|---|
| `ENT-FR-001` | `EntitlementSet` is instantiated **per tenant** | BC Map L383 |
| `ENT-FR-009` | An event without a resolvable `tenantId` **fails loudly**; no tier, limit or gate is defaulted | BC Map §9.1; `MP-GBR-06`, `MP-GBR-07` |
| `ENT-FR-014` | `tenantId` is an **explicit argument** of `check`, not ambient | BC Map L326 |
| `ENT-FR-021` | Every read is scoped to one tenant; **no interface may accept a shape capable of returning another tenant's entitlement** | `MP-GBR-08`, `MP-GBR-09`, `X-13` |
| `ENT-INV-003` | Every `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` is bound to exactly one `tenantId` | BC Map L383; `MP-GBR-08`, `MP-GBR-09` |
| `ENT-BR-007` | Absence of tenant context is a **failure**, not a condition with a default | `MP-GBR-07` |
| `ENT-AC-008`, `ENT-AC-016` | Testable criteria for both the loud failure and the foreign-`tenantId` probe | — |

Six obligations and two criteria. Tenant scoping is the most densely specified area of the PRD, which is
proportionate to `MP-RSK-01`.

### 6.2 Finding `A-07` — the existing implementation defaults silently, and it is High

The specification is correct. **The code is not.**

`lib/platform/business/business.dart` resolves a tenant's tier as `_tiers[...] ?? TenantTier.starter`. For an
unknown tenant it returns `starter` — a valid tier — instead of failing. `MP-GBR-07` requires a consumer
without tenant context to *"fail loudly, never default"*, and BC Map §9.1 repeats it: *"must **fail loudly, not
default**"*.

The consequence is not merely a wrong tier. A tenant whose registration has not been processed receives
`starter` limits silently, and the failure is invisible at the call site. This sits in the same class as
`MP-RSK-01`, though it is a *wrong-answer* defect rather than a demonstrated data leak: the code keys usage on
`'${tenantId}:${feature}'`, so counters do not appear to cross tenants.

**Disposition of `A-07`: ACCEPTED.** Severity **High**. Owner **Implementation lead**. Recorded in the PRD as
`D-014-03` and as `ENT-FR-009` / `ENT-BR-007` on the specification side. **No code was modified** — the user's
boundary is explicit, and Stage 8 is out of scope. Stage 6 must carry a task for it.

**Check 6 verdict: PASS on specification; the code contradiction is recorded as `A-07`, not concealed.**

---

## 7. Findings considered and REJECTED, with reasons

`PRD_LIFECYCLE.md` L104 requires this section to exist. Each candidate below was seriously entertained.

| ID | Candidate finding | Why rejected |
|---|---|---|
| `R3-01` | *"`PRD-014` must specify the fail-open/fail-closed policy — `E-17` describes it, so it is architecture, and Stage 3 should settle it."* | **Rejected.** `E-17` assigns the decision to Config *per feature*; `Q-03` is **Open** at BC Map **L542** and `MASTER_PRD.md` **L675**; the Rank 7 register does not exist. Settling it here would be an ADR-grade act by a review record. `ENT-FR-018` states the requirement's shape and defers the value to `ENT-GAP-001`/`ENT-GAP-002`. Stage 3 checks alignment; it does not legislate |
| `R3-02` | *"Two frozen PRDs (`MM-BR-013`, `SEAT-FR-296`) already behave fail-closed, so the platform rule is settled de facto and `PRD-014` should codify it."* | **Rejected as invention.** Each is scoped to its own gate on its own authority — `PRD-005` to membership creation, `PRD-007` to seat acquisition — and `PRD-007` **L1187–1199** even carries a note on *"why it does not contradict `Q-03`"*, which only makes sense if `Q-03` is open. Two module-scoped decisions do not sum to a platform rule. Generalising them would create a Rank 3 rule from a Rank 4 recommendation |
| `R3-03` | *"`PRD-014` should declare the `BC-20` to `BC-21` edge in §7 to fix `A-03`."* | **Rejected on authority.** BC Map is **Rank 4** and `PRD-014` is a Rank 3 module PRD; §7 L292 requires an **ADR** to add an edge. `PRD-013` established the compliant posture — *"decline any edge not in §7, never … invent one"*. `PRD-014` declines |
| `R3-04` | *"`PRD-014` should publish an `entitlement.EntitlementRecomputed` event so downstream contexts can react."* | **Rejected.** BC Map §9 names `BC-21` in three rows and it is the **consumer** in all three. No §9 row makes `BC-21` a publisher. `ENT-FR-024` and the empty `ENT-EVT-*` register record the fact. Inventing an event is explicitly prohibited by the user's instruction and by L292 |
| `R3-05` | *"`ENT-FR-026` is too conservative — audit of entitlement decisions is obviously required, since `X-11` says revenue leakage is unauditable."* | **Rejected as an action; accepted as a finding (`A-04`).** The desirability is real and is now recorded. But `E-20` is a §7.3 Domain→Capability edge and `BC-21` is capability-band, so the edge would be capability→capability — the `H-1` gap. Acting on desirability without authority is precisely what L292 forbids |
| `R3-06` | *"The `A-02` tension should be resolved in favour of BC Map L383, since L383 is more specific."* | **Rejected.** Both are Rank 4; `DOCUMENTATION_BASELINE.md` §4 gives no tie-break by specificity. The reviewer's reading (a derived projection is not a domain aggregate) is recorded in §2.5, and the question is left to the Architecture Owner as `ENT-GAP-006`. A review that silently picks a winner between two Rank 4 documents has made an architecture decision without an ADR |
| `R3-07` | *"`A-05` should be fixed now by promoting `TenantTier` to `contracts` — the yaml even names the fix."* | **Rejected.** It names the fix as an *option*; the finding is governed by `ADR-0012` §3.4 with an expiry of 2026-10-31. Editing `lib/` or `packages/` is forbidden by the user's boundary, and unilaterally promoting a type into shared vocabulary is a contracts change affecting `BC-19`. Recorded as `D-014-06` |
| `R3-08` | *"`seed.dart:95–96` violates `BZ-1` and should be reported as a boundary violation."* | **Partially rejected, deliberately.** The write is real and recorded as `D-014-04`. But whether bootstrap seeding of a demo tenant is a lawful fixture or an `X-11` violation depends on whether `BZ-1` binds test/bootstrap paths — a question the yaml assertion does not answer. Stage 1 deferred it here; **Stage 3 finds it genuinely undetermined and records it as `A-08`** rather than manufacturing a verdict |
| `R3-09` | *"`ADR-0035` should be treated as ACCEPTED, since its header says so, and it is the cleanest authority for the 'exactly two contexts' claim."* | **Rejected.** Its own changelog says *"Left `PROPOSED`: no conferral of Architecture Owner authority was given"*. Choosing the header over the changelog would be a governance act. `PRD-014` cites it **with caution** (`ENT-GAP-007`) and never as sole authority: the `platform/business` membership claim is independently supported by BC Map **L129–L130** and Matrix **L70** |
| `R3-10` | *"Check 6 should fail, because the code defaults silently and cross-tenant correctness is Critical."* | **Rejected as a check verdict; accepted as `A-07`.** Stage 3 tests whether the **PRD** aligns with architecture. The PRD's six tenant-scoping obligations are correct and cite the right authorities. A code defect is a Stage 6/8 matter, recorded as `D-014-03`. Failing Stage 3 for a pre-existing code defect would conflate specification review with implementation audit |
| `R3-11` | *"`PRD-014` claims `platform/business`, which `BC-20` also occupies — check 1 should fail."* | **Rejected.** Check 1's failure mode is *"Two PRDs own one aggregate"*, not *two contexts share one module*. `ADR-0035` L123 states the sharing as fact. `PRD-014` §1.4 publishes the split and `ENT-XC-004` disclaims `BC-20`'s artefacts. Recorded as `A-01`, which is mitigated rather than failing |

---

## 8. All findings, consolidated

| ID | Finding | Check | Severity | Owner | Disposition |
|---|---|---|---|---|---|
| `A-01` | `BC-21` shares `platform/business` with `BC-20`; module assertions split (`BZ-1` is `BC-21`'s, `BZ-2` is `BC-20`'s) | 1 | High (structural) | Product owner | **ACCEPTED, mitigated** by PRD §1.4 and `ENT-XC-004`. Standing constraint on future amendments |
| `A-02` | BC Map L383 grants an aggregate; Matrix L70 says R6 owns none. Both Rank 4 | 1 | Low | Architecture Owner | **ACCEPTED as open.** `ENT-GAP-006`. Not adjudicated |
| `A-03` | `BC-20` to `BC-21` edge published in §9, absent from §7 — no capability→capability subsection exists | 2 | High, **pre-existing** | Architecture Owner | **ACCEPTED as inherited** (`H-1`, `ENT-GAP-005`). Posture: decline, never invent. **Makes Stage 3 CONDITIONAL** |
| `A-04` | An entitlement-decision audit edge is desirable (`X-11` cites unauditable leakage) but would be capability→capability | 2 | Medium | Architecture Owner | **ACCEPTED.** `ENT-FR-026` declines it; desirability recorded, not acted on |
| `A-05` | `EntitlementService` imports the tenancy barrel for `TenantTier`, against the module's declared import list; expires **2026-10-31** | 3 | Low | Implementation lead | **ACCEPTED as pre-existing**, governed by `ADR-0012` §3.4. `D-014-06`. Not repaired |
| `A-06` | A caller could mistake an entitlement *allow* for an authorisation *permit* | 4 | Low | Architecture reviewer | **ACCEPTED as documentation only.** Not raised to a requirement — it would bind other contexts |
| `A-07` | Code defaults an unknown tenant to `TenantTier.starter`, against `MP-GBR-07` and BC Map §9.1 | 6 | **High** | Implementation lead | **ACCEPTED.** `D-014-03`; specification side is `ENT-FR-009`/`ENT-BR-007`. **No code modified** |
| `A-08` | Whether `BZ-1` binds bootstrap/seed paths is **undetermined**; `seed.dart:95–96` writes entitlement state directly | 1, 3 | Medium | Architecture Owner | **ACCEPTED as undetermined.** Recorded in `D-014-04`. Stage 3 declines to manufacture a verdict; needs an ADR or a `BZ-1` clarification |

**8 findings accepted. 11 candidate findings rejected with reasons (§7).**

---

## 9. Verdict

| Check | Subject | Verdict |
|---|---|---|
| 1 | Context ownership is exclusive | **PASS** — one aggregate, three value objects, complements exact with `TEN-XC-006` and `AUD-XC-007`; `A-01` mitigated, `A-02` open |
| 2 | Every integration edge exists in §7 | **CONDITIONAL** — zero edges added, but the sole lawful input crosses the `H-1` taxonomy gap (`A-03`) |
| 3 | Rank direction is downward | **PASS** — no upward dependency requested; `A-05` pre-existing and governed by `ADR-0012` |
| 4 | No authorisation outside `BC-18` | **PASS** — `ENT-XC-009`; no role, permission or scope introduced; `MP-GBR-21`'s closed register untouched |
| 5 | No credential, OTP or session outside `BC-18` | **PASS** — `ENT-XC-009` |
| 6 | Tenant scoping correct | **PASS on specification** — six obligations, two criteria; code defect recorded as `A-07` |
| — | Gate artefact exists, naming every conflict and its disposition | **PASS** — this document |

### **Stage 3 verdict: CONDITIONAL PASS.**

The condition is **`H-1`** (`A-03`, `ENT-GAP-005`): BC Map §7 has no capability→capability subsection, so the
`BC-20` to `BC-21` edge on which this entire module depends is published in §9 while absent from §7.

**The condition is inherited, not created.** `PRD-013`'s Stage 3 was CONDITIONAL on the identical gap, recorded
at `PRD-013` L431 and L463, and that PRD proceeded to `FROZEN` on that basis. `PRD-014` adopts the same
compliant posture — decline any edge not in §7, never invent one — and adds **zero** edges.

Stage 3 passing does **not** confer `IN_REVIEW` status in the registry, and this record does not claim it.

**Proceed to Stage 4 — Requirements Review.**

---

## 10. What this record deliberately does not do

| Not done | Why |
|---|---|
| Close `H-1` | Product-wide, Architecture Owner's, needs an ADR amending BC Map §7 |
| Add the `BC-20` to `BC-21` edge to §7 | Rank 4 document; L292 requires an ADR. `R3-03` |
| Decide `Q-03` or `Q-06` | Open at Rank 1 and Rank 4. `R3-01` |
| Adjudicate the L383 / L70 tension | Two Rank 4 documents; no tie-break exists. `R3-06` |
| Rule on whether `BZ-1` binds seed paths | Genuinely undetermined. `A-08` |
| Resolve the `ADR-0035`/`0036` status discrepancy | Governance Owner's. `R3-09` |
| Modify `lib/`, `packages/`, `test/` or `tool/` | The user's explicit boundary. `A-05`, `A-07`, `A-08` are recorded, not fixed |
| Confer registry status | Status is conferred by the registry, not by a review record |

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Stage 3 Architecture Alignment record created. All six lifecycle checks executed against named authorities. Ownership complements verified exact against `TEN-XC-006`, `AUD-XC-007`, `TEN-FR-006` and `PRD-007` L147. Edge inventory verified: **zero edges added**. 8 findings accepted with evidence, severity, owner and disposition; **11 candidate findings recorded as rejected with reasons**. Verdict **CONDITIONAL PASS**, conditional on the inherited `H-1` taxonomy gap |
