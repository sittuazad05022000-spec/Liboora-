# PRD-012a — Security Automation

> **PART 3 of 8 — Zero Trust, IAM & Multi-Tenant Security.**
> Part 1 (*Security Vision, Scope & Objectives*) is at
> [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md).
> Part 2 (*Platform Admin Security & Privileged Access*) is at
> [`PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md).
> **Neither is modified by this document.**

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 3 |
| **Module** | Security Automation |
| **Version** | **v0.3** (Part 3 added; Parts 1–2 unchanged) |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5 — the SECURITY platform holds no `BC-nn` |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1** — with the V2/V3 boundaries of §2.3 stated explicitly |
| **Requirement prefix** | **`SECP-`** — continuing Part 1's registers at the ranges Part 1 reserved |
| **Rank** | **Unranked.** No `DOCUMENTATION_BASELINE.md` §3 row. **MUST NOT** be cited as authority against any ranked document |
| **Authorities applied** | `MASTER_PRD.md` v1.7 (Rank 1) · `ADR-0002`, `ADR-0003`, `ADR-0004`, `ADR-0011`, `ADR-0013`, `ADR-0014` (Rank 2) · `PRD-001` v2.0 `FROZEN`, `PRD-003` v1.0, `PRD-013` v0.1 `FROZEN`, `PRD-016` v0.1 `FROZEN`, `PRD-017` v0.2 `FROZEN`, `PRD-023` v0.1 `FROZEN` (Rank 3) · Bounded Context Map v1.8, Module Dependency Matrix (Rank 4) · `ARCHITECTURE_RULINGS.md` (Rank 5) · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.2 (Rank 6, **descriptive**) |
| **Date** | 2026-08-21 |
| **Written at** | `e83ad29b5f2cffbde918878e20cc215d90a1b1f7` |

---

## 0. How to read Part 3

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default requiring a recorded
reason to depart from. **MAY** is genuinely optional. Part 1 §0.1's **directional principle** category also applies:
a directional statement carries **no V1 obligation** and **MUST NOT** be implemented as though it did.

### 0.2 What Part 3 does, and does not, do

| Part 3 does | Part 3 does **not** |
|---|---|
| State which Zero Trust properties are **V1 obligations** and which are **directional only** | Declare Zero Trust Architecture a V1 capability — EA L2050 tags it **V3** |
| Require that tenant isolation is **verified**, at every decision, by test | Define the tenant-partitioning mechanism or row-level security policy — `BC-19`/DATA own it |
| Require that authorisation failure is **closed**, and that closure is provable | Define roles, permissions, policy or decisions — `BC-18` owns them (`SECP-XC-006`) |
| Bind privilege-escalation prevention to the closed `SECP-HRO-*` set from Part 2 | Create a role, permission, scope or authentication factor |
| Record where a wanted control is blocked by rank, scope or absence | Resolve such a conflict, or grant itself an exception |
| Bind every normative requirement to a measurable criterion | Specify tables, APIs, SQL, code, UI, cloud resources or cryptographic mechanisms |

> ⚠ **The reading rule from Part 2 §0.2 is unchanged and governs Part 3.** `PRD-001` v2.0 is **`FROZEN` and Rank 3**;
> this document is **unranked**. Where Part 3 appears to state an IAM rule, it is either (a) **citing** a ranked
> requirement and adding a *verification* obligation, or (b) recording a **gap**. It never adds an authorisation or
> authentication rule of its own.

### 0.3 Identifier registers — Part 3's ranges

Part 3 continues Part 1's registers. **No identifier declared in Part 1 or Part 2 is renumbered, reworded or
withdrawn.** Ranges are contiguous, as `PRD_LIFECYCLE.md` §5 rule 4 requires.

| Register | Meaning | Parts 1–2 | **Part 3** | Part 3 range | Reserved for Parts 4–8 |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 18 | **12** | `019`…`030` | `031`+ |
| `SECP-BR-NNN` | Business rule | 8 | **3** | `009`…`011` | `012`+ |
| `SECP-XC-NNN` | Exclusion | 18 | **4** | `019`…`022` | `023`+ |
| `SECP-OWN-NNN` | Ownership boundary | 15 | **3** | `016`…`018` | `019`+ |
| `SECP-AC-NNN` | Acceptance criterion | 41 | **16** | `042`…`057` | `058`+ |
| `SECP-GAP-NNN` | Gap / open question | 21 | **3** | `022`…`024` | `025`+ |
| `SECP-OBJ-NNN` | Objective | 12 | **0** | — | `013`+ |
| `SECP-PRN-NNN` | Principle | 12 | **0** | — | `013`+ |
| `SECP-HRO-NNN` | High-risk administrative operation | 12 | **0** — the set is **closed** by `SECP-BR-004` | — | `013`+ |

**Part 3 declares 41 identifiers.** Running total for `PRD-012a`: **198**.

> ⚠ **Citation is not declaration.** Identifiers from Parts 1–2 (`SECP-XC-003`, `SECP-OWN-001`, `SECP-HRO-004`,
> `SECP-BR-004` and others) appear below as **citations**. A citation is not a declaration. Any count of "identifiers
> in Part 3" that includes out-of-range numbers is counting citations and will over-report.

### 0.4 Prefix collision check

No new prefix is introduced by Part 3, so §5 rule 3 of `PRD_LIFECYCLE.md` is not engaged. The `SECP-` selection and
the **rejection of `SEC-`** (which collides with `INV-SEC-001`…`071`, owner
[`INVITATION_SECURITY_SPECIFICATION.md`](../library/INVITATION_SECURITY_SPECIFICATION.md)) are recorded once, in
Part 1 §0.4, and are not restated here as a second source of truth.

---

## 1. Purpose

Part 3 specifies the security properties that **identity, access and tenant separation** must exhibit, and the
**verification** that must exist for each. It is the *Prevent* stage of the five-stage model Part 1 §2.3 established
(**Prevent → Detect → Contain → Respond → Recover**), and it is the stage most exposed to the platform's two Critical
risks: `MP-RSK-01` (cross-tenant leak) and `MP-RSK-02` (minor safety).

The distinguishing claim of Part 3 is narrow and deliberate:

> The platform's isolation and authorisation rules are already written, at Rank 3, by `PRD-001`, `PRD-013`, `PRD-003`,
> `PRD-017` and `PRD-023`. What is **not** written anywhere is the obligation that those rules be **demonstrated to
> hold**. Part 3 supplies that obligation and nothing else.

This is the same posture Part 2 took toward privileged access, and for the same reason: a second statement of an
existing rule creates a second source of truth, and
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) **L253** is explicit that *"a conflict is
a defect."*

---

## 2. Zero Trust — what is V1, and what is not

### 2.1 The architectural fact

[`LIBOORA_ENTERPRISE_ARCHITECTURE.md`](../../10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md) L2050 records the
`Zero Trust Architecture` subtree as **V3**, with its children tagged: `Service Authentication` **V3**,
`Least Privilege Enforcement` **V2**, `Network Segmentation` **V3**, `Continuous Verification` **Future**.

Part 1 already acted on this: `SECP-PRN-009` (Zero Trust) is recorded as **DIRECTIONAL ONLY**, and Part 1 §4.1
explains why. **Part 3 does not change that.** Declaring Zero Trust a V1 obligation here would be exactly the silent
promotion the governing instruction forbids.

### 2.2 What V1 nonetheless has

Zero Trust is a *posture*, not a single feature, and several of its constituent properties are already V1 because
some **other** V1 capability supplies them. Part 3's V1 obligations are drawn only from this set:

| Zero Trust property | V1 source | EA tag of that source |
|---|---|---|
| **Never trust the client** | `AUTH-8.20` — limits evaluated server-side, *"MUST NOT be influenced by any client-supplied value"* | Application Security **V1** |
| **Verify at every decision, not once** | `ADR-0003`; `TEN-BR-004`; `AUTH-8.37`, `AUTH-8.38` | Tenant Data Isolation **V1** |
| **Deny by default** | `PRD-001` §2.7 *Deny by Default*; `AUTH-2.26` | Application Security **V1** |
| **No decision without a tenant** | `PRD-001` §2.7 *Tenant Isolation*; `AC-2.16`; `TEN-XC-010` | Tenant ID Enforcement **V1** |
| **Encrypted transport and storage** | EA Encryption subtree — Transit **V1**, At Rest **V1** | Encryption **V1** |
| **Secrets held centrally, not inline** | EA Secrets Vault **V1**; `CNF-FR-057`, `CNF-FR-058` | Secrets & Key Mgmt **V1** |

### 2.3 The V1 / V2 / V3 boundary, stated once

| Capability | EA tag | Part 3 treatment |
|---|---|---|
| Tenant ID enforcement, row-level isolation | **V1** | **Normative** — verification obligations in §5 |
| Encryption in transit, encryption at rest | **V1** | **Normative** — §7 |
| Secrets vault, secret **references** | **V1** | **Normative** — §7, bounded by `CNF-XC-009` |
| Application security controls (OWASP, injection, headers) | **V1** | Part 4 |
| **Least Privilege *Enforcement*** (automated) | **V2** | **Not promoted.** The *principle* is V1 via `PRD-001` §2.7 (Rank 3); the automated enforcement tooling is V2. §4.2 and `SECP-GAP-022` state the difference |
| **Service Authentication** (service-to-service) | **V3** | **Directional only** — §8 |
| **Network Segmentation** | **V3** | **Excluded from V1** — `SECP-XC-020` |
| **Continuous Verification** | **Future** | **Excluded from V1** — `SECP-XC-020` |
| **Query Guardrails**, **Cross-Tenant Leak Tests** | **V2** | **Conflict recorded, not resolved** — §5.4, `SECP-GAP-023` |
| Field-level encryption, tokenization | **V2 / V3** | **Excluded from V1** — `SECP-XC-021` |

`SECP-XC-020` — Part 3 **MUST NOT** be read as placing network segmentation, continuous verification, service
authentication or automated least-privilege enforcement in V1 scope. Each is tagged **V2**, **V3** or **Future** by
EA L2050. Where a V1 requirement below resembles one of these, it is grounded in a **V1-tagged** source named in
§2.2, and that grounding is cited at the requirement.

`SECP-XC-021` — Part 3 **MUST NOT** specify field-level encryption, tokenization, cipher suites, key lengths, key
derivation, certificate lifecycle or any cryptographic construction. *Owner: SECURITY platform at V2/V3 for the
capabilities; the constructions themselves are implementation, and `PRD-001` §8's preamble already declines them for
the same reason.*

---

## 3. IAM — the boundary Part 3 must not cross

### 3.1 Who owns what

`BC-18` Identity & Access owns, per BC Map **L125**, *"credentials, sessions, devices, OTP, roles, permissions, policy
decisions, consent."* That is the whole of IAM. The SECURITY platform owns **none** of it.

`SECP-OWN-016` — **Authorisation semantics belong to `BC-18`.** The definition of a role, the contents of a
permission set, the resolution order of a policy, the meaning of a scope and the outcome of a decision are `BC-18`'s.
The SECURITY platform's V1 role is to require that these are *evaluated at the right moments*, *fail closed*, and are
*verified*. It contributes no semantics. *Cites `SECP-XC-006`, `PRD-001` §2.7, BC Map L125.*

`SECP-OWN-017` — **Tenant partitioning belongs to `BC-19` and the DATA platform.** The partitioning mechanism,
row-level security policy, query construction and storage layout are theirs. `CNF-XC-012` and `FIL-XC-006` decline
the same thing for their modules; Part 3 declines it for this one. *Owner: `BC-19` Tenancy (`PRD-013`) for the tenant
concept; DATA platform for the enforcement mechanism (EA L2067).*

`SECP-OWN-018` — **Identity records belong to `BC-10`.** Person identity, profile content, guardianship and the
suspend/reinstate/archive/restore **status** operations are `PRD-003`'s, and `SPO-8` restricts even a Platform
Administrator to *"status only — never profile content (`SID-3.32`)."* Part 3 adds no read path, no field and no
status. *Owner: `BC-10` Global Person Identity (`PRD-003`).*

`SECP-XC-019` — The SECURITY platform **MUST NOT** define, issue, hold, resolve, cache, override or infer an
identity, a role, a permission, a scope, a session, a device trust marker or an authorisation outcome. It **MUST NOT**
provide any path by which one of these is obtained other than from `BC-18`. *Owner: `BC-18`. Cites `SECP-XC-003`
(no authorisation outcome), `SECP-XC-006` (no roles or policy).*

### 3.2 What Part 3 therefore contributes

Three things, and only these:

1. **Placement** — the moments at which a decision must be taken (§4).
2. **Closure** — the behaviour when a decision cannot be taken (§6).
3. **Proof** — the tests that must exist for 1 and 2 (§5.3, §9).

---

## 4. Least privilege and role/permission enforcement

### 4.1 Enforcement placement

`SECP-FR-019` — Every operation that reads or mutates tenant-scoped data **SHALL** be preceded by an authorisation
decision obtained from `BC-18` for **that caller**, **that operation** and **that tenant**. There **SHALL** be no
operation reachable on the strength of an earlier decision, a session's existence, a role's presence or a caller's
identity alone. *Grounded in `AUTH-8.38` (*"a session MUST NOT carry authorization"*) and `ADR-0003`. `FIL-FR-008`
is the same obligation discharged by another module and is the pattern followed here.*

`SECP-FR-020` — An authorisation decision **SHALL NOT** be cached, memoised, persisted, replayed or reused across
operations by the SECURITY platform or by any module acting on its behalf. Where a caller performs several operations,
each **SHALL** carry its own decision. *Cites `SECP-XC-003`; `AUTH-8.37`.*

`SECP-FR-021` — The SECURITY platform **SHALL** require that the set of permissions a caller exercises in a given
operation is the **minimum** the operation needs, and **SHALL** treat the presence of an unexercised permission on the
decision path as a defect to be reported, not a convenience. *Discharges `PRD-001` §2.7 *Least Privilege* as a
verification obligation; adds no permission.*

`SECP-FR-022` — Permission checks **SHALL** be enforced on the server. A check performed only in a client, only in a
user interface, or only by the absence of a navigational route **SHALL NOT** count as enforcement. *Grounded in
`AUTH-8.20`; extended to non-authentication operations by Part 4 §5.*

### 4.2 The Least Privilege scope distinction, stated rather than blurred

EA L2050 tags `Least Privilege Enforcement` **V2**. `PRD-001` §2.7 states Least Privilege as a V1 authorization
principle at Rank 3. These are not in conflict once separated:

| Reading | Version | Status here |
|---|---|---|
| Least privilege as a **rule** decisions must satisfy | **V1** (Rank 3, `PRD-001` §2.7) | `SECP-FR-021` verifies it |
| Least privilege as **automated tooling** that computes and prunes grants | **V2** (EA L2050) | **Not in V1.** `SECP-GAP-022` |

`SECP-GAP-022` — **No V1 mechanism computes or prunes over-broad grants.** `SECP-FR-021` requires the minimum to be
exercised and unexercised permissions on the decision path to be *reported*; it cannot require automated reduction,
because the enforcement tooling that would do so is EA **V2**. V1 therefore detects over-grant by review and test,
not by tooling. **Priority: Medium.** *Not an argument for promoting the V2 node.*

---

## 5. Tenant isolation and cross-tenant access prevention

### 5.1 The rule already exists

`TEN-BR-004` makes isolation **structural and re-asserted at every authorisation decision**. `TEN-XC-010` is sharper
still: *"Supplying tenant context is not deciding access."* `ADR-0003` states the same as *"a continuous obligation,
not a one-time structural guarantee."* `MASTER_PRD.md` **L551** ranks the failure `MP-RSK-01` **Critical**;
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) **L362** calls
`X-13` *"the highest-severity failure class in the system."*

Part 3 restates none of this. It requires that it be **shown**.

### 5.2 Tenant-context validation

`SECP-FR-023` — An operation reaching the SECURITY platform without a resolved tenant context **SHALL** be refused.
It **SHALL NOT** be admitted, defaulted to a tenant, defaulted to a global scope, queued pending resolution, or
inferred from the caller's most recent tenant. *Grounded in `AC-2.16` (*"no authorization decision is reachable
without a tenant in scope"*), `FIL-FR-015`, `MP-GBR-07` (*"fails loudly, never defaults"*).*

`SECP-FR-024` — A tenant context **SHALL** be treated as an input to be validated, never as an assertion to be
trusted. A tenant identifier supplied by a client, embedded in a request, or carried in a token **SHALL** be
validated against the caller's authorised tenants at `BC-18` before any operation proceeds. *Grounded in `TEN-XC-010`;
`AUTH-8.20`.*

`SECP-BR-009` — **Presence of a tenant identifier is not evidence of entitlement to that tenant.** Any control that
treats a supplied tenant identifier as sufficient — for scoping a query, selecting a partition, or filtering a result
— is a defect regardless of whether a leak has been observed. *Restates no rule; classifies a class of
implementation as defective so it can be tested for. Cites `TEN-XC-010`, `SECP-FR-024`.*

### 5.3 Cross-tenant access prevention — the verification obligation

`SECP-FR-025` — For every operation in the SECURITY platform's V1 scope, there **SHALL** exist a test that presents
a caller authorised in tenant A with an identifier belonging to tenant B and asserts refusal. Absence of such a test
**SHALL** be treated as an unmet requirement, not as an untested one. *This is the obligation Part 3 exists to add.*

`SECP-FR-026` — A cross-tenant refusal **SHALL** be indistinguishable, in response body, status, timing class and
error text, from a refusal caused by a non-existent object. It **SHALL NOT** confirm that the object exists elsewhere.
*Grounded in `AC-2.3` (*"responses identical to an account that does not exist"*), `AUTH-8.22`, `FIL-FR-047`
(*"unreachable and unobservable — including through counts"*).*

`SECP-FR-027` — A cross-tenant access attempt **SHALL** emit a security signal for the Detect stage, and **SHALL**
be recorded by `BC-24`. The SECURITY platform **SHALL NOT** hold the record itself. *Grounded in `AUTH-11.27`
(*"alertable immediately, with no threshold"*). The signal register is Part 5; the audit obligation is
`SECP-XC-004`'s boundary and `BC-24`'s to discharge.*

### 5.4 The conflict Part 3 records and does not resolve

`SECP-GAP-023` — **The Rank 1 risk is Critical; the EA capability that would test it is V2.**
`MASTER_PRD.md` L551 ranks cross-tenant leak `MP-RSK-01` **Critical** and `X-13` is the highest-severity failure
class, yet EA L2067's `Tenant Data Isolation` subtree tags **`Cross-Tenant Leak Tests` V2** and **`Query Guardrails`
V2**, while only `Row Level Isolation` and `Tenant ID Enforcement` are **V1**.

`SECP-FR-025` requires per-operation cross-tenant tests **within this module's own V1 scope**, which is grounded in
Rank 1 and Rank 3 obligations and needs no EA node. It **does not** and **must not** be read as promoting EA's
platform-wide `Cross-Tenant Leak Tests` node into V1: that node covers every module, and this document has no
authority over other modules' test suites.

**The consequence is stated plainly:** at V1, cross-tenant isolation is enforced structurally and per-decision, and
tested within each module that chooses to test it, but **no platform-wide leak-test capability exists**, and
`MP-RSK-06` already records boundary decay as *"currently unimplemented."* **Priority: High.** *Required
cross-document change: `SECP-DEP-*` in Part 8 routes this to the Architecture Owner. This document does not edit the
EA, which is Rank 6 and not ours to amend.*

---

## 6. Fail-closed behaviour

### 6.1 The requirement

`SECP-FR-028` — Where an authorisation decision cannot be obtained — because `BC-18` is unavailable, the response is
malformed, the response is ambiguous, the tenant is unresolved, a timeout elapses, or an unexpected error occurs —
the operation **SHALL** be refused. It **SHALL NOT** proceed, degrade to a permissive default, retry silently into a
permissive path, or fall back to a cached outcome. *Grounded in `AUTH-2.26` (*"ambiguity MUST resolve to denial"*),
`MP-GBR-07`, `MP-NFR-12` (*"it is refused rather than guessed"*), `CNF-FR-043` and `FIL-FR-066` as the same choice
made by other modules.*

`SECP-FR-029` — Fail-closed behaviour **SHALL** be verified by test for each dependency whose absence could otherwise
admit an operation. A test **SHALL** exist that removes or faults the dependency and asserts refusal. *Pairs with
`SECP-FR-025`: the closed path is only closed if something has tried to open it.*

`SECP-BR-010` — **A control that has never been observed to refuse is not known to work.** For each control in the
SECURITY platform's V1 scope, a passing negative test — one asserting refusal — is required evidence. An absent
negative test **SHALL** be recorded as a gap against the control, not as a property of the test suite. *Cites
`PRD_LIFECYCLE.md` Stage 4 (*"every requirement testable"*) and Stage 4's exclusion rule (*"every exclusion states
what must be impossible"*).*

### 6.2 What fail-closed does not license

`SECP-XC-022` — Fail-closed behaviour **MUST NOT** be implemented as, or accompanied by, a bypass, override, emergency
mode, degraded-permissive mode, maintenance mode or support path that admits an operation a closed decision refused.
Part 2 §10 already prohibits break-glass (`SECP-XC-011`), and `AUTH-11.53`, `AUTH-11.54` and `AUD-XC-002` prohibit it
at Rank 3. Fail-closed means *refuse*; it never means *refuse unless*. *Owner: this exclusion is the SECURITY
platform's own and is absolute at V1.*

> ⚠ **`AUTH-11.57` bounds the degraded case and is not softened here:** *"Degraded operation MUST preserve tenant
> isolation without exception."* A degraded mode that relaxes isolation is not a degraded mode; it is a leak.

---

## 7. Encryption, secrets and trust material — the V1 slice

### 7.1 What is V1

EA tags `Encryption in Transit` **V1**, `Encryption at Rest` **V1** and `Secrets Vault` **V1**; `Rotation` and
`Key Management` are **V2**, `Certificate Management` **V3**, `Field Level` **V2** and `Tokenization` **V3**.

`SECP-FR-030` — Secret material **SHALL** be held only in the platform's secrets vault and **SHALL** be reachable
only by reference. A secret **SHALL NOT** be held in configuration, in source, in a build artefact, in an environment
variable committed to the repository, in a log, in a telemetry attribute, in an audit payload or in an error message.
*Grounded in EA Secrets Vault **V1**; `CNF-FR-057` (references only), `CNF-FR-058` (configuration holds no resolving
credential), `CNF-FR-059` (no emission), `CNF-XC-009` (*"Owner: SECURITY platform"*). The reciprocal obligation is
`SECP-OWN-*` in Part 1 §9 and is not restated.*

`SECP-BR-011` — **A secret that has been emitted is compromised, and rotation is the only remedy.** Because EA tags
`Secrets Rotation` **V2**, V1 has no rotation capability, and therefore an emitted secret in V1 is a manual
remediation with no automated path. This is a bounded, stated weakness, not a background assumption. *Cites
`SECP-GAP-024`.*

`SECP-GAP-024` — **V1 has no secret rotation capability.** `Secrets Rotation` is EA **V2** and `Key Management` is
EA **V2**. `SECP-FR-030` can require that secrets are never emitted; it cannot require that an emitted secret be
rotated, because the capability does not exist at V1. V1 therefore depends on prevention alone for secret exposure,
with manual remediation as the only response. **Priority: High.** *Not an argument for promoting the V2 nodes; it is
the reason `SECP-FR-030`'s emission prohibitions are absolute rather than best-effort.*

### 7.2 What is not V1

Cipher choice, key length, key derivation, envelope construction, certificate lifecycle, field-level encryption and
tokenization are outside this document entirely — `SECP-XC-021`.

---

## 8. Service-to-service trust and security trust signals

### 8.1 Service-to-service trust — directional only

EA L2050 tags `Service Authentication` **V3**. Further, `tool/module_dependencies.yaml` **L21** sets
`default_decision: deny` for module-to-module dependency, and the V1 topology it describes is a **modular monolith
of ranked modules**, not a set of independently authenticating services. There is therefore no V1 service boundary
across which a service identity would be presented.

Part 3 states the direction and stops:

> **Directional (no V1 obligation).** When the platform introduces a network boundary between independently deployed
> components, each component should present a verifiable service identity and each call should be authorised on that
> identity rather than on network position. This is EA **V3** (`Service Authentication`, `Network Segmentation`) and
> `SECP-PRN-009`'s directional scope. Nothing in V1 depends on it, and no V1 requirement below assumes it.

The V1 substitute is already in force and is not a security requirement of this module: the module dependency
manifest's deny-by-default rule, enforced by `tool/check_module_boundaries.dart`. `SECP-XC-017` (Part 2) already
declines CI/CD ownership, so Part 3 adds no obligation there and Part 7 treats the checker as evidence rather than as
a capability this module owns.

### 8.2 Security trust signals — what V1 may rely on

A *trust signal* is an input that raises or lowers confidence in a caller without itself being an authorisation
decision. V1 possesses a small, closed set, all of which are already owned elsewhere:

| Trust signal | Owner | V1 source |
|---|---|---|
| Device recognised / unrecognised | `BC-18` | `ADR-0002`'s compensating control; `EV-16` notification |
| Session within idle and absolute bounds | `BC-18` | `CFG-5`, `CFG-6`; `AUTH-8.36` |
| Session binding intact (account, device, library) | `BC-18` | `AUTH-8.35`; `ADR-0004` |
| Elevation active and within `CFG-12` | `BC-18` | `AUTH-7.19`, `XC-2.3` |
| Rate-limit or lock state for the identifier | `BC-18` | `AUTH-8.19`, `CFG-4` |

`SECP-BR-011` is not repeated for signals; instead the boundary is drawn as an exclusion in §3.1 (`SECP-XC-019`) and
as this rule of use:

> **Trust signals inform; they never decide.** A signal may cause the SECURITY platform to *require* a decision, to
> *emit* a Detect-stage signal, or to *refuse*. It **MUST NOT** cause the platform to *grant*. Granting is
> `BC-18`'s, and `SECP-XC-003` forbids this module from producing an outcome. `TEN-XC-010`'s formulation —
> *"supplying tenant context is not deciding access"* — generalises exactly.

**No V1 requirement in Part 3 depends on a trust signal that V1 does not have.** In particular, no requirement here
assumes device reputation, IP reputation, geo-location, behavioural baselining or risk scoring — EA tags these
**V2** (`Anomaly Detection`, `Bot & Abuse Detection`, `IP Allow/Deny`) or **V3** (`Geo Restrictions`,
`Account Takeover Detection`), and Part 5 keeps them there.

---

## 9. Acceptance criteria

Every normative requirement declared in Part 3 is bound below. Criteria are stated so that a reader can determine
pass or fail without consulting the author — `PRD_LIFECYCLE.md` Stage 4 rejects *"the system should be fast"* as
unverifiable, and the same test is applied here.

| ID | Criterion | Binds |
|---|---|---|
| `SECP-AC-042` | For a sampled operation in scope, an authorisation decision request to `BC-18` is observed for **each** invocation; two consecutive invocations produce two decisions | `SECP-FR-019` |
| `SECP-AC-043` | No decision outcome is found persisted, cached or memoised in any store, in-memory structure or response owned by this module; a second invocation after a revocation is refused | `SECP-FR-020`, `SECP-XC-019` |
| `SECP-AC-044` | For a sampled operation, the permissions exercised are enumerated and equal the operation's declared minimum; an unexercised permission on the decision path is reported as a defect in the review record | `SECP-FR-021` |
| `SECP-AC-045` | An operation attempted with the client-side check removed or bypassed is refused by the server with the same outcome as the client-side refusal | `SECP-FR-022` |
| `SECP-AC-046` | An operation submitted with no tenant context is refused; the audit and signal records show refusal, and no default, global or last-used tenant appears in any record | `SECP-FR-023` |
| `SECP-AC-047` | An operation submitted with a syntactically valid tenant identifier the caller is not authorised for is refused, and the refusal is attributable to validation against `BC-18` rather than to absence of data | `SECP-FR-024`, `SECP-BR-009` |
| `SECP-AC-048` | For **every** operation in this module's V1 scope, a test exists that presents a tenant-A caller with a tenant-B identifier and asserts refusal; the count of such tests equals the count of in-scope operations | `SECP-FR-025`, `SECP-BR-010` |
| `SECP-AC-049` | Responses to a cross-tenant attempt and to a genuinely non-existent object are compared and are identical in status, body, error text and timing class; neither reveals existence | `SECP-FR-026` |
| `SECP-AC-050` | A cross-tenant attempt produces a signal consumable by the Detect stage and an entry recorded by `BC-24`; no copy of the record is held by this module | `SECP-FR-027` |
| `SECP-AC-051` | With `BC-18` unavailable, faulted, timing out, and returning a malformed response — four separate cases — the operation is refused in all four; no case admits the operation | `SECP-FR-028` |
| `SECP-AC-052` | For each dependency whose absence could admit an operation, a test exists that faults it and asserts refusal; the set of such tests covers the set of such dependencies with no remainder | `SECP-FR-029`, `SECP-BR-010` |
| `SECP-AC-053` | No bypass, override, emergency, degraded-permissive, maintenance or support path admits an operation that a closed decision refused; a search for such a path returns none, and any found is a defect | `SECP-XC-022` |
| `SECP-AC-054` | No secret material is found in configuration, source, build artefacts, logs, telemetry attributes, audit payloads or error messages; a scan of each of these seven surfaces returns zero occurrences | `SECP-FR-030`, `SECP-BR-011` |
| `SECP-AC-055` | No requirement in Part 3 is satisfiable only by a capability EA tags V2, V3 or Future; each V1 requirement cites a V1-tagged source, and the citation is present in the requirement text | `SECP-XC-020`, `SECP-XC-021` |
| `SECP-AC-056` | Part 3 declares no role, permission, scope, session, credential, policy, tenant-partitioning mechanism, identity record or authorisation outcome; a search of Part 3 for such a declaration returns none | `SECP-OWN-016`, `SECP-OWN-017`, `SECP-OWN-018`, `SECP-XC-019` |
| `SECP-AC-057` | No requirement in Part 3 depends on a trust signal absent from §8.2's table; each requirement's inputs are traceable to that table or to an explicit citation | §8.2's rule of use |

### 9.1 Coverage table

| Requirement | Criterion | Requirement | Criterion |
|---|---|---|---|
| `SECP-FR-019` | `AC-042` | `SECP-FR-026` | `AC-049` |
| `SECP-FR-020` | `AC-043` | `SECP-FR-027` | `AC-050` |
| `SECP-FR-021` | `AC-044` | `SECP-FR-028` | `AC-051` |
| `SECP-FR-022` | `AC-045` | `SECP-FR-029` | `AC-052`, `AC-048` |
| `SECP-FR-023` | `AC-046` | `SECP-FR-030` | `AC-054` |
| `SECP-FR-024` | `AC-047` | `SECP-BR-009` | `AC-047` |
| `SECP-FR-025` | `AC-048` | `SECP-BR-010` | `AC-048`, `AC-052` |
| `SECP-BR-011` | `AC-054` | `SECP-XC-019` | `AC-043`, `AC-056` |
| `SECP-XC-020` | `AC-055` | `SECP-XC-021` | `AC-055` |
| `SECP-XC-022` | `AC-053` | `SECP-OWN-016`…`018` | `AC-056` |

**12 `SECP-FR-*`, 3 `SECP-BR-*`, 4 `SECP-XC-*` and 3 `SECP-OWN-*` are declared in Part 3; all 22 are bound above.
Uncovered: none.**

---

## 10. Gaps declared in Part 3

| ID | Gap | Priority | Blocked by |
|---|---|---|---|
| `SECP-GAP-022` | No V1 mechanism computes or prunes over-broad grants; least-privilege enforcement tooling is EA **V2** | Medium | EA L2050 version tag |
| `SECP-GAP-023` | `MP-RSK-01` is Rank 1 **Critical**, yet EA tags platform-wide `Cross-Tenant Leak Tests` and `Query Guardrails` **V2**; V1 has no platform-wide leak-test capability | **High** | EA L2067 version tags; Architecture Owner's to reconcile |
| `SECP-GAP-024` | V1 has no secret rotation or key management capability; an emitted secret has no automated remediation path | **High** | EA `Secrets Rotation` **V2**, `Key Management` **V2** |

None of these three is closed by Part 3, and none is an argument for promoting the capability that would close it.
Each is routed to its owner in Part 8.

---

## 11. Lifecycle status

**Stage 2 (Draft).** The Stage 2 gate — *"document on disk, versioned header, identifier registers declared"* — is
met: this file exists, the header carries a version, §0.3 declares every register with a contiguous range, §0.4
records that no new prefix is introduced, and §0.1 defines the normative language.

**Stage 1's gate remains unmet and is disclosed rather than claimed.** It requires *"a context identified in the
Bounded Context Map, not already owned,"* and the SECURITY platform holds no `BC-nn` — Part 1 §0.5 established this
and `SECP-GAP-010` records it. Authority to proceed is
[`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.1's standing authorisation that
*"`PRD-012a`/`PRD-012b` may be opened without a further ADR."*

**Stage 5 is not started.** `SECP-` is **not** registered in
[`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md); registration is a Stage 5 act and is out
of scope. **Freeze is conferred, not claimed** (`PRD_LIFECYCLE.md` Stage 7); this document claims nothing.

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v0.3 | 2026-08-21 | Part 3 created. 41 identifiers: `SECP-FR-019`…`030`, `SECP-BR-009`…`011`, `SECP-XC-019`…`022`, `SECP-OWN-016`…`018`, `SECP-AC-042`…`057`, `SECP-GAP-022`…`024`. Zero Trust held **directional** per EA L2050 **V3**; the V1 slice in §2.2 drawn only from V1-tagged sources. Least-privilege *principle* (V1, Rank 3) separated from least-privilege *tooling* (EA V2) — `SECP-GAP-022`. The `MP-RSK-01`-Critical / leak-tests-V2 conflict recorded as `SECP-GAP-023` and **not resolved**. Secret rotation absence recorded as `SECP-GAP-024`. Service-to-service trust stated **directional only**; trust signals confined to the closed V1 set in §8.2. No identifier from Parts 1–2 renumbered, reworded or withdrawn. |
