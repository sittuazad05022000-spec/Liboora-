# `PRD-012a` Security Automation — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Document** | `PRD-012a_ARCHITECTURE_ALIGNMENT.md` |
| **Subject** | `PRD-012a` Security Automation, Parts 1–8, **v0.8 `DRAFT`** — `docs/30-product/security/PRD-012a_*.md` (8 files, 3,670 lines) |
| **Stage** | **3 of 9 — Architecture Review** (`PRD_LIFECYCLE.md` §3, L87–106) |
| **Gate** | *"a written alignment record naming every conflict and its disposition"* (L101–102) |
| **Gate satisfied by** | **This document.** Worked examples cited by the lifecycle: `LIBRARY_PRD_ALIGNMENT.md`, `STUDENT_IDENTITY_ALIGNMENT.md` |
| **Verdict** | ⚠ **ALIGNED WITH ONE STRUCTURAL FINDING — 5 of 6 checks PASS, 1 PASS-BY-CONSTRUCTION-WITH-FINDING** |
| **Findings** | **3 accepted** (`A3-1`, `A3-2`, `A3-3`) · **4 rejected with reasons** (`R3-1`…`R3-4`) |
| **Conflicts resolved by this record** | **ZERO.** Every conflict is routed, none decided — `DOCUMENTATION_BASELINE.md` L253 |
| **Subject hash on entry** | See §8.1 — measured per file, not asserted |
| **Reviewed at** | `bd85a31d0b93da809706cf351a282adedb05149a`, working tree clean |
| **Registry status this permits** | `IN_REVIEW` — *not written by this pass; see §9* |
| **Subject modified** | **No.** Zero bytes of Parts 1–8 changed to produce this record |
| **Code modified** | **No.** Zero files under `lib/`, `test/`, `packages/`, `web/` |
| **Authority of this record** | **Unranked. Navigational and evidential only.** It records that the Stage 3 gate was met. It confers no rank, no status and no approval |
| **Date** | 2026-08-21 |

---

## 1. What Stage 3 actually requires

`PRD_LIFECYCLE.md` L41–42 defines what a gate is, and the definition is not negotiable:

> Each transition has a **gate**: a named artefact that must exist. A gate is not an opinion — if the artefact does
> not exist, the stage has not been passed, **however complete the work feels**.

L89 states what Stage 3 validates: *"the PRD against Ranks 1–5, in this order"* — six named checks in a fixed
sequence, each with a named authority and a named failure mode. L101–102 states the exit gate: a written alignment
record **naming every conflict and its disposition**.

And L104–106 states the obligation that makes such a record honest:

> **A rejected finding must be recorded as rejected, with its reason.** […] A review that records only accepted
> findings is indistinguishable from a review that found nothing.

This record therefore publishes **both** lists: three accepted findings in §4 and four rejected candidate findings
in §5, each with the evidence that defeated it.

### 1.1 What this record deliberately does not do

It does not resolve a single conflict. `PRD-012a` reaches Stage 3 already carrying three conflicts it declined to
decide (`SECP-GAP-023`, `SECP-GAP-031`, `SECP-GAP-042`), and this review adds none and closes none. The governing
rule is `DOCUMENTATION_BASELINE.md` **L253**:

> **A conflict is a defect.** If you find one, do not choose — raise it. The precedence order tells you which
> document is *wrong*, not which one to quietly ignore.

A Stage 3 reviewer holds *"authority to require an ADR"* (`PRD_LIFECYCLE.md` §6, L280). It does not hold authority
to amend the document the ADR would be about. Where this review finds that a higher-ranked document is wrong, it
says so and names the owner — it does not edit the higher-ranked document, and it does not weaken `PRD-012a` to make
the conflict disappear.

---

## 2. The six checks, in the order the lifecycle fixes them

`PRD_LIFECYCLE.md` L92–99, reproduced exactly, with the measured result against each:

| # | Check | Authority | Failure mode | Result |
|---|---|---|---|---|
| **C1** | Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate | ✅ **PASS** — §3.1 |
| **C2** | Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR | ✅ **PASS** — §3.2 |
| **C3** | Rank direction is downward | Dependency Matrix `L2` | Illegal import | ⚠ **PASS WITH FINDING `A3-1`** — §3.3 |
| **C4** | No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** | ✅ **PASS** — §3.4 |
| **C5** | No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited | ✅ **PASS** — §3.5 |
| **C6** | Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, **Critical** | ✅ **PASS** — §3.6 |

**Score: 5 PASS + 1 PASS-with-finding. Zero FAIL.**

### 2.1 The anomaly this review must confront before check C1

Every prior Stage 3 record in this repository reviewed a PRD that **owns a bounded context**. `PRD-012a` owns none,
and says so in its own header (Part 1 L14):

> **Owning bounded context** | **None.** See §0.5 — the SECURITY platform is a *platform*, not a bounded context;
> it appears in no `BC-nn` row of the Bounded Context Map

**Measured, not assumed:** the Bounded Context Map carries **87 `BC-nn` table rows** across its sections and **26
`E-nn` integration edges**. A case-insensitive search for a `BC-nn` row whose name contains *"security"* returns
**three** hits, and **none of them is a context definition**:

| Hit | Line | What it actually is |
|---|---|---|
| `ID-1` row | L178 | An identity **rule**, not a context |
| `BC-18` events row | L434 | `BC-18`'s event list, consumed by *"Security audit"* |
| `BC-01→09` scoping row | L486 | *"Row-level security"* — a mechanism |

So the SECURITY platform genuinely has no `BC-nn`. This does not defeat check C1 — it changes what C1 measures, and
that change is recorded as finding **`A3-1`** in §4.1 rather than glossed. `PRD-012a`'s authority to exist at all is
`PRD_REGISTRY.md` §4.1 (which reserves it) tracing to Rank 1 `MASTER_PRD.md` §8 Correction 2, **not** a BC Map row.

---

## 3. Check-by-check evidence

### 3.1 C1 — Context ownership is exclusive ✅ PASS

The failure mode is *"two PRDs own one aggregate."* `PRD-012a` cannot commit it, and the proof is structural rather
than argumentative: **it declares no aggregate at all.**

| Register | Declared count | Meaning |
|---|---|---|
| `SECP-INV-*` | **0 — deliberately empty** | No invariant ⇒ no aggregate. Reason published as `SECP-GAP-010` |
| `SECP-EVT-*` | **0 — deliberately empty** | `BC-nn` producer row absent. Reason published as `SECP-OWN-023` |
| `SECP-CFG-*` | **0 — deliberately empty** | Would duplicate `PRD-001`/`PRD-023`. Reason published as `SECP-XC-014` |

Measured against the subject: the three registers return **zero** occurrences of any `SECP-INV-`, `SECP-EVT-` or
`SECP-CFG-` identifier across all eight Parts. An empty register with a **published reason** is a finding, not an
omission — the standard `PRD-016` set when `AUD-EVT-*` and `AUD-CFG-*` were both admitted empty because `BC-24`
publishes nothing and no authority supplied a retention bound.

Positively, `PRD-012a` publishes **30 `SECP-OWN-*` boundaries** and **37 `SECP-XC-*` exclusions** that name what it
does *not* own, deferring to eleven distinct holders (Part 8 §3). `SECP-FR-084` makes the disclaimer normative:

> `PRD-012a` **SHALL NOT** be read as claiming ownership of any aggregate, context, parameter, event, record or
> capability listed above. Where a reader finds a Part appearing to specify one, the correct reading is a
> **citation plus a verification obligation**, and any text that cannot be so read is a defect to be raised.

That requirement is itself bound by `SECP-AC-128`, which requires all eleven deferral rows to be inspected and the
count of rows where a Part *specifies* rather than *cites* to be **zero**. **C1 passes on measurement, not on
assertion.**

### 3.2 C2 — Every integration edge exists in BC Map §7 ✅ PASS

The rule is absolute: *"If an edge is not in this table, it does not exist."* An edge not in §7 requires an ADR
before it may be relied on.

**Measured: the BC Map carries 26 `E-nn` edge rows, and `PRD-012a` adds zero.** It declares no `SECP-EVT-*`, so it
publishes nothing; and its consumption of other contexts' surfaces is expressed as **deferral** (`SECP-OWN-*`) or
**exclusion** (`SECP-XC-*`), not as a new edge. This matches the `PRD-016` precedent exactly, where `E-20` was
*"consumed, not created"* and the module added **0** edges.

**C2 passes.** No `SECP-ADR-*` request in Parts 1–8 asks for an edge.

### 3.3 C3 — Rank direction is downward ⚠ PASS WITH FINDING `A3-1`

The Dependency Matrix rule `L2` forbids an upward import. `PRD-012a` is a specification, not code, so the check
applies to the **module rank** it specifies against: `tool/module_dependencies.yaml` L30 places
`platform/security: 2`.

Measured against the manifest:

| Fact | Line | Consequence |
|---|---|---|
| `default_decision: deny` | L21 | Anything not explicitly allowed is refused |
| `platform/security: 2` | L30 | The rank exists in the rank list |
| `platform/security:crypto` consumed | L107, L181, L239 | Other modules already depend on it |
| `platform/security:secrets` consumed | L278 | " |
| `platform/security:pii_redaction` consumed | L279 | " |
| **A `platform/security:` block of its own** | **absent** | ⚠ **the finding** |

`platform/security` is ranked and is consumed by five declared ports, but **has no manifest block declaring what it
may itself import.** Under `default_decision: deny` the module is therefore specified as importing nothing, which is
not a statement anyone made deliberately.

This is **not a new finding of this review** — `PRD-012a` found it during drafting and raised it as `SECP-GAP-042`,
routed to the Architecture Owner as `SECP-ADR-004`. This review **confirms it independently** and records it as
`A3-1`. The direction of the rank is not violated by anything `PRD-012a` says; the manifest is simply silent where it
should speak. **The check passes; the manifest gap is carried, not cured.** Curing it means editing a Rank 4-governed
enforcement artefact, which is the Architecture Owner's act and requires an ADR.

### 3.4 C4 — No authorisation decided outside `BC-18` ✅ PASS

The lifecycle names this failure the most dangerous of the six: *"**A security defect that passes its own tests**."*
A document that quietly decides authorisation outside `BC-18` will satisfy every acceptance criterion it writes,
because it wrote them.

`PRD-012a` is a security PRD, which is precisely the document most tempted to decide authorisation. It does not, and
the separation is drawn inside the requirements themselves rather than added as a caveat. `SECP-FR-008`:

> Every authorisation decision on a privileged path **MUST** be reached server-side. A client-supplied claim of
> platform role, elevation state, tenant or permission **MUST NOT** be accepted as evidence of that state
> — owner column: **SECURITY (enforcement) + `BC-18` (decision)**

The owner column splits the two rights explicitly: **`BC-18` decides, SECURITY enforces.** `SECP-FR-010` continues
the pattern — *"Authority **MUST** be re-asserted at each decision point"* — with owner *"`BC-18` + SECURITY
(verification)."* And `SECP-OWN-016`, `SECP-OWN-019` and `SECP-OWN-026` defer to `BC-18` the whole list: *"Roles,
permissions, policy, sessions, credentials, devices, decisions, authentication rate limits."*

Two business rules make the default safe rather than merely stated:

- **`SECP-BR-002`** — ambiguity between two applicable rules resolves to **denial** (cites `AUTH-2.26`)
- **`SECP-BR-003`** — absence of an explicit grant on a privileged path is **refusal**, matching
  `tool/module_dependencies.yaml` L21 `default_decision: deny`

`SECP-FR-009` closes the remaining hole: unavailability of the decision point **MUST** produce refusal, *"never a
permissive default."* **C4 passes**, and it passes because the document routes the decision rather than making it.

### 3.5 C5 — No credential, OTP or session outside `BC-18` ✅ PASS

BC Map **L178**, rule `ID-1`, verbatim:

> No context outside BC-18 may store a password, OTP, session or credential. | Enforcement: Security review +
> schema scan in CI

`SECP-OWN-016`/`019`/`026` defer credentials, sessions and devices to `BC-18` by name. `SECP-XC-014` excludes the
`SECP-CFG-*` register entirely on the ground that it would duplicate `PRD-001`/`PRD-023` parameters — which also
removes the most likely accidental route to holding a credential value in a configuration key. Part 2's break-glass
decision is the sharpest evidence: `PRD-012a` **prohibits** a break-glass credential rather than specifying one,
following `AUTH-11.53`/`11.54`.

`PRD_LIFECYCLE.md` §7 L292 is the reason this check gets no benefit of the doubt at any stage:

> emergency security correction — *"Stages 3 and 7 still apply. **`X-13` and `ID-1` are never waived under time
> pressure**"*

**C5 passes.** Zero credential, OTP or session storage is specified anywhere in Parts 1–8.

### 3.6 C6 — Tenant scoping correct ✅ PASS

Failure mode: *"Cross-tenant leak — `MP-RSK-01`, **Critical**."* Authorities: `MP-GBR-08` and forbidden edge `X-13`.
BC Map L486 fixes the mechanism for `BC-01→09`: *"**Tenant-scoped.** Every row carries `tenantId`. Row-level
security + mandatory `TenantContext` in repository base class."*

`PRD-012a` does not define the tenant concept, the partitioning mechanism or row-level security — `SECP-OWN-017`
defers all three to `BC-19` Tenancy (`PRD-013`, **FROZEN**) plus the DATA platform. What it retains is the
**verification** obligation, which is the correct half for a platform that enforces rather than models.

`ARCHITECTURE_RULINGS.md` L116 is quoted here because it governs the boundary this check polices: the tenant-index
ruling *"does **not** relax `MP-GBR-08`, `SE-1` or `X-13` for tenant operational"* data. `PRD-012a` relaxes nothing.

⚠ **One conflict sits on this check and is routed, not resolved.** `SECP-GAP-023` records that `MP-RSK-01` rates a
cross-tenant leak **Critical** at **Rank 1**, while the EA at **Rank 6** tags `Cross-Tenant Leak Tests` **V2**. A
Critical Rank 1 risk whose test suite is deferred to V2 is a conflict on its face. `PRD-012a` scoped itself to
module-level tests only and raised the conflict rather than promoting the V2 capability (which the governance rules
forbid) or ignoring the Rank 1 rating (which L253 forbids). **This review upholds that disposition** and re-routes
it in §6 as `A3-2`. **C6 passes; the conflict is carried.**

---

## 4. Accepted findings

### 4.1 `A3-1` — `platform/security` has no manifest block while `default_decision: deny` stands

| Field | Value |
|---|---|
| **Severity** | **HIGH** — an enforcement artefact is silent about a ranked module |
| **Evidence** | `tool/module_dependencies.yaml` L21, L30; five consumed ports at L107, L181, L239, L278, L279; **no `platform/security:` key** |
| **Already raised by the subject as** | `SECP-GAP-042` → `SECP-ADR-004` |
| **Owner** | **Architecture Owner** |
| **Disposition** | ⛔ **CARRIED, NOT CURED.** Requires an ADR before the manifest is edited |
| **Why this review does not fix it** | Editing the manifest is an architecture change. `PRD_LIFECYCLE.md` §6 L280 gives a Stage 3 reviewer *authority to require an ADR* — not authority to make the change the ADR would authorise |

### 4.2 `A3-2` — Rank 1 `MP-RSK-01` Critical vs Rank 6 EA `Cross-Tenant Leak Tests` V2

| Field | Value |
|---|---|
| **Severity** | **HIGH** — a Critical Rank 1 risk with a V2-deferred test suite |
| **Already raised by the subject as** | `SECP-GAP-023` |
| **Owner** | **Architecture Owner** + **Product Owner** (scope) |
| **Disposition** | ⛔ **ROUTED.** Rank 1 outranks Rank 6, so the *likely* correction is to the EA — but L253 forbids this document from choosing |
| **What `PRD-012a` did correctly** | Scoped itself to module-level tests; did **not** promote the V2 capability to V1; did **not** silently downgrade the Rank 1 rating |

### 4.3 `A3-3` — Rank 3 FROZEN `AUTH-11.26`…`11.28` alertability vs Rank 6 EA `Alerting` V2

| Field | Value |
|---|---|
| **Severity** | **HIGH** — a frozen Rank 3 requirement whose enabling capability the EA defers |
| **Already raised by the subject as** | `SECP-GAP-031` → `SECP-ADR-002`, `SECP-DEP-001` |
| **Owner** | **Architecture Owner** (EA is Rank 6, *Descriptive*) |
| **Disposition** | ⛔ **ROUTED.** Part 8 §4.1 states the reasoning this review endorses without extending |
| **Note** | The EA is *"**Descriptive** — must follow the PRDs, never lead them"* (baseline §3.2). That makes the EA the *probable* wrong document — **probable is not a decision** |

**All three accepted findings were found by the subject itself before this review and are confirmed here
independently.** That is worth recording positively: a Stage 3 review whose findings are all new would suggest the
draft had not been self-checked; a review that confirms the draft's own findings by a different route is evidence
the draft's disclosures are honest.

---

## 5. Rejected candidate findings — recorded as rejected, with reasons

`PRD_LIFECYCLE.md` L104–106 requires this section to exist. Four candidate findings were raised during this review
and **defeated by evidence**. They are recorded so the review is distinguishable from one that found nothing.

### `R3-1` — *"`PRD-012a` violates C1 because it owns no bounded context"* — **REJECTED**

The check is *"context ownership is **exclusive**"*, whose failure mode is *"two PRDs own one aggregate."* Owning
**zero** aggregates cannot produce two owners for one. The candidate finding silently rewrote the check from
*exclusive* to *present*.

More importantly, it repeats a **named prior error**. `PRD-013_STAGE7_BLOCKER.md` was later **superseded** for
exactly this inference pattern: it measured a true absence (no v0.x document had ever been baselined) and treated
that absence as a **prohibition**. `ADR-0050` §5 withdrew the blocker as *"an invented rule."* No repository rule
requires a PRD to own a bounded context in order to pass Stage 3 — and `PRD_REGISTRY.md` §4.1 affirmatively reserves
`PRD-012a` for the SECURITY platform *"(rank 2)"*, a platform and not a context, on Rank 1 authority.

**Rejected.** The absence is real, is disclosed by the subject, and is recorded as `A3-1`'s context — but it is not
a C1 failure.

### `R3-2` — *"`SECP-FR-008` decides authorisation, violating `X-13`/C4"* — **REJECTED**

Read in full, `SECP-FR-008` constrains **where a decision may be trusted from** (server-side, not a client claim)
and its owner column reads *"SECURITY (enforcement) + `BC-18` (decision)"*. Requiring that a decision be obtained
from the decision point is the opposite of making the decision. `SECP-FR-009` reinforces this by making an
unobtainable decision a **refusal** rather than a locally-computed fallback — which is precisely what a document
that had usurped the decision would not need.

**Rejected.** Enforcing a decision is not making one.

### `R3-3` — *"`SECP-BR-003` restates `tool/module_dependencies.yaml` L21, so it is a second source of truth"* — **REJECTED**

`SECP-BR-003` reads *"matching `tool/module_dependencies.yaml` L21 `default_decision: deny`"*. A stated **match with
a citation** is alignment evidence, not a competing definition — and the manifest is a *code enforcement artefact*,
not a requirements register, so the two are not the same kind of statement. The genuine no-restatement check belongs
to **Stage 4** (*"No requirement restates another PRD's"*), where it is applied in the Stage 4 record.

**Rejected at this stage** — and re-tested at Stage 4 rather than dropped.

### `R3-4` — *"Part 3 specifies Zero Trust, a V3 capability, breaching rank/scope discipline"* — **REJECTED**

Measured: `SECP-PRN-009` is **directional** (a principle, not a requirement), `SECP-XC-020` **excludes** the
capability, and Part 3 §8.1 states the hold-out. Part 8 §4's promotion table lists *"Zero Trust Architecture;
Service Auth; Network Segmentation; Continuous Verification"* as **V3 / Future** with all three hold-out mechanisms
named. A principle that states a direction while an exclusion forbids building the capability is the documented
pattern for not promoting scope, not a breach of it.

**Rejected.** No V1 requirement in Parts 1–8 is satisfiable only by a V2/V3/Future capability (Part 8 §4).

---

## 6. Conflict disposition table — the gate's actual deliverable

The gate requires *"every conflict and its disposition."* This is that table. **Three conflicts, three dispositions,
zero resolutions by this record.**

| Conflict | Ranks in tension | Raised as | Owner | Disposition | Resolution mechanism |
|---|---|---|---|---|---|
| Cross-tenant leak test deferral | **Rank 1** `MP-RSK-01` Critical vs **Rank 6** EA V2 | `SECP-GAP-023` / `A3-2` | Architecture Owner + Product Owner | ⛔ **OPEN — routed** | ADR amending the EA, or a Product Owner scope decision |
| Alertability vs `Alerting` V2 | **Rank 3 FROZEN** `AUTH-11.26`…`11.28` vs **Rank 6** EA V2 | `SECP-GAP-031` / `A3-3` | Architecture Owner | ⛔ **OPEN — routed** | `SECP-ADR-002`; tracked as `SECP-DEP-001` |
| `platform/security` manifest silence | **Rank 4-governed** enforcement artefact vs `default_decision: deny` | `SECP-GAP-042` / `A3-1` | Architecture Owner | ⛔ **OPEN — routed** | `SECP-ADR-004` |

**None of the three blocks Stage 3.** All three are conflicts *between other documents*, surfaced by `PRD-012a`
rather than caused by it. A review that refused to pass Stage 3 until other documents were corrected would make this
PRD hostage to defects it did not create — and would have to *choose* between ranked documents to clear them, which
L253 forbids.

### 6.1 The remaining 41 gaps are not conflicts

`PRD-012a` carries **44 `SECP-GAP-*`** entries. Three are the conflicts above. The other **41** are open questions,
missing authorities and deferred decisions with named owners — the ordinary content of a gap ledger, admitted OPEN by
every frozen PRD in this repository (`PRD-013` admitted 4, `PRD-016` 5, `PRD-008` 17, `PRD-006` 18). They are
**neither cured nor ratified** by this record.

---

## 7. Authorities applied, and the direction of each citation

| Rank | Document | Version | How `PRD-012a` uses it |
|---|---|---|---|
| **1** | `MASTER_PRD.md` | v1.7 | `MP-GBR-06`…`09`, `MP-NFR-05`/`09`/`10`/`12`, `MP-RSK-01`/`02`, `MP-CON-11` — **cited, never restated** |
| **2** | `ADR-0002`, `ADR-0003`, `ADR-0004`, `ADR-0011`, `ADR-0014` | Accepted | `SECP-FR-010` is *"`ADR-0003` applied to privilege, not a new rule"* |
| **3** | `PRD-001` Authentication | **v2.0 FROZEN** | `AUTH-2.26`, `AUTH-8.16`…`8.39`, `AUTH-11.20`…`11.30`, `AUTH-11.53`/`11.54` — cited; **break-glass prohibited, not specified** |
| **3** | `PRD-013`, `PRD-016`, `PRD-023`, `PRD-017` | FROZEN | Deferrals via `SECP-OWN-017`/`022`/`021`/`020` |
| **4** | Bounded Context Map | **v1.8** | 87 `BC-nn` rows, 26 `E-nn` edges, `ID-1` L178, scoping L486 — **0 edges added** |
| **4** | Module Dependency Matrix | v1.3 | Rule `L2`; `platform/security: 2` |
| **5** | `ARCHITECTURE_RULINGS.md` | v1.2 | L116 — no relaxation of `MP-GBR-08`/`SE-1`/`X-13` |
| **6** | Enterprise Architecture | v2.2 | **Descriptive.** Source of two of the three conflicts; **never used to overrule Ranks 1–3** |

**Every citation runs downward or laterally. No requirement in Parts 1–8 cites a lower-ranked document as authority
over a higher-ranked one.** That is the substance of check C3, and it holds.

---

## 8. Measurements taken for this record

### 8.1 Subject state on entry

| File | Lines |
|---|---|
| `PRD-012a_SECURITY_AUTOMATION.md` (Part 1) | 550 |
| `PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md` | 588 |
| `PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md` | 494 |
| `PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md` | 429 |
| `PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md` | 391 |
| `PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md` | 391 |
| `PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md` | 410 |
| `PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md` | 417 |
| **Total** | **3,670** |

Reviewed at commit `bd85a31`, working tree clean. **Zero bytes of the subject were modified to produce this
record** — unlike the `PRD-017` Stage 5 pass, which repaired one defect and disclosed the resulting hash movement.
No defect of that kind was found here, so no such departure was needed.

### 8.2 Architecture measurements

| Measurement | Method | Result |
|---|---|---|
| `BC-nn` table rows in the BC Map | `grep -coE '^\| \*?\*?.?BC-[0-9]+'` | **87** |
| `E-nn` integration edges | `grep -coE '^\| \*?\*?.?E-[0-9]+'` | **26** |
| A `BC-nn` context named *security* | case-insensitive search, all 3 hits inspected | **0** — see §2.1 |
| Integration edges added by `PRD-012a` | `SECP-EVT-*` count + `SECP-ADR-*` edge requests | **0** |
| `SECP-INV-*` / `SECP-EVT-*` / `SECP-CFG-*` | token search across 8 Parts | **0 / 0 / 0**, each with a published reason |
| `platform/security` manifest block | key search in `tool/module_dependencies.yaml` | **absent** — `A3-1` |
| `platform/security` consumed ports | port references | **5** (L107, L181, L239, L278, L279) |

### 8.3 What was **not** measured, and why

This record does **not** re-verify identifier continuity, register counts or acceptance coverage. Those are the
Stage 2 and Stage 5 gates, measured elsewhere, and duplicating them here would create a second place for the numbers
to drift — the `GCP-01`/`GCP-07`/`GCP-11` defect class (*a derived statement left behind by a change to the thing it
describes*). This record cites the stage that owns each measurement instead of restating it.

---

## 9. What this record does not confer

**`PRD-012a` remains `PRD_REGISTRY.md` §4.1 `PLANNED`, and Part 1 remains v0.1 `DRAFT`.** This record changes
neither, and neither is changed by any file in this pass.

`PRD_REGISTRY.md` §8 rule 2: *"A status change requires the entry evidence in §2. 'It feels done' is not evidence."*
The registry status `IN_REVIEW` corresponds to Stages 3–4 (`PRD_LIFECYCLE.md` §2), and this record establishes the
Stage 3 half. Writing the status is a separate act, taken once Stage 4 is also recorded, and it is **not taken by
this document**.

This record is **unranked**. It appears in no `DOCUMENTATION_BASELINE.md` §3 row. On the `PRD-007_STAGE7_FREEZE.md`
standard: *"Navigational and evidential only. This record documents that the gate was met. It confers nothing."*

---

## 10. Verdict

⚠ **STAGE 3 GATE SATISFIED — ALIGNED WITH ONE STRUCTURAL FINDING.**

- **5 of 6** lifecycle checks PASS outright; **C3** passes with finding `A3-1` against an artefact `PRD-012a` does
  not own.
- **3 accepted findings**, all three independently confirming disclosures the subject had already made.
- **4 rejected candidate findings**, each recorded with the evidence that defeated it — including `R3-1`, which
  would have repeated the superseded `PRD-013_STAGE7_BLOCKER.md` error of reading an absence as a prohibition.
- **3 conflicts routed to named owners. Zero conflicts resolved by this record.**
- **0 bytes of the subject modified. 0 higher-ranked documents amended. 0 approvals claimed.**

The one finding that could have been "fixed" — the missing `platform/security` manifest block — was deliberately
**not** fixed, because fixing it is an Architecture Owner act requiring an ADR. `PRD_LIFECYCLE.md` L177–180 states
why that restraint is the point rather than an inconvenience: `PGA-01` and `PGA-02` are *"two confirmed defects in
frozen documents left unfixed for exactly this reason. If a silent edit is acceptable when the editor is confident,
the freeze protects nothing, because every editor is confident."*

**Next stage:** 4 — Requirements Review. Gate: *conflicts closed or explicitly deferred with a reason and an owner.*

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-21 | Created. Stage 3 architecture alignment for `PRD-012a` Parts 1–8 at v0.8. Verdict ALIGNED, 5 PASS + 1 PASS-with-finding. 3 accepted findings (`A3-1`…`A3-3`), 4 rejected (`R3-1`…`R3-4`). 3 conflicts routed, 0 resolved. Subject unmodified. |
