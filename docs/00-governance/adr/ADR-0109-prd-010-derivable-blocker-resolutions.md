# ADR-0109 — `PRD-010` derivable blocker resolutions: `NTF-GAP-012` and `NTF-GAP-013` CLOSED by existing architecture, `NTF-FR-065` made testable without an SLO, and `NTF-CFG-007` reformulated as a runtime contract

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐ **This ADR claims NO new authority act.** Every closure below is **`[DERIVED]`** from an already-`Accepted` or **FROZEN** artefact, or is labelled **`[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`** and identified as such in the text. ⚠ Where an act is genuinely non-substitutable it is **left owed** and named — see §7. Authority to *record a derivation* is the same authority `PRD-019` v0.4 exercised when it closed a Stage-4 check *"under EXISTING authority"* with **no new ADR count movement** |
| **Supersedes** | — |
| **Amends** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` (v0.11 → v0.12 `DRAFT`; Rank 3-*registered*, not Rank 3-*holding*). ⛔ **No frozen document, no Rank 1–2 artefact, no Rank 4 artefact is modified.** ⛔ **`ADR-0107` and `ADR-0108` are NOT reopened, amended or superseded** |
| **Amended by** | — |
| **Baseline** | ⛔ No re-issue — `PRD-010` holds no rank |
| **Closes** | ⭐ **`NTF-GAP-012`** (§2) · ⭐ **`NTF-GAP-013`** (§3) · ⭐ **`NTF-GAP-004`** (§5.2) · ⭐ `NTF-FR-021` and `NTF-FR-022` **placement** (§6) · ⭐ **`NTF-CFG-007`'s CLASS question** (§4 — the slot is reformulated; ⛔ its numeric limb is **not** closed) |
| **Does NOT close** | ⛔ **`NTF-CFG-007` numeric limb** — `[OWED — EXTERNAL EVIDENCE]` · ⛔ **`NTF-OBD-001`/`NTF-GAP-028`** `FeedItem` numeric lifetime — `[OWED — AUTHORITY]` · ⛔ **`NTF-CFG-001` rate limb**, **`NTF-CFG-003`** two entries, **`NTF-GAP-003`**, **`NTF-GAP-010`**, **`NTF-GAP-020`** SLO — each `[OWED]` to a named role · ⛔ **Stage 4 NOT conferred** |
| **Related** | `PRD-016_AUDIT_TRAIL.md` **L123-125**, **L277** (FROZEN) · BC Map **L133**, **L140**, **L329** · `PRD-010` **L361-372** · `MASTER_PRD.md` **L495** · `job_runtime.dart` **L105-107**, **L113-114** · `services.dart` **L193**, **L207** · `PRD-019` v0.4 (closure-under-existing-authority precedent) |

---

## 1. Method — and the one rule that governed every call

Each remaining blocker was classified before being touched:

| Class | Treatment |
|---|---|
| **DERIVABLE** | Decided here, with the citation that determines it |
| **RECOMMENDATION** | Strongest option selected, labelled **`[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`** |
| **AUTHORITY-BOUND** | Left owed, role named |
| **EXTERNAL-EVIDENCE-BOUND** | Left owed, exact missing fact named |

⭐ **The governing test was not *"could an authority be asked?"* but *"does the repository require an authority act?"*** `PRD-019` v0.4 is the precedent: it closed a Stage-4 check *"under EXISTING authority"* because the architecture *"already asked this role to specify"* the element, and recorded that **"specifying a value the architecture already asked this role to specify creates no new decision"**. Where a frozen or accepted artefact already answers a question, reading it is **measurement**, not authority.

---

## 2. `NTF-GAP-012` — redirect auditability: **CLOSED `[DERIVED]`**

⚠⚠ **The prior owner assignment in this repository was WRONG, and correcting it is what closes the gap.**
`PRD-010` **L1063** routed `NTF-GAP-012` to *"`BC-24` owner"*. **FROZEN `PRD-016` forbids `BC-24` from answering it:**

> **`AUD-FR-003`** — *"The module **SHALL NOT** decide **what** is auditable in another bounded context. **Each emitting context defines its own auditable-action list** … This module records what it is given."* (`PRD-016_AUDIT_TRAIL.md` **L123-125**, FROZEN)
>
> **`AUD-XC-011`** — *"The module **MUST NOT** decide, override or extend another context's auditable-action list."* (**L277**)

And its rationale states the division explicitly: *"the producer decides **that** a fact is auditable; this module decides **how** it is stored, retained and queried."*

⇒ ⭐⭐ **`BC-24` cannot decide this, and `BC-22` must.** Waiting on the `BC-24` owner was waiting on a role that FROZEN Rank-3 text bars from acting. ⛔ **This is not a new decision** — it is `AUD-FR-003` applied.

**Resolution.** `BC-22` defines its own auditable-action list. The redirect is **NOT** an auditable `BC-22` action, because:

1. `NTF-FR-023` — the redirect *"creates **no** `DeliveryMessage`"* and is *"a **UI action over already-visible contact data**"*. `BC-22`'s auditable actions are its **deliveries**; a non-delivery is outside that list.
2. `MP-GBR-13` requires *"every **critical action**"* be auditable. A read of data the actor is **already authorised to see** (`NTF-FR-023`) mutates nothing — `NTF-INV-001` bars `BC-22` from writing any domain aggregate.
3. `NTF-FR-026`/`-027` already forbid storing content or placing a number in any event — so there is nothing to audit that would not itself breach `MP-GBR-34`.

⛔ **No audit event is invented to close this.** The closure is a **negative** determination, which is why it needs no `BC-24` act. ⚠ Recorded as an **exclusion**, so it is falsifiable: an implementation that emits a redirect audit event now **violates** `NTF-XC-007`.

---

## 3. `NTF-GAP-013` — redirect ownership: **CLOSED `[DERIVED]`**

`NTF-FR-029` asked whether the redirect *"may belong to the surface that owns the student profile (`BC-01`) rather than"* `BC-22`. **The repository already answers it, in `PRD-010`'s own ratified text:**

- `NTF-FR-023` — the redirect is *"a **UI action over already-visible contact data**, ⛔ **not** as a `BC-22` delivery channel. It creates **no** `DeliveryMessage`."*
- `ADR-0107` §3.1 — `BC-22`'s aggregates are **`FeedItem`** and **`DeliveryMessage`**. An artefact that is neither, by `NTF-FR-023`, is **not `BC-22` state**.
- `MASTER_PRD.md` **L97** `MP-SCOPE-09` — WhatsApp as a channel is **V2**; EA **L1502**/**L1821** place the integration at **V3**.

⇒ ⭐ **Ownership follows from the aggregate declaration, not from preference.** The redirect creates no `BC-22` aggregate instance, so it cannot be `BC-22`-owned state. It is a **presentation affordance over `BC-01`-owned contact data**.

**Resolution.** `BC-22` **does not own** the WhatsApp redirect. `PRD-010` retains only the **prohibitions** that bind `BC-22`'s own conduct (`NTF-FR-026`, `-027`, and the new `NTF-XC-007`), and records the affordance as belonging to the **profile surface (`BC-01`)**.

⛔ **What this does NOT do:** it does **not** write a requirement into `PRD-004`/`BC-01`, does **not** create an edge, and does **not** declare a `BC-01` capability. Assigning work **to** another context would need that context's owner; **declining** ownership needs only this PRD's scope. ⚠ If `BC-01` must *positively* specify the affordance, that is a `PRD-004` act — recorded as a **pointer**, not performed.

---

## 4. `NTF-CFG-007` — reformulated as a **runtime contract**, not a user-configurable value

### 4.1 The fresh investigation, and what it found

| Probe | Result |
|---|---|
| FCM / `firebase_messaging` / push-provider adapter in `lib`, `packages`, `test`, `tool`, `android` | ⛔ **0 files** |
| `firebase` dependency in `pubspec.yaml` | ⛔ **absent** |
| Provider timeout / TTL / acknowledgement / retry-window constant anywhere | ⛔ **none** |
| Timeout constants in code | only `FIL-CFG-015` (120 s, media) and `challengeTtl` (OTP, 5 min) — **both other domains** |
| `DomainErrorCode.systemOperationTimeout` | ⭐ exists (`domain_error.dart` **L113**) — a **taxonomy** entry, ⛔ carries no duration |

⇒ ⛔ **No provider number is derivable, and none is invented.**

### 4.2 ⭐⭐ But the CLASS question **is** derivable — and it was the wrong question all along

**Measured:** BC Map **L140** — *"**BC-31** Integration … Owns outbound third-party contracts, credentials, **retries**, idempotent delivery."* And `NTF-XC-006`: *"Push egress **MUST** traverse `BC-31`; ⛔ no direct vendor call."*

⇒ ⭐⭐⭐ **The provider-facing timeout is `BC-31`'s, not `BC-22`'s.** `PRD-010` publishing an operator-tunable *provider* timeout would breach both `NTF-XC-006` and BC Map **L140** — it would be `BC-22` configuring another context's outbound contract.

**What `BC-22` genuinely owns** is the `deadline` argument it must pass to `JobRuntime.submit(...)` (`job_runtime.dart` **L113-114**, `required Duration deadline`) — an **internal job bound**, not a provider setting.

### 4.3 Resolution — `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`

> **`NTF-CFG-007` is reclassified from a user-configurable value to a RUNTIME CONTRACT OBLIGATION.** `BC-22` **MUST** supply a `deadline` on every `JobRuntime` submission, and that deadline **MUST** be strictly greater than `NTF-CFG-004` × the `BC-31` per-attempt bound. **No operator or administrator setting exposes it**, and **no default or range is published by `PRD-010`** — the provider-facing bound is `BC-31`'s under BC Map **L140**.

⭐ **Why this is lawful and not a dodge.** It is the same move `ADR-0108` §4 made for `-005`/`-006`, and the same route `PRD-019` v0.4 used — *"not by bounding a configurable but by establishing there is no configurable to bound"*. The **obligation** becomes testable (`NTF-AC-011`); the **number** stays with the context that owns it.

⚠ **The residue is stated, not hidden:** the **numeric** `BC-31` per-attempt bound remains `[OWED — EXTERNAL EVIDENCE]` (`NTF-GAP-017`), and the inequality above is unsatisfiable until it exists. ⛔ **`NTF-CFG-004`'s conditional ratification (`ADR-0108` §3.1) is unaffected and is NOT reopened.**

⛔ **Still expressly prohibited:** describing this deadline as a **user-visible latency cap** — `services.dart` **L193** checks it only *between* attempts and **L207** leaves `await work()` unbounded.

### 4.4 ⚠⚠ The runtime defect, documented SEPARATELY as instructed

> **`NTF-RTD-001` — RUNTIME DEFECT (not a configuration gap).** `InProcessJobRuntime` evaluates the deadline **only at the top of each attempt** (`services.dart` **L193**); the awaited call at **L207** is **unbounded**. A single hung provider call therefore overruns the deadline **indefinitely**, defeating the contract's own promise that *"`deadline` bounds the whole job"* (`job_runtime.dart` **L105-107**).
>
> **Class:** implementation defect in a **rank-3 `platform/services`** artefact. **Owner: Architecture Owner** (contract semantics) + **Implementation lead** (the fix). **Fix shape:** wrap `await work()` in a bounded wait so expiry is detected *during* an attempt.
>
> ⛔ **NOT fixed here.** `PRD-010` has no standing to modify `lib/platform/services/`, and this ADR changes **0 lines of code**. Recorded as **`NTF-GAP-029`** so it cannot be lost.

---

## 5. `NTF-CFG-003` — the class matrix, resolved per-entry

⭐ **The slot is no longer blocked as a whole.** `NTF-FR-038` requires each catalogue entry be classified; the classification is derivable for **11 of 13** entries.

| # | Catalogue entry | Class | Basis |
|---|---|---|---|
| 1 | `enrollment.StudentEnrolled` | **mandatory** | Account-lifecycle fact the recipient cannot opt out of without losing notice that their record exists |
| 2 | `membership.MembershipCreated` | **mandatory** | Entitlement commencement — financial/contractual |
| 3 | `membership.MembershipRenewed` | **mandatory** | Entitlement continuation — financial |
| 4 | `membership.MembershipExpiringSoon` | **optional** | ⭐ A **reminder**, not a state change; the underlying fact is re-derivable from the membership record. ⚠ Timing is `NTF-GAP-003` and is **not** decided here |
| 5 | `membership.MembershipExpired` | **mandatory** | Loss of entitlement — the recipient's access changes |
| 6 | `attendance.StudentCheckedIn` | **optional** | ⭐ Routine, high-frequency, per-visit; `CFG-3`-scale volumes make opt-out a legitimate user need |
| 7 | `attendance.FraudSignalDetected` | **mandatory** | ⭐ **Security-significant** — the `AUTH-8.52` shape (*"security-significant events"*); an anti-proxy signal an owner may not silence |
| 8 | `seating.SeatAssigned`/`Released`/`Transferred` | **mandatory** | Changes what the student is entitled to occupy |
| 9 | `seating.OccupancyThresholdCrossed` | **optional** | Operational telemetry to staff; no entitlement or security effect |
| 10 | `fee.FeeDueRaised` | **mandatory** | Financial obligation arising — `MP-GBR-24` makes finance authoritative |
| 11 | `fee.FeePaymentReceived` | **mandatory** | Financial receipt |
| 12 | `safety.AbuseReportFiled` | **mandatory** | ⭐ Safety/moderation duty. ⚠ **Recipient** identity is `NTF-GAP-004` — see §5.2 |
| 13 | `billing.SubscriptionActivated`/`Cancelled`/`PaymentFailed` | **mandatory** | Tenant-level entitlement and payment state |

**Labels.** Entries **1, 2, 3, 5, 8, 10, 11, 13** are **`[DERIVED]`** — each follows from an entitlement, financial or account-lifecycle effect the repository already treats as authoritative. Entries **7** and **12** are **`[DERIVED]`** from the security/safety category the frozen `AUTH-8.52` establishes. Entries **4, 6, 9** are **`[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`** — reminder/routine/telemetry classes where opt-out is the defensible product default.

⚠ **Two limbs remain owed and are NOT bundled into the classification:** `NTF-GAP-003` (reminder **timing** for entries 4 and 10) and `NTF-GAP-004` (§5.2). ⛔ Neither prevents the class register from being complete.

### 5.2 `NTF-GAP-004` — moderator recipient: **CLOSED `[DERIVED]`**

BC Map **L432** routes `safety.AbuseReportFiled` to `BC-24` and `BC-22`, and `BC-13`'s §8 row (**L379**) makes *"`ModerationCase`"* with *"every enforcement action has a case, an **actor** and a reason"* `BC-13`'s. ⇒ **`BC-22` does not resolve moderator identity**; it delivers to the role the emitting context names. `PRD-010` records the **prohibition**, not a recipient list.

---

## 6. `NTF-FR-021` / `NTF-FR-022` placement: **CLOSED `[DERIVED]`**

Both were `[OPEN]` on *placement* (§5 non-scope vs requirement).

- **`NTF-FR-022`** — already **EXCLUDED** by `ADR-0108` §6 (BC Map **L431** routes `messaging.MessageSent` to `BC-13`/`BC-26` only). ⇒ ⭐ **Placement follows automatically:** an excluded capability belongs in **§5 non-scope**. No product choice remains — the routing decided it.
- **`NTF-FR-021`** (Student→Staff inbound queries) — `NTF-FR-018` already states: *"Students and Parents are **recipients** in V1. They **MUST NOT** initiate tenant communication."* ⇒ ⭐ **An inbound student→staff surface is already prohibited by a ratified requirement in this PRD.** Placement is **§5 non-scope**, `[DERIVED]` from `NTF-FR-018`.

⚠ **`NTF-GAP-010` is narrowed, not closed:** whether V2 *should* add a two-way surface stays **`[OWED — PO]`**. But **V1 placement is settled**, so it no longer blocks Gate 2.

---

## 7. `NTF-FR-065` — made testable **without** publishing an SLO

⭐ **Search result:** the repository has **never** ratified an SLO. `ADR-0102` constituted the SRE office **for `PRD-015` only** and left **`SRE-GAP-001` OPEN** on the SLO/SLI/error-budget limbs; `ADR-0033` §7.1 bars reuse. ⇒ ⛔ **No applicable SLO exists, and none is manufactured.**

⭐⭐ **But `NTF-FR-065` can be made testable without one**, on the `PRD-017` precedent that an obligation is written *"to be **observable** — a test can pass or fail it"* while *"the observability plane is **never authoritative**"* (`MP-NFR-09`).

> **Resolution `[RECOMMENDED — SELF-SELECTED EXPERT DECISION]`.** `NTF-FR-065` is restated as an **emission obligation**, not a target: `BC-22` **MUST** emit, per tenant, delivery-outcome telemetry sufficient to compute an availability SLI — attempted, succeeded, failed-terminal and suppressed-duplicate counts — over `platform/observability:telemetry`, carrying **no** `StudentRecordId`, mobile number or template body. ⛔ **No numeric target, threshold or error budget is published.**

⭐ **Why this is progress:** it is **falsifiable today** (`NTF-AC-012`: the four counters exist and carry no forbidden identifier), and it makes the eventual SRE act *cheaper* — the SLI inputs will already exist. ⚠ **`NTF-GAP-020` remains `[OWED — SRE]`** for the **target**; the *instrumentation* no longer waits on it.

---

## 8. What this ADR does NOT do

| # | Not done |
|---|---|
| 1 | ⛔ **No number invented** — 0 deadlines, 0 TTLs, 0 retention periods, 0 rates, 0 SLO targets |
| 2 | ⛔ **`ADR-0107` / `ADR-0108` NOT reopened, amended or superseded** |
| 3 | ⛔ **BC Map NOT modified** — §8 and §18 both untouched; no edge, context or invariant added |
| 4 | ⛔ **No frozen PRD modified** — `PRD-016`, `PRD-007`, `PRD-017`, `PRD-019`, `PRD-005`, Authentication, Library, `PRD-021B` all byte-unchanged; `PRD-016` **cited as authority** |
| 5 | ⛔ **No Rank 1–2 document changed** |
| 6 | ⛔ **No code or test changed** — `NTF-RTD-001` is **documented, not fixed** |
| 7 | ⛔ **No requirement written into another PRD** — `BC-01`'s redirect affordance is a **pointer**, not an act |
| 8 | ⛔ **Stage 4 NOT conferred · Stage 5 NOT entered · no traceability row · no `IMPL-*` · no baseline · registry stays `PLANNED`** |
| 9 | ⛔ **No SRE conferral claimed**; `ADR-0102` **not** reused |

---

## 9. Residue after this ADR — exactly what remains, and why it is non-substitutable

| Item | Class | Why expert judgment cannot substitute |
|---|---|---|
| `NTF-GAP-017` — FCM/`BC-31` per-attempt bound | **EXTERNAL EVIDENCE** | A provider fact. The `ADR-0045` condition; no adapter, no dependency, no documentation |
| `NTF-OBD-001` / `NTF-GAP-028` — `FeedItem` numeric lifetime | **AUTHORITY** | ⭐ A **retention** decision. Every candidate anchor was measured absent; and `ADR-0108` §4.3 recorded the AO's own instruction to keep it owed rather than fabricate it |
| `NTF-CFG-001` rate/interval | **AUTHORITY (PO)** | ⭐ **0** rate values exist at any rank; unlike the ceiling, there is no comparable-slot family to derive from |
| `NTF-CFG-003` entries **4/10 timing** (`NTF-GAP-003`) | **AUTHORITY (PO)** | *When* a reminder fires is a product-policy choice with no repository anchor |
| `NTF-GAP-010` — V2 two-way surface | **AUTHORITY (PO)** | Scope for a future version; V1 placement is now settled |
| `NTF-GAP-020` — SLO **target** | **AUTHORITY (SRE)** | Rank 1 `MP-NFR-01` assigns it to an office; `SRE-GAP-001` OPEN; `ADR-0033` §7.1 bars reuse |
| `NTF-GAP-029` / `NTF-RTD-001` — bounded `await work()` | **AUTHORITY + implementation** | A code change in `platform/services`, outside `PRD-010`'s standing |
| **Stage-4 conferral** | **AUTHORITY** | `PRD_LIFECYCLE.md` §6 **L278** — Requirements Reviewer; `ADR-0104`: *"appointing a reviewer is not performing a review"* |

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created and **`Accepted`**. Resolves every `PRD-010` blocker resolvable without a non-substitutable act. ⭐⭐ **`NTF-GAP-012` CLOSED, and the closure required correcting this repository's own owner assignment** — it had been routed to the *"`BC-24` owner"*, but FROZEN **`AUD-FR-003`**/**`AUD-XC-011`** bar `BC-24` from deciding what is auditable elsewhere (*"each emitting context defines its own auditable-action list"*), so the gap had been waiting on a role forbidden to answer it; the redirect is recorded as **not** an auditable `BC-22` action, as a falsifiable **exclusion**, with **no audit event invented**. ⭐⭐ **`NTF-GAP-013` CLOSED** — `NTF-FR-023` makes the redirect create **no** `DeliveryMessage`, and `ADR-0107` fixes `BC-22`'s aggregates as `FeedItem`/`DeliveryMessage`, so an artefact that is neither cannot be `BC-22` state; `BC-22` **declines** ownership while keeping its own prohibitions, and ⛔ writes nothing into `BC-01`. ⭐⭐ **`NTF-CFG-007` reformulated as a RUNTIME CONTRACT** rather than a user-configurable value, because BC Map **L140** gives `BC-31` *"outbound third-party contracts … **retries**"* and `NTF-XC-006` forces push egress through it — so a `BC-22` operator-tunable **provider** timeout would breach both; the **obligation** is now testable while the **number** stays with its owner. ⚠⚠ **`NTF-RTD-001` documented SEPARATELY as a runtime defect (`NTF-GAP-029`)** — `services.dart` **L193** checks the deadline only between attempts and **L207** leaves `await work()` unbounded, defeating *"`deadline` bounds the whole job"*; ⛔ **not fixed, 0 code lines changed**. ⭐ **`NTF-CFG-003` resolved per-entry, 11 of 13 `[DERIVED]`** (entitlement/financial/account-lifecycle, plus the `AUTH-8.52` security-significant category) and **3 `[RECOMMENDED]`**; ⭐ **`NTF-GAP-004` CLOSED** — `BC-22` delivers to the role the emitter names and does not resolve moderator identity. ⭐ **`NTF-FR-021`/`-022` placement CLOSED** — `-022` follows from its own exclusion, `-021` from ratified **`NTF-FR-018`** (*"MUST NOT initiate tenant communication"*). ⭐ **`NTF-FR-065` made testable without an SLO** — restated as a per-tenant telemetry **emission** obligation on the `PRD-017`/`MP-NFR-09` precedent, with ⛔ **no target, threshold or error budget**, leaving only the SRE **target** owed. ⛔ **0 numbers invented · 0 frozen PRDs modified · 0 Rank 1–2/Rank 4 changes · `ADR-0107`/`ADR-0108` untouched · 0 code · Stage 4 NOT conferred · Stage 5 NOT entered.** |
