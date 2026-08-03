# Invitation Security Specification

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Status** | **Approved — authoritative** |
| **Satisfies** | Ruling `AR-4`, deferred item — *"the invitation security specification will be documented separately"* |
| **Owner** | Library Management / Tenant Organization (`BC-19`), per `AR-4` |
| **Governs** | Library PRD `LIB-14.5`, `LIB-15.2`; §14A.6 Private library access |
| **Precedence** | Rank 3 — module specification. Outranked by `MASTER_PRD.md` and accepted ADRs |
| **Related ADR** | [`ADR-0009`](../../00-governance/adr/ADR-0009-invitation-security-model.md) |

---

## 0. Why this document exists, and what changed

Ruling `AR-4` assigned invitation **ownership** to Library Management and then
explicitly deferred the security specification, listing six unspecified items with
the instruction **"DO NOT INVENT"**:

| Deferred by `AR-4` | Specified here |
|---|---|
| Expiry / TTL | §4 |
| Revocation | §5 |
| Single-use policy | §6 |
| Entropy | §3 |
| Validation rules | §7 |
| Audit logging | §8 |

The deferral was correct at the time: inventing security parameters without a
mandate is how unreviewable magic numbers enter a codebase. That constraint is now
lifted, because the Library PRD §§1–25 has been received and **the invitation
feature is confirmed to exist** in three forms the product owner has specified:

| Form | Source | Purpose |
|---|---|---|
| **Staff Invite** | Library PRD §15 *"Invite Staff"* | Grant `TR-1`/`TR-2`/`TR-3` in one library |
| **Private Library Invite** | §14A.6 — Invitation Link, QR Code, Invitation Code | Reach and join a Private library |
| **Invitation Code** | §14A.6 | Manually transcribable variant of the above |

`AR-4`'s six deferred items are each specified below with a stated rationale, so
that a reviewer can disagree with a *reason* rather than a bare number.

---

## 1. Scope and boundary

### 1.1 In scope

Invitation artefact creation, format, entropy, transport, expiry, revocation,
single-use enforcement, validation, rate limiting, audit logging, and the
delegation points to `BC-18`.

### 1.2 Explicitly out of scope

`INV-SEC-001` — This specification **MUST NOT** be read as granting this module
any authentication or authorisation capability.

| ID | This module **MUST NOT** | Owner |
|---|---|---|
| `INV-XC-1` | Verify an OTP or issue a session | `BC-18` (`LXC-1`) |
| `INV-XC-2` | Write, evaluate or cache a permission | `BC-18` (`LXC-2`, `AUTH-7.3`) |
| `INV-XC-3` | Create an `Account` | `BC-18` (`ADR-0005`) |
| `INV-XC-4` | Create a membership | `BC-02` (`LXC-3`) |
| `INV-XC-5` | Create a student profile | `BC-01`/`BC-10` (`LXC-4`) |
| `INV-XC-6` | Send the invitation itself over SMS, email or push | `BC-22` (`LXC-8`, `X-04`) |
| `INV-XC-7` | Treat invitation acceptance as authentication | `BC-18` |

`INV-SEC-002` — An invitation **MUST NOT** be a credential. It is a
**scoped, revocable, expiring claim to be offered a role or an enrollment
opportunity**, and it confers nothing until the holder authenticates
independently.

> **This is the single most important sentence in this document.** If an
> invitation authenticates, then possession of a link is possession of an identity,
> forwarding a WhatsApp message transfers an identity, and `MP-GBR-25` — the mobile
> number as **sole** authentication factor — is silently defeated. Every rule
> below follows from refusing that.

---

## 2. Invitation types

`INV-SEC-003` — Exactly three invitation types exist in V1. The list is closed;
adding a type requires a revision of this document.

| ID | Type | Grants on acceptance | Binding | Reusable |
|---|---|---|---|---|
| `IT-1` | **Staff Invitation** | A named library role `TR-1`/`TR-2`/`TR-3` in one library | Bound to one mobile number | ❌ Single use |
| `IT-2` | **Private Library Invitation** | Permission to *initiate* joining one Private library | Optionally bound to one number | ❌ Single use |
| `IT-3` | **Private Library Access Code** | Same as `IT-2` | Not bound to a number | ✅ Multi-use, bounded |

`INV-SEC-004` — `IT-1` **MUST** always be bound to exactly one mobile number,
**MUST** name exactly one role, and **MUST** be single use.

`INV-SEC-005` — `IT-3` is the only multi-use artefact. It **MUST** carry a
maximum acceptance count (`ICFG-6`) and **MUST** stop functioning when that count
is reached.

`INV-SEC-006` — `IT-3` **MUST NOT** be capable of granting a staff role under any
circumstance. A shared code that could confer `TR-2` Manager is a privilege
escalation vector by design.

`INV-SEC-007` — Every invitation **MUST** be scoped to exactly one library and
**MUST** confer nothing in any other (`AUTH-7.14`).

> **Why `IT-3` exists at all, given it is weaker.** §14A.6 explicitly lists a
> *"Library Invitation Code"* alongside links and QR codes — a code an owner reads
> aloud or writes on a whiteboard, which cannot be pre-bound to a number. Removing
> it would remove a stated requirement. It is instead constrained: bounded
> acceptance count, no staff roles, shorter life, and independently revocable.

---

## 3. Entropy and format

`AR-4` deferred item: **Entropy.**

`INV-SEC-008` — An invitation token **MUST** be generated by a cryptographically
secure random number generator. A UUIDv4, timestamp, counter, hash of tenant data,
or any predictable value **MUST NOT** be used.

`INV-SEC-009` — Minimum entropy by type:

| Type | Minimum entropy | Encoded length | Rationale |
|---|---|---|---|
| `IT-1` Staff Invitation | **128 bits** | ~22 chars, URL-safe | Grants an administrative role. Treat as key material |
| `IT-2` Private Library Invitation | **128 bits** | ~22 chars, URL-safe | Delivered as a link or QR; length costs the user nothing |
| `IT-3` Access Code | **≥ 40 bits** | 8 chars, unambiguous alphabet | Must be human-transcribable. Compensated by `ICFG-6`, `ICFG-3` and §9 rate limiting |

`INV-SEC-010` — `IT-3`'s alphabet **MUST** exclude visually ambiguous characters
(`0`/`O`, `1`/`I`/`l`) and **MUST** be case-insensitive on validation. It **MUST
NOT** be shortened below 8 characters to compensate.

`INV-SEC-011` — A token **MUST NOT** encode the tenant identifier, library name,
role, invitee number, expiry, or any other data. It **MUST** be an opaque lookup
key.

`INV-SEC-012` — Tokens **MUST** be stored as a salted cryptographic hash. The
plaintext **MUST** exist only transiently at creation, for delivery.

`INV-SEC-013` — A token **MUST NOT** be recoverable or re-displayable after
creation. Losing it means reissuing it.

`INV-SEC-014` — Token comparison **MUST** be constant-time.

`INV-SEC-015` — A token **MUST NOT** appear in an application log, analytics
event, error message, crash report, audit record, or emitted domain event
(`LIB-21.5`).

> **`INV-SEC-011` is why 40 bits is defensible for `IT-3`.** A self-describing
> code invites tampering — flip a character and try for a different role. An opaque
> key is only ever a lookup: an attacker with an invalid code learns nothing, and
> §9 rate limiting makes 2⁴⁰ guesses across a bounded window infeasible. A
> guessable 8-character code that *encoded* the role would be indefensible at any
> length.
>
> **`INV-SEC-013` will be argued with.** "Let the owner re-show the link" is a
> reasonable-sounding request. But an artefact retrievable from the database is an
> artefact retrievable by anyone who reaches the database, and it means a revoked
> invitation's plaintext still exists. Reissuing is cheap; both are audited.

---

## 4. Expiry

`AR-4` deferred item: **Expiry / TTL.**

`INV-SEC-016` — Every invitation **MUST** carry an absolute expiry recorded at
creation. An invitation without an expiry **MUST NOT** be creatable.

`INV-SEC-017` — Expiry **MUST** be evaluated server-side at every validation.
A client-supplied or client-visible expiry **MUST NOT** be trusted.

`INV-SEC-018` — An expired invitation **MUST** be refused, and refusal **MUST NOT**
be overridable by any library role, including `TR-1` Owner.

`INV-SEC-019` — Expiry **MUST NOT** be extendable. Extending an invitation is
reissuing it: the old artefact dies, a new one is created, both audited.

| ID | Parameter | Default | Range | Rationale |
|---|---|---|---|---|
| `ICFG-1` | `IT-1` Staff Invitation TTL | **48 h** | 1 h – 7 d | Two working days covers a staff member starting Monday invited Friday. Beyond a week an unaccepted administrative grant is stale — the intent is unverifiable |
| `ICFG-2` | `IT-2` Private Library Invitation TTL | **7 d** | 1 h – 30 d | A student may take a week to act. It grants only the *opportunity* to join, so the blast radius is far smaller than `IT-1` |
| `ICFG-3` | `IT-3` Access Code TTL | **24 h** | 1 h – 7 d | Shortest of the three: lowest entropy, multi-use, and shared aloud. Time is the primary compensating control |
| `ICFG-4` | Acceptance window after first use | **15 min** | 5 – 60 min | The gap between clicking and completing OTP. Long enough for a delayed SMS (`CFG-2` × `CFG-1`), short enough that an abandoned half-flow does not linger |

`INV-SEC-020` — `ICFG-1` **MUST NOT** exceed 7 days. A staff role grant pending
longer than a week has lost its authorising context.

`INV-SEC-021` — `ICFG-4` **MUST** be greater than `CFG-2` × `CFG-1` (the full OTP
retry cycle), so that a legitimate invitee is never timed out mid-authentication.

`INV-SEC-022` — These values **MUST** be validated at startup with `INV-1`…`INV-12`
(`IMPL-015`).

| ID | Invariant |
|---|---|
| `INV-13` | `ICFG-1` ≤ 7 d |
| `INV-14` | `ICFG-3` ≤ `ICFG-2` — the weakest artefact never lives longest |
| `INV-15` | `ICFG-4` > `CFG-2` × `CFG-1` |
| `INV-16` | `ICFG-6` ≥ 1 |

---

## 5. Revocation

`AR-4` deferred item: **Revocation.**

`INV-SEC-023` — Any invitation **MUST** be revocable at any time before
acceptance by `TR-1` Owner, by `TR-2` Manager where policy permits, or by a
Platform Administrator under audited elevation.

`INV-SEC-024` — Revocation **MUST** take effect **immediately and globally, with
no propagation window** (`MP-GBR-26`).

`INV-SEC-025` — A revoked invitation **MUST** be refused permanently. Revocation
**MUST NOT** be reversible; reinstatement means issuing a new invitation.

`INV-SEC-026` — Revocation **MUST NOT** delete the invitation record. The record
is retained, marked revoked, with actor, timestamp and reason (§8).

`INV-SEC-027` — Revoking an `IT-3` code **MUST** invalidate it for all future
acceptances, including holders who already possess it.

`INV-SEC-028` — Revocation **MUST NOT** affect a role already granted through a
prior acceptance. Withdrawing a granted role is **staff removal**
(`LIB-15.5`), a separate, separately audited operation.

`INV-SEC-029` — Removing a staff member **MUST** automatically revoke every
outstanding invitation issued *to* that person for that library.

`INV-SEC-030` — Suspending or archiving a library **MUST** automatically revoke
every outstanding invitation for that library (`LIB-8.2`).

`INV-SEC-031` — Changing visibility from Private to Public **MUST NOT**
automatically revoke outstanding `IT-2`/`IT-3` artefacts, but they **MUST** cease
to be *required* for access.

> **`INV-SEC-028` distinguishes two things that are easy to conflate.** Revoking
> an invitation says "this offer is withdrawn". Removing staff says "this person's
> access ends". If revocation silently removed a granted role, an Owner tidying up
> old invitations six months later would lock out their own manager.
>
> **`INV-SEC-030` closes a real gap.** Without it, a library suspended for
> non-payment or abuse still has live invitations that grant `TR-2` Manager on
> acceptance.

---

## 6. Single use and acceptance

`AR-4` deferred item: **Single-use policy.**

`INV-SEC-032` — `IT-1` and `IT-2` **MUST** be single use. Acceptance **MUST**
consume the artefact permanently.

`INV-SEC-033` — Consumption **MUST** be atomic. Two concurrent acceptances of the
same artefact **MUST** result in exactly one success and one refusal
(`INV-SEC-035`).

`INV-SEC-034` — `IT-3` **MUST** enforce a maximum acceptance count (`ICFG-6`) and
**MUST** refuse acceptance beyond it.

`INV-SEC-035` — Acceptance **MUST** be idempotent for the accepting account: a
retry by the same account after a successful acceptance **MUST NOT** create a
second role grant or a second membership.

`INV-SEC-036` — Acceptance **MUST** follow this order, and **MUST NOT** be
reordered:

```
1. Validate artefact          (§7 — this module)
2. Authenticate the holder    (BC-18 — OTP; ADR-0004 two-stage)
3. Bind: confirm the authenticated number matches the bound number,
         for IT-1 and bound IT-2                        (this module)
4. Consume the artefact atomically                      (this module)
5. Request the role grant / enrollment  (BC-18 / BC-02 — never this module)
6. Audit the outcome                                    (§8)
```

`INV-SEC-037` — Step 2 **MUST** precede step 5. A role **MUST NOT** be granted to
an unauthenticated holder.

`INV-SEC-038` — Step 3 **MUST** fail closed. If the authenticated number does not
match the bound number, acceptance **MUST** be refused and the artefact **MUST NOT**
be consumed — so that a mis-delivered invitation remains usable by its rightful
recipient.

`INV-SEC-039` — Step 4 **MUST** precede step 5 and **MUST** be committed in the
same transaction as, or before, the grant request — so that a failure between them
can never leave a reusable artefact that has already granted a role.

`INV-SEC-040` — If step 5 fails, the artefact **MUST** remain consumed and the
failure **MUST** be surfaced and audited. The Owner reissues.

`INV-SEC-041` — Acceptance **MUST NOT** be completable by an account that already
holds the invited role in that library. Such an attempt **MUST** consume nothing
and **MUST** report the existing state.

> **`INV-SEC-038` and `INV-SEC-039` pull in opposite directions and both are
> required.** A binding mismatch must *not* consume — otherwise anyone who
> intercepts a link can burn it, denying the real invitee. A successful
> authentication must consume *before* granting — otherwise a crash between grant
> and consume leaves an artefact that grants again. The distinction is whether the
> rightful holder has been established.

| ID | Parameter | Default | Range | Rationale |
|---|---|---|---|---|
| `ICFG-5` | Outstanding invitations per library | **50** | 1 – 500 | Bounds the damage of a compromised Owner account and the cost of enumeration |
| `ICFG-6` | Max acceptances per `IT-3` code | **25** | 1 – 200 | A classroom-sized cohort. Beyond this the library should be Public |
| `ICFG-7` | Invitations creatable per hour per library | **20** | 1 – 100 | Rate limit on the issuing side |

---

## 7. Validation rules

`AR-4` deferred item: **Validation rules.**

`INV-SEC-042` — Validation **MUST** be performed entirely server-side and **MUST**
check every condition below before any effect:

| # | Condition | On failure |
|---|---|---|
| 1 | Artefact exists (hash lookup) | Generic refusal |
| 2 | Not expired (§4) | Generic refusal |
| 3 | Not revoked (§5) | Generic refusal |
| 4 | Not consumed / count not exhausted (§6) | Generic refusal |
| 5 | Target library exists and is not Suspended or Archived | Generic refusal |
| 6 | For `IT-2`/`IT-3`: library is Private, or has become Public | Generic refusal |
| 7 | For `IT-1`/bound `IT-2`: authenticated number matches binding | Generic refusal, **no consumption** |
| 8 | For `IT-1`: named role is a valid library role | Generic refusal + **alert** |
| 9 | Acceptance rate limits not exceeded (§9) | Throttled refusal |

`INV-SEC-043` — Every refusal **MUST** be **observably identical**: the same
response shape, the same message, and the same timing class. The refusal **MUST
NOT** reveal which condition failed, whether the artefact ever existed, or whether
the library exists.

`INV-SEC-044` — Validation **MUST NOT** disclose the library's name, identifier,
visibility or status to a caller presenting an invalid artefact.

`INV-SEC-045` — A valid `IT-2`/`IT-3` **MAY** reveal the library's §14A.5 public
profile to the holder before authentication — this is the artefact's purpose — but
**MUST NOT** reveal any field outside that allow-list (`LIB-14B.7`).

`INV-SEC-046` — Validation **MUST NOT** be cached. Every presentation is
re-validated (`MP-GBR-26`, `INV-SEC-024`).

`INV-SEC-047` — Condition 8 failing indicates data corruption or tampering. It
**MUST** raise an operational alert in addition to refusing.

> **`INV-SEC-043` is the same anti-enumeration principle as `AR-7` and
> `LIB-14B.24`.** If "expired" and "never existed" are distinguishable, the
> endpoint is an oracle: an attacker sprays codes and reads which tenants exist
> from the differences. Timing is included because a hash lookup that short-circuits
> before a constant-time compare is a measurable side channel.

---

## 8. Audit logging

`AR-4` deferred item: **Audit logging.**

`INV-SEC-048` — Every invitation lifecycle event **MUST** be audit logged as an
append-only record.

| Event | Recorded |
|---|---|
| Created | Type, issuing account, role (`IT-1`), bound number (masked), library, expiry, timestamp |
| Delivered | Delivery channel class, timestamp. **Never the token** |
| Presented | Outcome class, timestamp, origin characteristics |
| Accepted | Accepting account, resulting grant request, timestamp |
| Refused | Refusal **reason internally**, timestamp, origin |
| Revoked | Revoking account, reason, timestamp |
| Expired | Timestamp, by system |

`INV-SEC-049` — Audit records **MUST NOT** contain the token, its plaintext, or
any value from which it could be reconstructed (`INV-SEC-015`).

`INV-SEC-050` — A bound mobile number **MUST** be stored masked in audit records.

`INV-SEC-051` — Audit records **MUST** be append-only and **MUST NOT** be
editable or deletable by any library role, including `TR-1` Owner (`LIB-19.5`).

`INV-SEC-052` — Audit records **MUST** survive account erasure in a form retaining
the fact and timing while no longer identifying the person (`AUTH-9.57`,
`LIB-19.6`).

`INV-SEC-053` — Refusals **MUST** record the internal reason even though the
caller receives a generic response (`INV-SEC-043`). Operators must be able to
distinguish an expiry from an attack.

`INV-SEC-054` — A sustained pattern of refusals against one library or one origin
**MUST** be observable to platform operators (§9).

### 8.1 Events emitted

`INV-SEC-055` — These extend the Library PRD register (§21.1). They **MUST** carry
the tenant key, actor and timestamp, and **MUST NOT** carry the token or an
unmasked number (`LIB-21.5`).

| ID | Event |
|---|---|
| `LEV-23` | `InvitationCreated` |
| `LEV-24` | `InvitationAccepted` |
| `LEV-25` | `InvitationRevoked` |
| `LEV-26` | `InvitationExpired` |
| `LEV-27` | `InvitationRefused` |
| `LEV-28` | `InvitationAbuseSuspected` |

`INV-SEC-056` — `LEV-17` `StaffInvited` and `LEV-23` `InvitationCreated` **MUST**
describe the same fact from two viewpoints and **MUST NOT** be emitted
inconsistently. `LEV-17` is the staff-management view; `LEV-23` is the invitation
view.

---

## 9. Rate limiting and abuse prevention

`INV-SEC-057` — Invitation **creation** **MUST** be rate limited per library
(`ICFG-7`) and per issuing account.

`INV-SEC-058` — Invitation **presentation** **MUST** be rate limited per origin
(`ICFG-8`), independently of `CFG-3`.

`INV-SEC-059` — Repeated failed presentations against one library **MUST** trigger
progressive throttling of that library's invitation endpoint, and **MUST NOT**
affect its public preview (§14B) or any authenticated operation.

`INV-SEC-060` — Throttling **MUST NOT** be implemented by identifying the caller
(`LIB-14B.42`).

`INV-SEC-061` — The number of outstanding invitations per library **MUST NOT**
exceed `ICFG-5`.

`INV-SEC-062` — `IT-3` codes **MUST** be independently rate limited at a stricter
threshold than `IT-1`/`IT-2`, reflecting their lower entropy.

| ID | Parameter | Default | Range | Rationale |
|---|---|---|---|---|
| `ICFG-8` | Invitation presentations per origin per hour | **20** | 5 – 100 | Well above legitimate use (one person, a few retries); far below what makes guessing viable |
| `ICFG-9` | Failed presentations before progressive throttling | **10** | 3 – 50 | Tolerates typos in a transcribed `IT-3` code |
| `ICFG-10` | Throttle duration after threshold | **30 min** | 5 – 120 min | Matches `CFG-4`; long locks are themselves a DoS vector (OWASP) |

`INV-SEC-063` — Throttling **MUST NOT** lock out the legitimate invitee
permanently. `ICFG-10` bounds every throttle.

> **`ICFG-8` at 20/hour is what makes 40-bit `IT-3` entropy safe in practice.**
> Even ignoring `ICFG-3`'s 24-hour life, 20 attempts per origin per hour against a
> 2⁴⁰ space is not a viable search. Entropy and rate limiting are one control, not
> two independent ones — which is why `INV-SEC-062` exists.

---

## 10. Delivery

`INV-SEC-064` — This module **MUST NOT** send an invitation directly. It emits
`LEV-23`; `BC-22` Notification Delivery delivers (`INV-XC-6`, `X-04`).

`INV-SEC-065` — The token **MUST** be passed to delivery through the mechanism
`BC-22` defines for one-time material, and **MUST NOT** be retained by this module
after delivery is queued.

`INV-SEC-066` — An invitation **MUST NOT** be delivered to an address the invitee
did not supply and the issuer did not enter. There is no address book lookup.

`INV-SEC-067` — Delivery **MUST NOT** be attempted to a number that is not the
bound number for `IT-1` or a bound `IT-2`.

`INV-SEC-068` — A QR code **MUST** encode the same artefact and **MUST NOT** be a
weaker parallel path. A QR code is a transport, not a type.

`INV-SEC-069` — An invitation link **MUST** use HTTPS and **MUST NOT** place the
token in a query parameter where it would be captured by referrer headers, server
logs or analytics. It **MUST** be carried in the path or fragment per the platform
convention.

> **`INV-SEC-069` is a mistake almost every implementation makes once.**
> `?invite=abc123` in a query string lands in access logs, referrer headers to
> third-party assets, and analytics payloads — three places the token was never
> supposed to reach, all of them retained.

---

## 11. Configurable values summary

Ten parameters. Operational guidance:
[`../../20-configuration/CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md).

| ID | Parameter | Default | Range | Anchor |
|---|---|---|---|---|
| `ICFG-1` | `IT-1` staff invitation TTL | 48 h | 1 h – 7 d | Two working days; administrative grant staleness |
| `ICFG-2` | `IT-2` private invitation TTL | 7 d | 1 h – 30 d | Student decision window; low blast radius |
| `ICFG-3` | `IT-3` access code TTL | 24 h | 1 h – 7 d | Lowest entropy, multi-use, shared aloud |
| `ICFG-4` | Acceptance window after first use | 15 min | 5 – 60 min | > `CFG-2` × `CFG-1` |
| `ICFG-5` | Outstanding invitations per library | 50 | 1 – 500 | Blast-radius bound |
| `ICFG-6` | Max acceptances per `IT-3` | 25 | 1 – 200 | Classroom cohort |
| `ICFG-7` | Invitations created per hour per library | 20 | 1 – 100 | Issuing-side limit |
| `ICFG-8` | Presentations per origin per hour | 20 | 5 – 100 | Makes `IT-3` entropy sufficient |
| `ICFG-9` | Failures before throttling | 10 | 3 – 50 | Tolerates transcription typos |
| `ICFG-10` | Throttle duration | 30 min | 5 – 120 min | OWASP; matches `CFG-4` |

`INV-SEC-070` — All ten **MUST** be validated at startup with `INV-1`…`INV-16`
(`IMPL-015`). A configuration violating an invariant **MUST** prevent startup.

---

## 12. Acceptance criteria

| ID | Passes when | Fails when |
|---|---|---|
| `IAC-1` | Tokens are CSPRNG-generated at the §3 entropy minimums | Any token derives from a UUID, timestamp, counter or hash of tenant data |
| `IAC-2` | Tokens are stored hashed and salted; plaintext is unrecoverable | Plaintext is stored, logged, or re-displayable |
| `IAC-3` | No token appears in any log, event, error, crash report or audit record | A token is found in any of them |
| `IAC-4` | Every invitation has a server-evaluated absolute expiry | An invitation without expiry is creatable, or expiry is client-trusted |
| `IAC-5` | An expired invitation is refused, unoverridably | Any role can accept an expired invitation |
| `IAC-6` | Revocation takes effect immediately with no propagation window | A revoked artefact is accepted after any interval |
| `IAC-7` | Revocation does not remove an already-granted role | Revoking an old invitation removes a working staff member's access |
| `IAC-8` | Suspending a library revokes all outstanding invitations | An invitation for a suspended library remains acceptable |
| `IAC-9` | `IT-1`/`IT-2` are single use; concurrent acceptance yields exactly one success | Two grants result from one artefact |
| `IAC-10` | `IT-3` stops working at `ICFG-6` acceptances | Acceptance count is unbounded |
| `IAC-11` | `IT-3` cannot grant any staff role | An `IT-3` code produces `TR-1`/`TR-2`/`TR-3` |
| `IAC-12` | Binding mismatch refuses **without** consuming | A mismatched attempt burns the artefact |
| `IAC-13` | Consumption commits before or with the grant request | A crash mid-flow leaves a reusable artefact that already granted |
| `IAC-14` | Authentication precedes role grant in every path | A role is granted to an unauthenticated holder |
| `IAC-15` | All nine refusal conditions are observably identical, including timing class | Any refusal is distinguishable by code, message or latency |
| `IAC-16` | Invalid presentation discloses nothing about library existence or state | A refusal reveals a name, status or identifier |
| `IAC-17` | A valid `IT-2`/`IT-3` reveals only §14A.5 public fields pre-authentication | Any non-allow-listed field is returned |
| `IAC-18` | Every §8 lifecycle event is audited with the required attributes | An event is unlogged or an attribute is missing |
| `IAC-19` | No library role can edit or delete an invitation audit record | An Owner alters invitation history |
| `IAC-20` | Rate limits `ICFG-7`, `ICFG-8` are enforced; throttling is origin-based, not identity-based | Limits are absent, or throttling identifies the caller |
| `IAC-21` | Throttling never exceeds `ICFG-10`, and never permanently locks the invitee | A throttle is unbounded |
| `IAC-22` | This module performs no OTP verification, session issuance or permission write | Any is found in `domain/library` |
| `IAC-23` | Invitations are delivered only via `BC-22` event emission | This module imports `platform/communication/**` |
| `IAC-24` | A link never carries the token in a query parameter | A token appears in a query string |
| `IAC-25` | A startup configuration violating `INV-13`…`INV-16` prevents startup | Invalid configuration boots |

---

## 13. Traceability to `AR-4`

| `AR-4` deferred item | Specified in | Requirements |
|---|---|---|
| Expiry / TTL | §4 | `INV-SEC-016`…`022`, `ICFG-1`…`ICFG-4` |
| Revocation | §5 | `INV-SEC-023`…`031` |
| Single-use policy | §6 | `INV-SEC-032`…`041`, `ICFG-5`…`ICFG-7` |
| Entropy | §3 | `INV-SEC-008`…`015` |
| Validation rules | §7 | `INV-SEC-042`…`047` |
| Audit logging | §8 | `INV-SEC-048`…`056` |

`INV-SEC-071` — With all six specified, ruling `AR-4` is **fully satisfied** and
review conflict `CC-7` is **fully closed**. Ownership was settled by `AR-4`; the
security specification is settled here.

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-03 | Created. Satisfies the `AR-4` deferral in full. Three invitation types `IT-1`…`IT-3`, 71 requirements `INV-SEC-001`…`INV-SEC-071`, ten configurables `ICFG-1`…`ICFG-10`, four invariants `INV-13`…`INV-16`, six events `LEV-23`…`LEV-28`, 25 acceptance criteria. Closes `CC-7` completely. |
