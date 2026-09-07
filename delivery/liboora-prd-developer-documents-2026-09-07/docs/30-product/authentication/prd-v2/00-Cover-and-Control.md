# Liboora — Authentication Product Requirements Document

| Field | Value |
|---|---|
| **Document** | Authentication PRD |
| **Bounded context** | `BC-18` Identity & Access `[GENERIC]` |
| **Version** | **v2.0** |
| **Status** | **PRODUCTION-READY — AUTHORITATIVE** |
| **Applies to** | Liboora multi-tenant SaaS platform, Version 1 |
| **Date** | 2026-08-02 |

---

## A. Authority and standing

This document is the **single authoritative specification** for Authentication in Liboora. It is self-contained.
Where any other material disagrees with this document, **this document governs**.

## B. Scope of the document

Eleven chapters, each normative:

| Ch. | Title |
|---|---|
| 1 | Purpose & Goals |
| 2 | User Types & Roles |
| 3 | Authentication Methods |
| 4 | Registration & Account Claim |
| 5 | Login & Library Selection |
| 6 | Session & Device Management |
| 7 | Roles, Permissions & Access Policies |
| 8 | Security & Privacy |
| 9 | Account Lifecycle |
| 10 | Events, Audit & Notifications |
| 11 | Non-Functional Requirements, Compliance & Final Acceptance |

## C. Identifier scheme

| Prefix | Meaning |
|---|---|
| `AUTH-c.n` | Normative requirement, chapter `c` |
| `BR-c.n` | Business rule |
| `XC-c.n` | Edge case |
| `AC-c.n` | Acceptance criterion |
| `PR-n` | Platform role |
| `TR-n` | Tenant (library) role |
| `EV-n` | Authentication domain event |
| `AERR-n` | Authentication error class |
| `CFG-n` | Configurable parameter |

Chapters additionally use local principle bands, each defined where it first appears.

## D. Normative language

**MUST** / **MUST NOT** — mandatory. **SHOULD** — strongly recommended; deviation requires recorded justification.
**MAY** — permitted. Statements without these keywords are explanatory and carry no obligation.

## E. Configurable parameters

The following values are **configurable**. Changing any of them alters behaviour but not architecture, and does not
require a change to this specification. They are collected here so that the complete operating envelope can be read
in one place.

Each value is an **enterprise-recommended default** anchored to a recognised standard or established industry
practice. Permitted ranges, validation rules, failure modes, per-environment overrides and the rationale for each
default are specified in the **Configuration Guide** (`docs/20-configuration/CONFIGURATION_GUIDE.md`), which is
normative for operations.

| ID | Parameter | Value | Governing chapter |
|---|---|---|---|
| `CFG-1` | OTP requests per mobile number, rolling 1 hour | 5 | 8 |
| `CFG-2` | Minimum interval between OTP requests for one number | 30 seconds | 8 |
| `CFG-3` | OTP requests per source network origin, rolling 1 hour | 100 | 8 |
| `CFG-4` | Temporary lock duration after request quota exhaustion | 30 minutes | 8, 9 |
| `CFG-5` | Idle session timeout | 30 days (mobile), 30 minutes (staff) | 6 |
| `CFG-6` | Absolute session lifetime | 90 days (mobile), 12 hours (staff) | 6 |
| `CFG-7` | Trusted-device trust lifetime | 90 days | 6 |
| `CFG-8` | Maximum concurrently registered devices per account | 10 | 6 |
| `CFG-9` | Pending-verification retention before discard | 24 hours | 9 |
| `CFG-10` | Soft-deleted account retention before permanent erasure | 30 days | 9 |
| `CFG-11` | Account-claim verification failures before claim lock | 5 per 24 hours | 4 |
| `CFG-12` | Platform Support elevated-access maximum duration | 1 hour | 2, 7 |

## F. Structural facts

The following are fixed by architecture and are **not** configurable. Changing any of them requires a change to this
specification.

| Fact | Value |
|---|---|
| OTP code length | 6 numeric digits |
| OTP challenge validity | 5 minutes |
| Verification attempts per challenge | 5 |
| Challenge reuse | Single-use |
| Concurrent challenges per mobile number | 1 |
| Authentication factors in Version 1 | Mobile OTP only |
| Active libraries per session | Exactly 1 |

## G. Permanent exclusions

Authentication does not own, and this document does not specify: usernames, student profiles, memberships,
enrollment, attendance, seating, fees, library operations, notification delivery, audit storage, analytics, search,
or any business workflow. Each belongs to its own bounded context and its own PRD.
