# ADR-0005 — Account creation on first successful OTP verification

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | `AR-2` (Architecture Rulings register v1.0) |
| **Scope** | `BC-18` Identity & Access |

## Context

In a passwordless system there is no separate "set a password" step, so there is no natural second moment at
which registration could complete. The only questions are *when* an `Account` starts to exist and *who* creates
it.

Two pressures conflict. Creating an account when a code is **requested** would let anyone manufacture unlimited
accounts for numbers they do not control, and would make account existence observable — an enumeration oracle.
Creating an account only after some later step, such as joining a library, would leave a verified human with no
identity to attach anything to, and would place registration logic inside whichever module happened to run next
— Library Discovery being the module that most often tried to.

## Decision

**An `Account` is created at the moment of the first successful OTP verification for a mobile number, and at no
other moment.** The Bounded Context Map states this as the `Account` aggregate's lifecycle rule: *"Created on
first successful OTP. Destroyed on account deletion. Holds credentials only."*

`BC-18` Identity & Access is the **sole** creator. Registration, account creation, OTP, session management and
the authorization handoff all belong to `BC-18`.

**Library Discovery must never implement registration logic.** No other bounded context may create an `Account`,
directly or by proxy.

Requesting a code creates **no** account and **no** persistent user-visible state. Before verification succeeds,
a registered and an unregistered number are indistinguishable to any caller (see `ADR-0007`).

## Consequences

**Positive.** Exactly one moment, one owner, one code path. Account existence cannot be probed by requesting
codes. There is no half-registered state to reconcile. Verified control of the number is a precondition of the
identity existing at all, which is what makes the number usable as the identifier.

**Negative.** Account creation shares a transactional boundary with OTP verification; a partial failure there
must not leave a verified challenge consumed without an account, so the operation must be idempotent per number.
The display name must already be in hand at that instant — which is exactly why `ADR-0006` requires it to be
collected earlier.

**Neutral.** A created account has no library, no role and no session until later stages run (`ADR-0004`).

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Create on OTP **request** | Unverified accounts for numbers the requester does not control; makes account existence observable |
| Create on first **library join** | A verified human with no identity; pushes registration logic into `BC-19`/Discovery, violating `BC-18` ownership |
| Create lazily on first write of any kind | Creation moment becomes unpredictable and untestable; multiple modules would race to create |

## Implementation note

The shipped implementation diverges from this decision. The divergence is recorded and **no production code was
changed** by the decision itself — remediation is an implementation task tracked in the Implementation Roadmap,
not a documentation question.

## References

Authentication PRD v2.0 Chapters 4 and 9 · `LIBOORA_BOUNDED_CONTEXT_MAP.md` §4, §14 ·
`ARCHITECTURE_RULINGS.md` `AR-2` · `ACR-001-OTP-Account-Creation.md` ·
`ADR-0004`, `ADR-0006`, `ADR-0007`
