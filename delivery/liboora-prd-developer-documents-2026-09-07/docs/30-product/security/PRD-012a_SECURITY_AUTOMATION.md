# PRD-012a — Security Automation

> **PART 1 of 8 — Security Vision, Scope & Objectives.**
> Parts 2–8 are **not written**. This document is incomplete by design and must not be read as a full
> specification of the SECURITY platform.

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` |
| **Module** | Security Automation |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2**, per [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.1 and [`PRD_OWNERSHIP_MODEL.md`](../../00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md) §4 L180 |
| **Owning bounded context** | **None.** See §0.5 — the SECURITY platform is a *platform*, not a bounded context; it appears in no `BC-nn` row of the Bounded Context Map |
| **Owned aggregate** | **None declared in Part 1.** Part 1 sets vision, scope and objectives only |
| **Module path** | `platform/security` (rank **2**) — measured from [`tool/module_dependencies.yaml`](../../../tool/module_dependencies.yaml) L30 |
| **Declared ports (existing, not created here)** | `platform/security:crypto` · `platform/security:secrets` · `platform/security:pii_redaction` — all three already exist in the manifest and are **cited, not invented** |
| **Product version** | **V1** |
| **Requirement prefix** | **`SECP-`** — ⚠ **not `SEC-`.** See §0.4: `SEC-` collides with the existing `INV-SEC-*` register |
| **Lifecycle stage** | **Stage 2 of 9 — Draft.** Stages 3–9 **not started** |
| **Rank** | **Unranked.** No [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 row exists for this document. It is **not** Rank 3 and must not be cited as authority against any ranked document |
| **Registry status** | **`PLANNED`** in `PRD_REGISTRY.md` §4.1 at the time of writing. See §0.6 — opening this document has a registry consequence that this document does not execute |
| **Lifecycle authority to exist** | `PRD_REGISTRY.md` §4.1: *"`PRD-012a`/`PRD-012b` may be opened without a further ADR."* Traced to Rank 1 — `MASTER_PRD.md` §8 **Correction 2** |
| **Authorities applied** | `MASTER_PRD.md` v1.7 (Rank 1) · `ADR-0002`, `ADR-0003`, `ADR-0004`, `ADR-0011`, `ADR-0014` (Rank 2) · `PRD-001` v2.0 `FROZEN`, `PRD-013` v0.1 `FROZEN`, `PRD-016` v0.1 `FROZEN` (Rank 3) · Bounded Context Map v1.8, Module Dependency Matrix (Rank 4) · `ARCHITECTURE_RULINGS.md` (Rank 5) · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.2 (Rank 6, **descriptive**) |
| **Date** | 2026-08-21 |
| **Written at** | `660a5c0f0b8f515e81141ca000f7f09f0612a9e4` |

---

## 0. How to read this document

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default requiring a recorded
reason to depart from. **MAY** is genuinely optional.

A **directional principle** is *not* normative. It states the direction the platform is committed to travelling and
carries no V1 obligation. Part 1 uses this category deliberately and marks every instance, because several
principles requested for this document are placed at **V2 or V3** by the Enterprise Architecture (§4.1).

### 0.2 What Part 1 does, and does not, do

| Part 1 does | Part 1 does **not** |
|---|---|
| Set the security vision and the V1 objective model | Specify controls, mechanisms or configuration |
| Declare V1 scope and out-of-scope boundaries | Declare database tables, APIs, SQL or code |
| Assign each security concern to an owning platform | Re-assign anything the Enterprise Architecture already assigns |
| Publish measurable success criteria | Claim any criterion is met |
| Record conflicts and gaps | Resolve a conflict with a ranked document |

### 0.3 Identifier registers — the ranges as a promise

Per the Stage 2 gate, registers are declared **up front** with ranges, and ranges are **contiguous**. A hole makes
the published range false.

**Class A — normative requirements and exclusions.**

| Register | Meaning | Declared in Part 1 | Range | Reserved for Parts 2–8 |
|---|---|---|---|---|
| `SECP-OBJ-NNN` | Security objective — normative outcome | **12** | `001`…`012` | `013`+ |
| `SECP-PRN-NNN` | Core security principle | **12** | `001`…`012` | `013`+ |
| `SECP-XC-NNN` | Exclusion — states what MUST be impossible or is out of this module's ownership | **10** | `001`…`010` | `011`+ |
| `SECP-OWN-NNN` | Ownership boundary assertion | **11** | `001`…`011` | `012`+ |
| `SECP-AC-NNN` | Acceptance criterion | **14** | `001`…`014` | `015`+ |
| `SECP-GAP-NNN` | Open gap, conflict or dependency | **13** | `001`…`013` | `014`+ |

**Registers declared and DELIBERATELY EMPTY in Part 1**, because Part 1 specifies no mechanism and no data:

| Register | Why empty |
|---|---|
| `SECP-FR-NNN` | Functional requirements belong to Parts 2–8. Part 1 states objectives, not functions |
| `SECP-BR-NNN` | Business rules require the mechanisms Parts 2–8 define |
| `SECP-INV-NNN` | An invariant needs an owned aggregate. Part 1 declares none (§0.5) |
| `SECP-EVT-NNN` | An event needs a Bounded Context Map §9 producer row. The SECURITY platform holds **no `BC-nn` identity**, so minting an event name here would assert an edge BC Map **L292** says does not exist |
| `SECP-CFG-NNN` | A configurable needs a default and a bound. No Rank 1–5 authority supplies either for this module yet — carried as `SECP-GAP-011` |

Empty is a finding, not an omission. `PRD-016` set this precedent: two registers were admitted empty rather than
populated with invented content.

**Total Part 1 normative identifiers: 72** (`OBJ` 12 · `PRN` 12 · `XC` 10 · `OWN` 11 · `AC` 14 · `GAP` 13).

### 0.4 ⚠ Prefix selection — `SEC-` was REJECTED on measurement

`PRD_LIFECYCLE.md` §5 rule 2 requires a prefix *"checked against every existing register before use"* and rule 3
requires that on collision *"change the new prefix, never the existing one."* The check was run, not assumed:

| Candidate | Measurement | Verdict |
|---|---|---|
| **`SEC-`** | `grep -rhoE '[A-Za-z-]*SEC-[0-9]{3}' docs/` returns **155 hits, all `INV-SEC-NNN`** — the Invitation Security Specification's register, `INV-SEC-001`…`071`, owned by **Library** and published in `TRACEABILITY_MATRIX.md` §2A L62 | ⛔ **REJECTED — collision** |
| **`SECP-`** | `grep -rhoE '\bSECP-' docs/ lib/ test/ tool/ packages/` returns **0** | ✅ **SELECTED** |
| `SPF-`, `SCP-`, `SEP-`, `PSEC-`, `SECU-` | 0 each — also free | Not needed |

⚠ **A disclosed near-miss.** A narrower probe, `grep -rhoE '\bSEC-[A-Z]{2,4}-[0-9]+'`, returns **zero** and would
have licensed `SEC-`. It returns zero only because the existing register is numbered `SEC-001`, not `SEC-XX-001` —
the pattern that matches the *new* convention cannot see a register written in the *old* one. `TRACEABILITY_MATRIX.md`
§2A.1 warns about exactly this family, noting that `INV-4` and `INV-SEC-004` are unrelated despite the shared token,
and `PRD-017` §0.4 records the same hazard for `INV-`. **The prefix chosen by the narrow probe would have collided.**
`SECP-` is chosen on the broad measurement.

### 0.5 ⚠ This module owns no bounded context, and that is not a defect

Every frozen PRD to date names an owning `BC-nn`. This one cannot, and the reason is structural rather than an
omission:

- The Bounded Context Map defines **31** contexts, `BC-01`…`BC-31`. **None is a security context.** `BC-28` is
  Workflow Orchestration; security appears in no `BC-nn` row.
- `MASTER_PRD.md` §8 module 16 assigns the *"Security"* half of *Security & Automation* to the **`SECURITY` platform**,
  not to a context. `PRD_REGISTRY.md` §4.1 reserves `PRD-012a` to *"SECURITY platform (rank 2)"* on the same basis.
- `ADR-0013` established that *a capability context is owned by its platform, and context ownership is distinct from
  aggregate ownership*. The SECURITY platform is the inverse case: a platform with enforcement duties and, so far,
  no context and no aggregate of its own.

The consequence is deliberate and constraining: **this module is an enforcer and a provider of ports, not a holder of
domain state.** It supplies `crypto`, `secrets` and `pii_redaction` to higher-rank modules and enforces properties
*about* other modules' data without owning that data. Every register that requires an aggregate is therefore empty
(§0.3), and whether the SECURITY platform should hold an aggregate at all is carried as **`SECP-GAP-010`** rather than
decided here.

### 0.6 ⚠ Two consequences of opening this document that it does NOT execute

1. **`PRD-012` retirement.** `PRD_REGISTRY.md` §4.1: *"`PRD-012` itself is retired on the day `PRD-012a` is opened;
   its number is **not** reused (§8 rule 1)."* Opening this document triggers that condition. It also clears the
   register's §7 finding of *"PRDs unassignable under the one-holder-per-role rule | **1** — `PRD-012`"*, since the
   confirmation text ties that finding to the split being **executed, not confirmed**.
2. **Register and ownership-model counts move.** `PRD-012a` ceases to be a reservation and becomes a document.

**Neither edit is made by this document.** The register is unranked, so no ADR is needed — but the register is not
this document's to amend as a side effect of its own creation, and a document that updated the register to record its
own existence would be conferring status on itself, which §0 of every frozen PRD here forbids. Both are carried as
**`SECP-GAP-012`** and **`SECP-GAP-013`**, routed to the **Governance Owner**.

### 0.7 ⚠ "Security & Automation" is one name and two owners

`MASTER_PRD.md` §8 **Correction 2** (Rank 1), verbatim:

> *"**Correction 2 — `Security & Automation` is two owners.** 'Security' is the SECURITY platform (R2).
> 'Automation' is Workflow Orchestration (`BC-28`, V2). A single module name spanning two owners at two ranks
> violates the Single Owner Rule (EA §10.1.1). The name is preserved; the ownership split is now explicit."*

**This document is the "Security" half only.** The word *Automation* in its registered title
(*"Security Automation"*) means **the automation of security enforcement** — controls that execute without human
initiation, such as an automatic session revocation or an automatic secret-reference resolution failure. It does
**not** mean workflow orchestration, saga execution, scheduling, compensation or dead-letter handling, all of which
are owned by **`BC-28` Workflow Orchestration** at **V2** and specified by **`PRD-012b`**. `SECP-XC-002` and
`SECP-OWN-010` make that boundary normative.

---

## 1. Purpose

### 1.1 Why this document exists

Liboora is a multi-tenant SaaS platform serving libraries and study halls whose users are substantially minors. Three
properties of the product make security a first-order specification concern rather than an implementation detail:

1. **One account spans many tenants.** `PRD-001` §8.1 states it directly: *"a single account is global and may hold
   roles in several libraries at once; compromising one account can therefore expose several tenants."* The blast
   radius of a single compromise is not bounded by one library.
2. **The platform holds minors' data.** `MP-RSK-02` classifies minor-safety failure as **Critical**, and `BC-13`
   Trust & Safety is classified `[CORE]` *"despite living in a Supporting platform — on a minor-heavy product this is
   existential legal risk, not a commodity."*
3. **Cross-tenant leakage is the top-severity failure class.** `MP-RSK-01` (Critical) and Dependency Matrix `X-13`
   both say so, `X-13` in the strongest terms available: *"cross-tenant data leak — highest-severity failure class in
   the system."*

Before this document, the SECURITY platform had duties and no specification. The Enterprise Architecture records the
condition it was in at **L88**: `[RECONSTRUCTED]`, *"Absent as an owner — security was scattered."* The EA reconstructed
the **ownership map**; it is Rank 6 and **descriptive** — it *"must follow the PRDs, never lead them."* A descriptive
document cannot supply requirements. That is this PRD's job.

### 1.2 What this Part establishes

`SECP-OBJ-*` the outcomes V1 must achieve · `SECP-PRN-*` the principles that constrain how · `SECP-XC-*` what is
excluded and what must be impossible · `SECP-OWN-*` who owns each security concern · `SECP-AC-*` how success is
measured · `SECP-GAP-*` what is unresolved.

### 1.3 Audience

Product Owner (objectives and scope) · Architecture Review Board (ownership boundaries and conflicts) · Platform
Engineering (what Parts 2–8 must specify) · Security QA (what must be testable).

---

## 2. Security Vision

### 2.1 The vision statement

> **Liboora's security objective is that no single compromise becomes a platform compromise.**
>
> A stolen device, a hijacked browser session, a forged API request, a phished OTP or a fully controlled ordinary
> user account must each yield **only** what that one identity was already entitled to, in the one tenant it was
> entitled to it in — and must leave evidence.

### 2.2 What this vision explicitly does NOT claim

**The platform is not, and will not be described as, "hack-proof", "unhackable" or "100% secure."** Such a claim is
unfalsifiable, and an unfalsifiable claim cannot be a requirement — `PRD_LIFECYCLE.md` Stage 4 rejects
*"The system should be fast"* for precisely this reason, and *"the system cannot be hacked"* fails the same test more
severely.

The claim is also operationally harmful. `ADR-0002` demonstrates the alternative discipline: having chosen mobile OTP
as the sole V1 factor, it **names the attack that defeats it** — SIM-swap — and specifies a compensating control
(`EV-16`, unrecognised-device notification), recording that this *"is why device management is V1 and not V2."* A
document that claimed OTP was unbreakable could not have produced that control, because it would have had no reason
to look for one.

### 2.3 The V1 objective model — Prevent → Detect → Contain → Respond → Recover

| Stage | Objective | V1 posture | Anchored by |
|---|---|---|---|
| **Prevent** | Make unauthorised access fail by construction, server-side | **V1 — substantial** | Application Security (V1), Encryption (V1), Secrets (V1), Tenant Isolation (V1), `BC-18` authorisation |
| **Detect** | Notice that something abnormal has happened | **V1 — narrow and honestly bounded.** Brute Force Protection is V1; general anomaly detection is **V2** | EA Threat Detection tree; `SECP-GAP-004` |
| **Contain** | Limit what a successful compromise reaches | **V1 — this is where V1 invests most** | Tenant isolation, least privilege, session revocation, role separation, elevation expiry |
| **Respond** | Act on a detected compromise with evidence | **V1 — partial.** The audit record is V1; formal Incident Response playbooks are **V2** | `PRD-016` (V1); `SECP-GAP-007` |
| **Recover** | Restore correct state and remove the attacker's access | **V1 — partial.** Backup Strategy is V1 and Disaster Recovery is **V3** | EA Infrastructure tree; `SECP-GAP-008` |

⚠ **The honest shape of V1 is a strong Prevent and Contain, a narrow Detect, and a partial Respond and Recover.** The
gaps are named in §11, not smoothed over. A five-stage model presented as uniformly complete at V1 would be a
misrepresentation of the architecture this document is required to follow.

### 2.4 The load-bearing asymmetry

Prevention scales with engineering effort and eventually saturates; containment is a **structural property** and is
cheap to specify early and expensive to retrofit. A startup-realistic V1 therefore invests in **Contain** ahead of
**Detect**, which is why `SECP-OBJ-003`, `004` and `005` are the strictest objectives in this document while the
detection objective `SECP-OBJ-007` is deliberately narrow.

---

## 3. V1 Security Objectives

Each objective is normative, testable and assigned to an owning platform. **"Owner" is the platform accountable for
the outcome**, which is not always the SECURITY platform — the Single Owner Rule is respected, not worked around.

| ID | Objective | Owner | Measured by |
|---|---|---|---|
| **`SECP-OBJ-001`** | Every security-relevant decision **MUST** be reached and enforced **server-side**. A client-supplied assertion of identity, role, tenant or entitlement **MUST NOT** be trusted as evidence of that fact | SECURITY (enforcement) + `BC-18` (decision) | `SECP-AC-001` |
| **`SECP-OBJ-002`** | Compromise of a client, browser, session, device, API request or ordinary user account **MUST NOT** by itself yield privileged access or access to any tenant the compromised identity did not already hold a role in | SECURITY | `SECP-AC-002`, `SECP-AC-003` |
| **`SECP-OBJ-003`** | Cross-tenant access **MUST** fail by construction. Absence of tenant context **MUST** cause failure, never a default | **DATA PLATFORM** (isolation) + **Tenancy** (context) + SECURITY (verification) | `SECP-AC-003` |
| **`SECP-OBJ-004`** | Every identity **MUST** operate at the least privilege sufficient for its function. Privilege **MUST NOT** be acquired by self-assertion, and standing privileged access to tenant business data **MUST NOT** exist | `BC-18` (model) + SECURITY (verification) | `SECP-AC-004`, `SECP-AC-005` |
| **`SECP-OBJ-005`** | Access **MUST** be denied by default. An operation for which no explicit grant exists **MUST** be refused, not permitted pending review | `BC-18` + SECURITY | `SECP-AC-006` |
| **`SECP-OBJ-006`** | Credentials, secrets and key material **MUST NOT** be stored, logged, cached or transmitted outside the components authorised to hold them | SECURITY (vault) + `BC-18` (credentials) | `SECP-AC-007`, `SECP-AC-008` |
| **`SECP-OBJ-007`** | Automated credential-guessing against the sole V1 authentication factor **MUST** be detected and throttled | SECURITY (Brute Force Protection, V1) | `SECP-AC-009` |
| **`SECP-OBJ-008`** | Every privileged action and every access to tenant data by a platform-side actor **MUST** produce an audit record that the actor cannot alter or remove | **Audit Platform (`BC-24`)** — SECURITY is a **consumer**, not the owner | `SECP-AC-010` |
| **`SECP-OBJ-009`** | Data **MUST** be encrypted in transit and at rest | SECURITY (Encryption, V1) | `SECP-AC-011` |
| **`SECP-OBJ-010`** | Common application-layer attack classes (OWASP Top 10 as scoped by EA Application Security V1) **MUST** be defended at the server boundary, including input sanitisation, CSRF, XSS, injection and secure response headers | SECURITY (Application Security, V1) | `SECP-AC-012` |
| **`SECP-OBJ-011`** | A security control **MUST** fail closed. Where a control cannot render a correct decision, the operation **MUST** be refused rather than permitted | SECURITY | `SECP-AC-013` |
| **`SECP-OBJ-012`** | Personally identifying data **MUST NOT** leak into planes not cleared to hold it, including logs, metrics, traces, search indices, analytics projections and model prompts | SECURITY (`pii_redaction` port) + each emitting platform | `SECP-AC-014` |

**Anchoring notes.** `SECP-OBJ-003` restates no requirement: `TEN-BR-004` already establishes that *"tenant isolation
is structural, and is additionally re-asserted at every authorisation decision"*, and `ADR-0003` requires it *"at
every authorization decision rather than at a data partition … a continuous obligation, not a one-time structural
guarantee."* This objective **cites** that rule and makes verification a SECURITY duty. `SECP-OBJ-011` follows
`MP-GBR-07` (*"fails loudly, never defaults"*) and `MP-NFR-12` (*"Where a decision cannot be rendered correctly, it
is refused rather than guessed"*). `SECP-OBJ-008` is deliberately worded as a **consumer** obligation because
`AUD-XC-002` gives `BC-24` exclusive ownership of immutability: *"No role, including Platform Administrator, MUST be
able to alter or remove an entry."*

---

## 4. Core Security Principles

`SECP-PRN-*` are **binding where marked normative** and **directional where marked directional**. The distinction is
not editorial softening — it is the Enterprise Architecture's version tags, applied honestly.

| ID | Principle | V1 status | Basis |
|---|---|---|---|
| **`SECP-PRN-001`** | **Server-side Security Enforcement** — security is decided and enforced on the server; the client is never the enforcement point | **Normative V1** | `SECP-OBJ-001`; EA Application Security V1 |
| **`SECP-PRN-002`** | **Multi-Tenant Isolation** — tenant separation is structural and re-asserted at every authorisation decision | **Normative V1** | EA `Tenant Data Isolation (V1)`; `TEN-BR-004`; `X-13`; `MP-GBR-06`…`MP-GBR-09` |
| **`SECP-PRN-003`** | **Deny by Default** — anything not explicitly granted is refused | **Normative V1** | `tool/module_dependencies.yaml` L21 `default_decision: deny`; `SECP-OBJ-005` |
| **`SECP-PRN-004`** | **Least Privilege** — every identity holds the minimum authority for its function | **Normative V1 for the identity model; V2 for platform-wide enforcement tooling** | `PRD-001` role separation, `XC-2.5`, `XC-2.14`; ⚠ EA places `Least Privilege Enforcement` at **V2** — `SECP-GAP-002` |
| **`SECP-PRN-005`** | **Privileged Access Protection** — platform-side privilege is separated, non-standing, time-bounded and attributed | **Normative V1** | `PRD-001` `PR-1`/`PR-2`, `AUTH-2.6`, `XC-2.5`, `AC-2.10`, `CFG-12` |
| **`SECP-PRN-006`** | **Secure Defaults** — the safe configuration is the delivered configuration; a deployment is not made safe by an administrator remembering to harden it | **Normative V1** | `BC-10` invariant *"privacy default = most restrictive"*; `PRD-001` §3.4 |
| **`SECP-PRN-007`** | **Defence in Depth** — no single control is the only thing standing between an attacker and tenant data | **Normative V1 as a design constraint on Parts 2–8** | `ADR-0003` (structural **and** per-decision); `ADR-0002` (OTP **and** device notification) |
| **`SECP-PRN-008`** | **Auditability** — privileged and security-relevant action is attributable and the record is immutable | **Normative V1** | `PRD-016` `AUD-BR-002`, `AUD-XC-002`; `AUTH-10.20` |
| **`SECP-PRN-009`** | **Zero Trust** — no implicit trust from network position, prior authentication or service identity | ⚠ **DIRECTIONAL ONLY.** EA places `Zero Trust Architecture` at **V3** (Service Auth V3, Network Segmentation V3, Continuous Verification Future) | `SECP-GAP-001` |
| **`SECP-PRN-010`** | **Security Monitoring** — abnormal activity is observed and alerted on | ⚠ **DIRECTIONAL, with one V1 exception:** Brute Force Protection is **V1**. EA places Threat Detection at **V2** and SIEM at **V3** | `SECP-GAP-004` |
| **`SECP-PRN-011`** | **Incident Readiness** — a security incident is handled by a rehearsed process, not improvisation | ⚠ **DIRECTIONAL.** EA places Security Incident Response at **V2**, Runbooks **V2**, Forensics/Breach Notification **V3** | `SECP-GAP-007` |
| **`SECP-PRN-012`** | **Resilience and Recovery** — correct state is restorable and an attacker's access is removable | ⚠ **PARTIAL V1.** EA places Backup Strategy at **V1** but Disaster Recovery at **V3** and RTO/RPO at **V2** | `SECP-GAP-008` |

### 4.1 ⚠ Why four principles are directional and not normative

Four of the twelve principles requested for this document — Zero Trust, Security Monitoring, Incident Readiness,
Resilience and Recovery — are placed by `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1989–2063** at **V2 or V3**, not V1.
`SECP-PRN-009` is the sharpest case: **Zero Trust is a V3 capability** in the EA's own tree.

Writing them as V1 requirements was available and would have read better. It was rejected for three reasons:

1. **It would silently promote V2/V3 capabilities into V1** — a redesign of the Enterprise Architecture performed by a
   Stage 2 draft, by a module that holds no rank.
2. **The EA is Rank 6 and descriptive.** It *"must follow the PRDs, never lead them"* — so a PRD **may** legitimately
   lead it. But leading it is an act with a procedure: `DOCUMENTATION_BASELINE.md` §7 and the post-freeze table
   require an **ADR before** a ranked change, and `LIB-26.2` requires an ADR for an ownership or boundary change.
   Asserting V1 in this table performs that change without the procedure.
3. **`DOCUMENTATION_BASELINE.md` L253:** *"A conflict is a defect. If you find one, do not choose — raise it."*

They are therefore recorded as **directional principles plus named gaps** (`SECP-GAP-001`, `004`, `007`, `008`). If
the Product Owner intends Zero Trust in V1, that is a legitimate decision — and it is an **ADR**, not a table cell.

---

## 5. V1 Scope

V1 scope is derived from the EA capability tree, taking **only** capabilities the EA tags **V1**. Ownership is the
EA's; the version tags are quoted, not chosen.

| # | V1 capability | EA tag | This module's V1 duty |
|---|---|---|---|
| 1 | **Secrets & Key Management** — Secret Vault | V1 | Own the vault and the `platform/security:secrets` port. Secret **references** remain `BC-25` Configuration's |
| 2 | **Encryption in Transit** | V1 | Own the requirement and the `crypto` port |
| 3 | **Encryption at Rest** | V1 | Own the requirement |
| 4 | **Application Security** — input sanitisation, OWASP Top 10, CSRF/XSS/injection defence, secure headers | V1 | Own all four |
| 5 | **Brute Force Protection** | V1 | Own it. The **only** V1 member of the Threat Detection branch |
| 6 | **PII redaction port** | V1 (`PII-Safe Logging` V1) | Own `platform/security:pii_redaction`; each emitter must use it |
| 7 | **Tenant isolation verification** | V1 | **Verify**, not own. Isolation is DATA PLATFORM's; enforcement at authorisation is `BC-18`'s |
| 8 | **Secrets in Pipeline** | V1 | Vault ownership only — the pipeline is DEVOPS PLATFORM's |

**Explicitly V1 in this document, and not from the EA tree:** the objective model of §2.3 and the ownership boundaries
of §9. Neither is a capability; both are specification.

### 5.1 Scope boundary — what "Security Automation" automates in V1

Automation in scope: a control that executes **without human initiation** as part of enforcing a security property —
throttling on repeated failure, refusal on absent tenant context, redaction before egress, expiry of an elevation.

Automation **not** in scope: process orchestration, sagas, scheduled jobs, compensation, retry topologies and DLQ
handling. Those are `BC-28` Workflow Orchestration, **V2**, `PRD-012b`. `SECP-XC-002`.

---

## 6. Out-of-Scope Boundaries

An exclusion here states either *what must be impossible* or *what this module does not own*. It is **not** a
deferral of an obligation the platform holds elsewhere.

| ID | Exclusion | Type | Authority |
|---|---|---|---|
| **`SECP-XC-001`** | This module **MUST NOT** store, cache, mint, validate or hold a credential, OTP, session or password. Not for convenience, not for verification, not for testing | Must be impossible | `ADR-0011` `ID-1`; `MP-GBR-27` |
| **`SECP-XC-002`** | This module **MUST NOT** own or specify workflow orchestration, sagas, scheduling, compensation or DLQ handling | Not owned — `BC-28`, V2 | `MASTER_PRD.md` §8 Correction 2 |
| **`SECP-XC-003`** | This module **MUST NOT** produce, cache, alter or short-circuit an **authorisation outcome**. Verifying that isolation held is not deciding access | Must be impossible | `X-13`; `TEN-XC-010` (same prohibition, same reason) |
| **`SECP-XC-004`** | This module **MUST NOT** alter, delete or suppress an audit entry, nor hold any privileged path that could | Must be impossible | `AUD-XC-002`; `AUTH-10.20` |
| **`SECP-XC-005`** | This module **MUST NOT** introduce, enable, hide or partially implement any authentication method beyond the sole V1 factor — including social or federated sign-in — in any form reachable by configuration, feature flag, environment or administrative action | Must be impossible | `MP-CON-11`; `MP-GBR-25`; `ADR-0002`; `PRD-001` `AUTH-3.13`, `AUTH-3.30` |
| **`SECP-XC-006`** | This module **MUST NOT** define an authentication or authorisation model, role, permission or policy. It consumes `BC-18`'s | Not owned — `BC-18` | BC Map L127 |
| **`SECP-XC-007`** | This module **MUST NOT** own tenant data partitioning, row-level isolation or query guardrails | Not owned — DATA PLATFORM | EA L2067–2085 |
| **`SECP-XC-008`** | This module **MUST NOT** own logging, metrics, tracing, alerting or crash reporting infrastructure. It sets the PII constraint on their content; it does not own the planes | Not owned — OBSERVABILITY | EA L1897+; `MP-NFR-09` |
| **`SECP-XC-009`** | This module **MUST NOT** own CI/CD, artefact management, release engineering or infrastructure provisioning | Not owned — DEVOPS / INFRASTRUCTURE | EA L2159, L2273 |
| **`SECP-XC-010`** | Part 1 **MUST NOT** be cited as specifying any control, mechanism, schema, interface or configuration. It specifies objectives, principles, scope, ownership and criteria only | Scope of this Part | §0.2 |

⚠ **`SECP-XC-005` is stated because this module is exactly where such a change would be attempted.** A security
platform is the plausible home for "additional authentication factors", and the prohibition is Rank 1
(`MP-CON-11`, `MP-GBR-25`) and unamended. This exclusion binds this module to it explicitly so that no later Part can
introduce a factor as a security enhancement.

---

## 7. Platform Admin Security Objective

Platform-side privilege is the highest-value target in the system: a Platform Administrator sits outside every
tenant boundary. `PRD-001` already specifies the model — `PR-1` Platform Administrator and `PR-2` Platform Support,
a **closed** set of two — and this section states the security outcome that model must deliver, without redefining it.

| ID | Objective | Owner |
|---|---|---|
| **`SECP-OBJ-004`** *(applied here)* | No standing privileged access to tenant business data exists. Access requires an elevation stating tenant and purpose, approved by a **distinct** administrator, expiring automatically, with every action attributed | `BC-18` (model) + SECURITY (verification) |

**Anchored to, and not restating, `PRD-001`:**

- `AUTH-2.6` — platform role assignment is performed exclusively by a Platform Administrator **other than** the subject
- `XC-2.5` — Platform Support tenant access requires an elevation request stating tenant and purpose, approved by a
  distinct Platform Administrator, expiring at `CFG-12`, all actions attributed, **"No standing access is created"**
- `XC-2.14` — a Platform Administrator attempting to self-assign a tenant role is **refused**
- `AC-2.10` — a Platform Administrator receives **no** tenant business data without an active, approved elevation
- Role Separation — *"A Platform Administrator is not an Owner of any library. An Owner has no platform authority.
  Neither can become the other by assertion"*
- `AUTH-10.20` / `AUD-BR-002` / `AUD-XC-002` — audit immutability holds **for every role, including Platform
  Administrator**; no break-glass route exists

**What this module adds:** the obligation that these properties are **verified, not assumed** — `SECP-AC-005` and
`SECP-AC-010` require a test proving that the privileged path fails, which `AUD-AC-003` already models for the audit
case.

⚠ **Gap, not closed here.** `AUD-GAP-004` records that BC Map L133 gives `BC-24` the record *"including support
access"* while **no Rank 1–5 document defines a support-access action list**, and the EA's `Support Access Log` is
**V3**. `SECP-OBJ-008` is therefore satisfiable for privileged *actions* and **not yet** for support *access*. Carried
as `SECP-GAP-005`; not resolved, because publishing the action list belongs to the emitter, per `AUD-FR-003`.

---

## 8. Threat Protection Objective

### 8.1 The stated objective

> **Compromising one thing must not compromise the platform.** Specifically: compromise of a client, browser,
> session, API request, device or ordinary user account **MUST NOT** by itself grant privileged access or access to
> any tenant that identity did not already hold a role in. — `SECP-OBJ-002`

### 8.2 Named threats and the V1 posture, honestly stated

Each row names the containment that holds and the stage of §2.3 that is weak. **Naming the weakness is the point** —
`ADR-0002` set this precedent by naming SIM-swap as the defeat of its own chosen factor.

| Threat | V1 containment | Honest V1 weakness |
|---|---|---|
| **Stolen or hijacked session** | Session bound to exactly one library (`ADR-0004`); revocation immediate and global (`BC-18` invariant); tenant re-asserted per decision (`ADR-0003`) | Detection of an anomalous-but-valid session is **V2** (`SECP-GAP-004`) |
| **Compromised ordinary user account** | Role separation; no self-assignment; least privilege; deny by default | The account's own legitimate access is fully exposed. Contained, not prevented |
| **Phished or intercepted OTP / SIM-swap** | `ADR-0002`'s compensating control — unrecognised-device notification `EV-16`, *"which is why device management is V1 and not V2"* | The sole V1 factor's channel is a single point of failure. `MP-ASM-01` records that its failure makes a fallback factor a V1 need. **Not closable by this module** — `MP-CON-11` is Rank 1 |
| **Automated credential guessing** | Brute Force Protection (**V1**) — `SECP-OBJ-007` | Distributed / low-and-slow attempts need anomaly detection (**V2**) |
| **Cross-tenant access attempt** | Structural isolation (V1) + per-decision re-assertion + `X-13` tenant-key lint + Multi-Tenant Test Suite | Cross-Tenant Leak Tests are EA **V2**; `D-016-01` records a live `X-13` exposure in existing code (`SECP-GAP-006`) |
| **Client-side tampering / forged API request** | Server-side enforcement (`SECP-PRN-001`); client assertions untrusted (`SECP-OBJ-001`) | WAF and DDoS protection are EA **V2** (`SECP-GAP-003`) |
| **Injection / XSS / CSRF** | Application Security V1 | SAST **V2**, DAST **V3**, dependency scanning **V2** (`SECP-GAP-009`) |
| **Privileged insider or compromised admin** | Two-person control on role assignment; elevation with purpose, expiry and attribution; audit immutable **for every role** | Forensics **V3**; support-access action list undefined (`SECP-GAP-005`) |
| **Supply-chain compromise** | CI static analysis and test execution are EA **V1** | Dependency Vulnerability Scanning **V2**, Patch Management **V2**. ⚠ **A DevSecOps expert flags this as genuinely necessary for production** — `SECP-GAP-009`, **priority High** |

### 8.3 ⚠ Two threats V1 does not contain, stated plainly

1. **A compromise of the OTP delivery channel compromises the account.** Structural to `MP-CON-11`. Not this module's
   to change.
2. **A valid-looking attacker inside a legitimate session is not detected in V1.** Anomaly and ATO detection are
   **V2/V3**. V1 contains the blast radius; it does not notice the intruder.

Recording these is a requirement of §2.2. A threat table that showed containment everywhere would be describing a
different system.

---

## 9. Security Ownership Boundaries

Derived from the EA capability trees, the Bounded Context Map, the frozen PRDs and
`tool/module_dependencies.yaml` — **not asserted**. The Single Owner Rule (EA §10.1.1) holds: each row has exactly
one owner.

| ID | Concern | **Owner** | This module's role |
|---|---|---|---|
| **`SECP-OWN-001`** | Secrets & key vault, encryption, application security, threat detection, WAF/DDoS, vulnerability management, penetration testing, privacy & compliance, security incident response, security posture | **SECURITY PLATFORM** | **Owner.** Version tags per EA; only the V1 subset in §5 is V1 |
| **`SECP-OWN-002`** | Credentials, OTP, sessions, devices, roles, permissions, **policy decisions**, consent | **`BC-18` Identity & Access** | Consumer via `platform/identity:policy_decision`. `SECP-XC-001`, `SECP-XC-006` |
| **`SECP-OWN-003`** | Tenant record, tenant context propagation, residency, lifecycle | **`BC-19` Tenancy** | Consumer via `platform/tenancy:tenant_context`. `TEN-XC-010` binds Tenancy symmetrically |
| **`SECP-OWN-004`** | Tenant data isolation, row-level isolation, tenant-ID enforcement, query guardrails | **DATA PLATFORM** | **Verifier, not owner.** `SECP-XC-007` |
| **`SECP-OWN-005`** | The immutable audit record, and its immutability against **every** role | **`BC-24` Audit Trail** | **Emitter and consumer only.** `SECP-XC-004` |
| **`SECP-OWN-006`** | Upload, virus scan, thumbnailing, signed URLs, storage abstraction | **`BC-29` File & Media** | Consumer. Security properties of file handling are specified there |
| **`SECP-OWN-007`** | Logging, metrics, tracing, alerting, crash reporting, SLOs, incident dashboards | **OBSERVABILITY PLATFORM** | Sets the **PII constraint on content** (`SECP-OBJ-012`); owns none of the planes. `SECP-XC-008` |
| **`SECP-OWN-008`** | Cloud foundation, compute, networking, CDN/edge, backup, DR, `Infrastructure Security Baseline` | **INFRASTRUCTURE** | Owns the **policy** the baseline implements — the EA marks it *"[policy owned by SECURITY PLATFORM]"*. `SECP-XC-009` |
| **`SECP-OWN-009`** | CI/CD, release engineering, `Secrets in Pipeline` | **DEVOPS PLATFORM** | Owns the **vault** the pipeline reads — the EA marks it *"[vault owned by SECURITY PLATFORM]"*. `SECP-XC-009` |
| **`SECP-OWN-010`** | Long-running processes, sagas, scheduling, compensation, DLQ | **`BC-28` Workflow Orchestration**, V2, `PRD-012b` | **None.** `SECP-XC-002` |
| **`SECP-OWN-011`** | Settings hierarchy, feature flags, **secret *references*** | **`BC-25` Configuration** | Owns the **secret itself**; Configuration owns only the reference — EA L132 re-homed `Secrets Management` to SECURITY, L526 leaves `Secret Reference Resolution` with Configuration |

### 9.1 The three boundaries most likely to be violated

1. **Verification is not decision.** `SECP-OWN-004` and `SECP-XC-003`. A cached tenant context is not evidence that
   an authorisation still holds — `TEN-XC-010` states this for Tenancy and it binds here identically.
2. **PII constraint is not log ownership.** `SECP-OWN-007`. The rule about what a log may contain is a security rule;
   the log is Observability's.
3. **Vault ownership is not pipeline ownership, and policy ownership is not infrastructure ownership.**
   `SECP-OWN-008`, `SECP-OWN-009`. The EA already splits both with explicit bracketed annotations; this table quotes
   them rather than re-deciding them.

---

## 10. Measurable Security Success Criteria

Every criterion is a **test that can fail**. None is claimed to be met — **0 of 14 are proven**, and this document
holds no test result.

| ID | Criterion | Proves |
|---|---|---|
| **`SECP-AC-001`** | A request asserting a role, tenant or entitlement it does not hold is refused; the assertion is not honoured from client input | `SECP-OBJ-001` |
| **`SECP-AC-002`** | A fully valid session for an ordinary user cannot invoke any platform-privileged operation | `SECP-OBJ-002` |
| **`SECP-AC-003`** | A request authenticated for tenant A cannot read, write or enumerate any tenant B resource, and a request with **no** tenant context **fails** rather than defaulting | `SECP-OBJ-002`, `003` |
| **`SECP-AC-004`** | An identity cannot grant itself a role or elevate its own privilege; a platform role assignment by the subject is refused | `SECP-OBJ-004` |
| **`SECP-AC-005`** | A platform-side actor with no active approved elevation receives no tenant business data; an expired elevation grants nothing | `SECP-OBJ-004` |
| **`SECP-AC-006`** | An operation with no explicit grant is refused, and the refusal discloses nothing about what would have been required | `SECP-OBJ-005` |
| **`SECP-AC-007`** | No credential, OTP, session token or secret value appears in any log, metric, trace, index, projection or event payload | `SECP-OBJ-006`, `012` |
| **`SECP-AC-008`** | No module outside its authorised holder can obtain a secret value; a secret **reference** does not yield a secret without the vault | `SECP-OBJ-006` |
| **`SECP-AC-009`** | Repeated failed authentication attempts against one identity are throttled, and the throttle cannot be bypassed by varying a client-supplied value | `SECP-OBJ-007` |
| **`SECP-AC-010`** | Every privileged action emits an audit entry; an attempt to alter or remove one **while acting as Platform Administrator** fails, with no privileged path succeeding | `SECP-OBJ-008` |
| **`SECP-AC-011`** | Data is encrypted in transit and at rest; an unencrypted transport path is refused rather than downgraded | `SECP-OBJ-009` |
| **`SECP-AC-012`** | The V1 OWASP-scoped attack classes are refused server-side, and secure response headers are present on every response | `SECP-OBJ-010` |
| **`SECP-AC-013`** | Where a security control cannot render a decision, the operation is **refused**; no code path permits on control failure | `SECP-OBJ-011` |
| **`SECP-AC-014`** | No PII reaches logs, metrics, traces, search indices, analytics projections or model prompts; redaction failure blocks egress rather than passing the payload | `SECP-OBJ-012` |

### 10.1 Coverage, measured

| Measure | Value |
|---|---|
| Objectives with at least one acceptance criterion | **12 of 12 = 100%** |
| Principles traceable to an objective or a named gap | **12 of 12 = 100%** |
| Criteria **proven by a test** | **0 of 14 = 0%** |
| Ownership rows with a single named owner | **11 of 11 = 100%** |

⚠ `SECP-AC-010` reuses the shape of `AUD-AC-003` deliberately: the same property, verified from the security side.
It does **not** restate `AUD-AC-003`'s ownership — immutability remains `BC-24`'s.

---

## 11. Gaps, conflicts and dependencies

**All 13 are OPEN.** None is resolved by this document. Each has an owner.

| ID | Gap / conflict | Owner | Priority | Disposition |
|---|---|---|---|---|
| **`SECP-GAP-001`** | **Zero Trust version conflict.** Requested as a core principle; the EA places `Zero Trust Architecture` at **V3** (Service Auth V3, Network Segmentation V3, Continuous Verification Future) | Product Owner + ARB | **High** | `SECP-PRN-009` carried **directional**. Making it V1 requires an ADR — the EA is Rank 6 but a version promotion is an architecture change |
| **`SECP-GAP-002`** | `Least Privilege Enforcement` is EA **V2** while the identity model supporting it is V1 | ARB | Medium | `SECP-PRN-004` split: normative for the model, directional for platform-wide tooling |
| **`SECP-GAP-003`** | **WAF and DDoS are EA V2.** A production multi-tenant SaaS on the public internet with no perimeter protection is exposed from day one — flagged by the Cloud/Infrastructure Security perspective | Product Owner + INFRASTRUCTURE | **High** | Recorded, not promoted |
| **`SECP-GAP-004`** | **Threat Detection is EA V2** (anomaly, bot/abuse), ATO **V3**, SIEM **V3**. Only Brute Force Protection is V1, so the **Detect** stage of §2.3 is narrow in V1 | Product Owner | **High** | `SECP-PRN-010` directional. The consequence is stated in §8.3 |
| **`SECP-GAP-005`** | **Support-access recording undefined.** BC Map L133 gives `BC-24` the record *"including support access"*; no Rank 1–5 document defines the action list; EA `Support Access Log` is **V3**. Inherits `AUD-GAP-004` | Product Owner + `BC-18` | **High** | `SECP-OBJ-008` is unsatisfiable for support access until an emitter publishes the list (`AUD-FR-003`) |
| **`SECP-GAP-006`** | **A live `X-13` exposure exists in code.** `D-016-01` — `recent()`/`count` read the audit store with **no tenant argument**. `X-13` calls this the *"highest-severity failure class in the system"* | Platform Engineering | **High** | Pre-existing, routed to `IMPL-922`. Named here because `SECP-OBJ-003` cannot be claimed while it stands |
| **`SECP-GAP-007`** | **Security Incident Response is EA V2**, Runbooks V2, Breach Notification / Forensics / Post-Incident Review **V3**. The **Respond** stage is partial in V1 | Product Owner | **High** | `SECP-PRN-011` directional. ⚠ Breach notification is a **statutory** obligation under DPDP; a compliance dependency, not merely a roadmap item |
| **`SECP-GAP-008`** | **Disaster Recovery is EA V3**, RTO/RPO **V2**; only Backup Strategy is V1. The **Recover** stage is partial | Product Owner + INFRASTRUCTURE | Medium | `SECP-PRN-012` marked partial |
| **`SECP-GAP-009`** | **Supply-chain security is EA V2**: Dependency Vulnerability Scanning V2, SAST V2, Patch Management V2, DAST V3. CI static analysis and tests are V1 | Product Owner + DEVOPS | **High** | Flagged by the DevSecOps perspective as genuinely necessary for production. Recorded, not promoted |
| **`SECP-GAP-010`** | **This module owns no aggregate and no bounded context** (§0.5). Whether the SECURITY platform should hold one is undecided; `SECP-INV-*` and `SECP-EVT-*` stay empty until it is | ARB | Medium | An aggregate or a `BC-nn` requires an ADR — BC Map L292 |
| **`SECP-GAP-011`** | **No Rank 1–5 authority supplies a security configurable, default or bound.** `CONFIGURATION_GUIDE.md` has no security row | Product Owner + `BC-25` | Medium | `SECP-CFG-*` empty. Inventing a threshold would create a control by side effect |
| **`SECP-GAP-012`** | **`PRD-012` retirement is triggered and not executed.** Registry §4.1 retires `PRD-012` *"on the day `PRD-012a` is opened"*; the register still lists it `PLANNED` and still reports **1** unassignable PRD | **Governance Owner** | Medium | Not executed here — see §0.6 |
| **`SECP-GAP-013`** | **Register and ownership-model counts are now stale.** `PRD_REGISTRY.md` §7 and `PRD_OWNERSHIP_MODEL.md` §4 both treat `PRD-012a` as a reservation | **Governance Owner** | Low | Not executed here |

⚠ **Naming, disclosed and not a gap.** The authoring request said `PRD-012A` (uppercase); every authority — registry
§4.1, `PRD_OWNERSHIP_MODEL.md` L180, the gap analysis — reserves lowercase **`PRD-012a`**. The registry form governs,
and this document uses it. `PRD-012A` is **not** a second identifier and must not become one.

### 11.1 Conflicts found and NOT silently resolved

`SECP-GAP-001`, `002`, `003`, `004`, `007`, `008` and `009` are all the same class: **a capability the Enterprise
Architecture places at V2 or V3, requested as a V1 principle for this document.** Every one is recorded rather than
resolved, under `DOCUMENTATION_BASELINE.md` L253 — *"A conflict is a defect. If you find one, do not choose — raise
it."*

The instruction that governs is the request's own qualifier: principles are to be included **"where supported by the
existing architecture."** Seven are not supported at V1 by the existing architecture, so they appear as directional
principles with named dependencies.

---

## 12. Lifecycle status

| Stage | Status |
|---|---|
| 1 — Discovery | ⚠ **Partially satisfied, with one gate not met as written.** `PRD_LIFECYCLE.md` Stage 1's *"Does a bounded context own this?"* test yields **no `BC-nn`** (§0.5), and its gate requires *"a context identified in the Bounded Context Map."* The authority to proceed is **not** that test: `PRD_REGISTRY.md` §4.1 states `PRD-012a` *"may be opened without a further ADR"*, tracing to Rank 1 §8 Correction 2. **The discrepancy is disclosed rather than reported as passed** — carried as `SECP-GAP-010` |
| 2 — Draft | **In progress.** Versioned header ✅ · registers declared with ranges ✅ · prefix chosen against §5's collision procedure **before** writing ✅ (§0.4) · contiguous ranges ✅ · normative language defined ✅. **Parts 2–8 not written, so Stage 2 is not complete** |
| 3 — Architecture Review | **Not started** |
| 4 — Requirements Review | **Not started** |
| 5 — Traceability | **Not started.** `SECP-` is **not** registered in `TRACEABILITY_MATRIX.md` §2 |
| 6 — Implementation Tasks | **Not started.** No `IMPL-*` range allocated |
| 7 — Freeze | **Not started.** No baseline row exists. This document is **unranked** |
| 8–9 | **Not started** |

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-08-21 | **Created — PART 1 ONLY.** Opened under `PRD_REGISTRY.md` §4.1's standing authorisation (*"may be opened without a further ADR"*), traced to `MASTER_PRD.md` §8 Correction 2 (Rank 1). **72 identifiers** across six registers; five registers declared **deliberately empty** with reasons. Prefix **`SECP-`** selected after **`SEC-` was measured and REJECTED** for collision with `INV-SEC-001`…`071` (155 hits) — the narrow probe that would have licensed `SEC-` is disclosed in §0.4 as a near-miss. **Four requested principles carried as DIRECTIONAL, not V1**, because the EA places Zero Trust at **V3** and Threat Detection, Incident Response, WAF/DDoS, Vulnerability Management and Compliance at **V2/V3** — recorded as `SECP-GAP-001`…`009` rather than promoted, per `DOCUMENTATION_BASELINE.md` L253. **13 gaps OPEN**, including one live code exposure (`D-016-01`, an `X-13` violation) named because `SECP-OBJ-003` cannot be claimed while it stands. **No ranked document amended. No frozen document touched. No requirement of any other PRD restated, moved or reinterpreted. No table, API, SQL, code, cloud resource or cryptographic mechanism specified. `PRD-012` retirement and register count updates triggered but NOT executed** (`SECP-GAP-012`, `SECP-GAP-013`) — routed to the Governance Owner. Parts 2–8 **not written** |
