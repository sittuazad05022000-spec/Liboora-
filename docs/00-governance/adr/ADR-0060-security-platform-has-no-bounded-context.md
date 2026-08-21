# ADR-0060 — The SECURITY platform has no bounded context, and Stage 1's gate is context-scoped rather than universal

| Field | Value |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-21 |
| **Deciders** | **Architecture Review Board**, acting through the **Architecture Owner** role defined in [`PRD_OWNERSHIP_MODEL.md`](../prd-ecosystem/PRD_OWNERSHIP_MODEL.md) §2.2 and §2.3 — the role that document's §2.1 derives from `ADR-INDEX.md` step 1 and baseline §7 rule 1, and that its §2.2 records as deciding *"Boundaries, ranks, permitted edges, precedence"*. Exercised by **direct conferral of the human principal of this engagement**, §7 |
| **Supersedes** | Nothing |
| **Amends** | **No ranked document's content.** No `BC-nn` is created, no Bounded Context Map cell is edited, no `E-*` edge is added, no aggregate is minted, and `PRD_LIFECYCLE.md` is **not** amended. This ADR **determines the scope of an existing gate**; it does not rewrite the gate |
| **Amended by** | — |
| **Baseline** | **No baseline re-issue.** Nothing ranked changes version. Baseline §7 rule 4 moves the identifier *"only when a Rank 1–3 document changes version"*, and no document's version moves here. `ADR-0055` and `ADR-0058` record the identical determination for their own no-version-change acts |
| **Closes** | `SECP-ADR-001` · `SECP-DEP-004` · `SECP-GAP-041` · blocker **`B7-3`** of [`PRD-012a_STAGE7_BLOCKER.md`](../../30-product/security/PRD-012a_STAGE7_BLOCKER.md) §2 |
| **Does NOT close** | `SECP-GAP-010` (whether the SECURITY platform should ever hold an aggregate) — **left open deliberately**, §5.3. Nor does it admit `PRD-012a` to the baseline; that is a separate act by a different role |
| **Opens** | `SECP-GAP-045` (§6.2) |
| **Related** | `ADR-0013` (capability-context ownership) · `MASTER_PRD.md` §8 Correction 2, **Rank 1** · `PRD_REGISTRY.md` §4.1, §6 · `PRD_LIFECYCLE.md` Stage 1 |

---

## 1. The question

`PRD-012a` Security Automation has reached Stage 6 of `PRD_LIFECYCLE.md` with **no owning bounded context**. Stage 1's
exit gate reads:

> *"**Gate:** a context identified in the Bounded Context Map, **not already owned** in `PRD_REGISTRY.md` §6."*

`PRD-012a` cannot satisfy that sentence, and `SECP-ADR-001` states the question precisely:

> *"**Does the SECURITY platform get a bounded context, or does the lifecycle exempt platform-composition PRDs?**
> Stage 1's gate cannot be met as written (`SECP-GAP-041`). `ADR-0013` assigns capability contexts; no ADR covers a
> platform with none. Stage 1's own note 'four of the nineteen Master PRD modules are compositions, not contexts'
> **suggests exemption, but that is a decision, not a reading**."*

That last clause is why this ADR exists rather than a paragraph in a gate record.

---

## 2. What was measured

Every figure below was derived from the repository during this pass, not carried from `PRD-012a`'s own prose.

| Measurement | Route | Result |
|---|---|---|
| Bounded contexts defined | `PRD_REGISTRY.md` §6, *"Verified against the Bounded Context Map's 31 contexts"* | **31** — `BC-01`…`BC-31` |
| A security context among them | Read every §6 row | **0.** `BC-28` is Workflow Orchestration. Security appears in **no** `BC-nn` row |
| Rank 1 ownership of "Security" | `MASTER_PRD.md` **L182**, §8 Correction 2 | *"'Security' is the **SECURITY platform (R2)**"* — assigned to a **platform**, explicitly not a context |
| Registry reservation | `PRD_REGISTRY.md` §4.1 | `PRD-012a` → owner **"SECURITY platform (rank 2)"**, and *"`PRD-012a`/`PRD-012b` may be opened **without a further ADR**"* |
| Master PRD modules that are **not** contexts | `MASTER_PRD.md` L171, L176 | **five** — modules **5, 10, 11, 12 and 19**; module 19 is labelled *"**not a context**"* in its own row |
| …and whether a non-context module may still carry requirements | `MASTER_PRD.md` L176 | **Yes, expressly**: module 19 owns *"no aggregate, no invariant and no business state"* and its *"Requirements are specified in `docs/30-product/library/`"* |
| Rank 3 rows scoped to something other than a `BC-nn` | `DOCUMENTATION_BASELINE.md` §4 | **1** — the Library PRD row, scoped to *"Everything inside the **Library Management domain**"*. Every other Rank 3 row reads *"Everything inside `BC-nn`"* |
| Stage 1's failure condition for question 1 | `PRD_LIFECYCLE.md` L63–74 | *"It is a **presentation composition** — dashboards, Parent Portal. No PRD"* |
| An exemption or waiver instrument in the lifecycle | `grep -niE "exempt\|waive\|waiver"` over `PRD_LIFECYCLE.md` | **0 provisions.** The only hit is L293, *"`X-13` and `ID-1` are never waived"* — a prohibition, not a mechanism |
| A role owning Stage 1 | `PRD_LIFECYCLE.md` §6 roles table | **None named.** §6 names roles for Stages 3, 4, 5, 6, 7 and 8 only |
| `PRD-012a`'s owned aggregates and invariants | Part 1 §0.5, Part 2 L74, `SECP-GAP-010` | **0 and 0**, declared and reasoned, not omitted |

### 2.1 The measurement that removed the obvious answer

`SECP-ADR-001` offers *"or does the lifecycle exempt platform-composition PRDs?"* as the alternative. **The
lifecycle has no exemption instrument to invoke.** It was searched for and it does not exist. So "record an
exemption" is not a lawful act here — it would require inventing a mechanism in a Rank 1 document, which is the
`PRD-013` failure class: `ADR-0050` §5 withdrew a blocker that had *"reasoned from a correctly measured fact… and
treated that absence as a **prohibition**. It is history, not a rule."* The inverse error — treating an absence as a
**permission** to invent a mechanism — is the same mistake pointed the other way.

---

## 3. What was considered and refused

| Option | Why refused |
|---|---|
| **Create `BC-32` Security** | ⛔ **Refused, and it is the refusal this ADR exists to make.** Three independent grounds, any one sufficient. (1) It **contradicts Rank 1**: `MASTER_PRD.md` L182 assigns Security to the SECURITY *platform*, and a Rank 2 ADR may not overturn Rank 1. (2) It **fails the Map's own admission test**: Stage 1 question 4 requires an owned aggregate *and* an invariant, and `PRD-012a` declares **neither** (`SECP-GAP-010`) — so the context would be created empty, purely to satisfy a gate. (3) It would make this ADR **the sole authority for a 32nd context** while `PRD_REGISTRY.md` §6 and the BC Map both enumerate 31, creating the second source of truth `ADR-0040` L166 forbids. **Creating a context to pass a gate is exactly the act that was prohibited** |
| **Record a "lifecycle exemption for platform PRDs"** | ⛔ Refused. §2.1 — **there is no exemption instrument in `PRD_LIFECYCLE.md` to record**. Writing one would amend a document treated as **Rank 1** by citation (baseline L298) as a side effect of admitting a module, which baseline §7 rule 1 and `PRD_LIFECYCLE.md` L177 forbid |
| **Amend `PRD_LIFECYCLE.md` Stage 1 to add a platform path** | ⛔ Refused **on scope, not on merit.** It is arguably the right long-term repair and the Architecture Owner does decide Rank 1–5 changes — but the conferral for this pass is to *resolve `PRD-012a`'s blockers*, and amending the lifecycle for every future platform PRD is a broader act than the one conferred. `ADR-0033` §7.1: *"a conferral for one act is not a standing licence."* Routed as **`SECP-GAP-045`** (§6.2) |
| **Read Stage 1's "compositions" note as already granting the exemption** | ⛔ Refused as a *reading*, and this is the subtlest refusal. The note says *"four of the nineteen Master PRD modules are compositions, not contexts"* — but its **failure row names only presentation compositions** (*"dashboards, Parent Portal"*), and its remedy for those is ***"No PRD"***. Treating that note as authorising a **platform** PRD stretches a sentence about dashboards to cover a rank-2 enforcement platform. `SECP-ADR-001` said this *"suggests exemption, but that is a decision, not a reading"* — and it was right. The determination in §4 is therefore made **as a decision, on Rank 1 authority**, not smuggled in as an interpretation |
| **Declare an aggregate for the SECURITY platform to satisfy question 4** | ⛔ Refused. No Rank 1–5 authority grants one, BC Map §8's aggregate rows grant it none, and `SECP-GAP-010` records the question as undecided. Minting an aggregate here would annex state the platform does not own in order to pass a gate |
| **Route `PRD-012a` under an existing context — `BC-18` was the tempting candidate** | ⛔ Refused. `BC-18` Identity & Access is `FROZEN` at Rank 3 as `PRD-001`, and `SECP-OWN-002` already cedes credentials, sessions, roles, permissions and policy decisions to it. Folding the SECURITY platform into `BC-18` would put threat detection, WAF/DDoS, vulnerability management and compliance programmes inside an authentication context — and would **re-create the Single Owner Rule violation** that Rank 1 Correction 2 was written to remove. Architecturally tidy, and wrong |

---

## 4. Decision

**Three findings, one determination.**

1. **The SECURITY platform does not get a bounded context.** It is a **platform**, assigned as such by Rank 1
   (`MASTER_PRD.md` L182) and reserved as such by `PRD_REGISTRY.md` §4.1. The Bounded Context Map's **31** contexts
   are unchanged, and **no 32nd is created**.

2. **`PRD-012a` is a platform-scoped specification, not a context-scoped one.** It owns **no `BC-nn`, no aggregate
   and no invariant**, and that is a structural property of its subject rather than a defect in its drafting. Part 1
   §0.5 reached the same conclusion by reading; this ADR confirms it by measurement and, unlike §0.5, has the
   standing to make it binding.

3. **`PRD_LIFECYCLE.md` Stage 1's gate is context-scoped, and does not apply to a platform-scoped specification.**
   The gate names *"a context identified in the Bounded Context Map, not already owned in `PRD_REGISTRY.md` §6"*.
   Every clause of it — *context*, *the Map*, *§6 ownership* — is about contexts. A document that owns no context
   does not fail this gate; **the gate does not reach it.**

**Consequently: Stage 1 is `NOT APPLICABLE` for `PRD-012a`, and `SECP-GAP-041` is closed on that basis.** The
lifecycle's substantive Stage 1 concern — *"the commonest wrong outcome is a PRD that should not exist"* — is
answered **affirmatively and independently** by Rank 1: `MASTER_PRD.md` §8 Correction 2 requires this document to
exist, and `PRD_REGISTRY.md` §4.1 records that it *"may be opened without a further ADR"*. The question Stage 1
exists to ask has an answer; it simply is not obtained by the context test.

### 4.1 What this determination rests on

| Ground | Source | Rank |
|---|---|---|
| "Security" belongs to a platform, not a context | `MASTER_PRD.md` **L182**, §8 Correction 2 | **1** |
| A single name spanning two owners at two ranks violates the Single Owner Rule — hence the split | `MASTER_PRD.md` **L182** citing EA §10.1.1 | **1** |
| A non-context module may still carry specified requirements | `MASTER_PRD.md` **L171**, **L176** — five such modules, module 19 explicitly | **1** |
| `PRD-012a` may be opened without a further ADR | `PRD_REGISTRY.md` §4.1 | unranked, tracing to Rank 1 |
| A Rank 3 row need not be scoped to a `BC-nn` | `DOCUMENTATION_BASELINE.md` §4 — the domain-scoped Library row | **1** |
| Context ownership is distinct from aggregate ownership | `ADR-0013` §2, §5 | **2** |
| Boundaries and ranks are the Architecture Owner's to decide | `PRD_OWNERSHIP_MODEL.md` §2.2 | unranked, derived from baseline §7 rule 1 |

### 4.2 What it does **not** rest on

- **Not** on the absence of precedent. No argument of the form *"no platform PRD has ever been baselined, therefore
  none may be"* — nor its inverse — appears here. `ADR-0050` §5 is the standing warning against both.
- **Not** on Stage 1's "compositions" note, which was examined and found to be about **presentation** compositions
  (§3).
- **Not** on convenience. The determination that a gate does not reach a document is narrower than a finding that
  the document passes it, and it is stated in the narrower form on purpose.

---

## 5. What this ADR deliberately does not do

### 5.1 It does not amend `PRD_LIFECYCLE.md`

Stage 1 still reads exactly as it did. The **next** platform PRD will meet the identical structural problem and will
need either this determination cited or the lifecycle repaired. That is `SECP-GAP-045`, and it is left open rather
than pre-emptively fixed, because fixing it is a broader act than the one conferred.

### 5.2 It does not admit `PRD-012a` to the baseline

Stage 7 is a **Governance Owner** act (`PRD_LIFECYCLE.md` §6 L282) and requires its own ADR and a
`DOCUMENTATION_BASELINE.md` §3 row. *"Freeze is conferred, not claimed."* Closing `B7-3` removes one of four
blockers; it confers nothing.

### 5.3 It does not decide `SECP-GAP-010`

Whether the SECURITY platform should **ever** hold an aggregate is a live question and is left open. Answering it
was not necessary: the determination above turns on what the platform owns **today**, which is measurable, not on
what it ought to own, which is not.

### 5.4 It verifies no code

No file under `lib/`, `packages/`, `test/`, `web/` or `tool/` is touched. **0 lines.** `lib/platform/security/`
does not exist, which is recorded in `ADR-0062` where it is load-bearing.

---

## 6. Findings

### 6.1 Findings this pass accepted

| # | Finding | Disposition |
|---|---|---|
| `A-1` | `PRD-012a` owns no `BC-nn`, no aggregate and no invariant | **Accepted as structural.** §4 finding 2 |
| `A-2` | Stage 1's gate cannot be satisfied by any platform-scoped PRD, present or future | **Accepted.** Resolved for `PRD-012a` by §4; the general case is `SECP-GAP-045` |
| `A-3` | The lifecycle has **no** exemption instrument | **Accepted**, and it changed the shape of this ADR — see §2.1 |
| `A-4` | Stage 1 has **no owner** in `PRD_LIFECYCLE.md` §6 | **Accepted and disclosed.** The Architecture Owner acts here because Stage 1's gate is entirely about contexts and boundaries (`PRD_OWNERSHIP_MODEL.md` §2.2), not because §6 names the role. Stated so a reader can test the inference rather than assume it |

### 6.2 `SECP-GAP-045` — opened, not closed

> **`SECP-GAP-045`** — `PRD_LIFECYCLE.md` Stage 1's gate is context-scoped and admits no platform-scoped PRD. This
> ADR determines that the gate does not *reach* `PRD-012a`; it does not repair the gate. Every future platform PRD
> — the DATA, OBSERVABILITY, INFRASTRUCTURE and DEVOPS platforms all appear as owners in `PRD-012a` §9 — will meet
> the same wall. **Owner: Architecture Owner.** **Remedy:** a Stage 1 amendment adding a platform path, under its
> own ADR per baseline §7 rule 1. **Priority: P2** — it misconfers nothing and blocks nothing that is currently in
> flight.

### 6.3 What was **not** opened

No gap is opened for the 31-vs-32 context count, because the count does not change. No gap is opened against
`MASTER_PRD.md`, whose Correction 2 is the authority relied on and is correct as written.

---

## 7. Authority

The authority is a **direct, explicit conferral by the human principal of this engagement**, instructing that the
Stage 7 blockers be resolved *"using the repository's actual authorities and lifecycle"* and specifically that
`SECP-ADR-001` be resolved *"through the **Architecture Owner's authority**"*.

**That instruction is the authority, and it is the only authority claimed.** This follows the form `ADR-0033` §7.2
records for the identical situation:

> *"A second, explicit conferral was made by the human principal of this engagement… **That instruction is the
> authority, and it is the only authority claimed.** It is a *separate* act of conferral."*

**This conferral is not a standing grant** (`ADR-0033` §7.1 — *"a conferral for one act is not a standing
licence"*). It authorises the determination in §4 and nothing wider, which is why §5.1 declines the lifecycle
amendment and §5.3 leaves `SECP-GAP-010` open.

### 7.1 What is **not** claimed

- **No ARB meeting** was held, minuted or attended. No quorum, attendee list or sign-off date exists.
- **No Security review** and **no Principal Enterprise Architect approval** were obtained.
- **No product-owner signature.**
- **This ADR does not freeze `PRD-012a`.** Stage 7 is a separate act by a different role requiring an admitting ADR
  and a baseline §3 row.
- **The instruction explicitly forbade inventing a bounded context**, and §3 records that refusal as the central act
  rather than presenting it as a discovery.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-21 | Created `Accepted`. Determines that the **SECURITY platform has no bounded context** and that **`PRD_LIFECYCLE.md` Stage 1's gate is context-scoped and does not reach a platform-scoped specification** — so Stage 1 is **`NOT APPLICABLE`** for `PRD-012a` and `SECP-GAP-041` closes on that basis, along with `SECP-ADR-001`, `SECP-DEP-004` and blocker **`B7-3`**. ⭐ **The central act is a refusal:** creating `BC-32 Security` was available, would have made the gate pass immediately, and is **refused on three independent grounds** — it contradicts **Rank 1** `MASTER_PRD.md` **L182** (which assigns Security to a *platform*), it fails the Map's own admission test (`PRD-012a` declares **0 aggregates and 0 invariants**, `SECP-GAP-010`), and it would make a Rank 2 ADR the sole authority for a 32nd context against two documents that enumerate 31. ⚠ **The obvious alternative was measured and found not to exist:** `SECP-ADR-001` offered *"or does the lifecycle exempt platform-composition PRDs?"*, and a search of `PRD_LIFECYCLE.md` returned **0 exemption or waiver provisions** — so "record an exemption" was not a lawful act, and the determination is framed as **gate scope** instead. ⚠ **Stage 1's 'compositions' note was tested as a shortcut and rejected**: its failure row names only **presentation** compositions (*"dashboards, Parent Portal"*) and prescribes *"No PRD"*, so reading it as authorising a rank-2 enforcement platform stretches a sentence about dashboards — `SECP-ADR-001`'s own warning that this *"suggests exemption, but that is a decision, not a reading"* is upheld rather than quietly ignored. ⚠ **Folding `PRD-012a` into `BC-18` was considered and refused** because it would re-create the Single Owner Rule violation Rank 1 Correction 2 exists to remove. ⚠ **Stage 1 has no owner in `PRD_LIFECYCLE.md` §6** — disclosed as finding `A-4`, with the Architecture Owner's standing derived from `PRD_OWNERSHIP_MODEL.md` §2.2 rather than asserted. **Amends no ranked document's content: 0 `BC-nn` created, 0 BC Map cells, 0 `E-*` edges, 0 aggregates, 0 requirements moved, `PRD_LIFECYCLE.md` byte-unchanged, no baseline re-issue (§7 rule 4), 0 lines of code.** **Opens `SECP-GAP-045`** — the general platform-PRD case, routed to the Architecture Owner and **not** pre-emptively repaired, because amending Stage 1 for all future platform PRDs is broader than the act conferred (`ADR-0033` §7.1). ⛔ **Confers no freeze**, closes neither `SECP-GAP-010` nor the remaining three blockers, and verifies no code |
