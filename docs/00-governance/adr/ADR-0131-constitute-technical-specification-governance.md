# ADR-0131 — The **Technical Specification** is constituted as a governed document class, with a lifecycle stage, an identifier namespace, a directory and an ownership model

| Field | Value |
|---|---|
| **ADR** | `ADR-0131` |
| **Status** | ⭐ **Accepted** — 2026-09-10, by direct, explicit conferral of the human principal of this engagement, jointly exercising **Governance Owner** and **Architecture Owner** authority, scoped to **this act and nothing else**. Same disclosure as `ADR-0033`, `ADR-0087`, `ADR-0092`, `ADR-0129` and `ADR-0130`: ⛔ **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *"a conferral for one act is not a standing licence"* (`ADR-0033` §7.1) — both offices ⛔ **revert on completion** |
| **Date** | 2026-09-10 |
| **Deciders** | **Governance Owner** — lifecycle, document status and the baseline (`PRD_OWNERSHIP_MODEL.md` **L418**) · **Architecture Owner** — *"ADR approval; any Rank 1–5 document change"* (`PRD_OWNERSHIP_MODEL.md` **L85**) |
| **Act performed** | ⭐ **Constitute the Technical Specification lifecycle/governance layer.** ⛔ **NOTHING ELSE.** |
| **Act NOT performed** | ⛔ **No Technical Specification is drafted, named, scaffolded or placeheld by this ADR.** This ADR creates the *class*, not an *instance* |
| **Supersedes** | **Nothing.** ⛔ No ADR is amended, restatused, rewritten or superseded by this act |
| **Amends** | `PRD_LIFECYCLE.md` · `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `ADR-INDEX.md` — each by the **smallest change** that registers the new class, enumerated in §9 |

---

## 1. Context — the measured gap this ADR closes

A Stage 1 read-only readiness audit of the repository on 2026-09-10 produced three measurements. Each is
reproducible, and each is the reason this ADR exists.

| # | Measurement | Method | Result |
|---|---|---|---|
| 1 | **No Technical Specification exists** | case-insensitive search for *"technical specification"* across `docs/` (503 markdown files) | ⭐ **1 hit, and it is a NEGATIVE statement** — `PRD-006_VERIFICATION_REPORT.md` **L407**: *"no technical specification"* |
| 2 | **No lifecycle slot exists for one** | `PRD_LIFECYCLE.md` §2 stage table | ⛔ **nine stages, none of them Technical Specification.** Stage 6 is *Implementation Tasks* (`IMPL-*`); Stage 8 is *Implementation* |
| 3 | **No identifier namespace exists** | `grep -rhoE '\bTS-[0-9]{3}\b' docs/` and `grep -ric TSPEC docs/` | ⭐ **`TS-NNN` = 0 occurrences · `TSPEC` = 0 occurrences.** The only `*TS-` family in the repository is **`LTS-*` (260 occurrences)**, which belongs to `PRD-021C` Library Marketplace |

⚠ **The consequence of gap 2 is the reason this is an ADR and not a convenience.** Without a lifecycle stage, a
Technical Specification cannot lawfully hold a version, a status, a gate or a rank — it would be an unranked file
asserting technical authority, which is precisely the failure mode `PRD-021B` Part **B9** records as
`XPB-CONF-012`.

### 1.1 What already exists, and why it is not sufficient

⛔ **This ADR does not claim the repository is technically empty.** It is not. The following were measured and are
deliberately **preserved, reused and cited** rather than replaced:

| Existing material | Measurement | Why it is not a Technical Specification layer |
|---|---|---|
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` v1.14 | 31 bounded contexts, 33 edges `E-01`…`E-33` | **Rank 4 architecture.** States boundaries and ownership, ⛔ not field types, contracts or persistence |
| 118 ADR files, highest `ADR-0130` | 81 Accepted | **Rank 2 decisions.** A decision is not a specification |
| `PRD-021A` **A8** (1,925 L) · `PRD-021B` **B9** (982 L) · `PRD-021C` **C8** (778 L) | all three baselined at **Rank 3** (`ADR-0087`, `ADR-0092`, `ADR-0098`) | ⭐ **Genuine partial technical specifications** — but each is scoped to its own PRD family and each invented its **own** stem (`TPA-`, `LMT-`, A8's own) |
| `INVITATION_SECURITY_SPECIFICATION.md` v1.0 | Authoritative, baselined | ⭐ **The repository's one complete, approved technical specification** — and it covers **one feature** (`IT-1`…`IT-3`) |
| 17 × `PRD-0xx_IMPLEMENTATION_TASKS.md` | Stage 6 gate records | ⛔ **task lists, NOT specifications** |
| `TRACEABILITY_MATRIX.md` v1.26 | 22 identifier inventories (§2 + §2A…§2U) | ⭐ strong PRD→ADR→`IMPL-*` chains; ⛔ **no technical-specification link in the chain** |

⭐ **The finding is therefore not "nothing exists" but "the technical layer is real, scattered, and ungoverned."**
Three PRD families each solved the same problem three different ways because no convention existed to follow.

---

## 2. Decision

⭐ **The Technical Specification is constituted as a governed document class of the Liboora repository**, with the
lifecycle stage of §4, the identifier namespace of §5, the directory of §6, the ownership model of §7, the
precedence rules of §3, the traceability obligation of §8 and the freeze/amendment rules of §10.

⛔ **This ADR authorises the class. It does NOT authorise drafting.** Drafting any individual Technical
Specification is a **separate governed act** requiring its own conferral, and §12 lists the blockers that must fall
first.

---

## 3. §A — What a Technical Specification IS, and its place in the chain

### 3.1 Purpose

A **Technical Specification** translates governed product and architectural decisions into implementation-level
technical detail, for exactly one clearly bounded subject, so that database design, API specification, UX, design
and implementation can proceed **without undocumented assumptions**.

### 3.2 The chain

```
PRD requirement
   ↓
Architecture / bounded-context constraint   (Rank 4)
   ↓
ADR decision                                (Rank 2)
   ↓
TECHNICAL SPECIFICATION                     ← constituted by this ADR
   ↓
Database + Supabase · API Specification · UX Research + User Flow · Design · Prototype
   ↓
Implementation
   ↓
QA / Security / Release
```

### 3.3 ⛔ What a Technical Specification is NOT — the five prohibitions

A Technical Specification:

1. ⛔ **does NOT override a PRD.** A PRD says *what*; a Technical Specification says *how*. Where they disagree,
   **the PRD wins and the disagreement is a specification defect to be raised, never silently reinterpreted**
   (`PRD_LIFECYCLE.md` Stage 8 rule).
2. ⛔ **does NOT override an Accepted ADR.** `ADR-INDEX` **L206**: *"Never edit an Accepted ADR's decision text —
   supersede it with a new ADR."* A Technical Specification has **no** supersession power over an ADR.
3. ⛔ **does NOT override Rank 4 architecture authority.** Boundaries, ownership and permitted edges belong to the
   BC Map and the Module Dependency Matrix. A Technical Specification **consumes** them.
4. ⛔ **does NOT compete with the Rank 6 Enterprise Architecture** — and equally, ⛔ **may NOT cite the EA as
   overriding technical authority.** Baseline §4 Rank 6: *"**Descriptive only.** Update it to match 1–5; never the
   reverse."* ⚠ An EA line that contradicts Ranks 1–5 is **stale, not authoritative**.
5. ⛔ **does NOT invent product requirements.** If a technical question cannot be answered from governed material,
   the Technical Specification **records a gap with a named owner** — it does not legislate. This is the
   `TPA-GAP-*` / `SAAS-GAP-*` / `FEE-GAP-*` discipline already established in this repository.

⭐ **Positively stated: a Technical Specification is a TRANSLATION artefact, not a decision artefact.** Its
legitimacy comes entirely from the governed decisions it cites.

---

## 4. §B — The lifecycle stage

### 4.1 ⚠ Why the stage is `6A` and not a renumber — a measured decision

The brief permitted the smallest governance-consistent amendment and warned against casual renumbering. **Both
options were measured before choosing:**

| Option | Measured cost | Verdict |
|---|---|---|
| **Renumber** so Technical Specification becomes a new Stage 7 and Freeze→10 | ⭐⭐ **7,411 `Stage N` references across 241 files** would become ambiguous or wrong (`Stage 3` alone = 1,817 hits / 241 files; `Stage 7` = 1,129 / 203). Every `PRD-0xx_STAGE7_FREEZE.md` filename, every `ADR` gate table and every registry status mapping would mis-resolve | ⛔ **REJECTED — catastrophic and irreversible** |
| **Insert as `6A`**, between Stage 6 (Implementation Tasks) and Stage 7 (Freeze) | ⭐ **0 existing references invalidated.** Follows the repository's own established letter-suffix insertion convention — `§6A`, `§7A`, `§7B`, `§8A`, `§10A`, `§14A`, `§14B` in product documents, and `PRD-012a`, `PRD-021A`, `PRD-021B`, `PRD-021C` in PRD identities | ⭐ **ADOPTED** |

⚠ **The nine-stage vocabulary is therefore PRESERVED.** `PRD_LIFECYCLE.md` §2's heading *"The nine stages"* and its
numbered table remain **byte-unchanged**, and nine registry statuses remain mapped exactly as before. Stage `6A` is
an **inserted stage, not a renumbering**, and its history is additive.

### 4.2 Stage `6A` — Technical Specification

| Field | Value |
|---|---|
| **Stage** | **`6A` — Technical Specification** |
| **Position** | **after** Stage 6 (Implementation Tasks), **before** Stage 7 (Freeze) |
| **Registry status** | ⛔ **No new registry status is created.** A PRD at stage `6A` remains `APPROVED`, exactly as at Stage 6. ⚠ Creating a tenth status would change `PRD_REGISTRY.md` §2's status vocabulary, which is **not** within this act |
| **Purpose** | Translate the frozen/approved requirements, the Rank 4 boundaries and the Accepted ADRs of one bounded subject into implementation-level technical detail, and **record every unanswerable question as a gap rather than deciding it** |

### 4.3 ⚠ Stage `6A` is OPTIONAL and NON-BLOCKING for already-frozen PRDs

⛔⛔ **Stage `6A` does NOT retroactively invalidate, reopen, downgrade or re-gate any PRD already frozen.**

**16 PRD identities are `FROZEN` and admitted to `DOCUMENTATION_BASELINE.md` §3.3 without ever passing stage `6A`,
because it did not exist.** Every one of them remains **FROZEN, authoritative and fully valid**. A stage inserted
today cannot be a gate a document failed yesterday.

⭐ Accordingly:

1. For a PRD **already frozen**, stage `6A` is **available but not required**, and its absence is ⛔ **NOT a
   defect, NOT a blocker and NOT a regression**.
2. For a PRD **not yet frozen**, stage `6A` is **available and recommended**, and ⛔ **still not a precondition of
   Stage 7** — because making it one would retroactively alter the Stage 7 gate that `PRD_LIFECYCLE.md` **L159**
   defines and that **every** existing freeze was conferred against.
3. Whether stage `6A` should ever become **mandatory** is ⛔ **explicitly NOT decided here** and is recorded as
   `TSG-GAP-001` in §11.

⚠ **This restraint is deliberate.** A governance act that silently converts 16 valid freezes into incomplete ones
would be the precise defect this repository's `GCP-*` register exists to catch.

### 4.4 Entry criteria — all four required

A subject may enter stage `6A` only when **all** hold:

| # | Entry criterion | Evidence required |
|---|---|---|
| **E-1** | The subject's requirements are **frozen or baseline-authoritative** | a row in `DOCUMENTATION_BASELINE.md` §3, or an Accepted ADR admitting it |
| **E-2** | Stage 3 (Architecture Review) has **passed** for the subject | the Stage 3 alignment/conferral record |
| **E-3** | Every Accepted ADR governing the subject is **identified and cited** | an explicit ADR list in the specification's control section |
| **E-4** | Every **governed decision the specification depends upon exists** — or the dependency is recorded as a **gap with a named owner** | the gap register required by §4.5 exit gate **X-5** |

⛔ **`E-4` is the load-bearing criterion.** It is what prevents a Technical Specification from inventing the
answer to a question no office has yet decided.

### 4.5 Exit gate — all six required

Stage `6A` is passed only when **all** hold. ⛔ *"A gate is not an opinion — if the artefact does not exist, the
stage has not been passed, however complete the work feels"* (`PRD_LIFECYCLE.md` **L41**).

| # | Exit criterion |
|---|---|
| **X-1** | A Technical Specification document exists on disk, in the §6 directory, with a versioned control header and its `TS-*` identifier declared |
| **X-2** | Its identifier stem is **collision-checked and measured 0** repository-wide before use (`PRD_LIFECYCLE.md` §5 rule 2) |
| **X-3** | **Every** technical assertion cites its governing authority — a PRD requirement ID, an ADR, a BC Map line, or a Rank 4/5 register entry |
| **X-4** | The §3.3 prohibitions are **individually and explicitly affirmed**, including that no permission, boundary, edge, port, aggregate or product requirement was invented |
| **X-5** | A **gap register** exists in which every unanswerable technical question is recorded **with a named owning office** — ⛔ and none is closed to make the document look complete |
| **X-6** | The §8 traceability chain is stated for every section: **PRD requirement → Architecture/BC → ADR → this section** |

### 4.6 Relationship to downstream stages

⭐ A Technical Specification is the **declared upstream input** to database design, API specification, UX research,
design, prototyping and implementation. ⛔ **It is not a substitute for any of them**, and ⛔ **passing stage `6A`
does not authorise any downstream act** — each remains its own governed act with its own conferral.

⚠ **Downstream ordering is stated as an expectation, not legislated as a gate**, because mandating it would alter
Stage 8, which is outside this act (see `TSG-GAP-002`, §11).

---

## 5. §C — Identifier convention

### 5.1 The namespace

⭐ **`TS-*` is established as the canonical Technical Specification identifier namespace**, reserved exclusively for
this document class.

**Measured free before adoption**, per `PRD_LIFECYCLE.md` §5 rule 2:

| Pattern | Method | Result |
|---|---|---|
| `TS-NNN` | `grep -rhoE '\bTS-[0-9]{3}\b' docs/` | ⭐ **0** |
| `TSPEC` | `grep -ric 'TSPEC' docs/` | ⭐ **0** |
| `TS-*` families present | `grep -rhoE '[A-Za-z]*TS-[A-Za-z0-9]+' docs/` | **only `LTS-*`, 260 occurrences** |

### 5.2 Form

| Element | Rule |
|---|---|
| **Document identifier** | `TS-NNN` — three digits, zero-padded, allocated **sequentially from `TS-001`** |
| **Requirement identifier inside a specification** | `TS-NNN-<STEM>-<nnn>`, where `<STEM>` is a short uppercase category token declared in the specification's own control section |
| **Allocation** | ⛔ **Never reuse and never reassign a number** (`PRD_LIFECYCLE.md` §5 rule 1; `ADR-INDEX` **L206**) |
| **First free identifier** | ⭐ **`TS-001`** — measured; ⛔ **not allocated by this ADR** |

### 5.3 ⛔ Reuse prohibitions — measured, not assumed

| Namespace | Owner | Rule |
|---|---|---|
| **`LTS-*`** (260 occurrences: `LTS-FR`, `LTS-BR`, `LTS-XC`, `LTS-AC`) | `PRD-021C` Library Marketplace | ⛔⛔ **MUST NOT be reused, extended or reinterpreted as a Technical Specification namespace** |
| **`LCTS-*`** | `PRD-021C` | ⛔ **MUST NOT be reused** |
| **`TPA-*`** | `PRD-021B` **B9** | ⛔ **MUST NOT be reused.** B9's own identifiers stay B9's |
| **`LMT-*`** | `PRD-021C` **C8** | ⛔ **MUST NOT be reused** |
| **`IMPL-*`** | Stage 6 task documents | ⛔ **A `TS-*` document MUST NOT allocate `IMPL-*` identifiers** |
| **`PERM-*`** | ⛔ **withdrawn** — measured **2** occurrences repository-wide, **both withdrawal records** | ⛔⛔ **MUST NOT be minted** — see §7.4 of the boundary clauses (§8.2 below) |

⛔ **No `TS-*` identifier is created, allocated or reserved by this ADR.**

---

## 6. §D — Directory convention

⭐ **The canonical directory for Technical Specifications is `docs/50-technical/`.**

| Rule | Value |
|---|---|
| **Path** | `docs/50-technical/` |
| **Per-subject grouping** | `docs/50-technical/<module-or-subject>/` — mirroring the existing `docs/30-product/<module>/` and `docs/40-implementation/<module>/` convention |
| **Numbering rationale** | The repository already uses a decade-ordered scheme: `00-governance`, `10-architecture`, `20-configuration`, `30-product`, `40-implementation`, `90-archive`. ⭐ **`50-` is the next free decade** and places the technical layer **after** implementation-task material in reading order while leaving `60-`…`80-` free for the downstream classes named in §3.2 |
| **Directory creation** | ⛔ **NOT created by this act.** The convention is declared; the directory is created by the first act that lawfully authors a `TS-*` document |
| **Placeholder files** | ⛔⛔ **PROHIBITED.** No stub, no `README`, no `.gitkeep`, no template is created by this ADR |

⛔ **`docs/50-technical/` does not exist after this commit, and that is intentional** — an empty governed directory
asserts a class member that does not exist.

### 6.1 ⚠ Where the three existing technical parts stay

⛔ **`PRD-021A` A8, `PRD-021B` B9 and `PRD-021C` C8 are NOT moved, renamed, restatused, re-identified or converted
by this act.** All three are **baselined at Rank 3** by Accepted `ADR-0087`, `ADR-0092` and `ADR-0098` respectively,
and they remain exactly where they are, under their own identifiers, at their own versions.

⭐ They may be **cited as input and as structural precedent** by future `TS-*` documents. ⚠ Whether any of them
should later be re-expressed as a `TS-*` document is ⛔ **explicitly NOT decided here** — `TSG-GAP-003`, §11.

---

## 7. §E — Ownership

### 7.1 Roles, from the existing model

`PRD_OWNERSHIP_MODEL.md` §2.2 already defines four roles, and **one of them is exactly this class's natural owner**:

| Role | Existing scope (`PRD_OWNERSHIP_MODEL.md`) | Stage `6A` responsibility |
|---|---|---|
| **Technical Owner** | **L86** — *"Implementation, `IMPL-*` tasks, traceability from requirement to test, §10.4 gate health"*; decides *"sequencing and technical approach"*; ⛔ never decides *"whether a requirement is right"* | ⭐ **Authors and attests** the Technical Specification |
| **Architecture Owner** | **L85** — *"ADR approval; any Rank 1–5 document change"*; sits as **ARB** | ⭐ **Approves** — confirms boundaries, edges and Rank 4 conformance |
| **Product Owner** | **L83** — business intent, scope, acceptance | **Attests** that no product requirement was invented or altered |
| **Domain Owner** | derived from the owning bounded context (§3 rule 3) | **Reviews** ubiquitous language and invariants |

⭐ **The Technical Owner role required no invention** — §2.2 already scopes it to implementation and traceability,
which is precisely this class. **This ADR constitutes no new office.**

### 7.2 ⚠ The offices are VACANT, and this ADR does not fill them

⛔⛔ **All governance offices in this repository are VACANT as constituted.** `PRD_OWNERSHIP_MODEL.md` records that
*"the role is **vacant as constituted** — constituting an office does not fill it, and nothing in this document
appoints anyone"*, and **L316** confirms *"Product and Technical Owner changes need no ADR"*.

⛔ **This ADR appoints nobody, names no person, and fills no office.** Accordingly:

1. Every stage-`6A` act proceeds under the **existing one-act-conferral model** — the human principal confers the
   required offices explicitly, for one act, and ⛔ **they revert on completion** (`ADR-0033` §7.1).
2. ⛔ **A Technical Specification MUST NOT record an office as occupied.** It records **which office is required**
   and **by which conferral it was exercised** — the disclosure form used by `ADR-0129` and `ADR-0130`.
3. ⛔ **Only the Architecture Owner approves.** `PRD_OWNERSHIP_MODEL.md` §12: *"**Only the Architecture Owner
   approves.** The others attest, review or confirm."* That asymmetry carries into stage `6A` unchanged.

---

## 8. §F — Authority and precedence

### 8.1 What a Technical Specification must conform to, in order

A Technical Specification **MUST** conform to, and is subordinate to, all of the following:

| Order | Authority | Source |
|---|---|---|
| **1** | **Rank 1 `MASTER_PRD.md`** global rules — `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` | baseline §4 Rank 1 |
| **2** | Applicable **frozen / baseline-authoritative PRDs** | baseline §3.3, §4 Rank 3 |
| **3** | **Accepted ADRs** | baseline §4 Rank 2 |
| **4** | **Rank 4 architecture** — BC Map, Module Dependency Matrix; and **Rank 5** Architecture Rulings | baseline §4 Ranks 4–5 |

⚠ **Where two of the above disagree, the Technical Specification applies the baseline §4 precedence order and
RECORDS the conflict. ⛔ It never resolves one.**

### 8.2 ⛔ The eight things a Technical Specification may never do

| # | Prohibition |
|---|---|
| **P-1** | ⛔ **MUST NOT supersede an ADR.** Supersession is an ADR's power alone (`ADR-INDEX` **L206**/**L207**) |
| **P-2** | ⛔ **MUST NOT supersede, amend or reinterpret a frozen PRD.** Amendment requires an ADR **before** the change (baseline §7 rule 1) |
| **P-3** | ⛔⛔ **MUST NOT invent a permission** — see §9.2 |
| **P-4** | ⛔ **MUST NOT create a new product boundary** — no bounded context (count is **31**), no edge (highest is **`E-33`**; ⛔ **`E-34` is NOT allocated**), no port, no aggregate name |
| **P-5** | ⛔ **MUST NOT silently resolve a conflict.** Conflicts are recorded with source, status, severity and the required governance act — never repaired in passing |
| **P-6** | ⛔ **MUST NOT cite the Rank 6 Enterprise Architecture as overriding technical authority** |
| **P-7** | ⛔ **MUST NOT change its own status.** `PRD-008` **L11** supplies the rule: *"Status is **conferred** by admission to the baseline, **never claimed by a document about itself**"* |
| **P-8** | ⛔ **MUST NOT introduce product requirements, scope or acceptance criteria that no PRD declares** |

### 8.3 ⚠ Rank is DEFERRED, explicitly

⛔ **This ADR does NOT assign a precedence rank to the Technical Specification class.** Baseline §4 currently
enumerates Ranks 1–7, and inserting a new rank would change the precedence order that **every** frozen document was
admitted under.

⭐ **Until a rank is conferred, a Technical Specification is an UNRANKED governed document**: it is governed (it has
a class, a lifecycle stage, an identifier, an owner and freeze rules) but it ⛔ **carries no precedence authority
over any ranked document**, and in any disagreement **the ranked document wins by default**.

⚠ **This is stated as a deliberate deferral, not an omission** — `TSG-GAP-004`, §11. It is also exactly the framing
`PRD-021B` B9 adopted for itself in `XPB-CONF-012`, and the framing is adopted here because it has already been
tested in this repository.

---

## 9. Mandatory boundary clauses — binding on EVERY future Technical Specification

⭐ These clauses exist because a specification author reading a single frozen PRD in isolation **would reintroduce
decisions this repository has already retired**. Each clause names the governing decision and the exact trap.

### 9.1 ⛔⛔ PAYMENT — `ADR-0130` is binding

Every Technical Specification **MUST** conform to `Accepted`
[`ADR-0130`](./ADR-0130-student-payment-v1-cash-only-liboora-platform-charge-and-settlement-v2.md):

| Subject | V1 | V2 |
|---|---|---|
| Student pays the library in **cash** | ⭐ **YES — the V1 student payment method** (`ADR-0037`: server-authoritative, ⛔ no offline write) | YES |
| **UPI** | ⛔ **NO** | ⚠ DEFERRED — not designed |
| **Card** | ⛔ **NO** | ⚠ DEFERRED — not designed |
| **Online payment** | ⛔ **NO** | ⚠ DEFERRED — not designed |
| **Student payment gateway** | ⛔ **NO — no V1 gateway exists** | ⚠ DEFERRED — not designed |
| **LIBOORA platform / extra charge** | ⛔ **NO — deliberately OUT OF V1 SCOPE** | ⚠ DEFERRED |
| **Library → LIBOORA settlement** | ⛔ **NO — deliberately OUT OF V1 SCOPE** | ⚠ DEFERRED |
| **V1 settlement mechanism** | ⛔ **NONE REQUIRED**, and its absence is ⛔ **NOT a V1 blocker** | ⚠ TO BE DESIGNED |

⛔ **No Technical Specification may invent a V2 mechanism prematurely** — not a settlement instrument, not a rail,
not a provider, not a gateway abstraction, not a bank-account structure.

⚠⚠ **THE SPECIFIC TRAP, NAMED SO IT CANNOT BE WALKED INTO.** `PRD-008` Revenue & Finance is **FROZEN at v1.7** and
is the natural input for any revenue Technical Specification — and its **§6.1** still lists as **V1**:

| `PRD-008` line | Content | Status under `ADR-0130` |
|---|---|---|
| **L209** | UPI | ⛔ **V2** |
| **L210** | Card | ⛔ **V2** |
| **L211** | Online payment | ⛔ **V2** |
| **L213** | Verification | ⛔ **V2** |
| **L214** | Webhook reconciliation | ⛔ **V2** |

⭐ **Those five lines are superseded IN EFFECT by rank** (baseline §4: a Rank 2 Accepted ADR outranks a Rank 3 PRD).
⛔ `PRD-008` is **FROZEN and NOT edited** by this act, so **a specification author MUST apply `ADR-0130`, not
`PRD-008` §6.1**, and **MUST record the divergence rather than repair it**. The lawful repair is a `PRD-008`
successor — ⛔ **a separate act, NOT performed here**.

⚠ Two further pre-existing divergences are **recorded, not repaired**: `PRD-019` §4 carries **39 Razorpay
references** ratified by `ACCEPTED` `ADR-0047`/`ADR-0048` and therefore ⛔ **may not be rewritten** without
superseding those ADRs; and `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1395**–**L1398** lists *Online / UPI / Card
Payments (V1)* but is **Rank 6 descriptive** and can only be **stale**, never authoritative.

### 9.2 ⛔⛔ AUTHORIZATION — `AUTH-7.22` is binding and the catalogue is CLOSED

`AUTH-7.22` (`prd-v2/07` **L124**): *"The permission catalogue **MUST** be closed. A permission not declared in it
cannot be granted, requested or evaluated."*

⚠⚠ **The measured state, which every specification author must know before writing an authorization section:**

| Measurement | Result |
|---|---|
| Permission **categories**, action classes and scope classes enumerated in `AUTH-7.22` | present |
| ⭐⭐ **Enumerated permission IDENTIFIERS** | ⛔⛔ **ZERO** |
| `PERM-*` occurrences repository-wide | **2 — and both are *withdrawal* records** |
| Consequence | ⛔ **No naming convention exists to extend.** Minting one would be *inventing the convention*, not applying it |

⛔ **No Technical Specification may invent, mint, infer, imply or "provisionally" name a permission identifier.**
`ADR-0043` §5.1 remains binding and is quoted in full: *"Owner may explicitly grant approval access **using the
existing permission/access-control mechanism**. **Do not invent a new permission ID.**"*

⛔ **`AP-9` fail-closed remains binding.** Where a required authority does not exist, the correct specification
outcome is **fail closed plus a recorded gap** — ⛔ never a fabricated permission.

⚠ Populating the catalogue is **blocker B-2** of the Stage 1 audit and is ⛔ **NOT performed by this act**. It
requires the **Authorization (`BC-18`/`PRD-001`) Owner + Product Owner**.

### 9.3 ⛔ AUTHENTICATION — Auth v3.0 / `ADR-0129` remain authoritative

**Authentication PRD v3.0** is the authoritative `BC-18` baseline (`DOCUMENTATION_BASELINE.md` §3.3, admitted by
`Accepted` `ADR-0129`, governed commit `14f6e8d`). **v2.0 and `prd-v2/00`…`11` are HISTORICAL / FROZEN and
byte-unchanged.**

⛔ **No Technical Specification may reintroduce:**

| ⛔ Prohibited in V1 | Governing decision |
|---|---|
| **V1 mobile OTP** as a required authentication method | `ADR-0129` — re-scoped to **V2** |
| **Password authentication** of any kind | Auth v3.0 — none exists, hashed or otherwise |
| **Email as canonical identity**, `AccountId`, `PersonId`, payment identity, uniqueness key or auto-match key | Auth v3.0 §5 |
| **Email-based recovery**, or any V1 Liboora recovery path for permanent Google-account loss | Auth v3.0 §7 — *"Version 1 has none"* |
| **A new Authentication PRD v4.0** | ⛔ outside every conferral |

⭐ **Positively required:** Google Sign-In/OIDC is the sole V1 method; the immutable Google **`sub`** is the
provider identity key; **`AccountId`** is the canonical internal Liboora identity, permanent and non-reusable;
**`PersonId`** remains `BC-10`-owned and is created atomically with the Account (`ADR-0011`); **`Unlinked`** is the
applicable successor state.

⚠ **A measured trap for authors:** `DEVELOPER_HANDOFF.md` — the baselined document that declares itself *"Read
this **First.** Before any other document, before any code"* — still states *"Authentication is a mobile number and
a one-time code"* (**8** stale references, **0** mentions of Google) and **6** further `docs/40-implementation/`
documents still cite *"Authentication PRD v2.0"* as their source. ⛔ **None is repaired by this act** (blocker
**B-6**); a specification author **MUST** prefer Auth v3.0 over any of them.

### 9.4 ⛔ ARCHITECTURE — five binding constraints

| # | Constraint | Source |
|---|---|---|
| **A-1** | ⛔⛔ **`MP-GBR-24`** — money owed by a **student to the library** (`BC-05`) and money owed by a **library to LIBOORA** (`BC-20`) *"must never share a model, a table or a metric."* ⛔ **No shared model, table or metric across that boundary, in any specification** | `MASTER_PRD.md` **L362** |
| **A-2** | ⛔ **`MP-CON-01`/`MP-CON-02` + `MP-RSK-05`** — the **Data Layer abstraction is load-bearing, not decorative.** ⛔ **No direct BaaS/Supabase call from domain code**, even though `ADR-0116`/`ADR-0124` select Supabase as the V1 runtime | `MASTER_PRD.md`; `ADR-0116`, `ADR-0124` |
| **A-3** | ⛔ **`ADR-0012` boundary checker remains a MERGE GATE.** Dependency Matrix §10.4 gates 3 and 4 *"block merge"*. ⚠ Its current baseline is deliberately red — **9 violations, 28 acknowledged debts** — and ⛔ **no specification may be written so as to require a new violation** | `ADR-0012`; Matrix §10.4 |
| **A-4** | ⛔ **The V1 architecture is a MODULAR MONOLITH.** ⛔ No microservice, no service extraction, no separate deployable. BC Map §12 names `BC-12` as the **first extraction candidate**, which is an extraction **order**, ⛔ **not an instruction to extract in V1** | `MASTER_PRD`; BC Map §12 |
| **A-5** | ⛔ **The Enterprise Architecture is Rank 6 DESCRIPTIVE ONLY** — *"Update it to match 1–5; never the reverse."* ⛔ It is **not** citable as overriding technical authority | baseline §4 Rank 6 |

---

## 10. §G — Traceability, and §H — Freeze / amendment

### 10.1 §G — Required traceability chain

Every Technical Specification **MUST** state, for every section it contains:

```
PRD requirement ID
   → Architecture / bounded context (BC Map or Matrix reference)
      → ADR decision
         → this Technical Specification section
            → (later) implementation / API / database reference
```

⭐ **`TRACEABILITY_MATRIX.md` must eventually support the `TS-*` document class** — a `TS-*` identifier inventory
section, in the pattern of its existing §2 + §2A…§2U (22 inventories).

⛔ **That matrix work is NOT performed by this act.** The matrix is currently **v1.26** and its header is measured
**stale** — it cites *"Authentication PRD v2.0"*, `BASELINE-2026-08-04-D`, and *"ADRs applied: `ADR-0001`…`ADR-0018`,
`ADR-0020`, `ADR-0032`"*, leaving **98 ADRs unlisted**. ⚠ Repairing it is **blocker B-8** of the Stage 1 audit,
belongs to the **Technical Owner**, and is ⛔ **a separate act**. Recorded as `TSG-GAP-005`, §11.

### 10.2 §H — Freeze and amendment lifecycle

| State | Meaning |
|---|---|
| **`DRAFT`** | The default on creation. ⛔ **NOT approved, NOT frozen, NOT authoritative**, and ⛔ **carries no authority whatsoever** |
| **Admitted / approved** | Becomes a **governed document** only when an **Accepted ADR** admits it, exercising Architecture Owner authority (baseline §7 rule 1). ⛔ **Status is never self-claimed** (`PRD-008` **L11**) |
| **Amendment** | Requires an **ADR before the change** (baseline §7 rule 1); the version and changelog move **in the same commit** (rule 2); the declaration is updated **in the same commit** (rule 3) |
| **Supersession** | A superseded Technical Specification is **retained, not deleted** — *"An ADR supersedes; it does not delete. The superseded record stays readable"* (`ADR-INDEX` **L207**) |
| ⛔ **Silent editing after freeze** | ⛔⛔ **PROHIBITED.** A frozen Technical Specification is amended only by the route above |
| **Citation discipline** | `ADR-0079` §8.5 **append-not-insert**: additions go **below** every cited line; amendments to cited lines are **strictly in place**; citation cost is **measured before and verified after** every write |
| **Rank on admission** | ⚠ **DEFERRED — see §8.3.** Admission makes a Technical Specification *governed*, ⛔ **not ranked** |

---

## 11. Gaps this ADR records rather than decides

⛔ **Each is OPEN with a named owning office. None is closed to make this ADR look complete.**

| Gap | Question | Required authority |
|---|---|---|
| **`TSG-GAP-001`** | Should stage `6A` ever become **mandatory** before Stage 7, and if so from which date and for which PRDs? ⛔ Deliberately non-blocking today (§4.3) | **Governance + Product Owner** |
| **`TSG-GAP-002`** | Should the §3.2 downstream ordering (database → API → UX → design → prototype → implementation) become **enforced gates**? That would alter Stage 8 | **Governance + Architecture Owner** |
| **`TSG-GAP-003`** | Should `PRD-021A` A8, `PRD-021B` B9 and `PRD-021C` C8 be re-expressed as `TS-*` documents, or remain as they are? ⛔ Untouched today (§6.1) | **Architecture + Product Owner** |
| **`TSG-GAP-004`** | What **precedence rank**, if any, does an admitted Technical Specification hold? ⛔ Explicitly deferred (§8.3) | **Architecture Owner** |
| **`TSG-GAP-005`** | `TRACEABILITY_MATRIX.md` must gain a `TS-*` inventory, and its stale header must be repaired (98 unlisted ADRs) | **Technical Owner** |
| **`TSG-GAP-006`** | Does a Technical Specification require a **new registry status**, or does `APPROVED` suffice? ⛔ No status created today (§4.2) | **Product + Governance Owner** |

---

## 12. ⛔ What this ADR does NOT do

⛔ **No Technical Specification is drafted, named, scaffolded, templated or placeheld.** ⛔ **`docs/50-technical/`
is NOT created.** ⛔ **No `TS-*` identifier is allocated** (`TS-001` remains free).

⛔ **None of the following Stage 1 blockers is resolved by this act**, and each remains OPEN with its own authority:

| Blocker | Subject | Authority |
|---|---|---|
| **B-2** | ⛔ `AUTH-7.22` permission catalogue — **still ZERO enumerated permissions** | Authorization + Product Owner |
| **B-3** | ⛔ `Q-01`, `Q-03`, `Q-04`, `Q-06` — **still OPEN**; `MP-DEP-07` still blocks **schema freeze** | Architecture + Product (+ counsel for `Q-04`) |
| **B-4** | ⛔ `PRD-008` §6.1 **L209**/**L210**/**L211**/**L213**/**L214** — divergence **recorded, NOT repaired** | Product + Architecture + Governance |
| **B-5** | ⛔ **No API style, error taxonomy, versioning or idempotency transport selected** | Architecture Owner |
| **B-6** | ⛔ `DEVELOPER_HANDOFF.md` + 6 implementation documents — **still stale on authentication** | Governance + Technical Owner |

⛔⛔ **Also NOT done, each deliberately:** ⛔ `PRD-008`, `PRD-019`, `PRD-022` **not modified** · ⛔ `PRD-018` **not
created** · ⛔ Authentication **v2.0/v3.0** and `prd-v2/`/`prd-v3/` **byte-unchanged**, ⛔ **no v4.0** · ⛔ A8/B9/C8
content and self-status **not touched** (`GCP-25` class **still OPEN**) · ⛔ `TRACEABILITY_MATRIX` **not repaired** ·
⛔ `ADR-0129` **not retroactively registered** (disclosed in `ADR-INDEX`'s Count cell by `ADR-0130`; ⛔ **still
missing**, still routed) · ⛔ **no permission, no `PERM-*`** · ⛔ **no bounded context** (still **31**), ⛔ **no edge
(`E-34` NOT allocated)**, ⛔ no port, no aggregate · ⛔ **no API style, endpoint or OpenAPI** · ⛔ **no SQL, schema,
migration or Supabase artefact** · ⛔ **no code, no test** · ⛔ **no `GCP-*` closed, no blocker discharged** · ⛔
**`A-9` not executed** · ⛔ **NOT pushed**.

---

## 13. Governance records amended by this act

⭐ **Four files, each by the smallest change that registers the new class.**

| File | Change | Why the ADR requires it |
|---|---|---|
| `PRD_LIFECYCLE.md` | **v1.0 → v1.1.** New **§7A** defining stage `6A`, appended **below** every cited line; version cell + changelog row | The stage must exist in the document that defines stages, or it does not exist |
| `PRD_REGISTRY.md` | New **§17** recording the `TS-*` namespace reservation and the `LTS-*`/`LCTS-*`/`TPA-*`/`LMT-*` non-reuse rule | §5 rule 2 requires prefixes to be registered so the next author's collision check finds them |
| `DOCUMENTATION_BASELINE.md` | §8 changelog row recording this act, and `ADR-0131` added to the §1 Authority list | §7 rule 3 — *"This declaration is updated in the same commit. A baseline that does not match the repository is worse than no baseline"* |
| `ADR-INDEX.md` | `ADR-0131` registered; `Count` cell corrected in place | `ADR-INDEX` Process rule 1 — an ADR must be registered |

### 13.1 ⚠ The baseline IDENTIFIER does not advance, and the reason is measured

⛔ **`BASELINE-2026-09-10-B` is NOT advanced by this act.**

`DOCUMENTATION_BASELINE.md` §7 **rule 4** (**L383**): *"The baseline identifier changes only when a **Rank 1–3**
document changes version."*

| Amended file | Is it Rank 1–3? | Evidence |
|---|---|---|
| `PRD_LIFECYCLE.md` v1.0 → v1.1 | ⛔ **NO** | Measured: **0** `00-governance/prd-ecosystem/` rows in baseline §3, and **0** appearances in §4's Rank 1–7 table. Its own header states *"**Process, not product.** This document governs *how* a PRD moves between states. It never governs *what* a PRD says"* |
| `PRD_REGISTRY.md` | ⛔ **NO** | same measurement |
| `ADR-INDEX.md` | ⛔ **NO** | baseline §3.1 lists it as *"Active — Authoritative"*, ⛔ not at a §4 rank |
| `DOCUMENTATION_BASELINE.md` | ⛔ **NO** | the declaration itself; §7 rule 4 keys the advance to its **subjects**, not to itself |

⭐ **No Rank 1–3 document changes version in this act, so rule 4's trigger is unmet and the identifier correctly
stays put.** This is the same determination the baseline's own §8 recorded four times for `PRD-015`, `PRD-009` and
`PRD-010` — *"unchanged — see the §7 rule 4 determination"* — and it is applied here rather than re-derived.

⚠ **One measured anomaly is disclosed, not repaired:** baseline **L326** describes *"The `IMPL-*` allocation table
in `PRD_LIFECYCLE.md` (**Rank 1**)"*, which conflicts with the measurement above. ⛔ **That cell is NOT edited** —
it is an `OPEN` gap entry about a **different** defect (the stale `IMPL-227+` row), its parenthetical is incidental,
and §4's rank table is the authoritative statement of rank. Repairing it is unrelated historical drift and
therefore outside this act.

---

## 14. Consequences

### 14.1 Positive

⭐ A Technical Specification can now lawfully exist: it has a class, a purpose, a position in the chain, a lifecycle
stage with real entry and exit gates, a collision-free identifier namespace, a canonical directory, an ownership
and attestation model, an explicit precedence order, a traceability obligation and freeze/amendment rules.

⭐ **The three existing technical parts stop being orphans** — A8, B9 and C8 become citable input and structural
precedent instead of three independent inventions.

⭐ **The two decisions most likely to be silently reversed are now bound in advance**: the `ADR-0130` cash-only V1
payment boundary and the `AUTH-7.22` closed permission catalogue. A future author cannot reintroduce a V1 gateway or
mint a permission without violating an explicit, cited clause.

### 14.2 Negative and honest

⚠ The lifecycle gains a **letter-suffixed stage** (`6A`), which is less tidy than a renumber — accepted because the
renumber would have invalidated **7,411** references across **241** files.

⚠ The class is **UNRANKED** until `TSG-GAP-004` is decided, so an admitted Technical Specification carries no
precedence authority and loses every disagreement with a ranked document by default.

⚠ ⛔ **Stage `6A` is non-mandatory, so its existence alone does not raise technical quality.** It only makes the
work possible to govern. Whether it is used, and whether it becomes required, is `TSG-GAP-001`.

⚠ ⛔ **No Technical Specification may lawfully be drafted yet in the areas that matter most.** Blockers **B-2**
(zero permissions) and **B-3** (`MP-DEP-07` schema freeze) stand, so any specification touching authorization or
persistence would have to invent what those blockers exist to protect.

---

## 15. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-10 | ⭐⭐ **Created and `Accepted`. The Technical Specification is constituted as a governed document class** — by a one-act joint conferral of **Governance Owner** and **Architecture Owner** authority; ⛔ both offices **revert on completion** (`ADR-0033` §7.1). ⭐ **Establishes:** the document class and its place in the chain (§3) · lifecycle stage **`6A`**, inserted between Stage 6 and Stage 7 with **4 entry criteria** and a **6-condition exit gate** (§4) · the **`TS-*`** identifier namespace, measured free at **0** occurrences (§5) · the **`docs/50-technical/`** directory convention (§6) · ownership via the **existing Technical Owner** role, with all offices ⛔ **VACANT and unfilled** (§7) · an explicit **4-level precedence order** and **8 prohibitions** (§8) · the traceability chain (§10.1) · and **freeze/amendment** rules (§10.2). ⚠⚠ **Stage `6A` is inserted, NOT a renumber**: a renumber was measured to invalidate **7,411 `Stage N` references across 241 files**, so the repository's own letter-suffix convention (`§6A`, `§14A`, `PRD-012a`, `PRD-021A`) was followed instead — ⭐ **0 existing references invalidated**, and §2's *"nine stages"* table is **byte-unchanged**. ⭐⭐ **Stage `6A` is OPTIONAL and NON-BLOCKING**: ⛔ it does **NOT** retroactively invalidate, reopen or re-gate the **16 frozen PRD identities** admitted before it existed, and its absence is ⛔ **NOT a defect and NOT a blocker** — mandating it would retroactively alter the Stage 7 gate every existing freeze was conferred against. ⭐ **Rank is EXPLICITLY DEFERRED** (`TSG-GAP-004`): an admitted Technical Specification is **governed but UNRANKED** and loses any disagreement with a ranked document by default, the same framing `PRD-021B` B9 adopted in `XPB-CONF-012`. ⛔⛔ **MANDATORY BOUNDARY CLAUSES bind every future Technical Specification** (§9): **PAYMENT** — `ADR-0130` V1 is **cash only**, ⛔ UPI/card/online/gateway/platform-charge/settlement are **V2**, ⛔ **no V1 settlement mechanism is required and its absence is NOT a blocker**, ⛔ **no V2 mechanism may be invented**, and ⚠ the trap is **named**: `PRD-008` **FROZEN v1.7 §6.1 L209/L210/L211/L213/L214 still say V1 and are superseded IN EFFECT by rank** — authors apply `ADR-0130`, not `PRD-008`; **AUTHORIZATION** — `AUTH-7.22` catalogue is **CLOSED**, ⛔ **enumerated permissions measured ZERO**, `PERM-*` repo-wide **2, both withdrawals**, so ⛔ **no convention exists to extend** and `ADR-0043` §5.1 (*"Do not invent a new permission ID"*) plus `AP-9` fail-closed remain binding; **AUTHENTICATION** — Auth **v3.0**/`ADR-0129` authoritative, ⛔ no V1 mobile OTP, no password, no email-as-identity, no email recovery, **no v4.0**, and ⚠ `DEVELOPER_HANDOFF.md` + **6** implementation documents are measured **stale** and ⛔ **not repaired here**; **ARCHITECTURE** — ⛔ `MP-GBR-24` `BC-05`/`BC-20` separation with **no shared model, table or metric**, ⛔ `MP-CON-01`/`02`+`MP-RSK-05` Data Layer abstraction with **no direct BaaS call from domain code**, ⛔ `ADR-0012` boundary checker **remains a merge gate**, ⛔ **modular monolith** in V1, ⛔ EA **Rank 6 descriptive only**. ⭐ **Six gaps recorded, none closed** — `TSG-GAP-001`…`006`, each with a named office. ⭐ **Four governance files amended, each minimally** (§13): `PRD_LIFECYCLE.md` **v1.0 → v1.1** (new §7A, appended below every cited line), `PRD_REGISTRY.md` (new §17 namespace reservation), `DOCUMENTATION_BASELINE.md` (§8 changelog + Authority list), `ADR-INDEX.md` (registration + Count correction). ⚠⚠ **CITATION COST: ZERO SHIFTED** — `PRD_LIFECYCLE.md` carries **682 citations across 184 files** with the highest at **L294**, and **every addition lands below it**. ⚠ **The baseline IDENTIFIER does NOT advance**: §7 rule 4 moves it only for a **Rank 1–3** version change, and all four amended files were **measured NOT Rank 1–3** (0 `prd-ecosystem` rows in §3, 0 appearances in §4's rank table) — the same determination the baseline recorded four times previously. ⚠ **One anomaly disclosed, not repaired:** baseline **L326** calls `PRD_LIFECYCLE.md` *"(Rank 1)"*, contradicting §4; ⛔ that cell is an `OPEN` entry about a different defect and is **NOT edited**. ⛔⛔ **NOTHING ELSE EXECUTED:** ⛔ **no Technical Specification drafted, named, scaffolded or placeheld** · ⛔ **`docs/50-technical/` NOT created** · ⛔ **`TS-001` NOT allocated** · ⛔ **blockers B-2, B-3, B-4, B-5, B-6 all remain OPEN** · ⛔ `PRD-008`/`PRD-019`/`PRD-022` **not modified**, `PRD-018` **not created** · ⛔ A8/B9/C8 **untouched** · ⛔ `TRACEABILITY_MATRIX` **not repaired** · ⛔ `ADR-0129` **still unregistered**, still routed · ⛔ **no permission, no `PERM-*`, no bounded context, no edge, no port, no aggregate, no API style, no endpoint, no OpenAPI, no SQL, no migration, no Supabase artefact, no code, no test** · ⛔ **no blocker closed, no `GCP-*` closed** · ⛔ **`A-9` not executed** · ⛔ **NOT pushed** — `github/main` remains `267f46e5c9b191da874553ffdfaf70dbfd3720cb`. |

---

*End of `ADR-0131`. ⭐ **Accepted** — constitutes the Technical Specification governance layer. ⛔ **Authorises no drafting.***
