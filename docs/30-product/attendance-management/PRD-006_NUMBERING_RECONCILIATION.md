# `PRD-006` Attendance Management — Numbering Reconciliation Record

| Field | Value |
|---|---|
| **Document type** | Reconciliation record — **validation artefact, not part of the specification** |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) v1.1 `DRAFT` → **v1.2 `DRAFT`** |
| **Scope** | **PRD number only.** `PRD-008` → `PRD-006`, plus the two derived counts that changed with `ATT-GAP-001` |
| **Authorising source** | [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) line **236** — the standing allocation `PRD-006` = Attendance Management / `BC-03`. **No new decision was made** |
| **Date** | 2026-08-04 |
| **Status** | Supporting record. **Not ranked**, therefore editable without an ADR |
| **Precedence** | Below every document it cites. Where this file disagrees with `PRD-006_ATTENDANCE-MANAGEMENT.md`, **the PRD is right and this file is a defect** |
| **ADR raised** | **None — and none is required.** See §2, which tests the question against five rules rather than asserting it |
| **Registry modified** | **No.** `PRD_REGISTRY.md` `f8e71ce876c2b53b401d8b5ab47cf104ae5d5cc61e13336e4e084962544f0674` — byte-identical before and after |
| **Frozen documents modified** | **None.** `PRD-SEAT-MANAGEMENT.md` `c8760a46a8a371a6548e56e50c867bc4ae8e86d26f73e8f119ae003dced4b7c6` — byte-identical |
| **Lifecycle effect** | **None.** Still Stage 2, still `DRAFT`, still Unranked, still not frozen |

---

## 0. The defect, as found

A Stage 2 draft specifying bounded context `BC-03` Attendance carried the number **`PRD-008`** in its filename and
header. `PRD_REGISTRY.md` allocates:

| Line | Allocation |
|---|---|
| **236** | `PRD-006` · Attendance Management · **`BC-03` Attendance** · `[CORE]` · V1 · `PLANNED` |
| **238** | `PRD-008` · **Revenue & Finance** · `BC-05` Fee & Collection · `[CORE]` · V1 · `PLANNED` |

The draft therefore occupied a number reserved for a **different bounded context**, and left the number reserved
for its own context unclaimed. The draft had recorded this itself as `ATT-GAP-001` rather than concealing it.

**Why it mattered more than a cosmetic mismatch.** Frozen `PRD-SEAT-MANAGEMENT.md` (Rank 3) cites `PRD-006` as the
Attendance PRD **twice** — line **223** and line **862** — and `PRD_LIFECYCLE.md` Stage 7 forbids editing a frozen
document to follow a draft's choice. Had the draft been frozen carrying `PRD-008`, those two citations would have
become permanently dangling, and `PRD-008` would have had to be denied to Revenue & Finance.

---

## 1. Direction of the correction

**The register was right and the draft was wrong, so the draft moved.**

This is the whole substance of the reconciliation and it is stated first because the opposite reading —
"a PRD disagrees with the register, therefore fix the register" — is a plausible misapplication of registry §8
rule 5 and would have produced the wrong result here.

Rule 5 (line **559**) reads: *"If this register disagrees with a PRD, **fix this register**."* It does not apply:

1. **The disagreement was not registry-vs-PRD.** It was the registry **and a frozen Rank 3 PRD, twice** against a
   Stage 2 draft. Three authorities on one side; a draft that "claims no authority" (its own header) on the other.
2. **Applying it would have changed a correct register to match an incorrect draft** — and would have required
   denying `PRD-008` to Revenue & Finance, breaching §8 rule 1 (line **554**): *"Numbers are never reused or
   reassigned."*

---

## 2. Was an ADR required? — tested against five rules

Each rule was checked against its source text rather than judged by impression.

| # | Rule | Source | Applies here? |
|---|---|---|---|
| 1 | *"A change to any **Rank 1–5** document requires an ADR **before** the change."* | `DOCUMENTATION_BASELINE.md` §7 step 1, line **286** | **No.** The document's header declares it *"**Unranked.** … This document claims no authority"*, and `PRD_REGISTRY.md` does not appear anywhere in the rank ladder at lines **203–215** |
| 2 | *"A decision that changes **structure, ownership, a boundary, or a platform-wide rule** requires an ADR before implementation."* | `ADR-INDEX.md` Process step 1, line **87** | **No.** `BC-03` ownership, all nine edges, four events, the `AttendanceDay` aggregate, all 506 identifiers and all six modes are untouched |
| 3 | *"Numbers are never reused or reassigned."* | `PRD_REGISTRY.md` §8 rule 1, line **554** | **Satisfied, not excepted.** `PRD-006` was already Attendance's; `PRD-008` remains Revenue & Finance's. Both standing allocations are honoured; neither is changed |
| 4 | *"Adding a bounded context to a PRD's ownership is an **architecture change requiring an ADR**."* | `PRD_REGISTRY.md` §8 rule 6, line **560** | **No.** No context added, removed or transferred |
| 5 | *"A frozen PRD is never silently modified."* | `PRD_LIFECYCLE.md` Stage 7, line **175** | **Respected.** No frozen document was touched; `PRD-007`'s hash is unchanged |

**Conclusion: no ADR is required, and raising one would have been an invention.**

An ADR records a **decision between options**. There was no decision to make: `PRD_REGISTRY.md` line 236 had
already allocated `PRD-006` to `BC-03`, and a Stage 2 draft has no standing to hold a different number. Producing
an ADR for a conformance action would manufacture a governance artefact where governance already spoke — the
mirror of the failure `ADR-0013` §7 avoided by *declining* to resolve `BC-25` without evidence.

> **This record exists precisely so that "no ADR" is auditable rather than merely asserted.** It follows the
> `PRD-007_CORRECTION_RECORD.md` / `PRD-004_CORRECTION_REPORT.md` pattern: an unranked supporting record,
> editable without an ADR, that states what changed, what did not, and how to re-verify both.

---

## 3. What changed

### 3.1 Files renamed — via `git mv`, history preserved

| Before | After |
|---|---|
| `PRD-008_ATTENDANCE-MANAGEMENT.md` | **`PRD-006_ATTENDANCE-MANAGEMENT.md`** |
| `PRD-008_VERIFICATION_REPORT.md` | **`PRD-006_VERIFICATION_REPORT.md`** |

Both registered by git as `R` (rename), so `git log --follow` and `git blame` remain intact across the boundary.
**No external document linked to either filename** — verified by grep across `docs/**` — so no inbound link broke.

### 3.2 Edits inside the PRD

| Site | Change |
|---|---|
| Header *PRD* row | `PRD-008` *(as instructed…)* → **`PRD-006`**, citing registry line 236, with the reconciliation noted |
| Header *Version* row | v1.1 → **v1.2** |
| §32 preamble | Count 18 open → **17 open**; added the note that a resolved gap **keeps its number** (`PRD_LIFECYCLE.md` §5 rule 5) |
| §32 register, `ATT-GAP-001` | 🔴 OPEN → ✅ **RESOLVED**, with the resolution basis and *Blocks* changed to **Nothing** |
| §32 result line | *"2 resolved, 1 narrowed, 18 open"* → *"**3 resolved, 1 narrowed, 17 open**"*, plus a caveat that this third resolution proves nothing about buildability |
| §32.1 ledger row | `ATT-GAP-001` verdict rewritten to RESOLVED |
| §32.2 | Retitled *"…RECONCILED"*; added the executed-reconciliation subsection, the five-rule ADR test, and the stale-derived-records subsection |
| End-of-file line | Filename and version updated |
| §34 changelog | New **v1.2** row |

### 3.3 Edits inside the Verification Report

Title · subject link · verdict cell · §5 edge table header · §5 conclusion · §6 event table header · §9 `PRD-007`
table header · §11 gap table (`ATT-GAP-001` → RESOLVED) · §12 conflict table (PRD number → RESOLVED) · §13
"what is not proven" item 2 and the Stage 3 blocker list · §14 reproduction variable `F=` · §15 changelog
(new v1.2 row) · §16 heading · §16.2 opening · §16.5 (rewritten as a reconciliation record with the five-rule
ADR test).

### 3.4 Measurements

| Measure | Before (`14e899c`) | After |
|---|---|---|
| PRD SHA-256 | `95840ef700c52504b3133fd5bf066e22bfca71bb8d08004f687ee81953021108` | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` |
| Report SHA-256 | `8e40464024c96af90c73f4bc4d25466bc9fcb2e8a074d1dbb14cc405c1888991` | `c78ee66bbc3acaa2a44675b5b279e36f875e5e69d6f9b8b2805c9abaa94b3db8` |
| PRD lines | 2209 | 2260 |
| Report lines | 610 | 637 |
| Diff | — | **129 insertions, 51 deletions, 2 files** |

---

## 4. What did NOT change

| Preserved | Evidence |
|---|---|
| **All ten identifier registers** | 506 identifiers; FR 148 · BR 42 · INV 12 · EVT 4 · XC 21 · PO 14 · CFG 24 · NFR 14 · AC 209 · GAP 18 numbers / 21 rows |
| **Obligation coverage** | 279/279 = 100.0%, unchanged |
| **The six V1 attendance modes** | Six mode constants; **RFID = 0 occurrences as a V1 artefact**, Future only |
| **Manual individual attendance (§13A)** | V1-buildable, untouched |
| **OCR failure → staff verification (§13C)** | `NEEDS_MANUAL_VERIFICATION` / `ATT-INV-009` preserved verbatim — it is `F-4`'s Human-in-the-Loop record |
| **Every integration edge and event** | Nine edges, four `attendance.*` events, all still quoted from BC Map §7/§9 |
| **The 17 remaining gaps** | None closed, none re-graded, none invented away |
| **The `LIB-16.2` FAIL** | Seven configurables still have no default. **Not papered over** |
| **`PRD_REGISTRY.md`** | `f8e71ce876c2b53b401d8b5ab47cf104ae5d5cc61e13336e4e084962544f0674` — byte-identical |
| **`PRD-SEAT-MANAGEMENT.md`** (frozen) | `c8760a46a8a371a6548e56e50c867bc4ae8e86d26f73e8f119ae003dced4b7c6` — byte-identical |
| **Every other authoritative document** | `git diff 14e899c HEAD` across all governance, architecture, PRD, implementation, `lib/`, `test/`, `tool/` paths → **empty** |
| **ADR count** | 21 files. None created, none edited |
| **Lifecycle stage** | Stage 2. Stages 3, 4, 5, 6, 7 remain unpassed |

---

## 5. The exact registry change now available — identified, NOT applied

`PRD_REGISTRY.md` is **correct on the number** and needs no correction for it. Four *derived* statements are now
stale because the repository changed underneath them. They are specified here precisely so the registry owner can
apply them in one pass, and are **deliberately not applied by this record**.

| Line | Current text | Why stale | Entry evidence (§2) |
|---|---|---|---|
| **236** | `PRD-006` … `PLANNED` | A `DRAFT` document for `BC-03` now exists | `DRAFT` requires *"a document on disk with a version header"* — **satisfied** |
| **501** | *"**9 files, 7 PRD identities** — `PRD-000`…`PRD-005` and `PRD-007`"* | Two further files; an eighth identity | Filesystem |
| **504** | *"`DRAFT` — **0** — unchanged"* | This document is `DRAFT` | As line 236 |
| **505** | *"`PLANNED` — **17** — `PRD-006`, `PRD-008`…`PRD-023`"* | `PRD-006` would leave `PLANNED` | As line 236 |

**Why this record does not make those edits:**

1. **Registry §8 rule 3** (line **557**) — *"This register is updated **in the same commit** as the change it
   records."* A separate later commit by a different actor is the documented pattern for a status change, and the
   status change is the registry owner's call, not the PRD's.
2. **Registry §8 rule 2** (line **556**) — *"A status change requires the entry evidence in §2. **'It feels done'
   is not evidence.**"* The evidence now exists; presenting it is this record's job, applying it is not.
3. The instruction governing this work forbids modifying the registry without authorisation.

> These four are the same defect class the repository already tracks as `GCP-01`, `GCP-07` and `GCP-08` — *a
> derived statement left behind by a change to the thing it describes*. Recording rather than silently absorbing
> them follows that precedent.

---

## 6. Re-verification

Every claim above is reproducible:

```bash
cd /home/user/flutter_app

# 1. Both files carry PRD-006; no file carries PRD-008 in its name
find docs -iname "*PRD-006*" -o -iname "*PRD-008*"

# 2. Renames preserved history
git log --follow --oneline docs/30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md | head

# 3. Registry and the frozen PRD-007 are byte-identical
sha256sum docs/00-governance/prd-ecosystem/PRD_REGISTRY.md \
          docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md
#   expect f8e71ce8...0674  and  c8760a46...b7c6

# 4. No protected path was touched
git diff --stat 14e899c HEAD -- docs/00-governance/ docs/10-architecture/ \
  docs/30-product/MASTER_PRD.md docs/30-product/seat-management/ \
  docs/40-implementation/ lib/ test/ tool/ pubspec.yaml
#   expect: empty

# 5. No ADR was created
ls docs/00-governance/adr/ADR-*.md | wc -l        # expect 21

# 6. Registers unchanged
grep -c "ATT-FR-" docs/30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md

# 7. Remaining PRD-008 mentions are all legitimate
grep -n "PRD-008" docs/30-product/attendance-management/PRD-006_*.md
#   every hit must be: a Revenue & Finance quotation, the historical
#   narrative of this reconciliation, or a v1.0/v1.1 changelog row
```

### 6.1 Measured results

| Check | Result |
|---|---|
| Ten `ATT-*` registers | **148 / 42 / 12 / 4 / 21 / 14 / 24 / 14 / 209 / 18** — all contiguous, **506** identifiers, unchanged |
| Obligation coverage | **279/279 = 100.0%**, 0 orphan `ATT-AC-*` — unchanged |
| V1 attendance modes | **6** — `MANUAL`, `FACE`, `FIXED_QR`, `FIXED_QR_WIFI`, `FIXED_QR_GPS`, `DYNAMIC_QR`. Byte-identical to the pre-rename blob |
| `ATTENDANCE_MODE_RFID` | **0** — the Future classification holds |
| `attendance.*` events | **4** — unchanged |
| Out-of-range identifiers | **0** |
| Protected-path diff `14e899c..HEAD` | **empty** |
| ADR files | **21** (20 ADRs + `ADR-INDEX.md`) — none created |
| `ATT-` in `TRACEABILITY_MATRIX.md` | **0** — Stage 5 provably still unpassed |

### 6.2 A pre-existing gate failure found while verifying — reported, NOT fixed

Running the repository's five documentation gates surfaced a **`tool/docs_check/prd007_traceability.py` FAIL**: it
reports `SEAT-*` identifiers *"found outside the module and outside the registry"*, naming this module's two files.

**This is not a regression from the renumbering, and it is proved rather than asserted.** The identical failure
was reproduced against a pristine worktree of `14e899c` — before the rename and before this reconciliation — where
it names the same citations under their old `PRD-008_*` filenames. Every gate's exit code is unchanged:

| Gate | At `14e899c` | At `HEAD` | Verdict |
|---|---|---|---|
| `prd007_traceability.py` | **1** | **1** | Pre-existing |
| `prd007_task_coverage.py` | 0 | 0 | Unchanged |
| `prd005_traceability.py` | 1 | 1 | Pre-existing |
| `prd005_task_coverage.py` | 0 | 0 | Unchanged |
| `prd004_traceability.py` | 1 | 1 | Pre-existing (`SM-10.7`, `SM-10.8`) |

**Cause.** The script's `ALLOWED` list (lines **285–292**) enumerates six paths permitted to cite `SEAT-*`. It was
last widened by `ADR-0020` on the stated reasoning that *"a citation is not a collision"*. The Attendance PRD did
not exist when that list was written, and it legitimately cites frozen `PRD-007` — which is exactly what a
downstream consumer of `E-08` is supposed to do. The scan cannot distinguish a citation from a collision by path
alone, so it flags them. **No `SEAT-*` identifier is defined outside Seat Management**; the register is not
colliding.

**Why it is left unfixed here.** Widening the list is a change to a **Stage 5 gate artefact belonging to frozen
`PRD-007`**, whose precedent (`ADR-0020`) records such a change in an ADR. This reconciliation has no authority
over `PRD-007`'s gates and was explicitly scoped to numbering. **The correct change is named, not applied**: add
`"attendance-management/"` to `ALLOWED` at line **286**, under whatever record `PRD-007`'s owner requires. Logging
it here follows the `GCP-09` precedent — a defect found after the gates passed is disclosed, not silently repaired.

---

## 7. Status after this record

| Question | Answer |
|---|---|
| Is the numbering reconciled? | **Yes.** `PRD-006`, matching registry line 236 and frozen `PRD-007` lines 223 and 862 |
| Is `PRD-008` preserved for Revenue & Finance? | **Yes.** Unclaimed by this module and quoted as reserved throughout |
| Was an ADR required? | **No** — §2, tested against five rules |
| Was the registry modified? | **No.** The change it now needs is specified in §5 for its owner |
| Was any frozen document modified? | **No** |
| Is `ATT-GAP-001` closed? | **Yes** — by conformance, not by an owner ruling. 17 gaps remain open |
| Is `PRD-006` frozen? | **No.** Stage 2, `DRAFT`, Unranked. **This record confers no status and advanced no stage** |
| Did any gate regress? | **No.** All five exit codes are identical to `14e899c` (§6.2). One pre-existing `prd007_traceability.py` FAIL was **found and reported, not fixed** |
| What is the next gate? | **Stage 3 — Architecture Review**, requiring a written alignment record. Unchanged by this work |

---

*End of `PRD-006_NUMBERING_RECONCILIATION.md` v1.0.*
