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
