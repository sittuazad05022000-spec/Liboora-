# ADR-0008 — Authentication PRD v2.0 is the official baseline

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-02 |
| **Closes** | Defect `D-7` |
| **Scope** | All documentation, all implementation of `BC-18` |

## Context

Defect `D-7` recorded that the Authentication PRD referenced throughout the repository — eleven chapters of
detailed specification — **was never present in the repository**. Eleven chapter files existed as empty slots
carrying the banner *"EMPTY SLOT AWAITING VERBATIM TRANSFER"*. Twelve downstream documents cited that missing
specification as their authority, including the Developer Guide, the Library PRD's §14A delegation, and every
verification report.

Recovery of the original v1 text was attempted and **failed**. The source is not in the repository, not in git
history, and not recoverable from any artefact under version control. A specification that cannot be produced
cannot be a baseline, and eleven empty slots cannot be handed to developers.

Leaving `D-7` open indefinitely has a compounding cost: every downstream document remains provisional, no
documentation lock can be applied, and implementation cannot begin against a specification that does not exist.

## Decision

**Authentication PRD v2.0 is declared the official baseline for `BC-18` Identity & Access.**

It was **authored, not recovered.** It does not claim to reproduce the v1 text and makes no representation about
what v1 contained. It is a complete, self-contained, eleven-chapter specification written against the binding
constraints that *were* in the repository — the Master PRD global rules, the Bounded Context Map, the Module
Dependency Matrix, and Architecture Rulings `AR-1`…`AR-7`.

Consequently:

1. **`D-7` is CLOSED — by authorship, not by transfer.** No further recovery attempt is warranted.
2. **v2.0 supersedes every earlier Authentication artefact.** The eleven empty slots, the v1 stub PRD, and the v1
   Developer Guide are superseded and archived.
3. **Every reference to "the Authentication PRD" means v2.0.** Any document asserting that the specification is
   absent, empty, or pending transfer is stale and must be corrected or archived.
4. **v2.0 is the sole authority for `BC-18`.** Where any other document conflicts with it on an authentication
   matter, v2.0 governs — except where the Master PRD states a platform-wide global rule, which outranks it.
5. **Downstream documents are unblocked.** Library PRD §14A's delegation to Authentication now resolves.

## Authority order

| Rank | Source | Governs |
|---|---|---|
| 1 | `MASTER_PRD.md` global rules (`MP-GBR-*`, `MP-CON-*`) | Platform-wide; outranks all module PRDs |
| 2 | Accepted ADRs in this register | Structural decisions |
| 3 | **Authentication PRD v2.0** | Everything within `BC-18` |
| 4 | Bounded Context Map, Module Dependency Matrix | Boundaries, ownership, permitted edges |
| 5 | Enterprise Architecture | Descriptive; must be updated to match 1–4, never the reverse |

## Consequences

**Positive.** A complete specification exists. Implementation can begin. Twelve downstream documents can be
corrected against a real authority. The documentation set can be locked and versioned.

**Negative.** If the original v1 text ever resurfaces, it has **no standing** — it would be a historical artefact
requiring a new ADR to reinstate any part of it. Conformance claims made against v1 language are not
automatically valid against v2.0 and were re-verified rather than assumed.

**Neutral.** v2.0 carries twelve configurable parameters (`CFG-1`…`CFG-12`) set to enterprise-recommended
defaults rather than to values inherited from v1. They are explicitly marked configurable and documented in the
Configuration Guide.

## Alternatives considered

| Alternative | Rejected because |
|---|---|
| Keep `D-7` open until v1 is recovered | The source does not exist; this blocks implementation indefinitely |
| Ship the eleven empty slots as-is with a caveat | Not a specification; developers would invent the missing rules independently |
| Write a thin summary instead of a full specification | Reproduces the original problem at lower resolution — downstream documents would still have no authority to cite |

## References

`docs/30-product/authentication/Authentication_PRD_v2.md` ·
`docs/30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md` ·
`DOCUMENTATION_BASELINE.md` · `MASTER_PRD.md` §31 ·
`DOCUMENTATION_AUDIT-001.md` findings `S-1`…`S-12`
