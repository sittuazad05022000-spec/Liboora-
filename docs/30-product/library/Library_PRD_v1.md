# Library PRD — Organization & Library Management

| Field | Value |
|---|---|
| **Version** | v1.0 (Startup MVP) |
| **Module** | Library Management |
| **Status** | **Approved — authoritative** |
| **Baseline** | `BASELINE-2026-08-03` |
| **Precedence** | Rank 3 — a module PRD. Outranked by `MASTER_PRD.md` global rules and accepted ADRs |
| **Owning contexts** | `BC-19` Tenancy · `BC-06` Library Policy · `BC-25` Configuration · `BC-29` File & Media |
| **Supersedes** | Nothing. This is the first complete receipt of §§1–25 |

---

## 0. How to read this document

### 0.1 Normative language

| Word | Meaning |
|---|---|
| **MUST** / **MUST NOT** | Absolute requirement. A violation is a defect |
| **SHOULD** / **SHOULD NOT** | Strong recommendation. Departing requires a recorded reason |
| **MAY** | Genuinely optional |

Anything not stated with one of these words is context, not requirement.

### 0.2 Identifier scheme

| Prefix | Meaning | Example |
|---|---|---|
| `LIB-n.m` | Requirement, chapter `n`, sequence `m` | `LIB-6.3` |
| `LBR-n` | Business rule | `LBR-4` |
| `LXC-n` | Explicit exclusion — a thing this module **MUST NOT** do | `LXC-2` |
| `LAC-n` | Acceptance criterion | `LAC-7` |
| `LCFG-n` | Configurable value | `LCFG-2` |
| `LEV-n` | Domain event emitted by this module | `LEV-5` |
| `LIB-DISC-n` | Discovery business rule — **inherited verbatim from §14A** | `LIB-DISC-004` |

Identifiers are permanent. A withdrawn requirement is marked withdrawn; its number is never reused.

### 0.3 What this document does not decide

This module configures a library. It does **not** own students, memberships,
attendance, seats, money, credentials or permissions. Where a requirement here
appears to touch one of those, it is a **reference** to the owning module's data,
never a copy of it. §26 states the ownership boundary in enforceable terms.

### 0.4 A note on the two meanings of "Library"

The word is ambiguous in this problem domain, and the ambiguity is resolved by
Bounded Context Map §5:

| Term | Context | Meaning |
|---|---|---|
| **`TenantOrganisation`** | `BC-19` | The business entity. The billing subject. The unit of tenant isolation |
| **`Branch`** | `BC-06` | A physical location with an address, floors, zones, seats and operating hours |

In V1 every `TenantOrganisation` has **exactly one** `Branch`. They are
nonetheless separate entities from the first migration, because retrofitting
`branchId` later is a migration across every tenant-scoped table (Context Map
`Q-02`). Where this document says "library" without qualification it means the
`TenantOrganisation`.

---

## 1. Purpose

The Library Management module is the authoritative source for managing a
library's identity, configuration, operational settings, branches,
infrastructure, branding, and staff. It establishes the organizational
foundation upon which all operational modules (Membership, Students, Seats,
Attendance, Finance, Dashboards, etc.) operate.

**This module manages the library, not the students or members.**

`LIB-1.1` — This module **MUST** be the single authoritative source for library
identity, profile, branding, configuration, branch structure, operating hours and
staff assignment.

`LIB-1.2` — No other module **MAY** store a second copy of the data this module
owns. Dependent modules **MUST** reference the library by identifier and read
through a published projection.

> **Why this is stated as a prohibition rather than a preference.** Duplicated
> library data is the most common cause of "the app shows two different opening
> times". Once two copies exist, one of them is wrong and nobody can tell which.

---

## 2. Objectives

- Create and manage library organizations.
- Support future multi-branch expansion.
- Configure operational settings without code changes.
- Centralize library policies and configuration.
- Enable secure multi-tenant isolation.
- Provide a stable foundation for all dependent modules.

`LIB-2.1` — Operational settings **MUST** be changeable by an authorised library
role at runtime, without a code change, a deployment or a database migration.

`LIB-2.2` — The V1 data model **MUST** carry `branchId` on every branch-scoped
record even though V1 permits exactly one branch, so that multi-branch does not
require a retrospective migration.

---

## 3. Scope

### In Scope

Library identity · Library profile · Library lifecycle · Branding · Library
configuration · Branch management · Floor management · Zone management ·
Operating hours · Holiday management · Staff management · Library settings ·
Business policies · Facilities · Visibility settings

### Out of Scope

Handled by other PRDs: Authentication · Student Identity · Student Management ·
Library Member Directory · Membership Management · Seat Management · Attendance ·
Revenue & Finance · Notifications · Analytics

### 3.1 Explicit exclusions

These are stated as prohibitions because "out of scope" is too easily read as
"not yet built here".

| ID | This module **MUST NOT** | Owner | Enforced by |
|---|---|---|---|
| `LXC-1` | Verify an OTP, issue a session, or create an `Account` | `BC-18` | `AUTH-3.*`, `ADR-0004` |
| `LXC-2` | Decide whether a caller may perform an action | `BC-18` Authorization | `AUTH-7.3` |
| `LXC-3` | Create, price, renew or validate a membership | `BC-02` | Membership PRD |
| `LXC-4` | Create or hold a student profile record | `BC-01` / `BC-10` | Student Identity PRD |
| `LXC-5` | Record attendance or compute presence | `BC-03` | Attendance PRD |
| `LXC-6` | Assign, transfer or release a seat | `BC-04` | Seat PRD |
| `LXC-7` | Hold money, price anything, or issue a receipt | `BC-11`…`BC-13` | Finance PRD |
| `LXC-8` | Send an SMS, email or push notification directly | `BC-22` | `X-04`, `banned_imports` |
| `LXC-9` | Import, name or otherwise know a map, SMS or storage vendor | `BC-31` | `X-03`, `banned_imports` |
| `LXC-10` | Read or expose any other tenant's data for any reason | — | `MP-GBR-08`, `SE-1`, `X-13` |

> **`LXC-8` and `LXC-9` are compile-time enforceable.** `tool/module_dependencies.yaml`
> already bans `platform/communication/**` and `platform/integration/**` from
> `domain/library`. Implementation task `IMPL-014` makes the check executable.

---

## 4. Actors

| PRD term | Authoritative role | Scope | Source |
|---|---|---|---|
| Platform Owner | **Platform Administrator** | Platform-wide, platform objects only | `AUTH-7.12`, `AUTH-7.13` |
| Library Owner | **`TR-1` Owner** | Exactly one library | `AUTH-7.14` |
| Library Manager | **`TR-2` Manager** | Exactly one library | `AUTH-7.14` |
| Reception Staff | **`TR-3` Reception** | Exactly one library | `AUTH-7.14` |

`LIB-4.1` — This module **MUST** use the role names `TR-1` Owner, `TR-2` Manager,
`TR-3` Reception and Platform Administrator. It **MUST NOT** introduce a role
name of its own.

`LIB-4.2` — A Platform Administrator **MUST NOT** be granted any permission over
tenant business data by virtue of that role. Access to a specific library's
operational data requires an explicit, audited, time-bounded elevation
(`AUTH-7.13`, `AUTH-7.16`, `CFG-12`).

> **Naming was corrected, not changed.** "Platform Owner" and "Library Owner"
> were the §4 wording. The Authentication PRD's closed role set is
> `TR-1`…`TR-5` plus Platform Administrator, and `AUTH-7.21` states no other
> role exists. Two vocabularies for one role is how permission bugs are written,
> so this document adopts the authoritative names. **No actor was added or
> removed.**

`TR-4` Student and `TR-5` Parent hold no permission in this module. They appear
here only as consumers of the public profile (§7, §14, §14A).

---

## 5. Core Entities

| Entity | Owning context | Notes |
|---|---|---|
| **`TenantOrganisation`** | `BC-19` | The library as a business and billing entity |
| **`Branch`** | `BC-06` | A physical location. Exactly one in V1 |
| **`Floor`** | `BC-06` | Belongs to exactly one `Branch` |
| **`Zone`** | `BC-06` | Belongs to exactly one `Floor` |
| **`Holiday`** | `BC-06` | Branch-scoped calendar exception |
| **`OperatingHours`** | `BC-06` | Weekly schedule, branch-scoped |
| **`StaffAssignment`** | `BC-19` + `BC-18` | **Split.** The assignment record is tenant data; the *role grant* is `BC-18` |
| **`LibrarySettings`** | `BC-25` | Settings hierarchy and feature flags |
| **`BusinessPolicy`** | `BC-06` | Operating rules. The rule **source** |
| **`LibraryBranding`** | `BC-25` + `BC-29` | **Split.** Values in `BC-25`; image binaries in `BC-29` |

`LIB-5.1` — `Staff` **MUST NOT** be modelled as an independent identity. A staff
member is an `Account` (`BC-18`) holding a library role (`TR-1`…`TR-3`) in this
tenant. This module stores the **assignment and its lifecycle**, never a
credential.

> **Why the entity list is annotated rather than reproduced flat.** The §5 list
> named ten entities without owners. Four of them span two contexts. An
> implementer given the flat list would have created a `Staff` table with a phone
> number in it — a second credential store, violating `BC-18`'s ownership of
> *"credentials, sessions, devices, OTP"*. Nothing was removed; ownership was
> made explicit.

---

## 6. Library Profile

### Required

| Field | Owner | Validation |
|---|---|---|
| Library Name | `BC-19` | Non-empty after trimming; 2–120 characters |
| Owner Name | `BC-19` | Non-empty. The `displayName` of the owning `Account` (`AR-5`) |
| Mobile Number | `BC-19` | The **business contact number**. See `LIB-6.4` |
| Address | `BC-19` | Non-empty |
| City | `BC-19` | Non-empty |
| State | `BC-19` | Non-empty; from a controlled list |
| PIN Code | `BC-19` | Exactly 6 digits |

### Optional

Logo · Cover Image · Description · Email · Website · Map Location ·
Social Links

`LIB-6.1` — Every required field **MUST** be non-empty after whitespace
trimming. A string of spaces **MUST NOT** satisfy a required field.

`LIB-6.2` — Required fields **MUST** be validated on create **and** on every
update. A library **MUST NOT** be able to reach a state where a required field
is empty.

`LIB-6.3` — Optional fields **MUST** be genuinely optional: absence **MUST NOT**
block activation, discovery or any operational function.

`LIB-6.4` — The business Mobile Number **MUST** be stored as library profile data
and **MUST NOT** be read from, written to, or inferred from the owner's
authentication credential. The two values **MAY** be identical at some moment in
time; they are **different fields with different lifecycles and different
visibility**.

> **This is the most consequential correction in this chapter.** §14A.10 already
> requires that *"Business Contact Information shall be separate from the Library
> Owner's authentication credentials."* If the profile were to read the owner's
> login number, then publishing the public profile (§7) would publish an
> authentication identifier — and `MP-GBR-25` makes the mobile number the **sole
> authentication factor**. Publishing it would put half of every owner's
> credential on a public page. The fields are therefore separate by requirement,
> not by convention.

`LIB-6.5` — Map Location **MUST** be stored as geocoded coordinates plus an
optional free-text locality. It **MUST NOT** be stored as a vendor-specific URL,
place identifier or embed code.

> **Corrects review finding `CC-6`.** The §6 wording was *"Google Maps
> Location"*. `X-03` forbids vendor knowledge inside `domain/library`, and
> `banned_imports` blocks `platform/integration/**`. Naming a vendor in the
> domain makes swapping providers a domain change. Geocoding and rendering are
> reached through a port; the vendor contract belongs to `BC-31` Integration.
> **The capability is unchanged** — the library still has a map location.

`LIB-6.6` — Logo and Cover Image **MUST** be stored through `BC-29` File & Media
and referenced by identifier. This module **MUST NOT** store image binaries, and
**MUST NOT** construct a storage URL itself.

---

## 7. Library Information

The public profile may display: Library Name · Logo · Gallery · Description ·
Opening Hours · Weekly Holidays · Available Facilities · Seat Capacity ·
Library Status

**Sensitive operational and financial information must never appear publicly.**

`LIB-7.1` — The set of publicly visible fields is defined **once**, in §14A.5,
and this chapter **MUST NOT** be read as a second, competing list.

> **Why the two lists were reconciled rather than both kept.** §7 named nine
> public fields. §14A.5 named fourteen, adding Cover Image, Business Address, Map
> Location, Membership Plans & Pricing and Business Contact Information. Two
> public-visibility lists in one PRD is a security defect waiting to happen: an
> implementer who trusts §7 omits membership plans and breaks discovery; one who
> trusts §14A.5 publishes a field §7 never authorised. §14A.5 is the superset and
> is the more recently reviewed text, so it governs. **Nothing was removed from
> either list.**

`LIB-7.2` — A field **MUST NOT** be publicly visible unless it appears in the
§14A.5 public list. Public visibility is **allow-list only**; a new field is
private until explicitly published.

`LIB-7.3` — Seat Capacity, when published, **MUST** be an aggregate count.
Per-seat identity, per-seat status and live occupancy **MUST NOT** be public in
V1. (Public Live Occupancy is V2 — §24.)

`LIB-7.4` — Adding a field to the public list **MUST** be a reviewed change
recorded in this document's change history, never a configuration toggle.

---

## 8. Library Lifecycle

`Create` → `Verify` → `Configure` → `Activate` → `Suspend` → `Archive` → `Restore`

**Permanent deletion is outside MVP.**

### 8.1 States

| State | Meaning | Publicly discoverable? | Operational? |
|---|---|---|---|
| **Draft** | Created; required profile incomplete | ❌ Never | ❌ |
| **Pending Verification** | Profile complete; awaiting verification | ❌ Never | ❌ |
| **Verified** | Verified; not yet configured or activated | ❌ Never | ❌ |
| **Active** | Operating normally | ✅ If visibility is Public | ✅ |
| **Suspended** | Operations halted | ❌ Never | ❌ |
| **Archived** | Withdrawn from service; data retained | ❌ Never | ❌ |

`LIB-8.1` — A library **MUST NOT** be publicly discoverable in any state other
than **Active** (`LIB-DISC-002`).

`LIB-8.2` — A **Suspended** library **MUST NOT** perform any operational
activity: no attendance, no seat assignment, no membership sale, no renewal
(`LBR-7`).

`LIB-8.3` — Suspension **MUST** take effect immediately and globally, with no
propagation window (`MP-GBR-26`). A cached authorisation decision **MUST NOT**
permit an operation in a library suspended a moment earlier.

`LIB-8.4` — Suspension **MUST NOT** delete, alter or invalidate any business
record. It halts activity; it does not erase history.

`LIB-8.5` — `Archive` **MUST** be reversible via `Restore`. `Restore` **MUST**
return the library to **Suspended**, never directly to **Active**, so that
reactivation is always a deliberate, separately audited act.

`LIB-8.6` — Every lifecycle transition **MUST** be audit logged with actor,
timestamp, prior state, new state and reason (§19).

`LIB-8.7` — Only `TR-1` Owner or a Platform Administrator **MAY** initiate
`Suspend`, `Archive` or `Restore`.

### 8.2 Deletion — scope boundary

`LIB-8.8` — Permanent deletion of a library is **out of V1 scope**. `Archive` is
the terminal state.

`LIB-8.9` — Archiving a library **MUST NOT** be interpreted as satisfying any
personal-data erasure obligation, and **MUST NOT** delete or anonymise any
`Account`.

`LIB-8.10` — When an `Account` is erased under `AUTH-9.46`…`AUTH-9.60`, this
module **MUST** remove that account's staff assignments and **MUST** retain the
library's own business records. Records surviving erasure **MUST NOT** be capable
of reconstituting the erased identity (`AUTH-9.59`).

`LIB-8.11` — A library **MUST NOT** be left with zero accounts holding `TR-1`
Owner. If the only Owner's account is erased or removed, the transition **MUST**
be refused until another Owner is assigned (`LBR-2`, `LIB-15.9`).

> **Why deletion needed three requirements instead of one line.** "Permanent
> deletion is outside MVP" is correct for the *library*, but the Authentication
> PRD carries a binding personal-data erasure obligation for *accounts*, and
> `AUTH-9.58` states deletion **must not** delete business records owned by other
> contexts. Without `LIB-8.10` an implementer faces two documents pulling in
> opposite directions the first time a staff member asks to be deleted. Without
> `LIB-8.11` that erasure can orphan a library with no owner.

---

## 9. Branch Management

### V1

- **Single Branch**

### Architecture Ready

- Multi Branch · Branch Status · Default Branch · Branch Archive

`LIB-9.1` — A V1 library **MUST** have exactly one `Branch`. Creating a second
**MUST** be refused.

`LIB-9.2` — Every branch-scoped record **MUST** carry `branchId` from the first
migration, populated with the single branch, even though only one exists
(`LIB-2.2`, Context Map `Q-02`).

`LIB-9.3` — Every branch-scoped record **MUST** also carry the tenant key
(`MP-GBR-08`). `branchId` is **not** a substitute for tenant scoping.

`LIB-9.4` — Multi-branch operation is tiered **V3**, not V2.

> **Corrects a roadmap conflict.** §9 said *"Architecture Ready"* and §24 listed
> Multi-Branch under *"Future Scope (V2+)"*. Master PRD §32 places Multi-Branch
> in **V3** — *"Enterprise: pass procurement, security review, compliance"*.
> `V2+` is not wrong so much as unusably vague; a team reading it plans
> multi-branch for the next release and discovers the enterprise tier's tenancy
> work is not funded. The authoritative tier governs. **No capability changed** —
> the schema is still branch-ready in V1.

`LIB-9.5` — Because exactly one branch exists in V1, **Default Branch** is that
branch. No selection UI is required, and none **MAY** be built in V1.

---

## 10. Floor Management

Multiple Floors · Floor Names · Floor Numbers · Floor Capacity · Floor Status

`LIB-10.1` — A `Branch` **MAY** have one or more `Floor` records. At least one
**MUST** exist before seats can be configured.

`LIB-10.2` — Floor Number **MUST** be unique within a branch.

`LIB-10.3` — Floor Name **MUST** be non-empty and **MUST NOT** be required to be
unique. ("Ground Floor" in two branches is legitimate.)

`LIB-10.4` — Floor Capacity **MUST** be a declared planning figure owned by this
module. It **MUST NOT** be treated as seat inventory, which is owned by `BC-04`
Seating.

`LIB-10.5` — Where declared Floor Capacity and the seat count configured in
`BC-04` disagree, `BC-04` **MUST** be treated as authoritative for operations,
and the discrepancy **MUST** be surfaced to the Owner rather than silently
reconciled.

`LIB-10.6` — Setting a floor to an inactive status **MUST NOT** delete seats,
attendance history or assignments. It **MUST** prevent new assignment on that
floor.

> **`LIB-10.4` and `LIB-10.5` exist because "Floor Capacity" is genuinely
> ambiguous.** It can mean "this floor was designed for 40 people" or "there are
> 40 seats on this floor". The first is a library property; the second is seat
> inventory belonging to `BC-04`. Left undecided, the number gets written twice
> and drifts. The planning figure stays here; operations trust `BC-04`.

---

## 11. Zone Management

### Supported Zones

Silent Zone · Standard Zone · Premium Zone · Custom Zones

`LIB-11.1` — A `Zone` **MUST** belong to exactly one `Floor`.

`LIB-11.2` — The four zone kinds **MUST** be modelled as data, not as code
branches. Adding a custom zone **MUST NOT** require a code change or a migration.

`LIB-11.3` — A zone **MAY** carry attributes that other modules read — for
example a premium indicator. Those attributes are **descriptive** and this module
**MUST NOT** attach pricing to them.

`LIB-11.4` — Pricing that varies by zone is a **membership plan** concern owned
by `BC-02`. A plan **MAY** reference a zone by identifier.

`LIB-11.5` — Whether a seat in a zone may be assigned to a given student is
decided by `BC-04` Seating using rules from `BC-06`. This module **MUST NOT**
implement assignment logic (`LXC-6`).

> **"Premium Zone" is where a scope leak would begin.** The natural next thought
> is a price on the zone. That would put money in `domain/library`, which
> `LXC-7` forbids and which would give the platform two places where a price
> lives. The zone stays descriptive; the plan carries the price.

---

## 12. Operating Hours

Opening Time · Closing Time · Weekly Schedule · Holiday Schedule ·
Emergency Closure

`LIB-12.1` — `BC-06` Library Policy **MUST** be the sole source of operating
hours, holidays and closures. Attendance, Seating and Discovery are **consumers**
(`E-04`, `E-05`).

`LIB-12.2` — A weekly schedule **MUST** be expressible per day of week, and
**MUST** permit a day to be closed.

`LIB-12.3` — A schedule **MUST** permit a closing time earlier in clock terms
than its opening time, representing a session crossing midnight.

`LIB-12.4` — All times **MUST** be stored with an explicit time zone (`LCFG-1`)
and **MUST NOT** rely on server local time.

`LIB-12.5` — A `Holiday` **MUST** override the weekly schedule for its date.

`LIB-12.6` — **Emergency Closure** **MUST** take effect immediately, **MUST**
carry a reason, and **MUST** be audit logged.

`LIB-12.7` — Emergency Closure **MUST NOT** cancel, delete or invalidate any
existing membership, attendance record or seat assignment. Its effect is on
**new** operations.

`LIB-12.8` — Changing operating hours **MUST NOT** retroactively alter already
recorded attendance. Attendance is evaluated against the rules in force at the
moment it was recorded.

> **`LIB-12.8` prevents a whole class of support incident.** Without it, a
> library correcting last month's opening time silently reclassifies a month of
> attendance as late. Rules apply forward.

---

## 13. Facilities

Air Conditioning · Wi-Fi · CCTV · Drinking Water · Washroom · Parking ·
Power Backup · Silent Zone · Charging Points · Locker (Optional)

**The platform must support future facility expansion without database redesign.**

`LIB-13.1` — Facilities **MUST** be modelled as a reference list of facility
definitions plus a per-branch association. They **MUST NOT** be modelled as one
boolean column per facility.

`LIB-13.2` — Adding a facility **MUST** require only a new row in the reference
list — no migration, no schema change, no code change, no deployment.

`LIB-13.3` — The ten named facilities **MUST** be seeded as the initial reference
list.

`LIB-13.4` — A facility association **MAY** carry an optional free-text note.

`LIB-13.5` — Facility data **MUST** be publicly visible for an Active, Public
library (§14A.5).

`LIB-13.6` — "Silent Zone" appears in both the facility list and §11 zone kinds.
The **facility** flag advertises that a silent area exists. The **zone** is the
addressable area. They **MUST NOT** be derived from one another, and the
implementation **MUST NOT** assume that setting one sets the other.

> **§13's stated requirement — expansion "without database redesign" — is
> unachievable with a boolean-per-facility schema**, which is the shape most teams
> reach for first. `LIB-13.1` names the mechanism that satisfies the requirement.
> The requirement is the product owner's; only the mechanism is added.
>
> **`LIB-13.6` resolves a real trap.** Nothing in §11 or §13 says whether these
> are the same fact. If an implementer guesses "yes", a library that advertises a
> silent area is forced to have a silent zone, and removing the zone silently
> removes the advertisement.

---

## 14. Library Visibility

### Public

Searchable · Viewable profile

### Private

Invite only · Direct link only

**Visibility must be configurable by the owner.**

`LIB-14.1` — Every library **MUST** have exactly one visibility mode:
**Public** or **Private** (`LIB-DISC-001`).

`LIB-14.2` — Visibility **MUST** default to **Private** on creation. A library
becomes public only by explicit act.

`LIB-14.3` — Only `TR-1` Owner **MAY** change visibility. The change **MUST** be
audit logged.

`LIB-14.4` — A **Private** library **MUST NOT** appear in search results,
nearby discovery, or any public listing (`LIB-DISC-004`).

`LIB-14.5` — A **Private** library **MUST** be reachable only through a valid
invitation artefact — Invitation Link, QR Code or Invitation Code — governed by
`INVITATION_SECURITY_SPECIFICATION.md`.

`LIB-14.6` — Changing visibility from Public to Private **MUST** remove the
library from the public discovery index within `LCFG-6`, and **MUST NOT** affect
any existing membership.

`LIB-14.7` — Visibility **MUST NOT** be the mechanism that protects confidential
data. Private data is protected by §19 and `LXC-10` in **both** modes. A Public
library exposes exactly the §14A.5 allow-list and nothing more.

> **`LIB-14.2` is a deliberate departure from the literal §14 text**, which does
> not state a default. Defaulting to Public would mean a half-configured library
> with a placeholder name is discoverable the moment it is created. `AP-3` Deny by
> default (`AUTH-7.6`) is the platform's established posture. Note that
> `LIB-8.1` independently prevents discovery before Active, so this is
> defence in depth rather than the only guard.
>
> **`LIB-14.7` states something the original §14 left dangerously implicit.**
> Reading §14 alone invites the conclusion that Private mode is a security
> control. It is a *discoverability* control. If confidentiality depended on it,
> every Public library would be exposed.

---

## 15. Staff Management

### Supported Roles

Owner · Manager · Reception Staff

### Functions

Invite Staff · Remove Staff · Activate · Suspend · Assign Roles ·
Branch Assignment

**Role permissions are governed by the Authorization PRD.**

`LIB-15.1` — A staff member **MUST** be an `Account` (`BC-18`) holding a library
role in this tenant. This module **MUST NOT** create an identity, store a
credential, or hold a password or OTP (`LXC-1`, `LIB-5.1`).

`LIB-15.2` — Staff invitation **MUST** be performed through the invitation
mechanism specified in `INVITATION_SECURITY_SPECIFICATION.md`.

`LIB-15.3` — "Assign Roles" **MUST** mean requesting a role grant from `BC-18`.
This module **MUST NOT** decide, store or evaluate permissions (`LXC-2`,
`AUTH-7.3`).

`LIB-15.4` — Only the three library roles `TR-1` Owner, `TR-2` Manager, `TR-3`
Reception **MAY** be assigned by this module. `TR-4` Student and `TR-5` Parent
**MUST NOT** be assignable as staff.

`LIB-15.5` — Removing a staff member **MUST** revoke the role grant immediately
and globally, with no propagation window (`MP-GBR-26`).

`LIB-15.6` — Suspending a staff member **MUST** have the same immediate effect on
authorisation as removal, while retaining the assignment record for later
reactivation.

`LIB-15.7` — Revocation **MUST** invalidate that account's active sessions **for
this library**, and **MUST NOT** affect its sessions or roles in any other
library (`AUTH-7.14`).

`LIB-15.8` — An account **MUST NOT** be able to grant itself a role, approve its
own elevation, or remove the last remaining Owner (`AP-5`, `AUTH-7.8`).

`LIB-15.9` — A library **MUST** have at least one account holding `TR-1` Owner at
all times. An operation that would leave zero Owners **MUST** be refused
(`LBR-2`, `LIB-8.11`).

`LIB-15.10` — Branch Assignment **MUST** be recorded even in V1, where it always
resolves to the single branch (`LIB-2.2`).

`LIB-15.11` — Every staff assignment change **MUST** be audit logged with actor,
subject, prior role, new role, timestamp and reason.

### 15.1 On "only the Owner may perform critical operations"

`LIB-15.12` — Where §19 reserves an operation to the Owner, that **MUST** be
implemented as an authorization policy evaluated by `BC-18`, never as a role-name
comparison in this module's code (`AUTH-7.4`, `AP-4`).

`LIB-15.13` — A library **MAY** have more than one account holding `TR-1` Owner.
Owner is a role, not a person, and **MUST NOT** be modelled as a single-valued
foreign key on the library record.

> **`LIB-15.13` prevents a structural dead end.** §6 requires an "Owner Name"
> field and §19 reserves critical operations to "the Owner", which together
> strongly suggest one owner column. But `AP-5` separation of duties requires
> that no account approve its own elevation — which is impossible to honour if
> exactly one Owner exists. Worse, `LIB-15.9` would make a sole Owner
> unremovable and their account un-erasable, colliding with `AUTH-9.46`. Owner as
> a multi-holder role resolves all three. The §6 "Owner Name" field remains: it
> is **profile display text**, not the authorization record.

---

## 16. Library Settings

Time Zone · Language · Currency · Date Format · Attendance Method (reference) ·
Shift Configuration · Seat Configuration (reference) · Notification Preferences ·
Member Directory Enable/Disable

**Operational rules remain owned by their respective modules.**

`LIB-16.1` — Settings **MUST** be stored through `BC-25` Configuration and
**MUST** be resolvable per tenant.

`LIB-16.2` — Every setting **MUST** have a documented default. A library that has
changed nothing **MUST** be fully operable.

`LIB-16.3` — Every setting change **MUST** be validated before persistence. An
invalid value **MUST** be rejected with a specific reason, and **MUST NOT** be
partially applied (§18).

`LIB-16.4` — Settings marked **(reference)** **MUST** be stored as a selection
whose meaning is owned elsewhere. This module **MUST NOT** implement the
behaviour behind them.

| Setting | Stored here | Behaviour owned by |
|---|---|---|
| Attendance Method | The selection | `BC-03` Attendance |
| Seat Configuration | The selection | `BC-04` Seating |
| Shift Configuration | Shift definitions | `BC-06`; consumed by `BC-02`, `BC-03` |
| Notification Preferences | The preference | `BC-22` Notification Delivery |
| Member Directory on/off | The flag | `BC-01` / Member Directory PRD |

`LIB-16.5` — **Notification Preferences** **MUST** be stored as tenant
configuration only. This module **MUST NOT** select a channel, render a template,
apply quiet hours or dispatch a message (`LXC-8`, `X-04`).

`LIB-16.6` — Disabling the Member Directory **MUST** suppress directory exposure
without deleting any membership or student record.

`LIB-16.7` — Currency **MUST** be stored for display and reporting. This module
**MUST NOT** perform currency conversion or hold monetary amounts (`LXC-7`).

`LIB-16.8` — Time Zone **MUST** be a single tenant-wide value in V1, and **MUST**
be applied to every time-bearing operational rule (`LIB-12.4`).

### 16.1 Configurable values

Values are **configurable**; their **ranges and invariants are not**. This table
is the register; operational guidance lives in
[`../../20-configuration/CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md).

| ID | Setting | Default | Range | Rationale for the default |
|---|---|---|---|---|
| `LCFG-1` | Time Zone | `Asia/Kolkata` | Any IANA zone | Every V1 library is in India (`MP-DEP-03` DLT) |
| `LCFG-2` | Language | `en` | Supported set | Only locale with complete strings at V1 |
| `LCFG-3` | Currency | `INR` | ISO 4217 | Follows `LCFG-1` |
| `LCFG-4` | Date Format | `dd/MM/yyyy` | Enumerated | Indian convention; `MM/dd` is a data-entry hazard |
| `LCFG-5` | Member Directory | **Disabled** | on/off | Deny by default (`AP-3`). Exposes members to members; opt in |
| `LCFG-6` | Discovery index propagation | **60 s** | 0–300 s | Public index is eventually consistent. **Applies only to Public→Private removal latency** |
| `LCFG-7` | Gallery images per branch | **20** | 1–50 | Storage and page-weight bound |
| `LCFG-8` | Facilities in reference list | **50** | 10–200 | Prevents unbounded growth of a public filter facet |
| `LCFG-9` | Floors per branch | **10** | 1–50 | Sanity bound |
| `LCFG-10` | Zones per floor | **20** | 1–100 | Sanity bound |

`LIB-16.9` — `LCFG-6` **MUST NOT** be applied to any authorization, membership,
suspension or revocation decision. Those are immediate and global with no
propagation window (`MP-GBR-26`).

> **`LIB-16.9` closes a genuine loophole.** Introducing any propagation window
> invites the reading that other state is also eventually consistent — which
> would contradict `MP-GBR-26`'s *"authoritative-or-absent, with no propagation
> window"*. The window applies to a **search index**, and to nothing else. Note
> also that `LCFG-6` governs only *removal* latency: `LIB-8.1` and `LIB-14.4`
> make non-appearance a correctness requirement, so a library must never become
> visible before it is Active and Public.

---

## 17. Business Policies

The library may configure policies that affect operations. Examples: Visitor
Policy · Security Policy · Library Timing Policy · Public Visibility Policy

**Detailed Membership, Attendance, Seat, and Finance policies are maintained in
their own PRDs.**

`LIB-17.1` — `BC-06` Library Policy **MUST** be the rule **source**. Other
contexts are rule **consumers** and **MUST** conform rather than translate
(`E-04`, `E-05`).

`LIB-17.2` — A policy **MUST** be stored as structured, validated data — never as
free text that another module parses.

`LIB-17.3` — A policy change **MUST** apply forward only, and **MUST NOT**
retroactively alter records already created (`LIB-12.8`).

`LIB-17.4` — Where a policy configured here would conflict with a rule owned by
another module, the owning module's rule **MUST** prevail and the conflict
**MUST** be surfaced to the Owner. This module **MUST NOT** silently override
another context's rule.

`LIB-17.5` — Membership, Attendance, Seat and Finance policy detail **MUST NOT**
be specified in this document.

---

## 18. Validation Rules

- Every library has one globally unique identifier.
- Every library must have one verified owner.
- Required profile information cannot be empty.
- Invalid configuration changes must be rejected.
- Every configuration change is validated before saving.

`LIB-18.1` — Every library **MUST** have one globally unique, immutable
identifier, assigned at creation and never reused.

`LIB-18.2` — The identifier **MUST NOT** encode the library name, mobile number,
PIN code, or any sequential counter that reveals tenant count or creation order.

`LIB-18.3` — Every library **MUST** have at least one account holding `TR-1`
Owner whose `Account` is verified (`LBR-2`, `LIB-15.9`).

`LIB-18.4` — Owner verification **MUST** mean a successfully OTP-verified
`Account` as defined by `BC-18` (`ADR-0005`). This module **MUST NOT** implement
its own verification.

`LIB-18.5` — Validation **MUST** occur before persistence. A rejected change
**MUST** leave stored state exactly as it was.

`LIB-18.6` — A multi-field change **MUST** be atomic: either every field is
applied or none is.

`LIB-18.7` — Rejection **MUST** identify the offending field and the reason.
A generic failure message is a defect.

`LIB-18.8` — Every tenant-scoped query **MUST** carry a tenant key. A query
without one **MUST** be refused, not defaulted (`MP-GBR-08`, `SE-1`, `X-13`).

> **`LIB-18.2` is added because `LIB-18.1` alone permits a sequential integer.**
> `library/1041` in a URL discloses the platform's customer count to every
> competitor, and makes neighbouring tenants trivially enumerable.

---

## 19. Security Requirements

Tenant Isolation · Role-Based Access Control · Audit Logs · Configuration
History · Permission Validation · Secure Configuration Storage

**Only the Owner can perform critical administrative operations.**

`LIB-19.1` — Tenant isolation **MUST** be enforced at the data-access boundary,
not in UI or application logic. Cross-tenant read or write **MUST** be
impossible, not merely unauthorised (`LXC-10`).

`LIB-19.2` — Every operation **MUST** be authorised by `BC-18` before execution.
This module **MUST NOT** infer permission from a role name (`AUTH-7.3`,
`AUTH-7.4`).

`LIB-19.3` — Deny **MUST** defeat allow in every case (`AUTH-7.34`).

`LIB-19.4` — Every administrative and configuration change **MUST** be audit
logged with actor account, role, tenant, action, target, prior value, new value,
timestamp and source.

`LIB-19.5` — Audit records **MUST** be append-only. They **MUST NOT** be
editable or deletable by any library role, including `TR-1` Owner.

`LIB-19.6` — Audit records **MUST** survive account erasure in a form that
retains the fact and timing of the action while no longer identifying the person
(`AUTH-9.57`).

`LIB-19.7` — Configuration History **MUST** allow reconstruction of the
configuration in force at any past moment.

`LIB-19.8` — Secrets **MUST NOT** be stored in library configuration. `BC-25`
holds secret **references** only.

`LIB-19.9` — Operations reserved to the Owner **MUST** be enumerated in policy
and evaluated by `BC-18` (`LIB-15.12`).

`LIB-19.10` — The public profile **MUST** be served by a projection containing
only §14A.5 fields. A public request **MUST NOT** be able to reach an operational
table (`LBR-5`, `LIB-7.2`).

> **`LIB-19.10` is the difference between a filtered query and a separate read
> model.** If the public endpoint queries the operational table and filters
> columns, one forgotten `SELECT *` leaks member data. If it can only see a
> projection, the leak is structurally impossible.

---

## 20. Non-Functional Requirements

Multi-Tenant SaaS · High Availability · Horizontal Scalability · High
Performance · Security by Default · Backup & Recovery · Observability ·
Auditability

`LIB-20.1` — Platform-wide NFR budgets **MUST** be taken from the Enterprise
Architecture NFR Budgets document. This PRD **MUST NOT** state a competing
latency or availability figure.

`LIB-20.2` — The public profile and discovery search **MUST** be servable to
unauthenticated traffic without consuming tenant-scoped operational capacity.

`LIB-20.3` — Public endpoints **MUST** be rate limited per origin (`CFG-3`).

`LIB-20.4` — Every configuration read **MUST** be tenant-scoped and **MUST NOT**
require a cross-tenant scan.

`LIB-20.5` — Observability **MUST** record tenant identifier, actor role and
outcome for every administrative operation, and **MUST NOT** record the contents
of a secret or an authentication credential.

> **`LIB-20.1` avoids a documentation trap.** A PRD that states "99.9%
> availability" creates a second source of truth that will diverge from the NFR
> budget. Referencing is the durable choice.

---

## 21. Integrations

This module integrates with: Authentication · Authorization · Student Identity &
Profile · Student Management · Library Member Directory · Membership Management ·
Seat Management · Attendance Management · Revenue & Finance · Dashboards ·
Notifications

`LIB-21.1` — Every integration **MUST** use a declared edge from the Bounded
Context Map. An undeclared dependency is a boundary violation.

| Integration | Context | Mechanism | Direction |
|---|---|---|---|
| Authentication | `BC-18` | Sync port — account verification, role grant request | Library → `BC-18` |
| Authorization | `BC-18` | Sync port — policy decision per operation | Library → `BC-18` |
| Student Identity & Profile | `BC-10` / `BC-01` | Read projection | Library ← |
| Student Management | `BC-01` | Read projection | Library ← |
| Library Member Directory | `BC-01` | Read projection, gated by `LCFG-5` | Library ← |
| Membership Management | `BC-02` | Read projection — plans for public display | Library ← |
| Seat Management | `BC-04` | Read projection — aggregate capacity only (`LIB-7.3`) | Library ← |
| Attendance Management | `BC-03` | Rule supply (`E-04`) | Library → |
| Revenue & Finance | `BC-11`…`BC-13` | Read projection — never authoritative here | Library ← |
| Dashboards | — | Read composition. Owns nothing | ← |
| **Notifications** | `BC-22` | **Event emission only.** Library emits facts; `BC-22` subscribes | Library → (async) |
| Search / Discovery | `BC-23` | Public projection | Library → |
| Map & geocoding | `BC-31` | Port. Vendor contract owned by `BC-31` (`LIB-6.5`) | Library → |

`LIB-21.2` — This module **MUST NOT** import `platform/communication/**`. It
emits domain events; `BC-22` Notification Delivery subscribes (`X-04`, `LXC-8`).

`LIB-21.3` — This module **MUST NOT** import `platform/integration/**`, and
**MUST NOT** name a vendor (`X-03`, `LXC-9`).

> **Corrects review finding `CC-5`.** §21 and §14A.12 both listed
> *"Notifications"* as an integration, while §3 and §14A.3 place it **out of
> scope** — and `banned_imports` blocks the import outright. An implementer
> following the integration list writes forbidden code; one following the scope
> list omits notifications entirely. Ambiguity guarantees one of them is wrong.
> The capability is preserved and the mechanism named correctly: **the library
> emits events, `BC-22` delivers.** Maps is corrected the same way (`CC-6`).

### 21.1 Events emitted

`LIB-21.4` — These events **MUST** be emitted as facts about something that has
already happened. They **MUST NOT** carry an instruction, and **MUST NOT** name a
recipient or channel.

| ID | Event | Emitted when |
|---|---|---|
| `LEV-1` | `LibraryCreated` | A library record is created |
| `LEV-2` | `LibraryVerified` | Verification succeeds |
| `LEV-3` | `LibraryActivated` | Library becomes Active |
| `LEV-4` | `LibrarySuspended` | Library is suspended |
| `LEV-5` | `LibraryArchived` | Library is archived |
| `LEV-6` | `LibraryRestored` | Library is restored to Suspended |
| `LEV-7` | `LibraryVisibilityChanged` | Visibility mode changes |
| `LEV-8` | `LibraryProfileUpdated` | Profile field changes |
| `LEV-9` | `OperatingHoursChanged` | Weekly schedule changes |
| `LEV-10` | `HolidayDeclared` | A holiday is added |
| `LEV-11` | `EmergencyClosureDeclared` | Emergency closure begins |
| `LEV-12` | `EmergencyClosureLifted` | Emergency closure ends |
| `LEV-13` | `BranchCreated` | A branch is created |
| `LEV-14` | `FloorConfigurationChanged` | Floors change |
| `LEV-15` | `ZoneConfigurationChanged` | Zones change |
| `LEV-16` | `FacilitiesChanged` | Facility associations change |
| `LEV-17` | `StaffInvited` | A staff invitation is issued |
| `LEV-18` | `StaffAssignmentCreated` | A staff role grant is confirmed |
| `LEV-19` | `StaffAssignmentSuspended` | A staff assignment is suspended |
| `LEV-20` | `StaffAssignmentRevoked` | A staff assignment is revoked |
| `LEV-21` | `LibrarySettingChanged` | A setting changes |
| `LEV-22` | `BusinessPolicyChanged` | A policy changes |

`LIB-21.5` — An event **MUST NOT** carry a mobile number, an OTP, a session
token, a secret or any authentication credential.

`LIB-21.6` — Every event **MUST** carry the tenant key, actor account
identifier, and timestamp.

---

## 22. Business Rules

| ID | Rule |
|---|---|
| `LBR-1` | Every library has a unique identity |
| `LBR-2` | Only a verified owner may create a library |
| `LBR-3` | Each library is fully isolated from every other tenant |
| `LBR-4` | Staff permissions follow role-based access |
| `LBR-5` | Public profiles never expose confidential information |
| `LBR-6` | Configuration changes are audit logged |
| `LBR-7` | A suspended library cannot perform operational activities |
| `LBR-8` | Dependent modules must reference the Library entity instead of storing duplicate library data |

| Rule | Enforced by | Verified by |
|---|---|---|
| `LBR-1` | `LIB-18.1`, `LIB-18.2` | `LAC-9` |
| `LBR-2` | `LIB-18.3`, `LIB-18.4` | `LAC-1` |
| `LBR-3` | `LIB-18.8`, `LIB-19.1`, `LXC-10` | `LAC-8` |
| `LBR-4` | `LIB-15.3`, `LIB-19.2`, `LIB-19.3` | `LAC-3` |
| `LBR-5` | `LIB-7.2`, `LIB-19.10` | `LAC-10` |
| `LBR-6` | `LIB-19.4`, `LIB-19.5` | `LAC-7` |
| `LBR-7` | `LIB-8.2`, `LIB-8.3` | `LAC-11` |
| `LBR-8` | `LIB-1.2` | `LAC-9` |

---

## 23. MVP Scope

### Must Have (V1)

Library Profile · Branding · Staff Management · Single Branch · Floor
Management · Zone Management · Operating Hours · Facilities · Library Settings ·
Visibility · Business Policies · Audit Logs

`LIB-23.1` — Every V1 item **MUST** be complete before this module is considered
shippable. Partial delivery of an item is not delivery.

`LIB-23.2` — Public Discovery and Public Preview (§14A, §14B) are **V1**. They
are the platform's user-acquisition entry point.

`LIB-23.3` — Audit Logs are **V1**, not a later hardening step. A configuration
change made before audit logging exists is unreconstructable.

---

## 24. Future Scope (V2+)

| Item | Tier | Note |
|---|---|---|
| Multi-Branch Operations | **V3** | Corrected from "V2+" per Master PRD §32 (`LIB-9.4`) |
| Franchise Management | **V3** | Depends on multi-branch |
| Public Live Occupancy | **V2** | Constrained by `LIB-7.3`; requires a privacy review before design |
| Online Seat Booking | **V2** | Owned by `BC-04`, not this module |
| Reviews & Ratings | **V2** | New context; not in the V1 31 |
| Events | **V2** | `BC-14` Event Platform, already tiered V2 |
| AI Insights | **V2** | `platform/ai` |
| Advanced Branding | **V2** | Extends `BC-25` |
| Public Library Discovery | **V1 — already delivered by §14A** | Listed under Future Scope in the source text; §14A specifies it as V1 |

`LIB-24.1` — No V2 or V3 item **MAY** be partially implemented in V1. A stub is
a maintenance liability and a false signal of progress.

`LIB-24.2` — Public Live Occupancy **MUST NOT** be implemented until a privacy
review has determined what may be published. Live occupancy is a proxy for
individual presence.

> **Two corrections in this chapter, both from the authoritative roadmap.**
> Multi-Branch was listed "V2+" but is **V3** in Master PRD §32. And *"Public
> Library Discovery"* appears in Future Scope while §14A specifies it as a V1
> capability with acceptance criteria — the same document listing one capability
> as both current and future. §14A governs.
>
> **`LIB-24.2` is a flag, not a new requirement.** A live seat-occupancy feed for
> a study hall tells an observer, in real time, roughly how many people are
> present and when a regular arrives. That deserves a decision, not a default.

---

## 25. Acceptance Criteria

The module is considered complete when:

| ID | Criterion | Source |
|---|---|---|
| `LAC-1` | A verified owner can create a library | §25 |
| `LAC-2` | Library profile can be managed | §25 |
| `LAC-3` | Staff can be invited and assigned roles | §25 |
| `LAC-4` | Library settings persist correctly | §25 |
| `LAC-5` | Facilities can be configured | §25 |
| `LAC-6` | Visibility settings work correctly | §25 |
| `LAC-7` | Audit logs capture administrative changes | §25 |
| `LAC-8` | Tenant isolation is enforced | §25 |
| `LAC-9` | Dependent modules can reference the Library entity without data duplication | §25 |

### 25.1 How each criterion is proven

An acceptance criterion that cannot fail is not a test. Each is given a
falsifiable form; **no criterion was weakened**.

| ID | Passes when | Fails when |
|---|---|---|
| `LAC-1` | An OTP-verified account creates a library reaching **Draft**, and required fields are enforced before **Pending Verification** | An unverified account creates a library, or a library reaches Active with an empty required field |
| `LAC-2` | Every §6 field is readable and writable by an authorised role; each change is audit logged | A field is silently truncated, or a change is unlogged |
| `LAC-3` | An invitation issued per `INVITATION_SECURITY_SPECIFICATION.md` results in a `BC-18` role grant | This module writes a permission itself, or an invitation grants a role without acceptance |
| `LAC-4` | A changed setting survives restart and is returned tenant-scoped; an invalid value is rejected atomically | An invalid value persists, or a partial write occurs |
| `LAC-5` | A facility is added to the reference list and associated with no migration and no deployment | Adding a facility requires a schema or code change |
| `LAC-6` | A Public library appears in discovery; a Private one never does, in any discovery method | A Private library appears anywhere public, or Public→Private removal exceeds `LCFG-6` |
| `LAC-7` | Every §19 field is present on every administrative change, and no library role can edit or delete a record | A field is absent, or an Owner can alter history |
| `LAC-8` | A tenant-less query is **refused**; a cross-tenant request returns nothing regardless of role | A query defaults to a tenant, or any path returns another tenant's row |
| `LAC-9` | No dependent module stores a copy of library-owned data; each reads a projection | A second copy of opening hours, name or facilities exists anywhere |
| `LAC-10` | The public profile returns exactly the §14A.5 allow-list and no other field | Any non-allow-listed field is reachable through a public endpoint |
| `LAC-11` | A Suspended library refuses every operational action immediately | A cached decision permits an operation after suspension |
| `LAC-12` | Every §21.1 event is emitted with tenant key, actor and timestamp, and carries no credential | An event carries a mobile number or token, or an event is missing |

`LIB-25.1` — `LAC-10`, `LAC-11` and `LAC-12` are **added acceptance criteria**,
not restatements. They prove `LBR-5`, `LBR-7` and `LIB-21.5`, which the original
nine did not cover.

---

## 26. Module ownership boundary — enforceable form

`LIB-26.1` — This table is the authoritative answer to "who owns this field?".
Where a field is needed by this module but owned elsewhere, it is **read through a
projection** and **never stored here**.

| Data | Owner | This module |
|---|---|---|
| Library name, address, contact, status, tenant record | `BC-19` | **Owns** |
| Branch, floors, zones, hours, holidays, closures, policies | `BC-06` | **Owns** |
| Settings, feature flags, branding values, secret references | `BC-25` | **Owns** |
| Logo, cover, gallery binaries | `BC-29` | References by id |
| Facility reference list and associations | `BC-06` | **Owns** |
| Staff assignment record and its lifecycle | `BC-19` | **Owns** |
| Role grant, permission, policy decision | `BC-18` | Requests only |
| Account, credential, OTP, session, device | `BC-18` | Never touches |
| Student profile, enrollment | `BC-01` / `BC-10` | Reads projection |
| Membership plan, price, validity | `BC-02` | Reads projection |
| Seat inventory, assignment, occupancy | `BC-04` | Reads aggregate only |
| Attendance record | `BC-03` | Supplies rules; reads nothing |
| Invoice, payment, revenue | `BC-11`…`BC-13` | Reads projection |
| Public discovery index | `BC-23` | Supplies projection |
| Notification channel, template, delivery | `BC-22` | Emits events only |
| Vendor contract, credential, retry | `BC-31` | Uses port only |

`LIB-26.2` — A change to this table is an **architecture change** requiring an
ADR. It **MUST NOT** be amended by a PRD revision alone.

---

## 27. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-03 | First complete receipt of §§1–25. Captured with the requirement set intact. Corrections applied only where a genuine conflict with a higher-precedence document existed: role names aligned to `TR-1`…`TR-3` + Platform Administrator (§4); Multi-Branch retiered V2+ → **V3** (§9, §24); Notifications and Maps restated as event emission and port (§21, `CC-5`, `CC-6`); the two public-field lists reconciled to §14A.5 (§7); business contact number separated from the authentication credential (§6); Owner modelled as a multi-holder role (§15). Added: explicit exclusions `LXC-1`…`LXC-10`, configurable register `LCFG-1`…`LCFG-10`, event register `LEV-1`…`LEV-22`, ownership boundary §26, acceptance criteria `LAC-10`…`LAC-12`. **No requirement from the source text was removed.** |

---

## 28. Related documents

| Document | Relationship |
|---|---|
| [`14A-Library-Discovery-And-Enrollment.md`](./14A-Library-Discovery-And-Enrollment.md) | §14A, captured verbatim. Part of this PRD |
| [`14B-Public-Library-Preview.md`](./14B-Public-Library-Preview.md) | §14B, extends §14A. Part of this PRD |
| [`INVITATION_SECURITY_SPECIFICATION.md`](./INVITATION_SECURITY_SPECIFICATION.md) | Satisfies `AR-4`. Governs §14.5, §15.2 |
| [`LIBRARY_PRD_ALIGNMENT.md`](./LIBRARY_PRD_ALIGNMENT.md) | Validation record for this version |
| [`../MASTER_PRD.md`](../MASTER_PRD.md) | Precedence rank 1 |
| [`../authentication/Authentication_PRD_v2.md`](../authentication/Authentication_PRD_v2.md) | Owns everything in `LXC-1`, `LXC-2` |
| [`../../00-governance/DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) | Precedence order |
| [`../../20-configuration/CONFIGURATION_GUIDE.md`](../../20-configuration/CONFIGURATION_GUIDE.md) | `CFG-*` and `LCFG-*` operational guidance |

---

**End of specification.**
