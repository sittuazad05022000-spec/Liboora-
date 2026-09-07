# Library PRD §14B — Public Library Preview

| Field | Value |
|---|---|
| **Version** | v1.0 |
| **Status** | **Approved — authoritative** |
| **Part of** | [`Library_PRD_v1.md`](./Library_PRD_v1.md) |
| **Extends** | §14A Library Discovery & Enrollment |
| **Classification** | Application / read composition capability. **Not a bounded context** (`AR-1`) |
| **Tier** | **V1** |

---

## 14B.1 Purpose

Public Library Preview allows **anyone** — with no account, no session and no
prior relationship with the platform — to browse a library's public information
and decide whether to join.

It is the platform's shop window. A prospective student can see branding, photos,
facilities, membership plans, seat availability information and opening hours
before being asked for a phone number.

§14A established *that* public discovery exists and *what* may be published.
§14B specifies **how an anonymous request is served safely**, and draws the
precise line at which authentication becomes mandatory.

---

## 14B.2 Relationship to §14A

§14B adds no new public field and removes no restriction. It is the
**enforcement and delivery** specification for what §14A already permits.

| Concern | §14A | §14B |
|---|---|---|
| Which fields may be public | **Defines** (§14A.5) | Consumes; adds nothing |
| Which operations need authentication | **Defines** (§14A.9) | Enforces; extends the list |
| How an anonymous request is served | — | **Defines** |
| How intent survives authentication | Requires (`LIB-DISC-012`) | **Specifies** |
| Anonymous abuse protection | — | **Defines** |

`LIB-14B.1` — Where §14B and §14A could be read as differing on which fields are
public, **§14A.5 governs**. §14B **MUST NOT** widen the public allow-list.

---

## 14B.3 The anonymous access principle

`LIB-14B.2` — Viewing public library information **MUST NOT** require an account,
a session, a phone number, an OTP, or any identifier that could later be linked
to a person.

`LIB-14B.3` — The platform **MUST NOT** require authentication as a precondition
for browsing, and **MUST NOT** present an authentication prompt, modal, interstitial
or paywall before public content is shown.

`LIB-14B.4` — Anonymous browsing **MUST NOT** create an `Account`, a partial
account, a lead record, or any durable record identifying the visitor.

`LIB-14B.5` — The platform **MUST NOT** collect a mobile number "to continue
browsing". A mobile number is the **sole authentication factor** (`MP-GBR-25`);
collecting it is an authentication act, not a browsing convenience.

> **`LIB-14B.5` is the requirement most likely to be eroded under commercial
> pressure.** "Enter your number to see prices" converts well and is precisely
> what §14A.2 exists to prevent — *"Enable students to discover libraries before
> authentication"*, *"Reduce onboarding friction"*. It also collects a credential
> under a false pretext. It is prohibited, not discouraged.

`LIB-14B.6` — An anonymous session identifier **MAY** be used for rate limiting
and abuse prevention. If used it **MUST** be short-lived, **MUST NOT** be
persisted beyond its operational purpose, and **MUST NOT** be joined to an
`Account` if the visitor later authenticates.

---

## 14B.4 What the preview shows

`LIB-14B.7` — The preview **MUST** be able to display every field in the §14A.5
public list, and **MUST NOT** display any field outside it.

| Group | Fields | Owning context |
|---|---|---|
| Identity | Library Name, Library Status | `BC-19` |
| Branding | Logo, Cover Image, Description | `BC-25` |
| Gallery | Images, up to `LCFG-7` | `BC-29` |
| Location | Business Address, Map Location | `BC-19` |
| Hours | Operating Hours, Weekly Holidays, current open/closed | `BC-06` |
| Facilities | Facility list with optional notes | `BC-06` |
| Plans | Membership Plans & Pricing | `BC-02` |
| Seats | **Aggregate** public seat information | `BC-04` |
| Contact | Business Contact Information | `BC-19` |

`LIB-14B.8` — The preview **MUST** be served from a **public read projection**
containing only these fields. A public request **MUST NOT** be able to reach an
operational table by any path (`LIB-19.10`).

`LIB-14B.9` — The projection **MUST** be built from events emitted by the owning
contexts. The preview **MUST NOT** query another context's store directly.

`LIB-14B.10` — Every field in the projection **MUST** be traceable to an owning
context. A field with no owner **MUST NOT** be published.

### 14B.4.1 Public seat information — the boundary

`LIB-14B.11` — Public seat information **MUST** be limited to aggregates:

| Publishable in V1 | **MUST NOT** be public in V1 |
|---|---|
| Total seat capacity | Individual seat identifiers or numbers |
| Capacity per zone kind (e.g. "40 silent, 60 standard") | Which specific seat is free or occupied |
| Whether seats are *generally* available | Live occupancy count or percentage |
| Whether a waitlist is in effect | Who occupies a seat, or when |
| — | Any per-seat status, history or timing |

`LIB-14B.12` — Public seat availability **MUST** be expressed as a coarse
qualitative indicator — for example *Available*, *Limited*, *Full* — and **MUST
NOT** expose a precise free-seat count in V1.

`LIB-14B.13` — Public Live Occupancy is **V2** and **MUST NOT** be implemented in
V1. It requires a completed privacy review (`LIB-24.2`).

`LIB-14B.14` — Public seat information **MUST NOT** be derived from attendance
records, and **MUST NOT** reveal presence, absence or arrival time of any
individual.

> **Why seat information is capped this tightly.** A study hall's regulars sit at
> the same desk daily. A live per-seat map is, in effect, a public attendance
> feed: an observer watching "seat 14 occupied 07:00–14:00 every weekday" learns
> one identifiable person's routine without ever logging in. The commercial need
> is *"do they have room for me?"* — which a coarse indicator answers completely.
> The requirement your §14A.5 stated is *"Seat Capacity (Optional)"*, and that is
> honoured exactly.

### 14B.4.2 Membership plans

`LIB-14B.15` — Plans and pricing **MUST** be read from a `BC-02` projection.
This module **MUST NOT** store or compute a price (`LXC-7`).

`LIB-14B.16` — Only plans the library has marked publicly offered **MUST** be
shown. Internal, legacy, negotiated or discontinued plans **MUST NOT** appear.

`LIB-14B.17` — The preview **MUST NOT** show any student-specific price,
discount, outstanding balance or personalised offer. There is no known visitor.

`LIB-14B.18` — Displayed prices **MUST** be marked as indicative for public
display. Authoritative pricing at purchase is owned by `BC-02` and Finance.

### 14B.4.3 Open / closed status

`LIB-14B.19` — Current open/closed status **MUST** be computed from `BC-06`
operating hours, holidays and emergency closures, in the library's configured
time zone (`LCFG-1`).

`LIB-14B.20` — An active Emergency Closure **MUST** be reflected in public status
within `LCFG-6`.

`LIB-14B.21` — Open/closed status **MUST NOT** be derived from whether anyone is
currently present.

---

## 14B.5 What the preview must never show

`LIB-14B.22` — The following **MUST NOT** be reachable through any public
endpoint, in any form, including aggregated, derived, inferred or error-message
form:

| Never public | Why |
|---|---|
| Student information, names, photos, contact details | `LBR-5`, §14A.5 |
| Member Directory in any form | `LCFG-5`, tenant-private |
| Staff names, roles, phone numbers, counts | §14A.5; enables social engineering |
| Financial data, revenue, collections, dues | `LBR-5` |
| Attendance records or any presence-derived value | `LIB-14B.14` |
| Internal analytics, dashboards, occupancy trends | §14A.5 |
| Security configuration, policies, audit logs | §19 |
| Administrative settings, feature flags | §16 |
| Owner authentication credential | `LIB-6.4`, `MP-GBR-25` |
| Any other tenant's data | `LXC-10`, `X-13` |
| Invitation artefacts for a Private library | `INV-SEC-*` |
| Internal identifiers revealing tenant count or order | `LIB-18.2` |

`LIB-14B.23` — A Private library **MUST NOT** be previewable through the public
preview surface. It is reachable only via a valid invitation artefact
(`LIB-DISC-004`, `LIB-14.5`).

`LIB-14B.24` — A request for a non-existent, Private, Draft, Pending, Suspended or
Archived library **MUST** produce the **same** observable response as a request
for a library that does not exist.

> **`LIB-14B.24` is anti-enumeration, and it is the same principle as `AR-7`.**
> If "not found" and "exists but is private" are distinguishable — by status code,
> message, or response timing — the public endpoint becomes an oracle for
> enumerating every private library on the platform. `AUTH-3.*` already requires
> identical observable behaviour for registered and unregistered phone numbers;
> this applies that established reasoning to libraries.

`LIB-14B.25` — Error responses **MUST NOT** disclose internal identifiers, table
names, query structure, stack traces or configuration values.

---

## 14B.6 The authentication boundary

`LIB-14B.26` — Authentication **MUST** be required only at the moment a
**protected operation** is initiated, and never before.

### 14B.6.1 Protected operations — the closed list

`LIB-14B.27` — The following **MUST** require a valid authenticated session
before execution. The list is **closed**: additions require a PRD revision.

| ID | Protected operation | Owning module |
|---|---|---|
| `PO-1` | **Join Library** | `BC-18` then `BC-02` |
| `PO-2` | **Membership Purchase** | `BC-02` + Finance |
| `PO-3` | **Membership Renewal** | `BC-02` + Finance |
| `PO-4` | **Seat Booking** | `BC-04` |
| `PO-5` | **Attendance** | `BC-03` |
| `PO-6` | **Dashboard** (personal) | Read composition |
| `PO-7` | **AI Services** | `platform/ai` |
| `PO-8` | **Chat** | `BC-15` / Community |
| `PO-9` | **All other member-only features** | Various |
| `PO-10` | Any write to tenant data | Owning context |
| `PO-11` | Any read of personally identifying data | Owning context |
| `PO-12` | Any staff or administrative function | This module + `BC-18` |

`LIB-14B.28` — `PO-9` **MUST** be interpreted as **deny by default**: a feature
not explicitly published as public is protected (`AP-3`, `AUTH-7.6`).

`LIB-14B.29` — Authorisation **MUST** be evaluated **in addition to**
authentication for every protected operation. A valid session is not permission
(`AUTH-7.3`, `LXC-2`).

> **`LIB-14B.29` is the difference between "logged in" and "allowed".** An
> authenticated visitor with no role in a library may attempt `PO-4` Seat Booking.
> Authentication succeeds; authorisation must still refuse. Conflating the two is
> how a member of library A books a seat in library B.

### 14B.6.2 What the preview must not do at the boundary

`LIB-14B.30` — This module **MUST NOT** verify an OTP, issue a session, refresh a
session, validate a token, or evaluate a permission. It **MUST** delegate to
`BC-18` (`LXC-1`, `LXC-2`, §14A.8).

`LIB-14B.31` — This module **MUST NOT** implement its own "is the user logged in"
check beyond asking `BC-18`, and **MUST NOT** cache an authorisation decision
across requests (`MP-GBR-26`).

`LIB-14B.32` — The preview **MUST NOT** pre-create an account, reserve a phone
number, or begin registration in anticipation of a join.

---

## 14B.7 Intent preservation

`LIB-DISC-012` requires that *"the platform shall preserve the user's intended
action after successful authentication."* This section specifies it.

`LIB-14B.33` — When an anonymous visitor initiates a protected operation, the
platform **MUST** record the intended action and its context, route the visitor to
the `BC-18` authentication flow, and **on success resume the original action**.

`LIB-14B.34` — Preserved intent **MUST** carry only what is needed to resume:
the action, the target library identifier, and any selection the visitor already
made. It **MUST NOT** carry a credential.

`LIB-14B.35` — Preserved intent **MUST** expire after `LCFG-11` and **MUST NOT**
be resumable after expiry.

`LIB-14B.36` — Resumption **MUST** re-evaluate authorisation at the moment of
resumption. Intent recorded before authentication **MUST NOT** be treated as
pre-authorised.

`LIB-14B.37` — Preserved intent **MUST NOT** be usable to perform an action on a
library other than the one it named.

`LIB-14B.38` — If the library's state changed during authentication — suspended,
made Private, plan withdrawn, capacity exhausted — resumption **MUST** re-validate
and **MUST** fail cleanly with an explanation rather than proceeding on stale
state.

`LIB-14B.39` — Intent **MUST NOT** be preserved across different accounts. If a
different account authenticates than the one that began the flow, intent from the
first **MUST** be discarded.

> **`LIB-14B.36` and `LIB-14B.39` close two real holes.** Without `LIB-14B.36`,
> "book seat 12" recorded pre-authentication becomes a capability that skips the
> permission check — a privilege escalation reachable by any anonymous visitor.
> Without `LIB-14B.39`, handing a device to a friend who logs in with their own
> number silently executes your intent under their identity.

### 14B.7.1 Flow

```
Anonymous visitor
      │
      ├──► Browse / search public libraries        no authentication
      ├──► View public preview (§14B.4)            no authentication
      ├──► Compare plans across libraries          no authentication
      │
      └──► Initiate protected operation (PO-1..PO-12)
                 │
                 ├─ record intent (LIB-14B.33), TTL = LCFG-11
                 │
                 ▼
           BC-18 Authentication
                 │  stage 1: identify account  (ADR-0004)
                 │  stage 2: issue session bound to one library
                 ▼
           BC-18 Authorization — evaluate NOW (LIB-14B.36)
                 │
                 ├─ refused ──► explain; intent discarded
                 │
                 ▼
           Re-validate library state (LIB-14B.38)
                 │
                 ▼
           Resume original action in its owning module
```

`LIB-14B.40` — The two-stage sequence **MUST** follow `ADR-0004`. This module
**MUST NOT** assume a session exists merely because an account was identified.

---

## 14B.8 Anonymous traffic protection

Public endpoints are the platform's only unauthenticated attack surface.

`LIB-14B.41` — Public endpoints **MUST** be rate limited per origin using
`CFG-3`. The limit **MUST** account for shared NAT, since many students share one
gateway.

`LIB-14B.42` — Rate limiting **MUST NOT** be implemented by identifying the
visitor. It operates on request origin characteristics, not identity
(`LIB-14B.4`).

`LIB-14B.43` — Public search **MUST NOT** permit an unbounded result set. Results
**MUST** be paginated with a maximum page size (`LCFG-12`).

`LIB-14B.44` — Public endpoints **MUST NOT** accept a caller-supplied field list,
sort expression, filter expression or query fragment that could widen the
projection.

`LIB-14B.45` — A public request **MUST NOT** be able to cause a tenant-scoped
operational query (`LIB-20.2`).

`LIB-14B.46` — Exhaustive enumeration of the public directory **MUST** be
rate-limited and **MUST** be observable to platform operators.

`LIB-14B.47` — Public endpoints **MUST NOT** log the visitor's IP address joined
to a library view in a form retained beyond the operational window required for
abuse prevention.

> **`LIB-14B.44` prevents the classic public-API leak.** A `?fields=` or
> `?include=` parameter that reaches an ORM turns a read-only public endpoint into
> a query interface over whatever the ORM can reach. The projection is fixed
> server-side.
>
> **`LIB-14B.47` matters because the visitor is a prospective student.** "This IP
> viewed these three libraries" is a behavioural profile of someone who has not
> consented to anything and may never join.

---

## 14B.9 Configurable values

| ID | Setting | Default | Range | Rationale |
|---|---|---|---|---|
| `LCFG-11` | Preserved intent TTL | **30 min** | 5–120 min | Comfortably exceeds an OTP round trip (`CFG-2` × `CFG-1`) while limiting the window in which a stale intent can be resumed |
| `LCFG-12` | Public search page size | **20** | 5–50 | Bounds enumeration rate and page weight |
| `LCFG-13` | Public preview cache TTL | **300 s** | 0–3600 s | Absorbs anonymous load. **MUST NOT** apply to any authorization decision (`LIB-16.9`) |

`LIB-14B.48` — `LCFG-11` **MUST NOT** exceed the absolute session lifetime
(`CFG-6`), because intent must not outlive the session that would resume it.

`LIB-14B.49` — `LCFG-13` **MUST NOT** be applied to visibility, suspension,
authorisation or membership state. A suspended or newly-Private library **MUST**
leave public view within `LCFG-6` regardless of cache TTL (`MP-GBR-26`).

`LIB-14B.50` — These values **MUST** be validated at startup alongside
`INV-1`…`INV-9` (`IMPL-015`).

| ID | Invariant |
|---|---|
| `INV-10` | `LCFG-11` ≤ `CFG-6` (mobile absolute session lifetime) |
| `INV-11` | `LCFG-11` > `CFG-2` × `CFG-1` — intent outlives a full OTP retry cycle |
| `INV-12` | `LCFG-13` ≤ 3600 s, and never consulted for authorization state |

---

## 14B.10 Business rules

| ID | Rule |
|---|---|
| `LIB-PREV-001` | Public library information is viewable without authentication |
| `LIB-PREV-002` | The preview exposes exactly the §14A.5 allow-list and nothing else |
| `LIB-PREV-003` | Anonymous browsing creates no durable record identifying the visitor |
| `LIB-PREV-004` | A mobile number is never collected as a condition of browsing |
| `LIB-PREV-005` | Authentication is required only at a protected operation `PO-1`…`PO-12` |
| `LIB-PREV-006` | Authorisation is evaluated in addition to authentication, at execution time |
| `LIB-PREV-007` | Intended action is preserved across authentication and resumed on success |
| `LIB-PREV-008` | Preserved intent confers no permission and is re-authorised at resumption |
| `LIB-PREV-009` | Private, Draft, Pending, Suspended, Archived and non-existent libraries are publicly indistinguishable |
| `LIB-PREV-010` | Public seat information is aggregate only; live occupancy is V2 |
| `LIB-PREV-011` | The preview is served from a projection, never from an operational table |
| `LIB-PREV-012` | Public endpoints are rate limited without identifying the visitor |
| `LIB-PREV-013` | This module performs no authentication, session or permission logic |

---

## 14B.11 Acceptance criteria

| ID | Passes when | Fails when |
|---|---|---|
| `LAC-14B-1` | A visitor with no account browses search, profile, gallery, facilities, hours and plans end to end | Any public view demands a session |
| `LAC-14B-2` | The public response body contains exactly the §14A.5 fields | Any additional field is present in the payload, including unrendered |
| `LAC-14B-3` | No durable record identifying the visitor exists after anonymous browsing | A lead, partial account or retained IP-to-library join is created |
| `LAC-14B-4` | No public flow requests a mobile number | A number is requested to view content |
| `LAC-14B-5` | Each of `PO-1`…`PO-12` triggers authentication when attempted anonymously | Any protected operation proceeds without a session |
| `LAC-14B-6` | An authenticated account with no role in a library is **refused** `PO-4` | A valid session alone permits the action |
| `LAC-14B-7` | Intent is resumed after authentication with selections intact | The visitor lands on a home screen and must start again |
| `LAC-14B-8` | Intent expires after `LCFG-11` and is then unusable | An expired intent resumes |
| `LAC-14B-9` | Intent recorded before authentication is re-authorised at resumption | Resumption skips the permission check |
| `LAC-14B-10` | Private, Suspended and non-existent libraries return identical observable responses, including timing class | Responses are distinguishable by code, message or latency |
| `LAC-14B-11` | Public seat information is aggregate only; no per-seat state is reachable | A per-seat identifier or status appears in any public payload |
| `LAC-14B-12` | A Public→Private change removes the library from public view within `LCFG-6` | The library remains previewable after the change |
| `LAC-14B-13` | A suspended library disappears from public view immediately, irrespective of `LCFG-13` | A cached preview outlives suspension |
| `LAC-14B-14` | Public endpoints refuse a caller-supplied field, filter or sort expression | Any such parameter alters the projection |
| `LAC-14B-15` | Public rate limiting is effective under shared NAT without blocking legitimate students | Limits are per-identity, or a shared gateway is blocked at normal load |
| `LAC-14B-16` | Intent begun anonymously is discarded if a different account authenticates | Intent executes under an unrelated account |

---

## 14B.12 Integrations

| Integration | Context | Mechanism |
|---|---|---|
| Public projection source | `BC-19`, `BC-25`, `BC-29`, `BC-06`, `BC-02`, `BC-04` | Events → read projection |
| Discovery index | `BC-23` Search Indexing | Public projection only (`AR-3`) |
| Authentication | `BC-18` | Delegation at the boundary |
| Authorization | `BC-18` | Policy decision per protected operation |
| Map & geocoding | `BC-31` | Port; vendor owned by `BC-31` (`LIB-6.5`) |
| Notification | `BC-22` | Event emission only; never called directly (`X-04`) |

`LIB-14B.51` — The public projection **MUST** be part of the **Platform Public
Discovery Index** class (`AR-3`), which indexes the tenant organisation itself and
**MUST NOT** contain tenant operational data. `MP-GBR-08`, `SE-1` and `X-13`
remain in force, unmodified, for all tenant operational data.

---

## 14B.13 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-03 | Created. Specifies anonymous public preview, the closed protected-operation list `PO-1`…`PO-12`, intent preservation, public seat aggregation limits, anonymous-traffic protection, `LCFG-11`…`LCFG-13`, invariants `INV-10`…`INV-12`, 13 business rules and 16 acceptance criteria. Adds **no** public field beyond §14A.5. |
