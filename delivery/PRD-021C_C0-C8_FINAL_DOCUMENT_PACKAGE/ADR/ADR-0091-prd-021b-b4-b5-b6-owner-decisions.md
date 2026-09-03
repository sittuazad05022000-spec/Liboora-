# ADR-0091 — `PRD-021B` B4/B5/B6 owner decisions: the ranking-composition question DETERMINED from Rank 1, the B5 wave DECIDED at V1 without editing the EA, B6's part status DISCHARGED by the registry act FOD-4 itself prescribed — and three residues disclosed rather than inferred

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Architecture Owner** for §3 and §5 (`XPB-CONF-001`, the signal/source dispositions) · **Product Owner** for §4 (`XPB-CONF-002` wave scope) · **Governance Owner** for §6 (`XPB-CONF-005` part status) — the Governance Owner role is constituted **VACANT** at `ADR-0080` **L85** and is here **filled for this act only** by **direct conferral from the human principal of this engagement**, in the same manner and with the same disclosure as `ADR-0032` §5.2, `ADR-0033` §7.2, `ADR-0036` §8.2, `ADR-0080` §5 and `ADR-0083`. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** ⛔ **No personal name is recorded** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 |
| **Supersedes** | — |
| **Amends** | ⛔ **NOTHING.** No PRD, no BC Map, no Enterprise Architecture, no Module Dependency Matrix, no `ARCHITECTURE_RULINGS.md`, no manifest, no frozen document. See §2 — the measurement that made this determination possible is precisely that **no Rank 1–5 amendment is required** |
| **Amended by** | — |
| **Baseline** | ⛔ **No baseline re-issue.** `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only when a **Rank 1–3** document changes version. **Zero documents change version.** `DOCUMENTATION_BASELINE.md` is **byte-unchanged** |
| **Closes** | `XPB-CONF-001` / `DRK-GAP-001` · `XPB-CONF-002` / `PYK-GAP-001` · `XPB-CONF-005` / `GLS-GAP-001` · `DRK-GAP-002` (determined, §5.1) · `DRK-GAP-003` (determined, §5.2) · `DRK-GAP-004` (determined, §5.2) · `PYK-GAP-004` (determined, §5.2) |
| **Does NOT close** | ⛔ **`PYK-GAP-002`** — the per-viewer suppression-state owner (§7.1). ⛔ **`PYK-GAP-003`** — the friends-of-friends traversal authorisation (§7.2). ⛔ **`GLS-GAP-002`** — the multi-library viewer scope rule (§7.3). ⛔ **`FOD-1`, `FOD-2`** — not this ADR's subjects; `ADR-0088` and `ADR-0090` remain reserved and unwritten. ⛔ **And it does NOT confer Stage 3, does NOT enter Stage 4, does NOT register traceability, does NOT create any `IMPL-*`, and does NOT make `PRD-021B` `READY`, `APPROVED` or `FROZEN`** |
| **Opens** | Nothing |
| **Related** | `MASTER_PRD.md` **L171** (module 19 — the decisive Rank 1 evidence) · `AR-1` (`ARCHITECTURE_RULINGS.md` L23–52) · `AR-3` (BC Map **L494**) · `ADR-0061` (**the precedent §4 reuses** — a higher rank outranks an EA wave tag and the EA is **not** edited) · `ADR-0058` (same *Amends: nothing* determination for the same conflict class) · `ADR-0083` (the conferral-and-execute method) · `ADR-0011` (rank 7.5; `ID-2`) · FROZEN `PRD-020` §8.3 · `PRD-021A` A3 `LCR-XC-004` · `PRD_REGISTRY.md` §13 · BC Map **L115**, **L132**, **L424**, **L488**, **L494** · `PRD_LIFECYCLE.md` §5, §7 |

> ✅ **ACCEPTED 2026-09-02.**
>
> ⭐ **Two of the three conflicts turned out NOT to need a decision at all.** They needed a
> **measurement**, and the measurement had not been taken. `XPB-CONF-001` is **determined** by
> Rank 1 `MASTER_PRD.md` **L171**, and `XPB-CONF-005` is **discharged** by the registry act that
> `FOD-4` itself prescribes. Only `XPB-CONF-002` is a genuine act of owner discretion.
>
> ⚠ **This is the `LCF-GAP-012` §3 distinction — "determined, not chosen" — applied deliberately.**
> An ADR that recorded all three as owner rulings would be **overstating its own authority** and
> would conceal that the repository had already answered two of them.

---

## 1. Context

`PRD-021B` Parts B4, B5 and B6 were authored as Stage-2 drafts at commit `8244a00` and registered
`DRAFT` / Stage 2 by `PRD_REGISTRY.md` §13. Their authoring recorded **three** conflicts between the
supplied task assumptions and measured repository evidence, each carried **OPEN** to a named owner
rather than resolved by the author:

| ID | Conflict as recorded | Routed to |
|---|---|---|
| `XPB-CONF-001` | Task asserted B4 owns *"ranking"*; FROZEN `PRD-020` §8.3 step [4], B0 §2 row 8 and B3 `SDS-XC-007` assign ranking to **`BC-23`** | ARB |
| `XPB-CONF-002` | Task asserted B5 is **V1**; EA **L930**/**L943**, B3 `SDS-BR-017`/`SDS-XC-006` and B0 §2 row 9 place it at **V2/V3** | Architecture Owner + Product Owner |
| `XPB-CONF-005` | **B6 is a part identifier the repository had not named**; `grep -rl "Part B6" docs/` → **0 files**; B0 `FOD-4` names B4, B5, B7, B8, B9 — ⛔ not B6 | Governance Owner |

This ADR disposes of all three, plus four gaps that prove **determinable on measurement**.

---

## 2. ⭐ The method question, decided by measurement before any ruling

`DOCUMENTATION_BASELINE.md` §7 rule 1 requires an ADR **before** any Rank 1–5 document changes.
The first question is therefore not *what to decide* but **whether any Rank 1–5 change is needed at
all** — because if one is, the decision has a much higher bar and a much larger blast radius.

**Measured, before any text was written:**

| Probe | Command class | Result |
|---|---|---|
| Does a V1 read-composition-over-`BC-23` shape already exist at Rank 1? | read `MASTER_PRD.md` L168–180 | ✅ **YES** — module 19 |
| Is `BC-11` V1 or V2 at Rank 4? | read BC Map L115 | ✅ **V1** |
| What rank is the Enterprise Architecture? | read `DOCUMENTATION_BASELINE.md` | ⚠ **Rank 6** — stated twice, explicitly |
| Is there a precedent for a higher rank outranking an EA wave tag **without editing the EA**? | read `ADR-0061` | ✅ **YES** — *"Amends: **Nothing** … and **not** the Enterprise Architecture"* |
| Does `FOD-4` prescribe its own remedy? | read B0 §8 `FOD-4` | ✅ **YES** — *"a registry §11-style allocation act"* |

⭐ **Consequence: this ADR amends NOTHING.** Every disposition below is reachable without touching a
single Rank 1–5 artefact. Four alternatives were available and are **rejected in §8**, including the
two that a less careful pass would have taken: editing the EA's capability tree, and minting a new
bounded context for discovery ranking.

---

## 3. `XPB-CONF-001` — **DETERMINED** from Rank 1. B4's ordering layer is a lawful read composition

### 3.1 The decisive evidence, which the draft did not reach

**Rank 1** `MASTER_PRD.md` **L171**:

> `| 19 | Library Discovery & Enrollment | Composition over BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, projected via BC-23 | *not a context* | V1 |`

and **L175–180**, the `AR-1` addition:

> *"Library Discovery & Enrollment is registered as an **application / read composition capability**…
> Per `AR-1` it owns **no aggregate, no invariant and no business state**; it orchestrates public read
> models and delegates every domain operation to the owning module… It is **not** a bounded context,
> so §5.1's V1 scope of 23 bounded contexts is unchanged."*

⭐ **This is the exact shape B4 claims for itself, already registered at Rank 1, already at V1, and
already explicitly "projected via `BC-23`" without owning `BC-23`.**

### 3.2 The determination

| Question | Answer | Authority |
|---|---|---|
| May a V1 read composition order results projected via `BC-23` without owning `BC-23`? | ✅ **YES** | **Rank 1** `MASTER_PRD.md` **L171** + `AR-1`; pattern corroborated by `PRD-021A` A3 `LCR-XC-004` and `AR-3` |
| Does B4 thereby acquire `BC-23`'s relevance ranking? | ⛔ **NO** | `BC-23` retains *"relevance, query rewriting"* (BC Map **L132**) and step **[4]** of FROZEN `PRD-020` §8.3 **unchanged** |
| Is a new bounded context required? | ⛔ **NO** | `AR-1`: a read composition *"owns no aggregate · owns no invariant · owns no business state"*. BC count remains **31** |
| Is a new integration edge required? | ⛔ **NO** | B4 consumes B3's published read contract `SDS-FR-017`; the `AR-1` no-edge-of-its-own principle is already settled for B0–B3 by `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` §2.1 |

**Ruling.** `DISC-RANK-1` is confirmed as a **post-retrieval ordering layer inside a read
composition**, lawful at V1, owning no aggregate, no invariant, no business state and no index.
⛔ **`BC-23`'s ownership of relevance is neither transferred nor diluted.**

### 3.3 ⚠ The consequence for `DRK-BR-001` and `DRK-XC-004` — a constraint is LIFTED, and one is KEPT

`DRK-BR-001` and `DRK-XC-004` were written defensively: while `XPB-CONF-001` was open, B4 was
forbidden from re-ordering **across relevance bands**.

| Rule | Disposition | Reason |
|---|---|---|
| `DRK-BR-001` (order only within BC-23's sequence) | ⚠ **RELAXED** on **query surfaces only** → see the constraint below | The Rank 1 shape authorises composition-level ordering |
| `DRK-XC-004` (⛔ no cross-band re-ordering) | ✅ **RETAINED AS BINDING for query surfaces** | ⭐ On a **text query**, relevance is the user's expressed intent. Re-ordering across relevance bands would make a search box stop answering the query — a **product defect**, not merely a boundary question |
| Non-query surfaces (browse, recommendation lists) | ✅ **Full `DISC-RANK-1` ordering authorised** | No user-expressed text intent exists to override |

⚠ **This is narrower than the task assumption.** The task said *"B4 owns ranking/scoring"*
unqualified. The determination authorises ordering **as a composition**, and keeps `BC-23` primary
**where a query exists**. ⛔ **The difference is recorded, not smoothed.**

---

## 4. `XPB-CONF-002` — a genuine **DECISION**: B5 is **V1-eligible**, and the EA is **NOT edited**

### 4.1 Why this one is a decision and not a determination

Unlike §3, no Rank 1 line settles this. The measured positions:

| Source | Rank | Says |
|---|---|---|
| `MASTER_PRD.md` `MP-SCOPE-01`…`09` (L89–97) | **1** | ⚠ **SILENT on student recommendations.** Recommendation appears at **L429** only in the *AI capabilities* narrative — not a wave rule |
| BC Map **L115** `BC-11` | **4** | **V1** — *"Owns relationships: friend requests, friendships, blocks, rate limits"* |
| EA **L930** `Recommended Students` | **6** | **V2** |
| EA **L943** `Friend Suggestions` | **6** | **V3** |
| B3 `SDS-BR-017`, `SDS-XC-006`; B0 §2 row 9 | unranked | V2/V3, *"not specified"* |

⭐ **The measurement that changes the picture: the Enterprise Architecture is Rank 6**, stated
explicitly twice in `DOCUMENTATION_BASELINE.md`, and that document's own EA row states the governing
rule — the EA is **"Descriptive — must follow the PRDs, never lead them."**

⚠ **The B4/B5/B6 drafts described the EA as "Rank 4". That was WRONG, and it is corrected here
rather than quietly carried.** The drafts' `XPB-CONF-002` reasoning — *"the EA is Rank 4 and
unanimous"* — therefore rested on a **misstated rank**. The conflict is real; its **weight** was
overstated.

### 4.2 The controlling precedent — `ADR-0061`

`ADR-0061` decided this exact class: a higher-ranked authority prevails over an EA wave tag, and
the EA is **not** edited, because *"the two describe different objects"*. Its `Amends` cell reads
**"Nothing … and not the Enterprise Architecture"**, and `ADR-0058` records the identical
determination for the identical class.

### 4.3 The decision

**Product Owner ruling** (`PRD_OWNERSHIP_MODEL.md` §2.2 — *"Whether a requirement is correct and
**in scope**"*), with **Architecture Owner** concurrence on precedence:

> **`PYK-SRC-001`-sourced student recommendations — same-library members, library-first, no
> traversal — are IN SCOPE at V1.** ⛔ **Every other candidate source remains at its measured wave.**

| Capability | Wave after this ADR | Basis |
|---|---|---|
| Recommendations from **same-library membership** (`PYK-SRC-001`) | ✅ **V1** | This decision. `BC-11` is V1 (BC Map L115, Rank 4); `E-02` and `MM-BR-006` pre-exist |
| **Friends-of-friends traversal** (`PYK-SRC-002`) | ⛔ **NOT V1** | `PYK-GAP-003` remains **OPEN** (§7.2). EA **L940** `Mutual Friends (V2)` untouched |
| **Common Interests** (`PYK-SRC-004`) | ⛔ **V2** | EA **L931**. Unchanged |
| **Nearby** (`PYK-SRC-006`) | ⛔ **V2** | EA **L929**. Unchanged |
| **Smart Matching / AI Discovery** | ⛔ **V3 / Future** | EA **L932**/**L933**. Unchanged |
| **`Friend Suggestions`** as EA L943 names it | ⛔ **V3** | ⚠ Explicitly **NOT** promoted — see §4.4 |

### 4.4 ⚠ What this decision deliberately does NOT do

1. ⛔ **It does not edit the EA.** L926–L943 are **byte-unchanged**. Per `ADR-0061`, precedence is
   decided; the descriptive document is left to be reconciled by its own owner.
2. ⛔ **It does not promote EA L930 `Recommended Students` wholesale.** Only the
   **`PYK-SRC-001`-sourced, library-first** subset is admitted. A reader must not infer that
   *"Recommended Students"* as the EA scopes it is now V1.
3. ⛔ **It does not promote EA L943 `Friend Suggestions` (V3).** Graph-derived suggestion remains V3
   and is additionally blocked by `PYK-GAP-003`.
4. ⚠ **It creates a disclosed drift**: EA L930 reads `(V2)` while a V1 subset now exists. This is
   the **`Q-A6` shape** — a Rank 6 document made stale by a higher-ranked act, where editing it is
   a separate owner act. **Routed, not repaired**, and recorded as **`XPB-DRIFT-001`** below.

### 4.5 The consequence for `PYK-CFG-001` and `PYK-XC-004`

| Rule | Before | After |
|---|---|---|
| `PYK-CFG-001 capability.recommendationsEnabled` | default **FALSE** (V2-gated) | ⚠ **Default remains FALSE** — see below |
| `PYK-XC-004` (⛔ impossible to enable while CONF-002 open) | binding | ✅ **DISCHARGED** — the conflict is closed |

⭐ **The default is deliberately left FALSE even though the wave block is lifted.** Two independent
reasons, both measured: `PYK-GAP-002` (per-viewer suppression state) is **still OPEN**, and
`PYK-SRC-002` is **still unauthorised**. A capability whose dismissal cannot persist and whose
second source is unauthorised should not default on. ⛔ **This is not a residual wave gate** — it is
an ordinary readiness default, and `PYK-XC-004`'s prohibition is gone.

---

## 5. Signal and source gaps — four **DETERMINED** on measurement

### 5.1 `DRK-GAP-002` — account-freshness signal ⛔ **REFUSED, and the refusal is now final**

BC Map **L424** measured verbatim:

> `| BC-10 | identity.PersonIdentityCreated | BC-23, BC-24, BC-26 | Identity created atomically with the account (SEV-1) |`

**`BC-11` is absent from the consumer cell.** Consuming that event from `BC-11` would assert an edge
BC Map **L292** says *"does not exist"*.

**Ruling: `DRK-SIG-005` is WITHDRAWN, not deferred.** ⛔ No edge is created. ⚠ Note the lawful
alternative the draft did not need: `BC-23` **is** a consumer, so if freshness is ever wanted it must
arrive **through `BC-23`'s projection via `E-21`**, never by a new `BC-10 → BC-11` edge. `DRK-GAP-002`
is **CLOSED** as determined.

### 5.2 `DRK-GAP-003`, `DRK-GAP-004`, `PYK-GAP-004` — ⛔ **REFUSED, final**

| Gap | Signal/source | Determination |
|---|---|---|
| `DRK-GAP-003` | co-presence / attendance (`BC-03`/`BC-04` → `BC-11`) | ⛔ **REFUSED, FINAL.** **0** edges measured, and `X-05` *Separate Ways* is preserved unamended by `ADR-0011`. Creating this edge would re-create the exact shape rank 7.5 was introduced to remove |
| `DRK-GAP-004` | behavioural / impression signals | ⛔ **REFUSED, FINAL for V1.** **0** impression store measured; `PRD-021A` A3 `D-3` already defers impression tracking. ⚠ A future store is a **`BC-26` Analytics** question, ⛔ not a `BC-11` one |
| `PYK-GAP-004` | same-study-hall source | ⛔ **REFUSED, FINAL.** Identical grounds to `DRK-GAP-003` |

⭐ **All four are closed as REFUSALS, and none is closed by inventing a source.** The
`DRK-SIG-003` weight-`0.00` disclosure (a mathematically constant V1 signal, carried at zero on the
A3 `LCR-RS-009` precedent) is **confirmed correct** and left exactly as drafted.

---

## 6. `XPB-CONF-005` — **DISCHARGED** by the act `FOD-4` itself prescribes

`FOD-4`, measured verbatim from B0 §8:

| Field | Value as written |
|---|---|
| **Required owner** | **Governance Owner** |
| **Exact smallest action** | *"None required for `PRD-021B`. If such parts are wanted, **a registry §11-style allocation act**"* |
| **Blocks B1/B2/B3 authoring?** | ⛔ No |
| **Blocks later implementation?** | ⛔ No |

⭐ **`PRD_REGISTRY.md` §13 IS that act**, performed 2026-09-02: a §11/§12-style append registering
B4, B5, B6 as `DRAFT` / Stage 2 at `BC-11`, with 128 lines added, **0 deleted**, and the first 1003
lines byte-identical so **0** existing citations shifted.

**Governance Owner ruling:** B4, B5 and B6 are **recognised parts of `PRD-021B`**. `XPB-CONF-005`
and `GLS-GAP-001` are **CLOSED**.

⚠ **Two disclosures kept rather than dropped:**

1. ⛔ **`FOD-4` is NOT edited.** Its text enumerates B4/B5/B7/B8/B9 and does not name B6. Amending it
   would modify a **Stage-3-PASS and Stage-4-PASS subject** (B0), which this ADR does not do. `FOD-4`
   is **discharged, not rewritten** — the `SECP-FR-018` / `FIL-GAP-012` precedent exactly: *closed in
   fact, row not editable without amendment authority.* An implementer **must read this ADR beside
   B0 §8**.
2. ⚠ **`FOD-4` remains OPEN for B7, B8, B9.** This ADR discharges it **only** for B4/B5/B6. No part
   beyond B6 is authorised by anything.

---

## 7. ⛔ Three items NOT closed — each with a reason and a named owner

### 7.1 `PYK-GAP-002` — per-viewer suppression state ⛔ **OPEN · ARB**

B5 needs durable per-viewer dismissal state, but `AR-1` says a read composition *"owns no business
state"*. Three options are recorded in B5 and **none is chosen here**: (a) `BC-11` holds
`RecommendationSuppression`; (b) `BC-25` per-user config; (c) session-only, non-durable.

⛔ **Not decidable by measurement.** Option (a) is a **Rank 4** BC Map §8 register append — the same
class as `FOD-2`/`ADR-0090`, which is *still* unwritten. Deciding it here would resolve by side
effect a question `ADR-0090` was reserved for. `PYK-XC-011` (⛔ MUST NOT claim durable dismissal)
**stays binding**.

### 7.2 `PYK-GAP-003` — friends-of-friends traversal ⛔ **OPEN · ARB**

B1 `SGR-FR-025` authorises a mutual-connection **count for an already-identified pair**. A
**traversal that produces new candidates** is a different operation over the same data, and no
measured line authorises it. ⛔ **Not closed** — and consequently `PYK-SRC-002` stays unauthorised
and B5's V1 capability rests on **one** source (§4.3).

### 7.3 `GLS-GAP-002` — multi-library viewer scope ⛔ **OPEN · Product Owner + ARB**

A person holding valid membership in **two** libraries has no specified `LIBRARY` scope resolution.
`GLS-EC-002` requires **fail-closed** and forbids both union and arbitrary choice. ⛔ Choosing
between *union*, *active-library selection* and *per-request explicit membership* is a product
decision with a privacy consequence (union leaks library A's membership into library B's surface),
and **no line measures it**. Fail-closed **stays binding**.

### 7.4 `XPB-DRIFT-001` — EA L930 made stale by §4 ⚠ **DISCLOSED · Architecture Owner**

EA **L930** reads `Recommended Students (V2)` while §4 admits a V1 subset. ⛔ **Not repaired**: the
EA is Rank 6 and **descriptive**, `ADR-0061` established that such a tag is **not edited** when
precedence is decided, and `ADR-0075` measured that inserting nodes into the EA capability tree
invalidates **240** line-citations across **39** files, three of them **FROZEN**. **Routed.**

---

## 8. Options considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | Mint a new bounded context for discovery ranking (`BC-32`) | ⛔ Contradicts Rank 1 `MASTER_PRD.md` **L182**; a ranking layer owns **0 aggregates and 0 invariants** so it fails the BC Map's own admission test; and `BC-32` has been refused **twice** already (`ADR-0035` §5.2.5, `ADR-0060`). **31 contexts before and after** |
| 2 | Edit the EA capability tree to move `Recommended Students` to V1 | ⛔ `ADR-0075` measured **240** invalidated citations across **39** files, 3 FROZEN. `ADR-0061`/`ADR-0058` establish the EA is **not** edited for a precedence decision |
| 3 | Transfer relevance ranking from `BC-23` to B4 | ⛔ Would amend **FROZEN** `PRD-020` §8.3 step [4] and Rank 4 BC Map **L132**. §3 shows no such transfer is needed |
| 4 | Create a `BC-03`/`BC-04` → `BC-11` edge for co-presence | ⛔ Breaches `X-05`, preserved unamended by `ADR-0011`; re-creates the shape rank 7.5 removed |
| 5 | Decide `PYK-GAP-002` by putting suppression in `BC-11` | ⛔ Rank 4 §8 register append; collides with `ADR-0090`'s reserved subject. §7.1 |
| 6 | Declare B5 fully V1 as the task assumed | ⛔ Would promote unauthorised sources (`PYK-SRC-002`) and EA L943 (V3) by side effect. §4.4 |
| 7 | Refuse all three conflicts as undecidable | ⛔ **Would be wrong.** Two are answerable by measurement (§3, §6); refusing them would repeat the error the drafts made in not reaching `MASTER_PRD.md` **L171** |

---

## 9. Verification

| Claim | Method | Result |
|---|---|---|
| `MASTER_PRD.md` L171 registers module 19 as V1 read composition via `BC-23` | direct read | ✅ confirmed verbatim |
| `BC-11` is V1 | BC Map L115 | ✅ confirmed |
| The EA is Rank 6 | `DOCUMENTATION_BASELINE.md` | ✅ **2** explicit statements |
| `BC-11` absent from `PersonIdentityCreated` consumers | BC Map L424 | ✅ confirmed — `BC-23, BC-24, BC-26` only |
| `FOD-4` prescribes a registry allocation act | B0 §8 | ✅ confirmed verbatim |
| `PRD_REGISTRY.md` §13 performed that act | git diff | ✅ 128 added / **0** deleted; L1–1003 byte-identical |
| `ADR-0091` was free | `grep -rl ADR-0091 docs/` | ✅ **0** files |
| `ADR-0088`/`ADR-0090` remain reserved and unwritten | `ls docs/00-governance/adr/` | ✅ **0** matches; ⛔ untouched |
| No Rank 1–5 document changes | `git diff --stat` | ✅ **0** |
| BC count | BC Map | ✅ **31** — unchanged |
| Edges created | count | ✅ **0** |
| Events minted | count | ✅ **0** — `BC-11` closed at 2 (L430) |
| `IMPL-*` allocated | count | ✅ **0** |

---

## 10. ⛔ What this ADR does not do

1. ⛔ **Confers no lifecycle stage.** Stage 3's gate is a **written alignment record**; this is an ADR,
   not that record. `PRD-021B_B4_B5_B6_STAGE3_ARCHITECTURE_ALIGNMENT.md` is the gate artefact.
2. ⛔ **Enters no Stage 4, registers no traceability (Stage 5), creates no `IMPL-*`.**
3. ⛔ **Freezes nothing. Approves nothing. Makes nothing `READY`.**
4. ⛔ **Amends no Rank 1–5 document, no frozen PRD, and not the Enterprise Architecture.**
5. ⛔ **Creates no bounded context, no edge, no event, no aggregate, no permission, no storage model.**
6. ⛔ **Edits no `PRD-021B` B0–B3 file.** All four remain byte-identical.
7. ⛔ **Reopens neither `PRD-021A` nor `PRD-020`.**
8. ⛔ **Touches no file under `lib/`, `test/`, `tool/`, `web/`, `android/` or `.github/` — 0 lines.**
