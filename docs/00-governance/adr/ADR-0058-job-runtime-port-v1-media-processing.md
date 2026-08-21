# ADR-0058 — `FIL-GAP-015` resolved: the V1 obligation is the `job_runtime` **port**, not the V2 runtime

| | |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-20 |
| **Deciders** | **Architecture Owner** (the port/runtime distinction, the V1 adapter) · Configuration Owner (the timeout and retry values already set by `ADR-0057`) |
| **Closes** | **`FIL-GAP-015`** |
| **Opens** | Nothing |
| **Amends** | Nothing. No PRD, no BC Map, no matrix, no manifest, no EA |
| **Authorises** | The `JobRuntime` port interface in `packages/liboora_contracts`, plus one in-process adapter and its registration |

---

## 1. The question

`FIL-FR-093` requires deferred, retryable media processing at **V1**. `FIL-XC-017` (FROZEN) forbids this module
from operating *"its own worker pool, queue, retry scheduler or cron"* and requires it to consume
`platform/services:job_runtime`. The EA places **Job Runtime at V2** (L1865). `FIL-GAP-015` records the result as a
**sequencing** gap.

The tempting readings are both wrong:

- *"Build the V2 Job Runtime now."* Heavy infrastructure — worker pools, queue management, backoff, job
  observability — for one V1 consumer.
- *"Let File & Media schedule its own retries for now."* Directly violates a **FROZEN** requirement.

The real question: **what exactly does `FIL-XC-017` oblige, a runtime or a port?**

---

## 2. Evidence

| Source | Rank | What it establishes |
|---|---|---|
| `tool/module_dependencies.yaml` **L338** | 4 | `platform/services:job_runtime` is a **declared port**, listed under `platform/workflow`'s `ports:` — not a module, not a deployment |
| `FIL-XC-017` (FROZEN) | 3 | *"**MUST NOT** operate its own worker pool, queue, retry scheduler or cron. It **MUST** consume `platform/services:job_runtime`"* — the obligation is stated as **consumption of a port** |
| EA **L1865-1871** | 6 | *"Job Runtime (V2)"* and its children: **Background Jobs, Worker Pools, Queue Management, Retry & Backoff, Job Observability** — every V2 item is a piece of **scaled infrastructure**, not a contract |
| EA baseline **L139** | 6 | The EA is **descriptive**, not prescriptive |
| `B-7` / `ADR-0012` debt, manifest **L647** | 4 | *"Five service ports are already **declared** (files, qr, idempotency, offline\_sync, clock); **only the interfaces are missing**"* — the repository's own diagnosis of this exact shape |
| `ADR-0012` exceptions, manifest **L646-651** | 2 | The recorded remedy for a declared-but-uninterfaced port is *"extract the interfaces"* — not *"build the subsystem"* |
| `lib/platform/services/services.dart` **L11** | code | `IdempotencyService` — an in-process, in-memory platform service already exists at V1 for a capability the EA also scales later |
| `ADR-0057` §2C.5, §2C.6 | 2 | The timeout (**120 s**) and retry bound (**3**) are already configured. What was missing was never the values |

**The decisive measurement.** Every child of EA "Job Runtime (V2)" is an infrastructure concern: pools, queues,
backoff, observability. **None of them is the port.** The port is what a consumer *calls*; those are what a
platform *operates*. `FIL-XC-017` forbids `BC-29` from operating them and requires it to call the port — so
satisfying `FIL-XC-017` requires **the port to exist**, not the V2 runtime.

---

## 3. Findings

### 3.1 The V1 obligation is a **port**; the V2 item is a **runtime**. They were conflated, and that conflation *is* the gap

`FIL-GAP-015` reads as a scheduling impossibility. It is not. It is `B-7` again — a **declared port with no
interface** — and the repository has already ruled on that shape: `ADR-0012` says *extract the interface*.

Once separated:

- **V1 needs**: a `JobRuntime` port (submit work, observe outcome, bounded retry under an operation key) plus **one**
  adapter that honours it.
- **V2 adds**: worker pools, queue management, distributed backoff, job observability — replacing the adapter,
  **never the port**.

`FIL-XC-017` is satisfied at V1 in full: `BC-29` operates no pool, no queue, no scheduler, no cron. It calls a port.

### 3.2 The V1 adapter is deliberately minimal, and its limits are stated rather than hidden

The V1 adapter runs work **asynchronously in-process**, off the request path. It is honest about what it is not:

| Property | V1 in-process adapter | V2 Job Runtime |
|---|---|---|
| Off the request path | ✅ Required | ✅ |
| Bounded retry under an operation key | ✅ | ✅ |
| Deadline → terminal `FAILED` | ✅ | ✅ |
| Survives process restart | ⛔ **No** | ✅ Durable queue |
| Multi-instance work distribution | ⛔ **No** | ✅ |
| Backpressure across instances | ⛔ **No** | ✅ |

⚠ **The durability limit is real and is not waved away.** A process restart mid-processing loses the in-flight
attempt. Two frozen requirements make that **safe rather than corrupting**: `FIL-FR-057` — a derivative is **never
the sole copy** — and `FIL-FR-083` — a derivative is **regenerable**. So the worst outcome is an object that must
be reprocessed, never a lost original and never a served partial (`FIL-INV-013`). And `FIL-FR-095` already
guarantees an object cannot sit non-terminal forever: the `FIL-CFG-015` deadline moves it to `FAILED`, from which
it is retryable. **The V1 adapter's weakness lands exactly where the specification already has a recovery path** —
which is why a lightweight adapter is defensible here and would not be for, say, payments.

### 3.3 ⛔ No heavy infrastructure is introduced — measured against the EA's own list

Not built: worker pools, queue management subsystem, distributed backoff, job-observability plane, cron, broker,
scheduler daemon. **Zero new packages, zero new dependencies, zero deployment units.** The V1 surface is one port
interface plus one adapter, following the `IdempotencyService` precedent already in `platform/services`.

### 3.4 Idempotency is the port's contract, not the caller's discipline

`FIL-FR-093` requires processing to be idempotent **under an operation key**: no second derivative, no second audit
fact, no different result. Placing that in the **port** contract means the guarantee cannot be lost by a careless
consumer, and the V2 runtime inherits an obligation it must honour. An `IdempotencyService` already exists to
compose with.

### 3.5 Retry is scheduled by the runtime, never by `BC-29`

`FIL-FR-093`: *"Retry **SHALL NOT** be scheduled by this module."* So `retryBudget` is submitted **as a parameter of
the job** and the runtime owns the loop. `BC-29` declares *how many* attempts are permitted (from
`FIL-CFG-014` = 3, `ADR-0057` §2C.6) and never decides *when* one happens. This is the distinction that keeps
`FIL-XC-017` satisfied in substance and not merely in wording.

### 3.6 What this does **not** decide

Not the storage model, not the schema, not the API, not any Flutter surface. Not `FIL-GAP-008` (retention — a legal
determination), not `FIL-GAP-016` (video — refused), not `FIL-GAP-012`'s implementation half (`ADR-0059`).
The port carries **no** tenant identifier of its own: it inherits ambient `TenantContext`, so no tenancy rule is
created, relaxed, or introduced into a global identity context.

---

## 4. Decision

1. **`FIL-GAP-015` is CLOSED.** It was a **port-vs-runtime conflation**, resolved by the `ADR-0012` / `B-7`
   precedent for a declared port whose interface is missing: **extract the interface**.
2. **A `JobRuntime` port is defined** in `packages/liboora_contracts` — the contract `FIL-XC-017` already requires
   `BC-29` to consume. Manifest **L338** already declares it; **no manifest edit is required**.
3. **One in-process adapter** is provided in `lib/platform/services/`, registered at the composition root,
   following the `IdempotencyService` precedent.
4. **⛔ No V2 infrastructure is built** (§3.3), and the adapter's non-durability is **documented in the port's own
   contract**, not discovered later.
5. **Retry is the runtime's job**; `BC-29` supplies the bound only (§3.5).
6. **No requirement is amended.** `FIL-FR-093`, `FIL-XC-017`, `FIL-FR-095` are satisfied **as written**. The EA is
   **not edited** — it is descriptive, and Job Runtime *as a scaled subsystem* genuinely remains V2.
7. **No baseline identifier is issued.** No Rank 1–3 document changes version.

---

## 5. What this ADR does NOT rest on

- **Not** on amending `FIL-XC-017`. It is satisfied literally: no pool, no queue, no scheduler, no cron in `BC-29`.
- **Not** on the EA being wrong. Job Runtime *as scaled infrastructure* is V2 and stays V2. The port is not that.
- **Not** on a claim of durability. §3.2 states the limit and names the two frozen requirements that make it
  survivable.
- **Not** on File & Media code existing. **It still does not.** This ADR authorises a **platform port**, and no
  `BC-29` module, schema or API is created.
- **Not** a claim that anything is verified.

---

## 6. Options considered

| Option | Verdict |
|---|---|
| Define the port, ship one in-process adapter | ✅ **Chosen.** Satisfies frozen `FIL-XC-017` literally; `ADR-0012`/`B-7` precedent; no heavy infrastructure |
| Build the V2 Job Runtime now | ⛔ **Rejected.** Pools, queues, backoff and an observability plane for one V1 consumer. The instruction forbids unnecessary infrastructure and the EA does not require it at V1 |
| Let `BC-29` schedule its own retries in V1 | ⛔ **Rejected.** Verbatim violation of FROZEN `FIL-XC-017` |
| Process synchronously inside the upload request | ⛔ **Rejected.** The instruction forbids it, and it breaks `FIL-FR-092`'s lifecycle: `PROCESSING` would not be an observable state and `FIL-FR-094` progress would be meaningless |
| Amend `FIL-XC-017` to permit a local scheduler | ⛔ **Rejected.** Withdrawing a frozen requirement needs an ADR **and** a ranked authority. Neither exists, and the requirement turns out not to need amending |
| Amend the EA to move Job Runtime to V1 | ⛔ **Rejected.** The EA is descriptive (baseline L139), and the claim would be **false**: pools and queues really are V2 |
| Leave `FIL-GAP-015` open and defer V1 processing | ⛔ **Rejected.** Media optimization is V1 by the `MP-CON-08` ruling in `FIL-GAP-005`. Deferring it would silently descope a V1 capability |
| Make the port durable in V1 with a persisted queue table | ⛔ **Rejected** *for now*, and this was the closest call. It is real infrastructure, `FIL-FR-057`/`FIL-FR-083` make loss recoverable, and Phase 6 has not yet designed the schema. Revisit **with** the storage design, not ahead of it |

---

## 7. Consequences

**Positive.** V1 media processing is schedulable **without** violating a frozen requirement and without building a
V2 subsystem. `FIL-XC-017`'s port becomes real, which also retires one instance of the `B-7` class. The V2 runtime
is a **drop-in replacement for the adapter**, because the port is the stable surface.

**Negative / accepted.** The V1 adapter does **not** survive a process restart or distribute across instances
(§3.2). In-flight work is lost on restart and must be reprocessed — safe by `FIL-FR-057`/`FIL-FR-083`, but a real
operational limitation that must be stated in release notes rather than discovered. It also means **V1 media
processing is not suitable for multi-instance deployment** until the V2 runtime or a durable adapter arrives; that
constraint is a consequence of this decision and is recorded here as such.

**Not a consequence.** No boundary moved. No ownership migrated. No frozen requirement reworded. No event minted.
No tenancy rule created or relaxed. No File & Media module, schema or API created. Nothing verified.

---

## 8. Compliance

| Rule | Compliance |
|---|---|
| `FIL-XC-017` — no own pool/queue/scheduler/cron; consume the port | ✅ `BC-29` operates none and calls the port |
| `FIL-FR-093` — idempotent under an operation key; bounded retry; retry not scheduled here | ✅ Idempotency is in the port contract; the bound is a submitted parameter (§3.4, §3.5) |
| `FIL-FR-095` — no indefinite non-terminal state | ✅ Deadline is a port concept; expiry is terminal `FAILED` |
| `FIL-FR-092` — `RECEIVED → VALIDATING → PROCESSING → READY \| FAILED` | ✅ Asynchronous execution makes `PROCESSING` observable |
| `FIL-INV-013` — servable only in `READY` | ✅ Untouched; the port publishes no object |
| `FIL-FR-057`, `FIL-FR-083` — never sole copy; regenerable | ✅ The basis on which non-durability is survivable |
| BC Map §11 tenancy | ✅ The port carries **no** tenant identifier; it inherits ambient `TenantContext`. No global identity context receives one |
| Manifest L338 | ✅ Already declares the port. **No manifest edit** |
| `MP-NFR-04` — backpressure, queues | ⚠ **Partially deferred to V2 and disclosed**, not claimed |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Created `Accepted`. **Closes `FIL-GAP-015`** by identifying it as a **port-vs-runtime conflation** rather than a scheduling impossibility. The decisive measurement: **every child of EA "Job Runtime (V2)" — Background Jobs, Worker Pools, Queue Management, Retry & Backoff, Job Observability — is scaled *infrastructure*, and none of them is the *port*.** `FIL-XC-017` forbids `BC-29` from **operating** those and requires it to **consume** `platform/services:job_runtime`, which manifest **L338** already **declares**; so the V1 obligation is that the **interface exist**, which is precisely the `B-7` / `ADR-0012` shape the repository has already ruled on (*"five service ports are already declared … only the interfaces are missing"* → remedy: *"extract the interfaces"*). Authorises a `JobRuntime` **port** plus **one** in-process adapter following the existing `IdempotencyService` precedent in `platform/services`. ⛔ **No V2 infrastructure is built** — measured against the EA's own list: no worker pool, queue subsystem, distributed backoff, observability plane, cron, broker or daemon; **zero new packages, zero dependencies, zero deployment units.** ⚠ **The adapter's non-durability is disclosed in the port's own contract rather than discovered later**: a process restart loses in-flight work, and this is survivable **only** because FROZEN `FIL-FR-057` (a derivative is never the sole copy) and `FIL-FR-083` (regenerable) mean the worst case is reprocessing, never a lost original or a served partial — with `FIL-FR-095`'s `FIL-CFG-015` deadline guaranteeing no object sits non-terminal forever. **The V1 weakness lands exactly where the specification already has a recovery path**, which is why a lightweight adapter is defensible here and would not be for payments. ⚠ **A real operational limit is recorded as a consequence rather than omitted**: V1 media processing is **not suitable for multi-instance deployment** until a durable adapter or the V2 runtime arrives. ⚠ **A durable persisted-queue adapter was the closest rejected option** and is deliberately deferred to **Phase 6, with the storage design**, rather than decided ahead of it. **Retry stays the runtime's job** — `BC-29` submits only the bound from `FIL-CFG-014` (= 3, `ADR-0057` §2C.6) and never decides when an attempt happens, which is what keeps `FIL-XC-017` satisfied in substance and not merely in wording. **No requirement amended, no PRD touched, no EA edit** (it is descriptive and its V2 placement of the *subsystem* remains true), **no manifest edit** (L338 already declares the port), **no BC Map or matrix change, no baseline issued** (no Rank 1–3 version change). **0 tenancy rules created or relaxed — the port carries no tenant identifier and inherits ambient `TenantContext`. 0 File & Media modules, 0 schema, 0 SQL, 0 API, 0 Flutter code, 0 events minted, nothing verified.** |
