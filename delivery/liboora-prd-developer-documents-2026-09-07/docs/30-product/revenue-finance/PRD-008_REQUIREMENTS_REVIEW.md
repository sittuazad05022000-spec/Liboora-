# `PRD-008` Revenue & Finance v1.7 — Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **L108–L119**) |
| **Subject** | [`PRD-008_REVENUE-AND-FINANCE.md`](PRD-008_REVENUE-AND-FINANCE.md) — `PRD-008`, `BC-05` Fee & Collection, **v1.7 `DRAFT`** |
| **Gate addressed by** | This document — *"conflicts closed or explicitly deferred **with a reason and an owner**"* (**L119**) |
| **Why this document exists at all** | ⚠ **`PRD-008` had no Stage 4 record.** Measured: `docs/30-product/revenue-finance/` held **2 files** — the PRD and its Stage 3 alignment record. Every peer has one ([`PRD-006_REQUIREMENTS_REVIEW.md`](../attendance-management/PRD-006_REQUIREMENTS_REVIEW.md), [`PRD-007_REQUIREMENTS_REVIEW.md`](../seat-management/PRD-007_REQUIREMENTS_REVIEW.md)). `ADR-0043` **§10 L459** asserts *"Stage 4 — Requirements Review ✅ Passed at v1.5; re-verified at exit 0"* — **but a status claim inside an ADR is not the gate artefact.** `PRD_LIFECYCLE.md` **L48** is explicit: *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed, however complete the work feels."* This record supplies the missing artefact |
| **Precedent followed** | [`PRD-007_REQUIREMENTS_REVIEW.md`](../seat-management/PRD-007_REQUIREMENTS_REVIEW.md) — header form, verdict form, mandate row, findings register with **rejected** findings retained |
| **Stage 3 record consumed** | [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT.md) (v1.2, ✅ 6/6) **jointly with** [`PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md) (v1.7 re-run, ✅ 6/6). ⚠ **Both are measurements; neither is a conferral.** See §5 |
| **Reviewed at** | `717dba0` |
| **PRD hash at review** | `d24832f33e600518415d47a58e6112b408c9ae0dce19c6fcd3c8b38e1d5057e5` — **v1.7, 2,808 lines, 369,405 characters**, verified identical before and after this review |
| **Date** | 2026-08-16 |
| **Status** | **Unranked.** A review record is a validation artefact, not a specification. It claims no authority and confers no status |
| **Mandate** | **Review only.** **No requirement created, reworded, renumbered or withdrawn** · no acceptance criterion added · no gap closed · no ADR written or accepted · no ranked document touched · no registry or baseline change · **no freeze** · **no conferral** · no checker weakened · 0 Dart files touched |
| **Verdict (measured)** | ✅ **A — PASS. All six gate checks PASS, plus the gate's own owner-attribution condition. 0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW.** |
| ⛔ **What this verdict is NOT** | **It is not a conferral, and Stage 4 is therefore NOT satisfied by this document alone.** `PRD_LIFECYCLE.md` **§6** assigns Stage 4 to the **Requirements Reviewer**. See **§5** |

---

## 0. Verdict

> ### ✅ **A — PASS**
>
> **Six of six Stage 4 checks PASS on `PRD-008` v1.7, and the gate's deferral condition is satisfied at 17 of 17.**
> **Zero findings at every severity. Zero requirements were created to reach this result** — the obligation count
> is **134** before and after, identical to v1.2.

⚠ **Read this beside §5.** A measured PASS is not an approval. The Requirements Reviewer must confer Stage 4; until
that act exists, `PRD-008` remains `DRAFT` with Stage 4 **NOT CONFERRED**.

---

## 1. Registers, as measured

Counted mechanically from the current bytes — *"counted by a tool, not by reading"* (`PRD_LIFECYCLE.md` **L124**).

| Register | Count | Contiguous from 001 | Carries obligation |
|---|---|---|---|
| `FEE-FR-*` | **62** | ✅ | ✅ |
| `FEE-BR-*` | **28** | ✅ | ✅ |
| `FEE-INV-*` | **10** | ✅ | ✅ |
| `FEE-EVT-*` | **3** | ✅ | ✅ |
| `FEE-XC-*` | **23** | ✅ | ✅ |
| `FEE-PO-*` | **8** | ✅ | ✅ |
| **Obligation-bearing total** | **134** | — | — |
| `FEE-AC-*` | **98** | ✅ | criterion |
| `FEE-GAP-*` | **17** | ✅ | ⛔ **not a requirement** |

---

## 2. The six gate checks

| # | Check (`PRD_LIFECYCLE.md` L110–117) | Measurement at v1.7 | Verdict |
|---|---|---|---|
| **C1** | Every requirement testable | **134 / 134** obligations map to ≥1 acceptance criterion. Uncovered: **0** | ✅ PASS |
| **C2** | Every exclusion states what must be **impossible** | **23** `FEE-XC-*`, all under headers carrying the modal — `\| ID \| This module MUST NOT \|` (**3** such headers). *"An exclusion is not a deferral"*: these state prohibition, not postponement | ✅ PASS |
| **C3** | Every configurable has a default and a range | `FEE-CFG-*` defined = **0**. A register that does not exist cannot hold an unbounded member; configurable **values** are delegated through `E-19` by `FEE-FR-006` rather than fixed here. **No "unbounded configuration" hole exists to find** | ✅ PASS |
| **C4** | Every acceptance criterion maps to a requirement | **98 / 98** mapped · orphan criteria **0** · dangling AC references **0** | ✅ PASS |
| **C5** | No requirement restates another PRD's | Foreign identifiers appearing in a first table cell: **8** — **all 8 are attributed quotations**, **0** unattributed restatements. See §3 | ✅ PASS |
| **C6** | Business rules do not contradict Rank 1 | **122** Rank 1 `MASTER_PRD` identifiers **cited**, none restated. `MP-GBR-24` is cited **41** times as a constraint `BC-05` **obeys**, never one it overrides. *"Rank 1 wins"* is respected by deference, not by silence | ✅ PASS |

### 2.1 C7 — the gate's own condition, tested separately

The Stage 4 gate is **not** the six checks. It is **L119**: *"conflicts closed or explicitly deferred **with a
reason and an owner**."* A PRD could pass C1–C6 and still fail the gate by deferring something to nobody, so the
condition is measured in its own right:

| Measurement | Result |
|---|---|
| Gap **definition** headings (title begins with the identifier) | **17** |
| Gap blocks naming an owner / deciding authority | **17 / 17** |
| Gap blocks naming **no** owner | **0** |

✅ **The gate condition is satisfied.** Every deferral is attributed.

---

## 3. Findings register

**0 CRITICAL · 0 HIGH · 0 MEDIUM · 0 LOW.** No finding is raised against `PRD-008` v1.7 by this review.

### 3.1 Findings this review RAISED and then REJECTED

`PRD_LIFECYCLE.md` **L104** requires rejected findings to be recorded with their reasons, because *"a review that
records only accepted findings is indistinguishable from a review that found nothing."* Two candidate findings were
produced by this review's own instruments and **both were rejected on evidence** — recorded here so the audit trail
shows what was examined, not merely what survived.

| # | Candidate finding | Why it was REJECTED | Class |
|---|---|---|---|
| **RJ-1** | *"C5 FAIL — `PRD-008` defines **8** identifiers belonging to `PRD-005`."* Eight `MM-*` identifiers appear in the **first cell** of table rows, the position a defining table uses | The eight rows are **attributed quotations inside comparison tables**, not definitions. Worked example, **L386**: `\| \`MM-FR-027\` (Rank 3, FROZEN) \| "makes the price snapshot immutable" (PRD-005 L695) \|`. Check 5 forbids **restating** another PRD's requirement — *"two sources of truth"*. **Quoting a frozen rule with its rank and its source line is deference, which is the opposite failure mode.** The instrument was reading cell **position** and inferring **authorship** | A first-cell foreign identifier is not necessarily a restatement |
| **RJ-2** | *"C7 FAIL — 20 gap headings but only 17 gaps registered; 3 gaps are undefined."* | **17 is right and the pattern was wrong.** Three headings *mention* a gap without defining it — **L1043** §18.1, **L1352** §28.1, **L2479** §39.2. A heading that cites an identifier is not its definition. The classifier was corrected to require the heading **to begin with** the identifier | A heading that mentions an identifier is not its definition |

> **Both errors ran in the direction that would have produced a more impressive review.** Each would have added a
> finding to a report that otherwise has none, and each would have been **wrong**. They are recorded here rather
> than dropped for exactly that reason.

---

## 4. What this review did NOT do

| | |
|---|---|
| **No requirement was created** | Obligation count **134** before, **134** after. `PRD_LIFECYCLE.md` Stage 4 has no clause permitting a reviewer to author requirements, and creating one to improve a score would corrupt the measurement it improves |
| **No gap was closed** | 17 before, 17 after. **Not one is marked `RESOLVED` by this record.** A review has no authority to close a gap; each names its own owner |
| **No `FEE-RSK-*` declaration was added** | The `FEE-RSK-*` register (**10** members) is registered in `TRACEABILITY_MATRIX.md` §2G but **not declared in `PRD-008` §0.2**. That is a **Stage 2** defect and a **document-owner** act. It is reported at every Stage 5 gate run and is **deliberately not self-fixed here** |
| **No ADR was written or accepted** | This record depends on `ACCEPTED` ADRs and **accepts none of them**. A review record must not accept the authority it relies on — it may only observe that a role with authority did |
| **The PRD is byte-unchanged** | `d24832f33e600518`, 2,808 lines, 369,405 characters — verified before and after |

---

## 5. ⛔ The boundary — measurement is not conferral

| | |
|---|---|
| **Who may confer Stage 4** | The **Requirements Reviewer** — `PRD_LIFECYCLE.md` **§6**: *"Requirements reviewer \| Stage 4"* |
| **Why this document does not** | The role is not held by the author of this pass. The repository's convention for exercising a role is an **explicit** act, *"by direct conferral of the human principal"* (`ADR-0033` §7.2, `ADR-0034`, `ADR-0035`, `ADR-0043`, `ADR-0046`), and no such conferral exists for Stage 4 of `PRD-008` |
| **Consequence** | `PRD-008` stays **`DRAFT`**. `PRD_REGISTRY.md` unchanged. `DOCUMENTATION_BASELINE.md` unchanged. **Stage 6 and Stage 7 remain unreached** |

### 5.1 The exact act required of the Requirements Reviewer

1. Adopt §2 and §2.1 as the measurement, or re-measure independently.
2. Adjudicate the two rejected findings in **§3.1** — accept the rejections, or reinstate either finding.
3. Confirm that **no requirement was created** to reach the PASS (obligation count 134, unchanged).
4. **Confer Stage 4**, or withhold it. Until that act exists, Stage 4 is **NOT CONFERRED**.

> ⚠ **One thing the reviewer should not be misled about.** `ADR-0043` **§10 L459** already records *"Stage 4 ✅
> Passed at v1.5"*. That statement is about the **checks**, and it was true of the checks. It is **not** the gate
> artefact, and it is **not** a conferral by the Requirements Reviewer. This record does not treat it as either.

---

## 6. References

[`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) **L108–L119** (the gate), §6 (roles), **L48** (a gate is an artefact) ·
[`PRD-008_ARCHITECTURE_ALIGNMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT.md) · [`PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md) ·
[`PRD-007_REQUIREMENTS_REVIEW.md`](../seat-management/PRD-007_REQUIREMENTS_REVIEW.md) — the precedent ·
[`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) §2G L582–590 ·
`tool/docs_check/prd008_stage5.py` — Stage 5 gate, exit 0

---

*End of `PRD-008_REQUIREMENTS_REVIEW.md` — Stage 4 **measurement** for `PRD-008` **v1.7 `DRAFT`** at `717dba0`.
**Verdict A — PASS, 0 findings. NOT A CONFERRAL. NOT AN APPROVAL. NOT A FREEZE.***
