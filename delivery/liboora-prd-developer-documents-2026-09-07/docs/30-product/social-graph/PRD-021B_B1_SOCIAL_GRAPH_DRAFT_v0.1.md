<!--
  PROVENANCE — PRD-021B Part B1

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  This file exists so that the exact state of PRD-021B Part B1 can be recovered
  from the repository after a context loss. It is NOT a freeze, NOT a baseline,
  and NOT a final document.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 (Architecture Review) has NOT
                  been entered. No alignment record exists and none is claimed.
  Open items    : FOD-1 (BC-11 aggregate/transaction boundary — ARB) and
                  FOD-2 (Mute register append — ARB) remain ⛔ OPEN.
                  ADR-0088 and ADR-0090 are PROPOSED ONLY — neither exists as a
                  file, neither is ratified, and this document does not ratify
                  them.

  Directory placement is NOT the placement decision
  -------------------------------------------------
  Filed under docs/30-product/social-graph/ because PRD-021 is registered as
  "Social Graph & Messaging" (PRD_REGISTRY.md L321) owning BC-11 and BC-12,
  and because PRD-021A Part A1 established this filing precedent.
  That is a FILING convention only. It is NOT an architecture placement, a
  bounded-context assignment, or a PRD_REGISTRY.md §4.2 row edit.

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge, event, permission, role or parameter.
    - It amends no FROZEN PRD (PRD-020, PRD-021A A1, Student_Identity_PRD_v1).
    - It amends no Rank 1-5 artefact. BC Map and EA are byte-unchanged.
    - It overrides no ACCEPTED ADR and ratifies no PROPOSED ADR.
    - It records no acceptance criterion as passing.
    - It mints no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — PART B1

## Global Social Graph — Friendship & Friend Requests

### Specification v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** This document is committed
> for context-loss recovery and continuity only. It has **not** entered Stage 3
> (Architecture Review). No alignment record exists.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B1 — Global Social Graph |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 NOT entered |
| Parent | `PRD-021` Social Graph & Messaging (`PRD_REGISTRY.md` L321) |
| Bounded context | **`BC-11` Social Graph** — existing. No new context. Count remains **31** |
| Rank | Unranked at this stage. Not in `DOCUMENTATION_BASELINE.md` §3 |
| Freeze | ⛔ **NOT FROZEN.** No baseline row written, none requested |
| Blocking open decisions | `FOD-1`, `FOD-2` (see Part B0 cross-part document §4) |

### §0.2 Identifier registers — declared up front, with ranges

Per `PRD_LIFECYCLE.md` Stage 2 gate: *"identifier registers declared **up front**
with ranges"*, and §5 rule 4: *"Ranges are contiguous and published."*

| Register | Meaning | Range | Count |
|---|---|---|---|
| `SGR-FR-nnn` | Functional requirement | `001`–`027` | **27** |
| `SGR-BR-nnn` | Business rule | `001`–`018` | **18** |
| `SGR-DM-nnn` | Data model rule | `001`–`012` | **12** |
| `SGR-API-nnn` | API behaviour rule | `001`–`014` | **14** |
| `SGR-EVT-nnn` | Event rule | `001`–`008` | **8** |
| `SGR-PRV-nnn` | Privacy rule | `001`–`007` | **7** |
| `SGR-SEC-nnn` | Security / authorization rule | `001`–`011` | **11** |
| `SGR-PERF-nnn` | Performance rule | `001`–`007` | **7** |
| `SGR-CACHE-nnn` | Caching rule | `001`–`006` | **6** |
| `SGR-EC-nnn` | Edge case | `001`–`018` | **18** |
| `SGR-XC-nnn` | Explicit exclusion | `001`–`014` | **14** |
| `SGR-SCOPE-nnn` | V1 / Future scope statement | `001`–`008` | **8** |
| `SGR-AC-nnn` | Acceptance criterion (GWT) | `001`–`030` | **30** |
| `SGR-GAP-nnn` | Disclosed gap — OPEN | `001`–`003` | **3** |
| **Total** | | | **183** |

⚠ **Range discipline.** Every range above is contiguous `001..max`. No number is
reused. No number is withdrawn. Identifiers here are **specification**
identifiers only — ⛔ **no `IMPL-*` task identifier is minted by this document.**

### §0.3 Prefix collision procedure — executed BEFORE writing

Per `PRD_LIFECYCLE.md` Stage 2 rule 2 and §5 rules 2–3.

| Prefix | Measured occurrences before authoring | Verdict |
|---|---|---|
| `SGR-` | **0** across `docs/` | ✅ free |
| `SSF-` (B2) | **0** across `docs/` | ✅ free |
| `SDS-` (B3) | **0** across `docs/` | ✅ free |
| `XPA-` (B0) | **0** across `docs/` | ✅ free |
| `FOD-` (B0) | **0** across `docs/` | ✅ free |
| ⚠ `SD-` | rejected as a stem — ambiguous against `SID-`/`SDS-` tokenisation | ⛔ not used |

### §0.4 Normative language

Per `PRD_LIFECYCLE.md` Stage 2 rule 4.

- **MUST** / **MUST NOT** — an absolute requirement. A violation is a defect.
- **SHOULD** / **SHOULD NOT** — a strong recommendation; deviation requires a
  recorded reason.
- **MAY** — genuinely optional.
- **⛔** marks a prohibition. **⚠** marks a disclosed defect, gap or risk.

---

## §B1.1 Scope and the FRIEND-only determination

`SGR-SCOPE-001` — B1 specifies the **global FRIEND relationship model** owned by
`BC-11`, comprising friend requests, symmetric friendship, and the rate limits on
graph mutation. Authority: BC Map **L115** — *"Owns relationships: friend
requests, friendships, blocks, rate limits on graph mutation."*

`SGR-SCOPE-002` — Friendship is **global**, not library-scoped. Authority: BC Map
**L488** — `BC-11`…`BC-17` are *"**Global.** No tenantId. Keyed on PersonId."*

`SGR-SCOPE-003` — V1 scope is: send request, accept, reject, cancel, unfriend,
list friends, relationship status, request rate limits. Authority: EA **L936-943**
Friends wave (`Send Request (V1)`, `Accept/Reject (V1)`, `Friends List (V1)`,
`Request Rate Limits (V1)`).

`SGR-SCOPE-004` — ⛔ **FOLLOW is FUTURE and is NOT specified.** Determination
reached on existing repository authority; **no ADR is required as a gate.**

| Evidence | Reading |
|---|---|
| `PRD_LIFECYCLE.md` Stage 1 | *"Is it V1/V2/V3, or Future? Future ⇒ **stop**. EA §10.3: 'do not design for it now, only avoid blocking it'"* |
| EA **L936-943** | Friends wave enumerated. **No FOLLOW node at any wave** |
| BC Map **L377** | `BC-11` structures = `Friendship`, `BlockList`, `FriendRequest`, `RateLimitCounter`. **No follower structure** |
| BC Map **L430** | `BC-11` event surface closed at **two**. Neither is a follow event |
| `PRD-017` **L270** | Disclaims follow/social-discovery **to** `BC-11` — a disclaimer, **not** a conferral |

⚠ **This is an absence-of-evidence finding and is stated as such.** Four
authorities are silent; none contradicts. B1 adds no structure that would block a
later FOLLOW design, satisfying EA §10.3's *"only avoid blocking it"*.

`SGR-SCOPE-005` — `Mutual connections` **capability** is specified in B1 as a
count/derivation rule. ⚠ EA **L940** places `Mutual Friends` at **V2**. B1
therefore specifies the **capability and its derivation**, and marks the
**browsable surface** V2 — see `SGR-FR-025`…`027` and `SGR-SCOPE-006`.

`SGR-SCOPE-006` — **Future (not V1):** FOLLOW · `Close Friends` (EA L941, V2) ·
`Friend Suggestions` (EA L943, V3) · browsable mutual-friend **lists** (V2).

`SGR-SCOPE-007` — B1 owns **no** messaging behaviour. Messaging is `BC-12`'s
(BC Map L378). B1 exposes only `canMessage` via `E-16`.

`SGR-SCOPE-008` — B1 owns **no** discovery behaviour. See Part B3.

---

## §B1.2 Global FRIEND model

`SGR-FR-001` — The system **MUST** model friendship as a **symmetric** relation
between exactly two distinct `PersonId` values. Authority: BC Map **L377** —
*"Symmetric friendship."*

`SGR-FR-002` — A friendship **MUST NOT** exist between a `PersonId` and itself.
Authority: BC Map **L377** — *"no self-friendship."*

`SGR-FR-003` — At most **one** friendship **MUST** exist for any unordered pair
`{A, B}`.

`SGR-BR-001` — Friendship is **global**. It **MUST NOT** be scoped, keyed,
filtered or partitioned by library, tenant, or membership. Authority: `ID-2`
(BC Map L488); `X-05` (Matrix L354, Separate Ways).

`SGR-BR-002` — Friendship **MUST** be keyed exclusively on `PersonId`.
⛔ `StudentRecordId` and `TenantId` **MUST NOT** appear in any B1 structure,
field, index, cache, log or API payload. Authority: CI-enforced
`banned_symbols` (`tool/module_dependencies.yaml` L263-267).

`SGR-XC-001` — ⛔ B1 does **not** own `PersonId` itself. `BC-10` does (BC Map
L376). `PersonId` reaches `BC-11` as a **shared-kernel value object** via `E-15`
(BC Map L319, `SK`, *"PersonId + PrivacyPolicy value objects are jointly owned"*),
which per `ADR-0011` lives in `contracts`, **not** `domain/person`.

---

## §B1.3 Friend request lifecycle and state machine

`SGR-FR-004` — A friend request **MUST** carry: requester `PersonId`, recipient
`PersonId`, state, created-at, and last-transition-at.

`SGR-FR-005` — The friend-request state machine **MUST** be exactly:

| From | Event | To | Actor |
|---|---|---|---|
| *(none)* | send | `PENDING` | requester |
| `PENDING` | accept | `ACCEPTED` → friendship established | recipient |
| `PENDING` | reject | `REJECTED` | recipient |
| `PENDING` | cancel | `CANCELLED` | requester |
| `PENDING` | block (either direction) | `CANCELLED` | either |
| `ACCEPTED` | unfriend | *(friendship removed)* | either |

`SGR-BR-003` — The state register above is **closed for V1**. Adding a state is a
specification change requiring the document owner's act.

`SGR-FR-006` — Only the **recipient** **MUST** be able to accept or reject.
Only the **requester** **MUST** be able to cancel.

`SGR-FR-007` — `REJECTED` and `CANCELLED` are **terminal** for that request
instance. A new request creates a **new** instance.

`SGR-BR-004` — A rejection **MUST NOT** be disclosed to the requester as a
distinct outcome from "no longer pending". Rationale: parity with
`TSF-XC-030`'s principle that exclusion reasons are not published.

---

## §B1.4 Concurrent and inverse requests

`SGR-FR-008` — If A sends to B while B's request to A is `PENDING` (an **inverse
request**), the system **MUST** treat the second send as an **accept** of the
first, producing exactly **one** friendship and **no** second request row.

`SGR-FR-009` — Two simultaneous sends for the same unordered pair **MUST**
converge to exactly one `PENDING` request or one friendship. Never two.

`SGR-BR-005` — Concurrency resolution **MUST** be enforced by a uniqueness
constraint on the **unordered** pair, not by application-level read-then-write.

⚠ `SGR-BR-006` — **Subject to `FOD-1`.** Whether `SGR-FR-008`/`009` execute in a
single transaction depends on the `BC-11` aggregate boundary. BC Map §8 preamble
states *"**The aggregate is the transaction boundary** — one aggregate, one
database transaction, no exceptions."* Whether `Friendship`, `FriendRequest`,
`BlockList` and `RateLimitCounter` form **one** aggregate is ⛔ **OPEN (`FOD-1`)**
and is an **ARB** decision. **B1 is written boundary-agnostically**: the
*outcome* is specified; the *mechanism* awaits `FOD-1`.

---

## §B1.5 Duplicate prevention and idempotency

`SGR-FR-010` — A send where a `PENDING` request already exists in the **same**
direction **MUST** be idempotent: no new row, no new event, no new notification.

`SGR-FR-011` — A send where a friendship already exists **MUST** be rejected as a
no-op conflict, not an error that reveals additional state.

`SGR-API-001` — Every mutating B1 endpoint **MUST** accept an idempotency key at
the API edge, and repeat submissions with the same key **MUST** return the same
outcome without re-executing the effect. Precedent: `PRD-008` `FEE-FR-029`
(idempotency key at the API edge).

`SGR-API-002` — Idempotency keys **MUST** be scoped to the authenticated caller.

---

## §B1.6 Relationship status

`SGR-FR-012` — The system **MUST** expose a relationship-status query for an
ordered pair (viewer, target), returning exactly one of:
`NONE` · `REQUEST_SENT` · `REQUEST_RECEIVED` · `FRIENDS` · `BLOCKED_BY_VIEWER` ·
`UNAVAILABLE`.

`SGR-BR-007` — ⛔ **`BLOCKED_BY_TARGET` MUST NOT be a returned value.** A viewer
blocked by the target **MUST** receive `UNAVAILABLE`, indistinguishable from a
non-existent or privacy-restricted person. Authority: `TSF-XC-030` — *"MUST NOT
publish the reason for a discovery exclusion"*, applied by parity.

`SGR-SEC-001` — Relationship status **MUST** be computed at read time from
authoritative state. ⛔ **MUST NOT** be served from a cached authorization
decision. Authority: `LCM-RM-021`, `LCM-RM-023`.

---

## §B1.7 Friend list

`SGR-FR-013` — The system **MUST** expose the authenticated person's friend list.

`SGR-FR-014` — The friend list **MUST** be paginated with a stable cursor.

`SGR-BR-008` — The friend list **MUST** exclude any person in a block relation in
either direction, evaluated at read time.

`SGR-XC-002` — ⛔ B1 **MUST NOT** expose another person's friend list in V1.

---

## §B1.8 Mutual connections

`SGR-FR-025` — The system **MUST** be able to derive a **mutual-connection
count** for an ordered pair as the cardinality of the intersection of both
friend sets, after block filtering.

`SGR-FR-026` — The mutual-connection count **MUST** exclude any person blocked in
either direction relative to the **viewer**.

`SGR-FR-027` — ⚠ The **browsable mutual-friend list** is **V2** and is **NOT**
specified. Authority: EA **L940** `Mutual Friends (V2)`.

`SGR-BR-009` — The count is a **derivation**, not stored state. ⛔ No mutual-count
table, cache or materialised view. Precedent: `LCM-RM-006` (no persisted
participant row/table/cache/materialised view).

---

## §B1.9 Global relationship scope, multiple libraries, membership expiry

`SGR-BR-010` — Two people who are friends **MUST** remain friends regardless of
how many libraries either belongs to, including **zero**.

`SGR-BR-011` — Belonging to the same library **MUST NOT** create, imply or
auto-establish a friendship.

`SGR-BR-012` — Belonging to **different** libraries **MUST NOT** prevent a
friendship.

⭐ `SGR-BR-014` — **Membership expiry MUST NOT sever a friendship.** A friendship
is global; membership is tenant-scoped. `BC-11` has no lawful way to observe a
membership fact: `ID-2` forbids `StudentRecordId`/`tenantId` in the graph, `X-05`
declares Library Management ⟷ `BC-11`…`BC-17` **Separate Ways** because it
*"merges two tenancy models and two privacy regimes"*, and `E-13` (BC Map L317)
is *"the only bridge between the two worlds"* with *"reference direction upward
only"*. What expiry **does** affect is **library-scoped discovery eligibility**,
which is Part B3's stage-[1] filter — see `SDS-BR-009`.

`SGR-XC-003` — ⛔ B1 **MUST NOT** read `MembershipValidity`. Its published shape
`{studentRecordId, validUntil, seatQuota}` (`MM-FR-066`,
`PRD-MEMBERSHIP-MANAGEMENT.md` L538) names a **CI-banned symbol**. Reading it
inside `domain/social` is **unbuildable**, not merely inadvisable.

---

## §B1.10 Privacy integration

`SGR-PRV-001` — Privacy policy is owned by **`BC-10`** (BC Map L376:
`GlobalStudentProfile` → `PrivacySettings`; *"privacy default = most restrictive;
minors cannot set profile to public"*). ⛔ B1 **MUST NOT** own, duplicate,
override or cache it.

`SGR-PRV-002` — B1 consumes `PrivacyPolicy` as a **shared-kernel value object**
via `E-15`.

`SGR-PRV-003` — A private profile **MUST NOT** prevent an existing friend from
seeing the relationship. Friendship is a mutual, consented relation.

⭐ `SGR-PRV-007` — `identity.PersonPrivacyModeChanged` carries **"no propagation
window"** (BC Map **L427**). B1 **MUST** apply a privacy-mode change to
relationship-status and friend-list responses **immediately on the next read**.
⛔ **MUST NOT** defer to a scheduled job. Corroborated by `SID-4.40` — removal
*"as part of the same operation, not on the next scheduled reindex"*.

`SGR-PRV-004` — ⛔ B1 **MUST NOT** persist any profile field. It holds `PersonId`
references only. Authority: `ADR-0011` — *"consume identity.Person* events; never
import"*; CI `banned_imports: domain/person/**`.

`SGR-PRV-005` — Friend-request notification content **MUST** contain only fields
the recipient is already entitled to see.

`SGR-PRV-006` — ⛔ B1 **MUST NOT** support lookup by mobile number. Authority:
`SID-4.41`.

---

## §B1.11 B2 safety integration

`SGR-FR-015` — Before creating a `PENDING` request the system **MUST** consult
the **B2 Safety Check** interface (§B2.16). A block in **either** direction
**MUST** prevent the request.

`SGR-BR-013` — **Block overrides friendship.** Authority: BC Map **L377** —
*"block is unilateral and overrides friendship."*

`SGR-FR-016` — Establishing a block where a friendship exists **MUST** remove the
friendship, and **MUST** cancel any `PENDING` request in either direction.

`SGR-SEC-002` — The Safety Check **MUST** fail **closed**. If it cannot be
evaluated, the mutation **MUST** be refused. Precedent: `LCM-RM-025` —
*"unavailable rather than stale-but-usable."*

`SGR-XC-004` — ⛔ B1 does **not** own Block. It is `BC-11`'s `BlockList`
(BC Map L377) specified in **Part B2**. B1 **consumes** the decision.

---

## §B1.12 Authorization

`SGR-SEC-003` — ⛔ **No authorization decision is made outside `BC-18`.**
Authority: `PRD_LIFECYCLE.md` Stage 3 check 4; `X-13` — *"A security defect that
passes its own tests."* B1 performs **relationship-eligibility** evaluation, which
is domain state, **not** an authentication or permission decision.

`SGR-SEC-004` — Every B1 mutation **MUST** be authenticated. The acting
`PersonId` **MUST** be resolved **server-side** from the session.
⛔ A client-supplied actor identity **MUST** be **rejected, not honoured**.
Precedent: `LCM-API-013`.

`SGR-SEC-005` — ⛔ B1 **MUST NOT** handle credentials, OTPs or sessions.
Authority: `ID-1`; Stage 3 check 5.

`SGR-SEC-006` — An enforcement action from `BC-13` (`E-14`,
`EnforcementActionTaken{personId, action, scope, until}`) **MUST** cause `BC-11`
to **self-restrict**. ⛔ `BC-13` **MUST NOT** write into `BC-11`. Authority:
BC Map L318; `TSF-XC-021`.

`SGR-SEC-007` — A suspended person **MUST NOT** send or accept requests.

`SGR-SEC-008` — ⛔ B1 **MUST NOT** log a `PersonId` alongside any tenant-scoped
identifier.

`SGR-SEC-009` — All B1 endpoints **MUST** reject requests where the target
`PersonId` is malformed, without disclosing whether it exists.

`SGR-SEC-010` — Enumeration resistance: responses for "does not exist",
"blocked", and "privacy-restricted" **MUST** be indistinguishable
(`UNAVAILABLE`).

---

## §B1.13 Rate limiting

`SGR-FR-017` — Friend-request sending **MUST** be rate-limited per requester over
a rolling window. Authority: BC Map **L377** — *"request rate limit per rolling
window"*; EA **L924** `Anti-Spam & Rate Limits (V1)`.

`SGR-BR-015` — `RateLimitCounter` is a **`BC-11`-owned** structure (BC Map L377).
⛔ T&S does **not** own it: `TSF-XC-003`/`F-6` — *"T&S does not own Block, Mute or
graph rate limits."*

`SGR-FR-018` — A rate-limited send **MUST** be refused without creating a
request, without an event, and without notifying the recipient.

`SGR-BR-016` — ⚠ The rate-limit **threshold and window values** are **NOT
specified here** — they are configuration owned by the document owner. ⛔ No
numeric value is invented.

`SGR-FR-019` — Rate-limit refusals **MUST** be counted as a deterministic abuse
signal available to B2 (§B2.9). ⛔ B1 **MUST NOT** classify abuse itself.

---

## §B1.14 Data model

`SGR-DM-001` — Structures owned: `Friendship`, `FriendRequest`,
`RateLimitCounter`. (`BlockList` is `BC-11`'s but specified in B2.)
Authority: BC Map **L377**.

`SGR-DM-002` — `Friendship` **MUST** store the pair in a canonical **ordered**
form (e.g. lower `PersonId` first) so the uniqueness constraint is enforceable.

`SGR-DM-003` — ⛔ **No** field of type `StudentRecordId` or `TenantId`.
CI-enforced.

`SGR-DM-004` — ⛔ **No** denormalised profile field (name, username, avatar).
`ADR-0011`.

`SGR-DM-005` — ⛔ **No** friend-count column. Counts are derived
(`LCM-RM-006` precedent).

`SGR-DM-006` — Timestamps **MUST** be stored UTC.

⭐ `SGR-DM-007` — **A `PersonId` may be referenced before `BC-11` has observed any
event for it.** BC Map **L424** shows `identity.PersonIdentityCreated` fanning out
to `BC-23`, `BC-24`, `BC-26` — **`BC-11` is NOT a listed consumer**, whereas
**L425-428** do list `BC-11` for `PersonProfileUpdated`,
`PersonUsernameChanged`, `PersonPrivacyModeChanged` and `PersonAnonymised`.
Therefore B1 **MUST** treat an unknown-but-well-formed `PersonId` as **valid but
unenriched** and **MUST NOT** reject it merely because no event has been observed.
⛔ B1 **MUST NOT** call `BC-10` synchronously to resolve it (`ADR-0011`;
`banned_imports: domain/person/**`).

`SGR-DM-008` — Uniqueness constraint on the canonical `Friendship` pair.

`SGR-DM-009` — Uniqueness constraint on `(requester, recipient, state=PENDING)`.

`SGR-DM-010` — ⚠ **Subject to `FOD-1`.** Whether these structures share one
aggregate root is ⛔ **OPEN**. The **constraints** above hold under either
resolution; only their **enforcement mechanism** differs.

`SGR-DM-011` — ⛔ **No `Mute` structure is defined in B1.** See B2 and `FOD-2`.

`SGR-DM-012` — ⛔ **No follower/following structure.** `SGR-SCOPE-004`.

---

## §B1.15 APIs

`SGR-API-003` — `POST` send friend request.
`SGR-API-004` — `POST` accept.
`SGR-API-005` — `POST` reject.
`SGR-API-006` — `POST` cancel.
`SGR-API-007` — `DELETE` unfriend.
`SGR-API-008` — `GET` friend list (paginated).
`SGR-API-009` — `GET` incoming requests (paginated).
`SGR-API-010` — `GET` outgoing requests (paginated).
`SGR-API-011` — `GET` relationship status for a target.

`SGR-API-012` — ⚠ **No endpoint path, URL, route, HTTP status code or payload
schema is specified here.** ⛔ Inventing them is barred by the `ADR-0035` §5.5b
class of prohibition (*"No endpoint, URL, path or route"*). This register names
**operations and their behaviour**, not wire format.

`SGR-API-013` — Every list endpoint **MUST** use cursor pagination with a stable
sort. ⛔ Offset pagination **MUST NOT** be used.

`SGR-API-014` — Every endpoint **MUST** resolve the actor server-side
(`SGR-SEC-004`).

---

## §B1.16 Events

`SGR-EVT-001` — `BC-11` publishes exactly **two** events:
`social.FriendshipEstablished` and `social.UserBlocked`, both to `BC-12` and
`BC-26`. Authority: BC Map **L430**. ⛔ **The surface is closed at two.**

`SGR-EVT-002` — ⛔ B1 **MUST NOT** mint a new published event. Doing so is a
Rank 4 change requiring an ADR *before* the change
(`DOCUMENTATION_BASELINE.md` §7 rule 1).

`SGR-EVT-003` — `BC-11` **consumes** four `BC-10` events (BC Map L425-428):
`PersonProfileUpdated`, `PersonUsernameChanged`, `PersonPrivacyModeChanged`,
`PersonAnonymised`.

`SGR-EVT-004` — `BC-11` consumes `EnforcementActionTaken` from `BC-13` via
`E-14`.

⭐ `SGR-EVT-005` — **`identity.PersonAnonymised` is the authoritative deletion
trigger.** On receipt, B1 **MUST** remove all friendships and requests involving
that `PersonId`. Authority: BC Map **L428** (SEV-16, `ID-5`).

`SGR-EVT-006` — ⛔ B1 **MUST NOT** treat absence of `PersonIdentityCreated` as
non-existence. See `SGR-DM-007`.

⚠ `SGR-GAP-001` — **OPEN.** There is **no** published `social.FriendshipRemoved`
event. `BC-12` therefore receives no proactive revocation signal on unfriend.
**Assessed NON-BLOCKING** because BC Map **L378** makes participants satisfy
`canMessage` **at send time**, so `BC-12` re-asks via `E-16` on every send.
⛔ **No event is minted to close this.** Routed to the `BC-11` owner + ARB.

`SGR-EVT-007` — `E-16` (BC Map L320) is a **synchronous C/S port**:
`canMessage(a, b)`. *"Messaging must ask; block enforcement lives in the graph."*

`SGR-EVT-008` — `E-28` (V2) carries `RateLimitCounter` + `BlockList` **reads** to
community. *"`BC-11` remains the owner."* ⛔ No ownership transfer.

---

## §B1.17 Discovery integration

`SGR-FR-020` — B1 **MUST** expose relationship signals for B3's read
composition: relationship status and mutual-connection count.

`SGR-XC-005` — ⛔ B1 **MUST NOT** perform discovery, search, ranking or candidate
generation. Part B3 composes; `BC-23` indexes and ranks.

`SGR-XC-006` — ⛔ `BC-11` is **deliberately not** a `BC-23` consumer. Authority:
`E-22` (BC Map L331) — *"`BC-11` and `BC-13` are deliberately NOT consumers …
`BC-11` answers eligibility as a boolean and never holds a `FileRef`"*; and
`E-21` (L330) lists only `BC-01`, `BC-10` → `BC-23`.

---

## §B1.18 Messaging integration

`SGR-FR-021` — B1 **MUST** answer `canMessage(a, b)` synchronously via `E-16`.

`SGR-BR-017` — `canMessage` **MUST** return false if a block exists in either
direction. Friendship is **not** necessarily required — the V1 messaging
eligibility predicate is `BC-12`'s to state; B1 supplies the **graph** facts.

`SGR-XC-007` — ⛔ B1 owns **no** `Conversation`, `Message`, `DeliveryReceipt` or
`RetentionPolicy`. Those are `BC-12`'s (BC Map L378).

`SGR-SEC-011` — `canMessage` **MUST NOT** disclose
**why** it returned false.

---

## §B1.19 Notification integration

`SGR-FR-022` — Friend-request and acceptance notifications **MUST** be delivered
by **`BC-22` Notification Delivery**. Authority: BC Map **L332** `E-23` routes
*all contexts* to `BC-22`.

`SGR-XC-008` — ⛔ B1 **MUST NOT** own notification delivery, templates, channels
or preferences.

⚠ `SGR-XC-009` — **`PRD-010` is NOT created; it remains `PLANNED`**
(`PRD_REGISTRY.md` §11.4). The **owner of the notification contract detail** is
therefore ⛔ **not currently defined in repository** at PRD level, while the
**context** owner (`BC-22`) and the **edge** (`E-23`) both exist. ⛔ Nothing is
invented to fill it.

---

## §B1.20 Audit

`SGR-FR-023` — Every state transition **MUST** produce an audit record:
actor, target, transition, timestamp, source.

`SGR-BR-018` — Audit records **MUST** be append-only.

`SGR-XC-010` — ⛔ B1 does not own the audit store. `BC-16` does.

`SGR-FR-024` — Audit records **MUST NOT** contain profile content or message
content.

---

## §B1.21 Performance

`SGR-PERF-001` — Relationship-status lookup **MUST** be a single indexed read.

`SGR-PERF-002` — Friend-list pagination **MUST NOT** degrade with total friend
count.

`SGR-PERF-003` — `canMessage` **MUST** be answerable within the synchronous
budget `BC-12` requires. ⚠ **No numeric latency target is invented here** — it is
an owner-set operational parameter.

`SGR-PERF-004` — Mutual-connection count **MUST** be bounded; an unbounded
intersection **MUST** be refused rather than run.

`SGR-PERF-005` — Rate-limit checks **MUST** be O(1) per attempt.

`SGR-PERF-006` — `PersonAnonymised` cleanup **MAY** be asynchronous, but
**MUST** be complete and **MUST NOT** leave orphan rows.

`SGR-PERF-007` — ⛔ No B1 read path **MAY** call `BC-10` synchronously.

---

## §B1.22 Caching

`SGR-CACHE-001` — B1 **MAY** cache **immutable derived** data only.

⛔ `SGR-CACHE-002` — B1 **MUST NOT** cache any **authorization, eligibility,
privacy or safety decision.** Authority: `LCM-RM-021`, `LCM-RM-023`.

`SGR-CACHE-003` — Relationship status **MUST NOT** be cached across a privacy
change. Authority: `SGR-PRV-007`; BC Map L427 *"no propagation window"*.

`SGR-CACHE-004` — Block state **MUST NOT** be cached. See `SSF-CACHE-*`.

`SGR-CACHE-005` — If a cache cannot be validated, B1 **MUST** treat the data as
**unavailable rather than stale-but-usable**. Authority: `LCM-RM-025`.

`SGR-CACHE-006` — ⛔ **No materialised view** of friendships, counts or mutuals.
Authority: `LCM-RM-006`.

---

## §B1.23 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `SGR-EC-001` | Self-request | Refused. `SGR-FR-002` |
| `SGR-EC-002` | Inverse request | Auto-accept; one friendship. `SGR-FR-008` |
| `SGR-EC-003` | Duplicate send | Idempotent no-op. `SGR-FR-010` |
| `SGR-EC-004` | Send to existing friend | No-op conflict. `SGR-FR-011` |
| `SGR-EC-005` | Send while blocked (either way) | Refused as `UNAVAILABLE`. No disclosure |
| `SGR-EC-006` | Accept an already-cancelled request | Refused; terminal state |
| `SGR-EC-007` | Accept by a non-recipient | Refused. `SGR-FR-006` |
| `SGR-EC-008` | Concurrent accept + cancel | Exactly one wins; no partial state |
| `SGR-EC-009` | Block during `PENDING` | Request → `CANCELLED`. `SGR-FR-016` |
| `SGR-EC-010` | Unfriend twice | Second is idempotent |
| `SGR-EC-011` | `PersonAnonymised` for a friend | All relations removed. `SGR-EVT-005` |
| `SGR-EC-012` | Unknown-but-well-formed `PersonId` | Valid but unenriched. `SGR-DM-007` |
| `SGR-EC-013` | Privacy → private with existing friends | Friendships persist. `SGR-PRV-003` |
| `SGR-EC-014` | Membership expires | Friendship persists. `SGR-BR-014` |
| `SGR-EC-015` | Person in zero libraries | Friendship persists. `SGR-BR-010` |
| `SGR-EC-016` | Suspended person attempts send | Refused. `SGR-SEC-007` |
| `SGR-EC-017` | Rate limit reached | Refused; no event; no notification. `SGR-FR-018` |
| `SGR-EC-018` | Safety Check unavailable | Mutation refused (fail closed). `SGR-SEC-002` |

---

## §B1.24 Explicit exclusions (consolidated)

`SGR-XC-011` — ⛔ No FOLLOW. `SGR-XC-012` — ⛔ No close friends (V2).
`SGR-XC-013` — ⛔ No friend suggestions (V3). `SGR-XC-014` — ⛔ No group/circle
construct. *(Plus `SGR-XC-001`…`010` above.)*

---

## §B1.25 V1 / Future scope summary

| Capability | Scope | Authority |
|---|---|---|
| Send / accept / reject request | **V1** | EA L937-938 |
| Friends list | **V1** | EA L939 |
| Request rate limits | **V1** | EA L940 |
| Mutual-connection **count** | **V1** (derivation) | `SGR-FR-025` |
| Mutual-friend **browsable list** | **V2** | EA L940 |
| Close friends | **V2** | EA L941 |
| Friend suggestions | **V3** | EA L943 |
| FOLLOW | ⛔ **Future** | `SGR-SCOPE-004` |

---

## §B1.26 Acceptance criteria — GWT (30)

> ⚠ **No criterion below is recorded as passing.** These are specifications of
> intended behaviour at Stage 2. ⛔ No test exists and none is claimed.

| ID | Given | When | Then | Maps to |
|---|---|---|---|---|
| `SGR-AC-001` | A and B are not related | A sends a request to B | Exactly one `PENDING` request exists | `SGR-FR-004/005` |
| `SGR-AC-002` | A request to self is attempted | A sends to A | Refused; no row created | `SGR-FR-002` |
| `SGR-AC-003` | B has a `PENDING` request to A | A sends to B | Exactly one friendship; zero additional requests | `SGR-FR-008` |
| `SGR-AC-004` | A `PENDING` A→B exists | A sends A→B again | No new row, no new event, no new notification | `SGR-FR-010` |
| `SGR-AC-005` | Two sends for `{A,B}` race | Both commit | Exactly one `PENDING` or one friendship | `SGR-FR-009`, `SGR-BR-005` |
| `SGR-AC-006` | A `PENDING` A→B exists | C attempts accept | Refused | `SGR-FR-006` |
| `SGR-AC-007` | A request was rejected | A queries status | `NONE`; rejection not disclosed | `SGR-BR-004` |
| `SGR-AC-008` | Same idempotency key resubmitted | Endpoint called twice | Same outcome; effect executed once | `SGR-API-001` |
| `SGR-AC-009` | B has blocked A | A queries status of B | `UNAVAILABLE`, not `BLOCKED_BY_TARGET` | `SGR-BR-007` |
| `SGR-AC-010` | A and B are friends | B blocks A | Friendship removed; pending requests cancelled | `SGR-FR-016`, `SGR-BR-013` |
| `SGR-AC-011` | Safety Check is unavailable | A sends to B | Mutation refused (fail closed) | `SGR-SEC-002` |
| `SGR-AC-012` | A is authenticated as A | Request supplies actor = C | Client-supplied actor **rejected**, not honoured | `SGR-SEC-004` |
| `SGR-AC-013` | A is suspended via `E-14` | A sends a request | Refused; `BC-13` performed no write into `BC-11` | `SGR-SEC-006/007` |
| `SGR-AC-014` | A has hit the rolling-window limit | A sends again | Refused; no request, no event, no notification | `SGR-FR-018` |
| `SGR-AC-015` | A rate-limit refusal occurs | B2 requests abuse signals | The refusal is available as a deterministic signal | `SGR-FR-019` |
| `SGR-AC-016` | A membership expires | Friend list is read | The friendship is still present | `SGR-BR-014` |
| `SGR-AC-017` | A belongs to zero libraries | Friend list is read | Friendships persist | `SGR-BR-010` |
| `SGR-AC-018` | A and B are in different libraries | A sends to B | Permitted | `SGR-BR-012` |
| `SGR-AC-019` | A and B share a library | Membership is granted | No friendship is auto-created | `SGR-BR-011` |
| `SGR-AC-020` | B switches public → private | A reads status on the next request | The change is applied immediately, not on a schedule | `SGR-PRV-007` |
| `SGR-AC-021` | `PersonAnonymised` for B is consumed | Friend lists are read | All B relations are absent | `SGR-EVT-005` |
| `SGR-AC-022` | No event observed for `PersonId` P | A sends to P | Treated as valid but unenriched; not rejected | `SGR-DM-007` |
| `SGR-AC-023` | A friend list is requested | Pagination cursor is followed | Stable cursor order; no offset pagination | `SGR-API-013` |
| `SGR-AC-024` | A blocked person is a friend-list member | List is read | Excluded at read time | `SGR-BR-008` |
| `SGR-AC-025` | Mutual count is requested | Viewer has blocked X | X excluded from the count | `SGR-FR-026` |
| `SGR-AC-026` | `BC-12` needs permission | `canMessage(a,b)` is called via `E-16` | Answered synchronously; reason not disclosed | `SGR-EVT-007`, `SGR-SEC-010` |
| `SGR-AC-027` | A friendship is established | Published events are inspected | Exactly `social.FriendshipEstablished`; no new event minted | `SGR-EVT-001/002` |
| `SGR-AC-028` | The B1 source tree is analysed | `dart run tool/check_module_boundaries.dart` runs | **Zero violations introduced by B1** (pre-existing `ADR-0012` set excluded) | `SGR-BR-002`, `SGR-DM-003` |
| `SGR-AC-029` | Any B1 structure is inspected | Fields are enumerated | No `StudentRecordId`, no `TenantId`, no profile field | `SGR-DM-003/004` |
| `SGR-AC-030` | Any state transition occurs | Audit store is read | An append-only record exists with actor, target, transition, timestamp | `SGR-FR-023`, `SGR-BR-018` |

⚠ `SGR-AC-028` is worded *"introduced by B1"* deliberately: the repository CI
currently returns `FAIL — 9 violation(s)` from the **pre-existing `ADR-0012`
set**, which is ⛔ **not caused by, and not repaired by, this document.**

---

## §B1.27 Disclosed gaps — all OPEN

| ID | Gap | Blocking? | Routed to |
|---|---|---|---|
| `SGR-GAP-001` | No `social.FriendshipRemoved` event | ⛔ No — `canMessage` is evaluated at send time (BC Map L378) | `BC-11` owner + ARB |
| `SGR-GAP-002` | Rate-limit threshold/window values unspecified | ⛔ No — configuration, not architecture | Document owner |
| `SGR-GAP-003` | `FOD-1` aggregate boundary undecided | ⛔ Not for authoring; **yes** for schema | **ARB** |

---

## §B1.28 What this document does not do

⛔ Creates no bounded context (count remains **31**) · ⛔ creates no integration
edge · ⛔ mints no published event · ⛔ mints no `IMPL-*` identifier · ⛔ creates
no implementation task · ⛔ amends no frozen PRD · ⛔ amends no Rank 1–5 artefact
· ⛔ ratifies no ADR · ⛔ claims no Stage 3 alignment · ⛔ records no acceptance
criterion as passing · ⛔ resolves neither `FOD-1` nor `FOD-2`.

---

**END — `PRD-021B` Part B1 v0.1 — DRAFT / Stage 2.**
