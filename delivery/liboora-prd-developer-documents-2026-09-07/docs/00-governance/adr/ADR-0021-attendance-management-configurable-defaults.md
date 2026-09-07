# ADR-0021 — The seven valueless `ATT-CFG-*` settings require an owner decision, and this ADR does not make it

| Field | Value |
|---|---|
| **Status** | **Proposed** — not binding. *(`ADR-INDEX.md` status vocabulary: “Under consideration; not binding”)* |
| **Date** | 2026-08-04 |
| **Deciders** | **Product owner** (D-1 — the seven values and their ranges; security input required for `ATT-CFG-014`) · **Governance owner** (D-2 — whether a CONDITIONAL Stage 3/4 verdict permits Stage 7) · Architecture owner (acceptance) |
| **Supersedes** | Nothing |
| **Amends** | **No document.** While `Proposed` this ADR amends nothing, binds nothing and confers nothing. `PRD-006` is byte-identical; no Rank 1–7 document is touched |
| **Amended by** | — |
| **Baseline** | **None issued.** A `Proposed` ADR is not binding and therefore not Rank 2, and no Rank 1–3 document changes version, so `DOCUMENTATION_BASELINE.md` §7 step 4 is not triggered. The baseline remains **`BASELINE-2026-08-04-E`** |
| **Closes** | **Nothing.** It does not close `ATT-GAP-017` |
| **Does NOT close** | **`ATT-GAP-017`** — the seven configurables still have no defaults and no ranges. Nor the other eighteen `ATT-GAP-*`, nor `PRD_LIFECYCLE.md` Stage 7 for `PRD-006`, nor the `PRD_REGISTRY.md` L236 status defect, nor `GCP-05`/`GCP-06`/`GCP-09` |
| **Related** | [`PRD-006_PREFREEZE_BLOCKER_RESOLUTION.md`](../../30-product/attendance-management/PRD-006_PREFREEZE_BLOCKER_RESOLUTION.md) (the investigation this ADR carries forward) · [`PRD-006_STAGE7_FREEZE_READINESS.md`](../../30-product/attendance-management/PRD-006_STAGE7_FREEZE_READINESS.md) (verdict 🚫 BLOCKED) · `ADR-0013` / `ADR-0014` (the `Proposed`-status precedent) · `ADR-0020` (the Stage 7 admission precedent) · `AR-4` · `ACN-001` · `DOCUMENTATION_AUDIT-001` · `LIB-16.2` · [`CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md) · [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stages 3, 4, 7 · [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §4, §6, §7 |

> ⚠️ **`Proposed`, and deliberately so.**
>
> This ADR **proposes no numeric value for any setting, and no allowed range.** It exists because
> [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md) Stage 4 requires an unresolved conflict to be *“explicitly
> deferred **with a reason and an owner**”*, and because the alternative to writing it was to invent seven security
> and product parameters — which `ATT-BR-043` forbids in terms and which `AR-4` calls *“how unreviewable magic
> numbers enter a codebase.”*
>
> `ADR-0013` and `ADR-0014` were likewise authored `Proposed` and accepted later. That is the precedent followed here.

---

## 1. The question

[`PRD-006_ATTENDANCE-MANAGEMENT.md`](../../30-product/attendance-management/PRD-006_ATTENDANCE-MANAGEMENT.md) v1.3
has completed Stages 3–6 of [`PRD_LIFECYCLE.md`](../prd-ecosystem/PRD_LIFECYCLE.md). Stage 7 returned **🚫 BLOCKED**
on one substantive item.

§16.3 defines **24** tenant configurables. **Seventeen** carry a concrete default and a closed allowed domain.
**Seven** carry the literal token `ATT-GAP-017` in the *Default* column and the word **unresolved** in the *Allowed
domain* column:

| ID | Configurable | Default | Allowed domain |
|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | **`ATT-GAP-017`** | Bounded duration — **unresolved** |
| `ATT-CFG-006` | Dynamic QR validity window | **`ATT-GAP-017`** | Bounded duration — **unresolved** |
| `ATT-CFG-011` | GPS acceptance radius | **`ATT-GAP-017`** | Bounded distance — **unresolved** |
| `ATT-CFG-012` | Minimum acceptable location accuracy | **`ATT-GAP-017`** | Bounded distance — **unresolved** |
| `ATT-CFG-014` | Face match confidence threshold | **`ATT-GAP-017`** | Bounded 0–1 — **unresolved** |
| `ATT-CFG-019` | OCR high-confidence threshold | **`ATT-GAP-017`** | Bounded 0–1 — **unresolved** |
| `ATT-CFG-023` | Correction window | **`ATT-GAP-017`** | Bounded duration — **unresolved** |

`PRD-006` §16.3 states the consequence itself, without being asked to:

> Seven rows above carry **`ATT-GAP-017`** in the Default column instead of a value … **This is a live breach of
> `LIB-16.2`** (Rank 3, Library PRD: *“Every setting **MUST** have a documented default”*) and it is recorded as a
> breach rather than closed by choosing seven numbers.

**Two questions follow, and they have different owners.**

- **D-1 — product owner.** By what route are the seven defaults *and their allowed ranges* established? → §4
- **D-2 — governance owner.** Does a **CONDITIONAL** Stage 3 / Stage 4 verdict permit entry to Stage 7? → §5

Neither is an architecture question, which is why neither is answered here.

---

## 2. Evidence

### 2.1 There is no authoritative source. This was tested, not assumed.

`PRD-006` asserts *“No Rank 1–5 source.”* An assertion by the document under review is not evidence, so the claim
was tested independently across `docs/30-product/`, `docs/10-architecture/`, `docs/00-governance/` and
`docs/20-configuration/`, excluding `attendance-management/` itself, over four concept families — code
rotation/expiry, geospatial radius and accuracy, biometric and OCR confidence, and correction windows.

**Result: zero authoritative values for all seven.** The PRD's claim is confirmed. Full search table:
[`PRD-006_PREFREEZE_BLOCKER_RESOLUTION.md`](../../30-product/attendance-management/PRD-006_PREFREEZE_BLOCKER_RESOLUTION.md) §2.2.

> **The near-miss, recorded because it is the mistake most likely to be made next.** The Authentication PRD *does*
> specify code-expiry behaviour, and `CONFIGURATION_GUIDE.md` gives OTP validity a concrete figure. Reusing it for
> `ATT-CFG-006` would *look* like citing a source. It would not be one: an OTP is a one-time secret transmitted to
> a phone in `BC-18`; a Dynamic QR code is a rotating display artefact in `BC-03`. Same word, different threat
> model, different bounded context, different owner. Borrowing the number would import a security parameter across
> a context boundary and dress an invention as a citation.

### 2.2 The repository has solved this before — and none of the three routes is available to a reviewer

| Precedent | What happened | Who supplied the anchor |
|---|---|---|
| **`ACN-001`** (Authentication) | OTP rate limits unspecified, *“no assumed values.”* Closed by specifying the policy **structure** normatively; the thresholds became `CFG-1`…`CFG-4` | Structure by the PRD author; **values by the Configuration Guide, inside envelopes the PRD supplied** |
| **`AR-4`** (Invitation Security) | Six security parameters deferred — *“inventing security parameters without a mandate is how unreviewable magic numbers enter a codebase.”* Deferral **lifted** | **The product owner**, by supplying the Library PRD. The deferral lifted *“because the Library PRD §§1–25 has been received”* |
| **`DOCUMENTATION_AUDIT-001`** | Twelve `CFG-*` re-anchored to NIST SP 800-63B, OWASP and market analysis; **six values changed** | **Named external standards**, applied by an authorised audit |

**What the three establish:** a value may be set once it is *anchored* — to a named external standard, to stated
operational analysis, or to owner input.

**What none of them establishes:** that a *reviewer* may perform the anchoring. In every case the anchor arrived
from outside the review. **No new authority has arrived for `ATT-GAP-017`.**

### 2.3 `CONFIGURATION_GUIDE.md` cannot absorb these seven

The Guide is the obvious home — it is **Rank 7** and already holds 35 parameters (`CFG-1`…`12`, `LCFG-1`…`13`,
`ICFG-1`…`10`) for exactly this purpose. It cannot take these, for a structural reason rather than a procedural one.

> `DOCUMENTATION_BASELINE.md` §4, Rank 7: *“Operating values **within the envelope** 1–3 define.”*
> `CONFIGURATION_GUIDE.md`: *“Subordinate to the PRDs. This guide sets values **within** the envelope they define;
> **it cannot change the envelope**.”*

**An envelope is a declared range, and for all seven the envelope is itself marked unresolved.** `Bounded 0–1` is a
*type*, not a range: it excludes `1.7` but admits `0.01` and `0.99` equally, and a face-match threshold of `0.01`
authorises impersonation. A Guide entry would require inventing the envelope first — precisely what Rank 7 forbids.

Contrast `ICFG-2`: *“**7 d**, range 1 h – 30 d.”* The PRD supplied the envelope; the Guide set the value inside it.
That division of labour is unavailable here because **half of it is missing**. This is why the register asks for
*“default values **and allowed ranges**”* — both — and the second half is what forecloses the easy route.

### 2.4 The specification under review forbids substitution normatively

`ATT-BR-043` is a **MUST**-class rule in `PRD-006` itself:

> A configurable whose Default column names an unresolved gap has **no default value, and no value **SHALL** be
> substituted for it** — not zero, not a framework default, not a value copied from another tenant, another mode,
> **another product** or an example in this document.

*“Another product”* forecloses the `CFG-*` / `ICFG-*` borrowing route by name. Supplying the seven values from
within the review would require **violating a normative rule of the specification being made freezable** —
resolving a blocker by breaking the document. `PRD-006` §0.4 states the general form:

> A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made by
> whoever happened to write the code first.

### 2.5 The breach is real, and it is latent

`ATT-BR-044` demonstrates that `LIB-16.2`'s **second** sentence — *“a library that has changed nothing MUST be
fully operable”* — is satisfied **in fact**: every one of the seven belongs to a capability that is *off by
default*. `ATT-CFG-005`/`006` require Dynamic QR (`ATT-CFG-002` **Disabled**); `011`/`012` require Fixed QR + GPS
(`ATT-CFG-004` **Disabled**); `014` requires Face (`ATT-CFG-016` **Disabled**, and `ATT-FR-064` blocks the build
outright); `019` requires the register-image workflow (`ATT-CFG-018` **Disabled**, and `ATT-FR-080` blocks the
build outright); `023` is optional by construction. A day-one tenant uses Manual, which has concrete defaults.

`ATT-FR-149`/`150`/`151` make the behaviour in the absence of a value deterministic: the mode cannot enable, no
attendance is accepted or rejected by evaluating a valueless setting, and the Owner is shown that no platform
default exists.

**None of that supplies a default.** `LIB-16.2`'s **first** sentence is unqualified — *“Every setting **MUST** have
a documented default”* — and it remains breached. The mitigation makes the breach unreachable; it does not make it
absent.

### 2.6 Why this one gap blocks when eighteen others do not

Open gaps do not bar freeze, and it would be wrong to imply they do:

- `DOCUMENTATION_BASELINE.md` §6 carries **`GCP-05`** — a contradiction *inside* frozen Rank 3 `PRD-003` — and
  **`GCP-06`** — a contradiction *inside* the frozen Rank 4 Bounded Context Map — both **OPEN**.
- `ADR-0020` §3 admitted `PRD-007` to Rank 3 with **fourteen** `SEAT-GAP-*` open, under a heading that says so:
  *“The open items — **investigated, not resolved**.”*

`ATT-GAP-017` differs **in kind**, not in degree. It is not merely an absent decision: it is an **active breach of
a MUST in a different Rank 3 document**. Freeze would confer Rank 3 authority on the violation.

Measured across the frozen module PRDs and `PRD-006`, occurrences of the phrase `live breach`:

| Document | Count |
|---|---|
| `PRD-SEAT-MANAGEMENT.md` (`PRD-007`, frozen) | **0** |
| `PRD-MEMBERSHIP-MANAGEMENT.md` (`PRD-005`, frozen) | **0** |
| `Student_Management_PRD_v1.md` (`PRD-004`, frozen) | **0** |
| `Library_PRD_v1.md` (frozen) | **0** |
| **`PRD-006_ATTENDANCE-MANAGEMENT.md`** | **1** |

**`PRD-006` would be the first frozen PRD in this repository carrying a self-declared live breach of a ranked
document.** There is no precedent to rely on, and none to distinguish. That is a decision for an owner, not an
inference for a reviewer.

---

## 3. What this ADR does not decide

Recorded explicitly, because an ADR that quietly widens its own scope is worse than no ADR.

| Not decided | Why |
|---|---|
| Any of the seven values | §2.1–§2.4. No source exists; `ATT-BR-043` forbids substitution; the owner is named |
| Any of the seven allowed ranges | Same. The range is the harder half — it is what makes a value reviewable |
| Whether `PRD-006` is frozen | Stage 7's gate is a baseline row, and no baseline row is created here |
| Whether `LIB-16.2` should be relaxed | That is a change to Rank 3 `Library_PRD_v1.md` and requires its own ADR against that document, by its owner |
| `ATT-GAP-001`…`016`, `018`, `016a`, `017a` | Each has its own named owner in `PRD-006` §32. Eighteen remain open and untouched |
| The `PRD_REGISTRY.md` L236 status defect | Recorded in the readiness review §7.1; belongs to the governance owner |
| `GCP-05`, `GCP-06`, `GCP-09` | Inherited, unrelated, and not opened here |

---

## 4. D-1 — the decision required of the product owner

**The decision is *which route*, not *which numbers*.** Four routes are supported by this repository's own
precedents. Each is costed below. **This ADR recommends no value under any of them.**

### Option A — The owner supplies the seven values and their ranges directly

*Pattern:* `AR-4`. The deferral lifted when the product owner supplied the missing authority.

| | |
|---|---|
| **Who acts** | Product owner; security input required for `ATT-CFG-014` (face) and advisable for `ATT-CFG-005`/`006` (QR rotation) |
| **What changes** | `PRD-006` §16.3 — seven *Default* cells and seven *Allowed domain* cells. Version → v1.4 with a changelog entry. `ATT-GAP-017` → RESOLVED in §32 / §32.1 |
| **Cost** | One owner decision cycle. Requires the owner to hold, or obtain, a security position on biometric thresholds |
| **Risk** | Values set without a stated anchor become the numbers the next reviewer treats as requirements. `DOCUMENTATION_AUDIT-001` had to change **six of twelve** such values later |
| **Effect on the breach** | **Closes it.** 24/24 with defaults; `LIB-16.2` satisfied in both sentences |

### Option B — Commission an anchored analysis; the owner ratifies its output

*Pattern:* `DOCUMENTATION_AUDIT-001`. Twelve `CFG-*` anchored to NIST SP 800-63B, OWASP and market analysis.

| | |
|---|---|
| **Who acts** | Whoever the owner commissions produces the anchors; **the product owner still ratifies.** An anchor is evidence, not authority |
| **What changes** | As Option A, plus an anchor column or companion note recording *why* each value is what it is |
| **Cost** | Highest of the four. Biometric and OCR thresholds are vendor- and dataset-dependent, so the anchor for `ATT-CFG-014`/`019` may be an evaluation rather than a citation |
| **Risk** | Lowest. Every value is defensible at review, and a later audit can re-anchor without re-litigating intent |
| **Effect on the breach** | **Closes it**, with the strongest evidence trail |

### Option C — `PRD-006` supplies the **envelopes**; `CONFIGURATION_GUIDE.md` supplies the **values**

*Pattern:* `ACN-001` + `ICFG-2`. The PRD specifies structure and range; Rank 7 sets the operating value inside it.

| | |
|---|---|
| **Who acts** | Product owner sets seven ranges (the architectural half); configuration owner sets seven values inside them |
| **What changes** | `PRD-006` §16.3 *Allowed domain* → seven concrete ranges, v1.4. `CONFIGURATION_GUIDE.md` gains seven new parameter entries |
| **Cost** | Two coordinated changes across two ranks instead of one |
| **Risk** | The division is real work, not a formality — a range is itself a security statement (`0.01` vs `0.95` for face match). Splitting it does **not** reduce the judgement required; it relocates half of it |
| **Effect on the breach** | **Closes it**, and matches how the repository governs its other 35 parameters. **Unavailable until the ranges exist** — see §2.3 |

### Option D — Descope the affected capabilities from V1

| | |
|---|---|
| **Who acts** | Product owner, as a scope decision |
| **What changes** | Dynamic QR, Fixed QR + GPS, Face and the register-image workflow leave V1; `ATT-CFG-023` becomes explicitly absent. The settings cease to exist in V1, so no default is owed |
| **Cost** | Largest product impact of the four. Removes four of the five capture modes; touches `ATT-FR-*`, `ATT-AC-*` and the Stage 6 backlog broadly, and would require Stages 4–6 to be re-run |
| **Risk** | Two of the four (Face, register-image) are **already build-blocked** by `ATT-FR-064`/`ATT-FR-080` on separate gaps, so descoping them costs less than it appears. Dynamic QR and GPS are not blocked and would be a genuine product loss |
| **Effect on the breach** | **Eliminates it** by eliminating the settings. Manual mode is unaffected and remains fully specified |

### 4.1 What the four have in common

Each requires **the product owner to act**. None can be executed by a reviewer, an architect or an implementer.
That is the finding, and it is the reason this ADR is `Proposed` rather than `Accepted`.

### 4.2 The mechanical consequence, whichever option is chosen

Recorded so the owner can see the size of what the decision unlocks. Under **A**, **B** or **C**:

- Stage 4 §5.6 check 3 moves **17/24 → 24/24**; its single 🔴 **FAIL** clears.
- The `LIB-16.2` breach **closes**; `PRD-006` §16.3's disclosure paragraph is retired.
- The gap ledger moves **2 resolved / 1 narrowed / 18 open → 3 / 1 / 17**.
- `IMPL-667` unblocks (12 blocked tasks → 11). Coverage stays **285/285 = 100.0%** — it was never the problem.
- Stage 3 and Stage 4 verdicts remain **⚠️ CONDITIONAL**; the condition simply ceases to be *this* one, so §5 still applies.

Under **D**, the arithmetic differs and Stages 4–6 require re-running; no figure is asserted for it here.

---

## 5. D-2 — the decision required of the governance owner

**Question: does a CONDITIONAL Stage 3 / Stage 4 verdict permit entry to Stage 7?**

`PRD-006` holds ⚠️ **CONDITIONALLY ALIGNED** (Stage 3, 21/22) and ⚠️ **CONDITIONALLY PASSED** (Stage 4, 5/6). Every
previously frozen PRD reached Stage 7 on **A — PASS**. The question has therefore never been put.

**Four independent readings of existing governance say a CONDITIONAL verdict does *not* bar freeze:**

1. **The gates are defined by artefact and disposition, not by grade.** Stage 3's gate is *“a written alignment
   record naming every conflict and its disposition”*; Stage 4's is *“conflicts closed **or explicitly deferred
   with a reason and an owner**.”* Stage 4 contemplates deferral in terms. Neither gate mentions a verdict letter.
2. **Stage 7's own gate names no verdict.** It is *“a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned
   precedence rank.”*
3. **The baseline already carries unresolved contradictions inside frozen documents** — `GCP-05` inside Rank 3
   `PRD-003`, `GCP-06` inside the Rank 4 BC Map, both **OPEN**. A standard barring CONDITIONAL entry would be
   stricter than the one the baseline currently meets.
4. **`ADR-0020` §3 admitted `PRD-007` with fourteen gaps open**, under a heading that says so.

**The honest limit.** All four are *readings*. `PRD-007` was **A — PASS** at Stages 4, 5 and 6, so no precedent
exists for an explicitly CONDITIONAL verdict entering Stage 7. Bases 1–2 argue from silence: the gates do not
*require* a grade, but neither do they *state* that a CONDITIONAL one suffices.

**This is recorded as a supported reading and referred for confirmation. It is not asserted as settled.** Inferring
a governance rule from four silences and acting on it would be inventing governance — the thing this ADR exists to
avoid.

**D-2 is not a workaround for D-1.** Even confirmed in the affirmative, it does not close `ATT-GAP-017`, and the
`LIB-16.2` breach in §2.5 stands independently of it.

---

## 6. Options considered for this ADR itself

| Option | Rejected because |
|---|---|
| **Write a `Proposed` ADR that frames the decision and proposes no value** *(chosen)* | `PRD_LIFECYCLE.md` Stage 4 requires deferral *“with a reason and an owner”*, and `ADR-0013`/`ADR-0014` set the precedent for authoring at `Proposed`. It advances the blocker to the limit of what a reviewer may do |
| Choose the seven values and record the reasoning | Violates `ATT-BR-043` (*“no value **SHALL** be substituted”*), `PRD-006` §0.4, and `AR-4`'s finding on magic numbers. Resolves a blocker by breaking the specification it is meant to make freezable |
| Copy `CFG-*` / `ICFG-*` figures from Authentication or Library | `ATT-BR-043` names *“another product”* explicitly. §2.1's near-miss: it imports a security parameter across a bounded-context boundary while looking like a citation |
| Add the seven to `CONFIGURATION_GUIDE.md` | Rank 7 sets values *within* an envelope and *“cannot change the envelope.”* **All seven envelopes are themselves unresolved** (§2.3), so this requires inventing the range first |
| Downgrade `ATT-GAP-017` to non-blocking and freeze | It does not block because it is *open* — eighteen others are open. It blocks because it is a **live breach of Rank 3 `LIB-16.2`** which freeze would elevate to Rank 3 (§2.6) |
| Grant a time-boxed deviation from `LIB-16.2` and freeze | **A real governance route, deliberately not put forward here.** It changes the authority of Rank 3 `Library_PRD_v1.md`, so it belongs in an ADR against *that* document by *its* owner — not in a clause inside an attendance ADR. Named rather than omitted, so the owner knows it exists |
| Write the *admitting* ADR now and hold it `Proposed` | Would prejudge D-1 and D-2. An admitting ADR asserts the specification is fit for Rank 3, and that assertion is false while §2.5's breach stands |
| Wait for the owner and write nothing | Leaves the blocker unframed and the deferral unrecorded — the Stage 4 gate's own failure mode |

---

## 7. Consequences

### 7.1 While `Proposed`

- **Nothing changes.** No rank, no baseline, no status, no requirement, no value. `PRD-006` is byte-identical
  (`93ab1c60d740c4e0…`); `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md`, `Library_PRD_v1.md`
  and all twenty existing ADRs are unmodified.
- **`ATT-GAP-017` stays OPEN.** The seven have no defaults; `ATT-BR-043` continues to forbid substitution;
  `IMPL-667` stays ⛔ BLOCKED.
- **`PRD-006` remains ineligible for Stage 7**, and remains `PLANNED` in the register — itself a known defect,
  recorded at readiness review §7.1.
- **No baseline identifier is issued.** `BASELINE-2026-08-04-E` stands. A `Proposed` ADR is *“not binding”* and
  therefore not Rank 2; §7 step 4 triggers only when a Rank 1–3 document changes version, and none has.

### 7.2 Disclosed: `ADR-INDEX.md` is **not** updated, and is therefore stale in one field

`ADR-INDEX.md` reads **“Count | 20 accepted — `ADR-0001` … `ADR-0020` · **0 proposed**.”** With this file present,
*“0 proposed”* is inaccurate.

**It is left uncorrected deliberately**, for two reasons: indexing `ADR-0021` is item **B-4** on the readiness
review's forbidden list, and the index is the governance owner's register. When `ADR-0013` and `ADR-0014` were
`Proposed` they *were* indexed — so this is a **known, one-line divergence from convention**, disclosed here rather
than left to be discovered.

**Required of the governance owner on acceptance or rejection:** update the count field and add the `ADR-0021` row.
Until then the index undercounts by one proposed ADR.

### 7.2a Disclosed: one gate script was maintained, and the maintenance is recorded rather than performed silently

**Authoring this ADR broke a passing gate, and the break was caused by this ADR.**
`tool/docs_check/prd006_traceability.py` was at **exit 0** before it existed and went to **exit 1** the moment it
did, because its collision scan treats any `ATT-` token outside `attendance-management/` as a possible collision —
and an ADR *about* the attendance configurables cannot avoid naming them.

**The fix is the repository's existing convention, not a new exemption.** The `ALLOWED` list gained **one named
file** — this ADR. `prd005_traceability.py` already enumerates `ADR-0019` for `MM-*` and `prd007_traceability.py`
enumerates `ADR-0020` for `SEAT-*`, both on the recorded reasoning that *“a citation is not a collision — a
collision would be another register **defining** an identifier.”* **ADR-0021 defines none**: every `ATT-*` token in
it refers to a row defined in `PRD-006` §16.3.

Four things were deliberately **not** done:

- The list stays **enumerated file by file** rather than widened to `docs/00-governance/`. Verified by negative
  control: a probe file containing a stray `ATT-FR-999` elsewhere in `docs/00-governance/` still returns **exit 1**,
  and exit 0 returns only when the probe is removed.
- **`DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and `ADR-INDEX.md` were *not* added**, though the `PRD-005` and
  `PRD-007` precedents list all three. Those were *freezes*; this is not. None of the three has been modified, and
  pre-authorising an edit that has not been made would let a later change pass unnoticed.
- The duplicate-definition, registered-prefix and §2F count checks — the ones that detect a *genuine* collision —
  are **untouched**.
- `prd007_traceability.py` was **not** modified. It remains at its **pre-existing exit 1** with the **same two
  problem classes**; this ADR adds two lines to an already-failing list and defines **zero** `SEAT-*` identifiers.

Both `PRD-006` gates re-run at **exit 0** after the change.

### 7.3 On acceptance *(for the deciders' information — not authorised here)*

Acceptance of this ADR alone would still not freeze `PRD-006`. It would record the route chosen under D-1 and the
governance position under D-2. The sequence afterwards is: execute the chosen option → re-run Stages 4–6 as that
option requires → author the **separate** admitting ADR → write the baseline row. Four distinct acts, in that
order, per `DOCUMENTATION_BASELINE.md` §7.

### 7.4 Carried forward, untouched

`ATT-GAP-001`…`016`, `018`, `016a`, `017a` (eighteen, each with a named owner) · the `PRD_REGISTRY.md` L236
`PLANNED` defect · the `PRD-006` header contradiction (readiness review §7.2) · `GCP-05` · `GCP-06` · `GCP-09` ·
`BLK-01` / `TASK-D10` · the stale `IMPL-227+` allocation table in `PRD_LIFECYCLE.md`.

---

## 8. Compliance

| Requirement | Where satisfied |
|---|---|
| `DOCUMENTATION_BASELINE.md` §7 step 1 — an ADR **before** the change | This ADR is written while every ranked document stands untouched. No change has been made |
| §7 step 2 — version + changelog in the same commit | **Not triggered.** No ranked document's version changes |
| §7 step 3 — declaration updated in the same commit | **Not triggered.** The baseline is unmodified and unchanged |
| §7 step 4 — baseline id changes on a Rank 1–3 change | **Not triggered.** `BASELINE-2026-08-04-E` stands |
| `ADR-INDEX.md` Process step 1 — ADR before implementation | Followed. Nothing is implemented |
| `ADR-INDEX.md` Process step 2 — number sequentially, never reuse | `ADR-0021` is the next free number; `0001`–`0020` verified present |
| `ADR-INDEX.md` Process step 4 — record the ADR number in the commit | Done in the authoring commit |
| `PRD_LIFECYCLE.md` Stage 4 — deferral *“with a reason and an owner”* | §2 gives the reason; §4 and §5 name the owners |
| `PRD_LIFECYCLE.md` Stage 7 — a row in `DOCUMENTATION_BASELINE.md` §3 | **Not claimed.** No row is created; `PRD-006` is not frozen |
| `PRD_REGISTRY.md` §2.1 — status conferred, never self-declared | Nothing is conferred. `PRD-006` remains as the register records it |
| `ATT-BR-043` — no value substituted for an unresolved default | **Zero values proposed.** §3, §4, §6 |
| `PRD-006` §0.4 — no gap resolved by implementation choice | `ATT-GAP-017` remains OPEN and is explicitly not closed |
| `LIB-16.2` (Rank 3) | **Still breached**, and said so — §2.5. This ADR does not repair it and does not pretend to |
| `SID-4.56` — an unchecked rule is treated as unmet | §2.5 records the breach as live rather than mitigated away; §4.2 states what would close it |

---

## 9. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as **`Proposed`** — *“under consideration; not binding”* — following the `ADR-0013`/`ADR-0014` precedent for authoring an ADR at `Proposed` when the consequent change belongs to another owner. Frames the two decisions that block `PRD-006`'s Stage 7 entry and **makes neither**. **Proposes no numeric value for any of the seven `ATT-CFG-*` settings, and no allowed range** — the harder half, and the half that makes `CONFIGURATION_GUIDE.md` unavailable as a route, since Rank 7 sets values *within* an envelope and *“cannot change the envelope”* while all seven envelopes read *unresolved*. Records that the PRD's *“no Rank 1–5 source”* claim was **tested independently rather than accepted**, across four documentation trees and four concept families, returning **zero** authoritative values; and records the near-miss that the Authentication OTP-expiry figure would have *looked* like a source for `ATT-CFG-006` while importing a security parameter across a bounded-context boundary. Examines the three repository precedents that solved this problem before — `ACN-001`, `AR-4`, `DOCUMENTATION_AUDIT-001` — and finds they establish that a value may be **anchored**, not that a reviewer may perform the anchoring: in every case the anchor arrived from an external standard or from the product owner supplying new input, and **no new authority has arrived**. **D-1** puts four costed routes to the product owner — owner supplies values (`AR-4` pattern), commissioned anchored analysis (`DOCUMENTATION_AUDIT-001` pattern), PRD-envelope + Guide-value split (`ACN-001`/`ICFG-2` pattern), or descope the affected capabilities from V1 — each with who acts, what changes, cost, risk and effect on the breach, and states the mechanical consequence of any of the first three (Stage 4 check 3 **17/24 → 24/24**, breach closes, ledger **2/1/18 → 3/1/17**, `IMPL-667` unblocks, coverage unchanged at **285/285**). **D-2** puts to the governance owner whether a CONDITIONAL Stage 3/4 verdict permits Stage 7, setting out **four independent bases** that it does — the Stage 3/4 gates are defined by artefact and disposition rather than grade and Stage 4 admits deferral in terms; Stage 7's gate names no verdict; `GCP-05` and `GCP-06` are unresolved contradictions **inside frozen Rank 3 and Rank 4 documents**; and `ADR-0020` admitted `PRD-007` with fourteen gaps open — while recording the **honest limit** that all four are readings, that bases 1–2 argue from silence, and that no precedent exists because every earlier freeze was **A — PASS**; referred for confirmation rather than asserted, and noted as **not a workaround for D-1**. Isolates **why this gap blocks when eighteen others do not**: not because it is open, but because it is a **live breach of Rank 3 `LIB-16.2`** that freeze would confer Rank 3 upon — measured as **the first such breach in any frozen PRD** (`live breach` occurrences: 0 in each of `PRD-007`, `PRD-005`, `PRD-004` and the Library PRD; **1** in `PRD-006`) — and records that `ATT-BR-044` satisfies `LIB-16.2`'s *second* sentence in fact, making the breach **latent but not absent**, while the unqualified first sentence remains breached. §6 names the *“time-boxed deviation from `LIB-16.2`”* route as **real and deliberately not put forward**, because it changes the authority of Rank 3 `Library_PRD_v1.md` and belongs in an ADR against that document by its owner. §7.2a discloses that **authoring this ADR broke a passing gate and that the break was caused by this ADR** — `prd006_traceability.py` went exit 0 → exit 1 because its collision scan cannot distinguish an ADR *citing* the attendance configurables from a register *defining* them — and records the fix as the repository's **existing** convention rather than a new exemption: the `ALLOWED` list gained **one named file**, matching `prd005_traceability.py`'s listing of `ADR-0019` and `prd007_traceability.py`'s of `ADR-0020` on the recorded reasoning that *“a citation is not a collision”*; **`DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and `ADR-INDEX.md` were deliberately *not* added** despite both precedents listing them, because those were freezes and this is not, and pre-authorising an unmade edit would let a later change pass unnoticed; the list stays enumerated file by file, **verified by negative control** (a stray `ATT-FR-999` probe elsewhere in `docs/00-governance/` still returns exit 1); the duplicate-definition, registered-prefix and §2F count checks are untouched; and `prd007_traceability.py` was not modified, remaining at its pre-existing exit 1 with the same two problem classes. §7.2 discloses that **`ADR-INDEX.md` is deliberately not updated** and that its *“0 proposed”* count is consequently stale by one, this being forbidden item **B-4** and the governance owner's register. **No baseline identifier issued** — `BASELINE-2026-08-04-E` stands, since a `Proposed` ADR is not binding and therefore not Rank 2, and no Rank 1–3 document changed version. **Nothing frozen, no baseline row, no value invented, no range invented, no gap closed, no verdict re-graded, `PRD-006` byte-identical, and no frozen, ranked or authoritative document modified.** |
