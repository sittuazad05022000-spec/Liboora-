# ADR-0110 — `PRD-010`'s final two gating blockers: the **dispatch rate limb is not `BC-22`'s to publish**, and **`NTF-FR-044` is made testable without asserting a provider fact**

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐ **No new authority act is claimed.** §2 is **`[DERIVED]`** from Rank 4 ownership rows and a FROZEN Rank-3 prohibition; §3 is **`[DERIVED]`** from an accepted Rank-3 precedent (`ITG-FR-019`) and asserts **nothing** about any provider. Same basis as `ADR-0109`: the `PRD-019` v0.4 precedent that closing a check *"under EXISTING authority"* creates no new decision |
| **Supersedes** | — |
| **Amends** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` (v0.12 → v0.13 `DRAFT`) |
| **Amended by** | — |
| **Baseline** | ⛔ No re-issue — `PRD-010` holds no rank |
| **Closes** | ⭐ **`NTF-CFG-001`** — the rate limb leaves this slot as `NTF-XC-008`, so the slot is **COMPLETE** (§2) · ⭐ **`NTF-FR-044`** — now testable, `NTF-AC-013` (§3) · ⭐ **`NTF-GAP-007`** — the rate half is withdrawn, the ceiling is ratified |
| **Does NOT close** | ⛔ **`NTF-GAP-017`** — whether a provider acknowledgement implies **device receipt** stays `[OWED — EXTERNAL EVIDENCE]` · ⛔ `NTF-GAP-003`, `-010`, `-020`, `-028`, `-029` · ⛔ **Stage 4 NOT conferred** |
| **Related** | BC Map **L128**, **L140**, **L381**, **L383** · `PRD-017` **L302** (`FIL-XC-009`) · `PRD-019` **L274** (`ITG-FR-019`) · `CONFIGURATION_GUIDE.md` **L423-426** · `ADR-0107`, `ADR-0108`, `ADR-0109` (**none reopened**) |

---

## 1. The decision test applied to each blocker

For each, the five questions were answered **before** any change:

| Question | Rate limb | `NTF-FR-044` |
|---|---|---|
| 1. Authoritative repository basis for a value? | ⛔ **No** | ⛔ **No** (no provider fact) |
| 2. Strong established precedent? | ⚠ **Yes — but for a different subject** (§2.1) | ⭐ **Yes — `ITG-FR-019`** (§3) |
| 3. Can expert judgment legitimately substitute? | ⛔ **No** for a number — ⭐ **Yes** for the **classification** | ⭐ **Yes** for the **formulation** |
| 4. Does governance require another authority? | ⭐ **Yes — and not the PO**: Rank 4 assigns rate/quota elsewhere (§2.2) | ⛔ **No**, for the reformulated obligation |
| 5. Reformulable without an unsupported claim? | ⭐ **Yes — by withdrawal** | ⭐ **Yes — by asserting only our own record** |

⚠ **The instruction's own test was applied strictly:** *"PO could choose a number"* was **not** treated as proof a number is derivable, and *"FCM documentation would be useful"* was **not** treated as proof it is architecturally required.

---

## 2. The dispatch rate / interval limb — **WITHDRAWN, not valued**

### 2.1 Final targeted audit — every rate precedent in the repository, and why none transfers

| Precedent | Value | Subject | Transfers to notification dispatch? |
|---|---|---|---|
| `CFG-1` | 5 OTP requests / number / hour | ⛔ **Adversarial** — bounds SMS cost + guessing | ⛔ No |
| `CFG-3` | 100 OTP requests / origin / hour | ⛔ **Adversarial** — NAT-gateway abuse | ⛔ No |
| `CFG-11` | 5 claim failures / 24 h | ⛔ **Adversarial** — account-claim abuse | ⛔ No |
| `ICFG-7` | 20 invitations / library / hour | ⛔ *"Rate limit on the **issuing** side"* — abuse | ⛔ No |
| `ICFG-8` | 20 presentations / origin / hour | ⛔ *"far below what makes **guessing** viable"* | ⛔ No |
| `ICFG-9` / `ICFG-10` | 10 failures → 30 min throttle | ⛔ **Progressive throttle** after failure | ⛔ No |
| `LCFG-12` | 20 page size | ⛔ *"Bounds **enumeration** rate"* | ⛔ No |
| `BC-11` `RateLimitCounter` | — | ⛔ Friend-request abuse; **`BC-11`-owned** | ⛔ No |

⇒ ⭐⭐ **Every rate value in this repository bounds an ADVERSARY or an ENUMERATION.** **Zero** bound legitimate **throughput** of a system-initiated dispatch. A notification rate limit is a **capacity/cost** control, not an abuse control — so the family that looks applicable is, on measurement, a **different subject**. Deriving from it would be borrowing a security-throttle rationale for a throughput parameter, the same category error this PRD already refused when it declined `AUTH-3.9`'s `5`.

### 2.2 ⭐⭐ But the classification IS derivable — and it points away from `PRD-010`

Rank 4 already assigns throughput and quota:

| Owner | Row | Assignment |
|---|---|---|
| **`BC-19`** Tenancy | **L128** | *"tiers, residency, lifecycle"* — `Quota` is a **`Tenant`** entity (**L381**) |
| **`BC-21`** Entitlement | **L383** | `EntitlementSet` with **`UsageCounter`**, **`Limit`** — *"Derived state only"* |
| **`BC-31`** Integration | **L140** | *"outbound third-party contracts, credentials, **retries**, idempotent delivery"* |

And FROZEN **`FIL-XC-009`** (`PRD-017` **L302**) forbids a module defining *"a configuration value's default, range or **resolution order**"* outside its own ownership.

⇒ ⭐⭐⭐ **A `PRD-010`-published dispatch rate would be `BC-22` setting another context's limit.** The question was never *"which number?"* — it was *"whose parameter?"*, and Rank 4 answers it.

### 2.3 Decision `[DERIVED]`

> **`NTF-XC-008`** — `BC-22` **MUST NOT** define, default, range or publish a dispatch rate limit, send-rate or throughput quota. Tenant quota is `BC-19`'s, metered limits are `BC-21`'s, outbound pacing is `BC-31`'s.

⇒ **`NTF-CFG-001` is now COMPLETE** on its remaining limb: recipient ceiling **200, range 1–500** (ratified by the PO at `ADR-0108` §7.1).

⛔ **What this is not.** It is **not** a claim that no rate limit should exist — it is a determination that **this PRD is not its home**. ⚠ If `BC-19`/`BC-21`/`BC-31` should publish one, that is **their** slot; recorded as a **pointer**, not an act, and **no number is proposed to them**.

---

## 3. `NTF-FR-044` — made testable **without** asserting a provider fact

### 3.1 Final targeted audit

| Probe | Result |
|---|---|
| FCM/`firebase_messaging` adapter or dependency | ⛔ **0** files; **0** in `pubspec.yaml` |
| Provider documentation in-repo | ⛔ **None.** `docs/30-product/integration/` holds `PRD-019` + its alignment record only — **Razorpay**, not FCM |
| `BC-31` acknowledgement semantics for push | ⛔ **None** — `PRD-019` §4 is the **payment webhook**, inbound |
| Ack/TTL/retry-window constant anywhere | ⛔ **None** |

⇒ ⛔ **No FCM semantics exist, and none is fabricated.**

### 3.2 ⭐⭐ The reformulation, and the precedent that licenses it

`ITG-FR-019` (`PRD-019` **L274**) defines acceptance **by the system's own act**: *"The route **MUST** return an HTTP `2xx` status when, **and only when**, it has durably accepted the event."* It asserts nothing about what the provider then believes.

⇒ ⭐ **The same shape works here.** The prior wording made `delivered` **depend** on an absent provider fact. The new wording makes it depend on **our own durable record** — which exists, and is testable today.

> **`NTF-FR-044`** — A Push delivery **MUST** be marked `delivered` **when, and only when**, `BC-22` has durably recorded a successful `BC-31` egress acknowledgement for that `DeliveryMessage`; a failure or absent acknowledgement **MUST NOT** be recorded as `delivered`. ⛔ **This state MUST NOT be presented, documented or relied upon as evidence that the notification reached a device, was displayed, or was seen by a person.**

⭐⭐ **The critical property: the prohibition is the honest half.** The requirement is now testable **and** it expressly refuses the false equivalence *provider acknowledgement = physical device delivery*. It is consistent with `NTF-FR-043` (*"`delivered` **MUST** mean provider-acknowledged, **not** user-seen"*), which was already ratified — the new text supplies the missing operational definition of *"provider-acknowledged"* without extending it.

⚠ **The residue, narrowed precisely.** `NTF-GAP-017` no longer blocks testability. What remains owed is only whether FCM's acknowledgement **additionally implies device receipt** — an external fact, needed only if the product later wants to claim device-level delivery. **`[OWED — EXTERNAL EVIDENCE]`.**

---

## 4. What this ADR does NOT do

| # | Not done |
|---|---|
| 1 | ⛔ **No rate number invented** · ⛔ **no FCM timeout, TTL or acknowledgement semantics invented** |
| 2 | ⛔ **No PO approval claimed** — the rate limb is **withdrawn on Rank 4 grounds**, not decided by the PO or by me |
| 3 | ⛔ **No claim that provider acknowledgement equals device delivery** — expressly prohibited in the requirement text |
| 4 | ⛔ **No rate published for `BC-19`, `BC-21` or `BC-31`** — pointer only |
| 5 | ⛔ **`ADR-0107`/`0108`/`0109` NOT reopened** · ⛔ **BC Map NOT modified** |
| 6 | ⛔ **No frozen PRD modified** — `PRD-017`, `PRD-019` cited as authority |
| 7 | ⛔ **No Rank 1–2 change · no code · no test · no traceability · no `IMPL-*` · no baseline · registry stays `PLANNED`** |
| 8 | ⛔ **Stage 4 NOT conferred · Stage 5 NOT entered** |

---

## 5. Consequences for the Stage-4 gates

| Gate | Effect |
|---|---|
| **1 — Testable** | ⭐ `NTF-FR-044` was the **last** `[OPEN]` obligation row ⇒ **0 remain** |
| **3 — Configurables** | ⭐ `NTF-CFG-001`'s rate limb withdrawn ⇒ **4 in-scope slots, all complete** |
| 2, 4, 5, 6 | Unchanged — `NTF-XC-008` adds a further MUST-NOT exclusion, strengthening Gate 2 |

⛔⛔ **This does NOT confer Stage 4.** Conferral is the **Requirements Reviewer**'s act (`PRD_LIFECYCLE.md` §6 **L278**), and `ADR-0104` holds that *"appointing a reviewer is not performing a review."* What this ADR removes is the **substantive** obstacle; the **procedural** one stands untouched.

---

## 6. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created and **`Accepted`**. Resolves `PRD-010`'s final two **gating** blockers with **no new authority act and no invented value**. ⭐⭐⭐ **The dispatch rate limb is WITHDRAWN from `NTF-CFG-001` as `NTF-XC-008`, because the audit showed the question was never *"which number?"* but *"whose parameter?"*** — **every** rate precedent in the repository (`CFG-1`, `CFG-3`, `CFG-11`, `ICFG-7`…`ICFG-10`, `LCFG-12`, `BC-11`'s `RateLimitCounter`) bounds an **adversary or an enumeration**, **none** bounds legitimate throughput; while Rank 4 already assigns quota to **`BC-19`** (`Quota`, **L381**), metered limits to **`BC-21`** (`UsageCounter`, `Limit`, **L383**) and outbound pacing to **`BC-31`** (**L140**), and FROZEN **`FIL-XC-009`** forbids a module defining another's configuration. ⇒ `NTF-CFG-001` is **COMPLETE** on its ratified ceiling (200 / 1–500) and **`NTF-GAP-007`** closes. ⛔ **No rate number proposed, here or to the owning contexts.** ⭐⭐ **`NTF-FR-044` is made TESTABLE WITHOUT ASSERTING ANY PROVIDER FACT**, on the accepted **`ITG-FR-019`** shape (*"`2xx` when, **and only when**, it has durably accepted the event"*): `delivered` is now defined by **`BC-22`'s own durable record** of a successful `BC-31` acknowledgement, ⛔ **with an express prohibition on presenting it as evidence of device receipt or user sight** — the honest half of the reformulation, and consistent with already-ratified `NTF-FR-043`. New **`NTF-AC-013`** tests both limbs. ⇒ Gate 1's last `[OPEN]` obligation row is removed. ⚠ **`NTF-GAP-017` is NARROWED, not closed** — only the device-receipt implication remains, `[OWED — EXTERNAL EVIDENCE]`. ⛔ 0 numbers invented · 0 provider semantics asserted · 0 PO approval claimed · `ADR-0107`/`0108`/`0109` untouched · BC Map untouched · 0 frozen PRDs modified · 0 code · **Stage 4 NOT conferred** · **Stage 5 NOT entered**. |
