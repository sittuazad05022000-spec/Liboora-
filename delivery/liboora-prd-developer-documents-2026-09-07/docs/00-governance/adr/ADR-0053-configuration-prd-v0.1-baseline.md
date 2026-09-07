# ADR-0053 — `PRD-023` Settings & Configuration v0.1 admitted to the baseline at Rank 3

| Field | Value |
|---|---|
| **ADR** | `ADR-0053` |
| **Status** | **Accepted** |
| **Date** | 2026-08-20 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct conferral of the human principal of this engagement, §6 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits a new document to Rank 3 and records the admission in `DOCUMENTATION_BASELINE.md` §3.1/§3.3/§4/§6/§8, `ADR-INDEX.md` and `PRD_REGISTRY.md` §4.3/§7 |
| **Amended by** | Nothing |
| **Baseline** | **`BASELINE-2026-08-20-A`** — issued because a **Rank 3** document enters the baseline (`DOCUMENTATION_BASELINE.md` §7 rule 4) |
| **Closes** | `PRD_LIFECYCLE.md` **Stage 7** for `PRD-023`; registry `PLANNED` → **`FROZEN`**; `ADR-0017` §5.3's deferred number-collision question, decided mechanically at Stage 5 |
| **Does NOT close** | `CNF-GAP-001`…`CNF-GAP-008` (all **8 OPEN**) · `H-1` · `Q-01`…`Q-07` · `PGA-03`…`PGA-10` including **`PGA-08`** · `GCP-14` · **`GCP-20`** (§3.2) · the stale `IMPL-227+` table in Rank 1 `PRD_LIFECYCLE.md` · `S4-D-01` · `S5-C-01`, `S5-C-02`, `S5-C-03`, `S5-F-01`, `S5-F-02` · the seven missing architecture tests of Matrix §10.3 · the 9 `app → domain/library` boundary findings · `ADR-0021`…`0031`/`0038`/`0041` remain `Proposed` |
| **Opens** | **`GCP-20`** — `DOCUMENTATION_BASELINE.md` §4 never received a Rank 3 row for `PRD-014` Entitlement when `BASELINE-2026-08-19-C` admitted it. **Carried, not repaired** (§3.2). **`GCP-21`** — §3.2 of the baseline records `ARCHITECTURE_RULINGS.md` at **v1.2** while the file's own version row reads **v1.1**; left unrepaired because it is not established which is wrong (§8.1 drift 4). ⚠ **The pre-existing-defect search was performed and did NOT return empty** — four measured drifts are recorded in §8.1 rather than absorbed, following the `ADR-0051` §8.1 discipline |
| **Related** | `ADR-0017` (the registration this ADR executes) · `ADR-0020` §4 item 2 / §5 (freeze does not renumber) · `ADR-0050`, `ADR-0051`, `ADR-0052` (the three prior v0.x admissions) · `ADR-0033` §7.1 (a conferral is not a standing licence) |

---

## 1. The question

May `docs/30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md` **v0.1** be admitted to
`DOCUMENTATION_BASELINE.md` at **Rank 3** as the authoritative specification for **`BC-25` Configuration**, and may
`PRD_REGISTRY.md` move `PRD-023` from **`PLANNED`** to **`FROZEN`**?

`ADR-0017` **§3.3** registered the document and expressly declined to write it: *"It **registers** a document; it does
not write one."* This ADR answers the remaining question — whether the document that was then written may be admitted.

**What is asked is narrower than it looks.** Admission confers Rank 3 authority over `BC-25`. It does not certify that
the module works, that its requirements are tested, or that its open questions are answered. §7 states what acceptance
does not license.

---

## 2. Evidence — the artefacts, not the feelings

`PRD_LIFECYCLE.md` **L41–42**: *"A gate is not an opinion — if the artefact does not exist, the stage has not been
passed, **however complete the work feels**."* Each stage is therefore evidenced by a file, not by a claim.

| Stage | Artefact | Verdict |
|---|---|---|
| 1 Discovery | `30-product/configuration/PRD-023_STAGE1_DISCOVERY.md` | **PASS** — `BC-25` identified and unowned; prefix `CNF-` selected by measurement; `IMPL-1100` identified next-free as measurement `M-22` |
| 2 Draft | `30-product/configuration/PRD-023_SETTINGS_AND_CONFIGURATION.md` v0.1 | The document itself, 1443 lines, 8 registers declared in §0.2 **before** use |
| 3 Architecture | `30-product/configuration/PRD-023_ARCHITECTURE_ALIGNMENT.md` | **✅ ALIGNED — PASS, 6 of 6, UNCONDITIONAL.** 10 owned / 13 ceded / 6 edges examined, **0 edges created**; 8 findings accepted, 11 rejected with reasons |
| 4 Requirements | `30-product/configuration/PRD-023_STAGE4_REQUIREMENTS_REVIEW.md` | **✅ PASS 6 of 6.** 113/113 testable; 16/16 impossibility statements; 0 configurables minted; 0 orphans; 0 undisclosed uncovered; 0 restatements. `D-01`…`D-06` deferred with named owners |
| 5 Conferral | `30-product/configuration/PRD-023_STAGE5_CONFERRAL.md` + `TRACEABILITY_MATRIX.md` **§2L** (v1.16) | **✅ GATE SATISFIED — CONFERRED.** 180 identifiers / 8 registers / **0 collisions in three directions** / 20 citations, all §2L's own / 0 definitions outside the module |
| 6 Tasks | `40-implementation/configuration/PRD-023_IMPLEMENTATION_TASKS.md` | **✅ PASS.** `IMPL-1100`…`IMPL-1129`, 30 tasks in 3 waves, **113 of 113 = 100.0%** of Class A obligations claimed, 9 blockers classified |
| 7 Freeze | `30-product/configuration/PRD-023_STAGE7_FREEZE.md` + the §3.3 row this ADR authorises | This document |

**Three independent instruments, three parsing strategies, all exit 0**, re-run immediately before this ADR was
accepted:

```
python3 tool/docs_check/prd023_traceability.py    → EXIT 0   (PRD vs itself; never opens the matrix)
python3 tool/docs_check/prd023_stage5.py          → EXIT 0   (register census; scope-position parsing)
python3 tool/docs_check/prd023_task_coverage.py   → EXIT 0   (task document; re-derives the obligation set itself)
```

None of the three imports another. `TRACEABILITY_MATRIX.md` §2H.2 names the failure this avoids: *"a checker written in
the same pass as the register it checks, by the same author, verifies agreement with itself."*

### 2.1 Figures computed from the PRD, not copied from the reports

```
CNF-FR-*    82   001..082  contiguous        CNF-XC-*   16   001..016  contiguous
CNF-BR-*    11   001..011  contiguous        CNF-CFG-*   0   DECLARED EMPTY
CNF-INV-*    4   001..004  contiguous        CNF-AC-*   59   001..059  contiguous
CNF-EVT-*    0   DECLARED EMPTY              CNF-GAP-*   8   001..008  contiguous

TOTAL  180 identifiers / 8 registers / 113 Class A obligations
acceptance coverage  76 / 113 = 67.3%       task coverage  113 / 113 = 100.0%
collisions  0 forward · 0 reverse · 0 by substring
acceptance criteria PROVEN BY A TEST  0 of 59
```

**Coverage is admitted at its measured 67.3%, not rounded up.** The precedent being avoided is named in the PRD's own
Stage 6 record: `PRD-006` v1.0 once published *"100% coverage"* against a true **49.1%**.

**The two coverage figures are different claims and are not reconciled by averaging.** All **16 `CNF-XC-*` are
uncovered by construction** — an exclusion states what must be *impossible*, and a criterion asserting that something
never happens is unfalsifiable by observation. The remaining 37 uncovered obligations are 21 definitional `CNF-FR-*`,
3 rule-restating `CNF-BR-*`, and those 16 exclusions.

### 2.2 The version, and why it is **not** moved

`ADR-0020` **§4 item 2** — *"Freeze confers status; it does not renumber"* — and its **§5**, which expressly rejects
*"Renumber to v1.0 to mark the freeze."*

`PRD-023` is admitted at **v0.1**, the version every gate measured. It is the **fourth v0.x admission**, after
`PRD-013` (`ADR-0050`), `PRD-016` (`ADR-0051`) and `PRD-014` (`ADR-0052`). `ADR-0050` §5 had already **withdrawn as an
invented rule** the contrary claim that a v0.x document must first be released to a version before freeze, and
reviving it here would re-introduce a prohibition this repository has rejected in writing.

**The PRD's bytes were verified unchanged five times across Stages 5, 6 and 7** at
`sha256 e97496083a76bfb0f45be9acae754050c374561b64734df5738dac7ff6399326`, so every gate measured the same document.

### 2.3 Architectural conformance

`ADR-0017` **§3.1** fixed six owned items and **§3.2** fixed the exclusions with *"This ADR moves no requirement."*
Stage 3 measured both:

| Test | Result |
|---|---|
| All six `ADR-0017` §3.1 items owned, and no seventh | **6 of 6, no seventh** |
| Integration edges added | **0.** `E-19` names `BC-25` as provider (BC Map L328); `E-20`'s consumer column reads *"All contexts"* |
| Requirements moved from another PRD | **0.** No `LIB-*`, `LCFG-*`, `SID-*`, `SCFG-*` or `ICFG-*` identifier relocated |
| Configurables absorbed from the 104-item census | **0.** `PRD-023` owns *"the resolution machinery, **not** the value list"* (`ADR-0017` §3.1 item 6) |
| Authorisation, credential, OTP or session specified outside `BC-18` | **0 of 8 mentions** — all citations, prohibitions, cessions or exclusion text |
| Verdict conditionality | **UNCONDITIONAL** — stronger than `PRD-013`'s and `PRD-014`'s CONDITIONAL PASS, for one measured reason: `BC-25` sits in the **FOUNDATIONAL** band (BC Map **L271**), so the `H-1` capability→capability taxonomy gap that conditioned both predecessors **does not apply to it** |

### 2.4 Two empty registers, and why emptiness is the correct content

**`CNF-EVT-*` is empty as a finding, not an omission.** `BC-25` appears as a producer in **zero** BC Map §9 rows.
Minting an event name would have created an edge that BC Map **§7 L292** says *"does not exist"*.

**`CNF-CFG-*` is empty because of what this module is.** `ADR-0017` §3.1 item 6 gives `PRD-023` *"the resolution
machinery, **not** the value list"*, and the 104 configurables of the clean census (`CFG-*`, `LCFG-*`, `ICFG-*`,
`SCFG-*`, `SMCFG-*`, `MM-CFG-*`, `SEAT-CFG-*`, `ATT-CFG-*`) are already owned by **eight frozen PRDs**. A numbered
`CNF-CFG` member would have either duplicated an owned value or invented a new one. It is the **fourth**
declared-empty CFG register, after `TEN-CFG-*`, `AUD-CFG-*` and `ENT-CFG-*`.

**Emptiness is enforced, not merely asserted:** all three checkers fail if either register acquires a member.

---

## 3. Findings routed at the correct rank, and **not** fixed here

| Finding | Where it belongs | Disposition |
|---|---|---|
| `CNF-GAP-001` — `Library_PRD_v1.md` **L188** assigns aggregate `LibrarySettings` to `BC-25`; BC Map §8's 17 rows grant `BC-25` none. A Rank 3 vs Rank 4 conflict | Architecture Owner — needs an ADR amending BC Map §8 **or** `Library_PRD_v1.md` L188 | **OPEN.** The PRD asserts **no aggregate**, so the Stage 3 check-1 failure mode is not triggered. Choosing a side would amend a frozen document without authority |
| `CNF-GAP-002` — the `platform/configuration:settings` port has **7 declared consumers and 0 providers** | Technical Owner | **OPEN.** Scheduled, not resolved |
| `CNF-GAP-003`, `CNF-GAP-004`, `CNF-GAP-006` | Named owners in the PRD's §14 | **OPEN** |
| `CNF-GAP-005` — the `INV-10`…`INV-16` discrepancy against `PRD-001`'s `IMPL-015`/`016` startup validation of `INV-1`…`INV-9` | Architecture Owner | **OPEN.** §3.4 of the task document states the relationship **without** duplicating those two tasks and **without** closing the gap |
| `CNF-GAP-007` — `tool/module_dependencies.yaml` gives `platform/configuration` a rank but **no module block**, and `check_module_boundaries.dart` **L778** exempts blockless modules from `default_decision: deny` | Technical Owner | **OPEN.** Blocker `B-1`; hard-blocks 5 of the 30 tasks |
| `CNF-GAP-008` — **all seven** architecture tests required by Matrix §10.3 are missing, including `tenant_isolation_test.dart`; `test/architecture/` holds only `boundary_checker_test.dart` | Technical Owner | **OPEN.** Blocker `B-2`. `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet"* |

**No code was touched.** `git status --short lib/ packages/ test/ web/ pubspec.yaml` → **0 lines**, across this pass and
every prior span of this lifecycle.

### 3.1 `S4-D-01` — a defect in the PRD, disclosed and deliberately not repaired

The PRD **over-declares its own uncovered set by three**: it names 40 uncovered obligations where 37 are uncovered,
because `CNF-XC-005`, `CNF-XC-008` and `CNF-XC-014` *are* cited by `CNF-AC-038`, `CNF-AC-041` and `CNF-AC-048`.

It therefore **understates** its verification coverage — the safe direction. It is left unrepaired for a reason that is
mechanical rather than aesthetic: editing the PRD changes its hash, and every Stage 3, 4, 5 and 6 measurement is
anchored to `e974960…`. Repairing a conservative error would invalidate four gate records to make one number prettier.

### 3.2 `GCP-20` — carried explicitly, and NOT repaired

**Measured, not assumed.** `DOCUMENTATION_BASELINE.md` **§3.3** holds **11** authoritative module baselines while its
**§4** holds **10** Rank 3 rows: `PRD-014` Entitlement received a §3.3 row under `BASELINE-2026-08-19-C` and never
received a §4 row.

```
sed -n '220,258p' DOCUMENTATION_BASELINE.md | grep -c '^| \*\*3\*\* |'   →  10
§3.3 authoritative module baselines                                      →  11
missing: Entitlement PRD v0.1
```

This is the **tenth instance** of the class already logged as `GCP-01`, `GCP-07`, `GCP-08`, `GCP-11`, `GCP-12`,
`GCP-15`, `GCP-16`, `GCP-17`, `GCP-18` and `GCP-19` — *a derived statement left behind by a change to the thing it
describes* — and precisely the §7 rule 3 failure `GCP-07` recorded in this same table.

**It is opened as `GCP-20` and left unrepaired, on explicit instruction.** Repairing it would edit the Rank 3
authority of a **different** frozen PRD as a side effect of admitting this one, which is the silent amendment §7 rule 1
and `PRD_LIFECYCLE.md` **L177** forbid. **`PRD-014`'s Rank 3 authority is not in doubt** — it rests on its §3.3 row and
the `ADR-0052` acceptance, both present and correct. Only the precedence table is incomplete.

⚠ **A consequence that must be stated rather than left to inference:** because §4 is not repaired, this admission adds
the `PRD-023` Rank 3 row to a table that is *already known to be missing one*. After this commit §4 holds **11** rows
against §3.3's **12** module baselines. The arithmetic gap survives the admission, by instruction, and a reader
counting rows in §4 will still be one short.

---

## 4. The decision

1. **`PRD-023_SETTINGS_AND_CONFIGURATION.md` v0.1 is ADMITTED at Rank 3** as the authoritative specification for
   **`BC-25` Configuration** — the **twelfth** module baseline in §3.3 and the **eleventh** Rank 3 row in §4.
2. **`PRD_REGISTRY.md` moves `PRD-023` `PLANNED` → `FROZEN`** — the **fourth** PRD to leave `PLANNED` directly for
   `FROZEN`, after `PRD-013`, `PRD-016` and `PRD-014`.
3. **The version stays at v0.1.** `ADR-0020` §4 item 2; the fourth v0.x admission.
4. **`BASELINE-2026-08-20-A` is issued** — §7 rule 4, a Rank 1–3 document entering the baseline. It is the first
   identifier to advance by **date** since `BASELINE-2026-08-19-C`.
5. **`IMPL-1100`…`IMPL-1129` is ratified** as `PRD-023`'s implementation range, with **`IMPL-1130`…`IMPL-1199`
   reserved** as its contiguous growth room (allocation rule 2), following the `ADR-0052:279` precedent that reserved
   `IMPL-1030`…`1099` for `PRD-014`.
6. **The requirement inventory is frozen** at 180 identifiers / 8 registers / 113 Class A obligations. No identifier was
   added, removed, renumbered or reworded on admission.
7. **All 8 `CNF-GAP-*` are admitted OPEN, and none is ratified by admission.**
8. **`GCP-20` is opened and carried unrepaired** (§3.2), and **`GCP-21`** is opened for §8.1 drift 4.
9. **`FROZEN` does not mean `VERIFIED`.** 0 of 59 acceptance criteria and 0 of 30 tasks are proven by a test.

### 4.1 What the admission rests on

Seven gate artefacts that exist on disk; three independent checkers at exit 0; **19 injected mutations, 19 caught**
(12 across Stage 5, 7 across Stage 6), every document restored byte-identical; and a PRD hash unchanged through five
verifications.

---

## 5. What this admission does **not** rest on

- **Not** on the author's assessment of the document's quality.
- **Not** on any gate script that imports another, or that was written by the register's own author without an
  independent second instrument reaching the same total by a different route.
- **Not** on the PRD's own `Status` row. It read **`DRAFT`** throughout every gate and said so explicitly:
  *"This document confers no status on itself."*
- **Not** on rounding. 67.3% is admitted as 67.3%.
- **Not** on any resolved gap. Eight remain open; the count did not fall by admitting them.
- **Not** on a clean §8.1. The pre-existing-defect search returned **four** drifts, and one is left unrepaired.

---

## 6. The authority basis, stated plainly

`PRD_LIFECYCLE.md` **§6 L282** assigns Stage 7 and the baseline to the **Governance owner**. **L283** records that
*"Every PRD needs a named owner. **None has one**"* (`PGA-08`).

The authority exercised here is direct, explicit conferral by the human principal of this engagement, scoped to this
act: the instruction was to execute **Stages 3 → 7** without skipping, merging or reordering them, to create `ADR-0053`
*"following ADR-0052 structure and governance precedent"*, and to make registry and baseline updates *"only where
Stage 7 explicitly requires them and governance permits them."* **That instruction is the authority, and it is the only
authority claimed.**

`ADR-0033` **§7.1** — *"A conferral for one act is not a standing licence."* This admission does **not** cure
`PGA-08`: `PRD-023` still has no standing named owner after this ADR exists.

### 6.1 The conditions attached to the grant, and how each was tested

| Condition in the instruction | How it was honoured |
|---|---|
| *"Re-verify repository evidence before every stage"* | Git state, PRD hash and gate exits re-measured at the head of Stages 5, 6 and 7 — three times recovering from an interruption by measurement rather than assumption, including this ADR's own interrupted first write, which was checked for existence before being redone |
| *"Frozen/authoritative documents read-only unless that stage explicitly requires an approved governance update"* | Stage 5 wrote only matrix §2L/§11 (its own gate artefact); Stage 6 wrote only a new file; Stage 7 writes the baseline, index and registry, which **are** its gate |
| *"Do not silently resolve contradictions"* | `CNF-GAP-001`, `H-1`, `Q-01`…`Q-07`, `S4-D-01`, `GCP-20` and §8.1 drift 4 all carried with owners named |
| *"Do not invent BCs, events, ports, requirements, identifiers or ownership"* | 0 events, 0 edges, 0 configurables, 0 aggregates asserted; **2 registers left declared EMPTY**, enforced as a test in three checkers |
| *"Preserve `ADR-0017` §3.1/§3.2 scope"* | 6 of 6 items owned, no seventh; 0 requirements moved |
| *"Keep all identifiers under the `CNF-` namespace"* | 180 of 180; **0 definitions outside `platform/configuration`** |
| *"Use `IMPL-1100`…`IMPL-1129`"* | Exactly that range, contiguous, 30 tasks, verified against the foreign reserve `IMPL-1030`…`1099` and against `PRD-001`'s `IMPL-015`/`016` |
| *"Do NOT repair `GCP-20` silently"* | Opened by name in the `Opens` field, §3.2 and the freeze record. **Not repaired**, and its surviving arithmetic consequence stated |
| *"Do NOT renumber the PRD"* | v0.1 throughout; §2.2 states why |
| *"Stop and report if a blocking contradiction makes the next stage unsafe"* | No blocking contradiction was found; had one been, §9 option `O-3` was the prepared answer |

---

## 7. What acceptance does **NOT** license

| Claim | Licensed? |
|---|---|
| Implementation of `BC-25` may begin | ✅ Yes — that is the purpose of the freeze |
| `PRD-023` outranks a Rank 1 or Rank 2 document inside `BC-25` | ❌ No. Rank 3 sits below `MASTER_PRD.md` and every accepted ADR |
| Any `CNF-GAP-*` is decided | ❌ No. All **8** remain OPEN with named owners |
| `CNF-CFG-*` may be populated by an implementer choosing a value | ❌ No. A configurable requires its owning authority, not an implementation choice |
| `CNF-EVT-*` may be populated by an implementer publishing an event | ❌ No. That would create an edge BC Map §7 L292 says does not exist |
| `BC-25` now owns an aggregate | ❌ No. `CNF-GAP-001` is unresolved and the PRD asserts none |
| The module is tested | ❌ No. **0 of 59** acceptance criteria are proven by a test |
| The seven missing architecture tests may be skipped | ❌ No. `CNF-GAP-008` stands; `SID-4.56` treats an uncheckable rule as unmet |
| `GCP-20` is repaired, or §4 is now complete | ❌ No. Explicitly carried unrepaired (§3.2) |
| Stage 8 has begun | ❌ No |
| A future PRD may reuse or reassign a number in `IMPL-1100`…`IMPL-1199` | ❌ No. Allocation rule 1 — *"Never reuse or reassign a number"* |

---

## 8. Counts re-derived by measurement, not by incrementing

```
ls docs/00-governance/adr/ADR-0*.md | wc -l                    →  52   (before this ADR)
classify all 52 files' own Status rows, stripping ** and ` :
        52 files / 39 ACCEPTED / 13 PROPOSED / 0 unclassified  →  sums to 52
after ADR-0053:                    53 files / 40 accepted / 13 proposed
```

**Only ONE number moves — accepted 39 → 40 — and `proposed` is deliberately unchanged at 13.** No ADR was promoted,
demoted or superseded; `ADR-0021`…`ADR-0031`, `ADR-0038` and `ADR-0041` all stay `Proposed`.

Registry §7, re-derived by enumerating the status column rather than incrementing: **`FROZEN` 11 → 12**,
**`PLANNED` 10 → 9**, **documents that exist 16 files / 14 identities → 17 files / 15 identities**. The **identity**
count is *measured* from disk; the **file** count is *incremented* and labelled as such, because §7 still states no
rule for what counts as one file — the disclosed limit `GCP-18` recorded, and it is not cured here.

### 8.1 The search for pre-existing defects was performed and did **NOT** return empty

`ADR-0051` §8.1 established the discipline of **testing** this claim rather than asserting it, after its own claim to
have found nothing was falsified. The test was run, and it falsified the comfortable answer again. **Four drifts
measured:**

| # | Measured drift | Disposition |
|---|---|---|
| 1 | **`GCP-20`** — §4 holds 10 Rank 3 rows against §3.3's 11 module baselines; the Entitlement row is missing | **Carried, NOT repaired** — explicit instruction (§3.2) |
| 2 | **§4's Rank 2 row reads *"38 accepted of 51 files"*** and enumerates to *"`ADR-0051`"*, while measurement gives **52 files / 39 accepted** with `ADR-0052` accepted | **Repaired**, because this admission must extend that same cell to name `ADR-0053`. This is `GCP-16`/`GCP-19` recurring for the **third** time in one cell; the correction is disclosed rather than presented as untouched, and it is stated as a **measured** figure so a future author re-derives rather than increments |
| 3 | **§3.1's self-reference cell reads `BASELINE-2026-08-05-A`** while the header reads `BASELINE-2026-08-19-C` — **three** baselines stale | **Repaired**, because §7 rule 3 requires this declaration to match the repository and this admission moves the header. ⚠ This is `GCP-15` **recurring after being recorded CLOSED** on 2026-08-19, and it is logged as a recurrence rather than as a first occurrence |
| 4 | **§3.2 records `ARCHITECTURE_RULINGS.md` at v1.2** while the file's own version row (**L6**) reads **v1.1** | ⚠ **NOT repaired. Opened as `GCP-21`.** This cell is not touched by this admission, and **it is not established which of the two is wrong** — the baseline may record a bump the file never received, or the file may have been reverted. Deciding that is an Architecture Owner act, not a freeze act, and writing either value would settle a question by guessing |

**Drift 4 is the honest cost of this section.** A tidier ADR would have found three repairable drifts and reported a
clean sweep. Reporting the fourth means admitting that this pass leaves the baseline with a known unverified cell —
which is the disclosure `ADR-0051` §8.1 exists to compel.

---

## 9. Options considered

| # | Option | Rejected because |
|---|---|---|
| `O-1` | Admit at **v1.0** to mark the freeze | `ADR-0020` §5 expressly rejects this. Three prior admissions preserved v0.x |
| `O-2` | Refuse admission until all 8 `CNF-GAP-*` are closed | No PRD has ever been admitted gap-free — `PRD-008` carried 17, `PRD-007` 14. Freeze records what a context **owns**, not what is **decided** |
| `O-3` | Refuse admission because `GCP-20` is unrepaired | `GCP-20` is a defect in a **different** PRD's precedence row. Blocking `PRD-023` on it would make one document's admission hostage to another's incomplete bookkeeping, and `PRD-014`'s authority is not in doubt |
| `O-4` | Repair `GCP-20` while here, since the §4 table is open on the screen | The instruction forbids it, and §7 rule 1 forbids amending another Rank 3 admission without its own ADR |
| `O-5` | Populate `CNF-CFG-*` with a default so the register is not empty | Would invent a value owned by one of eight frozen PRDs, or mint a 105th configurable without authority |
| `O-6` | Mint one `CNF-EVT-*` so the module publishes something | Would create an edge BC Map §7 L292 says does not exist |
| `O-7` | Repair `S4-D-01` so the uncovered count reads 37 consistently | Changes the PRD hash and invalidates four gate records anchored to `e974960…`, to make a conservative error prettier |
| `O-8` | Round acceptance coverage up, or report task coverage as *the* coverage figure | The `PRD-006` v1.0 failure — *"100% coverage"* against a true 49.1% — named in the PRD's own Stage 6 record |
| `O-9` | Repair the stale `IMPL-227+` table in Rank 1 `PRD_LIFECYCLE.md` | A Rank 1 change needs its own ADR first. Disclosed for the **fifth** consecutive backlog |
| `O-10` | Pick a value for `ARCHITECTURE_RULINGS.md`'s version so §8.1 reads clean | Would settle by guessing which of two records is wrong. Opened as `GCP-21` instead |
| `O-11` | Report §8.1 as *"no pre-existing defect found"* | Measurement falsified it. Four drifts exist |

---

## 10. Consequences

### 10.1 Immediate

- Rank 3 holds **twelve** module baselines in §3.3. **`BC-25` Configuration is the third and last FOUNDATIONAL-band
  context to gain a Rank 3 specification** — measured against BC Map **L271**, which places `BC-18`, `BC-19` and
  `BC-25` in that band: `BC-18` through the Authentication PRD, `BC-19` through `PRD-013`, and now `BC-25`. **The
  FOUNDATIONAL band is 3 of 3 covered.**
- Implementation of `BC-25` may begin at `IMPL-1100`, subject to 9 named blockers, 5 of them ⛔ hard-external.
- `ADR-0017` §5.3's deferred collision question is **closed**: zero collisions, measured in three directions.

### 10.2 What does **not** change

`MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, `ARCHITECTURE_RULINGS.md`,
`CONFIGURATION_GUIDE.md`, `tool/module_dependencies.yaml`, the 20 pre-existing `tool/docs_check` scripts, and every
file under `lib/`, `packages/`, `test/` and `web/`. **31 bounded contexts, 26 edges, 104 configurables — all
unchanged.**

### 10.3 Carried forward

All 8 `CNF-GAP-*`; **`GCP-20`**; **`GCP-21`**; `S4-D-01`; `S5-C-01`…`03`, `S5-F-01`, `S5-F-02`; the 5 pre-existing
exit-1 `docs_check` scripts; the stale Rank 1 `IMPL-227+` table; the 7 missing architecture tests; the 9 boundary
findings; `H-1`; `Q-01`…`Q-07`; `PGA-03`…`PGA-10`; `GCP-14`.

---

## 11. Compliance

| Rule | Satisfied |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 rule 1 — an ADR **before** the change | ✅ This document was written and accepted **first**; the baseline, index and registry follow in the same commit |
| §7 rule 2 — version incremented, changelog updated in the same commit | ✅ The **baseline identifier** advances and §8 gains a row. The **PRD's** version deliberately does not move (`ADR-0020` §4 item 2), and its changelog records the freeze |
| §7 rule 3 — this declaration updated in the same commit | ✅ §3.1, §3.3, §4, §6 and §8 in one commit. *"A baseline that does not match the repository is worse than no baseline"* |
| §7 rule 4 — identifier changes only for a Rank 1–3 version change | ✅ `BASELINE-2026-08-20-A`, because a Rank 3 document enters |
| `PRD_LIFECYCLE.md` Stage 7 — the gate is a §3 row at an assigned rank | ✅ §3.3 row + §4 Rank 3 row |
| *"Freeze is conferred, not claimed"* | ✅ The PRD's own header read `DRAFT` through every gate and disclaims self-conferral |
| `ADR-0020` §4 item 2 — freeze does not renumber | ✅ v0.1 |
| `ADR-0033` §7.1 — conferral is not standing | ✅ Stated in §6 |
| `ADR-0051` §8.1 — test the no-defect claim rather than assert it | ✅ Tested; **it failed**; four drifts named in §8.1 |

---

## 12. Change history

| Date | Change |
|---|---|
| 2026-08-20 | Created **`Accepted`**. Admits `PRD-023` Settings & Configuration v0.1 at Rank 3 for `BC-25`; registry `PLANNED` → `FROZEN`; issues `BASELINE-2026-08-20-A`; ratifies `IMPL-1100`…`1129` with `IMPL-1130`…`1199` reserved. Completes the FOUNDATIONAL band at 3 of 3. Eight `CNF-GAP-*` admitted OPEN; **`GCP-20` carried unrepaired** with its surviving arithmetic consequence stated; **`GCP-21` opened** for an unverifiable version cell; §8.1 records that the pre-existing-defect search **did not return empty** and names four drifts, two repaired as part of edits this admission already requires, one carried by instruction, one left open rather than settled by guessing |
