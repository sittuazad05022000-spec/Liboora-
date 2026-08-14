# API_SPECIFICATION — PRD-006 Attendance Management v1.9

**Derived document.** Authority: [`../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md`](../PRD/PRD-006_ATTENDANCE-MANAGEMENT_v1.9_FROZEN.md) (**FROZEN**) · the **`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. Read this first — this document contains no endpoints

**There is no REST API to specify, because the frozen specification does not
define one.**

This was measured, not assumed. A case-insensitive search for REST-shaped paths
(`POST /…`, `GET /…`, `PUT /…`, `PATCH /…`, `DELETE /…`), plus `openapi` and
`swagger`, across the five authoritative documents:

| Document | REST/OpenAPI occurrences |
|---|---|
| `PRD-006_ATTENDANCE-MANAGEMENT.md` (frozen v1.9) | **0** |
| `ADR-0034` (`Accepted`, admitting ADR) | **0** |
| `ADR-0032` (`Accepted`, Seat Card presence) | **0** |
| `LIBOORA_BOUNDED_CONTEXT_MAP.md` (v1.7) | **0** |
| `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **0** |

The PRD's occurrences of the word *"endpoints"* refer to **both endpoints of a
numeric range**, not to HTTP endpoints.

**Writing an endpoint table here would have invented an interface no one
approved.** The instruction governing this package is explicit — *do not invent or
change any frozen requirement, accepted ADR, event, status, numeric value, API, DB
field or architecture rule*. So this document specifies the **constraints any
future API must satisfy** and names who is authorised to design it.

## 2. What the specification defines instead of an API

The module's contract with the rest of the system is expressed as **ports** and
**events**, not as HTTP routes.

| Surface | Count | Where |
|---|---|---|
| **Ports** — `ATT-PO-001` … `ATT-PO-014` | **14** | §20, and [`DEVELOPER_GUIDE.md`](./DEVELOPER_GUIDE.md) §4 |
| **Published events** — `ATT-EVT-001` … `ATT-EVT-004` | **4** | §22, and [`EVENT_CONTRACTS.md`](./EVENT_CONTRACTS.md) |
| **Edges** — `E-01` … `E-26` | **26** | BC Map §7 |

**Build to the ports and the events.** Any transport (in-process call, HTTP,
message bus) is an implementation detail of a port, and choosing one does not
license changing the port's contract.

## 3. Constraints any API for this module MUST satisfy

These are derived from registered obligations. They are binding on whatever
interface is eventually designed.

### 3.1 The published surface is closed

- **Exactly four events.** No fifth, for any reason (`ATT-FR-134`, `ATT-AC-117`,
  `ATT-AC-216`).
- **No new edge.** BC Map L292: *"an edge not in this table does not exist and
  adding it requires an ADR."* The Dependency Matrix enforces an **explicit
  allow-list, not "anything within the cluster"**.
- An API **MUST NOT** become a back door that creates an unlisted dependency.

### 3.2 No raw network data may be exposed — ever

**`ATT-AC-218`** requires that presence facts exposed for composition contain
**no SSID, BSSID, signal strength, MAC address or other network datum**, and that
**no consumer can obtain one through the exposed path**.

Any endpoint, field, debug route, error payload or log surface that leaks one of
these violates the specification.

### 3.3 Presence is read-time composed and never a stored copy

**`ATT-AC-219`:** exposed presence facts are **computed from this module's own
aggregate on each read**, carry **the observation instant** they were computed
from, and *"nothing obliges or permits"* a consumer to hold a stored copy.

Consequences for an API: **no cache-as-truth**, no "sync presence" endpoint that
hands over ownership, and every response carries its **as-of** instant
(`SEAT-FR-105` requires the label; `SEAT-FR-106` requires visible degradation
rather than stale-as-current).

### 3.4 No fabricated values may appear in any response

**`ATT-AC-220`:** a gap containing no observation yields
`INCOMPLETE / EXIT NOT VERIFIED` rather than a computed exit instant, and exposed
facts carry **no invented exit timestamp**. A response must be able to say *"not
verified"*.

### 3.5 Authorisation and tenancy are not API-layer inventions

- Roles are **fixed** — `ATT-FR-118` forbids defining a new one. The nine
  operations and their roles are in §19 (see
  [`SECURITY_REQUIREMENTS.md`](./SECURITY_REQUIREMENTS.md)).
- **Tenant context is ambient**, propagated via `ATT-PO-004` (`E-18`, `SK`) —
  *"never a domain method parameter"*. **A `tenantId` request parameter is
  therefore the wrong shape.**
- `ATT-BR-017` requires tenant isolation; `BC-18` owns authentication.
- Entitlement is checked via `ATT-PO-003` **before the aggregate mutates**.

### 3.6 Idempotency is mandatory

Every event is idempotent **by event identifier** (§22.1), `ATT-FR-141` requires a
**stable** identifier, and `ATT-INV-003`/`ATT-FR-090` pair with **`MP-GBR-18`**.
Any write interface must accept a caller-supplied idempotency key or equivalent,
because the offline path **will** replay (`ATT-PO-011` … `ATT-PO-013`).

### 3.7 Corrections are append-only

`ATT-INV-005`/`ATT-BR-040` pair with **`MP-GBR-11` append-only corrections**, and
audit has **no update and no delete path** (`X-10`). **No `PUT`- or
`DELETE`-shaped semantics** may be offered over attendance records or audit
entries. A correction is a **new appended fact** that emits `ATT-EVT-003`.

### 3.8 No performance figure may be published

`ATT-NFR-003` forbids stating a latency or throughput figure while
**`ATT-GAP-017a`** is open. **No SLA, no rate limit, no timeout value** may be
documented as a specification-backed guarantee.

### 3.9 Failures must be distinguishable, never silent

`ATT-NFR-005` and `ATT-FR-036` forbid a **silent downgrade**. A verification
failure, a denied permission or a degraded composition **MUST** be
distinguishable in the response — not rendered as a normal negative result.

## 4. What is explicitly NOT decided, and by whom

| Undecided | Owner |
|---|---|
| **Whether a REST API exists at all**, and its shape | Architecture Owner |
| **The network verification mechanism** — no API, gateway, certificate or identifier may be named | `ADR-0027` (**`Proposed`**) · `ATT-XC-015` · **`ATT-GAP-007`** |
| **The booked-shift read path** — required by the tolerance and the conformance badge | `ADR-0029` (**`Proposed`**) · **`ATT-GAP-002a` OPEN** |
| **Retention of attendance and observation data** | **`ATT-GAP-005` OPEN.** This module **MUST NOT** define its own |
| **Latency / throughput targets** | **`ATT-GAP-017a` OPEN** |

> **Reminder on binding status.** `ADR-0021` … `ADR-0031` are **`Proposed`** —
> *"Under consideration; **not binding**"*. Their option lists are context, **not
> an interface specification**. Do not implement a `Proposed` ADR's preferred
> option as though it were decided.

## 5. If you are asked to design the API

1. Get an **ADR** first. An interface that crosses a context boundary needs one
   (BC Map L292).
2. Express it as a **realisation of an existing port**, not as a new capability.
3. Re-check every constraint in §3 against the draft.
4. Do **not** amend the frozen PRD to match the API. The PRD is **FROZEN** at
   v1.9 under `ADR-0034`; changing it requires the Architecture Owner and a new
   baseline entry.
