# `PRD-005` Correction Report — `C-2` Ratification and `C-3` Reconciliation

| Field | Value |
|---|---|
| **Report ID** | `PRD-005_CORRECTION_REPORT` |
| **Subject document** | [`PRD-MEMBERSHIP-MANAGEMENT.md`](PRD-MEMBERSHIP-MANAGEMENT.md) — `PRD-005`, **v1.0 → v1.1**, `DRAFT` |
| **Predecessor** | [`PRD-005_BLOCKER_ANALYSIS.md`](PRD-005_BLOCKER_ANALYSIS.md) (verdict **A**) |
| **Date** | 2026-08-04 |
| **Scope of authority** | Corrections to a Rank-3-candidate **draft** only. No frozen or ranked document was modified. No ADR was created. `PRD-005` was **not** frozen. |
| **Verdict** | **A — READY FOR INDEPENDENT REVIEW** (§7) |

---

## 0. What this report is, and what it deliberately is not

This report does two things and stops.

1. It **independently re-verifies** the seven `C-2` claims made by `PRD-005_BLOCKER_ANALYSIS.md`, under an
   instruction to *try to disprove them* rather than confirm them (§1). One of those verifications was a genuine
   falsification test with a defined failure condition that would have escalated the verdict to **B**.
2. It records every correction applied to `PRD-005` as a result (§2–§4), and the validation evidence (§6).

It is **not** an independent review of `PRD-005`. It does not assess whether the PRD's 288 requirements are the
right requirements. It does not freeze the document, register it in `PRD_REGISTRY.md`, or claim a baseline row.

### 0.1 Method — every claim below is reproducible

Each finding cites a file and line, reproducible by the command in the right-hand column. Nothing in this report
rests on recollection of a previous analysis.

| # | Claim under test | Reproduction command |
|---|---|---|
| 1 | BC Map L209 column 3 is contextual meaning | `sed -n '209p' … \| awk -F'\|' '{print $4}'` |
| 2 | BC Map L209 column 4 is the binding resolution | `sed -n '195,197p'` + `awk -F'\|' '{print $5}'` |
| 3 | `PRD-005` uses the binding `MembershipStatus` model | `grep -n 'MM-FR-072\|MM-XC-002'` |
| 4 | `MembershipStatus` is independent of `EnrollmentStatus` | `sed -n '209p' \| awk -F'\|' '{print $5}'` |
| 5 | `Frozen` is V2, not a V1 status | `sed -n '728p' …EA` |
| 6 | `E-10` requires a `Pending` membership | `sed -n '307p;421p'` |
| 7 | `Valid` is derived from dates | `sed -n '299p;371p'` |
| 8 | Columns 2–3 are exhaustive **(falsification test)** | `sed -n '212p'` vs `grep -nE '### 2\.2\.[0-9]'` in Authentication PRD |
| 9 | BC Map section numbering | `grep -nE '^## [0-9]+\.'` |
| 10 | Closure is declared explicitly, and only once | `grep -n 'closed set'` |
| 11 | The ADR trigger is edge-scoped | `grep -niE 'requires an ADR'` |
| 12 | The `BC-01` precedent exists and was ratified | `PRD-004` §7.4 vs BC Map §9; `ADR-0018` |

### 0.2 The authority baseline this report reasons under

From `DOCUMENTATION_BASELINE.md` §4: Rank 1 Master PRD · Rank 2 ADRs · **Rank 3 module PRDs** · **Rank 4 BC Map /
Dependency Matrix** · Rank 5 Rulings · Rank 6 EA (*"descriptive only"*) · Rank 7 Config Guide. The same section
states: *"**A conflict is a defect.** If you find one, do not choose — raise it."*

That rule is why this report exists in the form it does. A Rank-3 draft may **not** overrule the Rank 4 BC Map. So
every correction below had to be shown to be **compliance with** the BC Map, or a **citation fix**, never an
override. Where something could not be shown to be compliance, it was left open rather than argued away (§5).

---

## 1. Independent verification of the `C-2` interpretation

### 1.1 The seven claims, tested against primary sources

The decisive artefact is BC Map line 209, decomposed by column rather than read as prose:

```
COL1:  **Status**
COL2:  BC-01: Active/Inactive/Suspended/Archived enrollment state
COL3:  BC-02: Valid/Expired/Frozen membership state
COL4:  `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** —
       a student can be Active with an Expired membership.
```

The table header (L197) is `| Ambiguous word | Context A meaning | Context B meaning | Resolution (binding) |`.
The §5 preamble (L195) states its own authority verbatim:

> *"Each row is a word that means **different things in different contexts**. Every one of these is a latent bug.
> The resolution column is binding: these are the names that must appear in code, APIs, events and UI copy."*

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| 1 | L209 col-3 carries **contextual meaning**, not a binding enumeration | **CONFIRMED** | Column 3's header is literally `Context B meaning` (L197). The row's purpose, per L195, is to expose that one word means different things per context |
| 2 | L209 col-4 is the **binding** resolution | **CONFIRMED** | Column 4's header is `Resolution (binding)`; L195 binds *"the resolution column"* and scopes that binding to **names** — *"the names that must appear in code, APIs, events and UI copy"* |
| 3 | `PRD-005` uses the binding model | **CONFIRMED** | `MM-FR-072` names the type `MembershipStatus`; the PRD uses no banned bare word; the name appears in its events, API and UI copy sections |
| 4 | `MembershipStatus` is **independent** of `EnrollmentStatus` | **CONFIRMED** | Col-4 requires *"**Two independent state machines** — a student can be Active with an Expired membership"*. `PRD-005` §1.3 / `MM-XC-002` keep them separate, and `MM-FR-077` is the strongest possible expression of it: a student suspension **MUST NOT** change `MembershipStatus` |
| 5 | `Frozen` is a **V2** capability, not a V1 status | **CONFIRMED** | EA L728 `Membership Freeze (V2)`; L731 `Proration Rules (V2)`. A V1 PRD that shipped a `Frozen` status would be specifying a V2 capability |
| 6 | `E-10` requires a **pending** membership state | **CONFIRMED** | BC Map L307: *"`FeePaymentReceived` → **may activate a pending membership** (saga in V2, direct handler in V1)"*; L421 gives the same event the purpose *"**Activates membership**, receipt"*. The word *pending* is the Map's own, and `Valid/Expired/Frozen` contains no state that an activation could move **from** |
| 7 | `Valid` is **derived**, not stored | **CONFIRMED** | `E-02` (L299) publishes `MembershipValidity{studentRecordId, validUntil, seatQuota}` — a date, not a status token. The §8 aggregate invariant (L371) is `validUntil > validFrom`. Both treat validity as computed |

Claim 6 deserves emphasis because it inverts the apparent direction of the conflict. If column 3 *were* an
exhaustive V1 status set, then `E-10` — a ranked integration edge in the same Rank 4 document — would be
unimplementable, because there would be no state for a payment to activate a membership **out of**. The
`PendingPayment` state is therefore **recovered from** the BC Map, not asserted against it.

### 1.2 The falsification test — and its defined failure condition

Confirmations are cheap. The instruction was to attempt disproof, so the reading was given a test it could fail.

**Hypothesis to disprove (H₀):** *columns 2 and 3 of §5 are exhaustive enumerations that bind the value sets of
the types named in column 4.*

If H₀ holds, it must hold for **every** row, not just the Status row. It also produces a falsifiable prediction:
no higher-ranked document may define more values for a §5 type than §5 lists.

**The test — the `Role` row, L212:**

```
COL2:  BC-18: a permission bundle (Owner/Manager/Reception)      → 3 values
COL4:  `AccessRole` (BC-18) vs `CommunityRole` (BC-15)
```

**The measurement — Rank 3 `Authentication_PRD_v2.md`:**

| Source | Content |
|---|---|
| §2.2.1–2.2.5 (L469–508) | Student · Parent · Library Owner · Library Manager · Reception Staff |
| §2.3 role register (L590–622) | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception · **`TR-4` Student** · **`TR-5` Parent` |
| §2.2.6 (L517), §2.2.7 (L526) | Platform Support · Platform Administrator |
| `BR-2.9` (L773) | *"Owner, Manager, Reception, **and both platform roles** are invite-only"* |

The BC Map lists **3**. The Rank 3 PRD defines **five tenant roles** (`TR-1`…`TR-5`) plus two platform roles.

**Result: H₀ is falsified.** Under H₀, `Authentication_PRD_v2.md` would be in breach of the Rank 4 BC Map merely by
having a `Student` role — an absurd conclusion, and one nobody has ever raised as a defect. Columns 2 and 3 are
therefore **illustrative of contextual meaning**, exactly as their headers say.

**Control, to guard against a self-serving test.** The `Status` row's column 2 lists four `EnrollmentStatus`
values, and frozen `PRD-004` `SM-2.5` also defines exactly four. That match is real. But the control shows it is
**coincidence of completeness**, not evidence of binding: column 2 happened to enumerate `BC-01` fully, while for
`Role` it did not. A rule that holds in one row and provably fails in another is not a rule.

**What would have escalated this to verdict B.** Had the `Role` row matched the Authentication PRD, H₀ would have
survived its only available test, and `C-2` would have become a genuine Rank-3-vs-Rank-4 conflict — a defect to
raise under `DOCUMENTATION_BASELINE.md` §4, resolvable only by an ADR or a BC Map amendment, neither of which this
task permits. The test was therefore capable of failing, and did not.

### 1.3 Counter-evidence recorded against the ratification

Two statements point the other way, and are recorded here rather than omitted.

| Counter-evidence | Why it does not control |
|---|---|
| Frozen `PRD-004` §2.2 describes L209 as *"the authoritative values"* | This is a Rank 3 document characterising a Rank 4 document. It cannot enlarge §5's self-declared scope, and §5's preamble and column headers are the primary text. `PRD-004`'s statement is also **locally true and harmless**: for `BC-01`, column 2 *is* complete, so nothing in `PRD-004` depends on the general claim |
| `PRD-004_SECOND_INDEPENDENT_REVIEW.md` L564 lists *"`MembershipStatus` — `Valid`/`Expired`/`Frozen`"* | A review report is not a ranked document; it appears nowhere in the `DOCUMENTATION_BASELINE.md` §4 rank table. It also predates any `BC-02` PRD, so it is restating the BC Map illustration, not adjudicating `BC-02`'s V1 state machine |

**Residual risk, stated plainly.** This ratification rests on a reading of §5's scope. It is a strong reading —
the column headers, the preamble's own words, the falsification result, and the `E-10` implementability argument
all agree — but the BC Map does not contain a sentence that says *"columns 2 and 3 are illustrative."* The
architecture owner may prefer to make that explicit. `MM-GAP-006a` carries that suggestion as a **non-blocking**
editorial observation against the BC Map, and `PRD-005` is correct whether or not it is adopted.

### 1.4 Disposition

`C-2` is **ratified as compliance, not divergence**, and is treated as **resolved**. The BC Map is **not**
modified. No ADR is created.

---

## 2. `C-2` — correction applied to `PRD-005`

**§5.1 note, rewritten.** The v1.0 text framed the six-value set as a *divergence* from line 209 and pointed at an
open gap. That framing was wrong on the evidence in §1: there is nothing to diverge from, because column 3 binds
nothing. The note now:

- locates line 209 in **§5 Ubiquitous Language Collisions** and quotes the preamble's *"the resolution column is
  binding"* verbatim;
- decomposes the row's four columns and identifies `Valid/Expired/Frozen` as column 3, headed `Context B meaning`;
- shows compliance with column 4 in full — the type is named `MembershipStatus` (`MM-FR-072`) and is kept
  independent of `EnrollmentStatus` (§1.3, `MM-XC-002`, `MM-FR-077`);
- records the four supporting findings: the non-exhaustiveness proof from the `Role` row, `Frozen` = V2 (EA L728),
  `E-10`'s *"pending membership"* (L307/L421), and `Valid` as derived (`E-02` L299, invariant L371);
- closes `MM-GAP-006` and states explicitly that **no ADR is required and the BC Map is not modified**.

**What did not change.** The status set itself is untouched. No status was added, removed or renamed. `Frozen` and
`Unfrozen` remain **excluded** as V2, which is the correct V1 scope, not an omission.

---

## 3. `C-3` — reconciliation on the ratified `BC-01` precedent

### 3.1 The citation defect underneath the conflict

`C-3` was framed in v1.0 as *"three `BC-02` events are not in BC Map §8's list."* That framing contained a factual
error, which this report records as a defect in its own predecessor output rather than silently correcting.

`grep -nE '^## [0-9]+\.'` on the BC Map gives the authoritative numbering:

| § | Line | Title |
|---|---|---|
| 5 | 193 | Ubiquitous Language Collisions ← L209 lives here |
| 6 | 218 | **Context Map Diagram** |
| 7 | 290 | Integration Relationships ← L292 edge rule |
| **8** | **364** | **Aggregate & Invariant Register** |
| **9** | **397** | **Published Language — Event Surface** ← L407–411 `BC-02` events |
| 10 | 457 | Transaction & Consistency Boundaries |
| 12 | 514 | Microservice Extraction Order |
| **13** | **534** | **Open Questions** |

The event surface is **§9**, not §8. All event-surface citations were corrected (§4).

### 3.2 Is BC Map §9 a closed set for `BC-02`?

Three textual facts, each from a single unambiguous command:

| Fact | Command | Result |
|---|---|---|
| Closure is declared **explicitly** where it applies, and appears **once** in the whole document | `grep -n 'closed set'` | **1 hit, L429**, for `BC-10` only: *"`SEV-1`…`SEV-16` — closed set, see Student Identity PRD §4.14"* — and it **delegates** the register to a Rank 3 PRD |
| The sole ADR trigger is scoped to **edges**, not events | `grep -niE 'requires an ADR'` | **1 hit, L292** (§7): *"If an edge is not in this table, it **does not exist** and adding it requires an ADR"* |
| §9 self-describes as provisional | read L399 | it is the *"**seed** of the full Event Catalog"*, an open action item; the Catalog does not exist |

So: `BC-02` carries no closure marker; the one context that does carry one has it stated explicitly and delegated
downward to a Rank 3 PRD; and the mechanism that would have forced an ADR is about **edges**. `PRD-005` introduces
**no new edge** — every event it publishes travels an existing edge (`E-02`, `E-03`, `E-07`), which is precisely
why `ADR-0016` was needed for an edge change and is not needed here.

### 3.3 The precedent — and it is a ratified one

This exact situation has already been decided in this repository, in a **frozen** document.

| | BC Map §9 | Frozen `PRD-004` §7.4 |
|---|---|---|
| `BC-01` events | **4** — `StudentEnrolled`, `StudentProfileUpdated`, `StudentStatusChanged`, `StudentLinkedToPerson` | **10**, declared a **closed set** |
| Additions | — | `StudentArchived`, `StudentRestored`, `GuardianLinkChanged`, `StudentDocumentAttached`, `StudentDocumentRemoved`, `EnrollmentNumberAssigned` |

`PRD-004` §7.4's preamble cites §9 **for the naming convention only**. Its independent review examined the added
events one by one (L392–404) and challenged `SM-EV-9` as possibly redundant — **on design merit, never on the
grounds that adding events to §9's list required an ADR**. `ADR-0018` then froze `PRD-004` v1.2 with all six
additions intact, amending nothing in the BC Map.

The precedent is therefore not an inference from silence. A Rank 3 PRD owning a context declared a closed event set
larger than §9's seed; that document was reviewed, challenged on other grounds, and **ratified by an ADR**.
`PRD-005` doing the same for `BC-02` is the established, blessed pattern.

### 3.4 Per-event sourcing — nothing invented

| `PRD-005` event | In BC Map §9? | Source | Disposition |
|---|---|---|---|
| `MembershipCreated` | Yes (L409) | §9 | Unchanged |
| `MembershipRenewed` | Yes (L410) | §9 | Unchanged |
| `MembershipExpiringSoon` | Yes (L411) | §9 | Unchanged |
| `MembershipExpired` | Yes (L412) | §9 | Unchanged |
| **`MembershipUpgraded`** | **No** | **`E-07` (L304) names `MembershipCreated/Renewed/Upgraded/Frozen`** | **PRESERVED.** Its absence from §9 is an internal BC Map inconsistency, not authority against it. `BC-05` cannot adjust dues on upgrade without it |
| `MembershipActivated` | No | `E-10` (L307) *"may activate a pending membership"*; §9 L421 *"Activates membership"* | Retained. `E-10` is unimplementable without an activation fact |
| `MembershipVoided` | No | §5.4 error-correction requirement; `MM-INV-001` overlap block | Retained |

`MembershipUpgraded` is **preserved** as instructed, and on independent grounds: it is already named in the Rank 4
document's own `E-07` contract text.

**Frozen / Unfrozen are correctly absent.** §9's table lists them, but EA L728/L731 place Freeze and Proration in
**V2**. Excluding them from a V1 PRD is correctness, not omission — and under `MP-CON-10`, V1 fallbacks must be
explicit, which §12 now is.

### 3.5 Correction applied

**§12 note, rewritten** to record: the §9 location; the closure census showing `BC-02` is unmarked while `BC-10` is
explicitly marked and delegated; the edge-scoped nature of L292's ADR trigger; the `PRD-004`/`ADR-0018` precedent;
per-event sourcing per §3.4; and the V2 exclusion rationale. `MM-GAP-007` is closed. The BC Map is **not**
modified and **no ADR is created**.

---

## 4. Further genuine issues corrected

Auditing the two mandated corrections exposed three additional defect classes. All are citation or consistency
defects inside the draft. None changes a requirement.

| # | Defect | Occurrences | Correction | How found |
|---|---|---|---|---|
| **4.1** | Event surface cited as **BC Map §8** | 2 | → **§9** | `grep -nE '^## [0-9]+\.'` |
| **4.2** | Aggregate & Invariant Register cited as **BC Map §6** (§6 is the *Context Map Diagram*) | **8** | → **§8** | Auditing every `BC Map §N` reference after 4.1 |
| **4.3** | Open Questions cited as **BC Map §12** (§12 is *Microservice Extraction Order*) | 1 | → **§13** | Same audit |
| **4.4** | Four cross-references still described `MM-GAP-006`/`007` as **open** after §5.1/§12 closed them (§4.1 note, `MM-FR-054`, §5.3 note, §24.1 row) | 4 | Rewritten to state the ratified position | Post-edit consistency sweep for `MM-GAP-006\|MM-GAP-007` |
| **4.5** | §25.1 listed `C-2`/`C-3` as unresolved conflicts | 2 rows | Rewritten as **RESOLVED, not a conflict**, with the evidence and the *"no ADR, BC Map unmodified"* statement | Follows from §1–§3 |
| **4.6** | §25.2 listed both gaps as open | 2 rows | Struck through, marked **CLOSED 2026-08-04**; successors `MM-GAP-006a`/`MM-GAP-007a` opened as **non-blocking** BC Map observations | Follows from §1–§3 |
| **4.7** | Header did not reflect the pass | 1 | **v1.0 → v1.1**; Status records `C-2`/`C-3` ratified with no freeze-blocking gap open; **Supporting documents** row added | Housekeeping |
| **4.8** | Change history had no v1.1 row | 1 | v1.1 row added, asserting no requirement/invariant/event/AC/status/scope change | `PRD_LIFECYCLE.md` |
| **4.9** | **Self-inflicted.** §0.2 still declared `MM-GAP-n` count **9** and *"Total: 288 identifiers"* after §4.6 added `MM-GAP-006a`/`007a` — the declaration no longer matched the document | 1 | Corrected to **290 total / 279 obligation-bearing / 11 `MM-GAP`**, and the letter-suffix convention is now documented explicitly | Validation gate 1 (§6) |
| **4.10** | §14.1's `MM-BR-030` row was a **second definition** of a rule already defined in §9, not a restatement — the same defect class corrected in the v1.0 integrity pass | 1 | Rewritten as *"Restated from §9, which is the definition site"*, carrying the full rule text | Validation gate 2 (§6) |

**On 4.9 in particular.** The declaration break was introduced by this pass, not inherited. It is recorded as my own
defect rather than absorbed silently, because a register declaration that does not match its register is exactly the
class of defect `SID-4.56` addresses — *"a rule that cannot be checked SHALL be treated as unmet"*. The count is now
checkable and checked (§6, gate 1). The **279 obligation-bearing identifiers are unchanged from v1.0**; only the
non-obligation `MM-GAP` register grew, by two observations that exist solely to keep closed-gap citations resolvable.

### 4.11 Citations deliberately **not** changed

Blanket replacement would have introduced new defects. Two families of §8 reference are **correct** and were left
alone, filtered by surrounding text rather than by pattern:

- **`Master PRD §8`** (header, *module 6*) — a different document's §8.
- **Nine `BC Map §8` references to the Aggregate & Invariant Register** — L177 (*"the aggregate is the transaction
  boundary"*, verified at BC Map L366), L289/L1503 (`FeeLedger` invariants, verified at L374), L376/L430/L432
  (`BC-02` invariants, L371), L1047, L1138, L1139. All verified individually against the cited lines.

Only the **event-surface** §8s were wrong. Final census: `BC Map §6` = **0** · `§8` = **10** (aggregate register)
· `§9` = **8** (event surface) · `§13` = **1** (Open Questions).

---

## 5. Deliberately left open

Fixing these would require inventing a requirement or amending a ranked document. Both are out of scope.

| Item | Why left open |
|---|---|
| `C-1` — EA lists Membership Analytics as V3 (L734) but V2 elsewhere (L837/L1607) | Internal EA defect. Under `MP-CON-08`, an EA disagreement is *"a defect to be raised, not a choice to be made"*. `PRD-005` excludes Analytics from V1 under either reading, so it is not blocking |
| `C-4` / `MM-GAP-008` — single-day plan vs the strict `validUntil > validFrom` invariant | Resolving it means either disallowing `durationDays: 1` or reformulating a Rank 4 invariant. Blocks single-day plans only |
| `MM-GAP-001` (`Q-01` grace period), `MM-GAP-002` (`Q-06` proration) | Open questions in BC Map §13. `PRD-005` is correct under either answer; deciding them here would be invention |
| `MM-GAP-003` (`GCP-05` DOB) | Owned by `BC-10`; needs an external ADR |
| `MM-GAP-006a`, `MM-GAP-007a` | **New, non-blocking** observations **against the BC Map**: §5's columns would read better annotated *"illustrative"*; and §9 omits `MembershipUpgraded` though `E-07` names it, while listing V2 `Frozen`/`Unfrozen` under a V1 heading. Rank 4 editorial hygiene, for the BC Map owner |
| `BLK-01` / `TASK-D10` — boundary checker red | Pre-existing code debt under `ADR-0012` (expiry 2026-10-31), unrelated to this documentation pass (§6, gate 8). **Not waived** |

---

## 6. Validation

All gates run at the corrected state.

| # | Check | Command | Result |
|---|---|---|---|
| 1 | Requirement IDs / contiguity | register extraction across 10 prefixes | **290 identifiers** (279 obligation-bearing + 11 `MM-GAP`), 10 registers, **ALL CONTIGUOUS** ✅ *(declaration corrected — see §4.9)* |
| 2 | Duplicate IDs | definition-site scan, restatements excluded | **CLEAN** — zero duplicate definitions ✅ *(one found and fixed — see §4.10)* |
| 3 | Acceptance criteria | `MM-AC-*` table scan | **58 ACs**, zero with an empty *Verifies* column ✅ |
| 4 | Traceability (internal) | AC → FR/BR/INV/NFR/PO/XC/EVT/CFG resolution | **all AC references resolve**; **53** distinct requirements cited ✅ |
| 5 | Traceability (`PRD-004`) | `python3 tool/docs_check/prd004_traceability.py` | `TOTAL 251 218 9 13` — **unchanged** by this pass ✅ |
| 6 | Links | repo-wide markdown link resolution | **574 relative links, 0 broken** — `PRD-005_CORRECTION_REPORT.md` now exists ✅ |
| 7 | YAML | parse all project YAML | **4/4 OK** ✅ |
| 8 | Architecture / dependency | `dart run tool/check_module_boundaries.dart` | **RED — PRE-EXISTING.** Three `ADR-0012` debts: `domain/library → platform/services` (expires 2027-03-31), `platform/analytics → platform/event` and `platform/business → platform/tenancy` (both 2026-10-31, `BLK-01`). Code diff for this pass is provably **empty** (gate 10), so none is attributable here. **Not waived** ⚠ |
| 9 | Frozen-document integrity | `git diff HEAD` over frozen paths | **BC Map UNMODIFIED** (byte-identical) · all `10-architecture/`, `00-governance/`, `student-management/`, `authentication/`, Master PRD untouched · **ADR count still 18** ✅ |
| 10 | Application code untouched | `git diff HEAD -- lib/ test/ tool/ packages/ pubspec.yaml web/ android/` | **empty** ✅ |
| 11 | Format | `dart format --output=none --set-exit-if-changed .` | `Formatted 59 files (0 changed)`, exit 0 ✅ |
| 12 | Analyze | `flutter analyze` | **No issues found! (ran in 1.9s)** ✅ |
| 13 | Tests | `flutter test -r compact` | **`00:36 +77 All tests passed!`** ✅ |

Gates 1–4 carry the most weight, because the whole correction pass was **prose-only**. The **279
obligation-bearing identifiers are identical** before and after, all registers contiguous, zero duplicate
definitions — the mechanical proof that no requirement was added, removed, renumbered or silently reworded.

Gates 1 and 2 also earned their place: they each caught a real defect this pass had introduced or inherited
(§4.9, §4.10). A validation suite that never fails is not evidence of correctness, only of weak checks.

### 6.1 Constraint compliance

| Constraint | Status |
|---|---|
| Do **not** freeze `PRD-005` | ✅ Status remains `DRAFT`, Stage 2, *"not frozen, not baselined, not approved"* |
| Do **not** modify frozen/ranked documents | ✅ BC Map byte-identical; no ranked document in the diff |
| Do **not** create a new bounded context | ✅ `BC-02` only |
| Do **not** create an ADR | ✅ Still 18 |
| Do **not** invent requirements | ✅ **279 → 279** obligation-bearing identifiers; the only additions are two non-obligation `MM-GAP` observations; every event sourced in §3.4 |
| Do **not** modify application code | ✅ Gate 10 empty |
| Preserve `MembershipUpgraded` | ✅ §3.4, sourced to `E-07` L304 |
| Correct event surface §8 → §9 | ✅ §4.1 |

---

## 7. Verdict

> ### **A — READY FOR INDEPENDENT REVIEW**

Both freeze blockers are closed on evidence, without touching a frozen document, without an ADR, and without
inventing a requirement.

- **`C-2` — ratified.** All seven claims independently confirmed against primary sources. The interpretation was
  given a falsification test with a defined failure condition — the `Role` row against the Rank 3 Authentication
  PRD — and the disproof **failed**: 3 illustrated values against 5 defined tenant roles. Columns 2–3 are provably
  illustrative. `PRD-005` complies with the binding column in full. Counter-evidence is recorded (§1.3) and
  residual risk is carried as a **non-blocking** observation against the BC Map, not hidden.
- **`C-3` — reconciled.** The conflict rested partly on a mis-citation (§9, not §8), now fixed. `BC-02` carries no
  closure marker; the only explicit closure delegates its register to a Rank 3 PRD; the only ADR trigger is
  edge-scoped and no edge is added; and frozen `PRD-004` §7.4 established the identical pattern for `BC-01` with
  `ADR-0018`'s blessing. `MembershipUpgraded` is preserved on `E-07`'s own text.
- **Eight further defect classes** were found and corrected while verifying the two mandated ones — including two
  systemic citation errors outside the brief (§6→§8 eight times, §12→§13), four stale cross-references left behind
  by closing the gaps, and two integrity defects caught by the validation suite itself, **one of which this pass
  introduced** (§4.9) and is recorded as such rather than absorbed.

**Why A and not B.** Everything remaining open (§5) requires either an ADR, a ranked-document amendment, or a
product decision this document is right to decline. None of it is fixable inside `PRD-005`, and none of it blocks
review. **Why not C:** no architectural blocker survives — both candidates resolved to *compliance*, and the one
red gate is pre-existing code debt with an ADR and an expiry date.

**Two things a reviewer should attack first**, in the spirit of `SID-4.56` (*"a rule that cannot be checked SHALL be
treated as unmet"*):

1. **The scope of BC Map §5.** The ratification rests on reading columns 2–3 as illustrative. That is evidenced,
   not merely asserted — but the BC Map never says it in words. If a reviewer holds that `PRD-004` §2.2's phrase
   *"the authoritative values"* binds, `C-2` reopens as a Rank-3-vs-Rank-4 defect requiring an ADR.
2. **The `BC-01` precedent's transferability.** It is strong — same document, same seed table, ratified by ADR —
   but `PRD-004` was frozen **with** an ADR (`ADR-0018`). A reviewer may reasonably hold that `PRD-005`'s eventual
   freeze ADR must likewise name the three added events explicitly. That is a **freeze-time** requirement, not a
   review-time blocker, and this pass was instructed not to create one.

**Not claimed:** that `PRD-005` is complete, correct in its 288 requirements, or fit to freeze. This report
certifies only that the two named blockers are closed and that the draft is internally consistent enough to review.

**Stopping here**, as instructed — after correction and validation.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Independent re-verification of the seven `C-2` claims including a falsification test that failed to disprove them (§1.2), with counter-evidence recorded (§1.3); `C-2` ratified and `MM-GAP-006` closed; `C-3` reconciled on the `PRD-004`/`ADR-0018` `BC-01` precedent and `MM-GAP-007` closed; event surface corrected §8 → §9; `MembershipUpgraded` preserved on `E-07`'s own text; eight further defect classes corrected (§4), one of them introduced by this pass and disclosed as such (§4.9); items deliberately left open recorded (§5); 13 validation gates run (§6). **No frozen or ranked document modified · BC Map byte-identical · no ADR created (still 18) · `PRD-005` not frozen · no requirement invented (279 → 279 obligation-bearing) · no application code touched.** Verdict **A**. |
