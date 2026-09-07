<!--
  PRD-021B — Part B6 — Global vs Library Discovery Scope
  DRAFT v0.1 — Stage 2

  PROVENANCE
  ----------
  Authored from the supplied B6 specification, reconciled against measured
  repository authority.

  B6 owns SCOPE DEFINITION ONLY. It defines the closed scope enum, fixes the V1
  values (LIBRARY=ON, GLOBAL=OFF, LOCAL=OFF, NEARBY=OFF), specifies how scope is
  supplied and enforced, and describes a future global architecture WITHOUT
  enabling it.

  ⚠ ONE MEASUREMENT WORTH STATING UP FRONT
  ----------------------------------------
  "Part B6" measured 0 occurrences across docs/ before authoring - it is the
  only part in the supplied set that B0's FOD-4 does NOT name. FOD-4 lists
  B4/B5/B7/B8/B9. B6 is therefore a NEW part identifier, not a previously
  disclosed one. Recorded as XPB-CONF-005, Governance Owner.

  ⚠ THE LOAD-BEARING TENSION B6 EXISTS TO HOLD
  --------------------------------------------
  The "BC-11..BC-17 Student Network" residency BAND is GLOBAL by BC Map L488
  (rule ID-2): no tenantId, keyed on PersonId. (⚠ "BC-11→17" in the BC Map is a
  RANGE label for that band, NOT an integration edge; B6 cites no edge to BC-17
  Marketplace, which is V3.)
  Library membership is TENANT-SCOPED (MP-GBR-08). X-05 keeps them
  "Separate Ways". So "library-scoped discovery over a global social graph" is
  not a contradiction only if the SCOPE FILTER sits tenant-side and the GRAPH
  stays global. B6 states that rule explicitly rather than leaving it implied.

  Status        : DRAFT — v0.1 (Stage 2)
  Freeze status : NOT FROZEN. NOT FINAL. NOT APPROVED. NOT BASELINED.
  Lifecycle     : Stage 2 (Draft) ONLY. Stage 3 and Stage 4 NOT entered.

  What this file does NOT do
    - It creates no bounded context. The count remains 31.
    - It creates no integration edge and mints no published event.
    - It does NOT enable global, local or nearby discovery.
    - It amends no FROZEN PRD and no Rank 1-5 artefact.
    - It mints no IMPL-* identifier and creates no implementation task.
-->

# PRD-021B — PART B6

## Global vs Library Discovery — Scope Definition

### Specification v0.1 — Stage 2 (Draft)

> ⚠ **DRAFT — NOT FROZEN, NOT FINAL, NOT APPROVED.** Stage 3 and Stage 4 have
> **not** been entered.
>
> ⭐ **B6 owns scope DEFINITION only.** It defines and clamps; it does not
> discover, filter people, rank, recommend or store.

---

## §0. Document control

### §0.1 Status header

| Field | Value |
|---|---|
| Document | `PRD-021B` Part B6 — Global vs Library Discovery Scope |
| Version | **v0.1** |
| Status | **DRAFT** |
| Lifecycle stage | **Stage 2 (Draft)** — Stage 3 / Stage 4 NOT entered |
| Architectural form | **Policy / scope definition** — ⛔ **not** a bounded context, ⛔ not a store |
| V1 scope values | **`LIBRARY` = ON** · `GLOBAL` = **OFF** · `LOCAL` = **OFF** · `NEARBY` = **OFF** |
| Contexts referenced | `BC-19` (tenancy) · `BC-10` (global identity) · `BC-02` (membership via `E-02`) · `BC-25` (configuration via `E-19`) |
| Context count | **31** — unchanged |
| Edges created | **0** · Events minted | **0** |
| Freeze | ⛔ **NOT FROZEN** |
| Open items | `XPB-CONF-005` (part identifier), `GLS-GAP-001`…`003` — all **OPEN** with owners |

### §0.2 Identifier registers — declared up front, with ranges

| Register | Meaning | Range | Count |
|---|---|---|---|
| `GLS-FR-nnn` | Functional requirement | `001`–`011` | **11** |
| `GLS-BR-nnn` | Business rule | `001`–`008` | **8** |
| `GLS-DEF-nnn` | Scope definition | `001`–`006` | **6** |
| `GLS-INV-nnn` | Invariant | `001`–`006` | **6** |
| `GLS-CFG-nnn` | Configurable — default **and** range | `001`–`005` | **5** |
| `GLS-SEC-nnn` | Security rule | `001`–`005` | **5** |
| `GLS-FUT-nnn` | Future-architecture statement (⛔ not enabled) | `001`–`008` | **8** |
| `GLS-EC-nnn` | Edge case | `001`–`010` | **10** |
| `GLS-XC-nnn` | Explicit exclusion (what must be impossible) | `001`–`014` | **14** |
| `GLS-SCOPE-nnn` | V1 / Future scope statement | `001`–`004` | **4** |
| `GLS-AC-nnn` | Acceptance criterion (GWT) | `001`–`020` | **20** |
| `GLS-GAP-nnn` | Disclosed gap — OPEN, with owner | `001`–`003` | **3** |
| **Total** | | | **100** |

Ranges contiguous `001..max` — **measured, not asserted**.
⛔ No `IMPL-*` identifier minted.

### §0.3 Prefix collision — executed before writing

`GLS-` measured **0** occurrences across `docs/` prior to authoring.
⚠ `SCP-` was **rejected** (1 measured occurrence); `DSC-` rejected as
ambiguous against `SDS-`/`DRK-`.

### §0.4 Normative language

**MUST**/**MUST NOT** absolute · **SHOULD**/**SHOULD NOT** strong · **MAY**
optional · ⛔ prohibition · ⚠ disclosed defect/gap/risk · ⭐ load-bearing.

---

## §B6.1 ⭐ `XPB-CONF-005` — B6 is a new part identifier

| Field | Value |
|---|---|
| **Measurement** | `grep -rl "Part B6" docs/` → **0 files**. `B6` → **0** occurrences in `docs/30-product/social-graph/` |
| **The point** | B0 `FOD-4` names **B4, B5, B7, B8, B9** — ⛔ **not B6.** B4 and B5 were at least *disclosed as undefined*; B6 was never mentioned anywhere |
| **Authority** | `PRD_REGISTRY.md` §12.1 registers parts **B0–B3** only. §11.3/§11.4 recognise `PRD-021A` parts **A1–A8** only |
| **Disposition** | B6 is authored as a **Stage-2 draft** on the same §2 entry-evidence basis B0–B3 used (*"a document on disk with a version header"*). ⛔ **No allocation act is claimed** and no registry §11-style allocation is asserted |
| **Owner** | **Governance Owner** |
| **Status** | ⛔ **OPEN** — `GLS-GAP-001`; ⚠ `FOD-4` should be **extended** to name B6, which is an **authoring** correction to B0 and is **not applied here** (B0 is a Stage-3/4-passed subject) |
| **Blocks authoring?** | ⛔ No |
| **Blocks release?** | ⚠ Registration only |

---

## §B6.2 ⭐ The scope enum — closed, server-side, four values

`GLS-DEF-001` — **`DiscoveryScope`** is a **closed enum** with exactly four
values: **`LIBRARY`**, **`GLOBAL`**, **`LOCAL`**, **`NEARBY`**.
`GLS-DEF-002` — ⛔ The enum **MUST NOT** be extended without an architecture
decision. Precedent: BC Map §15.5's closed `PUBLIC`/`PRIVATE` visibility enum and
closed role set.

| Value | Meaning | V1 | Authority |
|---|---|---|---|
| `GLS-DEF-003` **`LIBRARY`** | Candidates limited to people holding a valid membership in the **viewer's own library** | ✅ **ON** | EA **L926** `Student Discovery (V1)`; **L927** `Search Students (V1)` |
| `GLS-DEF-004` **`GLOBAL`** | Candidates from the whole platform, unrestricted by library | ⛔ **OFF** | ⚠ **0** repository lines authorise global student discovery. Measured |
| `GLS-DEF-005` **`LOCAL`** | Candidates from libraries within an administrative or geographic region | ⛔ **OFF** | ⚠ **0** repository lines. No region model measured |
| `GLS-DEF-006` **`NEARBY`** | Candidates by device geographic proximity | ⛔ **OFF** | EA **L929** `Nearby Students (V2)` |

`GLS-FR-001` — B6 **MUST** supply exactly one `DiscoveryScope` value per
discovery or recommendation request.
`GLS-FR-002` — ⭐ In V1 the value **MUST** be **`LIBRARY`**, always, for every
request, for every viewer, on every surface.
`GLS-FR-003` — `GLOBAL`, `LOCAL` and `NEARBY` **MUST** be rejected in V1 with a
server-side refusal. ⛔ **MUST NOT** be silently downgraded to `LIBRARY` — a
silent downgrade hides a caller defect.
`GLS-FR-004` — B3, B4 and B5 **MUST** obtain scope from B6 and **MUST** treat it
as an input, never a parameter they choose.

---

## §B6.3 ⭐ The global-identity / library-membership separation

> ⚠ **This is the reason B6 exists as a separate part rather than a paragraph in
> B3.**

| | **Global social identity** | **Library membership** |
|---|---|---|
| Owner | **`BC-10`** Global Person Identity, rank **7.5** | **`BC-02`** Membership |
| Key | `PersonId` | `StudentRecordId` + `tenantId` |
| Tenancy | **Global.** *"No `tenantId`"* — BC Map **L488** | **Tenant-scoped** — `MP-GBR-08` |
| Rule | `ID-2`: *"Must never receive a `StudentRecordId` or `tenantId`"* | `X-13` forbids untenanted access |
| Relation | `X-05` **Separate Ways** | |

`GLS-INV-001` — ⭐ **The social graph stays global; the scope filter is
tenant-side.** A library-scoped discovery result is produced by **filtering a
global candidate set with a tenant-side membership predicate** — ⛔ never by
introducing a `tenantId` into `BC-11`.
`GLS-INV-002` — ⛔ **It MUST be IMPOSSIBLE for a `tenantId` or `StudentRecordId`
to enter any context in the `BC-11`..`BC-17` Student Network residency band.**
Authority: `ID-2` (BC Map **L488**); CI
`banned_symbols` (`tool/module_dependencies.yaml` **L268-270**) makes it a
**build failure**, not a review finding.
`GLS-INV-003` — ⛔ It **MUST be IMPOSSIBLE** for a scope value to be interpreted
as a tenant identifier. `DiscoveryScope` is a **policy enum**, not a tenant key.
`GLS-INV-004` — ⭐ Because the membership predicate is `studentRecordId`-keyed,
the component that evaluates it **MUST** sit **tenant-side**, not in
`domain/social`. Authority: B3 `SDS-XC-002`; CI **L265** bans
`domain/library/**` from social.
`GLS-INV-005` — ⛔ Scope **MUST NOT** be enforced by `BC-11` — `BC-11` cannot
know a library. Enforcement belongs to the tenant-side composition.
`GLS-INV-006` — ⛔ It **MUST be IMPOSSIBLE** for a `LIBRARY`-scoped result to
contain a person without valid membership in the **viewer's** library.
Authority: B3 `SDS-BR-012` cross-library isolation; `E-02` `MembershipValidity`.

`GLS-BR-001` — ⚠ **An honest consequence, stated rather than hidden:** because
`BC-11` is global and the filter is tenant-side, a person may exist in the global
graph, be a lawful friend of the viewer, and still be **absent** from
`LIBRARY`-scoped discovery. That is **correct**, not a defect: friendship is
global (`BC-11`), discoverability is library-scoped (V1).
`GLS-BR-002` — ⛔ B6 **MUST NOT** resolve that asymmetry by widening scope. B1's
friend list is a different surface with a different owner.

---

## §B6.4 Scope enforcement

`GLS-FR-005` — Scope **MUST** be resolved server-side **before** candidate
generation.
`GLS-FR-006` — ⭐ Scope **MUST** be applied as part of the **eligibility** stage
(step [1]), i.e. **before** privacy [2], safety [3], relevance [4] and ordering
[5]. Authority: **FROZEN** `TSF-INV-005` pipeline order.
`GLS-FR-007` — ⛔ Scope **MUST NOT** be applied after ranking. A post-ranking
scope filter would produce short pages and leak set size — the same failure class
B5 `PYK-BR-003` forbids for suppression.
`GLS-FR-008` — A request whose resolved scope is unavailable **MUST** fail
closed: return **empty**, ⛔ never unscoped.

`GLS-SEC-001` — ⭐ ⛔ **It MUST be IMPOSSIBLE for a client to supply, widen,
override or infer the scope.** Scope is server-derived from the authenticated
viewer's membership. Authority: `MP-GBR-08`; B3 `SDS-SEC-003` (rejects a
client-supplied `tenantId`).
`GLS-SEC-002` — A request carrying a scope parameter **MUST** be **rejected**,
not ignored. ⚠ Ignoring teaches a client the parameter is harmless.
`GLS-SEC-003` — ⛔ Scope **MUST NOT** be encoded in a cursor, page token, URL
path, query string or client-visible header. Authority: `PG-1`…`PG-4`; B3
`SDS-API-002`.
`GLS-SEC-004` — ⛔ A scope refusal **MUST NOT** disclose whether the wider scope
exists, is disabled, or is unauthorised for this viewer. Authority: `MP-GBR-22`
(*"a denial must not disclose existence"*); **FROZEN** `TSF-FR-024`.
`GLS-SEC-005` — ⛔ Scope **MUST NOT** be cached across viewers. A per-viewer
cache **MUST** be invalidated on any membership change.

`GLS-BR-003` — Scope resolution **MUST** be audited via **`E-20`** to `BC-24`
(BC Map **L329**). ⭐ Existing edge; ⛔ none created.
`GLS-BR-004` — ⛔ Audit records **MUST NOT** contain profile content
(precedent: B1 `SGR-FR-024`).

---

## §B6.5 Configuration — default **and** range

| ID | Configurable | Default | Range | Owner |
|---|---|---|---|---|
| `GLS-CFG-001` | `scope.libraryEnabled` | **`true`** | `{true,false}` | `BC-25` via `E-19` |
| `GLS-CFG-002` | ⭐ `scope.globalEnabled` | **`false`** | `{true,false}` | `BC-25`; ⛔ **MUST** stay `false` until `GLS-GAP-002` closes |
| `GLS-CFG-003` | `scope.localEnabled` | **`false`** | `{true,false}` | `BC-25`; ⛔ same |
| `GLS-CFG-004` | `scope.nearbyEnabled` | **`false`** | `{true,false}` | `BC-25`; ⛔ V2 (EA **L929**) |
| `GLS-CFG-005` | `scope.defaultValue` | `LIBRARY` | enum of the four values | `BC-25` |

`GLS-BR-005` — ⛔ A configuration enabling `GLOBAL`, `LOCAL` or `NEARBY`
**MUST** be **rejected at load** while the corresponding architecture gap is
OPEN. ⚠ ⛔ It **MUST NOT** be accepted-and-ignored: an accepted-but-inert flag is
how a scope leak ships.
`GLS-BR-006` — ⛔ Configuration **MUST NOT** be client-supplied
(`GLS-SEC-001`).
`GLS-BR-007` — ⛔ B6 **MUST NOT** define a configuration store or flag
mechanism. Owner: `BC-25` (BC Map **L134**).
`GLS-BR-008` — ⛔ A feature flag **MUST NOT** be the **only** control on scope.
`GLS-INV-002` and the CI banned symbols **MUST** hold even if a flag is
mis-set. ⭐ Defence in depth: a flag is a product control, `ID-2` is an
architecture guarantee.

---

## §B6.6 Future global discovery architecture — ⛔ defined, NOT enabled

> ⭐ **Purpose:** so that a future global capability is designed **once, in
> advance**, rather than improvised under delivery pressure. ⛔ **Nothing in this
> section is enabled, authorised or scheduled.**

`GLS-FUT-001` — A future `GLOBAL` scope **MUST** be built on `BC-10`'s global
`PersonId` space, ⛔ never by federating tenant data. Authority: `ID-2`, `X-05`.
`GLS-FUT-002` — It **MUST NOT** require a `tenantId` anywhere in the
**`BC-11`..`BC-17` Student Network residency band**.
⭐ Any global design that needs one is **wrong by construction**.
`GLS-FUT-003` — It **MUST** reuse `BC-23`'s permission-aware index via **`E-21`**
(BC Map **L330**). ⚠ Measured: `E-21` reads `BC-01, BC-10 → BC-23` — `BC-11` is
**not** a consumer, and `E-22` **L331** records that *"`BC-11` and `BC-13` are
deliberately NOT consumers."* So a global surface driven by `BC-11` would need an
**ADR**, exactly as BC Map §7 **L292** requires. ⛔ Not created here.
`GLS-FUT-004` — It **MUST** apply the same pipeline order — eligibility, privacy,
safety, relevance, ordering. **FROZEN** `TSF-INV-005` does not weaken at global
scale.
`GLS-FUT-005` — It **MUST** treat `BC-10` privacy as the authority, with
*"privacy default = most restrictive"* and *"minors cannot set profile to
public"* (BC Map **L376**). ⭐ Global discovery of minors is the sharpest risk
this platform has; ⚠ any future global design **MUST** be reviewed against
`MP-RSK-01` before a wave decision.
`GLS-FUT-006` — It **MUST** be independently disableable per tenant and
platform-wide, and **MUST** default to OFF on rollout.
`GLS-FUT-007` — `LOCAL` **MUST NOT** be implemented before a region model
exists. ⚠ Measured: **0** region or locality model in `docs/10-architecture/`
→ `GLS-GAP-003`.
`GLS-FUT-008` — `NEARBY` **MUST NOT** be implemented before a location-privacy
decision exists. ⚠ **0** location-consent model measured. `Nearby Students` is
**V2** (EA **L929**).

`GLS-XC-001` — ⛔ **It MUST be IMPOSSIBLE to enable `GLOBAL` in V1**, including
by configuration, feature flag, admin override, migration, test hook or
environment variable.
`GLS-XC-002` — ⛔ Same for `LOCAL`.
`GLS-XC-003` — ⛔ Same for `NEARBY`.
`GLS-XC-004` — ⛔ B6 **MUST NOT** introduce a global search index, a global
candidate cache or a cross-tenant projection.
`GLS-XC-005` — ⛔ B6 **MUST NOT** create a cross-library or cross-tenant read
path. Authority: `X-13` forbidden edge; `MP-GBR-08`; `MP-RSK-01` rates a
cross-tenant leak **Critical**.
`GLS-XC-006` — ⛔ B6 **MUST NOT** grant `BC-11` access to library data, nor
library modules access to `BC-11` internals. `X-05` holds in **both**
directions.

---

## §B6.7 What B6 does not own

`GLS-XC-007` — ⛔ **Candidate generation.** Owner: `BC-23` (B3 `SDS-BR-015`).
`GLS-XC-008` — ⛔ **Eligibility, privacy and safety filtering of people.**
Owners: `BC-11`, `BC-10`, `BC-13` (**FROZEN** `PRD-020` §8.3).
`GLS-XC-009` — ⛔ **Ranking and ordering.** Owners: `BC-23` step [4]; B4 step [5].
`GLS-XC-010` — ⛔ **Recommendation generation, feedback, suppression.** Owner: B5.
`GLS-XC-011` — ⛔ **Relationships.** Owner: `BC-11` via B1.
`GLS-XC-012` — ⛔ **Membership.** Owner: `BC-02`. B6 **consumes** validity via
`E-02`; ⛔ it never decides membership.
`GLS-XC-013` — ⛔ **Tenancy.** Owner: `BC-19` (BC Map **L271**). B6 defines a
**discovery-scope policy**, ⛔ not a tenancy model.
`GLS-XC-014` — ⛔ **Authorisation.** Owner: `BC-18` (`X-13`).

`GLS-FR-009` — B6's entire output surface is: **one scope value, plus a refusal
reason code that discloses nothing** (`GLS-SEC-004`).
`GLS-FR-010` — ⛔ B6 **MUST NOT** persist state. It is a pure policy function of
(authenticated viewer, configuration).
`GLS-FR-011` — ⛔ B6 **MUST NOT** hold an aggregate, an invariant over stored
data, or a business entity.

---

## §B6.8 Scope statements

| ID | Statement | Wave | Authority |
|---|---|---|---|
| `GLS-SCOPE-001` | `LIBRARY` scope, enforced server-side | **V1** | EA **L926**, **L927** |
| `GLS-SCOPE-002` | `NEARBY` scope | **V2** | EA **L929** |
| `GLS-SCOPE-003` | `GLOBAL` scope | ⏸ **Future — unauthorised** | **0** authorising lines; `GLS-GAP-002` |
| `GLS-SCOPE-004` | `LOCAL` scope | ⏸ **Future — no region model** | `GLS-GAP-003` |

---

## §B6.9 Edge cases

| ID | Case | Required behaviour |
|---|---|---|
| `GLS-EC-001` | Viewer holds no valid membership | Scope resolution fails closed; empty result; ⛔ no disclosure (`GLS-FR-008`) |
| `GLS-EC-002` | Viewer holds memberships in **two** libraries | ⚠ **Not specified** → `GLS-GAP-002` companion. ⛔ **MUST NOT** union them by default; ⛔ **MUST NOT** pick arbitrarily. **MUST** fail closed until decided |
| `GLS-EC-003` | Client sends `scope=GLOBAL` | Reject (`GLS-SEC-002`); ⛔ no silent downgrade (`GLS-FR-003`) |
| `GLS-EC-004` | Configuration sets `globalEnabled=true` | Reject configuration at load (`GLS-BR-005`) |
| `GLS-EC-005` | Membership expires mid-session | Next resolution fails closed; per-viewer cache invalidated (`GLS-SEC-005`) |
| `GLS-EC-006` | Membership frozen (`FreezeWindow`) | ⚠ **Not specified here** — `MembershipValidity` semantics are `BC-02`'s (`MM-FR-066`). B6 **MUST** use `BC-02`'s answer, ⛔ never its own |
| `GLS-EC-007` | `BC-02` unavailable | Fail closed; empty; ⛔ never unscoped |
| `GLS-EC-008` | `BC-25` unavailable | Use the **defaults** in §B6.5, which are `LIBRARY`-only — ⛔ fail-safe, never fail-open |
| `GLS-EC-009` | Cursor from a previous scope replayed | Reject the cursor; ⛔ **MUST NOT** honour a scope embedded in it (`GLS-SEC-003`) |
| `GLS-EC-010` | Viewer's library is deactivated | Fail closed; ⛔ no fallback to a wider scope |

---

## §B6.10 Acceptance criteria — 20, all GWT, all mapped

| ID | Given | When | Then (measurable) | Requirement |
|---|---|---|---|---|
| `GLS-AC-001` | Any V1 discovery request | Scope is resolved | Resolved value is exactly `LIBRARY` | `GLS-FR-002` |
| `GLS-AC-002` | A client sends `scope=GLOBAL` | Request received | Rejected; ⛔ not downgraded to `LIBRARY` | `GLS-FR-003`, `GLS-SEC-002` |
| `GLS-AC-003` | A client sends `scope=NEARBY` | Request received | Rejected | `GLS-FR-003` |
| `GLS-AC-004` | Configuration with `globalEnabled=true` | Loaded | Rejected at load; ⛔ not accepted-and-ignored | `GLS-BR-005`, `GLS-EC-004` |
| `GLS-AC-005` | A `LIBRARY`-scoped result | Every candidate checked against `E-02` | 100% hold valid membership in the **viewer's** library | `GLS-INV-006` |
| `GLS-AC-006` | Any social-side call in the scope path | Payload inspected | ⛔ Contains no `tenantId` and no `StudentRecordId` | `GLS-INV-002` |
| `GLS-AC-007` | The `domain/social` module | CI boundary check run | ⛔ 0 violations of `banned_symbols` introduced by B6 | `GLS-INV-002`, `GLS-BR-008` |
| `GLS-AC-008` | A scope refusal response | Inspected | ⛔ Discloses neither existence nor availability of the wider scope | `GLS-SEC-004` |
| `GLS-AC-009` | A page cursor | Decoded | ⛔ Contains no scope value | `GLS-SEC-003`, `GLS-EC-009` |
| `GLS-AC-010` | `BC-25` unavailable | Scope resolved | Defaults applied: `LIBRARY` only, all others OFF | `GLS-EC-008` |
| `GLS-AC-011` | `BC-02` unavailable | Scope resolved | Empty result; ⛔ never unscoped | `GLS-EC-007`, `GLS-FR-008` |
| `GLS-AC-012` | Viewer with no valid membership | Discovery requested | Empty; ⛔ no membership state disclosed | `GLS-EC-001` |
| `GLS-AC-013` | ⚠ Viewer with two library memberships | Scope resolved | Fails closed; ⛔ no union and no arbitrary pick | `GLS-EC-002` |
| `GLS-AC-014` | Membership expires mid-session | Next request | Fails closed; cache invalidated | `GLS-EC-005`, `GLS-SEC-005` |
| `GLS-AC-015` | Scope is resolved | Ordering pipeline traced | Scope applied at step [1], **before** privacy, safety, relevance and ordering | `GLS-FR-006`, `GLS-FR-007` |
| `GLS-AC-016` | Scope resolution occurs | `BC-24` inspected | Audit record arrived via `E-20`; ⛔ contains no profile content | `GLS-BR-003`, `GLS-BR-004` |
| `GLS-AC-017` | The repository is searched for a global index | Inspected | ⛔ B6 introduced no global index, cache or cross-tenant projection | `GLS-XC-004`, `GLS-XC-005` |
| `GLS-AC-018` | A friend outside the viewer's library | `LIBRARY` discovery run | They are absent, and the friend list still shows them | `GLS-BR-001`, `GLS-BR-002` |
| `GLS-AC-019` | B6's implementation | Inspected | ⛔ Holds no aggregate, no store and no persisted state | `GLS-FR-010`, `GLS-FR-011` |
| `GLS-AC-020` | ⚠ `GLS-GAP-002` is OPEN | Global scope is attempted by any means | Impossible: rejected by configuration **and** by `ID-2`/CI | `GLS-XC-001`, `GLS-BR-008` |

⭐ **20 ACs · 20 map to a requirement · 0 orphans.**
⚠ `GLS-AC-013` and `GLS-AC-020` assert **fail-closed** behaviour for the two
genuinely undecided cases, rather than asserting a capability.

---

## §B6.11 Disclosed gaps — OPEN, each with an owner

| ID | Gap | Blocks authoring? | Blocks release? | Owner |
|---|---|---|---|---|
| `GLS-GAP-001` | ⭐ `XPB-CONF-005` — B6 is a part identifier no repository document recognises; `FOD-4` does not name it | ⛔ No | ⚠ Registration only | **Governance Owner** |
| `GLS-GAP-002` | ⭐ Multi-library viewer semantics (`GLS-EC-002`) **and** global-scope authorisation both undecided. ⚠ Note `E-21`/`E-22` show `BC-11` is deliberately **not** a `BC-23` consumer, so a `BC-11`-driven global surface needs an **ADR** | ⛔ No | ✅ **Yes** for `GLOBAL`; ⚠ multi-library viewers fail closed meanwhile | **ARB + Architecture Owner** |
| `GLS-GAP-003` | No region/locality model exists (**0** measured), so `LOCAL` cannot be specified | ⛔ No | ⛔ No — refused | **Architecture Owner** |

---

## §B6.12 What B6 does **not** do

⛔ Creates no bounded context (**31**) · ⛔ creates no edge · ⛔ mints no event ·
⛔ mints no `PERM-*` · ⛔ mints no `IMPL-*` · ⛔ creates no aggregate or store ·
⛔ enables `GLOBAL`, `LOCAL` or `NEARBY` · ⛔ generates candidates · ⛔ filters
people · ⛔ ranks · ⛔ recommends · ⛔ decides membership, tenancy or
authorisation · ⛔ amends any frozen PRD or Rank 1–5 artefact · ⛔ modifies a CI
rule · ⛔ creates an ADR · ⛔ resolves `GLS-GAP-001`…`003` · ⛔ modifies any
B0/B1/B2/B3/B4/B5 requirement · ⛔ claims Stage 3 or Stage 4 · ⛔ writes
application code.

---

## §B6.13 Status

> ## `PRD-021B` Part B6 STATUS: **DRAFT / STAGE 2**

⛔ **NOT** Stage 3. ⛔ **NOT** Stage 4. ⛔ **NOT** `APPROVED`. ⛔ **NOT**
`FROZEN`. ⛔ **NOT** implementation-ready.

**V1 posture, restated for the avoidance of doubt:**
**`LIBRARY` = ON · `GLOBAL` = OFF · `LOCAL` = OFF · `NEARBY` = OFF.**

**Exact next step: Stage 3 — Architecture Review.**

---

**END — `PRD-021B` Part B6 v0.1 — DRAFT / Stage 2.**
