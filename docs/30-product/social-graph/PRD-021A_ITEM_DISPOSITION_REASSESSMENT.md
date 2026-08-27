# PRD-021A — LCF / LCR item disposition reassessment

| Field | Value |
|---|---|
| **Document** | `PRD-021A_ITEM_DISPOSITION_REASSESSMENT.md` |
| **Date** | 2026-08-26 |
| **Subjects measured** | `PRD-021A` A2 v0.7 (1,751 lines, sha256 `9192a8b1626716b5…`) · A3 v0.5 (1,253 lines, sha256 `6fb17cb1b8ba3a6c…`) |
| **Authority for the reassessment** | ⛔ **NONE IS CLAIMED, AND NONE IS NEEDED.** This record **classifies** items against dispositions that already exist in `Accepted` ADRs. It **takes no decision**, closes no item by its own force, and confers no readiness |
| **Subjects edited** | ⛔ **NONE.** A2 and A3 are **byte-unchanged**. So is every Rank 1–5 document |
| **Verdict** | **21 RESOLVED · 0 EXECUTABLE (of existing register items) · 34 BLOCKED · 1 REFUSED · 2 RETIRED = 58 positions** |
| **New findings** | ⭐ **3** register-staleness / inventory findings — `S-1`, `S-2`, `S-3` — none previously recorded anywhere in the repository |
| **Stage effect** | ⛔ **NONE.** No stage advances. `PRD-021A` remains **NOT READY — NOT FROZEN** |

---

## 0. Verdict

Every `LCF-` and `LCR-` item in `PRD-021A` A2 v0.7 and A3 v0.5 was located at its own register
row, read, and classified into exactly one of the four dispositions the instruction names —
**RESOLVED**, **EXECUTABLE**, **BLOCKED**, **REFUSED** — plus **RETIRED**, which is not a
disposition but a preserved position (`PRD-023` `CNF-FR-008`: a retired identifier SHALL NOT be
reused).

| Disposition | Count | Meaning applied here |
|---|---|---|
| ✅ **RESOLVED** | **21** | An authority **exists and has been exercised** — a named `Accepted` ADR, or an explicit Product Owner ruling recorded in the Decision Record |
| ⚡ **EXECUTABLE** | **0** | Of the **existing register items**: none. ⭐ See §2 — the only executable act found is a **new** finding, not a register item, and it is correctly declined on a measured ground |
| ⛔ **BLOCKED** | **34** | A named owner other than this pass must act, **or** a required artefact does not exist |
| ⛔ **REFUSED** | **1** | `LCR-DEC-009` — not decidable on present authority; the only two available "resolutions" are both prohibited |
| ⚪ **RETIRED** | **2** | `LCR-GAP-005`, `LCR-DEC-005` — positions preserved, not items |

⭐⭐ **The finding of this reassessment is not the tally. It is that the tally disagrees with the
repository's own inventory in three specific, measurable ways** — §5. Two `Accepted` ADR
dispositions have **not been reflected** in the subject's registers, and one whole pair of
registers has **never been inventoried at all**.

⛔ **Zero values were invented.** No weight, bound, threshold, permission, edge, rank, owner
decision or `IMPL-` allocation appears in this document.

---

## 1. ✅ RESOLVED — 21 items, each on a named authority

An item is RESOLVED here **only** if a document outside this record already carries the
disposition. The "Authority" column is the thing that closed it; this record merely reports it.

### 1.1 A2 `LCF-GAP-*` — 5 resolved

| Item | Substance | Authority | Where recorded |
|---|---|---|---|
| `LCF-GAP-001` | `LCF-` prefix not registered | ✅ `ADR-0080` (**Accepted**) §5 — prefix **REGISTERED** to `PRD-021A` A2, measured against every registered prefix, no collision | `ADR-0080` L195; A2 changelog **L117** (`U3`). ⚠ **But not in A2's register row — see `S-1`** |
| `LCF-GAP-005` | "A3 does not exist on disk" | ✅ **CLOSED ON MEASUREMENT, not on decision** — the predicate is a statement of fact and it became false | A2 register row **L1627** |
| `LCF-GAP-012` | `LCF-XC-017` excluded comments/reactions while the body specified them | ✅ Explicit **Product Owner** scope decision — comments and reactions **SHIP**; `LCF-XC-017` narrowed | A2 **L1650**; `PRD-021A_LCF-GAP-012_DECISION_RECORD.md` |
| `LCF-GAP-013` | `LCF-FR-026` cited the wrong exclusions; EA did not enumerate the capabilities | ✅ **FULLY RESOLVED at v0.7.** Citation half by `ADR-0076`; EA-enumeration half by `ADR-0079` (**Accepted**) via `ADR-0075` §8.5 **Option A**, append-only EA §12 | A2 **L1652** |
| `LCF-GAP-014` | `LCF-BR-010` required a reaction-kind set §22 never enumerated | ✅ Explicit **Product Owner** enumeration — exactly `LIKE`, `HELPFUL`, `CELEBRATE` | A2 **L1651**; DR v2.0 §7.2 |

⭐ **`LCF-GAP-005` is the only item in either annex ever closed without an owner's decision**, and
its sibling `LCF-GAP-011` was tested identically and **stayed OPEN** — `integration_test/` still
does not exist. Same instrument, opposite result, each measured.

### 1.2 A2 `LCF-ADR-*` and `LCF-DEC-*` — 4 resolved, ⭐ and this is a new determination

| Item | Substance | Authority |
|---|---|---|
| `LCF-ADR-005` | Resolve `ID-2` vs library-private community scope (**Conflict 5**) | ⭐ ✅ **`ADR-0078` (Accepted 2026-08-25) §5.1** — *"A2 **Conflicts 5 and 6** \| Same question, upstream form"* |
| `LCF-DEC-003` | Choose Option 1, 2 or 3 for tenant scoping (**Conflict 5**) | ⭐ ✅ Same — `ADR-0078` §2.1 rules **no `tenantId`**, which is A2 §20.2 **Option 1**'s outcome |
| `LCF-ADR-006` | Resolve BC Map **L450** against **L488** (**Conflict 6**) | ⭐ ✅ **`ADR-0078` §2.1** — *"BC Map L450 is scoped, not universal"* |
| `LCF-DEC-003a` | Rule on L450 vs L488 for Global-band events (**Conflict 6**) | ⭐ ✅ Same |

⭐⭐ **This is not a re-reading of a known closure; it is a closure the repository had not
connected.** `ADR-0078`'s header **Closes** row and its §5.1 table both name *"A2 Conflicts 5 and
6"* explicitly. A2 §20.2 **L1104** routes Conflict 5 to *"`LCF-ADR-005` / `LCF-DEC-003`"*, and
A2 **L1698** routes Conflict 6 to `LCF-DEC-003a`. The identity is therefore stated by the
subject itself — the ADR closed the **conflicts**, and the subject's own text says which
identifiers those conflicts are.

⚠ **What is NOT claimed.** `ADR-0078` §2.5 is explicit about its own limits, and this record does
not exceed them:

| `ADR-0078` §2.5 — not decided | Consequence for this reassessment |
|---|---|
| Registration of `BC-15`'s aggregates in BC Map §8 | `LCF-GAP-009` / `LCF-ADR-001` / `LCR-DEC-007` stay **BLOCKED** |
| Registration of `LCF-EVT-001`…`006` in BC Map §9 | Not treated as resolved anywhere below |
| The `BC-15 → BC-11` edge | `LCR-GAP-004` / `LCR-DEC-004` / `LCR-FND-001`…`006` stay **BLOCKED** |
| L450's **wording** in the BC Map | Disclosed by `ADR-0078` §4.2, **not repaired**; not counted here |

⚠ **One residual is disclosed rather than smoothed over.** A2 §20.2 **L1092** raises an *"honest
objection against my own proposal"* — that a `communityId` mapping 1:1 to a library *"may simply
be a `tenantId` wearing a different name."* Measured: `ADR-0078` contains **0** occurrences of
`communityId`, `Option 1`, `evasion` or `1:1`. The ADR rules on the **field** (`tenantId` is
absent) and does not address the **semantic** objection. It is recorded here as an open question
of A2's own raising, **not** re-opened as an item and **not** answered.

### 1.3 A3 `LCR-GAP-*` — 3 resolved

| Item | Authority |
|---|---|
| `LCR-GAP-001` | ✅ `ADR-0080` (**Accepted**) — `LCR-` prefix **REGISTERED** to A3 |
| `LCR-GAP-003` | ✅ **Product Owner** — both halves; `HELPFUL` designated as the helpfulness indication (DR v2.0 §7.3). ⚠ Makes `LCR-RS-003` **ELIGIBLE, not ACTIVE** |
| `LCR-GAP-009` | ✅ `ADR-0078` (**Accepted**) — community scope identifier carries **no** `tenantId` |

### 1.4 A3 `LCR-DEC-*` — 2 resolved

| Item | Authority |
|---|---|
| `LCR-DEC-002` | ✅ **Product Owner** — comments/reactions **SHIP** |
| `LCR-DEC-008` | ✅ **Product Owner** — **Recency 70** + **Legitimate engagement 30** = exactly **100** (DR v2.0 §7.4). ⚠ The ruling covered **two** signals and assigned **no** weight to helpfulness |

### 1.5 A3 `LCR-FND-*` — 7 resolved (the whole `F-2` chain)

`LCR-FND-007`…`012` are the six components of finding **F-2** (the EA did not enumerate community
comments/reactions); `LCR-FND-013` is its status row.

| Item | Disposition |
|---|---|
| `LCR-FND-007`…`012` | ✅ Components of `F-2`, closed with it |
| `LCR-FND-013` | ✅ **CLOSED at v0.5** by `ADR-0079` (**Accepted**), which executed the enumeration by **append** — EA v2.3 §12. Measured: **482** EA citations re-resolved, **0** invalidated, **0** frozen files touched, EA L967–973 byte-identical |

⭐ `LCR-FND-013`'s own precondition was *"SHALL NOT be recorded as closed while the EA remains
unamended."* The precondition is satisfied, which is why this is a closure rather than a claim.

---

## 2. ⚡ EXECUTABLE — 0 register items, and 1 new finding correctly declined

⛔ **No existing `LCF-`/`LCR-` register item is executable by this pass.** Every one of the 34
BLOCKED items needs a value, an artefact, or a role this pass does not hold — §4 probes each.

⭐ **One executable act was nonetheless found, and it is not a register item.** It is the remedy
for the Stage 3 **Check 2 FAILURE** recorded in
`PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md` §2. Labelled `E-1` locally.

### 2.1 The act

| Field | Value |
|---|---|
| **Substance** | A2 v0.7's `LCF-FR-034` (**L591**), `LCF-FR-096` (**L1178**) and `LCF-AUTH-012` (**L818**) are **unconditional `SHALL`s** consuming `BC-11` across an edge BC Map **L292** says does not exist. A2 raises **no** `LCF-ADR-*` for it and **blocks nothing** |
| **The correct shape already exists in A2** | `LCF-FR-043` (**L660**): *"**Until `LCF-ADR-002` is accepted**, `NOTE`, `MEDIA` and `LINK` posts SHALL be treated as blocked."* The remedy is to give the `BC-11` consumptions the same self-blocking form |
| **Does it invent anything?** | ⛔ **No** — and this is why it is *executable* rather than blocked. A blocking clause **withholds** capability; it grants none. It decides no edge, mints no permission, assigns no weight |
| **Citation blast radius** | ✅ **0.** A2 v0.7 is cited by line number **10** times across **6** files; the highest cited line is **L1492** of 1,751. An append below L1492 invalidates **0** citations |

### 2.2 ⛔ Why it is NOT performed here — a measured ground, not a reluctance

| # | Obstacle | Evidence |
|---|---|---|
| 1 | ⭐⭐ **A2 v0.7's sha256 is a hash anchor inside an `Accepted` ADR.** `ADR-0082` **L419** records `A2 v0.7 \| — \| 9192a8b1626716b5…`. Editing A2 v0.7 **in place** would falsify an anchor in an Accepted governance record | Verified this pass: on-disk sha256 is `9192a8b1626716b5…` — **identical**, i.e. the anchor is currently **true** and must stay true |
| 2 | The lawful route is therefore a **new version, A2 v0.8** — a subject-authoring act, not a "smallest safe remediation". It would need its own review, changelog, and register reconciliation | `PRD_LIFECYCLE.md` §5; the v0.3→v0.7 precedent, where every change opened a new file |
| 3 | The remedy's **complete** form also needs a **new `LCF-ADR-007`** requesting the edge. Minting an identifier is the **prefix holder's** act, and `PRD_LIFECYCLE.md` §5 rule 5 forbids reuse | A2 **L1505**: *"This part **creates none of them and mints no ADR number**"* |
| 4 | `ADR-0082` **L425–426** already set this pass's posture explicitly: *"**A2 and A3 are deliberately NOT EDITED, and that is a decision rather than an omission.** Zero items closed means **zero register cells change**"* | Read at its line |

⭐ **Disposition: EXECUTABLE, correctly declined, and routed.** The act is available and cheap;
the reason not to take it is that taking it in place would break an Accepted ADR's anchor, and
taking it lawfully is a larger authoring act than this pass is scoped to. Recorded so that the
A2 author can perform it at v0.8 with the blast radius already measured.

---

## 3. ⛔ REFUSED — 1 item

### 3.1 `LCR-DEC-009` — a weight for `LCR-RS-003` Helpfulness

A3 **L1083**, read verbatim:

> ⛔ **OPEN at v0.5 — formally REFUSED as undecidable, and expressly NOT resolved**
> (`ACCEPTED` `ADR-0081` section 2). … Of the three conceivable resolutions, **two are
> prohibited** — publishing a number is invention, and carving it from the ruled `70`/`30`
> overwrites a decision the Product Owner **did** make.

**Re-probed this pass, not assumed:**

| Probe | Result |
|---|---|
| `grep -ril "helpfulness" docs/` | **13** files |
| Of those, files **outside** the `PRD-021A` A-part family | **3** — `ADR-INDEX.md`, `ADR-0081`, `ADR-0082` |
| ⭐ Of those 3, files that are **not** `PRD-021A`'s own governance records | ⛔ **0** |
| ⇒ External **Product Owner** rulings assigning a helpfulness weight | ⛔ **0** |

⭐ **The instruction requires this item to stay unresolved unless an authoritative PO decision
actually exists. It does not exist.** `LCR-RS-003` therefore stays 🟡 **ELIGIBLE at weight 0**,
and the active set stays **Recency 70 + Legitimate engagement 30 = exactly 100**.

⚠ **A crude classifier disagreed and was overridden.** A marker-based scan labelled this row
`RESOLVED?` purely because the cell contains the token *"RESOLVED"* — inside the phrase *"expressly
**NOT** resolved"*. The disposition here is taken from the **read text**.

⚠ **`LCF-GAP-006` is deliberately NOT classified REFUSED.** Its substance (body length, attachment
count, page-size bounds) is equally un-mintable, but its authoritative disposition is
`ADR-0082` §3.2: ⛔ **OPEN** — routed to Product Owner + Configuration Owner. Reclassifying an
`Accepted` ADR's *OPEN* as *REFUSED* would be this record substituting its own judgement for a
ruling. It is counted **BLOCKED**.

---

## 4. ⛔ BLOCKED — 34 items, grouped by the authority that must act

### 4.1 Architecture Owner — 19 items

⭐⭐ **The authority is held; the execution is refused on measurement.** `ADR-0082` §4 is the
governing record: the single BC Map edit these reduce to shifts cited lines. Re-measured at
`2dca733` with a fresh instrument:

| Insert site | Lines shifted | ⛔ Citations invalidated | Files | FROZEN | Baseline-RANKED |
|---|---|---|---|---|---|
| **L388** — §8 aggregate row | 238 | ⛔ **300** | **52** | **4** | **27** |
| **L360** — §7 edge row | 266 | ⛔⛔ **599** | **69** | **8** | **34** |

⚠ `ADR-0082` **L229** records **658** / **1,112** from its own instrument. **Both figures are
published; neither is "corrected."** The delta is an instrument-boundary difference, and silently
replacing a figure inside an `Accepted` ADR is not this record's act.

| Items | Required act |
|---|---|
| `LCF-GAP-009` · `LCF-ADR-001` · `LCF-DEC-001` · `LCR-GAP-008` · `LCR-DEC-007` | Add a **`BC-15` aggregate row** to BC Map **§8** and extend L119 |
| `LCF-ADR-002` · `LCF-DEC-002` | Admit the **`BC-15` → `BC-14`** edge to BC Map **§7** |
| `LCR-GAP-004` · `LCR-DEC-004` · `LCR-FND-001`…`006` | Admit the **`BC-15` → `BC-11`** edge to BC Map **§7** (`ADR-0081` §4.1 row `004`: ⛔ **OPEN — routed**) |
| ⭐ `LCF-ADR-003` · `LCF-DEC-005` | Ratify a repository-wide **pagination convention**. Blocks `LCF-API-004`, `LCF-AC-036` |
| ⭐ `LCF-ADR-004` · `LCF-DEC-006` | Assign a **realtime owner, edge and fan-out model**. Blocks `LCF-API-014` |

⭐ **`B-NEW` — a second, distinct Architecture Owner act that no repository item requests.**
Carried from `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md` §1.3. A same-rank `BC-15 → BC-11`
dependency needs more than an edge:

| Fact | Value | Source |
|---|---|---|
| `domain/social` rank | **8** | `tool/module_dependencies.yaml` **L47** |
| Its declared contexts | `[graph, messaging, safety]` = `BC-11`/`12`/`13` — **`BC-15` absent** | yaml **L234** |
| The declared **Social cluster** | *"`BC-11` Graph, `BC-12` Messaging, `BC-13` Safety — Only edges `E-14`…`E-16`"* | Module Dep Matrix **L90** |
| Rule `L2` | *"A module may depend only on modules of **strictly lower rank**. **Same-rank dependencies are forbidden except within a declared cluster.**"* | Matrix **L49** |
| Matrix lines naming `BC-14`…`BC-17` | **1** — L354, and it is a **prohibition** (`X-05`) | measured |

⇒ The edge alone would still breach `L2` unless the **cluster at Matrix L90 is extended**.
Measured: `LCR-GAP-004`, `ADR-0081` §4.1 and `ADR-0082` §4 request the **edge** and say nothing
about the **cluster**.

⛔ **No identifier is minted for `B-NEW`.** Minting is the prefix holder's act, and `PRD-023`
`CNF-FR-008` forbids reusing a position. It is named descriptively and routed.

### 4.2 Product Owner — 6 items

| Item | Substance | Probe result |
|---|---|---|
| `LCF-GAP-006` | Body length / attachment count / page-size **bounds** | `CONFIGURATION_GUIDE.md` and `PRD-023` publish the **machinery**, not these values. Minting them invents three product constraints (also needs the Configuration Owner) |
| `LCF-GAP-010` · `LCR-GAP-010` | No latency or throughput budget | No budget exists to cite. A number minted here is an invented NFR (also needs the Architecture Owner) |
| `LCR-GAP-002` · `LCR-DEC-001` | No `helpState`, no announcement type, no priority field — and A2 `LCF-FR-027` **closes** the post-type set | Adding a post type **extends a closed register** — `PRD_LIFECYCLE.md` §5 rule 6 |
| `LCR-DEC-006` | Does an official **announcement surface** exist? | `grep -ril "announcement"` → the family plus the **Rank 6 EA**, which is **descriptive** and under `MP-CON-08` cannot supply a requirement |

### 4.3 Other named owners — 8 items

| Item | Owner | Blocker |
|---|---|---|
| `LCF-GAP-004` | Architecture Owner / `BC-14` PRD author | **0** PRDs own `BC-14`. Authoring a PRD is not an ADR act |
| `LCF-GAP-007` | `PRD-020` owner | `PRD-020` is **v0.1 `DRAFT`, unranked**; **0** occurrences in `DOCUMENTATION_BASELINE.md`, so `TSF-CFG-030` cannot be cited as authority |
| `LCR-GAP-007` | `BC-13` owner | Same root blocker — `BC-13`'s owning PRD **is** `PRD-020` |
| `LCF-GAP-008` | Governance Owner / Auth PRD owner | Permission catalogue **closed** by a **FROZEN Rank 3** document (`AUTH-7.22`); `grep -c "\bPERM-[0-9A-Z]"` over `docs/` → **1**, and it is the disclosure **recording the absence** |
| `LCF-GAP-015` | `PRD-020` owner | Opened by `ADR-0082` **L398** — `PRD-020`'s header declares Stage 2 while its Stage 3/4/5 records exist on disk. Disclosed, **not repaired**, and expressly does **not** unblock `LCF-GAP-007` |
| ⭐ `LCF-DEC-004` | **Product Owner** | `ADR-0036` **§8.2 question 2** — the first day of the three-day protected renewal window. **Inherited from A1 `LCM-DEC-001`** (A1 **L1436**, **L795**). Probed: no ADR answers q2 |
| `LCR-GAP-006` · `LCR-DEC-003` | **Privacy Owner + Product Owner** | The Privacy Owner role **exists** (`ADR-0077`) but is **constituted VACANT** and has issued no ruling. A privacy determination over a **minor-inclusive** population (`SM-INV-3`; BC-10 **L376**) is where invention would be most harmful |

⛔ **`B-28` — the Option B class half**, owner **Governance Owner + Architecture Owner**.
`ADR-0075` §8.5 **L315**; `ADR-0080` **L85** VACANT; §2.2 item 5: *"routed to this role, **not
resolved by it**… The 281 bare EA line-citations **remain OPEN**."* Measured and blocked in
`PRD-021A_OPTION_B_BLOCKER.md`. It is **not** a register item and is therefore **not** counted in
the 34; it is named here so the reassessment is not silent about it.

### 4.4 Blocked by a missing artefact, not a decision — 1 item

| Item | Owner | Blocker |
|---|---|---|
| `LCF-GAP-011` | Engineering Owner | ⭐ Re-measured: `ls -d integration_test` → **`No such file or directory`**. This is a **code** obligation behind an **unallocated `IMPL-` range** (next free is `IMPL-1500`+, **0** allocated). Its sibling `LCF-GAP-005` had the same shape and **closed**; this one does not |

---

## 5. ⭐ Three findings this pass established that no repository record holds

The three findings below are the substance of this record. Each is a **discrepancy between two
documents already in the repository** — not a new requirement, not a decision, not a proposal.
Each is **disclosed and left unrepaired**, for the reason given in §5.4.

⚠ **Line-number self-correction.** An earlier working note in this pass cited the A2 hash anchor at
`ADR-0082` **L419**, the `ADR-0078` *Closes* row at **L13** and A2's Conflict-5 routing at **L1104**.
Re-measured at authoring time with `grep -n`, the true lines are **L421**, **L12** and **L1102**.
The **substance is unchanged**; only the anchors are corrected. Both figures are recorded here rather
than the wrong one being silently dropped, per the same rule this pass applied to the 262/281 and
300/599 pairs.

### 5.1 ⭐ `S-1` — A2 v0.7 contradicts itself on whether the `LCF-` prefix is ratified

`ADR-0080` (**Accepted**) §5 **L195** REGISTERED the `LCF-` prefix, and A2's own changelog records it:

> A2 **L117** — *"`U3` `LCF-GAP-001` **CLOSED** by `ACCEPTED` `ADR-0080`. The `LCF-` prefix is
> REGISTERED."*

**Six** further locations in the same file still assert the opposite. All six read at their lines:

| A2 line | Text as measured | Posture |
|---|---|---|
| **L21** | *"it is a Governance Owner act (`LCF-GAP-001`)"* | stale |
| **L240** | *"⚠ **The `LCF-` prefix used below is proposed, not conferred.** … Ratifying `LCF-` is a **Governance Owner** act — `LCF-GAP-001`."* | stale |
| **L1495** | `LCF-RSK-014` — *"The prefix is **proposed, not ratified**."* | stale |
| **L1554** | Implementation checklist item **20** — *"Ratify the `LCF-` prefix in the identifier registry"* | stale |
| **L1616** | *"The `LCF-` prefix itself is **unratified** (`LCF-GAP-001`)."* | stale |
| **L1625** | The `LCF-GAP-001` **register row** — *"The `LCF-` prefix is not registered… `LCF-` is proposed only"* | stale |

Two probes establish that the contradiction is recorded **nowhere**:

| Probe | Command | Result |
|---|---|---|
| Does the register row carry a closure marker? | `sed -n '1625p' A2 \| grep -o "CLOSED\|RESOLVED\|✅" \| wc -l` | ⛔ **0** |
| Is the risk `LCF-RSK-014` noted outside A2's own versions? | `grep -rln "LCF-RSK-014" docs/ \| grep -v "PRD-021A_A2_" \| wc -l` | ⛔ **0** |

⭐ A3 v0.5 carries the **identical** staleness for its own prefix at **L89** (*"The `LCR-` prefix used
below is proposed, not conferred"*) and **L1016**, even though `ADR-0080` §5 **L196** registered `LCR-`
in the same act and A3's `LCR-GAP-001` is marked ✅ CLOSED.

⛔ **What `S-1` is not.** It is not a defect in `ADR-0080`, whose registration is unambiguous. It is
not a reason to doubt the prefixes — they **are** registered. It is a **stale-text** finding: two
subjects describe as open a question their own changelogs record as closed. No identifier is minted
for it.

### 5.2 ⭐⭐ `S-2` — an `Accepted` ADR determines four register positions that A2 still lists OPEN

`ADR-0078` (**Accepted 2026-08-25**) states in its header:

> **L12** — *"**Closes** | **`LCR-GAP-009`** (A3 §23) **and its A2 antecedents Conflicts 5 and 6** —
> the question *'does the community scope identifier carry a `tenantId`?'*"*

and repeats the identification in its scope-limit table:

> **L200** (§5.1 *Closed*) — *"| A2 **Conflicts 5 and 6** | Same question, upstream form |"*

Its ruling is unconditional:

> **L58** — *"**The community scope identifier carries NO `tenantId`.**"*
> **L63** — *"**BC Map L450 is scoped, not universal.** Its *'every domain event'* means every event
> **from a** tenant-scoped context."*

⭐ **The mapping from "Conflicts 5 and 6" to identifiers is made by the subject itself**, so recording
these positions as determined is *reporting an existing disposition*, not taking a decision:

| A2 line | Routing as written | ⇒ positions |
|---|---|---|
| **L1102** | *"⛔ Architecture Owner decision — `LCF-ADR-005` / `LCF-DEC-003`."* (§20.2, Conflict 5) | `LCF-ADR-005`, `LCF-DEC-003` |
| **L1118** | *"⛔ Architecture Owner decision — `LCF-ADR-006` / `LCF-DEC-003a`."* (§20.3, Conflict 6) | `LCF-ADR-006`, `LCF-DEC-003a` |
| **L1523** | `LCF-ADR-005` — *"Resolve `ID-2` vs library-private community scope"* | register row |
| **L1524** | `LCF-ADR-006` — *"Resolve BC Map L450 … against L488"* | register row |
| **L1697** | `LCF-DEC-003` — *"Choose Option 1, 2 or 3 for tenant scoping (Conflict 5)"* | register row |
| **L1698** | `LCF-DEC-003a` — *"Rule on L450 vs L488 for Global-band events (Conflict 6)"* | register row |

**A2 v0.7 nonetheless still carries these positions as open in six further places**:

| A2 line | Text | Still says |
|---|---|---|
| **L414** | *"Tenant context … Conflict 5 — **unresolved** for `BC-15`"* | unresolved |
| **L1213** | *"`tenantField` \| ⛔ **UNRESOLVED** \| Conflict 5 / Conflict 6. Not specified here."* | unresolved |
| **L1265** | *"`LCF-API-013` \| ⛔ **NOT PROVIDED** \| … cannot be specified **until Conflict 5 resolves**"* | blocked |
| **L1473** | *"⏸ `LCF-AC-035` \| **DEFERRED.** Depends on Conflict 5 (`LCF-ADR-005`)…"* | deferred |
| **L1482** | *"`LCF-RSK-001` \| Conflict 5 … resolves **against** Option 1"* | live risk |
| **L1483** | *"`LCF-RSK-002` \| Conflict 6 … resolves such that `BC-15` events cannot be emitted at all"* | live risk |

The negative probe confirms no record connects them:

| Probe | Result |
|---|---|
| `grep -rn "LCF-ADR-005\|LCF-ADR-006\|LCF-DEC-003a" docs/00-governance/adr/ \| wc -l` | ⛔ **0** |

#### ⛔ 5.2.1 What `S-2` does NOT unblock — stated precisely, not maximally

Read carelessly, `ADR-0078` appears to release both surfaces named at A2 **L1265** and **L1473**.
Read in full, it releases **neither by itself**:

| Surface | Full dependency as written in A2 | Effect of `ADR-0078` |
|---|---|---|
| `LCF-API-013` (search within community) | **L1265**: *"Depends on the **tenant-partitioned index class (`AR-3`)**, which cannot be specified until Conflict 5 resolves"* | Conflict 5 is determined; the **`AR-3` index class is still unspecified** ⇒ API stays ⛔ NOT PROVIDED |
| `LCF-AC-035` (cross-tenant isolation asserted per query) | **L1473**: *"Depends on Conflict 5 (`LCF-ADR-005`). **Also blocked because `integration_test/` does not exist** in the repository."* | Conflict 5 is determined; `ls -d integration_test` → **`No such file or directory`** ⇒ AC stays ⏸ DEFERRED under `LCF-GAP-011` |

⭐ **`S-2` unblocks the tenancy question and unblocks neither the API nor the acceptance criterion.**
Recording it as *"two surfaces now available"* would be exactly the overclaim this pass exists to avoid.

#### ⚠ 5.2.2 One residual `ADR-0078` does not reach

A2 §20.2 **L1091** raises what it calls an honest objection against its own preferred option — that a
`communityId` mapping one-to-one onto a library *may simply be a `tenantId` wearing a different name*.
Probed against the ADR:

| Token searched in `ADR-0078` | Occurrences |
|---|---|
| `communityId` | ⛔ **0** |
| `Option 1` | ⛔ **0** |
| `evasion` | ⛔ **0** |
| `1:1` | ⛔ **0** |
| `wearing` | ⛔ **0** |

⇒ `ADR-0078` rules on the **field** (`BC-15` carries no `tenantId`) and does **not** address the
**semantic** objection. That residual is recorded here and **routed to no one**, because nothing in the
repository assigns it and this record mints no identifier.

### 5.3 ⭐⭐ `S-3` — the `LCF-ADR-*` and `LCF-DEC-*` registers have never been inventoried

`ADR-0082` **L43** states the repository's authoritative open-item count:

> *"`PRD-021A` A2 v0.7 (1,751 lines) and A3 v0.5 (1,253 lines) carry **18** genuinely open items
> between them — **7** `LCF-GAP-*`, **6** `LCR-GAP-*` and **5** `LCR-DEC-*` — plus `LCR-DEC-009`."*

That inventory was tested mechanically against both routing ADRs:

| Instrument | Probe | Result |
|---|---|---|
| `LCF-ADR-*` ids named anywhere in `ADR-0082` | `grep -o "LCF-ADR-[0-9]*" \| wc -l` | ⛔ **0** |
| `LCF-DEC-*` ids named anywhere in `ADR-0082` | `grep -o "LCF-DEC-[0-9]*" \| wc -l` | ⛔ **0** |
| `LCF-ADR-*` ids in `ADR-0081` | `grep -o … \| sort -u` | **1** — `LCF-ADR-001` only, as a cross-reference on `LCF-GAP-009` |
| `LCF-DEC-*` ids in `ADR-0081` | `grep -o … \| wc -l` | ⛔ **0** |
| Either ADR mentions the two subjects at all | `grep -in "pagination\|realtime"` over both | ⛔ **0** |

`ADR-0081` **§1 L27** shows the exclusion is **by construction, not oversight of a single row**:

> *"`PRD-021A` A2 v0.6 and A3 v0.4 carry, between them, **9** open `LCF-GAP-*`, **7** open `LCR-GAP-*`
> and **6** open `LCR-DEC-*`."*

⇒ Three registers are inventoried; **three are not** (`LCF-ADR-*`, `LCF-DEC-*`, `LCR-FND-*`).

#### 5.3.1 Live positions reached by no inventory

| Position(s) | Subject | Owner as written | Corroboration that it is live |
|---|---|---|---|
| `LCF-ADR-003` / `LCF-DEC-005` | **Pagination convention** | Architecture Owner (A2 **L1521**, **L1700**) | A3 **L441**: *"⛔ Pagination convention is **NOT selected here** … routes the convention to the **Architecture Owner** as `LCF-ADR-003` / `LCF-DEC-005`. **A3 selects nothing.**"* — present in **all 5** A3 versions (`grep -c` = 1 in v0.1…v0.5). A2 **L1256**: `LCF-API-004` ⛔ NOT PROVIDED; **L1474**: `LCF-AC-036` ⏸ DEFERRED |
| `LCF-ADR-004` / `LCF-DEC-006` | **Realtime ownership and fan-out** | Architecture Owner (A2 **L1522**, **L1701**) | A2 **L1059–1060**: *"⛔ Owner, edge and fan-out model are an Architecture Owner decision… This part SHALL NOT select one."* **L1266**: `LCF-API-014` ⛔ NOT PROVIDED. **L1689**: *"No bounded context owns the Realtime Engine; no realtime edge exists"* |
| `LCF-DEC-004` | **`ADR-0036` §8.2 question 2** — first day of the three-day protected renewal window | ⭐ **Product Owner** (A2 **L1699**) | A2 **L1699**: *"`LCF-AC-034` stays **UNWRITABLE**; **inherited from A1 (`LCM-DEC-001`)**"* — upstream at A1 **L1436** / **L795** |

#### ⭐ 5.3.2 The corrected statement, published as a delta and **not** as a replacement

> **`ADR-0082`'s count of 18 is correct for the three registers it inventoried.** Across all six
> registers, the open set is **larger by 2** un-inventoried Architecture-Owner acts (pagination,
> realtime) and **smaller by 4** positions now determined by `ADR-0078` (§5.2).

⛔ **`ADR-0082` is not amended, not superseded and not re-statused by this record.** Its **L43** count
stands exactly as written, scoped as written. A PRD-level reassessment has no authority to restatus an
`Accepted` ADR, and §3.1 of this record already declined a smaller version of that same temptation.

### 5.4 ⛔ Why all three findings are disclosed and **not** repaired

The natural repair for `S-1` and `S-2` is an edit to A2 v0.7 (and, for `S-1`, A3 v0.5). Both are barred
on the identical ground that barred `E-1` in §2.2:

| Barrier | Evidence | Measured on disk |
|---|---|---|
| A2 v0.7's sha256 is a **hash anchor inside an `Accepted` ADR** | `ADR-0082` **L421** — *"\| **A2 v0.7** \| — \| `9192a8b1626716b5028678f8120fe0c33554ba03b5aecabab106b72a71bd5c19` \|"* | ✅ **identical** — the anchor is currently **true** |
| A3 v0.5's sha256 is the same kind of anchor | `ADR-0082` **L422** — `6fb17cb1b8ba3a6c5b87ee9eed62687bccee927982a0799b531d841390b191e8` | ✅ **identical** — anchor currently **true** |
| The no-edit posture is already an explicit **decision** | `ADR-0082` **L424** — *"⭐⭐ **A2 and A3 are deliberately NOT EDITED, and that is a decision rather than an omission.** Zero items closed means **zero register cells change**."* | — |

Editing either file in place would falsify verification data inside an `Accepted` ADR and reverse a
posture that ADR states deliberately. ⇒ `S-1`, `S-2` and `E-1` are **all routed to a future A2 v0.8
(and A3 v0.6)**, authored by the part's author, whose changelog can move the register cells lawfully.

---

## 6. Derived `LCR-RS-*` signal states — reported, not re-decided

The nine ranking signals are **not** register items and are **not** reassessed here. They are listed
because §1.4 records `LCR-DEC-008` RESOLVED and §3.1 records `LCR-DEC-009` REFUSED, and a reader is
entitled to see what those two dispositions imply for the weight set. Every cell below is **read from
A3 v0.5 L482–492**; **no weight is assigned, changed or proposed by this record**.

| Signal | Subject | State as written in A3 v0.5 | Weight |
|---|---|---|---|
| `LCR-RS-001` | Recency | ✅ **ACTIVE** | **70** |
| `LCR-RS-002` | Unresolved help priority | ⏸ DEFERRED — no `helpState` field; A2's post-type set is closed (`LCF-FR-027`) | 0 |
| `LCR-RS-003` | **Helpfulness** | 🟡 **ELIGIBLE** — *"substrate authoritative and designated, weight not assigned"* | ⛔ **0** |
| `LCR-RS-004` | Legitimate engagement | ✅ **ACTIVE at v0.4** | **30** |
| `LCR-RS-005` | Official announcement priority | ⏸ DEFERRED — no announcement type, no priority field | 0 |
| `LCR-RS-006` | Social relevance | ⏸ DEFERRED — no `BC-15 → BC-11` edge; BC Map **L292** | 0 |
| `LCR-RS-007` | Already-seen suppression | ⏸ DEFERRED — no per-viewer impression records exist | 0 |
| `LCR-RS-008` | Content-quality penalty | ⏸ DEFERRED — would require `BC-13` anti-spam (`LCF-XC-028`) | 0 |
| `LCR-RS-009` | ~~Community relevance~~ | ⛔ **WITHDRAWN** (P2-1 — constant across the candidate set) | n/a |

**Active set: 70 + 30 = exactly 100.** A3 **L168** records that this *"sums to **100** with no residue
and no rounding"*, satisfying `LCR-FR-035`'s renormalisation obligation.

⭐ **The consequence of `LCR-DEC-009` staying REFUSED (§3.1) is that `LCR-RS-003` stays at weight 0.**
A3 `LCR-FR-028a` (**L494**) makes that lawful rather than defective: *"An `ELIGIBLE` signal — one whose
substrate is authoritative but whose weight has not been assigned by its activation owner — SHALL
likewise contribute exactly zero until a weight is assigned."* ⇒ The ranking model is **internally
consistent while an item remains refused**. Assigning Helpfulness any nonzero weight here would both
invent a product value and break the 100 sum.

---

## 7. ⛔ What this record does NOT do

| # | Not done | Why |
|---|---|---|
| 1 | Does **not** close, reopen, retire or renumber any register position | Register cells live in A2/A3, whose changelogs are the only lawful surface (`PRD_LIFECYCLE.md` §5 rule 5 forbids renumbering) |
| 2 | Does **not** edit A2 v0.7 or A3 v0.5 | §5.4 — their sha256s are hash anchors at `ADR-0082` **L421–422**, and **L424** states the no-edit posture as a decision |
| 3 | Does **not** amend, supersede or restatus `ADR-0082` | §5.3.2 — its **18** stands, scoped as written |
| 4 | Does **not** amend `ADR-0078`, `ADR-0080` or `ADR-0081` | They are `Accepted`; this record only reads them |
| 5 | Does **not** assign a weight to `LCR-RS-003` | §6 — that is `LCR-DEC-009`, formally REFUSED |
| 6 | Does **not** answer `ADR-0036` q2 / `LCF-DEC-004` | Product Owner act; A1 **L1436** marks it ⛔ blocking |
| 7 | Does **not** mint any new identifier | Not for `S-1`, `S-2`, `S-3`, `E-1`, `B-NEW` or `B-28`. Prefix registries are a Governance Owner surface |
| 8 | Does **not** register the `BC-15 → BC-11` edge or extend the Social cluster | §4.1 `B-NEW` — two Architecture Owner acts, neither requested |
| 9 | Does **not** confer Stage 3, 5, 6 or 7, nor claim READY or FROZEN | Stage 3 FAILS Check 2 (`PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT.md`). *"Freeze is conferred, not claimed."* |
| 10 | Does **not** perform `ADR-0075` §8.5 Option B | `PRD-021A_OPTION_B_BLOCKER.md` — owner *"Governance Owner + Architecture Owner"* (`ADR-0075` **L315**), VACANT (`ADR-0080` **L85**) |
| 11 | Does **not** create `A4`–`A8` or define A4's scope | `PRD-021A_A4_NON_EXISTENCE_FINDING.md` — the subject does not exist |
| 12 | Does **not** claim authority | ⛔ **No authority is claimed, and none is needed** — every disposition is either read from an existing document or is an explicit refusal to decide |

### 7.1 Byte-level assertions — 8 files unchanged

Every document this record reasons about is verified **byte-identical** to its state at commit
`2dca733`. Measured at authoring time:

| File | sha256 (first 16) | Status |
|---|---|---|
| `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | `4f35283773f72c82` | ✅ unchanged |
| `docs/10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | `34761df53bfbf149` | ✅ unchanged |
| `docs/10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | `9895d244494372af` | ✅ unchanged |
| `tool/module_dependencies.yaml` | `22e40ac3fe080387` | ✅ unchanged |
| `docs/40-implementation/TRACEABILITY_MATRIX.md` | `bf16eb2de31d2994` | ✅ unchanged |
| `docs/00-governance/DOCUMENTATION_BASELINE.md` | `7e1c69f92363a5e5` | ✅ unchanged |
| ⭐ `…PRD-021A_A2_…_v0.7.md` | `9192a8b1626716b5` | ✅ unchanged — **matches `ADR-0082` L421 exactly** |
| ⭐ `…PRD-021A_A3_…_v0.5.md` | `6fb17cb1b8ba3a6c` | ✅ unchanged — **matches `ADR-0082` L422 exactly** |

⇒ The two hash anchors inside `ADR-0082` remain **true after this record exists**. That is the whole
point of §5.4: the findings are published *without* invalidating the ADR that would have been falsified
by repairing them.

---

## 8. The exact next act

Seven steps, in order. **Steps 3–7 are unavailable to any author who is not the named owner.**

| # | Step | Actor | Available now? |
|---|---|---|---|
| 1 | Author **A2 v0.8**, carrying: the `S-1` prefix corrections (6 lines), the `S-2` `ADR-0078` closures (4 register cells + 6 dependent cells), and the `E-1` self-blocking clause on `LCF-FR-034` / `LCF-FR-096` / `LCF-AUTH-012` | **A2's author** | ✅ **YES** — blast radius pre-measured: A2 v0.7 is cited **10×** across **6** files, max cited line **L1492** of 1,751 ⇒ **0** citations invalidated |
| 2 | Author **A3 v0.6**, carrying the `S-1` `LCR-` prefix corrections (**L89**, **L1016**) | **A3's author** | ✅ **YES** |
| 3 | Re-run Stage 3 Check 2 against A2 v0.8 | PRD author | ⛔ blocked on step 1 |
| 4 | Perform `ADR-0075` §8.5 **Option B** on the 262 bare EA line-citations | **Governance Owner + Architecture Owner** | ⛔ **VACANT** (`ADR-0080` **L85**) |
| 5 | Register the `BC-15 → BC-11` edge in BC Map §7 **and** extend the declared Social cluster (Matrix **L90**) so rule `L2` is not violated | **Architecture Owner** | ⛔ two acts, neither requested; cost **266 lines / 599 citations / 69 files / 8 FROZEN** |
| 6 | Answer `ADR-0036` q2 (`LCF-DEC-004`) and assign the `LCR-RS-003` weight (`LCR-DEC-009`) | **Product Owner** | ⛔ **0** external rulings found (§3.1: 13 / 3 / **0**) |
| 7 | Confer Stage 3, then 5, 6, 7 | **Governance Owner** | ⛔ VACANT; `DOCUMENTATION_BASELINE.md` **L139** currently **denies** PRD-021A readiness |

⚠ Step 1 must **not** be performed by this pass. Authoring A2 v0.8 would require re-deciding which of
A2's 596 identifiers move, and §5.4's barrier exists precisely so that the *version author* — not a
reassessment record — moves the register cells.

---

## 9. Verification

| Check | Expected | Result |
|---|---|---|
| Register positions classified | 58 | ✅ **58** — 21 RESOLVED · 0 EXECUTABLE · 34 BLOCKED · 1 REFUSED · 2 RETIRED |
| §4 sub-count reconciliation | 19 + 6 + 8 + 1 | ✅ **34** (`B-28` excluded as a non-register item; `LCR-FND-001`…`006` counted inside §4.1) |
| New values invented | 0 | ✅ **0** |
| New identifiers minted | 0 | ✅ **0** |
| Owner decisions asserted | 0 | ✅ **0** |
| Register cells changed | 0 | ✅ **0** |
| Frozen files modified | 0 | ✅ **0** |
| Existing repository files modified | 0 | ✅ **0** — this record is a new file only |
| A2 v0.7 / A3 v0.5 byte-identical | yes | ✅ `9192a8b1626716b5` / `6fb17cb1b8ba3a6c` — both **match `ADR-0082` L421–422** |
| 8 tracked-file sha256s vs `2dca733` | 8/8 | ✅ **8/8** (§7.1) |
| Accepted ADRs amended or restatused | 0 | ✅ **0** |
| Citations invalidated | 0 | ✅ **0** — no cited file's line numbering moves |
| Stage conferred | none | ✅ **none** — Stage 3 FAILS Check 2 |
| READY / FROZEN claimed | no | ✅ **no** |
| Line-number errors self-corrected | disclosed | ✅ 3 corrected and **both figures published** (§5 preamble) |
| Classifier overrides disclosed | disclosed | ✅ `LCR-DEC-009` (§3.1) — marker scan said `RESOLVED?`, read text says *"expressly **NOT** resolved"* |

### 9.1 Determination

⛔ **`PRD-021A` remains NOT READY and NOT FROZEN.**

This record closes **nothing** and unblocks **nothing**. Its value is that it makes four positions'
**already-existing** determination visible (`S-2`), names two live Architecture-Owner acts that **no
inventory reached** (`S-3`), and records a subject document that **contradicts itself** (`S-1`) — while
leaving every hash anchor, every frozen file, every `Accepted` ADR and every register cell exactly as
it found them.

*"A gap closed without authority is not progress; it is an invented requirement wearing a closure
marker."* — `ADR-0081` **L20–21**
