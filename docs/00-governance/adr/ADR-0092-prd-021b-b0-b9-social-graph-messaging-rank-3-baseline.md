# ADR-0092 — `PRD-021B` Social Graph, Discovery & Messaging (Parts B0–B9) is admitted to `DOCUMENTATION_BASELINE.md` at **Rank 3** for `BC-11` and `BC-12`, and Stage 7 is **CONFERRED** on the gate as written

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-02 |
| **Date** | 2026-09-02 |
| **Deciders** | **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 **L281**) — exercised by **direct, explicit conferral of the human principal of this engagement, scoped to this act**, recorded in full at [`PRD-021B_B0_B9_STAGE7_CONFERRAL_2026-09-02.md`](../../30-product/social-graph/PRD-021B_B0_B9_STAGE7_CONFERRAL_2026-09-02.md). The role is constituted **VACANT** by `Accepted` `ADR-0080` §2.2 rule 2 (**L85**), and `PRD_OWNERSHIP_MODEL.md` §7 rule 4 forbids recording a personal name; the repository's settled mechanism for that condition is direct conferral for one act, as exercised by `ADR-0064`, `ADR-0083`, `ADR-0086`, `ADR-0087` and `ADR-0091`. ⛔ **No standing appointment is created** — `ADR-0033` **L169**. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted.** |
| **Subject** | `PRD-021B` Social Graph, Safety, Discovery, Ranking, Recommendations, Scope, Messaging, Realtime/Media and Production Architecture, **Parts B0–B9**, at **v0.1**, in `docs/30-product/social-graph/` — **6,603 lines** |
| **Amends** | **No ranked document's content.** Admits one ten-part subject to **Rank 3** and records the admission in `DOCUMENTATION_BASELINE.md` §3.1/§3.3/§4/§6/§8 and `ADR-INDEX.md`. Corrects one stale derived cell in the unranked `PRD_REGISTRY.md` §14 (**`GCP-15`**, §7) |
| **Baseline** | Re-issued as **`BASELINE-2026-09-02-A`**, superseding `BASELINE-2026-09-01-B` — §7 rule 4, a **Rank 1–3** document entering. Pre-change sha256 `ee87aff31d3d4b88…` |
| **Closes** | ✅ the Stage 7 **gate** for `PRD-021B` B0–B9 · ✅ **`GCP-15`** — the stale `PRD_REGISTRY.md` §14 *"Stage 3 NOT entered"* cell (§7) · ✅ the single blocker of `PRD-021B_B0_B9_STAGE7_BLOCKER.md` v1.0 (the absent conferral) |
| **Does NOT close** | ⛔ the **17** open `XPB-CONF-*` items (§6) · ⛔ **`FOD-1`, `FOD-2`** — ARB items; `ADR-0088` and `ADR-0090` remain **reserved and unwritten** · ⛔ **`FOD-3`** · ⛔ `PYK-GAP-002`, `PYK-GAP-003`, `GLS-GAP-002` — left open by `ADR-0091` and **not reopened here** · ⛔ the **32** carried `*-GAP-*` items · ⛔ the un-written `tool/docs_check/prd021b_task_coverage.py` (§6) · ⛔ **`PGA-08`** · ⛔ **`GCP-20`** — §4's *"fourteen module baselines"* prose, a **pre-existing** defect deliberately not folded into this commit (§5.1) · ⛔ **and it does NOT enter Stage 8, create any `IMPL-*`, or authorise any code** |
| **Subject hashes** | **byte-unchanged by this ADR.** B0 `69dae44e5c8f99fa` 392 L · B1 `503c804504f2d04e` 772 L · B2 `7339862f8cf9fc11` 588 L · B3 `a3ccec3de060144e` 564 L · B4 `429ed76f94042e89` 600 L · B5 `2c8f1c3dba8840c1` 532 L · B6 `1c481c6ae7557568` 425 L · B7 `01e2a7fad860abe2` 939 L · B8 `a075ba341baa9003` 809 L · B9 `21561f8b53af7602` 982 L |
| **Precedence** | **Rank 2** as an accepted ADR. It confers Rank 3 on its subject; it does not itself hold Rank 3 |
| **Related** | [`ADR-0087`](./ADR-0087-prd-021a-library-community-a1-a8-rank-3-baseline.md) — **the precedent this ADR follows in form and method** (`PRD-021A` A1–A8 at Rank 3 for `BC-15`) · [`ADR-0086`](./ADR-0086-prd-020-trust-and-safety-v0.1-rank-3-baseline.md) (`PRD-020` at Rank 3 for `BC-13`) · [`ADR-0064`](./ADR-0064-prd-012a-security-automation-v0.8-baseline.md) (the baselining template) · [`ADR-0091`](./ADR-0091-prd-021b-b4-b5-b6-owner-decisions.md) (**this subject's** B4/B5/B6 owner decisions — **not reopened**) · `ADR-0080` §2.2 (the role, constituted vacant) · `ADR-0033` **L169** (one act is not a licence) · `ADR-0011` (`BC-11`/`BC-12` rank 7.5 cluster) |

> ✅ **ACCEPTED 2026-09-02.**
>
> ⭐ **`PRD-021B` B0–B9 is the SIXTEENTH Rank 3 module baseline**, and the **second** admitted
> for the Global Student social cluster after `PRD-021A`. It governs **`BC-11` Social Graph**
> and **`BC-12` Messaging** — two contexts measured **unowned at Rank 3** before this act, so
> §4's *"they do not overlap"* clause survives **on merit rather than by assertion**.
>
> ⛔ **Nothing in `PRD-021B` was changed to make this gate pass.** All ten parts are
> byte-identical to the bytes the Stage 3, 4, 5 and 6 verdicts were anchored to. That is not a
> courtesy; it is the only thing that keeps those four verdicts valid.

---

## 1. Context — the single thing that was missing, and nothing else

On 2026-09-02 the Stage 7 gate for this subject was measured and returned **BLOCKED**
([`PRD-021B_B0_B9_STAGE7_BLOCKER.md`](../../30-product/social-graph/PRD-021B_B0_B9_STAGE7_BLOCKER.md)).
⭐ **The blocker was not a defect in `PRD-021B`.** It was named precisely:

| # | Finding of the blocker record | Status now |
|---|---|---|
| 1 | `PRD_LIFECYCLE.md` **L159** requires *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"*; `PRD-021B` occurred **0** times in the whole baseline | ✅ **Written by this ADR** — §4 |
| 2 | Stage 7 belongs to the **Governance owner** (**L281**), an office constituted **VACANT** | ✅ **Conferred for this act only** — see `Deciders` |
| 3 | Freeze is *"conferred, not claimed"* (**L161**), so the turn could not self-authorise | ✅ **Conferred by the principal**, not by the executor |
| 4 | Stages 3, 4, 5, 6 all **PASS** and were expressly *not* the reason for the stop | ✅ **Unchanged. Not reopened.** §3 |

**The block was governance, not quality.** With the conferral supplied, exactly one thing
changes — the baseline row — and everything the blocker record verified as sound stays as it
was.

---

## 2. ⭐ The rank is DERIVED, not chosen

The conferral supplied authority; it expressly withheld the rank: *"Assign the appropriate
baseline precedence rank using **actual repository authority and existing rank precedents**.
Do not invent an unsupported rank."* So the rank is measured against the three properties
every existing Rank 3 row has.

| Test | Authority | `PRD-021B` | Verdict |
|---|---|---|---|
| Is it a **module** baseline, not a platform-wide rule? | §4 Rank 1 holds `MASTER_PRD.md` global rules; Rank 3 holds *"module baselines"* | ⭐ Governs **two bounded contexts**; states no `MP-*` global rule | ✅ **Rank 3** |
| Does it govern a **bounded context**? | Fifteen of fifteen existing Rank 3 rows name a context or platform scope | **`BC-11`** Social Graph, **`BC-12`** Messaging — both exist in the BC Map at **L115**/**L116** | ✅ |
| Does it **not overlap** an existing Rank 3 row? | §4: *"Rank 3 … they do not overlap"* — the clause that governs admission | ⭐ **Measured, not assumed** — §2.1 | ✅ |
| Is it Rank 4 instead (a boundary document)? | Rank 4 is *"Bounded Context Map · Module Dependency Matrix"* | ⛔ Not a boundary document; it is a product specification | ⛔ Not Rank 4 |
| Is it Rank 5/6/7? | Rank 5 = architecture rulings · Rank 6 = **descriptive** EA · Rank 7 = configuration values | ⛔ None applies | ⛔ |

**Rank 3 is the only rank the repository's own definitions permit.** The two nearest
precedents are exact in form: `ADR-0086` admitted `PRD-020` at Rank 3 for `BC-13`, and
`ADR-0087` admitted `PRD-021A` at Rank 3 for `BC-15` — the same cluster, the same product
family, one month apart.

### 2.1 The non-overlap clause, measured rather than asserted

⭐ This is the one test that could have **stopped** the admission, so it was run mechanically
over §4's Rank 3 rows before the row was written.

```
Rank-3 rows in DOCUMENTATION_BASELINE.md §4      → 15
Rows claiming ownership of BC-11                 → 0
Rows claiming ownership of BC-12                 → 0
BC-11 / BC-12 mentions inside Rank-3 rows        → 2, and BOTH are consumer references:
   · the ADR-count cell (ADR-0001…ADR-0087 enumeration) — not an ownership claim
   · the PRD-017 File & Media row — "BC-12 Messaging IS an E-22 consumer as of
     BC Map v1.8" (ADR-0055). A consumer of an edge is not an owner of a context.
```

**`BC-11` and `BC-12` are unowned at Rank 3.** `PRD_REGISTRY.md` §4.2 **L321** already records
`PRD-021` as their intended owner (`PRD-021B` is its lettered suffix), and the BC Map assigns
both to the **Global Student** subdomain — the same subdomain as `BC-15`, which `PRD-021A`
owns without conflict.

⚠ **Had either context been owned at Rank 3, this ADR would have stopped.** Resolving a Rank 3
overlap is an Architecture Owner question, and the conferral did not reach it.

### 2.2 The boundary most likely to be misread as an overlap — and it is not one

Following the discipline every prior Rank 3 admission observes, the sharpest adjacent boundary
is stated rather than left for a reader to trip over.

**`BC-12` Messaging (this admission) and `BC-13` Trust & Safety (FROZEN `PRD-020`) are the
boundary most likely to be misread as an overlap, and it is not one.** `PRD-021B` B7 owns
*whether a message is delivered* and B8 owns *realtime transport and media handling*, while
**`PRD-020` alone owns the report, the moderation case, the enforcement action and the
effective restriction**. B7 **L190** attributes `MessageRequest`'s **rules** to frozen
`PRD-020` §10.2 (`TSF-FR-032`…`035`) and its **counter** to `BC-11`'s `RateLimitCounter` per
`TSF-BR-011` — it does not restate them, and it may not decide them. The Stage 3 record
verified this in both directions (its check 4 and check 5, both PASS).

Second boundary: **`BC-11` and `BC-12` against each other.** B1 specifies `BC-11`, B7
specifies `BC-12`, and both sit in the same rank-7.5 cluster. Measured: **B1 disclaims
`BC-12`'s four entities at L578, and B7 attributes them to `BC-12` at L189** — the two parts
agree from opposite directions. `E-16` (BC Map **L320**) fixes the direction:
*"`canMessage(a, b)` — Messaging must ask; block enforcement lives in the graph."*

---

## 3. The four upstream gates — re-verified at HEAD, not carried on trust

⛔ **None of these is reopened, and none is re-decided.** They are re-verified as still valid
against the bytes this ADR admits, because a gate anchored to superseded bytes is the defect
`PRD-017`'s alignment supplement exists to record.

| Stage | Record | Verdict | Anchored to |
|---|---|---|---|
| **3** — Architecture | `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` | ✅ **PASS 6/6** | The ten hashes above — **unchanged** |
| **4** — Requirements | `PRD-021B_B0_B9_STAGE4_REQUIREMENTS_REVIEW.md` | ✅ **PASS 6/6**; *"21 open items, 0 without a reason, 0 without an owner"* | Same — **unchanged** |
| **5** — Traceability | `PRD-021B_B0_B9_STAGE5_TRACEABILITY.md` + `TRACEABILITY_MATRIX.md` **§2Q** v1.22 | ⭐ **PASS 4/4** | Same — **unchanged** |
| **6** — Implementation tasks | `PRD-021B_B0_B9_STAGE6_IMPLEMENTATION_TASKS.md` + `PRD-021B_IMPLEMENTATION_TASKS.md` | ✅ **PASS** — `IMPL-1600`…`1689`, 90 tasks, 90/90 traced, 106 edges acyclic | Task doc `f7a2d4d4…f16f3d` |

⭐ **Stage 6's range is not extended and no task is added.** The instruction's rule 10 — *"Do
not enter any implementation stage beyond the existing Stage 6 tasks"* — is observed: this ADR
creates **0** `IMPL-*` identifiers and the reserve `IMPL-1690`…`1749` stays empty.

---

## 4. The decision

1. ⭐ **`PRD-021B` Parts B0–B9 v0.1 are ADMITTED to `DOCUMENTATION_BASELINE.md` at Rank 3**,
   governing **`BC-11` Social Graph** and **`BC-12` Messaging**, tenant-scoped throughout.
2. ⭐ **Stage 7 is CONFERRED** on the gate as written — `PRD_LIFECYCLE.md` **L159**. The row
   required by that line is written by this ADR, in the same commit, per §7 rule 3.
3. ⭐ **The baseline identifier advances to `BASELINE-2026-09-02-A`**, superseding
   `BASELINE-2026-09-01-B` — §7 rule 4, a Rank 1–3 document entering.
4. ⛔ **The ten subject documents are not edited.** Their versions stay at **v0.1** and their
   bytes stay as hashed. §7 rule 2 governs *the changed document*, and the changed document
   here is `DOCUMENTATION_BASELINE.md`, whose identifier advances in the same commit.
5. ⛔ **No standing Governance Owner appointment is created**, and no personal name is recorded.
6. ⭐ **The stale `PRD_REGISTRY.md` §14 cell is corrected** — §7, the `GCP-15` repair the
   blocker record routed to this office.
7. ⛔ **No open item is closed by implication.** The 17 `XPB-CONF-*`, `FOD-1`…`3` and the 32
   carried gaps are admitted **OPEN** — §6.

### 4.1 Why the subjects keep saying `NOT FROZEN`, and why that is correct

The ten parts contain **39** declarations reading `NOT FROZEN` / `NOT BASELINED`. They are
**not edited**, on `PRD_LIFECYCLE.md` **L161** — *"Freeze is **conferred, not claimed**"* —
which cuts both ways: a PRD can no more be *edited into* freeze than declare itself frozen.
**The baseline row is the operative status**, and after this ADR that row is what a reader must
believe.

⭐ Editing them would additionally invalidate all four upstream gate records, which are
anchored to the §*Subject hashes* above. Precedent is exact and twice-tested: `PRD-020` (`D-3`)
and `PRD-021A` (`E-2`) were both admitted at Rank 3 with the same stale self-declarations left
in place. **Recorded as a known cosmetic residue, carried at §6.**

---

## 5. What this ADR deliberately does NOT do

| Act | Status |
|---|---|
| Change `PRD_LIFECYCLE.md` or any lifecycle authority | ⛔ **Refused.** Byte-unchanged — `5031fcc97a95980e…` |
| Change `PRD-021B` requirements, ACs, invariants or architecture | ⛔ **None changed.** 1,300 identifiers, 385 normative, 20 INV, 242 AC — untouched |
| Change the BC Map, Module Dependency Matrix or `ARCHITECTURE_RULINGS.md` | ⛔ **None changed.** BC Map `45e453032131cdda…` |
| Change any **frozen** PRD | ⛔ **None changed.** `PRD-020` `685fb65af95668df…`, `PRD-017` `c1f3abb49a3f6ab9…` |
| Change `TRACEABILITY_MATRIX.md` | ⛔ **Byte-unchanged** — `119d3ca6bdca09e3…`. §2Q already registers this subject |
| Reopen or re-rank Stage 3–6 decisions | ⛔ **Refused.** All four re-verified, none re-decided |
| Reopen `ADR-0091`'s determinations | ⛔ **Refused.** Its three open gaps stay open |
| Create a standing Governance Owner appointment | ⛔ **Refused** — the instruction forbids it; `ADR-0033` **L169** |
| Enter Stage 8, or create any `IMPL-*` | ⛔ **Refused.** 0 created; reserve untouched |
| Write application code | ⛔ **None.** 0 files under `lib/`, `test/`, `web/`, `tool/` |
| Delete or rewrite the Stage 7 blocker record | ⛔ **Refused** — retained beside this ADR, per the `ADR-0034` / `PRD-013` / `PRD-012a` precedent |

### 5.1 ⚠ A pre-existing defect found and deliberately NOT repaired here

§4's prose reads *"**Rank 3 holds fourteen module baselines** and they do not overlap"*, while
the §4 table was measured to hold **15** Rank 3 rows before this admission (and `ADR-INDEX.md`
already calls `ADR-0086`/`ADR-0087` the fifteenth and sixteenth). ⭐ **The sentence is stale by
one, and it was stale before this act.**

**It is not repaired in this commit**, on the standing instruction `ADR-0064` recorded for the
identical situation: folding an unrelated repair into an admission's commit leaves the defect
*"closed with no record of which pass closed it."* It is logged at **`GCP-20`**-adjacent in §6
and **routed**, not silently fixed. ⛔ **This ADR therefore does not increment that sentence**;
it states the measured count (`PRD-021B` is the **sixteenth**) in its own §3.3 and §4 rows,
where the number is derived from a count rather than from the stale prose.

---

## 6. Open items admitted OPEN — declared, not hidden

⭐ **An empty open-item ledger is NOT a Rank 3 admission prerequisite, and this is measured:**
`PRD-020` was admitted with **all 16** `TSF-GAP-*` OPEN; `PRD-021A` with **11 of 15**
`LCG-GAP-*` OPEN plus `LCF-GAP-011`; `PRD-012a` with **all 47** `SECP-GAP-*` OPEN. The
`ADR-0020` §4 rule governs: an admission may carry open questions **without ratifying any**.

| Item | Count | Owner | Effect on the baseline |
|---|---|---|---|
| `XPB-CONF-*` cross-part open decisions | **17** | Various — every one has a named owner (Stage 4: *"0 without an owner"*) | Carried OPEN. None is a requirement conflict |
| **`FOD-1`, `FOD-2`** | 2 | **ARB** | Carried OPEN. `ADR-0088` / `ADR-0090` **reserved and unwritten** |
| **`FOD-3`** | 1 | ARB | Carried OPEN |
| `*-GAP-*` carried gaps | **32** | Various | Carried OPEN |
| `PYK-GAP-002`, `PYK-GAP-003`, `GLS-GAP-002` | 3 | Left open by `ADR-0091` | ⛔ **Not reopened, not closed** |
| `tool/docs_check/prd021b_task_coverage.py` not written | 1 | **Governance Owner** | ⚠ Stage 6's §8 figures are reproducible **in principle only** — disclosed at `PRD-021B_IMPLEMENTATION_TASKS.md` §10.8. ⛔ **Not written here**: this conferral is for the freeze act, and a committed checker joins the standing 31-script sweep |
| 39 subject `NOT FROZEN` self-declarations | 39 | Governance Owner | ⚠ Cosmetic residue — §4.1 |
| **`PGA-08`** — no PRD has a named owner | — | Repository owner | Pre-existing, platform-wide |

**None of these blocks Rank 3**, and none is ratified by this admission.

---

## 7. `GCP-15` — the stale registry cell, corrected

The blocker record routed one repair to this office. `PRD_REGISTRY.md` §14 **L1163** reads:

> *"**Stage 3 NOT entered** for B7/B8/B9 — its gate is *"a written alignment record"*, and the
> only record on disk for these three parts is an **author self-check** (§14.6), which is
> categorically not an architecture review."*

⭐ **True when written; falsified since.** The consolidated
`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` reviews **B0–B9 together**, with `Act` =
*"Stage 3 — Architecture Review (`PRD_LIFECYCLE.md` L88–106)"*, `Reviewer role` =
**Architecture Reviewer**, and verdict ✅ **PASS — 6/6**. B7, B8 and B9 are three of its ten
subjects. The cell is a **`GCP-15`-class derived-statement defect**: a true statement about the
repository that the repository then moved past.

**Corrected here**, because §7 rule 3 makes it this office's business — *"A baseline that does
not match the repository is worse than no baseline"* — and because a registry that denies
Stage 3 for three parts of a document being admitted at Rank 3 is exactly the contradiction the
rule forbids. ⭐ **The correction is scoped to the two cells that are false** (`Lifecycle
stage`, `Freeze`); the surrounding §14 is left as written, and the original wording is
preserved in the corrected cell rather than overwritten.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-02 | Created and **`Accepted`**. ⭐⭐ **Admits `PRD-021B` B0–B9 v0.1 to `DOCUMENTATION_BASELINE.md` at Rank 3 for `BC-11` Social Graph and `BC-12` Messaging — the sixteenth Rank 3 module baseline** — and **CONFERS Stage 7**. Baseline re-issued `BASELINE-2026-09-01-B` → **`BASELINE-2026-09-02-A`** (§7 rule 4). Rank **derived** against five tests (§2), non-overlap **measured** (§2.1). Corrects `GCP-15` in `PRD_REGISTRY.md` §14 (§7). ⛔ Closes no `XPB-CONF-*`, no `FOD-*`, no gap; ⛔ edits no lifecycle authority, no subject byte, no frozen PRD, no BC Map, no matrix; ⛔ creates no standing appointment, no `IMPL-*`, no code; ⛔ leaves the pre-existing *"fourteen module baselines"* prose defect **unrepaired and routed** (§5.1). |

---

> ## ⭐⭐ `PRD-021B` B0–B9 — **ADMITTED AT RANK 3. STAGE 7 CONFERRED.**
>
> **`BASELINE-2026-09-02-A`** · `BC-11` Social Graph + `BC-12` Messaging · sixteenth Rank 3
> module baseline · ten subject documents **byte-unchanged** · 17 `XPB-CONF-*` and 35 further
> items carried **OPEN** and ratified by nothing.

**END — `ADR-0092` v1.0.**
