<!--
  PRD-017 -- BC-29 MEDIA SERVICE IMPLEMENTATION DECISION REQUEST
  ===================================================================
  PROVENANCE AND LIMITS OF THIS DOCUMENT
    - This is a REQUEST document, not a decision document.
    - Requests made here ................ ZERO decisions made here
    - Values proposed here ............... ZERO values proposed
    - Open decisions resolved here ....... ZERO resolved here
    - ADRs created by this document ...... ZERO ADRs created
    - Lifecycle effect .................. NONE. PRD-017 stays PLANNED.
  CONVENTION
    Follows the Pack -> Request pattern established by
    PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md and
    PRD-021A_OWNER_DECISION_REQUEST.md and
    PRD-021C_OWNER_DECISION_REQUEST.md.
  ===================================================================
-->

# PRD-017 -- BC-29 MEDIA SERVICE IMPLEMENTATION DECISION REQUEST

> WARNING: READ THIS FIRST. This document makes NO DECISION. It records open
> questions for the Architecture Owner. NO WORK MAY PROCEED until explicit
> authority is recorded.

| Field | Value |
|---|---|
| **Document** | PRD-017 Phase 6 Decision Request |
| **ADR pending** | UNASSIGNED (candidate ADR-0178) |
| **Date** | 2026-09-27 |
| **Status** | OPEN - awaiting Architecture Owner decision |
| **Scope** | BC-29 media implementation for actual photo rendering |
| **Source PRD** | PRD-017_FINAL_FREEZE.md |
| **Fil gaps** | FIL-GAP-001, FIL-GAP-008 |
| **Decisions made here** | ZERO |

---

## 1. THE EXACT QUESTIONS

> 1A. ADR ALLOCATION
> Who is authorized to assign an ADR number for BC-29 Phase 6 decisions?
> Candidate: ADR-0178 (unallocated in ADR-INDEX.md)

> 1B. FIL-GAP-001: MEDIAFILE OWNERSHIP
> Should BC-29 own a MediaFile aggregate with defined lifecycle responsibilities?
> Options: ADOPT | DEFER | REJECT

> 1C. FIL-GAP-008: RETENTION AND LEGAL REVIEW
> Establish retention policy requiring legal counsel approval.
> NOTE: Seven-year retention proposal is UNAPPROVED until legal review.

> 1D. AUTHORIZED MEDIA RETRIEVAL ARCHITECTURE
> Does existing FileAccess port suffice for retrieval, or is MediaStore required?

> 1E. PHASE 6 AUTHORIZATION
> Can implementation begin after ADR allocation and gap-resolution decisions?
> Specify permitted work scope vs. blocked items.

---

## 2. CONSTRAINTS (VERIFIED FROM GOVERNANCE)

- FileRef is opaque identifier -- never bytes/URL/path (ADR-0059 L8)
- FileRef must NOT be bearer capability (ADR-0059 section 3.5)
- Per-request authorization via E-22 (SM-4.11)
- Tenant isolation via ambient TenantContext (ADR-0059 section 3.6)
- Media-failure must degrade display only (SM-4.12, SID-2.40)
- ADR-0177 allocated to GSD-core, NOT available for BC-29

---

## 3. EARLIEST APPROVED PATH TO PHOTO RENDERING

**After ADR allocation and AO approval:**
1. Wire FileAccess.resolve(BC-01) into photo display path
2. Implement BC-29 MediaStore adapter (tenant-partitioned)
3. Extend FileRefAvatar to render image widget on success
4. Add widget test for BC-29 outage -> Monogram fallback

**NOT PERMITTED WITHOUT AO APPROVAL:**
- Allocating ADR-0178 or any other ADR number
- Declaring seven-year retention valid
- Any production storage implementation

---

## 4. REQUIRED AO DECISION

AO must rule on:
- ADR number allocation (candidate: ADR-0178)
- FIL-GAP-001 disposition (Accept / Defer / Reject MediaFile ownership)
- FIL-GAP-008 retention process (Legal review gate)
- Media retrieval contract approval
- Phase 6 implementation authorization scope