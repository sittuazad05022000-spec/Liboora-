# ADR-0123 — The `BC-03` treatment of a legitimately captured offline attendance mutation when the actor is **unauthorized at replay**: Item 8b-residual RESOLVED

| Field | Value |
|---|---|
| **ADR** | `ADR-0123` |
| **Status** | **Accepted** — 2026-09-08 |
| **Date** | 2026-09-08 |
| **Deciders** | **Product Owner + `BC-03` Domain Owner**, by **direct, explicit conferral from the human principal**, **for one act only**: *"to decide and record the `BC-03` treatment of a legitimately captured offline attendance mutation when the actor is revoked, expired, or otherwise unauthorized at replay."* ⭐ **Exactly the two offices the audit named**, and exactly the two `PRD_OWNERSHIP_MODEL.md` **L163** assigns to `PRD-006` / `BC-03` — Product Owner for *"business intent: scope, priority, acceptance"* (**L83**) and Domain Owner for *"correctness … within its bounded contexts; ubiquitous language; invariants"* (**L84**). ⛔ No ARB quorum, attendee list, sign-off date or Security review is asserted. ⛔ **No holder appointed, no personal name recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). ⛔ Both offices revert to their prior state after this act — **ONE ACT ONLY, NOT A STANDING LICENCE** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*). |
| **Subject** | The disposition of a legitimately captured offline attendance mutation whose actor is revoked, expired or otherwise unauthorized at the moment of replay (Item 8b-residual) |
| **Supersedes** | **Nothing** |
| **Amends** | ⛔ **Nothing.** No PRD, no BC Map, no Dependency Matrix, no manifest, no EA, no `MASTER_PRD.md`, no `CONFIGURATION_GUIDE.md`, no other ADR — the **`ADR-0058` / `ADR-0119` / `ADR-0120` / `ADR-0121` / `ADR-0122` shape**: a decision recorded **in the ADR itself** (§6) |
| **Amended by** | — |
| **Does NOT amend** | `MASTER_PRD.md` (Rank 1) · **BC Map (Rank 4), incl. §9.1, `E-20` L329 and `E-24` L333** · Dependency Matrix (Rank 4) · **`PRD-006` (Rank 3, FROZEN)** — ⛔ **no `ATT-INV-*`, `ATT-FR-*`, `ATT-BR-*`, `ATT-PO-*`, `ATT-CFG-*`, `ATT-NFR-*` or `ATT-AC-*` identifier is minted, moved or altered** · **`PRD-001` (Rank 3, FROZEN)** — ⛔ `AUTH-8.38`, `BR-7.1`, `AUTH-6.74` and the whole `XC-6.*` table are **untouched and unweakened** · `PRD-016` Audit Trail · every other frozen PRD · **`ADR-0119`, `ADR-0120`, `ADR-0121`, `ADR-0122`** · `ADR-0114`…`ADR-0118` · `ADR-0030` (`Proposed`, byte-unchanged) · `ADR-0036` · `DOCUMENTATION_BASELINE.md` · `PRD_OWNERSHIP_MODEL.md` · `tool/module_dependencies.yaml` |
| **Baseline** | ⛔ **No baseline re-issue and no version bump anywhere.** `BASELINE-2026-09-03-A` stands — `DOCUMENTATION_BASELINE.md` §7 rules 1–4 are **all unmet**, because **no Rank 1–5 document changes** (§7.2) |
| **Closes** | ⭐⭐ **Item 8b-residual.** All limbs of the conferred decision are recorded: the **timestamp rule** (§2 `EVT-AUTHZ-1`, `EVT-AUTHZ-2`), the **no-duplicate rule** (§2 `EVT-AUTHZ-3`), the **no-silent-discard rule** (§2 `EVT-AUTHZ-4`), the **retention/surfacing disposition** (§2 `EVT-AUTHZ-5`) and the **scoped disposal-path constitution** (§2 `EVT-AUTHZ-6`) |
| **Does NOT close** | ⛔ **Item 9b** at-rest protection (`ATT-GAP-006` **OPEN**) · ⛔ **Item 7a** retention period (`Q-04` **open**; ⭐ **a retention *disposition* is not a retention *period*** — §3) · ⛔ **Item 7a's** `PRD-018` limb · ⛔ `ATT-GAP-017a` (latency/throughput) · ⛔ `ATT-GAP-016a` (offline Dynamic QR) · ⛔ `ADR-0030`'s six Security validation points, which stay `Proposed` and open · ⛔ **the general disposal/resolution route** beyond this exact scenario (§3.2) · ⛔ **no implementation authority** |
| **Related** | `ADR-0119` **D-4** (*no silent discard*) · `ADR-0120` **`EVT-PERS-1`** · `ADR-0121` **`EVT-DEPTH-1`/`-2`** · `ADR-0122` **`EVT-RETRY-1`…`-4`** · `PRD-006` `ATT-FR-088`, `ATT-FR-089`, `ATT-INV-003`, `ATT-INV-008`, `ATT-FR-019`, `ATT-FR-129`…`133`, `ATT-PO-011`…`013`, §27.1 · `PRD-001` `AUTH-8.38`, `BR-7.1`, `AUTH-6.74`, `XC-6.4`…`XC-6.7`, `AUTH-10.4` · BC Map `E-20`, `E-24` · `ADR-0030` §6A (which **named** this gap and declined to decide it) |
| **Implementation authorised** | ⛔ **No** |

> ⚠⚠ **READ THIS FIRST.** This ADR records **one product/domain treatment**, in the human principal's exact
> words. It authorises **no** storage technology, database, queue product, schema, encryption, retention
> period, retry change, cloud resource, **Supabase** configuration, `PRD-018` or application
> implementation. **A treatment is not an implementation.**

---

## §1 The question, exactly as it stood

⭐ **The immediately preceding audit measured the gap and refused to fill it.** Its finding, verbatim
from the `IMPLEMENTATION_BLOCKER_REGISTER.md` §13.4 entry it produced:

> *"⛔ **THE RESIDUE IS UNRESOLVED AND IS NOT INVENTED:** what becomes of a **legitimately captured**
> offline mutation whose actor's access is revoked or expired **before** replay. Measured: a repository
> sweep for a queued-item disposition on revoked access returns **ZERO** authority."*

⭐ **What was already settled and is preserved here unweakened:**

| Settled | Authority |
|---|---|
| Replay is a **fresh** authorization decision; revoked/expired access **cannot be silently carried forward** | `AUTH-8.38` (*"A session MUST NOT carry authorization; authorization MUST be evaluated at the moment of each decision"*), `BR-7.1`, `AUTH-6.74` — FROZEN `PRD-001` |
| Already-**stored** attendance facts are safe | `ATT-INV-008`, `ATT-AC-149` — FROZEN `PRD-006` |
| Revocation is **forward-acting**; `ATT-FR-016` is **QR-scoped, not actor-scoped** | `ATT-FR-015` (L616), `ATT-FR-016` (L617) |

⭐⭐ **What was NOT settled, and is settled by this act:** the disposition of the queued mutation itself
when that fresh authorization decision **refuses**.

⭐ **`ADR-0030` §6A had already named this exact gap and expressly declined to close it** — *"Attendance
needs the resolution **most** in exactly the case Authentication is **least** able to serve it: an
observation queued offline and replayed later through `E-24`, when no live session exists."* ⛔ It remains
**`Proposed`**, binding nothing, and is **byte-unchanged** by this act.

---

## §2 ⭐⭐ The decision

**The `BC-03` treatment is:**

> **`EVT-AUTHZ-1` — If an attendance mutation was legitimately captured while the actor was authorized, its
> ORIGINAL CAPTURE TIMESTAMP remains the attendance time.**
>
> **`EVT-AUTHZ-2` — Replay/sync time, Wi-Fi connection time, Presence observation time, or retry time MUST
> NOT replace or rewrite that original attendance timestamp.**
>
> **`EVT-AUTHZ-3` — If a later Presence observation or another attendance attempt concerns the same
> student/day, it MUST NOT automatically create a duplicate attendance when a valid attendance already
> exists.**
>
> **`EVT-AUTHZ-4` — If the actor is unauthorized at replay, the queued mutation MUST NOT be silently
> discarded.**
>
> **`EVT-AUTHZ-5` — It MUST be retained as an audit-bearing rejected mutation and surfaced for
> explicit/manual resolution.**
>
> **`EVT-AUTHZ-6` — This treatment constitutes the explicit resolution/disposal path referenced by
> `EVT-PERS-1`, `EVT-DEPTH-2` and `EVT-RETRY-3` only to the extent necessary for this exact scenario.**

⭐ **Recorded VERBATIM** as the principal stated it. ⛔ **Not substituted, weakened, strengthened,
paraphrased, generalised or reinterpreted.** The identifiers `EVT-AUTHZ-1`…`-6` are **citation labels
only**, on the established `EVT-PERS-1` / `EVT-DEPTH-*` / `EVT-RETRY-*` pattern; they add no content and are
**not** `SYNC-*`, **not** `ATT-*`, **not** `ATT-CFG-*`, **not** `AUTH-*`, and are **not** added to any PRD
register. ⭐ Measured before minting: **0** pre-existing occurrences of `EVT-AUTHZ` anywhere in `docs/`.

### 2.1 ⭐ Which outcome this is, stated plainly

The audit listed four candidate outcomes and chose none. **The principal has selected outcome 3 —
*refuse but retain as an audit-bearing rejection*** — and has additionally fixed the **timestamp** and
**no-duplicate** limbs, which the audit had not enumerated as separable.

| Audit candidate | Selected? |
|---|---|
| 1 — Admit as historical fact (capture-time authorization governs) | ⛔ **No.** The mutation is **not** admitted as attendance on the strength of capture-time authorization |
| 2 — Refuse and discard | ⛔ **No.** `EVT-AUTHZ-4` forbids silent discard |
| **3 — Refuse but retain as an audit-bearing rejection** | ⭐⭐ **YES** — `EVT-AUTHZ-4` + `EVT-AUTHZ-5` |
| 4 — Another owner-defined treatment | ⛔ Not invoked |

⚠ **`EVT-AUTHZ-1`/`-2` are NOT candidate 1 in disguise, and the distinction is load-bearing.** They fix
*which instant is the attendance time* **for a mutation that is admitted**; they do **not** state that a
mutation from an unauthorized actor **is** admitted. ⛔ **Reading them as an admission rule would be an
inference this act does not make.** `EVT-AUTHZ-4`/`-5` govern the unauthorized case, and they produce a
**rejection**, not an attendance.

### 2.2 What the decision's own terms do and do not fix

| Term | What it fixes | What it does **NOT** fix |
|---|---|---|
| *"ORIGINAL CAPTURE TIMESTAMP remains the attendance time"* | The attendance instant is the **capture** instant, not any later instant | ⛔ **No time source, clock, format, timezone rule or precision** — `ATT-FR-088`'s platform-time-port rule already governs and is unamended (§4.2) |
| *"MUST NOT replace or rewrite"* | Four named later instants are barred: replay/sync, Wi-Fi connection, Presence observation, retry | ⛔ **No mechanism** by which preservation is achieved; no schema, field or column |
| *"MUST NOT **automatically** create a duplicate"* | Automatic duplication is barred where a valid attendance already exists | ⛔ **No** idempotency key, comparison rule, merge policy or conflict algorithm is stated — `ATT-INV-003` and `ATT-FR-090`…`095` already govern (§4.3). ⚠ *"automatically"* is preserved as stated and is **not** read as *"never, by any route"* |
| *"MUST NOT be silently discarded"* | Silence is absolutely barred | ⛔ **No** surfacing channel, UI, notification, alert or escalation ladder |
| *"retained as an audit-bearing rejected mutation"* | The disposition: **retention**, with the record **audit-bearing** | ⛔ **No** audit store, retention period, storage medium, encryption or schema — `ATT-FR-129`/`E-20` already own audit emission and `ATT-FR-130` forbids an attendance-specific audit store (§4.5) |
| *"surfaced for explicit/manual resolution"* | That a human route exists | ⛔ **Who** may perform it, what actions it offers, and what it may end in are **NOT** fixed here (§3.2) |
| *"only to the extent necessary for this exact scenario"* | The scope boundary of `EVT-AUTHZ-6` | ⛔ **No general disposal doctrine** — see §3.2 |

---

## §3 What this act does NOT authorise

⛔ **Nothing beyond the six statements in §2.** Tested item by item, as the conferral required
(*"Do not invent any additional attendance, Presence, authorization, retention, storage or implementation
rules"*):

| Category | Authorised here? |
|---|---|
| **Attendance rules** | ⛔ **None beyond §2.** No new status value, mode, session rule, duration rule, correction rule or invariant. The nine `PRD-006` §10A.1 statuses are **untouched** |
| **Presence rules** | ⛔ **None.** No observation rule, grace, tolerance, exit precedence or fabrication permission. ⚠ `EVT-AUTHZ-2` **names** Presence observation time only to **bar** it as a timestamp source — it states no Presence rule |
| **Authorization rules** | ⛔ **None.** `AUTH-8.38`, `BR-7.1`, `AUTH-6.74`, `XC-6.4`…`XC-6.7` are **preserved verbatim and unweakened**. ⛔ No revocation window, expiry rule, session rule or evaluation point is created or altered |
| **Retention** | ⛔ **No period, TTL, purge, archival or schedule.** ⭐ **A retention *disposition* is not a retention *period*** — `Q-04` (BC Map **L543**) and **Item 7a** stay **OPEN** |
| **Storage** | ⛔ **No** medium, database, queue product, file format, schema, index, encryption or at-rest protection. **Item 9b** stays open behind `ATT-GAP-006` |
| **Retry / backoff** | ⛔ **Unchanged.** `ADR-0122`'s `EVT-RETRY-1`/`-2` values stand exactly. ⚠ `EVT-AUTHZ-2` bars *retry time* as a timestamp source — it changes **no** retry count, interval or ladder |
| **Queue depth** | ⛔ **Unchanged.** `ADR-0121`'s 500/device stands exactly |
| **Supabase / infrastructure** | ⛔ **Nothing.** `ADR-0116`'s selection is a **server-side runtime** choice and is **not** read as implying any client-side or audit mechanism |
| **`PRD-018`** | ⛔ **Not created, not authorised, not re-statused.** Still `PLANNED` |
| **Implementation** | ⛔ **No.** 0 code, config, dependency or `IMPL-*` artefacts |
| **Standing authority** | ⛔ **None.** One act only |

### 3.1 ⭐⭐ The undefined limb that THIS act closes — and the precise extent

⭐⭐ **Three Accepted ADRs terminated on a disposal/resolution route the repository had never defined:**

| ADR | The undefined phrase |
|---|---|
| `ADR-0120` `EVT-PERS-1` | *"until it is either replayed or **explicitly disposed of**"* |
| `ADR-0121` `EVT-DEPTH-2` | *"until replay or **explicitly authorized disposal**"* |
| `ADR-0122` `EVT-RETRY-3` | *"surface it for **explicit/manual resolution**"* |

⭐ **`EVT-AUTHZ-6` supplies that route — and bounds itself.** It constitutes the explicit
resolution/disposal path *"**only to the extent necessary for this exact scenario**"*, namely: an
attendance mutation legitimately captured while authorized, whose actor is unauthorized at replay.

### 3.2 ⚠⚠ What remains undefined, disclosed rather than buried

⛔ **The general disposal/resolution route is STILL NOT defined**, and this act does not define it:

- ⛔ **Disposal for reasons other than actor unauthorization** — e.g. a mutation that exhausts retries for
  purely transport reasons (`EVT-RETRY-3`'s ordinary case), or one preserved at the `EVT-DEPTH-2` bound with
  no authorization problem — has **no** defined disposal route. `EVT-AUTHZ-6`'s own words exclude it.
- ⛔ **Who** may perform the *"explicit/manual resolution"*, **what actions** that route offers, and
  **whether it may end in destruction** are **NOT** stated. `EVT-AUTHZ-5` requires the item be *surfaced
  for* resolution; it does not enumerate the resolution.
- ⛔ **Where** the audit-bearing rejected mutation lives is **NOT** stated. ⚠ `ATT-FR-130` forbids `BC-03`
  creating *"an attendance-specific audit store"* and `ATT-FR-129`/`E-20` route audit facts to **`BC-24`**;
  ⛔ **this ADR does not resolve which of those applies to a rejected-mutation record**, because doing so
  would be an architecture/ownership act outside this conferral.

⭐ **The decision is nonetheless complete and operative for the conferred scenario**: retention is
**unconditional** and *"MUST NOT be silently discarded"* is **absolute**. ⭐ **An undefined resolution
route makes the guarantee stronger, never weaker** — nothing may be destroyed on the strength of a
resolution rule that does not exist.

---

## §4 ⭐⭐ Coherence, tested rather than assumed

⭐ **Seven conflict tests were run before recording.** A treatment contradicting frozen authority would be
worse than leaving 8b open.

### 4.1 ⭐ `EVT-AUTHZ-4`/`-5` SATISFY `ADR-0119` D-4 — as `EVT-RETRY-3` did, on a different trigger

| Accepted authority | Requirement | Satisfied? |
|---|---|---|
| `ADR-0119` **D-4** (§2 L55) | *"**No silent discard.** A queued item that fails to replay **MUST NOT** vanish; its failure must remain an observable signal"* | ✅ **Yes, exactly and on both limbs.** `EVT-AUTHZ-4` supplies *"MUST NOT be silently discarded"* — the **vanish** prohibition; `EVT-AUTHZ-5` supplies *"retained as an audit-bearing rejected mutation and surfaced"* — the **observable signal**. ⭐ D-4 was **deliberately a prohibition without a mechanism** (`ADR-0119` §2, L73–74); this supplies the disposition for the **authorization-refusal** trigger **without amending D-4** |

⚠ **Note the trigger difference, which is why this is not duplicative of `ADR-0122`.** `EVT-RETRY-3`
satisfies D-4 for **retry exhaustion** (a transport/replay failure). `EVT-AUTHZ-4`/`-5` satisfy it for
**authorization refusal** — a distinct failure mode that **retrying cannot cure**, since re-attempting a
revoked actor's mutation five times cannot make it authorized. ⛔ **`ADR-0122` is not amended, and its retry
values are unchanged.**

### 4.2 ⭐⭐ `EVT-AUTHZ-1`/`-2` are CONSISTENT with frozen `PRD-006` — the test the conferral asked for by name

⚠ **This was the highest-risk test**, because `EVT-AUTHZ-1` says *"original capture timestamp"* while
frozen `ATT-FR-088` forbids client-supplied time. **Both hold, and the reconciliation is that they answer
different questions.**

| Frozen authority | Text | Conflict? |
|---|---|---|
| **`ATT-FR-088`** (L1647) | *"Every attendance timestamp **MUST** be obtained from the **platform time port**, never from `DateTime.now()` in the domain and never from the client (`X-09`)"* | ✅ **No conflict.** ⭐ `ATT-FR-088` fixes the **SOURCE** of a timestamp; `EVT-AUTHZ-1` fixes **WHICH INSTANT** is the attendance time. ⛔ `EVT-AUTHZ-1` does **not** say the timestamp comes from the device clock, and **no** device-clock authority is created — `ATT-FR-088`/`X-09` govern the source **unamended** |
| **`PRD-006` L2436** | *"Ordering by the platform time port (`ATT-FR-088`), never by device clock"* | ✅ **No conflict** — ordering is untouched; `EVT-AUTHZ-1`/`-2` state no ordering rule |
| **`PRD-006` L2433–2435** | *"**Late arrival of an observation MUST NOT fabricate a disconnect that was never observed**: a queued loss is an observed loss **whenever it arrives**"* | ⭐⭐ **CORROBORATES.** Frozen Rank 3 already establishes that a queued item's **arrival time is not its event time**. `EVT-AUTHZ-1`/`-2` are the same principle stated for the capture instant |
| **`ATT-FR-089`** (L1650) | *"Attendance **MUST** be evaluated against the `AttendanceRules` in force **at the moment it was recorded**. A later policy change **MUST NOT** retroactively reclassify an existing record"* | ⭐⭐ **CORROBORATES.** Frozen Rank 3 already anchors evaluation to the **recording moment**, not a later one |
| **`ADR-0122` `EVT-RETRY-4`** | *"Preserve the original attendance capture timestamp. Replay/retry time MUST NOT replace the original attendance time"* | ⭐⭐ **CONSISTENT AND NARROWER-SUPERSET.** `EVT-AUTHZ-1`/`-2` state the **same rule** and extend the barred-source list from `{replay, retry}` to `{replay/sync, Wi-Fi connection, Presence observation, retry}`. ⛔ **`EVT-RETRY-4` is NOT amended, contradicted or superseded** — every instant it bars remains barred |

⭐ **Verdict: `EVT-AUTHZ-1`/`-2` CONFIRM frozen authority and one Accepted ADR rather than adding to them**,
and recording them is valuable precisely because the unauthorized-replay path is where the frozen rule is
easiest to breach. ⛔ **`ATT-FR-088`, `ATT-FR-089` and `PRD-006` L2433–2436 are byte-unchanged.**

### 4.3 ⭐ `EVT-AUTHZ-3` CONFIRMS existing frozen idempotency rather than creating a rule

| Frozen authority | Text | Relation |
|---|---|---|
| **`ATT-INV-003`** (L448) | *"A punch **MUST** be **idempotent by `(studentRecordId, date, idempotencyKey)`**"* | ⭐ `EVT-AUTHZ-3` is this invariant stated for the Presence/second-attempt case. ⛔ **No key is altered** |
| **`ATT-FR-019`** (L633) | *"A repeated scan … within the same `AttendanceDay` **MUST** be resolved by the idempotency rule (`ATT-INV-003`) and **MUST NOT** create a second check-in"* | ⭐⭐ **Near-identical in substance.** `EVT-AUTHZ-3` extends the same *no-duplicate* posture to a **Presence observation or another attendance attempt** |
| **`PRD-006` L2430–2431** (§27.1) | *"a replayed observation **MUST** be absorbed by idempotency … rather than applied twice"* | ⭐⭐ **CORROBORATES directly** |
| **`ATT-PO-012`** (L2419) | *"A replayed punch **MUST** be absorbed by idempotency (`ATT-INV-003`), not applied twice"* | ⭐ **CORROBORATES** |
| **`ATT-PO-013`** (L2422) | *"A replayed punch **MUST NOT** overwrite a correction made while the device was offline"* | ✅ **Preserved.** `EVT-AUTHZ-3` bars automatic duplication and states **nothing** about overwriting a correction |
| **`ATT-INV-004`** (L450) | *"no more than one open session per student at any moment"* | ✅ **Preserved and reinforced** |

⛔ **`ATT-PO-011` is honoured**: `BC-03` here **defines the policy** and **does not** implement the queue,
the replay or the conflict detection. This ADR creates **no** queue, replay loop or conflict detector.

### 4.4 ⭐ Consistent with `ADR-0120` `EVT-PERS-1` and `ADR-0121` `EVT-DEPTH-1`/`-2`

| Accepted authority | Requirement | Breached? |
|---|---|---|
| `ADR-0120` **`EVT-PERS-1`** | Persisted *"until it is either replayed or explicitly disposed of"* | ✅ **No — this act SUPPLIES the second terminating condition for one scenario.** ⚠ And it supplies it as **retention, not destruction**: an audit-bearing rejected mutation is **retained**. ⛔ `EVT-PERS-1` is **not amended**; its durability obligation continues to attach until an actual disposal occurs, which this act does not perform |
| `ADR-0121` **`EVT-DEPTH-2`** | *"preserving all already-captured queued mutations until replay or explicitly authorized disposal"* | ✅ **No.** `EVT-AUTHZ-4`/`-5` are **preservation**, exactly as `EVT-DEPTH-2` requires |
| `ADR-0121` **`EVT-DEPTH-1`** | 500 queued offline attendance mutations per device | ✅ **Unchanged.** ⚠ **The capacity interaction the prior audit flagged is REAL and is recorded, not glossed** — see §4.6 |
| `PRD-006` **L853** | *"a per-device audit trail is **not** a per-device attendance"* | ✅ **Preserved.** `EVT-AUTHZ-5`'s *audit-bearing* record is an **audit** artefact; `EVT-AUTHZ-3` keeps student/day attendance **singular** |

### 4.5 ⭐ `EVT-AUTHZ-5`'s "audit-bearing" is consistent with `PRD-006`'s audit posture — with one limb left open

| Frozen authority | Text | Relation |
|---|---|---|
| **`ATT-FR-129`** (L2051) | *"Audit facts **MUST** be emitted to **`BC-24` Audit Trail** via **`E-20`**, as fire-and-forget"* | ⭐ An existing, already-authorised route for audit facts. ⛔ **`E-20` is not amended and no new edge is created** |
| **`ATT-FR-130`** (L2054) | *"This module **MUST NOT** create an attendance-specific audit store"* | ⚠ **Honoured by silence.** ⛔ This ADR creates **no** audit store — and, per §3.2, **does not decide** where the rejected-mutation record lives |
| **`ATT-FR-132`** (L2064) | *"Every audit fact **MUST** carry the acting actor and the tenant of record"* | ✅ **Preserved and unamended** |
| **`ATT-FR-133`** (L2066) | *"No audit fact **MUST** contain an authentication secret"* | ✅ **Preserved and unamended** |
| **`AUTH-10.4`** | *"Authentication **MUST NOT** own audit storage, retention or querying; it **MUST** only produce audit-worthy facts"* | ✅ **Consistent** — this is a `BC-03` treatment, not an Authentication one, which is precisely why the audit found Authentication structurally unable to supply it |
| **`ATT-BR-011`** (L628) | *"A failure **MUST NOT** be silent … 'nothing happened' is not an acceptable result"* | ⭐⭐ **CORROBORATES `EVT-AUTHZ-4`** at Rank 3, independently of `MP-NFR-02` |

### 4.6 ⚠ A real capacity interaction is RECORDED, not glossed

⚠ Retained audit-bearing rejected mutations **continue to occupy queue slots** and therefore count toward
`EVT-DEPTH-1`'s **500/device** bound, after which `EVT-DEPTH-2` **blocks new offline captures**. ⭐ **This
is a coherent consequence of *"no silent discard"*, not a contradiction** — the alternative frees capacity
by destroying data, which `ADR-0119` D-4 forbids. ⚠ **It follows that a device whose actor is revoked can
accumulate rejected mutations toward the bound**, and the *"explicit/manual resolution"* route
(`EVT-AUTHZ-5`) is the only thing that relieves it. ⛔ **No depth value, blocking behaviour or relief
mechanism is changed or created here**; `ADR-0121` stands unamended. ⚠ This is disclosed as a **known
operational consequence** for whoever later receives implementation authority.

### 4.7 ⭐ Authorization authority is preserved unweakened — the test that mattered most

⚠ **The risk was that `EVT-AUTHZ-1`'s *"legitimately captured while the actor was authorized"* could be
misread as authorization being carried forward from capture.** It is not.

| Frozen `PRD-001` | Text | Weakened? |
|---|---|---|
| **`AUTH-8.38`** (L2861) | *"A session **MUST NOT** carry authorization; authorization **MUST** be evaluated at the moment of each decision"* | ✅ **NOT weakened.** ⭐ `EVT-AUTHZ-4`/`-5` are **premised on** a fresh evaluation having **refused** — the mutation is **rejected**, not admitted |
| **`BR-7.1`** (L2614) | *"Authorization is evaluated at every access decision, never captured at sign-in"* | ✅ **NOT weakened** |
| **`AUTH-6.74`** | *"revocation … **MUST** be evaluated on every use. Devices **MUST NOT** hold authoritative copies"* | ✅ **NOT weakened** — no device-side authorization cache is created |
| **`XC-6.4`…`XC-6.7`** (L2149–2152) | *"Refused at next use"* · *"The next operation is refused"* · *"refused on first contact"* · *"**Refused. Elapsed real time governs, not connected time**"* | ✅ **NOT weakened, and CONSISTENT.** ⭐ The **operation is refused**, exactly as they require; this ADR adds only what becomes of the **queued data** after that refusal — which the audit measured they are silent on |

⭐⭐ **The two rules are compatible because they act on different objects**: `PRD-001` refuses the
**operation**; `EVT-AUTHZ-4`/`-5` retain the **data** as a rejection. ⛔ **No authorization rule, revocation
window, expiry rule or evaluation point is created, altered or relaxed.**

---

## §5 Coherence with the wider repository

| Authority | Preserved? |
|---|---|
| `ATT-INV-008` / `ATT-AC-149` — no **stored** fact destructively updated or deleted | ✅ **Yes, and NOT stretched.** ⚠ The audit measured (via `ATT-AC-119`, L2724 — *"no attendance fact exists outside [an `AttendanceDay`]"*) that a queued item is **not yet** a stored fact. ⛔ **This ADR neither asserts nor denies that**; it makes the point moot by **retaining** the item regardless |
| `ATT-AC-119` (L2724) | ✅ **Preserved.** `EVT-AUTHZ-5`'s rejected mutation is **not** asserted to be an attendance fact, so nothing is claimed to exist outside an `AttendanceDay` |
| `ATT-NFR-012` — offline behaviour not promised beyond `E-24` | ✅ **Yes.** A rejection-and-retention treatment **promises the student less, not more**; no new mode, code path or user-visible capability |
| `ATT-GAP-016a` — offline Dynamic QR undefined (`ATT-PO-014`) | ✅ **Untouched and still OPEN** |
| `ATT-GAP-005` — *"A PRD may not promote an architecture document's own open question to an answer"* | ✅ **Honoured.** The values are **conferred by the owning offices**, not derived from `ADR-0030`'s open Security points or from general authorization rules |
| `ATT-GAP-006` — cryptographic construction is Security Platform's | ✅ **Untouched; Item 9b stays open** |
| `ATT-NFR-003` / `ATT-GAP-017a` | ✅ **Untouched.** ⛔ No latency, throughput or percentile figure is stated anywhere here |
| `PRD-006` **L2332** — *"none may be invented"* | ✅ **Honoured.** ⛔ No cooldown, frequency, quiet-hour rule, retry count or escalation ladder is stated |
| `ADR-0036` retain-and-flag | ✅ **Untouched.** It is `BC-04` seating-scoped and its own §207 records the question *"**OPEN.** This ADR does **not** close it"* — ⛔ **it was NOT used as a precedent to derive this decision** |
| `ADR-0030` (`Proposed`) | ✅ **Byte-unchanged.** ⛔ Its six Security validation points, including *"revoked device handling"*, remain **open** — this ADR decides an **actor-authorization** question, not a **device-trust** one |
| `MP-CON-01` / `MP-CON-03` | ✅ **Yes** — the treatment is **vendor-neutral** and names no product |
| BC Map: 31 contexts / 29 edges, §8's 17 aggregate rows | ✅ **Byte-unchanged.** No context, edge, event, port or aggregate created |

---

## §6 Where the decision is recorded

⭐ **In this ADR (§2), on the `ADR-0058` / `ADR-0119` / `ADR-0120` / `ADR-0121` / `ADR-0122` shape** — a
Rank 2 Accepted ADR recording a substantive obligation while amending nothing.

⚠ **Cost disclosed, not hidden:** a reader consulting only `PRD-006` or only the BC Map will **not** find
`EVT-AUTHZ-1`…`-6`. That is the same condition `ADR-0058`, `ADR-0061`, `ADR-0119`, `ADR-0120`, `ADR-0121`
and `ADR-0122` created. ⭐ A future **Architecture Owner** act **may** mirror these into Rank 4 on the
`BCM-22-INV-1` model; ⛔ this ADR **neither performs nor requires** that, and mirroring into **FROZEN**
`PRD-006` is expressly forbidden by the conferral.

### 6.1 ⛔ Why `PRD-006` is NOT edited

⛔ **The conferral states *"DO NOT modify frozen `PRD-006`"*.** Independently, `PRD-006` is **Rank 3 and
FROZEN**, so any edit would require an ADR-before-change plus a version/changelog bump plus (under §7
rule 4) a **baseline re-issue**. ⭐ **None of that is authorised, and none is performed.** Verified:
`PRD-006` is **byte-unchanged**.

---

## §7 What this act does not do

- ⛔ It does **not** confer standing authority. **One act only** (`ADR-0033` §7.1).
- ⛔ It does **not** appoint a holder or name a person (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).
- ⛔ It does **not** amend `PRD-006`, `PRD-001`, `PRD-016`, `MASTER_PRD.md`, the BC Map, the Dependency
  Matrix, `PRD_OWNERSHIP_MODEL.md`, `DOCUMENTATION_BASELINE.md` or any other ADR.
- ⛔ It does **not** create an edge, event, port, read model, API, aggregate or `IMPL-*`.
- ⛔ It does **not** create, authorise or re-status `PRD-018`.
- ⛔ It does **not** authorise Supabase, storage, encryption, retry changes or retention changes.
- ⛔ It does **not** define the **general** disposal/resolution route (§3.2).
- ⛔ It does **not** authorise implementation.

### 7.1 Blockers after this act

| Item | Status after `ADR-0123` |
|---|---|
| **4 — Backend runtime** | ✅ RESOLVED (`ADR-0115` §8, `ADR-0116`) |
| **3 — Durable queue** | ✅ RESOLVED (`ADR-0119`, `ADR-0120`) |
| **7b — Queue depth** | ✅ RESOLVED (`ADR-0121`) |
| **5 — Retry/backoff** | ✅ RESOLVED (`ADR-0122`) |
| **8b-residual** | ⭐⭐ **RESOLVED by this ADR** — ⚠ scoped by `EVT-AUTHZ-6` to this exact scenario (§3.2) |
| **9b — At-rest protection** | ⛔ **OPEN** — barred by OPEN `ATT-GAP-006` |
| **7a — Retention period** | ⛔ **OPEN** — `Q-04`; ⭐ a retention *disposition* is not a retention *period* |
| **Implementation authority** | ⛔ **ABSENT for every item above** |

### 7.2 Baseline test, performed rather than asserted

`DOCUMENTATION_BASELINE.md` **§7** (L377–383), each rule tested:

| Rule | Met? |
|---|---|
| 1 — A Rank 1–5 change needs an ADR **before** the change | ⛔ **Unmet** — **no Rank 1–5 document changes** |
| 2 — Version + changelog in the same commit | ⛔ **Unmet** — no ranked document is versioned |
| 3 — Declaration updated in the same commit | ⛔ **Unmet** — no declaration changes |
| 4 — Baseline identifier moves **only** for a Rank 1–3 version change | ⛔ **Unmet** — no Rank 1–3 version change |

⭐ **All four unmet ⇒ no version bump anywhere and `BASELINE-2026-09-03-A` STANDS.**

---

## §8 Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-08 | ⭐⭐⭐ **Created and ACCEPTED. Item 8b-residual is RESOLVED — the last of the five Offline-Sync owner decisions.** The **Product Owner + `BC-03` Domain Owner** offices, constituted for **one act only** by direct human-principal conferral (⛔ **no prior conferral reused** — `ADR-0117`'s and `ADR-0118`'s were spent by `ADR-0119`/`ADR-0121`, and `ADR-0120`/`ADR-0122` each received their own), record **`EVT-AUTHZ-1`** *original capture timestamp remains the attendance time*, **`EVT-AUTHZ-2`** *replay/sync, Wi-Fi connection, Presence observation and retry time MUST NOT replace or rewrite it*, **`EVT-AUTHZ-3`** *a later Presence observation or attendance attempt MUST NOT automatically create a duplicate where a valid attendance exists*, **`EVT-AUTHZ-4`** *no silent discard when the actor is unauthorized at replay*, **`EVT-AUTHZ-5`** *retain as an audit-bearing rejected mutation and surface for explicit/manual resolution*, **`EVT-AUTHZ-6`** *this constitutes the explicit resolution/disposal path for `EVT-PERS-1`, `EVT-DEPTH-2` and `EVT-RETRY-3` only to the extent necessary for this exact scenario* — **all VERBATIM**, mechanically verified. ⭐⭐ **This is the audit's candidate 3 — *refuse but retain as an audit-bearing rejection*** — plus two limbs the audit had not separated (timestamp, no-duplicate); ⛔ candidates 1, 2 and 4 were **not** selected, and §2.1 records ⚠ that `EVT-AUTHZ-1`/`-2` are **NOT candidate 1 in disguise**: they fix *which instant* is the attendance time for an admitted mutation, and do **not** make an unauthorized actor's mutation admissible. ⭐⭐ **SEVEN COHERENCE TESTS RUN BEFORE RECORDING:** **(i)** `EVT-AUTHZ-4`/`-5` **SATISFY** `ADR-0119` **D-4** on both limbs (vanish-prohibition + observable signal), supplying the disposition for the **authorization-refusal** trigger — ⚠ a **different** trigger from `EVT-RETRY-3`'s retry exhaustion, since retrying cannot cure unauthorization, so `ADR-0122` is **not** duplicated or amended; **(ii)** ⭐⭐ **the highest-risk test — `EVT-AUTHZ-1`/`-2` vs frozen `ATT-FR-088`** — resolved by measuring that `ATT-FR-088`/`X-09` fix the timestamp's **SOURCE** (platform time port, never client) while `EVT-AUTHZ-1` fixes **WHICH INSTANT** is the attendance time; ⛔ **no device-clock authority is created**, and `PRD-006` **L2433–2435** (*"a queued loss is an observed loss whenever it arrives"*) plus **`ATT-FR-089`** (*"evaluated against the rules in force at the moment it was recorded"*) **CORROBORATE** the arrival-time-is-not-event-time principle at Rank 3; **(iii)** `EVT-AUTHZ-1`/`-2` are a **consistent superset** of `ADR-0122` **`EVT-RETRY-4`**, extending the barred-instant list from `{replay, retry}` to four — ⛔ **`EVT-RETRY-4` not amended**, every instant it barred stays barred; **(iv)** **`EVT-AUTHZ-3` CONFIRMS** frozen `ATT-INV-003`, `ATT-FR-019`, `ATT-INV-004`, `ATT-PO-012` and `PRD-006` **L2430–2431** rather than creating a rule, ⛔ with **no** key, comparison, merge or conflict algorithm stated and `ATT-PO-013`'s correction protection preserved; **(v)** ⭐⭐ **authorization authority preserved unweakened** — `AUTH-8.38`, `BR-7.1`, `AUTH-6.74` and `XC-6.4`…`XC-6.7` all hold, because `PRD-001` refuses the **operation** while this ADR governs the **queued data** after that refusal; the mutation is **rejected, not admitted**; **(vi)** **`EVT-AUTHZ-5`'s *audit-bearing*** is consistent with `ATT-FR-129`/`E-20`, `ATT-FR-132`, `ATT-FR-133` and `AUTH-10.4`, and ⭐ **`ATT-BR-011`** (*"a failure MUST NOT be silent"*) **corroborates `EVT-AUTHZ-4` at Rank 3 independently of `MP-NFR-02`**; **(vii)** ⚠ **a real capacity interaction is RECORDED, not glossed** — retained rejected mutations occupy slots and count toward `EVT-DEPTH-1`'s **500/device** bound, after which `EVT-DEPTH-2` blocks new captures, so a revoked actor's device can accumulate toward the bound and only the `EVT-AUTHZ-5` route relieves it; a **coherent consequence** of *"no silent discard"*, since the alternative destroys data. ⭐ **`ATT-INV-008` is NOT stretched:** the audit had measured via **`ATT-AC-119`** that a queued item is not yet a *stored* fact; ⛔ this ADR **neither asserts nor denies** that and makes it **moot by retaining the item regardless**. ⚠⚠ **WHAT REMAINS UNDEFINED IS DISCLOSED (§3.2):** the **general** disposal route (for non-authorization causes such as ordinary retry exhaustion or depth-bound preservation) is **still undefined**; **who** may perform the *"explicit/manual resolution"*, what it offers and whether it may end in destruction are **NOT** stated; and ⛔ **where** the audit-bearing rejected mutation lives is **NOT** decided, because `ATT-FR-130` forbids `BC-03` creating an attendance-specific audit store while `ATT-FR-129`/`E-20` route audit facts to `BC-24` — resolving that would be an architecture/ownership act outside this conferral. ⭐ **The decision is complete and operative for the conferred scenario**: retention is unconditional and *no silent discard* is absolute, so the residual gap makes it **stronger, never weaker**. ⛔⛔ **RESOLVED IS NOT IMPLEMENTABLE:** ⛔ no attendance, Presence, authorization, retention, storage or implementation rule beyond §2 — tested category by category in §3 — and specifically **no** storage technology, database, queue product, schema, encryption, retention period, **retry change**, **queue-depth change**, cloud resource, **Supabase** configuration, `PRD-018` or application implementation; ⭐ **a retention *disposition* is not a retention *period***, so **Item 7a stays OPEN** (`Q-04`); **Item 9b** stays OPEN behind **`ATT-GAP-006`**. ⛔ **No `ATT-*` identifier minted** — a register row would be a Rank-3 change to a **FROZEN** PRD, so the treatment is **fixed by the ADR**. ⛔ `ADR-0123` **amends nothing**; **`PRD-006` byte-unchanged as expressly forbidden**, and `PRD-001`, `PRD-016`, `MASTER_PRD`, BC Map (incl. `E-20`, `E-24`), Dependency Matrix, `PRD_OWNERSHIP_MODEL`, `DOCUMENTATION_BASELINE`, `ADR-0030`, `ADR-0036` and `ADR-0114`…`ADR-0122` all **byte-unchanged**; **§7 rules 1–4 each tested and ALL UNMET**, so **no version bump anywhere** and **`BASELINE-2026-09-03-A` STANDS**. ⛔ **No standing authority; both offices revert after this act; no person appointed.** ⚠ `EVT-AUTHZ-1`…`-6` are **ADR-local citation labels** (measured: **0** pre-existing occurrences) — **not** `SYNC-*`, **not** `ATT-*`, **not** `ATT-CFG-*`, **not** `AUTH-*`, and **not** added to any PRD register. ⛔ **0** `IMPL-*`, **0** `SYNC-*`, **0** code/config/dependency files. ⛔ **Implementation authorised: No.** |
