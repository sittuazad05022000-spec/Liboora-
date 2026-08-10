# `PRD-007` Seat Management v1.0 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L155–174) |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, `BC-04` Seating, **v1.0 `DRAFT`** |
| **Gate satisfied by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked examples followed** | [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) |
| **Prior record consumed** | [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](PRD-007_INDEPENDENT_GAP_VERIFICATION.md) — verdict **A**; `SEAT-GAP-001` false positive, `SEAT-GAP-003` open/non-blocking |
| **Reviewed at** | `f89cd9d` |
| **PRD hash at review** | `623b8945ba03161fda507137315ee04f64cd72e99af9c08036a7441243be386a` — verified identical before and after |
| **Date** | 2026-08-10 |
| **Mandate** | **Stage 3 only.** No PRD modified, no ADR, no ranked document touched, no registry or baseline update, no specification, no implementation, no freeze. Stages 4–7 not started |
| **Verdict** | ✅ **ALIGNED — 6 of 6 checks PASS.** 0 conflicts · 1 false positive carried forward (`SEAT-GAP-001`) · 13 open gaps, none blocking (§8.3) · 7 findings rejected with reasons (§9) |

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line. Nothing is asserted from
conversation memory, and nothing is taken on trust from the PRD under review — each claim the PRD makes about a
ranked document was re-read at its source.

Where the PRD text conflicts with a higher-precedence document, the precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
**never which one to quietly ignore.** Per §4: *"A conflict is a defect. If you find one, do not choose — raise it."*

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD v1.7 | `../MASTER_PRD.md` | **1** |
| 2 | ADRs — `ADR-0011`, `ADR-0012`, `ADR-0013`, `ADR-0014`, `ADR-0018`, `ADR-0019` | `../../00-governance/adr/` | **2** |
| 3 | Authentication PRD v2.0 | `../authentication/Authentication_PRD_v2.md` | **3** |
| 4 | Library PRD v1.1 | `../library/Library_PRD_v1.md` | **3** |
| 5 | Student Management PRD v1.2 — **FROZEN** | `../student-management/Student_Management_PRD_v1.md` | **3** |
| 6 | Membership Management PRD v1.4 — **FROZEN** | `../membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **3** |
| 7 | Bounded Context Map — §3, §4, §7, §8, §9, §13 | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 8 | Module Dependency Matrix v1.3 — `L2`, `X-13`, `ID-1` | `../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** |
| 9 | Architecture Rulings v1.2 | `../../10-architecture/ARCHITECTURE_RULINGS.md` | **5** |
| 10 | Documentation Baseline · PRD Lifecycle | `../../00-governance/` | — |

Ranks 6 (Enterprise Architecture) and 7 (Configuration Guide) are **not** Stage 3 authorities — the lifecycle
scopes this stage to *"Ranks 1–5"*. The EA is **descriptive only** (baseline L139, L206) and is cited below only
where the PRD's alignment with Ranks 1–5 is unaffected.

### 1.2 Classification scheme

| Class | Meaning |
|---|---|
| **PASS** | Verified compliant against the named authority |
| **CONFLICT** | Two documents assert incompatible facts. Raised, never resolved here |
| **REJECTED FINDING** | A candidate finding examined and rejected, with its reason recorded |
| **OPEN / NON-BLOCKING GAP** | A genuine absent decision, owned elsewhere, that does not block this stage |

Findings are **not** raised for stylistic variation, differing levels of detail, or a document being silent on a
topic another document covers — the `DOCAUDIT-001` §1 rule.

---

## 2. Check 1 — Context ownership is exclusive

**Authority:** BC Map §3 (Context Register). **Failure mode:** *"Two PRDs own one aggregate."*

### 2.1 The context claim

BC Map §3.1 L99 registers `BC-04`:

> `| **BC-04** | **Seating** | [CORE] | Library Management | V1 | Owns physical space allocation: layout, seat inventory, assignment, transfer, live occupancy. |`

`PRD-007` `SEAT-FR-006` (L170) claims **exactly** the two aggregates BC Map §8 L373 assigns:

> *"This module owns exactly two aggregates, as fixed by BC Map §8: `SeatAllocation` and `SeatLayout`."*

No third aggregate is claimed. `SEAT-FR-007` (L173) restates the transaction boundary rule and adds the derived
prohibition that one operation *"MUST NOT transactionally mutate `SeatAllocation` and `SeatLayout` together."*

### 2.2 Exclusivity verified by exhaustive search

A repository-wide search for `SeatAllocation` / `SeatLayout` across `docs/30-product/` returns exactly three files:
`PRD-SEAT-MANAGEMENT.md`, this module's own gap-verification record, and `PRD-004_OWNERSHIP_MATRIX.md`. The last is
**corroborating, not competing** — `PRD-004_OWNERSHIP_MATRIX.md:39`:

> `| Seat / SeatAllocation | BC-04 Seating | PRD-007 (PLANNED) | BC Map |`

A frozen PRD's own ownership matrix therefore **assigns these aggregates to `PRD-007`**. **No other PRD claims
either aggregate.**

### 2.3 The ten-context ownership boundary

`PRD-007` §3.4 (L215–229) tabulates ten contexts with an explicit *"This module MUST NOT"* column, and
`SEAT-BR-002` (L231) makes duplication a defect to be raised rather than implemented. Spot-verified against source:

| Claim in §3.4 | Verified against | Result |
|---|---|---|
| `BC-10` — *"No edge exists. `E-13` is the only bridge and it belongs to `BC-01`"* | BC Map `ID-3`/`ID-4` L180–181; `E-13` | **PASS** |
| `BC-02` — must not recompute validity or alter `seatQuota` | `MM-FR-070`, `MM-FR-014`; `E-02` L299 | **PASS** |
| `BC-03` — must not record, correct or verify attendance | BC Map `E-08` L305 | **PASS** |
| `BC-05` — *"None. No edge exists"*; must hold no price or currency | BC Map §7 — no `BC-04`↔`BC-05` edge; `LXC-7` | **PASS** |
| `BC-18` — consumes RBAC, must not invent a framework | `MP-GBR-20`…`23`; `AR-4` | **PASS** |
| `BC-26` — operational counts only, no warehouse | BC Map §3.3 `BC-26`; `F-1`…`F-4` | **PASS** |

### 2.4 Result

> ### **Check 1 — PASS**

Ownership is exclusive. `BC-04` claims exactly its two registered aggregates; no other PRD claims them; a frozen
PRD's ownership matrix independently confirms the assignment.

---

## 3. Check 2 — Every integration edge exists in BC Map §7

**Authority:** BC Map §7. **Failure mode:** BC Map L292 — *"If an edge is not in this table, it does not exist and
adding it requires an ADR."*

### 3.1 Mechanical comparison

Every `E-nn` identifier cited anywhere in `PRD-007` was extracted and compared against the edges BC Map §7
actually declares:

| Set | Members |
|---|---|
| Cited by `PRD-007` (13) | `E-01` `E-02` `E-03` `E-04` `E-05` `E-08` `E-13` `E-17` `E-18` `E-19` `E-20` `E-21` `E-23` |
| Declared in BC Map §7 (26) | `E-01` … `E-26` |
| **Cited but not declared** | **∅ — none** |

> **Zero invented edges.** Every edge the PRD names exists in the Rank 4 register.

### 3.2 The inbound set is a subset of BC-04's actual edges

BC Map §7 declares exactly three core-to-core inbound edges for `BC-04`, plus the capability edges:

| Edge | BC Map line | Contract | PRD-007 obligation (§3.2 L190–197) | Result |
|---|---|---|---|---|
| `E-02` | 299 | `MembershipValidity{studentRecordId, validUntil, seatQuota}` — *"Seating **rejects** assignment if invalid"* | *"**Reject** acquisition when invalid (`SEAT-BR-012`). Never recompute validity"* | **PASS — exact** |
| `E-05` | 302 | `SeatRules{maxTransfersPerDay, reservationWindow}` sync port | *"**Conform** — consume as given, do not translate, do not store a competing copy"* | **PASS** — matches `E-04`'s *"conforms, does not translate"* pattern |
| `E-08` | 305 | `StudentCheckedIn/CheckedOut` → *"**Seating is the occupancy owner**, Attendance is the trigger"* | Same words, `SEAT-FR-113`…`116` | **PASS — exact** |
| `E-17` | 326 | `check(tenantId, feature, delta)` before mutation | *"Call **before** the aggregate mutates"* | **PASS** |
| `E-18` | 327 | Ambient `TenantContext`, *"propagated, never passed as a parameter"* | Same words | **PASS** |
| `E-19` | 328 | Typed accessors, no raw string lookups | Same | **PASS** |

`SEAT-FR-009` adds *"MUST NOT read another context's tables"* — consistent with `LIB-26.1`'s
read-through-projection rule and with `X-08`'s prohibition on scanning a foreign repository.

### 3.3 Outbound restraint

`SEAT-FR-011` limits outbound integration to `E-20` (Audit), `E-23` (Notification) and the §22 domain events.
`SEAT-FR-012` forbids a synchronous audit call and forbids instructing `BC-22` to send anything — matching BC Map
`E-20` (*"domain never calls audit synchronously"*) and `E-23` (*"domain emits facts, never 'send an SMS'"*).

`SEAT-XC-021` (L1827–1829) is notable for **declining** an edge it could have wanted:

> *"`BC-23` Search Indexing owns indexing, and `E-21` does not list `BC-04` as a producer — so this module **MUST
> NOT** publish to the search index in V1, and **MUST NOT** be given an edge to it."*

Verified: BC Map `E-21` L331 names `BC-01`/`BC-10` as producers, not `BC-04`. This is the same refusal
`MM-BR-035` and `SM-GAP-11` applied — declining to invent an edge rather than assuming one.

### 3.4 Domain events against BC Map §9

`SEAT-EVT-*` is closed at four (§0.3, `SEAT-BR-035`). BC Map §9 L418–419 declares
`seating.SeatAssigned`/`SeatReleased`/`SeatTransferred` and `seating.OccupancyThresholdCrossed` — **four**. The
closed register matches the Rank 4 surface exactly, following the `MM-BR-035` precedent of closing at the declared
count rather than extending it.

### 3.5 Result

> ### **Check 2 — PASS**

Thirteen edges cited, thirteen declared in BC Map §7, zero invented. One edge (`E-21`) is explicitly **declined**
where the module is not a registered producer.

---

## 4. Check 3 — Rank direction is downward

**Authority:** Module Dependency Matrix `L2`. **Failure mode:** illegal import.

### 4.1 The law

`LIBOORA_MODULE_DEPENDENCY_MATRIX.md:49`:

> `| **L2 — Downward only** | A module may depend only on modules of **strictly lower rank** (§3). Same-rank
> dependencies are forbidden except within a declared cluster. |`

`BC-04` sits in **`LIBRARY MANAGEMENT`, rank R8** (§3 L74 — *"Domain. Highest rank because it depends on the
most. Nothing depends on it."*).

### 4.2 Every dependency direction verified

| PRD-007 dependency | Target rank | Direction | `L2` |
|---|---|---|---|
| `BC-02` Membership, `BC-06` Policy, `BC-03` Attendance, `BC-01` Enrollment (`E-02`/`E-05`/`E-08`/`E-01`) | R8 — **same rank** | Within the **declared Core Library cluster** | **Legal** — Matrix L89: *"Core Library cluster (within R8) … Only the edges `E-01`…`E-10` listed in the context map. Enforced as an explicit allow-list."* All four are inside `E-01`…`E-10` |
| `BC-21` Entitlement (`E-17`) | R6 Business | downward | **PASS** |
| `BC-19` Tenancy (`E-18`) | R4 Shared Core | downward | **PASS** |
| `BC-25` Configuration (`E-19`) | R3 | downward | **PASS** |
| `BC-24` Audit (`E-20`), `BC-22` Communication (`E-23`) | R5 | downward | **PASS** |
| `BC-26` Analytics | R7 | downward — and **not** consumed as a dependency; the module merely serves counts | **PASS** |
| `BC-23` Search | R5 | **no dependency taken** (`SEAT-XC-021`) | **PASS** |

### 4.3 The forbidden upward direction is honoured

BC Map `F-1`…`F-4` forbid a capability context importing, referencing or querying a domain context.
`PRD-007` §22/§25 keep the module on the correct side: it **emits** to `BC-24`/`BC-22` and **serves** read models
to `BC-26`, and nothing in the PRD requires a capability context to call into `BC-04`.

`X-05` is not engaged: the module takes no dependency on `BC-11`…`BC-17`, and §3.4 records that `BC-10` has **no
edge** at all — a stricter position than `X-05` requires (Matrix L354 permits a downward `BC-10` dependency since
`ADR-0011`; the PRD simply does not use it).

### 4.4 Result

> ### **Check 3 — PASS**

Every dependency is strictly downward, or same-rank strictly within the declared Core Library cluster allow-list
`E-01`…`E-10`. No `L2` exception is requested and none is needed.

---

## 5. Check 4 — No authorisation decided outside `BC-18`

**Authority:** `X-13` and the `BC-18` boundary. **Failure mode:** *"A security defect that passes its own tests."*
**Reviewed line-by-line.**

### 5.1 The framework is consumed, never invented

`SEAT-FR-268` (L268 region, §28.1):

> *"This module **MUST NOT** define an authorisation framework. It consumes the platform model already fixed by
> Master PRD `MP-GBR-20`…`23` and Authentication PRD v2.0: roles are `owner`, `manager`, `reception`, `student`,
> `parent`, plus Platform Support and Platform Administrator; permissions are **scope-bearing**; and the scope
> register is **closed** at `self`, `guardianOf` and `tenantWide`."*

Verified against source, word by word:

| Element | Authority | Line | Match |
|---|---|---|---|
| Scope-bearing permissions | `MP-GBR-20` | 119 | exact |
| Closed register `self`/`guardianOf`/`tenantWide` | `MP-GBR-21` | 120 | exact, including *"No fourth scope … without an ADR"* |
| Non-disclosing denial | `MP-GBR-22` | 121 | exact |
| Per-library grants | `MP-GBR-23` | 122 | consistent |
| Five roles | Authentication `TR-1`…`TR-3`, `BR-2.9` | — | consistent |

### 5.2 No scope is added

`SEAT-FR-269`: *"This module **MUST NOT** add a scope value. `MP-GBR-21` closes that register."* A conceivable
floor- or zone-scoped grant is **not invented** — it is recorded as `SEAT-GAP-006` and stated to require an ADR,
with V1 grants restricted to `tenantWide` for staff and `self` for students. This is the correct handling of a
closed register.

### 5.3 No role is created, invited, elevated or revoked

`SEAT-FR-270` assigns role assignment, invitation and revocation to Authentication, citing `AR-4` and `BR-2.9`
(*"all invite-only"*). §3.4's `BC-18` row forbids *"invent an authorization framework, define a role, or store a
credential."*

### 5.4 Authorisation precedes the domain gate — the ordering matters

`SEAT-FR-271`: *"Every operation … **MUST** be authorised **before** the acquisition gate of §8 runs, so that an
unauthorised caller learns nothing about seat availability from the shape of the failure."*

Verified in the gate itself: §8 lists **G2 — actor authorised** (*"non-disclosing denial (§28.4)"*, authority
`MP-GBR-20`…`22`) ahead of every domain check, and **G5 — student exists** returns *"not found — identical to no
permission under G2"*, citing `MP-GBR-22`. The information-leak channel a naive ordering would open is closed by
construction.

### 5.5 The protected-operation list is closed and complete

`SEAT-FR-272` closes the list: *"An operation not in this list does not exist in V1."* Measured: **24 rows**,
`SEAT-PO-001`…`SEAT-PO-024`, each with a per-role decision across Owner / Manager / Reception / Student and a
back-reference to its defining requirement. Conditional cells name the governing configurable (`C`) or require an
explicit grant the role alone does not imply (`G` — e.g. `SEAT-PO-016` layout edit, `SEAT-PO-018` seat creation).

Cross-checked against the Rank 3 constraint that matters most: Authentication `BR-2.12` denies Reception *"revenue
and financial data in all circumstances."* `SEAT-FR-284`/`286` confine exports to `StudentRecordId` + admission
number with **no monetary value**, and deny export to Reception, students and guardians entirely.

### 5.6 Non-disclosing denial is specified beyond the letter of the rule

`SEAT-FR-282` forbids disclosure through *"message text, status code, **response time**, or the presence or absence
of a field."* The response-time channel is a timing side-channel that `MP-GBR-22` does not name explicitly; closing
it is consistent with `MP-NFR-07`'s principle that *"uniformity outranks speed"* on security-relevant paths.

`SEAT-FR-283` preserves auditability: *"Non-disclosure applies to the caller, never to the audit trail."*

### 5.7 Result

> ### **Check 4 — PASS**

No authorisation is decided in this module. The framework, the roles and the closed scope register are consumed
from Rank 1 and Rank 3; the closed 24-row protected-operation list delegates every decision; authorisation is
ordered **before** domain evaluation; denial is non-disclosing including on the timing channel.

---

## 6. Check 5 — No credential, OTP or session outside `BC-18`

**Authority:** `ID-1`. **Failure mode:** prohibited. **Reviewed line-by-line.**

### 6.1 The rule

BC Map §4.1 L178:

> `| **ID-1** | No context outside BC-18 may store a password, OTP, session or credential. | Security review +
> schema scan in CI |`

Corroborated at Matrix L235, where `"*.mobileNumber"` is forbidden to `BC-10` with the comment
*"rule `ID-1` — the number is a credential, held by `BC-18`."* **A mobile number is a credential under this
architecture.**

### 6.2 Exhaustive scan

A case-insensitive scan of the whole PRD for `password | OTP | credential | session | token` returns **exactly four
lines**. Every one was read in context:

| Line | Text | Disposition |
|---|---|---|
| 227 | §3.4 `BC-18` row: *"…or store a credential"* | **Prohibition.** Names the forbidden thing in order to forbid it |
| 1342 | `SEAT-FR-187`: QR *"**MUST NOT** encode a student identifier, a name, a session token or a credential"* | **Prohibition** |
| 921 | `SEAT-FR-116`: occupancy recomputable from *"the current `BC-03` **open-session set**"* | **Not a credential.** An attendance check-in session owned by `BC-03`, consumed over `E-08`. Distinct from an **auth** session |
| 2440 | `SEAT-AC-111`: same `BC-03` open-session concept | **Not a credential** |

**Zero storage of any credential, password, OTP or authentication session.** No mobile number, no contact detail:
`SEAT-FR-010` forbids holding *"name, photograph, contact details, guardian data, fee balance or attendance
total"*, and `SEAT-FR-278` forbids storing, caching or indexing *"any student personal attribute."*

### 6.3 QR is not an authentication mechanism

The highest-risk surface in this module is QR, because a seat QR could easily have been made a bearer token.
`PRD-007` closes that deliberately:

- `SEAT-FR-187` — encodes **only** the seat's internal identifier and its `tenantId`.
- `SEAT-FR-188` — a scan *"**MUST** initiate an assignment request for the **authenticated scanning actor's**
  context and **MUST** evaluate §8 in full. It **MUST NOT** assign a seat on the strength of the scan alone."*
- `SEAT-BR-030` (L1347) — *"A QR scan **MUST NOT** authenticate anybody. Authentication is `BC-18`'s exclusively."*

This is `ID-1` honoured in the one place where violating it would be convenient. It is also consistent with
Attendance's separate `Dynamic QR` concern, which this module does not touch (§14).

### 6.4 Result

> ### **Check 5 — PASS**

Four mentions of credential vocabulary exist and **all four are prohibitions or a distinct `BC-03` attendance
concept**. Nothing is stored. QR is explicitly denied any authenticating power.

---

## 7. Check 6 — Tenant isolation

**Authority:** `MP-GBR-08`, `X-13`. **Failure mode:** *"Cross-tenant leak — `MP-RSK-01`, Critical."*
**Reviewed line-by-line.**

### 7.1 The rules

| Rule | Source | Line | Statement |
|---|---|---|---|
| `X-13` | Matrix | 362 | *"Cache/index/vector key without `tenantId` … **Cross-tenant data leak — highest-severity failure class in the system**"* |
| `MP-GBR-08` | Master PRD | 339 | *"Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* |
| `MP-GBR-09` | Master PRD | 340 | A cache-key or index-name change is *"a **security-reviewable** change"* |
| `ID-2` | BC Map | 179 | *"`StudentRecordId` **never** leaves its tenant."* |
| `BC-19` invariant | BC Map §8 | 378 | *"suspended tenant rejects all writes"* |

### 7.2 Every tenant-bearing surface verified

| Surface | Requirement | Verified |
|---|---|---|
| Every row | `SEAT-FR-287` — seat, floor ref, zone ref, layout version, category, `SeatAllocation`, `Reservation`, maintenance record, lock, occupancy fact, filter preset **and idempotency key** carry `tenantId` | **PASS.** The idempotency key is included — a key omitted here would be an `X-13` violation on a replay path |
| Every read and write | `SEAT-INV-009` — *"Every query and every mutation **MUST** be filtered by the resolved `tenantId`. A query that could…"* | **PASS**, verified by `SEAT-AC-202`: *"an unfiltered query cannot be expressed"* |
| Allocation coherence | `SEAT-INV-007` — allocation's `tenantId` **MUST** equal the seat's **and** the student's | **PASS** — closes the three-way mismatch |
| Cross-tenant identifiers | `SEAT-FR-291` — `StudentRecordId` **MUST NOT** appear in any *"cross-tenant surface, global index, global cache key"* | **PASS** — implements `ID-2` / `MP-GBR-03` verbatim in scope |
| Entitlement | `SEAT-FR-295` — via `E-17` `check(tenantId, feature, delta)` **before** mutation | **PASS** |
| Real-time channel | `SEAT-FR-193` — *"A real-time update **MUST** be tenant-scoped. A client **MUST NOT** receive an update for a seat…"* | **PASS** — the most `X-13`-exposed surface, since a broadcast channel is a cache key by another name |
| Idempotency keys | `SEAT-FR-202` — *"scoped per tenant and per operation"* | **PASS** |
| Events | `SEAT-FR-208` — every event carries `tenantId`; a consumer that processes one without establishing tenant context is a defect | **PASS**; `SEAT-AC-167` verifies payloads carry no name, contact or `PersonId` |
| Search | `SEAT-FR-254` — results confined to the caller's `tenantId` **and** further confined by scope | **PASS** — tenant **and** permission, as `MP-GBR-08` requires both |
| Presets / defaults | `SEAT-FR-259`, `SEAT-FR-293` — presets tenant-scoped; no default category, preset or layout shared across tenants as a mutable row | **PASS** — closes the shared-mutable-default leak |
| QR payload | `SEAT-FR-187` — encodes `tenantId` | **PASS** |

### 7.3 Fail-loudly, never default

`MP-GBR-06`/`07` require a consumer without resolved tenant context to fail loudly and never default.
`SEAT-FR-113` (L911): *"Where a check-in arrives whose event `tenantId` cannot be resolved, the handler **MUST
fail** …"*, verified by `SEAT-AC-109`: *"It fails loudly and processes nothing; it never defaults to a tenant."*
`SEAT-FR-289` restates the principle module-wide. L2053 cites `MASTER_PRD` §16 directly: *"tenant-scoped rows must
carry it or the isolation guarantee is…"*.

### 7.4 No index is created, so `MP-GBR-08`'s index clause is satisfied by abstention

`SEAT-XC-021` declines search-index production entirely (`E-21` does not list `BC-04`). There is therefore **no
`BC-04` index or vector namespace to partition** — the strongest possible compliance with `MP-GBR-08`'s
partitioning requirement, and it removes the `MP-GBR-09` security-review surface as well.

### 7.5 Result

> ### **Check 6 — PASS**

Every persisted row, query, mutation, event, real-time message, idempotency key, preset and QR payload is
tenant-scoped. Unresolvable tenant context fails loudly. `StudentRecordId` is barred from every cross-tenant
surface. No index exists to mis-partition.

---

## 8. Conflicts, gaps and dispositions

### 8.1 Conflicts found at Stage 3

**None.** Zero CONFLICT findings against Ranks 1–5 arose from checks 1–6.

### 8.2 Carried forward — `SEAT-GAP-001`, false positive

| Item | Disposition |
|---|---|
| `SEAT-GAP-001` — claimed `Floor` ownership conflict | **NOT a conflict.** Carried forward from [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](PRD-007_INDEPENDENT_GAP_VERIFICATION.md) §3, verdict **C — false positive** |

Basis, restated for this stage without re-deciding anything: `BC-06` owns `Floor` per Rank 3 `LIB-26.1` and
`Library_PRD_v1.md:1093`. BC Map L373's *"Key entities / VOs"* column is provably non-exhaustive — `Zone` appears
**0 times** in the entire BC Map, and BC Map §8's own `BC-06` row (L375) omits `Floor`, `Zone` **and** `Branch`.
The identical non-exhaustiveness was adjudicated at `MM-GAP-006`/`C-2` **without an ADR**. `SEAT-FR-015` reads
containers and never mutates them, which is correct under either reading.

**Stage 3 consequence: no architecture conflict, no ADR required, no blocker.** The residual documentation-accuracy
finding on the PRD's *explanatory prose* (`GV-1`) is out of scope here and is **not** fixed.

### 8.3 Open, non-blocking

| Gap | Question | Owner | Blocking Stage 3? |
|---|---|---|---|
| **`SEAT-GAP-003`** (`Q-01`) | Does an expired membership release the seat immediately, at end-of-day, or after a grace period? | **Architecture + `BC-04` owner** (`ADR-0019` §3.3) | **No** |
| `SEAT-GAP-006` | Would a floor- or zone-scoped permission grant be needed, given `MP-GBR-21`'s closed register? | Architecture | **No** — V1 uses only `tenantWide` and `self`; an ADR would be required to add a scope, and none is assumed |
| `SEAT-GAP-002`, `004`, `005`, `007`…`014` (11 further) | Absent external decisions — waiting-list semantics, cross-branch transfer, layout-version retention, and similar | Named per gap in PRD §31 | **No** — `ADR-0018` §10: *"none blocks implementation start"* |

`SEAT-GAP-003` is **neither resolved nor invented here**, as instructed. `Q-01` is Open at Rank 1
(`MASTER_PRD.md:673`) and at Rank 4 (BC Map L540); both carry a *recommendation*, not a decision.
`SEAT-FR-155` flags and queues without auto-releasing, meeting `ADR-0019` §3.3's standard that V1 behaviour be
*"correct under either resolution."* `Q-01` is a **schema-freeze** dependency (`MP-DEP-07`), a later and distinct
gate from Stage 3 or Stage 7. `PRD-005` was frozen carrying the identical `MM-GAP-001`.

---

## 9. Rejected findings — recorded as rejected, with reasons

`PRD_LIFECYCLE.md` Stage 3: *"A rejected finding must be recorded as rejected, with its reason … A review that
records only accepted findings is indistinguishable from a review that found nothing."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `AR-R1` | *"Same-rank `E-02`/`E-05`/`E-08`/`E-01` dependencies violate `L2` downward-only."* | Matrix L89 declares the **Core Library cluster** as one of exactly two bounded `L2` exceptions, with an explicit allow-list of `E-01`…`E-10`. All four edges are inside it. `L2` is satisfied *by* the declared exception, not *despite* it |
| `AR-R2` | *"`Floor` in BC Map §8's `BC-04` row is a Rank 3/Rank 4 conflict requiring an ADR."* | Disproven in the independent verification: the column is non-exhaustive (`Zone` = 0 hits; §8's `BC-06` row omits `Floor`/`Zone`/`Branch`), Rank 3 `LIB-26.1` already assigns ownership, and `MM-GAP-006`/`C-2` set the no-ADR precedent. Raising it again would re-litigate a settled question |
| `AR-R3` | *"`SEAT-GAP-003` should be closed at Stage 3 by adopting BC Map L540's recommended 24h grace default."* | A recommendation in an open-question register is not a decision. Adopting it would silently amend a Rank 1 register — the failure `PRD_LIFECYCLE.md` L177 prohibits and that `ADR-0019` §3.3 refused for this same question |
| `AR-R4` | *"The module's `BC-03` 'open-session set' breaches `ID-1`."* | An attendance check-in session is not an authentication session, password, OTP or credential. It is `BC-03`'s state consumed over the declared `E-08` edge. `ID-1` is scoped to *"a password, OTP, session or credential"* in the `BC-18` sense — Matrix L235 confirms the intent by naming the mobile number as the credential class |
| `AR-R5` | *"`SEAT-XC-021` should be dropped and `BC-04` made an `E-21` search producer, since the module has a search feature."* | `E-21` L331 names `BC-01`/`BC-10` as producers. Adding `BC-04` requires an ADR under BC Map L292. Declining the edge is the compliant choice, and it matches `MM-BR-035`/`SM-GAP-11` |
| `AR-R6` | *"The EA listing `Floor Management (V1)` under Seat Management conflicts with `BC-06` ownership."* | The EA is **Rank 6, descriptive only** (baseline L139, L206: *"never lead them"*), and is outside Stage 3's stated Rank 1–5 scope. A descriptive document trailing normative ones is not a conflict. Correction belongs to the EA owner |
| `AR-R7` | *"`PRD-007` should be given a `PRD_REGISTRY.md` row and a baseline entry as part of passing Stage 3."* | Registry status and baseline rows are conferred at **Stage 7** by an admission ADR (`PRD_LIFECYCLE.md` L159–161: freeze is *"conferred, not claimed"*). Doing it here would perform Stage 7 work inside Stage 3 |

---

## 10. Containment audit

| Check | Result |
|---|---|
| `PRD-SEAT-MANAGEMENT.md` modified | **No** — SHA-256 `623b8945…be386a` identical before and after |
| PRD status / version changed | **No** — remains **v1.0 `DRAFT`** |
| PRD frozen | **No** |
| Any other PRD modified | **No** |
| BC Map · Master PRD · Rulings · Dependency Matrix · EA modified | **No** |
| Library PRD · Authentication PRD · Student Management PRD · Membership PRD modified | **No** |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` modified | **No** |
| ADR created or modified | **No** |
| Specification · API spec · DB schema · SQL · code · implementation tasks | **None created** |
| `TRACEABILITY_MATRIX.md` touched (Stage 5) | **No** |
| Integration edge invented | **No** |
| Existing gap resolved by this record | **No** — `SEAT-GAP-003` and 12 others remain open with named owners |
| Files added | **1** — this document |

This record is a **historical validation record and is not part of the specification**, following
`DOCUMENTATION_BASELINE.md` §3.3's treatment of `LIBRARY_PRD_ALIGNMENT.md` (L153),
`STUDENT_IDENTITY_ALIGNMENT.md` (L157) and `PRD-004_ALIGNMENT_REPORT.md` (L160). It confers no status.

---

## 11. Verdict

> ## ✅ **ALIGNED — Stage 3 PASS**

| # | Check | Authority | Result |
|---|---|---|---|
| 1 | Context ownership is exclusive | BC Map §3 | ✅ **PASS** |
| 2 | Every integration edge exists in §7 | BC Map §7 | ✅ **PASS** — 13/13 declared, 0 invented |
| 3 | Rank direction is downward | Matrix `L2` | ✅ **PASS** |
| 4 | No authorisation decided outside `BC-18` | `X-13` | ✅ **PASS** |
| 5 | No credential, OTP or session outside `BC-18` | `ID-1` | ✅ **PASS** |
| 6 | Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** |

**0 conflicts.** **1 prior claimed conflict confirmed a false positive** (`SEAT-GAP-001`). **13 open gaps, none
blocking**, each with a named owner. **7 candidate findings rejected**, each with its reason recorded.

The three security checks were the most rigorous part of this review, and the module is stronger than the rules
require in three specific places: authorisation is ordered **before** the domain gate so failure shape leaks
nothing; denial closes the **response-time** side channel that `MP-GBR-22` does not name; and the module
**declines** the `BC-23` search edge it is not a registered producer for, leaving no index to mis-partition.

**Next stage:** Stage 4 — Requirements Review. **Not started.**

**Per the mandate, no PRD was modified, no ADR was created, no ranked or governance document was touched, no gap
was resolved, and Specification, Implementation and Freeze were not started. Stage 3 is complete and stops here.**
