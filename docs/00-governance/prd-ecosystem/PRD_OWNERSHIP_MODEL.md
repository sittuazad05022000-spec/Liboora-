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
