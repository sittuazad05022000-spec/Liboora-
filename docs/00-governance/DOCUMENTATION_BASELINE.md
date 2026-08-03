# Liboora — Documentation Baseline Declaration

| Field | Value |
|---|---|
| **Baseline** | **BASELINE-2026-08-02** |
| **Status** | **Locked** |
| **Date** | 2026-08-02 |
| **Declared by** | Enterprise Architecture review (`DOCUMENTATION_AUDIT-001`) |
| **Authority** | `ADR-0008` |

---

## 1. What this document does

This document declares the **official documentation baseline** for the Liboora platform. It fixes, at one point in
time, which documents are authoritative, at which versions, and in what order of precedence. Every other document
in the repository is either **in the baseline**, **superseded by it**, or **archived**.

Its purpose is to remove the question *"which document do I believe?"* from the developer's day.

---

## 2. Baseline declaration

**Authentication PRD v2.0 is the official baseline specification for `BC-18` Identity & Access.**

Defect `D-7` — *"the Authentication PRD is not present in this repository"* — is **CLOSED**.

It is closed **by authorship, not by recovery.** The original v1 text was sought and is not in the repository, not
in git history, and not recoverable from any versioned artefact. v2.0 was written from scratch against the binding
constraints that *were* present. It does not reproduce v1 and makes no claim about what v1 contained. Full
reasoning is recorded in [`ADR-0008`](./adr/ADR-0008-authentication-prd-v2-baseline.md).

**If the original v1 ever resurfaces it has no standing.** Reinstating any part of it would require a new ADR.

---

## 3. Baseline contents

### 3.1 Governance

| Document | Version | Status |
|---|---|---|
| `00-governance/DOCUMENTATION_BASELINE.md` | BASELINE-2026-08-02 | **This document** |
| `00-governance/adr/ADR-INDEX.md` | Active | Authoritative |
| `00-governance/adr/ADR-0001` … `ADR-0008` | Accepted | Authoritative, binding |
| `00-governance/DOCUMENTATION_AUDIT-001.md` | 001 | Historical record of this review |

### 3.2 Architecture

| Document | Version | Status |
|---|---|---|
| `10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | v1.2 | Authoritative — boundaries, ownership, edges |
| `10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | v1.0 | Authoritative — permitted and forbidden dependencies |
| `10-architecture/ARCHITECTURE_RULINGS.md` | v1.1 | Authoritative for `AR-1`, `AR-3`, `AR-4`; `AR-2`, `AR-5`, `AR-6`, `AR-7` promoted to ADRs |
| `10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | **v2.1** | **Descriptive** — must follow the PRDs, never lead them |

### 3.3 Product

| Document | Version | Status |
|---|---|---|
| `30-product/MASTER_PRD.md` | v1.4 | Authoritative — platform-wide global rules |
| `30-product/authentication/Authentication_PRD_v2.md` | **v2.0** | **Authoritative — the baseline** |
| `30-product/authentication/prd-v2/00` … `11` | v2.0 | Chapter sources of the above |
| `30-product/authentication/PRD-V2-GOVERNANCE-NOTE.md` | v2.0 | Provenance record — **not part of the specification** |
| `30-product/library/` | Incomplete | §14A only; §§1–25 never supplied |

### 3.4 Configuration and implementation

| Document | Version | Status |
|---|---|---|
| `20-configuration/CONFIGURATION_GUIDE.md` | v1.0 | Normative for operations |
| `40-implementation/DEVELOPER_HANDOFF.md` | v1.0 | Entry point for developers |
| `40-implementation/IMPLEMENTATION_ROADMAP.md` | v1.0 | Sequenced work |
| `40-implementation/AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` | v1.0 | Per-requirement checklist |
| `40-implementation/TASK-D10-remove-demo-surfaces.md` | v1.0 | Release-blocking task |
| `40-implementation/DEFINITION_OF_DONE.md` | v1.0 | Merge and release gates |
| `40-implementation/TRACEABILITY_MATRIX.md` | v1.0 | Requirement → artefact mapping |

### 3.5 Archived — no authority

| Document | Reason |
|---|---|
| `90-archive/authentication-v1/Authentication_PRD.md` | v1 stub; eleven empty slots; superseded by v2.0 |
| `90-archive/authentication-v1/Authentication_PRD_Developer_Guide.md` | Written against the absent v1; every claim of absence is now false |
| `90-archive/authentication-v1/01-*.md` … `11-*.md` | The eleven empty slots |

Archived documents are **retained for history and must not be cited as authority.** Each carries a header saying
so.

---

## 4. Precedence

When two documents disagree, the higher rank wins. This order is not negotiable at implementation time.

| Rank | Source | Scope |
|---|---|---|
| **1** | `MASTER_PRD.md` global rules — `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` | Platform-wide. Outranks every module PRD |
| **2** | Accepted ADRs (`ADR-0001` … `ADR-0008`) | Structural decisions |
| **3** | **Authentication PRD v2.0** | Everything inside `BC-18` |
| **4** | Bounded Context Map · Module Dependency Matrix | Boundaries, ownership, permitted edges |
| **5** | Architecture Rulings `AR-1`, `AR-3`, `AR-4` | Domain classifications not promoted to ADRs |
| **6** | Enterprise Architecture v2.1 | **Descriptive only.** Update it to match 1–5; never the reverse |
| **7** | Configuration Guide | Operating values within the envelope 1–3 define |

**A conflict is a defect.** If you find one, do not choose — raise it. The precedence order tells you which
document is *wrong*, not which one to quietly ignore.

---

## 5. Terms fixed by this baseline

| Term | Means |
|---|---|
| "The Authentication PRD" | Authentication PRD **v2.0**, and nothing else |
| "The specification" (in an authentication context) | Authentication PRD v2.0 |
| "The rulings" | `ARCHITECTURE_RULINGS.md` v1.1, noting four are promoted to ADRs |
| "The BC Map" | `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.2 |
| "The EA" | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` v2.1 |

---

## 6. Known gaps carried by this baseline

These are **declared, not hidden.** The baseline is complete for authentication implementation and incomplete
elsewhere. Full detail and priority in `DEVELOPER_HANDOFF.md` §7.

| Gap | Effect | Priority |
|---|---|---|
| Library PRD §§1–25 never supplied | Library module cannot be implemented beyond §14A | **P1** — blocks the Library module only |
| Invitation security specification (`AR-4`) never written | Private-library invitations cannot be implemented | **P1** — blocks private libraries |
| `tool/check_module_boundaries.dart` does not exist | Module boundaries are unenforced; `ADR-0001` is advisory in practice | **P1** — implementation task `IMPL-014` |
| `D-10` demo surfaces present in code | **Release blocker** under `MP-CON-11` | **P0** — task `TASK-D10` |
| `D-8`, `D-9`, `R-5` | Carried forward unchanged | P2 |
| Development Standards document (`R-4`) | Deferred | P3 |

---

## 7. Changing the baseline

1. A change to any Rank 1–5 document requires an ADR **before** the change.
2. The changed document's version is incremented and its changelog updated in the same commit.
3. This declaration is updated in the same commit. A baseline that does not match the repository is worse than no
   baseline.
4. The baseline identifier changes only when a Rank 1–3 document changes version.

---

## 8. Changelog

| Baseline | Date | Change |
|---|---|---|
| **BASELINE-2026-08-02** | 2026-08-02 | Initial declaration. Authentication PRD v2.0 declared official; `D-7` closed by authorship; EA raised to v2.1; `CFG-3`, `CFG-4`, `CFG-5`, `CFG-6`, `CFG-7`, `CFG-12` reset to standards-anchored defaults; `ADR-0001`…`ADR-0008` accepted; twelve stale documents corrected or archived. |
