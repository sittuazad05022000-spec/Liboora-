<!--
  PROVENANCE — PRD-021C Part C3 (Library Public Profile)

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 NOT entered.

  Ownership note
  --------------
  Every field the public profile shows is owned by another context:
  BC-19 Tenancy, BC-25 Configuration, BC-29 File & Media, BC-06 Library
  Policy, BC-02 Membership, BC-04 Seating. C3 owns the COMPOSITION only.
  C3 duplicates NOTHING from Library Management.

  Sections 14A.5 (publishable field list) and 14B.4 (projection rules) are
  FROZEN / Approved and already own the field set. C3 CONSUMES and CITES
  them. C3 adds no public field and removes no restriction.

  One OPEN decision gates 4 of C3's requirements:
    XPC-OD-003 — E-22's consumer enumeration omits BC-19 and BC-25, so the
                 public gallery cannot lawfully be served as a FileRef today
                 (Architecture Owner)

  What this file does NOT do
  --------------------------
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Publishes no field outside the frozen 14A.5 list.
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C3

## Library Public Profile

### v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.
> ⚠⚠ **4 of 28 requirements are CONDITIONAL on an OPEN decision** — see §2.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C3** |
| **Part title** | Library Public Profile |
| **Version** | **v0.1** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | Part of the `AR-1` read composition (module 19). ⛔ **NOT a bounded context** |
| **Release** | **V1** |
| **Identifier prefix** | `LPP-*` — collision-checked at **0** occurrences |
| **Owns** | ⛔ **No entity. No field. No aggregate. No invariant.** Composition rules and presentation semantics only |
| **Consumes** | `BC-19` Tenancy · `BC-25` Configuration · `BC-29` File & Media *(⚠ conditional)* · `BC-06` Library Policy · `BC-02` Membership · `BC-04` Seating — projected via `BC-23` |
| **Cross-part** | [`C0`](./PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md) · [`C1`](./PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md) · [`C2`](./PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md) |

---

## §1. Purpose

C3 specifies the **public profile of a single library** — the page a prospective
student reaches from a C2 search result and reads before deciding to enquire or
join.

C3 is a **projection and presentation layer**. It composes fields owned
elsewhere, applies the publication rules already frozen in §14A.5 and §14B.4,
and renders them. It stores nothing, computes no business value, and holds no
state.

### §1.1 ⭐ Why C3 duplicates nothing from Library Management

The supplied intent says *"do not duplicate Library Management."* The repository
makes that stronger than a preference: it is already law.

`ARCHITECTURE_RULINGS.md` `AR-1` rules that this capability *"owns **no
aggregate**, **no invariant**, **no business state**"* and that *"Discovery
references, never duplicates."* `LIB-14B.10` requires that *"every field in the
projection **MUST** be traceable to an owning context. A field with no owner
**MUST NOT** be published."*

⭐ **The consequence for C3 is unusually clean: C3 has no field register of its
own.** Its field set is *exactly* §14A.5's public list — no more, no fewer — and
each field's meaning, validity and lifecycle stay with its owner.

> **Why this is stated as an ownership fact rather than a design choice.** A
> public profile is the single most tempting place to "denormalise for
> performance" — to keep a local copy of the address, the hours and the price so
> the page renders in one query. That copy is a second source of truth for
> commercially material data. When the library changes its price and the profile
> keeps showing the old one, the platform has published a wrong price under the
> library's name. `LIB-14B.15` and `LIB-14B.18` already resolve this: prices are
> read from a `BC-02` projection and are marked indicative. C3 restates the
> constraint but does not re-decide it.

### §1.2 What §14A and §14B already own, and what is left for C3

| Concern | Already owned by | C3's role |
|---|---|---|
| **Which fields may be public** | §14A.5 (FROZEN) | ⛔ None — consume verbatim |
| **Which fields may never be public** | §14A.5, `LIB-14B.22` | ⛔ None — consume verbatim |
| **Public / Private visibility modes** | §14A.6, `LIB-14B.23` | ⛔ None — consume verbatim |
| **Projection construction rules** | `LIB-14B.8`, `LIB-14B.9`, `LIB-14B.10` | ⛔ None — consume verbatim |
| **Seat publication boundary** | `LIB-14B.11`…`14`, `SEAT-XC-009` | ⛔ None — consume verbatim |
| **Plan / pricing publication** | `LIB-14B.15`…`18` | ⛔ None — consume verbatim |
| **Open / closed computation** | `LIB-14B.19`…`21` | ⛔ None — consume verbatim |
| **Anti-enumeration** | `LIB-14B.24`, `AR-7` | ⛔ None — consume verbatim |
| **Field grouping and presentation order** | *(unowned)* | ✅ **C3** |
| **Completeness and degradation when a source is unavailable** | *(unowned)* | ✅ **C3** |
| **Which parts of the profile a C2 result card may carry** | *(unowned)* | ✅ **C3** |
| **Deep-link and share-target shape** | *(unowned)* | ✅ **C3** |

⭐ **This table is the honest measure of C3's size.** Eight of twelve concerns
are already owned. C3 is a thin composition specification, and it is written as
one rather than padded to look substantial.

---

## §2. ⚠ The open decision that gates part of C3

| Open decision | What is unresolved | Owner | Requirements blocked |
|---|---|---|---|
| **`XPC-OD-003`** | `E-22` (BC Map **L331**) enumerates `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29`. **`BC-19` and `BC-25` are absent.** No lawful edge exists today by which tenant branding or a library gallery becomes a `BC-29` `FileRef` | **Architecture Owner** | `LPP-FR-014` … `LPP-FR-017` |

⛔ **No edge is created here.** `E-22`'s source cell is an **enumeration**, not
the wildcard *"All contexts"* that `E-17`…`E-20` and `E-23` carry. `ADR-0084`
records that for the comparable `E-21`, the wildcard argument *"was tested there
and **failed**"*; `ADR-0083` §4.5 (AO-9) **refused** to mint an edge for
`BC-15` on the same reasoning. Both refusals are honoured.

> **Why the gallery requirements are written at all, rather than deleted.**
> §14A.5 lists **Gallery** as publishable and `LIB-14B.7` requires the preview to
> be *able* to display every §14A.5 field. Deleting the gallery requirements
> would silently contradict a frozen document. Writing them and marking them
> **CONDITIONAL** records both the frozen obligation and the missing carrier,
> and leaves the decision with the role that owns it.

⚠ `LPP-FR-014`…`017` are marked **⚠ CONDITIONAL** throughout. They **MUST NOT**
be implemented until `XPC-OD-003` is decided.

---

## §3. Identifier register

| Register | Range | Count | Contiguous |
|---|---|---|---|
| `LPP-FR-*` | `LPP-FR-001` … `LPP-FR-028` | 28 | Yes |
| `LPP-AC-*` | `LPP-AC-001` … `LPP-AC-014` | 14 | Yes |
| `LPP-XC-*` | `LPP-XC-001` … `LPP-XC-010` | 10 | Yes |

### §3.1 Normative language

| Term | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A build violating it is defective |
| **SHOULD** | Strong recommendation; deviation requires a recorded reason |
| **MAY** | Genuinely optional |
| *(no keyword)* | Explanatory prose. Creates **no** requirement. Quoted `>` blocks are rationale and are **not** normative |

---

## §4. The profile projection

`LPP-FR-001` — The public profile **MUST** be served from the public read
projection defined by `LIB-14B.8`. A public profile request **MUST NOT** reach
an operational table of any context by any path.

`LPP-FR-002` — The profile's field set **MUST** be exactly the §14A.5 public
list. It **MUST NOT** contain a field outside that list, and **MUST NOT** omit a
field the library has populated and published.

`LPP-FR-003` — Every field rendered **MUST** be traceable to a single owning
context per the table below (`LIB-14B.10`). A field whose owner cannot be named
**MUST NOT** be rendered.

| Group | Fields | Owning context |
|---|---|---|
| Identity | Library Name, Library Status | `BC-19` |
| Branding | Logo, Cover Image, Description | `BC-25` |
| Gallery | Images | `BC-29` ⚠ `XPC-OD-003` |
| Location | Business Address, Map Location | `BC-19` |
| Hours | Operating Hours, Weekly Holidays, current open/closed | `BC-06` |
| Facilities | Facility list with optional notes | `BC-06` |
| Plans | Membership Plans & Pricing | `BC-02` |
| Seats | **Aggregate** public seat information | `BC-04` |
| Contact | Business Contact Information | `BC-19` |

`LPP-FR-004` — The profile **MUST** be readable **without authentication**
(`LIB-14B.1`, §14A.8). No field **MUST** be gated behind a sign-in prompt, a
partial blur, a paywall or a "log in to see prices" interstitial
(`LIB-14B.5`).

`LPP-FR-005` — The profile **MUST NOT** require, request or accept a mobile
number as a condition of viewing any part of itself (`LIB-14B.5`,
`MP-GBR-25`).

`LPP-FR-006` — Where a source context is unavailable, the profile **MUST**
render the fields it can resolve and **MUST** mark the unresolved group as
temporarily unavailable. It **MUST NOT** substitute a cached value of unknown
age, and **MUST NOT** fail the whole page because one group failed.

`LPP-FR-007` — Each field group **MUST** carry the freshness of its own source.
The profile **MUST NOT** present a single page-level freshness value that
implies groups are equally current when they are not.

`LPP-FR-008` — The profile **MUST** declare a stable presentation order of field
groups. The order **MUST NOT** vary by viewer, by session, by locale or by any
commercial arrangement.

> **`LPP-FR-008` exists because presentation order is the one thing C3 genuinely
> owns, and an unowned ordering becomes a monetisation surface.** If group order
> may vary "by arrangement", a paid library's plans move above a free library's
> hours and the profile stops being a neutral projection. Fixing the order is
> the smallest rule that prevents that without inventing a policy engine.

---

## §5. Identity and branding

`LPP-FR-009` — Library Name **MUST** be read from `BC-19`'s `TenantOrganisation`
record. C3 **MUST NOT** store, normalise for storage, or re-derive the name.

`LPP-FR-010` — Library Status **MUST** be read from `BC-19`. Only a status whose
visibility mode is **Public** (§14A.6) **MUST** be rendered; any other status
**MUST** be handled by `LPP-FR-026`.

`LPP-FR-011` — Logo **MUST** be read from `BC-25` branding values. C3 **MUST NOT**
hold a logo copy, and **MUST NOT** apply a default logo that could be mistaken
for the library's own mark.

`LPP-FR-012` — Cover Image **MUST** be read from `BC-25`. Where absent, the
profile **MUST** render a neutral placeholder that is visibly generic.

`LPP-FR-013` — Description **MUST** be rendered as the library authored it in
`BC-25`. C3 **MUST NOT** summarise, translate, rewrite, truncate destructively
or machine-generate description text.

> **`LPP-FR-013` is a truthfulness constraint, not a formatting one.** A
> generated or "improved" description is a statement the platform makes on a
> paying customer's behalf about a commercial premises. Rendering the authored
> text is the only form in which the library remains the author.

---

## §6. Gallery — ⚠ CONDITIONAL on `XPC-OD-003`

⚠ **`LPP-FR-014` … `LPP-FR-017` MUST NOT be implemented until `XPC-OD-003` is
decided by the Architecture Owner.** They are recorded because §14A.5 lists
Gallery as publishable and `LIB-14B.7` obliges the surface to be able to show it.

`LPP-FR-014` — ⚠ **CONDITIONAL.** Gallery images **MUST** be served as `BC-29`
`FileRef`s through a lawful integration edge. C3 **MUST NOT** hold image bytes,
**MUST NOT** hold a storage path, and **MUST NOT** construct a storage URL.

`LPP-FR-015` — ⚠ **CONDITIONAL.** Only images the library has explicitly marked
for public display **MUST** be shown. An image that is merely uploaded
**MUST NOT** be public by default.

`LPP-FR-016` — ⚠ **CONDITIONAL.** A gallery image **MUST NOT** be served until
`BC-29`'s virus scan has completed successfully for that object. An unscanned or
failed object **MUST** be treated as absent.

`LPP-FR-017` — ⚠ **CONDITIONAL.** Gallery images **MUST NOT** depict, and
**MUST NOT** be published where they depict, any identifiable student, member or
staff member. Enforcement of that rule belongs to the publishing library and to
the moderation authority; C3 **MUST NOT** self-certify image content.

> **Why `LPP-FR-017` stops short of promising enforcement.** C3 cannot inspect
> image content, and claiming otherwise would be a requirement no build can
> satisfy. What C3 can require is that the prohibition is stated on the public
> surface and that C3 does not present itself as the control. `LIB-14B.22`
> already forbids student photographs from being publicly reachable; this
> requirement points at that rule rather than duplicating its enforcement.

---

## §7. Location, hours and facilities

`LPP-FR-018` — Business Address and Map Location **MUST** be read from `BC-19`.
C3 **MUST NOT** geocode, re-geocode, correct or infer a coordinate.

`LPP-FR-019` — The profile **MUST NOT** publish any location precision beyond
what the library published. It **MUST NOT** refine a published approximate
location using any other signal.

`LPP-FR-020` — Operating Hours and Weekly Holidays **MUST** be read from `BC-06`
and rendered in the library's configured time zone (`LCFG-1`), with the time
zone shown.

`LPP-FR-021` — Current open / closed status **MUST** be computed from `BC-06`
operating hours, holidays and emergency closures (`LIB-14B.19`), and **MUST NOT**
be derived from whether anyone is currently present (`LIB-14B.21`). An active
Emergency Closure **MUST** be reflected within `LCFG-6` (`LIB-14B.20`).

`LPP-FR-022` — Facilities **MUST** be read from `BC-06` as a list, with the
library's optional notes rendered as authored. C3 **MUST NOT** score, rank,
badge, verify or certify a facility claim.

> **`LPP-FR-022`'s prohibition on badging is deliberate.** A "Verified AC" or
> "Top facilities" badge is a platform assertion about a physical premises the
> platform has not inspected. It also creates a ranking signal outside `BC-23`,
> which C2 §1.1 already forbids.

---

## §8. Plans, pricing and seats

`LPP-FR-023` — Membership Plans and Pricing **MUST** be read from a `BC-02`
projection (`LIB-14B.15`). C3 **MUST NOT** store a price, compute a price, apply
a discount, prorate, or total a plan (`LXC-7`). Only plans the library has
marked publicly offered **MUST** appear (`LIB-14B.16`).

`LPP-FR-024` — Displayed prices **MUST** be marked as indicative for public
display (`LIB-14B.18`). The profile **MUST NOT** show any student-specific
price, discount, outstanding balance or personalised offer — there is no known
visitor (`LIB-14B.17`).

`LPP-FR-025` — Public seat information **MUST** be limited to the aggregate
capacity and coarse qualitative indicator that `LIB-14B.11`, `LIB-14B.12` and
`SEAT-FR-117` permit. The profile **MUST NOT** show a precise free-seat count, a
per-seat identifier, a per-seat state, a live occupancy count or percentage, or
any value derived from attendance (`LIB-14B.13`, `LIB-14B.14`, `SEAT-XC-009`).
The seat surface is specified in full by **C4**.

---

## §9. Anti-enumeration and error hygiene

`LPP-FR-026` — A profile request for a library that is **non-existent, Private,
Draft, Pending, Suspended or Archived MUST** produce the **same** observable
response: the same status code, the same body shape, the same message, and a
response time that does not distinguish the cases (`LIB-14B.24`, `AR-7`).

> **This is the requirement most likely to be broken by an otherwise correct
> implementation.** A build that returns `404` for "no such library" and `403`
> for "private library" has, without writing a single line of leaking code, given
> an anonymous caller an oracle for enumerating every private library on the
> platform. `AUTH-3.*` already requires identical observable behaviour for
> registered and unregistered phone numbers; `LIB-14B.24` applies the same
> reasoning here, and C3 restates it because C3 is where the endpoint lives.

`LPP-FR-027` — A Private library **MUST NOT** be reachable through the public
profile surface by any identifier, guessed slug, cached link, sitemap entry or
enumeration of internal identifiers. It is reachable only through a valid
invitation artefact (`LIB-14B.23`, `LIB-DISC-004`).

`LPP-FR-028` — Error responses **MUST NOT** disclose internal identifiers, table
names, query structure, stack traces, context names or configuration values
(`LIB-14B.25`). Internal identifiers that would reveal tenant count or creation
order **MUST NOT** appear in any public response (`LIB-18.2`).

---

## §10. Exclusions

⛔ Each exclusion is a **boundary**, not a backlog item.

| ID | C3 does **not** | Authority |
|---|---|---|
| `LPP-XC-001` | Own, store or master any library field. C3 owns composition only | `AR-1`; `LIB-14B.10` |
| `LPP-XC-002` | Perform any write, mutation or state change. The profile is **read-only** | `AR-1` |
| `LPP-XC-003` | Publish, emit or define **any** event. C3 is a consumer of projections only | `AR-1`; BC Map §7.3 |
| `LPP-XC-004` | Add any public field, or remove any restriction, relative to §14A.5 and `LIB-14B.22` | §14A.5 (FROZEN); `LIB-14B.7` |
| `LPP-XC-005` | Show a rating, review, star score, testimonial or any reputation value | `ARCHITECTURE_RULINGS.md` §6 — *Reviews & Ratings, deferred **V2**, requires a new context and an ADR* |
| `LPP-XC-006` | Show per-seat identity, per-seat state, live occupancy or a precise free-seat count | `LIB-14B.11`…`14`; `SEAT-XC-009`; `ARCHITECTURE_RULINGS.md` §6 |
| `LPP-XC-007` | Decide any authorisation locally. Every access decision is delegated to `BC-18` | `X-13` |
| `LPP-XC-008` | Show any social signal — friends attending, followers, group membership, peer activity, `PersonId`-keyed data | `X-05` (Matrix **L354**); `ID-3` (BC Map **L180**) |
| `LPP-XC-009` | Preview, index, cache or acknowledge a Private library | §14A.6; `LIB-14B.23`, `LIB-14B.24` |
| `LPP-XC-010` | Compute, store, total, discount or prorate a price | `LXC-7`; `LIB-14B.15`, `LIB-14B.18` |

> **`LPP-XC-008` deserves a note, because a "3 of your friends study here" badge
> is an obvious product idea.** It is structurally forbidden twice: `X-05`
> forbids the `LIBRARY MANAGEMENT ↔ BC-11…BC-17` dependency it needs, and `ID-3`
> forbids the global band from resolving *"which library a person attends"* at
> all. It is not deferred pending appetite; it is prohibited pending an
> architecture decision that does not exist.

---

## §11. Acceptance criteria

⚠ **0 of the 14 criteria below is proven by an executed test.** They are
authored specifications of verifiable behaviour, at Stage 2.

**`LPP-AC-001` — Profile is fully readable anonymously**
> **Given** a library whose visibility mode is Public
> **When** an unauthenticated caller requests its public profile
> **Then** every populated §14A.5 field is returned
> **And** no field is blurred, truncated, withheld or gated behind a sign-in prompt
> **And** no mobile number is requested at any point.

**`LPP-AC-002` — No field outside the frozen public list**
> **Given** the rendered public profile of any library
> **When** the response payload is enumerated field by field
> **Then** every field appears in the §14A.5 public list
> **And** no field appears in the §14A.5 never-public list or in `LIB-14B.22`.

**`LPP-AC-003` — Every field names an owner**
> **Given** the public profile projection schema
> **When** each field is traced to a context
> **Then** each resolves to exactly one of `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04`
> **And** no field resolves to C3 itself.

**`LPP-AC-004` — Partial source failure degrades one group only**
> **Given** a library whose `BC-02` plan projection is unavailable
> **When** an anonymous caller requests the profile
> **Then** identity, branding, location, hours, facilities and seat groups render
> **And** the plans group is marked temporarily unavailable
> **And** no stale plan price of unknown age is shown
> **And** the request does not return a page-level error.

**`LPP-AC-005` — Group freshness is reported per group**
> **Given** a profile whose hours projection updated 30 seconds ago and whose plan projection updated 6 hours ago
> **When** the profile is rendered
> **Then** each group's freshness reflects its own source
> **And** no single page-level freshness value implies the two groups are equally current.

**`LPP-AC-006` — Presentation order is invariant**
> **Given** the same library profile requested by two different anonymous callers, in two locales, in two sessions
> **When** the field-group order of each response is compared
> **Then** the order is identical in all four responses.

**`LPP-AC-007` — Description is rendered as authored**
> **Given** a library description containing the library's own wording and formatting
> **When** the profile is rendered
> **Then** the text matches the `BC-25` value exactly
> **And** no summarised, translated, rewritten or machine-generated variant is shown.

**`LPP-AC-008` — Gallery is absent while `XPC-OD-003` is open**
> **Given** `XPC-OD-003` is undecided
> **When** a build is assessed against `LPP-FR-014`…`LPP-FR-017`
> **Then** no gallery image is served
> **And** the absence is attributed to the open decision, not to a missing implementation
> **And** no storage path or storage URL is present in any public response.

**`LPP-AC-009` — Open / closed is policy-derived, never presence-derived**
> **Given** a library that is inside its `BC-06` operating hours and currently has zero people present
> **When** the profile is rendered
> **Then** the status shows **Open**
> **And** the value is computed from operating hours, holidays and emergency closures only
> **And** no attendance or occupancy value contributes to it.

**`LPP-AC-010` — Emergency closure surfaces within the configured bound**
> **Given** a library that activates an Emergency Closure at time `T`
> **When** the public profile is requested at `T + LCFG-6`
> **Then** the status reflects the closure.

**`LPP-AC-011` — Pricing is indicative, never personalised**
> **Given** a library with one publicly offered plan, one internal plan and one negotiated rate
> **When** an anonymous caller reads the profile
> **Then** only the publicly offered plan appears
> **And** it is marked indicative for public display
> **And** no student-specific price, discount, balance or personalised offer appears.

**`LPP-AC-012` — Seat surface stays aggregate and coarse**
> **Given** a library with 100 seats of which 37 are currently free
> **When** an anonymous caller reads the profile
> **Then** the aggregate capacity may be shown
> **And** availability is expressed only as a coarse indicator such as *Available*, *Limited* or *Full*
> **And** the number 37, any percentage, any per-seat identifier and any per-seat state are absent from the response.

**`LPP-AC-013` — Anti-enumeration responses are indistinguishable**
> **Given** four identifiers: one non-existent, one Private, one Suspended and one Archived
> **When** each is requested through the public profile endpoint by an anonymous caller
> **Then** all four responses share the same status code, the same body shape and the same message
> **And** the response-time distributions are not separable
> **And** no response reveals which case occurred.

**`LPP-AC-014` — Errors leak no internals**
> **Given** an induced failure in the profile projection read path
> **When** the public error response is inspected
> **Then** it contains no internal identifier, table name, query fragment, stack trace, context name or configuration value.

---

## §12. Traceability to authority

| Requirement group | Governing authority |
|---|---|
| `LPP-FR-001`…`008` | `AR-1`; `MASTER_PRD.md` **L171** module 19; `LIB-14B.1`, `5`, `8`, `9`, `10`; §14A.5, §14A.8 |
| `LPP-FR-009`…`013` | §14A.5, §14A.6; `LIB-14B.7`; BC Map **L128** (`BC-19`), **L134** (`BC-25`) |
| `LPP-FR-014`…`017` | §14A.5; `LIB-14B.7`; `LIB-14B.22`; BC Map **L138**, **L331**; ⚠ `XPC-OD-003`; `ADR-0084`, `ADR-0083` §4.5 |
| `LPP-FR-018`…`022` | §14A.5; `LIB-14B.19`, `20`, `21`; `LCFG-1`, `LCFG-6`; BC Map **L101** (`BC-06`) |
| `LPP-FR-023`…`025` | `LIB-14B.15`…`18`; `LIB-14B.11`…`14`; `LXC-7`; `SEAT-XC-009`, `SEAT-FR-117`; `LIB-7.3` |
| `LPP-FR-026`…`028` | `LIB-14B.23`, `24`, `25`; `AR-7`; `LIB-DISC-004`; `LIB-18.2`; `AUTH-3.*` |

---

## §13. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered. **4 of 28** requirements ⚠ **CONDITIONAL** on
`XPC-OD-003`. **0** ADRs, **0** contexts, **0** edges, **0** events, **0**
aggregates, **0** new public fields, **0** `IMPL-*`, **0** Rank 1–6 documents
modified, **0** lines of code.

---

## §14. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created. Specifies the public library profile as a **projection and presentation layer** over §14A.5 / §14B.4, duplicating nothing from Library Management. 28 FR (4 conditional) · 14 AC · 10 XC |
