# ADR-0004 — Authentication and session issuance are separate stages

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | `AR-6` (Architecture Rulings register v1.1) |
| **Scope** | `BC-18` Identity & Access |

## Context

A user's mobile number identifies a **person**. A user's permissions belong to a **person acting inside one
library**. These are not the same fact, and they do not become true at the same moment.

The original implementation collapsed them into a single call:

```
verifyOtp(phone, code) → AuthSession?
```

A `null` return meant three unrelated things at once — wrong code, expired code, and *"the code was correct but
this person has no role anywhere."* The third case is not a failure. It is the normal state of every user who has
just registered and has not yet joined a library, and of every user who was removed from the only library they
belonged to. Under the single-call shape that state was **not representable**, so the system could only report it
as an authentication failure, which is both untrue and unactionable for the user.

The Bounded Context Map already required the separation implicitly: *"Hybrid. `Account` is global; role
assignments are tenant-scoped. `AccessPolicy` is always evaluated with a tenant in scope"* (§11). A global fact
and a tenant-scoped fact cannot be established by one indivisible operation.

## Decision

**Authentication and session issuance are two distinct stages with two distinct outputs.**

```
Collect display name
  → Collect mobile number
  → OTP verification          ── stage 1 output: a verified Account
  → Account creation (if new)
  → Continue original action
  → Membership processing (if required)
  → Role assignment
  → Session issuance          ── stage 2 output: a Session bound to exactly one library
```

Stage 1 proves *who*. Stage 2 grants *what, where*. **An Account may exist with no session and no role**, and
that state is legitimate, persistent, and must be representable in every API, model and screen.

A session is issued **only after** an authorization context exists. Every session is bound to exactly one active
library (`AUTH-6.4`); switching library is a session-scope change, never a re-authentication.

Authentication and Authorization must not be merged into one operation, one service method, or one screen.

## Consequences

**Positive.** "Authenticated with no library" becomes a first-class state the product can respond to — with an
invitation prompt, a discovery screen, or a join flow — instead of a false error. Session issuance can enforce
device limits, trust decisions and library selection at a single well-defined point. Removal of a user's last
role no longer has to masquerade as a credential problem.

**Negative.** This is a **breaking change to the `AuthService` verification signature.** Existing callers must be
updated. The client gains one additional round trip in the first-sign-in path. Two stages mean two failure
surfaces to test rather than one.

**Neutral.** The two stages may execute back-to-back with no user-visible pause for a returning user who has
exactly one library — the separation is architectural, not necessarily a visible extra screen.

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Keep the single call; return a sentinel session with no permissions | A session that authorises nothing is a lie about what a session means, and every consumer must then special-case it |
| Keep the single call; auto-create a personal library so a role always exists | Invents tenant data to satisfy a signature; contradicts `BC-19` ownership and `MP-GBR-08` |
| Keep the single call; return a rich result object instead of splitting | Preserves the coupling — one operation would still own both an identity concern and a tenancy concern |

## References

Authentication PRD v2.0 Chapters 4 and 6 · `AUTH-6.1`–`AUTH-6.10` ·
`ARCHITECTURE_RULINGS.md` `AR-6` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` §11 ·
`ADR-0003` (hybrid tenancy, the structural reason this split is required) ·
`IVR-001` §4.3 Blocker B, risk `RK-2`
