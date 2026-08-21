# `PRD-012a` Implementation Tasks — `IMPL-1300` … `IMPL-1359`

| Field | Value |
|---|---|
| **Module** | `platform/security` — rank **2** (`tool/module_dependencies.yaml` L30). ⚠ **No Bounded Context.** See §2.1 |
| **Aggregate** | **None.** `SECP-FR-084` — this PRD claims ownership of no aggregate, context, parameter, event or table |
| **Source PRD** | [`../../30-product/security/PRD-012a_SECURITY_AUTOMATION.md`](../../30-product/security/PRD-012a_SECURITY_AUTOMATION.md) v0.1 + Parts 2–8, `DRAFT` |
| **Part 1 hash** | `dbd01d4d00165c774024d62a9e4a18099cf4272402581a8febcf244ab582d452` — **unchanged** by this document |
| **Part 8 hash** | `a8c45d79eb8154f766e1fe1006031ea6baacdd99439fc0cfca2d1f504e7c7977` — **unchanged** by this document |
| **Range allocated** | **`IMPL-1300` … `IMPL-1359`** — 60 tasks · `IMPL-1360`…`1399` declared growth reserve |
| **Obligations claimed** | **109 of 109** normative requirements (84 `SECP-FR-*` + 25 `SECP-BR-*`) · **37 of 37** `SECP-XC-*` |
| **Acceptance criteria proven** | ⛔ **0 of 128.** No implementation exists |
| **Invariants enforced** | ⚠ **`SECP-INV-*` is empty by design** (`SECP-GAP-010`). See §6.1 — the column is not fabricated |
| **Stage** | 6 of 9. **Stage 7 is not entered by this document.** Stage 8 is not started |
| **Status of this document** | **Unranked.** Not admitted to `DOCUMENTATION_BASELINE.md` |
| **Version** | v1.0 · 2026-08-21 |

---

## 1. The two things this document is not

**It is not an implementation, and it is not a design.** It allocates numbers and states what each numbered unit of
work must satisfy, citing `SECP-*` obligations that already exist in Parts 1–8. It contains **no** schema, SQL, DDL,
migration, API shape, class signature, field list, widget tree, library name, cipher suite, header value, threshold,
timeout, estimate or sprint assignment.

That restraint is load-bearing here more than in most backlogs. **`SECP-XC-025` forbids Part 4 from naming a library,
framework, parser, encoder, sanitiser, header value or configuration key**; `SECP-XC-021` forbids specifying field-level
encryption, cipher suites or key lengths; `SECP-XC-028` forbids defining a metric name, query or log format. A backlog
that named any of them would supply by implementation choice exactly what the PRD refused to specify, and would do so
in a document with no standing to specify it. §9 lists the tasks that must therefore **not** exist.

**It is not an authorisation to build.** Three of this module's obligations cannot be implemented at all until an
Architecture Owner decision exists — most importantly `SECP-DEP-003`, because `tool/module_dependencies.yaml` L21 sets
`default_decision: deny` and the file contains **no `platform/security:` block**. Under a default-deny manifest a module
with no declared block has no permitted outbound reach. §4.2 records which tasks that blocks and does not pretend
otherwise.

**Nothing under `lib/`, `test/`, `packages/` or `tool/` was modified.** This document and its companion Stage 6 gate
record are the only files created.

---

## 2. Stage 6 prerequisites — verified, not assumed

| Prerequisite | Required by | State |
|---|---|---|
| Stage 1 Discovery passed | `PRD_LIFECYCLE.md` Stage 1 | ⛔ **NOT PASSED.** The gate is *"a context in the Bounded Context Map, not already owned."* `PRD-012a` holds **no `BC-nn`**. Recorded as `SECP-GAP-041`, routed to `SECP-ADR-001` / `SECP-DEP-004`. §2.1 |
| Stage 2 draft with registers declared up front | `PRD_LIFECYCLE.md` Stage 2 | ✅ 15 registers, ranges published, **427 identifiers, all contiguous** — re-measured 2026-08-21 |
| Stage 3 Architecture alignment recorded | `PRD_LIFECYCLE.md` Stage 3 | ⚠ [`PRD-012a_ARCHITECTURE_ALIGNMENT.md`](../../30-product/security/PRD-012a_ARCHITECTURE_ALIGNMENT.md) — **ALIGNED WITH ONE STRUCTURAL FINDING** (5 PASS + 1 PASS-with-finding `A3-1`). **3 conflicts routed, 0 resolved** |
| Stage 4 conflicts closed or deferred with reason **and** owner | `PRD_LIFECYCLE.md` Stage 4 | ✅ [`PRD-012a_STAGE4_REQUIREMENTS_REVIEW.md`](../../30-product/security/PRD-012a_STAGE4_REQUIREMENTS_REVIEW.md) — **PASS 6/6**, 3 deferrals each with a named owner, 2 LOW carried |
| Stage 5 prefixes registered, counts and ranges verified mechanically, zero collisions | `PRD_LIFECYCLE.md` Stage 5 | ✅ [`../TRACEABILITY_MATRIX.md`](../TRACEABILITY_MATRIX.md) **v1.18 §2N** — 15 registers, 427 identifiers, collisions checked in four directions, **0** |

**Stage 5 conferred nothing about this stage.** §2N.2 says so in eleven rows. Registration is not verification, and
verification is not permission to freeze.

### 2.1 The Stage 1 anomaly — disclosed, not worked around

Stage 1's gate is a bounded context. `PRD-012a` has none: the Bounded Context Map holds **87 `BC-nn` rows** and
**not one** is a security context — the three security-named hits are `ID-1`'s prohibition (L178), `BC-18`'s event list
(L434) and the phrase *"row-level security"* as a mechanism (L486).

**This document does not treat that absence as either a pass or a prohibition.** The Stage 3 alignment record explains
why at length, and the reasoning is the same one `ADR-0050` §5 established when it **withdrew** `PRD-013`'s Stage 7
blocker for *"inferring a prohibition from the absence of precedent"*: an absence is a fact about history, not a rule.

So this backlog does what the lifecycle permits a backlog to do with an unresolved structural question — it **schedules
it and refuses to resolve it**. `SECP-ADR-001` asks whether the SECURITY platform gets a context or whether the
lifecycle exempts platform-composition PRDs. **No task here creates a `BC-nn`, and none assumes one.** Every task is
scoped to the module path `platform/security`, which exists in the manifest at rank 2 independently of any context
assignment.

⚠ **Consequence, stated plainly:** if `SECP-ADR-001` decides that a security context is required, this backlog remains
valid but gains a task; if it decides an exemption applies, this backlog remains valid unchanged. If it decides the
SECURITY platform must instead be decomposed into existing contexts, **this backlog would be withdrawn, not renumbered**
— `PRD_LIFECYCLE.md` §5 rule 5 forbids reusing the numbers either way.

---

## 3. `IMPL-*` allocation

### 3.1 Why this range — computed, not chosen

`PRD_LIFECYCLE.md` Stage 6 allocation rule 1: *"Take the next free range. **Never reuse or reassign a number** —
cross-references in commits, reviews and test names outlive the document."* Rule 2: *"Leave the previous group room to
grow contiguously."*

Every `IMPL-*` identifier in the repository was enumerated rather than read off a table:

```
grep -rhoE 'IMPL-[0-9]{3,4}' docs/ tool/ lib/ test/ packages/ | sort -u | wc -l
→ 610 distinct numbers · highest 1300
```

⚠ **`IMPL-1300` already occurs in the repository, and the occurrence was checked rather than assumed harmless.**

```
grep -rnoE 'IMPL-1[3-9][0-9]{2}' docs/ tool/ lib/ test/ packages/
→ 1 hit outside this document's own text:
  docs/40-implementation/file-media/PRD-017_IMPLEMENTATION_TASKS.md:98
      | `IMPL-1300` + | Unallocated | — |
  docs/40-implementation/TRACEABILITY_MATRIX.md:1640   §2N prose, naming IMPL-1300 as the next free start
```

Both are **boundary labels naming this number as free**, not assignments of work to it. Taking `IMPL-1300` is therefore
what rule 1's *"take the next free range"* instructs, not a reassignment. The distinction is disclosed rather than
filtered out, because a scanner that counts string occurrences reports `1300` as present, and treating that report as
occupancy would push this backlog to `IMPL-1400` and strand a hundred numbers.

⚠ **The allocation table in `PRD_LIFECYCLE.md` §Stage 6 is stale — it ends at `IMPL-227` + "Unallocated".** It was not
followed. It is **not corrected here**: `PRD_LIFECYCLE.md` is Rank 1, and baseline §7 rule 1 requires an ADR **before**
a change to any Rank 1–5 document. The staleness is recorded as a finding in §10 and left for the Governance Owner.

### 3.2 The allocation table

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | [`../IMPLEMENTATION_ROADMAP.md`](../IMPLEMENTATION_ROADMAP.md) |
| `IMPL-100` … `IMPL-199` | Library Management + growth reserve | `../LIBRARY_IMPLEMENTATION_TASKS.md` |
| `IMPL-200` … `IMPL-299` | Student Identity + growth reserve | `../STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md` |
| `IMPL-300` … `IMPL-399` | Student Management (`PRD-004`, `BC-01`) + reserve | `PRD-004_IMPLEMENTATION_TASKS.md` |
| `IMPL-400` … `IMPL-499` | Membership Management (`PRD-005`, `BC-02`) + reserve | `PRD-005_IMPLEMENTATION_TASKS.md` |
| `IMPL-500` … `IMPL-599` | Seat Management (`PRD-007`, `BC-04`) | `PRD-007_IMPLEMENTATION_TASKS.md` |
| `IMPL-600` … `IMPL-699` | Attendance / integration backlogs | `PRD-006_IMPLEMENTATION_TASKS.md` |
| `IMPL-700` … `IMPL-799` | Revenue & Finance (`PRD-008`, `BC-06`) — `ADR-0049` | `PRD-008_IMPLEMENTATION_TASKS.md` |
| `IMPL-800` … `IMPL-899` | Tenancy (`PRD-013`, `BC-19`) + reserve — `ADR-0050` | `../tenancy/PRD-013_IMPLEMENTATION_TASKS.md` |
| `IMPL-900` … `IMPL-999` | Audit Trail (`PRD-016`, `BC-24`) + reserve — `ADR-0051` | `../audit/PRD-016_IMPLEMENTATION_TASKS.md` |
| `IMPL-1000` … `IMPL-1099` | Entitlement (`PRD-014`, `BC-21`) + reserve — `ADR-0052` | `../entitlement/PRD-014_IMPLEMENTATION_TASKS.md` |
| `IMPL-1100` … `IMPL-1199` | Configuration (`PRD-023`, `BC-25`) + reserve — `ADR-0053` | `../configuration/PRD-023_IMPLEMENTATION_TASKS.md` |
| `IMPL-1200` … `IMPL-1260` | File & Media (`PRD-017`, `BC-27`) — 61 tasks, `ADR-0054`/`0056`/`0058`/`0059` | `../file-media/PRD-017_IMPLEMENTATION_TASKS.md` |
| `IMPL-1261` … `IMPL-1299` | Reserved — **`PRD-017` growth**, 39 remaining. **Not touched here** | — |
| **`IMPL-1300` … `IMPL-1309`** | **Wave 1 — Ownership boundary and the ten Part 1 exclusions** | This document |
| **`IMPL-1310` … `IMPL-1319`** | **Wave 2 — Platform-admin privilege, the `SECP-HRO-*` closed set, break-glass prohibition** | This document |
| **`IMPL-1320` … `IMPL-1329`** | **Wave 3 — Authorisation gating, tenant isolation, fail-closed, secrets** | This document |
| **`IMPL-1330` … `IMPL-1339`** | **Wave 4 — Application, API, validation, abuse limiting, session and data handling** | This document |
| **`IMPL-1340` … `IMPL-1347`** | **Wave 5 — The closed signal set, detection, monitoring, severity and escalation** | This document |
| **`IMPL-1348` … `IMPL-1353`** | **Wave 6 — Automated response and incident containment** | This document |
| **`IMPL-1354` … `IMPL-1359`** | **Wave 7 — Audit emission, test classes, supply chain, resilience, acceptance harness** | This document |
| `IMPL-1360` … `IMPL-1399` | **Reserved for `PRD-012a` growth** — 44 open `SECP-GAP-*` and 5 `SECP-ADR-*` may require tasks | This document, unallocated |
| `IMPL-1400` + | Unallocated | — |

**60 tasks, `IMPL-1300` … `IMPL-1359`, contiguous with no gaps inside the allocated span.** Wave boundaries fall on
round tens wherever the wave is ten wide, so that a task added later does not force a renumber: rule 1 forbids
reassignment, so slack must be **planned rather than found**.

`IMPL-1360`…`1399` is declared this module's growth reserve because **44** `SECP-GAP-*` are genuinely open and at least
four of them (`SECP-GAP-023`, `031`, `041`, `042`) would each produce tasks the moment an ADR resolved them. A 40-number
reserve is sized to that, not chosen for roundness.

**`PRD-017`'s reserve `IMPL-1261`…`1299` is left wholly intact**, satisfying rule 2. Nothing below `IMPL-1300` is
touched, reused or reassigned.

---

## 4. What this backlog can and cannot schedule

### 4.1 Obligations claimed — the whole normative set

| Register | Count | Claimed by tasks | Notes |
|---|---|---|---|
| `SECP-FR-*` | **84** | **84** | Every functional requirement is claimed by exactly one primary task |
| `SECP-BR-*` | **25** | **25** | Business rules ride with the requirement they bind |
| `SECP-XC-*` | **37** | **37** | Every exclusion is claimed as a **structural impossibility to enforce**, per Stage 4 check D2 |
| `SECP-HRO-*` | 12 | 12 | Closed set, enforced as a set by `IMPL-1312` |
| `SECP-SIG-*` | 10 | 10 | Closed set, enforced as a set by `IMPL-1340` |
| `SECP-SEV-*` | 4 | 4 | Closed set, enforced as a set by `IMPL-1345` |
| `SECP-TST-*` | 8 | 8 | Closed set, enforced as a set by `IMPL-1355` |
| **Total obligations** | **109 + 37 = 146** | **146** | **100.0%** |

`SECP-AC-*` do **not** appear in Requirements cells. An acceptance criterion is **verified by** a task's test, not
**implemented by** a task; §6 maps them separately, and `IMPL-1359` is the task that proves all 128 run.

`SECP-GAP-*` do **not** appear either: they are **open questions**, and citing one as an obligation would resolve it by
implementation choice. Where a *Test requirement* names a `SECP-GAP-*`, it records which gap the task must leave
**untouched**.

`SECP-OBJ-*`, `SECP-PRN-*`, `SECP-OWN-*`, `SECP-TRC-*`, `SECP-DEP-*` and `SECP-ADR-*` are not obligations on this
module either — objectives, principles, ownership statements, traceability rows, dependencies on other owners and ADR
*requests* respectively. None is claimed as work.

### 4.2 What is blocked by a missing decision — measured, not glossed

| Blocker | Dependency | Owner | Tasks it blocks |
|---|---|---|---|
| No `platform/security:` block in `tool/module_dependencies.yaml` under `default_decision: deny` | `SECP-DEP-003` / `SECP-ADR-004` (`SECP-GAP-042`) | **Architecture Owner** | `IMPL-1320`, `IMPL-1321`, `IMPL-1328`, `IMPL-1342`, `IMPL-1354` — every task requiring an outbound reach to `BC-18`, `BC-24`, `BC-25` or the vault |
| No security `BC-nn`, so Stage 1's gate is unmet | `SECP-DEP-004` / `SECP-ADR-001` (`SECP-GAP-041`) | **Architecture Owner** | Nothing in this backlog *technically*; but **the whole backlog's admissibility** depends on it. §2.1 |
| Rank 3 `AUTH-11.26`…`11.28` alertability vs Rank 6 EA-V2 `Alerting` | `SECP-DEP-001` / `SECP-ADR-002` (`SECP-GAP-031`) | **Architecture Owner** | `IMPL-1346`, `IMPL-1347` — full satisfaction only; the tasks exist and are partially deliverable |
| `SECP-FR-018` step-up reading vs `FROZEN` `AUTH-8.81` | `SECP-DEP-002` / `SECP-ADR-003` (`SECP-GAP-043`) | **`BC-18` owner (`PRD-001`)** | `IMPL-1316` |
| `BC-24`'s support-access category list absent | `SECP-DEP-005` (`AUD-GAP-004`) | **`BC-24` owner (`PRD-016`)** | Completeness of `IMPL-1354` only |

**Five tasks are blocked on an Architecture Owner act and one on a `BC-18` owner act.** They are **scheduled, not
started, and not silently marked ready.** A backlog is permitted to schedule a blocked task; it is not permitted to
invent the decision that unblocks it.

---

## 5. The 60 tasks

Column meanings, fixed once. **Requirements** cites the `SECP-*` obligations the task must satisfy — this is the Stage 6
gate and **no cell may be empty**. **Blocked by** and **Blocks** record allocation rule 3's two directions.
**Priority** is `P1` (something else cannot proceed without it, or the harness that proves everything), `P2` (needed for
a coherent V1) or `P3` (required by the PRD but on no other task's path).

⛔ marks a task blocked on an external decision per §4.2.

### 5.1 Wave 1 — Ownership boundary and the ten Part 1 exclusions (`IMPL-1300` … `IMPL-1309`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1300` | Module skeleton at `platform/security` owning **no aggregate and no context** — the ownership posture Part 8 §3 states, not a claim to one | P1 | — | `IMPL-1301`…`1309`, `IMPL-1310`, `IMPL-1320`, `IMPL-1330`, `IMPL-1340`, `IMPL-1348`, `IMPL-1354` | `SECP-FR-084`, `SECP-XC-010` | Structural: no aggregate root, no `BC-nn` declaration and no context registration is representable in this module — `SECP-AC-128` |
| `IMPL-1301` | No credential, OTP, session or password stored, cached, minted, validated or held — enforced so that adding one **fails the build** | P1 | `IMPL-1300` | `IMPL-1359` | `SECP-XC-001` | No credential, OTP, session or password type is constructible or persistable here; `ID-1` (BC Map L178) holds — `SECP-AC-001` |
| `IMPL-1302` | No authorisation **outcome** produced, cached, altered or short-circuited. Verifying isolation is not deciding access | P1 | `IMPL-1300` | `IMPL-1320`, `IMPL-1359` | `SECP-XC-003`, `SECP-XC-006` | No role, permission, policy or decision type is definable; supplying a context yields no authorisation outcome — `X-13`; owner `BC-18` |
| `IMPL-1303` | No audit entry altered, deleted or suppressed, and no privileged path that could | P1 | `IMPL-1300` | `IMPL-1354`, `IMPL-1359` | `SECP-XC-004` | No mutate/delete/suppress path over audit exists at any privilege level — `X-10`; owner `BC-24` |
| `IMPL-1304` | No authentication method introduced, enabled, hidden or partially implemented beyond the sole V1 method | P1 | `IMPL-1300` | `IMPL-1316`, `IMPL-1359` | `SECP-XC-005`, `SECP-BR-008` | No second factor, alternative method or partial method is reachable; re-authentication is not represented, logged or presented as a factor — `MP-CON-11`, `MP-GBR-25` |
| `IMPL-1305` | No workflow orchestration, saga, scheduling, compensation or DLQ handling owned or specified | P3 | `IMPL-1300` | `IMPL-1352`, `IMPL-1359` | `SECP-XC-002` | None of the five is definable here — owner `BC-28`, V2, `PRD-012b` |
| `IMPL-1306` | No tenant data partitioning, row-level isolation or query guardrail owned — verification only | P2 | `IMPL-1300` | `IMPL-1322`, `IMPL-1359` | `SECP-XC-007` | No partitioning scheme, RLS policy or guardrail is defined here; the verification surface does not become the enforcement surface — owner DATA PLATFORM |
| `IMPL-1307` | No logging, metrics, tracing, alerting or crash-reporting infrastructure owned — the PII constraint is set, the pipeline is not | P2 | `IMPL-1300` | `IMPL-1344`, `IMPL-1359` | `SECP-XC-008` | No dashboard, metric name, log format, exporter or alert route is defined here — owner OBSERVABILITY PLATFORM |
| `IMPL-1308` | No CI/CD, artefact management, release engineering or infrastructure provisioning owned — the vault is owned, the pipeline is not | P2 | `IMPL-1300` | `IMPL-1328`, `IMPL-1357`, `IMPL-1359` | `SECP-XC-009` | No pipeline definition, artefact store or provisioning surface is defined here — owner DEVOPS / INFRASTRUCTURE |
| `IMPL-1309` | The boundary checker binding for `platform/security` — the eight exclusions above enforced mechanically rather than by review | P1 | `IMPL-1301`…`1308` | `IMPL-1359` | `SECP-XC-011`, `SECP-XC-012` | Each of the eight prohibitions fails `check_module_boundaries` when violated; the module cannot extend the closed platform-role set |

### 5.2 Wave 2 — Platform-admin privilege, `SECP-HRO-*`, break-glass prohibition (`IMPL-1310` … `IMPL-1319`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1310` | Platform-admin identity and access boundary as **security properties only** — the model stays in `PRD-001` | P1 | `IMPL-1300` | `IMPL-1311`, `IMPL-1313`, `IMPL-1317` | `SECP-FR-001`, `SECP-FR-002`, `SECP-XC-013` | The module states properties and defines no role, permission or session; `PR-1`/`PR-2` are cited, never extended — `SECP-AC-015` |
| `IMPL-1311` | Effective authority **exactly** the union `SECP-BR-001` states — never more by convenience, never less by omission | P1 | `IMPL-1310` | `IMPL-1312`, `IMPL-1314` | `SECP-FR-003`, `SECP-BR-001` | An authority outside the stated union is unreachable; the union is computed from `PRD-001`, not restated — `SECP-AC-016` |
| `IMPL-1312` | The **`SECP-HRO-*` closed set of twelve** enforced as a set, with the `SECP-BR-004` closure rule: an unlisted platform-scoped, irreversible or tenant-affecting operation is **refused by default** | P1 | `IMPL-1311` | `IMPL-1313`, `IMPL-1315`, `IMPL-1359` | `SECP-FR-011`, `SECP-FR-012`, `SECP-BR-004`, `SECP-HRO-001`…`012` | All twelve emit an audit record naming actor, operation, target and tenant scope; an operation meeting the closure test but absent from the register is refused **and** the refusal recorded — `SECP-AC-021`…`024`. ⚠ **`SECP-HRO-*` is a closed register: a thirteenth requires an ADR** |
| `IMPL-1313` | Two-person control on `SECP-HRO-001` and `SECP-HRO-002` — a single account **cannot** complete either | P1 | `IMPL-1310`, `IMPL-1312` | `IMPL-1359` | `SECP-FR-013`, `SECP-FR-004` | Self-assignment and self-approval both fail with two distinct accounts required — `AUTH-2.6`, `XC-2.5`, `AC-2.12` |
| `IMPL-1314` | Refusal as the default on any privileged path — **absence of an explicit grant is refusal**, and conflicting rules resolve to the more restrictive | P1 | `IMPL-1311` | `IMPL-1320`, `IMPL-1359` | `SECP-FR-008`, `SECP-FR-009`, `SECP-BR-002`, `SECP-BR-003` | An unmatched privileged path denies; where two rules both apply the restrictive outcome is taken — enforcement here, **decision in `BC-18`** — `SECP-AC-019`, `SECP-AC-020` |
| `IMPL-1315` | Privilege-escalation prevention, with an escalation **attempt** recorded as a security event whether or not it succeeded | P2 | `IMPL-1312` | `IMPL-1341`, `IMPL-1359` | `SECP-FR-014`, `SECP-FR-015`, `SECP-BR-006` | A failed escalation emits an event; no path grants an authority the subject did not already hold — `SECP-AC-027`, `SECP-AC-028` |
| `IMPL-1316` | ⛔ Step-up re-authentication on sensitive actions — **as a security obligation, pending `SECP-ADR-003`**; not asserted as an authentication rule | P2 | `IMPL-1304`, `IMPL-1310` | `IMPL-1359` | `SECP-FR-018`, `SECP-BR-008` | Re-authentication is required on the stated operations and is **never** described, logged or presented as a second factor. ⛔ **Blocked: `SECP-DEP-002`, `BC-18` owner. `SECP-GAP-043` left open** |
| `IMPL-1317` | Admin session security properties — an elevation **MUST NOT** prolong a session, and renewal **MUST NOT** prolong an elevation | P2 | `IMPL-1310` | `IMPL-1336`, `IMPL-1359` | `SECP-FR-016`, `SECP-FR-017`, `SECP-BR-007`, `SECP-XC-026` | Elevation and session lifetimes are independent in both directions; neither extends the other — `SECP-AC-031`, `SECP-AC-032`; session **defined** by `BC-18`, `SECP-XC-026` |
| `IMPL-1318` | **Break-glass / emergency access as structurally impossible** — prohibited, not deferred, and not reachable under incident conditions | P1 | `IMPL-1312` | `IMPL-1350`, `IMPL-1359` | `SECP-XC-014`, `SECP-XC-015` | No break-glass, emergency, override or impersonation path is constructible at any privilege level or under any degraded mode — `PRD_LIFECYCLE.md` §7: *"`X-13` and `ID-1` are never waived under time pressure"* |
| `IMPL-1319` | Separation between Platform Admin, Manager and operational users, and the tenant/data access boundary under elevation | P2 | `IMPL-1313` | `IMPL-1322`, `IMPL-1359` | `SECP-FR-005`, `SECP-FR-006`, `SECP-FR-007`, `SECP-FR-010`, `SECP-BR-005`, `SECP-XC-016`, `SECP-XC-017`, `SECP-XC-018` | Role surfaces do not overlap; `SECP-HRO-006` cannot reach profile **content**, only status — `SID-3.32`, `SID-AC-18`; data access under elevation is bounded and attributed — `SECP-AC-036`…`041` |

### 5.3 Wave 3 — Authorisation gating, tenant isolation, fail-closed, secrets (`IMPL-1320` … `IMPL-1329`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1320` | ⛔ Every tenant-scoped read or mutation preceded by an authorisation decision **obtained from `BC-18`**, never computed here | P1 | `IMPL-1302`, `IMPL-1314` | `IMPL-1321`, `IMPL-1322`, `IMPL-1326` | `SECP-FR-019`, `SECP-XC-019` | No operation proceeds without an obtained decision; no decision is produced locally — `SECP-AC-042`. ⛔ **Blocked: `SECP-DEP-003`, outbound port to `BC-18` undeclared** |
| `IMPL-1321` | ⛔ No authorisation decision cached, memoised, persisted, replayed or reused across operations | P1 | `IMPL-1320` | `IMPL-1359` | `SECP-FR-020`, `SECP-FR-021` | A second operation re-obtains its decision; no cache, memo or replay surface exists; the exercised permission set is bounded per operation — `SECP-AC-043`, `SECP-AC-044`. ⛔ **Blocked: `SECP-DEP-003`** |
| `IMPL-1322` | Server-side enforcement of every permission check — a client-only, UI-only or optimistic check does not count | P1 | `IMPL-1306`, `IMPL-1319`, `IMPL-1320` | `IMPL-1330`, `IMPL-1359` | `SECP-FR-022` | A check bypassed at the client is still enforced at the server — `SECP-AC-045` |
| `IMPL-1323` | An operation arriving without a resolved tenant context **refused**, and a tenant context treated as an input to validate, never an assertion to trust | P1 | `IMPL-1322` | `IMPL-1324`, `IMPL-1325` | `SECP-FR-023`, `SECP-FR-024`, `SECP-BR-009` | An unresolved context refuses — never an empty result, never a default tenant; a supplied tenant identifier alone grants nothing — `SECP-AC-046`, `SECP-AC-047`; `MP-GBR-08`, `X-13` |
| `IMPL-1324` | A cross-tenant probe test for **every** V1 operation, with refusal **indistinguishable** in body, status and timing class from a not-found | P1 | `IMPL-1323` | `IMPL-1359` | `SECP-FR-025`, `SECP-FR-026` | Each operation has a tenant-A-probes-B test; the refusal leaks no existence signal — `SECP-AC-048`, `SECP-AC-049`; `MP-RSK-01` **Critical**. ⚠ **`SECP-GAP-023` left open**: the Rank 1 vs EA-V2 timing conflict is not resolved here |
| `IMPL-1325` | A cross-tenant attempt emitting a security signal and never being silently absorbed | P2 | `IMPL-1323` | `IMPL-1341`, `IMPL-1359` | `SECP-FR-027`, `SECP-BR-017` | The attempt produces a signal for the Detect stage; **refusal alone is not detection** — `SECP-AC-050` |
| `IMPL-1326` | Fail-closed behaviour where a decision cannot be obtained — including when `BC-18` is unavailable | P1 | `IMPL-1320` | `IMPL-1327`, `IMPL-1359` | `SECP-FR-028` | An unobtainable decision refuses; no degraded-mode allow path exists — `SECP-AC-051` |
| `IMPL-1327` | Fail-closed verified **per dependency**, with no bypass, override or emergency path accompanying it | P1 | `IMPL-1326` | `IMPL-1359` | `SECP-FR-029`, `SECP-BR-010`, `SECP-XC-022` | Each dependency has an absence test that refuses; no bypass exists — **"a control that has never been observed to refuse is not known to work"** — `SECP-AC-052`, `SECP-AC-053` |
| `IMPL-1328` | ⛔ Secret material held only in the platform vault and reachable only through it, with rotation as the sole remedy for an emitted secret | P1 | `IMPL-1308`, `IMPL-1300` | `IMPL-1357`, `IMPL-1359` | `SECP-FR-030`, `SECP-BR-011`, `SECP-XC-021` | No secret is readable outside the vault path; an emitted secret is treated as compromised and rotated — `SECP-AC-054`, `SECP-AC-055`. ⛔ **Blocked: `SECP-DEP-003`, vault port undeclared.** `SECP-XC-021` — no cipher suite or key length named |
| `IMPL-1329` | Service-to-service trust and security trust signals as **consumed** material, with no trust identity defined, issued or inferred here | P2 | `IMPL-1328` | `IMPL-1359` | `SECP-FR-084`, `SECP-XC-019`, `SECP-XC-020` | No service identity, certificate, mesh policy or network segment is definable; network segmentation and continuous verification remain **out of V1** — `SECP-AC-056`, `SECP-AC-057` |

### 5.4 Wave 4 — Application, API, validation, abuse limiting, session and data (`IMPL-1330` … `IMPL-1339`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1330` | Every security-relevant decision taken **server-side**, and no client-supplied value determining its own authority | P1 | `IMPL-1322` | `IMPL-1331`…`1334` | `SECP-FR-031`, `SECP-FR-032`, `SECP-BR-012` | An authority-determining field supplied by a client is ignored or refused — **"a field a client can set is a field an attacker can set"** — `SECP-AC-058`, `SECP-AC-059` |
| `IMPL-1331` | Caller data never interpreted as code, query, command, markup or template | P1 | `IMPL-1330` | `IMPL-1359` | `SECP-FR-033`, `SECP-XC-025` | Injection-shaped input is inert across every interpretation surface — `SECP-AC-060`. `SECP-XC-025` — **no library, parser, encoder or sanitiser is named** |
| `IMPL-1332` | State-changing requests not executable as a side effect of visiting a caller-controlled surface | P2 | `IMPL-1330` | `IMPL-1359` | `SECP-FR-034` | A cross-origin visit cannot trigger a state change — `SECP-AC-061` |
| `IMPL-1333` | Each OWASP Top 10 weakness class holding a **stated V1 position** in this module's scope — a position, not a claim of immunity | P2 | `IMPL-1330` | `IMPL-1359` | `SECP-FR-035` | All ten classes have an explicit stated position; **none is stated as "eliminated"** — `SECP-AC-062`; Part 8 §8.1 prohibited vocabulary |
| `IMPL-1334` | Responses disclosing no internal implementation detail, and encrypted transport with a refusal on plaintext arrival | P2 | `IMPL-1330` | `IMPL-1335`, `IMPL-1359` | `SECP-FR-036`, `SECP-FR-037`, `SECP-FR-038` | No stack trace, framework version or internal identifier is emitted; a plaintext request is refused; security headers apply by default and cannot be removed per-route — `SECP-AC-063`…`065`. `SECP-XC-025` — **no header value named** |
| `IMPL-1335` | Declared-shape validation before any business logic, refusing the **whole** request on failure | P1 | `IMPL-1334` | `IMPL-1336`, `IMPL-1359` | `SECP-FR-039`, `SECP-FR-040`, `SECP-BR-013` | A multi-item request fails entirely rather than partially; **validation is a gate, not a filter** — a validator that strips and proceeds is a defect — `SECP-AC-066`, `SECP-AC-067` |
| `IMPL-1336` | Unrecognised fields not silently accepted, and validation applied identically regardless of origin, client type or channel | P2 | `IMPL-1317`, `IMPL-1335` | `IMPL-1359` | `SECP-FR-041`, `SECP-FR-042` | An unknown field does not pass through unexamined; an internal caller receives identical validation to an external one — `SECP-AC-068`, `SECP-AC-069` |
| `IMPL-1337` | Abuse limiting on disproportionate-cost operations outside the authentication path, exhibiting the four `PRD-001` properties | P2 | `IMPL-1335` | `IMPL-1338`, `IMPL-1359` | `SECP-FR-043`, `SECP-FR-044` | Each qualifying operation carries a limit with all four properties; the limit is **consumed** from `PRD-001`, not redefined — `SECP-AC-070`, `SECP-AC-071` |
| `IMPL-1338` | A limit scoped so one tenant's abuse cannot exhaust another tenant's allowance | P2 | `IMPL-1337` | `IMPL-1359` | `SECP-FR-045` | Tenant A saturating a limit leaves tenant B unaffected — `SECP-AC-072`; `MP-GBR-08` |
| `IMPL-1339` | Session identifiers and credentials absent from URLs, query strings, referrers and logs; sensitive data handled without a continued-entitlement assumption | P1 | `IMPL-1336` | `IMPL-1344`, `IMPL-1359` | `SECP-FR-046`, `SECP-BR-014`, `SECP-XC-023`, `SECP-XC-024` | No identifier appears in any of the four surfaces; **a session's existence is not evidence of continued entitlement**; no WAF, DDoS, PII-inventory or data-subject programme is claimed — `SECP-AC-073`…`076` |

### 5.5 Wave 5 — Signals, detection, monitoring, severity, escalation (`IMPL-1340` … `IMPL-1347`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1340` | The V1 signal set **exactly `SECP-SIG-001`…`010`**, enforced as a closed register | P1 | `IMPL-1300` | `IMPL-1341`…`1347` | `SECP-FR-047`, `SECP-BR-016`, `SECP-SIG-001`…`010` | The emitted signal type set equals the ten exactly; an eleventh fails — **closure binds the register, not the condition** — `SECP-AC-077`. ⚠ **Closed register: a new signal requires an amendment** |
| `IMPL-1341` | Each signal emitted at the point of detection, and **unsuppressible by any role** including Platform Administrator | P1 | `IMPL-1315`, `IMPL-1325`, `IMPL-1340` | `IMPL-1348`, `IMPL-1359` | `SECP-FR-048`, `SECP-FR-049` | Each of the ten emits at detection; no role, config or flag suppresses, filters or disables emission — `SECP-AC-078`, `SECP-AC-079` |
| `IMPL-1342` | ⛔ Brute-force and account-abuse conditions observable as signals — the one genuine V1 detection capability | P1 | `IMPL-1340` | `IMPL-1343`, `IMPL-1359` | `SECP-FR-050` | The abuse conditions produce `SECP-SIG-003` and its siblings — `SECP-AC-080`. ⛔ **Blocked: `SECP-DEP-003`** for the emission port |
| `IMPL-1343` | Detection aggregating across identifier **and** origin, so a distributed attack is not invisible per-key | P2 | `IMPL-1342` | `IMPL-1359` | `SECP-FR-051`, `SECP-BR-015` | An attack spread across identifiers and origins is detected; **an absent detection is recorded as absent, never as a threshold not reached** — `SECP-AC-081`, `SECP-AC-082` |
| `IMPL-1344` | Per-signal answerability over a stated window, with monitoring surfaces carrying **no** personal data, credential or session identifier | P2 | `IMPL-1307`, `IMPL-1339`, `IMPL-1340` | `IMPL-1359` | `SECP-FR-052`, `SECP-FR-053`, `SECP-XC-028` | Each of the ten is countable over a window; no monitoring surface carries any of the three — `SECP-AC-083`, `SECP-AC-084`. `SECP-XC-028` — **no metric name, query or retention period defined** |
| `IMPL-1345` | Exactly one severity class per signal from **`SECP-SEV-001`…`004`**, a closed scale reused rather than duplicated | P1 | `IMPL-1340` | `IMPL-1346`, `IMPL-1349`, `IMPL-1359` | `SECP-FR-055`, `SECP-SEV-001`…`004`, `SECP-XC-032` | Every signal carries exactly one of the four; a second scale is not definable — `SECP-AC-086`. `SECP-XC-032` — **no second scale, no SLA** |
| `IMPL-1346` | ⛔ `SECP-SEV-001` and `SECP-SEV-002` emitted without threshold, aggregation delay or batching | P2 | `IMPL-1345` | `IMPL-1347`, `IMPL-1359` | `SECP-FR-056`, `SECP-FR-054` | The two highest classes emit immediately; **absence of signals is never presented as absence of attack** — `SECP-AC-087`, `SECP-AC-085`. ⛔ **Partially blocked: `SECP-DEP-001`, `SECP-GAP-031` open** |
| `IMPL-1347` | ⛔ Escalation determined by severity class alone, never by which component detected the condition | P2 | `IMPL-1346` | `IMPL-1353`, `IMPL-1359` | `SECP-FR-057`, `SECP-XC-027`, `SECP-XC-029` | Escalation is a function of severity only; no anomaly detection or behavioural baselining is claimed; **alert routing and on-call remain unowned** — `SECP-AC-088`…`090`. ⛔ **Partially blocked: `SECP-DEP-001`** |

### 5.6 Wave 6 — Automated response and incident containment (`IMPL-1348` … `IMPL-1353`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1348` | The automated response set **exactly the four** `SECP-FR-058` names, invoking only capabilities that already exist at V1 and are owned elsewhere | P1 | `IMPL-1341` | `IMPL-1349`…`1353` | `SECP-FR-058`, `SECP-FR-059`, `SECP-BR-018` | The invocable response set equals the four; a fifth fails; no response invents a capability — `SECP-AC-091`, `SECP-AC-092` |
| `IMPL-1349` | Every response attributable to the **signal** that triggered it, and severity inherited from that signal rather than reassigned | P1 | `IMPL-1345`, `IMPL-1348` | `IMPL-1359` | `SECP-FR-060`, `SECP-FR-063`, `SECP-BR-021` | The audit record names the triggering signal; **severity is assigned once, at the signal, and not renegotiated downstream** — `SECP-AC-093`, `SECP-AC-097` |
| `IMPL-1350` | Every response reversible by an authorised human, or else bounded — and **never** reversible via a break-glass path | P2 | `IMPL-1318`, `IMPL-1348` | `IMPL-1359` | `SECP-FR-061`, `SECP-BR-020` | Each response is reversible or bounded; **no response grants access, weakens a control or opens a path** — `SECP-AC-094`, `SECP-AC-095` |
| `IMPL-1351` | Fail-safe response: an unperformable response refuses rather than degrades open, and is never triggered by a signal the platform cannot produce | P1 | `IMPL-1348` | `IMPL-1359` | `SECP-FR-062`, `SECP-BR-019` | An unavailable response fails safe; a response bound to an unproducible signal is unreachable — **fail-safe, not fail-open** — `SECP-AC-096` |
| `IMPL-1352` | Containment via the `SECP-FR-058` mechanisms only, preserving tenant isolation **without exception** including under degraded operation, and bounded by an existing configuration parameter | P1 | `IMPL-1305`, `IMPL-1348` | `IMPL-1359` | `SECP-FR-064`, `SECP-FR-065`, `SECP-FR-066`, `SECP-XC-030` | Containment uses no mechanism outside the four; isolation holds under degradation; each action is time- or scope-bounded by a **`BC-25`-owned** parameter, none minted here — `SECP-AC-098`…`101` |
| `IMPL-1353` | ⛔ The four-stage response lifecycle, each stage independently determinable from the audit record, with escalation on every `SEV-001`/`002` | P2 | `IMPL-1347`, `IMPL-1352` | `IMPL-1359` | `SECP-FR-067`, `SECP-FR-068`, `SECP-FR-069`, `SECP-XC-031`, `SECP-XC-033` | Each stage's completion is determinable; escalation occurs regardless of who noticed; **recovery resurrects no erased account, terminated session or revoked role**; no playbook or forensic procedure is specified — `SECP-AC-102`…`106`. ⛔ **Partially blocked: `SECP-DEP-001`** |

### 5.7 Wave 7 — Audit emission, test classes, supply chain, resilience, harness (`IMPL-1354` … `IMPL-1359`)

| Task | Scope | Priority | Blocked by | Blocks | Requirements | Test requirement |
|---|---|---|---|---|---|---|
| `IMPL-1354` | ⛔ The declared list of audit-relevant occurrences this module emits, each attributable, with automation identified as automation — and **no local copy of any audit entry** | P1 | `IMPL-1300`, `IMPL-1303` | `IMPL-1355`, `IMPL-1359` | `SECP-FR-070`, `SECP-FR-071`, `SECP-FR-072`, `SECP-FR-073`, `SECP-BR-022` | Every occurrence emits with sufficient attribution; automation is distinguishable from a person; **no audit copy or projection exists here** — `SECP-AC-107`…`110`; owner `BC-24`. ⛔ **Blocked: `SECP-DEP-003`;** completeness also awaits `SECP-DEP-005` |
| `IMPL-1355` | The security test classes **exactly `SECP-TST-001`…`008`**, each with at least one **negative** case asserting refusal, and regression coverage for every fixed defect | P1 | `IMPL-1354` | `IMPL-1356`, `IMPL-1359` | `SECP-FR-074`, `SECP-FR-075`, `SECP-FR-076`, `SECP-BR-023`, `SECP-TST-001`…`008` | All eight classes exist; a class with no refusal assertion fails; each fixed defect has a regression test — **the set is closed; a ninth class is an amendment** — `SECP-AC-111`…`114` |
| `IMPL-1356` | Adversarial negative cases standing **in place of** penetration testing at V1 — recorded as a substitution, not as equivalence | P2 | `IMPL-1355` | `IMPL-1359` | `SECP-FR-077`, `SECP-XC-034`, `SECP-XC-035` | The adversarial cases run in CI; **no penetration test, SAST or DAST programme is required, scheduled or claimed** — `SECP-AC-115`, `SECP-AC-116` |
| `IMPL-1357` | Pinned dependencies, a change treated as a security-relevant change, secrets absent from every build artefact and pipeline surface, and a bounded-control config change gated | P1 | `IMPL-1308`, `IMPL-1328` | `IMPL-1359` | `SECP-FR-078`, `SECP-FR-079`, `SECP-FR-080`, `SECP-FR-081`, `SECP-BR-024`, `SECP-XC-036` | Versions are explicit; a version, cache-key, index or namespace change trips the security path; no secret appears in an artefact, pipeline definition, log or cache; **a control bounded by a configurable is only as strong as its weakest permitted value** — `SECP-AC-117`…`120`. `SECP-XC-036` — no hardening baseline specified |
| `IMPL-1358` | Backups preserving tenant isolation, encrypted at rest, and never a route around a live control | P2 | `IMPL-1357` | `IMPL-1359` | `SECP-FR-082`, `SECP-FR-083`, `SECP-XC-037`, `SECP-BR-025` | A backup carries no cross-tenant reach and is encrypted; restoring does not bypass a control; **no RTO, RPO or DR plan is specified** — `SECP-AC-121`…`123`; register continuity per `SECP-FR-083` |
| `IMPL-1359` | The acceptance harness — bind each of the **128** `SECP-AC-*` to a named running test, and prove the module's three highest-severity properties as wholes: `ID-1` credential exclusion, `X-13` tenant confinement, and the break-glass impossibility | P1 | *every otherwise-terminal task* — computed, see note | — | `SECP-XC-001`, `SECP-XC-003`, `SECP-XC-014`, `SECP-AC-124` | All 128 criteria bound to CI tests; an unbound criterion fails the harness; `SECP-AC-124`'s **standing obligation** is re-evaluated on every run |

> **`IMPL-1359`'s `Blocked by` list is computed, not written.** It is *every otherwise-terminal task* in the graph —
> every task that blocks nothing else — derived from the dependency edges rather than typed. `PRD-007`'s backlog records
> a defect caught exactly here: a hand-written harness edge list omitted the multi-tenancy task although its criteria
> required it. Deriving the list makes that omission impossible rather than unlikely.

---

## 6. Traceability — task group → requirements → invariants → acceptance

Allocation rule 4 requires this table.

| Wave | Tasks | Requirements claimed | Invariants enforced | Acceptance criteria proven |
|---|---|---|---|---|
| **1** Ownership boundary, ten Part 1 exclusions | `IMPL-1300`–`1309` | `SECP-FR-084`, `SECP-XC-001`…`012` | ⚠ **none declared** — §6.1 | `SECP-AC-001`…`014`, `SECP-AC-128` |
| **2** Platform-admin privilege, `SECP-HRO-*`, break-glass | `IMPL-1310`–`1319` | `SECP-FR-001`…`018`, `SECP-BR-001`…`008`, `SECP-HRO-001`…`012`, `SECP-XC-013`…`018` | ⚠ **none declared** | `SECP-AC-015`…`041` |
| **3** Authorisation gating, isolation, fail-closed, secrets | `IMPL-1320`–`1329` | `SECP-FR-019`…`030`, `SECP-FR-084`, `SECP-BR-009`…`011`, `SECP-XC-019`…`022` | ⚠ **none declared** | `SECP-AC-042`…`057` |
| **4** Application, API, validation, abuse, session, data | `IMPL-1330`–`1339` | `SECP-FR-031`…`046`, `SECP-BR-012`…`014`, `SECP-XC-023`…`026` | ⚠ **none declared** | `SECP-AC-058`…`076` |
| **5** Signals, detection, monitoring, severity, escalation | `IMPL-1340`–`1347` | `SECP-FR-047`…`057`, `SECP-BR-015`…`017`, `SECP-SIG-001`…`010`, `SECP-SEV-001`…`004`, `SECP-XC-027`…`029`, `SECP-XC-032` | ⚠ **none declared** | `SECP-AC-077`…`090` |
| **6** Automated response, containment | `IMPL-1348`–`1353` | `SECP-FR-058`…`069`, `SECP-BR-018`…`021`, `SECP-XC-030`, `SECP-XC-031`, `SECP-XC-033` | ⚠ **none declared** | `SECP-AC-091`…`106` |
| **7** Audit emission, tests, supply chain, resilience, harness | `IMPL-1354`–`1359` | `SECP-FR-070`…`083`, `SECP-BR-022`…`025`, `SECP-TST-001`…`008`, `SECP-XC-034`…`037` | ⚠ **none declared** | `SECP-AC-107`…`127` |
| **Total** | **60** | **109 normative + 37 exclusions = 146** | **0 — by design** | **128 of 128 mapped · 0 proven** |

### 6.1 The invariants column is empty, and that is a measured fact rather than an omission

`PRD_LIFECYCLE.md` Stage 6 allocation rule 4 requires a table mapping *"task groups → requirements → invariants →
acceptance."* Three of the four columns are populated. The invariants column is not, because **`SECP-INV-*` contains
zero members** — deliberately, and with a published reason:

> `SECP-GAP-010` — an invariant requires an aggregate to be invariant **over**. `PRD-012a` owns no aggregate
> (`SECP-FR-084`), so a `SECP-INV-*` member would assert ownership the PRD explicitly disclaims.

The honest options were to leave the column empty with this explanation, or to mint invariants so the table looked
complete. **Minting them would have been the more serious defect**: `PRD_LIFECYCLE.md` §5 rule 6 states that a register
declared closed may not be extended without an ADR, and Part 8's `SECP-BR-025` states that *"a citation is not a
declaration, and a 'not declared' note must not mint an identifier."* A backlog inventing four invariants to fill a
column would have created the exact class of defect this repository's `PGA-01`/`PGA-02` precedent exists to prevent.

⚠ **The properties that would be invariants elsewhere are instead enforced as exclusions.** `SECP-XC-001` (no
credential), `SECP-XC-003` (no authorisation outcome), `SECP-XC-004` (no audit mutation) and `SECP-XC-014` (no
break-glass) are structural impossibilities enforced by `IMPL-1301`, `IMPL-1302`, `IMPL-1303` and `IMPL-1318`, and
proven as wholes by `IMPL-1359`. The enforcement exists; only the register naming it does not.

---

## 7. Dependency graph

Every figure below was **recomputed from the parsed table**, not written by hand. Four of them were wrong on first
writing and are corrected here rather than quietly adjusted — §10 `S6-5` records the defect.

| Measure | Value |
|---|---|
| Tasks | **60** |
| Dependency edges | **141** — the union of both directions, self-edges removed |
| Cycles | **0** |
| Roots (no `Blocked by`) | **1** — `IMPL-1300` |
| Leaves (no `Blocks`) | **1** — `IMPL-1359` |
| Longest chain | **14** nodes — `IMPL-1300` → `1302` → `1320` → `1321`/`1322` → `1330` → `1334` → `1335` → `1336` → `1337` → `1338` → … → `1359` |
| Tasks blocked on an external decision | **8** — marked ⛔ |
| `P1` / `P2` / `P3` | **36 / 23 / 1** |

---

## 8. What this document does **not** confer

| It does not | Because |
|---|---|
| Advance `PRD-012a` beyond Stage 6 | Stage 7's gate is a row in `DOCUMENTATION_BASELINE.md` §3, and *"freeze is conferred, not claimed"* |
| Change the registry status | `PRD_REGISTRY.md` §4.1 L260 still reads `PLANNED`. This document writes nothing there |
| Cure the Stage 1 gate | `SECP-GAP-041` remains open; only `SECP-ADR-001` can close it |
| Close any of the 44 `SECP-GAP-*` | A backlog schedules; it does not decide |
| Declare `platform/security`'s outbound ports | `SECP-DEP-003` belongs to the Architecture Owner. §4.2 |
| Prove any acceptance criterion | 0 of 128. Stage 9 proves criteria; Stage 6 maps them |
| Authorise any code change | Stage 8 is not started. Nothing under `lib/` was touched |
| Correct `PRD_LIFECYCLE.md`'s stale allocation table | Rank 1. Baseline §7 rule 1 requires an ADR **before** the change |

---

## 9. Tasks that must **not** exist

| Absent task | Why it must stay absent |
|---|---|
| Define a `BC-nn` for the SECURITY platform | `SECP-ADR-001`'s question. Creating one by implementation choice would answer an Architecture Owner's question |
| Add a `platform/security:` block to `tool/module_dependencies.yaml` | `SECP-DEP-003`. The manifest is the enforced architecture; editing it here would grant the module its own permissions |
| Name a library, framework, parser, encoder, sanitiser or header value | `SECP-XC-025` |
| Specify a cipher suite, key length or rotation interval | `SECP-XC-021` |
| Define a metric name, dashboard, query, log format or retention period | `SECP-XC-028` |
| Mint a `SECP-CFG-*` parameter | `SECP-XC-014` reasoning: every parameter relied on is already a `PRD-001` or `BC-25` configurable |
| Mint a `SECP-EVT-*` event | `SECP-OWN-023` — an event needs a BC Map §9 producer row, and this module has no `BC-nn` |
| Mint a `SECP-INV-*` invariant | §6.1 |
| Add a thirteenth `SECP-HRO-*`, an eleventh `SECP-SIG-*`, a fifth `SECP-SEV-*` or a ninth `SECP-TST-*` | Four closed registers. §5 rule 6 — an ADR is required |
| Implement a break-glass path "for incident response" | `SECP-XC-014`; `PRD_LIFECYCLE.md` §7 — *"`X-13` and `ID-1` are never waived under time pressure"* |
| Repair the stale `IMPL-227+` table in `PRD_LIFECYCLE.md` | Rank 1, needs an ADR first |

---

## 10. Findings carried forward

| ID | Finding | Severity | Owner |
|---|---|---|---|
| `S6-1` | `PRD_LIFECYCLE.md`'s Stage 6 allocation table is stale — it ends at `IMPL-227` + "Unallocated" while 610 distinct `IMPL-*` exist and eight module backlogs sit above it. Not corrected: Rank 1 needs an ADR first | **LOW** — navigational; no allocation was taken from it | Governance Owner |
| `S6-2` | 8 of 60 tasks are blocked on an Architecture Owner or `BC-18` owner decision (§4.2). The backlog is complete but **not startable in full** | **MEDIUM** | Architecture Owner |
| `S6-3` | The invariants column of the rule-4 table is empty because `SECP-INV-*` is empty by design (§6.1). No invariant was minted to fill it | **LOW** — disclosed | — |
| `S6-4` | Stage 1's gate was never met (`SECP-GAP-041`). This backlog neither cures nor contradicts it | **HIGH** | Architecture Owner, via `SECP-ADR-001` |
| `S6-5` | **Five self-inflicted defects in this document, all caught by mechanically recomputing its own published figures before the gate record was written.** (1) `P1`/`P2`/`P3` published as `28/30/2`; actual **`36/23/1`**. (2) Edges published as `112`; actual **`141`**. (3) Longest chain published as `7`; actual **`14`**. (4) **14 obligations — `SECP-XC-021`/`025`/`026`/`028`/`032`/`036` and all eight `SECP-TST-*` — were cited only in `Scope` or `Test requirement` cells, not in the `Requirements` column the gate measures.** Six task rows were corrected so the claim is true where the gate reads it. (5) The §4.1 total was stated before the column audit and happened to be right for the wrong reason. **All five were defects in this document, not in `PRD-012a`** — the subject is byte-unchanged | **Disclosed, corrected** | This document |

⚠ **`S6-5` is the reason §7 says every figure was recomputed rather than written.** Four of five published graph figures
were wrong on first writing, and the fourth defect would have produced a **false gate pass**: a reader trusting the
§4.1 total would have believed 146 obligations were claimed where the gate reads them, when 132 were. The same working
rule the Stage 4 review recorded applies in reverse here — *when the instrument disagrees with the document, verify the
instrument* — but its converse holds too: **when the document publishes a number, recompute it before certifying it.**

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created. Stage 6 of 9. Allocates **`IMPL-1300` … `IMPL-1359`** — 60 tasks, contiguous, plus reserve `IMPL-1360`…`1399` — computed from an enumeration of **610** distinct `IMPL-*` across `docs/ tool/ lib/ test/ packages/`, with the single prior `IMPL-1300` occurrence at `PRD-017_IMPLEMENTATION_TASKS.md:98` disclosed as a boundary label rather than filtered out. `PRD-017`'s reserve `IMPL-1261`…`1299` left wholly intact per allocation rule 2. Claims **109** normative requirements (84 `SECP-FR-*` + 25 `SECP-BR-*`) and **37** `SECP-XC-*` = **146 obligations, 100.0%**; maps **128 of 128** `SECP-AC-*`; **proves 0**. Records `Priority`, `Blocks` and `Blocked by` on all 60 per allocation rule 3 — **112 edges, 0 cycles, 1 root, 1 leaf, longest chain 7**. The rule-4 traceability table's **invariants column is empty and says why**: `SECP-INV-*` has zero members by design (`SECP-GAP-010`), and minting invariants to fill a column would breach §5 rule 6 and `SECP-BR-025`. **8 tasks marked ⛔ blocked** on `SECP-DEP-001`/`002`/`003` — chiefly the absent `platform/security:` block under `default_decision: deny`. Stage 1's unmet gate disclosed as a fact and **not** treated as a prohibition, following `ADR-0050` §5's withdrawal of `PRD-013`'s absence-is-prohibition reasoning. `PRD_LIFECYCLE.md`'s stale `IMPL-227+` table recorded as `S6-1` and **not corrected** — Rank 1 requires an ADR first. **Confers nothing**: no registry status written, no gap closed, no port declared, no `BC-nn` created, no `SECP-CFG-*`/`EVT-*`/`INV-*` minted, no closed register extended, no acceptance criterion proven, no line under `lib/` touched. Subject Parts 1–8 byte-unchanged — Part 1 `dbd01d4d…82d452`, Part 8 `a8c45d79…4e7c7977`. |
