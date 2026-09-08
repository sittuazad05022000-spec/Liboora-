# `PRD-018` — STAGE-1 DISCOVERY PREPARATION (Offline Sync, `BC-30`)

| Field | Value |
|---|---|
| **Document** | `PRD-018_STAGE1_DISCOVERY_PREPARATION.md` |
| **Version** | **v1.1** — ⭐ *§8.1 added: **Option B received** from the Product Owner. All v1.0 Stage-1 measurements preserved verbatim* |
| **Date** | 2026-09-07 |
| **Subject** | `PRD-018` Offline Sync — **`BC-30`** |
| **Written at** | `284d4f699fb01566b8edf6ac8fc572976b7ee643` (`github/main`) |
| **Type** | **Decision-preparation record.** It audits authority, states the Stage-1 questions with measured answers, and sets out options and trade-offs |
| **Act** | 🔍 **PREPARATION + DECISION RECORD.** ⛔ **Not** a PRD · **not** an ARB ruling · **not** a freeze · **not** a baseline · **not** a conferral · **not** a BC Map amendment |
| **Decision authority exercised** | ⭐ **Product Owner scope selection RECEIVED and RECORDED (§8.1) — Option B.** ⛔ **No** Architecture Owner authority is exercised, and **no Rank-4 change is executed** |
| **Approvals asserted** | ⭐ Product Owner decision **recorded**. ⛔ **No** Architecture Owner approval, ARB ruling, Security or Privacy review is claimed |
| **ADRs created / Accepted** | ⚠ **One created — [`ADR-0114`](../../00-governance/adr/ADR-0114-offline-sync-is-a-capability-of-bc-03-attendance.md), status `PROPOSED`.** ⛔ **0 accepted. NOT self-accepted** |
| **Subject document** | ⛔ **DOES NOT EXIST.** Measured: **0** `PRD-018` *specification* documents under `docs/` — the only `*PRD-018*` file is **this preparation record**, which is not a PRD |
| **Implementation authorised** | ⛔ **NO** — see §7 |
| **Scope of the capability** | ⭐ **ATTENDANCE ONLY** (`BC-03`). ⛔ Not fees, payments, financial ledger, membership, library operations, any other bounded context, or any future workflow |
| **Final status** | ⭐ **OPTION B SELECTED (§8.1).** ⚠ **Rank-4 BC Map disposition and the registry limb remain OPEN and are ROUTED** — Architecture Owner (`Q-1`/`Q-2`), Governance Owner (`Q-3`). `PRD-018` stays **`PLANNED`** |

> ⚠⚠ **READ THIS FIRST.** This document exists because `PRD-018`'s **Stage-1 Discovery gate cannot be
> answered "yes" on the current evidence**, and the failing answer is the one Discovery was written to
> catch. `PRD_LIFECYCLE.md` Stage 1 asks *"Does it own an aggregate and an invariant?"* and warns:
> *"Owning neither ⇒ **it is a capability of an existing context**"*, under the heading *"**The
> commonest wrong outcome is a PRD that should not exist.**"*
>
> ⛔ This document **does not decide** whether `PRD-018` should exist. It measures, presents three
> options, and stops.

---

## 1. Measured repository facts

⭐ Every row below is a **measurement taken at the commit named in the header**, with file and line.
Nothing in this section is inference, recommendation or judgement.

### 1.1 `PRD-018` is `PLANNED`, and the document does not exist

| Fact | Evidence |
|---|---|
| Registry status is **`PLANNED`** | `PRD_REGISTRY.md` **L318** — `` \| `PRD-018` \| Offline Sync \| **`BC-30`** \| `[GENERIC]` \| V1 \| `PLANNED` \| *"Attendance capture in a basement with no signal"* \| `` |
| **The PRD document does not exist** | Measured: **1** file matches `*PRD-018*` under `docs/` — **this preparation record alone**. There is **0** `PRD-018` specification document. ⚠ Stated this way deliberately: once this file exists the naive glob count is no longer 0, and a future reader must not mistake this record for the PRD |
| No stage is established | A stage requires a version/status header. No document ⇒ **no stage**, not "Stage 0" |
| Ownership roles are assigned | `PRD_OWNERSHIP_MODEL.md` **L200** — Product Owner **Services Platform** · Approver **ARB** · Implementer **Platform Engineering** |

### 1.2 The four Stage-1 Discovery questions, with measured answers

`PRD_LIFECYCLE.md` §3 Stage 1. **Gate:** *"a context identified in the Bounded Context Map, **not
already owned** in `PRD_REGISTRY.md` §6."*

| # | Question (verbatim) | Measured answer | Evidence |
|---|---|---|---|
| **1** | *"Does a bounded context own this?"* | ✅ **YES** — `BC-30` **Offline Sync** exists | BC Map **L139**: `` \| **BC-30** \| **Offline Sync** \| `[GENERIC]` \| Platform Services \| V1 \| Owns the client mutation queue, replay, conflict detection and resolution policy. \| `` |
| **2** | *"Does another PRD already own the context?"* | ✅ **NO** — `BC-30` is unowned | `PRD_REGISTRY.md` **L462** lists `BC-30` among contexts whose PRDs are *"(unwritten `PRD-004`…`021`)"* |
| **3** | *"Is it V1/V2/V3, or Future?"* | ✅ **V1** — not Future, so Discovery does not stop here | `PRD_REGISTRY.md` **L318**; BC Map **L139** |
| **4** | *"Does it own an aggregate and an invariant?"* | ⛔ **NO — measured 0 and 0** | BC Map **§8**: **0** `BC-30` aggregate rows. BC Map **§9**: **0** `BC-30` producer/event rows |

⛔ **Question 4 is the only failing answer, and it is the decisive one.** Its stated failure
consequence is not "write the PRD anyway" — it is *"**it is a capability of an existing context**"*.

⚠ **Counting method, stated so it can be re-run.** §8 rows were counted by extracting the block
between the `## 8.` and `## 9.` headings and matching `BC-30`; §9 rows likewise between `## 9.` and
`## 10.`. Both returned **0**. Anyone may reproduce this.

### 1.3 The one declared edge

| Fact | Evidence |
|---|---|
| **`E-24`** is the **only** edge touching `BC-30` (measured: 1) | BC Map **L333** — `` \| E-24 \| BC-03 Attendance \| BC-30 Offline Sync \| `CF` \| Sync port \| Attendance defines the conflict-resolution policy; Sync executes it \| `` |

⭐ **Read `E-24`'s contract cell carefully — it bears directly on question 4.** It states that
**Attendance defines the policy** and **Sync merely executes it**. A context that executes another
context's policy, owns no aggregate and emits no event is precisely the shape question 4 is testing
for. ⚠ This is an **observation about the evidence**, not a conclusion; see §5 option (b).

### 1.4 Governance constraints already in force

| # | Constraint | Source | Effect on `PRD-018` |
|---|---|---|---|
| **C1** | *"Cash payment is supported, but financial recording MUST remain online/server-authoritative. Physical cash may be offline, but the app **MUST NOT** perform an offline financial write, queue, local financial ledger, or later sync."* — *"Therefore **do NOT create a `BC-05` → `BC-30` dependency edge** and do NOT create `BC-32`."* | **`ACCEPTED` `ADR-0037`** | ⛔ **Financial offline capture is already OUT OF SCOPE and may not be re-opened by `PRD-018`.** A Product Owner act, so scope is bounded before drafting begins |
| **C2** | *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."* | BC Map **L292** (Rank 4) | Any consumer beyond `BC-03` requires an **ADR**, not a PRD sentence |
| **C3** | **`MP-ASM-03`** — *"Libraries operate with intermittent connectivity; offline attendance capture is required."* Mitigation column: *"**Offline Sync could be deferred.**"* | `MASTER_PRD.md` **L537** (Rank 1) | ⭐ **Deferral is expressly contemplated by the Rank-1 document.** Option (c) in §5 is not an evasion |
| **C4** | *"`BC-30` Offline Sync — Attendance capture in a basement with no signal — EA critique #9."* | `MASTER_PRD.md` **L195** | The recorded product driver, and it is **attendance-shaped**, not general-purpose |
| **C5** | Stage-2 gate requires *"a document with a version/status header, and its identifier registers declared **up front** with ranges"*, prefixes checked against **every** existing register **before** writing (`PRD_LIFECYCLE.md` §5 rules 1–4) | `PRD_LIFECYCLE.md` | No prefix may be chosen until Stage 1 is answered |

### 1.5 ⚠ Existing code precedes requirements — disclosed, **not fixed**

⛔ **This section reports. It repairs nothing.** No production code or test was modified by this
document, and none may be modified until the §8 decision is taken.

`lib/platform/services/services.dart` already contains an Offline Sync scaffold:

| Element | Location | Measured state |
|---|---|---|
| `enum SyncState { synced, queued, conflicted }` | **L29** | Declared |
| `final class OfflineSyncEngine` | **L50** | `queue` (a plain `List`), `online` flag, `enqueue`, `pendingCount`, `flush()` |
| One live producer | `lib/domain/library/attendance/attendance.dart` **L125** | `sync.enqueue(QueuedMutation(...))`, guarded by `if (!sync.online)` — the real `E-24` path |
| One consumer | `lib/app/shared/session.dart` **L301** | `await container.sync.flush()` |

**Measured against BC Map L139's four stated ownerships:**

| `BC-30` owns (L139) | Implemented? | Measurement |
|---|---|---|
| *"client mutation queue"* | ⚠ **Partially** | An **in-memory `List`**. No persistence, so queued mutations are **lost on process restart** |
| *"replay"* | ⛔ **No** | `flush()` iterates the queue and sets each item to `synced`. **No transport of any kind** — measured **0** HTTP/URI/client references in the file. Nothing is replayed anywhere |
| *"conflict detection"* | ⛔ **No** | `SyncState.conflicted` is **declared** and **assigned 0 times** anywhere in `lib/` |
| *"resolution policy"* execution | ⛔ **No** | No policy is received, held or executed |

**Test coverage: measured 0.** No test file matching `*sync*` or `*offline*` exists, and `test/`
references `OfflineSyncEngine`, `SyncState` and `QueuedMutation` **zero** times.

⚠⚠ **Why this matters to Stage 1 specifically.** The presence of a class named `OfflineSyncEngine`
could be mistaken for evidence that `BC-30` is already a real context with real behaviour. Measured,
**two of its four stated ownerships are entirely absent** and a third has no transport. It is a
**demo scaffold that makes the UI's offline indicator work**, not an implementation. ⛔ **It must not
be treated as satisfying any requirement, and it must not be cited as a reason `PRD-018` is already
half-done.**

### 1.6 ⚠ Manifest gap affecting the module that holds this code

| Fact | Evidence |
|---|---|
| `platform/services` is **ranked 3** | `tool/module_dependencies.yaml` **L33** |
| Its ports are consumed, including `offline_sync` | **L113**, **L527** |
| ⛔ It has **no module block** | Measured: **0** occurrences of a top-level `platform/services:` block. Its `imports`, `banned_imports` and assertions are therefore **undeclared and unenforced** |
| Already recorded elsewhere | `PRD-017` carries this as **`FIL-GAP-010`** — *"`platform/services` has no module block in the manifest, so the boundary is unenforced"* |

⚠ **Relevance:** `OfflineSyncEngine` lives in `platform/services`. Whatever §8 decides, any future
implementation would sit inside a module whose boundary the checker cannot currently govern. ⛔ This
document **does not amend the manifest** and opens no identifier — `FIL-GAP-010` belongs to FROZEN
`PRD-017` and only its owner may widen it.

---

## 2. What is NOT known, and is not invented here

⛔ Per `PRD_LIFECYCLE.md` and the precedent of `ADR-0045` (*"A named hole is honest; an invented
contract is not"*), the following are **absent from the repository** and are **not supplied** by this
document:

- ⛔ No requirement, identifier, prefix or register for `PRD-018` — **none is proposed**
- ⛔ No aggregate, invariant, event, edge or port is minted for `BC-30`
- ⛔ No conflict-resolution algorithm, queue durability model, retry policy, backoff schedule, replay
  ordering rule or conflict taxonomy — the repository specifies **none**
- ⛔ No NFR: no queue depth, retention window, sync latency, battery or storage budget
- ⛔ No backend, transport, storage engine, schema or provider — and note that **the V1 backend
  runtime is itself unapproved** (`MASTER_PRD.md` **L227** reads *"Not named in EA — candidate
  only"*), so a durable queue has no approved place to sync **to**

---

## 3. Governance constraints on this document itself

| Constraint | Honoured |
|---|---|
| Do not modify frozen PRDs | ✅ **0** changes to any PRD |
| Do not modify accepted ADRs | ✅ **0** changes; ADR count **101**, unchanged |
| Do not modify the BC Map (Rank 4) | ✅ byte-unchanged |
| Do not modify `MASTER_PRD.md` (Rank 1) | ✅ byte-unchanged |
| Do not modify the module manifest | ✅ byte-unchanged |
| Do not change production code or tests | ✅ **0** changes to `lib/`, `test/`, `tool/` |
| Do not create or accept an ADR | ✅ **0** created; see §6 for when one would be required |
| Do not create `PRD-018` | ✅ not created |
| Do not decide | ✅ **0** decisions; see §8 |

---

## 4. Precedent — how the repository has handled a zero-aggregate context before

⭐ **`BC-30` is not the first context to reach a PRD gate owning no BC Map §8 aggregate.**

`PRD-017` File & Media faced the identical fact for `BC-29` and proceeded **by recording it as a
deliberate, named gap rather than by minting an aggregate**:

> *"**Owned aggregate | NONE ASSERTED** — see §6.1 and `FIL-GAP-001`. BC Map §8 lists **17**
> aggregate rows and `BC-29` is **not among them** (measured: 0). This document does **not** mint
> one."*

⚠ **Two things this precedent does and does not establish.**

- ⭐ It **does** establish that proceeding with zero aggregates is **lawful**, provided the absence is
  measured, published and carried as an open gap.
- ⛔ It does **not** establish that proceeding is **automatic**. `PRD-017` was written because two
  **frozen** Rank-3 PRDs (`LIB-6.6`, `SID-4.35`) were **already consuming** `BC-29`, so the context
  was load-bearing whether or not it held an aggregate. **Whether an equivalent forcing condition
  exists for `BC-30` is a question of product fact, and it is part of the §8 decision** — the
  measured position is that `BC-30` has exactly **one** declared consumer (`E-24`, `BC-03`).

---

## 5. Options and trade-offs

⛔ **None of these is accepted. They are presented for the Product Owner's decision at §8.**

### Option (a) — Proceed with `PRD-018`, recording zero aggregate/event ownership as a deliberate gap

| | |
|---|---|
| **What it means** | Enter Stage 2, publish the `BC-30` §8/§9 absence as a named `*-GAP-*` finding on the `FIL-GAP-001` model, and **mint nothing** |
| **For** | ⭐ Follows an established, lawful precedent. Gives `BC-30` a written specification that the current scaffold demonstrably lacks. Makes the four L139 ownerships testable instead of notional |
| **Against** | ⚠ Question 4's stated consequence points the other way, and the precedent's forcing condition (multiple frozen consumers) is **not** present — `BC-30` has **one**. ⚠ The specification would be written against an **unapproved backend** (`MASTER_PRD.md` L227), so durability and replay could not be fully specified. ⚠ Cost is real: `PRD-017` carries **232** identifiers |
| **Consequential** | May surface a BC Map §8/§9 amendment question → then an **ADR** is required (§6) |

### Option (b) — Treat Offline Sync as a capability of `BC-03` Attendance; write no PRD

| | |
|---|---|
| **What it means** | Accept question 4's stated consequence. Offline behaviour is specified inside Attendance's own PRD/amendment; `PRD-018` is not written |
| **For** | ⭐ This is the outcome Stage 1's own text points to. ⭐ **`E-24`'s contract cell already says Attendance owns the policy and Sync only executes it.** ⭐ `MASTER_PRD.md` L195's driver is **attendance-shaped** — *"Attendance capture in a basement with no signal"*. ⭐ `ADR-0037` has already removed the other plausible consumer (finance) |
| **Against** | ⚠ `BC-30` **is** a registered context at BC Map L139 with a `[GENERIC]` classification and a V1 marker; treating it as a capability leaves a registered context permanently unowned, which the registry and the BC Map would then disagree about. ⚠ Likely requires a **BC Map amendment** to retire or re-scope `BC-30` → **ADR** (§6). ⚠ `PRD_REGISTRY.md` L318 would need a status change |
| **Consequential** | Almost certainly triggers §6's ADR condition |

### Option (c) — Defer Offline Sync

| | |
|---|---|
| **What it means** | Take no Stage-1 decision now; `PRD-018` stays `PLANNED`; nothing is written, retired or amended |
| **For** | ⭐ **Expressly contemplated by Rank 1**: `MP-ASM-03`'s own mitigation column reads *"Offline Sync could be deferred."* ⭐ Costs nothing and forecloses nothing — options (a) and (b) both remain open. ⭐ The single real consumer already degrades without crashing: `attendance.dart` L125 queues when offline. ⭐ The backend that a durable queue would sync **to** is itself undecided |
| **Against** | ⚠ The scaffold's limitations in §1.5 **persist and stay untested** — in particular, **queued mutations are lost on restart**, which is a silent data-loss path in the exact basement scenario L195 describes. ⚠ Deferral is not free if a library actually relies on offline capture today |
| **Consequential** | ⛔ **No ADR required.** Nothing is amended |

⚠ **A note on scope, true under all three options.** `ADR-0037` (**ACCEPTED**) already bars offline
financial write, queue, local ledger and later sync, and bars a `BC-05 → BC-30` edge. ⛔ **No option
above may re-open that**, and this document does not.

---

## 6. When an ADR would be required

⭐ **An ADR is required if — and only if — the eventual Product Owner decision amends the Rank-4
BC Map or another governed architectural decision that needs ADR treatment.**

| Decision path | ADR required? | Why |
|---|---|---|
| **(c) Defer** | ⛔ **No** | Nothing is amended. The registry keeps `PLANNED` |
| **(a) Proceed**, minting nothing and recording the gap | ⚠ **Not for Stage 1 itself** | The `PRD-017`/`FIL-GAP-001` precedent added no aggregate. An ADR becomes required only if drafting later needs a **new edge** (BC Map **L292**) or a **§8/§9 amendment** |
| **(a) Proceed**, adding a `BC-30` aggregate or event | ✅ **YES** | Amends the **Rank-4** BC Map. `DOCUMENTATION_BASELINE.md` §7 rule 1: *"A change to any Rank 1–5 document requires an ADR **before** the change"* |
| **(b) Capability of `BC-03`** | ✅ **Almost certainly YES** | Retiring or re-scoping a registered context is a Rank-4 change, and `PRD_REGISTRY.md` L318 would move off `PLANNED` |

**Deciding authority.** The Stage-1 question — *should this PRD exist?* — is a **product-scope**
question, and `PRD_OWNERSHIP_MODEL.md` **L200** names the **Product Owner** for `PRD-018`. Any
resulting **Rank-4 BC Map amendment** is the **Architecture Owner / ARB**'s act, requiring its own
`ACCEPTED` ADR. ⛔ **Neither authority is exercised here, and no ADR number is reserved.**

---

## 7. ⛔ IMPLEMENTATION IS NOT AUTHORISED

**No Offline Sync production code may be written on the strength of this document.**

| Reason | Evidence |
|---|---|
| There are **zero requirements** to implement against | **0** `PRD-018` specification documents exist; this preparation record states **no** requirement |
| Stage 1 is **not satisfied** | Question 4 measured **0** aggregates, **0** events (§1.2) |
| Writing code now would **resolve the Stage-1 question by implementation** | The failure mode `PRD_LIFECYCLE.md` Stage 1 exists to prevent |
| The backend a durable queue would sync to is **unapproved** | `MASTER_PRD.md` **L227** — *"Not named in EA — candidate only"* |
| The module holding the code has **no manifest block** | §1.6 |

⛔ **Only audit and design work is authorised.** ⛔ **The §1.5 scaffold defects must NOT be "fixed"
as a side effect** — repairing an unspecified component is implementation without requirements, and
would make the Stage-1 decision harder to take honestly by creating sunk work.

---

## 8. DECISION REQUIRED — Product Owner

> ⛔⛔ **DECISION REQUIRED — Product Owner**
>
> **Question:** Given that `BC-30` Offline Sync is a registered **V1** context in the BC Map (**L139**)
> and is unowned by any PRD (**L462**), but owns **0 aggregates** (BC Map §8) and **0 events**
> (BC Map §9), should `PRD-018` be written?
>
> | | Option | Selected |
> |---|---|---|
> | **(a)** | **Proceed** with `PRD-018`, recording the zero aggregate/event ownership as a deliberate, named gap on the `PRD-017` / `FIL-GAP-001` precedent | ☐ |
> | **(b)** | **Treat Offline Sync as a capability of `BC-03` Attendance** and do not create a PRD | ☐ |
> | **(c)** | **Defer** Offline Sync, as `MP-ASM-03` expressly contemplates | ☐ |
>
> **Decided by:** ............................................ *(role: **Product Owner**, `PRD_OWNERSHIP_MODEL.md` **L200**. ⛔ No personal name is to be recorded — `PRD_OWNERSHIP_MODEL.md` §7 rule 4)*
> **Date:** ............................
>
> ⚠ **If (a) or (b) is chosen and the choice amends the Rank-4 BC Map, an `ACCEPTED` ADR by the
> Architecture Owner is required BEFORE the amendment** (§6).

⚠⚠ **THE FORM ABOVE IS PRESERVED EXACTLY AS IT WAS PUT TO THE PRODUCT OWNER, WITH ITS BOXES STILL
BLANK — DELIBERATELY.** It is the **question as asked**, and back-filling a tick into it would rewrite
the record of what was presented. **The answer received is recorded separately in §8.1 below**, which is
the `14A` separation pattern `PRD_LIFECYCLE.md` §7 uses for exactly this reason: *"findings go in a
**separate** record so the capture stays auditable."*

*(Original v1.0 note, retained verbatim because it was true when written: ⛔ "This document records no
selection. The boxes above are blank on purpose; a pre-ticked box would be a fabricated decision.
⛔ A blank form is not a decision, on the same principle `PRD-015`'s preparation record states for its
own conferral template.")*

---

## 8.1 ⭐ DECISION RECEIVED — v1.1, 2026-09-07

> ### DECISION
>
> ⭐ **OPTION B SELECTED — Offline Sync is a capability of `BC-03` Attendance.**
>
> It is **NOT** an independent standalone bounded context requiring a `PRD-018` specification.
> **`PRD-018` is not to be written.**
>
> **Decided by:** **Product Owner** *(role only — `PRD_OWNERSHIP_MODEL.md` **L200**, §7 rule 4;
> ⛔ no personal name recorded)* · **Date:** 2026-09-07

> ### CURRENT SCOPE
>
> ⭐ **ATTENDANCE ONLY.**
>
> ```
> BC-03 Attendance
> └── Offline Sync capability   ◄ Attendance-related offline behaviour only
> ```
>
> ⛔ It is **NOT** to be generalised into a platform-wide generic synchronisation mechanism.

> ### NON-SCOPE — not authorised
>
> | ⛔ Not authorised for | Context |
> |---|---|
> | Fees · Payments · Financial ledger | `BC-05` — **also independently barred by `ACCEPTED` `ADR-0037`** |
> | Membership | `BC-02` |
> | Library operations | `BC-01`, `BC-04`, `BC-06`… |
> | Any other bounded context | any `BC-nn` other than `BC-03` |
> | Any future domain workflow | not yet named |

> ### FUTURE EXTENSION
>
> ⛔ Any future bounded-context use **requires a separate architecture/governance evaluation** and its own
> `ACCEPTED` ADR **before** being connected to or extending this capability.
> ⭐ `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."*

> ### IMPLEMENTATION STATUS
>
> ⛔ **NOT AUTHORISED by this task.** §7 stands unchanged and unweakened.

### 8.2 ⚠ What the decision does NOT execute, and why

⭐⭐ **A Product Owner scope selection is lawful, and it is still not self-executing.** The consequent
change lands on the **Rank-4** BC Map, which three rules reserve to a different authority:

| Rule | Source |
|---|---|
| *"Ownership or boundary change \| **ADR**"* | `PRD_LIFECYCLE.md` **L174** |
| *"A decision that changes structure, ownership, a boundary… requires an **ADR** before implementation"* | `ADR-INDEX.md` Process step 1 |
| *"A change to any Rank 1–5 document requires an **ADR** before the change"* | `DOCUMENTATION_BASELINE.md` **L379** |
| *"ADR approval; any Rank 1–5 document change"* → **Architecture Owner** | `PRD_OWNERSHIP_MODEL.md` **L85** |

**Therefore, as of v1.1 — measured, not asserted:**

| Artifact | State | Why |
|---|---|---|
| **BC Map** (Rank 4) | ⛔ **byte-unchanged** | `BC-30` disposition routed to the Architecture Owner |
| **`PRD_REGISTRY.md`** | ⛔ **byte-unchanged — `PRD-018` remains `PLANNED`** | §2's closed vocabulary holds **nine** values and **`RETIRED` is not one**; writing one would invent a governance value |
| **`E-24`** | ⛔ unchanged, still declared | Its fate depends on the BC Map disposition |
| **`ADR-0037`** | ⛔ unchanged, still binding | No `BC-05` → `BC-30` edge created or implied |
| **`OfflineSyncEngine`** | ⛔ untouched, **0 lines** | §7 |

⚠ **`BC-30` therefore still exists in the BC Map today, and `PRD-018` is still `PLANNED`.** That is a
visible inconsistency with the decision above, and it is **stated rather than smoothed over**: it is the
honest state until the Architecture Owner acts.

**Recorded and routed by:** [`ADR-0114`](../../00-governance/adr/ADR-0114-offline-sync-is-a-capability-of-bc-03-attendance.md)
— ⛔ **`PROPOSED`, NOT accepted, and NOT self-accepted.** Its open items are `Q-1` BC Map disposition ·
`Q-2` `E-24` · `Q-3` the registry vocabulary defect · `Q-4` index registration · `Q-5` where the
Attendance-only requirements are written.

---

## 9. What this document does NOT do

- ⭐ **Records the Product Owner's Option B selection (§8.1); it does not EXECUTE it.** The consequent Rank-4 BC Map change is **routed, not performed**
- ⛔ **Does not amend the BC Map**, retire `BC-30`, or withdraw `E-24` — all three are Architecture Owner acts (`Q-1`, `Q-2`)
- ⛔ **Does not change `PRD_REGISTRY.md`** — `PRD-018` remains **`PLANNED`**, because §2's closed nine-value vocabulary admits **no** terminal status (`Q-3`)
- ⛔ **Accepts no ADR.** `ADR-0114` is **`PROPOSED`** and **not self-accepted**
- ⛔ **Does not create `PRD-018`**, reserve a prefix, or mint any identifier
- ⚠ **Creates exactly ONE ADR — `ADR-0114`, `PROPOSED`** *(v1.0 read "creates no ADR"; that was true at v1.0 and is corrected rather than deleted)*. ⛔ It is **not accepted**, so it amends nothing and is in force nowhere
- ⛔ **Amends no ranked document** — BC Map, `MASTER_PRD.md`, `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `ADR-INDEX.md`, every frozen PRD, every **accepted** ADR and `tool/module_dependencies.yaml` are all **byte-unchanged**
- ⛔ **Changes no production code and no test** — the §1.5 scaffold defects are **disclosed and left in place**
- ⛔ **Invents no** requirement, aggregate, invariant, event, edge, port, conflict algorithm, durability model, NFR, schema, backend or provider
- ⛔ **Silently resolves no contradiction** — §1.5 (code before requirements), §1.6 (manifest gap) and the `MP-ASM-03`-versus-V1 tension are each **stated and left open**
- ⛔ **Confers no lifecycle stage.** `PRD-018` remains **`PLANNED`** and is **not to be written**; ⚠ Stage 1's *gate* is not "satisfied" — it is **answered in the negative**, which is the outcome `PRD_LIFECYCLE.md` warns is the commonest correct one
- ⛔ **Authorises no offline behaviour beyond Attendance**, and grants no standing licence for future cross-context use
- ⛔ **Does not re-open `ADR-0037`**, which bars offline financial capture

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-09-07 | ⭐⭐ **OPTION B RECEIVED AND RECORDED (§8.1).** The Product Owner selects: **Offline Sync is a capability of `BC-03` Attendance**, `PRD-018` is **not to be written**, scope is **ATTENDANCE ONLY**, with **no** authorisation for fees, payments, financial ledger, membership, library operations, any other bounded context or any future workflow, and any future cross-context use requiring **separate architecture/governance review** (`ADR-0033` §7.1 — *"a conferral for one act is not a standing licence"*). ⭐ **All v1.0 measurements are preserved verbatim; nothing in §1–§7 is edited**, and the §8 decision form is **left with its boxes blank on purpose** because it is the record of the question *as asked* — the answer is filed separately at §8.1 on the `14A` separation pattern. ⛔⛔ **THE DECISION IS RECORDED, NOT EXECUTED:** the consequent change lands on the **Rank-4** BC Map, and `PRD_LIFECYCLE.md` **L174**, `ADR-INDEX.md` Process step 1 and baseline **§7 rule 1** each require an **`ACCEPTED`** ADR *before* a boundary change, while `PRD_OWNERSHIP_MODEL.md` **L85** reserves that acceptance to the **Architecture Owner**. So [`ADR-0114`](../../00-governance/adr/ADR-0114-offline-sync-is-a-capability-of-bc-03-attendance.md) is created **`PROPOSED` and deliberately NOT self-accepted**, and the BC Map is **byte-unchanged** with `BC-30`'s disposition routed as `Q-1`/`Q-2`. ⚠ **`PRD_REGISTRY.md` is byte-unchanged and `PRD-018` remains `PLANNED`** — measured, §2's closed vocabulary holds **nine** values and **`RETIRED` is not among them**, a pre-existing defect already disclosed by `PRD-012a_STAGE7_FREEZE.md` and routed to the Governance Owner as `Q-3`; writing a forbidden status would invent a governance value. ⚠ **The resulting inconsistency is stated, not smoothed over**: `BC-30` still exists and `PRD-018` is still `PLANNED` despite the decision, and that is the honest state until the Architecture Owner acts. ⛔ **`ADR-0037` untouched** and no `BC-05` → `BC-30` edge created or implied; ⛔ **`OfflineSyncEngine` untouched — 0 lines**, its §1.5 defects still **disclosed and unrepaired**; ⛔ **implementation NOT authorised**. |
| **v1.0** | 2026-09-07 | **Created as Stage-1 Discovery preparation for `PRD-018` Offline Sync (`BC-30`).** Follows the `PRD-015_FINAL_ARCHITECTURE_DECISION_PREPARATION.md` convention. ⭐ **Central measurement: three of the four Stage-1 questions pass and the fourth fails** — `BC-30` exists (BC Map **L139**), is unowned (`PRD_REGISTRY.md` **L462**) and is **V1** (**L318**), but owns **0** BC Map §8 aggregate rows and **0** §9 event rows, whose stated consequence is *"it is a capability of an existing context"*. ⚠ **`E-24`'s own contract cell points the same way** — *"Attendance defines the conflict-resolution policy; Sync executes it"* (**L333**). ⚠⚠ **Code precedes requirements and is disclosed, not repaired:** `OfflineSyncEngine` (`services.dart` **L50**) is an **in-memory** queue with **no transport** (0 HTTP references), `SyncState.conflicted` is declared but **assigned 0 times**, and there are **0** Offline Sync tests — so **2 of `BC-30`'s 4 stated ownerships are entirely absent** and it must not be mistaken for a partial implementation. ⚠ `platform/services` has a rank but **no manifest module block** (`FIL-GAP-010`), so the module holding that code is unenforced. ⭐ **Three options are presented with trade-offs and none is selected:** (a) proceed on the `PRD-017`/`FIL-GAP-001` precedent — noting that precedent's forcing condition (multiple frozen consumers) is **absent** here, `BC-30` having exactly one; (b) treat it as a `BC-03` capability; (c) defer, which **Rank-1 `MP-ASM-03` expressly contemplates**. ⛔⛔ **NOTHING DECIDED:** 0 decisions, 0 ADRs, 0 identifiers, 0 amendments, 0 code or test changes; `ADR-0037`'s bar on offline financial capture is preserved untouched; implementation is **NOT authorised**; and the Product Owner decision box at §8 is **deliberately blank**. |
