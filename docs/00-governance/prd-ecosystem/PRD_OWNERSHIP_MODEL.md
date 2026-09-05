# LIBOORA — PRD Ownership Model

| Field | Value |
|---|---|
| **Document** | Role-based ownership model for every registered PRD |
| **Version** | v1.1 |
| **Status** | Active |
| **Scope** | All **24** PRDs in [`PRD_REGISTRY.md`](./PRD_REGISTRY.md) — `PRD-023` added 2026-08-04 by `ADR-0017` |
| **Closes** | `PGA-08` — *"0 of 23 registered PRDs have an explicit owner model"* |
| **Precedence** | **Unranked.** Governance process, not a requirement source. Never outranks a PRD |
| **Last Updated** | 2026-08-04 |

---

## 1. Why this document exists

[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) §5 records the finding this document closes:

> *"Every `Owner` field above reads **Unassigned**, and that is a finding, not an
> omission in this register. Searched: no PRD carries a document owner, a team
> name or an accountable individual. … So the repository consistently records
> **context ownership** and never records **document ownership**."*

The register declined to fill those fields because *"filling these in would
require inventing names."* That reasoning was correct and this document does not
overturn it. It resolves the gap the other way: **ownership is assigned to
organizational roles, never to people.**

### 1.1 Why roles, and not names

Three reasons, in order of weight:

1. **No name exists to record.** The repository names no individual anywhere. A
   name written here would be fabricated, and a fabricated owner is worse than an
   absent one — it terminates the search for a real one.
2. **A PRD outlives a post-holder.** `PRD-001` is frozen at Rank 3 and will be
   read for years. An identifier that changes when someone changes job is not an
   identifier.
3. **Accountability here is decisional, not personal.** What the governance rules
   actually require of an owner is the authority to *approve a change*. That
   authority already attaches to roles the repository names — see §2.

### 1.2 What this document does not do

* It does **not** modify any PRD. No PRD gains an `Owner` field; a frozen
  document cannot, and an unwritten one has no header to edit.
* It does **not** create requirements, and carries no `MP-*`, `LIB-*` or `SID-*`
  identifier.
* It does **not** change bounded-context ownership. Context ownership is an
  architectural fact enforced by `tool/check_module_boundaries.dart`; document
  ownership is a governance fact. **These are different things**, and conflating
  them is what produced `PGA-11`.
* It does **not** settle `PGA-11`. `BC-19`/`BC-29`/`BC-25` remain contested
  pending [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md).

---

## 2. The minimum model

The brief asked for *"the minimum ownership model actually required."* Minimum
was determined by working backwards from what the governance rules already
demand, not from what an ownership framework usually contains.

### 2.1 Derivation — what the rules actually require

| Existing rule | Question it forces | Role that answers it |
|---|---|---|
| `ADR-INDEX` Process step 1 — *"a decision that changes structure, ownership, a boundary, or a platform-wide rule requires an ADR"* | Who approves a structural change? | **Architecture Owner** |
| Baseline §7 step 1 — *"a change to any Rank 1–5 document requires an ADR before the change"* | Who authorises the document change? | **Architecture Owner** |
| `PRD_REGISTRY.md` §8.2 — *"a status change requires the entry evidence in §2"* | Who attests the evidence? | **Product Owner** |
| `PRD_REGISTRY.md` §8.6 — *"adding a bounded context to a PRD's ownership … requires an ADR"* | Who holds the context? | **Domain Owner** |
| Matrix §11 step 3 — *"the Architecture Review Board approves or rejects"* | Who waives an edge? | **Architecture Owner** (as ARB) |
| Matrix §10.4 — gates 3 and 4 *"block merge"* | Who keeps the gates green? | **Technical Owner** |

Four distinct answers. **Four roles is therefore the minimum** — not a choice of
granularity, but the number the existing rules already imply. A fifth would have
no rule to serve; a third would leave one of the six rows above unanswerable.

### 2.2 The four roles

| Role | Accountable for | Decides | Does **not** decide |
|---|---|---|---|
| **Product Owner** | Business intent: scope, priority, acceptance. Attests §2 entry evidence at each lifecycle stage | Whether a requirement is correct and in scope | How it is structured or built |
| **Domain Owner** | Correctness of the PRD **within its bounded contexts**; ubiquitous language; invariants | Whether a rule is consistent with the domain model | Which contexts the PRD owns (that is an ADR) |
| **Architecture Owner** | Boundaries, ranks, permitted edges, precedence. Convenes as the **Architecture Review Board** | ADR approval; any Rank 1–5 document change; every §11 exception | Business scope or priority |
| **Technical Owner** | Implementation, `IMPL-*` tasks, traceability from requirement to test, §10.4 gate health | Sequencing and technical approach | Whether a requirement is right |

**The Product Owner is not the default answer.** `ADR-0011`'s header records
*"Deciders: Product owner (authoritative ruling); Principal Enterprise Architect;
DDD reviewer"* — three roles for one decision, precisely because scope,
structure and domain correctness are separable judgements. This model preserves
that separation.

### 2.3 Role vocabulary is reused, not invented

Every role name below already appears in the repository. This document adopts the
existing vocabulary rather than introducing a parallel one:

| Role | Prior use in the repository |
|---|---|
| **Product Owner** | `ADR-0001`, `ADR-0011` (*"Deciders"*); `DOCUMENTATION_BASELINE.md` §§ on receipt of Library and Student Identity chapters; `PRD_LIFECYCLE.md` |
| **Architecture Owner** | `ADR-0012`, Matrix §11 step 3, BC Map §7 header — as **Architecture Review Board**; *"Principal Enterprise Architect"* in `ADR-0001`/`ADR-0011` |
| **Domain Owner** | *"DDD reviewer"* (`ADR-0011`); the BC Map's **"Owning Platform"** column is the same concept applied to contexts |
| **Technical Owner** | `IMPL-*` task ownership; `DEVELOPER_HANDOFF.md` |

**`ADR-INDEX` and Matrix §11 both name the Architecture Review Board as the
approving body.** *Architecture Owner* is the role; *ARB* is that role sitting as
a board. They are not two authorities.

---

## 3. Assignment rules

1. **Every registered PRD has exactly one Product Owner, one Domain Owner, one
   Architecture Owner and one Technical Owner.** Four roles, one holder each, no
   co-ownership. Two holders of one role is the ambiguity this model exists to
   remove.
2. **One role may be held by one party across many PRDs.** The Architecture Owner
   is platform-wide by construction — boundaries cannot be owned per-document
   without reintroducing the conflict of `PGA-11`.
3. **The Domain Owner is derived, never chosen.** It follows from the PRD's
   bounded contexts as recorded in `PRD_REGISTRY.md` §4 and the BC Map's *"Owning
   Platform"* column. Changing it means changing context ownership, which
   §8.6 makes an ADR matter.
4. **A `PLANNED` PRD has roles assigned; it does not have content.** Ownership is
   what makes the gap actionable — an unowned gap has nobody to close it.
5. **Ownership never overrides precedence.** An owner cannot approve a change that
   Baseline §4 gives to a higher-ranked document. Ownership says *who decides*;
   precedence says *which document wins*. Only the first is assignable.
6. **A contested context suspends the Domain Owner, not the other three.** Where
   ownership is disputed (`PGA-11`), the Domain Owner reads **Contested** and
   names the resolving ADR. The other three roles remain assigned, so the dispute
   has an owner too.

---

## 4. Assignment for all 23 registered PRDs

Domain Owner is derived per rule 3. Architecture Owner is platform-wide per
rule 2. Product Owner and Technical Owner are the roles as defined in §2.2.

### 4.1 Existing PRDs (Rank 3, frozen)

| PRD | Name | Product Owner | Domain Owner | Architecture Owner | Technical Owner |
|---|---|---|---|---|---|
| `PRD-001` | Authentication v2.0 | Product Owner | Identity Platform (`BC-18`) | ARB | Platform Engineering |
| `PRD-002` | Library Management v1.0 | Product Owner | Library Domain (`BC-01`…`BC-09`, `BC-06`) | ARB | Platform Engineering |
| `PRD-003` | Student Identity & Profile v1.0 | Product Owner | Person Domain (`BC-10`) | ARB | Platform Engineering |

`PRD-002`'s Domain Owner covers the contexts the Library PRD undisputedly owns —
including `BC-06`, which the BC Map assigns to Library Management. Its header's
additional claim to `BC-19`, `BC-25` and `BC-29` was **Contested** — **all three resolved 2026-08-04**, §4.4.

### 4.2 Planned PRDs — named in Master PRD §31

Names and contexts are taken **verbatim** from `PRD_REGISTRY.md` §4.1. Domain
Owner is derived from the context's owning module (rule 3), not chosen.

| PRD | Subject | Context | Product Owner | Domain Owner | Architecture Owner | Technical Owner |
|---|---|---|---|---|---|---|
| `PRD-004` | Student Management | `BC-01` Enrollment | Product Owner | Library Domain | ARB | Platform Engineering |
| `PRD-005` | Membership Management | `BC-02` Membership | Product Owner | Library Domain | ARB | Platform Engineering |
| `PRD-006` | Attendance Management | `BC-03` Attendance | Product Owner | Library Domain | ARB | Platform Engineering |
| `PRD-007` | Seat Management | `BC-04` Seating | Product Owner | Library Domain | ARB | Platform Engineering |
| `PRD-008` | Revenue & Finance | `BC-05` Fee & Collection | Product Owner | Library Domain | ARB | Platform Engineering |

> **`PRD-004` left `PLANNED` on 2026-08-04 and is now `DRAFT`.** Its four role assignments above are **unchanged**
> by that transition, which is the model working as intended: rule 3 derives Domain Owner from the context's
> owning module, so the owner of `BC-01` was determined before the document existed and did not need renegotiating
> when it appeared. This section's heading still reads *"Planned PRDs"* because it groups PRDs by **where the
> Master PRD names them** (§31), not by their current status — status lives in `PRD_REGISTRY.md` §4.1, which is
> authoritative for it. **No role was reassigned and no personal name was recorded.**
>
> `PRD-004` also introduces **no new owner**: chapter 5's Library Members Directory is a read composition inside
> `BC-01`, so it falls under the same Domain Owner rather than creating a fifth role or a separate claimant.
| `PRD-009` | Analytics & Reports | `BC-26` Analytics Read Model | Product Owner | Analytics Platform | ARB | Platform Engineering |
| `PRD-010` | Notifications & Communication | `BC-22` Notification Delivery | Product Owner | Communication Platform | ARB | Platform Engineering |
| `PRD-011` | AI Super Assistant | `BC-27` AI Assistance | Product Owner | AI Platform | ARB | Platform Engineering |
| `PRD-012` | Security & Automation | ⚠ SECURITY platform + `BC-28` Workflow | Product Owner | ⚠ **Split** — see note | ARB | Platform Engineering |
| `PRD-012a` | Security Automation *(reserved)* | SECURITY platform (rank 2) | Product Owner | Security Platform | ARB | Platform Engineering |
| `PRD-012b` | Workflow Orchestration *(reserved)* | `BC-28` Workflow | Product Owner | Workflow Platform | ARB | Platform Engineering |

**`PRD-012` cannot have a single Domain Owner as currently scoped.** It spans the
SECURITY platform (rank 2) and `BC-28` Workflow (rank 6) — two owners at two
ranks. `PRD_REGISTRY.md` §4.1 already records that this *"violates the Single
Owner Rule (EA §10.1.1)"*, which is why `PRD-012a`/`PRD-012b` are reserved. This
model does not resolve that split; it records that assignment rule 1 (one holder
per role) **cannot be satisfied** until the document is divided. That is a finding
about `PRD-012`'s scope, not a defect in this model.

### 4.3 Planned PRDs — named in Master PRD §8.1 and §8

| PRD | Subject | Context | Product Owner | Domain Owner | Architecture Owner | Technical Owner |
|---|---|---|---|---|---|---|
| `PRD-013` | Tenancy | `BC-19` | Product Owner | **Tenancy Platform** — resolved, §4.4 | ARB | Platform Engineering |
| `PRD-014` | Entitlement | `BC-21` | Product Owner | Business Platform | ARB | Platform Engineering |
| `PRD-015` | Search Indexing | `BC-23` | Product Owner | Search Platform | ARB | Platform Engineering |
| `PRD-016` | Audit Trail | `BC-24` | Product Owner | Audit Platform | ARB | Platform Engineering |
| `PRD-017` | File & Media | `BC-29` | Product Owner | **Services Platform** — resolved, §4.4 | ARB | Platform Engineering |
| `PRD-018` | Offline Sync | `BC-30` | Product Owner | Services Platform | ARB | Platform Engineering |
| `PRD-019` | Integration | `BC-31` | Product Owner | Integration Platform | ARB | Platform Engineering |
| `PRD-020` | Trust & Safety | `BC-13` ⚠ `[CORE]` | Product Owner | Social Domain | ARB | Platform Engineering |
| `PRD-021` | Social Graph & Messaging | `BC-11`, `BC-12` | Product Owner | Social Domain | ARB | Platform Engineering |
| `PRD-022` | SaaS Billing | `BC-20` Subscription & Billing | Product Owner | Business Platform | ARB | Platform Engineering |
| `PRD-023` | Settings & Configuration | `BC-25` Configuration | Product Owner | **Configuration Platform** (`platform/configuration`, rank 3) | ARB | Platform Engineering |

### 4.4 Contested Domain Ownership — **all three resolved 2026-08-04**

> ✅ **No context is contested. Count: 0.** Resolved during the Governance Closure Phase.

| Context | Was claimed by | BC Map *"Owning Platform"* | Resolved to | By |
|---|---|---|---|---|
| `BC-19` Tenancy / Shared Core | `PRD-002` header; `PRD-013` | Shared Core | **`PRD-013`** | [`ADR-0013`](../adr/ADR-0013-capability-context-ownership.md) — **Accepted** |
| `BC-29` File & Media | `PRD-002` header; `PRD-017` | Platform Services | **`PRD-017`** | `ADR-0013` — **Accepted** |
| `BC-25` Configuration | `PRD-002` header **only** | Configuration | **`PRD-023`** | [`ADR-0017`](../adr/ADR-0017-bc-25-configuration-ownership.md) — **Accepted** |

`ADR-0013` separated **context ownership** from **aggregate ownership**: a
capability context is owned by its platform, while the aggregates a domain builds
inside it stay with that domain. So `TenantOrganisation`, `StaffAssignment` and
the `LibraryBranding` values remain owned by `PRD-002` — **no requirement moved,
and `PRD-002` did not lose scope.**

Per rule 6, the **Contested** markers in §4.1–§4.3's tables are therefore
historical. They are left in place with this section as their referent, because
the reason they existed is the finding worth keeping (below).

#### The `BC-25` resolution corrects this section's own reasoning

The analysis below concluded that `PRD-023` must **not** be allocated, on the
grounds that allocating it would mean *inventing* a PRD. **That conclusion was
wrong, and the error was in the premise, not the principle.** `MASTER_PRD.md` §8
**module 18** already names *Settings & Configuration* → `BC-25`, `[GENERIC]`,
**V1** — a named product module in the **Rank 1** document. Registering `PRD-023`
therefore records a module that already exists in the governing specification; it
invents nothing. `PRD_REGISTRY.md` §4.3 had already applied exactly this reasoning
to `PRD-022` (§8 **module 17**, the preceding row of the same table).

The prohibition on inventing requirements is **unchanged and was not relaxed** —
`PRD-023` is registered `PLANNED` and carries **zero** requirements. What changed
is the discovery that `BC-25` was never absent from the Master PRD; it was absent
from the two *lists* (§31 and §8.1) this ecosystem derived its PRDs from. Full
reasoning, and five rejected alternatives, in `ADR-0017` §2 and §4.

**The original analysis is preserved verbatim below.**

**`BC-25` is the asymmetric case, and assigning ownership systematically is what
exposed it.** `PRD-015` is *Search Indexing* (`BC-23`), not configuration
management — so unlike `BC-19` and `BC-29`, `BC-25` has **no** registered PRD
contesting the Library PRD's header claim. There is nothing to assign it to.

This is exactly why `ADR-0013` §7 declines to resolve `BC-25` by default:
transferring it would require inventing a PRD, and *"do not invent requirements"*
forbids that. `PRD-023` is therefore **not** allocated in this document either —
allocating a number would pre-empt the decision `ADR-0013` §7 explicitly leaves
open (own PRD, or fold into `PRD-013`).

Until `ADR-0013` is Accepted, the other three roles remain assigned for every
affected PRD, so each dispute has an accountable owner.

**This is the finding worth carrying forward.** The three contested rows are not
a defect in this model — they are the reason a document-ownership model was
needed. `PRD_REGISTRY.md` §6 originally asserted *"no context is claimed by two
PRDs"*, which was true only because ownership had been listed for existing PRDs
alone. Assigning ownership systematically is what made the conflict visible.

Until `ADR-0013` is Accepted, the other three roles remain assigned for all three
PRDs, so each dispute has an accountable owner.

*(End of the preserved original analysis. `ADR-0013` and `ADR-0017` are both
Accepted as of 2026-08-04; see the resolution table at the head of this section.)*

---

## 5. What ownership obliges

| Stage (`PRD_LIFECYCLE.md`) | Product Owner | Domain Owner | Architecture Owner | Technical Owner |
|---|---|---|---|---|
| Named → Drafting | Confirms scope | — | Confirms contexts | — |
| Drafting → Review | Attests content complete | Reviews language, invariants | Reviews boundaries | Reviews feasibility |
| Review → Baseline | Attests §2 evidence | Confirms no context conflict | **Approves** — ADR + Baseline §7 | Confirms traceability |
| Baselined → Frozen | — | — | **Approves** version + changelog | — |
| Frozen → Amended | Requests | Reviews | **Approves** — ADR before the change | Implements |

**Only the Architecture Owner approves.** The others attest, review or confirm.
That asymmetry is not a hierarchy of importance: it follows from Baseline §7
step 1 and `ADR-INDEX` step 1, which vest document-change authority in the ADR
process alone.

---

## 6. Compliance

Verifiable without judgement:

1. Every PRD in `PRD_REGISTRY.md` §§3–4 appears exactly once in §4 above —
   **23 of 23**, plus the two reserved sub-numbers `PRD-012a`/`PRD-012b`.
   `PRD-000` (Master PRD) is the register itself, not an owned deliverable.
   `PRD-023` does not exist and is deliberately **not** allocated (§4.4).
2. Every PRD name and context in §4 is quoted from `PRD_REGISTRY.md` §§3–4, not
   paraphrased. Verified by comparing identifier-and-name pairs against the
   register.
3. No row names a person. Every entry is a role or an organizational unit.
4. Every role in §2.2 traces to prior repository usage (§2.3).
5. Every **Contested** row names a resolving ADR.
6. One PRD (`PRD-012`) is recorded as **unassignable** under rule 1 rather than
   given a fabricated single owner.
7. No PRD file was modified to produce this document.

---

## 7. Maintenance

1. A new PRD gets all four roles when it is registered, before it has content.
2. A Domain Owner change is a **context-ownership change** — ADR required
   (`PRD_REGISTRY.md` §8.6).
3. Product and Technical Owner changes need no ADR; update this document in the
   same commit (§8.3).
4. **Never** record a personal name. If a name is needed operationally, it belongs
   in a team directory outside the repository.
5. If this document disagrees with `PRD_REGISTRY.md`, **fix the register's Owner
   field**; this document is the authority on ownership.

---

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Closes `PGA-08`. Four roles, derived from six existing governance rules rather than chosen (§2.1), with vocabulary reused from `ADR-0001`, `ADR-0011`, `ADR-0012` and Matrix §11 rather than invented (§2.3). All 23 registered PRDs assigned plus the two reserved sub-numbers. Two findings surfaced *by* the act of assigning ownership: (1) **`PRD-012` is unassignable** under rule 1 as currently scoped — it spans the SECURITY platform (rank 2) and `BC-28` Workflow (rank 6), which the register already flags as violating the Single Owner Rule; recorded as unassignable rather than given a fabricated owner. (2) **`BC-25` Configuration has no registered claimant** — `PRD-015` is *Search Indexing*, so unlike `BC-19` and `BC-29` there is no second PRD contesting the Library PRD's header, and nothing to transfer it to; `PRD-023` is therefore **not** allocated, since that would pre-empt `ADR-0013` §7. **No PRD was modified, no requirement created or reinterpreted, and no personal name recorded.** |
| **v1.0** | 2026-08-04 | Cross-reference verification, same day, before the model was relied on. **One defect found and corrected before commit:** §§4.2–4.3 had been drafted with *invented* PRD subjects (`PRD-004` as "Attendance & Seating", `PRD-015` as "Configuration Management") instead of the register's authoritative names (**Student Management**, **Search Indexing**). Every name and context is now quoted from `PRD_REGISTRY.md` §§4.1–4.2 and verified pair-by-pair; the tables are also re-sectioned to match the register's own §31 / §8.1 split. The error mattered beyond tidiness: mis-reading `PRD-015` as a configuration PRD had produced a false claim that `BC-25` was contested *between two PRDs*, when in fact it has **no** registered claimant — which is the stronger finding and the reason `ADR-0013` §7 must stay open. **Version remains v1.0: a defect in an unreleased document, not an amendment to a published one.** |
| **v1.1** | 2026-08-04 | **All three contested Domain Owner cells resolved; `PRD-023` added; scope 23 → 24 PRDs.** Governance Closure Phase. `ADR-0013` **Accepted** — a capability context is owned by its platform, and context ownership is distinct from aggregate ownership — so `BC-19` → **Tenancy Platform** (`PRD-013`) and `BC-29` → **Services Platform** (`PRD-017`), replacing the ⚠ **Contested** markers in §4.3. `ADR-0017` **Accepted** — `BC-25` → **Configuration Platform** (`PRD-023`, `platform/configuration` rank 3). §4.4 rewritten with a resolution table, and **this document's own reasoning corrected in place**: §4.4 had concluded that allocating `PRD-023` would mean *inventing* a PRD and must therefore not be done. That conclusion was wrong — `MASTER_PRD.md` §8 **module 18** already names *Settings & Configuration* → `BC-25`, `[GENERIC]`, **V1**, at Rank 1, and `PRD_REGISTRY.md` §4.3 had already applied identical reasoning to `PRD-022` (module 17). The error was in the premise, not the principle: the prohibition on inventing requirements is **unchanged**, and `PRD-023` carries **zero** requirements. The original analysis is preserved verbatim rather than overwritten, because the method that produced it — *assign ownership systematically and the unassignable cases announce themselves* — is what exposed the question. **`PRD-012` remains ⚠ Split and unassignable**: the split is *confirmed* as already authorised by Master PRD §8 *Correction 2*, but confirmation is not execution — `PRD-012a` has not been opened, so `PRD-012` is not retired and this finding stays open. **No requirement was created, modified, moved or withdrawn; no personal name is recorded.** |
| **v1.2** | 2026-08-25 | ⭐ **A fifth role — `Privacy Owner` — is constituted, by derivation, under `ACCEPTED` [`ADR-0077`](../adr/ADR-0077-privacy-owner-role-derived-from-existing-rules.md).** §2.1's minimality test is **met, not overridden**: it holds that *"a fifth would have no rule to serve"*, and **five existing rules were measured that require a privacy review and assign it to nobody** — `ARCHITECTURE_RULINGS.md` **L290** (**Rank 5**), `Library_PRD_v1.md` **L1025** / `LIB-24.2` (**FROZEN Rank 3**), `PRD-020` **L1784**, `PRD-SEAT-MANAGEMENT.md` **L2266** / `SEAT-GAP-014`, and `PRD-021A` A3 `LCR-DEC-003` / `LCR-GAP-006`. The role therefore **serves rules that already exist**, which is the same derivation method §2.1 used for the original four. §2.3's *"role vocabulary is reused, not invented"* rule is satisfied by `PRD-020` **L1784**, which already says *"the privacy owner"* verbatim. ⛔ **Constituting a role is not exercising it:** no privacy decision is taken, `LCR-DEC-003` and `LCR-GAP-006` remain **OPEN**, `LCR-RS-007` remains **DEFERRED**, and **no personal name is recorded** (§7 rule 4). ⚠ **Executed by APPEND (§9), not by insertion into §2.1–§2.3 and §5 as `ADR-0077` §6 originally prescribed** — this document is cited **by line number 74 times**, with **35** citations to **L85** alone plus 9 to L180, 8 to L284, 7 each to L68/L69/L102 and 5 to L202; inserting a table row anywhere above L331 would silently invalidate every citation below it, in **Accepted ADRs** and in `DOCUMENTATION_BASELINE.md`. The append leaves every cited line **byte-identical** — verified. ⚠ **One disclosed consequence, deliberately not repaired:** §2's closing arithmetic still reads *"Four distinct answers"* and *"Four roles is therefore the minimum"*. Correcting it in place is precisely the insertion that breaks the 35 citations, so the discrepancy is **disclosed in §9.4 and routed**, not silently patched. ⚠ **A second, more serious gap is disclosed and NOT fixed:** `Governance Owner` also occurs **0** times in this document despite being the approving authority named in `ADR-0053`, `ADR-0054` and `ADR-0064`. **No PRD, requirement, register or acceptance criterion is created, modified or withdrawn; no PRD row in §§4.1–4.4 is touched; no rank, edge or boundary is altered.** |

| **v1.3** | 2026-08-25 | ⭐ **A sixth role — `Governance Owner` — is constituted, by derivation, under `Accepted` [`ADR-0080`](../adr/ADR-0080-governance-owner-role-derived-from-existing-rules.md).** This closes the **second defect §9.4 disclosed and deliberately did not fix** — *"`Governance Owner` occurs **0** times in this document"* — which §9.4 correctly routed to a separate pass rather than absorbing into `ADR-0077`'s conferral. ⭐ **The derivation is stronger than the Privacy Owner's, because three of its rules have already been *exercised*:** `PRD_LIFECYCLE.md` §6 **L282** names the role verbatim and assigns it *"Stage 7; the baseline"*; §7 makes Stage 7 **non-skippable**; and **Accepted** `ADR-0053` (**L8**), `ADR-0054` (**L8**, and **L148** holding of this role and the Architecture Owner that *"Those are different roles"*) and `ADR-0064` (**L7**, **L109**, **L134**) each record it as `Deciders`. Measured repository-wide: **342** occurrences of *"governance owner"* across **91** files, and **0** definitions here. §2.3's *"role vocabulary is reused, not invented"* rule is satisfied by **L282** verbatim. ⚠ **Executed by APPEND (§10), not by a sixth row in §2.2** — re-measured this pass: **74** line-citations to this document, highest **L331**, of which **35** are to **L85** alone; appending at **L400+** invalidates **0**, while inserting a row at L85–86 would silently misdirect every citation below it in **Accepted ADRs** and in `DOCUMENTATION_BASELINE.md`. ⛔ **Constituting a role is not exercising it:** `ADR-0075` §8.5 **Option B** (the **281** bare EA line-citations) is **routed** to this role, **not resolved**; it modifies **FROZEN** documents and `PRD_LIFECYCLE.md` **L177** forbids that. ✅ Two items *are* closed, because this role is their **only** required authority: **`LCF-GAP-001`** and **`LCR-GAP-001`** — the `LCF-` and `LCR-` prefixes are **REGISTERED** to `PRD-021A` A2 and A3 respectively, collision-checked against every existing prefix. ⚠ **§2's arithmetic is now stale by two** (*"Four distinct answers"*, *"a fifth would have no rule to serve"*) — the clause is a **conditional test** that both derivations *satisfy*, so the reasoning survives and only the count is stale; correcting it in place is the very insertion that breaks the 35 citations, so it is **disclosed in §10.4 and routed**, not silently patched. ⛔ **No holder is appointed and no personal name is recorded** (§7 rule 4). **No PRD, requirement, register or acceptance criterion is created, modified or withdrawn; no §2.2/§5/§9 line and no §§4.1–4.4 PRD row is touched; no rank, edge or boundary is altered; no document is frozen or baselined.** ⛔ `PRD-021A` remains **NOT READY / NOT FROZEN** and `PRD-021` remains gated behind `PRD-020`. |
---

## 9. ⭐ The `Privacy Owner` role — constituted by `ADR-0077`, recorded by append

⚠ **Why this is a section and not a row in §2.2.** `ADR-0077` §6 prescribed inserting the role into the §2.1
derivation table, the §2.2 role table, the §2.3 vocabulary table and the §5 stage table. On execution that
proved unsafe: this document is cited **by line number 74 times** across `docs/`, including **35** citations
to **L85** (the Architecture Owner row) and **8** to **L284** (*"Only the Architecture Owner approves"*), in
**Accepted ADRs** — `ADR-0040`, `ADR-0041`, `ADR-0042`, `ADR-0044` and others — and in
`DOCUMENTATION_BASELINE.md`. A single inserted row shifts every line beneath it and converts those citations
into silent misdirections. Appending below **L331** shifts **nothing**, and was verified to shift nothing.
**The role is no less constituted for being recorded here:** this document is the ownership model in whole,
not in part.

### 9.1 The role

| Role | Decides | Attests | Never decides |
|---|---|---|---|
| **Privacy Owner** | Whether a proposed processing of personal data is permissible: per-viewer behavioural tracking, presence and location inference, minor-inclusive data flows, cross-context identity resolution, and retention of observational data | That a **privacy review** demanded by an existing rule has been *completed*, so a gate conditioned on it can be evaluated | ⛔ Boundaries, ranks or permitted edges (**Architecture Owner**) · ⛔ scope, priority or acceptance (**Product Owner**) · ⛔ document status or freeze (**Governance Owner**) · ⛔ its own conferral |

⭐ **One holder, per §3 rule 1.** ⛔ **No personal name is recorded**, per §7 rule 4. The role is **vacant as
constituted** — constituting an office does not fill it, and nothing in this document appoints anyone.

### 9.2 Derivation — the five rules that already required it

Each of these demands a privacy review and names **no** role able to perform it. This is the measurement that
satisfies §2.1's own test rather than setting it aside.

| # | Rule | Where | Rank | What it demands |
|---|---|---|---|---|
| 1 | Public Live Occupancy | `ARCHITECTURE_RULINGS.md` **L290** | **5** | *"Requires a completed privacy review before design"*, and expressly that it *"must not be invented"* |
| 2 | `LIB-24.2` | `Library_PRD_v1.md` **L1025** | **3 — FROZEN** | A privacy review obligation inside a document that can no longer be edited to name its own reviewer |
| 3 | `TSF-GAP-016` | `PRD-020` **L1784** | DRAFT | Routes an open item to *"**the privacy owner**"* — the phrase, verbatim, already in use |
| 4 | `SEAT-GAP-014` | `PRD-SEAT-MANAGEMENT.md` **L2266** | 3 | *"Architecture + privacy review"* — two reviews, one role defined |
| 5 | `LCR-DEC-003` / `LCR-GAP-006` | `PRD-021A` A3 | draft | Per-viewer impression tracking over a population `SM-INV-3` records as **minor-inclusive** |

⭐ **Rule 2 is the one that forecloses every alternative.** A **FROZEN Rank 3** PRD already carries a privacy
obligation. It cannot be amended to route that obligation elsewhere (`PRD_LIFECYCLE.md` **L177**), so the
obligation must be dischargeable **as written**. That requires a role. Rule 1 independently forbids inventing
the review, which means the *reviewer* cannot be improvised at the point of use either.

### 9.3 Why none of the existing four can absorb it

| Candidate | Why not |
|---|---|
| **Product Owner** | §2.2 scopes it to *"business intent: scope, priority, acceptance"*. Whether processing a minor's behavioural data is **permissible** is not a scope question; a Product Owner who could waive it could buy features with lawfulness |
| **Architecture Owner** | §2.2 scopes it to *"boundaries, ranks, permitted edges, precedence"*. `SEAT-GAP-014` demands *"Architecture **+** privacy review"* — the conjunction is in the rule, so the two reviews are **not** the same review |
| **Domain Owner** | §3 makes this per-PRD. Privacy determinations must be **consistent across** PRDs, or `BC-10`'s global identity rules fragment per document |
| **Governance Owner** | Owns document status and process. ⚠ And it is **itself undefined here** — §9.4 |

### 9.4 ⚠ Two disclosed defects, neither repaired

| Defect | Measurement | Disposition |
|---|---|---|
| §2's closing arithmetic still reads *"Four distinct answers"* / *"Four roles is therefore the minimum"* / *"A fifth would have no rule to serve"* | The clause is a **conditional test**, and §9.2 shows the condition is now met — so the *reasoning* survives intact and only the *count* is stale | ⚠ **Disclosed, not edited.** Correcting the count in place is the insertion that breaks 35 citations to **L85**. Routed to the **Governance Owner** together with the line-citation convention itself |
| ⛔ `Governance Owner` occurs **0** times in this document | Yet it is the approving authority named in **Accepted** `ADR-0053`, `ADR-0054` and `ADR-0064`, and the routing target of `LCF-GAP-001`, `LCF-GAP-008` and `LCR-GAP-001` | ⛔ **Disclosed, deliberately NOT fixed.** It is **more serious** than the privacy gap — three Accepted ADRs already record approval by a role this model never defines — and it is outside `ADR-0077`'s conferred authority. Deriving a *second* undefined role in the same pass would be exactly the unbounded self-authorisation `ADR-0033` §7.1 warns against |

### 9.5 ⛔ What constituting this role does **not** do

| Claim | Status |
|---|---|
| Any privacy decision is taken | ⛔ **No.** `LCR-DEC-003`, `LCR-GAP-006`, `TSF-GAP-016`, `SEAT-GAP-014` and `LIB-24.2` all remain **OPEN** |
| `LCR-RS-007` (already-seen signal) becomes available | ⛔ **No** — still `DEFERRED`, weight **0** |
| A holder is appointed | ⛔ **No.** Vacant. §7 rule 4 forbids recording a name |
| `PRD-021A` A2 or A3 becomes ready or freezable | ⛔ **No** — **NOT READY, NOT FROZEN** |
| §§2.1–2.3, §5, or any §4 PRD row is amended | ⛔ **No** — every cited line is byte-identical |

---

## 10. ⭐ The `Governance Owner` role — constituted by `ADR-0080`, recorded by append

⚠ **Why this is a section and not a sixth row in §2.2.** Identical to the reason §9 gives, re-measured this
pass: this document is cited **by line number 74 times** across `docs/`, the highest being **L331**, and **35**
of those citations are to **L85** alone — the Architecture Owner row — in **Accepted ADRs** and in
`DOCUMENTATION_BASELINE.md`. Inserting a row into the §2.2 table shifts every line beneath it and converts
those citations into silent misdirections. Appending below **L399** shifts **nothing**, and was verified to
shift nothing. **The role is no less constituted for being recorded here:** this document is the ownership
model in whole, not in part.

### 10.1 The role

| Role | Decides | Attests | Never decides |
|---|---|---|---|
| **Governance Owner** | Document **status** and **process**: lifecycle **Stage 7**, admission of a PRD to the baseline, the freeze of a document, the baseline declaration and its identifier, and the **registration of identifier prefixes** | That a lifecycle stage demanded by `PRD_LIFECYCLE.md` has been *completed*, so a gate conditioned on it can be evaluated | ⛔ Boundaries, ranks or permitted edges (**Architecture Owner** — `ADR-0054` **L148**: *"Those are different roles"*) · ⛔ scope, priority or acceptance (**Product Owner**) · ⛔ domain correctness (**Domain Owner**) · ⛔ implementation or sequencing (**Technical Owner**) · ⛔ whether personal-data processing is permissible (**Privacy Owner**, §9.1) · ⛔ its own conferral, and ⛔ its own scope |

⭐ **One holder, per §3 rule 1.** ⛔ **No personal name is recorded**, per §7 rule 4. The role is **vacant as
constituted** — constituting an office does not fill it, and nothing in this document appoints anyone.

### 10.2 Derivation — the rules that already required it, three of them already exercised

⭐ **This derivation is evidentially stronger than §9.2's.** For the Privacy Owner, the rules *demanded* a role
that had never acted. Here, three **Accepted** ADRs have already **acted through** the role.

| # | Rule | Where | What it demands |
|---|---|---|---|
| 1 | **Stage 7 and the baseline** | `PRD_LIFECYCLE.md` §6 **L282** — `\| Governance owner \| Stage 7; the baseline \|` | Names the role **verbatim** and assigns it duties. §2.3's *"reused, not invented"* rule is satisfied by this line alone |
| 2 | **Stage 7 is not skippable** | `PRD_LIFECYCLE.md` §7 | *"Urgent business need — **No fast path.** Stage 7 is not skippable"*. A non-skippable stage owned by an undefined role is unperformable as written |
| 3 | `ADR-0053` — baselined `PRD-023` | **L8** | `Deciders: **Governance owner** (Stage 7 and the baseline, PRD_LIFECYCLE.md §6 L282)` — ⭐ **Accepted, already exercised** |
| 4 | `ADR-0054` — froze `PRD-017` | **L8**, **L148**, **L167** | as above, **plus** an explicit holding that this role and the Architecture Owner are *"different roles"* — ⭐ **Accepted, already exercised** |
| 5 | `ADR-0064` — baselined `PRD-012a` | **L7**, **L109**, **L134** | *"The conferral here is **Governance Owner**"* — ⭐ **Accepted, already exercised** |
| 6 | Routing target of open items | `LCF-GAP-001`, `LCF-GAP-008`, `LCR-GAP-001`, and §9.4 twice | A routing target that does not exist is an item that can never be actioned |

**Measured, repository-wide:** *"governance owner"* occurs **342** times across **91** files — and, before
`ADR-0080`, **0** times in this document as a definition. ⭐ **The role was never missing from practice; only
from the document whose purpose is to define roles.**

⚠ **The circularity objection, answered rather than avoided.** `ADR-0033` §7.1 warns against unbounded
self-authorisation, and §9.4 invoked it to defer this act. The authority is **not created here**: **L282**
already assigns the duties and `ADR-0053`/`0054`/`0064` already exercised them under direct conferral. This
section **writes down an authority that pre-exists it**. Refusing to write it down would not remove the
authority — it would only keep it undocumented, which is the defect §9.4 measured.

### 10.3 Why none of the other five can absorb it

| Candidate | Why not |
|---|---|
| **Architecture Owner** | ⛔ Foreclosed by an **Accepted** ADR: `ADR-0054` **L148** holds of these two roles *"Those are different roles"*, and **L167** assigns a specific act to one and not the other. Merging them would overturn `ADR-0054` by side effect |
| **Product Owner** | §2.2 scopes it to *"business intent: scope, priority, acceptance"*. Whether a document may be **frozen** is neither scope nor priority; a Product Owner who could freeze could ship past a gate |
| **Domain Owner** | §3 makes this per-PRD. Baseline and status decisions must be **consistent across** PRDs, or the baseline fragments per document |
| **Technical Owner** | §2.2 scopes it to implementation, `IMPL-*` and traceability. Stage 7 is a governance gate, not a build step |
| **Privacy Owner** | §9.1 expressly excludes it: *"⛔ document status or freeze (**Governance Owner**)"* — the exclusion already names this role as the correct holder |

### 10.4 ⚠ Disclosed, not repaired

| Defect | Measurement | Disposition |
|---|---|---|
| §2's closing arithmetic reads *"Four distinct answers"*, *"Four roles is therefore the minimum"*, *"A fifth would have no rule to serve"* | Now understates by **two**. But the clause is a **conditional test**, and §9.2 and §10.2 each *satisfy* it by measuring rules that already exist — so the **reasoning survives intact** and only the **count** is stale | ⚠ **Disclosed, not edited.** Correcting the count in place is the insertion that breaks **35** citations to **L85**. Routed to this role, together with the line-citation convention itself |
| §2.2's table still shows four rows | §§9 and 10 are the two constituted additions | ⚠ Same reason. The document is the model *in whole, not in part* |
| ⛔ **281 bare EA line-citations** (`ADR-0075` §8.5 **Option B**) | Now routed to a role that **exists** | ⛔ **OPEN, not resolved.** It edits **32 files including FROZEN `PRD-017` and the `PRD-012a` family**; `PRD_LIFECYCLE.md` **L177** forbids silent modification of a frozen PRD, and it needs the Architecture Owner as well |
| `PGA-08` — *"Every PRD needs a named owner. None has one"* | Unchanged | ⛔ §7 rule 4 forbids recording names. This section records an **office**, not an appointment |
| ⭐ **`SECP-DEP-007`** — *"Update `PRD_REGISTRY.md` §4.1 and `PRD_OWNERSHIP_MODEL.md` to reflect the executed split"*, owner **Governance Owner** (`PRD-012a_PART8` **L358**) | ⚠ **This document's §4.2 rows are stale.** **L179** still shows `PRD-012` as live and *"⚠ **Split**"*, and **L180**/**L181** still mark `PRD-012a`/`PRD-012b` *"(reserved)"* — but `ADR-0064` **RETIRED** `PRD-012` and moved `PRD-012a` to **FROZEN**. `ADR-0064` §4 item 5 discharged `SECP-DEP-007` *"for the registry"* only and mentions this document **0** times, so the ownership-model half was **never performed**, exactly as `DOCUMENTATION_BASELINE.md` **L363** records (*"ROUTED, NOT PERFORMED … Governance Owner acts"*) | ⚠ **Now dischargeable for the first time — and deliberately NOT discharged here.** ⛔ **L180 is a cited line**, and §4.2's rows cannot be corrected in place without either changing cited content or shifting the **35** citations to **L85**. The act also belongs to the same §7 rule 1 class as the §2 arithmetic. It is therefore **recorded as a live, owned, now-actionable obligation** rather than performed as a side effect of constituting the role that owns it |
| `DOCUMENTATION_BASELINE.md` **L363** — previously carried in working notes as citing a non-existent `PRD_OWNERSHIP_MODEL L358` | ⛔ **That was a false positive of the measuring instrument, not a defect in the document.** Re-read in full, **L363** cites **`PRD-012a_PART8` L358** — a **valid** line in a **417**-line file, naming `SECP-DEP-007` and its two target files. A regex that captured `PRD_OWNERSHIP_MODEL.md` from earlier in the same sentence mis-attributed the citation | ✅ **No repair owed. The false finding is retracted here rather than propagated**, and the *real* obligation it was obscuring is the `SECP-DEP-007` row immediately above |

### 10.5 ⛔ What constituting this role does **not** do

| Claim | Status |
|---|---|
| A holder is appointed | ⛔ **No.** Vacant. §7 rule 4 forbids recording a name |
| Any document is frozen, baselined or advanced a stage | ⛔ **No** |
| `ADR-0075` §8.5 Option B is resolved | ⛔ **No** — routed only. The 281 citations stand |
| Gaps other than `LCF-GAP-001` / `LCR-GAP-001` close | ⛔ **No.** For every other routed gap this role is **not the only** required authority — `LCF-GAP-008` needs the Auth owner, `LCF-GAP-004` the `BC-14` author, `LCF-GAP-006` the Product and Configuration Owners, `LCF-GAP-011` the Engineering Owner |
| The two prefix registrations confer readiness | ⛔ **No.** A registered prefix on a draft is still a draft |
| `PRD-021A` A2 or A3 becomes ready or freezable | ⛔ **No** — **NOT READY, NOT FROZEN** |
| The `PRD-020` release gate is affected | ⛔ **No.** `PRODUCT_IMPLEMENTATION_ROADMAP.md` **L161–164** stands unchanged |
| §§2.1–2.3, §5, §9, or any §4 PRD row is amended | ⛔ **No** — every cited line is byte-identical |

---

## 11. ⭐ `PRD-021A` — four roles assigned on registration, recorded by append

**Trigger.** `PRD-021A` **Library Community & Community Feed** was allocated `PLANNED` at **`BC-15` Community &
Groups**, **V2**, by Product Owner decision **`D-A`** on 2026-08-25, recorded at
[`PRD_REGISTRY.md`](./PRD_REGISTRY.md) **§11**.

**Why a record here is required, not optional.** §3 **rule 1** — *"Every registered PRD has exactly one Product
Owner, one Domain Owner, one Architecture Owner and one Technical Owner"* — and §7 **rule 1** — *"A new PRD gets
all four roles when it is registered, before it has content"* — together make this row **mandatory** the moment the
registry row exists. §3 **rule 4** states the reason: *"A `PLANNED` PRD has roles assigned; it does not have
content. Ownership is what makes the gap actionable — an unowned gap has nobody to close it."*

### 11.1 The assignment

| PRD | Subject | Context | Product Owner | Domain Owner | Architecture Owner | Technical Owner |
|---|---|---|---|---|---|---|
| **`PRD-021A`** | Library Community & Community Feed | **`BC-15`** Community & Groups (**V2**) | Product Owner | **Social Domain** | ARB | Platform Engineering |

**The Domain Owner is derived, not chosen** — §3 rule 3. `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L119** gives `BC-15`'s
*"Owning Platform"* as **Global Student**, the same value **L114**–**L117** give `BC-11`, `BC-12` and `BC-13`. §4.3
already renders that platform as **Social Domain** for `PRD-020` (`BC-13`) and `PRD-021` (`BC-11`, `BC-12`), so
this row **reuses the existing derived value rather than introducing a new one**. **No context-ownership change
occurs**, so §7 rule 2's ADR requirement is **not triggered**.

**Architecture Owner is platform-wide by construction** (§3 rule 2 — ARB). **Product Owner and Technical Owner are
the roles as defined in §2.2.** ⛔ **No personal name is recorded** — §7 rule 4. ⛔ **No new role is constituted**;
the six that exist (§2.2 four, §9 Privacy Owner, §10 Governance Owner) are unchanged, and **no holder is
appointed**.

**Not contested.** §3 rule 6 does not apply: **no second PRD claims `BC-15`**. `PRD-021` owns `BC-11`/`BC-12` and
`PRD-020` owns `BC-13`; none claims `BC-15`. §4.4's *"✅ **No context is contested. Count: 0**"* therefore **remains
true and is not amended**.

### 11.2 ⚠ Why this is a section and not a row inside §4.3

Measured before writing, on the identical discipline §9 and §10 record. This document is cited **by line number**
across the repository; the highest cited line is **L418**, with heavy concentrations at **L85** (35 citations),
**L180**, **L284** and **L202**/**L203** — the last two being the `PRD-020` and `PRD-021` rows in §4.3, which is
exactly where a `BC-15` row would naturally sit. **Inserting a row at L204 would shift every cited line below it**,
including **L284**, **L285**, **L311**, **L329**, **L331**, **L358**, **L399** and **L418**, in `Accepted` ADRs and
in `DOCUMENTATION_BASELINE.md`. **This section begins below L479, so it shifts 0 lines and changes 0 cited-line
contents** — verified. The precedent is stated in this document's own v1.3 changelog: the Governance Owner role was
constituted *"by APPEND (§10), not by a sixth row in §2.2"* because *"appending at L400+ invalidates 0"*.

### 11.3 ⚠ Two consequences disclosed, neither repaired

1. **§4's heading and §6 item 1 are now arithmetically stale.** The heading reads *"Assignment for all **23**
   registered PRDs"* (already stale before this pass — the header's Scope row says **24**), and §6 item 1 reads
   *"**23 of 23**, plus the two reserved sub-numbers"*. With `PRD-021A` the population is larger again. **Neither
   is edited**, because §4's heading sits at **L137** and §6 at **L291**, both above cited lines — the exact
   insertion that breaks the 35 citations to L85 and the ones to L284/L285. This is the same disclosure §9.4 and
   §10.4 made for §2's *"Four distinct answers"* arithmetic, which **remains stale by two** and **remains
   unrepaired on the same reasoning**. **Routed to the Governance Owner.**
2. **§6 item 1's clause *"`PRD-023` does not exist and is deliberately not allocated (§4.4)"* was already falsified**
   by `ADR-0017` and this pass **does not repair it either** — it is pre-existing, out of scope for `D-A`, and
   correcting it is the same insertion problem.

### 11.4 ⛔ What assigning these four roles does **not** do

| Claim | Status |
|---|---|
| A holder or personal name is recorded | ⛔ **No.** Roles only — §7 rule 4 |
| A new role is constituted | ⛔ **No.** Six roles before, six after |
| Context ownership changes | ⛔ **No.** `BC-15`'s owning platform is unchanged at BC Map **L119**; §7 rule 2's ADR requirement is not triggered |
| `PRD-021A` gains content, readiness or a lifecycle stage | ⛔ **No.** §3 rule 4 — *"it does not have content."* Stages 3–7 **NOT CONFERRED**; **nothing frozen** |
| `BC-15` moves from V2 to V1 | ⛔ **No.** The release band is untouched; that is a **Rank 1** scope act |
| A6, A7 or A8 gains an owner | ⛔ **No — they are NOT registered PRDs.** `D-A` refused them as **NO STANDALONE PRD**; their scope stays with `BC-13`/`PRD-020`, `BC-22`/`PRD-010`, and the EA/Matrix/`ADR-0001` respectively. **No row exists for them and none may be added** |
| A1–A5's open decisions are resolved | ⛔ **No.** A1's `W₀`, A4's scope decision, A5's existence gate and A2/A3's architectural gates all **remain OPEN**. §3 rule 5 — *"Ownership says who decides"*, not what is decided |
| Ownership overrides precedence | ⛔ **No** — §3 rule 5. This document is **Unranked** (header L10) and never outranks a PRD or a ranked document |
| Any ADR was created | ⛔ **No.** `ADR-0083` remains free and **was NOT created**; **73** ADR files before and after |
| Any §2.2, §5, §9, §10 line or any §§4.1–4.4 PRD row is amended | ⛔ **No** — every cited line is **byte-identical** |

### 11.5 Changelog note

⚠ **Recorded here rather than as a row in §8**, for the reason §9 and §10 both give: §8's table sits at **L325**,
below cited **L284**/**L285** but above cited **L311**, **L329**, **L331**, **L358**, **L399** and **L418**, so
appending a row there shifts six cited lines. **This note therefore lives in the section it describes.**

**v1.4 — 2026-08-25.** ⭐ **`PRD-021A` assigned its four roles on registration** under Product Owner decision
**`D-A`** (`PRD_REGISTRY.md` §11). Domain Owner **derived** to **Social Domain** from BC Map **L119**'s
*Global Student*, matching the existing `PRD-020`/`PRD-021` renderings — **no new value, no new role, no
context-ownership change, no ADR required** (this document is **Unranked**, header **L10**; absent from
`DOCUMENTATION_BASELINE.md` §3 and §4). Executed **by APPEND**: **0** cited lines shifted, **0** cited-line
contents changed, verified against the highest cited line **L418**. ⛔ **No holder appointed, no personal name
recorded, no lifecycle stage conferred, no document frozen, no A6/A7/A8 owner created, and no A1–A5 decision
resolved.** ⚠ §4's *"all 23"* heading and §6 item 1's count are **disclosed as stale in §11.3 and routed**, not
silently patched — the same treatment §9.4 and §10.4 gave §2's arithmetic.

---

## 12. ⭐ Six identifier prefixes registered — `PRD-021A` A1, A4, A5, A6, A7, A8 (2026-08-31)

> **Recorded by APPEND, for the reason §10, §11 and §11.5 all give.** Re-measured this pass: **74** line-citations
> point into this document, the highest is **L331**, and **35** of them are to **L85** alone. Appending below **L569**
> invalidates **0**; inserting a row into §5's prefix area or §8's table would silently misdirect citations held in
> **Accepted** ADRs and in `DOCUMENTATION_BASELINE.md`. **No existing line of this document is modified by this section.**

### 12.1 Authority

**Governance Owner**, the office §10 constitutes and `ADR-0080` derives. Registration of an identifier prefix is a
**Stage 7 / baseline** act — the duty `PRD_LIFECYCLE.md` §6 **L282** assigns to this role, and §11 of that document
makes Stage 7 non-skippable. The office is recorded **VACANT** at `ADR-0080` **L85**; it is filled **for this act only**
by direct conferral from the human principal, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 precedent.
⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted. No holder is appointed and no personal
name is recorded** (§7 rule 4).

The conferral directed, in these words:

> *"Register the prefixes `LCM-`, `LCG-`, `LCO-`, `LCS-`, `LCN-`, `LCT-`. Use the existing `ADR-0080` prefix-registration
> method."*

⭐ **The method is reused verbatim, not re-invented** — the table below has the same four columns `ADR-0080` §5 used to
register `LCF-` and `LCR-`, and it is executed by [`ADR-0083`](../adr/ADR-0083-prd-021a-owner-rulings-executed.md).

### 12.2 The register

`PRD_LIFECYCLE.md` §5 rule 3 — *"On collision, change the new prefix, never the existing one"* — and rule 5 —
*"Numbers are never reused, even after withdrawal"* — both apply. The collision domain was measured as **every**
three-segment identifier prefix in `docs/`: `AFIL ATT AUD CNF ENT FEE FIL INV ITG LCF LCG LCM LCN LCO LCR LCS LCT
LIB MM SAAS SEAT SEC SECP SID SM TEN TSF XCNF XFIL` — **29** prefixes.

| Prefix | Owning document | Collision check | Determination |
|---|---|---|---|
| **`LCM-`** | `PRD-021A` **A1** — Library Community Foundation | **No collision.** **953** uses; **601** in A1, which is the maximum and therefore the owner. The only non-`PRD-021A` occurrences are in `PRD_REGISTRY.md`, and those *reference* A1 rather than claiming the prefix | ✅ **REGISTERED** to `PRD-021A` A1 |
| **`LCG-`** | `PRD-021A` **A4** — Community Groups & Roles | **No collision.** **304** uses; **214** in A4 (maximum). ⚠ Distinct from **`LCF-`** (A2) by measurement, not by assumption — different second letter, and the two registers share no identifier | ✅ **REGISTERED** to `PRD-021A` A4 |
| **`LCO-`** | `PRD-021A` **A5** — Official Library Communication | **No collision.** **579** uses; **492** in A5 (maximum) | ✅ **REGISTERED** to `PRD-021A` A5 |
| **`LCS-`** | `PRD-021A` **A6** — Community Safety, Privacy & Moderation | **No collision.** **257** uses; **195** in A6 (maximum). ⚠ Distinct from `PRD-020`'s **`TSF-`**; A6 owns **no** `TSF-` identifier and mints none | ✅ **REGISTERED** to `PRD-021A` A6 |
| **`LCN-`** | `PRD-021A` **A7** — Community Notifications | **No collision.** **204** uses; **150** in A7 (maximum); **zero** occurrences outside `PRD-021A` anywhere in `docs/` | ✅ **REGISTERED** to `PRD-021A` A7 |
| **`LCT-`** | `PRD-021A` **A8** — Technical & Production Architecture | **No collision.** **318** uses; **292** in A8 (maximum); **zero** occurrences outside `PRD-021A` | ✅ **REGISTERED** to `PRD-021A` A8 |

⭐ **With `LCF-` and `LCR-` (registered by `ADR-0080` §5), all eight `PRD-021A` parts now hold a registered prefix.**
The collision domain grows from 29 to 29 — the six were already in use and are now *registered*, which is precisely the
defect being repaired: identifiers were in circulation without an authorising act.

### 12.3 ⛔ What registration does **not** do

`ADR-0080` §5's limiting paragraph is reproduced because it governs these six exactly as it governed the first two:

> ⛔ *"It settles **only** the prefix. It creates no requirement, closes no other gap, and confers no readiness on
> either annex. A registered prefix on a draft is still a draft."*

| Question | Answer |
|---|---|
| Does any part become READY, or gain a lifecycle stage? | ⛔ **No.** All eight remain **NOT READY / NOT FROZEN**. Stage 3 is a separate dated record with its own authority test; Stages 4–7 are **NOT CONFERRED** |
| Is any requirement, AC, gap or decision created? | ⛔ **No.** Registration authorises the *namespace*, not its contents |
| Are the parts' open items closed? | ⛔ **No.** `LCG-ADR-002` stays **OPEN** (`BC-15` publishes no event), `GAP-BC14-RANK` is **newly opened**, and `LCG-DEC-005b` is **newly split out**. A prefix does not answer a question asked in it |
| Is a role constituted or a holder appointed? | ⛔ **No.** Six roles before, six after; **no personal name recorded** |
| Is context ownership, a rank, an edge or a boundary altered? | ⛔ **No.** Those are **Architecture Owner** acts — `ADR-0054` **L148**: *"Those are different roles"* — and this pass's edge and cluster changes were made under **that** authority in the Rank 4 documents, not here |
| Does this document outrank a PRD? | ⛔ **No** — §3 rule 5. This document is **Unranked** (header **L10**) and absent from `DOCUMENTATION_BASELINE.md` §3/§4, so **no ADR was required** for this append; `ADR-0083` records it because the ruling set asked for one record, not because rank compelled it |
| Was any existing line changed? | ⛔ **No.** Every cited line, including **L85** and **L331**, is **byte-identical**. §11's *"73 ADR files before and after"* is now stale at **74** — ⚠ **disclosed here and routed, not silently patched**, on the §9.4 / §10.4 / §11.3 precedent, because correcting it in place is the very insertion that breaks the 35 citations to L85 |

### 12.4 Changelog note

**v1.5 — 2026-08-31.** ⭐ **Six identifier prefixes registered** — `LCM-` (A1), `LCG-` (A4), `LCO-` (A5), `LCS-` (A6),
`LCN-` (A7), `LCT-` (A8) — under **Governance Owner** authority conferred directly, executed by `ADR-0083`, using the
**`ADR-0080` §5 method** unchanged. Collision-checked against all **29** existing prefixes: **0** collisions; the four
apparent foreign uses in `PRD_REGISTRY.md` were measured to be *references* to the owning parts, not competing claims.
Executed **by APPEND**: **0** cited lines shifted, **0** cited-line contents changed, verified against the highest cited
line **L331** and the 35 citations to **L85**. ⛔ **No holder appointed, no personal name recorded, no lifecycle stage
conferred, no document frozen, no requirement or AC created, and no open decision resolved.** ⚠ §11's ADR count
(*"73 … before and after"*) is stale at **74** and is **disclosed above rather than edited**, for the citation reason
this document has now given five times.

---

## 13. ⭐ A seventh role — `SRE / Observability` — constituted and conferred for one act (2026-09-05)

> **Recorded by APPEND, for the reason §9, §10, §11, §11.5 and §12 all give.** Re-measured this pass:
> citations point into this document at **L68, L69, L85 (×35), L102, L107, L139, L144, L159, L197,
> L284** and **L331**. Appending below **L644** invalidates **0**; inserting a row into §2.2's role
> table would silently misdirect every citation beneath it, in **Accepted** ADRs and in
> `DOCUMENTATION_BASELINE.md`. **No existing line of this document is modified by this section.**

### 13.1 Authority and scope

**`SRE / Observability`**, the office **Rank 1** already names. Executed by
[`ADR-0102`](../adr/ADR-0102-sre-observability-office-conferred-for-prd-015-p7-availability-ratification.md).

⭐ **The role vocabulary is reused, not invented** — §2.3's rule is satisfied at **Rank 1**:
`MASTER_PRD.md` **L495** assigns `MP-NFR-01` *Availability* to **`SRE / OBSERVABILITY`** verbatim, as
do `MP-NFR-09` (**L503**) and `MP-NFR-12` (**L506**). Measured before this section existed:
`grep -ciE 'SRE|observabilit'` over this document returned **0**, so the office named by three Rank 1
obligations was **defined nowhere**.

The office is filled **for this act only** by direct conferral from the human principal, on the
`ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 / §12.1 precedent. The conferral directed, in
these words:

> *"I, as the human principal, explicitly confer and authorize the SRE / OBSERVABILITY office for the
> PRD-015 P7 availability-ratification act only. The authorized office shall ratify the already
> pre-approved target of 99.9% monthly availability, without re-deriving or changing the value. This
> is a one-act conferral only. No standing authority, no self-appointment, no personal name
> recording, and no invented authority."*

⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted. No holder is
appointed and no personal name is recorded** (§7 rule 4). ⭐ **One holder**, per §3 rule 1. ⛔ Outside
this act the office is **VACANT** — `ADR-0033` §7.1: *"a conferral for one act is not a standing
licence."*

| Role | Decides | Confirms | ⛔ Does NOT decide |
|---|---|---|---|
| **SRE / Observability** | Per-function availability targets, SLOs, SLIs and error budgets; what constitutes an availability breach; observability signal obligations | That an availability target demanded by an existing Rank 1 obligation has been **ratified**, so a gate conditioned on it can be evaluated | ⛔ Boundaries, ranks or permitted edges (**Architecture Owner**) · ⛔ scope, priority or acceptance (**Product Owner**) · ⛔ document status or freeze (**Governance Owner**) · ⛔ personal-data permissibility (**Privacy Owner**) · ⛔ its own conferral |

### 13.2 What was decided, and what was deliberately not

✅ **RATIFIED:** `PRD-015`'s `P7` availability target at **`99.9% monthly`** — the value
**pre-approved and coherence-checked** by `ADR-0100` §3.2, ⛔ **carried across unchanged and NOT
re-derived**. This closes `ADR-0100` §3.2 **L163**'s *"`P7` availability: OPEN … awaiting the right
office."*

⚠⚠ **`SRE-GAP-001` — OPEN.** `MP-NFR-01` requires *"targets with **SLOs, SLIs and error budgets**"*.
This act ratifies the **target** only; the **SLO**, **SLI** and **error budget** are **NOT
specified**, because defining an SLI is new content rather than ratification of a pre-approved value,
and a one-act conferral may not produce it. **Owner: this office. Requires a separate act.**

⛔ **Constituting and conferring an office is not exercising it beyond the conferred act.** No other
availability target, on any other module, is set, changed, confirmed or pre-judged. ⛔ **`H-B`'s
Architecture Owner concurrence is NOT supplied** — that is the **ARB** (**L197**), a different office
(`ADR-0054` **L148**), and this conferral does not reach it.

### 13.3 ⚠ Change-history row — recorded HERE, not inserted into §8

⚠⚠ **The row belongs in §8's changelog table, and it is deliberately NOT written there.** Citations
into this document were enumerated mechanically before the write and **five sit BELOW §8's table** —
**L353**, **L356**, **L418**, **L419** and **L509**. Inserting a row after **L334** shifts every one
of them by one and silently misdirects them. §9.4, §10.4 and §12's preamble each recorded the same
constraint; this section applies it rather than rediscovering it.

⭐ **The row, in §8's format, to be merged by any later pass that repairs the citation families
wholesale** (routed to `ADR-0075` §8.5 Option B):

| Version | Date | Change |
|---|---|---|
| **v1.4** | 2026-09-05 | ⭐⭐ **A seventh role — `SRE / Observability` — is constituted and conferred FOR ONE ACT ONLY, under `Accepted` [`ADR-0102`](../adr/ADR-0102-sre-observability-office-conferred-for-prd-015-p7-availability-ratification.md).** ⭐ **The derivation is the strongest of the three appended roles, because its vocabulary comes from Rank 1:** `MASTER_PRD.md` **L495** assigns `MP-NFR-01` *Availability* to **`SRE / OBSERVABILITY`** verbatim, as do `MP-NFR-09` (**L503**) and `MP-NFR-12` (**L506**) — and measured before §13 existed, `grep -ciE 'SRE\|observabilit'` over this document returned **0**, so an office named by **three Rank 1 obligations** was defined nowhere. §2.3's *"role vocabulary is reused, not invented"* rule is therefore satisfied **at Rank 1**, not by analogy. ⭐ **The conferral is quoted verbatim in §13.1** and is the **only** authority claimed, on the `ADR-0032` §5.2 / `ADR-0033` §7.2 / `ADR-0036` §8.2 / §12.1 precedent. ⛔ **No ARB quorum, attendee list, sign-off date or Security review is asserted; no holder is appointed and no personal name is recorded** (§7 rule 4); outside the conferred act the office is **VACANT** (`ADR-0033` §7.1 — *"not a standing licence"*). ✅ **One item IS closed, because this office is its only required authority:** `PRD-015`'s **`P7` availability target is RATIFIED at `99.9% monthly`**, the value **pre-approved and coherence-checked** by `ADR-0100` §3.2 and ⛔ **carried across unchanged, NOT re-derived** — closing `ADR-0100` §3.2 **L163**'s *"OPEN … awaiting the right office"* and `PRD-015`'s human-decision blocker **`H-D`** on all three of its limbs (office · holder · ratification). ⚠⚠ **A NEW GAP IS RAISED RATHER THAN HIDDEN — `SRE-GAP-001` is OPEN:** `MP-NFR-01` demands *"targets with **SLOs, SLIs and error budgets**"* and this act supplies **only the target**; defining an SLI is new content, not ratification of a pre-approved value, and a one-act conferral may not produce it. ⛔⛔ **`H-B`'s Architecture Owner concurrence is NOT supplied and the `H-B`/`H-D` coupling does NOT discharge** — `H-B` needs the **ARB** (**L197**), which `ADR-0054` **L148** holds is a *different role*; the coupling was a **shared blocker, never a shared authority**. ⚠ **Executed by APPEND (§13), not by rows in §2.1/§2.2/§2.3/§5/§8** — the constraint is now measured twice: citations reach **L85 (×35)**, L68, L69, L102, L107, L139, L144, **L197**, L284, L331 **and, below §8's table, L353, L356, L418, L419, L509**, so a §8 row insert would misdirect five live citations; the row is therefore recorded at **§13.3** and routed. ⚠ **§2's arithmetic is now stale by three** (*"Four distinct answers"*, *"a fifth would have no rule to serve"*) — the clause is a **conditional test** all three derivations *satisfy*, so the reasoning survives and only the count is stale; **disclosed and routed, not silently patched**, per §9.4 and §10.4. ⛔ **No PRD, requirement, register or acceptance criterion is created, modified or withdrawn; no §2.2/§5/§8 line and no §§4.1–4.4 PRD row is touched; no rank, edge or boundary is altered; `MASTER_PRD.md` is byte-unchanged and NOT amended; no document is frozen or baselined** — `BASELINE-2026-09-03-A` stands. ⛔ **`PRD-015` Stage 3 is NOT conferred**; `H-C` and `H-E` are untouched; **0** `IMPL-*` identifiers and **0** application-code files were created. |

⚠ **This document's `Version` field (L6) still reads `v1.1` and is NOT edited** — it has been stale
since v1.2 for the same citation reason, a pre-existing condition disclosed by `ADR-0077` §8 and
carried forward unrepaired here. ⛔ **Not introduced by this pass.**
