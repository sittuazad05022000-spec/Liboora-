# PRD-020 — Durable Context Handoff

| Field | Value |
|---|---|
| **Document type** | 📦 **Context backup / continuation handoff.** ⛔ **NOT a source of authority.** It confers no status, decides nothing, and creates no identifier |
| **Subject** | `PRD-020` — Trust & Safety, Privacy, Abuse Prevention & Moderation |
| **Path** | `docs/30-product/trust-safety/PRD-020_CONTEXT_HANDOFF.md` |
| **Created at commit** | **`4f3e597`** — branch `main`, working tree **clean** |
| **Measurement basis** | Every claim below was re-measured from repository files at `4f3e597`. Prior conversation text was **not** treated as evidence |
| **Identifiers minted** | **0** |
| **ADRs created** | **0** |
| **Lifecycle advancement performed** | **NONE.** No stage advanced, no status changed, no gate marked passed |
| **Protected artefacts modified** | **NONE** |
| **Precedence** | ⛔ If this document ever contradicts a repository file, **the repository file wins** and this document is stale. Accepted ADRs remain authoritative in all cases |

---

## 1. PURPOSE OF THIS HANDOFF

Agent context resets. When it does, the risk is not that work is lost — the work is
committed — but that a future session **re-derives conclusions badly**: repeating audits
already performed, re-reading a rule that was measured not to apply, or mistaking a
measurement for a grant of authority and "advancing" PRD-020 unlawfully.

This document exists so a future session can reach the current frontier **without
re-litigating settled ground and without inventing authority**. It records:

- what is **MEASURED** (facts read off files at `4f3e597`),
- what is **VERIFIED** (measured *and* cross-checked against a second source),
- what is **OPEN** (a real gap),
- what is **BLOCKED** (open *and* waiting on something specific),
- what is an **OWNER-ACT** (something only a named role may lawfully do),
- what is **PROPOSED** (analysis or recommendation, binding on nobody).

⛔ **The single most important thing in this document is §10 and §14.** Everything else
is recoverable by re-measurement. Those two sections record judgements that were
expensive to reach and cheap to get wrong.

---

## 2. REPOSITORY BASELINE — **MEASURED**

| Property | Value at handoff creation |
|---|---|
| **Commit** | `4f3e5975bb4cd3ba18db9d522d9e476e2c02501a` (`4f3e597`) |
| **Commit subject** | `docs(PRD-020): blocker resolution audit — ADR-0074 NOT required; two prior conclusions corrected` |
| **Branch** | `main` |
| **Working tree** | **clean** — `git status --porcelain` returned **0** lines |
| **Remote `github`** | `https://github.com/sittuazad05022000-spec/Liboora-.git` — ⚠ **PRIVATE**; `raw.githubusercontent.com` links 404 and must never be offered as downloads |
| **Remote parity** | ✅ **MEASURED IDENTICAL** — local `main` `4f3e5975…` ≡ `github/main` `4f3e5975…` |
| **Remote `genspark`** | `https://www.genspark.ai/sb-git/me/genspark-58d4883d-c0e3-4aa0-b60d-28b6cbe2cf56.git` — ⚠ manual mid-turn push returns `fatal: repository not found`; it is wired for **end-of-turn auto-push only** |
| **History integrity** | Linear. **No amend, no force-push, no rewrite** at any point |

⚠ **Known environment behaviour:** commits titled `genspark auto-backup` can land
**mid-turn** (e.g. `453fd80`, `708bcfa` in recent history). A future session must run
`git log --oneline -1` before assuming tree state — HEAD may not be what the last report said.

---

## 3. PRD-020 IDENTITY AND CURRENT LIFECYCLE

### 3.1 Identity — **MEASURED** from the PRD header and `PRD_REGISTRY.md`

| Property | Measured value | Source |
|---|---|---|
| Identifier | `PRD-020` | header |
| Name | Trust & Safety | header |
| Owning bounded context | **`BC-13` Trust & Safety** — `[CORE]`, Global Student, V1 | header; BC Map **L117** |
| Owned aggregate | **`ModerationCase`** — *adopted*, not invented (BC Map **L379**) | header |
| Module path | `domain/social` → context `safety`, rank **8** | `tool/module_dependencies.yaml` **L229**/**L233** |
| Requirement prefix | **`TSF-`** | header |
| Task range | **`IMPL-1400`…`1449`**, `1450`…`1499` reserved | header |
| Product version | **V1** | registry **L320** cell 5 |
| Registry status | ⛔ **`PLANNED`** | `PRD_REGISTRY.md` **L320** cell 6 — read mechanically |
| Rank | ⛔ **Unranked** | `grep -c 'PRD-020' DOCUMENTATION_BASELINE.md` = **0** |
| Document status field | **`DRAFT`** | header |
| Document version field | **v0.1** | header **L7** |

### 3.2 ⚠⚠ A CONTRADICTION THAT MUST BE REPORTED, NOT SILENTLY FIXED

The PRD's own header contains two cells that are **stale relative to the repository**:

| Header cell | Says | But the repository shows |
|---|---|---|
| **Lifecycle stage** | *"Stage 2 of 9 — Draft. Stages 3–9 **not started**"* | Stage 3, 4, 5 and 6 records **exist and pass** (§4) |
| **Version** | **v0.1** | `ADR-0065`'s `Amends` cell restates `TSF-FR-030`/`031`/`INV-007` **"→ v0.5 only"** |

⛔ **DO NOT EDIT THESE CELLS.** Two reasons, both measured:

1. The PRD's own status cell says: *"⚠ **This document confers no status on itself**"* —
   so the stale cell is **not** the operative status anyway. Status lives in
   `PRD_REGISTRY.md` (`PLANNED`) and in the separate stage records.
2. Editing a PRD's version/stage cells is an **amendment act**. It belongs to the owning
   role, not to a session doing measurement.

**Correct handling:** record the contradiction (as done here), route it, and leave it.
This is an instance of the standing rule in §14: *report contradictions instead of
silently resolving them*.

### 3.3 Lifecycle position — **MEASURED**, from the stage records and instruments

| Stage | Name | Verdict | Evidence |
|---|---|---|---|
| 1–2 | Intake / Draft | ✅ PASS | PRD exists, 226,262 B |
| **3** | Architecture alignment | ✅ **PASS** | `PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md` (10,834 B) |
| **4** | Requirements review | ✅ **PASS 6 / 6** | `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` v1.2 (16,818 B) + `..._STAGE4_AC_REQUIREMENT_MAPPING.md` (18,627 B) |
| **5** | Traceability | ✅ **PASS — conferred** | `PRD-020_STAGE5_CONFERRAL.md` (20,377 B); `..._STAGE5_TRACEABILITY_RECONCILIATION.md` v1.1 (19,878 B); instrument `prd020_stage5.py` **EXIT=0** |
| **6** | Implementation tasks | ✅ **PASS** | `PRD-020_IMPLEMENTATION_TASKS.md` (34,934 B); instrument `prd020_task_coverage.py` **EXIT=0** — 50 tasks, `1400..1449`, contiguous |
| **7** | **Freeze / rank** | ⛔ **NOT READY — BLOCKED** | **2 of 7** prerequisites unmet: **B-3** and **B-5** (§7) |
| 8 | Implementation | 🟡 **PARTIAL** | one component built (`IMPL-1410` partial, §4.5) |
| 9 | Verification | ⛔ **2 of 62** `TSF-AC-*` proven | §6.1 |

⛔ **PRD-020 is NOT `READY`. PRD-020 is NOT `FROZEN`. It is unranked `DRAFT` / `PLANNED`.**

---

## 4. COMPLETED WORK — do **not** redo unless evidence has changed

Each item below is committed. A future session that repeats these audits wastes the
turn and risks producing a *different* answer to a settled question.

### 4.1 Stage 3 — Architecture alignment · ✅ **VERIFIED PASS**
`docs/30-product/trust-safety/PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md`.
Established the binding findings the whole PRD rests on, notably:
- **`F-1`** — ⛔ **`BC-13` may not hold `tenantId`.** BC Map **L488** makes `BC-11`→`17`
  *"Global. No `tenantId`. Keyed on `PersonId`"*; `module_dependencies.yaml` **L266-267**
  bans the *symbols* `StudentRecordId` and `TenantId` in `domain/social`.
  **Consequence:** library-scoped moderation **cannot** be built in `BC-13` (→ `TSF-GAP-001`/`002`).
- **`F-3`** — `BC-13`'s only edge is the **outbound, event-only** `E-14`. Still true, unchanged.

### 4.2 Stage 4 — Requirements review · ✅ **VERIFIED PASS 6 / 6**
`..._STAGE4_REQUIREMENTS_REVIEW.md` **v1.2**. All six checks pass.

### 4.3 Stage 5 — Traceability · ✅ **VERIFIED PASS, conferred**
§2O of `TRACEABILITY_MATRIX.md` registers **400 identifiers across 9 registers**.
Instrument re-run at `4f3e597`: *"zero collisions in four directions."*
Reconciliation document raised to **v1.1**, closing B-1/B-2/B-4 (retained, not deleted).

### 4.4 Stage 6 — Implementation tasks · ✅ **VERIFIED PASS**
**50 tasks**, `IMPL-1400..1449`, contiguous, one row each, **50 of 50 trace to requirements**,
**0 minted, 0 dangling**.

### 4.5 `IMPL-1410` — ⚠ **BUILT BUT NOT COMPLETE**
Evidence record: `docs/40-implementation/trust-safety/PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md`
(22,333 B).

**What exists — MEASURED at `4f3e597`:**

| Artefact | Measurement |
|---|---|
| `lib/domain/social/messaging/enforcement_projection.dart` | **497 lines**, sha256 `bbea043ab0bb…` |
| `test/domain/social/messaging_enforcement_test.dart` | **982 lines, 26 tests, 26 passing**, sha256 `fc7caebd6ab8…` |
| `lib/domain/social/social.dart` | **75 lines** (was a 67-line stub) |
| Composition-root registration | `lib/bootstrap/di.dart` **L256-262**, `events.subscribe(kEnforcementActionTaken, …)` |

⛔ **But `IMPL-1410` is NOT complete** — see §6.4 and blocker **B-3**. The five `ADR-0065`
§7.1 items are all present; the **verification** binding them (`T-5`) is not discharged.

### 4.6 `TSF-AC-010` — ✅ **CORRECTION COMPLETE, preserved deliberately**
An earlier review recorded `TSF-AC-010` as an unmapped traceability gap. That was
**false and has been RETRACTED**. Measured cause, recorded at
`..._STAGE4_REQUIREMENTS_REVIEW.md` **L24-28** and **L106** (finding **`I-3`**):

> the gap search matched on the **criterion's** vocabulary (`reveals`, `report exists`,
> `indistinguishable`, `not-found`, `MP-GBR-22`, `disclos`) — vocabulary `TSF-FR-099`
> does not contain. The criterion **was** allocated, to `TSF-FR-126`/`139` under `IMPL-1436`.

**Outcome:** `RQ-1` **CLOSED (v1.2)** — all 32 previously-unmapped criteria mapped; Stage 4
raised to **PASS 6/6**. ⛔ **Do not "rediscover" this gap.** The retraction and its reason
are retained in-repo precisely so it is not rediscovered.

### 4.7 `TSF-GAP-003` — architecture half closed, implementation half open
See §6.4 and §8. Half-closed by `Accepted` `ADR-0065`.

### 4.8 Blocker resolution audit · ✅ **COMPLETE**
`docs/30-product/trust-safety/PRD-020_BLOCKER_RESOLUTION_AUDIT.md` (25,170 B, 366 lines).
Audited B-3/B-5/B-6/B-7 and published **two corrections** (§5.3). Created **0** ADRs,
minted **0** identifiers.

### 4.9 Tests and validation
See §13 for the full baseline. Headline: `flutter analyze` clean, **313 tests pass**,
all three PRD-020 instruments **EXIT=0**.

---

## 5. AUTHORITATIVE DECISIONS

### 5.1 `ADR-0065` — ⭐ **ACCEPTED · BINDING · MUST NOT BE REINTERPRETED**

`docs/00-governance/adr/ADR-0065-synchronous-enforcement-check-transport.md` (551 lines,
sha256 `10e23764…`).

| Field | Measured content |
|---|---|
| **Status** | ✅ **`Accepted`** — *"In force. Binding on all implementation"* |
| **Deciders** | **Architecture Owner (ARB)** |
| **Decision** | ⭐ **Option B** — the send-time check is a **LOCAL read** of an `E-14`-fed projection inside `BC-12`, with **NO new edge** |
| **Supersedes** | Nothing. *"**No `Accepted` ADR's decision text is edited, reversed or reinterpreted**"* |
| **Amends** | `PRD-020_TRUST_AND_SAFETY.md` (**unranked `DRAFT`**) → **v0.5 only** |
| **Closes** | ⭐ **The ARCHITECTURE HALF of `TSF-GAP-003`** — *"`IMPL-1410` is UNBLOCKED"* |
| **Does NOT close** | ⛔ `TSF-GAP-003`'s **implementation** half, `D-16`, `MP-RSK-02`, `TSF-AC-025`, **`T-5`**, or any `TSF-AC-*` |

**§3.6 concession — MUST be preserved verbatim in meaning:** a projection fed solely by
`E-14` **cannot** make a send fail *"even if the `E-14` event has not yet been consumed"*.
`TSF-INV-007` was therefore restated to the guarantee the architecture actually delivers —
bounded, monitored, disclosed. ⭐ **The fail-closed staleness gate is constitutive of the
approved architecture, not an optimisation of it.**

**§7.1 — the five items an implementation must contain** (all measured present, §6.3).

**§6.0 — a *conditional* conferral:** closure may be recorded *"only if the measured
implementation satisfies `TSF-FR-030`/`031`/`INV-007`."* ⚠ This is a **condition**, not a
standing grant.

### 5.2 Other Accepted decisions that bear on PRD-020

| ADR | Status | Bearing |
|---|---|---|
| `ADR-0055` | **Accepted** | Admitted **`BC-12` only** to BC Map `E-22`. §3 tested necessity **per context** and **refused `BC-11` and `BC-13`**. L12 closes *"the architecture half only"* of `FIL-GAP-012` |
| `ADR-0059` | **Accepted** | Made the four-context `E-22` list **executable in code** — the `files` port refuses any caller outside it, held by a mutation-proven architecture test |
| `ADR-0033` | **Accepted** | ⭐ **L169: *"A conferral for one act is not a standing licence."*** Binding on every authority question below |
| `ADR-0064` | **Accepted** | **L7** shows the *form* a Governance Owner conferral takes: *"direct conferral from the human principal of this engagement, in the form `ADR-0033` §7.2 records"* |
| `ADR-0012` | **Accepted** | Authorises the 9 known `app → domain/library` boundary violations (expires **2026-10-31**) — this is why the boundary checker legitimately exits 1 |
| `ADR-0013` | **Accepted** | Registers `BC-13` ownership |

### 5.3 ⭐⭐ TWO CORRECTIONS — **preserve these; they overturn earlier committed text**

Both were measured, published, and committed at `4f3e597`. A future session that reverts
to the pre-correction reading will mis-route work.

#### Correction 1 — `PRD_REGISTRY.md` **L317** governs a **different PRD**

Multiple earlier artefacts cited L317's sentence —
*"editing it is an amendment act requiring amendment authority, not a side effect of the
code landing"* — as the rule blocking **B-3**. Measured mechanically:

| Instrument | Result |
|---|---|
| `awk -F'\|' 'NR==317{print $2}'` | ⭐ **`` `PRD-017` ``** |
| `grep -c 'TSF-GAP-003'` on L317 | ⭐ **0** |
| gap the sentence names (3 occurrences on that line) | **`FIL-GAP-012`**, *"inside the **frozen** PRD"* |

`PRD-017` is **`FROZEN` at Rank 3**. `PRD-020` is **unranked `DRAFT`**. ⛔ **The rule does
not reach PRD-020.**

⚠ **Trap for a future session:** L317 *also* mentions `FIL-GAP-014` and `FIL-GAP-016` in
**different sentences** (about CFG defaults and video/audio refusal). A naive
`grep -o 'FIL-GAP-[0-9]*' | head -1` returns the wrong one. Read the **sentence**, not the line.

#### Correction 2 — **`ADR-0074` is NOT required**; the owner is the **`BC-12` owner**

Earlier text (including the `IMPL-1410` evidence record §7 act 1) asserted that recording
`TSF-GAP-003`'s closure required a new ADR by the Architecture Owner. Measured against
three independent citations in the subject PRD, that is **wrong**:

| Location | Measured text |
|---|---|
| **L698** | *"⛔ **What remains open is code, not architecture** … Owner of the remaining half: **the `BC-12` owner**. **`IMPL-1410` is UNBLOCKED and NOT complete.**"* |
| **§30.6 row 7 (L2551)** | `⛔ **Build IMPL-1410** to ADR-0065 §7.1, incl. the fail-closed staleness gate.` ⭐ `**This is what now holds READY — not a decision**` · owner `` `BC-12` owner `` · `TSF-GAP-003 (implementation half)` |
| **§24.2 (L2041-2043)** | the release gate is no longer *"is `ADR-0065` decided?"* but ⛔ *"is the check **BUILT** to `ADR-0065` §7.1?"* |

§30.6's **ADR** rows (5 and 6) are both already ✅ **DONE**; **row 7 names no ADR**.

**Why the `ADR-0055` → `ADR-0059` precedent does *not* force one:** `ADR-0059` existed
**because a question was open** — *"what makes `FIL-FR-006` enforced rather than merely
written?"* Here **`ADR-0065` §7.1 already IS the specification**. An ADR recording "the five
items exist" would contain **no decision**, and `ADR-INDEX.md` Process step 1 gates ADRs to
decisions changing *"structure, ownership, a boundary, or a platform-wide rule."*

⛔ **Writing `ADR-0074` would therefore be unlawful, not merely unauthorised.**
**MEASURED:** `docs/00-governance/adr/` holds **65** numbered ADR files; `ADR-0066`…`ADR-0074`
have **0 files each**.

### 5.4 Analysis / recommendation — **PROPOSED, binding on nobody**

Everything in the following is **measurement and analysis**, not authority:
`PRD-020_BLOCKER_RESOLUTION_AUDIT.md`, `..._STAGE5_TRACEABILITY_RECONCILIATION.md`,
`..._IMPL-1410_IMPLEMENTATION_EVIDENCE.md`, and **this handoff**.

---

## 6. CURRENT TRUST & SAFETY STATE

### 6.1 Requirements, ACs, traceability — **MEASURED**

| Register | Count |
|---|---|
| `TSF-FR-*` | **146** |
| `TSF-XC-*` | **70** |
| `TSF-AC-*` | **62** |
| `TSF-BR-*` | **41** |
| `TSF-CFG-*` | **30** |
| `TSF-INV-*` | **21** |
| `TSF-GAP-*` | **16** |
| `TSF-RSK-*` | **12** |
| `TSF-EVT-*` | **2** |
| **TOTAL** | ⭐ **400 across 9 registers** |

Instrument `prd020_traceability.py`: ✅ *"400 identifiers, all contiguous, **0 phantoms,
0 dangling**, **62/62** acceptance criteria cited."*

⛔ **Verification is a different thing from citation:** **62/62 cited**, but only
**2 of 62 proven**. Stage 9 is at **2/62**.

### 6.2 Implementation state
**Built:** the `BC-12` enforcement projection + its unit suite + DI registration (§4.5).
**Not built:** ⛔ **the message-send path itself.** MEASURED: `ensureSendAllowed` /
`evaluateSend` call sites in `lib/` **outside** the projection file = **ZERO**.

### 6.3 Projection / enforcement state — all five `ADR-0065` §7.1 items **VERIFIED**

| # | §7.1 requirement | Measured evidence | Verdict |
|---|---|---|---|
| 1 | Read model in `BC-12`, keyed by `PersonId`, fed **only** by `E-14` | class at **L203**; `Map<String,_Restriction> _restrictions` **L238-239** *"keyed on `PersonId.value` (`ID-3`). No tenant key"*; `apply` **L381** early-returns unless `eventType == kEnforcementActionTaken` (**L401**) | ✅ PRESENT |
| 2 | ⭐ **Fail-closed staleness gate** | `evaluateSend` **L287-306** refuses **three** ways: `_degraded`→`projectionDegraded`; `lag == null`→`freshnessUnestablished`; `lag > _budget`→`projectionStale`. Refusals map to `systemDependencyUnavailable` (retriable); restrictions to `forbidden` | ✅ PRESENT |
| 3 | Rebuild-from-events equivalence | `rebuildFrom` **L488-496** clears `_restrictions`, `_freshAsOf` **and** `_degraded`, then replays | ✅ PRESENT |
| 4 | ⛔ **No** `BC-12` → `BC-13` call | only import is `package:liboora_contracts/liboora_contracts.dart`; `grep 'bc_13\|bc13\|domain/safety\|trust_safety'` → no match; boundary checker reports `social` = **0** | ✅ PRESENT (verified as a **negative**) |
| 5 | Lag observability | `projectionLag` **L256**; `_observeLag` **L355**; counters **L304, L339, L423, L442, L450** | ✅ PRESENT |

Also measured: `kEnforcementStalenessBudget = 5s`, `kEnforcementStalenessCeiling = 30s`
which **throws** if exceeded (**L209-218**).

⭐ **`ADR-0065` §6.1's own instrument has materially changed:**

| Check | Then (2026-08-22, per §6.1) | Now (`4f3e597`) |
|---|---|---|
| `grep -rln 'EnforcementAction\|enforcementState\|messagingRestricted' lib/ test/ packages/` | ⭐ **EMPTY** | **4 files** |
| social domain | `social.dart` only, **67 L**, *"a stub … to hold a boundary open"* | **2 files** — `social.dart` (**75 L**) + projection (**497 L**) |
| tests | none | **982 lines / 26 tests / 26 passing** |

### 6.4 ⭐⭐ `T-5` state — ⛔ **NOT DISCHARGED.** This is the crux.

`PRD-020` **§24.2 (L2046-2047)** states the bar with **two limbs joined by "or"**:

> *"⛔ `PRD-020` **MUST NOT** be marked `READY` while the **implementation half** of
> `TSF-GAP-003` is open — that is, while **`IMPL-1410` is incomplete** **or** while any of
> the five `ADR-0065` §7.1 items is missing."*

**Limb 2 is discharged** (§6.3). **Limb 1 is NOT.** **L2464**, under a column headed
*"Scope the implementer is bound to"*, defines `IMPL-1410`'s completion as the five items
***"Verified by T-5"*** including the `TSF-AC-025` clause (b).

| `T-5` measurement | Result |
|---|---|
| `T-5`'s specified method (**L2129**) | *"**Integration + fault injection**"*; p99 ≤ 50 ms; fails closed |
| `ls integration_test/` | ⛔ **no such directory** |
| send call sites in `lib/` outside the projection | ⛔ **ZERO** |
| the test file's own **L885-889** | *"it does **not** discharge `T-5`, which PRD-020 L2129 specifies as 'Integration + fault injection'"* |
| evidence record, limit 2 | *"`T-5` … is **NOT discharged** … these are unit tests"* |

⭐ **The reasoning that must survive the context reset:** the gate is currently
unbypassable **because nothing calls it**. `TSF-FR-031`'s *"on every send"* is therefore
satisfied only **vacuously**. `SID-4.56` — *"a rule that cannot be checked SHALL be
treated as unmet"* — is the **same principle `ADR-0065` §6.1 used to keep this half open
in the first place**. Applying it consistently keeps it open now.

⛔ `TSF-FR-141` independently **forbids** recording `T-5` as passing unless clause (b) passes.

---

## 7. OPEN BLOCKERS

### B-3 — close the implementation half of `TSF-GAP-003`

| Field | Value |
|---|---|
| **Status** | ⛔ **OPEN / BLOCKED** |
| **Exact problem** | The five `ADR-0065` §7.1 items exist (✅), but **§24.2 limb 1 is unmet**: `IMPL-1410`'s completion is defined at **L2464** as those items *"Verified by `T-5`"*, and `T-5` is undischarged — **no `integration_test/`, ZERO send call sites** |
| **Owner** | ⭐ **the `BC-12` owner** — a **BUILD**, per L698 / §30.6 row 7 / §24.2. ⛔ **NOT the Architecture Owner, and NOT an ADR** |
| **Required authority** | ⭐ **NONE for the build itself** — `ADR-0065` already `Accepted` it and *"`IMPL-1410` is UNBLOCKED"*. What is missing is **work**, not permission |
| **Dependency / order** | ⛔ **Blocked behind `PRD-021`** — `T-5` needs a real send path, which is `BC-12` messaging, owned by `PRD-021` (§9) |
| **Evidence** | PRD **L686-699**, **L2041-2047**, **L2129**, **L2145**, **L2464**, **L2551**; `enforcement_projection.dart`; `messaging_enforcement_test.dart` **L885-889** |
| **Category** | 🔧 **TECHNICAL** (build + verification), with a product-sequencing dependency |

### B-5 — freeze, rank, baseline row, registry status

| Field | Value |
|---|---|
| **Status** | ⛔ **OPEN / BLOCKED** |
| **Exact problem** | Moving `PRD-020` from `PLANNED` to `FROZEN` at a rank requires: a `DOCUMENTATION_BASELINE.md` §3 row (currently **0** mentions), a `PRD_REGISTRY.md` **L320** status-cell edit, and a rank conferral |
| **Owner** | ⭐ **Governance Owner** |
| **Required authority** | ⭐ **Direct conferral from the human principal, in the `ADR-0033` §7.2 form** (see `ADR-0064` **L7** for the shape). ⛔ **No such conferral exists for PRD-020.** `ADR-0033` **L169**: *"A conferral for one act is not a standing licence"* — earlier conferrals are **spent** |
| **Dependency / order** | ⛔ **Sequence-blocked behind B-3 regardless** — §24.2 forbids `READY` while the implementation half is open |
| **Evidence** | `PRD_REGISTRY.md` **L320**; `DOCUMENTATION_BASELINE.md` §7 rules **L349-355**; `ADR-0033` **L169**; `ADR-0064` **L7** |
| **Category** | 🏛 **GOVERNANCE** |

### B-6 — `TSF-GAP-014`, the age-band accessor

| Field | Value |
|---|---|
| **Status** | ⛔ **OPEN** |
| **Exact problem** | Age-differentiated enforcement would need an age-band accessor. **No authority specifies one** |
| **Owner** | ⭐ **`BC-18` owner *with* `BC-13` owner** — **two** owners (PRD **L272-273**) |
| **Required authority** | A specifying authority that does not currently exist |
| **Dependency / order** | ⛔ **Outside V1** — §24.2.1 row 4 (**L2068**); `IMPL-1417` **withdrawn**; §24.3 already places it outside V1 |
| **Evidence** | PRD **L272-273**, **L2068**, §24.3 |
| **Category** | 🏗 **ARCHITECTURE** + 📦 **PRODUCT** (scope) |

### B-7 — the remaining `TSF-GAP-*` set

| Field | Value |
|---|---|
| **Status** | ⛔ **OPEN** (as a set) |
| **Exact problem** | `TSF-GAP-001`, `002`, `005`, `006`, `008`, `009`, `016` remain open, each for its own reason |
| **Owner** | Mixed: **Architecture Owner**, **Product Owner**, **`BC-19` owner**, **`BC-10` owner** — per-gap, see §8 |
| **Required authority** | Per-gap. `TSF-XC-051` is explicit: *"This PRD **MUST NOT** be read as selecting a route. `TSF-GAP-001` and `TSF-GAP-002` remain open and are routed to the **Architecture Owner** and **Product Owner**"* |
| **Dependency / order** | Independent of B-3/B-5 |
| **Evidence** | PRD **L466**, **L1478**, **L2083**, §29.1 |
| **Category** | 🏗 **ARCHITECTURE** / 📦 **PRODUCT** |

⭐ **`TSF-GAP-005` is open BY DESIGN.** PRD §29.1: *"⚪ **Already decided, against.**
`ADR-0055` **L114**/**L139** and `ADR-0059` **L162**/**L169** refuse this admission."*
⛔ **Closing it would require reversing two `Accepted` ADRs.** Do not treat it as a task.

### Blockers already CLOSED — retained, not deleted
**B-1, B-2, B-4** were closed during Stage 5 reconciliation (v1.1). They are retained in
`..._STAGE5_TRACEABILITY_RECONCILIATION.md` §8 so the analysis is inherited rather than rediscovered.

---

## 8. `TSF-GAP-*` INVENTORY — **MEASURED; statuses not invented**

⚠ **Method note (important for re-measurement):** the gap statuses are **distributed
across the PRD's disposition tables**, not held in one contiguous register table. A single
`grep` for a canonical register block returns nothing useful. Statuses below were read
from the disposition and §29 tables at the cited lines.

| Gap | Measured status | Owner / note | Evidence |
|---|---|---|---|
| `TSF-GAP-001` | ⛔ **OPEN** | Library-scoped moderation console; blocked by **`F-1`**/`X-05`, route undecided. **Architecture Owner + Product Owner** | **L216**, **L1478**, **L2083** |
| `TSF-GAP-002` | ⛔ **OPEN** | Same cluster as `001`; route undecided | **L216**, **L1478**, **L2083** |
| `TSF-GAP-003` | ⚠ **HALF-CLOSED** — ✅ architecture half **CLOSED** by `Accepted` `ADR-0065`; ⛔ **implementation half OPEN** | **`BC-12` owner.** *"What remains open is code, not architecture"* | **L693-699** |
| `TSF-GAP-004` | ⚪ **not re-measured this pass** — treat as **UNVERIFIED**, re-read before relying on it | — | PRD |
| `TSF-GAP-005` | ⛔ **OPEN — BY DESIGN** | ⚪ *"Already decided, against"* by `ADR-0055` L114/L139 + `ADR-0059` L162/L169. `ADR-0069` **withdrawn** | §29.1 |
| `TSF-GAP-006` | ⛔ **OPEN** | Part of the B-7 set | §29 |
| `TSF-GAP-007` | ⚪ **not re-measured this pass** — **UNVERIFIED** | — | PRD |
| `TSF-GAP-008` | ⛔ **OPEN** | *"verified library affiliation needs an `E-13`-mediated attestation that does not exist. Owner: **Architecture Owner with `BC-10` and `BC-19` owners**"*. V1 needs no attestation; `ADR-0073` **not opened** | **L466** |
| `TSF-GAP-009` | ⛔ **OPEN** | *"V1 moderates Global Student surfaces only; there is no V1 route that terminates at `BC-19`"* | §29 |
| `TSF-GAP-010` | ⚪ **not re-measured this pass** — **UNVERIFIED** | — | PRD |
| `TSF-GAP-011` | ⚪ **not re-measured this pass** — **UNVERIFIED** | — | PRD |
| `TSF-GAP-012` | ✅ **Resolved by scope reduction** — *"Recorded, not deleted, so that V2 inherits the analysis"*; band deferred to V2 (§14.4); `ADR-0067` **not opened** | ⚠ **Do not confuse with `FIL-GAP-012`**, a different register (§5.3) | **L1173**, §14.4 |
| `TSF-GAP-013` | ⚪ **not re-measured this pass** — **UNVERIFIED** | — | PRD |
| `TSF-GAP-014` | ⛔ **OPEN** — outside V1 | Age-differentiated enforcement outside V1 (§24.3); `ADR-0068` **not opened**. **`BC-18` + `BC-13` owners**. = **B-6** | **L272-273**, §24.3 |
| `TSF-GAP-015` | ⛔ **OPEN** — signals deferred to V2 | *"Four signals remain and are sufficient for V1 detection"* (§14.3.2); `ADR-0066` **not opened** | §14.3.2 |
| `TSF-GAP-016` | ⛔ **OPEN** | Part of the B-7 set | §29 |

⛔ **Total: 16 `TSF-GAP-*` identifiers exist.** Rows marked ⚪ **UNVERIFIED** were *not*
measured this pass — a future session must read them from the PRD rather than infer a
status from this table. **Inventing a status is worse than admitting it was not measured.**

---

## 9. `PRD-021` DEPENDENCY — why it is the next relevant work

### 9.1 The chain, measured end to end

1. Stage 7 needs **B-3** closed.
2. **B-3** needs **`T-5`** discharged (§24.2 limb 1, via **L2464**).
3. **`T-5`** (**L2129**) requires ***"Integration + fault injection"*** — an integration
   test exercising a **real message-send path** under injected faults.
4. ⛔ **There is no send path.** MEASURED: **ZERO** `evaluateSend`/`ensureSendAllowed`
   call sites in `lib/` outside the projection; **no `integration_test/` directory**.
5. The send path is **`BC-12` messaging**. PRD-020's request-flow diagram at **L282**
   names its owner verbatim:
   `├─> BC-12 messaging      ── send path, MUST call §10.1      (owner: PRD-021)`
   — and **L280** likewise assigns `BC-11` graph to `PRD-021`.
   ⚠ **Citation correction:** earlier text located this at "§5.4". **MEASURED:** the
   statement is the diagram at **L280-282**. Cite the line, not the section.
6. **MEASURED:** `PRD_REGISTRY.md` **L321** — `PRD-021` "Social Graph & Messaging",
   contexts **`BC-11`, `BC-12`**, `[SUPPORTING]`, V1, status ⛔ **`PLANNED`**.

⭐ **Therefore: `PRD-020` cannot reach Stage 7 until `PRD-021` leaves `PLANNED` and
specifies the send path.**

### 9.1.1 ⚠⚠ A REAL TENSION, recorded rather than resolved — **MEASURED**

The dependency in §9.1 runs **PRD-020 → PRD-021**. But the roadmap imposes a **shipping**
order in the opposite direction. PRD-020 **L166-167** quotes it:

> **L161**: *"`PRD-021` must not ship before `PRD-020`"*; **L164**: *"If `PRD-021` slips
> ahead of `PRD-020`, that is a release-blocking defect, not a schedule change."*

§24.2 (**L2051-2052**) confirms that gate *"is unchanged and still binds"*.

⛔ **These are not contradictory, and a future session must not "resolve" them by
discarding one.** They govern **different acts**:

| Constraint | Governs | Direction |
|---|---|---|
| Roadmap **L161**/**L164** (via PRD **L166-167**) | ⛔ **SHIPPING / release order** | `PRD-021` must not **ship** before `PRD-020` |
| §24.2 + **L2464** (`T-5`) | ⛔ **VERIFICATION prerequisite** | `PRD-020`'s `T-5` needs a send path **specified** by `PRD-021` |

⭐ **The reconciliation: `PRD-021` must be *specified* before `PRD-020` can be *verified*,
while `PRD-020` must be *shipped* no later than `PRD-021`.** Specification order and release
order are different orderings. ⛔ **Neither authorises PRD-020 to build the send path
itself** (§9.2), and ⛔ **neither is a licence to advance `PRD-021` without its own
authority.** A future session that believes these conflict must **report the conflict to the
Product Owner**, not pick a side.

### 9.2 ⛔ What `PRD-021` must **NOT** be replaced by

A future session under pressure to "make progress" will be tempted to build the send path
inside PRD-020's scope. **That is forbidden**, for reasons that are structural, not stylistic:

- **Ownership.** `BC-12` belongs to `PRD-021` (registry **L321**; PRD-020 **L282**). PRD-020
  owns **`BC-13`** and its aggregate `ModerationCase`.
- **PRD-020's own scope discipline.** PRD-020 built *only* the projection — the component
  `ADR-0065` Option B placed **in `BC-12`** — and stopped. Extending that into a full
  messaging feature converts a bounded implementation into scope capture.
- **It would not even work as a shortcut.** A send path written inside PRD-020 would still
  be an unspecified feature: `T-5` would be integrating against something no accepted
  specification describes, so the verification would prove nothing about the real system.
- **Identifier hygiene.** Messaging requirements would need `PRD-021` identifiers, which
  PRD-020 has no authority to mint.

⛔ **Do not implement `PRD-021` as part of a PRD-020 task.** Advancing `PRD-021` out of
`PLANNED` is itself a lifecycle act with its own owner and its own gates.

---

## 10. ⭐⭐ WHAT MUST NOT BE DONE — rejected shortcuts, recorded so they stay rejected

Each was actually considered and refused on measured grounds.

| # | ⛔ Shortcut | Why it is refused |
|---|---|---|
| 1 | **Create `ADR-0074`** | ⛔ **NOT required.** L698 / §30.6 row 7 / §24.2 all name the closing act as a **build** by the **`BC-12` owner**, *"not a decision"*. An ADR recording "the five items exist" contains **no decision**; `ADR-INDEX` Process step 1 gates ADRs to decisions changing *"structure, ownership, a boundary, or a platform-wide rule."* ⭐ **Create it only if repository evidence later establishes a genuine architectural decision requiring it** — and then on that evidence, not to unblock anything |
| 2 | **Record `T-5` as passed** | ⛔ `T-5` = *"Integration + fault injection"* (**L2129**). No `integration_test/`, **ZERO** send call sites. `TSF-FR-141` **forbids** recording it as passing unless `TSF-AC-025` clause (b) passes. The 26 unit tests **self-deny** discharging it (**L885-889**) |
| 3 | **Mark `PRD-020` `READY` or `FROZEN`** | ⛔ §24.2 forbids `READY` while the implementation half is open. Freezing is additionally a **Governance Owner** act with no conferral (B-5) |
| 4 | **Invent requirements or identifiers** | ⛔ **0 minted** across all PRD-020 work to date; instruments assert **0 phantoms, 0 dangling**. `ADR-0066`…`ADR-0074` have **0 files** — that is a *measurement*, not a reservation |
| 5 | **Reuse a spent conferral** | ⛔ `ADR-0033` **L169**: *"A conferral for one act is not a standing licence."* Earlier Governance Owner conferrals (e.g. `ADR-0064`) are **spent** and do not reach PRD-020 |
| 6 | **Move `BC-12` send-path work into PRD-020** | ⛔ `BC-12` is `PRD-021`'s (registry **L321**; PRD-020 **L282**). See §9.2 |
| 7 | **Edit `PRD_REGISTRY.md` L320 to advance status** | ⛔ Governance Owner act. Also: **L317**'s amendment rule is about **`PRD-017`** (§5.3 Correction 1) — do **not** re-cite it against PRD-020 |
| 8 | **Edit the PRD's stale "Stage 2" / "v0.1" header cells** | ⛔ Amendment act. Report the contradiction (§3.2); do not resolve it |
| 9 | **Close `TSF-GAP-005`** | ⛔ Open **by design**; closing reverses `ADR-0055` **and** `ADR-0059` |
| 10 | **"Fix" the boundary checker's exit 1** | ⛔ The 9 `app → domain/library` violations are authorised by `ADR-0012` (expires 2026-10-31). This is the **expected baseline**, not a regression |
| 11 | **"Fix" the 5 failing `docs_check` scripts** | ⛔ Known, pre-existing baseline failures unrelated to PRD-020 (§13) |
| 12 | **Re-open the `TSF-AC-010` gap** | ⛔ **RETRACTED** as a false positive with a measured cause (§4.6). Rediscovering it would be a regression |

---

## 11. NEXT LAWFUL ACTION — **MEASURED**

> ### ⭐ **`PRD-021` must leave `PLANNED`.**

**Prerequisites, in order:**

1. **Product Owner / Governance authority** to advance `PRD-021` out of `PLANNED`
   (registry **L321**). ⛔ **Not currently available in-repo.**
2. `PRD-021` specifies the `BC-12` message-send path.
3. The `BC-12` owner builds the send path and wires it to the **existing, already-built**
   `MessagingEnforcementProjection.evaluateSend`.
4. `T-5` is discharged by **integration + fault-injection** tests (**L2129**), including
   the p99 ≤ 50 ms measurement and `TSF-AC-025` clause (b).
5. **B-3** closes on measured evidence.
6. **Governance Owner conferral**, in the `ADR-0033` §7.2 form, for **B-5**.
7. Stage 7 re-measured.

⛔ **Steps 1 and 6 are authority boundaries. A session that reaches them must STOP and
report the owner and the authority required — never simulate them.**

⚠ **Sequencing caveat (§9.1.1):** advancing `PRD-021` is a *specification* act and does
**not** license shipping `PRD-021` ahead of `PRD-020` — Roadmap **L161**/**L164** bind
release order separately.

**Lawfully available *without* new authority in the meantime:** measurement, audit,
documentation, and re-validation. Nothing else on the PRD-020 critical path.

---

## 12. IMPORTANT FILE / EVIDENCE INDEX — all paths **VERIFIED to exist** at `4f3e597`

### 12.1 PRD-020 artefacts
| Path | Size | sha256 (12) |
|---|---|---|
| `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` ⭐ subject | 226,262 B | `685fb65af956` |
| `docs/30-product/trust-safety/PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md` | 10,834 B | `7560796d9b45` |
| `docs/30-product/trust-safety/PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` | 16,818 B | `337b082418b7` |
| `docs/30-product/trust-safety/PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` | 18,627 B | `e19e6448404e` |
| `docs/30-product/trust-safety/PRD-020_STAGE5_CONFERRAL.md` | 20,377 B | `444fbd7b733c` |
| `docs/30-product/trust-safety/PRD-020_STAGE5_TRACEABILITY_RECONCILIATION.md` | 19,878 B | `83e46f0b33af` |
| `docs/30-product/trust-safety/PRD-020_BLOCKER_RESOLUTION_AUDIT.md` | 25,170 B | `d9ed8ba28063` |
| `docs/40-implementation/trust-safety/PRD-020_IMPLEMENTATION_TASKS.md` | 34,934 B | `7500d26b4ece` |
| `docs/40-implementation/trust-safety/PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md` | 22,333 B | `c69e5642db96` |

### 12.2 ADRs
| Path | Bearing |
|---|---|
| `docs/00-governance/adr/ADR-0065-synchronous-enforcement-check-transport.md` ⭐ | **Accepted** — Option B; §7.1 the five items; §6.0 conditional conferral; §6.1 closure measurement |
| `docs/00-governance/adr/ADR-0055-e22-consumer-list-includes-bc-12.md` | **Accepted** — architecture half only |
| `docs/00-governance/adr/ADR-0059-e22-consumer-list-enforced-in-code.md` | **Accepted** — enforcement-in-code precedent |
| `docs/00-governance/adr/ADR-0033-*.md` | **Accepted** — **L169** spent-conferral rule |
| `docs/00-governance/adr/ADR-0064-prd-012a-security-automation-v0.8-baseline.md` | **Accepted** — **L7** conferral form |
| `docs/00-governance/adr/ADR-INDEX.md` | Status vocabulary + Process step 1 |

### 12.3 Implementation and tests
| Path | Measurement |
|---|---|
| `lib/domain/social/messaging/enforcement_projection.dart` ⭐ | **497 L**, `bbea043ab0bb` |
| `test/domain/social/messaging_enforcement_test.dart` ⭐ | **982 L / 26 tests**, `fc7caebd6ab8` |
| `lib/domain/social/social.dart` | **75 L**, `4db4310bce10` |
| `lib/bootstrap/di.dart` | **449 L**, `adaa245b7096` — registration at **L256-262** |
| ⛔ `integration_test/` | **DOES NOT EXIST** — this absence is `T-5`'s blocker |

### 12.4 Governance / lifecycle registers — ⛔ **READ-ONLY**
| Path | Key lines |
|---|---|
| `docs/00-governance/prd-ecosystem/PRD_REGISTRY.md` | **L317** = `PRD-017` row (the mis-cited rule) · **L320** PRD-020 `PLANNED` · **L321** PRD-021 `PLANNED` |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | §7 rules **L349-355**; **0** `PRD-020` mentions |
| `docs/00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md` | **L202** PRD-020 row; **L68/L69/L85/L102** Architecture Owner scope |
| `docs/00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | Stage 5 **L122-137** · Stage 6 **L139-153** · Stage 7 **L155-180** |
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | v1.20, §2O at **L1715** |
| `tool/module_dependencies.yaml` | **L229/L233** module path · **L266-267** banned symbols |
| `tool/check_module_boundaries.dart` | boundary checker |

### 12.5 PRD-020 validation instruments
| Path | Size | Result at `4f3e597` |
|---|---|---|
| `tool/docs_check/prd020_traceability.py` | 8,910 B | ✅ EXIT=0 |
| `tool/docs_check/prd020_stage5.py` | 14,095 B | ✅ EXIT=0 |
| `tool/docs_check/prd020_task_coverage.py` | 10,420 B | ✅ EXIT=0 |

---

## 13. VALIDATION BASELINE — measured at `4f3e597`

| Instrument | Result | Interpretation |
|---|---|---|
| `flutter analyze` | ✅ **No issues found** · EXIT=0 | clean |
| `flutter test` | ✅ **All 313 tests passed** · EXIT=0 | clean |
| `flutter test test/domain/social/messaging_enforcement_test.dart` | ✅ **+26 passed** | the projection suite |
| `dart run tool/check_module_boundaries.dart` | 🟡 EXIT=1 · `FAIL — 9 violation(s) in 1 category(ies)` | ⭐ **EXPECTED BASELINE** — the `ADR-0012` `app → domain/library` set (expires 2026-10-31). ⭐ **`social` = 0** |
| 28 × `tool/docs_check/*.py` | 🟡 **`TOTAL_NONZERO=5`** | ⭐ **EXPECTED BASELINE** — exactly `alignment_record_freshness.py`, `prd004_traceability.py`, `prd005_traceability.py`, `prd006_traceability.py`, `prd007_traceability.py`. **Not PRD-020 related** |
| `prd020_traceability.py` | ✅ EXIT=0 | 9 registers, 400 identifiers, contiguous, **0 phantoms, 0 dangling**, 62/62 ACs cited |
| `prd020_stage5.py` | ✅ EXIT=0 | §2O 400 identifiers / 9 registers; **zero collisions in four directions** |
| `prd020_task_coverage.py` | ✅ EXIT=0 | 50 tasks `1400..1449`, contiguous, 50/50 trace, **0 minted, 0 dangling** |
| Protected-path integrity | ✅ **0 diff lines** | `docs/00-governance/`, `docs/10-architecture/`, `tool/module_dependencies.yaml`, `tool/check_module_boundaries.dart` |
| Subject PRD integrity | ✅ **byte-unchanged** | sha256 `685fb65af956…` |

⭐ **How to read a "failure" here:** boundary EXIT=1 and `TOTAL_NONZERO=5` are the
**known-good baseline**. A future session must compare against *these numbers*, not
against zero. A drop to 4 or a rise to 6 is the signal; 5 is normal.

---

## 14. ⭐⭐ CONTINUATION INSTRUCTIONS FOR A FUTURE SESSION

1. ⭐ **Read this handoff first**, then read the artefacts in §12.1 in order.
2. ⭐ **Verify HEAD before acting.** Run `git log --oneline -1`, `git status --porcelain`,
   and `find . -name '*.tmp_edit'`. This handoff was written at **`4f3e597`**. If HEAD
   differs, **re-measure before trusting any number here** — `genspark auto-backup`
   commits land mid-turn.
3. ⭐ **Trust repository evidence over conversation text — including over this document.**
   This is a **backup**, not authority. Where it disagrees with a file, the file wins.
4. ⭐ **Do not redo completed work** (§4) unless the underlying evidence has changed.
   Re-running the three instruments is cheap and is the correct way to check.
5. ⭐⭐ **Distinguish measurement from authority.** Measuring that a condition is satisfied
   is *not* the same as being permitted to record that satisfaction. This distinction is
   the single most common failure mode on this repository.
6. ⭐⭐ **Stop at authority boundaries.** When the next step needs a Product, Architecture,
   Traceability or Governance Owner act, finish all measurement and documentation that can
   lawfully be done, then **STOP** and report the exact owner and authority required.
7. ⭐⭐ **Never invent missing authority.** Do not simulate a conferral, do not reuse a
   spent one (`ADR-0033` **L169**), and do not create an ADR merely to make progress.
8. ⭐⭐ **Report contradictions instead of silently resolving them.** §3.2 is the worked
   example: the PRD's header says "Stage 2, stages 3–9 not started" while four stage
   records exist and pass. That was **recorded and routed**, not edited away.
9. ⭐ **If an earlier conclusion is wrong, correct it *and record the correction with the
   measurement that forced it*** (§5.3 has two such corrections). Do not hide a reversal.
10. ⭐ **Preserve identifiers and terminology exactly.** `TSF-GAP-012` ≠ `FIL-GAP-012`.
    `IMPL-1410` "unblocked" ≠ "complete". "architecture half" ≠ "implementation half".
11. ⭐ **Tooling discipline that has repeatedly mattered here:**
    - `git checkout --` does **nothing** to an untracked file; mutation-test tracked files only.
    - `$?` after a pipe captures the **last** command — use `${PIPESTATUS[0]}`.
    - Assert occurrence counts **before** any string replacement.
    - Write atomically: encode → temp file → `os.replace()`.
    - When counting markdown table columns, **ignore escaped pipes** (`\|`) inside code spans.
    - ⛔ **Never reproduce a phantom identifier token in prose** — describe its position instead.
12. ⭐ **Before claiming any gate passes, re-read the gate's own text.** §24.2's two limbs
    were missed by earlier passes precisely because the first limb looked like a restatement
    of the second. It is not.

---

## 15. CHANGE HISTORY

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-24 | Created at commit **`4f3e597`** as a durable context backup. Reconstructs PRD-020 state from repository measurement: lifecycle **Stages 3/4/5/6 PASS**, **Stage 7 NOT READY** (B-3, B-5), **Stage 9 at 2/62**; registry status **`PLANNED`**, **unranked**. Records the **two corrections** (L317 governs `PRD-017`/`FIL-GAP-012`; **`ADR-0074` NOT required**, owner = **`BC-12` owner**), the **`T-5` two-limb finding** (no `integration_test/`, **ZERO** send call sites), the four open blockers with owners and required authority, the 16-gap inventory with **4 rows explicitly marked UNVERIFIED rather than guessed**, the **`PRD-021`** dependency, **12 rejected shortcuts**, the validation baseline (**boundary EXIT=1 / 9 violations** and **`TOTAL_NONZERO=5`** are the *expected* baseline), a newly-recorded **contradiction in the PRD's own header** (stale "Stage 2" and "v0.1" cells) that is **routed, not edited**, and a **citation correction** plus the **specification-order vs release-order tension** at §9.1.1 (Roadmap **L161**/**L164** vs §24.2 `T-5`), recorded rather than resolved. ⛔ **No lifecycle advancement. No status change. 0 ADRs created. 0 identifiers minted. 0 lines of code changed. No protected artefact modified.** |
