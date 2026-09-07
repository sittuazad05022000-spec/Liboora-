<!--
  PROVENANCE — PRD-021C Part C1 (Marketplace Foundation)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  Structural note
  ---------------
  This part is NOT a bounded context and does NOT belong to BC-17 Marketplace.
  BC-17 remains V3. C1 is a part of the existing V1 read composition registered
  at MASTER_PRD.md section 8 module 19 under ruling AR-1. See C0 section 2.

  What this file does NOT do
  --------------------------
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Creates no listing, order, payment or marketplace entity.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C1

## Marketplace Foundation

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C1** |
| **Part title** | Marketplace Foundation |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | ⭐ **Application / read composition capability of the Library domain** (`AR-1`; `MASTER_PRD.md` §8 **module 19**). ⛔ **NOT a bounded context.** ⛔ **NOT `BC-17`** |
| **Release** | **V1** — as module 19 already is at Rank 1 |
| **Identifier prefix** | `LMP-*` — registered in C0 §1.1, collision-checked at **0** occurrences |
| **Owns** | ⛔ **No aggregate. No invariant. No business state.** Composition and presentation rules only |
| **Consumes** | `BC-19` Tenancy · `BC-25` Configuration · `BC-06` Library Policy · `BC-02` Membership · `BC-04` Seating · `BC-18` Identity & Access · `BC-23` Search Indexing *(conditional — C0 `XPC-OD-001`)* |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) |

---

## §1. Purpose

C1 establishes the **foundation** on which C2 (search & local discovery), C3
(public profile) and C4 (seat availability & booking) are composed: the
definition of the marketplace surface, which libraries appear on it, the
visibility gate that admits them, the tenant-less/tenant-scoped split, and the
authentication boundary.

C1 specifies **no commerce**. It creates no listing, no order, no cart, no
payment and no seller. It is the *foundation of a directory of libraries*, which
`AR-3` distinguishes categorically from an index of tenant data.

### §1.1 ⭐ The word "marketplace", scoped

`LMP-XC-001` below states this normatively, but it is stated in prose first
because it is the single most likely misreading of this document:

> **The title says "marketplace" because that is the product intent's own name
> for the surface. It carries no claim on `BC-17` Marketplace, which owns
> student-to-student listings and orders, is keyed on `PersonId`, holds no
> `tenantId`, and remains V3.** A directory of libraries is not an index of
> listings. Conflating them would place a tenant directory inside the Global
> Student platform and breach both `X-05` and `ID-3`.

### §1.2 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD** strong recommendation · **MAY**
optional · unkeyworded prose and `>` blocks are **not** normative.

---

## §2. Identifier registers

| Register | Range | Count | Contiguous |
|---|---|---|---|
| `LMP-FR-*` | `LMP-FR-001` … `LMP-FR-024` | 24 | Yes |
| `LMP-AC-*` | `LMP-AC-001` … `LMP-AC-012` | 12 | Yes |
| `LMP-XC-*` | `LMP-XC-001` … `LMP-XC-010` | 10 | Yes |

---

## §3. The marketplace surface

`LMP-FR-001` — The platform **MUST** present a single public marketplace surface
whose indexed unit is the **`TenantOrganisation` record** owned by `BC-19`, and
**MUST NOT** index any tenant operational row on that surface (`AR-3`,
`MP-GBR-08`, `SE-1`, `X-13`).

`LMP-FR-002` — The marketplace surface **MUST** be reachable with **no account,
no session and no prior relationship** with the platform (§14B.3, `LIB-DISC-005`).

`LMP-FR-003` — The marketplace surface **MUST** compose only the public field
groups enumerated in `AR-1`'s read-model table and §14A.5, and **MUST NOT**
introduce a public field that §14A.5 does not already permit (§14B.2: *"adds no
new public field and removes no restriction"*).

`LMP-FR-004` — Each field presented **MUST** be read from its owning context and
**MUST NOT** be stored, cached as authoritative, recomputed or overridden by this
composition (`AR-1`: *"Discovery references, never duplicates"*).

`LMP-FR-005` — The composition **MUST** hold **no aggregate, no invariant and no
business state** (`AR-1`; `MASTER_PRD.md` **L175**–**L180**).

### §3.1 Field ownership — reproduced, not redefined

| Public field group | Owning context | Owning PRD |
|---|---|---|
| Library name · business address · map location · library status · business contact | `BC-19` Tenancy | `PRD-013` **FROZEN** |
| Logo · cover image · description | `BC-25` Configuration | `PRD-023` **FROZEN** |
| Gallery | `BC-29` File & Media | `PRD-017` **FROZEN** — ⚠ conditional, C0 `XPC-OD-003` |
| Operating hours · weekly holidays | `BC-06` Library Policy | `PRD-002` **FROZEN** |
| Membership plans & pricing | `BC-02` Membership | `PRD-005` **FROZEN** |
| Seat capacity (aggregate only) | `BC-04` Seating | `PRD-007` **FROZEN** |
| Discovery projection & query | `BC-23` Search Indexing | `PRD-015` — ⚠ **does not exist**, C0 `XPC-OD-002` |

`LMP-FR-006` — Where an owning context is unavailable, the composition **MUST**
degrade by omitting that field group, **MUST** still render the remainder, and
**MUST NOT** substitute a stored or stale value as if authoritative.

---

## §4. Admission — which libraries appear

`LMP-FR-007` — A library **MUST** appear on the marketplace surface only when
**both** conditions hold: it is **verified and activated** (`LIB-DISC-002`), and
its visibility mode is **Public** (`LIB-DISC-001`, `LIB-DISC-004`).

`LMP-FR-008` — A **Private** library **MUST NOT** appear on the marketplace
surface in any form — not in search, not in nearby discovery, not in a count, not
in an aggregate, and not in an error message (`LIB-DISC-004`, `LIB-14B.23`).

`LMP-FR-009` — Visibility mode **MUST** be consumed from its owner and **MUST
NOT** be defined, defaulted or overridden by this composition (`LIB-DISC-001`).

`LMP-FR-010` — A request for a library that does not exist, or that is Private,
Draft, Pending, Suspended or Archived, **MUST** produce the **same observable
response** — same status code, same body shape, and no timing signal that
distinguishes the cases (`LIB-14B.24`, `AR-7`).

> **`LMP-FR-010` is anti-enumeration.** If "not found" and "exists but is
> private" are distinguishable, the public surface becomes an oracle for
> enumerating every private library on the platform. This is the reasoning
> `AUTH-3.*` already applies to registered and unregistered phone numbers, and
> §14B applies to libraries; C1 restates it because a *marketplace* listing
> surface is exactly where the temptation to return a helpful 403 arises.

`LMP-FR-011` — Removal of a library from Public visibility, suspension, or
deactivation **MUST** remove it from the marketplace surface within
**`LCFG-6`** — the value consumed from `BC-25`, not defined here.

---

## §5. Tenancy — the two-class split

`LMP-FR-012` — The public marketplace surface **MUST** be served **without a
caller tenant context**, because the tenant *is* the indexed record (`AR-3`;
BC Map §11.1).

`LMP-FR-013` — Every read of **tenant operational data** — students, memberships,
attendance, fees, staff, analytics, configuration — **MUST** carry an ambient
`TenantContext` via `E-18`, and a query without a tenant predicate **MUST** fail
at runtime rather than silently return across tenants (BC Map §11,
`MP-GBR-08`, `X-13`).

`LMP-FR-014` — The composition **MUST NOT** place tenant operational data into
the public discovery index under any transformation — aggregated, derived,
inferred or error-message form (BC Map §11.1; `LIB-14B.22`).

`LMP-FR-015` — Any cache key, index name or namespace used by this composition
**MUST** be treated as a security-reviewable artefact (BC Map §11.1).

> **The single highest-severity failure mode in the architecture** is a
> cross-tenant leak through a capability context. C1 is the surface most exposed
> to it, because it is the only surface deliberately served **without** a tenant
> context. `LMP-FR-012` and `LMP-FR-013` are the two halves of that split and
> must be read together: *tenant-less* is lawful **only** for the directory of
> tenants, never for a row belonging to one.

---

## §6. The authentication boundary

`LMP-FR-016` — Browsing the marketplace surface **MUST NOT** require
authentication (`LIB-DISC-005`, §14B.3).

`LMP-FR-017` — Authentication **MUST** be required only at the moment a
**protected operation** is initiated, and never before (`LIB-14B.26`).

`LMP-FR-018` — The protected-operation list **MUST** be consumed from §14A.9 and
§14B.6.1 and **MUST NOT** be extended, reduced or reinterpreted by this
composition.

`LMP-FR-019` — The user's intended action **MUST** survive authentication and
**MUST** resume afterwards without re-entry (`LIB-DISC-012`, §14B.7).

`LMP-FR-020` — Registration, credential handling, OTP and session issuance
**MUST** be delegated to `BC-18` (`LIB-DISC-008`, `AR-2`, `AR-6`, `ID-1`).

`LMP-FR-021` — Every authorisation decision **MUST** be evaluated by `BC-18`;
this composition **MUST NOT** decide permission locally (`X-13`).

> **`X-13` names this failure "a security defect that passes its own tests."** A
> composition that decides its own authorisation will be internally consistent
> and externally wrong.

---

## §7. Anonymous traffic protection

`LMP-FR-022` — The public surface **MUST** be protected against automated
enumeration and scraping using the controls §14B.8 already specifies, and **MUST
NOT** define a new rate-limiting policy.

> **`ARCHITECTURE_RULINGS.md` §6 defers OTP request rate-limiting by ruling and
> states that no rate-limiting policy may be invented.** C1 honours the shape of
> that ruling: it requires protection to exist and refuses to author the numbers.

`LMP-FR-023` — Error responses on the public surface **MUST NOT** disclose
internal identifiers, table names, query structure, stack traces or
configuration values (`LIB-14B.25`).

`LMP-FR-024` — Internal identifiers that would reveal tenant count or creation
order **MUST NOT** appear on the public surface (`LIB-18.2`, `LIB-14B.22`).

---

## §8. Exclusions

| # | Excluded | Authority |
|---|---|---|
| `LMP-XC-001` | ⛔ This part **MUST NOT** be read as claiming, extending or occupying **`BC-17` Marketplace**, and **MUST NOT** create a listing, order, cart, seller or marketplace entity. `BC-17` remains **V3** | BC Map **L121**, **L148**; `MP-SCOPE-06`; C0 §2 |
| `LMP-XC-002` | ⛔ **MUST NOT** create a bounded context. The count remains **31** | `AR-1`; BC Map **L10** |
| `LMP-XC-003` | ⛔ **MUST NOT** create an integration edge. Where one is required it is an **OPEN decision** | BC Map §7 (*"If an edge is not in this table, it does not exist"*) |
| `LMP-XC-004` | ⛔ **MUST NOT** publish a domain event or mint an event identifier | BC Map §9 |
| `LMP-XC-005` | ⛔ **MUST NOT** create a payment, checkout, settlement or commission capability. Money is `BC-05` (student→library) and `BC-20` (library→LIBOORA) | BC Map §5 *Payment* collision row |
| `LMP-XC-006` | ⛔ **MUST NOT** consume, present or infer any social signal, friend, community, message or reputation value | `X-05` (Matrix **L354**); `ID-3` (BC Map **L180**) |
| `LMP-XC-007` | ⛔ **MUST NOT** decide authorisation | `X-13` |
| `LMP-XC-008` | ⛔ **MUST NOT** store or process a credential, OTP or session | `ID-1` |
| `LMP-XC-009` | ⛔ **MUST NOT** create a rating, review, star, score or ranking-of-libraries entity | `ARCHITECTURE_RULINGS.md` §6 — **Deferred V2**, *"must not be invented"* |
| `LMP-XC-010` | ⛔ **MUST NOT** store a price, compute a price or present a student-specific price | `LXC-7`; `LIB-14B.15`, `LIB-14B.17` |

---

## §9. Acceptance criteria

Given/When/Then form. ⚠ **0 of 12 is proven by a test — no test exists.**

`LMP-AC-001` — **Public surface requires no account**
> **Given** a client with no account, no session and no cookie
> **When** it requests the marketplace surface
> **Then** the surface returns successfully, **and** no authentication challenge is issued
> **And** the response contains only field groups enumerated in §14A.5.
> **Exercises** — `LMP-FR-002`, `LMP-FR-003`, `LMP-FR-016`

`LMP-AC-002` — **Only verified, activated, Public libraries appear**
> **Given** four libraries: (a) Public + verified + activated, (b) Public + unverified, (c) Private + verified + activated, (d) Public + verified + deactivated
> **When** the marketplace surface is listed anonymously
> **Then** only (a) appears
> **And** (b), (c) and (d) are absent from results, from any count and from any aggregate.
> **Exercises** — `LMP-FR-007`, `LMP-FR-009`

`LMP-AC-003` — **Private library is indistinguishable from non-existent**
> **Given** a Private library `L` and an identifier `N` that matches no library
> **When** the public surface is requested for `L` and for `N`
> **Then** both responses have the **same** status code and the **same** body shape
> **And** neither response reveals that `L` exists
> **And** the response-time difference is not a reliable signal of existence.
> **Exercises** — `LMP-FR-008`, `LMP-FR-010`, `LMP-FR-011`

`LMP-AC-004` — **No field is stored by the composition**
> **Given** the marketplace surface has rendered a library
> **When** the owning context's value changes (e.g. `BC-25` updates the logo)
> **Then** the next render reflects the owner's new value
> **And** no authoritative copy of the field is held by the composition.
> **Exercises** — `LMP-FR-004`, `LMP-FR-005`

`LMP-AC-005` — **Owner unavailability degrades, never fabricates**
> **Given** `BC-02` Membership is unavailable
> **When** the marketplace surface renders a library
> **Then** the membership-plan group is omitted
> **And** the remaining groups render
> **And** no stale or placeholder plan or price is presented as authoritative.
> **Exercises** — `LMP-FR-006`

`LMP-AC-006` — **Public surface carries no tenant context**
> **Given** an anonymous request to the public marketplace surface
> **When** the request is served
> **Then** no caller `TenantContext` is required
> **And** the indexed unit is the `TenantOrganisation` record, not any tenant-owned row.
> **Exercises** — `LMP-FR-012`, `LMP-FR-001`

`LMP-AC-007` — **Operational read without a tenant predicate fails**
> **Given** a code path that reads tenant operational data
> **When** it executes without an ambient `TenantContext`
> **Then** it fails at runtime
> **And** it does **not** return rows from more than one tenant
> **And** it does **not** return an empty success.
> **Exercises** — `LMP-FR-013`

`LMP-AC-008` — **Tenant operational data never enters the public index**
> **Given** the public discovery index
> **When** its contents are enumerated
> **Then** no student, membership, attendance, fee, staff, analytics or configuration value is present
> **And** no such value is present in aggregated, derived or inferred form.
> **Exercises** — `LMP-FR-014`, `LMP-FR-015`

`LMP-AC-009` — **Authentication is demanded only at a protected operation**
> **Given** an anonymous user browsing the marketplace surface
> **When** the user performs only browsing, filtering and profile viewing
> **Then** no authentication is required at any point
> **When** the user initiates an operation on the §14A.9 / §14B.6.1 list
> **Then** authentication is required at that moment and not before.
> **Exercises** — `LMP-FR-016`, `LMP-FR-017`, `LMP-FR-018`

`LMP-AC-010` — **Intent survives authentication**
> **Given** an anonymous user who initiated a protected operation against library `L`
> **When** authentication completes successfully
> **Then** the original operation against `L` resumes
> **And** the user is not required to re-enter the intent.
> **Exercises** — `LMP-FR-019`, `LMP-FR-020`

`LMP-AC-011` — **Authorisation is never decided locally**
> **Given** any protected operation initiated from this surface
> **When** the permission question is answered
> **Then** the answer is produced by `BC-18`
> **And** no permission rule is evaluated inside the composition.
> **Exercises** — `LMP-FR-021`

`LMP-AC-012` — **Errors disclose nothing internal**
> **Given** any failing public request
> **When** the error response is inspected
> **Then** it contains no internal identifier, table name, query fragment, stack trace or configuration value
> **And** it does not reveal tenant count or creation order.

---

## §10. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| `LMP-FR-001`…`006` | `AR-1`; `AR-3`; §14A.5; `MASTER_PRD.md` **L171**–**L180** |
| `LMP-FR-007`…`011` | `LIB-DISC-001`, `002`, `004`; `LIB-14B.23`, `LIB-14B.24`; `AR-7` |
| `LMP-FR-012`…`015` | BC Map §11, §11.1; `MP-GBR-08`; `SE-1`; `X-13` |
| `LMP-FR-016`…`021` | `LIB-DISC-005`, `006`, `008`, `012`; §14B.3, §14B.6, §14B.7; `AR-2`; `AR-6`; `ID-1`; `X-13` |
| `LMP-FR-022`…`024` | §14B.8; `LIB-14B.25`; `LIB-18.2`; `ARCHITECTURE_RULINGS.md` §6 |

---

## §11. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered. **0** ADRs, **0** contexts, **0** edges, **0** events,
**0** `IMPL-*`, **0** Rank 1–6 documents modified, **0** lines of code.

---

## §12. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created. Establishes the marketplace **foundation** as a part of the existing V1 `AR-1` read composition (module 19), **not** as `BC-17`. 24 FR · 12 AC · 10 XC |
