# ADR-0078 — The community scope identifier carries **no `tenantId`**: BC Map L450's tenant-safety rule is scoped by `ID-2`/`ID-3`, not in conflict with L488

| Field | Value |
|---|---|
| **Status** | **Accepted** — 2026-08-25 |
| **Date** | 2026-08-25 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in `PRD_OWNERSHIP_MODEL.md` §2.2 and §2.3 (L85, L102) — the role L284 records as the only approving body for a Rank 1–5 change. Authority **expressly conferred for this one decision**; `ADR-0033` §7.1 — not a standing licence over the Bounded Context Map |
| **Supersedes** | — |
| **Amends** | ⛔ **NOTHING.** This is an **interpretive ruling**, not an amendment. The Bounded Context Map is **byte-unchanged**: no rule edited, no row added, no event registered, no edge minted, no tenancy mode changed. §6 explains why no amendment is required and why making one would have been the error |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue** — and, unusually, **no document version moves at all**, because no document is amended. `DOCUMENTATION_BASELINE.md` §7 steps 2–4 are not engaged; step 1 is honoured by this ADR existing before any dependent part relies on the ruling |
| **Closes** | **`LCR-GAP-009`** (A3 §23) and its A2 antecedents **Conflicts 5 and 6** — the question *"does the community scope identifier carry a `tenantId`?"* |
| **Does NOT close** | `LCF-GAP-009` / `LCR-DEC-007` (the missing BC Map §8 aggregate rows for `BC-15` — a **registration** act this ADR expressly does not perform), `LCR-FND-001`…`006` (the unregistered `BC-15 → BC-11` edge), `LCF-GAP-001`, `004`–`008`, `010`, `011`, `LCR-GAP-001`, `002`, `004`, `006`, `007`, `008`, `010`, or any acceptance criterion. Confers **no** readiness and **no** freeze |
| **Related** | BC Map **L179** (`ID-2`), **L180** (`ID-3`), **L119** (`BC-15`), **L424–428** (`BC-10` `identity.*` events — the decisive existing pattern), **L444–451** (event envelope), **L450** (tenant safety), **L487**, **L488** (§11 tenancy table) · **`ADR-0011`** (`BC-10` global identity; L99, L125, L192 — enforced by `banned_symbols`) · `MASTER_PRD.md` **L519** (`MP-CON-08`) · A2 Conflicts 5 and 6 · A3 `LCR-GAP-009`, §23 · `PRD-021A_OWNER_DECISION_REQUEST.md` §6 |

> ✅ **ACCEPTED 2026-08-25.**
>
> ⭐ **This ADR rules that the "conflict" is not one.** BC Map **L450** and **L488** were read as two
> Rank 4 rules contradicting each other, which made the question **structurally unarbitrable** —
> `MP-CON-08` cannot adjudicate between two sources of equal rank. §2.2 shows, from a **third**
> measurement neither prior analysis had made, that L450 is **already scoped** by `ID-2`/`ID-3` and
> that the repository has been operating the resulting reading in five registered events since
> `ADR-0011`. **The ruling reconciles an accepted pattern; it does not choose between rules.**

---

## 1. Context

### 1.1 The apparent conflict

`PRD-021A` A3 §23 records `LCR-GAP-009`: *"Whether the community scope identifier carries a
`tenantId` is unresolved. Inherited from A2 Conflicts 5 and 6 (BC Map **L450** vs **L488**)."*

The two cited lines, measured verbatim:

| Line | Text |
|---|---|
| **L450** | **Tenant safety** — *"`tenantId` is mandatory on every domain event. A consumer that processes an event without establishing tenant context must fail loudly, not default."* |
| **L488** | **BC-11→17 Student Network** — *"**Global.** No `tenantId`. Keyed on `PersonId`. \| Must never receive a `StudentRecordId` or `tenantId` (rule `ID-2`)."* |

`BC-15` is in the `BC-11→17` band (BC Map **L119**), so L488 governs it. A2 publishes
`LCF-EVT-001`…`006`, so L450 appears to govern them. **L450 mandates a field L488 forbids.**

### 1.2 Why prior analysis stopped, and was right to

`PRD-021A_OWNER_DECISION_REQUEST.md` §6 recorded this as **structurally unarbitrable**: both lines
sit in the **same document at Rank 4**, so `MP-CON-08`'s *"the higher-ranked document wins"* has no
purchase — there is no higher rank to appeal to. With no third measurement available, any choice
would have been a preference dressed as a ruling. **The refusal was correct.** What follows is the
third measurement.

---

## 2. Decision

### 2.1 The ruling

**The community scope identifier carries NO `tenantId`.** `BC-15`'s aggregates key exclusively on
`PersonId` and on `BC-15`-owned community identifiers, and `BC-15`'s domain events —
`LCF-EVT-001`…`006` — are published **without** a `tenantId`, in the **Global** envelope shape
`BC-10` already uses.

**BC Map L450 is scoped, not universal.** Its *"every domain event"* means every event **from a
tenant-scoped or tenant-aware context** — the `BC-01→09` and `BC-19→31` bands. It does **not**
reach the **Global** bands, because `ID-2` forbids `tenantId` from ever appearing there.

### 2.2 ⭐ The decisive measurement — the pattern is already registered and accepted

Neither prior analysis measured **BC Map §9, L424–428**. Five registered domain events:

| BC Map line | Event | Producer |
|---|---|---|
| **L424** | `identity.PersonIdentityCreated` | `BC-10` |
| **L425** | `identity.PersonProfileUpdated` | `BC-10` |
| **L426** | `identity.PersonUsernameChanged` | `BC-10` |
| **L427** | `identity.PersonPrivacyModeChanged` | `BC-10` |
| **L428** | `identity.PersonAnonymised` | `BC-10` |

And `BC-10`'s own tenancy row, BC Map **L487**:

> *"BC-10 Global Person Identity — **Global. No `tenantId`.** Keyed on `PersonId`. Rank 7.5. \| Must
> **never receive** a `StudentRecordId` or `tenantId` (rule `ID-2`). … Asserted by cross-tenant leak
> tests + **`banned_symbols`**."*

⭐ **Therefore: the Bounded Context Map itself registers five domain events from a context it
forbids from ever holding a `tenantId`.** If L450 were universal, the BC Map would be in breach of
itself at five of its own rows — and `ADR-0011` (**Accepted**) would be enforcing that breach in
CI, since its L99/L125/L192 record that `BC-10` stores *"**no** `StudentRecordId` and **no**
`tenantId`"* and that this is asserted by a **`banned_symbols`** check.

A reading that convicts an Accepted ADR, five registered event rows and a passing CI gate of
error — while a reading that convicts nothing is available — is the wrong reading. **The
non-universal reading of L450 is the one the repository has been operating since `ADR-0011`.**

### 2.3 Why this is interpretation and not a new choice

Three independent rules already force the outcome, and all three pre-date this ADR:

| Rule | BC Map line | Statement | Effect on `BC-15` |
|---|---|---|---|
| **`ID-2`** | **179** | *"`StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, **event** or index."* | The word **event** is in the rule. `ID-2` already legislates about Global-context events |
| **`ID-3`** | **180** | *"Global and social contexts (BC-10→17) **key exclusively on `PersonId`**. They must not be able to resolve which library a person attends unless the person explicitly published it."* | `BC-15` is in `BC-10→17`. A `tenantId` on a community event **is** a resolution of which library — the exact capability `ID-3` forbids |
| **§11 L488** | **488** | `BC-11→17` — *"**Global.** No `tenantId`."* | Direct, by band membership (L119) |

⭐ **`ID-3` is the sharpest of the three, and it converts the question from a tie into a
prohibition.** Stamping a `tenantId` onto a community event would let any consumer resolve which
library a member attends — from a Global Student surface, without the member publishing it. That is
not a tenancy-convention preference; it is the **privacy leak `ID-3` exists to prevent**, on a
population `SM-INV-3` records as minor-inclusive.

So L450 could not be applied to `BC-15` even if it were universal: doing so would breach `ID-2`,
`ID-3` and L488 simultaneously to satisfy one clause of one envelope row.

### 2.4 What L450 **does** still require of `BC-15`

⛔ **The ruling is narrow. L450's *purpose* is preserved in full.** Its second sentence — *"A
consumer that processes an event without establishing tenant context must fail loudly, not
default"* — remains binding wherever it can apply:

| Requirement | Status under this ruling |
|---|---|
| A **tenant-scoped or tenant-aware** consumer (`BC-01→09`, `BC-19→31`) receiving a `BC-15` event | **MUST NOT** synthesise, infer or default a tenant context from it. It has none to establish, so it must **fail loudly** — exactly L450's disposition |
| A `BC-15` event carrying a `StudentRecordId` | ⛔ **Forbidden** — `ID-2`. Unchanged |
| A `BC-15` event enabling library-attendance resolution | ⛔ **Forbidden** — `ID-3`. Unchanged |
| Every other envelope field at L448 (`eventId`, `eventType`, `schemaVersion`, `occurredAt`, `actorId`, `correlationId`, `causationId`, `aggregateId`, `payload`) | **MANDATORY** and unchanged. Only `tenantId` is absent, and only because a higher-specificity rule forbids it |
| Outbox atomicity (L446), idempotency (L447), per-aggregate ordering (L448), schema evolution (L450), DLQ (L451) | **All unchanged and binding** |

**No safety property is weakened.** The fail-loud obligation is *strengthened* into an explicit
prohibition on defaulting.

### 2.5 What is **not** decided

| Not decided | Why |
|---|---|
| Registration of `BC-15`'s aggregates in BC Map §8 | ⛔ **`LCF-GAP-009` / `LCR-DEC-007` stay OPEN.** That is a Rank 4 **amendment**; this is an interpretation. Bundling them would use an interpretive ruling to perform a registration |
| Registration of `LCF-EVT-001`…`006` in BC Map §9 | Same reason. **Not performed** |
| The `BC-15 → BC-11` edge | `LCR-FND-001`…`006` stay OPEN. BC Map **L292** governs, and no edge is minted |
| Whether L450's wording should be clarified in the BC Map | ⚠ Raised in §4.2 as a **disclosed** clarity defect. **Deliberately not repaired** — see §6 |
| Readiness or freeze | Not conferred — §5.2 |

---

## 3. Alternatives considered and rejected

| # | Option | Rejected because |
|---|---|---|
| 1 | **`tenantId` IS carried, applying L450 literally** | Breaches `ID-2` (L179), `ID-3` (L180) and §11 L488 at once; contradicts `ADR-0011` (**Accepted**, CI-enforced); and would convict the BC Map's own L424–428 rows of error. It also creates the precise attendance-resolution leak `ID-3` forbids, over a minor-inclusive population |
| 2 | **Carry a nullable `tenantId`, null for Global contexts** | `ID-2` says the field *"must not appear"* in a Global Student event — appearing-as-null is still appearing, and `banned_symbols` (`ADR-0011` L192) is a **symbol** check, not a value check. It also re-introduces the defaulting hazard L450 exists to prevent |
| 3 | **Amend BC Map L450 to say "every tenant-scoped domain event"** | ⛔ Refused. It is the *substantively* attractive option and the *procedurally* wrong one: amending a Rank 4 rule to record an interpretation would let a `PRD-021A` blocker rewrite a platform-wide rule that governs 31 contexts. **§6 states the correct route** |
| 4 | **Declare it unarbitrable and carry the gap** | The honest posture **before** the L424–428 measurement, and what the Owner Decision Request §6 correctly recorded. After the measurement the question is answerable without choosing between rules |
| 5 | **Route to `MP-CON-08` precedence** | Cannot work — both lines are the same document at the same rank. `MP-CON-08` arbitrates **between** ranks. This is why a third measurement, not an appeal, was needed |
| 6 | **Mint a `BC-15`-specific tenancy exception** | Inventing a rule to answer a question three existing rules already answer |

---

## 4. Consequences

### 4.1 Positive

- `LCR-GAP-009` closes — the last of A2's inherited tenancy conflicts — without amending any Rank 4
  document, minting anything, or weakening a safety rule.
- `BC-15`'s events gain a **published, precedented** envelope shape: the one `BC-10` has used across
  five registered events since `ADR-0011`.
- `ID-3`'s attendance-resolution protection is stated explicitly for community surfaces, where it
  was previously only implied by band membership.

### 4.2 ⚠ Disclosed, not repaired — L450's wording is genuinely unclear

**BC Map L450 says *"every domain event"* and means *"every tenant-scoped or tenant-aware domain
event."*** Two competent prior analyses read it as universal and concluded the map contradicted
itself. That is a **real clarity defect at Rank 4**, and it is **not repaired here** (§3 option 3).

⭐ **This is raised as a defect, not settled by edit** — the disposition `MP-CON-08` prescribes:
*"A disagreement is a defect to be raised, not a choice to be made."* Routed to the **Architecture
Owner** for a clarifying amendment on the BC Map's own schedule, with its own ADR, on evidence
spanning all 31 contexts rather than one `PRD-021A` blocker. See §6.

### 4.3 Negative / accepted costs

- ⚠ The ruling is **interpretive**: a reader of BC Map L450 alone will still read it as universal.
  Until §4.2 is repaired, the correct reading requires L450 **plus** L179, L180, L487, L488 and
  L424–428. That cost is accepted rather than paid for by editing a platform-wide rule.
- ⚠ `BC-15`'s events remain **unregistered** in BC Map §9 (§2.5). This ADR rules on their *shape*,
  not their *existence*.

### 4.4 Neutral

- No code, test, manifest or gate is affected. `banned_symbols` already enforces the ruled outcome
  for `BC-10`, and no `BC-15` code exists.

---

## 5. Scope limits

### 5.1 Closed

| Item | Basis |
|---|---|
| **`LCR-GAP-009`** (A3 §23) | §2.1 — no `tenantId` |
| A2 **Conflicts 5 and 6** | Same question, upstream form |

### 5.2 ⛔ No readiness, no freeze

`PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** gates `PRD-021` behind `PRD-020`, which is
unranked `DRAFT`. A2 and A3 remain **NOT READY — NOT FROZEN**.

---

## 6. Why no document is amended — and what the correct route is

`DOCUMENTATION_BASELINE.md` §7 step 1 requires *"an ADR **before** the change"*. This ADR makes
**no change**, and that is deliberate:

| Consideration | Reasoning |
|---|---|
| **The rules already say it** | `ID-2`, `ID-3` and L488 already produce the outcome. Adding a rule would duplicate three |
| **The pattern is already registered** | L424–428 already publish five Global-context events. This ADR records that `BC-15` follows an existing shape |
| **Blast radius** | Editing L450 touches a rule governing **all 31 contexts** and **every** event row. That edit deserves its own evidence base and its own ADR, not a side effect of a social-graph draft |
| **The correct route** | §4.2's clarity defect is routed to the **Architecture Owner** as a standalone BC Map amendment. This ADR is cited as evidence that the ambiguity is load-bearing, having twice produced a false conflict verdict |

⛔ **A2 and A3 may cite this ADR for the envelope shape. Neither may cite it as authority to
register an event, an aggregate or an edge** — §2.5.

---

## 7. Compliance record

| Check | Result |
|---|---|
| Rank 4 rule chosen over another Rank 4 rule? | ✅ **No** — §2.2/§2.3 show L450 is **scoped** by `ID-2`/`ID-3`, so no tie was broken |
| Any document amended? | ✅ **No** — the BC Map is **byte-unchanged**. No rule, row, event, edge or tenancy mode touched |
| Safety property weakened? | ✅ **No** — §2.4. L450's fail-loud disposition is preserved and **strengthened** into an explicit no-defaulting prohibition |
| Aggregate, event, edge, permission or configurable minted? | ✅ No — `LCF-GAP-009` / `LCR-DEC-007` / `LCR-FND-001`…`006` left **OPEN** |
| Accepted ADR contradicted? | ✅ **No** — `ADR-0011` is the ruling's principal support; its text is byte-unchanged |
| Frozen artefact touched? | ✅ No |
| Baseline identifier advanced? | ✅ No — nothing amended |
| Pre-existing defect search performed? | ✅ Performed, **did NOT return empty** — L450's ambiguity (§4.2). **Disclosed and routed, not repaired** |
| Readiness / freeze claimed? | ✅ **No** — §5.2 |
