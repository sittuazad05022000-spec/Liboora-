# PRD-012a — Security Automation

> **PART 6 of 8 — Security Automation & Incident Response.**
> Parts 1–5 are in this directory and **none is modified by this document**:
> [Part 1](./PRD-012a_SECURITY_AUTOMATION.md) ·
> [Part 2](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md) ·
> [Part 3](./PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md) ·
> [Part 4](./PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md) ·
> [Part 5](./PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md).

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 6 |
| **Module** | Security Automation |
| **Version** | **v0.6** (Part 6 added; Parts 1–5 unchanged) |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5 |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1** — but EA tags `Security Incident Response` **V2** and `BC-28` Workflow **V2**; §2 governs |
| **Requirement prefix** | **`SECP-`** — continuing Part 1's registers. **No new register** |
| **Rank** | **Unranked.** **MUST NOT** be cited as authority against any ranked document |
| **Authorities applied** | As Part 5; `AUTH-8.80`…`8.83`, `AUTH-11.53`…`11.59`, `SPO-8`, `SEV-12`, `ADR-0013` applied directly |
| **Date** | 2026-08-21 |
| **Written at** | `12a55dbdfb64e7a91d00022220603c389f5c890b` |

---

## 0. How to read Part 6

### 0.1 Normative language

As Part 1 §0.1. **MUST**/**SHALL** binding; **SHOULD** a strong default requiring a recorded reason to depart from;
**MAY** genuinely optional; **directional** statements carry **no V1 obligation**.

### 0.2 What Part 6 does, and does not, do

| Part 6 does | Part 6 does **not** |
|---|---|
| State which automated responses V1 may take, as a closed set | Own workflow orchestration — `BC-28` is `[GENERIC]` and **V2** (`SECP-XC-030`) |
| Define incident severity by reference to Part 5's `SECP-SEV-*` classes | Mint a second severity scale |
| Require that every automated action be reversible, attributable and audited | Create a role, permission or capability able to perform the action |
| State the response lifecycle as *stages*, not as an orchestrated process | Define playbooks, runbooks, forensics or breach notification — all EA **V2/V3** |
| Record what V1 cannot contain, and why | Imply a containment capability the platform lacks |
| Bind every normative requirement to a measurable criterion | Specify tables, APIs, SQL, code, UI, cloud resources or crypto |

> ⚠ **The governing reading rule for Part 6.** *"Security automation"* is this module's name, and that makes it the
> Part most at risk of over-claiming. Two hard boundaries apply throughout. **First**, an automated response may only
> invoke a capability that **already exists at V1 and is owned elsewhere** — Part 6 mints no capability.
> **Second**, orchestration is `BC-28`'s and is **V2**; Part 6 therefore specifies *what must happen*, never *what
> sequences it*.

### 0.3 Identifier registers — Part 6's ranges

| Register | Meaning | Parts 1–5 | **Part 6** | Part 6 range | Reserved for Parts 7–8 |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 57 | **12** | `058`…`069` | `070`+ |
| `SECP-BR-NNN` | Business rule | 17 | **4** | `018`…`021` | `022`+ |
| `SECP-XC-NNN` | Exclusion | 29 | **4** | `030`…`033` | `034`+ |
| `SECP-OWN-NNN` | Ownership boundary | 23 | **3** | `024`…`026` | `027`+ |
| `SECP-AC-NNN` | Acceptance criterion | 90 | **16** | `091`…`106` | `107`+ |
| `SECP-GAP-NNN` | Gap / open question | 31 | **4** | `032`…`035` | `036`+ |
| `SECP-SIG-NNN` | Security signal | 10 | **0** — the set is **closed** by `SECP-BR-016` | — | `011`+ |
| `SECP-SEV-NNN` | Severity class | 4 | **0** — reused, not extended (§4) | — | `005`+ |

**Part 6 declares 43 identifiers.** Running total for `PRD-012a`: **340**.

> ⚠ **Citation is not declaration.** Out-of-range `SECP-*` numbers below cite Parts 1–5.

### 0.4 Prefix collision check

No new prefix. Part 1 §0.4 records the `SECP-` selection and the `SEC-` rejection; Part 5 §0.4 records `SECP-SIG-`
and `SECP-SEV-`. Part 6 introduces nothing further.

---

## 1. Purpose

Part 6 specifies the **Contain → Respond → Recover** stages of Part 1 §2.3's model. Parts 3–4 prevent; Part 5
detects; Part 6 is what happens next.

Its scope is set by a measurement that must be stated before any requirement is read:

> EA L2050 tags `Security Incident Response` **V2**, with `Playbooks` **V2**, `Breach Notification` **V3**,
> `Forensics` **V3** and `Post-Incident Review` **V3**. BC Map tags `BC-28` Workflow Orchestration `[GENERIC]` **V2**.
> OBSERVABILITY's `Incident Management` is **V3** and `Runbooks` **V2**.

**Almost nothing in incident response is a V1 capability.** Part 6 therefore does not specify an incident-response
programme. It specifies the narrow set of **automated, immediate, individually-triggered responses** that V1 can
actually perform using capabilities that already exist, and it records the rest as gaps with their version tags.

---

## 2. EA and BC scope boundary — the governing table

| Capability | Tag | Part 6 treatment |
|---|---|---|
| `Security Incident Response` (parent) | **V2** | **Not promoted.** §3's responses are grounded in **V1** capabilities owned elsewhere, not in this node |
| `Incident Response Playbooks` | **V2** | Excluded — `SECP-XC-031`; consequence `SECP-GAP-032` |
| `Breach Notification` | **V3** | Excluded — `SECP-XC-031`; consequence `SECP-GAP-034` |
| `Forensics` | **V3** | Excluded — `SECP-XC-031`; consequence `SECP-GAP-033` |
| `Post-Incident Review` | **V3** | Excluded — `SECP-XC-031` |
| `BC-28` Workflow Orchestration | **V2** | Excluded — `SECP-XC-030`, `SECP-OWN-024` |
| OBSERVABILITY `Incident Management` | **V3** | Excluded — `SECP-XC-031` |
| OBSERVABILITY `Runbooks` | **V2** | Excluded — `SECP-XC-031` |
| `Secrets Rotation`, `Key Management` | **V2** | Excluded — Part 3 `SECP-GAP-024` already records the consequence |
| INFRASTRUCTURE `Disaster Recovery` | **V3** | Excluded — Part 7's concern; `Backup Strategy` **V1** is Part 7's |
| **Session termination / global sign-out** | **V1** | **Relied upon** — `AUTH-8.80`; `BC-18` owns it |
| **Immediate revocation** | **V1** | **Relied upon** — `PRD-001` §2.7 *Immediate Revocation*; `BC-18` owns it |
| **Identity status suspend/reinstate** | **V1** | **Relied upon** — `SPO-8`, status only; `BC-10` owns it |
| **Device management** | **V1** | **Relied upon** — `ADR-0002` (*"which is why device management is V1"*) |
| **Audit record** | **V1** | **Relied upon** — `BC-24`; `AUD-XC-002` |
| **Notification delivery** | **V1** | **Relied upon** — `BC-22`; `EV-16` precedent |

`SECP-XC-030` — Part 6 **MUST NOT** define, own, schedule, sequence, retry, compensate or orchestrate a workflow,
saga, state machine, job queue or long-running process. `BC-28` Workflow Orchestration is `[GENERIC]` and **V2**.
Where Part 6 states that several things must happen, it states them as **independent obligations**, not as a
sequence. *Owner: `BC-28` Workflow Orchestration, at **V2**.*

`SECP-XC-031` — Part 6 **MUST NOT** specify an incident-response playbook, runbook, forensic procedure, evidence-
preservation process, breach-notification obligation, regulatory timeline, post-incident review process or on-call
structure. Each is EA **V2** or **V3**. *Owner: SECURITY platform at V2/V3; `Breach Notification` also engages
`MP-NFR-10`'s joint SECURITY + DATA compliance ownership.*

---

## 3. Security-triggered automation

### 3.1 The three rules that bound every automated response

`SECP-BR-018` — **An automated response may only invoke a capability that already exists at V1 and is owned
elsewhere.** Part 6 mints no capability, no role, no permission and no privileged path. Where a desired response has
no existing V1 capability, it **SHALL** be recorded as a gap rather than specified. *This is the rule that keeps
"security automation" from becoming a back door: `SECP-XC-019` already forbids this module holding an identity or
role, so an automated action must be performed by the owning context, not by this one.*

`SECP-BR-019` — **Automated response is fail-safe, not fail-open.** Where an automated response cannot be performed —
the owning capability is unavailable, the action is refused, or the outcome is ambiguous — the condition **SHALL**
escalate as an unhandled incident and **SHALL NOT** be treated as handled, retried silently into a permissive path, or
discarded. *Follows Part 3 `SECP-FR-028`'s fail-closed direction and `MP-NFR-12` (*"it is refused rather than
guessed"*).*

`SECP-BR-020` — **No automated response may weaken a control.** An automated action **SHALL NOT** grant access,
extend a session, elevate a role, relax a limit, disable a signal, suppress an audit entry, or create standing
access. Automation may **restrict**; it may never **permit**. *Grounded in `SECP-XC-003` (no authorisation outcome),
`AUTH-8.82` (no activity extends the absolute boundary), `AUTH-8.23` (no role bypasses limits), `AUD-XC-002` (no
audit alteration), `XC-2.5` (*"no standing access is created"*), and Part 5 `SECP-FR-049` (signals not suppressible).*

### 3.2 The closed response set

`SECP-FR-058` — The set of automated security responses available at V1 **SHALL** be exactly the four in the table
below. Each **SHALL** be performed by the owning context named, invoked by the SECURITY platform rather than executed
by it.

| Response | Triggering severity | Performed by | V1 capability relied upon |
|---|---|---|---|
| **Terminate the affected session(s)** | `SECP-SEV-001`, `SECP-SEV-002` | `BC-18` | `AUTH-8.80` global sign-out; `AUTH-8.37` per-use evaluation |
| **Refuse the in-flight operation** | any | the operation's own path | Part 3 `SECP-FR-028` fail-closed |
| **Notify the affected account holder** | `SECP-SEV-001`, `SECP-SEV-002` | `BC-22` | `EV-16` unrecognised-device notification precedent (`ADR-0002`) |
| **Record the response** | any | `BC-24` | `AUD-BR-002`; BC Map **L133** |

`SECP-FR-059` — A response **SHALL NOT** be invoked outside the set in `SECP-FR-058`. A condition requiring a response
not in that set **SHALL** escalate for human decision and **SHALL** be recorded as a gap against this register.
*Follows Part 2's `SECP-BR-004` and Part 5's `SECP-BR-016` closure device — "silence is not permission".*

`SECP-FR-060` — Every automated response **SHALL** be attributable in the audit record to the **signal** that
triggered it (`SECP-SIG-*`), the **severity** assigned (`SECP-SEV-*`), and the fact that it was automated rather than
performed by a person. An automated action indistinguishable from a human action in the record **SHALL** be treated as
a defect. *Grounded in BC Map **L133** — `BC-24` records *"who did what, including AI actions and support access"* —
so a non-human actor class already exists in the audit model and this requirement uses it rather than inventing one.*

`SECP-FR-061` — Every automated response **SHALL** be reversible by an authorised human, or **SHALL** be
non-destructive. A response that permanently destroys access, data or an account **SHALL NOT** be automated. *Bounds
the blast radius of automation. Note that session termination is non-destructive — the account may re-authenticate —
and identity **status** change under `SPO-8` is reversible by design (*"suspend/reinstate/archive/restore"*).*

`SECP-FR-062` — Automated response **SHALL NOT** be triggered by a signal the platform cannot produce. Where §3.2
names a triggering severity, the triggering signals are exactly Part 5 §6.2's mapping for that class. *Prevents
automation being specified against Part 5's excluded V2/V3 detections.*

---

## 4. Incident severity — reuse, not a second scale

`SECP-FR-063` — Incident severity **SHALL** be the severity class already assigned to the triggering signal under
Part 5 `SECP-FR-055`. Part 6 **SHALL NOT** define, derive or re-map a separate incident severity scale.

| Class | Incident meaning | Response expectation |
|---|---|---|
| `SECP-SEV-001` **Critical** | Isolation failure or a Rank 1 Critical risk realised | Immediate automated response **and** immediate escalation; no threshold |
| `SECP-SEV-002` **High** | Compromise or privileged-path anomaly | Immediate automated response **and** escalation; no threshold |
| `SECP-SEV-003` **Medium** | Abuse in progress, bounded by an existing control | Existing control responds; escalation on sustained rise |
| `SECP-SEV-004` **Low** | A control operating as designed under adverse conditions | Aggregate review; a rise is itself `SECP-SEV-003` |

`SECP-BR-021` — **Severity is assigned once, at the signal, and is not renegotiated downstream.** A response path
**SHALL NOT** downgrade, defer, batch or suppress a severity to reduce its own load. *Extends Part 5 `SECP-FR-057` from
escalation into response, closing the class where automation quietly reclassifies an incident it cannot handle.*

`SECP-XC-032` — Part 6 **MUST NOT** define a second severity scale, an incident priority scale, an SLA, a response-
time target, an SLO or an error budget. *Owner: OBSERVABILITY platform for SLO/SLI, tagged **V2**; escalation policy
is `SECP-XC-029`'s exclusion.*

---

## 5. Containment

### 5.1 What V1 can contain

`SECP-FR-064` — Containment at V1 **SHALL** be achieved by the mechanisms in `SECP-FR-058` — session termination,
operation refusal — together with the existing controls already specified elsewhere: rate-limit locks
(`AUTH-8.19`, `CFG-4`), challenge invalidation (`AUTH-8.25`), immediate revocation (`PRD-001` §2.7), device removal
(`AUTH-8.81`'s step-up surface), and identity **status** suspension (`SPO-8`, status only, never profile content per
`SID-3.32`). Part 6 adds no containment mechanism of its own.

`SECP-FR-065` — Containment **SHALL** preserve tenant isolation without exception, including under degraded operation.
A containment action **SHALL NOT** affect a tenant other than the one in scope, and **SHALL NOT** relax isolation to
achieve its effect. *Directly grounded in `AUTH-11.57` (*"degraded operation MUST preserve tenant isolation without
exception"*) and `AUTH-11.20`; a containment action that leaks across tenants has caused `MP-RSK-01`, not prevented
it.*

`SECP-FR-066` — A containment action **SHALL** be bounded in time or scope by an existing configuration parameter
owned by `BC-25`, and **SHALL NOT** create an indefinite state that only a manual act can clear. Where no such
parameter exists, the action **SHALL NOT** be automated. *Follows `CFG-4`'s bounded-lock precedent and `XC-2.6`'s
*"no grace period, no automatic renewal"*; avoids minting a parameter, per `SECP-XC-014`.*

### 5.2 What V1 cannot contain

`SECP-GAP-032` — **V1 has no playbook or orchestrated containment.** `Incident Response Playbooks` is EA **V2**,
`Runbooks` **V2**, and `BC-28` Workflow **V2**. V1's containment is therefore a set of **independent immediate
actions** (§3.2), not a coordinated procedure. A multi-step containment requiring ordering, compensation or retry
cannot be automated at V1. **Priority: Medium.** *Not an argument for promoting `BC-28`; §3's design deliberately
requires only order-independent actions so that no workflow is needed.*

`SECP-GAP-033` — **V1 cannot preserve forensic evidence.** `Forensics` is EA **V3**. The audit record (`BC-24`, V1)
records *what happened*; it is not an evidence-preservation capability, and `AUD-GAP-004` additionally leaves the
support-access list undefined. A V1 incident can be reconstructed from audit only to the extent `AUTH-11.29` allows
(*"reconstruct a single account's authentication history from audit without access to personal data"*). **Priority:
Medium.**

`SECP-GAP-034` — **V1 has no breach-notification capability or obligation record.** `Breach Notification` is EA
**V3**, `DPDP` compliance **V2**, `GDPR`/`SOC 2`/`ISO 27001` **V3/Future**. The platform operates in India and DPDP is
tagged **V2**, so a V1 breach has **no specified notification path, timeline or recipient set**. This is stated
plainly because `MP-NFR-10` assigns compliance jointly to SECURITY and DATA and neither has a V1 requirement here.
**Priority: High.** *Routed to the Governance and Architecture Owners in Part 8; this document does not invent a
regulatory obligation, which would be both out of scope and legally unsound.*

---

## 6. Response lifecycle, escalation and recovery

### 6.1 The lifecycle as stages, not as a process

`SECP-FR-067` — The response lifecycle **SHALL** be expressed as the four stages below, each an **independent
obligation** with its own completion condition. It **SHALL NOT** be implemented as an orchestrated process, and no
stage **SHALL** depend on a workflow engine to occur.

| Stage | Obligation | Completion condition | Owner of the mechanism |
|---|---|---|---|
| **Detect** | A `SECP-SIG-*` is emitted with a `SECP-SEV-*` class | Signal exists and is countable (Part 5 `SECP-FR-052`) | This module (emission); OBSERVABILITY (plane) |
| **Contain** | The applicable `SECP-FR-058` responses are invoked | Each invoked response returned an outcome, or escalated per `SECP-BR-019` | `BC-18`, `BC-22`, the operation's path |
| **Respond** | The incident is escalated per its severity | Escalation occurred, or a gap is recorded | OBSERVABILITY `Alerting` — **V2**, see `SECP-GAP-031` |
| **Recover** | Normal operation is restored without resurrecting revoked state | §6.3's four prohibitions hold | `BC-18`; INFRASTRUCTURE `Backup Strategy` **V1** |

> ⚠ **This is the same five-stage model as Part 1 §2.3, with *Prevent* discharged by Parts 3–4.** Part 6 does not
> introduce a competing model, and `SECP-BR-021` prevents severity drifting between stages.

`SECP-FR-068` — Each stage's completion **SHALL** be independently determinable from the audit record and the signal
record, without reference to an orchestrator's state. *Makes the stages verifiable in the absence of `BC-28`.*

### 6.2 Escalation

`SECP-FR-069` — Escalation **SHALL** occur for every `SECP-SEV-001` and `SECP-SEV-002` incident regardless of whether
an automated response succeeded. A successful automated containment **SHALL NOT** suppress escalation. *Closes the
most tempting automation defect: treating "handled" as "no longer worth reporting". `AUTH-11.27` and `AUTH-11.28`
require alertability unconditionally.*

> ⚠ **`SECP-GAP-031` (Part 5) bounds this requirement and is not restated as solved.** Rank 3 requires alertability;
> EA tags `Alerting` **V2**. `SECP-FR-069` therefore requires that escalation *occur*; it cannot require a delivery
> capability this module has no authority to promote.

### 6.3 Recovery

`SECP-XC-033` — Recovery **MUST NOT** resurrect an erased account, a terminated session, a revoked role, a removed
device or a deleted grant, and **MUST NOT** relax tenant isolation to complete. *Directly adopts `AUTH-11.55`…
`AUTH-11.58` — including `AUTH-11.57`'s *"degraded operation MUST preserve tenant isolation without exception"* —
rather than restating them as new rules. `AUTH-11.53` and `AUTH-11.54` continue to prohibit any bypass or break-glass
during recovery, as Part 2 §10 established (`SECP-XC-011`).*

`SECP-GAP-035` — **V1 has no exercised recovery procedure for the security responses in §3.2.** `AUTH-11.59` requires
that *"recovery procedures MUST be exercised, not merely documented"*, yet `Post-Incident Review` is EA **V3**,
`Runbooks` **V2** and `Disaster Recovery` **V3**. Part 7 carries the resilience and incident-readiness testing
obligation; this gap records that **no V1 artefact currently discharges `AUTH-11.59` for security responses**, and it
compounds Part 2's `SECP-GAP-018` (with break-glass prohibited and `PR-1` a closed two-role set, total loss of all
`PR-1` accounts has no administrative recovery path). **Priority: High.** *Not an argument for adding break-glass —
`AUTH-11.54` prohibits it and Part 2 §10 is unchanged.*

---

## 7. Coordination with Workflow — without taking ownership

`SECP-OWN-024` — **Orchestration belongs to `BC-28` Workflow Orchestration.** Sequencing, scheduling, retry,
compensation, timeout, long-running state and process definition are `BC-28`'s, `[GENERIC]`, and **V2**. The SECURITY
platform's V1 responses are deliberately designed to be **order-independent and individually completable** so that no
orchestrator is required. When `BC-28` arrives at V2, security responses become candidates for orchestration; that
will be `BC-28`'s specification to write, not this module's. *Owner: `BC-28` (**V2**).*

`SECP-OWN-025` — **Notification delivery belongs to `BC-22`.** Channel selection, templating, localisation, retry,
delivery status and provider behaviour are `BC-22`'s. Part 6 requires **that** an affected account holder be notified
(`SECP-FR-058`) and specifies nothing about how. *Owner: `BC-22` Notification Delivery.*

`SECP-OWN-026` — **The record belongs to `BC-24`; the identity status belongs to `BC-10`; the session and role belong
to `BC-18`.** Part 6 invokes each and owns none. `SPO-8` in particular restricts even a Platform Administrator to
identity **status** — *"never profile content (`SID-3.32`)"* — and no automated response may exceed what a human
Platform Administrator could do. *Owner: `BC-24` (`PRD-016`), `BC-10` (`PRD-003`), `BC-18` (`PRD-001`).*

> ⚠ **`ADR-0013`'s distinction is the one that makes this Part coherent.** Capability context is owned by its
> platform, and **context ownership is not aggregate ownership**. The SECURITY platform holds the *security context*
> of a response — which signal, which severity, whether to invoke — while every *aggregate* the response touches
> stays with its owning context. `SECP-BR-018` is the operational form of that ruling.

---

## 8. Acceptance criteria

| ID | Criterion | Binds |
|---|---|---|
| `SECP-AC-091` | Every automated response invokes a capability owned by another context; no response is executed by this module directly, and no new role, permission or privileged path is created for one | `SECP-BR-018`, `SECP-OWN-024`…`026` |
| `SECP-AC-092` | With the owning capability unavailable, refusing, and returning an ambiguous outcome — three cases — the condition escalates as unhandled in all three; none is recorded as handled | `SECP-BR-019` |
| `SECP-AC-093` | No automated response grants access, extends a session, elevates a role, relaxes a limit, disables a signal, suppresses an audit entry or creates standing access; seven checks, zero occurrences | `SECP-BR-020` |
| `SECP-AC-094` | The invoked response set equals `SECP-FR-058`'s four entries exactly; a condition requiring a fifth escalates for human decision and is recorded as a gap | `SECP-FR-058`, `SECP-FR-059` |
| `SECP-AC-095` | For a sampled automated response, the audit record carries the triggering `SECP-SIG-*`, the assigned `SECP-SEV-*`, and an actor class distinguishing automation from a person | `SECP-FR-060` |
| `SECP-AC-096` | Each of the four responses is either reversible by an authorised human or non-destructive; no response permanently destroys access, data or an account | `SECP-FR-061` |
| `SECP-AC-097` | No automated response is triggerable by a signal outside `SECP-SIG-001`…`010`; an attempt to configure one against an excluded V2/V3 detection has no effect | `SECP-FR-062` |
| `SECP-AC-098` | Incident severity equals the triggering signal's `SECP-SEV-*` class in every sampled case; no separate incident scale, priority scale, SLA or response-time target is found | `SECP-FR-063`, `SECP-XC-032` |
| `SECP-AC-099` | A response path cannot downgrade, defer, batch or suppress a severity; four attempts each leave the severity unchanged | `SECP-BR-021` |
| `SECP-AC-100` | Containment is achieved only by the mechanisms named in `SECP-FR-064`; no containment mechanism originating in this document is found | `SECP-FR-064` |
| `SECP-AC-101` | A containment action scoped to tenant A produces no effect observable by tenant B, and no isolation relaxation occurs; verified under normal and degraded operation | `SECP-FR-065` |
| `SECP-AC-102` | Every automated containment action is bounded by a `BC-25` parameter; an action with no bounding parameter is not automated, and the count of unbounded automated actions is zero | `SECP-FR-066` |
| `SECP-AC-103` | Each of the four lifecycle stages has an independently determinable completion condition, evaluable from the audit and signal records with no orchestrator state consulted | `SECP-FR-067`, `SECP-FR-068` |
| `SECP-AC-104` | A `SECP-SEV-001` and a `SECP-SEV-002` incident each escalate even when automated containment succeeded; success does not suppress escalation | `SECP-FR-069` |
| `SECP-AC-105` | After a recovery, an erased account, terminated session, revoked role, removed device and deleted grant each remain absent — five checks — and tenant isolation is intact | `SECP-XC-033` |
| `SECP-AC-106` | Part 6 declares no workflow, saga, state machine, job queue, playbook, runbook, forensic procedure, breach-notification obligation, second severity scale or SLA; a search returns none | `SECP-XC-030`, `SECP-XC-031`, `SECP-XC-032` |

### 8.1 Coverage table

| Requirement | Criterion | Requirement | Criterion |
|---|---|---|---|
| `SECP-FR-058` | `AC-094` | `SECP-FR-065` | `AC-101` |
| `SECP-FR-059` | `AC-094` | `SECP-FR-066` | `AC-102` |
| `SECP-FR-060` | `AC-095` | `SECP-FR-067` | `AC-103` |
| `SECP-FR-061` | `AC-096` | `SECP-FR-068` | `AC-103` |
| `SECP-FR-062` | `AC-097` | `SECP-FR-069` | `AC-104` |
| `SECP-FR-063` | `AC-098` | `SECP-BR-018` | `AC-091` |
| `SECP-FR-064` | `AC-100` | `SECP-BR-019` | `AC-092` |
| `SECP-BR-020` | `AC-093` | `SECP-BR-021` | `AC-099` |
| `SECP-XC-030` | `AC-106` | `SECP-XC-031` | `AC-106` |
| `SECP-XC-032` | `AC-098`, `AC-106` | `SECP-XC-033` | `AC-105` |
| `SECP-OWN-024`…`026` | `AC-091` | | |

**12 `SECP-FR-*`, 4 `SECP-BR-*`, 4 `SECP-XC-*` and 3 `SECP-OWN-*` are declared in Part 6; all 23 are bound above.
Uncovered: none.**

---

## 9. Gaps declared in Part 6

| ID | Gap | Priority | Blocked by |
|---|---|---|---|
| `SECP-GAP-032` | No playbook or orchestrated containment at V1; `Playbooks`/`Runbooks` EA **V2**, `BC-28` **V2**. Multi-step containment cannot be automated | Medium | EA and BC Map version tags |
| `SECP-GAP-033` | V1 cannot preserve forensic evidence; `Forensics` is EA **V3**, and `AUD-GAP-004` leaves the support-access list undefined | Medium | EA version tag; `PRD-016` |
| `SECP-GAP-034` | **No V1 breach-notification path, timeline or recipient set.** `Breach Notification` EA **V3**, DPDP **V2**; `MP-NFR-10` assigns compliance jointly to SECURITY and DATA | **High** | EA version tags; Governance Owner |
| `SECP-GAP-035` | `AUTH-11.59` requires recovery be *exercised*, yet no V1 artefact discharges this for security responses; compounds `SECP-GAP-018` | **High** | EA `Post-Incident Review` **V3**, `Runbooks` **V2**, `DR` **V3** |

---

## 10. Lifecycle status

**Stage 2 (Draft).** File on disk; versioned header; registers declared with contiguous ranges; no new prefix
(§0.4); normative language defined in §0.1.

Stage 1's gate remains unmet and **disclosed rather than claimed** — no security `BC-nn` exists (Part 1 §0.5;
`SECP-GAP-010`); authority to proceed is `PRD_REGISTRY.md` §4.1's standing authorisation. Stage 5 not started;
`SECP-` is **not** registered in `TRACEABILITY_MATRIX.md`. **Freeze is conferred, not claimed.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v0.6 | 2026-08-21 | Part 6 created. 43 identifiers: `SECP-FR-058`…`069`, `SECP-BR-018`…`021`, `SECP-XC-030`…`033`, `SECP-OWN-024`…`026`, `SECP-AC-091`…`106`, `SECP-GAP-032`…`035`. Workflow orchestration held to `BC-28` at **V2** (`SECP-XC-030`, `SECP-OWN-024`) — the response lifecycle is expressed as **four independent obligations**, deliberately order-independent so no orchestrator is required. `Security Incident Response` **not promoted** from EA **V2**: the four automated responses in `SECP-FR-058` are each grounded in an existing **V1** capability owned by `BC-18`, `BC-22` or `BC-24`, per `SECP-BR-018` and `ADR-0013`'s context-vs-aggregate distinction. `SECP-BR-020` forbids automation ever permitting, only restricting. Severity **reused** from Part 5, no second scale (`SECP-FR-063`, `SECP-XC-032`). Recovery prohibitions adopted from `AUTH-11.55`…`11.58` by reference (`SECP-XC-033`); break-glass remains prohibited. Playbooks, forensics, breach notification and exercised recovery recorded as `SECP-GAP-032`…`035`. No identifier from Parts 1–5 renumbered, reworded or withdrawn. |
