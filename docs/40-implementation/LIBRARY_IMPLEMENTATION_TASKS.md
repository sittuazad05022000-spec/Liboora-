# Library Management — Implementation Tasks

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Date** | 2026-08-03 |
| **Specifications** | [`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) · [`14A`](../30-product/library/14A-Library-Discovery-And-Enrollment.md) · [`14B`](../30-product/library/14B-Public-Library-Preview.md) · [`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) |
| **Status** | **All tasks OPEN.** Nothing here is implemented |

---

## 0. Read this first

**Every task in this document is unstarted.** No line of Library Management code
exists in the repository. `lib/` currently contains an authentication prototype and
a small domain sketch; there is no tenancy module, no library aggregate, no public
projection and no invitation mechanism.

This document is written so that a developer can start without asking a question.
Where a task has a prerequisite, the prerequisite is named. Where a task can be
done wrongly in a way that passes tests, the trap is described.

### 0.1 Why these are tasks and not closed documentation issues

Per the governing instruction: *"If an issue is an implementation task (such as
SMS Provider integration or D-10 demo account removal), do not mark it closed."*

Writing a specification does not create a schema, a projection or a rate limiter.
The documentation for Library Management is complete; the **software does not
exist**. These tasks track that honestly.

---

## 1. Task register

### 1.1 Identifier range — why these start at 100

`IMPL-014` … `IMPL-073` are allocated to authentication and release readiness by
[`IMPLEMENTATION_ROADMAP.md`](./IMPLEMENTATION_ROADMAP.md). In particular
`IMPL-070`…`IMPL-073` are the **Phase 7 release-readiness** tasks — NFR verification,
compliance verification, error classification and final acceptance.

Library Management therefore begins at **`IMPL-100`**. A task number is never reused
and never reassigned, for the same reason an ADR number is not: cross-references in
commit messages, review comments and test names outlive the document that created them.

| Range | Owner | Grouping |
|---|---|---|
| `IMPL-014` … `IMPL-073` | Authentication, platform, release readiness | `IMPLEMENTATION_ROADMAP.md` |
| **`IMPL-100` … `IMPL-109`** | **Library core** — tenancy, lifecycle, profile, structure, hours, facilities, settings, policies, branding | This document |
| **`IMPL-110` … `IMPL-114`** | **Invitations** — artefact, lifecycle, `IT-1`, `IT-2`/`IT-3`, rate limiting | This document |
| **`IMPL-120` … `IMPL-127`** | **Public surfaces** — projection, preview, search, protected-operation gate, intent, rate limiting, events, config validation | This document |
| `IMPL-128` + | Unallocated | — |

The gaps at `IMPL-115`–`119` and after `IMPL-127` are deliberate. Each group can grow
without renumbering its successors.

### 1.2 The tasks

| ID | Task | Priority | Blocks | Blocked by |
|---|---|---|---|---|
| `IMPL-100` | Tenant foundation — `TenantOrganisation`, tenant key enforcement | **P0** | Everything | — |
| `IMPL-101` | Library lifecycle state machine | **P0** | `102`, `120` | `100` |
| `IMPL-102` | Library profile + validation | **P0** | `120` | `100`, `101` |
| `IMPL-103` | Audit log infrastructure | **P0** | All administrative tasks | `100` |
| `IMPL-104` | Branch, floor, zone structure | P1 | `106` | `100` |
| `IMPL-105` | Operating hours, holidays, emergency closure | P1 | `120` | `100`, `104` |
| `IMPL-106` | Facilities reference list + associations | P1 | `120` | `104` |
| `IMPL-107` | Library settings via `BC-25` | P1 | — | `100` |
| `IMPL-108` | Business policies | P2 | — | `100`, `105` |
| `IMPL-109` | Branding + media via `BC-29` | P2 | `120` | `100` |
| `IMPL-110` | Invitation artefact core — generation, storage, validation | **P0** | `111`–`113` | `100`, `103` |
| `IMPL-111` | Invitation lifecycle — expiry, revocation, consumption | **P0** | `112`, `113` | `110` |
| `IMPL-112` | Staff invitation `IT-1` + role grant delegation | **P0** | — | `111`, `IMPL-020` |
| `IMPL-113` | Private library invitation `IT-2`/`IT-3` | P1 | — | `111` |
| `IMPL-114` | Invitation rate limiting + abuse detection | **P0** | — | `110`, `IMPL-021` |
| `IMPL-120` | Public read projection | **P0** | `121`–`123` | `101`, `102`, `105`, `106` |
| `IMPL-121` | Public preview endpoint | **P0** | — | `120` |
| `IMPL-122` | Public discovery search | P1 | — | `120` |
| `IMPL-123` | Protected-operation gate `PO-1`…`PO-12` | **P0** | — | `120` |
| `IMPL-124` | Intent preservation + resumption | **P0** | — | `123` |
| `IMPL-125` | Public endpoint rate limiting | **P0** | — | `IMPL-021` |
| `IMPL-126` | Library event emission `LEV-1`…`LEV-28` | P1 | `120` | `100` |
| `IMPL-127` | Extend startup config validation for `LCFG-*`/`ICFG-*` | **P0** | — | `IMPL-015` |

**23 tasks. 12 are P0.**

---

## 2. Critical path

```
IMPL-015 (config validation, existing)
    │
    ├──► IMPL-127  extend for LCFG-* / ICFG-*
    │
IMPL-100 tenant foundation ◄── nothing starts before this
    │
    ├──► IMPL-103 audit log ──────────────┐
    │                                     │
    ├──► IMPL-101 lifecycle               │
    │        └──► IMPL-102 profile        │
    │                 │                   │
    ├──► IMPL-105 hours ──┐               │
    ├──► IMPL-104 structure┤              │
    ├──► IMPL-106 facilities┤             │
    │                       ▼             │
    │              IMPL-120 public projection
    │                       │
    │                       ├──► IMPL-121 preview endpoint
    │                       ├──► IMPL-122 discovery search
    │                       └──► IMPL-123 protected-operation gate
    │                                 └──► IMPL-124 intent preservation
    │                                     │
    └──► IMPL-110 invitation core ◄───────┘
             └──► IMPL-111 lifecycle
                      ├──► IMPL-112 staff invite ◄── needs IMPL-020 (SMS)
                      └──► IMPL-113 private invite
```

`IMPL-100` gates everything. `IMPL-112` additionally waits on `IMPL-020` (SMS
provider), which is already the platform's longest external dependency because DLT
registration in India takes weeks.

---

## 3. P0 task detail

### `IMPL-100` — Tenant foundation

**Implements** `LIB-18.1`, `LIB-18.2`, `LIB-18.8`, `LIB-19.1`, `LXC-10`
**Authority** `MP-GBR-08`, `SE-1`, `X-13`

| Step | Action |
|---|---|
| 1 | Create `platform/tenancy` module at dependency rank 4 |
| 2 | Define `TenantOrganisation` with an opaque, non-sequential identifier |
| 3 | Implement tenant context propagation — explicit parameter, not ambient state |
| 4 | Enforce the tenant key at the data-access boundary. A tenant-less query is **refused**, never defaulted |
| 5 | Add a conformance test asserting that a tenant-less query throws |
| 6 | Add a conformance test asserting cross-tenant reads return nothing regardless of role |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-70-1` | A query without a tenant key raises, and does not fall back to a default tenant |
| `AC-70-2` | Tenant identifiers are opaque — not sequential, not derived from name, number or PIN |
| `AC-70-3` | No code path returns another tenant's row, at any role including Platform Administrator |
| `AC-70-4` | Tenant context is passed explicitly; no thread-local or global holds it |

> **The trap.** Ambient tenant context (a thread-local, a global, a request-scoped
> singleton) is the standard approach and it is what causes cross-tenant leaks. The
> leak happens on the one code path that runs outside the request — a background
> job, a projection rebuild, a retry — where the ambient value is stale or unset. An
> explicit parameter makes that path a compile error.

---

### `IMPL-103` — Audit log infrastructure

**Implements** `LIB-19.4`…`LIB-19.7`, `LBR-6`
**Authority** `AUTH-9.57`

| Step | Action |
|---|---|
| 1 | Append-only audit store. No update, no delete, at any privilege |
| 2 | Record actor account, role, tenant, action, target, prior value, new value, timestamp, source |
| 3 | Make records unreachable by any library role's write path, including `TR-1` Owner |
| 4 | Implement erasure-safe redaction preserving fact and timing while removing identity |
| 5 | Configuration history reconstructable to any past moment (`LIB-19.7`) |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-73-1` | No API, query or migration permits editing or deleting an audit record |
| `AC-73-2` | Every administrative change carries all nine attributes |
| `AC-73-3` | After account erasure, records retain fact and timing and no longer identify the person |
| `AC-73-4` | Configuration at an arbitrary past timestamp is reconstructable |

> **Build this before the features it audits, not after.** `LIB-23.3` makes audit
> logging V1 precisely because a configuration change made before audit exists is
> permanently unreconstructable. Retrofitting audit means the first weeks of
> production data have no history.

---

### `IMPL-110` — Invitation artefact core

**Implements** `INV-SEC-008`…`INV-SEC-015`, `INV-SEC-042`…`INV-SEC-047`
**Authority** `ADR-0009`

| Step | Action |
|---|---|
| 1 | CSPRNG token generation. **Not** UUIDv4, not timestamp, not counter, not hash of tenant data |
| 2 | Entropy per type: `IT-1` 128 bits · `IT-2` 128 bits · `IT-3` ≥ 40 bits, 8 chars |
| 3 | `IT-3` alphabet excludes `0`/`O`, `1`/`I`/`l`; validation is case-insensitive |
| 4 | Tokens are **opaque** — encode nothing (`INV-SEC-011`) |
| 5 | Store salted hash only. Plaintext exists transiently, for delivery |
| 6 | Constant-time comparison |
| 7 | Implement all nine validation conditions in order (§7 table) |
| 8 | **All refusals observably identical** — same shape, same message, same timing class |
| 9 | Assert no token reaches a log, event, error, crash report or audit record |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-80-1` | Tokens are CSPRNG-generated at the specified entropy |
| `AC-80-2` | Plaintext is unrecoverable after creation, including by an Owner |
| `AC-80-3` | Grep of logs, events and audit records for a known token yields nothing |
| `AC-80-4` | All nine refusal conditions produce identical responses **including latency distribution** |
| `AC-80-5` | An invalid presentation discloses nothing about library existence, name or state |
| `AC-80-6` | A valid `IT-2`/`IT-3` reveals only §14A.5 fields pre-authentication |

> **`AC-80-4` needs a timing test, not a response-body test.** A validator that
> short-circuits on "not found" before reaching the constant-time compare is
> measurably faster, and that difference enumerates the platform's private
> libraries. Test the latency distribution, not just the payload.

---

### `IMPL-111` — Invitation lifecycle

**Implements** `INV-SEC-016`…`INV-SEC-041`

| Step | Action |
|---|---|
| 1 | Absolute expiry at creation, server-evaluated. An invitation without expiry is uncreatable |
| 2 | Expiry unoverridable by any role, including `TR-1` Owner |
| 3 | Revocation immediate and global — **no propagation window** (`MP-GBR-26`) |
| 4 | Revocation irreversible; record retained and marked, never deleted |
| 5 | Cascade: staff removal revokes that person's outstanding invitations (`INV-SEC-029`) |
| 6 | Cascade: library suspension or archival revokes all outstanding invitations (`INV-SEC-030`) |
| 7 | Revocation **does not** remove an already-granted role (`INV-SEC-028`) |
| 8 | Atomic single-use consumption — concurrent acceptance yields exactly one success |
| 9 | `IT-3` bounded by `ICFG-6` |
| 10 | Acceptance order exactly as `INV-SEC-036`. Never reordered |
| 11 | Binding mismatch refuses **without** consuming (`INV-SEC-038`) |
| 12 | Consumption commits before or with the grant request (`INV-SEC-039`) |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-81-1` | An expired invitation is refused; no role can override |
| `AC-81-2` | A revoked invitation is refused immediately, with no interval in which it works |
| `AC-81-3` | Revoking an old invitation does **not** remove a working staff member's access |
| `AC-81-4` | Suspending a library makes every outstanding invitation unacceptable |
| `AC-81-5` | Two concurrent acceptances of one artefact yield exactly one grant |
| `AC-81-6` | A binding mismatch leaves the artefact usable by the rightful invitee |
| `AC-81-7` | A crash between consumption and grant never leaves a reusable artefact that already granted |
| `AC-81-8` | `IT-3` stops working at exactly `ICFG-6` acceptances |

> **Steps 11 and 12 pull in opposite directions and both are required.** A binding
> mismatch must not consume — otherwise anyone intercepting a link can burn it and
> deny the real invitee. A successful authentication must consume before granting —
> otherwise a crash in between leaves an artefact that grants twice. The
> discriminator is whether the rightful holder has been established.
>
> **Step 5 is the concurrency test most teams skip.** Single-use enforced by
> `SELECT` then `UPDATE` without a transactional guard grants twice under a double
> click. Test it with genuine parallelism.

---

### `IMPL-120` — Public read projection

**Implements** `LIB-14B.8`, `LIB-14B.9`, `LIB-19.10`, `LIB-7.2`
**Authority** `ADR-0010`, `AR-3`

| Step | Action |
|---|---|
| 1 | Define the projection with **exactly** the §14A.5 fields — no more |
| 2 | Build it from events emitted by `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04` |
| 3 | Never query another context's store directly (`LIB-14B.9`) |
| 4 | Public seat data is **aggregate only** — capacity, per-zone-kind counts, coarse indicator |
| 5 | Only publicly-offered plans (`LIB-14B.16`); no student-specific price |
| 6 | Compute open/closed from `BC-06` in the tenant time zone (`LCFG-1`) |
| 7 | Include only **Active** + **Public** libraries (`LIB-8.1`, `LIB-14.4`) |
| 8 | Removal on Public→Private or suspension within `LCFG-6` |
| 9 | The public path must be **structurally unable** to reach an operational table |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-90-1` | The response body contains exactly the §14A.5 fields — verified against the payload, not the UI |
| `AC-90-2` | No public code path can reach an operational table; verified by boundary test |
| `AC-90-3` | No per-seat identifier, status or live occupancy appears in any public payload |
| `AC-90-4` | Private, Draft, Pending, Suspended, Archived and non-existent libraries are indistinguishable |
| `AC-90-5` | A Public→Private change removes the library within `LCFG-6` |
| `AC-90-6` | Suspension removes it immediately, irrespective of `LCFG-13` cache TTL |

> **The trap this task exists to prevent.** Serving the public profile by querying
> the operational table and selecting columns looks correct, passes every test, and
> is one forgotten `SELECT *`, one added column or one debug parameter from leaking
> member data to the internet. A projection cannot leak a field it does not contain.

---

### `IMPL-123` — Protected-operation gate

**Implements** `LIB-14B.26`…`LIB-14B.32`

| Step | Action |
|---|---|
| 1 | Register `PO-1`…`PO-12` as a closed list in code |
| 2 | Gate each on a valid `BC-18` session |
| 3 | Evaluate **authorisation in addition** to authentication, at execution time |
| 4 | Deny by default: an unregistered operation is protected (`LIB-14B.28`) |
| 5 | No authentication prompt, modal or interstitial before public content |
| 6 | Never collect a mobile number as a browsing condition (`LIB-14B.5`) |
| 7 | No local "is logged in" check beyond asking `BC-18`; no cached authorisation |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-93-1` | Each of `PO-1`…`PO-12` triggers authentication when attempted anonymously |
| `AC-93-2` | An authenticated account with no role in a library is **refused** `PO-4` |
| `AC-93-3` | A new operation is protected until explicitly published as public |
| `AC-93-4` | No public view demands a session, and no flow requests a number to view content |
| `AC-93-5` | No authorisation decision is cached across requests |

> **`AC-93-2` is the one to write first.** Authentication and authorisation are
> conflated constantly. A valid session says who someone is; it says nothing about
> whether they may book a seat in *this* library. Without this test, a member of
> library A can book in library B.

---

### `IMPL-124` — Intent preservation

**Implements** `LIB-14B.33`…`LIB-14B.40`, `LIB-DISC-012`

| Step | Action |
|---|---|
| 1 | Record action, target library, prior selections. **Never a credential** |
| 2 | TTL `LCFG-11` (30 min); unusable after |
| 3 | **Re-evaluate authorisation at resumption** — intent is not pre-authorisation |
| 4 | Re-validate library state; fail cleanly if suspended, made Private, or plan withdrawn |
| 5 | Discard if a different account authenticates than the one that began the flow |
| 6 | Scope to the named library only |
| 7 | Follow the `ADR-0004` two-stage sequence |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-94-1` | Intent resumes with selections intact after authentication |
| `AC-94-2` | An expired intent cannot resume |
| `AC-94-3` | Resumption re-evaluates authorisation — intent alone never permits |
| `AC-94-4` | Intent for library A cannot act on library B |
| `AC-94-5` | Intent is discarded if a different account authenticates |
| `AC-94-6` | Resumption against changed library state fails with an explanation, not on stale state |

> **`AC-94-3` and `AC-94-5` close real holes.** Without `AC-94-3`, "book seat 12"
> recorded pre-authentication is a capability that skips the permission check — a
> privilege escalation any anonymous visitor can reach. Without `AC-94-5`, handing
> your phone to a friend who logs in with their own number silently executes your
> intent under their identity.

---

### `IMPL-127` — Extend startup configuration validation

**Implements** `LIB-14B.50`, `INV-SEC-070`
**Extends** `IMPL-015`

| Step | Action |
|---|---|
| 1 | Add `LCFG-1`…`LCFG-13` and `ICFG-1`…`ICFG-10` to the startup validator |
| 2 | Add invariants `INV-10`…`INV-16` |
| 3 | Invalid configuration **prevents startup**. Never a warning |
| 4 | The failure message names the parameter, the invariant and the offending value |

| ID | Invariant | Prevents |
|---|---|---|
| `INV-10` | `LCFG-11` ≤ `CFG-6` | Intent outliving the session that resumes it |
| `INV-11` | `LCFG-11` > `CFG-2` × `CFG-1` | User timing out mid-OTP |
| `INV-12` | `LCFG-13` ≤ 3600 s, never consulted for authorization | Stale authorisation |
| `INV-13` | `ICFG-1` ≤ 7 d | Stale administrative grant |
| `INV-14` | `ICFG-3` ≤ `ICFG-2` | Weakest artefact living longest |
| `INV-15` | `ICFG-4` > `CFG-2` × `CFG-1` | Invitee timing out mid-authentication |
| `INV-16` | `ICFG-6` ≥ 1 | A code that can never be accepted |

**Acceptance**

| ID | Criterion |
|---|---|
| `AC-97-1` | A configuration violating any of `INV-10`…`INV-16` prevents startup |
| `AC-97-2` | The message names parameter, invariant and value |
| `AC-97-3` | Every default in the three specifications passes validation |

---

## 4. P1 / P2 tasks — summary form

Each carries the same structure; detail is in the cited specification section.

| ID | Task | Key requirements | Watch for |
|---|---|---|---|
| `IMPL-101` | Lifecycle state machine | `LIB-8.1`…`LIB-8.11` | `Restore` → **Suspended**, never straight to Active. Suspension immediate (`LIB-8.3`) |
| `IMPL-102` | Profile + validation | `LIB-6.1`…`LIB-6.6` | Business number **separate** from the auth credential (`LIB-6.4`). Trim before the empty check |
| `IMPL-104` | Branch/floor/zone | `LIB-9.1`…`LIB-11.5` | `branchId` on every record from migration 1 even with one branch |
| `IMPL-105` | Hours/holidays/closure | `LIB-12.1`…`LIB-12.8` | Sessions crossing midnight. Changes apply **forward only** |
| `IMPL-106` | Facilities | `LIB-13.1`…`LIB-13.6` | Reference list, **not** boolean columns. Silent Zone facility ≠ zone |
| `IMPL-107` | Settings | `LIB-16.1`…`LIB-16.9` | `LCFG-6` applies to the **search index only** (`LIB-16.9`) |
| `IMPL-108` | Business policies | `LIB-17.1`…`LIB-17.5` | Structured data, never free text another module parses |
| `IMPL-109` | Branding + media | `LIB-6.6`, `LCFG-7` | Reference `BC-29` by id; never build a storage URL |
| `IMPL-112` | Staff invite `IT-1` | `INV-SEC-004`, `LIB-15.1`…`LIB-15.13` | Never leave zero Owners (`LIB-15.9`). Owner is multi-holder |
| `IMPL-113` | Private invite `IT-2`/`IT-3` | `INV-SEC-005`, `INV-SEC-006` | `IT-3` **never** grants a staff role |
| `IMPL-114` | Invitation rate limiting | `INV-SEC-057`…`INV-SEC-063` | Origin-based, never identity-based. Bounded by `ICFG-10` |
| `IMPL-122` | Discovery search | `LIB-DISC-003`, `LIB-14B.43` | No caller-supplied field/filter/sort (`LIB-14B.44`) |
| `IMPL-125` | Public rate limiting | `LIB-14B.41`, `CFG-3` | Must tolerate shared NAT — 60–200 students per gateway |
| `IMPL-126` | Event emission | `LEV-1`…`LEV-28` | Never a credential or unmasked number in an event (`LIB-21.5`) |

---

## 5. Cross-cutting prerequisites owned elsewhere

| Prerequisite | Task | Status | Effect if absent |
|---|---|---|---|
| SMS delivery | `IMPL-020` | ⬜ **OPEN — critical path** | `IMPL-112` cannot deliver a staff invitation |
| Rate limiting infrastructure | `IMPL-021` | ⬜ **OPEN** | `IMPL-114`, `IMPL-125` have nothing to build on |
| Config validation harness | `IMPL-015` | ⬜ **OPEN** | `IMPL-127` has nothing to extend |
| Boundary checker | `IMPL-014` | ⬜ **OPEN** | `LXC-8`, `LXC-9` are unenforced; forbidden imports compile |
| Demo surface removal | `TASK-D10` | ⬜ **OPEN — P0 release blocker** | Nothing ships |

> **`IMPL-020` should be started first even though it is not a Library task.** DLT
> registration in India is a multi-week external dependency, and `IMPL-112` staff
> invitation — a V1 must-have — cannot complete without it. Sequencing it late makes
> it the thing that delays the release.

---

## 6. Definition of Done

A Library task is done when Gate 1 and Gate 2 of
[`DEFINITION_OF_DONE.md`](./DEFINITION_OF_DONE.md) pass **and**:

| # | Condition |
|---|---|
| 1 | Every acceptance criterion has an executing automated test |
| 2 | `flutter analyze` is clean |
| 3 | No forbidden import — verified, once `IMPL-014` exists, by the checker |
| 4 | Every tenant-scoped query carries a tenant key; a tenant-less query is tested to fail |
| 5 | Every administrative change is audit logged with all nine attributes |
| 6 | No secret, token, credential or unmasked number in any log, event or audit record |
| 7 | `TRACEABILITY_MATRIX.md` updated from ⬜ to the real state |
| 8 | Public surfaces additionally satisfy `AC-90-1` — the payload contains only the allow-list |

`LIB-DoD-1` — A task **MUST NOT** be marked done on the basis of a manual check
where an automated test is possible.

---

## 7. Change history

| Date | Change |
|---|---|
| 2026-08-03 | **Identifier collision corrected before commit.** The register was first drafted at `IMPL-070`…`IMPL-097`, which collided with the existing Phase 7 release-readiness tasks `IMPL-070`…`IMPL-073` in `IMPLEMENTATION_ROADMAP.md`. The pre-existing identifiers hold; the Library block moved to `IMPL-100`…`IMPL-127` with its internal grouping preserved. §1.1 records the allocation so the collision cannot recur. No task's content, priority or dependency changed — only its number. |
| 2026-08-03 | Created. 23 tasks `IMPL-100`…`IMPL-127`, 12 at P0. Full detail for the 8 P0 tasks with the highest defect risk; summary form for the rest. All tasks open. |
