# PRD-012a — Continuity Summary

> **Purpose.** A compact, current statement of what `PRD-012a` is, what exists, what each Part decided, and what is
> open — so that authoring can resume without re-reading the full Parts.
>
> ⚠ **This file is a navigation aid. It is NOT an authority.** It confers no status, creates no identifier and
> overrides nothing. Where it and a Part disagree, **the Part governs**. Where a Part and a ranked document
> disagree, **the ranked document governs**.

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Security Automation |
| **Version** | **v0.2** (Parts 1–2 written) |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2, incomplete** (Parts 3–8 unwritten) |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None** — no security `BC-nn` exists (`SECP-GAP-010`) |
| **Prefix** | **`SECP-`** — ⚠ **not `SEC-`**, which collides with `INV-SEC-001`…`071` |
| **Rank** | **Unranked.** Not Rank 3. **MUST NOT** be cited against any ranked document |
| **Authority to exist** | `PRD_REGISTRY.md` §4.1 — *"may be opened without a further ADR"* → Rank 1 `MASTER_PRD.md` §8 Correction 2 |
| **Last updated** | 2026-08-21, after Part 2 |

---

## 1. Files that exist

| Part | File | Lines | State |
|---|---|---|---|
| **1** | [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md) | 550 | ✅ Written, committed `f15655f` |
| **2** | [`PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md) | ~585 | ✅ Written |
| — | This summary | — | ✅ Written |
| **3–8** | — | — | ⬜ **Not written** |

⚠ **Disclosure.** No continuity summary existed before Part 2; the Part 2 request referred to one as if it did.
This file was **created**, not updated, and its "update" for Part 2 is its initial content.

---

## 2. Identifier registers — current state

| Register | Meaning | Part 1 | Part 2 | **Total** | Next free |
|---|---|---|---|---|---|
| `SECP-OBJ-` | Security objective | 12 (`001`–`012`) | — | **12** | `013` |
| `SECP-PRN-` | Core principle | 12 (`001`–`012`) | — | **12** | `013` |
| `SECP-FR-` | Functional requirement | 0 | 18 (`001`–`018`) | **18** | `019` |
| `SECP-BR-` | Business rule | 0 | 8 (`001`–`008`) | **8** | `009` |
| `SECP-HRO-` | High-risk admin operation *(closed set)* | — | 12 (`001`–`012`) | **12** | `013` |
| `SECP-XC-` | Exclusion | 10 (`001`–`010`) | 8 (`011`–`018`) | **18** | `019` |
| `SECP-OWN-` | Ownership boundary | 11 (`001`–`011`) | 4 (`012`–`015`) | **15** | `016` |
| `SECP-AC-` | Acceptance criterion | 14 (`001`–`014`) | 27 (`015`–`041`) | **41** | `042` |
| `SECP-GAP-` | Gap / conflict / dependency | 13 (`001`–`013`) | 8 (`014`–`021`) | **21** | `022` |
| **Total** | | **72** | **85** | **157** | |

**Still deliberately empty:** `SECP-INV-` (no owned aggregate), `SECP-EVT-` (no `BC-nn` producer row),
`SECP-CFG-` (every parameter needed is already a `PRD-001` `CFG-*`; a duplicate would create a second source of
truth).

⚠ **Before adding any identifier:** re-run the collision procedure (`PRD_LIFECYCLE.md` §5 rules 2–3) against
`docs/ lib/ test/ tool/ packages/`. Part 1 §0.4 records a near-miss where a narrow grep would have licensed a
colliding prefix.

---

## 3. What each Part decided

### Part 1 — Security Vision, Scope & Objectives
- **Prevent → Detect → Contain → Respond → Recover** as the objective model. **No "hack-proof" claim** (§2.2).
- 12 objectives, 12 principles — but **4 principles are DIRECTIONAL, not V1**: Zero Trust (EA **V3**), Security
  Monitoring, Incident Readiness, Resilience/Recovery (EA **V2/V3**).
- V1 scope = **only** the 8 EA-tagged-V1 capabilities. Ownership assigned per the **Single Owner Rule**.
- This module is an **enforcer and port provider**, not a holder of domain state.

### Part 2 — Platform Admin Security & Privileged Access
- **`SECP-HRO-001`…`012`** — the closed set of high-risk admin operations (modelled on `PRD-003` `SPO-1`…`9`).
- 18 `SECP-FR-*` + 8 `SECP-BR-*`, **all 26 bound to criteria; 0 of 27 proven**.
- **Break-glass is PROHIBITED, not unsupported** — `AUTH-11.53`, `AUTH-11.54`, `AUD-XC-002`. Its operational
  consequence (no admin recovery path) is raised as `SECP-GAP-018`.
- **Step-up in V1 = re-assertion of the sole factor**, never a second factor (`SECP-BR-008`). `SECP-FR-018` is
  **`PENDING-AUTHORITY`** (`SECP-GAP-014`) — it may belong to `PRD-001`.
- **Platform Admin Panel is undefined repo-wide** → surface-agnostic properties only (`SECP-GAP-019`).

---

## 4. Open gaps — 21, all OPEN

| Priority | IDs |
|---|---|
| **High** | `001` Zero Trust=V3 · `003` WAF/DDoS=V2 · `004` Threat Detection=V2 · `005` support-access list undefined · `006` **live `X-13` code exposure `D-016-01`** · `007` Incident Response=V2 (DPDP statutory) · `009` supply-chain=V2 · `014` `SECP-FR-018` authority · `015` single-factor replay · `017` no admin hardening · `018` **no admin recovery path** · `021` support-access list (inherits `005`) |
| **Medium** | `002` least-privilege tooling=V2 · `008` DR=V3 · `010` no aggregate/`BC-nn` · `011` no security configurable · `012` `PRD-012` retirement not executed · `016` collusion undetectable · `019` admin panel undefined · `020` client concealment ≠ enforcement |
| **Low** | `013` register counts stale |

**Two blocking-style items to respect when resuming:**
1. `SECP-FR-018` **MUST NOT** be implemented until `BC-18`'s owner rules on `SECP-GAP-014`.
2. `SECP-AC-018` / `SECP-AC-030` **cannot pass** while `D-016-01` stands (routed to `IMPL-922`).

---

## 5. Standing constraints for Parts 3–8

1. **Never** promote an EA V2/V3 capability to V1 — record a gap (`DOCUMENTATION_BASELINE.md` L253).
2. **Never** introduce an authentication factor — `MP-CON-11`, `MP-GBR-25`, `SECP-XC-005`.
3. **Never** define roles, permissions, policy or sessions — `BC-18` owns them (`SECP-XC-006`).
4. **Never** own audit, logging, isolation, CI/CD or workflow — `SECP-XC-004`, `007`, `008`, `009`, `017`.
5. **Never** produce or cache an authorisation outcome — `SECP-XC-003`.
6. No tables, APIs, SQL, code, UI, cloud resources or crypto internals.
7. Every normative requirement gets a **measurable** criterion.
8. Do not edit `PRD_REGISTRY.md` / `PRD_OWNERSHIP_MODEL.md` — `SECP-GAP-012`/`013` are the Governance Owner's.

---

## 6. Lifecycle position

| Stage | State |
|---|---|
| 1 Discovery | ⚠ Gate **not met as written** (no `BC-nn`); proceeding on `PRD_REGISTRY.md` §4.1 |
| 2 Draft | **In progress** — Parts 1–2 of 8 |
| 3–9 | **Not started.** `SECP-` **not** in `TRACEABILITY_MATRIX.md` (Stage 5) · no `IMPL-*` range · no baseline row · **unranked** |

## 7. Change history

| Version | Date | Change |
|---|---|---|
| v0.2 | 2026-08-21 | **Created** alongside Part 2. Records Parts 1–2, the 157-identifier register state, 21 open gaps and the standing constraints. Discloses that no prior summary existed. |
