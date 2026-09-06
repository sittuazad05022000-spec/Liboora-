# ADR-0108 — `PRD-010` configuration classes: `NTF-CFG-005` and `-006` are **NOT configurable**, `NTF-CFG-004` is ratified **conditionally**, `NTF-CFG-007` stays **`[OWED]`**, and `NTF-GAP-011` is **EXCLUDED**

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐ **The Architecture Owner** (decisions **AO-6**…**AO-10**) and ⭐ **the Product Owner** (decisions **PO-1**, **PO-3**), each by **direct, explicit, first-person act** quoted verbatim at §2. Configuration class and bound are structural/platform-rule determinations (`PRD_OWNERSHIP_MODEL.md` **L85**); recipient ceilings and notification classes are business-intent determinations (**L83**) |
| **Supersedes** | — |
| **Amends** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` (Rank 3-*registered*, not Rank 3-*holding*: v0.10 `DRAFT`, **0** baseline §3 rows). ⛔ **No frozen document, no Rank 1–2 artefact, no Rank 4 artefact is modified by this ADR** — the Rank 4 change is `ADR-0107`'s |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only for a **Rank 1–3** document changing version; `PRD-010` **holds no rank** |
| **Closes** | ⭐ **`NTF-GAP-011`** — EXCLUDED (§5) · ⭐ **`NTF-CFG-005`** and **`NTF-CFG-006`** as *configurables* — both reclassified **NOT configurable**, which reduces Stage-4 check 3's target from **7** slots to **5** |
| **Does NOT close** | ⛔⛔ **`NTF-CFG-007`** — value **`[OWED — AO]`** · ⛔ **`NTF-CFG-006`'s numerical lifetime bounds** — recorded as an **unresolved bounded decision** (§4.3) · ⛔ **`NTF-CFG-001` rate limb** (`[OWED — PO]`) · ⛔ **`NTF-CFG-003` per-entry defaults** (`[OWED — PO]`) · ⛔ **`NTF-GAP-010`**, **`-012`**, **`-013`**, **`-017`**, **`-020`** · ⛔ **`NTF-FR-021`/`-022` placement** · ⛔ **Stage 4 is NOT conferred** |
| **Related** | `job_runtime.dart` **L82**, **L103-104**, **L113-114** · `services.dart` **L152-159**, **L193**, **L207** · `ADR-0057` **L133** (joint-ratification precedent) · `ADR-0107` (the `FeedItem` declaration this depends on) · `SEAT-FR-202` · `ITG-FR-017` · BC Map **L431**, **L447** |

---

## 2. The deciding acts, quoted verbatim

**Architecture Owner:**

> *"AO-6 — CFG-004: APPROVE: default = 3, range = 1–5, unit = total attempts including
> first attempt. This approval is conditional on CFG-007 being represented consistently
> with the JobRuntime contract.*
>
> *AO-7 — CFG-005: APPROVE: NOT configurable in V1, retry backoff deferred to V2. Create
> the required ADR decision.*
>
> *AO-8 — CFG-006: APPROVE: FIXED / NOT configurable, bounded by the authoritative
> `FeedItem` lifetime. Do NOT invent numerical lifetime bounds. If numerical bounds are
> still required by a gate, record them explicitly as an unresolved bounded decision rather
> than fabricating values.*
>
> *AO-9 — CFG-007: DO NOT invent a timeout value. The slot remains required with unit
> `Duration`. The actual value remains `[OWED]` until legitimate FCM/provider evidence
> establishes it.*
>
> *AO-10 — GAP-011: APPROVE closure as EXCLUDED because the repository's authoritative BC
> Map routing provides no lawful V1 trigger for BC-22 unread-message notification."*

**Product Owner:**

> *"PO-1 — CFG-001: APPROVE: default = 200, range = 1–500 recipients.*
>
> *PO-3 — CFG-003: APPROVE configurable values: `mandatory | optional`. Frozen
> Authentication MUST-notify obligations remain non-optional. DO NOT invent per-entry
> defaults that were not explicitly provided."*

**Authority basis.** Those instructions **are** the authority, and they are **the only
authority claimed**. Same form as `ADR-0033` §7.2 and `PRD-008_STAGE4_CONFERRAL.md`.
**Scope: these seven decisions only** — `ADR-0033` §7.1: *"A conferral for one act is not a
standing licence."*

⛔ **Expressly withheld by the same acts and NOT decided here:** `AO-11`/`NTF-GAP-013`,
`PO-2` (rate limb), `PO-4`/`PO-5` (`NTF-FR-021`/`-022` placement), `SRE-1` (SLO).

---

## 3. `NTF-CFG-004` — retry attempt bound, ratified CONDITIONALLY (AO-6)

| Field | Value |
|---|---|
| **Default** | **3** total attempts |
| **Range** | **1 – 5** total attempts |
| **Unit** | **total attempts, including the first** |
| **Class** | Configurable |
| **Owner** | Architecture Owner |

**The unit and floor are not created by this act.** The unit is fixed by the rank-0
`JobRuntime` port contract: *"`retryBudget` is the **total** attempts permitted, including
the first"* (`job_runtime.dart` **L103-104**), with `JobOutcome.attempts` documented as
*"Attempts consumed, including the first"* (**L82**). The floor is enforced **executably**:
`services.dart` **L152-159** throws `ArgumentError` when `retryBudget < 1`, quoting
`INV-21`.

**Why 3.** The *reasoning* — not the number — transfers from `FIL-CFG-014`: three attempts
absorb transient faults without masking a deterministic failure. That reasoning depends on a
durable fallback existing, and `ADR-0107` §3.5 now establishes one for `BC-22`
(`BCM-22-INV-1`). ⛔ `FIL-CFG-014`'s **value** is not imported; `ADR-0033` §7.1 forbids it.

**Why 5 is the ceiling but not the default.** The repository's only `5` is `AUTH-3.9`, which
bounds an **attacker's guesses** and is listed at `CONFIGURATION_GUIDE.md` **L41** among
values *"not configurable"*. A range bounds what an operator may set; it does not endorse
the extreme.

### 3.1 The condition, stated so it can be checked

⚠ **This ratification is CONDITIONAL** — the deciding act made it *"conditional on CFG-007
being represented consistently with the JobRuntime contract."*

**The condition is SATISFIED as to representation**, and that is verified rather than
assumed: `NTF-CFG-007` is published as a **required** slot whose unit is `Duration`, exactly
as `submit(...)` declares — `job_runtime.dart` **L113-114**:
`required int retryBudget, required Duration deadline`. `PRD-010` §20.1 states the slot in
those terms and in no other.

⚠ **What remains open is the VALUE, not the representation.** Because the V1 loop has **no
inter-attempt delay** (`delay`/`Timer`/`interval` = **0** in both `job_runtime.dart` and
`services.dart`), the budget consumes ≈ 3 × (per-attempt provider duration). If a deadline
is later ratified that is shorter than that product, attempts 2–3 become **unreachable** and
the ratified default would be partly fictional — the defect class `INV-18`/`INV-20` exist to
prevent. **Should that occur, `NTF-CFG-004` MUST be re-ratified downward**; this ADR records
that consequence in advance rather than leaving it to be discovered.

---

## 4. `NTF-CFG-005` and `NTF-CFG-006` — reclassified NOT configurable

### 4.1 `NTF-CFG-005` — retry backoff (AO-7)

> **DECISION.** Retry backoff is **NOT configurable in V1**. No operator or administrator
> setting exposes a backoff schedule, and **no `NTF-CFG-*` identifier carries one**. Backoff
> is **deferred to V2**.

**Measured basis.** **0** backoff schedules exist at Rank 1–5. The V1 adapter implements
none — `services.dart` **L189-221** is *deadline check → `attempts++` → `await work()` →
catch → loop immediately*, with **0** delay primitives. The EA places *"Retry & Backoff"* at
**V2** (**L1808**, **L1869**). ⇒ A backoff value would have **nothing to execute it**.

⚠ **The EA is cited as evidence, not authority** — `MP-CON-08` makes it *"descriptive, not
prescriptive"*. The decision rests on the AO's act plus the measured absence, not on the EA.

### 4.2 `NTF-CFG-006` — deduplication retention (AO-8)

> **DECISION.** Deduplication-record retention is **FIXED and NOT configurable**. No
> operator or administrator setting exposes it, and **no `NTF-CFG-*` identifier carries
> it**. Its bound is the **authoritative `FeedItem` lifetime** (`ADR-0107` §3.5,
> `BCM-22-INV-1`): a dedup record for key `(eventId, recipientId, channel, templateId)`
> **MUST** exist for as long as the `FeedItem` it protects exists, and **MUST NOT** exist
> thereafter.

**Precedent, measured.** The repository has **two** ratified idempotency-retention rules and
**both are fixed**, with **zero** configurable instances:

| Precedent | Value | Class |
|---|---|---|
| `SEAT-FR-202` (`PRD-007`, FROZEN) | 24 hours | *"This retention is fixed, not configurable"* |
| `ITG-FR-017` (`PRD-019`) | exactly 30 days | *"not configurable, no operator or administrator setting exposes it"* |

⭐ `PRD-019` v0.4 closed Stage-4 check 3 on this exact slot shape — *"**not by bounding a
configurable but by establishing there is no configurable to bound**"*. This decision
follows that ratified route.

⛔ **No number is copied.** `SEAT-FR-202`'s 24 h derives from *"client retry behaviour"* for
a synchronous operation; `BC-22`'s retries are server-side and immediate.
`ITG-FR-017`'s 30 d derives from *published provider windows* that do not exist for FCM
here. ⛔ `MM-CFG-008 = 7 days` is a **business lead time** and is **not** adopted.

### 4.3 ⚠⚠ The residue, recorded as an unresolved bounded decision — NOT fabricated

The deciding act required: *"Do NOT invent numerical lifetime bounds. If numerical bounds
are still required by a gate, record them explicitly as an unresolved bounded decision
rather than fabricating values."* That is done here.

> **`NTF-OBD-001` — UNRESOLVED BOUNDED DECISION.** The **numerical** lower and upper bounds
> of the `FeedItem` lifetime — and therefore of dedup retention — are **NOT established**.
> `BCM-22-INV-1` fixes that a `FeedItem` is **durable and rebuildable**; it fixes **no
> lifetime**. **Owner: Architecture Owner.**

⚠ **Consequence stated plainly.** Under `ITG-AC-017`'s standard — *"a criterion that cannot
fail is not a test"* — a rule reading *"for as long as the `FeedItem` exists"* is
**falsifiable in its coupling** (a dedup record outliving or predeceasing its `FeedItem`
fails) but **not yet falsifiable in absolute time**, because the `FeedItem`'s own lifetime is
unbounded. ⇒ **`NTF-CFG-006` is removed from the configurable register, and `NTF-OBD-001`
is opened in its place.** No value is invented to close the difference.

---

## 5. `NTF-CFG-007` — required slot, value `[OWED]` (AO-9)

> **DECISION.** The slot **remains required**, with unit **`Duration`**. **No default,
> minimum or maximum is ratified.** The value stays **`[OWED — Architecture Owner]`** until
> legitimate FCM/provider evidence establishes it.

**Why the slot cannot be reclassified away** — unlike `-005` and `-006`:
`JobRuntime.submit(...)` declares `required Duration deadline` (`job_runtime.dart`
**L113-114**), so `BC-22` **cannot submit work without one**.

**Provider evidence searched and absent** (`NTF-GAP-017`, the `ADR-0045` condition):

| Evidence | Status |
|---|---|
| Per-attempt request timeout | ⛔ ABSENT |
| Delivery acknowledgement semantics | ⛔ ABSENT |
| TTL / message expiry | ⛔ ABSENT — repo TTL sweep found only `LCFG-11`, `SEAT-FR-202`, `ITG-FR-017`; **zero** push-transport TTL |
| Provider retry / redelivery window | ⛔ ABSENT |
| Corroborating implementation | ⛔ ABSENT — **0** FCM/`firebase_messaging` files in `lib/`, `packages/`, `test/`; **no firebase dependency in `pubspec.yaml`** |

⛔⛔ **`NTF-CFG-007` MUST NOT be described as a user-visible hard latency cap.**
`services.dart` **L193** evaluates the deadline **only between attempts**; the awaited call
at **L207** is **unbounded**. A single hung provider request overruns the deadline
indefinitely at V1. Whether V1 must bound the in-flight call is a **runtime** question, not
a configuration value, and is **not decided here**.

⛔ **120 s is expressly REJECTED.** `FIL-CFG-015`'s bounds are anchored to document size and
object unservability, neither of which exists for a push transport; and `PRD-010` had
already refused its companion `FIL-CFG-014`'s number on the same storage-vs-push
failure-domain ground. Accepting one while refusing the other would be incoherent.

---

## 6. `NTF-GAP-011` — EXCLUDED (AO-10)

> **DECISION.** `NTF-GAP-011` is **CLOSED as EXCLUDED**. An unread-message notification is
> **not a `BC-22` V1 capability**, because no lawful trigger exists.

**The derivation, which the AO ratifies rather than replaces.** BC Map **L431** routes
`messaging.MessageSent` to **`BC-13`** (sampling) and **`BC-26`** — ⛔ **not** to `BC-22`.
BC Map §7's own rule is that *"if an edge is not in this table, it does not exist"*.
`PRD-010` creates no edge (`NTF-XC-004`). ⇒ `BC-22` has **no** lawful means of learning that
a message was sent, so the capability cannot be specified in V1 without a new `E-*` edge —
a Rank 4 act **not** performed here.

⭐ **This is an AO ratification of an evidence-based exclusion, not a preference.** The
evidence determines the outcome; the AO's act supplies the authority to record it as closed.

⚠ **What this does NOT do:** it does **not** forbid the capability in V2, and it does
**not** decide `NTF-FR-022`'s §5 placement, which stays **`[OWED — PO]`**.

---

## 7. Product Owner decisions recorded

### 7.1 `NTF-CFG-001` — bulk recipient ceiling (PO-1)

| Field | Value |
|---|---|
| **Default** | **200** recipients |
| **Range** | **1 – 500** recipients |
| **Unit** | recipients per dispatch |
| **Owner** | Product Owner |

Consistent with comparable ceilings: `CFG-3` = 100 (50–500), `ICFG-5` = 50 (1–500),
`ICFG-7` = 20 (1–100). `CONFIGURATION_GUIDE.md` **L131-132** sizes a study hall at *"sixty
to two hundred students"*, and `NTF-FR-010` bounds an audience to one tenant.

⛔ **The rate/interval limb is NOT decided** (`PO-2` withheld): **`[OWED — Product
Owner]`**. `NTF-CFG-001` therefore remains **incomplete** for Stage-4 check 3.

### 7.2 `NTF-CFG-003` — notification class (PO-3)

| Field | Value |
|---|---|
| **Allowed set** | **{`mandatory`, `optional`}** |
| **Per-entry defaults** | ⛔ **`[OWED — Product Owner]`** |
| **Owner** | Product Owner |

⭐ **A binding constraint is recorded, not created.** Frozen `Authentication_PRD_v2.md`
imposes unconditional MUST-notify duties — `AUTH-8.52`, `AUTH-9.29`, `AUTH-9.43`,
`AUTH-9.76`. Notices discharging those duties **MUST** be classified `mandatory` and
**MUST NOT** be opt-outable. ⛔ The frozen PRD is **cited, not modified**.

⛔ **Per-entry defaults are NOT invented.** `NTF-CFG-003` therefore remains **incomplete**
for Stage-4 check 3.

---

## 8. What this ADR does NOT do

| # | Not done |
|---|---|
| 1 | ⛔ **No number invented** — 0 deadlines, 0 TTLs, 0 retention periods, 0 backoff schedules, 0 rate limits, 0 per-entry defaults, 0 SLOs |
| 2 | ⛔ **`NTF-CFG-007` value NOT set**; **`NTF-OBD-001`** opened rather than closed |
| 3 | ⛔ **`NTF-GAP-010`, `-012`, `-013`, `-017`, `-020` all remain OPEN**, owners unchanged |
| 4 | ⛔ **`PO-2`, `PO-4`, `PO-5`, `SRE-1` NOT decided** — expressly withheld |
| 5 | ⛔ **No SLO/SLI published.** `ADR-0102` is **NOT** reused — `ADR-0033` §7.1 bars it; `SRE-GAP-001` stays OPEN |
| 6 | ⛔ **No frozen PRD modified, reopened or re-ranked** — `PRD-007`, `PRD-017`, `PRD-019`, `PRD-005`, Authentication, Library, `PRD-021B` all byte-unchanged |
| 7 | ⛔ **No Rank 1 or Rank 2 document changed**; ⛔ no Rank 4 change by *this* ADR |
| 8 | ⛔ **`CONFIGURATION_GUIDE.md` NOT edited** — §5: *"the specification declares what is configurable, this guide does not"*; slots with owed values cannot yet be published there |
| 9 | ⛔ **Stage 4 NOT conferred** — that is the Requirements Reviewer's act (`PRD_LIFECYCLE.md` §6 **L278**); ⛔ **Stage 5 NOT entered**; ⛔ Stages 6/7 not approached |
| 10 | ⛔ **No `IMPL-*` allocated · no traceability registration · no baseline row · registry stays `PLANNED`** |
| 11 | ⛔ **No application code changed** — `job_runtime.dart`, `services.dart`, `di.dart` read as evidence only |

---

## 9. Consequences for Stage-4 check 3

Check 3's target moves from **7 declared slots** to **5 configurable slots**, because
`-005` and `-006` are no longer configurables:

| Slot | State after this ADR |
|---|---|
| `NTF-CFG-001` | ⚠ **Partial** — ceiling ratified; **rate limb `[OWED — PO]`** |
| `NTF-CFG-002` | ✅ **Satisfied by citation** — `LCFG-2`, `en`, Supported set |
| `NTF-CFG-003` | ⚠ **Partial** — set ratified; **per-entry defaults `[OWED — PO]`** |
| `NTF-CFG-004` | ✅ **Ratified** (conditionally — §3.1) |
| `NTF-CFG-007` | ⛔ **`[OWED — AO]`** |
| ~~`NTF-CFG-005`~~ | ⛔ Removed — NOT configurable |
| ~~`NTF-CFG-006`~~ | ⛔ Removed — NOT configurable; **`NTF-OBD-001`** opened |

⛔⛔ **CHECK 3 THEREFORE STILL FAILS**, on `NTF-CFG-001` (rate), `NTF-CFG-003` (defaults)
and `NTF-CFG-007` (value). ⭐ **It fails on 3 limbs instead of 6 slots, which is progress and
not a pass.** An unresolved item is not satisfied merely because it has an owner.

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created and **`Accepted`**. Records the Architecture Owner's acts **AO-6**…**AO-10** and the Product Owner's acts **PO-1**, **PO-3**. `NTF-CFG-004` ratified **conditionally** at 3 / 1–5 total attempts including the first, with the representation limb verified against `job_runtime.dart` **L113-114** and the value limb's residual risk stated in advance. `NTF-CFG-005` and `NTF-CFG-006` reclassified **NOT configurable** on the `SEAT-FR-202` / `ITG-FR-017` precedent and the `PRD-019` v0.4 route (*"no configurable to bound"*), reducing check 3's target **7 → 5**. ⚠ **`NTF-OBD-001` opened** — the numerical `FeedItem` lifetime bounds are recorded as an **unresolved bounded decision** rather than fabricated, exactly as the deciding act required. `NTF-CFG-007` retained as a **required** slot with unit `Duration` and value **`[OWED]`**, with the five absent provider-evidence items enumerated and **120 s expressly rejected**. ⛔ **`NTF-CFG-007` must not be justified as a latency cap** while `services.dart` **L207** leaves `await work()` unbounded. `NTF-GAP-011` **closed as EXCLUDED** on BC Map **L431**'s routing. ⛔ **`AO-11`, `PO-2`, `PO-4`, `PO-5`, `SRE-1` expressly NOT decided.** ⛔ 0 numbers invented · 0 frozen PRDs touched · 0 Rank 1/2/4 changes · 0 `CONFIGURATION_GUIDE` bytes · 0 stages conferred · check 3 **still FAILS**. |
