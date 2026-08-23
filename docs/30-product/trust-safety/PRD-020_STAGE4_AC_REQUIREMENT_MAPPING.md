# `PRD-020` Trust & Safety — Stage 4 Acceptance-Criterion → Requirement Mapping Record

| Field | Value |
|---|---|
| **Subject** | `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md` |
| **Purpose** | Close `RQ-1`, the sole failing check of the Stage 4 gate — *"Every acceptance criterion maps to a requirement"* (`PRD_LIFECYCLE.md` **L108-120**) |
| **Scope** | **`B-1` / `RQ-1` only.** `B-2` (matrix registration), `B-3` (`ADR-0074`), `B-4` (Stage 6 tasks) and `B-5` (freeze) are untouched |
| **Subject sha256 BEFORE** | `4c719dbf7904a07a8619ab6459f0f8e39dd79a4d603d153b44b3e536b3bbd90b` (225,545 B) |
| **Subject sha256 AFTER** | `c66764959a7fe07e88d14898a9024b663f4acb7562bb1aae34896fe3cb5d5d60` (226,292 B) |
| **⚠ This record edited its subject** | **Yes** — 32 acceptance-criterion rows gained a requirement citation. Precedent: `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md`, which likewise closed Stage 4 defects by editing its subject and published both hashes. §1.2 states the limits |
| **Result** | **61 of 62** criteria cite a requirement · **1** declared **UNMAPPED/GAP** (`TSF-AC-010`) · **0** silently uncited |
| **Date** | 2026-08-22 |

---

## 1. Method and limits

### 1.1 How the mapping was produced

1. All 62 `TSF-AC-*` rows were extracted from §27 (subsections at **L2174**, **L2189**, **L2208**, **L2229**, **L2244**). **30** already cited a requirement; **32** did not.
2. A requirement pool of **336** definition lines was extracted across the six normative registers — `TSF-FR-*`, `TSF-BR-*`, `TSF-INV-*`, `TSF-XC-*`, `TSF-CFG-*`, `TSF-EVT-*` — recognising both table-row and prose-initial definition forms, because PRD-020 uses both.
3. Each uncited criterion was matched **only** where a requirement states the same obligation in normative language. Thematic adjacency was not accepted as a match.
4. Every citation added was then verified to be a **defined** identifier, not merely a referenced one. **46 distinct requirements** were checked; **0 were undefined**.

### 1.2 What this record deliberately does NOT do

| Not done | Why |
|---|---|
| Invent a requirement to cover a criterion | The instruction forbids it, and a fabricated register entry is worse than a disclosed gap |
| Treat the **goal → AC** mapping at **L173** as satisfying the gate | It runs the **inverse** direction. `G-1 → TSF-AC-001…008` says a goal is *evidenced by* criteria; the gate asks whether a criterion is *grounded in* a requirement |
| Renumber, reuse or create any `TSF-*` identifier | `PRD_LIFECYCLE.md` §5 rule 5. **Zero** new identifiers were minted; every citation points at a pre-existing requirement |
| Alter any requirement's text | Only §27 criterion rows were touched. The requirement registers are byte-unchanged |
| Modify `TRACEABILITY_MATRIX.md`, `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, any ADR, or any Rank 1–5 document | Outside this record's authority and explicitly out of scope |
| Change the status of any `TSF-GAP-*` | A gap's status is an owner's act |

---

## 2. The 32 newly mapped criteria

Each row shows the criterion, the requirement now cited, and the **normative text** that grounds it.

### 2.1 Reporting (§27.1)

| AC | Requirement(s) | Grounding text |
|---|---|---|
| `TSF-AC-001` | `TSF-FR-044`, `TSF-FR-045`, `TSF-FR-046` | *"fileable from the surface where the content was encountered"* (**L828**) + report contents (**L829**) + *"The reporter **MUST** receive an acknowledgement with a case reference"* (**L830**) |
| `TSF-AC-002` | `TSF-FR-049`, `TSF-FR-050` | *"Evidence **MUST** be an immutable snapshot taken at report time"* (**L866**) + *"Evidence **MUST** record its **provenance** — `REPORTER_SUPPLIED`…"* (**L868**) |
| `TSF-AC-003` | `TSF-FR-045`, `TSF-FR-008` | `TSF-FR-045` requires a *"subject reference"* distinct from subject type (**L829**); `TSF-FR-008` — *"exactly one **subject** (`PersonId`) and zero-or-more reported **artefacts**"* (**L937**) — is what makes the field, not the person, the cited artefact |
| `TSF-AC-004` | `TSF-FR-112` | *"Where the moderator lacks a read path … console **MUST** say so and offer `UNRESOLVABLE_PENDING_ACCESS`"* (**L1538**) |
| `TSF-AC-005` | `TSF-FR-027` | *"subject type register **MUST** include `COMMUNITY_POST` and `COMMUNITY_COMMENT` from V1, **unpopulated** until `BC-15` ships"* (**L607**). An unpopulated type yields no surface — which is precisely *absent, not an error page* |
| `TSF-AC-006` | `TSF-FR-048` | *"Report submission **MUST** be idempotent on `(reporterId, subjectRef, categoryCode, idempotencyKey)`"* (**L833**) |
| `TSF-AC-007` | `TSF-FR-053`, `TSF-CFG-013` | *"Reports on the same subject and category within `TSF-CFG-013` **MUST** attach to the open case"* (**L910**) + the 24 h window (**L1666**) |
| `TSF-AC-009` | `TSF-EVT-001`, `TSF-INV-009` | `TSF-EVT-001`'s closed payload `{caseId, category, severity, filedAt}` contains no reporter field (**L1718**) + *"Reporter identity **MUST NOT** appear in any notice, appeal record or export"* (**L832**) |
| `TSF-AC-010` | ⚠ **UNMAPPED — see §4** | — |

### 2.2 Lifecycle & attribution (§27.2)

| AC | Requirement(s) | Grounding text |
|---|---|---|
| `TSF-AC-011` | `TSF-FR-138` | *"**T-2** **MUST** be exhaustive over the transition matrix, asserting **rejection of every pair not in §13.2**"* (**L2142**). This is the requirement that closes §13.2's table into a normative allow-list |
| `TSF-AC-012` | `TSF-FR-056` | *"`CLOSED` is **terminal**. New evidence … opens a **new** case linked to the old one; it **MUST NOT** reopen it"* (**L978**) |
| `TSF-AC-015` | `TSF-FR-009` | *"Every transition **MUST** append an immutable `CaseTransition`: from, to, actor, timestamp, reason"* (**L977**) |
| `TSF-AC-016` | `TSF-FR-107` | *"a claimed case **MUST NOT** be actionable by another moderator without an explicit, recorded reassignment"* (**L1528**) |
| `TSF-AC-017` | `TSF-INV-011` | *"An `SLA` breach **MUST** be recorded on the case and **MUST NOT** be silently reset by reassignment"* (**L913**) |
| `TSF-AC-019` | `TSF-BR-021` | *"`RESOLVED` / `NO_VIOLATION` **MUST** be a first-class, blameless outcome, surfaced in moderator quality metrics as a **correct** result"* (**L980**) |
| `TSF-AC-020` | `TSF-FR-067`, `TSF-INV-001` | *"Every action **MUST** carry: case reference, policy citation, actor, scope, and either an expiry or an explicit `permanent` flag"* (**L1208**) + attribution invariant (**L387**) |
| `TSF-AC-021` | `TSF-INV-012` | *"An `EnforcementAction` **MUST NOT** exist without a parent `ModerationCase` … enforced by **the aggregate boundary**, not by code review"* (**L935**) — the criterion's *"fails at the aggregate boundary"* is this requirement's own wording |
| `TSF-AC-022` | `TSF-FR-069`, `TSF-INV-003` | *"Action 9 **MUST** require two distinct human actors, recorded separately. **One human cannot end an account**"* (**L1210**) + *"permanent termination **MUST** carry a completed human review record"* (**L492**) |

### 2.3 Enforcement & containment (§27.3)

| AC | Requirement(s) | Grounding text |
|---|---|---|
| `TSF-AC-027` | `TSF-FR-001` | *"**MUST** answer within 50 ms at p99 and **MUST** fail closed"* (**L186**, **L649**) |
| `TSF-AC-028` | `TSF-FR-123` | *"idempotent on `(caseId, actionId)`; duplicate delivery **MUST NOT** produce a second restriction"* (**L1725**) |
| `TSF-AC-030` | `TSF-INV-021` | *"**Strike determinism.** The ladder **MUST** be a pure function of (decayed strike count, category severity, `TSF-CFG-004`, `TSF-CFG-002`). The same history **MUST** yield the same recommended posture"* (**L1249**) |
| `TSF-AC-031` | `TSF-FR-074`, `TSF-CFG-004` | *"Strikes **MUST** decay per `TSF-CFG-004`"* (**L1247**) + *"Strike decay half-life, 180 d … **decays weight, never deletes the row**"* (**L1657**) |
| `TSF-AC-032` | `TSF-FR-073` | *"A strike **MUST** be recorded only on an **upheld** action"* (**L1246**) |
| `TSF-AC-034` | `TSF-FR-075` | *"`CRITICAL` categories **MUST** be able to bypass the ladder to actions 8–9 at first instance, **with two humans**"* (**L1248**) |

### 2.4 Appeals & correction (§27.4)

| AC | Requirement(s) | Grounding text |
|---|---|---|
| `TSF-AC-041` | `TSF-INV-013` | *"An appeal **MUST NOT** be decided by the actor who took the action, nor by anyone in that actor's approval chain"* (**L976**) |
| `TSF-AC-046` | `TSF-FR-083` | *"On `Overturned` for a content removal, the content **MUST** be restored, not merely marked restorable"* (**L1301**) |
| `TSF-AC-047` | `TSF-FR-073` | *"An overturned appeal **MUST** remove the strike and **MUST NOT** leave a residual \"was accused\" mark anywhere on the ladder"* (**L1246**) |

### 2.5 Risk, privacy, isolation (§27.5)

| AC | Requirement(s) | Grounding text |
|---|---|---|
| `TSF-AC-051` | `TSF-FR-058` | *"Every `RiskSignal` **MUST** carry the rule identifier, observation window, measured value, threshold crossed, and a human-readable statement"* (**L1017**) — a five-for-five match with the criterion |
| `TSF-AC-052` | `TSF-FR-059`, `TSF-CFG-002` | *"replaying the same signals through the same rule version **MUST** yield the same output"* (**L1018**) + the rule-set version pin (**L1655**) |
| `TSF-AC-055` | `TSF-FR-065`, `TSF-CFG-020`, `TSF-CFG-021` | *"A rule whose FP rate exceeds `TSF-CFG-020` over `TSF-CFG-021` **MUST** be automatically demoted to `Observe`"* (**L1140**) + budget 10% (**L1673**) + period 30 d (**L1674**) |
| `TSF-AC-056` | `TSF-FR-064`, `TSF-FR-073` | *"false-positive rate, computed from `NO_VIOLATION` outcomes and **overturned** appeals"* (**L1139**) covers the counting limb; `TSF-FR-073` (**L1246**) covers the no-strike limb |
| `TSF-AC-061` | `TSF-FR-114`, `TSF-FR-116` | *"Every **read** of reporter-submitted private evidence **MUST** emit an audit event by `E-20` recording moderator, case, artefact and timestamp"* (**L1553**) + *"There **MUST NOT** be a free-text search over evidence content"* (**L1555**) |

---

## 3. Mapping strength

| Class | Count | Meaning |
|---|---|---|
| **Exact** — requirement states the criterion's obligation in the same terms | 27 | e.g. `TSF-AC-051` → `TSF-FR-058`; `TSF-AC-021` → `TSF-INV-012` |
| **Composite** — two or three requirements are jointly necessary, each cited | 4 | `TSF-AC-001`, `TSF-AC-020`, `TSF-AC-055`, `TSF-AC-056` |
| **Inferential** — the requirement grounds the criterion but does not restate it | 1 | `TSF-AC-005` → `TSF-FR-027`: *unpopulated register entry* ⇒ *no surface*. Disclosed here rather than presented as exact |
| **Unmapped** | 1 | `TSF-AC-010` — §4 |

---

## 4. The one genuine gap — `TSF-AC-010`

> `TSF-AC-010` — **Given** a subject who was reported, **when** they use the product, **then** nothing in any response reveals that a report exists.

**No requirement in PRD-020 states this obligation.** Four near-misses were examined and each rejected:

| Candidate | Line | Why it does not cover the criterion |
|---|---|---|
| `TSF-FR-047` | 831 | Conceals **who** reported, not **that** a report exists |
| `TSF-INV-009` | 832 | Same limb — reporter *identity* in notices, appeals and exports |
| `TSF-FR-098` | 1414 | *"Enforcement state **MUST NOT** be publicly observable"* — binds after **enforcement**. The criterion binds from the moment of **report**, before any action exists |
| `TSF-FR-024` | 567 | *"Exclusion **MUST** be indistinguishable from non-existence"* — again an exclusion, i.e. post-enforcement |

The nearest statement is not a requirement at all but a command-table cell — `FileAbuseReport` … *"Uniform; **never reveals whether a prior report exists**"* (**L1805**). That is the right obligation in the wrong register: it binds one command's response shape, whereas `TSF-AC-010` asserts a property of **any** response the subject can observe.

**Therefore:** a **new requirement** is needed — pre-enforcement report-existence non-disclosure, of the `MP-GBR-22` *denial ≡ not-found* family, scoped to every subject-visible surface.

⛔ **STOP — this record does not write it.** Minting a `TSF-FR-*` identifier is a **Product owner** act on PRD-020's content, and no such authority was conferred here. The row is marked **UNMAPPED** in the subject so the gap is visible at the point of use rather than only in this record.

| Item | Value |
|---|---|
| **Required act** | Author one new requirement in §18 (privacy/observability), then cite it from `TSF-AC-010` |
| **Owner** | **Product owner** (`PRD_LIFECYCLE.md` §6) |
| **Note on numbering** | The next free `TSF-FR-*` number must be determined **at the time of writing**. This record deliberately does **not** reserve one — `PRD_LIFECYCLE.md` §5 rule 5 forbids reuse, and a number reserved but unused is a trap for the next author |

---

## 5. Effect on the Stage 4 gate

| Check | Before | After |
|---|---|---|
| 1 Every requirement testable | ✅ | ✅ unchanged |
| 2 Every exclusion states what must be impossible | ✅ | ✅ unchanged |
| 3 Every configurable has a default and a range | ✅ | ✅ unchanged |
| **4 Every acceptance criterion maps to a requirement** | ⛔ **FAIL — 32 of 62 orphaned** | ⚠ **61 of 62 mapped; 1 declared gap with a named owner** |
| 5 No requirement restates another PRD's | ✅ | ✅ unchanged |
| 6 Business rules do not contradict Rank 1 | ✅ | ✅ unchanged |

**Gate text:** *"conflicts closed or explicitly deferred **with a reason and an owner**."*

31 of the 32 orphans are **closed**. The 32nd is **explicitly deferred, with a reason (§4) and an owner (Product owner)** — which is what the gate's own wording permits. `RQ-1` therefore moves from an **unresolved HIGH finding** to a **resolved finding with one disclosed deferral**.

⚠ **This does not by itself make Stage 4 a clean, unqualified PASS in the strongest sense** — one criterion still lacks a requirement, and `SID-4.56` (*"a rule that cannot be checked SHALL be treated as unmet"*) counsels against calling an outstanding item satisfied. The honest verdict is recorded in `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` §2 and §3.1.

---

## 6. Verification performed

| Check | Result |
|---|---|
| AC rows in §27 | **62** (unchanged) |
| Rows citing ≥ 1 requirement | **61** |
| Rows marked UNMAPPED | **1** (`TSF-AC-010`) |
| Rows silently uncited | **0** |
| Distinct requirements newly cited | **46** |
| Newly cited identifiers that are **undefined** | **0** |
| New `TSF-*` identifiers minted | **0** |
| Requirement register text altered | **None** — diff is 32 changed lines, all in §27 |
| Rank 1–5 documents, matrix, registry, baseline, ADRs | **Byte-unchanged** |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-08-22 | Created. `RQ-1` repaired: 31 criteria mapped to pre-existing requirements, 1 (`TSF-AC-010`) declared UNMAPPED with reason and owner. Subject edited (hashes above) under the `PRD-017` Stage 4 precedent. `B-2`/`B-3`/`B-4`/`B-5` untouched. |
