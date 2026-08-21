# ADR-0059 — `FIL-GAP-012` implementation half: `E-22`'s consumer list becomes **executable**, and stays a copy of the map

| | |
|---|---|
| **Status** | `Accepted` |
| **Version** | v1.0 |
| **Date** | 2026-08-20 |
| **Deciders** | **Architecture Owner** (the enforcement point and its location) |
| **Closes** | The **implementation half** of **`FIL-GAP-012`**. `B-11` fully resolved |
| **Opens** | Nothing |
| **Amends** | Nothing. No PRD, no BC Map, no matrix, no manifest, no EA. `FIL-XC-019`/`020`/`022` untouched |
| **Authorises** | A `files` port interface in `packages/liboora_contracts`, one in-process adapter, its registration, and an architecture test that reads `E-22` from the BC Map |

---

## 1. The question

`ADR-0055` amended `E-22`'s consumer cell to `BC-01, BC-10, BC-12, BC-14` (BC Map **v1.8**, **L331**), which closed
`FIL-GAP-012`'s **architecture** half. Its §5 was explicit that the other half stayed open, and `PRD-017` L1731
states why:

> ⛔ **Implementation half remains OPEN** — no `lib/` code implements `FIL-FR-006`'s consumer check … so the rule is
> specified and authorised but not *enforced*. `IMPL-1230`…`1236` are therefore unblocked **architecturally** and
> may not be marked done on that basis alone.

So the question is narrow: **what makes `FIL-FR-006` enforced rather than merely written?**

---

## 2. Evidence

| # | Source | What it establishes |
|---|---|---|
| 1 | `FIL-FR-006` (FROZEN, PRD-017 L~300) | *"SHALL serve a caller only where the caller's bounded context appears in `E-22`'s consumer list as recorded in BC Map §7.3. A caller whose context is absent **SHALL** be refused."* |
| 2 | `FIL-FR-007` (FROZEN) | *"SHALL NOT widen `E-22`'s consumer list, and SHALL NOT treat a port grant in `tool/module_dependencies.yaml` as authorising an edge the BC Map does not record."* |
| 3 | BC Map **L292** | *"If an edge is not in this table, it does not exist."* |
| 4 | BC Map **L331** (v1.8) | The consumer list, post-`ADR-0055`: `BC-01, BC-10, BC-12, BC-14` |
| 5 | Manifest **L242** | `domain/social` holds `platform/services:files` at **module** granularity — `GCP-23` |
| 6 | Manifest **L649** | `ADR-0012` exception: *"Five service ports are already declared (**files**, qr, idempotency, offline_sync, clock); only the interfaces are missing."* |
| 7 | `ADR-0055` §4.4 | *"No ownership moves… `FIL-XC-019`, `FIL-XC-020` and `FIL-XC-022` remain in force **unamended** and this ADR relies on them."* |
| 8 | Matrix §10.3 | Architecture tests must validate architecture; `no_orphan_ports_test.dart` requires exactly one registered implementation per declared port |

---

## 3. Findings

### 3.1 This is the same `B-7` shape as Phase 3, and the manifest already says so

Evidence 6 lists `files` among the five ports whose **interfaces are missing** — the identical sentence that
`ADR-0058` used to resolve `FIL-GAP-015` for `job_runtime`. The recorded remedy for that class is *"extract the
interfaces"*, not *"build the subsystem"*. `FIL-FR-006` is a rule about **who may call**, so the interface that is
missing is the one that can **refuse a caller**.

### 3.2 The enforcement point is the port, not the module — because there is no module

`BC-29` has no `lib/` implementation, and this ADR does not create one. That is not an obstacle: `FIL-FR-006`
governs the **boundary**, and the boundary exists as soon as the port does. Placing the check in the port's
contract means it is enforced for **every** future adapter, including the Supabase-backed one, rather than being
re-implemented (and eventually forgotten) in each.

### 3.3 The allowed set must be a **copy** of the map, never a second opinion

The subtle failure available here is to hard-code `{BC-01, BC-10, BC-12, BC-14}` in Dart and let it drift from
BC Map L331. That would create exactly the second-source-of-truth problem `no_orphan_ports_test.dart`'s header
warns about, and worse: a future ADR amending `E-22` would silently fail to take effect, while `FIL-FR-006` — which
was written to *read the register* — would appear satisfied.

Two mitigations are adopted, and the second is the load-bearing one:

1. The Dart set is documented as a **transcription** of L331 with its authority named inline.
2. **An architecture test parses `E-22`'s consumer cell out of the BC Map and asserts the code's set equals it.**
   Amend the map and the test tells you which code to change; change the code and the test tells you the map does
   not agree. Neither can move alone.

This is what makes the enforcement *architectural* rather than decorative, and it is the difference the `B-2`
instruction asks for: the test reads the **authority** and executes the **code**, so it cannot pass by agreeing
with prose about itself.

### 3.4 `FIL-FR-007` is enforced by the *shape* of the API, not by a comment

`FIL-FR-007` forbids widening the list and forbids treating a manifest port grant as an edge authorisation. Both
are honoured by giving the port **no** widening surface: the allowed set is a compile-time constant with no setter,
no `register`, no `allow()`, no constructor parameter. A caller cannot widen what it cannot address. This also
disposes of `GCP-23` **at the code boundary without repairing the manifest**: the manifest's module-grained grant
lets `domain/social` link the port, and the port then refuses `BC-11` and `BC-13` per-context — so the
context-grained map, not the module-grained manifest, decides. `GCP-23` remains disclosed and unrepaired as
`ADR-0055` left it; this ADR neither widens the manifest nor narrows it.

### 3.5 What the port must **refuse to know** — the `FIL-XC-019`/`020`/`022` line

`ADR-0055` §4.4 keeps eligibility with `BC-11`, message semantics with `BC-12`, moderation with `BC-13`. The
implementation must make that structural, so the boundary is enumerated as **absences**:

| The port does NOT accept or expose | Owner | Rule |
|---|---|---|
| Friendship, blocking, `canMessage`, any eligibility evaluation | `BC-11` Social Graph | `FIL-XC-019` |
| Message text, ordering, delivery/read receipts, conversation membership | `BC-12` Messaging | `FIL-XC-020` |
| Abuse reports, moderation verdicts, strikes, bans | `BC-13` Trust & Safety | `FIL-XC-022` |
| Public/anonymous sharing, share-by-link without a named recipient | — | `FIL-XC-021` |

`FIL-FR-076` requires the eligibility decision to be **recorded, not re-derived**: the port therefore accepts an
opaque **decision reference** and never a boolean it could have computed. A second `canMessage` evaluation could
disagree with the owner's, which is the `X-13` hazard `PRD-017` cites.

### 3.6 Tenancy: nothing is created, and `BC-10` is the reason it must not be

`E-22` already carries a **global-class** consumer (`BC-10`, admitted by `ADR-0016`) alongside tenant-scoped ones.
The port therefore **must not** carry a `tenantId`: a required tenant parameter would be unsatisfiable for `BC-10`
and would breach BC Map §11 / rule `ID-2` / frozen `TEN-FR-018`. Tenancy stays where `TenantPartitionedStore` and
ambient `TenantContext` already put it. **This ADR invents no `tenant_id` rule**, and `FIL-GAP-013` — whether
peer sharing is confined to co-members — remains **OPEN** and `BC-11`'s to answer.

### 3.7 What this does **not** decide

Not the storage model, not the schema, not the API surface, not any Flutter code, not `FIL-GAP-008` (retention,
legal), not `FIL-GAP-016` (video, refused), not `FIL-GAP-013`. No `FIL-*` identifier is minted — the registers
belong to FROZEN `PRD-017`, and `ADR-0057` §8.1a records what happens when an ADR forgets that.

---

## 4. Decision

1. **`FIL-GAP-012` is CLOSED in full.** Its architecture half was closed by `ADR-0055`; its implementation half is
   closed here. **`B-11` is resolved.**
2. **A `files` port is defined** in `packages/liboora_contracts` (`src/ports/file_access.dart`), extracting the
   interface the manifest already declares at **L242** and already records as missing at **L649**.
3. **`E-22`'s consumer list is expressed as a compile-time constant** with no widening surface, documented as a
   transcription of BC Map **L331**, and **pinned to the map by an architecture test that parses the map**.
4. **A caller outside the list is refused** with `DomainErrorCode.forbidden`, and the refusal is
   indistinguishable from "absent" per `FIL-FR-094` — no reason string names the edge, the list, or the object.
5. **One in-process adapter** is provided in `lib/platform/services/` and **registered at the composition root**,
   following the `IdempotencyService` and `InProcessJobRuntime` precedents.
6. **No ownership moves into `BC-29`.** `FIL-XC-019`/`020`/`022` are relied upon and unamended; the port accepts an
   opaque eligibility **decision reference** and never evaluates eligibility.
7. **No tenancy rule is created or relaxed.** The port carries no tenant identifier (§3.6).
8. **No document is amended.** No PRD, BC Map, matrix, manifest or EA edit. **No baseline re-issue** — no Rank 1–3
   version change.
9. **`IMPL-1230`…`1236` remain not-done.** This ADR removes the *architectural* and *enforcement* blockers; it does
   not implement storage, schema or API, and nothing may be marked done on the strength of this record.

---

## 5. What this ADR does NOT rest on

It does **not** rest on the manifest's L242 grant as authority — `FIL-FR-007` explicitly denies that reading, and
this ADR applies the denial rather than quietly benefiting from it. It does **not** rest on `BC-29` having a module
(it has none). It does **not** rest on any claim that `BC-11` or `BC-13` should be admitted — they were tested and
refused by `ADR-0055` §3, and this ADR **enforces** that refusal rather than revisiting it.

---

## 6. Options considered

| Option | Verdict |
|---|---|
| Hard-code the consumer set in Dart, no test against the map | ⛔ Rejected — §3.3: creates a second source of truth that can silently disagree with a Rank 4 register |
| Parse the BC Map at **runtime** to build the set | ⛔ Rejected — R0 law L5 forbids `dart:io` in contracts, and a production path that reads a markdown file is worse than the drift it prevents |
| Constant + **test that parses the map** | ✅ **Adopted** — drift becomes a red test, not a latent defect |
| Enforce in each future adapter instead of the port | ⛔ Rejected — re-implemented per adapter, so the guarantee decays to whichever adapter was written last |
| Enforce in a `BC-29` module | ⛔ Rejected — no such module exists, and creating one is Phase 5–6 work, not an enforcement decision |
| Take a `bool eligible` from the caller | ⛔ Rejected — `FIL-FR-076` requires the decision **recorded, not derived**; a boolean invites `BC-29` to compute it (`X-13`) |
| Add `BC-11`/`BC-13` so `domain/social` "just works" | ⛔ Rejected — reverses `ADR-0055` §4.3 without an ADR, and widens an edge two contexts fail the necessity test for |
| Widen manifest L242 to context granularity | ⛔ Rejected — `ADR-0055` §6 already considered and disclosed this as `GCP-23`; repairing it is not this ADR's act |

---

## 7. Consequences

✅ `FIL-FR-006` is **enforced**, not merely specified. A `BC-11` or `BC-13` caller is refused **by code**, which is
what `ADR-0055` §4.3 decided and could not itself make true.

✅ `E-22` cannot drift from its implementation in either direction without a red test.

⚠ **`GCP-23` is unchanged.** The manifest still grants at module granularity. The port now makes that grant
*harmless* — a `domain/social` caller links the port and is refused unless it presents `BC-12` — but the
asymmetry in the documents remains disclosed, not erased.

⚠ **This does not make PRD-017 `VERIFIED`.** 0 of 96 acceptance criteria are proven by a test of a real storage
implementation, and `FROZEN` still is not `VERIFIED`. What is now true is narrower and stated exactly: the
`E-22` consumer rule is executable and tested.

⚠ **The adapter stores nothing durable.** It is an enforcement point plus an in-memory reference table, not a
storage backend. Phase 6 decides storage.

---

## 8. Compliance

| Rule | Compliance |
|---|---|
| `FIL-FR-006` — serve only listed contexts; refuse the absent | ✅ Enforced in the port; refusal tested |
| `FIL-FR-007` — never widen; a port grant is not an edge | ✅ No widening surface exists (§3.4) |
| `FIL-FR-076` — eligibility **recorded**, not derived | ✅ Opaque decision reference; no boolean, no evaluation |
| `FIL-XC-019` / `020` / `022` | ✅ Relied upon and unamended; enumerated as absences (§3.5) and asserted by test |
| `FIL-XC-021` — no public/anonymous/link-without-recipient | ✅ A grant requires a named recipient by signature |
| `FIL-FR-094` — refusal leaks nothing | ✅ No reason string names the edge, list or object |
| BC Map **L292**, **L331** | ✅ Transcribed, and pinned to the map by a parsing test |
| BC Map §11 tenancy · `TEN-FR-018` · rule `ID-2` | ✅ Port carries **no** tenant identifier (§3.6) |
| Manifest **L242** / `GCP-23` | ⚠ Unrepaired and disclosed; made harmless at the code boundary |
| Matrix §10.3 | ✅ One registered implementation at the composition root |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Created `Accepted`. **Closes the implementation half of `FIL-GAP-012`, resolving `B-11` in full.** Identifies the gap as the **same `B-7` / `ADR-0012` shape** Phase 3 resolved: manifest **L649** already records that `files` is one of *"five service ports … only the interfaces are missing"*, so the remedy is *"extract the interfaces"* — and because `FIL-FR-006` is a rule about **who may call**, the missing interface is the one that can **refuse a caller**. Authorises a `files` port, one in-process adapter, and its registration. ⭐ **The decisive design choice is that the allowed-consumer set is a *copy* of BC Map L331 that cannot silently diverge from it**: a hard-coded Dart set would be a second source of truth, and a future ADR amending `E-22` would fail to take effect while `FIL-FR-006` — written to *read the register* — appeared satisfied. So an architecture test **parses `E-22`'s consumer cell out of the BC Map** and asserts equality with the code, meaning neither can move alone. `FIL-FR-007` is enforced by the **shape** of the API rather than by a comment: the set is a compile-time constant with no setter, no `allow()`, no constructor parameter, so a caller cannot widen what it cannot address. **`FIL-XC-019`/`020`/`022` are relied upon and unamended** and enumerated as **absences** — no eligibility, no `canMessage`, no message text, ordering or receipts, no moderation — with `FIL-FR-076` honoured by accepting an **opaque decision reference** rather than a boolean the module could have computed (the `X-13` hazard). ⚠ **`GCP-23` is deliberately NOT repaired**: the manifest keeps its module-grained grant and the port makes it *harmless* by refusing `BC-11` and `BC-13` per context, so the context-grained map decides — the asymmetry stays **disclosed**, as `ADR-0055` left it. **0 tenancy rules created — the port carries no tenant identifier**, and it must not: `E-22` already serves the **global-class** consumer `BC-10` (`ADR-0016`), so a required tenant parameter would be unsatisfiable there and would breach BC Map §11, rule `ID-2` and frozen `TEN-FR-018`; `FIL-GAP-013` stays **OPEN** and `BC-11`'s to answer. **No `FIL-*` identifier minted** — those registers belong to FROZEN `PRD-017`, per `ADR-0057` §8.1a. **No requirement amended, no PRD touched, no BC Map edit, no manifest edit, no EA edit, no matrix change, no baseline issued.** ⚠ **`IMPL-1230`…`1236` remain NOT DONE** — this removes the enforcement blocker and nothing more. ⚠ **`FROZEN` is still not `VERIFIED`**: 0 of 96 acceptance criteria are proven against a real storage implementation; the narrower true claim is that the `E-22` consumer rule is now **executable and tested**. **0 aggregates, 0 events, 0 schema, 0 SQL, 0 API, 0 Flutter code.** |
