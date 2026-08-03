# Chapter 7 — Roles, Permissions & Access Policies

## 7.1 Purpose

Authentication establishes **who** someone is. Authorization determines **what they may do**. This chapter
specifies the second.

### Why the two are separate

They answer different questions, fail for different reasons, and change on different timescales.

| Property | Authentication | Authorization |
|---|---|---|
| Question | Who is this? | May they do this, here? |
| Frequency | Once per session | Every operation |
| Scope | Global | Tenant-scoped |
| Changes when | Identity changes | Roles change |
| Failure means | We don't know who you are | We know exactly who you are, and the answer is no |

Merging them produces two well-known failures. First, permissions become fixed at sign-in — a revoked role
continues to work until the session ends, which contradicts immediate revocation. Second, "authenticated" starts
to imply "permitted", so any gap in permission checking defaults to access rather than refusal.

Separating them means a session can remain perfectly valid while every authorization within it is denied. That is
not an inconsistency; it is the design.

`AUTH-7.1` — Authorization **MUST** be evaluated independently of authentication, at every access decision, using
current state rather than state captured at sign-in.

`AUTH-7.2` — Authentication success **MUST NOT** be treated as evidence of any permission.

### Ownership boundary

Authentication owns **the decision**. Modules own **the feature**.

Authentication answers "may this role, in this library, perform this named action?" It does not know what the
action means, when it should be offered, or what happens next. A module asks the question and honours the answer;
it never substitutes its own.

`AUTH-7.3` — No module **MAY** implement its own access logic, infer permission from role names, or proceed when
Authentication has refused.

---

## 7.2 Authorization Principles

| ID | Principle | Requirement |
|---|---|---|
| `AP-1` | **Authentication before authorization** | `AUTH-7.4` — No permission is evaluated before identity is established. An unauthenticated request is refused without evaluation |
| `AP-2` | **Least privilege** | `AUTH-7.5` — Every role holds the minimum permissions its function requires. Permissions are never granted in anticipation of future need |
| `AP-3` | **Deny by default** | `AUTH-7.6` — Absence of an explicit grant is refusal. A newly introduced permission is unreachable by every role until explicitly granted |
| `AP-4` | **Explicit assignment** | `AUTH-7.7` — Permissions are granted by name. No permission is derived from role naming, hierarchy, seniority or similarity to another permission |
| `AP-5` | **Separation of duties** | `AUTH-7.8` — No account may assign itself a role, approve its own elevation, or authorise an action requiring independent approval |
| `AP-6` | **Tenant isolation** | `AUTH-7.9` — Every decision is evaluated with exactly one library in scope. A decision without a tenant is **invalid**, and invalid means refused |
| `AP-7` | **No role inheritance** | `AUTH-7.10` — Roles do not inherit from one another. Owner is an enumerated permission set, not "everything Manager has, plus more" |
| `AP-8` | **Policy-based** | `AUTH-7.11` — Decisions are produced by evaluating policy against role, tenant, action and resource — never by conditional logic embedded in a feature |
| `AP-9` | **Fail closed** | `AUTH-7.12` — Where any input to a decision is unavailable, indeterminate or in error, the decision is refusal |

> `AP-7` deserves emphasis. Inheritance hierarchies appear economical and consistently produce over-permission:
> adding a permission to a base role silently widens every role above it. Enumerating each role's permissions
> makes every grant deliberate and every widening visible.

---

## 7.3 Role Model

### Role classes

| Class | Scope | Assigned by | Duration |
|---|---|---|---|
| **Platform roles** | Platform-wide, platform objects only | Platform Administrator | Standing |
| **Library roles** | Exactly one library | Owner or Manager of that library | Standing |
| **Temporary roles** | One library, or platform-scoped elevation | Approved by a second account | Time-bounded |
| **System roles** | Platform-internal | Not assignable to accounts | N/A |
| **Default roles** | None exist | — | — |

### Platform roles

Two, closed: `PR-1` Platform Administrator and `PR-2` Platform Support. Both administer the platform. Neither
confers access to tenant business data.

`AUTH-7.13` — Platform roles **MUST NOT** grant any permission over tenant business data. Such access requires
temporary elevation.

### Library roles

Five, closed: `TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5` Parent. Each assignment names
exactly one library.

`AUTH-7.14` — A library role **MUST** be scoped to exactly one library and **MUST** confer nothing in any other.

`AUTH-7.15` — An account **MAY** hold several library roles in one library. Effective permissions are the union of
their grants, **less** any explicit denial.

### Temporary roles

`AUTH-7.16` — A temporary role **MUST** carry an expiry recorded at grant time, and **MUST** cease at that moment
without any action.

`AUTH-7.17` — A temporary role **MUST** record requester, approver, scope, purpose and expiry.

`AUTH-7.18` — A temporary role **MUST NOT** be extended by its holder, and **MUST NOT** be renewed automatically.

`AUTH-7.19` — Platform Support elevation **MUST NOT** exceed `CFG-12` (1 hour).

### System roles

`AUTH-7.20` — System roles used by platform internals **MUST NOT** be assignable to any account, **MUST NOT**
appear in any role list, and **MUST NOT** be reachable by any authenticated request.

### Default roles

`AUTH-7.21` — No default role exists at either scope. A new account holds nothing, and role acquisition is always
an explicit act.

---

## 7.4 Permission Model

### Structure

A permission names a single capability. It is atomic: it cannot be partially held.

`AUTH-7.22` — The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted,
requested or evaluated.

`AUTH-7.23` — Every permission **MUST** declare its scope class. A permission without one is invalid.

### Permission categories

| Category | Governs | Example capability |
|---|---|---|
| **Identity** | Accounts, roles, devices, sessions | Assigning a role; viewing device records |
| **Operational** | Day-to-day library activity | Recording attendance; allocating a seat |
| **Member** | Records of people in a library | Viewing a member's status; administering a member |
| **Financial** | Revenue, fees, commercial data | Viewing revenue; recording a payment |
| **Configuration** | Library setup and settings | Changing operating hours; configuring seats |
| **Platform** | Platform-level objects | Provisioning a tenant; platform configuration |

### Action classes

| Action | Meaning |
|---|---|
| **Read** | Observe existing state |
| **Create** | Bring new state into existence |
| **Update** | Modify existing state |
| **Delete** | Remove state |
| **Approve** | Authorise an action requiring independent approval |
| **Export** | Extract data from the platform |

`AUTH-7.24` — Each action class **MUST** be granted independently. Read **MUST NOT** imply any other action, and
Update **MUST NOT** imply Create or Delete.

`AUTH-7.25` — **Approve** and **Export** **MUST** always be granted explicitly, and **MUST NOT** be implied by any
other action on the same resource.

> Export is separated because extraction has consequences reading does not: data leaves the platform's controls
> permanently. A role that may view a member list does not thereby acquire the right to remove a copy of it.

### Scope classes

A permission's scope determines the breadth of resource it may reach.

| Scope | Reaches |
|---|---|
| **Self** | Only resources belonging to the acting account |
| **Linked** | Only resources belonging to explicitly linked subjects |
| **Tenant** | Any resource within the active library |
| **Platform** | Platform-level objects only, never tenant business data |

`AUTH-7.26` — Every permission grant **MUST** carry a scope. A grant without one is invalid and **MUST** be
refused rather than treated as unrestricted.

`AUTH-7.27` — A scoped permission **MUST NOT** be exercisable without naming the resource it acts upon. A request
that omits the resource **MUST** be refused, never interpreted as applying to all.

> This is what prevents a student's "view attendance" from becoming "view everyone's attendance" through an
> omitted parameter.

### Hierarchy

`AUTH-7.28` — Permissions **MUST NOT** form a hierarchy. No permission implies another.

`AUTH-7.29` — Scopes **MUST** narrow, never widen: Self ⊂ Linked ⊂ Tenant. A grant at a narrower scope **MUST
NOT** be widened by holding another role at a broader one for a different permission.

---

## 7.5 Access Policies

### Evaluation

`AUTH-7.30` — A decision **MUST** be produced from exactly five inputs: authenticated identity, active tenant,
roles held in that tenant, the requested action, and the target resource.

`AUTH-7.31` — No other input **MAY** influence a decision — not the requesting module, not the interface, not the
device, not roles held in other tenants.

### Allow and deny rules

`AUTH-7.32` — An **allow** rule grants a named permission at a named scope to a named role.

`AUTH-7.33` — A **deny** rule prohibits a named permission for a named role irrespective of any allow rule.

`AUTH-7.34` — Deny **MUST** always defeat allow. No combination of roles, scopes or grants may overcome an
explicit denial.

> This makes constraints like "Reception never sees revenue" absolute. However many roles a person accumulates,
> the denial holds.

### Inheritance

`AUTH-7.35` — Permissions **MUST NOT** be inherited between roles, between scopes or between tenants. Every grant
is direct.

### Conflict resolution and precedence

`AUTH-7.36` — Decisions **MUST** be resolved in this order, stopping at the first that applies:

| Order | Condition | Outcome |
|---|---|---|
| 1 | No authenticated identity | **Deny** |
| 2 | Account not in a usable state | **Deny** |
| 3 | No active tenant, for a tenant-scoped action | **Deny** |
| 4 | An explicit deny rule matches | **Deny** |
| 5 | No allow rule matches | **Deny** |
| 6 | An allow rule matches but the resource lies outside its scope | **Deny** |
| 7 | An allow rule matches within scope | **Allow** |

`AUTH-7.37` — Where evaluation cannot complete for any reason, the outcome **MUST** be deny.

### Policy lifecycle

`AUTH-7.38` — Policy is defined at the platform level. No tenant **MAY** define, alter or extend it.

`AUTH-7.39` — A change to policy **MUST** take effect at the next decision, without requiring re-authentication.

`AUTH-7.40` — Policy changes **MUST** be auditable, attributable and reversible.

> Tenants configure their libraries; they never configure the permission model. Allowing per-tenant policy would
> make platform-wide guarantees unverifiable.

---

## 7.6 Role Assignment Rules

### Assignment authority

| Role | May be assigned by |
|---|---|
| `PR-1` Platform Administrator | A Platform Administrator other than the subject |
| `PR-2` Platform Support | A Platform Administrator |
| `TR-1` Owner | An existing Owner of that library |
| `TR-2` Manager | An Owner of that library |
| `TR-3` Reception | An Owner or Manager of that library |
| `TR-4` Student | Conferred on membership or successful claim |
| `TR-5` Parent | Conferred on a recognised parent–student link |

`AUTH-7.41` — Revocation authority **MUST** equal assignment authority. A holder **MAY** always relinquish their
own role, subject to the last-Owner rule.

### Constraints

`AUTH-7.42` — No account **MAY** assign a role conferring permissions the assigner does not hold.

`AUTH-7.43` — No account **MAY** assign any role to itself.

`AUTH-7.44` — Assignment requires the subject's account to be Active.

`AUTH-7.45` — A library **MUST** always retain at least one Owner. An assignment or revocation that would leave
none **MUST** be refused.

### Temporary access

`AUTH-7.46` — Temporary access **MUST** be requested by one account and approved by a different one.

`AUTH-7.47` — Temporary access **MUST** state its tenant, purpose and expiry at request time.

`AUTH-7.48` — Temporary access **MUST** terminate automatically at expiry, with no grace period.

### Invite-only roles

`AUTH-7.49` — `TR-1`, `TR-2`, `TR-3`, `PR-1` and `PR-2` **MUST** be invite-only. No self-service path may exist.

### Automatic removal

`AUTH-7.50` — A role **MUST** be removed automatically on: expiry of a temporary role, account deletion, or
deletion of the library it is scoped to.

`AUTH-7.51` — Automatic removal **MUST** emit an event identifying its cause.

### Cross-library restrictions

`AUTH-7.52` — An assignment in one library **MUST NOT** create, imply or affect any assignment in another.

`AUTH-7.53` — No assigner **MAY** assign a role in a library where they hold no assignment authority.

---

## 7.7 Permission Evaluation

Every access decision proceeds through the same sequence. No step may be omitted or reordered.

| Step | Evaluation | On failure |
|---|---|---|
| 1 | **Authentication** — is there a valid session bearing a verified identity? | Deny |
| 2 | **Account state** — is the account usable? | Deny |
| 3 | **Active tenant** — is exactly one library in scope, for a tenant-scoped action? | Deny |
| 4 | **Role resolution** — which roles does this account currently hold in this tenant? | Deny if none |
| 5 | **Policy evaluation** — apply precedence order `AUTH-7.36` | Deny at the first matching deny condition |
| 6 | **Scope check** — does the named resource lie within the granted scope? | Deny |
| 7 | **Decision** — allow or deny | — |

`AUTH-7.54` — Roles **MUST** be resolved at decision time from current state. A role list captured at sign-in
**MUST NOT** be used.

`AUTH-7.55` — Every denial **MUST** be indistinguishable, to the requester, from the resource not existing.

> A denial that says "you may not view this member" confirms the member exists. Across a library, that is an
> enumeration channel. Denials therefore reveal nothing about what lies behind them.

`AUTH-7.56` — Every decision on a sensitive resource **MUST** be recorded with actor, tenant, action, resource
class and outcome.

---

## 7.8 Multi-Tenant Authorization

`AUTH-7.57` — A decision **MUST** consider only roles held in the active tenant. Roles elsewhere **MUST NOT**
influence it.

`AUTH-7.58` — No decision **MAY** authorise access to a resource belonging to a tenant other than the active one.

`AUTH-7.59` — On switching tenants, the authorization context **MUST** be discarded entirely and rebuilt.

`AUTH-7.60` — A tenant **MUST NOT** be able to determine which other tenants an account holds roles in.

`AUTH-7.61` — Platform authority **MUST NOT** extend to tenant business data. Platform roles administer tenants as
objects; the contents require elevation.

### Worked example

An account holds `TR-1` Owner in Library C and `TR-4` Student in Library A. Library A is active.

| Attempted action | Outcome | Reason |
|---|---|---|
| View own attendance in Library A | **Allow** | `TR-4` grants Read at Self scope |
| View another student's attendance in Library A | **Deny** | Self scope excludes it |
| View revenue in Library A | **Deny** | `TR-4` holds no financial permission; ownership of C is not considered |
| View revenue in Library C | **Deny** | Library C is not the active tenant |
| Switch to Library C, then view revenue | **Allow** | After switching, `TR-1` applies and C is active |

---

## 7.9 Security Rules

### Privilege escalation prevention

`AUTH-7.62` — No account **MAY** obtain a permission it was not explicitly granted, by any sequence of permitted
actions.

`AUTH-7.63` — No account **MAY** assign, approve or elevate itself.

`AUTH-7.64` — No role **MAY** grant the ability to modify the policy that constrains it.

### Role spoofing prevention

`AUTH-7.65` — Roles **MUST** be resolved from authoritative platform state. A role asserted by a client, a
request or a module **MUST** be ignored.

`AUTH-7.66` — A request **MUST NOT** be able to name the tenant it operates in. The tenant derives from the
active context.

### Permission validation

`AUTH-7.67` — Every permission requested **MUST** exist in the closed catalogue. An unrecognised permission
**MUST** be refused, never treated as absent-therefore-harmless.

`AUTH-7.68` — Decisions **MUST** be evaluated server-side. Client-side checks are presentation only and carry no
authority.

### Unauthorized access protection

`AUTH-7.69` — Denials **MUST** disclose nothing about the resource, its existence or the reason for refusal.

`AUTH-7.70` — Repeated denials **MUST** be observable to security monitoring as a potential probing pattern.

### Audit requirements

`AUTH-7.71` — Every role assignment, revocation, elevation, expiry and policy change **MUST** emit an event.

`AUTH-7.72` — Every denial on a sensitive resource **MUST** be recorded.

`AUTH-7.73` — Audit records **MUST NOT** be alterable by any role, platform or tenant.

---

## 7.10 Business Rules

| ID | Rule |
|---|---|
| `BR-7.1` | Authorization is evaluated at every access decision, never captured at sign-in |
| `BR-7.2` | Authentication success confers no permission |
| `BR-7.3` | Absence of an explicit grant is refusal |
| `BR-7.4` | Permissions are granted by name and never derived |
| `BR-7.5` | Roles do not inherit from one another |
| `BR-7.6` | Every decision is evaluated with exactly one tenant in scope |
| `BR-7.7` | A tenant-scoped decision without a tenant is refused |
| `BR-7.8` | Only roles held in the active tenant are considered |
| `BR-7.9` | Deny always defeats allow |
| `BR-7.10` | Effective permissions are the union of held roles, less explicit denials |
| `BR-7.11` | A scoped permission cannot be exercised without naming its resource |
| `BR-7.12` | Read, Create, Update, Delete, Approve and Export are granted independently |
| `BR-7.13` | Approve and Export are never implied by another action |
| `BR-7.14` | The permission catalogue is closed |
| `BR-7.15` | An unrecognised permission is refused |
| `BR-7.16` | No account may assign a role to itself |
| `BR-7.17` | No account may assign permissions it does not hold |
| `BR-7.18` | Roles are assignable only to Active accounts |
| `BR-7.19` | A library always retains at least one Owner |
| `BR-7.20` | Temporary access requires two distinct accounts and terminates automatically |
| `BR-7.21` | Platform Support elevation never exceeds `CFG-12` |
| `BR-7.22` | Owner, Manager, Reception and both platform roles are invite-only |
| `BR-7.23` | Platform roles confer no access to tenant business data |
| `BR-7.24` | Tenant roles confer no platform authority |
| `BR-7.25` | Policy is platform-defined; no tenant may alter it |
| `BR-7.26` | Policy changes take effect at the next decision without re-authentication |
| `BR-7.27` | Roles asserted by a client or module are ignored |
| `BR-7.28` | A request cannot name its own tenant |
| `BR-7.29` | Denials are indistinguishable from non-existence |
| `BR-7.30` | Decisions are evaluated server-side only |
| `BR-7.31` | Every assignment, revocation, elevation, expiry and policy change emits an event |
| `BR-7.32` | Audit records are immutable to every role |
| `BR-7.33` | Where evaluation cannot complete, the outcome is denial |

---

## 7.11 Edge Cases

| ID | Scenario | Required behaviour |
|---|---|---|
| `XC-7.1` | **Account holds several roles in one library** | Effective permissions are the union of grants, less explicit denials. A denial attached to any held role prevails |
| `XC-7.2` | **Account holds Reception and Manager in one library** | Union applies for operational permissions; the Reception denial on financial data still prevails, because deny defeats allow |
| `XC-7.3` | **Account switches library** | The prior context is discarded entirely. Permissions become exactly those of the new tenant. No residue survives |
| `XC-7.4` | **Permission revoked during an active session** | The next decision denies. The session remains authenticated |
| `XC-7.5` | **Role deleted from the model while accounts hold it** | Every assignment of that role ceases to grant anything. Holders fall to whatever remains, possibly nothing. No implicit substitution occurs |
| `XC-7.6` | **Temporary role expires mid-operation** | The next decision denies. No grace period, no auto-renewal, no completion of the in-flight action |
| `XC-7.7` | **Policy conflict — allow and deny both match** | Deny prevails, unconditionally |
| `XC-7.8` | **Two allow rules match at different scopes** | The narrower scope governs. Scopes narrow, never widen |
| `XC-7.9` | **Owner attempts self-removal as the last Owner** | Refused. Ownership must first be transferred |
| `XC-7.10` | **Owner removes themselves while another Owner exists** | Permitted. Effective immediately; the account keeps roles held elsewhere |
| `XC-7.11` | **Platform Support requires tenant access** | Elevation requested with tenant and purpose, approved by a distinct Platform Administrator, expiring at `CFG-12`. Every action attributed |
| `XC-7.12` | **Platform Support attempts to approve their own elevation** | Refused by separation of duties |
| `XC-7.13` | **Platform Administrator attempts to read tenant data without elevation** | Refused. Platform authority does not extend to tenant contents |
| `XC-7.14` | **Request names a tenant explicitly** | The named tenant is ignored; the active context governs. If none is active, the request is refused |
| `XC-7.15` | **Client asserts a role it does not hold** | Ignored. Roles resolve from platform state only |
| `XC-7.16` | **Unrecognised permission requested** | Refused, and recorded as anomalous |
| `XC-7.17` | **Scoped permission requested without a resource** | Refused. Never interpreted as applying to all resources |
| `XC-7.18` | **Account holds no role in the active tenant** | Every tenant-scoped decision denies. The account is authenticated and authorised for nothing |
| `XC-7.19` | **Library suspended while an account operates in it** | Every decision in that library denies. Roles are retained for reinstatement |
| `XC-7.20` | **Role granted during an active session** | Effective at the next decision. No re-authentication required |
| `XC-7.21` | **Policy changed while sessions are active** | Effective at the next decision, for every session, with no re-authentication |
| `XC-7.22` | **Manager attempts to assign Owner** | Refused — exceeds the assigner's own permissions |
| `XC-7.23` | **Role assignment to a suspended account** | Refused. Subjects must be Active |
| `XC-7.24` | **Parent attempts to view an unlinked student** | Refused, indistinguishably from the student not existing |
| `XC-7.25` | **Student attempts to view another student's record** | Refused by Self scope, indistinguishably from non-existence |
| `XC-7.26` | **Policy store unavailable** | Every decision denies. Fail closed, without exception for any role |

---

## 7.12 Acceptance Criteria

| ID | Criterion |
|---|---|
| `AC-7.1` | Every access decision is evaluated at request time; no decision uses a role list captured at sign-in |
| `AC-7.2` | An authenticated account with no roles is denied every tenant-scoped action |
| `AC-7.3` | A tenant-scoped decision attempted with no active tenant is refused |
| `AC-7.4` | An account's roles in other libraries never alter a decision in the active library |
| `AC-7.5` | A permission not present in the closed catalogue is refused |
| `AC-7.6` | A newly introduced permission is unreachable by every role until explicitly granted |
| `AC-7.7` | An explicit deny defeats every combination of allow grants |
| `AC-7.8` | A Reception holder is denied financial permissions regardless of other roles held anywhere |
| `AC-7.9` | A scoped permission invoked without naming a resource is refused |
| `AC-7.10` | Self scope reaches only the acting account's own resources |
| `AC-7.11` | Linked scope reaches only explicitly linked subjects |
| `AC-7.12` | Granting Read confers no Create, Update, Delete, Approve or Export |
| `AC-7.13` | Export requires an explicit grant and is never implied |
| `AC-7.14` | Self-assignment is refused for every role at both scopes |
| `AC-7.15` | Assigning a role exceeding the assigner's own permissions is refused |
| `AC-7.16` | Assignment to a non-Active account is refused |
| `AC-7.17` | Removing a library's last Owner is refused |
| `AC-7.18` | Temporary access requested and approved by the same account is refused |
| `AC-7.19` | A Platform Support elevation is denied at the first decision after `CFG-12` elapses |
| `AC-7.20` | A platform role reads no tenant business data without an active elevation |
| `AC-7.21` | A role asserted by a client or module is ignored |
| `AC-7.22` | A tenant named in a request is ignored in favour of the active context |
| `AC-7.23` | Switching tenants yields exactly the new tenant's permissions, with no residue |
| `AC-7.24` | Role revocation denies the next decision while leaving the session authenticated |
| `AC-7.25` | A policy change takes effect at the next decision without re-authentication |
| `AC-7.26` | No tenant-level configuration can alter policy |
| `AC-7.27` | Denials are indistinguishable from the resource not existing, in content and shape |
| `AC-7.28` | Every assignment, revocation, elevation, expiry and policy change emits exactly one event |
| `AC-7.29` | Audit records cannot be altered by any role, including Platform Administrator |
| `AC-7.30` | An unavailable policy store results in denial for every decision, including platform roles |
| `AC-7.31` | No sequence of permitted actions yields a permission the account was not granted |
| `AC-7.32` | Decisions are unaffected by which module or interface originated the request |
