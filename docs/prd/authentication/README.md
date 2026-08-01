# Liboora — Authentication Architecture Specification

## Document purpose

This directory is the version-controlled destination for the Liboora
Authentication Architecture Specification, Chapters 1–11, together with its
final validation report and its GATE-1 blocker closure record.

Its purpose is custody, not authorship. No content in this directory may be
originated here; every chapter body must arrive by verbatim transfer from the
approved source.

## Version

| Field | Value |
| --- | --- |
| Specification version | v1.0 (lock candidate) |
| Directory created by | Task **D-7** — Documentation Lock |
| Repository | `liboora` / `docs/prd/authentication/` |
| Commit introducing this directory | `816f9b7` (closure record only) |

## Status

**STATUS = TRANSFER PENDING — NOT LOCKED.**

D-7 requested `Status = LOCKED`. That status has **not** been applied, because it
would be false. A lock asserts that the version-controlled copy is the
authoritative text. At the time of writing, eleven of the twelve documents in
this directory contain no chapter text — only transfer slots. Declaring LOCKED
over empty slots would create a source of truth that is authoritative and empty
at the same time.

`Status` becomes `LOCKED` only when both conditions below hold:

1. All eleven chapter files contain their approved text between the
   `BEGIN`/`END APPROVED CHAPTER CONTENT` markers.
2. The identifier-preservation check in `FINAL_VALIDATION_REPORT.md` has been
   run against the transferred text and passes.

Until then this directory is a **custody shell**, and the authoring channel
remains the only complete copy of the specification.

## Document index

| File | Contains | State |
| --- | --- | --- |
| `README.md` | This document — purpose, version, status, index, history | Complete |
| `01-Introduction.md` | Chapter 1 | Transfer slot — empty |
| `02-Authentication-Foundation.md` | Chapter 2 | Transfer slot — empty |
| `03-Registration.md` | Chapter 3 | Transfer slot — empty |
| `04-Login.md` | Chapter 4 | Transfer slot — empty |
| `05-Authorization.md` | Chapter 5 | Transfer slot — empty |
| `06-Sessions.md` | Chapter 6 | Transfer slot — empty |
| `07-Security.md` | Chapter 7 | Transfer slot — empty |
| `08-Lifecycle.md` | Chapter 8 | Transfer slot — empty |
| `09-Events-Audit-Notifications.md` | Chapter 9 | Transfer slot — empty |
| `10-Amendments-And-Integration.md` | Chapter 10 — title unconfirmed | Transfer slot — empty |
| `11-Non-Functional-Requirements.md` | Chapter 11 | Transfer slot — empty |
| `FINAL_VALIDATION_REPORT.md` | Validation report custody + D-7 outcome | Complete, partial content |
| `BLOCKER_CLOSURE_v1.0.md` | GATE-1 blocker closure decision record | Complete (pre-existing, `816f9b7`) |

## Chapter list

| # | Chapter | Filename | Title source |
| --- | --- | --- | --- |
| 1 | Introduction | `01-Introduction.md` | D-7 request (unconfirmed) |
| 2 | Authentication Foundation | `02-Authentication-Foundation.md` | D-7 request (unconfirmed) |
| 3 | Registration | `03-Registration.md` | D-7 request (unconfirmed) |
| 4 | Login | `04-Login.md` | D-7 request (unconfirmed) |
| 5 | Authorization | `05-Authorization.md` | D-7 request (unconfirmed) |
| 6 | Sessions | `06-Sessions.md` | D-7 request (unconfirmed) |
| 7 | Security | `07-Security.md` | D-7 request (unconfirmed) |
| 8 | Lifecycle | `08-Lifecycle.md` | D-7 request (unconfirmed) |
| 9 | Events, Audit & Notifications | `09-Events-Audit-Notifications.md` | D-7 request (unconfirmed) |
| 10 | *(approved title unknown)* | `10-Amendments-And-Integration.md` | **Not supplied by D-7** |
| 11 | NFRs, Compliance & Final Acceptance | `11-Non-Functional-Requirements.md` | Confirmed |

**Numbering note.** The D-7 request enumerated ten chapter files for eleven
approved chapters, and filed the NFR chapter as `10-`. Chapter 11 is numbered
11 here, and Chapter 10 has been given its own file, because merging chapters
is forbidden (D-7 rule 9) and numbering must be preserved (D-7 rule 4). Two
consequences require an owner's decision: the filename and approved title of
Chapter 10, and whether the D-7 file list should be corrected to eleven slots.

## Change history

| Date | Change | Commit |
| --- | --- | --- |
| Earlier | GATE-1 blocker closure record added; 14 blockers closed; 12 source files changed | `816f9b7` |
| This change | D-7 custody shell created: `README.md`, eleven chapter transfer slots, `FINAL_VALIDATION_REPORT.md`. **No specification content transferred.** | *this commit* |

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
