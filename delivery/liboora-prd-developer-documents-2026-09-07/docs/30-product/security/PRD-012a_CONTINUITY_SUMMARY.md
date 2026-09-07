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
| **Version** | **v0.8** (Parts 1–8 written — document text complete) |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2 gate met**; Stages 3–9 not started |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None** — no security `BC-nn` exists (`SECP-GAP-010`, `SECP-GAP-041`) |
| **Prefix** | **`SECP-`** — ⚠ **not `SEC-`**, which collides with `INV-SEC-001`…`071` |
| **Rank** | **Unranked.** Not Rank 3. **MUST NOT** be cited against any ranked document |
| **Authority to exist** | `PRD_REGISTRY.md` §4.1 — *"may be opened without a further ADR"* → Rank 1 `MASTER_PRD.md` §8 Correction 2 |
| **Last updated** | 2026-08-21, after Part 8 |

---

## 1. Files that exist

| Part | File | Lines | State |
|---|---|---|---|
| **1** | [`PRD-012a_SECURITY_AUTOMATION.md`](./PRD-012a_SECURITY_AUTOMATION.md) | 550 | ✅ Committed `f15655f` |
| **2** | [`PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md`](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md) | 588 | ✅ Committed `e83ad29` |
| **3** | [`PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md`](./PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md) | 494 | ✅ Committed `12a55db` |
| **4** | [`PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md`](./PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md) | 429 | ✅ Committed `12a55db` |
| **5** | [`PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md`](./PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md) | 391 | ✅ Committed `33fbaef` |
| **6** | [`PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md`](./PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md) | 391 | ✅ Committed `33fbaef` |
| **7** | [`PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md`](./PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md) | 410 | ✅ Committed `33fbaef` |
| **8** | [`PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md`](./PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md) | 407 | ✅ Written (amended after commit) |
| — | This summary | — | ✅ Updated after Part 8 |

⚠ **Disclosure — three auto-backup commits.** Parts 1, 3–4 and 5–8 were captured by the platform's `genspark
auto-backup` before an authored commit could be made (`f15655f`, `12a55db`, `33fbaef`). Each was verified to contain
**only** the intended files and was **accepted, not amended** — rewriting history is prohibited. The cosmetic cost is
a generic commit message on those three commits.

---

## 2. Identifier registers — current state

**Measured, not asserted:** 15 registers, **427 identifiers**, all contiguous from `001`.

| Register | Meaning | Parts 1–2 | Parts 3–8 | **Total** | Next free |
|---|---|---|---|---|---|
| `SECP-OBJ-` | Security objective | 12 | — | **12** | `013` |
| `SECP-PRN-` | Core principle | 12 | — | **12** | `013` |
| `SECP-FR-` | Functional requirement | 18 | 66 (`019`–`084`) | **84** | `085` |
| `SECP-BR-` | Business rule | 8 | 17 (`009`–`025`) | **25** | `026` |
| `SECP-HRO-` | High-risk admin operation *(closed set)* | 12 | — | **12** | ⛔ closed |
| `SECP-XC-` | Exclusion | 18 | 19 (`019`–`037`) | **37** | `038` |
| `SECP-OWN-` | Ownership boundary | 15 | 15 (`016`–`030`) | **30** | `031` |
| `SECP-AC-` | Acceptance criterion | 41 | 87 (`042`–`128`) | **128** | `129` |
| `SECP-GAP-` | Gap / conflict / dependency | 21 | 23 (`022`–`044`) | **44** | `045` |
| `SECP-SIG-` | Security signal *(closed set, Part 5)* | — | 10 | **10** | ⛔ closed |
| `SECP-SEV-` | Alert severity class *(closed set, Part 5)* | — | 4 | **4** | ⛔ closed |
| `SECP-TST-` | Security test class *(closed set, Part 7)* | — | 8 | **8** | ⛔ closed |
| `SECP-TRC-` | Traceability record *(Part 8)* | — | 9 | **9** | `010` |
| `SECP-DEP-` | External dependency *(Part 8)* | — | 7 | **7** | `008` |
| `SECP-ADR-` | Required ADR *(request, not a decision)* | — | 5 | **5** | `006` |
| **Total** | | **157** | **270** | **427** | |

**Per-Part declaration counts (measured, range-filtered):** P1 72 · P2 85 · P3 41 · P4 48 · P5 51 · P6 43 · P7 54 ·
P8 33 = **427**.

**Still deliberately empty, each with a stated reason:** `SECP-INV-` (no owned aggregate — `SECP-GAP-010`),
`SECP-EVT-` (no `BC-nn` producer row — `SECP-OWN-023`), `SECP-CFG-` (would duplicate `PRD-001`/`PRD-023`
parameters — `SECP-XC-014`).

⚠ **Two counting rules, codified as `SECP-BR-025`.** (a) **A citation is not a declaration** — count only numbers
inside a Part's own declared range; a naive count over-reports because later Parts cite earlier ones. (b) **No Part
may write an identifier it does not declare**, including as a "reserved" or "not minted" note, because a
repository-wide search cannot distinguish such a note from a real declaration. Both rules were violated during
authoring and corrected before commit (Part 8 §1.3).

⚠ **Before adding any identifier:** re-run the collision procedure (`PRD_LIFECYCLE.md` §5 rules 2–3) against
`docs/ lib/ test/ tool/ packages/` using a **broad** probe (`[A-Za-z-]*PREFIX-[0-9]{3}`). Part 1 §0.4 records a
near-miss where a narrow grep would have licensed a colliding prefix.

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
- **Break-glass is PROHIBITED, not unsupported** — `AUTH-11.53`, `AUTH-11.54`, `AUD-XC-002`. Its operational
  consequence (no admin recovery path) is raised as `SECP-GAP-018`.
- **Step-up in V1 = re-assertion of the sole factor**, never a second factor (`SECP-BR-008`). `SECP-FR-018` is
  **`PENDING-AUTHORITY`** (`SECP-GAP-014`).

### Part 3 — Zero Trust, IAM & Multi-Tenant Security
- Zero Trust held **directional** (EA **V3**); the V1 slice is drawn *only* from V1-tagged sources.
- **Least-privilege *principle* (V1) separated from least-privilege *tooling* (EA V2)** → `SECP-GAP-022`.
- Tenant isolation: refuse without context; **`SECP-BR-009`** — *"Presence of a tenant identifier is not evidence of
  entitlement."* Per-operation cross-tenant test; indistinguishable refusal.
- **`SECP-GAP-023`** — `MP-RSK-01` (cross-tenant leak, **Critical**) vs EA `Cross-Tenant Leak Tests` **V2**.
  **Recorded, not resolved.**
- Fail-closed: **`SECP-BR-010`** — *"A control that has never been observed to refuse is not known to work."*
- Service-to-service trust **directional only**; trust signals form a closed set — *"Trust signals inform; they
  never decide."*

### Part 4 — Application, API, Session & Data Security
- **`SECP-OWN-019`** — rate limiting, brute force, replay and session protection are **`PRD-001` §8's**
  (`AUTH-8.16`…`8.39`). Part 4 **tabulates and cites; it never restates.**
- Non-authentication abuse limits **adopt four `PRD-001` properties by reference** rather than rewriting them.
- **`SECP-BR-012`** — *"A field a client can set is a field an attacker can set."*
- **`SECP-BR-013`** — *"Validation is a gate, not a filter."* **`SECP-BR-014`** — *"A session's continued existence
  is not evidence of continued entitlement."*
- OWASP Top 10 requires a **stated position** per item — never a claim of immunity.

### Part 5 — Threat Detection, Monitoring & Alerts
- **`Brute Force Protection` is the only V1 member** of EA's Threat Detection subtree; anomaly, bot, takeover, SIEM
  and posture detection held at **V2/V3**.
- **`SECP-SIG-001`…`010`** (closed signal set) and **`SECP-SEV-001`…`004`** (closed severity set) introduced.
- **`SECP-BR-015`** — *"An absent detection MUST be recorded as absent, never as a threshold not yet reached."*
- **`SECP-BR-017`** — *"Refusal is not detection."*
- **`SECP-GAP-031`** — Rank 3 `AUTH-11.26`/`11.27`/`11.28` require alertability; EA (Rank 6) tags `Alerting` **V2**.
  Part 5 requires only that signals exist and are severity-classified, and **raises the conflict** per
  `DOCUMENTATION_BASELINE.md` L253. **Not resolved.**

### Part 6 — Security Automation & Incident Response
- Two hard boundaries: automation may **only invoke an existing V1 capability owned elsewhere** (`SECP-BR-018`), and
  **no orchestration** — that is `BC-28`'s and **V2** (`SECP-XC-030`).
- **Four-response closed set**, deliberately **order-independent so no workflow engine is required** — which is what
  lets Part 6 exist at V1 without promoting `BC-28`.
- **`SECP-BR-020`** — *"Automation may restrict; it may never permit."* **`SECP-BR-019`** — fail-safe, not fail-open.
- Severity **reused from Part 5**; no second scale. Successful containment does **not** suppress escalation.
- `SECP-GAP-032` no playbooks · `SECP-GAP-033` no forensics · **`SECP-GAP-034` no breach-notification path**.

### Part 7 — Audit, Vulnerability Management, Testing & Resilience
- **`SECP-TST-001`…`008`** — eight test classes, each bound to earlier Parts' requirements; each requires at least
  one **negative** case.
- **`SECP-FR-073`** — no own audit copy, and no read/search/export surface (`BC-24` owns the record).
- **`SECP-FR-077`** — internal adversarial tests **MUST NOT** be described, in any document or acceptance record, as
  a penetration test or third-party assurance. Penetration testing is EA **V3** (`SECP-XC-035`).
- **`SECP-GAP-037`** — dependency pinning gives **integrity, not a vulnerability signal**.
- `check_module_boundaries.dart` exits 1 with 9 violations **by design** (`ADR-0012`); Part 7 does **not** require
  exit 0.

### Part 8 — Final Requirements, Traceability & Acceptance
- The 15-register census, per-Part counts, and the coverage table — **all measured, not asserted**.
- 9 `SECP-TRC-*` traceability records · 7 `SECP-DEP-*` external dependencies · **5 `SECP-ADR-*` required ADRs**.
- **`SECP-ADR-*` is a *request for* an ADR, never an ADR.** `ADR-0060` measured as next free and **deliberately not
  assigned**.
- `SECP-GAP-041` no bounded context · **`SECP-GAP-042` no `platform/security` block in
  `tool/module_dependencies.yaml`** while `default_decision: deny` stands · `SECP-GAP-043` `SECP-FR-018`
  `PENDING-AUTHORITY` · `SECP-GAP-044` registry stale.
- **Explicitly NOT delivered:** no security claim, no V2/V3 promotion, no frozen document modified, no status, rank,
  baseline or freeze, no Stage 5 registration, **no conflict resolved**.

---

## 4. Open gaps — 44, all OPEN

| Priority | IDs |
|---|---|
| **High** | `001` Zero Trust=V3 · `003` WAF/DDoS=V2 · `004` Threat Detection=V2 · `005` support-access list undefined · `006` **live `X-13` code exposure `D-016-01`** · `007` Incident Response=V2 (DPDP statutory) · `009` supply-chain=V2 · `014` `SECP-FR-018` authority · `015` single-factor replay · `017` no admin hardening · `018` **no admin recovery path** · `021` support-access list · `023` **cross-tenant leak tests=V2 vs `MP-RSK-01` Critical** · `026` minor-data protection=V2 vs `MP-RSK-02` Critical · `029` no account-takeover detection (SIM-swap) · `031` **alertability Rank 3 vs `Alerting` V2** · `034` no breach-notification path · `035` `AUTH-11.59` recovery-exercise undischarged · `036` no vulnerability programme · `038` no independent security assessment · `042` **no `platform/security` manifest block** · `043` `SECP-FR-018` pending |
| **Medium** | `002` least-privilege tooling=V2 · `008` DR=V3 · `010` no aggregate/`BC-nn` · `011` no security configurable · `012` `PRD-012` retirement not executed · `016` collusion undetectable · `019` admin panel undefined · `020` client concealment ≠ enforcement · `022` least-privilege tooling · `024` no secret rotation at V1 · `025` no distributed/network-layer rate control · `027` no sensitive-field classification · `028` volume-not-anomaly detection · `030` no signal correlation · `032` no playbooks · `033` no forensics · `037` pinning ≠ vulnerability signal · `039` no infrastructure baseline · `040` audit coverage asserted not verified · `041` no bounded context |
| **Low** | `013` register counts stale · `044` registry stale |

**Blocking-style items to respect when resuming:**
1. `SECP-FR-018` **MUST NOT** be implemented until `BC-18`'s owner rules on `SECP-GAP-014`.
2. `SECP-AC-018` / `SECP-AC-030` **cannot pass** while `D-016-01` stands (routed to `IMPL-922`).
3. **`SECP-GAP-042`** — Parts 3–7 assume `platform/security` may reach `BC-18`, `BC-24`, `BC-22` and `BC-25`; none
   is declared and `default_decision: deny` stands. Implementation is blocked until the Architecture Owner acts
   (`SECP-ADR-004`).

---

## 5. Standing constraints — still binding for any amendment

1. **Never** promote an EA V2/V3 capability to V1 — record a gap (`DOCUMENTATION_BASELINE.md` L253).
2. **Never** introduce an authentication factor — `MP-CON-11`, `MP-GBR-25`, `SECP-XC-005`.
3. **Never** define roles, permissions, policy or sessions — `BC-18` owns them (`SECP-XC-006`).
4. **Never** own audit, logging, isolation, CI/CD or workflow — `SECP-XC-004`, `007`, `008`, `009`, `017`, `030`.
5. **Never** produce or cache an authorisation outcome — `SECP-XC-003`.
6. No tables, APIs, SQL, code, UI, cloud resources or crypto internals.
7. Every normative requirement gets a **measurable** criterion; re-run the **paragraph-aware** coverage check after
   any change — a line-based check yields both false negatives and missed defects.
8. Do not edit `PRD_REGISTRY.md` / `PRD_OWNERSHIP_MODEL.md` — `SECP-GAP-012`/`013`/`044` are the Governance Owner's.
9. **Never renumber, reword or withdraw an existing identifier** (`SECP-FR-083`); continue from §2's next-free column.

---

## 6. Lifecycle position

| Stage | State |
|---|---|
| 1 Discovery | ⚠ Gate **not met as written** (no `BC-nn`); proceeding on `PRD_REGISTRY.md` §4.1 |
| 2 Draft | ✅ **Gate met** — document on disk, versioned headers, registers declared (`PRD_LIFECYCLE.md` L47). Parts 1–8 of 8 |
| 3 Review | ⬜ Not started — requires the Security Owner, plus rulings on `SECP-GAP-023`, `031`, `042` |
| 4 Testability | ⬜ Not started — 128 criteria written, **0 proven** |
| 5 Registration | ⬜ Not started — `SECP-` **not** in `TRACEABILITY_MATRIX.md` (`SECP-DEP-006`) |
| 6–9 | ⬜ Not started — no `IMPL-*` range · no baseline row · **unranked** · freeze is conferred, never claimed |

## 7. Change history

| Version | Date | Change |
|---|---|---|
| v0.2 | 2026-08-21 | **Created** alongside Part 2. Records Parts 1–2, the 157-identifier register state, 21 open gaps and the standing constraints. Discloses that no prior summary existed. |
| v0.8 | 2026-08-21 | Updated after **Parts 3–8**, completing the document text. Register state **measured** at **427 identifiers across 15 registers, all contiguous** (four new closed/record registers: `SIG`, `SEV`, `TST`, plus `TRC`/`DEP`/`ADR`). Gap register grown to **44**. Records the Part 3–8 decisions, the two counting rules now codified as `SECP-BR-025`, the three `genspark auto-backup` commits, and the three unresolved conflicts (`SECP-GAP-023`, `031`, `042`) raised rather than decided. Lifecycle: **Stage 2 gate met**; Stages 3–9 not started; 0 of 128 criteria proven. |
