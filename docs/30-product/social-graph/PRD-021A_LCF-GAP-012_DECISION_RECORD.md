# `LCF-GAP-012` — Decision Record: Community Comments & Reactions = **IN SCOPE, SHIP**

| Field | Value |
|---|---|
| **Document** | `LCF-GAP-012` / `LCR-DEC-002` Decision Record (D2-P) |
| **Version** | v1.0 |
| **Decision** | **Community Comments and Community Reactions are IN SCOPE and SHALL SHIP in the current `PRD-021A` generation** |
| **Product Owner** | ✅ **DECIDED — SHIP** (explicit scope ruling, this record) |
| **Architecture Owner / ARB** | ⏳ **PENDING** — D2-A-i (EA enumeration) and D2-A-ii (`LCF-FR-026` citation) are **not** decided by this record (§4) |
| **`LCF-GAP-012` status** | ✅ **RESOLVED — narrow the exclusion, preserve the specification** |
| **`LCF-GAP-013` status** | 🔴 **OPEN — Architecture Owner** (untouched, §4.2) |
| **Subject** | `PRD-021A_A2_..._v0.4.md` (1,576 L) → amended as **v0.5** · `PRD-021A_A3_..._v0.2.md` (1,020 L) → integrated as **v0.3** |
| **Authority basis** | `PRD_OWNERSHIP_MODEL.md` **§2.2 L83** — the Product Owner *"decides whether a requirement is correct and **in scope**"* |

> **What this record is.** It documents the Product Owner's scope decision and the amendments
> it authorises. It does **not** amend the Enterprise Architecture, does **not** raise or
> accept an ADR, does **not** mint a bounded context, edge, aggregate, event, permission or
> storage model, does **not** resolve `LCF-GAP-013`, does **not** enumerate the reaction kind
> set, does **not** assign any ranking weight, and freezes nothing.

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

## 4. What this record does **NOT** decide

### 4.1 D2-A-i — EA enumeration ⏳ **ARCHITECTURE OWNER**

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

### 4.2 D2-A-ii — `LCF-FR-026` citation ⏳ **ARCHITECTURE OWNER**

`LCF-FR-026` (A2 L396–397) names *"`Moderation (V3)` and `Community Analytics (V3)`"* but
cites `LCF-XC-016` (rate-limit authorship) and `LCF-XC-017` (comments/reactions). The correct
targets are `LCF-XC-006` (moderation, L181) and `LCF-XC-029` (community analytics, L204).

**Deliberately NOT corrected.** A2 **L1492**: *"the original intent is ambiguous, and guessing
it would be a silent architectural decision."* `LCF-GAP-013` remains **OPEN — Architecture
Owner**.

⚠ **Disclosure.** Narrowing `LCF-XC-017` (§2) does **not** worsen `LCF-GAP-013`.
`LCF-XC-016` and `LCF-XC-017` never covered `Moderation (V3)` or `Community Analytics (V3)`
under any reading, so the mis-citation is unchanged in substance by this amendment.

### 4.3 The reaction kind set 🔴 **OPEN — PRODUCT OWNER** (`LCF-GAP-014`)

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

### 4.4 Ranking weights 🔴 **OPEN — PRODUCT OWNER**

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

| ID | Subject | Owner | Status |
|---|---|---|---|
| `LCF-GAP-013` | `LCF-FR-026` citation (D2-A-ii) | **Architecture Owner** | 🔴 OPEN |
| `LCF-GAP-014` | Reaction kind set unenumerated (`LCF-BR-010`) | **Product Owner** | 🔴 OPEN — **new** |
| `LCR-FND-007`…`012` | EA enumeration of comments/reactions (D2-A-i) | **Architecture Owner** | ⏳ RAISED |
| `LCF-ADR-001` / `LCF-DEC-001` | BC Map §8 aggregate row for `BC-15` | **Architecture Owner** | 🔴 OPEN — pre-existing |
| `LCF-ADR-002` / `LCF-DEC-002` | `BC-15 → BC-14` edge | **Architecture Owner** | 🔴 OPEN — pre-existing |
| `LCR-GAP-003` | Which reaction kind denotes helpfulness | **Product Owner** | 🔴 OPEN — narrowed |

**Neither A2 nor A3 becomes freezable through this record.** Both remain **DRAFT — NOT
FROZEN**, and A3 remains **NOT READY**.

---

*End of `LCF-GAP-012` Decision Record v1.0. This record decides scope only. Nothing is frozen,
baselined or approved.*
