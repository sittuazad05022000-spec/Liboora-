# Governance Note — Authentication PRD v2.0

**This note is not part of the specification.** It exists so the engineering record retains information that was
deliberately excluded from the PRD itself. The PRD was required to be clean of amendment, conflict and review
history; this file holds what would otherwise have been lost.

| Field | Value |
|---|---|
| Concerns | `docs/prd/authentication/prd-v2/` and the assembled `Authentication_PRD_v2.md` |
| Status of this note | Engineering record — advisory, non-normative |
| Date | 2026-08-02 |

---

## 1. Provenance

The v2.0 specification was **authored, not recovered**.

The previously approved eleven chapters were never transferred into the repository — all eleven files held headers
and zero body text. No attempt was made to reconstruct, imitate or infer that text. v2.0 was written from scratch
against the following inputs, treated as the current source of truth:

| Input | Contribution |
|---|---|
| Approved architecture rulings | Account creation on first verification; display name collected before verification; two-stage authentication; behavioural conformance |
| Master PRD global rules | OTP as sole factor; immediate and global revocation; no credential outside the Identity & Access context; no demo or guest accounts in a release build |
| Bounded Context Map | Definition of `BC-18`; global account with tenant-scoped role assignment; permitted and forbidden context edges |
| Implemented behaviour | 6-digit numeric codes, 5-minute validity, 5 verification attempts, single-use challenges, two-stage verify-then-issue |

The prior eleven-chapter document is **historical input only** and carries no authority.

## 2. Defect D-7 — disposition

`D-7` recorded that the approved Authentication chapters had never been transferred into the repository.

**D-7 is closed by authorship, not by transfer.** The gap was filled by writing a new specification, not by
recovering the original. Anyone expecting v2.0 to match the previously approved text should not assume it does. If
the original text still exists elsewhere and is considered authoritative, it must be reconciled against v2.0
explicitly — v2.0 will not silently agree with it.

## 3. ACN-001 — disposition

`ACN-001` recorded that OTP request rate limiting was unspecified, with ten open questions and no assumed values.

**ACN-001 is closed by Chapter 8 §8.3.** The policy *structure* is specified normatively. The numeric *thresholds*
were newly invented for this edition and are carried as `CFG-1` through `CFG-4`.

## 4. Parameters introduced without prior approval

Every value below appears in the specification for the first time. None is derived from an approved decision. They
are reasonable defaults, not validated ones, and each should be confirmed before the specification is treated as
signed off.

| ID | Parameter | Value chosen | Basis |
|---|---|---|---|
| `CFG-1` | OTP requests per number per hour | 5 | Balances legitimate retry against delivery cost |
| `CFG-2` | Minimum interval between requests | 30 seconds | Allows for slow delivery without enabling rapid abuse |
| `CFG-3` | OTP requests per origin per hour | 30 | Bounds shared-network abuse without penalising a library's own network |
| `CFG-4` | Lock after quota exhaustion | 60 minutes | Long enough to deter, short enough to avoid support load |
| `CFG-5` | Idle session timeout | 30 d mobile / 12 h staff | Consumer convenience against shared-device exposure at reception |
| `CFG-6` | Absolute session lifetime | 90 d mobile / 7 d staff | Bounds indefinite session survival |
| `CFG-7` | Device trust lifetime | 180 days | Periodic re-proof without frequent friction |
| `CFG-8` | Maximum registered devices | 10 | Accommodates genuine multi-device use; bounds accumulation |
| `CFG-9` | Pending-verification retention | 24 hours | Allows a same-day resumption; discards abandoned attempts |
| `CFG-10` | Soft-delete retention | 30 days | Protects against mistaken or coerced deletion |
| `CFG-11` | Claim failures before lock | 5 per 24 hours | Mirrors verification limits |
| `CFG-12` | Support elevation maximum | 4 hours | Bounds operator exposure to a working session |

**These twelve values require explicit sign-off.** They are marked configurable in the PRD, so changing any of them
is a decision rather than a specification amendment.

## 5. Items outside this specification that remain open

| Item | Status |
|---|---|
| `D-10` — demo constants present in the client (`kDemoChildPhone`, seeded sign-in list) | **OPEN.** Violates the platform rule prohibiting demo and guest accounts in a release build, and `AUTH-11.73`. Release blocker. Not addressed by this specification, which describes required behaviour rather than existing client code |
| `D-8`, `D-9` | Open; unrelated to this specification |
| `R-5` — contracts manifest defect and boundary checker | Open |
| Invitation-flow security specification | Referenced by Chapter 4; the detailed invitation mechanism remains to be specified |
| Library PRD chapters 1–25 | Never supplied |

## 6. Relationship to existing documents

| Document | Standing after v2.0 |
|---|---|
| The eleven empty chapter files | Superseded; retained as an empty custody shell only |
| `Authentication_PRD.md` (merged export of the empty shell) | Superseded; historical input only |
| `IVR-001`, `CHANGE_REPORT-001`, `VERIFICATION_REPORT-001`, `MODULE_COMPLETION_PACKAGE.md` | Retained as engineering record; not part of the specification |
| `ACN-001` | Closed by Chapter 8 |
| Architecture rulings register, Bounded Context Map, Master PRD | Unchanged and still authoritative for their own scope |

## 7. Conformance caveat

The specification was written to be consistent with implemented behaviour where that behaviour exists. It
nonetheless specifies a great deal that is **not yet implemented** — most of Chapters 6, 7, 9, 10 and 11 describe
required behaviour with no corresponding code. v2.0 must therefore be read as the target, not as a description of
the current system. A conformance pass against it will fail today, and should.
