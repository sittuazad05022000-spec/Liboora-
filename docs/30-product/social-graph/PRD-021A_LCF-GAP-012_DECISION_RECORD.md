# `PRD-021A` Owner Decision Record — Community Comments & Reactions **SHIP**, and the six owner rulings that followed

| Field | Value |
|---|---|
| **Document** | `PRD-021A` authoritative Owner Decision Record. Originally the `LCF-GAP-012` / `LCR-DEC-002` record (D2-P); **extended at v2.0** to carry every subsequent owner ruling. ⭐ **This is the single decision record for `PRD-021A`** — see §7.0 |
| **Version** | **v2.0** — 2026-08-25. v1.0 retained in full below (§1–§6) and in repository history |
| **Decision** | **Community Comments and Community Reactions are IN SCOPE and SHALL SHIP in the current `PRD-021A` generation** |
| **Product Owner** | ✅ **DECIDED** — SHIP (v1.0, §1) **and**, at v2.0: reaction kinds `LIKE`/`HELPFUL`/`CELEBRATE` (§7.2), `HELPFUL` = the helpfulness signal (§7.3), Recency `70` / Legitimate engagement `30` (§7.4) |
| **Architecture Owner / ARB** | ✅ **DECIDED at v2.0** via four ADRs — `ADR-0075` (EA enumeration, D2-A-i), `ADR-0076` (citation repointing, D2-A-ii), `ADR-0077` (Privacy Owner role), `ADR-0078` (`LCR-GAP-009` tenancy). See §7.5–§7.8 |
| **`LCF-GAP-012` status** | ✅ **RESOLVED — narrow the exclusion, preserve the specification** |
| **`LCF-GAP-013` status** | ✅ **RESOLVED at v2.0** by **`ADR-0076`** — §7.6 |
| **Subject** | v1.0: A2 v0.4 → **v0.5**, A3 v0.2 → **v0.3**. **v2.0:** A2 v0.5 → **v0.6**, A3 v0.3 → **v0.4**, EA v2.2 → **v2.3**, `PRD_OWNERSHIP_MODEL.md` v1.1 → **v1.2** |
| **Authority basis** | `PRD_OWNERSHIP_MODEL.md` **§2.2 L83** (Product Owner — *"whether a requirement is correct and **in scope**"*) and **§2.2 L85** / **§5** (Architecture Owner — *"ADR approval; any Rank 1–5 document change"*) |
| **Release gate** | ⛔ **NOT READY · NOT FROZEN · NOT RELEASED.** `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** gates `PRD-021` behind `PRD-020`, which is unranked `DRAFT`. Unchanged by v2.0 — see §7.11 |

> ⚠⚠⚠ **READ §7.0 FIRST — the blockquote below is v1.0 text and is SUPERSEDED in five respects.**
>
> **What this record was at v1.0.** It documents the Product Owner's scope decision and the
> amendments it authorises. It does **not** amend the Enterprise Architecture, does **not** raise or
> accept an ADR, does **not** mint a bounded context, edge, aggregate, event, permission or
> storage model, does **not** resolve `LCF-GAP-013`, does **not** enumerate the reaction kind
> set, does **not** assign any ranking weight, and freezes nothing.
>
> ⭐ **What v2.0 changes.** Five of those disclaimers are **superseded by owner ruling** — the EA
> **is** amended (`ADR-0075`), four ADRs **are** raised and accepted (`ADR-0075`…`ADR-0078`),
> `LCF-GAP-013` **is** resolved (`ADR-0076`), the reaction kind set **is** enumerated (§7.2), and
> ranking weights **are** assigned (§7.4). **Two disclaimers survive unchanged and are binding:**
> **no** bounded context, edge, aggregate, event, permission or storage model is minted, and
> **nothing is frozen**. §1–§6 are preserved verbatim as the v1.0 record; **§7 is authoritative
> where the two differ.**

---

## 1. The decision as taken

**Product Owner ruling, recorded verbatim:**

> *"I explicitly decide that Community Comments and Community Reactions are IN SCOPE and
> SHALL SHIP in the current PRD-021A generation. This is an explicit Product Owner scope
> decision."*

| Approver | Required because | Status |
|---|---|---|
| **Product Owner** | `PRD_OWNERSHIP_MODEL.md` §2.2 — *"whether a requirement is correct and **in scope**"*. Shipping scope is precisely this | ✅ **DECIDED — SHIP** |
| **Architecture Owner (ARB)** | §2.2 — *"ADR approval; **any Rank 1–5 document change**"*. Not engaged by this record; A2 and A3 are unranked DRAFTs | ⏳ **PENDING** for D2-A-i / D2-A-ii only |

**Why no ARB approval is required for the A2/A3 amendments themselves.** `PRD_REGISTRY.md`
**L321** carries `PRD-021` as **`PLANNED`**, and both A2 and A3 declare
*"NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED"*. Neither is a Rank 1–5 artefact, so
`DOCUMENTATION_BASELINE.md` §7 step 1 is not triggered. The amendments below change **no**
Rank 1–5 document.

---

## 2. What the decision resolves

| Item | Before | After |
|---|---|---|
| `LCF-GAP-012` (A2 L1491) | 🔴 OPEN — Product Owner | ✅ **RESOLVED** — exclusion narrowed, specification preserved |
| `LCR-DEC-002` (A3 L870) | 🔴 OPEN — Product Owner | ✅ **RESOLVED** by this record |
| A2 `LCF-XC-017` (L192) | Excluded *"Comments, reactions, threads, mentions"* | Narrowed to **threads and mentions only** |
| A2 comment/reaction requirements | Contradicted by the exclusion | **Preserved unchanged** — nothing deleted |

**The chosen resolution is the narrowing option, not the deletion option.** A2 **L1491**
records that deletion *"would violate 'invent, remove, merge, split no requirement'"*. The
Product Owner's SHIP decision selects narrowing, so **no requirement is removed**. All ~14
already-specified identifiers stand exactly as written:

`LCF-INV-002` (L241–242) · ownership rows 2–3 (L277–278) · `LCF-AUTH-006`/`007` (L665/667) ·
`LCF-FR-080`–`084` (L833–843) · `LCF-BR-010` (L847) · `CommunityComment` /
`CommunityReaction` field tables (L1065–1083) · `LCF-API-008`–`011` (L1110–1113) ·
`LCF-EVT-005`/`006` (L1143–1144).

---

## 3. Release class — **determined, not chosen**

The capability's release class follows from **Rank 1** authority and is therefore a
determination, not a decision this record takes:

| Authority | Rank | Text |
|---|---|---|
| `MASTER_PRD.md` **L92** `MP-SCOPE-04` | **1** | Content Sharing (`BC-14`), Community & Groups (`BC-15`) → **V2** |
| A2 `LCF-FR-026` (L396–397) | — | *"This part SHALL NOT require any V3 capability."* |
| A2 `LCF-INV-002` (L241–242) | — | `BC-15` is sole owner of `CommunityPost`, `CommunityComment`, `CommunityReaction` |

Both aggregates are `BC-15`-owned children of `CommunityPost`. `BC-15` is **V2** by Rank 1.
**Therefore comments and reactions are V2.**

⚠ **This is explicitly NOT an inference from EA L989 `Comments (V3)`.** That entry sits under
**Notes Sharing**, a different capability branch, and is unrelated. The V2 classification
rests on `MP-SCOPE-04` alone.

---

## 4. What this record did **NOT** decide *(v1.0 — see §7 for what changed)*

⚠ **§4.1, §4.2, §4.3 and §4.4 are all SUPERSEDED.** Each is retained verbatim because it records
the measurement and the reasoning that the later rulings acted on. The **status** lines below are
annotated; **no analytical text is altered**.

### 4.1 D2-A-i — EA enumeration ✅ **RESOLVED at v2.0 by `ADR-0075`** *(was ⏳ ARCHITECTURE OWNER)*

**Measured state of `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (v2.2, Rank 6):**

- The `Community (V2)` block (**L967–973**) enumerates six children. **Comments and reactions
  are absent from both.**
- `grep -c -i 'reaction'` over the whole EA → **0 occurrences**. Reactions have **no EA node
  at any version**.

**Why this record does not amend the EA.** `MASTER_PRD.md` **L519** `MP-CON-08` (Rank 1): the
EA *"is descriptive, not prescriptive… sits at precedence rank 6… the higher-ranked document
wins and the Enterprise Architecture is updated to match — never the reverse. **A disagreement
is a defect to be raised, not a choice to be made.**"* `DOCUMENTATION_BASELINE.md` §3.2
**L139**: *"must follow the PRDs, never lead them."*

Adding EA nodes is governed by **EA §10.5** (L2438–2445): propose as ADR → verify Single
Owner Rule → assign a version tag per §10.3 → update and bump the header → register the
cross-module dependency. **That is an Architecture Owner act.** Choosing *whether* to add two
new nodes or treat both as implicit within `Community Feed (V2)` (L970) is a genuine
architectural choice this record has no authority to make.

⭐ **The version question is already answered (§3, V2 by Rank 1). Only the EA *enumeration*
remains.** Per `MP-CON-08` this is *"a defect to be raised"* — and it is hereby raised, not
resolved. Referred as A3 §37.2 `LCR-FND-007`…`012`.

### 4.2 D2-A-ii — `LCF-FR-026` citation ✅ **RESOLVED at v2.0 by `ADR-0076`** *(was ⏳ ARCHITECTURE OWNER)*

`LCF-FR-026` (A2 L396–397) names *"`Moderation (V3)` and `Community Analytics (V3)`"* but
cites `LCF-XC-016` (rate-limit authorship) and `LCF-XC-017` (comments/reactions). The correct
targets are `LCF-XC-006` (moderation, L181) and `LCF-XC-029` (community analytics, L204).

**Deliberately NOT corrected.** A2 **L1492**: *"the original intent is ambiguous, and guessing
it would be a silent architectural decision."* `LCF-GAP-013` remains **OPEN — Architecture
Owner**.

⚠ **Disclosure.** Narrowing `LCF-XC-017` (§2) does **not** worsen `LCF-GAP-013`.
`LCF-XC-016` and `LCF-XC-017` never covered `Moderation (V3)` or `Community Analytics (V3)`
under any reading, so the mis-citation is unchanged in substance by this amendment.

### 4.3 The reaction kind set ✅ **RESOLVED at v2.0 — see §7.2** *(was 🔴 OPEN — PRODUCT OWNER, `LCF-GAP-014`)*

⭐ **A measured obligation of A2 is unsatisfied, and SHIP makes it live.**

`LCF-BR-010` (A2 **L847**): *"The reaction kind set SHALL be closed and SHALL be defined in
this part's data model (§22)."*

But §22 **L1082** states only: `` `kind` | Closed set | `LCF-BR-010`; not client-extensible ``.
**The set is never enumerated.** Verified by grep — no candidate kind appears anywhere in A2.
Contrast `LCF-FR-027` (L431), which *does* enumerate: *"exactly `TEXT`, `NOTE`, `MEDIA`,
`LINK`"*.

**Consequence.** While reactions now ship, **no individual reaction kind can be identified**.
Any ranking signal that must distinguish a *helpful* reaction from any other kind therefore
still has no substrate. Enumerating the set would be **inventing requirements**, which this
record does not do. Recorded as new A2 defect **`LCF-GAP-014`** and routed to the **Product
Owner**.

### 4.4 Ranking weights ✅ **RESOLVED at v2.0 — see §7.4** *(was 🔴 OPEN — PRODUCT OWNER)*

A3 `LCR-FR-034`: *"No reserved weight is published here… Weights are assigned when a signal
activates, by whoever owns its activation."* `LCR-FR-033` requires active weights to sum to
exactly `100`.

This record decides **scope**, not **values**. It therefore does **not** assign a weight to
any signal, and A3's active set is unchanged at `LCR-RS-001` Recency = **100**.

---

## 5. Amendments authorised by this record

| # | File | Change | Authority |
|---|---|---|---|
| 1 | A2 → **v0.5** | Narrow `LCF-XC-017` to threads/mentions; mark `LCF-GAP-012` RESOLVED; record `LCF-GAP-014`; register/count corrections | This record §1–§2 |
| 2 | A3 → **v0.3** | Resolve `LCR-DEC-002`; narrow `LCR-GAP-003`; `LCR-RS-004` substrate becomes authoritative; `LCR-RS-003` stays deferred on §4.3 | Upstream A2 v0.5 |

**Not amended:** `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (§4.1) ·
`LIBOORA_BOUNDED_CONTEXT_MAP.md` · `MASTER_PRD.md` · `PRD-023` · `ADR-0017` · `ADR-INDEX.md` ·
A1 v0.2 · A2 v0.3/v0.4 · A3 v0.1/v0.2 — all preserved.

**Created:** nothing. No bounded context, integration edge, aggregate row, event, permission,
storage model, configurable or ADR. `LCF-ADR-001` (BC Map §8 row) and `LCF-ADR-002`
(`BC-15 → BC-14` edge) remain **pre-existing open Architecture Owner items**, neither created
nor resolved here.

---

## 6. Remaining blockers after this record

| ID | Subject | Owner | Status at v1.0 | ⭐ Status at v2.0 |
|---|---|---|---|---|
| `LCF-GAP-013` | `LCF-FR-026` citation (D2-A-ii) | **Architecture Owner** | 🔴 OPEN | ✅ **RESOLVED** — `ADR-0076` |
| `LCF-GAP-014` | Reaction kind set unenumerated (`LCF-BR-010`) | **Product Owner** | 🔴 OPEN — new | ✅ **RESOLVED** — §7.2 |
| `LCR-FND-007`…`012` | EA enumeration of comments/reactions (D2-A-i) | **Architecture Owner** | ⏳ RAISED | ✅ **CLOSED** — `ADR-0075` (`LCR-FND-013`) |
| `LCF-ADR-001` / `LCF-DEC-001` | BC Map §8 aggregate row for `BC-15` | **Architecture Owner** | 🔴 OPEN — pre-existing | 🔴 **STILL OPEN** — `ADR-0078` §2.5 expressly declines it |
| `LCF-ADR-002` / `LCF-DEC-002` | `BC-15 → BC-14` edge | **Architecture Owner** | 🔴 OPEN — pre-existing | 🔴 **STILL OPEN** |
| `LCR-GAP-003` | Which reaction kind denotes helpfulness | **Product Owner** | 🔴 OPEN — narrowed | ✅ **RESOLVED** — §7.3, `HELPFUL` |

**Neither A2 nor A3 becomes freezable through this record.** Both remain **DRAFT — NOT
FROZEN**, and A3 remains **NOT READY**. ⭐ **That is still true at v2.0** — §7.11.

---

*End of the v1.0 record. Sections 1– 6 above decide **scope only**. Section 7 below carries the
v2.0 rulings.*

---

## 7. v2.0 — the owner rulings received after v1.0

### 7.0 ⭐ Why this section is here and not in a new file

`PRD-021A` has exactly **two** decision artefacts, and they have distinct jobs:

| File | Job | State |
|---|---|---|
| **this file** | The **authoritative record of decisions taken** | ✅ Extended to **v2.0** |
| `PRD-021A_OWNER_DECISION_REQUEST.md` | The **request** put to the owners, with its signature blocks | ✅ Annotated **ANSWERED** at v1.1 |

⛔ **No third artefact was created.** A parallel "second decision record" would produce two
documents claiming to record the same rulings, which is the duplicate-authority defect
`ADR-INDEX` Process rule 2 exists to prevent. The v1.0 text above is preserved **verbatim**;
where v1.0 and §7 differ, **§7 governs** and the difference is named explicitly.

### 7.1 The rulings, as received

| # | Item | Ruling | Owner | Instrument |
|---|---|---|---|---|
| 1 | `LCF-GAP-014` | Reaction kinds = **`LIKE`, `HELPFUL`, `CELEBRATE`** | **Product Owner** | §7.2 → A2 v0.6 §22 |
| 2 | `LCR-GAP-003` | **`HELPFUL`** is the helpfulness signal | **Product Owner** | §7.3 → A3 v0.4 `LCR-RS-003` |
| 3 | `LCR-DEC-008` | Recency = **70**, Legitimate engagement = **30**, total = **100** | **Product Owner** | §7.4 → A3 v0.4 §12.1 |
| 4 | D2-A-i | Community Comments/Reactions = **V2** in the EA | **Architecture Owner** | **`ADR-0075`** |
| 5 | D2-A-ii | Citation targets chosen by ruling, **not** by guess | **Architecture Owner** | **`ADR-0076`** |
| 6 | Privacy | **Establish the Privacy Owner role**; invent no approval | **Architecture Owner** | **`ADR-0077`** |
| 7 | `LCR-GAP-009` | Rank-4 tenancy conflict resolved by explicit ruling | **Architecture Owner** | **`ADR-0078`** |

### 7.2 `LCF-GAP-014` ✅ RESOLVED — the reaction kind set is enumerated

**Product Owner ruling.** The `CommunityReaction.kind` set is exactly:

```
LIKE, HELPFUL, CELEBRATE
```

This satisfies A2 **`LCF-BR-010`** — *"The reaction kind set SHALL be closed and SHALL be defined
in this part's data model (§22). It SHALL NOT be client-extensible."* That obligation was measured
**UNSATISFIED** at v0.5 (§4.3); it is satisfied at A2 **v0.6**.

The enumeration follows the shape A2 already uses for its other closed set, **`LCF-FR-027`**:
*"The post type set SHALL be exactly `TEXT`, `NOTE`, `MEDIA`, `LINK`. No fifth type SHALL be added
without a PRD amendment."* The reaction set is recorded with the same closure discipline: **a
fourth kind requires a PRD amendment.**

⛔ **No storage model, event or API is minted by this enumeration.** `CommunityReaction`,
`LCF-API-008`…`011` and `LCF-EVT-005`/`006` already existed at v0.4; the field's *domain* is now
stated. `LCF-FR-084`'s aggregate-count-only rule is unchanged: the summary counts **per kind** and
still **SHALL NOT** enumerate reacting members (`LCF-SEC-011`).

### 7.3 `LCR-GAP-003` ✅ RESOLVED — `HELPFUL` is the helpfulness signal

**Product Owner ruling.** **`HELPFUL`** denotes helpfulness for A3's `LCR-RS-003`.

This was the **narrowed** residue of `LCR-GAP-003`: at v0.3 the question was no longer *"do
comments/reactions exist"* (answered) but *"which reaction kind denotes helpful"*. §7.2 supplies a
kind set containing exactly one such member, and this ruling designates it.

⭐ **`LCR-FR-044` is satisfied, not bypassed.** It requires that A3 *"SHALL NOT infer helpfulness
from any proxy — including reaction volume, comment volume or any aggregate count. A helpful signal
requires an **explicit** helpful indication."* `HELPFUL` **is** an explicit indication: a member
selects it deliberately. The signal reads the `HELPFUL` count specifically, **not** total reaction
volume — which is what keeps `LCR-RS-003` (helpfulness) and `LCR-RS-004` (engagement) distinct
rather than collapsing one into the other.

### 7.4 `LCR-DEC-008` ✅ RESOLVED — Recency 70 / Legitimate engagement 30

**Product Owner ruling.** The active weight set is:

| Signal | Weight |
|---|---|
| `LCR-RS-001` Recency | **70** |
| `LCR-RS-004` Legitimate engagement | **30** |
| **Total** | **100** |

This discharges the two requirements that had made the weight the sole barrier:

| Requirement | Discharged how |
|---|---|
| **`LCR-FR-033`** — *"The active weights SHALL sum to exactly `100`"* | 70 + 30 = **100** exactly |
| **`LCR-FR-034`** — *"Weights are assigned when a signal activates, by whoever owns its activation"* | Assigned by the **Product Owner**, the named activation owner. Not defaulted, not inferred |
| **`LCR-FR-035`** — renormalise the active set to exactly 100 on activation | Recency renormalised 100 → 70 in the same act |

⭐ **No new substrate was needed, and none was created.** A2 **`LCF-FR-061`** already publishes
*"comment count, reaction summary"* per post in the feed response, and **`LCF-FR-084`** defines the
summary as an aggregate count per kind. A3 v0.3 had already measured this and marked
`LCR-RS-004` **🟡 ELIGIBLE — substrate authoritative, weight not assigned**. The ruling supplies
only the missing value.

⛔ **`LCR-BR-010` and `LCR-BR-010a` are preconditions of activation, not notes for later.**
Engagement SHALL be capped so it can never independently determine ordering, SHALL exclude
self-engagement, SHALL be deduplicated per actor, and SHALL be derived **only** from the aggregate
counts A2 publishes — with **no** per-actor engagement record retained.

⚠ **`LCR-RS-003` Helpfulness is designated but carries weight `0`.** §7.3 resolves *which kind*
means helpful; it does **not** assign a weight. `LCR-FR-034` reserves that to the activation owner,
and no ruling supplied one. Per **`LCR-FR-028a`** the signal therefore contributes **exactly
zero**, and it is recorded as **🟡 ELIGIBLE**, not ACTIVE. **Inventing a third weight to "complete"
the model would be the exact act `LCR-FR-034` forbids** — and would break the sum of 100.

### 7.5 D2-A-i ✅ RESOLVED — `ADR-0075`

The EA `Community (V2)` block now enumerates **`Community Comments (V2)`** and **`Community
Reactions (V2)`**. EA `v2.2` → **`v2.3`**; `DOCUMENTATION_BASELINE.md` §3.2 **L139** updated in the
same commit; **baseline identifier deliberately NOT advanced** (§7 step 4 — the EA is Rank 6).

⭐ **The `V2` tag was determined, not chosen** — `MP-SCOPE-04` (Rank 1) already places `BC-15` at
V2, so EA §10.5 step 3 reproduces a Rank 1 determination. This is `MP-CON-08`'s mandated
direction: **Rank 6 follows Rank 1, never the reverse.** `MASTER_PRD.md` is **not** edited.

### 7.6 D2-A-ii ✅ RESOLVED — `ADR-0076`, and the ruling did **not** guess

`LCF-FR-026`'s citations are repointed **`LCF-XC-016` → `LCF-XC-006`** (moderation) and
**`LCF-XC-017` → `LCF-XC-029`** (community analytics).

⭐ **The instruction was *"do not guess"*, and the ADR does not.** §4.2 above recorded two
"defensible candidates" per subject. `ADR-0076` §2.2 eliminates one of each from the candidates'
**own** published authority:

- **`LCF-XC-028` is eliminated on version** — it cites EA **L919** `Anti-Spam & Rate Limits`
  **(V1)**. A V1 node cannot ground a **V3** exclusion.
- **`LCF-XC-029` is selected on exact line identity** — it is the only exclusion row citing EA
  **L973**, one of the two lines `LCF-FR-026` itself names (`EA L972–973`).
- **`LCF-XC-006`** is the moderation-subject exclusion, covering EA **L972**.

⛔ **No exclusion row's subject text changed.** Only two pointer tokens moved, inside the
`ADR-0015` precedent's stated limit of *"three named cells in one named file"*.

### 7.7 Privacy ✅ ROLE ESTABLISHED — `ADR-0077`

The **Privacy Owner** role is now recorded in `PRD_OWNERSHIP_MODEL.md` (**v1.1 → v1.2**).

⭐ **It was derived, not invented.** §2.1 of that document derives roles from existing rules and
closes *"a fifth would have no rule to serve"*. **Five** rules already require a privacy review
with no role to perform it — `ARCHITECTURE_RULINGS.md` **L290** (Rank 5), `Library_PRD_v1.md`
**L1025** (`LIB-24.2`, Rank 3 **FROZEN**), `PRD-020` **L1784** (`TSF-GAP-016`, which uses the words
*"the privacy owner"* verbatim), `SEAT-GAP-014`, and the baseline/roadmap deferral rows. The
minimality clause is a **conditional test**; it is met, and it is **preserved rather than deleted**.

⛔⛔ **CONSTITUTING THE ROLE IS NOT EXERCISING IT.** No privacy approval is invented, implied or
pre-judged. **`LCR-DEC-003` and `LCR-GAP-006` remain OPEN**, `LCR-RS-007` **Already-seen
suppression** remains **⏸ DEFERRED**, and every other deferred privacy item stays deferred. No
personal name is recorded (§7 rule 4), and no incumbent is assigned.

### 7.8 `LCR-GAP-009` ✅ RESOLVED — `ADR-0078`

**The community scope identifier carries no `tenantId`.**

⭐ **The ruling does not pick one Rank 4 rule over another** — which is what made the question
*"structurally unarbitrable"* in the Owner Decision Request §6. `ADR-0078` §2.2 adds a **third**
measurement neither prior analysis had made: BC Map **L424–428** already registers **five**
`identity.*` domain events from **`BC-10`**, a context BC Map **L487** declares **Global, no
`tenantId`**, enforced by `ADR-0011`'s `banned_symbols` check. So L450's *"every domain event"* is
**already scoped** by `ID-2`/`ID-3` — a universal reading would convict the BC Map, an Accepted ADR
and a passing CI gate of error at five of the map's own rows.

`ID-3` (**L180**) is decisive independently: a `tenantId` on a community event would let any
consumer resolve which library a member attends from a Global Student surface — the leak `ID-3`
exists to prevent, over a minor-inclusive population.

⛔ **The BC Map is byte-unchanged.** L450's fail-loud disposition is preserved and **strengthened**
into an explicit no-defaulting prohibition (`ADR-0078` §2.4). ⚠ L450's *wording* is a genuine Rank 4
clarity defect — **disclosed and routed** to the Architecture Owner, **not repaired** here.

### 7.9 Amendments authorised by v2.0

| # | File | Change | Instrument |
|---|---|---|---|
| 1 | A2 v0.5 → **v0.6** | ✅ **DONE.** Enumerate `kind` as exactly `LIKE`/`HELPFUL`/`CELEBRATE` (§22); clear the `LCF-BR-010` UNSATISFIED block and mint `LCF-BR-010a`; `LCF-GAP-014` **RESOLVED**; repoint `LCF-FR-026` to `LCF-XC-006`/`LCF-XC-029`. ⚠ **`LCF-GAP-013` is HALF RESOLVED, not RESOLVED** — the citation half is closed by `ADR-0076`, but the **EA enumeration** half remains **OPEN** because `ADR-0075`'s execution is **BLOCKED** (§7.10a). ⚠ Also corrects v0.5's stale observation that named `ADR-0066` as the next free number: **`ADR-0066` was deliberately NOT created and does not exist** — `0066`–`0073` are earmarked by `PRD-020` **§29.2** | §7.2, §7.10a, `ADR-0076` |
| 2 | A3 v0.3 → **v0.4** | `LCR-RS-003` + `LCR-RS-004` activated; §12.1 → 70/30; `LCR-GAP-003` + `LCR-DEC-008` RESOLVED; `LCR-GAP-009` RESOLVED; `LCR-FND-013` closed | §7.3, §7.4, `ADR-0078`, `ADR-0075` |
| 3 | EA v2.2 → **v2.3** | Two nodes added under `Community (V2)`; §11 changelog | **`ADR-0075`** |
| 4 | `DOCUMENTATION_BASELINE.md` | §3.2 **L139** EA version cell only (§7 step 3) | **`ADR-0075`** |
| 5 | `PRD_OWNERSHIP_MODEL.md` v1.1 → **v1.2** | Privacy Owner derived into §2.1, §2.2, §2.3, §5, §8 | **`ADR-0077`** |
| 6 | `ADR-INDEX.md` | Four rows added; **Count re-derived**, not incremented | `ADR-0075`…`0078` |
| 7 | `PRD-021A_OWNER_DECISION_REQUEST.md` → **v1.1** | Annotated **ANSWERED**; no duplicate created | §7.0 |

**Not amended:** `MASTER_PRD.md` · `LIBOORA_BOUNDED_CONTEXT_MAP.md` · `ARCHITECTURE_RULINGS.md` ·
`PRD_LIFECYCLE.md` · `PRD_REGISTRY.md` · every **FROZEN** PRD (`PRD-017`, `PRD-023`, `PRD-014`,
`PRD-016`, `PRD-013`, `PRD-012a`, `PRD-008`) · every **Accepted** ADR · A1 v0.2 · A2 v0.3/v0.4 ·
A3 v0.1/v0.2 · all code, tests and gates.

**Created:** four ADRs (`ADR-0075`…`ADR-0078`) and nothing else. ⛔ **No** bounded context, edge,
aggregate row, event, permission, role-in-the-closed-set, storage model or configurable.

### 7.10 ⭐⭐ ADR numbering — a carried-forward assumption corrected

⚠ **A2 v0.5 records at three places (§31, §33 audit row 10, §35) that *"the next free number is
`ADR-0066`"*. That observation is measurably WRONG, and A2 v0.6 corrects it.**

Measured at HEAD `c563931`:

| Number | Reference count | Status |
|---|---|---|
| `ADR-0066` … `ADR-0073` | 32, 11, 5, 13, 2, 2, 2, 14 | ⛔ **EARMARKED** by `PRD-020` **§29.2** — a 9-row table assigning each a named subject and owner. **`ADR-0069` is marked "DO NOT OPEN"** |
| `ADR-0074` | 36 | ⚠ Named as the reserved next number by **8** `PRD-020` artefacts, but `PRD-020_BLOCKER_RESOLUTION_AUDIT.md` **L125** finds *"`ADR-0074` is NOT required. It has not been written."* |
| **`ADR-0075`, `0076`, `0077`, `0078`** | **0, 0, 0, 0** | ✅ **Wholly unreferenced — lawful** |

`PRD_LIFECYCLE.md` **§5 rule 5**: *"Numbers are never reused, even after withdrawal."* Minting
`ADR-0066` would therefore have collided with an earmarked `BC-13` decision. **`ADR-0075` is the
lowest number that is neither earmarked nor contested**, and `0075`–`0078` are used in order.

⛔ `PRD-020` §29.2 and the blocker audit were read as **authority** and left **byte-unchanged**.
The `ADR-0074` contradiction between them is a **pre-existing `PRD-020` defect**, **disclosed here
and not resolved** — it belongs to `PRD-020`'s owner.

### 7.11 ⛔⛔ Release gating — unchanged and binding

| Question | Answer |
|---|---|
| Is `PRD-021A` **READY**? | ⛔ **NO** |
| Is any part **FROZEN**? | ⛔ **NO** |
| Is anything **RELEASED**? | ⛔ **NO** |
| Is anything **BASELINED**? | ⛔ **NO** |

`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164**: *"`PRD-021` must not ship before `PRD-020`…
a release-blocking defect, not a schedule change."* `PRD-020` is **unranked `DRAFT`**.

Independently, blockers remain open on their own merits: the `LCF-`/`LCR-` **prefixes are
unratified** (`LCF-GAP-001`, `LCR-GAP-001` — Governance Owner, itself an undefined role per
`ADR-0077` §4.2), **BC Map §8 has no `BC-15` aggregate row** (`LCF-GAP-009` / `LCR-DEC-007`), the
**`BC-15 → BC-11` edge is unregistered** (`LCR-FND-001`…`006`), `integration_test/` **does not
exist** (`LCF-GAP-011`), and no privacy review is discharged (`LCR-DEC-003`).

⭐ **Resolving seven blockers advanced zero stages, and that is the correct outcome.** A2 remains
**DRAFT — NOT FROZEN**; A3 remains **NOT READY — NOT FROZEN**.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-24 | Created. Records the Product Owner `LCF-GAP-012` SHIP decision (D2-P) and authorises A2 → v0.5, A3 → v0.3. Four items left explicitly undecided (§4.1–§4.4) |
| **v2.0** | **2026-08-25** | ⭐ **Extended in place — no second decision record created** (§7.0). Carries seven owner rulings: reaction kinds `LIKE`/`HELPFUL`/`CELEBRATE`; `HELPFUL` = helpfulness; Recency 70 / engagement 30 = **exactly 100**; EA enumeration at V2 (`ADR-0075`); citation repointing **by measurement, not guess** (`ADR-0076`); Privacy Owner **derived** from five existing rules (`ADR-0077`); `LCR-GAP-009` resolved by scoping L450 against a **third** measurement, with the BC Map **byte-unchanged** (`ADR-0078`). §4.1–§4.4 annotated SUPERSEDED with their reasoning preserved verbatim. ⚠⚠ **Corrects a carried-forward error: the next free ADR number was NOT `ADR-0066`** — `0066`–`0073` are earmarked by `PRD-020` §29.2 and `0074` is contested, so `0075`–`0078` were used (§7.10). ⛔ **Three disclosed and NOT repaired:** the `Governance Owner` role gap, `MASTER_PRD.md`'s 10 stale `v2.1` EA citations (`Q-A6`), and BC Map L450's wording. ⛔ **`READY` / `FROZEN` / `RELEASED` NOT claimed** (§7.11) |

*End of Decision Record v2.0. Seven blockers resolved, zero stages advanced, nothing frozen.*
