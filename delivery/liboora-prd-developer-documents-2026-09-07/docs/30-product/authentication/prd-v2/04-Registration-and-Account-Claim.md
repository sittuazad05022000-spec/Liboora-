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
