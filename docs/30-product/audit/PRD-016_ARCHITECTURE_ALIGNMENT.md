# `PRD-016` Audit Trail v0.1 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L88–106) |
| **Subject** | [`PRD-016_AUDIT_TRAIL.md`](PRD-016_AUDIT_TRAIL.md) — `PRD-016`, `BC-24` Audit Trail `[GENERIC]`, **V1**, **v0.1 `DRAFT`** |
| **Gate satisfied by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`PRD-013_ARCHITECTURE_ALIGNMENT.md`](../tenancy/PRD-013_ARCHITECTURE_ALIGNMENT.md) · [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](../attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT.md) · [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Stage 1 predecessor** | [`PRD-016_STAGE1_DISCOVERY.md`](PRD-016_STAGE1_DISCOVERY.md) — Stage 1 **PASS**, 8 findings `F-1`…`F-8` |
| **Reviewed at** | `e99c1cd` |
| **PRD hash at review** | `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` — verified identical before and after |
| **Date** | 2026-08-19 |
| **Mandate** | **Stage 3 only.** No PRD modified, no ADR created or changed, no ranked document touched, no registry or baseline update, no identifier registered in any matrix, no traceability checker written, no freeze. **No implementation code modified.** Stages 4–7 not started, Stage 8 not entered |
| **Verdict** | ✅ **ALIGNED — 6 of 6 checks PASS.** **0 conflicts** · 5 open/non-blocking items with named owners (§9) · 3 code contradictions carried forward, not repaired (§10) · **9 candidate findings rejected, each with its reason (§11)** |

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line. Nothing is asserted from
conversation memory, and nothing is taken on trust from the PRD under review — each claim the PRD makes about a
ranked document was re-read at its source before this record was written.

Where the PRD text conflicts with a higher-precedence document, the precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
**never which one to quietly ignore.** Per `MASTER_PRD.md` `MP-CON-08`: *"A disagreement is a **defect to be
raised**, not a choice to be made."*

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD | `../MASTER_PRD.md` | **1** |
| 2 | ADRs — `ADR-0012`, `ADR-0013`, `ADR-0014`, `ADR-0017`, `ADR-0020`, `ADR-0049` | `../../00-governance/adr/` | **2** |
| 3 | **Authentication PRD v2.0 §10.4 — FROZEN** | `../authentication/Authentication_PRD_v2.md` | **3** |
| 4 | Seat Management `PRD-007` — **FROZEN** | `../seat-management/PRD-SEAT-MANAGEMENT.md` | **3** |
| 5 | Attendance `PRD-006` — **FROZEN** | `../attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md` | **3** |
| 6 | Tenancy `PRD-013` — **FROZEN** | `../tenancy/PRD-013_TENANCY.md` | **3** |
| 7 | Bounded Context Map v1.6 — §3, §4, §7, §8, §9, §9.1 | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 8 | Module Dependency Matrix v1.3 — `L1`–`L5`, `X-10`, `X-13`, §7.4, §10 | `../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 9 | Module manifest — machine-enforced | `../../../tool/module_dependencies.yaml` | **4** *(tooling of record)* |
| 10 | Architecture Rulings | `../../10-architecture/ARCHITECTURE_RULINGS.md` | **5** |
| 11 | PRD Registry · Lifecycle · Ownership Model · Roadmap · Dependency Graph · Baseline | `../../00-governance/` | — |

Ranks 6 (Enterprise Architecture) and 7 (Configuration Guide) are **not** Stage 3 authorities — the lifecycle scopes
this stage to *"Ranks 1–5"*. Both were nonetheless read, and where the PRD relies on their **silence** (the absent
audit configurable) that reliance is recorded in §9 rather than treated as a Stage 3 result.

### 1.2 Classification scheme

| Class | Meaning |
|---|---|
| **PASS** | Verified compliant against the named authority |
| **CONDITIONAL** | Compliant as drafted, but resting on a documentation gap outside this PRD's control |
| **CONFLICT** | Two documents assert incompatible facts. Raised, never resolved here |
| **OPEN / NON-BLOCKING** | A genuine absent decision, owned elsewhere, that does not block this stage |
| **CODE CONTRADICTION** | The specification disagrees with shipped code. Measured and named, **never repaired here** |
| **REJECTED FINDING** | A candidate finding examined and rejected, with its reason recorded (§11) |

### 1.3 What makes this review structurally unusual

Most Stage 3 reviews test whether a draft has **over-claimed**. This one had to test the opposite risk as well,
because `BC-24`'s subject matter is *already specified elsewhere*: nine audit **principles** `AU-1`…`AU-9` sit in a
**frozen Rank 3** document (`Authentication_PRD_v2.md` §10.4), four **assertions** sit in the machine-enforced module
manifest, and one Rank 1 global rule (`MP-GBR-13`) states the core invariant outright. A draft could therefore fail
Stage 3 in two directions at once — by claiming what `BC-18` owns, or by **restating** what a frozen document already
says and creating a second source of truth. Both directions were tested. Both pass.

---

## 2. Check 1 — Context ownership is exclusive

> **Authority:** Bounded Context Map §3 · **Failure:** *"Two PRDs own one aggregate"*

### 2.1 The claim under test

`PRD-016` claims exactly one aggregate. `AUD-FR-001`: *"The module **SHALL** own the `AuditEntry` aggregate as
declared in Bounded Context Map §8 **L384**, and no other aggregate."*

BC Map §8 L384, verbatim:

> `| BC-24 Audit Trail | AuditEntry | Actor, Action, Target, TenantContext | **Append-only, no update or delete path exists in code**; entry carries the tenant and actor of record; legal hold blocks purge |`

The four names in column 3 are **value objects**, not aggregates. `AUD-FR-004` carries them as value objects and adds
nothing — the aggregate count claimed is **1**, matching L384 exactly.

### 2.2 Exhaustive scan for a competing claimant

`grep -rn "AuditEntry" docs/ --include=*.md`, excluding `docs/30-product/audit/`, returns **4 hits in 3 files**:

| File | Line | What it is | Competing claim? |
|---|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` | 384 | The Rank 4 register row assigning `AuditEntry` to `BC-24` | **No — it is the grant** |
| `PRD-SEAT-MANAGEMENT.md` | 1627 | Inside `SEAT-FR-232`, which **disclaims**: *"the immutable append-only record of who did what"* (BC Map §4) and its `AuditEntry` aggregate is… | **No — a disclaimer** |
| `PRD-013_ARCHITECTURE_ALIGNMENT.md` | 380 | Enumerates §8 aggregates incl. `AuditEntry` while reasoning about `MASTER_PRD.md` L333 | **No — a citation** |
| `PRD-013_ARCHITECTURE_ALIGNMENT.md` | 495 | `S3-F-02`, same enumeration | **No — a citation** |

**Zero competing claims.** `PRD_REGISTRY.md` §6 records no written owner for `BC-24` and **0** contested contexts.

### 2.3 The check is proven by convergence, not merely by absence

Absence of a competing claim is weak evidence — it can equally mean nobody has looked. So the review searched for the
**positive** statements by which other PRDs have already surrendered this subject. Five were found across three
documents, two of them **FROZEN Rank 3**:

| Authority | Line | Statement | Status |
|---|---|---|---|
| **`AUTH-10.4`** | `Authentication_PRD_v2.md:3698` | *"Authentication MUST NOT own audit storage, retention or querying; it MUST only produce audit-worthy facts"* | **FROZEN** |
| **`AUTH-10.26`** | `Authentication_PRD_v2.md:4050` | *"Authentication MUST NOT own audit storage, retention or query; it MUST only produce the records"* | **FROZEN** |
| **`SEAT-FR-232`** | `PRD-SEAT-MANAGEMENT.md:1626` | *"The module **MUST NOT** implement its own immutable audit store. `BC-24` Audit Trail owns…"* | **FROZEN** |
| **`SEAT-XC-015`** | `PRD-SEAT-MANAGEMENT.md:1652` | *"**Audit retention, legal hold, purge, export and tamper-evidence are out of scope.** `BC-24` owns…"* | **FROZEN** |
| **`ATT-FR-079` / `ATT-FR-130`** | `PRD-006_ATTENDANCE-MANAGEMENT.md:1554, 2054` | Emitter-side duties only; storage routed to `BC-24` | **FROZEN** |

Plus `PRD-006_ARCHITECTURE_ALIGNMENT.md:322` — `| 10 | Audit | BC-24 via E-20, append-only (X-10) |`.

**`PRD-016`'s ownership is therefore *vacated to it* by frozen documents, not asserted by it.** `AUD-FR-002` states
this explicitly and cites `AUTH-10.26` as the vacating authority rather than claiming the territory. That is the
strongest possible form of this check's result.

### 2.4 The mirror test — does `PRD-016` claim anything belonging to another PRD?

Every aggregate in BC Map §8 was tested against the draft's exclusion register:

| Aggregate | Owner | `PRD-016`'s position |
|---|---|---|
| `Account` · `AccessPolicy`, `Credential`, `AuthSession`, `Device`, `ConsentRecord` | `BC-18` | Excluded — `AUD-XC-004`, `AUD-XC-005` |
| `Tenant`, `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` | `BC-19` / `PRD-013` **FROZEN** | Excluded — `AUD-XC-006` |
| `Subscription`, `SubscriptionInvoice` | `BC-20` | Excluded — `AUD-XC-008` |
| `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` | `BC-21` | Excluded — `AUD-XC-007` |
| `Projection`, `CertifiedMetric`, `ReadModel` | `BC-26` | Excluded — `AUD-XC-009` |
| `AgentRun`, `ApprovalRecord` | `BC-27` | Not claimed; §11 `AL-R4` |
| `Conversation`, `RetentionPolicy` | `BC-12` | Not claimed — see §11 `AL-R6` |

**Seven aggregate families belonging to other contexts, seven explicit exclusions or non-claims. Zero encroachments.**

### 2.5 Result

✅ **PASS.** One claimant, one aggregate, matching BC Map §8 L384 exactly. Ownership positively conferred by two
frozen Rank 3 requirements and corroborated by three more. No aggregate of another context claimed.

---

## 3. Check 2 — Every integration edge exists in BC Map §7

> **Authority:** Bounded Context Map §7 · **Failure:** *"If an edge is not in this table, it does not exist"* — needs an ADR

BC Map L292 states the rule verbatim: *"Every edge that crosses a context boundary in V1. If an edge is not in this
table, it **does not exist** and adding it requires an ADR."*

### 3.1 Mechanical comparison — every edge the draft names

`grep -nE "E-[0-9]+" PRD-016_AUDIT_TRAIL.md` returns four distinct edge identifiers. Each was matched against §7:

| Edge cited | Where cited in `PRD-016` | Exists in §7? | §7 row |
|---|---|---|---|
| **`E-20`** | `AUD-FR-010` (the module's **only inbound** edge), `AUD-XC-009` | ✅ **1 match** | L329 — `All contexts → BC-24 Audit Trail`, `PL`, *Event (fire-and-forget, outbox-backed)*, *"Domain never calls audit synchronously"* |
| **`E-23`** | `AUD-XC-010`, as the owner of the surface being **excluded** | ✅ **1 match** | L332 — `All contexts → BC-22 Notification Delivery` |
| **`E-21`** | Stage 1 record only, routing search away | ✅ **1 match** | L330 — `BC-01, BC-10 → BC-23 Search Indexing` |
| **`E-19`** | Stage 1 record only, routing configuration away | ✅ **1 match** | L328 — `All contexts → BC-25 Configuration` |

**4 of 4 edges exist. 0 invented.** The count of §7 edge rows in the map is **26**; no row was added, altered or
implied by this PRD.

### 3.2 The direction of every citation was checked, not just its existence

An edge can exist and still be cited wrongly — as the **wrong direction** or the wrong party. Each was tested:

- **`E-20` is inbound to `BC-24`.** `AUD-FR-010` cites it as *"the module's only inbound integration edge"* — matching
  the row's direction (`All contexts` → `BC-24`). Correct.
- **`E-23` is inbound to `BC-22`, not to `BC-24`.** `AUD-XC-010` cites it while forbidding this module from notifying
  — i.e. it cites `E-23` as evidence that the notification surface **belongs elsewhere**. It does not claim `E-23`.
  Correct use.
- **`E-19` and `E-21`** appear only in the Stage 1 discovery record's *"what `BC-24` does not own"* table, in the same
  routing-away sense. Correct.

### 3.3 The outbound direction: `BC-24` publishes nothing, and this was verified rather than assumed

`AUD-FR-012` states the module *"**MUST NOT** publish any domain event"*, and `AUD-EVT-*` is declared **empty**.
Verified by scanning BC Map §9's event fan-out table (L400–440) for rows whose **producer** column is `BC-24`:

```
awk 'NR>=400 && NR<=440' LIBOORA_BOUNDED_CONTEXT_MAP.md | grep -cE "^\| BC-24"   →   0
```

The producer set is `BC-01`…`BC-06`, `BC-10`…`BC-13`, `BC-18`, `BC-19`, `BC-20`, `BC-27`. `BC-24` appears **25 times
in that table, always in the consumer column** — the widest event fan-in in the architecture. The draft's empty event
register is therefore a **measured fact**, not an omission, and publishing one would require an ADR under L292.

### 3.4 The one edge the draft could have invented, and did not

`AUD-GAP-003` records that *"legal hold"* has no defined mechanism, and `AUD-GAP-001` that no retention period exists
anywhere at Ranks 1–5. A retention or hold mechanism would plausibly need an edge — to `BC-25` Configuration for the
period, or a new edge for hold administration. **The draft declines to create either**, records both as gaps with
named owners, and does not issue an `AUD-CFG-*` identifier. This is the `AL-R3` precedent from the `PRD-013` review:
*"Inventing the event would be a Stage 3 failure dressed as a fix."*

### 3.5 Result

✅ **PASS.** 4 of 4 cited edges exist in §7, each in the correct direction. **0 edges invented.** The outbound-edge
count is mechanically verified at **0**, matching the declared-empty `AUD-EVT-*` register. No ADR is required.

---

## 4. Check 3 — Rank direction is downward

> **Authority:** Module Dependency Matrix `L2` · **Failure:** *"Illegal import"*

### 4.1 The law

Matrix L49, verbatim:

> `| **L2 — Downward only** | A module may depend only on modules of **strictly lower rank** (§3). Same-rank dependencies are forbidden except within a declared cluster. | Rank ordering is what makes the graph provably acyclic without inspecting it. |`

Matrix L54: *"**L1 is absolute. L2–L5 admit exceptions only through the ADR process in §11.**"* Matrix L85 records
that `L2` has *"Two exceptions… both declared and bounded"*, and L655 confirms *"`L2` retains exactly its two declared
cluster exceptions."* **`platform/audit` is not one of them, and this PRD does not request a third.**

### 4.2 The module's rank and its declared import surface

`tool/module_dependencies.yaml` L37 sets `platform/audit: 5`. Its full declared block (L356–371):

```yaml
platform/audit:
  rank: 5
  imports:
    - { target: contracts, mode: import }
  consumes_events: ["*"]
  banned_imports: ["domain/**", "app/**"]
  banned_method_names: ["update*", "delete*", "purge*", "modify*"]   # X-10 append-only
  assertions:
    - id: AU-1  rule: "no public mutation method exists on the audit store"
    - id: AU-2  rule: "this platform is the sole consumer of every Class A authentication fact"   # A-5
    - id: AU-3  rule: "unavailability of this platform delays audit visibility only; recording occurs in the emitter's transaction"
    - id: AU-4  rule: "erasure makes a record non-identifying by key destruction; no record is ever removed"
```

**One import, and it is `contracts`.** Under `L5` (*"Contracts import nothing"*) the shared kernel is the lowest
thing in the graph, so a single import of it is the most conservative possible dependency surface — strictly downward
by definition, and incapable of forming a cycle.

### 4.3 `AUD-FR-013` restates the ban in the specification, matching the manifest

`AUD-FR-013`: *"The module **MUST NOT** import from `domain/**` or `app/**`."* This matches
`banned_imports: ["domain/**", "app/**"]` exactly, and is independently required by BC Map §7.4 `F-1` (L340):

> *"**No capability context may import, reference, or query a domain context.** Not AI, not Analytics, not Search,
> not Notification, not Workflow, **not Audit.**"*

`F-1` names Audit **explicitly**. `F-2` supplies the permitted alternative — *"Capability contexts learn about the
domain **exclusively** through Published Language events defined in `liboora_contracts`"* — which is precisely the
combination the manifest declares (`imports: contracts` + `consumes_events: ["*"]`) and precisely what `AUD-FR-010`
specifies via `E-20`. The specification, the Rank 4 map and the machine-enforced manifest agree on one mechanism.

### 4.4 `consumes_events: ["*"]` is the widest surface in the manifest, and it is not an `L2` breach

No other module declares `["*"]`. It is worth stating why this is lawful rather than exceptional: events are
Published Language living in `contracts`, so consuming *every* event still imports nothing above rank 5. The wildcard
widens the **set of facts** received, not the **set of modules depended upon**. `F-2` makes this the sanctioned
channel; `F-1` closes the unsanctioned one.

### 4.5 The one upward edge that exists in code is a pre-declared debt, and the PRD neither creates nor blesses it

`tool/module_dependencies.yaml` L631–636 declares an acknowledged-debt edge in the **opposite** direction:

```yaml
  - from: domain/library
    to: platform/audit
    mode: port
    reason: "CollectFee takes AuditTrail to append one entry. Fix: declare AuditSink in liboora_contracts.
             Append-only, so the port has no read surface to leak (X-10 keeps audit immutable)."
    adr: ADR-0012
    expires: 2026-12-31
```

Three observations, all material:

1. **Direction.** `domain/library` is rank 8; `platform/audit` is rank 5. Rank 8 → rank 5 is **downward**, so this is
   `L2`-compliant on its face; the debt is about *coupling to a concrete class* rather than a rank violation.
2. **It is already governed.** `ADR-0012` (Rank 2) records it with an expiry of 2026-12-31 and a named remedy —
   *"declare `AuditSink` in `liboora_contracts`."* Stage 3 does not re-litigate a Rank 2 decision.
3. **`PRD-016` does not create it, extend it, or claim it is resolved.** The draft specifies no port, adapter or
   injection shape. `ADR-0012`'s own reasoning already relies on this PRD's core invariant — *"Append-only, so the
   port has no read surface to leak"* — which means the ADR and `AUD-INV-001` reinforce one another rather than
   conflict. Recorded here for completeness; **no disposition required.**

### 4.6 Result

✅ **PASS.** Rank 5, exactly one import (`contracts`, the lowest node), `domain/**` and `app/**` banned in both the
manifest and `AUD-FR-013`, and BC Map §7.4 `F-1` names Audit explicitly. **No `L2` exception requested, so `L2`
retains exactly its two declared exceptions.** The one adjacent debt edge is pre-existing, downward, and governed by
`ADR-0012`.

---

## 5. Check 4 — No authorisation decided outside `BC-18`

> **Authority:** `X-13` · **Failure:** **"A security defect that passes its own tests"**

### 5.1 A note on the cited authority

The lifecycle's Stage 3 table names `X-13` as the authority for this check. `X-13` (Matrix L362) reads:

> `| **X-13** | Cache/index/vector key without tenantId | Oversight, not intent | **Cross-tenant data leak — highest-severity failure class in the system** | Tenant-prefixed key factory; enforced by lint + Multi-Tenant Test Suite |`

`X-13` is a **tenant-key** rule, not an authorisation-location rule. The substantive authority for "authorisation
lives in `BC-18`" is BC Map L127 (*"**BC-18** … Owns credentials, sessions, devices, OTP, roles, permissions, policy
decisions, consent"*) together with §7.4. This mis-citation is **in the lifecycle document, not in `PRD-016`**, and
it is identical to the one the `PRD-013` review recorded at its own check 4. It is **recorded, not fixed** — amending
a governance document is not a Stage 3 act. Both authorities were applied.

### 5.2 The module decides nothing

`AUD-XC-005`, verbatim from the draft:

> *"The module **MUST NOT** make, store, cache or evaluate an authorisation decision. **Confining a query to a
> tenant is not deciding access.**"*

The second sentence is the one that matters, and it is the correct distinction. Restricting results to the resolved
tenant is *scoping*, which every module must do; deciding **whether an actor may see audit at all** is a policy
decision, which `BC-18` owns. The draft draws the line where the architecture draws it.

`AUD-FR-014` and `AUD-FR-015` were tested against this line:

| Requirement | Does it decide access? | Why not |
|---|---|---|
| `AUD-FR-014` — every query confined to one tenant | **No** | Scoping. Cites `AU-7` (Auth §10.4) and `AUTH-10.23`, both **frozen**, as the source of the rule |
| `AUD-FR-015` — a query without a resolved tenant context **MUST** fail | **No** | Refusing to act in the absence of context is the opposite of deciding. Consumes frozen `TEN-FR-011` (*"Reading tenant context when it is unset MUST throw"*) rather than redefining it |
| `AUD-FR-016` — no cross-tenant read surface | **No** | Removes a capability; grants none |

### 5.3 The role-based statement in `AUD-BR-002` was tested most carefully

`AUD-BR-002` names a role — *"Immutability **MUST** hold for **every** role, including Platform Administrator"* — and
naming a role is where an audit PRD would most plausibly stray into authorisation. It does not, for a precise reason:
the requirement grants **no** role any capability and defines **no** role. It states that a capability exists for
**nobody**. A universal denial cannot be an authorisation decision, because there is no decision left to make. Its
authority is `AUTH-10.20` — *"immutable for every role, **including Platform Administrator**"* — a **frozen Rank 3**
requirement, so the role name is quoted from `BC-18`'s own document rather than introduced here.

`AUD-XC-002` is the exclusion form of the same rule and states what must be impossible: *"No support path,
break-glass route or administrative override exists."*

### 5.4 Result

✅ **PASS.** Zero authorisation decisions. The scoping/deciding boundary is drawn explicitly in `AUD-XC-005`. The one
role-bearing rule is a universal denial quoted from a frozen `BC-18` requirement. Authority mis-citation in the
lifecycle document recorded, not repaired.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

> **Authority:** `ID-1` · **Failure:** *"Prohibited"*

### 6.1 The rule and its two forms

BC Map L178 `ID-1` places the mobile number itself with `BC-18`; the manifest carries the machine-checkable form at
L235 — `"*.mobileNumber"` in a banned-field list, annotated *"rule `ID-1` — the number is a credential, held by
`BC-18`"*. Manifest assertion `ID-5` extends it to audit payloads specifically: no payload may contain a mobile
number, challenge, session token or key material.

### 6.2 Exhaustive scan of the draft

Every credential-class term was searched across `PRD-016_AUDIT_TRAIL.md`. The results are **all prohibitions**:

| Term | Occurrences | Every occurrence is… |
|---|---|---|
| credential | in `AUD-INV-004`, `AUD-XC-004` | a **MUST NOT** |
| OTP | in `AUD-INV-004`, `AUD-XC-004` | a **MUST NOT** |
| session token | in `AUD-INV-004`, `AUD-XC-004` | a **MUST NOT** |
| device trust marker | in `AUD-INV-004`, `AUD-XC-004` | a **MUST NOT** |
| key material | in `AUD-INV-004`, `AUD-XC-004` | a **MUST NOT** |
| unmasked personal data | in `AUD-INV-004` | a **MUST NOT** |
| password | in `AUD-XC-004` | a **MUST NOT** |

**Zero occurrences in a permissive or definitional sense.** The draft never defines what a credential is, never
stores one, and never specifies a format for one.

### 6.3 This check is the one where an audit PRD is most exposed, and the draft is stronger than the rule requires

An audit store is the single most likely place for a credential to leak, because its purpose is to record
security-relevant events — the very events that *carry* credentials. `ID-1` would be satisfied by a bare prohibition.
The draft goes further and states it **twice, in two different registers**:

- as an **invariant** (`AUD-INV-004`) — always true of every stored entry, so a violation is a defect in the store;
- as an **exclusion** (`AUD-XC-004`) — stating what must be **impossible**, with `BC-18` named as the owner.

The doubling is deliberate and correct rather than duplicative: an invariant binds the aggregate, an exclusion binds
the module's surface. Four independent authorities are cited between them (`ID-1`, `AUTH-10.22`, `AU-6` (Auth §10.4),
manifest `ID-5`), and `ATT-FR-133` corroborates from a third PRD.

### 6.4 The trap that was not entered

`AUD-INV-003` requires *"an actor of record"*. The natural but wrong implementation of an actor is a human-readable
identifier — an email address or a **mobile number**, which `ID-1` classifies as a credential. The draft does not go
there: it cites BC Map L384's *"actor of record"* and the envelope's `actorId` (§9.1 L449–450), an opaque identifier.
`AUD-INV-004` then forbids unmasked personal data outright. **The identity is referenced, never reproduced.**

### 6.5 Result

✅ **PASS.** Seven credential-class terms, every occurrence a prohibition. Stated in both invariant and exclusion
form. The actor requirement resolves to an opaque `actorId` from the Rank 4 envelope, not to a credential.

---

## 7. Check 6 — Tenant scoping is correct

> **Authority:** `MP-GBR-08`, `X-13` · **Failure:** *"Cross-tenant leak — `MP-RSK-01`, Critical"*

### 7.1 The Rank 1 and Rank 4 rules, and how the draft carries each

| Authority | Line | Rule | Carried by |
|---|---|---|---|
| **`MP-GBR-08`** | `MASTER_PRD.md:339` | *"Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* | `AUD-XC-003` — cross-tenant reach via *"query, projection, cache, index or diagnostic surface"* must be impossible |
| **`MP-GBR-09`** | `MASTER_PRD.md:340` | *"Cross-tenant leakage via a capability context is the single highest-severity failure mode in the architecture."* | `AUD-XC-003`. **`BC-24` is a capability context**, so this rule is aimed squarely at it |
| **`MP-RSK-01`** | `MASTER_PRD.md:551` | *"Cross-tenant data leak via a capability context"* — **Critical** | `AUD-FR-016`, `AUD-XC-003`; the code defect `D-016-01` is measured against it |
| **`X-13`** | Matrix L362 | Tenant key absent ⇒ *"highest-severity failure class in the system"* | `AUD-INV-002`, cited as a **blocker** |
| **BC Map §9.1** *Tenant safety* | L449–450 | *"`tenantId` is mandatory on every domain event. A consumer that processes an event without establishing tenant context must **fail loudly, not default**."* | `AUD-INV-002`, `AUD-FR-005`, `AUD-FR-015` |

### 7.2 Mechanical coverage

`grep -cE "tenant" PRD-016_AUDIT_TRAIL.md` in the requirement sections returns **12 matches across 5 identifiers** —
`AUD-INV-002`, `AUD-FR-014`, `AUD-FR-015`, `AUD-FR-016`, `AUD-XC-003`. Each was read individually; none is decorative.

### 7.3 Fail-loudly is specified as a failure, not a filter

`AUD-FR-015` is the load-bearing requirement of this check:

> *"A query issued without a resolved tenant context **MUST** fail. It **MUST NOT** return an empty result, and
> **MUST NOT** default to a tenant."*

The two negative clauses matter more than the positive one. An empty result is the classic silent failure — it looks
like *"this tenant has no audit"* and is indistinguishable from correct behaviour, which is exactly the
*"security defect that passes its own tests"* shape. Defaulting to a tenant is the leak itself. The draft forbids
both by name, and does so by **consuming** frozen `TEN-FR-011` (*"Reading tenant context when it is unset MUST
throw"*) rather than re-specifying the mechanism — so `PRD-013` remains the single source of truth for what "unset"
means.

### 7.4 The envelope carries the tenant, and the requirement says so

`AUD-FR-005` requires the full §9.1 envelope with *"a non-null `tenantId`"*. This is the structural guarantee behind
`AUD-INV-002`: the tenant is not attached by the audit module as an afterthought, it arrives inside the canonical
Rank 4 envelope from the emitter. `AUD-FR-006`'s idempotency key (`eventId`) comes from the same envelope, so no new
identifier scheme is introduced anywhere in this PRD.

### 7.5 The draft records a live cross-tenant leak in shipped code rather than concealing it

This is the most consequential single finding of the review, and the draft raises it itself. `AUD-FR-016` forbids any
cross-tenant read surface *"including a count, a 'recent entries' listing, an aggregate total or a diagnostic view."*
`lib/platform/audit/audit.dart` currently violates this:

| Code | Line | Measurement | Verdict against `MP-RSK-01` |
|---|---|---|---|
| `recent([int n = 25])` | L60 | `grep -c "tenantId"` inside the method body → **0** | Returns entries across **all** tenants |
| `int get count` | L63 | global list length | Discloses a cross-tenant total |
| Consumers | `lib/app/dashboards/ops_page.dart:270, 272, 282` | 3 call sites | The surface is reachable today |

The draft records this as **`D-016-01`** and states *"is **not repaired here** — Stage 8 is not started. A
specification is permitted to contradict code; that is what it is for."* This review confirms the measurement and the
disposition. **Note also what the code gets right:** `forTenant(TenantId t)` at L57 *does* filter, and no mutation
method exists at all — which is why `X-10` passes today. The defect is a **missing** filter on two convenience
accessors, not an absent tenancy model.

Two further contradictions are carried forward unrepaired: **`D-016-02`** — `AuditEntry` lacks `eventId`,
`correlationId`, `causationId` and `schemaVersion`, and `at` defaults to `DateTime.fromMillisecondsSinceEpoch(0)`
(L51), which `AUD-FR-007` (`AU-9` Auth §10.4, server time) forbids as authoritative; **`D-016-03`** — the store is an
in-memory `List` with no outbox, against `AUD-FR-008`.

### 7.6 Result

✅ **PASS** for the specification. All five tenancy authorities carried; cross-tenant reach framed as **impossible**
rather than merely undesirable; fail-loudly specified as a failure with both silent-failure modes named. The shipped
code contradicts `AUD-FR-016` today — **measured, named `D-016-01`, owned by Stage 8, and not repaired by this
record.**

---

## 8. The seventh test — does the draft create a second source of truth?

Stage 3's table has six checks. This section adds a seventh, not because the lifecycle requires it at Stage 3, but
because `BC-24` is the one context where the *"two sources of truth"* failure is more likely than any ownership
breach — the audit **principles** are already specified in a **frozen Rank 3** document. Recording the test here means
Stage 4 inherits a verified result rather than repeating the discovery.

### 8.1 The nine principles already exist, and the draft cites rather than restates them

`Authentication_PRD_v2.md` §10.4 (L4014–4028) — **FROZEN, Rank 3** — defines `AU-1`…`AU-9`:

| ID | Principle | `PRD-016`'s relationship |
|---|---|---|
| `AU-1` (Auth §10.4) | Completeness — *"Every security-relevant action is recorded, whether it succeeded or failed"* | Emitter-side. Routed away by `AUD-FR-003`, `AUD-XC-011` |
| `AU-2` (Auth §10.4) | Immutability — *"A recorded fact can never be altered or removed by anyone"* | **Cited** by `AUD-INV-001`, `AUD-BR-001` |
| `AU-3` (Auth §10.4) | Attribution | **Cited** by `AUD-INV-003` |
| `AU-4` (Auth §10.4) | Independence — *"Audit is beyond the control of the roles whose actions it records"* | **Cited** by `AUD-BR-002`, `AUD-XC-002` |
| `AU-5` (Auth §10.4) | Minimality | **Cited** by `AUD-INV-004` |
| `AU-6` (Auth §10.4) | Non-disclosure | **Cited** by `AUD-INV-004`, `AUD-XC-004` |
| `AU-7` (Auth §10.4) | Tenant confinement | **Cited** by `AUD-FR-014`, `AUD-XC-003` |
| `AU-8` (Auth §10.4) | Survivability | **Cited** by `AUD-BR-003`, `AUD-XC-012` |
| `AU-9` (Auth §10.4) | Server authority | **Cited** by `AUD-FR-007` |

**Not one principle is restated as an `AUD-*` requirement.** `PRD-016` §0.5 declares this explicitly and gives the
reason: restating them *"would fail Stage 4's 'No requirement restates another PRD's — two sources of truth'."* The
draft specifies the **store** that satisfies the principles; `BC-18` retains the principles themselves.

### 8.2 The `AU-n` collision hazard, and its disposition

`AU-n` names **two different registers**, and both predate `PRD-016`:

| Register | Location | Rank | `AU-4` means |
|---|---|---|---|
| Audit **principles** `AU-1`…`AU-9` | `Authentication_PRD_v2.md` §10.4 | **3, FROZEN** | *"Independence"* |
| Module **assertions** `AU-1`…`AU-4` | `tool/module_dependencies.yaml` `platform/audit` | **4** (tooling of record) | *"erasure makes a record non-identifying by key destruction"* |

This is the `PO-n`/`SPO-n` failure mode the traceability matrix warns about, where citing the wrong one *"would move a
requirement from one bounded context to another."* Here the consequence would be worse: `AU-4` in one register is an
independence rule and in the other an erasure mechanism.

**Disposition — recorded, not repaired.** Neither register may be edited: one is frozen Rank 3, the other is the
machine-enforced manifest, and renaming either would break every existing citation and possibly the boundary checker.
`PRD-016` §0.4 instead imposes **citation discipline**: every reference is qualified as *"`AU-n` (Auth §10.4)"* or
*"manifest `AU-n`"*, and **no bare `AU-n` appears anywhere in the draft.** Verified by reading all occurrences.
Carried from Stage 1 `F-2`.

### 8.3 Prefix collision — verified in both directions

| Test | Command | Result |
|---|---|---|
| `AUD-` unused repo-wide before this PRD | `grep -rn "AUD-" docs/ lib/ tool/` | **0 hits** |
| Prefixes already bearing `*-FR/BR/INV/EVT/XC/AC/CFG/GAP-nnn` | enumerated | `ATT FEE ITG MM SAAS SEAT SID SM TEN` — **9, `AUD` absent** |
| `AUD-*` token would not be read as an `AU-*` token | `echo AUD-FR-001 \| grep -c "AU-"` | **0** |
| `AU-*` token would not be read as an `AUD-*` token | `echo AU-3 \| grep -c "AUD-"` | **0** |

The hyphen makes the tokens non-overlapping: `AU-` is always followed by a digit, `AUD-` always by a letter.
**Zero collisions in either direction.** Note this is a Stage 3 *safety* check only — **no identifier is registered by
this record**; registration is Stage 5's gate.

### 8.4 Result

✅ **PASS.** Nine frozen principles cited, zero restated. The `AU-n` dual-register hazard is contained by citation
discipline rather than by editing a frozen or machine-read document. `AUD-` is collision-free in both directions.

---

## 9. Open, non-blocking items — each with a named owner

Stage 3 does not require these to be closed; Stage 4's gate requires them to be *"explicitly deferred **with a reason
and an owner**."* All five are carried unchanged from the draft's §10. **None is closed by this record, and none is
invented.**

| ID | Item | Owner | Why it does not block Stage 3 |
|---|---|---|---|
| `AUD-GAP-001` | **No audit retention period is defined anywhere at Ranks 1–5.** `MP-GBR-13` says *"legal hold blocks purge"* without defining hold or period; `MP-NFR-10` assigns retention and legal hold to **SECURITY + DATA Governance**; `Q-04` is *"Open — needs counsel"*; Rank 7 `CONFIGURATION_GUIDE.md` defines no audit parameter (`CFG-9`/`CFG-10` are **account** retention) | **SECURITY + DATA Governance**, with counsel | Stage 3 tests architecture, not commercial or legal parameters. Supplying a period would invent a legal rule — forbidden by the authoring instruction and by `MP-NFR-10`'s ownership. `AUD-CFG-*` is consequently **not issued at all** |
| `AUD-GAP-002` | **`AUTH-10.27` vs `E-20` / manifest `AU-3`.** `AUTH-10.27` (frozen Rank 3) requires inability-to-record to **fail** a security-critical action; `E-20` (Rank 4) is *"fire-and-forget"* and manifest `AU-3` says unavailability *"delays audit visibility only"* | **`BC-18`** + **ARB** | The draft is written so this module's obligation is **identical under either reading**: `AUD-FR-008` places the write in the *emitter's* transaction, so what could fail is the emitter's local outbox write, not a call into this module. Reconciling a frozen Rank 3 requirement with a Rank 4 edge is an ARB act, not a Stage 3 one |
| `AUD-GAP-003` | **"Legal hold" has no defined mechanism.** `MP-GBR-13` and BC Map L384 both say it *"blocks purge"*; no document defines who applies a hold, to what scope, or how it is released | **SECURITY + DATA Governance** | With `AUD-BR-003` (never remove), **purge has no path in V1**, so no hold mechanism is needed to satisfy any invariant. Recorded because the phrase sits in a **Rank 1** rule |
| `AUD-GAP-004` | **Support-access recording.** BC Map L133 gives `BC-24` the record *"including AI actions and support access"*, but no Rank 1–5 document defines a support-access action list | **Product Owner** + **`BC-18`** | `AUD-FR-003` places the auditable-action list with the **emitter**. No emitter has published a support-access list, so there is nothing for this module to record yet. Inventing one would breach `AUD-XC-011` |
| `AUD-GAP-005` | **The Class A fact register is not in the repository.** Manifest `event_register_source: docs/prd/authentication` — **that path does not exist**; `EVT-1001`…`EVT-1036` member names are recorded as never available | **`BC-18`** | `AUD-FR-011` cites the enforceable **class contract** (`A-5`, `ID-3`, manifest `AU-2`) rather than individual `EVT-*` numbers it cannot verify. Citing unverifiable identifiers would be worse than citing the contract |

### 9.1 The AI-action obligation was checked and needs no new gap

BC Map L133 gives `BC-24` the record *"including AI actions"*, and `MP-GBR-31` (Rank 1, L439) plus BC Map `F-4` (L344)
require AI-initiated domain writes to produce an `AI Action Log` entry with *"No exceptions in V1"*. BC Map §9 L438
registers `BC-27`'s producer row — `ai.AgentRunCompleted` / `AiActionApplied` → `BC-24`, `BC-26`.

This needs **no** new requirement and **no** new gap: the edge already exists, `BC-27` is already the producer, and
`AUD-FR-010`/`AUD-FR-011` already oblige this module to consume what arrives on `E-20` without discriminating by
producer. Any AI-specific auditable-action list belongs to `BC-27` under `AUD-FR-003`. Inventing an `AI Action Log`
sub-aggregate here would breach both `AUD-FR-004` (one aggregate) and `AUD-XC-011`. See §11 `AL-R4`.

---

## 10. Code contradictions carried forward — measured, named, not repaired

The draft's §11 records three. This review re-measured each against the file on disk at `e99c1cd`. All three confirmed.

| ID | Contradiction | Measured | Requirement contradicted | Disposition |
|---|---|---|---|---|
| **`D-016-01`** | `recent()` (L60) and `count` (L63) expose cross-tenant reads; reachable from `ops_page.dart:270, 272, 282` | `grep -c "tenantId"` inside `recent()` → **0** | `AUD-FR-016`, `AUD-XC-003`; severity by `MP-RSK-01` **Critical** | **Stage 8.** Not repaired here |
| **`D-016-02`** | `AuditEntry` lacks `eventId`, `correlationId`, `causationId`, `schemaVersion`; `at` defaults to `DateTime.fromMillisecondsSinceEpoch(0)` (L51) | 4 envelope fields absent; epoch-zero default present | `AUD-FR-005`, `AUD-FR-006`, `AUD-FR-007` | **Stage 8.** Not repaired here |
| **`D-016-03`** | Storage is an in-memory `List` (L33); no outbox, no persistence | `_entries` is `final List<AuditEntry>` | `AUD-FR-008` | **Stage 8.** Not repaired here |

**What the code already gets right, recorded so the review is not one-sided.** `lib/platform/audit/audit.dart`
contains **no** update, delete, purge or modify method — `append` is documented as *"The ONLY mutation method.
Intentional."* — which is why `X-10` is *"implemented and passing"* (`ADR-0014`; Matrix L13, L580). `forTenant()`
(L57) filters correctly. `AuditEntry` is `final class` with all-`final` fields. The scaffold's tenancy model is
present; two convenience accessors bypass it.

**Following the `D-013-01` / `D-013-02` precedent:** a code defect discovered during a documentation stage is
**measured and named**, never repaired inside that stage. `git status --short lib/ packages/ test/ tool/` returns
**0 lines** for this review.

---

## 11. Rejected findings — recorded as rejected, with reasons

> `PRD_LIFECYCLE.md` Stage 3: *"**A rejected finding must be recorded as rejected, with its reason.** … A review that
> records only accepted findings is indistinguishable from a review that found nothing."*

Nine candidate findings were raised during this review and rejected. Each is preserved with the test that refuted it.

| # | Candidate finding | Rejected because |
|---|---|---|
| `AL-R1` | *"`PRD-016` restates a frozen PRD: `AUD-INV-001` says the same thing as `AU-2` (Auth §10.4), so check 1 fails on 'two sources of truth'."* | Read both. `AU-2` (Auth §10.4) is a **principle** — *"a recorded fact can never be altered or removed by anyone."* `AUD-INV-001` is an **invariant on a named aggregate** with a named enforcement mechanism — no update/delete/purge/modify path exists in code, per manifest `banned_method_names`. A principle and its enforcement site are not two sources of truth; they are the division `AUTH-10.26` explicitly creates by vacating *storage* to `BC-24` while keeping the principles. `PRD-016` §0.5 declares the distinction rather than leaving it implicit |
| `AL-R2` | *"`BC-24` is `[GENERIC]` — BC Map L58 says a generic subdomain is a 'solved problem; buy or use a thin in-house wrapper' — so a full PRD is over-specification and Stage 3 should reject the scope."* | `[GENERIC]` describes **build-vs-buy strategy**, not documentation depth. `BC-18` (`Authentication`), `BC-19` (`Tenancy`), `BC-20`, `BC-21`, `BC-22`, `BC-23` are all `[GENERIC]` (L127–132) and **four of them already have PRDs, two of them FROZEN**. Rejecting on this basis would retroactively invalidate `PRD-013` and the Authentication PRD. `MP-GBR-13` (Rank 1) also mandates the invariant regardless of sourcing |
| `AL-R3` | *"`AUD-GAP-001` is a Stage 3 blocker: a store with no retention period is architecturally incomplete, so the review must stop."* | Tested against the gate. Stage 3's six checks are ownership, edges, rank, authorisation, credentials, tenancy — **retention is in none of them**. `MP-NFR-10` (Rank 1) assigns retention to `SECURITY + DATA Governance`, and `Q-04` records it *"Open — needs counsel"* product-wide. `SEAT-XC-015` (**frozen**) proves the precedent: a frozen PRD shipped while explicitly placing *"audit retention, legal hold, purge, export"* out of scope. Stopping here would block on a question the repository has already agreed to hold open |
| `AL-R4` | *"BC Map L133 says `BC-24` owns the record 'including AI actions', and `MP-GBR-31` requires an `AI Action Log`, so `PRD-016` must specify an `AI Action Log` — its absence is an incompleteness finding."* | Opened §9 L438 rather than trusting the phrase. `BC-27` is already the **producer** (`ai.AgentRunCompleted` / `AiActionApplied` → `BC-24`), the edge is `E-20`, and `AUD-FR-010`/`AUD-FR-011` already oblige consumption of everything that arrives. An `AI Action Log` **sub-aggregate** would breach `AUD-FR-004` (one aggregate) and the action list belongs to `BC-27` under `AUD-FR-003`/`AUD-XC-011`. §9.1 records the reasoning. Nothing to add |
| `AL-R5` | *"`AUD-BR-003` (erasure by key destruction) invents a compliance mechanism — the exact thing the authoring instruction forbids."* | This was the most serious candidate and it was tested hardest. The mechanism is quoted **verbatim** from manifest assertion `AU-4`: *"erasure makes a record non-identifying by key destruction; no record is ever removed."* It is corroborated by `AU-8` (Auth §10.4), `AUTH-10.25`, `MP-GBR-04` (Rank 1) and BC Map `ID-5`. **Five independent authorities.** No period, jurisdiction, statute or legal rule is supplied — only the mechanism the repository already records. Found, not invented |
| `AL-R6` | *"`BC-12` Messaging owns a `RetentionPolicy` value object (BC Map L378) and its purge is 'irreversible and audited'; `AUD-BR-003`'s never-remove rule therefore contradicts a Rank 4 aggregate."* | Read L378. `RetentionPolicy` governs **`Conversation`/`Message`** retention inside `BC-12` — a different aggregate in a different context. *"Irreversible and audited"* means the purge **emits an audit fact**, which `AUD-FR-010` consumes; it says nothing about purging the audit entry itself. `AUD-XC-009`'s *"MUST NOT become a system of record for any domain fact it records"* keeps the two separate. No contradiction; the two rules operate on different objects |
| `AL-R7` | *"`consumes_events: ['*']` is the widest dependency surface in the manifest and should be raised as an `L2` risk requiring an ADR."* | `L2` governs **module** dependencies, not the breadth of a Published Language subscription. Events live in `contracts`, which is the lowest node in the graph (`L5`), so consuming every event imports nothing above rank 5. BC Map §7.4 `F-2` makes event consumption the **sanctioned** channel for exactly this purpose. Requesting an ADR would manufacture a controversy in order to resolve it — the `D-013-01` precedent. §4.4 records the reasoning positively instead |
| `AL-R8` | *"`D-016-01` is a live **Critical** cross-tenant leak (`MP-RSK-01`); a Stage 3 review that leaves it unrepaired is negligent."* | Two rules forbid the repair. The authoring instruction: *"Do not modify implementation code. Do not enter Stage 8."* And the lifecycle's own separation of specification from implementation — the `D-013-01`/`D-013-02` precedent measured and named defects without touching code. The **correct** Stage 3 act is what was done: measure it (`grep -c "tenantId"` → 0), name it, cite the severity authority, name the call sites, and route it to Stage 8 with `AUD-FR-016` as the requirement it will be built against. A defect that is specified against is closer to fixed than one repaired without a specification |
| `AL-R9` | *"`PRD_REGISTRY.md` still shows `PRD-016` as `PLANNED`; passing Stage 3 should move it to `DRAFT` and add a baseline row."* | Registry status and baseline rows are conferred at **Stage 7** by an admission ADR — freeze is *"conferred, not claimed."* Doing it here would perform Stage 7 work inside Stage 3, and `ADR-0020` §4 item 2 (*"Freeze confers status; it does not renumber"*) governs the sequence. Registry status remains **`PLANNED`**. The `AL-R8` precedent from the `PRD-013` review |

---

## 12. Conflicts found at Stage 3

| # | Conflict | Disposition |
|---|---|---|
| — | **None.** | Six checks, zero conflicts between `PRD-016` and any Rank 1–5 authority |

Three **pre-existing** repository inconsistencies were encountered. None is caused by `PRD-016`, none blocks it, and
none is repaired here:

| # | Pre-existing inconsistency | Where | Disposition |
|---|---|---|---|
| **`S3-A-01`** | `PRD_DEPENDENCY_GRAPH.md` `D-09` and `PRD_GAP_ANALYSIS.md` `PGA-04` both still state that `X-10` (audit mutation check) is *"**not implemented**"* — while `ADR-0014` (**Accepted**, Rank 2) and Matrix L13/L580 record it as implemented and passing | Rank-adjacent governance docs | **Recorded, not fixed.** Carried from Stage 1 `F-1`. Same defect class as `GCP-15/16/17`. `PRD-016` cites the **Matrix and `ADR-0014`**, never `D-09`'s status line, so no stale claim propagates into the specification |
| **`S3-A-02`** | The lifecycle's Stage 3 table cites `X-13` (a tenant-key rule) as the authority for the **authorisation-location** check | `PRD_LIFECYCLE.md` L92 | **Recorded, not fixed** (§5.1). Identical to the `PRD-013` review's finding. Both the cited and the substantive authority were applied |
| **`S3-A-03`** | Manifest `event_register_source: docs/prd/authentication` points at a path that does not exist | `tool/module_dependencies.yaml` | **Recorded** as `AUD-GAP-005`, owner `BC-18`. `AUD-FR-011` cites the class contract instead of unverifiable `EVT-*` numbers |

---

## 13. Containment audit

| Check | Result |
|---|---|
| `PRD-016_AUDIT_TRAIL.md` modified | **No** — SHA-256 `281f15e8…39be` identical before and after |
| PRD status / version changed | **No** — remains **v0.1 `DRAFT`** |
| PRD frozen | **No** |
| `PRD-016_STAGE1_DISCOVERY.md` modified | **No** |
| Any other PRD modified | **No** |
| Authentication PRD (frozen) · Seat PRD (frozen) · Attendance PRD (frozen) · Tenancy PRD (frozen) modified | **No** |
| BC Map · Master PRD · Dependency Matrix · Rulings · EA modified | **No** |
| `tool/module_dependencies.yaml` modified | **No** |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` modified | **No** |
| Registry status changed | **No** — `PRD-016` remains **`PLANNED`** |
| ADR created or modified | **No** — none required by any of the six checks |
| `TRACEABILITY_MATRIX.md` touched (Stage 5) | **No** |
| `AUD-*` identifiers registered anywhere | **0** |
| Traceability checker created | **No** |
| Integration edge, domain event or aggregate field invented | **No** — 4/4 edges pre-existing, 0 events, 0 fields added |
| Retention period, legal rule or jurisdiction invented | **No** — `AUD-GAP-001`/`003` left open |
| Configurable invented | **No** — `AUD-CFG-*` remains unissued |
| Existing gap closed by this record | **No** — all five §9 items remain open with named owners |
| **Implementation code modified** | **No** — `git status --short lib/ packages/ test/ tool/` → **0 lines** |
| Code defect repaired | **No** — `D-016-01`…`03` measured and routed to Stage 8 |
| Stage 4 / 5 / 6 / 7 started | **No** |
| **Stage 8 entered** | **No** |
| Commits · pushes made by this review | **0 / 0** |
| Files added | **1** — this document |

This record is a **historical validation record and is not part of the specification**, following
`DOCUMENTATION_BASELINE.md` §3.3's treatment of `LIBRARY_PRD_ALIGNMENT.md`, `STUDENT_IDENTITY_ALIGNMENT.md`,
`PRD-004_ALIGNMENT_REPORT.md`, `PRD-006_ARCHITECTURE_ALIGNMENT.md` and `PRD-013_ARCHITECTURE_ALIGNMENT.md`.
**It confers no status.**

---

## 14. Verdict

> ## ✅ **ALIGNED — Stage 3 PASS (6 of 6)**

| # | Check | Authority | Result |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3, §8 L384 | ✅ **PASS** — one claimant, one aggregate; ownership **vacated by** `AUTH-10.4`/`AUTH-10.26` (frozen) and corroborated by `SEAT-FR-232`, `SEAT-XC-015`, `ATT-FR-079`/`130` |
| 2 | Every integration edge exists in §7 | BC Map §7 L292 | ✅ **PASS** — **4/4 cited edges exist, 0 invented**; outbound edge count mechanically **0** |
| 3 | Rank direction is downward | Matrix `L2` | ✅ **PASS** — rank 5, one import (`contracts`); `F-1` names Audit explicitly; **no new `L2` exception** |
| 4 | No authorisation decided outside `BC-18` | `X-13` *(mis-cited — §5.1)* | ✅ **PASS** — 0 decisions; scoping/deciding line drawn in `AUD-XC-005`; the one role-bearing rule is a universal denial quoted from `AUTH-10.20` |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | ✅ **PASS** — 7 credential-class terms, **every occurrence a prohibition**; actor resolves to opaque `actorId` |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** — 5 authorities carried; cross-tenant reach framed as **impossible**; both silent-failure modes named |
| 7* | *(added)* No second source of truth | Stage 4 preview | ✅ **PASS** — 9 frozen principles **cited, 0 restated**; `AU-n` dual register contained by citation discipline |

**0 conflicts.** **5 open items, none blocking**, each with a named owner. **3 code contradictions measured and routed
to Stage 8, none repaired.** **9 candidate findings rejected, each with its reason (§11).** **3 pre-existing
repository inconsistencies recorded, none fixed (§12).**

Three places where the draft is stronger than the rules require, all volunteered rather than mandated:
`AUD-FR-015` forbids the two *silent* tenancy failures by name rather than merely requiring a filter;
`AUD-INV-004` and `AUD-XC-004` state the credential prohibition twice, binding the aggregate and the module surface
separately; and `AUD-CFG-*` is **never issued** rather than issued-then-retired, so no identifier is burned to record
an absence.

The one thing this review could not do, and correctly did not attempt: repair `D-016-01`, a live cross-tenant read
surface rated **Critical** by `MP-RSK-01`. It is measured, named, given call sites, and given the requirement
(`AUD-FR-016`) it will be built against at Stage 8.

**Stage 3 gate satisfied.** `PRD-016` may proceed to **Stage 4 — Requirements Review**. Status remains
**v0.1 `DRAFT`**; registry status remains **`PLANNED`**.

---

## 15. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 3 Architecture Alignment Record** for `PRD-016` Audit Trail. Ran all six lifecycle checks in order against Ranks 1–5, plus a seventh no-second-source-of-truth test. **6 of 6 PASS, 0 conflicts.** Proved exclusive ownership by convergence from **five frozen disclaimers** rather than by absence. Verified **4/4 cited edges** exist and **0** were invented; verified the outbound edge count is mechanically **0**. Recorded **5 open gaps** with named owners, **3 code contradictions** (`D-016-01`…`03`) routed to Stage 8, **9 rejected findings** with reasons, and **3 pre-existing repository inconsistencies** (`S3-A-01`…`03`) left unrepaired. **No PRD modified, no ADR created, no identifier registered, no ranked document touched, no code modified, no commit or push.** |
