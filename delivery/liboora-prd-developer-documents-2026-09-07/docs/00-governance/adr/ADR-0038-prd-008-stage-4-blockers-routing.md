# `ADR-0038` — `PRD-008` Stage 4: the five blockers, measured, and routed to their authorities

| Field | Value |
|---|---|
| **Status** | **`PROPOSED`** — and **deliberately not self-accepted.** Four of the five blockers require a decision that only a named authority may take (**Product Owner** ×4, **Architecture Owner** ×2, jointly on two of them). This ADR **measures**, **routes** and **recommends**; it decides nothing that is not already decided elsewhere. Accepting it myself would be the exact defect `ADR-0035` §7.1 and `ADR-0036` were written to avoid |
| **Date** | 2026-08-15 |
| **Context** | `BC-05` Fee & Collection · `PRD-008` v1.2 `DRAFT` |
| **Supersedes / amends** | **Nothing.** No ranked document is amended by this ADR |
| **Decides** | **One thing only:** that `ADR-0035` `D-3` — *authorised* on 2026-08-05 and left unexecuted — **is now executed** in `PRD_DEPENDENCY_GRAPH.md` (Rank 5, self-declared *"Derived. Non-normative."*). Everything else is routed |
| **Requires** | **Product Owner** — `FEE-GAP-001` (refund V1 scope), `FEE-GAP-004` (fee-type taxonomy), `FEE-GAP-006` (due-date offset) · **Product Owner + Architecture Owner** — `FEE-GAP-005` (correction path) · **Architecture Owner** — `FEE-GAP-002` Stage-4 remainder (`FEE-FR-028` webhook contract) |
| **Companion** | `ADR-0035` (`ACCEPTED`) · `ADR-0037` (`ACCEPTED`) · `PRD-008_ARCHITECTURE_ALIGNMENT.md` |

---

## 1. Why this ADR exists, and what it refuses to do

The request was to **resolve** `PRD-008`'s five Stage-4 blockers. I measured all five against their
authoritative sources. The finding is uncomfortable and is stated plainly:

> **Four of the five cannot be resolved by measurement, because what they lack is not evidence — it is a
> product decision that no document in this repository contains.**

That is not a failure of searching. Each of the four was searched, and the searches are reproduced in §3
with their results. A gap that asks *"is refund V1 or V2?"* or *"what is the due-date offset?"* is not
waiting for a better `grep`; it is waiting for someone with authority to choose.

**The rule that forbids me closing them.** `PRD-005` §7.4 — *"a recommendation inside an open question **is
not a decision**"*. `ADR-0031` set the precedent that a configuration row is **refused rather than
invented** when no owner has approved a range. `PRD-006` §10A.4 set the precedent that a temporal rule must
be *"not derived, inferred, or defaulted"*. And `DOCUMENTATION_BASELINE.md` §4 / `MP-CON-08`: *"a
disagreement is a **defect to be raised**, not a choice to be made."*

⛔ **What this ADR therefore does NOT do.** It does not pick a refund tier. It does not enumerate a fee-type
taxonomy. It does not invent a due-date offset, default, minimum or maximum. It does not open a `FEE-CFG-*`
register (`PRD-008` §11.3.3 refused to open one and that refusal stands). It does not authorise a correction
workflow. It creates **no** `BC-32`, no edge, no permission, no configuration identifier, no endpoint, no
schema and no `FEE-*` requirement.

---

## 2. The one thing that *was* resolvable, and it was resolved

### 2.1 `ADR-0035` `D-3` — executed

`ADR-0035`'s acceptance table records `D-3` as **✅ Authorised** by conferral of **Architecture Owner**
authority on 2026-08-05, and simultaneously as **❌ not executed**, with the reason given verbatim:

> *"a Rank 5 edit belongs in its own commit, and this ADR's *amends* row must stay **Nothing**."*

**The authority already exists. Only the execution was outstanding.** This is the one blocker-adjacent item
in the set that needed no new decision, and it is the one this ADR executes.

**What was wrong.** `PRD_DEPENDENCY_GRAPH.md` **L116** asserted
`| D-14 | PRD-008/PRD-020 | PRD-019 BC-31 Integration | API | E-25 | Both unwritten |`.
Measured at HEAD: **`E-25` is `BC-20 Billing` → `BC-31 Integration`** (BC Map **L334**), and it is the
**only** `BC-31` edge in §7 — 26 edge rows, one of which touches `BC-31`.

**A finding beyond what `D-3` stated, and it is disclosed rather than quietly folded in.** `D-3` named only
the **`PRD-008`** half of the mis-citation. Measurement shows the **`PRD-020`** half is mis-cited *on the
same evidence*: `PRD-020` owns `BC-13`, whose only edge is `E-14` → `BC-11`/`BC-12`/`BC-14`/`BC-15`. So
`E-25` belongs to **neither** cited PRD.

| Question | Answer |
|---|---|
| Did the conferral cover this? | **The defect class, yes** — a derived document asserting an edge its source does not support |
| Did it name the second instance? | **No** |
| Was the fix widened silently? | **No** — the row now states that `D-3` named one half and measurement found two |
| Was a replacement edge asserted for `PRD-020`? | ⛔ **No.** That is the **Architecture Owner**'s with the `BC-13` owner |

**`BC-05`'s replacement is a port, not an edge.** `business.payment_intent`, already declared at Dependency
Matrix **L196**, prescribed by `X-03` **L352**, tabulated by Accepted `ADR-0012` **L86**, and ratified as
`ADR-0035` `D-1`. Per `ADR-0033`, BC Map L292 *"governs edges … it does **not** state that every
cross-context read must be an edge."*

**Why editing this file is lawful.** Its own header declares it ***"Derived. Non-normative. … This document
adds no edge of its own."*** It is **not** in `DOCUMENTATION_BASELINE.md`'s baseline list (grep: 0 hits) and
**not** frozen. Removing a false citation from a derived document brings it back into agreement with its
source; it does not amend the source. Hash `db3612a6fac92021` → `7fa28a35425acdb0`.

### 2.2 What `D-3` does **not** do — stated because it is the tempting overclaim

Executing `D-3` **does not close `FEE-GAP-002` for Stage 4.** The gap's Stage-4 remainder is
**`FEE-FR-028`**, the webhook/reconciliation contract, which carries **⛔ no acceptance criterion** and
therefore fails Stage 4's *"every requirement testable"* check. `ADR-0035` §5.5b decided **who** owns the
inbound webhook; it explicitly decided **no** *"endpoint, URL, payload schema, field list, signature
algorithm, header, replay window, retry policy or gateway provider"*. **An owner is not a contract.**

---

## 3. The four that require authority — measured, with the exact unresolved question

For each: what the authoritative source actually says, what remains, and who may close it. **The
measurements are the point; the recommendations are explicitly not decisions.**

### 3.1 `FEE-GAP-001` — Is refund V1 or V2?

| | |
|---|---|
| **Exact unresolved question** | Not *"which document wins"* — that is already mechanical. It is **the scope of V1 refund** |
| **Measured** | **Rank 4** BC Map **L100** (`BC-05` *"owns … refunds"*, Release **V1**), **L374** (`RefundRecord` in `FeeLedger`, invariant `refund ≤ received`), **L422** (`fee.RefundIssued` published) · **Rank 3 FROZEN** `PRD-005` **L942** routes a live V1 flow into it (*"a refund decision by `BC-05`"*) · **Rank 6** EA **L823**/**L1409** say `(V2)` |
| **Precedence — mechanical, not a decision** | `DOCUMENTATION_BASELINE.md` §4 places BC Map at **Rank 4** and EA at **Rank 6**, *"Descriptive only. Update it to match 1–5; never the reverse"*; `MP-CON-08` (**Rank 1**) repeats it. **So the tier question is already settled against the EA: refund is V1.** |
| **What still needs a decision** | The **V1 scope**: whole-payment only or partial; who approves; whether a deposit is refundable (couples to `FEE-GAP-004`) |
| **Blocks Stage 4 because** | `FEE-FR-042` and `FEE-BR-019` carry **⛔ no acceptance criterion** — untestable requirements, Stage 4 check 1 |
| **Authority** | **Product Owner** (scope) **+ Architecture Owner** (to correct the EA per `MP-CON-08`) |
| **Recommended, NOT decided** | Confirm V1; owner-approved; **compensating entry only** (`MP-GBR-12` — financial records immutable); `refund ≤ received` per L374; **no** partial-refund arithmetic, which is proration and `MM-XC-012` places proration at **V2** |

⚠ **The trap I did not walk into.** It is tempting to record *"refund is V1"* as **resolved**, since the
precedence determination is mechanical and already written. But `FEE-FR-042`/`FEE-BR-019` need a *scope* to
be testable, and the tier alone does not supply one. **Establishing which document wins is not the same as
deciding what to build.**

### 3.2 `FEE-GAP-004` — No approved fee-type taxonomy

| | |
|---|---|
| **Exact unresolved question** | Which fee types exist in V1 — and separately, **is a deposit a liability rather than revenue?** |
| **Measured** | The gap claims *"0 matches"*. **I re-measured and the raw grep is not 0** — `admission` appears in **23** files, `registration` in **41**. **Every hit is the enrollment/admission *event*, not a fee type** (e.g. `prd-v2/01` L185 *"Enrollment, admission, parent–child relationships"*). Searching the fee-type sense (`admission fee`, `joining fee`, `registration fee`, `security deposit`) outside `PRD-008` returns **2 hits, both in `PRD-022`**, and both are `PRD-022`'s **own open question** about which collections accrue a Platform Charge — *a question, not an authority* |
| **Verdict on the gap's own claim** | **Substantively correct, imprecisely worded.** No source *approves* a taxonomy. Recorded because a claim of *"0 matches"* that is really *"0 matches in the relevant sense"* is the kind of shortcut that eventually misleads |
| **Blocks Stage 4 because** | §22.1 specifies a report **over an undefined dimension** |
| **Authority** | **Product Owner** |
| **Recommended, NOT decided** | Approve a minimal V1 list; **decide `deposit` separately** — if refundable it is a **liability, not revenue**, and would change the ledger model and couple to `FEE-GAP-001` |

### 3.3 `FEE-GAP-005` — No authorised correction path for a mis-entered obligation

| | |
|---|---|
| **Exact unresolved question** | How is a genuinely wrong `FeeDue` corrected, given `FEE-BR-005`/`FEE-INV-002` immutability? |
| **Measured** | `MP-GBR-12` forbids in-place edits and **deliberately removed** the *"except through approved workflows"* loophole. **No source authorises cancel-and-reissue.** The loophole's removal is itself evidence: the absence is **deliberate**, so it cannot be read as an oversight I may fill |
| **Blocks Stage 4 because** | Staff face an uncorrectable error; the Stage 4 gate requires conflicts *"closed or explicitly deferred with a reason and an owner"*, and an unspecified correction path is neither |
| **Authority** | **Product Owner** (policy) **+ Architecture Owner** (whether a compensating-pair model is architecturally sanctioned) |
| **Recommended, NOT decided** | `CANCELLED` + new obligation as an **audited compensating pair** with actor and reason — consistent with `MP-GBR-12` and with `BC-03`'s append-only correction model |

⚠ **Why I did not resolve this by analogy.** `BC-03` has an append-only correction model, and copying its
shape would look well-founded. But `MP-GBR-12` **specifically deleted** the approved-workflow exception for
financial records. Reasoning *"`BC-03` does it, so `BC-05` may"* would **re-insert by analogy a loophole
Rank 1 removed by intent.**

### 3.4 `FEE-GAP-006` — Due-date offset undefined

| | |
|---|---|
| **Exact unresolved question** | **The offset value/range only.** The three-concept ambiguity is already CLOSED by measurement |
| **Already closed** | **(i)** membership term end (`endDate`) is `BC-02`'s, FROZEN, `MM-FR-057` a closed formula and `MM-FR-058` a **pure function** that *"MUST NOT depend on the current clock"*; `BC-05` may not touch it (`FEE-XC-020`). **(ii)** the fee-obligation due date is **`BC-05`'s own** — `grep -ni 'due date\|dueDate'` over FROZEN `PRD-005` = **0**, so no frozen document constrains it. **(iii)** the renewal-protection window is neither, and is carried by `FEE-GAP-013`(a2) |
| **What genuinely remains** | The offset itself. `CONFIGURATION_GUIDE.md` v1.1 governs 35 parameters and **none** is a payment-due offset; its §5 requires *"a PRD amendment"* to add one. **`PRD-008` has no `FEE-CFG-*` register at all** — deliberately refused at §11.3.3 |
| **Blocks Stage 4 because** | `FEE-BR-007` carries **⛔ no acceptance criterion**; `FEE-AC-020`/`021` are not deterministically implementable |
| **Authority** | **Product Owner** (policy), with `BC-06` for calendar semantics |
| **Recommended, NOT decided** | An explicit rule with a **stated range**, expressed as an offset from a **`BC-05`-owned** anchor — **not** an adjustment to `endDate` |

⚠ **The near-miss worth recording.** `PRD-022` v0.3 ratified a **due day of the 15th** by conferral. Reusing
it here would be **a `MP-GBR-24` violation in the specification layer**: `PRD-022`'s day governs money owed
**library → LIBOORA** (`BC-20`), while this offset governs money owed **student → library** (`BC-05`), and
Rank 1 holds they *"must never share a model, a table or a metric."* **A ratified number for the wrong
counterparty is not a ratified number for this one.**

---

## 4. Stage 4 readiness — measured, and the answer is NO

Stage 4's gate (`PRD_LIFECYCLE.md` L108–L120) is **six checks**, and the gate sentence is *"conflicts closed
or explicitly deferred **with a reason and an owner**."*

| Stage 4 check | Measured at v1.2 | State |
|---|---|---|
| Every requirement testable | **4 obligations carry ⛔ no acceptance criterion**: `FEE-FR-028` (`FEE-GAP-002`), `FEE-FR-042` + `FEE-BR-019` (`FEE-GAP-001`), `FEE-BR-007` (`FEE-GAP-006`) | ⛔ **FAIL** |
| Every exclusion states what must be impossible | 22 `FEE-XC-*`, each stated as an impossibility | ✅ |
| Every configurable has a default and a range | **No `FEE-CFG-*` register exists** — refused, not omitted | ✅ *vacuously, and honestly so* |
| Every acceptance criterion maps to a requirement | 0 orphan criteria (Stage 5 script territory) | ✅ |
| No requirement restates another PRD's | `MP-GBR-24` boundary held throughout | ✅ |
| Business rules do not contradict Rank 1 | `FEE-GAP-001`'s EA conflict resolves **in Rank 4's favour**, so no Rank 1 contradiction stands | ✅ |

> ⛔ **Stage 4 MUST NOT be run.** Check 1 fails on **four** untestable obligations, and the gate's
> *"explicitly deferred with a reason and an owner"* clause **does not rescue them**: a deferral is lawful
> for a *feature*, but `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-019` and `FEE-BR-007` are **requirements this PRD
> asserts** while marking them `⛔ BLOCKED`. A PRD cannot assert an obligation and defer its testability in
> the same breath — that is precisely the *"exclusion is not a deferral"* failure the adjacent check names.
>
> **Running Stage 4 now would produce a verdict on a document whose own traceability table says four of its
> obligations cannot be verified.** The honest report is that Stage 4 is **not reachable** until at least
> `FEE-GAP-001`, `002`(Stage-4 remainder) and `006` are decided by their authorities.

**This is a change of *nothing* in the gap counts.** All five still block Stage 4. `D-3`'s execution removed
a **false citation**, not a blocker.

---

## 5. What each authority must decide, in the minimum form that unblocks Stage 4

| # | Authority | Decision needed | Unblocks |
|---|---|---|---|
| 1 | **Product Owner** | Refund V1 **scope** (the tier is already mechanical) | `FEE-FR-042`, `FEE-BR-019` → `FEE-GAP-001` |
| 2 | **Architecture Owner** | Correct EA L823/L1409 to `V1` per `MP-CON-08` | `FEE-GAP-001`'s Rank 6 conflict |
| 3 | **Product Owner** | Minimal V1 fee-type list; **deposit decided separately** | §22.1 → `FEE-GAP-004` |
| 4 | **Product Owner + Architecture Owner** | Correction path (compensating pair or otherwise) | `FEE-GAP-005` |
| 5 | **Product Owner** | Due-date offset **with a stated range**, from a `BC-05`-owned anchor | `FEE-BR-007`, `FEE-AC-020`/`021` → `FEE-GAP-006` |
| 6 | **Architecture Owner** | Webhook/reconciliation **contract** (not merely its owner) | `FEE-FR-028` → `FEE-GAP-002` Stage-4 remainder |

**Six decisions by two authorities.** None is taken here.

---

## 6. Objections to this ADR, stated before they are raised

**"You executed a Rank 5 edit — is that not a document modification you were told to avoid?"**
`PRD_DEPENDENCY_GRAPH.md` is **not frozen** and **not baseline-listed** (measured: 0 hits in
`DOCUMENTATION_BASELINE.md`). It declares itself *"Derived. Non-normative."* The edit was **authorised by
name** on 2026-08-05 and deferred only for commit hygiene. Executing an authorised correction is the
opposite of an unauthorised change — and the seven protected hashes are **unchanged**.

**"You resolved only one item out of five — is that not a failure?"**
It is the measured outcome. Four blockers need a product decision that does not exist in this repository.
**Recording them as resolved would be the failure**; producing a green Stage 4 on four untestable
obligations would be worse.

**"`FEE-GAP-001`'s precedence is mechanical — why is it still blocking?"**
Because the mechanical part answers *which document wins*, and `FEE-FR-042`/`FEE-BR-019` need *what to
build*. Distinguishing these is the whole content of §3.1.

**"Could you not have deferred the four and passed Stage 4 on the gate's deferral clause?"**
No. Deferral requires the obligation not to be asserted. These four **are** asserted and marked `⛔
BLOCKED`. §4 states this in full.

---

## 7. Verification

| Claim | Method | Result |
|---|---|---|
| 5 Stage-4 blockers | Read every gap block's own `Stage 4` field | `FEE-GAP-001`, `002`, `004`, `005`, `006` |
| 17 gaps, none deleted | Count `### \`FEE-GAP-` headings | **17** |
| 4 untestable obligations | Traceability table rows with `⛔ none` | `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-007`, `FEE-BR-019` |
| `E-25` is `BC-20` → `BC-31` | BC Map §7, 26 edge rows | **1** `BC-31` edge, source `BC-20` |
| `BC-13` has no `BC-31` edge | Same table | Only `E-14` |
| No `BC-32` | Register rows | **0**; count **31** |
| No new edge | BC Map hash | `81518f1bb251218b` **unchanged** |
| No frozen document touched | 7 sha256 + PRD-006 md5 | **unchanged** |
| No `FEE-CFG-*` opened | Register grep | **still none** |
| No checker weakened | `git diff` over `tool/` | **0 files** |
| No code | `git diff` over `lib test pubspec.yaml android web` | **0 files** |

---

## 8. Defects observed and deliberately NOT repaired

1. **`FEE-GAP-004` says *"0 matches"*** for terms that appear in 23 and 41 files respectively. The claim is
   **substantively right** (no hit is a fee type) and **imprecisely worded**. Left as written; recorded in
   §3.2, because the owner of that sentence should correct it.
2. **`FEE-GAP-002`'s `Authority` row still reads *"REQUIRES ARCHITECTURE OWNER — to ratify `D-1` … and to
   decide `D-2`"*** — both **already ratified** by the 2026-08-05 conferral. Stale, and left standing: the
   Stage-4 remainder still requires the Architecture Owner, so the row's *conclusion* holds while its
   *reasons* are spent.
3. **`FEE-GAP-002`'s `Recommended` item 4** says *"Authorise the `D-14` correction"* — now **executed**, not
   merely authorised. Left for the same reason.
4. **`PRD-008` §28.1's `(b)`/`(c)` citation defect** (`ADR-0037` §8) — still uncorrected.
5. **`D-14`'s `Status` cell still reads *"Both unwritten"*** — accurate, and untouched.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **Created `PROPOSED`.** Measures `PRD-008`'s five Stage-4 blockers against their authoritative sources and finds **four require a product decision that no repository document contains**. **Executes exactly one item — `ADR-0035` `D-3`**, authorised by conferral on 2026-08-05 and deliberately unexecuted there; `PRD_DEPENDENCY_GRAPH.md` L116's false `E-25` citation is removed, and measurement additionally shows the `PRD-020` half is mis-cited on the same evidence — **disclosed rather than silently widened**, with **no replacement edge asserted** for `PRD-020`. **`BC-05`'s route is the already-declared port `business.payment_intent`, not an edge.** **Stage 4 is measured as NOT reachable and is NOT run:** check 1 fails on **four** obligations carrying no acceptance criterion (`FEE-FR-028`, `FEE-FR-042`, `FEE-BR-019`, `FEE-BR-007`), and the gate's *"deferred with a reason and an owner"* clause does not rescue obligations the PRD **asserts** while marking them `⛔ BLOCKED`. **All five gaps still block Stage 4 and the counts do not move.** Six decisions are routed to two authorities (§5). **Nothing decided beyond `D-3`'s execution:** no refund tier, no fee-type list, no due-date offset or range, no correction workflow, no `FEE-CFG-*` register, no `BC-32`, no edge, no permission, no configuration identifier, no endpoint, no schema, no `FEE-*` requirement. `ADR-0037`, `FEE-GAP-002`(c) and the 6/6 Stage-3 alignment are **untouched**. Five pre-existing defects recorded and left standing (§8). Seven protected hashes and PRD-006's md5 verified unchanged; 0 files changed under `tool/`, `lib`, `test`, `android`, `web`, `pubspec.yaml`. |
