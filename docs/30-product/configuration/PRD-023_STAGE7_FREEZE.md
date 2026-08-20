# PRD-023 — Stage 7 Freeze & Governance Record

| Field | Value |
|---|---|
| **Document** | Stage 7 record for `PRD-023` — Settings & Configuration |
| **Subject** | [`PRD-023_SETTINGS_AND_CONFIGURATION.md`](PRD-023_SETTINGS_AND_CONFIGURATION.md) **v0.1** |
| **Stage** | **Stage 7 — Freeze & Governance** (`PRD_LIFECYCLE.md` **L155–175**) |
| **Verdict** | **PASS — `PRD-023` is `FROZEN` at Rank 3** |
| **Conferring authority** | `ACCEPTED` [`ADR-0053`](../../00-governance/adr/ADR-0053-configuration-prd-v0.1-baseline.md) + the row in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3/§4 |
| **Baseline** | **`BASELINE-2026-08-20-A`** (supersedes `BASELINE-2026-08-19-C`) |
| **Subject hash before** | `e97496083a76bfb0f45be9acae754050c374561b64734df5738dac7ff6399326` |
| **Subject hash after** | `2fbd5b570341334adc2fd277a0592b004c08b3fbe5d4011182f85e429c599f56` — **changed, and §3 says why** |
| **Requirement body hash** | `46bafc38ac726e09b0fe736c42b72736936528a72d8f2554b7780db26a47d922` — **identical before and after** |
| **Date** | 2026-08-20 |
| **Precedence** | **None.** This is a stage record. It reports a conferral made elsewhere and confers nothing itself |

> **This document does not freeze anything.** `PRD_LIFECYCLE.md` L155–175: *"Freeze is **conferred, not claimed**. No PRD
> in this repository declares itself frozen."* The freeze was effected by `ADR-0053` and by the baseline row. This record
> exists so that the act can be **audited**, including in the places where it is incomplete.

---

## 1. The gate, and the artefact that satisfies it

`PRD_LIFECYCLE.md` **L41–42** sets the standard this record is measured by:

> *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed, **however complete the work feels**."*

Stage 7's artefact is **not** this document, and not a verdict. It is, verbatim from **L155–175**:

> *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."*

| Requirement | Artefact | Verified |
|---|---|---|
| A row in `DOCUMENTATION_BASELINE.md` §3 | §3.3 — the `PRD-023` authoritative module-baseline row | ✅ present |
| At an **assigned precedence rank** | §4 — new **Rank 3** row, *"Everything inside `BC-25` Configuration … the resolution machinery, not the value list"* | ✅ present |
| An ADR **before** the change (baseline §7 rule 1) | `ADR-0053`, **Accepted**, written first | ✅ present |
| A new baseline identifier (§7 rule 4 — a Rank 1–3 document changes) | `BASELINE-2026-08-20-A` | ✅ issued |

**Why the gate is the one that matters.** L155–175 calls it *"the gate that matters most, because it changes what
everyone else may do."* Before this row, `PRD-023` was a draft anyone could edit. After it, baseline §7 rule 1 requires
an ADR **before** any change to it. The freeze is therefore a **restriction on future authors**, which is why §7 of this
record is careful about what it does *not* license.

---

## 2. Order of operations, because the order is itself a rule

`DOCUMENTATION_BASELINE.md` **§7** states four rules. Three of them are about *sequence*, and getting the sequence wrong
would have produced a defective record even with every individual edit correct. The `PRD-014` precedent
([`../entitlement/PRD-014_STAGE7_FREEZE.md`](../entitlement/PRD-014_STAGE7_FREEZE.md) §2) is explicit: *"`ADR-0052` was
written **first** and only then were the baseline, index and registry touched."*

| # | Rule (verbatim) | How it was satisfied |
|---|---|---|
| 1 | *"A change to any Rank 1–5 document requires an ADR **before** the change."* | `ADR-0053` was written and set to **Accepted** as the **first** write of this stage. Baseline, index, registry and PRD were touched only afterwards. Verified by `ls` before writing: the file was **absent**, so an earlier interrupted attempt had not landed and was redone rather than assumed |
| 2 | *"The changed document's version is incremented and its changelog updated in the same commit."* | `DOCUMENTATION_BASELINE.md` — new baseline identifier + §8 changelog row, same commit. `PRD-023` — changelog row added; ⚠ **version deliberately NOT incremented**, see §3 |
| 3 | *"This declaration is updated in the same commit. A baseline that does not match the repository is worse than no baseline."* | §3.1, §3.3, §3.4, §4, §6 and §8 all updated in the same commit as `ADR-0053`. This rule is also what compelled repairing two stale cells — see §4 |
| 4 | *"The baseline identifier changes only when a Rank 1–3 document changes version."* | A **Rank 3** document *entered* the baseline, so a new identifier was issued: **`BASELINE-2026-08-20-A`** |

**Order actually executed:** `ADR-0053` → `DOCUMENTATION_BASELINE.md` → `ADR-INDEX.md` → `PRD_REGISTRY.md` → the PRD's
freeze metadata → this record → re-run the checkers.

---

## 3. The PRD hash changed, and that is disclosed rather than glossed

Through Stages 1–6 the subject hash was verified **identical at every stage boundary** — `e9749608…9326`, checked
**seven** separate times — because a review record measures a document *at a revision*, and a stage that silently edits
its subject invalidates every record that preceded it.

**Stage 7 changed it, to `2fbd5b57…9f56`.** Five header cells were edited, plus one changelog row:

| Cell | Before | After |
|---|---|---|
| `Status` | `` `DRAFT` `` — *"Stages 3–7 not yet run"* | `` `FROZEN` `` + the note that status is conferred by the **baseline row, not by the cell**, and that `FROZEN` is not `VERIFIED` |
| `Lifecycle stage` | *"Stage 2 — Draft"* | *"Stage 7 — Freeze & Governance, **PASSED**"*, each stage's record linked; **Stage 8 not begun** |
| `Registry status` | `` `PLANNED` `` … *"Not changed by this document"* | `` `FROZEN` `` … *"Still not changed **by** this document"* |
| `Rank` | *"**None yet.** … not claimed here"* | *"**Rank 3** — conferred … **not claimed here**"* + the FOUNDATIONAL band at 3 of 3 |
| `Baseline` | *"Written against `BASELINE-2026-08-19-C`"* | *"Admitted under **`BASELINE-2026-08-20-A`**"*, prior text retained verbatim |
| §17 changelog | one `v0.1` row (creation) | + one `v0.1` row recording the freeze and what it does **not** assert |

**Why this is legitimate where an earlier edit would not have been.** The change is **metadata recording the
conferral**, not content. That claim is *proven*, not asserted:

```
git diff -U0  hunks touched : lines 8, 16, 18-20, 22 (header) and the §17 changelog tail only
requirement body            : old lines 23-1437  vs  new lines 36-1450
body sha256 BEFORE          : 46bafc38ac726e09b0fe736c42b72736936528a72d8f2554b7780db26a47d922
body sha256 AFTER           : 46bafc38ac726e09b0fe736c42b72736936528a72d8f2554b7780db26a47d922   IDENTICAL
register counts before/after: CNF-FR 82/82  CNF-BR 11/11  CNF-INV 4/4  CNF-EVT 0/0
                              CNF-XC 16/16  CNF-CFG 0/0   CNF-AC 59/59  CNF-GAP 8/8
```

No requirement, invariant, exclusion, acceptance criterion, identifier, business rule or gap was added, removed or
reworded. **The version deliberately does not move** — `ADR-0020` §4 item 2, *"Freeze confers status; it does not
renumber,"* whose §5 expressly rejects *"renumber to v1.0 to mark the freeze."*

**It is disclosed because the alternative is worse.** Stages 1–6 each published `e9749608…9326`. A reader who recomputes
the hash today gets a different value, and without this section that mismatch is indistinguishable from an undisclosed
edit. The three `PRD-023` gate checkers were re-run **after** the change and all three still exit 0, which is the
mechanical evidence that no measured figure moved:

```
prd023_traceability.py   EXIT 0   uncovered measured 37 / named 40 (S4-D-01)  UNDISCLOSED 0
prd023_stage5.py         EXIT 0   180 identifiers / 8 registers / 0 collisions in three directions
prd023_task_coverage.py  EXIT 0   30 tasks / IMPL-1100..1129 / 113 of 113 = 100.0% / 0 of 59 proven
```

### 3.1 ⚠ A consequence of the hash change that NO gate detects, stated because nothing else will state it

Four documents now cite a hash their subject no longer has:

| Document | Cites | Now |
|---|---|---|
| `PRD-023_STAGE4_REQUIREMENTS_REVIEW.md` | `e9749608…9326` | stale |
| `PRD-023_STAGE5_CONFERRAL.md` | `e9749608…9326` | stale |
| `../../40-implementation/configuration/PRD-023_IMPLEMENTATION_TASKS.md` | `e9749608…9326` | stale |
| `ADR-0053` §2 / §2.1 | `e9749608…9326` | stale **by design** — it records the hash it measured |

⚠ **`tool/docs_check/alignment_record_freshness.py` does NOT cover `PRD-023`.** Its `RECORDS` list (L78–86) contains
exactly two entries, `PRD-008` and `PRD-019`; `grep -c 'PRD-014'` on it returns **0**, so the same blind spot applied to
the three freezes before this one. **The staleness above is therefore real and mechanically undetected** — the full
checker sweep returns *"total nonzero = 5"*, exactly the known pre-existing set, which is a **silence about `PRD-023`,
not a clearance of it.**

**Why the records were NOT edited to the new hash.** Each is a review record, and a review record states what was
measured **at the revision it measured**. Rewriting the cited hash would make each record claim it had reviewed bytes it
never saw. The precedent is settled and cited in the freshness gate's own header (L52–56): *"a stale review is corrected
by a dated re-run beside it, not by editing what it concluded."* Since no requirement byte changed, no re-run is
warranted, and the correct action is disclosure — which is this subsection.

**Why the gate was NOT extended to cover `PRD-023`.** Adding a `RECORDS` entry would mean **modifying a checker in the
same act that admits the document it checks** — teaching a gate about its own subject at the moment of admission. That
is the failure this repository has refused at every freeze. Extending the gate's coverage to all frozen PRDs is a
**Governance Owner** act; it is recorded here as an open item, not performed here.

---

## 4. What was changed, and what was deliberately not

### 4.1 Changed

| File | Rank | Change |
|---|---|---|
| `adr/ADR-0053-…md` | Rank 2 | **Created**, `Accepted`. 365 lines, 12 sections, on `ADR-0052`'s structure |
| `DOCUMENTATION_BASELINE.md` | **Rank 1** | Header → `BASELINE-2026-08-20-A`; §3.1 self-reference repaired; §3.3 **+3 rows**; §3.4 **+1 row**; §4 Rank 2 count corrected **+** new **Rank 3** row; §6 **+`GCP-20`, +`GCP-21`**; §8 new changelog row |
| `adr/ADR-INDEX.md` | Rank 2 | `Count` **39 → 40** accepted / **52 → 53** files, `proposed` unchanged at 13; register row for `ADR-0053`; change-history row |
| `PRD_REGISTRY.md` | **unranked** | §4.3 L327 `PLANNED` → **`FROZEN`**; §7 five count fields re-derived |
| `PRD-023_SETTINGS_AND_CONFIGURATION.md` | Rank 3 *(as of now)* | **Freeze metadata only** — five header cells + one changelog row. Version **not** moved. See §3 |
| `PRD-023_STAGE7_FREEZE.md` | none | **This document** |

**Two pre-existing defects were repaired, and only because rule 3 compelled it.** Both sit in cells this admission had
to write in; leaving a cell wrong while extending it produces a worse record than either state alone (`ADR-0020` §3.6):

| Defect | Was | Now |
|---|---|---|
| Baseline §4 Rank 2 count | *"38 accepted of 51 files"*, enumerating to `ADR-0051` | **"40 accepted of 53 files"** — ⚠ **`GCP-16`/`GCP-19` recurring a third time in the one cell they were opened to fix** |
| Baseline §3.1 self-reference | `BASELINE-2026-08-05-A` — three baselines stale | `BASELINE-2026-08-20-A` — ⚠ **`GCP-15` recurring after being recorded CLOSED on 2026-08-19 for this exact cell**; the `-B` and `-C` admissions each moved the header without moving the cell |

### 4.2 Deliberately NOT changed

| Item | Why not |
|---|---|
| ⚠ **`GCP-20`** — baseline §4 missing the `PRD-014` Entitlement Rank 3 row | **Explicit standing instruction: do not repair this unrelated defect silently.** Carried into this record instead. See §4.3 |
| ⚠ **`GCP-21`** — baseline §3.2 records `ARCHITECTURE_RULINGS.md` v1.2, that file's L6 reads **v1.1** | **Newly discovered here.** It is **not established** which record is wrong; writing either value settles a question by assertion. Opened, not closed |
| `S4-D-01` — §12 names 40 uncovered where 37 are uncovered | **Disclosed, not repaired.** It *understates* coverage — the safe direction — and editing it would change the hash Stages 3–6 are anchored to, invalidating every measurement taken against it |
| `PRD-023` **version** | `ADR-0020` §4 item 2 and §5 |
| The **8 `CNF-GAP-*`**, `CNF-GAP-001` included | Freeze does not close gaps. `CNF-GAP-001` (aggregate ownership) was admitted by Stage 3 **as an open conflict**, routed to the Architecture Owner. Settling it here would have manufactured a resolution to make a gate green |
| The four stale hash citations | §3.1 |
| `alignment_record_freshness.py` `RECORDS` | §3.1 — no checker modified in the act that admits its subject |
| `CNF-EVT-*`, `CNF-CFG-*` | Admitted **EMPTY**. Minting a member would annex another PRD's property while freezing this one |
| `MASTER_PRD.md`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, `CONFIGURATION_GUIDE.md`, `tool/module_dependencies.yaml` | Out of scope. `ADR-0017` §3.2: *"This ADR moves no requirement."* Neither does this freeze |
| `lib/`, `packages/`, `test/`, `web/`, `pubspec.yaml` | **0 lines changed.** This is a documentation act |
| `ADR-0021`…`0031`, `0038`, `0041` | Stay `PROPOSED`. Nothing here promotes an ADR |
| The 7 missing architecture tests | `CNF-GAP-008` stays OPEN. `SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet"* |

### 4.3 ⚠ `GCP-20` — carried explicitly, and its surviving consequence stated

Measured, not read:

```
baseline §4 rows at Rank 3, before this admission : 10
baseline §3.3 module baselines, before            : 11      -> GCP-20 CONFIRMED (missing: PRD-014 Entitlement)
after this admission: §4 = 11 rows  vs  §3.3 = 12 baselines -> THE GAP SURVIVES
```

Because §4 is **not** repaired while the `PRD-023` Rank 3 row **is** added, the arithmetic discrepancy **survives this
admission by design**. It is stated here, in `ADR-0053` §3.2 and in the baseline's own §6 `GCP-20` row, rather than left
for a reader to discover by counting rows. **Repairing it requires the Entitlement row, which is a `PRD-014` act under
`ADR-0052`, not a `PRD-023` act** — which is precisely why the instruction forbade folding it in here.

### 4.4 ⚠ `PRD_REGISTRY.md` was edited without a version bump, and that follows precedent rather than convenience

Baseline §7 rule 2 requires a version bump for a **changed document**, but rule 1 scopes the ADR requirement to **Rank
1–5**. Measured: `PRD_REGISTRY.md` appears in baseline §3 **0** times and in §4 **0** times — it is **unranked**. Its own
header states *"Navigational and administrative only … **Precedence:** Below every document it lists"* and *"Where this
register disagrees with a PRD, **the PRD is right and this register is a defect**."* Its version stands at **v2.1 /
2026-08-15**, and `grep 'ADR-005[012]'` over its §10 change history returns **0** — i.e. the three freezes immediately
preceding this one each edited §4.3 and §7 **without** bumping it. This pass follows that precedent and **discloses it
rather than relying on it silently**; whether an administrative register ought to carry a version discipline is a
Governance Owner question, recorded here and not decided here.

---

## 5. Counts re-derived, not incremented

Every figure below was recomputed by an instrument. `ADR-INDEX.md`'s own `Count` row records that this instrument has
been **wrong four times historically** — once a loose window match scored 28 by matching *"accepted"* inside
*"deliberately not self-accepted"* — so incrementing was not an option.

| Measure | Before | After | How derived |
|---|---|---|---|
| ADR files | 52 | **53** | `ls docs/00-governance/adr/ADR-0*.md \| wc -l` |
| ADR `Accepted` | 39 | **40** | Classifier over all files' own `Status` rows, stripping `**` **and** backticks, leading declared token |
| ADR `Proposed` | 13 | **13** | Same pass — **deliberately unchanged**; only `accepted` moves |
| Unclassified | 0 | **0** | Sum reconciles to the file count both times |
| Registry `FROZEN` | 11 | **12** | Enumerating §4.3's status column |
| Registry `PLANNED` | 10 | **9** | Enumerating §4.3; `PRD-023` written out member-by-member, since a range `PRD-020`…`PRD-023` would now silently contain a frozen document |
| Documents that exist | 16 files / 14 identities | **17 / 15** | ⚠ **asymmetric**: identities **measured** by sweeping `docs/30-product/` for specification documents; the **file** count **incremented and labelled as such**, because the row still states no rule for what counts as one file — `GCP-18`'s disclosed residue |
| Missing V1 PRDs | 12 | **11** | Derived from the above; the eighth decrease in that row's history |
| Baseline §4 Rank 3 rows | 10 | **11** | `grep -c` on §4 — against §3.3's 12. See §4.3 |

**Subject figures, recomputed from the PRD's own bytes rather than copied from the stage reports:**

```
CNF-FR   82 (001..082)   CNF-BR  11 (001..011)   CNF-INV  4 (001..004)   CNF-EVT  0 EMPTY
CNF-XC   16 (001..016)   CNF-CFG  0 EMPTY        CNF-AC  59 (001..059)   CNF-GAP  8 (001..008)
TOTAL 180 identifiers / 8 registers / 113 Class A obligations / all ranges contiguous
acceptance coverage 76 / 113 = 67.3%    task coverage 113 / 113 = 100.0%    AC proven 0 of 59
```

⚠ **The two coverage figures are different claims and are never merged.** Task coverage is 100% because every obligation
is allocated to a task. Acceptance coverage is 67.3% because all **16 `CNF-XC-*`** are uncovered **by construction** — an
exclusion states what must be *impossible*, and a criterion asserting that something never happens is unfalsifiable by
observation — plus **21** definitional `CNF-FR-*` and **3** rule-restating `CNF-BR-*`. Collapsing them into one headline
is exactly the `PRD-006` v1.0 failure, which published *"100% coverage"* against a true **49.1%**.

---

## 6. What `FROZEN` does and does not mean here

| `FROZEN` **does** mean | `FROZEN` does **NOT** mean |
|---|---|
| The document holds **Rank 3** and sits at an assigned precedence | That it is **implemented**. 0 of 30 `IMPL-1100`…`1129` tasks are begun |
| Changing it requires an **ADR before the change** (baseline §7 rule 1) | That it is **verified**. **0 of 59** `CNF-AC-*` are proven by a test |
| Its 180 identifiers are the authoritative `CNF-` namespace | That its acceptance coverage is complete — it is **67.3%**, and the uncovered set is **named** |
| Lower-ranked documents must conform to it | That its **gaps are closed**. All **8 `CNF-GAP-*` are OPEN**, `CNF-GAP-001` among them |
| `BC-25`'s ownership is settled per `ADR-0017` §3.1's six items | That `BC-25`'s **aggregate** is settled — `CNF-GAP-001` is an admitted open conflict for the Architecture Owner |
| The resolution **machinery** is specified | That the **value list** is owned here. `CNF-CFG-*` is empty; the 104 census configurables stay with their 8 owners |
| Stage 7 is complete | That **Stage 8** has begun, or that the 7 architecture tests exist — they do not (`CNF-GAP-008`) |
| The governance record is auditable | That the governance record is **clean** — **`GCP-20` and `GCP-21` are carried unrepaired**, and §3.1's staleness is undetected by any gate |

---

## 7. Verdict

**The eight final-gate conditions, each tested rather than asserted:**

| # | Condition | Evidence | Result |
|---|---|---|---|
| 1 | Status = `FROZEN` | Baseline §3.3 + §4 Rank 3 rows present; registry §4.3 L327 reads `FROZEN`; PRD header transcribes it | ✅ |
| 2 | Version = **v0.1** | PRD `Version` cell unchanged; `ADR-0020` §4 item 2 / §5 cited | ✅ |
| 3 | `ADR-0053` = **ACCEPTED** | `Status` row reads **Accepted**; counted by the classifier as 1 of 40 | ✅ |
| 4 | Implementation range = `IMPL-1100`…`1129` | `prd023_task_coverage.py` prints the allocated range; no reach into the `IMPL-1030`–`1099` foreign reserve | ✅ |
| 5 | CNF registers mechanically valid | `prd023_stage5.py` EXIT 0 — 180 / 8 registers / contiguous / 0 collisions in three directions / both empty registers empty **in fact** | ✅ |
| 6 | Traceability complete | `prd023_traceability.py` EXIT 0 — **0 undisclosed** uncovered obligations; matrix §2L registers every register and nothing more | ✅ |
| 7 | All known governance gaps disclosed | 8 `CNF-GAP-*`, `S4-D-01`, **`GCP-20`**, **`GCP-21`**, the 4 stale hash citations, the freshness-gate blind spot, the registry version question, 7 missing tests — all named in §3.1, §4.2, §4.3, §4.4 and §6 | ✅ |
| 8 | No unrelated frozen document altered | `git status` limited to: `ADR-0053` (new), `ADR-INDEX.md`, `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md`, the subject PRD, this record. `MASTER_PRD.md`, BC Map, Dependency Matrix, `ARCHITECTURE_RULINGS.md`, every other PRD, every other ADR, all of `tool/`, and `lib/`+`packages/`+`test/`+`web/` **byte-unchanged** | ✅ |

**STAGE 7 VERDICT: PASS. `PRD-023` — Settings & Configuration is `FROZEN` at v0.1, Rank 3, under
`BASELINE-2026-08-20-A`.**

⚠ **Condition 7 passes on *disclosure*, not on cleanliness.** Two governance defects (`GCP-20`, `GCP-21`) are carried
unrepaired by instruction and by insufficient evidence respectively; four records cite a stale hash that no gate
watches. A freeze recorded as clean would have been the false version of this verdict.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Created at Stage 7. Records the conferral of `FROZEN` / Rank 3 on `PRD-023` v0.1 by `ACCEPTED` `ADR-0053` under `BASELINE-2026-08-20-A`, on the 8-section `PRD-014_STAGE7_FREEZE.md` template. Discloses: the subject hash change with the requirement body **proven** byte-identical (§3); ⚠ the **four stale hash citations and the fact that `alignment_record_freshness.py` does not cover `PRD-023`**, so that staleness is real and mechanically undetected (§3.1); **`GCP-20` carried unrepaired by explicit instruction, with the §4-vs-§3.3 gap surviving the admission by design** (§4.3); **`GCP-21` newly opened rather than settled by guessing** (§4.2); `S4-D-01` disclosed not repaired; the two stale cells repaired **only** because rule 3 compelled it, logged as **`GCP-15`/`GCP-16`/`GCP-19` recurrences** (§4.1); and ⚠ the registry edited without a version bump, following the three prior freezes' precedent and **saying so** (§4.4). All counts re-derived by instrument (§5). Verdict **PASS** on 8 of 8 conditions, with condition 7 passing on **disclosure, not cleanliness** (§7) |

---

*End of `PRD-023` Stage 7 Freeze & Governance record v1.0. **Stage 8 is not begun**, and nothing in this document
authorises it.*
