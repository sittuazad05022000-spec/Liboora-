# Liboora — Configuration Guide

| Field | Value |
|---|---|
| **Version** | v1.1 |
| **Status** | Normative for operations |
| **Date** | 2026-08-02 · **extended 2026-08-03** |
| **Governs** | `CFG-1` … `CFG-12` (Authentication PRD v2.0 §E) · **`LCFG-1` … `LCFG-13`** (Library PRD v1.0 §16.1, §14B.9) · **`ICFG-1` … `ICFG-10`** (Invitation Security Specification §11) |
| **Authority** | Subordinate to the PRDs. This guide sets values **within** the envelope they define; it cannot change the envelope |

---

## 1. How to read this guide

The PRDs declare **thirty-five** configurable parameters — twelve authentication (`CFG-*`), thirteen library
(`LCFG-*`) and ten invitation (`ICFG-*`). Configurable means: the value can change per environment or per deployment
**without changing the specification, the architecture, or any interface**.

This guide gives, for each parameter:

- the **recommended default** and the standard or analysis it is anchored to
- the **permitted range** and what breaks outside it
- the **validation** that must run at startup
- the **failure mode** if the value is wrong
- who **owns** the decision to change it

**Every default in this guide is a considered engineering position, not a placeholder.** Where a value is anchored
to an external standard, the standard is named. Where it is anchored to an operational analysis of the Indian
study-hall market, the analysis is stated.

### What is NOT configurable

The following are **structural facts** fixed by architecture. They are not in this guide and must not be exposed as
configuration. Changing one requires a change to the PRD.

| Fact | Value |
|---|---|
| OTP code length | 6 numeric digits |
| OTP challenge validity | 5 minutes |
| Verification attempts per challenge | 5 |
| Challenge reuse | Single-use |
| Concurrent challenges per mobile number | 1 |
| Authentication factors in V1 | Mobile OTP only |
| Active libraries per session | Exactly 1 |
| `IT-1` / `IT-2` invitation entropy | 128 bits |
| `IT-3` access code entropy | ≥ 40 bits, 8 characters, unambiguous alphabet |
| Invitation types | Exactly three — `IT-1`, `IT-2`, `IT-3` |
| Protected operations requiring authentication | The closed list `PO-1` … `PO-12` |
| Public profile fields | The allow-list in §14A.5 |
| Invitation single-use policy | `IT-1`, `IT-2` single-use; `IT-3` multi-use bounded by `ICFG-6` |

Exposing any of these as a tunable is a **defect**, because operators could then configure the system out of
conformance with its own specification.

**Two of these deserve emphasis, because they look configurable.** The `PO-1`…`PO-12` list is closed: adding a
protected operation is a specification change, and *removing* one silently makes a member-only capability
anonymous. Likewise the public field allow-list — a deployment that could add a field to it could publish a mobile
number, which under `MP-GBR-25` is the sole authentication factor. Neither belongs in a configuration file.

---

## 2. Parameter register

### CFG-1 — OTP requests per mobile number, rolling 1 hour

| | |
|---|---|
| **Default** | **5** |
| **Range** | 3 – 10 |
| **Unit** | requests |
| **Chapter** | 8 (`AUTH-8.16`–`AUTH-8.23`) |
| **Owner** | Security |

**Rationale.** Five covers the legitimate worst case — one code not delivered, one mistyped number, one retry after
a network failure, plus margin — while keeping SMS cost per number bounded. This matches the prevailing pattern
across Indian consumer platforms, which users are already calibrated to.

**Below 3:** a user with genuinely poor SMS delivery cannot sign in at all. **Above 10:** per-number cost becomes
an attack surface — an attacker burns your SMS budget one number at a time.

**Failure mode if too low:** legitimate lockouts, support load, churn. **If too high:** SMS cost amplification.

---

### CFG-2 — Minimum interval between OTP requests for one number

| | |
|---|---|
| **Default** | **30 seconds** |
| **Range** | 15 – 60 seconds |
| **Unit** | seconds |
| **Chapter** | 8 |
| **Owner** | Security |

**Rationale.** Indian SMS delivery is routinely 5–20 seconds and occasionally slower. Thirty seconds is long enough
that a user who waits will usually have received the code, and short enough that the wait does not feel broken. It
must be shorter than the 5-minute challenge validity by a wide margin, or resending becomes pointless.

**Below 15 s:** users resend before delivery completes, multiplying cost and confusing themselves about which code
is current. **Above 60 s:** perceived as a fault.

**Interaction:** `CFG-2` × `CFG-1` = 2.5 minutes minimum to exhaust the per-number quota. Keep that below the
`CFG-4` lock duration.

---

### CFG-3 — OTP requests per source network origin, rolling 1 hour

| | |
|---|---|
| **Default** | **100** |
| **Range** | 50 – 500 |
| **Unit** | requests |
| **Chapter** | 8 |
| **Owner** | Security + Operations jointly |

**Rationale — this default was corrected during enterprise review.** A study hall is a **single NAT gateway with
sixty to two hundred students behind it.** At an origin quota of 30/hour, the twentieth student to arrive on a
Monday morning is refused a code because nineteen classmates already used the shared quota — and nothing they can
do will fix it. The control would have caused a total sign-in outage for exactly the venue type the product
targets.

100/hour tolerates a normal arrival burst while still stopping bulk enumeration, because per-number limits
(`CFG-1`, `CFG-2`) already make each individual number expensive to attack. The origin limit is a **second** line
of defence, not the first, and must be tuned so it never fires before the first line does.

**Below 50:** shared-connection venues lock out. **Above 500:** the control stops meaning anything.

**Deployment note.** Where the platform sits behind a CDN or load balancer, the origin must be derived from the
true client address, not the proxy address. Getting this wrong makes **every** user share **one** origin bucket and
takes the whole platform down.

**Failure mode if too low:** correlated, venue-wide lockout that looks like a platform outage and is invisible in
per-user metrics.

---

### CFG-4 — Temporary lock duration after request quota exhaustion

| | |
|---|---|
| **Default** | **30 minutes** |
| **Range** | 15 – 60 minutes |
| **Unit** | minutes |
| **Chapter** | 8, 9 |
| **Owner** | Security |

**Rationale — this default was corrected during enterprise review.** OWASP guidance is explicit that long hard
lockouts are themselves a denial-of-service vector: if an attacker knows a target's mobile number, a 60-minute lock
lets them keep that person out of the system all day for the cost of a handful of requests. Thirty minutes halves
the leverage while remaining long enough to make automated abuse uneconomic.

The lock is **temporary and self-clearing** (`Locked` → `Active` in Chapter 9). It is not an administrative
suspension and must never require support intervention to lift.

**Below 15 min:** attacker simply waits it out. **Above 60 min:** weaponisable against known numbers.

---

### CFG-5 — Idle session timeout

| | |
|---|---|
| **Default** | **30 days** (mobile) · **30 minutes** (staff) |
| **Range** | mobile 7 – 90 days · staff 15 – 60 minutes |
| **Chapter** | 6 |
| **Owner** | Security |

**Rationale — the staff value was corrected during enterprise review.** These are two different threat models
sharing one parameter name.

**Mobile (student, parent).** A personal device with device-level protection, used a few times a week. Thirty days
means a student who visits fortnightly is never signed out. A short timeout here buys nothing — the device lock is
the real control — and costs an OTP every visit.

**Staff (owner, manager, reception).** A **shared** device on a reception desk, physically accessible to anyone who
walks in. NIST SP 800-63B requires reauthentication after **30 minutes of inactivity at AAL2**, and this is exactly
the scenario the requirement exists for. The previous 12-hour value left an unattended reception tablet signed in
with full staff permissions for an entire working day. Anyone stepping behind the desk had a live session.

**Interaction:** `CFG-5` must be strictly less than `CFG-6` for the same audience, or the idle timeout never fires.

---

### CFG-6 — Absolute session lifetime

| | |
|---|---|
| **Default** | **90 days** (mobile) · **12 hours** (staff) |
| **Range** | mobile 30 – 180 days · staff 8 – 24 hours |
| **Chapter** | 6 |
| **Owner** | Security |

**Rationale — the staff value was corrected during enterprise review.** The absolute lifetime is the ceiling: the
session ends when it expires regardless of activity. It is the control that guarantees a stolen session token has a
finite life even if the thief keeps it warm.

**Staff = 12 hours** bounds a session to a **single working shift.** A session started at opening cannot survive to
the next day. The previous 7-day value meant a token stolen on Monday was still valid the following weekend, when
nobody is watching. Twelve hours also aligns with the NIST SP 800-63B AAL2 reauthentication ceiling.

**Mobile = 90 days** forces a periodic re-proof of number control, which is the only recurring check that catches a
device that changed hands.

**Constraint:** `CFG-6` > `CFG-5` for the same audience, always. Validate at startup.

---

### CFG-7 — Trusted-device trust lifetime

| | |
|---|---|
| **Default** | **90 days** |
| **Range** | 30 – 180 days |
| **Chapter** | 6 |
| **Owner** | Security |

**Rationale — this default was corrected during enterprise review.** Device trust suppresses friction, so its
lifetime is a direct security trade. The previous 180 days was twice the industry norm for "remember this device"
and, critically, **longer than the 90-day mobile session lifetime it was meant to complement** — trust outlived the
thing it was trusting.

90 days aligns the two: when the session reaches its absolute ceiling and the user re-proves number control, device
trust is re-established at the same moment. One cadence, not two.

**Constraint:** `CFG-7` ≤ `CFG-6` (mobile). Validate at startup.

---

### CFG-8 — Maximum concurrently registered devices per account

| | |
|---|---|
| **Default** | **10** |
| **Range** | 3 – 20 |
| **Chapter** | 6 |
| **Owner** | Product + Security |

**Rationale.** Ten accommodates a genuine user across phone, tablet, replacement handsets and a browser or two over
the device-trust window, without permitting the unbounded fan-out that would make account sharing free. When the
limit is reached the **user chooses** which device to remove — the system never silently evicts, because silent
eviction of the wrong device is indistinguishable from an attack.

**Below 3:** ordinary phone replacement causes support contact. **Above 20:** credential sharing becomes practical.

---

### CFG-9 — Pending-verification retention before discard

| | |
|---|---|
| **Default** | **24 hours** |
| **Range** | 1 – 72 hours |
| **Chapter** | 9 |
| **Owner** | Engineering |

**Rationale.** A `Pending Verification` record holds an unverified mobile number and a display name — personal data
for which no verified relationship yet exists. Twenty-four hours lets a user who abandoned mid-registration resume
the same day, then discards the data. Under DPDP, retaining unverified personal data indefinitely is not
defensible.

**Below 1 h:** a user interrupted by a phone call must start over. **Above 72 h:** accumulating unverified personal
data with no lawful purpose.

---

### CFG-10 — Soft-deleted account retention before permanent erasure

| | |
|---|---|
| **Default** | **30 days** |
| **Range** | 7 – 90 days |
| **Chapter** | 9 |
| **Owner** | Legal + Security |

**Rationale.** The grace window between `Pending Deletion` and `Deleted`, during which the user can recover from an
accidental or coerced deletion. Thirty days is the common consumer standard and is short enough to remain
defensible as erasure under DPDP.

**Important:** during this window the account is **not usable.** It cannot authenticate, hold a session, or appear
in any roster. Retention is for recovery only.

**Above 90 days:** difficult to defend as honouring an erasure request.

---

### CFG-11 — Account-claim verification failures before claim lock

| | |
|---|---|
| **Default** | **5 per 24 hours** |
| **Range** | 3 – 10 per 24 hours |
| **Chapter** | 4 |
| **Owner** | Security |

**Rationale.** Account claim is the path by which a person takes control of a record a library created for them. It
is a higher-value target than ordinary sign-in, because success grants an existing identity with existing history.
Five failures in 24 hours is deliberately tighter than the ordinary flow, and the 24-hour window is deliberately
longer than the `CFG-4` lock, because claim attacks are patient.

---

### CFG-12 — Platform Support elevated-access maximum duration

| | |
|---|---|
| **Default** | **1 hour** |
| **Range** | 30 minutes – 4 hours |
| **Chapter** | 2, 7 |
| **Owner** | Security + Legal |

**Rationale — this default was corrected during enterprise review.** This is the window in which a Liboora
employee holds elevated access into a customer's tenant. It is the single highest-privilege state in the platform
and the one with the weakest structural control, since the actor is trusted by definition.

Just-in-time least privilege says this window should be **as short as the task allows, not as long as the shift.**
One hour covers a normal support interaction; anything longer is a new, separately consented, separately audited
grant. The previous 4-hour value made elevated access effectively a half-day standing privilege.

Elevation is always **time-boxed, consented, and audited** (`AUTH-7.19`). Expiry is automatic and requires no
action to revoke.

**Above 4 hours:** elevated access stops being exceptional.

---

## 2A. Library parameter register — `LCFG-1` … `LCFG-13`

Declared by [`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) §16.1 and
[`14B-Public-Library-Preview.md`](../30-product/library/14B-Public-Library-Preview.md) §14B.9.

Presented in table form rather than one block per parameter. Most are locale or sanity bounds whose reasoning is one
line; the four carrying security weight are expanded below the table.

| # | Parameter | Default | Range | Owner | Rationale |
|---|---|---|---|---|---|
| `LCFG-1` | Time zone | `Asia/Kolkata` | Any IANA zone | Product | Every V1 library is in India (`MP-DEP-03` DLT registration) |
| `LCFG-2` | Language | `en` | Supported set | Product | Only locale with complete strings at V1 |
| `LCFG-3` | Currency | `INR` | ISO 4217 | Product | Follows `LCFG-1` |
| `LCFG-4` | Date format | `dd/MM/yyyy` | Enumerated | Product | Indian convention. `MM/dd` is a data-entry hazard, not a preference |
| `LCFG-5` | Member directory | **Disabled** | on / off | **Security** | **Deny by default** (`AP-3`). Exposes members to members; must be opted into |
| `LCFG-6` | Discovery index propagation | **60 s** | 0 – 300 s | **Security** | Public index is eventually consistent. **Removal latency only** — see below |
| `LCFG-7` | Gallery images per branch | **20** | 1 – 50 | Product | Storage and page-weight bound |
| `LCFG-8` | Facilities in reference list | **50** | 10 – 200 | Product | Prevents unbounded growth of a public filter facet |
| `LCFG-9` | Floors per branch | **10** | 1 – 50 | Product | Sanity bound |
| `LCFG-10` | Zones per floor | **20** | 1 – 100 | Product | Sanity bound |
| `LCFG-11` | Preserved intent TTL | **30 min** | 5 – 120 min | **Security** | Exceeds a full OTP round trip while bounding stale-intent resumption |
| `LCFG-12` | Public search page size | **20** | 5 – 50 | **Security** | Bounds enumeration rate and page weight |
| `LCFG-13` | Public preview cache TTL | **300 s** | 0 – 3600 s | **Security** | Absorbs anonymous load. **Never** applies to an authorization decision |

### `LCFG-5` — why the default is off

A member directory is a list of everyone who studies at a library, together with the fact that they study there. In
a domain where the users are largely students and a meaningful share are minors, that is not a neutral feature.
Deny by default (`AP-3`) is not caution here; it is the only defensible starting position. A library that wants a
directory can enable one, having made that choice deliberately.

### `LCFG-6` — the value most likely to be misused

This is the propagation delay of the **public discovery search index**, and it exists for exactly one purpose:
bounding how long a library just switched from Public to Private can still appear in search results.

**It must never be consulted on an authorization path** (`LIB-16.9`). The reason is `MP-GBR-26`, which requires
revocation to be immediate and global *"with no propagation window"*. A 60-second index delay **is** a propagation
window. Wiring it into a permission, membership, suspension or revocation check would violate a Rank 1 global rule
using a Rank 7 configuration value — precisely the inversion the precedence order exists to prevent.

Its presence in a search index is safe because the index answers *"what might be worth showing?"*, never *"is this
caller allowed?"*.

### `LCFG-11` — bounded from both directions

Two invariants, pulling in opposite directions:

- `INV-11` — must be **greater** than `CFG-2` × `CFG-1`, the longest a legitimate OTP flow can take. Otherwise a
  user who uses the retries the system explicitly grants them loses the thing they were trying to do.
- `INV-10` — must be **no greater** than `CFG-6`, the absolute session lifetime. An intent outliving every session
  capable of resuming it is unreachable.

At the recommended defaults the permitted window is 2.5 minutes to 90 days, and 30 minutes sits comfortably inside
it. If `CFG-1`, `CFG-2` or `CFG-6` is retuned this value must be re-checked — startup validation will catch it, but
whoever changes `CFG-2` should know they are touching two subsystems.

### `LCFG-13` — a cache is not a source of truth

The public preview is served from a projection and may be cached for anonymous callers. That is safe because the
projection contains only explicitly public fields (`LIB-7.1`).

**It stops being safe the moment a cached value decides anything.** A cached *"this library is Public"* answer is
not authority to serve its data 300 seconds after it went Private. The cache answers *what to render*; the
projection's current contents answer *what exists*; `BC-18` answers *who may act*. Three different questions.

---

## 2B. Invitation parameter register — `ICFG-1` … `ICFG-10`

Declared by
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) §11.
**Every parameter in this register is security-owned.** There is no locale or cosmetic value here.

| # | Parameter | Default | Range | Rationale |
|---|---|---|---|---|
| `ICFG-1` | `IT-1` staff invitation TTL | **48 h** | 1 h – 7 d | Two working days covers a staff member invited Friday to start Monday. Past a week an unaccepted administrative grant is stale and its intent unverifiable |
| `ICFG-2` | `IT-2` private library invitation TTL | **7 d** | 1 h – 30 d | A student may take a week to act. Grants only the *opportunity* to join, so the blast radius is far smaller than `IT-1` |
| `ICFG-3` | `IT-3` access code TTL | **24 h** | 1 h – 7 d | Shortest of the three: lowest entropy, multi-use, shared aloud. Time is its primary compensating control |
| `ICFG-4` | Acceptance window after first use | **15 min** | 5 – 60 min | The gap between presenting an invitation and completing OTP. Long enough for a delayed SMS, short enough that an abandoned half-flow does not linger |
| `ICFG-5` | Outstanding invitations per library | **50** | 1 – 500 | Bounds the damage of a compromised Owner account, and the cost of enumeration |
| `ICFG-6` | Max acceptances per `IT-3` code | **25** | 1 – 200 | A classroom-sized cohort. A library needing more than this should be Public |
| `ICFG-7` | Invitations creatable per hour per library | **20** | 1 – 100 | Rate limit on the **issuing** side |
| `ICFG-8` | Presentations per origin per hour | **20** | 5 – 100 | Well above legitimate use; far below what makes guessing viable |
| `ICFG-9` | Failed presentations before progressive throttling | **10** | 3 – 50 | Tolerates typos in a transcribed `IT-3` code |
| `ICFG-10` | Throttle duration after threshold | **30 min** | 5 – 120 min | Matches `CFG-4`. Long locks are themselves a DoS vector (OWASP) |

### The three TTLs are ordered, and the order is the security argument

`ICFG-3` (24 h) ≤ `ICFG-2` (7 d) is enforced as `INV-14`. This looks like an arbitrary tidiness rule and is not.

`IT-3` access codes are deliberately the weakest artefact in the system: eight characters, ≥40 bits of entropy, an
unambiguous alphabet, multi-use, designed to be read aloud to a room. That weakness is acceptable **only** while
their exposure window stays short — a short-lived low-entropy code paired with `ICFG-8` presentation limits is
sound; a long-lived one is a guessing target. Allowing `ICFG-3` to exceed `ICFG-2` would leave the weakest artefact
in circulation the longest, inverting the entire reason a weak artefact is permitted at all.

### `ICFG-8` is what makes 40 bits sufficient

Forty bits is not, on its own, a comfortable secret. It becomes sufficient because presentations are capped at 20
per origin per hour: the expected time to guess an eight-character code at that rate is far longer than the
24-hour window `ICFG-3` allows it to exist.

**Raising `ICFG-8` therefore weakens `IT-3` even though the entropy figure does not change.** These two values are a
single control expressed in two places. Neither can be tuned by looking only at its own row.

---

## 3. Cross-parameter invariants

These must be **validated at application startup**. A violation is a fatal configuration error — fail fast and
loudly. A silently inconsistent security configuration is worse than a wrong one, because nobody notices.

| # | Invariant | Why |
|---|---|---|
| **INV-1** | `CFG-5` (mobile) < `CFG-6` (mobile) | Otherwise the idle timeout never fires |
| **INV-2** | `CFG-5` (staff) < `CFG-6` (staff) | Same |
| **INV-3** | `CFG-7` ≤ `CFG-6` (mobile) | Device trust must not outlive the session it complements |
| **INV-4** | `CFG-2` × `CFG-1` < `CFG-4` | Quota must be reachable in less time than the resulting lock |
| **INV-5** | `CFG-3` > `CFG-1` | An origin limit that fires before the per-number limit makes the per-number limit dead code |
| **INV-6** | `CFG-2` < 300 s (OTP validity) | Otherwise a resend arrives after the previous challenge has already expired |
| **INV-7** | `CFG-5` (staff) ≤ 30 min | NIST SP 800-63B AAL2 ceiling — a compliance floor, not a preference |
| **INV-8** | `CFG-6` (staff) ≤ 24 h | Session must not span more than one calendar day on a shared device |
| **INV-9** | Every value within its declared range | Range violations indicate a bad deployment, not a considered choice |
| **INV-10** | `LCFG-11` ≤ `CFG-6` (mobile) | A preserved intent must not outlive the longest session that could resume it |
| **INV-11** | `LCFG-11` > `CFG-2` × `CFG-1` | A user who uses every OTP retry the system grants must not lose their intent |
| **INV-12** | `LCFG-13` ≤ 3600 s | Preview cache staleness must be bounded |
| **INV-13** | `ICFG-1` ≤ 7 d | A staff invitation must not outlive any plausible administrative window |
| **INV-14** | `ICFG-3` ≤ `ICFG-2` | The weakest artefact (`IT-3`) must never live the longest |
| **INV-15** | `ICFG-4` > `CFG-2` × `CFG-1` | An invitee must not time out part-way through authentication |
| **INV-16** | `ICFG-6` ≥ 1 | An `IT-3` code that nobody can redeem is a configuration error, not a policy |

Startup validation must report **all** violations, not just the first — an operator fixing a configuration should
see the complete list once.

**`INV-11` and `INV-15` are the same constraint applied to two different subsystems**, and both exist because the
failure they prevent is invisible in development. Each bounds a timeout *below* the maximum legitimate duration of
an authentication flow. A developer testing with an instant OTP will never reach it; a real user on a slow network,
using the retries `CFG-1` explicitly permits, reaches it every time. This is why they are startup-validated rather
than left to review: nobody reads two documents at once, and the constraint spans two.

**Seven invariants now cross module boundaries** (`INV-10`…`INV-16` all reference a `CFG-*` value or another
register's value). Changing an authentication parameter can therefore invalidate a library configuration. That is
not a design flaw to be removed by decoupling them — the coupling is real, because the OTP flow really does sit in
the middle of the invitation and preview journeys. It is a reason the validation must be mechanical.

---

## 4. Environment profiles

| Parameter | Development | Staging | **Production** |
|---|---|---|---|
| `CFG-1` | 20 | 5 | **5** |
| `CFG-2` | 0 s | 30 s | **30 s** |
| `CFG-3` | 1000 | 100 | **100** |
| `CFG-4` | 1 min | 30 min | **30 min** |
| `CFG-5` mobile | 30 d | 30 d | **30 d** |
| `CFG-5` staff | 8 h | 30 min | **30 min** |
| `CFG-6` mobile | 90 d | 90 d | **90 d** |
| `CFG-6` staff | 24 h | 12 h | **12 h** |
| `CFG-7` | 90 d | 90 d | **90 d** |
| `CFG-8` | 20 | 10 | **10** |
| `CFG-9` | 1 h | 24 h | **24 h** |
| `CFG-10` | 1 d | 30 d | **30 d** |
| `CFG-11` | 20 | 5 | **5** |
| `CFG-12` | 4 h | 1 h | **1 h** |
| `LCFG-6` | 0 s | 60 s | **60 s** |
| `LCFG-11` | 120 min | 30 min | **30 min** |
| `LCFG-12` | 50 | 20 | **20** |
| `LCFG-13` | 0 s | 300 s | **300 s** |
| `ICFG-1` | 7 d | 48 h | **48 h** |
| `ICFG-2` | 30 d | 7 d | **7 d** |
| `ICFG-3` | 7 d | 24 h | **24 h** |
| `ICFG-4` | 60 min | 15 min | **15 min** |
| `ICFG-5` | 500 | 50 | **50** |
| `ICFG-6` | 200 | 25 | **25** |
| `ICFG-7` | 100 | 20 | **20** |
| `ICFG-8` | 100 | 20 | **20** |
| `ICFG-9` | 50 | 10 | **10** |
| `ICFG-10` | 5 min | 30 min | **30 min** |

`LCFG-1`…`LCFG-5` and `LCFG-7`…`LCFG-10` are **per-library settings, not per-environment**. They are set by each
library through `BC-25` and do not appear in this table; the defaults in §2A apply on creation.

**Rules.

1. **Production uses the recommended defaults.** A production deviation requires a recorded decision and an owner.
2. **Development relaxations are relaxations of `CFG-*` only.** They must never disable a control, never bypass OTP,
   and never introduce a demo account or a code-peek surface — that is `MP-CON-11` and no environment profile can
   override it.
3. **Staging matches production** except where a shorter value is needed to test expiry. Staging exists to find
   configuration problems before production does; if it differs, it cannot.
4. **`INV-1` … `INV-16` are validated in every environment, including development.** Relaxed values must still be
   internally consistent.
5. **Development relaxations of `ICFG-8` and `ICFG-9` are the most dangerous ones in this table.** They are the
   controls that make `IT-3`'s deliberately low entropy safe. Relaxing them in development is acceptable; letting
   the relaxed value reach production removes the compensating control while leaving the entropy figure — and
   therefore every document that cites it — apparently unchanged.

---

## 5. Change control

| Change | Requires |
|---|---|
| Value within its declared range | Owner approval, recorded in the deployment change log |
| Value outside its declared range | An ADR. The range is part of the reasoning, not a formality |
| Adding a parameter | A PRD amendment — the specification declares what is configurable, this guide does not |
| Promoting a structural fact to configurable | An ADR **and** a PRD amendment |

**A value changed in one environment and not the others is a defect.** Divergence must be intentional, recorded,
and time-boxed.

---

## 6. Observability

Each parameter must be observable in production, or you are operating blind on the value.

| Parameter | Emit | Alert when |
|---|---|---|
| `CFG-1` | Per-number quota exhaustion rate | Sustained rise — either abuse or an SMS delivery failure |
| `CFG-3` | Per-origin quota exhaustion, with origin | **Any** production trigger — investigate before assuming abuse. This is the NAT-gateway failure mode |
| `CFG-4` | Locks applied, locks expired | Locks rising without matching `CFG-1` exhaustion |
| `CFG-5`/`CFG-6` | Session terminations by cause | Staff idle-timeout rate near zero — the setting is probably not taking effect |
| `CFG-7` | Trust grants and expiries | Grants far exceeding sign-ins |
| `CFG-8` | Device-limit refusals | Rising — either sharing or a device-identity bug |
| `CFG-12` | **Every** elevation: actor, tenant, duration, consent reference | **Every** elevation is alertable. This is not sampled |
| `LCFG-6` | Public→Private transitions, and index removal latency | Latency exceeding the configured value — the index is lagging its own bound |
| `LCFG-12` | Public search request rate per origin | Sustained high-rate paging — enumeration of the public directory |
| `ICFG-7` | Invitations created per library per hour | A library at its ceiling — either bulk onboarding or a compromised Owner account |
| `ICFG-8`/`ICFG-9` | Failed invitation presentations, by origin | **Any** sustained failure rate. Legitimate users mistype once, not repeatedly |
| `ICFG-6` | `IT-3` codes reaching their acceptance ceiling | Codes hitting the ceiling routinely — the library should probably be Public |

**Invitation presentation failures are the highest-signal metric in this guide.** A valid invitation is delivered
directly to one person, so a legitimate failure is a typo or an expiry. A *pattern* of failures against different
identifiers from one origin is someone guessing, and there is no benign explanation for it.

---

## 7. References

Authentication PRD v2.0 §E and §F · Chapters 4, 6, 7, 8, 9 ·
`ACN-001-OTP-Request-Rate-Limiting.md` (closed) ·
NIST SP 800-63B (AAL2 reauthentication) · OWASP Authentication Cheat Sheet (lockout as DoS) ·
`DOCUMENTATION_BASELINE.md` · `ADR-0002` ·
[`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) §16.1 ·
[`14B-Public-Library-Preview.md`](../30-product/library/14B-Public-Library-Preview.md) §14B.9 ·
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) §11 ·
`ADR-0009`, `ADR-0010`

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-03 | Added the Library register `LCFG-1`…`LCFG-13` (§2A) and the invitation register `ICFG-1`…`ICFG-10` (§2B), with expanded reasoning for the seven that carry security weight. Added invariants `INV-10`…`INV-16`. Extended §1 "not configurable" with invitation entropy, the closed `IT-*` set, the closed `PO-1`…`PO-12` list and the public field allow-list. Added environment profiles and observability rules for the new parameters. **No `CFG-*` value changed.** |
| v1.0 | 2026-08-02 | Created. `CFG-1`…`CFG-12` with ranges, rationale, invariants `INV-1`…`INV-9`, profiles and observability. Six values reset to standards-anchored defaults. Closes audit finding `G-3`. |
