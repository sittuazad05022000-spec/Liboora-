# PRD-005 — Correction Report for Findings `F-1` … `F-4`

**Corrected document:** `PRD-MEMBERSHIP-MANAGEMENT.md`, **v1.1 → v1.2**, still **`DRAFT`** (not frozen)
**Authorising input:** [`PRD-005_SECOND_INDEPENDENT_REVIEW.md`](PRD-005_SECOND_INDEPENDENT_REVIEW.md) — verdict **B — MINOR CORRECTIONS REQUIRED**
**Scope:** `F-1`, `F-2`, `F-3`, `F-4` **only**
**Date:** 2026-08-04
**Pre-correction baseline:** `9735de1`

---

## 0. Scope discipline

The instruction was to correct **only** the four findings in the second independent review. Nothing else was
touched. Specifically:

| Constraint | Compliance |
|---|---|
| Do not change frozen/ranked documents | **Met.** `git diff 9735de1 -- docs/10-architecture/ docs/00-governance/ docs/30-product/student-management/ docs/30-product/authentication/ docs/30-product/MASTER_PRD.md docs/30-product/library/` → **empty**. The BC Map is byte-identical |
| Do not create/accept ADRs | **Met.** ADR count **18**, unchanged. `F-1` was resolved *by following* an existing precedent, not by minting an ADR |
| Do not modify code | **Met.** `git diff 9735de1 -- lib/ test/ tool/ pubspec.yaml` → **empty**; `flutter analyze` → *No issues found!* |
| Do not invent requirements, traceability or acceptance criteria | **Met.** Every new `MM-AC-*` verifies rule text that already existed at v1.1. The three new identifiers (`MM-BR-035`, `MM-FR-057a`, `MM-GAP-010`) are the *minimum* needed to make existing claims enforceable and existing tensions visible |
| Preserve valid existing requirements | **Met.** **Zero** requirements deleted or weakened. No status value, event, payload, invariant or scope decision changed |
| `F-1`: do not invent a `BC-26` edge; follow the `PRD-004` precedent | **Met.** No edge invented. `BC-26` de-listed exactly as frozen `PRD-004` §7.4 did, tension recorded as `MM-GAP-010` (sibling of `SM-GAP-11`) |
| `F-2`: make the closed-set claim enforceable | **Met.** `MM-BR-035` |
| `F-3`: resolve the `endDate` contradiction consistently | **Met.** `MM-FR-057a` — re-derive the term from a new `startDate`, formula and purity intact |
| `F-4`: improve verification honestly; do not pad | **Met.** 39 criteria, each derived mechanically; grouped criteria and the residual 83 uncovered `MM-FR-*` disclosed rather than hidden |
| Do not freeze PRD-005 | **Met.** Status remains **`DRAFT`**, Stage 2; not registered in `PRD_REGISTRY.md` |
| Do not start implementation | **Met.** No code written |

---

## 1. Files changed

| File | Change |
|---|---|
| `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **Modified** — v1.1 → v1.2. All four findings corrected |
| `docs/30-product/membership-management/PRD-005_F1-F4_CORRECTION_REPORT.md` | **Created** — this report |

**Nothing else.** Two files in total.

---

## 2. Each finding, before and after

### `F-1` — `BC-26` named a consumer with no `BC-02` → `BC-26` edge *(moderate)*

**The defect, reproduced from primary sources.** BC Map **§9** names `BC-26` a consumer of `BC-02` events at lines
409, 410, 412 and 413. But BC Map **§7** — the complete V1 edge table — contains **no `BC-02` → `BC-26` edge**;
`BC-26`'s only inbound edge is `E-26` from `BC-27` AI (line 335). Line 292 states: *"If an edge is not in this table,
it **does not exist** and adding it requires an ADR."*

PRD-005 v1.1 nevertheless named `BC-26` a consumer in **eight** places, and justified it with a sentence that does
not survive checking:

> *"These three events introduce no new edge: `BC-05`, `BC-04`, `BC-03`, `BC-26`, `BC-22` and `BC-24` are all
> reachable on existing `E-07`, `E-02`, `E-03`, `E-20` and `E-23`."*

Destinations of those five edges, extracted mechanically: `E-02` → `BC-04`, `E-03` → `BC-03`, `E-07` → `BC-05`,
`E-20` → `BC-24`, `E-23` → `BC-22`. **None terminates at `BC-26`.** True for five of six named contexts, false for
the sixth.

**The precedent that decides it.** Frozen `PRD-004` §7.4 (L799–815) met the *identical* tension for `BC-01` and
resolved it by **not listing `BC-26`**, emitting nothing extra for it, and recording `SM-GAP-11` for the architecture
owner. `ADR-0018` froze that document with that treatment intact.

| | Before (v1.1) | After (v1.2) |
|---|---|---|
| Header *"Publishes to"* | `… BC-05 Fee & Collection (E-07) · **BC-26 Analytics** · BC-22 Notification` | `… BC-22 Notification (E-23) · BC-24 Audit Trail (E-20)` — with `BC-26` explicitly noted as deliberately not listed |
| `MM-EVT-001` consumers | `BC-05, BC-04, **BC-26**, BC-22` | `BC-05, BC-04, BC-22` |
| `MM-EVT-002` consumers | `BC-04, BC-03, **BC-26**, BC-22` | `BC-04, BC-03, BC-22` |
| `MM-EVT-003` consumers | `BC-05, **BC-26**, BC-22` | `BC-05, BC-22` |
| `MM-EVT-004` consumers | `BC-05, BC-04, **BC-26**, BC-22` | `BC-05, BC-04, BC-22` |
| `MM-EVT-005` consumers | `BC-04, **BC-26**, BC-22` | `BC-04, BC-22` |
| `MM-EVT-007` consumers | `BC-05, **BC-26**, BC-24` | `BC-05, BC-24` |
| Reachability sentence | Claimed `BC-26` reachable on 5 edges — **false** | Names only the five that verify, each mapped to its edge; states `BC-26` is *"not among them"* |
| The Rank 4 tension | **Unmentioned** | New `MM-BR-035` note reproduces it with line numbers, cites the `PRD-004`/`SM-GAP-11` precedent, and records `MM-GAP-010` |
| Conflict register | 7 conflicts | 8 — new **`C-8`** |

**No edge was invented. No ADR was created. The BC Map was not touched. No event, payload or producer changed.**

**Why Analytics loses nothing:** `MM-BR-030` already requires `BC-26` to learn about membership *only* from the §12
events, and all seven are still published to the bus. If the architecture owner resolves `MM-GAP-010` by adding an
edge under an ADR, `BC-26` becomes a listed consumer with **zero** change to any event in this document. That is
stated in the new note so the de-listing cannot be misread as withholding data.

### `F-2` — the *"closed set"* claim was not enforceable *(minor)*

**Before:** §12's heading and §0.2 both declared a closed set of seven events, but a census found **no requirement
enforcing it** — `grep -nE 'MM-(BR|FR)-[0-9]+.*(closed at|requires an ADR|new event)'` returned nothing. The three
*"requires an ADR"* matches were all quotations of BC Map L292 about **edges**. Frozen `PRD-004` shows what was
missing: `SM-7.12` — *"This set **MUST** be closed at **ten** events. A new event requires an ADR."*

By PRD-005's own `MM-NFR-014` (`SID-4.56`), an unenforceable claim is **unmet**.

**After — new `MM-BR-035`:**

> *"The event register above **MUST** be closed at **seven** events. Adding, removing or renaming an `MM-EVT-*`
> **MUST** require a new version of this document, and **MUST NOT** be done by an implementation. Every consumer
> named in the table **MUST** be reachable on an integration edge already declared in `MM-BR-006`; a consumer that is
> not **MUST NOT** be listed here."*

The second sentence deliberately does the work of both `F-1` and `F-2`: it makes the `BC-26` de-listing a **rule**
rather than an editorial choice, so the defect cannot silently return. §12's heading now reads *"closed set (enforced
by `MM-BR-035`)"*, and the prose note states that closure is *"stated as an enforceable requirement… rather than
asserted in prose."* Verified by **`MM-AC-075`** and **`MM-AC-076`**.

**Note on the trigger:** `SM-7.12` requires an ADR for a new event; `MM-BR-035` requires a **new document version**.
This is deliberate and is the weaker, more accurate claim — the review established that BC Map L292's ADR trigger is
**edge-scoped** and does not reach the event register, so requiring an ADR here would assert an obligation no ranked
document imposes. Closure is enforced without over-claiming.

### `F-3` — `MM-CFG-009` contradicted `MM-FR-057` / `MM-FR-058` *(minor)*

**Before**, §10.2 line 898 required that a delayed payment activate *"with the **original** `startDate`… so `endDate`
**MUST** be recomputed from the activation date if `MM-CFG-009` is enabled"*. That breaks two requirements at once:

- `MM-FR-057` — `endDate = startDate + (durationDays − 1)`. Holding `startDate` fixed while moving `endDate` yields a term **longer** than `durationDays`.
- `MM-FR-058` — the computation *"**MUST NOT** depend on the current clock"*. An `endDate` derived from arrival time is clock-dependent.

§4.3 granted no exemption. The prose was also a non-sequitur: the stated goal (not charging for unusable days) is
achieved by moving `startDate`, not by holding it fixed and extending `endDate`.

**After — new `MM-FR-057a`,** stated as an *input* change rather than an exception to the formula:

> *"…the term **MUST** be re-derived by setting `startDate` to the activation date and recomputing `endDate` by the
> **`MM-FR-057` formula unchanged**. The activation date **MUST** be captured once, as `activatedAt`, and passed in
> as the new `startDate` input; the computation itself **MUST** remain the pure function `MM-FR-058` requires. Moving
> `endDate` while holding `startDate` fixed **MUST** be impossible…"*

This resolves the contradiction **consistently** rather than by carving out an exception:

| Requirement | Status after `MM-FR-057a` |
|---|---|
| `MM-FR-057` formula | **Untouched and still universally true** |
| `MM-FR-058` purity | **Preserved** — the activation date enters as a recorded input (`activatedAt`), not a clock call inside the calculation |
| `MM-FR-047` idempotency | **Preserved** — replaying the same activation event yields the same term |
| `MM-INV-002` (`endDate >= startDate`) | **Preserved** for every `durationDays >= 1` |
| Commercial intent | **Preserved** — the student receives the full `durationDays` paid for |

Three dependent sites were aligned so the document cannot disagree with itself: §10.2's row now spells out both
branches and forbids moving `endDate` alone; `MM-CFG-009`'s §13.4 description now reads *"Re-derive the **whole
term**… (`startDate` := activation date, `endDate` by the `MM-FR-057` formula)"*; and §21 edge 13 now says
*"never `endDate` alone"*. Default remains `false`.

### `F-4` — verification coverage 13.8% against a 100% frozen precedent *(minor)*

**Before:** 58 criteria, but coverage of the business-rule, invariant, exclusion, protected-operation and event
registers was **11/80 = 13.8%** — 33 of 34 `MM-BR-*` and 15 of 16 `MM-XC-*` had no verifying criterion — while frozen
`PRD-004` achieves **63/63 = 100%** on the equivalent registers. `MM-NFR-014` therefore declared most of PRD-005's own
rules *unmet*.

**After:** **39** criteria added as §23.1 (`MM-AC-059`…`MM-AC-094`, plus `MM-AC-074a`, `MM-AC-076a`, `MM-AC-080a`).

**Method — mechanical, then filtered for honesty.** The uncovered set was produced by script, not by eye. A criterion
was written **only** where existing rule text is already falsifiable; nothing was invented and no rule was reworded
to make it testable.

| Register | Before | After |
|---|---|---|
| `MM-BR-*` | 1/34 | **35/35** |
| `MM-INV-*` | 2/12 | **12/12** |
| `MM-PO-*` | 2/11 | **11/11** |
| `MM-XC-*` | 1/16 | **16/16** |
| `MM-EVT-*` | 5/7 | **7/7** |
| **Comparable total** | **11/80 = 13.8%** | **81/81 = 100.0%** |
| **All criterion-verifiable obligations** | 63/224 = 28.1% | **140/223 = 62.8%** |

**Where padding was refused, and disclosed in the document:**

- `MM-AC-093` and `MM-AC-094` each verify a **group** of registers, because the underlying obligations are genuinely one test apiece (an authorisation matrix; a set of must-be-impossible constructions). Splitting them into eighteen near-identical rows would have inflated the count to 112 without adding one distinct check.
- `MM-BR-012`, `MM-BR-022`, `MM-BR-027`, `MM-BR-028` were **deliberately not** given new criteria — they are already verified by existing criteria or are restatements whose definition sites are covered.
- The **83** still-uncovered obligations are all `MM-FR-*` detail inside chapters §23's original 58 criteria already exercise. They are **counted in the 62.8%** rather than excluded to flatter the ratio, and §23.1 says so explicitly.

The overall figure is therefore honestly **62.8%, not 100%**, and the document states this rather than claiming
completeness.

---

## 3. Requirement-count changes

| Register | v1.1 | v1.2 | Δ | Nature of change |
|---|---|---|---|---|
| `MM-FR-*` | 118 | **119** | +1 | `MM-FR-057a` (`F-3`) |
| `MM-BR-*` | 34 | **35** | +1 | `MM-BR-035` (`F-1`, `F-2`) |
| `MM-AC-*` | 58 | **97** | +39 | §23.1 (`F-4`) |
| `MM-GAP-*` | 11 | **12** | +1 | `MM-GAP-010` (`F-1`) — **not** an obligation |
| `MM-INV-*` | 12 | 12 | 0 | unchanged |
| `MM-EVT-*` | 7 | 7 | 0 | unchanged — **closure preserved** |
| `MM-XC-*` | 16 | 16 | 0 | unchanged |
| `MM-NFR-*` | 14 | 14 | 0 | unchanged |
| `MM-PO-*` | 11 | 11 | 0 | unchanged |
| `MM-CFG-*` | 9 | 9 | 0 | unchanged (`MM-CFG-009` **description** clarified, count same) |
| **Total** | **290** | **332** | **+42** | |
| **Obligation-bearing** | 279 | **320** | +41 | |

**Zero identifiers were deleted, renumbered or weakened.** Suffixed numbering (`MM-FR-057a`, `MM-AC-074a`/`076a`/
`080a`) follows the convention §0.2 already documents, so **every citation written against v1.0 or v1.1 — in this
document, in the blocker analysis, in either review — still resolves.**

---

## 4. Traceability and verification coverage

| Measure | Before | After |
|---|---|---|
| Acceptance criteria | 58 | **97** |
| Criteria with an empty *Verifies* field | 0 | **0** |
| Dangling AC references | 1 (`MM-GAP-008` cited as a verifiable obligation) | **0** |
| `MM-BR`/`INV`/`PO`/`XC`/`EVT` coverage | 11/80 = 13.8% | **81/81 = 100.0%** |
| All criterion-verifiable obligations | 63/224 = 28.1% | **140/223 = 62.8%** |
| `MM-NFR-014` satisfied across obligation registers | **No** | **Yes** |
| Frozen `PRD-004` traceability | 227/240 = 94.6% | **227/240 = 94.6% — unchanged** |

---

## 5. Validation results

All gates re-run after the final edit. **13 of 13 pass**; the one red gate is pre-existing and unrelated.

| # | Gate | Result |
|---|---|---|
| 1 | Register contiguity, all 10 registers | **PASS** — zero gaps |
| 2 | Declared totals vs actual (332 / 320) | **PASS** — exact match |
| 3 | Comparable-register AC coverage | **PASS** — 81/81 = 100.0% |
| 4 | Overall coverage vs declared (140/223, 62.8%) | **PASS** — exact match |
| 5 | Dangling AC references | **PASS** — none |
| 6 | 97 AC rows, no empty *Verifies* | **PASS** |
| 7 | `BC-26` absent from every event consumer list | **PASS** |
| 8 | Declared AC count (97) | **PASS** |
| 9 | Phantom `MM-FR-119` absent | **PASS** |
| 10 | Frozen/ranked documents unmodified | **PASS** — diff empty; BC Map byte-identical |
| 11 | ADR count | **PASS** — 18, unchanged |
| 12 | `flutter analyze` | **PASS** — *No issues found! (ran in 2.1s)* |
| 13 | `PRD-004` traceability | **PASS** — `TOTAL 251 218 9 13`, unchanged |
| 14 | Repo-wide relative links | **PASS** — 659 links, 0 broken |
| — | `tool/check_module_boundaries.dart` | **RED, PRE-EXISTING** — three `ADR-0012` debts (`BLK-01`). Documentation-only change; code diff empty, so not attributable to this pass. **Not waived** |

### 5.1 Four defects in this correction pass, caught by its own audit

Disclosed rather than absorbed, and all fixed before commit:

1. **A phantom identifier.** Prose justifying `MM-FR-057a`'s suffix referred to `MM-FR-119`, which does not exist — the reference *itself* inflated the register count to 333 against a declared 332. Reworded to *"a non-existent 119th `MM-FR`"*.
2. **Three rules still uncovered** after the first draft of §23.1 — `MM-BR-019`, `MM-INV-008`, `MM-EVT-007`. Added `MM-AC-074a`, `MM-AC-080a`, `MM-AC-076a`. Without this, the claimed 100% would have been 96.3%.
3. **An open question cited as a verifiable obligation.** `MM-AC-088` cited `MM-GAP-008` in its *Verifies* column; a gap is explicitly *not* a requirement. Re-pointed at `MM-INV-002` and `MM-FR-056`.
4. **Overstated coverage.** A draft change-history row claimed *"69.5%"* and *"100% (80/80)"*. Measured values are **62.8% (140/223)** and **100.0% (81/81)**. Corrected everywhere, including §0.2, §23.1, §25.3 and the history row.

Item 4 is the one worth flagging: it is exactly the padding the instruction forbade, caught by measuring instead of
asserting.

---

## 6. What was deliberately **not** changed

- **The BC Map** — not one byte, despite `MM-GAP-010` being a genuine Rank 4 internal tension. It is the architecture owner's to resolve.
- **No ADR** — `F-1` was resolved by *following* frozen `PRD-004`'s precedent, which is precisely the no-ADR path.
- **`MM-GAP-006a` / `MM-GAP-007a`** — still open, still non-blocking, still directed at the BC Map owner.
- **`C-1`** (EA's V2/V3 self-contradiction on Membership Analytics), **`MM-GAP-008`** (single-day plans vs strict `>`), **`MM-GAP-009`** (holidays), **`Q-01`**, **`Q-03`**, **`Q-06`**, **`GCP-05`** — all still recorded, none decided. Out of scope.
- **Frozen `PRD-004`'s own defects** — its §2.2 cites *"BC Map §11 line 209"* (§11 is Multi-Tenancy) and its §7.4 cites *"BC Map §8 convention"* for the event surface, the same mis-citation PRD-005 was corrected for. **It is frozen; not touched.**
- **`PRD_REGISTRY.md`** — PRD-005 remains `PLANNED`. Freeze is conferred, not claimed.
- **Any code** — no implementation started.

---

## 7. Verdict

> ## **READY FOR INDEPENDENT REVIEW**

All four findings are corrected with primary-source evidence, under every stated constraint. `F-1` — the only
moderate finding — is resolved on the frozen `PRD-004` precedent with no invented edge and no ADR. `F-2` and `F-3`
are now enforceable and internally consistent. `F-4` is measured at 100% on the registers the review benchmarked and
honestly reported at 62.8% overall, with the shortfall disclosed rather than concealed.

**Two caveats a next reviewer should test first**, stated plainly because both are judgement calls:

1. **`MM-BR-035` requires a new document version, not an ADR, to change the event set** — deliberately weaker than `SM-7.12`, on the reasoning that BC Map L292's ADR trigger is edge-scoped and does not reach the event register. A reviewer may judge that consistency with the frozen sibling should outweigh that precision.
2. **`MM-AC-093`/`MM-AC-094` verify groups of registers.** This is defended in §23.1 as avoiding padding, but a reviewer may prefer one criterion per obligation and count the 100% as generous. The underlying test count would be unchanged either way.

**PRD-005 is not frozen, not registered and not implemented.** Verdict on the *next* step: independent review.

---

## 8. Document control

| Field | Value |
|---|---|
| Report | `PRD-005_F1-F4_CORRECTION_REPORT.md` |
| Corrected | `PRD-MEMBERSHIP-MANAGEMENT.md` v1.1 → **v1.2**, `DRAFT` |
| Findings addressed | `F-1`, `F-2`, `F-3`, `F-4` — all four |
| New identifiers | `MM-BR-035`, `MM-FR-057a`, `MM-GAP-010`, `MM-AC-059`…`MM-AC-094` (+ `074a`/`076a`/`080a`) |
| Requirements deleted or weakened | **None** |
| Frozen/ranked documents modified | **None** |
| ADRs created | **None** (18, unchanged) |
| Code modified | **None** |
| Validation | 14 gates pass; boundary checker red **pre-existing** |
| Verdict | **READY FOR INDEPENDENT REVIEW** |
