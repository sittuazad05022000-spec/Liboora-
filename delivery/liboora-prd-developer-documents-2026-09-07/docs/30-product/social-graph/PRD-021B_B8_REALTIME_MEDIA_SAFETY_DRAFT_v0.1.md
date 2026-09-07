<!--
  PRD-021B — Part B8 — Realtime, Media & Messaging Safety
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B8 specification, reconciled against MEASURED
  repository authority.

  ⚠ THE INSTRUCTION THIS DOCUMENT WAS WRITTEN UNDER, QUOTED
  ---------------------------------------------------------
  "But do not assume B8/B9 ownership is already authoritative. If an existing
   context owns these capabilities, preserve that ownership and make B8 a
   compatible specification layer."

  MEASUREMENT ANSWERED THAT CONDITIONAL IN THE AFFIRMATIVE, THREE TIMES OVER.
  B8 is therefore a COMPATIBLE SPECIFICATION LAYER, not an owner.

  1. REALTIME — there is NO realtime bounded context.
     All 31 BCs enumerated: BC-01..BC-06, BC-10..BC-13, BC-17..BC-27,
     BC-29..BC-31. No realtime context among them.
     `platform/services:realtime` is a PORT — tool/module_dependencies.yaml
     L243, granted to the social cluster.
     EA L1847 `Realtime Engine (V1)` is a PLATFORM SERVICE, not a context.
     PRESENCE specifically belongs to BC-12 — BC Map L116 — and FROZEN
     PRD-017 FIL-XC-002 independently confirms a "presence signal" is not
     BC-29's either.
     => B8 SPECIFIES USE OF A PORT. It owns no realtime context.

  2. MEDIA — BC-29 File & Media owns all of it.
     BC Map L138: "Owns upload, virus scan, thumbnailing, signed URLs,
     storage abstraction." FROZEN PRD-017 FIL-FR-034/036/037/018.
     E-22 (BC Map L331) ALREADY lists BC-12 as a BC-29 consumer, admitted by
     ADR-0055, "required by FIL-FR-075...FIL-FR-082, V1 student-to-student
     file sharing".
     => B8 SPECIFIES USE VIA E-22. It owns no byte, no scan, no URL.
     ⭐ AND: media in messaging is V1, not V2. See section B8.3.

  3. MESSAGING SAFETY — ADR-0065 (ACCEPTED 2026-08-22, Option B) ALREADY
     DECIDED the question B8 was asked to decide:
       "The send-time enforcement check is a LOCAL, synchronous read performed
        inside BC-12, against a read model BC-12 maintains from the EXISTING
        E-14 safety.EnforcementActionTaken event. No BC-12 -> BC-13 edge is
        created. No Rank 4 document is amended. No edge identifier is
        allocated."
     => B8 RESTATES A DECIDED ARCHITECTURE. It decides nothing.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 and Stage 4 NOT entered.
-->

# PRD-021B — Part B8

## Realtime, Media & Messaging Safety — a compatible specification layer

> ⛔ **This is a Stage-2 `DRAFT`.** Not approved, not frozen, not baselined,
> not implementation-ready.
>
> ⭐ **B8 owns nothing.** Realtime is a **platform port**. Media is **`BC-29`'s**.
> Messaging safety is **`BC-13`'s**, and its transport is already **decided by
> `ADR-0065`**. Presence is **`BC-12`'s** by BC Map **L116**. B8 states how
> `BC-12` **uses** these, which is the only thing left un-stated.

---

## §0. Document control

| Field | Value |
|---|---|
| Document | `PRD-021B` Part **B8** — Realtime, Media & Messaging Safety |
| Version | **v0.1** |
| Status | **`DRAFT`** |
| Lifecycle stage | **Stage 2 (Draft)**. ⛔ Stage 3 NOT entered |
| Parent | `PRD-021` — `PRD_REGISTRY.md` §4.2 **L321**, status **`PLANNED`** |
| Bounded contexts referenced | **`BC-12`** (spec subject) · **`BC-13`**, **`BC-29`**, **`BC-22`**, **`BC-30`**, **`BC-11`**, **`BC-24`**, **`BC-25`** (all **cited, never claimed**). ⛔ No context created; count remains **31** |
| Platform services referenced | **`platform/services:realtime`**, **`platform/services:files`** — **ports**, manifest **L242**–**L243**. ⛔ **Not** bounded contexts |
| Identifier stem | **`RTM-`** — measured **0** repository-wide occurrences before authoring |
| Ranks this document holds | **None.** Unranked `DRAFT` |
| Freeze | ⛔ **NOT FROZEN** |

### §0.1 Status header
**`PRD-021B` Part B8 — `DRAFT` v0.1 — Stage 2 — NOT FROZEN — NOT APPROVED.**

---

## §B8.1 ⭐ `XPB-CONF-007` — realtime is a port, not a context

### §B8.1.1 The conflict
The supplied specification asks B8 to own *"realtime connection lifecycle"* and
*"presence"*.

### §B8.1.2 The authoritative sources
| # | Source | Rank | Measurement |
|---|---|---|---|
| 1 | BC Map §4 context register | **4** | **31 contexts** enumerated. ⛔ **None is a realtime context** |
| 2 | BC Map **L116** | **4** | `BC-12` *"Owns … **presence**."* — presence is **already owned** |
| 3 | `tool/module_dependencies.yaml` **L243** | **CI-enforced** | `platform/services:realtime` appears under the social cluster's **`ports:`** list |
| 4 | EA **L1847** | 6 | `Realtime Engine (V1)` sits under **PLATFORM SERVICES**, ⛔ not under a context |
| 5 | **FROZEN** `PRD-017` `FIL-XC-002` | **3** | `BC-29` *"**MUST NOT** define a conversation, message, delivery receipt, **presence signal** or …"* — an independent confirmation that presence is **not** a platform-media concern either |

⭐ **Sources 2 and 5 agree from opposite directions.** One says presence *is*
`BC-12`'s; the other says it is *not* `BC-29`'s. Two independent authorities,
same conclusion.

### §B8.1.3 Already resolved?
**Yes.** Ownership of presence is settled (`BC-12`). The realtime **mechanism**
is settled as a platform service reached by a port.

### §B8.1.4 The repository decision, preserved
`BC-12` owns presence. `platform/services:realtime` is the transport. B8 owns
neither.

### §B8.1.5 The smallest compatible resolution
B8 specifies (a) how `BC-12` **hands off** to the realtime port, and (b) how
`BC-12` **models** presence as its own state. ⛔ It creates no context, no edge
and no port. ⭐ **A port grant is not an edge authorisation** — `FIL-FR-007`,
relied on by `ADR-0055`; B8 therefore claims no edge from a port grant.

### §B8.1.6 ⚠ Recorded, not decided — the realtime capability gap
EA **L86** discloses that the PLATFORM SERVICES section was *"Truncated in
source. Realtime Engine present but with no presence, fan-out or scaling
model."* EA **L1853** dates `Presence Service` **V2**, **L1854** dates
`Fan-Out Strategy` **V2**, **L1855** dates `Realtime Scaling & Backpressure`
**V3**. ⛔ B8 does **not** author a fan-out or scaling model to fill that hole —
doing so would be an unranked draft legislating a platform service it does not
own. **`RTM-GAP-001`, owner Platform Engineering + Architecture Owner.**

---

## §B8.2 ⭐ `XPB-CONF-009` — messaging safety is already decided

### §B8.2.1 The conflict
The supplied specification asks B8 to specify *"messaging safety enforcement"*.

### §B8.2.2 The authoritative source
**`ADR-0065`**, **`Accepted` 2026-08-22, Option B**, verbatim:

> *"The send-time enforcement check is a **LOCAL, synchronous read** performed
> inside `BC-12`, against a read model `BC-12` maintains from the **EXISTING**
> `E-14` `safety.EnforcementActionTaken` event. **No `BC-12` → `BC-13` edge is
> created. No Rank 4 document is amended. No edge identifier is allocated.**"*

Reinforced by **FROZEN** `PRD-020` §10.1 `TSF-FR-030`, `TSF-FR-031`,
`TSF-FR-001`, `TSF-INV-007`, and by BC Map **L468**/**L477** (the check is
located *"in BC-12"*) and **L286** (*"T&S never reaches into their models"*).

### §B8.2.3 Already resolved?
**Yes — entirely, and by an `Accepted` ADR.** ⛔ There is nothing here for B8 to
decide.

### §B8.2.4 The repository decision, preserved
Verbatim, in `RTM-FR-020`…`RTM-FR-026` below.

### §B8.2.5 The smallest compatible resolution
B8 **restates** the decided architecture and its **fail-closed staleness gate**,
and adds **only** observability requirements that the ADR's own §7 identifies as
implementation-side and that no ranked document forbids. ⛔ B8 introduces **no**
new transport, **no** edge, **no** synchronous cross-context query.

### §B8.2.6 ⚠ What B8 must NOT be read as closing
**`ADR-0065`** closes the **architecture half** of `TSF-GAP-003` and leaves the
**implementation half OPEN**. ⛔ B8 is a **specification**, not code, and closes
**neither** half further. *(`ADR-0065`: *"`DECIDED` is not `IMPLEMENTED`, and
`IMPLEMENTED` is not `VERIFIED`."*)*

---

## §B8.3 ⭐⭐ `XPB-CONF-008` — media ownership, and a wave correction against my own earlier reading

### §B8.3.1 The conflict
The supplied specification asks B8 to own *"media upload, access and
validation"*. **Additionally**, an earlier working assumption in this authoring
effort held media-in-messaging to be **V2** on EA **L952**/**L953**.

### §B8.3.2 The authoritative sources — ownership
| Source | Rank | Text |
|---|---|---|
| BC Map **L138** | **4** | `BC-29` *"Owns upload, virus scan, thumbnailing, signed URLs, storage abstraction"* |
| **FROZEN** `FIL-FR-034` | **3** | *"All stored objects **SHALL** be private by default"* |
| **FROZEN** `FIL-FR-036` | **3** | *"A signed URL **SHALL** be issued only after an affirmative access decision for that caller"* |
| **FROZEN** `FIL-FR-018` | **3** | Virus/malware scan **before** use |
| BC Map **L331** (`E-22`) | **4** | *"Domain holds a `FileRef`, **never bytes** or a raw storage path"* |

⛔ **B8 owns none of it.**

### §B8.3.3 ⭐ The authoritative sources — wave, and the correction
| Source | Rank | Text | Wave |
|---|---|---|---|
| BC Map **L331** | **4** | *"`BC-12` added by `ADR-0055` — required by `FIL-FR-075`…`FIL-FR-082`, **V1 student-to-student file sharing**"* | **V1** |
| **FROZEN** `PRD-017` **L455** | **3** | *"`FIL-FR-075`…`FIL-FR-082` specify exactly that and nothing more"* | **V1** |
| **FROZEN** `PRD-017` **L435** | **3** | *"The **text** of a message \| `BC-12` — **not this module** \| ✅ **V1** \| `FIL-XC-002`"* | **V1** |
| EA **L952**, **L953** | 6 | `Image Sharing (V2)`, `File Sharing (V2)` | **V2** |

⭐ **The correction, stated plainly.** A **Rank 4** line and a **FROZEN Rank 3**
PRD both date student-to-student file sharing **V1**. The EA's **V2** is
**Rank 6 and descriptive** — `DOCUMENTATION_BASELINE.md` says twice that the EA
*"must follow the PRDs, never lead them."* **Media attachments in messaging are
therefore V1.**

⚠ **This reverses an earlier working assumption in this same authoring effort,
and the reversal is recorded rather than quietly applied.** The earlier reading
took EA **L952**/**L953** at face value and would have deferred a **V1**
capability to **V2** — a real error, caught by measuring `E-22`'s consumer cell
instead of trusting the wave tree.

### §B8.3.4 The precedent that makes this lawful without editing anything
**`PRD-017` L195–L208** already resolved a V1-vs-V2 wave conflict **in favour of
Rank 4's V1** against EA **L1876**. **`ADR-0061`** established the method: a
higher rank prevails over an EA wave tag **without editing the EA**
(*"`Amends:` Nothing … and not the Enterprise Architecture"*).

⛔ **B8 therefore edits the EA not at all.** EA **L952**/**L953** are
**byte-unchanged**. B8 simply follows the higher rank, and says why.

### §B8.3.5 ⚠ Why this determination does NOT extend to presence or read receipts
⭐ **The asymmetry is the whole point, and it is a measurement, not a
preference.** Media has a **Rank 4** line (**L331**) and a **FROZEN Rank 3**
requirement set dating it V1. **Presence, typing and read receipts have
neither** — BC Map **L116** grants `BC-12` *ownership* of presence but assigns
**no wave**, and no Rank 1–4 line dates them. Where authority is **silent above
Rank 6**, the EA's V2 is the only measurement available, so those remain
**owner decisions** (`XPB-CONF-014`, `XPB-CONF-017`), ⛔ **not** determinations.

⭐ This is the `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` §3 distinction applied
honestly in **both** directions: *determined* where authority speaks, *decided
by an owner* where it does not.

---

## §B8.4 ⛔ Ownership refusal register

| ID | Refusal | Real owner + citation |
|---|---|---|
| `RTM-XC-001` | ⛔ B8 **MUST NOT** create a bounded context | Count **31**; none is realtime (§B8.1.2) |
| `RTM-XC-002` | ⛔ B8 **MUST NOT** create an integration edge | BC Map **L292**. Edge set `E-01`…`E-26`, `E-28`, `E-29`; `E-27` permanently vacant |
| `RTM-XC-003` | ⛔ B8 **MUST NOT** own realtime connections, transport, fan-out, scaling or backpressure | **`platform/services:realtime`** — port, manifest **L243**; EA **L1847** |
| `RTM-XC-004` | ⛔ B8 **MUST NOT** create a new platform port or widen an existing one | Manifest is **CI-enforced** and ⛔ **forbidden to modify** by this act |
| `RTM-XC-005` | ⛔ B8 **MUST NOT** own file bytes, upload, virus scanning, thumbnailing, signed URLs or storage | **`BC-29`** — BC Map **L138**; **FROZEN** `PRD-017` |
| `RTM-XC-006` | ⛔ B8 **MUST NOT** decide whether a media share is permitted | **FROZEN** `FIL-FR-076`: *"The module **SHALL NOT** decide whether a share is permitted. The **calling context** …"* — the decision is **`BC-11`'s** to evaluate |
| `RTM-XC-007` | ⛔ B8 **MUST NOT** own moderation, enforcement, reports, cases, strikes or appeals | **`BC-13`** — BC Map **L378**; **FROZEN** `PRD-020` |
| `RTM-XC-008` | ⛔ B8 **MUST NOT** create a `BC-12` → `BC-13` edge or any synchronous cross-context safety query | **`ADR-0065`** Option B; BC Map **L286** |
| `RTM-XC-009` | ⛔ B8 **MUST NOT** read or persist message bodies for safety purposes | **FROZEN** `TSF-XC-016`, `TSF-BR-013` (*"sampling only"*), `TSF-XC-032` |
| `RTM-XC-010` | ⛔ B8 **MUST NOT** own the message-request or rate-limit counter | **`BC-11`'s `RateLimitCounter`** — `TSF-BR-011` |
| `RTM-XC-011` | ⛔ B8 **MUST NOT** own notification channels, templates, quiet hours, dedup or consent | **`BC-22`** — BC Map **L131**; `E-23` **L332** |
| `RTM-XC-012` | ⛔ B8 **MUST NOT** own the client mutation queue, replay or conflict resolution | **`BC-30`** Offline Sync — BC Map **L139** |
| `RTM-XC-013` | ⛔ B8 **MUST NOT** own identity, credentials, sessions or devices | **`BC-18`** — rule **`ID-1`**, BC Map **L178** |
| `RTM-XC-014` | ⛔ B8 **MUST NOT** own the conversation, message, delivery receipt or retention model | **`BC-12`**, specified in **B7** — BC Map **L116**, **L378** |
| `RTM-XC-015` | ⛔ B8 **MUST NOT** own `Block`, `BlockList`, friendship or `canMessage` | **`BC-11`** — `E-16` **L320**; `SGR-XC-004` |
| `RTM-XC-016` | ⛔ B8 **MUST NOT** mint a published event | `BC-12`'s surface stays at **one**: `messaging.MessageSent`, BC Map **L431** |
| `RTM-XC-017` | ⛔ B8 **MUST NOT** store a `tenantId` or `StudentRecordId`, or tenant-scope media bytes | rule **`ID-2`**; **FROZEN** `FIL-FR-081` uses an **isolation class**, ⛔ *"not a tenant predicate"* |
| `RTM-XC-018` | ⛔ B8 **MUST NOT** amend the EA's wave tags | §B8.3.4; `ADR-0061` method |
| `RTM-XC-019` | ⛔ B8 **MUST NOT** allocate an `IMPL-*` identifier or create an implementation task | Stage 5 ⛔ not entered |
| `RTM-XC-020` | ⛔ B8 **MUST NOT** claim to close either half of `TSF-GAP-003` | §B8.2.6 |

**20 refusals.**

---

## §B8.5 Realtime — specification of use, not ownership

`RTM-FR-001` — `BC-12` **SHALL** hand off an accepted `Message` to the
**`platform/services:realtime`** port for opportunistic transport to connected
recipients.

`RTM-BR-001` — ⛔ **Realtime is a transport optimisation, never the delivery
record.** A `Message` is `DELIVERED` when `BC-12` has durably recorded it
(`MSG-FR-008`), ⛔ **not** when a socket frame is written. ⭐ A system that
treats a socket write as delivery loses messages exactly when the network is
worst, which is when it matters.

`RTM-BR-002` — ⛔ Realtime **SHALL NOT** be a precondition for send, receive or
read. Every capability **SHALL** be fully reachable over ordinary request/response.

`RTM-FR-002` — A client **SHALL** reconcile after reconnect by reading
`MSG-API-003` from its last known **sequence** (`MSG-FR-013`), ⛔ never by
trusting that it received every frame.

`RTM-BR-003` — ⛔ A realtime frame **SHALL NOT** be the only carrier of any state
change. Every frame's content **SHALL** be independently re-readable from
`BC-12`'s durable store.

`RTM-FR-003` — Realtime subscription authorisation **SHALL** be evaluated
**server-side** at subscribe time **and** re-evaluated for each fan-out target.
⛔ A client **SHALL NOT** subscribe to a `ConversationId` it is not a participant
of, and **SHALL NOT** be able to enumerate conversations by probing.

`RTM-SEC-001` — ⛔ A realtime channel **SHALL NOT** be authorised by a
client-supplied claim of participation. *(`MSG-SEC-001`; `MP-GBR-08`.)*

`RTM-BR-004` — ⛔ A fan-out **SHALL** apply the same `canMessage`/enforcement
outcome the send path applied. A message refused on the send path **SHALL NOT**
reach any subscriber. ⭐ Otherwise realtime becomes an authorisation bypass —
the exact negative check §B8.11 item 6 tests.

`RTM-FR-004` — Connection lifecycle (connect, authenticate, heartbeat,
reconnect, backoff) **SHALL** be the **port's** concern. ⛔ B8 **SHALL NOT**
specify a wire protocol, frame format, socket library or scaling topology
(`RTM-XC-003`, `RTM-GAP-001`).

`RTM-FR-005` — ⛔ A realtime frame **SHALL NOT** carry a `tenantId`,
`StudentRecordId`, credential, session token, raw storage path or unsigned media
URL (`RTM-XC-017`, `RTM-XC-013`, `MSG-API-012`).

---

## §B8.6 Presence and typing — `BC-12`'s state, ⚠ un-dated by authority

`RTM-FR-006` — Presence, when enabled, **SHALL** be modelled as **`BC-12`
state**, per BC Map **L116**. ⛔ It **SHALL NOT** be modelled as a new context,
and ⛔ **SHALL NOT** be pushed into `BC-29` (**FROZEN** `FIL-XC-002`) or `BC-18`
(`RTM-XC-013`).

`RTM-FR-007` — ⛔ In V1 presence **SHALL NOT** be disclosed to any other person,
and no presence or typing indicator **SHALL** be rendered.

`RTM-CFG-001` — Presence disclosure enabled — default ⛔ **FALSE**.
`RTM-CFG-002` — Typing indicator enabled — default ⛔ **FALSE**.

`RTM-XC-021` — ⛔ `RTM-CFG-001` and `RTM-CFG-002` **SHALL NOT** be set `TRUE`
while `XPB-CONF-017` is **OPEN**. *(The `PYK-XC-004` / `MSG-XC-021` gating
pattern: drafted, gated, un-enablable.)*

`RTM-BR-005` — ⚠ **The wave is an owner decision, not a determination.** BC Map
**L116** confers **ownership** of presence on `BC-12` but assigns **no wave**.
EA **L950** (`Read Receipts & Presence`) and **L1853** (`Presence Service`) both
say **V2**. ⛔ No Rank 1–4 line dates presence, so B8 **records** the tension
rather than resolving it. **`XPB-CONF-017`, owner Architecture Owner + Product
Owner jointly.**

`RTM-BR-006` — If presence is later enabled, it **SHALL** respect `canMessage`
and the block relation: ⛔ a blocked person **SHALL NOT** observe presence, and
the absence **SHALL** be indistinguishable from offline. *(`SGR-SEC-011`;
`SGR-BR-017`.)*

`RTM-SEC-002` — ⛔ Presence **SHALL NOT** disclose device count, device type, IP,
approximate location or last-seen precision beyond `RTM-CFG-003`.

`RTM-CFG-003` — Presence granularity — platform default, coarse.

---

## §B8.7 Media in messaging — use of `BC-29` via `E-22`

`RTM-FR-008` — A `Message` attachment **SHALL** be held as a **`BC-29` `FileRef`**
obtained via **`E-22`**. ⛔ `BC-12` **SHALL NOT** hold bytes or a raw storage
path (BC Map **L331**).

`RTM-FR-009` — Upload **SHALL** be performed against `BC-29`. ⛔ `BC-12`
**SHALL NOT** proxy, buffer, re-encode, thumbnail or scan bytes
(`RTM-XC-005`).

`RTM-BR-007` — ⭐ An attachment **SHALL NOT** be attachable to a `Message` until
`BC-29` reports the object **scanned and safe** (**FROZEN** `FIL-FR-018`).
⛔ `BC-12` **SHALL NOT** perform, re-implement or second-guess the scan; it
**SHALL** consume the verdict (`TSF-FR-039`: *"File safety is `BC-29`'s"*).

`RTM-BR-008` — ⛔ Recipient access **SHALL** be served **only** through a
`BC-29`-issued **signed, expiring URL** (**FROZEN** `FIL-FR-078`), issued only
after an affirmative access decision for that caller (**FROZEN**
`FIL-FR-036`), with the shortest workable validity (**FROZEN** `FIL-FR-037`).
⛔ No attachment **SHALL** be publicly or anonymously reachable
(**FROZEN** `FIL-FR-034`).

`RTM-FR-010` — ⭐ `BC-12` **SHALL** supply `BC-29` with an
**eligibility-decision reference**, per **FROZEN** `FIL-FR-076`, obtained from
`BC-11` via **`E-16`**. ⛔ `BC-12` **SHALL NOT** decide eligibility itself and
⛔ `BC-29` **SHALL NOT** be asked to decide it (`RTM-XC-006`).

`RTM-BR-009` — ⛔ The eligibility decision **SHALL NOT** be cached or reused
across shares. *(`FIL-FR-008` forbids caching a decision; `MSG-BR-006` applies
the same discipline to `canMessage`.)*

`RTM-FR-011` — A share grant **SHALL** convey **read access only** (**FROZEN**
`FIL-FR-077`) and **SHALL** be **revocable** (**FROZEN** `FIL-FR-079`).

`RTM-BR-010` — ⛔ Revocation **SHALL NOT** be claimed to invalidate an
already-issued signed URL. The residual exposure **equals** the `FIL-CFG-004`
lifetime — **disclosed, not eliminated** (**FROZEN** `FIL-AC-062`).

`RTM-FR-012` — On retention purge, `BC-12` **SHALL** revoke its share grants and
⛔ **SHALL NOT** issue a byte-deletion command to `BC-29` (`MSG-BR-017`;
`FIL-XC-002` keeps message retention out of `BC-29`).

`RTM-SEC-003` — ⛔ A `FileRef` **SHALL NOT** be guessable, enumerable, or
readable by a non-participant of the owning `Conversation` (`MSG-SEC-002`).

`RTM-FR-013` — ⭐ **Media attachments in messaging are `V1`.** Determined from
Rank 4 BC Map **L331** + **FROZEN** `FIL-FR-075`…`FIL-FR-082`, over EA
**L952**/**L953**'s Rank 6 V2 tags (§B8.3). ⛔ **The EA is not edited.**

`RTM-BR-011` — ⚠ **Voice messages remain V3** (EA **L954**) and video **Future**
(EA **L955**). ⭐ **Measured distinction:** `FIL-FR-075`…`082` authorise a
**share grant** mechanism, ⛔ **not** a media *type* expansion — so the V1
determination of `RTM-FR-013` extends **only** as far as the grant mechanism and
⛔ **does not** promote voice or video.

### §B8.7.1 ⭐ `XPB-CONF-013` — `FIL-GAP-013` is assigned to `PRD-021`, and B8 answers only the half it may

**Measured — FROZEN `PRD-017` L1162–L1165:**
> *"If the product intent is genuinely that peer sharing must be confined to
> co-members of one library, **that is a requirement on `BC-11`'s eligibility
> rule — `PRD-021`'s to state and `BC-11`'s to evaluate** — not a tenant
> predicate on the bytes. … Recorded as **`FIL-GAP-013`**, owner **Product +
> `PRD-021`**."*

⭐ **The repository explicitly hands this to `PRD-021` to state.** B8 is part of
`PRD-021`, so it **may** state it — and states exactly and only the half it is
competent to state:

`RTM-FR-014` — Whether attachment sharing is confined to co-members of one
library **SHALL** be expressed **as a `BC-11` eligibility input**, surfaced
through **`E-16`**. ⛔ It **SHALL NOT** be expressed as a tenant predicate on
bytes, a `tenantId` on a `FileRef`, or a `BC-29` storage partition
(`RTM-XC-017`; **FROZEN** `FIL-FR-081`, which uses an **isolation class**).

`RTM-BR-012` — ⛔ B8 **SHALL NOT** evaluate that rule and **SHALL NOT** decide
whether the confinement is wanted. ⚠ The **product** question — *is it wanted?* —
is `FIL-GAP-013`'s and stays **OPEN** with **Product Owner**.
**`XPB-CONF-013`.**

⭐ **This is a genuine partial discharge, stated as partial.** B8 supplies the
**architectural shape** the frozen PRD asked `PRD-021` for (an eligibility
input, not a tenant predicate) and ⛔ leaves the **product decision** where it
belongs. `FIL-GAP-013` is **not** claimed closed.

---

## §B8.8 Messaging safety — restatement of a decided architecture

⚠ **Everything in this section is a restatement.** ⛔ Nothing is decided here.

`RTM-FR-015` — `BC-12` **SHALL** maintain a **local enforcement-state read
model**, keyed by `PersonId`, answering *"is this person restricted from
messaging right now?"* **synchronously**. *(**FROZEN** `TSF-FR-030`;
**`ADR-0065`** Option B.)*

`RTM-BR-013` — That read model **SHALL** be fed **only** by the **existing**
`E-14` `safety.EnforcementActionTaken` event that `BC-12` is **already** an
entitled consumer of (BC Map **L433**), and **SHALL** be recomputable from that
event stream alone — ⛔ **never hand-edited** (BC Map **L383** projection
discipline).

`RTM-FR-016` — `BC-12` **SHALL** consult the read model on **every** send, on
the send path, **before** the message is accepted (**FROZEN** `TSF-FR-031`;
`MSG-FR-006` gate 2).

`RTM-FR-017` — ⭐ A **fail-closed staleness gate SHALL** apply: if the read
model's lag exceeds `TSF-CFG-030`, **or its freshness cannot be established**,
the send **SHALL** be **refused**. ⛔ **The gate is not optional** — it is
*"constitutive of the approved architecture, not an optimisation of it"*
(**FROZEN** `PRD-020` §10.1).

`RTM-FR-018` — The check **SHALL** meet **FROZEN** `TSF-FR-001`: **p99 ≤ 50 ms,
fail closed**.

`RTM-XC-022` — ⛔ `BC-13` **SHALL NOT** expose, and `BC-12` **SHALL NOT** call,
any synchronous enforcement query across the context boundary (**FROZEN**
`TSF-FR-030`; **`ADR-0065`**; BC Map **L286**).

`RTM-BR-014` — ⚠ **The residual window is disclosed, not eliminated.** Between
`BC-13` deciding a restriction and `E-14` reaching `BC-12`'s model, a send by
that person **can** succeed. That window is **bounded by `TSF-CFG-030`**, and
exceeding it converts the window into a **refusal** (**FROZEN** `TSF-INV-007`).

`RTM-FR-019` — ⭐ Read-model **lag SHALL be observable and alertable**, because
`RTM-FR-017`'s gate is unimplementable without a lag measurement. *(Named as
implementation-side in `ADR-0065`; ⛔ no ranked document forbids it.)*

`RTM-FR-020` — Message requests **SHALL** follow **FROZEN** `TSF-FR-032`…`035`:
a first message to a non-friend is held as a **request**; a decline **SHALL NOT**
be disclosed to the sender; outstanding-request limits **SHALL** be enforced per
**`TSF-CFG-009`**.

`RTM-BR-015` — ⛔ The request-limit counter is **`BC-11`'s `RateLimitCounter`**
(**FROZEN** `TSF-BR-011`). ⛔ B8 defines **no** second counter —
*"Two counters for one fact is how they drift apart."*

`RTM-FR-021` — An adult-classified sender's first contact with a
minor-classified recipient sharing no graph proximity **SHALL** be held as a
request **and** raise the `PRD-020` §5.3 signal (**FROZEN** `TSF-FR-035`).
⛔ B8 **SHALL NOT** define the classification, the proximity test or the signal —
all `BC-13`'s / `BC-11`'s.

`RTM-FR-022` — `messaging.MessageSent` **SHALL** be consumed by `BC-13`
**for sampling only** (**FROZEN** `TSF-BR-013`; BC Map **L431**). ⛔ The sample
**SHALL** feed volumetric counters only and **SHALL NOT** persist bodies
(**FROZEN** `TSF-XC-016`).

`RTM-FR-023` — Reported message content **SHALL** reach `BC-13` **only** as a
**reporter-supplied** evidence snapshot of content already lawfully visible to
them (**FROZEN** `TSF-FR-036`, `TSF-BR-012`, `TSF-FR-037`). ⛔ `BC-12`
**SHALL NOT** push bodies to `BC-13` and `BC-13` **SHALL NOT** query the message
store.

`RTM-XC-023` — ⛔ V1 **SHALL NOT** perform automated content classification of
message bodies (**FROZEN** `TSF-XC-032`). ⭐ *"This is a **privacy posture**, not
a capability gap."*

`RTM-FR-024` — A reported link **SHALL** be recorded by **normalised URL and
hash**, ⛔ never fetched by a moderator's browser session (**FROZEN**
`TSF-FR-038`).

`RTM-FR-025` — On receiving `E-14`, `BC-12` **SHALL** self-restrict. ⛔ `BC-13`
**SHALL NOT** write into `BC-12`'s model (`E-14` **L318**: *"each context
self-restricts. T&S never writes into them"*).

`RTM-FR-026` — ⛔ B8 **SHALL NOT** claim `TSF-GAP-003` closed in either half
(`RTM-XC-020`, §B8.2.6).

---

## §B8.9 Offline behaviour — `BC-30`'s, used not owned

`RTM-FR-027` — Client-side queuing and replay of an unsent message **SHALL** be
**`BC-30` Offline Sync's** concern — BC Map **L139**: *"Owns the client mutation
queue, replay, conflict detection and resolution policy."* ⛔ B8 **SHALL NOT**
define a second queue (`RTM-XC-012`).

`RTM-BR-016` — ⭐ A replayed send **SHALL** be made safe **only** by
`MSG-FR-011`'s idempotency key, ⛔ **never** by client-side de-duplication.

`RTM-BR-017` — ⛔ A queued send **SHALL** be re-gated on arrival: `canMessage`
and the enforcement read model **SHALL** be evaluated **at server receipt time**,
⛔ **never** at client queue time. ⭐ Otherwise an offline queue becomes a
mechanism for a blocked or banned person to deliver a message, which is exactly
the harm BC Map **L477** names.

`RTM-BR-018` — ⛔ A queued send **SHALL NOT** be presented to the sender as
delivered before `BC-12` accepts it (`RTM-BR-001`).

`RTM-FR-028` — ⚠ EA **L1860** dates `Conflict Resolution` **V2**. ⛔ B8 defines
no conflict-resolution policy for messaging — messages are **append-only**
(`MSG-INV-003`, `MSG-INV-005`), so no merge conflict arises for a `Message`.
⭐ Stated because the absence is a **consequence of immutability**, not an
oversight.

---

## §B8.10 Notification hand-off

`RTM-FR-029` — `BC-12` **SHALL** emit a notification **fact** via **`E-23`** to
`BC-22`. ⛔ It **SHALL NOT** select a channel, choose a template, evaluate quiet
hours, deduplicate or check consent (BC Map **L131**, **L332**;
`RTM-XC-011`).

`RTM-BR-019` — ⛔ The fact **SHALL NOT** carry the message body. ⭐ A
notification payload containing the body would make `BC-22` a message store and
would place bodies in channels (SMS, push) that `BC-12`'s security model does not
govern.

`RTM-BR-020` — Per-conversation mute (`MSG-FR-022`) **SHALL** be expressed **in**
the fact, ⛔ never as `BC-12` suppressing the emission (`MSG-FR-023`).

`RTM-FR-030` — ⛔ B8 **SHALL NOT** create a second notification system, a second
delivery guarantee or a second consent record (`RTM-XC-011`).

---

## §B8.11 ⛔ Negative self-checks

| # | Negative check | Result | Evidence |
|---|---|---|---|
| 1 | No duplicate ownership | ✅ **PASS** | 23 refusals (§B8.4, `RTM-XC-021`…`023`) |
| 2 | No duplicate entity | ✅ **PASS** | B8 registers **0** aggregates/entities |
| 3 | No new event | ✅ **PASS** | `RTM-XC-016`; surface stays at **one** (BC Map **L431**) |
| 4 | No unauthorised edge | ✅ **PASS** | `RTM-XC-002`; 6 pre-existing edges used |
| 5 | No cross-library data leakage | ✅ **PASS** | `RTM-XC-017`, `RTM-FR-014`; `X-13` obeyed; **FROZEN** `FIL-FR-081` isolation class, not tenant predicate |
| 6 | No privacy bypass via realtime | ✅ **PASS** | `RTM-FR-003`, `RTM-BR-004`, `RTM-SEC-001` |
| 7 | No block / safety bypass | ✅ **PASS** | `RTM-BR-004`, `RTM-BR-017`, `RTM-BR-006`, `RTM-FR-016` |
| 8 | No client-controlled authorisation | ✅ **PASS** | `RTM-SEC-001`, `RTM-FR-003`, `RTM-BR-017` |
| 9 | No duplicate notification system | ✅ **PASS** | `RTM-FR-030`, `RTM-XC-011` |
| 10 | No duplicate identity/profile/membership | ✅ **PASS** | `RTM-XC-013`, `RTM-XC-017` |
| 11 | No new platform port or widened grant | ✅ **PASS** | `RTM-XC-004`; manifest **byte-unchanged** |
| 12 | No frozen requirement reinterpreted | ✅ **PASS** | `TSF-*`/`FIL-*` quoted verbatim; §B8.2, §B8.7 |

---

## §B8.12 Scope — V1 / Future / Deferred / Open / Constraints

### §B8.12.1 ✅ V1
Realtime **hand-off to the port** · durable-record delivery independent of
realtime · sequence-based reconnect reconciliation · server-side subscription
authorisation with per-target re-evaluation · **media attachments via `E-22`**
(⭐ **V1**, §B8.3) · scan-before-attach · signed expiring URLs only ·
eligibility-decision reference from `BC-11` · revocable read-only share grants ·
grant revocation on purge · the **entire** `ADR-0065` send-time check with its
fail-closed staleness gate · lag observability · message requests per FROZEN
`TSF-FR-032`…`035` · `messaging.MessageSent` sampling · reporter-supplied
evidence snapshots · `E-23` notification facts without bodies · `BC-30`-based
offline queuing with server-side re-gating · presence **modelled**, ⛔ gated OFF.

### §B8.12.2 🔵 Future — dated by authority, ⛔ not built
| Capability | Wave | Authority |
|---|---|---|
| Presence service · read receipts | **V2** | EA **L1853**, **L950** (⚠ `XPB-CONF-017`, `XPB-CONF-014`) |
| Fan-out strategy | **V2** | EA **L1854** (⚠ `RTM-GAP-001`) |
| Offline conflict resolution | **V2** | EA **L1860** (⚠ moot — `RTM-FR-028`) |
| Encryption at rest | **V2** | EA **L949** |
| Voice messages | **V3** | EA **L954** (`RTM-BR-011`) |
| Realtime scaling & backpressure | **V3** | EA **L1855** (⚠ `RTM-GAP-001`) |
| Video calling | **Future** | EA **L955** |

### §B8.12.3 ⛔ Deferred by B8 with a stated reason
| Item | Why |
|---|---|
| Wire protocol / frame format / socket topology | Port's, not B8's (`RTM-FR-004`, `RTM-XC-003`) |
| Fan-out and scaling model | EA **L86** discloses the platform model is absent; an unranked draft may not legislate it (`RTM-GAP-001`) |
| Automated body classification | **FROZEN** `TSF-XC-032` — a privacy posture (`RTM-XC-023`) |
| Presence / typing disclosure | Un-dated by Rank 1–4; gated (`RTM-XC-021`) |
| Voice / video media types | `FIL-FR-075`…`082` authorise a **grant mechanism**, not a type expansion (`RTM-BR-011`) |
| Whether same-library confinement is wanted | `FIL-GAP-013`'s **product** half (`RTM-BR-012`) |

### §B8.12.4 ⚠ Open owner decisions
See §B8.14.

### §B8.12.5 🔒 Existing repository constraints B8 obeys
| Constraint | Source |
|---|---|
| No realtime bounded context exists; realtime is a port | BC Map §4 (31); manifest **L243**; EA **L1847** |
| Presence is `BC-12`'s | BC Map **L116**; **FROZEN** `FIL-XC-002` |
| `BC-29` owns upload, scan, thumbnails, signed URLs, storage | BC Map **L138**; **FROZEN** `PRD-017` |
| Domain holds a `FileRef`, never bytes | `E-22` **L331** |
| `BC-29` never decides whether a share is permitted | **FROZEN** `FIL-FR-076` |
| Student-to-student file sharing is **V1** | BC Map **L331**; **FROZEN** `FIL-FR-075`…`082` |
| Same-library confinement is a `BC-11` eligibility rule for `PRD-021` to state | **FROZEN** `PRD-017` L1162–65, `FIL-GAP-013` |
| Send-time check is a local `E-14`-fed read; ⛔ no `BC-12`→`BC-13` edge | **`ADR-0065`** Option B |
| Fail-closed staleness gate is constitutive | **FROZEN** `TSF-FR-031`, `TSF-INV-007` |
| T&S never reads bodies at rest; sampling only | **FROZEN** `TSF-XC-016`, `TSF-BR-013` |
| Request counter is `BC-11`'s | **FROZEN** `TSF-BR-011` |
| Domains emit notification facts, never channel instructions | `E-23` **L332** |
| `BC-30` owns the client mutation queue | BC Map **L139** |
| The EA is Rank 6 and descriptive | `DOCUMENTATION_BASELINE.md` (×2); `ADR-0061` |

---

## §B8.13 Acceptance criteria — 28, all Given/When/Then, all mapped

`RTM-AC-001` — **Given** a recipient with no realtime connection, **when** a
message is sent, **then** it is durably recorded and `DELIVERED`, and the sender
sees success. *(`RTM-BR-001`, `RTM-BR-002`)*

`RTM-AC-002` — **Given** a client that missed frames while disconnected,
**when** it reconnects and reads from its last sequence, **then** it obtains
every missed message with no gap. *(`RTM-FR-002`, `RTM-BR-003`)*

`RTM-AC-003` — **Given** realtime is entirely unavailable, **when** a user sends,
reads and marks read, **then** all three succeed over request/response.
*(`RTM-BR-002`)*

`RTM-AC-004` — **Given** a caller who is not a participant, **when** they attempt
to subscribe to a `ConversationId`, **then** it is refused and the response does
not reveal whether the conversation exists. *(`RTM-FR-003`, `RTM-SEC-001`)*

`RTM-AC-005` — **Given** a client asserting participation in its subscribe
payload, **when** the server authorises, **then** the assertion is ignored and
server-side state decides. *(`RTM-SEC-001`, `RTM-FR-003`)*

`RTM-AC-006` — **Given** a send refused by `canMessage` or the enforcement gate,
**when** fan-out runs, **then** no subscriber receives any frame for it.
*(`RTM-BR-004`, `RTM-FR-016`)*

`RTM-AC-007` — **Given** a realtime frame, **when** its payload is inspected,
**then** it contains no `tenantId`, `StudentRecordId`, credential, session token,
raw storage path or unsigned media URL. *(`RTM-FR-005`, `RTM-XC-017`)*

`RTM-AC-008` — **Given** V1, **when** any client requests another person's
presence or typing state, **then** nothing is returned and no indicator is
rendered. *(`RTM-FR-007`, `RTM-SEC-002`)*

`RTM-AC-009` — **Given** `XPB-CONF-017` is OPEN, **when** `RTM-CFG-001` or
`RTM-CFG-002` is set `TRUE`, **then** the configuration is refused.
*(`RTM-XC-021`)*

`RTM-AC-010` — **Given** presence were enabled and a block exists, **when** the
blocked person observes the other, **then** the result is indistinguishable from
offline. *(`RTM-BR-006`)*

`RTM-AC-011` — **Given** presence data, **when** it is served, **then** it
discloses no device count, device type, IP or location. *(`RTM-SEC-002`,
`RTM-CFG-003`)*

`RTM-AC-012` — **Given** an attachment, **when** the `Message` is stored,
**then** `BC-12` holds a `FileRef` and no bytes and no raw storage path.
*(`RTM-FR-008`, `RTM-FR-009`)*

`RTM-AC-013` — **Given** an object `BC-29` has not reported scanned and safe,
**when** attachment is attempted, **then** it is refused. *(`RTM-BR-007`)*

`RTM-AC-014` — **Given** a recipient reading an attachment, **when** access is
served, **then** it is a `BC-29`-issued signed URL with a bounded lifetime, and
no unauthenticated request succeeds. *(`RTM-BR-008`, `RTM-SEC-003`)*

`RTM-AC-015` — **Given** a share, **when** it is granted, **then** an
eligibility-decision reference obtained from `BC-11` via `E-16` is present, and
`BC-12` performed no eligibility evaluation of its own. *(`RTM-FR-010`,
`RTM-XC-006`)*

`RTM-AC-016` — **Given** a prior successful share, **when** a second share is
requested, **then** a fresh eligibility decision is obtained and no cached
decision is reused. *(`RTM-BR-009`)*

`RTM-AC-017` — **Given** a recipient of a share, **when** they attempt to
replace, delete or re-share the object, **then** it is refused and ownership is
unchanged. *(`RTM-FR-011`)*

`RTM-AC-018` — **Given** a revoked grant, **when** exposure is documented,
**then** it equals the `FIL-CFG-004` lifetime and is not claimed to be zero.
*(`RTM-BR-010`)*

`RTM-AC-019` — **Given** a retention purge of a message with an attachment,
**when** it completes, **then** grants are revoked and no byte-deletion command
was issued to `BC-29`. *(`RTM-FR-012`)*

`RTM-AC-020` — **Given** V1, **when** attachment sharing is exercised, **then**
it functions as a V1 capability, and EA **L952**/**L953** are byte-unchanged.
*(`RTM-FR-013`, `RTM-XC-018`)*

`RTM-AC-021` — **Given** a voice or video attachment attempt, **when** it is
submitted, **then** it is refused as out of V1 scope. *(`RTM-BR-011`)*

`RTM-AC-022` — **Given** same-library confinement were required, **when** it is
enforced, **then** it is applied as a `BC-11` eligibility input via `E-16`, and
no `tenantId` appears on a `FileRef` or storage partition. *(`RTM-FR-014`,
`RTM-BR-012`)*

`RTM-AC-023` — **Given** the send path, **when** the enforcement check runs,
**then** it reads a local `E-14`-fed model inside `BC-12`, no call is made to
`BC-13`, and the check completes before acceptance. *(`RTM-FR-015`,
`RTM-FR-016`, `RTM-XC-022`)*

`RTM-AC-024` — **Given** read-model lag exceeding `TSF-CFG-030`, **or** lag that
cannot be established, **when** a send is attempted, **then** it is refused.
*(`RTM-FR-017`, `RTM-BR-014`)*

`RTM-AC-025` — **Given** the read model, **when** its lag is queried, **then** a
lag measurement is available and alertable. *(`RTM-FR-019`, `RTM-FR-018`)*

`RTM-AC-026` — **Given** `BC-13`, **when** it consumes `messaging.MessageSent`,
**then** only volumetric counters are updated and no body is persisted; and
**when** it seeks body content, **then** the only available path is a
reporter-supplied snapshot. *(`RTM-FR-022`, `RTM-FR-023`, `RTM-XC-023`)*

`RTM-AC-027` — **Given** a message queued offline while the sender was
unrestricted, **when** the sender is blocked or restricted before the queue
drains, **then** the send is refused at server receipt time and is never
delivered. *(`RTM-BR-017`, `RTM-BR-018`)*

`RTM-AC-028` — **Given** a message arrives, **when** the `E-23` fact is emitted,
**then** it contains no message body, selects no channel, and mute is expressed
in the fact rather than as a suppressed emission. *(`RTM-BR-019`,
`RTM-BR-020`, `RTM-FR-029`)*

**28 ACs · 28 mapped · 0 orphans.**

---

## §B8.14 ⚠ Disclosed conflicts and gaps — OPEN, each with a named owner

| ID | Item | Disposition | Owner |
|---|---|---|---|
| `XPB-CONF-007` | B8 asked to own realtime + presence | ✅ **RESOLVED IN THIS DRAFT** — realtime is a **port**, presence is **`BC-12`'s**; B8 became a specification layer (§B8.1) | — |
| `XPB-CONF-008` | B8 asked to own media; **and** an earlier reading mis-dated it **V2** | ✅ **RESOLVED IN THIS DRAFT** — ownership is `BC-29`'s; wave is **V1** by Rank 4 + FROZEN Rank 3 over Rank 6 (§B8.3). ⚠ The earlier error is disclosed, not hidden | — |
| `XPB-CONF-009` | B8 asked to specify messaging-safety enforcement | ✅ **ALREADY RESOLVED BY `ADR-0065`** — B8 restates (§B8.2) | — |
| `XPB-CONF-013` | `FIL-GAP-013` same-library confinement of peer sharing | ⚠ **PARTIALLY DISCHARGED** — architectural shape stated (`RTM-FR-014`); ⛔ **product question OPEN** | Product Owner |
| `XPB-CONF-017` | Presence / typing wave: BC Map **L116** owns it, EA **L950**/**L1853** date it **V2**, no Rank 1–4 line dates it | ⛔ **OPEN** — drafted, gated **FALSE**, un-enablable | Architecture Owner + Product Owner |
| `RTM-GAP-001` | ⚠ EA **L86** discloses the platform realtime model has *"no presence, fan-out or scaling model"*; EA **L1854**/**L1855** date them V2/V3 | ⛔ **OPEN** — B8 refuses to legislate a platform service | Platform Engineering + Architecture Owner |
| `RTM-GAP-002` | ⚠ `TSF-GAP-003`'s **implementation** half remains OPEN per `ADR-0065`; B8 is a specification and closes neither half | ⛔ **OPEN** — pre-existing, not created here | `BC-12` owner |

---

## §B8.15 ⛔ What B8 does **not** do

1. ⛔ Confers no lifecycle stage. **Stage 2 only.**
2. ⛔ Creates **no** bounded context. Count remains **31**.
3. ⛔ Creates **no** integration edge and **no** platform port.
4. ⛔ Mints **no** published event.
5. ⛔ Registers **no** aggregate or entity.
6. ⛔ Amends **no** Rank 1–6 document. BC Map, **EA (incl. L952/L953)**, Matrix,
   `MASTER_PRD.md` and every FROZEN PRD are **byte-unchanged**.
7. ⛔ Modifies **no** file under `tool/` — the CI manifest is untouched.
8. ⛔ Reinterprets **no** frozen requirement; `TSF-*`/`FIL-*` are quoted verbatim.
9. ⛔ Overrides **no** ADR. `ADR-0055` and `ADR-0065` are relied on as written;
   **no new ADR is created**.
10. ⛔ Claims **no** closure of `TSF-GAP-003` or `FIL-GAP-013`.
11. ⛔ Duplicates **no** ownership — 23 refusals.
12. ⛔ Allocates **no** `IMPL-*` and creates **no** implementation task.
13. ⛔ Writes **no** baseline row and **no** traceability row.
14. ⛔ Does **not** freeze, approve or baseline `PRD-021B`.

---

## §B8.16 Status

**`PRD-021B` Part B8 = `DRAFT` / Stage 2.**

⛔ NOT Stage 3. ⛔ NOT Stage 4. ⛔ NOT Approved. ⛔ NOT Frozen. ⛔ NOT
Implementation Ready.

**Measured content:** 30 `RTM-FR-*` · 20 `RTM-BR-*` · 3 `RTM-SEC-*` · 23
`RTM-XC-*` · 3 `RTM-CFG-*` · 2 `RTM-GAP-*` · **28 `RTM-AC-*`, all mapped, 0
orphans**. 12/12 negative self-checks PASS. 0 contexts created. 0 edges created.
0 ports created. 0 events minted. 0 aggregates registered.

### §B8.17 Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Initial Stage-2 draft. ⭐ Authored as a **compatible specification layer** after measurement confirmed, on three independent counts, that the capabilities B8 was asked to own are already owned: **realtime is a platform port** with no bounded context anywhere in the 31 (`XPB-CONF-007`); **media is `BC-29`'s** (`XPB-CONF-008`); and **messaging-safety transport was already decided by `ADR-0065` Option B** (`XPB-CONF-009`). ⭐ Presence was confirmed `BC-12`'s by **two** independent authorities pointing the same way — BC Map **L116** positively, FROZEN `FIL-XC-002` negatively. ⚠ **A wave error made earlier in this authoring effort is corrected and disclosed**: media-in-messaging is **V1** on Rank 4 BC Map **L331** + FROZEN `FIL-FR-075`…`FIL-FR-082`, ⛔ not V2 as EA **L952**/**L953** suggest — the EA being **Rank 6 and descriptive**, resolved by the `PRD-017` L195–208 precedent using the `ADR-0061` method, so **the EA is not edited**. ⚠ Presence/typing were deliberately **not** given the same treatment, because unlike media they have **no** Rank 1–4 dating line — recorded as `XPB-CONF-017` instead. ⭐ `FIL-GAP-013` was **partially discharged** in the one respect FROZEN `PRD-017` L1162 expressly assigns to `PRD-021` — stating the confinement as a `BC-11` eligibility input rather than a tenant predicate — with the product question left **OPEN** |
