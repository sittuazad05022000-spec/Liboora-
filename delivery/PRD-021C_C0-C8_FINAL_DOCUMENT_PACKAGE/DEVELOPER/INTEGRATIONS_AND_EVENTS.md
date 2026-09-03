# INTEGRATIONS AND EVENTS — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. The rule that governs this entire document

Everything the marketplace integrates with, it reaches over an **edge that
already exists**. Everything it learns from another context, it learns from an
**event that already exists**. Both sets are closed.

> **`LMT-XC-009`** — ⛔ **No new edge is created or assumed.** BC Map **L292**:
> *"if an edge is not in this table, it **does not exist** and adding it requires
> an ADR."* ⭐ Set remains **29**; `E-27` permanently vacant; `E-31` would be next
> and ⛔ is not minted here.
>
> — C8 **§7.3**, **L356**

> **`LMT-XC-008`** — ⛔ **No new domain event is created, requested or assumed.**
> ⭐ C8 registers **0** events and proposes **0**.
>
> — C8 **§7.3**, **L352**

**Consequence for an implementer.** If you find yourself needing a context that
no edge reaches, or a fact that no event carries, you have found an
**architecture question**, not an implementation detail. Stop and route it to the
Architecture Owner. ⛔ Do not add the edge. ⛔ Do not add the event. ⛔ Do not
reach the context by another path *because* the edge is missing — that is the
precise failure `LMT-BR-010` names.

---

## 2. The integration edges the marketplace may use

Measured against BC Map **§7** in C0 **§4** (**L306**–**L316**):

| Need | Edge | BC Map line | Status | Note |
|---|---|---|---|---|
| Tenant context on every request | **`E-18`** | **L327** | ✅ available | Source cell is the wildcard *"All contexts"* |
| Typed configuration | **`E-19`** | **L328** | ✅ available | Wildcard source |
| Audit emission | **`E-20`** | **L329** | ✅ available | Wildcard source, **fire-and-forget** |
| Entitlement check before a write | **`E-17`** | **L326** | ✅ available | Wildcard source; **C4 only**, and the write is `BC-04`'s |
| Notification facts | **`E-23`** | **L332** | ✅ available | Wildcard source; **C4 only**, emitted by `BC-04` |
| Domain → search index | **`E-21`** | **L330** | ⚠ **conditional** | Source cell is an **enumeration** — `BC-01`, `BC-10`. **`BC-19` is absent** → **`XPC-CONF-004`, OPEN** |
| Domain → file/media `FileRef` | **`E-22`** | **L331** | ⚠ **conditional** | Consumers are `BC-01`, `BC-10`, `BC-12`, `BC-14`. **`BC-19`/`BC-25` absent** → **`XPC-CONF-007`, OPEN** |
| Offline booking queue | **`E-24`** | **L333** | ⛔ **unavailable** | Source is **`BC-03` Attendance only**. `BC-04` is **not** a consumer → `XPC-CONF-011`, resolved **by exclusion, not by an edge** |

### 2.1 ⭐⭐ Why five of these are safe and two are not — the wildcard/enumeration trap

This is the single most likely place for an implementer to go wrong, so it is
stated explicitly.

Five edges carry the **wildcard** source *"All contexts"*. They are therefore
available to **any** context, including the marketplace composition, with no
further permission needed.

Two edges — **`E-21`** and **`E-22`** — carry an **enumeration** instead of a
wildcard. An enumeration lists the contexts that may use the edge. `BC-19` is
**not in `E-21`'s list**; `BC-19` and `BC-25` are **not in `E-22`'s list**.

⛔ **You may not reason that an enumeration "obviously" includes a new context.**
C0 **§4** records that this exact argument has already been tested:

> ⭐ **The wildcard/enumeration distinction is applied exactly as [`ADR-0084`]
> established it** … `ADR-0084` records that the wildcard argument *"was tested
> there and **failed**"* for `E-21`. That finding is **honoured, not
> re-litigated**.

So both conflicts stay **OPEN** (`XPC-CONF-004`, `XPC-CONF-007`), and C0 states
the drafting consequence:

> ⛔ **No edge is created, extended or implied by this draft.** Where an edge is
> missing, the requirement is written as **conditional and blocked**, and the gap
> is recorded in §5 with a named owner.

**What that means when you build.** Any behaviour that depends on `E-21` or
`E-22` from `BC-19`/`BC-25` is **conditional and blocked**. Build it behind the
condition, or do not build it. ⛔ Do not implement it as though the enumeration
had been extended, and ⛔ do not extend the enumeration yourself.

---

## 3. The events the marketplace may consume — all four, all pre-existing

From C8 **§7.3** (**L344**–**L349**), reproduced without change:

| Event | Producer | Edge | Marketplace use |
|---|---|---|---|
| `tenancy.*` (`*Created` / `*Updated` / `*Deleted`) | `BC-19` | **`E-21`** → `BC-23` | Feeds the public discovery index (C2, C6, C3) |
| `tenancy.LibraryProfileViewed` | `BC-19` | **`E-30`** → `BC-26` | C3 owner-only Profile Views |
| `safety.EnforcementActionTaken` | `BC-13` | **`E-14`** | C7 enforcement-consequence rendering |
| Audit facts | all contexts | **`E-20`** → `BC-24` | C7 auditability |

> **`LMT-FR-011`** — C1–C7 **MUST** operate using **only** these existing events.
>
> — C8 **L350**

**There is no fifth event.** If a feature seems to need one, the feature is
either out of scope or blocked.

### 3.1 ⛔ `E-30`'s payload must not be extended — and why

> **`LMT-XC-010`** — ⛔ No extension of `E-30`'s payload. ⭐⭐ **The payload
> boundary IS the privacy control** (§17.2.1) — it carries the subject library and
> the occurrence time and ⛔ **no viewer identity in any form**. 🔗 Reinforces C3,
> C7 `LTS-XC-008` and `ADR-0097`'s refusal to certify `UniqueViewers`.
>
> — C8 **L361**

Read that carefully: the payload is not merely *currently* minimal, it is minimal
**as a control**. `E-30` carries the **subject library** and the **occurrence
time**, and nothing that identifies who viewed.

⛔ **Adding a viewer identifier, a session identifier, a device fingerprint, a
hashed visitor token or any other per-viewer field to `E-30` would remove the
privacy control**, not enrich the event. It is also the mechanism by which
`UniqueViewers` would become computable — which is exactly what `ADR-0097`
refused. See [`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md).

C8 **§12** (**L559**) confirms this is unchanged by the freeze:

> | Payload carries subject library + occurrence time, ⛔ **no viewer identity in
> any form** | ✅ **Unchanged** — `LMT-XC-010` |

### 3.2 ⚠⚠ An open, inherited gap you must not "fix" locally

> **`LMT-BR-010`** — ⛔ C8 **MUST NOT** rely on `BC-26` receiving events over any
> path other than a **declared** edge. ⚠⚠ **`GAP-BCMAP-BC26-EDGES` is OPEN and
> INHERITED** — `BC-26` appears as *"Primary consumer"* in ~20 §9 event rows while
> §7 declares no edge into it besides `E-26`. ⭐ `ADR-0096` deliberately **refused
> to use that anomaly as authority** and minted `E-30` explicitly instead; C8
> reuses that discipline and ⛔ does not resolve the gap. **Owner: Architecture
> Owner.**
>
> — C8 **L366**

⭐ **The precedent is the lesson.** There was an apparent licence sitting right
there — ~20 rows naming `BC-26` as primary consumer — and `ADR-0096` **declined
to use it**, minting `E-30` explicitly instead. When you meet an anomaly that
would conveniently authorise what you want to do, the established practice in
this repository is to **route it, not consume it**.

⛔ Do not resolve `GAP-BCMAP-BC26-EDGES`. Its owner is the **Architecture Owner**.

---

## 4. The delivery contract — inherited whole, restated by nobody

> **`LMT-FR-010`** — 📤 **DELEGATED IN FULL — BC Map §9.1 Event Delivery
> Contract.** C1–C7 inherit, and ⛔ C8 restates none of it as its own.
>
> — C8 **§7.2**, **L330**

The contract C1–C7 inherit, as C8 enumerates it (**L330**–**L342**):

| Obligation | Requirement |
|---|---|
| Publication | **Transactional outbox in the same DB transaction** as the state change |
| Delivery guarantee | **At-least-once** |
| Consumer duty | **Every consumer idempotent, keyed on `eventId`**, with a **processed-events table** |
| Ordering | **Per aggregate**, via partition key `aggregateId` — ⛔ **never global** |
| Envelope | `eventId` · `eventType` · `schemaVersion` · `occurredAt` · `tenantId` · `actorId` · `correlationId` · `causationId` · `aggregateId` · `payload` |
| Schema evolution | **Additive-only**, with **dual publication** |
| Failure handling | **Retry with backoff, then DLQ**, under an SLO |
| Rebuildability | Every `BC-26` projection and `BC-23` index **rebuildable from the log**, tested **quarterly** |

**⭐ Note what "inherited whole" means for you.** These obligations are **binding**
on marketplace consumers, but their **authority is BC Map §9.1**, not `PRD-021C`.
If BC Map §9.1 changes, this list changes with it. ⛔ Do not treat the table above
as an independent specification, and ⛔ do not cite `PRD-021C` as the source of
any of these rules.

**Three of these bite hardest in practice:**

1. **At-least-once means duplicates will arrive.** A consumer that is not
   idempotent on `eventId` is not merely imperfect — it is non-conformant. The
   **processed-events table** is named in the contract, not left to taste.
2. **Ordering is per aggregate only.** ⛔ Do not build logic that assumes a global
   order across libraries or across event types. If two events concern different
   aggregates, you have **no ordering guarantee** between them.
3. **Projections and indexes must be rebuildable from the log.** A discovery index
   or analytics projection that cannot be rebuilt has violated the contract, and
   the rebuild is **tested quarterly** — so it must actually work, not merely be
   theoretically possible.

### 4.1 Event naming

> **`LMT-BR-009`** — 📤 **DELEGATED — BC Map §9**: event names are
> `<Context>.<Aggregate><PastTenseVerb>`; ⭐ *"imperatives are commands and belong
> to Workflow, must not enter the event bus."*
>
> — C8 **§7.1**, **L324**

⛔ `library.SendNotification` is a **command**, not an event, and must not be put
on the bus. ✅ `tenancy.LibraryProfileViewed` is the correct shape — past tense,
context-qualified.

Since **`LMT-XC-008`** mints **0** events, you will not be naming a new one. The
rule is recorded so that you can recognise a violation if you meet one.

---

## 5. Jobs and background work

> **`LMT-FR-012`** — Where C1–C7 require deferred work, it **MUST** be submitted
> through the **declared port** `platform/services:job_runtime`
> (`tool/module_dependencies.yaml` **L338**, under `platform/workflow`'s `ports:`),
> per `ADR-0058`.
>
> — C8 **§8**, **L378**

> **`LMT-BR-011`** — 📤 **DELEGATED — `ADR-0058`**: V1 is a **lightweight
> in-process adapter**, ⛔ **not** the V2 Job Runtime deployment (EA
> **L1860**–**L1871**), and `submit` **MUST be non-`async`**.
>
> — C8 **L383**

> **`LMT-XC-011`** — ⛔ **No own worker pool, queue, retry scheduler or cron.**
> 📤 `FIL-XC-017`. ⭐ Measured: C1–C7 introduce **0** queues, **0** worker pools,
> **0** cron jobs.
>
> — C8 **L387**

⭐⭐ **And then the measurement that matters most:**

> **`LMT-FR-013`** — ⭐ Measured: C1–C7 require **no** deferred work of their own.
> Index feeding, projection building, media processing and audit writing are all
> their owners' background work, reached over existing edges. `LMT-FR-012` states
> the lawful route should a need later arise; **it does not assert one exists.**
>
> — C8 **L391**

**Read the last clause.** `LMT-FR-012` is a **route**, not a **dependency**. It is
written down so that a future need has a lawful path — it is not an instruction to
wire up the job runtime now. ⛔ Do not introduce a job, a cron entry or a worker
because the port exists.

The background work that *does* happen — feeding `BC-23`, building `BC-26`
projections, processing media in `BC-29`, writing audit into `BC-24` — belongs to
**those owners**, not to the marketplace.

---

## 6. Integration by context — what you may expect from each

Composed strictly from the ownership record in C0 **§3** and the edge table above.

| Context | Reached via | The marketplace may | ⛔ must not |
|---|---|---|---|
| `BC-19` Tenancy | producer of `tenancy.*`, `E-30` | Consume library facts; read public profile fields | Gain an analytics capability; write tenancy state |
| `BC-23` Search Indexing | **`E-21`** ⚠ conditional | Read the public discovery index | Define an index, analyzer, tokenizer, synonym set or relevance formula |
| `BC-26` Analytics | **`E-30`** (declared) | Read `ProfileViews` as certified | Compute a metric; rely on an undeclared inbound path |
| `BC-13` Safety | **`E-14`** | Render enforcement consequences; **enter** a report | **Decide** an outcome |
| `BC-24` Audit | **`E-20`** fire-and-forget | Emit audit facts | Call audit synchronously; audit an anonymous public view |
| `BC-04` Booking | **`E-17`**, **`E-23`** (**C4 only**) | Rely on `BC-04` to own the write | Perform the booking write; use `E-24` |
| `BC-29` Media | **`E-22`** ⚠ conditional | Reference a `FileRef` | Serve marketplace-side bytes |
| `BC-18` Authorization | policy decision | Ask for a decision | Make the decision locally |
| `BC-06`, `BC-02`, `BC-25` | per `MASTER_PRD.md` **L171** composition | Compose reads | Store anything |

⚠ **Two upstream owners do not exist yet.** `BC-23`'s Search Indexing PRD
(**`PRD-015`**) and `BC-26`'s Analytics PRD (**`PRD-009`**) are **absent from the
repository** — `PRD-015` does not exist at all, and `PRD-009` is `PLANNED` and
absent from disk (`PRD_REGISTRY.md` **L246**). That is a **real open upstream
dependency**, recorded here because it affects what an implementer can rely on,
and it is ⛔ **not** something the marketplace may resolve by specifying the
missing owner's behaviour itself.

---

## 7. Self-check before you integrate

1. **Is there a declared edge from my context to the target?** If not — stop, route
   to the Architecture Owner. Do not proceed.
2. **Is the edge's source cell a wildcard or an enumeration?** If an enumeration,
   is my context actually named in it? If not, the work is **conditional and
   blocked** (`XPC-CONF-004` / `XPC-CONF-007`).
3. **Is the fact I need carried by one of the four events?** If not, I am not
   permitted to invent a fifth.
4. **Is my consumer idempotent on `eventId`, with a processed-events table?** If
   not, it does not satisfy the inherited contract.
5. **Am I assuming an order between events on different aggregates?** If yes, that
   assumption has no guarantee behind it.
6. **Am I about to add a field to `E-30`?** Stop. The payload boundary *is* the
   privacy control.

---

## 8. Open items in this area — not resolved by this package

| Item | Status | Owner |
|---|---|---|
| `XPC-CONF-004` — `E-21` enumeration omits `BC-19` | **OPEN** | Architecture Owner |
| `XPC-CONF-007` — `E-22` enumeration omits `BC-19` / `BC-25` | **OPEN** | Architecture Owner |
| `GAP-BCMAP-BC26-EDGES` — `BC-26` inbound-edge anomaly | **OPEN, INHERITED** | Architecture Owner |
| `TSF-GAP-009` — `BC-13` → `BC-19` referral transport; ADR **required, not written**; blocks `IMPL-1424` | **OPEN, INHERITED from `PRD-020`** | Architecture Owner with the `BC-19` owner |
| `PRD-015` (`BC-23` owner) — ⚠ does not exist | **OPEN upstream** | Product / Architecture Owner |
| `PRD-009` (`BC-26` owner) — `PLANNED`, absent from disk | **OPEN upstream** | Product / Architecture Owner |
| `ADR-0088` / `ADR-0089` / `ADR-0090` — **cited but not written** | **OPEN** | Architecture Owner |

⛔ **Stage 8 implementation has NOT been performed.** No integration described
here has been built. **0** lines of application code exist for `PRD-021C`.
