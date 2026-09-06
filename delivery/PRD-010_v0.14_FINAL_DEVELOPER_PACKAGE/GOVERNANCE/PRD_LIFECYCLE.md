# LIBOORA — PRD Lifecycle

| Field | Value |
|---|---|
| **Document** | PRD Lifecycle — the stages every PRD passes through, and the gate between each |
| **Version** | v1.0 |
| **Status** | Active — binding process for new and amended PRDs |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Authority** | **Process, not product.** This document governs *how* a PRD moves between states. It never governs *what* a PRD says |
| **Companion** | [`PRD_REGISTRY.md`](./PRD_REGISTRY.md) §2 — the status vocabulary this lifecycle drives |

---

## 1. Why this document exists

Three PRDs reached the baseline by three different routes. Authentication v2.0 was **authored** after the v1.0
chapters turned out to be empty. The Library PRD was **received verbatim** from the product owner and reviewed
without editing a word. The Student Identity PRD was **reconciled** against an ADR that changed its architecture
mid-review.

All three arrived in good order. None followed a written process, because there was not one — and eighteen more
PRDs are still to be written.

This document records the route, so the next eighteen do not each invent their own.

> **What this does not do.** It does not add ceremony to work already done. `PRD-000`…`PRD-003` are frozen and
> **are not re-run through these stages**. §9 states how they map.

---

## 2. The nine stages

```
  Discovery ──► Draft ──► Architecture ──► Requirements ──► Traceability
                            Review           Review              │
                                                                 ▼
   Verification ◄── Implementation ◄── Freeze ◄── Implementation Tasks
```

Each transition has a **gate**: a named artefact that must exist. A gate is not an opinion — if the artefact does
not exist, the stage has not been passed, however complete the work feels.

| # | Stage | Registry status | Exit gate |
|---|---|---|---|
| 1 | Discovery | `DISCOVERY` | Bounded context identified and **unowned** by any other PRD |
| 2 | Draft | `DRAFT` | Document on disk, versioned header, identifier registers declared |
| 3 | Architecture Review | `IN_REVIEW` | Every boundary, edge and rank validated against the BC Map |
| 4 | Requirements Review | `IN_REVIEW` | Every requirement uniquely identified, testable, non-duplicating |
| 5 | Traceability | `APPROVED` | Prefixes registered in `TRACEABILITY_MATRIX.md`; zero collisions |
| 6 | Implementation Tasks | `APPROVED` | `IMPL-*` range allocated; every task traces to requirements |
| 7 | **Freeze** | **`FROZEN`** | Row in `DOCUMENTATION_BASELINE.md` §3 at a precedence rank |
| 8 | Implementation | `IMPLEMENTING` → `IMPLEMENTED` | All tasks closed |
| 9 | Verification | `VERIFIED` | Every acceptance criterion proven by a test or recorded procedure |

---

## 3. Stage detail

### Stage 1 — Discovery

**Purpose:** decide whether a PRD is warranted at all.

| Question | Fails if |
|---|---|
| Does a bounded context own this? | It is a presentation composition — dashboards, Parent Portal. **No PRD** |
| Does another PRD already own the context? | It is an amendment to that PRD, not a new one |
| Is it V1/V2/V3, or Future? | Future ⇒ **stop**. EA §10.3: *"do not design for it now, only avoid blocking it"* |
| Does it own an aggregate and an invariant? | Owning neither ⇒ it is a capability of an existing context |

**Gate:** a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6.

> **The commonest wrong outcome is a PRD that should not exist.** Four of the nineteen Master PRD modules are
> compositions, not contexts. Discovery exists to catch that before anyone writes 300 requirements behind a
> screen that owns no state.

### Stage 2 — Draft

**Gate:** a document with a version/status header, and its identifier registers declared **up front** with
ranges — as `Student_Identity_PRD_v1.md` §0 does, publishing *"the ranges as a promise"*.

Rules:
1. **Every requirement has a unique identifier.** No exceptions.
2. Prefixes are chosen against §5's collision procedure **before** writing.
3. Ranges are contiguous. A gap makes the published range false.
4. Normative language (**MUST**/**SHOULD**/**MAY**) is defined in the document.

### Stage 3 — Architecture Review

Validates the PRD against Ranks 1–5, in this order:

| Check | Authority | Failure |
|---|---|---|
| Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate |
| Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR |
| Rank direction is downward | Dependency Matrix `L2` | Illegal import |
| No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** |
| No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited |
| Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, Critical |

**Gate:** a written alignment record naming every conflict and its disposition —
`LIBRARY_PRD_ALIGNMENT.md` and `STUDENT_IDENTITY_ALIGNMENT.md` are the worked examples.

> **A rejected finding must be recorded as rejected, with its reason.** The Student Identity review accepted 11
> of 13 and rejected 2, preserving the draft's intent deliberately. A review that records only accepted findings
> is indistinguishable from a review that found nothing.

### Stage 4 — Requirements Review

| Check | Failure |
|---|---|
| Every requirement testable | *"The system should be fast"* — unverifiable |
| Every exclusion states what must be **impossible** | An exclusion is not a deferral |
| Every configurable has a default and a range | Unbounded configuration is a specification hole |
| Every acceptance criterion maps to a requirement | Orphan criterion |
| No requirement restates another PRD's | Two sources of truth |
| Business rules do not contradict Rank 1 | Rank 1 wins; the PRD is wrong |

**Gate:** conflicts closed or explicitly deferred **with a reason and an owner**.

### Stage 5 — Traceability

**Gate:** the PRD's prefixes registered in [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md)
§2 with counts and ranges, verified mechanically, **zero collisions**.

Mechanical means counted by a tool, not by reading. §2B records nine registers verified *"contiguous from 1 to
its stated maximum"*.

> **The near-miss worth knowing about.** `PO-1`…`PO-12` are protected operations behind the **public library
> preview** — an anonymous read surface. `SPO-1`…`SPO-9` are protected operations on a **Global Person Identity**
> — authenticated writes. Two candidate prefixes were changed during authoring to prevent collisions, and the
> matrix notes that citing `PO-3` when `SPO-3` was meant *"would move a requirement from one bounded context to
> another."* This stage exists for that class of error, which no amount of careful reading reliably catches.

### Stage 6 — Implementation Tasks

**Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Allocation rules:
1. Take the next free range. **Never reuse or reassign a number** — cross-references in commits, reviews and test
   names outlive the document.
2. Leave the previous group room to grow contiguously. Student Identity starts at `IMPL-200`, not `IMPL-128`, so
   Library Management can extend.
3. Record `Priority`, `Blocks`, `Blocked by` per task.
4. Add a traceability table mapping task groups → requirements → invariants → acceptance.

| Range | Owner |
|---|---|
| `IMPL-014`…`073` | Authentication, platform, release readiness |
| `IMPL-100`…`127` | Library Management |
| `IMPL-128`…`199` | Reserved — Library growth |
| `IMPL-200`…`226` | Student Identity |
| `IMPL-227`+ | **Unallocated** |

### Stage 7 — Freeze

**The gate that matters most, because it changes what everyone else may do.**

**Gate:** a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned precedence rank.

Freeze is **conferred, not claimed**. No PRD in this repository declares itself frozen — verified: four of the
five contain no occurrence of the word at all. The operative rule is baseline §7:

> *"A change to any Rank 1–5 document requires an ADR **before** the change."*

After freeze:

| Change | Requires |
|---|---|
| Typo, formatting, broken link | Nothing. Fix it |
| Clarifying wording with no change in meaning | Changelog entry |
| **Any business-rule change** | **ADR → version increment → changelog → baseline update, in that order** |
| New requirement | Same as a business-rule change |
| Ownership or boundary change | ADR. `LIB-26.2`: *"MUST NOT be amended by a PRD revision alone"* |
| Withdrawing a requirement | ADR stating what replaces it |

**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly
right — [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-01` and `PGA-02` are two confirmed defects in frozen
documents left unfixed for exactly this reason. If a silent edit is acceptable when the editor is confident, the
freeze protects nothing, because every editor is confident.

### Stage 8 — Implementation

`IMPLEMENTING` on the first task started; `IMPLEMENTED` when all are closed.

Governed by [`DEFINITION_OF_DONE.md`](../../40-implementation/DEFINITION_OF_DONE.md) v1.2 and the six pipeline
gates in Dependency Matrix §10.4:

```
1  dart format
2  flutter analyze
3  dart run tool/check_module_boundaries.dart   ◄ blocks merge
4  flutter test test/architecture/              ◄ blocks merge
5  flutter test
6  flutter build web --release
```

Rules: update the traceability matrix **in the same commit** as the code; a requirement moves to ✅ only when its
acceptance criteria are proven by automated tests; a requirement that cannot be implemented as written is a
**specification defect** — raise an amendment, never silently reinterpret it.

### Stage 9 — Verification

`VERIFIED` requires **every** acceptance criterion proven by an automated test or a recorded repeatable
procedure, plus one failing-on-violation test per invariant.

The governing principle is `SID-4.56`:

> *"A rule that cannot be checked SHALL be treated as unmet."*

Consequences that are easy to resent and are not negotiable:

- `X-13` and `X-10` are specified and **not implemented** — therefore **unmet**, not "mostly fine".
- `SID-INT-1`…`12` are review-verified only — therefore **unmet** until `IMPL-220` checks them.
- **The module is not complete at 25 of 26 acceptance criteria.**

> **`IMPLEMENTED` and `VERIFIED` are different facts.** A module whose tasks are all closed but whose acceptance
> criteria are unproven is implemented and unverified, and saying so is the whole point of having two states.

---

## 4. Amending a frozen PRD

```
Proposed change
      │
      ▼
Is it a business-rule change, new requirement, or ownership change?
      │                                    │
     NO                                   YES
      │                                    │
      ▼                                    ▼
Changelog entry              1. Write an ADR — BEFORE the change
Version unchanged            2. Accept the ADR
                             3. Increment the PRD version
                             4. Update the PRD changelog — same commit
                             5. Update DOCUMENTATION_BASELINE.md — same commit
                             6. Update TRACEABILITY_MATRIX.md if identifiers changed
                             7. Update PRD_REGISTRY.md
```

Baseline §7 step 3 states the reason bluntly: *"A baseline that does not match the repository is worse than no
baseline."*

**The worked example is `ADR-0011`.** It amended a global business rule (`MP-GBR-02`), the Bounded Context Map's
Identity Triad, and a PRD's architecture. The ADR came first; Master PRD went v1.6 → v1.7, BC Map v1.2 → v1.3,
Dependency Matrix v1.0 → v1.1, and the baseline moved to `BASELINE-2026-08-04` — all recorded. Nothing was
edited quietly.

---

## 5. Identifier rules

1. **Every requirement has a unique identifier**, unique across the *whole platform*, not just its document.
2. Prefixes are checked against every existing register before use — 2,282 identifiers across three PRDs today.
3. On collision, **change the new prefix**, never the existing one.
4. Ranges are contiguous and published.
5. Numbers are never reused, even after withdrawal. A withdrawn requirement is marked withdrawn.
6. A register declared **closed** — `SEV-1`…`16`, `SPO-1`…`9`, `PO-1`…`12` — may not be extended without an ADR.

| Register | Owner | Count |
|---|---|---|
| `MP-*` | Master PRD | — |
| `AUTH-*`, `BR-*`, `XC-*`, `AC-*`, `EV-*`, `AERR-*`, `CFG-*` | Authentication | 1,517 |
| `LIB-*`, `INV-SEC-*`, `LBR-*`, `LXC-*`, `LAC-*`, `IAC-*`, `LCFG-*`, `ICFG-*`, `PO-*`, `LEV-*` | Library | ~422 |
| `SID-*`, `SID-BR-*`, `SXC-*`, `SPO-*`, `SEV-*`, `SID-INT-*`, `SID-INV-*`, `SCFG-*`, `SID-AC-*` | Student Identity | 343 |

---

## 6. Roles

Roles, not people — the repository names no individuals, and this document does not invent any.

| Role | Owns |
|---|---|
| Product owner | Content, business rules, scope |
| Architecture reviewer | Stage 3; authority to require an ADR |
| Requirements reviewer | Stage 4 |
| Traceability owner | Stage 5; the matrix |
| Implementation lead | Stages 6 and 8 |
| Governance owner | Stage 7; the baseline |

**Every PRD needs a named owner. None has one** — [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-08`.

---

## 7. Fast paths, and the one that does not exist

| Situation | Path |
|---|---|
| Typo or broken link in a frozen PRD | Fix directly. No ADR |
| Received verbatim from the owner | Stages 3–5 still apply. Findings go in a **separate** record so the capture stays auditable — the `14A` pattern |
| Emergency security correction | Stages 3 and 7 still apply. **`X-13` and `ID-1` are never waived under time pressure** |
| Urgent business need | **No fast path.** Stage 7 is not skippable |

---

## 8. How this maps to `PRD-000`…`PRD-003`

These four are frozen and **not re-run through the lifecycle**. Their historical routes, for reference only:

| PRD | Route |
|---|---|
| `PRD-000` Master | Iterative, v1.0 → v1.7. Stage 7 at each baseline |
| `PRD-001` Authentication | **Authored** — v1.0 chapters were empty. `ADR-0008` conferred baseline status; `PRD-V2-GOVERNANCE-NOTE.md` preserves the provenance |
| `PRD-002` Library | **Received verbatim**, reviewed without editing. 14 conflicts recorded separately |
| `PRD-003` Student Identity | **Reconciled** — `ADR-0011` changed the architecture mid-review. 11 findings accepted, 2 rejected with reasons |

**Three routes, one destination.** That is the argument for writing the process down: all three worked, and none
of them would be reproducible from memory.

---

## 9. References

[`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §4, §7 ·
[`ADR-INDEX.md`](../adr/ADR-INDEX.md) ·
[`DEFINITION_OF_DONE.md`](../../40-implementation/DEFINITION_OF_DONE.md) ·
[`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) ·
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) §10.4 ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) §7 ·
[`CONTRIBUTING.md`](../../../CONTRIBUTING.md) ·
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) ·
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md)

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Nine stages, each with a named exit-gate artefact, mapped to the nine registry statuses. Derived from the **three different routes** `PRD-001`, `PRD-002` and `PRD-003` actually took (§8) — authored, received verbatim, and reconciled — rather than from a generic template. Records that freeze is **conferred by the baseline, not self-declared**, and that no existing PRD declares its own freeze state. No frozen document is re-run through the lifecycle. No requirement created or modified; no PRD edited. |
