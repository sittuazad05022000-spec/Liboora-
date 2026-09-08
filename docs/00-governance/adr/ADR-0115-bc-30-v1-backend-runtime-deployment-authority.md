# `ADR-0115` — V1 `BC-30` Offline Sync backend/runtime and deployment locus

| Field | Value |
|---|---|
| **Status** | ⭐ **Accepted** — 2026-09-08. The two follow-up gaps that held this ADR at *Accepted-in-principle/Execution-blocked* are now **closed**: the deployment locus office and the server-side secret-custody owner are **named** in §8. ⛔ **Acceptance of the ownership boundary is NOT implementation authority** — `Implementation authorised` remains **No**, and no runtime, vendor or value is selected |
| **Date** | 2026-09-08 |
| **Deciders** | **Architecture Owner / Architecture Review Board (ARB)** — accepted in principle on 2026-09-08 from the repository evidence; this act does not select a runtime or confer implementation authority |
| **Subject** | V1 `BC-30` Offline Sync backend/runtime and deployment locus |
| **Supersedes / amends** | Nothing |
| **Decision owner** | Architecture Owner for the architecture boundary and the deployment-locus office (§8.2); **SECURITY PLATFORM** for server-side secret custody (§8.1). Both named under one-act conferrals recorded in §8 |
| **Related authority** | `ADR-0114` (accepted capability ownership and execution context), `MASTER_PRD.md` `MP-CON-02` and **L227 (Rank-1 `Architectural owner` = INFRASTRUCTURE, runtime *"candidate only"* — see §8.2)**, `ADR-0100`, `ADR-0045`, `PRD-001`, `PRD-006` |
| **Implementation authorised** | ⛔ **No** — unchanged. Naming an accountable office is not permission to build. Items 3, 5, 9b and 7b are re-audited in §9 |
| **One-act conferrals** | Three, from the human principal, 2026-09-08 — SECURITY PLATFORM (secret custody) · Architecture Owner (deployment locus) · Governance Owner (`ADR-INDEX` re-derivation). ⛔ **None is a standing licence** (`ADR-0033` §7.1) |

> ⚠⚠ **READ THIS FIRST.** This ADR now **names who is accountable**. It still **selects no vendor, runtime, product,
> database or cloud account**, treats no candidate as authority, and changes no frozen artifact. Item 4's *authority*
> gap is closed; Item 4's *runtime selection* was never in scope and remains undone — see §9.

## 1. Decision required

The Architecture Owner must decide and record the authoritative V1 backend/runtime and
deployment locus for `BC-30` Offline Sync. The accepted decision must identify where the
following execute and who is accountable for operating that locus:

1. queue capture handoff and server-side processing;
2. durable queue/storage persistence across restart;
3. replay execution and its runtime boundary; and
4. server-side credential custody and use.

This is the minimum decision needed to remove Item 4's authority gap. It is not permission
to implement the queue, replay policy, retry policy or storage mechanism.

## 2. Exact scope and boundary

| In scope for the decision | Explicitly not decided by this draft |
|---|---|
| The V1 execution/deployment locus for `BC-30` queue capture, durable storage and replay | A vendor, product, SDK, database, cloud account or runtime option |
| The boundary at which server-side credentials are held and used | Retry/backoff values (Item 5) |
| The operational authority responsible for deployment, secrets, runtime health and release of the selected locus | Queue schema, durability implementation, queue-depth value or at-rest mechanism |
| The relationship between Architecture Owner approval and deployment authority execution | Attendance business rules, conflict policy, retention, or replay disposition |

`BC-03` remains the Attendance business-capability owner. `BC-30` remains the bounded
context and execution mechanism under accepted `ADR-0114`; `E-24` and `PRD-018` are
unchanged. This draft does not reopen or reinterpret `ADR-0114`.

## 3. Options and repository evidence

These are decision shapes for Architecture Owner review, not recommendations or approvals:

| Option shape | Repository evidence | Status in this draft |
|---|---|---|
| Managed backend/runtime service | `MASTER_PRD.md` L227 records a BaaS class as **candidate only**; `MP-CON-02` calls the choice a deployment decision | Not selected |
| Dedicated backend service operated by the team | `IMPL-020` measures this as an alternative and records that the repository does not specify deployment | Not selected |
| Direct provider calls from the Flutter client | `PRD-001`'s credential/authorization boundary and `IMPL-020` reject placing server credentials in the client | Rejected by existing security boundary; not a runtime selection |

The repository contains no approved provider/runtime decision. This accepted-in-principle act preserves that boundary; it does not confer runtime authority, name a deployment operator, or assign server-side secret custody.

## 4. Authority boundary

| Authority | Boundary |
|---|---|
| **Architecture Owner / ARB** | Accepts this governance boundary in principle and decides the architecture-level scope; does not by itself name the deployment operator or secret-custody owner |
| **Deployment authority** | ⭐ **NAMED in §8.2** — **INFRASTRUCTURE** owns the deployment locus (compute, persistence substrate, DR, availability); **DEVOPS PLATFORM** owns delivery onto it (CI/CD, release, rollback, environments). ⛔ Secret custody is **not** theirs — see §8.1. *(Prior text, true until 2026-09-08: "Unassigned at acceptance; must be named before execution…")* |
| **Technical Owner** | Implements only after the final runtime/deployment and operational assignments are recorded; does not approve the runtime or replace the Architecture Owner |
| **BC-03 / Domain Owner** | Owns Attendance business rules and conflict policy; does not select the deployment locus |

`MP-CON-02` prevents treating a deployment choice as an architecture fact. The accepted
ADR must nevertheless record the Architecture Owner's approval boundary and the deployment
authority's operational boundary so neither is inferred from a candidate or from the EA.

## 5. Security and secrets accountability

Before execution, the named deployment authority and secret-custody/control owner must be accountable for server-side credential custody, rotation, access control, auditability and runtime exposure, subject to the authorization and fail-closed rules in `PRD-001`.

⭐ **Both assignments are now made:** server-side secret custody to **SECURITY PLATFORM** (§8.1), and the
deployment locus to **INFRASTRUCTURE** with **DEVOPS PLATFORM** delivering onto it (§8.2). *(This paragraph
previously read "Both assignments remain **unassigned follow-up gaps**" — true when written on 2026-09-08 and
corrected here rather than deleted.)* ⛔ No credential, provider contract, secret format, encryption mechanism
or retention period is invented here.

## 6. Dependency impact

| Item | Effect of accepting this ADR |
|---|---|
| **Item 3 — Durable Queue** | Remains blocked by Item 4's unresolved runtime/deployment and operational assignments; no queue implementation or durability value is authorised. |
| **Item 5 — Retry/Backoff** | Remains blocked/open behind Item 4; retry/backoff remains without policy/value authority. |
| **Item 9b — At-rest** | Remains blocked behind Item 3; no automatic unblock. |
| **Item 7b — Queue Depth** | Remains blocked behind Item 3; no automatic unblock. |

⚠ **SUPERSEDED BY §9 — read §9, not this table.** The table above and the paragraph below were written at
`v0.2`, when both ownership gaps were open. They are **retained verbatim because they were true then**, and
because deleting them would erase the record of what acceptance-in-principle actually withheld.

*(Prior text, `v0.2`:)* *"This in-principle acceptance does not remove the execution block: Item 4 remains
**BLOCKED** pending a named deployment operator and server-side secret-custody owner; Items 3 and 5 remain
blocked/open, and Items 9b and 7b remain transitively blocked. 7a retention and 8b-residual remain independent
owner decisions."*

⭐ **What changed at `v1.0`:** §8 names both owners, so **Item 4's authority limb is RESOLVED** and Items 3 and
5 become **eligible — not resolved**. ⛔ **Item 4's runtime-selection limb remains BLOCKED**, and 9b/7b remain
blocked behind Item 3. **§9 is the current dependency statement.**

## 7. Required acceptance and post-acceptance path

The Architecture Owner / ARB accepted this ADR **in principle** on 2026-09-08, then **fully** on 2026-09-08 once §8 closed the two ownership gaps. ⛔ **Acceptance is still not a runtime selection and still cannot authorise implementation.** Before execution, a follow-up governed act must:

1. record the selected runtime/deployment locus — ⛔ **STILL OWED**; `MASTER_PRD` **L227** remains *"candidate only"*;
2. ~~name the deployment authority/operator~~ — ✅ **DONE, §8.2** (INFRASTRUCTURE; DEVOPS PLATFORM delivers);
3. ~~name the server-side secret-custody/control owner~~ — ✅ **DONE, §8.1** (SECURITY PLATFORM);
4. update Rank-1 `MASTER_PRD.md` L227 only if the final accepted authority requires it;
5. re-check Items 3, 5, 9b and 7b against the completed assignments; and
6. begin implementation only through separately authorised work.

No PRD-018, frozen PRD/ADR, `TASK-D10` or `IMPL-020` change is part of this act.

## 8. ⭐ Ownership assignments — the two gaps, closed

**Authority.** Three one-act conferrals were made by the human principal on 2026-09-08, in the form
`PRD_OWNERSHIP_MODEL.md` §13 and `ADR-0102` establish. ⛔ **Each is limited to the act named. None is a
standing licence** — `ADR-0033` §7.1: *"A conferral for one act is not a standing licence."* ⛔ **No holder
is appointed and no personal name is recorded** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4).

### 8.1 Server-side secret custody → **SECURITY PLATFORM**

| | |
|---|---|
| **Office** | **SECURITY PLATFORM** |
| **Scope** | Server-side credential custody, rotation, access control, auditability and runtime exposure **for the V1 `BC-30` Offline Sync runtime only** |
| **Conferral** | Human principal, one act, 2026-09-08 |

⭐ **The office is not invented — it is the one FROZEN `PRD-012a` already names**, so the conferral fills an
existing office rather than creating a role:

| Evidence | Text |
|---|---|
| **`SECP-OWN-001`** | *"Secrets & key vault, encryption … \| **SECURITY PLATFORM** \| **Owner.**"* |
| **`SECP-OWN-009`** | DEVOPS PLATFORM owns CI/CD and `Secrets in Pipeline`, but *"Owns the **vault** the pipeline reads — the EA marks it **[vault owned by SECURITY PLATFORM]**"* |
| **`SECP-OWN-008`** | INFRASTRUCTURE's `Infrastructure Security Baseline` is *"**[policy owned by SECURITY PLATFORM]**"* |
| **`MP-NFR-05`** (Rank 1, L499) | *"Security \| Zero trust, **secrets management**, encryption, threat detection \| **SECURITY**"* |

⭐ **Two adjacent offices were tested and both point away from themselves**: DEVOPS *reads* the vault, and
INFRASTRUCTURE *implements* a baseline whose policy Security owns. **Nothing was chosen; the convergence was
measured.**

### 8.2 Deployment locus → **INFRASTRUCTURE**, with **DEVOPS PLATFORM** delivering to it

| | |
|---|---|
| **Deployment locus office** | **INFRASTRUCTURE** |
| **Release/delivery office** | **DEVOPS PLATFORM** |
| **Decided by** | Architecture Owner, one-act conferral, 2026-09-08 |

⭐ **The split was resolved by matching each office's own declared scope to what §1 actually asks**, not by
preference. §1 requires the locus to answer *where* four things happen: queue-capture handoff and
server-side processing · durable persistence **across restart** · replay execution and its runtime boundary ·
server-side credential use.

| Office | Declared scope | Fit to §1 |
|---|---|---|
| **INFRASTRUCTURE** | ⭐⭐ **Rank 1 `MASTER_PRD` L227 — `Backend runtime` → `Architectural owner` = INFRASTRUCTURE (R1)**; `SECP-OWN-008` — *"Cloud foundation, **compute**, networking, CDN/edge, **backup, DR**"*; EA row 24 — *"Cloud Foundation, Compute, Networking, Regions & Availability, **Scaling**, **Disaster Recovery**, Capacity Planning"* | ✅ **Owns the execution and persistence substrate** — and is **already the Rank-1 architectural owner of `Backend runtime`**; compute answers *where it runs*, backup/DR answers *survives restart* |
| **DEVOPS PLATFORM** | `SECP-OWN-009` — *"CI/CD, release engineering, `Secrets in Pipeline`"*; EA row 22 — *"CI Pipeline, CD Pipeline, Release Engineering, Mobile Release Management, IaC, DB Migration Automation, **Rollback Automation**"* | ⚠ **Owns the pipeline that ships to the locus, not the locus** — every item is an act *upon* a runtime |

⛔ **This is a division of accountability, not a merger.** INFRASTRUCTURE is accountable for the locus
(compute, persistence substrate, DR, availability); DEVOPS PLATFORM is accountable for delivering onto it
(pipeline, release, rollback, environments). Neither absorbs the other, and **neither gains secret custody** —
that is §8.1's.

⭐⭐ **RANK-1 CORROBORATION, FOUND DURING POST-WRITE VALIDATION AND RECORDED WITH ITS PROVENANCE.** The
assignment above was first reached from `PRD-012a` and the EA alone. While validating that `MASTER_PRD.md`
was byte-unchanged I re-read **L227** in full and found that its **second column is `Architectural owner`**
and that column already reads **`INFRASTRUCTURE (R1)`** for **`Backend runtime`**:

| Capability | Architectural owner | Abstraction that must exist | Candidate implementation (V1) | Approved in EA v2.1? |
|---|---|---|---|---|
| Backend runtime | **INFRASTRUCTURE (R1)** | — | BaaS (e.g. Supabase) for V1 | **Not named in EA** — candidate only |

⭐ **So the deployment-locus office was already assigned at Rank 1**, and §8.2 **conforms to** that assignment
rather than creating it — which is the strongest possible footing and materially reduces the weakness disclosed
below. ⚠ **I did not have this when I decided, and I am not backdating it:** the conferred Architecture Owner
act stands on its own, and this row is corroboration discovered afterwards. ⚠⚠ **The same line also proves the
runtime limb is still shut:** *"candidate implementation"* and *"**candidate only**"* sit in columns **4 and 5**
of the very same row — Rank 1 names the **owner** and expressly declines to name the **runtime**. That is
exactly the two-limb split §9 records, now visible in a single line of `MASTER_PRD`. ⛔ **L227 is byte-unchanged.**

⚠ **A real weakness in this evidence is disclosed rather than hidden.** EA rows 22 and 24 are both
`[RECONSTRUCTED]` and both describe the office as *"Absent"* — meaning the EA is **describing platforms that
do not yet exist**. The scopes are nevertheless the repository's own, they are corroborated independently by
FROZEN `PRD-012a`'s `SECP-OWN-008`/`009`, and the EA is **Rank 6 descriptive** so it is read as evidence, never
as the grant. **The grant is the Architecture Owner's conferred act; the EA and `PRD-012a` are its basis.**

### 8.3 ⛔ What §8 does NOT do

- ⛔ **Selects no runtime, vendor, product, SDK, database, cloud account or region.** `MASTER_PRD` **L227**
  remains *"candidate only"* and is **byte-unchanged**; `MP-CON-02` is preserved.
- ⛔ **Authorises no implementation** — no queue, replay, retry, storage, schema or at-rest mechanism.
- ⛔ **Invents no** retry count, backoff, retention period, queue limit, encryption algorithm or secret format.
- ⛔ **Appoints no person** and confers no standing authority on any office.
- ⛔ **Does not reopen `ADR-0114`**, `PRD-018`, any frozen PRD, `TASK-D10` or `IMPL-020`.

---

## 9. Dependency re-audit after §8

⭐⭐ **Item 4 had two limbs. Exactly one of them closes here, and conflating them would be the easiest way to
make this ADR look finished when it is not.**

| Item | Before | After §8 | Reason |
|---|---|---|---|
| **Item 4 — authority limb** | 🔒 BLOCKED | ✅ **RESOLVED** | Deployment locus office and secret-custody owner are both named (§8.1, §8.2) |
| **Item 4 — runtime-selection limb** | 🔒 BLOCKED | 🔒 **STILL BLOCKED** | `MASTER_PRD` **L227** columns 4–5 still read *"BaaS (e.g. Supabase)"* / *"Not named in EA — **candidate only**"* — the **same row** whose column 2 supplies the owner, so Rank 1 names the office and withholds the runtime in one line. §2 excluded vendor selection from this ADR's scope, and §7 item 1 still requires a follow-up act to *"record the selected runtime/deployment locus"* |
| **Item 3 — durable queue** | 🔒 BLOCKED | ⛔ **OPEN — eligible, not resolved** | An accountable office (INFRASTRUCTURE) now exists to decide it. ⛔ No durability mechanism, technology or guarantee is authorised or stated |
| **Item 5 — retry/backoff** | ⛔ OPEN | ⛔ **OPEN — eligible, not resolved** | Architecture Owner + Product Owner may now act. ⛔ `PRD-006` **L2332** still governs: *"none may be invented"* |
| **Item 9b — on-device at-rest** | 🔒 BLOCKED | 🔒 **BLOCKED behind Item 3** | Owner clarified as **SECURITY PLATFORM** (`MP-NFR-05`), but nothing to protect until Item 3 lands |
| **Item 7b — queue depth** | 🔒 BLOCKED | 🔒 **BLOCKED behind Item 3** | `MP-NFR-04` backpressure; no value authorised |
| **7a — retention** | ⛔ OPEN | ⛔ **OPEN — untouched** | Independent. `Q-04` open; `ATT-GAP-005` bars promoting the unratified note |
| **8b-residual — queued item on revoked access** | ⚠ | ⚠ **REQUIRES OWNER DECISION — untouched** | Independent. Product Owner + `BC-03` Domain Owner |

⛔ **Items 3 and 5 move from *blocked* to *eligible*, which is not the same as resolved**, and they are not
recorded as resolved anywhere in this ADR.

---

## 10. Changelog

| Version | Date | Change |
|---|---|---|
| v0.1 | 2026-09-08 | Created as a **Proposed** Architecture Owner decision package. Records the unresolved V1 runtime/deployment authority question, option evidence, authority boundary, security/secrets accountability and downstream dependency impact. No vendor/runtime selected; no implementation authorised. |
| v0.2 | 2026-09-08 | Recorded Architecture Owner / ARB acceptance in principle from repository evidence. Preserved Item 4 as **BLOCKED** and explicitly left the deployment operator and server-side secret-custody owner as unassigned follow-up gaps; no runtime/vendor or implementation authority was invented. |
| **v1.0** | 2026-09-08 | ⭐⭐ **ACCEPTED. The two follow-up ownership gaps are CLOSED (§8), under three one-act conferrals from the human principal — none a standing licence (`ADR-0033` §7.1).** ⭐ **§8.1 server-side secret custody → SECURITY PLATFORM**, the office FROZEN `PRD-012a` already names: `SECP-OWN-001` (*"Owner"*), and the two adjacent offices point away from themselves — `SECP-OWN-009` says DEVOPS reads a vault *"[owned by SECURITY PLATFORM]"* and `SECP-OWN-008` says INFRASTRUCTURE implements a baseline whose *"[policy owned by SECURITY PLATFORM]"*; corroborated by Rank-1 `MP-NFR-05` L499. ⭐ **§8.2 deployment locus → INFRASTRUCTURE, with DEVOPS PLATFORM delivering onto it** — resolved by matching each office's declared scope to what §1 asks (*where* it runs, persists across restart, replays): INFRASTRUCTURE owns compute/persistence/DR (`SECP-OWN-008`, EA row 24) while every DEVOPS item (`SECP-OWN-009`, EA row 22) is an act **upon** a runtime, not the runtime. ⭐⭐ **RANK-1 CORROBORATION FOUND DURING POST-WRITE VALIDATION AND RECORDED WITH ITS PROVENANCE:** re-reading `MASTER_PRD.md` **L227** to confirm it was byte-unchanged revealed that its **second column is `Architectural owner`** and already reads **`INFRASTRUCTURE (R1)`** for **`Backend runtime`** — so §8.2 **conforms to an existing Rank-1 assignment instead of creating one**. ⚠ **Not backdated:** the decision was reached from `PRD-012a` + EA before this row was seen, and §8.2 says so. ⚠⚠ **The same row also proves the runtime limb stays shut** — its columns 4–5 read *"BaaS (e.g. Supabase)"* / *"candidate only"*, so **Rank 1 names the office and withholds the runtime in one line**, which is precisely the two-limb split. ⚠ **Weakness disclosed, not hidden:** EA rows 22/24 are both `[RECONSTRUCTED]` and describe the offices as *"Absent"* — read as Rank-6 descriptive evidence only; the grant is the conferred Architecture Owner act, corroborated by FROZEN `PRD-012a` and now by Rank-1 L227. ⚠ **A defect in my own draft was found and fixed before commit:** the header rows and callout cited **§9/§10** for the ownership assignments and the re-audit after the new sections were inserted, when they are **§8/§9**; all self-references were re-enumerated mechanically against the heading list and now resolve. ⭐⭐ **ITEM 4'S TWO LIMBS ARE SEPARATED RATHER THAN CONFLATED (§9): the AUTHORITY limb is RESOLVED; the RUNTIME-SELECTION limb REMAINS BLOCKED** because `MASTER_PRD` **L227** still reads *"candidate only"* — §7 item 1 is still owed. ⚠ **Items 3 and 5 become ELIGIBLE, NOT RESOLVED**; **9b and 7b stay blocked behind Item 3**; **7a and 8b-residual untouched**. ⛔ **NOTHING INVENTED:** no vendor, runtime, product, database, cloud account, retry count, backoff, retention period, queue limit, encryption algorithm or secret format; no person appointed; no standing authority. ⛔ **`Implementation authorised` remains NO.** ⛔ `MASTER_PRD.md`, `ADR-0114`, every frozen PRD, `TASK-D10` and `IMPL-020` **byte-unchanged**. |