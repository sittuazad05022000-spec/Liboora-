# PRD-007 Seat Management — Final Stage 4 Findings Correction

| Field | Value |
|---|---|
| **Corrects** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, v1.0 `DRAFT` |
| **Source of findings** | [`PRD-007_STAGE4_FINAL_REVIEW.md`](PRD-007_STAGE4_FINAL_REVIEW.md) — verdict **B — MINOR CORRECTIONS**, 2 LOW |
| **Findings corrected** | `FR-1`, `FR-2` — both, in one pass |
| **PRD commit before** | `789b9f428f0c9d1bbee52918d3575df7a9da8c0f` |
| **PRD hash before** | `6d87a05dfd6dd9b921129c984844a4d3669896f491a509c2c41c53db049f350a` |
| **PRD hash after** | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` |
| **PRD size** | 2,847 → 2,851 lines (+4, all inside `SEAT-FR-241`) |
| **Edit sites** | 4 — one prose requirement, three acceptance-criterion `Verifies` cells |
| **ADR required** | **No** — see §5 |
| **Status of this record** | Correction record. Validation artefact, **not part of the specification** (`DOCUMENTATION_BASELINE.md` §3.3) |

---

## 0. Scope of this pass

This pass corrects exactly the two LOW findings raised by the final independent Stage 4 review and nothing else. No
requirement was added, removed, renumbered or weakened; no register changed size; no architecture decision, Rank-1
rule, integration edge, tenancy rule or security boundary was touched. `SEAT-GAP-001` and `SEAT-GAP-003` remain open
and unmodified.

This record does **not** re-run the Stage 4 review, does not declare Stage 4 PASS, and does not authorise Stage 5.
Judging whether these corrections close the review is the reviewer's or owner's call, not this record's.

---

## 1. `FR-1` — `SEAT-FR-241` called 90% a default

### 1.1 The defect

`SEAT-FR-241` described **90%** as the `default` of `SEAT-CFG-017`. Four normative statements elsewhere in the same
document forbid applying it:

| Site | Statement |
|---|---|
| `SEAT-FR-212` (L1482) | *"the **90%** figure **MUST NOT** be substituted as a fallback"* |
| `SEAT-CFG-017` (register row) | Default = *"**Unset in V1 — no event is emitted and no value is substituted**"* |
| `SEAT-FR-265` (L1859–1864) | *"**90%** becomes the applicable default only once the threshold is carried by the `E-05` contract; until that confirmation it is a documented proposal, not an active default"* |
| `SEAT-FR-241` itself | *"the module **MUST NOT** substitute a hard-coded value"* — contradicting its own parenthetical |

Stage 4 check 3 requires every configurable to have **a** default — one, deterministic. Two readings of the same
value is a specification hole, and this was the sole unqualified site in 2,847 lines.

### 1.2 Before

```
`SEAT-FR-241` — The occupancy threshold that triggers `SEAT-EVT-004` **MUST** be configurable
(`SEAT-CFG-017`, owner `BC-06` via `E-05`, default **90%** of the branch's active seat count). Where the threshold
is unset, no threshold event is emitted; the module **MUST NOT** substitute a hard-coded value.
```

### 1.3 After (L1672–1678)

```
`SEAT-FR-241` — The occupancy threshold that triggers `SEAT-EVT-004` **MUST** be configurable
(`SEAT-CFG-017`, owner `BC-06` via `E-05`). **90%** of the branch's active seat count is the value *proposed* for
that contract to carry; it becomes applicable only once `E-05` actually carries it, and until then it is a documented
proposal, **not** a default this module applies (`SEAT-FR-212`, `SEAT-FR-265`, `SEAT-CFG-017`, `SEAT-GAP-005`). Where
the threshold is unset no threshold event is emitted at any occupancy value (`SEAT-AC-170`); where it is set to an
integer in 1–100 that value is the threshold and `SEAT-EVT-004` is emitted on a crossing of it (`SEAT-AC-169`). The
module **MUST NOT** substitute a hard-coded value.
```

### 1.4 What changed and what deliberately did not

| Aspect | Disposition |
|---|---|
| Threshold **behaviour** | **Unchanged.** Both branches state exactly what `SEAT-FR-212`, `SEAT-CFG-017` and `SEAT-FR-265` already required |
| The `MUST` obligation ("MUST be configurable") | **Unchanged**, still first clause |
| The `MUST NOT` obligation | **Unchanged**, retained verbatim as the closing sentence |
| The **90%** figure | **Retained**, now labelled *proposed* and bound to `E-05` carrying it, matching `SEAT-FR-265`'s wording |
| Owner (`BC-06`) and edge (`E-05`) | **Unchanged** |
| Domain (integer 1–100) | **Unchanged**, now also restated in the requirement itself |
| Cross-references | Added `SEAT-FR-212`, `SEAT-FR-265`, `SEAT-CFG-017`, `SEAT-GAP-005`, `SEAT-AC-169`, `SEAT-AC-170` — all pre-existing identifiers; none created |

The requirement became **more** constrained, not less: the set-branch and the unset-branch are now both stated in the
requirement rather than only in `SEAT-FR-265`, so a reader arriving at `SEAT-FR-241` alone cannot derive a fallback.

`SEAT-GAP-005` is cited here in **prose**, which §0.3 and §31 permit — they forbid citing a `SEAT-GAP-*` as a
*verifiable acceptance criterion*, which is `FR-2`'s subject, not this one.

---

## 2. `FR-2` — three acceptance criteria cited `SEAT-GAP-*` as verifiable

### 2.1 The defect

Three of 226 `Verifies` cells cited a gap identifier. Two rules forbid it:

- §0.3 L82 — *"`SEAT-GAP-*` identifiers are **questions, not requirements**, and must never be cited as verifiable."*
- §31 L2216 — *"None is verifiable and none may be cited as an acceptance criterion."*

§33 states the `Verifies` column *"names the requirement each criterion tests"*. A question is not a requirement.

### 2.2 Before → After

| AC | Line | `Verifies` before | `Verifies` after |
|---|---|---|---|
| `SEAT-AC-033` | 2354 | `` `SEAT-CFG-003`, `SEAT-GAP-002` `` | `` `SEAT-CFG-003` `` |
| `SEAT-AC-102` | 2448 | `` `SEAT-FR-155`, `SEAT-GAP-003` `` | `` `SEAT-FR-155` `` |
| `SEAT-AC-170` | 2531 | `` `SEAT-FR-241`, `SEAT-FR-212`, `SEAT-GAP-005` `` | `` `SEAT-FR-241`, `SEAT-FR-212` `` |

**Removal only.** No substitute identifier was inserted, so no citation was manufactured and no coverage inflated.
The `Given`, `When` and `Then` cells of all three rows are byte-identical to before — the tests themselves are
unchanged.

### 2.3 Every row retains a real, normatively backed requirement

| AC | Retained | Normative backing verified at source |
|---|---|---|
| `SEAT-AC-033` | `SEAT-CFG-003` | Register row L1872 — owner `BC-25`, default **blocks**, domain `blocks \| permits`; behaviour set by `SEAT-BR-013` (L565–568) |
| `SEAT-AC-102` | `SEAT-FR-155` | L1174 — *"On `membership.MembershipExpired` … **MUST** flag every affected active …"* |
| `SEAT-AC-170` | `SEAT-FR-241`, `SEAT-FR-212` | L1672 (as corrected) and L1480–1483 — both state the unset behaviour the criterion tests |

So no criterion became orphaned, and each still tests the outcome it asserted before.

### 2.4 The GAP register was not modified

All 14 rows of §31 remain. The three gaps merely lost an improper citation and are still referenced in prose where
that is legitimate:

| Gap | §31 row | Other citing lines after correction |
|---|---|---|
| `SEAT-GAP-002` | intact | 3 (incl. `SEAT-BR-013` L568, §29 matrix row 7) |
| `SEAT-GAP-003` | intact | 4 (incl. §14 L1128, L1142, §29 matrix row 4) |
| `SEAT-GAP-005` | intact | 6 (incl. `SEAT-FR-265` L1864, `SEAT-CFG-017`, `SEAT-FR-241` as corrected) |

---

## 3. Verification results

Verified mechanically by a purpose-written script, with every flag confirmed by reading the PRD at source. **36 checks,
36 pass.**

### 3.1 The two findings are closed

| Check | Result |
|---|---|
| Unqualified `default 90%` / fallback-90 wording anywhere in the PRD | **0 occurrences** — full re-scan of all 15 lines containing `90` |
| Acceptance criteria citing `SEAT-GAP-*` in `Verifies` | **0 of 226** |

### 3.2 Threshold states remain deterministic

| State | Behaviour | Stated in | Tested by |
|---|---|---|---|
| `SEAT-CFG-017` **unset** | No threshold exists; `SEAT-EVT-004` never emitted at any value incl. 100%; 90% not substituted; module remains operable | `SEAT-FR-212`, `SEAT-FR-241`, `SEAT-FR-265`, `SEAT-CFG-017` | `SEAT-AC-170` |
| **Set**, integer 1–100 | That value is the threshold; emitted once per crossing, either direction; re-arms on re-crossing | `SEAT-FR-211`, `SEAT-FR-241`, `SEAT-FR-242` | `SEAT-AC-169` |
| Out of domain | Rejected — domain is `Integer 1–100, or unset` | `SEAT-CFG-017` | `SEAT-AC-190` |
| 90% once `E-05` carries it | Becomes applicable; until then a documented proposal | `SEAT-FR-241`, `SEAT-FR-265`, `SEAT-FR-267` | `SEAT-AC-169` |

Four states, one behaviour each, no gap and no overlap. `SEAT-BR-037` (one owner, one default, defined unset
behaviour) is satisfied — and now satisfied at `SEAT-FR-241` too, which previously implied a second default.

### 3.3 Registers — all 10 contiguous, all unchanged in size

| Register | Count | Range | Contiguous |
|---|---|---|---|
| `SEAT-FR-*` | 304 | 001…304 | yes |
| `SEAT-BR-*` | 45 | 001…045 | yes |
| `SEAT-INV-*` | 14 | 001…014 | yes |
| `SEAT-EVT-*` | 4 | 001…004 | yes |
| `SEAT-XC-*` | 22 | 001…022 | yes |
| `SEAT-PO-*` | 24 | 001…024 | yes |
| `SEAT-CFG-*` | 18 | 001…018 | yes |
| `SEAT-NFR-*` | 12 | 001…012 | yes |
| `SEAT-AC-*` | 226 | 001…226 | yes |
| `SEAT-GAP-*` | 14 | 001…014 | yes |
| **Total** | **683** | — | — |

All match §0.3's declared ranges. No identifier created, retired or reused. No duplicate definitions.

### 3.4 Traceability

| Measure | Result |
|---|---|
| Identifiers defined | 683 |
| Distinct identifiers cited | 683 — exactly the sum of the ten register sizes |
| Dangling citations | **0** |
| AC rows | 226, none malformed |
| Orphan ACs (no requirement in `Verifies`) | **0** |
| `SEAT-FR-302` coverage (`BR`/`INV`/`EVT`/`XC` cited by ≥1 AC) | **85 / 85** |
| Unresolved internal `§` references | **0** |

`§43` at L31 is a foreign reference the PRD labels as such — *"the source draft's §43"* — not an internal target. It
is unchanged by this pass.

### 3.5 Nothing removed or weakened

| Measure | Before | After |
|---|---|---|
| `**MUST**` | 369 | **369** |
| `**MUST NOT**` | 226 | **226** |
| Configurables with owner + default + domain | 18 / 18 | **18 / 18** |
| Exclusions stating an impossibility, with an AC | 22 / 22 | **22 / 22** |
| Permission-operation rows | 24 / 24 | **24 / 24** |
| Lines changed | — | 4 sites; 2,847 → 2,851 lines |

No V1 capability was altered. The only obligations touched are the two inside `SEAT-FR-241`, both retained verbatim.

### 3.6 Stage 3 boundaries unchanged

| Boundary | Result |
|---|---|
| Integration edges (`E-nn`) | **13**, identical set; `E-05` semantics unchanged |
| Tenant isolation (`tenantId` lines) | **17**, identical |
| Ownership delegation (§28.1 `SEAT-FR-268`…`271`, §29, `SEAT-FR-295`, `SEAT-FR-243`, `SEAT-BR-036`) | untouched |
| Authorization / permission model | untouched |
| Event contracts | untouched — no event added, removed or re-scoped |
| Rank-1 rules (`MP-GBR-07/08/16/17/19/21`) | no statement altered; `SEAT-FR-241` now aligns more closely with `MP-GBR-19` (never retroactive) by removing an implied silent default |

### 3.7 Confinement

| Item | Status |
|---|---|
| `SEAT-GAP-001` | untouched — open |
| `SEAT-GAP-003` | untouched — open; §31 row intact, prose citations intact |
| Other PRDs, ADRs, governance docs, BC Map, architecture docs | **not modified** |
| Specification / API / DB / schema / code | **not created** |
| Unrelated wording | **not changed** — diff is 4 sites, all named in §1 and §2 |

---

## 4. Exact changes

| # | Finding | Location | Change |
|---|---|---|---|
| 1 | `FR-1` | `SEAT-FR-241`, L1672–1678 | 3 lines replaced by 7; "default **90%**" reworded as a proposal bound to `E-05`; both threshold branches stated; `MUST` and `MUST NOT` retained |
| 2 | `FR-2` | `SEAT-AC-033`, L2354 | removed `` , `SEAT-GAP-002` `` from `Verifies` |
| 3 | `FR-2` | `SEAT-AC-102`, L2448 | removed `` , `SEAT-GAP-003` `` from `Verifies` |
| 4 | `FR-2` | `SEAT-AC-170`, L2531 | removed `` , `SEAT-GAP-005` `` from `Verifies` |

Net: 2,847 → 2,851 lines. Sites 2–4 are pure deletions of a token; site 1 is the only prose rewrite.

---

## 5. Is an ADR required?

**No.** Both corrections restate decisions that already exist and are already recorded:

- `FR-1` — the decision that 90% is a proposal, not an active default, is `SEAT-FR-265`'s and `SEAT-CFG-017`'s
  existing content, and the open question is already registered as `SEAT-GAP-005`. Only a stale restatement was
  repaired. No new architectural choice was made, no owner changed, no edge changed.
- `FR-2` — removing an improper citation enforces the PRD's own §0.3 and §31 rules. It decides nothing.

Per the Stage 4 gate, an ADR is warranted when a correction requires an architectural decision. Neither does.

---

## 6. Process note

Two defects in my own execution are recorded here because a correction record that hides them is worth less than one
that does not:

1. **Failed edits corrupted unrelated text.** Three `Edit` operations reported write-verification failures. Inspection
   showed partial application had mangled `SEAT-AC-206` (L2571) and appended a duplicated tail fragment — neither
   related to either finding. I reverted the file to its committed state, confirmed the hash returned to
   `6d87a05d…`, and re-applied all four edits through a single script that asserts each target matches exactly once
   and that the line delta is exactly the expected +4. The final diff was then confirmed to contain only the four
   intended sites.
2. **First attempt over-reached the authorised remedy.** For `FR-2` I initially *substituted* replacement identifiers
   (`SEAT-BR-013` into `SEAT-AC-033`, `SEAT-CFG-017` into `SEAT-AC-170`) rather than only removing the `SEAT-GAP-*`
   tokens. That adds citations beyond the instruction "keep the real requirement identifiers already cited". I
   reverted both to strict removal-only, which is what §2.2 records.

---

## 7. Disposition

Both LOW findings from the final independent Stage 4 review are corrected, and each correction is verified against the
rule it was violating. All measurements above were recalculated after the edits, not carried over.

This record makes **no** verdict claim. Stage 4 is not declared PASS here, no further review cycle is initiated, and
Stage 5 Traceability remains unauthorised until the reviewer or PRD owner confirms closure.
