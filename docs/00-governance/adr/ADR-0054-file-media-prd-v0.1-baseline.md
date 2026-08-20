# ADR-0054 — `PRD-017` File & Media v0.1 admitted to the baseline at Rank 3

| Field | Value |
|---|---|
| **ADR** | `ADR-0054` |
| **Status** | **Accepted** |
| **Date** | 2026-08-20 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — exercised by direct conferral of the human principal of this engagement, §6 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** Admits a new document to Rank 3 and records the admission in `DOCUMENTATION_BASELINE.md` §3.3/§4/§6/§8, `ADR-INDEX.md` and `PRD_REGISTRY.md` §4.3/§7 |
| **Amended by** | Nothing |
| **Baseline** | **`BASELINE-2026-08-20-B`** — issued because a **Rank 3** document enters the baseline (`DOCUMENTATION_BASELINE.md` §7 rule 4). The **second** identifier ever to advance by suffix within a single day, after `BASELINE-2026-08-19-A` → `-B` |
| **Closes** | `PRD_LIFECYCLE.md` **Stage 7** for `PRD-017`; registry `PLANNED` → **`FROZEN`**; `ADR-0013` §5's outstanding write obligation for `BC-29` — its §2.1 states it *"does not create `PRD-017`"*, and the document now exists and is admitted |
| **Does NOT close** | ⛔ **`FIL-GAP-001`…`FIL-GAP-013` — all 13 OPEN**, including **`FIL-GAP-012`**, the `E-22` consumer gap · ⛔ **`B-11`** (the same gap as an implementation blocker) · ⛔ **`B-2`** and the **seven** architecture tests `TRACEABILITY_MATRIX.md` §10.3 requires · `S4-D-06` (recorded in this ADR §3.1, **not** in the Stage 4 record it belongs to) · `S5-C-05`, `S5-C-06`, `S5-C-07` (instrument defects fixed in the checker but retained as findings) · `S5-D-01b`, `S5-F-01`, `S5-F-02` · the stale `IMPL-227+` table in Rank 1 `PRD_LIFECYCLE.md` **L147–153** · the stale *"PRD-002 owns BC-29"* claim at `PRD_DEPENDENCY_GRAPH.md` **L113** · **`GCP-20`**, **`GCP-21`** · `GCP-14` · `H-1` · `Q-01`…`Q-07` · `PGA-03`…`PGA-10` · the 9 `app → domain/library` boundary findings · `ADR-0021`…`0031`/`0038`/`0041` remain `Proposed`, **`ADR-0022` among them** |
| **Opens** | **`GCP-22`** — the base Stage 3 alignment record's verdict was measured against **superseded bytes**, and this was **assumed away rather than measured** until §8.1 extracted and compared every hash citation. The response was a **supplement**; the general defect — **nothing mechanically checks whether a gate record's cited hash still matches its subject**, and `alignment_record_freshness.py`'s `RECORDS` table does not cover `PRD-017` — is **carried, not repaired**. ⚠ **The pre-existing-defect search was performed and did NOT return empty** — §8.1 names **six** drifts, following the `ADR-0051` §8.1 discipline |
| **Related** | `ADR-0013` §5 (the ownership grant this ADR executes) · `ADR-0016` (the `E-22` consumer-cell widening precedent this ADR **declines to exercise**, §3.2) · `ADR-0022` (**Proposed** — the same `E-22` question for `BC-03`) · `ADR-0034` (the `ATT-GAP-010` freeze-with-open-`E-22`-gap precedent, §4.1) · `ADR-0020` §4 item 2 / §5 (freeze does not renumber) · `ADR-0050`, `ADR-0051`, `ADR-0052`, `ADR-0053` (the four prior v0.x admissions) · `ADR-0033` §7.1 (a conferral is not a standing licence) |

---

## 1. The question

May `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` **v0.1** be admitted to `DOCUMENTATION_BASELINE.md` at
**Rank 3** as the authoritative specification for **`BC-29` File & Media**, and may `PRD_REGISTRY.md` move
`PRD-017` from **`PLANNED`** to **`FROZEN`** — **while a required integration edge does not exist**?

`ADR-0013` **§5** assigned `BC-29` to `PRD-017` and expressly declined to write it: **§2.1** states it *"does not
create `PRD-017`"*. The document has now been written and carried through Stages 3–7. This ADR answers whether it
may be admitted.

**The question is sharper than its four predecessors'.** `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023` each asked
whether a document with open *gaps* could be frozen. This one asks whether a document with an **architecturally
unservable V1 capability** can be — because `PRD-017` specifies student-to-student file sharing in V1, and BC Map
**L331**'s `E-22` consumer cell does not admit the caller that would need it. §3.2 and §4.1 answer that squarely
rather than around it.

---

## 2. Evidence — the artefacts, not the feelings

| Artefact | State |
|---|---|
| `PRD-017_FILE_AND_MEDIA.md` | **v0.1**, 1,690 lines, 135,999 bytes, ``4ebf5d07ecbbdf43f57fa5a63676995f34faa81931fdba5b7bdb42bcfc03d4e8`` |
| Stage 3 — `PRD-017_ARCHITECTURE_ALIGNMENT.md` | **PASS — CONDITIONAL, 6 of 6.** Measured `85adb6fa…` — ⛔ **stale** |
| Stage 3 — `PRD-017_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md` | **PASS — CONDITIONAL, 6 of 6**, re-measured against the **current** `4ebf5d07…`. Written because §8.1 measured the staleness instead of assuming it away |
| Stage 4 — `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` | **PASS, 6 of 6.** 6 defects fixed. Self-discloses that it edited its subject, with before/after hashes |
| Stage 5 — `PRD-017_STAGE5_CONFERRAL.md` | ✅ **GATE SATISFIED** — and ⛔ **architecture alignment explicitly NOT certified** |
| Stage 6 — `PRD-017_IMPLEMENTATION_TASKS.md` | **`IMPL-1200`…`IMPL-1239`**, 40 tasks, `IMPL-1240`…`1299` reserved |
| `TRACEABILITY_MATRIX.md` | **v1.17**, §2M at **L1369–L1541** |
| Instruments | `prd017_traceability.py` (623 lines) and `prd017_stage5.py` (803 lines), **both exit 0**, **12/12 mutants killed** |

### 2.1 Figures computed from the PRD, not copied from the reports

Re-derived by **three instruments that share no code and use three different parsing strategies** — line form,
scope position, and task-document Discharges-column parsing against an independently re-harvested obligation set:

| Register | Count | Range |
|---|---|---|
| `FIL-FR-*` | **82** | `001`…`082` contiguous |
| `FIL-BR-*` | **17** | `001`…`017` contiguous |
| `FIL-INV-*` | **11** | `001`…`011` contiguous |
| `FIL-EVT-*` | **0** | **DECLARED EMPTY** |
| `FIL-XC-*` | **22** | `001`…`022` contiguous |
| `FIL-AC-*` | **78** | `001`…`078` contiguous |
| `FIL-CFG-*` | **9** | `001`…`009` contiguous |
| `FIL-GAP-*` | **13** | `001`…`013` contiguous, **all OPEN** |
| **Total** | **232** | 8 registers · 0 duplicates · 0 dangling |

**Class A obligations 132. Covered by an acceptance criterion 94. Coverage 94/132 = 71.2%** — admitted at its
measured value, not rounded. **38 uncovered**, decomposed `{XC 17, FR 17, BR 3, INV 1}`, **0 undisclosed**.

⚠ **The 71.2% and the 100.0% are different claims and are NOT reconciled by rounding or averaging.** Stage 6
allocates 40 tasks claiming **132 of 132 = 100.0%** of Class A obligations with **0 phantom** claims. That is
*task* coverage. **Acceptance** coverage is 71.2%, and the largest single reason is structural rather than a
shortfall in diligence: **17 of the 38 uncovered are `FIL-XC-*` exclusions**, and a criterion asserting that
something never happens is unfalsifiable by observation. The precedent being avoided is named in `PRD-023`'s
record — `PRD-006` v1.0 published *"100% coverage"* against a true **49.1%**.

### 2.2 The version, and why it is **not** moved

Admitted at **v0.1** — the **fifth** v0.x admission, after `PRD-013`, `PRD-016`, `PRD-014` and `PRD-023`.
`ADR-0020` **§4 item 2** admits documents *"each at the version that was verified"* and **§5** expressly rejects
*"Renumber to v1.1 to mark the freeze"*. v0.1 is what every gate measured. **Freeze confers status; it does not
renumber.**

### 2.3 Architectural conformance

**0 `E-*` edges added. 0 BC Map cells amended. 0 contexts reclassified. 0 ports created. 0 manifest lines changed.
0 events minted. 0 aggregates asserted. 0 requirements moved into or out of `PRD-021`.**

`check_module_boundaries.dart` returns **byte-identically** to its pre-`PRD-017` baseline: `FAIL — 9 violation(s)
in 1 category(ies)`, `■ cross-context (9)`, `□ ACKNOWLEDGED DEBT — 28 finding(s) across 12 edge(s)`. **`PRD-017`
introduced zero new findings.** No file under `lib/`, `packages/`, `test/`, `web/` or `pubspec.yaml` was touched —
`git status --short` over those paths returns **0 lines**.

### 2.4 One empty register, and why emptiness is the correct content

**`FIL-EVT-*` is admitted EMPTY, as a finding.** `BC-29` is a producer in **zero** BC Map §9 rows. Minting an
event name would create an edge BC Map **L292** says *"does not exist"*. The temptation was concrete and is
recorded rather than described in the abstract: the Stage 3 record's §8 row `R-6` proposed minting **the first
member of `FIL-EVT-*`** for `ShareGranted` and it was **rejected**. ⭐ **That rejected proposal then survived as a dangling citation for two
stages** and was caught only at Stage 5 by a repaired checker (§8.1, drift 3) — so emptiness here is **enforced by
a test**, not merely asserted: `prd017_stage5.py` check 7 requires `FIL-EVT-*` empty in registration **and in
fact**.

`FIL-CFG-*` is **populated (9)** — unlike four predecessors' empty CFG registers — because file-size limits, MIME
allow-lists and retention windows are genuinely this module's to bound. The asymmetry is stated because four
consecutive empty-CFG admissions could otherwise read as a pattern rather than four separate findings.

---

## 3. Findings routed at the correct rank, and **not** fixed here

### 3.1 `S4-D-06` — a bookkeeping defect in a gate record, recorded here because its own record omits it

`PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` states that **five** defects were found and fixed. **Six** were. The sixth,
`S4-D-06`, is absent from that record's §9.1 table, §12 map and change history. **It is recorded here and NOT
repaired there**, for the reason `ADR-0053` gave when declining to repair `S4-D-01`: editing the Stage 4 record
would change bytes the Stage 5 conferral reviewed. It is also the benign direction of error — the record
**undercounts its own findings**, which is a weaker claim, not a false one.

### 3.2 ⭐ `FIL-GAP-012` — the `E-22` consumer gap, deliberately NOT closed, and the widening precedent deliberately NOT exercised

This is the substantive decision of this ADR. It is stated at length because it would have been easy to make
quietly.

**The gap.** BC Map **L331** gives `E-22` the consumer list `BC-01, BC-10, BC-14`. `PRD-017`'s V1
student-to-student sharing requires **`BC-12` Messaging** to hold a `FileRef`. `BC-12` is not in the cell.
BC Map **L292**: *"If an edge is not in this table, it does not exist and adding it requires an ADR."*

**Stage 3 narrowed the gap rather than accepting the brief's framing** — recorded as `S3-A-01`. Necessity was
tested **per context**, against BC Map §8's aggregate rows, instead of admitting the three contexts the brief
mentioned:

| Context | Needs `E-22`? | Reason |
|---|---|---|
| **`BC-12` Messaging** (L378) | ⛔ **YES** | The minimal sufficient consumer. A shared file must be referenced from a message |
| `BC-11` Social Graph (L377) | ✅ **NO** | Answering `canMessage` requires no file access |
| `BC-13` Trust & Safety (L379) | ✅ **NO** | `E-14` (L318) is **outbound** |

**So the required amendment is one cell, one context** — and `ADR-0016` is the exact precedent for making it. It
amended *"§7.3, edge `E-22`, the Consumer cell only. No edge added, no edge removed, no mode changed, no context
reclassified"*, raising the BC Map to v1.5, with §4.3 naming over-broad amendment as the **High** risk and the
mitigation *"One cell, one edge, named explicitly."* The amendment this module needs is precisely that shape.

⛔ **This ADR does NOT make that amendment, and the reason is authority, not doubt.**

`PRD_OWNERSHIP_MODEL.md` assigns BC Map amendment to the **Architecture Owner**. The authority conferred for this
pass is **Governance Owner** — *"Stage 7; the baseline"*. Those are different roles. Amending `E-22` here would be
the failure mode `ADR-0045` was accepted for refusing and `ADR-0049` recorded declining: **exercising conferred
authority beyond its grant because the answer seemed obvious.** The answer *is* obvious — which is exactly why the
temptation had to be named and refused rather than rationalised. Knowing the right amendment is not the same as
holding the right to make it.

**What was actually asked** was to *"resolve this through the repository's proper architecture/governance process
if Stage 3 proves the dependency is required."* Stage 3 proved it required. **The proper process is an Architecture
Owner ADR amending one cell**, and this ADR **routes it to that owner by name** rather than performing it.
`ADR-0022` — the same question for `BC-03` — has stood **Proposed** since before this module existed, which is
evidence that the repository treats this as an owner's decision and not a clerical one.

⛔ **`FIL-GAP-012` and `B-11` therefore remain OPEN**, and **`IMPL-1230`…`IMPL-1236` are admitted BLOCKED FOR
EXECUTION.** The capability is admitted as **specified and not servable**.

### 3.3 What was NOT done to make the gap look smaller

| Tempting move | Why refused |
|---|---|
| Add `BC-12` to `E-22`'s consumer cell here | Architecture Owner's act, not Governance Owner's. §3.2 |
| Promote `ADR-0022` from `Proposed` | It addresses `BC-03`, not `BC-12`, and promotion is not a freeze act |
| Drop student-to-student sharing from V1 | **Permanently retained in V1 by explicit instruction.** Descoping to make a gate green is the worst option available |
| Route sharing through `BC-14` Content Sharing, which *is* an `E-22` consumer | Would have been **architecturally clever and factually wrong**: `BC-14` owns content sharing, `BC-12` owns messaging, and a message attachment is not a content post. This would have invented an ownership claim to dodge an ADR |
| Record the gap as *"deferred"* rather than *"blocked"* | Stage 3 classified it **blocked**. Softening a conferred classification at Stage 7 is rewriting a verdict |
| Call alignment clean because 6 of 6 checks passed | The verdict is **CONDITIONAL** and the condition is unmet. §6.1 |

---

## 4. The decision

**`PRD-017_FILE_AND_MEDIA.md` v0.1 is ADMITTED to `DOCUMENTATION_BASELINE.md` at Rank 3** as the authoritative
specification for **`BC-29` File & Media**, and `PRD_REGISTRY.md` moves `PRD-017` **`PLANNED`** → **`FROZEN`**.

1. **Rank 3, `BC-29` only.** The **thirteenth** module baseline in §3.3.
2. **v0.1, not renumbered** (`ADR-0020` §4 item 2). The fifth v0.x admission.
3. **232 identifiers across 8 registers**, 1 declared EMPTY, admitted exactly as written. **0 identifiers added,
   removed, renumbered or reworded on admission.**
4. **`IMPL-1200`…`1239`** allocated; **`IMPL-1240`…`1299`** reserved. The range was computed by **two independent
   routes** — a repository-wide scan finding 553 distinct numbers with MAX=1200 proven to be a *boundary marker*
   rather than a task, and `PRD-023_IMPLEMENTATION_TASKS.md` **L89** — ⚠ **not** from `PRD_LIFECYCLE.md`
   **L147–153**, whose stale `IMPL-227+` would have collided with **four** allocated ranges at once.
5. **0 edges, 0 cells, 0 ports, 0 events, 0 aggregates, 0 requirements moved, 0 lines of code.**
6. **All 13 `FIL-GAP-*` are admitted OPEN.** The count did not fall by admitting them.
7. **`FIL-GAP-012` / `B-11` is routed to the Architecture Owner** (§3.2), not resolved here.
8. **`S4-D-06`, `S5-C-05`…`07`, `S5-D-01b`, `S5-F-01`, `S5-F-02` and `GCP-22` are carried**, not repaired.
9. ⛔ **`FROZEN` does not mean `VERIFIED`.**

### 4.1 What the admission rests on

**The `ATT-GAP-010` precedent, measured rather than recalled.** `PRD-006_ATTENDANCE-MANAGEMENT.md` **L1564** and
**L2973** show `PRD-006` reaching **FROZEN while carrying an OPEN `E-22` consumer gap**. So an unresolved `E-22`
question **does not by itself bar a freeze** — it must be **carried transparently**, which is what §3.2, the PRD's
own `FIL-GAP-012`, the Stage 3 verdict's stated condition, the Stage 5 record's refusal to certify alignment, and
`IMPL-1230`…`1236`'s BLOCKED marking each do independently. **Five artefacts state the same limitation and none of
them hides it.**

Freeze fixes **what `BC-29` owns**, not **what is decided**. A specification whose ownership boundary is settled is
worth more to the repository than a draft that keeps drifting while one cell awaits its owner.

---

## 5. What this admission does **not** rest on

- **Not** on the gap being small. It blocks a V1 capability outright.
- **Not** on the tests passing. **0 of 78** acceptance criteria are proven; **all seven** §10.3 architecture tests
  are missing (`B-2`).
- **Not** on 100% coverage. Acceptance coverage is **71.2%**.
- **Not** on `ADR-0022` being resolved. It is still **Proposed**.
- **Not** on the base Stage 3 record being current. It is **stale**, and a supplement was written (§8.1 drift 1).
- **Not** on the instruments being flawless. **Three** self-inflicted checker defects are recorded (§8.1 drift 3).

---

## 6. The authority basis, stated plainly

`PRD_LIFECYCLE.md` **§6 L282** assigns *"Stage 7; the baseline"* to the **Governance Owner**. That authority was
conferred by direct instruction: *"Follow the exact existing freeze precedent … Create the required ADR first if
governance requires it … Freeze PRD-017 as V0.1 unless repository authority requires otherwise."*

`DOCUMENTATION_BASELINE.md` **§7 rule 1** — *"A change to any Rank 1–5 document requires an ADR **before** the
change"* — is why this ADR exists and why it is written **first**, before any baseline, index, registry or PRD
header edit. Governance requires it because the Stage 7 gate **is** a `DOCUMENTATION_BASELINE.md` §3 row, and that
row is a Rank 3 baseline change.

### 6.1 The conditions attached to the grant, and how each was tested

| Condition | Test |
|---|---|
| *"Determine next free ADR number mechanically"* | 53 files, 53 unique numbers `ADR-0001`…`ADR-0053`, **no gaps**, max 53 → **`ADR-0054`**. Counted by tool, twice, in two separate segments |
| *"Create the required ADR first if governance requires it"* | It does. §6 above. This ADR precedes every ranked edit |
| *"Freeze as V0.1 unless repository authority requires otherwise"* | Authority requires **exactly** V0.1 (`ADR-0020` §4 item 2 / §5). Not moved |
| *"Do NOT silently modify the BC Map or invent an edge"* | **0 BC Map bytes changed. 0 edges invented.** §3.2 |
| *"Preserve all unresolved gaps transparently"* | 13 of 13 OPEN, in five independent places (§4.1) |
| *"Do not falsely mark alignment if a dependency remains unresolved"* | The Stage 5 record's own header reads ⛔ **architecture alignment NOT clean and NOT claimed**, and check 10 of `prd017_stage5.py` **fails the gate** if §2M over-claims while `FIL-GAP-012` is OPEN — a guard unique in this repository |
| *"Do not blindly trust previous claims"* | Every allocation, count and hash in this ADR was re-measured this pass. Drift 1 of §8.1 is the case where that discipline changed the outcome |

---

## 7. What acceptance does **NOT** license

| Claim | Licensed? |
|---|---|
| `BC-29` has an authoritative specification | ✅ **Yes** — precisely what is conferred |
| Student-to-student file sharing may be built | ❌ **No.** `B-11`. `IMPL-1230`…`1236` BLOCKED |
| `BC-12` may hold a `FileRef` | ❌ **No.** Requires an Architecture Owner ADR |
| `PRD-017`'s requirements are tested | ❌ **No.** 0 of 78 |
| An aggregate is claimed for `BC-29` | ❌ **No.** `FIL-GAP-001` OPEN; BC Map §8 grants none |
| An event may be published by `BC-29` | ❌ **No.** `FIL-EVT-*` empty; 0 producer rows |
| A virus-scanning provider is chosen | ❌ **No.** Named nowhere |
| Implementation may begin on the other 33 tasks | ✅ **Yes** — `ADR-0020` §6.2: freeze authorises implementation to begin; it does not perform it |

**This conferral is not a standing grant** (`ADR-0033` §7.1). It admits one document at one version.

---

## 8. Counts re-derived by measurement, not by incrementing

| Count | Before | After | How derived |
|---|---|---|---|
| ADR files | 53 | **54** | Filesystem enumeration |
| `Accepted` | 40 | **41** | Classifying every file's own `Status` row on the leading declared token, stripping `**` and backticks |
| `Proposed` | 13 | **13** | **Unchanged — no ADR promoted, demoted or superseded** |
| `Superseded` / `Deprecated` | 0 / 0 | **0 / 0** | — |
| Rank 3 module baselines (§3.3) | 12 | **13** | Enumerating §3.3 specification rows |
| Rank 3 rows in §4 Precedence | 11 | **12** | ⚠ Counted, not assumed: §4 held **11** against §3.3's **12**. That is `GCP-20`, carried — see drift 6 |
| Registry `FROZEN` | 12 | **13** | Enumerating §4.x status cells |
| Registry `PLANNED` | 9 | **8** | Enumerating, not decrementing |
| Missing V1 PRDs | 11 | **10** | — |

**Only one number moves in each pair.**

⚠ **The `BC-29` band claim is measured, and it is deliberately NOT the phrase any predecessor used.** `PRD-016`
claimed *"first CAPABILITY & GENERIC band context frozen"*; `PRD-023` claimed the FOUNDATIONAL band *"3 of 3"*.
**Neither transfers, and reusing either would have been fluent and false.** Measured against BC Map **L258–L268**,
the capability band holds **11** contexts (`BC-20`…`BC-24`, `BC-26`…`BC-31`); `BC-21` and `BC-24` are frozen, so
with `BC-29` the band reaches **3 of 11** — an unremarkable figure, stated because it is the true one. The **exact**
new claim, measured from BC Map §3.3's subdomain column, is that **`BC-29` is the first of the two `Platform
Services` contexts to hold a Rank 3 specification**: the cluster is `BC-29` File & Media and `BC-30` Offline Sync,
and `BC-30` is `PLANNED`.

### 8.1 The search for pre-existing defects was performed and did **NOT** return empty

Following the discipline `ADR-0051` §8.1 established after its own no-defect claim was falsified. **Six drifts.**

**Drift 1 — ⭐ the base Stage 3 record's verdict was anchored to superseded bytes, and this was nearly inherited as
a convenience.** The `PRD-016` and `PRD-023` admissions both record *"all gate records measured the identical hash,
so no supplement was required and none was written."* It was tempting — and would have been fluent — to state the
same here. Instead **every hash citation in every `PRD-017` gate record was extracted and compared**: Stage 3 cites
`85adb6fa…`, Stage 4 cites `880de96e…` and `202ccf5e…`, Stage 5 cites `4ebf5d07…`. **Three of four are stale.**
This is therefore the `PRD-008`/`PRD-013` case, and it was **measured rather than assumed in either direction**.
**Repaired by writing `PRD-017_ARCHITECTURE_ALIGNMENT_SUPPLEMENT.md`**, which re-runs all six checks against the
current bytes and returns the same **PASS — CONDITIONAL, 6 of 6**, with the drift measured as **+2 `FIL-AC-*`
(`FIL-AC-077`, `FIL-AC-078`) and nothing else** — every Class A register (`FR`, `BR`, `INV`, `EVT`, `XC`) proven
**identical in membership**, which is why the architectural verdicts survive re-testing. The base record's stale
hash is **deliberately unrepaired**: rewriting it would make it claim a review that did not happen. The general
defect — **no instrument checks whether a gate record's cited hash still matches its subject**, and
`alignment_record_freshness.py`'s `RECORDS` table does not cover `PRD-017` — is opened as **`GCP-22`** and
**carried**.

**Drift 2 — `S4-D-06` missing from the Stage 4 record** (§3.1). **Carried, not repaired.**

**Drift 3 — three self-inflicted instrument defects, recorded rather than hidden.** `S5-C-05` (a class-claim
arithmetic hole) and `S5-C-06` (a FROZEN-pattern over-match), plus ⭐ **`S5-C-07`**, which is the one worth stating
in full because it is the most instructive failure of this whole pass: check 4c did `if owned: continue`, skipping
the **entire file body** for anything in the module's own directory — so **citation resolution never ran inside
`docs/30-product/file-media/`**. The exemption had been scoped by **directory** when the thing it needed to excuse
was **a particular kind of line**. Splitting it so only the *definition* scan is exempt moved resolved citations
**141 → 479** and immediately exposed **3 dangling citations**, one of which — a numbered `FIL-EVT-*` token in the
Stage 3 record's §8 row `R-6`, naming an event the same row **rejected** — had been resident **since Stage 3** and
had passed every checker every time. **Fixed in the instrument; the finding is retained rather than quietly
absorbed.** ⚠ **And it recurred here.** The two sentences above originally reproduced that very token while
explaining it, so this ADR spent its first draft committing the defect it was written to record — caught by the
repaired checker on the Stage 7 re-run, which is exactly the outcome the repair was for. **The checker was right
and the prose was fixed, not the rule**; both passages now name the register and the ordinal position instead of
minting a number that resolves nowhere. Logged as the third occurrence of the author-introduced-phantom class
after `PRD-023`'s four and this module's six at Stage 5.

**Drift 4 — the Stage 5 conferral record cited a phantom identifier six times while both gates passed.** Found by
an out-of-band `grep` against a claim just made in prose — **not** by either instrument. ⚠ **Two independent
instruments were not sufficient**: one never opens sibling artefacts, the other had been told to skip them. Then,
while *documenting* that very defect, the phantom was **reintroduced into the paragraph describing it**, and the
repaired check caught it. Recorded because it is the argument for a mechanical guard over care.

**Drift 5 — two stale Rank 1 / Rank 4 statements, both carried.** `PRD_LIFECYCLE.md` **L147–153**'s `IMPL` table
still reads `IMPL-227+` (§4 item 4), and `PRD_DEPENDENCY_GRAPH.md` **L113** still claims *"PRD-002 owns BC-29"* —
directly contradicted by `ADR-0013` §5, which **this ADR executes**. Each needs its own ADR at its own rank. The
second is disclosed here precisely because **this admission is the act that makes it visibly wrong**.

**Drift 6 — `GCP-20` still open**: `DOCUMENTATION_BASELINE.md` §4 holds **11** Rank 3 rows against §3.3's **12**.
This admission adds one to each, so **after it §4 holds 12 against §3.3's 13**. The discrepancy is **preserved, not
silently corrected**, and the surviving consequence is stated rather than left to be rediscovered by the next pass.

---

## 9. Options considered

| Option | Verdict |
|---|---|
| **Admit v0.1 at Rank 3, carry all 13 gaps, route `E-22` to the Architecture Owner** | ✅ **CHOSEN** |
| Amend `E-22`'s consumer cell here to close `FIL-GAP-012` first | ❌ Exceeds the conferred grant. §3.2 |
| Refuse the freeze until `FIL-GAP-012` is closed | ❌ Contradicts the measured `ATT-GAP-010` precedent, and would leave `BC-29` unowned indefinitely while one cell awaits an owner |
| Drop student-to-student sharing from V1 to make the gate clean | ❌ V1 scope is permanently retained by instruction. Descoping to pass a gate is the worst option available |
| Renumber to v1.0 to mark the freeze | ❌ `ADR-0020` §5 expressly rejects it |
| Repair the base Stage 3 record's hash in place | ❌ Would make it claim a review that did not happen. A supplement was written instead |
| Write no supplement, on the `PRD-016`/`PRD-023` precedent | ❌ That precedent rests on all hashes agreeing. Here **three of four are stale** — §8.1 drift 1 |
| Declare architecture alignment clean because 6 of 6 checks passed | ❌ The verdict is **CONDITIONAL** and the condition is unmet |

---

## 10. Consequences

### 10.1 Immediate

- `DOCUMENTATION_BASELINE.md` gains a **§3.3 Rank 3 row** and a **§4 precedence row**; the baseline advances to
  **`BASELINE-2026-08-20-B`**.
- `ADR-INDEX.md`: **54 files / 41 accepted / 13 proposed / 0 superseded / 0 deprecated.**
- `PRD_REGISTRY.md` **L307**: `PLANNED` → **`FROZEN`**; §7 counts move.
- `PRD-017`'s header cells move to `FROZEN` at Rank 3. **Version stays v0.1.**
- **`IMPL-1200`…`1239`** becomes the allocated range of record; **`1240`…`1299`** reserved.

### 10.2 What does **not** change

`MASTER_PRD.md` · the **BC Map** · the Module Dependency Matrix · `ARCHITECTURE_RULINGS.md` ·
`CONFIGURATION_GUIDE.md` · `tool/module_dependencies.yaml` · all **23** pre-existing `tool/docs_check` scripts ·
`TRACEABILITY_MATRIX.md` (already at v1.17 from Stage 5) · every other frozen PRD · **all code**.

### 10.3 Carried forward

13 `FIL-GAP-*` · `B-2` · `B-11` · 7 missing §10.3 architecture tests · `S4-D-06` · `S5-C-05`…`07` · `S5-D-01b` ·
`S5-F-01` · `S5-F-02` · **`GCP-22`** · `GCP-20` · `GCP-21` · `GCP-14` · `H-1` · `Q-01`…`Q-07` · `PGA-03`…`10` ·
the stale `IMPL-227+` table · the stale `PRD_DEPENDENCY_GRAPH.md` L113 claim · 9 boundary findings ·
13 `Proposed` ADRs including **`ADR-0022`**.

---

## 11. Compliance

| Rule | Held? |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 rule 1 — ADR **before** the change | ✅ This ADR was written first |
| §7 rule 2 — version + changelog in the same commit | ✅ |
| §7 rule 3 — declaration updated in the same commit | ✅ |
| §7 rule 4 — baseline id moves when a Rank 1–3 document changes version | ✅ `BASELINE-2026-08-20-B` |
| BC Map **L292** — an edge not in the table does not exist | ✅ **Obeyed, not worked around.** §3.2 |
| `ADR-0020` §4 item 2 / §5 — freeze does not renumber | ✅ v0.1 preserved |
| `PRD_LIFECYCLE.md` — *"Freeze is conferred, not claimed"* | ✅ Conferred by the §3.3 row, not by the PRD |
| `ADR-0016` §4.3 — *"One cell, one edge, named explicitly"* | ✅ Cited as the **correct future mechanism**, and not exercised without the authority to exercise it |
| `ADR-0051` §8.1 — test the no-defect claim | ✅ Tested; **six drifts found**, §8.1 |

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-20 | Created **Accepted**. Admits `PRD-017_FILE_AND_MEDIA.md` **v0.1** at Rank 3 for `BC-29` File & Media — the **thirteenth** module baseline, the **fifth** v0.x admission, and the **first of the two `Platform Services` contexts** to gain a Rank 3 specification (measured from BC Map §3.3, deliberately **not** borrowed from either predecessor's band phrasing, both of which are false here). **0 edges, 0 cells, 0 ports, 0 events, 0 aggregates, 0 requirements moved, 0 lines of code.** ⛔ **All 13 `FIL-GAP-*` OPEN**; **`FIL-GAP-012`/`B-11` routed to the Architecture Owner rather than resolved by a Governance Owner grant that does not extend to BC Map amendment** — the central decision, §3.2, where the right amendment is identified precisely and then **declined for want of authority**. Admitted on the **measured** `ATT-GAP-010` precedent that a freeze may carry an open `E-22` gap transparently, with five independent artefacts stating the limitation. ⛔ **`FROZEN` is not `VERIFIED`: 0 of 78 criteria proven, 0 of 40 tasks implemented, 7 of 7 architecture tests missing, acceptance coverage 71.2% and deliberately not conflated with the 100.0% task figure.** ⚠ **The pre-existing-defect search returned SIX drifts, not none** — the first being that **three of four gate-record hashes were stale**, nearly inherited as a convenience from the `PRD-016`/`PRD-023` precedent, instead measured and answered with a **supplement** rather than a rewrite; **`GCP-22`** opened for the missing freshness instrument |
