# Liboora — Authentication Specification

## Document purpose

This directory holds the Liboora Authentication specification together with the
engineering record supporting it.

## Version

| Field | Value |
| --- | --- |
| Specification version | **v2.0** |
| Authoritative file | `Authentication_PRD_v2.md` (single file) |
| Per-chapter source | `prd-v2/` (cover + eleven chapters) |
| Repository | `liboora` / `docs/prd/authentication/` |

## Status

**STATUS = v2.0 AUTHORED — AUTHORITATIVE.**

The specification is complete. All eleven chapters contain their full text.
`Authentication_PRD_v2.md` is the source of truth for Authentication.

### How v2.0 came to exist

The previous status of this directory was `TRANSFER PENDING — NOT LOCKED`: an
eleven-slot custody shell whose chapter files contained **zero body characters**,
because the approved v1.0 text was never transferred into the repository. That
gap was recorded as defect `D-7`.

**`D-7` is closed by authorship, not by transfer.** Version 2.0 was written from
scratch against the approved architecture rulings, the Master PRD global rules,
the Bounded Context Map and implemented behaviour. It does **not** reproduce the
v1.0 text and makes no claim to. If the original approved text exists elsewhere
and is still considered authoritative, it must be reconciled against v2.0
explicitly — v2.0 will not silently agree with it.

The eleven original slot files are retained, marked superseded, so the custody
record stays intact.

### Caveat

v2.0 specifies substantially more than is currently implemented. It is the
target, not a description of the running system. See
`PRD-V2-GOVERNANCE-NOTE.md` for provenance, the twelve configurable parameters
awaiting sign-off, and the items that remain open.

## Document index

### The specification

| File | Contains | State |
| --- | --- | --- |
| `Authentication_PRD_v2.md` | **The complete specification, single file** | **Authoritative** |
| `prd-v2/00-Cover-and-Control.md` | Identifier scheme, normative language, `CFG-1`–`CFG-12`, structural facts | Authoritative |
| `prd-v2/01-Purpose-and-Goals.md` | Chapter 1 | Authoritative |
| `prd-v2/02-User-Types-and-Roles.md` | Chapter 2 | Authoritative |
| `prd-v2/03-Authentication-Methods.md` | Chapter 3 | Authoritative |
| `prd-v2/04-Registration-and-Account-Claim.md` | Chapter 4 | Authoritative |
| `prd-v2/05-Login-and-Library-Selection.md` | Chapter 5 | Authoritative |
| `prd-v2/06-Session-and-Device-Management.md` | Chapter 6 | Authoritative |
| `prd-v2/07-Roles-Permissions-and-Access-Policies.md` | Chapter 7 | Authoritative |
| `prd-v2/08-Security-and-Privacy.md` | Chapter 8 | Authoritative |
| `prd-v2/09-Account-Lifecycle.md` | Chapter 9 | Authoritative |
| `prd-v2/10-Events-Audit-and-Notifications.md` | Chapter 10 | Authoritative |
| `prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` | Chapter 11 | Authoritative |

### Engineering record — not part of the specification

| File | Contains |
| --- | --- |
| `PRD-V2-GOVERNANCE-NOTE.md` | Provenance, `D-7` disposition, parameters awaiting sign-off, open items |
| `MODULE_COMPLETION_PACKAGE.md` | Module completion package index and change register |
| `VERIFICATION_REPORT-001.md` | Implementation verification, forward and reverse traceability |
| `CHANGE_REPORT-001.md` | Implementation change report |
| `IVR-001-OTP-Account-Creation.md` | Implementation validation record |
| `ACN-001-OTP-Request-Rate-Limiting.md` | Rate-limiting gap — **closed by v2.0 Chapter 8** |
| `FINAL_VALIDATION_REPORT.md` | v1.0 validation custody record |
| `BLOCKER_CLOSURE_v1.0.md` | GATE-1 blocker closure decision record |

### Superseded

| File | State |
| --- | --- |
| `01-Introduction.md` … `11-Non-Functional-Requirements.md` | Eleven v1.0 transfer slots. Never contained chapter text. Marked superseded; retained for custody continuity |
| `Authentication_PRD.md` | Merged export of the empty v1.0 shell. Historical input only |

## Chapter list — v2.0

| # | Chapter |
| --- | --- |
| 1 | Purpose & Goals |
| 2 | User Types & Roles |
| 3 | Authentication Methods |
| 4 | Registration & Account Claim |
| 5 | Login & Library Selection |
| 6 | Session & Device Management |
| 7 | Roles, Permissions & Access Policies |
| 8 | Security & Privacy |
| 9 | Account Lifecycle |
| 10 | Events, Audit & Notifications |
| 11 | NFRs, Compliance & Final Acceptance |

## Change history

| Date | Change | Commit |
| --- | --- | --- |
| Earlier | GATE-1 blocker closure record added; 14 blockers closed; 12 source files changed | `816f9b7` |
| Earlier | D-7 custody shell created: `README.md`, eleven chapter transfer slots, `FINAL_VALIDATION_REPORT.md`. **No specification content transferred.** | `cbd59b3` |
| Earlier | Module completion package: architecture, implementation and verification records | `9b9e1d5` |
| This change | **Authentication PRD v2.0 authored.** Eleven complete chapters plus cover, assembled into `Authentication_PRD_v2.md`. `D-7` closed by authorship. `ACN-001` closed by Chapter 8. Eleven empty v1.0 slots marked superseded | *this commit* |

## Related documents

| Document | Path | Relationship |
| --- | --- | --- |
| Blocker closure record | `docs/prd/authentication/BLOCKER_CLOSURE_v1.0.md` | Records the GATE-1 rulings on `AS-09`, `QA-13`, `QA-24`, amendments `A-1`–`A-9`, defects `F-01`, `F-02` |
| Bounded context map | `docs/architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | Canonical for the identity triad, integration edges, `iam.*` events |
| Module dependency matrix | `docs/architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | Canonical for dependency laws L1–L5, ranks, forbidden edges `X-01`–`X-14` |
| Enterprise architecture | `docs/architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | Parent architecture document |
| Module dependency manifest | `tool/module_dependencies.yaml` | Carries amendments `A-2`–`A-6`, `A-9`; declares `event_register_source` pointing into this directory |
| Conformance suite | `test/authentication_conformance_test.dart` | 26 executable regressions for `F-01`, `F-02`, `A-7`, `A-8`, `QA-13` |

**Unresolved reference.** `tool/module_dependencies.yaml` sets
`event_register_source: docs/prd/authentication`. That pointer does not yet
resolve to any register, because Chapter 9 has not been transferred.
