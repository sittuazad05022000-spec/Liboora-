> # ⛔ ARCHIVED — NOT AUTHORITATIVE
>
> **This document has no standing.** It is retained for historical record only and **must not be cited as
> authority, quoted in a specification, or used to guide implementation.**
>
> | | |
> |---|---|
> | **Archived** | 2026-08-02 |
> | **Superseded by** | [`Authentication PRD v2.0`](../../30-product/authentication/Authentication_PRD_v2.md) |
> | **Authority** | [`ADR-0008`](../../00-governance/adr/ADR-0008-authentication-prd-v2-baseline.md) · [`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) |
>
> **Why archived: this file was a stub. Its eleven chapters were empty placeholders carrying "EMPTY SLOT AWAITING VERBATIM TRANSFER" banners, and line 14 stated the specification was "not present in this repository". It never contained a specification.**
>
> Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**. The specification
> now exists as Authentication PRD v2.0. Any statement below asserting that the specification is missing, empty,
> pending transfer, or unwritten **was true when written and is false now.**

---

# Liboora — Authentication PRD (Merged Export)

> **GENERATED ARTIFACT — PROVENANCE NOTICE.**
>
> This file is a **mechanical, byte-verbatim concatenation** of every
> Authentication document present in `docs/prd/authentication/` at the time of
> export. It was produced by `cat`, not by an author. No heading, table,
> identifier, business rule, acceptance criterion, ordering or number has been
> rewritten, improved, simplified, reorganised, normalised, summarised,
> de-duplicated or invented.
>
> **This export is not more complete than its sources.** Eleven of the twelve
> chapter documents are empty transfer slots (0 body characters, verified). The
> approved Chapter 1–11 text is **not present in this repository and not present
> in Git history** — verified by scanning all 275 objects in the object store.
> Defect `D-7` remains OPEN.
>
> Everything below the source separators is reproduced exactly as it exists on
> disk. The only text in this file that is not from a source document is this
> notice and the `=== SOURCE: ... ===` separators.

## Export manifest

| Order | Source file | Role |
|---|---|---|
| 1 | `README.md` | Directory index, status, chapter list, change history |
| 2 | `01-Introduction.md` | Chapter 1 — transfer slot |
| 3 | `02-Authentication-Foundation.md` | Chapter 2 — transfer slot |
| 4 | `03-Registration.md` | Chapter 3 — transfer slot |
| 5 | `04-Login.md` | Chapter 4 — transfer slot |
| 6 | `05-Authorization.md` | Chapter 5 — transfer slot |
| 7 | `06-Sessions.md` | Chapter 6 — transfer slot |
| 8 | `07-Security.md` | Chapter 7 — transfer slot |
| 9 | `08-Lifecycle.md` | Chapter 8 — transfer slot |
| 10 | `09-Events-Audit-Notifications.md` | Chapter 9 — transfer slot |
| 11 | `10-Amendments-And-Integration.md` | Chapter 10 — transfer slot |
| 12 | `11-Non-Functional-Requirements.md` | Chapter 11 — transfer slot |
| 13 | `BLOCKER_CLOSURE_v1.0.md` | GATE-1 blocker closure decision record — **has content** |
| 14 | `FINAL_VALIDATION_REPORT.md` | Validation report custody + D-7 outcome — **has content** |



---

<!-- ===== SOURCE: docs/prd/authentication/README.md (5758 bytes, 105 lines) — VERBATIM BELOW ===== -->

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

<!-- ===== END SOURCE: docs/prd/authentication/README.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/01-Introduction.md (1342 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 1 — Introduction

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 1. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 1 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request. Confirm against the approved chapter heading on transfer.

<!-- ===== BEGIN APPROVED CHAPTER 1 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 1 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/01-Introduction.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/02-Authentication-Foundation.md (1548 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 2 — Authentication Foundation

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 2. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 2 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Known open item: defect D-9 records that this chapter's exception register uses the band EC-01…EC-48 and is scheduled for renumbering to an EC-2xx band on consolidation. D-7 must NOT perform that renumbering (rule 4: preserve numbering). Transfer EC-01…EC-48 as approved; D-9 remains open.

<!-- ===== BEGIN APPROVED CHAPTER 2 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 2 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/02-Authentication-Foundation.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/03-Registration.md (1284 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 3 — Registration

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 3. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 3 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 3 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 3 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/03-Registration.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/04-Login.md (1277 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 4 — Login

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 4. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 4 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 4 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 4 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/04-Login.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/05-Authorization.md (1285 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 5 — Authorization

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 5. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 5 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 5 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 5 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/05-Authorization.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/06-Sessions.md (1280 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 6 — Sessions

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 6. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 6 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 6 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 6 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/06-Sessions.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/07-Security.md (1280 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 7 — Security

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 7. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 7 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 7 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 7 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/07-Security.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/08-Lifecycle.md (1281 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 8 — Lifecycle

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 8. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 8 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Working title supplied by the D-7 request.

<!-- ===== BEGIN APPROVED CHAPTER 8 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 8 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/08-Lifecycle.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/09-Events-Audit-Notifications.md (1655 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 9 — Events, Audit & Notifications

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 9. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 9 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Known dependency: amendment A-4 references the 36-fact event register EVT-1001…EVT-1036, whose member names were never available to the implementing agent. tool/module_dependencies.yaml therefore REFERENCES this register (event_register_source: docs/prd/authentication) rather than duplicating it. Once this chapter is transferred, that reference resolves to a real artifact for the first time.

<!-- ===== BEGIN APPROVED CHAPTER 9 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 9 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/09-Events-Audit-Notifications.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/10-Amendments-And-Integration.md (1666 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 10 — (approved title unknown to this agent)

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 10. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 10 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

STRUCTURAL DEVIATION — READ THIS. The D-7 request listed ten chapter files for eleven approved chapters, leaving this chapter without a destination. Creating it was required by rule 9 ('Do not merge chapters'), which outranks the filename list. This chapter is the source of amendments A-2, A-3, A-4, A-5 and A-6. Its approved title must be confirmed and this filename corrected on transfer.

<!-- ===== BEGIN APPROVED CHAPTER 10 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 10 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/10-Amendments-And-Integration.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/11-Non-Functional-Requirements.md (1836 bytes, 29 lines) — VERBATIM BELOW ===== -->

# Chapter 11 — NFRs, Compliance & Final Acceptance

> **CONTENT TRANSFER PENDING — THIS FILE IS NOT THE SPECIFICATION.**
>
> Status of chapter: **APPROVED** (approval occurred in the authoring channel).
> Status of this file: **EMPTY SLOT AWAITING VERBATIM TRANSFER**.
>
> This file was created by task D-7 to establish the version-controlled
> destination for Chapter 11. Its body has been left deliberately empty.
>
> The approved text of this chapter is not held in a retrievable form by the
> agent that created this file. Reconstructing it from memory would constitute
> regeneration, which D-7 explicitly forbids ("Do not rewrite, improve, expand,
> or regenerate the specification"). No requirement, identifier, table,
> register, diagram or cross-reference has therefore been written here, because
> none could be guaranteed byte-identical to the approved source.
>
> **Do not treat this file as authoritative until the transfer is performed.**

## Transfer instruction

Replace everything below the marker with the approved Chapter 11 text,
copied without alteration. Do not renumber. Do not reformat. Do not summarise.

Title is confirmed. Register inventory expected in this chapter (allocation spans only; member texts not held): NPB-1…9, NPO-1…12, NSP-1…12, PERF-1101…1134, AVL-1101…1128, SCL-1101…1137, OBS-1101…1126, CMP-1101…1154, ERR-1101…1136, BCP-1110…1140, CON-1101…1188, FAC-1101…1162, OOS-1101…1153, FUT-1101…1135, gates GATE-1/2/3, conflicts CFL-29…CFL-37, amendments A-7, A-8, A-9. NOTE: the D-7 request filed this chapter as '10-Non-Functional-Requirements.md'; it is chapter 11 and has been named accordingly to preserve numbering (rule 4).

<!-- ===== BEGIN APPROVED CHAPTER 11 CONTENT — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED CHAPTER 11 CONTENT ===== -->

<!-- ===== END SOURCE: docs/prd/authentication/11-Non-Functional-Requirements.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/BLOCKER_CLOSURE_v1.0.md (12334 bytes, 171 lines) — VERBATIM BELOW ===== -->

# Liboora Authentication — GATE-1 Blocker Closure Record

**Artifact type:** Decision record. Not a chapter. Not a specification.
**Authority:** Lead Enterprise Architect · Principal Security Architect · Documentation Governor
**Scope:** the 14 GATE-1 blockers named in the final validation report, and nothing else.

## Governing constraints on this record

| # | Constraint | Held |
|---|---|---|
| C-1 | No new functional requirement, business rule, bounded context, user role or authentication method | ✅ |
| C-2 | No locked chapter rewritten, no identifier renumbered | ✅ |
| C-3 | No new conflict, amendment, assumption, open question or defect | ✅ |
| C-4 | Every ruling derives from an already-locked identifier; none is an independent decision | ✅ |
| C-5 | Only artifacts named in D-1…D-6 modified | ✅ |

Each ruling below states the **locked identifiers it derives from**. Where a ruling could not be derived, it would have been escalated as an Architecture Change Request. **No ACR was required.**

---

## 1. Assumption

### `AS-09` — **ACCEPTED**

Confirmed in place, unchanged, as recorded in its originating chapter. This record does not restate it, because restating an assumption is how an assumption quietly becomes a different assumption.

**Basis for confirmation — non-contradiction.** `AS-09` was reviewed against every identifier locked after it, specifically: `CON-1120`–`CON-1125` (credentials), `CON-1123` (enumeration resistance), `PERF-1104`–`PERF-1112` (challenge budgets and the trust-boundary split), `CFL-30` (delivery is not BC-18's to promise), and `THR-806` verdict `CONTAIN`. No locked identifier contradicts it, and no chapter after it relied on it being different.

**Standing review trigger.** The confirmation lapses, and `AS-09` returns to the register, if any of the following changes: the sole-factor decision (`CON-1120`), the delivery trust boundary (`CFL-30`), or the `THR-806` verdict. Reconfirmation is then a review-authority act, not an implementation act.

**Status:** ACCEPTED · GATE-1 cleared · no register entry added.

---

## 2. Open Questions

### `QA-13` — entitlement evaluation, fail-open versus fail-closed for mutations — **RESOLVED**

**Ruling: fail closed for entitlement-gated mutations. Fail-open is not available.**

**This is a derivation, not a decision.** Three locked identifiers already determine it:

1. `AVL-1114` — an unavailable or stale decision input is treated as **absent**, and *"an absent input may narrow a decision and may never widen it."*
2. `BCP-1135` — *"where a decision cannot be rendered correctly, it is refused."*
3. The fourth `AccessPolicy` guardrail, **non-escalation** (`CON-1143`) — an entitlement gate exists to narrow; a gate that opens when it cannot be evaluated has escalated.

An absent entitlement therefore narrows the mutation to refusal. No new rule is created; the ruling merely records which branch the locked rules already compel.

**Bounds carried, per `AVL-1109` — the ruling may not reach beyond the gate:**

| Path | Effect of entitlement unavailability |
|---|---|
| Authenticate / establish session | **None.** Entitlement is a non-authentication dependency (`AVL-1107`). |
| Validate session | **None.** |
| Render a non-entitlement authorization decision | **None.** |
| Read a resource | **None.** Reads are not gated. |
| Entitlement-gated **mutation** | **Refused.** |

**Refusal shape:** internal class `AUTHZ` (`ERR-1111`), code `authzEntitlementGateRefused`, external projection `xDenied` (`ERR-1130`) — because the caller already legitimately knows the resource exists. The refusal is **not** `xTemporaryFailure`: a gate refusal is a decision, not a transient condition, and presenting it as retriable would invite the caller to retry until the gate happened to be unreachable.

**No conflict with `SSP-4`.** `SSP-4` forbids failing closed **on a non-authentication dependency** — that is, it forbids letting BC-21 break authentication. It does not require that an entitlement-gated mutation proceed ungated. The table above is the boundary, and it is enforced by construction: `AuthService` takes no entitlement dependency, asserted by `test/authentication_conformance_test.dart › QA-13`.

**Applied in:** `packages/liboora_contracts/lib/src/errors/domain_error.dart`, `tool/module_dependencies.yaml` (assertion `ID-8` neighbourhood), regression tests.
**Status:** RESOLVED · GATE-1 cleared.

---

### `QA-24` — the notification-address port — **RESOLVED**

**Ruling: accept the port exactly as scoped by the already-approved resolution of `CFL-26`. No widening.**

Derived from: `CON-1177` (no event ever carries a mobile number), `NTF-1012`–`NTF-1017` (address resolved at delivery time), `CMP-1116` (capability sized exactly to purpose), `OBS-1104` (a number may not appear in any observability artifact).

**Port shape — closed:**

| Property | Ruling |
|---|---|
| Name | `platform/identity:notification_address` |
| Consumer | `platform/communication` (BC-22) only |
| Input | one `AccountId` + one declared delivery purpose |
| Output | one address, for one already-queued delivery |
| Timing | at delivery time, never at emission time |
| Listing / bulk / enumeration | forbidden |
| Existence testing | forbidden — an unresolvable address fails the delivery, never the emitting operation |
| Retention by caller | forbidden — no persist, cache, index or log |

**Applied in:** `tool/module_dependencies.yaml` — port declared on `platform/communication`, `provides_ports` on `platform/identity`, assertions `CM-1`, `CM-2`, `CM-3`, `ID-5`.
**Status:** RESOLVED · GATE-1 cleared.

---

## 3. Amendments — all APPLIED

| ID | Target artifact | What was applied | Verification |
|---|---|---|---|
| `A-1` | `domain_error.dart` | **36** BC-18 error codes appended (never interleaved — the enum is additive-only). Internal classes `ERR-1110`–`ERR-1116`. The pre-application estimate was ≈22; enumerating the locked conditions yields 36. No condition was invented and none was merged. | `A-7 · every code declares a class and an external outcome` |
| `A-2` | `module_dependencies.yaml` | `domain/library` may consume `iam.AccountVerified`, `iam.AccountStatusChanged`; gains `platform/identity:account_directory` (single-subject, no listing, no lookup by number) | declared `provides_ports` constraint |
| `A-3` | `module_dependencies.yaml` | `platform/identity:notification_address` on `platform/communication`; assertions `CM-1`–`CM-3` | see `QA-24` |
| `A-4` | `module_dependencies.yaml` | `emission_classes` block: Class D / A / T with transport and consumers; assertions `ID-1`, `ID-2`. The 36-fact register is **referenced, not duplicated** — duplicating it is how two registers drift. | assertions `ID-1`, `ID-2` |
| `A-5` | `module_dependencies.yaml` | Class A confined to `platform/audit`, stated as a boundary violation rather than a subscription choice; assertions `ID-3`, `AU-2` | assertions `ID-3`, `AU-2` |
| `A-6` | `module_dependencies.yaml` | `platform/analytics` gains `excluded_events: ["iam.*"]` — explicit, because `"*"` would otherwise silently subscribe it; assertion `AN-3` | assertion `AN-3` |
| `A-7` | `domain_error.dart` | `ExternalOutcome` (closed, 7 members) + `ErrorClass` + **exhaustive** `switch` projections. Adding a code cannot compile until its class and projection are declared — the structural guarantee A-7 required, replacing convention. | 6 tests in `A-7` group |
| `A-8` | `identifiers.dart` | `DeviceId`, `SessionId`, `InviteId`, `PermissionId` as `Identifier` subtypes. `SessionId` now carried by `AuthSession`; `PermissionId` exposed by the closed `Permission` catalogue, so neither is dead code. | 3 tests in `A-8` group |
| `A-9` | `module_dependencies.yaml` | `global.observability_plane`: classification ceiling `DC-2`, banned content list, banned/allowed metric dimensions, forbidden inferences, `is_authoritative_for: []`, 30-day retention, `severity: blocker`; assertion `ID-4` | declared block + assertion `ID-4` |

`exceptions:` remains **empty**. None of the nine is an exception to a law — each widens a declared allow-list or adds an assertion. A law exception would have required an ADR and an expiry; none was needed.

---

## 4. Defects — both REMOVED

### `F-01` — unscoped `viewStudent` for `student` and `parent` — **REMOVED**

Violated `RBD-12`, `AZ-704`, `THR-808.6`, `CON-1141`, `CON-1146`.

The grant table changed shape, not content: `Map<AccessRole, Set<Permission>>` → `Map<AccessRole, Map<Permission, AccessScope>>`. **There is now no way to express an unscoped grant** — which is the actual fix. The scope register is the locked closed set, implemented verbatim: `self`, `guardianOf`, `tenantWide`.

- `student` → `viewStudent` at `self`
- `parent` → `viewStudent` at `guardianOf`
- staff roles → `tenantWide`, unchanged

`require()` keeps its signature and all eight existing domain call sites compile untouched, but it now **refuses** a scoped grant presented without a resource — and refuses it as `authzScopeOutsideSubject` → `xNotFound`, never `xDenied`, per `CON-1146`. `requireOn()` is the only path by which a scoped grant can pass.

**Regressions:** 7 tests, including `every grant in the catalogue declares a scope` (loops the full catalogue, so a future unscoped grant fails CI) and `a scoped denial is indistinguishable from not-found`.

### `F-02` — enumeration oracle, derivable challenge, no TTL, no attempt budget — **REMOVED**

Violated `SC-305`–`SC-308`, `BR-514`, `THR-805.5`, `CON-1121`, `CON-1123`.

| Sub-defect | Correction |
|---|---|
| `requestOtp` returned `false` for unknown numbers | Returns **`void`**. There is no signal to read — the signature is the fix. |
| Oracle repeated at two higher layers | `SessionController.requestOtp` no longer sets an error; `login_screen._send()` no longer branches. The message *"No Liboora account is registered for this number."* is deleted. |
| Code = `phone.hashCode` | Drawn digit-by-digit from `RandomSource`; `SecureRandomSource` wraps `Random.secure()` and lives in the adapter layer because the shared kernel may not import `dart:math` (L5). The port is the one named by `X-09`'s own `banned_symbols` entry. |
| No TTL | `challengeTtl` enforced against the injected `Clock`. |
| No attempt limit | `maxVerifyAttempts` enforced per challenge; exhaustion discards the challenge, so the correct code stops working. |
| Debug peek was a public field | `lastIssuedOtp` removed. `debugPeekChallenge()` returns null unless the wiring sets `challengePeekEnabled`, which DI derives from `!dart.vm.product`. |

Adapter defaults (`challengeTtl` = 5 min, `maxVerifyAttempts` = 5, 6 numeric digits per TRAI DLT) are **configuration of** the locked bounds, not restatements of them. The normative values remain the locked registers'.

**Regressions:** 8 tests, including `the challenge is not a function of the subject` — which the old implementation could not have passed under any parameterisation.

---

## 5. Verification at time of closure

| Check | Result |
|---|---|
| `flutter analyze` | **No issues found** |
| `flutter test` | **All tests passed — 35/35** (9 pre-existing + 26 new) |
| `dart format .` | clean |
| Locked chapters modified | **0** |
| Identifiers renumbered | **0** |
| New conflicts / amendments / assumptions / open questions / defects | **0** |
| ACRs required | **0** |

## 6. Files modified

| File | Blockers closed |
|---|---|
| `packages/liboora_contracts/lib/src/errors/domain_error.dart` | `A-1`, `A-7`, `QA-13` |
| `packages/liboora_contracts/lib/src/value_objects/identifiers.dart` | `A-8` |
| `packages/liboora_contracts/lib/src/ports/random_source.dart` *(new)* | `F-02` |
| `packages/liboora_contracts/lib/liboora_contracts.dart` | `F-02` (export) |
| `tool/module_dependencies.yaml` | `A-2`…`A-6`, `A-9`, `QA-24` |
| `lib/platform/identity/identity.dart` | `F-01`, `F-02`, `A-8` |
| `lib/bootstrap/di.dart` | `F-02` (secure wiring) |
| `lib/app/session.dart` | `F-02` (oracle at controller) |
| `lib/app/shell/login_screen.dart` | `F-02` (oracle at UI) |
| `test/authentication_conformance_test.dart` *(new)* | `FAC-1142` regressions |
| `lib/app/dashboards/students_page.dart` | analyzer baseline restored to clean |

<!-- ===== END SOURCE: docs/prd/authentication/BLOCKER_CLOSURE_v1.0.md ===== -->


---

<!-- ===== SOURCE: docs/prd/authentication/FINAL_VALIDATION_REPORT.md (3760 bytes, 56 lines) — VERBATIM BELOW ===== -->

# Final Validation Report — Authentication v1.0

> **Custody note.** The approved validation report (Revision 2) was produced in
> the authoring channel and its verbatim text is not held by the agent creating
> this file. Restating it from memory would be regeneration, which D-7 forbids.
> This file therefore carries only (a) the machine-verifiable evidence, which was
> re-executed against this repository, and (b) the D-7 outcome. **Section 3 is a
> transfer slot for the approved report.**

## 1. Machine-verified evidence

Every row below was produced by executing a command in this repository and
reading its output. Nothing in this section is inferred.

| Check | Command | Result |
| --- | --- | --- |
| HEAD commit | `git log --oneline -1` | `816f9b7 feat(auth): clear all 14 GATE-1 blockers for v1.0 lock` |
| Working tree | `git status --short` | empty — clean |
| Change set | `git show --stat HEAD` | 12 files changed, 1393 insertions(+), 66 deletions(-) |
| Static analysis | `flutter analyze` | `No issues found!` — exit 0 |
| Baseline suite | `flutter test test/widget_test.dart` | `+9` — `All tests passed!` |
| Conformance suite | `flutter test test/authentication_conformance_test.dart` | `+26` — `All tests passed!` |
| Total | — | 35 passing tests |

## 2. Claims that are NOT machine-verified

Recorded so that no reader mistakes a judgement for a measurement.

| Claim | Basis | Limitation |
| --- | --- | --- |
| Amendments `A-1`–`A-9` applied | Edits exist, compile, and are committed | That each edit *fully discharges* its amendment intent is a judgement. `A-2`–`A-6` texts are in Chapter 10, untransferred. `A-4` references `EVT-1001`–`EVT-1036`, whose member names were never available. |
| `QA-13` resolved | Ruling recorded in `BLOCKER_CLOSURE_v1.0.md`; 2 passing tests | The ruling is authored, not externally attested. |
| `QA-24` resolved | Ruling recorded in `BLOCKER_CLOSURE_v1.0.md` | No executable check exists. |
| `AS-09` accepted | Accepted by non-contradiction | The text of `AS-09` was never available. A standing review trigger applies. |
| Architecture Complete = YES | Self-assessment against `FAC-1130`–`FAC-1132` | Assessed against gates authored in the same effort, over chapters that are not yet files. |
| Implementation Ready = YES | Rests on §1 plus the rows above | Inherits their limitations. |
| `tool/module_dependencies.yaml` assertions (`ID-1`–`ID-9`, `CM-1`–`CM-3`, `AN-3`, `AU-2`–`AU-4`) | Declared in the manifest | **Declarative only.** No checker consumes the file; `tool/` contains no `check_module_boundaries.dart`. |
| Known internal inconsistency | — | `ERR-1113` names `X-DEVICE-REFUSED`, absent from the closed seven-member set in `ERR-1130`. Implemented per `ERR-1130`. Carried forward for a future reviewer. |

## 3. Approved validation report — transfer slot

<!-- ===== BEGIN APPROVED FINAL VALIDATION REPORT (REVISION 2) — PASTE VERBATIM BELOW ===== -->

<!-- ===== END APPROVED FINAL VALIDATION REPORT (REVISION 2) ===== -->

## 4. D-7 outcome

| Field | Value |
| --- | --- |
| D-7 status | **OPEN — NOT CLOSED** |
| Completed | Directory structure, `README.md`, eleven chapter transfer slots, this report shell |
| Not completed | Transfer of Chapters 1–11; transfer of Revision 2 |
| Blocked by | The approved text is not retrievable by the executing agent; supplying it from memory would violate D-7 rules 1, 3 and 7 |
| Input required | The approved chapter text, pasted or supplied as files, one chapter at a time or in full |
| Decision required | Approved title and filename for Chapter 10; correction of the D-7 file list from ten slots to eleven |
| Documentation lock | **Cannot be applied.** A lock over empty slots would be false. |

<!-- ===== END SOURCE: docs/prd/authentication/FINAL_VALIDATION_REPORT.md ===== -->
