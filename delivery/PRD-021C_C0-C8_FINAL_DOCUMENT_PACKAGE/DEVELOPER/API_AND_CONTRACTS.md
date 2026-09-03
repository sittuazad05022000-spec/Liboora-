# API AND CONTRACT EXPECTATIONS — `PRD-021C` C0–C8

**Derived document.** ⛔ No authority. Authority: [`../PRD/`](../PRD/) (**FROZEN**) ·
**`Accepted`** ADRs in [`../ADR/`](../ADR/) · [`../ARCHITECTURE/`](../ARCHITECTURE/).

---

## 1. ⚠ Read this first — this document contains no endpoints

**There is no REST API to specify, because the frozen specification does not
define one.**

**Measured, not assumed.** A case-insensitive search for REST-shaped paths
(`POST /…`, `GET /…`, `PUT /…`, `PATCH /…`, `DELETE /…`) and for `openapi` /
`swagger` across the nine frozen subjects returns **no endpoint definition**. C8
**§9** — the part that would carry them — instead specifies **composition rules,
idempotency, pagination, authentication and rate limiting**, and explicitly
refuses to mint conventions:

> **`LMT-XC-012`** — ⛔ No new API convention, envelope, error taxonomy, version
> scheme or content type. 📤 existing conventions.

**Writing an endpoint table here would invent an interface no one approved.** This
document therefore specifies the **constraints any marketplace API must satisfy**,
and names who is authorised to design the rest.

⭐ This is the same disposition the repository's own precedent took:
`delivery/PRD-006_v1.9_FINAL_DEVELOPER_PACKAGE/DEVELOPER/API_SPECIFICATION.md`
records *"no endpoints exist to specify"* for the same reason.

---

## 2. What the specification defines instead

The marketplace's contract with the rest of the system is expressed as **provided
reads**, **registered ports** and **existing events** — not as HTTP routes.

| Surface | Rule | Source |
|---|---|---|
| Reads | Compose from **owner-provided reads** | `LMT-FR-014` |
| Writes | Invoke the owner's **public command API through a registered port** | `LMT-BR-012` |
| Events | Consume **only** pre-existing events; publish **none** | `LMT-FR-011`, `LMT-XC-008` |
| Edges | The **29** existing edges; ⛔ none created | `LMT-XC-009` |

**Build to the reads, the ports and the events.** Whatever transport is eventually
chosen is an implementation detail of a port, and choosing one does **not** license
changing the port's contract.

---

## 3. Constraints any marketplace API MUST satisfy

### 3.1 Read composition — the boundary rule

**`LMT-FR-014`** — marketplace endpoints **MUST** compose from owner-provided
reads and **MUST NOT** query another context's tables. 📤 ruling `F-1`:
*"no capability context may import, reference or query a domain context"*;
BC Map **L330**: *"Search never reads domain tables."*

### 3.2 Writes — the caller is untrusted

**`LMT-BR-012`** — 📤 ruling `F-3`: where a marketplace action causes a domain
change it **MUST** invoke the domain's public command API through a **registered
port**; the domain **re-validates**, and the caller is treated as **untrusted**.

⭐ This is the rule under which **C7's report submission** and **C4's booking
initiation** operate. Neither writes the owner's state; both ask the owner to.

⚠ **"The domain re-validates" is not a courtesy.** Validation you perform in the
marketplace is for user experience only. It is **never** the enforcement point, and
duplicating a frozen rule in order to pre-validate is how a marketplace acquires an
unowned copy of somebody else's invariant.

### 3.3 Idempotency

**`LMT-FR-015`** — state-changing marketplace endpoints **MUST** be idempotent
using the **existing** idempotency key at the API edge (BC Map §10.1's
duplicate-payment override) and the `platform/services:idempotency` port that
`domain/library` already declares. ⛔ No new idempotency store.

### 3.4 Pagination — cursors only

**`LMT-FR-016`** — every marketplace list **MUST** paginate by **opaque
server-generated cursor**. 📤 `PG-1`…`PG-4` (BC Map **L709–L712**):

- clients **MUST NOT** parse, construct or decrement a cursor;
- a cursor **MUST NOT** expose ordering keys, DB ids, offsets, table names or
  index structure;
- an expired or malformed cursor **MUST** yield a domain error, and ⛔ **never** a
  silent reset.

**`LMT-XC-013`** — ⛔ no offset pagination, page numbers, total-count guarantee or
new pagination mechanism.

⚠ **"No total-count guarantee" is deliberate** and consistent with C2's count
suppression. A UI that needs *"showing 1–20 of 413"* is asking for a guarantee the
specification withholds.

### 3.5 Configuration

**`LMT-FR-019`** — tunable marketplace values **MUST** be read through typed
accessors over **`E-19`**; ⛔ *"no raw string lookups in domain code"* (BC Map
**L328**). ⛔ No new configuration store or flag system.

### 3.6 Rate limiting

**`LMT-FR-020`** — public marketplace surfaces **MUST** be rate-limited **per
origin** (`LIB-14B.41`); a short-lived anonymous session id **MAY** be used
(`LIB-14B.6`); and ⛔ the mechanism **MUST NOT** identify the visitor
(`LIB-14B.42`).

**`LMT-XC-015`** — ⛔ no rate-limit counter, bucket, store or evaluator is
created. `RateLimitCounter` remains `BC-11`'s (BC Map **L377**). 🔗 C7 `LTS-XC-005`.

⭐ **Note the tension the rule resolves deliberately:** rate limiting normally wants
to identify a caller, and here it **must not**. Per-origin limiting with a
short-lived anonymous session id is the specified compromise — ⛔ do not "improve"
it by fingerprinting.

---

## 4. ⛔ No performance numbers exist

**`LMT-XC-016`** — ⛔ C8 **MUST NOT** mint a latency target, throughput budget,
percentile SLO, payload-size cap, cache TTL or timeout value. C8 gives the reason:

> a number invented in a product part becomes an unowned obligation that no
> operator agreed to and no test can justify.

**`LMT-FR-021`** — where a marketplace surface needs a performance obligation, it
**MUST inherit** the obligation of the owner whose read it composes, and ⛔ **MUST
NOT** state a stricter or looser one.

⚠ **Disclosed as an absence, not presented as satisfied.** If you need a latency
budget for a marketplace surface, it does not exist and must be obtained from the
owning context — not chosen.

---

## 5. Who may decide the rest

| Question | Owner |
|---|---|
| The actual HTTP surface, envelope, error taxonomy | The existing repository-wide API conventions — ⛔ not `PRD-021C` |
| A new edge to reach a context | **Architecture Owner**, by ADR (BC Map **L292**) |
| A new event | **Architecture Owner**, by ADR |
| Anything touching the frozen PRD | ADR against the owning PRD |
| `E-21` / `E-22` enumeration extension | **OPEN** — `XPC-CONF-004`, `XPC-CONF-007` |

⛔ **None of these is an implementer's judgement**, and none of them is decided in
this package.
