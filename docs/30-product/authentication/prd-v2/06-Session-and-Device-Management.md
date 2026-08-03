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
| **Idle** — elapsed since last activity | 30 days | 30 minutes |
| **Absolute** — elapsed since creation | 90 days | 12 hours |

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

`AUTH-6.46` — Trust **MUST** expire `CFG-7` (90 days) after it was established.

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
| `BR-6.7` | Staff and platform sessions use 30-minute idle and 12-hour absolute limits, matching NIST SP 800-63B AAL2 |
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
| `AC-6.6` | A staff session is refused after 30 minutes idle or 12 hours from creation, whichever comes first |
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
| `AC-6.21` | Trust expires 90 days after establishment and is restored only by authenticating again |
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
