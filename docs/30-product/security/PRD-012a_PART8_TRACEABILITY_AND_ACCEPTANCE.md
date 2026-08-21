# PRD-012a — Security Automation

> **PART 8 of 8 — Final Security Requirements, Traceability & Acceptance.**
> Parts 1–7 are in this directory and **none is modified by this document**:
> [Part 1](./PRD-012a_SECURITY_AUTOMATION.md) ·
> [Part 2](./PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md) ·
> [Part 3](./PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md) ·
> [Part 4](./PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md) ·
> [Part 5](./PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md) ·
> [Part 6](./PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md) ·
> [Part 7](./PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md).

| Field | Value |
|---|---|
| **PRD** | `PRD-012a` — Part 8 |
| **Module** | Security Automation |
| **Version** | **v0.8** (Part 8 added; Parts 1–7 unchanged). **`PRD-012a` Parts 1–8 are now complete** |
| **Status** | **`DRAFT`** — `PRD_LIFECYCLE.md` **Stage 2 complete**. Stages 3–7 **not run**. **This document confers no status on itself** |
| **Owning platform** | **SECURITY PLATFORM** — `[GENERIC]`, rank **2** |
| **Owning bounded context** | **None.** Part 1 §0.5; `SECP-GAP-010` |
| **Module path** | `platform/security` (rank **2**) |
| **Product version** | **V1** |
| **Requirement prefix** | **`SECP-`**. **Three new registers `SECP-TRC-`, `SECP-DEP-`, `SECP-ADR-`**, collision-checked in §0.4 |
| **Rank** | **Unranked.** **MUST NOT** be cited as authority against any ranked document |
| **Date** | 2026-08-21 |
| **Written at** | `12a55dbdfb64e7a91d00022220603c389f5c890b` |

---

## 0. How to read Part 8

### 0.1 Normative language

As Part 1 §0.1. Part 8 declares very few new normative requirements by design: its job is to **verify** Parts 1–7,
not to extend them.

### 0.2 What Part 8 does, and does not, do

| Part 8 does | Part 8 does **not** |
|---|---|
| Verify identifier continuity and register counts across Parts 1–8 | Renumber, reword or withdraw any existing identifier |
| Publish the traceability of every register to its authority | Register `SECP-*` in `TRACEABILITY_MATRIX.md` — that is **Stage 5** |
| Consolidate all 44 gaps and route each to an owner | Close a gap, or resolve a conflict it recorded |
| **Identify the ADRs this PRD requires** | Write, accept or number an ADR — that is the Architecture Owner's act |
| Confirm every normative requirement has a measurable criterion | Confer a status, a rank, a baseline or a freeze on `PRD-012a` |

### 0.3 Identifier registers — Part 8's ranges

| Register | Meaning | Parts 1–7 | **Part 8** | Part 8 range |
|---|---|---|---|---|
| `SECP-FR-NNN` | Functional security requirement | 82 | **2** | `083`…`084` |
| `SECP-BR-NNN` | Business rule | 24 | **1** | `025` |
| `SECP-AC-NNN` | Acceptance criterion | 123 | **4** | `124`…`127` |
| `SECP-GAP-NNN` | Gap / open question | 40 | **4** | `041`…`044` |
| `SECP-TRC-NNN` | **Traceability record** *(new)* | — | **9** | `001`…`009` |
| `SECP-DEP-NNN` | **External dependency** *(new)* | — | **7** | `001`…`007` |
| `SECP-ADR-NNN` | **Required ADR** *(new)* | — | **5** | `001`…`005` |
| `SECP-XC-`, `SECP-OWN-`, `SECP-OBJ-`, `SECP-PRN-`, `SECP-HRO-`, `SECP-SIG-`, `SECP-SEV-`, `SECP-TST-` | — | as measured | **0** | — |

**Part 8 declares 32 identifiers. `PRD-012a` total: 426.**

### 0.4 Prefix collision check — three new registers

Checked repository-wide **before** writing, per `PRD_LIFECYCLE.md` §5 rule 2, using the broad-probe form Part 1 §0.4
established after the `SEC-` near-miss:

| Candidate | Broad probe | Result | Verdict |
|---|---|---|---|
| `SECP-TRC-` | `[A-Za-z-]*TRC-[0-9]+` | **0** | **FREE — selected** |
| `SECP-DEP-` | `[A-Za-z-]*DEP-[0-9]+` | **0** | **FREE — selected** |
| `SECP-ADR-` | `[A-Za-z-]*ADR-[0-9]+` | **0** | **FREE — selected** |

> ⚠ **`SECP-ADR-` is confusable with the governance `ADR-nnnn` series** (`ADR-0001`…`ADR-0059`). They do not collide
> — the governance series is unprefixed and four-digit — but the risk is recorded now, per `TRACEABILITY_MATRIX.md`
> §2A.1. **A `SECP-ADR-*` is a *request for* an ADR, never an ADR.** It confers nothing and decides nothing.

---

## 1. Identifier continuity — measured, not asserted

### 1.1 Register census

Every register was counted by measurement across `docs/30-product/security/`, not by summing the Parts' own claims:

| Register | Range | Max | Count | Contiguous? | Declaring Parts |
|---|---|---|---|---|---|
| `SECP-OBJ-` | `001`…`012` | `012` | **12** | ✅ | 1 |
| `SECP-PRN-` | `001`…`012` | `012` | **12** | ✅ | 1 |
| `SECP-FR-` | `001`…`084` | `084` | **84** | ✅ | 2, 3, 4, 5, 6, 7, 8 |
| `SECP-BR-` | `001`…`025` | `025` | **25** | ✅ | 2, 3, 4, 5, 6, 7, 8 |
| `SECP-HRO-` | `001`…`012` | `012` | **12** | ✅ | 2 *(closed set)* |
| `SECP-XC-` | `001`…`037` | `037` | **37** | ✅ | 1, 2, 3, 4, 5, 6, 7 |
| `SECP-OWN-` | `001`…`030` | `030` | **30** | ✅ | 1, 2, 3, 4, 5, 6, 7 |
| `SECP-AC-` | `001`…`127` | `127` | **127** | ✅ | 1, 2, 3, 4, 5, 6, 7, 8 |
| `SECP-GAP-` | `001`…`044` | `044` | **44** | ✅ | 1, 2, 3, 4, 5, 6, 7, 8 |
| `SECP-SIG-` | `001`…`010` | `010` | **10** | ✅ | 5 *(closed set)* |
| `SECP-SEV-` | `001`…`004` | `004` | **4** | ✅ | 5 *(closed set)* |
| `SECP-TST-` | `001`…`008` | `008` | **8** | ✅ | 7 *(closed set)* |
| `SECP-TRC-` | `001`…`009` | `009` | **9** | ✅ | 8 |
| `SECP-DEP-` | `001`…`007` | `007` | **7** | ✅ | 8 |
| `SECP-ADR-` | `001`…`005` | `005` | **5** | ✅ | 8 |
| **TOTAL** | | | **426** | | |

`PRD_LIFECYCLE.md` §5 rule 4 requires contiguity — *"a gap makes the published range false."* **All fifteen registers
are contiguous with no holes.**

### 1.2 Per-Part declaration counts

| Part | Declares | Registers touched |
|---|---|---|
| Part 1 | **72** | `OBJ`, `PRN`, `XC`, `OWN`, `AC`, `GAP` |
| Part 2 | **85** | `FR`, `BR`, `HRO`, `XC`, `OWN`, `AC`, `GAP` |
| Part 3 | **41** | `FR`, `BR`, `XC`, `OWN`, `AC`, `GAP` |
| Part 4 | **48** | `FR`, `BR`, `XC`, `OWN`, `AC`, `GAP` |
| Part 5 | **51** | `FR`, `BR`, `XC`, `OWN`, `AC`, `GAP`, `SIG`, `SEV` |
| Part 6 | **43** | `FR`, `BR`, `XC`, `OWN`, `AC`, `GAP` |
| Part 7 | **54** | `FR`, `BR`, `XC`, `OWN`, `AC`, `GAP`, `TST` |
| Part 8 | **32** | `FR`, `BR`, `AC`, `GAP`, `TRC`, `DEP`, `ADR` |
| **Total** | **426** | 15 registers |

### 1.3 Two counting rules that were applied, and why they matter

`SECP-BR-025` — **A citation is not a declaration, and a "not declared" note must not mint an identifier.** Any count
of a Part's identifiers **SHALL** include only numbers inside that Part's declared range; out-of-range occurrences are
citations of earlier Parts. Further, no Part **SHALL** write an identifier it does not declare — including as a
"reserved" or "not minted" annotation — because a repository-wide search cannot distinguish such a note from a real
declaration.

> ⚠ **Both halves of this rule were violated during authoring and both were corrected before commit.** Part 4's first
> draft wrote a reserved placeholder in the functional-requirement register one number past its own declared maximum,
> and Part 7's first draft wrote a "not declared" annotation in the cross-cutting-exclusion register one number past
> its own declared maximum. Each would have made a repository-wide search report an identifier that no requirement
> backed, and the first would additionally have collided with the number Part 5 later declared for real. Both were
> replaced with prose that names no identifier, and this paragraph deliberately describes their positions rather than
> reproducing the tokens — writing them here would re-commit the same defect. Recorded rather than quietly fixed,
> because the defect class is exactly what `PRD_LIFECYCLE.md` §5 rule 2 exists to prevent.

`SECP-FR-083` — Every future amendment to `PRD-012a` **SHALL** continue the registers in §1.1 from their stated
maxima, **SHALL NOT** renumber, reword or withdraw an existing identifier, and **SHALL** re-verify contiguity after
the change. *`PRD_LIFECYCLE.md` §5 rules 1 and 4; and L177's rule that a frozen PRD is never silently modified,
which will bind once a freeze is conferred.*

---

## 2. Traceability

Each register traces to the authority that licenses it. **This is not Stage 5 registration** — `SECP-*` is still
absent from `TRACEABILITY_MATRIX.md`, and Part 8 does not add it (`SECP-DEP-006`).

| ID | Register | Traces to | Rank of authority |
|---|---|---|---|
| `SECP-TRC-001` | `SECP-OBJ-`, `SECP-PRN-` | `MASTER_PRD.md` **L168** module 16 *Security & Automation*; **L182 §8 Correction 2** (the two-owner split) | **Rank 1** |
| `SECP-TRC-002` | `SECP-FR-`, `SECP-BR-` | `MP-NFR-05` (Security → SECURITY), `MP-GBR-06`…`09`, `MP-NFR-12`; and for each requirement, the V1-tagged EA node cited in its text | Rank 1 / Rank 6 |
| `SECP-TRC-003` | `SECP-XC-`, `SECP-OWN-` | BC Map **v1.8** L96-140 (31 contexts, none security); EA **L2404** Single Owner Rule; `ADR-0013` context-vs-aggregate | Rank 4 / Rank 6 / Rank 2 |
| `SECP-TRC-004` | `SECP-HRO-` | `PRD-003` §5.1's `SPO-1`…`SPO-9` closed-set precedent; `PRD-001` `PR-1`/`PR-2` closed role set | **Rank 3** |
| `SECP-TRC-005` | `SECP-SIG-` | `AUTH-8.27`, `AUTH-11.26`…`11.28` (alertability); BC Map **L133** (`BC-24` records *"including AI actions and support access"*) | Rank 3 / Rank 4 |
| `SECP-TRC-006` | `SECP-SEV-` | `AUTH-11.27`, `AUTH-11.28` (*"immediately, with no threshold"*); `MP-RSK-01` **Critical**; `X-13` | Rank 3 / Rank 1 |
| `SECP-TRC-007` | `SECP-TST-` | `PRD_LIFECYCLE.md` Stage 4 (*"every requirement testable"*); Stage 4's exclusion rule (*"states what must be impossible"*) | procedural |
| `SECP-TRC-008` | `SECP-AC-` | `PRD_LIFECYCLE.md` Stage 4; `DEFINITION_OF_DONE.md`; the user requirement that every normative requirement carry measurable AC | procedural |
| `SECP-TRC-009` | `SECP-GAP-`, `SECP-DEP-`, `SECP-ADR-` | `DOCUMENTATION_BASELINE.md` **L253** — *"A conflict is a defect. If you find one, do not choose — raise it."* | **Rank 0 governance** |

### 2.1 Cross-Part traceability — the five-stage model

Part 1 §2.3 fixed the model **Prevent → Detect → Contain → Respond → Recover**. It is preserved, and every stage has
an owning Part:

| Stage | Parts | Principal requirements |
|---|---|---|
| **Prevent** | 2, 3, 4 | `SECP-FR-001`…`046` — privilege model, isolation, fail-closed, request boundary |
| **Detect** | 5 | `SECP-FR-047`…`057`, `SECP-SIG-001`…`010`, `SECP-SEV-001`…`004` |
| **Contain** | 6 | `SECP-FR-058`…`066` |
| **Respond** | 6 | `SECP-FR-067`…`069` |
| **Recover** | 6, 7 | `SECP-XC-033`, `SECP-FR-082` |
| *(cross-cutting)* | 7, 8 | `SECP-FR-070`…`084` — audit emission, testing, traceability |

**No stage is unowned, and no Part introduces a competing model.**

---

## 3. Ownership boundary verification

Thirty `SECP-OWN-*` boundaries and thirty-seven `SECP-XC-*` exclusions were declared. The contexts and platforms they
defer to:

| Deferred to | Boundaries | Nothing this PRD claims |
|---|---|---|
| `BC-18` Identity & Access (`PRD-001`) | `OWN-016`, `OWN-019`, `OWN-026` | Roles, permissions, policy, sessions, credentials, devices, decisions, authentication rate limits |
| `BC-19` Tenancy (`PRD-013`) + DATA | `OWN-017` | Tenant concept, partitioning mechanism, row-level security |
| `BC-10` Person Identity (`PRD-003`) | `OWN-018`, `OWN-026` | Identity records, profile content, guardianship, status semantics |
| `BC-24` Audit Trail (`PRD-016`) | `OWN-022`, `OWN-027` | The audit record, its immutability, retention, query |
| `BC-25` Configuration (`PRD-023`) | `OWN-021`, `OWN-030` | Parameters, validation, typed accessors |
| `BC-29` File & Media (`PRD-017`) | `OWN-020` | Uploads, scanning, signed URLs, object metadata |
| `BC-22` Notification Delivery | `OWN-025` | Channels, templating, delivery |
| `BC-28` Workflow Orchestration (**V2**) | `OWN-024` | Sequencing, retry, compensation, process state |
| OBSERVABILITY platform | `OWN-022` | Logging, metrics, dashboards, alerting, incident management |
| DEVOPS platform | `OWN-028`, `OWN-029` | Pipelines, static analysis tooling, test execution |
| INFRASTRUCTURE platform | `OWN-030`, `SECP-XC-036`/`037` | Backup, restore, DR, hardening, IaC |

`SECP-FR-084` — `PRD-012a` **SHALL NOT** be read as claiming ownership of any aggregate, context, parameter, event,
record or capability listed above. Where a reader finds a Part appearing to specify one, the correct reading is a
**citation plus a verification obligation**, and any text that cannot be so read is a defect to be raised.

**Verified: `PRD-012a` declares no `SECP-INV-*` (no owned aggregate — `SECP-GAP-010`), no `SECP-EVT-*` (no `BC-nn`
producer row — `SECP-OWN-023`) and no `SECP-CFG-*` (would duplicate `PRD-001`/`PRD-023` parameters — `SECP-XC-014`).
All three registers remain deliberately empty, each with a stated reason.**

---

## 4. V1 / V2 / V3 scope verification

Every capability EA tags above V1 was checked for accidental promotion. **No V1 requirement in Parts 1–8 is
satisfiable only by a V2, V3 or Future capability.**

| EA capability | Tag | Held out by |
|---|---|---|
| Zero Trust Architecture; Service Auth; Network Segmentation; Continuous Verification | V3 / Future | `SECP-PRN-009` directional; `SECP-XC-020`; Part 3 §8.1 |
| Least Privilege Enforcement (tooling) | V2 | `SECP-GAP-022` — principle (V1, Rank 3) separated from tooling |
| Query Guardrails; Cross-Tenant Leak Tests | V2 | `SECP-GAP-023` — module-scoped tests only |
| Secrets Rotation; Key Management; Cert Mgmt | V2 / V3 | `SECP-GAP-024`; `SECP-XC-021` |
| Field-Level Encryption; Tokenization | V2 / V3 | `SECP-XC-021` |
| WAF; DDoS; IP Allow/Deny; Geo Restrictions | V2 / V3 | `SECP-XC-023`; `SECP-GAP-025` |
| PII Inventory; Data Minimization; DSR; Erasure; RoPA; Residency | V2 / V3 | `SECP-XC-024`; `SECP-GAP-027` |
| Minor Data Protection | V2 | `SECP-GAP-026` |
| Anomaly Detection; Bot & Abuse Detection | V2 | `SECP-XC-027`; `SECP-GAP-028` |
| Account Takeover Detection; SIEM; Security Posture | V3 | `SECP-XC-027`; `SECP-GAP-029`, `SECP-GAP-030` |
| **Alerting** | **V2** | `SECP-GAP-031` — **conflicts with Rank 3 `AUTH-11.26`…`11.28`** |
| Incident Response; Playbooks; Runbooks | V2 | `SECP-XC-031`; `SECP-GAP-032` |
| Forensics; Breach Notification; Post-Incident Review | V3 | `SECP-XC-031`; `SECP-GAP-033`, `SECP-GAP-034` |
| Workflow Orchestration (`BC-28`) | V2 | `SECP-XC-030`; `SECP-OWN-024` |
| Vulnerability Mgmt; SAST; Dependency Audit; Patch Mgmt | V2 | `SECP-XC-034`; `SECP-GAP-036`, `SECP-GAP-037` |
| DAST; **Penetration Testing**; Bug Bounty | V3 / Future | `SECP-XC-035`; `SECP-GAP-038`; `SECP-FR-077` |
| Infrastructure Security Baseline | V2 | `SECP-XC-036`; `SECP-GAP-039` |
| Disaster Recovery; RTO/RPO; IaC | V3 / V2 | `SECP-XC-037` |

### 4.1 The one genuine scope conflict

`SECP-GAP-031` is **not** a scope-discipline finding but a **document conflict**: `PRD-001` at **Rank 3, `FROZEN`**
requires alertability (`AUTH-11.26`, `AUTH-11.27`, `AUTH-11.28`) while the EA at **Rank 6** tags `Alerting` **V2**.
Rank 3 outranks Rank 6, so the likely resolution is an EA correction — but `DOCUMENTATION_BASELINE.md` L253 forbids
this document from choosing. It is raised as `SECP-ADR-002` and `SECP-DEP-001`.

**No other Rank 1–3 requirement conflicts with a Part 1–8 requirement.**

---

## 5. Acceptance-criteria coverage — verified

| Part | Normative requirements declared | Criteria declared | Uncovered |
|---|---|---|---|
| Part 1 | 0 *(objectives, principles, exclusions, boundaries only)* | 14 | — |
| Part 2 | 18 `FR` + 8 `BR` = **26** | 27 | **0** |
| Part 3 | 12 `FR` + 3 `BR` = **15** *(+4 `XC`, 3 `OWN` bound)* | 16 | **0** |
| Part 4 | 16 `FR` + 3 `BR` = **19** *(+4 `XC`, 3 `OWN` bound)* | 19 | **0** |
| Part 5 | 11 `FR` + 3 `BR` = **14** *(+3 `XC`, 2 `OWN`, 14 `SIG`/`SEV` bound)* | 14 | **0** |
| Part 6 | 12 `FR` + 4 `BR` = **16** *(+4 `XC`, 3 `OWN` bound)* | 16 | **0** |
| Part 7 | 13 `FR` + 3 `BR` = **16** *(+4 `XC`, 4 `OWN`, 8 `TST` bound)* | 17 | **0** |
| Part 8 | 2 `FR` + 1 `BR` = **3** | 4 | **0** |
| **Total** | **109 normative requirements** | **127 criteria** | **0** |

Every `SECP-FR-*` and `SECP-BR-*` is bound by at least one `SECP-AC-*` in its own Part's coverage table. Every
`SECP-XC-*`, `SECP-OWN-*`, `SECP-HRO-*`, `SECP-SIG-*`, `SECP-SEV-*` and `SECP-TST-*` register entry is likewise bound.

> ⚠ **One genuine coverage defect was found and fixed during Part 2's validation, and it is recorded, not smoothed
> over.** `SECP-BR-008` had no criterion while Part 2 §15 claimed complete coverage. `SECP-AC-041` was added and the
> counts corrected. A paragraph-aware check — rather than a line-based one — was required to find it; a line-based
> check had also produced two **false** negatives on `SECP-BR-002`/`003`, whose criteria wrapped onto continuation
> lines. Both facts are recorded so the method, not just the result, is auditable.

`SECP-AC-124` — Every `SECP-FR-*` and `SECP-BR-*` in Parts 1–8 appears in at least one coverage table, and the count
of unbound normative requirements is **zero**, verified by a paragraph-aware check rather than a line-based one.

`SECP-AC-125` — All fifteen registers in §1.1 are contiguous from `001` to their stated maximum, verified by
measurement; the number of registers with a hole is **zero**.

`SECP-AC-126` — No identifier declared in Parts 1–7 is renumbered, reworded or withdrawn by Part 8; a diff of Parts
1–7 against their committed state shows **no modification**.

`SECP-AC-127` — No `SECP-*` identifier appears anywhere in the repository outside `docs/30-product/security/`, and no
Part contains SQL, DDL, application code, a fenced code block, or a phrase from the prohibited-claims family
(*hack-proof*, *unhackable*, *100% secure*, *fully secure*, *cannot be breached*).

---

## 6. Consolidated gap register — 44 gaps

Part 1 declared 13, Part 2 eight, Parts 3–7 nineteen, Part 8 four. **All are OPEN.** None is closed by this document.

### 6.1 High priority (14)

| ID | Gap | Owner to route to |
|---|---|---|
| `SECP-GAP-018` | Break-glass prohibited + `PR-1` a closed two-role set ⇒ total `PR-1` loss has **no** administrative recovery path, while `AUTH-11.59` demands recovery be exercised | `BC-18` owner + Governance |
| `SECP-GAP-023` | `MP-RSK-01` Rank 1 **Critical**, yet platform-wide `Cross-Tenant Leak Tests`/`Query Guardrails` are EA **V2** | Architecture Owner |
| `SECP-GAP-024` | No secret rotation or key management at V1; an emitted secret has no automated remediation | Architecture Owner |
| `SECP-GAP-026` | `MP-RSK-02` minor-safety Rank 1 **Critical**, yet `Minor Data Protection` is EA **V2** | Architecture Owner + `PRD-003` |
| `SECP-GAP-029` | No account-takeover detection (EA **V3**) while `ADR-0002` names SIM-swap as the sole factor's own defeat | Architecture Owner |
| `SECP-GAP-031` | **Rank 3 alertability vs EA-V2 `Alerting` — a document conflict** | Architecture Owner |
| `SECP-GAP-034` | No V1 breach-notification path, timeline or recipient set; DPDP is EA **V2** | Governance + Architecture |
| `SECP-GAP-035` | `AUTH-11.59` (*"exercised, not merely documented"*) undischarged for security responses | Architecture Owner |
| `SECP-GAP-036` | No vulnerability-management programme at V1 | Architecture Owner |
| `SECP-GAP-037` | No dependency vulnerability auditing or patch management; pinning gives integrity, not a vulnerability signal | Architecture Owner |
| `SECP-GAP-038` | No independent security assessment; tests written by the control's own author | Architecture Owner |
| `SECP-GAP-041` | **This PRD has no bounded context**, so Stage 1's gate cannot be met as written | Architecture Owner |
| `SECP-GAP-042` | **`platform/security` has no own block in `tool/module_dependencies.yaml`** — only a rank entry and inbound port references | Architecture Owner |
| `SECP-GAP-043` | `SECP-FR-018` remains **`PENDING-AUTHORITY`**; its step-up reading is unconfirmed by `BC-18` | `BC-18` owner |

### 6.2 Medium and lower priority (30)

`SECP-GAP-001`…`013` (Part 1), `SECP-GAP-014`…`017`, `019`…`021` (Part 2), `SECP-GAP-022`, `025`, `027`, `028`,
`030`, `032`, `033`, `039`, `040`, `044`. Each is stated in its declaring Part with its blocker and priority.

### 6.3 Gaps newly declared by Part 8

`SECP-GAP-041` — **`PRD-012a` has no bounded context, and Stage 1's gate is written to require one.** The gate demands
*"a context identified in the Bounded Context Map, not already owned"*; BC Map v1.8 has 31 contexts and none is a
security context. Every Part discloses this rather than claiming the gate passed, relying on `PRD_REGISTRY.md` §4.1's
standing authorisation. **This cannot be resolved by this PRD** — it needs either a `BC-nn` or an explicit lifecycle
exemption for platform-composition PRDs. `SECP-ADR-001`. **Priority: High.**

`SECP-GAP-042` — **`platform/security` has no own block in `tool/module_dependencies.yaml`.** L30 gives it rank 2 and
L107/181/239/278/279 reference its ports (`crypto`, `secrets`, `pii_redaction`), but the module declares no
dependencies of its own. Given L21's `default_decision: deny`, Parts 3–7 assume this module may reach `BC-18` for
decisions, `BC-24` for audit, `BC-22` for notification and `BC-25` for parameters — **none of which is declared**.
`SECP-ADR-004`. **Priority: High.**

`SECP-GAP-043` — **`SECP-FR-018` is still `PENDING-AUTHORITY`.** Part 2 specified it and marked it unimplementable
until `BC-18`'s owner confirms whether extending re-authentication to four operations `AUTH-8.81` does not name is a
security obligation or an authentication requirement. Parts 3–8 did **not** activate it. `SECP-ADR-003`.
**Priority: High.**

`SECP-GAP-044` — **`PRD_REGISTRY.md` and `PRD_OWNERSHIP_MODEL.md` still describe `PRD-012a` as unopened.** The split
is now *executed* — eight Parts exist — but the registry rows are stale. Editing them is the **Governance Owner's**
act, and `SECP-GAP-012`/`013` already recorded the same finding; this gap records that Part 8's completion makes the
staleness material rather than theoretical. **Priority: Medium.** *Deliberately not edited by this PRD.*

---

## 7. External dependencies

| ID | Dependency | On whom | Blocks |
|---|---|---|---|
| `SECP-DEP-001` | Reconcile Rank 3 alertability with EA-V2 `Alerting` | Architecture Owner | `SECP-GAP-031`; full satisfaction of Part 5 §6 |
| `SECP-DEP-002` | Confirm the `SECP-FR-018` step-up reading | `BC-18` owner (`PRD-001`) | `SECP-GAP-043`; `SECP-FR-018` implementation |
| `SECP-DEP-003` | Declare `platform/security`'s outbound ports in `tool/module_dependencies.yaml` | Architecture Owner | `SECP-GAP-042`; any implementation of Parts 3–7 |
| `SECP-DEP-004` | Decide whether a security `BC-nn` is created or a lifecycle exemption recorded | Architecture Owner | `SECP-GAP-041`; Stage 1 and Stage 3 |
| `SECP-DEP-005` | Publish `BC-24`'s support-access category list (`AUD-GAP-004`) | `BC-24` owner (`PRD-016`) | Completeness of `SECP-FR-070`'s emission list |
| `SECP-DEP-006` | Register `SECP-`, `SECP-SIG-`, `SECP-SEV-`, `SECP-TST-`, `SECP-TRC-`, `SECP-DEP-`, `SECP-ADR-` in `TRACEABILITY_MATRIX.md` | Governance Owner, at **Stage 5** | Stage 5 conferral |
| `SECP-DEP-007` | Update `PRD_REGISTRY.md` §4.1 and `PRD_OWNERSHIP_MODEL.md` to reflect the executed split | Governance Owner | `SECP-GAP-044`, `SECP-GAP-012`, `SECP-GAP-013` |

---

## 8. Required ADRs

**These are *requests*, not decisions.** A `SECP-ADR-*` confers nothing; the Architecture Owner writes, numbers and
accepts an ADR. The next free governance number is **`ADR-0060`**, measured — but Part 8 **does not** assign it.
`ADR-0022`'s precedent shows an ADR may legitimately be opened as `Proposed`.

| ID | Required decision | Why an ADR is required | Priority |
|---|---|---|---|
| `SECP-ADR-001` | **Does the SECURITY platform get a bounded context, or does the lifecycle exempt platform-composition PRDs?** | Stage 1's gate cannot be met as written (`SECP-GAP-041`). `ADR-0013` assigns capability contexts; no ADR covers a platform with none. Stage 1's own note that *"four of the nineteen Master PRD modules are compositions, not contexts"* suggests exemption, but that is a decision, not a reading | **High** |
| `SECP-ADR-002` | **Reconcile Rank 3 alertability (`AUTH-11.26`…`11.28`) with EA-V2 `Alerting`** | A Rank 3 `FROZEN` requirement and a Rank 6 version tag disagree. `DOCUMENTATION_BASELINE.md` L253 forbids this PRD choosing. Amending a frozen PRD or the EA both require a recorded act | **High** |
| `SECP-ADR-003` | **Is platform step-up re-authentication a security obligation or an authentication requirement?** | `SECP-FR-018` extends re-authentication to four operations `AUTH-8.81` does not name. `PRD-001` is `FROZEN` and Rank 3; this PRD is unranked and may not assert an authentication rule | **High** |
| `SECP-ADR-004` | **Declare `platform/security`'s outbound dependencies** | `tool/module_dependencies.yaml` L21 denies by default and the module has no block. Parts 3–7 assume four outbound reaches. Adding them changes the enforced dependency graph | **High** |
| `SECP-ADR-005` | **Baseline `PRD-012a` v0.8 Parts 1–8** | Stages 3–7 require a governing decision to proceed; `ADR-0053`/`ADR-0054` are the precedent for a PRD-baseline ADR. Without it `PRD-012a` remains `DRAFT` indefinitely | Medium |

---

## 9. Final acceptance

### 9.1 What Parts 1–8 deliver

- **426 identifiers** across **15 registers**, all contiguous, none renumbered.
- **109 normative requirements**, each bound to at least one of **127 measurable criteria**; **zero uncovered**.
- **37 exclusions** and **30 ownership boundaries**, deferring to 8 bounded contexts and 4 platforms.
- **Four closed sets** — `SECP-HRO-*` (12 high-risk operations), `SECP-SIG-*` (10 signals), `SECP-SEV-*` (4
  severities), `SECP-TST-*` (8 test classes) — each with a default-refuse closure rule.
- **44 open gaps**, **7 external dependencies**, **5 required ADRs**.

### 9.2 What Parts 1–8 explicitly do **not** deliver

- **No claim of security.** Part 1 §2.2 forbids it; `SECP-AC-127` verifies the prohibited-claims family is absent.
- **No V2/V3 capability presented as V1.** §4's table is the audit; `SECP-AC-055` and `SECP-AC-090` verify it.
- **No frozen document modified.** `PRD-001`, `PRD-003`, `PRD-013`, `PRD-016`, `PRD-017`, `PRD-023` are cited only.
- **No status, rank, baseline or freeze.** Stages 3–7 are not run; **freeze is conferred, not claimed**.
- **No Stage 5 registration.** `SECP-DEP-006`.
- **No resolution of any conflict found.** All raised, per `DOCUMENTATION_BASELINE.md` L253.

### 9.3 Lifecycle position

**Stage 2 (Draft) — complete for all eight Parts.** The gate — *"document on disk, versioned header, identifier
registers declared"* — is met by each Part, with every prefix collision-checked **before** writing and all ranges
contiguous.

**Stage 1's gate is NOT met, and is disclosed rather than claimed** — `SECP-GAP-041`, `SECP-ADR-001`. Authority to
have proceeded is `PRD_REGISTRY.md` §4.1's standing authorisation that *"`PRD-012a`/`PRD-012b` may be opened without a
further ADR."*

**Stages 3, 4, 5, 6 and 7 are not run.** `PRD-012a` is **`DRAFT`**, **unranked**, with **no baseline row**. It
**MUST NOT** be cited as authority against any ranked document.

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| v0.8 | 2026-08-21 | Part 8 created; **`PRD-012a` Parts 1–8 complete**. 32 identifiers: `SECP-FR-083`…`084`, `SECP-BR-025`, `SECP-AC-124`…`127`, `SECP-GAP-041`…`044`, plus three new registers `SECP-TRC-001`…`009`, `SECP-DEP-001`…`007`, `SECP-ADR-001`…`005`, all broad-probe collision-checked before writing (§0.4). Verified by measurement: **426 identifiers, 15 registers, all contiguous**; **109 normative requirements, 127 criteria, zero uncovered**. `SECP-BR-025` codifies the two counting rules — citation-is-not-declaration, and **no Part may write an identifier it does not declare** — and §1.3 records that both were violated during authoring (two phantom placeholders, each one number past its Part's declared maximum, described in §1.3 without reproducing the tokens) and corrected before commit. Five ADRs identified as **requests, not decisions**; `ADR-0060` measured as next free but **not assigned**. `SECP-GAP-041`…`044` newly recorded, including the undeclared `platform/security` manifest block. No frozen document modified; no conflict resolved; no status conferred. |
