# Governance Note — Authentication PRD v2.0

**This note is not part of the specification.** It exists so the engineering record retains information that was
deliberately excluded from the PRD itself. The PRD was required to be clean of amendment, conflict and review
history; this file holds what would otherwise have been lost.

| Field | Value |
|---|---|
| Concerns | `docs/30-product/authentication/prd-v2/` and the assembled `Authentication_PRD_v2.md` |
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

## 4. Configurable parameters — reviewed and anchored

> **Superseded 2026-08-02.** This section originally recorded twelve values as *"reasonable defaults, not
> validated ones"* awaiting sign-off. They were subsequently reviewed under `DOCUMENTATION_AUDIT-001`, and **six
> were changed** to enterprise-recommended defaults anchored to recognised standards. The authoritative record is
> now [`../../20-configuration/CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md), which is
> normative for operations. The table below reflects the corrected values.

| ID | Parameter | Value | Anchor |
|---|---|---|---|
| `CFG-1` | OTP requests per number per hour | 5 | Prevailing Indian consumer-platform practice; bounds per-number SMS cost |
| `CFG-2` | Minimum interval between requests | 30 seconds | Indian SMS delivery is 5–20 s; must be far below the 5-minute validity |
| `CFG-3` | OTP requests per origin per hour | **100** *(was 30)* | **Corrected.** A study hall is 60–200 students behind one NAT gateway; 30 would have locked out every venue |
| `CFG-4` | Lock after quota exhaustion | **30 minutes** *(was 60)* | **Corrected.** OWASP — long hard lockouts are a DoS vector against known numbers |
| `CFG-5` | Idle session timeout | 30 d mobile / **30 min staff** *(was 12 h)* | **Corrected.** NIST SP 800-63B AAL2. A reception tablet is a shared, physically accessible device |
| `CFG-6` | Absolute session lifetime | 90 d mobile / **12 h staff** *(was 7 d)* | **Corrected.** NIST SP 800-63B AAL2; bounds a staff session to one working shift |
| `CFG-7` | Device trust lifetime | **90 days** *(was 180)* | **Corrected.** Industry norm, and must not outlive the 90-day mobile session it complements |
| `CFG-8` | Maximum registered devices | 10 | Covers genuine multi-device use over the trust window; bounds credential sharing |
| `CFG-9` | Pending-verification retention | 24 hours | DPDP — unverified personal data must not be retained indefinitely |
| `CFG-10` | Soft-delete retention | 30 days | Common consumer standard; defensible as erasure under DPDP |
| `CFG-11` | Claim failures before lock | 5 per 24 hours | Deliberately tighter than ordinary sign-in; claim grants an existing identity |
| `CFG-12` | Support elevation maximum | **1 hour** *(was 4)* | **Corrected.** Just-in-time least privilege — the highest-privilege state in the platform |

**Sign-off is no longer outstanding.** Each value is now a considered engineering position with a named anchor,
and nine cross-parameter invariants (`INV-1`…`INV-9`) are startup-validated requirements under `IMPL-015`.
Changing a value within its declared range is an operational decision; changing one outside its range requires an
ADR.

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
