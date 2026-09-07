# Chapter 9 — Account Lifecycle

## 9.1 Purpose

### Why a lifecycle is specified

An account is not a static record. It comes into existence, becomes usable, may lose and regain usability, may be
withdrawn from service temporarily or permanently, and may have its single identifying attribute replaced. Each of
these moments changes what the holder can do and what the platform must permit. If those moments are not defined
precisely, the same account can be interpreted differently by different parts of the platform, and access decisions
become inconsistent.

The lifecycle also determines the **security posture** of an account. A suspended account that can still obtain a
session is a defect. A deleted account whose data can be recovered by re-registering the same number is a privacy
breach. A number change that leaves old sessions alive defeats the primary remedy for a compromised SIM. The
lifecycle is therefore a security specification as much as a product one.

### The single-owner rule

Account state is owned exclusively by Authentication. No library, no business module and no external system may hold
its own notion of whether an account is usable. Modules may hold their own **membership** state — whether a student
is enrolled, active, on hold or discontinued at a particular library — but that is a different concept and must never
be conflated with account state. A student may be discontinued at every library and still hold a perfectly valid
account; an account may be suspended while every membership remains active.

### Global state, tenant-scoped participation

Because one account spans many libraries, account state is **global**. Suspension applies everywhere. Deletion
applies everywhere. A library cannot suspend an account; it can only remove the roles it granted. This distinction is
the single most important idea in this chapter and is enforced throughout.

| ID | Requirement |
|---|---|
| `AUTH-9.1` | Account state MUST be owned solely by Authentication and MUST NOT be duplicated, cached authoritatively, or overridden by any other context |
| `AUTH-9.2` | Account state MUST be global; it MUST NOT vary by library |
| `AUTH-9.3` | Account state MUST be distinct from membership state, and the two MUST NOT be conflated in any decision |
| `AUTH-9.4` | No tenant role MUST be able to change account state; tenant roles MAY only grant or revoke roles within their own library |
| `AUTH-9.5` | Every state and every transition MUST be explicit; there MUST be no implicit or undefined state |

---

## 9.2 Account States

An account is in exactly one state at any moment.

| State | Meaning | Can authenticate | Can obtain a session | Holds data |
|---|---|---|---|---|
| **Pending Verification** | A registration or claim was begun but the mobile number has not yet been verified | Yes, to complete verification | No | Provisional only |
| **Active** | Verified and usable | Yes | Yes, subject to holding a role | Yes |
| **Inactive** | Verified and usable but currently holds no role in any library | Yes | No | Yes |
| **Locked** | Temporarily barred following abuse-protection triggers | No | No | Yes |
| **Suspended** | Administratively barred pending review or resolution | No | No | Yes |
| **Disabled** | Permanently barred by platform decision | No | No | Yes |
| **Pending Deletion** | Deletion requested; within the retention window and reversible | No | No | Yes, retained |
| **Deleted** | Permanently erased; the account no longer exists | No | No | No |

### State definitions

**Pending Verification** — the interval between beginning registration and proving control of the mobile number. No
account exists in any durable sense; the display name and number are provisional. This state is time-bounded and
self-clearing.

**Active** — the normal state. The account is verified and holds at least one role in at least one library. This is
the only state in which a session may be issued.

**Inactive** — verified but role-less. The account exists, its identity is valid, and the holder can authenticate,
but there is nothing for them to enter. This arises when every role has been revoked, every membership has ended, or
an account was created but never linked to a library. It is not a punishment and carries no stigma; it is simply the
absence of anywhere to go.

**Locked** — an automatic, temporary state produced by abuse-protection controls, principally exhaustion of the OTP
request quota. It clears itself after `CFG-4`. It is not an administrative judgement and requires no human action.

**Suspended** — a deliberate, reversible administrative bar applied by a platform role. It persists until explicitly
lifted. It is used where wrongdoing is suspected, a dispute is unresolved, or a security incident is under
investigation.

**Disabled** — a deliberate, permanent administrative bar. It is used where the platform has concluded the account
must not be used again but where records must be preserved. It is not deletion and does not erase anything.

**Pending Deletion** — deletion has been requested and accepted. The account is immediately unusable, but the data
survives for `CFG-10` so that an erroneous or coerced request can be undone. This state is one-way in the sense that
it either reverts to Active or proceeds to Deleted; it never becomes Suspended, Locked or Inactive.

**Deleted** — terminal. Personal data has been erased. The mobile number is released for future registration. The
account cannot be recovered, and re-registering the same number produces an entirely new account with no history.

| ID | Requirement |
|---|---|
| `AUTH-9.6` | An account MUST be in exactly one state at any moment |
| `AUTH-9.7` | A session MUST be issuable only from the Active state |
| `AUTH-9.8` | Authentication MUST be permitted only in Pending Verification, Active and Inactive; every other state MUST refuse it |
| `AUTH-9.9` | Locked MUST be automatic and self-clearing; it MUST NOT require or accept administrative intervention to lift |
| `AUTH-9.10` | Suspended MUST be reversible only by a platform role |
| `AUTH-9.11` | Disabled MUST be permanent and MUST NOT be reversible to Active |
| `AUTH-9.12` | Deleted MUST be terminal and MUST NOT be reversible by any means |
| `AUTH-9.13` | Inactive MUST NOT be treated as a fault, a penalty or a security signal |

---

## 9.3 Lifecycle Transitions

### Valid transitions

| From | To | Trigger |
|---|---|---|
| *(none)* | Pending Verification | Registration or claim begun |
| Pending Verification | Active | Mobile number verified and at least one role exists or is granted |
| Pending Verification | Inactive | Mobile number verified but no role exists |
| Pending Verification | *(discarded)* | `CFG-9` elapsed without verification |
| Active | Inactive | Last remaining role revoked |
| Inactive | Active | A role granted in any library |
| Active | Locked | Abuse-protection quota exhausted |
| Inactive | Locked | Abuse-protection quota exhausted |
| Locked | Active | `CFG-4` elapsed and at least one role held |
| Locked | Inactive | `CFG-4` elapsed and no role held |
| Active | Suspended | Platform role suspends |
| Inactive | Suspended | Platform role suspends |
| Locked | Suspended | Platform role suspends |
| Suspended | Active | Platform role lifts suspension and at least one role held |
| Suspended | Inactive | Platform role lifts suspension and no role held |
| Active | Disabled | Platform role disables |
| Inactive | Disabled | Platform role disables |
| Locked | Disabled | Platform role disables |
| Suspended | Disabled | Platform role disables |
| Active | Pending Deletion | Holder requests deletion, or platform role initiates it |
| Inactive | Pending Deletion | Holder requests deletion, or platform role initiates it |
| Suspended | Pending Deletion | Platform role initiates deletion |
| Disabled | Pending Deletion | Platform role initiates deletion |
| Pending Deletion | Active | Holder cancels within `CFG-10` and at least one role held |
| Pending Deletion | Inactive | Holder cancels within `CFG-10` and no role held |
| Pending Deletion | Deleted | `CFG-10` elapsed |

### Invalid transitions

These are stated explicitly so that they can be tested as prohibitions rather than merely omitted.

| From | To | Why prohibited |
|---|---|---|
| *(none)* | Active | An account never exists without prior verification |
| Pending Verification | Locked | Abuse protection acts on the mobile number, not on a not-yet-existent account |
| Pending Verification | Suspended | There is no account to suspend |
| Pending Verification | Disabled | There is no account to disable |
| Pending Verification | Pending Deletion | Nothing durable exists to delete; the record is discarded instead |
| Locked | Locked | A lock is not extendable by further attempts; it runs its fixed course |
| Disabled | Active | Disablement is permanent by definition |
| Disabled | Inactive | Disablement is permanent by definition |
| Disabled | Suspended | A weaker state cannot follow a stronger permanent one |
| Disabled | Locked | Abuse protection is meaningless for an account that cannot authenticate |
| Suspended | Locked | The account already cannot authenticate; locking adds nothing and would mask the suspension |
| Pending Deletion | Suspended | Deletion supersedes; suspension would obscure the pending erasure |
| Pending Deletion | Disabled | Deletion supersedes |
| Pending Deletion | Locked | The account cannot authenticate, so abuse protection cannot trigger |
| Deleted | *(any)* | Terminal |
| *(any)* | Pending Verification | Verification is not repeatable for an existing account |

| ID | Requirement |
|---|---|
| `AUTH-9.14` | Every transition MUST be one of those listed as valid; any other transition MUST be refused |
| `AUTH-9.15` | A refused transition MUST leave the account in its existing state with no partial effect |
| `AUTH-9.16` | Every transition MUST emit exactly one state-change event |
| `AUTH-9.17` | Every transition MUST record the actor, the reason where one applies, and the moment |
| `AUTH-9.18` | Transitions between Active and Inactive MUST occur automatically as roles are granted and revoked, without administrative action |
| `AUTH-9.19` | A transition into any state that bars authentication MUST terminate every session on every device immediately |
| `AUTH-9.20` | A transition out of a barring state MUST NOT restore any previously terminated session |
| `AUTH-9.21` | Concurrent transition requests MUST be serialised; the account MUST NOT occupy two states or apply two transitions simultaneously |
| `AUTH-9.22` | A Pending Verification record MUST be discarded after `CFG-9` and MUST leave no trace recoverable by any role |

---

## 9.4 Suspension & Recovery

### Suspension

Suspension is the platform's reversible remedy. It is deliberately blunt: it stops all access everywhere, because a
security or conduct concern about an identity is not confined to one library.

| ID | Requirement |
|---|---|
| `AUTH-9.23` | Suspension MUST be applicable only by a platform role |
| `AUTH-9.24` | Suspension MUST apply globally across every library in which the account holds roles |
| `AUTH-9.25` | Suspension MUST take effect immediately and MUST terminate every session on every device |
| `AUTH-9.26` | A suspended account MUST NOT obtain an OTP challenge, complete verification, or receive a session |
| `AUTH-9.27` | Suspension MUST require a recorded reason |
| `AUTH-9.28` | Suspension MUST preserve all roles, links and device records so that lifting it restores the prior position exactly |
| `AUTH-9.29` | The account holder MUST be notified that access has been suspended |
| `AUTH-9.30` | A notification of suspension MUST NOT disclose investigative detail, the reporting party, or any other account |
| `AUTH-9.31` | A tenant role MUST NOT be able to suspend, and MUST NOT be able to observe that suspension is the cause of an account's absence |

### Locking

| ID | Requirement |
|---|---|
| `AUTH-9.32` | Locking MUST arise only from abuse-protection controls and MUST NOT be applied manually |
| `AUTH-9.33` | A lock MUST last exactly `CFG-4` and MUST clear automatically |
| `AUTH-9.34` | A lock MUST NOT be extendable by further attempts during the lock period |
| `AUTH-9.35` | A lock MUST NOT be liftable early by any role, including platform roles |
| `AUTH-9.36` | A lock MUST NOT terminate existing sessions, because it bars new authentication rather than existing access |
| `AUTH-9.37` | The holder MUST be able to determine that they must wait, without being told the precise remaining duration |

### Recovery

| ID | Requirement |
|---|---|
| `AUTH-9.38` | Lifting a suspension MUST be performable only by a platform role and MUST require a recorded reason |
| `AUTH-9.39` | Lifting a suspension MUST return the account to Active if any role is held, or Inactive if none is |
| `AUTH-9.40` | Recovery MUST restore roles and links exactly as they stood at suspension, less any revoked in the interim by their granting library |
| `AUTH-9.41` | Recovery MUST NOT restore terminated sessions; the holder MUST authenticate afresh |
| `AUTH-9.42` | Recovery MUST NOT restore device trust that expired during the suspension |
| `AUTH-9.43` | The holder MUST be notified that access has been restored |
| `AUTH-9.44` | There MUST be no self-service route out of suspension |
| `AUTH-9.45` | Recovery from Disabled MUST NOT exist; an account requiring renewed access MUST be created afresh |

---

## 9.5 Account Deletion

### Principles

Deletion serves a right, not a workflow. It must be genuine — the data must actually go — and it must be reversible
for long enough to protect a person who acted in error or under pressure. It must also not destroy the tenant's
lawful business records, which are owned by other contexts and are not the platform's to erase.

| ID | Requirement |
|---|---|
| `AUTH-9.46` | An account holder MUST be able to request deletion of their own account without administrative assistance |
| `AUTH-9.47` | A deletion request MUST require the holder to be authenticated at the moment of the request |
| `AUTH-9.48` | Deletion MUST move the account to Pending Deletion immediately and MUST terminate every session on every device |
| `AUTH-9.49` | A Pending Deletion account MUST NOT authenticate, obtain a session, or appear as an available member to any library |
| `AUTH-9.50` | Pending Deletion MUST persist for `CFG-10`, during which the holder MAY cancel |
| `AUTH-9.51` | Cancellation MUST be available only to the account holder and MUST require re-verification of the mobile number |
| `AUTH-9.52` | After `CFG-10`, personal data held by Authentication MUST be permanently erased |
| `AUTH-9.53` | Erasure MUST be irreversible; no role, backup restoration or support procedure MUST be able to reconstitute the account |
| `AUTH-9.54` | Erasure MUST remove the mobile number and display name, and MUST release the mobile number for future registration |
| `AUTH-9.55` | Erasure MUST remove all device records, device trust and session records associated with the account |
| `AUTH-9.56` | Erasure MUST revoke every role assignment in every library and MUST notify each affected library that the member is no longer available |
| `AUTH-9.57` | Audit records MUST survive erasure in a form that retains the fact and timing of actions while no longer identifying the person |
| `AUTH-9.58` | Deletion MUST NOT delete, alter or invalidate business records owned by other contexts |
| `AUTH-9.59` | Business records surviving deletion MUST NOT be capable of reconstituting the deleted identity |
| `AUTH-9.60` | Re-registration of the same mobile number after erasure MUST produce an entirely new account with no prior roles, devices, links or history |

### Constraints on deletion

| ID | Requirement |
|---|---|
| `AUTH-9.61` | Deletion MUST be refused while the account is the sole Owner of any library |
| `AUTH-9.62` | A refusal under `AUTH-9.61` MUST state the obligation to transfer ownership without naming or enumerating any library the requester cannot already see |
| `AUTH-9.63` | A platform role MAY initiate deletion; a tenant role MUST NOT |
| `AUTH-9.64` | Platform-initiated deletion MUST require a recorded reason and MUST notify the holder |
| `AUTH-9.65` | Deletion MUST NOT be used as a substitute for suspension or disablement in disciplinary situations |

---

## 9.6 Mobile Number Change

### Why this is a security operation

The mobile number is the sole credential channel. Changing it changes who can authenticate as this account. It is
therefore treated with the same rigour as authentication itself, not as a profile edit.

### Requirements

| ID | Requirement |
|---|---|
| `AUTH-9.66` | A mobile number change MUST be initiated only by the account holder while authenticated |
| `AUTH-9.67` | A change MUST require successful verification of the **new** number before it takes effect |
| `AUTH-9.68` | A change MUST require successful verification of the **current** number at initiation, where the holder still controls it |
| `AUTH-9.69` | Where the current number is no longer controllable, the change MUST NOT proceed self-service; it MUST require a platform-role-assisted procedure with a recorded reason |
| `AUTH-9.70` | A change MUST be refused if the new number already resolves to another account in any state other than Deleted |
| `AUTH-9.71` | A change MUST take effect atomically; the account MUST NOT be reachable by both numbers at any moment |
| `AUTH-9.72` | On success, every session on every device MUST be terminated, including the session that requested the change |
| `AUTH-9.73` | On success, all device trust MUST be revoked; devices MUST be treated as unknown at next use |
| `AUTH-9.74` | On success, the account identity MUST remain the same; roles, links, history and memberships MUST be preserved unchanged |
| `AUTH-9.75` | The old number MUST be released and MUST become available for a future, entirely separate registration |
| `AUTH-9.76` | Both the old and the new number MUST be notified of the change, so far as delivery to the old number remains possible |
| `AUTH-9.77` | A change MUST emit an event and MUST be recorded with actor, both masked numbers and the moment |
| `AUTH-9.78` | A change MUST be refused while the account is Locked, Suspended, Disabled, Pending Deletion or Deleted |
| `AUTH-9.79` | No tenant role MUST be able to change, or request a change to, any account's mobile number |
| `AUTH-9.80` | The display name MUST be unaffected by a number change |

---

## 9.7 Business Rules

| ID | Rule |
|---|---|
| `BR-9.1` | An account occupies exactly one state at any moment |
| `BR-9.2` | Account state is global and never varies by library |
| `BR-9.3` | Account state is owned by Authentication alone |
| `BR-9.4` | Account state and membership state are separate and are never conflated |
| `BR-9.5` | A session is issued only from the Active state |
| `BR-9.6` | Authentication is permitted only in Pending Verification, Active and Inactive |
| `BR-9.7` | Only transitions listed as valid may occur; all others are refused |
| `BR-9.8` | A refused transition produces no partial effect |
| `BR-9.9` | Every transition emits exactly one state-change event |
| `BR-9.10` | Every transition records actor, reason where applicable, and moment |
| `BR-9.11` | Active and Inactive interchange automatically with role grant and revocation |
| `BR-9.12` | Any transition into a barring state terminates all sessions immediately |
| `BR-9.13` | Leaving a barring state never restores a terminated session |
| `BR-9.14` | Concurrent transitions are serialised |
| `BR-9.15` | Pending Verification is discarded after `CFG-9` and leaves no recoverable trace |
| `BR-9.16` | Locking is automatic, lasts `CFG-4`, and clears itself |
| `BR-9.17` | A lock cannot be extended, shortened or lifted by any role |
| `BR-9.18` | A lock bars new authentication but does not terminate existing sessions |
| `BR-9.19` | Suspension is applied and lifted only by a platform role and always requires a reason |
| `BR-9.20` | Suspension applies globally and terminates all sessions |
| `BR-9.21` | Suspension preserves roles, links and devices |
| `BR-9.22` | A tenant role can neither suspend an account nor observe that an account is suspended |
| `BR-9.23` | Disablement is permanent and never returns to Active or Inactive |
| `BR-9.24` | There is no self-service exit from suspension or disablement |
| `BR-9.25` | Deletion is requestable by the holder while authenticated, and by a platform role with a reason |
| `BR-9.26` | Deletion is never requestable by a tenant role |
| `BR-9.27` | Deletion moves the account to Pending Deletion immediately and terminates all sessions |
| `BR-9.28` | Pending Deletion lasts `CFG-10` and is cancellable only by the holder, with re-verification |
| `BR-9.29` | After `CFG-10`, personal data is permanently and irreversibly erased |
| `BR-9.30` | Erasure releases the mobile number for future registration |
| `BR-9.31` | Erasure revokes every role in every library and notifies each affected library |
| `BR-9.32` | Audit records survive erasure without identifying the person |
| `BR-9.33` | Deletion never removes or alters records owned by other contexts |
| `BR-9.34` | Surviving business records can never reconstitute a deleted identity |
| `BR-9.35` | Re-registration after erasure yields a wholly new account with no history |
| `BR-9.36` | Deletion is refused while the account is a library's sole Owner |
| `BR-9.37` | A mobile number change requires verification of the new number, and of the current number where controllable |
| `BR-9.38` | A number change is refused if the new number already resolves to a non-Deleted account |
| `BR-9.39` | A number change is atomic; both numbers are never simultaneously valid |
| `BR-9.40` | A number change terminates all sessions and revokes all device trust |
| `BR-9.41` | A number change preserves account identity, roles, links and history |
| `BR-9.42` | A number change is refused in Locked, Suspended, Disabled, Pending Deletion and Deleted |
| `BR-9.43` | No tenant role may change or request a change to any mobile number |
| `BR-9.44` | Every lifecycle change that affects the holder's access results in a notification to the holder |

---

## 9.8 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-9.1` | Registration abandoned before verification | Record discarded after `CFG-9`; no account ever existed; the number is immediately reusable |
| `XC-9.2` | Verification completed but no library role exists | Account becomes Inactive, not Active; authentication succeeds but no session is issued |
| `XC-9.3` | Last role revoked while the holder has an active session | Account becomes Inactive; the existing session continues until a tenant-scoped decision fails; identity remains valid |
| `XC-9.4` | Role granted to an Inactive account | Account becomes Active automatically with no administrative action |
| `XC-9.5` | Role granted while the account is Suspended | Assignment is refused; suspension must be lifted first |
| `XC-9.6` | Lock triggered while the holder has an active session | Session continues; only new authentication is barred |
| `XC-9.7` | Further OTP requests during a lock | Refused; the lock is not extended by them |
| `XC-9.8` | Platform role attempts to lift a lock early | Refused; locks are not administratively controllable |
| `XC-9.9` | Suspension applied while the holder is mid-verification | Verification completes but no session is issued; the outcome is indistinguishable from other non-usable states |
| `XC-9.10` | Suspension applied to an account holding roles in five libraries | All five lose access simultaneously; none is told why |
| `XC-9.11` | Suspension lifted after a library independently revoked its role | Account returns with the remaining roles only; the revoked role is not restored |
| `XC-9.12` | Suspension lifted after every role was revoked in the interim | Account returns to Inactive, not Active |
| `XC-9.13` | Disablement applied to a suspended account | Permitted; the account becomes permanently barred |
| `XC-9.14` | Attempt to reactivate a Disabled account | Refused; a new account must be created |
| `XC-9.15` | Deletion requested by an account that is sole Owner of one library | Refused with a statement of the ownership-transfer obligation |
| `XC-9.16` | Deletion requested by an account that is sole Owner of one library and Student at another | Refused; the refusal does not reveal the second library |
| `XC-9.17` | Deletion cancelled on the final day of `CFG-10` | Permitted; account returns to Active or Inactive according to roles held |
| `XC-9.18` | Deletion cancellation attempted after `CFG-10` | Refused; erasure has occurred and is irreversible |
| `XC-9.19` | Cancellation attempted by a platform role on the holder's behalf | Refused; only the holder may cancel |
| `XC-9.20` | A library attempts to view a Pending Deletion member | Member is not available; the library is not told deletion is the cause |
| `XC-9.21` | Same number registered again during another account's `CFG-10` window | Refused while the number remains bound; permitted once erasure completes, producing a new account |
| `XC-9.22` | Same number registered again after erasure | Wholly new account; no roles, devices, links or history are restored |
| `XC-9.23` | Number change requested to a number already held by an Active account | Refused |
| `XC-9.24` | Number change requested to a number held by a Deleted account | Permitted; the number was released on erasure |
| `XC-9.25` | Number change where the new number's verification is abandoned | No change occurs; the old number remains in force; the account is unaffected |
| `XC-9.26` | Number change where the current number is no longer reachable | Self-service route refused; platform-assisted procedure with recorded reason is required |
| `XC-9.27` | Number change completed while five sessions are active elsewhere | All five terminate, as does the requesting session; every device is untrusted |
| `XC-9.28` | Number change attempted while the account is Locked | Refused |
| `XC-9.29` | Number change attempted while Pending Deletion | Refused |
| `XC-9.30` | Two number-change requests submitted concurrently | Serialised; at most one takes effect; the other is refused against the changed state |
| `XC-9.31` | Suspension and deletion requested concurrently | Serialised; whichever applies first governs, and the second is evaluated against the resulting state |
| `XC-9.32` | Role revocation and account deletion occur in the same interval | Both apply; the resulting state reflects deletion, which supersedes |
| `XC-9.33` | Library deleted while accounts hold roles in it | Those roles are revoked; affected accounts become Inactive if no other role remains |
| `XC-9.34` | Holder attempts to determine why access stopped | Told only that access is unavailable and how to contact support; no state, reason or party is disclosed |
| `XC-9.35` | Audit query for a deleted account | Returns the actions and their timing without identifying the person |
| `XC-9.36` | Backup restored to a point before an erasure | Erasure must be re-applied; a restored backup must never resurrect an erased identity |

---

## 9.9 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-9.1` | An account is always in exactly one of the eight defined states |
| `AC-9.2` | Account state is identical when observed from any library |
| `AC-9.3` | No context other than Authentication can change account state |
| `AC-9.4` | A session is issued only from Active |
| `AC-9.5` | Authentication is refused in Locked, Suspended, Disabled, Pending Deletion and Deleted |
| `AC-9.6` | Every transition listed as invalid is refused |
| `AC-9.7` | A refused transition leaves the prior state wholly intact |
| `AC-9.8` | Every accepted transition emits exactly one state-change event |
| `AC-9.9` | Every accepted transition records actor, reason where applicable, and moment |
| `AC-9.10` | Revoking the last role moves the account to Inactive without administrative action |
| `AC-9.11` | Granting any role moves an Inactive account to Active without administrative action |
| `AC-9.12` | Any transition into a barring state terminates every session on every device |
| `AC-9.13` | No session survives, or is restored after, a barring state |
| `AC-9.14` | Concurrent transitions never leave the account in two states |
| `AC-9.15` | A Pending Verification record is unrecoverable after `CFG-9` |
| `AC-9.16` | A lock clears automatically after exactly `CFG-4` |
| `AC-9.17` | A lock cannot be lifted early, extended or applied manually by any role |
| `AC-9.18` | A lock does not terminate existing sessions |
| `AC-9.19` | Only a platform role can suspend or lift a suspension |
| `AC-9.20` | Suspension without a recorded reason is refused |
| `AC-9.21` | Suspension takes effect in every library simultaneously |
| `AC-9.22` | Lifting a suspension restores exactly the roles still held, and no others |
| `AC-9.23` | No tenant role can suspend, or determine that an account is suspended |
| `AC-9.24` | A Disabled account can never return to Active or Inactive |
| `AC-9.25` | Deletion by an authenticated holder is accepted without administrative assistance |
| `AC-9.26` | Deletion requested by a tenant role is refused |
| `AC-9.27` | Deletion moves the account to Pending Deletion and terminates all sessions immediately |
| `AC-9.28` | Cancellation within `CFG-10` by the holder, with re-verification, restores the account |
| `AC-9.29` | Cancellation by anyone other than the holder is refused |
| `AC-9.30` | After `CFG-10`, no role, tool, procedure or backup restoration recovers the account |
| `AC-9.31` | After erasure, the mobile number can be registered afresh and yields no prior data |
| `AC-9.32` | Erasure revokes every role and notifies every affected library |
| `AC-9.33` | Audit records survive erasure and no longer identify the person |
| `AC-9.34` | Deletion alters no record owned by another context |
| `AC-9.35` | No surviving record permits reconstruction of a deleted identity |
| `AC-9.36` | Deletion is refused while the account is a library's sole Owner |
| `AC-9.37` | A refusal under sole-ownership discloses no library the requester cannot already see |
| `AC-9.38` | A number change without verification of the new number never takes effect |
| `AC-9.39` | A number change to a number held by a non-Deleted account is refused |
| `AC-9.40` | At no moment do both the old and new numbers resolve to the account |
| `AC-9.41` | A completed number change terminates every session and revokes every device trust |
| `AC-9.42` | A completed number change preserves account identity, roles, links and history |
| `AC-9.43` | A number change is refused in every non-usable state |
| `AC-9.44` | No tenant role can change or request a change to any mobile number |
| `AC-9.45` | Every lifecycle change affecting access produces a notification to the holder |
| `AC-9.46` | No notification or error discloses the account's state to any party other than the holder and platform roles |
