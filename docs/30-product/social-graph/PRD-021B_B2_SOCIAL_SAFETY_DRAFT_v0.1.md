<!--
  PROVENANCE — PRD-021B Part B2

  Purpose of this file
  --------------------
  CONTEXT-LOSS RECOVERY / CONTINUITY ARTEFACT.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.
  Open items    : FOD-2 (Mute register append — ARB) remains ⛔ OPEN and GATES
                  the persisted Mute structure only. FOD-1 also remains OPEN.
                  ADR-0090 is PROPOSED ONLY — the file does not exist, it is not
                  ratified, and this document does not ratify it.

  ⭐ THE FROZEN DECISION ON MUTE IS RESPECTED VERBATIM AND NOT REOPENED.
  PRD-020 (FROZEN) TSF-XC-005 already settles Mute's OWNER and CLASSIFICATION.
  This document reproduces that decision and does NOT change it. The only open
  question is the Rank 4 BC Map §8 REGISTER APPEND, which this document has no
  authority to make and therefore marks UNRESOLVED (FOD-2).

  What this file does NOT do
  --------------------------
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge or published event.
    - It amends no FROZEN PRD. PRD-020 is byte-unchanged.
    - It amends no Rank 1-5 artefact. BC Map and EA are byte-unchanged.
    - It does NOT reclassify Mute.
    - It mints no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — PART B2

## Social Safety — Block, Mute & Abuse Prevention

### Specification v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Committed for context-loss
> recovery and continuity only. Stage 3 has **not** been entered.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B2 — Social Safety |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 NOT entered |
| Bounded context | **`BC-11` Social Graph** — existing. Count remains **31** |
| Freeze | ⛔ **NOT FROZEN** |
| Blocking open decisions | `FOD-2` (gates the persisted `Mute` structure only), `FOD-1` |

### §0.2 Identifier registers — declared up front, with ranges

| Register | Meaning | Range | Count |
|---|---|---|---|
| `SSF-FR-nnn` | Functional requirement | `001`–`027` | **27** |
| `SSF-BR-nnn` | Business rule | `001`–`022` | **22** |
| `SSF-DM-nnn` | Data model rule | `001`–`010` | **10** |
| `SSF-API-nnn` | API behaviour rule | `001`–`010` | **10** |
| `SSF-EVT-nnn` | Event rule | `001`–`006` | **6** |
| `SSF-PRV-nnn` | Privacy / data-minimisation rule | `001`–`008` | **8** |
| `SSF-SEC-nnn` | Security rule | `001`–`010` | **10** |
| `SSF-PERF-nnn` | Performance rule | `001`–`006` | **6** |
| `SSF-CACHE-nnn` | Caching rule | `001`–`006` | **6** |
| `SSF-EC-nnn` | Edge case | `001`–`016` | **16** |
| `SSF-XC-nnn` | Explicit exclusion | `001`–`016` | **16** |
| `SSF-SCOPE-nnn` | V1 / Future scope statement | `001`–`006` | **6** |
| `SSF-AC-nnn` | Acceptance criterion (GWT) | `001`–`028` | **28** |
| `SSF-GAP-nnn` | Disclosed gap — OPEN | `001`–`003` | **3** |
| **Total** | | | **174** |

Ranges contiguous `001..max`. ⛔ No `IMPL-*` identifier minted.

### §0.3 Prefix collision — executed before writing

`SSF-` measured **0** occurrences across `docs/` prior to authoring. ✅ Free.

### §0.4 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD**/**SHOULD NOT** strong, deviation
recorded · **MAY** optional · ⛔ prohibition · ⚠ disclosed defect/gap/risk.

---

## §B2.1 Scope and the ownership determination

`SSF-SCOPE-001` — B2 specifies the **safety capabilities owned by `BC-11`**:
Block, Unblock, Mute, Unmute, graph rate limits, and the Safety Check interface
that B1 and B3 consume.

⭐ `SSF-SCOPE-002` — **`BC-11` owns these, and Trust & Safety explicitly does
not.** This is not an inference; `PRD-020` (**FROZEN**) says it four times:

| Ref | Verbatim reading |
|---|---|
| `F-6` (L97) | *"Block and rate limiting are already owned… **T&S does not own Block, Mute or graph rate limits**"* |
| `TSF-XC-003` (L201) | Does not own friendship / follow / social graph → `BC-11` / `PRD-021` |
| `TSF-XC-004` (L202) | Does not own Block |
| `TSF-XC-005` (L203) | Does not own Mute — *"Same owner as Block — **a unilateral graph-visibility preference, not a safety decision**"* |

`SSF-SCOPE-003` — ⛔ B2 **MUST NOT** own moderation cases, abuse reports,
enforcement actions, strikes or appeals. Those are `BC-13`'s `ModerationCase`
aggregate (BC Map **L379**).

`SSF-SCOPE-004` — V1: Block, Unblock, rate limiting, Safety Check, abuse
signals. ⚠ **Mute is specified but its persisted structure is gated by
`FOD-2`** — see §B2.5 and `SSF-EC-016`.

`SSF-SCOPE-005` — ⚠ EA **L942** lists `Block Users` at **V2**, contradicting EA
**L921** `Block Enforcement (V1)`, `PRD-020` `F-6`/`TSF-XC-004` (which presuppose
Block exists in V1), and BC Map **L115**/**L377** (which make `BlockList` a
`BC-11` structure with no wave qualifier). **Block is treated as V1** on a
4-authority-to-1 reading. ⛔ **The EA is NOT edited.** The contradiction is
**raised, not adjudicated** — `DOCUMENTATION_BASELINE.md` §4: *"A conflict is a
defect. If you find one, do not choose — raise it."* Routed as `FOD-3`.

`SSF-SCOPE-006` — **Future:** community-scoped safety via `E-28` (V2).

---

## §B2.2 Block

`SSF-FR-001` — A person **MUST** be able to block another person by `PersonId`.

`SSF-BR-001` — Block is **unilateral**. Authority: BC Map **L377** — *"block is
unilateral and overrides friendship."*

`SSF-BR-002` — **Block overrides friendship.** Establishing a block where a
friendship exists **MUST** remove the friendship.

`SSF-FR-002` — Blocking **MUST** cancel any `PENDING` friend request in either
direction.

`SSF-FR-003` — Blocking **MUST** be idempotent.

`SSF-BR-003` — A person **MUST NOT** block themselves.

`SSF-BR-004` — ⚠ **Subject to `FOD-1`.** Whether block establishment and
friendship removal occur in one transaction depends on the `BC-11` aggregate
boundary (BC Map §8 preamble: *"one aggregate, one database transaction, no
exceptions"*). The **outcome** is specified; the **mechanism** awaits ARB.

`SSF-FR-004` — Block **MUST** be enforced **server-side** on every read and
mutation path. ⛔ Client-side filtering is **not** enforcement.

---

## §B2.3 Unblock

`SSF-FR-005` — A person **MUST** be able to unblock someone they blocked.

`SSF-BR-005` — Unblock **MUST NOT** restore a friendship removed by the block.
The pair returns to `NONE`.

`SSF-FR-006` — Unblock **MUST** be idempotent.

`SSF-BR-006` — Only the blocker **MUST** be able to unblock.

⚠ `SSF-GAP-001` — **OPEN.** There is **no** published `social.UserUnblocked`
event. `BC-11`'s surface is closed at **two** (BC Map **L430**:
`social.FriendshipEstablished` / `social.UserBlocked`). **Assessed
NON-BLOCKING** because `BC-12` re-evaluates `canMessage` **at send time**
(BC Map **L378**). ⛔ **No event is minted.** Routed to `BC-11` owner + ARB.

---

## §B2.4 Safety precedence

`SSF-BR-007` — Precedence, highest first:

| Rank | Rule | Authority |
|---|---|---|
| 1 | `BC-13` enforcement (suspension/ban) | `E-14`, `TSF-XC-021` |
| 2 | Block (either direction) | BC Map L377 |
| 3 | Privacy policy (`BC-10`) | BC Map L376 |
| 4 | Mute (viewer preference) | `TSF-XC-005` |
| 5 | Relationship state | BC Map L377 |

`SSF-BR-008` — A lower rank **MUST NOT** override a higher rank.

`SSF-BR-009` — Mute is rank **4** precisely because it is *"a unilateral
graph-visibility **preference**, not a safety decision"* (`TSF-XC-005`).

---

## §B2.5 Mute — the frozen decision, and the one open question

> ⭐ **NOTICE — FROZEN DECISION REPRODUCED, NOT REOPENED.**
> `PRD-020` `TSF-XC-005` is **FROZEN**. It settles Mute's **owner** (same as
> Block ⇒ `BC-11`) and its **classification** (*"a unilateral graph-visibility
> preference, not a safety decision"*). ⛔ **This document does not change,
> reinterpret, weaken or reclassify it.**

`SSF-BR-020` — Mute is owned by `BC-11` and is classified as a **unilateral
graph-visibility preference, not a safety decision.** Four normative
consequences follow:

1. Mute **MUST NOT** be treated as an abuse signal.
2. Mute **MUST NOT** be surfaced to `BC-13` as safety input.
3. Mute **MUST NOT** appear in any moderation record.
4. Mute **MUST NOT** restrict the muted person's own capabilities in any way.

`SSF-FR-007` — A person **MUST** be able to mute another person.
`SSF-FR-008` — A person **MUST** be able to unmute.
`SSF-FR-009` — Mute **MUST** be unilateral and **MUST NOT** be disclosed to the
muted person.
`SSF-FR-010` — Mute **MUST** suppress content/notifications **for the muter
only**.
`SSF-BR-010` — Mute **MUST NOT** remove a friendship.
`SSF-BR-011` — Mute **MUST NOT** prevent messaging. That is Block's role.

⛔ `SSF-BR-021` — **GATED BY `FOD-2` — UNRESOLVED.** `Mute` is **absent from the
BC Map §8 aggregate register**. Verbatim, BC Map **L377** reads:

```
| BC-11 Social Graph | Friendship · BlockList | FriendRequest, RateLimitCounter |
  Symmetric friendship; block is unilateral and overrides friendship;
  request rate limit per rolling window; no self-friendship |
```

Four named structures. **No `Mute`.** Adding one is a **Rank 4 change**, which
`DOCUMENTATION_BASELINE.md` §7 rule 1 requires *"an ADR before the change"*.
⛔ **This document has no such authority, creates no ADR, and makes no BC Map
edit.** The question is recorded as **`FOD-2`**, owner **ARB**, smallest action:
**one ADR authorizing a Rank 4 append of `Mute` to BC Map L377.**

⚠ **This is a register question, not a classification question.** The
classification is already frozen (`SSF-BR-020`) and is **not** reopened.

---

## §B2.6 Server-side enforcement

`SSF-FR-011` — Every block-sensitive read **MUST** filter server-side.
`SSF-FR-012` — Every block-sensitive mutation **MUST** be refused server-side.
`SSF-SEC-001` — ⛔ Enforcement **MUST NOT** depend on a client honouring a flag.
`SSF-SEC-002` — Enforcement **MUST** be non-bypassable. Parity with
`TSF-INV-005`: *"A ranking or recommendation path that reaches the index without
step 3 is a defect."*

---

## §B2.7 Friend-request protection

`SSF-FR-013` — A block in **either** direction **MUST** prevent a friend request.
`SSF-FR-014` — The refusal **MUST** be indistinguishable from "person
unavailable". Authority: `TSF-XC-030` by parity.
`SSF-BR-012` — Repeated blocked-request attempts **MUST** be counted as an abuse
signal (§B2.9) without notifying the target.

---

## §B2.8 Spam prevention and rate limiting

`SSF-FR-015` — Graph-mutation rate limits are owned by `BC-11` via
`RateLimitCounter` (BC Map **L377**). Authority: `F-6`, `TSF-XC-003`.
`SSF-FR-016` — Rate limits **MUST** apply to: friend-request sends, block/unblock
toggling, and mute/unmute toggling.
`SSF-BR-013` — ⚠ **No numeric threshold or window is specified.** ⛔ Not
invented. Owner-set configuration. Routed as `SSF-GAP-002`.
`SSF-FR-017` — A rate-limited action **MUST** be refused with no state change, no
event, and no notification.

---

## §B2.9 Deterministic abuse signals

`SSF-FR-018` — B2 **MUST** expose **deterministic, countable** abuse signals:
(a) blocked-request attempts, (b) rate-limit refusals, (c) block/unblock
toggling frequency, (d) inbound block count.

`SSF-BR-014` — Signals **MUST** be deterministic and reproducible from recorded
state. ⛔ **No heuristic, score, model or probabilistic classifier.**

`SSF-BR-015` — ⛔ B2 **MUST NOT** classify, adjudicate or act on abuse.
Adjudication is `BC-13`'s.

⚠ `SSF-BR-016` — Inbound block count is a **count**, not a judgement. It
**MUST NOT** trigger an automatic restriction inside `BC-11`.

---

## §B2.10 Report integration — without duplicating A6

`SSF-FR-019` — A person **MUST** be able to report another. The report is
**`BC-13`'s** `AbuseReport` (BC Map **L379**).

`SSF-XC-001` — ⛔ B2 **MUST NOT** store, own or duplicate reports, cases,
strikes, enforcement actions or appeals.

⭐ `SSF-XC-002` — **`PRD-021A` Part A6 exists and does NOT change this.**
`PRD_REGISTRY.md` §11.4 records A6 as *"✅ **AUTHORIZED 2026-08-31 as `PRD-021A`
Part A6 — NOT a standalone PRD**"*, executed by `ADR-0083`, with the moderation
architecture settled as an *"existing-edge-fed **local projection**"* and ⛔ *"no
`BC-15` → `BC-13` edge created"*. Critically: *"**`BC-13` / `PRD-020` Trust &
Safety keeps the aggregates and the scope.** `ModerationCase` is still `BC-13`'s
(BC Map **L379**) — ⛔ **no aggregate ownership transferred**."*
⇒ B2 duplicates **nothing** from A6; both **read**, neither owns.

`SSF-FR-020` — Reporting **SHOULD** offer blocking in the same flow, but the two
**MUST** remain independent operations.

---

## §B2.11 Discovery safety

`SSF-FR-021` — B2 **MUST** expose a safety filter to B3's read composition
removing anyone blocked in either direction relative to the viewer.

`SSF-BR-017` — The filter **MUST** be applied **before** results are returned and
**MUST** be non-bypassable. Parity: `TSF-INV-005`.

`SSF-XC-003` — ⛔ B2 **MUST NOT** publish the reason for a discovery exclusion.
Authority: `TSF-XC-030` (verbatim).

⭐ `SSF-XC-004` — ⛔ **`BC-13` MUST NOT filter a discovery result set itself.**
`TSF-XC-029` (FROZEN): *"T&S MUST NOT filter a discovery result set itself — it
has no query path into the graph (`F-3`)."*

---

## §B2.12 Messaging safety

`SSF-FR-022` — `canMessage(a, b)` **MUST** return false when a block exists in
either direction. Authority: `E-16` (BC Map L320) — *"block enforcement lives in
the graph."*
`SSF-BR-018` — `canMessage` is evaluated **at send time** (BC Map **L378**).
`SSF-XC-005` — ⛔ `canMessage` **MUST NOT** disclose the reason.
`SSF-XC-006` — ⛔ B2 owns no message content, retention or delivery.

---

## §B2.13 Community safety integration

`SSF-FR-023` — `E-28` (V2) exposes `RateLimitCounter` + `BlockList` **reads** to
community as a C/S sync port. Verbatim: *"**`BC-11` remains the owner**."*
`SSF-XC-007` — ⛔ No ownership transfer via `E-28`. Read access only.
⚠ `E-28` is **V2**; ⛔ not V1 scope (see `SSF-SCOPE-006`).

---

## §B2.14 Suspension and account deletion

`SSF-FR-024` — On `EnforcementActionTaken{personId, action, scope, until}`
(`E-14`), `BC-11` **MUST** self-restrict.
`SSF-SEC-003` — ⛔ `BC-13` **MUST NOT** write into `BC-11`. Authority: `E-14`
(*"each context self-restricts. **T&S never writes into them**"*);
`TSF-XC-021` — *"`BC-13` MUST NOT write into `BC-10`, `BC-11`, `BC-12`, `BC-14`
or `BC-15`."*
`SSF-FR-025` — On `identity.PersonAnonymised` (BC Map **L428**), B2 **MUST**
remove all block and mute records involving that `PersonId`.
`SSF-BR-019` — A suspension **MUST NOT** delete blocks. Suspension is temporary;
blocks are the other party's preference.

---

## §B2.15 *(reserved — see §B2.16)*

---

## §B2.16 Safety Check interface

`SSF-FR-026` — B2 **MUST** expose a **Safety Check** returning, for an ordered
pair (viewer, target): `blockedEitherDirection` (boolean) and `mutedByViewer`
(boolean).

`SSF-BR-022` — The Safety Check **MUST** return a **computed boolean at read
time**. Precedent: `LCM-RM-023`; and `E-22` (BC Map L331) — *"`BC-11` answers
eligibility as a boolean and never holds a `FileRef`."*

`SSF-SEC-004` — ⛔ The result **MUST NOT** be cached. Precedent: `LCM-RM-021` —
*"no participation authorisation decision cached."*

`SSF-SEC-005` — The Safety Check **MUST fail closed.** If it cannot be evaluated,
the caller **MUST** treat the pair as **unavailable rather than
stale-but-usable** (`LCM-RM-025`).

`SSF-API-001` — The interface is **internal** (consumed by B1, B3, `BC-12` via
`E-16`). ⛔ Not a public endpoint.

`SSF-API-002` — ⚠ **No path, schema, header or status code is specified.**
⛔ Not invented (`ADR-0035` §5.5b class).

---

## §B2.17 Audit

`SSF-FR-027` — Every block, unblock, mute and unmute **MUST** produce an
append-only audit record: actor, target, action, timestamp.
`SSF-XC-008` — ⛔ B2 does not own the audit store (`BC-16`).
`SSF-PRV-001` — ⛔ Audit records **MUST NOT** contain a reason field supplied by
the actor. Block requires no justification.

---

## §B2.18 Privacy and data minimisation

`SSF-PRV-002` — B2 **MUST** store only `PersonId` pairs and timestamps.
`SSF-PRV-003` — ⛔ **No** `StudentRecordId`, **no** `TenantId`. CI-enforced.
`SSF-PRV-004` — ⛔ **No** profile field is denormalised into B2.
`SSF-PRV-005` — ⛔ The muted person **MUST NOT** be able to detect the mute.
`SSF-PRV-006` — ⛔ The blocked person **MUST NOT** be able to detect the block
distinguishably from unavailability.
`SSF-PRV-007` — Block/mute lists **MUST** be visible only to their owner.
`SSF-PRV-008` — ⛔ Aggregate block counts **MUST NOT** be publicly exposed.

---

## §B2.19 Security

`SSF-SEC-006` — Actor resolved **server-side**; client-supplied actor
**rejected, not honoured** (`LCM-API-013`).
`SSF-SEC-007` — ⛔ No authorization decision outside `BC-18` (Stage 3 check 4,
`X-13`).
`SSF-SEC-008` — ⛔ No credentials/OTP/session handling (`ID-1`).
`SSF-SEC-009` — Enumeration resistance: block/mute endpoints **MUST NOT** reveal
target existence.
`SSF-SEC-010` — ⛔ Blocking **MUST NOT** be performable on behalf of another
person.

---

## §B2.20 Performance

`SSF-PERF-001` — Block lookup **MUST** be a single indexed read, O(1) per pair.
`SSF-PERF-002` — The Safety Check **MUST** meet `BC-12`'s synchronous budget.
⚠ No numeric target invented.
`SSF-PERF-003` — Discovery safety filtering **MUST NOT** be O(n) per candidate
against an unbounded list.
`SSF-PERF-004` — Block list pagination **MUST** be cursor-based.
`SSF-PERF-005` — Rate-limit checks **MUST** be O(1).
`SSF-PERF-006` — `PersonAnonymised` cleanup **MAY** be asynchronous but **MUST**
be complete.

---

## §B2.21 Caching and fail-closed

`SSF-CACHE-001` — ⛔ **Block state MUST NOT be cached.**
`SSF-CACHE-002` — ⛔ **The Safety Check result MUST NOT be cached.**
`SSF-CACHE-003` — Mute state **MUST NOT** be cached across a mute/unmute.
`SSF-CACHE-004` — Any cache that cannot be validated ⇒ **unavailable, not
stale-but-usable** (`LCM-RM-025`).
`SSF-CACHE-005` — ⛔ **No materialised view** of block relationships
(`LCM-RM-006`).
`SSF-CACHE-006` — Every failure mode **MUST** fail **closed** (deny), never open.

---

## §B2.22 Data model

`SSF-DM-001` — `BlockList` is a `BC-11` structure (BC Map **L377**).
`SSF-DM-002` — A block record stores `(blockerPersonId, blockedPersonId,
createdAt)`.
`SSF-DM-003` — Directional uniqueness constraint on the ordered pair.
`SSF-DM-004` — ⛔ No `StudentRecordId` / `TenantId` field.
`SSF-DM-005` — ⛔ No denormalised profile field.
`SSF-DM-006` — ⛔ No block-count column; counts derived.
`SSF-DM-007` — `RateLimitCounter` is a `BC-11` structure (BC Map L377).
`SSF-DM-008` — ⚠ **Subject to `FOD-1`** — aggregate membership undecided.
⛔ `SSF-DM-009` — **GATED BY `FOD-2`.** A `mute_list` structure
`(muterPersonId, mutedPersonId, createdAt)` is specified **but MUST NOT be
created** until `FOD-2` is resolved by ARB. **This is the only new persisted
structure B2 proposes.**
`SSF-DM-010` — Timestamps UTC.

---

## §B2.23 APIs

`SSF-API-003` block · `SSF-API-004` unblock · `SSF-API-005` list blocked
(paginated) · `SSF-API-006` mute *(gated by `FOD-2`)* · `SSF-API-007` unmute
*(gated)* · `SSF-API-008` list muted *(gated)* · `SSF-API-009` report → routes to
`BC-13`.
`SSF-API-010` — ⚠ ⛔ No path, route, schema or status code specified.

---

## §B2.24 Events

`SSF-EVT-001` — `social.UserBlocked` → `BC-12`, `BC-26` (BC Map **L430**).
`SSF-EVT-002` — ⛔ **The `BC-11` event surface is closed at two.** No new event
minted.
`SSF-EVT-003` — B2 consumes `EnforcementActionTaken` via `E-14`.
`SSF-EVT-004` — B2 consumes `identity.PersonAnonymised` (BC Map L428).
`SSF-EVT-005` — ⛔ **No mute event is published.** Mute is a private preference
(`TSF-XC-005`), and publishing it would disclose it.
`SSF-EVT-006` — See `SSF-GAP-001` — no unblock event; non-blocking.

---

## §B2.25 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `SSF-EC-001` | Self-block | Refused. `SSF-BR-003` |
| `SSF-EC-002` | Block an existing friend | Friendship removed; requests cancelled |
| `SSF-EC-003` | Block twice | Idempotent |
| `SSF-EC-004` | Unblock when not blocked | Idempotent no-op |
| `SSF-EC-005` | Unblock after block removed a friendship | Friendship **not** restored. `SSF-BR-005` |
| `SSF-EC-006` | Mutual block | Both records exist independently |
| `SSF-EC-007` | Blocked person attempts a friend request | Refused as `UNAVAILABLE` |
| `SSF-EC-008` | Blocked person attempts a message | `canMessage` false; reason not disclosed |
| `SSF-EC-009` | Blocked person appears in discovery | Filtered before return. `SSF-BR-017` |
| `SSF-EC-010` | Block/unblock toggled rapidly | Rate-limited; abuse signal counted |
| `SSF-EC-011` | Safety Check unavailable | Caller fails **closed** |
| `SSF-EC-012` | Suspension arrives via `E-14` | `BC-11` self-restricts; `BC-13` performed no write |
| `SSF-EC-013` | `PersonAnonymised` for a blocked person | All block/mute records removed |
| `SSF-EC-014` | Suspension expires | Blocks still present. `SSF-BR-019` |
| `SSF-EC-015` | Muted person posts content | Hidden **for the muter only**; poster unaffected |
| ⛔ `SSF-EC-016` | **`FOD-2` unresolved at build time** | **DEGRADED SHIP MODE:** mute endpoints return *not implemented*; `mute_list` is **not created**; Block, unblock, rate limiting, Safety Check, and **all of B1 and B3** ship complete and unaffected |

---

## §B2.26 Explicit exclusions (consolidated)

`SSF-XC-009` ⛔ no moderation case · `SSF-XC-010` ⛔ no strike/appeal ·
`SSF-XC-011` ⛔ no automated enforcement inside `BC-11` · `SSF-XC-012` ⛔ no
heuristic abuse scoring · `SSF-XC-013` ⛔ no content scanning ·
`SSF-XC-014` ⛔ no shadow-ban · `SSF-XC-015` ⛔ no reason disclosure ·
`SSF-XC-016` ⛔ no reclassification of Mute. *(Plus `SSF-XC-001`…`008`.)*

---

## §B2.27 Acceptance criteria — GWT (28)

> ⚠ **No criterion is recorded as passing.** ⛔ No test exists and none is claimed.

| ID | Given | When | Then | Maps to |
|---|---|---|---|---|
| `SSF-AC-001` | A and B unrelated | A blocks B | A block record exists; unilateral | `SSF-FR-001`, `SSF-BR-001` |
| `SSF-AC-002` | A blocks A | Attempted | Refused | `SSF-BR-003` |
| `SSF-AC-003` | A and B are friends | A blocks B | Friendship removed | `SSF-BR-002` |
| `SSF-AC-004` | A `PENDING` request exists | A blocks B | Request cancelled | `SSF-FR-002` |
| `SSF-AC-005` | A has blocked B | A blocks B again | Idempotent; one record | `SSF-FR-003` |
| `SSF-AC-006` | A blocked B, removing a friendship | A unblocks B | Friendship **not** restored; status `NONE` | `SSF-BR-005` |
| `SSF-AC-007` | B blocked A | A attempts unblock of B | Refused; only blocker may unblock | `SSF-BR-006` |
| `SSF-AC-008` | B has blocked A | A requests B | Refused as `UNAVAILABLE`; reason not disclosed | `SSF-FR-013/014` |
| `SSF-AC-009` | B has blocked A | Discovery is run by A | B absent; no exclusion reason published | `SSF-BR-017`, `SSF-XC-003` |
| `SSF-AC-010` | B has blocked A | `canMessage(A,B)` called | False; reason not disclosed | `SSF-FR-022`, `SSF-XC-005` |
| `SSF-AC-011` | A blocked B | Client sends a crafted request bypassing UI | Refused server-side | `SSF-FR-011/012`, `SSF-SEC-001` |
| `SSF-AC-012` | Safety Check cannot evaluate | Any consumer calls it | Fails **closed**; treated unavailable | `SSF-SEC-005`, `SSF-CACHE-004` |
| `SSF-AC-013` | Safety Check called twice with a block added between | Second call | Reflects new state; no cached result | `SSF-SEC-004`, `SSF-CACHE-002` |
| `SSF-AC-014` | A toggles block rapidly | Limit exceeded | Refused; no state change; signal counted | `SSF-FR-017`, `SSF-FR-018` |
| `SSF-AC-015` | Repeated blocked-request attempts | Signals are read | Deterministic count; reproducible | `SSF-FR-018`, `SSF-BR-014` |
| `SSF-AC-016` | Abuse signals exist | `BC-11` evaluates them | No automatic restriction applied inside `BC-11` | `SSF-BR-015/016` |
| `SSF-AC-017` | A reports B | Report is stored | Stored by `BC-13`; ⛔ no copy in `BC-11` | `SSF-FR-019`, `SSF-XC-001` |
| `SSF-AC-018` | `EnforcementActionTaken` arrives | `BC-11` processes it | `BC-11` self-restricts; **`BC-13` wrote nothing into `BC-11`** | `SSF-FR-024`, `SSF-SEC-003` |
| `SSF-AC-019` | `PersonAnonymised` for B | Records inspected | All block and mute records for B removed | `SSF-FR-025` |
| `SSF-AC-020` | B is suspended, then suspension expires | Blocks inspected | Blocks still present | `SSF-BR-019` |
| `SSF-AC-021` | A mutes B | B inspects everything visible to B | B cannot detect the mute | `SSF-FR-009`, `SSF-PRV-005` |
| `SSF-AC-022` | A mutes B | B sends a message | Delivery unaffected; mute does not block | `SSF-BR-011` |
| `SSF-AC-023` | A mutes B | Friendship inspected | Friendship intact | `SSF-BR-010` |
| `SSF-AC-024` | A mutes B | `BC-13` inputs inspected | Mute absent from safety inputs and moderation records | `SSF-BR-020` (2)(3) |
| `SSF-AC-025` | Any B2 structure inspected | Fields enumerated | No `StudentRecordId`, no `TenantId`, no profile field | `SSF-PRV-003/004` |
| `SSF-AC-026` | Published events inspected after a block | Event list read | Exactly `social.UserBlocked`; no new event minted | `SSF-EVT-001/002` |
| `SSF-AC-027` | A block list is requested | Requested by a non-owner | Refused; visible only to its owner | `SSF-PRV-007` |
| ⛔ `SSF-AC-028` | **`FOD-2` is unresolved** | Build ships | Mute endpoints return *not implemented*; `mute_list` **absent**; Block, unblock, rate limiting, Safety Check, **all B1 and B3** fully functional | `SSF-DM-009`, `SSF-EC-016` |

---

## §B2.28 Disclosed gaps — all OPEN

| ID | Gap | Blocking? | Routed to |
|---|---|---|---|
| `SSF-GAP-001` | No `social.UserUnblocked` event | ⛔ No — send-time `canMessage` (BC Map L378) | `BC-11` owner + ARB |
| `SSF-GAP-002` | Rate-limit thresholds/windows unspecified | ⛔ No — configuration | Document owner |
| `SSF-GAP-003` | **`FOD-2`** — `Mute` absent from BC Map §8 register | ⚠ **Partially** — gates the `mute_list` structure **only**; degraded ship mode specified | **ARB** |

---

## §B2.29 What this document does not do

⛔ Creates no bounded context (count **31**) · ⛔ creates no edge · ⛔ mints no
event · ⛔ mints no `IMPL-*` · ⛔ creates no implementation task · ⛔ amends no
frozen PRD (`PRD-020` byte-unchanged) · ⛔ amends no Rank 1–5 artefact (BC Map
byte-unchanged) · ⛔ **reclassifies no decision frozen by `TSF-XC-005`** ·
⛔ ratifies no ADR · ⛔ claims no Stage 3 alignment · ⛔ records no AC as passing
· ⛔ resolves neither `FOD-1` nor `FOD-2`.

---

**END — `PRD-021B` Part B2 v0.1 — DRAFT / Stage 2.**
