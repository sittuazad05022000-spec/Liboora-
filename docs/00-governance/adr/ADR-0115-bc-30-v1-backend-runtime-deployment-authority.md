# `ADR-0115` — V1 `BC-30` Offline Sync backend/runtime and deployment locus

| Field | Value |
|---|---|
| **Status** | **Proposed** — under consideration; not binding |
| **Date** | 2026-09-08 |
| **Deciders** | **Architecture Owner / Architecture Review Board (ARB)** — required for acceptance; no acceptance or ratification is exercised by this draft |
| **Subject** | V1 `BC-30` Offline Sync backend/runtime and deployment locus |
| **Supersedes / amends** | Nothing |
| **Decision owner** | Architecture Owner for the D1 decision act; the accepted decision must name the separate deployment authority/operator, if one exists |
| **Related authority** | `ADR-0114` (accepted capability ownership and execution context), `MASTER_PRD.md` `MP-CON-02` and L227, `ADR-0100`, `ADR-0045`, `PRD-001`, `PRD-006` |
| **Implementation authorised** | **No** |

> **This is a decision draft, not an approval.** It selects no vendor or runtime, treats no
> candidate as authority, changes no frozen artifact, and leaves Item 4 **BLOCKED**.

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

The repository contains no approved provider/runtime decision. The option table therefore
does not confer authority, narrow the Architecture Owner's choice, or substitute for the
required accepted ADR act.

## 4. Authority boundary

| Authority | Boundary |
|---|---|
| **Architecture Owner / ARB** | Accepts or rejects this ADR; decides the V1 runtime/deployment locus and the architecture-level boundary that `BC-30` must execute within |
| **Deployment authority** | Must be named by the accepted decision; operates the approved deployment locus, environments, release process, runtime availability and secret custody |
| **Technical Owner** | Implements only after acceptance and sequences authorised work; does not approve the runtime or replace the Architecture Owner |
| **BC-03 / Domain Owner** | Owns Attendance business rules and conflict policy; does not select the deployment locus |

`MP-CON-02` prevents treating a deployment choice as an architecture fact. The accepted
ADR must nevertheless record the Architecture Owner's approval boundary and the deployment
authority's operational boundary so neither is inferred from a candidate or from the EA.

## 5. Security and secrets accountability

The accepted decision must make the deployment authority accountable for server-side
credential custody, rotation, access control, auditability and runtime exposure, subject to
the authorization and fail-closed rules in `PRD-001`. No credential, provider contract,
secret format, encryption mechanism or retention period is invented here. Security review
and any required control owner must be named by the accepting governance act rather than
assumed from the runtime option.

## 6. Dependency impact

| Item | Effect of accepting this ADR |
|---|---|
| **Item 3 — Durable Queue** | Direct Item 4 dependency is removed; Item 3 becomes eligible for its own queue/durability authority and design. It is not automatically resolved. |
| **Item 5 — Retry/Backoff** | Direct Item 4 dependency is removed; retry/backoff remains open and requires its own policy/value authority. |
| **Item 9b — At-rest** | Remains blocked behind Item 3; no automatic unblock. |
| **Item 7b — Queue Depth** | Remains blocked behind Item 3; no automatic unblock. |

Until this ADR is accepted, Item 4 remains **BLOCKED**, Items 3 and 5 remain blocked/open,
and Items 9b and 7b remain transitively blocked. 7a retention and 8b-residual remain
independent owner decisions.

## 7. Required acceptance and post-acceptance path

Acceptance requires an explicit, scoped **Architecture Owner / ARB** ratification. A
`Proposed` ADR is not binding and cannot authorise implementation. On acceptance:

1. record the selected runtime/deployment locus and named deployment authority in this ADR;
2. update Rank-1 `MASTER_PRD.md` L227 from candidate-only wording to the accepted authority,
   in the same governed change sequence required by the ADR process;
3. re-check Items 3, 5, 9b and 7b against the accepted scope; and
4. begin implementation only through separately authorised work.

No PRD-018, frozen PRD/ADR, `TASK-D10` or `IMPL-020` change is part of this draft.

## 8. Changelog

| Version | Date | Change |
|---|---|---|
| v0.1 | 2026-09-08 | Created as a **Proposed** Architecture Owner decision package. Records the unresolved V1 runtime/deployment authority question, option evidence, authority boundary, security/secrets accountability and downstream dependency impact. No vendor/runtime selected; no implementation authorised. |