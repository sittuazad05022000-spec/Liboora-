# PRD-007 — Comprehensive Stage 4 Correction Record

**Validation record — not part of the specification** (`DOCUMENTATION_BASELINE.md` §3.3).

| Field | Value |
|---|---|
| Subject | `PRD-SEAT-MANAGEMENT.md` v1.0 `DRAFT` |
| PRD SHA-256 **before** | `705323e94c88fc90a857723fde060ad5e01301a04c34a10a9e8a287be2ebf87c` |
| PRD SHA-256 **after** | `6d87a05dfd6dd9b921129c984844a4d3669896f491a509c2c41c53db049f350a` |
| Lines | 2842 → 2847 |
| Diff | 21 insertions / 16 deletions · 13 sites |
| Baseline commit | `5d9abe7` (`PRD-007_STAGE4_REREVIEW_2.md`) |
| Scope | All legitimate outstanding Stage 4 findings, closed in one pass |
| Registers changed | `SEAT-AC-*` 225 → **226** (one criterion genuinely required) |
| Version / status | **Unchanged** — v1.0 `DRAFT`, unfrozen |
| Outcome | 6 defects corrected · 2 false positives recorded · 4 observations deferred with reasons |

---

## 0. What this pass did, and why it is one pass

The instruction was to identify, correct and verify **all** legitimate Stage 4 issues together rather than one finding
per cycle. So this pass did not begin from the three named findings (`SR-3`, `SR-4`, `SR-6`). It began with a fresh
full-document audit, on the explicit assumption that the previous reviewers did not find everything.

That assumption paid off. Three of the six defects corrected here — the invalid internal section references — were
**never raised by any prior review**. They had survived a Stage 3 review, two Stage 4 reviews, and two correction
passes.

---

## 1. Findings considered, and their disposition

Every item examined in this pass, including the ones I rejected.

| # | Finding | Source | Determination | Action |
|---|---|---|---|---|
| 1 | `SEAT-FR-212` — *"tenant configuration"* misstates ownership | `SR-6` | **Genuine defect** | Corrected §2.1 |
| 2 | `SEAT-AC-169` — *"its default 90%"* stale after `SR-1` | `SR-4` | **Genuine defect** (wording) | Corrected §2.2 |
| 3 | `SEAT-NFR-009` — lock limb has no observable criterion | `SR-3` (part) | **Genuine defect** | Corrected §2.3 |
| 4 | `SEAT-NFR-009` — *"maximum row count the entitlement permits"* unbounded | `SR-3` (part) | **FALSE POSITIVE** — bound exists | §3.1 |
| 5 | `SEAT-EVT-001` / `SEAT-EVT-004` absent from any `Verifies` column | `SR-5` | **Genuine defect** (round-trip) | Corrected §2.4 |
| 6 | `§15.4` cited 3× — **section does not exist** | **This pass** | **Genuine defect** | Corrected §2.5 |
| 7 | `§16.3` cited 2× — **section does not exist** | **This pass** | **Genuine defect** | Corrected §2.5 |
| 8 | `§24.2` cited 1× — **section does not exist** | **This pass** | **Genuine defect** | Corrected §2.5 |
| 9 | `SEAT-NFR-001` bare `§10.1` ambiguous | **This pass** | **Genuine defect** (minor) | Corrected §2.6 |
| 10 | `SEAT-XC-005` / `018` / `022` — exclusions without impossibility | Prior detector | **FALSE POSITIVE** | §3.2 |
| 11 | `SEAT-FR-272` closed-list closure untested | `SR-2` | **ALREADY RESOLVED** | §3.3 |
| 12 | `SEAT-NFR-001/003/004/011/012` — no AC | **This pass** | **Valid observation, not a defect** | §4.1 |
| 13 | 18 of 24 `SEAT-PO-*` not cited in any AC | **This pass** | **Valid observation, not a defect** | §4.2 |
| 14 | `SEAT-CFG-001/004/015/018` not cited in any AC | **This pass** | **Valid observation, not a defect** | §4.3 |
| 15 | `SEAT-NFR-003` *"fast enough"* | `RQ-R1` | **Legitimate deferral** — re-upheld | §4.4 |
| 16 | `§43` source-draft reference | `RQ-4` | **ALREADY RESOLVED** | §3.4 |
| 17 | `SEAT-GAP-001` / `SEAT-GAP-003` open | standing | **Legitimate deferral** — out of scope | §4.5 |
| 18 | Duplicate identifier definitions | **This pass** | **NONE FOUND** (0) | §5 |
| 19 | Duplicate table-row identifiers | **This pass** | **NONE FOUND** (0) | §5 |
| 20 | Dangling identifier citations | **This pass** | **NONE FOUND** (0 of 682) | §5 |
| 21 | Orphan acceptance criteria | **This pass** | **NONE FOUND** (0 of 226) | §5 |
| 22 | Malformed permission-matrix rows | **This pass** | **NONE FOUND** — 24/24 well-formed | §5 |
| 23 | Configurables without default or domain | **This pass** | **NONE FOUND** (0 of 18) | §5 |
| 24 | Residual 90% fallback | `SR-1` | **ALREADY RESOLVED** | §5 |

**6 corrected · 2 false positives · 3 already resolved · 6 clean sweeps · 7 observations/deferrals.**

---

## 2. Corrections applied

### 2.1 `SEAT-FR-212` — ownership wording (`SR-6`)

The retained phrase *"Threshold values are tenant configuration"* contradicted five precise statements: `SEAT-CFG-017`
names **`BC-06`** as owner; `SEAT-FR-266` lists the threshold among values that are *"**not** this module's
configurables"*; `SEAT-FR-263` forbids reading it from `BC-25`; `SEAT-AC-191` says `E-05` values *"are **not** tenant
settings of this module"*; `SEAT-XC-022` scopes it *"branch-scoped where `BC-06` owns it"*.

**Before:** `Threshold values are tenant configuration. Where a threshold **is** configured…`

**After:**
```
`SEAT-FR-212` — The threshold is configuration owned by **`BC-06`** and consumed over `E-05`; this module **MUST NOT**
define, translate or locally override it (`SEAT-CFG-017`, `SEAT-FR-263`, `SEAT-FR-266`). Where a threshold **is**
configured it is an integer 1–100 and `SEAT-FR-211`'s crossing rule applies to that value. Where none is configured
no threshold exists: …
```

This is the *second source of truth* risk the instruction named explicitly. An implementer reading only the old
sentence could have built a local tenant setting. The correction adds a prohibition rather than removing anything —
the unset limb, the configured limb and *"**MUST** remain operable"* are all preserved verbatim.

### 2.2 `SEAT-AC-169` — stale default wording (`SR-4`)

`Given` said *"the threshold at its **default** 90%"*. After `SR-1`, 90% is a documented proposal, not a default
(`SEAT-CFG-017`, `SEAT-FR-267`). Changed to *"the threshold **set to** 90"* — a legitimate fixture inside the domain
`1–100`. The criterion's behaviour, `When`, `Then` and existing citations are unchanged.

### 2.3 `SEAT-NFR-009` — lock limb made observable (`SR-3`, valid part)

The lock limb read *"**MUST NOT** hold a lock for the duration of a large batch **in a way that blocks** counter
operations"* — a subjective test with no criterion. Restated as an observable outcome, and the row-count bound made
explicit by citation rather than left implicit:

```
`SEAT-NFR-009` — Bulk operations **MUST** complete or fail as a unit (`SEAT-BR-028`) at the maximum row count
permitted by `SEAT-FR-179`'s sanity bound — **2,000** rows per import, **500** allocations per reassignment — within
the tenant's entitlement limit as checked at gate G4 (`E-17`, `SEAT-FR-172`). A bulk operation **MUST NOT** hold a
lock on any seat it is not currently writing, so that a single-seat acquisition on an untouched seat **MUST** still
succeed while a bulk operation of maximum size is in progress (`SEAT-AC-226`). Where the two conflict, counter
operations take precedence — a library cannot stop serving students because an import is running.
```

**One new criterion, `SEAT-AC-226`** — the only new identifier in this pass:

> | `SEAT-AC-226` | A bulk import of 2,000 rows or a bulk reassignment of 500 allocations is in progress | A single-seat assignment is attempted on a seat the bulk operation does not write | It succeeds without waiting for the bulk operation to finish | `SEAT-NFR-009` |

**Why a new criterion was unavoidable.** I first tried to cite an existing one and drafted `SEAT-AC-129` — then
checked it and found it tests *export contents*, not locks. No existing criterion observes concurrent access during a
bulk operation. Citing `SEAT-AC-129` would have been a dangling-in-substance citation: mechanically valid, semantically
false. That is precisely the artificial coverage the instruction forbids, so I created the one criterion the
requirement genuinely needs and extended §0.3's declared range from `SEAT-AC-225` to `SEAT-AC-226` to keep the
register contiguous.

### 2.4 `SEAT-EVT-001` / `SEAT-EVT-004` — round-trip closed (`SR-5`)

Both events were cited only inside AC *Then* columns, so §33's promise (*"a reader can go from any requirement to its
test and back"*, L2293) failed for 2 of 85. Added to the `Verifies` column of the criteria that already test them:

- `SEAT-AC-166` (enumerates the event set) `Verifies` += `SEAT-EVT-001`
- `SEAT-AC-169` (threshold crossing) `Verifies` += `SEAT-EVT-004`

No criterion invented; both already tested these events in substance. `SEAT-FR-302` round-trip is now **85/85**.

### 2.5 Three invalid internal section references — **found in this pass**

Not raised by any prior review. Each pointed at a subsection that does not exist in the document.

| Ref | Sites | Target does not exist | Corrected to | Verified |
|---|---|---|---|---|
| `§15.4` | L736, L1566, L1874 | §15 stops at **15.3** | `§15.3` (L736, L1874) · `` `SEAT-FR-119` `` (L1566) | §15.3 is *Reservation approval*, containing `SEAT-FR-130` |
| `§16.3` | L2631, L2772 | §16 stops at **16.2** | `§16.2` | §16.2 is *Shift integration*, containing `SEAT-FR-136` |
| `§24.2` | L1464 | §24 stops at **24.1** | `§24.1` | §24.1 is *Which notifiable facts exist, and what carries them* |

The L1566 site needed different treatment. It cited *"the terminal reason from the closed set of §15.4"* — but the
closed set of reservation states is defined by **`SEAT-FR-119`**, not by any subsection. Pointing it at `§15.3` would
have replaced a broken reference with a merely inaccurate one, so it now cites the requirement directly.

**Why this class of defect matters at Stage 4.** A reference into a non-existent section is a requirement an
implementer cannot follow to its source. `SEAT-CFG-007`'s *"Defined at"* column pointed into nothing — the exact
"unbounded configuration is a specification hole" failure mode, arriving by a different route.

### 2.6 `SEAT-NFR-001` — `§10.1` disambiguated

`SEAT-NFR-001` cited *"BC Map §10 … and §10.1 lists double seat allocation"*. The bare `§10.1` reads as this
document's §10.1, which does not exist; the intended target is **BC Map §10.1** (*Where Eventual Consistency Is Not
Acceptable*, verified at `LIBOORA_BOUNDED_CONTEXT_MAP.md` L470). The other three `§10.1` sites already say *"BC Map
§10.1"* explicitly. Prefixed for consistency. Every `§10.1` in the PRD is now an unambiguous foreign reference.

---

## 3. False positives and already-resolved items

Recorded per `PRD_LIFECYCLE.md` L104: *"A rejected finding must be recorded as rejected, with its reason."*

### 3.1 `SR-3`'s row-count limb — FALSE POSITIVE

The previous review said *"'maximum row count the entitlement permits' is never bounded anywhere"*, citing
`grep "maximum row"` returning only `SEAT-NFR-009`.

**The bound exists.** `SEAT-FR-179`: *"A bulk operation **MUST** be bounded by a sanity limit: no more than **2,000**
rows per import and **500** allocations per reassignment. Exceeding a bound **MUST** be rejected before validation
begins."* It is tested by `SEAT-AC-128` (2,001 rows → rejected, naming the limit). `SEAT-FR-172` additionally checks
row count against the `E-17` entitlement limit.

The prior finding searched for the *phrase* rather than the *concept*. I corrected `SEAT-NFR-009` anyway — not because
it was unbounded, but to make the existing bound explicit at the point of use so the same false positive cannot recur.

### 3.2 Three exclusions "without impossibility" — FALSE POSITIVE

My own detector in the previous pass flagged `SEAT-XC-005`, `SEAT-XC-018`, `SEAT-XC-022` for opening with *"out of
scope"*. All three carry absence criteria (`SEAT-AC-078`, `SEAT-AC-175`/`216`, `SEAT-AC-190`), and §0.3 defines the
register as *"Exclusion — must be impossible **or is out of scope**"*. Re-tested and re-rejected. No edit.

### 3.3 `SR-2` closed-list closure — ALREADY RESOLVED

`SEAT-AC-192`: *"It is exactly the 24 of §28.2; an operation not listed does not exist"*, citing `SEAT-FR-272`. The
count matches the 24 `SEAT-PO-*` rows. Withdrawn in the previous pass; re-confirmed here. No edit.

### 3.4 `§43` — ALREADY RESOLVED

L31 reads *"This constraint is the source draft's §43 — that number is the source draft's numbering, not this
document's."* Self-labelling is correct and deliberate. No edit.

---

## 4. Observations and legitimate deferrals — deliberately not "fixed"

### 4.1 Five NFRs have no acceptance criterion

`SEAT-NFR-001`, `003`, `004`, `011`, `012` are cited by no AC.

**Not a defect, and I declined to manufacture coverage.** `SEAT-FR-302` — the PRD's own coverage mandate — requires
criteria for `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*` and `SEAT-XC-*`. It deliberately excludes `SEAT-NFR-*`. Each of
the five is also a *meta* or *architectural-conformance* statement rather than a behaviour: `NFR-004` forbids stating a
latency figure; `NFR-011` requires observability of other requirements; `NFR-012` records a design trade;
`NFR-001` is enforced by the DB constraint that `SEAT-BR-011` mandates and `SEAT-AC-036` tests; `NFR-003` inherits from
`MM-NFR-011`. Adding five ACs to satisfy a rule that does not apply is exactly the inflation the instruction forbids.

### 4.2 Eighteen of 24 `SEAT-PO-*` not cited in an AC

Same reasoning: `SEAT-FR-302` does not cover `SEAT-PO-*`. Every one of the 24 appears in the §28.2 permission matrix
with a per-role grant and a *"Defined at"* requirement, and `SEAT-AC-192` tests the list's closure. The permission
model is consumed from `BC-18`, not defined here (§28.1), so per-operation criteria would restate another context's
model — a gate-check-5 breach. Deferred to Stage 6 test design.

### 4.3 Four configurables not cited in an AC

`SEAT-CFG-001` (zone label), `004` (release reason list), `015` (hold duration), `018` (filter horizon). All four
carry an owner, a default and a bounded domain in §27.1, and `SEAT-AC-190` tests that **no** configurable at any
permitted value disables a `MUST`. Gate check 3 asks for a default and a range, both present. Deferred to Stage 6.

### 4.4 `SEAT-NFR-003` *"fast enough"* — deferral re-upheld

Bounded by a comparative clause (*"not to dominate the seat-assignment path"*) and inherited from `MM-NFR-011` in a
FROZEN Rank 3 PRD. Restating a figure here would breach gate check 5 *and* `SEAT-NFR-004`. `RQ-R1` re-upheld.

### 4.5 `SEAT-GAP-001` and `SEAT-GAP-003` — explicitly out of scope

Untouched by instruction. Both owned by Architecture, both bounded, neither ships wrong behaviour. `SEAT-GAP-001`
3 mentions, `SEAT-GAP-003` 5 mentions — unchanged. `PRD_LIFECYCLE.md` contains no rule making open gaps block Stage 4.

---

## 5. Verification after correction

### 5.1 Registers — all contiguous

| Register | Range | Used | Missing | Extra |
|---|---|---|---|---|
| `FR` | 1–304 | 304 | 0 | 0 |
| `BR` | 1–45 | 45 | 0 | 0 |
| `INV` | 1–14 | 14 | 0 | 0 |
| `EVT` | 1–4 | 4 | 0 | 0 |
| `XC` | 1–22 | 22 | 0 | 0 |
| `PO` | 1–24 | 24 | 0 | 0 |
| `CFG` | 1–18 | 18 | 0 | 0 |
| `NFR` | 1–12 | 12 | 0 | 0 |
| **`AC`** | **1–226** | **226** | 0 | 0 |
| `GAP` | 1–14 | 14 | 0 | 0 |

§0.3's declared range was updated for `SEAT-AC-*` only, and the register remains contiguous with no number reused.

### 5.2 Structural checks

| Check | Result |
|---|---|
| AC rows well-formed | **226 / 226** |
| Orphan ACs | **0** |
| Dangling identifier citations | **0** — 683 distinct identifiers cited across 1,637 occurrences, and 683 is exactly the sum of the ten register sizes |
| Duplicate identifier definition sites | **0** |
| Duplicate table-row identifiers | **0** |
| Configurables with empty default or domain | **0** of 18 |
| Permission-matrix rows well-formed | **24 / 24** |
| Invalid internal subsection references | **0** (was 3) |
| Unresolved `§` references | **0** — `§10.1` now explicitly BC Map, `§43` self-labelled |
| `SEAT-FR-302` coverage in `Verifies` | **85 / 85** (was 83/85) |
| Residual 90% fallback | **0** |

### 5.3 No capability lost, and no requirement weakened

| Measure | Before | After | Reading |
|---|---|---|---|
| `**MUST**` | 368 | **369** | +1 — `SEAT-NFR-009`'s new lock obligation |
| `**MUST NOT**` | 225 | **226** | +1 — the `SEAT-FR-212` ownership prohibition |
| Requirements deleted | — | **0** | — |
| Identifiers renumbered | — | **0** | — |
| Registers reduced | — | **0** | `AC` grew by 1; all others identical |

Normative force **increased**. Every V1 capability is preserved: the diff contains no removal of a feature, a role
grant, an operation or an event. The three reference fixes and the two wording fixes change *where a reader is sent*
and *how precisely a rule is stated*, not what the system does. `SEAT-NFR-009`'s correction makes an existing
obligation testable; it does not relax it.

### 5.4 Stage 3 invariants — no regression

| Surface | Value | vs baseline |
|---|---|---|
| Integration edges | 13: `E-01 E-02 E-03 E-04 E-05 E-08 E-13 E-17 E-18 E-19 E-20 E-21 E-23` | identical, 0 invented |
| Headings | 136 | identical |
| `tenantId` | 17 lines / 19 occurrences | identical on both measures |
| `SEAT-GAP-001` / `SEAT-GAP-003` | 3 / 5 | identical — both open |
| Rank 1 rules | `MP-GBR-08/16/17/19/21` | unaffected |
| `E-05` payload | `SeatRules{maxTransfersPerDay, reservationWindow}` | unaffected; threshold still `SEAT-GAP-005` |
| Authorisation | consumed from `BC-18` | unaffected |

### 5.5 Four threshold states — re-verified after the `SEAT-FR-212` edit

| State | Behaviour | Sources agreeing | Tested by |
|---|---|---|---|
| `unset` | No threshold; `SEAT-EVT-004` never emitted at any value incl. 100%; no substitution; module operable | `FR-212`, `FR-241`, `FR-265`, `FR-267`, `CFG-017` | `SEAT-AC-170` |
| `1` | Threshold 1; event on crossing | `FR-212`, `FR-211`, `FR-242`, `CFG-017` | `SEAT-AC-169` |
| `90` | Threshold 90; event once on crossing | same | `SEAT-AC-169` directly |
| `100` | Threshold 100; event on crossing | same | `SEAT-AC-169` |

The ownership clarification did not disturb any state. `SEAT-BR-037`'s *"exactly one default"* still holds.

---

## 6. No ADR was required

Per instruction 9, an architectural decision would have meant stopping and reporting rather than inventing one. None
arose. Every correction is a clarification within existing decisions:

- `SEAT-FR-212` now **states** the `BC-06`/`E-05` ownership the BC Map already fixes — it does not change ownership.
- `SEAT-NFR-009` cites bounds that `SEAT-FR-179` and `SEAT-FR-172` already set — it does not set new ones.
- The reference fixes point at sections that already exist — no content moved.
- `SEAT-AC-226` tests an obligation `SEAT-NFR-009` already carried.

No integration edge, tenancy rule, security boundary or Rank 1 statement was touched.

---

## 7. What remains open after this pass

| Item | Status | Owner |
|---|---|---|
| `SEAT-GAP-001` `Floor` ownership | Open, bounded | Architecture |
| `SEAT-GAP-003` `Q-01` membership expiry | Open, bounded | Architecture + `BC-04` |
| `SEAT-GAP-002`, `004`…`014` | Open, each with a stated impact | as recorded in §31 |
| NFR / PO / CFG acceptance-criteria depth | Stage 6 test design | `PRD-007` author |
| `SEAT-NFR-003` inherited wording | Deferred, `RQ-R1` | `PRD-007` author |
| Threshold in `E-05` payload | `SEAT-GAP-005`, ADR required | Architecture |

---

## 8. What this correction did not do

- Did **not** declare Stage 4 PASS or grade **A** — that is for an independent reviewer
- Did **not** perform another Stage 4 re-review
- Did **not** begin Stage 5 Traceability, Stage 6 Implementation Tasks, or Stage 7 Freeze
- Did **not** freeze the PRD; version and status remain v1.0 `DRAFT`
- Did **not** create an ADR, specification, API contract, DB schema or code
- Did **not** resolve `SEAT-GAP-001` or `SEAT-GAP-003`
- Did **not** modify any architecture, governance or frozen document
- Did **not** delete or weaken any requirement, or renumber any existing identifier
- Did **not** inflate coverage: 1 new criterion, created only because no existing criterion observed the behaviour
