# ADR-0122 — The `BC-30` V1 offline **replay retry policy**: Item 5 RESOLVED

| Field | Value |
|---|---|
| **ADR** | `ADR-0122` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | **Architecture Owner + Product Owner**, by **direct, explicit conferral from the human principal**, **for one act only**: *"to decide and record the `BC-30` V1 offline replay retry policy."* ⭐ **Two offices jointly, because the decision has two limbs**: the retry/backoff **mechanism** is an Architecture Owner matter (`PRD_OWNERSHIP_MODEL.md` **L85**) and the exhaustion **disposition** is a Product Owner matter (**L83**, *"business intent: scope, priority, acceptance"*) — the `ADR-0011` precedent of *"three roles for one decision"*. ⛔ No ARB quorum, attendee list, sign-off date or Security review is asserted. ⛔ **No holder appointed, no personal name recorded** (§7 rule 4). ⛔ Both offices revert to their prior state after this act — `ADR-0033` §7.1: *"a conferral for one act is not a standing licence."* |
| **Subject** | The `BC-30` V1 offline replay retry limit, backoff strategy and exhaustion behaviour (Item 5) |
| **Supersedes** | **Nothing** |
| **Amends** | ⛔ **Nothing.** No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no `CONFIGURATION_GUIDE.md`, no other ADR — the **`ADR-0058` / `ADR-0119` / `ADR-0120` / `ADR-0121` shape**: a decision recorded **in the ADR itself** (§5) |
| **Amended by** | — |
| **Does NOT amend** | `MASTER_PRD.md` (Rank 1) · **BC Map (Rank 4), incl. §9.1 and `E-24` L333** · Dependency Matrix (Rank 4) · **`PRD-006` (Rank 3, FROZEN)** — ⛔ **no `ATT-CFG-*`, `ATT-NFR-*`, `ATT-FR-*` or `ATT-AC-*` identifier is minted, moved or altered** · `PRD-001` · every other frozen PRD · **`ADR-0119`, `ADR-0120`, `ADR-0121`** · `ADR-0114`…`ADR-0118` · `DOCUMENTATION_BASELINE.md` · `PRD_OWNERSHIP_MODEL.md` · `tool/module_dependencies.yaml` |
| **Baseline** | ⛔ **No baseline re-issue and no version bump anywhere.** `BASELINE-2026-09-03-A` stands — `DOCUMENTATION_BASELINE.md` §7 rules 1–4 are **all unmet**, because **no Rank 1–5 document changes** (§5.2) |
| **Closes** | ⭐⭐ **Item 5 — Retry / Backoff.** All three limbs are recorded: the **limit** (§2 `EVT-RETRY-1`), the **backoff strategy** (§2 `EVT-RETRY-2`) and the **exhaustion behaviour** (§2 `EVT-RETRY-3`), plus the **timestamp-preservation constraint** (§2 `EVT-RETRY-4`) |
| **Does NOT close** | ⛔ **Item 9b** at-rest (`ATT-GAP-006` OPEN) · ⛔ **Item 7a** retention (`Q-04` open) · ⛔ **8b-residual** — and ⚠ **`EVT-RETRY-3`'s "explicit/manual resolution" does NOT define it** (§3.1) · ⛔ `ATT-GAP-017a` (latency/throughput) · ⛔ **no implementation authority** |
| **Related** | `ADR-0119` **D-1…D-4** · `ADR-0120` **`EVT-PERS-1`** · `ADR-0121` **`EVT-DEPTH-1`/`-2`** · `PRD-006` **L2332** (*"none may be invented"*), `ATT-FR-088`, `ATT-NFR-003`, `ATT-NFR-005`, `ATT-NFR-012`, `ATT-PO-011` · `MASTER_PRD` `MP-NFR-02` · `ADR-0044` §158 (*retry behaviour "expressly withheld … Not conferred"*) · `ADR-0021`/`ATT-GAP-017` (the owner-supplied-values precedent) |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR records **one retry policy**, in the human principal's exact words. It
> authorises **no** storage technology, database, queue product, schema, encryption, retention, cloud
> resource, Supabase configuration or application implementation. **A policy is not an implementation.**

---

## §1 The act

`PRD-006` **L2332** forbids invention in terms: *"No cooldown, frequency, quiet-hour rule, **retry count** or
escalation ladder is stated for any row above, and **none may be invented**."* An exhaustive six-sweep audit
measured **0** authoritative retry/backoff values for attendance or offline sync anywhere in the repository,
and rejected four near-miss candidates by scope — `FIL-CFG-014` (**`BC-29`** processing), `NTF-CFG-004`
(**`BC-22`** notifications), BC Map **§9.1**'s qualitative *"retry with backoff"* row (which states no count
or delay and, per `ADR-0119` §3, does not reach `BC-30`), and `ADR-0028` **C-3** (which forbids inventing a
backoff and is only **`Proposed`**).

⭐ **So this value could only be supplied, never derived** — the `ATT-GAP-017` precedent, where seven
valueless `ATT-CFG-*` settings were closed by **owner-supplied values** and `ADR-0021` expressly declined to
decide them. The human principal has now supplied it:

> *"I confer Architecture Owner + Product Owner authority for ONE ACT ONLY to decide and record the BC-30 V1
> offline replay retry policy. **DECISION: Retry limit = 5 attempts. Backoff strategy = exponential: 1, 2, 4,
> 8 and 16 minutes. On retry exhaustion, the system MUST retain the mutation as terminal-failed and surface it
> for explicit/manual resolution, with no silent discard.** … Preserve the original attendance capture
> timestamp. Replay/retry time MUST NOT replace the original attendance time. This is a
> replay/synchronization retry policy only."*

⛔ **No prior conferral was reused.** `ADR-0117`'s and `ADR-0118`'s acts were spent by `ADR-0119`/`ADR-0121`;
this is a **separate** conferral to **different offices** over a **different subject**.

---

## §2 ⭐⭐ The decision

> **`EVT-RETRY-1` — Retry limit = 5 attempts.**
>
> **`EVT-RETRY-2` — Backoff strategy = exponential: 1, 2, 4, 8 and 16 minutes.**
>
> **`EVT-RETRY-3` — On retry exhaustion, the system MUST retain the mutation as terminal-failed and surface
> it for explicit/manual resolution, with no silent discard.**
>
> **`EVT-RETRY-4` — Preserve the original attendance capture timestamp. Replay/retry time MUST NOT replace
> the original attendance time.**

⭐ **Recorded VERBATIM** as the principal stated it. ⛔ **Not substituted, weakened, strengthened, rounded,
re-derived or reinterpreted.** ⭐ **This is a replay/synchronization retry policy ONLY**, as the conferral
states. The identifiers `EVT-RETRY-1`…`-4` are **citation labels only**, on the `EVT-PERS-1`/`EVT-DEPTH-*`
pattern; they add no content and are **not** `SYNC-*`, **not** `ATT-*`, **not** `ATT-CFG-*`, and are **not**
added to any PRD register.

### 2.1 What the terms fix, and what they do not

| Term | Fixes | Does **NOT** fix |
|---|---|---|
| **`5 attempts`** | The attempt bound, exactly | ⛔ Not configurable, not a range, not tenant-scoped — **no `ATT-CFG-*` slot is created** (§5.1) |
| **`exponential: 1, 2, 4, 8 and 16 minutes`** | The five inter-attempt delays, exactly as enumerated | ⛔ **No jitter, no clock source for the delay, no scheduler, no timer mechanism.** ⚠ `ATT-PO-011` still forbids `BC-03` from implementing the replay machinery |
| **`retain … as terminal-failed`** | The item **survives** exhaustion in a terminal state | ⛔ **No state machine, status vocabulary, storage medium or schema** for "terminal-failed" |
| **`surface it for explicit/manual resolution`** | It must become **visible** and resolvable by a deliberate act | ⚠ **What that resolution consists of is NOT defined** — see §3.1 |
| **`no silent discard`** | Restates and reinforces `ADR-0119` **D-4** | — |
| **`preserve the original … timestamp`** | The attendance time is the **capture** time, never the replay time | ⛔ No timestamp format, precision or field name |

---

## §3 ⛔ What this ADR does NOT authorise — the conferral's own exclusion list, transcribed

| Not authorised | Status |
|---|---|
| **Storage technology** · **database** · **queue product** · **schema** | ⛔ None. ⚠ `ADR-0116`'s `Supabase` selection is a **server-side runtime** choice and is **NOT** read as implying any client-side retry mechanism |
| **Encryption** | ⛔ None. Item 9b remains SECURITY PLATFORM's; **`ATT-GAP-006` OPEN** |
| **Retention** | ⛔ **None.** ⭐ **A retry schedule is NOT a retention period** — `EVT-RETRY-2` bounds *how long between attempts*, never *how long an item is kept*. `Q-04`/`ATT-GAP-005` untouched |
| **Cloud resources** · **Supabase configuration** | ⛔ None. Verified **0** `supabase` occurrences in `lib/`, `pubspec.yaml`, `android/` |
| **Application implementation** | ⛔ None. **0** code/config/dependency files |
| **`PRD-006` amendment** | ⛔ **Byte-unchanged** |
| **`PRD-018`** | ⛔ Not created; remains `PLANNED` |
| **Conflict-resolution semantics** | ⛔ **Untouched** — `BC-03` still defines the policy (`ATT-PO-011`, `E-24`, `ADR-0114`) |
| **Queue depth (500/device)** | ⛔ **Untouched** — `ADR-0121` `EVT-DEPTH-1`/`-2` stand unamended |
| **Persistence guarantee** | ⛔ **Untouched** — `ADR-0120` `EVT-PERS-1` stands unamended |
| **At-rest protection** | ⛔ **Untouched** |
| **Standing authority** | ⛔ None |

### 3.1 ⚠⚠ The one undefined limb, disclosed rather than buried

`EVT-RETRY-3` requires the exhausted item be *"surfaced for **explicit/manual resolution**."* ⛔ **What that
resolution consists of — who may perform it, and whether it may end in disposal — is NOT defined by this
act, and is not implied or pre-judged.**

⭐ This is the **third** ADR to meet the same open limb, and the pattern is now explicit: `ADR-0120`
`EVT-PERS-1` (*"explicitly disposed of"*), `ADR-0121` `EVT-DEPTH-2` (*"explicitly authorized disposal"*) and
now `EVT-RETRY-3`. All three terminate on a **disposal/resolution route that the repository has never
defined**, which is substantially the **Item 8b-residual** question — owned by the **Product Owner + `BC-03`
Domain Owner** and **untouched** here.

⭐ **The policy is nonetheless complete and operative**: retention after exhaustion is **unconditional**, and
*"no silent discard"* is absolute. **An undefined resolution route makes the guarantee stronger, never
weaker** — nothing may be dropped on the strength of a resolution rule that does not exist.

---

## §4 Coherence, tested rather than assumed

⭐ **Six conflict tests were run against Accepted and FROZEN authority before recording. A retry value that
contradicted a frozen requirement would be worse than leaving Item 5 open.**

### 4.1 ⭐ `EVT-RETRY-3` is CONSISTENT with `ADR-0119` D-4 — indeed it *satisfies* it

| Accepted authority | Requirement | Does `EVT-RETRY-3` satisfy it? |
|---|---|---|
| `ADR-0119` **D-4** | *"**No silent discard.** A queued item that fails to replay **MUST NOT** vanish; its failure must remain an observable signal"* | ✅ **Yes, exactly.** *"Retain … as terminal-failed and surface it … with no silent discard"* is D-4's requirement made concrete. ⭐ **D-4 was expressed as a prohibition without a mechanism** (`ADR-0119` §2 records this deliberately); `EVT-RETRY-3` supplies the disposition **without** amending D-4 |
| Rank 1 `MP-NFR-02` | *"DLQ depth is an SLO-monitored signal, **not a silent bin**"* | ✅ **Yes** — *"surface it"* is the observable-signal limb |

### 4.2 ⭐ CONSISTENT with `ADR-0120` `EVT-PERS-1`

`EVT-PERS-1` guarantees persistence *"until it is either replayed or explicitly disposed of."* ⚠ **A retry
limit could have been read as a third, implicit termination** — *"and also, after 5 failures, it may be
dropped."* ⭐ **`EVT-RETRY-3` forecloses that reading**: exhaustion produces **retention** in a terminal
state, **not** disposal. **So the two guarantees compose, and `EVT-PERS-1` is not narrowed.**

### 4.3 ⭐ CONSISTENT with `ADR-0121` `EVT-DEPTH-1`/`-2`

⚠ **A real interaction exists and is recorded rather than glossed:** items that exhaust retries are
**retained**, so they continue to occupy queue slots and therefore count toward the **500/device** bound —
after which `EVT-DEPTH-2` **blocks new offline captures**. ⭐ **That is a coherent consequence of the two
decisions, not a contradiction**, and it follows necessarily from *"no silent discard"* — the alternative
would be to free capacity by dropping data, which D-4 forbids. ⛔ **No queue-depth value or blocking
behaviour is changed here**; `ADR-0121` stands unamended.

### 4.4 ⭐ `EVT-RETRY-4` CONFIRMS existing frozen authority rather than adding to it

⚠ Timestamp preservation is the requirement most at risk from a retry policy — a naive implementation would
stamp the attendance at replay time. ⭐ **Frozen Rank 3 already forbids that**, and `EVT-RETRY-4` aligns with
it exactly:

| Frozen authority | Text |
|---|---|
| **`ATT-FR-088`** (L1647) | *"Every attendance timestamp **MUST** be obtained from the platform time port, never from the device clock"* |
| **`PRD-006` L2433–2436** | *"**Late arrival of an observation MUST NOT fabricate a disconnect that was never observed**: a queued loss is an observed loss **whenever it arrives** … Ordering by the platform time port (`ATT-FR-088`), never by device clock"* |
| **`ATT-BR-030`** | An end timestamp **MUST NOT** be fabricated |

⭐ **So `EVT-RETRY-4` is a restatement in the retry context, not a new rule** — and recording it is valuable
precisely because retry is where the frozen rule is easiest to breach. ⛔ **`ATT-FR-088` is not amended.**

### 4.5 ⚠ `ATT-NFR-003` does NOT bar these values — the scope test

`ATT-NFR-003` says *"**This document** **MUST NOT** state a latency figure, throughput number or percentile
target"* (`ATT-GAP-017a`). Tested on two limbs, both of which must hold:

1. ⭐ **Scope of the subject:** it binds *"**this document**"* — `PRD-006` — and **`PRD-006` is
   byte-unchanged**. This ADR is a Rank 2 record, not an edit to it.
2. ⭐ **Scope of the kind:** a **backoff interval is not a latency figure, throughput number or percentile
   target.** Latency measures how fast the system responds; a backoff interval prescribes how long to wait
   before re-attempting. ⚠ **`ATT-GAP-017a` therefore remains OPEN and is NOT closed by this act** — no
   latency, throughput or percentile target is stated anywhere here.

⚠ **`ADR-0028` C-3 is honoured, not overridden:** it says *"no scan interval, backoff or timeout may be
**invented here**"* — a prohibition on **invention**, scoped to that ADR. This value is **conferred, not
invented**, and `ADR-0028` is `Proposed` and byte-unchanged.

### 4.6 No value collision, and no clash with the 5-minute grace

⭐ Measured: **0** existing uses of `5 attempts` or the `1, 2, 4, 8, 16` schedule anywhere in `docs/`.
⚠ **`PRD-006`'s 5-minute presence grace was checked for confusion** (L838, L839, L898): it is a **predicate
over recorded observations** deciding whether a session continues, and **`EVT-RETRY-2`'s first delay of 1
minute and its 16-minute tail are unrelated to it** — different subject (sync attempts vs presence
sessions), different owner (`BC-30` execution vs `BC-03` policy). ⛔ **No presence rule is altered.**
⭐ `ATT-NFR-005`'s requirement that failure signals be **distinguishable** supports `EVT-RETRY-3`'s
*terminal-failed* disposition rather than conflicting with it.

---

## §5 Method and baseline

### 5.1 Recorded in the ADR; no configurable created

The **`ADR-0058` / `ADR-0119` / `ADR-0120` / `ADR-0121`** shape — `Amends: Nothing`, with the obligation
attached to the **`E-24` Sync port** that BC Map **L333** already declares.

⛔ **No `ATT-CFG-*` row is created**, and the reason is load-bearing: a configurable would be a **Rank-3
register change to a FROZEN PRD**, expressly outside this conferral, and `PRD-006` **L2332** treats
uninvented retry values as prohibited content rather than as empty slots. ⭐ The values are therefore
**fixed by this ADR**, not configured.

### 5.2 No baseline movement

| §7 rule | Applies? |
|---|---|
| 1 — Rank 1–5 change needs a prior ADR | ⛔ **Not engaged** — no Rank 1–5 document changes |
| 2 — version + changelog same commit | ⛔ **Not engaged** |
| 3 — declaration updated same commit | ⛔ **Not engaged** |
| 4 — identifier moves on Rank 1–3 version change | ⛔ **Not engaged.** `BASELINE-2026-09-03-A` **stands** |

⚠ **Cost disclosed:** a reader of `PRD-006` or the BC Map alone will **not** find `EVT-RETRY-1`…`-4` — the
same condition `ADR-0058`/`ADR-0119`/`ADR-0120`/`ADR-0121` created. A future Architecture-Owner act **may**
mirror them into Rank 3/4; this ADR **neither performs nor requires** that.

---

## §6 Dependency re-audit

| Item | Before | After | Reason |
|---|---|---|---|
| **3 — Durable Queue** | ✅ RESOLVED | ✅ **RESOLVED** | `ADR-0119` + `ADR-0120`, unchanged |
| **7b — Queue depth** | ✅ RESOLVED | ✅ **RESOLVED** | `ADR-0121`, unchanged (§4.3 records the interaction) |
| **⭐⭐ 5 — Retry/Backoff** | ⛔ OPEN | ✅ **RESOLVED** | **This ADR** — limit, backoff, exhaustion **and** timestamp constraint. ⛔ **RESOLVED ≠ IMPLEMENTABLE** |
| **9b — At-rest** | ⛔ OPEN — eligible | ⛔ **OPEN — eligible, not resolved** | **`ATT-GAP-006` OPEN**; SECURITY PLATFORM's |
| **7a — Retention** | ⛔ OPEN | ⛔ **OPEN — untouched** | ⭐ **A retry schedule is not a retention period.** `Q-04`; `ATT-GAP-005` |
| **8b-residual** | ⚠ owner decision | ⚠ **REQUIRES OWNER DECISION — untouched** | ⚠ **Now load-bearing for THREE ADRs** (§3.1) |
| **`ATT-GAP-017a`** | 🔴 OPEN | 🔴 **OPEN — untouched** | §4.5 — no latency/throughput/percentile target stated |

⭐⭐ **All four items of the original Offline-Sync dependency chain (4 → 3 → 9b/7b) plus Item 5 are now
governed**, with **9b, 7a and 8b-residual** remaining as independent owner decisions. ⛔ **No implementation
is authorised.**

⛔ This ADR confers **no lifecycle stage**, creates **no** context, edge, event, port, aggregate or
requirement identifier, allocates **0** `IMPL-*`, mints **0** `SYNC-*`, and touches **0** application-code files.

---

## §7 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐ **Created and ACCEPTED. ITEM 5 IS RESOLVED.** **Architecture Owner + Product Owner**, under a **new** one-act conferral (⛔ **no prior conferral reused** — `ADR-0117`'s and `ADR-0118`'s were spent by `ADR-0119`/`ADR-0121`), record **`EVT-RETRY-1`** *5 attempts*, **`EVT-RETRY-2`** *exponential 1, 2, 4, 8, 16 minutes*, **`EVT-RETRY-3`** *retain as terminal-failed and surface for explicit/manual resolution, no silent discard*, and **`EVT-RETRY-4`** *preserve the original attendance capture timestamp; replay time MUST NOT replace it* — **all VERBATIM**, not substituted, weakened, strengthened, rounded, re-derived or reinterpreted. ⭐ **Two offices jointly** because the decision has a mechanism limb (Architecture, **L85**) and a disposition limb (Product, **L83**) — the `ADR-0011` *"three roles for one decision"* precedent. ⭐ **The value could only be SUPPLIED, never derived:** a six-sweep audit measured **0** authoritative retry values and rejected four near-misses by scope — `FIL-CFG-014` (`BC-29`), `NTF-CFG-004` (`BC-22`), BC Map §9.1's qualitative row (no count/delay, and it does not reach `BC-30`), and `ADR-0028` C-3 (which **forbids** inventing a backoff, and is only `Proposed`); the lawful route is the `ATT-GAP-017`/`ADR-0021` owner-supplied-values precedent. ⭐⭐ **SIX COHERENCE TESTS RUN BEFORE RECORDING (§4):** **(i)** `EVT-RETRY-3` **satisfies** `ADR-0119` **D-4** rather than merely avoiding it — D-4 was a prohibition **without** a mechanism, and this supplies the disposition **without amending it**; **(ii)** **consistent with `ADR-0120` `EVT-PERS-1`** — a retry limit could have been misread as a third, implicit termination, and `EVT-RETRY-3` **forecloses** that by making exhaustion produce **retention, not disposal**; **(iii)** ⚠ **a real interaction with `ADR-0121` is recorded, not glossed** — retained terminal-failed items keep occupying slots and count toward the **500/device** bound, after which `EVT-DEPTH-2` blocks new captures; that is a **coherent consequence** of *"no silent discard"*, since the alternative would free capacity by dropping data; **(iv)** **`EVT-RETRY-4` CONFIRMS frozen `ATT-FR-088`** and `PRD-006` **L2433–2436** (*"late arrival … whenever it arrives"*, ordering by the platform time port) — a restatement in the retry context, where the frozen rule is easiest to breach, **not** a new rule; **(v)** ⚠ **`ATT-NFR-003` does NOT bar these values**, on two limbs — it binds *"**this document**"* (`PRD-006`, **byte-unchanged**) and it bars **latency/throughput/percentile** figures, which a **backoff interval is not**; **`ATT-GAP-017a` stays OPEN and is NOT closed**; **(vi)** **0** value collisions, and the **5-minute presence grace** was checked and is a different subject and owner — **no presence rule altered**; `ATT-NFR-005`'s distinguishable-failure requirement **supports** the terminal-failed disposition. ⚠⚠ **ONE LIMB UNDEFINED AND DISCLOSED (§3.1):** *"explicit/manual resolution"* is **not defined, implied or pre-judged** — this is the **THIRD** ADR to terminate on the repository's undefined disposal/resolution route (after `EVT-PERS-1` and `EVT-DEPTH-2`), substantially the **8b-residual** question, now **load-bearing for three ADRs**; retention after exhaustion is **unconditional**, so the gap makes the guarantee **stronger, never weaker**. ⛔ **NOTHING ELSE AUTHORISED (§3):** no storage technology, database, queue product, schema, encryption, retention, cloud resource, Supabase configuration or application implementation; ⛔ **conflict-resolution semantics, queue depth (500/device), the persistence guarantee and at-rest protection are ALL untouched**, exactly as the conferral required; ⭐ **a retry schedule is NOT a retention period**, so **7a stays OPEN**; ⛔ **no `ATT-CFG-*` row created** — a configurable would be a Rank-3 change to a FROZEN PRD. ⛔ **Amends NOTHING**; `PRD-006`, BC Map, `MASTER_PRD`, `ADR-0114`…`ADR-0121`, `DOCUMENTATION_BASELINE`, `CONFIGURATION_GUIDE` and `tool/module_dependencies.yaml` **byte-unchanged**; §7 rules 1–4 each tested and **all unmet**, so **no version bump** and **`BASELINE-2026-09-03-A` stands**; ⚠ cost disclosed — a `PRD-006`-or-BC-Map-only reader will not find these labels, and mirroring is **neither performed nor required**. ⛔ **No standing authority; no person named; `PRD-018` not created; 0 `IMPL-*`; 0 `SYNC-*`; 0 code/config/dependency files; Implementation authorised: No.** |
