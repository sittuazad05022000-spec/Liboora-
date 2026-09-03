# TESTING REQUIREMENTS — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) ·
[`../IMPLEMENTATION/TRACEABILITY_MATRIX.md`](../IMPLEMENTATION/TRACEABILITY_MATRIX.md) **§2R**.

---

## 1. What must be tested — the measured basis

**123 acceptance criteria** are the testable obligations of `PRD-021C` C0–C8.
Every one maps to at least one requirement — **123/123, 0 orphans**
(Matrix **§2R**, Stage-4 check 4).

| Part | Register stem | Own ACs |
|---|---|---|
| C1 Marketplace Foundation | `LMP-AC-*` | **12** |
| C2 Search & Local Discovery | `LSD-AC-*` | **16** |
| C3 Library Public Profile | `LPP-AC-*` | **22** |
| C4 Live Seat Availability & Booking | `LSB-AC-*` | **18** |
| C5 Ratings & Reviews | `LRR-AC-*` | **12** |
| C6 Discovery Presentation | `LDR-AC-*` | **14** |
| C7 Trust & Safety Integration | `LTS-AC-*` | **13** |
| C8 Technical & Production Architecture | `LMT-AC-*` | **16** |
| **Total** | | **123** |

⛔ **These 123 are the test basis. Do not add a 124th** as though it were an
acceptance criterion of `PRD-021C` — the registers are frozen and contiguous
(Matrix **§2R**: *"30 of 30 registers contiguous from `001` to their stated
maximum, with no exception to preserve"*).

---

## 2. ⚠⚠ Coverage is 81.4%, and that number must not be "fixed"

From Matrix **§2R** (v1.23, **L2721** onward):

| Measure | Value |
|---|---|
| Identifiers | **528** across **30** registers, all contiguous |
| Normative requirements | **258** (`*-FR-*` **220** + `*-BR-*` **38**), on **own-stem occupancy** |
| Exclusions | **118** own-stem `*-XC-*` |
| Acceptance criteria | **123** — forward coverage **123/123, 0 orphans** |
| **Reverse coverage** | **210 / 258 = 81.4%** — ⚠ **48 uncovered** |

⭐⭐ **48 normative requirements have no acceptance criterion, and this was
registered rather than repaired.** That is deliberate, and Matrix **§2O.2**
records the reasoning that governs it:

> minting identifiers to move a percentage is the same act at larger scale

**What this means for you as a test author:**

- ✅ Implement tests for the **123** ACs that exist.
- ✅ If you find an untested requirement among the **48**, that is a **known,
  registered condition** — record it, do not resolve it by inventing an AC.
- ⛔ **Do not mint a new `*-AC-*` identifier to raise the coverage number.** The
  percentage is a *measurement*, not a target. Moving it by minting is the defect
  the frozen matrix names.
- ⛔ Do not edit `TRACEABILITY_MATRIX.md` to change the figure.

### 2.1 ⚠ Denominator discipline — 258 vs 263

Matrix **§2R** records **two** figures and keeps them apart:

> **258** … counted on **own-stem occupancy**. ⚠ The whole-text figure is **263**;
> the two are different denominators and §2R.2 keeps them apart.

⛔ Do not average, reconcile or silently substitute one for the other. If you
recompute coverage and get a different percentage, check which denominator you
used before concluding anything has changed.

---

## 3. ⭐⭐ The C5 absence tests — the most unusual requirement here

C5 Ratings & Reviews is **V2 on two frozen authorities**
(`Library_PRD_v1.md` **L1016** and `ARCHITECTURE_RULINGS.md` **§6 L291**, whose
heading is *"Explicitly deferred — **do not invent**"*). C5 therefore authored
**no capability**, and C8 **`LMT-FR-001`** refuses to specify runtime
architecture for it, because *"an architecture section for a non-existent
capability would be precisely the defect C5 refused to create."*

**So what is there to test?** ⭐ **The absence itself.** Four implementation tasks
exist for exactly this:

| Task | Group | Nature |
|---|---|---|
| `IMPL-1775` … `IMPL-1778` | **G5 — C5** | ⭐ **Absence tests** |

**What an absence test asserts.** Not *"the rating feature works"* — there is no
rating feature. It asserts that the rating capability **is not present**, and
cannot appear by accident:

| ✅ The test should assert | ⛔ It must not |
|---|---|
| No rating value is stored, read or rendered anywhere on a marketplace surface | Assert a rating equals zero — that would *create* a rating with value 0 |
| No rating field appears in any composed read | Provide a stub rating for the test to pass against |
| No ordering, filter or badge derives from a rating | Test a "disabled" rating UI — a disabled control advertises the capability |
| No review text is accepted, stored or displayed | Add a feature flag guarding a rating feature — the feature must not exist to guard |

⭐⭐ **Why absence tests are the right instrument.** A deferred capability
normally re-appears by drift: a helpful placeholder, a nullable column added "for
later", a greyed-out star widget. An absence test converts *"we agreed not to
build it"* into a **failing build** if someone does. It is the same discipline
that C6 applied when it named its withdrawn slot **by number only** — the
emptiness is recorded, so it can be checked.

⚠ **Note the parallel with `UniqueViewers`.** `LMT-XC-018` forbids rendering it
as zero, unknown, placeholder, "coming soon", disabled, blurred, teased or
estimated. That is the same class of prohibition, and it too is testable by
asserting absence rather than a value. See
[`ANALYTICS_AND_OBSERVABILITY.md`](./ANALYTICS_AND_OBSERVABILITY.md) §2.

---

## 4. Exclusions are testable — 118 of them

**118** own-stem `*-XC-*` exclusions exist. An exclusion is a **prohibition**, and
a prohibition is testable by the same absence discipline as C5.

The highest-value exclusion tests, drawn from the parts:

| Exclusion | What to assert |
|---|---|
| `LMT-XC-008` / `LMT-XC-009` | **0** new events, **0** new edges. Edge set remains **29**; `E-27` vacant; ⛔ no `E-31` |
| `LMT-XC-010` | `E-30`'s payload carries library + time and ⛔ **no viewer identity in any form** |
| `LMT-XC-013` | ⛔ No offset pagination, page number or total-count guarantee is exposed |
| `LMT-XC-014` | ⛔ No role, permission, scope, policy language or consent mechanism is defined |
| `LMT-XC-018` | ⛔ No metric is computed or aggregated on a marketplace surface; `UniqueViewers` renders in **no** form |
| `LMT-XC-019` / `LMT-XC-020` | ⛔ No second analytics/search/media/audit/authorization/safety/config/job system |
| `LMT-XC-006` | ⛔ No index, analyzer, tokenizer, synonym list, relevance formula or query rewriter |
| `LMT-XC-016` / `LMT-XC-017` | ⛔ No minted latency/SLO/TTL/timeout number; ⛔ no cache tier or read replica |
| `LSD-XC-002` | ⛔ No second ranking or relevance system |
| `LSD-XC-008` | Occupancy not disclosed *"by value **or by inference**"* — ⭐ so test the **inference** route too |
| `LMT-XC-007` | ⛔ No `StudentRecordId` reaches `BC-10`…`BC-17` |
| `LMT-FR-025` | ⛔ No local write buffer, store-and-forward queue or offline mutation log |

⚠ **`LSD-XC-008` deserves its own test design.** Suppressing a value while
leaking it through ordering, grouping, counts, error text or timing is still
disclosure — C6 **§4.4** puts it exactly: *"Hiding the seat count and then
sorting by it publishes the same fact in a different alphabet."* A test that only
checks the field is absent will pass while the leak remains.

---

## 5. Test areas by topic

Composed from the frozen requirements; each links to the developer document that
states the rule.

| Area | What must be verified | Reference |
|---|---|---|
| **Tenant isolation** | ⭐⭐ Highest severity. Missing tenant context **fails loudly**, ⛔ never defaults; ⛔ no query joins the untenanted public index to tenanted rows; no leak **by value or inference** | [`OWNERSHIP_AND_DATA.md`](./OWNERSHIP_AND_DATA.md) §4 |
| **Authorization** | Server-side `BC-18` decision **per request, per object**; ⛔ never inferred from possession of an identifier | [`AUTHORIZATION_AND_SECURITY.md`](./AUTHORIZATION_AND_SECURITY.md) §3 |
| **Anonymous public access** | Public browsing works with **no** authentication; ⛔ no personalisation; same results regardless of caller | `LMT-FR-017`, `LSD-FR-032` |
| **Rate limiting** | Per origin; ⛔ the mechanism must not identify or re-identify the visitor | `LMT-FR-020`, `LIB-14B.42` |
| **Event consumption** | Consumers **idempotent on `eventId`** with a processed-events table; duplicates tolerated; ⛔ no assumption of global ordering | [`INTEGRATIONS_AND_EVENTS.md`](./INTEGRATIONS_AND_EVENTS.md) §4 |
| **Rebuildability** | ⭐ `BC-26` projections and `BC-23` indexes rebuildable from the log — **tested quarterly** per the inherited contract | `LMT-FR-010` |
| **Ordering determinism** | Same query → same order; tie-break **stable, opaque, non-semantic**; ⛔ not random/time/session/viewer-seeded | [`SEARCH_RANKING_AND_DISCOVERY.md`](./SEARCH_RANKING_AND_DISCOVERY.md) §4 |
| **Sort key disclosure** | The sort key in force is **published to the user** (`LSD-FR-026`) | C2 §7 |
| **Degraded modes** | ⭐⭐ All five rows of C8 **§10.3** — each must **omit or truthfully relabel** | [`ERROR_AND_FAILURE_HANDLING.md`](./ERROR_AND_FAILURE_HANDLING.md) §3 |
| **Cursor integrity** | Malformed/expired cursor → **domain error**, ⛔ never a silent reset; cursor leaks no key/offset/table/index | C8 §9.3 |
| **Booking boundary** | ⛔ The marketplace performs **no** booking write; `BC-04` owns it | [`ARCHITECTURE_AND_BOUNDARIES.md`](./ARCHITECTURE_AND_BOUNDARIES.md) §4.1 |
| **Safety boundary** | Report **entered**, ⛔ never **decided**; when `BC-13` is down the UI ⛔ must not claim a case was opened | `AUTHORIZATION_AND_SECURITY.md` §5.1 |
| **Audit** | ⛔ **No** audit entry for an anonymous public view; ⛔ audit never called synchronously | `ANALYTICS_AND_OBSERVABILITY.md` §5 |
| **Media** | Only `FileRef`s held; ⛔ no bytes, no raw storage path, ⛔ no marketplace-side copy | `LMT-FR-005`, `LMT-XC-005` |
| **C5 absence** | ⭐ The four absence tests, `IMPL-1775`…`IMPL-1778` | §3 above |

---

## 6. ⚠ Reproducibility of the Stage-5 figures — an honest limitation

The Stage-5 measurements in Matrix **§2R** were produced by six purpose-built
instruments under `tool/docs_check/prd021c_*.py`. ⚠ **Those instruments were
deliberately NOT committed.**

⭐ **The consequence, stated plainly:** the figures — **528**, **258**, **123**,
**118**, **210/258 = 81.4%**, **48** — are reproducible **in principle** from the
frozen documents by re-deriving them, but **not** by re-running a committed
script.

✅ Every figure in this document was **independently re-derived from the frozen
files** while writing it, and each matched the registered value.

⛔ Do not treat the absence of the instruments as licence to change a figure. ⛔
And do not modify any script under `tool/docs_check/` — the repository's
validators are out of scope for this package.

⚠ **Note on the existing validator suite.** The repository's documentation checks
run **31** validators with **25** passing and **6** failing, and all **6**
failures are **pre-existing and unrelated to `PRD-021C`**
(`alignment_record_freshness.py`, `prd004_traceability.py`,
`prd005_traceability.py`, `prd006_traceability.py`, `prd007_traceability.py`,
`prd020_stage5.py`). ⭐ `prd020_stage5.py`'s failure list prints in a **different
order** on different runs, so it must be compared as a **set**, not as a diff —
otherwise it falsely appears to be a regression.

---

## 7. What is NOT specified — and must not be invented

| Question | Why it is absent | ⛔ Do not |
|---|---|---|
| Coverage **thresholds** (e.g. "80% line coverage") | No numeric budget is minted — `LMT-XC-016`'s reasoning applies: an invented number is *"an unowned obligation that no operator agreed to"* | Invent a gate percentage and present it as required |
| Test **framework**, runner, harness | ⛔ Not authored by `PRD-021C`; existing repository conventions govern | Introduce a second test stack |
| Performance / load test targets | ⛔ No latency, throughput or percentile SLO exists | Write a load test against a self-chosen threshold |
| Test data for ratings | ⛔ The capability does not exist | Create rating fixtures — that would defeat the absence tests |
| Test data implying live occupancy | ⛔ Live occupancy is **V2**, *"must not be invented"* | Fixture a live seat count |
| A `UniqueViewers` fixture | ⛔ **NOT CERTIFIED** (`ADR-0097`) | Fixture it, even as zero |

---

## 8. Self-check for a test suite claiming `PRD-021C` conformance

1. **Are all 123 ACs covered?** Forward coverage is **123/123** in the matrix —
   the tests should match it.
2. **Have I minted any new `*-AC-*`?** ⛔ If yes, remove it.
3. **Have I changed a matrix figure?** ⛔ If yes, revert it.
4. **Do the C5 tests assert absence, or do they assert a value?** Asserting
   `rating == 0` **creates** a rating. It must assert *not present*.
5. **Do the exclusion tests check the inference route**, not just the field?
6. **Does a tenant-context test assert a loud failure**, rather than a default?
7. **Does an authorization test attempt access by possession of a valid
   identifier** and expect denial?
8. **Do the degraded-mode tests assert omission or relabelling** — and explicitly
   assert that a zero, a placeholder and a cached value do **not** appear?
9. **Does a `BC-13`-down test assert the UI says the report failed?**
10. **Does an audit test assert that an anonymous public view produces no audit
    entry?**
11. **Have I modified anything under `tool/docs_check/`?** ⛔ Out of scope.

---

## 9. Open items in this area

| Item | Status | Owner |
|---|---|---|
| **48 uncovered normative requirements** (reverse coverage **210/258 = 81.4%**) | ⚠ **REGISTERED at its measured value** — ⛔ **not** to be repaired by minting (§2O.2) | Recorded in Matrix §2R |
| Stage-5 instruments `tool/docs_check/prd021c_*.py` **not committed** | ⚠ **Disclosed** — figures reproducible in principle, not by script | — |
| 6 pre-existing validator failures | ⚠ **Pre-existing, unrelated to `PRD-021C`** — 0 regressions | Respective PRD owners |
| `IMPL-1424` blocked by `TSF-GAP-009` | **OPEN, INHERITED from `PRD-020`** | Architecture Owner with `BC-19` owner |

⛔ **Stage 8 implementation has NOT been performed.** **No test described here has
been written.** **0** lines of application code and **0** lines of test code exist
for `PRD-021C`.
