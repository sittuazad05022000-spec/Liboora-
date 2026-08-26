# ADR-0075 — The EA `Community (V2)` block enumerates Community Comments and Community Reactions at **V2**

| Field | Value |
|---|---|
| **Status** | ⛔ **ACCEPTED IN PRINCIPLE — EXECUTION BLOCKED.** 2026-08-25. The **decision** in §2 stands: comments and reactions belong in the EA `Community (V2)` block at **V2**, and that is determined by Rank 1, not chosen. ⚠ **The edit in §6 was attempted, measured, and REVERTED.** Inserting two lines into the §9 capability tree shifts every subsequent line of a **2,549-line document**, invalidating **175 line-number citations across 32 files** — including **FROZEN Rank 3** `PRD-017` and `PRD-012a`. See §8. The EA is **byte-unchanged at `v2.2`**. |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 and §2.3 (L85, L102) — the role `PRD_OWNERSHIP_MODEL.md` L284 records as the *only* approving body for a Rank 1–5 document change. Authority **expressly conferred for this one decision**; per `ADR-0033` §7.1 a conferral for one act is **not** a standing licence over the Enterprise Architecture |
| **Supersedes** | — |
| **Amends** | ⛔ **NOTHING — as executed.** The EA is **byte-unchanged**, verified `sha256 bb07d1e7bf8fd0162212…`, **2,549 lines**, header **`v2.2`**, and `grep -c -i reaction` = **0**. `DOCUMENTATION_BASELINE.md` §3.2 **L139** is likewise unchanged, because §7 step 3 binds only when the document *does* change version. **The intended amendment is retained below as the specification of the blocked act, not as a record of a performed one:** `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` (**Rank 6**) — §9 capability tree, the `Community (V2)` block only: **two child nodes added**, header version bumped `v2.2` → `v2.3`, one §11 changelog entry appended. **No node removed, no node renamed, no existing version tag changed, no other block touched, no bounded context minted, no edge minted, no aggregate moved, no event minted, no invariant altered, no tenancy mode touched.** Executed, see §6 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** The Enterprise Architecture is **Rank 6**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. `ADR-0042` and `ADR-0016` record the identical exemption. §7 **step 3** is nonetheless satisfied: `DOCUMENTATION_BASELINE.md` §3.2 **L139** is updated in the **same commit** |
| **Closes** | ⛔ **NOTHING, as executed.** A gap is closed by a performed act, not an authorised one. `LCF-GAP-013`'s enumeration half and `LCR-FND-013` remain **OPEN**, now with a *named, measured and costed* blocker (§8) instead of an unanswered question — which is progress, but is not closure. **Intended, once §8 is resolved:** **`LCF-GAP-013`'s enumeration half** — the EA half of A2's raised `MP-CON-08` defect — and A3 **`LCR-FND-013`** (finding F-2, the sole architectural residue of D2). See §5 |
| **Does NOT close** | `LCF-GAP-001`, `004`–`011`, `LCF-GAP-013`'s **citation** half (that is `ADR-0076`), `LCR-GAP-001`, `002`, `004`, `006`–`010`, `LCR-FND-001`…`006` (finding F-1), or any acceptance criterion. It confers **no** readiness and **no** freeze on any `PRD-021A` part. **This ADR amends a descriptive document; it verifies no code and ships no feature** |
| **Related** | **`ADR-0042`** (the one-token Rank 6 correction precedent) · **`ADR-0061`** (Rank 3 alertability outranks a Rank 6 `V2` tag, and the EA was deliberately *not* edited — the contrast that makes this ADR's direction lawful) · `ADR-0016`, `ADR-0055` (baseline-exemption precedent) · `MASTER_PRD.md` **L92** (`MP-SCOPE-04`), **L519** (`MP-CON-08`) · BC Map **L119** (`BC-15`, V2) · EA **§10.3** (L2422–2429), **§10.5** (L2438–2445), **§11** (L2448) · A2 v0.6 `LCF-INV-002`, `LCF-FR-024`, `LCF-FR-026` · A3 v0.4 `LCR-FND-013` · `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` §4.1 |

> ⛔⛔⛔ **READ §8 FIRST. THE MIGRATION IN §6 WAS ATTEMPTED AND REVERTED.**
>
> The **decision** — that these two capabilities are `Community (V2)` children at **V2** — is sound and is
> unchanged. The **execution** is blocked by a property of the target document that §1–§7 did not measure:
> the EA is cited **by line number** 329 times across the repository, and **175 of those citations point at
> lines below the insertion point**. A two-line insertion silently converts every one of them into a wrong
> citation, in documents this ADR has no authority to touch — three of them **FROZEN**.
>
> ⭐ **§1–§7 are preserved verbatim and were not rewritten to fit the outcome.** They are the record of a
> correct decision reached on incomplete measurement. §8 is the correction. Deleting them would hide that
> the blocker was found by verification rather than by foresight — and the verification is the point.
>
> This ADR performs the **correction direction** `MP-CON-08` mandates and no other: a **Rank 6**
> descriptive document is updated to match **Rank 1** and **Rank 3**, *never the reverse*. The
> **version tag was not chosen here** — it was already determined at Rank 1 before this ADR was
> opened. What was open, and what this ADR decides, is **whether the two nodes are enumerated at
> all** and **where**.

---

## 1. Context

### 1.1 The defect, stated as a measurement

`PRD-021A` Part A2 specifies two aggregates owned by `BC-15` — `CommunityComment` and
`CommunityReaction` — together with `LCF-API-008`…`011` and `LCF-EVT-005`/`006`. A Product Owner
scope decision (recorded in `PRD-021A_LCF-GAP-012_DECISION_RECORD.md`, `LCF-GAP-012` ✅ RESOLVED)
placed both **IN SCOPE to SHIP** in this generation.

The Enterprise Architecture does not name either capability. Measured at HEAD `c563931`:

| Measurement | Result |
|---|---|
| EA `Community (V2)` block, L967–973 | 6 children: Public Communities (V2), Private Communities (V2), Community Feed (V2), Community Roles (V2), Moderation (V3), Community Analytics (V3) |
| `Comments` in the `Community` block | **absent** |
| `grep -c -i 'reaction'` across the **whole** EA | **0** — no reaction node at any version |
| The only EA `Comments` node | **L989 — `Comments (V3)`**, under **Notes Sharing** |

So two `PRD-021A` parts specify capabilities the descriptive architecture does not name.

### 1.2 Why `Comments (V3)` at L989 is **not** the answer

EA **L989** sits under the **Notes Sharing** branch, which is a different capability. Reading a
`BC-15` community capability's version off a `BC-14`-adjacent Notes Sharing node would be
inference across branches. A2 v0.5 already refused that reading explicitly, and A3
`LCR-FND-008` recorded it as a distinct observation. **This ADR adopts neither node's tag by
inheritance.**

### 1.3 The rule that forbids fixing this quietly, and fixes its direction

`MASTER_PRD.md` **L519** (`MP-CON-08`, **Rank 1**) holds that the Enterprise Architecture

> *"is nonetheless **descriptive, not prescriptive** … sits at **precedence rank 6** … the
> higher-ranked document wins and the Enterprise Architecture is updated to match — **never the
> reverse**. **A disagreement is a defect to be raised, not a choice to be made.**"*

Two consequences, and they pull in opposite directions:

1. The EA **must** be updated — it is the document that is wrong.
2. The **content** of the update is **not** a choice this ADR gets to make. It is dictated.

EA **§10.5** supplies the procedure: *"Propose the change as an **ADR**"* (step 1), *"Assign a
version tag (V1/V2/V3/Future) using 10.3"* (step 3), *"Update this document and bump the version
in the header table"* (step 4). This ADR is step 1; §6 executes steps 3–5.

---

## 2. Decision

### 2.1 What is decided

**Two child nodes are added to the EA `Community (V2)` block, both tagged `(V2)`:**

```
├── Community Comments (V2)                                ← NEW
└── Community Reactions (V2)                               ← NEW
```

The EA header version moves **`v2.2` → `v2.3`** and a `### v2.3` changelog entry is appended
to §11.

### 2.2 What was **determined** rather than decided — the version tag

⭐ **The `(V2)` tag is not this ADR's choice.** It is fixed by two higher-ranked records that
were already in force:

| Rank | Source | Statement |
|---|---|---|
| **1** | `MASTER_PRD.md` **L92** (`MP-SCOPE-04`) | places **`BC-14`** and **`BC-15`** at **V2** |
| **4** | BC Map **L119** | `BC-15` Community & Groups — Global Student — **V2** — *"Owns communities, study groups, membership of groups, community roles"* |
| **3** | A2 `LCF-INV-002` | `BC-15` is the **sole owner** of `CommunityComment` and `CommunityReaction` |

A capability owned solely by a V2 context, in a product whose Rank 1 scope register places that
context at V2, is V2. EA **§10.3** defines `V2` as **Growth**, which is the band `MP-SCOPE-04`
already assigns. Applying §10.5 step 3 therefore **reproduces** the Rank 1 determination; it does
not exercise discretion. Had this ADR assigned any other tag it would have made the EA *lead* the
PRDs, which `MP-CON-08` forbids in terms.

### 2.3 What is **not** decided

| Not decided | Why |
|---|---|
| Whether comments/reactions ship | Already decided — **Product Owner**, `LCF-GAP-012` RESOLVED. This ADR has no scope authority |
| The reaction **kind** set | A **Product Owner** act (`LCF-GAP-014`), recorded in the decision record, not here |
| Any ranking weight | A **Product Owner** value act (`LCR-DEC-008`), not an architecture act |
| `LCF-FR-026`'s citation targets | **`ADR-0076`**. Deliberately separated — a citation repoint is a different subject with a different precedent (`ADR-0015`) |
| Any BC Map row, edge, event or aggregate registration | `LCF-GAP-009` / `LCR-DEC-007` remain **OPEN**. The EA is Rank 6 and registers nothing |
| Readiness or freeze of any `PRD-021A` part | Not conferred. See §5.3 |

⛔ **No new capability is created by this edit.** The capability was created by a Rank 1 scope
decision and specified at Rank 3. This edit makes a descriptive index accurate.

---

## 3. Alternatives considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | **Leave the EA unamended and carry the gap** | This was the *correct* posture for A2 v0.5 and A3 v0.3, which had no Architecture Owner ruling. With the ruling in hand, continuing to carry it would leave a Rank 6 document knowingly contradicting Rank 1 — the state `MP-CON-08` calls a **defect** |
| 2 | **Tag the nodes `V3`, inheriting EA L989** | Cross-branch inference (§1.2), and it would contradict `MP-SCOPE-04` at **Rank 1**. It would also put A2 in breach of its own `LCF-FR-026` (*"SHALL NOT require any V3 capability"*) — manufacturing a defect in a Rank 3 draft to preserve a Rank 6 omission |
| 3 | **Amend `MASTER_PRD.md` or the BC Map instead** | Exactly the *"never the reverse"* direction `MP-CON-08` forbids. Neither is wrong; both are the authority being conformed to |
| 4 | **Add one combined `Comments & Reactions (V2)` node** | The EA tree is one node per capability; A2 specifies **two** aggregates with **two** API groups and **two** events. One node would under-describe the surface the tree exists to describe |
| 5 | **Fold this into `ADR-0076`** | Different subject, different precedent, different blast radius. `ADR-0033` §7.1 — one conferral, one act |
| 6 | **Use the `PRD_LIFECYCLE.md` fast path (L283–296)** | The fast path reaches a *"typo or broken link"*. Two **absent** nodes are neither; EA §10.5 step 1 requires an ADR |

---

## 4. Consequences

### 4.1 Positive

- The Rank 6 index stops contradicting Rank 1 and Rank 3. A reader of the EA can now see the
  capability that two `PRD-021A` parts specify.
- A3's `LCR-FND-013` — *"the sole architectural residue of D2"* — is closed at its stated cause.
- `LCF-FR-024`/`LCF-FR-025`'s V2 dependency-recording discipline now has an EA line to cite.

### 4.2 Negative / accepted costs

- ⚠ **The EA version citation drift worsens, and is disclosed rather than absorbed.**
  `MASTER_PRD.md` (**Rank 1**) contains **10** literal `v2.1` references to the EA. Moving the EA
  to `v2.3` widens that gap. **`MASTER_PRD.md` is deliberately NOT edited**:
  `DOCUMENTATION_BASELINE.md` **L139** already routes this as **`Q-A6`** and records that
  *"Editing Rank 1 as a side effect of a Rank 6 version bump is the silent amendment §7 step 1 and
  `PRD_LIFECYCLE.md` L177 forbid."* The drift is **pre-existing**, is **not caused** by this ADR,
  and remains routed to the Architecture Owner as `Q-A6`.
- ⚠ **`DOCUMENTATION_BASELINE.md` L139's own count is stale.** It records **7** `v2.1`
  occurrences in `MASTER_PRD.md`; the measured figure is **10**. Disclosed here; **not silently
  corrected**, because the cell's count is part of the `Q-A6` record it belongs to.
- The two new nodes have **no** BC Map §8 aggregate row (`LCF-GAP-009`). A Rank 6 node does not
  create a Rank 4 registration, and this ADR does not pretend otherwise.

### 4.3 Neutral

- No code, test, manifest or gate is affected. The EA is not machine-read by any checker.

---

## 5. What this closes, precisely

### 5.1 Closed

| Item | Basis |
|---|---|
| **`LCR-FND-013`** (A3 finding F-2, EA-enumeration residue) | Its stated residue was *"purely the EA enumeration"*. Enumerated |
| The **enumeration half** of the `MP-CON-08` defect A2 §34 raised | The nodes exist, at the determined tag |

### 5.2 Explicitly left open

`LCF-GAP-001`, `LCF-GAP-004`…`011`, the **citation half** of `LCF-GAP-013` (→ `ADR-0076`),
`LCR-GAP-001`, `002`, `004`, `006`…`010`, `LCR-FND-001`…`006` (finding F-1, the unregistered
`BC-15 → BC-11` edge), and every `LCR-DEC-*` other than those closed by their own owners.

### 5.3 ⛔ No readiness, no freeze

This ADR confers **no** stage advance on `PRD-021A`. `PRODUCT_IMPLEMENTATION_ROADMAP.md`
**L161–164** holds that *"`PRD-021` must not ship before `PRD-020`"* and calls a violation
*"a release-blocking defect, not a schedule change."* `PRD-020` is unranked `DRAFT`. A2 and A3
therefore remain **NOT READY — NOT FROZEN**, and this ADR does not touch that.

---

## 6. Migration — executed

Per EA §10.5:

| §10.5 step | Action | State |
|---|---|---|
| 1 — Propose as an ADR | This document | ✅ |
| 2 — Single Owner Rule / Duplicate Resolution Matrix (EA §3) | `BC-15` is the sole owner (A2 `LCF-INV-002`); no second context claims either capability; no duplicate created | ✅ |
| 3 — Assign a version tag using §10.3 | **`V2`** — reproduced from `MP-SCOPE-04` (Rank 1), not chosen | ✅ |
| 4 — Update the document and bump the header version | Two nodes added under `Community (V2)`; header `v2.2` → `v2.3`; `### v2.3` entry appended to §11 | ✅ |
| 5 — Register any new cross-module dependency | ⛔ **None to register.** This edit adds no dependency: `BC-15` already owns both aggregates, and no new edge is implied. The **pre-existing** unregistered `BC-15 → BC-11` consumption stays open as `LCR-FND-001`…`006` / `LCF-GAP-009` and is **not** smuggled in here | ✅ (nil return, stated) |

Same commit, per `DOCUMENTATION_BASELINE.md` §7 steps 2–3: the EA changelog is updated and
`DOCUMENTATION_BASELINE.md` §3.2 **L139** is moved to `v2.3`. Per §7 step 4 the **baseline
identifier does not advance**.

---

## 7. Compliance record

| Check | Result |
|---|---|
| Direction of correction | ✅ Rank 6 follows Rank 1. **Never the reverse** (`MP-CON-08`) |
| Version tag invented? | ✅ **No** — determined at Rank 1 (`MP-SCOPE-04`) and reproduced |
| Bounded context minted? | ✅ No — `BC-15` already exists at BC Map L119 |
| Edge / event / aggregate / permission / configurable minted? | ✅ No — none |
| Rank 1–4 document amended? | ✅ **No.** `MASTER_PRD.md`, the BC Map, the Dependency Matrix and `ARCHITECTURE_RULINGS.md` are **byte-unchanged** |
| Frozen artefact touched? | ✅ No — `PRD-017`, `PRD-023`, `PRD-014`, `PRD-016`, `PRD-013`, `PRD-012a`, `PRD-008` all byte-unchanged |
| Accepted ADR's decision text edited? | ✅ No — `ADR-0042` and `ADR-0061` were read as authority and left byte-unchanged |
| Baseline identifier advanced? | ✅ No — Rank 6 exemption, `ADR-0042`/`ADR-0016` precedent |
| Pre-existing defect search performed? | ✅ Performed, and it did **NOT** return empty — see §4.2 (`Q-A6`, 10 vs 7 `v2.1` occurrences). Both **disclosed, neither repaired** |
| Readiness / freeze claimed? | ✅ **No** — §5.3 |

---

## 8. ⛔ EXECUTION BLOCKER — discovered on verification, after the edit was applied

### 8.1 What was done, and what it broke

The §6 migration **was applied in full**: two nodes inserted after `Community Roles (V2)`, header `v2.2` →
`v2.3`, `Last Updated` moved to `2026-08-25`, and a `### v2.3` entry appended to §11. The tree glyphs were
byte-matched with `cat -A` beforehand, and the `V3` pair was deliberately kept as the block tail so the
last-child glyph `└──` did not have to move. **The edit was mechanically correct and still wrong.**

Post-edit verification measured the consequence:

| Measurement | Before | After | Effect |
|---|---|---|---|
| EA total lines | 2,549 | 2,579 | +30 (2 tree nodes + 28 changelog) |
| `Moderation (V3)` | **L972** | **L974** | ⚠ +2 |
| `Community Analytics (V3)` | **L973** | **L975** | ⚠ +2 |
| `Anti-Spam & Rate Limits (V1)` | **L920** | L922 | ⚠ +2 |
| `Job Runtime (V2)` | **L1865** | L1867 | ⚠ +2 |
| `DPDP Act (V2)` | **L2050** | L2052 | ⚠ +2 |
| **EA line-citations repo-wide** | 329 | 329 | — |
| ⛔ **Citations pointing below the insertion (≥ L974)** | **175 correct** | **175 WRONG** | ⛔ **the blocker** |

⭐ **The citations were verified accurate *before* the edit**, so this is not pre-existing drift being
inherited — it is **new breakage this ADR would author**. Spot-checks against the pre-edit blob:
`L1865` = `Job Runtime (V2)` ✅ · `L2050` = `DPDP Act (V2)` ✅ · `L972` = `Moderation (V3)` ✅ ·
`L973` = `Community Analytics (V3)` ✅. Post-edit, `L1865` resolves to `Offline Capability Matrix (V2)` and
`L2050` to a blank tree connector.

### 8.2 The 32 affected files, and why that settles it

| Citing file | Citations ≥ L974 | Status |
|---|---|---|
| `PRD-008_REVENUE-AND-FINANCE.md` | **46** | `DRAFT` — Rank 3 |
| `ADR-INDEX.md` | **15** | Governance index |
| ⛔ `PRD-017_FILE_AND_MEDIA.md` | **13** | ⛔ **`FROZEN`** — Rank 3, conferred by `ADR-0054` |
| ⛔ `PRD-012a_PART3` / `PART4` / `PART5` / `PART6` / `PART7` / `PART8` | **10 + 6 + 4 + 1 + 8 + 1 = 30** | ⛔ **FROZEN family** |
| `ADR-0035`, `0037`, `0041`–`0047`, `0056`, `0058` | **~40** | **Accepted** ADRs |
| `PRD-006`, `PRD-022`, `PRD-012a_SECURITY_AUTOMATION`, `PAYMENT_GOVERNANCE_RESOLUTION` | **6** | Mixed |
| `PRD-021A` A2 v0.3/v0.4/v0.5, A3 v0.3, Decision Record, Owner Decision Request | **11** | This part's own drafts |

⛔ **This ADR cannot lawfully repair them.** `PRD_LIFECYCLE.md` **L177** — *"A frozen PRD is never silently
modified"* — forecloses editing `PRD-017` or the `PRD-012a` parts. Editing the bodies of **Accepted** ADRs to
chase a Rank 6 line shift is worse: `ADR-0015`'s own risk row warns against exactly this kind of expanding
"obvious fix". And leaving them wrong is not available either: `MP-CON-08` classes a document that disagrees
with reality as *"a defect to be raised"*.

⭐ **Only 48 of the 329 citations carry a content anchor** (e.g. `` EA **L1880** places CDN Delivery at **V2** ``);
**281 are bare line numbers**. An anchored citation degrades into a self-correcting nuisance. A bare one
becomes **silently, invisibly wrong** — and bare citations are the large majority.

### 8.3 Why the `ADR-0042` precedent does **not** authorise this

`ADR-0042` is cited throughout §1–§7 as *the* Rank 6 amendment precedent. On inspection of the commit
(`58cb5f4`) it authorises **less** than assumed:

| `ADR-0042`'s EA edit | This ADR's EA edit |
|---|---|
| **One token** in place: `Refunds (V2)` → `(V1)` at L820 | **Two whole lines inserted** into the tree |
| Header version, one line, in place | Same |
| Changelog **appended at the end** — below every citation | Same |
| ⭐ **Net line shift in the tree body: ZERO** | ⛔ **+2 for everything below L973** |

⭐ **`ADR-0042` never moved a line, so it never had to answer this question.** Its own changelog entry says
*"No platform added, removed or re-homed; **no node added or lost**"*. The v2.3 entry I drafted reused that
sentence pattern while doing the one thing `v2.2` explicitly did **not** do. **This ADR is the first EA
amendment in the repository's history to insert a line into the capability tree**, and the citation
convention that grew up around the document has no answer for it.

### 8.4 What was reverted, and proof

`git checkout --` on the EA only. Verified after: `sha256` prefix **`bb07d1e7bf8fd0162212`**, identical to the
pre-edit blob; **2,549** lines; header **`v2.2`**; `Last Updated` **2026-08-02**; `grep -c -i reaction` = **0**;
`Moderation (V3)` back at **L972** and `Community Analytics (V3)` at **L973**. `DOCUMENTATION_BASELINE.md` was
**never** touched, so §7's same-commit obligation never came due. **No other file was modified in the revert.**

### 8.5 What is now required, and who owns it

⛔ **Not proposed here, because choosing among these is itself an architectural decision** — and one about
governance convention, which is wider than this ADR's conferred authority (`ADR-0033` §7.1).

| Option | Sketch | Owner |
|---|---|---|
| **A** | Append-only EA amendment: enumerate the two capabilities in a **new § at the end** of the EA, below all cited lines, cross-referenced from `Community (V2)` **without inserting a line**. Ugly, but shifts nothing | Architecture Owner |
| **B** | Retire line-number citation of the EA in favour of **section + node-name anchors**, then insert freely. Correct long-term; touches 32 files including frozen ones | Governance Owner + Architecture Owner |
| **C** | Insert the two nodes **and** re-point all 175 citations in one atomic commit under an explicit frozen-document exemption | Governance Owner (frozen-PRD exemption) + Architecture Owner |
| **D** | Accept `LCF-GAP-013`'s enumeration half as **permanently open**, on the ground that the EA is descriptive and A2 already carries the normative statement | Architecture Owner |

⭐ **Option B is the only one that removes the class of defect rather than an instance of it**, and it is also
the only one that explains why this repository has **281 bare line citations** to a living document. That is a
**Governance Owner** matter — and `Governance Owner` is itself **undefined** in `PRD_OWNERSHIP_MODEL.md`
(`ADR-0077` §4.2 discloses this). The two blockers are therefore linked, and neither is invented here.

### 8.6 Status ledger after §8

| Item | Claimed in §1–§7 | ⭐ Actual |
|---|---|---|
| EA amended | ✅ executed | ⛔ **NO** — byte-unchanged at `v2.2` |
| `DOCUMENTATION_BASELINE.md` §3.2 L139 moved | ✅ same commit | ⛔ **NO** — not due |
| `LCF-GAP-013` enumeration half | ✅ closed | ⛔ **OPEN** — blocked, §8.5 |
| `LCR-FND-013` | ✅ closed | ⛔ **OPEN** — same blocker |
| The **`V2` determination** | Rank 1 `MP-SCOPE-04` | ✅ **UNCHANGED AND SOUND** — independent of the edit |
| The **reaction kind set** | Product Owner ruling | ✅ **UNCHANGED** — lives in A2, not the EA |
| A2 / A3 readiness | none claimed | ✅ **still none** — **NOT READY, NOT FROZEN** |
| Baseline identifier | not advanced | ✅ **not advanced** — now trivially true |

⭐ **The Product Owner rulings are unaffected.** `LIKE`/`HELPFUL`/`CELEBRATE`, the `HELPFUL` designation and
the 70/30 weights all land in **A2 and A3**, which are Rank 3 and carry the normative text. The EA is
**descriptive** (`MP-CON-08`); its silence is a **disclosure defect**, not a functional gap. ⛔ **But it is
still a defect, and it is still open.**

### 8.7 ⭐ Why this ADR was not deleted or quietly downgraded

Deleting it would erase the measurement. Rewriting §1–§7 to pretend the blocker was known would be a
falsified record. `PRD_LIFECYCLE.md` §5 rule 5 — *"Numbers are never reused, even after withdrawal"* —
means `ADR-0075` is spent regardless. **The honest disposition is the one recorded here:** a sound decision,
a blocked execution, a named and measured cause, and four routed options.

⚠ **`ADR-0076`, `ADR-0077` and `ADR-0078` are unaffected by this blocker.** `ADR-0076` amends **A2**, a Rank 3
document nobody cites by line number. `ADR-0077` amends `PRD_OWNERSHIP_MODEL.md`, cited by line in **one**
place, verified. `ADR-0078` amends **nothing**. **Only the EA has this citation-density problem**, which is
itself the strongest argument for Option B.
