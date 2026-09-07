# PRD-021A A1–A8 — Owner Decision Package

| Field | Value |
|---|---|
| **Document** | `PRD-021A` A1–A8 Owner Decision Package |
| **Version** | **v1.0** — ⛔ **UNANSWERED.** Every item below awaits its named owner |
| **Scope** | All 22 open owner-held items across Parts **A1–A8**, measured at commit `f4db31d` |
| **Convention** | The Pack → Request pattern of `PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md`, as already applied by `PRD-021A_OWNER_DECISION_REQUEST.md` |
| ⭐ **Decisions made here** | **ZERO.** This document *recommends* and *routes*. It decides nothing |
| ⭐ **Values proposed here** | **ZERO owner-owned values.** Where a value would be invention it is left blank — see §2.2 |
| **Gaps resolved here** | **ZERO** |
| **Lifecycle stages conferred** | **ZERO.** Stage 3 not conferred; Stage 4 not entered; Stage 5 unchanged |
| **Frozen documents amended** | **ZERO** |
| **ACCEPTED ADRs reopened** | **ZERO** — `ADR-0078`, `ADR-0079`, `ADR-0080`, `ADR-0081`, `ADR-0082` all stand |
| **New ADRs created** | **ZERO.** `ADR-0083` was **NOT** created; the count stands at **73** |

> ⚠⚠⚠ **READ THIS BEFORE READING ANY RECOMMENDATION.**
>
> ⭐ **A recommendation is not a decision, and this document must never be read as one.** Every row below
> carries a *recommended option* because the human principal expressly asked for one. **Not one of them has
> been applied**, and none may be applied without the ruling of its named owner.
>
> ⛔ **This document is NOT an authority.** `PRD_LIFECYCLE.md` §6 assigns these acts to the Product Owner
> (content, business rules, scope), the Architecture Reviewer (**L277** — Stage 3, authority to require an
> ADR) and the Governance Owner (**L282** — Stage 7, the baseline). This file is evidence that the questions
> are real and that no answer was guessed.
>
> ⚠ **Where a recommendation rests on inference rather than authority, it says so** — see §2.1 and §2.2.

---

## 0. The one act that was performed, and why it was the only one

⭐ **Exactly one item in this package was mechanically authorised, and it is the only thing that was done.**

| Item | Act | Authority | Commit |
|---|---|---|---|
| `LCS-GAP-001`(a) | Corrected `PRD_REGISTRY.md` §11.4's falsified filesystem measurement at **L761** | §8 rule 5 — *"If this register disagrees with a PRD, **fix this register**"*; register is **unranked**, so §11.2 q1 applies and **no ADR is required** | `c66f1d7` |

**Citation safety was measured before the edit, not after:** **204** line-citations to `PRD_REGISTRY.md` exist
across `docs/`; **ZERO** point below L761. The correction invalidated **0** citations.

⛔ **Everything else in this document was left unexecuted**, because for every other item the measurement
returned *"requires an authority this document does not hold."*

---

## 1. What is already decided, and is NOT reopened here

| Item | Closed by | Standing |
|---|---|---|
| `LCF-ADR-005`, `LCF-ADR-006`, `LCR-GAP-009` | `ADR-0078` (`Accepted`) | Community scope carries **no** `tenantId` |
| `LCF-GAP-001`, `LCR-GAP-001` | `ADR-0080` §5 (`Accepted`) | `LCF-` and `LCR-` **REGISTERED** |
| `LCR-FND-013` | `ADR-0079` (`Accepted`) | EA v2.3 by append; **482** citations re-resolved, **0** invalidated |
| `LCR-GAP-003`, `LCR-DEC-002`, `LCR-DEC-008` | Product Owner | `HELPFUL` designated; Recency **70** / Legitimate engagement **30** = **exactly 100** |
| Stage 7 | `ADR-0082` (`Accepted`) | **NOT ENTERABLE** |
| `LCR-DEC-009` | `ADR-0081` §2 (`Accepted`) | ⚠ **REFUSED as undecidable — and therefore still OPEN.** Refusal is a disposition, not a resolution |

⛔ **No recommendation below overrides any row in this table.**

---

## 2. Two recommendations that rest on inference — disclosed, not buried

### 2.1 `LCM-DEC-001` — my reasoning is the exact reasoning `ADR-0036` refused to accept

My recommendation (W₀ = D+1) rests on two arguments: that *"3 calendar days"* is satisfied only by the
exclusive reading, and that `MM-FR-062` makes `endDate` a day the membership is still in force.

⭐ **`ADR-0036` §6.5 considered precisely this reasoning and declined to act on it**, in its own words:

> *"**That is an argument, not an authority.** Off-by-one errors in inclusive date intervals are exactly what
> frozen `MM-FR-057`'s *'Why − 1'* note calls *'the classic source of a customer-visible dispute'*, and this ADR
> will not resolve a customer-visible boundary by inference."*

**So the recommendation is offered to the authority that may act on an argument — the Product Owner — and is
NOT presented as a finding.** A one-day error is visible to a paying student on the date that decides whether
their seat is released.

### 2.2 `LCR-DEC-009` — where a value is required, this document supplies none

If the Product Owner prefers to **assign** a helpfulness weight rather than defer it, three values are needed
(X, Y, Z summing to exactly 100). ⛔ **This document leaves them blank.** `ADR-0081` ran six determinability
probes and every one returned nothing; publishing a number would be the invention it refused, and carving one
from the ruled `70`/`30` would overwrite a decision the Product Owner **did** make.

⚠ **The arithmetic trap, stated once and plainly:** A3 **L1160** forbids carving the weight out of the ruled
`70`/`30`, while `LCR-FR-035` (**L616**) requires the active set to sum to **exactly 100** on activation.
Therefore **any weight > 0 for `LCR-RS-003` necessarily supersedes `LCR-DEC-008`.** It is not an additive act,
and it must not be presented to the Owner as one.

---

## 3. Product Owner — 7 items

⛔ **This document takes none of these.**

| # | ID | Question | Recommended | Basis for the recommendation |
|---|---|---|---|---|
| PO-1 | `LCM-DEC-001` | First day of the 3-day protected window | **W₀ = D+1** | Exclusive reading is the only one yielding exactly 3 days; `MM-FR-062` non-overlap. ⚠ **Inference — see §2.1** |
| PO-2 | `LCR-DEC-009` | Helpfulness weight | **Permanent deferral by decision** | Zero behavioural delta (already 0); avoids superseding `LCR-DEC-008`; satisfies Stage 4's *"explicitly deferred with a reason and an owner"* |
| PO-3 | `LCG-DEC-001` | A4 scope | **Allocated part of PRD-021A** | Registry **L704** already lists A1–A5; a separate PRD needs an ADR under §8 rule 6 **and** would put two PRDs on `BC-15` — failing Stage 3 Check 1 for both |
| PO-4 | `LCG-DEC-003` | `CommunityRole` set | **`OWNER`/`MODERATOR`/`MEMBER`, ranked** | Already present as a named candidate (A4 **L208**) — ratification, not invention. Prerequisite for PO-6 |
| PO-5 | `LCG-DEC-005` | Visibility enum + name uniqueness | **2 values; uniqueness deferred** | ⭐ A third value would be **untestable**: `LCG-AC-008` makes `UNLISTED` and `PRIVATE` observationally identical, so Stage 4's *"every requirement testable"* would fail on it |
| PO-6 | `LCG-DEC-006` | Last-owner rule | **Deny voluntary; `ARCHIVED` involuntary** | `ARCHIVED` **already exists** in the enum (A4 L232); auto-promotion is what A4 **L455** calls *"an authority act"* |
| PO-7 | `LCO-DEC-001` + `LCO-DEC-002` ≡ `LCR-DEC-006` | A5 existence, ownership, A2 type-set treatment | **Exists; orthogonal discriminator; A2's four types NOT extended** | Two exact precedents refuse a fifth value in a closed set (`ADR-0036` §4.2 `SeatState`; BC Map v1.6 `attendance.*`). ⭐ **Decisive:** a fifth post type would be **born blocked** by `LCF-FR-043` — only `TEXT` ships today |

⭐ **Recommended batching** — PO-3 + PO-7 + the A6/A7/A8 allocation are **one register edit**; PO-4 **must**
precede PO-6.

---

## 4. Architecture Owner — 9 items resolving into 4 acts

⭐ **Three of the nine cost ZERO file edits.** That is the single most useful finding in this section.

| # | ID | Recommended | Cost | Why |
|---|---|---|---|---|
| AO-1 **+** AO-7 | `LCF-ADR-007` **+ D-2** | **Admit the edge — ONE ADR performing both acts** | BC Map §7 row **+** Matrix **L90** **+** yaml **L234** | A2's own register row (**L1725**) already says *"two acts are required, not one."* ⭐ **Highest leverage in the package:** `BC-15` appears **ZERO** times in the Matrix, so this is what makes Stage-3 **Check 3 evaluable for all eight parts** |
| AO-2 | `LCF-ADR-003` | **Ratify, append-only** | EA new section | ⭐ EA **L379** already declares `Pagination & Filtering Standards (V1)` with **0** cursor definitions repo-wide — this *populates a declared-but-empty standard*. Method: `ADR-0079` (0 invalidated) |
| AO-3 | `LCF-ADR-002` | ⏸ **DEFER** | **0 edits** | ⭐ **`BC-14` has no PRD.** Registering a transport to an unspecified target is a Rank 4 commitment that cannot be implemented or verified. `LCF-FR-043` already confines the loss to 3 of 4 post types |
| AO-4 | `LCS-ADR-001` | ⭐ **REFUSE — the edge is unnecessary** | **0 edits** | `BC-13` **owns** `AbuseReport` (BC Map §8 **L379**); intake is `BC-13`'s. ⚠ The `ADR-0065` projection shape **fails here** — it worked because `BC-12` already received `E-14`, but **no all-context edge targets `BC-13`** |
| AO-5 | `LCT-ADR-002` | **Not required at V2; defer `LCF-NFR-006`** | A2/A8 only | Option (a) requires promoting `Event Replay` **V3 → V2** — a scope act far larger than the NFR |
| AO-6 | `LCT-CONF-002` | ⭐ **No amendment — cite `ADR-0078` §2.1** | **0 edits** | The substance is **already decided**; only the wording is stale, and `ADR-0078` §4.2 **already routed** it |
| AO-8 | **D-5** | **Append-only** (`ADR-0079` method) | BC Map append | `ADR-0082` §229 measured the in-place path at **300** citations / **52** files / **4 FROZEN** |
| AO-9 | Search transport | ⭐ **Rule OUT of band** | **0 edits** | A8 **L1043–1051** already concurs: the feed is *"filtering over an authorized candidate set, not platform search"* |

### 4.1 ⚠ The residual AO-4 does NOT solve

Refusing the `BC-15 → BC-13` edge settles **report intake**. It does **not** settle how `BC-13` **reads**
`BC-15` content in order to moderate it — an *inbound-to-`BC-13`* path that **does not exist**. ⛔ **This is
recorded as a new open item routed to the Architecture Owner, and is expressly not closed by the refusal.**

---

## 5. Social Domain Owner — `LCT-CONF-001`

**Measured:** A7 declares **7** facts; A2 declares **6** and closes the set by `LCF-FR-104` (*"A seventh SHALL
require a PRD amendment"*). A5 `LCO-FR-113` **obeyed** it. **A7's awareness of `LCF-FR-104` = 0 hits.**
BC Map **L401**'s naming rule is satisfied by *both* candidate names, so ⭐ **L401 does NOT break the tie —
A2 owns the set.**

### ⭐ RECOMMENDED: Option B — reduce A7 to A2's six

⭐⭐ **The decisive measurement: all four of A7's extra facts are independently blocked or redundant, so
Option A cannot be completed even if authorised.**

| Extra fact | Independent blocker |
|---|---|
| `LCN-EVT-004` `MembershipChanged` | ⛔ A4 `LCG-ADR-002` requires an ADR for any `BC-15`-sourced event, and **BC Map §7 sources ZERO edges from `BC-15`** |
| `LCN-EVT-005` `ContentEligibilityChanged` | ⛔ **Redundant** — A1 derives eligibility with **no event at all** (`C-7`, `LMD-16` precedent) |
| `LCN-EVT-006` `OfficialCommunicationPublished` | ⛔ Blocked on **PO-7** |
| `LCN-EVT-007` `HelpRequestAnswered` | ⛔ Blocked on **PO-2** |

→ Amending A2 would admit **four events unusable on arrival**: a PRD amendment for **zero** delivered
capability.

**Two further reasons.** A2's names are also *better* — `ReactionChanged` expresses removal, which
`ReactionAdded` **cannot**. And withdrawal is **reversible**: `PRD_LIFECYCLE.md` §5 **rule 5** — *"Numbers are
never reused… A withdrawn requirement is marked withdrawn"* — so any fact may be re-raised under a **new**
number once its blocker clears.

⛔ **NOT EXECUTED.** A7 is unchanged at v0.1; A2 is unchanged at v0.8.

---

## 6. Governance — the authority required, stated exactly

### 6.1 ⭐ A correction to an earlier statement of my own

A prior pass reported that the Governance Owner *"has no named owner (`PGA-08`)"*. **More precisely:**

| Fact | Source |
|---|---|
| The office **IS constituted** — the sixth role of `PRD_OWNERSHIP_MODEL.md` | `ADR-0080` §2.2 item 1 |
| ⛔ The office **IS VACANT** | `ADR-0080` **L85** — *"It is constituted **VACANT**… Constituting an office does not fill it, and nothing here appoints anyone"* |

A4 **L211** cites this correctly. **The chair exists; nobody sits in it.**

### 6.2 Registering the six prefixes

| Requirement | Status |
|---|---|
| Collision-safe? | ✅ **True collisions = 0** for all six. Raw hits `LCM-` 1, `LCG-` 1, `LCO-` 1 all resolve to `PRD_REGISTRY.md` **L741/744/745** — this register's own references to these very parts, not rival registers |
| Whose act? | Governance Owner — `PRD_LIFECYCLE.md` **L282**; `ADR-0080` §5: *"a **Stage 7 / baseline** act"* |
| Office filled? | ⛔ **NO** — §6.1 |
| Precedent | Exercised **only by an Accepted ADR**, by authority *"exercised by **direct conferral** from the human principal"* (`ADR-0080` Deciders). A search for a **non-ADR** prefix registration returns **nothing** |

⭐ **TWO SEPARATE GRANTS ARE REQUIRED, not one:**
1. **Explicit conferral** of Governance Owner authority for the act, **and**
2. **Explicit authorisation of `ADR-0083`** to carry it.

⛔ **Neither exists. Nothing was executed. `ADR-0083` was NOT created.**

### 6.3 `LCS-GAP-001` splits in two

| Half | Authority | Done? |
|---|---|---|
| **(a)** The falsified filesystem measurement at L761 | ⭐ **Mechanically authorised** — §8 rule 5, unranked register | ✅ **DONE** — `c66f1d7` |
| **(b)** The allocation status of A6/A7/A8 | ⛔ **Product Owner.** §8 rule 3 requires the register to be *"updated in the same commit as the change it records"* — and the only record of authorisation lives in the drafts' **own provenance headers** | ⛔ **NOT DONE** |

---

## 7. Sequence — what each decision unblocks

1. **PO batch 1** — allocation (`LCG-DEC-001` + `LCO-DEC-001` + A6/A7/A8) → one register edit; closes `LCS-GAP-001`(b)
2. **PO batch 2** — `LCG-DEC-003` **before** `LCG-DEC-006`; then `LCG-DEC-005` → 2 unwritable ACs become verifiable
3. **PO batch 3** — PO-7, then `LCR-DEC-009`, then `LCM-DEC-001` → A5's double gate lifts; A1's implementation bar lifts
4. **Social Domain** — `LCT-CONF-001`; Option B needs nothing from above
5. **Governance** — conferral **+** `ADR-0083` → Stage 5 becomes reachable
6. **Architecture** — AO-1+AO-7 first (highest leverage), then AO-2, AO-8, then the three zero-edit dispositions

---

## 8. Stage impact, stated honestly

| | Effect if every recommendation is approved |
|---|---|
| **Stage 3 evidence** | A2 Check 2 **satisfied**; A6 Check 2 ⚠→✅; A8 Checks 2 **and** 6 ⚠→✅; ⭐ Check 3 becomes **evaluable for all 8** via D-2 |
| **Stage 3 conferral** | ⛔ **STILL NOT CONFERRED.** The gate is *"a written alignment record naming every conflict and its disposition"*; the existing record is **stale** (subjects A2 v0.7 / A3 v0.5, base `2dca733`) and ⛔ **must not be edited**; a **fresh dated record** must sit beside it; and conferral is the **Architecture Reviewer's** act (**L277**) |
| **Stage 4** | ⛔ **NOT ENTERED.** 4 of 5 checks improve; 5 unwritable/deferred items become writable |
| **Stage 5** | ⛔ **UNCHANGED** — matrix registrations for all 8 prefixes remain **0** |
| **Stage 7** | ⛔ **NOT ENTERABLE** — `ADR-0082` |

**Precondition met today: 0 of 22.**

---

## 9. What this document deliberately did NOT do

- ⛔ Did **not** decide anything. Every item awaits its named owner
- ⛔ Did **not** create `ADR-0083`, or any ADR. Count stands at **73**
- ⛔ Did **not** edit the stale Stage-3 alignment record (`eab88c9ab3be6f91`, byte-unchanged)
- ⛔ Did **not** confer Stage 3, enter Stage 4, or register a prefix
- ⛔ Did **not** add a bounded context (**31**), an edge (**26**), an event, a permission, a policy value or a role value
- ⛔ Did **not** move anything from V2 to V1
- ⛔ Did **not** amend a frozen document, or reopen `ADR-0078`/`0079`/`0080`/`0081`/`0082`
- ⛔ Did **not** re-draft or duplicate A1–A8 (**19** files, **0** touched)
- ⛔ Did **not** supply a helpfulness weight, a `CommunityRole` value beyond A4's existing candidate set, or any other owner-owned value
- ⚠ Did **not** solve how `BC-13` reads `BC-15` content for moderation (§4.1) — routed, not closed

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-26 | First record. All 22 open owner-held items across A1–A8 measured at `f4db31d` and routed to their named owners, each with repository-supported options, precedents, a recommended option and approval-ready wording. **Zero decisions taken.** One mechanically authorised act performed and recorded at §0 (`c66f1d7`, `PRD_REGISTRY.md` §11.4 L761). Two recommendations resting on inference disclosed at §2 rather than presented as findings. One prior statement of my own corrected at §6.1: the Governance Owner office **is** constituted (`ADR-0080` §2.2) but **is VACANT** (`ADR-0080` **L85**). Three architecture recommendations identified as costing **zero** file edits. `ADR-0083` **NOT** created; 73 ADRs, 26 edges, 31 BCs unchanged; `docs_check` **28/6**. |

---

*End of `PRD-021A` A1–A8 **Owner Decision Package v1.0** — ⛔ **UNANSWERED**. Recommendations are not decisions.
No lifecycle stage is conferred. No frozen document was modified. No `ACCEPTED` ADR was reopened.*
