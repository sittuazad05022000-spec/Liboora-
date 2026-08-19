# `PRD-016` Audit Trail v0.1 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–118) |
| **Subject** | [`PRD-016_AUDIT_TRAIL.md`](PRD-016_AUDIT_TRAIL.md) — `PRD-016`, `BC-24` Audit Trail, **v0.1 `DRAFT`** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Gate satisfied by** | This document — §8 closes 0 conflicts because none exists, and defers **5** items each with a reason **and** a named owner |
| **Predecessors** | [Stage 1 Discovery](PRD-016_STAGE1_DISCOVERY.md) ✅ · [Stage 3 Alignment](PRD-016_ARCHITECTURE_ALIGNMENT.md) ✅ **6/6 PASS** |
| **Reviewed at** | `4bd728d` |
| **PRD hash at review** | `281f15e8de65dde8c8b5a5e8edda71f8e34eff07c7abc411698fbfc0f6f339be` — verified identical before and after |
| **Date** | 2026-08-19 |
| **Mandate** | **Stage 4 only.** No PRD modified, no ADR created, no identifier registered in any matrix, no ranked document touched, no registry or baseline update, no traceability checker, no freeze. **No implementation code modified.** Stages 5–7 not started, Stage 8 not entered |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** 0 conflicts · 5 explicit deferrals, each with a reason and an owner · 1 measurement discrepancy raised against the draft and **resolved in the draft's favour** (§5.2) · 4 candidate findings rejected (§9) |

---

## 1. Method

Stage 4 differs from Stage 3 in what it tests. Stage 3 asks *"is this PRD lawful against Ranks 1–5?"* Stage 4 asks
*"is this PRD **buildable and verifiable** as written?"* Its six checks are internal-quality checks, and five of the
six are **mechanically decidable** — so each was decided by a script over the document text, not by reading.

Where a mechanical result disagreed with the document's own claim, the disagreement was investigated to root cause
before either was believed. That happened once, at check 4, and **the document was right** (§5.2).

### 1.1 The six checks and how each was decided

| # | Check | Failure mode named by the lifecycle | Decided by |
|---|---|---|---|
| 1 | Every requirement testable | *"'The system should be fast' — unverifiable"* | Script — normative verb per requirement + vague-language scan |
| 2 | Every exclusion states what must be **impossible** | *"An exclusion is not a deferral"* | Script — prohibition/impossibility per `AUD-XC-*` row + owner cell |
| 3 | Every configurable has a default and a range | *"Unbounded configuration is a specification hole"* | Script — `AUD-CFG-*` count + duration-literal scan |
| 4 | Every acceptance criterion maps to a requirement | *"Orphan criterion"* | Script — forward and **reverse** coverage with range expansion |
| 5 | No requirement restates another PRD's | *"Two sources of truth"* | Script + reading — foreign-identifier census, then §0.5 audit |
| 6 | Business rules do not contradict Rank 1 | *"Rank 1 wins; the PRD is wrong"* | Script — permissive-mutation scan + Rank 1 citation census |

---

## 2. Check 1 — Every requirement is testable

### 2.1 Normative verb present in every requirement

The document declares its normative language in §0.1. Every obligation-bearing requirement was extracted and tested
for a `MUST` / `MUST NOT` / `SHALL` / `SHALL NOT`:

```
requirements found (AUD-FR-*, AUD-BR-*, AUD-INV-*) : 23
without a normative verb                            : NONE ✅
```

23 = 16 `AUD-FR-*` + 3 `AUD-BR-*` + 4 `AUD-INV-*`, matching §0.2's declared counts exactly.

### 2.2 Vague-language scan

Ten unverifiable constructions were searched for, including the lifecycle's own example:

```
'should be fast', 'as needed', 'appropriate', 'reasonable', 'efficient',
'user-friendly', 'robust', 'as soon as possible', 'etc.', 'and so on'
                                                    → 0 occurrences of any ✅
```

### 2.3 The three requirements whose testability is least obvious were read individually

A verb and the absence of vague words are necessary, not sufficient. Three requirements make claims about **absence**,
which is the hardest thing to test, so each was checked for a stated observation point:

| Requirement | Why testability could be doubted | The observation it names |
|---|---|---|
| `AUD-INV-001` — immutable, *"no update, delete, purge or modify path exists in code"* | *"No path exists"* is a universal negative | Names the enforcement mechanism: manifest `banned_method_names: ["update*","delete*","purge*","modify*"]`. `AUD-AC-001` makes it a checker run — *"adding one fails the boundary checker"*. **Decidable by tooling** |
| `AUD-FR-009` — unavailability *"MUST NOT fail or delay the emitting operation"* | Depends on a component being **down** | `AUD-AC-014` states the experiment: *"With the audit module unavailable, the emitting operation still completes and its outbox row is written"*. **Decidable by fault injection** |
| `AUD-FR-016` — no read surface spanning tenants | Requires enumerating surfaces | `AUD-AC-009`: *"No method on the module returns a value derived from more than one tenant's entries — including counts, totals and 'recent' listings"*. **Decidable by inspecting the public API**, and already measured against real code as `D-016-01` |

Each is testable because the draft supplies the observation point, not merely the obligation.

### 2.4 Result

✅ **PASS.** 23 of 23 requirements carry a normative verb. Zero vague constructions. The three universal-negative
requirements each name a decidable observation.

---

## 3. Check 2 — Every exclusion states what must be impossible

> *"An exclusion is not a deferral."*

### 3.1 Mechanical result

```
AUD-XC-* rows                                       : 12
rows without a prohibition or impossibility clause  : NONE ✅
rows with an empty owner cell                       : NONE ✅
```

Every row carries `MUST NOT` or the word *impossible*. `AUD-XC-002` and `AUD-XC-003` use the strongest form — *"No
role … MUST be able to"* and *"Cross-tenant reach MUST be impossible"* — which state impossibility directly rather
than merely forbidding an action.

### 3.2 Owner column — every exclusion says where the subject went

The lifecycle's failure mode is an exclusion that *defers* rather than *excludes*: "we are not doing X" with no
statement of who is. All 12 rows resolve:

| Owner cell | Rows | Meaning |
|---|---|---|
| **`BC-18`** | `AUD-XC-004`, `AUD-XC-005` | Credentials and authorisation decisions |
| **`BC-19`** / `PRD-013` | `AUD-XC-006` | Tenant aggregate and context propagation |
| **`BC-21`** | `AUD-XC-007` | Entitlement |
| **`BC-20`** | `AUD-XC-008` | Subscription and billing |
| **`BC-26`** | `AUD-XC-009` | Projections, certified metrics, read models |
| **`BC-22`** | `AUD-XC-010` | Notification channels and delivery |
| **each emitting context** | `AUD-XC-011` | The auditable-action list |
| **`—`** (deliberate) | `AUD-XC-001`, `AUD-XC-002`, `AUD-XC-003`, `AUD-XC-012` | **Universal prohibitions.** No other context may do these either, so there is no owner to name — the em dash is a statement, not a blank |

The four em-dash rows were checked individually rather than accepted as empty. Each is a capability that exists
**nowhere** in the system: mutating an audit entry (`AUD-XC-001`), overriding immutability by role (`AUD-XC-002`),
reaching across tenants (`AUD-XC-003`), and deleting to satisfy erasure (`AUD-XC-012`). Naming an owner would falsely
imply the capability exists somewhere. **This is the correct use of `—`, not a missing cell.**

### 3.3 Result

✅ **PASS.** 12 of 12 exclusions state what must be impossible. 8 name a receiving owner; the 4 that do not are
universal prohibitions where naming one would be wrong.

---

## 4. Check 3 — Every configurable has a default and a range

> *"Unbounded configuration is a specification hole."*

### 4.1 The check is satisfied by the register being empty

```
AUD-CFG-* identifiers issued          : 0
duration literals in the document     : NONE ✅   (0 days / months / years / hours / minutes / seconds)
```

This check cannot fail on an empty register: with zero configurables there is no configurable lacking a default or a
bound. The substantive question is therefore the inverse one — **is the register empty because the work was skipped?**

### 4.2 The register is empty because no authority supplies a bound, and that is recorded

`PRD-016` §0.3 states the reasoning and it was verified at source:

- Rank 7 `CONFIGURATION_GUIDE.md` defines `CFG-1`…`CFG-12` only, all SMS/session/device/lock/account values.
  `CFG-9` is *"Pending-verification retention before discard"* and `CFG-10` is *"Soft-deleted account retention
  before permanent erasure"* — **account** retention, not audit. **No audit, retention or legal-hold parameter
  exists at any rank.**
- `MP-NFR-10` (Rank 1) assigns retention and legal hold to **SECURITY + DATA Governance**.
- `Q-04` (Rank 1) records the retention period as *"Open — needs counsel."*

Issuing an `AUD-CFG-*` identifier with an invented default would have created exactly the *"specification hole"* this
check exists to catch — an apparently-bounded parameter whose bound has no authority behind it. Declining to issue one
and recording `AUD-GAP-001` instead is the compliant outcome.

### 4.3 The draft improves on the `PRD-013` precedent, deliberately

`PRD-013` issued `TEN-CFG-001` and then **retired** it. `PRD-016` never issues one. The draft's stated reason is
sound: a retired identifier is permanently unusable under the never-reuse rule, so burning a number to record an
absence is waste. The absence is instead recorded in prose in §0.3 **and** as a numbered gap (`AUD-GAP-001`), so it
remains visible to a future author without consuming a register slot.

### 4.4 Result

✅ **PASS.** Zero configurables issued, zero duration literals, and the emptiness is justified against three
authorities rather than assumed. `AUD-GAP-001` carries the open question with a named owner.

---

## 5. Check 4 — Every acceptance criterion maps to a requirement

> *"Orphan criterion."*

### 5.1 Forward coverage — no orphans

```
AUD-AC-* rows                                   : 18
criteria with no traces-to identifier           : NONE ✅
```

Every one of the 18 criteria carries a `Traces to` cell naming at least one `AUD-FR-*`, `AUD-BR-*`, `AUD-INV-*` or
`AUD-XC-*`. **Zero orphans.**

### 5.2 Reverse coverage, and a measurement discrepancy that had to be resolved

The lifecycle requires forward coverage only. Reverse coverage — which requirements carry **no** criterion — was
measured anyway, because it is where an untestable requirement hides. The draft's §9 claims **8** such identifiers.

**The first mechanical run disagreed, reporting 11.** The three extra were `AUD-XC-006`, `AUD-XC-007` and
`AUD-XC-008`. Rather than believe the script or the document, the cause was traced:

`AUD-AC-017`'s traces cell reads `` `AUD-FR-013`, `AUD-XC-005`…`008` `` — an **ellipsis range**, not a token list. The
first script matched literal identifier tokens only, so it saw `AUD-XC-005` and `AUD-XC-008` but not the two members
of the range between them. The script was wrong; the document was right. Re-running with range expansion:

```
Class A total       : 35
covered by an AC    : 27
uncovered           : 8
uncovered list      : AUD-FR-001, AUD-FR-002, AUD-FR-003, AUD-FR-004,
                      AUD-FR-010, AUD-FR-011, AUD-XC-009, AUD-XC-011
draft §9 claims     : (identical 8)
MATCH               : ✅ EXACT
```

**This is recorded rather than quietly corrected because it is a finding about mechanical verification itself.**
A gate script written for Stage 5 that does not expand ellipsis ranges will produce false coverage and collision
figures on this document — as this review's own first script did. Carried forward as `S4-D-01` (§8.4).

### 5.3 The 8 uncovered identifiers were each checked for whether a criterion is *owed*

| Identifier | Subject | Why no behavioural criterion |
|---|---|---|
| `AUD-FR-001` | Owns `AuditEntry`, and no other aggregate | A scope statement. Its violation is *the presence of a second aggregate root* — structural, covered by `AUD-AC-017`'s type-absence check |
| `AUD-FR-002` | Owns storage, retention execution, query | A scope statement, and one **vacated by** `AUTH-10.26`. There is no runtime behaviour to observe in an ownership grant |
| `AUD-FR-003` | Does not decide what is auditable elsewhere | A scope statement. Its exclusion form `AUD-XC-011` is also uncovered, for the same reason |
| `AUD-FR-004` | `AuditEntry` is the only aggregate root, 4 value objects | Structural. Adding a fifth value object requires an ADR — a governance event, not a test |
| `AUD-FR-010` | Consumes via `E-20` only | Structural: the presence of a second inbound edge. `AUD-AC-017` checks the import surface |
| `AUD-FR-011` | Sole consumer of Class A facts | Enforced by manifest `AU-2` (manifest) / `ID-3` — a **boundary-checker** assertion. A second subscriber is a build failure, not a test failure |
| `AUD-XC-009` | No projection, metric or read model | Type-absence. Covered structurally by `AUD-AC-017` |
| `AUD-XC-011` | Does not decide another context's action list | The exclusion form of `AUD-FR-003` |

All eight are **scope, ownership or structural** statements whose violation is observable as *the presence of a type,
an aggregate or a subscription* rather than as a runtime behaviour. `AUD-AC-017` is the structural criterion that
covers them collectively, and the draft says so. This is the treatment `PRD-013` gave `TEN-FR-001`…`009`, so the
precedent is established rather than invented here.

**No synthetic criterion was demanded.** A criterion of the form *"the module owns `AuditEntry`"* would be
unfalsifiable and would inflate the count without adding verification — the orphan problem inverted.

### 5.4 Result

✅ **PASS.** 18 of 18 criteria trace to a real requirement; **zero orphans**. Reverse coverage measured at 8 uncovered
Class A identifiers, **exactly matching the draft's own claim** once ellipsis ranges are expanded. Each of the 8 is a
structural statement covered by `AUD-AC-017`.

---

## 6. Check 5 — No requirement restates another PRD's

> *"Two sources of truth."*

### 6.1 Census of foreign authority

```
distinct foreign identifiers cited : 32
total citations                    : 88
citation verbs present             : 18 occurrences of cite/cites/consumes/verbatim/as declared/states
```

A document with 88 citations to 32 foreign identifiers is either scrupulously derivative or systematically
duplicative. The distinguishing test is whether each citation **points at** the foreign definition or **reproduces**
it as a local obligation.

### 6.2 The nine highest-risk cases

The audit **principles** `AU-1`…`AU-9` live in a **frozen Rank 3** document. If any were reproduced as an `AUD-*`
requirement, this check fails. Each was traced (the full table is in the Stage 3 record §8.1):

| Principle | `PRD-016`'s treatment | Restated? |
|---|---|---|
| `AU-1` (Auth §10.4) Completeness | Routed **away** — emitter-side, `AUD-FR-003` / `AUD-XC-011` | No |
| `AU-2` (Auth §10.4) Immutability | Cited by `AUD-INV-001`, `AUD-BR-001` | No — see §6.3 |
| `AU-3` (Auth §10.4) Attribution | Cited by `AUD-INV-003` | No |
| `AU-4` (Auth §10.4) Independence | Cited by `AUD-BR-002`, `AUD-XC-002` | No |
| `AU-5` (Auth §10.4) Minimality | Cited by `AUD-INV-004` | No |
| `AU-6` (Auth §10.4) Non-disclosure | Cited by `AUD-INV-004`, `AUD-XC-004` | No |
| `AU-7` (Auth §10.4) Tenant confinement | Cited by `AUD-FR-014`, `AUD-XC-003` | No |
| `AU-8` (Auth §10.4) Survivability | Cited by `AUD-BR-003`, `AUD-XC-012` | No |
| `AU-9` (Auth §10.4) Server authority | Cited by `AUD-FR-007` | No |

### 6.3 The distinction that decides this check

`AUD-INV-001` and `AU-2` (Auth §10.4) are the closest pair, and the reason they are not two sources of truth is
precise:

- `AU-2` (Auth §10.4) is a **principle**: *"A recorded fact can never be altered or removed by anyone."* It has no
  aggregate, no module and no enforcement mechanism.
- `AUD-INV-001` is an **invariant on a named aggregate with a named enforcement site**: `AuditEntry`, in
  `platform/audit`, enforced by `banned_method_names` and checked by `AUD-AC-001`.

`AUTH-10.26` creates this division explicitly by vacating *storage* to `BC-24` while `BC-18` keeps the principles. A
principle and its enforcement site are one source of truth expressed at two ranks — which is what a rank system is
for. Had `PRD-016` written *"a recorded fact can never be altered by anyone"* as `AUD-BR-00n`, this check would fail.
It does not.

### 6.4 §0.5 is a declared no-restatement register, and it was audited

The draft publishes a table of seven things it deliberately does **not** restate: the `AU-*` principles,
`AUTH-10.19`…`10.27`, the §9.1 envelope, `PRD-013`'s tenant context, `PRD-006`'s emitter duties, the Rank 1 global
rules, and `X-10`/`X-13`. Each was spot-checked against the requirement text:

- **The envelope** — `AUD-FR-005` lists the ten field names. This was the most plausible restatement in the document,
  and it survives: L449–450 is **Rank 4 canonical text**, the requirement cites it by line, and the point of the
  requirement is *"every recorded entry MUST carry"* it — an obligation on this module, not a redefinition of the
  envelope. `AUD-FR-004`'s note makes the intent explicit: further fields *"arrive through the envelope … rather than
  through an invented aggregate field."* See §9 `S4-R3`.
- **`TEN-FR-011`** — `AUD-FR-015` says it *"consumes"* the frozen requirement *"rather than redefining it"*, and does
  not restate what "unset" means.
- **`ATT-FR-129`…`133`** — cited as emitter-side duties, never reproduced.

### 6.5 Result

✅ **PASS.** 32 foreign identifiers cited across 88 citations, **zero restatements**. The nine frozen audit principles
are cited and none is reproduced as a local obligation. The one borderline case (`AUD-FR-005`, the envelope) cites
canonical Rank 4 text by line and states an obligation on this module rather than redefining the envelope.

---

## 7. Check 6 — Business rules do not contradict Rank 1

> *"Rank 1 wins; the PRD is wrong."*

### 7.1 The three business rules against their Rank 1 authorities

| Rule | States | Rank 1 authority | Relationship |
|---|---|---|---|
| `AUD-BR-001` | A correction **MUST** be a new entry | `MP-GBR-13` — *"append-only with no update or delete path in code"* | **Reinforces.** Remedy quoted verbatim from `X-10`: *"Append a correcting entry"* |
| `AUD-BR-002` | Immutable for **every** role incl. Platform Administrator | `MP-GBR-13`; `AUTH-10.20` (Rank 3, frozen) | **Reinforces**, and is stronger — it forecloses the privileged-override path `MP-GBR-13` does not mention |
| `AUD-BR-003` | Erasure by making non-identifying, **never** by removal | `MP-GBR-04` — erasure retains history pseudonymised | **Reinforces.** Also satisfies `MP-GBR-13`'s no-delete-path, which a delete-based erasure would breach |

### 7.2 Permissive-mutation scan

```
permissive mutation language ('MAY update', 'MAY delete', 'update path', 'delete path') : NONE ✅
MP-GBR-13 citations : 5      MP-GBR-04 citations : 4
MP-GBR-08/09        : 1      MP-NFR-10           : 3
```

Not one construction anywhere in the document weakens the Rank 1 invariant.

### 7.3 The apparent Rank 1 contradiction, and why it is not one

`MP-GBR-13` says audit is append-only with no delete path. `MP-GBR-04` says erasure retains history pseudonymised.
Read naively these pull in opposite directions — a right to erasure implies removal, and removal is forbidden.

`AUD-BR-003` satisfies both **simultaneously**, and the mechanism was not invented for this PRD: manifest assertion
`AU-4` already states *"erasure makes a record non-identifying by key destruction; no record is ever removed."*
Four further authorities agree — `AU-8` (Auth §10.4), `AUTH-10.25`, `MP-GBR-04`, BC Map `ID-5`. **Five independent
sources.** Both Rank 1 rules hold; neither is bent. This was tested hardest of anything in the review, because a
compliance mechanism is exactly what the authoring instruction forbids inventing — see §9 `S4-R2`.

### 7.4 One rule is *stronger* than Rank 1 requires, and that is lawful

`AUD-BR-002` forbids Platform Administrator override; no Rank 1 rule mentions administrators. A PRD may be stricter
than a global rule — it may not be **looser**. And the strictness is not volunteered from nothing: it is quoted from
`AUTH-10.20`, a frozen Rank 3 requirement in the context that owns roles. So the additional strength is inherited,
not asserted.

### 7.5 Result

✅ **PASS.** 3 of 3 business rules reinforce Rank 1. Zero permissive-mutation constructions. The apparent
`MP-GBR-13` / `MP-GBR-04` tension is resolved by a mechanism already recorded in five places, not by a new rule.

---

## 8. The gate — conflicts closed or deferred, with a reason and an owner

> **Gate:** *"conflicts closed or explicitly deferred **with a reason and an owner**."*

### 8.1 Conflicts

| # | Conflict | Status |
|---|---|---|
| — | **None.** | Six checks, zero internal-quality conflicts. Stage 3 also returned zero authority conflicts |

### 8.2 Explicit deferrals — 5, each with a reason and a named owner

Carried unchanged from the draft's §10. **None is closed by this record. None is invented.**

| ID | Deferred item | **Owner** | **Reason for deferral** |
|---|---|---|---|
| `AUD-GAP-001` | Audit retention period — undefined at every rank | **SECURITY + DATA Governance**, with counsel | `MP-NFR-10` (Rank 1) assigns retention and legal hold to that owner; `Q-04` records it *"Open — needs counsel."* Supplying a period would invent a legal rule. `AUD-CFG-*` consequently unissued |
| `AUD-GAP-002` | `AUTH-10.27` (fail the action) vs `E-20` / manifest `AU-3` (fire-and-forget) | **`BC-18`** + **ARB** | Reconciling a frozen Rank 3 requirement with a Rank 4 edge is an ARB act. `AUD-FR-008`/`009` are written so this module's obligation is identical under either reading, so the deferral costs nothing |
| `AUD-GAP-003` | "Legal hold" has no defined mechanism | **SECURITY + DATA Governance** | With `AUD-BR-003` (never remove), purge has **no path** in V1, so no hold mechanism is needed to satisfy any invariant. Recorded because the phrase sits in a Rank 1 rule |
| `AUD-GAP-004` | Support-access action list undefined | **Product Owner** + **`BC-18`** | `AUD-FR-003` places the action list with the emitter. No emitter has published one; inventing it would breach `AUD-XC-011` |
| `AUD-GAP-005` | Class A fact register absent from the repository | **`BC-18`** | Manifest `event_register_source` points at a non-existent path. `AUD-FR-011` cites the enforceable class contract instead of unverifiable `EVT-*` numbers |

### 8.3 Code contradictions — deferred to Stage 8, with the requirement each will be built against

Not conflicts in the Stage 4 sense (the specification is internally sound), but recorded so nothing is lost:

| ID | Contradiction | **Owner** | Built against |
|---|---|---|---|
| `D-016-01` | `recent()` / `count` expose cross-tenant reads | **Stage 8 implementation** | `AUD-FR-016`, `AUD-XC-003`, `AUD-AC-009` |
| `D-016-02` | 4 envelope fields absent; `at` defaults to epoch 0 | **Stage 8 implementation** | `AUD-FR-005`, `AUD-FR-006`, `AUD-FR-007`, `AUD-AC-011`, `AUD-AC-012` |
| `D-016-03` | In-memory list, no outbox | **Stage 8 implementation** | `AUD-FR-008`, `AUD-AC-013` |

### 8.4 A new deferral raised by this review

| ID | Item | **Owner** | **Reason** |
|---|---|---|---|
| **`S4-D-01`** | Any mechanical checker for `AUD-*` **must expand ellipsis ranges** (`` `AUD-XC-005`…`008` ``). A token-only scanner under-counts coverage by 3 and would report a false gap — as this review's own first script did (§5.2) | **Stage 5** (whoever writes the `prd016_*` gate script) | Raised here because the defect is in *verification tooling*, not in the PRD. Recording it prevents Stage 5 from re-discovering it as a PRD fault. `PRD-013` §2I already records the absence of a `TEN-*` gate script as a known weakness; this names the trap in advance |

---

## 9. Rejected findings — recorded as rejected, with reasons

Four candidate findings were raised at Stage 4 and rejected.

| # | Candidate finding | Rejected because |
|---|---|---|
| `S4-R1` | *"8 of 35 Class A identifiers carry no acceptance criterion — that is a 23% verification gap and check 4 should fail."* | Check 4's failure mode is the **orphan criterion** (a criterion with no requirement), and there are **zero**. Reverse coverage is not a lifecycle requirement at all; it was measured voluntarily. All 8 are scope/ownership/structural statements whose violation is the *presence of a type*, covered by `AUD-AC-017` and by boundary-checker assertions. Manufacturing criteria of the form *"the module owns `AuditEntry`"* would be unfalsifiable and would inflate the count without adding verification. `PRD-013` set this precedent for `TEN-FR-001`…`009` |
| `S4-R2` | *"`AUD-BR-003` invents a compliance mechanism (key destruction), so check 6 fails on inventing a rule."* | Raised at Stage 3 as `AL-R5` and re-tested here against check 6 specifically. The mechanism is quoted **verbatim** from manifest `AU-4` and corroborated by `AU-8` (Auth §10.4), `AUTH-10.25`, `MP-GBR-04` and `ID-5` — **five sources**. No period, jurisdiction or statute is supplied. It resolves an apparent Rank 1 tension **using existing text**, which is the opposite of inventing a rule |
| `S4-R3` | *"`AUD-FR-005` reproduces the ten envelope field names from BC Map §9.1, so check 5 fails on two sources of truth."* | Examined most closely of the 88 citations. The requirement's obligation is *"every recorded entry MUST carry"* the envelope — an obligation on **this module**. It cites L449–450 by line, defines no field, changes no name, adds none, and `AUD-FR-004`'s note states that further fields arrive *through* the envelope rather than as aggregate members. Naming the fields it must carry is what makes `AUD-AC-011` testable; omitting them to avoid apparent duplication would make the requirement unverifiable and fail check 1 instead |
| `S4-R4` | *"Check 3 cannot be genuinely passed by an empty register — an audit store with no retention configuration is incomplete, so the check should be FAIL or CONDITIONAL."* | The check tests *"every configurable has a default and a range."* With zero configurables the predicate is vacuously satisfied, and the real question — *is the emptiness justified?* — was answered against three authorities (`CONFIGURATION_GUIDE.md` silence, `MP-NFR-10` ownership, `Q-04` open). Marking it CONDITIONAL would imply the PRD could resolve it, which `MP-NFR-10` forbids. Frozen `SEAT-XC-015` is the precedent: a PRD **froze** while placing *"audit retention, legal hold, purge, export"* out of scope. The absence is carried as `AUD-GAP-001` with a named owner, which is what the Stage 4 gate actually asks for |

---

## 10. Containment audit

| Check | Result |
|---|---|
| `PRD-016_AUDIT_TRAIL.md` modified | **No** — SHA-256 `281f15e8…39be` identical before and after |
| PRD status / version changed | **No** — remains **v0.1 `DRAFT`** |
| Stage 1 or Stage 3 record modified | **No** |
| Any other PRD modified | **No** |
| Frozen PRDs (Auth · Seat · Attendance · Tenancy) modified | **No** |
| BC Map · Master PRD · Matrix · Rulings · manifest modified | **No** |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` modified | **No** — registry remains **`PLANNED`** |
| ADR created or modified | **No** — no check required one |
| `TRACEABILITY_MATRIX.md` touched (Stage 5) | **No** |
| `AUD-*` identifiers registered anywhere | **0** |
| Traceability checker created | **No** — `S4-D-01` names its requirement for Stage 5 |
| Requirement, criterion, exclusion or configurable **added to the PRD** | **No** — 58 identifiers unchanged |
| Gap closed | **No** — all 5 remain open with named owners |
| **Implementation code modified** | **No** — `git status --short lib/ packages/ test/ tool/` → **0 lines** |
| Code defect repaired | **No** — `D-016-01`…`03` routed to Stage 8 |
| Stages 5 / 6 / 7 started | **No** |
| **Stage 8 entered** | **No** |
| Commits · pushes made by this review | **0 / 0** |
| Files added | **1** — this document |

This record is a **historical validation record and is not part of the specification**. **It confers no status.**

---

## 11. Verdict

> ## ✅ **PASS — Stage 4, 6 of 6 checks**

| # | Check | Result |
|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** — 23/23 carry a normative verb; **0** vague constructions; the 3 universal-negative requirements each name a decidable observation |
| 2 | Every exclusion states what must be impossible | ✅ **PASS** — 12/12; 8 name a receiving owner, 4 are universal prohibitions where `—` is correct |
| 3 | Every configurable has a default and a range | ✅ **PASS** — **0 issued**, 0 duration literals; emptiness justified against 3 authorities and carried as `AUD-GAP-001` |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** — 18/18 traced, **0 orphans**; reverse coverage **8**, exactly matching the draft once ellipsis ranges are expanded |
| 5 | No requirement restates another PRD's | ✅ **PASS** — 32 foreign identifiers, 88 citations, **0 restatements**; the 9 frozen principles cited, none reproduced |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** — 3/3 reinforce; **0** permissive-mutation constructions; the `MP-GBR-13`/`MP-GBR-04` tension resolved from 5 existing sources |

**Gate satisfied:** **0 conflicts to close.** **5 explicit deferrals**, each with a **reason and a named owner**
(§8.2), plus 3 code contradictions routed to Stage 8 with the requirements they will be built against (§8.3), plus
**1 new deferral** raised by this review for Stage 5's tooling (`S4-D-01`, §8.4). **4 candidate findings rejected**
with reasons (§9).

The most useful thing this review produced is not a pass mark but `S4-D-01`. A verification script that disagrees
with a document is not evidence the document is wrong — here the script was wrong, and finding out **why** turned a
false 3-identifier gap into a written constraint on the Stage 5 gate script. *"Mechanical means counted by a tool"*
also means the tool must be right.

**`PRD-016` may proceed to Stage 5 — Traceability Registration.** Status remains **v0.1 `DRAFT`**; registry status
remains **`PLANNED`**.

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Created as the **Stage 4 Requirements Review Record** for `PRD-016`. All six checks decided **mechanically** where decidable: 23/23 requirements verb-bearing, 0 vague constructions, 12/12 exclusions stating impossibility, 0 configurables issued, 18/18 criteria traced with 0 orphans, 32 foreign identifiers cited with 0 restatements, 3/3 business rules reinforcing Rank 1. **6 of 6 PASS, 0 conflicts.** Raised and resolved one measurement discrepancy in the draft's favour (ellipsis-range expansion, §5.2) and recorded the tooling constraint as **`S4-D-01`** for Stage 5. **5 deferrals** carried with reasons and owners; **4 candidate findings rejected** with reasons. **No PRD modified, no identifier registered, no ADR created, no code modified, no commit or push.** |
