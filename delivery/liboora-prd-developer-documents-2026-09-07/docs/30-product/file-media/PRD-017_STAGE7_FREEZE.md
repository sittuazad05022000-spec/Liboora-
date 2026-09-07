# PRD-017 — Stage 7 Freeze & Governance Record

| Field | Value |
|---|---|
| **Document** | Stage 7 record for `PRD-017` — File & Media |
| **Subject** | [`PRD-017_FILE_AND_MEDIA.md`](PRD-017_FILE_AND_MEDIA.md) **v0.1** |
| **Stage** | **Stage 7 — Freeze & Governance** (`PRD_LIFECYCLE.md` **L155–175**) |
| **Verdict** | **PASS — `PRD-017` is `FROZEN` at Rank 3** |
| **Conferring authority** | `ACCEPTED` [`ADR-0054`](../../00-governance/adr/ADR-0054-file-media-prd-v0.1-baseline.md) + the rows in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3 and §4. **Neither is this document** |
| **Baseline** | **`BASELINE-2026-08-20-B`** (supersedes `BASELINE-2026-08-20-A`) — the **second** suffix advance within a single day |
| **Subject hash before** | `4ebf5d07ecbbdf43f57fa5a63676995f34faa81931fdba5b7bdb42bcfc03d4e8` |
| **Subject hash after** | `c1bb22a7d066808485df0d3d8cf33c5472311a021a8372103e88dcfb7677d9bd` — **changed, and §3 says why** |
| **Requirement body hash** | ⚠ **CORRECTED — the finding stands, the figure was stale.** Originally published as `9cb9ee4bf2075272cc7f564e503b9ff5f8c8d3d72dd1403c136ab2ed7915318b` *"measured over L35–L1685"*. The **final validation re-derived the span by ANCHOR** — first `---` separator to `### 18.3 Change history` — rather than by the two literal line numbers, and measured **L37–L1685, span 1649 lines, `50c20e964b54f93d2b9511d62c760db2e37e9751d1de47c27a66b2c0b63e3bb0`**. That value is **byte-identical to the same anchored span in `ac6d13c`, the pre-freeze commit** (`BODY IDENTICAL: True`), so **the claim the row was making is true**: the freeze changed no requirement text. What was wrong was the *hardcoded offset* — `L35` began two lines above the separator, so the earlier digest covered two header lines as well as the body, and the pair it compared were consistent with each other but not with the span the row named. **The claim was verified; the number that expressed it was not recomputable from its own stated definition.** Both are shown so a reader can reproduce either. This is the **same defect class as the three stale gate-record hashes recorded in §3.1** — a hash citation outliving the bytes or bounds it was taken over — and it is recorded here rather than silently overwritten, under `GCP-22` |
| **Date** | 2026-08-20 |
| **Precedence** | **None.** This is a stage record. It reports a conferral made elsewhere and confers nothing itself |

---

## 1. The gate, and the artefact that satisfies it

`PRD_LIFECYCLE.md` **L155–175** does not make Stage 7 a self-declaration. The gate is
*"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"*, and the same section states the rule
this document is careful not to break: **"Freeze is conferred, not claimed."**

So the question this record answers is narrow. Not *"is `PRD-017` good enough to freeze?"* — Stages 3, 4, 5 and 6
answered that at their own gates — but **"does the row exist, and was it written by an authority entitled to write
it?"**

| Requirement of the gate | Artefact | Verified |
|---|---|---|
| A `DOCUMENTATION_BASELINE.md` §3 row at an assigned rank | §3.3, three rows: the PRD, its alignment supplement, and its three other gate records | ✅ |
| A §4 precedence entry | §4, **Rank 3**, `BC-29` File & Media | ✅ |
| An ADR authorising the ranked-document change **before** the change | [`ADR-0054`](../../00-governance/adr/ADR-0054-file-media-prd-v0.1-baseline.md), written and complete **before** any ranked file was touched — baseline §7 rule 1 | ✅ |
| A baseline identifier advance, since a Rank 1–3 document changed version-or-membership | `BASELINE-2026-08-20-A` → **`BASELINE-2026-08-20-B`**, baseline §7 rule 4 | ✅ |
| The registry reflecting the conferred status | `PRD_REGISTRY.md` **L307** `PLANNED` → **`FROZEN`**, plus the four §7 count rows | ✅ |
| The ADR registered | `ADR-INDEX.md` — new row, count re-derived **54 files / 41 accepted / 13 proposed** | ✅ |
| Prior stage gates passed | Stage 3 ✅ PASS-CONDITIONAL 6/6 · Stage 4 ✅ 14 categories · Stage 5 ✅ CONFERRED · Stage 6 ✅ 40 tasks | ✅ |

**The authority question is the one worth stating plainly.** `PRD_LIFECYCLE.md` §6 **L282** assigns Stage 7 and the
baseline to the **Governance Owner**, and that role was conferred directly for this pass. It is also the reason
`FIL-GAP-012` is still open: the conferred role does **not** extend to amending a Rank 4 document, so the one
amendment that would have made this freeze clean was identified precisely and then declined (§4.2, `ADR-0054` §3.2).

---

## 2. Order of operations, because the order is itself a rule

`DOCUMENTATION_BASELINE.md` §7 rule 1 reads: *"A change to any Rank 1–5 document requires an ADR **before** the
change."* That makes the sequence a compliance matter rather than a matter of convenience, and it was followed in
this order:

| # | Act | File | Why here and not elsewhere |
|---|---|---|---|
| 1 | Write the ADR | `ADR-0054-file-media-prd-v0.1-baseline.md` | §7 rule 1. **Nothing ranked was touched until this file existed and was complete** — 397 lines, 12 sections |
| 2 | Advance the baseline | `DOCUMENTATION_BASELINE.md` | The conferring document. Header, §3.1 self-reference, §3.3 (3 rows), §3.4 (1 row), §4 (Rank 2 count, Rank 3 row, the baseline-count sentence), §6 (4 gap rows), §8 (changelog) |
| 3 | Register the ADR | `ADR-INDEX.md` | The index follows the ADR it indexes; the count is re-derived from all 54 files, not incremented |
| 4 | Update the registry | `PRD_REGISTRY.md` | L307 status, then the four §7 count rows |
| 5 | Update the PRD's own metadata | `PRD-017_FILE_AND_MEDIA.md` | **Last among the ranked edits, and deliberately so** — the subject reports its status, it does not assert it. Editing it first would have had the document claim a rank no one had yet conferred |
| 6 | Write this record | this file | A record of acts already performed. It cannot precede them |
| 7 | Re-run both checkers | `prd017_traceability.py`, `prd017_stage5.py` | §7 verdict. **This step found a real defect — see §3.2** |

---

## 3. The PRD hash changed, and that is disclosed rather than glossed

The subject's hash moved from `4ebf5d07…d4e8` to `c1bb22a7…d9bd`. Every gate record for this module cites the
**old** value, so as of this edit **every one of those citations is historical**. That is stated here because the
alternative — going back and rewriting the hashes so the records look current — would make each record claim a
review of bytes it never saw.

**What actually changed, measured rather than asserted:**

| Scope | Before | After | Changed? |
|---|---|---|---|
| Whole file | `4ebf5d07…d4e8` | `c1bb22a7…d9bd` | **Yes** |
| Requirement body, **anchored span** (first `---` → `### 18.3`), measured **L37–L1685** | `50c20e96…3bb0` | `50c20e96…3bb0` | **No — byte-identical**, confirmed against `git show ac6d13c:<path>`. ⚠ The originally published pair `9cb9ee4b…318b` / `9cb9ee4b…318b` was taken over the **mis-stated** span `L35–L1685`; see the header row. The verdict in this column is unchanged by the correction |
| Distinct `FIL-*` identifiers | 232 | 232 | No |
| `FIL-FR` / `BR` / `INV` / `EVT` / `XC` / `CFG` / `AC` / `GAP` | 82 / 17 / 11 / 0 / 22 / 9 / 78 / 13 | 82 / 17 / 11 / 0 / 22 / 9 / 78 / 13 | No |
| Class A obligations | 132 | 132 | No |
| Acceptance coverage | 94 / 132 = 71.2% | 94 / 132 = 71.2% | No |
| Line count | 1,690 | 1,691 | +1, the change-history row |

Six header metadata cells moved — Version (annotated, **value unchanged at v0.1**), Status, Lifecycle stage,
Registry status, Rank, Baseline — plus one change-history row. **No requirement, business rule, invariant,
exclusion, configurable, criterion, gap or section body was edited.** The requirement-body hash is the evidence,
and it is published so a reader can recompute it rather than take this paragraph's word for it.

### 3.1 ⚠ This module already had a staleness problem, and this edit is its second instance

The hash movement above is the *ordinary* kind: a freeze edits metadata, so the anchor moves, and every predecessor
freeze record discloses the same thing.

**This module had the other kind too, and it was found by measurement rather than inherited.** Before any Stage 7
edit, the hashes cited by the four PRD-017 gate records were extracted and compared against the subject:

| Record | Cites | Status at Stage 7 start |
|---|---|---|
| `PRD-017_ARCHITECTURE_ALIGNMENT.md` L6 | `85adb6fa…cb44e` | ⛔ **STALE** |
| `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` L10 | `880de96e…ac2d6` | ⛔ **STALE** (self-disclosed) |
| `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` L11 | `202ccf5e…9705e` | ⛔ **STALE** (self-disclosed) |
| `PRD-017_STAGE5_CONFERRAL.md` L13 | `4ebf5d07…d4e8` | ✅ CURRENT |

**Three of four.** The two immediately preceding freezes — `PRD-016` and `PRD-023` — each record that *"all five
gate records measured the identical hash, so no supplement was required and none was written."* Writing that
sentence here would have been fluent, consistent with the most recent precedent, and **false**. This is the
`PRD-008`/`PRD-013` case instead, so **a supplement was required and was written**:
[`PRD-017_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md`](PRD-017_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md).

The drift between `85adb6fa…` and `4ebf5d07…` was then measured at identifier level rather than assumed harmless:
**230 → 232 distinct, `FIL-AC-077` and `FIL-AC-078` added, nothing removed**, every Class A register **identical in
membership** (FR 82 · BR 17 · INV 11 · EVT 0 · XC 22). That is *why* the six Stage 3 verdicts survived re-testing
unchanged — the bytes that moved were not the bytes any architectural verdict rested on.

**⚠ The general defect is not fixed.** Nothing in `tool/docs_check/` compares a gate record's cited hash to its
subject, and `alignment_record_freshness.py` carries a hard-coded `RECORDS` table that **does not cover `PRD-017`
at all**. This was caught by reading, and reading does not scale. Opened as **`GCP-22`** in
`DOCUMENTATION_BASELINE.md` §6, carried rather than repaired.

### 3.2 ⚠ The Stage 7 re-run failed first, and the checker was right

Step 7 of §2 was not a formality. On its first execution `prd017_stage5.py` returned **EXIT=1**:

```
FAIL - 1 problem(s):
  * outward collision -- docs/00-governance/adr/ADR-0054-file-media-prd-v0.1-baseline.md
    cites FIL-EVT-001, which is defined nowhere
```

`ADR-0054` had used a numbered `FIL-EVT-*` token twice — in **both** places where it explains that the register is
empty and that a numbered token in the Stage 3 record had been the very dangling citation drift 3 exposed. The ADR
had therefore **committed the defect it was written to record**.

**The prose was fixed, not the rule.** Both passages now name the register and the ordinal position
(*"the first member of `FIL-EVT-*`"*) instead of minting a number that resolves nowhere — the same repair the
Stage 3 record received. Weakening the checker to permit "obviously rhetorical" citations was considered and
rejected: the exemption would have to be scoped by intent, and a gate that cannot mechanically distinguish a
rejected proposal from a real reference is not a gate.

This is the **third** occurrence of the author-introduced-phantom class in two admissions — `PRD-023` recorded
four, this module's Stage 5 recorded six, and this is one more. In all three the checker was right and the
document was wrong, which is the argument for keeping the rule strict.

After the fix: **both checkers EXIT=0.**

---

## 4. What was changed, and what was deliberately not

### 4.1 Changed

| File | Change | Rank |
|---|---|---|
| `docs/00-governance/adr/ADR-0054-…md` | **Created.** 12 sections, `Accepted`, `BASELINE-2026-08-20-B`. §3.2 is the central decision; §8.1 records **six** drifts | 2 |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | Header block; §3.1 self-reference `-A` → `-B`; §3.3 **+3 rows**; §3.4 **+1 row**; §4 Rank 2 count **40/53 → 41/54**, **+1 Rank 3 row**, baseline-count sentence **eleven → thirteen**; §6 **+4 gap rows**; §8 **+1 changelog row** | 1 |
| `docs/00-governance/adr/ADR-INDEX.md` | **+1** table row above `ADR-0053`; count row re-derived to **41 accepted · 13 proposed · 0 · 0, 54 files** | — |
| `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | **L307** `PLANNED` → `FROZEN` with admission prose; §7 rows: documents-that-exist **17/15 → 18/16**, `FROZEN` **12 → 13**, `PLANNED` **9 → 8**, Missing V1 **11 → 10** | — |
| `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` | **Six header metadata cells + one change-history row.** Requirement body **byte-identical** | 3 |
| `docs/30-product/file-media/PRD-017_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md` | **Created** (Stage 3, §3.1) | — |
| `docs/30-product/file-media/PRD-017_STAGE7_FREEZE.md` | **Created** — this file | — |

### 4.2 Deliberately NOT changed

| File / thing | Why not |
|---|---|
| **`LIBOORA_BOUNDED_CONTEXT_MAP.md` — and specifically `E-22` at L331** | ⭐ **The central refusal of this pass.** Stage 3 proved by per-context testing that `BC-12` Messaging needs the edge and that `BC-11` and `BC-13` do not. `ADR-0016` is the exact one-cell precedent. The amendment was identified precisely — **and declined**, because BC Map amendment is an **Architecture Owner** act and the authority conferred here is Governance Owner. `ADR-0054` §3.2: *"knowing the right amendment is not the same as holding the right to make it."* **`FIL-GAP-012` is routed, not closed** |
| Routing sharing through **`BC-14` Content Sharing** | The subtlest available shortcut, and refused: `BC-14` *is* already an `E-22` consumer, so the gap would have vanished with no ADR at all. **A message attachment is not a content post.** Recorded in `ADR-0054` §3.3 as *"architecturally clever and factually wrong"* |
| **`ADR-0022`** | Left `Proposed`. It frames the same `E-22` question for `BC-03`, and promoting it would have been the cheapest route to closing this module's one load-bearing gap. A `Proposed` ADR about a different context is not authority over `BC-12`. The index's proposed count is **13 before and 13 after** |
| The **version number** | Stays **v0.1**. `ADR-0020` §4 item 2 — *"Freeze confers status; it does not renumber."* Fifth v0.x admission |
| The four **stale hash citations** in the Stage 3 and Stage 4 records | Rewriting them would make each record claim a review of bytes it never saw. The supplement is the answer; §3.1 is the disclosure |
| **`S4-D-06`** | Recorded in `ADR-0054` §3.1 rather than back-dated into the Stage 4 artefact. Editing a completed gate record to add a finding discovered later is not a repair, it is a rewrite |
| `PRD_LIFECYCLE.md` **L147–153** (`IMPL-227+`) | Stale, and **not followed**: obeying it would have collided with four reserved ranges. Amending a **Rank 1** document is a different act from allocating a range |
| `PRD_DEPENDENCY_GRAPH.md` **L113** (*"PRD-002 owns BC-29"*) | Stale Rank 4 statement, contradicted by `ADR-0013` §5. Not this act's to fix |
| `MASTER_PRD.md`, Module Dependency Matrix, `ARCHITECTURE_RULINGS.md`, `CONFIGURATION_GUIDE.md`, `tool/module_dependencies.yaml`, every pre-existing `tool/docs_check/*` | Byte-unchanged. **0 edges, 0 cells, 0 ports, 0 events, 0 aggregates, 0 configurables absorbed, 0 requirements moved** |
| `lib/`, `packages/`, `test/`, `web/`, `pubspec.yaml` | **0 lines.** This is a documentation act. `check_module_boundaries.dart` output is byte-identical to baseline, so **0 new** boundary findings |

### 4.3 ⚠ `GCP-20` — carried explicitly, and its surviving consequence stated

`DOCUMENTATION_BASELINE.md` §4 never received a Rank 3 row for `PRD-014` Entitlement. Measured again during this
pass: §4 held **11** Rank 3 rows against §3.3's **12**. It was **not repaired**, because repairing it would amend a
*different* frozen PRD's precedence entry as a side effect of admitting `PRD-017` — the silent amendment §7 rule 1
and `PRD_LIFECYCLE.md` **L177** forbid.

**The consequence, stated rather than left to be rediscovered:** this admission adds one row to each side, so §4
now holds **12** against §3.3's **13**. The arithmetic gap **survives this admission by design.** `ADR-0054` §8.1
drift 6.

### 4.4 ⚠ One drift WAS repaired in this pass, and the distinction matters

§4's sentence *"Rank 3 holds eleven module baselines"* was **stale by one** before this pass began: `ADR-0053` §11
**L323** already states *"Rank 3 holds **twelve** module baselines in §3.3"*, but the `PRD-023` admission moved the
§3.3 table without moving this sentence. So it advanced by **two — eleven → thirteen** — with the recurrence
recorded in the cell rather than smoothed over.

**Why this one was repaired while `GCP-20` was not:** this admission *must* extend this sentence, so leaving it
wrong would mean writing a number that is wrong on both counts. `GCP-20`, by contrast, would require touching a
row about a different module. **The line is whether the correction is inside the act being performed or outside
it.** The same reasoning appears at `ADR-0053` §8.1 drift 2 and is followed rather than reinvented.

---

## 5. Counts re-derived, not incremented

Every number written into a governance document during this pass was recomputed from the repository. Where a route
existed to obtain a figure by adding one to a previous figure, it was not used.

| Figure | Route | Result |
|---|---|---|
| ADR files | `ls docs/00-governance/adr/ADR-0*.md \| wc -l` | **54** |
| ADR statuses | Classify **all 54** files' own `Status` rows on the leading declared token | **41 accepted · 13 proposed · 0 superseded · 0 deprecated** — sums to 54 |
| ADR-INDEX completeness | For each of 54 files, assert a table row exists | **54 rows, 54 distinct, 0 missing** |
| Next free ADR | Distinct `ADR-00NN` from filenames; assert no gaps; take max+1 | **`ADR-0054`**; 53 unique `0001`…`0053`, **no gaps** |
| Registry `FROZEN` | Enumerate the §4.3 status column + §3's four detail blocks | **13** (10 in §4.3 + `PRD-000`/`001`/`002`) |
| Registry `PLANNED` | Same sweep | **8** |
| Registry `DRAFT` / `IMPLEMENTING` | Same sweep | **2** / **1** — sums with the above to **24** registered |
| Baseline §4 Rank 3 rows | `grep -c '^| \*\*3\*\* |'` within §4 | **12** — against §3.3's **13** (§4.3) |
| PRD identifiers | Two independent checkers, one parsing by **line form**, one by **scope position** | **232** — agreeing |
| Class A / covered / coverage | Recomputed by both | **132** / **94** / **71.2%** |
| `FIL-*` citations resolved | `prd017_stage5.py` outward sweep | **736** outside the module, **0** outward definitions, **0** dangling after §3.2's fix |
| Requirement body integrity | sha256 of the **anchored** span (first `---` → `### 18.3`), re-derived at final validation instead of trusting the stored offsets — measured **L37–L1685** | **`50c20e96…3bb0` both times**, before (`ac6d13c`) and after. ⚠ Supersedes the stale figure `9cb9ee4b…318b`, which was correct as a *comparison* but was labelled with a span it did not cover |

**Coverage is published at 71.2% and is not conflated with the 132/132 = 100.0% task figure.** They count different
things: the first is criteria attached to obligations, the second is obligations claimed by tasks. The 38
uncovered obligations are enumerated by class — **XC 17 · FR 17 · BR 3 · INV 1**, with **0 undisclosed** — and the
`FIL-XC-*` majority is structural rather than a shortfall in diligence: a criterion asserting that something never
happens is unfalsifiable by observation.

---

## 6. What `FROZEN` does and does not mean here

**It means:** the specification is admitted at **Rank 3**, it outranks Rank 4–7 within `BC-29`, and changing it now
requires an ADR before the change (baseline §7 rule 1).

**It does not mean the module works, and the following are true simultaneously with the freeze:**

| Claim a reader might infer | Actual state |
|---|---|
| The behaviour is proven | ⛔ **0 of 78** acceptance criteria proven by a test |
| The work is done | ⛔ **0 of 40** `IMPL-1200`…`1239` tasks implemented |
| The architecture is test-enforced | ⛔ **7 of 7** tests required by `TRACEABILITY_MATRIX.md` §10.3 are **missing** (`B-2`) |
| The open questions are settled | ⛔ **All 13 `FIL-GAP-*` OPEN** |
| Student-to-Student sharing can ship | ⛔ **No.** Retained in V1, and `BC-12` cannot lawfully obtain a `FileRef`. `FIL-GAP-012` / `B-11`; `IMPL-1230`…`1236` **BLOCKED** |
| Stage 3 passed cleanly | ⚠ **PASS — CONDITIONAL.** The condition is the `E-22`/`BC-12` amendment, and **it is not met** |
| Coverage is complete | ⚠ **71.2%**, with the 38 uncovered enumerated by class |
| The gate records are all current | ⚠ **No.** Three of four cited stale hashes at Stage 7 start (§3.1), and after this edit **all four are historical** |

**`FROZEN` is a statement about governance, not about software.** A reader who takes this row as evidence that
files can be uploaded in Liboora today has misread it.

---

## 7. Verdict

> **PASS — Stage 7 complete. `PRD-017` File & Media v0.1 is `FROZEN` at Rank 3 under `BASELINE-2026-08-20-B`.**
>
> Conferred by `ACCEPTED` `ADR-0054` and the `DOCUMENTATION_BASELINE.md` §3.3/§4 rows — **not by this document.**
>
> Both instruments re-run after every edit: `prd017_traceability.py` **EXIT=0**, `prd017_stage5.py` **EXIT=0** —
> the latter only after it correctly failed a phantom citation this pass had introduced into its own ADR (§3.2).
>
> ⛔ **The module's one load-bearing gap is open and stays open.** A retained V1 capability is specified and not
> servable, the amendment that would fix it is identified precisely, and it was **declined for want of authority**
> rather than taken. `FIL-GAP-012` and `B-11` are routed to the **Architecture Owner**.
>
> ⛔ **`FROZEN` is not `VERIFIED`.**

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-20 | Created. Records the Stage 7 freeze of `PRD-017` File & Media **v0.1** at Rank 3 under **`BASELINE-2026-08-20-B`**, conferred by `ACCEPTED` `ADR-0054`. **7 files changed: 3 created** (the ADR, the Stage 3 supplement, this record) **and 4 edited** (baseline, ADR index, registry, and the subject's own six header cells). **0 edges, 0 BC Map cells, 0 ports, 0 events, 0 aggregates, 0 requirements moved, 0 lines of code**; requirement body **byte-identical** at `9cb9ee4b…318b`. ⚠ **Two things this record refuses to smooth over.** First, **three of the four gate-record hashes were stale**, so the convenient `PRD-016`/`PRD-023` no-supplement sentence was **measured and falsified rather than inherited**, and a Stage 3 supplement was written; the missing freshness instrument is **`GCP-22`**. Second, **the Stage 7 checker re-run FAILED on first execution** because `ADR-0054` cited a numbered `FIL-EVT-*` token while explaining that the register is empty — the ADR committed the defect it was written to record, and **the prose was fixed, not the rule**. ⭐ **The central act of this pass was a refusal:** the `ADR-0016`-shaped one-cell amendment that would have closed `FIL-GAP-012` was identified precisely and **declined**, because BC Map amendment belongs to the Architecture Owner and the conferred authority was Governance Owner. ⛔ **All 13 `FIL-GAP-*` OPEN · `B-2` and `B-11` OPEN · `IMPL-1230`…`1236` BLOCKED · 0 of 78 criteria and 0 of 40 tasks proven · `GCP-20` carried with its consequence stated (§4 now 12 rows against §3.3's 13) · `FROZEN` is not `VERIFIED`** |
