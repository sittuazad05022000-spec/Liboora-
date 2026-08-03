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
