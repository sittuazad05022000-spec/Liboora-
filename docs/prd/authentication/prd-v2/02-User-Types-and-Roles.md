# Chapter 2 — User Types & Roles

## 2.1 Purpose

Authentication answers "who is this?" and "what may they do here?". This chapter defines the vocabulary for the
second question.

Two distinctions carry the entire chapter and must be understood before anything else:

**A user category is not a role.** A *category* describes what kind of person an account belongs to and how they
came to be on the platform. A *role* is a revocable grant of permissions, held in a specific library or at the
platform level. Categories are descriptive; roles are the only thing authorization actually evaluates.

**A platform role is not a tenant role.** Platform roles concern the operation of Liboora itself. Tenant roles
concern the operation of a single library. They are separate namespaces, assigned by different authorities, and
they never substitute for one another.

Without these distinctions a multi-tenant platform drifts toward a single flat permission list, where a person
who is an owner somewhere is treated as privileged everywhere. This chapter prevents that.

`AUTH-2.1` — Authorization **MUST** be evaluated exclusively from role assignments. A user category **MUST NOT**
grant any permission.

`AUTH-2.2` — Every role assignment **MUST** be scoped either to the platform or to exactly one library. An
unscoped role assignment is invalid.

---

## 2.2 User Categories

Seven categories are supported. The set is closed; introducing a category is an architectural decision, not a
configuration change.

### 2.2.1 Student

| Aspect | Definition |
|---|---|
| **Description** | A person who uses a library's facilities — seats, study space, resources. The platform's primary user population |
| **Authentication eligibility** | Eligible. Self-registers with a display name and a mobile number, or claims a record a library created for them |
| **Primary responsibilities** | Accessing their own attendance, seat bookings, membership status and library information |
| **Authentication restrictions** | May hold the Student role in any number of libraries. Cannot hold any platform role. Cannot assign roles to anyone. May act only on their own data |

### 2.2.2 Parent

| Aspect | Definition |
|---|---|
| **Description** | A person responsible for one or more students, who requires visibility of those students' library activity |
| **Authentication eligibility** | Eligible. Registers independently with their own mobile number |
| **Primary responsibilities** | Viewing the activity and status of students they are linked to |
| **Authentication restrictions** | Access extends only to students they are explicitly linked to, and only within libraries where that link is recognised. Cannot hold platform roles. Cannot act on a student's behalf beyond viewing. **A parent must hold their own account** — a shared account with the student is prohibited |

> The parent–student link itself is established by Enrollment. Authentication consumes the link when evaluating
> access; it does not create, modify or interpret it.

### 2.2.3 Library Owner

| Aspect | Definition |
|---|---|
| **Description** | The person accountable for a library on Liboora. Commercially and operationally responsible for that tenant |
| **Authentication eligibility** | Eligible. Registers as any other user; the Owner role is conferred on the library, not on the person by default |
| **Primary responsibilities** | Full operational authority within their library, including staff role assignment |
| **Authentication restrictions** | Authority is confined to the libraries they own. Confers no visibility of any other library. Cannot hold platform roles by virtue of ownership. Cannot remove the last remaining Owner of a library |

### 2.2.4 Library Manager

| Aspect | Definition |
|---|---|
| **Description** | A senior staff member responsible for day-to-day operation, delegated by an Owner |
| **Authentication eligibility** | Eligible. Assignment is invite-only; a Manager role cannot be self-selected |
| **Primary responsibilities** | Operational management within one library, including limited staff administration |
| **Authentication restrictions** | Cannot assign or revoke the Owner role. Cannot delete the library. Cannot exceed the permissions the Owner holds. Confined to the assigning library |

### 2.2.5 Reception Staff

| Aspect | Definition |
|---|---|
| **Description** | Front-desk personnel handling check-in, seat allocation and routine student interaction |
| **Authentication eligibility** | Eligible. Invite-only assignment |
| **Primary responsibilities** | Daily operational tasks at the point of service |
| **Authentication restrictions** | Explicitly excluded from financial and revenue information. Cannot assign roles. Cannot alter library configuration. Confined to the assigning library |

### 2.2.6 Platform Support

| Aspect | Definition |
|---|---|
| **Description** | Liboora personnel who assist libraries and users with operational problems |
| **Authentication eligibility** | Eligible, through the platform's internal assignment process. Never self-registered into this category |
| **Primary responsibilities** | Diagnosing and resolving user-reported issues |
| **Authentication restrictions** | **No standing access to tenant data.** Access to a library requires an explicit, time-bounded, purpose-recorded elevation. Cannot assign tenant roles. Cannot authorise their own elevation. Every action is attributed and audited |

### 2.2.7 Platform Administrator

| Aspect | Definition |
|---|---|
| **Description** | Liboora personnel accountable for platform-wide operation, tenant provisioning and platform security |
| **Authentication eligibility** | Eligible, through the platform's internal assignment process only |
| **Primary responsibilities** | Tenant lifecycle, platform configuration, platform security administration |
| **Authentication restrictions** | Administers the platform, **not the contents of tenants**. Cannot read tenant business data without the same time-bounded elevation required of Platform Support. Cannot grant themselves tenant roles. Cannot act as a tenant user |

### 2.2.8 Category summary

| Category | Self-registers | Platform role | Tenant role | Multi-library |
|---|---|---|---|---|
| Student | Yes | Never | Yes | Yes |
| Parent | Yes | Never | Yes (view-scoped) | Yes |
| Library Owner | Yes | Never | Yes | Yes |
| Library Manager | Yes, then invited | Never | Yes | Yes |
| Reception Staff | Yes, then invited | Never | Yes | Yes |
| Platform Support | No | Yes | Only by elevation | N/A |
| Platform Administrator | No | Yes | Only by elevation | N/A |

`AUTH-2.3` — A single account **MAY** correspond to more than one category simultaneously. Category is a
description of how an account is used, not an exclusive classification.

`AUTH-2.4` — Platform categories **MUST NOT** be reachable by self-registration under any circumstance.

---

## 2.3 Platform Roles

Platform roles govern Liboora itself. Two exist. The set is closed.

### `PR-1` Platform Administrator

| Aspect | Definition |
|---|---|
| **Purpose** | Operate and secure the platform: provision and suspend tenants, manage platform configuration, administer platform-level security |
| **Scope** | Platform-wide, for **platform-level objects only** — tenants as entities, platform configuration, platform role assignments |
| **Limitations** | Confers **no** access to tenant business data. Cannot self-assign tenant roles. Cannot impersonate a tenant user. Cannot alter or delete audit records. Cannot approve their own elevation request |
| **Security considerations** | The highest-privilege role on the platform and the primary target for compromise. Requires the strictest session limits, complete action attribution, and separation of duties from Platform Support. Assignment and revocation are themselves auditable security events |

### `PR-2` Platform Support

| Aspect | Definition |
|---|---|
| **Purpose** | Resolve user- and library-reported problems |
| **Scope** | Platform-wide **read** access to non-sensitive operational metadata; access to a specific tenant only through time-bounded elevation |
| **Limitations** | No standing tenant access. Cannot assign any role, platform or tenant. Cannot modify tenant business data outside an approved elevation. Cannot extend their own elevation. Cannot access authentication factors or session secrets under any circumstance |
| **Security considerations** | The role most frequently exercised against live tenant data, therefore the greatest insider risk. Every elevation records requester, approver, tenant, purpose and expiry, and terminates automatically at `CFG-12` (4 hours) |

`AUTH-2.5` — Platform roles **MUST NOT** grant access to tenant business data. Such access is obtained only
through explicit elevation, and only for the elevation's duration.

`AUTH-2.6` — Platform role assignment **MUST** be performed exclusively by a Platform Administrator other than
the subject. Self-assignment and self-elevation are prohibited.

`AUTH-2.7` — Every platform role assignment, revocation and elevation **MUST** emit an authentication event.

---

## 2.4 Tenant (Library) Roles

Tenant roles govern one library. Every assignment names exactly one library and has no meaning outside it.

### `TR-1` Owner

| Aspect | Definition |
|---|---|
| **Permissions overview** | Complete operational authority within the library: configuration, staff role assignment and revocation, financial and revenue visibility, member administration, library closure |
| **Ownership** | Conferred at library creation. Subsequently assignable only by an existing Owner of that library |
| **Restrictions** | Confined to the library. Cannot view or affect any other library. Cannot grant permissions the role model does not define. **The last remaining Owner cannot be removed or self-demote**; ownership must first be transferred |

### `TR-2` Manager

| Aspect | Definition |
|---|---|
| **Permissions overview** | Day-to-day operational management: member administration, attendance and seating oversight, operational reporting, assignment of Reception Staff |
| **Ownership** | Assigned and revoked by an Owner of the library |
| **Restrictions** | Cannot assign, revoke or transfer the Owner role. Cannot delete or close the library. Cannot alter library-level commercial configuration. Cannot exceed Owner permissions. Confined to the assigning library |

### `TR-3` Reception

| Aspect | Definition |
|---|---|
| **Permissions overview** | Point-of-service operations: student check-in and check-out, seat allocation, viewing member status necessary to serve a person at the desk |
| **Ownership** | Assigned and revoked by an Owner or a Manager of the library |
| **Restrictions** | **Explicitly denied revenue and financial data.** Cannot assign any role. Cannot alter library configuration. Cannot administer members beyond operational status. Confined to the assigning library |

### `TR-4` Student

| Aspect | Definition |
|---|---|
| **Permissions overview** | Access to the holder's own records within the library: attendance, seat bookings, membership status, library information |
| **Ownership** | Acquired on becoming a member of the library, or on successful claim of a library-created record |
| **Restrictions** | Reaches the holder's own data only. Cannot view any other person's data. Cannot assign roles. Cannot access operational or financial functions |

### `TR-5` Parent

| Aspect | Definition |
|---|---|
| **Permissions overview** | Read-only visibility of the activity of students the holder is explicitly linked to, within this library |
| **Ownership** | Acquired when Enrollment establishes a parent–student link recognised by the library |
| **Restrictions** | **Read-only.** Reaches only explicitly linked students, and only within this library. Confers nothing regarding students in other libraries. Cannot act on a student's behalf. Cannot assign roles |

### 2.4.1 Tenant role authority summary

| Role | May assign | May revoke | Financial visibility | Scope of data |
|---|---|---|---|---|
| `TR-1` Owner | `TR-1`, `TR-2`, `TR-3` | `TR-2`, `TR-3`, and `TR-1` while another Owner remains | Full | Entire library |
| `TR-2` Manager | `TR-3` | `TR-3` | Operational only | Entire library, excluding commercial configuration |
| `TR-3` Reception | None | None | **None** | Operational data required at the desk |
| `TR-4` Student | None | None | Own dues only | Own records |
| `TR-5` Parent | None | None | Linked students' dues only | Linked students' records, read-only |

`AUTH-2.8` — Tenant roles **MUST NOT** be inherited across libraries. Holding a role in one library confers
nothing in another.

`AUTH-2.9` — No tenant role, including Owner, **MAY** confer any platform-level permission.

`AUTH-2.10` — A library **MUST** retain at least one account holding `TR-1` Owner at all times.

---

## 2.5 Multi-Library Role Assignment

### One account, many libraries

An account is global; role assignments are tenant-scoped. A single verified mobile number yields one account,
which may hold roles in any number of libraries.

Consider one person who studies at Library A, works the reception desk at Library B, and owns Library C. That is
**one account with three independent tenant role assignments** — not three accounts, and not one privileged
account.

| Library | Role held | What the account may do there |
|---|---|---|
| Library A | `TR-4` Student | View only their own attendance and bookings |
| Library B | `TR-3` Reception | Operate the desk; **no** revenue visibility |
| Library C | `TR-1` Owner | Full operational authority, including revenue |

### Independence of permissions

`AUTH-2.11` — Every access decision **MUST** be evaluated using only the roles the account holds **in the active
library**. Roles held elsewhere **MUST NOT** influence the decision in any way.

The consequence is deliberate and absolute: while operating in Library A, the account above is a student and
nothing more. Ownership of Library C grants it no additional visibility in Library A, not even indirectly.

### Tenant isolation

`AUTH-2.12` — Exactly one library **MUST** be active at any moment within a session. Simultaneous multi-library
operation is not supported.

`AUTH-2.13` — Switching the active library **MUST** discard the prior authorization context in full and rebuild
it from the new library's role assignments.

`AUTH-2.14` — An account holding roles in several libraries **MUST NOT** be able to observe, from within one
library, that it holds roles in any other.

### Absence of any role

`AUTH-2.15` — An account **MAY** exist while holding no tenant role in any library. This is a valid, expected
state — it is the state of every newly created account.

`AUTH-2.16` — An account holding no role in a library **MUST** be treated in that library exactly as an account
that does not exist: no data, no presence, no acknowledgement.

---

## 2.6 Role Assignment Rules

### Who may assign

| Role to assign | Authorised assigner |
|---|---|
| `PR-1` Platform Administrator | An existing Platform Administrator, other than the subject |
| `PR-2` Platform Support | A Platform Administrator |
| `TR-1` Owner | An existing Owner of that library |
| `TR-2` Manager | An Owner of that library |
| `TR-3` Reception | An Owner or Manager of that library |
| `TR-4` Student | Conferred on library membership, or on successful account claim |
| `TR-5` Parent | Conferred when Enrollment establishes a recognised parent–student link |

### Who may revoke

`AUTH-2.17` — Authority to revoke a role **MUST** be identical to the authority to assign it, with one addition:
a holder **MAY** always relinquish their own role, subject to `AUTH-2.10`.

`AUTH-2.18` — Revocation **MUST** take effect immediately and globally, on every active session and device.

### Default roles

`AUTH-2.19` — A newly created account **MUST** hold **no role of any kind**. There is no default role, at either
scope.

`AUTH-2.20` — Role acquisition is always a distinct, explicit act following account creation.

### Invite-only roles

`AUTH-2.21` — `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `PR-1` and `PR-2` **MUST** be invite-only. No
self-service path to any of them may exist.

> Invitation mechanics — links, codes and QR — are owned by Library Management / Tenant Organization.
> Authentication records the resulting assignment and enforces who was entitled to make it.

### Restrictions on assignment

`AUTH-2.22` — No account **MAY** assign a role conferring permissions the assigner does not itself hold.

`AUTH-2.23` — No account **MAY** assign any role to itself. Every assignment involves two distinct accounts.

`AUTH-2.24` — Assignment requires the subject to hold an **active** account. Roles cannot be assigned to
suspended, locked, disabled or deleted accounts.

`AUTH-2.25` — Every assignment and revocation **MUST** emit an event identifying assigner, subject, role, scope
and time.

---

## 2.7 Authorization Principles

| Principle | Definition | Consequence |
|---|---|---|
| **Least Privilege** | Every role holds the minimum permissions its function requires | Reception has no revenue access, because desk work does not require it. Permissions are not granted in anticipation |
| **Deny by Default** | Absence of an explicit grant is refusal | A new permission is unreachable by every role until explicitly granted. Adding a feature cannot silently widen access |
| **Tenant Isolation** | Every decision is evaluated with exactly one library in scope | A decision without a tenant is **invalid**, not permissive |
| **Explicit Authorization** | Permissions are granted by name, never derived | No role obtains a permission through seniority, hierarchy or name similarity. Owner is not "everything"; it is an enumerated set |
| **Role Separation** | Platform and tenant roles are distinct namespaces | A Platform Administrator is not an Owner of any library. An Owner has no platform authority. Neither can become the other by assertion |
| **Separation of Duties** | Sensitive acts require two distinct accounts | No self-assignment, no self-elevation, no self-approval |
| **Immediate Revocation** | Withdrawal takes effect at once, everywhere | Access does not persist to the end of a session or a cache lifetime |

`AUTH-2.26` — Where two rules could both apply and produce different outcomes, the outcome **MUST** be denial.

---

## 2.8 Business Rules

| ID | Rule |
|---|---|
| `BR-2.1` | One verified mobile number yields exactly one global account, platform-wide |
| `BR-2.2` | One account may hold roles in any number of libraries |
| `BR-2.3` | Role assignments are tenant-scoped; none is inherited across libraries |
| `BR-2.4` | A new account holds no role at either scope |
| `BR-2.5` | A user category confers no permission; only roles do |
| `BR-2.6` | Platform roles never confer tenant business data access |
| `BR-2.7` | Tenant roles never confer platform authority |
| `BR-2.8` | A library must always retain at least one Owner |
| `BR-2.9` | Owner, Manager, Reception, and both platform roles are invite-only |
| `BR-2.10` | No account may assign a role to itself |
| `BR-2.11` | No account may assign permissions it does not hold |
| `BR-2.12` | Reception is denied revenue and financial data in all circumstances |
| `BR-2.13` | Parent access is read-only and limited to explicitly linked students in the current library |
| `BR-2.14` | Platform Support tenant access is time-bounded, purpose-recorded and self-terminating at `CFG-12` |
| `BR-2.15` | Elevation must be requested and approved by two distinct accounts |
| `BR-2.16` | Role revocation takes effect immediately on all sessions and devices |
| `BR-2.17` | Roles cannot be assigned to accounts that are not active |
| `BR-2.18` | An account with no role in a library is indistinguishable, within that library, from an account that does not exist |
| `BR-2.19` | Every assignment, revocation and elevation emits an authentication event |
| `BR-2.20` | Where rules conflict, access is denied |

---

## 2.9 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-2.1` | **Owner in one library, Student in another** | Fully supported by one account. In the student library the account holds `TR-4` only; ownership elsewhere has no effect there, and is not observable there |
| `XC-2.2` | **Account holds roles in many libraries** | Authentication succeeds once. Library selection follows. Exactly one library becomes active; permissions derive solely from it |
| `XC-2.3` | **Account removed from one library** | That library's role assignment ends immediately. The account, its other library roles, and its sessions elsewhere are unaffected. If the removed library was active, the session's tenant context is cleared and reselection is required |
| `XC-2.4` | **Removal from the only library** | The account continues to exist holding no role — the same state as a newly created account. It is not deleted, suspended or degraded |
| `XC-2.5` | **Platform Support requires tenant access** | Requires an elevation request stating tenant and purpose, approved by a distinct Platform Administrator, expiring automatically at `CFG-12`. All actions attributed. No standing access is created |
| `XC-2.6` | **Elevation expires mid-operation** | Access ends at expiry. The in-flight operation is refused at the next decision point. No grace period, no automatic renewal |
| `XC-2.7` | **Suspended account holding roles** | Role assignments are retained but unusable. Every access decision denies while suspended. Reinstatement restores the prior assignments unchanged |
| `XC-2.8` | **Deleted account holding roles** | All assignments, platform and tenant, are revoked at deletion. If the account was a library's last Owner, deletion is refused until ownership is transferred |
| `XC-2.9` | **Sole Owner attempts to leave** | Refused. The refusal states that ownership must be transferred first. `AUTH-2.10` holds without exception |
| `XC-2.10` | **Role revoked during an active session** | The next access decision denies. The session itself remains valid — the account is still authenticated, but no longer authorised. Authentication and authorization fail independently |
| `XC-2.11` | **Manager attempts to assign Owner** | Refused. A Manager cannot assign a role exceeding its own permissions |
| `XC-2.12` | **Same person, two mobile numbers** | Two distinct accounts, by definition. The platform does not merge accounts. Consolidation is achieved by claiming under one number and relinquishing the other |
| `XC-2.13` | **Parent and student share one mobile number** | Prohibited. One account represents one person. The parent must use a distinct number |
| `XC-2.14` | **Platform Administrator attempts to self-assign a tenant role** | Refused. Prohibited by `AUTH-2.23` and by role separation |
| `XC-2.15` | **Library suspended while a user is active in it** | Every access decision in that library denies. Roles are retained for reinstatement. The account's access to other libraries is unaffected |
| `XC-2.16` | **Account holds Manager and Student in the same library** | Permitted. Effective permissions are the union of the two roles, subject to explicit denials — which are never overridden by union |

---

## 2.10 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-2.1` | One verified mobile number yields exactly one account; a second registration attempt with the same number never produces a second account |
| `AC-2.2` | A newly created account holds zero roles at both scopes, verified immediately after creation |
| `AC-2.3` | An account holding a role in Library A and none in Library B receives, in Library B, responses identical to an account that does not exist |
| `AC-2.4` | An account holding Owner in Library C and Student in Library A can perform no owner-level action while Library A is active |
| `AC-2.5` | Switching the active library changes effective permissions to exactly the new library's assignments, with no residue from the previous context |
| `AC-2.6` | A `TR-3` Reception holder is denied every revenue and financial permission, in every library, under every combination of other roles held elsewhere |
| `AC-2.7` | An attempt to remove a library's last Owner is refused, and the library retains an Owner |
| `AC-2.8` | A Manager's attempt to assign the Owner role is refused |
| `AC-2.9` | A self-assignment attempt is refused for every role at both scopes |
| `AC-2.10` | A Platform Administrator receives no tenant business data without an active, approved elevation |
| `AC-2.11` | A Platform Support elevation expires automatically at `CFG-12`; the first decision after expiry is a denial |
| `AC-2.12` | An elevation approved by the requesting account is refused |
| `AC-2.13` | Role revocation denies the next access decision on every active session within the revocation window |
| `AC-2.14` | Role assignment to a suspended, locked, disabled or deleted account is refused |
| `AC-2.15` | Every assignment, revocation and elevation emits exactly one event carrying assigner, subject, role, scope and time |
| `AC-2.16` | No authorization decision is reachable without a tenant in scope; a tenant-less decision is refused rather than allowed |
| `AC-2.17` | A `TR-5` Parent can read only explicitly linked students, only in the active library, and can perform no write action |
| `AC-2.18` | A suspended account holding roles is denied every access decision, and reinstatement restores the identical set of assignments |
| `AC-2.19` | The set of user categories and the set of roles are each closed; no undeclared category or role is reachable at runtime |
| `AC-2.20` | Where two applicable rules disagree, the observed outcome is denial |
