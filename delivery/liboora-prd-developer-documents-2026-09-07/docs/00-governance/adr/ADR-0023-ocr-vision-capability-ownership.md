# ADR-0023 — No context owns an OCR/Vision capability, and this ADR does not assign one

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: "Under consideration; not binding")* |
| **Date** | 2026-08-04 |
| **Deciders** | **Architecture owner (ARB)** — `PRD-006` §32 names the owner and states *"needs an ADR"* |
| **Supersedes** | Nothing |
| **Amends** | **Nothing.** Assigning or creating a capability context is what a decision would authorise; none is made here |
| **Related** | `ATT-GAP-011` (**NARROWED**, not open in its original form) · `ATT-XC-005` · `ATT-FR-080` · BC Map §7.4 `F-1`/`F-3`/`F-4`, L136 · `MP-GBR-29`…`32` (Rank 1) · `ADR-0013` · `ADR-0017` · `ADR-0022` |

> ⚠️ **`Proposed`. This ADR frames a decision it is not authorised to make.**
>
> `ADR-INDEX.md` Process step 1 — *"A decision that changes **structure, ownership**, a boundary, or a
> platform-wide rule requires an ADR **before** implementation."* Assigning a capability to a bounded context is
> an ownership decision; creating a new capability context is a structural one. Both are named in the trigger.

---

## 1. Context

`PRD-006` §13B needs a processor that reads a photographed attendance register. **No such processor exists in the
repository**, and this is a measured finding, not an impression.

`PRD-006` §5.4 records the search: `OCR`, `computer vision`, `document AI` and `image recognition` across
`docs/**` return **zero capability nodes**, including in Enterprise Architecture v2.1's AI Platform tree.
`BC-27` AI Assistance's charter (BC Map **L136**) is *"prompts, agents, RAG retrieval, memory, guardrails, PII
redaction, human-in-the-loop, model routing"* — **no vision, no OCR, no image ingestion.**

The gap is therefore **not** "which of several candidates should own OCR". It is: **nothing in this repository
owns it, and something would have to be created or extended.**

---

## 2. Evidence

### 2.1 The question has already been narrowed once, correctly, and the narrowing must be preserved

`ATT-GAP-011` originally asked two things: *who owns OCR* **and** *what edge is needed*. **The edge half is
answered and refuted.** BC Map §7.4 rules, restated at **Rank 1** as `MP-GBR-29`…`32`:

* **`F-1`** — *"**No capability context may import, reference, or query a domain context.** Not AI, not Analytics,
  not Search, not Notification, not Workflow, not Audit."*
* **`F-3`** — *"Where a capability must *cause* a domain change… it does so by **invoking the domain's public
  command API** through a registered port — with the domain re-validating every invariant. **The capability is an
  untrusted caller.**"*
* **`F-4`** — *"AI-initiated domain writes additionally require a **Human-in-the-Loop approval record** (`BC-27`)
  and produce an `AI Action Log` entry (`BC-24`). **No exceptions in V1.**"*

`PRD-006` §5.4 draws the consequence and applies it **against** its own earlier draft:

> *"An OCR request modelled as `BC-03 → BC-27` would make Attendance depend on a capability; `F-3`'s direction is
> the reverse. **`ATT-XC-005` is therefore correct and is strengthened, not relaxed.** The absence of a
> `BC-03` → `BC-27` edge in §7 is **not a defect to be closed by an ADR — it is the intended state.**"*

**An ADR that added a `BC-03` → `BC-27` edge would be wrong.** This ADR must not be read as a vehicle for one.

`PRD-006` §32.1 records the gap as **🟡 NARROWED** for exactly this reason, and the Stage 5 gate reproduces that
classification mechanically: *"21 rows — 2 resolved, **1 narrowed**, 18 open"*.

### 2.2 What remains is a single question with no edge component

> **Which context owns an OCR/Vision capability, given that `F-1`/`F-3` already fix how it must reach `BC-03`
> once it exists?**

### 2.3 Two existing ADRs supply the governing principle — and neither answers this

* **`ADR-0013`** — *"A capability context is owned by its platform, not by the domain that consumes it."*
  This forecloses one tempting answer: **`BC-03` may not own OCR merely because Attendance is the consumer.**
* **`ADR-0017`** — resolved `BC-25` Configuration's ownership *on evidence*, namely `MASTER_PRD.md` §8 module 18
  naming it at **Rank 1**, and `ADR-INDEX.md` records the distinction that matters here: it was *"the consistent
  application of an existing rule, **not the invention of a PRD to fill a gap**."*

**No equivalent Rank 1 evidence exists for OCR.** `MASTER_PRD.md` §8 names no OCR or vision module. So the
`ADR-0017` route is unavailable: there is nothing to consistently apply.

### 2.4 The prohibition that makes the easy answer unavailable

`PRD-006` §0.4: *"A gap resolved by implementation choice is not resolved — it is an undocumented architecture
decision made by whoever happened to write the code first."* §5.4 applies it by name: *"Assigning it to `BC-27`
would be **inventing a capability**, which §0.4 forbids."*

Extending `BC-27`'s charter to cover vision is not a clarification. It is a **structural change to a Rank 4
frozen document**, and therefore requires an accepted ADR under Baseline §7 step 1 — which is why this draft
exists rather than an edit.

### 2.5 This gap does not stand alone

`ATT-FR-080` blocks on **both** `ATT-GAP-010` **and** `ATT-GAP-011`:

> *"Until `ATT-GAP-010` **and** `ATT-GAP-011` are answered by their named owners, the OCR/Vision workflow **MUST
> NOT** be implemented."*

And §13B's rationale states why answering only this one changes nothing: *"an approval mechanism with no
processor to approve is still not buildable, and… `ATT-GAP-010` — where the image bytes may legally live — is
untouched by §7.4."* **Symmetrically: a processor with nowhere to legally read the bytes from is equally
unbuildable.** `ADR-0022` carries the other half; **both** must be decided affirmatively to lift `ATT-FR-080`.

---

## 3. What this ADR does not decide

| Not decided | Why |
|---|---|
| Which context owns OCR/Vision | It is the question. Owner: architecture owner (ARB) |
| Whether a new capability context is created | Would take the count past **31**. A structural decision, ARB's |
| Whether `BC-27`'s charter is extended | BC Map L136 is **Rank 4, frozen**. Baseline §7 step 1 requires an accepted ADR first |
| Whether an OCR capability is procured or built | An implementation decision downstream of the ownership one |
| `ATT-GAP-010` — may `BC-03` hold a `FileRef`? | Separate draft `ADR-0022`. **Both** are required by `ATT-FR-080` |
| Whether §13B stays in V1 | Product scope, not architecture |
| Any `ATT-CFG-019` value | `ATT-GAP-017`'s owner is the product owner, and no engine exists to measure a confidence scale against |

---

## 4. Options, costed. None is recommended

### Option A — Extend `BC-27` AI Assistance to own OCR/Vision

Cheapest structurally: no new context, count stays **31**, `F-4`'s Human-in-the-Loop record already lives in
`BC-27` and `PRD-006` §13C already satisfies it. **But** it amends a Rank 4 frozen charter, and §5.4 already
characterises assigning OCR to `BC-27` on today's evidence as *inventing a capability*. Whether an
ARB-authorised charter extension escapes that objection is precisely the ARB's call.

### Option B — Create a new capability context for document/vision processing

Structurally honest — a capability that is genuinely absent gets modelled as absent-then-added. Costs: context
count **31 → 32**, a BC Map §3 entry, a §7 edge, and by the `ADR-0017` precedent likely a registered PRD. The
heaviest option, and the one with the clearest audit trail.

### Option C — Assign it to an existing non-AI platform context

Requires a candidate. `BC-29` File & Media holds bytes but is a storage capability, not a processing one.
**No candidate is nominated here**; naming one without evidence is the §0.4 failure mode.

### Option D — Defer; §13B is not built

`ATT-GAP-011` stays 🟡 NARROWED, `ATT-FR-080` stands, §13B remains specified and unbuilt. `ADR-0020` admitted
`PRD-007` with fourteen open gaps, so deferral is a legitimate outcome. **The cheapest option, and the one that
costs the product a feature.**

---

## 5. Consequences while `Proposed`

| Consequence | State |
|---|---|
| Bounded Context Map | **Unmodified.** No charter extended, no context created — still **31** |
| `ATT-GAP-011` | 🟡 **NARROWED — unchanged.** A draft is not an answer |
| `ATT-FR-080` | **Stands.** Blocked on `ATT-GAP-010` **and** `ATT-GAP-011` |
| `ATT-XC-005` | **Stands, and is strengthened by §7.4** — `BC-03` MUST NOT consume `BC-27` |
| `PRD-006` | Unmodified, unranked, DRAFT |
| `ADR-INDEX.md` | **Not updated** — see `ADR-0022` §6, same reasoning |

---

## 6. Compliance

| Rule | Compliance |
|---|---|
| `ADR-INDEX.md` step 1 — ADR before implementation | ✅ Written while the BC Map stands untouched |
| `ADR-INDEX.md` step 2 — number sequentially | ✅ `ADR-0023`, following `ADR-0022` |
| Baseline §7 step 1 — ADR before a Rank 1–5 change | ✅ No Rank 1–5 document is changed |
| BC Map L292 — adding an edge requires an ADR | ✅ **No edge added** — and §2.1 records that the requested edge would be *wrong* |
| `PRD-006` §0.4 — no resolution by implementation choice | ✅ No capability invented, no context nominated |
| `ADR-0013` — capabilities are platform-owned | ✅ Applied: `BC-03` is excluded as a candidate |
| `ADR-0017` — apply an existing rule, do not invent | ✅ Tested and found **unavailable**: no Rank 1 evidence exists |
| `MP-GBR-29`…`32` (Rank 1) | ✅ Restated, not reinterpreted |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created **`Proposed`** during a Phase 4 governance/ADR determination, because `PRD-006` §32 records `ATT-GAP-011`'s owner as *"Architecture owner — **needs an ADR**"* and `ADR-INDEX.md` Process step 1 fires on both *structure* and *ownership*. Preserves the existing **NARROWED** classification rather than reopening it: BC Map §7.4 `F-1`/`F-3`/`F-4` and Rank 1 `MP-GBR-29`…`32` already settled the **direction**, and `PRD-006` §5.4 records that the originally requested `BC-03` → `BC-27` edge *"is not a defect to be closed by an ADR — it is the intended state"*, so **this ADR must not be used to add one**. States the residual question in one line. Records that `ADR-0013` forecloses `BC-03` as owner and that the `ADR-0017` evidence route is **unavailable** because `MASTER_PRD.md` §8 names no OCR module at Rank 1. Frames four options and **chooses none**; Option C deliberately nominates **no** candidate context. Records that `ATT-FR-080` blocks on this gap **and** `ATT-GAP-010` (`ADR-0022`), so deciding either alone lifts nothing. **The Bounded Context Map is unmodified, the context count remains 31, no charter is extended, `ATT-GAP-011` remains NARROWED, and this ADR is not Accepted.** |
