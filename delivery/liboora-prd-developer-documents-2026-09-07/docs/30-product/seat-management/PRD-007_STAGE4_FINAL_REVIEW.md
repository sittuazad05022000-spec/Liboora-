# PRD-007 Seat Management — Final Independent Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Reviews** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, v1.0 `DRAFT` |
| **Baseline commit** | `feb5721f1d8f42f7ea69120e3879f1b730cbd26c` |
| **PRD hash at review start** | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` |
| **PRD hash at review end** | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` — **identical; the PRD was not modified** |
| **PRD size** | 2,851 lines · §0–§36 · 136 numbered headings |
| **Gate applied** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 4, re-read at source (L108–119) |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW** |
| **False positives rejected** | 8 (`RC-1`…`RC-8`) |
| **Verdict** | **A — PASS** |

---

## 1. Review scope and baseline

This is the final independent Stage 4 requirements decision for `PRD-007`, taken against the repository as the single
source of truth at commit `feb5721`. Stage 3 Architecture Alignment is already PASS and was not re-opened.

The PRD under review is the state after all prior correction cycles: the `SEAT-FR-212` threshold contradiction, `SR-3`
through `SR-6`, the invalid internal references, the addition of `SEAT-AC-226`, and findings `FR-1` and `FR-2`.
`SEAT-GAP-001` and `SEAT-GAP-003` are intentionally open and non-blocking; they were not re-litigated.

This review was scoped to reach a decision, not to open another correction loop.

---

## 2. Independent methodology

Previous review records and correction records were **not** trusted as evidence. No count, ratio or conclusion was
carried over from them. Every number in §4 was recalculated from the PRD text by verifiers written fresh for this
review (`/tmp/r4/m1.py`…`m5.py`, deliberately outside the repository and deleted afterwards).

Three deliberate methodological choices:

**Definition form was discovered empirically, not assumed.** Rather than presuming which registers are defined in
prose and which in tables — the error that produced phantom duplicates in an earlier cycle — the parser counted both
forms for every register and reported the split:

| Register | Prose defs | Table defs |
|---|---|---|
| `SEAT-FR`, `SEAT-BR`, `SEAT-INV`, `SEAT-XC`, `SEAT-NFR` | 304 / 45 / 14 / 22 / 12 | 0 |
| `SEAT-EVT`, `SEAT-PO`, `SEAT-CFG`, `SEAT-AC`, `SEAT-GAP` | 0 | 4 / 24 / 18 / 226 / 14 |

Each register uses exactly one form with zero overlap, so the two parsers cannot double-count.

**Detector output was treated as a hypothesis, never as evidence.** Every flag raised by a verifier was resolved by
reading the PRD — and where the claim was about another document's authority, by reading that document. Eight flags
were disproved this way and are recorded in §6.

**Authoritative sources were read directly**, not quoted from the PRD's own citations: `MASTER_PRD.md` (Rank 1) for
`MP-GBR-07/08/16/17/19/21`, the FROZEN Membership PRD v1.4 for `MM-NFR-011`, and `PRD_LIFECYCLE.md` for the gate text.

---

## 3. Six Stage 4 gate results

| # | Check | Result |
|---|---|---|
| 1 | Every requirement is testable | **PASS** |
| 2 | Every exclusion states what must be impossible | **PASS** |
| 3 | Every configurable has owner, deterministic default, bounded domain, deterministic unset behaviour | **PASS** |
| 4 | Every AC maps to a requirement; no orphan or dangling references | **PASS** |
| 5 | No requirement improperly restates another PRD's authority | **PASS** |
| 6 | No business rule contradicts Rank-1 authority | **PASS** |

### Gate 1 — testability

A vague-language scan across all normative lines (`fast`, `quick`, `efficient`, `reasonable`, `appropriate`,
`robust`, `scalable`, `as needed`, `etc.` and 12 further terms) returned **one** candidate: `SEAT-NFR-003` at L2257,
*"MUST be fast enough not to dominate the seat-assignment path"*. On its face this is the gate's own failure example.

It is not a defect. The requirement continues *"consistent with `MM-NFR-011`, which states that obligation from the
publishing side"*, and `MM-NFR-011` was read at its authoritative source — Membership PRD v1.4 (**FROZEN**), L1351:

> *"A validity check **MUST** complete fast enough to sit in the seat-assignment and check-in paths without becoming
> their bottleneck; the projection exists for this reason"*

The bound is owned and stated by the publishing module. `SEAT-NFR-004` then makes restating it **forbidden**: *"This
document **MUST NOT** state a latency or availability figure of its own… a second figure in a module PRD creates a
conflict with no resolution rule."* Adding a number here would violate gate 5 to satisfy gate 1. The reference is the
correct construction, and the requirement is testable through its named owner.

All 12 NFRs carry either a numeric bound or a named external delegate — **0 of 12** have neither.

### Gate 2 — exclusions state absence

All **22** exclusions state what is impossible or absent, and all **22/22** are tested by at least one acceptance
criterion. §0.3 L74 defines the register as *"Exclusion — must be impossible **or is out of scope**"*, and each
exclusion satisfies one of those two forms with an AC that asserts the absence, per `SEAT-FR-303`.

Four exclusions were flagged by a first-pass regex and disproved by reading them — see `RC-1`.

### Gate 3 — configurables

All **18** configurable rows carry an owner, a single default and a bounded domain. Exactly one — `SEAT-CFG-017` — has
a domain admitting `unset` (`Integer 1–100, or unset`), and its Default cell states the unset behaviour explicitly:
*"**Unset in V1 — no event is emitted and no value is substituted**"*. A mechanical check for *any* configurable whose
domain admits `unset` without defining unset behaviour returned **0**.

`SEAT-BR-037` (L1847) governs the register: *"Every configurable in this module **MUST** have exactly one owner,
exactly one default, and a defined behaviour when unset"*, grounded in `LIB-16.2`.

### Gate 4 — AC mapping

226 AC rows, all well-formed (5 cells each), **0 orphans**, **0 dangling references**. 683 identifiers are defined and
683 distinct identifiers are cited across 1,641 occurrences — the cited set equals the defined set exactly, in both
directions, so there is neither a citation to a non-existent identifier nor an identifier that is never referenced.

### Gate 5 — no improper restatement

65 distinct foreign identifiers are cited. A scan for any local requirement claiming ownership of a foreign rule
(`this module defines/owns/decides/sets` in the same statement as a foreign identifier) returned **0**. The PRD instead
uses delegation language in 26 places — *"**MUST NOT** define, compute or translate"* (L509, L640, L709), *"decided
entirely by `BC-22`"*, *"is **not decided here**"* (L567), *"belongs to `BC-26`"*.

Representative delegations verified: seat rules to `BC-06` over `E-05`; membership validity to `BC-05` over `E-02`;
notification to `BC-22`; analytics to `BC-26`; authorisation scope to `BC-18` (§28.1, `SEAT-FR-268`…`271`); tenancy
entitlement to `E-17`.

### Gate 6 — no Rank-1 contradiction

Six Rank-1 rules were read in `MASTER_PRD.md` and compared against every PRD statement citing them:

| Rank-1 rule | Source | PRD treatment |
|---|---|---|
| `MP-GBR-07` — events carry tenant context, fail loudly, never default | L338 | L912, L1456, L2082, L2085 — quoted and enforced; `SEAT-AC-203` tests it |
| `MP-GBR-08` — tenant partitioning | L339 | §29 consistent |
| `MP-GBR-16` — seating **blocks**; attendance records/flags | L357 | L554 (G7), L570, L767, L906, L1164 — asymmetry preserved deliberately |
| `MP-GBR-17` — one allocation per seat per window, pessimistic lock, never optimistic | L358 | L485–486, L580, L1018 — restated as the rule's own words with the constraint and lock |
| `MP-GBR-19` — never retroactive | L360 | L1061, L1495, L1856 — configuration changes explicitly non-retroactive |
| `MP-GBR-21` — closed scope register | L120 | L690, `SEAT-FR-269` — *"This module **MUST NOT** add a scope value"* |

No contradiction. Where the PRD narrows a rule it does so in the direction the rule requires, and `SEAT-BR-014` makes
`MP-GBR-16` absolute *"for every role, including Owner"*, refusing any override.

---

## 4. Mechanical verification results

All figures recalculated at `feb5721`. Requested invariants in **bold**.

### 4.1 Registers — contiguous, unique, complete

| Register | Declared (§0.3) | Measured | Contiguous | Duplicates | Out of range |
|---|---|---|---|---|---|
| `SEAT-FR-*` | 001…304 | **304** | yes | 0 | 0 |
| `SEAT-BR-*` | 001…045 | **45** | yes | 0 | 0 |
| `SEAT-INV-*` | 001…014 | **14** | yes | 0 | 0 |
| `SEAT-EVT-*` | 001…004 | **4** | yes | 0 | 0 |
| `SEAT-XC-*` | 001…022 | **22** | yes | 0 | 0 |
| `SEAT-PO-*` | 001…024 | **24** | yes | 0 | 0 |
| `SEAT-CFG-*` | 001…018 | **18** | yes | 0 | 0 |
| `SEAT-NFR-*` | 001…012 | **12** | yes | 0 | 0 |
| `SEAT-AC-*` | 001…226 | **226** | yes | 0 | 0 |
| `SEAT-GAP-*` | 001…014 | **14** | yes | 0 | 0 |
| **Total** | — | **683** | — | **0** | **0** |

Every measured count equals the count declared in §0.3, and every range is contiguous from 1 with no reuse.

### 4.2 Traceability

| Invariant | Result |
|---|---|
| **226/226 AC rows valid** | 226 rows, 0 malformed |
| **0 orphan ACs** | 0 |
| **0 dangling references** | 0 |
| Distinct identifiers cited | **683** = total defined |
| Total citation occurrences | 1,641 |
| Defined but never cited | 0 |
| **`SEAT-FR-302` promise** (every `BR`/`INV`/`EVT`/`XC` cited by ≥1 AC) | **85 / 85** |
| Unresolved internal `§` references | **0** (74 distinct refs against 136 headings) |
| TODO / TBD / FIXME / placeholder | 0 |

### 4.3 Threshold consistency

**No unqualified 90% fallback remains.** Eight lines contain `90`; a scan for any statement calling 90 a default or
fallback without qualification returned **0**. A separate scan for any site asserting 90 *applies when unset* also
returned **0**.

The nine cited sites are mutually consistent:

| Identifier | Location | Statement | Consistent |
|---|---|---|---|
| `SEAT-FR-211` | L1474 | Emit on crossing a configured threshold, either direction; not repeatedly on one side | yes |
| `SEAT-FR-212` | L1478 | Owned by `BC-06` via `E-05`; module **MUST NOT** define/translate/override; unset ⇒ never emitted, 90% **MUST NOT** be substituted, module remains operable | yes |
| `SEAT-FR-241` | L1672 | Configurable; 90% is the value *proposed* for `E-05`, **not** a default this module applies; both branches stated | yes |
| `SEAT-FR-265` | L1855 | Unset ⇒ no threshold, never emitted at any value including 100%, 90% **MUST NOT** be applied as a fallback; 90% is *"a documented proposal, not an active default"* | yes |
| `SEAT-FR-267` | L1907 | Threshold is a **proposed** `E-05` addition, must be confirmed at Stage 3, recorded as `SEAT-GAP-005`; *"Until confirmed, no threshold is set"* | yes |
| `SEAT-CFG-017` | L1890 | Owner `BC-06` via `E-05`; default *"Unset in V1 — no event is emitted and no value is substituted"*; domain `Integer 1–100, or unset` | yes |
| `SEAT-BR-037` | L1847 | Every configurable: exactly one owner, one default, defined unset behaviour | yes |
| `SEAT-AC-169` | L2530 | Tests the **set** branch — threshold 90, crossing 88→91→95, emitted once | yes |
| `SEAT-AC-170` | L2531 | Tests the **unset** branch — occupancy 100%, no event emitted | yes |

The reviewer's list named `SEAT-FR-037`; that identifier is the `SeatState` derivation function at L386 and is
unrelated to thresholds. The configurable-governance rule is `SEAT-BR-037` (L1847), which is what was verified. Both
were read; neither conflicts with the set above.

Four states, one behaviour each, no gap and no overlap: unset · set to 1–100 · out-of-domain (rejected, tested by
`SEAT-AC-190`) · 90% once `E-05` carries it.

### 4.4 `SEAT-GAP-*` discipline

**No `SEAT-GAP-*` appears in any AC's `Verifies` field** — 0 of 226. This satisfies §0.3 L82 (*"must never be cited as
verifiable"*) and §31 L2216 (*"none may be cited as an acceptance criterion"*).

All 14 GAP rows carry a question, a reason and an owner, satisfying the Stage 4 gate requirement that conflicts be
*"closed or explicitly deferred with a reason and an owner"*.

### 4.5 Integration edges and Stage 3 boundaries

**13 integration edges, unchanged, none invented:** `E-01`, `E-02`, `E-03`, `E-04`, `E-05`, `E-08`, `E-13`, `E-17`,
`E-18`, `E-19`, `E-20`, `E-21`, `E-23`.

| Boundary | Result |
|---|---|
| `tenantId` lines | **17**, unchanged |
| Tenant context unresolved | fails loudly; no default or fallback tenant (`MP-GBR-07`) |
| Suspended tenant | writes rejected, reads per `BC-19` |
| Entitlement limit | checked via `E-17` before the aggregate mutates, failing closed |
| Protected operations | 24 rows, ordered and contiguous 1…24, each with operation and scope |
| Concurrency | pessimistic row lock **and** database unique constraint, *never optimistically* |
| Audit / history | append-only and immutability language across 19 lines |
| Notification | delegated to `BC-22` |
| Bulk bounds | 2,000 import rows / 500 reassignments, with over-limit rejection tested at 2,001 |

### 4.6 No requirement weakened by the latest corrections

Measured against the pre-correction PRD at `789b9f4`:

| Measure | Before | After | Δ |
|---|---|---|---|
| `**MUST**` | 369 | **369** | 0 |
| `**MUST NOT**` | 226 | **226** | 0 |
| `SEAT-FR-*` | 304 | **304** | 0 |
| `SEAT-AC-*` | 226 | **226** | 0 |
| `SEAT-XC-*` | 22 | **22** | 0 |
| `SEAT-CFG-*` | 18 | **18** | 0 |
| `SEAT-PO-*` | 24 | **24** | 0 |
| `SEAT-GAP-*` | 14 | **14** | 0 |

No obligation was removed, no register shrank, no identifier was renumbered or retired. `SEAT-FR-241` gained
constraint: both threshold branches are now stated in the requirement itself, so the unset behaviour can no longer be
misread from that requirement alone.

---

## 5. Findings

**None.**

No CRITICAL, HIGH, MEDIUM or LOW Stage 4 defect was identified. Every candidate raised during this review was tested
against the four conditions required before reporting — that it is normative, that it is an actual
contradiction or testability gap, that no existing AC or requirement already covers it, and that it genuinely fails a
Stage 4 gate — and every candidate failed at least one condition. All are recorded in §6.

The two findings from the preceding review are independently verified closed:

| Prior finding | Verification at this baseline |
|---|---|
| `FR-1` — `SEAT-FR-241` called 90% a default | **CLOSED.** L1672–1678 now reads *"the value **proposed** for that contract to carry… **not** a default this module applies"*. Scan for unqualified default/fallback-90 returns 0 across all 8 lines containing `90`; no site asserts 90 applies when unset |
| `FR-2` — three ACs cited `SEAT-GAP-*` in `Verifies` | **CLOSED.** 0 of 226 AC rows cite a `SEAT-GAP-*`. `SEAT-AC-033` retains `SEAT-CFG-003`, `SEAT-AC-102` retains `SEAT-FR-155`, `SEAT-AC-170` retains `SEAT-FR-241` + `SEAT-FR-212`; all remain non-orphan and the GAP register still has all 14 rows |

Earlier corrections also verified closed at this baseline: the `SEAT-FR-212` threshold contradiction (§4.3), `SR-3`
through `SR-6`, the invalid internal references (0 unresolved), and `SEAT-AC-226` (present, well-formed, citing
`SEAT-NFR-009`).

---

## 6. Rejected false positives

Recorded as rejected with the evidence that disproves each, per the lifecycle's rule that *"a review that records only
accepted findings is indistinguishable from a review that found nothing."*

| ID | Candidate | Why it is not a defect |
|---|---|---|
| `RC-1` | `SEAT-XC-005`, `SEAT-XC-016`, `SEAT-XC-018`, `SEAT-XC-022` state no impossibility | Verifier artefact. My negation regex omitted *"out of scope"* — which §0.3 L74 defines as a valid exclusion form: *"must be impossible **or is out of scope**"*. Read at source, all four state absence explicitly, and each is tested by an absence-asserting AC (`SEAT-AC-078`, `165`, `175`, `190`, `216`) |
| `RC-2` | `SEAT-NFR-003` uses *"fast enough"* — the gate's own failure example | Not a local requirement. The bound is owned and stated by `MM-NFR-011`, read at source in the FROZEN Membership PRD v1.4 L1351. `SEAT-NFR-004` **forbids** this PRD stating its own figure. Adding a number would breach gate 5 to satisfy gate 1 |
| `RC-3` | 307 `SEAT-FR-*` definitions vs 304 declared | Verifier artefact. Read at source, the 3 extras are line-wrapped **citations** beginning a continuation line — L1569 (*"`SEAT-FR-091`'s conversion occurred."*), L2008, L2170 — not definitions. Strict matching yields exactly 304 unique, 0 duplicates |
| `RC-4` | Delegation phrases *"MUST NOT define"*, *"is not decided here"* absent | Verifier artefact: probe strings ignored markdown emphasis. Present with `**` markup — *"This module `**MUST NOT**` define"* at L509, L640, L709; *"is `**not decided here**`"* at L567 |
| `RC-5` | Unresolved internal reference `§43` | Not internal. L31 labels it explicitly: *"This constraint is the source draft's §43"* — a declared foreign reference to the pre-split draft, not a pointer to a section of this document |
| `RC-6` | `SEAT-FR-037` missing from the threshold-consistency set | Identifier confusion in the request, not a PRD defect. `SEAT-FR-037` (L386) is the `SeatState` derivation function; the configurable-governance rule is `SEAT-BR-037` (L1847). Both read; both consistent |
| `RC-7` | 5 NFRs, 18 POs and 9 CFGs lack dedicated ACs | Legitimate deferral, already dispositioned to Stage 6, and outside `SEAT-FR-302`'s scope — that mandate covers `BR`/`INV`/`EVT`/`XC` only, and is satisfied 85/85. Gate 4 requires every AC to map to a requirement, not every requirement to have an AC. Not reopened merely because coverage is under 100% |
| `RC-8` | `SEAT-GAP-001` and `SEAT-GAP-003` remain open | Intentionally open and non-blocking, each recorded with a question, reason and owner — which is exactly what the Stage 4 gate permits: *"conflicts closed or explicitly deferred with a reason and an owner."* Not re-litigated |

No stylistic preference, optional strengthening, additional-AC suggestion or "could be better" observation was
promoted to a finding.

---

## 7. Regression and containment verification

| Item | Status |
|---|---|
| PRD modified | **No** — hash `05dc6fb2…` identical at start and end |
| ADR created | No |
| Architecture, governance, BC Map or other PRD modified | **No** — read-only throughout |
| Stage 5 started | No |
| Specification / API / schema / code / tasks created | No |
| PRD frozen | No |
| `SEAT-GAP-001` / `SEAT-GAP-003` | Untouched, open, non-blocking |
| Files created by this review | Exactly one — this record |
| Verifier scripts | Written to `/tmp/r4/`, outside the repository, deleted after use |

Per `DOCUMENTATION_BASELINE.md` §3.3 this record is a **validation record — not part of the specification**.

---

## 8. Final verdict

### A — PASS

All six Stage 4 gates pass. No genuine CRITICAL, HIGH, MEDIUM or LOW defect exists. No unresolved contradiction
remains inside the PRD — in particular the threshold rule is consistent across all nine sites, with four deterministic
states. All mechanical invariants pass: 10 registers contiguous and unique, 683 identifiers defined and 683 cited,
226/226 AC rows valid, 0 orphans, 0 dangling references, `SEAT-FR-302` satisfied 85/85, no unqualified 90% fallback,
no `SEAT-GAP-*` in any `Verifies` field, 13 integration edges unchanged, Stage 3 boundaries intact, and no requirement
weakened by the latest corrections.

**STAGE 4 PASS — PRD-007 is ready to proceed to Stage 5 Traceability.**

Stage 4 is closed. This review is final; no further Stage 4 cycle is authorised. Stage 5 has **not** been started —
the next authorised step is registering the PRD's prefixes in `TRACEABILITY_MATRIX.md` §2 with counts and ranges,
verified mechanically with zero collisions, on separate authorisation.
