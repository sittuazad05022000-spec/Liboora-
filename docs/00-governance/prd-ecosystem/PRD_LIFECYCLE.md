# LIBOORA — PRD Lifecycle

| Field | Value |
|---|---|
| **Document** | PRD Lifecycle — the stages every PRD passes through, and the gate between each |
| **Version** | ⭐⭐ **v1.2** |
| **Status** | Active — binding process for new and amended PRDs |
| **Date** | 2026-08-04 |
| **Baseline** | `BASELINE-2026-08-04` |
| **Authority** | **Process, not product.** This document governs *how* a PRD moves between states. It never governs *what* a PRD says |
| **Companion** | [`PRD_REGISTRY.md`](./PRD_REGISTRY.md) §2 — the status vocabulary this lifecycle drives |

---

## 1. Why this document exists

Three PRDs reached the baseline by three different routes. Authentication v2.0 was **authored** after the v1.0
chapters turned out to be empty. The Library PRD was **received verbatim** from the product owner and reviewed
without editing a word. The Student Identity PRD was **reconciled** against an ADR that changed its architecture
mid-review.

All three arrived in good order. None followed a written process, because there was not one — and eighteen more
PRDs are still to be written.

This document records the route, so the next eighteen do not each invent their own.

> **What this does not do.** It does not add ceremony to work already done. `PRD-000`…`PRD-003` are frozen and
> **are not re-run through these stages**. §9 states how they map.

---

## 2. The nine stages

```
  Discovery ──► Draft ──► Architecture ──► Requirements ──► Traceability
                            Review           Review              │
                                                                 ▼
   Verification ◄── Implementation ◄── Freeze ◄── Implementation Tasks
```

Each transition has a **gate**: a named artefact that must exist. A gate is not an opinion — if the artefact does
not exist, the stage has not been passed, however complete the work feels.

| # | Stage | Registry status | Exit gate |
|---|---|---|---|
| 1 | Discovery | `DISCOVERY` | Bounded context identified and **unowned** by any other PRD |
| 2 | Draft | `DRAFT` | Document on disk, versioned header, identifier registers declared |
| 3 | Architecture Review | `IN_REVIEW` | Every boundary, edge and rank validated against the BC Map |
| 4 | Requirements Review | `IN_REVIEW` | Every requirement uniquely identified, testable, non-duplicating |
| 5 | Traceability | `APPROVED` | Prefixes registered in `TRACEABILITY_MATRIX.md`; zero collisions |
| 6 | Implementation Tasks | `APPROVED` | `IMPL-*` range allocated; every task traces to requirements |
| 7 | **Freeze** | **`FROZEN`** | Row in `DOCUMENTATION_BASELINE.md` §3 at a precedence rank |
| 8 | Implementation | `IMPLEMENTING` → `IMPLEMENTED` | All tasks closed |
| 9 | Verification | `VERIFIED` | Every acceptance criterion proven by a test or recorded procedure |

---

## 3. Stage detail

### Stage 1 — Discovery

**Purpose:** decide whether a PRD is warranted at all.

| Question | Fails if |
|---|---|
| Does a bounded context own this? | It is a presentation composition — dashboards, Parent Portal. **No PRD** |
| Does another PRD already own the context? | It is an amendment to that PRD, not a new one |
| Is it V1/V2/V3, or Future? | Future ⇒ **stop**. EA §10.3: *"do not design for it now, only avoid blocking it"* |
| Does it own an aggregate and an invariant? | Owning neither ⇒ it is a capability of an existing context |

**Gate:** a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6.

> **The commonest wrong outcome is a PRD that should not exist.** Four of the nineteen Master PRD modules are
> compositions, not contexts. Discovery exists to catch that before anyone writes 300 requirements behind a
> screen that owns no state.

### Stage 2 — Draft

**Gate:** a document with a version/status header, and its identifier registers declared **up front** with
ranges — as `Student_Identity_PRD_v1.md` §0 does, publishing *"the ranges as a promise"*.

Rules:
1. **Every requirement has a unique identifier.** No exceptions.
2. Prefixes are chosen against §5's collision procedure **before** writing.
3. Ranges are contiguous. A gap makes the published range false.
4. Normative language (**MUST**/**SHOULD**/**MAY**) is defined in the document.

### Stage 3 — Architecture Review

Validates the PRD against Ranks 1–5, in this order:

| Check | Authority | Failure |
|---|---|---|
| Context ownership is exclusive | BC Map §3 | Two PRDs own one aggregate |
| Every integration edge exists in §7 | BC Map §7 | *"If an edge is not in this table, it does not exist"* — needs an ADR |
| Rank direction is downward | Dependency Matrix `L2` | Illegal import |
| No authorisation decided outside `BC-18` | `X-13` | **A security defect that passes its own tests** |
| No credential, OTP or session outside `BC-18` | `ID-1` | Prohibited |
| Tenant scoping correct | `MP-GBR-08`, `X-13` | Cross-tenant leak — `MP-RSK-01`, Critical |

**Gate:** a written alignment record naming every conflict and its disposition —
`LIBRARY_PRD_ALIGNMENT.md` and `STUDENT_IDENTITY_ALIGNMENT.md` are the worked examples.

> **A rejected finding must be recorded as rejected, with its reason.** The Student Identity review accepted 11
> of 13 and rejected 2, preserving the draft's intent deliberately. A review that records only accepted findings
> is indistinguishable from a review that found nothing.

### Stage 4 — Requirements Review

| Check | Failure |
|---|---|
| Every requirement testable | *"The system should be fast"* — unverifiable |
| Every exclusion states what must be **impossible** | An exclusion is not a deferral |
| Every configurable has a default and a range | Unbounded configuration is a specification hole |
| Every acceptance criterion maps to a requirement | Orphan criterion |
| No requirement restates another PRD's | Two sources of truth |
| Business rules do not contradict Rank 1 | Rank 1 wins; the PRD is wrong |

**Gate:** conflicts closed or explicitly deferred **with a reason and an owner**.

### Stage 5 — Traceability

**Gate:** the PRD's prefixes registered in [`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md)
§2 with counts and ranges, verified mechanically, **zero collisions**.

Mechanical means counted by a tool, not by reading. §2B records nine registers verified *"contiguous from 1 to
its stated maximum"*.

> **The near-miss worth knowing about.** `PO-1`…`PO-12` are protected operations behind the **public library
> preview** — an anonymous read surface. `SPO-1`…`SPO-9` are protected operations on a **Global Person Identity**
> — authenticated writes. Two candidate prefixes were changed during authoring to prevent collisions, and the
> matrix notes that citing `PO-3` when `SPO-3` was meant *"would move a requirement from one bounded context to
> another."* This stage exists for that class of error, which no amount of careful reading reliably catches.

### Stage 6 — Implementation Tasks

**Gate:** an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**.

Allocation rules:
1. Take the next free range. **Never reuse or reassign a number** — cross-references in commits, reviews and test
   names outlive the document.
2. Leave the previous group room to grow contiguously. Student Identity starts at `IMPL-200`, not `IMPL-128`, so
   Library Management can extend.
3. Record `Priority`, `Blocks`, `Blocked by` per task.
4. Add a traceability table mapping task groups → requirements → invariants → acceptance.

| Range | Owner |
|---|---|
| `IMPL-014`…`073` | Authentication, platform, release readiness |
| `IMPL-100`…`127` | Library Management |
| `IMPL-128`…`199` | Reserved — Library growth |
| `IMPL-200`…`226` | Student Identity |
| `IMPL-227`+ | **Unallocated** |

### Stage 7 — Freeze

**The gate that matters most, because it changes what everyone else may do.**

**Gate:** a row in [`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §3 at an assigned precedence rank.

Freeze is **conferred, not claimed**. No PRD in this repository declares itself frozen — verified: four of the
five contain no occurrence of the word at all. The operative rule is baseline §7:

> *"A change to any Rank 1–5 document requires an ADR **before** the change."*

After freeze:

| Change | Requires |
|---|---|
| Typo, formatting, broken link | Nothing. Fix it |
| Clarifying wording with no change in meaning | Changelog entry |
| **Any business-rule change** | **ADR → version increment → changelog → baseline update, in that order** |
| New requirement | Same as a business-rule change |
| Ownership or boundary change | ADR. `LIB-26.2`: *"MUST NOT be amended by a PRD revision alone"* |
| Withdrawing a requirement | ADR stating what replaces it |

**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly
right — [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-01` and `PGA-02` are two confirmed defects in frozen
documents left unfixed for exactly this reason. If a silent edit is acceptable when the editor is confident, the
freeze protects nothing, because every editor is confident.

### Stage 8 — Implementation

`IMPLEMENTING` on the first task started; `IMPLEMENTED` when all are closed.

Governed by [`DEFINITION_OF_DONE.md`](../../40-implementation/DEFINITION_OF_DONE.md) v1.2 and the six pipeline
gates in Dependency Matrix §10.4:

```
1  dart format
2  flutter analyze
3  dart run tool/check_module_boundaries.dart   ◄ blocks merge
4  flutter test test/architecture/              ◄ blocks merge
5  flutter test
6  flutter build web --release
```

Rules: update the traceability matrix **in the same commit** as the code; a requirement moves to ✅ only when its
acceptance criteria are proven by automated tests; a requirement that cannot be implemented as written is a
**specification defect** — raise an amendment, never silently reinterpret it.

### Stage 9 — Verification

`VERIFIED` requires **every** acceptance criterion proven by an automated test or a recorded repeatable
procedure, plus one failing-on-violation test per invariant.

The governing principle is `SID-4.56`:

> *"A rule that cannot be checked SHALL be treated as unmet."*

Consequences that are easy to resent and are not negotiable:

- `X-13` and `X-10` are specified and **not implemented** — therefore **unmet**, not "mostly fine".
- `SID-INT-1`…`12` are review-verified only — therefore **unmet** until `IMPL-220` checks them.
- **The module is not complete at 25 of 26 acceptance criteria.**

> **`IMPLEMENTED` and `VERIFIED` are different facts.** A module whose tasks are all closed but whose acceptance
> criteria are unproven is implemented and unverified, and saying so is the whole point of having two states.

---

## 4. Amending a frozen PRD

```
Proposed change
      │
      ▼
Is it a business-rule change, new requirement, or ownership change?
      │                                    │
     NO                                   YES
      │                                    │
      ▼                                    ▼
Changelog entry              1. Write an ADR — BEFORE the change
Version unchanged            2. Accept the ADR
                             3. Increment the PRD version
                             4. Update the PRD changelog — same commit
                             5. Update DOCUMENTATION_BASELINE.md — same commit
                             6. Update TRACEABILITY_MATRIX.md if identifiers changed
                             7. Update PRD_REGISTRY.md
```

Baseline §7 step 3 states the reason bluntly: *"A baseline that does not match the repository is worse than no
baseline."*

**The worked example is `ADR-0011`.** It amended a global business rule (`MP-GBR-02`), the Bounded Context Map's
Identity Triad, and a PRD's architecture. The ADR came first; Master PRD went v1.6 → v1.7, BC Map v1.2 → v1.3,
Dependency Matrix v1.0 → v1.1, and the baseline moved to `BASELINE-2026-08-04` — all recorded. Nothing was
edited quietly.

---

## 5. Identifier rules

1. **Every requirement has a unique identifier**, unique across the *whole platform*, not just its document.
2. Prefixes are checked against every existing register before use — 2,282 identifiers across three PRDs today.
3. On collision, **change the new prefix**, never the existing one.
4. Ranges are contiguous and published.
5. Numbers are never reused, even after withdrawal. A withdrawn requirement is marked withdrawn.
6. A register declared **closed** — `SEV-1`…`16`, `SPO-1`…`9`, `PO-1`…`12` — may not be extended without an ADR.

| Register | Owner | Count |
|---|---|---|
| `MP-*` | Master PRD | — |
| `AUTH-*`, `BR-*`, `XC-*`, `AC-*`, `EV-*`, `AERR-*`, `CFG-*` | Authentication | 1,517 |
| `LIB-*`, `INV-SEC-*`, `LBR-*`, `LXC-*`, `LAC-*`, `IAC-*`, `LCFG-*`, `ICFG-*`, `PO-*`, `LEV-*` | Library | ~422 |
| `SID-*`, `SID-BR-*`, `SXC-*`, `SPO-*`, `SEV-*`, `SID-INT-*`, `SID-INV-*`, `SCFG-*`, `SID-AC-*` | Student Identity | 343 |

---

## 6. Roles

Roles, not people — the repository names no individuals, and this document does not invent any.

| Role | Owns |
|---|---|
| Product owner | Content, business rules, scope |
| Architecture reviewer | Stage 3; authority to require an ADR |
| Requirements reviewer | Stage 4 |
| Traceability owner | Stage 5; the matrix |
| Implementation lead | Stages 6 and 8 |
| Governance owner | Stage 7; the baseline |

**Every PRD needs a named owner. None has one** — [`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md) `PGA-08`.

---

## 7. Fast paths, and the one that does not exist

| Situation | Path |
|---|---|
| Typo or broken link in a frozen PRD | Fix directly. No ADR |
| Received verbatim from the owner | Stages 3–5 still apply. Findings go in a **separate** record so the capture stays auditable — the `14A` pattern |
| Emergency security correction | Stages 3 and 7 still apply. **`X-13` and `ID-1` are never waived under time pressure** |
| Urgent business need | **No fast path.** Stage 7 is not skippable |

## 7A. ⭐ Stage `6A` — Technical Specification *(added v1.1)*

⭐ **Established by `Accepted` [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md).** This section is the lifecycle's statement of the stage; the ADR is its
authority. ⛔ The ADR authorises the **document class**, ⛔ **not the drafting of any specification.**

### 7A.1 ⚠ Why `6A` and not a renumber

⛔ **§2's nine-stage table is BYTE-UNCHANGED and the nine registry statuses are unaltered.** A renumber was measured
before it was rejected: **7,411 `Stage N` references across 241 files** would have become ambiguous or wrong
(`Stage 3` alone = 1,817 hits / 241 files). Stage `6A` is therefore an **inserted stage**, following this
repository's own letter-suffix convention — `§6A`, `§7A`, `§14A` in product documents, and `PRD-012a`, `PRD-021A`,
`PRD-021B`, `PRD-021C` in PRD identities. ⭐ **Zero existing references are invalidated.**

### 7A.2 Position and purpose

| Field | Value |
|---|---|
| **Stage** | **`6A` — Technical Specification** |
| **Position** | **after** Stage 6 (Implementation Tasks), **before** Stage 7 (Freeze) |
| **Registry status** | ⛔ **No new status.** A PRD at `6A` remains `APPROVED`, as at Stage 6 |
| **Purpose** | Translate frozen requirements, Rank 4 boundaries and Accepted ADRs into implementation-level technical detail, recording every unanswerable question as a **gap with a named owner** rather than deciding it |
| **Identifier namespace** | ⭐ **`TS-*`** — reserved by [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md) §C; measured **0** occurrences before reservation. ⛔ `LTS-*`, `LCTS-*`, `TPA-*`, `LMT-*`, `IMPL-*` and `PERM-*` **MUST NOT** be reused |
| **Directory** | ⭐ **`docs/50-technical/<subject>/`**. ⛔ **Not created until the first specification is lawfully authored** |
| **Exit gate artefact** | A `TS-*` document satisfying **X-1**…**X-6** below |

### 7A.3 ⭐⭐ Stage `6A` is OPTIONAL and NON-BLOCKING

⛔⛔ **Stage `6A` does NOT retroactively invalidate, reopen, downgrade or re-gate any PRD already frozen.**
**Sixteen PRD identities are `FROZEN` and admitted to `DOCUMENTATION_BASELINE.md` §3.3 without passing `6A`,
because it did not exist.** Every one remains **FROZEN, authoritative and fully valid** — a stage inserted today
cannot be a gate a document failed yesterday.

1. For an **already-frozen** PRD, `6A` is **available but not required**; its absence is ⛔ **NOT a defect, NOT a
   blocker and NOT a regression**.
2. For a PRD **not yet frozen**, `6A` is **available and recommended**, and ⛔ **still not a precondition of
   Stage 7** — making it one would retroactively alter the Stage 7 gate at **L159** that every existing freeze
   was conferred against.
3. Whether `6A` should ever become **mandatory** is ⛔ **NOT decided** — `TSG-GAP-001` in [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md) §11.

### 7A.4 Entry criteria — all four required

| # | Criterion |
|---|---|
| **E-1** | The subject's requirements are **frozen or baseline-authoritative** — a `DOCUMENTATION_BASELINE.md` §3 row, or an Accepted ADR admitting it |
| **E-2** | **Stage 3** (Architecture Review) has **passed** for the subject |
| **E-3** | Every Accepted ADR governing the subject is **identified and cited** |
| **E-4** | ⭐ Every governed decision the specification depends upon **exists** — or the dependency is **recorded as a gap with a named owning office**. ⛔ This is the criterion that prevents inventing an answer no office has decided |

### 7A.5 Exit gate — all six required

⛔ *"A gate is not an opinion — if the artefact does not exist, the stage has not been passed, however complete the
work feels"* (**L41**).

| # | Criterion |
|---|---|
| **X-1** | A `TS-*` document exists in `docs/50-technical/`, with a versioned control header and its identifier declared |
| **X-2** | Its identifier stem is **collision-checked and measured 0** repository-wide before use (§5 rule 2) |
| **X-3** | **Every** technical assertion cites its governing authority — PRD requirement, ADR, BC Map line, or Rank 4/5 register entry |
| **X-4** | The prohibitions in [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md) §3.3 and §8.2 are **individually affirmed**, including that no permission, boundary, edge, port, aggregate or product requirement was invented |
| **X-5** | A **gap register** exists naming an owning office for every unanswerable question — ⛔ and none is closed to make the document look complete |
| **X-6** | The traceability chain is stated per section: **PRD requirement → Architecture/BC → ADR → this section** |

### 7A.6 Ownership and attestation

| Role | Stage `6A` act |
|---|---|
| **Technical Owner** | **Authors and attests** — §2.2 already scopes this role to implementation and traceability; ⛔ no new office is constituted |
| **Architecture Owner** | ⭐ **Approves** — boundaries, edges and Rank 4 conformance. ⛔ *"Only the Architecture Owner approves"* |
| **Product Owner** | **Attests** that no product requirement was invented or altered |
| **Domain Owner** | **Reviews** ubiquitous language and invariants |

⛔⛔ **All offices are VACANT as constituted, and [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md) fills none of them.** Every `6A` act proceeds under the
**one-act-conferral** model, and the offices ⛔ **revert on completion** (`ADR-0033` §7.1). ⛔ A Technical
Specification **MUST NOT record an office as occupied** — it records which office is **required** and by which
**conferral** it was exercised.

### 7A.7 Authority, precedence and rank

A Technical Specification is **subordinate** to, and must conform to, in order: **(1)** Rank 1 `MASTER_PRD.md`
global rules · **(2)** applicable frozen/baseline-authoritative PRDs · **(3)** Accepted ADRs · **(4)** Rank 4
architecture (BC Map, Dependency Matrix) and Rank 5 rulings.

⛔ It **MUST NOT** supersede an ADR or a frozen PRD · ⛔ **MUST NOT** invent a permission · ⛔ **MUST NOT** create a
bounded context, edge, port or aggregate · ⛔ **MUST NOT** silently resolve a conflict · ⛔ **MUST NOT** cite the
Rank 6 Enterprise Architecture as overriding technical authority · ⛔ **MUST NOT** claim its own status.

⚠ **RANK IS EXPLICITLY DEFERRED** (`TSG-GAP-004`). An admitted Technical Specification is **governed but
UNRANKED**: it ⛔ **carries no precedence authority over any ranked document**, and in any disagreement **the
ranked document wins by default**.

### 7A.8 Freeze and amendment

| State | Rule |
|---|---|
| **`DRAFT`** | The default on creation. ⛔ **NOT approved, NOT frozen, NOT authoritative** |
| **Admitted** | Becomes a **governed document** only when an **Accepted ADR** admits it. ⛔ **Status is never self-claimed** |
| **Amendment** | Requires an **ADR before the change**; version + changelog + declaration all move **in the same commit** (`DOCUMENTATION_BASELINE.md` §7 rules 1–3) |
| **Supersession** | The superseded record is **retained, not deleted** (`ADR-INDEX` **L207**) |
| ⛔ **Silent post-freeze edit** | ⛔⛔ **PROHIBITED** |
| **Citations** | `ADR-0079` §8.5 **append-not-insert**; citation cost **measured before and verified after** every write |

### 7A.9 ⛔⛔ Mandatory boundary clauses

Every Technical Specification is bound by [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md) §9, summarised here and **authoritative there**:

| Domain | Binding constraint |
|---|---|
| **PAYMENT** | `ADR-0130` — V1 student payment is ⭐ **CASH ONLY**; ⛔ UPI, card, online, gateway, LIBOORA platform charge and library→LIBOORA settlement are **V2**; ⛔ **no V1 settlement mechanism is required and its absence is NOT a blocker**; ⛔ **no V2 mechanism may be invented**. ⚠ **Named trap:** `PRD-008` **FROZEN v1.7 §6.1 L209/L210/L211/L213/L214 still say V1** and are **superseded IN EFFECT by rank** — authors apply `ADR-0130`, ⛔ **not** `PRD-008` §6.1 |
| **AUTHORIZATION** | `AUTH-7.22` catalogue is **CLOSED**; ⛔ **enumerated permissions measured ZERO**, `PERM-*` repo-wide **2, both withdrawals** — ⛔ **no convention exists to extend**. `ADR-0043` §5.1 (*"Do not invent a new permission ID"*) and `AP-9` **fail-closed** remain binding |
| **AUTHENTICATION** | Auth **v3.0** / `ADR-0129` authoritative. ⛔ No V1 mobile OTP, ⛔ no password, ⛔ no email-as-identity, ⛔ no email recovery, ⛔ **no Auth v4.0**. ⚠ `DEVELOPER_HANDOFF.md` and 6 implementation documents are **stale** — prefer Auth v3.0 |
| **ARCHITECTURE** | ⛔ `MP-GBR-24` — `BC-05` and `BC-20` share **no model, table or metric** · ⛔ `MP-CON-01`/`02` + `MP-RSK-05` — **no direct BaaS/Supabase call from domain code** · ⛔ `ADR-0012` boundary checker **remains a merge gate** · ⛔ **modular monolith** in V1 · ⛔ EA is **Rank 6 descriptive only** |
| **API** | `ADR-0135` — **`API-1`** V1 external style is **REST over HTTP** (Rank-1 `MASTER_PRD` **L407**, Rank-4 BC Map **L226**) · **`API-2`** GraphQL **only** at the BFF/OHS edge **where the BFF requires it** — ⛔ not a general style, ⛔ not a second surface · **`API-3`** cross-context calls are **in-process port calls**, ⛔ **never internal HTTP** (`MP-CON-09` modular monolith; `ADR-0012` checker is the merge gate) · ⛔⛔ **`API-4`** a denial **MUST NOT disclose existence** — *"exists but forbidden"* and *"does not exist"* **MUST be indistinguishable**; ⛔ **distinct 404/403 for private-vs-absent is PROHIBITED** (`Accepted` [`ADR-0010`](../adr/ADR-0010-public-preview-anonymous-access.md) **L151**, *"enumeration oracle"*) · ⛔ **`API-5`** a denial **MUST NOT disclose the reason** — not the failing rule, conjunct, capability, role, policy, tenant or another principal's state (`AUTH-10.33`, `LCM-API-003`) · **`API-6`** validation errors **MAY** be specific (`MASTER_PRD` **L410**); ⛔ authorization and existence outcomes **MUST NOT** be — ⭐ and an `AP-9` **fail-closed** refusal **MUST look identical** to an entitlement refusal · **`API-7`** the V1 surface **MUST carry an explicit version identifier** from first release (Rank 1 **L408** beats EA **L380**/**L1787** `(V2)`; EA is **descriptive only**) · ⚠ **`API-8`** the versioning **MECHANISM is NOT selected** — path, header, media-type and query are **all open** · **`API-9`** an idempotency key is **request METADATA, not domain payload** — caller-supplied, **opaque to the domain**, unique **per tenant** (FROZEN **`FEE-FR-029`** *"at the API edge"*, **`FEE-INV-005`**, Rank-1 **`MP-GBR-18`**); ⛔ **no header name is specified** · **SESSION** — the API edge **consumes** authorization decisions via `identity.policy_decision` and ⛔ **MUST NOT evaluate, cache or infer** one from a token (Rank-1 **`MP-GBR-26`** *"no propagation window"*, Rank-4 Matrix **L220** *"ask `BC-18`, never evaluate or cache"*); ⛔ **a token is NOT an authorization store**; ⛔ Auth **v3.0** internals are **untouched** · **AUTHZ** — ⛔⛔ **ZERO permission identifiers**, `AUTH-7.22` **CLOSED at 0**, `ADR-0043` §5.1 binding, ⛔ `ADR-0132` **not reopened**; derived capability (`LCM-AUTH-001`/`002`) is the sanctioned route; ⛔⛔ **endpoint-keyed grants and route allow-lists are PROHIBITED** — each would build a permission vocabulary outside the closed catalogue. ⚠⚠ **OPEN — `API-GAP-001`:** the **deprecation / sunset / multi-version-support policy** is **UNDECIDED** (measured **0** governed statements repo-wide); it needs **Product Owner + Architecture Owner** and ⛔ **a specification MUST NOT invent one**. ⛔ **`API-1`…`API-9` specify no endpoint, path, verb, status code, header name, payload or schema** — that remains §6A work |

### 7A.10 Relationship to downstream stages

⭐ A Technical Specification is the declared upstream input to **database + Supabase → API specification → UX
research + user flow → design → prototype → implementation → QA / security / release**. ⛔ It is **not a substitute
for any of them**, and ⛔ **passing `6A` authorises no downstream act** — each remains its own governed act with its
own conferral. ⚠ That ordering is an **expectation, not an enforced gate** (`TSG-GAP-002`).

---

---

## 8. How this maps to `PRD-000`…`PRD-003`

These four are frozen and **not re-run through the lifecycle**. Their historical routes, for reference only:

| PRD | Route |
|---|---|
| `PRD-000` Master | Iterative, v1.0 → v1.7. Stage 7 at each baseline |
| `PRD-001` Authentication | **Authored** — v1.0 chapters were empty. `ADR-0008` conferred baseline status; `PRD-V2-GOVERNANCE-NOTE.md` preserves the provenance |
| `PRD-002` Library | **Received verbatim**, reviewed without editing. 14 conflicts recorded separately |
| `PRD-003` Student Identity | **Reconciled** — `ADR-0011` changed the architecture mid-review. 11 findings accepted, 2 rejected with reasons |

**Three routes, one destination.** That is the argument for writing the process down: all three worked, and none
of them would be reproducible from memory.

---

## 9. References

[`DOCUMENTATION_BASELINE.md`](../DOCUMENTATION_BASELINE.md) §4, §7 ·
[`ADR-INDEX.md`](../adr/ADR-INDEX.md) ·
[`DEFINITION_OF_DONE.md`](../../40-implementation/DEFINITION_OF_DONE.md) ·
[`TRACEABILITY_MATRIX.md`](../../40-implementation/TRACEABILITY_MATRIX.md) ·
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) §10.4 ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) §7 ·
[`CONTRIBUTING.md`](../../../CONTRIBUTING.md) ·
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) ·
[`PRD_GAP_ANALYSIS.md`](./PRD_GAP_ANALYSIS.md)

---

## 10. Change history

| Version | Date | Change |
| ⭐ **v1.1** | 2026-09-10 | ⭐⭐ **Stage `6A` — Technical Specification — INSERTED**, by `Accepted` [`ADR-0131`](../adr/ADR-0131-constitute-technical-specification-governance.md), under a one-act joint conferral of **Governance Owner** and **Architecture Owner** authority; ⛔ both offices **revert on completion** (`ADR-0033` §7.1). ⭐ **New §7A** defines the stage's position (after Stage 6, before Stage 7), purpose, **4 entry criteria** (`E-1`…`E-4`), **6-condition exit gate** (`X-1`…`X-6`), ownership/attestation, precedence, freeze/amendment rules, mandatory boundary clauses and downstream relationship. ⚠⚠ **THIS IS AN INSERTION, NOT A RENUMBER.** §2's *"nine stages"* table is ⛔ **BYTE-UNCHANGED** and the nine registry statuses are unaltered. A renumber was **measured before rejection**: **7,411 `Stage N` references across 241 files** would have become ambiguous or wrong (`Stage 3` alone **1,817** hits / 241 files; `Stage 7` **1,129** / 203). The letter-suffix convention already used by this repository (`§6A`, `§7A`, `§14A`; `PRD-012a`, `PRD-021A`/`B`/`C`) was followed instead — ⭐ **0 existing references invalidated**. ⚠⚠ **CITATION COST: ZERO SHIFTED — measured before the write and verified after.** **682 line-number citations across 184 documents** point into this file, the highest at **L294**; ⭐ **§7A is inserted at L296 and the changelog row at the foot, both BELOW every cited line**, per the `ADR-0079` §8.5 append-not-insert doctrine. The only in-place edit is the header `Version` cell (**L6**, measured **uncited**), so ⛔ **no cited line is displaced**. ⭐⭐ **Stage `6A` is OPTIONAL and NON-BLOCKING**: ⛔ it does **NOT** retroactively invalidate, reopen, downgrade or re-gate the **16 frozen PRD identities** admitted before it existed, and its absence is ⛔ **NOT a defect, NOT a blocker and NOT a regression** — mandating it would retroactively alter the **L159** Stage 7 gate that every existing freeze was conferred against. Whether it becomes mandatory is ⛔ **NOT decided** (`TSG-GAP-001`). ⭐ **Identifier namespace `TS-*` reserved** — measured **0** occurrences repository-wide before reservation; ⛔ **`LTS-*` (260 occurrences, `PRD-021C` Marketplace), `LCTS-*`, `TPA-*` (B9), `LMT-*` (C8), `IMPL-*` and `PERM-*` MUST NOT be reused**. ⭐ **Directory `docs/50-technical/` declared** — ⛔ **NOT created**, and ⛔ **no placeholder, stub, README or template exists**. ⛔ **`TS-001` is NOT allocated.** ⭐ **Ownership uses the EXISTING Technical Owner role** (§2.2 **L86**) — ⛔ **no new office constituted**; ⛔⛔ **all offices remain VACANT and this act fills none**; ⛔ *"Only the Architecture Owner approves."* ⚠ **RANK IS EXPLICITLY DEFERRED** (`TSG-GAP-004`): an admitted Technical Specification is **governed but UNRANKED** and ⛔ **loses any disagreement with a ranked document by default** — the framing `PRD-021B` B9 already adopted as `XPB-CONF-012`. ⛔⛔ **BOUNDARY CLAUSES BIND EVERY FUTURE SPECIFICATION** (§7A.9): **`ADR-0130`** cash-only V1 with UPI/card/online/gateway/platform-charge/settlement **all V2** and ⛔ **no V2 mechanism invented** — ⚠ with the trap **named**, that `PRD-008` **FROZEN v1.7 §6.1 L209/L210/L211/L213/L214 still say V1** and are **superseded IN EFFECT by rank**; **`AUTH-7.22`** closed catalogue with ⛔ **ZERO enumerated permissions** and `ADR-0043` §5.1 binding; **Auth v3.0/`ADR-0129`** with ⛔ no V1 OTP, no password, no email identity or recovery, **no v4.0**; **architecture** — `MP-GBR-24`, `MP-CON-01`/`02`, `ADR-0012` merge gate, modular monolith, EA descriptive-only. ⛔⛔ **NOTHING ELSE CHANGED IN THIS FILE:** ⛔ §1, §2, §3 (Stages 1–9), §4, §5, §6, §7, §8 and §9 are **byte-unchanged**; ⛔ **no stage renamed, renumbered or re-gated**; ⛔ **no registry status created** (`APPROVED` carries `6A`); ⛔ the **stale `IMPL-*` allocation table is NOT repaired** — it remains the `OPEN` baseline gap disclosed at `DOCUMENTATION_BASELINE.md` **L326** for the fourth consecutive backlog, and repairing it is unrelated drift outside this act. ⛔ **No Technical Specification was drafted.** ⛔ **NOT pushed.** |
|---|---|---|
| ⭐⭐ **v1.2** | 2026-09-10 | ⭐⭐ **§7A.9 GAINS ONE NEW `API` ROW — the API boundary clause. No stage added, renamed, renumbered or re-gated; no entry or exit criterion altered; §1–§7, §7A.1–§7A.8, §7A.10, §8 and §9 are BYTE-UNCHANGED.** Applies `Accepted` [`ADR-0135`](../adr/ADR-0135-api-governance-style-error-taxonomy-versioning-idempotency-transport.md) under a one-act **Architecture Owner** conferral — the office `ADR-0131` §12 names for **`B-5`**; ⛔ the office **reverts on completion**. ⭐⭐⭐ **FOUR OF THE SIX `B-5` DECISIONS WERE ALREADY MADE AT HIGHER RANK AND ARE RECOGNISED, NOT RE-DECIDED:** style from Rank-1 `MASTER_PRD` **L407** + Rank-4 BC Map **L226** + `MP-CON-09`; non-disclosing denial from ⭐ **`Accepted` `ADR-0010` L151**, which had **already rejected** *"distinct 404/403 for private vs non-existent"* as an *"**enumeration oracle**"*, plus FROZEN `AUTH-10.33`, `LCM-API-003` and `AP-9`; idempotency from ⭐ **FROZEN `FEE-FR-029`** (*"MUST accept an idempotency key **at the API edge**"*) + `FEE-INV-005` + `MP-GBR-18`; the session boundary from `MP-GBR-26` + Matrix **L220**. ⚠⚠ **ONE DECISION NEEDED REAL ARCHITECTURE JUDGEMENT BECAUSE RANK 1 AND RANK 6 DISAGREE:** **L408** requires *"versioned endpoints"* while EA **L380**/**L1787** date versioning **(V2)** — ⭐ resolved **by rank** (§4; baseline **L139** makes the EA *"descriptive … never lead"*) **and by distinguishing an interface *property* from management *machinery***: a V1 surface can carry a version without running a deprecation programme. ⛔⛔ **AND ONE LIMB IS STOPPED, NOT GUESSED — `API-GAP-001`:** the deprecation/sunset policy measured **0** governed statements repo-wide, is a **Product** commitment rather than an Architecture property, and **Product authority was not conferred**. ⭐ **Safe to leave open because V1 has no external API consumer** — `Public Developer APIs` is **(Future)** at EA **L1783**. ⚠⚠ **THE IDENTIFIER NAMESPACE WAS MEASURED AND THE OBVIOUS CHOICE REFUSED:** bare `API-NNN` measured **free (0)**, yet ⛔ three-digit `API-001` was **NOT** minted because **400** `LCF-`/`LCR-`/`LCM-`/`MSG-`/`SGR-`/`SSF-`/`SDS-`/`LCO-API-NNN` identifiers exist in baselined Rank-3 `PRD-021A`/`B` and a bare twin would collide in `grep`, traceability and the reader's eye; ⭐ single-digit **`API-1`…`API-9`** matches this repository's architecture-rule convention (`AP-3`…`AP-9`, `AR-1`…`AR-7`, `CID-1`…`CID-6`). ⛔ **`AERR-1`…`AERR-13`** (Authentication v2) are **not reused or extended**. ⛔⛔ **ZERO permission identifiers**; ⛔ `ADR-0132` **not reopened**; ⛔ endpoint-keyed grants **prohibited**. ⚠⚠ **CITATION COST ZERO, MEASURED BEFORE THE WRITE:** §7A.9's highest live citation is **L403** — the **PAYMENT** row, cited by `ADR-0134` — so the new row is **appended BELOW it at L407** and ⛔ **L403 is byte-unchanged**; **62** distinct lines are cited into this file, highest **L403**, and ⛔ **0 are shifted** by an append at L407. ⚠ **A PRE-EXISTING DEFECT IS DISCLOSED AND DELIBERATELY NOT REPAIRED:** this table's separator sits at **L453**, *below* the v1.1 data row at **L452** instead of directly under the header — a malformation introduced by the **v1.1** act itself (`024e20d`). ⭐ This row is inserted **directly after the separator**, which is both lawful Markdown and newest-first; ⛔ **re-ordering L452 is NOT done here** — it is unrelated cosmetic drift, and moving a row in a changelog to tidy it is exactly the silent edit this document's **L177** discipline warns against. ⛔ **NOT DONE:** no Technical Specification, `TS-001` **not allocated**, `docs/50-technical/` still **absent**; ⛔ **0** OpenAPI/endpoints/paths/verbs/status codes/header names/schemas; ⛔ **0** DB/SQL/migrations; ⛔ no Supabase change; ⛔ `PRD-008`/`019`/`022` and every frozen PRD byte-unchanged; ⛔ `ADR-0130`/`0131`/`0132`/`0133`/`0134` byte-unchanged; ⛔ **`Q-04` still OPEN, V1 schema freeze still BLOCKED**; ⛔ **`B-6` untouched**; ⛔ **0** code/test/tool files; ⛔ **0** blockers closed. **No baseline re-issue** — §7 rule 4's limb **unmet** (this file is **unranked**; no Rank 1–3 version change), so **`BASELINE-2026-09-10-C` STANDS**. ⛔ **NOT pushed.** |
| **v1.0** | 2026-08-04 | Created. Nine stages, each with a named exit-gate artefact, mapped to the nine registry statuses. Derived from the **three different routes** `PRD-001`, `PRD-002` and `PRD-003` actually took (§8) — authored, received verbatim, and reconciled — rather than from a generic template. Records that freeze is **conferred by the baseline, not self-declared**, and that no existing PRD declares its own freeze state. No frozen document is re-run through the lifecycle. No requirement created or modified; no PRD edited. |
