# ADR-0006 — Display name is collected before verification and is always present

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | `AR-5` (Architecture Rulings register v1.1) |
| **Scope** | `BC-18` Identity & Access · Registration flow |

## Context

`Account.displayName` is a `required`, non-nullable `String`. `ADR-0005` requires the account to be created at
the instant OTP verification succeeds. Those two facts together mean the name must already exist at that instant
— there is no later moment at which it could be supplied without either making the field nullable or inventing a
placeholder.

Every escape route from that constraint damages the product. A nullable field pushes "name might be missing"
into every screen, notification, audit line and staff roster forever. A placeholder such as `"User 9810000001"`
or an empty string is worse: it is indistinguishable from a real name at the type level, so it silently
propagates into attendance sheets, receipts and audit records, and no later validation can tell it apart from a
user who genuinely typed that.

The competing concern is ownership. Authentication must not become a profile service. Collecting arbitrary user
profile data is a Registration concern, not a credential concern.

## Decision

**The Registration flow collects the display name before OTP verification.** `displayName` remains **required
and non-nullable**. No nullable migration, no default, no derivation from the mobile number.

The following are **prohibited** as a display name:

| Prohibited | Detection |
|---|---|
| Empty string | Machine-detectable — refuse account creation |
| Whitespace-only | Machine-detectable — refuse account creation |
| The mobile number itself | Machine-detectable — refuse account creation |
| Placeholder values | Honoured by never producing one |
| Auto-generated names | Honoured by never producing one |

**Ownership is preserved by handing the value across, not by storing it.** Authentication remains responsible for
OTP verification only. The collected name is **supplied to Authentication at the moment of account creation** as
an input parameter. Authentication never holds it as profile state between calls, never generates it, and never
infers it from the subject.

**An existing account's display name is never rewritten by a later verification.** Signing in again does not
overwrite the stored name with whatever was typed on the sign-in screen.

## Consequences

**Positive.** Every account has a real, human-supplied name from the first millisecond of its existence. No
nullable handling anywhere downstream. No placeholder can ever reach an attendance sheet or an audit record.
Authentication stays a credential service.

**Negative.** The registration screen asks for a name before the user has proven anything, so a user who
abandons at the OTP step has typed a name for nothing. The client must carry the collected name through the OTP
step and present it at verification — the two calls are no longer independent.

**Neutral.** The three machine-detectable prohibitions are enforced at account creation, not at input, so the
same rule holds regardless of which client collected the value.

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Make `displayName` nullable | Propagates "name might be missing" into every consumer permanently |
| Auto-generate from the mobile number | Indistinguishable from a real name; leaks the number into rosters and receipts |
| Collect the name **after** verification | Contradicts `ADR-0005` — the account must be creatable at the verification instant |
| Let Authentication own a profile record | Turns a credential service into a profile service; breaks `BC-18` scope |

## References

Authentication PRD v2.0 Chapters 4 and 9 · `ARCHITECTURE_RULINGS.md` `AR-5` ·
`IVR-001` §4.2 Blocker A, risk `RK-1` · `ACR-002` Blocker A · `ADR-0005`
