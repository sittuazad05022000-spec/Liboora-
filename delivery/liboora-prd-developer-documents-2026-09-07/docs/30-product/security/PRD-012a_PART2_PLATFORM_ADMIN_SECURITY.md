# PRD-012a — Security Automation

> **PART 2 of 8 — Platform Admin Security & Privileged Access.**
> Part 1 (*Security Vision, Scope & Objectives*) is at
> [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md) and is **not modified by this document**.
> Parts 3–8 are **not written**.

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 2 |
| **Module** | Security Automation |
| **Version** | **v0.2** (Part 2 added; Part 1 remains **v0.1**, unchanged) |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5 — the SECURITY platform holds no `BC-nn` |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1** |
| **Requirement prefix** | **`SECP-`** — continuing Part 1's registers at the ranges Part 1 reserved |
| **Rank** | **Unranked.** No `DOCUMENTATION_BASELINE.md` §3 row. **Not** Rank 3; **MUST NOT** be cited as authority against any ranked document |
| **Authorities applied** | `MASTER_PRD.md` v1.7 (Rank 1) · `ADR-0002`, `ADR-0003`, `ADR-0004`, `ADR-0011`, `ADR-0013`, `ADR-0014` (Rank 2) · `PRD-001` Authentication v2.0 `FROZEN`, `PRD-003` Student Identity v1.0, `PRD-013` v0.1 `FROZEN`, `PRD-016` v0.1 `FROZEN` (Rank 3) · Bounded Context Map v1.8, Module Dependency Matrix (Rank 4) · `ARCHITECTURE_RULINGS.md` (Rank 5) · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.2 (Rank 6, **descriptive**) |
| **Date** | 2026-08-21 |
| **Written at** | `f15655f4f45cd19d4e61738e6573126630aa7790` |

---

## 0. How to read Part 2

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default requiring a recorded
reason to depart from. **MAY** is genuinely optional. Part 1 §0.1's **directional principle** category also applies:
a directional statement carries **no V1 obligation**.

### 0.2 What Part 2 does, and does not, do

| Part 2 does | Part 2 does **not** |
|---|---|
| State the **security properties** the platform-admin privilege model must exhibit | Define roles, permissions, sessions, credentials or policy — those are `BC-18`'s (`SECP-XC-006`) |
| Enumerate **high-risk administrative operations** as a closed set | Create a new role, a new permission or a new authentication factor |
| Require that privileged paths are **verified to fail**, not assumed to fail | Restate, move or reinterpret any `PRD-001`, `PRD-003`, `PRD-013` or `PRD-016` requirement |
| Record conflicts where a desired control is blocked by a ranked authority | Resolve such a conflict, or grant itself an exception |
| Bind each normative requirement to a measurable acceptance criterion | Specify tables, APIs, SQL, code, UI, cloud resources or cryptographic mechanisms |

> ⚠ **The single most important reading rule.** `PRD-001` v2.0 is **`FROZEN` and Rank 3**; this document is
> **unranked**. Where Part 2 appears to state an admin-security rule, it is either (a) **citing** `PRD-001` and adding
> a *verification* obligation, or (b) recording a **gap**. It never adds an authorisation or authentication rule of
> its own. `SECP-XC-006` and `SECP-XC-011` make that structural.

### 0.3 Identifier registers — Part 2's ranges

Part 1 §0.3 published reserved ranges as a promise. Part 2 **continues those ranges** rather than opening new
prefixes, because `PRD_LIFECYCLE.md` §5 rule 3 favours the existing register and rule 4 requires contiguity.

| Register | Meaning | Part 1 | **Part 2** | Part 2 range | Reserved for Parts 3–8 |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 0 *(declared empty)* | **18** | `001`…`018` | `019`+ |
| `SECP-BR-NNN` | Business rule | 0 *(declared empty)* | **8** | `001`…`008` | `009`+ |
| `SECP-HRO-NNN` | **High-risk administrative operation** — closed set | — *(new in Part 2)* | **12** | `001`…`012` | `013`+ |
| `SECP-XC-NNN` | Exclusion | 10 | **8** | `011`…`018` | `019`+ |
| `SECP-OWN-NNN` | Ownership boundary | 11 | **4** | `012`…`015` | `016`+ |
| `SECP-AC-NNN` | Acceptance criterion | 14 | **27** | `015`…`041` | `042`+ |
| `SECP-GAP-NNN` | Open gap, conflict or dependency | 13 | **8** | `014`…`021` | `022`+ |

**Part 2 total: 85 identifiers.** Cumulative `PRD-012a` total: **157**.

> Identifiers from Part 1 (`SECP-XC-003`, `SECP-OWN-001`, `SECP-GAP-005` and others) appear in Part 2 as
> **citations**. A citation is not a declaration: Part 2 declares only within the ranges above, and re-states no
> Part 1 requirement.

**Still deliberately empty after Part 2:**

| Register | Why still empty |
|---|---|
| `SECP-INV-NNN` | An invariant requires an owned aggregate. Part 1 §0.5 declares none, and Part 2 declares none — `SECP-GAP-010` |
| `SECP-EVT-NNN` | An event requires a BC Map §9 producer row. This module holds no `BC-nn`. Admin security events are **`BC-18`'s** (`AUTH-2.7`) and **`BC-24`'s** to record — `SECP-OWN-005`, `SECP-XC-013` |
| `SECP-CFG-NNN` | Every parameter Part 2 relies on is **already** a `PRD-001` configurable — `CFG-5`, `CFG-6`, `CFG-12`. Minting a `SECP-CFG-*` duplicate would create a second source of truth. `SECP-XC-014` |

### 0.4 Collision check — run before writing, per Stage 2 rule 2

| Candidate | Measurement across `docs/ lib/ test/ tool/ packages/` | Verdict |
|---|---|---|
| `SECP-FR-`, `SECP-BR-`, `SECP-XC-`, `SECP-OWN-`, `SECP-AC-`, `SECP-GAP-` | Existing only within `PRD-012a`; Part 2 continues above each published maximum (`XC-010`, `OWN-011`, `AC-014`, `GAP-013`) | ✅ Continued, no overlap |
| **`SECP-HRO-`** | **0 hits** | ✅ **SELECTED** |
| `SECP-PA-`, `SECP-ADM-`, `SECP-OP-`, `SECP-ROL-`, `SECP-SEV-`, `SECP-DEP-` | 0 each — free, not needed | Not used |

`SECP-HRO-` is modelled on an existing precedent rather than invented in style: `PRD-003` §5.1 publishes
`SPO-1`…`SPO-9` as a **closed set of protected operations**. `SECP-HRO-*` is the same device applied to
platform-side operations, and §5 states its closure explicitly.

---

## 1. Purpose and scope of Part 2

### 1.1 Purpose

Part 1 `SECP-OBJ-004` set the objective: *no standing privileged access to tenant business data exists*. Part 2
states the security properties that must hold around **platform-side privilege** for that objective to be
believable — and, critically, states which of them are **already specified at Rank 3** and which are **absent and
blocked**.

`PRD-001` describes `PR-1` Platform Administrator as *"the highest-privilege role on the platform and the primary
target for compromise"*, requiring *"the strictest session limits, complete action attribution, and separation of
duties from Platform Support."* Part 2 does not restate that model. It does three things the model does not do:

1. **Enumerates the high-risk operation set** (`SECP-HRO-*`) so that "sensitive action" stops being a loose term.
2. **Requires proof.** A privileged path that is believed to fail but is never tested is an assumption, not a
   control. Every `SECP-FR-*` here is bound to a criterion that can fail.
3. **Records what V1 cannot do**, including one control that is *prohibited* rather than merely deferred (§10) and
   one that is *blocked by Rank 1* (`SECP-GAP-015`).

### 1.2 Why the platform-admin surface is treated as the highest-value target

`PRD-001` §8.1 states that a single account may hold roles in several tenants and therefore *"compromising one
account can therefore expose several tenants."* A platform role is worse: it sits **outside every tenant boundary**
by construction. Part 1 `SECP-OBJ-002` therefore sets the containment requirement in its strongest form for this
surface — compromise of a platform-admin *session, device or client* must not by itself yield tenant business data,
because the model requires an **approved, purpose-stated, expiring elevation** in between.

### 1.3 What Part 2 explicitly does not claim

Consistent with Part 1 §2.2, Part 2 makes **no claim that the platform-admin surface cannot be compromised.** A
Platform Administrator with a valid session, an approved elevation and a cooperating second administrator is
operating *inside* the model, not against it. What the model must guarantee is narrower and testable: that such
activity is **bounded, expiring, attributed and recorded**, and that the *absence* of those conditions produces
refusal rather than access.

---

## 2. Platform Admin identity and access boundaries

### 2.1 The boundary, as already fixed at Rank 3

| Boundary | Fixed by | Part 2's role |
|---|---|---|
| Platform roles are a **closed set of two** — `PR-1`, `PR-2` | `PRD-001` §2.3 | Cite; forbid extension (`SECP-XC-012`) |
| Platform roles grant **no** tenant business data access | `AUTH-2.5`, `AUTH-7.13` | Require verification (`SECP-FR-001`) |
| Tenant access requires elevation: tenant + purpose, distinct approver, auto-expiry at `CFG-12` | `XC-2.5`, `AUTH-7.19` | Require verification (`SECP-FR-004`…`007`) |
| Platform and tenant role namespaces are **distinct**; neither converts by assertion | `PRD-001` Role Separation | Require verification (`SECP-FR-014`) |
| A platform admin **cannot** impersonate a tenant user | `PR-1` Limitations | Forbid any such path (`SECP-XC-015`) |

### 2.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-001`** | A platform-role identity **MUST NOT** be able to read, list, export, search, aggregate or infer tenant business data in the absence of an active approved elevation. Refusal **MUST** be indistinguishable from the absence of the data | `BC-18` (decision) + SECURITY (verification) | `SECP-AC-015` |
| **`SECP-FR-002`** | A platform-role identity **MUST NOT** hold, or be able to obtain, any tenant role by its own action | `BC-18` | `SECP-AC-016` |
| **`SECP-FR-003`** | The platform-role set **MUST** be closed at `PR-1` and `PR-2`. A privileged capability that does not fit either **MUST** be refused, not accommodated by a new role | `BC-18` | `SECP-AC-017` |

⚠ **`SECP-FR-001`'s indistinguishability clause is a citation, not an invention.** `AC-2.3` already requires that an
account without a role in a library receives *"responses identical to an account that does not exist."* Part 2
extends the *verification* of that property to the platform-role case, where the risk is enumeration of tenants.

---

## 3. Admin roles and least privilege

### 3.1 Least privilege as it applies to platform roles

`PRD-001` §2.7 defines Least Privilege as *"every role holds the minimum permissions its function requires"* and
adds that *"permissions are not granted in anticipation."* Applied to the platform surface, the consequential rules
are already present and Part 2 cites them:

- `PR-2` Platform Support holds **read** access to *non-sensitive operational metadata* only, and **cannot assign any
  role**, platform or tenant.
- `PR-2` **cannot extend its own elevation**, and **cannot access authentication factors or session secrets under any
  circumstance**.
- `PR-1` **cannot approve their own elevation request**.

### 3.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-004`** | An elevation **MUST** be scoped to exactly one tenant and **MUST NOT** be usable against any other tenant, including through a cached decision, a shared index, a report, an export or a background job | `BC-18` + DATA PLATFORM | `SECP-AC-018` |
| **`SECP-FR-005`** | An elevation **MUST** state a purpose at request time, and the purpose **MUST** be carried into the audit record rather than reconstructed later | `BC-18` (emit) + `BC-24` (record) | `SECP-AC-019` |
| **`SECP-FR-006`** | An elevation **MUST** expire automatically at `CFG-12` without requiring any actor to end it, and **MUST NOT** be renewable, extendable or self-approvable by its holder | `BC-18` | `SECP-AC-020` |
| **`SECP-FR-007`** | A privileged capability **MUST NOT** be granted in anticipation of need. A capability with no current approved use **MUST** be absent, not dormant behind a flag | `BC-18` + `BC-25` | `SECP-AC-021` |

**`SECP-BR-001`** — A platform-role identity's effective authority over tenant business data is **exactly** the union
of its active approved elevations, and is **empty** when none is active.

---

## 4. RBAC and authorisation enforcement

### 4.1 This module enforces; it does not decide

Part 1 `SECP-XC-003` is absolute: this module **MUST NOT** produce, cache, alter or short-circuit an authorisation
outcome. `BC-18` owns policy decisions and exposes them through `platform/identity:policy_decision`
(`tool/module_dependencies.yaml`). Part 2 therefore states enforcement *properties*, never policy content.

### 4.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-008`** | Every authorisation decision on a privileged path **MUST** be reached server-side. A client-supplied claim of platform role, elevation state, tenant or permission **MUST NOT** be accepted as evidence of that state | SECURITY (enforcement) + `BC-18` (decision) | `SECP-AC-022` |
| **`SECP-FR-009`** | A privileged operation **MUST** be refused when the authorisation decision cannot be obtained, is stale, or is ambiguous. Unavailability of the decision point **MUST** produce refusal, never a permissive default | SECURITY | `SECP-AC-023` |
| **`SECP-FR-010`** | Authority **MUST** be re-asserted at each decision point rather than derived from an earlier decision, a session attribute or a cached elevation state | `BC-18` + SECURITY (verification) | `SECP-AC-024` |

**`SECP-BR-002`** — Where two rules could both apply to a privileged operation and produce different outcomes, the
outcome **MUST** be denial. *(Cites `AUTH-2.26`; stated here because privileged paths are where the ambiguity is
most consequential.)* — verified by **`SECP-AC-023`**.

**`SECP-BR-003`** — Absence of an explicit grant on a privileged path is **refusal**, matching
`tool/module_dependencies.yaml` L21 `default_decision: deny` and Part 1 `SECP-PRN-003`. — verified by
**`SECP-AC-022`**.

⚠ **`SECP-FR-010` is `ADR-0003` applied to privilege, not a new rule.** `ADR-0003` requires tenant isolation
*"at every authorization decision rather than at a data partition"*, making it *"a continuous obligation, not a
one-time structural guarantee."* An elevation checked once and trusted thereafter would reintroduce exactly the
one-time model `ADR-0003` rejected.

---

## 5. High-risk administrative operations — `SECP-HRO-*`, a closed set

### 5.1 Why a closed set

"Sensitive action" is unverifiable as a category — a test cannot prove a property of an open-ended list.
`PRD-003` §5.1 solved the same problem with `SPO-1`…`SPO-9`, *"protected operations — closed set."* Part 2 applies
the device to the platform surface.

**Closure rule — `SECP-BR-004`:** the set below is **closed for V1**. An operation that is platform-scoped,
irreversible or tenant-affecting and is **not** listed **MUST** be treated as high-risk by default and **MUST** be
refused until it is added to this register by amendment. Silence is not permission.

| ID | High-risk operation | Already governed by | Class |
|---|---|---|---|
| **`SECP-HRO-001`** | Assign or revoke a **platform role** (`PR-1`, `PR-2`) | `AUTH-2.6` — by a Platform Administrator **other than** the subject | Two-person |
| **`SECP-HRO-002`** | **Approve** an elevation request | `XC-2.5` — distinct approver; `AC-2.12` — self-approval refused | Two-person |
| **`SECP-HRO-003`** | **Request** an elevation to a tenant | `XC-2.5` — tenant + purpose stated | Attributed |
| **`SECP-HRO-004`** | Provision, suspend or reinstate a **tenant** | `PR-1` Purpose (*"provision and suspend tenants"*); `XC-2.15` | Tenant-affecting |
| **`SECP-HRO-005`** | Change **platform configuration** | `PR-1` Scope; `BC-25` owns the hierarchy | Platform-affecting |
| **`SECP-HRO-006`** | Suspend, reinstate, archive or restore an **identity status** | `PRD-003` `SPO-8`, `SID-3.32` — **status only, never profile content** | Person-affecting |
| **`SECP-HRO-007`** | Suspend, lock, disable or delete an **account** | `PRD-001` §9 lifecycle; `XC-2.7`, `XC-2.8` | Person-affecting |
| **`SECP-HRO-008`** | Force **global sign-out** / terminate sessions | `AUTH-8.80` | Availability-affecting |
| **`SECP-HRO-009`** | Read, list or export **tenant business data** under an active elevation | `AC-2.10`; `AUTH-8.96` | Data access |
| **`SECP-HRO-010`** | Read or export **personal data** of an identified person | `AUTH-8.70` — explicit elevation bounded by `CFG-12`, event emitted | Data access |
| **`SECP-HRO-011`** | Change the **secret** held in the vault, or its rotation state | Part 1 §5 row 1 — SECURITY owns the vault; `BC-25` owns references | Platform-affecting |
| **`SECP-HRO-012`** | Alter **security enforcement state** — throttle thresholds, redaction rules, isolation verification switches | Part 1 `SECP-OWN-001`; `MP-GBR-09` (*cache-key change is security-reviewable*) | Control-affecting |

### 5.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-011`** | Every `SECP-HRO-*` operation **MUST** emit an audit record naming actor, operation, target, tenant scope (or explicit platform scope), purpose where one is required, and time — before the operation is treated as complete | `BC-24` (record) + emitting context | `SECP-AC-025` |
| **`SECP-FR-012`** | An operation meeting the §5.1 closure test but absent from the register **MUST** be refused, and the refusal **MUST** be recorded as a security event | SECURITY + `BC-18` | `SECP-AC-026` |
| **`SECP-FR-013`** | `SECP-HRO-001` and `SECP-HRO-002` **MUST** require two distinct accounts. A single account **MUST NOT** be able to complete either, including across separate sessions, devices or elevations of itself | `BC-18` | `SECP-AC-027` |

**`SECP-BR-005`** — `SECP-HRO-006` **MUST NOT** be usable to reach profile *content*. `SID-3.32` and `SID-AC-18`
confine Platform Administrator authority to identity **status**; a status operation that exposes or edits content
would breach `PRD-003`'s boundary, not this module's.

---

## 6. Privilege-escalation prevention

### 6.1 The escalation paths that are already closed

| Path | Closed by |
|---|---|
| Self-assignment of a platform role | `AUTH-2.6`, `AC-2.9` |
| Self-assignment of a tenant role by a platform admin | `XC-2.14`, `AUTH-2.23` |
| Self-approval of an elevation | `AC-2.12`, `PR-1` Limitations |
| Self-extension of an elevation | `PR-2` Limitations, `AUTH-7.19` |
| Assigning a role exceeding one's own | `XC-2.11` |
| Deriving a permission by seniority or name similarity | `PRD-001` Explicit Authorization |
| Ambiguity resolving permissively | `AUTH-2.26` |
| Union of roles overriding an explicit denial | `XC-2.16` |

### 6.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-014`** | A tenant-scoped identity **MUST NOT** be able to acquire platform authority, and a platform-scoped identity **MUST NOT** be able to acquire tenant authority, by any sequence of otherwise-permitted operations | `BC-18` | `SECP-AC-028` |
| **`SECP-FR-015`** | Escalation **MUST NOT** be reachable by indirect means — including role union, elevation chaining, approving one's own request through a second identity one controls, replaying an expired elevation, or reusing a decision issued for a different tenant | `BC-18` + SECURITY (verification) | `SECP-AC-029`, `SECP-AC-030` |

**`SECP-BR-006`** — An escalation **attempt** is a security event in its own right and **MUST** be recorded whether
it succeeded or failed. A refused attempt that leaves no trace is indistinguishable from an attempt that never
happened.

⚠ **`SECP-FR-015` names "approving one's own request through a second identity one controls" as a threat V1 does
not fully close.** `AC-2.12` prevents *self*-approval by account identity; it cannot detect two accounts operated by
one person. Collusion detection is an anomaly-detection capability, EA **V2**. Recorded as **`SECP-GAP-016`**, not
claimed.

---

## 7. Admin session security

### 7.1 What is already fixed

`AUTH-6.19` requires that sessions held by accounts with **staff or platform roles** use the shorter boundaries —
`CFG-5` 30 minutes idle and `CFG-6` 12 hours absolute (`BR-6.7`, benchmarked to *"NIST SP 800-63B AAL2"*).
`AUTH-8.82` forbids extension beyond the absolute boundary *"by any activity"*. `AUTH-8.80` requires global sign-out
effective *"at the next use of every session, on every device"*. `XC-2.10` establishes that authentication and
authorisation fail **independently** — a valid session that has lost its role is authenticated but unauthorised.

### 7.2 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-016`** | A platform-role session **MUST NOT** outlive the shorter staff boundaries, and **MUST NOT** be extendable by activity, by reconnection, by device trust or by holding an active elevation | `BC-18` | `SECP-AC-031` |
| **`SECP-FR-017`** | Revocation of a platform role or termination of a session **MUST** take effect at the next decision on every session and device, without waiting for expiry or cache invalidation | `BC-18` | `SECP-AC-032` |

**`SECP-BR-007`** — An active elevation **MUST NOT** prolong a session, and session renewal **MUST NOT** prolong an
elevation. The two lifetimes are independent; the shorter always governs. *(Follows `XC-2.6`: on expiry mid-operation
*"the in-flight operation is refused at the next decision point. No grace period, no automatic renewal."*)*

---

## 8. Sensitive-action re-authentication and step-up

### 8.1 ⚠ The V1 constraint that shapes this section

Step-up re-authentication normally means *a second, stronger factor*. **V1 has exactly one factor** — mobile OTP —
fixed at Rank 1 by `MP-CON-11` and `MP-GBR-25`, and Part 1 `SECP-XC-005` forbids this module from introducing
another *"in any form reachable by configuration, feature flag, environment or administrative action."*

Therefore **"step-up" in V1 can only mean re-assertion of the same factor**, not a stronger one. Part 2 states this
plainly rather than implying a strength the platform does not have.

### 8.2 What `PRD-001` already requires

`AUTH-8.81` is the existing step-up rule: *"A stolen device holding a valid session MUST NOT be able to change the
mobile number, remove other devices or elevate access without re-authentication."* Note its scope — it covers
**number change, device removal and access elevation**. It does **not** enumerate the platform-side operations of §5.

### 8.3 Normative requirements

| ID | Requirement | Owner | AC |
|---|---|---|---|
| **`SECP-FR-018`** | Re-authentication **MUST** be required before `SECP-HRO-001`, `SECP-HRO-002`, `SECP-HRO-011` and `SECP-HRO-012`, and the re-authentication **MUST NOT** be satisfiable by session possession, device trust or a prior re-authentication older than the operation's own request | `BC-18` (mechanism) + SECURITY (obligation) | `SECP-AC-033` |

**`SECP-BR-008`** — Re-authentication in V1 **MUST NOT** be described, logged or presented as a second factor. It is
re-assertion of the sole factor, and the distinction is material to any risk statement made about it. — verified by
**`SECP-AC-041`**.

⚠ **`SECP-GAP-014` — a conflict recorded, not resolved.** `SECP-FR-018` extends a re-authentication obligation to
four platform operations that `AUTH-8.81` does not name. `AUTH-8.81` sits in **frozen, Rank 3** `PRD-001`; this
document is unranked. Two readings exist:

1. `SECP-FR-018` is a **security-platform obligation layered on** `BC-18`'s existing mechanism, consistent with
   `AUTH-8.81`'s intent and adding no factor — permissible; or
2. it is an **authentication requirement**, which only `PRD-001` may set — in which case it belongs in `PRD-001` by
   amendment and **must not** be enforced from here.

**Reading 2 is the conservative one and Part 2 does not assume Reading 1.** `SECP-FR-018` is therefore marked
**`PENDING-AUTHORITY`**: it is specified and testable, and it **MUST NOT** be implemented until `BC-18`'s owner
confirms the reading. Routed to the Product Owner + `BC-18`. Per `DOCUMENTATION_BASELINE.md` L253, *"a conflict is a
defect… do not choose — raise it."*

⚠ **`SECP-GAP-015` — the deeper dependency.** With one factor, re-authentication before a high-risk operation is
*replayable by whoever controls the OTP channel*. `MP-ASM-01` already records that the factor's failure makes a
fallback factor a V1 need, and `ADR-0002` names SIM-swap as the defeat of its own chosen factor. **This module cannot
close it** — `MP-CON-11` is Rank 1 and unamended. Recorded as a **High** dependency.

---

## 9. Admin account protection

`PRD-001` §2.3 states that `PR-1` *"requires the strictest session limits, complete action attribution, and
separation of duties from Platform Support"*, and that *"assignment and revocation are themselves auditable security
events."* The protections available in V1 are those of any account — the sole factor, device notification `EV-16`,
brute-force throttling — plus the structural constraints of §§2–7.

**What V1 does not have, stated plainly:** no hardware-token requirement, no admin IP allow-listing (EA
`IP Allow/Deny` is **V2**), no admin-specific anomaly detection (EA **V2**), and no separate stronger factor
(`MP-CON-11`). Recorded as **`SECP-GAP-017`**.

The account-protection obligations for platform roles are stated where the mechanism they constrain is stated:
session bounds in §7 (`SECP-FR-016`, `SECP-FR-017`, `SECP-BR-007`), re-authentication in §8 (`SECP-FR-018`,
`SECP-BR-008`), and two-person control in §5 (`SECP-FR-013`). §9 adds **no new requirement** — it records what V1
lacks, so the lack is visible rather than implied.

⚠ **A protection that would normally be recommended and is *prohibited* here.** An "emergency admin account" or
recovery credential is the standard answer to admin lockout. `AUTH-11.54` forbids it outright — see §10.

---

## 10. Emergency / break-glass access — **PROHIBITED, not merely unsupported**

The request asked for break-glass *"where supported by the existing architecture."* It is **not** supported, and the
distinction matters: this is an **explicit Rank 3 prohibition**, not an unfilled gap.

| Authority | Text |
|---|---|
| `AUTH-11.53` | *"There MUST be no emergency bypass of authentication under any circumstance, including total delivery failure"* |
| `AUTH-11.54` | *"There MUST be no break-glass credential, master code, universal code or support-issued code"* |
| `AUD-XC-002` | *"No role, including Platform Administrator, MUST be able to alter or remove an entry. No support path, break-glass route or administrative override exists"* |
| `IMPLEMENTATION_ROADMAP.md` | *"No emergency bypass (`AUTH-11.53`), no break-glass (`AUTH-11.54`). Any mechanism proposed under either name…"* |

| ID | Exclusion | Type |
|---|---|---|
| **`SECP-XC-011`** | This module **MUST NOT** define, provide, enable or document a break-glass credential, master code, universal code, support-issued code, emergency bypass or recovery override — in any form, including one reachable only in a declared emergency | Must be impossible |
| **`SECP-XC-012`** | This module **MUST NOT** extend the platform-role set beyond `PR-1` and `PR-2`, nor create a role, capability or account class that carries platform authority under another name | Must be impossible |
| **`SECP-XC-013`** | This module **MUST NOT** own, emit as authoritative, alter, suppress or delay the audit record of an administrative action. It is an emitter and consumer only | Must be impossible |
| **`SECP-XC-014`** | This module **MUST NOT** mint a configurable duplicating `CFG-5`, `CFG-6` or `CFG-12`, nor define a second source of truth for a session or elevation bound | Must be impossible |
| **`SECP-XC-015`** | This module **MUST NOT** define or enable impersonation of a tenant user by a platform-role identity, including "view as", "act as" or session assumption | Must be impossible |
| **`SECP-XC-016`** | This module **MUST NOT** specify the Platform Admin Panel's screens, navigation, components or interaction design. It states security properties the surface must exhibit | Not owned — presentation |
| **`SECP-XC-017`** | This module **MUST NOT** define admin approval workflows, queues, escalation chains, reminders or SLA timers — `BC-28`, V2, `PRD-012b` | Not owned |
| **`SECP-XC-018`** | Part 2 **MUST NOT** be cited as specifying an authentication or authorisation *mechanism*. It states security obligations on `BC-18`'s mechanisms | Scope of this Part |

**`SECP-GAP-018`** — **The operational consequence of `SECP-XC-011` is unaddressed.** With no break-glass and a
closed two-role set, total loss of all `PR-1` accounts (or a sustained OTP-channel outage affecting them) leaves the
platform with **no path to administrative recovery**. `AUTH-11.53` explicitly contemplates *"total delivery failure"*
and still forbids bypass. `AUTH-11.59` requires that *"recovery procedures MUST be exercised, not merely
documented"* — but **no recovery procedure for this scenario exists in any Rank 1–5 document.** Owner: Product Owner
+ `BC-18`. Priority **High**. This is a genuine production risk recorded as a dependency, **not** an argument for
adding break-glass.

---

## 11. Separation between Platform Admin, Manager and operational users

`PRD-001` Role Separation is the governing statement: *"A Platform Administrator is not an Owner of any library. An
Owner has no platform authority. Neither can become the other by assertion."*

| Actor | Scope | Cannot |
|---|---|---|
| `PR-1` Platform Administrator | Platform objects only | Access tenant business data without elevation; self-assign tenant roles; impersonate; alter audit; approve own elevation |
| `PR-2` Platform Support | Platform-wide read of non-sensitive operational metadata | Assign any role; hold standing tenant access; extend own elevation; access factors or session secrets |
| `TR-1` Owner | Exactly one library | Hold platform authority; affect another library |
| `TR-2` Manager | Exactly one library | Assign Owner (`XC-2.11`); exceed own permissions |
| `TR-3` Reception | Exactly one library | Hold revenue or financial permissions (`AC-2.6`) |

| ID | Ownership boundary | **Owner** | This module's role |
|---|---|---|---|
| **`SECP-OWN-012`** | The platform-role set, tenant-role set, their separation and every permission in either | **`BC-18` Identity & Access** | Verifier only. `SECP-XC-006`, `SECP-XC-012` |
| **`SECP-OWN-013`** | Identity **status** transitions and their authority limits (`SPO-8`, `SID-3.32`) | **`BC-10` Global Person Identity** (`PRD-003`) | Cites as `SECP-HRO-006`; owns nothing |
| **`SECP-OWN-014`** | The Platform Admin Panel as a presentation surface | **Presentation — no `BC-nn`** | States security properties only. `SECP-XC-016`, and see `SECP-GAP-019` |
| **`SECP-OWN-015`** | Admin approval workflow orchestration | **`BC-28` Workflow Orchestration**, V2, `PRD-012b` | None. `SECP-XC-017` |

⚠ **`SECP-GAP-019` — the Platform Admin Panel is undefined.** The phrase *"Platform Admin Panel"* appears in **no**
document in the repository — measured, zero hits across `docs/`. `PRD_LIFECYCLE.md` Stage 1 notes that *"four of the
nineteen Master PRD modules are compositions, not contexts"*, and an admin panel is exactly such a composition. Part 2
therefore states **surface-agnostic** properties (§12) and does **not** invent the surface. Owner: Product Owner.
Priority Medium.

---

## 12. Security controls for the Platform Admin surface

Stated as properties of *whatever* surface exposes platform administration, because the surface itself is undefined
(`SECP-GAP-019`). Each restates no mechanism; each is testable.

| Property | Requirement it derives from |
|---|---|
| No privileged capability is decided or enforced in the client | `SECP-FR-008`, Part 1 `SECP-PRN-001` |
| Absence of an authorisation decision yields refusal, not a rendered control | `SECP-FR-009` |
| Tenant business data is absent from the surface without an active elevation | `SECP-FR-001` |
| The surface exposes no operation outside the `SECP-HRO-*` closed set | `SECP-FR-012`, `SECP-BR-004` |
| High-risk operations require re-authentication *(pending `SECP-GAP-014`)* | `SECP-FR-018` |
| No PII reaches logs, metrics or traces from the surface | Part 1 `SECP-OBJ-012` |
| Every operation is attributed before completion | `SECP-FR-011` |
| Secure response headers, CSRF/XSS/injection defence apply | EA Application Security **V1**; Part 1 §5 row 4 |

**`SECP-GAP-020`** — **A hidden or disabled control is not a security control.** Presentation-layer concealment of a
privileged capability is not enforcement; `SECP-FR-008` requires the server to refuse regardless of what the client
renders. No Rank 1–5 document states this for admin surfaces. Owner: Product Owner + presentation. Priority Medium.

---

## 13. Admin activity accountability and security events

`BC-24` owns *"the immutable append-only record of who did what, including AI actions and support access."*
`AUTH-2.7` already requires that *"every platform role assignment, revocation and elevation MUST emit an
authentication event."* This module **emits and consumes; it does not own** (`SECP-OWN-005`, `SECP-XC-013`).

| Requirement | Binding |
|---|---|
| Every `SECP-HRO-*` completes only after its record exists | `SECP-FR-011` / `SECP-AC-025` |
| Refused out-of-set operations are recorded | `SECP-FR-012` / `SECP-AC-026` |
| Escalation attempts are recorded whether they succeed or fail | `SECP-BR-006` / `SECP-AC-034` |
| The record is immutable **for every role, including `PR-1`** | `AUD-BR-002`, `AUD-XC-002`, `AUTH-10.20` — proven by `AUD-AC-003` |

⚠ **`SECP-GAP-021`** — inherits Part 1 `SECP-GAP-005`. BC Map L133 gives `BC-24` the record *"including support
access"*, but **no Rank 1–5 document defines the support-access action list**, and EA `Support Access Log` is **V3**.
Consequence: `SECP-FR-011` is satisfiable for the twelve enumerated **operations** and **not yet** for support
*access* as a category. Owner: Product Owner + `BC-18`. Priority **High**.

---

## 14. Tenant and data access boundaries

Part 1 `SECP-OWN-004` places isolation with **DATA PLATFORM** and `SECP-XC-003` forbids this module from producing
an authorisation outcome. `TEN-XC-010` states the same asymmetry from Tenancy's side: *"Supplying tenant context is
not deciding access."*

| Boundary | Held by | Cited requirement |
|---|---|---|
| Elevation is single-tenant and cannot bleed across tenants | `BC-18` + DATA PLATFORM | `SECP-FR-004` / `SECP-AC-018` |
| A decision issued for tenant A is unusable for tenant B | `BC-18` | `SECP-FR-015` / `SECP-AC-030` |
| Absent tenant context ⇒ refusal, never a default | DATA PLATFORM + Tenancy | Part 1 `SECP-OBJ-003`; `MP-GBR-07` |
| Cross-tenant reads are the highest-severity failure class | — | `X-13`; `MP-RSK-01` **Critical** |

⚠ **A live exposure that limits what §14 can claim.** Part 1 `SECP-GAP-006` records `D-016-01` — `recent()`/`count`
read the audit store with **no tenant argument**, a live `X-13` violation routed to `IMPL-922`. `SECP-AC-018` and
`SECP-AC-030` **cannot pass** while it stands. Carried forward unchanged; not re-numbered.

---

## 15. Acceptance criteria — `SECP-AC-015` … `SECP-AC-041`

Every criterion is a **test that can fail**. **None is claimed to be met: 0 of 27 are proven.**

| ID | Criterion | Proves |
|---|---|---|
| **`SECP-AC-015`** | A `PR-1` identity with no active elevation requests tenant business data and receives a response identical to one for data that does not exist — no record, no count, no partial field, no timing difference | `SECP-FR-001` |
| **`SECP-AC-016`** | A `PR-1` identity attempting to assign itself any tenant role is refused, for every role and every library | `SECP-FR-002` |
| **`SECP-AC-017`** | Every platform-authority path in the implementation resolves to `PR-1` or `PR-2`; no third platform role name exists anywhere | `SECP-FR-003` |
| **`SECP-AC-018`** | An elevation approved for tenant A yields refusal for tenant B on every read path, including cached decision, search index, report, export and background job | `SECP-FR-004` |
| **`SECP-AC-019`** | An elevation request without a stated purpose is refused; an approved one carries the purpose verbatim into the audit record | `SECP-FR-005` |
| **`SECP-AC-020`** | An elevation is refused at the first decision after `CFG-12`; renewal, extension and self-approval attempts are each refused | `SECP-FR-006` |
| **`SECP-AC-021`** | No privileged capability is reachable without a current approved use — including via feature flag, environment variable or configuration override | `SECP-FR-007` |
| **`SECP-AC-022`** | A request asserting platform role, elevation state, tenant or permission client-side is refused; the server-side decision governs | `SECP-FR-008` |
| **`SECP-AC-023`** | With the decision point unavailable, every privileged operation is refused; none proceeds on a cached, stale or default-permit outcome | `SECP-FR-009` |
| **`SECP-AC-024`** | Revoking authority mid-sequence causes the next decision to deny, without waiting for session or cache expiry | `SECP-FR-010` |
| **`SECP-AC-025`** | For each of the twelve `SECP-HRO-*`, an audit record exists naming actor, operation, target, scope, purpose where required, and time — and the operation is not observable as complete before the record exists | `SECP-FR-011` |
| **`SECP-AC-026`** | A platform-scoped, irreversible or tenant-affecting operation absent from `SECP-HRO-*` is refused, and the refusal is recorded | `SECP-FR-012`, `SECP-BR-004` |
| **`SECP-AC-027`** | `SECP-HRO-001` and `SECP-HRO-002` cannot be completed by one account — not in one session, not across two sessions, not across two devices, not by re-elevating itself | `SECP-FR-013` |
| **`SECP-AC-028`** | No sequence of permitted operations lets a tenant identity gain platform authority, or a platform identity gain tenant authority | `SECP-FR-014` |
| **`SECP-AC-029`** | Role union, elevation chaining and expired-elevation replay each fail to yield authority beyond the union of active approved grants | `SECP-FR-015` |
| **`SECP-AC-030`** | A decision issued for one tenant, replayed against another, is refused | `SECP-FR-015` |
| **`SECP-AC-031`** | A platform-role session is refused after 30 minutes idle or 12 hours absolute, whichever first — and is not extended by activity, reconnection, device trust or an active elevation | `SECP-FR-016` |
| **`SECP-AC-032`** | Platform-role revocation denies the next decision on every active session and device | `SECP-FR-017` |
| **`SECP-AC-033`** | *(**`PENDING-AUTHORITY`** — `SECP-GAP-014`)* Each of `SECP-HRO-001`, `002`, `011`, `012` is refused without a re-authentication bound to that request; session possession, device trust and an earlier re-authentication are each insufficient | `SECP-FR-018` |
| **`SECP-AC-034`** | A refused escalation attempt produces a security event distinguishable from no attempt | `SECP-BR-006` |
| **`SECP-AC-035`** | An identity-status operation (`SECP-HRO-006`) neither reads nor writes profile content | `SECP-BR-005`, `SID-AC-18` |
| **`SECP-AC-036`** | An active elevation does not extend a session, and session renewal does not extend an elevation; the shorter bound governs | `SECP-BR-007` |
| **`SECP-AC-037`** | No break-glass credential, master code, universal code, support-issued code or emergency bypass exists or is reachable in any environment or configuration | `SECP-XC-011`, `AUTH-11.53`, `AUTH-11.54` |
| **`SECP-AC-038`** | No impersonation, "view as", "act as" or session-assumption path exists for a platform-role identity | `SECP-XC-015` |
| **`SECP-AC-039`** | An alter or delete attempt against an administrative audit record fails while acting as `PR-1`, with no privileged path succeeding | `SECP-XC-013`; models `AUD-AC-003` |
| **`SECP-AC-040`** | Concealing a privileged control in the client does not permit it: the server refuses the operation when it is invoked directly | `SECP-GAP-020`, `SECP-FR-008` |
| **`SECP-AC-041`** | No V1 re-authentication prompt, log entry, audit field, event payload or user-facing text characterises the re-assertion as a second factor, two-factor, 2FA or MFA | `SECP-BR-008` |

### 15.1 Coverage

| Normative statements | Count | Bound to a criterion |
|---|---|---|
| `SECP-FR-001` … `SECP-FR-018` | 18 | 18 — each row carries its AC in the requirement table |
| `SECP-BR-001` … `SECP-BR-008` | 8 | 8 — `BR-001`→`AC-015`/`018`/`020` · `BR-002`→`AC-023` · `BR-003`→`AC-022` · `BR-004`→`AC-026` · `BR-005`→`AC-035` · `BR-006`→`AC-034` · `BR-007`→`AC-036` · `BR-008`→**`AC-041`** |
| **Total** | **26** | **26 — uncovered: none** |

**Proven: 0 of 27 criteria.** `SECP-AC-033` is additionally **`PENDING-AUTHORITY`** (`SECP-GAP-014`), and
`SECP-AC-018` / `SECP-AC-030` **cannot pass** while `D-016-01` stands (§14).

---

## 16. Gaps, conflicts and dependencies introduced by Part 2

**All 8 are OPEN.** None is resolved here.

| ID | Gap / conflict | Owner | Priority |
|---|---|---|---|
| **`SECP-GAP-014`** | `SECP-FR-018` may be an authentication requirement, which only frozen Rank 3 `PRD-001` may set. Marked **`PENDING-AUTHORITY`**; not to be implemented until `BC-18`'s owner rules | Product Owner + `BC-18` | **High** |
| **`SECP-GAP-015`** | Single-factor re-authentication is replayable by whoever controls the OTP channel. Blocked by Rank 1 `MP-CON-11`; `MP-ASM-01` and `ADR-0002` already record the exposure | Product Owner | **High** |
| **`SECP-GAP-016`** | Two accounts operated by one person defeat two-person control. Collusion/anomaly detection is EA **V2** | Product Owner | Medium |
| **`SECP-GAP-017`** | No admin-specific hardening in V1 — no hardware token, no IP allow-listing (EA **V2**), no admin anomaly detection (EA **V2**), no stronger factor (Rank 1) | Product Owner | **High** |
| **`SECP-GAP-018`** | **No administrative recovery path exists.** Break-glass is prohibited (`AUTH-11.54`) and the two-role set is closed; total loss of `PR-1` access has no documented procedure, though `AUTH-11.59` requires procedures be *exercised* | Product Owner + `BC-18` | **High** |
| **`SECP-GAP-019`** | The **Platform Admin Panel is undefined** — zero occurrences repo-wide. Part 2 states surface-agnostic properties instead of inventing it | Product Owner | Medium |
| **`SECP-GAP-020`** | No Rank 1–5 authority states that client-side concealment is not enforcement for admin surfaces | Product Owner | Medium |
| **`SECP-GAP-021`** | Support-access action list still undefined (inherits Part 1 `SECP-GAP-005`, `AUD-GAP-004`); EA `Support Access Log` is **V3** | Product Owner + `BC-18` | **High** |

### 16.1 Conflicts NOT silently resolved

`SECP-GAP-014` is the sharpest: a control that good practice demands (step-up before high-risk admin operations)
sits at a boundary this unranked document may not cross. Writing `SECP-FR-018` as plainly binding was available and
would have read better. It was rejected — the requirement is stated, made testable, and **gated** pending the owning
context's ruling. `SECP-GAP-018` is the honest counterpart: the correct answer to admin lockout is *prohibited* here,
so the risk is recorded rather than engineered around.

---

## 17. Lifecycle status

| Stage | Status |
|---|---|
| 1 — Discovery | ⚠ Unchanged from Part 1 — gate not met as written (no `BC-nn`); authority to proceed is `PRD_REGISTRY.md` §4.1. `SECP-GAP-010` |
| 2 — Draft | **In progress.** Parts 1–2 written; **Parts 3–8 not written, so Stage 2 is not complete** |
| 3–9 | **Not started.** `SECP-` is **not** registered in `TRACEABILITY_MATRIX.md`; no `IMPL-*` range; no baseline row; **unranked** |

---

## 18. Change history

| Version | Date | Change |
|---|---|---|
| **v0.2** | 2026-08-21 | **PART 2 added — Platform Admin Security & Privileged Access.** 85 identifiers: `SECP-FR-001`…`018`, `SECP-BR-001`…`008`, **`SECP-HRO-001`…`012`** (new register, 0 collisions, modelled on `PRD-003` `SPO-1`…`9`), `SECP-XC-011`…`018`, `SECP-OWN-012`…`015`, `SECP-AC-015`…`041`, `SECP-GAP-014`…`021`. All 26 normative statements bound to criteria; **0 of 27 proven**. `SECP-AC-041` was added during validation after a coverage check found `SECP-BR-008` unbound — the defect is recorded rather than the claim softened. **Break-glass recorded as PROHIBITED** by `AUTH-11.53`/`AUTH-11.54`, not as an unfilled gap — and its operational consequence raised as `SECP-GAP-018`. **`SECP-FR-018` marked `PENDING-AUTHORITY`** rather than asserted over frozen Rank 3 `PRD-001` (`SECP-GAP-014`). Platform Admin Panel found **undefined repo-wide** (`SECP-GAP-019`); surface-agnostic properties stated instead. **Part 1 not modified. No frozen document touched. No role, permission, factor, table, API, SQL, code or configurable created.** Parts 3–8 not written |
