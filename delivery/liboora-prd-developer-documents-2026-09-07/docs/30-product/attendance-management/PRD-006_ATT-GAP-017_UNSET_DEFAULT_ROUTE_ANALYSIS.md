# `ATT-GAP-017` — The "explicit unset" route: a fifth option no prior record considered

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-017` Unset-Default Route Analysis |
| **Version** | v1.0 · 2026-08-04 |
| **Purpose** | Test whether the remaining four settings can be resolved **without inventing a value**, using a precedent already frozen at Rank 3 |
| **Finding** | ✅ **A precedent exists.** A frozen Rank 3 PRD satisfies `LIB-16.2` for a gap-bound numeric setting **without supplying a number** |
| **Consequence** | 🟡 **A fifth option is now available to the decision owner.** It is **not** exercised here — exercising it is an owner/ARB act |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` v1.3 DRAFT · SHA-256 `93ab1c60d740c4e0…` **unmodified** |
| **Freeze** | 🔴 **Not conferred** |

> **Why this document exists.** Four prior records reported `ATT-CFG-005`, `006`, `019` and `014` as BLOCKED and
> stopped. The instruction directs that where the repository contains a legitimate authority or process, it be
> followed rather than merely reported. This document is the result of doing that: searching the frozen corpus
> for how an *already-frozen* PRD handled the identical problem. It found one, and `ADR-0021` never considered it.

---

## 1. The four remaining settings — what was verified first

| ID | Setting | Capability | Capability's build status |
|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | Dynamic QR | **Construction blocked** by `ATT-GAP-006` (§33 L2307) |
| `ATT-CFG-006` | Dynamic QR validity window | Dynamic QR | **Construction blocked** by `ATT-GAP-006` |
| `ATT-CFG-019` | OCR high-confidence threshold | Register-image / OCR | `ATT-FR-080` — *"**MUST NOT** be implemented"* |
| `ATT-CFG-014` | Face match confidence | Face | `ATT-FR-064` — *"**MUST NOT** be implemented … not authorised to be built"* |

**Measured: all four belong to capabilities that cannot be built in V1.** Every one is `Disabled` by default at
its enabling flag (`ATT-CFG-002`, `018`, `016`) and two are under an explicit `MUST NOT` build block.

**The ordering requirement was verified to exist**, as instructed, rather than assumed:

> `ATT-CFG-005` validation (L1159): *"Must be > 0 **and ≤ validity window**"*
> `ATT-CFG-006` validation (L1160): *"Must be **≥ rotation interval**"*

The requirement is real and mutual. **No new rule was invented**, and because no values were supplied, no
consistency arithmetic between them was performed.

---

## 2. The Security Platform authority was traced — it does not exist yet

`PRD_OWNERSHIP_MODEL.md` §2.2 makes Security Platform a **Domain Owner**, and the registry names its document:

> `PRD_REGISTRY.md` L242 — `PRD-012` Security & Automation · **`PLANNED`**
> L244 — *"⚠ **`PRD-012` must not be written as one PRD.**"*
> L248 — *"**`PRD-012` is therefore a placeholder that will never be authored.**"*
> L253 — `PRD-012a` **Security Automation** · **SECURITY platform (rank 2)** · **`PLANNED`**

`docs/30-product/` contains seven module directories; **there is no security directory and no `PRD-012a`.**

**Conclusion: the Security Platform's specification does not exist.** `ATT-CFG-005`/`006` are rotation and
validity parameters for a security artefact, and the owner competent to bound them has no authored document in
this repository. This is not an oversight to route around — it is a genuine external-authority blocker.

---

## 3. OCR/Vision ownership was traced through `ADR-0023` — deferral is a real option, but not mine

`ADR-0023` §4 costs four options: **A** extend `BC-27` AI Assistance · **B** create a new capability context
(31 → 32) · **C** assign to an existing non-AI context (*"**No candidate is nominated here**"*) · **D** defer.

Option D is explicitly legitimate on precedent: *"`ADR-0020` admitted `PRD-007` with fourteen open gaps, so
deferral is a legitimate outcome."*

**But Option D is still an ARB selection.** `ADR-INDEX.md` defines `Proposed` as *"under consideration; **not
binding**"*, and `ADR-INDEX.md` Process step 1 reserves structure/ownership decisions to an ADR accepted by its
authority. Choosing D on the ARB's behalf — even the cheapest option — would be deciding another owner's
question, which `ADR-0020` L233 names as the reason it declined to close fourteen gaps.

---

## 4. THE FINDING — a frozen Rank 3 precedent for a valueless numeric setting

Searching the two frozen module PRDs' configuration registers for how they handle a numeric setting whose value
depends on an unresolved gap returned an exact analogue in **`PRD-007`, frozen at Rank 3 by `ADR-0020`**:

> `PRD-SEAT-MANAGEMENT.md` L1890 —
> `| SEAT-CFG-017 | Occupancy percentage that emits SEAT-EVT-004 | BC-06 via E-05 | `**Unset in V1 — no event is
> emitted and no value is substituted** *(explicit unset behaviour per `SEAT-FR-265`)*; **90%** applies only once
> `E-05` carries the threshold (`SEAT-GAP-005`) `| Integer 1–100, or unset | …`

Structural comparison against `ATT-CFG-019` (the closest analogue — a threshold on a capability that is not built):

| Property | `SEAT-CFG-017` (frozen) | `ATT-CFG-019` (draft) |
|---|---|---|
| Numeric threshold | ✅ | ✅ |
| Value depends on an **open gap** | ✅ `SEAT-GAP-005` | ✅ `ATT-GAP-017` |
| Capability inoperative in V1 | ✅ no event emitted | ✅ `ATT-FR-080` blocks the build |
| Default column | **"Unset in V1 — no value is substituted"** | **"`ATT-GAP-017`"** |
| Allowed domain column | **"Integer 1–100, or unset"** | **"Bounded 0–1 — unresolved"** |
| Substitution forbidden | ✅ `SEAT-FR-265` | ✅ `ATT-BR-043` |
| **Frozen at Rank 3?** | ✅ **YES** | 🔴 blocked on this issue |

**Both documents make the same substantive choice — refuse to invent a number. They differ only in how the
register *states* it.** `PRD-007` writes a documented default whose content is *"unset, and here is the unset
behaviour"*, plus a domain that admits `unset` as a legal member. `PRD-006` writes a gap identifier in both
columns.

### 4.1 Why the difference is decisive for `LIB-16.2`

`LIB-16.2` sentence 1: *"Every setting **MUST** have a documented default."* It requires a **documented
default** — not a *numeric* one. `SEAT-CFG-017` documents its default as *unset with specified consequences*, and
an ADR-accepting authority admitted that as satisfying Rank 3 freeze. `ATT-CFG-019` documents an **unanswered
question** — a pointer to a gap is not a default in any form.

`PRD-006` already possesses the entire behavioural apparatus this route needs, and it is **stronger** than
`PRD-007`'s: `ATT-BR-043` (no substitution), `ATT-FR-149` (mode not enableable), `ATT-FR-150` (fail closed),
`ATT-FR-151` (Owner shown no default exists), `ATT-BR-044` (operability check). **What is missing is not
behaviour — it is register wording.**

### 4.2 `ADR-0021` never considered this

`ADR-0021` §4 costs exactly four options: **A** owner supplies values · **B** commission an anchored analysis ·
**C** PRD supplies envelopes + Guide supplies values · **D** descope the capabilities. Searched: `ADR-0021`
contains **zero** occurrences of `SEAT-CFG-017` or `unset`. The frozen precedent was not in its option set.

**This is therefore a genuine fifth option, discovered from the repository's own frozen corpus:**

> **Option E — Document the default as an explicit unset, per the `SEAT-CFG-017` precedent.** For each unresolved
> setting, replace the Default column's gap pointer with an explicit unset statement and its consequence, and
> widen the Allowed domain to admit `unset` as a legal member — citing `ATT-FR-149`/`ATT-FR-150` for the
> behaviour, exactly as `SEAT-CFG-017` cites `SEAT-FR-265`. **No number is invented. `LIB-16.2` sentence 1 is
> satisfied in the same manner a Rank 3 frozen document already satisfies it.**

---

## 5. Why this analysis does **not** exercise Option E

Option E is a **register-wording amendment to `PRD-006` §16.3**, and three things put it beyond this analysis:

1. **It reinterprets `ATT-GAP-017`.** The gap asks *"What are the default values and allowed ranges…"*. Option E
   answers *"the documented default is 'unset'"* — a legitimate answer, but a **different kind** of answer than
   the one the gap's owner posed. Deciding that the question may be answered that way is the **product owner's**
   call (the gap's named owner), not a reviewer's.
2. **`ATT-CFG-014` is not eligible without the ARB.** Face's release class is unresolved (`ATT-GAP-015`, PO says
   V3, ARB pending). Writing *"unset in V1"* presumes the V1/V3 answer.
3. **Sequencing.** Amending §16.3 moves the subject hash off `93ab1c60d740c4e0` and re-triggers a **full Stage 4
   re-review**. That is correct and expected — but it must be done **once**, for all seven rows, after the owner
   confirms Option E applies. Doing it now for four rows while three carry PO values, then again later, produces
   the partial-edit incoherence that §4 of the PO value record already declined.

**What Option E changes is the shape of the remaining blocker.** It was reported as *"four values are missing and
only external authorities can supply them."* It is now demonstrably: *"the product owner may either supply four
values, **or** authorise the `SEAT-CFG-017` wording — and the second requires no Security Platform document, no
OCR ownership assignment, and (for three of the four) no ARB."*

| Setting | Needs a value? | **Or Option E?** | Residual dependency under Option E |
|---|---|---|---|
| `ATT-CFG-005` | Security Platform range | ✅ eligible | **None** — PO authorisation only |
| `ATT-CFG-006` | Security Platform range | ✅ eligible | **None** — PO authorisation only |
| `ATT-CFG-019` | OCR owner first | ✅ eligible | **None** — `ATT-FR-080` already blocks the build |
| `ATT-CFG-014` | PO + Security | ⚠️ conditional | **ARB** must settle V1-vs-V3 first |

---

## 6. Gate results at the time of this analysis

| Stage | Result |
|---|---|
| **Stage 4** | ⚠️ **CONDITIONALLY PASSED** — 0 commits to subject, hash `93ab1c60d740c4e0` identical → no re-review triggered. **Not upgraded** |
| **Stage 5** | ✅ **exit 0** |
| **Stage 6** | ✅ **exit 0** — 285/285 = 100.0% |
| **Stage 7** | 🔴 **UNSATISFIED** — 0 baseline rows; registry `` `PLANNED` `` |

---

## 7. What this analysis did **not** do

| Not done | Why |
|---|---|
| Invent any value, range, unit or threshold | Absolute rule. **Zero numbers were proposed** |
| Exercise Option E | §5 — it reinterprets the gap; that is the product owner's act |
| Amend `PRD-006` §16.3 or issue v1.4 | Must be one coherent amendment covering all seven rows |
| Select `ADR-0023` Option D (defer) | Legitimate outcome, but an **ARB** selection (§3) |
| Accept `ADR-0021`, `0022` or `0023` | No acceptance authority present; all remain **Proposed** |
| Record an ARB approval for Face V3 | None exists |
| Invent a `validity ≥ rotation` rule | Verified it **already exists** at L1159/L1160 — nothing added |
| Create an admitting ADR | Baseline §7 step 1 requires ARB acceptance, which is absent |
| Mark `PRD-006` FROZEN | Freeze is *"conferred, not claimed"* |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Followed the instruction to pursue legitimate repository authority rather than only reporting blockers, and produced **two findings no prior record contains.** **(1)** Traced the Security Platform authority to `PRD_REGISTRY.md` L242–253 and established that `PRD-012` is *"a placeholder that will never be authored"* while its successor `PRD-012a` is `PLANNED` with **no directory in `docs/30-product/`** — so the owner competent to bound `ATT-CFG-005`/`006` has no authored specification, a genuine external blocker. **(2) Searched the frozen Rank 3 corpus for a precedent and found one**: `PRD-SEAT-MANAGEMENT.md` L1890 `SEAT-CFG-017` is a numeric threshold, tied to an open gap (`SEAT-GAP-005`), on a capability inoperative in V1, whose Default column reads *"**Unset in V1 — no event is emitted and no value is substituted**"* with domain *"Integer 1–100, **or unset**"* — and it is **frozen at Rank 3 by `ADR-0020`**. Established that `LIB-16.2` requires a *documented* default, not a *numeric* one, and that `PRD-006` already holds stronger behavioural apparatus (`ATT-BR-043`, `ATT-FR-149`, `150`, `151`, `ATT-BR-044`) than `PRD-007` does — so what is missing is **register wording, not behaviour**. Verified `ADR-0021` §4 costs only four options and contains **zero** occurrences of `SEAT-CFG-017` or `unset`, making this a genuine **fifth option (Option E)**. Verified the *"validity ≥ rotation"* requirement genuinely exists at L1159/L1160 and invented no new rule. Verified all four remaining settings sit on capabilities blocked from construction. Declined to exercise Option E, giving three reasons: it reinterprets the gap's own question (a product-owner act), `ATT-CFG-014` needs the ARB's V1/V3 answer first, and §16.3 must be amended once for all seven rows. **Result: the remaining blocker is re-characterised — three of the four settings need no Security Platform document and no OCR ownership assignment if the owner authorises Option E.** Gates: Stage 4 no trigger and not upgraded, Stage 5 exit 0, Stage 6 exit 0, Stage 7 unsatisfied. **No value, range, approval, signature or ADR acceptance invented; no gate weakened; no governance bypassed; `PRD-006` and all protected documents byte-identical; no code written; nothing pushed.** |
