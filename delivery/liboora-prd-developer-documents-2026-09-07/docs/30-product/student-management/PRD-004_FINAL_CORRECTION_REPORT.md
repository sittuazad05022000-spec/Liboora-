# PRD-004 — Final Correction Report

| Field | Value |
|---|---|
| **Document** | `PRD-004_FINAL_CORRECTION_REPORT.md` |
| **Subject** | [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) — PRD-004, Student Management & Library Members Directory |
| **Subject version before this pass** | v1.1 |
| **Subject version after this pass** | **v1.2** |
| **Driving input** | [`PRD-004_SECOND_INDEPENDENT_REVIEW.md`](PRD-004_SECOND_INDEPENDENT_REVIEW.md) — 17 findings, verdict **B** |
| **Pass type** | Controlled correction pass — **audit-driven, surgical** |
| **Date** | 2026-08-04 |
| **Status** | Complete. **PRD-004 remains `DRAFT` and is NOT frozen.** |
| **Verdict** | **A — READY FOR FINAL FREEZE REVIEW** (see §11) |

> **Scope discipline.** This pass did not rewrite PRD-004, did not create a new PRD, did not create a bounded
> context, did not modify application code, did not modify any frozen or ranked document, and did not freeze
> PRD-004. Six documents were changed; every one is unranked or `DRAFT` under
> [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4, so **no ADR was required**.
> Every number in this report was produced by a script run against the live repository. No count was estimated,
> inferred from a group table, or carried forward from a previous document.

---

## 1. Order of work

The instruction was explicit: *"First reproduce and verify every finding from the second review."* That order was
followed literally. **No edit was made to any file until the finding motivating it had been reproduced
mechanically against the repository.** This mattered: one finding (`SR-13`) failed reproduction and was
therefore rejected rather than "fixed", and one (`SR-11`) reproduced at a different magnitude than reported,
which changed how it is characterised below.

---

## 2. Findings verified

All 17 findings were examined. The table records what was *reproduced*, with the evidence, before any change.

| ID | Sev | Reproduced? | Mechanical evidence obtained **before** editing |
|---|---|---|---|
| `SR-01` | **HIGH** | ✅ **YES — both halves** | Matrix §2C read live: `SM-c.n`=105, `SM-EV-n`=9, `SM-AC-n`=28, `SM-GAP-n`=9, total **242**, Ch 10 = 10. Script count of the PRD: 107 / 10 / 30 / 10 = **248 base**. Task-range half: `grep -o 'IMPL-3[0-9][0-9]' \| sort -u \| wc -l` → PRD **24**, task doc **18**; `comm -13` named the six absentees `IMPL-318`…`IMPL-323` |
| `SR-02` | **HIGH** | ✅ **YES — exactly 3** | `grep -n` for the `No … **MUST**` shape returned precisely three hits: L604 (`LMD-24a`), L780 (`SM-7.14`), L977 (`SM-10.9`). Each read in full and confirmed to assert the logical opposite of intent under the PRD's own §0.1 vocabulary |
| `SR-03` | MEDIUM | ✅ **YES** | `grep -c "BC-03" docs/10-architecture/ARCHITECTURE_RULINGS.md` → **0**; `grep -c "BC-05"` → **0**. `AR-1`'s composed-context table (L38–50) is {BC-19, BC-25, BC-29, BC-06, BC-02, BC-04, BC-23}. §5.4 claimed `AR-1` precedent for four rows, two of which `AR-1` never mentions |
| `SR-04` | MEDIUM | ✅ **YES** | `grep -c "BC-26"` on the PRD → **0**, while BC Map §8 rows L404–405 name `BC-26` a primary consumer of `enrollment.StudentEnrolled` and `enrollment.StudentProfileUpdated` |
| `SR-05` | MEDIUM | ✅ **YES — external** | BC Map §7 (L316–335) contains no `BC-01`→`BC-26` edge; §8 (L400–412) names `BC-26` twice; L292 states an edge absent from §7 *"does not exist"*. Genuine Rank 4 internal tension in a **frozen** document |
| `SR-06` | MEDIUM | ✅ **YES — 3 of 3** | All six requirements involved read in full. `SM-2.2` is the field list; `SM-2.4` concerns record scope; `SM-10.5` is a retention rule — none is what its citing criterion actually tests |
| `SR-07` | LOW | ✅ **YES — 4 of 4** | `SID-5.7` (L1111) read verbatim: *"A field not needed for that purpose SHALL NOT be added here…"* — materially the same rule as `SM-8.15`. `E-20`/`X-10`, BC Map L209 and `X-10` confirmed as real, uncited sources for the other three |
| `SR-08` | LOW | ✅ **YES** | Heading map of `Student_Identity_PRD_v1.md` §2: 2.1@269, **2.2@298**, 2.3@328, **2.4@368 = "Profile privacy"**, 2.5@405 … The Optional list is at **L309, inside §2.2**. The PRD's "§2.4" citation is wrong at two sites |
| `SR-09` | LOW | ✅ **YES** | `AP-3` read verbatim at `Authentication_PRD_v2.md` L2263: *"**Deny by default** \| AUTH-7.6 — Absence of an explicit grant is refusal."* An authorisation policy. It does not by itself compel a **safeguarding** default |
| `SR-10` | MEDIUM | ✅ **YES** | Scan of all 30 `Verifies` cells for the guardian/DOB/minor cluster returned exactly **one** row (`SM-AC-29`, the absent-DOB case). §4.2.1 cases 1 and 2 had no criterion |
| `SR-11` | LOW | ⚠️ **PARTIALLY — magnitude wrong** | Reproduced at **27**, not 32, after expanding the range notation the task table actually uses (`SM-2.1`–`SM-2.4`). Naive matching gives 100; the review's 32 lies between the two, so its own expansion was incomplete. See §4 |
| `SR-12` | LOW | ✅ **YES** | `SHOULD` appears on **one** line only — L31, the §0.1 definition row itself. `MUST` ×244, `MUST NOT` ×83, `MAY` ×3 (L32 definition, L381 `SM-3.14a`, L556 `LMD-15a`). Vocabulary defined, never used |
| `SR-13` | LOW | ❌ **NO — DISPROVED** | `PRD-004_CORRECTION_REPORT.md` §3 L160 reads verbatim: *"`RF-16` — stale roadmap. **NOT REJECTED**, but out of scope for this pass"*. §3 never classified `RF-16` as rejected. **My own second-review finding was wrong.** See §5 |
| `SR-14` | OBS | ✅ **YES — immaterial** | The `PRD-0\d\d` regex loophole exists in `tool/docs_check/prd004_traceability.py`. Exhaustive scan of definition lines: 3 `PRD-0nn` citations, none a self-citation, two on excluded gaps. Coverage effect **zero** |
| `SR-15` | OBS | ✅ **YES** | 12 authorisation-family requirements now carry an AC (`SM-8.1`, `8.2`, `8.10`, `8.11`, `8.13`, `SM-10.2`, `10.3`, `10.4`, `10.6`, `10.7`, `10.8`, `10.9`). §8.2's 12 × 5 role matrix still rests largely on `SM-AC-23` |
| `SR-16` | OBS | ✅ **YES — still true** | Post-correction AC scan: `SM-7.7a` **False**, `SM-7.12a` **False**, `SM-10.12` **False**. All three remain task-covered (`IMPL-320`, `IMPL-321`) |
| `SR-17` | LOW | ✅ **YES — and worse** | Counts are hand-maintained in **six** documents, not four: PRD §0.2, `TRACEABILITY_MATRIX.md` §2C, `PRD-004_TRACEABILITY.md` §1, `docs/README.md`, `PRD-004_ALIGNMENT_REPORT.md`, `PRD-004_IMPLEMENTATION_TASKS.md` §7 |

**Verified: 16 of 17.** Reproduced as reported: 15. Reproduced at a different magnitude: 1 (`SR-11`).
Failed reproduction: 1 (`SR-13`).

---

## 3. Findings fixed

Nine findings were fixed inside PRD-004 and its unranked satellites.

### 3.1 `SR-01` HIGH — stale counts and stale task range

This was the **Stage 5 freeze blocker**. [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L120–131 requires
*"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, **verified mechanically**,
zero collisions… Mechanical means counted by a tool, not by reading."* The matrix was reading 242 against an
actual 251, so the gate could not pass on its own terms.

**Half A — matrix §2C.** Every register count, range and per-chapter figure re-derived by script and written in:

| Register | Was | Now |
|---|---|---|
| `SM-c.n` | 105 | **107** |
| `SM-EV-n` | 9 | **10** |
| `SM-AC-n` | 28 | **32** |
| `SM-GAP-n` | 9 | **11** |
| Chapter 10 subtotal | 10 | **12** |
| **Base total** | **242** | **251** |
| **Total incl. sub-lettered** | — | **266** (251 + 15) |

A measured-coverage line (**227/240 = 94.6%**) and a ⚠ blockquote were added, the latter quoting the Stage 5
*"counted by a tool, not by reading"* rule and recording that the document is unranked so no ADR was needed.
Header v1.3 → **v1.4**; Sources → PRD-004 **v1.2**; change-history row added.

**Half B — task range.** `PRD-004_IMPLEMENTATION_TASKS.md` gained **§3.6 Wave 6**, carrying `IMPL-318`…`IMPL-323`
transcribed verbatim from PRD §10.7. Title and §3 heading corrected to `IMPL-300 … IMPL-323` / "The 24 tasks";
critical-path diagram extended with a note that Wave 6 does not lengthen it; §7 claims resynchronised; v1.0 → **v1.1**.

**Verification.** `comm -3` between the two documents' task sets is now **empty**; both hold **24** unique task IDs.

### 3.2 `SR-02` HIGH — three negated-MUST requirements

Each was rewritten so the obligation is stated as a prohibition. **The security and architecture rule each was
intended to express is preserved in full, and one is strengthened.**

| ID | Defect | Repair | Rule preserved? |
|---|---|---|---|
| `SM-10.9` | *"**No** endpoint **MUST** accept `tenant_id`…"* — states accepting it is *not obligatory* | *"An endpoint **MUST NOT** accept `tenant_id`… Tenant scope **MUST** derive from the session's authorisation context (`SM-8.2`, `SM-8.3`, `X-13`)."* | ✅ **Strengthened** — `X-13` is now named explicitly, and the positive derivation rule is stated alongside the prohibition. `X-13` is not weakened; it is invoked |
| `SM-7.14` | Same shape, event-payload leakage | *"An event payload **MUST NOT** contain a credential, an OTP, a raw document byte, a `FileRef` resolvable without authorisation, or a `BC-10`-owned personal field."* | ✅ Identical prohibited set, `ID-1`/`SM-7.13` citations retained |
| `LMD-24a` | Same shape, domain-layer composition | *"A composed row in this table **MUST NOT** be read from this module's **domain layer**… **MUST NOT** be persisted… cached beyond the display request, or used to evaluate any invariant this module owns."* | ✅ `SID-2.38`–`SID-2.41`, `SM-7.1`, `SM-7.1a`, `LMD-22` all retained |

**Self-caught regression.** My first attempt produced *"No endpoint **MUST NOT** accept…"* and *"No row in this
table **MUST NOT** be read…"* — double negatives that re-introduced the exact defect class `SR-02` reports. Both
were corrected by changing the grammatical subject ("An endpoint", "A composed row"). This is recorded because a
correction pass that silently re-injects the fault it is repairing is worse than one that leaves it alone.

**Post-fix scans.** Negated-MUST rescan and double-negative rescan both return **empty**. The single residual
regex hit is the §11 change-history row *quoting* the old defective pattern for the record — inspected and
confirmed a false positive.

### 3.3 `SR-10` MEDIUM — objective acceptance criteria for the guardian cases

Two criteria added. Both are objective: each names a concrete input state, a concrete observable outcome, and an
outcome that is *excluded*.

| ID | Criterion | Verifies |
|---|---|---|
| `SM-AC-31` | With a `BC-10` DOB giving age **under 18** and **no** `GuardianLink`, enrollment is **rejected with a typed domain error**; no `StudentRecord` is committed, and the rejection is not a generic 500 | `SM-4.4`, `SM-INV-3`, `SM-10.8`, §4.2.1 case 1 |
| `SM-AC-32` | With a `BC-10` DOB giving age **18 or over** and **no** `GuardianLink`, enrollment **succeeds**; supplying a `GuardianLink` for the same record is also accepted and neither path blocks enrollment | `SM-4.4`, `SM-INV-3`, §4.2.1 case 2 |

**Consistency with the absent-DOB behaviour.** `SM-AC-29` — the fail-safe-to-minor path when DOB is absent — was
**not touched**. The three DOB cases now partition cleanly and without overlap: *DOB present & minor* → reject
(`SM-AC-31`); *DOB present & adult* → succeed (`SM-AC-32`); *DOB absent* → treated as minor, fail-safe
(`SM-AC-29`, `SM-4.5a`–`SM-4.5c`). No case is now silent, and no case is covered twice with different outcomes.

### 3.4 `SR-03` MEDIUM — composition authority re-attributed

Fixed by **promoting the higher-ranked authority that was already cited**, not by adding a requirement.
`SID-2.7` (Rank 3, **frozen**) authorises exactly the contributor set PRD-004 uses — including `BC-03` and
`BC-05`, which `AR-1` (Rank 5) never mentions. Decisive corroboration: **`BC-10` has no BC Map §7 edge to
`BC-02`/`BC-03`/`BC-04`/`BC-05` yet composes all four under `SID-2.7`**, so composition-without-edge is
established Rank 3 doctrine, not an invention of PRD-004.

§5.4 now states `AR-1` **classifies** the mechanism while `SID-2.7` **authorises** these specific contributors;
all four table rows read `**SID-2.7** composition`; the header Rulings row is annotated; and the blockquote
explicitly **withdraws** the earlier *"identical precedent"* claim as *"true for `BC-02`/`BC-04` and false for
`BC-03`/`BC-05`"*.

### 3.5 `SR-04` MEDIUM — undisclosed event consumers

§7.4 gained a blockquote stating what the `Consumers` column omits and why: `BC-24` (reached by generic `E-20`
plus `SM-8.10`), `BC-22` (generic `E-23`), and `BC-26` — the last recorded as **`SM-GAP-11`** rather than silently
added, because adding it would assert an edge that BC Map §7 does not contain.

### 3.6 `SR-05` MEDIUM — registered, not resolved

The BC Map §8-vs-§7 tension over `BC-26` is a defect in a **frozen Rank 4** document. It is registered as
**`SM-GAP-11`** for the architecture owner, with the ADR requirement stated. **Not resolved inside PRD-004** — see §10.

### 3.7 `SR-06` MEDIUM — three miscited criteria

| Criterion | Was | Now |
|---|---|---|
| `SM-AC-5` | `SM-2.2` (field list) | `SM-2.7`, `SM-2.5`, BC Map line 209 |
| `SM-AC-6` | `SM-2.4` (record scope) | `SM-2.7`, `SM-BR-3`, BC Map line 209 |
| `SM-AC-25` | `SM-10.5` (retention) | `LMD-30`, `SM-BR-14`, `SMCFG-4` |

**Second self-caught error.** I first pointed `SM-AC-5` at `SM-2.6`, then read `SM-2.6` and found it governs the
`Prospective`/`Registered` transition while `SM-2.5` is the closed status set the criterion actually exercises.
Corrected before commit. I also re-read `SM-AC-11`, confirmed it was already correct, and left it alone rather
than "fixing" a non-defect to inflate this section.

### 3.8 `SR-07` LOW — four already-true citations stated

| Requirement | Source now cited |
|---|---|
| `SM-6.6` | `E-20`, `X-10`, `SM-8.10` |
| `SM-6.8` | `SM-2.4`, `SM-XC-2`; BC-02 owns `MembershipStatus` per BC Map line 209 |
| `SM-8.11` | `SM-8.10`, `X-10` |
| `SM-8.15` | `SID-5.7` — quoted verbatim — applied to this module's own record; `ID-1` |

**Coverage rose 92.9% → 94.6% honestly.** No requirement was reworded to match the traceability regex; none was
reclassified as a gap to leave the denominator (the denominator *rose*, 238 → 240); the 13 remaining untraced
identifiers are still enumerated by name in §10.5.1. §10.5.1 now carries an explicit direction-of-change
paragraph: *"The figure rose because four real sources were cited, not because the measurement was relaxed."*

### 3.9 `SR-08` and `SR-09` LOW — citation corrections

`SR-08`: `PRD-003` §2.4 → **§2.2 *Global Profile*, Optional list** at both sites (§4.2.1 and `SM-GAP-10`), with
`SID-5.9` annotated in §5.2. `SR-09`: `SM-4.5b` gained a second paragraph ordering authority correctly — `SID-4.56`
direct, `SID-5.14` supplying the safeguarding obligation, `AP-3` direct only for the capability-closure half.

---

## 4. Findings reviewed and consciously not converted into requirements

Instruction: *"Fix only genuine defects. Do not manufacture requirements."* Five findings are real observations
whose remedy would mean inventing normative content. Each is recorded, none is silently dropped.

| ID | Why no change was made |
|---|---|
| `SR-11` | Reproduced at **27**, not 32. Every one is a scope statement (`SM-1.1`–`SM-1.8`), a prohibition verified by AC schema scan (`SM-7.1`, `SM-7.2`, `SM-7.5`–`SM-7.11`), or a requirement with an alternative verification route. Attaching tasks to prohibitions would create work items that cannot fail. **Coverage shape, not a hole.** The review's "32" is itself imprecise: naive matching gives 100, full range expansion gives 27 — its expansion of the task table's `A`–`B` notation was partial. Recorded here rather than propagated |
| `SR-12` | `SHOULD` is defined and used zero times; `MUST` ×244. Demoting `LMD-11`/`LMD-17` to `SHOULD` would make the pagination-stability and ordering-determinism guarantees unenforceable, which `SID-4.56` treats as **unmet**. The correct trade is to keep them `MUST`. `MAY` *is* used twice in substance (`SM-3.14a`, `LMD-15a`), so the vocabulary is not wholly ornamental |
| `SR-14` | Script hygiene in an unranked tool; measured effect on coverage is **zero** (3 `PRD-0nn` citations, no self-citation, 2 on excluded gaps). Tightening the regex is a tooling change with no documentation consequence; it is not a PRD defect |
| `SR-15` | `SM-8.6` delegates the authorisation decision to `BC-18`, whose own PRD carries the role-matrix tests. Authorisation-family AC coverage rose to **12 requirements** as a side effect of this pass. Manufacturing 60 cell-level criteria here would duplicate another module's test surface |
| `SR-16` | `SM-7.7a`, `SM-7.12a` and `SM-10.12` still have no AC — confirmed post-correction. All three are covered by `IMPL-320`/`IMPL-321`, and `SM-10.11` explicitly permits task-route verification. Adding criteria is defensible but optional; the instruction named only the guardian/DOB gap as mandatory, and I declined to expand scope on my own authority |
| `SR-17` | Structural fragility, now measured as **six** hand-maintained copies rather than four. The correct remedy — have the counting script emit the register table — is a tooling change outside this pass's scope. Its concrete instance (`SR-01`) is fixed |

---

## 5. Findings rejected

### `SR-13` — REJECTED. My own second-review finding was wrong.

`SR-13` alleged that `PRD-004_CORRECTION_REPORT.md` §3 classified `RF-16` among *rejected* findings while §7.2
recorded the roadmap update as performed. Reading §3 at L160 verbatim:

> *"**`RF-16` — stale roadmap. NOT REJECTED, but out of scope for this pass:** already corrected in `1922f8d`
> during Request J-2, i.e. before this correction phase began."*

The words **"NOT REJECTED"** appear in the source. §3 never classified `RF-16` as rejected; it explicitly said the
opposite. The contradiction `SR-13` reports **does not exist in the document**. The finding was produced by
reading the section heading rather than the row, and it is withdrawn.

I am recording this prominently because the alternative — quietly dropping it, or "fixing" the correction report
to match my own erroneous claim — would have corrupted a truthful document to protect a false finding. A review
that cannot fail its own findings is not an audit.

**Rejected: 1 of 17.**

---

## 6. Exact requirement changes

Complete and exhaustive. Nothing else in the normative body of PRD-004 was altered.

### 6.1 Requirements whose text changed — 3

| ID | Change | Weakened? |
|---|---|---|
| `SM-10.9` | Negated-MUST → `MUST NOT`; added the positive session-derived tenant rule and an explicit `X-13` citation | **No — strengthened** |
| `SM-7.14` | Negated-MUST → `MUST NOT`; prohibited set unchanged | No |
| `LMD-24a` | Negated-MUST → `MUST NOT`; subject changed to "A composed row"; all four prohibitions retained | No |

### 6.2 Requirements whose *citations* changed — 6 (obligation text untouched)

`SM-4.5b` (authority order), `SM-6.6`, `SM-6.8`, `SM-8.11`, `SM-8.15` (sources stated), and the two `PRD-003`
§2.4 → §2.2 sites.

### 6.3 Identifiers added — 3

`SM-AC-31`, `SM-AC-32` (§3.3), `SM-GAP-11` (§3.6).

### 6.4 Identifiers removed, renamed or renumbered — **0**

**Nothing was deleted or renumbered.** In particular: `SM-EV-*` remains **closed at ten** (`SM-EV-10` intact);
the `LMD-n` register remains at **31**; and no `SM-c.n`, `SM-BR-n`, `SM-XC-n`, `SM-INV-n`, `SM-PO-n` or `SMCFG-n`
was added, removed or renumbered.

### 6.5 Preservation checks — all six mandated invariants intact

| Must be preserved | Status | Evidence |
|---|---|---|
| Global Identity boundary | ✅ Intact | `BC-10` remains sole owner of personal fields; `SM-7.14` still forbids `BC-10`-owned fields in payloads |
| `BC-01` ownership | ✅ Intact | No ownership row touched; `StudentRecordId` remains per-tenant |
| Enrollment vs Membership separation | ✅ Intact | `SM-AC-6`'s citation correction *reinforces* it — now cites BC Map L209, where `BC-02` owns `MembershipStatus` |
| Directory as read composition | ✅ Intact | `LMD-24a`'s repair makes the application-layer-only rule **more** explicit |
| `SM-EV-10` | ✅ Intact | Event set still closed at ten; `IMPL-320` still carries it |
| `AR-1`/`SID-2.7` architecture interpretation | ✅ Intact, better attributed | Same mechanism, correct authority: `SID-2.7` authorises, `AR-1` classifies. No new edge, no new context |

---

## 7. Final counts

Every figure below was produced by a script run against the committed files, per `SID-4.56` and the Stage 5
*"counted by a tool, not by reading"* rule.

### 7.1 Requirement count

| Measure | Before | **After** |
|---|---|---|
| Base identifiers | 248 | **251** |
| Sub-lettered | 15 | **15** |
| **Total normative identifiers** | 263 | **266** |
| Proposed gaps (`SM-GAP-*`) | 10 | **11** |
| Real requirements (denominator) | 238 | **240** |

Per-register: `SM-c.n` **107** · `SM-BR-n` 16 · `SM-XC-n` 14 · `SM-INV-n` 11 · `SM-EV-n` **10** ·
`SM-PO-n` 12 · `SM-AC-n` **32** · `SMCFG-n` 7 · `LMD-n` 31 · `SM-GAP-n` **11**.
All ten registers verified **contiguous**, zero numbering gaps.

### 7.2 Traceability count

```
Identifiers located in the PRD      : 251
Proposed gaps (SM-GAP-*, excluded)  : 11
Denominator — real requirements     : 240
  traced DIRECT  (external source)  : 218
  traced DERIVED (via a traced req) : 9
  UNTRACED                          : 13
Coverage                            : 227/240 = 94.6%
```

Was **221/238 = 92.9%** with 17 untraced. The 13 remaining are named individually in PRD §10.5.1 and reprinted by
the script on every run, so the figure is falsifiable by anyone who disagrees with it.

### 7.3 Acceptance-criteria count

**32** rows (was 30). Verified: 32 unique IDs, `SM-AC-1`…`SM-AC-32` contiguous, **0 empty `Verifies` cells**,
**0 references to undefined local identifiers**, **50** distinct non-AC identifiers carried.
**0 of 32 are currently executed as automated tests** — disclosed in PRD §10.5.1 and `PRD-004_TRACEABILITY.md`.

### 7.4 Implementation-task count

**24** tasks, `IMPL-300` … `IMPL-323`. PRD §10.7 and `PRD-004_IMPLEMENTATION_TASKS.md` now hold **identical**
sets — `comm -3` returns empty. This was the second half of `SR-01`.

---

## 8. Validation results

| # | Validation | Command / method | Result |
|---|---|---|---|
| V1 | **Requirement IDs** | register counter with contiguity check | ✅ 10/10 registers contiguous; **251** base / **266** total |
| V2 | **Duplicate IDs** | duplicate scanner across all registers | ✅ **11 apparent, all benign** — 9 are §0.2 register rows paired with their real definitions (`SM-4.5b`@64/450, `SM-7.1a`@69/719, `LMD-24a`@70/633, `SM-7.12a`@71/819, `SM-4.5a`@72/444, `SM-3.14a`@73/380, `LMD-15a`@74/548, `SM-7.7a`@75/750, `SM-8.4a`@76/880); `SM-3.17`@402 is the definition, @1142 a cross-reference; `SMCFG-3`@649 is a continuation line, @1040 the table row. **0 genuine collisions** |
| V3 | **Traceability** | `python3 tool/docs_check/prd004_traceability.py` | ⚠️ exit 1 **by design** — `227/240 = 94.6%`, 13 untraced enumerated. Exit 1 is the tool asserting the 13 remain; it is not a regression |
| V4 | **Acceptance criteria** | AC integrity checker | ✅ 32 rows, 0 empty cells, 0 undefined identifiers, IDs contiguous |
| V5 | **Links** | relative-link resolver over `docs/**/*.md` | ✅ **572 links checked, 0 broken** |
| V6 | **YAML** | `yaml.safe_load` on all manifests | ✅ **4/4 parse OK** (`module_dependencies.yaml`, `analysis_options.yaml`, `pubspec.yaml`, `liboora_contracts/pubspec.yaml`) |
| V7 | **Gate 1 — format** | `dart format --output=none --set-exit-if-changed .` | ✅ `Formatted 59 files (0 changed)` · **EXIT=0** |
| V8 | **Gate 2 — analyze** | `flutter analyze` | ✅ **`No issues found!`** |
| V9 | **Gate 3 — architecture checker** | `dart run tool/check_module_boundaries.dart` | ⚠️ **EXIT=1 — pre-existing.** See §8.1 |
| V10 | **Gate 4 — architecture tests** | `flutter test test/architecture/` | ✅ **20 tests, all passed** — including *"app → domain/library is deliberately NOT waived"* |
| V11 | **Gate 5 — full test suite** | `flutter test -r compact` | ✅ **`+77 All tests passed!`** · EXIT=0 |
| V12 | **Frozen-document integrity** | `git diff a030b07 HEAD -- <9 ranked paths + ADRs + all code>` | ✅ **EMPTY** |
| V13 | **git diff scope** | `git diff --name-only a030b07 HEAD` | ✅ exactly **7 files**, all unranked/draft docs (6 corrected + the review report from Part 1) |
| V14 | **GitHub synchronisation** | see §8.2 | ⚠️ pending push at time of writing; resolved in the commit accompanying this report |

Gate 6 (`flutter build web --release`) was not re-run: `git diff a030b07 HEAD -- lib/ web/ pubspec.yaml packages/`
is empty, so the build input is byte-identical to the last green build. Recording that reasoning rather than
claiming a run that did not happen.

### 8.1 Gate 3 is red, and this pass did not cause it

Five violations, each carrying an `ADR-0012` waiver owned by `TASK-D10`/`BLK-01`:
`domain/library → platform/event` (5 sites, expires 2026-12-31) · `domain/library → platform/identity` (5 sites,
2027-03-31) · `domain/library → platform/services` (2 sites, 2027-03-31) · `platform/analytics → platform/event`
(1 site, 2026-10-31) · `platform/business → platform/tenancy` (1 site, 2026-10-31).

**Causation by this pass proved nil, three independent ways:**
1. `git diff --stat a030b07 HEAD -- lib/ test/ tool/ pubspec.yaml packages/` → **empty**
2. `git diff --name-only a030b07 HEAD -- lib/ | wc -l` → **0**
3. All five violations carry pre-existing ADR-0012 waivers with expiry dates predating this pass

This is a standing code-debt item, tracked as `BLK-01` (P0), not a documentation defect. It does not block a
documentation freeze and it is not within this pass's mandate — the instruction forbade modifying application code.

### 8.2 Repository synchronisation

`local main` = `03fa856`. `github/main` last fetched at `a030b07`. The four intervening commits are
`2054cf1` → `c9df348` → `bdc9ba5` → `03fa856`, all authored by the environment's end-of-turn auto-backup, which
captured the review report and the correction edits mid-flight. `a030b07` is confirmed an ancestor of `HEAD`, so
the history is linear and fast-forwardable. The push and the `local main == github/main` verification are
performed in the commit that accompanies this report; the result is reported in chat.

---

## 9. Governance impact

| Question | Answer |
|---|---|
| Documents modified | **6** (plus this report, new) |
| Any **ranked** document modified? | **No.** `MASTER_PRD.md`, all ADRs, `Student_Identity_PRD_v1.md`, `Authentication_PRD_v2.md`, Library PRD, all of `docs/10-architecture/`, all of `docs/00-governance/` — diff **empty** |
| Any **frozen** document modified? | **No** |
| ADR required? | **No.** All six are unranked or `DRAFT` under `DOCUMENTATION_BASELINE.md` §4 (L152–176) |
| Application code modified? | **No.** `lib/`, `test/`, `tool/`, `packages/`, `pubspec.yaml`, `web/`, `android/` all byte-identical |
| New bounded context? | **No** |
| New integration edge asserted? | **No.** The `BC-26` question is registered as `SM-GAP-11`, not answered |
| PRD-004 status | **`DRAFT`. Not frozen.** |
| Stage 5 mechanical-registration gate | **Now satisfiable** — matrix §2C agrees with the script, 0 collisions |
| Open `SM-GAP-*` decisions | **11** (was 10) — each requires a named owner; two require an external ADR |
| Net governance effect | Six documents that disagreed with each other now agree, and each disagreement is explained in place rather than silently overwritten |

---

## 10. Remaining external issues

Neither was resolved inside PRD-004, per instruction.

### G-1 — `SID-5.9` vs `PRD-003` §2.2: is Date of Birth mandatory?

**Still applicable.** `SID-5.9` (L1120) states DOB *"SHALL be stored, because minor-safety obligations (ID-6)
depend on it"*, while the §2.2 *Global Profile* Optional list (L309) includes it. Both are Rank 3 and frozen.
PRD-004 handles the contradiction defensively — `SM-4.5a`–`SM-4.5c` fail safe to minor when DOB is absent, and
`SM-AC-29` tests it — but **cannot resolve it**. Registered as **`SM-GAP-10`**. Resolution requires the
Student Identity PRD owner and an ADR. This pass corrected only the citation (§2.4 → §2.2), not the substance.

### G-2 — BC Map §8 vs §7: is `BC-26` a consumer of `BC-01` events?

**Still applicable, and now registered.** §8 names `BC-26` a primary consumer of `enrollment.StudentEnrolled`
and `enrollment.StudentProfileUpdated`; §7 declares no `BC-01`→`BC-26` edge; L292 states an edge absent from §7
*"does not exist"*. A frozen Rank 4 document contradicts itself. PRD-004 now **discloses** this in §7.4 and
records it as **`SM-GAP-11`**, without asserting the edge. Resolution requires the architecture owner and an ADR.

### Standing items outside this pass

`TASK-D10`/`BLK-01` (P0, gate 3 red, ADR-0012 earliest expiry 2026-10-31) · `IMPL-020`/`BLK-02` ·
`IMPL-220`/`BLK-03` · `GCP-02`/`BLK-04` · `PRD-012a`/`BLK-05` · **0 of 32 acceptance criteria executed as tests** ·
`genspark` remote returning HTTP 404 server-side · 19 unwritten V1 PRDs.

---

## 11. Verdict

### **A — READY FOR FINAL FREEZE REVIEW**

Reasoning, stated so it can be challenged:

1. **Both HIGH findings are fully fixed and mechanically verified.** `SR-01`'s freeze-blocking count divergence is
   closed — matrix §2C now agrees with the script that produced it, and the task documents hold identical sets.
   `SR-02`'s three inverted requirements read as prohibitions, with the negated-MUST *and* double-negative scans
   both returning empty, and `X-13` strengthened rather than weakened.
2. **The mandated MEDIUM finding is fixed.** `SR-10`'s two guardian/DOB paths have objective criteria, and the
   three DOB cases now partition without overlap or silence.
3. **Every other genuine defect found is fixed** — `SR-03`, `SR-04`, `SR-05` (as a registered gap), `SR-06`,
   `SR-07`, `SR-08`, `SR-09`.
4. **No finding was left silently open.** Six residual observations are recorded in §4 with the reason no
   requirement was manufactured for them; one was rejected in §5 with the disproving quotation.
5. **The Stage 5 mechanical-registration gate is now satisfiable** — the precise condition that made freeze
   impossible before this pass.
6. **All six preservation constraints hold**, and the only material change to the architecture story is that a
   Rank 3 frozen authority (`SID-2.7`) is now cited where a Rank 5 ruling was over-claimed. That is strictly
   better-founded than what it replaced.
7. **Validation is green where it depends on this pass** — format, analyze, architecture tests, full suite
   (`+77`), links (572/0), YAML (4/4), ID contiguity, AC integrity, frozen-document integrity, diff scope. The one
   red gate is pre-existing code debt with waivers, and its independence from this pass is proved three ways.

**Why not B.** Nothing remaining is a defect in PRD-004's normative content. The residuals are coverage *shape*
(`SR-11`), an unused vocabulary entry whose "fix" would violate `SID-4.56` (`SR-12`), tooling hygiene with zero
measured effect (`SR-14`), optional additional criteria (`SR-15`, `SR-16`), and a structural fragility whose
concrete instance is fixed (`SR-17`). Another correction round would have to manufacture requirements to justify
itself, which the instruction forbids.

**Why not C.** No architectural blocker exists *within PRD-004*. The two external contradictions are recorded as
`SM-GAP-10` and `SM-GAP-11` and are defects in other documents. PRD-004 composes exactly the contributor set that
`SID-2.7` authorises, adds no edge, and creates no context. `BC-01`'s ownership, the Enrollment/Membership
separation and the read-composition boundary are all intact.

**Caveats the freeze reviewer should weigh explicitly:**
- **11 open `SM-GAP-*` decisions**, two needing an external ADR (`SM-GAP-10`, `SM-GAP-11`). Whether a PRD may
  freeze with open gaps is a governance call, not mine.
- **0 of 32 acceptance criteria are executed as automated tests.** Under `SID-4.56` — *"a rule that cannot be
  checked SHALL be treated as unmet"* — the criteria are specified but not yet demonstrated.
- **13 requirements remain untraced (5.4%).** Each is named in §10.5.1.

**PRD-004 is NOT frozen by this report.** Per instruction, work stops here and awaits final freeze authorization.

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Initial issue. Final correction pass following `PRD-004_SECOND_INDEPENDENT_REVIEW.md`. 16 of 17 findings verified, 9 fixed, 1 rejected (`SR-13`, disproved against `PRD-004_CORRECTION_REPORT.md` §3 L160), 6 recorded as non-defects. Final counts: **251** base / **266** total identifiers, **227/240 = 94.6%** traceability, **32** acceptance criteria, **24** implementation tasks, **11** proposed gaps. Verdict **A — READY FOR FINAL FREEZE REVIEW**. PRD-004 not frozen. |

---

*Every count in this report is reproducible by re-running the scripts named in §8 against the commit that
carries it. Where a figure differs from a figure in an earlier document, the earlier figure is identified and
withdrawn rather than quietly replaced.*
