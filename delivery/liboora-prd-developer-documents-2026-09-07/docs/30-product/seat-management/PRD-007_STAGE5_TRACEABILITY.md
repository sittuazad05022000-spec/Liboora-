# `PRD-007` Stage 5 Traceability Report — Seat Management

| Field | Value |
|---|---|
| **Document** | Stage 5 traceability record for [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) (`PRD-007`) |
| **Stage** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **Stage 5 — Traceability** |
| **Version** | v1.0 |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR (`DOCUMENTATION_BASELINE.md` §3.3 — *"validation record, not part of the specification"*) |
| **Date** | 2026-08-04 |
| **Registry updated** | [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) **§2E**, matrix **v1.5 → v1.6** |
| **Gate script** | [`tool/docs_check/prd007_traceability.py`](../../../tool/docs_check/prd007_traceability.py) — exit **0** |
| **Precedence** | Below every document it cites. Where this file disagrees with `PRD-007`, **`PRD-007` is right and this file is a defect** |

---

## 1. Verdict

**A — PASS.**

The `PRD-007` prefixes are registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified
mechanically by a tool rather than by reading, with **zero collisions**. That is the whole of the Stage 5 gate:

> **Gate:** the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified
> mechanically, **zero collisions**.

| Gate element | Required | Measured | Result |
|---|---|---|---|
| Prefixes registered in §2 | all | **10 / 10** in new §2E | ✅ |
| Counts registered | all | **10 / 10**, computed | ✅ |
| Ranges registered | all | **10 / 10**, contiguous 1…max | ✅ |
| Verified mechanically | by a tool | `prd007_traceability.py`, exit **0** | ✅ |
| Collisions | **zero** | **0**, checked in both directions | ✅ |

**Findings: 0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW.**

---

## 2. Changes

Two files. One registry edit and one new checker. **No PRD content was created or modified.**

| # | File | Change | Lines |
|---|---|---|---|
| 1 | `docs/40-implementation/TRACEABILITY_MATRIX.md` | **modified** — §2E added; header bumped; §10 References extended; §11 Change history row added | **+107 / −4** |
| 2 | `tool/docs_check/prd007_traceability.py` | **created** — the Stage 5 exit gate §2E.2 names | **+366 / −0** |
| 3 | `docs/30-product/seat-management/PRD-007_STAGE5_TRACEABILITY.md` | **created** — this report | new |

### 2.1 The five edit sites in `TRACEABILITY_MATRIX.md`

Deliberately the smallest change that satisfies the gate. The file was **not** reformatted, no existing entry was
reordered, and no unrelated entry was touched.

| Site | Location | Before | After |
|---|---|---|---|
| E1 | new §2E, inserted before `## 3. Chapter map` | — | 100 lines: §2E inventory table, §2E.1 collision record, §2E.2 exit gate |
| E2 | header `Version` | `v1.5` | `v1.6` |
| E3 | header `Date` | `… · **§2D added 2026-08-04**` | `… · **§2D added 2026-08-04** · **§2E added 2026-08-04**` |
| E4 | header `Baseline` | `BASELINE-2026-08-04-C` | `BASELINE-2026-08-04-D` |
| E5 | header `Sources` | `… Membership Management PRD v1.4 (PRD-005, DRAFT)` | `… (PRD-005, FROZEN) · Seat Management PRD v1.0 (PRD-007, DRAFT)` |
| E6 | §10 References | — | two entries appended: `PRD-SEAT-MANAGEMENT.md`, `prd007_traceability.py` |
| E7 | §11 Change history | — | one `v1.6` row above `v1.5`, with the containment declaration |

**`git diff` reports exactly 4 deletions**, and all four are the header lines replaced by E2–E5. Every other
change is an insertion. The insertion point follows the file's own convention: one lettered subsection per PRD
(§2 Authentication → §2A Library → §2B Student Identity → §2C Student Management → §2D Membership → **§2E Seat
Management**), placed before §3 so the inventory sections stay contiguous.

### 2.2 One change that is a correction, not an addition

E5 also changed `PRD-005` from **`DRAFT`** to **`FROZEN`** in the header `Sources` field. This is not scope creep
and not an "improvement": the header was **factually stale**. `PRD_REGISTRY.md` line 225 records `PRD-005` as
**`FROZEN`**, admitted by `ADR-0019` under `BASELINE-2026-08-04-D`, and §2D's own body already describes the
freeze. Registering a new source line beside a stale one would have published a contradiction in the field I was
editing. It is recorded here rather than repaired silently. **No `PRD-005` register row, count or range was
touched.**

### 2.3 Why a checker script, and why it is in scope

§2D.3 makes the script *the* Stage 5 exit gate for `PRD-005`, and Stage 5 requires *"counted by a tool, not by
reading."* Registering counts by hand and asserting they were verified mechanically would fail the gate it claims
to pass — which is the precise defect §2C committed and finding `SR-01` (HIGH) caught. A `tool/docs_check/`
checker is **not application code**: it ships no product behaviour, is not imported by `lib/`, and is the same
artefact class as the existing `prd004_traceability.py` and `prd005_traceability.py`. No `lib/`, `test/`,
`pubspec.yaml` or Dart file was touched.

---

## 3. `PRD-007` register verification

Computed from `PRD-SEAT-MANAGEMENT.md`, treated as authoritative. **Definition form was discovered empirically,
not assumed**: five registers are defined in prose, five in table rows, with zero overlap.

| Prefix | Count | Range | Continuous | Unique | Form |
|---|---:|---|:---:|:---:|---|
| `SEAT-FR-n` | **304** | `SEAT-FR-001` … `SEAT-FR-304` | ✅ 1…304, 0 holes | ✅ 0 duplicates | prose |
| `SEAT-BR-n` | **45** | `SEAT-BR-001` … `SEAT-BR-045` | ✅ 1…45, 0 holes | ✅ 0 duplicates | prose |
| `SEAT-INV-n` | **14** | `SEAT-INV-001` … `SEAT-INV-014` | ✅ 1…14, 0 holes | ✅ 0 duplicates | prose |
| `SEAT-EVT-n` | **4** | `SEAT-EVT-001` … `SEAT-EVT-004` | ✅ 1…4, 0 holes | ✅ 0 duplicates | table |
| `SEAT-XC-n` | **22** | `SEAT-XC-001` … `SEAT-XC-022` | ✅ 1…22, 0 holes | ✅ 0 duplicates | prose |
| `SEAT-PO-n` | **24** | `SEAT-PO-001` … `SEAT-PO-024` | ✅ 1…24, 0 holes | ✅ 0 duplicates | table |
| `SEAT-CFG-n` | **18** | `SEAT-CFG-001` … `SEAT-CFG-018` | ✅ 1…18, 0 holes | ✅ 0 duplicates | table |
| `SEAT-NFR-n` | **12** | `SEAT-NFR-001` … `SEAT-NFR-012` | ✅ 1…12, 0 holes | ✅ 0 duplicates | prose |
| `SEAT-AC-n` | **226** | `SEAT-AC-001` … `SEAT-AC-226` | ✅ 1…226, 0 holes | ✅ 0 duplicates | table |
| `SEAT-GAP-n` | **14** | `SEAT-GAP-001` … `SEAT-GAP-014` | ✅ 1…14, 0 holes | ✅ 0 duplicates | table |

**Total: 683.** Of these, **669 carry obligation** and **14 are `SEAT-GAP-*`** open questions carrying no
authority. Of the 669, **443** are obligations an acceptance criterion can verify.

**Three independent declarations agree with one computation.** The counts above are reproduced against *both*
`PRD-007` §0.3's declared ranges *and* the §2E rows now registered in the matrix. The instruction supplied counts
as known-verified; they were **recalculated from source rather than copied**, and the source confirms every one.

| Cross-check | Result |
|---|---|
| Computed vs `PRD-007` §0.3 declared ranges | ✅ 10 / 10 agree |
| Computed vs `TRACEABILITY_MATRIX.md` §2E rows | ✅ 10 / 10 agree, and total 683 agrees |
| Computed vs the counts supplied in the instruction | ✅ 10 / 10 agree |

### 3.1 Supporting mechanical results

| Measure | Result |
|---|---|
| `SEAT-*` occurrences across the document | **1,641** across **683** distinct identifiers |
| Dangling references (cited, never defined) | **0** |
| Defined but never referenced | **0** |
| `SEAT-AC-*` rows / malformed rows | **226 / 0** (5 cells each) |
| Blank `Verifies` cells | **0** |
| Orphan acceptance criteria | **0** |
| `SEAT-GAP-*` cited as verifiable | **0** |
| `Verifies` citations / distinct obligations reached | **363 / 325** |
| `SEAT-FR-302` coverage (BR + INV + EVT + XC) | **85 / 85 = 100%** |
| Overall coverage of AC-verifiable obligations | **325 / 443 = 73.4%** |

The 118 uncovered obligations are **86** `SEAT-FR-*`, **18** `SEAT-PO-*`, **9** `SEAT-CFG-*` and **5**
`SEAT-NFR-*` — the four registers `SEAT-FR-302` deliberately excludes from its mandate. They are **named rather
than argued away**, per `SEAT-NFR-011` / `SID-4.56`. This is a **standing deferral to Stage 6, not a Stage 5
finding**: the Stage 5 gate concerns registration and collisions, and coverage below 100% in registers no
requirement mandates is not a gate failure.

---

## 4. Collision verification

**Zero collisions.** Checked in **both directions**, because the `PO-n` / `SPO-n` near-miss the Stage 5 gate
exists for is invisible to a one-way check.

### 4.1 Outward — does any `SEAT-*` exist elsewhere?

| Scope | Command | Result |
|---|---|---|
| `docs/**`, word-boundary | `grep -rIno '\(^\|[^-A-Za-z]\)SEAT-[A-Z]\+-[0-9]' docs --include=*.md \| grep -v seat-management/` | **(empty)** |
| `docs/**`, loose substring | same, matching `SEAT-` only | **0 hits** |
| `tool/`, `lib/`, `test/` | `grep -rIno 'SEAT-[A-Z]\+-[0-9]' tool lib test` | **0 hits** |

The loose search was run deliberately: a word-boundary search alone cannot prove a substring collision is absent,
and §2C.1 requires the looser match to be *inspected* rather than skipped. It returned nothing to inspect.

`PRD-007` §0.3 records that `SEAT-*` was verified absent from `docs/**` **before adoption**, and that `SM-*` was
**rejected as a candidate prefix** for exactly this reason, per `PRD_LIFECYCLE.md` §5 rule 3 — *"on collision,
change the **new** prefix, never the existing one."* This registration confirms that decision held.

### 4.2 Inward — does `PRD-007` cite a foreign register by a bare prefix?

This is the direction that matters, and a loose matcher flags **five bare prefixes, 36 hits** inside `PRD-007`.
**Every hit was inspected at its line.** Detector output is not evidence.

| Bare token | Hits | Inspected at source | Verdict |
|---|---:|---|---|
| `BR-2.9`, `BR-2.12` | 3 | Authentication business rules — role-assignment authority (L1936, L2031) and Reception's denial of financial data (L2774) | ✅ correct foreign citation. Authentication numbers as `BR-c.n`; `SEAT-BR-nnn` cannot collide |
| `BR-001` … `BR-018` | 20 | The **source draft's** eighteen rules, in the left column of the §36.1 *carried-by* table (L2818+) whose right column names the `SEAT-*` identifiers carrying each | ✅ **not a register** — a historical draft token. Word-boundary search for `BR-0nn` in `docs/**` outside the module: **0 hits** |
| `LCFG-9`, `LCFG-10` | 4 | Library configurables bounding floors/seats per branch (L1841, L2264–2265) | ✅ correct foreign citation |
| `LXC-7` | 3 | Library exclusion — no price on a zone or seat (L262, L1080, L2030) | ✅ correct foreign citation |
| `LMD-23`, `LMD-24` | 4 | Student Management Directory requirements (L204, L849, L1731, L2235) | ✅ correct foreign citation |
| `TR-2` | 2 | Authentication trust requirement bounding Manager authority (L1991, L2773) | ✅ correct foreign citation |

**None is a collision.** A collision requires two registers to *define* the same identifier. `PRD-007` defines
only `SEAT-*`, and every foreign token above is a citation of a register owned elsewhere — which is what a
cross-context PRD is supposed to do.

### 4.3 Registered against every existing prefix family

| Family | Prefixes checked | Result |
|---|---|---|
| Authentication (`PRD-001`) | `AUTH`, `BR`, `XC`, `AC`, `PR`, `TR`, `EV`, `AERR`, `CFG`, `SO`, `PP`, `AU`, `EP` | ✅ no overlap |
| Library (`PRD-002`) | `LIB`, `LIB-14B`, `LIB-DISC`, `INV-SEC`, `LBR`, `LIB-PREV`, `LXC`, `INV-XC`, `LAC`, `LAC-14B`, `IAC`, `LCFG`, `ICFG`, `LEV`, `PO`, `IT` | ✅ no overlap |
| Student Identity (`PRD-003`) | `SID`, `SID-BR`, `SXC`, `SPO`, `SEV`, `SID-INT`, `SID-INV`, `SCFG`, `SID-AC` | ✅ no overlap |
| Student Management (`PRD-004`) | `SM`, `SM-BR`, `SM-XC`, `SM-INV`, `SM-EV`, `SM-PO`, `SM-AC`, `SMCFG`, `LMD`, `SM-GAP` | ✅ no overlap |
| Membership (`PRD-005`) | `MM-FR`, `MM-BR`, `MM-INV`, `MM-EVT`, `MM-XC`, `MM-AC`, `MM-NFR`, `MM-PO`, `MM-CFG`, `MM-GAP` | ✅ no overlap |

### 4.4 The range question, answered rather than assumed

The instruction warned: *"Do not assume that different textual prefixes automatically make a collision impossible
if the repository's governance defines ranges globally."* So the governance was read rather than assumed.

**Ranges are per-register, not global.** `PRD_LIFECYCLE.md` §5 rule 1 makes the **identifier** unique across the
platform — not the number. §2B.1 states the convention explicitly: independently numbered registers *"are
numbered independently and overlap numerically on purpose; the prefix carries the producer."* `SEAT-FR-001`
therefore does not overlap `MM-FR-001`, `SM-1.1` or `AUTH-1.1` in any prohibited sense, and no range-overlap
prohibition applies to §2E.

**The one range this repository does allocate globally is `IMPL-*`**, governed by Stage 6 (*"take the next free
range. Never reuse or reassign a number"*). `PRD-007` contains **0** occurrences of `IMPL-`, and §2E allocates
none. **Stage 6 remains entirely unconsumed.**

---

## 5. `PRD` integrity

**`PRD-007` is byte-for-byte unchanged.**

| Check | Result |
|---|---|
| SHA-256 before | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` |
| SHA-256 after | `05dc6fb2fccfd7296d52960e86899e73ad08090ea77cea908dcee3fd38f7b943` |
| `git diff` on `PRD-SEAT-MANAGEMENT.md` | **empty** |
| Line count | 2,851 → **2,851** |
| Requirements added / removed / renumbered / reworded | **0 / 0 / 0 / 0** |
| Acceptance criteria changed | **0** |
| `SEAT-GAP-*` resolved or altered | **0** — all 14 remain open |
| Status | remains **`DRAFT`**; no freeze, no rank claimed |

The PRD was restored to this exact hash after each negative test of the checker (§7), and the hash was
re-verified afterwards.

---

## 6. Repository integrity

| Check | Result |
|---|---|
| `MASTER_PRD.md` (Rank 1) | ✅ unchanged — `5c31a3363d99a5f6ae82cb029d6ee501835d045c2532a8e86ffe7e9042f78da9` |
| ADRs | ✅ none created or modified |
| Architecture documents, BC Map | ✅ unchanged |
| Other PRDs (`PRD-001`…`PRD-006`) | ✅ unchanged |
| `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` | ✅ unchanged |
| API specs, DB schema, migrations | ✅ none exist, none created |
| `lib/`, `test/`, `pubspec.yaml` | ✅ unchanged — no Dart touched |
| Specification / implementation-task files | ✅ none created |
| Existing §2, §2A, §2B, §2C, §2D rows | ✅ **not one row changed, reordered or reformatted** |
| §3–§8A of the matrix | ✅ untouched |
| ADR required? | ❌ **No.** `TRACEABILITY_MATRIX.md` is **unranked** (§2D: *"no ADR required: this document is unranked"*) |

---

## 7. Findings

**None.** 0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW.

### 7.1 Observations — recorded, not repaired

Out-of-scope issues are documented rather than silently fixed, per the Stage 5 instruction.

| # | Observation | Why not a finding, and why not repaired here |
|---|---|---|
| `OB-1` | The matrix header listed `PRD-005` as `DRAFT` while `PRD_REGISTRY.md` records it `FROZEN` | **Repaired**, because it is inside the field E5 edits and publishing a new source line beside a stale one would create a contradiction. Recorded in §2.2. No `PRD-005` register row touched |
| `OB-2` | §2A declares Library counts with `~` ("~130", "~422") — approximate, not mechanical | Pre-existing, another PRD's register, outside this stage's scope. **Not modified.** Stage 5 for `PRD-002` is not reopened here |
| `OB-3` | `tool/docs_check/prd004_traceability.py` exits **1** (untraced `SM-10.7`, `SM-10.8`) | Pre-existing and unrelated to `PRD-007`; the untraced identifiers are named in `PRD-004` §10.5.1. **Not touched** |
| `OB-4` | 118 obligations outside `SEAT-FR-302`'s mandate carry no AC | Standing deferral to Stage 6, already recorded. Coverage below 100% in registers no requirement mandates is not a Stage 5 gate failure, and the instruction forbids reopening deferred coverage on that basis |

### 7.2 Two defects in my own tooling, caught before they became false findings

Recorded because a review that hides its own errors cannot be audited.

| # | What happened | How it was caught | Resolution |
|---|---|---|---|
| `PD-1` | The insertion script's expected line-delta was computed as `len(split("\n"))` instead of `count("\n")` — off by one | The script's own assertion **refused to write** and reported `delta 103, expected 104` | Arithmetic derived correctly rather than the assertion loosened. File confirmed untouched at the original hash, then re-applied. Diff is exactly the 5 intended sites |
| `PD-2` | The checker's collision scan flagged 100+ `SEAT-*` hits in `TRACEABILITY_MATRIX.md` — the registry that Stage 5 *requires* to cite them | Inspected the hits rather than reporting them; every one was in §2E itself | Adopted `prd005_traceability.py`'s established rule — *"a citation is not a collision; a collision would be another register DEFINING an identifier"* — with a file-by-file allow-list, so a stray `SEAT-` anywhere else still fails |

`PD-2` is exactly the failure mode the instruction named: **detector output is not evidence.** Reporting it would
have manufactured a collision finding against the artefact the gate mandates.

### 7.3 The checker was negative-tested

A checker that cannot fail proves nothing. Six defects were injected, each reverted immediately:

| Test | Injected | Detected |
|---|---|---|
| T1 | §2E count drifted 304 → 305 | ✅ *"§2E declares SEAT-FR-* count=305 … computed count=304"* |
| T2 | Extra cell in an AC row | ✅ *"has 6 cells, expected 5"* |
| T2b | `SEAT-GAP-005` cited inside a `Verifies` cell | ✅ *"cites a SEAT-GAP-* as verifiable"* |
| T3 | `SEAT-BR-020` definition renamed (hole punched) | ✅ hole, count drift, total drift **and** dangling reference — 4 checks |
| T4 | `SEAT-FR-999` planted in `MASTER_PRD.md` | ✅ collision reported at `MASTER_PRD.md:735` |
| T5 | A `Verifies` cell blanked | ✅ *"has a blank Verifies cell"* |

After every test the file was restored and the hash re-verified. Final state: `PRD-007` at
`05dc6fb2…`, `MASTER_PRD.md` at `5c31a336…`, gate **exit 0**.

---

## 8. Final decision

**Verdict A — PASS.** `PRD-007`'s ten identifier prefixes are registered in `TRACEABILITY_MATRIX.md` §2E with
counts and ranges that a tool computes rather than a reader asserts; all ten ranges are contiguous from 1 to their
stated maximum; there are no duplicate definitions, no dangling references and no orphan acceptance criteria; and
there are **zero collisions**, verified in both directions with every loose match inspected at source.

**STAGE 5 COMPLETE — `PRD-007`'s prefixes are registered and mechanically verified with zero collisions.**

### What this report does **not** claim

- It does **not** allocate an `IMPL-*` range or create any implementation task. **Stage 6 is not started.**
- It does **not** freeze `PRD-007`. It remains **`DRAFT`**; freeze is Stage 7 and is conferred externally by
  admission to the baseline, not by this document.
- It does **not** confer Rank 3, baseline status, or `VERIFIED` status. **0 of 226** acceptance criteria are
  proven; nothing here claims `BC-04` works.
- It does **not** resolve, close or ratify any of `SEAT-GAP-001` … `SEAT-GAP-014`. All 14 remain open.
- It does **not** re-open Stage 3 or Stage 4, whose gates were closed separately.
- It creates no specification, API contract, database schema or code.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Created. Stage 5 traceability registration for `PRD-007` — §2E added to `TRACEABILITY_MATRIX.md` (matrix v1.5 → v1.6), 10 registers, 683 identifiers, all ranges contiguous, zero collisions in both directions, `PRD-007` unchanged at `05dc6fb2…`. Gate script `prd007_traceability.py` created and negative-tested against 6 injected defects. Verdict **A — PASS**. No Stage 6, no freeze, no PRD content created or modified. |
