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

| ID | Parameter | Value | Governing chapter |
|---|---|---|---|
| `CFG-1` | OTP requests per mobile number, rolling 1 hour | 5 | 8 |
| `CFG-2` | Minimum interval between OTP requests for one number | 30 seconds | 8 |
| `CFG-3` | OTP requests per source network origin, rolling 1 hour | 30 | 8 |
| `CFG-4` | Temporary lock duration after request quota exhaustion | 60 minutes | 8, 9 |
| `CFG-5` | Idle session timeout | 30 days (mobile), 12 hours (staff) | 6 |
| `CFG-6` | Absolute session lifetime | 90 days (mobile), 7 days (staff) | 6 |
| `CFG-7` | Trusted-device trust lifetime | 180 days | 6 |
| `CFG-8` | Maximum concurrently registered devices per account | 10 | 6 |
| `CFG-9` | Pending-verification retention before discard | 24 hours | 9 |
| `CFG-10` | Soft-deleted account retention before permanent erasure | 30 days | 9 |
| `CFG-11` | Account-claim verification failures before claim lock | 5 per 24 hours | 4 |
| `CFG-12` | Platform Support elevated-access maximum duration | 4 hours | 2, 7 |

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


---

# Chapter 1 — Purpose & Goals

## 1.1 Purpose

### Why Authentication exists

Liboora is a multi-tenant SaaS platform serving independent libraries and study halls. Every meaningful action on
the platform — a student checking into a seat, a parent viewing attendance, an owner reviewing revenue — requires
the platform to answer two questions before anything else happens:

1. **Who is making this request?**
2. **What is this person permitted to do in this specific library, right now?**

Authentication exists to answer both questions, and to be the **only** part of the platform that does so. Every
other module receives the answer; none of them derives it.

### The business problem it solves

Without a single identity authority, a multi-tenant platform fragments in three predictable ways:

| Problem | Consequence |
|---|---|
| **Identity duplication** | A student attending two libraries would hold two unrelated logins, two credentials, two histories. The platform could never present a coherent view of one person, and the user experiences Liboora as two unrelated products |
| **Inconsistent access control** | If each module decides its own permissions, security becomes the weakest module's decision. A defect in one feature becomes a platform-wide breach |
| **Tenant leakage** | Without a single authority establishing which library a request belongs to, data from one library can surface in another — the failure a multi-tenant platform cannot survive commercially |

Authentication solves all three by establishing **one global identity per verified mobile number**, **one place
where access decisions are made**, and **one mechanism that binds every request to exactly one library**.

`AUTH-1.1` — Authentication **MUST** be the sole authority for identity verification, role assignment, access
decisions, session lifecycle and device trust across the entire platform.

`AUTH-1.2` — No other bounded context **MAY** store, derive or infer a credential, an authentication factor, a
session, or an access decision.

### Responsibilities Authentication owns

| Responsibility | Meaning |
|---|---|
| **Identity establishment** | Creating and maintaining the global account that represents one real person |
| **Identity verification** | Proving that the person presenting an identity controls it |
| **Account lifecycle** | Every state an account may hold, and every permitted transition between states |
| **Account claim** | Binding a library's pre-existing record of a person to that person's verified global account, without duplicating identity |
| **Role assignment** | Recording which roles an account holds, in which library |
| **Authorization** | Deciding whether a specific action is permitted, in a specific library, by a specific role |
| **Session lifecycle** | Creating, validating, renewing, expiring and revoking sessions |
| **Device trust** | Recording which devices an account uses and which are trusted |
| **Tenant context** | Establishing and switching the single active library that scopes every request |
| **Authentication security** | Protecting the above against interception, brute force, replay, escalation and cross-tenant access |
| **Event emission** | Publishing authentication events for other contexts to consume |

### Responsibilities Authentication explicitly does NOT own

This list is normative. Anything on it is out of scope even when it appears adjacent.

| Not owned | Owner |
|---|---|
| **Username** | Global Student Identity |
| **Student profile** — name beyond the account display name, class, photograph, guardian details, academic data | Student Management |
| **Membership** — plans, validity, renewal, expiry, fees | Membership Management |
| **Enrollment and parent–child linking** | Enrollment |
| **Library records** — branches, seats, timings, staff rosters, operational configuration | Library Management |
| **Attendance, seating, fees, library policy** | Their respective contexts |
| **Notification delivery** — SMS, email, push, in-app, including OTP message transport | Notification |
| **Audit storage and retention** | Audit Trail |
| **Analytics, reporting, dashboards** | Analytics and the presentation layer |
| **Invitations** — links, QR codes, library invitation codes | Library Management / Tenant Organization |
| **Business workflows of any kind** | The owning domain context |

`AUTH-1.3` — Authentication **MUST NOT** implement, duplicate or approximate any responsibility in the table
above. Where Authentication needs such information, it **MUST** obtain it from the owning context.

`AUTH-1.4` — A membership is **not** an authentication concept. Authentication records that an account holds a
role in a library; whether the underlying membership is paid, current or expired is determined by Membership
Management and consumed by Authentication as an input to authorization, never decided by it.

---

## 1.2 Product Vision

**Authentication is the platform's front door: invisible when it works, absolute when it must refuse.**

Liboora's users are students, parents and small-business staff in Indian libraries and study halls. Many are
first-time users of any SaaS product. The platform earns adoption by asking for as little as possible — a mobile
number and a name — and never asking again.

The long-term vision has four commitments:

**One person, one identity, for life on the platform.** A student who joins a second library, later becomes a
staff member, and eventually opens a library of their own remains the same account throughout. Identity accretes
roles; it is never re-created.

**Security that does not become friction.** Every additional prompt costs adoption. Authentication achieves
enterprise-grade protection primarily through mechanisms the user never sees — challenge design, rate limiting,
session hygiene, device trust — reserving visible friction for genuinely elevated risk.

**Tenant isolation as an absolute.** A library owner's trust in Liboora rests on the certainty that no other
library can see their data. Isolation is enforced structurally, so that violating it requires deliberate
circumvention rather than a forgotten check.

**Extensible without disruption.** Mobile OTP is the only method in Version 1. The design admits additional
methods later — email, federated sign-in, passkeys, enterprise SSO — as **additional ways to prove control of an
existing identity**, never as parallel identity systems. Adding a method must never fork the account model.

---

## 1.3 Objectives

Each objective is measurable and attributable to Authentication alone.

| ID | Objective | Measure |
|---|---|---|
| `OBJ-1` | **Frictionless first access** | A new user completes registration and reaches an authenticated state in a single uninterrupted sequence requiring only a name, a mobile number and one code |
| `OBJ-2` | **Single global identity** | Exactly one account exists per verified mobile number, platform-wide, with no duplicate-identity path |
| `OBJ-3` | **Multi-library membership without multi-login** | A user belonging to any number of libraries authenticates once and switches libraries without re-authenticating |
| `OBJ-4` | **Correct authorization** | Every access decision is derived from the account's roles in the active library only; no decision depends on roles held elsewhere |
| `OBJ-5` | **Absolute tenant isolation** | No authenticated request resolves data belonging to a library other than the active one |
| `OBJ-6` | **Immediate, global revocation** | Withdrawal of access takes effect on every device within the revocation window, with no dependence on session expiry |
| `OBJ-7` | **Resistance to identity enumeration** | Observable behaviour is identical for registered and unregistered mobile numbers up to the point of successful verification |
| `OBJ-8` | **Non-duplicating account claim** | A person already recorded by a library links to their global account without a second identity being created |
| `OBJ-9` | **Complete authentication event record** | Every security-significant authentication occurrence is emitted as an event for audit and downstream consumption |
| `OBJ-10` | **Extensibility without migration** | A future authentication method can be added without altering the account model, the role model or the session model |

---

## 1.4 Scope

### In Scope

Authentication owns the following, completely:

**Identity**
- The global account and its identifier
- The binding between an account and exactly one verified mobile number
- The account display name, as the minimum profile datum required to create an account
- Account state and every permitted state transition
- Account claim against a library's pre-existing record of a person
- Mobile number change, including its security consequences

**Verification**
- Mobile OTP as the sole Version 1 authentication method
- Challenge issuance, validity, attempt limits and single use
- Uniform observable behaviour regardless of registration status
- The definition of what constitutes successful verification

**Authorization**
- Platform roles and tenant roles, and the separation between them
- The permission model and the closed permission catalogue
- Access policy evaluation, precedence and conflict resolution
- Role assignment and revocation authority
- Temporary and time-bounded elevated access

**Sessions and devices**
- Session creation, validation, renewal, expiry, termination and revocation
- Idle and absolute session limits
- Global sign-out across all devices
- Device registration, naming, listing, trust, trust expiry and removal
- Concurrent session and device limits

**Tenant context**
- Library selection following authentication
- Establishment of exactly one active library per session
- Library switching within an authenticated session
- Behaviour when an account holds no library role

**Security and privacy of the above**
- Rate limiting of authentication operations
- Brute force, replay and session-hijacking protection
- Privilege escalation and role spoofing prevention
- Protection and minimisation of authentication data, including mobile numbers
- Consent recording where authentication requires it

**Events**
- Emission of every authentication domain event, with defined producers and consumers

### Out of Scope

The following are **not** Authentication's responsibility and are specified elsewhere:

| Excluded | Owning PRD |
|---|---|
| Username selection, uniqueness, display and change | Global Student Identity |
| Student profile data of every kind | Student Management |
| Membership plans, pricing, validity, renewal, expiry | Membership Management |
| Enrollment, admission, parent–child relationships | Enrollment |
| Library creation, branches, seats, timings, operational settings | Library Management |
| Invitation links, QR codes and library invitation codes | Library Management / Tenant Organization |
| Attendance, seat allocation, fee ledgers, library policy | Their respective contexts |
| Composition and delivery of any message, including the OTP message | Notification |
| Storage, indexing and retention of audit records | Audit Trail |
| Reporting, dashboards, metrics presentation | Analytics and presentation layer |
| Payment, billing, subscription of libraries to Liboora | Platform Billing |
| Content, catalogue and study material | Their respective contexts |

`AUTH-1.5` — Authentication **MUST** treat the boundary above as fixed. A requirement that cannot be satisfied
without crossing it **MUST** be raised as a cross-context dependency and **MUST NOT** be absorbed into
Authentication.

---

## 1.5 Success Metrics

Metrics are grouped by what they protect. Each is attributable to Authentication and measurable without reference
to another module's behaviour.

### Adoption and experience

| ID | Metric | Target |
|---|---|---|
| `KPI-1` | First-attempt registration completion rate | ≥ 90% of started registrations reach an authenticated state |
| `KPI-2` | Median time from registration start to authenticated state | ≤ 60 seconds, excluding message transport latency |
| `KPI-3` | Repeat authentication rate on a trusted device | ≤ 1 interactive authentication per account per 30 days |
| `KPI-4` | Library switch success rate for multi-library accounts | ≥ 99.9%, with no re-authentication |
| `KPI-5` | Account claim success rate for eligible records | ≥ 95% at first attempt |

### Correctness and security

| ID | Metric | Target |
|---|---|---|
| `KPI-6` | Cross-tenant data exposure incidents | **Zero.** Any occurrence is a Severity 1 incident |
| `KPI-7` | Duplicate accounts per verified mobile number | **Zero** |
| `KPI-8` | Successful authorization of an action the active role does not permit | **Zero** |
| `KPI-9` | Median elapsed time from revocation to effective denial on all devices | ≤ 60 seconds |
| `KPI-10` | Measurable difference in observable behaviour between registered and unregistered numbers before successful verification | **None detectable** |
| `KPI-11` | Authentication events emitted for security-significant occurrences | 100% |

### Operational

| ID | Metric | Target |
|---|---|---|
| `KPI-12` | Authentication service availability | ≥ 99.9% monthly |
| `KPI-13` | Authorization decision latency, 95th percentile | ≤ 50 ms |
| `KPI-14` | Session validation latency, 95th percentile | ≤ 30 ms |
| `KPI-15` | OTP request volume rejected as abusive | Reported monthly; sustained increase triggers review |

---

## 1.6 Guiding Principles

Every Authentication feature, present and future, **MUST** satisfy all of the following. A feature that cannot is
rejected, not excepted.

| ID | Principle | Obligation |
|---|---|---|
| `GP-1` | **Authentication precedes authorization** | Identity is established before any permission is evaluated. The two are distinct stages and **MUST NOT** be merged |
| `GP-2` | **One identity, many roles** | An account is global and singular. Roles are tenant-scoped and plural. Never create a second identity to represent a second role |
| `GP-3` | **Deny by default** | Absence of an explicit grant is a denial. No implicit permission is derived from role name, seniority or context |
| `GP-4` | **Least privilege** | Every role receives the minimum permissions required for its function, and no permission is granted in anticipation of future need |
| `GP-5` | **Tenant isolation is structural** | Every authenticated operation carries exactly one active library. Isolation is enforced by construction, not by remembering to filter |
| `GP-6` | **Uniform observable behaviour** | The platform's response **MUST NOT** reveal whether an identity exists, until the requester has proven control of it |
| `GP-7` | **Verified ownership** | An identity is bound only to a factor whose control has been demonstrated. Assertion is never sufficient |
| `GP-8` | **No shared credentials** | Every account represents exactly one natural person. Shared, generic, service, demo and guest accounts are prohibited |
| `GP-9` | **Revocation is immediate and global** | Withdrawal of access takes effect everywhere, without waiting for expiry |
| `GP-10` | **Minimum data** | Authentication collects only what verification and access control require, retains it only as long as required, and exposes it only where required |
| `GP-11` | **Every decision is attributable** | Every security-significant occurrence is emitted as an event identifying actor, tenant and outcome |
| `GP-12` | **Extension, not fork** | A new authentication method is an additional proof of control over an existing identity, never a parallel identity system |
| `GP-13` | **Own only identity** | Where a requirement belongs to another context, Authentication depends on it — it does not implement it |
| `GP-14` | **Fail closed** | When a component required for an access decision is unavailable, the decision is denial |

---

## 1.7 Assumptions

| ID | Assumption | Consequence if false |
|---|---|---|
| `AS-1` | Every user possesses a mobile number capable of receiving messages, and controls it personally | Users without one cannot be authenticated in Version 1; an alternative method must be brought forward from the roadmap |
| `AS-2` | A mobile number identifies exactly one natural person at a given time | Shared numbers within a family break the one-account-one-person principle; parent and child require distinct numbers |
| `AS-3` | Mobile numbers may be **recycled** by carriers and reassigned to a different person | Number change and dormant-account handling must assume a number can change owner; addressed in Chapter 9 |
| `AS-4` | A separate Notification capability delivers the OTP message reliably | Authentication cannot guarantee delivery and must not be measured on transport failures |
| `AS-5` | Libraries are independent tenants with no shared operational data | Any cross-library data requirement is a new architectural decision, not an authentication feature |
| `AS-6` | Library records of students may exist **before** those students hold accounts | Account claim (Chapter 4) is required; without this assumption it would be unnecessary |
| `AS-7` | A single person may legitimately hold different roles in different libraries, including owner in one and student in another | Role assignment must be strictly per-tenant |
| `AS-8` | Staff act on shared premises and on devices that may be shared operationally | Staff sessions require shorter limits than personal mobile sessions |
| `AS-9` | Users operate on intermittent mobile connectivity | Session and device rules must tolerate reconnection after prolonged absence |
| `AS-10` | Platform personnel require occasional access to tenant context for support | Time-bounded, audited elevated access is required, and must never be silent or permanent |
| `AS-11` | Membership status is authoritative in Membership Management and available when authorization requires it | Authentication would otherwise have to infer entitlement, which it must not do |
| `AS-12` | Regulatory obligations applicable to Indian telecommunications and personal data apply to authentication data | Retention, consent and message-content rules follow from this |

---

## 1.8 Constraints

Constraints are binding. Unlike principles, they are not open to interpretation.

### Business constraints

| ID | Constraint |
|---|---|
| `CN-1` | Mobile OTP is the **only** authentication method in Version 1. No alternative may be offered, enabled or piloted |
| `CN-2` | No demo, guest, anonymous, sample or shared account may exist in any release build |
| `CN-3` | Registration collects only a display name and a mobile number. No additional profile field may be required to create an account |
| `CN-4` | Libraries operate independently; no library may be granted visibility of another library's accounts, roles or activity |
| `CN-5` | Platform personnel may not hold standing access to tenant data. Access is time-bounded, purpose-bound and audited |

### Technical constraints

| ID | Constraint |
|---|---|
| `CN-6` | Exactly one account exists per verified mobile number, platform-wide |
| `CN-7` | Exactly one library is active per session. Multi-library operation is achieved by switching, never by concurrency |
| `CN-8` | An account may exist with no tenant role. Account existence and library access are independent facts |
| `CN-9` | Credentials, challenges, sessions and access decisions exist only within Authentication. No other context may hold them |
| `CN-10` | Authentication must remain functional as tenants, accounts, sessions and devices scale, without per-tenant special cases |
| `CN-11` | Authorization decisions must be evaluated with a tenant in scope. A decision without a tenant is invalid, not permissive |

### Security constraints

| ID | Constraint |
|---|---|
| `CN-12` | The display name is **required and non-empty** at account creation. An empty value, the mobile number itself, a placeholder, or an automatically generated name are all prohibited |
| `CN-13` | Behaviour observable to an unauthenticated requester **MUST NOT** differ according to whether a mobile number is registered |
| `CN-14` | An authentication challenge is single-use, time-limited and attempt-limited |
| `CN-15` | Authentication must never disclose, to any party, whether a specific identity exists, except to the verified holder of that identity |
| `CN-16` | Revocation of a session, role or account takes effect globally and immediately |
| `CN-17` | No authentication factor, challenge value or session secret may appear in any event, log, metric, error message or analytics record |

### Product constraints

| ID | Constraint |
|---|---|
| `CN-18` | Authentication must be usable by first-time SaaS users with no onboarding, in a low-bandwidth environment |
| `CN-19` | A returning user on a trusted device must not be prompted for interactive authentication during normal use |
| `CN-20` | Every refusal presented to a user must be actionable, and must not disclose why a specific identity failed |
| `CN-21` | Future authentication methods are roadmap only. They must not influence Version 1 behaviour, data or user experience |


---

# Chapter 2 — User Types & Roles

## 2.1 Purpose

Authentication answers "who is this?" and "what may they do here?". This chapter defines the vocabulary for the
second question.

Two distinctions carry the entire chapter and must be understood before anything else:

**A user category is not a role.** A *category* describes what kind of person an account belongs to and how they
came to be on the platform. A *role* is a revocable grant of permissions, held in a specific library or at the
platform level. Categories are descriptive; roles are the only thing authorization actually evaluates.

**A platform role is not a tenant role.** Platform roles concern the operation of Liboora itself. Tenant roles
concern the operation of a single library. They are separate namespaces, assigned by different authorities, and
they never substitute for one another.

Without these distinctions a multi-tenant platform drifts toward a single flat permission list, where a person
who is an owner somewhere is treated as privileged everywhere. This chapter prevents that.

`AUTH-2.1` — Authorization **MUST** be evaluated exclusively from role assignments. A user category **MUST NOT**
grant any permission.

`AUTH-2.2` — Every role assignment **MUST** be scoped either to the platform or to exactly one library. An
unscoped role assignment is invalid.

---

## 2.2 User Categories

Seven categories are supported. The set is closed; introducing a category is an architectural decision, not a
configuration change.

### 2.2.1 Student

| Aspect | Definition |
|---|---|
| **Description** | A person who uses a library's facilities — seats, study space, resources. The platform's primary user population |
| **Authentication eligibility** | Eligible. Self-registers with a display name and a mobile number, or claims a record a library created for them |
| **Primary responsibilities** | Accessing their own attendance, seat bookings, membership status and library information |
| **Authentication restrictions** | May hold the Student role in any number of libraries. Cannot hold any platform role. Cannot assign roles to anyone. May act only on their own data |

### 2.2.2 Parent

| Aspect | Definition |
|---|---|
| **Description** | A person responsible for one or more students, who requires visibility of those students' library activity |
| **Authentication eligibility** | Eligible. Registers independently with their own mobile number |
| **Primary responsibilities** | Viewing the activity and status of students they are linked to |
| **Authentication restrictions** | Access extends only to students they are explicitly linked to, and only within libraries where that link is recognised. Cannot hold platform roles. Cannot act on a student's behalf beyond viewing. **A parent must hold their own account** — a shared account with the student is prohibited |

> The parent–student link itself is established by Enrollment. Authentication consumes the link when evaluating
> access; it does not create, modify or interpret it.

### 2.2.3 Library Owner

| Aspect | Definition |
|---|---|
| **Description** | The person accountable for a library on Liboora. Commercially and operationally responsible for that tenant |
| **Authentication eligibility** | Eligible. Registers as any other user; the Owner role is conferred on the library, not on the person by default |
| **Primary responsibilities** | Full operational authority within their library, including staff role assignment |
| **Authentication restrictions** | Authority is confined to the libraries they own. Confers no visibility of any other library. Cannot hold platform roles by virtue of ownership. Cannot remove the last remaining Owner of a library |

### 2.2.4 Library Manager

| Aspect | Definition |
|---|---|
| **Description** | A senior staff member responsible for day-to-day operation, delegated by an Owner |
| **Authentication eligibility** | Eligible. Assignment is invite-only; a Manager role cannot be self-selected |
| **Primary responsibilities** | Operational management within one library, including limited staff administration |
| **Authentication restrictions** | Cannot assign or revoke the Owner role. Cannot delete the library. Cannot exceed the permissions the Owner holds. Confined to the assigning library |

### 2.2.5 Reception Staff

| Aspect | Definition |
|---|---|
| **Description** | Front-desk personnel handling check-in, seat allocation and routine student interaction |
| **Authentication eligibility** | Eligible. Invite-only assignment |
| **Primary responsibilities** | Daily operational tasks at the point of service |
| **Authentication restrictions** | Explicitly excluded from financial and revenue information. Cannot assign roles. Cannot alter library configuration. Confined to the assigning library |

### 2.2.6 Platform Support

| Aspect | Definition |
|---|---|
| **Description** | Liboora personnel who assist libraries and users with operational problems |
| **Authentication eligibility** | Eligible, through the platform's internal assignment process. Never self-registered into this category |
| **Primary responsibilities** | Diagnosing and resolving user-reported issues |
| **Authentication restrictions** | **No standing access to tenant data.** Access to a library requires an explicit, time-bounded, purpose-recorded elevation. Cannot assign tenant roles. Cannot authorise their own elevation. Every action is attributed and audited |

### 2.2.7 Platform Administrator

| Aspect | Definition |
|---|---|
| **Description** | Liboora personnel accountable for platform-wide operation, tenant provisioning and platform security |
| **Authentication eligibility** | Eligible, through the platform's internal assignment process only |
| **Primary responsibilities** | Tenant lifecycle, platform configuration, platform security administration |
| **Authentication restrictions** | Administers the platform, **not the contents of tenants**. Cannot read tenant business data without the same time-bounded elevation required of Platform Support. Cannot grant themselves tenant roles. Cannot act as a tenant user |

### 2.2.8 Category summary

| Category | Self-registers | Platform role | Tenant role | Multi-library |
|---|---|---|---|---|
| Student | Yes | Never | Yes | Yes |
| Parent | Yes | Never | Yes (view-scoped) | Yes |
| Library Owner | Yes | Never | Yes | Yes |
| Library Manager | Yes, then invited | Never | Yes | Yes |
| Reception Staff | Yes, then invited | Never | Yes | Yes |
| Platform Support | No | Yes | Only by elevation | N/A |
| Platform Administrator | No | Yes | Only by elevation | N/A |

`AUTH-2.3` — A single account **MAY** correspond to more than one category simultaneously. Category is a
description of how an account is used, not an exclusive classification.

`AUTH-2.4` — Platform categories **MUST NOT** be reachable by self-registration under any circumstance.

---

## 2.3 Platform Roles

Platform roles govern Liboora itself. Two exist. The set is closed.

### `PR-1` Platform Administrator

| Aspect | Definition |
|---|---|
| **Purpose** | Operate and secure the platform: provision and suspend tenants, manage platform configuration, administer platform-level security |
| **Scope** | Platform-wide, for **platform-level objects only** — tenants as entities, platform configuration, platform role assignments |
| **Limitations** | Confers **no** access to tenant business data. Cannot self-assign tenant roles. Cannot impersonate a tenant user. Cannot alter or delete audit records. Cannot approve their own elevation request |
| **Security considerations** | The highest-privilege role on the platform and the primary target for compromise. Requires the strictest session limits, complete action attribution, and separation of duties from Platform Support. Assignment and revocation are themselves auditable security events |

### `PR-2` Platform Support

| Aspect | Definition |
|---|---|
| **Purpose** | Resolve user- and library-reported problems |
| **Scope** | Platform-wide **read** access to non-sensitive operational metadata; access to a specific tenant only through time-bounded elevation |
| **Limitations** | No standing tenant access. Cannot assign any role, platform or tenant. Cannot modify tenant business data outside an approved elevation. Cannot extend their own elevation. Cannot access authentication factors or session secrets under any circumstance |
| **Security considerations** | The role most frequently exercised against live tenant data, therefore the greatest insider risk. Every elevation records requester, approver, tenant, purpose and expiry, and terminates automatically at `CFG-12` (4 hours) |

`AUTH-2.5` — Platform roles **MUST NOT** grant access to tenant business data. Such access is obtained only
through explicit elevation, and only for the elevation's duration.

`AUTH-2.6` — Platform role assignment **MUST** be performed exclusively by a Platform Administrator other than
the subject. Self-assignment and self-elevation are prohibited.

`AUTH-2.7` — Every platform role assignment, revocation and elevation **MUST** emit an authentication event.

---

## 2.4 Tenant (Library) Roles

Tenant roles govern one library. Every assignment names exactly one library and has no meaning outside it.

### `TR-1` Owner

| Aspect | Definition |
|---|---|
| **Permissions overview** | Complete operational authority within the library: configuration, staff role assignment and revocation, financial and revenue visibility, member administration, library closure |
| **Ownership** | Conferred at library creation. Subsequently assignable only by an existing Owner of that library |
| **Restrictions** | Confined to the library. Cannot view or affect any other library. Cannot grant permissions the role model does not define. **The last remaining Owner cannot be removed or self-demote**; ownership must first be transferred |

### `TR-2` Manager

| Aspect | Definition |
|---|---|
| **Permissions overview** | Day-to-day operational management: member administration, attendance and seating oversight, operational reporting, assignment of Reception Staff |
| **Ownership** | Assigned and revoked by an Owner of the library |
| **Restrictions** | Cannot assign, revoke or transfer the Owner role. Cannot delete or close the library. Cannot alter library-level commercial configuration. Cannot exceed Owner permissions. Confined to the assigning library |

### `TR-3` Reception

| Aspect | Definition |
|---|---|
| **Permissions overview** | Point-of-service operations: student check-in and check-out, seat allocation, viewing member status necessary to serve a person at the desk |
| **Ownership** | Assigned and revoked by an Owner or a Manager of the library |
| **Restrictions** | **Explicitly denied revenue and financial data.** Cannot assign any role. Cannot alter library configuration. Cannot administer members beyond operational status. Confined to the assigning library |

### `TR-4` Student

| Aspect | Definition |
|---|---|
| **Permissions overview** | Access to the holder's own records within the library: attendance, seat bookings, membership status, library information |
| **Ownership** | Acquired on becoming a member of the library, or on successful claim of a library-created record |
| **Restrictions** | Reaches the holder's own data only. Cannot view any other person's data. Cannot assign roles. Cannot access operational or financial functions |

### `TR-5` Parent

| Aspect | Definition |
|---|---|
| **Permissions overview** | Read-only visibility of the activity of students the holder is explicitly linked to, within this library |
| **Ownership** | Acquired when Enrollment establishes a parent–student link recognised by the library |
| **Restrictions** | **Read-only.** Reaches only explicitly linked students, and only within this library. Confers nothing regarding students in other libraries. Cannot act on a student's behalf. Cannot assign roles |

### 2.4.1 Tenant role authority summary

| Role | May assign | May revoke | Financial visibility | Scope of data |
|---|---|---|---|---|
| `TR-1` Owner | `TR-1`, `TR-2`, `TR-3` | `TR-2`, `TR-3`, and `TR-1` while another Owner remains | Full | Entire library |
| `TR-2` Manager | `TR-3` | `TR-3` | Operational only | Entire library, excluding commercial configuration |
| `TR-3` Reception | None | None | **None** | Operational data required at the desk |
| `TR-4` Student | None | None | Own dues only | Own records |
| `TR-5` Parent | None | None | Linked students' dues only | Linked students' records, read-only |

`AUTH-2.8` — Tenant roles **MUST NOT** be inherited across libraries. Holding a role in one library confers
nothing in another.

`AUTH-2.9` — No tenant role, including Owner, **MAY** confer any platform-level permission.

`AUTH-2.10` — A library **MUST** retain at least one account holding `TR-1` Owner at all times.

---

## 2.5 Multi-Library Role Assignment

### One account, many libraries

An account is global; role assignments are tenant-scoped. A single verified mobile number yields one account,
which may hold roles in any number of libraries.

Consider one person who studies at Library A, works the reception desk at Library B, and owns Library C. That is
**one account with three independent tenant role assignments** — not three accounts, and not one privileged
account.

| Library | Role held | What the account may do there |
|---|---|---|
| Library A | `TR-4` Student | View only their own attendance and bookings |
| Library B | `TR-3` Reception | Operate the desk; **no** revenue visibility |
| Library C | `TR-1` Owner | Full operational authority, including revenue |

### Independence of permissions

`AUTH-2.11` — Every access decision **MUST** be evaluated using only the roles the account holds **in the active
library**. Roles held elsewhere **MUST NOT** influence the decision in any way.

The consequence is deliberate and absolute: while operating in Library A, the account above is a student and
nothing more. Ownership of Library C grants it no additional visibility in Library A, not even indirectly.

### Tenant isolation

`AUTH-2.12` — Exactly one library **MUST** be active at any moment within a session. Simultaneous multi-library
operation is not supported.

`AUTH-2.13` — Switching the active library **MUST** discard the prior authorization context in full and rebuild
it from the new library's role assignments.

`AUTH-2.14` — An account holding roles in several libraries **MUST NOT** be able to observe, from within one
library, that it holds roles in any other.

### Absence of any role

`AUTH-2.15` — An account **MAY** exist while holding no tenant role in any library. This is a valid, expected
state — it is the state of every newly created account.

`AUTH-2.16` — An account holding no role in a library **MUST** be treated in that library exactly as an account
that does not exist: no data, no presence, no acknowledgement.

---

## 2.6 Role Assignment Rules

### Who may assign

| Role to assign | Authorised assigner |
|---|---|
| `PR-1` Platform Administrator | An existing Platform Administrator, other than the subject |
| `PR-2` Platform Support | A Platform Administrator |
| `TR-1` Owner | An existing Owner of that library |
| `TR-2` Manager | An Owner of that library |
| `TR-3` Reception | An Owner or Manager of that library |
| `TR-4` Student | Conferred on library membership, or on successful account claim |
| `TR-5` Parent | Conferred when Enrollment establishes a recognised parent–student link |

### Who may revoke

`AUTH-2.17` — Authority to revoke a role **MUST** be identical to the authority to assign it, with one addition:
a holder **MAY** always relinquish their own role, subject to `AUTH-2.10`.

`AUTH-2.18` — Revocation **MUST** take effect immediately and globally, on every active session and device.

### Default roles

`AUTH-2.19` — A newly created account **MUST** hold **no role of any kind**. There is no default role, at either
scope.

`AUTH-2.20` — Role acquisition is always a distinct, explicit act following account creation.

### Invite-only roles

`AUTH-2.21` — `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `PR-1` and `PR-2` **MUST** be invite-only. No
self-service path to any of them may exist.

> Invitation mechanics — links, codes and QR — are owned by Library Management / Tenant Organization.
> Authentication records the resulting assignment and enforces who was entitled to make it.

### Restrictions on assignment

`AUTH-2.22` — No account **MAY** assign a role conferring permissions the assigner does not itself hold.

`AUTH-2.23` — No account **MAY** assign any role to itself. Every assignment involves two distinct accounts.

`AUTH-2.24` — Assignment requires the subject to hold an **active** account. Roles cannot be assigned to
suspended, locked, disabled or deleted accounts.

`AUTH-2.25` — Every assignment and revocation **MUST** emit an event identifying assigner, subject, role, scope
and time.

---

## 2.7 Authorization Principles

| Principle | Definition | Consequence |
|---|---|---|
| **Least Privilege** | Every role holds the minimum permissions its function requires | Reception has no revenue access, because desk work does not require it. Permissions are not granted in anticipation |
| **Deny by Default** | Absence of an explicit grant is refusal | A new permission is unreachable by every role until explicitly granted. Adding a feature cannot silently widen access |
| **Tenant Isolation** | Every decision is evaluated with exactly one library in scope | A decision without a tenant is **invalid**, not permissive |
| **Explicit Authorization** | Permissions are granted by name, never derived | No role obtains a permission through seniority, hierarchy or name similarity. Owner is not "everything"; it is an enumerated set |
| **Role Separation** | Platform and tenant roles are distinct namespaces | A Platform Administrator is not an Owner of any library. An Owner has no platform authority. Neither can become the other by assertion |
| **Separation of Duties** | Sensitive acts require two distinct accounts | No self-assignment, no self-elevation, no self-approval |
| **Immediate Revocation** | Withdrawal takes effect at once, everywhere | Access does not persist to the end of a session or a cache lifetime |

`AUTH-2.26` — Where two rules could both apply and produce different outcomes, the outcome **MUST** be denial.

---

## 2.8 Business Rules

| ID | Rule |
|---|---|
| `BR-2.1` | One verified mobile number yields exactly one global account, platform-wide |
| `BR-2.2` | One account may hold roles in any number of libraries |
| `BR-2.3` | Role assignments are tenant-scoped; none is inherited across libraries |
| `BR-2.4` | A new account holds no role at either scope |
| `BR-2.5` | A user category confers no permission; only roles do |
| `BR-2.6` | Platform roles never confer tenant business data access |
| `BR-2.7` | Tenant roles never confer platform authority |
| `BR-2.8` | A library must always retain at least one Owner |
| `BR-2.9` | Owner, Manager, Reception, and both platform roles are invite-only |
| `BR-2.10` | No account may assign a role to itself |
| `BR-2.11` | No account may assign permissions it does not hold |
| `BR-2.12` | Reception is denied revenue and financial data in all circumstances |
| `BR-2.13` | Parent access is read-only and limited to explicitly linked students in the current library |
| `BR-2.14` | Platform Support tenant access is time-bounded, purpose-recorded and self-terminating at `CFG-12` |
| `BR-2.15` | Elevation must be requested and approved by two distinct accounts |
| `BR-2.16` | Role revocation takes effect immediately on all sessions and devices |
| `BR-2.17` | Roles cannot be assigned to accounts that are not active |
| `BR-2.18` | An account with no role in a library is indistinguishable, within that library, from an account that does not exist |
| `BR-2.19` | Every assignment, revocation and elevation emits an authentication event |
| `BR-2.20` | Where rules conflict, access is denied |

---

## 2.9 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-2.1` | **Owner in one library, Student in another** | Fully supported by one account. In the student library the account holds `TR-4` only; ownership elsewhere has no effect there, and is not observable there |
| `XC-2.2` | **Account holds roles in many libraries** | Authentication succeeds once. Library selection follows. Exactly one library becomes active; permissions derive solely from it |
| `XC-2.3` | **Account removed from one library** | That library's role assignment ends immediately. The account, its other library roles, and its sessions elsewhere are unaffected. If the removed library was active, the session's tenant context is cleared and reselection is required |
| `XC-2.4` | **Removal from the only library** | The account continues to exist holding no role — the same state as a newly created account. It is not deleted, suspended or degraded |
| `XC-2.5` | **Platform Support requires tenant access** | Requires an elevation request stating tenant and purpose, approved by a distinct Platform Administrator, expiring automatically at `CFG-12`. All actions attributed. No standing access is created |
| `XC-2.6` | **Elevation expires mid-operation** | Access ends at expiry. The in-flight operation is refused at the next decision point. No grace period, no automatic renewal |
| `XC-2.7` | **Suspended account holding roles** | Role assignments are retained but unusable. Every access decision denies while suspended. Reinstatement restores the prior assignments unchanged |
| `XC-2.8` | **Deleted account holding roles** | All assignments, platform and tenant, are revoked at deletion. If the account was a library's last Owner, deletion is refused until ownership is transferred |
| `XC-2.9` | **Sole Owner attempts to leave** | Refused. The refusal states that ownership must be transferred first. `AUTH-2.10` holds without exception |
| `XC-2.10` | **Role revoked during an active session** | The next access decision denies. The session itself remains valid — the account is still authenticated, but no longer authorised. Authentication and authorization fail independently |
| `XC-2.11` | **Manager attempts to assign Owner** | Refused. A Manager cannot assign a role exceeding its own permissions |
| `XC-2.12` | **Same person, two mobile numbers** | Two distinct accounts, by definition. The platform does not merge accounts. Consolidation is achieved by claiming under one number and relinquishing the other |
| `XC-2.13` | **Parent and student share one mobile number** | Prohibited. One account represents one person. The parent must use a distinct number |
| `XC-2.14` | **Platform Administrator attempts to self-assign a tenant role** | Refused. Prohibited by `AUTH-2.23` and by role separation |
| `XC-2.15` | **Library suspended while a user is active in it** | Every access decision in that library denies. Roles are retained for reinstatement. The account's access to other libraries is unaffected |
| `XC-2.16` | **Account holds Manager and Student in the same library** | Permitted. Effective permissions are the union of the two roles, subject to explicit denials — which are never overridden by union |

---

## 2.10 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-2.1` | One verified mobile number yields exactly one account; a second registration attempt with the same number never produces a second account |
| `AC-2.2` | A newly created account holds zero roles at both scopes, verified immediately after creation |
| `AC-2.3` | An account holding a role in Library A and none in Library B receives, in Library B, responses identical to an account that does not exist |
| `AC-2.4` | An account holding Owner in Library C and Student in Library A can perform no owner-level action while Library A is active |
| `AC-2.5` | Switching the active library changes effective permissions to exactly the new library's assignments, with no residue from the previous context |
| `AC-2.6` | A `TR-3` Reception holder is denied every revenue and financial permission, in every library, under every combination of other roles held elsewhere |
| `AC-2.7` | An attempt to remove a library's last Owner is refused, and the library retains an Owner |
| `AC-2.8` | A Manager's attempt to assign the Owner role is refused |
| `AC-2.9` | A self-assignment attempt is refused for every role at both scopes |
| `AC-2.10` | A Platform Administrator receives no tenant business data without an active, approved elevation |
| `AC-2.11` | A Platform Support elevation expires automatically at `CFG-12`; the first decision after expiry is a denial |
| `AC-2.12` | An elevation approved by the requesting account is refused |
| `AC-2.13` | Role revocation denies the next access decision on every active session within the revocation window |
| `AC-2.14` | Role assignment to a suspended, locked, disabled or deleted account is refused |
| `AC-2.15` | Every assignment, revocation and elevation emits exactly one event carrying assigner, subject, role, scope and time |
| `AC-2.16` | No authorization decision is reachable without a tenant in scope; a tenant-less decision is refused rather than allowed |
| `AC-2.17` | A `TR-5` Parent can read only explicitly linked students, only in the active library, and can perform no write action |
| `AC-2.18` | A suspended account holding roles is denied every access decision, and reinstatement restores the identical set of assignments |
| `AC-2.19` | The set of user categories and the set of roles are each closed; no undeclared category or role is reachable at runtime |
| `AC-2.20` | Where two applicable rules disagree, the observed outcome is denial |


---

# Chapter 3 — Authentication Methods

## 3.1 Purpose

An authentication method is the means by which a person proves they control an identity. This chapter defines
which methods Liboora supports, which it deliberately does not, and the rules governing how methods may be added
in future without disturbing what exists.

The chapter is concerned with **proof of control only**. What happens once control is proven — registration,
login, session issuance, library selection — belongs to later chapters and is not specified here.

Liboora supports exactly one method in Version 1: **Mobile Number + OTP**. This is a deliberate product decision,
not a temporary limitation awaiting completion.

`AUTH-3.1` — Mobile Number + OTP **MUST** be the only authentication method available in Version 1.

`AUTH-3.2` — Every account **MUST** be bound to exactly one verified mobile number, and every verified mobile
number **MUST** correspond to exactly one account.

---

## 3.2 Design Principles

| ID | Principle | Application |
|---|---|---|
| `MP-1` | **Simplicity** | The user supplies a number and a code. Nothing to remember, nothing to reset, nothing to lose. Password recovery — historically the largest source of authentication support burden — does not exist because passwords do not exist |
| `MP-2` | **Security** | The factor is possession of a mobile number, verified at each interactive authentication. Security derives from challenge design and rate limiting, not from user diligence |
| `MP-3` | **Scalability** | The method carries no per-user secret storage and no credential recovery workflow, so its cost per account approaches zero as the platform grows |
| `MP-4` | **Future extensibility** | Methods are proofs of control over an identity, not identities themselves. The account model is method-independent, so a method may be added without migrating any account |
| `MP-5` | **Mobile-first** | The target population is mobile-only. The method requires nothing beyond the device the user already holds — no email account, no password manager, no second device |
| `MP-6` | **Uniformity** | The method behaves identically regardless of whether the number is registered. Method behaviour never becomes an identity oracle |
| `MP-7` | **Single source of proof** | Exactly one method is authoritative per authentication event. Methods are never combined to reach a partial or blended confidence |

---

## 3.3 Supported Authentication Methods (V1)

### 3.3.1 Mobile Number + OTP

**Description**

The user presents a mobile number. The platform issues a one-time numeric code to that number through the
Notification capability. The user returns the code. Correct return of an unexpired, unused code within the
permitted number of attempts constitutes proof of control over the number, and therefore authentication of the
identity bound to it.

**Business purpose**

| Driver | Rationale |
|---|---|
| **Population fit** | Every target user has a mobile number; a substantial proportion have no email address and no experience of password managers |
| **Zero-friction onboarding** | Registration requires a name and a number. Nothing must be created, remembered or recovered |
| **Trusted identifier** | The mobile number is already the identifier libraries use for their students, which makes account claim natural |
| **Support cost** | Eliminates password reset, the dominant support category in credential-based systems |
| **Regulatory alignment** | Message delivery operates within the Indian telecommunications framework applicable to transactional messaging |

**Eligibility**

`AUTH-3.3` — Any person controlling a mobile number capable of receiving messages is eligible.

`AUTH-3.4` — Eligibility **MUST NOT** depend on prior registration, on membership of any library, or on any role.

**Ownership**

| Concern | Owner |
|---|---|
| Challenge generation, validity, attempt limits, single use, verification | **Authentication** |
| Composition and delivery of the message carrying the code | **Notification** |
| Storage of the number as an authentication identifier | **Authentication** |
| Any other use of the number, including operational contact | The context requiring it, under its own rules |

`AUTH-3.5` — Authentication **MUST NOT** implement message transport. It **MUST** request delivery from
Notification and **MUST NOT** depend on the outcome of delivery to decide the result of verification.

**Security objectives**

| Objective | Requirement |
|---|---|
| Unpredictability | `AUTH-3.6` — Codes **MUST** be generated so that observing any number of prior codes yields no advantage in predicting another |
| Non-correlation | `AUTH-3.7` — A code **MUST NOT** be derived from the mobile number, the account, the time, or any other observable input |
| Time limitation | `AUTH-3.8` — A challenge **MUST** expire **5 minutes** after issuance |
| Attempt limitation | `AUTH-3.9` — A challenge **MUST** permit at most **5** verification attempts, after which it is destroyed |
| Single use | `AUTH-3.10` — A challenge **MUST** be destroyed on first successful verification and **MUST NOT** be reusable |
| Uniform behaviour | `AUTH-3.11` — Issuance behaviour **MUST** be identical for registered and unregistered numbers: same response, same shape, same timing characteristics, same absence of any indication that an identity exists |
| Non-disclosure | `AUTH-3.12` — The code **MUST NOT** appear in any response, event, log, metric, error or analytics record. It exists only in the challenge record and the delivered message |

**Structural parameters**

Fixed by architecture. Not configurable, and not subject to per-tenant variation.

| Parameter | Value |
|---|---|
| Code length | 6 digits |
| Code alphabet | Numeric only |
| Challenge validity | 5 minutes |
| Verification attempts per challenge | 5 |
| Concurrent valid challenges per number | 1 — issuing a new challenge invalidates the previous |
| Reusability | None; single use |

> The numeric-only alphabet is required for compatibility with the registered-template messaging regime and for
> reliable entry on numeric keypads.

**Limitations**

These are acknowledged properties of the method, not defects. Chapter 8 defines the compensating controls.

| Limitation | Consequence | Compensation |
|---|---|---|
| Dependence on message delivery | Authentication is unavailable to a user if delivery fails | Availability is measured separately from correctness; delivery is not Authentication's obligation |
| Susceptibility to SIM swap | Control of the number may transfer to an attacker | Device trust, revocation on number change, event emission for detection |
| Susceptibility to device-level interception | A compromised device may expose the code | Short validity, single use, attempt limits |
| Number recycling | A number may later belong to a different person | Dormant-account handling and number-change rules in Chapter 9 |
| Single factor | Possession alone; no second factor in V1 | Rate limiting, trusted-device management, immediate revocation, event-driven detection |
| No offline authentication | Interactive authentication requires connectivity | Long-lived sessions on trusted devices reduce interactive frequency |

---

## 3.4 Unsupported Authentication Methods

The following are **not available in Version 1**. Each is unavailable by decision, and none may be enabled by
configuration, feature flag, environment, tenant setting or administrative action.

| Method | Not available because |
|---|---|
| **Email login** | The target population's email coverage is materially lower than mobile coverage; email would serve a minority while adding a second identifier, a second verification path and a second recovery surface |
| **Password login** | Introduces a stored secret, a reset workflow, reuse risk across sites, and the platform's largest prospective support cost — for no gain over possession of the mobile number |
| **Google Sign-In** | Adds an external identity provider dependency and a second account-linking model, for a population with inconsistent Google account usage |
| **Apple Sign-In** | Negligible iOS share in the target market; would create a platform-specific identity path |
| **Passkeys** | Requires device and browser capability not uniformly present in the target device population, and a fallback method — which would reintroduce the complexity being avoided |
| **Biometric login** | Device-local convenience, not an authentication factor the platform can verify. Device unlock does not prove control of the identity to Liboora |
| **Social login (any provider)** | Third-party identity dependency, inconsistent data quality, privacy exposure, and no benefit over the mobile number the library already holds |

`AUTH-3.13` — No unsupported method **MAY** be present in a release build in any form — enabled, disabled,
hidden, partially implemented or reachable by configuration.

`AUTH-3.14` — A request to authenticate by an unsupported method **MUST** be refused with a response that
discloses nothing about roadmap, configuration or account state.

---

## 3.5 Authentication Method Selection Rules

**Default method**

`AUTH-3.15` — Mobile Number + OTP is the default and, in Version 1, the only method. No selection interface is
presented, because no choice exists.

**One primary method**

`AUTH-3.16` — Every account **MUST** have exactly one primary authentication method at any time. In Version 1
this is Mobile Number + OTP for every account, without exception.

`AUTH-3.17` — An account **MUST NOT** hold two methods that independently authenticate it in Version 1.

**Method consistency**

`AUTH-3.18` — The method **MUST** behave identically for every account, in every library, for every role. No
category, role, tenant, region or device may alter method behaviour.

`AUTH-3.19` — No tenant **MAY** configure, restrict, extend or substitute the authentication method for its
users. The method is a platform property, never a tenant setting.

**Future extensibility**

`AUTH-3.20` — A future method **MUST** be introduced as an **additional proof of control over an existing
account**, never as a parallel identity.

`AUTH-3.21` — Introducing a method **MUST NOT** require any change to the account model, the role model, the
session model or existing accounts.

`AUTH-3.22` — Every account **MUST** retain a verified mobile number as its identity anchor, irrespective of any
additional method added later.

---

## 3.6 Security Principles

High-level principles governing methods. Operational security controls are specified in Chapter 8.

| ID | Principle | Requirement |
|---|---|---|
| `SP-1` | **Verified ownership** | `AUTH-3.23` — An identity **MUST** be bound only to a factor whose control has been demonstrated through successful verification. Assertion of a number never suffices |
| `SP-2` | **Secure verification** | `AUTH-3.24` — Verification **MUST** be resistant to guessing, replay and interception through unpredictability, time limitation, attempt limitation and single use |
| `SP-3` | **No shared credentials** | `AUTH-3.25` — One account represents exactly one natural person. Shared, generic, service, demo, sample and guest accounts are prohibited in every release build |
| `SP-4` | **Authentication before authorization** | `AUTH-3.26` — No permission **MAY** be evaluated before authentication completes. The stages are separate and ordered |
| `SP-5` | **Least privilege** | `AUTH-3.27` — Successful authentication **MUST** confer identity only. It **MUST NOT** confer any permission, role or tenant access |
| `SP-6` | **Non-disclosure** | `AUTH-3.28` — No method behaviour **MAY** reveal whether an identity exists, prior to that identity's holder proving control |
| `SP-7` | **Factor isolation** | `AUTH-3.29` — Authentication factors and challenge values **MUST** exist only within Authentication and **MUST NOT** be transmitted to, stored by, or derivable from any other context |

---

## 3.7 Business Rules

| ID | Rule |
|---|---|
| `BR-3.1` | Mobile Number + OTP is the sole authentication method in Version 1 |
| `BR-3.2` | One verified mobile number corresponds to exactly one account, platform-wide |
| `BR-3.3` | One account is bound to exactly one verified mobile number |
| `BR-3.4` | An OTP code is 6 numeric digits |
| `BR-3.5` | A challenge is valid for 5 minutes from issuance |
| `BR-3.6` | A challenge permits at most 5 verification attempts, then is destroyed |
| `BR-3.7` | A challenge is single-use and is destroyed on successful verification |
| `BR-3.8` | Issuing a new challenge for a number invalidates any previous challenge for that number |
| `BR-3.9` | Challenge issuance behaves identically for registered and unregistered numbers |
| `BR-3.10` | A code is never disclosed in any response, event, log, metric, error or analytics record |
| `BR-3.11` | Authentication requests message delivery from Notification and never performs delivery itself |
| `BR-3.12` | Verification outcome is independent of message delivery outcome |
| `BR-3.13` | No unsupported method is present or reachable in a release build |
| `BR-3.14` | The method is uniform across all accounts, roles, libraries and regions |
| `BR-3.15` | No tenant may configure, restrict or substitute the authentication method |
| `BR-3.16` | Successful authentication confers identity only, never permissions |
| `BR-3.17` | Every account retains a verified mobile number as its identity anchor permanently |
| `BR-3.18` | Shared, generic, service, demo and guest accounts are prohibited |
| `BR-3.19` | Changing an account's mobile number requires verification of the new number and does not create a new account |
| `BR-3.20` | A future method may be added only as an additional proof of control over an existing account |

---

## 3.8 Future Roadmap

Directional only. Nothing below is designed, committed, scheduled or permitted to influence Version 1.

| Candidate | Prospective rationale |
|---|---|
| **Email OTP** | Secondary proof for users whose number changes or becomes unreachable |
| **Google Sign-In** | Reduced friction for users with established Google accounts |
| **Apple Sign-In** | Required if iOS share grows materially |
| **Passkeys** | Phishing-resistant proof as device capability becomes uniform |
| **Enterprise SSO** | Institutional customers requiring federated staff identity |
| **Second factor for elevated roles** | Additional assurance for Owner and platform roles |

`AUTH-3.30` — Roadmap items **MUST NOT** appear in Version 1 as interface elements, configuration, capability
declarations, partial implementations or user-visible statements of intent.

`AUTH-3.31` — Each future method, when introduced, **MUST** be specified in its own right and **MUST** conform to
`AUTH-3.20` through `AUTH-3.22`.

---

## 3.9 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-3.1` | **Unsupported method requested** | Refused. The response discloses nothing about roadmap, configuration or whether the identity exists. No event distinguishes the attempt from any other refused authentication |
| `XC-3.2` | **A future method exists in the codebase but is disabled** | Prohibited outright by `AUTH-3.13`. A disabled method is not compliant; it must be absent |
| `XC-3.3` | **Multiple methods introduced in future** | Exactly one remains primary per account. Additional methods prove control over the same account and never create a second identity |
| `XC-3.4` | **Mobile number changed** | The account persists; its identifier is rebound following verification of the new number. Sessions and device trust are invalidated (Chapters 6 and 9). No second account is created and no history is lost |
| `XC-3.5` | **New number already bound to another account** | The change is refused. `AUTH-3.2` admits no exception. The refusal must not confirm that the target number is registered |
| `XC-3.6` | **Challenge requested while a valid challenge exists** | The prior challenge is invalidated and a new one issued, subject to rate limits. Two valid challenges never coexist for one number |
| `XC-3.7` | **Message delivery fails** | Verification behaviour is unchanged; the challenge remains valid until expiry. The user may request another within rate limits. Authentication does not surface delivery status |
| `XC-3.8` | **Correct code entered after expiry** | Refused, identically to an incorrect code. The response does not distinguish expiry from incorrectness |
| `XC-3.9` | **Code entered after the attempt budget is exhausted** | Refused. The challenge no longer exists. A new challenge must be requested, subject to rate limits |
| `XC-3.10` | **Same code submitted twice after success** | Refused. The challenge was destroyed at first success |
| `XC-3.11` | **Verification attempted for a number with no challenge** | Refused, identically to an incorrect code, with no indication that no challenge was issued |
| `XC-3.12` | **Number valid in format but non-existent on any network** | Challenge issuance succeeds and behaves normally. Delivery fails silently. No feedback distinguishes this case, as doing so would disclose network state |
| `XC-3.13` | **Two devices request a challenge for one number simultaneously** | One challenge exists; the later issuance invalidates the earlier. Only the most recent code verifies |
| `XC-3.14` | **Number recycled to a new person who requests a challenge** | Issuance and verification proceed normally — control of the number is genuine. Chapter 9 governs whether the pre-existing account is reachable |

---

## 3.10 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-3.1` | Mobile Number + OTP is the only method reachable in a release build; no other method is present in any state |
| `AC-3.2` | A generated code is exactly 6 numeric digits |
| `AC-3.3` | Codes are unpredictable: no sequence of observed codes improves prediction of a subsequent code |
| `AC-3.4` | A code cannot be derived from the mobile number, account identifier, or issuance time |
| `AC-3.5` | A challenge submitted after 5 minutes is refused |
| `AC-3.6` | A sixth verification attempt on one challenge is refused and the challenge no longer exists |
| `AC-3.7` | A code that has verified successfully is refused on reuse |
| `AC-3.8` | Issuing a challenge for a number invalidates any prior challenge for that number |
| `AC-3.9` | Challenge issuance for a registered and an unregistered number produces responses indistinguishable in content, shape and observable timing |
| `AC-3.10` | No code value appears in any response, event, log, metric, error or analytics record |
| `AC-3.11` | Verification outcome is unaffected by message delivery success or failure |
| `AC-3.12` | An unsupported-method request is refused without disclosing roadmap, configuration or identity existence |
| `AC-3.13` | Successful verification yields identity only; no permission, role or tenant access accompanies it |
| `AC-3.14` | Exactly one account exists per verified mobile number, verified across concurrent registration attempts |
| `AC-3.15` | A mobile number change preserves the account identifier and all role assignments |
| `AC-3.16` | A number change to a number already bound elsewhere is refused without confirming that the target is registered |
| `AC-3.17` | No tenant-level configuration can alter, restrict or extend the authentication method |
| `AC-3.18` | Method behaviour is identical across all accounts, roles and libraries, verified for each role |
| `AC-3.19` | No shared, generic, service, demo or guest account exists in a release build |
| `AC-3.20` | Expired, incorrect, exhausted and absent-challenge verifications are externally indistinguishable |


---

# Chapter 4 — Registration & Account Claim

## 4.1 Purpose

This chapter defines how an identity comes into existence on Liboora, and how a person already known to a library
takes control of the record that library holds.

Two distinct paths lead to an authenticated identity:

| Path | Situation | Outcome |
|---|---|---|
| **Registration** | No account exists for the mobile number | A new global account is created |
| **Account claim** | A library recorded a person before that person held an account | The existing library record is bound to the person's verified global account |

Both paths converge on the same result: **one global account per verified mobile number**. Neither may produce a
duplicate identity, and neither may be used to bypass the other.

The distinction matters commercially. Libraries onboard students by entering them into the system, often long
before those students install anything. When such a student later registers, the platform must recognise the
existing record rather than creating a parallel one — otherwise every library would accumulate two versions of
each student, and attendance, membership and fees would fragment across them.

`AUTH-4.1` — Exactly one account **MUST** exist per verified mobile number, platform-wide, irrespective of path
taken or number of libraries involved.

`AUTH-4.2` — Neither path **MAY** create a second identity for a person already holding an account.

---

## 4.2 Registration Principles

| ID | Principle | Requirement |
|---|---|---|
| `RP-1` | **One global identity** | `AUTH-4.3` — Registration creates a **platform-level** account, not a library-level one. The account exists independently of any library and survives removal from all of them |
| `RP-2` | **Mobile number ownership** | `AUTH-4.4` — An account **MUST NOT** be created until control of the mobile number has been proven by successful verification. An unverified number never yields an account |
| `RP-3` | **No duplicate accounts** | `AUTH-4.5` — Registration with a number already bound to an account **MUST** authenticate the existing account rather than create another. There is no path to a second account for one number |
| `RP-4` | **Minimal onboarding** | `AUTH-4.6` — Registration **MUST** require exactly two inputs: a display name and a mobile number. No further datum may be required to create an account |
| `RP-5` | **Identity before entitlement** | `AUTH-4.7` — Registration creates identity only. It **MUST NOT** create a membership, confer a role, or grant access to any library |
| `RP-6` | **Future extensibility** | `AUTH-4.8` — The account created is method-independent. Adding an authentication method later **MUST NOT** require re-registration or account migration |
| `RP-7` | **Non-disclosure** | `AUTH-4.9` — Registration **MUST NOT** reveal, before successful verification, whether the number is already registered |

### 4.2.1 Why the display name is collected before verification

The account is created at the instant verification succeeds, and a display name is required at that instant. It
therefore **MUST** be collected beforehand.

`AUTH-4.10` — The registration flow **MUST** collect the display name **before** verification is attempted.

`AUTH-4.11` — The display name **MUST** be present and non-empty at account creation. Each of the following is
prohibited as a display name:

- an empty or whitespace-only value;
- the mobile number, in any format;
- a placeholder value of any kind;
- a value generated automatically by the platform.

`AUTH-4.12` — Where verification identifies an **existing** account, the collected display name **MUST** be
discarded. An existing display name is never overwritten by a subsequent registration attempt.

`AUTH-4.13` — Display name collection **MUST** be uniform: the same inputs are requested for every number,
whether registered or not. Varying the inputs by registration status would disclose identity existence and is
prohibited.

> The display name is the **only** profile datum Authentication holds. It exists solely so that an account can be
> attributed in interfaces and audit records. All other profile information belongs to Student Management, and
> the username belongs to Global Student Identity. Neither is collected here.

---

## 4.3 New Account Registration

### Eligibility

`AUTH-4.14` — Any person controlling a mobile number not currently bound to an account is eligible.

`AUTH-4.15` — Eligibility **MUST NOT** depend on any library's involvement, invitation, membership or approval.
Registration is open; **access to a library is not**.

### Prerequisites

| Prerequisite | Requirement |
|---|---|
| Display name | Collected before verification, satisfying `AUTH-4.11` |
| Mobile number | Structurally valid and capable of receiving messages |
| Verification | Successfully completed |

`AUTH-4.16` — All three **MUST** be satisfied. Absence of any one prevents account creation.

### Mobile verification requirement

`AUTH-4.17` — Account creation **MUST** occur only upon successful verification, and **MUST** be atomic with it —
there is no intermediate state in which an unverified account exists.

`AUTH-4.18` — Failed verification — incorrect code, expired challenge, exhausted attempts, or no challenge —
**MUST NOT** create an account, and **MUST NOT** leave any residue from which a future attempt could infer prior
activity.

### Global account creation

Upon successful verification of a number bound to no account, exactly one account is created, holding:

| Attribute | Value at creation |
|---|---|
| Account identifier | Newly allocated, globally unique, permanent, non-reassignable |
| Mobile number | The verified number |
| Display name | The value collected before verification |
| Account state | **Active** |
| Platform roles | **None** |
| Tenant roles | **None**, in every library |
| Library associations | **None** |

`AUTH-4.19` — The account identifier **MUST** be permanent and **MUST NOT** be reused after deletion.

`AUTH-4.20` — The account identifier **MUST NOT** be derived from, or permit derivation of, the mobile number.

### Initial account state

`AUTH-4.21` — A newly created account is **Active** and holds **no role at either scope**. This is a complete,
valid state — not a partial or pending one.

The consequences are deliberate:

- The account is authenticated but authorised for nothing.
- It is a member of no library and cannot see any library's data.
- It is indistinguishable, from within any library, from an account that does not exist.
- It obtains access only when a library assigns it a role, or when it claims an existing record.

`AUTH-4.22` — The platform **MUST** present this state as a normal outcome. It **MUST NOT** be described as an
error, a failure, or an incomplete registration.

---

## 4.4 Existing Student Account Claim

### Purpose

A library may record a student in Liboora before that student holds an account — at admission, during migration
from paper records, or when staff enrol someone at the desk. Such a record represents a real person who has no
means to access it.

**Account claim binds that record to the person's verified global account, without creating a second identity.**

### Eligibility

`AUTH-4.23` — A claim is eligible when a library holds an unclaimed student record whose recorded mobile number
matches the number the claimant has verified.

`AUTH-4.24` — A record already bound to an account **MUST NOT** be claimable. Records are claimed once.

### Preconditions

| Precondition | Requirement |
|---|---|
| Verified identity | The claimant holds an account created through successful verification |
| Record exists | The library holds a student record for the claimant's number |
| Record unclaimed | No account is currently bound to that record |
| Record eligible | The record is not deleted, archived or otherwise withdrawn |
| Library active | The library is operational and not suspended or deleted |
| Account active | The claiming account is Active |

`AUTH-4.25` — Every precondition **MUST** hold. Failure of any one refuses the claim.

### Verification requirements

`AUTH-4.26` — A claim **MUST** require successful verification of the mobile number recorded against the student
record. Control of the number is the sole basis on which a claim is granted.

`AUTH-4.27` — A claim **MUST NOT** be granted on the basis of knowledge alone — of a name, a student identifier,
a class, a membership number or any other detail. Such information is guessable, and treating it as proof would
permit impersonation.

`AUTH-4.28` — Claim attempts **MUST** be rate-limited at `CFG-11` (5 failed attempts per 24 hours per account),
after which further claim attempts by that account are refused for the remainder of the period.

### Successful claim

On success:

| Effect | Detail |
|---|---|
| Record bound | The library's student record is associated with the claiming account |
| Role conferred | The account receives the `TR-4` Student role **in that library only** |
| History preserved | Attendance, membership and fee history on the record remain intact and become visible to the account |
| Identity unchanged | The global account identifier, display name and mobile number are unaltered |
| No duplication | No second account, and no second student record, is created |
| Event emitted | A claim event is emitted for audit and downstream consumption |

`AUTH-4.29` — A successful claim **MUST NOT** alter the account's display name. The library's recorded name for
the student belongs to Student Management and does not overwrite the authentication display name.

`AUTH-4.30` — A successful claim **MUST NOT** affect the account's roles in any other library.

### Failed claim

`AUTH-4.31` — A failed claim **MUST** leave the record unclaimed, confer no role, and change no state other than
the claim attempt counter.

`AUTH-4.32` — A refusal **MUST NOT** disclose whether a matching record exists. A claim against a non-existent
record and a claim against an ineligible record **MUST** be externally indistinguishable.

> This constraint is essential. A refusal that distinguished "no such record" from "record already claimed" would
> let anyone test whether a given person attends a given library — a privacy breach committed through the
> refusal itself.

---

## 4.5 Multi-Library Account Linking

### One account, many libraries

`AUTH-4.33` — A single account **MUST** be capable of association with any number of libraries, with no platform
limit.

Each association is independent and carries its own role assignment, membership, records and history.

| Property | Behaviour |
|---|---|
| **Identity** | One account, one identifier, one mobile number, one display name — shared across all libraries |
| **Roles** | Independent per library; not inherited between them |
| **Membership** | Independent per library, owned by Membership Management |
| **Records** | Independent per library; never merged or cross-visible |
| **Claim** | Performed per library; claiming in one library confers nothing in another |

### Independent memberships and permissions

`AUTH-4.34` — Association with a library **MUST NOT** create, imply or modify association with any other.

`AUTH-4.35` — Loss of access to one library **MUST NOT** affect access to any other, and **MUST NOT** affect the
account itself.

### Tenant isolation

`AUTH-4.36` — A library **MUST NOT** be able to determine, from the account, that it is associated with any other
library.

`AUTH-4.37` — Registration and claim **MUST NOT** disclose to any library the existence, name or number of
libraries the account is associated with elsewhere.

> A library sees a person who attends it. It never sees that the same person also attends a competitor.

---

## 4.6 Registration Restrictions

| ID | Restriction | Required behaviour |
|---|---|---|
| `RS-1` | **Number already registered** | Verification authenticates the existing account. No second account is created; the collected display name is discarded. Before verification succeeds, nothing indicates that the number was already registered |
| `RS-2` | **Account suspended** | Verification may succeed, establishing identity, but the account remains suspended and no access follows. Registration **MUST NOT** be usable to circumvent suspension by creating a fresh account for the same number |
| `RS-3` | **Account locked** | As `RS-2`. The lock persists; a new challenge does not clear it |
| `RS-4` | **Account deleted, within retention** | The number remains bound to the soft-deleted account. Re-registration follows the recovery rules in Chapter 9, not the new-account path |
| `RS-5` | **Account deleted, retention elapsed** | The number is unbound. Registration proceeds as a genuinely new account, with no access to any prior data |
| `RS-6` | **Invalid claim request** | Refused without disclosing whether a matching record exists |
| `RS-7` | **Duplicate claim request** | Refused. Records are claimable once |
| `RS-8` | **Cross-library claim attempt** | A claim reaches exactly one record in one library. Records in other libraries are unaffected and must be claimed separately |
| `RS-9` | **Display name violates `AUTH-4.11`** | Account creation is refused. The refusal identifies the input problem without referring to account state |
| `RS-10` | **Structurally invalid mobile number** | Refused before challenge issuance, on format alone. No inference about registration is possible from this refusal |
| `RS-11` | **Registration during rate limiting** | Refused by the rate limiter (Chapter 8). The refusal is uniform for registered and unregistered numbers |

---

## 4.7 Business Rules

| ID | Rule |
|---|---|
| `BR-4.1` | Exactly one account exists per verified mobile number, platform-wide |
| `BR-4.2` | An account is created only on successful verification, atomically with it |
| `BR-4.3` | Registration requires exactly a display name and a mobile number |
| `BR-4.4` | The display name is collected before verification is attempted |
| `BR-4.5` | The display name must be non-empty and must not be the mobile number, a placeholder, or automatically generated |
| `BR-4.6` | An existing account's display name is never overwritten by a later registration attempt |
| `BR-4.7` | Registration input is identical for registered and unregistered numbers |
| `BR-4.8` | A newly created account is Active and holds no role at either scope |
| `BR-4.9` | Registration creates no membership and grants no library access |
| `BR-4.10` | An account with no library association is a valid, non-error state |
| `BR-4.11` | The account identifier is permanent and is never reused after deletion |
| `BR-4.12` | The account identifier does not permit derivation of the mobile number |
| `BR-4.13` | A claim requires verification of the mobile number recorded on the student record |
| `BR-4.14` | A claim is never granted on knowledge of student details alone |
| `BR-4.15` | A student record can be claimed exactly once |
| `BR-4.16` | A successful claim confers the Student role in that library only |
| `BR-4.17` | A successful claim preserves the record's existing history |
| `BR-4.18` | A successful claim does not alter the account's display name |
| `BR-4.19` | A refused claim discloses nothing about whether a matching record exists |
| `BR-4.20` | Claim attempts are limited to `CFG-11` failures per 24 hours per account |
| `BR-4.21` | One account may associate with any number of libraries, each independently |
| `BR-4.22` | No library can observe an account's association with any other library |
| `BR-4.23` | Loss of access to one library affects neither the account nor other libraries |
| `BR-4.24` | Registration cannot be used to escape suspension, locking or deletion |
| `BR-4.25` | Failed verification creates no account and leaves no inferable residue |

---

## 4.8 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-4.1` | **Number already registered** | Verification authenticates the existing account. No duplicate is created; the supplied display name is discarded. Nothing before successful verification reveals that the number was known |
| `XC-4.2` | **Student record exists without an account** | The record remains unclaimed and inert. It confers nothing until claimed. Library staff may continue to operate on it; the person simply has no access |
| `XC-4.3` | **Student recorded in multiple libraries** | One account, several claimable records. Each is claimed separately, and each confers a role only in its own library |
| `XC-4.4` | **Claim submitted with incorrect details** | Refused. The refusal is identical to one issued where no record exists |
| `XC-4.5` | **Duplicate claim on an already-claimed record** | Refused, indistinguishably from `XC-4.4`, whether or not the claimant is the account that already holds it |
| `XC-4.6` | **Student record deleted before claim** | Not claimable. Refusal is indistinguishable from a non-existent record |
| `XC-4.7` | **Library inactive or suspended** | Claims against it are refused. Existing associations are retained for reinstatement; access is denied while inactive |
| `XC-4.8` | **Membership expired on the claimed record** | The claim succeeds — claim binds identity, not entitlement. The Student role is conferred, and Membership Management governs what the expired membership permits |
| `XC-4.9` | **Two people claim the same record concurrently** | At most one succeeds. Both must have verified the same number, which implies they share it — prohibited by `AUTH-3.25`. The second attempt is refused as already claimed, disclosing nothing |
| `XC-4.10` | **Verification succeeds but account creation cannot complete** | No account exists. The challenge is consumed. The user may retry, subject to rate limits. No partial account is ever persisted |
| `XC-4.11` | **Display name supplied for an existing account** | Discarded. The stored display name is unchanged. No indication is given that it was ignored, as that would disclose registration status |
| `XC-4.12` | **Registration abandoned after the challenge is issued** | The challenge expires. No account is created. No record of the attempt is inferable by a later requester |
| `XC-4.13` | **Number recycled to a new person** | If the prior account still holds the number, verification authenticates **that** account — a genuine risk of number recycling. Chapter 9 governs dormancy and number change to limit exposure |
| `XC-4.14` | **Claim attempted while the account is suspended** | Refused. Claims require an Active account |
| `XC-4.15` | **Account holds roles in ten libraries and claims an eleventh record** | Permitted. There is no limit on library associations |
| `XC-4.16` | **Library creates a record for a number already holding an account** | Permitted; the record is created unclaimed. The account claims it in the ordinary way. The library is not informed that the number holds an account |

---

## 4.9 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-4.1` | Registration with an unregistered number creates exactly one account bearing the collected display name |
| `AC-4.2` | Registration with a registered number authenticates the existing account and creates no second account |
| `AC-4.3` | No account exists at any point before verification succeeds |
| `AC-4.4` | Failed verification — wrong code, expired, exhausted, or no challenge — creates no account |
| `AC-4.5` | Account creation is refused when the display name is empty or whitespace-only |
| `AC-4.6` | Account creation is refused when the display name equals the mobile number in any format |
| `AC-4.7` | No account is ever created bearing a platform-generated display name |
| `AC-4.8` | A second registration attempt on an existing account leaves the stored display name byte-identical |
| `AC-4.9` | The inputs requested during registration are identical for registered and unregistered numbers |
| `AC-4.10` | A newly created account holds zero roles at both scopes and is associated with zero libraries |
| `AC-4.11` | A newly created account is Active, and this state is presented as normal rather than as an error |
| `AC-4.12` | Account identifiers are never reused following deletion |
| `AC-4.13` | The mobile number cannot be derived from the account identifier |
| `AC-4.14` | A claim succeeds only after verification of the number recorded on the target record |
| `AC-4.15` | A claim supplying correct student details but no verification is refused |
| `AC-4.16` | A successful claim confers the Student role in exactly one library |
| `AC-4.17` | A successful claim preserves all pre-existing history on the record |
| `AC-4.18` | A successful claim leaves the account display name unchanged |
| `AC-4.19` | Refusals for non-existent, already-claimed, deleted and ineligible records are externally identical |
| `AC-4.20` | A record already claimed cannot be claimed again by any account |
| `AC-4.21` | The sixth failed claim within 24 hours is refused by rate limiting |
| `AC-4.22` | An account can associate with at least ten libraries with no degradation of isolation |
| `AC-4.23` | No response in either path discloses an account's association with any other library |
| `AC-4.24` | Removing an account from every library leaves the account Active and holding no roles |
| `AC-4.25` | Registration cannot produce a second account for a number bound to a suspended, locked or soft-deleted account |
| `AC-4.26` | Every account creation and every successful claim emits exactly one corresponding event |


---

# Chapter 5 — Login & Library Selection

## 5.1 Purpose

Login is the act by which a returning user proves control of an existing identity. Library selection is the act by
which that authenticated identity acquires an operating context.

They are **separate stages**, and the separation is the central point of this chapter.

| Stage | Question answered | Result | Owner |
|---|---|---|---|
| **Login** | Who is this? | An authenticated identity | Authentication |
| **Library selection** | Where are they operating? | An active tenant context | Authentication |
| **Authorization** | What may they do here? | An access decision | Authentication (Chapter 7) |

A user may complete stage one and be unable to complete stage two — a genuine, expected outcome for anyone who
holds an account but belongs to no library. Such a user is authenticated and authorised for nothing. Treating this
as a login failure would be incorrect: their identity was proven; they simply have nowhere to operate.

`AUTH-5.1` — Authentication and tenant context establishment **MUST** be separate stages. They **MUST NOT** be
merged into a single operation.

`AUTH-5.2` — Successful authentication **MUST NOT**, by itself, confer access to any library.

---

## 5.2 Login Principles

| ID | Principle | Requirement |
|---|---|---|
| `LP-1` | **Secure authentication** | `AUTH-5.3` — Login **MUST** use the same verification mechanism as registration, with identical guarantees of unpredictability, time limitation, attempt limitation and single use |
| `LP-2` | **One global account** | `AUTH-5.4` — A user authenticates **once** against their global account, irrespective of how many libraries they belong to. Per-library login does not exist |
| `LP-3` | **Mobile-first** | `AUTH-5.5` — Login **MUST** require only the mobile number and the code. No additional input may be required |
| `LP-4` | **Identity before authorization** | `AUTH-5.6` — No permission **MAY** be evaluated, and no tenant data accessed, before authentication completes |
| `LP-5` | **Tenant isolation** | `AUTH-5.7` — Login **MUST** be tenant-neutral. It **MUST NOT** be performed in the context of a library, and its behaviour **MUST NOT** vary by library |
| `LP-6` | **Uniform behaviour** | `AUTH-5.8` — Login **MUST NOT** disclose, before verification succeeds, whether the number is registered or what state its account holds |
| `LP-7` | **Minimum interactive frequency** | `AUTH-5.9` — A returning user on a trusted device **MUST NOT** be required to authenticate interactively during normal use |

> `LP-5` has a practical consequence worth stating: there is no per-library login page, no library-scoped login
> identifier, and no way for a library to observe login attempts by numbers that are not its members. Login
> belongs to the platform, not to any tenant.

---

## 5.3 Login Flow

### Preconditions

| Precondition | Requirement |
|---|---|
| Mobile number | Structurally valid |
| Challenge | Issued and unexpired |
| Rate limits | Not exceeded (Chapter 8) |

`AUTH-5.10` — Login **MUST NOT** require the user to declare whether they are registering or logging in. The
platform determines this from the verification outcome, never from user assertion.

> This is why registration and login present the same inputs. A user who does not know whether they have an
> account simply proceeds; the platform resolves it. A flow that asked "are you new?" would both burden the user
> and, if the answer were validated, disclose registration status.

### Successful login

On successful verification of a number bound to an existing Active account:

| Effect | Detail |
|---|---|
| Identity established | The account is authenticated |
| Challenge destroyed | Single-use; cannot be replayed |
| Display name unchanged | Any name supplied during the attempt is discarded |
| Roles unchanged | Login never alters role assignments |
| Next stage | Library selection (§5.4) |

`AUTH-5.11` — Successful login **MUST** yield an authenticated identity and nothing more. It **MUST NOT** issue a
session bearing an active tenant until library selection completes.

### Failed login

`AUTH-5.12` — All of the following **MUST** produce an externally identical refusal: incorrect code, expired
challenge, exhausted attempt budget, no challenge issued, and unregistered number.

`AUTH-5.13` — A failed login **MUST NOT** disclose which condition applied, **MUST NOT** alter account state
beyond attempt accounting, and **MUST** be counted toward rate limiting.

### Account not in a usable state

The following describe the **user-visible** outcome. Complete state semantics are defined in Chapter 9.

| Account state | Verification | Outcome |
|---|---|---|
| **Active** | May succeed | Proceeds to library selection |
| **Suspended** | May succeed | Identity established; **access denied**. The user is informed that the account is unavailable and directed to support. No library context is established |
| **Locked** | May succeed | Identity established; **access denied** until the lock clears or is cleared administratively |
| **Disabled** | May succeed | Identity established; **access denied**. Reinstatement requires administrative action |
| **Deleted, within retention** | Refused | Treated as unregistered. Recovery follows Chapter 9, not login |
| **Deleted, retention elapsed** | N/A | The number is unbound; the flow is registration, not login |
| **Pending verification** | N/A | Not reachable — no account exists before verification succeeds |

`AUTH-5.14` — Where an account exists but is unusable, the platform **MUST** distinguish this from a failed
verification. The user proved control of the number; telling them their code was wrong would be false and would
send them into a futile retry loop.

`AUTH-5.15` — A refusal for an unusable account **MUST** be actionable and **MUST NOT** disclose the specific
reason for suspension, locking or disablement.

`AUTH-5.16` — An unusable account **MUST NOT** proceed to library selection, and **MUST NOT** receive a session
bearing any tenant context.

---

## 5.4 Library Selection

Following successful authentication of a usable account, the platform resolves the libraries in which the account
holds an active role.

### Single-library users

`AUTH-5.17` — Where exactly one library is available, it **MUST** be selected automatically. No prompt is
presented.

> This covers the overwhelming majority of users. A student attending one library must never be asked to choose
> from a list of one.

### Multi-library users

`AUTH-5.18` — Where more than one library is available, the platform **MUST** establish exactly one as active,
resolved in the following order:

| Order | Rule |
|---|---|
| 1 | The **last selected** library, if still available to the account |
| 2 | The account's **default** library, if set and still available |
| 3 | **Explicit selection** by the user from the available set |

`AUTH-5.19` — Where neither the last selected nor the default library is available, the user **MUST** be asked to
choose. The platform **MUST NOT** select arbitrarily on the user's behalf.

### Default library

`AUTH-5.20` — An account **MAY** nominate one library as its default. The nomination is a user preference, holds
no security significance, and **MUST NOT** influence any access decision.

`AUTH-5.21` — Where the default library becomes unavailable, the default **MUST** be cleared rather than
reassigned.

### Last selected library

`AUTH-5.22` — The platform **MUST** record the most recently activated library per account and use it as the
first-choice context on subsequent authentication.

`AUTH-5.23` — The last-selected record **MUST** be revalidated at every use. A library the account can no longer
access **MUST NOT** be activated on the basis of this record.

### Library switching

`AUTH-5.24` — An authenticated user **MUST** be able to switch the active library **without re-authenticating**.

`AUTH-5.25` — Switching **MUST** discard the prior authorization context in full and rebuild it from the target
library's role assignments.

`AUTH-5.26` — Switching **MUST** be available only to libraries in which the account currently holds an active
role, revalidated at the moment of switching.

### No available libraries

`AUTH-5.27` — Where an account holds no active role in any library, authentication **MUST** succeed and tenant
context establishment **MUST NOT** occur.

`AUTH-5.28` — This state **MUST** be presented as a normal outcome — the account exists and is verified, but
belongs to no library yet. It **MUST NOT** be presented as an authentication failure.

`AUTH-5.29` — In this state the account **MUST** be able to perform only account-level actions that require no
tenant context. It **MUST NOT** receive data from any library.

---

## 5.5 Tenant Context Establishment

### The stages, in order

`AUTH-5.30` — The following sequence **MUST** be observed, and no stage may be skipped or reordered:

| Stage | Action | Result |
|---|---|---|
| 1 | Identity verification | Authenticated identity |
| 2 | Account state evaluation | Account confirmed usable |
| 3 | Available library resolution | Set of libraries with active roles |
| 4 | Tenant selection | Exactly one active library |
| 5 | Authorization context construction | Roles and permissions for that library |
| 6 | Session issuance | Operable session bearing tenant context |

`AUTH-5.31` — A session bearing tenant context **MUST NOT** be issued before stage 5 completes.

### Active tenant context

`AUTH-5.32` — Exactly one library **MUST** be active at any moment. Zero is valid only in the no-library state,
where no tenant-scoped operation is permitted. More than one is never valid.

`AUTH-5.33` — Every tenant-scoped operation **MUST** resolve its tenant from the active context. An operation
**MUST NOT** accept a tenant supplied by the caller.

> This is the structural basis of tenant isolation. If a request could name its own tenant, isolation would depend
> on validating that name correctly on every path. By deriving it from the established context, a request has no
> means to reach another library at all.

### Context switching

`AUTH-5.34` — On switching, the platform **MUST**: revalidate the account's role in the target library, discard
the entire prior authorization context, construct a new one, and record the change.

`AUTH-5.35` — Switching **MUST NOT** create a second session, and **MUST NOT** leave the prior context
recoverable within the session.

### Tenant isolation

`AUTH-5.36` — No operation performed under one active library **MAY** read, write, reference or infer data
belonging to another.

`AUTH-5.37` — The set of libraries available to an account **MUST NOT** be disclosed to any library.

`AUTH-5.38` — Library switching **MUST NOT** be observable by either the library departed or the library entered.

---

## 5.6 Business Rules

| ID | Rule |
|---|---|
| `BR-5.1` | A user authenticates once against their global account, never per library |
| `BR-5.2` | Login requires only a mobile number and a code |
| `BR-5.3` | The user is never asked to declare whether they are new or returning |
| `BR-5.4` | Incorrect, expired, exhausted, absent-challenge and unregistered outcomes are externally identical |
| `BR-5.5` | Login is tenant-neutral and never performed in a library's context |
| `BR-5.6` | Successful login confers identity only, never library access |
| `BR-5.7` | An unusable account may authenticate but receives no tenant context |
| `BR-5.8` | A refusal for an unusable account is distinguished from a verification failure, without disclosing the specific reason |
| `BR-5.9` | A single available library is selected automatically |
| `BR-5.10` | Multi-library resolution follows last selected, then default, then explicit choice |
| `BR-5.11` | The last-selected library is revalidated at every use |
| `BR-5.12` | The default library is a preference and carries no security significance |
| `BR-5.13` | An unavailable default is cleared, never reassigned |
| `BR-5.14` | Exactly one library is active at any moment |
| `BR-5.15` | Switching requires no re-authentication |
| `BR-5.16` | Switching discards the prior authorization context entirely |
| `BR-5.17` | Switching is limited to libraries where an active role is held, revalidated at that moment |
| `BR-5.18` | An account with no library role authenticates successfully and receives no tenant context |
| `BR-5.19` | The no-library state is a normal outcome, not an error |
| `BR-5.20` | Tenant-scoped operations derive their tenant from the active context, never from the caller |
| `BR-5.21` | The set of libraries available to an account is never disclosed to any library |
| `BR-5.22` | A session bearing tenant context is issued only after the authorization context is constructed |

---

## 5.7 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-5.1` | **Account belongs to one library** | Selected automatically; no prompt. The user perceives a single continuous login |
| `XC-5.2` | **Account belongs to several libraries** | Last selected, else default, else explicit choice. Exactly one becomes active |
| `XC-5.3` | **Account belongs to no library** | Authentication succeeds; no tenant context. Presented as a normal state. Only account-level actions are available |
| `XC-5.4` | **Last library removed while signed out** | Next authentication succeeds and yields the no-library state. The account is unaffected |
| `XC-5.5` | **Library suspended before selection** | Excluded from the available set. If it was last selected or default, resolution falls through to the next rule |
| `XC-5.6` | **Active library suspended during a session** | The next decision in that library denies. Tenant context is cleared; the user selects another library or enters the no-library state. The session remains authenticated |
| `XC-5.7` | **Library deleted while active** | As `XC-5.6`, and the library is permanently removed from the available set |
| `XC-5.8` | **Membership expired but role retained** | The library remains available and selectable. Membership Management governs what the expired membership permits; Authentication does not withdraw the role |
| `XC-5.9` | **Role removed while the library is active** | The next decision denies. Tenant context is cleared. The session remains authenticated — authentication and authorization fail independently |
| `XC-5.10` | **Role removed in a library that is not active** | No effect on the current session. The library disappears from the available set at the next resolution |
| `XC-5.11` | **Role granted during an active session** | The new library becomes available at the next resolution or switch. No re-authentication is required |
| `XC-5.12` | **Tenant temporarily unavailable** | Access to that library is denied while unavailable — fail closed. Other libraries are unaffected. Authentication itself remains available |
| `XC-5.13` | **Switch attempted to a library where the role was just revoked** | Refused at revalidation. The prior context is already discarded, so the outcome is the no-library state until another selection is made |
| `XC-5.14` | **Two devices active in different libraries** | Permitted. Each session holds its own active library independently. No cross-session leakage occurs |
| `XC-5.15` | **Account suspended while operating in a library** | Every subsequent decision denies, in every library, on every device, within the revocation window |
| `XC-5.16` | **Verification succeeds for a soft-deleted account** | Treated as unregistered; login does not proceed. Recovery is governed by Chapter 9 |
| `XC-5.17` | **Last-selected library still recorded after role loss** | Revalidation excludes it. Resolution falls through. The stale record is cleared |
| `XC-5.18` | **Account holds roles in ten libraries** | All are available. Exactly one is active. Switching among them requires no re-authentication |

---

## 5.8 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-5.1` | A user with any number of library associations authenticates exactly once |
| `AC-5.2` | Login requires no input beyond the mobile number and the code |
| `AC-5.3` | Incorrect, expired, exhausted, absent-challenge and unregistered refusals are indistinguishable in content, shape and observable timing |
| `AC-5.4` | Login behaviour is identical irrespective of which libraries the account belongs to |
| `AC-5.5` | Successful login without library selection grants access to no library data |
| `AC-5.6` | A suspended account may verify successfully yet receives no tenant context and no library data |
| `AC-5.7` | The refusal shown to a suspended account differs from a verification failure and does not state the reason for suspension |
| `AC-5.8` | An account with exactly one available library reaches an operable state with no selection prompt |
| `AC-5.9` | An account with several libraries activates the last selected one when it remains available |
| `AC-5.10` | Where the last selected library is unavailable, the default is used; where neither is available, the user is prompted |
| `AC-5.11` | An unavailable default library is cleared rather than reassigned |
| `AC-5.12` | An account with no library role authenticates successfully and receives no tenant context |
| `AC-5.13` | The no-library state is presented as a normal outcome, not as an authentication error |
| `AC-5.14` | Exactly one library is active in a session at all times; no state exists with two |
| `AC-5.15` | Switching libraries requires no re-authentication and issues no new session |
| `AC-5.16` | After switching, effective permissions equal exactly those of the new library, with no residue from the previous context |
| `AC-5.17` | A switch to a library where the role was revoked is refused at revalidation |
| `AC-5.18` | No tenant-scoped operation accepts a tenant identifier supplied by the caller |
| `AC-5.19` | No response discloses the set of libraries an account belongs to |
| `AC-5.20` | Suspending the active library denies the next decision while leaving the session authenticated |
| `AC-5.21` | Revoking a role in the active library denies the next decision while leaving the session authenticated |
| `AC-5.22` | Two sessions on different devices may hold different active libraries with no cross-contamination |
| `AC-5.23` | A session bearing tenant context is never observed before the authorization context is constructed |
| `AC-5.24` | An unavailable tenant results in denial rather than in unscoped access |


---

# Chapter 6 — Session & Device Management

## 6.1 Purpose

### Why sessions exist

Authentication is expensive for the user — it requires a message, a wait, and manual entry of a code. Requiring it
on every request would make the platform unusable. A session is the mechanism that lets a single authentication
event stand for a period of continued access.

A session is therefore a **bounded assertion**: this identity was verified, at this time, in this library, on this
device, and that assertion remains valid until it expires or is withdrawn. Every property in this chapter derives
from the need to keep that assertion accurate — long enough to be usable, short enough to be safe, and revocable
the instant it stops being true.

### Why device management exists

A session exists on a device. Where the device is, and who holds it, determines the real security of the session.

Device management serves three purposes:

| Purpose | Rationale |
|---|---|
| **Visibility** | A user can only detect compromise if they can see where their account is signed in |
| **Control** | Detecting compromise is useless without the ability to end it — per device, immediately |
| **Reduced friction** | Recognising a device the user has already proven control of allows longer sessions without weakening security for unknown devices |

`AUTH-6.1` — Authentication **MUST** own the complete session lifecycle and the complete device trust model. No
other context **MAY** create, extend, validate or terminate a session.

`AUTH-6.2` — Every session **MUST** be bound to exactly one account, one device and one active library.

---

## 6.2 Session Principles

| ID | Principle | Requirement |
|---|---|---|
| `SN-1` | **One authenticated identity** | `AUTH-6.3` — Every session represents exactly one account. A session **MUST NOT** represent multiple identities, and **MUST NOT** be transferable between accounts |
| `SN-2` | **Independent sessions** | `AUTH-6.4` — Sessions are mutually independent. The creation, renewal, expiry or termination of one **MUST NOT** affect another, except where a global action explicitly targets all |
| `SN-3` | **Secure lifecycle** | `AUTH-6.5` — Every session **MUST** have a defined creation, a bounded lifetime and a definite end. An unbounded session **MUST NOT** exist |
| `SN-4` | **Session isolation** | `AUTH-6.6` — A session **MUST NOT** expose its state to another session, and **MUST NOT** be reconstructible from another |
| `SN-5` | **Global sign-out** | `AUTH-6.7` — An account holder **MUST** be able to terminate every session across every device in a single action |
| `SN-6` | **Revocation** | `AUTH-6.8` — Any session **MUST** be revocable individually, immediately, and independently of its expiry |
| `SN-7` | **Expiration** | `AUTH-6.9` — Every session **MUST** be subject to both an idle limit and an absolute limit, whichever is reached first |
| `SN-8` | **Tenant binding** | `AUTH-6.10` — A session **MUST** carry exactly one active library at any moment, and every tenant-scoped decision within it **MUST** resolve from that binding |
| `SN-9` | **Authentication and authorization fail independently** | `AUTH-6.11` — Loss of authorization **MUST NOT** invalidate a session. Loss of identity validity **MUST** invalidate it |

> `SN-9` restates the chapter's most important boundary. A user whose role is revoked remains *authenticated* —
> the platform still knows who they are — but is no longer *authorised*. Terminating the session would be wrong:
> the identity assertion is still true. Only the permission changed.

---

## 6.3 Session Lifecycle

### Creation

`AUTH-6.12` — A session **MUST** be created only after: successful verification, confirmation that the account is
usable, establishment of an active library, and construction of the authorization context.

`AUTH-6.13` — A session **MUST NOT** be created for an account holding no role in any library. Such an account is
authenticated but has no context in which a session could operate.

At creation a session records: the account, the device, the active library, the roles held in that library at that
moment, the creation time, the last activity time, and both expiry boundaries.

### Activation

`AUTH-6.14` — A session becomes operable at creation. No separate activation step exists.

### Renewal

`AUTH-6.15` — Activity within a session **MUST** extend its idle boundary, and **MUST NOT** extend its absolute
boundary.

`AUTH-6.16` — Renewal **MUST NOT** re-establish identity. A renewed session carries the assurance of its original
authentication, which is why the absolute boundary cannot move.

`AUTH-6.17` — Renewal **MUST** revalidate that the account remains usable and that the active library remains
accessible. Failure of either **MUST** terminate the session.

### Expiration

| Boundary | Mobile (`CFG-5`, `CFG-6`) | Staff (`CFG-5`, `CFG-6`) |
|---|---|---|
| **Idle** — elapsed since last activity | 30 days | 12 hours |
| **Absolute** — elapsed since creation | 90 days | 7 days |

`AUTH-6.18` — A session **MUST** end when either boundary is reached, whichever occurs first.

`AUTH-6.19` — Sessions held by accounts with staff or platform roles in the active library **MUST** use the
shorter limits. Where an account holds both a staff and a non-staff role, the shorter limits apply.

> Staff operate on shared premises, often on shared hardware, and hold permissions over other people's data. A
> reception device left unattended overnight must not remain signed in. A student's personal phone poses a
> materially different risk and is treated accordingly.

### Termination

`AUTH-6.20` — A session **MUST** terminate on any of: idle expiry, absolute expiry, user sign-out, global
sign-out, administrative revocation, device removal, account state change to any unusable state, or mobile number
change.

`AUTH-6.21` — Termination **MUST** be immediate and irreversible. A terminated session **MUST NOT** be resumable.

### Sign-out

`AUTH-6.22` — Sign-out **MUST** terminate the current session only, leaving other sessions unaffected.

`AUTH-6.23` — Sign-out **MUST** clear the active tenant context and **MUST NOT** retain any authorization state.

### Sign out from all devices

`AUTH-6.24` — The account holder **MUST** be able to terminate every session on every device, including the
current one, in a single action.

`AUTH-6.25` — Global sign-out **MUST** take effect within the revocation window on every device, including those
offline at the time — enforced at their next contact.

### Forced sign-out

`AUTH-6.26` — The platform **MUST** terminate sessions without user action on: account suspension, locking,
disablement or deletion; mobile number change; device removal or trust revocation; administrative revocation; or
detection of a security condition warranting it.

`AUTH-6.27` — Forced sign-out **MUST** emit an event identifying the cause.

### Recovery

`AUTH-6.28` — An expired or terminated session **MUST NOT** be recoverable. Continued access requires a new
authentication.

`AUTH-6.29` — Session termination **MUST NOT** cause loss of user data. Work in progress is the responsibility of
the owning context.

---

## 6.4 Device Management

### Device categories

| Category | Definition | Consequence |
|---|---|---|
| **Trusted** | A registered device on which authentication succeeded and whose trust has not expired or been revoked | Longer session limits; reduced interactive authentication |
| **Registered** | A device known to the account, on which a session was created, but which is not currently trusted | Normal session limits; interactive authentication as required |
| **Unknown** | A device with no prior successful authentication for this account | Full interactive authentication; event emitted on first use |

`AUTH-6.30` — Every session **MUST** be associated with exactly one device record.

`AUTH-6.31` — A device record **MUST** be created on first successful authentication from that device.

### Device ownership

`AUTH-6.32` — A device record belongs to the account, not to the platform or to any library.

`AUTH-6.33` — No library **MAY** view, name, trust or remove any device belonging to an account, including
devices used to access that library.

`AUTH-6.34` — Platform roles **MUST NOT** view or manage device records without an approved elevation, and
**MUST NOT** grant or extend trust under any circumstance.

### Device naming

`AUTH-6.35` — Each device record **MUST** carry a name distinguishable by the user.

`AUTH-6.36` — The account holder **MUST** be able to rename any of their devices. Names are for user recognition
only and carry no security significance.

### Device removal

`AUTH-6.37` — The account holder **MUST** be able to remove any device, including the one in use.

`AUTH-6.38` — Removal **MUST** immediately terminate every session on that device and revoke its trust.

`AUTH-6.39` — A removed device **MUST** be treated as unknown on next use, requiring full interactive
authentication.

### Device limits

`AUTH-6.40` — An account **MUST NOT** exceed `CFG-8` (10) concurrently registered devices.

`AUTH-6.41` — On reaching the limit, the account holder **MUST** be required to remove a device before registering
another. The platform **MUST NOT** silently evict.

> Silent eviction would let an attacker displace the legitimate user's device by registering enough of their own.
> Requiring explicit removal keeps the user in control of that decision.

### Last active information

`AUTH-6.42` — Each device record **MUST** show its name, category, first-seen time, last-active time and trust
expiry, so the holder can recognise an unfamiliar device.

`AUTH-6.43` — Device records **MUST NOT** expose any authentication factor, challenge value or session secret.

---

## 6.5 Device Trust Rules

### Becoming trusted

`AUTH-6.44` — A device becomes trusted upon successful interactive authentication from it, where the account is
Active and no security condition prohibits trust.

`AUTH-6.45` — Trust **MUST NOT** be conferred by assertion, by device characteristics, or by any signal other than
successful authentication from the device itself.

### Trust expiry

`AUTH-6.46` — Trust **MUST** expire `CFG-7` (180 days) after it was established.

`AUTH-6.47` — Expiry of trust **MUST NOT** terminate active sessions. It removes the device's reduced-friction
status; existing sessions continue until their own boundaries.

`AUTH-6.48` — Trust **MUST** be re-established only by a further successful interactive authentication.

### Removing trust

`AUTH-6.49` — The account holder **MUST** be able to revoke trust for any device without removing the device
record.

`AUTH-6.50` — Trust **MUST** be revoked automatically on: device removal, mobile number change, account state
change to unusable, global sign-out, or detection of a security condition affecting the account.

### Lost or stolen devices

`AUTH-6.51` — The account holder **MUST** be able to remove a lost device from any other device, terminating its
sessions and revoking its trust immediately.

`AUTH-6.52` — Where no other device is available, global sign-out **MUST** be reachable following a fresh
authentication on a new device.

> The design intent is that a user who has lost their phone can recover control from any borrowed device by
> authenticating with their number and signing out everywhere.

### New device detection

`AUTH-6.53` — First successful authentication from an unknown device **MUST** emit an event.

`AUTH-6.54` — New-device detection **MUST NOT** block authentication. It is a detection mechanism, not a control.

### Verification requirements

`AUTH-6.55` — Full interactive authentication **MUST** be required on: an unknown device, a device whose trust has
expired, a device whose trust was revoked, and the first use after a mobile number change.

---

## 6.6 Session Security

### Timeouts

`AUTH-6.56` — Both idle and absolute limits **MUST** be enforced server-side. Client-reported time **MUST NOT**
influence expiry.

`AUTH-6.57` — Expiry **MUST** be evaluated at every use of the session, not by scheduled sweep alone. A session
past either boundary is invalid at the moment of use, irrespective of cleanup timing.

### Renewal principles

`AUTH-6.58` — Session renewal **MUST NOT** extend the absolute boundary, **MUST NOT** re-establish identity, and
**MUST** revalidate account and tenant state.

### Revocation

`AUTH-6.59` — Revocation **MUST** take effect on the next use of the session, without dependence on cache
expiry, propagation delay or client cooperation.

`AUTH-6.60` — Revocation **MUST** be available for: one session, all sessions on a device, and all sessions of an
account.

### Concurrent sessions

`AUTH-6.61` — An account **MAY** hold concurrent sessions on distinct devices, within `CFG-8`.

`AUTH-6.62` — Concurrent sessions **MAY** hold different active libraries independently.

`AUTH-6.63` — A single device **MUST NOT** hold more than one active session per account.

### Hijacking protection

`AUTH-6.64` — A session **MUST** be bound to its device record. Presentation from a different device **MUST** be
refused and **MUST** emit an event.

`AUTH-6.65` — Session identifiers **MUST** be unpredictable, and **MUST NOT** be derived from the account, the
device, the tenant or the time.

`AUTH-6.66` — Session identifiers **MUST NOT** appear in any event, log, metric, error, analytics record or
user-visible surface.

### Replay protection

`AUTH-6.67` — A terminated, expired or revoked session **MUST NOT** be reusable under any circumstance.

`AUTH-6.68` — Authentication challenges **MUST NOT** be replayable into session creation. A challenge yields at
most one session.

---

## 6.7 Multi-Device Rules

| Aspect | Requirement |
|---|---|
| **Same account, several devices** | `AUTH-6.69` — Permitted within `CFG-8`. This is the normal case: phone, tablet, desk terminal |
| **Device independence** | `AUTH-6.70` — Each device holds its own trust state, session state and active library. No device's state affects another's |
| **Session independence** | `AUTH-6.71` — Terminating one session **MUST NOT** affect sessions on other devices, unless the action was global |
| **Global sign-out** | `AUTH-6.72` — Terminates every session on every device within the revocation window, including offline devices at next contact |
| **Forced sign-out** | `AUTH-6.73` — Applies to every device when triggered by an account-level condition; to one device when triggered by a device-level condition |
| **Synchronisation** | `AUTH-6.74` — Account state, role assignments and revocation are authoritative platform-side and **MUST** be evaluated on every use. Devices **MUST NOT** hold authoritative copies |

`AUTH-6.75` — Devices **MUST NOT** synchronise session state directly with one another. All coordination occurs
through the platform.

---

## 6.8 Business Rules

| ID | Rule |
|---|---|
| `BR-6.1` | A session is created only after verification, usability confirmation, tenant establishment and authorization context construction |
| `BR-6.2` | No session is created for an account holding no library role |
| `BR-6.3` | Every session binds exactly one account, one device and one active library |
| `BR-6.4` | Activity extends the idle boundary and never the absolute boundary |
| `BR-6.5` | A session ends at whichever boundary is reached first |
| `BR-6.6` | Mobile sessions use 30-day idle and 90-day absolute limits |
| `BR-6.7` | Staff and platform sessions use 12-hour idle and 7-day absolute limits |
| `BR-6.8` | Where both apply, the shorter limits govern |
| `BR-6.9` | Sign-out terminates only the current session |
| `BR-6.10` | Global sign-out terminates every session on every device |
| `BR-6.11` | Forced sign-out occurs on suspension, locking, disablement, deletion, number change, device removal and administrative revocation |
| `BR-6.12` | A terminated or expired session is never resumable |
| `BR-6.13` | Loss of authorization does not terminate a session |
| `BR-6.14` | Loss of identity validity terminates every session |
| `BR-6.15` | Every session is associated with exactly one device record |
| `BR-6.16` | Device records belong to the account, never to a library or the platform |
| `BR-6.17` | No library may view or manage any device |
| `BR-6.18` | Platform roles may never grant or extend device trust |
| `BR-6.19` | An account may hold at most `CFG-8` registered devices |
| `BR-6.20` | Reaching the device limit requires explicit removal; devices are never silently evicted |
| `BR-6.21` | Trust is conferred only by successful interactive authentication from the device |
| `BR-6.22` | Trust expires after `CFG-7` and is re-established only by authenticating again |
| `BR-6.23` | Trust expiry does not terminate active sessions |
| `BR-6.24` | Device removal immediately terminates that device's sessions and revokes its trust |
| `BR-6.25` | A removed device is treated as unknown on next use |
| `BR-6.26` | First authentication from an unknown device emits an event and does not block access |
| `BR-6.27` | Expiry is enforced server-side; client time never influences it |
| `BR-6.28` | Revocation takes effect at next use, with no dependence on client cooperation |
| `BR-6.29` | A session presented from a different device is refused and emits an event |
| `BR-6.30` | Session identifiers are unpredictable and never appear in any event, log, metric or error |
| `BR-6.31` | One device holds at most one active session per account |
| `BR-6.32` | Concurrent sessions may hold different active libraries |
| `BR-6.33` | A challenge yields at most one session |
| `BR-6.34` | Devices never synchronise session state directly |

---

## 6.9 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-6.1` | **Device lost** | The holder removes it from any other device. Sessions terminate and trust is revoked immediately. If no other device is available, they authenticate on a new one and sign out everywhere |
| `XC-6.2` | **Device stolen** | As `XC-6.1`. Global sign-out is the recommended action, terminating every session including the thief's |
| `XC-6.3` | **Mobile number changed** | Every session terminates and all device trust is revoked. The identity anchor changed, so prior authentication assurance no longer holds. Full interactive authentication is required on every device |
| `XC-6.4` | **Session expired** | Refused at next use. The user re-authenticates. On a trusted device this remains low-friction |
| `XC-6.5` | **Session revoked while in use** | The next operation is refused. No partial-authority state exists between revocation and refusal |
| `XC-6.6` | **Offline device reconnects after global sign-out** | Its session is refused on first contact. The device cannot detect the revocation while offline; enforcement occurs at reconnection |
| `XC-6.7` | **Offline device reconnects after expiry** | Refused. Elapsed real time governs, not connected time |
| `XC-6.8` | **Account suspended during an active session** | Every session terminates within the revocation window, on every device |
| `XC-6.9` | **Library role removed during an active session** | The session **remains valid**. The next tenant-scoped decision denies and the tenant context is cleared. The user may select another library |
| `XC-6.10` | **Only library role removed during a session** | The session remains valid with no tenant context. The account enters the no-library state without being signed out |
| `XC-6.11` | **Several simultaneous logins** | Permitted within `CFG-8`, one session per device. Each authentication from an unknown device emits an event |
| `XC-6.12` | **Device clock incorrect** | No effect. All boundaries are evaluated server-side; client-reported time is never trusted |
| `XC-6.13` | **Device limit reached** | Registration of a further device is refused until one is removed. The refusal names the limit and offers the device list |
| `XC-6.14` | **Trust expires during an active session** | The session continues to its own boundaries. Only the device's reduced-friction status ends |
| `XC-6.15` | **Same account signed in on two devices in different libraries** | Fully supported. Each session holds its own active library; neither observes the other's |
| `XC-6.16` | **Session presented from a different device** | Refused, session terminated, event emitted. Treated as a probable hijacking attempt |
| `XC-6.17` | **User signs out on one device** | Only that session ends. Other devices are unaffected |
| `XC-6.18` | **Global sign-out issued from the device in use** | Every session terminates, including the initiating one. The user is signed out where they stand |
| `XC-6.19` | **Two devices authenticate concurrently with the same challenge** | The challenge is single-use: at most one session results. The second attempt is refused |
| `XC-6.20` | **Account deleted with active sessions** | Every session terminates immediately and every device record is removed |
| `XC-6.21` | **Staff role granted to an account with an active mobile session** | The shorter staff limits apply from the next renewal. The absolute boundary is recomputed and may already have passed, ending the session |
| `XC-6.22` | **Device removed while that device is online** | Its next operation is refused. It cannot re-register itself; the user must authenticate again |

---

## 6.10 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-6.1` | No session exists before verification, usability confirmation, tenant establishment and authorization context construction all complete |
| `AC-6.2` | An account holding no library role receives no session |
| `AC-6.3` | Every session names exactly one account, one device and one active library |
| `AC-6.4` | Activity extends the idle boundary; the absolute boundary is never extended by any activity |
| `AC-6.5` | A mobile session is refused after 30 days idle or 90 days from creation, whichever comes first |
| `AC-6.6` | A staff session is refused after 12 hours idle or 7 days from creation, whichever comes first |
| `AC-6.7` | An account holding both staff and non-staff roles receives the shorter limits |
| `AC-6.8` | Sign-out ends only the current session, verified against a concurrent session on another device |
| `AC-6.9` | Global sign-out ends every session on every device within the revocation window |
| `AC-6.10` | An offline device is refused at first contact after a global sign-out |
| `AC-6.11` | An expired or terminated session is never resumable by any means |
| `AC-6.12` | Role revocation denies the next tenant-scoped decision while the session remains authenticated |
| `AC-6.13` | Account suspension terminates every session on every device |
| `AC-6.14` | A mobile number change terminates every session and revokes trust on every device |
| `AC-6.15` | Every session is associated with exactly one device record, created on first authentication from it |
| `AC-6.16` | No library-scoped role can view, name, trust or remove any device |
| `AC-6.17` | No platform role can grant or extend device trust, with or without elevation |
| `AC-6.18` | Registering an eleventh device is refused until an existing device is removed |
| `AC-6.19` | No device is ever removed automatically to make room for another |
| `AC-6.20` | Trust is conferred only by successful interactive authentication from the device |
| `AC-6.21` | Trust expires 180 days after establishment and is restored only by authenticating again |
| `AC-6.22` | Trust expiry leaves active sessions running to their own boundaries |
| `AC-6.23` | Device removal terminates that device's sessions immediately and revokes its trust |
| `AC-6.24` | A removed device requires full interactive authentication on next use |
| `AC-6.25` | First authentication from an unknown device emits exactly one event and does not block access |
| `AC-6.26` | Altering the device clock does not extend or shorten any session |
| `AC-6.27` | A session presented from a device other than the one it was bound to is refused, terminated and evented |
| `AC-6.28` | Session identifiers are unpredictable and appear in no event, log, metric, error or analytics record |
| `AC-6.29` | One device holds at most one active session per account |
| `AC-6.30` | Two sessions on different devices may hold different active libraries with no cross-contamination |
| `AC-6.31` | A single challenge yields at most one session under concurrent use |
| `AC-6.32` | Device records display name, category, first-seen, last-active and trust expiry, and disclose no secret |
| `AC-6.33` | Account deletion terminates every session and removes every device record |
| `AC-6.34` | Every forced sign-out emits an event identifying its cause |


---

# Chapter 7 — Roles, Permissions & Access Policies

## 7.1 Purpose

Authentication establishes **who** someone is. Authorization determines **what they may do**. This chapter
specifies the second.

### Why the two are separate

They answer different questions, fail for different reasons, and change on different timescales.

| Property | Authentication | Authorization |
|---|---|---|
| Question | Who is this? | May they do this, here? |
| Frequency | Once per session | Every operation |
| Scope | Global | Tenant-scoped |
| Changes when | Identity changes | Roles change |
| Failure means | We don't know who you are | We know exactly who you are, and the answer is no |

Merging them produces two well-known failures. First, permissions become fixed at sign-in — a revoked role
continues to work until the session ends, which contradicts immediate revocation. Second, "authenticated" starts
to imply "permitted", so any gap in permission checking defaults to access rather than refusal.

Separating them means a session can remain perfectly valid while every authorization within it is denied. That is
not an inconsistency; it is the design.

`AUTH-7.1` — Authorization **MUST** be evaluated independently of authentication, at every access decision, using
current state rather than state captured at sign-in.

`AUTH-7.2` — Authentication success **MUST NOT** be treated as evidence of any permission.

### Ownership boundary

Authentication owns **the decision**. Modules own **the feature**.

Authentication answers "may this role, in this library, perform this named action?" It does not know what the
action means, when it should be offered, or what happens next. A module asks the question and honours the answer;
it never substitutes its own.

`AUTH-7.3` — No module **MAY** implement its own access logic, infer permission from role names, or proceed when
Authentication has refused.

---

## 7.2 Authorization Principles

| ID | Principle | Requirement |
|---|---|---|
| `AP-1` | **Authentication before authorization** | `AUTH-7.4` — No permission is evaluated before identity is established. An unauthenticated request is refused without evaluation |
| `AP-2` | **Least privilege** | `AUTH-7.5` — Every role holds the minimum permissions its function requires. Permissions are never granted in anticipation of future need |
| `AP-3` | **Deny by default** | `AUTH-7.6` — Absence of an explicit grant is refusal. A newly introduced permission is unreachable by every role until explicitly granted |
| `AP-4` | **Explicit assignment** | `AUTH-7.7` — Permissions are granted by name. No permission is derived from role naming, hierarchy, seniority or similarity to another permission |
| `AP-5` | **Separation of duties** | `AUTH-7.8` — No account may assign itself a role, approve its own elevation, or authorise an action requiring independent approval |
| `AP-6` | **Tenant isolation** | `AUTH-7.9` — Every decision is evaluated with exactly one library in scope. A decision without a tenant is **invalid**, and invalid means refused |
| `AP-7` | **No role inheritance** | `AUTH-7.10` — Roles do not inherit from one another. Owner is an enumerated permission set, not "everything Manager has, plus more" |
| `AP-8` | **Policy-based** | `AUTH-7.11` — Decisions are produced by evaluating policy against role, tenant, action and resource — never by conditional logic embedded in a feature |
| `AP-9` | **Fail closed** | `AUTH-7.12` — Where any input to a decision is unavailable, indeterminate or in error, the decision is refusal |

> `AP-7` deserves emphasis. Inheritance hierarchies appear economical and consistently produce over-permission:
> adding a permission to a base role silently widens every role above it. Enumerating each role's permissions
> makes every grant deliberate and every widening visible.

---

## 7.3 Role Model

### Role classes

| Class | Scope | Assigned by | Duration |
|---|---|---|---|
| **Platform roles** | Platform-wide, platform objects only | Platform Administrator | Standing |
| **Library roles** | Exactly one library | Owner or Manager of that library | Standing |
| **Temporary roles** | One library, or platform-scoped elevation | Approved by a second account | Time-bounded |
| **System roles** | Platform-internal | Not assignable to accounts | N/A |
| **Default roles** | None exist | — | — |

### Platform roles

Two, closed: `PR-1` Platform Administrator and `PR-2` Platform Support. Both administer the platform. Neither
confers access to tenant business data.

`AUTH-7.13` — Platform roles **MUST NOT** grant any permission over tenant business data. Such access requires
temporary elevation.

### Library roles

Five, closed: `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5` Parent. Each assignment names
exactly one library.

`AUTH-7.14` — A library role **MUST** be scoped to exactly one library and **MUST** confer nothing in any other.

`AUTH-7.15` — An account **MAY** hold several library roles in one library. Effective permissions are the union of
their grants, **less** any explicit denial.

### Temporary roles

`AUTH-7.16` — A temporary role **MUST** carry an expiry recorded at grant time, and **MUST** cease at that moment
without any action.

`AUTH-7.17` — A temporary role **MUST** record requester, approver, scope, purpose and expiry.

`AUTH-7.18` — A temporary role **MUST NOT** be extended by its holder, and **MUST NOT** be renewed automatically.

`AUTH-7.19` — Platform Support elevation **MUST NOT** exceed `CFG-12` (4 hours).

### System roles

`AUTH-7.20` — System roles used by platform internals **MUST NOT** be assignable to any account, **MUST NOT**
appear in any role list, and **MUST NOT** be reachable by any authenticated request.

### Default roles

`AUTH-7.21` — No default role exists at either scope. A new account holds nothing, and role acquisition is always
an explicit act.

---

## 7.4 Permission Model

### Structure

A permission names a single capability. It is atomic: it cannot be partially held.

`AUTH-7.22` — The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted,
requested or evaluated.

`AUTH-7.23` — Every permission **MUST** declare its scope class. A permission without one is invalid.

### Permission categories

| Category | Governs | Example capability |
|---|---|---|
| **Identity** | Accounts, roles, devices, sessions | Assigning a role; viewing device records |
| **Operational** | Day-to-day library activity | Recording attendance; allocating a seat |
| **Member** | Records of people in a library | Viewing a member's status; administering a member |
| **Financial** | Revenue, fees, commercial data | Viewing revenue; recording a payment |
| **Configuration** | Library setup and settings | Changing operating hours; configuring seats |
| **Platform** | Platform-level objects | Provisioning a tenant; platform configuration |

### Action classes

| Action | Meaning |
|---|---|
| **Read** | Observe existing state |
| **Create** | Bring new state into existence |
| **Update** | Modify existing state |
| **Delete** | Remove state |
| **Approve** | Authorise an action requiring independent approval |
| **Export** | Extract data from the platform |

`AUTH-7.24` — Each action class **MUST** be granted independently. Read **MUST NOT** imply any other action, and
Update **MUST NOT** imply Create or Delete.

`AUTH-7.25` — **Approve** and **Export** **MUST** always be granted explicitly, and **MUST NOT** be implied by any
other action on the same resource.

> Export is separated because extraction has consequences reading does not: data leaves the platform's controls
> permanently. A role that may view a member list does not thereby acquire the right to remove a copy of it.

### Scope classes

A permission's scope determines the breadth of resource it may reach.

| Scope | Reaches |
|---|---|
| **Self** | Only resources belonging to the acting account |
| **Linked** | Only resources belonging to explicitly linked subjects |
| **Tenant** | Any resource within the active library |
| **Platform** | Platform-level objects only, never tenant business data |

`AUTH-7.26` — Every permission grant **MUST** carry a scope. A grant without one is invalid and **MUST** be
refused rather than treated as unrestricted.

`AUTH-7.27` — A scoped permission **MUST NOT** be exercisable without naming the resource it acts upon. A request
that omits the resource **MUST** be refused, never interpreted as applying to all.

> This is what prevents a student's "view attendance" from becoming "view everyone's attendance" through an
> omitted parameter.

### Hierarchy

`AUTH-7.28` — Permissions **MUST NOT** form a hierarchy. No permission implies another.

`AUTH-7.29` — Scopes **MUST** narrow, never widen: Self ⊂ Linked ⊂ Tenant. A grant at a narrower scope **MUST
NOT** be widened by holding another role at a broader one for a different permission.

---

## 7.5 Access Policies

### Evaluation

`AUTH-7.30` — A decision **MUST** be produced from exactly five inputs: authenticated identity, active tenant,
roles held in that tenant, the requested action, and the target resource.

`AUTH-7.31` — No other input **MAY** influence a decision — not the requesting module, not the interface, not the
device, not roles held in other tenants.

### Allow and deny rules

`AUTH-7.32` — An **allow** rule grants a named permission at a named scope to a named role.

`AUTH-7.33` — A **deny** rule prohibits a named permission for a named role irrespective of any allow rule.

`AUTH-7.34` — Deny **MUST** always defeat allow. No combination of roles, scopes or grants may overcome an
explicit denial.

> This makes constraints like "Reception never sees revenue" absolute. However many roles a person accumulates,
> the denial holds.

### Inheritance

`AUTH-7.35` — Permissions **MUST NOT** be inherited between roles, between scopes or between tenants. Every grant
is direct.

### Conflict resolution and precedence

`AUTH-7.36` — Decisions **MUST** be resolved in this order, stopping at the first that applies:

| Order | Condition | Outcome |
|---|---|---|
| 1 | No authenticated identity | **Deny** |
| 2 | Account not in a usable state | **Deny** |
| 3 | No active tenant, for a tenant-scoped action | **Deny** |
| 4 | An explicit deny rule matches | **Deny** |
| 5 | No allow rule matches | **Deny** |
| 6 | An allow rule matches but the resource lies outside its scope | **Deny** |
| 7 | An allow rule matches within scope | **Allow** |

`AUTH-7.37` — Where evaluation cannot complete for any reason, the outcome **MUST** be deny.

### Policy lifecycle

`AUTH-7.38` — Policy is defined at the platform level. No tenant **MAY** define, alter or extend it.

`AUTH-7.39` — A change to policy **MUST** take effect at the next decision, without requiring re-authentication.

`AUTH-7.40` — Policy changes **MUST** be auditable, attributable and reversible.

> Tenants configure their libraries; they never configure the permission model. Allowing per-tenant policy would
> make platform-wide guarantees unverifiable.

---

## 7.6 Role Assignment Rules

### Assignment authority

| Role | May be assigned by |
|---|---|
| `PR-1` Platform Administrator | A Platform Administrator other than the subject |
| `PR-2` Platform Support | A Platform Administrator |
| `TR-1` Owner | An existing Owner of that library |
| `TR-2` Manager | An Owner of that library |
| `TR-3` Reception | An Owner or Manager of that library |
| `TR-4` Student | Conferred on membership or successful claim |
| `TR-5` Parent | Conferred on a recognised parent–student link |

`AUTH-7.41` — Revocation authority **MUST** equal assignment authority. A holder **MAY** always relinquish their
own role, subject to the last-Owner rule.

### Constraints

`AUTH-7.42` — No account **MAY** assign a role conferring permissions the assigner does not hold.

`AUTH-7.43` — No account **MAY** assign any role to itself.

`AUTH-7.44` — Assignment requires the subject's account to be Active.

`AUTH-7.45` — A library **MUST** always retain at least one Owner. An assignment or revocation that would leave
none **MUST** be refused.

### Temporary access

`AUTH-7.46` — Temporary access **MUST** be requested by one account and approved by a different one.

`AUTH-7.47` — Temporary access **MUST** state its tenant, purpose and expiry at request time.

`AUTH-7.48` — Temporary access **MUST** terminate automatically at expiry, with no grace period.

### Invite-only roles

`AUTH-7.49` — `TR-1`, `TR-2`, `TR-3`, `PR-1` and `PR-2` **MUST** be invite-only. No self-service path may exist.

### Automatic removal

`AUTH-7.50` — A role **MUST** be removed automatically on: expiry of a temporary role, account deletion, or
deletion of the library it is scoped to.

`AUTH-7.51` — Automatic removal **MUST** emit an event identifying its cause.

### Cross-library restrictions

`AUTH-7.52` — An assignment in one library **MUST NOT** create, imply or affect any assignment in another.

`AUTH-7.53` — No assigner **MAY** assign a role in a library where they hold no assignment authority.

---

## 7.7 Permission Evaluation

Every access decision proceeds through the same sequence. No step may be omitted or reordered.

| Step | Evaluation | On failure |
|---|---|---|
| 1 | **Authentication** — is there a valid session bearing a verified identity? | Deny |
| 2 | **Account state** — is the account usable? | Deny |
| 3 | **Active tenant** — is exactly one library in scope, for a tenant-scoped action? | Deny |
| 4 | **Role resolution** — which roles does this account currently hold in this tenant? | Deny if none |
| 5 | **Policy evaluation** — apply precedence order `AUTH-7.36` | Deny at the first matching deny condition |
| 6 | **Scope check** — does the named resource lie within the granted scope? | Deny |
| 7 | **Decision** — allow or deny | — |

`AUTH-7.54` — Roles **MUST** be resolved at decision time from current state. A role list captured at sign-in
**MUST NOT** be used.

`AUTH-7.55` — Every denial **MUST** be indistinguishable, to the requester, from the resource not existing.

> A denial that says "you may not view this member" confirms the member exists. Across a library, that is an
> enumeration channel. Denials therefore reveal nothing about what lies behind them.

`AUTH-7.56` — Every decision on a sensitive resource **MUST** be recorded with actor, tenant, action, resource
class and outcome.

---

## 7.8 Multi-Tenant Authorization

`AUTH-7.57` — A decision **MUST** consider only roles held in the active tenant. Roles elsewhere **MUST NOT**
influence it.

`AUTH-7.58` — No decision **MAY** authorise access to a resource belonging to a tenant other than the active one.

`AUTH-7.59` — On switching tenants, the authorization context **MUST** be discarded entirely and rebuilt.

`AUTH-7.60` — A tenant **MUST NOT** be able to determine which other tenants an account holds roles in.

`AUTH-7.61` — Platform authority **MUST NOT** extend to tenant business data. Platform roles administer tenants as
objects; the contents require elevation.

### Worked example

An account holds `TR-1` Owner in Library C and `TR-4` Student in Library A. Library A is active.

| Attempted action | Outcome | Reason |
|---|---|---|
| View own attendance in Library A | **Allow** | `TR-4` grants Read at Self scope |
| View another student's attendance in Library A | **Deny** | Self scope excludes it |
| View revenue in Library A | **Deny** | `TR-4` holds no financial permission; ownership of C is not considered |
| View revenue in Library C | **Deny** | Library C is not the active tenant |
| Switch to Library C, then view revenue | **Allow** | After switching, `TR-1` applies and C is active |

---

## 7.9 Security Rules

### Privilege escalation prevention

`AUTH-7.62` — No account **MAY** obtain a permission it was not explicitly granted, by any sequence of permitted
actions.

`AUTH-7.63` — No account **MAY** assign, approve or elevate itself.

`AUTH-7.64` — No role **MAY** grant the ability to modify the policy that constrains it.

### Role spoofing prevention

`AUTH-7.65` — Roles **MUST** be resolved from authoritative platform state. A role asserted by a client, a
request or a module **MUST** be ignored.

`AUTH-7.66` — A request **MUST NOT** be able to name the tenant it operates in. The tenant derives from the
active context.

### Permission validation

`AUTH-7.67` — Every permission requested **MUST** exist in the closed catalogue. An unrecognised permission
**MUST** be refused, never treated as absent-therefore-harmless.

`AUTH-7.68` — Decisions **MUST** be evaluated server-side. Client-side checks are presentation only and carry no
authority.

### Unauthorized access protection

`AUTH-7.69` — Denials **MUST** disclose nothing about the resource, its existence or the reason for refusal.

`AUTH-7.70` — Repeated denials **MUST** be observable to security monitoring as a potential probing pattern.

### Audit requirements

`AUTH-7.71` — Every role assignment, revocation, elevation, expiry and policy change **MUST** emit an event.

`AUTH-7.72` — Every denial on a sensitive resource **MUST** be recorded.

`AUTH-7.73` — Audit records **MUST NOT** be alterable by any role, platform or tenant.

---

## 7.10 Business Rules

| ID | Rule |
|---|---|
| `BR-7.1` | Authorization is evaluated at every access decision, never captured at sign-in |
| `BR-7.2` | Authentication success confers no permission |
| `BR-7.3` | Absence of an explicit grant is refusal |
| `BR-7.4` | Permissions are granted by name and never derived |
| `BR-7.5` | Roles do not inherit from one another |
| `BR-7.6` | Every decision is evaluated with exactly one tenant in scope |
| `BR-7.7` | A tenant-scoped decision without a tenant is refused |
| `BR-7.8` | Only roles held in the active tenant are considered |
| `BR-7.9` | Deny always defeats allow |
| `BR-7.10` | Effective permissions are the union of held roles, less explicit denials |
| `BR-7.11` | A scoped permission cannot be exercised without naming its resource |
| `BR-7.12` | Read, Create, Update, Delete, Approve and Export are granted independently |
| `BR-7.13` | Approve and Export are never implied by another action |
| `BR-7.14` | The permission catalogue is closed |
| `BR-7.15` | An unrecognised permission is refused |
| `BR-7.16` | No account may assign a role to itself |
| `BR-7.17` | No account may assign permissions it does not hold |
| `BR-7.18` | Roles are assignable only to Active accounts |
| `BR-7.19` | A library always retains at least one Owner |
| `BR-7.20` | Temporary access requires two distinct accounts and terminates automatically |
| `BR-7.21` | Platform Support elevation never exceeds `CFG-12` |
| `BR-7.22` | Owner, Manager, Reception and both platform roles are invite-only |
| `BR-7.23` | Platform roles confer no access to tenant business data |
| `BR-7.24` | Tenant roles confer no platform authority |
| `BR-7.25` | Policy is platform-defined; no tenant may alter it |
| `BR-7.26` | Policy changes take effect at the next decision without re-authentication |
| `BR-7.27` | Roles asserted by a client or module are ignored |
| `BR-7.28` | A request cannot name its own tenant |
| `BR-7.29` | Denials are indistinguishable from non-existence |
| `BR-7.30` | Decisions are evaluated server-side only |
| `BR-7.31` | Every assignment, revocation, elevation, expiry and policy change emits an event |
| `BR-7.32` | Audit records are immutable to every role |
| `BR-7.33` | Where evaluation cannot complete, the outcome is denial |

---

## 7.11 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-7.1` | **Account holds several roles in one library** | Effective permissions are the union of grants, less explicit denials. A denial attached to any held role prevails |
| `XC-7.2` | **Account holds Reception and Manager in one library** | Union applies for operational permissions; the Reception denial on financial data still prevails, because deny defeats allow |
| `XC-7.3` | **Account switches library** | The prior context is discarded entirely. Permissions become exactly those of the new tenant. No residue survives |
| `XC-7.4` | **Permission revoked during an active session** | The next decision denies. The session remains authenticated |
| `XC-7.5` | **Role deleted from the model while accounts hold it** | Every assignment of that role ceases to grant anything. Holders fall to whatever remains, possibly nothing. No implicit substitution occurs |
| `XC-7.6` | **Temporary role expires mid-operation** | The next decision denies. No grace period, no auto-renewal, no completion of the in-flight action |
| `XC-7.7` | **Policy conflict — allow and deny both match** | Deny prevails, unconditionally |
| `XC-7.8` | **Two allow rules match at different scopes** | The narrower scope governs. Scopes narrow, never widen |
| `XC-7.9` | **Owner attempts self-removal as the last Owner** | Refused. Ownership must first be transferred |
| `XC-7.10` | **Owner removes themselves while another Owner exists** | Permitted. Effective immediately; the account keeps roles held elsewhere |
| `XC-7.11` | **Platform Support requires tenant access** | Elevation requested with tenant and purpose, approved by a distinct Platform Administrator, expiring at `CFG-12`. Every action attributed |
| `XC-7.12` | **Platform Support attempts to approve their own elevation** | Refused by separation of duties |
| `XC-7.13` | **Platform Administrator attempts to read tenant data without elevation** | Refused. Platform authority does not extend to tenant contents |
| `XC-7.14` | **Request names a tenant explicitly** | The named tenant is ignored; the active context governs. If none is active, the request is refused |
| `XC-7.15` | **Client asserts a role it does not hold** | Ignored. Roles resolve from platform state only |
| `XC-7.16` | **Unrecognised permission requested** | Refused, and recorded as anomalous |
| `XC-7.17` | **Scoped permission requested without a resource** | Refused. Never interpreted as applying to all resources |
| `XC-7.18` | **Account holds no role in the active tenant** | Every tenant-scoped decision denies. The account is authenticated and authorised for nothing |
| `XC-7.19` | **Library suspended while an account operates in it** | Every decision in that library denies. Roles are retained for reinstatement |
| `XC-7.20` | **Role granted during an active session** | Effective at the next decision. No re-authentication required |
| `XC-7.21` | **Policy changed while sessions are active** | Effective at the next decision, for every session, with no re-authentication |
| `XC-7.22` | **Manager attempts to assign Owner** | Refused — exceeds the assigner's own permissions |
| `XC-7.23` | **Role assignment to a suspended account** | Refused. Subjects must be Active |
| `XC-7.24` | **Parent attempts to view an unlinked student** | Refused, indistinguishably from the student not existing |
| `XC-7.25` | **Student attempts to view another student's record** | Refused by Self scope, indistinguishably from non-existence |
| `XC-7.26` | **Policy store unavailable** | Every decision denies. Fail closed, without exception for any role |

---

## 7.12 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-7.1` | Every access decision is evaluated at request time; no decision uses a role list captured at sign-in |
| `AC-7.2` | An authenticated account with no roles is denied every tenant-scoped action |
| `AC-7.3` | A tenant-scoped decision attempted with no active tenant is refused |
| `AC-7.4` | An account's roles in other libraries never alter a decision in the active library |
| `AC-7.5` | A permission not present in the closed catalogue is refused |
| `AC-7.6` | A newly introduced permission is unreachable by every role until explicitly granted |
| `AC-7.7` | An explicit deny defeats every combination of allow grants |
| `AC-7.8` | A Reception holder is denied financial permissions regardless of other roles held anywhere |
| `AC-7.9` | A scoped permission invoked without naming a resource is refused |
| `AC-7.10` | Self scope reaches only the acting account's own resources |
| `AC-7.11` | Linked scope reaches only explicitly linked subjects |
| `AC-7.12` | Granting Read confers no Create, Update, Delete, Approve or Export |
| `AC-7.13` | Export requires an explicit grant and is never implied |
| `AC-7.14` | Self-assignment is refused for every role at both scopes |
| `AC-7.15` | Assigning a role exceeding the assigner's own permissions is refused |
| `AC-7.16` | Assignment to a non-Active account is refused |
| `AC-7.17` | Removing a library's last Owner is refused |
| `AC-7.18` | Temporary access requested and approved by the same account is refused |
| `AC-7.19` | A Platform Support elevation is denied at the first decision after `CFG-12` elapses |
| `AC-7.20` | A platform role reads no tenant business data without an active elevation |
| `AC-7.21` | A role asserted by a client or module is ignored |
| `AC-7.22` | A tenant named in a request is ignored in favour of the active context |
| `AC-7.23` | Switching tenants yields exactly the new tenant's permissions, with no residue |
| `AC-7.24` | Role revocation denies the next decision while leaving the session authenticated |
| `AC-7.25` | A policy change takes effect at the next decision without re-authentication |
| `AC-7.26` | No tenant-level configuration can alter policy |
| `AC-7.27` | Denials are indistinguishable from the resource not existing, in content and shape |
| `AC-7.28` | Every assignment, revocation, elevation, expiry and policy change emits exactly one event |
| `AC-7.29` | Audit records cannot be altered by any role, including Platform Administrator |
| `AC-7.30` | An unavailable policy store results in denial for every decision, including platform roles |
| `AC-7.31` | No sequence of permitted actions yields a permission the account was not granted |
| `AC-7.32` | Decisions are unaffected by which module or interface originated the request |


---

# Chapter 8 — Security & Privacy

## 8.1 Purpose

### Why security matters in authentication

Authentication is the only point in Liboora at which an anonymous request becomes an identified one. Every access
decision made anywhere in the platform — attendance, seating, fees, memberships, reporting — rests on the claim that
the requester is who the session says they are. If that claim can be forged, weakened or replayed, no downstream
control has any value. A defect in attendance affects attendance. A defect in authentication affects everything.

This is amplified by two properties of the platform. First, a single account is global and may hold roles in several
libraries at once; compromising one account can therefore expose several tenants. Second, the sole first-version
factor is a one-time code delivered to a mobile number, which means the security of the entire platform is bounded by
the security of that one channel and by the discipline of the controls placed around it.

### Why privacy matters in authentication

Authentication necessarily handles the most identifying attribute the platform holds: a person's mobile number. It
also handles minors' data, because students at study halls are frequently under eighteen and are linked to parent
accounts. The obligation is therefore not merely regulatory but ethical: the platform must hold the minimum, use it
only for the purpose it was collected for, and never allow one library to learn about a person's relationship with
another.

Privacy in authentication is also a **tenancy** concern. The fact that a mobile number is registered at all, the fact
that it holds a role somewhere else, and the fact that it has ever attempted to sign in are each disclosures. This
chapter treats them as such.

### What this chapter establishes

This chapter defines the security objectives Authentication must meet, the categories of control it must apply, the
privacy principles that bound its handling of personal data, the threats it is required to withstand, and the
verifiable criteria by which all of this is judged.

### What this chapter does not do

It does not specify algorithms, ciphers, key lengths, libraries, storage layouts, transport configuration, rate-limit
data structures, or any other implementation matter. It states **what must be true**; engineering decides how.

| ID | Requirement |
|---|---|
| `AUTH-8.1` | Authentication MUST be designed and reviewed as a security-critical component, not as an ordinary product feature |
| `AUTH-8.2` | Every control in this chapter MUST be enforced server-side; no control MAY depend on client cooperation |
| `AUTH-8.3` | Security controls MUST fail closed; when a control cannot be evaluated, the request MUST be refused |
| `AUTH-8.4` | Privacy obligations MUST apply equally to all account holders, including staff and platform roles |

---

## 8.2 Security Objectives

The following objectives are the standard against which the rest of this chapter is measured.

| ID | Objective | Statement |
|---|---|---|
| `SO-1` | Identity assurance | A session MUST correspond to a person who demonstrated control of the registered mobile number |
| `SO-2` | Credential minimisation | The platform MUST hold no reusable secret capable of impersonating a user |
| `SO-3` | Containment | Compromise of one account, device, session or library MUST NOT propagate to another |
| `SO-4` | Tenant isolation | No security event, control or failure MUST allow one library to observe or affect another |
| `SO-5` | Non-enumeration | No response MUST allow an unauthenticated party to determine whether a mobile number is registered |
| `SO-6` | Abuse resistance | Automated and high-volume attacks MUST be made economically unattractive without denying service to legitimate users |
| `SO-7` | Revocability | Any access MUST be withdrawable immediately, globally and unilaterally |
| `SO-8` | Attributability | Every security-relevant action MUST be attributable to an account, a device and a moment in time |
| `SO-9` | Least privilege | Authentication MUST grant the narrowest access consistent with the verified identity and the active tenant |
| `SO-10` | Defensibility | Controls MUST remain effective when an attacker knows exactly how they work |

| ID | Requirement |
|---|---|
| `AUTH-8.5` | The security of Authentication MUST NOT depend on any control being secret |
| `AUTH-8.6` | No security objective MAY be relaxed by tenant configuration, commercial arrangement or support request |
| `AUTH-8.7` | Where objectives conflict, containment and tenant isolation MUST take precedence over convenience |

---

## 8.3 Authentication Security Controls

This section defines the categories of control Authentication MUST apply. Each is stated as an outcome.

### OTP protection

The one-time code is the only credential in the system and is treated accordingly.

| ID | Requirement |
|---|---|
| `AUTH-8.8` | An OTP MUST be valid for exactly one verification and MUST be consumed by the first verification attempt that presents it |
| `AUTH-8.9` | An OTP MUST expire after its validity window regardless of whether it was used, viewed or delivered |
| `AUTH-8.10` | At most one OTP challenge MAY be outstanding for a mobile number at any moment; issuing a new challenge MUST invalidate any previous one |
| `AUTH-8.11` | An OTP MUST be unpredictable and MUST NOT be derivable from the mobile number, the time, a sequence, or any other observable value |
| `AUTH-8.12` | An OTP MUST NOT be retrievable after issuance by any role, interface, log, event, report or support tool |
| `AUTH-8.13` | An OTP MUST NOT be displayed, echoed, pre-filled or transmitted anywhere other than to the registered mobile number |
| `AUTH-8.14` | Verification MUST compare in a manner that does not reveal how much of a submitted code was correct |
| `AUTH-8.15` | A challenge MUST be bound to the mobile number it was issued for and MUST NOT verify against any other number |

### Rate limiting

Rate limiting exists to bound the cost of abuse. It is applied at two independent levels so that neither can be
evaded by varying the other.

| ID | Requirement |
|---|---|
| `AUTH-8.16` | OTP requests for a single mobile number MUST be limited to `CFG-1` within a rolling one-hour window |
| `AUTH-8.17` | Consecutive OTP requests for a single mobile number MUST be separated by at least `CFG-2` |
| `AUTH-8.18` | OTP requests originating from a single source network origin MUST be limited to `CFG-3` within a rolling one-hour window |
| `AUTH-8.19` | Exhausting the per-number quota MUST place that number under a temporary lock lasting `CFG-4` |
| `AUTH-8.20` | Limits MUST be evaluated server-side against server time and MUST NOT be influenced by any client-supplied value |
| `AUTH-8.21` | Limits MUST apply identically to registered and unregistered numbers, so that limiting behaviour never reveals registration status |
| `AUTH-8.22` | A refusal caused by rate limiting MUST NOT reveal which limit was reached, the remaining quota, or the time of reset beyond a coarse retry indication |
| `AUTH-8.23` | Rate limiting MUST NOT be bypassable by any role, including platform roles |

### Brute-force protection

Rate limiting bounds requests. Brute-force protection bounds guesses.

| ID | Requirement |
|---|---|
| `AUTH-8.24` | A challenge MUST permit at most five verification attempts, after which it MUST be permanently invalidated |
| `AUTH-8.25` | An invalidated challenge MUST NOT be revivable by requesting a resend, changing device, or any other action |
| `AUTH-8.26` | Attempt counting MUST be server-side and MUST be per challenge, not per session or per device |
| `AUTH-8.27` | Repeated challenge exhaustion for one number within a short period MUST be treated as an attack signal and MUST emit a security event |
| `AUTH-8.28` | Failed verification MUST NOT distinguish between an expired challenge, an exhausted challenge, a consumed challenge and an incorrect code |

### Replay protection

| ID | Requirement |
|---|---|
| `AUTH-8.29` | A previously accepted OTP MUST NOT be accepted a second time under any circumstance |
| `AUTH-8.30` | A successful verification MUST NOT itself be sufficient to obtain a second session |
| `AUTH-8.31` | A session credential captured from one device MUST NOT function on another |
| `AUTH-8.32` | A terminated, expired or revoked session MUST NOT be resumable by re-presenting anything previously issued |
| `AUTH-8.33` | Retrying a request that was already applied MUST NOT produce a second effect |

### Session protection

| ID | Requirement |
|---|---|
| `AUTH-8.34` | A session credential MUST be unpredictable and MUST NOT encode the account, mobile number, tenant or role |
| `AUTH-8.35` | A session MUST be bound to one account, one device and one active library, and MUST be refused when presented outside that binding |
| `AUTH-8.36` | A session MUST be subject to both an idle boundary and an absolute boundary, and MUST end at whichever is reached first |
| `AUTH-8.37` | Session validity MUST be evaluated on every use; a session MUST NOT remain usable on the strength of an earlier evaluation |
| `AUTH-8.38` | A session MUST NOT carry authorization; authorization MUST be evaluated at the moment of each decision |
| `AUTH-8.39` | Session identifiers MUST NOT appear in any log, event payload, metric, error message, report or support interface |
| `AUTH-8.40` | Revocation MUST take effect at the next use of the session and MUST NOT depend on the client acknowledging it |

### Device verification

| ID | Requirement |
|---|---|
| `AUTH-8.41` | Every session MUST be associated with exactly one device record |
| `AUTH-8.42` | Device trust MUST be conferred only by successful interactive authentication from that device |
| `AUTH-8.43` | Device trust MUST expire after `CFG-7` and MUST be re-established only by authenticating again |
| `AUTH-8.44` | Device trust MUST NOT be grantable, extendable or transferable by any role, including platform roles |
| `AUTH-8.45` | First use of an unrecognised device MUST emit a security event and MUST notify the account holder |
| `AUTH-8.46` | Device removal MUST immediately terminate that device's sessions and revoke its trust |
| `AUTH-8.47` | A device identifier MUST NOT be treated as a credential and MUST NOT by itself authorise anything |

### Account protection

| ID | Requirement |
|---|---|
| `AUTH-8.48` | An account MUST be capable of being suspended, locked or disabled with immediate global effect |
| `AUTH-8.49` | An account under lock MUST NOT be able to obtain a new challenge or a new session for the duration of the lock |
| `AUTH-8.50` | Loss of identity validity MUST terminate every session on every device; loss of authorization MUST NOT |
| `AUTH-8.51` | An account holder MUST be able to view their active sessions and devices and terminate any of them without assistance |
| `AUTH-8.52` | An account holder MUST be notified of security-significant events affecting their account, including new-device sign-in, global sign-out, suspension and mobile number change |
| `AUTH-8.53` | Account protection actions MUST NOT be reversible by the party they were applied against |

### Secure logout

| ID | Requirement |
|---|---|
| `AUTH-8.54` | Sign-out MUST terminate the session server-side and MUST NOT rely on the client discarding state |
| `AUTH-8.55` | Sign-out MUST be available at all times, including while the account is suspended or locked |
| `AUTH-8.56` | Global sign-out MUST terminate every session on every device, including the one that requested it |
| `AUTH-8.57` | After sign-out, no cached authorization, tenant context or personal data MUST remain usable |
| `AUTH-8.58` | Sign-out MUST NOT remove the device record or revoke device trust unless explicitly requested |

---

## 8.4 Privacy Principles

| ID | Principle | Statement |
|---|---|---|
| `PP-1` | Purpose limitation | Personal data collected for authentication MUST be used only to authenticate, protect and notify the account holder |
| `PP-2` | Data minimisation | Authentication MUST collect only the mobile number and display name, and MUST NOT collect any further personal attribute |
| `PP-3` | Tenant confidentiality | A library MUST learn nothing about an account's existence, roles or activity in any other library |
| `PP-4` | No secondary use | Authentication data MUST NOT be used for marketing, profiling, ranking, scoring, resale or training |
| `PP-5` | Transparency | An account holder MUST be able to see what Authentication holds about them and where their identity is in use |
| `PP-6` | Individual control | An account holder MUST be able to end sessions, remove devices, change their number and request deletion |
| `PP-7` | Retention limitation | Personal data MUST be retained only while a defined purpose requires it, and MUST then be erased |
| `PP-8` | Minor protection | Data belonging to minors MUST receive the strictest treatment available and MUST NOT be exposed to any party other than the minor and their linked guardian |
| `PP-9` | Non-disclosure by inference | Responses, timings, errors and notifications MUST NOT disclose personal facts indirectly |
| `PP-10` | Accountability | Every access to personal data by a platform role MUST be attributable, time-bounded and recorded |

| ID | Requirement |
|---|---|
| `AUTH-8.59` | Authentication MUST hold exactly two personal attributes: the mobile number and the display name |
| `AUTH-8.60` | Authentication MUST NOT hold, request or infer date of birth, address, gender, photograph, government identifier, email address or payment detail |
| `AUTH-8.61` | Personal data held by Authentication MUST NOT be replicated into any other bounded context |
| `AUTH-8.62` | No privacy principle MAY be waived by tenant agreement, user consent prompt or support escalation |

---

## 8.5 Sensitive Data Protection

### Classification

| Class | Data | Treatment |
|---|---|---|
| **Credential** | OTP codes, session credentials, device trust markers | Never readable by any human or role; never logged; never exported |
| **Direct identifier** | Mobile number | Masked in all interfaces and events; visible in full only to the account holder |
| **Personal** | Display name | Visible within libraries where a role is held; never across libraries |
| **Behavioural** | Sign-in times, device names, session activity | Visible to the account holder; visible to a library only for that library's context |
| **Derived** | Security events, lock states, attempt counts | Never exposed to tenants; available to platform roles only under recorded, time-bounded access |

| ID | Requirement |
|---|---|
| `AUTH-8.63` | Credential-class data MUST NOT be retrievable in any form after issuance |
| `AUTH-8.64` | Mobile numbers MUST be masked by default in every interface, event payload, notification, report and support tool |
| `AUTH-8.65` | An account holder's full mobile number MUST be visible only to that account holder |
| `AUTH-8.66` | A library MUST see only the display name and masked number of accounts holding a role in that library |
| `AUTH-8.67` | Behavioural data MUST NOT be aggregated across libraries in any tenant-visible form |
| `AUTH-8.68` | Personal data MUST NOT appear in error messages, diagnostic output, crash reports or performance telemetry |
| `AUTH-8.69` | Bulk export of authentication personal data MUST NOT be available to any tenant role |
| `AUTH-8.70` | Platform-role access to personal data MUST require an explicit elevation bounded by `CFG-12` and MUST emit an event |
| `AUTH-8.71` | Data belonging to a minor MUST be visible only to that minor and their linked guardian, and to no tenant role beyond what a role assignment requires |

---

## 8.6 Threat Scenarios

Each scenario states the threat, the required posture, and the outcome the design must guarantee.

### SIM swap

An attacker persuades a mobile operator to reassign the victim's number to a new SIM, then requests an OTP.

| ID | Requirement |
|---|---|
| `AUTH-8.72` | The platform MUST assume the mobile channel can be captured and MUST NOT treat number control as proof of continued ownership |
| `AUTH-8.73` | Authentication from an unrecognised device MUST emit an event and notify the account holder, providing the earliest possible signal |
| `AUTH-8.74` | Existing sessions MUST NOT be terminated merely because a new device authenticated, so that a legitimate holder retains a channel to respond |
| `AUTH-8.75` | An account holder MUST be able to terminate all sessions and remove all devices without administrator assistance |
| `AUTH-8.76` | A mobile number change MUST require verification of the new number and MUST terminate every existing session |

### Lost device

The device is out of the holder's possession but no attacker is known to be active.

| ID | Requirement |
|---|---|
| `AUTH-8.77` | An account holder MUST be able to remove a device from any other device, immediately terminating its sessions and revoking its trust |
| `AUTH-8.78` | A removed device MUST be treated as unknown on next use and MUST require full authentication |
| `AUTH-8.79` | Device trust MUST expire on its own after `CFG-7` even if no action is taken |

### Stolen device

The device is in an adversary's possession and may hold an unexpired session.

| ID | Requirement |
|---|---|
| `AUTH-8.80` | Global sign-out MUST be available and MUST take effect at the next use of every session, on every device |
| `AUTH-8.81` | A stolen device holding a valid session MUST NOT be able to change the mobile number, remove other devices or elevate access without re-authentication |
| `AUTH-8.82` | A session MUST NOT be extendable beyond its absolute boundary by any activity |
| `AUTH-8.83` | Staff sessions MUST use the shorter idle and absolute boundaries, limiting exposure at shared reception devices |

### OTP interception

The code is observed in transit, on a lock screen, on a shared device, or via malware.

| ID | Requirement |
|---|---|
| `AUTH-8.84` | The validity window and single-use property MUST bound the value of an intercepted code |
| `AUTH-8.85` | An intercepted code MUST be useless once the legitimate holder has verified, because the challenge is consumed |
| `AUTH-8.86` | Successful verification MUST NOT by itself yield access; a session MUST additionally require a usable account and an established tenant context |
| `AUTH-8.87` | Interception MUST NOT be detectable as such by the attacker through any differential response |

### Session hijacking

A session credential is captured and replayed from another device.

| ID | Requirement |
|---|---|
| `AUTH-8.88` | A session presented from a device other than the one it was bound to MUST be refused and MUST emit a security event |
| `AUTH-8.89` | Session credentials MUST NOT be discoverable from logs, events, URLs, notifications or support tooling |
| `AUTH-8.90` | A refused hijack attempt MUST NOT reveal to the attacker why it failed |

### Replay attacks

Any previously valid message is resubmitted.

| ID | Requirement |
|---|---|
| `AUTH-8.91` | Every credential in Authentication MUST be single-use, time-bounded, or both |
| `AUTH-8.92` | Repeating a verification, a session issuance or a state transition MUST NOT produce a second effect |

### Insider misuse

A staff member, owner or platform operator abuses legitimate access.

| ID | Requirement |
|---|---|
| `AUTH-8.93` | No role MUST be able to authenticate as another account, impersonate, or obtain a session it did not authenticate for |
| `AUTH-8.94` | No role MUST be able to read, reset, resend to an alternate destination, or otherwise obtain an OTP |
| `AUTH-8.95` | No role MUST be able to assign itself a role or elevate its own access |
| `AUTH-8.96` | Platform-role access to tenant data MUST require explicit elevation, MUST be bounded by `CFG-12`, and MUST expire automatically |
| `AUTH-8.97` | Audit records MUST NOT be alterable or deletable by any role, including Platform Administrator |

### Unauthorized access

An unauthenticated or under-privileged party attempts a protected action.

| ID | Requirement |
|---|---|
| `AUTH-8.98` | Every protected action MUST require an authenticated session and an explicit permission grant |
| `AUTH-8.99` | Absence of a grant MUST result in denial; there MUST be no implicit, default or inherited permission |
| `AUTH-8.100` | A denial MUST be indistinguishable in content and shape from the resource not existing |

### Cross-tenant access attempts

An account holding roles in several libraries attempts to reach one library's data while operating in another.

| ID | Requirement |
|---|---|
| `AUTH-8.101` | Exactly one library MUST be active per session, and every tenant-scoped decision MUST be evaluated against it alone |
| `AUTH-8.102` | Roles held in other libraries MUST NOT influence any decision in the active library |
| `AUTH-8.103` | A tenant identifier supplied in a request MUST be ignored in favour of the established active context |
| `AUTH-8.104` | Switching libraries MUST discard all cached authorization and MUST establish the new context afresh |
| `AUTH-8.105` | A tenant-scoped decision attempted with no active library MUST be refused |

---

## 8.7 Security Business Rules

| ID | Rule |
|---|---|
| `BR-8.1` | The one-time code is the only credential in the platform; no password, PIN or recovery answer exists |
| `BR-8.2` | An OTP is single-use and is consumed by the first verification attempt that presents it |
| `BR-8.3` | An OTP expires after its validity window whether or not it was delivered or seen |
| `BR-8.4` | At most one challenge is outstanding per mobile number; a new challenge invalidates the previous one |
| `BR-8.5` | A challenge permits at most five verification attempts before permanent invalidation |
| `BR-8.6` | An invalidated challenge is never revived by resend, retry, device change or support action |
| `BR-8.7` | OTP requests per number are limited to `CFG-1` per rolling hour |
| `BR-8.8` | Consecutive requests for one number are separated by at least `CFG-2` |
| `BR-8.9` | OTP requests per source origin are limited to `CFG-3` per rolling hour |
| `BR-8.10` | Exhausting the per-number quota locks that number for `CFG-4` |
| `BR-8.11` | Rate limits apply identically to registered and unregistered numbers |
| `BR-8.12` | No role may bypass, raise, reset or waive any rate limit |
| `BR-8.13` | Failure responses do not distinguish expired, exhausted, consumed and incorrect codes |
| `BR-8.14` | Failure responses do not reveal whether a mobile number is registered |
| `BR-8.15` | No response timing, message, status or side effect discloses registration status |
| `BR-8.16` | Successful verification alone does not grant access; a session additionally requires a usable account and an established tenant context |
| `BR-8.17` | A session is bound to one account, one device and one active library |
| `BR-8.18` | A session presented outside its binding is refused and emits a security event |
| `BR-8.19` | Session validity is evaluated at every use, never cached |
| `BR-8.20` | Sessions carry no authorization; permissions are evaluated at each decision |
| `BR-8.21` | Revocation is immediate, global and independent of client cooperation |
| `BR-8.22` | Loss of identity validity ends all sessions; loss of authorization ends none |
| `BR-8.23` | Device trust arises only from interactive authentication on that device |
| `BR-8.24` | Device trust expires after `CFG-7` and is never granted, extended or transferred by a role |
| `BR-8.25` | Device removal immediately ends that device's sessions and revokes its trust |
| `BR-8.26` | First use of an unrecognised device emits an event and notifies the holder without blocking access |
| `BR-8.27` | An account holder may terminate any session and remove any device without assistance |
| `BR-8.28` | Sign-out is server-side and available even while suspended or locked |
| `BR-8.29` | Global sign-out ends every session including the requesting one |
| `BR-8.30` | No role may authenticate as, impersonate, or obtain a session belonging to another account |
| `BR-8.31` | No role may read, retrieve, reset or redirect an OTP |
| `BR-8.32` | No role may assign itself a role or elevate its own access |
| `BR-8.33` | Platform-role access to tenant data requires elevation bounded by `CFG-12` and emits an event |
| `BR-8.34` | Audit records are immutable for every role without exception |
| `BR-8.35` | Every security control fails closed when it cannot be evaluated |
| `BR-8.36` | No security control depends on its own secrecy |
| `BR-8.37` | Security controls are never weakened by tenant configuration or commercial arrangement |
| `BR-8.38` | All limits, expiries and boundaries are evaluated against server time |
| `BR-8.39` | Repeated challenge exhaustion for one number emits an attack signal |
| `BR-8.40` | Session and challenge identifiers never appear in any log, event, metric, error or report |

---

## 8.8 Privacy Business Rules

| ID | Rule |
|---|---|
| `BR-8.41` | Authentication holds exactly two personal attributes: mobile number and display name |
| `BR-8.42` | No further personal attribute is collected, inferred, derived or stored |
| `BR-8.43` | Personal data is used only to authenticate, protect and notify the account holder |
| `BR-8.44` | Personal data is never used for marketing, profiling, scoring, resale or model training |
| `BR-8.45` | Mobile numbers are masked by default in every interface, event, notification and report |
| `BR-8.46` | A full mobile number is visible only to the account holder it belongs to |
| `BR-8.47` | A library sees only the display name and masked number of accounts holding a role in that library |
| `BR-8.48` | A library never learns that an account holds a role in any other library |
| `BR-8.49` | A library never learns of authentication activity that occurred outside its own context |
| `BR-8.50` | Behavioural data is never aggregated across libraries in any tenant-visible form |
| `BR-8.51` | An account holder can see the libraries in which they hold roles, their devices and their sessions |
| `BR-8.52` | An account holder can end sessions, remove devices, change their number and request deletion |
| `BR-8.53` | Minor data is visible only to the minor and their linked guardian, plus what a role assignment strictly requires |
| `BR-8.54` | A guardian link confers visibility of the linked minor only, never of any other account |
| `BR-8.55` | Pending unverified data is retained no longer than `CFG-9` and is then discarded |
| `BR-8.56` | Soft-deleted account data is retained no longer than `CFG-10` and is then permanently erased |
| `BR-8.57` | Retention periods are never extended for commercial or analytical reasons |
| `BR-8.58` | Personal data never appears in error messages, diagnostics, crash reports or telemetry |
| `BR-8.59` | Bulk export of authentication personal data is unavailable to every tenant role |
| `BR-8.60` | Platform-role access to personal data is elevation-gated, time-bounded and recorded |
| `BR-8.61` | Authentication personal data is never replicated into another bounded context |
| `BR-8.62` | Notifications disclose no personal fact beyond what the recipient already knows |
| `BR-8.63` | No privacy rule is waivable by tenant agreement, consent prompt or support escalation |
| `BR-8.64` | Deletion of authentication identity does not require or cause deletion of tenant business records, and tenant records never reconstitute a deleted identity |

---

## 8.9 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-8.1` | OTP requested for a number that is not registered | Behaves identically to a registered number in message, timing and limits; no account is created until verification |
| `XC-8.2` | OTP requested repeatedly to discover registered numbers | Every response is identical; enumeration yields no information |
| `XC-8.3` | Correct OTP submitted after the challenge expired | Refused with the generic verification failure; not distinguishable from an incorrect code |
| `XC-8.4` | Correct OTP submitted after the challenge was consumed | Refused generically; no second session results |
| `XC-8.5` | Correct OTP submitted after five failed attempts | Refused; the challenge remains permanently invalid |
| `XC-8.6` | New OTP requested while a challenge is outstanding | Previous challenge invalidated; only the newest code can verify |
| `XC-8.7` | Per-number quota exhausted | Number locked for `CFG-4`; response reveals neither the limit nor the reset time precisely |
| `XC-8.8` | Origin quota exhausted while a legitimate user shares that origin | Refused with a retry indication; the user may proceed from another origin; no account penalty applied |
| `XC-8.9` | Attacker rotates origins to evade the origin limit | Per-number limits continue to apply independently and bound the attack |
| `XC-8.10` | Attacker rotates numbers to evade per-number limits | Origin limit continues to apply independently and bounds the attack |
| `XC-8.11` | Verification succeeds but the account holds no library role | No session is issued; the outcome is identical to any other non-usable state |
| `XC-8.12` | Verification succeeds for a suspended account | No session is issued; the response does not disclose suspension to an unverified party |
| `XC-8.13` | Session credential replayed from a second device | Refused; security event emitted; the original session remains valid |
| `XC-8.14` | Session presented after global sign-out | Refused at first use; no grace period applies |
| `XC-8.15` | Session presented after the absolute boundary despite constant activity | Refused; activity never extends the absolute boundary |
| `XC-8.16` | Device trust expires mid-session | The active session continues; the next authentication requires full verification |
| `XC-8.17` | Device removed while that device holds an active session | Session terminated at next use; trust revoked immediately |
| `XC-8.18` | Account holder removes the device they are currently using | Permitted; the current session terminates and the device becomes unknown |
| `XC-8.19` | Number reassigned by the operator to a different person | New holder must complete verification and receives no access to the prior account's history beyond what the account itself contains; prior holder's remedy is number change and global sign-out |
| `XC-8.20` | Mobile number change requested while other sessions are active | Requires verification of the new number; on success every session terminates |
| `XC-8.21` | Two accounts attempt to register the same mobile number | The number resolves to exactly one account; the second attempt authenticates into the existing account rather than creating a duplicate |
| `XC-8.22` | Staff member attempts to view a student's full mobile number | Refused; only the masked form is available |
| `XC-8.23` | Owner attempts to export member contact details from Authentication | Refused; Authentication provides no bulk personal-data export to tenants |
| `XC-8.24` | Owner attempts to discover whether a member also attends another library | Refused; no interface, event or error discloses cross-library role holding |
| `XC-8.25` | Platform Support views tenant data without elevation | Refused; access requires explicit elevation |
| `XC-8.26` | Platform Support elevation reaches `CFG-12` mid-task | Access denied at the next decision; the task must be re-elevated |
| `XC-8.27` | Platform Administrator attempts to alter or delete an audit record | Refused; audit records are immutable for all roles |
| `XC-8.28` | Platform role attempts to grant itself device trust for another account | Refused; trust arises only from interactive authentication on the device |
| `XC-8.29` | Support asked to read a user's OTP to help them sign in | Refused; no interface exposes an OTP to any role |
| `XC-8.30` | Guardian attempts to view a linked minor's device list | Refused unless the minor's own account grants it; guardian linkage does not confer device management |
| `XC-8.31` | Minor's display name requested by a library where the minor holds no role | Refused; visibility follows role holding |
| `XC-8.32` | Rate-limit store unavailable | Requests are refused rather than admitted unlimited; the control fails closed |
| `XC-8.33` | Policy or session store unavailable | Every decision is denied, including for platform roles |
| `XC-8.34` | Clock skew between client and server | Server time governs exclusively; client time is never consulted |
| `XC-8.35` | Deletion requested while the account is the last Owner of a library | Deletion of identity is refused until ownership is transferred; the refusal states the obligation without disclosing other libraries |
| `XC-8.36` | Deleted account's number used to register again within the retention window | Treated as a new registration; no prior personal data is restored or disclosed |

---

## 8.10 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-8.1` | An OTP verifies exactly once; a second presentation of the same code always fails |
| `AC-8.2` | An OTP fails after its validity window regardless of correctness |
| `AC-8.3` | Issuing a new challenge renders the previous code unusable |
| `AC-8.4` | A sixth verification attempt on one challenge fails and the challenge cannot be revived |
| `AC-8.5` | No interface, log, event, metric or support tool returns an OTP value |
| `AC-8.6` | Expired, exhausted, consumed and incorrect codes produce indistinguishable failures |
| `AC-8.7` | A request beyond `CFG-1` within one hour is refused |
| `AC-8.8` | A request sooner than `CFG-2` after the previous one is refused |
| `AC-8.9` | Requests beyond `CFG-3` from one origin within one hour are refused |
| `AC-8.10` | Quota exhaustion locks the number and the lock persists for `CFG-4` |
| `AC-8.11` | Registered and unregistered numbers produce identical responses in content, shape and timing |
| `AC-8.12` | No role can raise, reset, waive or bypass any rate limit |
| `AC-8.13` | Verification alone produces no session when the account is unusable or no tenant context exists |
| `AC-8.14` | A session presented from a different device is refused and emits a security event |
| `AC-8.15` | A revoked session is refused at its next use with no grace period |
| `AC-8.16` | A session is refused once either the idle or absolute boundary is reached |
| `AC-8.17` | Continuous activity never extends a session past its absolute boundary |
| `AC-8.18` | Session identifiers appear in no log, event, metric, error or report |
| `AC-8.19` | Sessions confer no permission; every decision is evaluated independently |
| `AC-8.20` | Device trust cannot be created, extended or transferred by any role |
| `AC-8.21` | Device trust expires after `CFG-7` without any action |
| `AC-8.22` | Device removal terminates that device's sessions and revokes trust immediately |
| `AC-8.23` | First authentication from an unrecognised device emits an event and notifies the holder |
| `AC-8.24` | Global sign-out terminates every session including the requesting one |
| `AC-8.25` | Sign-out succeeds while the account is suspended or locked |
| `AC-8.26` | No role can impersonate an account or obtain a session it did not authenticate for |
| `AC-8.27` | No role can assign itself a role or elevate its own access |
| `AC-8.28` | Platform-role access without elevation is refused |
| `AC-8.29` | Platform-role elevation is denied at the first decision after `CFG-12` elapses |
| `AC-8.30` | Every elevation emits an event identifying the actor, the scope and the moment |
| `AC-8.31` | No role, including Platform Administrator, can alter or delete an audit record |
| `AC-8.32` | Authentication stores no personal attribute other than mobile number and display name |
| `AC-8.33` | Full mobile numbers are visible only to the account holder |
| `AC-8.34` | Mobile numbers are masked in every event payload and notification |
| `AC-8.35` | A library can retrieve no information about an account's roles in any other library |
| `AC-8.36` | No tenant role can bulk-export authentication personal data |
| `AC-8.37` | Personal data appears in no error message, diagnostic output or telemetry record |
| `AC-8.38` | Unverified pending data is unavailable after `CFG-9` |
| `AC-8.39` | Soft-deleted personal data is unrecoverable after `CFG-10` |
| `AC-8.40` | A minor's data is unreachable by any party other than the minor, their linked guardian, and roles strictly requiring it |
| `AC-8.41` | Unavailability of the rate-limit, policy or session store results in refusal, never in unrestricted access |
| `AC-8.42` | Every limit, expiry and boundary is enforced against server time and is unaffected by client-supplied values |
| `AC-8.43` | Denials are indistinguishable from the resource not existing |
| `AC-8.44` | No security or privacy control can be weakened by tenant configuration or support action |


---

# Chapter 9 — Account Lifecycle

## 9.1 Purpose

### Why a lifecycle is specified

An account is not a static record. It comes into existence, becomes usable, may lose and regain usability, may be
withdrawn from service temporarily or permanently, and may have its single identifying attribute replaced. Each of
these moments changes what the holder can do and what the platform must permit. If those moments are not defined
precisely, the same account can be interpreted differently by different parts of the platform, and access decisions
become inconsistent.

The lifecycle also determines the **security posture** of an account. A suspended account that can still obtain a
session is a defect. A deleted account whose data can be recovered by re-registering the same number is a privacy
breach. A number change that leaves old sessions alive defeats the primary remedy for a compromised SIM. The
lifecycle is therefore a security specification as much as a product one.

### The single-owner rule

Account state is owned exclusively by Authentication. No library, no business module and no external system may hold
its own notion of whether an account is usable. Modules may hold their own **membership** state — whether a student
is enrolled, active, on hold or discontinued at a particular library — but that is a different concept and must never
be conflated with account state. A student may be discontinued at every library and still hold a perfectly valid
account; an account may be suspended while every membership remains active.

### Global state, tenant-scoped participation

Because one account spans many libraries, account state is **global**. Suspension applies everywhere. Deletion
applies everywhere. A library cannot suspend an account; it can only remove the roles it granted. This distinction is
the single most important idea in this chapter and is enforced throughout.

| ID | Requirement |
|---|---|
| `AUTH-9.1` | Account state MUST be owned solely by Authentication and MUST NOT be duplicated, cached authoritatively, or overridden by any other context |
| `AUTH-9.2` | Account state MUST be global; it MUST NOT vary by library |
| `AUTH-9.3` | Account state MUST be distinct from membership state, and the two MUST NOT be conflated in any decision |
| `AUTH-9.4` | No tenant role MUST be able to change account state; tenant roles MAY only grant or revoke roles within their own library |
| `AUTH-9.5` | Every state and every transition MUST be explicit; there MUST be no implicit or undefined state |

---

## 9.2 Account States

An account is in exactly one state at any moment.

| State | Meaning | Can authenticate | Can obtain a session | Holds data |
|---|---|---|---|---|
| **Pending Verification** | A registration or claim was begun but the mobile number has not yet been verified | Yes, to complete verification | No | Provisional only |
| **Active** | Verified and usable | Yes | Yes, subject to holding a role | Yes |
| **Inactive** | Verified and usable but currently holds no role in any library | Yes | No | Yes |
| **Locked** | Temporarily barred following abuse-protection triggers | No | No | Yes |
| **Suspended** | Administratively barred pending review or resolution | No | No | Yes |
| **Disabled** | Permanently barred by platform decision | No | No | Yes |
| **Pending Deletion** | Deletion requested; within the retention window and reversible | No | No | Yes, retained |
| **Deleted** | Permanently erased; the account no longer exists | No | No | No |

### State definitions

**Pending Verification** — the interval between beginning registration and proving control of the mobile number. No
account exists in any durable sense; the display name and number are provisional. This state is time-bounded and
self-clearing.

**Active** — the normal state. The account is verified and holds at least one role in at least one library. This is
the only state in which a session may be issued.

**Inactive** — verified but role-less. The account exists, its identity is valid, and the holder can authenticate,
but there is nothing for them to enter. This arises when every role has been revoked, every membership has ended, or
an account was created but never linked to a library. It is not a punishment and carries no stigma; it is simply the
absence of anywhere to go.

**Locked** — an automatic, temporary state produced by abuse-protection controls, principally exhaustion of the OTP
request quota. It clears itself after `CFG-4`. It is not an administrative judgement and requires no human action.

**Suspended** — a deliberate, reversible administrative bar applied by a platform role. It persists until explicitly
lifted. It is used where wrongdoing is suspected, a dispute is unresolved, or a security incident is under
investigation.

**Disabled** — a deliberate, permanent administrative bar. It is used where the platform has concluded the account
must not be used again but where records must be preserved. It is not deletion and does not erase anything.

**Pending Deletion** — deletion has been requested and accepted. The account is immediately unusable, but the data
survives for `CFG-10` so that an erroneous or coerced request can be undone. This state is one-way in the sense that
it either reverts to Active or proceeds to Deleted; it never becomes Suspended, Locked or Inactive.

**Deleted** — terminal. Personal data has been erased. The mobile number is released for future registration. The
account cannot be recovered, and re-registering the same number produces an entirely new account with no history.

| ID | Requirement |
|---|---|
| `AUTH-9.6` | An account MUST be in exactly one state at any moment |
| `AUTH-9.7` | A session MUST be issuable only from the Active state |
| `AUTH-9.8` | Authentication MUST be permitted only in Pending Verification, Active and Inactive; every other state MUST refuse it |
| `AUTH-9.9` | Locked MUST be automatic and self-clearing; it MUST NOT require or accept administrative intervention to lift |
| `AUTH-9.10` | Suspended MUST be reversible only by a platform role |
| `AUTH-9.11` | Disabled MUST be permanent and MUST NOT be reversible to Active |
| `AUTH-9.12` | Deleted MUST be terminal and MUST NOT be reversible by any means |
| `AUTH-9.13` | Inactive MUST NOT be treated as a fault, a penalty or a security signal |

---

## 9.3 Lifecycle Transitions

### Valid transitions

| From | To | Trigger |
|---|---|---|
| *(none)* | Pending Verification | Registration or claim begun |
| Pending Verification | Active | Mobile number verified and at least one role exists or is granted |
| Pending Verification | Inactive | Mobile number verified but no role exists |
| Pending Verification | *(discarded)* | `CFG-9` elapsed without verification |
| Active | Inactive | Last remaining role revoked |
| Inactive | Active | A role granted in any library |
| Active | Locked | Abuse-protection quota exhausted |
| Inactive | Locked | Abuse-protection quota exhausted |
| Locked | Active | `CFG-4` elapsed and at least one role held |
| Locked | Inactive | `CFG-4` elapsed and no role held |
| Active | Suspended | Platform role suspends |
| Inactive | Suspended | Platform role suspends |
| Locked | Suspended | Platform role suspends |
| Suspended | Active | Platform role lifts suspension and at least one role held |
| Suspended | Inactive | Platform role lifts suspension and no role held |
| Active | Disabled | Platform role disables |
| Inactive | Disabled | Platform role disables |
| Locked | Disabled | Platform role disables |
| Suspended | Disabled | Platform role disables |
| Active | Pending Deletion | Holder requests deletion, or platform role initiates it |
| Inactive | Pending Deletion | Holder requests deletion, or platform role initiates it |
| Suspended | Pending Deletion | Platform role initiates deletion |
| Disabled | Pending Deletion | Platform role initiates deletion |
| Pending Deletion | Active | Holder cancels within `CFG-10` and at least one role held |
| Pending Deletion | Inactive | Holder cancels within `CFG-10` and no role held |
| Pending Deletion | Deleted | `CFG-10` elapsed |

### Invalid transitions

These are stated explicitly so that they can be tested as prohibitions rather than merely omitted.

| From | To | Why prohibited |
|---|---|---|
| *(none)* | Active | An account never exists without prior verification |
| Pending Verification | Locked | Abuse protection acts on the mobile number, not on a not-yet-existent account |
| Pending Verification | Suspended | There is no account to suspend |
| Pending Verification | Disabled | There is no account to disable |
| Pending Verification | Pending Deletion | Nothing durable exists to delete; the record is discarded instead |
| Locked | Locked | A lock is not extendable by further attempts; it runs its fixed course |
| Disabled | Active | Disablement is permanent by definition |
| Disabled | Inactive | Disablement is permanent by definition |
| Disabled | Suspended | A weaker state cannot follow a stronger permanent one |
| Disabled | Locked | Abuse protection is meaningless for an account that cannot authenticate |
| Suspended | Locked | The account already cannot authenticate; locking adds nothing and would mask the suspension |
| Pending Deletion | Suspended | Deletion supersedes; suspension would obscure the pending erasure |
| Pending Deletion | Disabled | Deletion supersedes |
| Pending Deletion | Locked | The account cannot authenticate, so abuse protection cannot trigger |
| Deleted | *(any)* | Terminal |
| *(any)* | Pending Verification | Verification is not repeatable for an existing account |

| ID | Requirement |
|---|---|
| `AUTH-9.14` | Every transition MUST be one of those listed as valid; any other transition MUST be refused |
| `AUTH-9.15` | A refused transition MUST leave the account in its existing state with no partial effect |
| `AUTH-9.16` | Every transition MUST emit exactly one state-change event |
| `AUTH-9.17` | Every transition MUST record the actor, the reason where one applies, and the moment |
| `AUTH-9.18` | Transitions between Active and Inactive MUST occur automatically as roles are granted and revoked, without administrative action |
| `AUTH-9.19` | A transition into any state that bars authentication MUST terminate every session on every device immediately |
| `AUTH-9.20` | A transition out of a barring state MUST NOT restore any previously terminated session |
| `AUTH-9.21` | Concurrent transition requests MUST be serialised; the account MUST NOT occupy two states or apply two transitions simultaneously |
| `AUTH-9.22` | A Pending Verification record MUST be discarded after `CFG-9` and MUST leave no trace recoverable by any role |

---

## 9.4 Suspension & Recovery

### Suspension

Suspension is the platform's reversible remedy. It is deliberately blunt: it stops all access everywhere, because a
security or conduct concern about an identity is not confined to one library.

| ID | Requirement |
|---|---|
| `AUTH-9.23` | Suspension MUST be applicable only by a platform role |
| `AUTH-9.24` | Suspension MUST apply globally across every library in which the account holds roles |
| `AUTH-9.25` | Suspension MUST take effect immediately and MUST terminate every session on every device |
| `AUTH-9.26` | A suspended account MUST NOT obtain an OTP challenge, complete verification, or receive a session |
| `AUTH-9.27` | Suspension MUST require a recorded reason |
| `AUTH-9.28` | Suspension MUST preserve all roles, links and device records so that lifting it restores the prior position exactly |
| `AUTH-9.29` | The account holder MUST be notified that access has been suspended |
| `AUTH-9.30` | A notification of suspension MUST NOT disclose investigative detail, the reporting party, or any other account |
| `AUTH-9.31` | A tenant role MUST NOT be able to suspend, and MUST NOT be able to observe that suspension is the cause of an account's absence |

### Locking

| ID | Requirement |
|---|---|
| `AUTH-9.32` | Locking MUST arise only from abuse-protection controls and MUST NOT be applied manually |
| `AUTH-9.33` | A lock MUST last exactly `CFG-4` and MUST clear automatically |
| `AUTH-9.34` | A lock MUST NOT be extendable by further attempts during the lock period |
| `AUTH-9.35` | A lock MUST NOT be liftable early by any role, including platform roles |
| `AUTH-9.36` | A lock MUST NOT terminate existing sessions, because it bars new authentication rather than existing access |
| `AUTH-9.37` | The holder MUST be able to determine that they must wait, without being told the precise remaining duration |

### Recovery

| ID | Requirement |
|---|---|
| `AUTH-9.38` | Lifting a suspension MUST be performable only by a platform role and MUST require a recorded reason |
| `AUTH-9.39` | Lifting a suspension MUST return the account to Active if any role is held, or Inactive if none is |
| `AUTH-9.40` | Recovery MUST restore roles and links exactly as they stood at suspension, less any revoked in the interim by their granting library |
| `AUTH-9.41` | Recovery MUST NOT restore terminated sessions; the holder MUST authenticate afresh |
| `AUTH-9.42` | Recovery MUST NOT restore device trust that expired during the suspension |
| `AUTH-9.43` | The holder MUST be notified that access has been restored |
| `AUTH-9.44` | There MUST be no self-service route out of suspension |
| `AUTH-9.45` | Recovery from Disabled MUST NOT exist; an account requiring renewed access MUST be created afresh |

---

## 9.5 Account Deletion

### Principles

Deletion serves a right, not a workflow. It must be genuine — the data must actually go — and it must be reversible
for long enough to protect a person who acted in error or under pressure. It must also not destroy the tenant's
lawful business records, which are owned by other contexts and are not the platform's to erase.

| ID | Requirement |
|---|---|
| `AUTH-9.46` | An account holder MUST be able to request deletion of their own account without administrative assistance |
| `AUTH-9.47` | A deletion request MUST require the holder to be authenticated at the moment of the request |
| `AUTH-9.48` | Deletion MUST move the account to Pending Deletion immediately and MUST terminate every session on every device |
| `AUTH-9.49` | A Pending Deletion account MUST NOT authenticate, obtain a session, or appear as an available member to any library |
| `AUTH-9.50` | Pending Deletion MUST persist for `CFG-10`, during which the holder MAY cancel |
| `AUTH-9.51` | Cancellation MUST be available only to the account holder and MUST require re-verification of the mobile number |
| `AUTH-9.52` | After `CFG-10`, personal data held by Authentication MUST be permanently erased |
| `AUTH-9.53` | Erasure MUST be irreversible; no role, backup restoration or support procedure MUST be able to reconstitute the account |
| `AUTH-9.54` | Erasure MUST remove the mobile number and display name, and MUST release the mobile number for future registration |
| `AUTH-9.55` | Erasure MUST remove all device records, device trust and session records associated with the account |
| `AUTH-9.56` | Erasure MUST revoke every role assignment in every library and MUST notify each affected library that the member is no longer available |
| `AUTH-9.57` | Audit records MUST survive erasure in a form that retains the fact and timing of actions while no longer identifying the person |
| `AUTH-9.58` | Deletion MUST NOT delete, alter or invalidate business records owned by other contexts |
| `AUTH-9.59` | Business records surviving deletion MUST NOT be capable of reconstituting the deleted identity |
| `AUTH-9.60` | Re-registration of the same mobile number after erasure MUST produce an entirely new account with no prior roles, devices, links or history |

### Constraints on deletion

| ID | Requirement |
|---|---|
| `AUTH-9.61` | Deletion MUST be refused while the account is the sole Owner of any library |
| `AUTH-9.62` | A refusal under `AUTH-9.61` MUST state the obligation to transfer ownership without naming or enumerating any library the requester cannot already see |
| `AUTH-9.63` | A platform role MAY initiate deletion; a tenant role MUST NOT |
| `AUTH-9.64` | Platform-initiated deletion MUST require a recorded reason and MUST notify the holder |
| `AUTH-9.65` | Deletion MUST NOT be used as a substitute for suspension or disablement in disciplinary situations |

---

## 9.6 Mobile Number Change

### Why this is a security operation

The mobile number is the sole credential channel. Changing it changes who can authenticate as this account. It is
therefore treated with the same rigour as authentication itself, not as a profile edit.

### Requirements

| ID | Requirement |
|---|---|
| `AUTH-9.66` | A mobile number change MUST be initiated only by the account holder while authenticated |
| `AUTH-9.67` | A change MUST require successful verification of the **new** number before it takes effect |
| `AUTH-9.68` | A change MUST require successful verification of the **current** number at initiation, where the holder still controls it |
| `AUTH-9.69` | Where the current number is no longer controllable, the change MUST NOT proceed self-service; it MUST require a platform-role-assisted procedure with a recorded reason |
| `AUTH-9.70` | A change MUST be refused if the new number already resolves to another account in any state other than Deleted |
| `AUTH-9.71` | A change MUST take effect atomically; the account MUST NOT be reachable by both numbers at any moment |
| `AUTH-9.72` | On success, every session on every device MUST be terminated, including the session that requested the change |
| `AUTH-9.73` | On success, all device trust MUST be revoked; devices MUST be treated as unknown at next use |
| `AUTH-9.74` | On success, the account identity MUST remain the same; roles, links, history and memberships MUST be preserved unchanged |
| `AUTH-9.75` | The old number MUST be released and MUST become available for a future, entirely separate registration |
| `AUTH-9.76` | Both the old and the new number MUST be notified of the change, so far as delivery to the old number remains possible |
| `AUTH-9.77` | A change MUST emit an event and MUST be recorded with actor, both masked numbers and the moment |
| `AUTH-9.78` | A change MUST be refused while the account is Locked, Suspended, Disabled, Pending Deletion or Deleted |
| `AUTH-9.79` | No tenant role MUST be able to change, or request a change to, any account's mobile number |
| `AUTH-9.80` | The display name MUST be unaffected by a number change |

---

## 9.7 Business Rules

| ID | Rule |
|---|---|
| `BR-9.1` | An account occupies exactly one state at any moment |
| `BR-9.2` | Account state is global and never varies by library |
| `BR-9.3` | Account state is owned by Authentication alone |
| `BR-9.4` | Account state and membership state are separate and are never conflated |
| `BR-9.5` | A session is issued only from the Active state |
| `BR-9.6` | Authentication is permitted only in Pending Verification, Active and Inactive |
| `BR-9.7` | Only transitions listed as valid may occur; all others are refused |
| `BR-9.8` | A refused transition produces no partial effect |
| `BR-9.9` | Every transition emits exactly one state-change event |
| `BR-9.10` | Every transition records actor, reason where applicable, and moment |
| `BR-9.11` | Active and Inactive interchange automatically with role grant and revocation |
| `BR-9.12` | Any transition into a barring state terminates all sessions immediately |
| `BR-9.13` | Leaving a barring state never restores a terminated session |
| `BR-9.14` | Concurrent transitions are serialised |
| `BR-9.15` | Pending Verification is discarded after `CFG-9` and leaves no recoverable trace |
| `BR-9.16` | Locking is automatic, lasts `CFG-4`, and clears itself |
| `BR-9.17` | A lock cannot be extended, shortened or lifted by any role |
| `BR-9.18` | A lock bars new authentication but does not terminate existing sessions |
| `BR-9.19` | Suspension is applied and lifted only by a platform role and always requires a reason |
| `BR-9.20` | Suspension applies globally and terminates all sessions |
| `BR-9.21` | Suspension preserves roles, links and devices |
| `BR-9.22` | A tenant role can neither suspend an account nor observe that an account is suspended |
| `BR-9.23` | Disablement is permanent and never returns to Active or Inactive |
| `BR-9.24` | There is no self-service exit from suspension or disablement |
| `BR-9.25` | Deletion is requestable by the holder while authenticated, and by a platform role with a reason |
| `BR-9.26` | Deletion is never requestable by a tenant role |
| `BR-9.27` | Deletion moves the account to Pending Deletion immediately and terminates all sessions |
| `BR-9.28` | Pending Deletion lasts `CFG-10` and is cancellable only by the holder, with re-verification |
| `BR-9.29` | After `CFG-10`, personal data is permanently and irreversibly erased |
| `BR-9.30` | Erasure releases the mobile number for future registration |
| `BR-9.31` | Erasure revokes every role in every library and notifies each affected library |
| `BR-9.32` | Audit records survive erasure without identifying the person |
| `BR-9.33` | Deletion never removes or alters records owned by other contexts |
| `BR-9.34` | Surviving business records can never reconstitute a deleted identity |
| `BR-9.35` | Re-registration after erasure yields a wholly new account with no history |
| `BR-9.36` | Deletion is refused while the account is a library's sole Owner |
| `BR-9.37` | A mobile number change requires verification of the new number, and of the current number where controllable |
| `BR-9.38` | A number change is refused if the new number already resolves to a non-Deleted account |
| `BR-9.39` | A number change is atomic; both numbers are never simultaneously valid |
| `BR-9.40` | A number change terminates all sessions and revokes all device trust |
| `BR-9.41` | A number change preserves account identity, roles, links and history |
| `BR-9.42` | A number change is refused in Locked, Suspended, Disabled, Pending Deletion and Deleted |
| `BR-9.43` | No tenant role may change or request a change to any mobile number |
| `BR-9.44` | Every lifecycle change that affects the holder's access results in a notification to the holder |

---

## 9.8 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-9.1` | Registration abandoned before verification | Record discarded after `CFG-9`; no account ever existed; the number is immediately reusable |
| `XC-9.2` | Verification completed but no library role exists | Account becomes Inactive, not Active; authentication succeeds but no session is issued |
| `XC-9.3` | Last role revoked while the holder has an active session | Account becomes Inactive; the existing session continues until a tenant-scoped decision fails; identity remains valid |
| `XC-9.4` | Role granted to an Inactive account | Account becomes Active automatically with no administrative action |
| `XC-9.5` | Role granted while the account is Suspended | Assignment is refused; suspension must be lifted first |
| `XC-9.6` | Lock triggered while the holder has an active session | Session continues; only new authentication is barred |
| `XC-9.7` | Further OTP requests during a lock | Refused; the lock is not extended by them |
| `XC-9.8` | Platform role attempts to lift a lock early | Refused; locks are not administratively controllable |
| `XC-9.9` | Suspension applied while the holder is mid-verification | Verification completes but no session is issued; the outcome is indistinguishable from other non-usable states |
| `XC-9.10` | Suspension applied to an account holding roles in five libraries | All five lose access simultaneously; none is told why |
| `XC-9.11` | Suspension lifted after a library independently revoked its role | Account returns with the remaining roles only; the revoked role is not restored |
| `XC-9.12` | Suspension lifted after every role was revoked in the interim | Account returns to Inactive, not Active |
| `XC-9.13` | Disablement applied to a suspended account | Permitted; the account becomes permanently barred |
| `XC-9.14` | Attempt to reactivate a Disabled account | Refused; a new account must be created |
| `XC-9.15` | Deletion requested by an account that is sole Owner of one library | Refused with a statement of the ownership-transfer obligation |
| `XC-9.16` | Deletion requested by an account that is sole Owner of one library and Student at another | Refused; the refusal does not reveal the second library |
| `XC-9.17` | Deletion cancelled on the final day of `CFG-10` | Permitted; account returns to Active or Inactive according to roles held |
| `XC-9.18` | Deletion cancellation attempted after `CFG-10` | Refused; erasure has occurred and is irreversible |
| `XC-9.19` | Cancellation attempted by a platform role on the holder's behalf | Refused; only the holder may cancel |
| `XC-9.20` | A library attempts to view a Pending Deletion member | Member is not available; the library is not told deletion is the cause |
| `XC-9.21` | Same number registered again during another account's `CFG-10` window | Refused while the number remains bound; permitted once erasure completes, producing a new account |
| `XC-9.22` | Same number registered again after erasure | Wholly new account; no roles, devices, links or history are restored |
| `XC-9.23` | Number change requested to a number already held by an Active account | Refused |
| `XC-9.24` | Number change requested to a number held by a Deleted account | Permitted; the number was released on erasure |
| `XC-9.25` | Number change where the new number's verification is abandoned | No change occurs; the old number remains in force; the account is unaffected |
| `XC-9.26` | Number change where the current number is no longer reachable | Self-service route refused; platform-assisted procedure with recorded reason is required |
| `XC-9.27` | Number change completed while five sessions are active elsewhere | All five terminate, as does the requesting session; every device is untrusted |
| `XC-9.28` | Number change attempted while the account is Locked | Refused |
| `XC-9.29` | Number change attempted while Pending Deletion | Refused |
| `XC-9.30` | Two number-change requests submitted concurrently | Serialised; at most one takes effect; the other is refused against the changed state |
| `XC-9.31` | Suspension and deletion requested concurrently | Serialised; whichever applies first governs, and the second is evaluated against the resulting state |
| `XC-9.32` | Role revocation and account deletion occur in the same interval | Both apply; the resulting state reflects deletion, which supersedes |
| `XC-9.33` | Library deleted while accounts hold roles in it | Those roles are revoked; affected accounts become Inactive if no other role remains |
| `XC-9.34` | Holder attempts to determine why access stopped | Told only that access is unavailable and how to contact support; no state, reason or party is disclosed |
| `XC-9.35` | Audit query for a deleted account | Returns the actions and their timing without identifying the person |
| `XC-9.36` | Backup restored to a point before an erasure | Erasure must be re-applied; a restored backup must never resurrect an erased identity |

---

## 9.9 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-9.1` | An account is always in exactly one of the eight defined states |
| `AC-9.2` | Account state is identical when observed from any library |
| `AC-9.3` | No context other than Authentication can change account state |
| `AC-9.4` | A session is issued only from Active |
| `AC-9.5` | Authentication is refused in Locked, Suspended, Disabled, Pending Deletion and Deleted |
| `AC-9.6` | Every transition listed as invalid is refused |
| `AC-9.7` | A refused transition leaves the prior state wholly intact |
| `AC-9.8` | Every accepted transition emits exactly one state-change event |
| `AC-9.9` | Every accepted transition records actor, reason where applicable, and moment |
| `AC-9.10` | Revoking the last role moves the account to Inactive without administrative action |
| `AC-9.11` | Granting any role moves an Inactive account to Active without administrative action |
| `AC-9.12` | Any transition into a barring state terminates every session on every device |
| `AC-9.13` | No session survives, or is restored after, a barring state |
| `AC-9.14` | Concurrent transitions never leave the account in two states |
| `AC-9.15` | A Pending Verification record is unrecoverable after `CFG-9` |
| `AC-9.16` | A lock clears automatically after exactly `CFG-4` |
| `AC-9.17` | A lock cannot be lifted early, extended or applied manually by any role |
| `AC-9.18` | A lock does not terminate existing sessions |
| `AC-9.19` | Only a platform role can suspend or lift a suspension |
| `AC-9.20` | Suspension without a recorded reason is refused |
| `AC-9.21` | Suspension takes effect in every library simultaneously |
| `AC-9.22` | Lifting a suspension restores exactly the roles still held, and no others |
| `AC-9.23` | No tenant role can suspend, or determine that an account is suspended |
| `AC-9.24` | A Disabled account can never return to Active or Inactive |
| `AC-9.25` | Deletion by an authenticated holder is accepted without administrative assistance |
| `AC-9.26` | Deletion requested by a tenant role is refused |
| `AC-9.27` | Deletion moves the account to Pending Deletion and terminates all sessions immediately |
| `AC-9.28` | Cancellation within `CFG-10` by the holder, with re-verification, restores the account |
| `AC-9.29` | Cancellation by anyone other than the holder is refused |
| `AC-9.30` | After `CFG-10`, no role, tool, procedure or backup restoration recovers the account |
| `AC-9.31` | After erasure, the mobile number can be registered afresh and yields no prior data |
| `AC-9.32` | Erasure revokes every role and notifies every affected library |
| `AC-9.33` | Audit records survive erasure and no longer identify the person |
| `AC-9.34` | Deletion alters no record owned by another context |
| `AC-9.35` | No surviving record permits reconstruction of a deleted identity |
| `AC-9.36` | Deletion is refused while the account is a library's sole Owner |
| `AC-9.37` | A refusal under sole-ownership discloses no library the requester cannot already see |
| `AC-9.38` | A number change without verification of the new number never takes effect |
| `AC-9.39` | A number change to a number held by a non-Deleted account is refused |
| `AC-9.40` | At no moment do both the old and new numbers resolve to the account |
| `AC-9.41` | A completed number change terminates every session and revokes every device trust |
| `AC-9.42` | A completed number change preserves account identity, roles, links and history |
| `AC-9.43` | A number change is refused in every non-usable state |
| `AC-9.44` | No tenant role can change or request a change to any mobile number |
| `AC-9.45` | Every lifecycle change affecting access produces a notification to the holder |
| `AC-9.46` | No notification or error discloses the account's state to any party other than the holder and platform roles |


---

# Chapter 10 — Events, Audit & Notifications

## 10.1 Purpose

### Why events exist

Authentication knows things that other parts of the platform need to react to. When a member's roles are revoked,
attendance must stop accepting them. When an account is deleted, every library holding a role must be told the person
is gone. When a sign-in occurs from an unrecognised device, the holder must be warned. None of this can be achieved by
other contexts reaching into Authentication to inspect its state — that would couple every module to the internals of
one, and would make the boundary meaningless.

Events are how Authentication tells the platform what happened without telling anyone how it works. They are the sole
outbound channel. A module that needs to know something about identity subscribes to an event; it does not query, it
does not read, and it does not cache authoritative copies.

### Why audit exists

Audit answers a different question. Events say *what happened so you can react*. Audit says *what happened so it can
be examined later*. Audit exists for disputes, investigations, regulatory enquiry and the plain operational need to
reconstruct a sequence of events after something went wrong. Its defining property is that it must be trustworthy —
which means it must be immutable, complete, and beyond the reach of the people whose actions it records.

### Why notifications exist

Notifications are how the platform tells a **person** something about their own identity. They are the primary
security control against silent account takeover: a SIM swap is invisible until the legitimate holder is told that
someone signed in from a device they do not recognise. Notifications are therefore a security mechanism first and a
convenience second.

### The separation this chapter enforces

Authentication **produces** events, **records** audit facts and **determines** that a notification is warranted. It
does not deliver messages, does not own the audit store, and does not decide a recipient's channel preferences.
Delivery belongs to the notification context; storage belongs to the audit context. This chapter specifies only what
Authentication is responsible for.

| ID | Requirement |
|---|---|
| `AUTH-10.1` | Events MUST be the sole means by which Authentication communicates state changes to other contexts |
| `AUTH-10.2` | No other context MUST read Authentication's internal state directly |
| `AUTH-10.3` | Authentication MUST NOT deliver notifications; it MUST only determine that one is warranted and emit the fact |
| `AUTH-10.4` | Authentication MUST NOT own audit storage, retention or querying; it MUST only produce audit-worthy facts |

---

## 10.2 Event Principles

| ID | Principle | Statement |
|---|---|---|
| `EP-1` | Facts, not commands | An event states that something happened; it never instructs a consumer to act |
| `EP-2` | Past tense | Events describe completed changes; nothing is emitted for an attempt still in progress |
| `EP-3` | Emitted only on success | A change that was refused or rolled back emits no state-change event |
| `EP-4` | Exactly one per change | A single change produces exactly one event, never zero and never several |
| `EP-5` | Self-describing | A consumer needs nothing beyond the event to understand what occurred |
| `EP-6` | Minimal payload | An event carries the least information a consumer needs, and no personal data beyond a masked identifier |
| `EP-7` | No credentials | No event ever carries an OTP, a session credential, a device trust marker or any secret |
| `EP-8` | Tenant-scoped where tenant-relevant | An event concerning a library is visible only to that library |
| `EP-9` | Consumer-agnostic | Authentication neither knows nor depends on who consumes an event |
| `EP-10` | Idempotent consumption | Consumers must tolerate receiving the same event more than once without additional effect |
| `EP-11` | Ordered per account | Events for one account are consumable in the order they occurred |
| `EP-12` | Non-blocking | Emission never delays, conditions or reverses the change that caused it |

| ID | Requirement |
|---|---|
| `AUTH-10.5` | Every event MUST be a statement of completed fact in the past tense |
| `AUTH-10.6` | An event MUST be emitted only after the change it describes has taken effect |
| `AUTH-10.7` | A refused or rolled-back change MUST emit no state-change event |
| `AUTH-10.8` | Each state change MUST emit exactly one event |
| `AUTH-10.9` | Event payloads MUST carry masked mobile numbers only, and MUST NOT carry any other personal attribute beyond the display name where the consumer requires it |
| `AUTH-10.10` | Event payloads MUST NOT carry credentials, session identifiers or challenge identifiers |
| `AUTH-10.11` | Failure to emit an event MUST NOT reverse the change; emission MUST be retried until it succeeds |
| `AUTH-10.12` | Events MUST be consumable in per-account order |
| `AUTH-10.13` | Authentication MUST NOT wait for, depend upon, or react to any consumer's handling of an event |

---

## 10.3 Authentication Events

Each event is specified by its purpose, its trigger, its producer, its consumers and its business significance.

### Identity events

#### `EV-1` Account Created

| Field | Value |
|---|---|
| **Purpose** | Announce that a new global identity now exists |
| **Trigger** | First successful OTP verification for a mobile number not previously registered |
| **Producer** | Authentication |
| **Consumers** | Member management, notification, analytics, audit |
| **Business significance** | Marks the entry of a new person into the platform. Downstream contexts may now reference this identity. Until this event, no identity exists to attach memberships, attendance or fees to. |

#### `EV-2` Account Verified

| Field | Value |
|---|---|
| **Purpose** | Confirm that control of the mobile number has been demonstrated |
| **Trigger** | Successful OTP verification, whether for a new or existing account |
| **Producer** | Authentication |
| **Consumers** | Audit, security monitoring, analytics |
| **Business significance** | Establishes the assurance on which every later access decision rests. Distinct from `EV-1` because verification recurs for the lifetime of the account while creation happens once. |

#### `EV-3` Account State Changed

| Field | Value |
|---|---|
| **Purpose** | Announce that the account has moved between lifecycle states |
| **Trigger** | Any accepted lifecycle transition |
| **Producer** | Authentication |
| **Consumers** | Member management, session enforcement, notification, audit, analytics |
| **Business significance** | The single signal by which the platform learns that a person has become usable, unusable, or permanently gone. Every context that gates behaviour on account usability depends on this event rather than on its own copy of state. |

#### `EV-4` Account Deletion Requested

| Field | Value |
|---|---|
| **Purpose** | Announce that erasure has been requested and the retention window has begun |
| **Trigger** | Acceptance of a deletion request |
| **Producer** | Authentication |
| **Consumers** | Member management, notification, compliance, audit |
| **Business significance** | Gives every context notice to stop presenting the person as available, while preserving the ability to reverse if the request is cancelled. |

#### `EV-5` Account Deleted

| Field | Value |
|---|---|
| **Purpose** | Announce that personal data has been permanently erased |
| **Trigger** | Expiry of the retention window without cancellation |
| **Producer** | Authentication |
| **Consumers** | Member management, every context holding a reference, compliance, audit |
| **Business significance** | Obliges every consumer to sever its reference to the identity. This is the point at which the platform's obligation to erase becomes binding on contexts other than Authentication. |

#### `EV-6` Mobile Number Changed

| Field | Value |
|---|---|
| **Purpose** | Announce that the account's credential channel has been replaced |
| **Trigger** | Successful completion of a mobile number change |
| **Producer** | Authentication |
| **Consumers** | Notification, member management, security monitoring, audit |
| **Business significance** | The identity is unchanged but the means of reaching and authenticating the person has moved. Contexts displaying a contact number must refresh; security monitoring must treat the change as high-significance because it is the classic post-takeover action. |

#### `EV-7` Display Name Changed

| Field | Value |
|---|---|
| **Purpose** | Announce that the person's presented name has been updated |
| **Trigger** | Successful update of the display name |
| **Producer** | Authentication |
| **Consumers** | Member management, every context presenting the name, audit |
| **Business significance** | Ensures the person is presented consistently everywhere without any context storing its own authoritative copy. |

### Authentication events

#### `EV-8` Authentication Challenge Issued

| Field | Value |
|---|---|
| **Purpose** | Record that a one-time code was generated and dispatched |
| **Trigger** | Acceptance of an OTP request that passed all protective limits |
| **Producer** | Authentication |
| **Consumers** | Delivery, security monitoring, audit, operational metrics |
| **Business significance** | The point at which delivery cost is incurred and at which abuse becomes measurable. Volume anomalies here are the earliest indicator of automated attack. |

#### `EV-9` Authentication Succeeded

| Field | Value |
|---|---|
| **Purpose** | Record a successful proof of identity |
| **Trigger** | Correct OTP presented within validity and attempt limits |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, audit, analytics |
| **Business significance** | Distinct from session issuance. Verification may succeed and still yield no access. Separating the two makes it possible to detect accounts that authenticate repeatedly but can never enter — a signal of misconfigured roles. |

#### `EV-10` Authentication Failed

| Field | Value |
|---|---|
| **Purpose** | Record an unsuccessful proof attempt |
| **Trigger** | Incorrect, expired, consumed or exhausted code presented |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, abuse detection, audit |
| **Business significance** | The primary raw signal for brute-force detection. Individually unremarkable; in aggregate, the clearest evidence of attack. |

#### `EV-11` Authentication Rate Limited

| Field | Value |
|---|---|
| **Purpose** | Record that a protective limit refused a request |
| **Trigger** | A request exceeding the per-number, interval or per-origin limit |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, abuse detection, operational metrics, audit |
| **Business significance** | Confirms controls are engaging. Sustained volume indicates either an active attack or a limit set too tightly for legitimate use — both require attention. |

#### `EV-12` Account Locked

| Field | Value |
|---|---|
| **Purpose** | Announce that abuse protection has temporarily barred a number |
| **Trigger** | Exhaustion of the per-number request quota |
| **Producer** | Authentication |
| **Consumers** | Notification, security monitoring, support tooling, audit |
| **Business significance** | The holder must be told they are barred and that it is temporary; support must be able to see the cause without being able to lift it. |

### Session and device events

#### `EV-13` Session Issued

| Field | Value |
|---|---|
| **Purpose** | Announce that access has been granted for a specific account, device and library |
| **Trigger** | Successful session issuance following verification, usability confirmation and tenant establishment |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, analytics, audit, presence-dependent contexts |
| **Business significance** | The moment a person actually enters a library's context. The basis of active-user measurement and of any downstream behaviour conditioned on presence. |

#### `EV-14` Session Terminated

| Field | Value |
|---|---|
| **Purpose** | Announce that a session has ended and the reason class |
| **Trigger** | Sign-out, expiry, revocation or forced termination |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, analytics, audit |
| **Business significance** | Distinguishes ordinary departure from enforced removal. A rise in forced terminations indicates either an incident in progress or an over-aggressive policy. |

#### `EV-15` All Sessions Terminated

| Field | Value |
|---|---|
| **Purpose** | Announce a global revocation across every device |
| **Trigger** | Global sign-out, suspension, disablement, deletion, or number change |
| **Producer** | Authentication |
| **Consumers** | Notification, security monitoring, audit |
| **Business significance** | Almost always a response to suspected compromise. Its occurrence is itself a security signal, and the holder must be told it happened. |

#### `EV-16` New Device Detected

| Field | Value |
|---|---|
| **Purpose** | Warn that authentication occurred from a device not previously seen |
| **Trigger** | First successful authentication from an unrecognised device |
| **Producer** | Authentication |
| **Consumers** | Notification, security monitoring, audit |
| **Business significance** | The single most important user-facing security signal in the platform. It is the only mechanism by which a victim of SIM swap learns that their identity is in use elsewhere. Access is not blocked, so the notification is the entire control. |

#### `EV-17` Device Trusted

| Field | Value |
|---|---|
| **Purpose** | Record that a device has entered the trusted set |
| **Trigger** | Successful interactive authentication conferring trust |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, audit |
| **Business significance** | Trust reduces future friction, so its conferral must be observable and attributable. |

#### `EV-18` Device Removed

| Field | Value |
|---|---|
| **Purpose** | Announce that a device has been detached from the account |
| **Trigger** | Removal by the account holder, or automatic revocation |
| **Producer** | Authentication |
| **Consumers** | Notification, security monitoring, audit |
| **Business significance** | Confirms to the holder that a lost or stolen device can no longer reach their account — the closure of a security concern. |

#### `EV-19` Suspicious Session Activity Detected

| Field | Value |
|---|---|
| **Purpose** | Record that a session was presented outside its binding |
| **Trigger** | A session credential presented from a device other than the one it was bound to |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, incident response, audit |
| **Business significance** | Direct evidence of attempted session theft. Rare in normal operation and therefore high-value; every occurrence warrants examination. |

### Authorization events

#### `EV-20` Role Assigned

| Field | Value |
|---|---|
| **Purpose** | Announce that an account has gained a role in a library or at the platform |
| **Trigger** | Successful role assignment |
| **Producer** | Authentication |
| **Consumers** | Member management, notification, the affected library, audit |
| **Business significance** | The moment a person becomes able to act somewhere. Also the moment an Inactive account becomes Active, which other contexts must observe. |

#### `EV-21` Role Revoked

| Field | Value |
|---|---|
| **Purpose** | Announce that an account has lost a role |
| **Trigger** | Successful role revocation |
| **Producer** | Authentication |
| **Consumers** | Member management, notification, the affected library, audit |
| **Business significance** | Access ends at the next decision without the session ending. Contexts must not assume the person has departed the platform — only that library. |

#### `EV-22` Access Elevated

| Field | Value |
|---|---|
| **Purpose** | Record that a platform role obtained time-bounded access to tenant data |
| **Trigger** | Approval of an elevation request |
| **Producer** | Authentication |
| **Consumers** | Audit, compliance, security monitoring |
| **Business significance** | The platform operator viewing a customer's data is the highest-trust action in the system. It must be recorded without exception so that it can be justified afterwards. |

#### `EV-23` Access Elevation Expired

| Field | Value |
|---|---|
| **Purpose** | Record that elevated access ended |
| **Trigger** | Expiry of the elevation window, or explicit relinquishment |
| **Producer** | Authentication |
| **Consumers** | Audit, compliance, security monitoring |
| **Business significance** | Closes the window opened by `EV-22`, making the exposure period exactly measurable. |

#### `EV-24` Access Policy Changed

| Field | Value |
|---|---|
| **Purpose** | Record a change to the permissions attached to a role |
| **Trigger** | Any accepted change to the policy definition |
| **Producer** | Authentication |
| **Consumers** | Audit, compliance, security monitoring |
| **Business significance** | Policy changes silently alter what many accounts can do. Without this event, a widening of access would be indistinguishable from normal operation. |

#### `EV-25` Authorization Denied

| Field | Value |
|---|---|
| **Purpose** | Record a refused access decision |
| **Trigger** | A decision resolving to deny |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, audit |
| **Business significance** | Individual denials are ordinary. Patterns — one account probing many permissions, or repeated attempts against another tenant — are the signature of reconnaissance. |

#### `EV-26` Cross-Tenant Access Attempted

| Field | Value |
|---|---|
| **Purpose** | Record an attempt to reach one library's data while operating in another |
| **Trigger** | A request naming a tenant other than the established active context |
| **Producer** | Authentication |
| **Consumers** | Security monitoring, incident response, audit, compliance |
| **Business significance** | The most serious signal the platform can produce. Tenant isolation is the core promise of a multi-tenant product; any attempt against it must be visible immediately, whether it originates from an attacker or a defect. |

| ID | Requirement |
|---|---|
| `AUTH-10.14` | Every event listed in this section MUST be emitted whenever its trigger occurs |
| `AUTH-10.15` | No event MUST be emitted when its trigger has not occurred |
| `AUTH-10.16` | An event concerning a specific library MUST be scoped to that library and MUST NOT be observable by any other |
| `AUTH-10.17` | Events concerning identity rather than participation MUST NOT disclose the set of libraries an account belongs to |
| `AUTH-10.18` | The event catalogue MUST be closed; a new event MUST require an explicit specification change |

---

## 10.4 Audit Principles

| ID | Principle | Statement |
|---|---|---|
| `AU-1` | Completeness | Every security-relevant action is recorded, whether it succeeded or failed |
| `AU-2` | Immutability | A recorded fact can never be altered or removed by anyone |
| `AU-3` | Attribution | Every record identifies the acting account, the device where applicable, and the moment |
| `AU-4` | Independence | Audit is beyond the control of the roles whose actions it records |
| `AU-5` | Minimality | Records hold what is needed to reconstruct the action, and nothing more |
| `AU-6` | Non-disclosure | Records hold no credential and no unmasked personal data |
| `AU-7` | Tenant confinement | A library sees only audit concerning its own context |
| `AU-8` | Survivability | Audit outlives the account it concerns, in a form that no longer identifies the person |
| `AU-9` | Server authority | Every recorded time is server time; client-supplied time is never recorded as authoritative |

### Auditable actions

| Category | Actions recorded |
|---|---|
| Authentication | Challenge issued, verification succeeded, verification failed, rate limit engaged, lock applied |
| Session | Session issued, session terminated with reason class, global termination, binding violation |
| Device | Device registered, trust conferred, trust expired, device removed |
| Lifecycle | Every state transition, with actor and reason |
| Identity | Mobile number change, display name change |
| Authorization | Role assigned, role revoked, elevation granted, elevation expired, policy changed, access denied |
| Isolation | Every cross-tenant access attempt |

| ID | Requirement |
|---|---|
| `AUTH-10.19` | Every action in the auditable list MUST produce an audit record |
| `AUTH-10.20` | Audit records MUST be immutable for every role, including Platform Administrator |
| `AUTH-10.21` | Audit records MUST identify the acting account, the device where applicable, and the server-side moment |
| `AUTH-10.22` | Audit records MUST NOT contain OTP values, session credentials, device trust markers or unmasked mobile numbers |
| `AUTH-10.23` | A library MUST be able to view audit only for actions within its own context |
| `AUTH-10.24` | Audit MUST record failed and refused actions, not only successful ones |
| `AUTH-10.25` | Audit MUST survive account erasure in a de-identified form |
| `AUTH-10.26` | Authentication MUST NOT own audit storage, retention or query; it MUST only produce the records |
| `AUTH-10.27` | Inability to record an audit fact MUST be treated as a failure of the action for security-critical operations |

---

## 10.5 Notification Responsibilities

### The division of duty

Authentication decides **that** a person must be told and **what** they must be told about. The notification context
decides **how**, **when** and **through which channel**. Authentication holds no channel preferences, no templates,
no delivery state and no retry logic.

### Notifiable occurrences

| Occurrence | Recipient | Why the person must be told |
|---|---|---|
| Sign-in from an unrecognised device | Account holder | Sole warning of account takeover |
| All sessions terminated | Account holder | Confirms a global revocation they may not have initiated |
| Device removed | Account holder | Confirms a lost device can no longer reach the account |
| Mobile number changed | Old and new number | Classic post-takeover action; both parties must know |
| Account locked | Account holder | Explains inability to sign in and that it is temporary |
| Account suspended | Account holder | Explains loss of access without disclosing investigation |
| Account restored | Account holder | Confirms access is available again |
| Account disabled | Account holder | Explains permanent loss of access |
| Deletion requested | Account holder | Starts the cancellation window; protects against coerced or mistaken deletion |
| Deletion completed | Account holder, so far as delivery remains possible | Confirms the obligation was discharged |
| Role assigned | Account holder | Tells the person they can now act somewhere |
| Role revoked | Account holder | Explains loss of access to one library |

| ID | Requirement |
|---|---|
| `AUTH-10.28` | Authentication MUST determine that a notification is warranted and MUST NOT deliver it |
| `AUTH-10.29` | Authentication MUST NOT hold channel preferences, templates, delivery state or retry logic |
| `AUTH-10.30` | A notification MUST be warranted for every occurrence listed above |
| `AUTH-10.31` | A notification MUST NOT contain an OTP, a session credential or an unmasked mobile number other than to the holder of that number |
| `AUTH-10.32` | A notification MUST NOT disclose any library in which the recipient does not hold a role |
| `AUTH-10.33` | A notification about suspension MUST NOT disclose the reason, the reporting party, or any other account |
| `AUTH-10.34` | A notification MUST NOT be suppressible by any tenant role |
| `AUTH-10.35` | Security notifications MUST NOT be suppressible by the account holder |
| `AUTH-10.36` | Failure to deliver a notification MUST NOT reverse or delay the change that warranted it |
| `AUTH-10.37` | The OTP itself MUST NOT be treated as a notification and MUST NOT pass through any general notification path |

---

## 10.6 Business Rules

| ID | Rule |
|---|---|
| `BR-10.1` | Events are the only outbound channel from Authentication to other contexts |
| `BR-10.2` | No context reads Authentication's internal state directly |
| `BR-10.3` | Every event states a completed fact in the past tense |
| `BR-10.4` | An event is emitted only after the change has taken effect |
| `BR-10.5` | A refused or rolled-back change emits no state-change event |
| `BR-10.6` | Each state change emits exactly one event |
| `BR-10.7` | No event carries an OTP, session credential, challenge identifier or trust marker |
| `BR-10.8` | Event payloads carry masked mobile numbers only |
| `BR-10.9` | Tenant-relevant events are scoped to the library concerned |
| `BR-10.10` | No event discloses the set of libraries an account belongs to |
| `BR-10.11` | Emission never blocks, delays or reverses the change |
| `BR-10.12` | Emission is retried until it succeeds |
| `BR-10.13` | Events for one account are consumable in occurrence order |
| `BR-10.14` | Consumers tolerate duplicate delivery without additional effect |
| `BR-10.15` | Authentication never depends on a consumer's handling of an event |
| `BR-10.16` | The event catalogue is closed; additions require a specification change |
| `BR-10.17` | Every security-relevant action produces an audit record, successful or not |
| `BR-10.18` | Audit records are immutable for every role without exception |
| `BR-10.19` | Every audit record identifies actor, device where applicable, and server-side moment |
| `BR-10.20` | Audit records contain no credential and no unmasked personal data |
| `BR-10.21` | A library sees audit only for its own context |
| `BR-10.22` | Audit survives account erasure in de-identified form |
| `BR-10.23` | Authentication produces audit facts but owns no audit storage |
| `BR-10.24` | Inability to record audit fails the action for security-critical operations |
| `BR-10.25` | All recorded times are server times |
| `BR-10.26` | Authentication determines notification need; it never delivers |
| `BR-10.27` | Every listed notifiable occurrence warrants a notification |
| `BR-10.28` | Notifications never contain credentials or another person's unmasked number |
| `BR-10.29` | Notifications never disclose a library where the recipient holds no role |
| `BR-10.30` | Suspension notifications disclose no reason, reporter or other account |
| `BR-10.31` | No tenant role can suppress a notification |
| `BR-10.32` | Security notifications cannot be disabled by the holder |
| `BR-10.33` | Notification delivery failure never reverses the underlying change |
| `BR-10.34` | The OTP is not a notification and never uses a general notification path |
| `BR-10.35` | Events, audit and notifications are three distinct concerns and are never substituted for one another |

---

## 10.7 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-10.1` | Change succeeds but event emission fails | Change stands; emission is retried until it succeeds; no rollback occurs |
| `XC-10.2` | Event emitted twice due to retry | Consumers treat the duplicate as a no-op; no second effect occurs |
| `XC-10.3` | Consumer unavailable when an event is emitted | Event remains available for later consumption; Authentication is unaffected |
| `XC-10.4` | Consumer processes events out of order | Per-account ordering is guaranteed by the platform; a consumer disregarding it bears the consequence |
| `XC-10.5` | Change refused after validation | No state-change event is emitted; an audit record of the refusal is still produced |
| `XC-10.6` | Verification succeeds but no session is issued | `EV-9` is emitted; `EV-13` is not; the distinction is observable |
| `XC-10.7` | Account created and role assigned in one operation | `EV-1` and `EV-20` are both emitted, in that order |
| `XC-10.8` | Suspension terminates six sessions | One `EV-3` and one `EV-15`; not six separate termination events |
| `XC-10.9` | Number change terminates sessions and revokes trust | `EV-6`, `EV-15` and the appropriate device events are all emitted |
| `XC-10.10` | Deletion cancelled within the window | `EV-4` was already emitted; a subsequent `EV-3` records the return to Active or Inactive; `EV-5` is never emitted |
| `XC-10.11` | Library attempts to consume an event about another library | Not observable; scoping prevents it |
| `XC-10.12` | Library attempts to infer other libraries from an identity event | Identity events carry no library set, so the inference is impossible |
| `XC-10.13` | Consumer requests an unmasked mobile number from an event | Not present; the consumer must obtain it through a permitted path or not at all |
| `XC-10.14` | Audit store unavailable during a security-critical action | The action fails; it is not permitted to proceed unrecorded |
| `XC-10.15` | Audit store unavailable during a non-critical action | The action may proceed; the omission is itself recorded when the store returns |
| `XC-10.16` | Platform Administrator attempts to delete an audit record | Refused; the attempt is itself audited |
| `XC-10.17` | Audit queried for an erased account | Actions and timings are returned; the person is not identifiable |
| `XC-10.18` | Library requests audit for an account's activity elsewhere | Refused; only its own context is visible |
| `XC-10.19` | Notification delivery fails permanently | The change stands; the delivery failure is recorded; no retry obligation falls on Authentication |
| `XC-10.20` | Holder attempts to disable new-device notifications | Refused; security notifications are not optional |
| `XC-10.21` | Library attempts to suppress role-revocation notifications | Refused; tenants cannot suppress notifications |
| `XC-10.22` | Number change where the old number is unreachable | Notification to the new number proceeds; failure to reach the old number does not block the change |
| `XC-10.23` | Deletion completes and the holder can no longer be reached | Erasure proceeds; the undeliverable notification does not delay it |
| `XC-10.24` | Unrecognised device is in fact the holder's reinstalled application | `EV-16` is still emitted and the holder is still notified; a false positive is preferred to a missed takeover |
| `XC-10.25` | Cross-tenant attempt caused by a platform defect rather than an attacker | `EV-26` is emitted identically; the event records the attempt, not the intent |
| `XC-10.26` | Elevation expires while the operator is mid-task | `EV-23` is emitted at expiry; continuing requires a fresh elevation and a fresh `EV-22` |
| `XC-10.27` | Policy change affects two thousand accounts | One `EV-24` describing the policy change; not one event per affected account |
| `XC-10.28` | Same event consumed by six contexts | Emitted once; each consumer reads independently; Authentication is unaware of the count |

---

## 10.8 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-10.1` | No context obtains Authentication state by any means other than an event |
| `AC-10.2` | Every event is expressed as a completed past-tense fact |
| `AC-10.3` | No event is emitted before its change has taken effect |
| `AC-10.4` | A refused change emits no state-change event |
| `AC-10.5` | Each state change emits exactly one event |
| `AC-10.6` | No event payload contains an OTP, session credential, challenge identifier or trust marker |
| `AC-10.7` | No event payload contains an unmasked mobile number |
| `AC-10.8` | A tenant-relevant event is unobservable by any library other than the one concerned |
| `AC-10.9` | No event reveals the set of libraries an account belongs to |
| `AC-10.10` | A failed emission never reverses the change and is retried to success |
| `AC-10.11` | Duplicate delivery of an event produces no second effect |
| `AC-10.12` | Events for one account are delivered in occurrence order |
| `AC-10.13` | Authentication completes its work regardless of consumer availability |
| `AC-10.14` | Every event in the catalogue is emitted on its trigger and on no other occasion |
| `AC-10.15` | An event outside the catalogue cannot be emitted |
| `AC-10.16` | Verification succeeding without session issuance emits `EV-9` and not `EV-13` |
| `AC-10.17` | A global termination emits one `EV-15` regardless of the number of sessions ended |
| `AC-10.18` | A policy change emits one `EV-24` regardless of the number of accounts affected |
| `AC-10.19` | Every auditable action produces exactly one audit record |
| `AC-10.20` | Failed and refused actions produce audit records |
| `AC-10.21` | No role, including Platform Administrator, can alter or delete an audit record |
| `AC-10.22` | An attempt to alter an audit record is itself audited |
| `AC-10.23` | Every audit record carries actor, device where applicable, and server-side time |
| `AC-10.24` | No audit record contains a credential or an unmasked mobile number |
| `AC-10.25` | A library retrieves audit only for its own context |
| `AC-10.26` | Audit for an erased account returns actions without identifying the person |
| `AC-10.27` | A security-critical action fails when it cannot be audited |
| `AC-10.28` | Every recorded time is server time regardless of any client value |
| `AC-10.29` | Authentication delivers no notification itself |
| `AC-10.30` | Every listed notifiable occurrence results in a notification being warranted |
| `AC-10.31` | Sign-in from an unrecognised device always notifies the holder |
| `AC-10.32` | A mobile number change notifies both the old and the new number |
| `AC-10.33` | No notification discloses a library where the recipient holds no role |
| `AC-10.34` | A suspension notification discloses no reason, reporter or other account |
| `AC-10.35` | No tenant role can suppress any notification |
| `AC-10.36` | A holder cannot disable security notifications |
| `AC-10.37` | Notification delivery failure never reverses or delays the underlying change |
| `AC-10.38` | The OTP never traverses a general notification path |


---

# Chapter 11 — Non-Functional Requirements, Compliance & Final Acceptance

## 11.1 Purpose

### Why this chapter exists

The preceding ten chapters specify what Authentication must do. This chapter specifies how well it must do it, under
what obligations, and how anyone can determine whether the specification has been met.

Authentication is the platform's single point of entry. Every session in every library begins here. That gives it
two properties no other component shares: it is on the critical path of every user journey, and it has no fallback.
A slow attendance screen is an annoyance; a slow sign-in is the product being unavailable. An unavailable reporting
module affects reporting; an unavailable Authentication affects everything.

The requirements in this chapter follow from that position. They are deliberately achievable at first-version scale
and deliberately not padded with numbers the platform cannot yet measure.

### What this chapter provides

Performance, availability, scalability and observability requirements; the compliance obligations Authentication
operates under; a closed classification of the errors it may return; business-continuity requirements; the
architectural constraints that must never be violated; the final acceptance criteria for the module; a statement of
what remains permanently out of scope; and the roadmap for evolution beyond the first version.

| ID | Requirement |
|---|---|
| `AUTH-11.1` | Every requirement in this chapter MUST be measurable, observable or verifiable |
| `AUTH-11.2` | No non-functional requirement MAY be met by weakening a functional or security requirement |
| `AUTH-11.3` | Where a target cannot yet be measured, the measurement capability MUST be built before the target is claimed as met |

---

## 11.2 Performance

### Targets

Measured server-side, excluding network transit and excluding delivery time of the code by the mobile operator.

| Operation | Target (95th percentile) | Upper bound (99th percentile) |
|---|---|---|
| OTP request accepted and dispatched to the delivery provider | 500 ms | 1,500 ms |
| OTP verification decision | 300 ms | 1,000 ms |
| Session issuance following verification | 300 ms | 1,000 ms |
| Session validation on an ordinary request | 50 ms | 150 ms |
| Authorization decision | 50 ms | 150 ms |
| Library selection and tenant context establishment | 400 ms | 1,200 ms |
| Session termination | 200 ms | 600 ms |
| Global session termination | 1,000 ms | 3,000 ms |

| ID | Requirement |
|---|---|
| `AUTH-11.4` | Session validation and authorization decisions MUST be fast enough to be invisible, because they occur on every request |
| `AUTH-11.5` | Performance MUST NOT be improved by caching authorization decisions across requests |
| `AUTH-11.6` | Performance MUST NOT degrade with the number of libraries in which an account holds roles |
| `AUTH-11.7` | Performance MUST NOT degrade with the number of tenants on the platform |
| `AUTH-11.8` | Delivery latency of the mobile operator MUST NOT be counted against these targets, and MUST NOT be presented to users as platform latency |
| `AUTH-11.9` | Under load exceeding capacity, the system MUST shed load predictably rather than degrade uniformly |

---

## 11.3 Availability & Reliability

### Targets

| Property | Target |
|---|---|
| Authentication service availability | 99.9% monthly |
| Session validation availability | 99.95% monthly |
| Authorization decision availability | 99.95% monthly |
| Maximum tolerable continuous outage | 30 minutes |
| Data durability for identity and role records | No tolerated loss |

Session validation and authorization are held to a higher target than sign-in because their failure affects every
user already working, whereas a brief sign-in outage affects only those arriving.

| ID | Requirement |
|---|---|
| `AUTH-11.10` | Authentication MUST NOT lose identity records, role assignments or audit records under any failure |
| `AUTH-11.11` | Loss of an in-flight OTP challenge MUST be tolerable; the user MUST be able to request another |
| `AUTH-11.12` | Loss of session state MUST be tolerable; users MUST be able to authenticate again |
| `AUTH-11.13` | Failure of the delivery provider MUST NOT prevent existing sessions from continuing to work |
| `AUTH-11.14` | Failure of any single component MUST NOT grant access that would otherwise be denied |
| `AUTH-11.15` | Every failure mode MUST fail closed |
| `AUTH-11.16` | Recovery MUST NOT restore sessions that were terminated before or during the failure |
| `AUTH-11.17` | Recovery MUST re-apply any lifecycle state that a restored backup would otherwise reverse |

---

## 11.4 Scalability

### First-version envelope

| Dimension | First-version target | Design headroom |
|---|---|---|
| Tenants (libraries) | 500 | 10,000 |
| Accounts | 100,000 | 5,000,000 |
| Concurrent active sessions | 10,000 | 500,000 |
| OTP requests per hour, peak | 5,000 | 250,000 |
| Authorization decisions per second, peak | 500 | 25,000 |
| Libraries per account | 10 | 100 |

| ID | Requirement |
|---|---|
| `AUTH-11.18` | The design MUST accommodate the headroom column without architectural change |
| `AUTH-11.19` | Scaling MUST NOT require tenant-specific configuration, partitioning or deployment |
| `AUTH-11.20` | No tenant's load MUST be capable of degrading another tenant's authentication |
| `AUTH-11.21` | Authorization decisions MUST scale independently of the number of role assignments an account holds |
| `AUTH-11.22` | Growth in tenant count MUST NOT increase the cost of any single decision |

---

## 11.5 Observability

### Required signals

| Category | Signals |
|---|---|
| Volume | OTP requests, verifications attempted, verifications succeeded, sessions issued, sessions terminated |
| Success rates | Verification success rate, session issuance rate, authorization allow rate |
| Latency | Distribution for every operation in §11.2 |
| Abuse | Rate-limit engagements, lockouts, challenge exhaustions, binding violations, cross-tenant attempts |
| Health | Dependency availability, delivery provider success rate, error rate by class |
| Lifecycle | State transitions by type, deletions requested, deletions completed |

| ID | Requirement |
|---|---|
| `AUTH-11.23` | Every operation MUST be observable in volume, success rate and latency |
| `AUTH-11.24` | Observability data MUST contain no personal data, no credential and no session identifier |
| `AUTH-11.25` | Signals MUST be attributable to a tenant for capacity purposes without exposing any individual |
| `AUTH-11.26` | A sustained rise in verification failures, rate-limit engagements or lockouts MUST be alertable |
| `AUTH-11.27` | Any cross-tenant access attempt MUST be alertable immediately, with no threshold |
| `AUTH-11.28` | Any session binding violation MUST be alertable immediately, with no threshold |
| `AUTH-11.29` | It MUST be possible to reconstruct a single account's authentication history from audit without access to personal data |
| `AUTH-11.30` | Delivery provider failures MUST be distinguishable from platform failures in every signal |

---

## 11.6 Compliance

### Obligations

Liboora operates in India and serves libraries and study halls whose members frequently include minors.
Authentication is subject to the following classes of obligation.

| Area | Obligation |
|---|---|
| Personal data protection | Lawful basis, purpose limitation, minimisation, retention limits, and the individual's rights of access, correction and erasure |
| Minors | Heightened protection for those under eighteen, with guardian linkage where applicable |
| Commercial communication | Compliance with the registered-sender and template regime governing transactional messages to Indian mobile numbers |
| Data localisation | Personal data of Indian users held within permitted jurisdictions |
| Record keeping | Retention of records sufficient to demonstrate what occurred, without retaining more personal data than necessary |
| Security | Reasonable and appropriate safeguards proportionate to the sensitivity of the data held |

| ID | Requirement |
|---|---|
| `AUTH-11.31` | Personal data MUST be collected only for authentication, protection and notification, and MUST be limited to the mobile number and display name |
| `AUTH-11.32` | An account holder MUST be able to obtain, correct and erase their authentication data without administrative assistance |
| `AUTH-11.33` | Erasure MUST be genuine and irreversible once the retention window has passed |
| `AUTH-11.34` | Retention periods MUST be defined, enforced automatically, and never extended for commercial reasons |
| `AUTH-11.35` | Data belonging to minors MUST receive the strictest available treatment and MUST be reachable only by the minor, their linked guardian, and roles strictly requiring it |
| `AUTH-11.36` | Transactional messages MUST conform to the registered-sender and template regime; codes MUST be numeric to satisfy it |
| `AUTH-11.37` | Personal data MUST be held within permitted jurisdictions |
| `AUTH-11.38` | Audit MUST be sufficient to demonstrate compliance and MUST itself hold no unmasked personal data |
| `AUTH-11.39` | Compliance obligations MUST NOT be waivable by tenant agreement, consent prompt or support escalation |
| `AUTH-11.40` | Where an obligation and a product convenience conflict, the obligation MUST prevail |

---

## 11.7 Error Classification

Errors are grouped into a closed set of classes. A class determines what the caller may do, not what went wrong
internally. Distinct causes within one class MUST be indistinguishable to the caller where distinguishing them would
disclose information.

| ID | Class | Meaning | Caller may |
|---|---|---|---|
| `AERR-1` | Invalid input | The request is malformed or fails validation | Correct and retry immediately |
| `AERR-2` | Verification failed | The code was incorrect, expired, consumed or exhausted | Retry within remaining attempts, or request a new code |
| `AERR-3` | Rate limited | A protective limit refused the request | Retry after the indicated coarse interval |
| `AERR-4` | Temporarily locked | Abuse protection has barred the number | Retry after the lock period; no other remedy exists |
| `AERR-5` | Not authenticated | No valid session accompanies the request | Authenticate |
| `AERR-6` | Session invalid | The session has expired, been revoked, or was presented outside its binding | Authenticate again |
| `AERR-7` | Not authorized | The permission required is not held | Nothing; the request will not succeed as made |
| `AERR-8` | Tenant context required | A tenant-scoped decision was attempted with no active library | Select a library |
| `AERR-9` | Account not usable | The account's state does not permit the operation | Contact support; no self-service remedy |
| `AERR-10` | Conflict | The operation contradicts current state, or two operations collided | Re-read state and reconsider |
| `AERR-11` | Precondition unmet | A stated obligation blocks the operation, such as sole ownership blocking deletion | Discharge the obligation and retry |
| `AERR-12` | Dependency unavailable | A required component could not be reached | Retry later |
| `AERR-13` | Internal failure | An unexpected condition occurred | Retry later; report if persistent |

| ID | Requirement |
|---|---|
| `AUTH-11.41` | Every error returned MUST belong to exactly one class in this closed set |
| `AUTH-11.42` | `AERR-2` MUST NOT distinguish incorrect, expired, consumed and exhausted codes |
| `AUTH-11.43` | `AERR-3` MUST NOT disclose which limit was reached, the remaining quota, or a precise reset time |
| `AUTH-11.44` | `AERR-7` MUST be indistinguishable in content and shape from the resource not existing |
| `AUTH-11.45` | `AERR-9` MUST NOT disclose which state the account is in |
| `AUTH-11.46` | No error MUST disclose whether a mobile number is registered |
| `AUTH-11.47` | No error MUST contain personal data, a credential, a session identifier or a diagnostic detail useful to an attacker |
| `AUTH-11.48` | `AERR-12` and `AERR-13` MUST result in refusal, never in permissive fallback |
| `AUTH-11.49` | Error responses MUST be uniform in shape and timing across classes where variation would disclose information |

---

## 11.8 Business Continuity

| ID | Requirement |
|---|---|
| `AUTH-11.50` | Failure of the delivery provider MUST NOT affect existing sessions; only new authentication MUST be impaired |
| `AUTH-11.51` | The platform MUST be able to switch delivery providers without any change to this specification |
| `AUTH-11.52` | A delivery outage MUST be communicated to affected users as a delivery problem, distinct from a platform fault |
| `AUTH-11.53` | There MUST be no emergency bypass of authentication under any circumstance, including total delivery failure |
| `AUTH-11.54` | There MUST be no break-glass credential, master code, universal code or support-issued code |
| `AUTH-11.55` | Restoration from backup MUST NOT resurrect erased accounts, terminated sessions, revoked roles or expired trust |
| `AUTH-11.56` | Restoration MUST re-apply lifecycle states that post-date the backup point where those states bar access |
| `AUTH-11.57` | A partial failure MUST NOT leave an account in an undefined state; transitions MUST be atomic |
| `AUTH-11.58` | Degraded operation MUST preserve tenant isolation without exception |
| `AUTH-11.59` | Recovery procedures MUST be exercised, not merely documented |

---

## 11.9 Architectural Constraints

These constraints are permanent. Violating any of them invalidates the specification.

| ID | Constraint |
|---|---|
| `AUTH-11.60` | All credentials, sessions, devices, roles, permissions and policy decisions MUST reside solely within the Identity and Access context |
| `AUTH-11.61` | No other context MUST hold, cache authoritatively, or reimplement any part of authentication or authorization |
| `AUTH-11.62` | An account MUST be global; role assignments MUST be tenant-scoped |
| `AUTH-11.63` | Exactly one library MUST be active per session |
| `AUTH-11.64` | Authentication and authorization MUST remain distinct stages; a session MUST NOT be issued before an authorization context exists |
| `AUTH-11.65` | Sessions MUST carry no permissions; every decision MUST be evaluated at the moment it is made |
| `AUTH-11.66` | Revocation MUST be immediate and global |
| `AUTH-11.67` | Mobile OTP MUST be the sole authentication factor in the first version |
| `AUTH-11.68` | No password, PIN, security question or reusable secret MUST exist anywhere in the platform |
| `AUTH-11.69` | Display name MUST be collected before verification and MUST always be present |
| `AUTH-11.70` | Account creation MUST occur on first successful verification, and at no earlier point |
| `AUTH-11.71` | Communication with other contexts MUST occur solely through events |
| `AUTH-11.72` | Conformance MUST be judged on observable behaviour, never on internal structure |
| `AUTH-11.73` | No demo account, guest account, seeded account or bypass MUST exist in a release build |
| `AUTH-11.74` | Every control MUST fail closed |

---

## 11.10 Final Acceptance Criteria

The module is accepted when all of the following hold.

### Functional

| ID | Criterion |
|---|---|
| `AC-11.1` | Every acceptance criterion in Chapters 2 through 10 is demonstrably satisfied |
| `AC-11.2` | A new user completes registration and reaches a library in a single uninterrupted flow |
| `AC-11.3` | An existing user signs in and reaches their library without re-entering any detail beyond the code |
| `AC-11.4` | A user holding roles in several libraries selects among them and operates in exactly one at a time |
| `AC-11.5` | An invited person claims their account and inherits precisely the roles prepared for them |
| `AC-11.6` | Every lifecycle state and every valid transition is reachable and behaves as specified |
| `AC-11.7` | Every transition listed as invalid is refused |
| `AC-11.8` | Every event in the catalogue is emitted on its trigger and never otherwise |

### Security

| ID | Criterion |
|---|---|
| `AC-11.9` | No password, PIN or reusable secret exists anywhere in the platform |
| `AC-11.10` | An OTP verifies exactly once and never after expiry |
| `AC-11.11` | Every rate limit and lock behaves as specified and cannot be bypassed by any role |
| `AC-11.12` | No response discloses whether a mobile number is registered |
| `AC-11.13` | A session presented outside its binding is refused and raises an alert |
| `AC-11.14` | Revocation takes effect at the next use, globally, without client cooperation |
| `AC-11.15` | No role can impersonate an account, read an OTP, or elevate its own access |
| `AC-11.16` | Every cross-tenant access attempt is refused and alerted immediately |
| `AC-11.17` | Every control fails closed when its dependency is unavailable |

### Privacy and compliance

| ID | Criterion |
|---|---|
| `AC-11.18` | Authentication holds no personal attribute beyond mobile number and display name |
| `AC-11.19` | Mobile numbers are masked everywhere except to their own holder |
| `AC-11.20` | No library can learn anything about an account's participation in another library |
| `AC-11.21` | A holder can obtain, correct and erase their data unaided |
| `AC-11.22` | Erasure is genuine, irreversible and survives backup restoration |
| `AC-11.23` | Retention periods are enforced automatically |
| `AC-11.24` | Minors' data is reachable only by the minor, their linked guardian, and roles strictly requiring it |

### Operational

| ID | Criterion |
|---|---|
| `AC-11.25` | Every performance target in §11.2 is met under the first-version load envelope |
| `AC-11.26` | Every availability target in §11.3 is met over a full measurement period |
| `AC-11.27` | Every signal in §11.5 is emitted and queryable |
| `AC-11.28` | Cross-tenant attempts and binding violations alert with no threshold |
| `AC-11.29` | No observability signal contains personal data or a credential |
| `AC-11.30` | Recovery procedures have been exercised and produce the specified outcome |

### Architectural

| ID | Criterion |
|---|---|
| `AC-11.31` | No credential, session, device, role or policy exists outside the Identity and Access context |
| `AC-11.32` | No context reads Authentication state other than through events |
| `AC-11.33` | Sessions carry no permissions |
| `AC-11.34` | Authentication and authorization remain distinct stages |
| `AC-11.35` | No release build contains a demo account, guest account, seeded account or bypass |
| `AC-11.36` | Conformance is demonstrated against behaviour, not internal structure |
| `AC-11.37` | Every configurable parameter is externalised and changeable without altering this specification |

---

## 11.11 Out of Scope

Permanently outside Authentication, in this and every future version:

| Area | Owning concern |
|---|---|
| Usernames and handles | Not part of the product; identity is the mobile number |
| Student and member profiles | Member management |
| Memberships, plans and enrolment | Membership |
| Attendance and presence | Attendance |
| Seat allocation and reservation | Seating |
| Fees, invoices, payments and refunds | Billing |
| Library configuration and operating hours | Library management |
| Notification channels, templates and delivery | Notification |
| Audit storage, retention and querying | Audit |
| Reporting, dashboards and analytics | Analytics |
| Search and discovery | Discovery |
| Support ticketing and case management | Support |
| Marketing, campaigns and communications | Marketing |
| Business workflows of every kind | Their respective contexts |

Outside the first version but within Authentication's eventual remit: additional authentication factors, federated
identity, delegated administration beyond the defined roles, and organisation-level identity for library chains.

| ID | Requirement |
|---|---|
| `AUTH-11.75` | Authentication MUST NOT acquire responsibility for any area listed as belonging to another context |
| `AUTH-11.76` | A requirement that appears to need one of these areas MUST be resolved by an event, not by absorbing the responsibility |

---

## 11.12 Future Evolution

Roadmap only. Nothing here is a first-version commitment, and nothing here may be relied upon by any other
specification.

| Stage | Direction | Rationale |
|---|---|---|
| Near | Email as an alternative delivery channel for the one-time code | Reduces dependence on a single operator relationship and on message delivery reliability |
| Near | Federated sign-in with major consumer identity providers | Removes delivery cost and latency for users who already hold such an identity |
| Medium | Device-bound passkeys | Eliminates the delivery channel entirely and materially raises assurance |
| Medium | A second factor for privileged roles | Owners and platform roles carry disproportionate risk and warrant stronger proof |
| Medium | Risk-adaptive authentication | Vary friction by signal rather than applying uniform friction to everyone |
| Longer | Enterprise federation for institutional customers | Required by educational institutions and library chains with existing directories |
| Longer | Organisation-level identity above the library | Chains need administration spanning their branches without per-branch assignment |
| Longer | Delegated administration | Larger tenants need to distribute administrative duty without granting ownership |

| ID | Requirement |
|---|---|
| `AUTH-11.77` | Every future method MUST satisfy every security and privacy requirement in this document without relaxation |
| `AUTH-11.78` | Adding a method MUST NOT alter the account model, the tenancy model or the stage separation |
| `AUTH-11.79` | Adding a method MUST NOT introduce a reusable secret |
| `AUTH-11.80` | A user MUST NOT be compelled to adopt a new method; existing methods MUST remain usable until formally withdrawn |
| `AUTH-11.81` | Withdrawal of a method MUST be announced in advance and MUST NOT strand any account |

---

## 11.13 Final Summary

### What this specification defines

Authentication in Liboora establishes who a person is, once, globally, and makes that identity usable across every
library the person belongs to. It rests on a single factor — a one-time code sent to a mobile number — chosen because
it matches how the market actually behaves and because it introduces no reusable secret to be lost, guessed or
stolen.

The account is global; participation is tenant-scoped. A person registers once and may hold different roles at
different libraries without maintaining separate identities. Exactly one library is active at a time, and every
tenant-scoped decision is evaluated against that library alone. This is the mechanism by which a shared identity does
not become a shared exposure.

Authentication and authorization are deliberately separate stages. Proving who you are does not by itself admit you;
a session is issued only after the platform has confirmed the account is usable and established what the person may
do in the library they are entering. Sessions carry no permissions, so revocation is immediate everywhere and needs
no cooperation from any client.

Everything Authentication tells the rest of the platform, it tells through events. Nothing else reads its state.
Every security-relevant action is audited immutably. Every occurrence that could indicate compromise notifies the
person affected, because in a single-factor system the user's own awareness is a control, not a courtesy.

### The commitments

| Commitment | Guarantee |
|---|---|
| One identity | A person registers once and is known across every library |
| No reusable secret | Nothing exists that can be stolen and replayed indefinitely |
| Immediate revocation | Access can be withdrawn everywhere, at once, unilaterally |
| Tenant isolation | No library learns anything about another library's relationship with a person |
| Minimal data | Two personal attributes, held for one purpose, erased on request |
| Fail closed | Uncertainty always resolves to refusal |
| No bypass | No emergency route, master code or privileged shortcut exists |
| Behavioural conformance | Compliance is judged by what the system does, not how it is built |

### The boundary

Authentication owns credentials, sessions, devices, roles, permissions and policy decisions. It owns nothing else. It
does not know what a membership is, what attendance means, how fees are calculated or how a seat is allocated. That
ignorance is intentional and must be preserved: it is what allows every other context to evolve without renegotiating
identity, and what allows identity to be reasoned about, tested and secured on its own terms.

### Standing

This document is the authoritative specification for Authentication in Liboora. Its eleven chapters are complete and
mutually consistent. Requirements marked MUST are binding. Configurable parameters are externalised and listed in the
control section, and may be changed by decision without amending this document. Everything else requires a
specification change.

**End of specification.**
