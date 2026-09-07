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
