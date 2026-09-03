# Liboora — Developer Handoff

| Field | Value |
|---|---|
| **Version** | v1.1 |
| **Date** | 2026-08-02 · **revised 2026-08-03** |
| **Baseline** | BASELINE-2026-08-03 |
| **Audience** | Engineers implementing `BC-18` Identity & Access **or Library Management** |
| **Read this** | **First.** Before any other document, before any code |

---

## 1. What Liboora is

A **multi-tenant SaaS platform for libraries and study halls in India.** One deployment serves many independent
library organisations. A library's owner, managers and reception staff run their venue; students and parents use
it.

Two facts shape almost every technical decision:

1. **Tenant isolation is absolute.** Data belonging to one library must never be reachable from another. A
   tenant-less query on tenant data is a **blocker-severity** defect, not a bug to schedule.
2. **Authentication is a mobile number and a one-time code. There are no passwords anywhere.** Not hashed, not
   optional, not "for admins." None.

---

## 2. Read in this order

| # | Document | Why |
|---|---|---|
| 1 | **This document** | Orientation and the traps |
| 2 | `00-governance/DOCUMENTATION_BASELINE.md` | Which documents are authoritative, and precedence |
| 3 | `00-governance/adr/ADR-INDEX.md` → all **10** ADRs | The structural decisions. **Binding** |
| 4 | `20-configuration/CONFIGURATION_GUIDE.md` | The thirty-five configurable values and why |
| 5 | `40-implementation/IMPLEMENTATION_ROADMAP.md` | What to build, in what order |
| 6 | `40-implementation/DEFINITION_OF_DONE.md` | The three gates |

Then **the specification for the module you are working on** — not both:

| Working on | Read |
|---|---|
| **Authentication** (`BC-18`) | `30-product/authentication/Authentication_PRD_v2.md` — 588 requirements · then `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`, kept open while coding |
| **Library Management** | `30-product/library/Library_PRD_v1.md` — §§1–25 · `14A-Library-Discovery-And-Enrollment.md` · `14B-Public-Library-Preview.md` · `INVITATION_SECURITY_SPECIFICATION.md` · then `LIBRARY_IMPLEMENTATION_TASKS.md` |

The ten ADRs are short. **Read all ten before writing code**, whichever module you are on. Each records a decision
that looks arbitrary until you know why, and each has been re-litigated at least once already.

**Library engineers still need `ADR-0002`, `ADR-0003` and `ADR-0004`.** Library Management never authenticates
anyone, but almost every journey it owns passes through authentication — joining, booking, invitation acceptance. You
cannot implement the boundary correctly without knowing what is on the other side of it.

---

## 3. Architecture in one page

**Modular monolith.** One deployable, hard internal boundaries. A pure-Dart shared kernel in
`packages/liboora_contracts` holds cross-module contracts. Modules communicate only along permitted edges
(`E-01`…`E-26`); fourteen edges are explicitly forbidden (`X-01`…`X-14`).

**31 bounded contexts, 23 in V1.** `BC-18` Identity & Access owns *"credentials, sessions, devices, OTP, roles,
permissions, policy decisions, consent."* Nothing else may create an account, issue a session, or decide a
permission.

**Hybrid tenancy.** `Account` is **global** — one person, one mobile number, one account across the whole
platform. Role assignments are **tenant-scoped** — the same person can be a manager in one library and a student
in another, and those facts are unrelated. `AccessPolicy` is always evaluated with a tenant in scope.

**Two-stage authentication.** Verification proves *who* and yields an `Account`. Session issuance grants *what,
where* and yields a `Session` bound to exactly one library. These are separate operations with separate outputs.

**Library Discovery is not a bounded context.** It is an application-level *read composition* (`AR-1`) — it owns no
aggregate, no invariant and no business state. It composes `BC-19` Tenancy, `BC-25` Configuration, `BC-29` File &
Media, `BC-06` Library Policy, `BC-02` Membership and `BC-04` Seating through `BC-23` Search Indexing. If you find
yourself giving it a table of its own, stop.

**"Library" means two different things and the codebase must keep them apart.** `TenantOrganisation` (`BC-19`) is
the billing entity — the customer. `Branch` (`BC-06`) is the physical location that has opening hours and seats.
Model `branchId` on every core record from the first migration even though V1 ships one branch per organisation:
multi-branch is V3, and retrofitting the column later is a migration across every core table.

**Boundaries are currently unenforced.** `tool/check_module_boundaries.dart` does not exist (`IMPL-014`). Until
it does, every boundary rule is honour-system. This is the first task in the roadmap.

---

## 4. The seven things most likely to be got wrong

Ranked by consequence. Each is elaborated in the checklist.

### 1. Letting the OTP reach the client ⚠ severity: authentication does not exist

The code must never appear in any client response, header or field, in **any** environment. Development reads it
from **server logs**. Tests read it from a fake gateway in `test/`.

This is not hypothetical — it is the current state of the codebase (`TASK-D10`, Surface 3).

### 2. Getting `CFG-3` wrong ⚠ severity: venue-wide outage

A study hall is **60–200 students behind one NAT gateway**. Per-origin rate limiting must tolerate that, and the
origin must be the true client address, not a proxy address. The original value of 30/hour would have locked out
every venue on day one.

### 3. Caching an authorization decision ⚠ severity: violates a global rule

`MP-GBR-26`: revocation is *"immediate and global — authoritative-or-absent, with no propagation window."* Even
a few seconds of cached authorization violates it. **Design for this from the start.**

### 4. Treating device management as optional ⚠ severity: no takeover detection

It is V1. In a single-factor system SIM swap defeats authentication completely, and unrecognised-device
notification (`EV-16`) is the **only** compensating control.

### 5. Making "authenticated, no library" an error ⚠ severity: first-run broken for everyone

Every user is in this state immediately after registering. It is normal, persistent, and must be representable.

### 6. One session timeout for everyone ⚠ severity: compliance failure

Staff use **shared reception devices** — 30 minutes idle, 12 hours absolute, per NIST SP 800-63B AAL2. Mobile
users have personal devices — 30 days idle, 90 days absolute. Two threat models.

### 7. Inventing a requirement ⚠ severity: permanent undocumented rule

If the specification is silent, **raise it — do not decide it.** A guess made under delivery pressure is
indistinguishable from a decision to the next reader.

Both PRDs now carry explicit **exclusion registers** — `XC-*` for authentication, `LXC-1`…`LXC-10` for Library,
`INV-XC-1`…`INV-XC-7` for invitations. An exclusion is not an omission awaiting your judgement; it is a decision
that the thing must be **impossible**. If you find yourself implementing something listed there, you have found a
requirements conflict, not a gap.

---

## 4A. Library Management — the four things most likely to be got wrong

Read alongside §4. These are specific to the Library module and each has a corresponding task in
[`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md).

### 1. Treating an invitation as a credential ⚠ severity: creates a second authentication factor

`ADR-0009`: *an invitation is a scoped, revocable, expiring claim to be offered a role or an enrollment opportunity
— never a credential.* Possession of the link must never, by itself, authenticate anybody.

The failure mode is subtle and looks like a convenience feature. If holding the link logs you in, then forwarding a
WhatsApp message **transfers an identity** — and the platform now has two authentication factors, one of which is
routinely copy-pasted into group chats. That defeats `MP-GBR-25`, `ADR-0002` and `ADR-0004` simultaneously.

The acceptance sequence in the Invitation Security Specification §6 is ordered deliberately and **must not be
reordered**: validate the artefact → authenticate the holder via `BC-18` → confirm the authenticated number matches
the bound number → consume the artefact → *request* the role grant from `BC-18` → audit. Library Management never
grants the role itself.

### 2. Confusing authentication with authorisation on the public preview ⚠ severity: cross-tenant exposure

`LIB-14B.29`: protected operations require authorisation **in addition to** authentication. A gate that admits any
authenticated caller has implemented half of `IMPL-123` — and will pass every test written by whoever implemented
it, because the tests will use a caller who happens to be a member.

### 3. Publishing a field that is really a credential ⚠ severity: discloses the sole auth factor

The library's business contact number and the owner's authentication credential are **different fields**
(`LIB-6.4`), and the former must never be read from or inferred from the latter. Under `MP-GBR-25` a mobile number
*is* the authentication factor; a public profile that surfaces one has published half a credential.

The public field list is an **allow-list**, defined once in §14A.5. Never add to it in code.

### 4. Modelling Owner as a single value ⚠ severity: unfixable without a migration

`LIB-15.13`: Owner is a **multi-holder role**, never a single-valued foreign key on the library record. A single
owner column collides with three separate rules at once — `AP-5` separation of duties, `LIB-15.9` last-owner
protection, and `AUTH-9.46` the right of any account holder to request erasure. The first owner who asks to be
deleted makes the problem visible, and by then it is a data migration.

---

## 5. Ground rules

| Rule | Consequence of breaking it |
|---|---|
| No passwords or reusable secrets, ever | `MP-GBR-25` — architectural, not a preference |
| No demo, guest, seeded or sample account in any build | `MP-CON-11` — **release blocker** |
| No emergency bypass, no break-glass | `AUTH-11.53`, `AUTH-11.54` — permanently excluded |
| Every tenant-scoped query carries a tenant key | `MP-GBR-08` — blocker severity |
| Structural facts (PRD §F) are never configurable | Lets operators configure out of conformance |
| A structural decision needs an ADR **before** the code | Otherwise the reasoning is lost |
| Documentation updates in the **same commit** as the code | This is how the repository reached its audit state |
| Library Management never decides a permission | `X-13` — ask `BC-18`, cache nothing |
| Library Management never calls `platform/communication/**` | `X-04` — emit a fact (`LEV-*`), let `BC-22` deliver it |
| Library Management never calls `platform/integration/**` | `X-03` — no vendor knowledge inside a domain module |
| No Library event carries a credential or unmasked mobile number | `LIB-21.5` — an event goes everywhere, to subscribers who were never part of the authorization decision |

---

## 6. Current codebase state — read honestly

| | |
|---|---|
| **Flutter / Dart** | 3.35.4 / 3.9.2 — version-locked, do not upgrade |
| **`flutter analyze`** | `No issues found!` |
| **`flutter test`** | 43 passing — 34 conformance, 9 widget |
| **Conformance to v2.0** | **Unknown.** The tests predate the specification |

**The code predates the specification.** 43 green tests do not evidence conformance to 588 requirements. They
were written against earlier rulings and cover a fraction of the surface. Treat existing authentication code as
**unverified**, not as a working baseline.

**The application currently cannot lawfully ship.** Three demo surfaces violate `MP-CON-11`:

| Surface | Location | Guard |
|---|---|---|
| Seeded accounts panel — 5 tappable accounts including Owner | `login_screen.dart:219`, rendered at line 90 | **None** |
| OTP auto-filled into the login field | `identity.dart:323` → `session.dart:91` → `login_screen.dart:42` | Release only — **active in profile builds** |
| Hardcoded demo child phone | `session.dart:26` | None |

Full detail and remediation: `TASK-D10-remove-demo-surfaces.md`.

**One thing you can do today.** Deleting `login_screen.dart:42` (`_code.text = s.otpHint ?? '';`) closes the live
authentication bypass. One line, no dependencies. Everything else in `TASK-D10` waits for real SMS delivery,
because removing the demo surfaces without it leaves an application nobody can enter.

**Library Management does not exist in the codebase at all.** Not partially, not as a sketch — there is no tenancy
module, no library aggregate, no public projection and no invitation mechanism. This is a materially different
situation from authentication, and the difference matters when reading a status column: authentication code is
**unverified**, Library code is **absent**. Both show as "not started"; only one of them has something to inspect.

---

## 7. Known gaps — declared, not hidden

| Gap | Effect | Priority |
|---|---|---|
| **`TASK-D10`** — demo surfaces in code | Cannot ship any release build | **P0** |
| **`IMPL-020`** — no real SMS delivery | Blocks `TASK-D10`, blocks everything | **P0** |
| **`IMPL-014`** — no module boundary checker | Boundaries unenforced; violations accumulate silently | **P1** |
| **`IMPL-015`** — no configuration validation | A misconfigured control looks enabled | **P1** |
| **`IMPL-100`** — no tenant foundation | `MP-GBR-08` cannot be enforced; blocks all 22 other Library tasks | **P1** |
| **Library Management** — 23 tasks, none started | Fully specified, entirely unbuilt | **P1** |
| `R-5` — `lib/contracts/` referenced but absent | Import paths in prose do not resolve | P2 |
| `D-8`, `D-9` | Carried forward from earlier registers | P2 |
| Public Live Occupancy · Reviews & Ratings | **V2.** Deferred; no V1 effect | P3 |
| Development Standards (`R-4`) | Deferred | P3 |

**Both modules are now fully specified and ready to implement.** Two gaps that sat in this table since 2026-08-02 —
*"Library PRD §§1–25 never supplied"* and *"invitation security spec never written"* — closed on 2026-08-03. The
specifications exist.

**That is not the same as progress.** What replaced them is twenty-three open implementation tasks. A specification
tells you the work is *possible*; it does not make the work smaller. `IMPL-020` in particular is now on the Library
critical path too — an `IT-1` staff invitation is delivered by SMS, so it inherits the DLT registration dependency.
**DLT approval takes weeks and is not under our control: start it before writing any Library code.**

---

## 8. When documents disagree

| Rank | Source |
|---|---|
| 1 | `MASTER_PRD.md` global rules — `MP-GBR-*`, `MP-CON-*`, `MP-DEP-*` |
| 2 | Accepted ADRs |
| 3 | Authentication PRD v2.0 (`BC-18`) · **Library PRD v1.0 + §14A + §14B + Invitation Security Specification** (Library Management) |
| 4 | Bounded Context Map · Module Dependency Matrix |
| 5 | Architecture Rulings `AR-1`, `AR-3`, `AR-4` |
| 6 | Enterprise Architecture v2.1 — **descriptive only** |
| 7 | Configuration Guide |

**A conflict is a defect.** Do not resolve it in code. The precedence order tells you which document is *wrong* —
report it so it gets fixed once, rather than worked around repeatedly.

**Rank 3 holds two module baselines and they do not overlap.** Where a Library requirement appears to constrain
authentication — the preview's authentication boundary, the invitation acceptance sequence — the Library document
states *what must be true* and `BC-18` remains the sole authority on *how it is decided*. That is not a precedence
question; a Library module that evaluates or caches an authorization decision has violated `X-13`.

---

## 9. A note on the Authentication PRD

Authentication PRD **v2.0** was **authored, not recovered.** An earlier v1 was referenced throughout the
repository but never existed in it — eleven chapter files were empty placeholders. Recovery failed; the text is
not in git history or any versioned artefact.

v2.0 was written from scratch against the constraints that *were* present: the Master PRD global rules, the
Bounded Context Map, the Module Dependency Matrix, and Architecture Rulings `AR-1`…`AR-7`. It makes **no claim**
about what v1 contained. It is now the official baseline (`ADR-0008`), and if v1 ever resurfaces it has no
standing.

**Practical consequence:** you may encounter archived documents in `90-archive/` asserting that the specification
is missing. They are historical. Every one carries a header saying so. The specification exists.

---

## 10. First week

| Day | Do |
|---|---|
| 1 | Read documents 2–5 above. All **ten** ADRs |
| 1 | Delete `login_screen.dart:42`. Closes the live bypass |
| 2 | `IMPL-014` — module boundary checker. Run it; record existing violations |
| 3 | `IMPL-015` — configuration validation, `INV-1`…`INV-9` |
| 4 | `IMPL-016` — configuration surface. No `CFG` literals anywhere |
| 5 | Begin `IMPL-020` — SMS provider. The critical path starts here |

**Start the DLT registration paperwork on day 1, in parallel with everything above.** It is the longest lead time in
the programme, it is an external approval nobody here can accelerate, and both `TASK-D10` and `IMPL-112` wait on it.
Every other item in this table is measured in days; this one is measured in weeks.

**Do not begin feature work before `IMPL-014`.** Authentication touches more modules than anything else, and
without boundary enforcement it is the work most likely to create a violation that is expensive to unwind later.

### If you are starting on Library Management

| Day | Do |
|---|---|
| 1 | Read the four Library documents. Then `ADR-0009` and `ADR-0010` |
| 2 | `IMPL-100` — tenant foundation. `branchId` and the tenant key on every table from migration 1 |
| 3 | `IMPL-101` — lifecycle state machine. `Restore` returns to **Suspended**, never straight to Active |
| 4 | `IMPL-103` — audit log. Every administrative action, before the actions exist |
| 5 | `IMPL-102` — profile and validation. Business number **separate** from the auth credential |

**`IMPL-100` first, and not negotiably.** Tenant-key enforcement under `MP-GBR-08` is nearly free to build into a
schema and expensive to add to one. Every table created before it exists is a table that will need migrating.

---

## 11. References

`DOCUMENTATION_BASELINE.md` · `ADR-INDEX.md` · `Authentication_PRD_v2.md` · `CONFIGURATION_GUIDE.md` ·
`IMPLEMENTATION_ROADMAP.md` · `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` · `TASK-D10-remove-demo-surfaces.md` ·
`DEFINITION_OF_DONE.md` · `TRACEABILITY_MATRIX.md` ·
[`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) ·
[`14A-Library-Discovery-And-Enrollment.md`](../30-product/library/14A-Library-Discovery-And-Enrollment.md) ·
[`14B-Public-Library-Preview.md`](../30-product/library/14B-Public-Library-Preview.md) ·
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) ·
[`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md)

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-03 | Extended to cover Library Management. Added §4A (the four Library traps), a Library reading path in §2, the `TenantOrganisation`/`Branch` distinction and the `AR-1` composition note in §3, four Library ground rules in §5, a Library first-week plan in §10. Revised §7 — the two Library specification gaps are closed and replaced with twenty-three open implementation tasks. ADR count 8 → 10. Recorded that `IMPL-020` DLT registration is now on the Library critical path and has the longest external lead time in the programme. |
| v1.0 | 2026-08-02 | Created. Closes audit finding `G-2`. |
