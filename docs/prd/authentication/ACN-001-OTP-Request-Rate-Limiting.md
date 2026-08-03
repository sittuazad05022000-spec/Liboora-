# ACN-001 — Architecture Consistency Note
## OTP request rate limiting is unspecified and must not be assumed

| Field | Value |
|---|---|
| **Note ID** | `ACN-001` |
| **Type** | Architecture Consistency Note — a recorded specification gap, not a decision |
| **Raised by** | Ruling issued alongside `AR-5`…`AR-7`: *"Do not invent any rate-limiting policy. Create an Architecture Consistency Note documenting that OTP request rate limiting must be specified in the Authentication Security PRD before implementation. No implementation assumptions are permitted."* |
| **Status** | **CLOSED — specified by Authentication PRD v2.0, Chapter 8 §8.3** |
| **Owning bounded context** | `BC-18` Identity & Access |
| **Owning module** | `platform/identity` (rank 4) |
| **Owning document** | `docs/prd/authentication/prd-v2/08-Security-and-Privacy.md` §8.3 |
| **Date** | 2026-08-02 |
| **Blocks** | Any implementation of an OTP request throttle. Does **not** block `IVR-001` |

---

## 0. Closure

**This note is closed.** OTP request rate limiting is now specified normatively in **Authentication PRD v2.0,
Chapter 8 §8.3 — Rate limiting** (`AUTH-8.16` through `AUTH-8.23`), with the numeric thresholds carried as
configurable parameters:

| Parameter | Value | Requirement |
|---|---|---|
| `CFG-1` | 5 OTP requests per mobile number per rolling hour | `AUTH-8.16` |
| `CFG-2` | 30 seconds minimum interval between requests for one number | `AUTH-8.17` |
| `CFG-3` | 30 OTP requests per source network origin per rolling hour | `AUTH-8.18` |
| `CFG-4` | 60-minute temporary lock on per-number quota exhaustion | `AUTH-8.19` |

The specification additionally requires that limits be evaluated server-side against server time (`AUTH-8.20`), apply
identically to registered and unregistered numbers so that limiting never discloses registration status
(`AUTH-8.21`), refuse without revealing which limit was reached (`AUTH-8.22`), and be unbypassable by any role
including platform roles (`AUTH-8.23`).

**Caveat carried forward.** The four numeric values were chosen when v2.0 was authored and are **not** derived from a
prior approved decision. They are marked configurable precisely so they can be changed by decision rather than by
amending the specification. See `PRD-V2-GOVERNANCE-NOTE.md` §4 for the reasoning behind each and the outstanding
sign-off.

The ten open questions recorded below are answered by §8.3 and are retained as the record of what was asked.

---

## 1. What this note records

**OTP request rate limiting is not specified anywhere in the project.** No authoritative document states a
threshold, a window, a scope, a counter, a lockout, a backoff curve or a response for an exceeded limit.

Per the ruling, **no policy is invented here.** This note states the gap, its exact location, its consequence, and
the document that must close it. It contains **no numbers, no thresholds and no defaults**, because every such
value would be an invented requirement.

---

## 2. Evidence — the gap, verified in the code and the documents

### 2.1 `AuthService` contains no issuance throttle

`lib/platform/identity/identity.dart` — the complete set of bounds that exist:

| Bound | Value | What it actually bounds |
|---|---|---|
| `challengeTtl` | `Duration(minutes: 5)` | How long an **issued** challenge stays valid |
| `maxVerifyAttempts` | `5` | How many **verification** attempts a challenge tolerates |
| single-use | `_issued.remove(phone)` on success | Reuse of a **consumed** challenge |

**All three bound verification. None bounds issuance.** `requestOtp` may be called an unlimited number of times,
for an unlimited number of distinct phone numbers, with no counter, no window and no cost.

### 2.2 The owning specification is an empty transfer slot

| Document | Size | Body content |
|---|---|---|
| `docs/prd/authentication/07-Security.md` | 1,280 bytes, 29 lines | **0 characters.** Empty. Defect `D-7` OPEN |

Chapter 7 is the document that owns rate limiting. It has no content. The richest surviving Authentication
specification, `BLOCKER_CLOSURE_v1.0.md`, closes `F-02` on the *predictability and uniformity* of the challenge —
it does not address *frequency of issuance*.

### 2.3 The System Architecture has no OTP rate-limiting capability node either

A repository-wide search for rate limiting, throttling, cooldown and resend policy was run across
`docs/prd/authentication/`, `docs/architecture/`, `MASTER_PRD.md`, `lib/` and `tool/`. Every hit belongs to
**another** capability. Verified in `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (the System Architecture per ruling `R-1`):

| Hit | Location | Belongs to | Relevance |
|---|---|---|---|
| `Anti-Spam & Rate Limits (V1)` | line 920 | **Trust & Safety** (`BC-13`) — social abuse | Not authentication |
| `Request Rate Limits (V1)` | line 939 | **Friends** (`BC-11` Social Graph) — friend requests | Not authentication |
| `RateLimitCounter` | BC Map line 371 | **`BC-11` Social Graph** value object | Not authentication |
| `AI Rate Limits & Quotas (V2)` | line 1195 | AI Platform | Not authentication |
| `Rate Limiting (V2)`, `API Rate Limiting (V2)` | lines 1725, 1796 | Integration / API gateway | Not authentication, and **V2** |
| `Rate Limiter Service (V2)` | line 1883 | Platform Services | Generic; **V2 — out of V1 scope** |

**The `IDENTITY & ACCESS PLATFORM` → `Authentication` branch (lines 617–623) lists exactly six capabilities:**
`Mobile OTP Login (V1)`, `Email Login (V2)`, `Social Login (V2)`, `Enterprise SSO (V3)`,
`Multi-Factor Authentication (V3)`, `Passwordless Login (Future)`.

**There is no rate-limiting capability node under Authentication at any version.** The only general-purpose
limiter in the architecture is `Rate Limiter Service`, which is **V2**. So the gap is not merely an unwritten
policy — the capability itself is unplaced for V1. There is nothing to implement against.

---

## 3. Why the gap matters now

The `AR-7` / option C1 requirement is that a caller must observe **no difference** between a registered and an
unregistered number before verification succeeds. The implementation satisfies this by making challenge issuance
**unconditional** — the registration-dependent branch in `requestOtp` is removed.

That is a **strict security improvement for anti-enumeration** (it removes the last registration-dependent branch,
including its timing and memory side-channels). It also changes what bounds the in-memory challenge map:

| | Before | After |
|---|---|---|
| Entries in `_issued` | Bounded by the number of **registered** accounts | Bounded by the number of **requested** numbers |
| Who controls growth | The tenant's account roster | Any unauthenticated caller |

So the availability characteristic of the challenge store moves from *system-bounded* to *caller-bounded*. The
control that would bound it — a request rate limit — **does not exist and must not be invented.**

**This is a pre-existing gap, not one created by `IVR-001`.** `requestOtp` is unthrottled today. What changes is
that the gap becomes load-bearing, because it is now the only bound on the store's growth.

---

## 4. What is NOT decided by this note

| Question | Status |
|---|---|
| Requests permitted per number, per window | **Unspecified. Must not be assumed** |
| Window length | **Unspecified. Must not be assumed** |
| Whether the limit is per number, per device, per IP, per tenant, or a combination | **Unspecified. Must not be assumed** |
| Resend cooldown between consecutive requests for one number | **Unspecified. Must not be assumed** |
| Behaviour when a limit is exceeded — silent no-op, error code, or lockout | **Unspecified. Must not be assumed** |
| Whether an exceeded-limit response may differ from a normal response | **Unspecified — and constrained: any answer must not reintroduce an enumeration signal (`F-02`, `AR-7`)** |
| Where the counter lives — adapter, port, or Integration Platform | **Unspecified. Must not be assumed** |
| Whether SMS cost / TRAI DLT delivery constraints impose a floor | **Unspecified. Must not be assumed** |
| Bound on the size of the challenge store itself | **Unspecified. Must not be assumed** |
| Whether the capability is V1 or V2 — no Authentication rate-limiting node exists, and `Rate Limiter Service` is **V2** (§2.3) | **Unspecified. Must not be assumed** |

**Ten open questions, zero assumptions.** Each is a product or security decision, not a coding choice.

---

## 5. Constraints any future policy must respect

These are **existing, already-approved** rules that a future rate-limiting specification cannot override. They are
restated, not created:

| Constraint | Source |
|---|---|
| Identical observable behaviour for registered and unregistered numbers until verification succeeds | Ruling `AR-7` / option C1 |
| `F-01` and `F-02` must not be weakened | Ruling `AR-7`; `BLOCKER_CLOSURE_v1.0.md` |
| Mobile OTP remains the sole authentication factor | `MP-GBR-25` |
| No credential, OTP or session may be stored outside `BC-18` | `MP-GBR-27`, `ID-1` |
| No ambient time, id or randomness in domain code — a limiter must take its clock as a port | `X-09` |
| `platform/identity` may import `contracts` only | `tool/module_dependencies.yaml`, rank 4 |

A limiter whose refusal is observable **only for registered numbers** would reopen `F-02`. That is the single
sharpest edge in this area and the reason the policy needs a security review rather than a developer's judgement.

---

## 6. Required to close this note

1. **Authentication Security PRD — Chapter 7** (`docs/prd/authentication/07-Security.md`) is authored with an OTP
   request rate-limiting policy answering the ten questions in §4, including whether the capability is placed in
   V1 at all (§2.3 shows it currently is not).
2. The policy is checked against every constraint in §5, in particular that no refusal is observable in a
   registration-dependent way.
3. An implementation validation report is produced for the limiter, per the standing guardrails.
4. Only then is the limiter implemented.

**Until then:** `requestOtp` remains unthrottled, exactly as it is today. This is recorded as a known, accepted,
documented gap — **not** silently mitigated by an invented default.

---

## 7. Relationship to `IVR-001`

`IVR-001` does **not** depend on this note being closed:

- The gap **predates** the change — `requestOtp` has never been throttled.
- The change **improves** anti-enumeration and does not weaken `F-01` or `F-02`.
- Inventing a limiter inside `IVR-001` would breach both *"Do not invent any rate-limiting policy"* and
  *"Implement only the minimum architecture-aligned changes."*

`IVR-001` therefore proceeds, and carries this note as its recorded residual risk (`RK-4`).

---

## 8. Register entry

| Field | Value |
|---|---|
| Recorded in | `docs/architecture/ARCHITECTURE_RULINGS.md` §6 — *Explicitly deferred — do not invent* |
| Linked risk | `IVR-001` `RK-4` |
| Linked defect | `D-7` — Authentication PRD chapters 1–11 are empty transfer slots |
| Closes when | Chapter 7 specifies the policy and its own validation report is approved |
