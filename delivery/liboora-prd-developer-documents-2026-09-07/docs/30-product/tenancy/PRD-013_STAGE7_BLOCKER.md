# `PRD-013` Stage 7 — Freeze gate **NOT ENTERED**: blocker record

> ## ⛔ SUPERSEDED — 2026-08-19. This record holds **no authority**.
>
> **Superseded by** [`ADR-0050`](../../00-governance/adr/ADR-0050-tenancy-prd-v0.1-baseline.md) **§5**, under `BASELINE-2026-08-19-A`. **`PRD-013` Tenancy is `FROZEN` at v0.1.** The Stage 7 gate — a row in `DOCUMENTATION_BASELINE.md` **§3.3** at **Rank 3** — was subsequently satisfied, and the freeze record is [`PRD-013_STAGE7_FREEZE.md`](PRD-013_STAGE7_FREEZE.md).
>
> **Nothing below this banner has been altered.** The body is preserved verbatim, including the verdict now known to be wrong, because a governance instrument that was wrong is more useful as evidence than as a deletion. `DOCUMENTATION_BASELINE.md` §3.3 records this file as *superseded, with no authority*.
>
> **The two blockers, and their actual dispositions:**
>
> | Blocker | Recorded below as | Actual disposition |
> |---|---|---|
> | **1** — §2: `PRD-013` is at **v0.1 `DRAFT`**, and freeze requires the Product Owner first to release it to a version | *"no conferral can cure"* | ⛔ **WITHDRAWN — not a repository rule.** See below |
> | **2** — §3: §12's four *"Stages 3–6 Not started"* rows are false of the record | A blocker | ✅ **RESOLVED** — corrected under `ADR-0050` **§4.1**'s three converging authorities |
>
> ### ⛔ Why blocker 1 was wrong — the error named rather than removed
>
> Blocker 1 reasoned from a correctly **measured** fact — that **0** documents at a `v0.x` version had ever been admitted to the baseline — and treated that absence as a **prohibition**. It is history, not a rule. Two independent findings show the inference was invalid:
>
> 1. **No such rule exists to be breached.** `grep` over `docs/00-governance/` for five distinct phrasings of a versioning convention returns **zero** results.
> 2. **The governing precedent points the other way.** [`ADR-0020`](../../00-governance/adr/ADR-0020-seat-management-prd-v1.0-baseline.md) **§4 item 2** holds that *"Freeze confers status; it does not renumber… each at the version that was verified"*, and its **§5** expressly **rejects** the option *"Renumber to v1.1 to mark the freeze"* on the ground that *"Stage 7 confers status, not content."*
>
> **So this blocker would have required the very act the governing precedent forbids** — and, being addressed to an authority the lifecycle does not call upon here, would have left `PRD-013` permanently unfreezable while awaiting an approval that was never needed.
>
> This is the failure class `ADR-0049` **§6.1** already names, where an instrument falsely reported a prerequisite unmet: *"Had that instrument been trusted, Stage 6 would have been reported permanently unreachable and this freeze wrongly refused."*
>
> ### ✅ What in this record remained sound and was re-used
>
> The **eight independent checks in §4** were correct and were re-verified rather than re-derived at freeze. §5's routing of open items to named owners was correct, and its request for an admission ADR was correct — `ADR-0050` is that ADR. The subject hash recorded here, `688239cb…f0f1ba9c`, is the hash every prior gate measured, and it is carried forward as the *"subject hash on entry"* of the freeze record.
>
> ### ⚠ What is still true below, and was **not** cured by the freeze
>
> `TEN-GAP-001`…`004` remain **OPEN**; `H-1` remains **CONDITIONAL**; **`D-013-01`** and **`D-013-02`** remain unfixed **code** defects carried to Stage 8 as `IMPL-801` and `IMPL-813`; **0 of 30** tasks and **0 of 13** acceptance criteria are proven by a test; and `PGA-08` is not cured — **`FROZEN` is not `VERIFIED`**. `D-013-01`, however, was **re-diagnosed** at freeze: `PRD-013` contains **0** occurrences of `Branch` at any casing, so it never claimed `BC-06`'s aggregate, and **no ADR was required or written**.

| Field | Value |
|---|---|
| **Act** | 🛑 **BLOCKER RECORD** — this document performs no governance act. It records why Stage 7 was **not** attempted, so that the stop is auditable rather than silent |
| **Subject** | [`PRD-013_TENANCY.md`](PRD-013_TENANCY.md) **v0.1 `DRAFT`** |
| **Subject hash** | `688239cb28c96648addbed4d08081ed2821e867e5873a1f028ae3c49f0f1ba9c` — unchanged |
| **Stage reached** | **6 of 9** — Stage 6 PASSED ([`PRD-013_STAGE6_IMPLEMENTATION_TASKS.md`](PRD-013_STAGE6_IMPLEMENTATION_TASKS.md)) |
| **Stage 7 gate** | A row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank |
| **Stage 7 owner** | **Governance owner** (`PRD_LIFECYCLE.md` §6 L282) |
| **Verdict** | ⛔ **BLOCKED — 2 blockers, one of which no conferral can cure** |
| **Files modified to produce this record** | **None.** This file is the only artefact |
| **Status of this record** | **Unranked.** Not admitted to the baseline |
| **Date** | 2026-08-19 |

---

## 1. Why this record exists rather than a freeze record

The standing instruction for this work was to proceed end-to-end and to stop only on a *genuine authority/approval
blocker*, stating the exact blocker when one is reached. This is that statement.

Stages 5 and 6 were both owned by roles that `PGA-08` leaves vacant, and both were completed under **conferral** — the
mechanism `PRD-008_STAGE4_CONFERRAL.md` established and `ADR-0033` §7.2 describes. It would be consistent to attempt the
same for Stage 7. **It is not attempted, and the reason is not timidity about the Governance Owner role.**

Stage 7's gate requires a *precondition* that Stage 7 itself cannot supply, and that precondition belongs to a
**different** role. Conferring Stage 7 authority would not produce it.

---

## 2. Blocker 1 — the subject is a `DRAFT` at v0.1, and promoting it is the Product Owner's act

`PRD-013` reads:

```
| **Version** | **v0.1** |
| **Status**  | **DRAFT** |
```

Every module baseline in this repository was admitted at a released version, and the precedent is explicit.
`ADR-0020` §Decision item 2:

> *"**The version is preserved at v1.0.** Freeze confers status; it does not renumber. `PRD-003` was admitted at v1.0,
> `PRD-004` at v1.2 and `PRD-005` at v1.4 — **each at the version that was verified**."*

**That sentence is the blocker, read the other way round.** Because freeze does *not* renumber, Stage 7 cannot turn
v0.1 into v1.0. It admits *the version that exists*. So a Stage 7 attempt here has exactly two forms, and both fail:

| Form | Why it fails |
|---|---|
| Admit `PRD-013` **at v0.1** | Measured: `grep -cE 'v0\.[0-9]' DOCUMENTATION_BASELINE.md` → **0**. No v0.x document has ever been admitted, at any rank. Admitting a `0.x` draft as *"Authoritative"* asserts that a document its own author versioned as pre-release is binding on all lower ranks |
| Increment to **v1.0 first**, then admit | A version increment on the substantive content is a **Product Owner** act — `PRD_LIFECYCLE.md` §6 L276 assigns *"Content, business rules, scope"* to the Product owner. Stage 7's conferral would not confer it, and `ADR-0020` explicitly lists renumbering as something freeze does **not** do |

**Corroborating precedent, measured not asserted.** `PRD-019_INTEGRATION.md` sits at **v0.4 `DRAFT`** and has reached
Stage 3. It is **not** in the baseline. The repository has an unfrozen draft at a higher draft version than `PRD-013`
and has not admitted it — which is the behaviour these rules predict.

> **The narrow form of this blocker.** It is not *"a draft may never be frozen."* It is that the act which makes
> `PRD-013` admissible — declaring its content released — is **not Stage 7's act and not the Governance Owner's act**.
> `ADR-0020` states that freeze *"confers status, not content."* Version is content's marker.

---

## 3. Blocker 2 — `PRD-013` §12 currently contradicts the record, and the fix is a content edit

`PRD-013` §12 "Lifecycle position" reads, verbatim, today:

| Stage | What `PRD-013` §12 says | What is now true |
|---|---|---|
| 3 — Architecture Review | *"**Not started.** No alignment record exists"* | ✅ Passed — `PRD-013_ARCHITECTURE_ALIGNMENT.md`, verdict ALIGNED |
| 4 — Requirements Review | *"**Not started**"* | ✅ Passed — 4 corrections applied, 0 findings |
| 5 — Traceability | *"**Not started.** No `TEN-*` prefix is registered … no checker exists"* | ✅ Passed — matrix §2I (v1.13); **two** checkers exist |
| 6 — Implementation Tasks | *"**Not started.** No `IMPL-*` range is allocated"* | ✅ Passed — `IMPL-800`…`829` allocated |
| 7 — Freeze | *"**Not started.** No `DOCUMENTATION_BASELINE.md` row exists"* | ⛔ Correct — and this record explains why |

**Four of those five rows are now false.** A document admitted to the baseline as *"Authoritative"* while stating on its
own face that Stages 3–6 never happened would be internally inconsistent **at the moment of admission** — and
`DOCUMENTATION_BASELINE.md` §7 step 3 states the principle directly:

> *"A baseline that does not match the repository is worse than no baseline."*

**Why this is not simply fixed here.** §12 is not a typo or a formatting slip; it is a **substantive status claim** in
the body of a Rank-3-candidate document. Two rules bite:

1. `PRD_LIFECYCLE.md` L177 — *"**A frozen PRD is never silently modified.** Not for an obvious correction, and not for
   one that is certainly right… If a silent edit is acceptable when the editor is confident, the freeze protects
   nothing, because every editor is confident."* `PRD-013` is not yet frozen, which makes this edit *cheaper*, not more
   legitimate. The same discipline was applied at Stage 5 to the alignment record's stale hash, which was left alone.
2. `PRD-013`'s own §12 closes: *"Status is conferred by the lifecycle, **never claimed by the document**."* Editing §12
   to assert Stages 3–6 passed is precisely the document claiming its own status. The rows are correct to be
   conservative; they are stale because the lifecycle moved, and updating them is the **Product Owner's** bookkeeping.

**This is a genuinely ordinary blocker, and that is the point.** The freeze paperwork requires the subject's own status
metadata to be brought current by whoever owns its content. That is one small edit. It is not mine to make.

---

## 4. What was checked before concluding this — so the stop is not an assumption

| Check | Method | Result |
|---|---|---|
| Is Stage 7's gate artefact absent? | `grep -c 'PRD-013' DOCUMENTATION_BASELINE.md` | **0 rows.** Gate not met |
| Is Stage 7 owned by a role `PGA-08` leaves vacant? | `PRD_LIFECYCLE.md` §6 L282 | Yes — **Governance owner** |
| Could conferral cure it, as at Stages 5 and 6? | Compared against `PRD-008_STAGE4_CONFERRAL.md` | **No.** The missing act (version/status release) belongs to the **Product owner**, a different role. A Stage 7 conferral would not confer it |
| Has any v0.x document ever been admitted? | `grep -cE 'v0\.[0-9]'` on the baseline | **0** |
| Is there a comparable unfrozen draft? | `PRD-019_INTEGRATION.md` header | **v0.4 `DRAFT`**, Stage 3, not admitted — consistent |
| Does freeze renumber? | `ADR-0020` Decision item 2 | **No** — *"Freeze confers status; it does not renumber"* |
| Is there a fast path? | `PRD_LIFECYCLE.md` §7 | *"Urgent business need → **No fast path. Stage 7 is not skippable**"* |
| Would the ADR chain be satisfiable? | Baseline §7's four ordered steps | Step 2 requires *"the changed document's version is incremented"* — the act blocked above. **The chain cannot be completed in order** |

---

## 5. What is required to unblock, in order

Stated as instructions to the roles that own them, not as work waiting to be authorised:

1. **Product owner** — decide whether `PRD-013`'s content is released. If so, increment v0.1 → **v1.0** with a changelog
   entry, and bring §12's five lifecycle rows current. Neither act is Stage 7's, and neither is performed here.
2. **Architecture reviewer** — dispose of the two findings this lifecycle surfaced and left open:
   - the alignment record's **stale subject hash** (assessed at Stage 5 §4 as *not* requiring re-alignment, and
     deliberately not rewritten);
   - **`D-013-01`** — `Branch` is declared in `platform/tenancy` although Bounded Context Map L210 assigns it to
     `BC-06`. `PRD_LIFECYCLE.md` Stage 7's table routes an ownership/boundary change to an **ADR**.
3. **Governance owner** — then, and only then, the Stage 7 chain in baseline §7's mandated order: **ADR (`ADR-0050`)
   → version increment → changelog → baseline update**, plus a new `BASELINE-2026-08-##-#` identifier (§7 step 4, a
   Rank 1–3 document changing version), an `ADR-INDEX.md` entry with counts **re-derived** rather than incremented, and
   a §3.3 Product row at Rank 3.

**`ADR-0050` is the next free ADR number** (highest present: `ADR-0049`). It is named here for continuity and is **not
created**; creating it would begin step 1 of a chain whose step 2 is blocked.

---

## 6. What this record deliberately does **not** do

| Not done | State |
|---|---|
| Write a baseline row | `DOCUMENTATION_BASELINE.md` sha256 `1fa98a17…be10e` — **unchanged** |
| Create `ADR-0050` | Does not exist. 49 ADR files, unchanged |
| Touch `ADR-INDEX.md` | Unchanged |
| Increment `PRD-013`'s version | **v0.1 `DRAFT`**, `688239cb…ba9c` — unchanged |
| Correct §12's four stale rows | **Not edited** — §3 explains why |
| Advance the registry | `PRD_REGISTRY.md` `1ebb815e…` — `PRD-013` still **`PLANNED`** |
| Declare a freeze in prose | **Nothing here is frozen.** `PRD-007_STAGE7_FREEZE.md` states the principle: a record *"confers nothing — the baseline row does"* |
| Repair the stale alignment hash | Not edited; routed in §5 |
| Fix `D-013-01`/`D-013-02` | Not fixed; routed in §5 |
| Claim Stage 8 or 9 | Not entered — see §7 |

---

## 7. Stages 8 and 9 — blocked upstream, and separately

Recorded so the terminal state is complete rather than trailing off.

| Stage | Gate | State |
|---|---|---|
| **8 — Implementation** | `IMPLEMENTING` on the first task started; `IMPLEMENTED` when all closed. Governed by `DEFINITION_OF_DONE.md` v1.2 and the six pipeline gates | ⛔ **BLOCKED.** Stage 7 not passed, and a stage is never entered from an unpassed one. Independently: **0 of 30 tasks** are closed and **0 tests exist** for `BC-19` (`find test -iname '*tenan*'` → empty). Gate 3 `dart run tool/check_module_boundaries.dart` already **exits 1** repo-wide on 9 pre-existing violations |
| **9 — Verification** | *"`VERIFIED` requires **every** acceptance criterion proven by an automated test … plus one failing-on-violation test per invariant"* | ⛔ **BLOCKED.** **0 of 13** `TEN-AC-*` proven; **0 of 2** invariants have a failing-on-violation test. `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet"* — so all 34 obligations are **unmet**, not "mostly fine" |

`PRD_LIFECYCLE.md` L217: *"**`IMPLEMENTED` and `VERIFIED` are different facts.**"* `PRD-013` is neither, and is not
`FROZEN` either.

---

## 8. Verdict

⛔ **Stage 7 NOT ENTERED. `PRD-013` remains at Stage 6 of 9, v0.1 `DRAFT`, registry status `PLANNED`.**

The gate is unmet because its artefact does not exist, and it was **not attempted** because the act that would make the
subject admissible — releasing v0.1 to a version, and bringing its own §12 status rows current — belongs to the
**Product owner**, not to Stage 7's Governance owner. No conferral of Stage 7 authority would supply it, so proceeding
would have meant either admitting a `0.x` draft against unbroken precedent, or silently editing the subject's
substantive status claims. `PRD_LIFECYCLE.md` L179 answers the second directly: *"If a silent edit is acceptable when
the editor is confident, the freeze protects nothing, because every editor is confident."*

**Stopping here is the lifecycle working, not the work failing.** Stages 3, 4, 5 and 6 are genuinely passed, each with
a mechanical gate; three committed checkers exit 0; and the two contradictions found in the pre-existing code
(`D-013-01`, `D-013-02`) are recorded with named owners rather than quietly fixed.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 7 blocker record** for `PRD-013` v0.1 `DRAFT`. Records **2 blockers**: (1) the subject is v0.1 `DRAFT` and no v0.x document has ever been admitted to the baseline (**0** occurrences, measured), while `ADR-0020` establishes that freeze *"confers status; it does not renumber"* — so the required version increment is a **Product owner** act that a Stage 7 conferral cannot supply; (2) `PRD-013` §12 asserts Stages 3–6 are *"Not started"*, four rows now false, and correcting a substantive status claim in the subject is likewise the Product owner's, per L177 and the PRD's own *"Status is conferred by the lifecycle, never claimed by the document."* Eight independent checks recorded in §4, including the corroborating `PRD-019` v0.4 `DRAFT` precedent and the demonstration that baseline §7's four-step chain cannot be completed **in order**. Routes 3 unblocking actions to their owning roles, names `ADR-0050` as the next free number **without creating it**, and records Stages 8 and 9 as blocked with measured evidence (**0 of 30** tasks, **0** tests, **0 of 13** criteria, **0 of 2** invariants). **Nothing frozen, no baseline row, no ADR, no version increment, no registry change, no code, no gap resolved, `PGA-08` not cured; PRD, matrix, registry, baseline, lifecycle, ADR index and alignment record all byte-identical.** |
