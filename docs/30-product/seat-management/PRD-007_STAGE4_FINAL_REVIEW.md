# PRD-007 Seat Management — Final Independent Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Reviews** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, v1.0 `DRAFT` |
| **PRD commit reviewed** | `8ba9675de568f35551835444176669c0df9ae728` |
| **PRD hash at review start** | `6d87a05dfd6dd9b921129c984844a4d3669896f491a509c2c41c53db049f350a` |
| **PRD hash at review end** | `6d87a05dfd6dd9b921129c984844a4d3669896f491a509c2c41c53db049f350a` — **identical; nothing was modified** |
| **PRD size** | 2,847 lines · 36 sections · 136 numbered headings |
| **Gate applied** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 4, re-read at L108–119 |
| **Method** | Full-document audit from scratch. Every number recalculated by a purpose-written verifier; every finding confirmed by reading the PRD at source |
| **Verdict** | **B — MINOR CORRECTIONS** |
| **Findings** | 0 CRITICAL · 0 HIGH · 0 MEDIUM · **2 LOW** |
| **Nature of this document** | **Validation record — not part of the specification** (`DOCUMENTATION_BASELINE.md` §3.3) |

---

## 0. Verdict

**B — MINOR CORRECTIONS.**

All six Stage 4 gate checks pass on their own terms. The two findings below are **internal-consistency defects
against the PRD's own declared rules**, not gate failures: no requirement is untestable, no exclusion is
unfalsifiable, no configurable is unbounded, no criterion is orphaned, no requirement restates another PRD's, and no
business rule contradicts Rank 1.

Both findings are LOW. Neither changes system behaviour, neither requires an ADR, and each has a one-line remedy.
Verdict B rather than A because in each case the PRD states a rule and then departs from it in specific places — the
exact class of defect Stage 4 exists to catch, and a defect a future reader would legitimately raise again.

I did **not** fix them: the instruction for B/C is to report only.

---

## 1. Method, and why previous records were not trusted

Previous review reports and correction records were read only as historical context; **no number, verdict or
disposition was carried forward**. Specifically:

- The Stage 4 gate was re-read from `PRD_LIFECYCLE.md` at source rather than quoted from a prior review.
- A new verifier was written for this review (five independent scripts, `/tmp/s4/v1.py`…`v6.py`), with parsers
  reimplemented rather than reused, so that a bug in an earlier tool could not be inherited.
- Every register, count and citation was recalculated from the PRD text.
- Every mechanical flag was then **read at source before being called a finding**. This mattered: the verifier
  raised eleven candidates that source reading disproved (§4).
- All foreign citations spot-checked in the authority documents themselves (`MASTER_PRD.md`, BC Map, Library PRD,
  Membership PRD).

> **On tool output.** A regex flag is a hypothesis, not a finding. Nine of the eleven candidates in §4 came from my
> own detectors being either stricter or looser than the PRD's actual conventions. Reporting them as defects would
> have manufactured findings; reporting none of them would have hidden the reasoning.

---

## 2. Gate-by-gate result

| # | Stage 4 check | Result | Evidence |
|---|---|---|---|
| 1 | Every requirement testable | **PASS** | 304 `FR` + 45 `BR` + 14 `INV` + 12 `NFR`. 0 vague-adjective requirements without a bound or a named owner. 0 `TODO`/`TBD`/placeholder. 11 requirements carry no modal — all are **definitional** (scope enumeration, aggregate ownership, term definitions, closed sets); §0.2 admits definitions, and each states a checkable fact (§4, `RC-4`) |
| 2 | Every exclusion states what must be impossible/absent | **PASS** | 22/22 `SEAT-XC-*`. All 22 cited by ≥1 `SEAT-AC-*`; all 22 carry impossibility or absence language. §0.3 defines the register as *"must be impossible **or is out of scope"*, and `SEAT-FR-303` mandates absence-as-criterion |
| 3 | Every configurable has a default and a range | **PASS** | 18/18 rows carry Configurable · Owner · **Default** · **Value domain** · Defined at. 0 empty cells; 0 unbounded domains. `SEAT-CFG-017` is the only row admitting `unset`, and its Default column states the unset behaviour explicitly, as `SEAT-BR-037` requires |
| 4 | Every acceptance criterion maps to a requirement | **PASS** | 226/226 AC rows well-formed (7 cells each, no empty Given/When/Then). **0 orphans.** 683 distinct identifiers cited across 1,637 occurrences; **0 dangling**. 683 = the exact sum of the ten register sizes, so every defined identifier is also cited |
| 5 | No requirement restates another PRD's | **PASS** | Ownership is delegated, not duplicated: authorisation consumed from `BC-18` (`SEAT-FR-268`…`271`), tenancy from `BC-19` (`E-18`), limits from `BC-21` (`SEAT-FR-295`: *"MUST NOT implement its own seat-count limit"*), notification routing from `BC-22` (`SEAT-FR-243`), audit from `BC-24`, threshold config from `BC-06` (`SEAT-FR-212`/`266`), analytics from `BC-26` (`SEAT-BR-036`). Foreign identifiers are cited with attribution, never restated as local rules |
| 6 | Business rules do not contradict Rank 1 | **PASS** | Verified at source in `MASTER_PRD.md`: `MP-GBR-16` L357 (seating blocks, attendance records) ⇒ `SEAT-BR-014` absolute G7, no override for any role · `MP-GBR-17` L358 (one allocation per seat per window, pessimistic lock) ⇒ `SEAT-INV-001` + `SEAT-NFR-001` · `MP-GBR-19` L360 (never retroactive) ⇒ `SEAT-FR-264` · `MP-GBR-21` L120 (scope register closed) ⇒ `SEAT-FR-269` adds no scope, defers to `SEAT-GAP-006` · `MP-GBR-07`/`08` ⇒ §29 tenancy. **0 contradictions** |

**Gate condition — *"conflicts closed or explicitly deferred with a reason and an owner"*: SATISFIED.** All 14
`SEAT-GAP-*` rows carry question · why-this-module-cannot-settle-it · **owner** · V1 effect, with no empty cell.

---

## 3. Findings

Two findings. Both LOW. Both are the PRD contradicting a rule it declares itself.

### `FR-1` — LOW — `SEAT-FR-241` still calls 90% a "default", which four other statements deny

| Field | Detail |
|---|---|
| **Location** | Line 1673, `SEAT-FR-241` (§24.1) |
| **Exact text** | *"The occupancy threshold that triggers `SEAT-EVT-004` **MUST** be configurable (`SEAT-CFG-017`, owner `BC-06` via `E-05`, **default 90%** of the branch's active seat count)."* |
| **Evidence** | This is the **only** remaining site in 2,847 lines that presents 90% as an active default. The other four qualify it: `SEAT-FR-212` L1482 — *"the **90%** figure **MUST NOT** be substituted as a fallback"*; `SEAT-FR-265` L1860 — *"the **90%** figure **MUST NOT** be applied as a fallback"*; `SEAT-FR-265` L1862 — *"**90%** becomes the applicable default **only once** the threshold is carried by the `E-05` contract; until that confirmation it is a documented proposal, **not an active default**"*; `SEAT-CFG-017` Default column L1886 — *"**Unset in V1 — no event is emitted and no value is substituted**"*. Measured: `default **90%**` = 1 occurrence; explicit anti-fallback statements = 2; *"not an active default"* = 1 |
| **Why it violates Stage 4** | Check 1 (testable) and the Stage 4 gate on closed conflicts. A `MUST`-bearing requirement naming a default that four other normative statements forbid applying is a **contradictory normative statement**. A reader implementing only `SEAT-FR-241` would ship the 90% fallback that `SEAT-FR-212` prohibits — the identical defect class corrected in `SEAT-AC-169` (where *"the threshold at its default 90%"* became *"set to 90"*), left in place in the requirement that criterion tests |
| **Severity rationale — LOW, not MEDIUM** | The same sentence immediately continues *"Where the threshold is unset, no threshold event is emitted; the module **MUST NOT** substitute a hard-coded value"*, so the requirement is self-limiting and the four-state behaviour is still deterministic (§5). The defect is stale wording inside an otherwise correct rule, not a behavioural ambiguity |
| **Minimal remedy** | In `SEAT-FR-241`, qualify the parenthetical exactly as the other four sites do — e.g. *"default **90%** of the branch's active seat count, applicable only once `E-05` carries the threshold (`SEAT-GAP-005`)"*. One clause; no identifier, register or AC change |
| **ADR required** | **No.** Wording alignment inside an existing decision. Ownership (`BC-06` via `E-05`) and the `SEAT-GAP-005` deferral are unchanged |

### `FR-2` — LOW — three acceptance criteria cite `SEAT-GAP-*` in **Verifies**, which §0.3 and §31 both forbid

| Field | Detail |
|---|---|
| **Location** | `SEAT-AC-033` L2350 · `SEAT-AC-102` L2444 · `SEAT-AC-170` L2527 |
| **Exact text** | `SEAT-AC-033` Verifies = `` `SEAT-CFG-003`, `SEAT-GAP-002` `` · `SEAT-AC-102` Verifies = `` `SEAT-FR-155`, `SEAT-GAP-003` `` · `SEAT-AC-170` Verifies = `` `SEAT-FR-241`, `SEAT-FR-212`, `SEAT-GAP-005` `` |
| **Evidence** | §0.3 L81–82: *"`SEAT-GAP-*` identifiers are **questions, not requirements**, and **must never be cited as verifiable**."* §31 L2215–2216 states it more strongly still: *"None is verifiable and **none may be cited as an acceptance criterion**."* §33 intro L2296 defines the column: *"The **Verifies** column names **the requirement** each criterion tests."* A `SEAT-GAP-*` is by its own definition not a requirement, so it cannot be a member of that column. Measured: exactly 3 of 226 AC rows; 0 occurrences in any Given/When/Then cell |
| **Why it violates Stage 4** | Check 4 (*every acceptance criterion maps to a requirement*). The column is defined to hold requirements; three rows place a non-requirement in it. It is also the `PO-*`/`SPO-*` class of register hygiene error that Stage 5 exists to catch (L129–133) — carrying it forward would register three criteria as verifying identifiers that are declared unverifiable |
| **Severity rationale — LOW, not MEDIUM** | **No criterion is orphaned and none becomes untestable.** In each row the observable outcome rests on a real requirement — `SEAT-AC-033`→`SEAT-CFG-003` (*"Rejected — the default is blocks"*), `SEAT-AC-102`→`SEAT-FR-155` (*"flagged and queued… not released"*), `SEAT-AC-170`→`SEAT-FR-241`+`SEAT-FR-212` (*"No `SEAT-EVT-004` is emitted"*). The `GAP` is an appended context pointer, not the thing under test, so each criterion remains executable exactly as written |
| **Minimal remedy** | Remove the three `SEAT-GAP-*` tokens from the Verifies column. Where the provenance is worth keeping, move it into the criterion's Given/Then prose (as `SEAT-AC-102` already does with *"per the open `Q-01`"*) or leave it to §31, which already records all three. No register change; requirement coverage is unaffected because each row retains its requirement citation |
| **ADR required** | **No.** Register hygiene inside a rule the PRD already states |

---

## 4. Rejected candidates — recorded as rejected, with the evidence

Per the lifecycle's rejected-findings rule (L104–106): *"A review that records only accepted findings is
indistinguishable from a review that found nothing."* Eleven candidates were raised by my own tooling or by reading,
and disproved.

| # | Candidate | Why it is **not** a defect |
|---|---|---|
| `RC-1` | `SEAT-EVT-002`/`003` missing from the register; 2 dangling citations | **Parser bug in my own first script.** It required a prose `` `ID` — `` form; `EVT` is defined in the §22.1 table. Strict re-parse: `EVT` = 4/4 defined at L1446–1449, 0 dangling. Confirmed at source |
| `RC-2` | 7 duplicate definition sites (`SEAT-FR-024`, `SEAT-BR-005`, `SEAT-INV-005`, `SEAT-BR-012`, `SEAT-FR-091`, `SEAT-BR-025`, `SEAT-FR-277`) | **Same parser bug.** Each second hit is a line-initial *citation* in prose (e.g. L2166 *"`SEAT-FR-024`, which permits free repositioning…"*), not a definition. Strict re-parse: **0 duplicates** across all 683 identifiers |
| `RC-3` | 5 configurable rows malformed / `SEAT-CFG-001` domain unbounded | **Markdown escaping artefact.** The "extra cells" are escaped pipes inside enum domains (`` `blocks` \| `permits` ``). Read at source: all 18 rows carry owner, default and domain. `SEAT-CFG-001`'s *"Non-empty string, presentation only"* **is** a bounded domain for a display label |
| `RC-4` | 11 requirements have no `MUST`/`SHOULD`/`MAY` ⇒ untestable | Read all 11. Every one is **definitional**: `FR-004` V1 scope enumeration · `FR-006` aggregate ownership per BC Map §8 · `FR-038` *"`Locked` is NOT a `SeatState` value"* · `FR-041` `Occupied` semantics · `FR-085` booking/reservation/assignment distinction · `FR-089` closed conversion-mode set · `FR-150` normative five-case table · `FR-206` closed event set · `BR-036` metrics/analytics boundary · `FR-272` closed PO list · `FR-304` no-capability-lost statement. §0.2 admits definitions; each states a fact a test can check, and 7 of the 11 are additionally cited by an AC |
| `RC-5` | `SEAT-XC-014` states no impossibility | **Detector too narrow.** L1621 opens *"**No** operation to edit or delete an allocation record… **MUST** exist, for any role including Owner"* — a textbook impossibility statement my regex missed because the negation precedes the modal. Tested by `SEAT-AC-047` and `SEAT-AC-153` |
| `RC-6` | 5 protected operations cite no requirement (`PO-018`…`021`, `PO-024`) | **Detector accepted only `SEAT-FR/BR`.** All five cite sections in *Defined at*: `§5.2` (same grant as `SEAT-PO-016`), `§17.1`, `§17.2`, `§27`, `§13`/`§23.4`/`§25`. Valid backing; 24/24 POs trace to a requirement or a section |
| `RC-7` | Permission-matrix cells unparsed (`**G**`, `` `self` only ``) | Both are **declared legend values** (L1948–1949: *"**G** requires an explicit grant that the role alone does not imply"*). 24/24 rows well-formed, ordered and unique |
| `RC-8` | Four vague phrases the PRD promised to remove are still present | All hits are at L46–47 — inside §0.2's **quoted retrospective** naming the phrases it eliminated. The only other hit, L2065, quotes *"where applicable"* to reject it: *"a decision rule, not a hedge"*. Zero live hedges |
| `RC-9` | 5 NFRs, 18 POs, 9 CFGs have no acceptance criterion | Not a gate failure. `SEAT-FR-302` L2601 scopes the coverage mandate to *"Every `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*` and `SEAT-XC-*`"* — measured **85/85 satisfied**. `NFR`/`PO`/`CFG` are deliberately outside it. Legitimacy re-tested independently in §6: none is a hidden requirement |
| `RC-10` | `BC-18` appears only twice ⇒ authorisation may be decided locally | Frequency is not evidence. §28.1 `SEAT-FR-268`…`271` delegates explicitly: *"This module **MUST NOT** define an authorisation framework"*, roles and the closed scope register consumed from `MP-GBR-20`…`23`, and `SEAT-FR-271` requires authorisation **before** the §8 gate. Gate check 5 holds |
| `RC-11` | 8 AC *Then* cells are one word (`Rejected`, `` `Available` ``, `Denied`) | Brevity is not vagueness. Each names a **specific observable state or outcome** whose meaning is fixed normatively elsewhere (§6.3 statuses; `SEAT-NFR-010` requires every rejection to carry gate, limit and current value). Each remains a single deterministic outcome |

---

## 5. Targeted re-verification of the corrections under review

Verified against the PRD text, independently of what the correction records claim.

### 5.1 Threshold rules — the four states are deterministic

| State | Behaviour, and where it is fixed | Deterministic? |
|---|---|---|
| **`unset`** | No threshold exists. `SEAT-EVT-004` **MUST NOT** be emitted at any occupancy value; 90% **MUST NOT** be substituted; module remains operable — `SEAT-FR-212`, `SEAT-FR-241`, `SEAT-FR-265`, `SEAT-CFG-017`. Tested by `SEAT-AC-170` at 100% | **Yes** |
| **`1`** | Lower bound of the declared domain *Integer 1–100*; `SEAT-FR-211`'s crossing rule applies | **Yes** |
| **`90`** | In-domain value; crossing emits once, not per change while above — `SEAT-FR-211`, `SEAT-FR-242`. Tested by `SEAT-AC-169` (88% → 91% → 95%) | **Yes** |
| **`100`** | Upper bound of the declared domain | **Yes** |

`SEAT-BR-037` (one owner, one default, defined unset behaviour) is satisfied for `SEAT-CFG-017`: owner **`BC-06` via
`E-05`**, unset behaviour stated in the Default column, domain *"Integer 1–100, or unset"*. `FR-1` above is a wording
defect **within** this otherwise coherent set, not a break in it.

### 5.2 The specific items named for attention

| Item | Independent result |
|---|---|
| `SR-6` — threshold ownership | **CLOSED.** `SEAT-FR-212` L1478–1479 names `BC-06`/`E-05` and adds *"this module **MUST NOT** define, translate or locally override it"*. No second source of truth. Consistent with `SEAT-FR-266` (`E-05` Conformist) and BC Map L302 |
| `SR-3` — bulk-operation bounds | **CLOSED, and the original claim was wrong.** `SEAT-FR-179` bounds bulk work at **2,000** rows per import / **500** allocations per reassignment, tested by `SEAT-AC-128` (an import of 2,001 rows is rejected naming the limit). `SEAT-NFR-009` now cites those bounds at the point of use |
| `SR-4` — `SEAT-AC-169` wording | **CLOSED.** Reads *"the threshold **set to 90**"*. No "default" language remains in any AC. The residue is in `SEAT-FR-241` — reported as `FR-1` |
| `SR-5` — event round-trip | **CLOSED.** All four events are cited in an AC Verifies column: `EVT-001`→`SEAT-AC-166`, `EVT-002`→`SEAT-AC-224`, `EVT-003`→`SEAT-AC-225`, `EVT-004`→`SEAT-AC-169`. `SEAT-FR-302` measured **85/85** (`BR` 45/45, `INV` 14/14, `EVT` 4/4, `XC` 22/22) |
| The six invalid internal references | **CLOSED.** 136 numbered headings; **0 unresolved internal `§` references**. `§15.4`, `§16.3`, `§24.2` no longer occur. `§10.1` resolves to BC Map `### 10.1 Where Eventual Consistency Is *Not* Acceptable` (verified at BC Map L470) and is attributed as *"BC Map §10.1"* in `SEAT-NFR-001`. `§43` is self-labelled at L31 as *"the source draft's own numbering, not a section of this document"* |
| `SEAT-AC-226` | **VALID.** Row well-formed; Verifies = `SEAT-NFR-009`; tests a distinct obligation (a single-seat acquisition on an untouched seat succeeds during a maximum-size bulk operation) that no other criterion covers — `SEAT-AC-128` tests the bound, `SEAT-AC-129` exports, `SEAT-AC-225` transfers. `AC` register contiguous 1–226; §0.3 declared range matches |

### 5.3 Domain-by-domain audit

| Domain | Result |
|---|---|
| Booking / reservation / assignment | Distinguished once and normatively — `SEAT-FR-085`: *"A booking is not a reservation and a reservation is not an allocation."* Seven Q-cases §12.2–12.7 each resolve to a configurable or a rule. No contradiction |
| Concurrency / duplicate prevention | `SEAT-INV-001` (one `Active` allocation per seat per overlapping window, enforced in-aggregate **and** at storage) · `SEAT-FR-196` (loser gets a conflict reason and can retry) · `SEAT-FR-197` (two concurrent transfers ⇒ exactly one success) · `SEAT-BR-032` (idempotency at G3, original result returned). Consistent with `MP-GBR-17` |
| Maintenance / locking | `SEAT-BR-025` (lock suppresses **new acquisition only**, at G12) and `SEAT-FR-161` (*"Locking a seat must never trap a student in it"*) are complementary, not contradictory. Override paths bounded: Owner `SEAT-FR-162`, Manager via `SEAT-CFG-005` |
| Eligibility / membership | `SEAT-BR-014` G7 absolute for every role including Owner, no override/bypass/force — matches `MP-GBR-16`. `SEAT-BR-013` G6 refuses `Suspended`/`Archived` per `PRD-004`. `SEAT-FR-146`: a category change never invalidates a held allocation |
| Audit / history | Emitted, not owned (§23.5, `E-20` fire-and-forget, `SEAT-NFR-008` off the critical path). `SEAT-XC-014` forbids edit/delete of any history record for any role; `SEAT-XC-015` refuses to define retention |
| Notification boundary | `SEAT-FR-243`: channel and recipient decided *"entirely by `BC-22`"*; module **MUST NOT** carry a per-student notify preference. `SEAT-FR-240`: a fact with no event carrier goes to a work queue, is not silently dropped, and no new event type may be invented |
| Tenant isolation | `SEAT-FR-287` (`tenantId` on every row class) · `SEAT-INV-009` (no query without a tenant predicate) · `SEAT-INV-010` (no cross-tenant reference) · `SEAT-FR-289` (fail loudly, never default) · `SEAT-FR-294` (cross-tenant ⇒ not-found, not forbidden) · `SEAT-INV-011` (suspended tenant rejects writes). Matches `MP-GBR-07`/`08` |
| Stage 3 integration edges | 13 distinct: `E-01 E-02 E-03 E-04 E-05 E-08 E-13 E-17 E-18 E-19 E-20 E-21 E-23`. None invented; `SEAT-FR-267` records the `E-05` threshold addition as `SEAT-GAP-005` pending Stage 3, rather than assuming it |

---

## 6. Are the deferred observations legitimate deferrals, or hidden requirements?

Tested independently rather than accepted.

| Deferral | Legitimate? | Evidence |
|---|---|---|
| 5 NFRs with no AC (`001`, `003`, `004`, `011`, `012`) | **Yes** | Outside `SEAT-FR-302`'s mandate. `NFR-001` delegates the mechanism to BC Map §10/§10.1 · `NFR-003` delegates the figure to `MM-NFR-011` — **verified present** in the FROZEN Membership PRD at L1351 · `NFR-004` is a self-prohibition against stating platform figures (`LIB-20.1` precedent) · `NFR-011` is the meta-rule making every other requirement observable · `NFR-012` is a stated read-time trade-off. None adds an untested capability |
| 18 POs with no AC | **Yes** | Coverage is not the mechanism: `SEAT-FR-272` declares the list **closed** and `SEAT-AC-192` tests that closure (*"exactly the 24 of §28.2; an operation not listed does not exist"*). All 24 rows carry role columns and a *Defined at* backing. Adding 18 per-operation criteria would restate `BC-18`'s permission model — a gate-check-5 breach |
| 9 CFGs with no AC | **Yes** | All 9 carry default **and** domain, so gate check 3 is met by the register itself. `SEAT-AC-190` tests the cross-cutting guarantee that no configurable value can disable an invariant, a gate step or a `MUST` (`SEAT-FR-301`) |
| `SEAT-GAP-001`, `SEAT-GAP-003` (and the other 12) | **Yes** | Each carries a question, why this module cannot settle it, an **owner**, and a V1 effect. `SEAT-GAP-003` traces to `Q-01`, **verified Open** in `MASTER_PRD.md` L673. `SEAT-BR-045` forbids resolving any gap by implementation choice. This is precisely the gate's *"deferred with a reason and an owner"* |

No deferral was found to conceal a requirement.

---

## 7. Recalculated measurements

Every figure below was computed for this review.

| Register | Range | Count | Missing | Duplicates | §0.3 declared | Match |
|---|---|---|---|---|---|---|
| `SEAT-FR` | 1–304 | 304 | 0 | 0 | 1–304 | ✅ |
| `SEAT-BR` | 1–45 | 45 | 0 | 0 | 1–45 | ✅ |
| `SEAT-INV` | 1–14 | 14 | 0 | 0 | 1–14 | ✅ |
| `SEAT-EVT` | 1–4 | 4 | 0 | 0 | 1–4 | ✅ |
| `SEAT-XC` | 1–22 | 22 | 0 | 0 | 1–22 | ✅ |
| `SEAT-PO` | 1–24 | 24 | 0 | 0 | 1–24 | ✅ |
| `SEAT-CFG` | 1–18 | 18 | 0 | 0 | 1–18 | ✅ |
| `SEAT-NFR` | 1–12 | 12 | 0 | 0 | 1–12 | ✅ |
| `SEAT-AC` | 1–226 | 226 | 0 | 0 | 1–226 | ✅ |
| `SEAT-GAP` | 1–14 | 14 | 0 | 0 | 1–14 | ✅ |

| Measure | Value |
|---|---|
| Identifiers defined | **683** |
| Distinct identifiers cited | **683** — equal, so nothing is defined-but-uncited or cited-but-undefined |
| Total citation occurrences | 1,637 |
| Dangling citations | **0** |
| Orphan acceptance criteria | **0** of 226 |
| Malformed AC rows | **0** of 226 |
| `SEAT-FR-302` mandate | **85 / 85** |
| Configurables with default + domain | **18 / 18** |
| Permission-matrix rows well-formed | **24 / 24** |
| `SEAT-GAP-*` rows with reason + owner + V1 effect | **14 / 14** |
| Unresolved internal `§` references | **0** (136 numbered headings) |
| `**MUST**` / `**MUST NOT**` | 369 / 226 |
| Integration edges | 13, none invented |
| `tenantId` | 17 lines / 19 occurrences |
| `TODO`/`TBD`/placeholder | **0** |

---

## 8. What this review did not do

- Did **not** modify the PRD. Hash identical before and after: `6d87a05dfd6dd9b921129c984844a4d3669896f491a509c2c41c53db049f350a`.
- Did **not** fix `FR-1` or `FR-2` — the instruction for verdict B/C is to report only.
- Did **not** create a correction record, an ADR, a specification, an API, a schema or code.
- Did **not** start Stage 5 Traceability or Stage 6 Implementation Tasks, and did **not** freeze the PRD.
- Did **not** resolve `SEAT-GAP-001` or `SEAT-GAP-003`; both remain open with their owners.
- Did **not** declare Stage 4 PASS or grade A — the verdict is **B**.

---

## 9. Disposition

**Verdict: B — MINOR CORRECTIONS.** Two LOW findings, both internal-consistency defects against rules the PRD
declares itself, neither requiring an ADR:

- **`FR-1`** — `SEAT-FR-241` L1673 still calls 90% a default; four other statements forbid applying it.
- **`FR-2`** — `SEAT-AC-033`, `SEAT-AC-102`, `SEAT-AC-170` cite `SEAT-GAP-*` in **Verifies**, which §0.3 and §31 forbid.

Because the verdict is not A, Stage 4 is **not** closed and Stage 5 Traceability is **not** authorised. The
appropriate next step is a decision by the PRD owner on these two findings — either correct them or record them as
accepted deviations with a reason and an owner, per the Stage 4 gate. Both remedies are single-line edits that change
no register, no identifier and no behaviour.
