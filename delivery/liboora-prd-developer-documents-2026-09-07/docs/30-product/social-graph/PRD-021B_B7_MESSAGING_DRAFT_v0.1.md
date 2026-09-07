<!--
  PRD-021B — Part B7 — 1-to-1 Messaging & Conversation System
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B7 specification, reconciled against MEASURED
  repository authority. Where the two differ, the repository prevails and the
  difference is recorded as a conflict with a named owner.

  ⚠⚠ THE ONE MEASUREMENT THAT DETERMINES THIS ENTIRE DOCUMENT'S SHAPE
  -------------------------------------------------------------------
  The supplied specification asks B7 to define "Conversation / Participant /
  Message ownership".

  MEASURED — LIBOORA_BOUNDED_CONTEXT_MAP.md (Rank 4) L116:

      | **BC-12** | **Messaging** | `[SUPPORTING]` | Global Student | V1 |
        Owns conversations and messages, delivery guarantees, retention,
        presence. |

  MEASURED — PRD-020 (FROZEN) Section 10 L633-634, an explicit "Ownership guard":

      "BC-12 owns conversations, messages, delivery and retention. T&S owns
       the restriction and the report."

  MEASURED — BC Map Section 8 L378, the registered aggregate row:

      | BC-12 Messaging | `Conversation` | `Message`, `DeliveryReceipt`,
        `RetentionPolicy` | Participants must satisfy `canMessage` at send
        time; message immutable after delivery; retention purge is
        irreversible and audited |

  => BC-12 ALREADY OWNS every capability B7 was asked to assign. Ownership is
     therefore NOT B7's to confer. B7 is a SPECIFICATION OF BC-12, written by
     PRD-021, which BC-12 is already allocated to (PRD_REGISTRY 4.2 L321:
     "PRD-021 Social Graph & Messaging = BC-11, BC-12").

     B7 SPECIFIES. IT DOES NOT OWN, AND IT DOES NOT ASSIGN OWNERSHIP.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 and Stage 4 NOT entered.

  What this file does NOT do
    - It creates no bounded context. The count remains 31 (23 in V1).
    - It creates no integration edge. It USES E-14, E-16, E-19, E-20, E-22,
      E-23 — all pre-existing.
    - It mints no published event. BC-12's published surface stays at ONE:
      `messaging.MessageSent` (BC Map L431).
    - It proposes no new BC Map Section 8 aggregate or entity row.
    - It does not own Block, the RateLimitCounter, Identity, Profile,
      Membership, Notification, Realtime or Media.
    - It allocates no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — Part B7

## 1-to-1 Messaging & Conversation System — a specification of `BC-12`

> ⛔ **This is a Stage-2 `DRAFT`.** It is not approved, not frozen, not
> baselined, not implementation-ready. It confers no lifecycle stage on itself.
>
> ⭐ **It is a specification, not an allocation.** `BC-12` Messaging already
> owns conversations, messages, delivery guarantees, retention and presence by
> **Rank 4** BC Map **L116**, reinforced by **FROZEN** `PRD-020` §10's
> ownership guard. B7 states *how* that owned capability behaves. It does not
> state *who* owns it, because that is already settled and not B7's to settle.

---

## §0. Document control

| Field | Value |
|---|---|
| Document | `PRD-021B` Part **B7** — 1-to-1 Messaging & Conversation System |
| Version | **v0.1** |
| Status | **`DRAFT`** — `PRD_REGISTRY.md` §2 vocabulary |
| Lifecycle stage | **Stage 2 (Draft)**. ⛔ Stage 3 NOT entered — its gate is *"a written alignment record naming every conflict and its disposition"* (`PRD_LIFECYCLE.md` L88–106) and no such record exists for B7 |
| Parent | `PRD-021` Social Graph & Messaging — `PRD_REGISTRY.md` §4.2 **L321**, status **`PLANNED`** |
| Bounded context | **`BC-12` Messaging** — **existing**, BC Map **L116**, `[SUPPORTING]`, Global Student, **V1**. ⛔ No context created |
| Identifier stem | **`MSG-`** — measured **0** repository-wide occurrences before authoring; no existing namespace shadowed |
| Ranks this document holds | **None.** `DOCUMENTATION_BASELINE.md` §3/§4 contain **0** `PRD-021B` rows. B7 is **unranked** and cannot overrule Rank 1–6 |
| Owner | Unchanged — `PRD_OWNERSHIP_MODEL.md` **L203**: Product Owner · Social Domain · **ARB** · Platform Engineering |
| Freeze | ⛔ **NOT FROZEN.** No baseline row written and none requested |

### §0.1 Status header

**`PRD-021B` Part B7 — `DRAFT` v0.1 — Stage 2 — NOT FROZEN — NOT APPROVED.**
This header is the `PRD_REGISTRY.md` §2 Stage-2 entry evidence: *"A document on
disk with a version header."*

### §0.2 Authority order applied throughout

| Rank | Document | Effect on B7 |
|---|---|---|
| 1 | `MASTER_PRD.md` | Binding |
| 3 | **FROZEN** `PRD-017` File & Media, **FROZEN** `PRD-020` Trust & Safety | Binding. B7 cites; B7 never reinterprets |
| 4 | BC Map · Module Dependency Matrix · `ARCHITECTURE_RULINGS.md` | Binding. Ownership, edges, events, invariants all come from here |
| 5 | ADRs (`ADR-0055`, `ADR-0065`, `ADR-0083`, `ADR-0091`) | Binding |
| 6 | Enterprise Architecture | ⚠ **Descriptive.** `DOCUMENTATION_BASELINE.md` states twice that the EA *"must follow the PRDs, never lead them."* Cited for wave intent; **overtaken** by Rank 1–4 where they differ (`ADR-0061` precedent: a higher rank prevails **without editing the EA**) |
| — | **This document** | **Unranked `DRAFT`.** Subordinate to all of the above |

---

## §B7.1 ⭐ `XPB-CONF-006` — the ownership conflict, and its disposition

### §B7.1.1 The conflict

The supplied specification asks B7 to establish ownership of `Conversation`,
`Participant` and `Message`.

### §B7.1.2 The authoritative source

| Source | Rank | Text |
|---|---|---|
| BC Map **L116** | **4** | `BC-12` *"Owns conversations and messages, delivery guarantees, retention, presence."* |
| `PRD-020` §10 **L633** | **3, FROZEN** | *"`BC-12` owns conversations, messages, delivery and retention. T&S owns the **restriction** and the **report**."* |
| BC Map **L378** | **4** | Aggregate root **`Conversation`**; entities **`Message`**, **`DeliveryReceipt`**, **`RetentionPolicy`** |
| `PRD_REGISTRY.md` §4.2 **L321** | unranked register | `PRD-021` = `BC-11`, `BC-12` |

### §B7.1.3 Is it already resolved?

**Yes — completely.** Ownership is fixed at Rank 4 and re-stated by a FROZEN
Rank 3 PRD. There is no open question.

### §B7.1.4 The repository decision, preserved

`BC-12` owns it. B7 does not.

### §B7.1.5 The smallest compatible resolution

⭐ **B7 is re-framed from an ownership document into a specification document.**
Nothing is dropped from the supplied product intent; every capability the
specification asks for is stated as a **requirement on `BC-12`**, authored by
`PRD-021`, to which `BC-12` is already allocated. The word *"owns"* is replaced
throughout by *"specifies"*, and the ownership section becomes a **restatement
with citation** rather than a claim.

⛔ **This costs nothing and changes no requirement.** It changes who the document
says is in charge — from "B7" to "`BC-12`, already" — which is the only honest
reading available.

### §B7.1.6 ⭐ The sharper half — `Participant` and `MessageRequest` are NOT registered entities

**Measured.** BC Map **L378** registers, for `BC-12`, exactly one aggregate root
and exactly three entities. **`Participant` is not among them. `MessageRequest`
is not among them.**

| Supplied name | Rank 4 status | B7's disposition |
|---|---|---|
| `Conversation` | ✅ **Registered aggregate root** | Specified as such |
| `Message` | ✅ **Registered entity** | Specified as such |
| `DeliveryReceipt` | ✅ **Registered entity** — ⚠ the supplied spec omitted it | Specified; **added back** |
| `RetentionPolicy` | ✅ **Registered entity** — ⚠ the supplied spec omitted it | Specified; **added back** |
| `Participant` | ⛔ **NOT registered** | Specified **only as an internal of the `Conversation` aggregate** (`MSG-XC-001`) |
| `MessageRequest` | ⛔ **NOT registered** | Specified **only as a state of `Conversation`** (`MSG-XC-002`), not a peer entity |

⛔ **B7 proposes NO amendment to BC Map §8.** Adding an entity row is a **Rank 4
change** requiring an ADR (`DOCUMENTATION_BASELINE.md` §7 rule 1), and B7 is a
Stage-2 draft with no such authority. Expressing `Participant` and
`MessageRequest` as aggregate internals is the **smallest compatible
resolution**: it needs no Rank 4 change at all, because a Rank 4 aggregate row
constrains the *registered* model surface, not the internal composition of an
aggregate.

`MSG-XC-001` — `Participant` **MUST** be modelled **inside** the `Conversation`
aggregate boundary. It **MUST NOT** be a separately registered entity, **MUST
NOT** be independently addressable by an external context, and **MUST NOT**
appear in any BC Map §8 amendment proposed by this document.

`MSG-XC-002` — `MessageRequest` **MUST** be modelled as a **state of
`Conversation`** (`MSG-BR-004`'s enum), not as a distinct registered entity. Its
safety rules are **FROZEN** `PRD-020` §10.2's and are **not restated as B7's
own** (`MSG-XC-010`).

---

## §B7.2 ⭐ Verification of the 17 supplied items against measured authority

The supplied specification names 17 items. This section reports, per item,
whether the repository **supports**, **constrains**, or **does not support** it.
⚠ **One item is not supported at all, and eight are constrained.** They are
recorded here rather than authored as though they were clean.

| # | Supplied item | Measured repository position | Verdict |
|---|---|---|---|
| 1 | 1-to-1 conversations | BC Map **L116** V1; EA **L946** `One-to-One Chat (V1)` | ✅ **SUPPORTED — V1** |
| 2 | `Conversation`/`Participant`/`Message` ownership | BC Map **L116**, **L378**; `PRD-020` §10 guard | ⚠ **CONSTRAINED** — owned by `BC-12` already; `Participant` not a registered entity (§B7.1.6). `XPB-CONF-006` |
| 3 | `MessageRequest` | **FROZEN** `PRD-020` §10.2 `TSF-FR-032`…`035` owns the **rules**; `TSF-BR-011` puts the **counter** in `BC-11`'s `RateLimitCounter` | ⚠ **CONSTRAINED** — B7 specifies the record; ⛔ **not** the rules, ⛔ **not** the counter. `XPB-CONF-010` |
| 4 | Help → Message flow | **Measured 0 lines.** `LCN-EVT-007` **WITHDRAWN** by `ADR-0083` L237; `LCN-FR-019` **VOID** (A7 L459) | ⛔ **NOT SUPPORTED.** `XPB-CONF-011`, **OPEN** |
| 5 | Message lifecycle | BC Map **L378** invariant *"message immutable after delivery"* | ✅ **SUPPORTED — constrained** |
| 6 | Idempotency | No Rank 1–4 rule measured for `BC-12`. `PRD-021A` A8 §16 is a peer **draft**, not authority | ✅ **SUPPORTED — B7 may specify** (no conflict) |
| 7 | Ordering | No Rank 1–4 rule measured. BC Map **L116** *"delivery guarantees"* is `BC-12`'s to define | ✅ **SUPPORTED — B7 may specify** |
| 8 | Unread / read state | ⚠ `DeliveryReceipt` **is** a registered entity (**L378**). But EA **L950** dates `Read Receipts & Presence` **V2** | ⚠ **SPLIT** — unread **count** V1; **read receipt disclosure to the sender** is an **owner decision** (`XPB-CONF-014`) |
| 9 | Archive | No Rank 1–4 rule. A per-participant view state | ✅ **SUPPORTED — B7 may specify** |
| 10 | Context references | ⚠ Requires a source. Only `E-16` (`canMessage`) inbound and `E-22` (`FileRef`) outbound exist for `BC-12` | ⚠ **CONSTRAINED** — opaque, un-dereferenced references only (`MSG-FR-024`) |
| 11 | Block / mute integration | `E-16` **L320** *"`canMessage(a, b)` — Messaging must ask; block enforcement lives in the graph"*; `SGR-XC-004`; `SGR-BR-013` | ✅ **SUPPORTED — via `E-16` only.** ⛔ Block is **`BC-11`'s `BlockList`** |
| 12 | Membership independence | BC Map **L488** rule `ID-2`; Matrix **L354** `X-05`; `MP-GBR-08` | ✅ **SUPPORTED — mandatory** |
| 13 | APIs | Matrix **L49** `L2`, **L90** social cluster; `PG-1`…`PG-4` (BC Map §15.3) | ✅ **SUPPORTED — constrained** |
| 14 | Events | BC Map **L431** — `messaging.MessageSent` is the **only** `messaging.*` event in the entire map | ⚠ **CONSTRAINED** — ⛔ B7 mints **none**. `MSG-XC-006` |
| 15 | Realtime hand-off | ⛔ **No realtime bounded context exists** (31 counted). `platform/services:realtime` is a **port** (manifest **L243**); EA **L1847** is a **platform service** | ⚠ **CONSTRAINED** — port, not context. Detailed in **B8** |
| 16 | Notification hand-off | `E-23` **L332** *"All contexts → `BC-22` · `PL` · Event · Domain emits facts, never 'send an SMS'"* | ✅ **SUPPORTED — via `E-23` only** |
| 17 | Retention / security | `RetentionPolicy` registered (**L378**); invariant *"retention purge is irreversible and audited"*; EA **L948** dates `Message Retention Policy` **V2** | ⚠ **SPLIT** — the entity and invariant are **V1**; a **configurable** policy surface is an **owner decision** (`XPB-CONF-015`) |

**Measured tally: 8 supported · 8 constrained or split · 1 not supported.**

---

## §B7.3 ⛔ Ownership refusal register — what B7 does not own

⭐ Stated as a register because `PRD_LIFECYCLE.md` L104–106's discipline —
*"A review that records only accepted findings is indistinguishable from a
review that found nothing"* — applies equally to a specification that records
only what it claims.

| ID | Refusal | Real owner + citation |
|---|---|---|
| `MSG-XC-003` | ⛔ B7 **MUST NOT** create a bounded context | Count is **31** (23 V1), BC Map §4. Creating one needs an ADR |
| `MSG-XC-004` | ⛔ B7 **MUST NOT** create an integration edge | BC Map **L292**: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."* Edge set = `E-01`…`E-26`, `E-28`, `E-29`; **`E-27` permanently vacant** (**L614**) |
| `MSG-XC-005` | ⛔ B7 **MUST NOT** own `Block` or `BlockList` | **`BC-11`** — `E-16` **L320**, `SGR-XC-004`. `SGR-BR-013`: *"Block overrides friendship"* |
| `MSG-XC-006` | ⛔ B7 **MUST NOT** mint a published event | `BC-12`'s surface stays at **one**: `messaging.MessageSent`, BC Map **L431** |
| `MSG-XC-007` | ⛔ B7 **MUST NOT** own the message-request rate counter | **`BC-11`'s `RateLimitCounter`** — `TSF-BR-011`: *"Two counters for one fact is how they drift apart"* |
| `MSG-XC-008` | ⛔ B7 **MUST NOT** own Identity, credentials, sessions, devices or OTP | **`BC-18`** — BC Map **L127**; rule **`ID-1`** (**L178**): *"No context outside `BC-18` may store a password, OTP, session or credential"* |
| `MSG-XC-009` | ⛔ B7 **MUST NOT** own the global person profile, username or privacy settings | **`BC-10`** — BC Map **L114**, **L378** `GlobalStudentProfile` |
| `MSG-XC-010` | ⛔ B7 **MUST NOT** own messaging-safety rules or enforcement | **`BC-13`** owns restriction + report (`PRD-020` §10 guard); the send-time check's transport is decided by **`ADR-0065`** (Option B). Detailed in **B8** |
| `MSG-XC-011` | ⛔ B7 **MUST NOT** own library membership, enrolment or any tenant-scoped record | **`BC-02`/`BC-01`** — Matrix **L354** `X-05` *"Separate Ways"* |
| `MSG-XC-012` | ⛔ B7 **MUST NOT** own notification channel selection, templates, quiet hours or consent | **`BC-22`** — BC Map **L131**; reached only by `E-23` |
| `MSG-XC-013` | ⛔ B7 **MUST NOT** own realtime transport, connections, fan-out or scaling | **`platform/services:realtime`** — a **port**, manifest **L243**; EA **L1847** platform service. ⛔ **Not a bounded context** |
| `MSG-XC-014` | ⛔ B7 **MUST NOT** own file bytes, upload, virus scan, thumbnailing, signed URLs or storage | **`BC-29`** — BC Map **L138**; **FROZEN** `PRD-017`. Reached only by `E-22` |
| `MSG-XC-015` | ⛔ B7 **MUST NOT** own friendship or friend requests | **`BC-11`** — BC Map **L377** `Friendship` · `FriendRequest` |
| `MSG-XC-016` | ⛔ B7 **MUST NOT** own search indexing or ranking | **`BC-23`** — BC Map **L132**; Matrix **L357** `X-08` |
| `MSG-XC-017` | ⛔ B7 **MUST NOT** own the audit trail or configuration store | **`BC-24`** (`E-20`), **`BC-25`** (`E-19`) |
| `MSG-XC-018` | ⛔ B7 **MUST NOT** propose a BC Map §8 aggregate or entity row | §B7.1.6. That is a Rank 4 change requiring an ADR |
| `MSG-XC-019` | ⛔ B7 **MUST NOT** allocate an `IMPL-*` identifier or create an implementation task | Stage 5 discipline; Stage 5 **not entered** |
| `MSG-XC-020` | ⛔ B7 **MUST NOT** store a `tenantId` or a `StudentRecordId` | rule **`ID-2`** (BC Map **L488**); manifest `banned_symbols`: `TenantId` → *"nothing — social data is not tenant-scoped"* |

**20 refusals** (`MSG-XC-001`…`MSG-XC-002` in §B7.1.6, `MSG-XC-003`…`MSG-XC-020` here).

---

## §B7.4 Edges B7 uses — all pre-existing, none created

| Edge | BC Map line | Direction | Mechanism | B7's use |
|---|---|---|---|---|
| `E-14` | **L318** | `BC-13` → `BC-12` | `PL` Event | `safety.EnforcementActionTaken` feeds `BC-12`'s **local** enforcement read model per `ADR-0065` Option B. ⛔ `BC-12` never calls `BC-13` |
| `E-16` | **L320** | `BC-11` → `BC-12` | `C/S` Sync port | `canMessage(a, b)`, re-asked on **every** send (`SGR-FR-021`, `MSG-FR-006`) |
| `E-19` | **L328** | → `BC-25` | Config | Reading `MSG-CFG-*` values |
| `E-20` | **L329** | → `BC-24` | Audit | Retention purge audit (BC Map **L378** invariant) |
| `E-22` | **L331** | `BC-12` → `BC-29` | `CF` Sync port | `FileRef` for attachments. ⭐ `BC-12` admitted by **`ADR-0055`**, *"required by `FIL-FR-075`…`FIL-FR-082`, **V1** student-to-student file sharing"* |
| `E-23` | **L332** | `BC-12` → `BC-22` | `PL` Event | Notification **facts**, never channel instructions |

**6 edges used · 0 created.** ⛔ `E-27` is **not** referenced — permanently vacant.

---

## §B7.5 Conversation model — specification of the `BC-12` aggregate

`MSG-FR-001` — A `Conversation` **SHALL** be the aggregate root for all 1-to-1
messaging state, per BC Map **L378**. It **SHALL** be keyed by a server-assigned
opaque `ConversationId`.

`MSG-FR-002` — A V1 `Conversation` **SHALL** have **exactly two** participants,
each identified by **`PersonId`**. ⛔ Group conversations are **out of V1** — EA
**L951** dates `Group Chat` **V2**, and no Rank 1–4 line places it earlier.

`MSG-FR-003` — Participation **SHALL** be recorded as an internal of the
aggregate (`MSG-XC-001`), holding: `PersonId`, join time, per-participant read
cursor, per-participant archive flag, per-participant mute flag.

`MSG-BR-001` — A `Conversation` between an **order-insensitive** pair of
`PersonId`s **SHALL** be unique. A second attempt to open a conversation with
the same counterpart **SHALL** resolve to the existing `Conversation`, never
create a second one.

`MSG-BR-002` — ⛔ **Self-conversation is refused.** `BC-11`'s no-self-friendship
discipline (BC Map **L377**) is mirrored: a `Conversation` where both
participants are the same `PersonId` **SHALL** be rejected.

`MSG-INV-001` — A `Conversation`'s participant set **SHALL** be immutable after
creation. There is no add, remove or leave in V1 — those are group semantics
(**V2**).

`MSG-FR-004` — A `Conversation` **SHALL** carry a **state**, from the closed enum
of `MSG-BR-004`.

`MSG-BR-003` — Participation **SHALL** be keyed **only** on `PersonId`. ⛔ A
`Conversation` **SHALL NOT** hold a `tenantId`, a `StudentRecordId`, a
membership identifier or a library identifier (`MSG-XC-020`, rule `ID-2`).

`MSG-BR-004` — `Conversation` **state** is a **closed enum**:
`REQUESTED` · `ACTIVE` · `DECLINED` · `RESTRICTED`.
⛔ No fifth value may be introduced without amending this rule.

| State | Meaning | Entered by |
|---|---|---|
| `REQUESTED` | First message sent to a non-friend; not in the recipient's inbox | `TSF-FR-032` (FROZEN) |
| `ACTIVE` | Delivered to both inboxes | Acceptance, or a first message between friends |
| `DECLINED` | Recipient declined; ⛔ sender **not** informed | `TSF-FR-033` (FROZEN) |
| `RESTRICTED` | Sending refused by the `ADR-0065` local enforcement read model, or by `canMessage` returning false | `E-14` / `E-16` |

`MSG-INV-002` — `DECLINED` **SHALL** be terminal for the requesting direction. A
declined sender **SHALL NOT** be able to re-request within `MSG-CFG-004`.

---

## §B7.6 Message model, lifecycle, immutability

`MSG-FR-005` — A `Message` **SHALL** be an entity of the `Conversation`
aggregate (BC Map **L378**), carrying: opaque server-assigned `MessageId`,
`ConversationId`, sender `PersonId`, body, optional `FileRef` list, client
idempotency key, server-assigned sequence, server-assigned timestamp, state.

`MSG-INV-003` — ⭐ **A `Message` SHALL be immutable after delivery.** This is a
**Rank 4 registered invariant** (BC Map **L378**) and B7 restates it verbatim
rather than paraphrasing it. ⛔ No edit, no in-place redaction, no body
mutation.

`MSG-BR-005` — `Message` **state** is a **closed enum**:
`ACCEPTED` · `DELIVERED` · `READ` · `FAILED` · `PURGED`.
⛔ `DELETED` is **deliberately absent** — see `MSG-FR-010`.

`MSG-FR-006` — ⭐ Before a `Message` is **accepted**, `BC-12` **SHALL**
synchronously satisfy **both** gates, in this order:

| # | Gate | Authority | On failure |
|---|---|---|---|
| **1** | `canMessage(a, b)` via **`E-16`** | `SGR-FR-021`, BC Map **L320**, **L378** invariant *"Participants must satisfy `canMessage` at send time"* | Refuse. ⛔ Reason **not** disclosed (`SGR-SEC-011`) |
| **2** | Local enforcement-state read, with the fail-closed staleness gate | **FROZEN** `TSF-FR-030`/`031`/`INV-007`; **`ADR-0065`** Option B | Refuse |

`MSG-BR-006` — ⛔ `canMessage` **SHALL** be re-asked on **every** send. It
**SHALL NOT** be cached, memoised on the `Conversation`, or inferred from a
prior success. *(B1 **L544**: *"`canMessage` at send time, so `BC-12` re-asks
via `E-16` on every send."* `FIL-FR-008` forbids caching a decision in the
sibling case.)*

`MSG-FR-007` — A send refused by either gate **SHALL** produce a response
**indistinguishable** between *"blocked"*, *"restricted"* and *"not permitted"*.
*(`SGR-SEC-011`: `canMessage`'s result must not disclose the block.)*

`MSG-FR-008` — A `Message` **SHALL** transition to `DELIVERED` when `BC-12` has
durably recorded it as available to the recipient. ⛔ Delivery **SHALL NOT** be
predicated on the recipient holding a live realtime connection — realtime is a
**transport optimisation**, not the delivery record (**B8**).

`MSG-FR-009` — `FAILED` **SHALL** be reachable only **before** `DELIVERED`. ⛔ A
delivered message **SHALL NOT** become `FAILED` (`MSG-INV-003`).

`MSG-FR-010` — ⭐ V1 **SHALL NOT** offer message deletion. **Measured reason:**
BC Map **L378** fixes *"message immutable after delivery"*, and the only
registered removal mechanism is `RetentionPolicy` purge, whose invariant is
*"irreversible and audited"*. A user-facing delete is neither. ⚠ Recorded as an
**owner decision**, `XPB-CONF-016`, **not** silently added.

`MSG-BR-007` — `PURGED` **SHALL** be reachable **only** by a `RetentionPolicy`
purge (§B7.12), **never** by a user action.

---

## §B7.7 Idempotency

⚠ **Measured: no Rank 1–4 idempotency rule exists for `BC-12`.** `PRD-021A` A8
§16 is a **peer Stage-2 draft**, not authority. B7 therefore **specifies**
rather than **cites** here, and says so (`MSG-GAP-001`).

`MSG-FR-011` — A send request **SHALL** carry a client-generated idempotency key,
unique per sender per `Conversation`.

`MSG-BR-008` — A repeat send with an already-seen key **SHALL** return the
**original** `MessageId`, sequence and timestamp, with a success status. ⛔ It
**SHALL NOT** create a second `Message`.

`MSG-INV-004` — For a given (sender `PersonId`, `ConversationId`, idempotency
key) triple, **at most one** `Message` **SHALL** exist. ⭐ This is the property
that makes a client retry after a network timeout safe, which is the whole
reason the rule exists.

`MSG-FR-012` — Idempotency keys **SHALL** be retained for at least
`MSG-CFG-005`. ⚠ After that window a repeat **may** create a duplicate; the
window is **disclosed, not eliminated** — the `TSF-INV-007` discipline of
bounding a residual rather than claiming it away.

`MSG-BR-009` — ⛔ An idempotency key **SHALL NOT** be accepted as, or used to
derive, a `MessageId`. A client-supplied value **SHALL NOT** become a server
identifier.

---

## §B7.8 Ordering

⚠ **Measured: no Rank 1–4 ordering rule for `BC-12`.** BC Map **L116**'s
*"delivery guarantees"* is `BC-12`'s to define, so B7 defines it
(`MSG-GAP-001`).

`MSG-FR-013` — Every accepted `Message` **SHALL** receive a **server-assigned,
strictly monotonic sequence** within its `Conversation`.

`MSG-BR-010` — ⛔ **Ordering SHALL be by sequence, never by timestamp.** Wall
clocks are not monotonic and client clocks are not trusted at all.

`MSG-BR-011` — ⛔ A client-supplied timestamp **SHALL NOT** determine order,
position or visibility. It **may** be stored as `clientSentAt` metadata only.

`MSG-INV-005` — Within one `Conversation`, sequence **SHALL** be gap-free and
never reused.

`MSG-FR-014` — Pagination **SHALL** use an **opaque cursor** over sequence, per
BC Map §15.3 `PG-1`…`PG-4`. ⛔ No offset pagination; ⛔ no cursor that leaks
sequence, timestamp or count.

`MSG-FR-015` — ⭐ Ordering is **per-conversation only**. ⛔ B7 **SHALL NOT**
define a global cross-conversation total order — that would require a
coordination guarantee no Rank 1–4 document asks for, and **B9** records why it
is not attempted.

---

## §B7.9 Unread and read state — ⚠ split by the repository

### §B7.9.1 The split, measured

| Capability | Authority | Wave |
|---|---|---|
| `DeliveryReceipt` as an entity | BC Map **L378** — **registered** | ✅ **V1** (the entity exists in the V1 model) |
| Unread **count** for the recipient's own inbox | Derivable from the participant read cursor; no external disclosure | ✅ **V1** |
| **Read receipt disclosed to the sender** | EA **L950** `Read Receipts & Presence (V2)` | ⚠ **CONTESTED** |

⭐ **Why this is an owner decision and not a determination.** The media case
(**B8**) is resolvable because a **Rank 4** line (BC Map **L331**) and a
**FROZEN Rank 3** PRD both date it **V1**, overtaking the EA. **No equivalent
line exists for read receipts.** BC Map **L116** grants `BC-12` *ownership* of
delivery guarantees but assigns **no wave** to receipt *disclosure*. With
authority silent above Rank 6, the EA's V2 is the only measurement available —
and reversing it would be B7 legislating, which is refused.

**Recorded as `XPB-CONF-014`, owner Architecture Owner + Product Owner jointly.**

### §B7.9.2 What B7 specifies for V1

`MSG-FR-016` — Each participant **SHALL** hold a **read cursor**: the highest
sequence they have read in that `Conversation`.

`MSG-FR-017` — A participant's **unread count SHALL** be derived as the number of
messages with sequence greater than their own cursor and sender ≠ self.

`MSG-BR-012` — A read cursor **SHALL** be monotonic. ⛔ It cannot move backwards;
there is no "mark as unread" in V1.

`MSG-FR-018` — ⛔ In V1 a participant's read cursor **SHALL NOT** be disclosed to
the other participant, and no read-receipt indicator **SHALL** be rendered.
*(`MSG-CFG-002` defaults **FALSE**; `MSG-XC-021` makes enablement impossible
while `XPB-CONF-014` is open.)*

`MSG-XC-021` — ⛔ `MSG-CFG-002` **SHALL NOT** be set `TRUE` while
`XPB-CONF-014` is **OPEN**. *(The `PYK-XC-004` pattern from B5: a contested
capability is drafted, gated, and made un-enablable rather than omitted or
smuggled in.)*

`MSG-FR-019` — A `DeliveryReceipt` **SHALL** record delivery to `BC-12`'s durable
store, which **is** V1 and **is** disclosable to the sender — it states *"the
platform has it"*, ⛔ **not** *"the person read it"*.

---

## §B7.10 Archive and mute

`MSG-FR-020` — Archive **SHALL** be a **per-participant view state** on the
`Conversation`, not a state of the `Conversation` itself.

`MSG-BR-013` — ⛔ Archiving **SHALL NOT** affect the other participant's view,
delivery, retention or unread count. ⭐ An archive that the counterpart can
observe is a disclosure, not a filing action.

`MSG-FR-021` — A new message in an archived `Conversation` **SHALL** un-archive it
for that participant.

`MSG-FR-022` — Mute **SHALL** be a **per-participant** flag that suppresses
**notification facts** for that `Conversation`.

`MSG-BR-014` — ⛔ Mute **SHALL NOT** suppress delivery, un-mute the counterpart,
or be visible to the counterpart. ⛔ Mute is **not** Block: Block is `BC-11`'s
`BlockList` (`MSG-XC-005`) and is bidirectional in effect (`SGR-BR-017`);
mute is local, unilateral and affects notifications only.

`MSG-FR-023` — ⛔ Where `BC-22` requires a fact for consent or audit purposes,
suppression **SHALL** be expressed **as the fact's content**, ⛔ never as
`BC-12` deciding not to notify. *(`E-23` **L332**: *"Domain emits facts, never
'send an SMS'"*.)*

---

## §B7.11 Context references — ⚠ constrained to opaque

`MSG-FR-024` — A `Message` **MAY** carry a **context reference**: an opaque
`{type, id}` pair recording what the conversation was started about.

`MSG-BR-015` — ⛔ `BC-12` **SHALL NOT** dereference a context reference. It
**SHALL NOT** call the referenced context, join to it, validate it, or render its
content. ⭐ **Measured reason:** dereferencing would require an inbound edge
`BC-12` does not have, and BC Map **L292** rules that *"if an edge is not in this
table, it does not exist."* `BC-12`'s only inbound sync port is `E-16`
(`canMessage`) and its only outbound sync port is `E-22` (`FileRef`).

`MSG-BR-016` — A context reference **SHALL** be **display-inert**: stored,
returned to the client verbatim, and resolved (if at all) by the **client**
against a context the client is already entitled to read.

`MSG-XC-022` — ⛔ A context reference **SHALL NOT** carry a `tenantId`, a
`StudentRecordId`, a library identifier or any tenant-scoped key
(`MSG-XC-020`, rule `ID-2`, Matrix **L354** `X-05`).

`MSG-FR-025` — Context reference `type` **SHALL** be a closed enum, and in V1 it
**SHALL** be **empty**. ⚠ ⛔ **No V1 source is authorised.** The one the supplied
specification implies — a help request — is `XPB-CONF-011`, **withdrawn**
(§B7.14). Populating the enum requires a named, authorised source.

---

## §B7.12 Retention and security

`MSG-FR-026` — `RetentionPolicy` **SHALL** be an entity of the `Conversation`
aggregate (BC Map **L378**).

`MSG-INV-006` — ⭐ **A retention purge SHALL be irreversible and audited.**
Verbatim Rank 4 invariant (BC Map **L378**). The audit **SHALL** be written via
**`E-20`** to `BC-24`.

`MSG-FR-027` — Purge **SHALL** remove message bodies and `FileRef`s. ⛔ It
**SHALL NOT** be reversible by any operator action, and no soft-delete tier
**SHALL** be presented as a purge.

`MSG-BR-017` — ⚠ Purging a `Message` **SHALL NOT** issue a byte-deletion command
to `BC-29`. ⭐ **Measured:** `PRD-017` L986 states the two lifecycles *"are
related only through `FIL-FR-080`"*, and `FIL-XC-002` keeps message retention
out of `BC-29` entirely. `BC-12` **SHALL** therefore **revoke its `E-22` share
grant** (**FROZEN** `FIL-FR-079`) and **SHALL NOT** attempt to delete bytes it
does not own (`MSG-XC-014`).

`MSG-FR-028` — ⚠ In V1 `RetentionPolicy` **SHALL** be a **fixed platform
default** (`MSG-CFG-003`), not a user- or library-configurable surface.
⭐ **Measured reason:** EA **L948** dates `Message Retention Policy` **V2**, and
no Rank 1–4 line dates a *configurable* policy earlier. The **entity** is V1
because **L378** registers it; the **configurability** is not.
**`XPB-CONF-015`, owner Architecture Owner + Product Owner.**

`MSG-SEC-001` — ⛔ Authorisation **SHALL** be evaluated **server-side on every
request**. ⛔ No client-supplied claim of participation, entitlement, friendship
or scope **SHALL** be trusted. *(`MP-GBR-08`; the `SGR-`/`SDS-` server-side
discipline.)*

`MSG-SEC-002` — Reading a `Conversation` **SHALL** require the caller's
authenticated `PersonId` to be a participant. ⛔ Membership of the same library
**SHALL NOT** grant read access.

`MSG-SEC-003` — ⛔ `BC-12` **SHALL NOT** store a credential, password, OTP,
session or device record (rule **`ID-1`**, BC Map **L178**; `MSG-XC-008`).

`MSG-SEC-004` — Message bodies **SHALL** be private by default and reachable only
through an authorised, authenticated read of the owning `Conversation`.

`MSG-SEC-005` — ⛔ `BC-13` **SHALL NOT** read message bodies at rest
(`TSF-XC-016`, FROZEN). The **only** path by which body content reaches `BC-13`
is a **reporter-supplied** evidence snapshot under `TSF-FR-036`/`TSF-BR-012`,
which is `BC-13`'s mechanism and **not** something `BC-12` initiates.

`MSG-SEC-006` — ⛔ Encryption at rest beyond the platform default **SHALL NOT**
be claimed. EA **L949** dates `Encryption at Rest` **V2**. ⭐ Recorded as a
**deferred** item, ⛔ not silently promised.

---

## §B7.13 API surface

`MSG-API-001` — Open-or-resolve a `Conversation` with a counterpart `PersonId`.
Idempotent per `MSG-BR-001`.
`MSG-API-002` — List the caller's `Conversation`s, opaque-cursor paginated,
ordered by last activity, excluding the caller's archived set unless requested.
`MSG-API-003` — Read messages in a `Conversation`, opaque-cursor paginated over
sequence.
`MSG-API-004` — Send a `Message`, requiring an idempotency key, subject to
`MSG-FR-006`'s two gates.
`MSG-API-005` — Advance the caller's read cursor.
`MSG-API-006` — Archive / un-archive for the caller.
`MSG-API-007` — Mute / un-mute for the caller.
`MSG-API-008` — Accept or decline a `REQUESTED` `Conversation`.

`MSG-API-009` — ⛔ Every endpoint **SHALL** be authorised server-side against the
caller's authenticated `PersonId` (`MSG-SEC-001`).

`MSG-API-010` — ⛔ **No endpoint SHALL accept a `tenantId`, `StudentRecordId`,
library identifier or membership identifier** as a parameter, header or body
field (rule `ID-2`; manifest `banned_symbols`).

`MSG-API-011` — ⛔ No endpoint **SHALL** expose another person's read cursor,
presence, device state, block state or enforcement state (`MSG-FR-018`,
`SGR-SEC-011`).

`MSG-API-012` — ⛔ No endpoint **SHALL** return a raw storage path or an
unsigned media URL. Media reads are `BC-29`-issued signed URLs only
(**FROZEN** `FIL-FR-078`, `FIL-FR-034`).

`MSG-API-013` — All list endpoints **SHALL** use opaque cursors per `PG-1`…`PG-4`.

`MSG-API-014` — ⛔ B7 **SHALL NOT** define a realtime endpoint, socket protocol
or subscription channel. That is `platform/services:realtime`'s and is specified
in **B8** (`MSG-XC-013`).

---

## §B7.14 ⛔ `XPB-CONF-011` — the Help → Message flow is NOT authored

### §B7.14.1 The conflict
The supplied specification asks B7 to author a "Help → Message flow".

### §B7.14.2 The authoritative measurement
| Probe | Result |
|---|---|
| Repository lines defining a Help → Message flow for `PRD-021B` | **0** |
| `community.HelpRequestAnswered` | Exists **only** as `LCN-EVT-007`, and it is **`WITHDRAWN`** — `ADR-0083` **L237**; `PRD-021A` A7 **L319** *"WITHDRAWN"* |
| `LCN-FR-019` | **`VOID`** — A7 **L459** |
| A community → `BC-12` edge | ⛔ **Does not exist.** Edge set `E-01`…`E-26`, `E-28`, `E-29`; BC Map **L292** governs |

### §B7.14.3 Already resolved?
**Yes — resolved against it.** The enabling event was **withdrawn by an
`Accepted` ADR**, and `PRD_LIFECYCLE.md` §5 rule 5 holds that identifiers
*"are never reused, even after withdrawal."*

### §B7.14.4 The repository decision, preserved
The flow has no event, no edge and no requirement. It is **not** authored.

### §B7.14.5 The smallest compatible resolution
`MSG-FR-025` leaves the context-reference `type` enum **defined but empty**, so
the mechanism is ready and the **source is refused**. ⛔ B7 does **not** revive
`LCN-EVT-007`, does **not** mint a substitute event, and does **not** propose an
edge.

### §B7.14.6 Recorded, not invented
**`XPB-CONF-011` — OPEN. Owner: Product Owner** (scope: is the flow wanted?)
**+ Architecture Owner** (if wanted, a source event and an edge must be
authorised by ADR).

---

## §B7.15 Hand-offs

`MSG-FR-029` — **Realtime hand-off.** `BC-12` **SHALL** publish accepted messages
to the **`platform/services:realtime` port** for transport. ⛔ The port is **not**
a bounded context and **SHALL NOT** be modelled as one (`MSG-XC-013`).
⛔ Realtime delivery **SHALL NOT** be the delivery record (`MSG-FR-008`).
Specified in **B8**.

`MSG-FR-030` — **Notification hand-off.** `BC-12` **SHALL** emit a
notification **fact** via **`E-23`** to `BC-22`. ⛔ It **SHALL NOT** select a
channel, choose a template, evaluate quiet hours, deduplicate, or check consent —
all `BC-22`'s (BC Map **L131**, `MSG-XC-012`).

`MSG-FR-031` — **Media hand-off.** Attachments **SHALL** be held as a `BC-29`
`FileRef` via **`E-22`**. ⛔ `BC-12` **SHALL NOT** hold bytes or a raw storage
path (BC Map **L331**). Specified in **B8**.

`MSG-FR-032` — **Safety hand-off.** The send-time enforcement check **SHALL** be
a **local read** of an `E-14`-fed projection inside `BC-12`, per **`ADR-0065`**
Option B. ⛔ **No `BC-12` → `BC-13` edge exists or is created.** Specified in
**B8**.

`MSG-FR-033` — **Eligibility hand-off.** `canMessage(a, b)` **SHALL** be asked of
`BC-11` via **`E-16`** on every send (`MSG-BR-006`).

`MSG-EVT-001` — ⚠ `BC-12`'s **only** published event remains
**`messaging.MessageSent`**, consumed by `BC-13` (**sampling only**,
`TSF-BR-013`) and `BC-26` — BC Map **L431**. ⛔ B7 mints **no** event
(`MSG-XC-006`).

---

## §B7.16 Configuration

| ID | Value | Default | Range | Owner |
|---|---|---|---|---|
| `MSG-CFG-001` | Max message body length | platform default | bounded | `BC-25` via `E-19` |
| `MSG-CFG-002` | Read-receipt disclosure enabled | ⛔ **FALSE** | ⛔ **FALSE only** while `XPB-CONF-014` is OPEN (`MSG-XC-021`) | Architecture + Product |
| `MSG-CFG-003` | Retention window | platform default, **fixed** | ⛔ not configurable in V1 (`MSG-FR-028`) | Architecture + Product |
| `MSG-CFG-004` | Re-request cooldown after `DECLINED` | platform default | bounded | Product |
| `MSG-CFG-005` | Idempotency key retention | platform default | bounded (`MSG-FR-012`) | Platform |
| `MSG-CFG-006` | Conversation list page size | platform default | bounded | Platform |

⚠ **Outstanding-request limits are NOT listed here.** They are
**`TSF-CFG-009`** — **FROZEN** `TSF-FR-034` — and the counter is `BC-11`'s
`RateLimitCounter` (`TSF-BR-011`, `MSG-XC-007`). ⛔ B7 defines no second one.

---

## §B7.17 Scope — V1 / Future / Deferred / Open / Constraints

### §B7.17.1 ✅ V1
1-to-1 `Conversation` with two `PersonId` participants · the four-value state
enum · `Message` with server sequence · immutability after delivery ·
idempotent send · per-conversation ordering · the two send-time gates ·
message requests (record only) · unread count · read cursor (private) ·
`DeliveryReceipt` · archive · mute · opaque-cursor pagination · `FileRef`
attachments via `E-22` (⭐ V1 per BC Map **L331** + FROZEN `FIL-FR-075`…`082`) ·
notification facts via `E-23` · retention purge, irreversible and audited ·
context-reference mechanism with an **empty** source enum.

### §B7.17.2 🔵 Future — named, dated by authority, ⛔ not built
| Capability | Wave | Authority |
|---|---|---|
| Group chat | **V2** | EA **L951** |
| Read receipts disclosed to sender · presence | **V2** | EA **L950** (⚠ contested — `XPB-CONF-014`) |
| Configurable retention policy | **V2** | EA **L948** (⚠ `XPB-CONF-015`) |
| Encryption at rest | **V2** | EA **L949** |
| Voice messages | **V3** | EA **L954** |
| Video calling · AI chat assistant | **Future** | EA **L955**, **L956** |

### §B7.17.3 ⛔ Deferred by B7 with a stated reason
| Item | Why |
|---|---|
| User-facing message deletion | Conflicts with the **L378** immutability invariant; no authorised mechanism. `XPB-CONF-016` |
| Help → Message flow | Enabling event **WITHDRAWN**. `XPB-CONF-011` |
| Populated context-reference source enum | No authorised source exists (`MSG-FR-025`) |
| Cross-conversation global ordering | No authority requires it; cost is real (`MSG-FR-015`) |
| Mark-as-unread | Would break the read cursor's monotonicity (`MSG-BR-012`) |
| Leave / add / remove participant | Group semantics, **V2** (`MSG-INV-001`) |

### §B7.17.4 ⚠ Open owner decisions
See §B7.19.

### §B7.17.5 🔒 Existing repository constraints B7 obeys and cannot alter
| Constraint | Source |
|---|---|
| `BC-12` owns conversations, messages, delivery, retention, presence | BC Map **L116** |
| Aggregate root `Conversation`; entities `Message`, `DeliveryReceipt`, `RetentionPolicy` | BC Map **L378** |
| `canMessage` at send time; immutable after delivery; purge irreversible + audited | BC Map **L378** |
| The send-time check is a **local** `E-14`-fed read; **no** `BC-12`→`BC-13` edge | **`ADR-0065`** Option B |
| First message to a non-friend is a request; decline is silent; limits per `TSF-CFG-009`; the counter is `BC-11`'s | **FROZEN** `TSF-FR-032`…`035`, `TSF-BR-011` |
| T&S never reads bodies at rest | **FROZEN** `TSF-XC-016` |
| `messaging.MessageSent` is the only `messaging.*` event | BC Map **L431** |
| Media is `BC-29`'s; domain holds a `FileRef` | BC Map **L331**, **FROZEN** `PRD-017` |
| Notification is `BC-22`'s; domains emit facts | `E-23` **L332** |
| No `tenantId` / `StudentRecordId` in social data | rule **`ID-2`**, BC Map **L488**; manifest `banned_symbols` |
| Library ↔ Student Network is *Separate Ways* | Matrix **L354** `X-05` |
| No context outside `BC-18` stores a credential | rule **`ID-1`**, BC Map **L178** |
| An edge absent from BC Map §7 does not exist | BC Map **L292** |

---

## §B7.18 Acceptance criteria — 30, all Given/When/Then, all mapped

⭐ Every AC below names the requirement it tests. **0 orphan ACs.** ⛔ No AC
tests a requirement B7 did not state.

`MSG-AC-001` — **Given** two `PersonId`s with no conversation, **when** either
opens one twice, **then** exactly one `Conversation` exists and both calls return
the same `ConversationId`. *(`MSG-BR-001`, `MSG-FR-001`)*

`MSG-AC-002` — **Given** a caller, **when** they open a conversation with
themselves, **then** it is refused and no `Conversation` is created.
*(`MSG-BR-002`)*

`MSG-AC-003` — **Given** an `ACTIVE` conversation, **when** any actor attempts to
add, remove or change a participant, **then** it is refused and the participant
set is unchanged. *(`MSG-INV-001`, `MSG-FR-002`)*

`MSG-AC-004` — **Given** a `Conversation`, **when** its persisted form is
inspected, **then** it contains no `tenantId`, no `StudentRecordId`, no library
identifier and no membership identifier. *(`MSG-BR-003`, `MSG-XC-020`)*

`MSG-AC-005` — **Given** a `Conversation`, **when** its state is set, **then** the
value is one of `REQUESTED`/`ACTIVE`/`DECLINED`/`RESTRICTED`, and any fifth value
is refused. *(`MSG-BR-004`, `MSG-FR-004`)*

`MSG-AC-006` — **Given** a `DECLINED` conversation, **when** the original sender
re-requests within `MSG-CFG-004`, **then** it is refused, and the recipient
learns nothing about the attempt. *(`MSG-INV-002`, `MSG-CFG-004`)*

`MSG-AC-007` — **Given** a delivered `Message`, **when** any edit, redaction or
body mutation is attempted, **then** it is refused and the stored body is
byte-unchanged. *(`MSG-INV-003`, `MSG-FR-005`)*

`MSG-AC-008` — **Given** a send, **when** it is processed, **then**
`canMessage(a, b)` was asked of `BC-11` via `E-16` **during that request**, and no
cached or inferred result was used. *(`MSG-FR-006`, `MSG-BR-006`, `MSG-FR-033`)*

`MSG-AC-009` — **Given** a block in either direction, **when** a send is
attempted, **then** it is refused, and the response is indistinguishable from a
restriction refusal and from a not-permitted refusal. *(`MSG-FR-007`,
`MSG-XC-005`)*

`MSG-AC-010` — **Given** a person restricted in `BC-12`'s local enforcement read
model, **when** they send, **then** it is refused **before** the message is
accepted. *(`MSG-FR-006` gate 2, `MSG-FR-032`)*

`MSG-AC-011` — **Given** the enforcement read model's freshness cannot be
established within `TSF-CFG-030`, **when** a send is attempted, **then** it is
**refused** (fail closed), not allowed through. *(`MSG-FR-006`, `MSG-FR-032`)*

`MSG-AC-012` — **Given** the send path, **when** the enforcement check runs,
**then** it is a local read inside `BC-12` and **no** call is made to `BC-13`.
*(`MSG-FR-032`, `MSG-XC-004`)*

`MSG-AC-013` — **Given** a send to a non-friend with no prior conversation,
**when** it is accepted, **then** the `Conversation` state is `REQUESTED` and the
message is **not** in the recipient's inbox. *(`MSG-BR-004`, `MSG-XC-002`)*

`MSG-AC-014` — **Given** an outstanding-request limit breach, **when** a further
request is attempted, **then** it is refused by `BC-11`'s `RateLimitCounter`, and
`BC-12` holds **no** second counter. *(`MSG-XC-007`, `MSG-CFG-002` exclusion note
in §B7.16)*

`MSG-AC-015` — **Given** a send request with an idempotency key already seen,
**when** it is retried, **then** the original `MessageId`, sequence and timestamp
are returned and no second `Message` exists. *(`MSG-BR-008`, `MSG-INV-004`)*

`MSG-AC-016` — **Given** a client-supplied idempotency key, **when** the message
is stored, **then** the `MessageId` is server-assigned and is not derived from
that key. *(`MSG-BR-009`, `MSG-FR-011`)*

`MSG-AC-017` — **Given** messages accepted out of wall-clock order, **when** the
conversation is read, **then** they are returned in server-sequence order and the
client timestamp did not affect position. *(`MSG-BR-010`, `MSG-BR-011`)*

`MSG-AC-018` — **Given** a conversation with N accepted messages, **when**
sequences are inspected, **then** they are gap-free, strictly monotonic and
non-reused. *(`MSG-INV-005`, `MSG-FR-013`)*

`MSG-AC-019` — **Given** a message list request, **when** a page is returned,
**then** the cursor is opaque and reveals no sequence, timestamp or total count.
*(`MSG-FR-014`, `MSG-API-013`)*

`MSG-AC-020` — **Given** a participant with a read cursor, **when** the
counterpart reads the conversation, **then** that cursor is not present in any
response field. *(`MSG-FR-018`, `MSG-API-011`)*

`MSG-AC-021` — **Given** `XPB-CONF-014` is OPEN, **when** `MSG-CFG-002` is set
`TRUE`, **then** the configuration is refused. *(`MSG-XC-021`)*

`MSG-AC-022` — **Given** a read cursor at sequence S, **when** a request tries to
move it below S, **then** it is refused and the cursor remains S.
*(`MSG-BR-012`, `MSG-FR-016`)*

`MSG-AC-023` — **Given** a participant archives a conversation, **when** the
counterpart reads it, **then** their view, unread count and delivery are
unchanged and no archive state is visible to them. *(`MSG-BR-013`, `MSG-FR-020`)*

`MSG-AC-024` — **Given** an archived conversation, **when** a new message
arrives, **then** it is un-archived for that participant only.
*(`MSG-FR-021`)*

`MSG-AC-025` — **Given** a muted conversation, **when** a message arrives,
**then** it is still delivered and recorded, and the mute is not visible to the
counterpart. *(`MSG-BR-014`, `MSG-FR-022`)*

`MSG-AC-026` — **Given** a message with a context reference, **when** it is
served, **then** `BC-12` made no call to the referenced context and returned the
reference verbatim. *(`MSG-BR-015`, `MSG-BR-016`)*

`MSG-AC-027` — **Given** V1, **when** a context reference with a populated `type`
is submitted, **then** it is refused because the source enum is empty.
*(`MSG-FR-025`, `MSG-FR-024`)*

`MSG-AC-028` — **Given** a retention purge, **when** it completes, **then** the
bodies and `FileRef`s are gone, an audit record exists via `E-20`, and no
operator action restores them. *(`MSG-INV-006`, `MSG-FR-027`)*

`MSG-AC-029` — **Given** a purge of a message with an attachment, **when** it
completes, **then** `BC-12` revoked its `E-22` share grant and issued no
byte-deletion command to `BC-29`. *(`MSG-BR-017`, `MSG-XC-014`)*

`MSG-AC-030` — **Given** any endpoint, **when** a request supplies a `tenantId`,
`StudentRecordId` or library identifier, **then** it is rejected; and **when** a
caller who is not a participant requests a conversation, **then** it is refused
even if they share a library. *(`MSG-API-010`, `MSG-SEC-002`, `MSG-XC-011`)*

**30 ACs · 30 mapped · 0 orphans.**

---

## §B7.19 ⚠ Disclosed conflicts and gaps — OPEN, each with a named owner

| ID | Item | Disposition | Owner |
|---|---|---|---|
| `XPB-CONF-006` | B7 asked to own what `BC-12` already owns | ✅ **RESOLVED IN THIS DRAFT** by re-framing B7 as a specification (§B7.1). No authority changed | — |
| `XPB-CONF-010` | `MessageRequest` ownership vs FROZEN `PRD-020` §10.2 | ✅ **RESOLVED IN THIS DRAFT**: B7 specifies the record; rules and counter stay FROZEN/`BC-11` | — |
| `XPB-CONF-011` | Help → Message flow has **0** repository basis | ⛔ **OPEN** — not authored (§B7.14) | Product Owner + Architecture Owner |
| `XPB-CONF-014` | Read-receipt / presence disclosure wave: BC Map **L116** owns it, EA **L950** dates it **V2** | ⛔ **OPEN** — drafted, gated **FALSE**, un-enablable | Architecture Owner + Product Owner |
| `XPB-CONF-015` | Configurable retention: entity is V1 (**L378**), EA **L948** dates the policy **V2** | ⛔ **OPEN** — fixed default in V1 | Architecture Owner + Product Owner |
| `XPB-CONF-016` | User-facing message deletion vs the **L378** immutability invariant | ⛔ **OPEN** — deferred, not added | Product Owner + Architecture Owner |
| `MSG-GAP-001` | ⚠ No Rank 1–4 idempotency or ordering rule exists for `BC-12`; §B7.7/§B7.8 are **B7 specifying**, not citing | ⛔ **OPEN** — disclosed as authored-not-derived | Architecture Owner |
| `MSG-GAP-002` | ⚠ `PRD-021` itself is still **`PLANNED`** (`PRD_REGISTRY.md` §4.2 **L321**) while parts B0–B9 accumulate as drafts | ⛔ **OPEN** — pre-existing, not created here | Governance Owner |

⭐ **`FOD-4`.** Part B0 §8's `FOD-4` names B4, B5, **B7, B8, B9** — so unlike B6,
B7 is a **previously disclosed** part identifier. `FOD-4`'s own *"exact smallest
action"* is *"a registry §11-style allocation act"*, which `PRD_REGISTRY.md` §14
performs. ⛔ **B0 is not edited by this draft.**

---

## §B7.20 ⛔ What B7 does **not** do

1. ⛔ Confers no lifecycle stage. **Stage 2 only.** Stage 3 requires a written
   alignment record; **none exists** for B7 and none is claimed.
2. ⛔ Creates **no** bounded context. Count remains **31** (23 V1).
3. ⛔ Creates **no** integration edge. 6 used, all pre-existing; `E-27` untouched.
4. ⛔ Mints **no** published event. `BC-12`'s surface stays at **one**.
5. ⛔ Proposes **no** BC Map §8 aggregate or entity row.
6. ⛔ Amends **no** Rank 1–6 document. BC Map, EA, Matrix, `MASTER_PRD.md`,
   `ARCHITECTURE_RULINGS.md` and every FROZEN PRD are **byte-unchanged**.
7. ⛔ Reinterprets **no** frozen decision. `TSF-*` and `FIL-*` are cited verbatim.
8. ⛔ Overrides **no** ADR. `ADR-0055`, `ADR-0065`, `ADR-0083` are relied on as
   written; **no new ADR is created** by this draft.
9. ⛔ Duplicates **no** ownership — 20 refusals in §B7.3.
10. ⛔ Moves **no** capability between waves. EA lines are cited, never edited.
11. ⛔ Allocates **no** `IMPL-*` and creates **no** implementation task.
12. ⛔ Writes **no** `DOCUMENTATION_BASELINE.md` row and **no**
    `TRACEABILITY_MATRIX.md` row. Traceability is Stage 5, ⛔ not entered.
13. ⛔ Modifies **no** file under `lib/`, `test/`, `tool/`, `web/`, `android/` or
    `.github/`.
14. ⛔ Does **not** freeze, approve or baseline `PRD-021B`.

---

## §B7.21 Status

**`PRD-021B` Part B7 = `DRAFT` / Stage 2.**

⛔ NOT Stage 3. ⛔ NOT Stage 4. ⛔ NOT Approved. ⛔ NOT Frozen. ⛔ NOT
Implementation Ready.

**Measured content:** 33 `MSG-FR-*` · 17 `MSG-BR-*` · 6 `MSG-INV-*` · 6
`MSG-SEC-*` · 14 `MSG-API-*` · 22 `MSG-XC-*` · 6 `MSG-CFG-*` · 1 `MSG-EVT-*` ·
2 `MSG-GAP-*` · **30 `MSG-AC-*`, all mapped, 0 orphans**. 6 edges used, 0
created. 0 contexts created. 0 events minted. 4 conflicts left **OPEN** against
named owners; 2 resolved within the draft by preserving repository authority.

### §B7.22 Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Initial Stage-2 draft. ⭐ Authored as a **specification of `BC-12`** rather than an ownership claim, after BC Map **L116**, **L378** and FROZEN `PRD-020` §10's ownership guard were measured to already own every capability the supplied specification asked B7 to assign (`XPB-CONF-006`). ⚠ `Participant` and `MessageRequest` were measured **absent** from the Rank 4 entity register and are expressed as aggregate internals rather than as a proposed §8 amendment (§B7.1.6). ⛔ The Help → Message flow was **refused** — its enabling event is `WITHDRAWN` by `ADR-0083` (`XPB-CONF-011`). ⚠ Read receipts and configurable retention were **gated, not decided** (`XPB-CONF-014`, `XPB-CONF-015`). ⭐ Media attachments are stated **V1** on Rank 4 BC Map **L331** + FROZEN `FIL-FR-075`…`FIL-FR-082`, correcting an earlier working assumption drawn from EA **L952**/**L953** — the EA is **Rank 6 and descriptive** |
