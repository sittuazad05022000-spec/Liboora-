# Liboora — Configuration Guide

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Status** | Normative for operations |
| **Date** | 2026-08-02 |
| **Governs** | `CFG-1` … `CFG-12` declared in Authentication PRD v2.0 §E |
| **Authority** | Subordinate to Authentication PRD v2.0. This guide sets values **within** the envelope the PRD defines; it cannot change the envelope |

---

## 1. How to read this guide

Authentication PRD v2.0 declares twelve **configurable parameters**. Configurable means: the value can change per
environment or per deployment **without changing the specification, the architecture, or any interface**.

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

Exposing any of these as a tunable is a **defect**, because operators could then configure the system out of
conformance with its own specification.

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

Startup validation must report **all** violations, not just the first — an operator fixing a configuration should
see the complete list once.

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

**Rules.**

1. **Production uses the recommended defaults.** A production deviation requires a recorded decision and an owner.
2. **Development relaxations are relaxations of `CFG-*` only.** They must never disable a control, never bypass OTP,
   and never introduce a demo account or a code-peek surface — that is `MP-CON-11` and no environment profile can
   override it.
3. **Staging matches production** except where a shorter value is needed to test expiry. Staging exists to find
   configuration problems before production does; if it differs, it cannot.
4. **`INV-1` … `INV-9` are validated in every environment, including development.** Relaxed values must still be
   internally consistent.

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

---

## 7. References

Authentication PRD v2.0 §E and §F · Chapters 4, 6, 7, 8, 9 ·
`ACN-001-OTP-Request-Rate-Limiting.md` (closed) ·
NIST SP 800-63B (AAL2 reauthentication) · OWASP Authentication Cheat Sheet (lockout as DoS) ·
`DOCUMENTATION_BASELINE.md` · `ADR-0002`
