# ADR-0010 — Public library information is served anonymously from a projection

| Field | Value |
|---|---|
| **Status** | Accepted |
| **Date** | 2026-08-03 |
| **Scope** | Library Discovery & Preview; the pre-authentication surface of the platform |
| **Implements** | Library PRD §14A, §14B · `LIB-DISC-005`, `LIB-DISC-006`, `LIB-DISC-012` |
| **Depends on** | `AR-1` (Discovery is a read composition) · `AR-3` (public index ≠ tenant data index) |

## Context

The product requires that anyone can browse a library's branding, gallery,
facilities, membership plans, public seat information and operating hours **without
logging in**, and that authentication becomes mandatory only at a protected
operation — Join Library, Membership Purchase, Renewal, Seat Booking, Attendance,
Dashboard, AI Services, Chat, and member-only features.

This is a commercial requirement (§14A.2: reduce onboarding friction, increase
conversion) and it is also the platform's **only unauthenticated attack surface**.
Every other surface can assume a session, a tenant context and a role. This one
cannot assume any of them.

Two structural questions had to be settled before anyone writes an endpoint.

### Question 1 — how does an anonymous request reach tenant-owned data?

The public profile aggregates fields owned by six contexts: `BC-19` Tenancy,
`BC-25` Configuration, `BC-29` File & Media, `BC-06` Library Policy, `BC-02`
Membership, `BC-04` Seating. Meanwhile `MP-GBR-08`, `SE-1` and `X-13` require a
tenant key on every tenant-scoped query, and an anonymous caller has no tenant
context at all.

The tempting implementation is to query the operational tables and filter the
columns. It appears to satisfy everything and it is what a small team ships first.

It is rejected. A column-filtered query over an operational table is one forgotten
`SELECT *`, one added column, or one debug parameter away from leaking member data
to the public internet. The failure mode is silent, and the blast radius is every
tenant.

### Question 2 — what happens to the user's intent across authentication?

`LIB-DISC-012` requires the platform to *"preserve the user's intended action after
successful authentication."* Preserving intent is easy to build and easy to build
**wrongly**: an intent recorded before authentication, replayed after it, is a
capability that bypasses the permission check unless something forces
re-evaluation.

## Decision

### 1. The public surface reads only from a public projection

`LIB-14B.8`, `LIB-14B.9`, `LIB-19.10`. The preview and discovery search are served
from a **read projection built from events** emitted by the owning contexts. A
public request **cannot reach an operational table by any path**.

This makes the leak structurally impossible rather than merely prohibited. The
public endpoint cannot expose a field the projection does not contain, however the
query is malformed, and `LIB-14B.44` forbids caller-supplied field, filter or sort
expressions that could widen it.

The projection belongs to the **Platform Public Discovery Index** class established
by `AR-3` — it indexes the tenant organisation itself, never tenant operational
data. `MP-GBR-08`, `SE-1` and `X-13` remain in force, unmodified, for everything
else.

### 2. Public visibility is allow-list only

`LIB-7.2`. A field is private until §14A.5 explicitly publishes it. Adding a field
is a reviewed documentation change (`LIB-7.4`), never a configuration toggle.

This also resolved a live conflict: §7 named nine public fields and §14A.5 named
fourteen. Two public-visibility lists in one PRD is a security defect waiting for
an implementer to pick the wrong one. §14A.5 governs as the superset.

### 3. Authentication is required at the operation, never before it

`LIB-14B.26`, and the **closed** list `PO-1`…`PO-12` (`LIB-14B.27`). No
authentication prompt, modal, interstitial or paywall precedes public content
(`LIB-14B.3`), and **a mobile number is never collected as a condition of
browsing** (`LIB-14B.5`).

That last prohibition is deliberate and will come under commercial pressure —
"enter your number to see prices" converts well. It is inadmissible because the
mobile number is the **sole authentication factor** (`MP-GBR-25`): collecting it to
unlock content is an authentication act performed under a false pretext, on a
person who has not agreed to create an account.

`LIB-14B.28` makes `PO-9` deny-by-default: a feature not explicitly published as
public is protected, consistent with `AP-3`.

### 4. Authorisation is evaluated in addition to authentication, at execution time

`LIB-14B.29`. A valid session is not permission. An authenticated visitor with no
role in a library must still be refused Seat Booking.

### 5. Preserved intent confers nothing and is re-authorised at resumption

`LIB-14B.36`. Intent carries the action, the target library and prior selections —
never a credential (`LIB-14B.34`) — expires after `LCFG-11` (30 min), is discarded
if a different account authenticates (`LIB-14B.39`), and is re-validated against
current library state (`LIB-14B.38`).

### 6. Public seat information is aggregate only

`LIB-14B.11`, `LIB-14B.12`. Total and per-zone capacity and a coarse indicator
(*Available* / *Limited* / *Full*) are publishable. Per-seat identity, per-seat
status, live occupancy and any presence-derived value are not. Public Live Occupancy
remains **V2** and requires a privacy review (`LIB-24.2`).

A study hall's regulars sit at the same desk daily. A live per-seat map is
effectively a public attendance feed for identifiable individuals. The commercial
question — *"is there room for me?"* — is fully answered by a coarse indicator.

### 7. Non-existent and non-public libraries are indistinguishable

`LIB-14B.24`. Private, Draft, Pending Verification, Suspended, Archived and
non-existent libraries produce the **same** observable response, including timing
class. This is `AR-7`'s anti-enumeration reasoning applied to libraries: if
"not found" and "exists but private" differ, the endpoint is an oracle for
enumerating every private library on the platform.

## Consequences

### Accepted

- **A projection must be built and kept current.** Extra machinery, and an
  eventual-consistency window (`LCFG-6` = 60 s) for *removal* from the public
  index. `LIB-16.9` and `LIB-14B.49` confine that window strictly to the search
  index: it must never touch an authorization, suspension, revocation or membership
  decision, all of which remain immediate and global per `MP-GBR-26`.
- **Public endpoints need their own rate limiting** (`CFG-3`), and it must work
  under shared NAT — 60–200 students behind one gateway is normal.
- **Coarse seat availability will be questioned** as less useful than a live count.
  That is the intended trade.
- **Anonymous traffic cannot be attributed**, by design (`LIB-14B.4`,
  `LIB-14B.42`, `LIB-14B.47`). Conversion analytics on the public funnel are
  therefore limited to aggregates. A prospective student who never joins has
  consented to nothing.

### Rejected alternatives

| Alternative | Why rejected |
|---|---|
| Column-filtered queries over operational tables | One `SELECT *` from a public leak; silent failure mode; every tenant affected |
| Require a phone number to view plans or prices | Collects the sole authentication factor under a false pretext; defeats §14A.2 |
| Authenticate first, browse after | Removes the acquisition funnel the module exists to provide |
| Trust preserved intent as pre-authorised | Privilege escalation reachable by any anonymous visitor |
| Live per-seat occupancy in V1 | A public attendance feed for identifiable individuals |
| Distinct 404 / 403 for private vs non-existent | Enumeration oracle for the private-library inventory |
| Visibility mode as the confidentiality control | Would mean every Public library is exposed; visibility controls discoverability only (`LIB-14.7`) |

## Compliance

| Obligation | Where |
|---|---|
| Tenant isolation preserved for operational data | `AR-3`; `LIB-14B.51` restates `MP-GBR-08`, `SE-1`, `X-13` unmodified |
| No authentication logic in this module | `LIB-14B.30`, `LIB-14B.31` ← `LXC-1`, `LXC-2` |
| Revocation and suspension immediate | `LIB-14B.49` ← `MP-GBR-26` |
| Two-stage authentication respected | `LIB-14B.40` ← `ADR-0004` |
| No demo or bypass path | `MP-CON-11`; no unauthenticated write exists |
| Verifiable | 16 acceptance criteria `LAC-14B-1`…`LAC-14B-16` |

## Related

- [`14B-Public-Library-Preview.md`](../../30-product/library/14B-Public-Library-Preview.md) — the specification
- [`14A-Library-Discovery-And-Enrollment.md`](../../30-product/library/14A-Library-Discovery-And-Enrollment.md) — the public field allow-list
- `AR-1` — Discovery is a read composition owning no aggregate
- `AR-3` — public discovery index is not a tenant data index
- [`ADR-0004`](./ADR-0004-two-stage-authentication.md) — the sequence at the boundary
- [`ADR-0009`](./ADR-0009-invitation-security-model.md) — how Private libraries are reached instead
- `IMPL-120`…`IMPL-124` — implementation tasks
