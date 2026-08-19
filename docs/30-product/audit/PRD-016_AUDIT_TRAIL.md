# PRD-016 — Audit Trail

| Field | Value |
|---|---|
| **PRD** | `PRD-016` |
| **Module** | Audit Trail |
| **Version** | **v0.1** |
| **Status** | **`FROZEN`** — admitted to the documentation baseline at **Rank 3** on 2026-08-19 by [`ADR-0051`](../../00-governance/adr/ADR-0051-audit-trail-prd-v0.1-baseline.md), whose gate artefact is the row in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) **§3.3**. ⚠ **`FROZEN`, not `VERIFIED`** — 0 of 30 tasks and **0 of 18** acceptance criteria are proven by a test. **This document still confers no status on itself**; the baseline §3.3 row does, and this field only records what was conferred elsewhere. *Superseded value retained verbatim:* **`DRAFT`** — `PRD_LIFECYCLE.md` Stage 2. **This document confers no status on itself** |
| **Owning bounded context** | **`BC-24` Audit Trail** `[GENERIC]` — owning platform **Audit** |
| **Product version** | **V1** |
| **Owned aggregate** | **`AuditEntry` — and only `AuditEntry`** |
| **Module path** | `platform/audit` (rank **5**) |
| **Requirement prefix** | `AUD-` |
| **Lifecycle stage** | **Stage 7 of 9 — Freeze, PASSED.** See §12. Stages 8 and 9 **not started** |
| **Baseline** | **`BASELINE-2026-08-19-B`**, the identifier issued by this freeze. *Superseded value retained verbatim: written against **`BASELINE-2026-08-19-A`***. The identifier moved because a Rank 3 document changed version-status, per baseline §7 step 4 |
| **Rank** | **Rank 3, conferred** by [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) **§3.3** and §4 (which now records **ten** module baselines), **not claimed here** |
| **Registry status** | **`FROZEN`** in [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.2 L306, the **second** PRD ever to leave `PLANNED` directly for `FROZEN`. *Superseded value retained verbatim:* **`PLANNED`** … until conferred otherwise |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ADR-0012`, `ADR-0014`, `ADR-0020`, `ADR-0049`, `ADR-0050`, **`ADR-0051`** (Rank 2) · **Authentication PRD v2.0 `FROZEN`**, **Library PRD v1.1 `FROZEN`**, `PRD-006`, `PRD-013` v0.1 `FROZEN` (Rank 3) · Bounded Context Map v1.5, Module Dependency Matrix v1.3 (Rank 4) · Architecture Rulings (Rank 5) |
| **Date** | 2026-08-19 |
| **Reviewed at** | `66fc263327aed5233f1449e2e8e800a24a39b68e` |
| **Reviewed content hash** | `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` — the sha256 of this **whole file as it stood immediately before the freeze**, and the hash cited by every one of the five gate records (Stages 1, 3, 4, 5, 6). That uniformity is why **no alignment supplement was required and none was written**, unlike `ADR-0049` and `ADR-0050`. ⚠ **It is no longer this file's hash and is not presented as one**: the freeze edited the header, §12 and §14, so the whole-file hash has moved. **This document deliberately does not state its own current hash**, because a file cannot contain its own digest — every attempt to write one invalidates it, and a first draft of this field did exactly that, asserting a value that its own next edit falsified. The current whole-file hash is recorded **outside** this document, in [`PRD-016_STAGE7_FREEZE.md`](./PRD-016_STAGE7_FREEZE.md) §12, which is where an integrity witness can live without being self-defeating. **The invariant that survives the freeze is the specification itself**: the span **§0 *How to read* through §11 inclusive** — every requirement, rule, invariant, exclusion, criterion, gap and register — hashes to **`a4fee4df54ff8f17282d636b78ce97693245f8bd50a5c7adee8d5d114eb9d6cb`** both before and after, verified by extracting the span by section anchor in each version rather than by fixed line numbers, which the header's growth would have shifted |

> **Freeze is conferred, not claimed.** Per `PRD_LIFECYCLE.md` L41–42: *"A gate is not an opinion — if the artefact
> does not exist, the stage has not been passed, however complete the work feels."*

---

## 0. How to read this document

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default requiring a recorded
reason to depart from. **MAY** is genuinely optional.

### 0.2 Identifier registers — the ranges as a promise

Per the Stage 2 gate: identifier registers declared **up front** with ranges, *"publishing the ranges as a
promise."* Ranges are **contiguous**; a hole makes the published range false.

**Class A — normative requirements and exclusions.**

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `AUD-FR-001` … `AUD-FR-016` | contiguous | **16** | §1–§6 | Functional requirements |
| `AUD-BR-001` … `AUD-BR-003` | contiguous | **3** | §4 | Business rules |
| `AUD-INV-001` … `AUD-INV-004` | contiguous | **4** | §5 | Domain invariants — always true |
| `AUD-EVT-*` | **DECLARED EMPTY** | **0** | §6 | Domain events — see §0.3 |
| `AUD-XC-001` … `AUD-XC-012` | contiguous | **12** | §7 | Exclusions — what **MUST be impossible** |

**Class B — verification.**

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `AUD-AC-001` … `AUD-AC-018` | contiguous | **18** | §8 | Acceptance criteria |

**Class C — open items owned elsewhere.**

| Register | Range | Count | Section | Meaning |
|---|---|---:|---|---|
| `AUD-GAP-001` … `AUD-GAP-005` | contiguous | **5** | §10 | Gaps — absent decisions owned elsewhere |

**Totals.** Class A = **35** (16 + 3 + 4 + 0 + 12). Obligation-bearing = **35**. Class B = **18**.
Class C = **5**. **Grand total 58 identifiers.** No identifier is retired; none has ever been issued before.

### 0.3 Two registers are declared EMPTY, and why that is a finding rather than an omission

**`AUD-EVT-*` — declared empty.** `BC-24` publishes **no** domain event. Verified mechanically: scanning Bounded
Context Map §9's event table (L400–440) for rows whose *producer* is `BC-24` returns **0**; the producer set is
`BC-01`…`BC-06`, `BC-10`…`BC-13`, `BC-18`, `BC-19`, `BC-20`, `BC-27`. `BC-24` appears **25 times, always as a
consumer** — the widest event fan-in in the map. Publishing an event would require an ADR (BC Map §7: *"If an edge
is not in this table, it does not exist"*). **The register is published as empty rather than omitted**, so that a
future author sees the decision rather than a hole.

**`AUD-CFG-*` — declared empty and not published.** Rank 7 [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md)
defines **no** audit, retention or legal-hold parameter: `CFG-1`…`CFG-12` are SMS, session, device, lock and
account values; `CFG-9`/`CFG-10` are *account* retention, not audit. Stage 4 requires *"every configurable has a
default and a range"* — an unbounded configurable is *"a specification hole."* Since no authority supplies a
default or a bound, **no `AUD-CFG-*` identifier is issued at all.** This follows the `TEN-CFG-001` precedent, with
one deliberate difference: `PRD-013` issued then retired `TEN-CFG-001`; this document **never issues one**, because
a retired identifier is permanently unusable and there is no reason to burn a number. Retention is recorded as
**`AUD-GAP-001`**.

### 0.4 ⚠ Citation discipline — `AU-n` names TWO different registers

Established in [Stage 1 §6.2](./PRD-016_STAGE1_DISCOVERY.md). Both predate this document.

| Register | Location | `AU-4` means |
|---|---|---|
| **Audit principles `AU-1`…`AU-9`** | `Authentication_PRD_v2.md` §10.4 — **Rank 3, FROZEN** | *"Independence — audit is beyond the control of the roles whose actions it records"* |
| **Module assertions `AU-1`…`AU-4`** | `tool/module_dependencies.yaml` → `platform/audit` | *"erasure makes a record non-identifying by key destruction; no record is ever removed"* |

**This document never cites a bare `AU-n`.** Every citation is qualified as either **`AU-n` (Auth §10.4)** or
**manifest `AU-n`**. This is the discipline the traceability matrix applied to the `PO-n`/`SPO-n` near-collision,
where citing the wrong one *"would move a requirement from one bounded context to another."*

### 0.5 What this document deliberately does not restate

The audit **principles** are already specified, in a **frozen** Rank 3 document. Restating them would fail Stage 4's
*"No requirement restates another PRD's — two sources of truth."* This document **cites** them and specifies the
**store** that satisfies them.

| Already owned | Where | This document's relationship |
|---|---|---|
| `AU-1`…`AU-9` audit principles | Auth PRD §10.4 (**FROZEN**) | **Cited as binding.** Not restated |
| `AUTH-10.19`…`10.27` | Auth PRD §10.4 (**FROZEN**) | **Cited.** `AUTH-10.26` vacates storage/retention/query to this PRD |
| The event envelope | BC Map §9.1 L449–450 (Rank 4) | **Cited** by `AUD-FR-005` |
| Tenant context and `tenant_id` | `PRD-013` `TEN-FR-008`/`010`/`011`/`018` (**FROZEN**) | **Consumed.** Not redefined |
| `ATT-FR-129`…`133`, `ATT-FR-038` | `PRD-006` | Emitter-side duties. **Not restated** |
| `MP-GBR-13`, `MP-GBR-31`, `MP-GBR-04` | Master PRD (Rank 1) | **Cited.** Rank 1 wins |
| `X-10`, `X-13` | Dependency Matrix §10 (Rank 4) | **Cited.** Enforced by tooling, not by this text |

---

## 1. Purpose and scope

**`AUD-FR-001`** — The module **SHALL** own the `AuditEntry` aggregate as declared in Bounded Context Map §8
**L384**, and no other aggregate.

**`AUD-FR-002`** — The module **SHALL** own **audit storage, retention execution and audit query**. This ownership
is not asserted here but **vacated to it** by a frozen Rank 3 document: `AUTH-10.26` — *"Authentication MUST NOT own
audit storage, retention or query; it MUST only produce the records."*

**`AUD-FR-003`** — The module **SHALL NOT** decide *what* is auditable in another bounded context. Each emitting
context defines its own auditable-action list — `AUTH-10.19` and the §10.4 auditable-actions table for `BC-18`,
`ATT-FR-131` for `BC-03`. This module records what it is given.

> **Why `AUD-FR-003` matters.** `BC-24` has the widest event fan-in in the map (25 rows). A module that also decided
> what those 25 producers must audit would hold a veto over every other context's compliance obligation. The
> division is the same one Authentication draws for notifications: the producer decides **that** a fact is
> auditable; this module decides **how** it is stored, retained and queried.

---

## 2. The aggregate

**`AUD-FR-004`** — `AuditEntry` **SHALL** be the module's only aggregate root, carrying `Actor`, `Action`, `Target`
and `TenantContext` as value objects, exactly as Bounded Context Map §8 L384 declares. The module **SHALL NOT**
introduce a fifth value object into the aggregate without an ADR amending L384.

> **The field set is discovered, not designed.** L384 names four value objects. This document adds none. Where a
> further field is needed to satisfy a cited principle — a server timestamp for `AU-9` (Auth §10.4), an `eventId` for
> idempotency — it arrives through the **envelope** (`AUD-FR-005`), which is already canonical at Rank 4, rather
> than through an invented aggregate field.

---

## 3. Recording

**`AUD-FR-005`** — Every recorded entry **MUST** carry the full event envelope of Bounded Context Map §9.1
**L449–450** — `eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`,
`causationId`, `aggregateId`, `payload` — with a non-null `tenantId`.

**`AUD-FR-006`** — Recording **MUST** be idempotent, keyed on `eventId`. BC Map §9.1: delivery is at-least-once,
therefore *"every consumer must be idempotent — keyed on `eventId`, with a processed-events table or equivalent."*
A redelivered fact **MUST NOT** produce a second entry.

**`AUD-FR-007`** — The recorded time **MUST** be server time. Client-supplied time **MUST NOT** be recorded as
authoritative — `AU-9` (Auth §10.4). Where a client-asserted moment is retained it **MUST** be a distinct,
non-authoritative field within `payload`.

**`AUD-FR-008`** — The audit fact **MUST** commit in the same database transaction as the state change it describes,
via the **Transactional Outbox** — BC Map §9.1 *"Atomicity with state"*; manifest assertion `ID-6`. It **MUST NOT**
be published from application code after commit.

**`AUD-FR-009`** — Unavailability of this module **MUST NOT** fail or delay the emitting operation. Manifest
assertion `AU-3`: *"unavailability of this platform delays audit visibility only; recording occurs in the emitter's
transaction."* This is the module-side reading of `E-20`'s *"fire-and-forget"* and *"Domain never calls audit
synchronously."*

> ⚠ **`AUD-FR-009` and `AUTH-10.27` are in tension, and this document does not resolve it.** `AUTH-10.27` requires
> that *"inability to record an audit fact MUST be treated as a failure of the action for security-critical
> operations."* Both statements can hold simultaneously only because `AUD-FR-008` puts the write in the **emitter's**
> transaction: what fails is the emitter's local outbox write, not a call into this module. Whether that
> satisfies `AUTH-10.27`'s intent for every security-critical operation is **not this module's decision to make** —
> it is recorded as **`AUD-GAP-002`** and routed to `BC-18` and the ARB. It does not block, because this module's
> obligation is identical either way.

---

## 4. Business rules

**`AUD-BR-001`** — A correction **MUST** be a new entry. Dependency Matrix `X-10` states the remedy for a bad entry
verbatim: *"Append a correcting entry."* No entry is edited to correct another.

**`AUD-BR-002`** — Immutability **MUST** hold for **every** role, including Platform Administrator — `AUTH-10.20`.
There is no privileged role, support path or administrative override that can alter or remove an entry. `AU-4`
(Auth §10.4): *"Audit is beyond the control of the roles whose actions it records."*

**`AUD-BR-003`** — Erasure **MUST** be performed by making an entry non-identifying, **never** by removing it.
Manifest assertion `AU-4`: *"erasure makes a record non-identifying by key destruction; no record is ever removed."*
Consistent with `AU-8` (Auth §10.4) *"Audit outlives the account it concerns, in a form that no longer identifies
the person"*, `AUTH-10.25`, `MP-GBR-04` and BC Map `ID-5`.

> **`AUD-BR-003` is the resolution of this PRD's hardest question, and it was found rather than invented.**
> Append-only and a right to erasure appear to contradict. The repository had already answered: destroy the key,
> retain the record. No retention period, jurisdiction or legal rule needed to be supplied to state this rule.

---

## 5. Invariants — always true

**`AUD-INV-001`** — An `AuditEntry`, once written, **MUST** be immutable in its entirety. No update, delete, purge
or modify path exists in code — Bounded Context Map L384; `MP-GBR-13`; `X-10`; manifest `banned_method_names:
["update*","delete*","purge*","modify*"]` and assertion `AU-1` (*"no public mutation method exists on the audit
store"*).

**`AUD-INV-002`** — Every `AuditEntry` **MUST** carry a non-null `tenantId`. BC Map §9.1 *Tenant safety*:
*"`tenantId` is mandatory on every domain event. A consumer that processes an event without establishing tenant
context must **fail loudly, not default**."* `X-13` rates a tenant-key violation a **blocker** — *"the
highest-severity failure class in the system."*

**`AUD-INV-003`** — Every `AuditEntry` **MUST** carry an actor of record. BC Map L384: *"entry carries the tenant and
actor of record."* `AU-3` (Auth §10.4) — Attribution.

**`AUD-INV-004`** — An `AuditEntry` **MUST NOT** contain a credential, OTP value, session token, device trust
marker, key material or unmasked personal data. `AUTH-10.22`; `AU-6` (Auth §10.4); manifest assertion `ID-5`;
`ATT-FR-133`.

---

## 6. Events and integration

**`AUD-FR-010`** — The module **MUST** consume audit facts via **`E-20`** — Bounded Context Map §7.3 L329, *"All
contexts → BC-24 Audit Trail, `PL`, Event (fire-and-forget, outbox-backed)."* This is the module's only inbound
integration edge.

**`AUD-FR-011`** — The module **MUST** be the sole consumer of every **Class A** authentication fact. Manifest
emission class A: `consumers: [platform/audit]`, *"A-5 — sole consumer, no exceptions"*, constraint *"any consumer
other than `platform/audit` is a boundary violation, not a subscription"*; assertions `AU-2` (manifest) and `ID-3`.

**`AUD-FR-012`** — The module **MUST NOT** publish any domain event. **`AUD-EVT-*` is declared empty** (§0.3): the
Bounded Context Map §9 event table lists `BC-24` as a producer **zero** times. Publishing one requires an ADR
amending §9 — BC Map §7: *"If an edge is not in this table, it does not exist."*

**`AUD-FR-013`** — The module **MUST NOT** import from `domain/**` or `app/**`. Manifest `banned_imports`;
Dependency Matrix §7.4 — Capability → Domain is the forbidden direction.

---

## 7. Query and access

**`AUD-FR-014`** — Every audit query **MUST** be confined to one tenant. `AU-7` (Auth §10.4): *"A library sees only
audit concerning its own context."* `AUTH-10.23`: *"A library MUST be able to view audit only for actions within its
own context."*

**`AUD-FR-015`** — A query issued without a resolved tenant context **MUST** fail. It **MUST NOT** return an empty
result, and **MUST NOT** default to a tenant. This consumes `PRD-013` `TEN-FR-011` (**FROZEN**) — *"Reading tenant
context when it is unset MUST throw"* — rather than redefining it.

**`AUD-FR-016`** — The module **MUST NOT** expose any read surface that spans tenants, including a count, a
"recent entries" listing, an aggregate total or a diagnostic view.

> ⚠ **`AUD-FR-016` contradicts existing code, deliberately.** `lib/platform/audit/audit.dart` L60–61 exposes
> `recent([int n = 25])` with no tenant filter (`grep -c tenantId` inside the method body → **0**) and L63 exposes
> `count` returning a global total; both are consumed by `lib/app/dashboards/ops_page.dart:270,272,282`. This is
> recorded as code defect **`D-016-01`** (§11) and is **not repaired here** — Stage 8 is not started. A
> specification is permitted to contradict code; that is what it is for.

---

## 8. Exclusions — what MUST be impossible

An exclusion is **not** a deferral. Each states what must be impossible and names the owner of the excluded subject.

| ID | Exclusion | Owner | Authority |
|---|---|---|---|
| `AUD-XC-001` | The module **MUST NOT** expose any public method that updates, deletes, purges or modifies a stored entry | — | `X-10`; manifest `banned_method_names`, `AU-1` (manifest) |
| `AUD-XC-002` | **No role, including Platform Administrator, MUST be able to alter or remove an entry.** No support path, break-glass route or administrative override exists | — | `AUTH-10.20`; `AU-4` (Auth §10.4) |
| `AUD-XC-003` | **Cross-tenant reach MUST be impossible.** No query, projection, cache, index or diagnostic surface may return, reference, count or infer an entry belonging to a tenant other than the resolved one | — | `AU-7` (Auth §10.4); `AUTH-10.23`; `MP-GBR-08`/`09`; `X-13` (**blocker**) |
| `AUD-XC-004` | The module **MUST NOT** store a credential, password, OTP, session, device trust marker or key material | **`BC-18`** | BC Map `ID-1` L178; `AUTH-10.22`; `AU-6` (Auth §10.4); manifest `ID-5` |
| `AUD-XC-005` | The module **MUST NOT** make, store, cache or evaluate an authorisation decision. Confining a query to a tenant is not deciding access | **`BC-18`** | `X-13`; BC Map §7.4; `PRD-013` `TEN-XC-003`/`010` precedent |
| `AUD-XC-006` | The module **MUST NOT** define, store or claim the `Tenant` aggregate, tenant context propagation, `TenantTier`, `Quota`, `ResidencyRegion` or `TenantLifecycleState` | **`BC-19`** / `PRD-013` | `TEN-FR-001`…`005` (**FROZEN**) |
| `AUD-XC-007` | The module **MUST NOT** define, store or compute `EntitlementSet`, `FeatureGate`, `UsageCounter` or `Limit` | **`BC-21`** | BC Map L383 |
| `AUD-XC-008` | The module **MUST NOT** define, store or compute subscription or billing state | **`BC-20`** | BC Map L382 |
| `AUD-XC-009` | The module **MUST NOT** own an analytics projection, certified metric or read model, and **MUST NOT** become a system of record for any domain fact it records | **`BC-26`** | BC Map L385; `E-20` is one-way |
| `AUD-XC-010` | The module **MUST NOT** publish a domain event, emit a notification, or request delivery through any channel | **`BC-22`**, — | `AUD-FR-012`; BC Map `E-23`; BC Map §9 (`BC-24` produces nothing) |
| `AUD-XC-011` | The module **MUST NOT** decide, override or extend another context's auditable-action list | each emitting context | `AUTH-10.19`; `ATT-FR-131`; `AUD-FR-003` |
| `AUD-XC-012` | The module **MUST NOT** remove a record in order to satisfy an erasure request, and **MUST NOT** implement erasure as deletion | — | manifest `AU-4`; `AU-8` (Auth §10.4); `AUTH-10.25`; `MP-GBR-04`; `ID-5` |

---

## 9. Acceptance criteria

Each maps to a requirement, invariant or exclusion in this document. No criterion is orphaned.

| ID | Criterion | Traces to |
|---|---|---|
| `AUD-AC-001` | `platform/audit` exposes no public method whose name matches `update*`, `delete*`, `purge*` or `modify*`; adding one fails the boundary checker | `AUD-INV-001`, `AUD-XC-001` |
| `AUD-AC-002` | An attempt to mutate a stored `AuditEntry` fails — statically or at runtime — and the stored entry is byte-identical after the attempt | `AUD-INV-001` |
| `AUD-AC-003` | An attempt to alter or remove an entry while acting as Platform Administrator fails, with no privileged path succeeding | `AUD-BR-002`, `AUD-XC-002` |
| `AUD-AC-004` | Correcting a wrong entry produces a **second** entry; the original remains present and unchanged | `AUD-BR-001` |
| `AUD-AC-005` | Every persisted entry carries a non-null `tenantId`; an attempt to write one without it fails loudly rather than defaulting | `AUD-INV-002` |
| `AUD-AC-006` | Every persisted entry carries an actor of record; an attempt to write one without it fails | `AUD-INV-003` |
| `AUD-AC-007` | A query issued under tenant A returns no entry, count, reference or derived total belonging to tenant B; attempting one is an error, **not an empty result** | `AUD-FR-014`, `AUD-XC-003` |
| `AUD-AC-008` | A query issued with no resolved tenant context throws; it returns neither an empty list nor a default tenant's data | `AUD-FR-015` |
| `AUD-AC-009` | No method on the module returns a value derived from more than one tenant's entries — including counts, totals and "recent" listings | `AUD-FR-016`, `AUD-XC-003` |
| `AUD-AC-010` | Delivering the same audit fact twice, with the same `eventId`, produces exactly one entry | `AUD-FR-006` |
| `AUD-AC-011` | Every entry carries all ten envelope fields of BC Map §9.1 L449–450 | `AUD-FR-005` |
| `AUD-AC-012` | The recorded authoritative time is server-supplied; a client-supplied timestamp does not appear as the authoritative moment | `AUD-FR-007` |
| `AUD-AC-013` | The audit fact and the state change it describes commit or roll back together; no fact is published from application code after commit | `AUD-FR-008` |
| `AUD-AC-014` | With the audit module unavailable, the emitting operation still completes and its outbox row is written; only audit **visibility** is delayed | `AUD-FR-009` |
| `AUD-AC-015` | No entry, payload or log line contains a credential, OTP, session token, device trust marker, key or unmasked personal datum | `AUD-INV-004`, `AUD-XC-004` |
| `AUD-AC-016` | The set of domain event types published by `platform/audit` is **empty**. Publishing any type fails | `AUD-FR-012`, `AUD-XC-010` |
| `AUD-AC-017` | `platform/audit` contains no import from `domain/**` or `app/**`, and no authorisation decision, `Tenant`, entitlement or subscription type is defined within it | `AUD-FR-013`, `AUD-XC-005`…`008` |
| `AUD-AC-018` | After an erasure request, the entry is still present and its identifying key is destroyed; the record is non-identifying and **no row was removed** | `AUD-BR-003`, `AUD-XC-012` |

**Reverse coverage.** Of the **35** Class A identifiers, those carrying no criterion are `AUD-FR-001`, `AUD-FR-002`,
`AUD-FR-003`, `AUD-FR-004`, `AUD-FR-010`, `AUD-FR-011`, `AUD-XC-009` and `AUD-XC-011`. Each is a **scope or
ownership statement** whose violation is observable as the *presence of a type or a subscription* rather than as a
runtime behaviour — the same treatment `PRD-013` gave `TEN-FR-001`…`009`. They are covered structurally by
`AUD-AC-017` and are recorded here rather than given a synthetic criterion.

---

## 10. Open gaps — decisions owned elsewhere

None is invented, and none is closed here.

| ID | Gap | Owner | Why it is not decided here |
|---|---|---|---|
| `AUD-GAP-001` | **No retention period is defined for audit anywhere at Rank 1–5.** `MP-GBR-13` says *"legal hold blocks purge"* without defining hold or period; `MP-NFR-10` assigns *"retention enforcement… legal hold"* to **SECURITY + DATA Governance**; `Q-04` is *"Open — needs counsel"*; `CONFIGURATION_GUIDE.md` (Rank 7) defines no audit parameter. EA lists `Legal Hold (Future)` — EA is **Rank 6, descriptive only** | **SECURITY + DATA Governance**, with counsel | Inventing a period or a jurisdiction is forbidden by the authoring instruction and by `MP-NFR-10`'s ownership. `AUD-CFG-*` is therefore **not issued** (§0.3) |
| `AUD-GAP-002` | **`AUTH-10.27` vs `E-20`/manifest `AU-3`.** One requires inability-to-record to fail the security-critical action; the other two make audit fire-and-forget and non-blocking | **`BC-18`** + **ARB** | Reconciling a frozen Rank 3 requirement with a Rank 4 edge is an ARB act. `AUD-FR-008`/`AUD-FR-009` are written so this module's obligation is the same under either reading |
| `AUD-GAP-003` | **"Legal hold" has no defined mechanism.** `MP-GBR-13` and BC Map L384 both say it *"blocks purge"*, but no document defines who applies a hold, to what scope, or how it is released | **SECURITY + DATA Governance** | With `AUD-BR-003` (never remove), *purge* has no path in V1, so no hold mechanism is required to satisfy the invariant. Recorded because the phrase is in a **Rank 1** rule |
| `AUD-GAP-004` | **Support access recording.** BC Map L133 says `BC-24` owns the record *"including AI actions and support access"*, but no Rank 1–5 document defines a support-access action list. EA lists `Support Access Log (V3)` — Rank 6, descriptive | **Product Owner** + `BC-18` | `AUD-FR-003` places the auditable-action list with the emitter. No emitter has published a support-access list, so there is nothing for this module to record yet |
| `AUD-GAP-005` | **The Class A fact register is not in the repository.** Manifest `event_register_source: docs/prd/authentication` — that path does not exist; `EVT-1001`…`EVT-1036` member names are recorded as never available | **`BC-18`** | This document cites the enforceable **class contract** (`A-5`, `ID-3`, manifest `AU-2`) rather than individual `EVT-*` numbers it cannot verify |

---

## 11. Contradictions with existing code — recorded, not repaired

Stage 8 is not started. These follow the `D-013-01`/`D-013-02` precedent: measured, named, and left to
implementation.

| ID | Contradiction | Mechanical evidence | Requirement it violates |
|---|---|---|---|
| **`D-016-01`** | `AuditTrail.recent([int n = 25])` and `count` expose **cross-tenant** read surfaces | `lib/platform/audit/audit.dart` L60–63; `grep -c "tenantId"` within `recent()` → **0**; callers at `lib/app/dashboards/ops_page.dart:270,272,282` | `AUD-FR-016`, `AUD-XC-003`, `AU-7` (Auth §10.4), `AUTH-10.23` |
| **`D-016-02`** | `AuditEntry` carries no `eventId`, `correlationId`, `causationId` or `schemaVersion`, so envelope and idempotency cannot hold; `at` defaults to `DateTime.fromMillisecondsSinceEpoch(0)` when omitted, recording epoch zero rather than server time | `lib/platform/audit/audit.dart` L9–27, L51 | `AUD-FR-005`, `AUD-FR-006`, `AUD-FR-007` |
| **`D-016-03`** | The store is an in-memory `List<AuditEntry>` with no outbox and no transaction participation | `lib/platform/audit/audit.dart` L33, L44 | `AUD-FR-008` |

`lib/platform/audit/audit.dart` is unchanged since commit `a44ebb0` (*"feat(scaffold)"*). **No code was modified by
this document.**

> **What the existing code gets right.** Its header states *"Append-only by construction: this class exposes no
> update, delete or purge method (forbidden edge `X-10`)"*, and it does not. `append` is annotated *"The ONLY
> mutation method. Intentional."* `AUD-INV-001` and `AUD-XC-001` are already satisfied by the scaffold — which is
> why `X-10` passes today.

---

## 12. Lifecycle position

| Stage | Gate | Status |
|---|---|---|
| 1 — Discovery | A context in the BC Map, not already owned in registry §6 | ✅ **PASS** — [`PRD-016_STAGE1_DISCOVERY.md`](./PRD-016_STAGE1_DISCOVERY.md) |
| 2 — Draft | A document with a version/status header and identifier registers declared up front with ranges | ✅ **This document** |
| 3 — Architecture Review | A written alignment record naming every conflict and its disposition | ✅ **ALIGNED 6/6** — [`PRD-016_ARCHITECTURE_ALIGNMENT.md`](./PRD-016_ARCHITECTURE_ALIGNMENT.md), 9 findings **rejected with reasons recorded rather than deleted**, 3 deferred as `S3-A-01`…`03`. *Superseded value: ⏳ Next* |
| 4 — Requirements Review | Conflicts closed or explicitly deferred with a reason and an owner | ✅ **PASS 6/6** — [`PRD-016_STAGE4_REQUIREMENTS_REVIEW.md`](./PRD-016_STAGE4_REQUIREMENTS_REVIEW.md), 4 findings rejected with reasons, 1 deferred as `S4-D-01` with a named owner. *Superseded value: ⏳* |
| 5 — Traceability | Prefixes registered in `TRACEABILITY_MATRIX.md` §2, verified mechanically, zero collisions | ✅ **CONFERRED** — §2J of [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **v1.14**, verified by **two independent committed checkers** (`prd016_traceability.py`, `prd016_stage5.py`), **0 collisions in both directions**, 0 orphans, 0 dangling; record at [`PRD-016_STAGE5_CONFERRAL.md`](./PRD-016_STAGE5_CONFERRAL.md). *Superseded value: ⏳* |
| 6 — Implementation Tasks | An `IMPL-*` range allocated; every task traces to requirements | ✅ **A — PASS** — `IMPL-900`…`929` (30 tasks, 47 edges, chain depth 7), **35 of 35 obligations = 100.0%** claimed by a task, verified by `prd016_task_coverage.py`; 11 of 11 mutations caught. Range allocated **by measurement of 451 numbers, not read from the lifecycle table**, which is stale. Record at [`PRD-016_STAGE6_IMPLEMENTATION_TASKS.md`](./PRD-016_STAGE6_IMPLEMENTATION_TASKS.md). *Superseded value: ⏳* |
| 7 — Freeze | **A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank** | ✅ **PASSED — the gate artefact EXISTS**: the §3.3 specification row admitting this document at **Rank 3** under **`BASELINE-2026-08-19-B`**, conferred by [`ADR-0051`](../../00-governance/adr/ADR-0051-audit-trail-prd-v0.1-baseline.md), with the record at [`PRD-016_STAGE7_FREEZE.md`](./PRD-016_STAGE7_FREEZE.md) — **which confers nothing; the §3.3 row does.** *Superseded value: ⏳* |
| 8 — Implementation | — | ⛔ **NOT STARTED** |
| 9 — Verification | — | ⛔ **NOT STARTED** |

> ⚠ **The five verdicts above were changed from `⏳` in the freeze commit, not before it, and not silently.** Each was **false** against artefacts
> that already existed on disk; leaving them would have made this document contradict the baseline at the moment of admission. Every superseded
> value is **quoted, not erased**, per `ADR-0050` §4.1 and `ADR-0051` §4.1.
>
> ⛔ **Stages 8 and 9 are NOT STARTED and this freeze does not begin them.** `FROZEN` ≠ `IMPLEMENTED` ≠ `VERIFIED`: **0 of 30** tasks are
> implemented, **0 of 18** acceptance criteria are proven by a test, acceptance coverage stands at **27 of 35 = 77.1%** with the 8 uncovered
> obligations named in §9, all **5 `AUD-GAP-*` remain OPEN**, and the 3 code contradictions `D-016-01`…`03` are carried into Stage 8 **unrepaired**.

---

## 13. References

Rank 1 — [`MASTER_PRD.md`](../MASTER_PRD.md) `MP-GBR-13`, `MP-GBR-31`, `MP-GBR-04`, `MP-NFR-10`, §8.1 ·
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) ·
[`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md)
Rank 2 — [`ADR-0012`](../../00-governance/adr/ADR-0012-scaffold-port-inversion-debt.md) ·
[`ADR-0014`](../../00-governance/adr/ADR-0014-tenant-key-and-audit-mutation-enforcement.md) ·
[`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) ·
[`ADR-0050`](../../00-governance/adr/ADR-0050-tenancy-prd-v0.1-baseline.md)
Rank 3 — [`Authentication_PRD_v2.md`](../authentication/Authentication_PRD_v2.md) §10.4 **FROZEN** ·
[`PRD-013_TENANCY.md`](../tenancy/PRD-013_TENANCY.md) **FROZEN** ·
[`PRD-006_ATTENDANCE-MANAGEMENT.md`](../attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) §21
Rank 4 — [`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) L133, L384, §7.3
L329, §9.1 L449–450 · [`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md)
`X-10` L359, L580 · `tool/module_dependencies.yaml` `platform/audit`
Rank 7 — [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md)

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** *(unchanged)* | 2026-08-19 | **FROZEN at Rank 3** by [`ADR-0051`](../../00-governance/adr/ADR-0051-audit-trail-prd-v0.1-baseline.md), gate artefact = the `DOCUMENTATION_BASELINE.md` **§3.3** row, baseline identifier **`BASELINE-2026-08-19-B`**. ⚠ **The version is deliberately NOT moved.** `ADR-0020` §4 item 2 admits each document *"at the version that was verified"* and §5 rejects renumbering to mark a freeze: **Stage 7 confers status, not content.** Refusing the freeze because v0.x looks *"not release-ready"* was `PRD-013`'s Stage 7 blocker 1 and `ADR-0050` §5 **withdrew it as a rule this repository does not contain**; it is not revived here. **No requirement text, identifier, range, gap, default or exclusion was altered by the freeze** — the specification span **§0 through §11** hashes to **`a4fee4df…9d6cb`** both before and after, measured by extracting it by section anchor in each version rather than by fixed line numbers, which the header's growth would have shifted. ⚠ **Stated precisely, because the looser claim would be false:** the *file* hash **did** move away from `281f15e8…f339be`, because the header, §12 and §14 all record the conferral; the new value is witnessed in [`PRD-016_STAGE7_FREEZE.md`](./PRD-016_STAGE7_FREEZE.md) §12 rather than here, since a document cannot state its own digest without invalidating it. `281f15e8…f339be` is the whole-file hash of the **pre-freeze** document and is what all five gate records cite — uniformly, which is why **no alignment supplement was required and none was written**. The only edits are the header's status/baseline/rank/registry fields, the five §12 verdicts (each with its superseded `⏳` **quoted, not erased**) and this row. `BC-24` is the **first CAPABILITY & GENERIC band context frozen** — measured, not inherited: BC Map **L271** reserves the FOUNDATIONAL band for `BC-18`/`BC-19`/`BC-25`, so `PRD-013`'s precedent phrase does not transfer, and of the capability band's **11** contexts none was owned by any previously frozen PRD. ⛔ **Nothing was fixed to make this pass**: all **5 `AUD-GAP-*` OPEN**, **0 of 30** tasks and **0 of 18** criteria tested, coverage **27/35 = 77.1%**, `D-016-01`…`03` carried to Stage 8 unmodified, and **no file under `lib/`, `packages/`, `test/` or `tool/` was touched** — so no gate was taught about this document in the same act that admitted it. Two **pre-existing** governance defects found while updating the registers that carried them were corrected and logged as **`GCP-18`** and **`GCP-19`** (`DOCUMENTATION_BASELINE.md` §6); `GCP-18` was found **by testing `ADR-0051`'s own claim that no such defect existed**, and the test falsified the claim. |
| **v0.1** | 2026-08-19 | Created as the **Stage 2** draft for `PRD-016` Audit Trail (`BC-24`, aggregate `AuditEntry`, module `platform/audit` rank 5, prefix `AUD-`). Declared **58** identifiers across five populated registers with contiguous ranges published up front: `AUD-FR-001`…`016`, `AUD-BR-001`…`003`, `AUD-INV-001`…`004`, `AUD-XC-001`…`012`, `AUD-AC-001`…`018`, `AUD-GAP-001`…`005`. **`AUD-EVT-*` declared empty** — `BC-24` is a producer in **zero** BC Map §9 rows. **`AUD-CFG-*` not issued at all** — no Rank 1–7 authority supplies a default or bound, and an unbounded configurable is a specification hole. Every requirement cites existing authority rather than restating it; the audit **principles** remain `AU-1`…`AU-9` in the **frozen** Authentication PRD §10.4, and `AUTH-10.26` is the authority by which this module owns storage, retention and query. Recorded **5 gaps** owned elsewhere and **3 code contradictions** (`D-016-01`…`03`). **No retention period, jurisdiction, legal requirement, event, integration edge or configuration value was invented. No code modified. No identifier registered in the traceability matrix — that is Stage 5.** |
