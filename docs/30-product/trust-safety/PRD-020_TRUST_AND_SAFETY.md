# PRD-020 — Trust & Safety, Privacy, Abuse Prevention & Moderation

| Field | Value |
|---|---|
| **PRD** | `PRD-020` |
| **Name** | Trust & Safety |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 2**. ⚠ **This document confers no status on itself** |
| **Owning bounded context** | **`BC-13` Trust & Safety** — `[CORE]` ⚠, `Global Student` platform, **V1**. Bounded Context Map **L117** |
| **Owned aggregate** | **`ModerationCase`** — *already declared* by the Rank 4 BC Map **L379**. This PRD **adopts** it; it does not invent it |
| **Module path** | `domain/social` → context `safety`, rank **8** — [`tool/module_dependencies.yaml`](../../../tool/module_dependencies.yaml) **L229**/**L233** |
| **Requirement prefix** | **`TSF-`** — collision-tested against every existing register: **0 occurrences**. `SAF-`, `TS-`, `TAS-` also 0; `TSF-` chosen for legibility |
| **⛔ Prefix explicitly NOT used** | **`SEV-`** — already held **twice**: `PRD-003`'s **closed** `SEV-1`…`16` domain-event register (`PRD_LIFECYCLE.md` §5 rule 6) and `PRD-012a`'s severity register. Per §5 rule 3, *"on collision, change the new prefix, never the existing one."* Also **not** `SEC-` (collides `INV-SEC-*`, per `PRD-012a` §0.4) |
| **Implementation task range** | **`IMPL-1400`…`1449`**, with `1450`…`1499` reserved. Measured free: [`PRD-012a_IMPLEMENTATION_TASKS.md`](../../40-implementation/security/PRD-012a_IMPLEMENTATION_TASKS.md) **L140** records *"`IMPL-1400` + | Unallocated"* |
| **Product version** | **V1** |
| **Lifecycle stage** | **Stage 2 of 9 — Draft.** Stages 3–9 **not started** |
| **Rank** | **Unranked.** No [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 row exists for this document. It is **not** Rank 3 and **must not be cited as authority against any ranked document** |
| **Registry status** | **`PLANNED`** in `PRD_REGISTRY.md` §4.2 at the time of writing. ⚠ Opening this document has a registry consequence **this document does not execute** — see §0.6 |
| **Authorities applied** | `MASTER_PRD.md` (Rank 1) · `ADR-0011`, `ADR-0013`, `ADR-0014`, `ADR-0016`, `ADR-0055`, `ADR-0059` (Rank 2) · `PRD-001` v2.0, `PRD-002` v1.0, `PRD-003` v1.0, `PRD-013`, `PRD-016`, `PRD-017` v0.2 — all `FROZEN` (Rank 3) · Bounded Context Map **v1.8**, Module Dependency Matrix (Rank 4) · `ARCHITECTURE_RULINGS.md` (Rank 5) |
| **Date** | 2026-08-22 |
| **Written at** | `9226f86` |

---

## 0. How to read this document

### 0.1 Normative language

**MUST**, **MUST NOT**, **SHALL**, **SHALL NOT** are binding. **SHOULD** is a strong default requiring a recorded
reason to depart from. **MAY** is genuinely optional. A **directional principle** is not normative and carries no
V1 obligation; every instance is marked.

### 0.2 Declared registers and ranges

Published up front as a promise, per Stage 2's gate and the `Student_Identity_PRD_v1.md` §0 precedent.

| Register | Meaning | Range | Count |
|---|---|---|---|
| `TSF-FR-nnn` | Functional requirement | `001`…`118` | 118 |
| `TSF-BR-nnn` | Business rule | `001`…`038` | 38 |
| `TSF-XC-nnn` | Exclusion / negative constraint | `001`…`031` | 31 |
| `TSF-INV-nnn` | Invariant enforced inside the aggregate | `001`…`016` | 16 |
| `TSF-EVT-nnn` | Published domain event | `001`…`002` | **2** |
| `TSF-CFG-nnn` | Configurable | `001`…`021` | 21 |
| `TSF-AC-nnn` | Acceptance criterion | `001`…`062` | 62 |
| `TSF-GAP-nnn` | Open gap blocking implementation | `001`…`014` | 14 |
| `TSF-RSK-nnn` | Risk | `001`…`012` | 12 |
| | | **Total** | **314** |

⚠ **`TSF-EVT-*` is deliberately only TWO members, and that is a measurement, not an omission.**
BC Map §9 (**L432**, **L433**) publishes exactly two `BC-13` events — `safety.AbuseReportFiled` and
`safety.EnforcementActionTaken`. §7's rule is that an integration surface not in the register does not exist.
A third event is a **Rank 4 amendment requiring an ADR**, so no third event was invented. See `TSF-GAP-004`.

### 0.3 What this document is not

It is **not** a specification of the social graph, of messaging, of community content, of authentication, of file
storage, of audit or of security. Each has an owner, and §6 names them. Where a safety outcome requires behaviour
inside another context, this PRD states the **obligation and the transport**, never the other context's internals.

### 0.4 Six findings that constrain this document

Established by measurement before drafting. Each is carried into §29 as an ADR requirement.

| # | Finding | Consequence |
|---|---|---|
| **F-1** | **`BC-13` may not hold `tenantId`.** BC Map **L488**: `BC-11`→`17` are *"Global. No `tenantId`. Keyed on `PersonId`. Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)"*. `module_dependencies.yaml` **L266–267** bans the **symbols** `StudentRecordId` and `TenantId` in `domain/social`, with `use_instead: "nothing — social data is not tenant-scoped"` | **Library-scoped moderation as requested cannot be built in `BC-13`.** §18 and `TSF-GAP-001` |
| **F-2** | **`X-05` is Separate Ways.** Matrix **L354**: Library Management ⟷ `BC-11`…`BC-17` — *"Merges two tenancy models and two privacy regimes"*; the only bridge is `PersonId` via the `E-13` ACL | **A Library Owner console may not read `BC-13`.** §18, `TSF-GAP-002` |
| **F-3** | **`BC-13` has exactly ONE edge, and it is outbound.** `E-14` (BC Map **L318**), event-only, to `BC-11`/`BC-12`/`BC-14`/`BC-15`. There is **no inbound edge and no port** | **T&S has no read path into reported content.** §12, `TSF-GAP-003` |
| **F-4** | **`BC-13` is deliberately NOT an `E-22` consumer.** BC Map **L331**; refused per-context by `ADR-0055` §3 and made **executable** by `ADR-0059` — the `files` port refuses callers outside the four-context list | **T&S may not hold a `FileRef` or read bytes.** §13, `TSF-GAP-005` |
| **F-5** | **`BC-14` and `BC-15` are V2.** BC Map **L118**, **L119**. Content Sharing and Community & Groups have no PRD and are `PLANNED` V2 (`PRD_REGISTRY.md` **L391**) | **Community-post moderation is not V1 work** — there are no V1 posts to moderate. §25, `TSF-GAP-006` |
| **F-6** | **Block and rate limiting are already owned.** BC Map **L115**/**L377**: `BC-11` owns *"blocks, rate limits on graph mutation"*, aggregate `BlockList`, entity `RateLimitCounter`. `E-16` (**L320**): *"block enforcement lives in the graph"* | **T&S does not own Block, Mute or graph rate limits.** §6, `TSF-XC-004`…`006` |

### 0.5 The one pre-ratified synchronous rule

BC Map **L468** already decides the hardest consistency question in this domain, and this PRD adopts it verbatim
rather than restating it as a new requirement:

> *"Ban a user | `BC-13`, then `BC-10`/`11`/`12`/`14`/`15` | **Eventual** | `EnforcementActionTaken` fan-out.
> **Messaging must additionally check enforcement state at send time** — eventual consistency is unacceptable for
> abuse containment, so this path is belt-and-braces."*

This is also one of the three mitigations `MP-RSK-02` names. §5 and §11 build on it; they do not reinterpret it.

### 0.6 The registry consequence this document does not execute

`PRD_REGISTRY.md` §4.2 records `PRD-020` as **`PLANNED`**. §2.1 of that register holds that status is *conferred by
the baseline row, not read off the PRD*. Writing this file satisfies Stage 2's evidence test (*"a document on disk
with a version header"*), which would move the row `PLANNED` → `DRAFT`.

⛔ **This document does not make that edit.** Amending `PRD_REGISTRY.md` is a **Governance Owner** act. The
consequence is recorded here and routed as `TSF-GAP-013`. The same applies to `PRD_OWNERSHIP_MODEL.md` **L202**,
`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L152** and `PRD_DEPENDENCY_GRAPH.md` **D-16**, all of which describe
`PRD-020` as unwritten. **No existing repository file was modified to produce this PRD.**

---

## 1. Executive Summary

`BC-13` Trust & Safety is the only bounded context in LIBOORA classified `[CORE]` while living in a Supporting
platform. The BC Map states the reason at **L117**: *"on a minor-heavy product this is existential legal risk,
not a commodity."* `MP-RSK-02` — *"Minor-safety incident on the social product"* — is rated **Critical**, and its
stated mitigation is *"`BC-13` Trust & Safety at V1"*. Until this document exists, that mitigation is a bounded
context with no specification, no tasks and no owner. `PRD_REGISTRY.md` **L323** calls it *"the highest unmitigated
product risk in the register."*

This PRD specifies the V1 system that closes it: a **report → case → decision → enforcement → appeal** pipeline
with an append-only evidence chain, a transparent rule-based risk layer, and a deterministic strike ladder.

**What makes this design different from the request that produced it** is that four requested capabilities were
measured against the Rank 4 architecture and found to be **owned elsewhere or structurally prohibited**. They are
not silently dropped and not silently taken: Block and Mute stay with `BC-11`; virus scanning stays with `BC-29`;
the immutable audit record stays with `BC-24`; and **library-scoped moderation is named as the central unresolved
architectural decision** (`TSF-GAP-001`/`002`), because building it inside `BC-13` would require that context to
hold a `tenantId` the Rank 4 register and the machine-enforced manifest both forbid.

**V1 delivers:** user reporting across five reportable subject types; a single-aggregate moderation case with a
lifecycle of seven states; nine graduated enforcement actions; a deterministic strike ladder; appeals decided by a
different actor than the enforcer; a rule-based risk layer that **advises and never auto-decides irreversibly**;
minor-safety escalation; and the synchronous send-time enforcement check `MP-RSK-02` requires.

**V1 explicitly does not deliver** ML/AI moderation, graph-based coordinated-abuse detection, community-post
moderation (no V1 posts exist), or a library-administrator console (architecturally blocked).

---

## 2. Problem & Goals

### 2.1 Problem

LIBOORA is shipping a global student social surface — profiles (`BC-10`, `IMPLEMENTING`), a social graph and
messaging (`BC-11`/`BC-12`, V1, unwritten) — to a population that is **substantially minors**. `MP-GBR-05` and
`ID-6` both require a guardian consent record before any social context activates, which is an admission in the
architecture's own language that the platform expects minor users.

Three properties make this urgent rather than important:

1. **The blast radius is legal, not commercial.** A minor-safety incident is not a churn event.
2. **The mitigation is sequenced last.** `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L152** places `PRD-020` in Wave 4,
   and **L155** concedes *"that is a decision with a cost."*
3. **The dependent ships alongside it.** **L161**: *"`PRD-021` must not ship before `PRD-020`"*; **L164**: *"If
   `PRD-021` slips ahead of `PRD-020`, that is a release-blocking defect, not a schedule change."*

### 2.2 Goals

| ID | Goal | Measured by |
|---|---|---|
| `G-1` | Every user can report abuse against a person, a message, a profile, a file reference or a community object, from the surface where they encountered it | `TSF-AC-001`…`008` |
| `G-2` | Every enforcement action is traceable to a case, a named actor and a stated reason | `TSF-INV-001`, `TSF-AC-020` |
| `G-3` | Strikes escalate deterministically — the same history yields the same next action | `TSF-INV-005`, `TSF-AC-030` |
| `G-4` | An appeal is never decided by the actor who enforced | `TSF-INV-006`, `TSF-AC-041` |
| `G-5` | A suspended person cannot send a message, even before the enforcement event has propagated | `TSF-AC-025`, BC Map **L468** |
| `G-6` | A minor-safety report reaches a human within its SLA regardless of queue depth | `TSF-AC-014`, `TSF-CFG-005` |
| `G-7` | No safety decision is made irreversibly by an automated score alone | `TSF-BR-021`, `TSF-XC-014` |
| `G-8` | A false positive is recoverable, measurable and does not accumulate as a strike | `TSF-BR-026`, `TSF-AC-055` |

### 2.3 Non-functional targets

| ID | Requirement |
|---|---|
| `TSF-FR-001` | The send-time enforcement check (§11.4) **MUST** answer within **50 ms at p99** and **MUST fail closed** — an unavailable check denies the send |
| `TSF-FR-002` | Report submission **MUST** be accepted and acknowledged within **1 s at p95**; triage is asynchronous |
| `TSF-FR-003` | `safety.EnforcementActionTaken` **MUST** be published within **5 s at p95** of the decision committing |
| `TSF-FR-004` | The moderation queue **MUST** remain answerable at **10,000 open cases** without degrading `TSF-FR-001` |

---

## 3. Non-Goals

Stated as exclusions so that a later reader does not "fix" them.

| ID | Non-goal | Why |
|---|---|---|
| `TSF-XC-001` | This PRD does **not** own identity, username, profile or profile privacy | `BC-10` / `PRD-003` `IMPLEMENTING`. `SID-*` governs |
| `TSF-XC-002` | Does **not** own credentials, sessions, OTP, roles, permissions or consent | `BC-18` / `PRD-001` `FROZEN`. Rule `ID-1`: *"No context outside `BC-18` may store a password, OTP, session or credential"* |
| `TSF-XC-003` | Does **not** own friendship, follow or the social graph | `BC-11` / `PRD-021` |
| `TSF-XC-004` | Does **not** own **Block** | BC Map **L377** aggregate `BlockList` is `BC-11`'s; **L320** `E-16`: *"block enforcement lives in the graph"* |
| `TSF-XC-005` | Does **not** own **Mute** | Same owner as Block — a unilateral graph-visibility preference, not a safety decision |
| `TSF-XC-006` | Does **not** own graph or messaging **rate limits** | BC Map **L115**, **L377** `RateLimitCounter` — `BC-11` |
| `TSF-XC-007` | Does **not** own conversations, messages, delivery or presence | `BC-12` |
| `TSF-XC-008` | Does **not** own posts, comments or community membership | `BC-14`/`BC-15`, **both V2** (`F-5`) |
| `TSF-XC-009` | Does **not** own file storage, upload, signed URLs or **virus scanning** | `BC-29` / `PRD-017` `FROZEN` — BC Map **L139** assigns *"upload, virus scan, thumbnailing, signed URLs"* |
| `TSF-XC-010` | Does **not** own the immutable audit record | `BC-24` / `PRD-016` `FROZEN`, which owns exactly one aggregate `AuditEntry`. T&S **emits** via `E-20` |
| `TSF-XC-011` | Does **not** own notification channel, template, quiet hours, dedup or unsubscribe | `BC-22`; `MP-GBR-35` |
| `TSF-XC-012` | Does **not** own WAF, DDoS, TLS, secrets, PII redaction gateway or vulnerability management | `platform/security` rank 2 / `PRD-012a`; §22 draws the line |
| `TSF-XC-013` | Does **not** own library membership status | `BC-02` / `PRD-005` |
| `TSF-XC-014` | Does **not** permit an automated score to execute an irreversible enforcement action in V1 | §14.6; `G-7` |
| `TSF-XC-015` | Does **not** implement ML/AI classification in V1 | §25 |
| `TSF-XC-016` | Does **not** grant `BC-13` read access to message bodies at rest | §12.3; privacy posture |
| `TSF-XC-017` | Does **not** introduce a fourth authorization scope | `MP-GBR-21`: the register `self`, `guardianOf`, `tenantWide` is **closed** without an ADR |
| `TSF-XC-018` | Does **not** create a Library Administrator moderation console in V1 | Blocked by `F-1`/`F-2`; `TSF-GAP-001`/`002` |

---

## 4. Personas

| Persona | Identity key | Reaches T&S how | May **not** |
|---|---|---|---|
| **Student (adult)** | `PersonId` | Files reports; receives notices; submits appeals | See another person's report, case or strike history |
| **Student (minor)** | `PersonId` + guardian consent record in `BC-18` (`ID-6`) | Same, with escalated routing (§17.4) | — |
| **Guardian** | `Account` with `guardianOf` scope (`MP-GBR-21`) | Receives notices about the minor's enforcement; may appeal on their behalf | Read the minor's message content through a safety surface (`TSF-XC-016`) |
| **Platform Safety Moderator** | `Account` + platform role in `BC-18` | Full queue, case, evidence, enforcement, appeal | Decide an appeal on a case they enforced (`TSF-INV-006`) |
| **Platform Safety Lead** | `Account` + platform role | Escalations, permanent termination, policy versions | Author and approve the same policy version (`TSF-INV-013`) |
| **Library Owner / Manager / Staff** | `Account` + tenant role, `StudentRecordId` domain | ⛔ **No V1 path.** See §18.3 | Read any `BC-13` object — `X-05`, `F-2` |
| **Automated risk evaluator** | System actor | Produces advisory signals and scores | Execute an irreversible action (`TSF-XC-014`) |

⚠ **The Library Owner row is the honest answer, not a design omission.** The requested capability is real and
wanted; §18.3 sets out three routes to it and names the authority that must choose.

---

## 5. Threat / Safety Model

### 5.1 Actors and motivations

| Threat actor | Objective | Primary surface |
|---|---|---|
| Peer harasser | Distress a specific known person | Messaging, comments |
| Bulk spammer | Reach many people cheaply | Friend requests, message requests |
| Scammer | Extract money or credentials | Messaging, links |
| Impersonator | Borrow trust of a person or a library | Profile, username, official posts |
| Predatory adult | Contact minors | Discovery → request → messaging |
| Block evader | Re-reach a person who refused them | New account, secondary identity |
| Coordinated group | Mass-report a target, or amplify content | Reporting system itself, graph |
| Compromised account | Use a real identity's trust | Any authenticated surface |
| **Malicious moderator** | Abuse privileged access | The console itself |

⚠ The last row is a first-class threat. §19.4 treats moderator access as an audited action, not a trusted one.

### 5.2 The reporting system as an attack surface

`TSF-BR-010` A report is an **accusation, not a finding**. Mass-reporting a target **MUST NOT** by volume alone
produce an enforcement action — see `TSF-BR-011` (deduplication) and `TSF-BR-024` (reporter-reputation weighting).
This inverts the naive design in which report count drives action, which is precisely the coordinated-abuse
primitive.

### 5.3 Grooming-risk indicator posture

`TSF-FR-005` The platform **MUST** evaluate *unsafe contact patterns* — an adult-classified account initiating
contact with multiple minor-classified accounts who share no graph proximity — as a **risk signal routed to human
review**, never as an automated determination.

`TSF-XC-019` The platform **MUST NOT** infer, store or display any inference about a person's intent, sexuality or
relationships. Age band and contact topology are the only inputs. This is a deliberate ceiling on how much this
system is permitted to know.

`TSF-GAP-014` **OPEN** — age band for a `PersonId` is derived from `BC-18`'s consent state (`ID-6`), and no
authority specifies an accessor for it. Owner: `BC-18` owner with `BC-13` owner.

### 5.4 Trust boundaries

```
Client ──┬─> BC-18 Authn/Authz ──> the actor is known
         │
         ├─> BC-11 graph          ── eligibility, block, rate limit  (owner: PRD-021)
         │
         ├─> BC-12 messaging      ── send path, MUST call §11.4      (owner: PRD-021)
         │
         └─> BC-13 safety         ── report intake, case, decision   (THIS PRD)
                    │
                    ├── E-14 event ──> BC-11, BC-12, BC-14, BC-15   self-restrict
                    ├── E-20 event ──> BC-24 audit                  immutable record
                    └── E-23 event ──> BC-22 notification           notices
```

`TSF-XC-020` `BC-13` **MUST NOT** appear upstream of authentication or authorization. A safety check is never a
substitute for an access decision.

---

## 6. Architecture & Ownership

### 6.1 The pipeline

Requested in the task as *User Action → Auth → Safety → Allow/Restrict/Review/Block → Audit → Monitoring*. Rendered
against the measured architecture:

```
  User action
      │
  [1] BC-18  Authentication            — is the actor who they claim?          (ID-1)
      │
  [2] BC-18  Authorization             — may this actor do this at all?        (MP-GBR-21/22)
      │
  [3] BC-11  Eligibility + block       — is the counterparty reachable?        (E-16)
      │
  [4] BC-13  Enforcement state check   — is the actor restricted right now?    (§11.4, SYNCHRONOUS)
      │
      ├── DENY ──────────────────────> indistinguishable-from-not-found where required (MP-GBR-22)
      │
  [5] execute in the owning context    — BC-12 sends, BC-15 posts, …
      │
  [6] E-20 ──> BC-24 audit             — append-only, fire-and-forget, outbox-backed
      │
  [7] async: risk signals ──> BC-13    — advisory only (§14)
```

`TSF-BR-001` Steps 1–4 are **strictly ordered** and step 4 **MUST NOT** precede step 2. A safety check that runs
before authorization leaks the existence of objects to unauthorized callers.

`TSF-BR-002` Step 4 is the **only** synchronous obligation `BC-13` places on another context. Everything else T&S
does is asynchronous and event-driven, which is what keeps `E-14` acyclic — BC Map **L286**: *"T&S publishes
`EnforcementActionTaken` events and other contexts subscribe and self-restrict. **T&S never reaches into their
models.**"*

### 6.2 Synchronous vs asynchronous — the decision table

| Action | Check timing | Why | Authority |
|---|---|---|---|
| Send a message | **Synchronous** enforcement-state check | *"Eventual consistency is unacceptable for abuse containment"* | BC Map **L468** |
| Send a message request to a non-friend | **Synchronous** eligibility + enforcement | Same, plus `E-16` `canMessage` | **L320**, **L468** |
| Create a friend/follow request | **Synchronous** enforcement; rate limit in `BC-11` | Cheap check, high abuse value | `F-6` |
| Change username or display name | **Synchronous** enforcement | Impersonation vector; §7.6 | This PRD |
| Appear in discovery results | **Synchronous** filter at query time | A suspended person must not surface | §8.3 |
| Publish a community post *(V2)* | **Synchronous** enforcement, **asynchronous** content review | Removal is reversible; blocking publication is not | §9 |
| Upload a file reference | **Asynchronous** — `BC-29` scans (`TSF-XC-009`) | T&S has no byte access (`F-4`) | `ADR-0059` |
| Score risk | **Asynchronous**, always | Advisory (`TSF-XC-014`) | §14 |
| Enforce a decision | **Synchronous** commit, **asynchronous** fan-out | One transaction, then `E-14` | BC Map **L468** |

`TSF-BR-003` **Reversibility decides the timing.** An action whose harm is undoable (removing a post) may be
reviewed after the fact. An action whose harm is not undoable (delivering a threat to a minor, letting a suspended
adult open a new conversation) **MUST** be checked before execution.

### 6.3 Ownership map — what T&S owns, and what it must never own

| Concern | Owner | `BC-13`'s relationship |
|---|---|---|
| Safety **policy** — the versioned rule text | **`BC-13`** | Owns |
| Abuse **report** | **`BC-13`** | Owns |
| Moderation **case** | **`BC-13`** | Owns — the aggregate |
| **Evidence** snapshot | **`BC-13`** | Owns the *snapshot and its hash*, never the live object |
| **Decision** and **enforcement action** | **`BC-13`** | Owns |
| **Strike** ledger | **`BC-13`** | Owns |
| **Appeal** | **`BC-13`** | Owns |
| Risk **signal** / **assessment** | **`BC-13`** | Owns |
| Person identity, username, profile privacy | `BC-10` | Consumes `identity.Person*` events |
| Block, mute, graph rate limit, `canMessage` | `BC-11` | Publishes to it (`E-14`); **never writes it** |
| Message store, delivery | `BC-12` | Publishes to it; consumes `messaging.MessageSent` **sampling only** (BC Map **L431**) |
| Posts, comments, community roles | `BC-14`/`BC-15` (V2) | Publishes to it |
| File bytes, virus scan, signed URL | `BC-29` | ⛔ **No edge** (`F-4`) |
| Immutable audit record | `BC-24` | Emits via `E-20` |
| Notification delivery | `BC-22` | Emits via `E-23` |
| Credentials, session revocation, roles, consent | `BC-18` | Requests via §7.3 |
| Tenant record, tenant context | `BC-19` | ⛔ **Must not carry `tenantId`** (`F-1`) |

`TSF-XC-021` `BC-13` **MUST NOT** write into `BC-10`, `BC-11`, `BC-12`, `BC-14` or `BC-15`. Restriction is achieved
by those contexts **self-restricting** on `E-14`. Any design in which T&S mutates a peer's model is a defect,
regardless of how convenient it is.

### 6.4 Aggregate boundary — one, not eleven

BC Map §8 fixes the rule: *"The aggregate is the transaction boundary — one aggregate, one database transaction,
no exceptions."* **L379** already declares `BC-13`'s:

> `ModerationCase` — key entities `AbuseReport`, `EnforcementAction`, `StrikeRecord`, `Appeal`.

The task requested eleven top-level entities. Modelling eleven aggregates would break the Rank 4 rule. §20 therefore
places `AbuseReport`, `Evidence`, `EnforcementAction`, `Appeal` and `StrikeRecord` **inside** the `ModerationCase`
boundary, and models `RiskSignal`, `RiskAssessment`, `SafetyPolicy` and `UserRestriction` as **separate stores
outside it** — three read models and one policy register — with their transactional independence justified per row.

`TSF-INV-001` Every `EnforcementAction` **MUST** belong to exactly one `ModerationCase`, carry an `actorId` and a
non-empty `reasonCode`. *(BC Map **L379** invariant, adopted verbatim.)*

### 6.5 Naming — the governed collisions

BC Map §5 bans bare terms that mean different things in different contexts. Three apply here.

| Term | Collision | Required name in `BC-13` |
|---|---|---|
| **Report** | `BC-26` analytical output vs `BC-13` abuse report (**L206**) | **`AbuseReport`** — never bare `Report` |
| **Role** | `BC-18` permission bundle vs `BC-15` community role | `AccessRole` / `CommunityRole` |
| **Profile** | `BC-01` staff-visible vs `BC-10` peer-visible | `PublicProfile` when referring to `BC-10` |

`TSF-XC-022` The bare identifier `Report` **MUST NOT** appear in any cross-context contract file. The task brief
used the name `SafetyReport`; this PRD uses **`AbuseReport`** because the Rank 4 register already fixed it, and
inventing a synonym for a governed term is how a ubiquitous language decays.

---

## 7. Account & Identity Safety

⚠ **Ownership guard.** `BC-18` owns credentials, sessions, OTP and consent (`ID-1`); `BC-10` owns username and
profile. This section specifies **safety outcomes** and the **requests** T&S makes of those owners. It duplicates
neither.

### 7.1 Fake and bulk account creation

| ID | Requirement |
|---|---|
| `TSF-FR-010` | T&S **MUST** consume account-creation signals and maintain a `RiskSignal` for creation velocity per correlator (device, network, verification channel) |
| `TSF-FR-011` | On breach of `TSF-CFG-001`, T&S **MUST** open a `ModerationCase` of type `BULK_CREATION` and **MUST NOT** itself block creation |
| `TSF-FR-012` | T&S **MAY** request `BC-18` apply step-up verification; the decision and mechanism remain `BC-18`'s |
| `TSF-XC-023` | T&S **MUST NOT** store the device identifier, IP address or phone number itself. It stores a **salted correlator hash** with the retention of `TSF-CFG-014` |

`TSF-BR-004` A creation-velocity signal alone **MUST NOT** terminate an account. It is `RESTRICT`-eligible at most,
pending human review — a shared school or library Wi-Fi legitimately produces bursts, which is the exact
false-positive this rule exists to prevent.

### 7.2 Account takeover indicators

`TSF-FR-013` T&S **MUST** treat *behavioural discontinuity* — a sudden mass-messaging or mass-request burst from an
account with no such history — as a **high-confidence, low-severity** signal routed to review.

`TSF-FR-014` On a takeover-suspected case, T&S **MUST** request session revocation from `BC-18`. ⚠ `BC-18`'s
model already guarantees *"session revocation is immediate and global"* (BC Map **L380**), so T&S **requests** and
does not implement it.

`TSF-BR-005` A takeover-suspected restriction **MUST NOT** accrue a `StrikeRecord`. The account holder is the
**victim**. Recording a strike against them is a defect (`TSF-AC-056`).

### 7.3 OTP abuse

`TSF-XC-024` OTP issuance, TTL, single-use semantics and throttling are **`BC-18`'s** (`ID-1`, BC Map **L380**).
T&S **MUST NOT** implement an OTP counter.

`TSF-FR-015` T&S **MAY** consume an aggregate OTP-failure signal from `BC-18` as a risk input. `TSF-GAP-007`
**OPEN** — no such published signal exists. Owner: `BC-18` owner.

### 7.4 Impersonation of a person

`TSF-FR-016` T&S **MUST** accept an `IMPERSONATION` report against a `PersonId`, carrying the impersonated
identity as a claim.

`TSF-BR-006` An impersonation finding **MUST** be decided by a human. `TSF-XC-025` **MUST NOT** be auto-decided by
name or photo similarity — the false-positive population is *people with common names*, and misfiring here removes
a legitimate identity.

### 7.5 Impersonation of a library, owner or staff member

⚠ **This is the sharpest cross-boundary problem in the document, and it is not fully solvable in V1.**

A person can claim in a **global** `BC-10` profile to be *"Owner, Central City Library"*. Verifying that requires
reading tenant data, and `X-05` (`F-2`) forbids the social side from reaching Library Management.

| ID | Requirement |
|---|---|
| `TSF-FR-017` | T&S **MUST** accept a `LIBRARY_IMPERSONATION` report and open a case |
| `TSF-FR-018` | The V1 disposition **MUST** be *unverifiable-claim removal*: the enforcement action removes the **claim text** from the global profile via `E-14`, and asserts nothing about the underlying truth |
| `TSF-XC-026` | T&S **MUST NOT** resolve the claim by reading `BC-01`, `BC-02` or `BC-19`. That is the `X-05` prohibition and no exception is created here |
| `TSF-GAP-008` | **OPEN** — verified library affiliation needs an `E-13`-mediated attestation that does not exist. Owner: Architecture Owner with `BC-10` and `BC-19` owners |

`TSF-BR-007` Until `TSF-GAP-008` closes, LIBOORA **MUST NOT** display any affiliation claim as *verified*. An
unverified claim rendered as verified is worse than no claim, because it lends the platform's credibility to an
unchecked assertion.

### 7.6 Username abuse

`TSF-FR-019` T&S **MUST** accept reports against a username (slur, impersonating handle, targeted harassment
handle) and **MUST** be able to enforce a forced-rename via `E-14`.

`TSF-XC-027` The username uniqueness rule, format and the rename mechanism remain **`BC-10`'s** (`SID-*`, BC Map
**L376**). T&S supplies the **decision**; `BC-10` performs the change.

### 7.7 The enforcement ladder for accounts

| Level | Action | Reversible | Who may apply | Strike |
|---|---|---|---|---|
| 0 | **Warning** — notice, no capability change | Yes | Moderator | 1 |
| 1 | **Restriction** — one capability, time-boxed (§15) | Yes | Moderator | 1 |
| 2 | **Temporary suspension** — all social capability, time-boxed | Yes | Moderator | 2 |
| 3 | **Permanent termination** | ⛔ **No** | **Safety Lead only** | terminal |

`TSF-INV-002` A **permanent termination MUST NOT** be applied by an automated actor under any risk score, in V1 or
later without an ADR. *(`TSF-XC-014`, `G-7`.)*

`TSF-INV-003` A permanent termination **MUST** carry a completed human review record naming the reviewing actor,
and **MUST** be appealable at least once (§16).

`TSF-FR-020` **Reinstatement** — on a successful appeal or moderator error, T&S **MUST** publish a
`safety.EnforcementActionTaken` carrying `action = REINSTATE`, and the accrued `StrikeRecord` **MUST** be marked
`VACATED` rather than deleted (`TSF-INV-004`, and §21.4 on why nothing is deleted).

`TSF-XC-028` Termination **MUST NOT** delete the person's data as a side effect. Deletion is a **DSR** act governed
by `MP-GBR-04`/`MP-GBR-14` and `ID-5`, and conflating punishment with erasure would destroy the evidence that
justifies the punishment.

---

## 8. Social Graph & Discovery Safety

⚠ **Ownership guard.** `BC-11` owns friendship, block and graph rate limits (`F-6`); Library Discovery is a
**read composition, not a context** (ruling `AR-1`, BC Map **L86**). T&S contributes **eligibility inputs**.

### 8.1 What T&S contributes, and what it does not

| Concern | Owner |
|---|---|
| Friend-request rate limit counter and window | **`BC-11`** — `RateLimitCounter` (**L377**) |
| Block list and block semantics | **`BC-11`** — `BlockList`, *"unilateral and overrides friendship"* |
| `canMessage(a,b)` | **`BC-11`** — `E-16` (**L320**) |
| Whether a person is under a **discovery restriction** | **`BC-13`** — this PRD |
| Whether a person is **suspended or terminated** | **`BC-13`** — this PRD |
| Block-**evasion** detection across identities | **`BC-13`** — this PRD, §8.4 |

`TSF-FR-021` T&S **MUST** publish discovery-affecting state via `E-14` so `BC-11` can self-restrict.
`TSF-XC-029` T&S **MUST NOT** filter a discovery result set itself — it has no query path into the graph (`F-3`).

### 8.2 Spam and mass-connection abuse

`TSF-FR-022` T&S **MUST** maintain request-velocity and **acceptance-ratio** signals per `PersonId`.

`TSF-BR-008` **Acceptance ratio is the load-bearing signal, not volume.** A popular student sending many accepted
requests is not abusive; an account sending many *ignored or declined* requests is. Rate alone punishes popularity.

`TSF-BR-009` A **block-rate** signal — the proportion of counterparties who block after first contact — is the
strongest available V1 indicator of harassment and **MUST** be weighted above report volume, because it is a
behavioural fact rather than an accusation (§5.2).

### 8.3 The discovery safety pipeline

Requested as *Candidate → Eligibility → Privacy → Safety → Ranking → Result*. Rendered with owners:

```
  Candidate set                         BC-23 Search index (permission-aware)
      │
  [1] Eligibility     BC-11   — not blocked either direction; graph rules
      │
  [2] Privacy         BC-10   — PrivacySettings; "privacy default = most restrictive";
      │                          "minors cannot set profile to public"     (BC Map L376)
      │
  [3] Safety          BC-13   — exclude suspended / terminated / discovery-restricted   ← THIS PRD
      │
  [4] Ranking         BC-23   — relevance
      │
  Result
```

| ID | Requirement |
|---|---|
| `TSF-FR-023` | A person under `SUSPENSION`, `TERMINATION` or `DISCOVERY_RESTRICTION` **MUST NOT** appear in any discovery result, recommendation or search suggestion |
| `TSF-INV-005` | Step **[3] MUST run after [1] and [2] and MUST be non-bypassable.** A ranking or recommendation path that reaches the index without step 3 is a defect |
| `TSF-FR-024` | Exclusion **MUST** be indistinguishable from non-existence — no *"this user is suspended"* tombstone. *(`MP-GBR-22`: a denial must not disclose existence.)* |
| `TSF-XC-030` | T&S **MUST NOT** publish the *reason* for a discovery exclusion to any peer-facing surface |

`TSF-FR-025` **Recommendation manipulation** — T&S **MUST** treat reciprocal-follow rings and mass-follow-then-
unfollow as risk signals routed to review. ⚠ Graph-topology detection is **V2** (§25); V1 detects only the
per-account velocity form.

### 8.4 Block evasion

`TSF-FR-026` When a person blocked by X is followed by a **new** account contacting X within
`TSF-CFG-008`, sharing a creation correlator, T&S **MUST** raise a `BLOCK_EVASION` signal.

`TSF-BR-010` A block-evasion signal **MUST** route to human review and **MUST NOT** auto-terminate. Sibling
students on one device are a real population and a real false positive.

---

## 9. Library Community Safety

⚠⚠ **This section is constrained by finding `F-5` and it is the section that most differs from the request.**

### 9.1 The measurement

`BC-14` Content Sharing and `BC-15` Community & Groups are **V2** — BC Map **L118**, **L119**;
`PRD_REGISTRY.md` **L391** lists them *"`PLANNED` — correctly deferred."* A grep for `moderator` across
`docs/30-product/` returns **0 files**. There is no V1 community, no V1 post, no V1 comment and no
`CommunityRole` specification anywhere in the repository.

`TSF-XC-008` therefore holds: **community-post moderation is not V1 scope**, because there is nothing to moderate.

`TSF-GAP-006` **OPEN** — *"Library Community, Feed & Messaging"* was requested as an existing surface. Measured: the
messaging third exists (`BC-12`, V1); the community and feed thirds are **V2 contexts with no PRD**. Owner: Product
Owner, to decide whether `BC-15` is pulled into V1. **This PRD does not pull it in** — that is a Rank 1 scope act.

### 9.2 What V1 *does* build for community safety

Not nothing: the machinery is built now so that `BC-15` inherits it rather than reinventing it.

| ID | Requirement |
|---|---|
| `TSF-FR-027` | The `AbuseReport` subject type register **MUST** include `COMMUNITY_POST` and `COMMUNITY_COMMENT` from V1, unpopulated until `BC-15` ships |
| `TSF-FR-028` | The enforcement action register **MUST** include `COMMUNITY_RESTRICTION` and `CONTENT_REMOVAL` from V1 |
| `TSF-FR-029` | `E-14`'s consumer set **MUST** already include `BC-14` and `BC-15` — it does (BC Map **L318**), so no amendment is needed |
| `TSF-XC-031` | This PRD **MUST NOT** specify community roles, membership or post lifecycle. `CommunityRole` is `BC-15`'s (BC Map **L214**) |

### 9.3 Moderation permissions — specified, gated on §18

Requested for five actor classes. Specifiable now, but **only the first is exercisable in V1** (§18.3).

| Actor | Scope | May | May **NOT** |
|---|---|---|---|
| **Platform Safety Moderator** | Global | Triage, investigate, enforce, remove content, restrict | Decide own appeals; read message bodies (`TSF-XC-016`) |
| **Platform Safety Lead** | Global | All the above + permanent termination + policy versions | Author *and* approve one policy version |
| **Library Owner** | ⛔ blocked | — | Any `BC-13` read. `F-1`/`F-2` |
| **Library Manager** | ⛔ blocked | — | Same |
| **Authorized Community Moderator** | Deferred to `BC-15` (V2) | — | Same |
| **Student** | `self` | Report; block/mute via `BC-11`; appeal own case | See any other person's case, report or strike |

`TSF-INV-006` A library-scoped actor **MUST NOT** be able to read: another library's reports or cases; **any**
private message; or **any** platform-global risk intelligence. This is invariant regardless of how §18.3 is
resolved — it is the requirement the resolution must satisfy, not a consequence of it.

---

## 10. Messaging Safety

⚠ **Ownership guard.** `BC-12` owns conversations, messages, delivery and retention. T&S owns the **restriction**
and the **report**.

### 10.1 The synchronous send-time check — the load-bearing requirement

| ID | Requirement |
|---|---|
| `TSF-FR-030` | `BC-13` **MUST** expose a **synchronous** enforcement-state query answering *"is `PersonId` restricted from messaging right now?"* |
| `TSF-FR-031` | `BC-12` **MUST** call it on **every** send, and **MUST NOT** rely on its own `E-14` projection alone |
| `TSF-FR-001` | p99 ≤ 50 ms, **fail closed** |
| `TSF-INV-007` | A send by a messaging-restricted person **MUST** fail even if the `E-14` event has not yet been consumed |

⚠ **Authority.** BC Map **L468** already requires exactly this: *"Messaging must additionally check enforcement
state at send time — eventual consistency is unacceptable for abuse containment, so this path is belt-and-braces."*
This PRD adopts a ratified rule; it does not introduce one.

`TSF-GAP-003` **OPEN — the transport does not exist.** `BC-13`'s only edge is the **outbound, event-only** `E-14`
(`F-3`). A synchronous *inbound* query from `BC-12` to `BC-13` is **not in BC Map §7**, and §7's own rule is that
*"if an edge is not in this table, it does not exist and adding it requires an ADR."* Both are `domain/social`
contexts, so no rank law is violated and an internal edge (`E-14`'s sibling) is the likely shape — but that is an
**Architecture Owner** act. Owner: Architecture Owner with the `BC-12` and `BC-13` owners. **Blocks `IMPL-1410`.**

⚠ This is the same defect class as `ADR-0016` and `ADR-0055` — a Rank 3 requirement depending on an edge the Rank 4
register does not list. Both precedents were resolved by a **one-cell amendment after a per-context necessity
test**, and neither was resolved by the PRD author. This PRD follows that precedent: it **names the gap and routes
it** rather than asserting the edge.

### 10.2 Message requests and unwanted contact

| ID | Requirement |
|---|---|
| `TSF-FR-032` | A first message to a non-friend **MUST** be a **message request** — not delivered to the inbox until accepted |
| `TSF-FR-033` | A person **MUST** be able to decline without the sender learning it was declined |
| `TSF-FR-034` | Outstanding-request limits **MUST** be enforced per `TSF-CFG-009` |
| `TSF-FR-035` | An **adult-classified** sender's first contact with a **minor-classified** recipient who shares no graph proximity **MUST** be held as a request **and** raise the §5.3 signal |
| `TSF-XC-016` | T&S **MUST NOT** read message bodies at rest |

`TSF-BR-011` The request-limit counter is **`BC-11`'s** (`F-6`, `RateLimitCounter`); T&S consumes the breach as a
signal. Two counters for one fact is how they drift apart.

### 10.3 Reported message content — the narrow, consented exception

`TSF-FR-036` When a person reports a message, the report **MUST** carry an **evidence snapshot** of that message,
submitted **by the reporter**, of content **already lawfully visible to them**.

`TSF-BR-012` This is the **only** path by which message content enters `BC-13`, and it is **reporter-supplied, not
platform-harvested**. T&S never queries the message store.

`TSF-FR-037` The snapshot **MUST** be limited to the reported message plus at most `TSF-CFG-010` messages of
surrounding context, and **MUST** be visible only to a moderator on that case (§19.4).

`TSF-BR-013` `messaging.MessageSent` is consumed **for sampling only** — BC Map **L431** says exactly that. The
sample **MUST** feed volumetric counters only and **MUST NOT** persist bodies (`TSF-XC-016`).

### 10.4 User-reported vs proactive detection — the required distinction

| | **User-reported** | **Proactive automated** |
|---|---|---|
| Trigger | A person files an `AbuseReport` | A rule fires on a signal |
| Content access | Reporter-supplied snapshot (§10.3) | ⛔ **No message content in V1** |
| Evidentiary weight | An accusation (`TSF-BR-010`) | A statistical indication |
| May cause enforcement | Yes, after human review | ⛔ **Advisory only** (`TSF-XC-014`) |
| V1 scope | **Yes — the primary path** | Metadata/velocity only |

`TSF-XC-032` V1 **MUST NOT** perform automated content classification of message bodies. This is a **privacy
posture**, not a capability gap: the platform has no lawful V1 read path, and building one to enable scanning would
be a far larger decision than a moderation feature (§25, `TSF-GAP-011`).

### 10.5 Malicious links and files

`TSF-FR-038` A reported link **MUST** be recorded as evidence by **normalised URL and hash**, never fetched by a
moderator's browser session.

`TSF-FR-039` File safety is **`BC-29`'s** — *"upload, virus scan"*, BC Map **L139**. T&S consumes the scan verdict
and **MUST NOT** scan.

`TSF-GAP-005` **OPEN** — T&S is deliberately **not** an `E-22` consumer (`F-4`, `ADR-0055` §3, enforced in code by
`ADR-0059`). It therefore cannot read a `FileRef` to display reported media to a moderator. Owner: Architecture
Owner. ⚠ `ADR-0055` §3 **already tested `BC-13` and refused it**, so this is not an oversight to be corrected but a
**decision to be revisited on new evidence** — namely that moderation of a reported file requires the moderator to
see it. §12.4 specifies the V1 workaround. **Blocks `IMPL-1418`.**

---

## 11. Content & File Safety

### 11.1 Reportable content surfaces

| Surface | Owner | V1? | Report subject type |
|---|---|---|---|
| Person / public profile | `BC-10` | ✅ | `PERSON` |
| Username | `BC-10` | ✅ | `PERSON` |
| Direct message | `BC-12` | ✅ | `MESSAGE` |
| File / media reference | `BC-29` | ✅ | `FILE_REF` |
| Link inside a message | `BC-12` | ✅ | `MESSAGE` |
| Community post / comment | `BC-14`/`BC-15` | ⛔ V2 | `COMMUNITY_POST` / `_COMMENT` (declared, unpopulated) |
| Library public profile | `BC-19` + `BC-02` §14B projection | ⚠ **see §11.3** | `LIBRARY_PROFILE` |
| Library official post | — | ⛔ **does not exist** | — |

### 11.2 Enforcement on content

| ID | Requirement |
|---|---|
| `TSF-FR-040` | `CONTENT_REMOVAL` **MUST** be published via `E-14` with the content reference; the owning context performs removal |
| `TSF-FR-041` | `VISIBILITY_RESTRICTION` **MUST** reduce audience without deleting — reversible on appeal |
| `TSF-INV-008` | T&S **MUST NOT** delete content directly (`TSF-XC-021`) |
| `TSF-FR-042` | A removal **MUST** retain its evidence snapshot for `TSF-CFG-012` even after the source is gone — otherwise a successful appeal has nothing to review |

### 11.3 The library public profile — a cross-boundary report

⚠ A **library public profile** is tenant data (`PRD-002` §14B, `LIB-14B-*`, served anonymously from a projection
per `ADR-0010`). A **global** student reporting it crosses `X-05`.

`TSF-FR-043` T&S **MUST** accept a `LIBRARY_PROFILE` report and open a case.

`TSF-BR-014` The case **MUST** be resolvable **without** T&S reading tenant data: the evidence is the
**reporter-supplied snapshot of the public projection**, which is by construction already public
(`ADR-0010`: *"served anonymously"*). Reporting something already world-readable creates no new disclosure.

`TSF-XC-033` The **enforcement** action on a library profile **MUST NOT** be executed by `BC-13` — there is no edge
(`F-2`, `F-3`). The disposition is **referral to the platform operations role that owns tenant lifecycle**
(`BC-19`).

`TSF-GAP-009` **OPEN** — no referral transport exists between `BC-13` and `BC-19`, and `X-05` makes a direct edge
the wrong shape. Owner: Architecture Owner with `BC-19` owner. **Blocks `IMPL-1424`.**

### 11.4 "Library official post" — refused for want of a subject

`TSF-XC-034` The request names *"Library official posts"* as a reportable type. **No such object exists in the
repository** — measured: no `BC-nn` owns it, `BC-15` is V2, and no PRD defines it. **No requirement was written for
it.** Inventing a reportable type for an object with no owner would create a register entry that can never be
satisfied. Recorded as `TSF-GAP-010`, owner Product Owner.

---

## 12. Reporting

### 12.1 Report intake

| ID | Requirement |
|---|---|
| `TSF-FR-044` | A report **MUST** be fileable from the surface where the content was encountered, in ≤ 3 interactions |
| `TSF-FR-045` | Every report **MUST** carry: reporter `PersonId`, subject type, subject reference, category, free text (bounded `TSF-CFG-011`), evidence snapshot, client timestamp, server receipt timestamp |
| `TSF-FR-046` | The reporter **MUST** receive an acknowledgement with a case reference |
| `TSF-FR-047` | A report **MUST** be acceptable **anonymously to the subject** — the subject **MUST NOT** learn who reported them |
| `TSF-INV-009` | Reporter identity **MUST NOT** appear in any notice, appeal record or export visible to the subject |
| `TSF-FR-048` | Report submission **MUST** be idempotent on `(reporterId, subjectRef, categoryCode, idempotencyKey)` |

`TSF-BR-015` `TSF-INV-009` is **not a courtesy** — a reporting system that discloses the reporter to the reported
person is a retaliation delivery mechanism, and on a minor-heavy product that is the dominant failure mode.

### 12.2 Categories

`SEVERITY` is intrinsic to the category and set by policy, not by the reporter.

| Category | Severity | SLA |
|---|---|---|
| `THREAT` — threat of violence or self-harm | **`CRITICAL`** | `TSF-CFG-005` |
| `MINOR_SAFETY` — exploitative or grooming-risk contact | **`CRITICAL`** | `TSF-CFG-005` |
| `HARASSMENT` | `HIGH` | `TSF-CFG-006` |
| `BULLYING` | `HIGH` | `TSF-CFG-006` |
| `IMPERSONATION` | `HIGH` | `TSF-CFG-006` |
| `PRIVACY_VIOLATION` | `HIGH` | `TSF-CFG-006` |
| `MALICIOUS_FILE` | `HIGH` | `TSF-CFG-006` |
| `SCAM` | `MEDIUM` | `TSF-CFG-007` |
| `INAPPROPRIATE_CONTENT` | `MEDIUM` | `TSF-CFG-007` |
| `SPAM` | `LOW` | `TSF-CFG-007` |
| `OTHER` | `MEDIUM` on triage | `TSF-CFG-007` |

`TSF-BR-016` A reporter **MUST NOT** be able to set severity. Self-declared severity is trivially gamed to jump
the queue, which is a denial-of-service against genuine `CRITICAL` reports.

`TSF-BR-017` `THREAT` and `MINOR_SAFETY` **MUST** bypass deduplication collapse and **MUST** each be individually
human-reviewed, even at ten reports on one subject (§12.5).

### 12.3 Evidence

| ID | Requirement |
|---|---|
| `TSF-FR-049` | Evidence **MUST** be an immutable snapshot taken at report time, with a content hash |
| `TSF-INV-010` | Evidence **MUST** be append-only. No update or delete path in code |
| `TSF-FR-050` | Evidence **MUST** record its **provenance** — `REPORTER_SUPPLIED`, `SYSTEM_SIGNAL` or `MODERATOR_NOTE` — and provenance **MUST** be displayed wherever evidence is |
| `TSF-XC-035` | Evidence **MUST NOT** include data the reporter could not lawfully see |
| `TSF-FR-051` | Every moderator **view** of evidence **MUST** emit an access record (§19.4) |

`TSF-BR-018` Provenance is displayed because a moderator weighing *"the reporter says this was said"* against
*"the platform observed this"* is making a different judgement in each case, and a UI that renders them
identically invites the wrong one.

### 12.4 The reported-file workaround

Given `TSF-GAP-005` (T&S cannot read a `FileRef`):

`TSF-FR-052` For a `FILE_REF` report, V1 evidence **MUST** consist of: the opaque `FileRef` identifier, the
`BC-29` scan verdict, the reporter's textual description, and the reporter-supplied snapshot **if** the client
can produce one from what was already rendered to them.

`TSF-BR-019` If a moderator cannot see the file, the case **MUST** be dispositioned on the surrounding conduct
(the sending pattern, the relationship, the reporter's account) and **MUST NOT** be dispositioned by guessing at
content. `TSF-XC-036` A case **MUST NOT** be closed as *"no violation"* solely because the evidence was
unviewable — it **MUST** be closed as `UNRESOLVABLE_PENDING_ACCESS` and counted (`TSF-AC-060`), so the gap has a
measurable cost instead of an invisible one.

### 12.5 Triage, deduplication and routing

```
  Report received
      │
  [1] Validate + idempotency                          TSF-FR-048
      │
  [2] Deduplicate ── same subject + category + window ─> attach to open case   TSF-FR-053
      │                                                  (CRITICAL exempt: TSF-BR-017)
  [3] Severity from category                           §12.2
      │
  [4] Route ── CRITICAL ─> escalation queue, page a human   TSF-FR-054
      │        HIGH/MED ─> standard queue by severity then age
      │        LOW      ─> batch queue
      │
  [5] Open or attach ModerationCase, state = NEW
```

| ID | Requirement |
|---|---|
| `TSF-FR-053` | Reports on the same subject and category within `TSF-CFG-013` **MUST** attach to the open case rather than create duplicates |
| `TSF-FR-054` | A `CRITICAL` report **MUST** page a human within `TSF-CFG-005` regardless of queue depth (`G-6`) |
| `TSF-FR-055` | Queue order **MUST** be severity, then **age** — never report count (`TSF-BR-010`) |
| `TSF-INV-011` | An `SLA` breach **MUST** be recorded on the case and **MUST NOT** be silently reset by reassignment |

`TSF-BR-020` A **reporter-reputation** weight (`TSF-BR-024`) **MUST NOT** suppress a `CRITICAL` report. A
low-reputation reporter is exactly who a predator would target.

---

## 13. Moderation

### 13.1 The case is the aggregate, and that is the whole design

Rank 4 BC Map **L379** fixes `BC-13`'s aggregate as **`ModerationCase`**. §6.4 adopted it rather than
declaring a new one. The consequence for this section is concrete and non-negotiable: **every safety
decision in Liboora is a state transition on exactly one `ModerationCase`, inside exactly one database
transaction** (BC Map §8 — *"one aggregate, one database transaction, no exceptions"*).

There is no "quick action" path, no "just hide it" button, no enforcement without a case. That is not
bureaucracy — it is the only mechanism by which `TSF-INV-004` (every enforcement action is attributable)
becomes *structurally* true rather than merely intended.

| ID | Requirement |
|---|---|
| `TSF-INV-012` | An `EnforcementAction` **MUST NOT** exist without a parent `ModerationCase`. No code path creates one standalone — this is enforced by the aggregate boundary, not by code review |
| `TSF-FR-006` | A case **MUST** be openable from exactly three origins: a user report (§12), a rule trip (§14), or a moderator-initiated review. All three produce the same aggregate in the same shape |
| `TSF-FR-007` | A case **MUST** record `openedBy` as either a `PersonId`, a rule identifier, or a moderator identity — never null, and never `"system"` without a rule identifier |
| `TSF-FR-008` | A case **MUST** carry exactly one **subject** (`PersonId`) and zero-or-more reported artefacts. A case about two people is two cases |

`TSF-FR-008` is deliberate. Shared cases feel efficient and destroy attributability: the strike ladder
(§15.3), the appeal right (§16) and the retention clock (§17) are all per-person, and a two-subject case
makes each of them ambiguous.

### 13.2 The seven-state lifecycle

The brief specifies `NEW → TRIAGED → INVESTIGATING → ACTIONED → APPEAL → RESOLVED → CLOSED`. Adopted
verbatim, and made a machine — with the *forbidden* transitions stated as loudly as the permitted ones,
because in moderation the dangerous defect is a state you can reach, not one you cannot.

```
   [NEW] ──> [TRIAGED] ──> [INVESTIGATING] ──> [ACTIONED] ──> [RESOLVED] ──> [CLOSED]
     │           │               │                  │              ▲            ▲
     │           └── no action ──┴──────────────────┘              │            │
     │                    (outcome = NO_VIOLATION) ────────────────┘            │
     │                                                                         │
     ├──> invalid / duplicate ─────────────────────────────────────────────> [CLOSED]
     │
     └── [ACTIONED] ──> [APPEAL] ──> [RESOLVED]      (upheld | overturned | modified)
```

| From | To | Who may | Precondition |
|---|---|---|---|
| `NEW` | `TRIAGED` | Moderator, or the triage rule set | Severity assigned, queue assigned |
| `NEW` | `CLOSED` | Moderator | Outcome `DUPLICATE` or `INVALID`. **MUST** link the surviving case if duplicate |
| `TRIAGED` | `INVESTIGATING` | Moderator | A **named** moderator has claimed it |
| `TRIAGED` | `RESOLVED` | Moderator | Outcome `NO_VIOLATION`, severity ≤ `MEDIUM` |
| `INVESTIGATING` | `ACTIONED` | Moderator | ≥ 1 `EnforcementAction` attached, **with a policy citation** |
| `INVESTIGATING` | `RESOLVED` | Moderator | Outcome `NO_VIOLATION`, reason recorded |
| `ACTIONED` | `APPEAL` | **The subject only** (§16) | Action appealable, inside the appeal window |
| `ACTIONED` | `RESOLVED` | Time, or moderator | Appeal window elapsed, or subject waived |
| `APPEAL` | `RESOLVED` | **A different moderator** (`TSF-INV-013`) | Appeal decided |
| `RESOLVED` | `CLOSED` | Time | Retention / legal-hold clock, §17 |

| ID | Requirement |
|---|---|
| `TSF-INV-013` | An appeal **MUST NOT** be decided by the actor who took the action, nor by anyone in that actor's approval chain. This mirrors Rank 4 BC Map **L379** — *"appeal cannot be decided by the enforcing actor"* — and is therefore not this PRD's invention but its **inheritance** |
| `TSF-FR-009` | Every transition **MUST** append an immutable `CaseTransition`: from, to, actor, timestamp, reason. There is no update path on a transition |
| `TSF-FR-056` | `CLOSED` is **terminal**. New evidence on a closed matter opens a **new** case linked to the old one; it **MUST NOT** reopen it |
| `TSF-FR-057` | A case **MUST NOT** skip `INVESTIGATING` en route to `ACTIONED` at severity `HIGH` or `CRITICAL` — the record must show that a human looked |
| `TSF-BR-021` | `RESOLVED` / `NO_VIOLATION` **MUST** be a first-class, blameless outcome, surfaced in moderator quality metrics as a **correct** result. A queue that rewards only enforcement manufactures enforcement |

### 13.3 Why `TSF-FR-056` refuses to reopen

Reopening is the most attractive shortcut in case management and the most corrosive. A reopened case
carries two decisions under one identifier, after which the audit record can no longer answer *"what was
decided about this person on that date"* without disambiguation logic. `MP-GBR-13` makes audit
append-only precisely so that question stays answerable. A successor case costs one link field and
preserves the property.

### 13.4 Automation's ceiling inside the lifecycle

| Transition | May a rule perform it in V1? | Why |
|---|---|---|
| `NEW → TRIAGED` | **Yes** | Reversible, no user-visible effect |
| `NEW → CLOSED` (duplicate) | **Yes** | Deterministic key match; reversible by opening a new case |
| `TRIAGED → INVESTIGATING` | No | Claiming is an accountability act; a rule cannot be accountable |
| `→ ACTIONED` | **Only** the reversible actions of §15 rows 1–6, inside §14.4 caps | `TSF-INV-002` |
| `→ APPEAL` | Never | Only the subject initiates |
| `APPEAL → RESOLVED` | **Never** | An appeal exists *because* automation may have erred |

`TSF-BR-022` If the rule set is disabled, degraded, or its configuration is unreachable, cases **MUST**
remain openable and manually triageable. **Automation is an accelerator of the queue, never its gate.** A
safety system that stops accepting reports when its classifier is down has inverted its own priorities.

---

## 14. Risk & Abuse Detection

### 14.1 V1 is rule-based and transparent — a deliberate ceiling, not a staffing compromise

The brief asks for a *"V1 transparent/rule-based risk framework"*. Adopted and sharpened: in V1 every
risk output **MUST** be explainable as a sentence a moderator can read and a subject could be shown. No
opaque score, no model, no embedding.

| ID | Requirement |
|---|---|
| `TSF-FR-058` | Every `RiskSignal` **MUST** carry the rule identifier, observation window, measured value, threshold crossed, and a human-readable statement |
| `TSF-FR-059` | A `RiskAssessment` **MUST** be reproducible — replaying the same signals through the same rule version **MUST** yield the same output. The rule version **MUST** be recorded on the assessment |
| `TSF-FR-060` | A risk output that cannot be explained **MUST NOT** be actionable. It may be logged for future analysis (§25) but **MUST NOT** appear as a basis on any case |
| `TSF-BR-023` | **A risk score is a request for attention, never a finding of guilt.** No enforcement action may cite a score as its sole basis; it must cite a policy and evidence |

### 14.2 The four quantities, kept separate

The brief requires *risk, confidence, severity, thresholds* to be distinguished. Conflating them is the
classic failure mode, so they are defined as different things with different owners:

| Quantity | Measures | Range | Set by | May it alone decide? |
|---|---|---|---|---|
| **Severity** | How bad the *alleged* behaviour would be **if true** | `LOW`…`CRITICAL` | The **category** (§12.2), fixed | No — it sets urgency, not outcome |
| **Risk** | How likely this *pattern* is abusive | 0–100 from rule contributions | Rule set, versioned | No (`TSF-BR-023`) |
| **Confidence** | How reliable the *measurement* is | `LOW`/`MEDIUM`/`HIGH` | Rule, from sample size + window completeness | No |
| **Threshold** | The line at which something happens | Config, `TSF-CFG-*` | `BC-25` Configuration via `E-19` | It gates; it does not decide |

`TSF-INV-014` **Severity MUST NOT be raised by risk.** A spam-category report against a high-risk
account is still a spam-category report. Letting risk escalate severity would allow volume of accusation
to manufacture urgency — the exact failure `TSF-BR-010` exists to prevent.

### 14.3 The V1 signal register

All signals below are computable from events `BC-13` **already receives** per BC Map §9, or from its own
case history. **Nothing here requires a new inbound edge** — that constraint (`F-3`) is what kept this
list short and honest.

| Signal | Source | Rule shape | Confidence driver |
|---|---|---|---|
| Request-acceptance ratio | `BC-11` graph events | Outbound requests ÷ accepted, per window | Denominator size (`TSF-BR-008`) |
| Block rate | `BC-11` `social.UserBlocked` | Distinct blockers ÷ distinct contacted | Contact count (`TSF-BR-009`) |
| Message-request rate | `BC-12` `messaging.MessageSent` **(sampling, L431)** | Requests to non-connections per window | ⚠ **Sampled — capped at `MEDIUM`** |
| Report velocity | Own cases | Distinct reporters × distinct categories, per window | Reporter independence |
| Repeat enforcement | Own `StrikeRecord` | Count of **upheld** actions, decayed | Exact — `HIGH` |
| Account age at first burst | `BC-10` `identity.PersonIdentityCreated` | Activity volume ÷ account age | Exact — `HIGH` |
| Coordination indicator | Own cases | ≥ N subjects, same target set, same window | Cohort size |

| ID | Requirement |
|---|---|
| `TSF-BR-024` | A **reporter-reputation** weight (the forward reference from `TSF-BR-020`) **MAY** influence queue *position* within a severity band and **MUST NOT** influence severity, outcome, or whether a report is accepted. It **MUST NOT** apply at all to `CRITICAL` categories — a low-reputation reporter is exactly who a predator would target |
| `TSF-BR-027` | The message-request signal derives from a **sampled** stream (BC Map **L431** publishes `messaging.MessageSent` to `BC-13` as *"(sampling)"*). Its confidence is therefore capped at `MEDIUM` and it **MUST NOT** be the sole basis of any irreversible action. Treating a sampled stream as a census is how a safety system acquires a systematic false-positive bias it cannot see |

### 14.4 Threshold bands, and the ceiling on each

| Band | Risk | Confidence | Permitted automatic effect |
|---|---|---|---|
| **Observe** | < `TSF-CFG-015` | any | Log the signal. No case, no user-visible effect |
| **Friction** | ≥ `TSF-CFG-015` | ≥ `MEDIUM` | Recommend tightening **existing** `BC-11` limits (§14.6). Reversible, invisible ⚠ `TSF-GAP-012` |
| **Review** | ≥ `TSF-CFG-016` | ≥ `MEDIUM` | **Open a case at `TRIAGED`.** No enforcement |
| **Restrain** | ≥ `TSF-CFG-017` | **`HIGH` only** | Case + **one** reversible action from §15 rows 1–6, time-boxed to `TSF-CFG-018`, human review mandatory before expiry |
| — | any | any | ⛔ Suspension (row 8) and termination (row 9) are **never** automatic (`TSF-INV-002`) |

| ID | Requirement |
|---|---|
| `TSF-FR-061` | An automatic `Restrain` action **MUST** expire at `TSF-CFG-018` unless a human has affirmed it. **Silence expires the restriction; it does not extend it** |
| `TSF-FR-062` | Automatic actions **MUST** be globally rate-capped at `TSF-CFG-019` per hour. On breach the system **MUST** stop acting and page a human — never act faster |
| `TSF-FR-063` | Every rule **MUST** be individually disableable at runtime through configuration, without deployment (`E-19`) |
| `TSF-CFG-002` | Rule-set version pin |
| `TSF-CFG-003` | Signal observation window (default 24 h) |
| `TSF-CFG-004` | Decay half-life for historical enforcement in risk contribution |

`TSF-FR-062` is the circuit breaker, and it is the single most important requirement in this section.
A mature platform's worst safety incident is rarely a missed abuser; it is a rule that mass-actioned
thousands of innocent accounts at machine speed. A global hourly cap converts that from a catastrophe
into an alert.

### 14.5 False positives are a measured, budgeted quantity

| ID | Requirement |
|---|---|
| `TSF-FR-064` | Every rule **MUST** publish an observed false-positive rate, computed from `NO_VIOLATION` outcomes and **overturned** appeals on cases it opened |
| `TSF-FR-065` | A rule whose FP rate exceeds `TSF-CFG-020` over `TSF-CFG-021` **MUST** be automatically demoted to `Observe` and reported. **Demotion is automatic; promotion back is a human act** |
| `TSF-FR-066` | Overturned appeals **MUST** feed back to the originating rule as labelled outcomes (§16). An appeals system that does not inform detection is a complaints desk |
| `TSF-BR-025` | A false positive **MUST** be treated as a safety failure of the same class as a false negative, not as an acceptable cost of doing business. Wrongly restricting a student **is** a harm to a student |

### 14.6 Where risk may act, and where `BC-11` keeps the authority

§3 excluded rate limiting as `TSF-XC-006`: `BC-11` owns `RateLimitCounter`, and `E-16` states *"block
enforcement lives in the graph"*. Risk detection therefore **computes** and **publishes**; the graph
**decides** and **enforces**.

`TSF-XC-037` `BC-13` **MUST NOT** hold a rate-limit counter, evaluate a rate-limit decision, or store
per-actor quotas. It publishes a fact by `E-14` and the graph self-restricts — exactly as BC Map **L286**
requires: *"T&S never reaches into their models."*

⚠ **`TSF-GAP-012`** *(this populates the slot reserved in §0.2)*. The `Friction` band needs `BC-11` to
interpret an `EnforcementActionTaken` carrying a **graduated tightening** semantic. The published
contract at BC Map **L318** is `EnforcementActionTaken{personId, action, scope, until}` — a **closed
four-field shape**. Whether `action` admits a `TIGHTEN_RATE_LIMITS` value, or whether that needs a Rank 4
contract amendment, is **not this document's decision to make**. Routed to the **Architecture Owner**.
Until it is decided, the `Friction` band is **specified but not implementable** and `IMPL-1412` is
blocked. It is recorded rather than assumed because inventing a new enum value inside a Rank 4 contract,
from an unranked document, is precisely the silent override the brief forbids.

---

## 15. Enforcement

### 15.1 The nine actions, ordered by reversibility

The brief lists nine graduated actions. Adopted verbatim, ordered by reversibility — because §6.2's
`TSF-BR-003` established that **reversibility decides the timing**, and it decides the *authority* too.

| # | Action | Reversible? | Executed by | Automatable? | Appealable? |
|---|---|---|---|---|---|
| 1 | **Warning** | Fully — it is a message | `BC-13` + `BC-22` (`E-23`) | Yes | No — nothing is restricted |
| 2 | **Content removal** | Yes — soft delete (`MP-GBR-14`) | Owning context, via `E-14` | Yes | **Yes** |
| 3 | **Visibility restriction** | Yes | `BC-11` / `BC-14` self-restrict | Yes | Yes |
| 4 | **Comment restriction** | Yes | `BC-15` — ⚠ **V2**, §9.1 | Yes | Yes |
| 5 | **Messaging restriction** | Yes | `BC-12`, **+ send-time check §10.1** | Yes | Yes |
| 6 | **Discovery restriction** | Yes | `BC-11` pipeline stage 4 (§8.3) | Yes | Yes |
| 7 | **Community restriction** | Yes | `BC-14` / `BC-15` — ⚠ **V2** | Yes | Yes |
| 8 | **Temporary suspension** | Yes, but total | `BC-18` session revoke + `E-14` | ⛔ **No** | Yes |
| 9 | **Permanent termination** | **No** | `BC-18` + `BC-13`, **two actors** | ⛔ **No** | Yes — and **must** be |

| ID | Requirement |
|---|---|
| `TSF-FR-067` | Every action **MUST** carry: case reference, policy citation, actor, scope, and either an expiry or an explicit `permanent` flag. An action with neither is invalid and **MUST** be rejected at write time |
| `TSF-FR-068` | Actions 2–7 **MUST** be expressed as `EnforcementActionTaken{personId, action, scope, until}` (`E-14`) and executed by the **owning** context. `BC-13` **MUST NOT** write into another context's store |
| `TSF-FR-069` | Action 9 **MUST** require two distinct human actors, recorded separately. **One human cannot end an account** |
| `TSF-FR-070` | Action 8 **MUST** carry an expiry at creation. There is no open-ended suspension — that is action 9 wearing a disguise, and it evades action 9's two-actor rule |
| `TSF-INV-015` | An action's scope **MUST** be drawn from the closed register of `MP-GBR-21` (`self`, `guardianOf`, `tenantWide`) **or** be a `BC-13`-local **global** scope. It **MUST NOT** invent a tenant-shaped scope — see §18.2 |

### 15.2 Proportionality is computed, then a human signs it

| Input | Weight | Source |
|---|---|---|
| Category severity | Primary | §12.2, fixed by category |
| Evidence strength | Primary | Corroboration count + provenance (§12.3) |
| Upheld prior actions | Secondary, decayed by `TSF-CFG-004` | Own `StrikeRecord` |
| Risk assessment | **Advisory only** | §14, `TSF-BR-023` |
| Subject age band | Escalates **protection**, mitigates **punishment** | ⚠ `TSF-GAP-014` — no accessor exists |

| ID | Requirement |
|---|---|
| `TSF-FR-071` | The console **MUST** display a *recommended* action, and the moderator **MUST** be able to depart from it with a recorded reason. A recommendation the moderator cannot refuse is an automatic decision with a human alibi |
| `TSF-FR-072` | Departing **downward** (more lenient) **MUST** require only a reason. Departing **upward** at severity `HIGH`/`CRITICAL` **MUST** require a second moderator |
| `TSF-BR-026` | **Overlapping actions MUST NOT stack silently.** A new restriction on an already-restricted subject **MUST** explicitly replace or extend the existing one, and the resulting effective state **MUST** be a single computable answer to *"what may this person do right now?"* |

`TSF-BR-026` is load-bearing for §10.1. If effective state required reducing a history of overlapping
actions at read time, the ≤ 50 ms p99 budget would be spent on arithmetic. One current
effective-restriction row makes the send-time check a **point read**.

### 15.3 The strike ladder

| Strikes (decayed) | Default posture | Note |
|---|---|---|
| 0 | Warning, or removal | First contact is educational unless severity is `HIGH`+ |
| 1 | Removal + **targeted** restriction | Scoped to the abused surface only |
| 2 | Broader restriction, time-boxed | Multiple surfaces |
| 3 | Temporary suspension (action 8) | Human |
| 4+ | Termination **review** (action 9) | Two humans. Never automatic |

| ID | Requirement |
|---|---|
| `TSF-FR-073` | A strike **MUST** be recorded only on an **upheld** action. An overturned appeal **MUST** remove the strike and **MUST NOT** leave a residual "was accused" mark anywhere on the ladder |
| `TSF-FR-074` | Strikes **MUST** decay per `TSF-CFG-004`. A student's conduct at 14 must not sentence them at 19 |
| `TSF-FR-075` | `CRITICAL` categories **MUST** be able to bypass the ladder to actions 8–9 at first instance, with two humans. A credible threat to a child is not a first offence to be coached |

### 15.4 What enforcement never does

| ID | Prohibition | Authority |
|---|---|---|
| `TSF-XC-038` | **MUST NOT** hard-delete user content | `MP-GBR-14` soft delete; evidence integrity (§12.3) |
| `TSF-XC-039` | **MUST NOT** delete or mutate an identity record | `ID-1`; `BC-18` / `BC-10` own it |
| `TSF-XC-040` | **MUST NOT** revoke a **library membership** | `BC-02` owns membership. A platform safety action is not a refund event |
| `TSF-XC-041` | **MUST NOT** alter attendance, fees, seating, or any tenant operational record | `X-05`; a global safety decision holds no authority over tenant business state |
| `TSF-XC-042` | **MUST NOT** notify a subject's library that a global social enforcement action occurred | §18.4; the library is not a party to it |

`TSF-XC-040` and `TSF-XC-042` are the sharpest lines in this document. A student suspended from the
global social network **remains a paying member of their library, keeps their seat, their fee record and
their attendance history**. Liboora is two products under one roof; a safety decision on one must never
silently become a commercial or academic penalty on the other.

---

## 16. Appeals

### 16.1 Why appeals are a design requirement, not a courtesy

§14 admits automation. §12 admits that a report is an accusation. §5.1 admits a malicious-moderator
threat actor. Each of those admissions is only defensible if a wrong outcome has a route back. The
appeal is that route, and it is the mechanism that makes `TSF-BR-025` (false positives are safety
failures) measurable rather than rhetorical.

| ID | Requirement |
|---|---|
| `TSF-FR-076` | Every action in §15 rows 2–9 **MUST** be appealable exactly once by its subject. Row 1 (warning) is not appealable because nothing is restricted |
| `TSF-FR-077` | The subject **MUST** be told, at the moment of enforcement: what was decided, which policy, the scope, the expiry, and **how to appeal**. An unexplained restriction is indistinguishable from a bug and generates support load instead of correction |
| `TSF-FR-078` | An appeal **MUST** be fileable while the restriction is in force, including during a suspension (action 8) — the appeal channel **MUST NOT** be gated behind the capability that was suspended |
| `TSF-FR-079` | Filing an appeal **MUST NOT** extend, escalate or otherwise worsen the existing action. Appeal **MUST NOT** be a risk |
| `TSF-FR-080` | Appeal window: `TSF-CFG-006`. Decision SLA: `TSF-CFG-007`. Both **MUST** be stated to the subject up front |

`TSF-FR-078` is the one most often broken in practice: the account is suspended, and the appeal form
lives behind a login the suspension blocks. `BC-18` owns sessions (`ID-1`), so the appeal intake **MUST**
be reachable on a path that does not require an active social session.

### 16.2 The three outcomes, and what each does

| Outcome | Effect on action | Effect on strike | Effect on rule (§14.5) |
|---|---|---|---|
| **Upheld** | Stands unchanged | Strike retained | Counts as a true positive |
| **Modified** | Replaced by a lesser action (§15 order) | Strike **downgraded** to the new action's level | Counts as a **partial** false positive |
| **Overturned** | Reversed; effective state restored | Strike **removed** entirely (`TSF-FR-073`) | Counts as a **false positive** |

| ID | Requirement |
|---|---|
| `TSF-FR-081` | An appeal **MUST NOT** result in a *harsher* action than the one appealed. Discovery of worse conduct **MUST** open a **new** case (`TSF-FR-056`), not amplify the appeal |
| `TSF-FR-082` | On `Overturned`, the reversal **MUST** propagate by the same `E-14` fan-out that imposed it, and the send-time check (§10.1) **MUST** reflect it within `TSF-CFG-008` |
| `TSF-FR-083` | On `Overturned` for a content removal, the content **MUST** be restored, not merely marked restorable — soft delete (`MP-GBR-14`) exists so that this is possible |
| `TSF-INV-016` | An appeal decision **MUST** record the deciding actor, and that actor **MUST** satisfy `TSF-INV-013`. A system that cannot find a second moderator **MUST** queue the appeal, **never** auto-uphold it |

`TSF-INV-016`'s last clause is deliberate. Auto-upholding on timeout is the default behaviour of every
under-resourced appeals queue, and it converts a review right into a waiting room. A breached appeal SLA
**MUST** surface as an operational alert (§23), not as a silent affirmation of the original decision.

### 16.3 What an appeal is not

| ID | Exclusion | Reason |
|---|---|---|
| `TSF-XC-043` | An appeal is **not** a data-subject request. Erasure, export and correction are `BC-10` / `BC-18` under `MP-GBR-04` | `ID-1`, `ID-5` |
| `TSF-XC-044` | An appeal is **not** a channel to learn the reporter's identity. `TSF-INV-009` (reporter anonymity) survives the appeal intact | Anti-retaliation, §12.1 |
| `TSF-XC-045` | An appeal is **not** available to a **reporter** dissatisfied that no action was taken. That is a re-report, which §12.5 deduplication will attach to the existing case | A reporter has no adjudicated interest to appeal; the subject does |

`TSF-XC-044` is the hardest tension in this section and it is resolved in favour of the reporter. A
subject appealing in good faith would benefit from knowing who accused them; a subject appealing in bad
faith would use it to retaliate. Because the platform cannot distinguish the two at appeal time, and
because the population includes minors, the anonymity holds. The subject receives the **substance** of
the allegation and the evidence relied upon — never the reporter's identity.

---

## 17. Privacy & Student Safety

### 17.1 The tension stated honestly

A safety system is a surveillance system pointed at a good cause. Every capability in §12–§15 is also a
privacy risk: evidence stores contain private messages, risk signals profile behaviour, and the moderator
console is a window into student lives. This section constrains `BC-13` **against itself**.

| ID | Requirement |
|---|---|
| `TSF-FR-084` | `BC-13` **MUST** hold the **minimum** data required to decide the case in front of it. It **MUST NOT** build a general behavioural profile of any person as a standing asset |
| `TSF-FR-085` | `BC-13` **MUST NOT** store message content except as reporter-submitted evidence attached to an open case (`TSF-BR-012`, §10.3). The sampled `messaging.MessageSent` stream (**L431**) **MUST** be consumed as **counters only**, never retained as content |
| `TSF-FR-086` | A `RiskSignal` **MUST** store the **derived measure** and not the underlying observations. "17 requests, 2 accepted, 24 h" is retained; the 17 identities are not |
| `TSF-INV-017` | `BC-13` **MUST NOT** store any `StudentRecordId` or `tenantId` — `ID-2`, `ID-3`, and the `banned_symbols` list at `tool/module_dependencies.yaml` **L265–267**. This is enforced by the module manifest, not by policy |

`TSF-FR-086` is the requirement that keeps this system from becoming the thing it protects against. A
risk engine that retains every observation it counted has quietly built the behavioural dossier that
`TSF-FR-084` forbids.

### 17.2 Retention, and why nothing here is kept forever by default

| Data | Retention | Authority |
|---|---|---|
| Case + transitions + decisions | `TSF-CFG-009` after `CLOSED` | Accountability; audit is separate and append-only (`MP-GBR-13`) |
| Reporter-submitted evidence | `TSF-CFG-010` after `CLOSED`, then purged | Minimisation; it is private content |
| `RiskSignal` (derived measures) | `TSF-CFG-011`, rolling | Short window suffices for pattern detection |
| `StrikeRecord` | Decayed per `TSF-CFG-004`; row retained | Ladder needs history; weight must not |
| `AuditEntry` for safety actions | Owned by **`BC-24`**, append-only | `E-20`, `MP-GBR-13`; **not** `BC-13`'s to expire |
| Legal-hold cases | ⛔ Purge **blocked** | `MP-GBR-13` — legal hold blocks purge |

| ID | Requirement |
|---|---|
| `TSF-FR-087` | Purge **MUST** be automatic on the clock, not dependent on a human remembering. A retention policy nobody executes is a data-hoarding policy |
| `TSF-FR-088` | A legal hold **MUST** suspend purge for the held case only, **MUST** name the authority, and **MUST** be visible in the console as a reason the data still exists |
| `TSF-XC-046` | `BC-13` **MUST NOT** expire, edit, redact or delete an `AuditEntry`. `BC-24` owns the audit record and it is append-only with no delete path in code (BC Map **L384**) |

### 17.3 Deletion, anonymisation, and the one thing that survives

`ID-5` fixes the semantics: a DSR **deletes** the Account, **anonymises** the Person, and **retains**
`StudentRecord` history. `BC-13` must be consistent with all three at once.

| ID | Requirement |
|---|---|
| `TSF-FR-089` | On `identity.PersonAnonymised` (BC Map **L428**), `BC-13` **MUST** sever the case from the `PersonId` and **MUST** retain the case in an anonymised form. Accountability for a decision does not evaporate because the subject left |
| `TSF-FR-090` | Anonymised cases **MUST NOT** be re-identifiable by `BC-13`. Reversal, if legally compelled, is a `BC-10`/`BC-18` act under `MP-GBR-04`, not a `BC-13` capability |
| `TSF-FR-091` | A pending **termination review** or an active legal hold **MUST** block silent anonymisation completion and **MUST** raise an operational alert. Deletion **MUST NOT** be usable as an escape from an open `CRITICAL` case |
| `TSF-BR-028` | An **overturned** action's record **MUST** be purged on the shortest applicable clock and **MUST NOT** contribute to any future assessment. If we were wrong, we do not get to keep the file |

`TSF-FR-091` closes an abuse path that is easy to miss: without it, the fastest way to escape a
child-safety investigation is to file a deletion request. The account may still be deleted — that right is
real — but the case survives, anonymised, and the review completes.

### 17.4 Minor safety, and the escalation route

*(This subsection satisfies the forward reference from §4 and §5.3.)*

`MP-GBR-05` requires guardian consent; `ID-6` requires it before social activation; `MP-RSK-02` is rated
**Critical** on exactly this population. Liboora is a minor-heavy product, and that fact changes the
default in three specific ways.

| ID | Requirement |
|---|---|
| `TSF-FR-092` | Where the subject **or** the reporting party is a minor, the applicable category **MUST** be treated as **not less than** `HIGH`, and grooming/sexualisation categories **MUST** be `CRITICAL` |
| `TSF-FR-093` | A `CRITICAL` minor-safety case **MUST** route to the escalation queue (§12.5 step 4), page a human within `TSF-CFG-005`, and **MUST NOT** be auto-closed as duplicate (`TSF-BR-017`) |
| `TSF-FR-094` | Minor-safety cases **MUST** be visible to a restricted moderator role only, and every open **MUST** be an audited access (§19.4) |
| `TSF-FR-095` | Guardian-facing disclosure **MUST** be limited to the enforcement outcome affecting their own child under scope `guardianOf` (`MP-GBR-21`). It **MUST NOT** disclose the reporter, other students' identities, or evidence naming third parties |
| `TSF-BR-029` | Protective urgency **MUST** rise with youth; **punitive** severity **MUST NOT**. A 13-year-old who harasses is a safeguarding subject, not a harder target |

⚠ **`TSF-GAP-014`** *(carried from §5.3 and §15.2)*. All five requirements above need an **age band** for
a `PersonId`. `BC-18` owns consent and `BC-10` owns the person, but **no published event or port exposes a
minor/adult band to `BC-13`**. `BC-13` has one outbound event-only edge (`E-14`, `F-3`), so it cannot
query. Until an accessor exists, `TSF-FR-092` is satisfiable only when the **reporter volunteers** the
category, which is a materially weaker control. Routed to the **Architecture Owner and `BC-18` owner**.

`TSF-XC-047` `BC-13` **MUST NOT** infer age from behaviour, language, or profile text as a substitute for
`TSF-GAP-014`. An inferred age band would be an unexplainable input (`TSF-FR-060`) driving the most
consequential category in the system.

### 17.5 Escalation beyond the platform

| ID | Requirement |
|---|---|
| `TSF-FR-096` | The system **MUST** support recording that an out-of-platform escalation occurred: authority, date, reference, and the deciding actor. Recording is in scope; **transmitting** is not (§25) |
| `TSF-FR-097` | An escalated case **MUST** automatically acquire a legal hold (`TSF-FR-088`) so that evidence is not purged while an external process runs |
| `TSF-XC-048` | Automated reporting to any external authority is **out of V1 scope**. It is a legal and jurisdictional decision, not an engineering default, and it varies by residency (`BC-19`) |

### 17.6 Privacy of the safety system itself

| ID | Requirement |
|---|---|
| `TSF-FR-098` | Enforcement state **MUST NOT** be publicly observable. A restricted profile **MUST** be indistinguishable from a non-existent or private one — `MP-GBR-22`, denial ≡ not-found |
| `TSF-FR-099` | A user **MUST NOT** be able to determine whether they were reported, by whom, or how many times, other than through an enforcement notice served on them (`TSF-FR-077`) |
| `TSF-FR-100` | Error messages, latency and response shapes on the send-time check (§10.1) **MUST** be uniform whether the block is enforcement, a `BC-11` block, or absence of a connection. Three distinguishable failures are three information leaks |

`TSF-FR-100` is subtle and matters: a blocked sender who can tell *"platform-suspended"* from *"this
person blocked me"* has learned something the blocker did not choose to disclose — and §8.4 shows that
block evasion begins with exactly that inference.

---

## 18. Multi-Tenant Isolation

### 18.1 The measured position: `BC-13` is not multi-tenant, and that is upstream of this PRD

This is the section where the brief's request and the repository's architecture diverge most sharply, so
it states the measurement before the design.

| Evidence | Finding |
|---|---|
| BC Map **L488** | `BC-11`→`BC-17`: *"Global. No `tenantId`. Keyed on `PersonId`. Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)"* |
| yaml **L265–267** | `domain/social` `banned_symbols`: `StudentRecordId`, `TenantId` — `use_instead: "nothing — social data is not tenant-scoped"` |
| Matrix **L354** (`X-05`) | Library Management ⟷ `BC-11`…`BC-17` = **Separate Ways** — *"Merges two tenancy models and two privacy regimes"* |
| BC Map **L117** | `BC-13` tenancy model = **Global Student** |

**`BC-13` therefore has no tenant dimension at all.** It is not that library-scoped moderation is
unbuilt; it is that the context which would host it is *forbidden by a machine-checked manifest* from
holding the identifier that scoping requires (`F-1`, `TSF-INV-017`).

### 18.2 What isolation means for a global context

Isolation here does not mean "each tenant sees only its rows". It means the opposite: **the global safety
context must not leak into, or be reachable from, any tenant.**

| ID | Requirement |
|---|---|
| `TSF-FR-101` | Every `BC-13` record **MUST** be keyed on `PersonId` only (`ID-3`). No tenant column exists to filter on |
| `TSF-FR-102` | Enforcement scope **MUST** be **global** for social capabilities and **MUST NOT** be expressed as `tenantWide`. `MP-GBR-21`'s `tenantWide` scope belongs to tenant-side authorisation and carries a meaning `BC-13` cannot honour (`TSF-INV-015`) |
| `TSF-FR-103` | `BC-13` **MUST NOT** consume, join to, or derive from any tenant-scoped store: enrollment, membership, attendance, fees, seating |
| `TSF-XC-049` | `BC-13` **MUST NOT** expose any endpoint, report, export or console view reachable through a tenant-scoped session. Global safety intelligence is not a tenant resource |
| `TSF-XC-050` | A library administrator **MUST NOT** be able to determine whether a given student holds any global safety history — not through a UI, an export, an error code, a latency difference, or an absence |

`TSF-XC-049` and `TSF-XC-050` are the direct implementation of the brief's own final rule — *"Do not
allow library admins to access global safety intelligence"* — and they are the reason §4's Library Owner
persona has ⛔ **no V1 path**. That is not an omission in the persona table; it is this constraint,
honestly propagated.

### 18.3 The three routes to library-scoped moderation — and which one this PRD may not take

*(This subsection satisfies the forward reference from §9.3, and answers the brief's request that
*"library administrators must only moderate their authorized library"*.)*

The request is legitimate and, on its own terms, correct. It is also, as measured, **not implementable
inside `BC-13`**. There are exactly three architectural routes. Each is named, costed, and **left
undecided**, because choosing among them is a Rank 4 act.

| Route | Mechanism | Cost | Verdict |
|---|---|---|---|
| **R-1** | Admit `tenantId` into `BC-13` | Amend BC Map **L488**, amend yaml `banned_symbols`, breach `ID-2`, merge two privacy regimes (`X-05`) | ⛔ **Rejected on evidence.** It would dismantle a Rank 4 tenancy boundary to add a feature. `ID-2` exists to prevent exactly this |
| **R-2** | A **separate** library-community moderation capability inside the **tenant** side (`BC-14`/`BC-15`, V2), moderating only tenant-scoped community content, with **no read path** to `BC-13` | New V2 scope; two moderation systems with distinct vocabularies; needs a PRD | ✅ **Architecturally sound, correctly V2.** This is the route the existing architecture already implies (§9.1) |
| **R-3** | Community moderation as an **application-layer read composition** over tenant data, owning no aggregate — the `AR-1` pattern used for Library Discovery (BC Map **L86**) | No new context; limited to what tenant contexts already own; cannot hold a case | ⚠ **Possible for lightweight hide/pin only.** Cannot support cases, strikes or appeals |

| ID | Requirement |
|---|---|
| `TSF-INV-018` | Whichever route is chosen, the invariant is fixed: **a library actor's moderation authority MUST terminate at that library's own content, and MUST NOT extend to any global social artefact, case, strike, risk signal or safety history.** This invariant binds `R-2` and `R-3` in advance |
| `TSF-XC-051` | This PRD **MUST NOT** be read as selecting a route. `TSF-GAP-001` and `TSF-GAP-002` remain open and are routed to the **Architecture Owner** and **Product Owner** |

Recording `TSF-INV-018` now is the useful act available at this rank: whenever the route is chosen, the
safety boundary it must respect is already written down and cannot be quietly negotiated away during
implementation.

### 18.4 Cross-boundary communication that is permitted

| Direction | Permitted? | Mechanism |
|---|---|---|
| `BC-13` → global social contexts | ✅ Yes | `E-14`, event, `EnforcementActionTaken` |
| `BC-13` → `BC-24` Audit | ✅ Yes | `E-20`, fire-and-forget, outbox-backed |
| `BC-13` → `BC-22` Notification | ✅ Yes | `E-23`, emits a **fact**, never "send an SMS" |
| `BC-13` → tenant contexts | ⛔ **No** | `X-05` Separate Ways; `TSF-XC-041` |
| Tenant contexts → `BC-13` | ⛔ **No** | No inbound edge exists (`F-3`) |
| `BC-13` → `BC-19` Tenancy | ⛔ **No** | ⚠ `TSF-GAP-009` — no transport exists |
| `BC-13` → `BC-29` Files | ⛔ **No** | `E-22` deliberately excludes `BC-13` (`F-4`, `TSF-GAP-005`) |

`TSF-FR-104` A `BC-13` notification **MUST** address the **subject** or their guardian under scope
`guardianOf` only. It **MUST NOT** address a library, a library owner, or library staff (`TSF-XC-042`).
Quiet hours, deduplication and unsubscribe remain `BC-22`'s under `MP-GBR-35` — but `TSF-BR-030` an
enforcement notice **MUST NOT** be suppressible by an unsubscribe preference. A person must be told what
was decided about them.

---

## 19. Admin & Moderator Console UX

### 19.1 Three consoles, not one

The brief asks for an admin/moderator console. Measurement forces a split, because the three plausible
audiences sit on opposite sides of `X-05`.

| Console | Audience | Scope | V1? |
|---|---|---|---|
| **Global safety console** | Platform moderator / safety lead | `BC-13`, all `PersonId`s, no tenant dimension | ✅ **V1** |
| **Library community console** | Library owner / staff | Tenant community content only | ⛔ **Not V1** — §18.3, `TSF-GAP-002` |
| **Tenant admin console** | Library owner | Existing library operations | Out of scope — `BC-01`…`BC-05` |

`TSF-XC-052` The global safety console **MUST** be a separate application surface with its own
authorisation, reachable only by platform safety roles issued by `BC-18`. It **MUST NOT** be a privileged
mode of the library admin app — a shared shell is how a tenant session eventually reaches a global view
(`TSF-XC-049`).

### 19.2 The queue is the product

| ID | Requirement |
|---|---|
| `TSF-FR-105` | The queue **MUST** default to severity, then age (`TSF-FR-055`), and **MUST NOT** offer a sort by report count (`TSF-BR-010`) |
| `TSF-FR-106` | The queue **MUST** remain answerable at 10,000 open cases (`TSF-FR-004`) — pagination and filters **MUST NOT** degrade into a full scan |
| `TSF-FR-107` | A case **MUST** be claimable, and a claimed case **MUST NOT** be actionable by another moderator without an explicit, recorded reassignment (`TSF-INV-011`) |
| `TSF-FR-108` | The console **MUST** show SLA state — met, at-risk, breached — and **MUST NOT** allow a breach to be cleared by reassignment |
| `TSF-FR-109` | The escalation queue (`CRITICAL`) **MUST** be visually and operationally separate, and **MUST NOT** be mixed into the standard queue |

### 19.3 The decision surface

| ID | Requirement |
|---|---|
| `TSF-FR-110` | The case view **MUST** present: subject, category, severity, evidence with provenance (§12.3), risk assessment **labelled advisory** (`TSF-BR-023`), strike history, and the recommended action |
| `TSF-FR-111` | Taking an action **MUST** require a **policy citation** and **MUST NOT** be completable without one (`TSF-FR-067`) |
| `TSF-FR-112` | Where the moderator lacks a read path — a reported file (`TSF-GAP-005`) or off-platform content — the console **MUST** say so explicitly and offer `UNRESOLVABLE_PENDING_ACCESS` (`TSF-XC-036`). It **MUST NOT** present an empty pane that invites a guess |
| `TSF-FR-113` | Bulk action **MUST** be limited to `NO_VIOLATION` and `DUPLICATE` closure. **Bulk enforcement MUST NOT exist** in V1 |

`TSF-FR-113` follows from `TSF-FR-062`. Having built a circuit breaker on automated enforcement, it would
be incoherent to hand the same unbounded capability to a tired human with a checkbox column.

### 19.4 Moderator access is itself an audited action

*(This subsection satisfies the forward references from §10.3, §12.3, §12.5 and §17.4.)*

§5.1 lists the **malicious moderator** as a threat actor. That listing is only meaningful if the console
treats its own operators as a monitored population.

| ID | Requirement |
|---|---|
| `TSF-FR-114` | Every **read** of reporter-submitted private evidence **MUST** emit an audit event by `E-20` recording moderator, case, artefact and timestamp. Reading private content is an action, not navigation |
| `TSF-FR-115` | Access **MUST** be case-bound. A moderator **MUST NOT** be able to browse persons, messages or evidence outside a case assigned to or claimed by them |
| `TSF-FR-116` | There **MUST NOT** be a free-text search over evidence content, message bodies, or persons by attribute. Search **MUST** be by case identifier, `PersonId`, or queue filter |
| `TSF-FR-117` | Minor-safety cases (§17.4) **MUST** require a restricted role, and access **MUST** be reported in a review that a human reads on `TSF-CFG-012` |
| `TSF-FR-118` | Moderator access volume **MUST** be a monitored metric (§23) with an alert on anomalous per-moderator read volume |
| `TSF-INV-019` | A moderator **MUST NOT** act on a case where they are the reporter, the subject, or a named party in the evidence. Self-recusal **MUST** be enforced by the system, not left to conscience |
| `TSF-XC-053` | The console **MUST NOT** expose reporter identity to any role below safety lead, and **MUST NOT** expose it in any export, log line, or notification (`TSF-INV-009`, `TSF-XC-044`) |

`TSF-FR-116` will be unpopular with operators, and it is the correct trade. A free-text search across
student message evidence is the single highest-value target in this entire system: it converts a
case-bound console into a general surveillance tool, and it is the capability a malicious insider would
most want. Case-bound access makes abuse expensive and, through `TSF-FR-114`, visible.

`TSF-FR-119` The console **MUST** display, on every case, why the subject is *reachable* — that a case
exists — and **MUST NOT** display anything about the subject's library, membership, fees, attendance or
seat. Those fields are not merely hidden by permission; **they are not present in `BC-13` at all**
(`TSF-INV-017`), and the console must not create the impression that they could be requested.

---

## 20. Data Model & Contracts

### 20.1 One aggregate, eleven entities — the mapping the brief needs

The brief names eleven entities. BC Map §8 permits `BC-13` **one aggregate** (`ModerationCase`, **L379**)
and states *"one aggregate, one database transaction, no exceptions."* §6.4 established the split; this
section makes it a table.

| # | Entity | Inside `ModerationCase`? | Owner | Justification |
|---|---|---|---|---|
| 1 | **`ModerationCase`** | **Aggregate root** | `BC-13` | Rank 4 **L379** |
| 2 | **`AbuseReport`** | ✅ Inside | `BC-13` | Rank 4 **L379** lists it as an entity; a report's validity is decided with the case |
| 3 | **`Evidence`** | ✅ Inside | `BC-13` | Append-only child; integrity is transactional with the case |
| 4 | **`EnforcementAction`** | ✅ Inside | `BC-13` | **L379**; `TSF-INV-012` forbids it standing alone |
| 5 | **`StrikeRecord`** | ✅ Inside | `BC-13` | **L379**; written in the same transaction as the upheld action |
| 6 | **`Appeal`** | ✅ Inside | `BC-13` | **L379**; the appeal decides *this* case |
| 7 | **`CaseTransition`** | ✅ Inside | `BC-13` | `TSF-FR-009`; immutable child |
| 8 | **`RiskSignal`** | ⛔ **Outside** | `BC-13` | Per-person, not per-case; one signal informs many cases. Separate lifecycle and retention (`TSF-CFG-011`) |
| 9 | **`RiskAssessment`** | ⛔ **Outside** | `BC-13` | Computed, reproducible (`TSF-FR-059`), not a system of record |
| 10 | **`SafetyPolicy`** | ⛔ **Outside** | `BC-13` | Versioned reference data cited by actions; changing policy must not rewrite decided cases |
| 11 | **`EffectiveRestriction`** | ⛔ **Outside** | `BC-13` | The read-optimised answer to *"what may this person do now?"* — `TSF-BR-026`, required by §10.1's ≤ 50 ms budget |

**Two brief-named entities are deliberately absent.** `UserRestriction` is renamed
**`EffectiveRestriction`** to make clear it is derived state, not an authority (`TSF-XC-054`). And
`SafetyEvent`/`SafetyAuditEvent` are **not modelled here at all** — the audit record is `BC-24`'s
`AuditEntry` reached by `E-20` (`TSF-XC-046`); modelling a parallel safety audit log would duplicate a
Rank 4 aggregate and create two answers to *"who did what"*.

### 20.2 Entity detail

| Entity | Scope key | Lifecycle | States | Authorisation | Retention | Audited | Index |
|---|---|---|---|---|---|---|---|
| `ModerationCase` | `PersonId` (subject) | Report / rule / moderator → `CLOSED` | The 7 of §13.2 | Safety roles; case-bound (`TSF-FR-115`) | `TSF-CFG-009` | Every transition | `(state, severity, openedAt)`; `(subjectPersonId)` |
| `AbuseReport` | `caseId` | Filed → attached | `ACCEPTED`/`DUPLICATE`/`INVALID` | Reporter identity ≥ safety lead only | With case | On file, on read | `(caseId)`; `(reporterPersonId, filedAt)` for `TSF-BR-013` |
| `Evidence` | `caseId` | Attached, **never mutated** | — | Read = audited action (`TSF-FR-114`) | `TSF-CFG-010`, shortest clock | **Every read** | `(caseId)` |
| `EnforcementAction` | `caseId` + `PersonId` | Created → active → expired/reversed | `ACTIVE`/`EXPIRED`/`REVERSED` | Two actors for row 9 (`TSF-FR-069`) | With case | Create + reverse | `(personId, state, until)` |
| `StrikeRecord` | `PersonId` | On **upheld** action only | Active, decaying | Safety roles | Row retained; weight decays | On write + removal | `(personId, occurredAt)` |
| `Appeal` | `caseId` | Filed → decided | `FILED`/`UPHELD`/`MODIFIED`/`OVERTURNED` | Subject files; **different** moderator decides (`TSF-INV-013`) | With case | File + decide | `(caseId)`; `(state, filedAt)` for SLA |
| `CaseTransition` | `caseId` | Append-only | — | Read-only always | With case | Is itself the record | `(caseId, at)` |
| `RiskSignal` | `PersonId` | Computed, rolling | — | Safety roles; **advisory label** | `TSF-CFG-011` | On use in a case | `(personId, ruleId, window)` |
| `RiskAssessment` | `PersonId` | Computed on demand | — | Safety roles | Not retained beyond citing case | On use | `(personId, at)` |
| `SafetyPolicy` | Policy id + version | Versioned, immutable per version | `DRAFT`/`ACTIVE`/`RETIRED` | Safety lead publishes | Permanent | On publish | `(policyId, version)` |
| `EffectiveRestriction` | **`PersonId` (PK)** | Derived from active actions | — | Read by `BC-12` send-time check | Rebuildable | Rebuild logged | **`(personId)` point read** |

`TSF-FR-120` `EffectiveRestriction` **MUST** be a **single row per `PersonId`** and **MUST** be
rebuildable from `EnforcementAction` history, yielding identical output. It is a projection, never a
system of record — the same discipline BC Map **L383** imposes on `BC-21`'s `EntitlementSet`
(*"never hand-edited; recomputable"*).

`TSF-INV-020` No entity above **MUST** contain a `tenantId`, `StudentRecordId`, membership reference, fee
reference, seat reference or attendance reference (`TSF-INV-017`, `F-1`).

### 20.3 Vocabulary conformance

BC Map **L199–213** governs shared terms, and enforcement is real: *"a CI lint rule fails the build if a
banned bare term appears in a cross-context contract file."*

| Bare term | ⛔ Never | ✅ This PRD uses | Authority |
|---|---|---|---|
| `Report` | `Report` | **`AbuseReport`** | **L206** — `AnalyticalReport` is `BC-26`'s |
| `Role` | `Role` | `SafetyRole` (own), `AccessRole` (`BC-18`) | **L207**-class collision |
| `Profile` | `Profile` | `PublicProfile` (`BC-10`) | Language table |
| `Session` | `Session` | `BC-18`'s only; not modelled here | `ID-1` |
| `Member` | `Member` | Not used — `BC-13` has no members | `BC-02` owns it |

`TSF-XC-055` This PRD **MUST NOT** introduce the bare term `Report` into any contract, event, table or
API identifier. The brief's `SafetyReport` was already refused for the same reason as `TSF-XC-022`.

---

## 21. APIs & Events

### 21.1 The integration surface is two events, and that is the whole of it

BC Map §9 publishes exactly **two** `BC-13` events (**L432**, **L433**). §7's rule is absolute: *"If an
edge is not in this table, it does not exist and adding it requires an ADR."*

| ID | Event | Consumers | Payload | Authority |
|---|---|---|---|---|
| `TSF-EVT-001` | **`safety.AbuseReportFiled`** | `BC-24`, `BC-22` | `{caseId, category, severity, filedAt}` — ⛔ **no reporter identity**, ⛔ no content | **L432** |
| `TSF-EVT-002` | **`safety.EnforcementActionTaken`** | `BC-10`, `BC-11`, `BC-12`, `BC-14`, `BC-15`, `BC-24` | `{personId, action, scope, until}` — the **closed four-field shape** of **L318** | **L433**, `E-14` |

| ID | Requirement |
|---|---|
| `TSF-FR-121` | `BC-13` **MUST NOT** publish a third event in V1. `TSF-EVT-*` is a **two-entry closed register** for exactly this reason |
| `TSF-FR-122` | `TSF-EVT-001` **MUST NOT** carry the reporter's `PersonId` (`TSF-INV-009`), nor any evidence content |
| `TSF-FR-123` | `TSF-EVT-002` **MUST** be emitted through the transactional outbox and **MUST** be idempotent on `(caseId, actionId)`. A duplicate delivery **MUST NOT** produce a second restriction |
| `TSF-FR-124` | Reversal (§16.2) **MUST** be expressed as `TSF-EVT-002` with a past-dated or nulled `until`, **not** as a new event type — `TSF-FR-121` |

⚠ **`TSF-GAP-004`** *(carried forward)*. Appeal outcomes, case closure and risk-band changes have no
published event. Any consumer needing them requires a **Rank 4 amendment** to BC Map §9. Routed to the
**Architecture Owner**. `TSF-FR-124` is the workaround that keeps V1 inside the published surface.

### 21.2 Inbound: what `BC-13` consumes

Consumption is permitted where the publisher already publishes to `BC-13` per BC Map §9. No new edge is
claimed.

| Consumed | From | Use | Note |
|---|---|---|---|
| `messaging.MessageSent` | `BC-12` | Risk counters | ⚠ **Sampled (L431)** — `TSF-BR-027` |
| `social.FriendshipEstablished` / `UserBlocked` | `BC-11` | Acceptance ratio, block rate | **L430** publishes to `BC-12`, `BC-26` ⚠ |
| `identity.PersonAnonymised` | `BC-10` | `TSF-FR-089` | **L428** publishes to `BC-11`, `BC-12`, … ⚠ |
| `attendance.FraudSignalDetected` | `BC-03` | ⛔ **Not consumed** — see below | **L417** *does* list `BC-13` |

`TSF-XC-056` `attendance.FraudSignalDetected` is published to `BC-13` by **L417**, and this PRD
**deliberately does not consume it in V1**. It is tenant-side attendance fraud — a `BC-03` operational
matter under `X-05` — and consuming it would import a tenant signal into a global context, inviting the
`tenantId` that `TSF-INV-020` forbids. Recorded as a **conscious non-consumption**, not an oversight.

⚠ **`TSF-GAP-015`** *(new)*. Rows 2 and 3 above are marked ⚠ because BC Map **L430** and **L428** list
their consumers **without `BC-13`**. §14.3's acceptance-ratio and block-rate signals therefore rest on
subscriptions the Rank 4 register does not publish. This is the **third instance of the `ADR-0016` defect
class** — a requirement depending on an unlisted consumer cell. Two honest resolutions exist: amend the
consumer cells (Architecture Owner, per-signal necessity test as `ADR-0055` §3 did), **or** reduce §14.3
to the signals that survive without them (report velocity, repeat enforcement, coordination — all from
`BC-13`'s own case history). **This PRD does not choose.** Until it is resolved, `IMPL-1411` is blocked
and the affected signals are **specified but not implementable**.

`TSF-GAP-015` is disclosed rather than papered over because the alternative — quietly asserting a
subscription — is exactly what `ADR-0016` and `ADR-0055` exist to prevent, and the repository has now
caught this pattern twice before.

### 21.3 Command surface

`BC-13` has **no published inbound edge** (`F-3`), so every command below is internal to the safety
application, not a cross-context API.

| Command | Actor | Idempotency | Authorisation | Errors |
|---|---|---|---|---|
| `FileAbuseReport` | Any authenticated person | Client key + `(reporter, subject, category, window)` | Rate-limited by `BC-18`/edge | Uniform; never reveals whether a prior report exists |
| `TriageCase` | Moderator or rule | `(caseId, targetState)` | Safety role | — |
| `ClaimCase` | Moderator | `(caseId, moderator)` | Safety role | Conflict if claimed |
| `AttachEvidence` | Reporter (at filing) | Content hash | Reporter, own report | Append-only |
| `TakeEnforcementAction` | Moderator (×2 for row 9) | `(caseId, actionType, actor)` | Safety role + `TSF-INV-019` recusal | Rejected without policy citation |
| `FileAppeal` | **Subject only** | `(caseId, subject)` | Subject, once (`TSF-FR-076`) | Uniform outside window |
| `DecideAppeal` | Different moderator | `(appealId, decider)` | `TSF-INV-013` | Rejected if same actor or chain |

`TSF-FR-125` Every command **MUST** be idempotent on the key shown. Safety operations are retried by
clients under stress; a duplicate report **MUST NOT** become two accusations, and a duplicate action
**MUST NOT** become two strikes.

`TSF-FR-126` Authorisation failures on **all** safety endpoints **MUST** be indistinguishable from
not-found (`MP-GBR-22`). A distinguishable `403` on a case endpoint confirms a case exists.

⚠ **`TSF-GAP-003`** *(carried, and this is the blocking one)*. §10.1's synchronous send-time check needs
`BC-12` to **query** `BC-13`'s `EffectiveRestriction` inside a request. `BC-13` has **one edge, outbound,
event-only**. **There is no published sync transport.** BC Map **L468** *mandates* the check; the edge
table does not carry it. Routed to the **Architecture Owner**; `IMPL-1410` blocked. Two candidate
resolutions — a new `CF` sync port `BC-12 → BC-13`, or `BC-12` maintaining a locally projected
restriction cache fed by `TSF-EVT-002` — are **named, not chosen**. The second is attractive because it
adds no edge, and dangerous because a stale cache defeats the entire point of `L468`.

### 21.4 Why nothing here is ever deleted

*(This subsection satisfies the forward reference from §7.7.)*

Every API above adds, transitions or reverses. **None deletes.** Four measured authorities converge:

| Authority | Consequence |
|---|---|
| `MP-GBR-14` | Soft delete except legally compelled erasure |
| `MP-GBR-13` | Audit append-only; legal hold blocks purge |
| BC Map **L384** | `BC-24` — *"no update or delete path exists in code"* |
| `TSF-FR-083` | Overturned removals must be **restorable** — impossible after a hard delete |

| ID | Requirement |
|---|---|
| `TSF-FR-127` | There **MUST NOT** be a delete endpoint on any entity in §20. Removal of expired data happens through **retention purge** (§17.2), which is a scheduled system act with a policy behind it, not an operator action |
| `TSF-FR-128` | Reversal **MUST** be modelled as a new state plus a new transition, **never** as the erasure of the original. The record must show that we acted and then that we were wrong |
| `TSF-BR-031` | "Undo" **MUST NOT** exist as a concept in this system. Everything is either a forward transition or a reversal, and both are visible |

`TSF-BR-031` is the design's spine. In a system where a wrongly-restricted student's record can be
silently erased, `TSF-FR-064`'s false-positive rate becomes unmeasurable and `TSF-BR-025` becomes a
slogan. Keeping our mistakes on the record is what makes the accuracy commitments enforceable.

---

## 22. Security Integration

### 22.1 The `PRD-012a` ÷ `PRD-020` line

`PRD-012a` Security & Automation is **FROZEN**, owns `platform/security` at **rank 2**, uses prefix
`SECP-`, and holds **no `BC-nn`** (per `ADR-0060`). `PRD-020` owns `BC-13` at **rank 8**. The two are not
layered accidentally — rank 2 is infrastructure, rank 8 is domain — and the division follows.

| Concern | Owner | Why |
|---|---|---|
| Credentials, sessions, OTP, MFA | **`BC-18`** | `ID-1`; `TSF-XC-013` |
| Session revocation on suspension | **`BC-18`**, on `TSF-EVT-002` | `BC-13` publishes; `BC-18` self-restricts |
| Edge rate limiting, WAF, bot defence | **`PRD-012a`** | Infrastructure, rank 2 |
| Secret management, key rotation | **`PRD-012a`** | Infrastructure |
| Dependency & vulnerability scanning | **`PRD-012a`** | Infrastructure |
| Malware scanning of uploads | **`BC-29`** (`PRD-017`) | BC Map **L138** — *"upload, virus scan, thumbnailing"* |
| Security incident response | **`PRD-012a`** | Operational security |
| **Abuse by authenticated users** | **`PRD-020`** | This document |
| **Enforcement decisions on persons** | **`PRD-020`** | `BC-13` |

`TSF-XC-057` `PRD-020` **MUST NOT** define, duplicate or override any `SECP-*` requirement.
`PRD-012a` is **FROZEN**; a frozen document is not amended by a draft one.

`TSF-BR-032` **Security asks "is this request legitimate?"; safety asks "is this person harming
someone?"** A verified, authenticated, MFA-protected, rate-limit-compliant request from a real student
can still be abuse. That is why `BC-13` exists as a `[CORE]` context and not as a security feature.

### 22.2 What `BC-13` relies on and must not reimplement

| Reliance | Provider | `BC-13` obligation |
|---|---|---|
| Authenticated principal | `BC-18` | Trust it; never store credentials |
| Authorisation decision | `BC-18` | Request it; never cache a policy decision |
| Audit persistence | `BC-24`, `E-20` | Emit; never store its own audit log (`TSF-XC-046`) |
| Configuration | `BC-25`, `E-19` | Typed accessors; no raw string lookups |
| Notification delivery | `BC-22`, `E-23` | Emit facts; never send channels |
| File scanning | `BC-29` | ⛔ **Unreachable** — `F-4`, `TSF-GAP-005` |

### 22.3 File safety, restated as a security boundary

§11 and §12.4 established that `BC-13` cannot read a reported file. From a security standpoint this is
**a feature with a cost**, and both halves must be said:

- **The feature:** the safety context holds no `FileRef`, no bytes, and no storage path. A compromise of
  the moderation console yields **no file access whatsoever**. Given that the console is operated by
  humans with elevated privilege over minors' data, that is a materially strong containment property.
- **The cost:** a genuinely harmful uploaded file cannot be reviewed in V1, and §12.4 requires such cases
  to close as `UNRESOLVABLE_PENDING_ACCESS` so the cost is **counted** (`TSF-XC-036`).

`TSF-FR-129` The count of `UNRESOLVABLE_PENDING_ACCESS` closures **MUST** be a reported metric (§23). It
is the evidence base on which `ADR-0055` §3's per-context necessity test would be revisited — if the
number is small, the exclusion was right; if it is large, there is a measured case for an ADR. Either way
the decision becomes empirical rather than rhetorical.

---

## 23. Analytics & Observability

### 23.1 What must be measurable for this system to be trustworthy

A safety system that cannot report on itself cannot be held to `G-1`…`G-8`. But metrics are also an
exfiltration path, so §23.3 constrains them.

| Metric | Why | Alert |
|---|---|---|
| Open cases by severity and age | `TSF-FR-004` capacity | Backlog growth, oldest-`CRITICAL` age |
| Time to first human touch, `CRITICAL` | `G-6` | Breach of `TSF-CFG-005` — **pages** |
| Report intake p95 | `TSF-FR-002` | > 1 s |
| Send-time check p99 | `TSF-FR-001` — the `MP-RSK-02` mitigation | **> 50 ms, or any fail-open** |
| `TSF-EVT-002` publish→apply lag | `TSF-FR-003` | > 5 s p95 |
| Appeal SLA state | `TSF-FR-080`, `TSF-INV-016` | Any breach — **never** auto-uphold |
| Overturn rate, overall and per rule | `TSF-FR-064` | Above `TSF-CFG-020` → auto-demote |
| Automatic actions per hour | `TSF-FR-062` circuit breaker | Cap breach — **stop and page** |
| `UNRESOLVABLE_PENDING_ACCESS` count | `TSF-FR-129` | Trend review |
| Moderator evidence reads per moderator | `TSF-FR-118` | Anomalous volume |
| `NO_VIOLATION` rate per moderator | `TSF-BR-021` — both extremes are signals | Outlier either way |

`TSF-FR-130` A **fail-open** on the send-time check **MUST** be treated as a `SEV`-class operational
incident and alerted immediately. `TSF-FR-001` requires **fail closed**; an observed fail-open means the
`MP-RSK-02` mitigation is not in force.

`TSF-FR-131` The `NO_VIOLATION` rate **MUST** be monitored for outliers in **both** directions. A
moderator who never finds a violation may be inattentive; a moderator who always finds one is a
`TSF-BR-021` failure and a `TSF-BR-025` risk.

### 23.2 Where analytics live

`TSF-XC-058` `BC-26` Analytics Read Model owns the metric/semantic layer and projections (BC Map **L135**,
**L385**). `BC-13` **MUST NOT** build its own reporting store, and **MUST NOT** use the bare term `Report`
for a metric (`TSF-XC-055`; `AnalyticalReport` is `BC-26`'s, **L206**).

`TSF-FR-132` Safety metrics **MUST** be derived from the event stream and case store, and **MUST** be
rebuildable — BC Map **L385**: *"Fully rebuildable from the event log; no projection is a system of
record."*

### 23.3 Analytics as a privacy boundary

| ID | Requirement |
|---|---|
| `TSF-FR-133` | Safety metrics **MUST** be aggregate. No metric, dimension, drill-down or export **MUST** expose a `PersonId`, evidence content, or reporter identity |
| `TSF-FR-134` | Aggregates **MUST** be suppressed below `TSF-CFG-014` cell size. A count of 1 in a rare category is an identification |
| `TSF-XC-059` | Safety metrics **MUST NOT** be exposed in any tenant-facing dashboard, export or API — `TSF-XC-049`, `TSF-XC-050`. There **MUST NOT** be a per-library safety statistic, because a per-library figure over a small membership re-identifies students |
| `TSF-XC-060` | Safety metrics **MUST NOT** be dimensioned by tenant at all. `BC-13` holds no `tenantId` (`TSF-INV-020`), so such a dimension could only be created by joining across `X-05` |

`TSF-XC-059` deserves its bluntness. *"Safety incidents at your library: 3"* sounds like a reasonable
owner-facing feature and is, on a 40-student library, a near-identification of three named minors —
delivered to a party who is not a party to any of the three cases (`TSF-XC-042`).

### 23.4 Traceability of the risk engine

| ID | Requirement |
|---|---|
| `TSF-FR-135` | Every case opened by a rule **MUST** record the rule identifier and version, so that `TSF-FR-064`'s FP rate is attributable and `TSF-FR-065`'s demotion is possible |
| `TSF-FR-136` | Rule configuration changes **MUST** be audited by `E-20` with actor and before/after. A threshold change is a policy change |
| `TSF-FR-137` | The system **MUST** be able to answer, for any decided case: which rule version, which policy version, which moderator, which evidence, and which appeal outcome — from stored data, without reconstruction |

---

## 24. V1 Scope

### 24.1 In scope — and buildable today

| Capability | Sections | Depends on nothing unresolved |
|---|---|---|
| Report intake on person, message, profile | §12.1–12.3 | ✅ |
| `ModerationCase` aggregate + 7-state lifecycle | §13 | ✅ |
| Evidence attach, append-only, audited reads | §12.3, §19.4 | ✅ |
| Triage, dedup, severity routing, escalation queue | §12.5 | ✅ |
| The 9 enforcement actions for surfaces that exist in V1 (rows 1, 2, 3, 5, 6, 8, 9) | §15 | ✅ |
| Strike ladder with decay | §15.3 | ✅ |
| Appeals, one per action, different decider | §16 | ✅ |
| Rule-based risk on **own-case** signals (report velocity, repeat enforcement, coordination) | §14.3 | ✅ |
| `EffectiveRestriction` projection | §20.2 | ✅ |
| The two published events | §21.1 | ✅ |
| Global safety console, case-bound access, audited reads | §19 | ✅ |
| Retention, purge, legal hold, anonymisation handling | §17.2–17.3 | ✅ |
| Observability and the circuit breaker | §14.4, §23 | ✅ |

### 24.2 In scope — but **blocked** on a decision this PRD may not make

**This is the most important table in the document.** Each row is specified, testable and ready — and
cannot be built until someone with the authority decides. Shipping V1 without resolving rows 1 and 2
means shipping without the `MP-RSK-02` mitigation that BC Map **L468** mandates.

| # | Capability | Blocked by | Blocked task | Decision owner |
|---|---|---|---|---|
| 1 | **Synchronous send-time enforcement check** | `TSF-GAP-003` — no sync transport; `BC-13`'s only edge is outbound and event-only | `IMPL-1410` | **Architecture Owner** |
| 2 | Graph/messaging risk signals (acceptance ratio, block rate) | `TSF-GAP-015` — **L430**/**L428** consumer cells omit `BC-13` | `IMPL-1411` | **Architecture Owner** |
| 3 | `Friction` band (graduated rate-limit tightening) | `TSF-GAP-012` — `EnforcementActionTaken` is a closed 4-field shape | `IMPL-1412` | **Architecture Owner** |
| 4 | Minor-safety severity floor | `TSF-GAP-014` — no age-band accessor reaches `BC-13` | `IMPL-1417` | **Architecture Owner** + `BC-18` owner |
| 5 | Review of a reported **file** | `TSF-GAP-005` — `E-22` deliberately excludes `BC-13` (`ADR-0055` §3) | `IMPL-1418` | **Architecture Owner** |
| 6 | Verified library-affiliation checks | `TSF-GAP-008` — no attestation exists | `IMPL-1421` | **Product Owner** |
| 7 | Tenancy-level referral | `TSF-GAP-009` — no `BC-13`→`BC-19` transport | `IMPL-1424` | **Architecture Owner** |

`TSF-BR-033` Row 1 is **release-critical, not merely blocked.** `MP-RSK-02` is rated **Critical** and BC
Map **L468** names the send-time check as one of its three mitigations. If `TSF-GAP-003` is unresolved at
release, then `PRD-020` ships **without** a mitigation the Rank 4 architecture requires, and the
roadmap's `PRD-021` gate (Roadmap **L161**, **L164** — *"a release-blocking defect, not a schedule
change"*) rests on an incomplete foundation. This PRD **MUST NOT** be marked `READY` while row 1 is open.

### 24.3 Explicitly not in V1 — and why that is correct rather than convenient

| Deferred | Reason | Authority |
|---|---|---|
| Community & feed moderation (`BC-14`/`BC-15`) | Those contexts are **V2**; `grep moderator docs/30-product/` = **0 files**. There is nothing to moderate | BC Map **L118**/**L119**; registry **L391** |
| Library-scoped moderation console | `F-1` + `X-05`; route undecided (§18.3) | `TSF-GAP-001`/`002` |
| Enforcement rows 4 and 7 | Their executing contexts are V2 | §15.1 |
| Proactive content classification | §10.4; no read path, no classifier | `TSF-GAP-011` |
| Automated external-authority reporting | Jurisdictional/legal, not engineering | `TSF-XC-048` |
| ML/heuristic risk scoring | V1 is transparent by design | `TSF-FR-060` |
| Bulk enforcement | Deliberately absent | `TSF-FR-113` |
| Reporter reputation as a suppression mechanism | Allowed only for queue position | `TSF-BR-024` |

`TSF-XC-061` This PRD **MUST NOT** be read as pulling `BC-14` or `BC-15` into V1. Their V1/V2 placement is
a Rank 1/Rank 4 scope decision recorded at BC Map **L118**/**L119** and registry **L391**. An unranked
document does not move a context between releases.

---

## 25. Future Scope (V2+)

| Capability | Prerequisite | Note |
|---|---|---|
| Community & feed moderation | `BC-14`/`BC-15` exist | Inherits §13's lifecycle and §15's action set unchanged; `TSF-INV-018` binds it in advance |
| Library community console (route `R-2`) | §18.3 decision | **MUST** satisfy `TSF-INV-018` — authority ends at the library's own content |
| Proactive content classification | A read path + a classifier | `TSF-FR-060` still applies: unexplainable output stays non-actionable |
| ML-assisted risk | Labelled data from §14.5 + §16 | Must remain **advisory** (`TSF-BR-023`); explanation requirement does not lapse |
| Cross-platform signal sharing | Legal basis, residency (`BC-19`) | High privacy cost; not assumed |
| Automated authority reporting | `TSF-XC-048` resolved | Jurisdiction-specific |
| Trusted-flagger programme | Reputation model matured | `TSF-BR-024`'s `CRITICAL` exemption survives |
| Transparency reporting | `TSF-FR-133`/`134` aggregation | Suppression thresholds are mandatory, not optional |
| Saga-based multi-context enforcement | `BC-28` (V2) | Would replace §15's fan-out; `TSF-BR-026` still governs effective state |

`TSF-BR-034` No V2 capability **MUST** weaken a V1 invariant. Specifically: `TSF-INV-012` (no orphan
action), `TSF-INV-013` (independent appeal), `TSF-INV-017`/`020` (no tenant identifiers),
`TSF-INV-018` (library authority ceiling) and `TSF-INV-019` (recusal) are **permanent**. A V2 that needs
one of them relaxed needs an ADR, not a sprint.

---

## 26. Testing Strategy

Fourteen test classes. Each maps to an acceptance criterion in §27 and each is written so that a
**failing** test names a specific harm, not a specific implementation.

| # | Class | What it proves | Method |
|---|---|---|---|
| **T-1** | **Reporting** | Every surface can be reported; intake is idempotent; a duplicate is not a second accusation | Integration, per surface |
| **T-2** | **Lifecycle** | Only §13.2's transitions are reachable; `CLOSED` is terminal; no reopen | **State-machine exhaustive** — assert every *illegal* pair is rejected |
| **T-3** | **Attribution** | No `EnforcementAction` exists without a case, actor and policy citation | Property-based; attempt orphan creation and assert failure |
| **T-4** | **Enforcement propagation** | `TSF-EVT-002` reaches each consumer; idempotent on redelivery; no double restriction | Contract + duplicate-delivery |
| **T-5** | **Synchronous containment** | A suspended person cannot send, **before** propagation; p99 ≤ 50 ms; **fails closed** | Integration + fault injection ⚠ blocked by `TSF-GAP-003` |
| **T-6** | **Strike determinism** | Same history ⇒ same next action; decay applied; overturn removes the strike | Golden-case table |
| **T-7** | **Appeal independence** | Enforcer cannot decide own appeal; approval chain excluded; timeout **queues**, never auto-upholds | Negative-path |
| **T-8** | **Risk transparency** | Every signal is explainable and reproducible at a pinned rule version | Replay |
| **T-9** | **Circuit breaker** | Automatic actions stop at the hourly cap and page; auto actions expire on silence | Load + clock |
| **T-10** | **Tenant isolation** | No `tenantId`/`StudentRecordId` in any `BC-13` schema, payload, log or export | **Static + schema assertion**, plus `dart run tool/check_module_boundaries.dart` on `banned_symbols` |
| **T-11** | **Admin containment** | No tenant-session path reaches any `BC-13` surface; no per-library safety statistic exists | Authorisation matrix, negative |
| **T-12** | **Privacy & minimisation** | No message content retained outside case evidence; risk stores measures not observations; purge runs on the clock | Data-inspection + time-travel |
| **T-13** | **Indistinguishability** | Denial ≡ not-found across every safety endpoint; uniform latency and shape on the send-time check | **Timing + response-shape differential** |
| **T-14** | **Moderator accountability** | Evidence reads are audited; access is case-bound; no free-text search exists; recusal enforced | Integration + **negative capability** |

| ID | Requirement |
|---|---|
| `TSF-FR-138` | **T-2** **MUST** be exhaustive over the transition matrix, asserting rejection of every pair not in §13.2. Testing only the happy path in a state machine that governs suspensions is not testing |
| `TSF-FR-139` | **T-13** **MUST** assert timing indistinguishability, not merely equal status codes. `MP-GBR-22` is defeated by a measurable latency difference |
| `TSF-FR-140` | **T-10** **MUST** run in CI as a build-failing check, aligned with the existing `banned_symbols` enforcement at yaml **L265–267** |
| `TSF-FR-141` | **T-5 MUST NOT** be marked skipped-and-forgotten while `TSF-GAP-003` is open. It **MUST** fail loudly as *blocked*, so the missing mitigation stays visible in every CI run |

`TSF-FR-141` matters more than it looks. A skipped test is invisible; a failing blocked test is a standing
reminder that the `MP-RSK-02` mitigation is not yet in place.

`TSF-XC-062` Testing **MUST NOT** use real student data, real reports, or production evidence. A test
fixture that contains a real minor's message is a privacy incident in a repository.

---

## 27. Acceptance Criteria

62 criteria in Given/When/Then. Every criterion forward-referenced by §2's goals is defined here.

### 27.1 Reporting (`TSF-AC-001`…`010`)

| ID | Given / When / Then |
|---|---|
| `TSF-AC-001` | **Given** a signed-in student viewing a person's profile, **when** they report it, **then** a case is created and an acknowledgement is shown |
| `TSF-AC-002` | **Given** a received message, **when** reported, **then** the case is created and the message is attached as evidence with provenance `reporter-submitted` |
| `TSF-AC-003` | **Given** a profile field, **when** reported, **then** a case is created citing the field, not the whole person |
| `TSF-AC-004` | **Given** a reported **file**, **when** the case is opened, **then** the console shows *no read path* and offers `UNRESOLVABLE_PENDING_ACCESS` |
| `TSF-AC-005` | **Given** a community object in V1, **when** a report is attempted, **then** the surface is absent — not an error page |
| `TSF-AC-006` | **Given** the same report submitted twice with one client key, **when** both arrive, **then** exactly one `AbuseReport` exists |
| `TSF-AC-007` | **Given** two different reporters on the same subject and category inside the window, **when** both file, **then** both attach to **one** case and both are recorded |
| `TSF-AC-008` | **Given** a `CRITICAL` category, **when** a duplicate arrives, **then** it is **not** auto-closed (`TSF-BR-017`) |
| `TSF-AC-009` | **Given** any report, **when** it is stored, **then** the reporter's identity is absent from `TSF-EVT-001` |
| `TSF-AC-010` | **Given** a subject who was reported, **when** they use the product, **then** nothing in any response reveals that a report exists |

### 27.2 Lifecycle & attribution (`TSF-AC-011`…`024`)

| ID | Given / When / Then |
|---|---|
| `TSF-AC-011` | **Given** a case at `NEW`, **when** any transition not in §13.2 is attempted, **then** it is rejected and the state is unchanged |
| `TSF-AC-012` | **Given** a `CLOSED` case, **when** reopening is attempted, **then** it is rejected and a **new linked** case is offered |
| `TSF-AC-013` | **Given** a severity-`HIGH` case, **when** `TRIAGED → ACTIONED` is attempted directly, **then** it is rejected (`TSF-FR-057`) |
| `TSF-AC-014` | **Given** a `CRITICAL` minor-safety report and a queue of 10,000, **when** it arrives, **then** a human is paged within `TSF-CFG-005` — satisfies `G-6` |
| `TSF-AC-015` | **Given** any transition, **when** it completes, **then** an immutable `CaseTransition` exists with actor and reason |
| `TSF-AC-016` | **Given** a claimed case, **when** another moderator acts, **then** it is rejected absent recorded reassignment |
| `TSF-AC-017` | **Given** a breached SLA, **when** the case is reassigned, **then** the breach remains recorded |
| `TSF-AC-018` | **Given** a rule set that is disabled, **when** a report arrives, **then** it is still accepted and triageable (`TSF-BR-022`) |
| `TSF-AC-019` | **Given** a `NO_VIOLATION` resolution, **when** metrics are computed, **then** it counts as a **correct** outcome |
| `TSF-AC-020` | **Given** any `EnforcementAction`, **when** inspected, **then** it has a case, a named actor, a policy citation, and a scope — satisfies `G-2` |
| `TSF-AC-021` | **Given** an attempt to create an `EnforcementAction` without a case, **when** submitted, **then** it fails at the aggregate boundary |
| `TSF-AC-022` | **Given** a permanent termination by one actor, **when** submitted, **then** it is rejected pending a second actor |
| `TSF-AC-023` | **Given** a suspension without an expiry, **when** submitted, **then** it is rejected (`TSF-FR-070`) |
| `TSF-AC-024` | **Given** a case, **when** a moderator who is a named party attempts to act, **then** recusal is enforced (`TSF-INV-019`) |

### 27.3 Enforcement & containment (`TSF-AC-025`…`040`)

| ID | Given / When / Then |
|---|---|
| `TSF-AC-025` | **Given** a person suspended one millisecond ago, **when** they send a message **before** `TSF-EVT-002` is consumed, **then** the send **fails** — satisfies `G-5`, BC Map **L468**. ⚠ blocked by `TSF-GAP-003` |
| `TSF-AC-026` | **Given** the enforcement store is unreachable, **when** a send is attempted, **then** it **fails closed** and an incident is raised (`TSF-FR-130`) |
| `TSF-AC-027` | **Given** the send-time check under load, **when** measured, **then** p99 ≤ 50 ms |
| `TSF-AC-028` | **Given** `TSF-EVT-002` delivered twice, **when** consumed, **then** exactly one restriction exists |
| `TSF-AC-029` | **Given** overlapping restrictions, **when** effective state is read, **then** exactly one row answers *"what may this person do now?"* (`TSF-BR-026`) |
| `TSF-AC-030` | **Given** two persons with identical strike histories, **when** the next action is computed, **then** the recommendation is identical — satisfies `G-3` |
| `TSF-AC-031` | **Given** a strike past its decay half-life, **when** the ladder is computed, **then** its weight is reduced |
| `TSF-AC-032` | **Given** a non-upheld action, **when** the ladder is computed, **then** no strike is counted |
| `TSF-AC-033` | **Given** an account-takeover victim, **when** the case resolves, **then** **no strike** is recorded against the victim (`TSF-BR-005`) |
| `TSF-AC-034` | **Given** a `CRITICAL` first offence, **when** actioned, **then** rows 8–9 are reachable with two humans |
| `TSF-AC-035` | **Given** a global suspension, **when** the subject's library record is inspected, **then** membership, fees, seat and attendance are **unchanged** (`TSF-XC-040`/`041`) |
| `TSF-AC-036` | **Given** a global enforcement action, **when** notifications are inspected, **then** **no** library, owner or staff was notified (`TSF-XC-042`) |
| `TSF-AC-037` | **Given** an enforcement notice, **when** the subject has unsubscribed from notifications, **then** the notice is still delivered (`TSF-BR-030`) |
| `TSF-AC-038` | **Given** a content removal, **when** storage is inspected, **then** the content is soft-deleted, not erased (`TSF-XC-038`) |
| `TSF-AC-039` | **Given** any safety API, **when** a delete is attempted, **then** no such endpoint exists (`TSF-FR-127`) |
| `TSF-AC-040` | **Given** the hourly automatic-action cap is reached, **when** another rule trips, **then** the system **stops** and pages (`TSF-FR-062`) |

### 27.4 Appeals & correction (`TSF-AC-041`…`050`)

| ID | Given / When / Then |
|---|---|
| `TSF-AC-041` | **Given** an action taken by moderator M, **when** M attempts to decide its appeal, **then** it is rejected — satisfies `G-4` |
| `TSF-AC-042` | **Given** M's manager, **when** they attempt to decide M's appeal, **then** it is rejected (approval chain, `TSF-INV-013`) |
| `TSF-AC-043` | **Given** a suspended account, **when** the subject files an appeal, **then** the appeal channel is reachable (`TSF-FR-078`) |
| `TSF-AC-044` | **Given** an appeal SLA breach and no second moderator, **when** the clock expires, **then** the appeal is **queued**, never auto-upheld (`TSF-INV-016`) |
| `TSF-AC-045` | **Given** an appeal, **when** decided, **then** the outcome cannot be harsher than the original (`TSF-FR-081`) |
| `TSF-AC-046` | **Given** an overturned removal, **when** the appeal completes, **then** the content is **restored** |
| `TSF-AC-047` | **Given** an overturned action, **when** the ladder is computed, **then** no residual mark remains |
| `TSF-AC-048` | **Given** an appeal, **when** the subject reads it, **then** the reporter's identity is absent (`TSF-XC-044`) |
| `TSF-AC-049` | **Given** a reporter dissatisfied with `NO_VIOLATION`, **when** they attempt to appeal, **then** no appeal path exists for them (`TSF-XC-045`) |
| `TSF-AC-050` | **Given** an overturned action, **when** propagation completes, **then** the send-time check reflects it within `TSF-CFG-008` |

### 27.5 Risk, privacy, isolation (`TSF-AC-051`…`062`)

| ID | Given / When / Then |
|---|---|
| `TSF-AC-051` | **Given** any `RiskSignal`, **when** displayed, **then** it states rule, window, value, threshold and a human-readable sentence |
| `TSF-AC-052` | **Given** a pinned rule version and stored signals, **when** replayed, **then** the assessment is identical |
| `TSF-AC-053` | **Given** a risk score alone, **when** an action is attempted citing only it, **then** it is rejected (`TSF-BR-023`) |
| `TSF-AC-054` | **Given** a high-risk subject and a `LOW` category, **when** severity is computed, **then** severity is unchanged (`TSF-INV-014`) |
| `TSF-AC-055` | **Given** a rule whose FP rate exceeds its budget, **when** evaluated, **then** it is auto-demoted to `Observe` — satisfies `G-8` |
| `TSF-AC-056` | **Given** an overturned automatic action, **when** the rule's FP rate is computed, **then** the overturn is counted; and **no strike** persists against the subject |
| `TSF-AC-057` | **Given** any `BC-13` table, payload, log line or export, **when** inspected, **then** it contains **no** `tenantId` and **no** `StudentRecordId` (`TSF-INV-020`) |
| `TSF-AC-058` | **Given** a library-admin session, **when** any `BC-13` surface is requested, **then** the response is indistinguishable from not-found (`TSF-XC-049`/`050`) |
| `TSF-AC-059` | **Given** safety metrics, **when** dimensions are enumerated, **then** no per-library or per-tenant dimension exists (`TSF-XC-059`/`060`) |
| `TSF-AC-060` | **Given** a reported file with no read path, **when** the case closes, **then** it closes as `UNRESOLVABLE_PENDING_ACCESS` and is **counted** (`TSF-FR-129`) |
| `TSF-AC-061` | **Given** a moderator reading evidence, **when** the read completes, **then** an audit event exists naming moderator, case and artefact; and no free-text evidence search exists |
| `TSF-AC-062` | **Given** a subject who requests deletion during an open `CRITICAL` case, **when** anonymisation runs, **then** the case survives anonymised and the review completes (`TSF-FR-091`) |

---

## 28. Risks & Mitigations

Twelve risks. Rated on the Master PRD's scale. `TSF-RSK-001` is not a new risk — it **is** `MP-RSK-02`,
restated at this document's level of detail, because the registry already names `PRD-020` as *"the highest
unmitigated product risk in the register"* (**L323**).

| ID | Risk | Sev | Mitigation | Residual |
|---|---|---|---|---|
| `TSF-RSK-001` | **Minor-safety incident on the social product** (= `MP-RSK-02`) | **Critical** | §17.4 severity floor; `CRITICAL` escalation with a paged SLA; guardian consent gate (`ID-6`); **synchronous send-time check** (BC Map **L468**) | ⚠ **High while `TSF-GAP-003` and `TSF-GAP-014` are open** — two of the three named mitigations are not yet implementable |
| `TSF-RSK-002` | **Enforcement does not contain in time** — eventual consistency lets a suspended abuser keep messaging | **Critical** | `TSF-FR-030`/`031`, `TSF-INV-007`, fail-closed, p99 ≤ 50 ms | ⚠ **High** — `TSF-GAP-003`: the transport does not exist |
| `TSF-RSK-003` | **Automated mass false enforcement** — a rule restricts thousands at machine speed | **High** | `TSF-FR-062` hourly cap → stop and page; `TSF-INV-002` no automatic suspension; `TSF-FR-061` silence expires; `TSF-FR-065` auto-demotion | **Low** — the circuit breaker is buildable today |
| `TSF-RSK-004` | **Moderator insider abuse** — elevated access to minors' private messages | **High** | `TSF-FR-114` audited reads; `TSF-FR-115` case-bound; `TSF-FR-116` **no free-text search**; `TSF-INV-019` recusal; `TSF-FR-118` volume alerting | **Medium** — detection, not prevention; the role is necessarily privileged |
| `TSF-RSK-005` | **Cross-tenant leak of global safety intelligence** to a library admin | **High** | `TSF-XC-049`/`050`; `TSF-XC-059`/`060`; `TSF-INV-017`/`020`; **`X-05` Separate Ways is structural, not procedural** | **Low** — the identifier is banned by a machine-checked manifest |
| `TSF-RSK-006` | **Report system weaponised** — coordinated mass-reporting silences a target | **High** | `TSF-BR-010` accusation ≠ finding; `TSF-FR-055` never sort by count; `TSF-BR-013` reporter-abuse detection; `TSF-INV-014` risk cannot raise severity | **Medium** — cheap to attempt, so it must be measured continuously |
| `TSF-RSK-007` | **Grooming undetected** — the highest-consequence false negative | **Critical** | User reporting on every surface; `CRITICAL` routing; `TSF-XC-019` acknowledges the knowledge ceiling honestly | ⚠ **High** — V1 is reactive by design (§10.4); this is a scope decision, not a defect |
| `TSF-RSK-008` | **Safety system becomes a surveillance asset** | **High** | `TSF-FR-084` minimisation; `TSF-FR-086` measures not observations; `TSF-FR-085` no content retention; §17.2 purge on the clock | **Low–Medium** — depends on purge actually running (`TSF-FR-087`) |
| `TSF-RSK-009` | **Deletion used to escape investigation** | **High** | `TSF-FR-091` blocks silent anonymisation during an open `CRITICAL` case or legal hold; `TSF-FR-089` case survives anonymised | **Low** |
| `TSF-RSK-010` | **Moderation capacity exceeded** — queue grows faster than humans | **High** | `TSF-FR-004` 10,000-case design point; severity-then-age ordering; `TSF-BR-022` automation degrades gracefully; §23 backlog alerts | **Medium** — an operational and hiring risk, not solvable in code |
| `TSF-RSK-011` | **A blocked capability ships silently as "done"** | **High** | `TSF-FR-141` blocked tests fail loudly in CI; §24.2's table; `TSF-BR-033` forbids `READY` while row 1 is open | **Low** — provided §24.2 is read at the gate |
| `TSF-RSK-012` | **Two moderation systems diverge** — a future `R-2` library console develops its own vocabulary and ladder | **Medium** | `TSF-INV-018` recorded **in advance**; `TSF-BR-034` V1 invariants are permanent; §25 requires inheritance of §13/§15 | **Medium** — mitigation is documentary until `R-2` exists |

`TSF-BR-035` `TSF-RSK-001` and `TSF-RSK-002` **MUST** be re-rated at implementation gate. Their residual
ratings are **High** solely because `TSF-GAP-003` is open; resolving that one architectural question moves
both to **Low**. That is the single highest-leverage decision in this PRD, and it is why §24.2 row 1 is
listed first.

`TSF-RSK-007`'s residual is stated as **High** rather than mitigated, because the honest position is that
a reactive-only system on a minor-heavy platform carries real risk. §10.4 and `TSF-XC-019` record that as
a deliberate V1 choice with a named cost, not as a claim of coverage.

---

## 29. ADR Requirements

Nine ADRs. `ADR-0065` is the next free number (ADR-INDEX: 64 files, highest `ADR-0064`). **This PRD does
not author them** — an unranked document cannot amend Rank 4 — it specifies what each must decide.

| # | ADR | Decides | Rank touched | Owner | Blocks |
|---|---|---|---|---|---|
| 1 | **`ADR-0065`** | **The synchronous enforcement-check transport.** New `CF` sync port `BC-12 → BC-13`, **or** an event-fed projected cache in `BC-12`. Must satisfy BC Map **L468** | Rank 4 — BC Map §7 edge table | Architecture Owner | `IMPL-1410`, `TSF-RSK-002` |
| 2 | `ADR-0066` | Whether `BC-13` is admitted to the consumer cells at BC Map **L430**/**L428**. Per-signal necessity test, following `ADR-0055` §3's method | Rank 4 — BC Map §9 | Architecture Owner | `IMPL-1411`, `TSF-GAP-015` |
| 3 | `ADR-0067` | Whether `EnforcementActionTaken.action` admits a graduated `TIGHTEN_RATE_LIMITS` value, or the `Friction` band is dropped | Rank 4 — **L318** contract | Architecture Owner | `IMPL-1412`, `TSF-GAP-012` |
| 4 | `ADR-0068` | How an **age band** reaches `BC-13` without leaking a birth date. Event field, port, or none | Rank 4 + `BC-18` | Architecture Owner + `BC-18` owner | `IMPL-1417`, `TSF-GAP-014` |
| 5 | `ADR-0069` | Whether `BC-13` is admitted to `E-22` for **reported-file review only**, revisiting `ADR-0055` §3 on the evidence of `TSF-FR-129`'s metric | Rank 4 — `E-22` **L331** | Architecture Owner | `IMPL-1418`, `TSF-GAP-005` |
| 6 | `ADR-0070` | **The library-scoped moderation route** — `R-1`, `R-2` or `R-3` (§18.3). Must not breach `ID-2` or `TSF-INV-018` | Rank 4 + Rank 1 scope | Architecture Owner + Product Owner | `TSF-GAP-001`, `TSF-GAP-002` |
| 7 | `ADR-0071` | Whether a **third** `BC-13` event is published (appeal outcome / case closure), or `TSF-FR-124`'s workaround stands | Rank 4 — BC Map §9 | Architecture Owner | `TSF-GAP-004` |
| 8 | `ADR-0072` | Whether "Library official post" becomes an owned, reportable object — and which `BC-nn` owns it | Rank 4 + Rank 1 | Product Owner + Architecture Owner | `TSF-GAP-010` |
| 9 | `ADR-0073` | Whether verified **library affiliation** exists as an attestation, enabling impersonation enforcement beyond unverifiable-claim removal | Rank 1 product scope | Product Owner | `IMPL-1421`, `TSF-GAP-008` |

| ID | Requirement |
|---|---|
| `TSF-FR-142` | `ADR-0065` **MUST** be decided before `PRD-020` leaves `DRAFT`. Every other ADR above may be `Proposed` at that point; this one cannot, because `TSF-RSK-002` is **Critical** and BC Map **L468** already mandates the behaviour it enables |
| `TSF-FR-143` | Each ADR above **MUST** apply a **per-context necessity test** in the manner of `ADR-0055` §3, rather than admitting `domain/social` wholesale. The map is context-grained where the manifest is module-grained (`GCP-23`), and that asymmetry must be preserved |
| `TSF-XC-063` | This PRD **MUST NOT** be cited as the authority for any decision above. It supplies the requirement and the evidence; the ADR supplies the decision |

`TSF-FR-143` is the lesson the repository has already learned twice. `ADR-0016` and `ADR-0055` both
resolved this same defect class, and `ADR-0055` §3 established the better method by testing `BC-11` and
`BC-13` **separately** and admitting neither. Repeating that discipline here is what keeps `BC-13` from
acquiring capabilities it does not need simply because a sibling context needed one.

---

## 30. Implementation Checklist

`IMPL-1400`…`1449`. Range measured free at `PRD-012a_IMPLEMENTATION_TASKS.md` **L140** — *"`IMPL-1400` + |
Unallocated"*. `IMPL-1450`…`1499` reserved for the V2 community work of §25.

### 30.1 Foundation — buildable today

| Task | Work | Verifies |
|---|---|---|
| `IMPL-1400` | `ModerationCase` aggregate + `CaseTransition`, one transaction | `TSF-INV-012`, `TSF-AC-021` |
| `IMPL-1401` | The 7-state machine with **rejection of every illegal pair** | `TSF-FR-138`, `TSF-AC-011`/`012`/`013` |
| `IMPL-1402` | `AbuseReport` intake, idempotent, uniform responses | `TSF-AC-006`, `TSF-FR-126` |
| `IMPL-1403` | `Evidence` append-only + provenance | `TSF-INV-010`, `TSF-AC-002` |
| `IMPL-1404` | Severity table + dedup + routing + escalation queue | `TSF-AC-007`/`008`/`014` |
| `IMPL-1405` | `SafetyPolicy` versioning; citation required on action | `TSF-FR-111`, `TSF-AC-020` |
| `IMPL-1406` | `EnforcementAction` with scope/expiry validation; two-actor gate on row 9 | `TSF-FR-069`/`070`, `TSF-AC-022`/`023` |
| `IMPL-1407` | `StrikeRecord` + decay + upheld-only rule | `TSF-AC-030`/`031`/`032` |
| `IMPL-1408` | `EffectiveRestriction` single-row projection, rebuildable | `TSF-FR-120`, `TSF-AC-029` |
| `IMPL-1409` | The two events through the transactional outbox, idempotent | `TSF-EVT-001`/`002`, `TSF-AC-028` |

### 30.2 Blocked — do not start before the ADR

| Task | Work | Blocked by | ADR |
|---|---|---|---|
| ⛔ `IMPL-1410` | **Synchronous send-time check**, fail-closed, p99 ≤ 50 ms | `TSF-GAP-003` | `ADR-0065` |
| ⛔ `IMPL-1411` | Graph/messaging risk signals | `TSF-GAP-015` | `ADR-0066` |
| ⛔ `IMPL-1412` | `Friction` band rate-limit recommendation | `TSF-GAP-012` | `ADR-0067` |
| ⛔ `IMPL-1417` | Minor-safety severity floor from an age band | `TSF-GAP-014` | `ADR-0068` |
| ⛔ `IMPL-1418` | Reported-file review path | `TSF-GAP-005` | `ADR-0069` |
| ⛔ `IMPL-1421` | Verified library-affiliation enforcement | `TSF-GAP-008` | `ADR-0073` |
| ⛔ `IMPL-1424` | `BC-13` → `BC-19` referral transport | `TSF-GAP-009` | — (`TSF-GAP-009`) |

### 30.3 Risk engine, appeals, privacy

| Task | Work | Verifies |
|---|---|---|
| `IMPL-1413` | Own-case signals (velocity, repeat enforcement, coordination) | `TSF-AC-051` |
| `IMPL-1414` | `RiskAssessment` with pinned rule version, replayable | `TSF-FR-059`, `TSF-AC-052` |
| `IMPL-1415` | **Circuit breaker** — hourly cap, stop and page; auto-expiry on silence | `TSF-FR-061`/`062`, `TSF-AC-040` |
| `IMPL-1416` | FP-rate computation + auto-demotion | `TSF-FR-064`/`065`, `TSF-AC-055` |
| `IMPL-1419` | Appeal intake **reachable while suspended** | `TSF-FR-078`, `TSF-AC-043` |
| `IMPL-1420` | Independent-decider enforcement incl. approval chain; queue-on-timeout | `TSF-INV-013`/`016`, `TSF-AC-041`/`042`/`044` |
| `IMPL-1422` | Reversal propagation + content restore | `TSF-FR-082`/`083`, `TSF-AC-046`/`050` |
| `IMPL-1423` | Strike removal on overturn, no residual mark | `TSF-FR-073`, `TSF-AC-047` |
| `IMPL-1425` | Retention clocks + automatic purge + legal hold | `TSF-FR-087`/`088` |
| `IMPL-1426` | `PersonAnonymised` handling; block escape-by-deletion | `TSF-FR-089`/`091`, `TSF-AC-062` |
| `IMPL-1427` | Guardian disclosure limited to `guardianOf` scope | `TSF-FR-095` |

### 30.4 Console, isolation, observability

| Task | Work | Verifies |
|---|---|---|
| `IMPL-1428` | Queue: severity-then-age, no count sort, 10,000-case performance | `TSF-FR-105`/`106`, `TSF-AC-019` |
| `IMPL-1429` | Claim / reassign / SLA display, breach not clearable | `TSF-FR-107`/`108`, `TSF-AC-016`/`017` |
| `IMPL-1430` | Case view with **advisory-labelled** risk + recommendation | `TSF-FR-110`, `TSF-AC-053` |
| `IMPL-1431` | Audited evidence reads; **case-bound access; no free-text search** | `TSF-FR-114`/`115`/`116`, `TSF-AC-061` |
| `IMPL-1432` | Recusal enforcement | `TSF-INV-019`, `TSF-AC-024` |
| `IMPL-1433` | Separate console surface, platform-role auth only | `TSF-XC-052`, `TSF-AC-058` |
| `IMPL-1434` | `UNRESOLVABLE_PENDING_ACCESS` closure + counter | `TSF-FR-129`, `TSF-AC-060` |
| `IMPL-1435` | **CI check: no `tenantId` / `StudentRecordId` anywhere in `BC-13`** | `TSF-INV-017`/`020`, `TSF-FR-140`, `TSF-AC-057` |
| `IMPL-1436` | Denial ≡ not-found across all endpoints, **incl. timing** | `TSF-FR-126`/`139`, `TSF-AC-010`/`058` |
| `IMPL-1437` | Aggregate-only metrics with cell suppression; **no tenant dimension** | `TSF-FR-133`/`134`, `TSF-AC-059` |
| `IMPL-1438` | Alerting: fail-open, SLA breach, cap breach, moderator read volume | `TSF-FR-130`, `TSF-FR-118` |
| `IMPL-1439` | Config accessors via `E-19` for all 21 `TSF-CFG-*` | `TSF-FR-063` |
| `IMPL-1440` | Audit emission via `E-20` on every decision and config change | `TSF-FR-136`/`137` |
| `IMPL-1441` | Notification facts via `E-23`; unsubscribe cannot suppress a notice | `TSF-BR-030`, `TSF-AC-037` |

### 30.5 Test build-out

| Task | Work |
|---|---|
| `IMPL-1442` | T-1, T-2 (exhaustive), T-3 |
| `IMPL-1443` | T-4, **T-5 as a loud blocked failure** (`TSF-FR-141`) |
| `IMPL-1444` | T-6, T-7 |
| `IMPL-1445` | T-8, T-9 |
| `IMPL-1446` | T-10, T-11 |
| `IMPL-1447` | T-12, T-13 |
| `IMPL-1448` | T-14 |
| `IMPL-1449` | Full `TSF-AC-001`…`062` traceability sweep |

### 30.6 Governance actions this document does **not** perform

⛔ **No repository file was modified to produce this PRD.** The following are required and are **not
mine to execute** (§0.6):

| # | Action | Owner | Gap |
|---|---|---|---|
| 1 | `PRD_REGISTRY.md` **L320** `PLANNED` → `DRAFT` | Governance Owner | `TSF-GAP-013` |
| 2 | `PRD_OWNERSHIP_MODEL.md` **L202** register the `TSF-` prefix and `IMPL-1400`…`1449` | Governance Owner | `TSF-GAP-013` |
| 3 | `PRD_DEPENDENCY_GRAPH.md` **L118** re-state `D-16` now that `PRD-020` has a specification | Governance Owner | `TSF-GAP-013` |
| 4 | `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L152** Wave 4.1 status | Governance Owner | `TSF-GAP-013` |
| 5 | Open `ADR-0065`…`ADR-0073` as `Proposed` | Architecture Owner | §29 |
| 6 | Decide `ADR-0065` before `DRAFT` is left | Architecture Owner | `TSF-FR-142` |

`TSF-FR-144` This document **MUST NOT** be treated as conferring `DRAFT` status on itself, and **MUST
NOT** be cited as authority against any ranked document. It is **Unranked** (header), and its value is the
measurement it carries, not the standing it claims.

---

## Document control

| | |
|---|---|
| **Written at** | `9226f86`, 2026-08-22 |
| **Status** | `DRAFT` v0.1 — Stage 2 |
| **Rank** | **Unranked** |
| **Repository changes made by this document** | **None.** One new untracked file |
| **Blocking decision** | `ADR-0065` — the synchronous enforcement-check transport (`TSF-GAP-003`) |
