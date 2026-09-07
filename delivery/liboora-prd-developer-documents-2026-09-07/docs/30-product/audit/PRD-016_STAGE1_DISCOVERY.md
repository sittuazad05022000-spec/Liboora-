# PRD-016 — Stage 1 Discovery Record

| Field | Value |
|---|---|
| **Subject** | `PRD-016` Audit Trail |
| **Stage** | **Stage 1 — Discovery** |
| **Gate** | *"a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6"* — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 1 |
| **Gate satisfied** | ✅ **YES** — `BC-24` at BC Map **L133**; registry §6 shows **no written PRD owning `BC-24`**, contested contexts **0** |
| **Verdict** | ✅ **PASS — a PRD is warranted** |
| **Candidate prefix** | `AUD-` — **0 collisions in both directions** (§6) |
| **Aggregate** | `AuditEntry` — BC Map **L384** |
| **Module** | `platform/audit` (rank **5**) — `tool/module_dependencies.yaml:37` |
| **Date** | 2026-08-19 |
| **Reviewed at** | `66fc263327aed5233f1449e2e8e800a24a39b68e` |
| **Authority for ordering** | [`PRODUCT_IMPLEMENTATION_ROADMAP.md`](../../00-governance/prd-ecosystem/PRODUCT_IMPLEMENTATION_ROADMAP.md) §4 Wave 1 row **1.2** |

> **This record confers nothing.** It documents that the Stage 1 gate was met. Per `PRD_LIFECYCLE.md` L41–42:
> *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed, however complete the
> work feels."*

---

## 1. The four Stage 1 questions, answered against authority

`PRD_LIFECYCLE.md` Stage 1 asks four questions and states what each fails on. Each is answered by citation, not
by judgement.

| Question | Fails if | Finding | Authority |
|---|---|---|---|
| Does a bounded context own this? | *"It is a presentation composition"* ⇒ **no PRD** | ✅ **`BC-24` Audit Trail** is a bounded context, `[GENERIC]`, owning platform **Audit**, **V1** | BC Map **L133** |
| Does another PRD already own the context? | *"It is an amendment to that PRD"* | ✅ **No.** `BC-24` is unowned by any written PRD; contested contexts **0** | Registry **§6**, **§7** |
| Is it V1/V2/V3, or Future? | Future ⇒ **stop** | ✅ **V1** | BC Map **L133**; registry §4.2 |
| Does it own an aggregate and an invariant? | Owning neither ⇒ a capability, not a context | ✅ **Aggregate `AuditEntry`**; **invariant** *"append-only, no update or delete path exists in code"* | BC Map **L384** |

**All four pass.** The commonest wrong outcome the lifecycle warns of — *"a PRD that should not exist"* — does not
apply: `BC-24` owns state, owns an invariant, and is named in a Rank 1 document.

---

## 2. Why `PRD-016` and not another PRD — the mechanical ordering

This was not decided by number. Four independent authorities were consulted; all four agree.

| Axis | Evidence | Source |
|---|---|---|
| **Explicit ordered wave** | Wave 1 is an ordered table: **1.1 `PRD-013` → 1.2 `PRD-016` → 1.3 `PRD-014` → 1.4 `PRD-017`**. `PRD-013` is **`FROZEN`** as of 2026-08-19, so 1.2 is next | Roadmap §4, **L89–92** |
| **Critical path** | `PRD-013 Tenancy ──► PRD-016 Audit ──► PRD-014 Entitlement` | Roadmap §5 **L182** |
| **Sequencing rule** | Rule 2: *"**`PRD-016` Audit before the first auditable action.** Immutability cannot be retrofitted."* | Roadmap §6 **L208** |
| **Live unsatisfied edge** | **`D-09`** — consumers `PRD-002` (**`FROZEN`**) and `PRD-003` (**`IMPLEMENTING`**) already depend on `BC-24`. §4 preamble: these edges *"exist **architecturally today** and are satisfied by nothing… Each is a live risk, not a future one"* | `PRD_DEPENDENCY_GRAPH.md` **§4 L111** |

**Why Tenancy had to precede it**, verbatim from the roadmap: *"An audit entry without a tenant key is a
cross-tenant leak in the one store that must never leak — `MP-RSK-01`, 'highest-severity failure class in the
system' (`X-13`)."* That precondition is now satisfied — `PRD-013` is frozen and `TEN-FR-018` requires
`tenant_id` on every tenant-scoped row.

**Wave 1's entry gate is CLEARED** as of 2026-08-04 (roadmap L92, `ADR-0013` + `ADR-0017`, `PGA-11` closed).

---

## 3. Ownership check — `BC-24` is not owned, and is not contested

| Check | Method | Result |
|---|---|---|
| Registry §6 assigns `BC-24` to a written PRD? | Read §6 table | ❌ No — falls in the *"(unwritten `PRD-004`…`021`)"* bucket |
| Contested bounded contexts | Registry §7 | **0** — resolved 2026-08-04 by `ADR-0013` + `ADR-0017` |
| Any ADR assigns `BC-24` elsewhere? | `grep -rn "BC-24" docs/00-governance/adr/` | **7 hits, 0 ownership claims** — all are event-consumer citations (`ADR-0018` L136/137, `ADR-0023` L48, `ADR-0030` L121, `ADR-0041` L126, `ADR-0042` L128) or a `[GENERIC]` sharing note (`ADR-0017` L86) |
| Any existing `PRD-016` document? | `ls docs/30-product/` | ❌ None — no `audit` product document existed before this record |
| Registry status | §4.2 **L306** | **`PLANNED`** |
| Named owners | `PRD_OWNERSHIP_MODEL.md` §4.3 **L198** | Product Owner · **Audit Platform** · ARB · Platform Engineering — by **role**, not individual (`PGA-08`) |

**Conclusion: the Stage 1 gate is met exactly as written.** `BC-24` is in the BC Map and is owned by no PRD.

---

## 4. What `BC-24` owns — discovered, not assumed

The instruction was explicit: *do not assume what fields an `AuditEntry` contains beyond what repository authority
establishes.* The following is the complete set of statements found. **Nothing here is invented.**

### 4.1 The aggregate and its declared parts

BC Map **L384**, verbatim:

> `| BC-24 Audit Trail | `AuditEntry` | `Actor`, `Action`, `Target`, `TenantContext` | **Append-only, no update or
> delete path exists in code**; entry carries the tenant and actor of record; legal hold blocks purge |`

So: aggregate root **`AuditEntry`**; value objects **`Actor`**, **`Action`**, **`Target`**, **`TenantContext`**.
The BC Map declares **four** value objects and no more.

### 4.2 The nine audit principles — already specified, in a FROZEN Rank 3 document

`Authentication_PRD_v2.md` §10.4 (**`FROZEN`**, Rank 3) L4016–4028 defines **`AU-1`…`AU-9`**:

| ID | Principle | Statement (verbatim) |
|---|---|---|
| `AU-1` | Completeness | *"Every security-relevant action is recorded, whether it succeeded or failed"* |
| `AU-2` | Immutability | *"A recorded fact can never be altered or removed by anyone"* |
| `AU-3` | Attribution | *"Every record identifies the acting account, the device where applicable, and the moment"* |
| `AU-4` | Independence | *"Audit is beyond the control of the roles whose actions it records"* |
| `AU-5` | Minimality | *"Records hold what is needed to reconstruct the action, and nothing more"* |
| `AU-6` | Non-disclosure | *"Records hold no credential and no unmasked personal data"* |
| `AU-7` | Tenant confinement | *"A library sees only audit concerning its own context"* |
| `AU-8` | Survivability | *"Audit outlives the account it concerns, in a form that no longer identifies the person"* |
| `AU-9` | Server authority | *"Every recorded time is server time; client-supplied time is never recorded as authoritative"* |

**This is the single most important discovery in Stage 1.** The audit *principles* are already written, in a
**frozen** document, at **Rank 3**. `PRD-016` therefore **must not restate them** — Stage 4's *"No requirement
restates another PRD's"* would fail. `PRD-016` **cites** `AU-1`…`AU-9` and specifies the store that satisfies them.

### 4.3 The eight requirements `AUTH-10.19`…`10.26`, and the one that hands ownership over

Same document, immediately after §10.4:

| ID | Requirement (verbatim) |
|---|---|
| `AUTH-10.19` | *"Every action in the auditable list MUST produce an audit record"* |
| `AUTH-10.20` | *"Audit records MUST be immutable for every role, **including Platform Administrator**"* |
| `AUTH-10.21` | *"Audit records MUST identify the acting account, the device where applicable, and the server-side moment"* |
| `AUTH-10.22` | *"Audit records MUST NOT contain OTP values, session credentials, device trust markers or unmasked mobile numbers"* |
| `AUTH-10.23` | *"A library MUST be able to view audit only for actions within its own context"* |
| `AUTH-10.24` | *"Audit MUST record failed and refused actions, not only successful ones"* |
| `AUTH-10.25` | *"Audit MUST survive account erasure in a de-identified form"* |
| **`AUTH-10.26`** | *"**Authentication MUST NOT own audit storage, retention or query; it MUST only produce the records**"* |
| `AUTH-10.27` | *"Inability to record an audit fact MUST be treated as a failure of the action for security-critical operations"* |

**`AUTH-10.26` is the load-bearing find.** A frozen Rank 3 PRD explicitly disclaims ownership of **audit storage,
retention and query** — which is precisely the surface `PRD-016` must own. The gap is not merely unfilled; it is
**formally vacated by the neighbouring frozen document**.

⚠ **`AUTH-10.27` creates a real tension with `E-20`.** `E-20` is *"fire-and-forget"* and *"Domain never calls audit
synchronously"*, yet `AUTH-10.27` requires inability-to-record to **fail the action** for security-critical
operations. This is recorded in §7 as a candidate gap, not resolved here.

### 4.4 The machine-enforced module assertions — `AU-1`…`AU-4` in the manifest

`tool/module_dependencies.yaml` **L356–371** declares, for `platform/audit`:

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
    - id: AU-2  rule: "this platform is the sole consumer of every Class A authentication fact"       # A-5
    - id: AU-3  rule: "unavailability of this platform delays audit visibility only; recording occurs in the emitter's transaction"
    - id: AU-4  rule: "erasure makes a record non-identifying by key destruction; no record is ever removed"
```

⚠⚠ **A GENUINE IDENTIFIER HAZARD — `AU-n` names two different registers.** See §6.2. This is exactly the class of
error the lifecycle's Stage 5 exists to catch (*"citing `PO-3` when `SPO-3` was meant would move a requirement from
one bounded context to another"*).

**Manifest `AU-4` resolves the hardest question in this PRD without invention.** How does append-only survive a
right-to-erasure request? Answer, already written: *"erasure makes a record non-identifying **by key destruction**;
**no record is ever removed**."* That is consistent with `AU-8` (*"outlives the account… in a form that no longer
identifies the person"*), `AUTH-10.25`, `MP-GBR-04` and `ID-5`. **No retention period, jurisdiction or legal rule
needs to be invented.**

### 4.5 The event envelope — already canonical, at Rank 4

BC Map §9.1 **L449–450**:

> **Envelope** — `eventId`, `eventType`, `schemaVersion`, `occurredAt`, `tenantId`, `actorId`, `correlationId`,
> `causationId`, `aggregateId`, `payload`.
>
> **Tenant safety** — *"`tenantId` is mandatory on every domain event. A consumer that processes an event without
> establishing tenant context must **fail loudly, not default**."*

Also: **Delivery** at-least-once ⇒ *"**every consumer must be idempotent** — keyed on `eventId`"*; **Atomicity**
via **Transactional Outbox** in the same DB transaction as the mutation.

`PRD-013` set the precedent for citing this rather than restating it (`TEN-FR-021`).

### 4.6 The integration edge — exactly one, inbound

BC Map §7.3 **L329**:

> `| E-20 | All contexts | BC-24 Audit Trail | `PL` | Event (fire-and-forget, outbox-backed) | Domain never calls
> audit synchronously |`

**Mechanically verified: `BC-24` publishes ZERO events.** Scanning the §9 event fan-out table (L400–440) for rows
whose *producer* column is `BC-24` returns **0**; producers are only `BC-01`…`BC-06`, `BC-10`…`BC-13`, `BC-18`,
`BC-19`, `BC-20`, `BC-27`. `BC-24` appears **25 times, always as a consumer** — the widest event fan-in in the map.

⇒ `PRD-016`'s `AUD-EVT-*` register is a candidate for **declared empty**, on the `TEN-CFG-*` precedent. Recorded
for Stage 2, not decided here.

### 4.7 The Class A emission class — `BC-24` is a *sole* consumer by contract

Manifest **L467–470**:

```yaml
- class: A                            # audit-only fact
  transport: event
  consumers: [platform/audit]         # A-5 — sole consumer, no exceptions
  constraint: "any consumer other than platform/audit is a boundary violation, not a subscription"
```

Enforced by `ID-3` (*"no Class A fact has a consumer other than `platform/audit`"*) and `ID-6` (*"the audit fact
commits in the same transaction as the state change it describes"*).

### 4.8 Rank 1 — the global business rule

`MASTER_PRD.md` **L354**:

> `| **MP-GBR-13** | Every critical action is auditable. The audit trail is **append-only with no update or delete
> path in code**; legal hold blocks purge. | Preserved, hardened |`

And **L193**: `| BC-24 Audit Trail | Required by global business rule "every critical action is auditable". |`
And **MP-GBR-31** (L439): AI-initiated writes *"produce an AI Action Log entry. **No exceptions in V1.**"*

### 4.9 The forbidden-edge rule that names this module

Dependency Matrix **L359**:

> `| **X-10** | `AUDIT` with an update or delete method | "We need to fix a bad entry" | Destroys the evidentiary
> value of the entire audit trail | **Append a correcting entry** |`

**`X-10` is implemented and passing** — Matrix L13 and L580, per **`ADR-0014`** (`Accepted` 2026-08-04, migration
*"has been executed"*). See §7 finding `F-1`: one document still says otherwise.

---

## 5. What `BC-24` does **not** own — the exclusion candidates, each with a named owner

Every item below has an owner **other than** `BC-24`, established by citation. These become `AUD-XC-*` in Stage 2.

| Subject | Owner | Authority |
|---|---|---|
| `Account`, `Credential`, `AuthSession`, `Device`, `ConsentRecord`, and **every authorisation decision** | **`BC-18`** | BC Map L380; `ID-1` L178; Matrix `X-13` |
| The `Tenant` aggregate, tenant context propagation, residency | **`BC-19`** / `PRD-013` **`FROZEN`** | `TEN-FR-001`…`004` |
| `EntitlementSet`, `FeatureGate`, `UsageCounter`, `Limit` | **`BC-21`** | BC Map L383 |
| `Subscription`, `SubscriptionInvoice`, billing state | **`BC-20`** | BC Map L382 |
| Analytics projections, `CertifiedMetric`, `ReadModel` | **`BC-26`** | BC Map L385 |
| Search indexing | **`BC-23`** | BC Map `E-21` |
| Notification channels, templates, delivery | **`BC-22`** | BC Map `E-23` |
| Typed configuration resolution | **`BC-25`** / `PRD-023` **`PLANNED`** | BC Map `E-19`; `ADR-0017` |
| The attendance correction workflow | **`BC-03`** / `PRD-006` | `MP-GBR-11`; `ATT-FR-130` |
| Financial immutability and compensating entries | **`BC-05`** / `PRD-008` | `MP-GBR-12` |
| **Producing** audit facts (the *emitters'* duty) | **every other context** | `E-20`; `AUTH-10.19`; `ATT-FR-129`…`133` |

**Note the symmetry with `AUTH-10.26`.** Authentication disclaims *storage, retention and query*; `PRD-016` must
disclaim *deciding what is auditable in another context's domain*. `ATT-FR-131` (attendance) and `AUTH-10.19`
(authentication) each define their own auditable-action lists. `PRD-016` **must not** restate or override them.

---

## 6. Prefix collision analysis — checked in both directions

### 6.1 `AUD-` is free

| Test | Command | Result |
|---|---|---|
| Prefixes already in use for `*-FR/BR/INV/EVT/XC/AC/CFG/GAP-nnn` | regex scan of `docs/` | `ATT` `FEE` `ITG` `MM` `SAAS` `SEAT` `SID` `SM` `TEN` — **9 prefixes, `AUD` absent** |
| Any `AUD-` token anywhere | `grep -rn "AUD-" docs/ lib/ tool/` | **0 hits** |
| Forward substring: does `AU-` match `AUD-FR-001`? | `echo AUD-FR-001 \| grep -c "AU-"` | **0** |
| Reverse substring: does `AUD-` match `AU-3`? | `echo AU-3 \| grep -c "AUD-"` | **0** |

**Zero collisions in both directions.** The hyphen makes `AU-` and `AUD-` non-overlapping tokens: `AU-` is always
followed by a digit, `AUD-` always by a letter.

### 6.2 ⚠ FINDING `F-2` — `AU-n` is **two different registers**, and neither is `PRD-016`'s

This is a genuine hazard and is recorded rather than worked around.

| Register | Location | Rank | Meaning of `AU-4` |
|---|---|---|---|
| **`AU-1`…`AU-9`** *audit principles* | `Authentication_PRD_v2.md` §10.4 | **Rank 3, FROZEN** | *"Independence — audit is beyond the control of the roles whose actions it records"* |
| **`AU-1`…`AU-4`** *module assertions* | `tool/module_dependencies.yaml` `platform/audit` | tooling manifest | *"erasure makes a record non-identifying by key destruction"* |

**`AU-4` means two entirely different things depending on which register is meant.** So does `AU-1`
(*"Completeness"* vs *"no public mutation method exists"*), `AU-2` (*"Immutability"* vs *"sole consumer of Class A"*)
and `AU-3` (*"Attribution"* vs *"unavailability delays visibility only"*).

**Disposition:** `PRD-016` will **never** cite a bare `AU-n`. Every citation must be qualified — either
*"`AU-4` (Authentication PRD §10.4)"* or *"manifest assertion `AU-4` (`platform/audit`)"*. This is the same
discipline the matrix applied to `PO-n`/`SPO-n`. **`PRD-016` will not use `AU-` as its own prefix**, which is why
`AUD-` was chosen. Carried to Stage 5 §2J for formal registration.

⚠ **This is a pre-existing repository condition, not one created here.** Both registers predate `PRD-016`. It is
**not** silently fixed: renaming either would edit a frozen Rank 3 document or a tooling manifest, neither of which
Stage 1 authorises.

---

## 7. Findings carried forward — none blocks Stage 2

| # | Finding | Verified by | Disposition |
|---|---|---|---|
| **`F-1`** | `PRD_DEPENDENCY_GRAPH.md` `D-09` (L111) states *"`X-10` audit-mutation check **not implemented**"*. **`ADR-0014`** (`Accepted`) records the migration *"has been executed"* and `X-10` *"now implemented and passing"*; Matrix L13 says **12 of 12** categories implemented | Read both; direct contradiction | **Stale derived statement**, same class as `GCP-15`/`16`/`17`. `PRD-016` cites the **Matrix + `ADR-0014`** (Rank 4 + Rank 2), never `D-09`'s status line. **Not edited** — outside this stage's scope. Logged as **`GCP-18`** candidate |
| **`F-2`** | `AU-n` names two registers (§6.2) | Both read verbatim | Qualify every citation; use `AUD-` prefix. No document edited |
| **`F-3`** | `AUTH-10.27` requires inability-to-record to **fail** the action, while `E-20` is **fire-and-forget** and `AU-3`(manifest) says unavailability *"delays audit visibility only"* | Read all three | **Genuine tension.** Candidate `AUD-GAP-*` for Stage 2/4. **Not resolved here** — may require ARB. Does **not** block Stage 2, because the PRD can state the tension without deciding it |
| **`F-4`** | Existing code `lib/platform/audit/audit.dart` exposes `recent([int n])` (L60–61) with **no tenant filter**, and `count` (L63) returning a **global** count. `grep -c tenantId` inside `recent()` → **0**. Both are called from `lib/app/dashboards/ops_page.dart:270,272,282` | Read code + callers | **Candidate contradiction with `AU-7`** (*"A library sees only audit concerning its own context"*) and `AUTH-10.23`. **Code is NOT modified** (Stage 8 forbidden). Carried as a code-defect finding, on the `D-013-01`/`D-013-02` precedent |
| **`F-5`** | `AuditEntry` in code carries `id, tenantId, actor, action, target, at, detail` — **no** `correlationId`, `causationId`, `eventId`, `schemaVersion`; `at` defaults to `DateTime.fromMillisecondsSinceEpoch(0)` when omitted, which contradicts `AU-9` server-authority | Read L9–27, L51 | Carried as a code-defect finding. **No code change** |
| **`F-6`** | Manifest `event_register_source: docs/prd/authentication` — that path **does not exist**; `EVT-1001`…`1036` member names are recorded as never available (`docs/90-archive/.../Developer_Guide.md` L275, L585) | `ls docs/prd` → absent | Pre-existing. `PRD-016` cites the **class contract** (`A-5`, `ID-3`) which is enforceable, **not** individual `EVT-*` numbers it cannot verify |
| **`F-7`** | Rank 7 `CONFIGURATION_GUIDE.md` defines **no** audit, retention or legal-hold parameter (`CFG-1`…`CFG-12` are SMS/session/device/lock values; `CFG-9`/`CFG-10` are *account* retention, not audit) | Read §E table + all 5 audit mentions | ⇒ `AUD-CFG-*` is a candidate for **declared EMPTY**, on the `TEN-CFG-*` precedent. Decided in Stage 2 |
| **`F-8`** | **No retention period, jurisdiction or legal-hold mechanism is defined anywhere at Rank 1–5.** `MP-GBR-13` says *"legal hold blocks purge"* without defining hold; `MP-NFR-10` assigns compliance to *"SECURITY + DATA Governance"*; `Q-04` is *"Open — needs counsel"*; EA lists `Legal Hold (Future)` and `Support Access Log (V3)` — EA is **Rank 6, descriptive only** | Grepped all Rank 1–5 | ⇒ **Candidate `AUD-GAP-*`.** Per the instruction, this is **recorded as a gap, not invented**. Does not block: `AU-4`(manifest) already fixes the *mechanism* (key destruction, never removal) |

**No finding blocks Stage 2.** `F-3` and `F-8` are recorded as gaps with named owners; `F-4` and `F-5` are code
defects that a specification is permitted to contradict (that is what a specification is *for*); `F-1`, `F-2`, `F-6`
are pre-existing conditions handled by citation discipline.

---

## 8. Prerequisites — verified satisfied

| Prerequisite | Authority | Status |
|---|---|---|
| Wave 1 entry gate cleared | Roadmap L92 | ✅ **CLEARED 2026-08-04** |
| Predecessor `PRD-013` (`BC-19`) complete | `ADR-0050`, baseline §3.3 | ✅ **`FROZEN` 2026-08-19** at v0.1, Rank 3 |
| Tenant key specified for the audit store to carry | `TEN-FR-018`, `TEN-FR-008` | ✅ Yes — `tenant_id` on every tenant-scoped row; `TenantId` in `liboora_contracts` |
| Edge exists in BC Map §7 | **`E-20`** L329 | ✅ Yes — no ADR required |
| Rank direction downward | Matrix `L2`; `platform/audit` rank 5 | ✅ Consumers reach it by **event**, not import; `banned_imports: ["domain/**","app/**"]` |
| `EVENT` edge rules apply | Dep-graph §7 item 4 | ✅ Async, at-least-once, idempotent, **no** credential/OTP/mobile/parent contact — matches `AU-6`, `ID-5`, `AUTH-10.22` |
| No data duplication | Dep-graph §7 item 5 | ⚠ Requires care: an audit entry legitimately *copies* facts. Addressed by `AU-5` minimality — carried to Stage 3 |
| Prefix registered before requirements written | Roadmap §6 rule 6 | ⏳ Stage 5 obligation, noted |

---

## 9. What this record deliberately does **not** do

| Not done | Why |
|---|---|
| Register `AUD-*` in `TRACEABILITY_MATRIX.md` | That is the **Stage 5** gate. Registering now would be premature — the instruction forbids it |
| Allocate an `IMPL-*` range | **Stage 6** gate |
| Change `PRD_REGISTRY.md` status from `PLANNED` | Status is **conferred** by the freeze mechanism, not claimed |
| Write an ADR | Stage 1 needs none: `BC-24` is already in the BC Map, `E-20` already exists, ownership is already routed. Following `ADR-0047` §2.3 reasoning, and `D-013-01`'s — writing one *"would manufacture a controversy in order to resolve it"* |
| Fix `D-09`'s stale `X-10` line | Not this stage's file; read-only finding `F-1` |
| Modify `lib/platform/audit/audit.dart` | **Stage 8 is forbidden.** Findings `F-4`/`F-5` are recorded, not repaired |
| Define a retention period or legal-hold rule | **No authority defines one.** `F-8` records the gap |
| Rename either `AU-n` register | Would edit a frozen Rank 3 document or the tooling manifest |

---

## 10. Verdict

✅ **Stage 1 PASS.** The gate — *"a context identified in the Bounded Context Map, not already owned in
`PRD_REGISTRY.md` §6"* — is satisfied by `BC-24` at BC Map L133 and registry §6's zero contested contexts.
`PRD-016` is warranted, is next in the repository's own ordering, and its prerequisites are met.

**Stage 2 may begin.** Eight findings are carried forward; none blocks it.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 1** Discovery record for `PRD-016` Audit Trail. Answered the four Stage 1 questions against authority; verified `BC-24` unowned and uncontested; verified `AUD-` collision-free in both directions; discovered `AU-1`…`AU-9` (Authentication PRD §10.4, **FROZEN**), `AUTH-10.19`…`10.27`, manifest assertions `AU-1`…`AU-4`, the Class A emission contract, the §9.1 envelope and `MP-GBR-13`. Recorded **8 findings** — including two identifier registers sharing `AU-n` (`F-2`), a stale `X-10` status line (`F-1`), the `AUTH-10.27`/`E-20` tension (`F-3`), two code defects (`F-4`, `F-5`) and the absent retention authority (`F-8`). **No requirement written, no identifier registered, no file outside this record created, no code modified.** |
