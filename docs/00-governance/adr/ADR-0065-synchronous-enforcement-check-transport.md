# ADR-0065 — How `BC-12` Messaging performs the synchronous enforcement-state check against `BC-13`, and this ADR does not decide it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-22 |
| **Deciders** | **Architecture Owner (ARB)** — `PRD_OWNERSHIP_MODEL.md` §2.2/§2.3 (**L85**, **L102**), the role **L68**/**L69** name as the only approver of a structural change or a Rank 1–5 document change. ⚠ Amendment site 3 (§4.3) additionally touches a **machine-enforced manifest**; whether that is the same act or a separate Technical Owner act is itself an open question — see §6 item 4 |
| **Supersedes** | Nothing |
| **Amends** | **Nothing. No document is modified by this ADR.** An amendment is what a decision would authorise; none is made here. The three sites a future decision *would* have to amend are enumerated in §4 and left untouched |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** Nothing changes version. Were the decision taken, `DOCUMENTATION_BASELINE.md` §7 step 4 would still exempt it — all three sites are **Rank 4**, and the baseline identifier moves *"only when a Rank 1–3 document changes version"* (the `ADR-0016`/`ADR-0055` exemption precedent) |
| **Closes** | **Nothing.** `TSF-GAP-003` stays **OPEN**; `IMPL-1410` stays **BLOCKED** |
| **Does NOT close** | `TSF-GAP-003`, `IMPL-1410`, `D-16`, `MP-RSK-02`, or any `TSF-AC-*`. **This ADR frames a decision; it authorises no edge and verifies no code** |
| **Related** | **`ADR-0022`** (the exact `Proposed`-frames-but-does-not-decide precedent) · `ADR-0055` §3 (the per-context necessity method this decision must follow) · `ADR-0059` (why an unlisted caller is refused *by code*) · `ADR-0011` (created the Social-cluster shape) · `ADR-0012` (module boundary authority) · BC Map **L292** (the governing rule), **L318** (`E-14`), **L468** (the requirement), **L286** · Matrix **L90**, **L254**, **L354** (`X-05`) · `tool/module_dependencies.yaml` **L255**–**L259** · `MASTER_PRD.md` **L552** (`MP-RSK-02`, **Critical**) · `PRD-020` `TSF-FR-001`, `TSF-GAP-003`, `TSF-RSK-002`, §10.1, §29 · `PRD_DEPENDENCY_GRAPH.md` **D-16** · `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161**/**L164** |

> ⚠️ **`Proposed`. This ADR frames a decision it is not authorised to make.**
>
> It exists because three repository rules independently require one *before* anything changes:
>
> * `ADR-INDEX.md` Process step 1 — *"A decision that changes structure, ownership, **a boundary**, or a
>   platform-wide rule requires an ADR **before** implementation."*
> * `DOCUMENTATION_BASELINE.md` §7 step 1 — *"A change to any **Rank 1–5** document requires an ADR **before**
>   the change."*
> * Bounded Context Map **L292** — *"If an edge is not in this table, it **does not exist** and adding it
>   requires an ADR."*
>
> **No transport is chosen here.** Two candidate options are described in §3 with their measured consequences.
> Selecting one is the Architecture Owner's act.

---

## 1. Context — a Rank 1 mitigation and a Rank 4 register that disagree today

### 1.1 What Rank 1 requires

`MASTER_PRD.md` **L552** records the platform's only **Critical** product risk:

> `MP-RSK-02` | Minor-safety incident on the social product. | **Critical** | `BC-13` Trust & Safety at V1;
> guardian consent gate; **synchronous enforcement check at message send**.

Three mitigations, of which the third is a *mechanism* claim. BC Map §10 **L468** states the same requirement
from the architecture side, and states *why* eventual consistency is refused there:

> *"Ban a user | BC-13, then BC-10/11/12/14/15 | **Eventual** | `EnforcementActionTaken` fan-out.
> **Messaging must additionally check enforcement state at send time** — eventual consistency is
> unacceptable for abuse containment, so this path is belt-and-braces."*

### 1.2 What Rank 4 actually publishes

`BC-13` appears in the BC Map's edge register (§7.1, §7.2, §7.3) in **exactly one row**:

| # | Upstream | Downstream | Pattern | Mechanism | Direction |
|---|---|---|---|---|---|
| **`E-14`** (**L318**) | **`BC-13`** Trust & Safety | `BC-11`, `BC-12`, `BC-14`, `BC-15` | `PL` | **Event** | **Outbound from `BC-13`** |

There is **no `BC-12 → BC-13` edge**, in any pattern, in any mechanism, anywhere in the register. Under **L292**
that edge **does not exist**.

### 1.3 The defect, stated precisely

**A Rank 1 mitigation and a Rank 4 requirement both mandate a synchronous check across a boundary the Rank 4
edge register does not carry.** This is the same defect *class* as `ADR-0016` and `ADR-0055` — a requirement
resting on an edge or consumer cell the map does not list — with one difference that makes it **harder**, not
easier:

> `ADR-0016` and `ADR-0055` each widened **one cell** of an **existing** edge (`E-22`'s consumer list).
> This would create a **new edge in a closed cluster allow-list**, or avoid needing one. It is a larger act,
> and §4 enumerates every site it touches so that the size is visible before it is authorised.

⚠ **This ADR does not assert that a new edge is the answer.** §3 Option B satisfies **L468** with **no new
edge at all**. Which is why this is `Proposed`: the framing must not smuggle in the outcome.

---

## 2. Why this cannot be deferred, and equally cannot be assumed

| Force | Record |
|---|---|
| `MP-RSK-02` is **Critical** and names this mechanism | `MASTER_PRD.md` **L552** (Rank 1) |
| `D-16` `PRD-021` → `PRD-020` is **"Unsatisfied — `MP-RSK-02` is Critical"** | `PRD_DEPENDENCY_GRAPH.md` **L118** |
| *"If `PRD-021` slips ahead of `PRD-020`, that is a **release-blocking defect**, not a schedule change"* | `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L164** |
| `PRD-020` `TSF-FR-142` holds that this ADR **must** be decided before `PRD-020` leaves `DRAFT` | `PRD-020` §29 |
| ⛔ But an unranked `DRAFT` PRD **may not** amend Rank 4 | `PRD-020` `TSF-XC-063`; Ownership **L69** |

So the decision is **required** and **not available to the requester**. `Proposed` is the only lifecycle-correct
state this record can hold today.

---

## 3. The two options, and what each costs

Both satisfy **L468**. They differ in which architectural principle they spend.

### 3.1 Option A — a synchronous `BC-12 → BC-13` check

A new edge: `BC-12` Messaging (downstream) asks `BC-13` Trust & Safety (upstream) *"is this actor restricted
right now?"* on the send path. Pattern would plausibly be `C/S` + sync port, by direct analogy with **`E-16`**
(**L320**), which is the *existing* precedent for exactly this shape inside this cluster:

> `E-16` | BC-11 Social Graph | BC-12 Messaging | `C/S` | Sync port | `canMessage(a, b)` — **Messaging must ask**

| For | Against |
|---|---|
| Literally implements **L468**'s *"check enforcement state at send time"* | **Creates a 4th internal edge in a closed 3-edge allow-list** (Matrix **L90**, **L254**) |
| Exact `E-16` precedent already exists in the same cluster, same direction | Puts `BC-13` on the **synchronous critical path of every message send** — `TSF-FR-001` demands **50 ms p99, fail-closed** |
| No projection to build, no staleness window to reason about | An outage in the safety context becomes an outage in messaging (fail-closed is *correct* but *costly*) |
| Strongest possible reading of a **Critical** Rank 1 mitigation | Inverts `E-14`'s direction of travel — BC Map **L286**: *"T&S never reaches into their models"* is preserved, but the converse traffic is new |

### 3.2 Option B — an event-fed projected enforcement state inside `BC-12`

`BC-12` maintains its own local read model of enforcement state, fed by the **existing** `E-14`
`safety.EnforcementActionTaken` event (**L318**, **L433** — `BC-12` is *already* a listed consumer). The
send-path check is then a **local** point read inside `BC-12`.

| For | Against |
|---|---|
| ⭐ **Requires no new edge.** `E-14` already exists and already lists `BC-12` | The check is synchronous *locally* but the **state** is eventually consistent — a race window exists between decision and projection |
| Amendment sites 1 and 2 (§4.1, §4.2) may be **unnecessary** — see §6 item 1 | Does **L468**'s *"check enforcement state at send time"* mean a fresh cross-context read, or a local check of projected state? **This ADR does not interpret L468** |
| Trivially satisfies `TSF-FR-001`'s 50 ms p99 — it is a local read | Duplicates enforcement state into a second context; `BC-12` must be trusted to apply it |
| Reuses the projection discipline BC Map **L383** already imposes on `BC-21` (*"never hand-edited; recomputable from events"*) | Requires a bounded, **stated** staleness budget, which is itself a decision |

### 3.3 What this ADR refuses to do

| Tempting move | Refused because |
|---|---|
| Pick Option B because it is cheaper and needs no Rank 4 amendment | Cost is not authority. Whether a *projected* check satisfies **L468** is an **interpretation of a Rank 4 requirement**, which belongs to the Architecture Owner |
| Pick Option A because it is the literal reading of **L468** | It creates a 4th edge in a **closed** allow-list and puts a `[CORE]` safety context on the hot path of every send. That is a boundary act, not a wording preference |
| Declare the two options equivalent and let implementation choose | They are **not** equivalent — one amends three Rank 4 sites, the other amends none. Deferring to implementation is how unlisted edges enter a codebase |
| Widen the Social cluster allow-list to *"any intra-cluster edge"* | Matrix **L86** requires an *"explicit allow-list, not 'anything within the cluster'"*. Dissolving the list to admit one edge destroys the instrument |
| Fold this into `ADR-0066`/`ADR-0067` as one "PRD-020 architecture" ADR | `ADR-0033` **L169**: *"a conferral for one act is not a standing licence."* Three questions, three records |

---

## 4. The blast radius — three amendment sites, enumerated and untouched

⚠ **This is the section `PRD-020` §29 under-specified.** §29 named the BC Map only. Measurement returns **three**
sites, and the third is **machine-enforced**, so a decision that amended only the first would be caught by a
checker rather than by review.

**Under Option A, all three would require amendment. Under Option B, potentially none** (see §6 item 1).

### 4.1 Site 1 — `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` (Rank 4)

| | |
|---|---|
| **What** | §7 edge register — a **new row** in §7.1/§7.2 for `BC-12 → BC-13` |
| **Why** | **L292**: *"If an edge is not in this table, it does not exist and adding it requires an ADR"* |
| **Scope if amended** | One new row. **No existing row modified**, no context reclassified, no aggregate moved, no invariant altered, no tenancy mode touched |
| **Precedent for scope discipline** | `ADR-0055` §7 (one cell), `ADR-0016` (one cell) |

### 4.2 Site 2 — `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` (Rank 4)

| | |
|---|---|
| **What** | **L90** — the Social cluster row: *"Only edges **E-14…E-16**"* |
| **Why** | **L86** requires the list be *"an explicit allow-list, not 'anything within the cluster'"*. A 4th edge is outside the list and therefore forbidden **independently** of the BC Map |
| **Also** | **L254** carries the same list a second time in the same file, as `internal_edges_allowed: [ E-14, E-15, E-16 ]`. **Both occurrences would need amending** — amending one leaves the file self-contradictory |

⚠ **This site is a second, independent Rank 4 authority.** Amending the BC Map alone would produce an edge that
the BC Map permits and the Matrix forbids.

### 4.3 Site 3 — `tool/module_dependencies.yaml` (machine-enforced)

| | |
|---|---|
| **What** | **L255**–**L259**, the `internal_edges` list for `domain/social`: `E-14` (`safety → [graph, messaging]`, `mode: event`), `E-15`, `E-16` |
| **Why** | This is the **executable** form of the allow-list, checked by `tool/check_module_boundaries.dart` (`ADR-0012`). A new edge absent here fails the checker even with both documents amended |
| **Note** | ⚠ `E-14`'s row records `from: safety, to: [graph, messaging], mode: event`. Option A's edge runs **the other way** and is **not** `mode: event`. It is a genuinely new entry, not a widening of `E-14` |

### 4.4 What is *not* a site — and why the instruction's third name was corrected

The task named `TRACEABILITY_MATRIX.md` as the third artefact. **Measurement does not support that**, and this
ADR records the correction rather than complying with it:

| Checked | Result |
|---|---|
| `grep -n 'E-22\|E-16\|edge' docs/40-implementation/TRACEABILITY_MATRIX.md` | Returns **identifier-coverage and gap-ledger commentary only**. The file holds **no edge register** |
| `grep -c 'TSF-' docs/40-implementation/TRACEABILITY_MATRIX.md` | **0** — `PRD-020`'s identifiers are not registered there yet |

`TRACEABILITY_MATRIX.md` is a **downstream consequence**, not an amendment site: it would need a `TSF-*`
identifier-inventory section (the **§2M** precedent set for `FIL-*` at its **v1.17**) *whenever* `PRD-020`
advances — independently of this decision, and by the **Traceability Owner** (`PRD_LIFECYCLE.md` §6), not the
Architecture Owner. Recording it as an amendment site would have misattributed the act.

The third real site is `tool/module_dependencies.yaml` (§4.3) — and it matters more, because it is the one that
**fails a build** rather than a review.

---

## 5. What a decision must satisfy — constraints that hold under either option

These are **not** decisions; each is an existing rule a resolution may not breach.

| # | Constraint | Authority |
|---|---|---|
| C-1 | `BC-13` **MUST NOT** receive or store `StudentRecordId` or `TenantId` | `ID-2`/`ID-3`; manifest `banned_symbols` **L265**–**L267**; `PRD-020` `TSF-INV-017` |
| C-2 | T&S **MUST NOT** write into `BC-11`/`BC-12` models | BC Map **L286**; `PRD-020` `TSF-XC-037` |
| C-3 | Block enforcement and rate limits stay with `BC-11` | **`E-16`** **L320**; `PRD-020` `TSF-XC-004`…`006` |
| C-4 | The check **MUST fail closed** — an unavailable check denies the send | `PRD-020` `TSF-FR-001` |
| C-5 | 50 ms p99 budget, and answerable at 10,000 open cases | `PRD-020` `TSF-FR-001`, `TSF-FR-004` |
| C-6 | Library ↔ Social **Separate Ways** is untouched; the only bridge stays `E-13` via ACL | Matrix **L92**, **L354** (`X-05`) |
| C-7 | Necessity is tested **per context**, not granted to `domain/social` wholesale | `ADR-0055` §3; `PRD-020` `TSF-FR-143` |
| C-8 | A caller outside an allow-list is refused **by code**, indistinguishably from absent | `ADR-0059` §4 items 3–4 |

---

## 6. Open questions this ADR deliberately does not answer

1. **Does a locally-projected check satisfy BC Map L468?** If **yes**, Option B needs **zero** Rank 4
   amendments and §4's three sites are moot. If **no**, Option A is forced and all three apply. **This single
   interpretive question determines the entire blast radius**, and it is the Architecture Owner's to answer.
2. **If Option B: what staleness budget is acceptable**, and where is it recorded? `PRD-020` `TSF-CFG-024`
   currently posts a 60 s p95 *reversal propagation* budget, which is a different quantity.
3. **If Option A: what is the edge's pattern and number?** `C/S` + sync port by `E-16` analogy is *plausible*,
   not decided. The next free edge identifier is not allocated here.
4. **Is amending `tool/module_dependencies.yaml` (§4.3) the same act as amending the two Rank 4 documents?**
   `ADR-0012` gives the manifest its own authority. If it is a separate **Technical Owner** act, this ADR's
   `Deciders` cell is incomplete for site 3 — stated rather than resolved.
5. **Does `BC-14`/`BC-15` (V2) need the same check later?** Out of scope. Naming it prevents a future pass
   from treating this record as having settled it.

---

## 7. Consequences of leaving this `Proposed`

| | |
|---|---|
| `TSF-GAP-003` | **OPEN** |
| `IMPL-1410` | **BLOCKED** — and every `TSF-AC-*` that depends on the send-time check remains unprovable |
| `PRD-020` lifecycle | Cannot leave `DRAFT` per its own `TSF-FR-142`. **`PLANNED` → `DRAFT` is unaffected**; this blocks the *next* transition |
| `PRD-021` | **MUST NOT ship.** Roadmap **L164** makes shipping it ahead of `PRD-020` a **release-blocking defect**, and this is the mechanism `PRD-020` cannot yet specify |
| `MP-RSK-02` | Remains **Critical**, one of three mitigations unimplementable |
| Architecture | **Unchanged.** No edge added, no allow-list widened, no manifest touched, no code written |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-22 | Created **`Proposed`**. Frames the `BC-12` → `BC-13` synchronous enforcement-check transport required by `MASTER_PRD.md` **L552** (`MP-RSK-02`, **Critical**) and BC Map **L468**, against a Rank 4 edge register in which `BC-13` appears in **exactly one outbound event row** (`E-14`, **L318**). **No transport chosen. No document amended. Nothing closed.** Two options recorded with measured consequences (§3); **three** amendment sites enumerated (§4) — BC Map §7, Matrix **L90**+**L254**, and `tool/module_dependencies.yaml` **L255**–**L259** — correcting `PRD-020` §29, which named only the first. ⚠ **`TRACEABILITY_MATRIX.md` was assessed and REJECTED as an amendment site** (§4.4): it holds no edge register (measured), and its `TSF-*` inventory is a **Traceability Owner** act owed whenever `PRD-020` advances, not an Architecture Owner act contingent on this decision — recording it would have misattributed authority. Eight constraints that hold under either option are listed (§5) and five questions are left explicitly unanswered (§6), the first of which — *does a projected check satisfy L468?* — **alone determines whether the blast radius is three sites or zero**. Follows the **`ADR-0022`** precedent of a `Proposed` ADR that frames a decision it is not authorised to make. |
