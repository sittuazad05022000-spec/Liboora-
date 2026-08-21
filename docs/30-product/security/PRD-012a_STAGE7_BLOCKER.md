# `PRD-012a` Stage 7 — Freeze Blocker Record

| Field | Value |
|---|---|
| **Act** | 🛑 **BLOCKER RECORD** — this document performs no governance act. It records why Stage 7 was **not** completed, so that the stop is auditable rather than silent |
| **Type** | Review record. **Not a freeze**, not a baseline row, not an ADR, not part of any specification |
| **Subject** | `PRD-012a` Parts 1–8, v0.1–v0.8 `DRAFT` |
| **Part 1 hash** | `dbd01d4d00165c774024d62a9e4a18099cf4272402581a8febcf244ab582d452` — **unchanged** |
| **Part 8 hash** | `a8c45d79eb8154f766e1fe1006031ea6baacdd99439fc0cfca2d1f504e7c7977` — **unchanged** |
| **Stage reached** | **6 of 9.** Stages 2, 3, 4, 5 and 6 completed this pass; **Stage 7 not completed** |
| **Governing gate** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §Stage 7, L155–180 |
| **Stage 7 owner** | **Governance owner** — `PRD_LIFECYCLE.md` §6 **L282** (*"Stage 7; the baseline"*) |
| **Verdict** | ⛔ **BLOCKED — Stage 7's gate is not satisfied** |
| **Files modified to produce this record** | **None.** This file is the only artefact |
| **Authority** | **None.** This document confers no status, ranks nothing and admits nothing to any baseline |
| **Status of this record** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-21 |

---

## 1. Verdict

⛔ **BLOCKED.**

Stage 7's gate is one sentence, quoted verbatim from `PRD_LIFECYCLE.md` L159:

> **Gate:** a row in [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3 at an
> assigned precedence rank.

**That row does not exist.**

```
grep -n "PRD-012a\|012a" docs/00-governance/DOCUMENTATION_BASELINE.md    → 0 lines
grep -ciE 'SECURITY platform|platform/security' docs/00-governance/DOCUMENTATION_BASELINE.md → 0
```

The gate is unsatisfied **as a matter of fact, not of judgement**. Stage 7 is therefore not passed, and this record
exists instead of a freeze record.

### 1.1 Why this is a stop rather than an act

The standing instruction was to take `PRD-012a` *"through the repository's lifecycle from Stage 2 through Stage 7"*, and
it was explicit about what to do at exactly this point:

> *"Only proceed if every mandatory Stage 7 gate is legitimately satisfied… **If any mandatory gate is not satisfied,
> STOP and report the blocker instead of falsely declaring FROZEN.**"*

and

> *"Do not claim CONFERRAL yourself unless the repository explicitly permits the current actor to confer it. If Product
> Owner / Architecture Owner / Governance Owner approval is required, **record it as pending rather than fabricating
> approval**."*

The repository says the same thing in its own words. `PRD_LIFECYCLE.md` Stage 7 calls itself *"the gate that matters
most, because it changes what everyone else may do,"* and states the rule this record obeys:

> **"Freeze is conferred, not claimed."**

`PRD_REGISTRY.md` **L57** repeats it from the register's side: *"Freeze is therefore **not self-declared**. It is
conferred externally by admission to the baseline."*

**Verified — nothing in `PRD-012a` claims otherwise.** `FROZEN` appears 21 times across the twelve
`PRD-012a` files, and **every occurrence is a citation of another document's status** — `PRD-001`, `PRD-013`, `PRD-016`,
`PRD-017`. All eight Parts carry `Status: DRAFT`, and six carry the sentence *"This document confers no status on
itself."* The document has not drifted toward claiming its own freeze, and this record does not move it there.

---

## 2. The four blockers

| # | Blocker | Type | Owner | Can this pass cure it? |
|---|---|---|---|---|
| **`B7-1`** | **No row for `PRD-012a` exists in `DOCUMENTATION_BASELINE.md` §3.** This *is* the gate | **Factual** — measured, 0 occurrences | **Governance owner** (§6 L282) | ⛔ No. Creating the row would be claiming the freeze the row confers |
| **`B7-2`** | **Admitting the row is itself a change to a Rank 1 document, and baseline §7 rule 1 requires an ADR *before* the change.** No such ADR exists — `ADR-0059` is the highest on disk, `ADR-0060` is free and **not taken here** | **Procedural prerequisite** | **Governance owner**, via an admission ADR | ⛔ No. Writing the ADR would be authoring my own authorisation |
| **`B7-3`** | **Stage 1's gate was never met.** `PRD-012a` holds no `BC-nn`; the Bounded Context Map has **87** rows and none is a security context. `SECP-GAP-041` is open and routed to `SECP-ADR-001` | **Prior-stage gate** | **Architecture owner** | ⛔ No. Creating a context by implementation choice would answer an Architecture Owner's open question |
| **`B7-4`** | **Three cross-authority conflicts remain unresolved**, each routed at Stage 3 and re-confirmed at Stage 4 — `SECP-GAP-023` (Rank 1 `MP-RSK-01` vs Rank 6 EA-V2), `SECP-GAP-031` (Rank 3 `FROZEN` `AUTH-11.26`–`11.28` vs Rank 6 EA-V2), `SECP-GAP-042` (no `platform/security` block under `default_decision: deny`). All five `SECP-ADR-001`…`005` remain **requests** | **Substantive** | **Architecture owner**; `BC-18` owner for `SECP-DEP-002` | ⛔ No. `DOCUMENTATION_BASELINE.md` **L253**: *"**A conflict is a defect.** If you find one, do not choose — raise it"* |

**All four are external. None is a defect in `PRD-012a`.** Stages 2, 3, 4, 5 and 6 all passed on their own gates; the
subject is not blocked for want of quality or completeness.

### 2.1 What `B7-2` means concretely

Every prior freeze in this repository was executed the same way, and the pattern is unambiguous. `ADR-0054`, the most
recent, records its own decider as:

> *"**Governance owner** (Stage 7 and the baseline, `PRD_LIFECYCLE.md` §6 L282) — **exercised by direct conferral of the
> human principal of this engagement**"*

The five predecessors — `ADR-0050` (`PRD-013`), `ADR-0051` (`PRD-016`), `ADR-0052` (`PRD-014`), `ADR-0053` (`PRD-023`),
`ADR-0054`/`0056` (`PRD-017`) — each did the same: an accepted ADR admitted the document to a rank, and the baseline row
followed from the ADR.

**The conferral this pass received was for Stage 6.** The Stage 6 gate record §0 states its scope and cites
`ADR-0033` §7.1 — *"A conferral for one act is not a standing licence."* Extending a Stage 6 conferral to cover Stage 7
would be precisely the fabrication the instruction forbade.

---

## 3. What was deliberately NOT done

| Not done | Why |
|---|---|
| A row added to `DOCUMENTATION_BASELINE.md` §3 | That row *is* the gate. Writing it would manufacture the evidence of its own passing |
| `ADR-0060` written, numbered or accepted | An ADR admitting this document would be authored by the party seeking admission |
| `PRD_REGISTRY.md` §4.1 L260 changed from `PLANNED` | Registry §8 rule 4: `FROZEN` only when the document appears in baseline §3 at Rank 1–5. It does not |
| The string `FROZEN` written as `PRD-012a`'s status anywhere | Verified: **0** occurrences as a self-status across all twelve files |
| A precedence rank assigned | Rank assignment is a baseline act |
| The baseline identifier advanced past `BASELINE-2026-08-20-C` | §7 rule 4 — only a Rank 1–3 version change triggers it, and no such change occurred |
| Any `SECP-GAP-*` closed, `SECP-DEP-*` met or conflict resolved | Stage 3 routed them; Stage 7 does not decide them |
| Any PRD Part edited | Both hashes unchanged. A freeze-readiness review may not improve its subject to make it passable |
| A "conditional" or "provisional" freeze declared | The status vocabulary in `PRD_REGISTRY.md` §2 is a **closed set** of nine. None of them is conditional |

---

## 4. One inference this record refuses to draw

**A near-miss worth recording, because the repository has already been burned by it.**

All **51** Rank 3 product rows in baseline §3.3 are scoped to a bounded context or a named domain. `PRD-012a` is scoped
to the **SECURITY platform (rank 2)** — a platform composition, not a context. It is tempting to conclude: *no
platform-scoped document has ever held a precedence rank, therefore none may.*

**That inference is refused.** It is the exact error `ADR-0050` §5 **withdrew** when it superseded
`PRD-013_STAGE7_BLOCKER.md`:

> *"Blocker 1 reasoned from a correctly **measured** fact — that **0** documents at a `v0.x` version had ever been
> admitted to the baseline — and treated that absence as a **prohibition**. It is history, not a rule."*
> *"**No such rule exists to be breached.**"*

So the question was tested affirmatively rather than assumed:

```
grep -rniE "may be admitted|admission to the baseline|eligib|only bounded context|must own a bounded context" \
    docs/00-governance/
→ no admission-eligibility rule found
```

**There is no rule requiring a baselined document to own a bounded context.** The 51-of-51 observation is therefore
recorded as **context for the Governance Owner's decision, not as a bar to it**. Whether a platform-composition PRD may
hold a precedence rank is an open question for `SECP-ADR-001`, and this record does not pre-empt the answer in either
direction.

The same restraint applies to `B7-3`. Stage 1's gate is unmet — that is a measured fact. Whether the lifecycle *exempts*
platform-composition PRDs from needing a context is **also** `SECP-ADR-001`'s question; Part 8 notes the lifecycle's own
observation that *"four of the nineteen Master PRD modules are compositions, not contexts,"* which **suggests** an
exemption but does not constitute one.

---

## 5. What would unblock Stage 7

Stated as a sequence, in the order baseline §7 requires, and **without claiming any step is trivial**:

1. **Architecture Owner decides `SECP-ADR-001`** — does the SECURITY platform receive a `BC-nn`, or does the lifecycle
   record an exemption for platform compositions? This closes `SECP-GAP-041` and settles `B7-3`.
2. **Architecture Owner decides `SECP-ADR-004` / `SECP-DEP-003`** — declare `platform/security`'s outbound ports in
   `tool/module_dependencies.yaml`. This closes `SECP-GAP-042`, settles part of `B7-4`, and unblocks 8 of the 60 Stage 6
   tasks.
3. **Architecture Owner decides `SECP-ADR-002`** and **`BC-18` owner decides `SECP-ADR-003`** — the two remaining
   cross-rank conflicts, `SECP-GAP-031` and `SECP-GAP-043`.
4. **Governance Owner writes and accepts an admission ADR** — `ADR-0060` if still free — assigning a precedence rank,
   on the `ADR-0050`…`ADR-0054` pattern. This satisfies `B7-2`.
5. **The baseline row is added** under that ADR, the baseline identifier advanced per §7 rule 4, and the changelog
   updated in the same commit per §7 rule 2. This satisfies `B7-1`.
6. **`PRD_REGISTRY.md` §4.1 is updated** `PLANNED` → `FROZEN` in the same commit, per registry §8 rule 3.

⚠ **Step 4 cannot be performed by the party seeking admission, and steps 1–3 belong to a different owner entirely.**
That is the whole content of this blocker.

---

## 6. What is *not* blocked

To be clear about what this stop does and does not mean:

| Stage | State |
|---|---|
| Stage 2 Draft | ✅ **PASS** — 427 identifiers, 15 registers, all contiguous, 0 phantoms |
| Stage 3 Architecture Review | ⚠ **ALIGNED WITH ONE STRUCTURAL FINDING** — 5 PASS + 1 PASS-with-finding, 3 accepted / 4 rejected, **3 conflicts routed, 0 resolved** |
| Stage 4 Requirements Review | ✅ **PASS 6/6** — 0C/0H/0M/2 LOW, 3 deferrals each with a named owner |
| Stage 5 Traceability | ✅ **REGISTERED** — `TRACEABILITY_MATRIX.md` v1.18 §2N, collisions checked in four directions, 0 |
| Stage 6 Implementation Tasks | ✅ **PASS** — `IMPL-1300`…`IMPL-1359`, 60 tasks, 146/146 obligations, 128/128 AC mapped |
| **Stage 7 Freeze** | ⛔ **BLOCKED** — this record |
| Stage 8 Implementation | Not started. 0 lines under `lib/` touched |
| Stage 9 Verification | Not started. **0 of 128** acceptance criteria proven |

**`PRD-012a` remains `DRAFT`, and the registry remains `PLANNED`.** Both are the correct statuses for a document at
Stage 6, and neither was written by this pass.

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created. Records that **Stage 7 is BLOCKED** for `PRD-012a` and why, so the stop is auditable. The gate — *"a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank"* — is **unsatisfied as a measured fact**: the baseline contains **0** occurrences of `PRD-012a` and **0** of `SECURITY platform`/`platform/security`. Four blockers recorded, **all external, none a defect in the subject**: `B7-1` the absent baseline row (the gate itself); `B7-2` the absent admission ADR, since baseline §7 rule 1 requires an ADR *before* a Rank 1 change and `ADR-0059` is the highest on disk with `ADR-0060` free and **deliberately not taken**; `B7-3` Stage 1's unmet gate (`SECP-GAP-041`, 87 BC Map rows, no security context); `B7-4` three unresolved cross-authority conflicts and five `SECP-ADR-*` still *requests*. **§4 explicitly REFUSES the inference that 51-of-51 context-scoped Rank 3 rows prohibit a platform-scoped one** — that is the reasoning `ADR-0050` §5 withdrew as *"history, not a rule"* when it superseded `PRD-013_STAGE7_BLOCKER.md`; a governance-wide probe for an admission-eligibility rule **found none**, so the observation is recorded as context for the Governance Owner, not as a bar. **Nothing was created, changed or claimed**: no baseline row, no ADR, no rank, no registry write, no `FROZEN` status, no gap closed, no conflict resolved, no conditional freeze, no PRD Part edited. Verified that all 21 `FROZEN` occurrences across the twelve `PRD-012a` files are **citations of other documents' statuses**, and that all eight Parts still read `DRAFT`. **Files modified to produce this record: none — this file is the only artefact.** |
