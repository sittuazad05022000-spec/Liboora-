# ADR-0136 — `B-6` disposition RECORDED: the implementation-documentation authentication alignment is COMPLETE, and the "stale" boundary statement is CORRECTED

| Field | Value |
|---|---|
| **ADR** | `ADR-0136` — ⭐ **next free, measured immediately before creation**: 123 ADR files, highest allocated identifier `ADR-0135`, `ADR-0136` referenced **0** times across `docs/`, `tool/`, `lib/`, `test/` and `.github/` |
| **Status** | ⭐ **Accepted** — 2026-09-11, by direct, explicit conferral of the human principal of this engagement, exercising **Governance Owner** authority, scoped to **this act and nothing else**. ⛔ The office **reverts on completion** (`ADR-0033` §7.1) |
| **Deciders** | **Governance Owner** — and **only** Governance Owner. ⭐ This act decides **nothing about product, architecture, privacy, payment, legal retention or schema**; it records a completed act and corrects a statement of **fact** that has become false |
| **Supersedes** | ⚠ **`ADR-0131` §9.3's final paragraph — IN PART and IN EFFECT ONLY.** ⛔ **`ADR-0131` is NOT edited, NOT restatused, NOT reopened and remains `Accepted` and byte-unchanged.** ⭐ Only the **factual clause** *"`DEVELOPER_HANDOFF.md` … still states … and **6** further `docs/40-implementation/` documents still cite *\"Authentication PRD v2.0\"* as their source. ⛔ **None is repaired by this act** (blocker **B-6**)"* is superseded. ⛔ **Every prohibition in `ADR-0131` §9.3's table survives UNWEAKENED** |
| **Amends** | `PRD_LIFECYCLE.md` (**v1.2 → v1.3**, the §7A.9 `AUTHENTICATION` summary row) · `ADR-INDEX.md` (registration + `Count`) · `DOCUMENTATION_BASELINE.md` (§1 Authority + §8 changelog) |
| **Amended by** | — |
| **Baseline** | ⚠ **`BASELINE-2026-09-10-C` STANDS.** §7 **rule 4**'s limb is **UNMET** — ⛔ no Rank 1–3 document changes version (`PRD_LIFECYCLE` is **unranked**; `MASTER_PRD` stays **v1.10**; BC Map stays **v1.15**; every PRD byte-unchanged) |
| **Closes** | ⭐ **`SX-03`** — the `B-6` disposition gap identified by the Stage-1 Final Readiness Audit |
| **Does NOT close** | ⛔⛔ **`Q-04`** (Legal counsel — ⛔ still not a constituted office) · ⛔⛔ **the V1 schema freeze** · ⛔ **`API-GAP-001`** · ⛔ `MP-DEP-03` · ⛔ `BLK-01`/`BLK-02` · ⛔ `TASK-D10` · ⛔ Stage-6A entry as a whole |
| **Related** | `ADR-0129` (Auth v3 — ⛔ **not reopened**) · `ADR-0131` (§9.3, superseded in part) · `ADR-0135` §8 (recorded `B-6` as *"OPEN — untouched"*) · `ADR-0057` (late-registration discipline) · `ADR-0079` §8.5 (append-not-insert) |

---

## 1. Context — what the Stage-1 exit audit actually found

The Stage-1 Final Readiness / Exit Audit examined whether any act had been **incorrectly labelled DISPOSED**. It
found the opposite defect, and this ADR exists to repair it.

`B-6` — *"`DEVELOPER_HANDOFF.md` + 6 implementation documents — still stale on authentication"* (`ADR-0131` §12
**L512**, authority *"Governance + Technical Owner"*) — **was executed**, in commit
**`a6dd2b295b3ce81a672eef8cac4dc6d1bb1f2d5b`**. It was then **never recorded in any governance document**.

⚠ Three measurements establish the gap:

| Measurement | Result |
|---|---|
| Last written `B-6` status anywhere in `docs/` | ⛔ **`ADR-0135` L367 — *"OPEN — untouched"*** |
| Documents in `docs/` stating `B-6` is done, aligned or disposed | ⛔ **0** |
| `ADR-INDEX` / `DOCUMENTATION_BASELINE` entries for `B-6` | ⛔ **0** |

⭐⭐ **The work was sound; the record was absent.** A commit message is evidence of *what happened*; it is not a
governance record, it is not indexed, it is not cited, and no future specification author reads it.

### 1.1 ⛔⛔ The consequence that makes this urgent, not cosmetic

`PRD_LIFECYCLE` **L405** — a **mandatory boundary clause** under §7A.9, binding on **every** future Technical
Specification — still reads:

> *"⚠ `DEVELOPER_HANDOFF.md` and 6 implementation documents are **stale** — prefer Auth v3.0"*

⛔ **That statement is now false.** The documents were aligned in `a6dd2b2`. A binding clause that asserts a
false fact is worse than a missing one: it instructs an author to distrust documentation that is, in the
relevant respects, now correct.

---

## 2. ⭐⭐⭐ Why an ADR is required here — and why that is NOT a claim that `B-6` needed one

⭐ **This distinction is the whole legal basis of this act, and it must not be blurred.**

**`B-6` itself correctly required no ADR.** It was a **Technical Owner** documentation-alignment act over seven
**unranked** `docs/40-implementation/` documents:

- `PRD_OWNERSHIP_MODEL` **L316 rule 3** — *"Product and Technical Owner changes need no ADR"*
- `PRD_OWNERSHIP_MODEL` **L86** — the Technical Owner owns *"Implementation, `IMPL-*` tasks, traceability"*
- `DOCUMENTATION_BASELINE` §7 **rule 1** requires an ADR only for a **Rank 1–5** change; ⛔ all seven targets are
  **unranked**

⛔ **This ADR therefore does NOT retroactively claim `B-6` was an ADR-class act, and does not retroactively
authorise it.** `B-6` was lawful when performed, on authority that already existed.

**The ADR is required for a different reason entirely.** The false statement of §1.1 exists in **two** places,
and they are not equal:

| Location | Nature | Editable? |
|---|---|---|
| **`ADR-0131` §9.3, final paragraph** (**L431–L435**) | ⭐ **AUTHORITATIVE** — `PRD_LIFECYCLE` **L398**: §7A.9 is *"summarised here and **authoritative there**"* | ⛔⛔ **NO** — `ADR-INDEX` **L206**: *"Never edit an Accepted ADR's decision text — **supersede it with a new ADR**"* |
| **`PRD_LIFECYCLE` L405** | A **summary** of the above | ✅ Yes, but it derives its force from the authoritative text |

⭐⭐ **Correcting only the summary would be the wrong repair.** It would leave the authoritative source asserting
the false fact and the summary contradicting it — manufacturing a Rank-2-versus-summary conflict where none
exists today. ⭐ **Correcting the authoritative source requires a new ADR, because `L206` permits no other
route.** Hence this record.

---

## 3. The `B-6` facts, verified from repository evidence

| Field | Verified value |
|---|---|
| **Commit** | **`a6dd2b295b3ce81a672eef8cac4dc6d1bb1f2d5b`** (`a6dd2b2`), 2026-09-11 |
| **Authority exercised** | **Technical Owner** (`PRD_OWNERSHIP_MODEL` **L86**, **L316 rule 3**) — ⛔ no new authority invented, ⛔ no standing conferral created |
| **Diffstat** | **7 files changed, 13 insertions(+), 13 deletions(-)** — ⭐ every edit **strictly in place**; line counts unchanged in all seven files |
| **Governing record aligned to** | **Authentication PRD v3.0**, `Accepted` `ADR-0129`; `DOCUMENTATION_BASELINE` **L258** (*"Authentication PRD v3.0 … (v2.0 superseded — historical, frozen)"*) |

### 3.1 The seven documents

| # | Document | Change |
|---|---|---|
| 1 | `docs/40-implementation/DEVELOPER_HANDOFF.md` | ⭐ **4 of 8** stale authentication references corrected (**L23/L24**, **L65/L67**, **L163/L164**, **L261**) |
| 2 | `docs/40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` | Successor annotation on the **primary source declaration** (**L9**) |
| 3 | `docs/40-implementation/DEFINITION_OF_DONE.md` | Successor annotation (**L204**) |
| 4 | `docs/40-implementation/IMPLEMENTATION_BLOCKER_REGISTER.md` | Successor annotation (**L111**) |
| 5 | `docs/40-implementation/IMPLEMENTATION_ROADMAP.md` | Successor annotation (**L16**) |
| 6 | `docs/40-implementation/TASK-D10-remove-demo-surfaces.md` | Successor annotation (**L259**) |
| 7 | `docs/40-implementation/TRACEABILITY_MATRIX.md` | Successor annotation (**L9**) |

⭐ The six siblings match `ADR-0131` **L432** exactly — *"**6** further `docs/40-implementation/` documents still
cite *\"Authentication PRD v2.0\"* as their source"* — derived mechanically, not chosen.

### 3.2 ⭐⭐ Four of the eight were DELIBERATELY NOT changed, and that is a finding, not an omission

⛔ `B-6` was an **alignment** act, ⛔ **not a rewrite**. Four of `DEVELOPER_HANDOFF`'s eight references are
**correct as written** and were preserved:

| Line(s) | Content | Why preserved |
|---|---|---|
| **L61** | `BC-18` owns *"credentials, sessions, devices, OTP, roles, permissions, policy decisions, consent"* | ⭐ A **byte-exact quotation** of Rank 4 BC Map **L127**, which is unchanged. ⛔ Editing it would falsify a quotation |
| **L91**/**L93**/**L96** | *"Letting the OTP reach the client"* | ⭐ Describes a **live code defect** (`TASK-D10` Surface 3, `identity.dart:323`). ⛔ Rewriting it would **erase a security finding** that exists regardless of the V1 method |
| **L191** | *"No Library event carries a credential or unmasked mobile number"* | `LIB-21.5` **verbatim** — a prohibition that over-covers still forbids nothing wrongly |
| **L213** | *"OTP auto-filled into the login field \| identity.dart:323"* | A measured **code-surface inventory** — a statement of fact |

### 3.3 ⭐ Historical records preserved as historical

⛔ **No historical evidence was rewritten to appear as though Auth v3 existed at the time.** The v2.0 citations in
the six siblings are **RETAINED for traceability** and merely **annotated** with the successor. `docs/90-archive/`
is **untouched**. Authentication PRD **v2.0** and `prd-v2/` are **byte-unchanged**.

---

## 4. Decision

### `D-1` — `B-6` is DISPOSED

⭐ **`B-6` is DISPOSED: the documentation-alignment act it named is COMPLETE**, performed at `a6dd2b2` under
Technical Owner authority, over the seven documents of §3.1.

⚠ **What "DISPOSED" means here, stated so it cannot be over-read:** the stale-authentication condition `B-6`
described **no longer obtains**. ⛔ It does **not** mean `docs/40-implementation/` is free of every defect, ⛔ it
does **not** close `TASK-D10`, `BLK-01`, `BLK-02` or `TSG-GAP-005`, and ⛔ it does **not** unblock Stage-6A entry,
which fails on other grounds (§6).

### `D-2` — the authoritative "stale" clause is superseded in part

⭐ `ADR-0131` §9.3's final paragraph is **superseded IN EFFECT and IN PART**, to the following extent and no
further:

| Clause of `ADR-0131` §9.3 final ¶ | Disposition |
|---|---|
| *"`DEVELOPER_HANDOFF.md` … still states *\"Authentication is a mobile number and a one-time code\"* (**8** stale references, **0** mentions of Google)"* | ⚠ **SUPERSEDED as a statement of present fact.** Accurate when written; ⭐ **4 of the 8 are corrected**, and Google Sign-In is now stated affirmatively. ⭐ The remaining 4 are the §3.2 set, preserved **on purpose** |
| *"**6** further `docs/40-implementation/` documents still cite *\"Authentication PRD v2.0\"* as their source"* | ⚠ **SUPERSEDED as a statement of present fact.** All six now carry the v3.0 successor annotation; ⭐ the v2.0 citation is **retained beneath it** for traceability |
| *"⛔ **None is repaired by this act** (blocker **B-6**)"* | ✅ **STILL TRUE OF `ADR-0131` ITSELF** — that act repaired nothing, correctly. ⭐ The repair happened later, at `a6dd2b2` |
| *"a specification author **MUST** prefer Auth v3.0 over any of them"* | ✅ ⭐⭐ **RETAINED, UNWEAKENED AND STILL BINDING.** Auth v3.0 remains the authority for `BC-18`; an implementation document never outranks it |

⛔⛔ **Everything else in `ADR-0131` §9.3 is UNTOUCHED** — the prohibition table (V1 mobile OTP, passwords,
email-as-identity, email recovery, Auth v4.0) and the positive requirements (Google Sign-In sole V1 method,
immutable `sub`, `AccountId`, `BC-10`-owned `PersonId`, `Unlinked`) remain **fully in force**.

### `D-3` — ⛔ what this decision explicitly is not

⛔ **Authentication v3 is NOT reopened, re-evaluated, amended or re-decided.** ⛔ No new authentication rule is
created. ⛔ `ADR-0129` is not modified. ⛔ No Auth v4.0.

---

## 5. Companion clerical act — `SX-04`, the `ADR-0129` registration

⭐ Registered in the **same commit**, per the `ADR-0057` **late-registration discipline** the index itself cites
at **L8**. ⛔ **This is clerical and required no ADR of its own**; it is recorded here only for traceability.

⚠⚠ **A correction to the Stage-1 audit's own characterisation is owed, and is made here rather than quietly
dropped.** That audit called the defect *"`ADR-0129`'s **main-table register row** is missing."* Re-measurement
shows the framing was wrong: `grep "^| \[\`ADR-0128\`\]"` returns **0** as well — ⭐ **`ADR-0115` through
`ADR-0135` are ALL registered as end-of-file addendum sections, not main-table rows.** The main `Register` table
ends at `ADR-0114`. ⭐ **The established format for this era is therefore the addendum section**, and `ADR-0129`
is registered in that form. ⛔ Adding a main-table row would have been *inconsistent with its eleven neighbours*
and would have shifted **9** live citations.

---

## 6. ⛔⛔ What remains BLOCKED — stated so this act cannot be mistaken for progress

| Item | Status after this ADR |
|---|---|
| **`Q-04`** attendance retention | ⛔⛔ **STILL OPEN.** Requires **Legal counsel**, which ⛔ **is not a constituted office** (0 of 6 roles in `PRD_OWNERSHIP_MODEL`). ⛔ **No retention period is inferred, adopted or implied here** |
| **V1 schema freeze** | ⛔⛔ **STILL BLOCKED.** `MP-DEP-07` needs **all seven** questions; six is not seven |
| **`API-GAP-001`** | ⛔ **STILL OPEN** — deprecation/sunset policy, Product + Architecture Owner |
| **Stage-6A entry** | ⛔ **STILL NOT ENTERABLE.** ⭐ This act removes blockers **`SX-03`** and **`SX-04`** only; **`SX-01`** (`Q-04`) is independently sufficient to block |

---

## 7. ⛔ What this ADR does NOT do

⛔ **No Technical Specification** drafted, named, scaffolded or placeheld · ⛔ **`TS-001` NOT allocated** · ⛔
**`docs/50-technical/` NOT created** · ⛔ **0** API, OpenAPI, endpoint, schema, SQL, migration or Supabase
artefact · ⛔ **0** code, test or tool files · ⛔⛔ **0 permission identifiers** — `AUTH-7.22` stays **CLOSED at
0**, `ADR-0043` §5.1 binding, ⛔ `ADR-0132` **not reopened** · ⛔ **0** payment decisions — `ADR-0130` cash-only
untouched, ⛔ no V2 mechanism invented · ⛔ **0** frozen PRDs modified (`PRD-008`, `PRD-019`, `PRD-022`,
`MASTER_PRD`, BC Map, Matrix, EA all byte-unchanged) · ⛔ **Authentication v3.0/v2.0 and `prd-v2/`/`prd-v3/`
byte-unchanged** · ⛔ `ADR-0129`…`ADR-0135` **byte-unchanged** · ⛔ **no legal, privacy, product, architecture or
schema decision made** · ⛔ **no `B-7` created** · ⛔ **NOT pushed**.

---

## 8. Citation cost — measured before the write

| File | Highest live citation | Placement | Shifted |
|---|---|---|---|
| `ADR-INDEX.md` | **L957** | ⭐ both registrations **APPENDED at end of file** (`ADR-0079` §8.5); **L9** `Count` edited **in place** | ⭐ **0** |
| `PRD_LIFECYCLE.md` | **L453** | **L405** edited **strictly in place** (line count unchanged); v1.3 changelog row appended **below** L453 | ⭐ **0** |
| `DOCUMENTATION_BASELINE.md` | **L383** | §8 row inserted at **L391**, below L383; §1 Authority edited **in place** | ⭐ **0** |

⚠ **A pre-existing malformation is DISCLOSED, NOT repaired:** `PRD_LIFECYCLE` §10's separator sits at **L454**,
*below* the v1.1 data row at **L453**, instead of under the header at **L452**. ⭐ Introduced by the **v1.1** act
(`024e20d`) and already disclosed by `ADR-0135`. ⛔ **The row order is not tidied** — `PRD_LIFECYCLE` **L177**
warns against exactly that class of silent edit.

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-11 | ⭐⭐ **Created and `Accepted`. `B-6` is formally DISPOSED and the now-false "stale documentation" boundary statement is CORRECTED** — under a one-act **Governance Owner** conferral; ⛔ the office **reverts on completion**. ⭐⭐⭐ **The defect repaired is the INVERSE of the one the Stage-1 audit went looking for:** it asked whether any act was *incorrectly* labelled DISPOSED, and found instead that the one act with **no** label — `B-6`, executed at **`a6dd2b2`** — was the one needing a record, while `PRD_LIFECYCLE` **L405**, a **mandatory §7A.9 boundary clause**, kept telling every future specification author that seven documents were *"stale"* when they no longer are. ⭐⭐ **THE ADR IS NOT A CLAIM THAT `B-6` NEEDED ONE:** `B-6` was lawfully performed under **Technical Owner** authority (`PRD_OWNERSHIP_MODEL` **L316 rule 3**, **L86**) over seven **unranked** documents, and §7 rule 1 reaches only **Rank 1–5**. ⭐ The ADR is required because the false clause is **authoritative inside `Accepted` `ADR-0131` §9.3** (`PRD_LIFECYCLE` **L398** — *"summarised here and **authoritative there**"*), and `ADR-INDEX` **L206** permits **no** in-place edit of an Accepted ADR — *"supersede it with a new ADR"*. ⛔ **`ADR-0131` is therefore byte-unchanged, still `Accepted`, and superseded only IN PART and IN EFFECT**, limited to two clauses of **fact**; ⭐⭐ **its entire prohibition table survives unweakened**, and *"a specification author MUST prefer Auth v3.0"* is **retained verbatim in force**. ⭐ **`B-6`'s substance, verified from evidence:** 7 files, **13 insertions / 13 deletions**, every edit **strictly in place**; **4 of 8** stale `DEVELOPER_HANDOFF` references corrected (**L23/24**, **L65/67**, **L163/164**, **L261**) and ⭐⭐ **4 DELIBERATELY PRESERVED** — **L61** is a byte-exact quotation of Rank 4 BC Map **L127** (editing it would falsify a quotation), **L91**/**L93**/**L96** describe a **live code defect** (`TASK-D10` Surface 3, `identity.dart:323`) whose erasure would delete a security finding, **L191** is `LIB-21.5` verbatim and **L213** is a measured code-surface inventory. ⭐ Six siblings annotated on the **primary source declaration only**, with v2.0 citations **RETAINED for traceability** — ⛔ **no historical record was rewritten to appear as though Auth v3 existed at the time**, and `docs/90-archive/` is untouched. ⚠⚠ **A CORRECTION TO THE AUDIT'S OWN WORDING IS MADE RATHER THAN DROPPED:** it called `ADR-0129`'s defect a missing *"main-table row"*, but `ADR-0128` has **0** such rows too — ⭐ `ADR-0115`…`ADR-0135` are **all** end-of-file addendum sections, so that **is** the established format, a main-table row would have been inconsistent with eleven neighbours, and it would have shifted **9** live citations. ⛔⛔ **NOTHING ELSE MOVES:** ⛔ **`Q-04` STILL OPEN** and ⛔ **the V1 schema freeze STILL BLOCKED** (`MP-DEP-07` needs all seven; ⛔ **no retention period inferred**, ⛔ **Legal counsel still not a constituted office**) · ⛔ **`API-GAP-001` STILL OPEN** · ⛔ **Stage-6A STILL NOT ENTERABLE** — `SX-01` alone suffices · ⛔ **no `B-7`** · ⛔ **0** Technical Specifications, `TS-001` unallocated, `docs/50-technical/` absent · ⛔ **0** API/OpenAPI/schema/SQL/migration/Supabase · ⛔ **0** code/test/tool files · ⛔⛔ **0 permission identifiers** (`AUTH-7.22` closed at 0; `ADR-0132` not reopened) · ⛔ **0** payment changes · ⛔ **0** frozen PRDs, `MASTER_PRD`, BC Map, Matrix and EA byte-unchanged · ⛔ **Auth v3.0 byte-unchanged** (blob-verified) and ⛔ **not reopened**. §7 rule 1 satisfied (ADR written **before** the amendments); ⭐ **rule 4's limb UNMET — no Rank 1–3 version change — so `BASELINE-2026-09-10-C` STANDS**. ⚠ **Citation cost measured before the write: ZERO shifted in all three amended files.** ⛔ **NOT pushed** — `github/main` remains `267f46e5c9b191da874553ffdfaf70dbfd3720cb`. |
