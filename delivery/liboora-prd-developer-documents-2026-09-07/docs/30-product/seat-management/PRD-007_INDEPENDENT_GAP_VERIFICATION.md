# `PRD-007` v1.0 — Independent Gap Verification

| Field | Value |
|---|---|
| **Review** | Independent gap verification — adversarial, audit-only |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, `BC-04` Seating, **v1.0 `DRAFT`** |
| **Prior review** | Production review, verdict **B — MINOR**, on two claimed higher-authority conflicts: `SEAT-GAP-001`, `SEAT-GAP-003` |
| **Question put** | Are `SEAT-GAP-001` and `SEAT-GAP-003` genuine higher-authority conflicts, and do they block a PASS? |
| **Architecture sources** | Master PRD v1.7 (Rank 1) · `ADR-0018`, `ADR-0019` (Rank 2) · Library PRD v1.1 (Rank 3) · BC Map (Rank 4) · Architecture Rulings v1.2 (Rank 5) · Enterprise Architecture v2.1 (Rank 6) · Configuration Guide (Rank 7) · `PRD_LIFECYCLE.md` · `DOCUMENTATION_BASELINE.md` · `DOCUMENTATION_AUDIT-001.md` · frozen `PRD-004` v1.2 · frozen `PRD-005` v1.4 |
| **Reviewed at** | `f89cd9d` (working tree clean) |
| **PRD hash at review** | `623b8945ba03161fda507137315ee04f64cd72e99af9c08036a7441243be386a` — verified identical before and after |
| **Date** | 2026-08-10 |
| **Mandate** | **Audit only.** Nothing fixed, no PRD modified, no status or version change, no freeze, no registry update, no baseline update, no specification, no ADR, no implementation |
| **Verdict** | **A — Both gaps are false or non-blocking** (§9) |

---

## 0. Verdict

> ### **A — Both gaps are false or non-blocking**

**The prior production review was wrong on both counts, and this record says so explicitly.**

| Gap | Prior claim | Verified classification |
|---|---|---|
| `SEAT-GAP-001` | Rank-3-vs-Rank-4 conflict over `Floor` ownership | **C — false positive.** No conflict exists |
| `SEAT-GAP-003` | Unresolved `Q-01`, therefore blocking | **A — genuine, but definitively non-blocking** |

The prior review made two distinct errors:

1. **It inferred a conflict from a non-exhaustive illustrative column** — the failure mode the reviewing
   instruction expressly warned against.
2. **It invented a gate.** It asserted that recorded open gaps prevent a PASS. No such rule exists in
   `PRD_LIFECYCLE.md`, and two frozen PRDs refute it — one carrying the identical `Q-01`.

**Neither gap requires an ADR before `PRD-007` may be frozen.**

---

## 1. Method

Every finding cites a document **on disk in this repository**, by path and line. Nothing is asserted from
conversation memory or from the PRD under review. The precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4 decides which document is *wrong* —
never which one to quietly ignore.

Both gaps were **actively challenged**: the working hypothesis was that each is a false positive, and evidence was
sought to disprove it. `SEAT-GAP-001` failed to survive that test. `SEAT-GAP-003` survived as a genuine open
question but failed to survive the separate test of whether it blocks.

---

## 2. Repository state

| Item | Value |
|---|---|
| Branch | `main` |
| `HEAD` | `f89cd9d7a8ced81ad99e7fb4cd62112b96a708a4` |
| Working tree at review | clean |
| PRD under review | 2833 lines, §0–§36, status `DRAFT`, ten registers, declared == measured == max |
| `PRD-007` registry row | `PRD_REGISTRY.md:227` — `PLANNED`, `BC-04` Seating, `[CORE]`, V1 |

---

## 3. `SEAT-GAP-001` — verified **FALSE POSITIVE**

### 3.1 What the gap claimed

PRD §31 (L2210) and the §3.1 note (L177–182) assert that BC Map §8 listing `Floor` among `BC-04`'s entities
contradicts the Library PRD's ownership of `Floor`, and that *"two authorities disagree."*

### 3.2 Who owns `Floor`: `BC-06` Library Policy, unambiguously

| # | Source | Line | Assertion |
|---|---|---|---|
| 1 | `Library_PRD_v1.md` §26 | **1093** | `| Branch, floors, zones, hours, holidays, closures, policies | BC-06 | **Owns** |` |
| 2 | `Library_PRD_v1.md` | **183** | `| **Floor** | BC-06 | Belongs to exactly one Branch |` |
| 3 | `Library_PRD_v1.md` `LIB-10.1`…`LIB-10.6` | 186–210 | Floor uniqueness, naming, capacity, status rules — all defined here |
| 4 | `CONFIGURATION_GUIDE.md` `LCFG-9`/`LCFG-10` | 345–346 | *"Floors per branch"*, *"Zones per floor"* — **per-library** settings (L508) |

`LIB-26.1` frames §26 as *"the authoritative answer to 'who owns this field?'"*. That is a Rank 3 statement.

### 3.3 The Library PRD does **not** prohibit `BC-04` from owning `Floor`

This was tested directly, because the prior review implied such a prohibition. It does not exist:

- `LXC-6` (L135) forbids **the Library module** from assigning, transferring or releasing a seat.
- `LIB-11.5` (L455) states seat assignment *"is decided by `BC-04` Seating using rules from `BC-06`. This module
  **MUST NOT** implement assignment logic."*

Both concern **assignment**, not **container ownership**. There is no prohibition for the BC Map to contradict.
The prior review's characterisation — *"`LIB-11.5` says assignment is `BC-04`'s but the container is not"* — reads a
container rule into a sentence that contains none.

### 3.4 BC Map L373 does not contradict Rank 3 — the column is provably non-exhaustive

`LIBOORA_BOUNDED_CONTEXT_MAP.md:373` places `Floor` in column 3, headed **"Key entities / VOs"**. Column 2,
**"Aggregate Root"**, holds only `SeatAllocation · SeatLayout`. Three independent proofs that column 3 is
illustrative:

| # | Proof | Evidence |
|---|---|---|
| 1 | **`Zone` appears 0 times in the entire BC Map** (measured) | Yet `LIB-11.1` mandates *"A `Zone` **MUST** belong to exactly one `Floor`"*. A container the map never names cannot be owned by the map's silence |
| 2 | **BC Map §8's own `BC-06` row omits `Floor`, `Zone` and `Branch`** | L375 lists only `WorkingHours, HolidayCalendar, AttendanceRules, SeatRules`. If column 3 were exhaustive, `Floor` would be owned by **nobody** |
| 3 | **The repository has already adjudicated this exact non-exhaustiveness** | `PRD-005` §25.1 `C-2` proved BC Map §5's columns *"provably non-exhaustive"* (the `Role` row lists 3 values where Rank 3 Authentication defines 5), **closed it without an ADR**, and carried the residue as `MM-GAP-006a`: *"§5's per-context columns would be clearer if annotated 'illustrative, not exhaustive'"* |

### 3.5 No edge exists that could make `BC-04` the owner

The sole `BC-06 → BC-04` edge is `E-05` (L302), carrying `SeatRules{maxTransfersPerDay, reservationWindow}` — no
spatial data. BC Map L292: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR."*
Relocating `Floor` into `BC-04` would therefore require a new edge **and** an ADR. Leaving it in `BC-06`, where
Rank 3 already puts it, requires nothing.

### 3.6 The one source that appears to favour `BC-04` is descriptive

`LIBOORA_ENTERPRISE_ARCHITECTURE.md:760` lists `Floor Management (V1)` under Seat Management. The EA is **Rank 6,
descriptive only** — `DOCUMENTATION_BASELINE.md` L139 and L206: *"Update it to match 1–5; never the reverse."*
The audit corpus already records the EA contradicting itself elsewhere (`DOCAUDIT-001` `C-1`; `PRD-005` §25.1 `C-1`).

### 3.7 Already adjudicated in governance

`DOCUMENTATION_AUDIT-001.md:337` — `LC-12`, *"Floor Capacity vs authoritative seat inventory"*, classified
**CONFLICT**, disposition: *"`LIB-10.4`, `LIB-10.5` — planning figure; `BC-04` authoritative; discrepancy surfaced,
never silently reconciled."* Audit outcome: **REMEDIATED**. The Floor/seat-inventory boundary was settled before
this PRD was written, and settled in a way that leaves the container with `BC-06` and the inventory with `BC-04` —
exactly what `SEAT-FR-015` implements.

### 3.8 The PRD's behaviour is already correct

| Requirement | Text | Consistent with |
|---|---|---|
| `SEAT-FR-013` | Container hierarchy **MUST** be `Branch → Floor → Zone → Seat` | `LIB-11.1`, `Library_PRD_v1.md:183` |
| `SEAT-FR-015` | **MUST NOT** create, rename, renumber, delete or set the status of a `Floor` or `Zone` | `LIB-26.1` read-through-projection rule |
| `SEAT-FR-016` | Operates against a default floor where none is configured | `LIB-16.2` *"a library that has changed nothing MUST be fully operable"* |
| `SEAT-FR-174` | Bulk import **MUST NOT** create, rename or delete a `Floor` or `Zone` | `SEAT-FR-015` |

**Only the §31 diagnosis is wrong. Every requirement it produced is right.**

### 3.9 Is an ADR required?

**No**, for two independent reasons:

1. **There is nothing to decide.** `LIB-26.2` (L1108) protects §26 — *"a change to this table is an architecture
   change requiring an ADR. It **MUST NOT** be amended by a PRD revision alone."* §26 **already** assigns floors and
   zones to `BC-06`. An ADR would either restate Rank 3 or overturn it; neither is needed here.
2. **Precedent is directly on point.** `MM-GAP-006`/`MM-GAP-007` were closed on identical reasoning: *"No ADR is
   required and the BC Map is not modified, because the binding column is satisfied and no ranked statement is
   contradicted."*

At most an **editorial** annotation on BC Map L373 is desirable — which is `MM-GAP-006a`'s existing scope, carried
against the **BC Map**, not against this PRD.

---

## 4. `SEAT-GAP-003` — verified **GENUINE, NON-BLOCKING**

### 4.1 `Q-01` is open

| Source | Line | Text |
|---|---|---|
| `MASTER_PRD.md` (Rank 1) | **673** | `| Q-01 | Does an expired membership release the seat immediately, at end-of-day, or after a grace period? | Open — recommendation: configurable, default 24h |` |
| `MASTER_PRD.md` `MP-DEP-07` | 574 | *"Resolution of open questions `Q-01`…`Q-07`"* — **schema freeze** dependency, partially resolved (`Q-02`, `Q-07` settled) |
| BC Map §13 | **540** | Same question; impact *"BC-02→BC-04 event handler semantics"*; recommendation *"Configurable per tenant (BC-25), default 24h grace"* |

Both sources carry a **recommendation**, never a decision. A recommendation inside an open-question register is not
a ruling. `SEAT-GAP-003` is therefore **correctly recorded**.

### 4.2 Membership Management defines expiry, and deliberately refuses to decide release timing

| Requirement | Line | Text |
|---|---|---|
| `MM-FR-071` | 555 | *"This module **MUST NOT** release a seat…"* |
| `MM-FR-112` | 825 | *"Seat reclamation after expiry **MUST** be `BC-04`'s decision, driven by `MM-EVT-005`."* |
| — | 826 | *"**MUST NOT** specify when the seat is released."* |
| — | 558 | *"`Q-01` is open and is **not decided here**."* |
| `MM-FR-111` | — | No grace period at `BC-02`; recorded as `MM-GAP-001` |

So no authoritative document has answered immediate / end-of-day / grace / other.

### 4.3 What the PRD does, and why it is safe

`SEAT-FR-155` flags the allocation and enters it in the expiry work queue; **nothing auto-releases**. Verified by
`SEAT-AC-102` and by the edge-case row at PRD L2114. A human-initiated release is compatible with **all three**
candidate answers, so no wrong behaviour ships under any resolution.

`ADR-0019` §3.3 states the governing standard: *"V1 behaviour is specified so as to be **correct under either
resolution**."* `SEAT-FR-155` meets it.

### 4.4 Why the PRD must **not** decide it

`ADR-0019` §3.3: deciding `Q-01` inside a module document *"would amend the BC Map's open-question register as a side
effect… the silent-amendment failure `PRD_LIFECYCLE.md` L177 prohibits."* `ADR-0018` §10 rejects the same move for
`SM-GAP-10`/`SM-GAP-11`. The named owner is **Architecture + the `BC-04` owner**, and BC Map L540 makes the answer
configurable via `BC-25` — i.e. cross-context, not unilaterally `BC-04`'s.

### 4.5 Is an ADR required?

**Yes eventually — but not before this PRD is frozen.** `Q-01` is a **schema-freeze** dependency (`MP-DEP-07`), a
later and different gate from a module PRD freeze. `ADR-0019` proves the separation by freezing `PRD-005` while
`MM-GAP-001` — the identical `Q-01` — stayed open.

---

## 5. Does either gap block a PASS?

**No.** Three independent lines of evidence.

### 5.1 No such rule exists

`PRD_LIFECYCLE.md` searched for `open gap`, `open question`, `zero gap`, `all gaps`, `unresolved` — **zero hits**.
The Stage 7 gate (L159) is *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."* Nothing
about gap counts. **"Open gap = failure" is an invention of the prior review, not a repository rule.**

### 5.2 Frozen precedent, twice, including on this exact question

| PRD | Status | Open gaps at freeze | Includes |
|---|---|---|---|
| `PRD-005` v1.4 | **FROZEN** (`ADR-0019`) | **7** | **`MM-GAP-001` = `Q-01`, the identical question** |
| `PRD-004` v1.2 | **FROZEN** (`ADR-0018`) | **11** | `SM-GAP-10`, `SM-GAP-11` — *"both remain open and each requires its own ADR"* |

`ADR-0019` L13 lists five gaps it *"does NOT close"*. `PRD_REGISTRY.md:571` records the same: *"Five gaps remain
open and are not ratified by admission."* And `PRD-005_FIFTH_INDEPENDENT_REVIEW.md` L14 returned **A — PASS**,
*"no findings"*, while `MM-GAP-001` was open.

The prior review therefore held `PRD-007` to a stricter standard than the repository applied to the two PRDs it has
already frozen — including on `Q-01` itself.

### 5.3 `ADR-0018` §10 states the operative test

*"none blocks implementation start."* Applied to the two gaps here: `SEAT-GAP-001` has no decision pending at all;
`SEAT-GAP-003` has one pending, and the PRD is written to be correct under every possible answer.

---

## 6. Findings

| # | Finding | Against | Severity | Disposition |
|---|---|---|---|---|
| `GV-1` | `SEAT-GAP-001`'s **diagnosis text** (PRD L177–182, L2210) asserts a Rank-3-vs-Rank-4 conflict that does not exist | `PRD-007` §3.1, §31 | **Low — documentation accuracy only** | The requirements it produced (`SEAT-FR-013`/`015`/`016`/`174`) are **correct and need no change**. Reclassify the gap as an editorial observation against the BC Map, merging into `MM-GAP-006a`'s scope. A clarifying edit under `PRD_LIFECYCLE.md` L171 — changelog entry, **no ADR**. **Not performed here: this record is audit-only** |
| `GV-2` | The prior production review applied a non-existent gate (*open gap ⇒ no PASS*) | The prior review, not the PRD | Medium | **Overturned by this record.** Corrected verdict: **A** |

**No finding is raised against any requirement of `PRD-007`.** `GV-1` concerns explanatory prose; `GV-2` concerns
the prior review.

---

## 7. Rejected findings — recorded as rejected, with reasons

`PRD_LIFECYCLE.md` Stage 3: *"A rejected finding must be recorded as rejected, with its reason. A review that
records only accepted findings is indistinguishable from a review that found nothing."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `RJ-1` | *"`SEAT-GAP-003` should be closed by adopting the BC Map's recommended 24h grace default"* | The recommendation is not a decision. Adopting it would silently amend a Rank 1 open-question register — prohibited by `PRD_LIFECYCLE.md` L177 and refused for the same question by `ADR-0019` §3.3 |
| `RJ-2` | *"`SEAT-GAP-001` should be closed by an ADR assigning `Floor` to `BC-06`"* | Rank 3 `LIB-26.1`/§26 L1093 **already** assigns it. An ADR restating a settled Rank 3 table adds no decision, and `LIB-26.2` reserves ADRs for actual *changes* to that table |
| `RJ-3` | *"The EA listing `Floor Management` under Seat Management is a conflict requiring correction"* | The EA is Rank 6 **descriptive**; baseline L206 requires it to follow Ranks 1–5. A descriptive document trailing the normative ones is not a conflict. Correcting it belongs to the EA owner, not to this PRD |
| `RJ-4` | *"`SEAT-FR-155` should specify the release timing to remove the gap"* | That would decide `Q-01` inside a module PRD — the exact move `ADR-0018` §10 and `ADR-0019` §3.3 both rejected |
| `RJ-5` | *"BC Map L373 should be edited to remove `Floor` from `BC-04`'s entity list"* | A Rank 4 edit requires an ADR before the change (baseline §7), is outside this record's mandate, and is unnecessary — the column is illustrative and no ranked statement is contradicted |

---

## 8. Containment audit

| Check | Result |
|---|---|
| `PRD-SEAT-MANAGEMENT.md` modified | **No** — SHA-256 `623b8945…be386a` identical before and after |
| Status or version changed | **No** — remains **v1.0 `DRAFT`** |
| PRD frozen | **No** |
| Any other PRD modified | **No** |
| BC Map / Master PRD / Rulings / EA / Dependency Matrix modified | **No** |
| Governance files modified (`PRD_LIFECYCLE`, `PRD_REGISTRY`, `DOCUMENTATION_BASELINE`) | **No** |
| ADR created or modified | **No** |
| Specification / API spec / DB schema / SQL / code / implementation tasks created | **No** |
| Integration edge invented | **No** |
| Files added by this record | **1** — this file |

This record is a **historical validation record and is not part of the specification**, following
`DOCUMENTATION_BASELINE.md` §3.3's treatment of `LIBRARY_PRD_ALIGNMENT.md`, `STUDENT_IDENTITY_ALIGNMENT.md`,
`PRD-004_ALIGNMENT_REPORT.md` and the eight `PRD-005` review records. It confers no status and creates,
modifies, reinterprets and withdraws nothing.

---

## 9. Final verdict

> ## **A — Both gaps are false or non-blocking**

- **`SEAT-GAP-001` is a false positive.** `BC-06` owns `Floor` per Rank 3 `LIB-26.1` and §26 L1093. The BC Map
  column relied upon is provably illustrative — `Zone` appears **0 times** in the whole map, and BC Map §8's own
  `BC-06` row omits `Floor`, `Zone` and `Branch`. The same non-exhaustiveness was already adjudicated at
  `MM-GAP-006`/`C-2` **without an ADR**. No conflict, no decision pending, no ADR required.
- **`SEAT-GAP-003` is genuine but non-blocking.** `Q-01` is open at Rank 1, owned by Architecture + the `BC-04`
  owner, and needs an ADR before **schema freeze** — a later gate. `SEAT-FR-155` is correct under all three
  candidate answers, meeting `ADR-0019` §3.3's standard.
- **Neither blocks a PASS.** `PRD_LIFECYCLE.md` contains no rule that open gaps prevent one, and `PRD-004` and
  `PRD-005` were frozen carrying 11 and 7 open gaps respectively — the latter including this same `Q-01`.

**The prior production review's B — MINOR verdict was incorrect and is overturned.** One documentation-accuracy
finding (`GV-1`) is recorded against explanatory prose, not against any requirement.

**Per the mandate, nothing was modified, no status was changed, nothing was frozen and no post-review workflow was
executed. This verification is complete and stops here.**
