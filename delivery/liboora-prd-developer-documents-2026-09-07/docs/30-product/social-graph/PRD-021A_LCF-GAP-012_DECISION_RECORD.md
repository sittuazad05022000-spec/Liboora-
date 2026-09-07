# `PRD-021A` Owner Decision Record — Community Comments & Reactions **SHIP**, and the six owner rulings that followed

| Field | Value |
|---|---|
| **Document** | `PRD-021A` authoritative Owner Decision Record. Originally the `LCF-GAP-012` / `LCR-DEC-002` record (D2-P); **extended at v2.0** to carry every subsequent owner ruling. ⭐ **This is the single decision record for `PRD-021A`** — see §7.0 |
| **Version** | **v2.2** — 2026-08-25. v2.1, v2.0 and v1.0 retained in full below. ⛔ **v2.2 closes NOTHING**: it records that **Stage 7 is NOT ENTERABLE**, that **all 18 `LCF`/`LCR` items remain OPEN**, and that `READY`/`FROZEN` are **REFUSED** — see **§7.13** |
| **Decision** | **Community Comments and Community Reactions are IN SCOPE and SHALL SHIP in the current `PRD-021A` generation** |
| **Product Owner** | ✅ **DECIDED** — SHIP (v1.0, §1) **and**, at v2.0: reaction kinds `LIKE`/`HELPFUL`/`CELEBRATE` (§7.2), `HELPFUL` = the helpfulness signal (§7.3), Recency `70` / Legitimate engagement `30` (§7.4). ⛔ **STILL OWED at v2.1: a helpfulness weight.** `LCR-DEC-009` is **REFUSED as undecidable** by `ADR-0081` §2 rather than answered — §7.12.3 |
| **Architecture Owner / ARB** | ✅ **DECIDED at v2.0** via four ADRs — `ADR-0075` (EA enumeration, D2-A-i), `ADR-0076` (citation repointing, D2-A-ii), `ADR-0077` (Privacy Owner role), `ADR-0078` (`LCR-GAP-009` tenancy). See §7.5–§7.8. ⭐ **Extended at v2.1** by `ADR-0079` (the EA enumeration **executed**) and `ADR-0081` §3 — see §7.12 |
| **`LCF-GAP-012` status** | ✅ **RESOLVED — narrow the exclusion, preserve the specification** |
| **`LCF-GAP-013` status** | ✅ **FULLY RESOLVED at v2.1.** The **citation** half was closed at v2.0 by **`ADR-0076`** (§7.6). ⭐ The **enumeration** half — `BLOCKED` at v2.0 — is closed by **`ADR-0079`**, which **EXECUTED** the EA amendment by append-only section (§7.12) |
| **Subject** | v1.0: A2 v0.4 → **v0.5**, A3 v0.2 → **v0.3**. **v2.0:** A2 v0.5 → **v0.6**, A3 v0.3 → **v0.4**, `PRD_OWNERSHIP_MODEL.md` v1.1 → **v1.2**. ⚠ **v2.0's cell claimed `EA v2.2 → v2.3` and that claim was FALSE when written** — `ADR-0075`'s edit was attempted, measured and **reverted**, leaving the EA byte-unchanged at `v2.2`; the claim is corrected here rather than quietly dropped. **v2.1:** A2 v0.6 → **v0.7**, A3 v0.4 → **v0.5**, `PRD_OWNERSHIP_MODEL.md` v1.2 → **v1.3**, `ADR-INDEX.md` extended, and **EA v2.2 → v2.3 for real** (`ADR-0079`) |
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

### 7.12 ⭐⭐⭐ v2.1 — the three ACCEPTED ADRs that completed the `PRD-021A` blocker set

⭐ **What this subsection is.** §7.1–§7.11 record the owner rulings received at v2.0. This
subsection records what happened when the **remaining** blockers were worked to authority. It is
appended, not inserted: **L303–304 of this file are cited** by `ADR-0081` §2, `ADR-INDEX.md` and
A3 v0.5, so no line above §7.12 was permitted to move.

| ADR | Status | What it decided | Blocker(s) it closes |
|---|---|---|---|
| **`ADR-0079`** | `Accepted` — Architecture Owner | The EA community enumeration, **EXECUTED** by append-only new §12 (EA v2.2 → **v2.3**) | `LCF-GAP-013` enumeration half; `LCR-FND-013`; `ADR-0075` §8.5 **Option A** |
| **`ADR-0080`** | `Accepted` — Governance owner, by direct conferral | Constitutes the **`Governance Owner`** role by derivation from existing rules; registers the `LCF-` and `LCR-` prefixes | `LCF-GAP-001`; `LCR-GAP-001`; `ADR-0077` §9.4 defect 2 |
| **`ADR-0081`** | `Accepted` | Dispositions every residual `PRD-021A` gap and decision, **including the formal REFUSAL of `LCR-DEC-009`** | `LCF-GAP-005` (closed on measurement); 16 others dispositioned or routed |

⛔ **None of the three advances a stage, freezes an artefact, or invents a value.** §7.12.4
restates the release gate that all three leave standing.

---

#### 7.12.1 ⭐⭐ `ADR-0079` — the EA enumeration, executed instead of merely authorised

**The problem v2.0 left behind.** `ADR-0075` ruled that the EA's community block **shall** enumerate
Community Comments and Community Reactions at V2. It then attempted the edit as a **tree insertion**
inside the existing `BC-15` block, measured the consequences, and **reverted**. Its status is
therefore the literal truth of what *it* did: `⛔ ACCEPTED IN PRINCIPLE — EXECUTION BLOCKED`.

⚠ **v2.0's own Subject row claimed the EA had gone `v2.2 → v2.3`. That claim was false when it
was written.** The EA was byte-unchanged at `v2.2`. The header table above corrects it explicitly
rather than quietly dropping it, because a decision record that silently deletes its own errors is
not a record.

**Why the insertion was forbidden, in numbers.** `ADR-0075` §8.5 was not an opinion; it was a
measurement. It was re-run before any edit was attempted at v2.1:

| Measurement | Value |
|---|---|
| EA line-citations across the repository (**precise** regex) | **482** in **57** files |
| Highest EA line cited **anywhere** | **`L2404`** — in `PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md`, which is ⛔ **FROZEN** |
| Genuine EA citations **above** `L2404` | **0** |
| Citations invalidated by the **blocked tree insertion at L972** | **240**, across **39** files, **3 of them FROZEN** |
| Citations invalidated by an **append below L2404** | **0** |

⚠ **A broad regex initially reported 34 citations above `L2404`, the highest at `L4028` — in a
2,570-line file.** Every one of the 34 was opened and read individually. All 34 were **false
positives**: they were line references to *other* documents whose names had been swallowed by the
regex's capture span. The precise regex, which binds the filename to the line token, returned
**482** citations and a genuine maximum of **`L2404`**. ⭐ A precise measurement replaced a broad
one, and the broad one was discarded rather than averaged in.

**What was executed.** `ADR-0075` §8.5 itself pre-authorised four remediation options.
**Option A — append-only** was the one whose measured cost was zero, so it was taken:

- EA **§11** received a `v2.3` changelog row at **L2450**.
- EA **§12** was **appended** at **L2570**, enumerating **Community Comments (V2)** and
  **Community Reactions (V2)** as owned by **`BC-15`**.
- EA header: **L9 → `v2.3`**, **L11 → `2026-08-25`**.
- Final EA length: **2,603 lines**.

**Post-execution verification — measured, not asserted.**

| Gate | Result |
|---|---|
| EA citations re-resolved | **482** |
| Citations invalidated | **0** |
| Contents of any cited EA line changed | **0** |
| `EA L967–L973` (the `BC-15` block body) | ✅ **byte-identical** |
| Node lines `L920, L967, L971, L972, L973, L989, L1865, L2050` | ✅ **all unchanged** |
| Frozen files modified | **0** |
| Diff hunks landing in `L12–L2449` | **0** |

⚠ **`ADR-0079` §3.4 corrects its own pre-execution prediction.** It had predicted the EA would
finish at **2,570** lines with **457** citations. The executed reality was **2,603** lines and
**482** citations. The ADR was amended to the measured values rather than left holding the estimate.

**Authority for amending the EA at all.** `MP-CON-08` (`MASTER_PRD.md` **L519**, Rank 1) holds that
the EA is *"descriptive, not prescriptive — precedence rank 6"*, and that where it disagrees with
a higher-ranked document *"the higher-ranked document wins and the Enterprise Architecture is
updated to match — **never the reverse**"*. `MP-SCOPE-04` (**L92**, Rank 1) places `BC-14`/`BC-15`
at **V2**. The EA was silent on comments and reactions; the Rank 1 rule already put them at V2.
⭐ The EA was therefore updated **to match** authority — which is precisely the direction
`MP-CON-08` permits. EA §10.5's five-step change process was followed: proposed as an ADR, Single
Owner Rule verified, version tag assigned, document updated **and header version bumped**, no new
cross-module dependency created.

**What `ADR-0079` deliberately did NOT do.**

1. ⛔ **It did not add an in-tree cross-reference marker** at the `BC-15` block. A marker there was
   the obvious readability improvement and it was explicitly rejected: **`EA L967` is cited exactly**
   by `PRD-021A_A1 v0.2`, and any insertion at or above that line changes what the citation resolves
   to. Readability does not outrank citation integrity.
2. ⛔ **It did not restatus `ADR-0075` to `Accepted`, and did not supersede it.** `ADR-0075`'s own
   execution attempt genuinely was reverted; its status is a true record of its own act. A
   *different* ADR performed the act by a *different* route. Collapsing the two would falsify the
   history of both. `ADR-0079` §3.1 states this in terms.
3. ⛔ **It did not close `ADR-0075` §8.5 Option B.** The **281 bare EA line-citations** remain a
   live, disclosed defect class. Option A fixed the *enumeration*; Option B — repointing bare
   citations to stable anchors — is untouched and still owed.

---

#### 7.12.2 ⭐⭐ `ADR-0080` — the Governance Owner, constituted by derivation

**The gap v2.0 disclosed but did not fix.** §7.11 named it plainly: the `LCF-`/`LCR-` prefixes
were **unratified** because prefix registration belongs to a **`Governance Owner`**, and
`ADR-0077` §4.2 had found that role **undefined**. Two blockers — `LCF-GAP-001` and
`LCR-GAP-001` — sat on that single missing definition.

**The measurement.** Before constituting anything, the repository was searched:

| Measurement | Value |
|---|---|
| References to a governance owner across `docs/` | **342**, in **91** files |
| Documents that **define** the role's authority | **0** |
| `Accepted` ADRs that already name it in `Deciders` | **3** — `ADR-0053` (L8), `ADR-0054` (L8), `ADR-0064` (L7) |
| Lifecycle stage that assigns it | `PRD_LIFECYCLE.md` **L282**: `| Governance owner | Stage 7; the baseline |` |

⭐⭐ **This is the shape of a role that exists in fact but was never written down.** Three
`Accepted` ADRs had already exercised its authority. `PRD_LIFECYCLE.md` **L282** had already assigned
it a scope. `PGA-08` (**L284**) had already recorded the consequence: *"Every PRD needs a named
owner. None has one."* The role was **not invented at v2.1 — it was derived from rules already in
force and written down for the first time.**

**The circularity, and its answer.** An obvious objection: registering a prefix requires a Governance
Owner, and constituting a Governance Owner is itself a governance act — so who authorises the
constitution? `ADR-0080` §2.4 answers it without hand-waving: the constitution is **not** a new
grant of power. It is a **written statement of authority three `Accepted` ADRs had already
exercised** and that `PRD_LIFECYCLE.md` **L282** had already assigned. Nothing is conferred that was
not already operative; the ADR records, it does not create. The Architecture Owner — whose
`PRD_OWNERSHIP_MODEL.md` **§5** remit covers *"any Rank 1–5 document change"* — approved the
recording.

**What was executed.** `PRD_OWNERSHIP_MODEL.md` v1.2 → **v1.3**, **by APPEND**:

- New **§10** (§10.1–10.5) constituting the role, plus one **§8** changelog row.
- Final length **479 lines**.
- ⭐ **Zero-shift verified by line-content comparison:** `L64, L68, L69, L83, L85, L102, L180,
  L202, L284, L329, L331` are all **byte-identical**; the **first differing line is L334**. The file
  carries **35** line-citations, the highest at **L85** — all above the first change.
- §5 of `ADR-0080` **registers the `LCF-` and `LCR-` prefixes** to `PRD-021A` (A2 and A3
  respectively), satisfying `PRD_LIFECYCLE.md` §5 **L252–258** rule 3 (collision → change the
  new prefix — no collision found) and rule 5 (**numbers are never reused**).

⛔⛔ **The role is constituted VACANT. No person is named.** Naming an individual would be
exactly the invention the instruction forbids — no document anywhere in the repository names a
holder. `ADR-0080` states the role, its authority, its scope and its vacancy, and stops. ⭐ A
constituted-but-vacant role is a **true** statement; a constituted-and-staffed one would be a
fabrication.

**A false finding retracted, and a real obligation surfaced.** §6 of `ADR-0080` does two things
that are easy to conflate and must not be:

1. ⚠ **It RETRACTS a finding carried forward from an earlier pass** which claimed a defect at
   `PRD-012a_PART8` **L358**. That file is **FROZEN**; the claim was re-measured against the actual
   bytes and was **wrong**. It is retracted in writing rather than allowed to keep propagating.
2. ⚠ **It discloses `SECP-DEP-007`** — a genuine, still-open dependency whose
   **ownership-model half** is not discharged by v1.3. It is named, not closed. ⛔ It remains on
   the disclosed-not-repaired list at §7.12.5.

---

#### 7.12.3 ⛔⛔⛔ `ADR-0081` — `LCR-DEC-009` REFUSED, because no authority decides it

⭐⭐⭐ **This is the most important paragraph in v2.1.** The instruction was to resolve the
remaining decisions **according to authority, with no guessing and no invention**. For
**`LCR-DEC-009`** — *what numeric weight does the helpfulness signal carry?* — those two clauses
are in direct conflict: it cannot be resolved *and* remain uninvented, because **no authority
anywhere assigns it a value**. `ADR-0081` §2 therefore **REFUSES** it.

**The six determinability probes.** Refusal was not asserted; it was earned by looking in every
place a value could legitimately live:

| # | Probe | Result |
|---|---|---|
| 1 | Product Owner ruling in this record (§7.2–7.4) | ❌ Fixes reaction **kinds** and Recency `70` / engagement `30`. **Silent on a helpfulness weight** |
| 2 | `MASTER_PRD.md` global rules (Rank 1) | ❌ No ranking weights of any kind |
| 3 | Any `Accepted` ADR | ❌ None assigns one |
| 4 | `PRD-021A_OWNER_DECISION_REQUEST.md` v1.1 | ❌ **L365** — *"Proposes — no value of any kind"*. The request itself declined to propose one |
| 5 | A3's own ranking specification (§12.1) | ❌ `LCR-RS-003` is `ELIGIBLE` with weight **`0`** — designated, not weighted |
| 6 | Enterprise Architecture (Rank 6) | ❌ Silent — and being Rank 6 and **descriptive**, could not supply one even if it spoke (`MP-CON-08`, **L519**) |

⭐⭐ **Six probes, six empty results.** `MP-CON-08` names the correct disposition for exactly this
situation: *"**A disagreement is a defect to be raised, not a choice to be made.**"* An absence is
the same class of thing. Inventing `15`, or `10`, or any other number would have produced a document
that *looked* complete and was **untrue**. ⛔ **Refusal is the only honest disposition, and it is
recorded as a refusal — not as a resolution.**

**The consequence, and the invariant it protects.**

| Item | State after v2.1 |
|---|---|
| `LCR-DEC-009` | ⛔ **OPEN — formally REFUSED as undecidable** |
| `LCR-RS-003` Helpfulness | `ELIGIBLE`, weight **`0`**, *not assigned* — unchanged |
| Active ranking set | **Recency `70` + Legitimate engagement `30` = exactly `100`** |
| A3 §12.1 (the weight table) | ✅ **BYTE-IDENTICAL** between v0.4 and v0.5 — verified by diff, not by inspection |

⭐ **The 100 % invariant is the reason the refusal is safe.** Because helpfulness sits at `0`, the
active weights already sum to exactly `100`. Assigning any non-zero helpfulness weight would have
required **reducing** Recency or engagement — both of which the Product Owner **ruled** at
§7.4. So inventing a helpfulness weight would not merely have added an unauthorised number; it
would have **silently overwritten a ruled one**. ⛔ That is why nothing was touched, and why A3
§12.1 was diffed to prove it.

**`LCF-GAP-005` — closed on measurement, and its sibling deliberately left open.** `ADR-0081`
§3 closes `LCF-GAP-005` because the condition it asserts was **measured and found satisfied**.
⭐⭐ Its structurally identical sibling **`LCF-GAP-011` remains OPEN** — because the same test
applied to it **fails**: `integration_test/` **does not exist** in the repository. Two gaps of the
same shape received opposite dispositions **because the measurement differed**, which is what
measuring instead of guessing looks like in practice.

**The arithmetic of the whole disposition pass** (§4.5 of `ADR-0081`):

| Disposition | Count |
|---|---|
| ✅ **CLOSED** | **5** |
| ⛔ **REFUSED** (recorded as open) | **1** — `LCR-DEC-009` |
| ⛔ **OPEN** — dispositioned or routed to a named owner | **16** |
| ⭐⭐⭐ **Values invented** | **0** |

Still open on the merits and named as such: `LCF-GAP-004`, `006`, `007`, `008`, `009`, `010`, `011`;
`LCR-GAP-002`, `004`, `006`, `007`, `008`, `010`; and `LCR-DEC-001`, `003`, `004`, `006`, `007`,
`009`. ⭐ **Every one is named. None is quietly dropped.**

---

#### 7.12.4 ⛔⛔⛔ Release gating — REAFFIRMED, not relaxed

§7.11 recorded the gate at v2.0. Ten resolved blockers later, **the gate has not moved**, and
`ADR-0081` §5.1 restates it:

| Question | Answer after v2.1 |
|---|---|
| Is `PRD-021A` **READY**? | ⛔ **NO** |
| Is any part **FROZEN**? | ⛔ **NO** |
| Is anything **RELEASED**? | ⛔ **NO** |
| Is anything **BASELINED**? | ⛔ **NO** |

**The binding constraint.** `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** gates `PRD-021`
behind **`PRD-020`**, which is **unranked `DRAFT`**. That is a **release-blocking defect**, and it is
not within the gift of this record to waive. ⛔ **`ADR-0081` §5 enumerates ELEVEN genuinely
unmet conditions**, the `PRD-020` gate first among them, followed by the nineteen open
`LCF-`/`LCR-` items of §7.12.3 and the fact that **Stage 7 has not been performed**.

⭐⭐ **`PRD_LIFECYCLE.md` §7 forecloses the shortcut in terms:** *"Urgent business need —
**No fast path.** Stage 7 is not skippable."* And **L177**: *"A frozen PRD is never silently
modified."* ⛔ There is no mechanism by which resolving blockers substitutes for the gate.

⭐⭐⭐ **Ten blockers resolved. Zero stages advanced. That is the correct outcome, and it is
stated as a success rather than apologised for.** A2 remains **DRAFT — NOT FROZEN** (its
`NOT FROZEN` markers were **increased**, not removed). A3 remains **NOT READY — NOT FROZEN**: its
`NOT READY` count rose **6 → 8** and `NOT FROZEN` **4 → 6** across v0.4 → v0.5. ⭐ A pass
that resolves blockers should make a document *more* explicit about not being ready, not less.

⚠ **A structural note carried forward, so it is not rediscovered as new.** The append-only
technique that made the EA amendment free **does not transfer to the BC Map**. `LIBOORA_BOUNDED_
CONTEXT_MAP.md` is **Rank 4**, **625 lines**, carries **1,376** line-citations with the highest at
**L605**, and its §7 and §8 are **structured registers** — a `BC-15` aggregate row must land
*inside* §8, not below it. ⛔ `LCF-GAP-009` / `LCR-DEC-007` therefore stay **OPEN**; the BC Map
is **byte-unchanged**.

---

#### 7.12.5 ⚠⚠ Disclosed and NOT repaired — six items

⭐⭐ **Disclosure is a deliverable, not a failure.** Each item below was found by measurement, and
each was left unrepaired for a **stated** reason rather than because it was missed.

| # | Item | Why not repaired |
|---|---|---|
| 1 | ⭐⭐⭐ **NEW: `ADR-INDEX.md` "L143" is stale in six documents** | See the detail below — the citers are retained superseded drafts |
| 2 | **281 bare EA line-citations** (`ADR-0075` §8.5 **Option B**) | Repointing them is a repository-wide act needing its own ADR and its own measurement pass. Option A closed the enumeration; Option B is untouched and **still owed** |
| 3 | **`SECP-DEP-007`** — the ownership-model half | Genuinely open. Named by `ADR-0080` §6, not closed by v1.3 |
| 4 | **`Q-A6`** — `MASTER_PRD.md`'s 10 stale `v2.1` EA references | ⛔ `MASTER_PRD.md` is **Rank 1**. Editing it to chase a **Rank 6** document's version is precisely the inversion `MP-CON-08` **L519** forbids. ⚠ Now **two** versions stale (`v2.1` → actual `v2.3`) — the staleness **widened**, and that is disclosed rather than hidden |
| 5 | **BC Map L450's wording** | Rank 4, 1,376 citations. Scoped around at v2.0 by `ADR-0078` with the file byte-unchanged; the wording itself is untouched |
| 6 | **`ADR-0022` and 12 other ADRs still `Proposed`** | Not this pass's subject. ⚠ `ADR-0022` has now been `Proposed` for eight consecutive passes |

**Item 1 in full, because it is the same defect the instruction asked to fix — found again, in a
different file.**

Before `ADR-INDEX.md` was edited at v2.1, its citation exposure was measured first — the discipline
learned from the EA. The result:

| Measurement | Value |
|---|---|
| Broad regex | 36 citations, 20 files, max cited **L292** — in a **186-line** file |
| **Precise** regex | **31** citations, **16** files, distinct cited lines **`[9, 75, 95, 143]`** |
| Frozen files citing this file **below** the insert point `L104` | **0** |
| `docs_check` tools naming `ADR-INDEX.md` | 3 — `prd005`, `prd006`, `prd007_traceability.py`. ⛔ **None validates line numbers** |

⚠ **The `L292` hit was a false positive**, dismissed by reading it: `ADR-0022` **L10** cites
*"BC Map §7.3 edge `E-22` L331, L292"* — a **BC Map** citation whose filename the broad regex's
capture span had swallowed. ⭐ Second time a precise regex overturned a broad one.

⭐⭐⭐ **`L143` was then read, and it was the wrong line.** Six documents cite `ADR-INDEX.md
L143` for the Process rule *"requires an ADR before implementation"*. **L143 now holds the `AR-4`
ruling row.** Rather than assume why, the file's history was **bisected**:

```
a2f4411  lines=182  L143=[1. A decision that changes str]   <- citation CORRECT
f42e098  lines=182  L143=[1. A decision that changes str]   <- citation CORRECT
4ac9dbf  lines=182  L143=[1. A decision that changes str]   <- citation CORRECT
2cd5b51  lines=186  L143=[| `AR-4` | Invitation ownershi]   <- BROKEN
```

⛔⛔ **The breakage was caused by the immediately preceding pass**, which appended four
`ADR-0075`–`0078` register rows (**182 → 186** lines) and displaced the Process rule from
**L143 → L147**, and **this** pass moved it again to **L150**. Nothing detected any of it, because no CI gate
checks line numbers in citations. The six
citers are `PRD-021A_A1 v0.2` (L707, L771, L854, L1328, L1350, L1404) and `A2` v0.3/v0.4/v0.5/v0.6/
v0.7.

⭐⭐ **Why it was disclosed rather than repaired.** Four of the six citing documents are
**retained superseded drafts**, whose bytes are preserved deliberately as the record of what those
drafts actually said. Silently repointing their citations would rewrite that record. The finding was
therefore **routed to `ADR-0075` §8.5 Option B** — it is the **same defect class**, in a second
document — and disclosed in place under `ADR-INDEX.md`'s Process rule 1, which now names the
correct, line-independent citation form: **`ADR-INDEX.md "Process" step 1`**.

⭐⭐⭐ **The disclosure then caught itself, and the self-catch is the strongest evidence in this record.** As first written, both
that note and this subsection stated the rule "now sits at **L147**". That was true of the **186**-line file they were
measured against — but the *same pass* appended the three `ADR-0079`–`ADR-0081` rows, taking `ADR-INDEX.md` to
**208** lines and moving the rule to **L150**. ⚠ **So the disclosure of a stale line-citation had itself become a stale
line-citation, within minutes of being written.** It was caught by an audit gate that **re-reads the cited line and
compares it to the prose** rather than trusting the prose, and both documents were corrected in place.

⭐ **This is the ruling proved by demonstration rather than asserted.** A bare `L###` citation into a living document is not
fragile in theory: in this one file it broke **three times** (**L143 → L147 → L150**), **twice inside a single pass**,
and CI noticed none of it. ⛔ The chain is recorded in full so the next displacement reads as expected behaviour rather
than as a new discovery, and so that the argument for `ADR-0075` §8.5 **Option B** rests on measured recurrence instead
of on prediction.

⭐ **The v2.1 edit to `ADR-INDEX.md` was itself proven harmless.** Three register rows were appended
**after L104**, shifting every line from 105 onward by `+3` — which includes `L143`. But `L143`
was **already invalid**, so **zero currently-valid citations were invalidated**. The three
still-valid cited lines all sit **above** the insertion and were edited **strictly in place**,
verified by hash: **L75 md5 `739c40fe197fcc4f516d5eb7a6c387e8`** and **L95 md5
`bf2bc102341ac0fdc9fd6a120f608088`** — **identical before and after**.

⭐⭐ **The ADR count was re-derived mechanically, not incremented.** A classifier read all **72**
ADR files' own `Status` rows with an explicit *unparsed* bucket. The bucket returned **exactly one**
entry — `ADR-0075`, whose status genuinely is `⛔ ACCEPTED IN PRINCIPLE — EXECUTION BLOCKED`
— classified **by reading its own declaration**, never by rounding it to `Accepted`. Result:
**72 files = 58 accepted + 13 proposed + 1 accepted-in-principle**. ⭐ The **baseline identifier was
deliberately left unchanged**, per `DOCUMENTATION_BASELINE.md` §7 rule 4 (*"changes only when a
Rank 1–3 document changes version"*) — the EA is **Rank 6**.

---

### 7.13 ⛔⛔ v2.2 — Stage 7 is NOT ENTERABLE, and the remaining 18 items are ROUTED, not resolved

The instruction that produced this subsection was explicit on both halves: *"Mandatory Stage 7 complete karo"* **and**
*"koi value/decision invent mat karo."* Where those two requirements met, **the second one won.** This subsection
records why, and what was measured to establish it.

**Authority:** `ADR-0082` (`Accepted`) — Governance Owner (§2, §6), Architecture Owner (§4), Traceability Owner
(§5, *measurement only*). Companion record: `PRD-021A_STAGE7_BLOCKER.md`.

#### 7.13.1 Stage 7 — the gate was read at its line

`PRD_LIFECYCLE.md` **L159** states the gate as a positive requirement:

> **Gate:** a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank.

and **L160–161** state the rule:

> **"Freeze is conferred, not claimed. No PRD in this repository declares itself frozen."**

⭐⭐ **`DOCUMENTATION_BASELINE.md` contains exactly ONE occurrence of `PRD-021A`, at L139 — and it is inside §3, and
it DENIES readiness.** The line was opened and read rather than counted, because a hit inside §3's range could be
mistaken for the gate being satisfied. It is a cell in the Enterprise Architecture's row, and it ends:

> ⛔ Enumerating a capability in a **descriptive** document confers **no readiness**: `PRD-021A` remains **NOT READY /
> NOT FROZEN**.

⭐ **That sentence was written by this same pass four days earlier, under `ADR-0079`.** A pass declaring the freeze
now would contradict its own text inside the very document that constitutes the gate.

**Three earlier gates are unmet before it**, each measured independently:

| Stage | Gate quoted at its line | Measurement | State |
|---|---|---|---|
| **3** | **L88** — *"a written **alignment record** naming every conflict and its disposition"* | `ls docs/30-product/social-graph/ \| grep -c ALIGNMENT` → **0**. Twelve exist for other PRDs | ⛔ UNMET |
| **5** | **L123** — *"prefixes registered … verified **mechanically**, zero collisions"* | `grep -c "LCF-\|LCR-"` on the matrix → **0** | ⛔ UNMET |
| **6** | **L135** — *"an `IMPL-*` range allocated"* | **0**. Next free block is **`IMPL-1500`+** (`PRD-020` holds 1400–1449, reserves 1450–1499, its **L2434**) | ⛔ UNMET |

⛔ **Four routes to "completing" Stage 7 were considered and refused** (`ADR-0082` §2.3): writing the baseline row
(the row *is* the gate — that is claiming, not conferral); declaring `FROZEN` in A2/A3's headers (**L160** forbids it
in terms); passing Stages 3/5/6 first to reach Stage 7 (refused as a fast path — **L294**: *"**No fast path.** Stage 7
is not skippable"*); and recording Stage 7 `NOT APPLICABLE` on the `ADR-0060` precedent. ⭐ **The fourth deserves its
distinction:** `ADR-0060` applied because Stage 1's gate is **context-scoped** and **did not reach** a platform-scoped
document. **Stage 7's gate reaches `PRD-021A` perfectly well.** It is **UNMET, not INAPPLICABLE**, and conflating the
two would be the `PRD-013` blocker-1 error — reasoning *"history, not a rule"*, which `ADR-0050` §5 withdrew.

#### 7.13.2 ⭐⭐⭐ The five Architecture-Owner items — authority is HELD, execution is REFUSED on measurement

This is the finding of the pass, and it inverted the pass's own expectation.

Five items (`LCF-GAP-009`, `LCR-GAP-008`, `LCR-DEC-007`, `LCR-GAP-004`, `LCR-DEC-004`) name the **Architecture
Owner** — an authority this pass holds and has exercised lawfully five times (`ADR-0055`, `ADR-0076`, `ADR-0078`,
`ADR-0079`, `ADR-0061`). All five reduce to **one edit**: adding `BC-15` to the **Rank 4** Bounded Context Map. So the
edit was **measured before being attempted**:

```
LIBOORA_BOUNDED_CONTEXT_MAP.md  →  624 lines, Rank 4
line-citations INTO it          →  2,920, across 310 distinct cited lines
```

| Insert site | Purpose | Cited lines shifted | **Citations INVALIDATED** | Files | Frozen / ranked |
|---|---|---|---|---|---|
| **§8, L388** (after `BC-27`) | the `BC-15` aggregate row | **92** | ⛔ **658** | **87** | **11** |
| **§7, L360** | the `BC-15 → BC-11` edge | **113** | ⛔⛔ **1,112** | **102** | **13** |

Casualties include **L488 ×79**, **L450 ×51**, **L422 ×31** and **L435 ×21** — L422 and L435 are cited by
**`DOCUMENTATION_BASELINE.md` itself** — and **L605 ×5**, cited by **`ADR-0081`, this pass's own immediately
preceding ADR**. Frozen or ranked documents that would break include `PRD-017_FILE_AND_MEDIA`,
`PRD-014_ENTITLEMENT`, `PRD-016_AUDIT_TRAIL`, `PRD-012a_ARCHITECTURE_ALIGNMENT`, `PRD-008_REVENUE-AND-FINANCE` and
the `PRD-020` family.

⛔ **`ADR-0079`'s append technique does not transfer.** It worked because the EA tolerates an addendum below its
highest cited line. **BC Map §7 and §8 are STRUCTURED REGISTERS**: a row must land *inside* the table, and BC Map
**L292** rules that a surface absent from *the table* does not exist — so appending below §8 satisfies **nothing**.
Worse, §7's closing pattern-count block at **L350–358** contains *"Separate Ways | 1 | Library Management ⟷ Student
Network `BC-11`…`BC-17` (structural)"*, a cell the new edge **directly contradicts**.

⭐⭐ **The decisive comparison:** `ADR-0075` attempted an edit of this exact shape, measured **175** invalidated
citations across **32** files, and was **fully reverted**; its status is still `⛔ ACCEPTED IN PRINCIPLE — EXECUTION
BLOCKED`. **The act refused here is 3.8×–6.4× larger.** Re-attempting a reverted act at six times the scale, in the
same pass that recorded the revert, would be indefensible.

⭐⭐⭐ **The finding, stated plainly: holding the authority to decide is not the same as the decision being
executable.** The blocker is the repository's line-citation architecture, not jurisdiction — and the route that
unblocks it is already published and already open: `ADR-0075` **§8.5 Option B**, retiring the **281** remaining bare
line-citations. ⛔ **The BC Map is byte-unchanged.**

#### 7.13.3 ⭐ Stage 5 is measured EXECUTABLE — and deliberately not executed

This subsection would be dishonest if it reported all gates as equally immovable. They are not.

```
TRACEABILITY_MATRIX.md                       →  2,318 lines, UNRANKED (its own L8)
line-citations INTO it                       →  140, across 80 distinct lines
highest matrix line cited anywhere           →  L2046
```

L2046 would sit *below* a §3 insert point at **L1872**, so it was **opened and read**. The text at matrix **L1833**
and **L2299** is *"§24.2 **L2046**"* — a citation to **`PRD-020`'s** §24.2, **not to the matrix**. ⭐ **It is a false
positive**, so a new §2P at **L1872** shifts one cited line and that line is the false positive ⇒ **0 real citations
invalidated.** The matrix is unranked, so no ADR is needed to amend it.

It was still not executed, on **four sequencing grounds**: Stage 3 comes first; **`tool/docs_check/` holds 28
checkers and none for `PRD-021A`**, so **L123**'s *"verified **mechanically**"* — which every existing `§2x`
registration satisfies with **two committed, independent checkers** — is unsatisfiable today; registration advances
no stage; and the `LCF-GAP-002`/`LCF-GAP-003` non-contiguity (**both absent repository-wide** while `LCF-GAP-*` runs
to 14) requires an **owner annotation**, renumbering being forbidden by `PRD_LIFECYCLE.md` §5 rule 5 — *"Numbers are
never reused, even after withdrawal."*

⭐ **It is labelled a sequencing refusal, not an impossibility**, so the next pass is not misled into believing
Stage 5 is structurally blocked. It is blocked by order, and the order is the constraint.

#### 7.13.4 ⛔ `LCR-DEC-009` re-confirmed REFUSED, and the other 12 owner-blocked items

`ADR-0081` §2 refused `LCR-DEC-009` as undecidable. Two probes were re-run as a **check on** that refusal, not an
attempt to overturn it: `grep -ril "helpfulness"` returns **10 files, every one inside the `PRD-021A` family** ⇒ **0**
external rulings, and the Owner Decision Request **L365** still reads *"proposes … no value of any kind."*

⛔ **The refusal stands.** ⭐ **The invariant is preserved exactly:** `LCR-RS-003` Helpfulness stays **`ELIGIBLE` at
weight 0** (§7.4 above, and A3 **L1164**/**L1251**), and the active set stays **`70 + 30 = exactly 100`**. *A weight
assigned by this pass would be an invented requirement wearing a resolution marker, and it would silently overwrite
the one split the Product Owner did rule.*

The other 12 were each probed for a ruling by their own named owner. **Every probe returned nothing outside the
family** — and ⭐ **two probes returned what looked like hits and were proven not to be**: `grep -c "\bPERM-[0-9A-Z]"`
returns **1** repo-wide hit, which **is the disclosure recording the absence**; and `helpState`/`resolutionState`
outside the family returns **1**, which **is `ADR-0081`'s own disclosure of the gap**. Separately measured:
`ls -d integration_test` → **`No such file or directory`** (`LCF-GAP-011` stays OPEN), and **0 PRDs own `BC-14`**
(`LCF-GAP-004` stays OPEN).

⛔ **One route was available for all 13 and is refused explicitly**: each could be marked ✅ by minting the missing
value and citing `ADR-0082` as its authority. The repository already names that failure mode, in
`TRACEABILITY_MATRIX.md` §2O, having refused the identical shortcut for `PRD-020`:

> *"A fix that moves a percentage by creating identifiers is not a fix; it is the defect Stage 5 registers against."*

#### 7.13.5 ⚠ The `PRD-020` dependency — respected, and one discrepancy disclosed

The `PRD-020` release gate (`PRODUCT_IMPLEMENTATION_ROADMAP` **L161–164**) is **reaffirmed**, not softened.

⚠ **A discrepancy was found and is disclosed rather than repaired.** `PRD-020`'s own header (**L8**, **L17**) declares
*"`DRAFT` — Stage 2"* and *"Stages 3–9 **not started**"*. That is **false of the record**: `PRD-020_STAGE3_ARCHITECTURE_ALIGNMENT.md`
(127 L) reads **PASS 6/6**, `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` (156 L) reads **PASS 6/6** at v1.2, and
`PRD-020_STAGE5_CONFERRAL.md` (266 L) reads **CONFERRED**. ⇒ **`PRD-020` has reached Stage 5 of 9.** Repairing the
header is a document-owner act, so it is opened as **`LCF-GAP-015`** and `PRD-020` is left **byte-unchanged**.

⭐⭐ **And it does NOT unblock `LCF-GAP-007`** — recorded explicitly, because a future reader who repairs the header
might conclude otherwise. The blocker is **rank**, not progress: `grep -c "PRD-020"` over
`DOCUMENTATION_BASELINE.md` → **0**, `PRD-020` is **Unranked**, and its own **L18** states it *"must not be cited as
authority against any ranked document."* **Stage 5 confers `APPROVED`, not rank**; rank is conferred at **Stage 7**,
which `PRD-020` has also not reached. So `TSF-CFG-030` remains uncitable and both `LCF-GAP-007` and `LCR-GAP-007`
stay **OPEN**.

#### 7.13.6 ⛔⛔ Release gating — `READY` / `FROZEN` REFUSED, and the conditions enumerated

⛔ **`PRD-021A` is NOT READY and NOT FROZEN.** `ADR-0082` §6 enumerates **eleven** conditions and **none is met**.
The instruction permitted the marking *"sirf genuinely satisfied conditions par"* — only on genuinely satisfied
conditions — and the conditions are not satisfied. A2 stays **v0.7 `DRAFT`**, A3 stays **v0.5 `DRAFT`**, and
`PRD_REGISTRY.md` **L321** stays **`PLANNED`**.

⭐ **What was NOT done, exhaustively:** no baseline row created; no rank assigned; no `FROZEN`/`READY`/`RELEASED`/
`BASELINED` claimed; no conditional or partial freeze (a category `PRD_LIFECYCLE.md` does not define — inventing one
would be the same act as inventing a requirement value); no stage advanced; no gap closed; **no value or decision
invented**; no `Accepted` ADR's decision text edited; **no Rank 1–4 document amended** — `MASTER_PRD.md`, the **BC
Map**, the Dependency Matrix and **every FROZEN PRD are byte-unchanged**; the **matrix**, the **baseline** and
**`PRD-020`** are byte-unchanged; and **A2 and A3 themselves are byte-unchanged** at
`9192a8b1…5c19` and `6fb17cb1…91e8`.

#### 7.13.7 ⚠ Disclosed and NOT repaired by v2.2

| # | Item | Why not repaired here |
|---|---|---|
| 1 | ⭐ **`LCF-GAP-015`** — `PRD-020`'s header claims Stage 2 while its Stage 3/4/5 records all PASS | A document-owner act. §7.13.5, and it does **not** discharge the dependency |
| 2 | ⭐ **`LCF-GAP-002` / `LCF-GAP-003` absent repository-wide** while `LCF-GAP-*` runs to 14 | Renumbering forbidden (`PRD_LIFECYCLE.md` §5 rule 5). Needs an **owner annotation**, not a matrix registration that papers over it |
| 3 | ⚠⚠ **A FOURTH link in the `ADR-INDEX.md` citation chain — L143 → L147 → L150 → L151** | ⭐ **Caused by this pass, measured BEFORE the edit, and disclosed in `ADR-INDEX.md` under `Process` step 1 rather than found later.** Adding the `ADR-0082` row moved the rule from L150 to L151. The insert was still made, because the alternative was leaving an `Accepted` ADR unregistered, which `ADR-0057`'s discipline forbids. ⛔ **The 19 citations reading "L143" were ALREADY stale** and are not newly broken; and **two apparent external casualties were opened and read at their lines and proven FALSE POSITIVES** — `PRD-006_AUTHORITY_DETERMINATION.md`'s "L163" cites `PRD_OWNERSHIP_MODEL.md`, `PRD-020_TRUST_AND_SAFETY.md`'s "L169" cites `ADR-0059` — so the real cost is **9 self-references in 2 files this pass already edits, and 0 external documents.** This is now the strongest single piece of evidence for `ADR-0075` §8.5 **Option B** |
| 4 | `ADR-0075` **Option B** — the **281** bare `EA L###` citations | Out of scope, and §7.13.2 shows it is the **prerequisite** for the five structural items |
| 5 | ⚠ **A measurement-shape trap recorded for the next pass** | The v2.1 note recorded this file's **L303–304** md5 as `be9afe38…`. That value is correct **only without a trailing newline** (`printf '%s'`); the canonical `sed \| md5sum` form is **`616b1d0652a4be797fe0058ebd136e04`**. **Both were asserted before this append, and both held** — the file is byte-identical to commit `0e03144`. ⭐ Recorded because a hash that looks broken is indistinguishable from content drift until the command shape is checked, and the honest response is to publish both forms rather than to quietly replace one |
| 6 | The standing deferred set — `GCP-14`/`18`/`20`…`25`, `PGA-01`…`10`, `Q-01`…`07`, `Q-A6`, the 9 `ADR-0012` boundary findings, the 6 baseline `docs_check` failures | Each has a named owner or is red by design |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-24 | Created. Records the Product Owner `LCF-GAP-012` SHIP decision (D2-P) and authorises A2 → v0.5, A3 → v0.3. Four items left explicitly undecided (§4.1–§4.4) |
| **v2.0** | **2026-08-25** | ⭐ **Extended in place — no second decision record created** (§7.0). Carries seven owner rulings: reaction kinds `LIKE`/`HELPFUL`/`CELEBRATE`; `HELPFUL` = helpfulness; Recency 70 / engagement 30 = **exactly 100**; EA enumeration at V2 (`ADR-0075`); citation repointing **by measurement, not guess** (`ADR-0076`); Privacy Owner **derived** from five existing rules (`ADR-0077`); `LCR-GAP-009` resolved by scoping L450 against a **third** measurement, with the BC Map **byte-unchanged** (`ADR-0078`). §4.1–§4.4 annotated SUPERSEDED with their reasoning preserved verbatim. ⚠⚠ **Corrects a carried-forward error: the next free ADR number was NOT `ADR-0066`** — `0066`–`0073` are earmarked by `PRD-020` §29.2 and `0074` is contested, so `0075`–`0078` were used (§7.10). ⛔ **Three disclosed and NOT repaired:** the `Governance Owner` role gap, `MASTER_PRD.md`'s 10 stale `v2.1` EA citations (`Q-A6`), and BC Map L450's wording. ⛔ **`READY` / `FROZEN` / `RELEASED` NOT claimed** (§7.11) |
| **v2.1** | **2026-08-25** | ⭐ **Extended in place again — §7.12 added by APPEND ONLY, and no line above it moved**, because **L303–304** of this file are cited by `ADR-0081` §2, `ADR-INDEX.md` and A3 v0.5. Carries three `ACCEPTED` ADRs. ⭐ **`ADR-0079` EXECUTED the EA enumeration that `ADR-0075` left blocked**, by the append-only path `ADR-0075` §8.5 pre-authorised as **Option A**: EA **v2.2 → v2.3** with a new §12, appended below **L2404**, the highest EA line cited anywhere. Measured after execution: **482** EA citations re-resolved, **0 invalidated**, **0** cited-line contents changed, **L967–L973 byte-identical**, **0 frozen files touched**. ⚠ **Corrects a FALSE claim in v2.0's own Subject row**, which said "EA v2.2 → v2.3" when that edit had in fact been reverted. ⭐ **`ADR-0080` constituted the `Governance Owner`** by derivation from `PRD_LIFECYCLE.md` **L282** and three `Accepted` ADRs that had already named it as `Deciders`; `PRD_OWNERSHIP_MODEL.md` → **v1.3 by APPEND**, role **VACANT**, no personal name ⇒ **`LCF-GAP-001` and `LCR-GAP-001` CLOSED**, discharging the gap §7.11 disclosed. ⛔⛔ **`ADR-0081` REFUSED `LCR-DEC-009` as undecidable rather than inventing a helpfulness weight** — six determinability probes all returned nothing — so `LCR-RS-003` stays **ELIGIBLE at 0** and the active set stays **70 + 30 = exactly 100**; `LCF-GAP-005` closed **on measurement**, while its identically-tested sibling `LCF-GAP-011` stays **OPEN**. Consequential: A2 → **v0.7**, A3 → **v0.5**, `ADR-INDEX.md` extended to **72** registered ADRs (re-derived mechanically: 72 / 58 / 13 / 1 / 0). ⚠ **Six items disclosed and NOT repaired** (§7.12.5), including a **newly discovered second instance of the bare-line-citation defect class** — six documents cite `ADR-INDEX.md` "L143" for a rule that now sits at **L150**, broken by the *previous* pass and bisected rather than assumed. ⭐ **The note then caught itself:** it was written saying "L147" — true of the 186-line file — and this pass's own three new rows moved the rule to **L150**, so the disclosure of a stale citation became stale itself and was corrected in place. The full chain **L143 → L147 → L150** — three breakages, two inside one pass, zero detected by CI — is recorded as measured evidence for Option B. ⛔ **`READY` / `FROZEN` / `RELEASED` / `BASELINED` all still NOT claimed; the `PRD-020` release gate is REAFFIRMED and 11 conditions remain unmet** (§7.12.4) |

| **v2.2** | **2026-08-25** | ⛔⛔ **Extended in place a third time — §7.13 added by APPEND ONLY, and no line above it moved**, because **L303–304** of this file are cited by `ADR-0081` §2, `ADR-INDEX.md` and A3 v0.5; **both md5 forms of that anchor were asserted before the append and both held**. Carries **one** `Accepted` ADR, `ADR-0082`, and **it closes nothing — that is its finding.** ⭐⭐ **Stage 7 is recorded NOT ENTERABLE, not merely blocked.** Its gate — *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"* (`PRD_LIFECYCLE.md` **L159**) — does not exist, and the baseline's **only** mention of `PRD-021A`, at **L139**, **denies** readiness in a sentence **this same pass wrote** under `ADR-0079`. **Stages 3, 5 and 6 are unmet before it** (0 alignment records · 0 matrix registrations · 0 `IMPL` range, next free `IMPL-1500`+). **Four routes to "completing" Stage 7 refused**, including the `ADR-0060` `NOT APPLICABLE` route — rejected because Stage 1's gate was **context-scoped and did not reach** a platform, whereas **Stage 7's gate reaches `PRD-021A`: it is UNMET, not INAPPLICABLE.** ⭐⭐⭐ **The central finding: holding an authority is not the same as the decision being executable.** Five items name the **Architecture Owner**, which this pass holds and has exercised five times — but the one BC Map edit all five reduce to was **measured before being attempted** and invalidates **658** citations (§8 row; 92 lines, 87 files, **11 frozen/ranked**) or **1,112** (§7 edge; 113 lines, 102 files, **13 frozen/ranked**), including into **`DOCUMENTATION_BASELINE.md` itself** (BC Map L422 ×31, L435 ×21) and into **`ADR-0081`**, this pass's own preceding ADR (L605 ×5). ⛔ **`ADR-0079`'s append route does NOT transfer** — BC Map §7/§8 are **structured registers** and **L292** holds that a surface absent from *the table* does not exist; §7's pattern-count cell at **L350–358** is additionally **contradicted** by the new edge. **The act is 3.8×–6.4× larger than the `ADR-0075` act already measured at 175 citations and REVERTED**; the unblocking route is `ADR-0075` **§8.5 Option B**. ⭐⭐ **The opposite result is reported with equal care:** Stage 5 is measured **EXECUTABLE** — the matrix is **unranked** and its highest cited line **L2046** was **opened and read and proven a FALSE POSITIVE** (the text is *"§24.2 L2046"*, citing **`PRD-020`'s** §24.2) ⇒ a §2P at **L1872** invalidates **0 real citations** — and is declined on **four sequencing grounds**, chiefly that **`tool/docs_check/` holds 28 checkers and none for `PRD-021A`**, so **L123**'s *"verified mechanically"* is unsatisfiable today. It is expressly labelled *"a sequencing refusal, not an impossibility."* ⛔ **`LCR-DEC-009` re-confirmed REFUSED as undecidable** — `grep -ril "helpfulness"` returns **10 files, all inside the family** ⇒ 0 external rulings — so `LCR-RS-003` stays **`ELIGIBLE` at weight 0** and the active set stays **70 + 30 = exactly 100**. **The other 12 owner-blocked items were each probed and every probe returned nothing**; ⭐ two *looked* like hits and were proven not to be — `PERM-*` returns **1** repo-wide hit which **is the disclosure of the absence**, and `helpState` returns **1** which **is `ADR-0081`'s own disclosure**. ⚠ **`PRD-020`'s header claim of "Stage 2 — Stages 3–9 not started" measured FALSE** (Stage 3 PASS 6/6, Stage 4 PASS 6/6, Stage 5 CONFERRED all exist ⇒ **Stage 5 of 9**) — opened as **`LCF-GAP-015`**, **not repaired**, and §7.13.5 records that it **does NOT unblock `LCF-GAP-007`**, because the blocker is **rank**: `PRD-020` occurs **0** times in the baseline, its own **L18** forbids citing it against ranked documents, and **Stage 5 confers `APPROVED`, not rank**. Consequential records: `PRD-021A_STAGE7_BLOCKER.md` (**new**, 393 L, on the `PRD-012a`/`PRD-013` precedent, *"performs no governance act"*) and `ADR-INDEX.md` → **73** registered ADRs (**re-derived mechanically: 73 / 59 / 13 / 1 / 0, unparsed EMPTY**; unregistered enumeration returned exactly `ADR-0082`). ⚠ **Six items disclosed and NOT repaired** (§7.13.7), including a **FOURTH link in the `ADR-INDEX.md` citation chain, L143 → L147 → L150 → L151, caused by this pass, measured BEFORE the edit and disclosed in the index itself** — with the 19 "L143" citations shown to be **already stale** and two apparent external casualties **read at their lines and proven false positives**, leaving a real cost of **9 self-references in 2 files this pass already edits and 0 external documents**. ⛔⛔ **`READY` / `FROZEN` / `RELEASED` / `BASELINED` all REFUSED; the `PRD-020` release gate REAFFIRMED; 11 conditions unmet; all 18 `LCF`/`LCR` items remain OPEN; 0 closed; 0 stages advanced; 0 values invented; no Rank 1–4 document, no FROZEN PRD, and neither A2 nor A3 modified.** |

*End of Decision Record v2.2. Ten blockers resolved across v2.0 and v2.1, **two** formally REFUSED, **eighteen still OPEN**, zero stages advanced, nothing frozen, and zero values invented.*
