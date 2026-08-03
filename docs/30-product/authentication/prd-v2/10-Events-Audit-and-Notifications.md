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
