# `PRD-021A` Part A4 — Non-Existence Finding

| Field | Value |
|---|---|
| **Document** | Non-existence finding — `PRD-021A` Parts A4, A5, A6, A7 |
| **Requested act** | Verify A4's consistency with A1, A2, A3, `BC-10`, Membership, Messaging, Social Graph, Files & Media, A5, A6, A7 and the relevant ADRs |
| **Status** | ⛔ **NOT PERFORMABLE — the subject does not exist** |
| **Acts performed** | ⛔ **NONE.** **0** files authored, **0** ownership assigned |

---

## 0. Verdict

⛔ **A consistency review of Part A4 cannot be performed, because Parts A4, A5, A6 and A7 do
not exist** — not as files, not as drafts, not as stubs, anywhere in the repository.

⭐⭐ **The repository has already made this exact finding, and already corrected a document
for the opposite error.** A3 §5 (**L336**, present identically in v0.1–v0.5) records:

> ⚠ **Correction applied (P0-5).** The reviewed draft assigned ownership to *"A4 … A8"*.
> `grep -rl "Part A4" docs/` … `"Part A8"` returns **0 files each** — **those parts do not
> exist.** Worse, **two of the concerns assigned to them are already owned by V1 bounded
> contexts.** Ownership below is stated against the actual repository.

⛔ **Authoring an A4 in order to have something to verify would reproduce precisely the defect
`P0-5` corrected**, and would violate the instruction not to duplicate ownership. This record
therefore states the absence and stops.

---

## 1. The measurement

### 1.1 Files present in `docs/30-product/social-graph/`

**15 files**, and no A4:

| Part | Files |
|---|---|
| **A1** | `PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` |
| **A2** | `…_v0.3`, `v0.4`, `v0.5`, `v0.6`, `v0.7` (5 files) |
| **A3** | `…_v0.1`, `v0.2`, `v0.3`, `v0.4`, `v0.5` (5 files) |
| ⛔ **A4** | ⛔ **none** |
| ⛔ **A5, A6, A7, A8** | ⛔ **none** |
| Records | `LCF-GAP-012_DECISION_RECORD`, `OWNER_DECISION_REQUEST`, `STAGE7_BLOCKER` |

### 1.2 Repository-wide search

| Probe | Result |
|---|---|
| `find . -name "*A4*" -o -name "*A5*" -o -name "*A6*" -o -name "*A7*" -o -name "*A8*"` | ⛔ **0 results** |
| `grep -rl "Part A5" docs/` | ⛔ **0 files** |
| `grep -rl "Part A6" docs/` | ⛔ **0 files** |
| `grep -rl "Part A7" docs/` | ⛔ **0 files** |
| `grep -rl "Part A4" docs/` | **5 files** — ⭐ **all five are the `P0-5` correction itself**, quoting the string inside its own `grep` command, in A3 v0.1 **L168**, v0.2 **L184**, v0.3 **L221**, v0.4 **L265**, v0.5 **L336** |
| `grep -rl "Part A8" docs/` | **5 files** — the same five occurrences |

⭐ **The only mentions of "Part A4" in the repository are a correction stating that Part A4
does not exist.** Counting those hits as evidence of existence would be the exact
read-the-match-at-its-line failure this work has committed to avoiding.

### 1.3 What the A-series documents themselves say

| Source | Statement |
|---|---|
| A1 v0.2 **L15** | *"only after A1-A8 are all complete. **A2 has NOT been started.**"* |
| A1 v0.2 **L59** | *"finalisation occur only after Parts A1–A8 are all complete."* |
| A2 v0.7 **L18** | *"only after A1-A8 are all complete. **A3-A8 do not exist.**"* |
| A2 v0.7 **L223** | *"Lifecycle: No stage advanced. **Stage 7 freeze happens only after A1–A8 exist.**"* |

⚠ **A2 v0.7 L18 is now partially stale and is not corrected here.** It says *"A3-A8 do not
exist"*; A3 exists (v0.5, 1,253 L). That staleness is already recorded — `LCF-GAP-005` was
**CLOSED ON MEASUREMENT** at v0.7 on precisely this ground (*"A3 now exists"*). ⛔ Amending
A2's header comment is an **A2-author** act and is not performed here.

⭐ **A4–A8 remain correctly described as non-existent by every version of every part.** The
A-series consistently states that the parts are missing; the repository has never claimed
otherwise.

---

## 2. Why the requested verification is not performable

The request names twelve counterparties: A1, A2, A3, `BC-10`, Membership, Messaging, Social
Graph, Files & Media, A5, A6, A7 and the relevant ADRs. Their availability:

| Counterparty | Exists? | Basis |
|---|---|---|
| A1, A2, A3 | ✅ yes | §1.1 |
| `BC-10` Global Person Identity | ✅ yes | `BC Map` **L114**; `ADR-0011` |
| Membership | ✅ yes | `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` |
| Files & Media | ✅ yes | `PRD-017_FILE_AND_MEDIA.md` — **FROZEN + RANKED** |
| Messaging | ⚠ **context only** | `BC-12` exists in the `BC Map` (**L116**); ⛔ **no PRD exists** — `PRD-021` *"Social Graph & Messaging"* is `PLANNED`, `PRD_REGISTRY.md` **L321**, and **L546** lists `PRD-021` among the **7** `PLANNED` documents |
| Social Graph | ⚠ **context only** | `BC-11` exists (**L115**); the PRD is the same `PLANNED` `PRD-021` |
| ⛔ **A4** — *the subject* | ⛔ **NO** | §1 |
| ⛔ **A5, A6, A7** | ⛔ **NO** | §1 |

⛔ **Four of the twelve named counterparties do not exist, and one of them is the subject
itself.** A consistency check requires two documents. Here there is neither the document
under review nor three of its comparators.

⚠ **Two further counterparties exist only as bounded contexts, not as specifications.**
"Messaging" and "Social Graph" are `BC-12` and `BC-11` in the `BC Map`; the PRD that would
specify them is `PRD-021`, which is `PLANNED` and unwritten. Checking A4 against them would
mean checking a non-existent document against an unwritten one.

---

## 3. What A4's scope would be — and why that is not decidable here

The natural question is what A4 *would* have covered. It is not answerable from the
repository:

- **No part-allocation table exists.** A1 and A2 assert that *"A1–A8"* must be complete before Stage 7, but no document states what A4…A8 each contain.
- ⭐ **A3 §5 (L339–345) already redistributed the concerns an earlier draft had assigned to A4–A8**, and assigned them to parties that **actually exist**: Community access → **A1**; Library membership validity → **`BC-02`** (`BC Map` **L371**); `CommunityPost` and content lifecycle → **`BC-15`**, specified by A2; Feed retrieval → **A2**; Feed ordering/ranking → **A3**; Comments and reactions → **`BC-15`**, specified by A2; Enforcement/moderation/anti-spam → **`BC-13`**.
- ⛔ **The `P0-5` correction's second clause is the operative warning**: *"**two of the concerns assigned to them are already owned by V1 bounded contexts.**"* So the earlier draft's A4–A8 allocation was not merely vacuous — it **duplicated ownership already held by `BC-02`, `BC-13` and `BC-15`**.

⛔ **Deciding what A4 covers is a Product Owner scope act and an Architecture Owner ownership
act.** Neither is taken here. Inventing a scope for A4 would risk re-duplicating the very
ownership A3 §5 corrected.

---

## 4. What this record does **NOT** do

| Act | Owner | Verification |
|---|---|---|
| ⛔ Author Part A4, A5, A6 or A7 | **Product Owner** (scope) + part author | **0** files created under those names |
| ⛔ Decide what A4's scope would be | **Product Owner** | **0** scope decisions |
| ⛔ Assign any concern to A4…A8 | **Architecture Owner** | **0** assignments. A3 §5's corrected table is unchanged |
| ⛔ Amend A3 §5 or its `P0-5` correction | **A3 author** | A3 `6fb17cb1…` — byte-identical |
| ⛔ Amend A2 v0.7 **L18**'s now-stale *"A3-A8 do not exist"* | **A2 author** | A2 `9192a8b1…` — byte-identical. Staleness recorded in §1.3, not repaired |
| ⛔ Amend A1's *"Parts A1–A8"* precondition | **A1 author** — and A1 is **FROZEN-marked** | Untouched |
| ⛔ Alter `PRD-021`'s `PLANNED` status, or write the Messaging / Social Graph PRD | **Governance Owner** (status) + Product Owner | `PRD_REGISTRY.md` untouched |
| ⛔ Claim A4 consistency verified, or unverifiable-therefore-acceptable | — | ⛔ **Neither is claimed.** The check is **NOT PERFORMABLE** |

---

## 5. The exact next act

⛔ **The requested verification becomes available only after Part A4 exists**, which requires,
in order:

| # | Act | Owner | Available now? |
|---|---|---|---|
| 1 | Decide the A-series part allocation — what A4…A8 each cover | **Product Owner** | ⛔ **NO** — no such decision exists in the repository |
| 2 | Confirm the allocation duplicates no `BC-02` / `BC-13` / `BC-15` ownership (the `P0-5` trap) | **Architecture Owner** | ⛔ NO — step 1 |
| 3 | Author A4 | part author | ⛔ NO |
| 4 | Verify A4 against A1, A2, A3 and the existing contexts | Architecture reviewer — Stage 3 | ⛔ NO |
| 5 | Verify A4 against A5, A6, A7 | Architecture reviewer | ⛔ NO — those parts must exist first |

⚠ **Even step 4 is currently blocked for a second, independent reason:** `PRD-021A`'s Stage 3
**FAILS** on Check 2 for the parts that *do* exist — see
`PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md`. A4 would join a family that has not passed
architecture review.

⭐ **`PRD-021A` cannot reach Stage 7 while A4–A8 are absent**, on the subjects' own terms:
A2 **L223** — *"Stage 7 freeze happens only after A1–A8 exist."* That is **5** missing parts,
and it is an additional, independent bar to freeze beyond every item in `ADR-0082`.

---

## 6. Verification

| Assertion | Result |
|---|---|
| Files created under A4/A5/A6/A7/A8 names | ✅ **0** |
| A1, A2, A3 byte-identical | ✅ A2 `9192a8b1…`, A3 `6fb17cb1…` |
| `git diff docs/00-governance/` | ✅ **0 lines** |
| `git diff docs/10-architecture/` | ✅ **0 lines** |
| Ownership assignments made | ✅ **0** |
| Scope decisions taken | ✅ **0** |
| Identifiers minted | ✅ **0** |
| Frozen documents touched | ✅ **0** |

---

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-25 |
| **Base commit** | `2dca733` |
| **Determination** | ⛔ **A4 consistency review NOT PERFORMABLE — subject absent.** A4, A5, A6, A7 (and A8) do not exist; **5** parts missing against A2 **L223**'s Stage 7 precondition |
