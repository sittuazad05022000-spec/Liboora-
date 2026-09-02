<!--
  PROVENANCE — PRD-021C Part C3 (Library Public Profile)

  Status        : DRAFT — v0.2 (Stage 2)
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

  Analytics ownership note (v0.2, section 9A)
  -------------------------------------------
  The Owner Profile Engagement Summary is a C3 PRESENTATION/READOUT
  requirement. It is NOT a new analytics domain. Analytics ownership is
  RECONCILED to the owner that already exists in the repository:

    BC-26 Analytics Read Model  — owns the metric/semantic layer, read-model
                                  store, projections, reports, exports
                                  (BC Map L135); owns CertifiedMetric and
                                  ReadModel (BC Map L385). Rank 4.
    PRD-009 Analytics & Reports — the registered owner of the analytics
                                  experience for BC-26, V1, status PLANNED
                                  (PRD_REGISTRY.md L246). ABSENT from disk.

  C3 renders already-certified metrics and defines NO metric semantics.

  TWO OPEN decisions gate parts of C3:
    XPC-OD-003 — E-22's consumer enumeration omits BC-19 and BC-25, so the
                 public gallery cannot lawfully be served as a FileRef today
                 (Architecture Owner)
    XPC-OD-007 — No profile-view event producer and no lawful edge into BC-26
                 exists. Which context produces the profile-view fact, over
                 which declared edge, and does PRD-009 certify ProfileViews
                 and UniqueViewers as CertifiedMetrics?
                 (Architecture Owner + Product Owner)

  What this file does NOT do
  --------------------------
    - Creates no bounded context, edge, event, aggregate or invariant.
    - Publishes no field outside the frozen 14A.5 list.
    - Creates NO analytics system, metric store, database, event pipeline
      or parallel tracking architecture. Defines NO metric semantics.
    - Renders NO engagement metric on the public profile surface
      (14A.5 lists Internal Analytics as NEVER-PUBLIC; LIB-14B.22 repeats it).
    - Amends no FROZEN PRD and no Rank 1-6 artefact.
    - Mints no IMPL-* identifier. Confers no lifecycle stage.
-->

# PRD-021C — PART C3

## Library Public Profile

### v0.2 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 has **not** been entered.
> ⚠⚠ **4 of 44 requirements are CONDITIONAL on `XPC-OD-003`** — see §2.
> ⚠⚠ **15 of 44 requirements are CONDITIONAL on `XPC-OD-007`** — see §9A.1.

| Field | Value |
|---|---|
| **PRD** | `PRD-021C` Part **C3** |
| **Part title** | Library Public Profile |
| **Version** | **v0.2** |
| **Status** | **`DRAFT`** — Stage 2 |
| **Structural classification** | Part of the `AR-1` read composition (module 19). ⛔ **NOT a bounded context** |
| **Release** | **V1** |
| **Identifier prefix** | `LPP-*` — collision-checked at **0** occurrences |
| **Owns** | ⛔ **No entity. No field. No aggregate. No invariant.** Composition rules and presentation semantics only |
| **Consumes** | `BC-19` Tenancy · `BC-25` Configuration · `BC-29` File & Media *(⚠ conditional)* · `BC-06` Library Policy · `BC-02` Membership · `BC-04` Seating — projected via `BC-23` · `BC-26` Analytics Read Model *(⚠ conditional — read-only metric readout, §9A)* |
| **Analytics ownership** | ⛔ **Not C3's.** Metric/semantic layer = **`BC-26`** (BC Map **L135**, **L385**). Analytics experience = **`PRD-009`** (`PRD_REGISTRY.md` **L246**, `PLANNED`). C3 **renders only** |
| **Access control** | Public profile = anonymous (`LPP-FR-004`). §9A summary = **`PO-12`**, delegated to `BC-18` (`LPP-FR-032`) |
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

## §2. ⚠ The open decisions that gate parts of C3

| Open decision | What is unresolved | Owner | Requirements blocked |
|---|---|---|---|
| **`XPC-OD-003`** | `E-22` (BC Map **L331**) enumerates `BC-01`, `BC-10`, `BC-12`, `BC-14` → `BC-29`. **`BC-19` and `BC-25` are absent.** No lawful edge exists today by which tenant branding or a library gallery becomes a `BC-29` `FileRef` | **Architecture Owner** | `LPP-FR-014` … `LPP-FR-017` |
| **`XPC-OD-007`** | No profile-view event producer exists in the V1 event surface (BC Map §9), and the only edge into `BC-26` is `E-26` (`BC-27 AI → BC-26, BC-23`), which is not a telemetry ingress. `PRD-009` — `BC-26`'s registered owner — is `PLANNED` and absent from disk | **Architecture Owner** *(producer + edge)* **+ Product Owner** *(`PRD-009` metrics)* | `LPP-FR-030` … `LPP-FR-044`; `LPP-AC-015` … `LPP-AC-022` — see **§9A.1** |

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
| `LPP-FR-*` | `LPP-FR-001` … `LPP-FR-044` | 44 | Yes |
| `LPP-AC-*` | `LPP-AC-001` … `LPP-AC-022` | 22 | Yes |
| `LPP-XC-*` | `LPP-XC-001` … `LPP-XC-017` | 17 | Yes |

⚠ **`LPP-FR-029`…`044`, `LPP-AC-015`…`022` and `LPP-XC-011`…`017`** were added
in **v0.2** for the Owner Profile Engagement Summary (§9A). `LPP-FR-030`…`044`
(15 requirements) and `LPP-AC-015`…`022` (8 criteria) are ⚠ **CONDITIONAL** on
`XPC-OD-007`.

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

## §9A. Owner Profile Engagement Summary

> ⚠⚠ **All 16 requirements in this section are CONDITIONAL on `XPC-OD-007`.**
> See §9A.1. No profile-view event producer and no lawful edge into `BC-26`
> exists in the repository today.

### §9A.1 ⭐ The analytics ownership determination

This section is a **presentation/readout requirement of C3**. It is **not** a new
analytics domain. The repository already has an analytics owner, and C3
reconciles to it rather than inventing one.

| Concern | Authoritative owner | Measured source |
|---|---|---|
| Metric **definition** (what "a profile view" counts as) | **`BC-26` Analytics Read Model** — *"Owns the metric/semantic layer… metric definitions single-sourced from the semantic layer"* | BC Map **L135**, **L385** (Rank 4) |
| Metric **store, projection, report, export** | **`BC-26`** | BC Map **L135** |
| The analytics **product surface** (dashboards, detailed analytics) | **`PRD-009` Analytics & Reports** → `BC-26`, `[GENERIC]`, V1 | `PRD_REGISTRY.md` **L246** |
| Profile-view **event production** | ⚠ **UNDETERMINED** → `XPC-OD-007` | no producer exists — see below |
| **Rendering** an already-certified metric on the profile | **C3** (this document) | this section only |

`BC-26` is `[GENERIC]`, Release **V1**, and is a **projection** context whose
own invariant is *"Fully rebuildable from the event log; no projection is a
system of record"* (BC Map **L385**). It is therefore already exactly the shape
this requirement needs: a read model that certifies metrics and is never a
source of truth.

**Two gaps were measured, and neither is closed here:**

1. **`PRD-009` does not exist on disk.** `PRD_REGISTRY.md` **L246** registers it
   as `PLANNED`. `find docs/ -iname "*009*"` returns no `PRD-009` document. The
   *owner* of the metric definition is therefore named at Rank 4 (`BC-26`) but
   the *specification* that would define `ProfileViews` and `UniqueViewers` as
   `CertifiedMetric`s has not been authored. This is structurally identical to
   `XPC-OD-002` (`PRD-015`, `BC-23`'s absent owner) and is recorded the same
   way — as an OPEN decision, not as an assumption.

2. **No profile-view event exists, and C3 cannot produce one.** The V1 event
   surface (BC Map §9) contains no view event for any aggregate. The naming
   convention is binding — `<Context>.<Aggregate><PastTenseVerb>` — and every
   producer in the catalogue is a context that owns an aggregate. C3 owns no
   aggregate (`LPP-XC-001`) and is already forbidden from emitting any event
   (`LPP-XC-003`), so C3 cannot be the producer. The only edge into `BC-26` in
   §7.3 is **`E-26`** (`BC-27 AI → BC-26, BC-23`), which is inbound to AI, not a
   telemetry ingress for a composition capability.

> **The repository has already reasoned about view events once, and reached the
> opposite conclusion to a naive tracking design.** `SM-7.17` records that
> *"`StudentViewed` is deliberately absent — viewing is an **audit** concern
> (§8.3), not a domain event."* That precedent does not resolve this section, but
> it does mean the question *"which context may lawfully emit a view fact, and to
> which consumer"* is a live architectural question with an existing answer for a
> neighbouring case. Minting `library.ProfileViewed` here — and an edge to carry
> it — would be exactly the *"duplicate event pipeline"* this requirement
> forbids. It is recorded as `XPC-OD-007` and left open.

`XPC-OD-007` — **Which context lawfully produces the profile-view fact, over
which declared edge, and does `PRD-009` certify `ProfileViews` and
`UniqueViewers` as `CertifiedMetric`s of `BC-26`?**
**Owner: Architecture Owner** (edge + producer) **and Product Owner**
(`PRD-009` metric definitions).

### §9A.2 ⚠ Reconciliation with `LPP-FR-002`, `LPP-FR-004` and `LPP-FR-008`

The engagement summary is **viewer-varying**, and three already-authored C3
requirements forbid viewer-varying content. All three are reconciled **without
amendment**, because the summary is not part of the public projection at all.

| Requirement | Apparent tension | Reconciliation |
|---|---|---|
| `LPP-FR-002` — field set **MUST** be exactly the §14A.5 public list | Is the summary a new profile field? | **No.** It is an **owner-only overlay rendered outside the public projection**. `LPP-FR-030` forbids it from entering the projection. §14A.5's field set is untouched; `LPP-XC-004` still holds |
| `LPP-FR-004` — profile **MUST** be readable without authentication | Does the summary gate the profile? | **No.** The anonymous response is byte-identical whether or not an owner exists. The overlay is additive **after** a successful `BC-18` decision, never a precondition for reading any public field |
| `LPP-FR-008` — order **MUST NOT** vary by viewer | Position 7 appears only for owners | **Ordering is invariant within each audience class.** The public order is fixed and identical for every anonymous and every non-owner viewer. Position 7 is a **reserved slot** that is either absent (all public viewers) or occupied by the summary (authorised owner/admin only). No commercial arrangement, locale or session may reorder either rendering |

> **This is the reconciliation that keeps `LPP-FR-008` meaningful.** `LPP-FR-008`
> exists to stop presentation order becoming a monetisation surface. A reserved
> slot that is *structurally* owner-only does not create that surface — it cannot
> be sold, because no amount of payment makes a viewer the owner. What would
> break `LPP-FR-008` is a slot whose *occupancy* varies by arrangement, and
> `LPP-FR-029` forbids exactly that.

### §9A.3 Presentation order

`LPP-FR-029` — The profile **MUST** render its groups in exactly this order.
Position **7** is a **reserved owner-only slot** (§9A.2). The order **MUST NOT**
vary by viewer within an audience class, by session, by locale or by any
commercial arrangement (`LPP-FR-008`).

| # | Group | Audience | Governing requirement |
|---|---|---|---|
| 1 | Library Identity & Basic Information | Public | `LPP-FR-009`, `LPP-FR-010` |
| 2 | Photos / Media | Public ⚠ `XPC-OD-003` | `LPP-FR-014`…`017` |
| 3 | Facilities & Amenities | Public | `LPP-FR-021`, `LPP-FR-022` |
| 4 | Location, Hours & Contact | Public | `LPP-FR-018`…`020` |
| 5 | Pricing / Membership Information | Public | `LPP-FR-023`, `LPP-FR-024` |
| 6 | Availability Preview | Public — **aggregate only** | `LPP-FR-025`; C4 |
| **7** | **Owner Profile Engagement Summary** | ⛔ **Owner/admin only** ⚠ `XPC-OD-007` | **`LPP-FR-030`…`044`** |
| 8 | Owner/Admin Profile Controls | ⛔ Owner/admin only | `LIB-14B.27` `PO-12` |
| 9 | Privacy & Visibility | ⛔ Owner/admin only | §14A.6 |
| 10 | Profile Actions | Mixed — per `PO-*` | `LIB-14B.27` |

### §9A.4 Non-public by construction

`LPP-FR-030` — The engagement summary **MUST NOT** form part of the public
profile projection. It **MUST NOT** appear in an anonymous response **in any
form, including aggregated, derived, inferred, cached, embedded-metadata or
error-message form** (§14A.5 *Internal Analytics*, **never-public**;
`LIB-14B.22` — *"Internal analytics, dashboards, occupancy trends"*).

> **This requirement is not defensive drafting; it is the frozen field list
> speaking.** §14A.5 places *Internal Analytics* on the **never-public** list and
> `LIB-14B.22` repeats it. A view counter rendered to an anonymous visitor would
> publish an internal analytic on a public endpoint — which `LPP-XC-004` already
> forbids C3 from doing. The summary is lawful **only** because it never enters
> the public surface.

`LPP-FR-031` — The presence or absence of the summary **MUST NOT** be observable
to an unauthorised caller. Status code, body shape, payload size class, field
ordering and response timing of the public profile **MUST** be indistinguishable
whether the summary exists, is empty, or is unavailable (`LPP-FR-026`,
`LIB-14B.24`, `AR-7`).

`LPP-FR-032` — Rendering the summary is a **protected operation** under
`LIB-14B.27` **`PO-12`** (*any staff or administrative function*). Access
**MUST** be delegated to **`BC-18` Identity & Access**. C3 **MUST NOT** evaluate
any permission locally (`LIB-14B.30`, `LPP-XC-007`, `X-13`).

`LPP-FR-033` — Authorisation **MUST** be evaluated **in addition to**
authentication. A valid session **MUST NOT** be treated as permission
(`LIB-14B.29`, `AUTH-7.3`). An authenticated visitor with no owner/admin role in
**this** library **MUST** be refused.

`LPP-FR-034` — The summary **MUST** be scoped to the requested library's own
tenant. A request **MUST** carry tenant context and **MUST** be refused where it
is absent or does not match (`MP-GBR-08`, `SE-1`, `X-13`; `AR-3` **Tenant
Operational Data** class — *not* the Platform Public Discovery Index class).

> **`LPP-FR-034` is the highest-severity rule in this section.** BC Map §11.1
> records that *"the single highest-severity failure mode in the entire
> architecture is a cross-tenant data leak via a capability context."* The public
> profile is deliberately served with **no caller tenant context** (`AR-3`,
> Platform Public Discovery Index). Bolting a tenant-scoped metric onto that same
> endpoint is precisely the shape of that failure mode, which is why the overlay
> must be resolved on the operational-data path with a mandatory tenant key and
> never on the discovery-index path.

### §9A.5 Metrics — read, never computed

`LPP-FR-035` — **Total Profile Views MUST** be read as a **`CertifiedMetric`
of `BC-26`**. C3 **MUST NOT** count, increment, store, cache-as-source,
aggregate, sample or re-derive it (BC Map **L135**, **L385**).

`LPP-FR-036` — ⚠ **CONDITIONAL.** **Unique Viewers MUST** be rendered **only
where `BC-26` publishes it as a `CertifiedMetric`**. C3 **MUST NOT** compute
uniqueness, deduplicate by identifier, fingerprint a device, or infer
distinctness from any signal. Where the metric is not published, the field
**MUST** be omitted — **not** shown as zero, unknown or "coming soon".

`LPP-FR-037` — The **period/trend summary** (e.g. *"+18% this week"*) **MUST**
be a comparison published by `BC-26` over `BC-26`-defined periods. C3 **MUST
NOT** compute the delta, choose the comparison window, or annualise, smooth or
project it. The period **MUST** be labelled explicitly; a trend without a stated
period **MUST NOT** be rendered.

`LPP-FR-038` — C3 **MUST NOT** define the metric semantics — what constitutes a
view, whether a bot is excluded, whether an owner's own visit counts, or the
deduplication window. These are `BC-26` semantic-layer concerns and belong to
`PRD-009` (⚠ `XPC-OD-007`).

> **`LPP-FR-038` is a refusal, and it is deliberate.** A readout that defines its
> own metric semantics *is* a parallel analytics system, however small. Two
> surfaces that each decide independently whether a bot counts will disagree, and
> the owner will be shown *"1.2K"* on the profile and a different number in the
> analytics dashboard. Declining to define the semantics is the only way the CTA
> in `LPP-FR-040` can lead somewhere consistent.

### §9A.6 Viewer privacy

`LPP-FR-039` — The summary **MUST NOT** expose individual viewer identities by
default. It **MUST NOT** render a viewer list, name, avatar, handle, `PersonId`,
`AccountId`, partial identifier, device identifier, precise timestamp of an
individual view, or any value from which an individual viewer could be
re-identified (§14A.5 never-public; `LIB-14B.27` **`PO-11`**; `ID-3`).

`LPP-FR-040` — Where a metric value is small enough that it could identify an
individual viewer, it **MUST** be suppressed rather than rendered. C3 **MUST
NOT** define the suppression threshold; the threshold is a `BC-26` semantic-layer
concern (⚠ `XPC-OD-007`).

`LPP-FR-041` — The summary **MUST NOT** render any social signal — which
friends, followers, group members or peers viewed the profile — under any
aggregation (`X-05`, Matrix **L354**; `ID-3`, BC Map **L180**; `LPP-XC-008`).

### §9A.7 The View Analytics CTA

`LPP-FR-042` — The **View Analytics** CTA **MUST** hand off to the analytics
experience owned by **`PRD-009` / `BC-26`**. C3 **MUST NOT** render detailed
analytics, a chart, a breakdown, a segment, a funnel, an export or a date-range
picker inline.

`LPP-FR-043` — The CTA **MUST** be rendered only to a caller already authorised
under `LPP-FR-032`. For every other caller it **MUST** be **absent**, not
disabled-with-explanation, not present-and-refusing (`LPP-FR-031`).

`LPP-FR-044` — Where `BC-26` is unavailable or the metric cannot be resolved, the
summary **MUST** mark itself temporarily unavailable and **MUST NOT** render
zero, a stale value of unknown age, or an inferred value (`LPP-FR-006`). It
**MUST** carry the freshness of its own source (`LPP-FR-007`), and **MUST NOT**
fail the public profile (`LPP-FR-030`).

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
| `LPP-XC-011` | Create an analytics system, metric store, read-model store, warehouse or reporting database. `BC-26` owns all of these | BC Map **L135**, **L385**; `AR-1` |
| `LPP-XC-012` | Create an event pipeline, telemetry collector, tracking endpoint, beacon, pixel or parallel tracking architecture | `LPP-XC-003`; BC Map §9 naming convention (binding) |
| `LPP-XC-013` | Define, own or version any metric semantic — view definition, bot exclusion, deduplication window, suppression threshold or comparison period | BC Map **L385** *(metric definitions single-sourced from the semantic layer)*; `PRD-009` ⚠ `XPC-OD-007` |
| `LPP-XC-014` | Emit, name or route a profile-view event, or mint an edge to carry one | `LPP-XC-003`; BC Map §7.3; `ADR-0084`, `ADR-0083` §4.5 *(edge-minting refused)*; ⚠ `XPC-OD-007` |
| `LPP-XC-015` | Render any engagement metric, in any form, on the public profile surface | §14A.5 *Internal Analytics* (**never-public**); `LIB-14B.22` |
| `LPP-XC-016` | Identify, list, name, count-to-identifiability or re-identify an individual viewer | §14A.5; `LIB-14B.27` `PO-11`; `ID-3` |
| `LPP-XC-017` | Render detailed analytics, charts, breakdowns, segments, exports or date-range controls inline | `PRD-009` / `BC-26` owns the analytics experience |

> **`LPP-XC-011`…`014` are the four exclusions that make this a readout rather
> than a second analytics system.** The requirement that produced §9A explicitly
> forbids a duplicate analytics system, database, event pipeline or parallel
> tracking architecture. Stating that as prose would have been an intention;
> stating it as four boundaries with named authorities makes it testable — and
> makes it visible if a later revision quietly crosses one.

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

### §11.1 Owner Profile Engagement Summary — acceptance criteria

⚠ **All 8 criteria below are CONDITIONAL on `XPC-OD-007`** and, like the 14
above, **0 are proven by an executed test.**

**`LPP-AC-015` — The summary is invisible to the public surface**
> **Given** a library whose visibility mode is Public and whose owner has a non-zero view count
> **When** an unauthenticated caller requests its public profile
> **Then** no engagement metric appears in any form — aggregated, derived, inferred, cached, embedded in metadata or in an error message
> **And** the response is indistinguishable in status code, body shape, payload size class, field order and response timing from the same profile with an empty or unavailable summary.

**`LPP-AC-016` — Authentication alone does not admit**
> **Given** an authenticated caller holding a valid session but no owner or admin role in the requested library
> **When** the caller requests the profile
> **Then** the engagement summary is **absent** from the response
> **And** the View Analytics CTA is **absent**, not disabled and not present-and-refusing
> **And** the authorisation decision was returned by `BC-18`, with no permission evaluated locally.

**`LPP-AC-017` — Cross-tenant refusal**
> **Given** an authorised owner of library A
> **When** that caller requests the engagement summary of library B, and separately requests it with tenant context absent
> **Then** both requests are refused
> **And** no metric value, existence signal or count for library B is returned in either case.

**`LPP-AC-018` — Metrics are read, never computed**
> **Given** the engagement summary read path
> **When** its data sources are traced
> **Then** Total Profile Views resolves to a `CertifiedMetric` of `BC-26`
> **And** no counter, increment, aggregation, sample or re-derivation is performed by C3
> **And** C3 holds no metric store of its own.

**`LPP-AC-019` — Unique Viewers is omitted when uncertified**
> **Given** a deployment in which `BC-26` does not publish a Unique Viewers `CertifiedMetric`
> **When** an authorised owner views the summary
> **Then** the Unique Viewers field is omitted entirely
> **And** it is not rendered as zero, as unknown, or as "coming soon"
> **And** no uniqueness is computed, deduplicated, fingerprinted or inferred by C3.

**`LPP-AC-020` — Trend carries an explicit period**
> **Given** a rendered period/trend summary such as "+18% this week"
> **When** the value and its label are inspected
> **Then** both the delta and the comparison period were published by `BC-26`
> **And** the period is stated explicitly in the rendering
> **And** no trend is rendered without a stated period
> **And** C3 performed no delta, smoothing, annualisation or projection.

**`LPP-AC-021` — No individual viewer is identifiable**
> **Given** an authorised owner viewing the engagement summary
> **When** the full response payload is enumerated
> **Then** it contains no viewer name, avatar, handle, `PersonId`, `AccountId`, partial identifier, device identifier or individual-view timestamp
> **And** it contains no social signal describing which friends, followers, group members or peers viewed the profile
> **And** where a value is small enough to identify an individual, it is suppressed rather than rendered.

**`LPP-AC-022` — No duplicate analytics architecture exists**
> **Given** the complete C3 implementation surface
> **When** it is inspected for analytics infrastructure
> **Then** C3 declares no metric store, read-model store, warehouse or reporting database
> **And** C3 declares no event, telemetry collector, tracking endpoint, beacon or pixel
> **And** C3 defines no metric semantic — view definition, bot exclusion, deduplication window, suppression threshold or comparison period
> **And** the View Analytics CTA hands off to the `PRD-009` / `BC-26` experience rather than rendering analytics inline.

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
| `LPP-FR-029` | `LPP-FR-008`; §9A.2 reconciliation; `LIB-14B.27` `PO-12` |
| `LPP-FR-030`…`034` | §14A.5 *Internal Analytics* (**never-public**); `LIB-14B.22`, `24`, `27` (`PO-11`, `PO-12`), `29`, `30`; `AR-3` / BC Map §11.1; `AR-7`; `MP-GBR-08`; `SE-1`; `X-13` |
| `LPP-FR-035`…`038` | BC Map **L135** (`BC-26` owns the metric/semantic layer), **L385** (`CertifiedMetric`, `ReadModel`); `PRD_REGISTRY.md` **L246** (`PRD-009`); ⚠ `XPC-OD-007` |
| `LPP-FR-039`…`041` | §14A.5; `LIB-14B.27` `PO-11`; `ID-3` (BC Map **L180**); `X-05` (Matrix **L354**) |
| `LPP-FR-042`…`044` | `PRD_REGISTRY.md` **L246**; BC Map **L135**; `LPP-FR-006`, `LPP-FR-007`, `LPP-FR-031` |

---

## §13. Status

**`DRAFT` · Stage 2 · NOT FROZEN · NOT APPROVED · NOT BASELINED · Rank: none.**
Stage 3 **not** entered. **4 of 44** requirements ⚠ **CONDITIONAL** on
`XPC-OD-003`; a further **15 of 44** (§9A) ⚠ **CONDITIONAL** on `XPC-OD-007`.
**0** ADRs, **0** contexts, **0** edges, **0** events, **0** aggregates, **0**
new public fields, **0** analytics systems, **0** metric definitions, **0**
`IMPL-*`, **0** Rank 1–6 documents modified, **0** lines of code.

---

## §14. Change history

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-02 | Created. Specifies the public library profile as a **projection and presentation layer** over §14A.5 / §14B.4, duplicating nothing from Library Management. 28 FR (4 conditional) · 14 AC · 10 XC |
| **v0.2** | 2026-09-02 | Added **§9A Owner Profile Engagement Summary** as a C3 **presentation/readout** requirement — **not** a new analytics domain. Reconciled analytics ownership to the **existing** owner: `BC-26` Analytics Read Model (BC Map **L135**, **L385**) for the metric/semantic layer, `PRD-009` (`PRD_REGISTRY.md` **L246**, `PLANNED`) for the analytics experience. Added the mandated **10-item presentation order** (`LPP-FR-029`) with the summary at position **7** as an owner-only reserved slot, reconciling `LPP-FR-002` / `004` / `008` **without amending them**. Recorded **`XPC-OD-007`** OPEN — no profile-view event producer and no lawful edge into `BC-26` exists. **+16 FR · +8 AC · +7 XC** → 44 FR · 22 AC · 17 XC. Stage held at **2**. `BC-17`, C1, C2, C4 and all Rank 1–6 / FROZEN artefacts **unchanged** |
