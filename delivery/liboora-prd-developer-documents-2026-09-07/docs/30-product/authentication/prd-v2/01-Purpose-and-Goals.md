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
