# ADR-0002 — Mobile OTP as the sole V1 authentication factor

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Promotes** | `MP-GBR-25`, `MP-CON-11` |
| **Scope** | `BC-18` Identity & Access |

## Context

Liboora's users are library owners, reception staff, students and parents in India. Students are
frequently minors. The platform must authenticate all of them from a mobile application, and reception
staff additionally from a shared desk device.

Passwords impose a burden the target market will not accept: they must be created, remembered, reset,
and stored securely by the platform, and they are reusable indefinitely once stolen. Email is not a
reliable identifier in this market — many students do not use email routinely, whereas essentially every
user has a mobile number that they already treat as their identity for banking, payments and government
services.

## Decision

**Mobile number plus a one-time code is the sole authentication factor in V1.** No password, PIN,
security question or any other reusable secret exists anywhere in the platform.

The code is six numeric digits, valid for five minutes, single-use, with at most five verification
attempts and at most one outstanding challenge per number. Numeric digits are required by the Indian
DLT/TRAI registered-template regime governing transactional SMS.

## Consequences

**Positive.** The platform holds no reusable credential, so there is nothing to steal that grants
indefinite access. Registration is one step. Users are already fluent in the interaction. Password
reset, password strength policy, breach-list checking and credential rotation cease to exist as
problems.

**Negative.** Authentication depends entirely on one delivery channel. An SMS provider outage prevents
all new sign-ins — mitigated by requiring that existing sessions keep working (`AUTH-11.50`) and that
providers be swappable (`AUTH-11.51`). Per-message delivery cost scales with sign-in volume. Most
seriously, **SIM swap defeats the factor entirely**; the compensating control is unrecognised-device
notification (`EV-16`), which is why device management is V1 and not V2.

**Neutral.** Additional factors are roadmap items (§11.12) and none may introduce a reusable secret
(`AUTH-11.79`).

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Password + optional OTP | Reintroduces every problem passwords cause; contradicts the market's expectation |
| Email OTP in V1 | Email is not a reliable identifier in this market; Authentication holds no email address |
| Social login in V1 | Adds third-party dependency and consent complexity for a minor-heavy user base |
| Passkeys in V1 | Device support and user familiarity insufficient in the target market today; on the roadmap |

## References

Authentication PRD v2.0 Chapter 3 · `AUTH-11.67`, `AUTH-11.68` · `MASTER_PRD.md` `MP-GBR-25`, `MP-CON-11`, `MP-DEP-03`
