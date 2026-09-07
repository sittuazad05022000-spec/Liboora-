# `PRD-010` — Stage 4 → Stage 7 execution record

| Field | Value |
|---|---|
| **Document** | `docs/30-product/notifications/PRD-010_STAGE4_TO_STAGE7_EXECUTION_RECORD.md` |
| **Version** | **v1.0** |
| **Type** | ⛔ **Review / execution record.** ⛔ **Confers nothing.** Not a PRD, not an ADR, not a conferral |
| **Date** | 2026-09-05 |
| **Subject** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` **v0.9 `DRAFT`** |
| **Subject sha256** | `343857f38a0251048b37d7d951340aa126118d4ca4a586b64d85c46164b99bb1` — ⛔ **byte-unchanged by this record** |
| **HEAD at audit** | `1aefe0111ffacd9f4933e5d403612262d5789984`, branch `main`, tree **clean** |
| **Instruction** | Advance `PRD-010` from Stage 4 to Stage 7 **only by following existing governance** |

> ⛔⛔ **VERDICT, STATED FIRST SO THE REST CANNOT BE READ AS PROGRESS.**
> **`STAGE 7 NOT CONFERRED — AUTHORITY OWED.`**
> **Stage 4 remains NOT READY.** Stages 5, 6 and 7 were **not entered**, because each is gated on the
> prior stage and the instruction's own critical clause requires stopping at the highest legitimately
> completed stage. The highest legitimately completed stage is **Stage 3**.

---

## 1. Why this record exists, and what it deliberately is not

The instruction asked for a Stage-7 outcome. ⭐ **The governance-correct Stage-7 outcome for `PRD-010`
is a refusal**, and the reasoning is recorded here so it can be checked rather than trusted.

⛔ **This record does not:** confer any stage · supply any configuration value · create or amend an ADR ·
amend the manifest · alter a frozen document · close any gap · mint any `NTF-*` identifier · change any
requirement · touch application or test code.

---

## 2. Step 1 — fresh repository audit (all figures re-measured, no inherited numbers)

| Item | Measured value | Method |
|---|---|---|
| Branch / HEAD | `main` / `1aefe011` | `git rev-parse`, `git branch --show-current` |
| Working tree | **clean** | `git status --porcelain` → empty |
| Subject version / status | **v0.9** / ⛔ **`DRAFT`** | subject header |
| `NTF-FR-*` | **65** | `grep -o … | sort -u | wc -l` |
| `NTF-BR-*` | **3** | same |
| `NTF-INV-*` | **11** | same |
| `NTF-XC-*` | **6** | same |
| `NTF-AC-*` | **9** | same |
| `NTF-GAP-*` | **27** | same — ⭐ the hypothesised 27 is **confirmed by measurement**, not assumed |
| `NTF-CFG-*` | **7** | same |
| Gap rows carrying an owner | **27 of 27** | row count inside §28 |
| Registry status | **`PLANNED`** | `PRD_REGISTRY.md` **L247** |
| Baseline rows for `PRD-010` | ⛔ **0** | `grep -c` in `DOCUMENTATION_BASELINE.md` |
| `NTF-` in `TRACEABILITY_MATRIX.md` | ⛔ **0** | `grep -c` |
| `IMPL-*` allocated to `PRD-010` | ⛔ **0** | sweep of `docs/40-implementation/` |
| ⭐⭐ **ADRs referencing `PRD-010` / `NTF-CFG` / `NTF-GAP`** | ⛔⛔ **0 files** | `grep -rl` across all **94** ADRs |
| ADR count | **94** | `ls | wc -l` |

⭐⭐⭐ **The decisive measurement is the last but one: across all 94 ADRs, not one references `PRD-010`,
`NTF-CFG-*` or `NTF-GAP-*`.** No Product Owner, Architecture Owner, SRE or Requirements Reviewer act
exists for this PRD anywhere in the repository. **Every value it needs is unowned.**

⚠ **Stale-citation check performed as instructed.** The `JobRuntime` line references were re-measured
this pass and the subject's **v0.9** corrections verified: the retry-unit sentence is at **L103-104**
and the deadline sentence at **L105-107** of
`packages/liboora_contracts/lib/src/ports/job_runtime.dart`. ⛔ **0 stale references remain in the
subject.** The Stage-4 record retains its original numbers **by design** (append-only) with the
correction carried in its supplement **v1.8**.

---

## 3. Step 2 — Stage 4 re-run from scratch, against `PRD_LIFECYCLE.md` §Stage 4 (L108-119)

The six checks are quoted from the authority, not paraphrased.

| # | Check (verbatim) | Result | Evidence | Owner |
|---|---|---|---|---|
| 1 | *"Every requirement testable"* | ⚠ **PARTIAL** | 0/85 vague terms; ⛔ but `NTF-FR-044` (Push `delivered` semantics) and `NTF-FR-065` (SLO) are **untestable as written** — both depend on absent external inputs | Requirements Reviewer |
| 2 | *"Every exclusion states what must be **impossible**"* | ⚠ **PARTIAL** | `NTF-XC-001`…`-006` all state impossibilities; ⛔ but `NTF-FR-021`/`-022` are **scope disclaimers sitting in a requirement register** | Requirements Reviewer |
| 3 | *"Every configurable has a default and a range"* | ⛔⛔ **FAIL** | **7 slots · 1 satisfied · 6 OWED** — see §4 | **Architecture + Product Owner** |
| 4 | *"Every acceptance criterion maps to a requirement"* | ⚠ **PARTIAL** | **0 orphan criteria** (the check as written **passes**); ⛔ but coverage is **9 / 85 = 10.6%**, and 8 of 9 carry no explicit requirement ID | Requirements Reviewer |
| 5 | *"No requirement restates another PRD's"* | ✅ **PASS** | All 15 rows naming another BC constrain `BC-22`'s **own** conduct; `NTF-CFG-002` **consumes** `LCFG-2` rather than copying it | — |
| 6 | *"Business rules do not contradict Rank 1"* | ✅ **PASS** | V1 channel set = exactly In-App + Push, matching `MP-SCOPE-09`; `MP-GBR-21`/`-33`/`-34`/`-35` all honoured | — |

**Gate (verbatim):** *"conflicts closed or explicitly deferred **with a reason and an owner**."*
⇒ ✅ **GATE SATISFIED 27/27** — every gap carries a reason and a named owner.

⭐⭐ **This is why the verdict is NOT READY rather than BLOCKED**: the deferral discipline is intact.
⛔ **But check 3 FAILS, and a Stage with a failing mandatory check cannot be conferred.**

---

## 4. Step 2C — the configuration register, slot by slot

| ID | Value | Range | Status | Authority | Evidence |
|---|---|---|---|---|---|
| `NTF-CFG-001` | ⛔ none | ⛔ none | **[OWED]** | **Product Owner** | `NTF-GAP-007`; **0** rate-limit/ceiling value at any rank |
| `NTF-CFG-002` | **`en`** | *"Supported set"* | ✅ **[AUTHORITATIVE]** | **Product** | `Library_PRD_v1.md` **L717** (FROZEN Rank 3); `CONFIGURATION_GUIDE.md` **L352** |
| `NTF-CFG-003` | ⛔ none per entry | `{mandatory, optional}` | **[OWED]** | **Product Owner** | `NTF-GAP-015`; range enumerated, **per-entry default owed** |
| `NTF-CFG-004` | **3** | **1–5** | ⚠ **[RECOMMENDED — NOT AUTHORITATIVE]** · **unit + floor [AUTHORITATIVE]** | **Architecture Owner** | Unit *"total attempts permitted, **including the first**"* — `job_runtime.dart` **L103-104** (rank 0); floor **≥ 1** enforced **executably** at `services.dart` **L152-159** citing `INV-21` |
| `NTF-CFG-005` | ⛔ none | ⛔ none | **[OWED]** | **Architecture Owner** | **0** backoff schedule at Rank 1–5; V1 adapter has **no delay primitive** (`services.dart` **L196-221**); EA **L1808** places *"Retry & Backoff"* at **V2** |
| `NTF-CFG-006` | ⛔ none | ⛔ none | **[OWED]** | **Architecture Owner** | `NTF-GAP-018`; bounded **below** by `NTF-INV-007` |
| `NTF-CFG-007` | ⛔ none | ⛔ none | **[OWED]** | **Architecture Owner** | `NTF-GAP-026`; one well-defined number (**transport/attempt-run** bound, §20.3e) |

⇒ ⛔ **1 of 7 satisfied.** ⭐ **`NTF-CFG-004` is the closest to ready — its *unit* and *floor* are
repository-authoritative and only its *number* is owed** — but **[RECOMMENDED] is not [AUTHORITATIVE]**,
and the instruction forbids the conversion. ⛔ **Not converted.**

---

## 5. Step 2 (F–H) — dependency, event and retry correctness

| # | Verified property | Result | Evidence |
|---|---|---|---|
| F1 | `BC-22` = `platform/communication`, **rank 5** | ✅ | manifest **L392-410**, ranks **L26-49** |
| F2 | A `BC-22` → `platform/services:job_runtime` edge would be **strictly downward** (3 → 5) ⇒ **`L2` satisfied, no waiver** | ✅ **[EVIDENCE]** | Matrix **L49**; ranks block |
| F3 | ⛔ `platform/communication` does **not** declare the `job_runtime` port | ⛔ **manifest amendment required** | manifest **L392-410** |
| G1 | Domain emits facts; `BC-22` consumes over `E-23` only | ✅ | `NTF-XC-004`; BC Map **L265**, **L332** |
| G2 | Address resolved via approved port `platform/identity:notification_address` (`A-3`) | ✅ | manifest **L462-464**; `CM-1` |
| G3 | Resolved address never persisted/cached/indexed/logged | ✅ | `CM-2` → `NTF-FR-058`, `NTF-FR-004` |
| G4 | ⭐ **`EBR-1030` protection intact** — unresolvable address fails the delivery **only** | ✅ **[AUTHORITATIVE]** | `CM-3`, manifest **L409-410** → `NTF-INV-011`, `NTF-AC-009` |
| H1 | `retryBudget` = **total attempts incl. first** | ✅ **[AUTHORITATIVE]** | `job_runtime.dart` **L103-104**; `JobOutcome.attempts` **L82** |
| H2 | Minimum **≥ 1** | ✅ **[AUTHORITATIVE]**, executable | `services.dart` **L152-159** |
| H3 | `deadline` bounds the whole job/attempt-run | ✅ **[EVIDENCE]** | `job_runtime.dart` **L105-107**; re-checked per attempt `services.dart` **L190-201** |
| H4 | Duplicate `JobKey` does not execute twice | ✅ **[AUTHORITATIVE]**, test-pinned | `services.dart` **L163-165** |
| H5 | ⭐ **No inter-attempt delay at V1** | ✅ **[EVIDENCE]** | `services.dart` **L196-221** — 0 delay primitives |
| H6 | Durable In-App fallback exists | ✅ **[EVIDENCE]** | **13/13** catalogue rows include In-App, **0** Push-only; BC Map **L205**, **L453** |
| H7 | ⛔ `3` is **not** authoritative | ⛔ **confirmed** | **0** of 94 ADRs supply it |

---

## 6. Step 3 — classification of every Stage-4 defect

| Defect | Class | Actionable by | Blocking Stage 4? |
|---|---|---|---|
| Check 3: `NTF-CFG-001`, `-003` values | **OWED** | **Product Owner** | ⛔ **YES** |
| Check 3: `NTF-CFG-004`, `-005`, `-006`, `-007` values | **OWED** | **Architecture Owner** | ⛔ **YES** |
| `NTF-FR-044` Push `delivered` semantics | **OPEN** | external (FCM docs absent — the `ADR-0045` condition) | ⚠ check 1 only |
| `NTF-FR-065` SLO | **OWED** | **SRE / Observability** — requires a **fresh** conferral (`ADR-0033` §7.1 bars reusing `ADR-0102`) | ⚠ check 1 only |
| `job_runtime` port absent from manifest | **BLOCKED** | **Architecture Owner** — manifest amendment, `A-3` shape | ⚠ consumability |
| `NTF-GAP-027` limb 3 (quiet hours V1/V2) | **OPEN** | **Architecture + Product Owner** — an `MP-CON-08` *"defect to be raised"* | ⚠ non-blocking |
| `NTF-GAP-025` (DLQ) | **OPEN** | **Architecture Owner** | ✅ **non-blocking** — post-exhaustion only |
| AC coverage 9/85 | **PARTIAL** | ⭐ **agent-actionable in principle** | ⚠ material for Stage 5 |
| Stage-4 conferral itself | — | **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**) | ⛔ **YES** |

⭐ **Agent-actionable items were sought deliberately.** Exactly one exists — authoring more acceptance
criteria — and it is **not** performed here, because ⛔ **it would not change the verdict**: check 3
would still fail, and adding ACs to a PRD whose configuration authority is absent is work that a later
authority may invalidate. ⚠ **This is a judgement, and it is recorded as one.**

---

## 7. Step 4 — decision package for the owed authorities

⛔ **This is a package, not a decision.** Nothing below is claimed as approved.

### 7.1 Retry — `NTF-CFG-004`

| Field | Content |
|---|---|
| **Proposed** | **3 total attempts, including the first** |
| **Range** | **1 – 5** |
| **Status** | ⚠ **[RECOMMENDED — NOT AUTHORITATIVE]** |
| **Unit** | ✅ **[AUTHORITATIVE]** — `job_runtime.dart` **L103-104** |
| **Floor** | ✅ **[AUTHORITATIVE]** — `services.dart` **L152-159** (`INV-21`) |
| **Derivation** | With **no** inter-attempt delay (**L196-221**), a larger budget buys **N near-simultaneous calls to a failing provider**, not a wider recovery window. `1` renders `NTF-FR-047` inoperative; `2` is defensible but unsupported; `4` is indistinguishable from `3` on evidence; **`5` is rejected** because the repository's only `5` is **adversarial** (`AUTH-3.9`, an attacker bound, listed *"not configurable"* at `CONFIGURATION_GUIDE` **L41**) |
| ⚠ **Caveat** | **Must be ratified jointly with `NTF-CFG-007`** — the feasibility inequality *attempts × per-attempt duration ≤ deadline* cannot be checked without it. Precedent: `ADR-0057` set `FIL-CFG-015` (120 s) and `FIL-CFG-014` (3) **in one act** |

### 7.2 Deadline — `NTF-CFG-007` ⇒ **[OWED]**

⛔ **No value proposed.** Repository evidence supplies the **semantics** (a transport/attempt-run bound,
one clock — §20.3e) but **no number**: the provider timeout is `NTF-GAP-017`, unresolvable because the
repository does not contain FCM's documentation. ⭐ `PRD-017` could derive `3` **only because** its
companion timeout was already fixed; `PRD-010` has no analogue. ⇒ **Inventing one is refused.**

### 7.3 Backoff — `NTF-CFG-005` ⇒ **[OWED]**

Three options, **not chosen here**: (a) **no backoff at V1** — consistent with the adapter and with EA
**L1808** placing *"Retry & Backoff"* at **V2**; (b) **configurable backoff** — requires a value that
does not exist; (c) **ADR**. ⭐ **Option (a) is the least-invention path and is noted as such**, but
⛔ selecting it is an Architecture Owner act, since it would fix V1 behaviour by omission.

### 7.4 Manifest

⭐ **Minimum lawful amendment — one line**: add `platform/services:job_runtime` to
`platform/communication`'s `ports:` list, in the **`A-3` shape** (`amendments_applied` **L715-721**).
⛔ **No `L2` waiver required** — rank 3 → rank 5 is strictly downward. ⛔ **Manifest NOT modified here**:
it is Rank 4, and baseline §7 requires *"an ADR **before** the change."*

### 7.5 `NTF-GAP-027`

⭐ Limbs **1** and **2** were already resolved by **existing** authority at subject **v0.8** (one clock;
no lifecycle mapping required — the port declares `JobState` *"deliberately not the same enum"* as a
domain lifecycle, `job_runtime.dart` **L45-51**). ⛔ **Limb 3 remains OPEN** and is **not** touched —
closing it would presuppose the quiet-hours V1/V2 answer that `MP-CON-08` reserves.

---

## 8. Step 5 — Stage 4 re-run result

⛔⛔ **STAGE 4 = NOT READY / NOT CONFERRED.**

- **Gates: 6.** ✅ **2 PASS** (checks 5, 6) · ⚠ **3 PARTIAL** (checks 1, 2, 4) · ⛔ **1 FAIL** (check 3).
- **Deferral gate: ✅ SATISFIED 27/27.**
- ⛔ **Conferral withheld** — it belongs to the **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6
  **L278**), and *a gate signed by the author of the thing being gated is not a gate*.

---

## 9. Steps 6, 7, 8 — Stages 5, 6, 7 NOT ENTERED

Each was located in the authority and tested for **entry eligibility** rather than skipped silently.

| Stage | Authoritative gate | Entry test | Result |
|---|---|---|---|
| **5 — Traceability** | *"prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, **zero collisions**"* (**L121-124**) | Requires Stage 4 conferred; **`NTF-` occurs 0 times** in the matrix | ⛔ **NOT ENTERED** |
| **6 — Implementation Tasks** | *"an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**"* (**L135**) | Requires Stage 5; **0** `IMPL-*` allocated to `PRD-010`; next free range would be `IMPL-227`+ | ⛔ **NOT ENTERED** |
| **7 — Freeze** | *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"* (**L157-160**) | Requires Stage 6; **0** baseline rows; ⭐ *"Freeze is **conferred, not claimed**"* | ⛔ **NOT ENTERED** |

⭐⭐ **Registering the `NTF-` prefix or allocating `IMPL-227`+ was mechanically possible and was
deliberately NOT done.** Stage 5's gate presupposes a **conferred** Stage 4; performing its mechanical
half on a NOT-READY subject would produce a matrix row implying a completed review that does not exist.
⛔ **That is the "cosmetically complete" outcome the instruction forbids.**

---

## 10. Step 8 — Stage-7 conferral matrix

| Gate | Condition | Result | Evidence | Authority | Notes |
|---|---|---|---|---|---|
| 1 | Stage 3 exists and passed | ✅ **PASS** | `PRD-010_ARCHITECTURE_ALIGNMENT.md` — 6/6, `NTF-AL-B2` DISCHARGED | Architecture reviewer | ⚠ `NTF-AL-F2`/`F3` disclosed, non-failing |
| 2 | Stage 4 exists and passed/conferred | ⛔⛔ **FAIL** | §8 — check 3 FAILS; **NOT CONFERRED** | Requirements Reviewer | ⛔ **Blocking** |
| 3 | Stage 5 exists and passed | ⛔ **FAIL** | **0** `NTF-` in `TRACEABILITY_MATRIX.md` | Traceability owner | Not entered |
| 4 | Stage 6 exists and passed | ⛔ **FAIL** | **0** `IMPL-*` allocated | Implementation lead | Not entered |
| 5 | Required approvals satisfied | ⛔⛔ **FAIL** | **0 of 94 ADRs** reference `PRD-010` | multiple | ⭐ the root cause |
| 6 | PRD version/status correct | ✅ **PASS** | **v0.9 `DRAFT`** — honestly stated | — | Claims nothing it lacks |
| 7 | Registry status consistent | ✅ **PASS** | **`PLANNED`** (**L247**) — consistent with DRAFT | Governance owner | Unmodified |
| 8 | No frozen decision altered | ✅ **PASS** | 0 frozen PRDs, 0 baseline, 0 BC Map, 0 `MASTER_PRD`, 0 EA, 0 matrix, 0 manifest | — | Verified by `git status` |
| 9 | No unresolved mandatory blocker | ⛔⛔ **FAIL** | 6 owed values + Stage-4 conferral | multiple | ⛔ **Blocking** |
| 10 | OPEN gaps correctly classified | ✅ **PASS** | **27/27** carry a reason **and** an owner | — | Deferral gate satisfied |
| 11 | Evidence points to current content | ✅ **PASS** | All citations re-measured this pass | — | v0.9 corrections verified |
| 12 | No stale line-number citations | ✅ **PASS** | **0** stale refs in the subject | — | Record retains its own **by design** (append-only), corrected in supplement v1.8 |
| 13 | No duplicate/conflicting requirement introduced | ✅ **PASS** | 0 identifiers minted this pass; all 7 registers contiguous | — | Measured |
| 14 | No unauthorized code/manifest change | ✅ **PASS** | **0** code, **0** tests, **0** manifests | — | Verified |

⇒ **9 of 14 PASS · 5 FAIL.** ⛔ **Gates 2, 3, 4, 5 and 9 are each independently fatal.**

---

## 11. Integrity

| Item | Value |
|---|---|
| Files created | **this record only** |
| Files modified | see §12 |
| Files deleted | **0** |
| Code changed | ⛔ **0** — `job_runtime.dart`, `services.dart`, `di.dart` **read as evidence only** |
| Tests changed | ⛔ **0** |
| Manifests changed | ⛔ **0** |
| Frozen PRDs changed | ⛔ **0** |
| ADRs | **94**, unchanged |
| Identifiers minted | ⛔ **0** |
| Gaps closed | ⛔ **0** — **27 OPEN** |
| Values converted [RECOMMENDED] → [AUTHORITATIVE] | ⛔ **0** |

---

## 12. Owed authority — the exact decisions required, in dependency order

| # | Decision | Owner | Unblocks |
|---|---|---|---|
| 1 | `NTF-CFG-007` transport deadline **+** `NTF-CFG-004` = 3 (range 1–5) — **one act** | **Architecture Owner** | Check 3 · the feasibility inequality |
| 2 | `NTF-CFG-005` backoff (or a reasoned "none at V1") · `NTF-CFG-006` dedup window | **Architecture Owner** | Check 3 |
| 3 | `NTF-CFG-001` ceiling/rate limit · `NTF-CFG-003` mandatory/optional register | **Product Owner** | Check 3 |
| 4 | Manifest: `job_runtime` port for `platform/communication` (ADR **before** the change) | **Architecture Owner** | Consumability |
| 5 | `NTF-GAP-027` limb 3 — quiet hours V1/V2 (`MP-CON-08` defect) | **Architecture + Product Owner** | `NTF-FR-039` |
| 6 | `NTF-FR-065` SLO/SLI — **fresh** conferral scoped to `PRD-010` | **SRE / Observability** | Check 1 |
| 7 | **Stage-4 conferral** | **Requirements Reviewer** | Stages 5 → 6 → 7 |

⛔ **None of the seven is agent-actionable.** ⛔ **None is manufactured here.**

---

## 13. Final verdict

> ⛔⛔ **`STAGE 7 NOT CONFERRED — AUTHORITY OWED`**
>
> Highest legitimately completed stage: ⭐ **Stage 3 (PASS 6/6)**.
> Stage 4 **NOT READY** — check 3 fails on **6 of 7** configuration slots, and **0 of 94 ADRs** supply
> any of them. Stages 5, 6 and 7 **not entered**, each being gated on its predecessor.

---

## 14. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created. Stage 4 re-run from scratch against `PRD_LIFECYCLE.md` **L108-119**: **2 PASS · 3 PARTIAL · 1 FAIL**, deferral gate **satisfied 27/27**. ⭐⭐ **The decisive new measurement: `grep -rl` across all **94** ADRs returns **0 files** referencing `PRD-010`, `NTF-CFG-*` or `NTF-GAP-*`** — so **no** Product Owner, Architecture Owner, SRE or Requirements Reviewer act exists for this PRD anywhere, and every value it needs is unowned. Stages 5, 6, 7 **located in the authority and tested for entry eligibility**, then **NOT ENTERED** (0 `NTF-` in `TRACEABILITY_MATRIX.md`; 0 `IMPL-*`; 0 baseline rows). ⭐ **Registering the prefix and allocating `IMPL-227`+ were mechanically possible and deliberately refused**, because Stage 5's gate presupposes a **conferred** Stage 4 and doing its mechanical half would imply a review that does not exist. Stage-7 matrix: **9 of 14 PASS, 5 FAIL**, gates 2/3/4/5/9 each independently fatal. Seven owed decisions published in dependency order; **none agent-actionable, none manufactured**. ⛔ **0 values invented · 0 [RECOMMENDED] converted to [AUTHORITATIVE] · 0 gaps closed (27 OPEN) · 0 identifiers minted · 0 ADRs (94) · 0 manifest · 0 frozen PRDs · 0 baseline · 0 registry · 0 matrix · 0 `IMPL-*` · 0 application code · 0 test code.** Verdict: **`STAGE 7 NOT CONFERRED — AUTHORITY OWED`**. |
