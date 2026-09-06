# `PRD-010` Notifications & Communication — Stage 4 Requirements Review: **CONFERRAL**

| Field | Value |
|---|---|
| Document | `PRD-010_STAGE4_CONFERRAL.md` |
| Act | ⚖️ **CONFERRAL** — this document performs a governance act. It is **not** a measurement. |
| Conferred by | **Requirements Reviewer**, exercised by **direct, explicit and unconditional conferral of the human principal of this engagement** |
| Instruction (verbatim) | *"I am exercising the authorized Requirements Reviewer role for this specific act. Formally review PRD-010 v0.13 and, if the independently re-measured evidence satisfies `PRD_LIFECYCLE.md`, confer Stage 4."* |
| Authority basis | That instruction **is** the authority, and it is **the only authority claimed**. Same form as `ADR-0033` §7.2, `ADR-0034` §7.2 and `PRD-008_STAGE4_CONFERRAL.md`. |
| Scope | **This specific act only.** Not a standing licence for unrelated acts — `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."* ⛔ It confers **no** Stage 5, 6 or 7 authority. |
| Subject | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` — reviewed at **v0.13**, sha256 `02045de9dc97d5e6`, 1,223 lines; **conferred at v0.14**, sha256 `63326045fefe8328`, 1,224 lines (six reviewer-found defects repaired mid-review — §3) |
| Evidence reviewed | The subject's own bytes; `PRD-010_STAGE4_REQUIREMENTS_REVIEW.md`; `ADR-0107`, `ADR-0108`, `ADR-0109`, `ADR-0110`; `tool/docs_check/prd010_traceability.py` |
| Gate applied | `PRD_LIFECYCLE.md` **L110-119** — six checks, plus **L119**: *"conflicts closed or explicitly deferred **with a reason and an owner**."* |
| Status of this record | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md`. Admission is the Governance Owner's act, not this one. |
| Date | 2026-09-05 |
| **Verdict** | ✅ **STAGE 4 REQUIREMENTS REVIEW PASSED — C1–C6 plus the gate, zero failures. CONFERRED.** |

---

## 1. The four acts required of the Requirements Reviewer

| # | Required act | Performed | Outcome |
|---|---|---|---|
| 1 | Re-measure independently, or adopt the prior measurement | ⭐ **Re-measured independently against the v0.13 bytes.** The prior pass's gate matrix was **not** adopted | **6 defects found** (§3) |
| 2 | Adjudicate any finding the record left open | Performed | 2 stale rows, 3 pointer rows, 1 non-impossibility exclusion — all repaired |
| 3 | Confirm no requirement was created to reach the verdict | Recounted from source | **67 → 67** FR. **0** identifiers minted (§4) |
| 4 | Confer Stage 4, or withhold it | — | **CONFERRED** (§6) |

> **A reviewer who adopts the measurement of the document under review has reviewed nothing.** Act 1 was
> therefore performed by re-measurement — and it is the reason this conferral is not a rubber stamp: the
> independent pass **failed** the document on first measurement.

---

## 2. The six checks, re-measured against `PRD-010` v0.14

`PRD_LIFECYCLE.md` **L110-117** states six checks; **L119** states the gate.

| # | Check (verbatim) | Measured | Verdict |
|---|---|---|---|
| **C1** | *"Every requirement testable"* — failure mode *"The system should be fast"* | **77** obligation rows (FR/BR/INV, 3-column register form). **0** carry `**[OPEN]**`. **0** vague terms (`should be fast`, `as fast as possible`, `user-friendly`, `reasonably quick`). **0** lack a normative verb or a testable prohibition | ✅ |
| **C2** | *"Every exclusion states what must be **impossible**"* — *"an exclusion is not a deferral"* | **8** `NTF-XC-*` rows; **7** state **MUST NOT**, `NTF-XC-006` states **MUST** (*"Push egress MUST traverse `BC-31`"* — an impossibility expressed positively). **8 of 8** state an impossibility after `NTF-XC-004`'s repair | ✅ |
| **C3** | *"Every configurable has a default and a range"* — *"unbounded configuration is a specification hole"* | **4** in-scope configurables, all complete: `NTF-CFG-001` (200, 1–500) · `NTF-CFG-002` (`en`, Supported set — cited from `LCFG-2`) · `NTF-CFG-003` ({mandatory, optional} + all 13 per-entry defaults) · `NTF-CFG-004` (3, 1–5, total attempts incl. first). **3** declared slots are **not** configurables and are out of scope: `-005`, `-006`, `-007` (`ADR-0108`, `ADR-0109`) | ✅ |
| **C4** | *"Every acceptance criterion maps to a requirement"* — *"orphan criterion"* | **13** `NTF-AC-*` rows; **13** carry a `Verifies` cell; **0** orphans | ✅ |
| **C5** | *"No requirement restates another PRD's"* — *"two sources of truth"* | Every cross-context row constrains **`BC-22`'s own conduct**; `NTF-CFG-002` **consumes** `LCFG-2` rather than copying it; `NTF-FR-054` cites `FIL-XC-009` and defers resolution to `BC-25` | ✅ |
| **C6** | *"Business rules do not contradict Rank 1"* — *"Rank 1 wins; the PRD is wrong"* | V1 channels = In-App + Push only (`MP-SCOPE-09`); `MP-GBR-21` (tenant isolation), `MP-GBR-33`/`-34` (no number in events), `MP-GBR-35` (`BC-22` owns quiet hours/dedup/consent) all upheld, none narrowed | ✅ |

### The gate — `PRD_LIFECYCLE.md` **L119**

> *"conflicts closed or explicitly deferred **with a reason and an owner**."*

✅ **SATISFIED.** Every unresolved item carries both. The **six** open items, each with a reason and a named owner:

| Item | Reason it is open | Owner |
|---|---|---|
| `NTF-GAP-017` | FCM's device-receipt implication is a vendor fact absent from this repository (the `ADR-0045` condition) | **`[OWED — EXTERNAL EVIDENCE]`** |
| `NTF-GAP-028` / `NTF-OBD-001` | Numerical `FeedItem` lifetime bounds; `BCM-22-INV-1` fixes durability, not lifetime | **Architecture Owner** |
| `NTF-GAP-029` / `NTF-RTD-001` | `await work()` unbounded; also the unenforced transient/permanent split | **Architecture Owner** + Implementation lead |
| `NTF-GAP-003` | Reminder timing is product policy with no repository anchor | **Product Owner** |
| `NTF-GAP-010` | V2 two-way surface scope | **Product Owner** |
| `NTF-GAP-020` | SLO **target**; `SRE-GAP-001` OPEN, `ADR-0033` §7.1 bars reusing `ADR-0102` | **SRE / Observability** |
| `NTF-GAP-019` | Platform- vs tenant-level key resolution is `BC-25`'s | **`BC-25` / `PRD-023`** |

⭐ **None is a *conflict*; each is a deferral with a reason and an owner** — which is precisely what L119 permits. A deferral is not a failure of the gate; an *undocumented* deferral would be.

---

## 3. ⭐⭐ Six defects found by this review, and repaired before conferral

**The document did not pass on first measurement.** Recorded because a review that finds nothing is
indistinguishable from a review that was not performed.

| # | Defect | Row | Why it failed | Repair |
|---|---|---|---|---|
| 1 | **Stale text contradicting a closure the document had itself made** | `NTF-FR-017` | Read *"no number is proposed"* although `NTF-GAP-007` is **CLOSED** — ceiling ratified (`ADR-0108` §7.1), rate limb withdrawn (`ADR-0110` §2) | Now states the ceiling obligation and cites `NTF-XC-008` |
| 2 | **Stale text, same class** | `NTF-FR-040` | Read *"no classification asserted"* although §20.6 classifies **all 13** entries (`ADR-0109` §5) | Now requires a class from the closed set and forbids dispatch without one |
| 3 | **Pointer, not an obligation** | `NTF-FR-049` | Described what had been decided elsewhere; stated no MUST | Now: bounded by `NTF-CFG-004`; `BC-22` MUST NOT schedule; no V1 backoff |
| 4 | **Pointer, not an obligation** | `NTF-FR-054` | Stated only that ownership was contested | Now: MUST resolve through `BC-25`, MUST NOT define resolution order — `[DERIVED]` from FROZEN `FIL-XC-009` + `ADR-0017` §2.5 |
| 5 | **Non-normative form** | `NTF-FR-047` | *"Only transient failures retry"* — descriptive | Now MUST/MUST-terminate, **with the runtime shortfall disclosed** (`services.dart` **L215** does not distinguish the two) |
| 6 | **Exclusion stating scope, not impossibility** | `NTF-XC-004` | Failed C2 on its own terms — *"an exclusion is not a deferral"* | Now: MUST NOT consume over any edge but `E-23`; MUST NOT create or assume a new edge |

⛔ **What the repairs did NOT do:** no requirement added, retired or renumbered · **0** identifiers minted ·
**0** numbers introduced · **0** gaps closed · no obligation weakened to reach a pass. Each repair either
states an existing obligation precisely or corrects text the document had already superseded.

⚠ **Defect 5's disclosure is deliberately retained in the requirement text.** `NTF-FR-047` is now testable,
but the V1 adapter does not yet enforce it. Making the requirement normative **without** recording that
would have produced a specification the runtime silently violates.

---

## 4. Nothing was created to reach this verdict

| Register | Before review | At conferral | Δ |
|---|---|---|---|
| `NTF-FR-*` | 67 | **67** | 0 |
| `NTF-BR-*` | 3 | **3** | 0 |
| `NTF-INV-*` | 11 | **11** | 0 |
| `NTF-XC-*` | 8 | **8** | 0 |
| `NTF-AC-*` | 13 | **13** | 0 |
| `NTF-GAP-*` | 29 | **29** | 0 |
| `NTF-CFG-*` declared | 7 | **7** | 0 |

**Mechanical verification:** `tool/docs_check/prd010_traceability.py` → **exit 0** — all seven registers
contiguous from 1 to maximum, every self-stated count matching measurement, **zero** cross-PRD collisions.

---

## 5. Governance constraints verified before conferring

| Constraint | Verified |
|---|---|
| No frozen PRD modified | ✅ `PRD-005`, `PRD-007`, `PRD-016`, `PRD-017`, `PRD-019`, `PRD-021B`, Authentication, Library — **byte-unchanged**; `PRD-016`/`PRD-017`/`PRD-019` **cited as authority** |
| No Rank-1 document modified | ✅ `MASTER_PRD.md` byte-unchanged |
| No Rank-4 document modified | ✅ BC Map byte-unchanged by this phase; **§8 and §18 both intact** |
| `ADR-0107`/`0108`/`0109`/`0110` preserved | ✅ Not reopened, amended or superseded |
| `BC-22` two-root architecture preserved | ✅ `FeedItem` · `DeliveryMessage` unchanged |
| No checker weakened | ✅ `prd010_traceability.py` and `prd010_stage5.py` **byte-unchanged**; the six defects were fixed in the **artefact** |
| No manifest, code or test changed | ✅ **0** `.dart` files; `tool/module_dependencies.yaml` untouched |
| Working tree | ✅ clean; `git diff --check` clean |
| Only in-scope files changed | ✅ **1** file in this phase: the subject PRD |

---

## 6. Conferral

> ⚖️ **Stage 4 — Requirements Review — is CONFERRED for `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` v0.14**
> (sha256 `63326045fefe8328`), on the measurement in §2: **all six `PRD_LIFECYCLE.md` L110-117 checks PASS**,
> and the **L119 gate is SATISFIED** — every unresolved item is explicitly deferred with a reason and a named
> owner.

### What this conferral does NOT do

- ⛔ It does **not** close `NTF-GAP-017`, `-028`, `-029`, `-003`, `-010`, `-019` or `-020`. All remain **OPEN**, owners unchanged.
- ⛔ It does **not** rank, baseline or freeze `PRD-010`. Status stays **`DRAFT`**; `PRD_REGISTRY.md` stays **`PLANNED`**; `DOCUMENTATION_BASELINE.md` holds **0** `PRD-010` rows.
- ⛔ It does **not** confer Stage 5, 6 or 7. Stage 5 is the **Traceability Owner**'s (`PRD_LIFECYCLE.md` **L279**); Stage 6 the **Implementation lead**'s (**L280**); Stage 7 the **Governance Owner**'s (**L281**).
- ⛔ It does **not** validate the V1 implementation. `NTF-GAP-029` records two obligations the runtime does not yet enforce.
- ⚠ It does **not** discharge `NTF-CFG-004`'s **suspensive condition** (`ADR-0108` §3.1): if a `NTF-CFG-007` value is later ratified shorter than 3 × the per-attempt bound, the budget **must** be re-ratified downward. **That condition survives this conferral.**

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | Created. **Stage 4 CONFERRED** for `PRD-010` v0.14 by the Requirements Reviewer, on direct, explicit and unconditional conferral of the human principal, quoted verbatim in the header. ⭐⭐ **The review was performed by independent re-measurement against the subject's bytes, and the subject FAILED on first measurement** — **six defects** were found and repaired before conferral: two rows carrying **stale text that contradicted closures the document had itself already made** (`NTF-FR-017`, `NTF-FR-040`), three **pointer rows stating no obligation** (`NTF-FR-049`, `NTF-FR-054`, `NTF-FR-047`), and one **exclusion stating scope rather than impossibility** (`NTF-XC-004`, failing C2 on its own terms). ⛔ **0 requirements created, retired or renumbered; 0 identifiers minted; 0 numbers introduced; 0 gaps closed; no obligation weakened** — verified by recount (67/3/11/8/13/29/7 unchanged) and by `prd010_traceability.py` **exit 0**. ⚠ **`NTF-FR-047`'s runtime shortfall is retained in the requirement text rather than hidden**, since making it normative without disclosure would specify behaviour the V1 adapter silently violates. **Six deferrals verified to carry a reason and a named owner** per **L119**. ⛔ **No stage beyond 4 conferred · nothing ranked, baselined or frozen · registry stays `PLANNED` · `ADR-0107`/`0108`/`0109`/`0110` preserved · BC Map §8 and §18 intact · 0 frozen PRDs · 0 Rank-1 changes · 0 code · no checker weakened.** |
