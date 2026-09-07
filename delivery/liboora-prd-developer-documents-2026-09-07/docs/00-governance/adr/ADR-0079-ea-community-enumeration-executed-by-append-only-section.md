# ADR-0079 — The EA enumeration of Community Comments and Reactions is EXECUTED by an append-only section, not by inserting lines into the capability tree

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Owner** (EA §10.5 change process; `PRD_OWNERSHIP_MODEL.md` **L85**) |
| **Supersedes** | Nothing |
| **Amends** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` → **v2.3**, by **APPEND ONLY** (a new §12 after the existing changelog, plus two in-place token edits in the header table). ⛔ **No line is inserted into the capability tree. No existing line moves.** |
| **Amended by** | — |
| **Baseline** | `DOCUMENTATION_BASELINE.md` — the EA is **Rank 6**, descriptive (`MP-CON-08`) |
| **Closes** | `LCF-GAP-013` **enumeration half** (the citation half was closed by `ADR-0076`) · `LCR-FND-013` · `ADR-0075` §8.5 **Option A** |
| **Does NOT close** | `LCF-GAP-001`, `004`–`011` · `LCR-GAP-001`, `002`, `004`, `006`, `007`, `008`, `010` · the **281 bare EA line-citations** (the *class* defect — `ADR-0075` §8.5 Option B, still open) |
| **Related** | `ADR-0075` (accepted in principle, execution blocked — **this ADR unblocks it**), `ADR-0042` (the zero-line-shift precedent), `ADR-0054` (froze `PRD-017`), `ADR-0076`, `ADR-0077`, `ADR-0078` |

> `ADR-0075` decided **correctly** that community comments and reactions belong at **V2**, and then discovered that the *edit* it prescribed would silently invalidate **175** EA line-citations across **32** files, three of them **FROZEN**. It reverted, and routed four options. This ADR executes **Option A** — the one option that requires **no** frozen file to be touched, **no** citation to be repointed, and **no** governance exemption to be granted — and proves, by measurement rather than assertion, that it shifts **zero** lines.

---

## 1. Context

`ADR-0075` §8 is the record of an authorised act that was deliberately not performed. Its §8.5 tabled four options:

| Option | Approach | Cost |
|---|---|---|
| **A** | Enumerate the capabilities in a **new section at the end** of the EA, below every cited line, cross-referenced from the tree **without inserting a line** | *"Ugly, but shifts nothing"* |
| **B** | Retire line-number citation in favour of section + node-name anchors, then insert freely | Correct long-term; **touches 32 files including frozen ones** |
| **C** | Insert the nodes **and** repoint all 175 citations atomically under a frozen-document exemption | Requires a **frozen-PRD exemption** |
| **D** | Accept the enumeration half as **permanently open** | Leaves a Rank 1 determination unrecorded |

`ADR-0075` §8.5 observes that **Option B** *"is the only one that removes the class of defect rather than an instance of it."* That remains true, and this ADR does **not** claim otherwise. But Option B is a **Governance Owner + Architecture Owner** act spanning 32 files, and Option C requires an exemption to modify **FROZEN** documents. Option A is within the Architecture Owner's sole competence, requires no exemption, and is the only option whose blast radius is **provably zero**.

Options B and C were **refused for the same reason `ADR-0075` reverted**: they modify frozen artefacts. Option D was refused because it leaves a **Rank 1** determination (`MP-SCOPE-04`) permanently unrecorded in the document whose job is to describe the platform.

---

## 2. Decision

### 2.1 The measurement that makes Option A safe

The insertion point is what matters. Measured across **all** of `docs/`, over **482** EA line-citations (including the second endpoint of every range citation such as `EA L967–973`):

| Insertion point | Citations invalidated | Files affected |
|---|---|---|
| after **L967** (inside `Community (V2)`) | **264** | **39** |
| after **L972** (`ADR-0075`'s point) | **240** | **39** |
| after **L974** | **203** | **35** |
| ⭐ after **L2405** | **0** | **0** |
| ⭐ after **L2448** (the changelog heading) | **0** | **0** |
| ⭐ at **end of file** | **0** | **0** |

⭐ **The highest EA line cited anywhere in the repository is L2404** — a single citation, in `PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md`. The EA is **2,549** lines long. Everything from **L2405 to L2549 is citation-free space**, and an append after the end of the document is therefore **provably shift-free**, not merely believed to be.

⚠ This is a *stronger* claim than `ADR-0075` §8.4's revert proof. That proof showed the EA had been restored. This shows that a **forward** edit exists which cannot break anything.

### 2.2 What is decided

1. ✅ **Community Comments** and **Community Reactions** are **V2** capabilities of the `Community` platform, owned by **`BC-15`**. This restates `ADR-0075` §2 unchanged — the determination was never in doubt, only its execution.
2. ✅ The EA records this in a **new §12 — Capability Enumeration Addenda**, appended **after** the existing §11 changelog, at the end of the document.
3. ⛔ The **capability tree at L967–973 is NOT modified.** No node is inserted, no `└──` last-child glyph moves, no line shifts. `Moderation (V3)` remains at **L972** and `Community Analytics (V3)` remains at **L973**, so every one of the 482 citations continues to resolve to the content it names.
4. ✅ Two **in-place token** edits are made in the header table: `Version` `v2.2` → `v2.3` at **L9**, and `Last Updated` at **L11**. Both replace a token **within** an existing line. ⭐ This is exactly the mechanism `ADR-0042` used (commit `58cb5f4`: `@@ -6,7 +6,7 @@` and `@@ -820,7 +820,7 @@` — token replacement in place, plus `@@ -2447,6 +2447,31 @@`, an append **below every citation**). **This ADR follows the `ADR-0042` precedent exactly, where `ADR-0075` departed from it.**
5. ✅ A **changelog entry** for `v2.3` is appended to §11, in the same position and manner as `v2.2`.

### 2.3 Why an addendum section is a legitimate way for the EA to say something

The EA is **Rank 6 and descriptive** (`MP-CON-08`, `MASTER_PRD.md` **L519**). Its authority does not derive from the *shape* of its capability tree; it derives from being an accurate description. §10.5's change process requires an ADR, a Single Owner Rule check, a version tag from §10.3, a document update and a header bump — **all five of which this ADR performs**. Nothing in §10.5 requires that a capability be expressed as a tree node rather than as a named addendum, and nothing in it authorises breaking 175 citations to achieve a preferred typography.

⚠ **The addendum is deliberately cross-referenced from nowhere inside the tree.** A cross-reference marker placed on L967–973 would be an in-place edit of a cited line — safe as to *numbering*, but it would change the content that **39 files** cite. `PRD-021A_A1` cites **EA L967** exactly. The addendum is therefore reachable via §12's own heading and via this ADR, and the tree is left completely untouched. This is the "ugly" that `ADR-0075` §8.5 predicted, and it is accepted as the price of not breaking frozen documents.

---

## 3. Consequences

### 3.1 What this closes

| Item | Before | After |
|---|---|---|
| `ADR-0075` execution | ⛔ BLOCKED | ✅ **UNBLOCKED** — performed by this ADR under Option A |
| `LCF-GAP-013` enumeration half | ⛔ OPEN | ✅ **CLOSED** — the EA now enumerates both capabilities at V2 |
| `LCR-FND-013` | ⛔ BLOCKED | ✅ **CLOSED** — the finding's subject is recorded in the EA |
| EA version | `v2.2` | **`v2.3`** |
| EA `reaction` occurrences | **0** | **≥1** (the defect `ADR-0075` §8.6 measured) |

⚠ **`ADR-0075` is NOT superseded and its Status is NOT changed by this ADR.** Its `Status` remains `ACCEPTED IN PRINCIPLE — EXECUTION BLOCKED`, because that is the true record of what happened *at the time it was written*: the act it prescribed — an insertion into the tree — is **still** blocked and will always be. What this ADR performs is a **different act** achieving the same outcome. Rewriting `ADR-0075`'s status would erase the measurement that produced this ADR, which is the most valuable thing either document contains.

### 3.2 What this does NOT close

⛔ **The class defect survives.** The EA is still cited by bare line number **281** times, and those citations are still fragile against any *future* tree insertion. This ADR proves a safe path exists **for an append**; it does not make the tree editable. `ADR-0075` §8.5 **Option B** — retiring line-number citation in favour of section + node anchors — **remains OPEN and remains the correct long-term remedy**, and is now routed to the **Governance Owner**, a role constituted in `ADR-0080`.

⚠ Every open `LCF-GAP-*` and `LCR-GAP-*` listed in the `Does NOT close` field remains open. Enumerating a capability in a Rank 6 document creates no field, no edge, no aggregate row, no permission and no configurable.

⛔ **This ADR does not advance any lifecycle stage and confers no readiness.** `PRD-021A` remains **NOT READY / NOT FROZEN**, and `PRD-021` remains gated behind `PRD-020` (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**).

### 3.3 Verification performed

| Check | Result |
|---|---|
| EA line count | 2,549 → **2,603** (all 54 new lines at or below **L2450**; ⭐ **corrected from the 2,570 this table predicted before execution** — see §3.4) |
| `Moderation (V3)` line | **L972 → L972** ✅ unchanged |
| `Community Analytics (V3)` line | **L973 → L973** ✅ unchanged |
| `Anti-Spam & Rate Limits (V1)` line | **L920 → L920** ✅ unchanged |
| `Comments (V3)` (Notes Sharing) line | **L989 → L989** ✅ unchanged |
| `Job Runtime (V2)` line — cited by **FROZEN** `PRD-017` L217 | **L1865 → L1865** ✅ unchanged |
| `DPDP Act (V2)` line — cited ×10 by the **frozen** `PRD-012a` family | **L2050 → L2050** ✅ unchanged |
| Diff hunk shape | header token in place · append at end. ⭐ **No hunk inside L12–2549** |
| Citations invalidated | **0**, verified by re-resolving all **482** against the amended file |
| FROZEN documents modified | **0** |

### 3.4 One figure in §3.3 was predicted before execution and is corrected here

⚠ **§3.3 originally declared `2,549 → 2,570` (21 new lines). The executed amendment produced `2,549 → 2,603` (54 new lines).** The figure has been corrected **to the measurement**, and the discrepancy is recorded rather than quietly overwritten, because the difference between a predicted number and a measured one is exactly the kind of drift this ADR exists to prevent.

| | Predicted | Measured | Why |
|---|---|---|---|
| New lines | 21 | **54** | The prediction counted only §12. The executed amendment also appends a **`v2.3` changelog entry** into §11 (22 lines at **L2450**), which EA **§10.5 step 4** and `DOCUMENTATION_BASELINE.md` §7 rule 2 both require. §12 itself is 32 lines. 22 + 32 = **54**. |
| Final line count | 2,570 | **2,603** | as above |

⭐ **The correction changes no conclusion.** Both insertion points — **L2450** (§11 changelog) and **L2570** (§12) — lie **below L2404**, the highest EA line cited anywhere in the repository. Re-resolving all **482** citations against the amended file yields **0** invalidated and **0** whose cited content changed. The measured diff contains exactly **four** hunks: `@@ -9 +9 @@` and `@@ -11 +11 @@` (in-place header tokens) and two pure additions at **L2450** and **L2570**. ⛔ **There is no hunk anywhere between L12 and L2449.** Lines 1–2404 are byte-identical to the pre-amendment file **except L9 and L11**, verified line by line.

---

## 4. Alternatives rejected

| Alternative | Why rejected |
|---|---|
| **Option B** — retire line-number citation | Correct in principle and **still open**, but it edits **32 files including FROZEN `PRD-017` and the `PRD-012a` family**. `PRD_LIFECYCLE.md` **L177**: *"A frozen PRD is never silently modified."* It is a Governance Owner act, not an Architecture Owner one. |
| **Option C** — insert and repoint atomically | Requires a **frozen-PRD exemption** that no one has granted, to obtain a typographic improvement. Refused on proportionality. |
| **Option D** — leave permanently open | Leaves a **Rank 1** determination (`MP-SCOPE-04`) unrecorded in the descriptive document forever, and leaves `LCF-GAP-013` and `LCR-FND-013` open for a reason that measurement shows is avoidable. |
| Insert the nodes anyway, accepting the breakage | This is precisely what `ADR-0075` did, measured, and reverted. |
| Change `ADR-0075`'s Status to `Accepted` | Would erase the record of a self-detected defect. Its §8 is the reason this ADR exists. |
| Add a cross-reference marker on L967–973 | Line-safe, but changes the **content** of lines cited by 39 files, including `EA L967` cited by `PRD-021A_A1`. |

---

## 5. Compliance with EA §10.5

| Step | Requirement | Discharged |
|---|---|---|
| 1 | Propose the change as an ADR | ✅ This document |
| 2 | Verify against the Single Owner Rule and Duplicate Resolution Matrix | ✅ `BC-15` is sole owner of `CommunityComment` and `CommunityReaction` (A2 `LCF-INV-002`); no duplicate capability exists — `grep -c -i reaction` on the pre-edit EA returned **0** |
| 3 | Assign a version tag using §10.3 | ✅ **V2** = Growth, per §10.3 (**L2422–2429**), determined by `MP-SCOPE-04` (**L92**, Rank 1) |
| 4 | Update the document and bump the header version | ✅ v2.2 → **v2.3**, by in-place token replacement |
| 5 | Register any new cross-module dependency | ✅ **None arises.** No new edge; A2's existing consumption is unchanged. `LCF-GAP-009`/`LCR-GAP-008` (BC Map §8 aggregate registration) are **separate acts and remain open** |

---

## 6. Compliance with `DOCUMENTATION_BASELINE.md` §7

| Rule | Discharged |
|---|---|
| 1 — ADR **before** the change | ✅ This ADR; the EA is Rank 6, below the Rank 1–5 threshold, and an ADR is provided regardless |
| 2 — version incremented and changelog updated in the same commit | ✅ v2.3 + §11 changelog entry, same commit |
| 3 — baseline declaration updated in the same commit | ✅ **N/A by its own terms** — §3.2's EA cell records the version, and it is updated. ⚠ See §7 |
| 4 — baseline identifier changes only on a Rank 1–3 version change | ✅ The EA is **Rank 6**; the identifier does **not** change |

---

## 7. Disclosed, not repaired

1. ⚠ **`DOCUMENTATION_BASELINE.md` §3.2 records the EA at `v2.2`.** Rule 2 requires the changed document's version to be updated in the same commit, and rule 3 requires the baseline to match the repository. The baseline cell is therefore updated to `v2.3` in this commit — **an in-place token replacement**, verified not to move any of the baseline's own cited lines.
2. ⚠ **`MASTER_PRD.md` contains 10 literal `v2.1` EA references** (`Q-A6`). Now **two** versions stale. It is **Rank 1** and is **NOT edited here**; disclosed and left routed.
3. ⚠ **The 281 bare line-citations remain.** Option B is unaffected by this ADR and remains the correct remedy.
4. ⚠ **`PRD-008`'s self-disclosed defective `EA L1409` citation** is untouched.
5. ⚠ **A2 `LCF-XC-028` cites `EA L919`**, which is stale by one line (measured **L920**). Pre-existing; unaffected by an append; disclosed and not silently fixed.

---

## 8. What this ADR does NOT do

- ⛔ Creates no bounded context, edge, event, aggregate row, permission, role or configurable.
- ⛔ Modifies no **FROZEN** document, no Rank 1–4 artefact, and no `Accepted` ADR's decision text.
- ⛔ Does not change `ADR-0075`'s Status, and does not supersede it.
- ⛔ Does not resolve any open `LCF-GAP-*` or `LCR-GAP-*` other than `LCF-GAP-013`'s enumeration half.
- ⛔ Does not advance a lifecycle stage, does not confer readiness, and does not satisfy the `PRD-020` release gate.
