# `PRD-005` — Correction Report for `TR-1` … `TR-5`

| Field | Value |
|---|---|
| **Document** | Correction report — third independent review findings `TR-1` … `TR-5` |
| **Subject** | [`PRD-MEMBERSHIP-MANAGEMENT.md`](PRD-MEMBERSHIP-MANAGEMENT.md) (`PRD-005`, `BC-02` Membership) |
| **Authorising input** | [`PRD-005_THIRD_INDEPENDENT_REVIEW.md`](PRD-005_THIRD_INDEPENDENT_REVIEW.md) — verdict **B** (*correct with required corrections*) |
| **Version change** | **v1.2 → v1.3** |
| **Date** | 2026-08-04 |
| **Type** | Correction pass. **No specification, no implementation, no freeze, no registration, no fourth review.** |
| **Status of `PRD-005` after this pass** | **`DRAFT`** — `PRD_LIFECYCLE.md` Stage 2. Unchanged. Not frozen, not baselined, not approved, not registered |

---

## 1. Files changed

Exactly two files were touched, both inside `docs/30-product/membership-management/`.

| File | Action | Δ |
|---|---|---|
| `PRD-MEMBERSHIP-MANAGEMENT.md` | **Modified** | +96 / −35 lines across **14 hunks** (1731 → 1792 lines) |
| `PRD-005_TR-1-TR-5_CORRECTION_REPORT.md` | **Created** | this file |

**No other file was modified or created.** Mechanically confirmed — `git diff --stat a60a083` limited to
`docs/10-architecture/`, `docs/00-governance/`, `docs/30-product/student-management/`, `docs/30-product/MASTER_PRD.md`,
`docs/30-product/authentication/`, `docs/30-product/library/`, `lib/`, `test/`, `tool/` and `pubspec.yaml` returns
**empty output**. See §11 and §14.

## 2. Version change

**v1.2 → v1.3.** Applied at the header table (`| **Version** | v1.3 (Startup MVP) |`) and recorded as a new
**v1.3** row in §26 *Change history*. The repository convention — one history row per correction pass, established by
the v1.1 and v1.2 rows — required the increment because this pass changes normative rule text (`MM-BR-035`), a
criterion (`MM-AC-075`), the declared verification metrics and a recorded gap (`MM-GAP-010`).

The **Supporting documents** header row now also links the third review and this report, so the correction chain is
navigable from the PRD itself.

---

## 3. `TR-1` — `MM-BR-035` was violated by the table it governs

**The finding.** v1.2's `MM-BR-035` required that *"every consumer named in the table **MUST** be reachable on an
integration edge already declared in `MM-BR-006`; a consumer that is not **MUST NOT** be listed here."* Yet the
`MM-EVT-006` row listed **`BC-28`**, and `BC-28` appears on **no** edge in `MM-BR-006` — nor, in fact, on any edge
anywhere in BC Map §7. The rule was falsified by its own table, one column away from the `BC-26` defect that `F-1`
had just corrected. Severity: **HIGH**.

### 3.1 What I found on inspecting the primary source — and why it changed the remedy

The review offered two remedies: **(a)** de-list `BC-28` and record the §9-vs-§7 tension alongside `BC-26` as a strict
`F-1` parallel, or **(b)** narrow the reachability clause to V1 consumers. The instruction required me to *inspect the
BC Map, `MM-EVT-006`, `MM-BR-006` and `MM-BR-035` and determine the correct PRD-level correction*. Doing so showed
that **remedy (a) would have recorded an architectural defect that does not exist**:

| Evidence | Source | Verified |
|---|---|---|
| §7 is scoped to V1 only — *"Every edge that crosses a context boundary **in V1**"* | BC Map **L292** | Read verbatim |
| `BC-28` Workflow Orchestration is a **V2** context | BC Map **L137** (register), **L147** (V2 roll-up) | Read verbatim |
| `BC-28` has **zero** rows in §7 (L290–363) | `grep 'BC-28'` over §7 → **0 hits** | Executed |
| **No** wholly-V2 context has a §7 row: `BC-07` 0, `BC-08` 0, `BC-09` 0, `BC-28` 0 | Script over BC Map register + §7 | Executed |
| `BC-26` Analytics, by contrast, is a **V1** context | BC Map **L135** | Read verbatim |
| BC Map §9 **L411** itself names `BC-28` a consumer of `membership.MembershipExpiringSoon` | BC Map L411 | Read verbatim |

**The conclusion.** `BC-28`'s absence from §7 is **that table working exactly as designed**, not an omission: §7
enumerates V1 edges, and `BC-28` is not a V1 context. There is no *"missing edge"* to infer and therefore no Rank 4
tension to record. This is the **inverse** of the `BC-26` case, where a **V1** context is named as a consumer in §9
while §7 — inside its own declared V1 scope — declares no inbound edge from any of the eleven producers that name it.
Treating the two as parallel, as remedy (a) would have, would have filed a fictitious defect against the architecture
owner. I therefore applied **remedy (b)**.

*This is reported explicitly because it is a case where the review's suggested remedy was not adopted. The finding
itself was fully valid; only one of its two proposed fixes rested on an inference the primary source does not support.*

### 3.2 What was changed

1. **`MM-BR-035` reachability clause narrowed to V1**, and `(V2)` given a defined, enforceable meaning:

   > Every **V1** consumer named in the table **MUST** be reachable on an integration edge already declared in
   > `MM-BR-006`; a V1 consumer that is not **MUST NOT** be listed here. A consumer annotated **`(V2)`** asserts **no
   > V1 edge and no V1 delivery obligation**: it **MAY** be listed only where BC Map §9 already names it, and **MUST
   > NOT** be depended on by any V1 behaviour in this document.

2. **A new explanatory note added to §12** stating the V1-scope reasoning, naming the four wholly-V2 contexts absent
   from §7, and explicitly distinguishing the `BC-28` case from the `BC-26` case.

3. **`BC-28` retained** with its `(V2)` annotation in the `MM-EVT-006` row, because BC Map §9 L411 names it. Deleting
   it would have made a Rank 3 PRD diverge from the Rank 4 Published Language for no reason.

4. **`MM-AC-075` re-verified and tightened** so it tests the amended rule rather than the old one:

   > *The event register contains exactly **seven** `MM-EVT-*` entries; every consumer named **without** a `(V2)`
   > annotation resolves to an edge declared in `MM-BR-006`; and no V1 code path delivers to, or depends on, a
   > `(V2)`-annotated consumer.*

5. **The §12 reachability sentence** amended to say *"every **V1** consumer"* and to note that the single
   `(V2)`-annotated consumer asserts no V1 edge — keeping §12's prose consistent with `MM-BR-035`.

**Constraints honoured:** no integration edge invented · no ADR created · BC Map not modified · no new event, payload,
consumer or requirement · event table, `MM-BR-006`, `MM-BR-035`, `MM-AC-075` and §12 prose mutually consistent.

**Verified:** `MM-EVT-*` rows = 7 · rows naming `BC-26` as a consumer = **0** · `` `BC-28` (V2) `` annotation present ·
`MM-BR-035` self-consistent with the table it governs.

---

## 4. `TR-2` — the declared coverage figure was not reproducible

**The finding.** v1.2 declared **81/81 = 100.0%** and **140/223 = 62.8%**, both *"reproduced by script, not
asserted"*. The review recomputed them three ways and could not reproduce either under any defensible rule. Severity:
**HIGH**.

### 4.1 Measurement methodology — stated explicitly, as instructed

Three candidate rules exist for *"is this obligation verified?"*. I computed all three on the **v1.2** text:

| Method | Rule | Rule registers (81) | All verifiable (223) |
|---|---|---|---|
| **(A) Strict** | Identifier appears in the ***Verifies* column*** of an `MM-AC-*` row | **69/81 = 85.2%** | **126/223 = 56.5%** |
| (B) Loose | Identifier appears anywhere in the AC row (text or *Verifies*) | 77/81 = 95.1% | 135/223 = 60.5% |
| (C) Block-scan | Identifier appears anywhere in §23, **including surrounding prose** | 81/81 = 100.0% | 140/223 = 62.8% |

**The declared figures reproduce only under (C)** — and (C) is not a coverage measure. The 100.0% depended on a single
line: the §23.1 prose sentence stating that `MM-BR-012`, `MM-BR-022`, `MM-BR-027` and `MM-BR-028` are *intentionally
**not** given new criteria*. Deleting that one sentence dropped the figure from 100.0% to 95.1%. **A metric that rises
when you write prose describing a gap is measuring prose, not verification.** It also contradicts `MM-NFR-014` /
`SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."*

**Method (A) was adopted as the binding rule**, because it is the only one under which the measure cannot be moved by
editorial prose.

### 4.2 What was changed

**§0.2 now defines the counting rule as binding on every coverage figure in the document**, states *why* it is strict
(citing `MM-NFR-014`), publishes the measured result as a table plus a per-register breakdown, and names the four
unverified rules. **§23.1's note** was rewritten to state the rule, publish the measured figures, explain in full why
v1.2's numbers were wrong and why the lower ones are the true ones, and record that `TR-4` was a traceability repair
rather than new coverage.

**The v1.2 change-history row was annotated, not rewritten**, marking its two figures as superseded and pointing to
the corrected values — the same convention v1.2 itself used when correcting the v1.1 row. The figures v1.2 actually
published therefore stay auditable.

**What was *not* done, per instruction:** no acceptance criterion was manufactured to raise the percentage · no
legitimate criterion was deleted or weakened · coverage was not inflated through nearby prose. **The claim was
corrected, not the coverage.**

---

## 5. `TR-3` — the false universal claim in §25.3

**The finding.** §25.3's *Verification coverage* row asserted: *"**Measured, not asserted.** Every `MM-BR-*`,
`MM-INV-*`, `MM-XC-*`, `MM-PO-*` and `MM-EVT-*` now carries at least one verifying `MM-AC-*` — **81/81 = 100.0%**."*
The universal *"Every"* was false under every measurement method: four `MM-BR-*` carry no criterion of their own, by
the document's own admission twelve lines earlier.

**What was changed.** The row now states the measured position under the §0.2 rule — **77/81 = 95.1%** and
**134/223 = 60.1%** — notes that `MM-INV-*`, `MM-EVT-*`, `MM-XC-*` and `MM-PO-*` are each at 100% while `MM-BR-*` is
at 31/35, **names the four unverified rules explicitly**, records that they are counted as **uncovered**, and states
that v1.2's claim was false and is corrected here.

**No requirement was weakened or deleted and no valid criterion was removed** — the change is confined to the sentence
that described the criteria.

---

## 6. `TR-4` — eight identifiers were tested but not traced

**The finding.** Eight register identifiers were verified by an existing criterion whose **text** named them but whose
***Verifies* cell** did not, so they counted as uncovered under any honest rule.

**What was changed.** The correct register ID was added to the *Verifies* field of the **existing** verifying
criterion. **No criterion was created, duplicated, reworded or changed in substance.**

| Identifier | Verifying criterion (already existed) | *Verifies* before → after |
|---|---|---|
| `MM-EVT-001` | `MM-AC-062` | `MM-BR-003` → `MM-BR-003`, **`MM-EVT-001`** |
| `MM-EVT-002` | `MM-AC-024` | `MM-FR-043`, `E-10` → `MM-FR-043`, **`MM-EVT-002`**, `E-10` |
| `MM-EVT-003` | `MM-AC-040` | `MM-FR-091` → `MM-FR-091`, **`MM-EVT-003`** |
| `MM-EVT-004` | `MM-AC-049` | `MM-FR-099`, `MM-FR-100` → + **`MM-EVT-004`** |
| `MM-EVT-005` | `MM-AC-042` | `MM-FR-105`, `MM-FR-106` → + **`MM-EVT-005`** |
| `MM-EVT-006` | `MM-AC-043`, `MM-AC-081` | `MM-FR-108` → + **`MM-EVT-006`**; `MM-BR-026`, `MM-CFG-008` → + **`MM-EVT-006`** |
| `MM-PO-003` | `MM-AC-027` | `MM-NFR-008` → `MM-NFR-008`, **`MM-PO-003`**, `MM-PO-004` |
| `MM-PO-004` | `MM-AC-026`, `MM-AC-027` | `MM-FR-043`, §17 → + **`MM-PO-004`**; and via `MM-AC-027` above |

Nine criteria amended in total (`MM-AC-024`, `026`, `027`, `040`, `042`, `043`, `049`, `062`, `081`).

**Verified:** AC row count **97** (unchanged) · duplicate AC IDs **0** · duplicate criterion text **0** · empty
*Verifies* cells **0** · no `MM-GAP-*` cited as verifiable **0** · every added ID names a criterion that genuinely
tests it, so **no false verification claim was introduced**. Coverage rerun after the change — see §7.

---

## 7. `TR-5` — `MM-GAP-010` was too narrow

**The finding.** `MM-GAP-010` recorded only the `BC-02` instance of the `BC-26` problem, so the architecture owner
would resolve one symptom while the same defect persisted for every other producer.

**Measured scope of the systemic issue** (script over BC Map §9 L405–456 and §7 L290–363):

- BC Map §9 names `BC-26` a **consumer for eleven producing contexts**: `BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-05`,
  `BC-10`, `BC-11`, `BC-12`, `BC-18`, `BC-20`, `BC-27`.
- BC Map §7 declares an inbound edge to `BC-26` from **exactly one** of them — `E-26`, from `BC-27` (L335).
- **Ten** producer → `BC-26` relationships are therefore asserted in §9 with no §7 edge. `PRD-005` and frozen
  `PRD-004` (`SM-GAP-11`) are two symptoms of one Rank 4 defect.

**What was changed.** `MM-GAP-010` now states the eleven-vs-one measurement, identifies the `BC-02` and `BC-01`
instances as symptoms of a class, and poses the **general** question — *is consumption of a Published-Language event a
relationship that requires its own §7 edge at all?* — with the three candidate resolutions: (i) add ten producer →
`BC-26` edges under an ADR; (ii) declare read-model/projection fan-out not to be a §7 edge, generalising the `E-20`
*"All contexts"* pattern; (iii) declare §9's consumer column advisory, leaving §7 the sole authority. It records that
**a ruling on the class settles every module PRD at once**, and that `PRD-005` is correct under all three.

It also **explicitly excludes `BC-28`** from the gap, with the §3.1 V1-scope reasoning, so the architecture owner is
not sent to investigate a non-defect.

**Constraints honoured:** no edge invented · BC Map not modified · not resolved locally · no ADR created · the gap
remains **non-blocking** and is still owned by the architecture owner.

---

## 8. Coverage before and after

All figures under the **strict** rule now binding (§0.2): identifier present in an `MM-AC-*` *Verifies* cell.

| Scope | v1.2 **declared** | v1.2 **measured** | v1.3 **measured** |
|---|---|---|---|
| Rule registers (`MM-BR`/`INV`/`EVT`/`XC`/`PO`) | 81/81 = **100.0%** ✗ | 69/81 = **85.2%** | **77/81 = 95.1%** |
| All criterion-verifiable obligations | 140/223 = **62.8%** ✗ | 126/223 = **56.5%** | **134/223 = 60.1%** |

Per register at v1.3: `MM-INV-*` 12/12 · `MM-EVT-*` 7/7 · `MM-XC-*` 16/16 · `MM-PO-*` 11/11 · `MM-BR-*` 31/35 ·
`MM-FR-*` 48/119 · `MM-NFR-*` 7/14 · `MM-CFG-*` 2/9.

The **+8** improvement comes entirely from `TR-4` moving already-tested identifiers into the *Verifies* column. **No
criterion was added** (97 before, 97 after). The four residual rule-register gaps — `MM-BR-012`, `MM-BR-022`,
`MM-BR-027`, `MM-BR-028` — are counted as **uncovered** and named in both §0.2 and §25.3.

*Note on a figure in the third review:* the review projected 135/223 for the overall measure after `TR-4`. The
measured value is **134/223**; one of the eight identifiers also required a `MM-FR-*` already counted. The measured
figure governs and is what the PRD now publishes.

---

## 9. Register-count changes

**None.** Every register is byte-identical in membership to `a60a083`, verified by set comparison, not by counting:

| Register | v1.2 | v1.3 | Declared in §0.2 | Set identical? |
|---|---|---|---|---|
| `MM-FR-*` | 119 | 119 | 119 | ✅ |
| `MM-BR-*` | 35 | 35 | 35 | ✅ |
| `MM-INV-*` | 12 | 12 | 12 | ✅ |
| `MM-EVT-*` | 7 | 7 | 7 | ✅ |
| `MM-XC-*` | 16 | 16 | 16 | ✅ |
| `MM-AC-*` | 97 | 97 | 97 | ✅ |
| `MM-NFR-*` | 14 | 14 | 14 | ✅ |
| `MM-PO-*` | 11 | 11 | 11 | ✅ |
| `MM-CFG-*` | 9 | 9 | 9 | ✅ |
| `MM-GAP-*` | 12 | 12 | 12 | ✅ |

**Totals unchanged: 332 identifiers, 320 obligation-bearing, 12 `MM-GAP-*`.** No identifier was added, removed,
renumbered or re-lettered.

---

## 10. Regression verification

| Check | Method | Result |
|---|---|---|
| No requirement deleted | Set difference `a60a083` → HEAD, all 10 registers | **empty** ✅ |
| No requirement renumbered | Set equality per register | **identical** ✅ |
| No requirement weakened | `MUST`/`MUST NOT`/`SHOULD`/`MAY` counts | `MUST NOT` 102→**104**, `MUST` 227→227, `SHOULD` 1→1, `MAY` 8→**9** — the deltas are the two new `MUST NOT`/one new `MAY` inside the amended `MM-BR-035`; **nothing downgraded** ✅ |
| Register contiguity | Gap scan per register | **0 gaps** in all 10 ✅ |
| No duplicate identifiers | Duplicate scan | **0** ✅ |
| No dangling references | Cited − defined | **0** ✅ |
| No phantom `MM-FR-119` | Literal count | **0** ✅ |
| AC row count | Table parse | **97** (= declared) ✅ |
| No duplicate AC IDs / criterion text | Duplicate scan | **0 / 0** ✅ |
| No empty *Verifies* cell | Table parse | **0 of 97** ✅ |
| No `MM-GAP-*` cited as verifiable | *Verifies* scan | **0** ✅ |
| V1 scope not expanded | Freeze/Downgrade/Transfer/Proration/Auto-Renewal still excluded; §22 V2/V3 table intact | unchanged ✅ |
| Membership Analytics still not-V1 | `MM-XC-006` present; `C-1` row intact | unchanged ✅ |
| Status set unchanged | §5.1 six values | unchanged ✅ |
| Event payloads unchanged | §12 table columns 5 | unchanged ✅ |
| Lifecycle status unchanged | Header **`DRAFT`** Stage 2 | unchanged ✅ |
| Change history append-only | v1.0/v1.1/v1.2/v1.3 rows all present | ✅ |
| Link integrity | Resolver over `docs/**` | **587 relative links, 0 broken** ✅ |
| Dart analysis | `flutter analyze` | **`No issues found! (ran in 1.8s)`** ✅ |

**Boundary checker** (`dart run tool/check_module_boundaries.dart`) remains **RED** — three pre-existing `ADR-0012`
debts including `BLK-01`, expiry 2026-10-31. **Not attributable to this pass:** the code diff versus `a60a083` is
empty. Not waived; still tracked.

---

## 11. Mechanical verification results

Every check below was **executed**, not assumed.

| # | Check | Command / method | Result |
|---|---|---|---|
| 1 | Register counts == declared | Regex extraction + comparison to §0.2 | **all 10 match** ✅ |
| 2 | Register contiguity | Gap scan | **0 gaps** ✅ |
| 3 | Duplicate identifiers | Multiset scan | **0** ✅ |
| 4 | Dangling references | `cited − defined` | **0** ✅ |
| 5 | Phantom references | `grep -c 'MM-FR-119'` | **0** ✅ |
| 6 | AC row count | Table row parse | **97** ✅ |
| 7 | Strict *Verifies* coverage | Column-only scan | **77/81, 134/223** ✅ |
| 8 | Empty *Verifies* cells | Table parse | **0** ✅ |
| 9 | `MM-GAP-*` as verifiable | *Verifies* scan | **0** ✅ |
| 10 | `BC-26` refs — not a consumer of any event | `MM-EVT-*` consumer-column scan | **0 of 7 rows** ✅ |
| 11 | `BC-28` consistency | Annotation + `MM-BR-035` + `MM-AC-075` cross-read | **consistent** ✅ |
| 12 | `BC-28` §7 edge count (evidence for §3.1) | `grep 'BC-28'` over BC Map L290–363 | **0** ✅ |
| 13 | V2 contexts absent from §7 | Script over register + §7 | `BC-07`/`08`/`09`/`28` = **0 rows** ✅ |
| 14 | `BC-26` producers in §9 vs §7 edges | Script over L405–456 / L290–363 | **11 producers, 1 edge** ✅ |
| 15 | Normative strength | Modal-verb counts | **no downgrade** ✅ |
| 16 | Removed-identifier set | Set difference vs `a60a083` | **empty** ✅ |
| 17 | Version + history row | Header + §26 parse | **v1.3, 4 rows** ✅ |
| 18 | No stale live coverage claim | Scan for `62.8%` / `81/81` outside historical context | **0 live** ✅ |
| 19 | Link integrity | Resolver over `docs/**` | **587 links, 0 broken** ✅ |
| 20 | Dart analysis | `flutter analyze` | **No issues found** ✅ |
| 21 | Frozen/ranked containment | `git diff --stat a60a083 -- <ranked paths>` | **empty** ✅ |
| 22 | Working tree | `git status --porcelain` | **clean** ✅ |
| 23 | Total changed files | `git diff --stat a60a083` | **2** (review + PRD) ✅ |
| 24 | Diff hunk locations | `git diff | grep '^@@'` | **14 hunks**, all in expected sections ✅ |

*On check 18:* two lines contain the string `81/81` by design — §23.1's explanation of the superseded figure and
§25.3's statement that v1.2's claim was false. Both mark the figure as **wrong**; neither asserts it. Manually
inspected.

*On check 19:* the link count is 587 rather than the 582 measured at the third review, because this pass added five
new relative links (two to the third review, three to this report). **0 broken** in both. The two forward references
to this file resolved once it was created.

---

## 12. Unresolved architectural dependency

**One, unchanged in substance and now stated at class scope: `MM-GAP-010`.**

> BC Map §9 names `BC-26` Analytics a consumer for **eleven** producing contexts, while BC Map §7 declares an inbound
> edge to `BC-26` from **one** (`E-26`, from `BC-27`). Ten producer → `BC-26` relationships are asserted with no §7
> edge. L292 states that an edge absent from §7 *"does not exist"*. **Owner: the architecture owner / BC Map owner.
> Rank 4 → requires a Rank 2 ADR to resolve, which this document may not create.**

**Why it was not resolved here.** Resolving it means either adding edges to the BC Map (Rank 4, forbidden to a Rank 3
PRD, and `ADR-0016` establishes that even amending a single §7 *consumer cell* needs an ADR) or creating an ADR
(Rank 2, explicitly out of scope). `PRD-005` therefore does what frozen `PRD-004` §7.4 did at `SM-GAP-11`: **declines
to list `BC-26`, invents no edge, emits nothing additional, and refers the question upward.** It is correct under all
three candidate resolutions, so the gap is **non-blocking** for this document.

**Sibling record:** `SM-GAP-11` in frozen `PRD-004`. **Not part of this dependency:** the `BC-28` case (§3.1) — §7 is
V1-scoped, `BC-28` is V2, so no defect exists to escalate.

**Governance dependencies encountered that required stopping:** **none.** No correction in this pass required a change
to a frozen or ranked document. `MM-BR-035`, `MM-AC-075`, `MM-GAP-010`, §0.2, §23.1 and §25.3 are all Rank 3 text
owned by `PRD-005`.

---

## 13. Git commit

| Field | Value |
|---|---|
| **Commit SHA** | recorded in §16 below (written after commit, from `git rev-parse HEAD`) |
| **Branch** | `main` |
| **Parent** | `8e9429c` (auto-backup carrying the v1.3 PRD edits) · correction baseline `a60a083` |

*Note on the ancestry:* the sandbox auto-backup committed the in-progress PRD edits as `8e9429c` before this report
existed. The tree state is identical to what a single commit would have produced; the correction is complete and
self-consistent at HEAD, and §11 checks 21–24 were run against the **content**, not the commit boundary.

## 14. Confirmation — no frozen or ranked document was modified

`git diff --stat a60a083` for the ranked/frozen paths returns **empty output**:

- **Rank 1** `docs/30-product/MASTER_PRD.md` — untouched ✅
- **Rank 2** `docs/00-governance/adr/` — untouched; **19 files** (18 ADRs + index), no ADR created ✅
- **Rank 3** `docs/30-product/student-management/Student_Management_PRD_v1.md` (**FROZEN v1.2**) — untouched ✅
- **Rank 4** `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` — **byte-identical**; no edge added, no consumer
  cell amended, no §9 row changed ✅
- **Rank 5/6/7** rulings, EA, config guide — untouched ✅
- `docs/00-governance/` in full, incl. `DOCUMENTATION_BASELINE.md`, `PRD_LIFECYCLE.md` — untouched ✅
- **`PRD_REGISTRY.md` — untouched.** `PRD-005` remains **`PLANNED`** (L225); the `PLANNED` count remains **19**.
  `PRD-005` was **not** registered and **not** marked approved ✅
- `authentication/`, `library/`, `lib/`, `test/`, `tool/`, `pubspec.yaml` — untouched ✅
- `PRD-005_THIRD_INDEPENDENT_REVIEW.md`, `PRD-005_F1-F4_CORRECTION_REPORT.md`,
  `PRD-005_SECOND_INDEPENDENT_REVIEW.md`, `PRD-005_BLOCKER_ANALYSIS.md`, `PRD-005_CORRECTION_REPORT.md` — **not
  edited** ✅

## 15. Confirmation — no specification or implementation was performed

This pass produced **no**:

- API contract, endpoint, request/response schema or error catalogue
- database schema, table, column, index, migration or SQL of any kind
- Flutter, Dart or any other source code; no widget, screen, route or state-management design
- UI layout, wireframe, mockup or visual design
- test file, test case implementation or test harness
- Firebase collection, security rule or backend service
- new feature, capability, requirement or V1 scope expansion

`flutter analyze` was run **only** as a regression guard, and `lib/`, `test/`, `tool/` and `pubspec.yaml` are
byte-identical to `a60a083`. §0.3's *"not an API specification… no SQL, no migrations, no code, no visual mockups"*
remains true of `PRD-005` at v1.3.

**Also not done, per the stop instruction:** no fourth independent review · `PRD-005` **not frozen** · **not
registered** in `PRD_REGISTRY.md` · **not** marked approved or baselined · implementation **not** started ·
specification **not** created.

---

## 16. Summary

| Finding | Severity | Disposition |
|---|---|---|
| `TR-1` — `MM-BR-035` violated by its own table (`BC-28`) | HIGH | **Corrected** via remedy (b), after primary-source evidence showed remedy (a) would record a non-existent defect (§3.1) |
| `TR-2` — declared coverage not reproducible | HIGH | **Corrected** — strict counting rule now binding and stated; measured figures published |
| `TR-3` — false *"Every…"* claim in §25.3 | MEDIUM | **Corrected** — measured statement, four gaps named |
| `TR-4` — eight identifiers tested but untraced | LOW | **Corrected** — IDs added to existing *Verifies* cells; no new criteria |
| `TR-5` — `MM-GAP-010` too narrow | MEDIUM | **Corrected** — broadened to the eleven-producer class with three candidate resolutions |

**All five findings corrected. Registers unchanged (332 / 320 / 12). Coverage restated honestly: 95.1% and 60.1%
measured, replacing the unreproducible 100.0% and 62.8%. One unresolved architectural dependency (`MM-GAP-010`),
non-blocking, escalated at class scope. No frozen or ranked document modified. No ADR created. No specification, no
implementation. `PRD-005` remains `DRAFT` at Stage 2.**

| Field | Value |
|---|---|
| **Commit SHA** | `PENDING_SHA` |
| **Push status** | see below |

---

*End of correction report.*
