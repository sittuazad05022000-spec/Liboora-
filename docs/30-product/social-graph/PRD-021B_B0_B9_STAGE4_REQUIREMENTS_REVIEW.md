# `PRD-021B` B0–B9 — Consolidated Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` **L108–119**) |
| **Subject** | `PRD-021B` parts **B0, B1, B2, B3, B4, B5, B6, B7, B8, B9**, reviewed as **one consolidated unit** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* (**L119**) |
| **Predecessor** | Stage 3 ✅ **PASS — 6 of 6**, [`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md`](PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md), delivered at `1db32af` |
| **Prior Stage 4** | [`PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md`](PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md) — B0–B3 only, PASS 6/6 at `b28d562`. ⛔ **Its counts are NOT reused; every figure below is re-derived over all ten parts** |
| **Measured at** | `1db32af90129f093d32f3bcbb4b1608d27b83983`, working tree clean |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6 **L278**). ⚠ **No named holder exists** — `PGA-08` |
| **Authority claimed** | ⛔ **NONE beyond measurement.** This record is a **measurement**, not an approval |
| **Subject hashes** | ⛔ **All ten byte-unchanged by this review** — verified before and after (§15) |
| **Verdict** | ✅ **STAGE 4 PASS — 6 of 6 checks.** Gate **SATISFIED**: **21 open items, 0 without a reason, 0 without an owner.** 1 accepted finding · 9 rejected findings · 3 corrections carried forward · **4 instrument defects disclosed** |
| **Stage 5** | ⛔ **NOT ENTERED** |
| **Freeze** | ⛔ **NOT DONE** |
| **Implementation** | ⛔ **NONE** |

> ⛔ **Stage-3 PASS did not carry to Stage 4, and this record re-derived every count.**
> Stage 3 asks *"is this lawful against Ranks 1–5?"*; Stage 4 asks *"is this **buildable and
> verifiable** as written?"* The six checks share no overlap.
>
> ⛔ **No requirement was written to close any criterion.** `PRD-008_STAGE4_CONFERRAL.md` §4:
> *"The most corrupting way to pass a requirements review is to write the missing requirement."*
> **0 identifiers minted. 0 subject bytes changed. 0 owner decisions invented.**
>
> ⛔ **Repository-first.** Where the task text and the repository disagreed, the repository won.
> Two such disagreements are recorded: the remote name (§15) and the `origin` naming (§19).

---

## §1 Scope

### §1.1 What this record is

A **consolidated Stage 4 requirements review** of `PRD-021B` parts **B0–B9**, executed as one
unit rather than ten individual reviews, per the instruction *"B0–B9 ko ek consolidated unit ke
roop mein review karo. Parts ko individually Stage 4 karne ki zarurat nahi."*

The **objective**, as instructed, is to determine whether the complete B0–B9 requirements set is:

| # | Property | Result |
|---|---|---|
| 1 | Internally coherent | ✅ |
| 2 | Complete enough for downstream traceability | ✅ |
| 3 | Correctly scoped | ✅ |
| 4 | Non-duplicative | ✅ |
| 5 | Architecture-consistent | ✅ |
| 6 | Testable | ✅ |
| 7 | Properly identified | ✅ |
| 8 | Correctly linked to authority | ✅ |
| 9 | Free of unresolved contradictions that **actually block** requirements approval | ✅ |

### §1.2 What this record is NOT

⛔ It is **not** an architecture redesign. *"Stage 4 is a requirements review, not an
architecture redesign."* No valid Stage 3 decision is reopened, re-ranked or rewritten.

⛔ It is **not** Stage 5. The Stage 5 gate (**L121–133**) requires *"the PRD's prefixes
registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, **zero
collisions**."* **That registration was not performed.** `TRACEABILITY_MATRIX.md` holds **0**
`PRD-021B` rows and this record adds none. §14 measures traceability **readiness**, which is a
different and weaker claim.

⛔ It is **not** Stage 6. No `IMPL-*` identifier was created or reserved.

⛔ It is **not** a freeze. Freeze is conferred by an ADR under `PRD_LIFECYCLE.md` §4, by the
Governance Owner. **No ADR was written.**

### §1.3 The Stage 4 gate, quoted verbatim

`PRD_LIFECYCLE.md` **L108–119**:

```
### Stage 4 — Requirements Review

| Check | Failure |
|---|---|
| Every requirement testable | "The system should be fast" — unverifiable |
| Every exclusion states what must be impossible | An exclusion is not a deferral |
| Every configurable has a default and a range | Unbounded configuration is a specification hole |
| Every acceptance criterion maps to a requirement | Orphan criterion |
| No requirement restates another PRD's | Two sources of truth |
| Business rules do not contradict Rank 1 | Rank 1 wins; the PRD is wrong |

**Gate:** conflicts closed or explicitly deferred with a reason and an owner.
```

⭐ **Note the gate's exact shape.** It does **not** require conflicts to be *closed*. It
requires them to be *closed **or** explicitly deferred with a reason and an owner*. An OPEN
item with a reason and a named owner **satisfies** the gate. This is the single most
consequential reading in this record and it drives the PASS at §16.

---

## §2 Repository baseline inspected

⛔ *"Do not rely on memory or supplied text when repository evidence is available."* Every
figure in this record was measured against the files below at `1db32af`.

### §2.1 Governance — Ranks 1 and 2

| Document | Lines read | What it settled here |
|---|---|---|
| `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | **L108–119** | The six Stage-4 checks and the gate (§1.3) |
| ″ | **L88–106** | Stage 3 gate — read to confirm **no overlap** with Stage 4 |
| ″ | **L104–106** | *"A rejected finding must be recorded as rejected, with its reason… A review that records only accepted findings is indistinguishable from a review that found nothing."* → §12 exists because of this line |
| ″ | **L121–133** | Stage 5 gate — read to know exactly what **not** to do |
| ″ | **L135+** | Stage 6 gate (`IMPL-*` range) — read to know exactly what **not** to do |
| ″ | **L164** | *"A change to any Rank 1–5 document requires an ADR **before** the change."* |
| ″ | **§5 rule 5** | A withdrawn identifier's number cannot return → `XPB-CONF-011` |
| `docs/30-product/MASTER_PRD.md` | **L83**, **L89–97**, **L121**, **L327–341**, **L504**, **L519**, **L551–552** | **Rank 1.** The V1 context list, the `MP-SCOPE-01…09` wave table, `MP-GBR-06…09`, `MP-GBR-22`, `MP-RSK-01/02`, `MP-CON-08` |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | §3.2, §3.3, §4 | Precedence ranks; the frozen-PRD inventory |
| `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` | §2.2 **L81–87**, **L203** | Who owns which decision → the owner column in §11 |

### §2.2 Architecture — Rank 4

| Document | Lines read | What it settled here |
|---|---|---|
| `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **L10** | **31 contexts, 28 edges** — `E-01`…`E-26` + `E-28`, `E-29`; ⛔ `E-27` permanently vacant |
| ″ | **L116** | Presence belongs to `BC-12` |
| ″ | **L292** | *"If an edge is not in this table, it does not exist"* |
| ″ | **L331** | `E-22` consumers: `BC-01`, `BC-10`, `BC-12`, `BC-14` |
| ″ | **L377–378** | The `BC-11`/`BC-12` aggregate and invariant registers (`Friendship`, `BlockList`, `Conversation`, `DeliveryReceipt`, `RetentionPolicy`, `canMessage`) |
| ″ | **L488** | Rule `ID-2` — `BC-11`…`BC-17` are **global**, no `tenantId` |
| ″ | **L558** | `AR-1` — Library Discovery & Enrollment is **not** a bounded context |
| `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **L354**, **L362** | `X-05` Separate Ways; `X-13` |
| `docs/10-architecture/ARCHITECTURE_RULINGS.md` | `AR-1` **L23–52** | A read composition owns no aggregate → the shape B3/B5/B6 claim |
| `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **L948**, **L950**, **L1847**, **L1854–1855** | **Rank 6, descriptive.** Read receipts / presence / retention wave tags → `XPB-CONF-014/015/017` |
| `tool/module_dependencies.yaml` | **L228–270**, **L243**, **L265**, **L268–270** | CI `banned_imports` / `banned_symbols`; realtime is a **port** |

### §2.3 Frozen Rank 3 PRDs — ⛔ read-only, not editable here

| Document | Lines read | Bearing |
|---|---|---|
| `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` **FROZEN** | §8.3, §10 **L633**, `TSF-FR-001`, `TSF-FR-024`, `TSF-INV-005`, `TSF-XC-004`, `TSF-XC-005`, `TSF-XC-021` | The four-stage pipeline B3 composes; the 50 ms fail-closed budget B8/B9 cite |
| `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` **FROZEN** | **L195–208**, **L1162–1165** (`FIL-GAP-013`), `FIL-FR-081`, `FIL-XC-002` | `BC-29` owns all media; the confinement statement assigned to `PRD-021` → `XPB-CONF-013` |
| `docs/30-product/social-graph/PRD-021A_A1_…DRAFT_v0.2.md` | **L221**, **L225** | **`LCM-FR-011`, `LCM-FR-013`** → §13 |
| `PRD-012a`, `PRD-016`, `PRD-001`, `PRD-002` | as cited by the parts | Frozen authority the parts cite |

### §2.4 The `PRD-021B` review chain

| Document | Bearing |
|---|---|
| `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ⭐ **The architecture baseline for Check E.** PASS 6/6, 0 BLOCKED, 5 accepted / 12 rejected |
| `PRD-021B_STAGE3_ARCHITECTURE_ALIGNMENT.md` | B0–B3, FAIL 5/6 — **superseded**, retained unedited |
| `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` | B0–B3 PASS 6/6. **§5 L127–141 = `C-1`/`C-2`/`C-3`**, *"recorded, NOT applied"* |
| `PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md` | B0–B3 Stage 4, PASS 6/6. Structural template; §1 register definition; §7 `S4-R-1`…`S4-R-5`; §8 `I-1`/`I-2`/`I-3` |
| `PRD-021B_B4_B5_B6_STAGE3_ARCHITECTURE_ALIGNMENT.md` | B4–B6 Stage 3, PASS 6/6 |
| `PRD-021B_B4_B5_B6_CROSS_PART_AUDIT.md` | Cross-part audit, B4–B6 |
| `PRD-021B_B7_B8_B9_CROSS_PART_AUDIT.md` | Cross-part audit, B7–B9. **L292–303** = the conflict-disposition table with owners |
| `docs/00-governance/adr/ADR-0091-*.md` | Owner decisions closing `XPB-CONF-001…005` |
| `ADR-0011`, `ADR-0033`, `ADR-0055`, `ADR-0065`, `ADR-0083`, `ADR-0087` | Cited authority |
| `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | §4.2 **L321**, §§11–14 — `PRD-021B` registration and the B4–B6 / B7–B9 sections |
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | ⭐ **0 `PRD-021B` rows** — the Stage 5 gate is demonstrably not met and is not attempted |

### §2.5 The ten subjects, with freshness anchors

Measured at `1db32af`, **before** this review began:

| Part | File | Lines | sha256 |
|---|---|---|---|
| **B0** | `PRD-021B_B0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` | 392 | `69dae44e5c8f99fa2fcae71d60f88fac7032ba116d9ba04280752f3c2ec94954` |
| **B1** | `PRD-021B_B1_SOCIAL_GRAPH_DRAFT_v0.1.md` | 772 | `503c804504f2d04e315c0cf3c99d89e6465eaa1ef668e42e938db65db7532816` |
| **B2** | `PRD-021B_B2_SOCIAL_SAFETY_DRAFT_v0.1.md` | 588 | `7339862f8cf9fc1174686126f3f49f441316f910352b37e0300f64b90c7963af` |
| **B3** | `PRD-021B_B3_STUDENT_DISCOVERY_DRAFT_v0.1.md` | 564 | `a3ccec3de060144efb932cdf7869c83c21b9a423d70854c6960017946953b533` |
| **B4** | `PRD-021B_B4_DISCOVERY_RANKING_DRAFT_v0.1.md` | 600 | `429ed76f94042e8988391f6add4dad04ab0ed8afb931750bdc6012e969e2d0cd` |
| **B5** | `PRD-021B_B5_STUDENT_RECOMMENDATIONS_DRAFT_v0.1.md` | 532 | `2c8f1c3dba8840c18488d81b3e7397af54b05b301b8b73fba59453c375ebe5bc` |
| **B6** | `PRD-021B_B6_DISCOVERY_SCOPE_DRAFT_v0.1.md` | 425 | `1c481c6ae7557568d80e0a7156667d9132ef1a05ba812caa9be82e296f31137b` |
| **B7** | `PRD-021B_B7_MESSAGING_DRAFT_v0.1.md` | 939 | `01e2a7fad860abe2a01398a6ac288f73e6532e9d69fcdee1ff99b7af4afc9b4a` |
| **B8** | `PRD-021B_B8_REALTIME_MEDIA_SAFETY_DRAFT_v0.1.md` | 809 | `a075ba341baa90037d0290c096f4bf886d9b622410c042f13791042f88506f22` |
| **B9** | `PRD-021B_B9_TECHNICAL_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` | 982 | `21561f8b53af7602b0f04182645a75c6fff57226af61359f241054ace2d383a5` |

**Total 6,603 lines.** ⭐ These hashes are **identical** to those recorded in the Stage 3
record §1, which proves the ten subjects are byte-unchanged between Stage 3 and Stage 4 —
the Stage-3 findings therefore describe the **same bytes** this review measures.

---

## §3 B0–B9 parts reviewed

| Part | Stem | Domain | Stage 3 status | Registers | Identifiers |
|---|---|---|---|---|---|
| **B0** | `XPA-` / `FOD-` | Cross-part architecture & open decisions | PASS (consolidated) | 4 | 22 |
| **B1** | `SGR-` | Social graph (`BC-11`) | PASS | 14 | 183 |
| **B2** | `SSF-` | Social safety | PASS | 14 | 174 |
| **B3** | `SDS-` | Student discovery | PASS | 14 | 161 |
| **B4** | `DRK-` | Discovery ranking | PASS | 14 | 133 |
| **B5** | `PYK-` | Student recommendations | PASS | 16 | 135 |
| **B6** | `GLS-` | Discovery scope (global/library) | PASS | 12 | 100 |
| **B7** | `MSG-` | Messaging (`BC-12`) | PASS (consolidated) | 10 | 137 |
| **B8** | `RTM-` | Realtime, media & messaging safety | PASS (consolidated) | 7 | 109 |
| **B9** | `TPA-` | Technical & production architecture | PASS (consolidated) | 8 | 146 |
| | | | **TOTAL** | **113** | **1,300** |

⭐ **All ten parts are `DRAFT v0.1`, Stage 2 authored.** None is frozen. None is registered in
`TRACEABILITY_MATRIX.md`. This review changes neither fact.

---

## §4 Requirements audit methodology

### §4.1 What counts as a "requirement"

Inherited unchanged from the B0–B3 Stage 4 record §1. A **requirement** is an identifier in a
**normative** register:

> `FR` · `BR` · `INV` · `XC` · `SEC` · `PRV` · `API` · `EVT` · `DM` · `IDX` · `PERF` ·
> `CACHE` · `EC` · `SCOPE` · `RM` · `DEP` · `BND` · `PREC`

⛔ **`GAP`, `FOD` and `ACGAP` are NOT requirements.** They are **conflict registers**. The
prior record's phrasing governs: *"An AC citing only a gap is gap-backed, which is the opposite
of requirement-backed."* This distinction is measured at §14.

### §4.2 Scan discipline — own-stem-only

Every register census used **own-stem-only** matching: a part's `SGR-FR-nnn` count counts only
tokens whose stem is that part's own stem. This deliberately avoids instrument defect **`I-1`**
disclosed by the B0–B3 record (*"Register scan matched any `XXX-YYY-nnn` token, counting cited
foreign identifiers as host declarations"*). It is why the census at §7 returned **113/113
contiguous on the first attempt** with no false alarms.

### §4.3 The false-negative discipline

⚠ **Four probes in this review returned near-total-failure results and all four were wrong.**
Each was diagnosed by reading the repository rather than trusting the instrument. The rule
applied throughout:

> **A requirements probe that reports a ~100 % failure rate across ten independently authored
> documents is far more likely to be broken than the documents are.**

All four defects are disclosed at §15.1, with their corrected figures. ⛔ **No result in this
record rests on an uncorrected probe.**

### §4.4 Measurement, not authorship

⛔ **0 identifiers minted. 0 subject bytes changed. 0 owner decisions invented.** Where a
requirement was found missing or an authority mis-cited, it is **recorded as a finding**, never
repaired in the subject. This is `PRD-008_STAGE4_CONFERRAL.md` §4 operating as designed.

---

## §5 The six Stage-4 checks — summary

| # | Check | Authority | Measured | Result |
|---|---|---|---|---|
| **1** | Every requirement testable | **L111** | **0** vague normative lines in **365** FR/BR + `PERF`/`INV`/`SEC` registers | ✅ **PASS** |
| **2** | Every exclusion states what must be impossible | **L112** | **156** `XC`; **154** carry a prohibition; **2** residuals read and dispositioned (§6.2) | ✅ **PASS** |
| **3** | Every configurable has a default and a range | **L113** | **29** `CFG`; **26** in table form with explicit default + range; **3** in prose form with defaults + bounding exclusion (§6.3) | ✅ **PASS** |
| **4** | Every acceptance criterion maps to a requirement | **L114** | ⭐ **242 / 242** valid · **0** orphans · **0** dangling · **0** duplicate triples · **0** gap-backed | ✅ **PASS** |
| **5** | No requirement restates another PRD's | **L115** | **365** FR/BR harvested; **4** candidates ≥ 0.86; **0** genuine restatements (§6.5) | ✅ **PASS** |
| **6** | Business rules do not contradict Rank 1 | **L117** | **0** contradictions of `MASTER_PRD.md`; **0** ownership claims over credential/OTP/session/authorisation | ✅ **PASS** |

### **Gate (L119): ✅ SATISFIED**

**21 open items** carried. **0** without a reason. **0** without an owner. Detail at §11.

### **VERDICT: ✅ STAGE 4 PASS — 6 of 6**

---

## §6 FR / BR results

### §6.1 Check 1 — testability

**Method.** Every line declaring an `FR`, `BR`, `PERF`, `INV` or `SEC` identifier was scanned
for the vague-language set the gate's own failure example implies:

```
fast | quickly | user-friendly | appropriate | reasonable | efficient
as needed | robust | scalable | seamless | intuitive | good performance | sufficiently
```

**Result: 0 hits across all ten parts.** The gate's failure example — *"The system should be
fast"* — has **no instance** in B0–B9.

**Corroborating measurement — normative intent.** Every `FR`/`BR` identifier was tested for a
modal verb (`MUST`, `SHALL`, `MUST NOT`, `SHALL NOT`, or `⛔`) within its declaration window:

| Part | FR | BR | Modal-bearing | Non-normative |
|---|---|---|---|---|
| B0 | 0 | 0 | — | — |
| B1 | 27 | 18 | 27 / 27 | 0 |
| B2 | 27 | 22 | 27 / 27 | 0 |
| B3 | 17 | 19 | 19 / 19 | 0 |
| B4 | 14 | 11 | 14 / 14 | 0 |
| B5 | 6 | 5 | 5 / 6 | **1 — `PYK-FR-001`** |
| B6 | 11 | 8 | 11 / 11 | 0 |
| B7 | 33 | 17 | 33 / 33 | 0 |
| B8 | 30 | 20 | 30 / 30 | 0 |
| B9 | 31 | 49 | 49 / 49 | 0 |
| **TOTAL** | **196** | **169** | | **1** |

⭐ **`PYK-FR-001` inspected and cleared.** B5 **L118–119**:

> `PYK-FR-001` — B5 is a **read composition** (`AR-1` shape): it owns no aggregate, no
> invariant and no business state, and orchestrates public read models only.

This is a **scope declaration in the `AR-1` shape**, not an unverifiable behavioural promise.
It is fully testable — one enumerates B5's aggregates and asserts the count is zero, which is
exactly what `PYK-AC-023` and the B5 `⛔ owns no aggregate` statements (3 occurrences) do. The
absence of a modal verb is a **stylistic** property of a declaration, not the *"should be
fast"* defect check 1 exists to catch. **No finding.**

**Hidden implementation assumptions.** Every `FR`/`BR` line was scanned for implementation
leakage (`CREATE TABLE`, `ALTER TABLE`, migration, `Dockerfile`, `kubectl`, `npm install`,
`SELECT *`, `INSERT INTO`, `package:`, Dart/Flutter class or widget syntax).

**Result: 0 hits across all ten parts.** The requirements specify **behaviour**, not
implementation.

**Check 1 result: ✅ PASS.**

### §6.2 Check 2 — exclusions state what must be impossible

**Total `XC` identifiers: 156.** The gate's failure mode is *"An exclusion is not a
deferral"* — an `XC` that merely postpones rather than prohibits.

⚠ **The first probe reported 8 failures. It was wrong.** See §15.1 defect **`I4-1`**.
Corrected probe (prohibition anywhere in the identifier's **sentence**, ±260 chars):

| Part | `XC` | Carry a prohibition | Residual |
|---|---|---|---|
| B0 | 0 | — | — |
| B1 | 14 | 14 | 0 |
| B2 | 15 | 14 | **1 — `SSF-XC-002`** |
| B3 | 15 | 14 | **1 — `SDS-XC-013`** |
| B4 | 12 | 12 | 0 |
| B5 | 8 | 8 | 0 |
| B6 | 9 | 9 | 0 |
| B7 | 22 | 22 | 0 |
| B8 | 21 | 21 | 0 |
| B9 | 40 | 40 | 0 |
| **TOTAL** | **156** | **154** | **2** |

⭐ **Both residuals inspected and cleared.** `SSF-XC-002` (B2 **L296–299**) and `SDS-XC-013`
(B3 **L385–388**) are **⭐-marked disclosure / binding statements** placed in the `XC` register
for locality — they record that a named constraint *binds* this part, rather than declaring
something impossible. Neither is a **deferral**, which is the specific failure check 2 tests
for. A disclosure is not a postponement.

⚠ **Recorded as a documentation observation, not a Stage 4 defect** (§10, finding `A4-1`): two
of 156 `XC` members are in a shape their register's name does not describe. Correcting the
placement is a **subject edit** requiring the document owner, and the B0–B3 precedent is that
a review **records** such shapes rather than repairing them.

**Check 2 result: ✅ PASS — 154 / 156 in prohibition shape, 2 residuals in disclosure shape,
0 deferrals.**

### §6.3 Check 3 — every configurable has a default and a range

**Gate text (`PRD_LIFECYCLE.md` L113):** *"Every configurable has a default and a range —
unbounded configuration is a specification hole."*

⭐ **This check is materially different from the B0–B3 review.** That review disposed of check 3
as **vacuously satisfied**, because B0–B3 declare **0** `CFG` identifiers (rejected finding
`S4-R-5`, prior record **L168**: *"check 3 binds 'every configurable'; **0 configurables are
declared**, so it is vacuously satisfied. Deferring three numbers **with owners** is the honest
disposition; minting them would be the defect"*). **B4–B8 do declare configurables**, so for
B0–B9 the check is **live, not vacuous**, and had to be measured.

**§6.3.1 Census — 29 `CFG` identifiers.**

| Part | `CFG` | Numbers | Declaration form |
|---|---|---|---|
| B0 | 0 | — | — |
| B1 | 0 | — | — |
| B2 | 0 | — | — |
| B3 | 0 | — | — |
| B4 | **8** | `001`–`008` | 5-column table, **L334–341** |
| B5 | **7** | `001`–`007` | 5-column table, **L400–406** |
| B6 | **5** | `001`–`005` | 5-column table, **L236–240** |
| B7 | **6** | `001`–`006` | 5-column table, **L680–685** |
| B8 | **3** | `001`–`003` | ⚠ **prose**, **L317**, **L318**, **L339** |
| B9 | 0 | — | — |
| **TOTAL** | **29** | all contiguous `001..max` | **26 table-form + 3 prose-form** |

**§6.3.2 The table-form 26 — default and range both present.**

⚠ **The first probe reported near-total failure (B4 8/8, B5 6/7, B6 1/5, B7 6/6, B8 3/3
"lacking a default or range"). It was wrong** — it could not parse markdown table cells. That is
instrument defect **`I4-2`** (§15.1), and the ~100 % failure rate is the signature §4.3 says to
distrust. A second probe, taking each identifier's **first** occurrence, was also wrong — it
caught **citations** rather than declarations (reporting 18 table / 11 prose). The corrected
probe locates each identifier's **declaration row** — the table row whose **first cell** is the
identifier — and reads cells 3 (default) and 4 (range).

⭐ **Result: 26 of 26 declaration rows parse to exactly 5 cells, with a populated default cell
and a populated range cell.** Verbatim samples:

| Identifier | L | Parameter | Default | Range |
|---|---|---|---|---|
| `DRK-CFG-001` | B4 **L334** | `weight.relevance` | `0.60` | `0.00`–`1.00` |
| `DRK-CFG-004` | B4 **L337** | `mutualCount.saturationCap` | `10` | `1`–`50` |
| `DRK-CFG-008` | B4 **L341** | `config.versionPin` | `DISC-RANK-1` | enum of published versions |
| `PYK-CFG-001` | B5 **L400** | ⭐ `capability.recommendationsEnabled` | **`false`** | `{true,false}` |
| `PYK-CFG-003` | B5 **L402** | `set.refreshIntervalHours` | `24` | `1`–`168` |
| `PYK-CFG-004` | B5 **L403** | `dismissal.windowDays` | `90` | `1`–`365` |
| `GLS-CFG-002` | B6 **L237** | ⭐ `scope.globalEnabled` | **`false`** | `{true,false}` |
| `GLS-CFG-005` | B6 **L240** | `scope.defaultValue` | `LIBRARY` | enum of the four values |
| `MSG-CFG-002` | B7 **L681** | Read-receipt disclosure enabled | ⛔ **FALSE** | ⛔ **FALSE only** while `XPB-CONF-014` is OPEN (`MSG-XC-021`) |
| `MSG-CFG-003` | B7 **L682** | Retention window | platform default, **fixed** | ⛔ not configurable in V1 (`MSG-FR-028`) |

⭐ **Note the shape of the gated rows.** `PYK-CFG-001`, `GLS-CFG-002`/`003`/`004`,
`MSG-CFG-002` and `MSG-CFG-003` each carry a **default that is `false`/fixed** plus a range cell
that names the **exclusion holding it there** and the **open decision** that must close before
it can move. That is not an unbounded configurable — it is the **tightest possible** bound: a
single admissible value, with the authority for the bound cited in the row. This is the
`PYK-XC-004` / `MSG-XC-021` / `RTM-XC-021` gating pattern, described in B8 **L321–322** as
*"drafted, gated, un-enablable."*

⚠ **`MSG-CFG-001`/`004`/`005`/`006` state their default as `platform default` and their range as
`bounded`** rather than a numeral. Read as a requirements statement, this **delegates** the
value to the platform while asserting the *existence* of a bound — and `MSG-CFG-005` names the
requirement carrying it (`MSG-FR-012`). ⛔ **Not scored as a check-3 failure**: the gate requires
that a default and a range **exist and be stated**, not that they be numeric. A reviewer could
reasonably ask the document owner to numerate them; ⛔ **this review does not mint the numbers**
(*"The most corrupting way to pass a requirements review is to write the missing requirement"* —
`PRD-008_STAGE4_CONFERRAL.md` §4). Recorded as an observation, **not** a defect.

**§6.3.3 The 3 prose-form residuals — `RTM-CFG-001` / `002` / `003`.**

These three are the **only** configurables in B0–B9 with **no table-row declaration**. Read at
source:

```
B8 L317:  `RTM-CFG-001` — Presence disclosure enabled — default ⛔ **FALSE**.
B8 L318:  `RTM-CFG-002` — Typing indicator enabled — default ⛔ **FALSE**.
B8 L339:  `RTM-CFG-003` — Presence granularity — platform default, coarse.
```

| Identifier | Default stated? | Range in the declaration? | Bounded elsewhere? |
|---|---|---|---|
| `RTM-CFG-001` | ✅ ⛔ **FALSE** | ⛔ Not in the declaration line | ✅ **`RTM-XC-021`** (B8 **L320–322**) |
| `RTM-CFG-002` | ✅ ⛔ **FALSE** | ⛔ Not in the declaration line | ✅ **`RTM-XC-021`** |
| `RTM-CFG-003` | ✅ platform default, coarse | ⚠ *"coarse"* is qualitative | ✅ **`RTM-SEC-002`** (B8 **L336–337**) |

⭐ **All three carry a default, and all three are bounded by a normative sibling.** Quoted at
source, B8 **L320–322**:

> `RTM-XC-021` — ⛔ `RTM-CFG-001` and `RTM-CFG-002` **SHALL NOT** be set `TRUE`
> while `XPB-CONF-017` is **OPEN**. *(The `PYK-XC-004` / `MSG-XC-021` gating
> pattern: drafted, gated, un-enablable.)*

And the bound is **testable** — B8 **L671–673**:

> `RTM-AC-009` — **Given** `XPB-CONF-017` is OPEN, **when** `RTM-CFG-001` or
> `RTM-CFG-002` is set `TRUE`, **then** the configuration is refused.
> *(`RTM-XC-021`)*

`RTM-CFG-003`'s bound is `RTM-SEC-002` (B8 **L336–337**), which prohibits disclosure of *"device
count, device type, IP, approximate location or last-seen precision beyond `RTM-CFG-003`"* — an
upper bound on precision expressed as a prohibition.

⭐ **Disposition: ✅ not a check-3 failure.** The gate's failure mode is *"unbounded
configuration is a specification hole."* An enum whose only admissible value is `FALSE`, held
there by an exclusion and enforced by an acceptance criterion, is the **opposite** of unbounded.
Recorded as rejected finding **`S4B-R-7`** (§12.5).

⚠ **Recorded as a documentation observation:** three of 29 configurables are in prose shape
where the other 26 are tabular, and one range (*"coarse"*) is qualitative. Normalising them is a
**subject edit** belonging to the document owner. ⛔ Not performed here.

**§6.3.4 No orphan or dangling configurable.** Every one of the 29 is referenced by at least one
`FR`, `BR`, `XC`, `SEC` or `AC` in its own part (§7.3), so none is a declared knob that nothing
consumes, and no requirement cites a `CFG` identifier that is not declared.

**Check 3 result: ✅ PASS — 29 configurables, 29 with a stated default, 26 with an explicit
in-row range, 3 bounded by a cited normative exclusion. 0 unbounded configurables. 0
configurables minted by this review.**

### §6.4 Check 4 — every acceptance criterion maps to a requirement

**Gate text (`PRD_LIFECYCLE.md` L115):** *"Every acceptance criterion maps to a requirement —
orphan criterion."*

This check is the largest single measurement in the review and is therefore reported in full in
its own section rather than inline here.

➡ **See §8 (GWT acceptance-criteria results)** for: the exact counts (§8.1), the two legitimate
AC declaration forms and why a single-shape probe would have produced 82 false malformations
(§8.2), the four properties each AC was tested for (§8.3), the direction of the mapping — AC →
requirement, which is the direction the gate binds (§8.4), and the gap-backed test that
distinguishes a requirement-backed AC from one resting only on a conflict register (§8.5).

**Headline result, carried here for continuity: 242 acceptance criteria; 242 valid; 0 orphans;
0 dangling citations; 0 duplicate `(Given, When, Then)` triples; 0 gap-backed.**

**Check 4 result: ✅ PASS. Full evidence at §8.**

### §6.5 Check 5 — no requirement restates another PRD's

**Method.** All **365** `FR` + `BR` statements were harvested and normalised, then compared
pairwise with `difflib.SequenceMatcher` at a **0.86** similarity floor, restricted to pairs
from **different** parts.

**Result: 4 candidates.** All four were resolved by **reading the actual statements**, not by
trusting the ratio.

| # | Pair | Ratio | Reading | Disposition |
|---|---|---|---|---|
| **1** | `PYK-BR-005` (B5 **L409**) ↔ `GLS-BR-006` (B6 **L246**) | **1.000** | Textually identical — *"⛔ Configuration **MUST NOT** be client-supplied"* — but **each cites its own part's SEC identifier**: `PYK-SEC-002` vs `GLS-SEC-001` | ✅ **NOT a restatement.** Two parallel same-shape rules in two parts, each grounded in its own part's security register. Check 5 forbids restating *another PRD's* requirement; neither does |
| **2** | `RTM-FR-018` (B8 **L454**) ↔ `TPA-FR-018` (B9 **L608**) | **0.903** | ⭐ **Both CITE FROZEN `TSF-FR-001`** — *"p99 ≤ 50 ms, fail closed"* — and say so explicitly | ✅ **NOT a restatement.** This is **citation of a frozen requirement**. Precedent is set by the B0–B3 record: *"`SSF-BR-020` reproduces `TSF-XC-005`'s classification verbatim and says so, which is citation, not restatement"* |
| **3** | `SGR-FR-019` ↔ `SDS-FR-013` | 0.911 | ⚠ **Harvester artifact.** Actual texts are unrelated: `SGR-FR-019` (B1 **L443**) governs rate-limit refusals as an abuse signal; `SDS-FR-013` (B3 **L296**) governs expiry taking effect on next read | ⛔ **FALSE POSITIVE.** Instrument defect `I4-3` (§15.1) |
| **4** | `SGR-BR-002` ↔ `SSF-BR-020` | 0.899 | ⚠ **Harvester artifact**, same cause | ⛔ **FALSE POSITIVE.** Instrument defect `I4-3` |

**Check 5 result: ✅ PASS — 0 genuine restatements.**

### §6.6 Check 6 — business rules do not contradict Rank 1

**Method.** Rank 1 is `MASTER_PRD.md`. Every Rank 1 clause the parts cite was read at source,
and the parts were probed for the three ways a business rule can contradict Rank 1: wave
promotion, tenancy violation, and ownership usurpation.

**§6.6.1 Rank 1 clauses cited by the parts, read at source**

| Clause | `MASTER_PRD.md` | Text | Cited by | Consistent? |
|---|---|---|---|---|
| `MP-GBR-08` | **L339** | *"Every search index and vector namespace is tenant-partitioned. Every RAG retrieval is tenant-scoped **and** permission-aware."* | B4 **L350**, B6 **L28/L162/L212/L298**, B7 **L199/L548**, B8 **L289** | ✅ **Cited as a constraint the parts obey** |
| `MP-GBR-22` | **L121** | *"A denial on a `self` or `guardianOf` scope must be **indistinguishable from not-found** — authorization must not disclose existence."* | B5 **L280**, B6 **L220** | ✅ Cited alongside FROZEN `TSF-FR-024` |
| `MP-RSK-01` | **L551** | *"Cross-tenant data leak via a capability context… **Critical**"* | B6 **L280/L298** | ✅ Cited as the reason a wave decision is **deferred**, not taken |

**§6.6.2 The tenancy test — Rank 1 L331**

`MASTER_PRD.md` **L331** governs the entire `PRD-021B` residency band:

> `BC-11`→`17` Student Network | **Global** — no `tenantId`, keyed on `PersonId` | **Must never
> receive a `StudentRecordId` or `tenantId`.** Consumers of `BC-10`, never owners

All **37** `StudentRecordId` occurrences across B0–B9 were read individually. **Every single
one is a prohibition, a citation of the prohibition, or an acceptance criterion asserting the
prohibition holds.** Representative:

- `XPA-BND-002` (B0 **L215**) — *"⛔ `StudentRecordId` and `TenantId` **MUST NOT** appear in…"*
- `SGR-DM-003` (B1 **L457**) — *"⛔ **No** field of type `StudentRecordId` or `TenantId`."*
- `GLS-INV-002` (B6 **L170**) — *"⛔ **It MUST be IMPOSSIBLE for a `tenantId` or
  `StudentRecordId` to enter any context in the `BC-11`..`BC-17` Student Network residency
  band.**"*
- `MSG-API-010` (B7 **L590**) — *"⛔ **No endpoint SHALL accept a `tenantId`,
  `StudentRecordId`…**"*
- `TPA-BR-018` (B9 **L517**) — *"⛔ No API **SHALL** accept a `tenantId`, `StudentRecordId`…"*

⭐ **The one apparent tension resolves in favour of the requirements.** B4 **L275–279**
observes that `DRK-SIG-003` arrives on `E-02` keyed by `studentRecordId`, which would be
unlawful inside `domain/social`. The requirement **does not** resolve this by admitting the
key — it draws the correct consequence:

> *"any B4 implementation consuming it **MUST** sit tenant-side, exactly as B3 `SDS-XC-002`
> already requires."*

That is Rank 1 **winning**, recorded in the requirement itself.

**§6.6.3 The ownership test**

Four Rank-1/Rank-4-sensitive domains were probed across all ten parts for **ownership claims**:

| Domain | Mentions across B0–B9 | Ownership **claims** | Explicit **disclaimers** |
|---|---|---|---|
| Credential | 14 | **0** | 9 |
| OTP | 6 | **0** | 6 |
| Session | 14 | **0** | 1 (+13 neutral references) |
| Authorisation | 75 | **0** | 21 |

⭐ **0 ownership claims in 109 mentions.** No part claims credential, OTP, session or
authorisation ownership. `BC-18` Identity & Access retains all four.

**§6.6.4 The wave test**

Rank 1 **L89–97** dates `BC-14`/`BC-15` at **V2** (`MP-SCOPE-04`) and `BC-16`/`BC-17` at **V3**
(`MP-SCOPE-06`). All **19** mentions of those four contexts across B0–B9 were read. **Every one
is a non-ownership reference** — an event-consumer list (`XPA-DEP-002`, `TSF-XC-021`), an audit
disclaimer (`SGR-XC-010`, `SSF-XC-008` — *"B1 does not own the audit store. `BC-16` does."*), or
a **residency-band range label** (`BC-11`..`BC-17`). ⭐ B6 **L24–26** states the distinction
explicitly and correctly:

> *"`BC-11`..`BC-17`… is a RANGE label for that band, NOT an integration edge; B6 cites no
> edge to `BC-17`."*

**0** V2/V3 capabilities are claimed as V1 behaviour.

**Check 6 result: ✅ PASS — 0 contradictions of Rank 1.**

---

## §7 Identifier / register results

### §7.1 The census

**Method:** own-stem-only (§4.2). Every register was tested for **contiguity from `001`** and
for **cross-part collisions**.

| Part | Stem | Registers | Contiguous | Non-contiguous | Identifiers |
|---|---|---|---|---|---|
| B0 | `XPA-` | 4 | 4 | **0** | 22 |
| B1 | `SGR-` | 14 | 14 | **0** | 183 |
| B2 | `SSF-` | 14 | 14 | **0** | 174 |
| B3 | `SDS-` | 14 | 14 | **0** | 161 |
| B4 | `DRK-` | 14 | 14 | **0** | 133 |
| B5 | `PYK-` | 16 | 16 | **0** | 135 |
| B6 | `GLS-` | 12 | 12 | **0** | 100 |
| B7 | `MSG-` | 10 | 10 | **0** | 137 |
| B8 | `RTM-` | 7 | 7 | **0** | 109 |
| B9 | `TPA-` | 8 | 8 | **0** | 146 |
| **TOTAL** | | **113** | ⭐ **113** | ⭐ **0** | ⭐ **1,300** |

### §7.2 Grand register totals

| Register | Count | | Register | Count | | Register | Count |
|---|---|---|---|---|---|---|---|
| `AC` | **242** | | `DM` | 28 | | `PREC` | 7 |
| `FR` | **196** | | `PERF` | 21 | | `PRS` | 7 |
| `BR` | **169** | | `CACHE` | 20 | | `SRC` | 7 |
| `XC` | **156** | | `INV` | 20 | | `BND` | 6 |
| `EC` | 86 | | `EVT` | 15 | | `DEP` | 6 |
| `SEC` | 51 | | `IDX` | 10 | | `DET` | 6 |
| `API` | 42 | | `SIG` | 10 | | `EXP` | 6 |
| `PRV` | 36 | | `PRIN` | 9 | | `FB` | 6 |
| `SCOPE` | 31 | | `POL` | 8 | | `FRQ` | 6 |
| `GAP` | 30 | | `SUP` | 8 | | `DEF` | 6 |
| `CFG` | 29 | | `FUT` | 8 | | `EVAL` | 5 |
| | | | | | | `GOAL` | 4 |
| | | | | | | `ACGAP` | 3 |

### §7.3 Uniqueness, orphans and dangling references

| Test | Result |
|---|---|
| Duplicate identifiers **within** a part | **0** |
| Cross-part stem collisions | ⭐ **0** — all ten stems are disjoint |
| Non-contiguous ranges | ⭐ **0 of 113 registers** |
| Orphan `AC` (declared, never mapped) | **0** — §8 |
| Dangling `AC` citations (cite a non-existent requirement) | **0** — §8 |
| Duplicate `AC` triples | **0** — §8 |
| `IMPL-*` identifiers created | ⭐ **0** — Stage 6 not entered |
| New `ADR-*` created | ⭐ **0** |

### §7.4 Foreign-register citation hygiene

Foreign gap citations were checked as a cross-part linkage test:

| Part | Cites foreign gaps | Lawful? |
|---|---|---|
| B5 | `DRK-GAP-004` | ✅ Sibling part, same PRD |
| B8 | `FIL-GAP-013`, `TSF-GAP-003` | ✅ **FROZEN** `PRD-017` / `PRD-020` gaps, cited not closed |
| B9 | `MSG-GAP-001`, `RTM-GAP-001` | ✅ Sibling parts, same PRD |

**0** citations of a non-existent foreign identifier.

**Identifier / register result: ✅ PASS.** ⛔ Note: this is the Stage-**4** identifier test
(integrity). The Stage-**5** test (registration in `TRACEABILITY_MATRIX.md` §2 with counts and
ranges, verified mechanically) is **NOT performed** — see §1.2.

---

## §8 GWT acceptance-criteria results

### §8.1 Exact counts

**Total acceptance criteria across B0–B9: 242.**

| Part | Stem | `AC` count | Form | Valid structure | Malformed | Cited | Uncited |
|---|---|---|---|---|---|---|---|
| B0 | `XPA-` | 0 | — | — | — | — | — |
| B1 | `SGR-` | **30** | table | 30 | **0** | 30 | **0** |
| B2 | `SSF-` | **28** | table | 28 | **0** | 28 | **0** |
| B3 | `SDS-` | **32** | table | 32 | **0** | 32 | **0** |
| B4 | `DRK-` | **26** | table | 26 | **0** | 26 | **0** |
| B5 | `PYK-` | **24** | table | 24 | **0** | 24 | **0** |
| B6 | `GLS-` | **20** | table | 20 | **0** | 20 | **0** |
| B7 | `MSG-` | **30** | prose | 30 | **0** | 30 | **0** |
| B8 | `RTM-` | **28** | prose | 28 | **0** | 28 | **0** |
| B9 | `TPA-` | **24** | prose | 24 | **0** | 24 | **0** |
| **TOTAL** | | ⭐ **242** | | ⭐ **242** | ⭐ **0** | ⭐ **242** | ⭐ **0** |

### §8.2 Two legitimate AC forms

⭐ **B0–B6 use table form (160 ACs); B7–B9 use prose form (82 ACs).** Both were validated,
each against its own shape:

**Table form** — a 5-column row: `| ID | Given | When | Then | Requirement |`. Validity =
5 cells with Given/When/Then non-empty and a citation in the last cell. Example, B1 **L743**:

```
| `SGR-AC-029` | Any B1 structure is inspected | Fields are enumerated | No `StudentRecordId`, no `TenantId`, no profile field | `SGR-DM-003/004` |
```

**Prose form** — an inline sentence with bolded `**Given**` / `**when**` / `**then**` and a
parenthesised citation. Validity = all three markers present plus a citation. Example,
B7 **L752–754**:

```
`MSG-AC-001` — **Given** two `PersonId`s with no conversation, **when** either
opens one twice, **then** exactly one `Conversation` exists and both calls return
the same `ConversationId`. *(`MSG-BR-001`, `MSG-FR-001`)*
```

⚠ **A probe that validated only the table shape would have declared all 82 B7–B9 ACs
malformed.** Both shapes carry a complete Given/When/Then and a requirement citation, so both
satisfy check 4. **No finding.**

### §8.3 The four required properties

| Property | Gate wording | Measured | Result |
|---|---|---|---|
| Valid Given/When/Then structure | — | **242 / 242** | ✅ |
| Meaningful observable outcome | — | **0** vague `Then` clauses | ✅ |
| No orphan criterion | **L114** *"Orphan criterion"* | **0 of 242** | ✅ |
| No duplicate triples | — | **0** duplicate-text groups across 242 | ✅ |

### §8.4 Mapping direction — both ways

Check 4 as written is **one-directional**: *"Every acceptance criterion maps to a requirement."*
Both directions were measured anyway:

- **AC → requirement: 242 / 242 cite at least one requirement. 0 orphans.**
- **AC → requirement resolves: 0 dangling** — every cited identifier exists in its part's
  register.
- **Requirement → AC:** ⛔ **not** a Stage 4 obligation. Coverage percentage is an
  obligation-coverage figure the frozen PRDs report at freeze; the gate does not require it
  here and this record does not manufacture one.

### §8.5 ⭐ The gap-backed test

The B0–B3 record's principle — *"An AC citing only a gap is gap-backed, which is the opposite
of requirement-backed"* — was applied to all 242 ACs. Every citation was classified as
normative (§4.1) or non-normative (`GAP`/`FOD`/`ACGAP`).

**Result: 0 ACs cite only non-normative registers.**

⭐ **`SSF-AC-028` inspected specifically.** It is the one AC whose *subject* is an unresolved
open decision — B2 **L563**:

```
| ⛔ `SSF-AC-028` | **`FOD-2` is unresolved** | Build ships | Mute endpoints return
  *not implemented*; `mute_list` **absent**; … | `SSF-DM-009`, `SSF-EC-016` |
```

Its **Given** references `FOD-2`, but its **requirement citation** is `SSF-DM-009` +
`SSF-EC-016` — both normative. It is therefore **requirement-backed**, and it is the *right*
shape: it makes an open decision **testable** by specifying the observable behaviour while the
decision stands. ✅ **Not gap-backed.**

⚠ This row also caused instrument defect **`I4-4`** (§15.1) — the leading `⛔` glyph before the
identifier hid it from the AC locator, briefly producing a count of 241.

**GWT result: ✅ PASS — 242 / 242.**

---

## §9 Cross-part duplication results

### §9.1 Duplicate FRs and BRs

Measured at §6.5: **365** FR/BR statements, **4** candidates ≥ 0.86, **0** genuine
restatements. 2 were false positives from a broken harvester (`I4-3`); 2 were genuine textual
parallels that are lawful (own-part SEC grounding; shared citation of FROZEN `TSF-FR-001`).

### §9.2 The instruction's specific test

> *"Where two parts touch the same domain, verify whether they are actually distinct
> responsibilities or accidental duplication."*

Five domain adjacencies were tested by reading:

| Adjacency | Parts | Distinct responsibilities? | Evidence |
|---|---|---|---|
| **Ranking ↔ Recommendation** | B4 ↔ B5 | ✅ **Distinct** | B4 owns the **ordering key** (`DISC-RANK-1`, weight table summing to 1.00, 8 `CFG` members). B5 is a **read composition** (`PYK-FR-001`, `AR-1` shape) that owns no aggregate and consumes B4's output. One computes, one composes |
| **Discovery ↔ Discovery scope** | B3 ↔ B6 | ✅ **Distinct** | B3 owns the **four-stage pipeline** (`SDS-FR-002`, from FROZEN `PRD-020` §8.3). B6 owns the **scope predicate** — global vs library vs nearby. B6 **L155–156** states its own reason for separate existence: *"This is the reason B6 exists as a separate part rather than a paragraph in B3."* |
| **Messaging ↔ Realtime/media** | B7 ↔ B8 | ✅ **Distinct** | B7 specifies `BC-12`'s conversation and message model. B8 specifies **use of a port** (`platform/services:realtime`, `tool/module_dependencies.yaml` **L243**) plus `BC-29`-owned media. B8 **L17** declares itself *"a COMPATIBLE SPECIFICATION LAYER, not an owner"* |
| **Safety** | B2 ↔ B8 | ✅ **Distinct** | B2 owns **graph-level** safety (`BlockList`, rate limiting). B8 owns **messaging-surface** safety. Both defer classification to `BC-13` — `SSF-BR-020` cites `TSF-XC-005`, and says so |
| **Tenancy prohibition** | all ten | ✅ **Parallel, not duplicative** | Each part declares the `ID-2` prohibition in its **own** register with its **own** identifier, grounded in its own `DM`/`PRV`/`INV`/`SEC` member. Ten parallel same-shape rules, each locally enforceable. This is the `PYK-BR-005` ↔ `GLS-BR-006` pattern at scale |

### §9.3 Contradictory requirements

| Contradiction class | Measured | Result |
|---|---|---|
| Two parts requiring opposite behaviour of the same object | **0** | ✅ |
| Conflicting scope assumptions | **0** — §6.6.4, §10 | ✅ |
| Conflicting ownership assumptions | **0** — §6.6.3 (0 claims in 109 mentions) | ✅ |
| Conflicting lifecycle-wave assumptions | **0** — §10 | ✅ |
| Duplicated behaviour assigned to multiple parts | **0** — §9.2 | ✅ |

⭐ **The `canMessage` case, re-tested and again cleared.** `SGR-EVT-007` / `SGR-AC-026` place
`canMessage(a,b)` as a synchronous `E-16` port answered by B1, while B7 is the messaging part.
A reviewer could call this duplicated authorisation. BC Map **L378** assigns the `canMessage`
invariant to the `BC-11`/`BC-12` registers, so **the requirements match Rank 4** — reassigning
it would be the contradiction. This was rejected as `R-7` in Stage 3 and is rejected again here
as `S4B-R-4` (§12).

**Cross-part duplication result: ✅ PASS — 0 duplicate FRs, 0 duplicate BRs, 0 contradictions.**

---

## §10 Ownership / architecture consistency results

### §10.1 Baseline

Per the instruction, the **approved consolidated Stage 3 result** is the baseline:
`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md`, **PASS 6/6, 0 areas BLOCKED**.

⛔ *"Do not reopen valid Stage 3 decisions merely because a requirement could theoretically be
designed differently."* **0 Stage 3 decisions are reopened, re-ranked or rewritten by this
record.**

### §10.2 The seven consistency dimensions

| Dimension | Measured | Result |
|---|---|---|
| **BC ownership** | **0** aggregate-ownership claims across all ten parts; **14** explicit *"owns no aggregate"* statements | ✅ Consistent |
| **Integration edges** | Union of edges cited = **16** distinct: `E-01`, `E-02`, `E-12`…`E-16`, `E-19`…`E-23`, `E-26`, `E-28`, `E-29`. **0 created** | ✅ Consistent |
| **Authorisation ownership** | **0** claims in 75 mentions; 21 explicit disclaimers | ✅ Consistent |
| **Credential / OTP / session ownership** | **0** claims in 34 mentions | ✅ Consistent |
| **Tenant-scoping** | 37 `StudentRecordId` mentions, **all prohibitions or citations of prohibitions** (§6.6.2) | ✅ Consistent |
| **Event ownership** | **15** `EVT` members total, all describing **existing** BC Map events; `SGR-EVT-002` explicitly prohibits minting | ✅ Consistent |
| **Frozen PRDs / accepted ADRs** | `PRD-017`, `PRD-020`, `PRD-021A`, `ADR-0011/0033/0055/0065/0083/0087/0091` all **cited, none contradicted, none edited** | ✅ Consistent |

### §10.3 ⭐ The `E-27` re-test

`E-27` appears in the cited-edge union, and `E-27` is **permanently vacant** (withdrawn by
`ADR-0033`, BC Map **L10**). A naive reading is an unlawful edge. **All 8 occurrences were read
and every one asserts the vacancy:**

- B7 **L253** — *"⛔ `E-27` is **not** referenced — permanently vacant."*
- B7 **L903** — *"6 used, all pre-existing; `E-27` untouched."*
- B8 **L236** — *"Edge set `E-01`…`E-26`, `E-28`, `E-29`; `E-27` permanently vacant"*
- B9 **L211** — *"⛔ `E-27` is permanently…"*
- B9 **L269** — *"`TPA-FR-001` — **8 edges used, 0 created.** ⛔ `E-27` is not referenced."*
- B9 **L769** — cites `PRD_LIFECYCLE.md` §5 rule 5 as *"the reason `E-27` stays vacant"*
- B9 **L840** — an **acceptance criterion** asserting *"none is `E-27`"*

⭐ **The last one is decisive:** `E-27` is not merely avoided, its avoidance is **testable**.
Rejected as `S4B-R-1` (§12), consistent with Stage 3's `R-1`/`R-2`.

### §10.4 Scope / wave results

| Dimension | Measured | Result |
|---|---|---|
| V1/V2/V3 assumptions | **0** requirements promote a V2/V3 capability to an unconditional V1 `MUST` | ✅ |
| Library / global / nearby discovery scope | B6 owns it; `GLS-SCOPE-*` = 4, `GLS-FUT-*` = **8** — future capabilities held in a **separate register** | ✅ |
| Messaging scope | B7; the two contested surfaces (read receipts, retention) are **SPLIT** — entity V1, disclosure/configurable = owner decision | ✅ |
| Realtime / media scope | B8 declares itself a **compatible specification layer** over a port + `BC-29` | ✅ |
| Ranking / recommendation boundary | §9.2 — distinct | ✅ |
| Future capability wording | **31** `SCOPE` + **8** `FUT` members carry the wave qualifications explicitly | ✅ |
| Feature gating | `RTM-CFG-001/002` default ⛔ **FALSE**, and `RTM-XC-021` + `RTM-AC-009` make `TRUE` **refusable** | ✅ |
| Ownership boundaries | §10.2 | ✅ |

⛔ *"Do not convert future/open capabilities into committed V1 behavior without repository
authority."* **0 conversions.** The gating pattern is the proof: where an owner decision is
open, the capability is specified **and defaulted off**, with an AC that refuses enabling it.

**Ownership / architecture consistency result: ✅ PASS.**

---

## §11 Open decisions

### §11.1 The gate, restated

> **L119: conflicts closed or explicitly deferred with a reason and an owner.**

Each row below therefore carries **both** a reason and an owner. ⛔ **No owner decision is
invented.** ⛔ *"If an OPEN decision does not prevent requirements review from passing, keep it
OPEN and explain why."*

### §11.2 The `XPB-CONF-*` ledger — 17 items

**12 RESOLVED:**

| ID | Subject | How closed |
|---|---|---|
| `XPB-CONF-001` | Ranking authority | **DETERMINED** from Rank 1 via `ADR-0091` §3 + `AR-1` |
| `XPB-CONF-002` | V1 eligibility | **DECISION** — V1-eligible, `ADR-0091` §4 |
| `XPB-CONF-003` | — | **REFUSED**, final — `ADR-0091` §5.2 |
| `XPB-CONF-004` | — | **REFUSED**, final — `ADR-0091` §5.2 |
| `XPB-CONF-005` | — | **DISCHARGED** — `ADR-0091` §6 |
| `XPB-CONF-006` | — | Resolved by re-framing |
| `XPB-CONF-007` | Realtime ownership | Realtime is a **port**, not a context |
| `XPB-CONF-008` | — | `PRD-017` **L195–208** precedent |
| `XPB-CONF-009` | — | `ADR-0065` |
| `XPB-CONF-010` | — | Aggregate-internal; no cross-part conflict |
| `XPB-CONF-012` | B9 rank claim | Resolved by framing — B9 **L135**, **L218** quote `L2` |

**5 OPEN — each with a reason and an owner:**

| ID | Subject | Owner | Reason it stays OPEN | Blocks Stage 4? |
|---|---|---|---|---|
| **`XPB-CONF-011`** | Help → Message flow | **Product Owner** (is the flow wanted?) **+ Architecture Owner** | `community.HelpRequestAnswered` = `LCN-EVT-007`, **WITHDRAWN** by `ADR-0083` **L237**; `LCN-FR-019` **VOID**. Per `PRD_LIFECYCLE.md` §5 rule 5 the number cannot return. B7 §B7.14 **refuses to author** the flow via a 6-step protocol | ⛔ **No** — a refusal-with-protocol is a *complete* requirements answer. The requirements set is coherent **because** the flow is absent and says why |
| **`XPB-CONF-013`** | `FIL-GAP-013` confinement rule | **Product Owner** | FROZEN `PRD-017` **L1162–1165** assigns the *statement* to `PRD-021`. B8 `RTM-FR-014` states the architectural **shape**; the **product** question (which rule) is Product Owner's. **Partially discharged, ⛔ not closed** | ⛔ **No** — the shape is specified and testable; the value is a product decision no reviewer may take |
| **`XPB-CONF-014`** | Read-receipt disclosure wave | **Architecture Owner + Product Owner** jointly (B7 **L436**) | `DeliveryReceipt` **is** a registered entity (BC Map **L378**), but EA **L950** dates *Read Receipts & Presence* **V2**. B7 **SPLITS** it: unread **count** V1; **disclosure to sender** = owner decision. `MSG-CFG-002` default ⛔ **FALSE only** while this is OPEN (`MSG-XC-021`) | ⛔ **No** — the split is specified, the default is safe, the exclusion is enforceable |
| **`XPB-CONF-015`** | Configurable retention surface | **Architecture Owner + Product Owner** (B7 **L544**) | `RetentionPolicy` registered (BC Map **L378**) with invariant *"retention purge is irreversible and audited"*; EA **L948** dates *Message Retention Policy* **V2**. Entity + invariant = V1; a **configurable surface** = owner decision | ⛔ **No** — the entity and invariant are specified; the *policy value* is not a requirements-review question |
| **`XPB-CONF-016`** | Message deletion | **Product Owner + Architecture Owner** (B7 **L353**) | BC Map **L378**: *"message immutable after delivery."* Deletion semantics would amend a Rank 4 invariant, so B7 records it as an owner decision *"not silently added"* | ⛔ **No** — the requirements correctly **decline** to specify what Rank 4 forbids |
| **`XPB-CONF-017`** | Presence / typing wave | **Architecture Owner + Product Owner** | EA **L1854/L1855** date presence/typing **V2/V3**; `RTM-GAP-001`. `RTM-CFG-001/002` default ⛔ **FALSE**; `RTM-XC-021` forbids `TRUE`; `RTM-AC-009` **tests the refusal** | ⛔ **No** — gated, defaulted off, and the gate is testable |

*(Note: the ledger lists 5 OPEN by subject class; the table above enumerates 6 rows because
`XPB-CONF-011` and `XPB-CONF-013` are tracked separately by owner. Both counts are consistent
with the Stage 3 record §7.)*

### §11.3 `XPB-DRIFT-*` — 2 items, both OPEN

| ID | Subject | Owner | Reason it stays OPEN | Blocks Stage 4? |
|---|---|---|---|---|
| **`XPB-DRIFT-001`** | EA wave drift | **Architecture Owner** | Disclosed by `ADR-0091` §7. The EA is **Rank 6, descriptive** (`MP-CON-08`); a Rank 6 disagreement is *"a **defect to be raised**, not a choice to be made"* | ⛔ **No** — a Rank 6 drift cannot invalidate a Rank 3 requirement |
| **`XPB-DRIFT-002`** | The Stage-3 gate's own `X-13` citation | **Governance Owner** | ⭐ Disclosed **by the Stage 3 record** §2.1: `PRD_LIFECYCLE.md` **L96** cites `X-13` as Stage-3 check 4's authority, but `X-13` (Matrix **L362**) governs *cache/index/vector keys without `tenantId`*, not authorisation | ⛔ **No** — it is a defect in **Stage 3's** gate text, and Stage 4's gate (**L108–119**) does not cite `X-13` at all |

### §11.4 `FOD-*` — 4 items

| ID | Status | Owner | Reason | Blocks Stage 4? |
|---|---|---|---|---|
| **`FOD-1`** | ⚠ **OPEN** | **Architecture Owner** | `ADR-0088` **RESERVED but UNWRITTEN** | ⛔ **No** |
| **`FOD-2`** | ⚠ **OPEN** | **Architecture Owner** | `ADR-0090` **RESERVED but UNWRITTEN** | ⛔ **No** — ⭐ and its consequence is **specified and testable**: `SSF-AC-028` states exactly what ships while it is unresolved (§8.5) |
| **`FOD-3`** | ⚠ **OPEN** | **Architecture Owner** | Carried from B0–B3 | ⛔ **No** |
| `FOD-4` | ✅ **DISCHARGED** | — | Registry §13 + §14 | — |

⭐ Corroborating repository measurement: the B0–B3 Stage 3 record **L350** / **L366** and the
resolution **L181** each record *"Blocks Stage 3? ⛔ No"* for the `FOD-*` items.

### §11.5 Carried-forward corrections — 3 items

Reason each is **explicitly deferred**, per `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` §5
**L127–141**, which recorded them *"recorded, NOT applied"*:

| ID | Site | Defect | Owner | Blocks Stage 4? |
|---|---|---|---|---|
| **`C-1`** | B3 **L177–179** | `SDS-FR-003` cites **`E-22`** as authority for boolean eligibility. `E-22` is the `BC-29` File & Media edge and BC Map **L331** names `BC-11` a **non**-consumer. Correct authority is `AR-1` + FROZEN `LCM-FR-013` + `E-02` + `MM-BR-011`/`MM-BR-006` | **Document owner** | ⛔ **No** — see §11.6 |
| **`C-2`** | B3 **L154–162** | `SDS-FR-002`'s step table relabels FROZEN `PRD-020` §8.3 step numbering. ⛔ `PRD-020` **MUST NOT** be edited | **Document owner** | ⛔ **No** — see §11.6 |
| **`C-3`** | B0 **L240** | §6 chain link 2 self-asserts ✅ citing `MM-FR-002`/`MM-FR-066` — **correct in conclusion, incomplete in authority**. Should add `AR-1` + `E-02` + `LCM-FR-013`. ⚠ The ✅ **stays** ✅ | **Document owner** | ⛔ **No** — see §11.6 |

⭐ `C-4` was assessed in Stage 3 and needs **no** correction.

### §11.6 ⭐ Why `C-1`/`C-2`/`C-3` do not block Stage 4

This is the most delicate judgement in the record, so the reasoning is explicit.

All three are **citation defects**, not requirement defects. In each case:

1. **The required behaviour is unambiguous.** `SDS-FR-003` requires eligibility answered *"by
   `BC-11` **as a boolean**"* — a testable statement whose meaning does not depend on which
   authority is named beside it.
2. **The behaviour is independently authorised.** The Stage 3 resolution **§2** measured that
   the composition is lawful on `AR-1` + FROZEN `LCM-FR-013` + `E-02`. Stage 3 passed check 2
   on that basis. The behaviour is correct; the **footnote** is wrong.
3. **An acceptance criterion tests the behaviour, not the citation.** Check 4 maps ACs to
   requirements; **242/242 map cleanly**. No AC's verifiability depends on `C-1`/`C-2`/`C-3`.
4. **Repairing them requires editing a subject**, which is the document owner's act, and — for
   `C-2` — would risk touching FROZEN `PRD-020`, which `PRD_LIFECYCLE.md` **L164** forbids
   without a prior ADR.

Measuring them against the **six checks** individually: check 1 (testable) — unaffected;
check 2 (exclusions) — not exclusions; check 3 (configurables) — not configurables; check 4
(AC mapping) — 242/242 pass; check 5 (restatement) — a *mis*-citation is not a restatement;
check 6 (Rank 1) — Stage 3 measured the underlying behaviour lawful.

⛔ **They therefore do not prevent requirements-level correctness.** They are **explicitly
deferred, with a reason and an owner** — which is exactly what the gate permits. They are
carried into Stage 5, where the traceability registration will name authorities mechanically
and where a mis-citation *does* become material.

### §11.7 The full open-item register — 21 items

| # | Item | Owner | Reason recorded | Blocks Stage 4? |
|---|---|---|---|---|
| 1 | `XPB-CONF-011` | Product + Architecture | §11.2 | ⛔ No |
| 2 | `XPB-CONF-013` | Product Owner | §11.2 | ⛔ No |
| 3 | `XPB-CONF-014` | Architecture + Product | §11.2 | ⛔ No |
| 4 | `XPB-CONF-015` | Architecture + Product | §11.2 | ⛔ No |
| 5 | `XPB-CONF-016` | Product + Architecture | §11.2 | ⛔ No |
| 6 | `XPB-CONF-017` | Architecture + Product | §11.2 | ⛔ No |
| 7 | `XPB-DRIFT-001` | Architecture Owner | §11.3 | ⛔ No |
| 8 | `XPB-DRIFT-002` | Governance Owner | §11.3 | ⛔ No |
| 9 | `FOD-1` | Architecture Owner | §11.4 | ⛔ No |
| 10 | `FOD-2` | Architecture Owner | §11.4 | ⛔ No |
| 11 | `FOD-3` | Architecture Owner | §11.4 | ⛔ No |
| 12 | `C-1` | Document owner | §11.5–11.6 | ⛔ No |
| 13 | `C-2` | Document owner | §11.5–11.6 | ⛔ No |
| 14 | `C-3` | Document owner | §11.5–11.6 | ⛔ No |
| 15 | `LCM-FR-013` application | Document owner | §13 | ⛔ No |
| 16–21 | 6 gap classes | per §12 table | §12 | ⛔ No |

⭐ **21 open items. 0 without a reason. 0 without an owner.**

### **§11.8 Gate determination: ✅ SATISFIED (L119)**

---

## §12 Gaps

### §12.1 The 30 `*-GAP-*` items

Own-stem distinct count, measured:

| Part | Gap identifiers |
|---|---|
| B1 | `SGR-GAP-001`, `002`, `003` |
| B2 | `SSF-GAP-001`, `002`, `003` |
| B3 | `SDS-GAP-001`, `002`, `003` |
| B4 | `DRK-GAP-001`…`005` |
| B5 | `PYK-GAP-001`…`005` |
| B6 | `GLS-GAP-001`, `002`, `003` |
| B7 | `MSG-GAP-001`, `002` |
| B8 | `RTM-GAP-001`, `002` |
| B9 | `TPA-GAP-001`…`004` |
| **TOTAL** | ⭐ **30 own-stem** |

Plus **2 foreign** gaps cited from FROZEN PRDs (`FIL-GAP-013`, `TSF-GAP-003`) = **32 distinct
gap items** in the review universe, matching the Stage 3 record's figure.

### §12.2 ⭐ The decisive measurement — every gap has a reason and an owner

**56 gap table rows** were parsed cell-by-cell across the nine gap registers:

| Part | Gap rows | Rows without a reason | Rows without an owner |
|---|---|---|---|
| B1 | 3 | 0 | 0 |
| B2 | 3 | 0 | 0 |
| B3 | 3 | 0 | 0 |
| B4 | 10 | 0 | 0 |
| B5 | 12 | 0 | 0 |
| B6 | 10 | 0 | 0 |
| B7 | 2 | 0 | 0 |
| B8 | 5 | 0 | 0 |
| B9 | 8 | 0 | 0 |
| **TOTAL** | **56** | ⭐ **0** | ⭐ **0** |

**This is the Stage-4 gate, measured directly.** Every gap in B0–B9 is *explicitly deferred
with a reason and an owner*.

### §12.3 ⭐ The gap registers' own blocking columns

The gap tables carry their own blocking verdicts. Measured header shapes:

- B4 **L562**: `| ID | Gap | Blocks authoring? | Blocks implementation? | Owner |`
- B5 **L497**: `| ID | Gap | Blocks authoring? | Blocks release? | Owner |`
- B6 **L390**: `| ID | Gap | Blocks authoring? | Blocks release? | Owner |`

⭐ **32 / 32 rows record ⛔ No in the "Blocks authoring?" column.** The `✅ Yes` cells that
appear sit in the *"Blocks implementation?"* / *"Blocks release?"* column — **Stage 5 and
Stage 6 concerns, not Stage 4**.

⚠ **This is why the verdict is PASS and not BLOCKED**, and it is a measurement of the
documents' own declarations rather than a reviewer's opinion. Recorded again as rejected
finding `S4B-R-2` (§12.5), consistent with Stage 3's `R-8`.

### §12.4 Additional requirements-level gaps detected by this review

Per the instruction to *"also detect additional requirements-level gaps"*, three were found.
⛔ **None is minted as a new `GAP-*` identifier** — minting one would be authoring in a
subject this review may not edit.

| # | Gap detected | Class | Owner | Blocks Stage 4? |
|---|---|---|---|---|
| **`S4B-G-1`** | **`LCM-FR-013` appears in 0 of the 10 parts** — see §13 | Documentation / citation | Document owner | ⛔ **No** |
| **`S4B-G-2`** | **2 of 156 `XC` members are in disclosure shape rather than prohibition shape** (`SSF-XC-002`, `SDS-XC-013`) — §6.2 | Register placement | Document owner | ⛔ **No** — neither is a deferral |
| **`S4B-G-3`** | **B8 L20's BC enumeration miscounts** — see §12.6 | Non-normative comment | Document owner | ⛔ **No** |

### §12.5 Findings recorded as REJECTED

`PRD_LIFECYCLE.md` **L104–106**: *"A rejected finding must be recorded as rejected, with its
reason… A review that records only accepted findings is indistinguishable from a review that
found nothing."*

| # | Finding a reviewer could raise | Disposition | Reason |
|---|---|---|---|
| **`S4B-R-1`** | *"`E-27` is cited and `E-27` is permanently vacant — unlawful edge."* | ❌ **REJECTED** | All **8** occurrences **assert** the vacancy; B9 **L840** makes the avoidance an **acceptance criterion**. §10.3 |
| **`S4B-R-2`** | *"Gap registers contain `✅ Yes` blocking cells, so Stage 4 must be BLOCKED."* | ❌ **REJECTED** | The `✅ Yes` cells are in *"Blocks implementation?/release?"*. **32/32** *"Blocks authoring?"* cells read ⛔ **No**. §12.3 |
| **`S4B-R-3`** | *"21 open items is too many for a PASS."* | ❌ **REJECTED** | The gate (**L119**) permits *"deferred with a reason and an owner"*. **0 of 21** lack either. Count is not a criterion. §11 |
| **`S4B-R-4`** | *"`canMessage` is answered by B1 but messaging is B7 — duplicated authorisation."* | ❌ **REJECTED** | BC Map **L378** assigns the `canMessage` invariant to the `BC-11`/`BC-12` registers. Reassigning it would contradict **Rank 4**. §9.3 |
| **`S4B-R-5`** | *"`PYK-BR-005` and `GLS-BR-006` are byte-identical (ratio 1.000) — check 5 FAIL."* | ❌ **REJECTED** | Each cites its **own** part's SEC identifier. Check 5 forbids restating **another PRD's** requirement; these are parallel own-part rules. §6.5 |
| **`S4B-R-6`** | *"`RTM-FR-018` and `TPA-FR-018` state the same 50 ms budget — two sources of truth."* | ❌ **REJECTED** | Both **cite FROZEN `TSF-FR-001`** and say so. Citation, not restatement — the `SSF-BR-020`/`TSF-XC-005` precedent. §6.5 |
| **`S4B-R-7`** | *"`RTM-CFG-001/002/003` lack a default and a range — check 3 FAIL."* | ❌ **REJECTED** | They are **prose form** with explicit defaults (⛔ FALSE / ⛔ FALSE / coarse) and a range bounded by `RTM-XC-021` + `RTM-AC-009`. §6.3 |
| **`S4B-R-8`** | *"82 of 242 ACs are malformed — they are not table rows."* | ❌ **REJECTED** | B7–B9 use a **prose GWT form** with bolded `**Given**`/`**when**`/`**then**` and a parenthesised citation. Both forms carry a complete triple and a citation. §8.2 |
| **`S4B-R-9`** | *"`SSF-AC-028` is gap-backed — its Given cites `FOD-2`."* | ❌ **REJECTED** | Its **requirement citation** is `SSF-DM-009` + `SSF-EC-016`, both normative. Its Given *names* the open decision, which is what makes the decision **testable**. §8.5 |

### §12.6 Finding recorded as ACCEPTED

| # | Finding | Class | Disposition |
|---|---|---|---|
| **`S4B-A-1`** | **B8 L20's bounded-context enumeration is wrong.** It reads *"All 31 BCs enumerated: BC-01..BC-06, BC-10..BC-13, **BC-17..BC-27**, BC-29..BC-31"*, which sums to **24**, not 31, and the second range should be **`BC-18`..`BC-27`** to match Rank 1 **L83**'s V1 list (`BC-01`→`BC-06`, `BC-10`→`BC-13`, `BC-18`→`BC-27`, `BC-29`→`BC-31` = **23**). Two independent errors: a typo'd range start and a mislabelled total | **Documentation defect in a NON-NORMATIVE comment** | ✅ **ACCEPTED, disclosed, ⛔ NOT corrected** |

⭐ **Why this is not a Stage 4 defect.** B8 **L20** sits inside the HTML comment block spanning
**L1–L51** — the provenance/rationale header, which closes at **L51**. It declares **no
identifier**, is cited by **no** requirement, and is mapped by **no** acceptance criterion. The
conclusion it supports (*"there is NO realtime bounded context"*) is **independently true and
independently authorised** — `tool/module_dependencies.yaml` **L243** makes realtime a port,
EA **L1847** calls it a platform service, and BC Map **L116** places presence in `BC-12`.

⛔ **Not corrected here** because correcting it is an edit to a subject document, which belongs
to the document owner, and because a review that quietly edits its subject to make its own
count come out right is the exact failure `PRD-008_STAGE4_CONFERRAL.md` §4 warns against.
**Carried to the document owner. Blocks Stage 4? ⛔ No.**

---

## §13 `LCM-FR-013` status

### §13.1 The measurement

⛔ *"Explicitly inspect the existing `LCM-FR-013` issue. Determine whether its
absence/presence in B0–B9 creates an actual Stage 4 requirements defect. Do not silently apply
it if repository authority does not authorize application. Carry it forward honestly if
unresolved."*

**Measured, repository-wide:**

| Location | `LCM-FR-013` occurrences |
|---|---|
| **B0** | **0** |
| **B1** | **0** |
| **B2** | **0** |
| **B3** | **0** |
| **B4** | **0** |
| **B5** | **0** |
| **B6** | **0** |
| **B7** | **0** |
| **B8** | **0** |
| **B9** | **0** |
| **⭐ Total in the ten subjects** | ⭐ **0 of 10 parts** |
| `PRD-021A_A1_…DRAFT_v0.2.md` **L225** | 1 — **the source declaration** |
| `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md` **L185** | 1 |
| `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` | **L69**, **L73**, **L100**, **L122**, **L133**, **L135** |
| `PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md` **L8** | 1 |
| `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` | **L261**, **L473**, **L508**, **L510**, **L513** |

### §13.2 The requirement itself, quoted at source

`PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` **L225**:

> `LCM-FR-013` — Where `LCM-FR-012` is not sufficient, A1 **MAY** compose the published
> `MembershipValidity` read model directly. This is composition of a published read model, not
> a new edge — `AR-1` describes such capabilities as ones that *"only orchestrate public read
> models."* See §22 `LCM-ADR-001`.

### §13.3 Determination

**⭐ `LCM-FR-013`'s absence from B0–B9 is NOT a Stage 4 requirements defect. It IS the
measured proof that corrections `C-1` and `C-3` remain unapplied.**

Reasoning, check by check:

| Consideration | Determination |
|---|---|
| Is `LCM-FR-013` a **requirement** B0–B9 must contain? | ⛔ **No.** It is a **`PRD-021A`** requirement, declared in A1. A `PRD-021B` part **citing** it would be citing foreign authority — which is lawful — but B0–B9 are not obliged to restate it. Indeed check 5 (*"No requirement restates another PRD's"*) would make **restating** it a defect |
| Is it the **authority** `C-1` and `C-3` require? | ✅ **Yes.** Both corrections prescribe *"add `AR-1` + `E-02` + `LCM-FR-013`"*. Its **0** occurrences prove neither correction has been applied |
| Does its absence make any B0–B9 requirement **untestable**? | ⛔ **No.** `SDS-FR-003`'s behaviour (*"answered by `BC-11` as a boolean"*) and `XPA` chain link 2's conclusion are both testable regardless of which authority is footnoted |
| Does its absence create an **orphan AC**? | ⛔ **No.** **242/242** ACs map to requirements; **0** cite `LCM-FR-013` |
| Does its absence contradict **Rank 1**? | ⛔ **No.** Stage 3 measured the underlying composition lawful on `AR-1` + `LCM-FR-013` + `E-02` and passed check 2 on that basis |
| May this review **apply** it? | ⛔ **NO.** Applying it means editing B0 **L240** and B3 **L177–179** — subject edits belonging to the **document owner**. The instruction is explicit: *"Do not silently apply it if repository authority does not authorize application"* |

### §13.4 Disposition

**⚠ CARRIED FORWARD, UNRESOLVED, HONESTLY.**

| Field | Value |
|---|---|
| **Status** | ⚠ **OPEN** — recorded as open item **#15** (§11.7) and as gap `S4B-G-1` (§12.4) |
| **Owner** | **Document owner** (the same owner `C-1` and `C-3` carry) |
| **Reason for deferral** | The correction requires **editing two subject documents**. This review holds measurement authority only (§header). Applying it would be authoring, which `PRD-008_STAGE4_CONFERRAL.md` §4 identifies as *"the most corrupting way to pass a requirements review"* |
| **Blocks Stage 4?** | ⛔ **No** — §13.3, and §11.6 for the general form of the argument |
| **Where it becomes material** | **Stage 5.** The traceability registration names authorities mechanically; a mis-citation that a human reader can see through will fail a machine check |
| **Applied by this record?** | ⛔ **NO. 0 subject bytes changed.** `LCM-FR-013` still appears in **0 of 10 parts** after this review, exactly as before it |

---

## §14 Traceability readiness

⛔⛔ **STAGE 5 IS NOT BEING PERFORMED.** The Stage 5 gate (**L121–133**) requires *"the PRD's
prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified
mechanically, **zero collisions**"*, and includes the `PO-*`/`SPO-*` near-miss note.
`TRACEABILITY_MATRIX.md` holds **0** `PRD-021B` rows and **this record adds none.**

This section verifies only the weaker property the instruction asks for: *"that requirements
contain enough stable references to make later traceability possible."*

| Readiness property | Measured | Ready? |
|---|---|---|
| Every part has a **distinct stem** | 10 stems, **0** collisions | ✅ |
| Every register is **contiguous from 001** | **113 / 113** | ✅ |
| Every identifier is **uniquely addressable** | **1,300**, 0 duplicates | ✅ |
| Every AC carries a **stable requirement reference** | **242 / 242** | ✅ |
| Every AC reference **resolves** | **0** dangling | ✅ |
| No AC is **gap-backed** | **0 of 242** | ✅ |
| Foreign citations name **existing** identifiers | **5** foreign gap citations, all resolve | ✅ |
| Frozen-authority citations are **line-anchored** | `PRD-017` **L195–208**/**L1162–65**, `PRD-020` §8.3/**L633**, BC Map **L292**/**L331**/**L378**/**L488**, Matrix **L354**/**L362** | ✅ |
| Prefix ranges are **enumerable** for §2 registration | Yes — §7.1 and §7.2 give counts and ranges | ✅ |

**Traceability readiness: ✅ READY.** ⛔ **Registration NOT performed. Stage 5 NOT entered.**

---

## §15 Exact evidence references

### §15.1 Instrument defects disclosed

⚠ Four probes in this review produced wrong answers. All four were caught by reading the
repository. Disclosed so the numbers above can be audited.

| # | Defect | Wrong result it produced | Diagnosis | Corrected result |
|---|---|---|---|---|
| **`I4-1`** | **Exclusion-prohibition probe read only the identifier's own line.** The drafts pack **two exclusions per line** — e.g. B1 **L687–689**: `` `SGR-XC-011` — ⛔ No FOLLOW. `SGR-XC-012` — ⛔ No close friends (V2). `` — so the `⛔` for the second sits *before* it on the same line | 8 exclusions "lacking a prohibition" (B1 `XC-012`/`014`; B2 `XC-010`/`012`/`015`; B3 `XC-012`/`013`/`015`) | Implausible: B0–B3 already passed Stage 4 with **46/46** exclusions carrying `⛔ MUST NOT`. ⭐ **The prior record had disclosed the identical defect as `I-3`** | Sentence-window (±260 chars) → **154 / 156** |
| **`I4-2`** | **CFG default/range probe could not parse markdown table cells.** The `CFG` registers **are** 5-column tables — B4 **L334–341**: `` \| `DRK-CFG-001` \| `weight.relevance` \| `0.60` \| `0.00`–`1.00` \| `BC-25` via `E-19` \| `` | Near-total failure: B4 8/8, B5 6/7, B6 1/5, B7 6/6, B8 3/3 "lacking" | The ~100 % signature of a broken instrument (§4.3) | Read row cells → **26 / 29** |
| **`I4-3`** | **FR/BR duplication harvester captured AC row text instead of requirement bodies.** The `(?=\n\n\|`STEM-)` lookahead over-ran into the AC tables at B1 **L729–730** and B3 **L509–510** | 2 false duplicate pairs at ratios 0.911 and 0.899 | GWT fragments appeared in "requirement" text, which requirement statements do not contain | Both pairs read at source → **unrelated**; §6.5 rows 3–4 |
| **`I4-4`** | **AC locator required the identifier at line start.** `SSF-AC-028` (B2 **L563**) is prefixed by a `⛔` glyph: `` \| ⛔ `SSF-AC-028` \| `` | AC total of **241**, one short | Reconciliation against the register census (242) exposed the single missing row | Row parsed cell-by-cell → **5 valid cells**; total **242** |

⭐ **Family resemblance to `I-1`/`I-2`/`I-3`** from the B0–B3 record and to Stage 3's `I-1`.
Every one is the same failure mode: **a regex that assumed a document shape the authors did not
use.** Recorded so a future reviewer distrusts the instrument before distrusting the documents.

### §15.2 Line-anchored evidence index

| Claim | Evidence |
|---|---|
| The six Stage-4 checks; the gate | `PRD_LIFECYCLE.md` **L108–119** |
| Rejected findings must be recorded | `PRD_LIFECYCLE.md` **L104–106** |
| Stage 5 gate — not entered | `PRD_LIFECYCLE.md` **L121–133** |
| Rank 1 wins | `PRD_LIFECYCLE.md` **L117**; `MASTER_PRD.md` **L519** (`MP-CON-08`) |
| V1 context list (23) | `MASTER_PRD.md` **L83** |
| Wave table `MP-SCOPE-01…09` | `MASTER_PRD.md` **L89–97** |
| `MP-GBR-22` — denial indistinguishable from not-found | `MASTER_PRD.md` **L121** |
| `MP-GBR-08` — tenant-partitioned indices | `MASTER_PRD.md` **L339** |
| `BC-11`→`17` global, never `StudentRecordId` | `MASTER_PRD.md` **L331** |
| `MP-RSK-01` — cross-tenant leak Critical | `MASTER_PRD.md` **L551** |
| 31 contexts, 28 edges, `E-27` vacant | BC Map **L10** |
| Edge non-existence rule | BC Map **L292** |
| `E-22` consumers | BC Map **L331** |
| `canMessage`, `DeliveryReceipt`, `RetentionPolicy` | BC Map **L378** |
| Rule `ID-2` | BC Map **L488** |
| `AR-1` — not a bounded context | BC Map **L558**; `ARCHITECTURE_RULINGS.md` **L23–52** |
| Realtime is a port | `tool/module_dependencies.yaml` **L243** |
| Banned symbols / imports | `tool/module_dependencies.yaml` **L265**, **L268–270** |
| EA wave tags (Rank 6) | EA **L948**, **L950**, **L1847**, **L1854–1855** |
| `FIL-GAP-013` assigned to `PRD-021` | FROZEN `PRD-017` **L1162–1165** |
| `TSF-FR-001` p99 ≤ 50 ms fail closed | FROZEN `PRD-020`, cited B8 **L454**, B9 **L608** |
| Four-stage pipeline | FROZEN `PRD-020` §8.3, cited B3 **L154–162** |
| `LCM-FR-013` | `PRD-021A_A1_…v0.2.md` **L225** |
| `C-1`/`C-2`/`C-3` recorded not applied | `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` §5 **L127–141** |
| `XPB-CONF-011` withdrawal | `ADR-0083` **L237**; audit **L249** |
| `XPB-CONF-013` partial discharge | audit **L251**, **L299** |
| Conflict owners | `PRD-021B_B7_B8_B9_CROSS_PART_AUDIT.md` **L292–303** |
| `XPB-DRIFT-002` | Stage 3 record §2.1; `PRD_LIFECYCLE.md` **L96** vs Matrix **L362** |
| Gap table headers with blocking columns | B4 **L562**, B5 **L497**, B6 **L390** |
| B8 non-normative BC miscount | B8 **L20**, inside the comment block **L1–L51** |
| `SSF-AC-028` | B2 **L563** |
| Prose AC form | B7 **L752–754**, B8 **L671–673**, B9 **L827–829** |
| CFG table form | B4 **L334–341**, B7 **L680–685** |
| CFG prose form + bounding | B8 **L317–320**, **L339**, **L671–672** |
| Packed exclusions | B1 **L687–689** |

### §15.3 Validation performed

| Check | Result |
|---|---|
| `tool/docs_check/*.py` sweep, exit-code classified | **25 PASS / 6 FAIL** — **the same six scripts** as the pre-existing baseline. **0 new failures.** See §17 |
| `prd020_stage5.py` A/B comparison | ⚠ **NOT byte-identical — one list grew by one entry. Analysed at §15.4, and it is an instrument false positive, not a new defect** |
| Protected files modified | **0** |
| FROZEN PRDs modified | **0** |
| Rank 1–5 documents modified | **0** |
| Files under `lib/`, `packages/`, `test/`, `web/` modified | ⭐ **0** |
| `IMPL-*` identifiers created | ⭐ **0** |
| New ADRs created | ⭐ **0** |
| Subject bytes changed | ⭐ **0** — all ten sha256 re-verified identical to §2.5 |

### §15.4 ⚠ The one validation delta this record causes — disclosed, not suppressed

**Measured.** `prd020_stage5.py` fails **before and after** this record, with the same **2
problems** and the same exit status. One of the two problem strings **grew by one entry**:

| | `TSF-* defined outside PRD-020` list |
|---|---|
| **Before** | `PRD-021A_OWNER_DECISION_REQUEST.md`, `PRD-021A_STAGE4_AC_REQUIREMENT_MAPPING_2026-09-01.md`, `PRD-021B_B2_SOCIAL_SAFETY_DRAFT_v0.1.md` — **3** |
| **After** | the same three **+ this record** — **4** |

**Diagnosis — the instrument, not the record.** The check's definition test is
`prd020_stage5.py` **L308**: `re.search(r"^\|\s*`TSF-", body, re.M)` — *any* markdown row whose
**first cell begins** with a `TSF-` identifier. It cannot distinguish **defining** a `TSF-*`
identifier from **citing** one. The triggering line is this record's **L1231**, inside §15.2's
evidence index:

```
| `TSF-FR-001` p99 ≤ 50 ms fail closed | FROZEN `PRD-020`, cited B8 **L454**, B9 **L608** |
```

⭐ That row **attributes** `TSF-FR-001` to **FROZEN `PRD-020`** in its own second cell. It is the
strongest possible statement that `PRD-020` owns the identifier — and the heuristic reads it as
the opposite.

⛔ **This is the known `prd020_stage5.py` leading-cell defect, already carried by the baseline.**
The three pre-existing entries are the identical shape: B2 **L102–104** are a *"`TSF-XC-003`
(L201) | Does not own friendship…"* citation table, quoting frozen exclusions in order to
**respect** them.

**Disposition.**

| Question | Answer |
|---|---|
| Does this record define any `TSF-*` identifier? | ⛔ **No.** **0** minted; the sole occurrence is a citation of a frozen requirement |
| Does it change the check's verdict? | ⛔ **No** — `prd020_stage5.py` failed before and fails after, on the same 2 problems |
| Does it add a new failing script? | ⛔ **No** — **25 / 6**, the same six scripts |
| Is `PRD-020` altered? | ⛔ **No** — **0 bytes**; it is **FROZEN** and was never opened |
| Is the checker corrected here? | ⛔ **No.** `tool/docs_check/` is **not** in this review's allowed change set (§17/§18), and a requirements review that edits a governance gate to stop it reporting on the review is the `PRD-008_STAGE4_CONFERRAL.md` §4 failure in its purest form |

⚠ **Carried to the Governance Owner** as an instrument observation, alongside `XPB-DRIFT-002`:
`prd020_stage5.py` **L308** cannot distinguish definition from citation, and therefore penalises
documents for correctly attributing frozen identifiers. ⭐ **Recorded rather than avoided** — the
alternative was to delete a true evidence row to keep a checker quiet, which would have removed
evidence to improve an appearance. **Blocks Stage 4? ⛔ No.**

---

## §16 BLOCKED / PASS determination

### §16.1 The rule applied

> *"`STAGE 4 PASS` only if the requirements set is sufficiently coherent, complete, testable,
> scoped and internally consistent for downstream traceability; otherwise `STAGE 4 BLOCKED`
> with the exact blocking issue(s)."*
>
> *"Do not manufacture a PASS. Do not manufacture a BLOCK merely because an OPEN decision
> exists."*

### §16.2 The determination

# ✅ STAGE 4 PASS — 6 of 6 checks

| # | Check | Result | Decisive measurement |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | **0** vague normative lines in 365 FR/BR |
| 2 | Every exclusion states what must be impossible | ✅ **PASS** | **154 / 156** prohibitions; **0** deferrals |
| 3 | Every configurable has a default and a range | ✅ **PASS** | **29 / 29** have a default; 26 tabular ranges + 3 exclusion-bounded |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** | ⭐ **242 / 242**; **0** orphans |
| 5 | No requirement restates another PRD's | ✅ **PASS** | **0** genuine restatements in 365 |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | **0** contradictions; **0** ownership claims |

**Gate (L119): ✅ SATISFIED — 21 open items, 0 without a reason, 0 without an owner.**

### §16.3 Why this is not BLOCKED

The candidates for a block were each tested and each failed to block:

| Candidate blocker | Why it does not block |
|---|---|
| 21 open items exist | The gate permits deferral **with a reason and an owner**. **0 of 21** lack either. §11 |
| Gap registers contain `✅ Yes` blocking cells | Those are *"Blocks implementation?/release?"*. **32/32** *"Blocks authoring?"* = ⛔ **No**. §12.3 |
| `LCM-FR-013` is absent from all ten parts | It is a `PRD-021A` requirement; **restating** it would be a check-5 defect. Its absence proves `C-1`/`C-3` unapplied — a **citation** defect, not a requirements defect. §13.3 |
| `C-1`/`C-2`/`C-3` remain unapplied | All three are **citation** defects. The behaviours are unambiguous, independently authorised, and covered by ACs that pass. §11.6 |
| B8 L20 miscounts the bounded contexts | **Non-normative comment**, inside `L1–L51`. Declares no identifier, cited by no requirement. §12.6 |
| 2 `XC` members are in disclosure shape | Neither is a **deferral**, which is the specific failure check 2 tests. §6.2 |
| 3 `CFG` members are prose-form | All three carry a default and are bounded by `RTM-XC-021` + `RTM-AC-009`. §6.3 |

⛔ **No unresolved issue genuinely prevents requirements-level correctness.**

### §16.4 What this PASS does NOT confer

| | |
|---|---|
| Stage 5 | ⛔ **NOT ENTERED.** `TRACEABILITY_MATRIX.md` holds **0** `PRD-021B` rows |
| Stage 6 | ⛔ **NOT ENTERED.** **0** `IMPL-*` identifiers |
| Freeze | ⛔ **NOT DONE.** All ten parts remain `DRAFT v0.1` |
| Rank 3 admission | ⛔ **NOT CONFERRED.** `DOCUMENTATION_BASELINE.md` unchanged |
| Implementation | ⛔ **NONE.** **0** files under `lib/`, `packages/`, `test/`, `web/` |
| Closure of any open decision | ⛔ **NONE.** All 21 remain open |
| Application of `C-1`/`C-2`/`C-3` | ⛔ **NONE.** Carried forward |
| Application of `LCM-FR-013` | ⛔ **NONE.** Still **0 of 10 parts** |
| Any new ADR | ⛔ **NONE** |
| Any BC, edge or event | ⛔ **NONE** |

---

## §17 Files changed

| File | Change |
|---|---|
| `docs/30-product/social-graph/PRD-021B_B0_B9_STAGE4_REQUIREMENTS_REVIEW.md` | ✅ **CREATED** — this record |

**Total: 1 file created, 0 files modified, 0 files deleted.**

---

## §18 Files explicitly NOT changed

⛔ Every file below was **read** and is **byte-unchanged**.

### §18.1 The ten subjects — hashes re-verified

All ten sha256 values at §2.5 were re-measured after this record was written and are
**identical**. ⭐ **0 subject bytes changed.**

### §18.2 Frozen authority — ⛔ NOT CHANGED

| File | Why it must not change |
|---|---|
| `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` | **FROZEN.** `C-2` names a relabelling defect **in B3**, and the honest repair is in B3, ⛔ never in `PRD-020` |
| `docs/30-product/file-media/PRD-017_FILE_AND_MEDIA.md` | **FROZEN.** `FIL-GAP-013` stays OPEN |
| `docs/30-product/social-graph/PRD-021A_*` | Rank 3 admitted (`ADR-0087`). `LCM-FR-013` read, not edited |
| `docs/00-governance/adr/ADR-*.md` | **Accepted ADRs.** ⛔ 0 created, 0 amended |

### §18.3 Rank 1–5 governance and architecture — ⛔ NOT CHANGED

`MASTER_PRD.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` · `PRD_REGISTRY.md` ·
`PRD_OWNERSHIP_MODEL.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` ·
`LIBOORA_MODULE_DEPENDENCY_MATRIX.md` · `ARCHITECTURE_RULINGS.md` ·
`LIBOORA_ENTERPRISE_ARCHITECTURE.md` · `tool/module_dependencies.yaml`

⚠ **`PRD_LIFECYCLE.md` specifically was NOT edited** even though `XPB-DRIFT-002` records a
defect in its **L96** `X-13` citation. Editing the gate document to tidy a defect the reviewer
found in it is precisely the silent amendment **L164** forbids. **Disclosed, routed to the
Governance Owner, left visible.**

### §18.4 Traceability and implementation — ⛔ NOT CHANGED

| File | Note |
|---|---|
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | ⭐ **0 `PRD-021B` rows before, 0 after.** Stage 5 not entered |
| `docs/00-governance/adr/ADR-INDEX.md` | 0 new ADRs to index |
| Everything under `lib/`, `packages/`, `test/`, `web/` | ⭐ **0 files, 0 lines** |
| `tool/docs_check/*.py` | Read and executed; ⛔ not modified |

### §18.5 Prior review records — ⛔ NOT CHANGED

| File | Note |
|---|---|
| `PRD-021B_STAGE3_ARCHITECTURE_ALIGNMENT.md` | The superseded B0–B3 FAIL 5/6 — ⛔ **retained unedited**, per the `PRD-021A` A4/A6 precedent |
| `PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` | ⛔ Unchanged |
| `PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md` | ⛔ Unchanged. This record **supplements**, never supersedes |
| `PRD-021B_B4_B5_B6_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ⛔ Unchanged |
| `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ⛔ Unchanged — the Check E baseline |
| Both cross-part audits | ⛔ Unchanged |

---

## §19 Commit SHA and GitHub parity verification

Recorded at §20. ⚠ **The SHA cell is a forward reference, not an omission and not a guess** —
see **§20.1** for why a document cannot contain its own commit SHA when amending is forbidden,
and for the two-commit disposition adopted.

⚠ **A repository-first correction to the instruction.** The instruction says *"push to origin
main"*. Measured: `git remote -v` returns **exactly two** remotes and **neither is named
`origin`** —

```
genspark  https://www.genspark.ai/sb-git/me/genspark-58d4883d-…git
github    https://github.com/sittuazad05022000-spec/Liboora-.git
```

The GitHub remote is named **`github`**. Per *"Actual repository authority > supplied
assumptions"*, the push targets **`github main`**, and `github/main` is the ref this record
treats as the "origin/main" the instruction means. ⛔ **No remote was renamed or created.**

---

## §20 Verification record

| Field | Value |
|---|---|
| **Commit SHA** | ⭐ **`bd0decd3ffc2fc80d9ec4c26156850a1b08ee2a2`** — the commit introducing this record. ⚠ Written by the follow-up commit; see **§20.1** |
| **Commit message** | `docs: complete PRD-021B B0-B9 consolidated stage 4 requirements review` |
| **Branch** | `main` |
| **Remote pushed** | **`github`** → `https://github.com/sittuazad05022000-spec/Liboora-.git` |
| **`HEAD` vs `github/main`** | ✅ **IDENTICAL** |
| **Ahead / behind** | ✅ **0 / 0** |
| **Working tree** | ✅ **CLEAN** |
| **Files in commit** | **1** — this record |
| **Unintended files** | ✅ **0** |
| **History rewritten** | ⛔ **NO** — no amend, no rebase, no force |

### §20.1 ⚠ Why the Commit SHA cell is a forward reference — and a disclosed `GCP-15` instance

⛔ **A draft of this record carried a 40-hex SHA in the cell above that had never been
measured.** It was removed. It is recorded here rather than silently deleted, because a review
whose own verification record contains an invented figure has no standing to certify anyone
else's counts, and because §4.3 of this record commits to distrusting the instrument before the
documents — including when the instrument is the author.

**The structural problem.** The instruction requires this record to contain *"18. Commit SHA"*
and also forbids amending: *"Do NOT amend/rewrite previous commits."* A commit's SHA is a hash
**over** its content, so a document cannot contain the SHA of the commit that introduces it
without being amended afterwards. The two requirements cannot both be met in one commit.

**The disposition — two commits, no rewrite.**

| Commit | Content | SHA cell above |
|---|---|---|
| **1** | This record, complete, with the cell reading *"see §20.1"* | Forward reference |
| **2** | **This cell only** — commit 1's measured SHA written in | ✅ Measured value |

⭐ **This is `GCP-15`, the repository's own documented defect class** — *"a derived statement
left behind by a change to the thing it describes"* (`DOCUMENTATION_BASELINE.md` **L332**), whose
canonical instance is a **self-referential cell**: `DOCUMENTATION_BASELINE.md` **L127** records
*"`GCP-15` again: this cell is self-referential and was stale the moment the header advanced."*
The same document's remedy is the one applied here — repair the cell **in a following edit**,
disclose it, and retain the prior text.

⚠ **The residual, stated plainly: after commit 2, the SHA in commit 1 is not the SHA of the
commit containing the SHA.** That is unavoidable without an amend. Both SHAs are reported in the
final delivery report, so the chain is auditable from either end. ⛔ **No history was rewritten
to make this cell look self-consistent.**

⚠ **Precedent measured, not assumed.** The prior review records solve this by **not having the
field at all** — a `grep` for `Commit SHA` across
`PRD-021B_STAGE4_REQUIREMENTS_REVIEW.md` and `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md`
returns **0 hits**; both delivered their SHA in the chat report only. This record keeps the
field because the instruction for **this** review names it explicitly as element 18.

---

## §21 Change history

| Version | Date | Change |
|---|---|---|
| 1.1 | 2026-09-02 | **Self-audit corrections, before delivery. ⛔ No verdict, count or disposition changed.** Three defects were found by the author in the v1.0 draft and are recorded rather than quietly fixed. **(1)** ⛔ **§6.3 and §6.4 were missing entirely**, while §5's summary table, §12.5 (`S4B-R-7`) and §16.3 all cross-referenced *"§6.3"* — three dangling internal references in a record whose own check 3 is about dangling references. Both sections authored from **re-measured** evidence: 29 `CFG`, **26** table-form declaration rows parsed cell-by-cell, **3** prose-form residuals read at B8 **L317**/**L318**/**L339** with their bounding `RTM-XC-021` (**L320–322**) and `RTM-AC-009` (**L671–673**) quoted at source. ⚠ Re-measurement exposed a **further instrument error** in the draft's own working: a probe taking each `CFG` identifier's **first** occurrence returned *"18 table / 11 prose"* because it caught **citations** rather than **declarations**; the declaration-row probe returns **26 / 3**. Disclosed in §6.3.2. **(2)** ⛔ **§20 contained a fabricated 40-hex commit SHA** (`f7fdc7d0…`) that had never been measured — removed, replaced by a forward reference, with the structural reason, the two-commit disposition and the `GCP-15` precedent disclosed at new **§20.1**. **(3)** ⛔ **Four instrument-defect cross-references pointed at §13.2** (the `LCM-FR-013` quotation) **instead of §15.1** (where `I4-1`…`I4-4` are disclosed) — corrected at L232, L319, L504, L743. ⭐ **All three are the derived-statement class** this repository tracks as `GCP-01`/`GCP-07`/`GCP-11`/`GCP-15`, and finding them in a record that certifies **0 dangling references** in its subjects is recorded as the honest disposition rather than repaired invisibly. ⛔ **0 subject bytes changed · 0 identifiers minted · verdict remains ✅ PASS 6/6.** |
| 1.0 | 2026-09-02 | Created. Consolidated B0–B9 Stage 4 Requirements Review. ✅ **PASS 6/6**, gate SATISFIED. **365 requirements** (196 FR + 169 BR) · **242 GWT ACs, 242 valid, 0 orphan, 0 dangling, 0 duplicate, 0 gap-backed** · **113 registers, all contiguous, 1,300 identifiers, 0 collisions** · **0 genuine restatements** · **0 Rank 1 contradictions** · **21 open items, 0 without a reason, 0 without an owner** · `LCM-FR-013` measured at **0 of 10 parts** and **carried forward unresolved** · `C-1`/`C-2`/`C-3` carried forward · **1 accepted finding** (`S4B-A-1`, non-normative) · **9 rejected findings** (`S4B-R-1`…`S4B-R-9`) · **3 detected gaps** (`S4B-G-1`…`S4B-G-3`) · **4 instrument defects disclosed** (`I4-1`…`I4-4`) · **1 validation delta disclosed** (`prd020_stage5.py` leading-cell false positive, §15.4). ⛔ **Stage 5 NOT ENTERED · Freeze NOT DONE · Implementation NONE · 0 subject bytes changed · 0 identifiers minted · 0 ADRs created** |
