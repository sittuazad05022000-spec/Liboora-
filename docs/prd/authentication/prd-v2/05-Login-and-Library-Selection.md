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
