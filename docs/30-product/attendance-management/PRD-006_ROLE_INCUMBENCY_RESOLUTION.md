# `PRD-006` — Role Incumbency Resolution

| Field | Value |
|---|---|
| **Document** | Incumbency resolution for the four roles blocking [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) v1.3 DRAFT (sha256 `93ab1c60d740c4e0`) |
| **Question asked** | How can the human incumbents of the four existing roles be recorded through a legitimate repository/governance process? |
| **Answer** | ⛔ **No appointment mechanism exists — because governance explicitly PROHIBITS recording one.** `PRD_OWNERSHIP_MODEL.md` §7 rule 4: *"**Never** record a personal name."* The incumbency register is not missing by oversight; it is **forbidden by design**, and directed to *"a team directory **outside the repository**"* |
| **Consequence** | The blocker is **not** repairable inside the repository. It is an **external organisational act**, and the repository is explicit that this is the intended arrangement |
| **Scope** | Determination only. No role changed or invented, no person appointed or guessed, no value supplied, no document modified |
| **Version** | v1.0 |

---

## 1. The prohibition — verbatim

`PRD_OWNERSHIP_MODEL.md` **§7 Maintenance** (L311-321), the five rules governing how
ownership records may change:

> 1. *"A new PRD gets all four roles when it is registered, before it has content."*
> 2. *"A **Domain Owner** change is a **context-ownership change** — **ADR required** (`PRD_REGISTRY.md` §8.6)."*
> 3. *"**Product and Technical Owner** changes need **no ADR**; update this document in the same commit (§8.3)."*
> 4. > **"Never** record a personal name. If a name is needed operationally, it belongs in a **team directory outside the repository**."*
> 5. *"If this document disagrees with `PRD_REGISTRY.md`, fix the register's Owner field; this document is the authority on ownership."*

**Rules 2 and 3 are a genuine appointment mechanism — for roles, not for people.** They
govern *which role or organizational unit* occupies a slot, and they were exercised: the
§4.4 Contested rows were resolved on 2026-08-04 by `ADR-0013` and `ADR-0017`.

**Rule 4 forecloses the question actually asked.** Recording a human incumbent is not an
unimplemented feature of this governance model. It is an action the model **forbids**, and
it names the correct venue: outside the repository.

`§6 Compliance` **rule 3** makes the prohibition mechanically checkable:

> *"**No row names a person.** Every entry is a role or an organizational unit."*

---

## 2. Why the prohibition exists — the repository's own reasoning

`PRD_OWNERSHIP_MODEL.md` **§1.1 "Why roles, and not names"** (L29-41), *"three reasons, in
order of weight"*:

| # | Reason (verbatim) | Bearing on this request |
|---|---|---|
| 1 | *"**No name exists to record.** The repository names no individual anywhere. A name written here would be **fabricated**, and a fabricated owner is **worse than an absent one** — it **terminates the search for a real one**."* | Directly forbids the act this request might have led to. Naming anyone would end the search for the real authority |
| 2 | *"**A PRD outlives a post-holder.** `PRD-001` is frozen at Rank 3 and will be read for years. An identifier that changes when someone changes job **is not an identifier**."* | A name in a Rank 3 document is a durability defect |
| 3 | *"**Accountability here is decisional, not personal.** What the governance rules actually require of an owner is the authority to *approve a change*. That authority already attaches to **roles the repository names**."* | The **design intent**: the model deliberately stops at the role |

Reason 1 is decisive and was written before this request existed. The repository
anticipated precisely this pressure and pre-committed against it.

---

## 3. Mechanisms that exist — and what each can and cannot do

Every candidate mechanism in the repository was tested against the actual need.

| Mechanism | Source | Can it record a human incumbent? |
|---|---|---|
| **ADR process** | `ADR-INDEX.md` Process 1-4: *"A decision that changes **structure, ownership**, a boundary, or a platform-wide rule requires an ADR"* | ⛔ **No.** Handles *ownership* in the context/role sense. `ADR-0013`/`0017` reassigned **contexts**; none records a person. Constrained by §7 rule 4 regardless |
| **Ownership Model §7 rule 2** | Domain Owner change → ADR | ⛔ **No.** Changes *which unit* owns a context, not *who staffs it* |
| **Ownership Model §7 rule 3** | Product/Technical Owner change, no ADR needed | ⛔ **No.** Same — role-to-role, and rule 4 binds it |
| **`PRD_REGISTRY.md` Owner field** | §7 rule 5 — register is subordinate to the model | ⛔ **No.** Downstream of the model, inherits the prohibition |
| **`CODEOWNERS`** | — | ⛔ **File does not exist** anywhere in the repository |
| **Branch-protection reviewers** | `BRANCH_PROTECTION_STATUS.md` | ⛔ **No.** `GCP-02` — protection **cannot be enabled** on the Free plan (HTTP 403 on both APIs). Would be a merge control, not a governance appointment |
| **GPG commit signing** | — | ⛔ **No.** 0 signed commits (`%G?` = `N` throughout); a signature is authorship, not appointment |
| **`PRD_LIFECYCLE.md` stage attestations** | Model §5 obligations table | ⛔ **No.** Defines *what each role does* at each stage, never *who* |
| **Team directory** | §7 rule 4 — *"outside the repository"* | ✅ **YES — the designated venue.** Referenced exactly once (L319) and **does not exist in-repo**, correctly, because it is not supposed to |

**Result: 1 of 9 mechanisms can hold a human incumbent, and it lies outside this
repository by explicit instruction.**

---

## 4. Per-role determination

| Role | Incumbent | Evidence | Existing appointment mechanism | Status |
|---|---|---|---|---|
| **Architecture Owner** | ⛔ **NOT FOUND** | Assigned to `PRD-006` at `PRD_OWNERSHIP_MODEL.md` **L163** as *"ARB"*. `ADR-0013`/`0014`/`0015`/`0016`/`0017` all read *"acting through the **Architecture Owner role** defined in §2.2"* — §2.2's table has **no holder column** | **None in-repo.** §7 rule 4 prohibits it | Role **assigned**, incumbent **prohibited from being recorded here** |
| **Product Owner** | ⛔ **NOT FOUND** | Assigned at **L163**. `ADR-0018`/`0019`/`0020` name *"Product owner (freeze authorisation)"* as a **title** | **None in-repo.** §7 rule 3 permits a *role* change without an ADR; rule 4 still bars a name | Same |
| **Governance Owner** | ⛔ **NOT FOUND** | Named only in `ADR-0021` L7 for **D-2**. **Not one of the four §2.2 roles** — §2.1 derives exactly four, and *"A fifth would have no rule to serve"* | **None.** No §4 assignment row exists for it at all | **Weaker than the others** — the role is referenced by an ADR but never established in the model |
| **Security Platform** | ⛔ **NOT FOUND** | Registered as Domain Owner of `PRD-012a` at **L180**. `PRD-006` §32 `ATT-GAP-006` owner: *"Security Platform owner"* | **§7 rule 2** — a Domain Owner change requires an **ADR** (`PRD_REGISTRY.md` §8.6). *This mechanism exists and is available* | Role **registered**; three further obstacles below |

**4 of 4: NOT FOUND.** No role has a recorded human incumbent, and for three of the four
the repository forbids recording one in any in-repo document.

### 4.1 Security Platform — the one role with an available mechanism, and why it still blocks

Unlike the other three, §7 rule 2 gives a **live, exercised** path: an ADR may change a
Domain Owner. `ADR-0013` and `ADR-0017` both did exactly this. But three measured
obstacles remain, and none is a naming problem:

1. **The unit is `[RECONSTRUCTED]`, not observed.** `LIBOORA_ENTERPRISE_ARCHITECTURE.md`
   L88 marks `SECURITY PLATFORM` `[RECONSTRUCTED]`; L50 defines the marker as platforms
   *"**not present in the transmitted text**… therefore **architected to enterprise
   standard**."* The owner was **designed by a document**, not observed in an organisation.
2. **Attached to an unopened document.** L331: *"**confirmation is not execution** —
   `PRD-012a` has not been opened."*
3. **`SECURITY` is a platform, not a bounded context.** `PRD_REGISTRY.md` L253 records
   *"SECURITY platform (rank 2)"*; `PRD_LIFECYCLE.md` Stage 1 requires *"a context
   identified in the **Bounded Context Map**."* No security bounded context exists.

**No new role is proposed** — per instruction, this resolves the **existing registered
role** at L180. An ADR under §7 rule 2 could bind that registered unit to a specific
organizational unit. It **cannot** name a person (rule 4), and it cannot by itself supply
a QR duration.

### 4.2 Governance Owner — a distinct, smaller finding

`ADR-0021` L7 assigns **D-2** to a *"Governance owner"*. This role:
- is **not** among the four derived in §2.1 (*"Four distinct answers. Four roles is
  therefore the minimum… A fifth would have no rule to serve"*);
- has **no** row in §4's assignment tables for any of the 23 PRDs;
- is therefore **referenced by a Proposed ADR without being established in the model**.

Recorded as an observation. **No role is created, renamed or merged here** — that would be
inventing governance. The legitimate reading is that D-2 belongs to whichever established
role owns governance-process questions, and **identifying which is itself an ARB/model
decision**, not a reviewer's.

---

## 5. Legitimate next action

The workflow requested in step 2 **cannot be prepared for in-repo recording**, because §7
rule 4 forbids the record. The legitimate workflow is therefore:

| # | Action | Venue | Authority |
|---|---|---|---|
| **1** | Record the human holders of Architecture Owner, Product Owner and Security Platform in a **team directory outside the repository** | **External** — `PRD_OWNERSHIP_MODEL.md` §7 rule 4 | The organisation. No repository act required or permitted |
| **2** | Those holders then act **through their roles**, exactly as `ADR-0013`/`0014`/`0015`/`0016`/`0017` describe — *"acting through the Architecture Owner role defined in §2.2"* | In-repo, via ADR | ARB / Product Owner |
| **3** | *Optionally*, bind the registered **Security Platform** Domain Owner to an organizational unit by ADR under §7 rule 2 — **a unit, never a person** | In-repo | Architecture Owner |
| **4** | Establish where `ADR-0021`'s **D-2 "Governance owner"** sits among the four §2.2 roles | In-repo | Architecture Owner / model authority |
| **5** | Named holders then supply the outstanding `ATT-GAP-017` answers — defaults **and allowed ranges** for `ATT-CFG-005`, `006`, `014`, `019` (**8 of the 14** required) | In-repo | Product Owner + Security Platform |

**Step 1 is not a governance defect to be fixed — it is the governance design.** The
repository deliberately holds only the decisional structure and delegates personnel
records elsewhere. Nothing in this repository can, or should, complete step 1.

---

## 6. What unlocks after each incumbent exists

| Incumbent recorded | `PRD-006` decisions unlocked |
|---|---|
| **Architecture Owner** | `ATT-CFG-019` OCR threshold *(needs `ADR-0023` option A/B/C/D chosen; option C nominates no candidate)* · `ATT-CFG-014` Face V3 ratification *(+ Security input)* · acceptance-or-rejection of `ADR-0021`, `ADR-0022`, `ADR-0023` · authority to bind the Security Platform unit (§7 rule 2) |
| **Product Owner** | `ADR-0021` **D-1** — the seven values and their ranges · co-authority for the `BC-03` admitting ADR *(with Principal Enterprise Architect + independent reviewer, per `ADR-0018`/`0019`/`0020`)* |
| **Governance Owner** *(once located among the four roles)* | `ADR-0021` **D-2** — whether a CONDITIONAL Stage 3/4 verdict permits Stage 7 |
| **Security Platform** | `ATT-CFG-005` rotation interval + range · `ATT-CFG-006` validity window + range · security input to `ATT-CFG-014` · `ATT-GAP-006` cryptographic construction · contributes to `ATT-GAP-012`, `ATT-GAP-014` |
| **All four together** | `ATT-GAP-017` reaches **14 of 14** answers → the `LIB-16.2` breach clears → one coherent §16.3 amendment (synchronising L1185/1187/1190/1214/1229/2059/2071/2178/2212/2316) → v1.3 → v1.4 → Stage 4 re-review → admitting ADR → Stage 7 freeze |

**Ordering constraint:** the Architecture Owner is first in every chain — it alone
*approves* (§5: *"**Only the Architecture Owner approves.** The others attest, review or
confirm"*), and it is the authority for step 3 and step 4 above.

---

## 7. What this document did **not** do

| Boundary | Held |
|---|---|
| Change or invent a governance role | ✅ None. The Governance Owner observation (§4.2) is **recorded, not resolved** |
| Guess or appoint any person | ✅ None. §1.1 reason 1 quoted as the reason |
| Treat git author / repo owner / Owner-Manager / email as authority | ✅ Rejected — already tested in `PRD-006_HUMAN_AUTHORITY_IDENTIFICATION.md` §2 on four measurements |
| Create a new role for Security Platform | ✅ None. §4.1 resolves the **existing registered** role at L180 |
| Modify `PRD-006`, Registry, Baseline, frozen documents or any ADR status | ✅ 0 changes — 12 protected hashes re-verified |
| Invent a configurable value or range | ✅ None |
| Freeze, accept an ADR, or amend §16.3 | ✅ None attempted — stopped at incumbency resolution as instructed |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created. Determines that **no in-repo appointment mechanism exists for human incumbents, because `PRD_OWNERSHIP_MODEL.md` §7 rule 4 explicitly prohibits one** — *"**Never** record a personal name. If a name is needed operationally, it belongs in a **team directory outside the repository**"* — reinforced by §6 Compliance rule 3 (*"No row names a person"*) and justified by §1.1's three reasons, the first being that *"a fabricated owner is worse than an absent one — it terminates the search for a real one."* Nine candidate mechanisms tested; **1 of 9** can hold a human incumbent, and it is external by design. Genuine role-level mechanisms **do** exist and are distinguished from the request: §7 rule 2 (Domain Owner change → ADR, as exercised by `ADR-0013`/`ADR-0017`) and §7 rule 3 (Product/Technical Owner, no ADR). All four roles report **NOT FOUND**. Security Platform is the one role with an available mechanism but carries three further obstacles — `[RECONSTRUCTED]` per EA L50/L88, unopened `PRD-012a` per L331, and platform-not-bounded-context blocking `PRD_LIFECYCLE.md` Stage 1. A distinct smaller finding is recorded: `ADR-0021`'s **"Governance owner"** is **not** among the four roles §2.1 derives and has no §4 assignment row — observed, not resolved, since establishing it is itself a model decision. Concludes that the blocker is an **external organisational act, not a repository defect**. No role changed or invented, no person guessed or appointed, no value supplied, no document modified. |
