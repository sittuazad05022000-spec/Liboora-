# ADR-0009 — An invitation is a revocable claim, not a credential

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-03 |
| **Closes** | Ruling `AR-4` deferral · review conflict `CC-7` (fully) |
| **Promotes** | `AR-4` from ownership-only to a complete specification |
| **Scope** | Library Management invitations; the `BC-18` delegation boundary |

## Context

Ruling `AR-4` assigned ownership of Invitation Links, QR Codes and Library
Invitation Codes to Library Management / Tenant Organization, and then **explicitly
deferred the security specification** with the instruction *"DO NOT INVENT"*,
listing six unspecified items: expiry, revocation, single-use policy, entropy,
validation rules, audit logging.

The deferral was the right call at the time. Inventing security parameters without
a product mandate produces numbers nobody can defend in review, and the invitation
feature's shape was not yet confirmed — §§1–25 of the Library PRD had never been
supplied.

Two things have now changed. The Library PRD §§1–25 has been received, and it
**confirms the feature exists** in three distinct forms: Staff Invite (§15),
Private Library Invite via link or QR (§14A.6), and a transcribable Invitation
Code (§14A.6). The deferral therefore blocks work that is now specified and
scheduled.

Leaving it deferred has a specific cost. Staff invitation is on the V1 must-have
list (§23), and an implementer building it without this specification will invent
the six missing parameters themselves — in code, undocumented, unreviewed. The
deferral stops being a safeguard and becomes the cause of the thing it was meant
to prevent.

### The decision that actually matters

Six parameters are the visible question. The real question is **what an invitation
*is***, because every parameter follows from it. Two readings were available:

**Reading A — an invitation authenticates its holder.** Possession proves you are
the invitee. Acceptance grants the role directly. This is simple, it is what a
"magic link" does in many products, and it is what an implementer will build by
default.

**Reading B — an invitation is a claim to be *offered* something, and confers
nothing until the holder authenticates independently.**

Reading A cannot be adopted here. `MP-GBR-25` makes the mobile number the **sole
authentication factor** for the platform. If possession of a link authenticates,
then a forwarded WhatsApp message transfers an identity, and the platform has
acquired a second authentication factor — one that travels through channels nobody
controls, cannot be revoked once forwarded, and was never reviewed as a factor.
`ADR-0002` and `ADR-0004` would both be silently defeated.

## Decision

**An invitation is a scoped, revocable, expiring claim to be offered a role or an
enrollment opportunity. It is never a credential and never authenticates its
holder.**

Recorded normatively as `INV-SEC-002` in
[`INVITATION_SECURITY_SPECIFICATION.md`](../../30-product/library/INVITATION_SECURITY_SPECIFICATION.md).

Consequences that follow directly, rather than being chosen separately:

| Because an invitation is not a credential… | Requirement |
|---|---|
| Authentication must happen independently, and first | `INV-SEC-036`, `INV-SEC-037` |
| It must be bindable to one mobile number | `INV-SEC-004` |
| It must expire | `INV-SEC-016` |
| It must be revocable immediately and globally | `INV-SEC-024` |
| Consuming it must not be reversible | `INV-SEC-032` |
| It must never write a permission itself | `INV-XC-2` |
| Revoking it must not remove an already-granted role | `INV-SEC-028` |

### Three types, deliberately unequal

| Type | Entropy | TTL | Multi-use | May grant staff role |
|---|---|---|---|---|
| `IT-1` Staff Invitation | 128 bits | 48 h | ❌ | ✅ |
| `IT-2` Private Library Invitation | 128 bits | 7 d | ❌ | ❌ |
| `IT-3` Access Code | ≥ 40 bits | 24 h | ✅ bounded | **❌ never** |

`IT-3` is weaker by necessity — §14A.6 requires a code a person can read aloud,
and a 22-character token cannot be. It is compensated on three axes rather than
one: the shortest life, a bounded acceptance count, and the strictest rate limit.
`INV-SEC-006` forbids it from ever granting a staff role, because a shared code
that could confer `TR-2` Manager is a privilege escalation vector by construction.

## Consequences

### Accepted

- **`IT-3` is a real, if bounded, weakness.** 40 bits is not 128. The mitigation
  is rate limiting (`ICFG-8` = 20 presentations/origin/hour) and a 24-hour life.
  Entropy and rate limiting are treated as **one control**, which is why
  `INV-SEC-062` requires `IT-3` to be limited more strictly than the others.
- **A lost invitation cannot be re-displayed** (`INV-SEC-013`). Owners will ask
  for this. The answer is reissue-and-audit, because an artefact retrievable from
  the database is retrievable by anyone who reaches the database.
- **Binding mismatch does not consume** (`INV-SEC-038`), so an attacker who
  intercepts a link cannot burn it to deny the real invitee — at the cost of
  letting them retry. Rate limiting bounds that.
- **Ten new configurable parameters.** Each is anchored and range-bounded; four
  new invariants (`INV-13`…`INV-16`) are startup-validated under `IMPL-015`.

### Rejected alternatives

| Alternative | Why rejected |
|---|---|
| Invitation authenticates the holder | Creates a second authentication factor, defeating `MP-GBR-25`, `ADR-0002`, `ADR-0004` |
| Self-describing tokens encoding role and tenant | Invites tampering; leaks tenant data into a shareable artefact (`INV-SEC-011`) |
| No expiry, revocation only | An unrevoked forgotten invitation is a permanent standing grant |
| Reusable staff invitations | One link circulating in a staff WhatsApp group grants `TR-2` to everyone in it |
| Distinct error messages per refusal reason | Turns the endpoint into an enumeration oracle (`INV-SEC-043`, same reasoning as `AR-7`) |
| Invitations owned by `BC-18` | Contradicts `AR-4`. An invitation is an organisational artefact, not a credential |

### Boundary preserved

This specification gives Library Management **no** authentication or authorisation
capability. `INV-XC-1`…`INV-XC-7` restate the prohibitions in enforceable form.
The acceptance sequence delegates OTP verification to `BC-18` and the role grant to
`BC-18`; this module validates the artefact, enforces the binding, consumes it, and
audits.

## Compliance

| Obligation | Where |
|---|---|
| All six `AR-4` deferred items specified | `INVITATION_SECURITY_SPECIFICATION.md` §13 traceability table |
| Revocation immediate and global | `INV-SEC-024` ← `MP-GBR-26` |
| No demo or bypass path | `MP-CON-11`; no test invitation type exists |
| Startup validation of all parameters | `INV-SEC-070` ← `IMPL-015` |
| Audit survives erasure | `INV-SEC-052` ← `AUTH-9.57` |
| Verifiable | 25 acceptance criteria `IAC-1`…`IAC-25` |

## Related

- `AR-4` — ownership ruling this ADR completes
- [`ADR-0002`](./ADR-0002-mobile-otp-sole-factor.md) — the rule that makes Reading A inadmissible
- [`ADR-0004`](./ADR-0004-two-stage-authentication.md) — the two-stage sequence acceptance must follow
- [`ADR-0010`](./ADR-0010-public-preview-anonymous-access.md) — the anonymous surface invitations coexist with
- [`INVITATION_SECURITY_SPECIFICATION.md`](../../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) — the specification
- `IMPL-110`…`IMPL-113` — implementation tasks
