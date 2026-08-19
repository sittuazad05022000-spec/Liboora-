# `PRD-014` Entitlement v0.1 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–120) |
| **Subject** | [`PRD-014_ENTITLEMENT.md`](PRD-014_ENTITLEMENT.md) — `PRD-014`, `BC-21` Entitlement, **v0.1 `DRAFT`** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Gate satisfied by** | This document — §8. **0 conflicts closed by edit**, **13 items explicitly deferred**, every one with a reason **and** a named owner |
| **Predecessors** | [Stage 1 Discovery](PRD-014_STAGE1_DISCOVERY.md) ✅ **PASS** · [Stage 3 Alignment](PRD-014_ARCHITECTURE_ALIGNMENT.md) ✅ **CONDITIONAL PASS** (5 PASS, 1 CONDITIONAL on inherited `H-1`) |
| **Reviewed at** | `834fa52` |
| **PRD hash at review** | `d4ca7e11352d009c84b3ed38f531e7ce73bb059549db0cd3cb2bacc25214c175` — `sha256` of `PRD-014_ENTITLEMENT.md`, 658 lines, verified before and after this review |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6). **No named holder exists** — `PGA-08`, `PRD_LIFECYCLE.md` L283 |
| **Date** | 2026-08-19 |
| **Mandate** | **Stage 4 only.** No PRD modified · no ADR created · no identifier registered in any matrix · no ranked document touched · no registry or baseline update · no traceability checker written · no freeze. **No implementation code modified.** Stages 5–7 not started · Stage 8 not entered |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** 13 explicit deferrals each with a reason and an owner · **2 genuine defects found in the draft** and deferred rather than silently edited (§8.4) · **1 defect found in this review's own predecessor record** and disclosed (§8.5) · **2 defects found in this review's own checkers** and disclosed (§10) · 11 candidate findings rejected with reasons (§9) |

> `PRD_LIFECYCLE.md` L41–42: *"A gate is not an opinion — if the artefact does not exist, the stage has not been
> passed, however complete the work feels."* This document is that artefact for Stage 4.

---

## 1. Method

Stage 3 asked *"is this PRD lawful against Ranks 1–5?"* Stage 4 asks a different question: *"is this PRD
**buildable and verifiable** as written?"* The six checks are internal-quality checks. Five of the six are
mechanically decidable, so each was decided by a script over the document text rather than by reading it.

Where a mechanical result disagreed with the document, the disagreement was driven to root cause **before either
side was believed**. That happened four times in this review. Twice the document was right and the checker was
wrong (§10). Twice the checker was right and the document carries a real defect (§8.4).

### 1.1 The six checks and how each was decided

| # | Check (`PRD_LIFECYCLE.md` L110–118) | Failure mode the lifecycle names | Decided by |
|---|---|---|---|
| 1 | Every requirement testable | *"'The system should be fast' — unverifiable"* | Script — modality census + vague-adjective scan + unverifiable-claim scan |
| 2 | Every exclusion states what must be **impossible** | *"An exclusion is not a deferral"* | Script — impossibility modality per `ENT-XC-*` + deferral-language scan + owner-cell census |
| 3 | Every configurable has a default and a range | *"Unbounded configuration is a specification hole"* | Script — `ENT-CFG-*` count + numeric-literal scan across all requirements |
| 4 | Every acceptance criterion maps to a requirement | *"Orphan criterion"* | Script — forward **and** reverse coverage, recomputed from declared ranges independently of §10.1 |
| 5 | No requirement restates another PRD's | *"Two sources of truth"* | Script — foreign-identifier census + attribution test — then §0.5 audited by reading |
| 6 | Business rules do not contradict Rank 1 | *"Rank 1 wins; the PRD is wrong"* | Script — permissive-mutation scan + Rank 1 hazard-term scan + citation census |

### 1.2 Why this review does not edit the draft

Two genuine defects were found in the draft (§8.4). Neither was repaired by editing the PRD. That is a
deliberate choice with a stated authority, not reticence.

`tool/docs_check/alignment_record_freshness.py` exists precisely because *"a Stage 3 or Stage 4 review record
measures a PRD **at a revision**"*, and when the PRD is then revised *"the record's measurement silently becomes
a statement about a document that no longer exists — while still reading as a current verdict."* It quotes the
baselined `PRD-006` precedent as the governing mechanism:

> *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded."*

Editing `PRD-014_ENTITLEMENT.md` during Stage 4 would change its hash and thereby invalidate the Stage 3
alignment record's measurement of it — manufacturing the exact drift class that gate exists to catch. It would
also depart from the immediate precedent: `PRD-016`'s Stage 4 record states **"No PRD modified"** in its own
mandate row.

The lifecycle gate does not require closure by edit. It requires *"conflicts closed **or explicitly deferred**
with a reason and an owner."* Both defects are deferred, with a reason and a named owner, in §8.4.

---

## 2. Check 1 — Every requirement is testable

**Population.** 42 requirements bearing conduct obligations: `ENT-FR-001`…`028` (28), `ENT-BR-001`…`008` (8),
`ENT-INV-001`…`006` (6).

### 2.1 Modality census

| Result | Count |
|---|---|
| Requirements carrying a prescriptive keyword (`SHALL` / `MUST` / `SHALL NOT` / `MUST NOT`) | **32** |
| Requirements stating a testable property in **declarative-prohibitive** or **declarative-property** form | **10** |
| Requirements carrying neither | **0** |

The ten declarative requirements were read individually, because a first pass of the checker flagged them as
failures and that flag had to be resolved rather than dismissed (§10, defect `S4-C-01`).

| ID | Form | Why it is testable |
|---|---|---|
| `ENT-BR-001` | *"A manual grant … is **prohibited**"* | A prohibition is a decidable predicate over call graphs — `ENT-AC-002`, `ENT-AC-004` |
| `ENT-BR-004` | *"A feature flag being on does **not** confer entitlement"* | An implication asserted false. Testable by the counter-case in `ENT-AC-024` |
| `ENT-BR-005` | *"consulted **before** a mutation, never after"* | An ordering property. Testable by call-order assertion — `ENT-AC-012` |
| `ENT-BR-007` | *"Absence of tenant context is a **failure**, not a condition with a default"* | An error-behaviour property — `ENT-AC-008` |
| `ENT-BR-008` | *"grace period is a **configured** value, never an implicit one"* | Absence of a hardcoded literal is statically decidable — `ENT-AC-026` |
| `ENT-INV-001` | *"replaying … produces an `EntitlementSet` **identical** to …"* | An equality assertion — `ENT-AC-003` |
| `ENT-INV-002` | *"**No code path** outside a … handler writes entitlement state"* | A reachability property — `ENT-AC-002` |
| `ENT-INV-003` | *"bound to exactly one `tenantId`, and no read or write path can reach …"* | A quantified reachability property — `ENT-AC-016` |
| `ENT-INV-004` | *"are **functions of** consumed inputs alone"* | Reproducibility from inputs — `ENT-AC-025` |
| `ENT-INV-006` | *"leaves `EntitlementSet` **unchanged**"* | A state-equality assertion — `ENT-AC-007` |

An invariant expressed as a property rather than an instruction is the normal and correct form for an invariant.
`§0.1` of the draft defines its normative vocabulary, and none of these ten is vague — each names the observable
that decides it.

### 2.2 Vague-language and unverifiable-claim scans

| Scan | Pattern | Result |
|---|---|---|
| Vague adjectives | `fast`, `quickly`, `efficient`, `user-friendly`, `robust`, `scalable`, `as needed`, `appropriate`, `reasonable`, `etc.` | **0 matches across all 42** |
| Unverifiable hedges | `should be`, `as fast as possible`, `best effort`, `where possible`, `if feasible`, `ideally`, `generally`, `typically`, `usually` | **0 matches across all 42** |

The lifecycle's named failure for this check is literally *"The system should be fast."* Neither `should be` nor
`fast` occurs in any requirement.

### 2.3 The one bounded permission

`ENT-FR-010` is the only requirement using `MAY`:

> *"The module **SHALL NOT** assume global event ordering. It **MAY** rely only on ordering per aggregate,
> guaranteed by the partition key `aggregateId`."*

The `MAY` is bounded by *"only"* and is subordinate to a `SHALL NOT` in the same sentence. The testable
obligation is the prohibition; the permission narrows what remains. This is not an unverifiable requirement — it
is one requirement with an explicit safe harbour. Candidate finding rejected as `R4-09`.

### 2.4 The requirement whose testability is genuinely conditional

`ENT-FR-018` — the fail-open/fail-closed disposition — is testable **in shape** but not **in value**, because the
configured value it defers to does not exist (`ENT-GAP-002`) and the decision that would create it is Open
(`ENT-GAP-001`, `Q-03`). The draft states this itself: *"This requirement is therefore **satisfiable only after
`ENT-GAP-002` closes**, which is stated rather than hidden."*

A requirement that names its own precondition and the gap that blocks it is not an unverifiable requirement. It
is a verifiable requirement with a disclosed dependency. Deferred as **`S4-D-05`** in §8.2 with a named owner.
The alternative — choosing a default here — is prohibited invention.

### 2.5 Result

✅ **PASS.** 42 of 42 requirements are testable. 0 vague, 0 unverifiable-hedged, 1 bounded permission, 1 with a
disclosed and deferred precondition.

---

## 3. Check 2 — Every exclusion states what must be impossible

**Population.** 12 exclusions, `ENT-XC-001`…`012`.

### 3.1 Mechanical result

| Test | Result |
|---|---|
| Exclusions carrying an impossibility modality (`MUST NOT` / `SHALL NOT` / `prohibited`) | **12 of 12** |
| Exclusions containing deferral language (`later`, `deferred to a future version`, `will be added in`, `out of scope for now`, `phase 2`, `V2 will`) | **0 of 12** |
| Exclusions naming an `Owner:` in their own row | **11 of 12** — `ENT-XC-012` does not |

The lifecycle's named failure is *"An exclusion is not a deferral."* Zero exclusions defer. Every one states
what must be impossible, in the imperative negative.

### 3.2 The owner census — where each excluded subject went

An exclusion that says *"not here"* without saying *"there"* leaves the subject homeless. Eleven of the twelve
name a holder:

| Exclusion | Subject excluded | Owner named in the row |
|---|---|---|
| `ENT-XC-001` | `Tenant`, `TenantTier`, `Quota`, `ResidencyRegion`, `TenantLifecycleState` | `BC-19` / `PRD-013` (FROZEN) |
| `ENT-XC-002` | `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`, `PaymentAttempt`, `DunningState` | `BC-20` / `PRD-022` |
| `ENT-XC-003` | Emission and versioning of `billing.EntitlementChanged` | `BC-20` |
| `ENT-XC-004` | Money, gateway, invoice, dunning, `BZ-2`, `payment_gateway` port | `BC-20` |
| `ENT-XC-005` | Proration arithmetic | **undetermined** — `Q-06` is Open, and the row says so |
| `ENT-XC-006` | `MembershipPlan`, publication of `seatQuota` | `BC-02` / `PRD-005` (FROZEN) |
| `ENT-XC-007` | `Seat`, seat allocation, seating layout | `BC-04` / `PRD-007` (FROZEN) |
| `ENT-XC-008` | Feature-flag definition, evaluation, rollout | `BC-25` / `PRD-023` |
| `ENT-XC-009` | Authorisation, credential, OTP, session | `BC-18` |
| `ENT-XC-010` | `AuditEntry`, audit store | `BC-24` / `PRD-016` (FROZEN) |
| `ENT-XC-011` | Any domain or `app/**` import | *"the architecture itself"* — `F-1`, `L2`, `banned_imports` |
| `ENT-XC-012` | Reliance on an edge absent from BC Map §7 | **none stated** — defect `S4-F-01` |

`ENT-XC-005`'s owner cell reading **undetermined** is correct conduct, not a defect: `Q-06` is Open at Rank 4
(BC Map L545) and Rank 1 (`MASTER_PRD.md` L678), and the row cites both. Naming an owner there would be
inventing an ownership decision. Candidate finding rejected as `R4-12`.

### 3.3 The one exclusion without a stated owner — `S4-F-01`

`ENT-XC-012` prohibits creating or relying upon an edge absent from BC Map §7. Its authority line cites the §7
preamble (L292) and the posture inherited from `PRD-013` **L431 `H-1`**, but the row does not carry an `Owner:`
cell as the other eleven do — while §9's own preamble promises *"Each row below names the owner that holds the
excluded thing."*

This is a **real internal inconsistency between the draft's §9 preamble and its twelfth row**, and it is recorded
as such. It is *not* a check-2 failure: check 2 tests whether an exclusion states an impossibility, and
`ENT-XC-012` states one plainly (*"MUST NOT create, assume or rely upon"*). The owner is also *discoverable* from
the row's own citation — `H-1`'s owner is the Architecture Owner, per `PRD-013` L431 and this PRD's
`ENT-GAP-005`. What is missing is the explicit cell, not the answer.

Recorded as **`S4-F-01`**, Low, owner **Product owner**, deferred in §8.4 rather than edited (§1.2).

### 3.4 Result

✅ **PASS.** 12 of 12 state what must be impossible. 0 deferrals. 1 row omits an owner cell whose answer is
discoverable from its own citation — recorded as `S4-F-01` and deferred with an owner.

---

## 4. Check 3 — Every configurable has a default and a range

### 4.1 The check is satisfied by the register being empty

`ENT-CFG-*` has **zero** entries. Mechanically confirmed: `grep -cE '\bENT-CFG-[0-9]+'` over the draft returns
**0** — the register is not merely described as empty, it *is* empty.

Check 3 quantifies over configurables: *"**Every** configurable has a default and a range."* Over an empty set
the predicate holds vacuously. There is no configurable in this PRD lacking a default, because there is no
configurable in this PRD.

### 4.2 The register is empty because no authority at any rank supplies a bound — and the draft records that

The emptiness is a finding, not an omission. §0.3 and §11 both state the reason and cite the measurements:

| Fact | Measured |
|---|---|
| BC Map **L326** (`E-17`) assigns the per-feature fail disposition to Config: *"decided per feature, **recorded in Config**"* | The instruction exists |
| `docs/20-configuration/CONFIGURATION_GUIDE.md` (Rank 7) searched for `entitlement\|BC-21\|quota\|feature.?gate\|usage.?count` | **7 hits, every one an OTP/SMS value** (`CFG-1`…`CFG-4`, `INV-4`) |
| `docs/10-architecture/ARCHITECTURE_RULINGS.md` (Rank 5) | **0 entitlement rulings** |
| `Q-03`, the question that would decide the value | **Open** at Rank 4 (BC Map L542) and Rank 1 (`MASTER_PRD.md` L675) |

Declaring a configurable here would require choosing both a default and a range for a value the platform has not
decided. `PRD_LIFECYCLE.md` L114 demands both; the user's mandate prohibits inventing *"configuration values."*
The two obligations meet exactly at *"record the hole."* The draft records it as `ENT-GAP-001` and
`ENT-GAP-002`, both **High**, both with named owners.

> §0.3 of the draft: *"An empty register that names its reason is a finding. An empty register that says nothing
> is an omission."*

### 4.3 The complementary scan — no requirement smuggles in an unbounded value

An empty `ENT-CFG-*` register would be worthless if a requirement hardcoded a tunable elsewhere. All 42
requirements were scanned for a bare numeric literal followed by a duration, count or percentage unit
(`second`, `minute`, `hour`, `day`, `ms`, `millisecond`, `%`, `percent`).

**Result: 0 matches.** No requirement hardcodes a timeout, a grace period, a limit value or a threshold.
`ENT-BR-008` is the sharpest test of this — it governs the downgrade grace period and states only that it is
*"a **configured** value, never an implicit one"*, citing BC Map **L467** verbatim, without naming a duration.

### 4.4 Result

✅ **PASS.** 0 configurables declared, so 0 configurables lack a default or a range. The emptiness is justified
against four measured authorities and recorded as two High-severity open gaps. 0 unbounded literals leak into the
requirement text.

---

## 5. Check 4 — Every acceptance criterion maps to a requirement

### 5.1 Forward coverage — the direction the gate actually tests

The lifecycle names the failure as **"Orphan criterion"** — a criterion mapping to no requirement.

| Test | Result |
|---|---|
| Acceptance-criteria rows in §10 | **26** |
| Rows whose `Proves` column is empty | **0** |
| Distinct identifiers cited across all `Proves` columns | **51** |
| Cited identifiers that are **not** obligation-bearing (i.e. would be orphan references) | **0** |
| Cited identifiers with no definition site in the document | **0** |
| Duplicate `ENT-AC-*` identifiers | **0** |

**Zero orphan criteria.** Every one of the 26 criteria names at least one obligation, every named obligation is
a real declared identifier, and every one has a definition site in the document. Check 4's named failure mode
does not occur.

### 5.2 Reverse coverage — recomputed independently, and it agrees with the draft

Reverse coverage is not what check 4 names, but it is the more useful measure, so it was recomputed from first
principles rather than read from §10.1. The obligation set was constructed from the **declared ranges** in §0.2
(`FR` 1–28, `BR` 1–8, `INV` 1–6, `XC` 1–12 = 54), not from what the document happens to cite — so that a
requirement omitted from both §10 and §10.1 would still be caught.

| Measure | Recomputed | §10.1 claims | Agree? |
|---|---|---|---|
| Obligation-bearing identifiers | **54** | 54 | ✅ |
| Obligations covered by ≥ 1 criterion | **51** | 51 | ✅ |
| Coverage | **94.4 %** | 94.4 % | ✅ |
| Uncovered obligations | `ENT-FR-017`, `ENT-FR-018`, `ENT-FR-026` | same three, named | ✅ |
| Orphan criteria | **0** | 0 | ✅ |

The draft's published figures are exact. This is the second independent computation of them — the first was run
at Stage 2 against the finished draft — and both agree.

### 5.3 Each of the three uncovered obligations was tested for whether a criterion is *owed*

| Uncovered | Is a criterion owed? | Reasoning |
|---|---|---|
| `ENT-FR-017` | **No — not writable here** | It obliges this module to expose remaining allowance *so that callers need no duplicate limit*. The absence of a duplicate is a property of `BC-04`'s and `BC-02`'s code. A criterion asserted in this PRD would test contexts this PRD does not govern — which check 5 forbids. The supply-side half **is** covered, by `ENT-AC-013` via `ENT-FR-022` |
| `ENT-FR-018` | **No — would require inventing a value** | The configured per-feature disposition does not exist (`ENT-GAP-002`) and `Q-03` is Open (`ENT-GAP-001`). A criterion would have to name fail-open or fail-closed for some feature. That is the prohibited invention |
| `ENT-FR-026` | **No — would presume an open answer** | Whether a `BC-21` → `BC-24` edge is lawful is the `H-1` taxonomy gap (`ENT-GAP-005`). A criterion would encode an answer the architecture has not given |

All three are uncovered **for stated reasons recorded in the document itself**, not by oversight. Each is
deferred in §8.2 with a named owner.

### 5.4 Result

✅ **PASS.** 0 orphan criteria — the failure mode check 4 names. 26 criteria, all mapped. Reverse coverage 94.4 %,
independently recomputed and matching the draft exactly; the 3 uncovered obligations are uncovered lawfully and
deferred with owners.

---

## 6. Check 5 — No requirement restates another PRD's

### 6.1 Census of foreign authority inside requirement text

All 42 requirements were scanned for identifiers belonging to other PRDs' registers
(`MM-`, `SEAT-`, `FEE-`, `ATT-`, `TEN-`, `AUD-`, `SAAS-`, `STU-`, `AUTH-`).

| Requirement | Foreign identifier cited | Attributed? |
|---|---|---|
| `ENT-BR-003` | `TEN-FR-006` (`PRD-013`, FROZEN) | ✅ — *"`PRD-013` **L157–159** `TEN-FR-006`, FROZEN: the two value-object sets 'are disjoint'"* |
| `ENT-FR-028` | `MM-FR-014` (`PRD-005`, FROZEN) | ✅ — *"Corroborated by `PRD-007` **L147** and `PRD-005` **L240** `MM-FR-014`"* |

**Two citations in 42 requirements.** Both carry an attributing construction naming the source document, its line
and its status. Zero unattributed foreign identifiers.

### 6.2 The distinction that decides this check

Check 5's failure is *"Two sources of truth"* — the same rule stated authoritatively in two documents, so that
amending one silently diverges from the other. It is **not** a prohibition on citation; the user's own mandate
requires the opposite: *"cite their authority where required."*

The test applied was therefore: *does this requirement create an obligation whose authority is this document, on
a subject another document owns?*

| Requirement | What it obliges | Whose authority | Verdict |
|---|---|---|---|
| `ENT-BR-003` | **This module** SHALL NOT define, store or recompute `TenantTier` / `Quota` | This document's, about this module's conduct | Not a restatement — it is the mirror obligation. `PRD-013` L157–159 is cited as the *fact* of disjointness |
| `ENT-FR-028` | **This module** SHALL use `SeatQuota`, SHALL NOT use `Seat` | This document's. The terminology rule is BC Map L211 (Rank 4), cited | Not a restatement — `MM-FR-014` is corroboration, and `PRD-005` remains the publisher of the value |

### 6.3 The subtlest case in the document, and it passes

The highest-risk restatement available to a BC-21 PRD is the fail-closed rule. `PRD-005` `MM-BR-013` and
`PRD-007` `SEAT-FR-296` **already assert fail-closed conduct** for their own gates. A PRD-014 that lifted either
into a platform-wide entitlement rule would create exactly two sources of truth on the most revenue-sensitive
behaviour in the system — and would additionally close `Q-03` without an ADR.

The draft does neither. `ENT-FR-018` states the requirement's **shape** (per-feature, resolved from external
configuration) and explicitly forbids the generalisation:

> *"The module … **SHALL NOT** derive one by generalising any other context's statement of its own conduct."*

And §0.4 registers the near-miss in terms:

> *"`PRD-005` `MM-BR-013` and `PRD-007` `SEAT-FR-296` assert fail-closed **for their own gates, on their own
> authority**. This document cites them; it does not generalise them into a `BC-21` platform rule."*

A requirement that names the restatement it is refusing to make is the strongest available evidence for this
check.

### 6.4 §0.5 is a declared no-restatement register, and it was audited

The draft carries a 10-row register of subjects it deliberately does not restate. Each row was tested against the
document body for leakage:

| Subject | Owner | Leakage found? |
|---|---|---|
| Tenant lifecycle, `TenantTier`, `Quota`, residency | `BC-19` / `PRD-013` | None — cited as inputs; `ENT-XC-001` prohibits definition |
| Subscriptions, plans, invoices, gateway, dunning | `BC-20` / `PRD-022` | None — `ENT-XC-002`, `ENT-XC-004` |
| Schema and emission of `billing.EntitlementChanged` | `BC-20` | None — `ENT-XC-003`. The event is cited from BC Map L437, never specified |
| Membership plans, publication of `seatQuota` | `BC-02` / `PRD-005` | None — `ENT-XC-006` |
| Seat allocation and its own fail-closed conduct | `BC-04` / `PRD-007` | None — §6.3 above |
| Feature-flag definition, evaluation, rollout | `BC-25` / `PRD-023` | None — `ENT-XC-008`, `ENT-BR-004` states only the boundary |
| Authorisation, credentials, OTP, sessions | `BC-18` | None — `ENT-XC-009` |
| Audit persistence (`AuditEntry`) | `BC-24` / `PRD-016` | None — `ENT-XC-010`, `ENT-FR-026` |
| The event delivery contract (outbox, at-least-once, envelope, ordering, replay) | BC Map §9.1, Rank 4 | None — `ENT-FR-008`, `ENT-FR-009`, `ENT-FR-010` each state *this module's* duty **given** the contract, and cite §9.1 rather than reproducing it |
| Tenant partitioning as a platform rule | `MP-GBR-08`, `MP-GBR-09`, Rank 1 | None — `ENT-FR-021`, `ENT-INV-003` state this module's obligations |

The ninth row is the one worth dwelling on. It would have been easy, and wrong, to reproduce the envelope's ten
fields and the outbox mechanics inside PRD-014. The draft cites §9.1 and states only what this module must do —
be idempotent on `eventId`, fail loudly without `tenantId`, not assume global ordering.

### 6.5 Result

✅ **PASS.** 2 foreign citations in 42 requirements, both attributed with document, line and status. 0 obligations
authored here on a subject another document owns. The highest-risk restatement available is explicitly refused in
requirement text. A 10-row declared no-restatement register audited row by row with 0 leakage.

---

## 7. Check 6 — Business rules do not contradict Rank 1

**Population.** 8 business rules, `ENT-BR-001`…`008`. Rank 1 = `MASTER_PRD.md` and the governance documents.

### 7.1 The eight rules against their Rank 1 authorities

| Rule | Rank 1 authority | Direction |
|---|---|---|
| `ENT-BR-001` — manual grant prohibited | Matrix `X-11` (Rank 4). No Rank 1 rule permits a manual grant | Consistent; no Rank 1 counterpart to contradict |
| `ENT-BR-002` — rebuild divergence is a defect | BC Map L383 (Rank 4) | Consistent |
| `ENT-BR-003` — `TenantTier`/`Quota` are inputs, never outputs | `PRD-013` L157–159 (Rank 3) | Consistent; narrows, does not widen |
| `ENT-BR-004` — flag ≠ entitlement, entitlement ≠ flag | `ADR-0017` L125–126 (Rank 2, **Accepted**) | Consistent |
| `ENT-BR-005` — consulted before mutation, never after | BC Map L326 (Rank 4) | Consistent |
| `ENT-BR-006` — derived from library→LIBOORA money only | **`MP-GBR-24`** (Rank 1) — the two *"must never share a model, a table or a metric"* | **Directly implements** it |
| `ENT-BR-007` — absence of tenant context is a failure, not a default | **`MP-GBR-06`**, **`MP-GBR-07`** (Rank 1) — a consumer *"fails loudly, never defaults"* | **Directly implements** it |
| `ENT-BR-008` — downgrade tightening is eventual; grace period configured, never implicit | BC Map L467 (Rank 4) | Consistent |

Two of the eight are direct implementations of a Rank 1 rule. None weakens one.

### 7.2 Permissive-mutation scan

Each rule was scanned for language that would permit what Rank 1 forbids — `MAY be set/edited/overridden/
defaulted`, `may default`, `is permitted to default/skip/bypass`, `can be bypassed`, `optional tenant`,
`without tenant context`.

**Result: 0 of 8 contain permissive mutation language.** `ENT-BR-007` is the decisive case: where a permissive
rule would have said *"MAY default to the starter tier"*, it says *"Absence of tenant context is a **failure**,
not a condition with a default."*

### 7.3 Rank 1 hazard-term scan — the rules PRD-014 could contradict by trespass

Beyond the rules it cites, PRD-014 could contradict Rank 1 by touching a subject Rank 1 closes. Each hazard term
was counted across the whole draft:

| Rank 1 rule | Hazard term | Occurrences in PRD-014 |
|---|---|---|
| `MP-GBR-03` — `StudentRecordId` never leaves its tenant | `StudentRecordId` | **0** |
| `MP-GBR-21` — scope register closed to `self`, `guardianOf`, `tenantWide` | `guardianOf` · `tenantWide` · `scope register` | **0 · 0 · 0** |
| `MP-GBR-02` / identity rules | `PersonId` | **0** |
| `MP-GBR-24` — student→library money is a different concept | `student fee` · `BC-05` | **0 · 0** |

Zero trespass. PRD-014 introduces no scope, touches no student identifier, and never references `BC-05` — the
context whose money `MP-GBR-24` insists must never share a model with `BC-20`'s.

### 7.4 Rank 1 citation census

Rank 1 rules cited in the draft: **`MP-GBR-06`, `MP-GBR-07`, `MP-GBR-08`, `MP-GBR-09`, `MP-GBR-18`,
`MP-GBR-24`** — six, each on the subject it governs. No `MP-ASM-*`, `MP-CON-*`, `MP-FUT-*` or `MP-SM-*` is cited,
and none is contradicted; they govern subjects this module does not touch.

### 7.5 One rule is stronger than Rank 1 requires, and that is lawful

`ENT-BR-007` extends *"fails loudly, never defaults"* from `MP-GBR-07`'s stated domain — the processing of an
**emitted domain event** — to *any* absence of tenant context, including a synchronous `check` call. That is
strictly stronger than Rank 1 demands.

Strengthening is not contradiction. Rank 1 sets a floor; a module PRD may hold itself above it, and a stricter
rule cannot cause a Rank 1 violation. The direction that would fail this check is the opposite one. Candidate
finding rejected as `R4-07`.

### 7.6 Result

✅ **PASS.** 8 of 8 consistent with Rank 1; 2 directly implement a Rank 1 rule; 1 is deliberately stronger than
Rank 1 requires. 0 permissive-mutation constructions. 0 hazard-term trespass across four closed Rank 1 subjects.

---

## 8. The gate — conflicts closed or explicitly deferred, with a reason and an owner

> `PRD_LIFECYCLE.md` L120: *"**Gate:** conflicts closed or explicitly deferred **with a reason and an owner**."*

### 8.1 Conflicts requiring closure

**Zero.** No check produced a conflict between the draft and an authority. The two defects found (§8.4) are
internal-consistency defects in the draft, not conflicts with a ranked document.

### 8.2 Explicit deferrals — the draft's own, each carrying a reason and an owner

The draft's §12 records eight open gaps. Each was verified to carry evidence, severity, an owner and a status:

| Deferral | Reason | Owner | Status |
|---|---|---|---|
| `ENT-GAP-001` | `Q-03` (fail-open vs fail-closed on timeout) is **Open** — BC Map L542, `MASTER_PRD.md` L675 | Architecture Owner | OPEN |
| `ENT-GAP-002` | `E-17` requires a per-feature disposition *"recorded in Config"*; no entitlement configurable exists at any rank | Governance Owner and `BC-25` / `PRD-023` | OPEN |
| `ENT-GAP-003` | `Q-06` (proration ownership) is **Open** — BC Map L545, `MASTER_PRD.md` L678 | Architecture Owner | OPEN |
| `ENT-GAP-004` | `PRD-022` (962 lines) contains **zero** mentions of entitlement, yet owns this module's only lawful input | Product owner, `PRD-022` | OPEN |
| `ENT-GAP-005` | `H-1` — BC Map §7 has no capability→capability subsection | Architecture Owner | OPEN, inherited |
| `ENT-GAP-006` | BC Map L383 grants an aggregate; Matrix L70 says R6 owns none. Both Rank 4, no tie-break exists | Architecture reviewer | OPEN |
| `ENT-GAP-007` | `ADR-0035` / `ADR-0036` header status contradicts their own changelogs | Governance Owner | OPEN |
| `ENT-GAP-008` | `IMPLEMENTATION_ROADMAP.md` contains **zero** entitlement references | Implementation lead | OPEN |

Three further deferrals arise from this review's coverage analysis (§5.3):

| Deferral | Reason | Owner |
|---|---|---|
| **`S4-D-04`** | `ENT-FR-017` carries no acceptance criterion because the property is a property of *other* contexts' code, and asserting it here would breach check 5 | Product owner, jointly with `BC-02` / `BC-04` owners |
| **`S4-D-05`** | `ENT-FR-018` carries no acceptance criterion, and is satisfiable only after `ENT-GAP-002` closes, because a criterion would have to name a value this document may not invent | Architecture Owner (via `ENT-GAP-001`) |
| **`S4-D-06`** | `ENT-FR-026` carries no acceptance criterion because writing one would presume the answer to `H-1` | Architecture Owner (via `ENT-GAP-005`) |

### 8.3 Code contradictions — deferred to Stage 8, each with the requirement it will be built against

The draft's §13 records six contradictions between the specification and the existing implementation. Stage 4
does not repair code; it confirms each has a requirement to be built against, so that Stage 6 can task it.

| Contradiction | Existing behaviour | Requirement it must satisfy |
|---|---|---|
| `D-014-01` | `_limits` and `_gates` are hardcoded `static const` maps, not event-derived | `ENT-FR-003`, `ENT-FR-004`, `ENT-INV-001` |
| `D-014-02` | `check(Feature, {delta})` omits `tenantId` | `ENT-FR-013`, `ENT-FR-014` |
| `D-014-03` | Unknown tenant silently defaults to `TenantTier.starter` | `ENT-FR-009`, `ENT-BR-007` (and Stage 3 `A-07`, **High**) |
| `D-014-04` | `_usage` is in-memory with no persistence or outbox | `ENT-FR-020`, `ENT-INV-001` |
| `D-014-05` | `find test -iname '*entitlement*'` returns nothing — **0 tests** | All 26 `ENT-AC-*` |
| `D-014-06` | `seed.dart:95–96` writes tier directly via `registerTenant` | `ENT-FR-003`, `ENT-INV-002` — and Stage 3 `A-08`, whose lawfulness is undetermined |

All six are **deferred to Stage 8**, owner **Implementation lead**. No code was modified by this review.

### 8.4 Two genuine defects found in the draft by this review — deferred, not silently edited

| ID | Defect | Evidence | Severity | Owner | Disposition |
|---|---|---|---|---|---|
| **`S4-F-01`** | `ENT-XC-012` omits the `Owner:` cell that §9's own preamble promises for every row (*"Each row below names the owner that holds the excluded thing"*). 11 of 12 rows carry it | Owner-cell census, §3.1–3.3 | **Low** | Product owner | **DEFERRED.** Not a check-2 failure — the row states its impossibility plainly, and the owner is discoverable from its own citation (`H-1` ⇒ Architecture Owner). Correction belongs to the next revision of the draft, not to an in-place edit during review (§1.2) |
| **`S4-F-02`** | `ENT-FR-017` and `ENT-FR-022` overlap substantively — both oblige the module to expose remaining allowance. Token-set Jaccard **0.438**, the only pair in 861 comparisons above the 0.40 threshold | Internal non-duplication scan, all 42 requirements pairwise | **Low** | Product owner | **DEFERRED.** They are distinguishable — `ENT-FR-022` is the plain read surface (BC Map L130 *"how much of it is left"*), `ENT-FR-017` is the single-source-of-truth obligation that no caller need hold a duplicate limit (BC Map L130 *"Single source of truth"*, plus the `PRD-007` L2128–2135 demand). But **the draft does not state that boundary**, and two requirements obliging the same exposure is a duplication risk *inside* one document. A clarifying sentence is owed at the next revision |

Neither is a failure of any of the six checks. `S4-F-02` in particular is worth being precise about: check 5's
named failure is *"No requirement restates **another PRD's**"* — internal overlap is not the failure mode the
lifecycle names, which is why check 5 passes. The overlap is nonetheless a real specification-quality defect and
is recorded rather than passed over.

### 8.5 A defect in this review's own predecessor record — disclosed

| ID | Defect | Severity | Owner | Disposition |
|---|---|---|---|---|
| **`S4-F-03`** | `PRD-014_ARCHITECTURE_ALIGNMENT.md` (Stage 3, written by this same reviewer) contains **no "PRD hash at review" row**. `tool/docs_check/alignment_record_freshness.py` exists specifically to detect a review record drifting from the document it measured, and requires *"at least one 64-hex candidate"* per record or it fails with *"anchor missing"*. The Stage 3 record supplies none | **Medium** | Architecture reviewer (myself) | **ACCEPTED and DISCLOSED.** Not repaired by editing the Stage 3 record, per the same no-in-place-edit doctrine invoked at §1.2. This Stage 4 record carries the hash `d4ca7e11…c175`, establishing the anchor from here forward. Whether the Stage 3 record requires a dated supplement is a matter for the Architecture reviewer role, and is raised rather than self-decided |

The freshness gate does not currently enumerate PRD-014, so this produces no red gate today. It is recorded
because the user's mandate is explicit: *"Do not silently hide or delete your own mistakes."*

### 8.6 Gate satisfied

| Requirement of the gate | Satisfied by |
|---|---|
| Conflicts **closed** | 0 conflicts exist to close |
| Conflicts **explicitly deferred** | **13** deferrals: 8 `ENT-GAP-*` + 3 coverage deferrals (`S4-D-04`…`06`) + 2 draft defects (`S4-F-01`, `S4-F-02`) |
| Every deferral has a **reason** | ✅ Stated for each, in §8.2, §8.4 |
| Every deferral has an **owner** | ✅ Named for each. `ENT-XC-005`'s *subject* owner is undetermined by `Q-06`; the **gap** owner (`ENT-GAP-003`, Architecture Owner) is named |
| Plus code contradictions | 6, deferred to Stage 8, owner Implementation lead, each mapped to a requirement |
| Plus own-work defects | 1 disclosed (`S4-F-03`) |

---

## 9. Rejected findings — recorded as rejected, with reasons

> `PRD_LIFECYCLE.md` L104: *"**A rejected finding must be recorded as rejected, with its reason.** … A review
> that records only accepted findings is indistinguishable from a review that found nothing."*

Written for Stage 3, but the principle governs any review. Twelve candidate findings were raised during this
review and rejected.

| ID | Candidate finding | Why rejected |
|---|---|---|
| `R4-01` | *"10 of 42 requirements carry no `SHALL`/`MUST`, so check 1 fails."* | The 10 are declarative-prohibitive or declarative-property constructions, each naming the observable that decides it (§2.1). An invariant stated as a property is the correct form for an invariant. This was a defect in the checker, recorded as `S4-C-01` |
| `R4-02` | *"`ENT-FR-001` and `ENT-FR-019` carry no citation, so their authority is unsourced."* | Both cite inline rather than in a trailing parenthetical: `ENT-FR-001` names *"BC Map **L383**"* twice in its own sentence; `ENT-FR-019` names `packages/liboora_contracts/lib/src/errors/domain_error.dart:22–23`. Checker defect, recorded as `S4-C-02` |
| `R4-03` | *"An empty `ENT-CFG-*` register violates check 3."* | Check 3 quantifies over configurables. Over an empty set the predicate holds vacuously. Filling the register would require inventing a default and a range for a value `Q-03` has not decided — prohibited (§4.1) |
| `R4-04` | *"`ENT-FR-018` invokes configuration but declares no configurable, which is the 'specification hole' check 3 names."* | The named failure is *unbounded configuration* — a knob with no stated default or range. `ENT-FR-018` declares no knob; it declares the **shape** of a decision and defers the value to a named High-severity gap. A disclosed hole with an owner is the opposite of an unbounded one |
| `R4-05` | *"`ENT-BR-003` restates `PRD-013`'s `TEN-FR-006`, creating two sources of truth."* | `TEN-FR-006` is cited as the *fact* that the two value-object sets are disjoint. `ENT-BR-003` obliges **this module's** conduct given that fact. Attribution names document, lines and FROZEN status (§6.1) |
| `R4-06` | *"`ENT-FR-028` restates `PRD-005`'s `MM-FR-014`."* | Cited as corroboration; the terminology rule's authority is BC Map **L211** at Rank 4, enforced by a CI lint. The obligation created is this module's use of `SeatQuota` (§6.2) |
| `R4-07` | *"`ENT-BR-007` goes beyond `MP-GBR-07`, which speaks only of emitted events, so it contradicts Rank 1 by scope."* | Strengthening is not contradiction. Rank 1 sets a floor; a stricter module rule cannot cause a Rank 1 violation. The failing direction is weakening (§7.5) |
| `R4-08` | *"Coverage of 94.4 % means check 4 fails; the gate should require 100 %."* | Check 4's named failure is the **orphan criterion** — the criterion→requirement direction, which is **0**. Reverse coverage is a quality measure the lifecycle does not gate on, and each of the 3 uncovered obligations cannot lawfully carry a criterion yet (§5.3) |
| `R4-09` | *"`ENT-FR-010`'s `MAY` makes it unverifiable."* | The `MAY` is bounded by *"only"* and subordinate to a `SHALL NOT` in the same sentence. The testable obligation is the prohibition (§2.3) |
| `R4-10` | *"`ENT-BR-008` asserts a grace period the platform has not defined — an invented business rule."* | It asserts no value. It constrains the shape — *"configured, never implicit"* — quoting BC Map **L467** verbatim, and points at `ENT-GAP-002` for the missing value. The numeric-literal scan confirms 0 hardcoded durations (§4.3) |
| `R4-11` | *"Fail Stage 4: 0 of 26 acceptance criteria are proven by a passing test."* | Stage 4 tests whether criteria are **written, testable and mapped**. Whether they pass is Stage 8. The draft discloses the zero itself, in §10's preamble and as `D-014-05`. Failing here would collapse specification review into implementation verification |
| `R4-12` | *"`ENT-XC-005`'s owner cell reads 'undetermined', so it fails check 2's owner requirement."* | `Q-06` is Open at Rank 4 (BC Map L545) and Rank 1 (`MASTER_PRD.md` L678). Naming an owner would be inventing an ownership decision. The row cites both Opens and the gap `ENT-GAP-003` names the **gap's** owner. Recording an undetermined owner as undetermined is correct conduct |

---

## 10. Defects in this review's own checkers — disclosed

Four mechanical results disagreed with the draft. Two were the draft's defects (§8.4). Two were mine.

| ID | Checker defect | How it manifested | Resolution |
|---|---|---|---|
| **`S4-C-01`** | The check-1 modality regex tested only for `SHALL`/`MUST`/`SHALL NOT`/`MUST NOT` | Reported 10 false failures — `ENT-BR-001`, `004`, `005`, `007`, `008`, `ENT-INV-001`, `002`, `003`, `004`, `006` | Broadened to accept declarative-prohibitive and declarative-property constructions, then **all 10 were read individually** (§2.1) rather than being cleared by the widened regex alone. Final: 0 failures |
| **`S4-C-02`** | The check-1 citation regex required a trailing `*(`…`)*` parenthetical | Reported `ENT-FR-001` and `ENT-FR-019` as uncited, when both cite inline | Verified by reading both requirements in full. Final: 0 uncited (§9 `R4-02`) |

Both are recorded because a review that reports only the target's defects and not its instruments' is not
measuring its own reliability. The first version of the modality checker would have produced a **false FAIL of
check 1** — the most consequential possible error in this stage — and it was caught by investigating the
disagreement instead of accepting it.

Note also that a bare `grep 'INV-'` over this draft would over-count: `INV-1`…`INV-16` are **platform
invariants** registered at `TRACEABILITY_MATRIX.md` L82, and `INV-SEC-*` / `INV-XC-*` also exist. Every scan in
this review used anchored patterns (`\bENT-INV-`). The draft registers this hazard itself, at §0.4.

---

## 11. Containment audit

| Boundary | Commands run | Result |
|---|---|---|
| `lib/**` | 0 writes | ✅ untouched |
| `packages/**` | 0 writes | ✅ untouched |
| `test/**` | 0 writes | ✅ untouched |
| `tool/**` | 0 writes — `alignment_record_freshness.py` and `prd016_traceability.py` read only | ✅ untouched. No `prd014_*.py` checker written; that is Stage 5/6 work |
| `PRD-014_ENTITLEMENT.md` | 0 writes — hash `d4ca7e11…c175` identical before and after | ✅ unmodified, per §1.2 |
| `PRD-014_STAGE1_DISCOVERY.md` · `PRD-014_ARCHITECTURE_ALIGNMENT.md` | 0 writes | ✅ unmodified — including the record carrying defect `S4-F-03` |
| Rank 1–5 documents | 0 writes | ✅ untouched |
| `TRACEABILITY_MATRIX.md` | 0 writes | ✅ untouched — Stage 5 |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `ADR-INDEX.md` | 0 writes | ✅ untouched — Stage 7 |
| Any ADR | 0 created | ✅ none — `ADR-0052` is Stage 7 work and must come **first** in that stage, per `DOCUMENTATION_BASELINE.md` §7 rule 1 |
| Registry status | not changed | ✅ `PRD-014` remains `PLANNED` at `PRD_REGISTRY.md` L304. Stage 4 confers no status; the registry moves at Stage 5 (`APPROVED`) and Stage 7 (`FROZEN`) |
| Stage 8 | not entered | ✅ |
| Git | 0 commits, 0 pushes, 0 ZIPs by this review | ✅ |

**Files created by this review: one** — this record.

---

## 12. Verdict

### 12.1 The six checks

| # | Check | Verdict | Evidence |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | 42/42 testable · 32 prescriptive + 10 declarative, all 10 read individually · 0 vague adjectives · 0 unverifiable hedges · 1 bounded `MAY` · 1 disclosed precondition deferred |
| 2 | Every exclusion states what must be **impossible** | ✅ **PASS** | 12/12 carry an impossibility modality · 0 deferral constructions · 11/12 name an owner; the 12th's owner is discoverable from its own citation — `S4-F-01` |
| 3 | Every configurable has a default and a range | ✅ **PASS** | 0 configurables ⇒ vacuously satisfied · emptiness justified against 4 measured authorities · 0 hardcoded durations, counts or percentages in 42 requirements |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** | **0 orphan criteria** — the named failure · 26 criteria, 0 empty `Proves`, 0 undefined references, 0 duplicate ids · reverse coverage 94.4 % independently recomputed and matching §10.1 exactly |
| 5 | No requirement restates another PRD's | ✅ **PASS** | 2 foreign citations in 42, both attributed with document/line/status · 0 obligations authored here on another context's subject · the highest-risk restatement explicitly refused in requirement text · 10-row register audited, 0 leakage |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | 8/8 consistent · 2 directly implement `MP-GBR-24` and `MP-GBR-06`/`07` · 1 deliberately stronger than Rank 1 · 0 permissive-mutation constructions · 0 hazard-term trespass across 4 closed Rank 1 subjects |

### 12.2 Verdict

✅ **STAGE 4 — PASS, 6 of 6 checks.**

The gate — *"conflicts closed or explicitly deferred with a reason and an owner"* — is satisfied by §8: **0
conflicts**, **13 explicit deferrals** each with a reason and a named owner, plus 6 code contradictions deferred
to Stage 8 with the requirement each will be built against.

### 12.3 What this record does **not** do

| It does not | Because |
|---|---|
| Confer any registry status | Stage 4 has no registry transition of its own. `PRD-014` remains `PLANNED` until Stage 5 (`APPROVED`) and `FROZEN` only at Stage 7, and only *"through the repository's actual baseline/governance mechanism"* |
| Edit the PRD to fix `S4-F-01` or `S4-F-02` | §1.2 — *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded"* |
| Resolve `ENT-GAP-001`…`008` | Each needs an ADR or an owner's decision. All eight remain **OPEN** |
| Adjudicate `A-02` (BC Map L383 vs Matrix L70) or `A-08` (whether `BZ-1` binds seed paths) | Both were left undetermined at Stage 3 by design. Stage 4 does not overturn that; a requirements review that silently settled a Rank 4 tension would be making an architecture decision without an ADR |
| Repair any code contradiction | Stage 8 |
| Register any identifier | Stage 5. **No `ENT-` prefix is registered in `TRACEABILITY_MATRIX.md` as of this record** |
| Allocate `IMPL-*` | Stage 6 |
| Claim that any acceptance criterion passes | 0 of 26 are proven by a test today (`D-014-05`). These are criteria, not results |
| Close `PGA-08` | No named holder exists for the Requirements-reviewer role. This review was performed by the same agent that authored the draft — a self-review, which the lifecycle's own words caution against: *"A green gate signed by the author of the thing being gated is not a gate."* Recorded here so the limitation travels with the verdict |

### 12.4 Stage 5 readiness

| Prerequisite | State |
|---|---|
| Stage 1 gate artefact | ✅ `PRD-014_STAGE1_DISCOVERY.md`, PASS |
| Stage 2 gate artefact | ✅ `PRD-014_ENTITLEMENT.md` v0.1 `DRAFT`, 88 identifiers in 8 registers declared up front with contiguous ranges |
| Stage 3 gate artefact | ✅ `PRD-014_ARCHITECTURE_ALIGNMENT.md`, CONDITIONAL PASS — carries defect `S4-F-03` |
| Stage 4 gate artefact | ✅ this record |
| `ENT-` prefix collision-free | ✅ anchored scan returned **0** before the prefix was chosen; to be **re-verified mechanically** at Stage 5 as the gate requires |
| Registers contiguous from `001` | ✅ verified at Stage 2 for all 6 populated registers |
| Blocking issue for Stage 5 | **None.** The two draft defects are Low and deferred; neither affects an identifier, a range or a count |

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-19 | Initial Stage 4 requirements review of `PRD-014_ENTITLEMENT.md` v0.1 at hash `d4ca7e11…c175`, repository `834fa52`. All six checks from `PRD_LIFECYCLE.md` L110–118 executed, five mechanically. Verdict **PASS 6/6**. **13 explicit deferrals** each with a reason and an owner; 6 code contradictions deferred to Stage 8. **2 genuine defects found in the draft** (`S4-F-01` owner cell omitted from `ENT-XC-012`; `S4-F-02` `ENT-FR-017`/`ENT-FR-022` overlap at Jaccard 0.438) — both **deferred rather than edited**, per the no-in-place-edit doctrine. **1 defect disclosed in this reviewer's own Stage 3 record** (`S4-F-03`, missing PRD-hash row). **2 defects disclosed in this review's own checkers** (`S4-C-01`, `S4-C-02`), the first of which would have produced a false FAIL of check 1. **12 candidate findings rejected with reasons.** No PRD, ranked document, registry, baseline, matrix, ADR or implementation file modified |
