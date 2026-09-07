# ADR-0113 — `PRD-009` Analytics & Reports v0.6 is **ADMITTED to `DOCUMENTATION_BASELINE.md` §3.3 at Rank 3** for `BC-26`

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-09-05 |
| **Date** | 2026-09-05 |
| **Deciders** | ⭐⭐⭐ **Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6) — exercised by **direct, explicit and unconditional conferral of the human principal of this engagement**, quoted verbatim at §2. ⛔ **`ADR-0033` §7.1 — not a standing licence.** ⛔ **No personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4) |
| **Act** | ⚖️ **THIS IS THE ADMITTING ADR.** It is recorded **BEFORE** the baseline row, per `DOCUMENTATION_BASELINE.md` §7 **rule 1** |
| **Supersedes** | — |
| **Amends** | `DOCUMENTATION_BASELINE.md` (§3.3 rows + §8 changelog) · `ADR-INDEX.md` (register row + count cell) · `PRD_REGISTRY.md` (status `PLANNED` → `FROZEN`). ⛔ **No PRD, no frozen document, no Rank 1–2 artefact, no BC Map, no Dependency Matrix, no `module_dependencies.yaml`, no `TRACEABILITY_MATRIX.md` line is modified** |
| **Amended by** | — |
| **Baseline** | ⛔ **`BASELINE-2026-09-03-A` STANDS — the identifier does NOT change.** §7 **rule 4**: *"The baseline identifier changes only when a **Rank 1–3** document changes **version**."* ⭐ `PRD-009` enters for the **first time**; it held no rank and therefore no version to change (§5.1) |
| **Closes** | ⭐ Stage-7 entry conditions **10** (baseline row) and **11** (admitting ADR) of `PRD-006_STAGE7_FREEZE_READINESS.md` §3, taking `PRD-009` from **9 / 11** to **11 / 11** |
| **Does NOT close** | ⛔⛔ **F-1** (no semantic layer) · **F-2** (no learning-outcome data) · **F-3** (peer comparison barred) · `AttendanceCorrected` · **`ANL-AL-B1`/`ANL-OBD-008`** (live **Rank-4 vs Rank-4** `iam.*` conflict) · `ANL-OBD-002`/`-004`/`-009` · `ANL-CFG-003`/`-005`/`-006` values · **all 25** `ANL-GAP-*` · ⛔ **Stage 8** (**0 / 17** acceptance criteria proven by a test) |
| **Related** | `ADR-0111` (the direct template — `PRD-010` admission) · `ADR-0106` (`PRD-015`) · `ADR-0051`, `ADR-0054`, `ADR-0064`, `ADR-0087` (the other freeze conferrals) · `ADR-0080` (the office, constituted VACANT) · `ADR-0112` (`PRD-009` **Stage 3 only** — ⛔ **not reused here**) · `ADR-0082` (chain order) |

---

## 1. Context

`PRD-009` reached **9 of 11** Stage-7 entry conditions, measured in
[`PRD-009_STAGE7_FREEZE_READINESS.md`](../../30-product/analytics/PRD-009_STAGE7_FREEZE_READINESS.md)
v1.0. The two absent conditions were **the baseline row** and **the admitting ADR** — and that record
stated plainly that they *"are one dependency seen from two sides"* and that neither could be
self-closed, because the **Governance Owner office is constituted VACANT** (`ADR-0080` §2.2).

⭐ **The human principal has now supplied the conferral.** This ADR is the first step of the five-step
sequence `ADR-0111` established, and it is recorded **before** any baseline byte changes.

---

## 2. ⭐⭐⭐ The conferral, recorded as it actually is

### 2.1 The act, in the principal's own words

> *"I confer PRD-009 for admission to Stage 7 at Rank 3, and nothing else."*

**That instruction is the authority, and it is the only authority claimed.**

⭐ The instruction is **first-person**, names the **subject** (`PRD-009`), names the **act** (admission to
Stage 7), names the **rank expressly** (**Rank 3**), and **closes its own scope** (*"and nothing else"*)
— the same four elements `ADR-0106` §2 and `ADR-0111` §2 record.

### 2.2 ⛔ What is NOT claimed

| ⛔ Not claimed |
|---|
| ⛔ **No personal name, initials, handle or identity** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4: *"**Never** record a personal name"*. The office is exercised **role-based** |
| ⛔ **No self-appointment.** The conferral is the principal's act; ⭐ **the agent is not the Governance Owner and does not act as one outside this grant** |
| ⛔ **No standing office.** Outside this act the office reverts to **VACANT** (`ADR-0080` **L242**) |
| ⛔ **No licence for any other PRD** — `ADR-0033` §7.1 |
| ⛔ **No rank other than 3**, and ⛔ **no re-ranking** of any already-baselined document |
| ⛔ **No Rank 1–2 amendment**, no BC Map or Dependency Matrix change, no `TRACEABILITY_MATRIX.md` change |
| ⛔ **No Stage 8**, and ⛔ **no claim that the specification is implemented** |
| ⛔ **No blocker closed, downgraded or reinterpreted** — see §6 |

### 2.3 ⚠ On the phrase *"admission to Stage 7"* — read narrowly, not generously

⚠ **The conferral admits `PRD-009` to Stage 7. It does not assert that Stage 7 is thereby "complete" in
any sense beyond the gate.** The Stage-7 gate **is** the baseline row — `PRD_LIFECYCLE.md`: *"a row in
`DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank."* ⭐ So admission at a rank **is** the
conferral of Stage 7, and this ADR performs exactly that and stops.

⛔ **What it therefore does not touch:** Stage 8 verification, implementation readiness, or any open
decision. `PRD-009` becomes **`FROZEN`** — which records what `BC-26` **owns**, not what is **decided**.

---

## 3. Decision

### 3.1 The admission

> ⭐⭐⭐ **`PRD-009_ANALYTICS_AND_REPORTS.md` v0.6 is ADMITTED to `DOCUMENTATION_BASELINE.md` §3.3 at
> **Rank 3**, scoped to "Everything inside `BC-26` Analytics Read Model".**

| Aspect | Determination |
|---|---|
| **Subject** | `PRD-009_ANALYTICS_AND_REPORTS.md` **v0.6**, sha256 `53df11c4fcee6930a5d2be2310b9988db5dba09c4731f4b26247a0b58bddd70b`, **1,194 lines** |
| **Rank** | ⭐ **3** — named expressly by the conferral, and independently corroborated by §4 |
| **Scope of rank** | *"Everything inside `BC-26` Analytics Read Model"* — the metric/semantic layer, read-model store, projections, reports and exports (BC Map **L135**) |
| **Validation records admitted with it** | The Stage-3 alignment record, the Stage-3/4/5 conferrals, the Stage-6 task document and the Stage-7 readiness record — **as validation records, NOT as specification** |
| **Registry** | `PLANNED` → **`FROZEN`** (`PRD_REGISTRY.md` §8 rule 2 entry evidence: 11/11 conditions) |
| **Duration** | ⛔ **This act only.** The office reverts to VACANT |

### 3.2 The five-step order, and why the order matters

| Step | Act | Rule |
|---|---|---|
| **1** | ⭐ **This ADR** | §7 **rule 1** — *"an ADR **before** the change"* |
| **2** | `DOCUMENTATION_BASELINE.md` §3.3 rows + §8 changelog | §7 rules 2–3 — same commit |
| **3** | `ADR-INDEX.md` row + count **re-derived** | The index follows the ADR it indexes |
| **4** | `PRD_REGISTRY.md` `PLANNED` → `FROZEN` | §8 rule 2 |
| **5** | `PRD-009_STAGE7_CONFERRAL.md` | The conferral record |

⛔ **Steps 2–5 are consequences of this ADR, not independent acts.** Writing the baseline row first would
have inverted §7 rule 1 — the failure mode the rule exists to prevent.

---

## 4. ⭐⭐ Rank 3 — corroborated independently of the conferral

⚠ **The conferral names Rank 3. This ADR does not rely on that alone**, because an ADR that accepts a
rank purely on instruction records no reasoning. The rank was **proven by exclusion** in the readiness
record §3, and re-stated here:

| Rank | What `DOCUMENTATION_BASELINE.md` §4 assigns it | Fits `PRD-009`? |
|---|---|---|
| 1 | `MASTER_PRD.md` global rules | ⛔ No |
| 2 | Accepted ADRs | ⛔ No |
| **3** | ⭐ **Module PRDs, each scoped *"Everything inside `BC-nn`"*** | ⭐ **YES — the only rank whose definition fits.** `PRD-009` owns exactly one bounded context, `BC-26` |
| 4 | ⛔ **Bounded Context Map · Module Dependency Matrix** — *"Boundaries, ownership, permitted edges"* | ⛔ **No — structurally reserved for the two architecture instruments** |
| 5 | Architecture Rulings `AR-1`, `AR-3`, `AR-4` | ⛔ No |
| 6 | Enterprise Architecture — *"Descriptive only"* | ⛔ No |

⭐ **Corroboration by count:** §3.3 holds **18** Rank 3 rows; **every** Rank 4 row is an architecture
instrument, never a PRD. ⭐ **The instruction and the evidence agree**, and the agreement is recorded as
two independent findings rather than one.

---

## 5. Consequences

### 5.1 ⭐⭐ Why the baseline identifier does NOT change — measured against rule 4

§7 **rule 4**: *"The baseline identifier changes only when a **Rank 1–3** document changes **version**."*

| Limb | Measured |
|---|---|
| Does an already-baselined Rank 1–3 document change version? | ⛔ **NO** — `PRD-009` is entering for the **first time**; it held no rank and therefore no version to change |
| Precedent | ⭐ **`ADR-0111`** made the identical determination for `PRD-010`, and **`ADR-0106`** for `PRD-015`: *"the identifier does NOT change"* |
| Contrast | `ADR-0087` **did** re-issue (`BASELINE-2026-09-01-B`) — because `PRD-021A` entered as an eight-part subject under the then-current identifier's own terms |

⭐ **`BASELINE-2026-09-03-A` stands, unchanged.**

### 5.2 ⚠ No §4 Precedence row — the disclosed precedent, not a silent omission

⚠ **This ADR adds rows to §3.3 but NOT to the §4 Precedence table**, and that is stated rather than left
to be discovered.

| Fact | Detail |
|---|---|
| Precedent | ⭐ **`ADR-0111`/`PRD-010` and `ADR-0106`/`PRD-015` each received a §3.3 row and no §4 row.** Omitting it is therefore the established pattern, not an oversight |
| Known open defect | ⚠ **`GCP-20`** — `PRD-014` likewise received a §3.3 row and never a §4 row. It is **OPEN and deliberately not repaired here** |
| Why not repaired | ⛔ Repairing `GCP-20` would amend §4 for **three other PRDs**, which is **outside** *"and nothing else"*. ⭐ `ADR-0111` §4.1 declined for the same reason |
| Effect | ⭐ **None on authority.** §4 *"confers rank by identifier, never by count"*, and §3.3 carries the rank |

⛔ **`GCP-20` is disclosed, not replicated silently and not closed.**

### 5.3 What changes and what does not

| ⭐ Changes | ⛔ Does not change |
|---|---|
| `PRD-009` gains **Rank 3** authority for `BC-26` | ⛔ **0** `.dart` files; no code exists for `BC-26` beyond a 251-line projection module |
| Registry `PLANNED` → **`FROZEN`** | ⛔ No requirement, exclusion, AC, CFG, GAP or OBD altered |
| Stage 7 **11 / 11** | ⛔ Stage 8 not entered — **0 / 17** acceptance criteria proven |
| Post-freeze change rules now bind `PRD-009` | ⛔ `TRACEABILITY_MATRIX.md`, BC Map, Dependency Matrix, `module_dependencies.yaml`, `MASTER_PRD.md` all byte-unchanged |

---

## 6. ⛔⛔ Blockers — admitted **OPEN**, none closed

⭐⭐ **A freeze records what a context OWNS, not what is DECIDED.** This is the single most important
limit on this ADR, and it is precedented: `PRD-008` froze with **all 17** gaps open; `PRD-017` froze with
three configuration values owed.

| Item | State at admission | Owner |
|---|---|---|
| **F-1** — no semantic layer exists, though `MP-GBR-36` requires one and manifest `AN-2` makes it assertable | ⛔ **OPEN — BLOCKER** | Architecture + Implementation |
| **F-2** — no learning-outcome data source exists | ⛔ **OPEN — BLOCKER** | Product Owner |
| **F-3** — peer comparison structurally barred (`MP-GBR-21` closed scope register) | ⛔ **OPEN** | Product Owner + ADR |
| `AttendanceCorrected` restatement semantics | ⛔ **OPEN** | Product Owner |
| **`ANL-AL-B1` / `ANL-OBD-008`** — **Rank-4 vs Rank-4** `iam.*` conflict (BC Map **L434** vs manifest **L317**/`AN-3`) | ⛔ **OPEN** — ⭐ conservative default `ANL-XC-012` governs, so **no `iam.*`-derived metric is authorised** | **Architecture Owner** |
| `ANL-OBD-002` · `-004` · `-009` | ⛔ **OPEN** | Privacy+Arch · `BC-18` · Product |
| `ANL-CFG-003` · `-005` · `-006` values | ⛔ **OWED** | SRE · Privacy · Arch+Legal |
| **25** `ANL-GAP-*` | ⛔ **25 / 25 OPEN** | Named per gap |

⛔ **Nothing above was closed, downgraded or reinterpreted to obtain this admission.** ⭐ Mechanically
enforced: `prd009_stage5.py` **fails** if any of the twelve is deleted from the subject.

⚠⚠ **Therefore, stated plainly: `PRD-009` becomes a FROZEN specification, not a shippable capability.**
Its foundation — the semantic layer `MP-GBR-36` requires — **does not exist**, and **8 of 32** Stage-6
tasks cannot be started.

---

## 7. ⛔ Scope limits

| ⛔ Not done |
|---|
| ⛔ **`ADR-0112` NOT reused** — scoped to *"`PRD-009` Stage-3 … and nothing else"*; `ADR-0033` §7.1 |
| ⛔ **No other PRD touched** — `PRD-010` byte-unchanged and still FROZEN at Rank 3 |
| ⛔ **No frozen PRD modified**; no Rank 1–2 artefact; no BC Map, Dependency Matrix or manifest change |
| ⛔ **`TRACEABILITY_MATRIX.md` byte-unchanged** — Stage 5 is already conferred and is not revisited |
| ⛔ **The subject PRD is byte-unchanged** — sha256 `53df11c4fcee6930` |
| ⛔ **No Stage-3/4/5/6 artefact modified** — all consumed as evidence, not edited |
| ⛔ **No `IMPL-*` identifier allocated**; **0** `.dart`; **0** `tool/` |
| ⛔ **No personal name, initials, handle or identity recorded** |
| ⛔ **No ARB quorum, attendee list or sign-off date asserted**; no Security or Privacy review asserted or waived |
| ⛔ **`GCP-20` not closed** and **`GCP-25`** not repaired — both disclosed |

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | ⭐⭐⭐ **Created — Accepted. THIS IS THE ADMITTING ADR**, recorded **BEFORE** the baseline row per §7 **rule 1**, which binds the baseline's own amendment because the baseline is itself Rank 1 governance. ⭐⭐ **The `Governance Owner` office — constituted VACANT by `ADR-0080` §2.2 — is CONFERRED FOR ONE ACT ONLY** by the human principal's **first-person** instruction, quoted verbatim at §2.1: *"I confer PRD-009 for admission to Stage 7 at Rank 3, and nothing else."* ⭐ It names subject, act, **rank** and its own closing scope — the four elements `ADR-0106` §2 and `ADR-0111` §2 record. ⛔ **No personal name recorded** (§7 rule 4); the office is exercised **role-based** and **reverts to VACANT** after this act. ⭐⭐ **§4 corroborates Rank 3 INDEPENDENTLY of the instruction**, because an ADR that accepts a rank purely on instruction records no reasoning: Rank 4 is **structurally reserved** for the BC Map and Dependency Matrix, Rank 1 is `MASTER_PRD` rules, Rank 2 Accepted ADRs, Rank 5 Architecture Rulings and Rank 6 descriptive — leaving **Rank 3**, defined as *"Everything inside `BC-nn`"*, which is exactly what `PRD-009` is for `BC-26`. **The instruction and the evidence agree, and the agreement is recorded as two findings rather than one.** ⭐ **§5.1** determines the **baseline identifier does NOT move** — §7 rule 4's limb is unmet because `PRD-009` enters for the **first time** and had no version to change, the identical determination `ADR-0111` and `ADR-0106` made. ⚠ **§5.2 discloses that NO §4 Precedence row is added**, on the `ADR-0111`/`ADR-0106` precedent, and records that **`GCP-20` remains OPEN and deliberately unrepaired** — repairing it would amend §4 for three other PRDs, outside *"and nothing else"*. ⚠ **§2.3 reads the conferral NARROWLY rather than generously**: the Stage-7 gate *is* the baseline row, so admission at a rank *is* Stage 7 — and nothing beyond it, expressly not Stage 8 (**0/17** criteria proven) and not implementation readiness. ⛔⛔ **§6 admits every blocker OPEN and closes none:** **F-1** (no semantic layer, though `MP-GBR-36` requires one), **F-2** (no learning-outcome data), **F-3**, `AttendanceCorrected`, **`ANL-AL-B1`/`ANL-OBD-008`** (the live Rank-4 vs Rank-4 `iam.*` conflict, where `ANL-XC-012`'s conservative default means **no `iam.*`-derived metric is authorised**), `ANL-OBD-002`/`-004`/`-009`, three owed `ANL-CFG-*` values and **25/25** `ANL-GAP-*` — on the `PRD-008` precedent (froze with all 17 gaps open) and `PRD-017` (froze with values owed). ⚠ **Stated plainly: this makes `PRD-009` a FROZEN specification, not a shippable capability** — its foundation does not exist and **8 of 32** Stage-6 tasks cannot be started. ⛔ `ADR-0112` **not reused**; subject and all Stage-3/4/5/6/7 artefacts **byte-unchanged**; `TRACEABILITY_MATRIX.md`, BC Map, Dependency Matrix, `module_dependencies.yaml`, `MASTER_PRD.md` untouched; **0** `.dart`; `PRD-010` untouched and still FROZEN. |
