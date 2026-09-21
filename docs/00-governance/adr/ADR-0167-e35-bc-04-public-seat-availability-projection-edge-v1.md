# ADR-0167 — The `BC-04` public seat-availability gap is registered and closed: edge **`E-35`** `BC-04 Seating → BC-23 Search Indexing` (`PL`, Event, **V1**), payload `{libraryId, availabilityState}` only

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — **2026-09-19**, under the one-act conferral recorded **verbatim** at **§10.1**. ⛔ **Reverting on completion** *(`ADR-0033` §7.1)*. ⚠️⚠️ **NO INDEPENDENT REVIEW CLAIMED** — expressly so stated in the conferral |
| **Rank** | 2 — Architecture Decision Record |
| **Date prepared** | 2026-09-19 |
| **Bounded context** | `BC-04` Seating *(producer)* · `BC-23` Search Indexing *(consumer)* · Library §14B Public Preview *(the read composition served)* |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| ⭐⭐ **Deciding authority** | ⭐⭐ **Architecture Owner** — BC Map **L292** *("adding an edge requires an **ADR**")*; `PRD_OWNERSHIP_MODEL` §2.2 *(boundaries, ranks, permitted edges)* |
| **Contributing offices** | ⛔⛔ **NONE.** ⭐ No Product Owner, Privacy Owner or Security Owner input is claimed, exercised or recorded |
| **Decides** | ⭐ **One gap registered** · ⭐ **one edge declared — `E-35`** · ⭐ **one payload boundary fixed**. ⛔ **Nothing else** |
| **Expressly does NOT decide** | ⛔⛔ **The `Available` / `Limited` / `Full` thresholds — a PRODUCT OWNER act** · ⛔ any UI · ⛔ any implementation · ⛔ `SEAT-CFG-017` · ⛔ `SEAT-GAP-005` / `SEAT-GAP-014` · ⛔ `LIB-24.2`'s deferred privacy review · ⛔ Public Live Occupancy *(stays **V2**)* · ⛔ any `PERM-*`, role, office or scope class · ⛔ `DD-0007`'s counts or design-readiness |
| **Amends** | ⚠️ **Prescribes** a Rank-4 `LIBOORA_BOUNDED_CONTEXT_MAP.md` amendment **by append** *(§8)* — ⛔ **NOT executed here** |
| **Origin** | ⭐ The read-only V1/V2 boundary analysis of 2026-09-19, which found the gap while verifying the `BC-04 → BC-23` projection flow |

> ⭐⭐ **Two identifier spaces were re-measured immediately before drafting.**
> **ADR:** `ADR-0166` highest on disk; `ADR-0167` measured **0** files and **0**
> references; `0150`–`0166` gap-tested **contiguous**.
> **Edge:** see **§4.3** — ⭐ `E-35` verified free by four probes, with ⛔ `E-27`
> permanently vacant and ⛔ `E-31` **reserved**.

---

## 1. ⭐⭐ The decision

### `D-1` — ⭐ The gap is REGISTERED

⭐⭐ **A V1 `MUST` requirement has no lawful data path.** `Library_PRD_v1.md` §14B
**L92** requires the public preview to publish *"**Aggregate** public seat
information"* sourced from **`BC-04`**, and `LIB-14B.12` makes the coarse
availability indicator **mandatory in V1** — ⛔ **but `BC-04` is the source of ZERO
edges** and **no public-facing context consumes any `BC-04` event**.

⭐ Registered here as **`GAP-BCMAP-BC04-PUBLIC`** *(§3.5)*.

### `D-2` — ⭐⭐ Edge **`E-35`** is DECLARED

| Field | Value |
|---|---|
| **Identifier** | ⭐⭐ **`E-35`** |
| **Source** | **`BC-04` Seating** |
| **Target** | **`BC-23` Search Indexing** |
| **Pattern** | **`PL`** *(Published Language)* |
| **Mechanism** | **Event** |
| **Tier** | ⭐⭐ **V1** |
| **Payload** | ⭐⭐ **`{libraryId, availabilityState}` — and nothing else** |

### `D-3` — ⭐⭐ The payload boundary is FIXED and is the privacy control

⭐ **`E-35` MUST carry exactly two fields:**

| Field | Type | Meaning |
|---|---|---|
| `libraryId` | Tenant/library identifier | ⭐ Which library the state describes |
| `availabilityState` | ⭐⭐ **Closed enumeration of exactly three values** | ⭐ The coarse qualitative indicator `LIB-14B.12` mandates |

⛔⛔ **`E-35` MUST NOT carry, in any form, encoded or derived:**

| ⛔ Forbidden | Authority |
|---|---|
| Any **occupancy count** | `LIB-14B.11`, `LIB-14B.12`, `SEAT-FR-117` |
| Any **percentage** or ratio | `LIB-14B.11`, `LIB-14B.13` |
| Any **free-seat count**, precise or approximate | `LIB-14B.12` |
| Any **seat identifier**, number, floor, zone or category | `LIB-14B.11`, `LIB-7.3`, `SEAT-XC-009` |
| Any **per-seat status, history or timing** | `LIB-14B.11`, `SEAT-FR-250` |
| Any **attendance datum**, presence, absence or arrival time | ⭐⭐ **`LIB-14B.14`** |
| Any **`PersonId`**, `StudentRecordId`, account or device identifier | `ID-2`, `ID-3`, `X-05` |
| Any **timestamp of a state change** beyond ordinary envelope metadata | `LIB-14B.14` *(timing is a presence proxy)* |

⭐⭐ **The two-field payload is not a summary of a richer event — it is the whole
event.** ⛔ A count that is "rounded" or "bucketed" at the consumer is **still a
count crossing the boundary**, and is forbidden.

### `D-4` — ⛔⛔ The enumeration is closed; ⛔ its THRESHOLDS are NOT decided

⭐ `availabilityState` is a **closed enumeration of exactly three values**,
matching `LIB-14B.12`'s named examples.

⛔⛔ **This ADR does NOT decide what makes a library `Available`, `Limited` or
`Full`.** ⭐ That is a **Product Owner** act, ⛔ expressly excluded by the conferral
and ⛔ outside the Architecture Owner's competence *(`PRD_OWNERSHIP_MODEL` §2.2:
scope, priority and acceptance belong to the Product Owner)*.

⭐ **What IS architecturally fixed** *(because it is a boundary question, not a
product one)*: the state **MUST** be computed **inside `BC-04`** from
**allocation-versus-capacity**, and ⛔⛔ **MUST NOT** be derived from attendance
records or physical presence — **`LIB-14B.14`**. ⭐ §5.2 explains why this limb is
architectural.

### `D-5` — ⛔ Public Live Occupancy remains **V2**

⛔⛔ **Untouched:** `LIB-14B.13` · `LIB-24.2` · `SEAT-XC-009` · `SEAT-XC-020` ·
`SEAT-FR-250` · `ARCHITECTURE_RULINGS.md` §6 · `SEAT-GAP-014`.

⭐⭐ **`E-35` is the mechanism `LIB-14B.12` already requires — ⛔ NOT an early
delivery of what `LIB-14B.13` defers.** §6 proves the distinction.

---

## 2. ⭐ Scope

| Dimension | Disposition |
|---|---|
| ⭐ Gap registration | ⭐⭐ **DONE** — `GAP-BCMAP-BC04-PUBLIC` |
| ⭐ Edge declaration | ⭐⭐ **DONE** — `E-35` |
| ⭐ Payload boundary | ⭐⭐ **DONE** — two fields, closed |
| ⭐ Derivation **input class** | ⭐ **FIXED** — allocation ÷ capacity; ⛔ **never** attendance |
| ⛔ Threshold **values** | ⛔⛔ **NOT DECIDED — Product Owner** |
| ⛔ Event **name** | ⛔ **NOT MINTED** — §7.2 |
| ⛔ UI / widgets / code | ⛔ **NOT DECIDED** |
| ⛔ BC Map file edit | ⛔ **NOT EXECUTED** — §8 |
| ⛔ Frozen/approved specs | ⛔ **UNTOUCHED** |

---

## 3. ⭐⭐ The gap — established by measurement

### 3.1 What the V1 contract requires

| Source | Requirement |
|---|---|
| ⭐ 14B **L92** | *"Seats \| **Aggregate** public seat information \| **`BC-04`**"* |
| ⭐⭐ `LIB-14B.12` | *"Public seat availability **MUST** be expressed as a coarse qualitative indicator — for example **Available, Limited, Full**"* |
| ⭐ `LIB-14B.9` | *"The projection **MUST** be built from **events emitted by the owning contexts**. The preview **MUST NOT** query another context's store directly."* |
| ⭐ `LIB-14B.10` | *"Every field in the projection **MUST** be traceable to an owning context."* |
| ⭐ `LIB-14B.8` | *"A public request **MUST NOT** be able to reach an operational table by any path"* |
| ⭐ `SEAT-FR-117` *(FROZEN)* | *"This module **MAY** publish an aggregate seat capacity and **a coarse availability indicator for the public profile**, in the shape `LIB-7.3` and **`LIB-14B.12`** already define."* |

⭐ Document status: `14B-Public-Library-Preview.md` — **Approved — authoritative**,
⭐⭐ **Tier: V1**. `PRD-007` — **`FROZEN`**, Rank 3.

### 3.2 ⛔⛔ What the architecture provides — measured

| Probe | Method | Result |
|---|---|---|
| `BC-04` as **source** of any §7 edge | Programmatic parse of all **26** edge rows | ⛔⛔ **ZERO** |
| `BC-04` as **target** | same | ⭐ `E-02`, `E-05`, `E-08` |
| Edges **into `BC-23`** | same | ⭐ `E-21` *(`BC-01`, `BC-10`, `BC-19`)* · `E-26` *(`BC-27` AI, retrieval)* — ⛔ **no `BC-04`** |
| Consumers of `BC-04` events *(BC Map §9 **L418-419**)* | direct read | ⭐ `BC-26`, `BC-24`, `BC-22` — ⛔ **no `BC-23`, no `BC-19`** |

⭐ `BC-04`'s event set is **closed** — `SEAT-FR-206`: *"This module's published
domain events are **exactly** the following, fixed by BC Map §9. The set is
**closed**; adding an event requires an ADR."*

### 3.3 ⛔ The contradiction

⭐⭐ **A V1 `MUST` requires a field sourced from `BC-04` via events; `BC-04` emits
no event any public-facing context consumes, and has no outbound edge at all.**

⛔ BC Map **L292**: *"If an edge is not in this table, it **does not exist** and
adding it requires an **ADR**."*

⛔⛔ **Therefore, before this ADR, `LIB-14B.12` was unbuildable without violating
either `LIB-14B.9` *(direct store query)* or **L292** *(undeclared edge)*.**

### 3.4 ⭐ This is a known, recurring defect class

⭐ The `ADR-0016` class — *a PRD depending on an edge participant the Rank-4
register omits*. Prior instances, **each resolved by ADR, never by building
around it**:

| # | ADR | Fix |
|---|---|---|
| 1 | `ADR-0016` | `E-22` consumer += `BC-10` |
| 2 | `ADR-0055` | `E-22` consumer += `BC-12` |
| 3 | `ADR-0093` | `E-21` source += `BC-19` |
| 4 | `ADR-0095` | `E-22` consumer += `BC-19`, `BC-25` |
| ⭐⭐ **5** | ⭐ **This ADR** | ⭐ **A new edge, because `BC-04` is in NO existing edge's source cell** |

### 3.5 ⭐ The gap is registered

> ⭐⭐ **`GAP-BCMAP-BC04-PUBLIC`** — *`Library_PRD_v1.md` §14B **L92** and
> `LIB-14B.12` require public seat-availability information sourced from `BC-04`,
> and `LIB-14B.9` requires it to arrive **by event**. Measured at BC Map v1.18:
> `BC-04` is the source of **zero** edges, and no public-facing context consumes
> any `BC-04` event. **Status: CLOSED by this ADR** via `E-35`.*

⚠️ ⛔ **It was NOT previously registered** — `SEAT-GAP-001`…`014` were searched and
**none** records it. ⭐ `SEAT-GAP-014` concerns the *busy/moderate/quiet* indicator,
⛔ a different question *(§6.2)*.

---

## 4. ⭐ Why this shape

### 4.1 ⭐ Why a NEW edge rather than extending an existing one

⭐⭐ **Extension was tested FIRST and is unavailable.** `ADR-0093` and `ADR-0095`
both preferred a **one-cell source/consumer amendment** over a new edge, and that
route was checked here:

| Candidate | ⛔ Why unavailable |
|---|---|
| ⭐ Add `BC-04` to **`E-21`**'s source cell | ⚠️⚠️ **Tested — and REFUSED.** `E-21` carries *"`*Created/Updated/Deleted` → index"* — ⭐ **entity-lifecycle indexing events**. ⭐⭐ `availabilityState` is a **derived operational state**, ⛔ not a create/update/delete of an indexed entity. ⭐ Folding it in would silently widen `E-21`'s Published Language from *"index these records"* to *"index these records **and** stream live derived state" — ⛔ **a contract change disguised as a cell edit**, and it would make the privacy boundary **unstateable**, because `E-21`'s payload is *"`*Created/Updated/Deleted`"* generically and could not carry a two-field restriction |
| **`E-26`** | ⛔ Wrong producer *(`BC-27` AI)*, wrong direction *(AI **reads from** `BC-23`)*, wrong mechanism *(`CF` Sync port)* |
| **`E-08`** | ⛔ **Inbound** to `BC-04`, and ⛔⛔ it is the **attendance** edge — ⭐ the very source `LIB-14B.14` forbids |
| **`E-05`** | ⛔ Inbound `BC-06 → BC-04`; ⛔ amending it is `SEAT-GAP-005`, a **different** open question |
| **`E-27`** | ⛔⛔ **Permanently vacant** — `ADR-0033`; *"numbers are never reused"* |

⭐⭐ **A distinct edge is the honest representation**, and it is what makes `D-3`
enforceable: a dedicated edge can carry a **two-field closed payload**; a widened
`E-21` could not.

### 4.2 ⭐ Why `BC-23` as the target

| Reason | Evidence |
|---|---|
| ⭐ `BC-23` is **the** public read-composition target | BC Map **L86** — §14B *"orchestrates **public read models only**"*, composing `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02` and **`BC-04`** *through `BC-23`* |
| ⭐ §14A is already the **V1 `BC-23` discovery contract** | `Accepted` **`ADR-0094`** |
| ⭐ It satisfies `LIB-14B.8` | ⭐ A public request reaches the **index**, ⛔ never an operational table |
| ⭐ `PL` + Event matches the neighbours | `E-20`, `E-21`, `E-23` are all `PL` + Event *(BC Map **L888**)* |
| ⭐ ⛔ Search never reads domain tables | `E-21`'s own rule, preserved |

### 4.3 ⭐⭐ Why `E-35` — the identifier, measured not assumed

| Probe | Result |
|---|---|
| Every `E-nn` in the BC Map | `E-01`…`E-35` appear as **tokens** |
| ⭐ Every `E-35` occurrence repo-wide *(`docs/`, `lib/`, `test/`, `tool/`)* | ⭐⭐ **3, and NOT ONE is an allocation** — BC Map **L1421** is a **freeness probe** *("`E-35` free … **0**")*; **L1482** states ⛔ *"**`E-35` is NOT allocated**"*; `DD-0004` **L2845** states ⛔ *"no `E-35` is proposed"* |
| `E-31` | ⛔⛔ **RESERVED** for `PRD-021C`/`TSF-GAP-009`; *"absent from this file"* — ⛔ **NOT taken** |
| `E-27` | ⛔⛔ **Permanently vacant** *(`ADR-0033`)* — ⛔ **never reused** |
| `E-32`, `E-33`, `E-34` | ⭐ Allocated — `ADR-0127`, `ADR-0128`/v1.13, `ADR-0146`/v1.18 |

⭐⭐ **`E-35` is the next legitimately available identifier**, and BC Map **L1421**
states the rule this follows: ⛔ *"not needed; **numbering is sequential**"*.

⚠️⚠️ **`E-31` was NOT taken despite being numerically lower** — ⭐ it is **reserved**,
and ⛔ consuming a reserved number would pre-empt `PRD-021C`'s open question.
⭐⭐ **Sequential allocation past a reservation is the correct behaviour**, exactly
as `E-28` was allocated past the vacant `E-27`.

---

## 5. ⭐⭐ The privacy argument — the payload boundary IS the control

⭐ This adopts the **`ADR-0096` / `E-30`** method verbatim in principle: ⭐⭐ *"the
payload boundary **IS** the privacy control."*

### 5.1 ⭐ What an observer can learn from `E-35`

⭐ A complete `E-35` event says: **"library X is `Limited`."**

| Question an observer might ask | ⭐ Answerable from `E-35`? |
|---|---|
| How many people are in the library? | ⛔⛔ **NO** — no count, no percentage |
| Is a specific seat free? | ⛔⛔ **NO** — no seat identifier exists in the payload |
| Is a specific person present? | ⛔⛔ **NO** — no person identifier in any form |
| When did someone arrive or leave? | ⛔⛔ **NO** — ⭐ no attendance datum and no state-change timing |
| Is the library busy **right now**? | ⚠️ **Coarsely — and that is exactly what `LIB-14B.12` MANDATES** |

⭐⭐ **`LIB-24.2`'s stated fear is met and not engaged.** Its rationale: *"A live
seat-occupancy feed … tells an observer, in real time, roughly **how many people
are present and when a regular arrives**."* ⛔ A three-state label reveals
**neither** — ⭐ and 14B says so: *"The commercial need is **'do they have room for
me?'** — which a coarse indicator answers completely."*

### 5.2 ⭐⭐ Why the "not from attendance" limb is ARCHITECTURAL, not product

⚠️ ⭐ `BC-04`'s internal live occupancy is updated by **`E-08`** from `BC-03`
Attendance *(BC Map **L305**: "Seating updates live occupancy. **Seating is the
occupancy owner**, Attendance is the trigger")*.

⛔⛔ **So the intuitive derivation — occupancy ÷ capacity — would make the public
label an ATTENDANCE DERIVATIVE, which `LIB-14B.14` forbids in terms.**

⭐⭐ **That is a data-lineage constraint — which input crosses which boundary — and
lineage is squarely an Architecture Owner question.** ⛔ The **threshold values**
applied to the lawful input are a **product** question and are **not decided
here**. ⭐ The line between the two is the line between *"which data may flow"* and
*"what the cut-offs are."*

⭐ **Lawful input:** `SeatAllocation` state versus seat capacity — ⭐ both owned by
`BC-04` *(BC Map **L373**: aggregates `SeatAllocation` · `SeatLayout`)*.
⛔ **Unlawful input:** `BC-03` attendance, presence, check-in/out, or the
`E-08`-fed live occupancy figure.

⭐ Corroborated inside `PRD-007` itself — `SEAT-FR-041`: *"`Occupied` means
**allocated**, not physically present."* ⭐⭐ **The frozen spec already separates the
two concepts this boundary depends on.**

### 5.3 ⭐ Identity rules preserved, not weakened

⛔ **No `PersonId`, `StudentRecordId`, `AccountId`, device identifier or
fingerprint** in any form. ⭐ `ID-2`, `ID-3` and `X-05` are **preserved**, and
⛔ **no context gains an exemption** — the `ADR-0096` §17.2.1 formulation.

### 5.4 ⛔⛔ What this does NOT do to `LIB-24.2`

⛔ **The deferred privacy review is NOT performed, satisfied, narrowed, pre-empted
or declared unnecessary.** ⭐ It gates **Public Live Occupancy** *(`LIB-24.2`,
`LIB-14B.13`)*; ⭐⭐ **`E-35` carries no occupancy.** ⛔ `SEAT-GAP-014` stays
**OPEN**.

---

## 6. ⛔⛔ Alternatives and inferences REFUSED

### 6.1 Four structural alternatives

| # | Alternative | ⛔ Refused because |
|---|---|---|
| 1 | ⭐ Let 14B read `BC-04`'s store directly | ⛔⛔ **`LIB-14B.9`** — *"**MUST NOT** query another context's store directly"*; ⛔ **`LIB-14B.8`** |
| 2 | ⭐ Build the UI now and declare the edge later | ⛔⛔ **BC Map L292** — an undeclared edge *"does not exist"*. ⛔ `LIB-24.1` — no partial implementation |
| 3 | ⭐ Route via `BC-26` Analytics | ⛔ `BC-26`'s own invariant *(**L385**)*: *"no projection is a system of record"*; ⛔ and it would put a **public** read behind an **analytics** context. ⚠️ `GAP-BCMAP-BC26-EDGES` is **separately open** and ⛔ must not be leveraged |
| 4 | ⭐ Widen `E-21`'s source cell | ⛔ §4.1 — ⭐⭐ a contract change disguised as a cell edit, and it would make the two-field boundary **unstateable** |

### 6.2 ⚠️⚠️ The `SEAT-GAP-014` collision — tested, and it does NOT bar `E-35`

⭐ `SEAT-XC-020`: *"A tenant-configurable **'busy / moderate / quiet'** public
indicator is **V2**."*

| # | Distinction | Evidence |
|---|---|---|
| 1 | ⭐⭐ **Different semantics** — *busy/quiet* describes **how many people are present** *(an occupancy reading)*; *Available/Limited/Full* describes **whether capacity remains** *(a vacancy reading)* | `LIB-14B.11` puts *"live occupancy count or percentage"* in the ⛔ column and *"whether seats are **generally** available"* in the ⭐ column — ⭐ **same table, contrasted rows** |
| 2 | ⭐⭐ **`SEAT-XC-020` says "tenant-configurable"** — the V2 item is a **configurable** indicator. ⭐ `LIB-14B.12`'s is **fixed and non-configurable** | `LIB-7.4` — *"never a configuration toggle"* |
| 3 | ⭐⭐ **The same FROZEN document does both** — `SEAT-XC-020` defers the busy/quiet indicator *(**L1797**)* while **`SEAT-FR-117`** *(**L957**)* **permits the coarse availability indicator citing `LIB-14B.12`** | ⛔ A frozen document does not contradict itself across two requirements; ⭐ it is drawing a line |

⭐⭐ **`SEAT-GAP-014` is about a different indicator and is NOT closed, narrowed or
engaged by this ADR.**

### 6.3 ⛔ Five inferences refused

| # | Inference | ⛔ Refused on |
|---|---|---|
| 1 | *An edge exists ⇒ the feature may be built* | ⭐⭐ **A registered edge is not an implementation** — `ADR-0146` §24.3 verbatim |
| 2 | *Architecture fixed the input ⇒ it may fix the thresholds* | ⛔ `PRD_OWNERSHIP_MODEL` §2.2 — scope and acceptance are the **Product Owner**'s; ⛔ **the conferral excludes it in terms** |
| 3 | *`BC-04` owns occupancy ⇒ it may publish occupancy* | ⛔ `LIB-14B.11`, `LIB-14B.13`, `SEAT-XC-009`, `SEAT-FR-250` |
| 4 | *A bucketed count is not a count* | ⛔⛔ **It is.** ⭐ `D-3` forbids counts *"in any form, encoded or derived"* |
| 5 | *`E-31` is lower, so use `E-31`* | ⛔ **RESERVED** for `PRD-021C`/`TSF-GAP-009`; ⭐ sequential past a reservation, as `E-28` went past vacant `E-27` |

### 6.4 ⛔ Two temptations of scope

⛔ **Minting the event NAME.** ⭐ BC Map §9's convention is
`<Context>.<Aggregate><PastTenseVerb>` *(`SEAT-FR-207`)*, and `SEAT-FR-206` closes
`BC-04`'s event set at **four**. ⭐⭐ **Declaring the edge and its payload is within
this conferral; ⛔ minting a fifth event identifier inside a FROZEN PRD's closed
register is a heavier act** touching `PRD-007` §9 and the traceability matrix.
⭐ **Routed at §9, ⛔ not performed.**

⛔ **Executing the BC Map edit.** ⭐ Prescribed at §8; ⛔ not performed — ⭐ the
`ADR-0152-F-1` / `ADR-0154-F-1` / `ADR-0163` §4.4 pattern, where an ADR **prepares**
a downstream document act rather than silently performing it.

---

## 7. ⭐ Authority

### 7.1 Why the Architecture Owner

⭐ **BC Map L292** — *"adding an edge requires an **ADR**"*; ⭐ `PRD_OWNERSHIP_MODEL`
§2.2 gives the Architecture Owner *"boundaries, ranks or permitted edges"*; ⭐ `ADR-0132`
§7 row 7 reserves identifier-minting acts to the Architecture Owner.
⭐ Precedent: `ADR-0016`, `ADR-0055`, `ADR-0093`, `ADR-0095`, `ADR-0096`, `ADR-0127`,
`ADR-0146` — ⭐ **all edge acts, all Architecture Owner.**

### 7.2 ⛔ What this office may NOT do here

⛔ **Decide the thresholds** *(Product Owner — §2.2; ⛔ conferral excludes)* ·
⛔ **Create roles or permissions** *(⛔ conferral excludes; `AUTH-7.22` closed at zero)* ·
⛔ **Amend frozen/approved product specs** *(⛔ conferral excludes)* ·
⛔ **Perform `LIB-24.2`'s privacy review** *(Privacy Owner + Architecture — `SEAT-GAP-014`)* ·
⛔ **Mint the event name inside `PRD-007`'s closed register** *(§6.4)*.

---

## 8. ⚠️ Prescribed downstream act — ⛔ NOT executed

⭐ **Owner: Architecture Owner** *(a separate act)*. ⭐ Target:
`docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md`, currently **v1.18**.

| Field | Value |
|---|---|
| **Method** | ⭐⭐ **APPEND a new section**, ⛔ **NOT** an insertion into §7 |
| **Why append** | ⭐ Measured precedent: v1.9 recorded that inserting a row after `E-26` shifts **1,293** line-citations, *"several inside **FROZEN** Rank 3 documents"*, versus **0** for an append. ⭐ The `ADR-0079` §8.5 Option A method, reused by §15, §16, §17, §19 and §24 |
| **Content** | ⭐ The `E-35` row *(§1 `D-2`)* · the `D-3` payload boundary · the §5 privacy argument · the §3.5 gap record |
| **Header cells** | ⭐ Version → **v1.19**; ⭐ edge count updated; ⛔ **§7 byte-unchanged** |
| **Baseline** | ⛔ **No re-issue** — Rank 4; `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier *"only when a Rank 1–3 document changes version"*; ⭐ the `ADR-0016`/`0055`/`0083`/`0085`/`0146` precedent |
| ⛔ **Must NOT** | ⛔ Alter §7, §8 or §9 in place · ⛔ add a context *(**31**, 23 in V1)* · ⛔ add an aggregate or invariant · ⛔ touch `E-27`/`E-31` |

⭐ Until executed, ⭐⭐ **this ADR is the authoritative record of `E-35`** — the
`ADR-0163` §4.4 position.

---

## 9. ⭐ What must happen before any implementation

⭐⭐ **Ordered. ⛔ None is performed here.**

| # | Act | Office | Status |
|---|---|---|---|
| 1 | ⭐⭐ **Decide the `Available`/`Limited`/`Full` thresholds**, on an **allocation-vs-capacity** input | ⭐⭐ **PRODUCT OWNER** | ⛔⛔ **BLOCKING** |
| 2 | Mint the `E-35` event **name** in `BC-04`'s closed register *(`SEAT-FR-206`/`207`)* | **Architecture Owner** *(with the `PRD-007` amendment procedure)* | ⛔ Outstanding |
| 3 | Execute the BC Map append → **v1.19** | **Architecture Owner** | ⛔ Outstanding |
| 4 | Register this ADR in `ADR-INDEX` | **Governance Owner** | ⛔ Outstanding |
| 5 | Design the surface | **UX Architecture Owner** | ⛔ Outstanding |
| 6 | Implement | Technical | ⛔ Outstanding |

⛔⛔ **Implementation before step 1 would invent a product decision; before steps 2–3
it would rely on an event and an edge the registers do not yet carry.**

---

## 10. ⭐⭐ Authority record

### 10.1 ⭐⭐ The conferral — VERBATIM

> ⭐⭐ **VERBATIM CONFERRAL — human principal of this engagement, 2026-09-19:**
>
> ```
> "I confer the Architecture Owner office for the single act of resolving the V1
> public seat-availability architectural gap identified between `BC-04` and the
> public projection. Determine and, if warranted, authorize the required V1
> event/edge path using an existing valid edge/event mechanism or the next
> legitimately available identifier. Payload must be privacy-preserving:
> `{libraryId, availabilityState}` only; no occupancy count, percentage, seat ID,
> or attendance data. Record the gap, architectural decision, payload boundary,
> and V1 scope in an ADR and accept the resulting ADR. Do not modify
> frozen/approved product specs, create roles or permissions, or decide the
> Available/Limited/Full thresholds; that remains a Product Owner act. This
> one-act conferral reverts on completion. No independent review is claimed."
> ```

### 10.2 ⭐ Validity

| # | Element | Supplied? | Words relied on |
|---|---|---|---|
| 1 | First-person grant | ⭐ **YES** | *"**I confer**"* |
| 2 | Names the office | ⭐ **YES** | *"the **Architecture Owner** office"* |
| 3 | Single act | ⭐ **YES** | *"for the **single act** of resolving the V1 public seat-availability architectural gap"* |
| 4 | Decision scope | ⭐ **YES** | *"**Determine and, if warranted, authorize** the required V1 event/edge path"* |
| 5 | ⭐⭐ Identifier latitude | ⭐ **YES** | *"an existing valid edge/event mechanism **or the next legitimately available identifier**"* |
| 6 | ⭐⭐ Payload constraint | ⭐ **YES** | *"`{libraryId, availabilityState}` **only**"* |
| 7 | One-act, reverting | ⭐ **YES** | *"This **one-act** conferral **reverts on completion**"* |
| 8 | Acceptance covered | ⭐ **YES** | *"and **accept the resulting ADR**"* |
| 9 | ⭐⭐ Express prohibitions | ⭐ **YES** | *"Do not modify frozen/approved product specs, create roles or permissions, or **decide the Available/Limited/Full thresholds**"* |
| 10 | Review disclosure | ⭐ **YES** | *"**No independent review is claimed**"* |

⭐⭐ **10 / 10.** ⭐ Conferring authority: the **human principal of this engagement** —
`ADR-0080` **L7**; ⭐ `ADR-0106` — *"the **only** authority competent to fill this
office."*

⭐⭐ **Element 4's *"if warranted"* was treated as a real condition**, ⛔ not a
formality: §3 establishes the gap by measurement **before** §1 authorizes anything.
⭐ Had `BC-04` possessed an outbound path, the correct answer would have been ⛔ **no
edge**.

### 10.3 ⛔⛔ Three things this conferral is NOT

⛔ **NOT a standing licence** — `ADR-0033` §7.1.
⛔ **NOT any Authorization Owner conferral** — `ADR-0162` §2, `ADR-0164` §10.2,
`ADR-0165` §9.1, `ADR-0166` §9.1 are ⭐ **all spent and reverted**, ⛔ and ⭐ **a
different office** in any event.
⛔ **NOT a licence to decide product scope** — ⭐ the thresholds limb is excluded in
terms.

### 10.4 ⭐⭐ Reversion

⭐⭐ **Reverts on completion of this act** — the recording of this determination and
the acceptance of this ADR. ⛔⛔ **The BC Map append (§8), the event-name mint and
any further architecture act each require a NEW one-act conferral.**

---

## 11. ⭐ Sources

| # | Source | Locus | Relied on for |
|---|---|---|---|
| 1 | ⭐⭐ `14B-Public-Library-Preview.md` | **L92**, `LIB-14B.8`…`.14` | ⭐ **The V1 contract and the gap** |
| 2 | ⭐⭐ `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.18 | **L292**, §7, §9 **L418-419**, **L86**, **L373**, **L888**, **L1421**, **L1482** | ⭐ **The edge register; `BC-04` = 0 sources; `E-35` free** |
| 3 | `PRD-SEAT-MANAGEMENT.md` **FROZEN** | `SEAT-FR-117`, `SEAT-FR-041`, `SEAT-FR-206`/`207`, `SEAT-FR-250`, `SEAT-XC-009`/`020`, `SEAT-GAP-014`, §35 `C-5` | Supply side; the closed event set; the V2 line |
| 4 | `Library_PRD_v1.md` | `LIB-7.3`, `LIB-7.4`, `LIB-24.1`, `LIB-24.2` | Aggregate-only; no toggle; no partial V2 |
| 5 | ⭐ `ADR-0096` | §17.2.1 | ⭐ **"The payload boundary IS the privacy control"** |
| 6 | `ADR-0016` · `0055` · `0093` · `0095` | — | The defect class and its remedy |
| 7 | `ADR-0033` | §7.1; `E-27` withdrawal | One-act conferral; numbers never reused |
| 8 | `ADR-0127` · `ADR-0146` §24.3 | `E-32`; `E-34`, **L1482** | ⭐ Edge-mint precedent; *"a registered edge is not an implementation"* |
| 9 | `ADR-0079` §8.5 · BC Map v1.9 | — | The append method, chosen on measurement |
| 10 | `ADR-0094` | — | §14A is the V1 `BC-23` discovery contract |
| 11 | `PRD_OWNERSHIP_MODEL` | §2.2 | Architecture vs Product boundary |
| 12 | `ADR-0080` · `ADR-0106` | L7 · L7 | Conferral mechanism |

---

## 12. ⭐ Status after acceptance

| Item | State |
|---|---|
| **This ADR** | ⭐⭐ **Accepted** — 2026-09-19 |
| ⭐ **`GAP-BCMAP-BC04-PUBLIC`** | ⭐⭐ **REGISTERED and CLOSED** by `E-35` |
| ⭐ **`E-35`** | ⭐⭐ **DECLARED** — `BC-04 → BC-23`, `PL`, Event, **V1**, 2-field payload |
| **BC Map** | ⚠️ **v1.18 — NOT yet amended**; ⭐ append prescribed at §8 |
| **Event name** | ⛔ **NOT minted** |
| ⛔ **Thresholds** | ⛔⛔ **NOT decided — PRODUCT OWNER** |
| **`LIB-14B.12`** | ⭐⭐ **Now has a lawful data path** — ⛔ still not implemented |
| **Public Live Occupancy** | ⛔ **V2** — unchanged |
| **`SEAT-CFG-017`** | ⛔ **HELD** — untouched; ⭐ 9 holds, coverage **95 / 104** |
| **`SEAT-GAP-005` / `SEAT-GAP-014`** | ⛔ **OPEN** |
| **`PERM-*`** | ⛔ **0** — `AUTH-7.22` closed at zero |
| **Contexts** | ⭐ **31** *(23 in V1)* — unchanged |
| **`ADR-INDEX`** | ⛔ **Not modified** — ⭐ a Governance Owner act |
| **The conferral** | ⛔⛔ **REVERTED ON COMPLETION** |

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **1.0** | 2026-09-19 | ⭐⭐ **Created and `Accepted`. The `BC-04` public seat-availability gap is REGISTERED as `GAP-BCMAP-BC04-PUBLIC` and CLOSED by a new edge `E-35` `BC-04 Seating → BC-23 Search Indexing` (`PL`, Event, **V1**), carrying `{libraryId, availabilityState}` and NOTHING else.** ⭐⭐ **THE GAP WAS ESTABLISHED BY MEASUREMENT BEFORE ANYTHING WAS AUTHORIZED** — the conferral's *"**if warranted**"* was treated as a real condition: a programmatic parse of all **26** BC Map §7 edge rows returned ⛔⛔ **`BC-04` as SOURCE = ZERO** *(target only: `E-02`, `E-05`, `E-08`)*, and BC Map §9 **L418-419** shows `BC-04`'s **closed** event set consumed by `BC-26`/`BC-24`/`BC-22` ⛔ **with no `BC-23` and no `BC-19`** — while `14B` **L92** requires seat information sourced from `BC-04` and **`LIB-14B.9`** requires it *"built from **events**"*, ⛔ forbidding a direct store read. ⭐ Under **L292** *("if an edge is not in this table, it **does not exist**")*, ⭐⭐ **`LIB-14B.12`'s mandatory V1 indicator was UNBUILDABLE without violating one rule or the other.** ⭐ This is the **fifth** instance of the `ADR-0016` defect class, and ⭐ **the first requiring a NEW edge** — `BC-04` appears in **no** existing edge's source cell. ⭐⭐ **EXTENSION WAS TESTED FIRST AND REFUSED** *(§4.1)*: widening `E-21`'s source cell — the `ADR-0093`/`ADR-0095` one-cell route — ⛔ would convert *"`*Created/Updated/Deleted` → index"* into a live derived-state stream, ⭐⭐ **a contract change disguised as a cell edit**, and ⛔ would make the two-field boundary **unstateable**; ⛔ `E-26` *(wrong producer/direction/mechanism)*, ⛔ `E-08` *(inbound, and the **attendance** edge `LIB-14B.14` forbids)* and ⛔ `E-05` *(inbound; `SEAT-GAP-005`)* all fail. ⭐⭐ **`E-35` WAS MEASURED FREE, NOT ASSUMED** — its **3** repo-wide occurrences are ⛔ **all freeness probes or express non-allocations** *(BC Map **L1421**, **L1482** *"`E-35` is NOT allocated"*, `DD-0004` **L2845**)*; ⛔ **`E-27` stays permanently vacant** and ⛔⛔ **`E-31` was NOT taken despite being lower — it is RESERVED for `PRD-021C`/`TSF-GAP-009`**, and ⭐ sequential allocation past a reservation is the `E-28`-past-`E-27` precedent. ⭐⭐ **THE PAYLOAD BOUNDARY IS THE PRIVACY CONTROL** *(§5, the `ADR-0096` §17.2.1 method)* — ⛔ **no count, no percentage, no free-seat number, no seat/floor/zone identifier, no per-seat status or timing, no attendance datum, no `PersonId`/`StudentRecordId`/device identifier, no state-change timestamp** — ⭐ so `ID-2`, `ID-3` and `X-05` are **preserved** and ⛔ **no context gains an exemption**; ⭐⭐ **a bucketed or rounded count is still a count and is forbidden.** ⭐⭐ **THE 'NOT FROM ATTENDANCE' LIMB IS ARCHITECTURAL, NOT PRODUCT** *(§5.2)* — `BC-04`'s internal occupancy is `E-08`-fed from `BC-03`, so the intuitive *occupancy ÷ capacity* derivation ⛔ **would make the public label an attendance derivative**, which **`LIB-14B.14`** forbids; ⭐ the lawful input is **`SeatAllocation` vs capacity**, corroborated by frozen **`SEAT-FR-041`** *("`Occupied` means **allocated**, not physically present")* — ⭐ **data lineage is a boundary question; thresholds are not.** ⛔⛔ **THE `Available`/`Limited`/`Full` THRESHOLDS ARE EXPRESSLY NOT DECIDED — a PRODUCT OWNER act**, excluded by the conferral and by `PRD_OWNERSHIP_MODEL` §2.2; ⭐ they are the **blocking** step 1 of §9. ⚠️⚠️ **THE `SEAT-GAP-014` COLLISION WAS TESTED AND DOES NOT BAR `E-35`** *(§6.2)* on three measured grounds — ⭐ *busy/quiet* is an **occupancy** reading while *Available/Limited/Full* is a **vacancy** reading *(`LIB-14B.11` contrasts them in one table)*; ⭐ `SEAT-XC-020` defers a **tenant-configurable** indicator while `LIB-7.4` makes this one **non-configurable**; and ⭐⭐ **the same FROZEN document does both** — `SEAT-XC-020` **L1797** defers, `SEAT-FR-117` **L957** permits *"in the shape … **`LIB-14B.12`** already define"*. ⛔ **`SEAT-GAP-014` is NOT closed, narrowed or engaged**; ⛔ **`LIB-24.2`'s privacy review is NOT performed, satisfied or pre-empted**; ⛔ **Public Live Occupancy stays V2** *(`LIB-14B.13`, `SEAT-XC-009`/`020`, `SEAT-FR-250`, `ARCHITECTURE_RULINGS` §6)*. ⛔ **FOUR ALTERNATIVES AND FIVE INFERENCES REFUSED** *(§6)*, incl. ⛔ a direct store read *(`LIB-14B.9`)*, ⛔ building first and declaring later *(`L292`, `LIB-24.1`)*, ⛔ routing via `BC-26` *(its **L385** invariant; and ⭐ `GAP-BCMAP-BC26-EDGES` must not be leveraged)*, and ⛔ *"an edge exists ⇒ the feature may be built"* — ⭐⭐ **`ADR-0146` §24.3: *a registered edge is not an implementation***. ⛔ **THE EVENT NAME IS NOT MINTED** *(§6.4)* — `SEAT-FR-206` closes `BC-04`'s set at **four** inside a FROZEN PRD; ⭐ routed as §9 step 2. ⛔ **THE BC MAP IS NOT EDITED** — §8 prescribes a **v1.19 APPEND** *(⭐ measured: insertion after `E-26` shifts **1,293** citations vs **0** for append — the `ADR-0079` §8.5 method)*, ⛔ not executed, on the `ADR-0152-F-1`/`ADR-0154-F-1`/`ADR-0163` §4.4 pattern. ⛔ Supersedes **NOTHING** · ⛔ **0** frozen/approved specs modified · ⛔ **0** `PERM-*` *(`AUTH-7.22` closed at zero)* · ⛔ **0** roles, offices, permissions or scope classes · ⛔ **0** contexts, aggregates or invariants *(**31**, 23 in V1)* · ⛔ **0** thresholds decided · ⛔ **0** UI or runtime code · ⛔ `SEAT-CFG-017` untouched, **9** holds and **95 / 104** unchanged · ⛔ `ADR-INDEX` **not modified** · ⛔ **no commit, no push**. ⭐⭐ **The conferral has REVERTED ON COMPLETION.** |
