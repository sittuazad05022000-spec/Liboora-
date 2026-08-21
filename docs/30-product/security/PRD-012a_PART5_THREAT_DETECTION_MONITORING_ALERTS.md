# PRD-012a — Security Automation

> **PART 5 of 8 — Threat Detection, Monitoring & Alerts.**
> Parts 1–4 are at [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md),
> [`PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md),
> [`PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md`](./PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md) and
> [`PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md`](./PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md).
> **None is modified by this document.**

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 5 |
| **Module** | Security Automation |
| **Version** | **v0.5** (Part 5 added; Parts 1–4 unchanged) |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5 |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1 — and this Part is the most version-constrained of the eight.** EA tags every member of Threat Detection **V2/V3 except `Brute Force Protection` (V1)**, and tags `Alerting` **V2**. §2 is therefore the governing section |
| **Requirement prefix** | **`SECP-`** — continuing Part 1's registers; **two new registers `SECP-SIG-` and `SECP-SEV-`**, collision-checked in §0.4 |
| **Rank** | **Unranked.** **MUST NOT** be cited as authority against any ranked document |
| **Authorities applied** | As Part 4; `AUTH-8.27`, `AUTH-11.23`…`11.30` and `ADR-0002` applied directly in §3–§6 |
| **Date** | 2026-08-21 |
| **Written at** | `12a55dbdfb64e7a91d00022220603c389f5c890b` *(the Parts 3–4 commit; see §9's note on its authorship)* |

---

## 0. How to read Part 5

### 0.1 Normative language

As Part 1 §0.1. **MUST**/**SHALL** binding; **SHOULD** a strong default requiring a recorded reason to depart from;
**MAY** genuinely optional; **directional** statements carry **no V1 obligation**.

### 0.2 What Part 5 does, and does not, do

| Part 5 does | Part 5 does **not** |
|---|---|
| Enumerate the **security signals** V1 can actually emit, as a closed set | Claim a detection capability EA tags **V2** or **V3** |
| State severity classes and the escalation each requires | Own alerting, routing, paging or on-call — EA tags `Alerting` **V2**; §6 records the consequence |
| Require a signal where a ranked requirement already demands alertability | Restate `AUTH-11.26`…`11.28`, reinterpret them, or move them |
| Record every detection V1 **cannot** perform, as a gap | Imply that an absent detection is a present one |
| Bind every normative requirement to a measurable criterion | Own logging, metrics, tracing, dashboards or incident management |

> ⚠ **The most important reading rule for Part 5.** This Part specifies the *Detect* stage of Part 1 §2.3's model
> (**Prevent → Detect → Contain → Respond → Recover**). At V1 that stage is **thin by architectural decision, not by
> oversight**. A reader looking for anomaly detection, bot detection, account-takeover detection or SIEM will find
> each recorded as out of V1 scope **with its EA version tag**. Part 1 §2.2 forbids claiming the platform is secure;
> Part 5 is where that honesty costs the most.

### 0.3 Identifier registers — Part 5's ranges

| Register | Meaning | Parts 1–4 | **Part 5** | Part 5 range | Reserved for Parts 6–8 |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 46 | **11** | `047`…`057` | `058`+ |
| `SECP-BR-NNN` | Business rule | 14 | **3** | `015`…`017` | `018`+ |
| `SECP-XC-NNN` | Exclusion | 26 | **3** | `027`…`029` | `030`+ |
| `SECP-OWN-NNN` | Ownership boundary | 21 | **2** | `022`…`023` | `024`+ |
| `SECP-AC-NNN` | Acceptance criterion | 76 | **14** | `077`…`090` | `091`+ |
| `SECP-GAP-NNN` | Gap / open question | 27 | **4** | `028`…`031` | `032`+ |
| `SECP-SIG-NNN` | **Security signal — closed set** *(new)* | — | **10** | `001`…`010` | `011`+ |
| `SECP-SEV-NNN` | **Severity class — closed set** *(new)* | — | **4** | `001`…`004` | `005`+ |

**Part 5 declares 51 identifiers.** Running total for `PRD-012a`: **297**.

> ⚠ **Citation is not declaration.** Out-of-range `SECP-*` numbers below cite Parts 1–4. A count that includes them
> is counting citations and will over-report.

### 0.4 Prefix collision check — two new registers

`PRD_LIFECYCLE.md` §5 rule 2 requires prefixes be chosen against the collision procedure **before** writing; rule 3
requires that on collision the **new** prefix change, never the existing one. Both were checked repository-wide
before this file was written:

| Candidate | Broad probe | Result | Verdict |
|---|---|---|---|
| `SECP-SIG-` | `[A-Za-z-]*SIG-[0-9]+` across `docs/` | **0** | **FREE — selected** |
| `SECP-SEV-` | `[A-Za-z-]*SEV-[0-9]{3}` across `docs/` | **0** | **FREE — selected** |

> ⚠ **The probe was deliberately broad, and that matters.** Part 1 §0.4 records a near-miss in which a *narrow* probe
> for `SEC-` returned zero and would have licensed a prefix that in fact collides with `INV-SEC-001`…`071`
> (155 occurrences; owner [`INVITATION_SECURITY_SPECIFICATION.md`](../library/INVITATION_SECURITY_SPECIFICATION.md);
> published at [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **L62**). The same broad
> form was used here.
>
> ⚠ **`SECP-SEV-` is confusable with `PRD-003`'s `SEV-1`…`SEV-16`** — the student-identity domain events, e.g.
> `SEV-12 identity.PersonSuspended`. They do **not** collide: `SEV-nn` is unprefixed and one-or-two digit,
> `SECP-SEV-nnn` is prefixed and three-digit. But `TRACEABILITY_MATRIX.md` §2A.1 warns about confusable prefixes, so
> the risk is recorded now rather than discovered at Stage 5. **Part 5 never writes a bare `SEV-nn`.**

---

## 1. Purpose

Part 5 answers one question honestly:

> When something goes wrong, what does the platform actually notice at V1 — and what does it not?

The answer is bounded by two measured facts. First, EA L2020-2063 tags the whole `Threat Detection` subtree **V2 or
V3 with a single exception**: `Brute Force Protection` is **V1**. Second, EA L1897-1985 tags OBSERVABILITY's
`Alerting` node **V2** and `Incident Management` **V3**, while `Logging`, `PII-Safe Logging`, `Tenant & User Context`
and `Crash Reporting` are **V1**.

Part 5 therefore does something narrower than a security-monitoring specification. It enumerates the signals V1 can
emit, requires their emission where a **ranked** requirement already demands alertability, classifies severity, and
records everything else as a gap.

---

## 2. EA scope boundary — the governing table

| EA capability | Tag | Part 5 treatment |
|---|---|---|
| **`Brute Force Protection`** | **V1** | **Normative** — §4. The *only* V1 member of the Threat Detection subtree |
| `Anomaly Detection` | **V2** | Excluded — `SECP-XC-027`; consequence `SECP-GAP-028` |
| `Bot & Abuse Detection` | **V2** | Excluded — `SECP-XC-027` (also Part 4 `SECP-XC-023`) |
| `Account Takeover Detection` | **V3** | Excluded — `SECP-XC-027`; consequence `SECP-GAP-029` |
| `SIEM Integration` | **V3** | Excluded — `SECP-XC-027`; consequence `SECP-GAP-030` |
| `Security Metrics & Posture` | **V3** | Excluded — `SECP-XC-027` |
| `Security Awareness & Training` | **V3** | Out of scope entirely — not a detection capability |
| OBSERVABILITY `Logging`, `PII-Safe Logging`, `Tenant & User Context`, `Crash Reporting` | **V1** | **Relied upon, not owned** — `SECP-OWN-022` |
| OBSERVABILITY **`Alerting`** | **V2** | **The binding constraint.** §6.1 and `SECP-GAP-031` |
| OBSERVABILITY `Metrics` | **V2** | **Not relied upon** by any V1 requirement here |
| OBSERVABILITY `Tracing`, `Incident Management` | **V3** | Excluded; incident response is Part 6, likewise scoped |

`SECP-XC-027` — Part 5 **MUST NOT** be read as placing anomaly detection, behavioural baselining, bot or abuse
detection, account-takeover detection, SIEM integration, security-posture scoring, IP or device reputation, or
geo-based detection in V1 scope. Each is EA **V2** or **V3**. **No V1 requirement in Part 5 depends on any of them**,
and an implementation that satisfies a Part 5 requirement *by* building one of them has **exceeded** V1 scope rather
than met it. *Owner: SECURITY platform, at the version EA records.*

`SECP-BR-015` — **An absent detection MUST be recorded as absent, never as a threshold not yet reached.** A signal
the platform cannot produce **SHALL NOT** appear in any dashboard, report, acceptance record or status summary as
"none detected", because that phrasing asserts a negative the platform never tested. *This is the Detect-stage form
of Part 1 §2.2's prohibition on security claims, and of `MP-NFR-09`'s rule that the observability plane is "never
authoritative".*

---

## 3. Security signals — the closed V1 set

### 3.1 What a signal is, and is not

A **security signal** is an observable emission indicating a security-relevant condition. A signal is **not** an alert
(an alert is routed and actioned — §6), **not** an audit entry (`BC-24` owns those), and **not** a decision
(`SECP-XC-003` forbids this module producing one).

`SECP-OWN-022` — **The observability plane belongs to the OBSERVABILITY platform; the audit record belongs to
`BC-24`.** Log transport, retention, storage, dashboards, metric aggregation and query are OBSERVABILITY's; the
immutable append-only record of who did what — *"including AI actions and support access"* (BC Map **L133**) — is
`BC-24`'s. Part 5 emits signals **into** these planes and owns neither. `MP-NFR-09` makes the observability plane
*"never authoritative"*; `AUD-XC-002` bars every role, *including Platform Administrator*, from altering or removing
an audit entry. *Owner: OBSERVABILITY platform; `BC-24` Audit Trail (`PRD-016`).*

`SECP-OWN-023` — **Domain events belong to their contexts.** `AUTH-2.7` already requires every role assignment,
revocation and elevation to emit an authentication event; `PRD-003`'s `SEV-1`…`SEV-16` are `BC-10`'s identity events.
Part 5 mints **no** domain event and declares **no** `SECP-EVT-*` register — Part 1 recorded why that register is
deliberately empty (no `BC-nn` producer row). A `SECP-SIG-*` is a **security observation**, not a domain event.
*Owner: `BC-18` (`PRD-001`), `BC-10` (`PRD-003`).*

### 3.2 The closed set

`SECP-FR-047` — The V1 security-signal set **SHALL** be exactly `SECP-SIG-001`…`SECP-SIG-010`. Each **SHALL** be
emitted on the condition stated, **SHALL** carry tenant attribution where a tenant is in scope, and **SHALL NOT**
carry personal data, credentials or session identifiers. *The exclusions follow `AUTH-11.24` and `AUTH-8.39`
directly; tenant attribution follows `AUTH-11.25` and OBSERVABILITY's `Tenant & User Context` **V1**.*

| ID | Signal | Emitted when | V1 grounding |
|---|---|---|---|
| `SECP-SIG-001` | **Cross-tenant access attempt** | A caller authorised in one tenant presents an identifier belonging to another | `AUTH-11.27` (*"alertable immediately, with no threshold"*); `X-13`; Part 3 `SECP-FR-027` |
| `SECP-SIG-002` | **Session binding violation** | A session is presented outside its account, device or library binding | `AUTH-11.28`; `AUTH-8.35`; `ADR-0004` |
| `SECP-SIG-003` | **Challenge exhaustion cluster** | Repeated challenge exhaustion for one identifier in a short period | `AUTH-8.27` — already requires a security event; this Part gives it a signal identity |
| `SECP-SIG-004` | **Rate-limit engagement** | A limit under `AUTH-8.16`…`8.19` or Part 4 `SECP-FR-043` refuses a request | `AUTH-11.26` |
| `SECP-SIG-005` | **Verification failure rise** | Verification failures rise sustainedly against an identifier or origin | `AUTH-11.26`; `PRD-001` L3839 (*"the primary raw signal for brute-force detection"*) |
| `SECP-SIG-006` | **Privileged operation performed** | Any `SECP-HRO-001`…`012` operation completes | Part 2 §13; `AUTH-8.70`, `AUTH-8.96` |
| `SECP-SIG-007` | **Elevation granted, used or expired** | A platform-role elevation bounded by `CFG-12` changes state | `AUTH-7.19`, `XC-2.3`, `XC-2.6` |
| `SECP-SIG-008` | **Authorisation unavailable — request failed closed** | A decision could not be obtained and the operation was refused | Part 3 `SECP-FR-028`; `MP-NFR-12` |
| `SECP-SIG-009` | **Tenant context absent — request refused** | An operation arrived with no resolved tenant context | Part 3 `SECP-FR-023`; `AC-2.16`; `MP-GBR-07` |
| `SECP-SIG-010` | **Sensitive value found on a prohibited surface** | A scan under Part 4 `SECP-AC-070` or Part 3 `SECP-AC-054` finds prohibited content | Part 3 `SECP-FR-030`; `CNF-FR-059`; EA `PII-Safe Logging` **V1** |

`SECP-BR-016` — **The signal set is closed, and closure binds the register, not the condition.** A newly identified
security-relevant condition **SHALL NOT** be emitted as an ad-hoc signal; it **SHALL** be added to this register by
amendment, or recorded as a gap. An emission with no `SECP-SIG-*` identity **SHALL** be treated as **unmonitored**.
*Follows Part 2's `SECP-BR-004` device and `PRD-003` §5.1's `SPO-*` precedent — "silence is not permission", applied
to observation rather than to authority.*

`SECP-FR-048` — Each of `SECP-SIG-001`…`010` **SHALL** be emitted at the point the condition is detected, in the same
execution path as the refusal or completion it describes, and **SHALL NOT** depend on a later batch, reconciliation or
scheduled job for its existence. *Closes the class where a signal exists only if a downstream job happens to run.*

`SECP-FR-049` — Signal emission **SHALL NOT** be suppressible, filterable or disableable by any role, including `PR-1`
Platform Administrator. *Adopts `AUTH-8.23`'s no-bypass property by reference; aligns with `AUD-XC-002` and Part 2
§10's prohibition on privileged override paths.*

---

## 4. Brute-force and account-abuse detection — the one V1 capability

### 4.1 The boundary, stated once

`Brute Force Protection` is EA **V1**, and its *rules* are already written at Rank 3 and `FROZEN`: `AUTH-8.24`
(attempt budget), `AUTH-8.25` (no revival), `AUTH-8.26` (server-side, per challenge), `AUTH-8.27` (exhaustion cluster
emits a security event), `AUTH-8.28` (indistinguishable failure modes) — with rate limiting at `AUTH-8.16`…`8.23` and
claim limiting at `AUTH-4.28`/`CFG-11`.

Part 4 `SECP-OWN-019` already assigned these to `PRD-001`. **Part 5 adds no rule to them.** It adds the
detection-side obligation no ranked document states:

`SECP-FR-050` — Brute-force and account-abuse conditions **SHALL** be observable as signals (`SECP-SIG-003`,
`SECP-SIG-004`, `SECP-SIG-005`) **independently of the refusal they cause**, so that a sustained attack which never
succeeds is nonetheless visible. *`AUTH-11.26` requires a sustained rise be alertable; this requirement makes the
underlying observation exist rather than assuming it.*

`SECP-FR-051` — Detection **SHALL** aggregate across identifier **and** across origin, so that an attack distributed
over identifiers or over origins is not invisible to both views. *Follows `PRD-001` §8's own two-level design —
`AUTH-8.16` per number, `AUTH-8.18` per origin, "applied at two independent levels so that neither can be evaded by
varying the other."*

`SECP-BR-017` — **Refusal is not detection.** A control that refuses an abusive request without emitting an
observation has prevented one attempt and recorded nothing; the attack remains invisible. Prevention and detection are
separate stages of Part 1 §2.3's model and **SHALL NOT** be treated as satisfied by a single mechanism. *Cites
`SECP-FR-050`.*

### 4.2 What V1 brute-force detection does not reach

`SECP-GAP-028` — **V1 detects volume, not anomaly.** `Anomaly Detection` is EA **V2**. V1's detection is threshold
and aggregation over §3.2's signals; it cannot recognise a low-and-slow attack that stays under every threshold, nor a
behavioural deviation by an otherwise-authorised caller. **Priority: Medium.** *Not an argument for promoting the V2
node.*

`SECP-GAP-029` — **V1 cannot detect account takeover, and the single-factor model makes that consequential.**
`Account Takeover Detection` is EA **V3**. `ADR-0002` records mobile OTP as the sole factor and **names SIM-swap as
its own defeat**, with unrecognised-device notification (`EV-16`) as the compensating control — *"which is why device
management is V1 and not V2."* V1 therefore relies on **user-visible notification** rather than platform detection: a
takeover via a swapped SIM produces `SECP-SIG-002` only if a binding is violated, and produces **nothing** if it is
not. **Priority: High.** *A bounded, stated weakness of the V1 factor model. `MP-CON-11` and `MP-GBR-25` place the
factor question outside this PRD's authority, and Part 1 `SECP-XC-005` forbids introducing a factor — so this gap is
recorded, not solved here.*

`SECP-GAP-030` — **V1 has no correlation across signal sources.** `SIEM Integration` is EA **V3**. The ten signals
land in the observability plane and the audit record separately; nothing at V1 correlates them into a single incident
view. Part 6's response lifecycle is therefore driven by individual signals, not by a correlated picture.
**Priority: Medium.**

---

## 5. Threat monitoring

`SECP-FR-052` — For each of `SECP-SIG-001`…`010`, the platform **SHALL** be able to state, for a stated time window,
whether the signal was emitted and how many times. A signal that cannot be counted **SHALL** be treated as **not
monitored**. *Follows `AUTH-11.23`'s pattern of requiring volume observability, applied to security signals. Note this
requires counting, not a metrics pipeline — EA `Metrics` is **V2** and is deliberately not relied upon.*

`SECP-FR-053` — Monitoring surfaces **SHALL** carry no personal data, no credential and no session identifier, and
**SHALL** attribute to a tenant without exposing an individual. *Adopts `AUTH-11.24` and `AUTH-11.25` by reference;
aligns with EA `PII-Safe Logging` **V1**.*

`SECP-FR-054` — The **absence** of signals over a period **SHALL NOT** be presented as evidence of absence of attack
unless the emission path itself was verified live in that period. Where it was not, the only supportable statement is
that nothing was observed. *Operationalises `SECP-BR-015`; the same distinction `MP-NFR-09` draws.*

`SECP-XC-028` — Part 5 **MUST NOT** define a dashboard, metric name, query, retention period, log format, storage
layout, alert channel or on-call rota. *Owner: OBSERVABILITY platform (`SECP-OWN-022`); retention of audit content is
`BC-24`'s.*

---

## 6. Alert severity, alerts and escalation

### 6.1 The constraint that shapes this section

EA L1897-1985 tags OBSERVABILITY `Alerting` **V2** and `Incident Management` **V3** (`Runbooks` **V2**). Yet
`PRD-001` — **Rank 3, `FROZEN`** — states three **alertability** obligations at V1: `AUTH-11.26` (a sustained rise
MUST be alertable), `AUTH-11.27` (any cross-tenant attempt, immediately, no threshold), `AUTH-11.28` (any session
binding violation, immediately, no threshold).

These are not reconcilable by inference, so the conflict is **raised, not chosen** —
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) **L253**: *"A conflict is a defect. If
you find one, do not choose — raise it."*

`SECP-GAP-031` — **Rank 3 requires alertability; EA tags the alerting capability V2.** `AUTH-11.26`, `AUTH-11.27` and
`AUTH-11.28` are frozen Rank 3 requirements using the word *alertable*. EA's `Alerting` node is **V2**. Part 5
therefore requires that the **signals** exist and are severity-classified at V1 (`SECP-FR-047`, `SECP-FR-055`) —
which is what makes alerting possible — and **does not** require an alert-delivery capability, which it has no
authority to promote. The stated consequence: at V1 a cross-tenant attempt is **emitted and recorded immediately** but
may not be **delivered to a human immediately**. **Priority: High.** *Routed to the Architecture Owner in Part 8.
Rank 3 outranks Rank 6, so the likely resolution is an EA correction rather than a PRD change — but that
determination is the Architecture Owner's, not this document's, and Part 5 does not pre-empt it.*

### 6.2 Severity classes

`SECP-FR-055` — Every emitted signal **SHALL** carry exactly one severity class from `SECP-SEV-001`…`004`, assigned by
the mapping below rather than at emission time by the emitter's discretion. *A fixed mapping is testable; a
discretionary one is not — `PRD_LIFECYCLE.md` Stage 4 rejects the unverifiable.*

| ID | Class | Meaning | Signals | Response expectation |
|---|---|---|---|---|
| `SECP-SEV-001` | **Critical** | Realises a Rank 1 Critical risk, or indicates isolation failure | `SECP-SIG-001`, `SECP-SIG-010` | Immediate, no threshold — `AUTH-11.27`; `MP-RSK-01`; `X-13` |
| `SECP-SEV-002` | **High** | Indicates compromise or a privileged-path anomaly | `SECP-SIG-002`, `SECP-SIG-006`, `SECP-SIG-007` | Immediate, no threshold — `AUTH-11.28` |
| `SECP-SEV-003` | **Medium** | Indicates abuse in progress, bounded by an existing control | `SECP-SIG-003`, `SECP-SIG-004`, `SECP-SIG-005` | Threshold-based — `AUTH-11.26` (*sustained* rise) |
| `SECP-SEV-004` | **Low** | Indicates a control operating as designed under adverse conditions | `SECP-SIG-008`, `SECP-SIG-009` | Aggregate review; a **rise** in these is itself `SECP-SEV-003` |

`SECP-FR-056` — `SECP-SEV-001` and `SECP-SEV-002` **SHALL** be emitted without threshold, aggregation delay or
sampling, and **SHALL NOT** be batched, deduplicated into a count, or suppressed as noise. *Directly grounded in
`AUTH-11.27` and `AUTH-11.28`'s "immediately, with no threshold."*

`SECP-FR-057` — Escalation **SHALL** be determined by severity class and **SHALL NOT** depend on which component
emitted the signal, which tenant it concerns, or the time of day. *Prevents severity being renegotiated downstream.
The response lifecycle that consumes escalation is Part 6's, not Part 5's.*

`SECP-XC-029` — Part 5 **MUST NOT** own alert routing, notification delivery, on-call scheduling, escalation-policy
configuration, paging or incident tooling. `BC-22` Notification Delivery owns delivery; OBSERVABILITY owns alerting at
**V2**; `Incident Management` is **V3**. Part 5 owns only signal identity, severity assignment, and the rule that
severity is not renegotiated. *Owner: OBSERVABILITY platform (V2); `BC-22` for delivery.*

---

## 7. Acceptance criteria

| ID | Criterion | Binds |
|---|---|---|
| `SECP-AC-077` | The emitted signal set equals `SECP-SIG-001`…`010` exactly; no signal outside the register is emitted, and each register member has an emitting condition or a recorded gap | `SECP-FR-047`, `SECP-BR-016` |
| `SECP-AC-078` | Each of the ten signals is inspected and contains no personal data, no credential, no session identifier; tenant attribution is present wherever a tenant is in scope | `SECP-FR-047`, `SECP-FR-053` |
| `SECP-AC-079` | For each of the ten signals, emission is observed in the same execution path as the refusal or completion it describes; no signal requires a batch or scheduled job to exist | `SECP-FR-048` |
| `SECP-AC-080` | An attempt to suppress, filter or disable signal emission as `PR-1` Platform Administrator fails, and the signal is still emitted | `SECP-FR-049` |
| `SECP-AC-081` | A brute-force sequence refused throughout still produces `SECP-SIG-003`, `SECP-SIG-004` and `SECP-SIG-005` as their conditions arise; no refused-but-silent case exists | `SECP-FR-050`, `SECP-BR-017` |
| `SECP-AC-082` | An abuse sequence distributed across identifiers is visible in the origin aggregation, and one distributed across origins is visible in the identifier aggregation; both views are populated | `SECP-FR-051` |
| `SECP-AC-083` | For each of the ten signals a count over a stated window is producible; the number of signals for which no count is producible is zero | `SECP-FR-052` |
| `SECP-AC-084` | Monitoring surfaces are inspected for personal data, credentials, session identifiers and individual attribution; all four absent, tenant attribution present | `SECP-FR-053` |
| `SECP-AC-085` | No dashboard, report, acceptance record or status summary presents a §2-excluded capability as though it reported "none detected"; a review finds zero such presentations | `SECP-BR-015`, `SECP-FR-054` |
| `SECP-AC-086` | A period with no signals is reported as "nothing observed" unless a live verification of the emission path occurred in that period, in which case the verification is cited | `SECP-FR-054` |
| `SECP-AC-087` | Every emitted signal carries exactly one severity class matching §6.2's mapping in every sampled case; no emitter-chosen class is observed | `SECP-FR-055` |
| `SECP-AC-088` | A single `SECP-SEV-001` and a single `SECP-SEV-002` occurrence each emit end to end without threshold, batching, deduplication into a count, or suppression | `SECP-FR-056` |
| `SECP-AC-089` | The same severity class produces the same escalation across four variations — emitting component, tenant, time of day, and signal within the class | `SECP-FR-057` |
| `SECP-AC-090` | Part 5 declares no dashboard, metric name, query, retention period, log format, alert channel, on-call rota, domain event, or detection capability EA tags V2/V3; a search returns none | `SECP-XC-027`, `SECP-XC-028`, `SECP-XC-029`, `SECP-OWN-022`, `SECP-OWN-023` |

### 7.1 Coverage table

| Requirement | Criterion | Requirement | Criterion |
|---|---|---|---|
| `SECP-FR-047` | `AC-077`, `AC-078` | `SECP-FR-053` | `AC-078`, `AC-084` |
| `SECP-FR-048` | `AC-079` | `SECP-FR-054` | `AC-085`, `AC-086` |
| `SECP-FR-049` | `AC-080` | `SECP-FR-055` | `AC-087` |
| `SECP-FR-050` | `AC-081` | `SECP-FR-056` | `AC-088` |
| `SECP-FR-051` | `AC-082` | `SECP-FR-057` | `AC-089` |
| `SECP-FR-052` | `AC-083` | `SECP-BR-015` | `AC-085` |
| `SECP-BR-016` | `AC-077` | `SECP-BR-017` | `AC-081` |
| `SECP-XC-027` | `AC-090` | `SECP-XC-028` | `AC-090` |
| `SECP-XC-029` | `AC-090` | `SECP-OWN-022`, `SECP-OWN-023` | `AC-090` |
| `SECP-SIG-001`…`010` | `AC-077`, `AC-078`, `AC-079`, `AC-083`, `AC-087` | `SECP-SEV-001`…`004` | `AC-087`, `AC-088`, `AC-089` |

**11 `SECP-FR-*`, 3 `SECP-BR-*`, 3 `SECP-XC-*` and 2 `SECP-OWN-*` are declared in Part 5; all 19 are bound above. All
10 `SECP-SIG-*` and all 4 `SECP-SEV-*` register entries are bound by at least one criterion. Uncovered: none.**

---

## 8. Gaps declared in Part 5

| ID | Gap | Priority | Blocked by |
|---|---|---|---|
| `SECP-GAP-028` | V1 detects volume, not anomaly; `Anomaly Detection` is EA **V2**. Low-and-slow attacks under every threshold are invisible | Medium | EA L2020 version tag |
| `SECP-GAP-029` | V1 cannot detect account takeover; `Account Takeover Detection` is EA **V3**, while `ADR-0002` names SIM-swap as the sole factor's own defeat. V1 relies on user notification, not platform detection | **High** | EA version tag; `MP-CON-11`/`MP-GBR-25` place the factor outside this PRD |
| `SECP-GAP-030` | V1 has no correlation across signal sources; `SIEM Integration` is EA **V3**. Part 6 responds to individual signals, not a correlated picture | Medium | EA version tag |
| `SECP-GAP-031` | **Rank 3 `AUTH-11.26`/`11.27`/`11.28` require alertability; EA tags `Alerting` V2.** V1 emits and records immediately but may not deliver to a human immediately | **High** | Rank 3 / Rank 6 conflict — Architecture Owner's to resolve |

---

## 9. Lifecycle status

**Stage 2 (Draft).** File on disk; versioned header; registers declared with contiguous ranges; **two new prefixes
collision-checked before writing** per `PRD_LIFECYCLE.md` §5 rule 2, with the broad-probe method and the
`SECP-SEV-`/`SEV-nn` confusability recorded in §0.4; normative language defined in §0.1.

Stage 1's gate remains unmet and is **disclosed rather than claimed** — it requires *"a context identified in the
Bounded Context Map, not already owned"*, and the SECURITY platform holds no `BC-nn` (Part 1 §0.5; `SECP-GAP-010`).
Authority to proceed is [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.1's standing
authorisation. Stage 5 is not started: `SECP-`, `SECP-SIG-` and `SECP-SEV-` are **not** registered in
`TRACEABILITY_MATRIX.md`. **Freeze is conferred, not claimed.**

> ⚠ **Note on the `Written at` header cell.** Parts 3 and 4 were committed by the platform's automated backup as
> `12a55db` before this Part was authored, so the commit message on that milestone is generic rather than descriptive.
> The commit was verified to contain exactly the two intended files and no others, and was **accepted rather than
> amended**, because rewriting history is prohibited. Part 8 §11 records the same fact for the record.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v0.5 | 2026-08-21 | Part 5 created. 51 identifiers: `SECP-FR-047`…`057`, `SECP-BR-015`…`017`, `SECP-XC-027`…`029`, `SECP-OWN-022`…`023`, `SECP-AC-077`…`090`, `SECP-GAP-028`…`031`, plus two new registers `SECP-SIG-001`…`010` and `SECP-SEV-001`…`004`, both broad-probe collision-checked before writing (§0.4). `Brute Force Protection` treated as the **only V1** member of EA's Threat Detection subtree; anomaly, bot, takeover, SIEM and posture detection held at **V2/V3** (`SECP-XC-027`, `SECP-GAP-028`…`030`). `PRD-001` §8's brute-force and rate-limit rules **cited, never restated** (`SECP-OWN-019` governs). The Rank 3 alertability / EA-V2 `Alerting` conflict recorded as `SECP-GAP-031` and **not resolved** — raised per `DOCUMENTATION_BASELINE.md` L253. `SECP-BR-015` forbids reporting an absent detection as "none detected". No `SECP-EVT-*` register minted; domain events left to `BC-18`/`BC-10` (`SECP-OWN-023`). No identifier from Parts 1–4 renumbered, reworded or withdrawn. |
