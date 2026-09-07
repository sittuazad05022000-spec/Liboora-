# ADR-0076 — `LCF-FR-026`'s V3-exclusion citations are repointed to `LCF-XC-006` and `LCF-XC-029`

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 and §2.3 (L85, L102) — the role `PRD_OWNERSHIP_MODEL.md` L284 records as the *only* approving body for a Rank 1–5 document change. Authority **expressly conferred for this one decision**; `ADR-0033` §7.1 — a conferral for one act is **not** a standing licence |
| **Supersedes** | — |
| **Amends** | `docs/30-product/social-graph/PRD-021A_A2_LIBRARY_COMMUNITY_FEED_CONTENT_DRAFT_v0.5.md` → **v0.6**, requirement **`LCF-FR-026`** only, the **two cited identifiers** only. **No requirement added, removed, merged, split or renumbered. No exclusion row's subject changed. No architectural determination altered.** Executed, see §6 |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** A2 is an **unranked `DRAFT`** working part of `PRD-021A`, which `PRD_REGISTRY.md` L321 carries as **`PLANNED`**; `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier *"only when a Rank 1–3 document changes version"*. A2 holds no rank and no baseline position. §7 step 1's *"ADR **before** the change"* is nonetheless honoured — this ADR is that instrument |
| **Closes** | **`LCF-GAP-013`** — the citation half of A2 §34's reported defect `R2`, in full |
| **Does NOT close** | `LCF-GAP-001`, `004`–`011`, `LCF-GAP-014` (Product Owner), `LCR-GAP-*`, `LCR-FND-001`…`006`, or any acceptance criterion. It does **not** re-open `LCF-XC-017`'s narrowing, does **not** change what any exclusion row excludes, and confers **no** readiness or freeze |
| **Related** | ⭐ **`ADR-0015`** (the controlling precedent — a full ADR to repoint three wrong context citations; its risk row's *"three named cells in one named file"* limit is honoured here as **two named cells in one named file**) · **`ADR-0075`** (the EA enumeration half of the same raised defect) · A2 `LCF-FR-026`, `LCF-XC-006`, `LCF-XC-015`, `LCF-XC-016`, `LCF-XC-017`, `LCF-XC-028`, `LCF-XC-029` · EA **L919**, **L972**, **L973** · BC Map **L379** (`ModerationCase`), **L135** (`BC-26`), **L377** (`RateLimitCounter`) · `PRD_LIFECYCLE.md` **L170**, **L283–296** (the fast path, and why it does not reach) · `PRD-021A_OWNER_DECISION_REQUEST.md` §4.2 |

> ✅ **ACCEPTED 2026-08-25. The migration in §6 has been executed.**
>
> ⭐ **The instruction under which this ADR was opened was explicit: *"do not guess."* This ADR does
> not guess. §2.2 shows the pair is fixed by a **line-reference match the requirement itself
> publishes** — `LCF-FR-026` cites *"EA L972–973"*, and exactly one candidate per subject cites
> those same lines. The two candidates the Owner Decision Request listed as *"live alternatives"*
> are therefore **not** equally supported once each candidate's own cited authority is measured.
> The ADR route was still taken, because the measurement had to be **ruled on** by the owner rather
> than acted on by the drafter.**

---

## 1. Context

### 1.1 The defect

A2 **`LCF-FR-026`** reads:

> *"This part SHALL NOT require any V3 capability. `Moderation (V3)` and `Community Analytics
> (V3)` (EA L972–973) are out of scope (`LCF-XC-016`, `LCF-XC-017`)."*

Both cited identifiers have the wrong subject. Measured in A2 v0.5 §4:

| Cited | A2 line | Its actual subject |
|---|---|---|
| `LCF-XC-016` | 208 | **Rate-limit policy authorship** — `BC-11` `RateLimitCounter` (BC Map L377) |
| `LCF-XC-017` | 209 | **Threaded replies and mentions** (narrowed at v0.5) |

Neither covers `Moderation (V3)`. Neither covers `Community Analytics (V3)`. A2 v0.5 recorded
this as `LCF-GAP-013` and — correctly, having no ruling — **left it intact**.

### 1.2 Why the `PRD_LIFECYCLE.md` fast path does not reach it

`PRD_LIFECYCLE.md` **L170** and **L283–296** permit fixing a *"typo or broken link"* directly.
Both citations are **syntactically valid** and **resolve to real, defined rows**. The defect is
**semantic** — the rows say the wrong thing. `ADR-0015` is the controlling precedent: it required
a **full ADR** to repoint three wrong context citations, and its own risk row warns against being

> *"used as precedent for editing frozen documents to fix 'obvious' typos without an ADR"*,

authorising *"three named cells in one named file"* only. This ADR stays inside that shape: **two
named cells in one named file.**

### 1.3 Why this was framed as a genuine choice, and what changed

`PRD-021A_OWNER_DECISION_REQUEST.md` §4.2 presented **two candidates per V3 subject**:

| V3 subject | Candidate A | Candidate B |
|---|---|---|
| `Moderation (V3)` | `LCF-XC-006` — moderation cases, abuse reports, enforcement, strikes, appeals (`BC-13`, BC Map L379) | `LCF-XC-028` — anti-spam heuristics, reputation scoring, abuse detection (`BC-13`, EA L919) |
| `Community Analytics (V3)` | `LCF-XC-015` — analytics metric definitions, projections, reports (`BC-26`) | `LCF-XC-029` — the analytics product for community content (EA L973) |

That framing was correct for a document with **no authority to measure the tie-break as
binding**. Under an Architecture Owner ruling the tie-break in §2.2 **is** available, and it is
decisive.

---

## 2. Decision

### 2.1 What is decided

**`LCF-FR-026`'s two cited identifiers are replaced:**

| Position | Was | Becomes |
|---|---|---|
| Exclusion covering `Moderation (V3)` | `LCF-XC-016` | **`LCF-XC-006`** |
| Exclusion covering `Community Analytics (V3)` | `LCF-XC-017` | **`LCF-XC-029`** |

Nothing else in `LCF-FR-026` changes. The EA line reference *"EA L972–973"* is **retained
unchanged** — it was always correct, and §2.2 is why.

### 2.2 ⭐ The determinative test — the requirement's own line reference

`LCF-FR-026` publishes its own authority: **"EA L972–973"**. Measured in the EA at HEAD
`c563931`:

| EA line | Content |
|---|---|
| **L972** | `Moderation (V3)` |
| **L973** | `Community Analytics (V3)` |

Now measure **each candidate's own cited authority**:

| Candidate | Cites | That line is | Verdict |
|---|---|---|---|
| `LCF-XC-006` | BC Map **L379** — `ModerationCase` | the `BC-13` **moderation-case aggregate** | ✅ the moderation-subject exclusion |
| `LCF-XC-028` | EA **L919** — `Anti-Spam & Rate Limits` **(V1)** | a **V1** node | ⛔ **cannot** be the exclusion for a **V3** subject |
| `LCF-XC-015` | `BC-26` (BC Map **L135**) | the analytics **context**, platform-wide | ⛔ not the community-content analytics product, and cites no EA line |
| `LCF-XC-029` | **EA L973** | **the exact line `LCF-FR-026` cites** | ✅ the analytics-subject exclusion |

Two independent eliminations, each from the candidate's **own** published authority:

1. **`LCF-XC-028` is eliminated on version.** `LCF-FR-026` is a **V3**-exclusion requirement.
   `LCF-XC-028`'s cited node is tagged **`(V1)`**. A V1 node cannot be the ground on which a V3
   capability is excluded — citing it would make the requirement self-contradicting.
2. **`LCF-XC-029` is selected on exact line identity.** It is the **only** exclusion row in A2
   that cites **EA L973**, which is one of the two lines `LCF-FR-026` names. The remaining line,
   **L972** (`Moderation (V3)`), is the moderation subject, and `LCF-XC-006` is the moderation
   exclusion — the only row addressing moderation *as a capability the part does not perform*.

⭐ **This is a measurement, not a preference.** No intent was reconstructed, no plausibility was
weighed, and no row's meaning was reinterpreted. The pair was read off the line references the
documents already publish. A2 v0.5 §34 had itself observed the same pair — *"The V3 subjects are
actually covered by `LCF-XC-006` (moderation) and `LCF-XC-029` (analytics)"* — and then declined
to act, because an observation is not authority. **This ADR supplies the authority; it does not
supply the answer.**

### 2.3 What is **not** decided

| Not decided | Why |
|---|---|
| What any exclusion row excludes | ⛔ **Unchanged.** `LCF-XC-006`, `015`, `016`, `017`, `028`, `029` keep their subjects **byte-for-byte** |
| `LCF-XC-017`'s narrowing | Already settled by the Product Owner at v0.5. Not re-opened |
| Whether A2 requires a V3 capability | Already answered — `LCF-FR-026` says it does not, and that normative claim is untouched. Only the **pointer** was wrong |
| Any register count | `LCF-XC-*` stays **29**, `001`–`029`. No identifier minted, none retired |
| `LCF-GAP-014`, `LCF-GAP-009`, or any weight | Not this owner's, not this subject |
| Readiness or freeze | Not conferred — §5.2 |

---

## 3. Alternatives considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | **`LCF-XC-028` + `LCF-XC-015`** (both Candidate B/A crossed) | `LCF-XC-028` cites a **V1** node (§2.2 elimination 1); `LCF-XC-015` scopes to the `BC-26` context rather than the community-content analytics product and cites no EA line |
| 2 | **Cite all four rows** | Over-citation would assert that rate-limit authorship and anti-spam heuristics are *V3 capability exclusions*, which they are not. It would replace a wrong pointer with a vaguer one |
| 3 | **Delete the parenthetical citation** | `LCF-FR-025` requires V2/V3 dependencies to be *"recorded with its EA line reference"*. Removing the pointer would breach the neighbouring requirement to fix this one |
| 4 | **Rewrite `LCF-XC-016`/`017` to match the citation** | Backwards, and destructive: it would change what two exclusion rows exclude — a scope act, owned by the Product Owner, to repair an architecture-owned pointer. It would also undo the v0.5 narrowing |
| 5 | **Leave it open and carry `LCF-GAP-013`** | Correct for v0.5, which had no ruling. Now that the owner has ruled, carrying a defect whose answer is measured would be an evasion |
| 6 | **Fold into `ADR-0075`** | Different subject (a Rank-3-draft citation vs a Rank 6 tree), different precedent (`ADR-0015` vs `ADR-0042`), different blast radius. `ADR-0033` §7.1 |
| 7 | **Use the lifecycle fast path** | §1.2 — the defect is semantic, not a typo or broken link |

---

## 4. Consequences

### 4.1 Positive

- `LCF-FR-026` now cites rows that carry its subject. A reader can verify the V3 exclusion claim.
- `LCF-GAP-013`, one of A2's two remaining §34 defects, closes at its cause.
- The `ADR-0015` precedent is applied at **two** cells rather than stretched — its stated limit is
  respected, not tested.

### 4.2 Negative / accepted costs

- ⚠ The pair is chosen on **line-reference identity and version consistency**, not on recovered
  authorial intent. Intent is unrecoverable; the ADR says so rather than claiming otherwise.
- ⚠ `LCF-XC-015` and `LCF-XC-028` remain **valid, defined and unreferenced by `LCF-FR-026`**.
  That is correct — they exclude real things, just not V3 capabilities. **Neither is retired.**

### 4.3 Neutral

- No code, test, gate, manifest or Rank 1–5 register is affected.

---

## 5. Scope limits

### 5.1 Exactly what changed

**Two identifier tokens in one requirement in one file.** Verified by §7: A2's `LCF-XC-*` register
is unchanged at 29 identifiers, and every exclusion row's subject text is byte-identical.

### 5.2 ⛔ No readiness, no freeze

`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** gates `PRD-021` behind `PRD-020`, which is
unranked `DRAFT`. A2 remains **NOT READY — NOT FROZEN**. This ADR closes one gap; it advances no
stage.

---

## 6. Migration — executed

| Step | Action | State |
|---|---|---|
| 1 | This ADR raised and accepted **before** the change (`DOCUMENTATION_BASELINE.md` §7 step 1) | ✅ |
| 2 | `LCF-FR-026`'s two cited identifiers replaced — `LCF-XC-016` → `LCF-XC-006`, `LCF-XC-017` → `LCF-XC-029` | ✅ |
| 3 | A2 version incremented **v0.5 → v0.6** and its header CHANGELOG updated in the **same commit** (§7 step 2) | ✅ |
| 4 | A2 §34 `LCF-GAP-013` row moved 🔴 OPEN → ✅ **RESOLVED**, citing this ADR | ✅ |
| 5 | Baseline identifier **not** advanced (§7 step 4 — A2 is unranked) | ✅ |

---

## 7. Compliance record

| Check | Result |
|---|---|
| Guessing performed? | ✅ **No** — §2.2 is a two-way elimination from the candidates' **own** cited line references |
| Any exclusion row's subject changed? | ✅ **No** — all six read byte-identically |
| Identifier minted or retired? | ✅ No — `LCF-XC-*` stays 29 / `001`–`029` |
| Frozen artefact touched? | ✅ No |
| Rank 1–5 document amended? | ✅ **No** — A2 is an unranked `DRAFT`. `MASTER_PRD.md`, the EA, the BC Map and `ARCHITECTURE_RULINGS.md` are byte-unchanged **by this ADR** |
| Accepted ADR's decision text edited? | ✅ No — `ADR-0015` read as authority, left byte-unchanged |
| `ADR-0015`'s stated cell limit respected? | ✅ Yes — **two** cells in **one** named file, inside its *"three named cells in one named file"* |
| Baseline identifier advanced? | ✅ No |
| Readiness / freeze claimed? | ✅ **No** — §5.2 |
