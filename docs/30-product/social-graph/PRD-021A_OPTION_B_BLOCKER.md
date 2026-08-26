# `ADR-0075` §8.5 Option B — Feasibility Measurement and Authority Blocker

| Field | Value |
|---|---|
| **Document** | Option B feasibility measurement — the bare EA line-citation class defect |
| **Subject** | `ADR-0075` §8.5 **L315**, Option B |
| **Raised by** | `PRD-021A` — `LCF-GAP-013`'s surviving class half (A2 v0.7 **L1651**) |
| **Status** | ⛔ **BLOCKED — no part is executable.** Owner role is **VACANT** |
| **Acts performed** | ⛔ **NONE.** **0** citations rewritten, **0** files modified |

---

## 0. Verdict

⛔ **Option B is BLOCKED by authority, not by mechanics.**

The remediation is *mostly* mechanically feasible — **76** of the **87** cited EA lines have a
unique anchor, covering **383** of **441** citations (§2). It is nevertheless **not
executable in any part**, because:

1. §8.5 **L315** assigns Option B to *"**Governance Owner** + Architecture Owner"*;
2. `ADR-0080` **L85** constitutes the Governance Owner ⛔ **VACANT**;
3. ⭐ `ADR-0080` §2.2 item 5 states in terms: *"**`ADR-0075` §8.5 Option B is routed to this role, not resolved by it.** Constituting the role that owns a decision does not take the decision. **The 281 bare EA line-citations remain OPEN.**"*
4. **7** of the **56** citing files are **FROZEN**, holding **30** citations, and `PRD_LIFECYCLE.md` **L177** forbids silent frozen modification with **no exemption mechanism** defined anywhere in `PRD_OWNERSHIP_MODEL.md`.

⭐ **The smallest safe remediation permitted by Option B is therefore the empty set — and
that is a measured finding, not a refusal to attempt the work.** §4 records what was tested
and rejected, including a candidate that looked executable and was not.

---

## 1. The measurement

Instrument: every repository occurrence of an `EA L###`-shaped citation, classified by
whether the citation carries a section or node name alongside the line number.

| Metric | Value |
|---|---|
| EA size | **2,603** lines (`wc -l`), v2.3, Rank 6 |
| EA sha256 | `34761df53bfbf149…` |
| **TOTAL** `EA L###` citations | **441** |
| — across | **56** files, **87** distinct EA lines |
| ⛔ **BARE** (line number only) | **262**, across **48** files |
| ✅ **QUALIFIED** (carries §/node name) | **179** |
| **FROZEN** files holding EA citations | **7** (**30** citations) |
| Baseline-**RANKED** files | **18** |

### 1.1 ⚠ The recorded figure is 281; this instrument measures 262

`ADR-0075` §8.5 **L319–322** records *"**281 bare line citations**"*. This measurement finds
**262** — a delta of **−19**.

⛔ **Neither number is corrected here, and the recorded figure is not overwritten.** The
delta is a **classifier-boundary difference**: what counts as *"qualified"* depends on how far
from the line number a section or node name may sit before it stops disambiguating the
citation. Both figures are defensible under their own rule, and the governing observation —
that the EA is cited by bare line number in the **hundreds**, across **dozens** of files — is
identical under either.

⭐ Both are published, with the method, following the `PRD-021A_LCF-GAP-012_DECISION_RECORD`
§7.13.7 precedent, where two md5 command shapes were both recorded rather than one silently
chosen.

### 1.2 Where the bare citations live

| Count | File |
|---|---|
| **43** | `PRD-008_REVENUE-AND-FINANCE.md` |
| **19** | `ADR-INDEX.md` |
| **14** | `PRD-021A_A2_…_v0.7.md` |
| **12** | `PRD-021A_A2_…_v0.6.md` |
| ⛔ **11** | `PRD-017_FILE_AND_MEDIA.md` — **FROZEN + RANKED** |
| **10** | `PRD-021A_A2_…_v0.5.md` |
| **9** | `PRD-021A_A3_…_v0.5.md` |
| **8** | `ADR-0076-lcf-fr-026-citation-targets-repointed.md` |

### 1.3 ⛔ The frozen exposure

| File | EA citations | Status |
|---|---|---|
| `PRD-017_FILE_AND_MEDIA.md` | **16** | FROZEN + RANKED |
| `PRD-023_SETTINGS_AND_CONFIGURATION.md` | 5 | FROZEN |
| `ADR-0075-…-at-v2.md` | 3 | FROZEN — ⭐ *the ADR prescribing Option B is itself in scope* |
| `PRD-021A_A1_…_v0.2.md` | 3 | FROZEN-marked |
| `PRD-006_ATTENDANCE-MANAGEMENT.md` | 1 | FROZEN |
| `PRD-014_ENTITLEMENT.md` | 1 | FROZEN |
| `PRD-022_SAAS-BILLING.md` | 1 | FROZEN |
| **Total** | **30** | **7 files** |

---

## 2. Mechanical feasibility — mostly possible

Option B requires replacing each `EA L###` citation with a **section + node-name anchor**. An
anchor is only an anchor if it resolves to exactly one place. Tested per cited line:

| Class | Lines | Citations |
|---|---|---|
| ✅ **UNIQUE anchor available** | **76** | **383** |
| ⛔ **AMBIGUOUS** — the name repeats in the EA | **4** | **17** |
| ⛔ **NO usable node name** | **7** | **41** |

### 2.1 ⛔ Ambiguous — an anchor resolving to N places is not an anchor

| EA line | Cited | Anchor | Occurrences in EA |
|---|---|---|---|
| **L814** | 6× | `Financial Reports` | **2** |
| **L1423** | 4× | `Financial Reports` | **2** |
| **L2067** | 4× | `════════…` (a horizontal rule) | **37** |
| **L122** | 3× | `Student Payments` | **2** |

⭐ **L814 and L1423 are different EA locations that reduce to the same anchor string.**
Converting both would silently merge two distinct references — strictly worse than the bare
line numbers it replaces.

### 2.2 ⛔ No usable node name

| EA line | Cited | Content |
|---|---|---|
| **L79** | 13× | `\| 11 \| **BUSINESS PLATFORM** \| 8.0 \| Solid b…` — a scoring-table row |
| **L86** | 10× | `\| 18 \| **PLATFORM SERVICES** \| \`[PARTIAL]\` 7…` |
| ⛔ **L944** | 5× | `│` |
| ⛔ **L957** | 5× | `│` |
| **L74** | 4× | `\| 6 \| **LIBRARY MANAGEMENT** \| 8.5 \| Excelle…` |
| **L71** | 2× | `\| 3 \| **CONFIGURATION PLATFORM** \| 9.0 \| Wel…` |
| ⛔ **L1880** | 2× | `│` |

⭐⭐ **`L944`, `L957` and `L1880` are cited a combined 12 times, and each is a single
box-drawing character.** There is no node to name. These citations cannot be converted to
anchors under any scheme; they can only be **repointed by a human who determines what was
meant** — which is an authoring act on 12 citations across other documents, several of them
outside `PRD-021A`'s scope entirely.

### 2.3 ⚠ The first instrument produced a false blocker

An initial anchor test reported only **4 of 87** lines as anchorable, which would have made
Option B look structurally impossible.

⛔ **That figure was wrong and is not reported as a finding.** The test demanded a Markdown
heading or a table-row prefix, so it rejected EA tree-diagram lines that plainly *do* carry
node names — e.g. `│   └── Secret Reference Resolution (V2)`. Rewriting the extractor to
strip box-drawing characters, take the first table cell, and strip heading markers yields
**76**.

⭐ The honest finding is that Option B is **mechanically mostly feasible and blocked on
authority** — not that it is impossible. Reporting **4/87** would have manufactured an
impossibility and excused the work.

---

## 3. ⛔ The authority blocker

### 3.1 The owner named by §8.5

> `ADR-0075` §8.5 **L315**:
> `| **B** | Retire line-number citation of the EA in favour of **section + node-name anchors**, then insert freely. Correct long-term; touches 32 files including frozen ones | Governance Owner + Architecture Owner |`

§8.5 **L309–310** adds that the choice is *"⛔ Not proposed here, because choosing among these
is itself an architectural decision — and one about governance convention, which is wider
than this ADR's conferred authority (`ADR-0033` §7.1)."*

### 3.2 The owner is VACANT

`ADR-0080` constitutes the Governance Owner by derivation from existing rules, and:

- **L85**: *"⛔ **It is constituted VACANT.** `PRD_OWNERSHIP_MODEL.md` §7 rule 4 — '**Never** record a personal name' — is observed. Constituting an office does not fill it, and nothing here appoints anyone."*
- ⭐⭐ **§2.2 item 5**: *"⛔ **`ADR-0075` §8.5 Option B is routed to this role, not resolved by it.** Constituting the role that owns a decision does not take the decision. **The 281 bare EA line-citations remain OPEN.**"*

`PRD_OWNERSHIP_MODEL.md` **L418** grants the role *"Document **status** and **process**… and
the **registration of identifier prefixes**"*, but expressly ⛔ **not** *"boundaries, ranks or
permitted edges (**Architecture Owner**)"*, and ⛔ **not** *"its own conferral, and ⛔ its own
scope."* **L419**: *"The role is **vacant as constituted**."*

⭐ **The blocking sentence was written by the very ADR that created the owning role.** This is
the strongest possible form of the blocker: the repository anticipated exactly this attempt
and pre-emptively denied it.

### 3.3 The frozen-file blocker is independent

Even with the Governance Owner filled, **30** of the citations sit in **7 FROZEN** files.

- `PRD_LIFECYCLE.md` **L177**: *"**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly…"*
- `grep "exemption"` across `PRD_OWNERSHIP_MODEL.md` returns **0 hits** — no exemption mechanism is defined.
- An exemption is the distinguishing feature of **Option C**, not Option B, and §8.5 assigns it to *"Governance Owner (frozen-PRD exemption)"* — the same vacant role.

⛔ **Two independent blockers, one vacant role. Filling the role is necessary and not
sufficient; the frozen-document rule needs a separate act.**

---

## 4. What was tested as a "smallest safe remediation" and **REJECTED**

The instruction was to find the *smallest* safe remediation permitted by Option B. Four
candidates were measured. All four are rejected, with reasons.

### 4.1 ⛔ REJECTED — "convert only the 383 unambiguous citations"

Mechanically clean; **0** ambiguous conversions.

⛔ **Rejected on authority.** Converting **any** citation *is* Option B, in part. §8.5 assigns
Option B to a vacant role, and no rule anywhere permits partial execution of a routed
decision by a party that does not hold it. `ADR-0082` established the governing principle for
this repository: *routing an item is not resolving it*.

⚠ **It also fails on its own terms**: **97** of the 383 sit in files that also hold
ambiguous or unnameable citations, so a partial conversion leaves those files citing the EA
by **two mutually inconsistent conventions** — a new class defect replacing the old one.

### 4.2 ⛔ REJECTED — "convert only citations in `PRD-021A`-owned files"

`PRD-021A` files hold **54** bare citations across A2 v0.3–v0.7 and A3. Scope is genuinely
within this work's remit.

⛔ **Rejected.** The convention is repository-wide by construction. A2 citing the EA by
node-name anchor while `PRD-008` cites it by line number does not remove the class defect; it
**doubles** the conventions in force. Option B's stated value is that it *"removes the class
of defect rather than an instance of it"* (§8.5 **L319**) — and a scheme applied to 54 of 262
citations removes neither.

⚠ Additionally, **3** of those citations are in `PRD-021A_A1_…_v0.2.md`, which is
**FROZEN-marked**.

### 4.3 ⛔ REJECTED — "add anchors alongside the existing line numbers, changing nothing"

Superficially the safest possible act: purely additive, no citation invalidated, no frozen
file touched if restricted to unfrozen ones.

⛔ **Rejected — this is not Option B, and it makes the defect harder to fix.** Option B is
*"**Retire** line-number citation"*. A citation reading `EA L814 (Financial Reports)` still
breaks when the EA shifts, and now breaks **silently**: the anchor lends the stale number
false credibility. It would also have to be applied to the **17** ambiguous and **41**
unnameable citations, where the added anchor is either wrong (`Financial Reports`, 2
locations) or meaningless (`│`).

⭐ This was the most attractive candidate and it is the most instructive rejection: an act
that changes nothing normative can still make the eventual correct act harder.

### 4.4 ⛔ REJECTED — "repoint the 12 citations pointing at bare `│` characters"

These are defective under *any* convention — a citation to a box-drawing glyph conveys
nothing. Repointing them looks like an unambiguous repair.

⛔ **Rejected — repointing requires determining what was meant, which is an authoring act on
another document's requirement.** The `ADR-0076` precedent is directly on point: repointing
`LCF-FR-026`'s two citation targets was possible **only** because the correct targets were
*measurable* (`LCF-XC-006` for moderation, `LCF-XC-029` for analytics, the latter being the
only exclusion row citing EA **L973**), and even then it required an **Architecture Owner
ADR**. Here the intended targets are **not** measurable: `│` at L944 is consistent with any
node in the surrounding subtree.

⚠ ⛔ **And the citing documents are not all ours to amend.** Several sit outside `PRD-021A`.

---

## 5. What this record does **NOT** do

| Act | Owner | Verification |
|---|---|---|
| ⛔ Convert, add or retire any citation | **Governance Owner + Architecture Owner** (§8.5 **L315**) | **0** citations altered in **0** files |
| ⛔ Modify the EA | **Architecture Owner** | `34761df53bfbf149…` — byte-identical |
| ⛔ Modify any frozen document | — | **0** of the 7 touched |
| ⛔ Fill, appoint to, or act as the Governance Owner | — | Role remains ⛔ **VACANT** per `ADR-0080` **L85** |
| ⛔ Grant a frozen-document exemption | **Governance Owner** (Option **C**) | Not granted; no mechanism exists to grant it |
| ⛔ Correct `ADR-0075`'s recorded figure of 281 | **Architecture Owner** | Both **281** and **262** published with method (§1.1) |
| ⛔ Choose between Options A/B/C/D | **Architecture Owner** + **Governance Owner** | No option selected. `ADR-0075` retains `EXECUTION BLOCKED` |
| ⛔ Create or amend any ADR | **Architecture Owner** | `git diff docs/00-governance/` is **0 lines**. Next free remains **`0083`** |
| ⛔ Close `LCF-GAP-013`'s class half | **Governance Owner** | ⛔ Remains **OPEN**, exactly as A2 **L1651** records |

---

## 6. The exact next act

⛔ **There is no next act available to any party working from repository authority alone.**

The sequence, in order, each step requiring the previous:

| # | Act | Owner | Available now? |
|---|---|---|---|
| 1 | Appoint a holder to the Governance Owner office | ⛔ **outside the repository** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 forbids recording a personal name, and **L418** denies the role *"its own conferral"* | ⛔ **NO** |
| 2 | Choose among §8.5 Options A/B/C/D | **Architecture Owner** + **Governance Owner** | ⛔ NO — step 1 |
| 3 | If B: ratify a repository-wide anchor convention | **Governance Owner** | ⛔ NO |
| 4 | Resolve the **4** ambiguous and **7** unnameable lines (**58** citations) | **Architecture Owner** — requires EA edits to make the nodes nameable | ⛔ NO |
| 5 | Grant a frozen-document exemption for the **30** frozen citations | **Governance Owner** | ⛔ NO — and no mechanism is defined |
| 6 | Execute the conversion across **48**–**56** files | **Architecture Owner** | ⛔ NO |

⭐ **Step 1 is not a documentation act, and no volume of measurement substitutes for it.**
`ADR-0079` previously unblocked Option **A** by measuring *where* an edit was safe rather than
*whether* editing was safe. That manoeuvre is unavailable here: Option B's obstacle is not
the location of an edit but the identity of the decider.

---

## 7. Verification

| Assertion | Result |
|---|---|
| EA byte-identical | ✅ `34761df53bfbf149…`, 2,603 L |
| Citations altered | ✅ **0** |
| Files modified | ✅ **0** |
| Frozen documents touched | ✅ **0** of 7 |
| `git diff docs/00-governance/` | ✅ **0 lines** |
| `git diff docs/10-architecture/` | ✅ **0 lines** |
| Identifiers minted | ✅ **0** |
| Owner decisions taken | ✅ **0** |
| Options selected | ✅ **0** — `ADR-0075` retains `EXECUTION BLOCKED` |

---

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-25 |
| **Base commit** | `2dca733` |
| **Determination** | ⛔ **Option B BLOCKED — 0 of 441 citations remediable under present authority.** `LCF-GAP-013` class half remains **OPEN** |
