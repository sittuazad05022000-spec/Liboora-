# PRD-005 Blocker Analysis — Conflicts C-2 and C-3

| Field | Value |
|---|---|
| **Document** | `PRD-005_BLOCKER_ANALYSIS.md` |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Status** | **ANALYSIS ONLY — no decision taken, no ADR proposed for acceptance** |
| **Scope** | Exactly two conflicts: **C-2** (`MembershipStatus` value set) and **C-3** (`BC-02` event list) |
| **Baseline observed** | `BASELINE-2026-08-04-C` |
| **Subject document** | [`PRD-MEMBERSHIP-MANAGEMENT.md`](PRD-MEMBERSHIP-MANAGEMENT.md) (`PRD-005`, v1.0, DRAFT Stage 2) |
| **Files modified by this analysis** | **None.** This document is additive; `PRD-005` and every ranked document are untouched |
| **Related gaps** | `MM-GAP-006` (C-2) · `MM-GAP-007` (C-3) |

> **What this document does and does not do.** It reproduces both conflicts mechanically against the live
> repository, identifies the exact conflicting statements and their ranks, determines what the architecture
> *actually intends*, and states what would need to change. It **does not** amend anything, **does not** create or
> accept an ADR, and **does not** invent a requirement or a decision. Where the evidence is genuinely
> indeterminate, that is recorded as indeterminate.

---

## 0. Method

Every claim below was reproduced by reading the live files. Line numbers are as at this baseline.

| # | Check | Command / source | Purpose |
|---|---|---|---|
| 1 | Status collision row | `sed -n '209p'` BC Map, column-decomposed with `awk -F'\|'` | Establish **which table column** the status lists occupy |
| 2 | Enclosing section of line 209 | `grep -n '^## '` BC Map → §5 begins line 192 | Establish the section's own stated authority |
| 3 | `BC-02` event rows | `sed -n '398,425p'` BC Map | Extract the event contract verbatim |
| 4 | Enclosing section of the event table | `grep -n '^## 9'` → line 397 | **Correct a mis-citation in `PRD-005`** |
| 5 | Closure language | `grep -n 'closed set'` BC Map → **one** hit, line 429 (`BC-10`) | Test whether `BC-02`'s list is declared closed |
| 6 | ADR-trigger language | `grep -niE 'requires an ADR'` BC Map → **one** hit, line 292 (edges) | Test whether adding an event triggers an ADR |
| 7 | Edge contract texts | `grep -n 'E-07\|E-10'` BC Map lines 304, 307 | Find events/states the Map itself presupposes |
| 8 | Freeze precedent | `Student_Management_PRD_v1.md` §2.2 (L240–257), §7.4 (L776–800) | How a frozen Rank 3 PRD already handled both problems |
| 9 | Rank table | `DOCUMENTATION_BASELINE.md` §4 L195–205 | Confirm relative authority |
| 10 | Version classification | EA L722–735 (`Freeze` = V2) | Test whether line 209 is V1-scoped |
| 11 | Event-name novelty | `grep -rn 'MembershipUpgraded\|MembershipActivated\|MembershipVoided' docs/` excluding PRD-005 | Confirm which names are genuinely new |
| 12 | ADR corpus | `ADR-INDEX.md`, `ADR-0011`, `ADR-0016` | Establish what has historically required an ADR |

---

## 1. Authority baseline

`DOCUMENTATION_BASELINE.md` §4, verbatim:

| Rank | Document | Authority |
|---|---|---|
| **1** | `MASTER_PRD.md` global rules | Platform-wide |
| **2** | Accepted ADRs | Structural decisions |
| **3** | Four module PRDs incl. **Student Management v1.2** | Everything inside their context |
| **4** | **Bounded Context Map** · Module Dependency Matrix | Boundaries, ownership, permitted edges |
| **6** | Enterprise Architecture v2.1 | **Descriptive only** |

And the governing instruction:

> *"**A conflict is a defect.** If you find one, do not choose — raise it. The precedence order tells you which
> document is *wrong*, not which one to quietly ignore."*

`PRD-005` is a **Rank 3** draft. The BC Map is **Rank 4**. On its face Rank 3 outranks Rank 4 — but §4 scopes
Rank 3 authority to *"everything inside"* the module's context, while Rank 4 governs *"boundaries, ownership,
permitted edges"*. **Both conflicts sit exactly on that seam**, which is why neither is disposable by precedence
alone. That is the real question this analysis has to answer, and it answers it differently for C-2 and C-3.

---

## 2. Conflict C-2 — `MembershipStatus` value set

### 2.1 The conflicting definitions

**Statement A — BC Map (Rank 4), line 209.** Reproduced by column decomposition:

| Column | Header | Content |
|---|---|---|
| 1 | Ambiguous word | `**Status**` |
| 2 | **Context A meaning** | `BC-01: Active/Inactive/Suspended/Archived enrollment state` |
| 3 | **Context B meaning** | `BC-02: Valid/Expired/Frozen membership state` |
| 4 | **Resolution (binding)** | `` `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can be Active with an Expired membership. `` |

**Statement B — `PRD-005` (Rank 3 draft), `MM-FR-072`.** A closed set of six:
`PendingPayment`, `Scheduled`, `Active`, `Expired`, `Superseded`, `Cancelled`; and `MM-FR-073` makes `Frozen`
unreachable in V1.

### 2.2 The mechanical difference

| Value | BC Map line 209 col. 3 | `PRD-005` §5.1 | Assessment |
|---|---|---|---|
| `Valid` | Present | **Absent** | Divergence — but see §2.3 |
| `Expired` | Present | Present | Agree |
| `Frozen` | Present | **Excluded from V1** (`MM-FR-073`, `MM-XC-009`) | **Version-scope difference, not a modelling disagreement** |
| `Active` | Absent | Present | Addition |
| `PendingPayment` | Absent | Present | Addition — **presupposed by `E-10`** |
| `Scheduled` | Absent | Present | Addition |
| `Superseded` | Absent | Present | Addition |
| `Cancelled` | Absent | Present | Addition |

### 2.3 What the architecture actually intends — four findings

**Finding 1 — the status lists are *not* in the binding column.** §5 is titled *"Ubiquitous Language
Collisions"*. Its preamble states its own purpose:

> *"Each row is a word that means **different things in different contexts**. Every one of these is a latent bug.
> The resolution column is binding: these are the names that must appear in code, APIs, events and UI copy."*

The authority claimed is over **names**, and it is claimed for **the resolution column**. The status values sit in
column 3, *"Context B meaning"* — a gloss explaining why the word `Status` is ambiguous. The binding resolution in
column 4 is `EnrollmentStatus` vs `MembershipStatus` and *"two independent state machines"*. **`PRD-005` complies
fully with column 4**: it names the type `MembershipStatus`, and `MM-FR-065`/`§1.3` keep the two machines
independent.

This is the single most important finding in C-2, and it materially weakens the conflict. `PRD-005` §5.1 states
the divergence is *"from BC Map line 209"* without distinguishing the illustrative column from the binding one.

**Finding 2 — line 209 cannot be a V1 status set, because one of its three values is V2.** EA line 728 classifies
**Membership Freeze as V2**. If line 209 were the authoritative V1 enumeration, it would mandate a V1 status
reachable only by a V2 feature. Reading it as the *eventual, cross-version* vocabulary removes that contradiction.
`PRD-005`'s reason 1 is therefore sound. (EA is Rank 6/descriptive, so this is corroborating, not decisive —
but nothing in Ranks 1–4 contradicts it.)

**Finding 3 — `PendingPayment` is presupposed by a Rank 4 statement.** BC Map §7 line 307, `E-10`, verbatim:

> `| E-10 | BC-05 Fee & Collection | BC-02 Membership | C/S | Event | FeePaymentReceived → may activate a pending membership (saga in V2, direct handler in V1) |`

And §9 line 415 gives `fee.FeePaymentReceived` the purpose *"**Activates membership**, receipt"*. A status set of
`Valid/Expired/Frozen` cannot represent *"a pending membership"*. So **the BC Map requires a pre-activation state
that its own column-3 gloss does not list** — an internal incompleteness in the Rank 4 document, independent of
`PRD-005`. `PendingPayment` is *recovered from* the Map, not invented against it.

**Finding 4 — `Valid` is a computed answer, not a stored state.** BC Map §7 line 299, `E-02`, publishes
`MembershipValidity{studentRecordId, validUntil, seatQuota}` and the §6 aggregate invariant is
`validUntil > validFrom`. Both treat validity as **derived from dates**. `PRD-005` `MM-FR-065` defines validity as
`status == Active AND startDate <= D <= endDate AND tenant matches`. Storing `Valid` as a status would make the
same fact representable two ways — the classic conflation. `PRD-005`'s reason 3 is sound.

### 2.4 The governing precedent — and why it does *not* control here

Frozen `PRD-004` §2.2 faced the mirror-image problem and treated line 209 as **authoritative and closed**:

> `SM-2.5` — `EnrollmentStatus` **MUST** be the closed set **`Active`, `Inactive`, `Suspended`, `Archived`**.

with the rationale *"The repository does not support that set"*, rejecting a proposed richer lifecycle.

**This is the strongest argument against `PRD-005`'s six values, and it must be stated plainly.** If line 209's
column 3 was binding for `BC-01`, symmetry suggests it is binding for `BC-02`.

**But the two cases are materially different, in a way that is verifiable rather than rhetorical:**

| | `BC-01` (PRD-004) | `BC-02` (PRD-005) |
|---|---|---|
| Values in col. 3 | 4 | 3 |
| Any col.-3 value unreachable in V1? | **No** — all 4 are V1 | **Yes** — `Frozen` is V2 (EA 728) |
| Does another Rank 4 statement require an unlisted value? | **No** | **Yes** — `E-10` requires *"pending"* |
| Was a value *rejected* or *added*? | **Rejected** `Prospective`/`Registered`/`Expired` — narrowing to the list | **Adds** states — widening beyond the list |
| Cross-machine contamination? | `Expired` would have collapsed the two machines (`SM-2.7`) | None — `PRD-005` keeps them separate |

`PRD-004` **narrowed** to line 209 and removed a value (`Expired`) that would have collapsed the two state
machines — the very thing column 4 makes binding. `PRD-005` **widens** with lifecycle states that leave column 4
intact. So `PRD-004` is a precedent for *"line 209's binding content is the two-machine separation"*, which
`PRD-005` honours. It is **not** a precedent for *"column 3 is an exhaustive V1 enumeration"* — that question was
never reached, because `PRD-004` had no value to add.

One asymmetry must be conceded: `PRD-004` §2.2 *describes* line 209 as *"the authoritative values"*. That phrase,
in a frozen Rank 3 document, is evidence for the stricter reading. It is not dispositive — `PRD-004` speaks for
`BC-01`, and column 2 for `BC-01` happens to be complete — but an honest analysis records it rather than
explaining it away.

### 2.5 Can C-2 be resolved entirely inside `PRD-005`?

**Yes, on the current evidence — with one residual risk.**

`PRD-005` can be corrected without touching any ranked document, because the fix is **editorial precision about
what line 209 binds**, not a change to line 209:

1. Restate the conflict as *"line 209 column 3 is an illustrative gloss; column 4 is the binding resolution"*, and
   state compliance with column 4 explicitly.
2. Add the `E-10` citation (line 307) as the **positive authority** for a pre-activation state, so
   `PendingPayment` is sourced rather than asserted.
3. Cite EA 728 for `Frozen`'s V2 status, framing the exclusion as version scope rather than divergence.
4. Note the derived-vs-stored distinction for `Valid` against `E-02` and the §6 invariant.
5. Downgrade `MM-GAP-006` from *"blocks freeze"* to a **clarification request**: *should BC Map §5 line 209
   column 3 be annotated as illustrative?* — an editorial improvement to a Rank 4 document, not a precondition.

**Residual risk, stated plainly:** this rests on reading column 3 as illustrative. That reading is well supported
(the section's own preamble, the `Frozen`/V2 contradiction, `E-10`'s *"pending"*), but it is an *interpretation* of
a frozen Rank 4 document made by the same author as `PRD-005`. If the Architecture Owner instead rules that
column 3 is an exhaustive per-context enumeration, then `PRD-005` §5.1 is defective and **C-2 becomes a genuine
Rank 3/Rank 4 contradiction requiring an ADR**. The interpretation is therefore offered for ratification, not
asserted as settled.

### 2.6 C-2 summary

| Item | Finding |
|---|---|
| **Conflicting definitions** | BC Map §5 L209 col. 3 `Valid/Expired/Frozen` vs `PRD-005` `MM-FR-072` six values |
| **Authoritative source** | BC Map §5 line 209 **column 4** (`Resolution (binding)`) — the two-machine separation and the type names. Column 3 is *"Context B meaning"*, an ambiguity gloss, and the section claims authority over **names** |
| **Is `PRD-005` non-compliant?** | **Not with the binding column.** It names `MembershipStatus` and preserves the two independent machines (§1.3, `MM-FR-065`) |
| **Recommended resolution** | Correct `PRD-005`'s *characterisation* of the conflict (§2.5 items 1–4); retain the six values; re-scope `MM-GAP-006` to an editorial clarification request against BC Map §5 |
| **Documents needing amendment** | **None mandatory.** `PRD-005` §5.1 prose — a Rank 3 draft, freely editable. *Optional, desirable:* BC Map §5 L209 col. 3 annotated *"illustrative, not exhaustive"* (Rank 4 → needs an ADR **if** pursued). *Separately, pre-existing:* BC Map §9 has no `BC-02` pre-activation state despite `E-10` — a Rank 4 incompleteness that exists with or without `PRD-005` |
| **ADR required?** | **No — not to correct `PRD-005`.** An ADR is required only to *amend the BC Map*, which is optional. **Ratification of the column-3 reading by the Architecture Owner is required** before freeze; if that ruling goes the other way, an ADR becomes mandatory |

---

## 3. Conflict C-3 — `BC-02` event list

### 3.1 First: `PRD-005` mis-cites the section number

`PRD-005` refers throughout to *"BC Map §8"* for the event surface. Verified:

| BC Map section | Line | Title |
|---|---|---|
| §8 | 364 | **Aggregate & Invariant Register** |
| **§9** | **397** | **Published Language — Event Surface** |

The event table is **§9**, and the *"names… are fixed here"* sentence is §9's preamble (line 399). §8 is the
aggregate register. This is a citation defect in `PRD-005` (§12, §18, §25.1 C-3, `MM-GAP-007`) and must be
corrected regardless of how C-3 is decided. It does not change the substance.

### 3.2 Current BC Map event contract for `BC-02` — verbatim, §9 lines 407–411

| Producer | Event | Primary consumers | Purpose |
|---|---|---|---|
| BC-02 | `membership.MembershipCreated` | BC-05, BC-04, BC-26, BC-22 | Generates dues, unlocks seating |
| BC-02 | `membership.MembershipRenewed` | BC-05, BC-26, BC-22 | Extends validity |
| BC-02 | `membership.MembershipExpiringSoon` | BC-22, BC-28 | Reminder trigger (fact, not command) |
| BC-02 | `membership.MembershipExpired` | BC-04, BC-26, BC-22 | Seat reclamation policy |
| BC-02 | `membership.MembershipFrozen` / `Unfrozen` | BC-05, BC-04, BC-26 | Proration + seat hold |

§9 preamble, verbatim:

> *"The V1 event surface, by producing context. This is the **seed of the full Event Catalog** (open action item #4
> in the architecture README) — names, producers and consumers are fixed here; payload schemas and versioning
> belong in the catalog."*

### 3.3 `PRD-005` event contract — §12, `MM-EVT-001` … `MM-EVT-007`

| ID | Event | In BC Map §9? |
|---|---|---|
| `MM-EVT-001` | `membership.MembershipCreated` | ✅ Yes |
| `MM-EVT-002` | `membership.MembershipActivated` | ❌ **No — added** |
| `MM-EVT-003` | `membership.MembershipRenewed` | ✅ Yes |
| `MM-EVT-004` | `membership.MembershipUpgraded` | ❌ **No — added** (but see §3.5 Finding 2) |
| `MM-EVT-005` | `membership.MembershipExpired` | ✅ Yes |
| `MM-EVT-006` | `membership.MembershipExpiringSoon` | ✅ Yes |
| `MM-EVT-007` | `membership.MembershipVoided` | ❌ **No — added** |

### 3.4 Exact missing / extra events

**Extra in `PRD-005` (3):** `MembershipActivated`, `MembershipUpgraded`, `MembershipVoided`.

**Missing from `PRD-005` (2):** `MembershipFrozen`, `MembershipUnfrozen` — excluded as V2 (`MM-XC-009`).

Novelty check (`grep -rn` across `docs/`, excluding `membership-management/`): `MembershipActivated` and
`MembershipVoided` appear in **zero** other documents. `MembershipUpgraded` appears **once**, outside §9 — see below.

### 3.5 What the architecture actually intends — four findings

**Finding 1 — §9 does not declare `BC-02`'s list closed, and the repository shows what closure looks like.**
`grep -n 'closed set'` over the BC Map returns exactly **one** hit, line 429:

> `| BC-10 | *(full register)* | — | SEV-1…SEV-16 — closed set, see Student Identity PRD §4.14 |`

So the Map *does* mark a closed event register when it means one — for `BC-10`, and by **delegating the full
register to the Rank 3 PRD**. `BC-02` carries no such marker. Further, §9 calls itself the *"**seed** of the full
Event Catalog"*, and the Catalog does not yet exist (open action item #4). A seed is explicitly not a complete set.
*"Fixed"* is best read as **"these names are binding where they apply"** — you may not rename
`MembershipRenewed` — rather than *"no `BC-02` event may ever exist beyond these five"*.

**Finding 2 — the Map itself already names `MembershipUpgraded`.** BC Map §7 line 304, `E-07`, verbatim:

> `| E-07 | BC-02 Membership | BC-05 Fee & Collection | C/S | Event | MembershipCreated/Renewed/Upgraded/Frozen → generates or adjusts FeeDue |`

`MembershipUpgraded` is therefore **already in the Rank 4 document**, in the edge contract, and its absence from
the §9 table is an internal inconsistency **within the BC Map** — the same class of defect as `ADR-0016`'s missing
`E-22` consumer. This is not `PRD-005` diverging; it is `PRD-005` following one part of the Map where another part
is silent.

**Finding 3 — the decisive precedent: frozen `PRD-004` did exactly this, and it was ratified.** BC Map §9 lists
**four** `BC-01` events (`StudentEnrolled`, `StudentProfileUpdated`, `StudentStatusChanged`,
`StudentLinkedToPerson`). Frozen `PRD-004` §7.4 declares a **closed set of ten**, adding six:

| Added by `PRD-004` | In BC Map §9? |
|---|---|
| `SM-EV-3` `StudentArchived` | ❌ No |
| `SM-EV-4` `StudentRestored` | ❌ No |
| `SM-EV-6` `GuardianLinkChanged` | ❌ No |
| `SM-EV-7` `StudentDocumentAttached` | ❌ No |
| `SM-EV-8` `StudentDocumentRemoved` | ❌ No |
| `SM-EV-9` `EnrollmentNumberAssigned` | ❌ No |

`PRD-004` §7.4's preamble cites §9 only for the **naming convention**, not for the enumeration. Its independent
review examined all nine events individually (§392–404), questioned `SM-EV-9` as *redundant* and even recommended
removing it — **on design merit, never on the ground that adding an event to the Map's list required an ADR.**
`PRD-004` was then frozen at v1.2 by `ADR-0018` with those six additions intact, and `ADR-0018` did not treat them
as an amendment to the BC Map.

**This is a governing precedent, ratified at Rank 2, that a Rank 3 module PRD may declare its own complete event
register — including events absent from BC Map §9 — without an ADR.** `PRD-005` adding three is a *smaller*
departure than `PRD-004` adding six.

**Finding 4 — the ADR trigger in the BC Map is scoped to edges, not events.**
`grep -niE 'requires an ADR'` over the BC Map returns exactly **one** hit, line 292:

> *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and
> adding it requires an ADR."*

This is §7 (edges), not §9 (events). `ADR-0016` exists precisely because line 292 made an unlisted **edge**
impossible to add silently. **No equivalent sentence governs §9.** And `PRD-005`'s three added events introduce
**no new edge**: their consumers (`BC-05`, `BC-04`, `BC-03`, `BC-26`, `BC-22`, `BC-24`) are all reachable on
existing `E-07`, `E-02`, `E-03`, `E-20`, `E-23`. `PRD-005` §12 already notes this correctly.

### 3.6 The `Frozen`/`Unfrozen` exclusion is not a conflict at all

EA line 728 classifies **Membership Freeze as V2**. BC Map §9 lists `MembershipFrozen`/`Unfrozen` in a table
headed *"The V1 event surface"*, with the purpose *"**Proration** + seat hold"* — and EA line 731 makes
**Proration V2** too. So §9's inclusion of these two rows is itself inconsistent with the V1 scope it claims.
`PRD-005` excluding a V2 feature's events from a V1 PRD is **correct**; the defect is in §9's row, which mixes a
V2 capability into a V1 table. This should be recorded as a BC Map observation, not as a `PRD-005` divergence.

### 3.7 Can C-3 be resolved entirely inside `PRD-005`?

**Yes — and here the evidence is materially stronger than for C-2**, because it does not rest on interpretation
but on a ratified precedent plus two textual facts:

1. §9 marks closure explicitly when it means it (`BC-10`, line 429); `BC-02` has no marker.
2. The ADR trigger (line 292) is scoped to **edges**; no new edge is introduced.
3. Frozen `PRD-004`, blessed by `ADR-0018`, added **six** events to its own register without an ADR.
4. `MembershipUpgraded` is already in the Map at `E-07`.

`PRD-005` can therefore be corrected by amending its own prose only:

- Fix **§8 → §9** citations throughout.
- Reframe §12's note: `PRD-005` declares the `BC-02` register in the manner `PRD-004` §7.4 already established,
  citing §9 for the **naming convention** (which it satisfies) rather than as an exhaustive enumeration.
- Cite `E-07` line 304 as existing authority for `MembershipUpgraded`.
- Justify `MembershipActivated` from `E-10` line 307 and §9 line 415 (*"Activates membership"*), which describe
  activation as a distinct transition `MembershipCreated` cannot express when status is `PendingPayment`.
- Record `Frozen`/`Unfrozen` as **V2-consistent exclusion** (§3.6), not divergence.
- Re-scope `MM-GAP-007` from *"blocks freeze"* to two **observations against the BC Map**: (a) `MembershipUpgraded`
  missing from §9 though present at `E-07`; (b) §9 lists two V2-only events in a V1 table.

### 3.8 C-3 summary

| Item | Finding |
|---|---|
| **Current BC Map event contract** | §9 (**not** §8), lines 407–411: `MembershipCreated`, `MembershipRenewed`, `MembershipExpiringSoon`, `MembershipExpired`, `MembershipFrozen`/`Unfrozen`. Preamble binds the **naming convention** and calls itself the *"seed"* of a Catalog that does not yet exist |
| **`PRD-005` event contract** | `MM-EVT-001`…`007`, closed set: `Created`, `Activated`, `Renewed`, `Upgraded`, `Expired`, `ExpiringSoon`, `Voided` |
| **Extra (3)** | `MembershipActivated` (required by `E-10` semantics), `MembershipUpgraded` (**already at `E-07` line 304**), `MembershipVoided` (required by §5.4) |
| **Missing (2)** | `MembershipFrozen`, `MembershipUnfrozen` — **correctly excluded**; both serve V2 Freeze/Proration (EA 728, 731) |
| **Recommended resolution** | Correct `PRD-005` prose only (§3.7). Retain all seven events. Fix §8→§9. Re-scope `MM-GAP-007` to BC Map observations |
| **Documents needing amendment** | **None mandatory.** `PRD-005` §12/§18/§25.1 prose — Rank 3 draft. *Optional, desirable:* BC Map §9 add `MembershipUpgraded`; annotate the `Frozen`/`Unfrozen` row as V2 (Rank 4 → ADR **if** pursued) |
| **ADR required?** | **No.** Line 292's ADR trigger governs **edges**; no new edge is introduced. Frozen `PRD-004` + `ADR-0018` establish the precedent that a Rank 3 PRD declares its own event register |

---

## 4. Cross-cutting observations

Recorded, not resolved — none is a requirement.

| # | Observation | Rank affected | Note |
|---|---|---|---|
| **O-1** | BC Map §9 lists `MembershipFrozen`/`Unfrozen` in a *"V1 event surface"* table, but Freeze (EA 728) and Proration (EA 731) are V2 | 4 vs 6 | The V1 table contains V2-only events |
| **O-2** | `MembershipUpgraded` is at `E-07` (§7 L304) but absent from §9 | 4, internal | Same defect class as `ADR-0016` |
| **O-3** | BC Map presupposes a *"pending"* membership state (`E-10` L307; §9 L415 *"Activates membership"*) that line 209 col. 3 does not list | 4, internal | Independent of `PRD-005` |
| **O-4** | `PRD-005` cites *"§8"* for the event surface; it is **§9** | 3, draft | Must be fixed regardless |
| **O-5** | BC Map §5's binding claim is over **names** in the resolution column; per-context value lists sit in the illustrative columns | 4 | Governs the C-2 reading |
| **O-6** | Frozen `PRD-004` §2.2 calls line 209 *"the authoritative values"* — evidence for the stricter reading | 3, frozen | Recorded against my own recommendation |
| **O-7** | §9's `BC-10` row delegates a closed register to a Rank 3 PRD, showing the intended division of labour | 4 | Supports Rank 3 register ownership |

---

## 5. Answer to the specific question posed

> *"Evaluate whether either conflict can be resolved entirely inside `PRD-005` without changing a ranked/frozen
> document."*

| Conflict | Resolvable inside `PRD-005` alone? | Confidence | Basis |
|---|---|---|---|
| **C-2** | **Yes** | **Moderate** | Rests on reading BC Map §5 line 209 col. 3 as illustrative — well supported by the section's own preamble, `E-10`'s *"pending"*, and `Frozen`-is-V2, but it is an interpretation, and frozen `PRD-004` used the phrase *"authoritative values"* (O-6). **Needs Architecture Owner ratification of the reading, not an ADR** |
| **C-3** | **Yes** | **High** | Rests on textual facts and a ratified precedent, not interpretation: sole ADR trigger is edge-scoped (L292); no new edge; §9 marks closure only for `BC-10`; §9 self-describes as a *"seed"*; `MembershipUpgraded` already at `E-07`; frozen `PRD-004` added **six** events without an ADR and was blessed by `ADR-0018` |

Neither conflict requires a ranked or frozen document to change **in order for `PRD-005` to become correct**. Both
did, however, expose genuine defects *within* the BC Map (O-1, O-2, O-3). Those are pre-existing, independent of
`PRD-005`, and fixing them would require an ADR — but they do **not** block `PRD-005`.

---

## 6. FINAL VERDICT

### **A — No architectural change required; `PRD-005` can be corrected.**

**For C-3 this is firm.** The claim that adding a `BC-02` event requires an ADR does not survive contact with the
repository: the only ADR trigger (line 292) is scoped to edges, no new edge is introduced, §9 declares closure only
for `BC-10`, §9 calls itself a *"seed"*, `MembershipUpgraded` is already in the Map at `E-07`, and frozen `PRD-004`
— ratified by `ADR-0018` — declares ten events where §9 lists four. `MM-GAP-007` was **over-stated** in `PRD-005`
and should be re-scoped from freeze-blocking to two observations against the BC Map.

**For C-2 the verdict holds with one qualification.** The six-value set is compatible with the *binding* column of
line 209, and the `Frozen`-is-V2 and `E-10`-*"pending"* findings make the strict reading of column 3 internally
contradictory. But this conclusion depends on an interpretation of a frozen Rank 4 document, and frozen `PRD-004`
describes the same line as *"the authoritative values"*. I therefore record C-2 as verdict **A conditional on the
Architecture Owner ratifying that BC Map §5 line 209's per-context value lists are illustrative**. If that ruling
goes the other way, C-2 alone escalates to **verdict B** and an ADR becomes mandatory before `PRD-005` §5.1 can
stand. Per `SID-4.56` — *"a rule that cannot be checked SHALL be treated as unmet"* — I do not treat my own
reading as ratified merely because it is well argued.

**Not verdict C.** The architecture is not incoherent. The BC Map contains three localised internal defects
(O-1, O-2, O-3) which are real but narrow, pre-existing, and independent of `PRD-005`. Nothing found here suggests
the membership model itself is unsettled.

### What would happen next (not done here, and not authorised by this analysis)

1. Architecture Owner ratifies or rejects the O-5 column-3 reading — the **only** open decision gating C-2.
2. `PRD-005` prose corrected per §2.5 and §3.7 — Rank 3 draft edits, no ADR.
3. §8 → §9 citations fixed throughout `PRD-005` (O-4).
4. `MM-GAP-006`/`MM-GAP-007` re-scoped from freeze-blocking to clarification requests.
5. **Optionally and separately**, one ADR to repair BC Map O-1/O-2/O-3. Desirable for Map hygiene; **not** a
   precondition for `PRD-005`.

> **No file was modified in producing this analysis, and no ADR was created or accepted.**

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Initial analysis of C-2 and C-3 against the live repository at `BASELINE-2026-08-04-C`. Verdict **A**, with C-2 conditional on ratification of the BC Map §5 column-3 reading. No file modified; no ADR proposed for acceptance |
