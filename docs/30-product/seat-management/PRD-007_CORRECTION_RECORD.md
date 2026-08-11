# `PRD-007` Seat Management — Targeted Correction Record (`RQ-1` … `RQ-4`)

| Field | Value |
|---|---|
| **Document type** | Correction record — **validation artefact, not part of the specification** |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) `PRD-007` v1.0 `DRAFT` |
| **Authorising review** | [`PRD-007_REQUIREMENTS_REVIEW.md`](PRD-007_REQUIREMENTS_REVIEW.md) — Stage 4, verdict **B — MINOR CORRECTIONS** |
| **Scope** | `RQ-1`, `RQ-2`, `RQ-3`, `RQ-4` only |
| **Date** | 2026-08-10 |
| **PRD hash before** | `623b8945ba03161fda507137315ee04f64cd72e99af9c08036a7441243be386a` |
| **PRD hash after** | `9c32cd4725187cb722d34a56b9fbf5ac7d1658e08f8ca309f8661018c6725c8a` |
| **Diff size** | **15 insertions, 8 deletions, 5 sites, 1 file** |
| **Line count** | 2833 → 2840 (+7) |
| **Registers** | **Unchanged** — no identifier created, deleted or renumbered |
| **Outcome** | `RQ-1` **RESOLVED** · `RQ-3` **RESOLVED** · `RQ-4` **RESOLVED** · `RQ-2` **DEFERRED, no edit** |

---

## 0. What this record is

`PRD_LIFECYCLE.md` Stage 7 L171 permits a clarifying edit that does not change meaning. Every correction below is
either a **clarification of an existing rule** or the **addition of a back-reference to an existing requirement**.
No requirement was created, deleted, weakened or renumbered. No architecture, governance or frozen document was
touched. `SEAT-GAP-001` and `SEAT-GAP-003` remain open and untouched.

This document follows `DOCUMENTATION_BASELINE.md` §3.3's treatment of review artefacts: **a validation record, not
part of the specification.** It confers no rank and freezes nothing.

---

## 1. `RQ-1` — MEDIUM — RESOLVED

### 1.1 The defect, as raised

`SEAT-CFG-017`'s value domain read *"Integer 1–100, **or unset**"* while its Default column read *"**90%**"*.
`SEAT-FR-265` states that an unset configurable **MUST** take its stated default *"except where the default column
says so explicitly"* — and the default column said only `90%`, so the escape clause was **not** triggered. Read
literally, an unset `SEAT-CFG-017` therefore took 90% and emitted `SEAT-EVT-004`. But `SEAT-FR-241`,
`SEAT-FR-267` and `SEAT-AC-170` all require the opposite: **no event while unset, no substituted value.**

Materiality: `SEAT-CFG-017` is the **only** one of 18 configurables whose domain admits `unset`, and per
`SEAT-GAP-005` unset is the **actual V1 state**. The ambiguity sat on the live V1 path.

### 1.2 The correction — a deterministic rule

Two edits, both clarifying, neither creating an identifier.

**Edit 1 — `SEAT-CFG-017` register row (§27.1).** The Default column now states its unset behaviour *explicitly*,
which is precisely the condition `SEAT-FR-265`'s escape clause requires:

> `**Unset in V1 — no event is emitted and no value is substituted**` (explicit unset behaviour per `SEAT-FR-265`);
> `**90%**` applies only once `E-05` carries the threshold (`SEAT-GAP-005`)

`Defined at` extended from `§24.1, SEAT-FR-241` to `§24.1, SEAT-FR-241, SEAT-FR-265, SEAT-FR-267`.
**Value domain left unchanged** at *"Integer 1–100, or unset"* — it was never wrong; only the default was silent.

**Edit 2 — `SEAT-FR-265` (§27), appended to the existing paragraph.** No new identifier; the rule is folded into
the requirement that owns it:

> Exactly one row exercises that escape clause — `SEAT-CFG-017`, the only configurable in §27.1 whose value domain
> admits `unset` — and its Default column states its unset behaviour explicitly. The resolution is therefore
> deterministic and admits no substitution: where `SEAT-CFG-017` is **unset** no threshold exists, `SEAT-EVT-004`
> is **never** emitted at any occupancy value including 100%, and the **90%** figure **MUST NOT** be applied as a
> fallback (`SEAT-FR-241`, `SEAT-AC-170`); where it is **set** to an integer in 1–100 that value is the threshold
> and `SEAT-EVT-004` is emitted on a crossing of it (`SEAT-FR-242`, `SEAT-AC-169`). **90%** becomes the applicable
> default only once the threshold is carried by the `E-05` contract; until that confirmation it is a documented
> proposal, not an active default (`SEAT-FR-267`, `SEAT-GAP-005`).

### 1.3 Why this shape, and not another

- **A new `SEAT-FR-265a` was drafted and then reverted.** It would have created an identifier outside §0.3's
  declared contiguous range `SEAT-FR-001 … SEAT-FR-304`, which states *"Ranges are contiguous. Numbers are never
  reused."* A Stage 5 mechanical scan would have flagged it, and §0.3 would have needed editing too — a larger diff
  for no behavioural gain.
- **Deleting `or unset` from the value domain was rejected.** That would have *weakened* `SEAT-FR-241` and
  contradicted `SEAT-GAP-005`, which is the whole reason `unset` exists.
- **Changing `SEAT-FR-241`'s "default 90%" wording was rejected.** It is accurate about the *proposed* default and
  is an explicit preserve target.

### 1.4 The four-state test — as required

| State of `SEAT-CFG-017` | Rule now applied | `SEAT-EVT-004` | Authority |
|---|---|---|---|
| **`unset`** | No threshold exists. 90% **MUST NOT** be substituted | **Never emitted**, even at 100% | `SEAT-FR-265` (as corrected), `SEAT-FR-241`, `SEAT-FR-267`, `SEAT-AC-170` |
| **`1`** | In domain. Threshold = 1% | Emitted on the upward crossing of 1% | `SEAT-CFG-017` domain, `SEAT-FR-242` |
| **`90`** | In domain. Threshold = 90%. Also the value that applies once `E-05` carries it | Emitted once on the crossing, not per change while above; re-arms on downward re-crossing | `SEAT-FR-242`, `SEAT-AC-169` |
| **`100`** | In domain (upper bound). Threshold = 100% | Emitted on reaching 100% **only when set**; when unset, 100% emits nothing | `SEAT-CFG-017` domain, `SEAT-AC-170` |

**No state is now ambiguous, and no two statements in the PRD disagree about any of the four.**

Measured evidence (post-edit):

```
L1855  where `SEAT-CFG-017` is **unset** no threshold exists
L1856  `SEAT-EVT-004` is **never** emitted at any occupancy value including 100%
L1857  the **90%** figure **MUST NOT** be applied as a fallback
L1858  set to an integer in 1–100 → that value is the threshold, emitted on a crossing
L1882  register row: Default states unset behaviour explicitly
L2521  SEAT-AC-170  unset → occupancy rises to 100% → no SEAT-EVT-004   [UNCHANGED]
L2520  SEAT-AC-169  threshold 90% → crossing → emitted once             [UNCHANGED]
```

### 1.5 Preserve targets — verified verbatim, byte-identical

| Target | Line | Status |
|---|---|---|
| `SEAT-FR-241` | 1668–1670 | **Unchanged** |
| `SEAT-FR-267` | 1899–1902 | **Unchanged** |
| `SEAT-AC-169` | 2520 | **Unchanged** |
| `SEAT-AC-170` | 2521 | **Unchanged** |
| `SEAT-GAP-005` | 2221 | **Unchanged** |

No ADR is required: the correction changes no `E-05` payload, no BC Map edge and no ownership. `SEAT-GAP-005`
remains the open architectural question, still owned by Architecture, still with impact *"None — `SEAT-FR-241`
emits nothing while unset."*

---

## 2. `RQ-3` — LOW — RESOLVED by citation, not by fabrication

### 2.1 The finding, and what investigation actually showed

`RQ-3` recorded that 7 of 12 `SEAT-NFR-*` carried no acceptance criterion, and named `SEAT-NFR-007` and
`SEAT-NFR-009` as the two that are behavioural and testable.

Investigation established that **the behaviour was already tested — only the back-reference was missing.** No test
was absent; the traceability link was.

### 2.2 The correction — four existing rows, no new criteria

| AC | Behaviour it already tested | Citation added | Why exact |
|---|---|---|---|
| `SEAT-AC-108` | *"A check-in already processed / the same event is redelivered / the count is unchanged — idempotent by event identifier"* | `SEAT-NFR-007` | `SEAT-NFR-007` demands tolerance of **duplicate** `E-08` delivery. This row *is* the duplicate-delivery test |
| `SEAT-AC-111` | *"A missed or stale `E-08` event / occupancy is recomputed / it converges…"* | `SEAT-NFR-007` | `SEAT-NFR-007` demands tolerance of **out-of-order/stale** delivery without a wrong count |
| `SEAT-AC-125` | *"100 rows, row 57 duplicate / no row is applied"* | `SEAT-NFR-009` | `SEAT-NFR-009` demands bulk operations *"complete or fail as a unit"*. This is the all-or-nothing test |
| `SEAT-AC-130` | *"bulk reassignment of 10, student 4 invalid / no reassignment is applied"* | `SEAT-NFR-009` | Same unit-of-work property on the reassign path |

**Zero new acceptance criteria. The AC register remains at exactly 225**, so §0.3's declared range
`SEAT-AC-001 … SEAT-AC-225` needed no edit.

### 2.3 What was deliberately *not* claimed

`SEAT-NFR-009` also requires atomicity *"at the maximum row count the entitlement permits"* and forbids holding a
lock that blocks counter operations. **No existing AC tests the maximum-row-count or lock-contention limb**, and
none was invented. `SEAT-NFR-009` is therefore **partially**, not fully, covered. Recorded here honestly rather
than reported as closed.

Coverage delta, measured:

```
before:  NFR-002=1 NFR-005=1 NFR-006=2 NFR-008=2 NFR-010=1   → 5 of 12 NFRs cited
after:   + NFR-007=2  NFR-009=2                              → 7 of 12 NFRs cited
```

`SEAT-NFR-001/003/004/011/012` remain uncited — correctly. `SEAT-NFR-004` forbids stating a local figure;
`SEAT-NFR-003` defers to frozen `MM-NFR-011`; `SEAT-NFR-011`/`012` are meta-requirements about the document.
Fabricating criteria for these was the exact outcome the instruction forbade.

---

## 3. `RQ-2` — LOW — **NO EDIT MADE. Deferral retained.**

`RQ-2` recorded that 18 of 24 `SEAT-PO-*` protected operations carry no acceptance criterion.

**I did not correct this, and the instruction is the reason.** The candidate rows were examined
(`SEAT-AC-030`, `SEAT-AC-153`, `SEAT-AC-194`, `SEAT-AC-195`, `SEAT-AC-196`). Each tests something *other* than the
permission grid:

- `SEAT-AC-030` tests **gate step G7** (membership validity), not a role grant. It already cites `SEAT-BR-014`,
  `SEAT-XC-004` correctly.
- `SEAT-AC-153` tests `SEAT-INV-008` immutability of a released allocation — no `SEAT-PO-*` governs it.
- `SEAT-AC-196` tests `SEAT-FR-273`, Platform Support holding no operation by default.

Attaching a `SEAT-PO-*` number to these rows would have raised the measured coverage percentage while testing
nothing new — **decorative citation**, which is precisely the artificial inflation the instruction prohibits:
*"Coverage percentage badhane ke liye artificial requirements/AC mat banao."*

`RQ-2` therefore remains **open and non-blocking**, and it satisfies the Stage 4 gate's own escape at
`PRD_LIFECYCLE.md` L118 — *"conflicts closed or explicitly deferred with a reason and an owner"*:

| Field | Value |
|---|---|
| **Reason** | Correcting it requires authoring genuinely new criteria, which exceeds a targeted-correction mandate and is Stage 6 task-authoring work |
| **Owner** | `PRD-007` author, at Stage 6 |
| **Mitigation, measured** | §28.2 matrix is 24 rows × 4 role columns, **fully populated**, **zero undefined cells** — materially better than `PRD-004`, which shipped two literal `**GAP**` cells (`RF-12`). Nine role-behaviour criteria exist |
| **Blocking?** | **No** |

---

## 4. `RQ-4` — LOW — RESOLVED

L31 cited `§43` in a document with 36 sections, so the reference could not resolve internally.

**Before:** *"This constraint is the source draft's §43, retained verbatim in intent."*

**After:** *"This constraint is the source draft's §43 — that number is the source draft's own numbering, not a
section of this document, which has 36 sections — retained verbatim in intent."*

The mechanical scan still reports `unresolvable: 1 ['43']`, and that is now **correct behaviour**: the scanner
resolves `§` refs against this document's headings, and `§43` deliberately belongs to another document. The
ambiguity a reader faced is gone; the detector hit is an expected artefact, documented here so no future reviewer
re-raises it.

---

## 5. Verification results

### 5.1 Register integrity — unchanged

| Register | Declared §0.3 | Measured after | Max | Verdict |
|---|---|---|---|---|
| `SEAT-FR-*` | 001…304 | **304** | 304 | ✅ |
| `SEAT-BR-*` | 001…045 | **45** | 045 | ✅ |
| `SEAT-INV-*` | 001…014 | **14** | 014 | ✅ |
| `SEAT-EVT-*` | 001…004 | **4** | 004 | ✅ |
| `SEAT-XC-*` | 001…022 | **22** | 022 | ✅ |
| `SEAT-PO-*` | 001…024 | **24** | 024 | ✅ |
| `SEAT-CFG-*` | 001…018 | **18** | 018 | ✅ |
| `SEAT-NFR-*` | 001…012 | **12** | 012 | ✅ |
| `SEAT-AC-*` | 001…225 | **225** | 225 | ✅ |
| `SEAT-GAP-*` | 001…014 | **14** | 014 | ✅ |

Table-row counts confirm the same: **225 AC rows, 18 CFG rows.** No renumbering. No deletion.

### 5.2 Mechanical scan — no new failures

| Check | Before | After | Verdict |
|---|---|---|---|
| Registers contiguous | PASS | **PASS** | ✅ |
| No identifier undefined | PASS (0) | **PASS (0)** | ✅ |
| No orphan acceptance criteria | PASS (0) | **PASS (0)** | ✅ |
| No dangling citations | PASS (0) | **PASS (0)** | ✅ |
| BR/INV/EVT/XC fully AC-covered | PASS (85/85) | **PASS** | ✅ |
| Identifier double-defined | 14 flagged | **14 flagged** | ⚠ unchanged — all 14 adjudicated line-wrap artefacts (`RQ-R4`) |
| Vague language | 1 flagged | **1 flagged** | ⚠ unchanged — `SEAT-NFR-003` quotes frozen `MM-NFR-011` (`RQ-R1`) |
| Section refs resolve | 1 flagged | **1 flagged** | ⚠ unchanged — `§43`, now explicitly labelled foreign (§4 above) |

**Three flags before, the same three after. No new flag introduced.**

### 5.3 Duplicate-citation scan

Eight AC rows report a repeated identifier (`SEAT-AC-033`, `053`, `056`, `060`, `062`, `080`, `224`, `225`). All
eight were verified **byte-identical in `HEAD`** — pre-existing, caused by the identifier appearing in both the
scenario text and the *Verifies* column. **None is an edited row.** Out of scope; recorded, not touched.

The four edited rows carry no duplicate:

```
SEAT-AC-108  FR-111 FR-205 NFR-007
SEAT-AC-111  FR-115 FR-116 NFR-006 NFR-007
SEAT-AC-125  BR-028 FR-172 NFR-009
SEAT-AC-130  BR-029 FR-177 NFR-009
```

### 5.4 Stage 3 regression — no decision regressed

| Surface | Stage 3 record | After correction | Verdict |
|---|---|---|---|
| Edges cited | 13, all ⊂ 26 declared, 0 invented | **13, identical set** `E-01 E-02 E-03 E-04 E-05 E-08 E-13 E-17 E-18 E-19 E-20 E-21 E-23` | ✅ |
| `E-05` payload | Not modified; threshold remains a *proposal* | **Unchanged** — `SEAT-FR-266`, `SEAT-FR-267` untouched | ✅ |
| `SEAT-GAP-001` | False positive, left open | **Untouched** | ✅ |
| `SEAT-GAP-003` | Genuine, non-blocking, left open | **Untouched** | ✅ |
| `SEAT-GAP-005` | Open, owned by Architecture | **Untouched, now cited more precisely** | ✅ |
| Scope register | `self` / `guardianOf` / `tenantWide` only | **Unchanged** | ✅ |
| Tenant isolation | 12 tenant-bearing surfaces | **Unchanged** — no tenant text edited | ✅ |
| Section headings | 136 | **136** | ✅ |
| `SEAT-XC-021` declines `E-21` | Held | **Unchanged** | ✅ |

The correction touched **no** security, tenancy, authorisation or edge-contract text. The only requirement-bearing
sentence changed is `SEAT-FR-265`, which gained precision about a case three other requirements already governed.

### 5.5 Files changed

```
docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md      | 15 +, 8 -   (corrected)
docs/30-product/seat-management/PRD-007_CORRECTION_RECORD.md | new        (this record)
```

Verified **not** modified: all of `docs/10-architecture/`, all ADRs, `MASTER_PRD.md`, `PRD_LIFECYCLE.md`,
`DOCUMENTATION_BASELINE.md`, `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, every other PRD including both frozen
ones, `lib/`, `test/`, `pubspec.yaml`.

### 5.6 Status and version

Deliberately **not** changed. The PRD remains **v1.0 `DRAFT`**, Stage 2 per its own header. `PRD_LIFECYCLE.md`
L171 attaches a changelog duty to a **frozen** document; this one is not frozen, and §35 is a change log *against
the source draft*, not a version history. Bumping either would be a claim this correction does not earn.

---

## 6. Stage 4 re-review readiness — the honest answer

**`RQ-1` is resolved and I consider it closed.** The MEDIUM contradiction that produced verdict **B** no longer
exists: all four configurable states are deterministic, and the five preserve targets are byte-identical.

**`RQ-3` is resolved as raised, but `SEAT-NFR-009` is only partially covered** — the maximum-row-count and
lock-contention limbs remain untested, by choice.

**`RQ-4` is resolved.**

**`RQ-2` is NOT corrected.** It stands as an explicit deferral with a reason and an owner, which the Stage 4 gate
permits at L118. A re-reviewer is entitled to weigh that differently than I did.

**Readiness: the PRD is ready to be *submitted* for an independent Stage 4 re-review. It is not for me to declare
that re-review passed.** The blocking defect is gone and the two residual items are LOW and documented, so a
re-review starts from a materially better position than verdict **B**. But `RQ-2` is still open, `SEAT-NFR-009` is
still partial, and `SEAT-GAP-001`/`SEAT-GAP-003` are still open by instruction. **An independent reviewer, not the
author of the correction, decides the verdict.** I am not recording a PASS or an **A**.

### 6.1 Observation raised, not corrected — out of scope

§0.3 states that `SEAT-GAP-*` identifiers *"must never be cited as verifiable"*, yet `SEAT-AC-170` cites
`SEAT-GAP-005` in its *Verifies* column. This is **pre-existing**, is **not** part of `RQ-1`…`RQ-4`, and
`SEAT-AC-170` was an explicit preserve target. Flagged for a future reviewer; deliberately not touched.

---

## 7. What this correction did not do

- Did not rewrite or restructure the PRD
- Did not delete or weaken any requirement, capability or exclusion
- Did not renumber any identifier, or create one
- Did not create an ADR, Specification, API spec, DB schema or code
- Did not perform Stage 5, 6 or 7 work — no traceability registration, no `IMPL-*` allocation, no freeze
- Did not modify any architecture, governance or frozen document
- Did not resolve `SEAT-GAP-001` or `SEAT-GAP-003`
- Did not change the PRD's status, version or rank
- Did not force a PASS verdict
