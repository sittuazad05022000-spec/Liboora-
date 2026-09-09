# ADR-0121 — The `BC-30` V1 offline queue **depth bound and backpressure behaviour**: Item 7b RESOLVED

| Field | Value |
|---|---|
| **ADR** | `ADR-0121` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | **`DATA / EVENT`** — the office constituted by `Accepted` [`ADR-0118`](./ADR-0118-data-event-office-conferred-for-bc-30-queue-depth-act-only.md) and conferred **for one act only**: *"to decide and record the `BC-30` Offline Sync queue-depth/backpressure bound required for Item 7b."* ⭐ **This ADR IS that act, and it is the FIRST exercise of it** — `ADR-0118` §4.2 recorded the act as *"CONFERRED but NOT YET EXERCISABLE"* and it was left **unspent** by `ADR-0119` §5.1 and `ADR-0120` §6.1. ⛔ No ARB quorum, attendee list, sign-off date or Security review is asserted. ⛔ **No holder appointed, no personal name recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4); **one holder** (§3 rule 1). ⛔ The office is **VACANT** after this act — `ADR-0033` §7.1 |
| **Subject** | The `BC-30` V1 offline queue depth bound and its backpressure behaviour (Item 7b) |
| **Supersedes** | **Nothing** |
| **Amends** | ⛔ **Nothing.** No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no other ADR — the **`ADR-0058` / `ADR-0119` / `ADR-0120` shape**: a decision recorded **in the ADR itself** (§5) |
| **Amended by** | — |
| **Does NOT amend** | `MASTER_PRD.md` (Rank 1, incl. **L498** `MP-NFR-04`) · **BC Map (Rank 4), incl. §8, §9.1, §18 and `E-24` L333** · Dependency Matrix (Rank 4) · **`PRD-006` (Rank 3, FROZEN)** · `PRD-001` · every other frozen PRD · `ADR-0114`…`ADR-0120` · `DOCUMENTATION_BASELINE.md` · `PRD_OWNERSHIP_MODEL.md` · `CONFIGURATION_GUIDE.md` · `tool/module_dependencies.yaml` |
| **Baseline** | ⛔ **No baseline re-issue and no version bump anywhere.** `BASELINE-2026-09-03-A` stands — `DOCUMENTATION_BASELINE.md` §7 rules 1–4 are **all unmet**, because **no Rank 1–5 document changes** (§5.2) |
| **Closes** | ⭐⭐ **Item 7b — Queue Depth / Backpressure.** Both limbs are recorded: the **bound** (§2 `EVT-DEPTH-1`) and the **behaviour at the bound** (§2 `EVT-DEPTH-2`) |
| **Does NOT close** | ⛔ **Item 5** retry/backoff · ⛔ **Item 9b** at-rest (`ATT-GAP-006` OPEN) · ⛔ **Item 7a** retention (`Q-04` open) · ⛔ **8b-residual** — and ⚠ **the "explicitly authorized disposal" limb of this decision depends on it** (§3.1) · ⛔ **no implementation authority** |
| **Related** | `ADR-0118` (the conferral this discharges) · `ADR-0119` **D-4** (*no silent discard*) · `ADR-0120` **`EVT-PERS-1`** (the persistence guarantee) · `MASTER_PRD.md` **L498** (`MP-NFR-04`, Rank 1 — owner `DATA / EVENT`) · `PRD-006` `ATT-NFR-012`, `ATT-PO-001`, `ATT-PO-011` · `MP-ASM-03` |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR records **one bound and one behaviour**, in the human principal's exact
> words. It authorises **no** storage technology, database, queue product, schema, flush policy,
> acknowledgement protocol, encryption, retry/backoff, retention, cloud resource, Supabase configuration or
> application implementation. **A bound is not a mechanism.**

---

## §1 The act

`ADR-0118` constituted the `DATA / EVENT` office and **withheld the exercise**, sequencing it *"after the
Item-3 durability model is authoritative."* Item 3 became authoritative on 2026-09-08 (`ADR-0119` D-1…D-4 +
`ADR-0120` `EVT-PERS-1`). ⭐ **But the act still could not be exercised**, because `ADR-0119` §5.1 and
`ADR-0120` §6.1 both measured **0** queue-depth values anywhere in the repository to ratify — `MP-NFR-04`
supplies the **obligation** and no **value** — and an exhaustive four-sweep audit confirmed it.

⭐ **That audit is why this ADR ratifies rather than invents.** The human principal has now supplied the
value, in these words:

> *"I confer the DATA / EVENT authority already constituted by ADR-0118 to be exercised now for its one
> act. **DECISION: the BC-30 V1 offline queue bound is 500 queued offline attendance mutations per device,
> and on reaching the bound the system MUST block new offline captures while preserving all already-captured
> queued mutations until replay or explicitly authorized disposal.** One act only, not a standing licence.
> Authorizes only the queue-depth/backpressure decision."*

⛔ **No prior conferral was reused.** `ADR-0118`'s act was **unspent**; this is its **first and only**
exercise, and the office is **VACANT** afterwards.

---

## §2 ⭐⭐ The decision

**The `BC-30` V1 offline queue bound and its backpressure behaviour are:**

> **`EVT-DEPTH-1` — The `BC-30` V1 offline queue bound is 500 queued offline attendance mutations per
> device.**
>
> **`EVT-DEPTH-2` — On reaching the bound, the system MUST block new offline captures while preserving all
> already-captured queued mutations until replay or explicitly authorized disposal.**

⭐ **Recorded VERBATIM** as the principal stated it. ⛔ **Not substituted, weakened, strengthened,
paraphrased, rounded or reinterpreted.** The identifiers `EVT-DEPTH-1`/`EVT-DEPTH-2` are **citation labels
only**, on the `EVT-PERS-1` pattern; they add no content and are **not** `SYNC-*`, **not** `ATT-*`, **not**
`ATT-CFG-*`, and are **not** added to any PRD register.

### 2.1 What the decision's own terms fix, and what they do not

| Term | What it fixes | What it does **NOT** fix |
|---|---|---|
| **`500`** | The numeric bound, exactly | ⛔ **Not configurable, not tenant-scoped, not a range** — no `ATT-CFG-*` row is created (§3), and no second or derived value is introduced |
| **`queued offline attendance mutations`** | The unit counted is the **queued offline attendance mutation** — the artefact `E-24` already carries | ⛔ **No schema, record layout or serialisation** for that unit |
| **`per device`** | The **scope** of the bound | ⚠ See §4.2 — this is a **counting scope**, and it does **not** create per-device attendance |
| **`MUST block new offline captures`** | The behaviour at the bound: **block**, not drop, not overwrite, not shed | ⛔ **No UI, error code, message, surface or retry semantics** for the blocked capture |
| **`preserving all already-captured queued mutations`** | Already-queued items are **retained**, not sacrificed to make room | ⛔ **No storage mechanism** by which retention is achieved |
| **`until replay or explicitly authorized disposal`** | The two terminating conditions | ⚠ **"Explicitly authorized disposal" is UNDEFINED** — see §3.1 |

---

## §3 ⛔ What this ADR does NOT authorise — the conferral's own exclusion list, transcribed

| Not authorised | Status |
|---|---|
| **Storage technology** | ⛔ None named |
| **Database** | ⛔ None. ⚠ `ADR-0116`'s `Supabase` selection is a **server-side runtime** choice and is **NOT** read as implying any client-side mechanism |
| **Queue product** | ⛔ None |
| **Schema** | ⛔ None |
| **Flush policy** | ⛔ None |
| **Acknowledgement protocol** | ⛔ None |
| **Encryption** | ⛔ None. Item 9b remains SECURITY PLATFORM's; **`ATT-GAP-006` OPEN** |
| **Retry / backoff** | ⛔ **None.** Item 5. ⭐ **Blocking is NOT a retry policy** — `EVT-DEPTH-2` says what happens *at* the bound, not how or when a blocked capture is re-attempted. `PRD-006` **L2332**: *"none may be invented"* |
| **Retention** | ⛔ **None.** ⭐ **A depth bound is NOT a retention period** — `EVT-DEPTH-1` bounds *how many*, never *how long*. `Q-04`/`ATT-GAP-005` untouched |
| **Cloud resources** | ⛔ None |
| **Supabase configuration** | ⛔ None. Verified: **0** occurrences in `lib/`, `pubspec.yaml`, `android/` |
| **Application implementation** | ⛔ None. **0** code/config/dependency files |
| **`PRD-006` amendment** | ⛔ **Byte-unchanged.** ⛔ No `ATT-CFG-*`, `ATT-NFR-*` or `ATT-AC-*` identifier is minted, moved or altered |
| **`PRD-018`** | ⛔ Not created; remains `PLANNED` |
| **Standing authority** | ⛔ None. Office **VACANT** after this act |

### 3.1 ⚠⚠ The one undefined limb, disclosed rather than buried

`EVT-DEPTH-2` terminates on *"replay or **explicitly authorized disposal**."* ⛔ **What constitutes
"explicitly authorized disposal" is NOT defined by this act, and is not implied or pre-judged.**

⭐ This is the **same** open limb `ADR-0120` §2.1 disclosed for `EVT-PERS-1`'s *"explicitly disposed of"*,
and it is substantially the **Item 8b-residual** question — the disposition of a legitimately captured
mutation whose actor's access is revoked before replay — owned by the **Product Owner + `BC-03` Domain
Owner**, and **untouched** here.

⭐ **The decision is nonetheless complete and operative**, for the same reason: retention of queued items is
**unconditional until** a terminating event, so an undefined disposal route makes the guarantee **stronger,
never weaker**. **Nothing may be dropped on the strength of a disposal rule that does not exist.**

---

## §4 Coherence, tested rather than assumed

⭐ **Four conflict tests were run against Accepted and FROZEN authority before recording this decision.
Recording a value that contradicted a frozen requirement would be worse than leaving Item 7b open.**

### 4.1 ⭐ `EVT-DEPTH-2` is CONSISTENT with `ADR-0119` D-4 and `ADR-0120` `EVT-PERS-1` — and this was the real risk

⚠ A depth bound is the natural place to introduce a **shed/drop/evict** policy, and any such policy would
have **collided with two Accepted ADRs**:

| Accepted authority | What it forbids | Does `EVT-DEPTH-2` breach it? |
|---|---|---|
| `ADR-0119` **D-4** — *"**No silent discard.** A queued item that fails to replay **MUST NOT** vanish"* | Dropping queued items silently | ✅ **No.** `EVT-DEPTH-2` **blocks new captures** and **preserves** existing ones — the opposite of discard |
| `ADR-0120` **`EVT-PERS-1`** — persisted *"until it is either replayed or explicitly disposed of"* | Losing a captured mutation | ✅ **No.** `EVT-DEPTH-2` uses the **same two terminating conditions**, in the same order |
| Rank 1 `MP-NFR-02` — *"DLQ depth is an SLO-monitored signal, **not a silent bin**"* | Silent absorption of overflow | ✅ **No.** Blocking is **loud by construction**: the capture does not succeed |

⭐⭐ **So the supplied behaviour resolves a genuine tension rather than creating one.** A drop-oldest or
shed-newest policy would have required amending or contradicting `ADR-0119`/`ADR-0120`; **block-and-preserve
does not**, and no Accepted ADR is amended, superseded or restatused by this ADR.

### 4.2 ⚠ `per device` — a counting scope, not a new attendance concept

⚠ **`PRD-006` L853 is explicit**: *"student-level attendance and presence remain singular. **A per-device
audit trail is not a per-device attendance**."* A careless reading of *"per device"* could be taken to
create per-device attendance, which that frozen line forbids.

⭐ **It does not, and the distinction is recorded so it cannot be misread later.** `EVT-DEPTH-1` scopes a
**capacity counter on `BC-30`'s client queue** — a property of the **execution mechanism**. It creates **no**
per-device attendance record, **no** second presence system of record (`ATT-AC-152`), and **no** change to
`AttendanceDay` as the aggregate. ⛔ **`PRD-006` is byte-unchanged.**

### 4.3 ⭐ Blocking capture does NOT breach `ATT-PO-001`'s *"never blocks"*

⚠ **`ATT-PO-001` says Attendance *"records and flags, never blocks."*** Measured in context (**L307**, and
its twin at **L225**), that rule is **`E-03` membership-validity scoped**: it forbids blocking a check-in
*because a membership is invalid*. Both occurrences sit in the membership row and nowhere else.

⭐ **`EVT-DEPTH-2` blocks on a `BC-30` capacity condition, not on a `BC-02` membership condition** — a
different port, a different cause, a different context. `ATT-PO-001` is **preserved unweakened**.

### 4.4 `MP-ASM-03` and `ATT-NFR-012`

`MP-ASM-03` requires that *"offline attendance capture is required"*; `ATT-NFR-012` forbids promising
offline behaviour *"beyond what `E-24` authorises."* ⭐ **`EVT-DEPTH-1`/`-2` promise LESS, not more**: they
place a **ceiling** on offline capture and extend the offline feature surface by **nothing** — no new mode,
code path, capability or user-visible promise. ⛔ `ATT-GAP-016a`'s prohibition on promising offline Dynamic
QR is untouched.

### 4.5 No value collision

Measured: **0** conflicting uses of `500` as a queue/offline/limit/max value in `PRD-006`,
`MASTER_PRD.md` or `CONFIGURATION_GUIDE.md`. ⛔ **No existing configured value is displaced.**

---

## §5 Method and baseline

### 5.1 Recorded in the ADR

The **`ADR-0058` / `ADR-0119` / `ADR-0120`** shape: `ADR-0058` attached a V1 obligation to a **port** with
`Amends: Nothing`, and **`E-24` L333 already declares `BC-30`'s Sync port**, so the artefact this bound
attaches to already exists. ⛔ **No aggregate is declared, no `ATT-CFG-*` row is created** — a configurable
would be a **Rank-3 register change** to a FROZEN PRD and is expressly outside this conferral.

### 5.2 No baseline movement

| `DOCUMENTATION_BASELINE.md` §7 rule | Applies? |
|---|---|
| 1 — Rank 1–5 change requires a prior ADR | ⛔ **Not engaged** — no Rank 1–5 document changes |
| 2 — version + changelog in the same commit | ⛔ **Not engaged** |
| 3 — declaration updated in the same commit | ⛔ **Not engaged** |
| 4 — identifier moves on a Rank 1–3 version change | ⛔ **Not engaged.** `BASELINE-2026-09-03-A` **stands** |

⚠ **Cost disclosed:** a reader of the BC Map or `PRD-006` alone will **not** find `EVT-DEPTH-1`/`-2` — the
same condition `ADR-0058`, `ADR-0119` and `ADR-0120` created. A future Architecture-Owner act **may** mirror
these into Rank 4; this ADR **neither performs nor requires** that.

---

## §6 Dependency re-audit

| Item | Before | After this ADR | Reason |
|---|---|---|---|
| **3 — Durable Queue** | ✅ RESOLVED | ✅ **RESOLVED** | `ADR-0119` + `ADR-0120`, unchanged |
| **⭐⭐ 7b — Queue depth / backpressure** | 🔒 BLOCKED | ✅ **RESOLVED** | **This ADR** — bound **and** behaviour both recorded. ⛔ **RESOLVED ≠ IMPLEMENTABLE** |
| **5 — Retry/Backoff** | ⛔ OPEN | ⛔ **OPEN — untouched** | ⭐ **Blocking is not a retry policy** (§3). `PRD-006` **L2332**: *"none may be invented"*. Architecture Owner + Product Owner |
| **9b — At-rest** | ⛔ OPEN — eligible | ⛔ **OPEN — eligible, not resolved** | **`ATT-GAP-006` OPEN**: *"the construction is Security Platform's … §0.4 forbids"* |
| **7a — Retention** | ⛔ OPEN | ⛔ **OPEN — untouched** | ⭐ **A depth bound is not a retention period.** `Q-04` open; `ATT-GAP-005` bars the unratified note |
| **8b-residual** | ⚠ owner decision | ⚠ **REQUIRES OWNER DECISION — untouched** | ⚠ **Now load-bearing for two ADRs**: it defines *"explicitly authorized disposal"* in `EVT-DEPTH-2` and *"explicitly disposed of"* in `EVT-PERS-1` (§3.1) |

⭐⭐ **With Item 7b resolved, the original Offline-Sync dependency chain — Item 4 → Item 3 → Item 9b / 7b —
is fully discharged at the governance level.** ⛔ **Three independent owner decisions remain (5, 9b, 7a),
plus 8b-residual, and NO implementation is authorised.**

⛔ This ADR confers **no lifecycle stage**, creates **no** context, edge, event, port, aggregate or
requirement identifier, allocates **0** `IMPL-*`, mints **0** `SYNC-*`, and touches **0** application-code
files.

---

## §7 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. ITEM 7b IS RESOLVED.** The `DATA / EVENT` office performs the **first and only** exercise of the act `ADR-0118` conferred and withheld (⛔ **no conferral reused**; `ADR-0119` §5.1 and `ADR-0120` §6.1 had both left it **unspent** because **0** values existed to ratify). ⭐ Records **`EVT-DEPTH-1`** — *"the `BC-30` V1 offline queue bound is 500 queued offline attendance mutations per device"* — and **`EVT-DEPTH-2`** — *"on reaching the bound the system MUST block new offline captures while preserving all already-captured queued mutations until replay or explicitly authorized disposal"* — **both VERBATIM**, not substituted, weakened, strengthened, rounded or reinterpreted. ⭐⭐ **FOUR COHERENCE TESTS RUN BEFORE RECORDING (§4), because a value that contradicted frozen authority would be worse than leaving 7b open:** (i) **`EVT-DEPTH-2` is CONSISTENT with `ADR-0119` D-4 and `ADR-0120` `EVT-PERS-1`** — this was the real risk, since any shed/drop/evict policy would have collided with *"no silent discard"* and with persistence *"until replayed or explicitly disposed of"*; **block-and-preserve resolves that tension instead of creating it**, and **no Accepted ADR is amended**; (ii) **`per device` is a counting scope on `BC-30`'s queue, NOT per-device attendance** — `PRD-006` **L853** forbids the latter (*"a per-device audit trail is not a per-device attendance"*), and `ATT-AC-152`/`AttendanceDay` are untouched; (iii) **`ATT-PO-001`'s *"never blocks"* is `E-03` MEMBERSHIP-scoped** (measured at **L307** and **L225**), so blocking on a `BC-30` **capacity** condition does not breach it; (iv) **`MP-ASM-03`/`ATT-NFR-012` are satisfied** — a ceiling **promises less, not more**, and extends the offline surface by nothing. ⭐ **No value collision** — **0** conflicting uses of `500` as a queue/offline/limit value. ⚠⚠ **ONE LIMB REMAINS UNDEFINED AND IS DISCLOSED (§3.1):** *"explicitly authorized disposal"* is **not defined, implied or pre-judged** — it is substantially the **8b-residual** question (Product Owner + `BC-03` Domain Owner), which is now **load-bearing for two ADRs**; the decision is nonetheless complete and operative because retention is **unconditional until** a terminating event, so an undefined disposal route makes it **stronger, never weaker**. ⛔ **NOTHING ELSE AUTHORISED (§3):** no storage technology, database, queue product, schema, flush policy, acknowledgement protocol, encryption, retry/backoff, retention, cloud resource, Supabase configuration or application implementation; ⭐ **blocking is NOT a retry policy** and ⭐ **a depth bound is NOT a retention period**, so Items 5 and 7a stay OPEN; ⛔ **no `ATT-CFG-*` row is created** — a configurable would be a Rank-3 register change to a FROZEN PRD, outside this conferral. ⛔ **Amends NOTHING; BC Map and `PRD-006` byte-unchanged**; `DOCUMENTATION_BASELINE.md` §7 rules 1–4 each tested and **all unmet**, so **no version bump anywhere** and **`BASELINE-2026-09-03-A` stands**; ⚠ cost disclosed — a BC-Map-only reader will not find these labels, and mirroring is **neither performed nor required**. ⛔ **No standing authority; no person named; office VACANT after this act; Implementation authorised: No.** `MASTER_PRD`, `PRD-001`, all frozen PRDs, BC Map (incl. `E-24`), Dependency Matrix, `PRD_OWNERSHIP_MODEL`, `CONFIGURATION_GUIDE`, `ADR-0114`…`ADR-0120` and `tool/module_dependencies.yaml` **byte-unchanged**; **`PRD-018` not created**; **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config/dependency files. |
