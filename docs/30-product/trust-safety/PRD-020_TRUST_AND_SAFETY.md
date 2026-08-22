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
