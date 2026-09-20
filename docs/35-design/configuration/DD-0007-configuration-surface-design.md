<!-- LIBOORA Design Doc | DD-0007 | BC-25 Configuration -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, configuration
> parameters or backend contracts.

# `DD-0007` — Configuration surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0007` |
| **Version** | ⭐ **v0.5** — ⭐⭐ **Authorization coverage 39 / 104 → 49 / 104** by recording `Accepted` **[`ADR-0154`](../../00-governance/adr/ADR-0154-app-3-read-only-bc-25-configuration-surface-and-cfg-platform-default-read-allocation.md)** *(10 `CFG-*`, `READ` = `PR-1` + `PR-2`)*. ⭐⭐ **D1 RESTATED — APP 2 + APP 3 (read-only)**; ⭐⭐ **D5 RE-DECLARED as a POSITIVE cross-app dependency**, ⛔ the v0.3 *"measured NEGATIVE"* being **void**. ⚠️⚠️ **D3 REMAINS `PARTIAL`** — ⛔ **104/104 is NOT claimed** and **55** stay `NOT YET AUTHORIZED`; ⛔ **7 `ATT-CFG-*` + `CFG-10` + `CFG-12` held**. ⛔ `CNF-GAP-002` / `CNF-GAP-007` **still OPEN, Stage 6** *(prior: **v0.4** — coverage 22 → 39)* |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-25` Configuration** `[GENERIC]` — **FOUNDATIONAL** band (BC Map **L271**), **V1** |
| **Subject PRD** | `PRD-023` Settings & Configuration — **`FROZEN` v0.1**, Rank 3, admitted 2026-08-20 by `ACCEPTED` `ADR-0053` under `BASELINE-2026-08-20-A`. **180 identifiers / 8 registers / 113 obligation-bearing** |
| ⭐⭐ **Governing authorization authority** | **`ADR-0151`** *(Rank 2, **Accepted** — 22)* **+ ⭐ `ADR-0153`** *(Rank 2, **Accepted** — 17 `ATT-CFG-*`)* **+ ⭐ `ADR-0154`** *(Rank 2, **Accepted** — 10 `CFG-*`)* — together the **only** operation×role sources for any `BC-25` parameter. ⛔ They cover **49 of 104**; ⛔ the other **55 are NOT authorized** |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Purpose** | Specify the `BC-25` configuration surfaces precisely enough that a Figma prototype or Flutter implementation could be built **without inventing UX, parameters, roles or authority** |
| **Verdict** | ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS** — §26. ⛔ **The Figma gate is NOT OPEN** (§25) |

---

## 1. Document identity

### 1.1 What this document does

It specifies the **presentation and interaction behaviour** of the configuration
surfaces `PRD-023` §12 requires, at the fidelity an implementer needs in order
to build **without guessing**.

### 1.2 ⛔ What this document does NOT do

⛔ It does not amend `PRD-023`, `PRD-002`, `PRD-005`, `PRD-001` or
`CONFIGURATION_GUIDE.md`. ⛔ It does not create a parameter, a role, an action
class, a scope class, a `PERM-*` identifier or an authorization model.
⛔ It does not authorize the 65 unallocated parameters. ⛔ It does not prescribe
database schema, API shape, event contracts or implementation internals.
⛔ It confers no status on itself.

### 1.3 ⭐⭐ Why `BC-25` is designable — and the requirement that gates everything

`PRD-023` **§12 is titled *"UI/UX requirements"*** — the first PRD in this design
chain with an explicit surface chapter. Its preamble states the case:

> *"Configuration is one of the few capabilities where the UI **is** the feature.
> A hierarchy that resolves correctly but renders as a flat form has not
> delivered `ADR-0017` §3.1 item 1 — the user cannot see whether a value is
> inherited or set, and therefore cannot reason about what changing it will do."*

| Surface-affecting evidence in `PRD-023` | Measured |
|---|---|
| §12.1 surface requirements | ⭐ **7** — `CNF-FR-076`…`CNF-FR-082` |
| §12.2 required components | ⭐ **6**, each with a driving requirement |
| §3 hierarchy | ⭐ **5** scopes, precedence fixed (`CNF-FR-009`, `CNF-FR-010`) |
| §4.5 failure modes | ⭐ stated *"so they can be tested"* |
| §13 acceptance criteria | ⭐ **59** `CNF-AC-*` |
| Literal `UI` occurrences | **16** *(word-anchored **14**)* — ⚠️ the **highest** of the seven contexts designed so far |

⭐⭐ **The gating requirement is `CNF-FR-081`**, and it is why this design could
not be written before `ADR-0151`:

> *"A parameter the current actor may read but not write (`CNF-BR-010`) **SHALL**
> be presented as **read-only**, not hidden and not presented as
> editable-then-refused."*

⛔ Rendering *any* parameter row requires knowing, per parameter and per role,
whether it is writable, readable-only, or absent. ⛔ Before `ADR-0151` that was
unknown for **all 104**. ⭐ It is now known for **22**, which is exactly the set
this document can design.

---

## 2. Governance gate — verified before authoring

⭐ Each row was measured in this repository at HEAD `30dfcc2`, not assumed.

| # | Gate | Evidence | Verdict |
|---|---|---|---|
| 1 | **`BC-25` is owned by `PRD-023`** | `PRD_OWNERSHIP_MODEL.md` **L205** *(`PRD-023` → `BC-25`, Product Owner, ARB)*; **L215** *(`BC-25` → **`PRD-023`**, `ADR-0017` **Accepted**)* | ⭐ **PASS** |
| 2 | **`PRD-023` is sufficiently frozen** | `Status` = **`FROZEN`** (`ADR-0053`, `BASELINE-2026-08-20-A`); Stage 7 **PASSED**; Rank 3 | ⭐ **PASS** |
| 3 | **README §2A/§2B permits creation** | §2A.3 discriminator — *"a Design Doc can only be written where a frozen PRD actually fixes surface requirements"* — satisfied by §12 (§1.3) | ⭐ **PASS** |
| 4 | **`DD-0007` is the next lawful number** | README §3 **L440**: *"the next Design Doc is **`DD-0007`**"*; measured **0** files named `DD-0007*` | ⭐ **PASS** |
| 5 | **No existing `DD-0007` elsewhere** | `find docs -iname 'DD-0007*'` → **0**. The 6 textual hits are all forward references *(README L440; `ADR-0151` ×5)* | ⭐ **PASS** |
| 6 | **Title / path are convention-backed** | README §3 pattern `DD-NNNN-short-kebab-title.md`; §2 *"Organised by bounded context / module"*, *"New contexts get a new subdirectory when a Design Doc for them is actually written"* — the `analytics/` precedent, created with `DD-0006` | ⭐ **PASS** |

⭐ **Path:** `docs/35-design/configuration/DD-0007-configuration-surface-design.md`
⭐ `configuration/` is the **EIGHTH** context directory, created **at the moment
this document was written**, exactly as README §2 prescribes and `analytics/`
precedents.

⚠️ **`PRD-023` lives at `docs/30-product/configuration/`, so `configuration/` is
the directory name the repository already uses for this context** — ⛔ the name is
taken from existing practice, not chosen.

---

## 3. Source of truth

| Rank | Document | What is consumed |
|---:|---|---|
| 1 | `MASTER_PRD.md` | `MP-NFR-06` *(mobile-first, portrait-optimised)*; `MP-NFR-08` *(WCAG-aligned, owner = UI Design System)*; `MP-GBR-06`…`09`; `MP-CON-11` |
| 2 | ⭐⭐ **`ADR-0151`** | **The authorization allocation — 22 parameters.** §2.3 matrix; §3.5 platform-default vacuity; §5 `LCFG-1` conflict; §6 `CNF-D-1`/`CNF-D-2`; §7 non-closure |
| 2 | `ADR-0017` | `BC-25` ownership; §3.1's six owned items; §3.2 exclusions |
| 2 | `ADR-0132` | `AUTH-7.22` audited at **zero** enumerated permissions |
| 2 | `ADR-0053` | `PRD-023` v0.1 baseline / freeze |
| 3 | ⭐ **`PRD-023`** | **The subject.** §3 hierarchy · §4 `E-19` · §8 audit · §9 authority · §10 isolation · §11 observability · **§12 UI/UX** · §13 `CNF-AC-*` · §14 gaps |
| 3 | `PRD-001` Authentication v2.0 | `TR-1`…`TR-5`, `PR-1`, `PR-2`; `AUTH-2.5`, `AUTH-2.9`; `AC-7.8`; `AP-3`, `AP-4` |
| 3 | `PRD-002` Library v1.1 | `LCFG-1`…`LCFG-13` definitions; `LIB-16.1`…`16.9`; `LIB-12.4` |
| 3 | `PRD-005` Membership v1.6 | `MM-CFG-001`…`009` (§13.4); `MM-BR-026` |
| ⛔ **Unranked** | `PRD-012a` Part 2 *(`DRAFT`)* | `SECP-HRO-005`; `SECP-BR-004` closure rule. ⚠️ **Unranked — `MUST NOT` be cited as authority against any ranked document** (its own header); see §5.3 |
| 2 | ⭐⭐ **`ADR-0152`** | **The platform-configuration boundary.** `SECP-HRO-005` is a **governance / change-control act**; ⛔ **0** APP 3 runtime configuration **write** paths. ⚠️ Its §7 *"surface"* limb and §8.5 are **superseded IN PART and IN EFFECT ONLY** by `ADR-0154` §4.3 — ⛔ `ADR-0152` itself is **byte-unchanged** and remains **`Accepted`** |
| 2 | ⭐⭐ **`ADR-0154`** | **The APP 3 read-only boundary and the `CFG-*` allocation.** APP 3 **may** hold a **read-only** `BC-25` surface for `PR-1`/`PR-2`; ⛔ **no write path**. Allocates **10** `CFG-*` |
| 4 | BC Map v1.11 | **L134** `BC-25` row; **L271** FOUNDATIONAL band; **L328** `E-19`; **L331** `E-22` |
| 7 | `CONFIGURATION_GUIDE.md` v1.2 | §2/§2A/§2B registers; §3 `INV-1`…`INV-16`; §4 profiles + **L829**; §5 change control; §6 observability |
| — | `DD-0001`…`DD-0006` | Structure, verdict vocabulary, state/loading patterns, App-Boundary QA |
| — | `lib/app/shared/` | Existing Flutter design system (§10) |

---

## 4. Configuration taxonomy

⭐ Reproduced from `PRD-023` §2 — ⛔ **cited, not redefined.**

| Term | `PRD-023` meaning | Design consequence |
|---|---|---|
| **Setting** | A value a tenant may change | ⭐ Renders as an **editable or read-only row** |
| **Configuration** | A value fixed by deployment | ⛔ **Never** renders as editable |
| **Effective value** | The single value resolution produces | ⭐ *"**derived**, never stored"* (`CNF-INV-004`) — ⛔ the UI must never imply it is stored at the shown scope |
| **Override** | A value set at a scope, displacing a weaker one | ⭐ `CNF-FR-076` — **MUST** be visually distinct from inherited |
| **Parameter** | A registered key owned by a PRD | ⛔ `CNF-FR-030` — one absent from the register **MUST NOT** be served |

---

## 5. APP + ROLE BOUNDARY

⭐ Per README §2B.3, all five declarations are stated. ⭐ **Four are `PASS`.**
⚠️⚠️ **Declaration 3 is `PARTIAL` and is reported as such — ⛔ NOT rounded to
PASS**: `ADR-0151` *(22)*, `ADR-0153` *(17)* and `ADR-0154` *(10)* cover
**49 of 104**, and ⛔ the other **55 remain `NOT YET AUTHORIZED`**.

| # | Declaration | Value | Verdict |
|---|---|---|---|
| **1** | **Target App** | ⭐⭐ **A JUSTIFIED TWO-APP SET** *(README §2B.3 D1: "APP 1, APP 2, APP 3, **or an explicit, justified set**")* — ⭐ **APP 2 — Library App** for `TR-1`/`TR-2`/`TR-3` *(read **and** write)*; ⭐ **APP 3 — Platform Admin** for `PR-1`/`PR-2` *(**READ-ONLY**)*. ⛔ **APP 1 = 0 surfaces.** ⛔ **APP 3 = 0 *writable* surfaces** — `Accepted` **`ADR-0154`** `D-2`/`D-4`, §5.3 | ⭐ **PASS** |
| **2** | **Target Roles** | ⭐ `TR-1` Owner · `TR-2` Manager · `TR-3` Reception — all `PRD-001` v2.0 §2.4. ⛔ `TR-4`/`TR-5` **excluded**, §5.2 | ⭐ **PASS** |
| **3** | **Permission Scope** | ⭐ **`ADR-0151` §2.3** *(22)* **+ ⭐ `ADR-0153` §2.3** *(17 `ATT-CFG-*`)* **+ ⭐ `ADR-0154` §2.5** *(10 `CFG-*`, **READ-only** to `PR-1`/`PR-2`)* — the operation×role sources. ⚠️ **PARTIAL: 49 of 104 parameters**; ⛔ the other **55 are NOT authorized** and ⛔ **MUST NOT** be rendered | ⚠️ **PARTIAL** |
| **4** | **Tenant / Library / Platform scope** | ⭐ `Tenant` **10 + 17** · `Library` **8** · `Platform default` **4 + 10** (`ADR-0151` §2.3; `ADR-0153` §2.3; `ADR-0154` §2.5; `PRD-023` §3.1 `CNF-FR-009`). ⛔ Cross-tenant impossible — `CNF-INV-003`/`004` | ⭐ **PASS** |
| **5** | **Cross-App dependencies** | ⭐⭐ **ONE — DECLARED, SOURCED AND ONE-DIRECTIONAL.** The **10** `CFG-*` platform-default parameters are **read** in **two apps**: **APP 2** *(`TR-n`, as resolved effective values)* and **APP 3** *(`PR-1`/`PR-2`, read-only — `ADR-0154` `D-2`/`D-3`)*. ⛔ **No app writes them** (`CNF-FR-020`); ⛔ **no navigation between the two surfaces**; ⛔ APP 1 = 0 (§5.2). ⭐ `E-19`/`E-22` remain **bounded-context** edges, ⛔ not app boundaries (`DD-0001` §4.0.4) — §5.4 | ⭐ **PASS** |

| App | In scope? | Roles | Code home |
|---|---|---|---|
| ⭐ **APP 1 — Student App** | ⛔ **NO — 0 surfaces** | — | — |
| ⭐ **APP 2 — Library App** | ⭐ **YES** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception | `lib/app/staff/{owner,manager,reception}/` *(verified present)* |
| ⭐ **APP 3 — Platform Admin** | ⭐ **YES — READ-ONLY** *(`ADR-0154` `D-2`)*; ⛔⛔ **0 *writable* surfaces** *(`ADR-0152` §7 limb 3, preserved)* | `PR-1` Platform Administrator · `PR-2` Platform Support | `lib/app/platform_admin/` *(⛔ **reserved, 0 Dart files — implementation NOT authorized**)* |

### 5.1 ⭐ Why APP 2 = YES

⭐ All three roles `ADR-0151` allocates — `TR-1`, `TR-2`, `TR-3` — are **APP 2**
roles by README §2B.1. ⭐ `lib/app/staff/{owner,manager,reception}/` exists and is
reserved. ⛔ No other app hosts these roles.

### 5.2 ⭐ Why APP 1 = 0 surfaces — measured, not assumed

| # | Evidence | Text |
|---|---|---|
| 1 | **`ADR-0151` §2.3** | The allocation names **only** `TR-1`, `TR-2`, `TR-3`. ⛔ `TR-4`/`TR-5` receive **no** read and **no** write on any of the 22 |
| 2 | **`PRD-001` v2.0** | `TR-4` = *"Own records only"*; `TR-5` = *"Read-only, linked students"* — ⛔ neither mentions configuration |
| 3 | **`PRD-023` §9** | The role table marks `TR-4` and `TR-5` *"Not a writer"*; ⛔ it grants neither any read |
| 4 | **`AP-3`** | Deny by default — ⛔ silence is not a grant |

⛔ **A student never sees a configuration surface.** ⭐ Students *experience*
configuration through other modules' behaviour (§18) — ⛔ which is an effect, not
a surface.

### 5.3 ⭐⭐ APP 3 holds a READ-ONLY `BC-25` surface and **0 writable** surfaces — settled by `ADR-0152` as superseded in part by `ADR-0154`

⭐⭐ **Two `Accepted` Rank 2 ADRs govern this jointly, and the division between
them is exact.**

| | |
|---|---|
| ⭐ **`ADR-0154`** `D-2` | **APP 3 MAY hold a READ-ONLY `BC-25` configuration surface** for `PR-1` and `PR-2` |
| ⛔⛔ **`ADR-0152` §7 limb 3** *(preserved in full)* | **"No runtime write path to scope 1 exists or may be built"** |

⭐⭐ **`ADR-0154` §4.3 supersedes `ADR-0152` IN PART and IN EFFECT ONLY, in
exactly two places** — §7's word *"surface"* and §8.5's one table row — on the
**`ADR-0130`** instrument. ⛔⛔ **`ADR-0152` is byte-unchanged** (md5
`7fc60c7ff06a8fb6e47c17d88dec9071`) ⛔ **and remains `Accepted`.** ⭐ Its *"API"*
and *"write path"* nouns, limbs **1**, **2**, **4** and §8.1–§8.4 all **stand
unamended**.

⭐ `SECP-HRO-005` is **still** a governance / change-control act — ⛔ `ADR-0154`
does not reclassify it.

| # | Source | Text | Rank |
|---|---|---|---|
| 0 | ⭐⭐ **`ADR-0154`** `D-2`, `D-4` | *"APP 3 MAY hold a READ-ONLY `BC-25` configuration surface… ⛔ **NO WRITE AUTHORITY IS CREATED FOR ANY ACTOR AT ANY SCOPE**."* | ⭐ **2, Accepted** |
| 1 | ⭐⭐ **`ADR-0152` §7** *(limb 3, preserved)* | *"⛔ It does NOT establish an APP 3 / Platform Admin runtime configuration… **API or write path**."* ⚠️ The *"surface"* noun is superseded in part | ⭐ **2, Accepted** |
| 2 | **`CNF-FR-020`** *(`PRD-023`)* | Scope 1 *"**SHALL NOT** be writable at runtime by any actor, **including a platform role**"* | ⭐ **3, FROZEN** |
| 3 | **`CNF-AC-011`** | *"**No** API, role, actor, environment or maintenance path can write a value at scope 1 at runtime"* | ⭐ **3, FROZEN** |
| 4 | **`AUTH-2.9`** | *"No tenant role, including Owner, **MAY** confer any platform-level permission."* | ⭐ **3, FROZEN** |
| 5 | **`CONFIGURATION_GUIDE` §5** | Default changes route to *"**An ADR**"* and/or *"**A PRD amendment**"* — ⭐ **governance acts, not screens** | 7 |

⭐ **`PR-1`'s authority is NOT narrowed.** `PRD-001` v2.0 **L128** keeps *"platform
configuration"* inside `PR-1` Scope; ⭐ `ADR-0152` §7 item 1 preserves it, and
§3 distinguishes **authority in principle** from a **runtime product surface**.
⭐ `SECP-HRO-005` also **retains full force** as a control obligation
(`SECP-FR-011` audit, `SECP-BR-004` closure) — `ADR-0152` §7 item 4.

⚠️⚠️ **SELF-REPORTED FACTUAL CORRECTION — v0.1 of this section was WRONG, and it
is corrected rather than quietly replaced.** v0.1 read *"Why APP 3 is UNRESOLVED
— a **Rank 3 vs Rank 3** contradiction"* and concluded *"precedence cannot break
a same-rank tie."* ⛔ **The premise was false.** `PRD-012a` Part 2's own header
states: *"**Unranked.** No `DOCUMENTATION_BASELINE.md` §3 row. **Not** Rank 3;
**MUST NOT** be cited as authority against any ranked document"* — measured
identically across **all 8** `PRD-012a` parts, with `Status` = **`DRAFT`**.
⚠️ The error was reading `PRD-012a`'s **module rank 2** (`platform/security`) as a
**document precedence rank**; ⭐ they are different ladders. ⛔ There was never a
tie to break, and ordinary precedence settles it (`ADR-0152` §4.1, §7.1).

⭐ A second independent ground stands alone: `PRD-012a` Part 2 **§0.2** excludes
*"tables, APIs, SQL, code, **UI**, cloud resources or cryptographic mechanisms"*
from what it specifies — ⛔ **a document that does not specify UI cannot create
one** (`ADR-0152` §4.2).

⛔ **This document designs NO APP 3 surface**: no platform-admin configuration
panel, no platform-admin runtime write path, no platform-admin API, no new
permission. ⭐ That is now a **recorded governance outcome**, ⛔ no longer merely a
conservative design choice.

### 5.4 ⭐⭐ Declaration 5 — ONE declared cross-app dependency

⭐⭐ **There is EXACTLY ONE cross-APP dependency for the `BC-25` configuration
surface, and it is declared in full at §5.4.5.** ⚠️⚠️ **This REPLACES v0.3's
*"measured NEGATIVE"*, which is VOID** — ⛔ not re-worded, ⛔ not retained.
`Accepted` **`ADR-0154`** `D-2` authorises a **read-only APP 3 surface**, which
falsifies the old premise *"every authorized surface is APP 2"* **by
construction**.

⭐ README §2B.3 Declaration 5 — *"Cross-App dependencies, **if any**"* — is
satisfied by a **declared, sourced, one-directional** dependency; ⛔ its stated
failure mode is an *"**undeclared** jump between apps"*, and ⭐ this is the
opposite of undeclared.

⭐ **What IS evidenced — cross-BC:**

| Edge | Direction | Type | Source |
|---|---|---|---|
| **`E-19`** | *All contexts* → `BC-25` | `CF` Sync port | BC Map **L328** — *"Typed config accessors; no raw string lookups in domain code"* |
| **`E-22`** | `BC-25` → `BC-29` File & Media | `CF` Sync port | BC Map **L331** — `BC-25` is a listed consumer |

⭐ **`BC-25` publishes NO event** — `PRD-023` §0.3: BC Map §9 enumerates 14
producing contexts and *"`BC-25` is **not** one of them"*; `CNF-EVT-*` **declared
empty**; `CNF-FR-051` states the prohibition positively. ⛔ So there is **no**
event-based cross-app dependency.

⭐ **Seven declared consumers**, measured in `tool/module_dependencies.yaml`:
`domain/library` (L108) · `domain/person` (L182) · `domain/social` (L240) ·
`platform/ai` (L280) · `platform/analytics` (L309) · `platform/workflow` (L336) ·
**`app`** (L540, rank 9).

#### 5.4.1 ⭐⭐ The dependency test, applied one endpoint at a time

⭐ Each candidate dependency was tested for an **authoritative** statement placing
its endpoints in **different apps** — the `DD-0001` §4.0.4 method.

| # | Candidate dependency | Direction | Crosses an APP boundary? | ⭐ Authoritative basis |
|---|---|---|---|---|
| 1 | `TR-1`/`TR-2`/`TR-3` configuration surfaces | within APP 2 | ⛔ **NO — APP 2 → APP 2** | ⭐⭐ **`ADR-0151` §2.3** allocates to `TR-1`/`TR-2`/`TR-3` **only**; ⭐ all three are **APP 2** roles by README §2B.1 |
| 2 | `E-19` *All contexts* → `BC-25` | inbound to `BC-25` | ⛔ **NO — a bounded-context edge** | BC Map **L328**; §5.4.2 |
| 3 | `E-22` `BC-25` → `BC-29` branding media | outbound | ⛔ **NO — a BC edge; both endpoints APP 2** | BC Map **L331** |
| 4 | APP 1 `TR-4`/`TR-5` | — | ⛔ **NO — 0 surfaces, so no endpoint exists** | ⭐ **§5.2** — four independent sources |
| 5 | ⭐⭐ **APP 3 `PR-1`/`PR-2` read-only view of the 10 `CFG-*`** | **APP 3** *(read)* ↔ **APP 2** *(read)* of the **same** scope-1 values | ⭐⭐ **YES — AND IT IS DECLARED** | ⭐⭐ **`Accepted` `ADR-0154`** `D-2`, `D-3`; §5.4.5 below |

continued at §5.4.5.

#### 5.4.5 ⭐⭐ The ONE cross-app dependency — declared, not discovered

⚠️⚠️ **v0.3's *"measured NEGATIVE"* is VOID and is NOT retained.** It rested on
the premise *"every authorized surface is APP 2, therefore no jump between apps
is possible"* — ⛔ a premise `ADR-0154` `D-2` falsifies **by construction**.
⭐ **The correction is recorded rather than quietly replaced** (`ADR-0154` `D-9`).

⭐⭐ **The dependency, stated in full:**

> ⭐ The **ten** `CFG-*` platform-default parameters — `CFG-1`…`CFG-9`, `CFG-11` —
> resolve at **scope 1** and are **READ** in **two apps**:
> · ⭐ **APP 2 — Library App**: `TR-1`/`TR-2`/`TR-3` experience them as **resolved
>   effective values** behind other surfaces.
> · ⭐ **APP 3 — Platform Admin**: `PR-1`/`PR-2` may view them **read-only**
>   (`ADR-0154` `D-3`).
>
> ⛔ **The dependency is ONE-DIRECTIONAL and READ-ONLY.** ⛔ **Neither app writes
> them** — the value originates from the **environment profile at deployment**
> (`CNF-FR-026`, `CNF-FR-029`) and is unwritable at runtime by **any** actor
> (`CNF-FR-020`, `CNF-AC-011`).
> ⛔ **There is NO navigation between the two surfaces**, ⛔ no shared shell, and
> ⛔ no mixed-role screen — README §2B.4 rules **2** and **7**.
> ⛔ **APP 1 remains at 0 surfaces** (§5.2).

table—

| Property | Value |
|---|---|
| Endpoints | **APP 2** *(read)* · **APP 3** *(read)* |
| Direction | ⭐ **One-directional** — both are readers of a deployment-supplied value; ⛔ neither calls the other |
| Action | ⭐ **READ only** — `AUTH-7.24`: *"Read **MUST NOT** imply any other action"* |
| Shared UI | ⛔ **NONE** — materially different UX, documented separately (README §2B.4 rule **3**) |
| Writer | ⛔ **NONE at runtime** — environment profile at deployment |

⭐⭐ **README §2B.3 Declaration 5 asks for cross-app dependencies *"if any"*, and
names the failure mode as *"an **undeclared** jump between apps."*** ⭐ A
**declared, sourced, one-directional** dependency satisfies the declaration; ⛔ a
concealed one would not. ⛔ **Nothing is rounded up here** — the declaration is
*larger* than v0.3's, not smaller.

#### 5.4.2 ⛔⛔ `E-19` is a BOUNDED-CONTEXT edge and MUST NOT be treated as an APP boundary

⭐ `E-19`'s source column reads *"All contexts"* — a quantifier over **bounded
contexts** (BC Map Rank 4), ⛔ **not** over APP 1 / APP 2 / APP 3, a *product
surface* vocabulary introduced by `docs/35-design/README.md` §2B.1.

⭐⭐ **`DD-0001` §4.0.4 is the governing precedent and it is followed here
verbatim:** *"⛔⛔ **A BOUNDED-CONTEXT EDGE IS NOT AN APP BOUNDARY, AND THIS
DECLARATION DOES NOT TREAT ONE AS THE OTHER.**"* ⭐ `DD-0001` converted the same
observation into its **grounds for PASS** via a measured negative.

⚠️ **One residue is DISCLOSED, not resolved:** ⛔ no document maps the
bounded-context vocabulary onto the APP vocabulary. ⭐ This affects **every**
wildcard edge (`E-17`, `E-18`, `E-19`, `E-20`, `E-23`), ⛔ is **not** a `BC-25`
defect, and ⛔ **does not change the answer** — app placement here is fixed by
`ADR-0151` **by role**, ⛔ never by an edge.

#### 5.4.3 ⛔⛔ Why `CNF-GAP-002` and `CNF-GAP-007` are NOT Declaration 5 blockers

⚠️⚠️ **BOTH REMAIN OPEN. ⛔ Neither is closed, narrowed or re-dispositioned by
this document** — ⛔ a Design Doc cannot close a `PRD-023` gap.

| Gap | Text | Severity | Status | ⭐ Disposition — *stated by `FROZEN` `PRD-023` itself* |
|---|---|---|---|---|
| **`CNF-GAP-002`** | *"Seven modules declare a dependency on a port **no module provides**"* (7 consumers / 0 providers) | **High** | ⛔⛔ **OPEN** *(`ADR-0053` **L131**: "OPEN. Scheduled, not resolved")* | ⭐⭐ **`PRD-023` L1368 — "Stage 6 — closed by the implementation task that declares the provider"**. Owner: **Technical Owner** |
| **`CNF-GAP-007`** | `platform/configuration` has **no module block** in `tool/module_dependencies.yaml` | Medium | ⛔⛔ **OPEN** | ⭐⭐ **`PRD-023` L1373 — "Stage 6"**; §1.3 adds it is *"a Stage 6 obligation… **not a defect in the manifest**"*. Owner: **Technical Owner** |

⭐ **Both are real, both are OPEN, and both are STAGE 6 IMPLEMENTATION concerns.**
⛔ **Neither is a Declaration 5 blocker**, for four independent reasons:

1. ⛔ **README §2B.3 requires no provider.** Declaration 5 asks for *"Cross-App
   dependencies, **if any**"*; its only named failure mode is *"an undeclared
   jump between apps"*. ⛔ Measured **0** occurrences of *provider*,
   *implementation*, *binding* or *manifest* in §2B.3 or §2B.5.
2. ⭐⭐ **`FROZEN` `PRD-023` dispositions both to Stage 6**, and README §5.1 holds
   that a Design Doc *"**is not a precondition of implementation**"*
   (`ADR-0131` §4.3). ⛔ Treating a Stage 6 item as a design blocker would make
   the design wait on the implementation while the implementation does not wait
   on the design — ⛔ a deadlock no authority creates.
3. ⭐ **The condition is repository-wide, not `BC-25`-specific** — measured in
   `tool/module_dependencies.yaml`: **25 of 35** consumed ports have no provider
   declaration; `provides_ports` is used by **3 of 18** modules; **7 of 22**
   ranked modules have no module block; and `tool/check_module_boundaries.dart`
   reads `provides_ports` **0** times across its **12** enforced categories.
   ⭐ The manifest's own legend (**L14**) defines a port as an *"interface
   declared by **consumer**, implemented elsewhere, DI-wired"* — ⛔ so a
   `provides_ports` counterpart is not structurally required.
4. ⭐⭐ **Precedent is unanimous and one case is on all fours.** `DD-0006`'s
   subject port `platform/analytics:read_model` is declared by `app` at the
   **same app root** (**L539**, one line above `settings` at **L540**), has **no**
   provider declaration, and was awarded ⭐ **D5 PASS** on a design-level
   statement (`DD-0006` §5.3). ⭐ `DD-0005` §3.3 did likewise. ⛔ **No** Design
   Doc has ever been required to show a provider, a binding or an
   implementation to satisfy Declaration 5.

#### 5.4.4 ⚠️ The app-root port declaration — tested, and it does not sustain a GAP

⭐ The fact is **true and preserved**: the `app` module (rank 9) declares
`platform/configuration:settings` at **L540**, the **app ROOT**, and `lib/app/`
contains `student/`, `staff/` **and** `platform_admin/`.

⛔ It does not sustain a Declaration 5 GAP, on four measurements:

1. ⛔ The manifest contains **0** per-app submodules — per-app declaration is
   **not expressible** in the current schema, so ⛔ its absence cannot be a
   `BC-25` defect.
2. ⛔ **All 11** ports `app` declares are root-declared, ⭐ including `DD-0006`'s
   `read_model` at **L539**.
3. ⭐⭐ **Port visibility is not authorization** — the rule v0.1 correctly stated
   and, ⚠️ having stated it, then used a **visibility** fact to withhold an
   **authorization** conclusion. ⭐ Applied consistently, it resolves the other
   way.
4. ⭐⭐ **Authorization is app-determinate from a Rank-2 source**: `ADR-0151` §2.3
   allocates to `TR-1`/`TR-2`/`TR-3` only — all APP 2. ⭐ README §2B.4 rule 4
   requires exactly this: *"Permissions come from PRD / ADR / Auth sources
   only"* — ⛔ never from a build manifest.

⚠️ **Recorded as a separate observation, ⛔ not as a `BC-25` blocker:** that the
manifest cannot express per-app port granularity is a genuine **Rank 4**
question affecting all **11** `app` ports. → **`DD7-GAP-013`**, Architecture
Owner (§22).

#### 5.4.5 ⭐ Verdict

⭐⭐ **Declaration 5 = `PASS`** — the cross-app dependency position is
**declared** (there is none) and **sourced** (`ADR-0151` §2.3 · `ADR-0152` §7 ·
§5.2 · `DD-0001` §4.0.4 · BC Map **L328**/**L331**), which is what README §2B.5
requires.

⚠️⚠️ **SELF-REPORTED CORRECTION — v0.2's four numbered blockers were all
FACTUALLY TRUE, and every one of them is preserved above.** ⛔ What was wrong was
the **adjudication**, not the measurement: three of the four are **Stage 6
implementation** facts and the fourth (`E-19`'s bounded-context wording) is the
affirmative **ground for PASS** under `DD-0001` §4.0.4. ⭐ The error was applying
an implementation-readiness test to a **design-readiness** declaration. ⛔ It is
corrected here rather than quietly replaced.

### 5.5 ⭐ App-Boundary QA — the 13 checks (README §2B.5)

| # | Check | Result |
|---|---|---|
| 1 | Every surface assigned to exactly one app | ⭐ **PASS** — all 4 surfaces → APP 2 (§11.1) |
| 2 | Every surface assigned to named roles | ⭐ **PASS** — §11.1 |
| 3 | No role invented | ⭐ **PASS** — 3 tenant roles cited; ⛔ 0 created |
| 4 | Parent inside APP 1, not separate | ⭐ **PASS** *(vacuously — `TR-5` has **0** surfaces, §5.2)* |
| 5 | Student data scoped to self | ⭐ **PASS** *(vacuously — `TR-4` has **0** surfaces)* |
| 6 | `TR-1`/`TR-2`/`TR-3` differences respected | ⭐ **PASS** — `ADR-0151` §2.3 gives three distinct row treatments (§12) |
| 7 | Platform roles separated (`AUTH-2.5`) | ⭐ **PASS** — ⭐ APP 3's surface is **READ-ONLY** and its parameters resolve at **scope 1**, which `PRD-023` **L316** places outside tenant settability; ⭐ `CFG-*` are therefore **platform-level objects**, ⛔ **not tenant business data**, so `AUTH-2.5`/`AUTH-7.13`/`AUTH-7.61` are **not engaged** (`ADR-0154` §3.2). ⛔ **0 tenant-role authority granted**; ⛔ `PR-1`/`PR-2` granted **separately**, never merged |
| 8 | Figma preserves boundaries | ⭐ **PASS by construction** — ⛔ gate is **BLOCKED** (§25) |
| 9 | No mixed-role shell | ⭐ **PASS** — one surface, three role treatments, ⛔ not one screen greyed by role (§12.4) |
| 10 | Tenant scope explicit | ⭐ **PASS** — `CNF-INV-003`/`004`; every row carries a scope |
| 11 | Cross-app dependency named | ⭐ **PASS** — §5.4.5; ⭐⭐ named as **ONE DECLARED, one-directional, read-only** dependency *(⚠️ v0.3's measured negative is **void**)* |
| 12 | No permission inferred from visibility | ⭐ **PASS** — §12.5; every cell traces to `ADR-0151` §2.3, `ADR-0153` §2.3 or `ADR-0154` §2.5 |
| 13 | Evidence cited per declaration | ⭐ **PASS** |

⭐⭐ **13 of 13 PASS · 0 GAP** — ⭐ advanced from **11/13** at v0.1, **12/13** at
v0.2, **13/13** at v0.3; ⭐ **held at 13/13 at v0.5 by re-earning check 11 in the
opposite form**.

⚠️⚠️ **Check 11 was RE-EARNED, NOT CARRIED FORWARD.** ⛔ v0.3 passed it on a
**measured negative**; that negative is now **false**. ⭐ It passes at v0.5
because the dependency is **declared, sourced and one-directional** (§5.4.5) —
⭐ a different route to the same verdict, ⛔ not the same claim restated.

⭐⭐ **13/13 is reached WITHOUT inventing anything**, and ⛔ **without rounding**:
⭐ check 7 is re-argued from `PRD-023` **L316** rather than from *"APP 3 = 0"*,
and ⭐ check 11 is re-argued from `ADR-0154` `D-2`.

⚠️⚠️ **THIS IS NOT A ROUNDING-UP, and the distinction is stated because v0.2
expressly warned against one.** ⛔ `CNF-GAP-002` *(7 consumers / 0 providers,
**High**)* and `CNF-GAP-007` remain **OPEN** — ⛔ **neither is closed here** —
and `ADR-0053` **L131**'s *"OPEN. Scheduled, not resolved"* stands unaltered.
⭐ What changed is **which test they answer**: `FROZEN` `PRD-023` dispositions
both to **Stage 6 implementation** (L1368, L1373), ⛔ and Declaration 5 is a
**design-readiness** declaration about app boundaries. ⭐ §5.4.3 sets this out
with the repository-wide measurements and the `DD-0005`/`DD-0006` precedent.

---

## 6. The canonical 104-parameter register

### 6.1 ⭐ Source of truth, and how it was reconciled

⭐ **The canonical register is `PRD-023` §3.6** *(FROZEN, Rank 3)* — the only
document that enumerates all eight owning registers and totals them.

| Register | Count | Owning PRD | Status | Definition site |
|---|---:|---|---|---|
| `CFG-1`…`CFG-12` | **12** | `PRD-001` Authentication | FROZEN v2.0 | `CONFIGURATION_GUIDE.md` §2 |
| `LCFG-1`…`LCFG-13` | **13** | `PRD-002` Library | FROZEN v1.1 | §16.1 (1–10) · §14B.9 (11–13) |
| `ICFG-1`…`ICFG-10` | **10** | Invitation Security Spec | Rank 3 | `CONFIGURATION_GUIDE.md` §2B |
| `SCFG-1`…`SCFG-11` | **11** | `PRD-003` Student Identity | FROZEN v1.0 | §5.5 |
| `SMCFG-1`…`SMCFG-7` | **7** | `PRD-004` Student Management | FROZEN v1.2 | §10.3 |
| `MM-CFG-001`…`009` | **9** | `PRD-005` Membership | FROZEN v1.6 | §13.4 |
| `SEAT-CFG-001`…`018` | **18** | `PRD-007` Seat | FROZEN v1.0 | §27.1 |
| `ATT-CFG-001`…`024` | **24** | `PRD-006` Attendance | FROZEN v1.9 | Its own register |
| `TEN-CFG-*` · `AUD-CFG-*` · `ENT-CFG-*` | **0 · 0 · 0** | `PRD-013` · `PRD-016` · `PRD-014` | FROZEN | **Declared empty** |
| **Total** | **104** | **8 owning PRDs** | **all FROZEN** | |

⭐ **Arithmetic verified: 12+13+10+11+7+9+18+24 = 104.** ⭐ Every register was
re-measured against its definition site; all eight enumerate completely.

⚠️ **Reconciliation notes — three discrepancies found and recorded, none
resolved here:**

| # | Discrepancy | Disposition |
|---|---|---|
| 1 | ⚠️ `PRD-023` §3.6 cites `PRD-005` as **"FROZEN v1.4"**; the repository is at **v1.6** (`ADR-0149`, `ADR-0150`) | ⛔ **Stale citation, not a register change** — `MM-CFG-*` is still **9**, verified. ⛔ Not repaired: `PRD-023` is FROZEN. Routed to **`CNF-D-3`** (§22) |
| 2 | ⚠️ The **Invitation Security Specification** is the only owning source that is **not** a numbered `PRD-*` | ⭐ Recorded as-is; `PRD-023` §3.6 marks it *"Rank 3"*. ⛔ No reclassification attempted |
| 3 | ⚠️ `ATT-CFG-014` is recorded elsewhere as *"leaving the V1 configuration surface"* on a V3 face-attendance ruling | ⛔ **Not applied.** The change is conditional in its own source; ⛔ `PRD-023` §3.6 still counts **24**. Recorded, not acted on |

### 6.2 ⭐⭐ Authorization coverage — the separation that matters most

⛔⛔ **INVENTORY IS NOT AUTHORIZATION.** The table in §6.3 lists all 104 so the
design scope is honest about what exists. ⛔ **65 of them carry NO operation×role
source and MUST NOT be rendered by any surface this document describes.**

| Band | Count | Label | Meaning |
|---|---:|---|---|
| ⭐ **Authorized** | **35** | `AUTHORIZED` | A complete role×action×scope treatment **and** a write path exists — **18** by `ADR-0151`, ⭐ **17** by `ADR-0153` |
| ⭐ **Platform default** | **4** | `PLATFORM DEFAULT` | `ADR-0151` covers them, but `CNF-FR-020` makes them **unwritable by any actor**; read decided |
| ⛔ **Not authorized** | **65** | `NOT YET AUTHORIZED` | ⛔ **No** operation×role source. ⛔ Inventoried only |
| | **104** | | |

⭐ **18 + 4 = 22** — the `ADR-0151` subset. ⭐ **+ 17** — the `ADR-0153` `ATT-CFG-*`
subset. ⭐ **35 + 4 = 39 authorized; 39 + 65 = 104.**

⚠️ **`PARTIALLY AUTHORIZED` is used for exactly 0 parameters**, because
`ADR-0151` treats each of its 22 completely. ⚠️ **`OPEN` is used for 0
parameters** in the authorization column, and appears only in the *open-issue*
column.

### 6.3 The complete inventory

⭐ Columns: **Scope** = effective resolution scope · **Auth** = authorization
status · **Comm** = commercial classification · **Design** = whether `DD-0007`
designs a row for it.

⛔ For all 65 unallocated rows: **Scope = `OPEN`**, **Comm = `OPEN`**,
**Design = ⛔ NOT DESIGNED** — ⛔ and that is not an oversight, it is the absence
of a lawful source.

⚠️⚠️ **The 17 `ATT-CFG-*` rows authorized by `ADR-0153` are `AUTHORIZED` but
remain ⛔ NOT DESIGNED in this document.** ⭐ Authorization and design are
separate: `DD7-GAP-003` — whether `BC-25` owns a configuration surface at all,
or each owning module renders its own — is ⛔ **still open**, and `DD-0003`
`S-L8` already renders these 24 as a **`BC-06`** surface. ⛔ `ADR-0153` §7 states
expressly that it *"creates no design artifact"*.

#### 6.3.1 ⭐ AUTHORIZED — `MM-CFG-001`…`009` *(`PRD-005` / `BC-02`)*

| ID | Name | Scope | Auth | Comm | Evidence | Design | Dependency | Open issue |
|---|---|---|---|---|---|---|---|---|
| `MM-CFG-001` | Tenant default currency | `Tenant` | ⭐ **AUTHORIZED** | ⭐ **COMMERCIAL** | `ADR-0151` §2.3 | ⭐ Designed | `LCFG-3` | — |
| `MM-CFG-002` | Max staleness, cached enrollment state | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | — |
| `MM-CFG-003` | Max back-dating of `startDate` | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | — |
| `MM-CFG-004` | Max forward-dating of `startDate` | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | — |
| `MM-CFG-005` | Idempotency record retention | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ `TR-3` read DENY |
| `MM-CFG-006` | Tenant timezone | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | `LCFG-1` | ⚠️ `DD7-GAP-004` |
| `MM-CFG-007` | `PendingPayment` auto-void window | `Tenant` | ⭐ **AUTHORIZED** | ⭐ **COMMERCIAL** | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ `TR-3` read DENY (`AC-7.8`) |
| `MM-CFG-008` | Expiring-soon threshold | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | `SMCFG-3` ⚠️ | ⚠️ `DD7-GAP-005` |
| `MM-CFG-009` | Re-derive whole term on delayed payment | `Tenant` | ⭐ **AUTHORIZED** | ⭐ **COMMERCIAL** | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ `TR-3` read DENY (`AC-7.8`) |

#### 6.3.2 ⭐ AUTHORIZED / PLATFORM DEFAULT — `LCFG-1`…`LCFG-13` *(`PRD-002` / `BC-03`)*

| ID | Name | Scope | Auth | Comm | Evidence | Design | Dependency | Open issue |
|---|---|---|---|---|---|---|---|---|
| `LCFG-1` | Time Zone | ⚠️ `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3, §5 | ⭐ Designed | `MM-CFG-006` | ⛔ **`CNF-D-1`** conflict |
| `LCFG-2` | Language | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ supported set undefined |
| `LCFG-3` | Currency | `Library` | ⭐ **AUTHORIZED** | ⭐ **COMMERCIAL** | `ADR-0151` §2.3 | ⭐ Designed | `MM-CFG-001` | — |
| `LCFG-4` | Date Format | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | — |
| `LCFG-5` | Member Directory | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | `LMD-6` | — |
| `LCFG-6` | Discovery index propagation | ⚪ `Platform default` | ⭐ **PLATFORM DEFAULT** | NOT COMMERCIAL | `ADR-0151` §2.3, §3.5 | ⛔ **Not writable** | — | `LIB-16.9` |
| `LCFG-7` | Gallery images per branch | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ `TR-3` read DENY |
| `LCFG-8` | Facilities in reference list | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | — | ⚠️ `TR-3` read DENY |
| `LCFG-9` | Floors per branch | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | `LCFG-10` | — |
| `LCFG-10` | Zones per floor | `Library` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0151` §2.3 | ⭐ Designed | `LCFG-9` | — |
| `LCFG-11` | Preserved intent TTL | ⚪ `Platform default` | ⭐ **PLATFORM DEFAULT** | NOT COMMERCIAL | `ADR-0151` §2.3, §3.5 | ⛔ **Not writable** | `CFG-6`, `CFG-2`×`CFG-1` | `INV-10`, `INV-11` |
| `LCFG-12` | Public search page size | ⚪ `Platform default` | ⭐ **PLATFORM DEFAULT** | NOT COMMERCIAL | `ADR-0151` §2.3, §3.5 | ⛔ **Not writable** | — | — |
| `LCFG-13` | Public preview cache TTL | ⚪ `Platform default` | ⭐ **PLATFORM DEFAULT** | NOT COMMERCIAL | `ADR-0151` §2.3, §3.5 | ⛔ **Not writable** | — | `INV-12`, `LIB-14B.49` |

#### 6.3.3 ⛔ NOT YET AUTHORIZED — `CFG-1`…`CFG-12` *(`PRD-001` / `BC-18`)*

⛔ **No operation×role source exists for any row below.** ⚠️ These are
authentication controls; `CNF-FR-028` notes that if the hierarchy allowed a
tenant override on an unsettable parameter *"a library could raise its own OTP
quota"*.

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `CFG-1` | OTP requests per mobile number / hour | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-2` | Min interval between OTP requests | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-3` | OTP requests per network origin / hour | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-4` | Temporary lock after quota exhaustion | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-5` | Idle session timeout | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-6` | Absolute session lifetime | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-7` | Trusted-device trust lifetime | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-8` | Max concurrent registered devices | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-9` | Pending-verification retention | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-10` | Soft-deleted account retention | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-11` | Account-claim failures before lock | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |
| `CFG-12` | Platform Support elevated-access max duration | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2 | ⛔ Not designed |

#### 6.3.4 ⛔ NOT YET AUTHORIZED — `ICFG-1`…`ICFG-10` *(Invitation Security Spec)*

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `ICFG-1` | `IT-1` staff invitation TTL | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-2` | `IT-2` private library invitation TTL | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-3` | `IT-3` access code TTL | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-4` | Acceptance window after first use | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-5` | Outstanding invitations per library | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-6` | Max acceptances per `IT-3` code | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-7` | Invitations creatable / hour / library | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-8` | Presentations per origin / hour | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-9` | Failed presentations before throttling | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |
| `ICFG-10` | Throttle duration after threshold | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | Guide §2B | ⛔ Not designed |

#### 6.3.5 ⛔ NOT YET AUTHORIZED — `SCFG-1`…`SCFG-11` *(`PRD-003` / `BC-11`)*

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `SCFG-1` | Username length | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-2` | Reserved-username list | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-3` | Username rename cooldown | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-4` | Username-history retention | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-5` | Released-username hold period | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-6` | Bio maximum length | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-7` | Global Profile Photo max size | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-8` | Global Profile Photo accepted formats | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-9` | Per-contributor composition timeout | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-10` | Public-profile view rate limit | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |
| `SCFG-11` | Username availability-check rate limit | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-003` §5.5 | ⛔ Not designed |

#### 6.3.6 ⛔ NOT YET AUTHORIZED — `SMCFG-1`…`SMCFG-7` *(`PRD-004` / `BC-01`)*

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `SMCFG-1` | Directory default page size | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |
| `SMCFG-2` | Directory maximum page size | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |
| `SMCFG-3` | Membership expiring-soon threshold | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed — ⚠️ see `DD7-GAP-005` |
| `SMCFG-4` | Bulk operation record cap | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |
| `SMCFG-5` | Enrollment number format | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |
| `SMCFG-6` | Documents per student | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |
| `SMCFG-7` | Directory export row cap | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-004` §10.3 | ⛔ Not designed |

#### 6.3.7 ⛔ NOT YET AUTHORIZED — `SEAT-CFG-001`…`018` *(`PRD-007` / `BC-04`)*

⚠️ **Two rows below are themselves authorization-shaped** — `SEAT-CFG-005`
*"which roles beyond Owner may override"* and `SEAT-CFG-014` *"whether Reception
may cancel another student's reservation"*. ⛔ They remain **NOT YET AUTHORIZED**;
⛔ a configuration parameter that *grants* authority cannot be self-authorizing.
Recorded as **`DD7-GAP-006`**.

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `SEAT-CFG-001` | Tenant label for `Zone` | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-002` | Effective `seatQuota` when `E-02` omits | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-003` | Whether `Inactive` blocks acquisition | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-004` | Release reason list | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-005` | **Override grant — roles beyond Owner** | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed — ⛔ **`DD7-GAP-006`** |
| `SEAT-CFG-006` | Max concurrent `Pending` seat-change requests | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-007` | Decision deadline for `Pending` | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-008` | Student self-booking enabled | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-009` | Behaviour when window exceeds membership | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-010` | Booking mode | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-011` | Reservation → allocation conversion trigger | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-012` | No-show count suspending self-booking | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-013` | Self-booking suspension duration | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-014` | **Whether Reception may cancel a reservation** | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed — ⛔ **`DD7-GAP-006`** |
| `SEAT-CFG-015` | Default reservation hold duration | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-016` | Max concurrent active reservations / student | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-017` | Occupancy % emitting `SEAT-EVT-004` | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |
| `SEAT-CFG-018` | *Expiring soon* filter horizon | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-007` §27.1 | ⛔ Not designed |

#### 6.3.8 ⭐ PARTLY AUTHORIZED — `ATT-CFG-001`…`024` *(`PRD-006` / `BC-06`)*

⭐⭐ **17 of 24 AUTHORIZED by `Accepted` [`ADR-0153`](../../00-governance/adr/ADR-0153-att-cfg-attendance-configuration-authorization-allocation.md)** —
`ATT-CFG-001`…`012` and `017`…`021`: **`READ` = `TR-1` + `TR-2` + `TR-3`**,
**`NOT COMMERCIAL`**, **Scope = `Tenant`**. ⭐ **`WRITE` is unchanged** and comes
from FROZEN `PRD-006` §16.3 — `TR-1` on 16, **`TR-1` + `TR-2` on `ATT-CFG-008`**
(`D-12`); ⛔ `ADR-0153` did not decide it.

⛔⛔ **7 remain `NOT YET AUTHORIZED` and are NOT allocated:** `ATT-CFG-013`,
`014`, `015`, `016` *(Face — V1/V3 boundary; `ADR-0021` requires **Security
Owner** input for `014`)* · **`022`**, **`023`**, **`024`** *(⛔ **authorization-
semantic** — `022` gates `TR-2`/`TR-3` correction rights and `024` gates `TR-5`
parent visibility, `PRD-006` §19.2 **L1980**/**L1983**; both need the
**Authorization Owner**)*. ⭐ `ADR-0153` §5.
⭐⭐ **A `WRITE` role in §16.3 was NOT treated as sufficient to authorize
them** — all seven carry `WRITE` = `Owner` exactly like the 17.

⚠️⚠️ **`DD-0003` §16.2 already designs a surface (`S-L8`) rendering these 24 rows,
assigned `TR-1` ONLY, plus `S-L8a` for `TR-1`+`TR-2`.** ⛔ That is a **`BC-06`**
surface under `PRD-006`'s own requirements — ⛔ **not** a `BC-25` surface, and
⛔ **not** an authorization source for `BC-25`. ⭐ It is strong evidence for the
distributed-ownership reading in **`DD7-GAP-003`** (§22).

| ID | Name | Scope | Auth | Comm | Evidence | Design |
|---|---|---|---|---|---|---|
| `ATT-CFG-001` | Fixed QR enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-002` | Dynamic QR enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-003` | Fixed QR + Wi-Fi enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-004` | Fixed QR + GPS enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-005` | Dynamic QR rotation interval | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-006` | Dynamic QR validity window | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-007` | Dynamic QR single-use per student-day | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-008` | Approved Wi-Fi network(s) | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3; `ATT-FR-032` | ⛔ Not designed *(`DD-0003` `S-L8a`)* |
| `ATT-CFG-009` | Wi-Fi verification strictness | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-010` | Library coordinates | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-011` | GPS acceptance radius | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-012` | Minimum acceptable location accuracy | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-013` | Face enrollment required before use | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-014` | Face match confidence threshold | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed — ⚠️ §6.1 note 3 |
| `ATT-CFG-015` | Face liveness required | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-016` | Face mode enabled | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-017` | Manual mode enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-018` | Register-image workflow enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-019` | OCR high-confidence threshold | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-020` | Unattended creation of OCR entries | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-021` | Check-out tracking enabled | `Tenant` | ⭐ **AUTHORIZED** | NOT COMMERCIAL | `ADR-0153` §2.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-022` | Staff correction permitted | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-023` | Correction window | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |
| `ATT-CFG-024` | Parent attendance visibility | `OPEN` | ⛔ **NOT YET AUTHORIZED** | `OPEN` | `PRD-006` §16.3 | ⛔ Not designed *(`DD-0003` `S-L8`)* |

### 6.4 ⭐ Coverage summary — mechanically checked

| Band | Count | Renders in `DD-0007`? |
|---|---:|---|
| ⭐ `AUTHORIZED` *(writable, role-allocated)* — `ADR-0151` | **18** | ⭐ **YES** |
| ⭐ `AUTHORIZED` *(writable, role-allocated)* — ⭐ `ADR-0153` `ATT-CFG-*` | **17** | ⛔ **NO — authorized, not designed** *(`DD7-GAP-003`)* |
| ⭐ `PLATFORM DEFAULT` *(read-only by `CNF-FR-020`)* | **4** | ⚠️ **Read decision exists; ⛔ 0 write affordance** |
| ⛔ `NOT YET AUTHORIZED` | **65** | ⛔ **NO** |
| **Total** | **104** | ⭐ **39 of 104 = 37.5% authorization coverage** |

⛔⛔ **37.5% is published as measured.** ⛔ It is not rounded, not described as
"most of the important ones", and ⛔ the 65 are **not** presented as authorized
merely because they are inventoried. ⚠️ **Authorization coverage is NOT design
coverage** — ⭐ **22** parameters are designed here, ⛔ not 39.

---

## 7. Scope model and the hierarchy the UI must express

⭐ `PRD-023` §3.1 `CNF-FR-009` fixes **five** scopes; `CNF-FR-010` makes the
number and order **structural, not configurable**; `CNF-FR-011` makes scopes 4–5
*"structurally present and functionally unpopulated"* in V1.

| # | Scope | Populated in the 22? | UI treatment |
|---:|---|---|---|
| 1 | **Platform default** | ⭐ all 22 have one | ⭐ Shown as the **origin** of an inherited value; ⛔ **never** editable (`CNF-FR-020`) |
| 2 | **Tenant** | ⭐ **10** | ⭐ Editable where the role allows |
| 3 | **Library** | ⭐ **8** | ⭐ Editable where the role allows |
| 4 | Branch | ⛔ **0** | ⛔ **Not rendered.** `CNF-GAP-003`; ⛔ showing an empty scope selector would imply a capability that does not exist |
| 5 | User | ⛔ **0** | ⛔ **Not rendered.** Same reason |

⭐⭐ **Design consequence — the scope selector has exactly TWO options in V1**,
not five. ⭐ `CNF-FR-011` requires the *resolution algorithm* to traverse scopes 4
and 5; ⛔ it does **not** require the *interface* to offer them. ⚠️ Rendering an
unpopulated scope is the *"trial and error"* failure `CNF-FR-080` exists to
prevent, one level up.

---

## 8. Authorization boundary — how a row is rendered

⛔⛔ **Every cell below traces to `ADR-0151` §2.3. ⛔ Nothing is inferred from UI,
navigation, frontend guards, implementation or API behaviour.**

| Actor state | Rendering | Authority |
|---|---|---|
| Role may **write** the parameter | ⭐ **Editable row** with range affordance | `ADR-0151` §2.3 ✅ · `CNF-FR-080` |
| Role may **read** but not write | ⭐ **Read-only row**, ⛔ not hidden, ⛔ not editable-then-refused | **`CNF-FR-081`** |
| Role may **not read** | ⛔ **Absent** — ⛔ not greyed, ⛔ not a lock icon | `AP-3`; ⭐ §8.2 |
| Parameter at **scope 1** | ⭐ Read-only for everyone; ⛔ **0** write affordance | `CNF-FR-020`, `CNF-AC-011`, `ADR-0151` §3.5 |
| `TR-2`, **non-commercial** | ⚠️ **Resolved by `BC-18` at request time** — ⛔ this design does **not** assert ALLOW | **`ADR-0151` §2.4** |

### 8.1 ⭐ The `TR-2` row — the one the design must not over-claim

⭐ `ADR-0151` §2.4 records `*existing model*` for `TR-2` on the **18
non-commercial** parameters: *"neither ALLOW nor DENY… converting the absence of
a prohibition into a grant would breach `AP-3`."*

⭐⭐ **Design consequence:** the surface **MUST NOT** hard-code `TR-2` editability
for those 18. ⭐ It renders whatever `BC-18` returns for the request —
`CNF-FR-064`: *"the module **SHALL** treat an arriving write as
already-authorised"*, and `CNF-XC-006`: `BC-25` **MUST NOT** evaluate
authorisation itself.

⚠️ This is the only place in this document where a row's rendering is
**determined at runtime rather than at design time**, and ⛔ that is a
consequence of the authority state, not a design preference.

### 8.2 ⭐⭐ Why *deny-read* means ABSENT, not greyed

⭐ `CNF-FR-081` mandates **read-only** for *read-but-not-write*. ⛔ It says nothing
about *cannot-read*, and the distinction matters:

| Case | Rendering | Why |
|---|---|---|
| Read ✅ / Write ⛔ | ⭐ **Read-only row, value visible** | `CNF-FR-081` — *"not hidden"* |
| Read ⛔ | ⛔ **Row absent entirely** | ⭐ A greyed row **discloses that the parameter exists and has a value** — for `MM-CFG-007`/`009` that is financial disclosure, which `AC-7.8` denies *"regardless of other roles held anywhere"* |

⚠️⚠️ **This is a genuine design trap.** The intuitive pattern — show everything,
grey what you can't touch — would leak exactly what `AC-7.8` protects. ⭐ `TR-3`
sees **13 rows**, not 22 with 9 greyed.

---

## 9. UI/UX Pro Max — rules applied, with rationale

⭐ **Source:** `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`** (MIT),
present at `/home/user/sb-git-refs/ui-ux-pro-max-skill`. ⭐ Workflow read from
`CLAUDE.md`; queried via `src/ui-ux-pro-max/scripts/search.py --domain ux`.

⛔⛔ **UI/UX Pro Max is a design input, NOT governance authority.** ⛔ Where it
conflicts with a Liboora source, the Liboora source wins and the rule is
**REJECTED**.

| Rule *(skill)* | Liboora application | Evidence / source | Design decision | Status |
|---|---|---|---|---|
| **Forms → Submit Feedback** *(High)* — *"Show loading then success/error state"* | Every write shows saving → saved / reason | Skill `ux-guidelines`; `CNF-FR-022`, `CNF-FR-067` | §15 state model | ⭐ **APPLIED** |
| **Accessibility → Form Labels** *(High)* — ⛔ no placeholder-only inputs | Every parameter row carries a persistent visible label | Skill; `MP-NFR-08` | §14 | ⭐ **APPLIED** |
| **Forms → Inline Validation** *(Medium)* — validate on blur | Validate on blur against the declared range | Skill; **`CNF-FR-080`** *(range shown **before** a write)* | §15.3 | ⭐ **APPLIED — and Liboora is stricter** |
| **Layout → Content Jumping** *(High)* — reserve space for async text | Validation text and inherited-badge occupy a **reserved slot** | Skill; `MP-NFR-06` | §11.3 | ⭐ **APPLIED** |
| **Forms → Focusable Error Summary** *(High)* — summary at top, focus moved, links to fields | ⚠️ **ADAPTED** — summary is useful, but `CNF-FR-079` requires *"the specific reason **against the field**"*; the summary supplements, ⛔ never replaces, inline errors | Skill; **`CNF-FR-079`** | §15.3 | ⚠️ **ADAPTED** |
| Skill visual-style domains *(glassmorphism, palettes, font pairings)* | ⛔ Not consulted for tokens | **`CNF-XC-016`** — the module **MUST NOT** define design tokens, colour, typography; owner = **UI Design System** | ⛔ None | ⛔ **REJECTED** |
| Skill `chart` / `react` / `gsap` domains | ⛔ Not applicable — no charts, not React, no web animation library | Flutter; `MP-NFR-06` | ⛔ None | ⛔ **REJECTED** |
| Skill `--design-system` dials | ⛔ Not used | ⭐ Liboora has an existing design system (§10); ⛔ creating a competing one is forbidden by the brief and by `CNF-XC-016` | ⛔ None | ⛔ **REJECTED** |

⭐ **5 applied/adapted · 3 rejected.** ⭐ Every rejection names a Liboora source
rather than a preference.

---

## 10. Design-system reuse matrix

⭐ Measured in `lib/app/shared/` at HEAD. ⛔ **No new component is proposed where
an existing one fits.**

| Existing component / pattern | Source file | `DD-0007` usage | Why reused |
|---|---|---|---|
| `AppScaffold` + `NavigationBar` | `lib/app/shared/app_chrome.dart` L52, L130 | Hosts Settings as a staff destination | ⭐ The only navigation shell in the app; ⛔ a second would fragment the chrome |
| `PanelCard` | `lib/app/shared/widgets/common.dart` L290 | Groups a parameter category | ⭐ Existing card treatment; ⛔ no new container needed |
| `SectionHeader` | `common.dart` L98 | Category headings within a group | ⭐ Matches existing information hierarchy |
| `Pill` | `common.dart` L151 | ⭐ **The inherited-vs-override badge** (`CNF-FR-076`) and source-scope label (`CNF-FR-077`) | ⭐ Already a compact status token; ⛔ inventing a badge would duplicate it |
| `EmptyState` *(icon, title, message)* | `common.dart` L237 | ⭐ `TR-3` with 0 readable rows in a category | ⭐ Existing empty treatment |
| `LiblColors` semantic roles | `lib/app/shared/theme.dart` L13–26 | `warning` for commercial-change warnings; `danger` for refusal; `textMuted` for inherited | ⭐ Semantic roles already defined; ⛔ **no new colour values** (`CNF-XC-016`) |
| `LiblSpace` scale | `theme.dart` L30–35 | All spacing | ⭐ Existing 4/8/12/16/24/32 scale |
| `InputDecorationTheme` | `theme.dart` L81–95 | All value inputs | ⭐ Existing field treatment incl. focus border |
| `Monogram` | `common.dart` L190 | Actor avatar in history rows | ⭐ Existing identity token |
| `LayoutBuilder` + `BoxConstraints(maxWidth:)` | `lib/app/shared/login_screen.dart` L77–81 | ⭐ The responsive pattern for the two-pane layout | ⭐ **The repository's only established responsive pattern** — reused rather than replaced |
| `AccountAvatarButton`, `BranchOptionTile`, `SheetSectionLabel` | `app_chrome.dart` L147/L191/L228 | Scope-selector sheet | ⭐ `BranchOptionTile` already renders a *"pick a scope-like thing"* row |
| ⛔ `MeterBar` | `common.dart` L308 | ⛔ **PROHIBITED** | ⛔ There is no ratio, percentage or progress quantity on a configuration surface. ⭐ The **fourth** consecutive Design Doc to prohibit it, for a fourth distinct reason |

### 10.1 ⚠️ New components — only where the repository shows a real gap

| Proposed | Driving requirement | Why nothing existing fits |
|---|---|---|
| ⚠️ **`RangeBoundedField`** | **`CNF-FR-080`** — the declared range **SHALL** be presented **before** a write is attempted | ⛔ `InputDecorationTheme` styles a field; ⛔ nothing in `common.dart` renders a *permitted domain*. `PRD-023` §12.2 names it as a required component |
| ⚠️ **`InheritedValueRow`** | **`CNF-FR-076`**, **`CNF-FR-077`** | ⛔ No existing row type carries *value + origin scope + set-here/inherited*. `Pill` supplies the badge, ⛔ but the row composition does not exist |
| ⚠️ **`ResetToInheritedControl`** | **`CNF-FR-078`** — removal **SHALL** be an operation distinct from setting | ⛔ No existing control expresses *"remove my override"*; ⛔ a plain button would read as "set to parent's value", which `CNF-FR-078`'s note explicitly rejects |

⭐ All three are named by **`PRD-023` §12.2** as *"requirements on the Design
System"*. ⛔ This document **requests** them; ⛔ it does not specify their tokens,
which `CNF-XC-016` reserves to the **UI Design System**.

⚠️⚠️ **And the UI Design System does not exist as a document** (`PRD-023` §14.1,
Rank-1 mandated by `MP-NFR-06`/`MP-NFR-08`). ⛔ So these three component requests
name an owner that cannot yet receive them — carried as **`DD7-GAP-007`**.

---

## 11. UI/UX architecture

### 11.1 Surface inventory — 4 surfaces, every one traced

| ID | Surface | App | Roles | Scope | Traces to | Status |
|---|---|---|---|---|---|---|
| **`C-1`** | **Settings home** — categories, effective values at a glance | APP 2 | `TR-1` · `TR-2` · `TR-3` | `Tenant` + `Library` | `CNF-FR-076`, `CNF-FR-077`, `ADR-0151` §2.3 | ⭐ **DESIGNABLE** |
| **`C-2`** | **Parameter detail / edit** — one parameter, its range, its origin | APP 2 | `TR-1` · `TR-2` *(runtime)* · `TR-3` read-only | `Tenant` or `Library` | `CNF-FR-078`, `CNF-FR-079`, `CNF-FR-080`, `CNF-FR-081` | ⭐ **DESIGNABLE** |
| **`C-3`** | **Scope selector** — which populated scope is being edited | APP 2 | `TR-1` · `TR-2` | `Tenant` / `Library` | `PRD-023` §12.2 *(scope selector)*, `CNF-FR-009`, `CNF-FR-011` | ⭐ **DESIGNABLE** |
| **`C-4`** | **Change history** — read-projection of the audit trail | APP 2 | ⚠️ **roles UNRESOLVED** | `Tenant` | `CNF-FR-060`, `CNF-BR-006` | ⛔ **BLOCKED — `DD7-GAP-008`** |

⭐ **3 of 4 designable now.** ⛔ `C-4` is blocked: `CNF-BR-006` says history
*"**SHALL** be reconstructible from the audit trail"* and `CNF-XC-010` forbids
`BC-25` to hold a query surface — ⛔ so the reader is `BC-24`/`PRD-016`, and
⛔ **no source allocates `TR-1`/`TR-2`/`TR-3` read on configuration audit
entries.** ⛔ Designing it would invent an authorization.

### 11.2 Information architecture

```
APP 2 — Library App
└── Settings (C-1)                      TR-1 · TR-2 · TR-3
      ├── Scope selector (C-3)          TR-1 · TR-2      ⛔ 2 options, not 5
      ├── Membership & billing          9 MM-CFG rows
      │     └── Parameter detail (C-2)
      ├── Library presentation          LCFG-2,4,5,7,8
      ├── Money & currency              LCFG-3 + MM-CFG-001    ⚠️ commercial
      ├── Space layout                  LCFG-9, LCFG-10
      ├── Time                          LCFG-1 (+ MM-CFG-006)  ⚠️ CNF-D-1
      ├── Platform-managed (read-only)  LCFG-6,11,12,13        ⛔ 0 write affordance
      └── Change history (C-4)          ⛔ BLOCKED
```

⭐ **Grouping is by the operator's mental model, not by register prefix.** ⚠️ A
library owner does not think *"`MM-CFG` versus `LCFG`"* — ⛔ those are ownership
facts, not user concepts. ⭐ **Money & currency** deliberately co-locates
`LCFG-3` and `MM-CFG-001` because they are the same question at two scopes
(§13 `I-1`).

### 11.3 Layout

| Breakpoint | Layout | Basis |
|---|---|---|
| **Mobile portrait** *(primary)* | Single column; category list → detail push | **`MP-NFR-06`** *"Mobile-first, accessible, portrait-optimised"*; **`CNF-FR-082`** |
| **Tablet / desktop** | Two-pane: categories left, detail right | ⭐ Reuses `LayoutBuilder` + `BoxConstraints(maxWidth:)` from `login_screen.dart` |

⭐ **Reserved slots** for the inherited badge and the validation message, so a
value change or a refusal ⛔ never reflows the row *(UI/UX Pro Max — Content
Jumping, High)*.

⛔ **No numeric breakpoint is asserted.** ⚠️ `PRD-023` §14.1 records that the
`NFR Budgets (V1)` document **does not exist**, and `MASTER_PRD` L663 defers
measurable targets to it. ⛔ Inventing `600dp` would be inventing an NFR →
**`DD7-GAP-009`**.

---

## 12. Role experiences — three treatments, not one screen greyed by role

⛔⛔ README §2B.4 rule 6: `TR-1`/`TR-2`/`TR-3` *"are Library-App roles with
different permissions, and the design **MUST** respect the differences — ⛔ not
render one screen and grey controls out by role as an afterthought."*

### 12.1 `TR-1` Owner — the configuring role

⭐ Writes **18** of 22 *(all but the 4 platform-default)*. ⭐ Reads all 22.
⭐ **This is the only role for whom Settings is a primary task surface**; the IA
in §11.2 is designed for this user.

### 12.2 `TR-2` Manager — the partial writer

⭐ Reads all 22. ⛔ **Denied write on the 4 commercial parameters**
(`MM-CFG-001`, `MM-CFG-007`, `MM-CFG-009`, `LCFG-3`) at **both** Tenant and
Library scope (`ADR-0151` §3.2, PO answer **C = YES**).
⚠️ On the 18 non-commercial, editability is **runtime-resolved** (§8.1).

⭐⭐ **`CNF-FR-081`'s own note is the design brief here:** *"a Manager sees
library configuration and may change part of it. Hiding the commercial
parameters misrepresents the library's state; showing them as editable produces
a refusal after the effort. **Read-only is the only honest rendering.**"*

### 12.3 `TR-3` Reception — the read-only role, with 9 rows absent

⛔ Writes **nothing** (`PRD-001` L612 — *"Cannot alter library configuration"*).
⭐ Reads **13** of 22. ⛔ **9 rows are ABSENT, not greyed** (§8.2).

⭐ What `TR-3` sees, and why it is coherent rather than arbitrary: timezone,
date format, language, currency, the two dating bounds, the expiring-soon
threshold, enrollment-state staleness, the directory switch, floors and zones —
⭐ **every one of these is a value the desk visibly depends on to serve a person**
(`prd-v2/02` L175). ⛔ What it does not see: retention windows, public-discovery
internals, gallery caps, and the two payment-lifecycle parameters.

### 12.4 ⭐ Why this is three treatments and not one

| | `TR-1` | `TR-2` | `TR-3` |
|---|---|---|---|
| Rows visible | 22 | 22 | ⭐ **13** |
| Rows editable | 18 | ⚠️ ≤14, runtime-resolved | ⭐ **0** |
| Primary intent | Configure | Operate, with commercial guard-rails | ⭐ **Consult** |
| Landing behaviour | Category list | Category list | ⭐ **Flat readable list — ⛔ no scope selector** |

⭐⭐ **`TR-3` gets no scope selector at all**, because selecting a scope is an
act preparatory to writing, and `TR-3` never writes. ⛔ Offering it would be the
*"editable-then-refused"* pattern `CNF-FR-081` forbids, displaced one level up.

### 12.5 ⛔ Authorization is never inferred from the surface

⛔ The UI **MUST NOT** treat row visibility as permission. `CNF-XC-006`: the
module **MUST NOT** *"make, cache, store or evaluate an authorisation
decision"*; `CNF-FR-064`: every write is authorised **before** it reaches the
module; `CNF-FR-066`: **no** write surface may be reachable without passing the
authorising boundary. ⭐ The renderings above are a **presentation of** an
authorization decision, ⛔ never a substitute for one.

---

## 13. Configuration impact model

⭐ For each authorized parameter where evidence permits. ⛔ Where the frozen
source is silent, the cell reads **OPEN** — ⛔ behaviour is not invented.

⭐ **One rule governs every row** — **`CNF-BR-007`**: *"A configuration change
**SHALL** take effect only for resolutions performed after it commits. The
module **SHALL NOT** retroactively alter a value already resolved."*
⭐⭐ **So the answer to *"are existing records affected?"* is NO for all 18**, and
that is a frozen guarantee the UI must state plainly, not a design choice.

| Configuration | Affected BC / module | Affected actor | Effect timing | Existing records affected? | Reversible? | Warning? | Confirm? | Audit |
|---|---|---|---|---|---|---|---|---|
| `MM-CFG-001` Currency | `BC-02` | Staff, students | Next resolution | ⛔ **No** — `MM-FR-040` persists `currencySnapshot` | ⭐ Yes | ⭐⭐ **Yes — commercial** | ⭐ Yes | `CNF-FR-060` |
| `MM-CFG-002` Enrollment-state staleness | `BC-02` | Staff | Next resolution | ⛔ No (`CNF-BR-007`) | ⭐ Yes | ⛔ No | ⛔ No | `CNF-FR-060` |
| `MM-CFG-003` Back-dating bound | `BC-02` | `TR-3` at the desk | Next create | ⛔ No | ⭐ Yes | ⚠️ **OPEN** | ⛔ No | `CNF-FR-060` |
| `MM-CFG-004` Forward-dating bound | `BC-02` | Staff | Next create | ⛔ No | ⭐ Yes | ⚠️ **OPEN** | ⛔ No | `CNF-FR-060` |
| `MM-CFG-005` Idempotency retention | `BC-02` | ⛔ None visible | Next resolution | ⛔ No | ⭐ Yes | ⛔ No | ⛔ No | `CNF-FR-060` |
| `MM-CFG-006` Tenant timezone | `BC-02`, `BC-06`, `BC-04` | ⭐⭐ **Everyone** | Next resolution | ⛔ No | ⭐ Yes | ⭐⭐ **Yes — broadest blast radius** | ⭐ Yes | `CNF-FR-060` |
| `MM-CFG-007` Auto-void window | `BC-02`, `BC-05` | Students with unpaid memberships | Next evaluation | ⛔ No | ⭐ Yes | ⭐⭐ **Yes — commercial** | ⭐ Yes | `CNF-FR-060` |
| `MM-CFG-008` Expiring-soon threshold | `BC-02` *(`MM-EVT-006` + view)* | Students, staff | Next evaluation | ⛔ No | ⭐ Yes | ⚠️ Yes — ⭐ `MM-BR-026` single-threshold rule | ⛔ No | `CNF-FR-060` |
| `MM-CFG-009` Term re-derivation | `BC-02` | Students paying late | Next activation | ⛔ No | ⭐ Yes | ⭐⭐ **Yes — commercial** | ⭐ Yes | `CNF-FR-060` |
| `LCFG-1` Time Zone | ⭐ *"every time-bearing operational rule"* (`LIB-16.8`, `LIB-12.4`) | ⭐⭐ **Everyone** | Next resolution | ⛔ No | ⭐ Yes | ⭐⭐ **Yes** | ⭐ Yes | `CNF-FR-060` |
| `LCFG-2` Language | UI strings | All users | Next resolution | ⛔ No | ⭐ Yes | ⛔ No | ⛔ No | `CNF-FR-060` |
| `LCFG-3` Currency | Display + reporting (`LIB-16.7`) | Staff, students | Next resolution | ⛔ No | ⭐ Yes | ⭐⭐ **Yes — commercial** | ⭐ Yes | `CNF-FR-060` |
| `LCFG-4` Date Format | All date rendering | All users | Next resolution | ⛔ No | ⭐ Yes | ⛔ No | ⛔ No | `CNF-FR-060` |
| `LCFG-5` Member Directory | `BC-01` (`LMD-6`), `BC-10` | ⭐⭐ **Students — visibility to each other** | Immediate (`LIB-16.6`) | ⛔ No — *"without deleting any membership or student record"* | ⭐ Yes | ⭐⭐ **Yes — privacy** | ⭐ Yes | `CNF-FR-060` |
| `LCFG-7` Gallery images / branch | `BC-03`, `BC-29` | Public viewers | Next resolution | ⚠️ **OPEN** — ⛔ no source states what happens to images already above a lowered cap | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | `CNF-FR-060` |
| `LCFG-8` Facilities in list | `BC-03` | Public viewers | Next resolution | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | `CNF-FR-060` |
| `LCFG-9` Floors / branch | `BC-04` | Staff, students | Next resolution | ⚠️ **OPEN** — ⛔ no source states the effect on existing floors above a lowered cap | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | `CNF-FR-060` |
| `LCFG-10` Zones / floor | `BC-04` | Staff, students | Next resolution | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | ⚠️ **OPEN** | `CNF-FR-060` |
| `LCFG-6`/`11`/`12`/`13` | — | — | ⛔ **Not writable** | n/a | n/a | n/a | n/a | n/a |

⚠️⚠️ **Four rows carry OPEN cells, and the pattern is identical:
lowering a cap below existing usage.** ⛔ `PRD-023` cannot answer it — the
parameters belong to `PRD-002` and `PRD-007`, and `CNF-XC-001` forbids `BC-25`
to interpret them. ⭐ Recorded once as **`DD7-GAP-010`**.

### 13.1 ⭐ Two named dependency couplings

| ID | Coupling | Evidence | Design consequence |
|---|---|---|---|
| **`I-1`** | `MM-CFG-001` *(Tenant currency)* ↔ `LCFG-3` *(Library currency)* | Both COMMERCIAL; `MM-FR-008` binds `currency` to `price` | ⭐ Co-located in **Money & currency**; ⭐ the detail surface shows **which scope is winning** (`CNF-FR-077`) |
| **`I-2`** | `MM-CFG-006` *(Tenant timezone)* ↔ `LCFG-1` *(Time Zone)* | `LIB-16.8` *"a single tenant-wide value"*; `LIB-12.4` | ⚠️ **Two parameters appear to govern one concept** → **`DD7-GAP-004`** |

⚠️ **`I-2` is a real finding, not a presentation problem.** ⛔ This document does
**not** decide which wins; ⛔ it renders both with their scopes visible and
routes the question.

---

## 14. Accessibility

⭐ `MP-NFR-08` names the **UI Design System** as owner of WCAG targets;
`CNF-FR-082` requires configuration surfaces to meet them; `CNF-XC-016` forbids
`BC-25` to define conformance levels.

| Requirement | Design | Source |
|---|---|---|
| Every input has a persistent visible label | ⛔ No placeholder-only fields | UI/UX Pro Max *(High)*; `MP-NFR-08` |
| Refusal is announced, not only coloured | Reason is text against the field | **`CNF-FR-079`** |
| Inherited-vs-override not conveyed by colour alone | ⭐ `Pill` carries **text** (*"Inherited from Platform default"*), ⛔ not a tint | **`CNF-FR-076`** — *"**SHALL NOT** be visually identical"*; colour-only would fail for colour-blind users |
| Range announced before entry | Helper text, ⛔ not a tooltip | **`CNF-FR-080`** |
| Focus order follows reading order | Category → row → control | `MP-NFR-08` |
| Touch targets | ⚠️ **OPEN — no authoritative minimum exists** | ⛔ `NFR Budgets (V1)` absent → `DD7-GAP-009` |

⛔ **No contrast ratio, target size or timing value is asserted.** ⚠️ `DD-0006`
set the precedent of **declining** to name a contrast ratio; ⭐ the same refusal
applies here.

---

## 15. State, error and recovery model

### 15.1 States

| State | Behaviour | Source |
|---|---|---|
| **Loading** | ⭐ Skeleton in the **reserved row slot** | ⛔ No flash-of-empty; UI/UX Pro Max *(Content Jumping)* |
| **Loaded** | Rows with value + origin badge | `CNF-FR-076`, `CNF-FR-077` |
| **Saving** | Row-scoped busy state; ⛔ **the rest of the surface stays usable** | UI/UX Pro Max *(Submit Feedback)* |
| **Saved** | ⭐ Badge flips *Inherited → Set here*; ⭐ **the change is the feedback** | `CNF-FR-076` |
| **Validation failure** | ⭐ Specific reason **against the field**; ⭐ **previous value remains in force** | **`CNF-FR-022`**, **`CNF-FR-067`** |
| **Refused on authority** | ⭐ Same treatment as validation refusal; ⛔ stored configuration unchanged | **`CNF-FR-067`** |
| **Network failure** | ⚠️ Retry affordance; ⛔ **no optimistic UI** | ⭐ §15.4 |
| **Stale / concurrent** | ⚠️ **OPEN** | ⭐ §15.5 |
| **Empty** | ⭐ `EmptyState` when a role can read 0 rows in a category | `common.dart` L237 |

### 15.2 ⭐⭐ Partial application is impossible, and the UI must say so

**`CNF-FR-067`** — a refused write *"**SHALL** leave stored configuration
unchanged… and **SHALL NOT** be partially applied."* ⭐ So the surface **MUST
NOT** show a half-saved row, and ⛔ **MUST NOT** offer *"save all"* across
multiple parameters unless the backend guarantees atomicity — ⛔ which no source
states. ⭐ **Design: one parameter, one write.** ⛔ No bulk save.

### 15.3 Validation

⭐ Validate **on blur** against the declared range *(UI/UX Pro Max, Medium)*, and
⭐ show the range **before** entry (`CNF-FR-080`). ⭐ `CNF-FR-024` guarantees every
parameter has a default **and** a range, so ⛔ there is never a field without a
stated domain.

⚠️ **ADAPTED from UI/UX Pro Max:** an error summary may supplement inline errors,
⛔ but **never replace** them — `CNF-FR-079`: *"A refused write **SHALL** present
the specific reason **against the field** that caused it. A refusal **SHALL NOT**
be presented as a generic failure."*

### 15.4 ⭐ Network failure — no optimistic UI

⛔ **The value must not appear changed until the write commits.** ⭐ `CNF-BR-007`
makes commit the moment of effect; ⚠️ an optimistic row would assert an effective
value that does not exist — the *"derived, never stored"* confusion `CNF-INV-004`
guards. ⭐ **Design: row stays at its previous value, with a retry affordance.**

⚠️ **Indian-market note *(design consideration only)*:** intermittent
connectivity is common; ⛔ but `MP-CON-11` and `CONFIGURATION_GUIDE` §4 rule 2
bar convenience relaxations, and **`CNF-FR-066`** bars **any** write path that
does not pass the authorising boundary. ⛔ **So no offline queue for
configuration writes is proposed.** ⭐ Retry, not queue.

### 15.5 ⚠️ Concurrency and staleness — OPEN

⛔ **`PRD-023` specifies no optimistic-concurrency token, version field, or
last-writer rule for configuration writes.** Measured: **0** occurrences of
`etag`, `version conflict` or `concurrent write` in `PRD-023`.

⛔ **This document does not invent one.** ⚠️ Two Owners editing the same
parameter is a realistic scenario in a small library team, and the outcome is
**undetermined** → **`DD7-GAP-011`**, owner **Architecture Owner + `PRD-023`**.

---

## 16. Security and privacy

| Threat | Mitigation | Source | Status |
|---|---|---|---|
| **Unauthorized change** | Authorisation at the boundary; ⛔ no surface bypasses it | `CNF-FR-064`, **`CNF-FR-066`** | ⭐ Frozen |
| **Privilege escalation via UI** | ⛔ Visibility ≠ permission; `BC-18` decides at request time | `CNF-XC-006`, `CNF-XC-014` | ⭐ Frozen |
| **Cross-tenant leakage** | ⛔ No resolution returns another tenant's value — including via cache, error text, log or telemetry | **`CNF-INV-003`**, **`CNF-INV-004`** | ⚠️ **Unverifiable — `CNF-GAP-008`**, `tenant_isolation_test.dart` does not exist |
| **Cross-library leakage** | Scope is an explicit input; ⛔ never inferred | `CNF-FR-012` | ⭐ Frozen |
| **Tampered client request** | ⛔ Client-side rendering is not a control; server authorises | `CNF-FR-064` | ⭐ Frozen |
| **Replay** | ⚠️ **OPEN** — ⛔ no idempotency rule for configuration writes | — | ⚠️ **`DD7-GAP-012`** |
| **Audit tampering** | ⛔ `BC-25` **MUST NOT** store or query audit entries | `CNF-XC-010`, `CNF-FR-061` | ⭐ Frozen |
| **Financial disclosure to `TR-3`** | ⭐ 2 rows **absent**, not greyed | **`AC-7.8`**; §8.2 | ⭐ Frozen |

⛔ **No security control is invented.** ⚠️ `DD7-GAP-012` is recorded as a
**recommendation to route**, ⛔ not as a requirement.

---

## 17. Auditability

⭐ Every write emits an audit fact carrying **parameter, scope, actor, previous
value, new value** (`CNF-FR-060`), through **`E-20`** to `BC-24`
(`CNF-FR-061`). ⭐ Removing an override is **its own auditable action**
(`CNF-FR-062`), which is why `ResetToInheritedControl` is a distinct control and
not a value-set in disguise (§10.1).

⛔ **`BC-25` keeps no second history** (`CNF-BR-006`, `CNF-XC-010`) — which is
precisely why surface `C-4` is **BLOCKED** (§11.1).

---

## 18. Student impact — what changes for students

⛔ **Students have 0 surfaces here** (§5.2). ⭐ They experience configuration
**only** as changed behaviour elsewhere:

| Configuration | What the student experiences | Immediate or future? |
|---|---|---|
| `LCFG-5` Member Directory | ⭐⭐ Whether other students can see they study here | ⭐ **Immediate** (`LIB-16.6`) |
| `MM-CFG-008` Expiring-soon | When the renewal reminder arrives (`MM-EVT-006`) | Future evaluations |
| `MM-CFG-007` Auto-void | ⭐⭐ How long an unpaid membership survives | Future evaluations |
| `MM-CFG-009` Term re-derivation | ⭐⭐ Whether a late payment shortens the paid term | Next activation |
| `LCFG-1`/`MM-CFG-006` Timezone | Which day an action counts on | Next resolution |
| `LCFG-3`/`MM-CFG-001` Currency | The denomination of displayed amounts | Next resolution |

⭐⭐ **Existing memberships, seats, attendance and fees are NOT retroactively
altered** — `CNF-BR-007`, reinforced by `MM-FR-040` (`priceSnapshot`,
`currencySnapshot`) and `MM-AC-005` (*"editing a plan's price leaves every
existing membership's `priceSnapshot` byte-identical"*).

⭐ **Design consequence:** the confirmation copy for commercial parameters
**MUST** state *"applies from the next …"* and ⭐ **reassure that existing records
are untouched** — the same reasoning `DD-0003` §16.2 reached for `ATT-FR-103`.

---

## 19. Human behaviour

⛔ **Design considerations only.** ⛔ None is converted into a requirement.

| Risk | Where it bites | Design response | Evidence anchor |
|---|---|---|---|
| ⭐⭐ **"Reset" misunderstood as "type the parent's value"** | `CNF-FR-078` | Distinct control; ⛔ never a pre-filled field | **`CNF-FR-078`**'s own note names this failure |
| **Inherited value read as "set here"** | Every row | Persistent textual badge, ⛔ not a subtle tint | **`CNF-FR-076`** |
| **Trial-and-error entry** | Numeric bounds | Range shown **before** entry | **`CNF-FR-080`** |
| ⭐ **Fear that a change rewrites history** | Timezone, currency, thresholds | Confirmation states *"applies from the next …; existing records unchanged"* | `CNF-BR-007`; `DD-0003` precedent |
| **Cognitive load of 22 rows** | `C-1` | 6 task-shaped categories (§11.2), ⛔ not one long list | UX judgement — ⛔ recommendation |
| **Refusal after effort** | `TR-2` on commercial rows | Read-only **from the start** | **`CNF-FR-081`** note |

---

## 20. Indian-market considerations

⛔ **Design considerations only**, per the brief.

| Consideration | Repository anchor | Design response |
|---|---|---|
| Android / mobile-first | **`MP-NFR-06`**; `CNF-FR-082` | Portrait single-column primary (§11.3) |
| ₹ currency | `LCFG-3` default **`INR`**; `MM-CFG-001` default `INR` | ⭐ Defaults render as-is; ⛔ **no digit-grouping convention asserted** — `DD-0006` declined the same choice (`DD6-TBD-001`) |
| Indian date convention | `LCFG-4` default **`dd/MM/yyyy`**, *"`MM/dd` is a data-entry hazard"* | ⭐ Date rendering follows `LCFG-4`; ⛔ never hard-coded |
| Timezone | `LCFG-1` default **`Asia/Kolkata`**; `MM-CFG-006` same | ⭐ Surfaced with its scope (§13 `I-2`) |
| Small teams, non-technical operators | ⭐ `TR-1` is often the proprietor | Plain-language labels; ⛔ no register prefixes in the UI |
| Multiple branches | ⚠️ Branch scope is **unpopulated** (`CNF-GAP-003`) | ⛔ **No branch selector** (§7) |
| Low bandwidth | `MP-NFR-06` | ⛔ No optimistic UI; retry, ⛔ not queue (§15.4) |
| Language | `LCFG-2` default `en`, *"Only locale with complete strings at V1"* | ⛔ **No second locale asserted**; the supported set is undefined (§6.3.2) |

---

## 21. User journeys

⭐ Each row classifies its basis. ⛔ Recommendations are never stated as
requirements.

| # | Journey | Frozen requirement | Architecture constraint | Accepted ADR | Design recommendation | Open decision |
|---|---|---|---|---|---|---|
| 1 | **Owner changes an authorized configuration** | `CNF-FR-076`…`080`; `CNF-FR-060` | `E-19`; `CNF-FR-064` | `ADR-0151` §2.3 `TR-1` ✅ | Row → detail → range-bounded entry → confirm → badge flips | — |
| 2 | **Manager changes a non-commercial configuration** | `CNF-FR-081` | `CNF-XC-006` — `BC-18` decides | ⚠️ `ADR-0151` §2.4 *existing model* | ⭐ Render from the runtime decision; ⛔ do **not** hard-code | ⚠️ `TR-2` position on the 18 |
| 3 | **Manager attempts a commercial configuration** | `CNF-FR-081` | — | ⭐ `ADR-0151` §2.3 `TR-2` ⛔ DENY | ⭐ **Read-only from the start**, with the reason visible; ⛔ never editable-then-refused | — |
| 4 | **Reception views an allowed configuration** | `CNF-FR-081`; `AC-7.8` | — | ⭐ `ADR-0151` §2.3 — 13 ALLOW / 9 DENY | ⭐ 13 read-only rows; ⛔ **9 absent**, ⛔ no scope selector | — |
| 5 | **Invalid value entered** | **`CNF-FR-022`**, **`CNF-FR-067`**, `CNF-FR-080` | `LIB-16.3` — ⛔ never partially applied | — | Blur validation; reason against the field; ⭐ previous value stands | — |
| 6 | **Dependency / constraint conflict** | `CNF-INV-001` — ⛔ no read served while an invariant is unsatisfied; `INV-10`/`11`/`12` | `CNF-INV-002` | — | ⭐ Show the prerequisite **inline** *(the `DD-0003` §16.2 pattern)* | ⚠️ Cross-register invariants touch `CFG-*`, which are **NOT authorized** |
| 7 | **Network fails during save** | `CNF-FR-067` | `CNF-FR-066` — ⛔ no bypass path | — | ⛔ No optimistic UI; retry affordance | ⚠️ Retry semantics → `DD7-GAP-012` |
| 8 | **Concurrent / stale edit** | ⛔ **none** | ⛔ **none** | ⛔ **none** | ⛔ **Nothing designed** | ⛔⛔ **`DD7-GAP-011`** |
| 9 | **Change affects students / memberships / seats / attendance / fees** | **`CNF-BR-007`**; `MM-FR-040`; `MM-AC-005` | `E-19` | — | Confirmation states *"from the next …; existing records unchanged"* (§18) | ⚠️ Cap-lowering → `DD7-GAP-010` |
| 10 | **Mobile workflow** | `MP-NFR-06`; `CNF-FR-082` | — | — | Portrait single-column; category → detail push | ⚠️ Targets → `DD7-GAP-009` |
| 11 | **Desktop / tablet workflow** | `MP-NFR-06` | — | — | Two-pane via the existing `LayoutBuilder` pattern | ⚠️ Breakpoint → `DD7-GAP-009` |

⛔ **Journey 8 is designed as BLOCKED, not guessed.** ⭐ That is the honest
outcome when the frozen source is silent on a real scenario.

---

## 22. Open gaps

⛔⛔ **`DD7-GAP-*` are proposed design-doc identifiers carrying NO authority.**
⛔ They are **not** added to any closed register — `CNF-GAP-*` remains **8** in
`FROZEN` `PRD-023`, and this document extends it by nothing.

| ID | Gap | Blocking? | Owner | Lawful instrument |
|---|---|---|---|---|
| ⭐⭐ **`DD7-GAP-001`** | ~~`SECP-HRO-005` vs `CNF-FR-020`~~ — ⭐⭐ **CLOSED** by `Accepted` **`ADR-0152`** §8.1. ⚠️ The v0.1 premise *("Rank 3 vs Rank 3")* was **false**: `PRD-012a` Part 2 is **Unranked** (§5.3), so precedence resolves it | ⭐ **CLOSED** | — | ⭐ Discharged by `ADR-0152` |
| ⭐ **`DD7-GAP-002`** | ***"Platform configuration" is not a defined parameter set*** — **23** uses repo-wide, **0** definitions. ⭐⭐ **MOOT for the runtime APP 3 surface** (`ADR-0152` §8.2): its precondition *"even if APP 3 has a surface"* is settled in the negative. ⚠️⚠️ **The definitional gap itself REMAINS — still 0 definitions** — and returns if any future act needs the set enumerated | ⛔ **No longer blocking** | Product Owner + Architecture Owner | ⭐ `ADR-0152-F-2` — Rank 2 ADR or `PRD-023` amendment |
| ⛔ **`DD7-GAP-003`** | **Does `BC-25` own a configuration SURFACE at all, or does each owning module render its own?** ⚠️ `DD-0003` `S-L8` renders 24 `ATT-CFG-*` as a `BC-06` surface — evidence for the distributed reading | ⚠️ **Shapes scope, not validity** | Product Owner + UX Architecture Owner | Product decision |
| ⚠️ **`DD7-GAP-004`** | **`MM-CFG-006` and `LCFG-1` both govern timezone** at Tenant scope. ⛔ Which prevails is unstated | ⛔ No — both render | Architecture Owner | Clarification in an owning PRD |
| ⚠️ **`DD7-GAP-005`** | **`MM-CFG-008` and `SMCFG-3` are both *"expiring-soon threshold"*.** `MM-BR-026` binds `MM-CFG-008` to one view **and** `MM-EVT-006`; `LMD-26` requires the Directory's threshold configurable. ⛔ Relationship unstated, and `SMCFG-3` is **NOT authorized** | ⛔ No | Product Owner | Clarification in `PRD-004`/`PRD-005` |
| ⚠️ **`DD7-GAP-006`** | **`SEAT-CFG-005` and `SEAT-CFG-014` are authorization-shaped parameters** — *"which roles beyond Owner may override"*, *"whether Reception may cancel"*. ⛔ A parameter that grants authority cannot be self-authorizing | ⛔ No — both `NOT YET AUTHORIZED` | Authorization (`BC-18`) Owner + PO | Rank 2 ADR |
| ⚠️ **`DD7-GAP-007`** | **The UI Design System does not exist as a document**, yet `MP-NFR-06`/`MP-NFR-08` name it owner and §10.1 requests 3 components from it | ⚠️ Blocks token-level design | Governance Owner | Create the Rank-1 artefact |
| ⛔ **`DD7-GAP-008`** | **Surface `C-4` Change history has no authorized reader.** `CNF-BR-006` routes history to the audit trail; `CNF-XC-010` bars `BC-25` from a query surface; ⛔ no source allocates staff read on `BC-24` configuration entries | ⭐ **BLOCKING `C-4`** | Authorization Owner + `PRD-016` Owner | Rank 2 ADR |
| ⚠️ **`DD7-GAP-009`** | **No authoritative NFR budget exists** — `NFR Budgets (V1)` absent (`PRD-023` §14.1; `MASTER_PRD` L663). ⛔ No breakpoint, target size, contrast ratio or latency may be asserted | ⚠️ Blocks measurable AC | Governance Owner | Create the document |
| ⚠️ **`DD7-GAP-010`** | **Lowering a cap below existing usage is unspecified** — `LCFG-7`, `LCFG-8`, `LCFG-9`, `LCFG-10`. ⛔ `CNF-XC-001` bars `BC-25` from interpreting them | ⛔ No — rows render | `PRD-002` + `PRD-007` Owners | PRD clarification |
| ⛔ **`DD7-GAP-011`** | **No concurrency / staleness rule for configuration writes.** Measured **0** occurrences of `etag`, `version conflict`, `concurrent write` in `PRD-023` | ⭐ **BLOCKING journey 8** | Architecture Owner + `PRD-023` Owner | `PRD-023` v0.2 or Rank 2 ADR |
| ⚠️ **`DD7-GAP-012`** | **No idempotency / replay rule for configuration writes** | ⛔ No | Security + Architecture Owner | Recommendation to route |
| ⭐ **`DD7-GAP-013`** | ***(new, v0.3)*** **`tool/module_dependencies.yaml` cannot express per-app port granularity.** The `app` module (rank 9) declares **all 11** of its ports at the **app ROOT**, and the schema contains **0** per-app submodules — so the manifest cannot distinguish APP 1 / APP 2 / APP 3 consumption. ⛔ **Not a `BC-25` defect** — it affects every `app` port equally, ⭐ including `DD-0006`'s `platform/analytics:read_model` (**L539**) | ⛔ **No — not a D5 blocker** (§5.4.4); ⭐ authorization is fixed **by role** at `ADR-0151` §2.3, ⛔ never by the manifest | Architecture Owner | Rank 4 manifest question — ⛔ **not** an ADR, ⛔ **not** `DD-0007`'s to resolve |

⚠️⚠️ **`CNF-GAP-002` and `CNF-GAP-007` — RE-VERIFIED OPEN AT THIS AMENDMENT, and
⛔ NEITHER IS CLOSED BY IT.** ⭐ `CNF-GAP-002` *(7 consumers / 0 providers,
**High**)* remains **OPEN** — `ADR-0053` **L131**, *"OPEN. Scheduled, not
resolved"*, **Technical Owner** — dispositioned by `FROZEN` `PRD-023` **L1368**
to *"**Stage 6** — closed by the implementation task that declares the
provider"*. ⭐ `CNF-GAP-007` remains **OPEN**, **Stage 6** (**L1373**), which
`PRD-023` §1.3 calls *"a Stage 6 obligation… **not a defect in the manifest**"*.
⛔⛔ **A Design Doc cannot close either, and v0.3 does not.** ⭐ v0.3 records only
that **neither is a Declaration 5 blocker** (§5.4.3) — ⛔ a statement about which
test they answer, ⛔ not about their status.

⭐ **Inherited and preserved OPEN, not re-litigated:** `CNF-GAP-001`…`008`
(`PRD-023` §14) · `CNF-D-1`, `CNF-D-2` (`ADR-0151` §6) · ⭐ **`CNF-D-3`** *(new,
§6.1 — `PRD-023` §3.6 cites `PRD-005` v1.4; repository is at v1.6)*.

⚠️⚠️ **`DD7-GAP-002` — MOOT is not ANSWERED, and v0.2 preserves the difference.**
⭐ `ADR-0152` §8.2 closes it **as moot** for the runtime APP 3 surface, because its
stated precondition *"even if APP 3 has a surface"* is now settled in the
negative. ⛔ **But *"platform configuration"* still has 0 definitions as a
parameter set** — re-measured at this amendment, unchanged. ⭐ If any future act
needs that set enumerated, the definitional question **returns**, and it is
carried as **`ADR-0152-F-2`**, ⛔ not treated as resolved.

⚠️ **v0.1 recorded this gap as OPEN and blocking, and that was correct when
written** — at the time, measured **0** ADRs referenced `SECP-HRO-005`. ⭐ `ADR-0152`
is that ADR, and it did not exist until after v0.1 was committed.

---

## 23. Decision register

| Decision | Evidence | Authority | Impact | Classification |
|---|---|---|---|---|
| Inherited vs override must be visually distinct | `CNF-FR-076` | `PRD-023` Rank 3 | Every row | ⭐ **Frozen Requirement** |
| Source scope must be named | `CNF-FR-077` | `PRD-023` | Every inherited row | ⭐ **Frozen Requirement** |
| Reset-to-inherited is a distinct operation | `CNF-FR-078` | `PRD-023` | `C-2`, new component | ⭐ **Frozen Requirement** |
| Refusal states a specific reason against the field | `CNF-FR-079` | `PRD-023` | §15.3 | ⭐ **Frozen Requirement** |
| Range shown before a write is attempted | `CNF-FR-080` | `PRD-023` | `RangeBoundedField` | ⭐ **Frozen Requirement** |
| Read-but-not-write renders **read-only** | `CNF-FR-081` | `PRD-023` | `TR-2`, `TR-3` | ⭐ **Frozen Requirement** |
| Portrait-optimised + a11y targets | `CNF-FR-082`, `MP-NFR-06`, `MP-NFR-08` | Rank 1 + 3 | §11.3, §14 | ⭐ **Frozen Requirement** |
| No retroactive effect on existing records | `CNF-BR-007` | `PRD-023` | §13, §18 | ⭐ **Frozen Requirement** |
| Refused write is never partially applied | `CNF-FR-067`, `LIB-16.3` | `PRD-023`, `PRD-002` | §15.2 | ⭐ **Frozen Requirement** |
| Scope 1 unwritable by any actor | `CNF-FR-020`, `CNF-AC-011` | `PRD-023` | 4 parameters ⚪ | ⭐ **Frozen Requirement** |
| `BC-25` evaluates no authorisation | `CNF-XC-006`, `CNF-FR-064` | `PRD-023` | §8, §12.5 | ⭐ **Existing Architecture Constraint** |
| Audit via `E-20` to `BC-24`; no second history | `CNF-FR-060`…`062`, `CNF-BR-006`, `CNF-XC-010` | `PRD-023`, BC Map | §17, `C-4` blocked | ⭐ **Existing Architecture Constraint** |
| Config reaches domain only via `E-19` typed accessors | BC Map **L328**; `CNF-FR-031`, `CNF-FR-037` | Rank 4 + 3 | Whole surface | ⭐ **Existing Architecture Constraint** |
| 22 parameters allocated across `TR-1`/`TR-2`/`TR-3` | `ADR-0151` §2.3 | **Rank 2 Accepted** | §6, §8, §12 | ⭐ **Accepted ADR Decision** |
| `TR-2` commercial restriction reaches Tenant scope | `ADR-0151` §3.2 | Rank 2 | §12.2 | ⭐ **Accepted ADR Decision** |
| `TR-3` read ALLOW 13 / DENY 9 | `ADR-0151` §2.3 | Rank 2 | §12.3 | ⭐ **Accepted ADR Decision** |
| `TR-2` on 18 non-commercial = *existing model* | `ADR-0151` §2.4 | Rank 2 | §8.1 | ⭐ **Accepted ADR Decision** |
| Deny-read renders **absent**, not greyed | `AC-7.8` + `AP-3` applied to `CNF-FR-081` | — | §8.2 | ⚠️ **Design Recommendation** |
| Scope selector offers **2** options, not 5 | `CNF-FR-011` + `CNF-GAP-003` | — | §7, `C-3` | ⚠️ **Design Recommendation** |
| 6 task-shaped categories | UX judgement | — | §11.2 | ⚠️ **Design Recommendation** |
| One parameter, one write — ⛔ no bulk save | `CNF-FR-067` | — | §15.2 | ⚠️ **Design Recommendation** |
| ⛔ No optimistic UI | `CNF-BR-007`, `CNF-INV-004` | — | §15.4 | ⚠️ **Design Recommendation** |
| `TR-3` gets no scope selector | `CNF-FR-081` extended | — | §12.4 | ⚠️ **Design Recommendation** |
| ⭐ **APP 3 = 0 `BC-25` configuration surfaces**; `SECP-HRO-005` is a governance act | **`ADR-0152`** §7 | **Rank 2, Accepted** | Declaration 1 → **PASS** | ⭐ **Accepted ADR Decision** |
| Concurrency behaviour | ⛔ **`DD7-GAP-011`** | — | Journey 8 | ⛔ **Open Product Decision** |
| `C-4` change-history readers | ⛔ **`DD7-GAP-008`** | — | `C-4` | ⛔ **Open Product Decision** |
| Branch / user scope surfaces | `CNF-GAP-003`, `CNF-FR-011` | — | ⛔ Not designed | ⭐ **Future / V2** |
| The other 65 parameters | ⛔ No operation×role source | — | ⛔ Not designed | ⭐ **Future / V2** |
| ⭐ The 17 `ATT-CFG-*` authorized by `ADR-0153` | ⭐ Authorized — ⛔ but `DD7-GAP-003` open; `DD-0003` `S-L8` renders them as a `BC-06` surface | — | ⛔ Not designed **here** | ⭐ **Future** |
| Second locale | `LCFG-2` — *"Only locale with complete strings at V1"* | — | ⛔ Not designed | ⭐ **Future / V2** |

---

## 24. Acceptance criteria

⭐ `DD7-AC-*` are **design** acceptance criteria for this document's surfaces.
⛔ They are **not** `CNF-AC-*` and ⛔ do not extend `PRD-023`'s closed register
of **59**.

| ID | Criterion | Traces to |
|---|---|---|
| `DD7-AC-001` | Every rendered row traces to a parameter listed `AUTHORIZED` or `PLATFORM DEFAULT` in §6.3 | `ADR-0151` |
| `DD7-AC-002` | ⛔ **No** surface renders any of the 65 `NOT YET AUTHORIZED` parameters | §6.2 |
| `DD7-AC-003` | An inherited value and an override are **not** visually identical, and the difference is **not colour-only** | `CNF-FR-076` |
| `DD7-AC-004` | An inherited row names its source scope | `CNF-FR-077` |
| `DD7-AC-005` | Reset-to-inherited exists as a control distinct from setting a value, wherever an override exists | `CNF-FR-078` |
| `DD7-AC-006` | A refusal shows a specific reason against the causing field; ⛔ no generic failure | `CNF-FR-079` |
| `DD7-AC-007` | The declared range is visible **before** entry | `CNF-FR-080` |
| `DD7-AC-008` | A read-but-not-write parameter renders read-only; ⛔ not hidden, ⛔ not editable-then-refused | `CNF-FR-081` |
| `DD7-AC-009` | A **cannot-read** parameter is **absent**; ⛔ no greyed row, ⛔ no lock icon | `AC-7.8`, `AP-3` |
| `DD7-AC-010` | `TR-3` sees exactly **13** of 22 rows and **0** editable controls | `ADR-0151` §2.3 |
| `DD7-AC-011` | `TR-2` sees the **4** commercial rows as read-only at **both** Tenant and Library scope | `ADR-0151` §2.3, §3.2 |
| `DD7-AC-012` | The 4 platform-default parameters expose **0** write affordance to **any** role | `CNF-FR-020`, `CNF-AC-011` |
| `DD7-AC-013` | The scope selector offers exactly the **populated** scopes; ⛔ branch and user are absent | `CNF-FR-011`, `CNF-GAP-003` |
| `DD7-AC-014` | A refused write leaves the displayed value unchanged; ⛔ no partial state | `CNF-FR-067` |
| `DD7-AC-015` | Commercial-parameter confirmation states the change applies from the next resolution and existing records are unchanged | `CNF-BR-007` |
| `DD7-AC-016` | Every write surface is reachable only through the authorising boundary | `CNF-FR-066` |
| `DD7-AC-017` | Every input has a persistent visible label; ⛔ no placeholder-only field | `MP-NFR-08` |
| `DD7-AC-018` | Layout is portrait-optimised and does not reflow on validation | `MP-NFR-06`, `CNF-FR-082` |
| `DD7-AC-019` | ⛔ **No** `PERM-*`, role, action class or scope class is introduced by any surface | `AUTH-7.22`, `ADR-0132` |
| `DD7-AC-020` | ⛔ **No** APP 3 surface, platform-admin API or platform write path exists | `CNF-FR-020`, `AUTH-2.9`; ⭐ **`ADR-0152`** §7 |
| ⚠️ `DD7-AC-021` | **Performance / latency budget** | ⛔ **OPEN — `DD7-GAP-009`.** ⛔ No authoritative budget exists; ⛔ no number invented |
| ⚠️ `DD7-AC-022` | **Contrast ratio / touch-target minimum** | ⛔ **OPEN — `DD7-GAP-007`/`009`.** Owner = UI Design System, which does not exist |

⭐ **20 stated · ⛔ 2 deliberately OPEN.** ⛔ Inventing numbers for the last two
would be the exact defect `PRD-023` §14.1 records.

---

## 25. Figma readiness

⛔⛔ **The Figma gate is NOT OPEN.** ⭐ **3** blockers at v0.3 *(was 4 — blocker 2
cleared; was 5 at v0.1)*:

| # | Blocker | Reference |
|---|---|---|
| 1 | ⭐ ~~Declaration 1 is `GAP`~~ — **CLEARED** at v0.2 by `Accepted` `ADR-0152` | ⭐ **RESOLVED** |
| 2 | ⭐ ~~Declaration 5 is `GAP`~~ — **CLEARED** at v0.3; ⭐ the cross-app position is a **sourced negative** | ⭐ **RESOLVED** — §5.4 |
| 3 | ⛔ **UI Design System does not exist** — no tokens, type scale or a11y targets to bind to | `DD7-GAP-007` |
| 4 | ⛔ **No NFR budgets** — no breakpoint or target size may be drawn | `DD7-GAP-009` |
| 5 | ⛔ **Surface `C-4` has no authorized reader** | `DD7-GAP-008` |

⭐ 3 of 4 surfaces are **specified** well enough to prototype once 3–5 clear;
⛔ the gate is a governance state, not a completeness state.

⚠️⚠️ **Clearing D5 does NOT open the gate, and ⛔ it must not be read as doing
so.** ⭐ Three blockers stand, and ⚠️ **Declaration 3 remains `PARTIAL` at
39 / 104** — ⛔ **65 parameters are NOT authorized and MUST NOT be prototyped**.

---

## 26. Final readiness verdict

# ⚠️ DESIGNED WITH EXPLICIT BLOCKERS

| Dimension | Result |
|---|---|
| Surfaces specified | ⭐ **3 of 4** (`C-1`, `C-2`, `C-3`); ⛔ `C-4` BLOCKED |
| Parameters designed | ⭐ **18 editable + 4 read-only = 22**; ⛔ **82 not designed** *(⚠️ incl. the 17 newly **authorized** `ATT-CFG-*` — `DD7-GAP-003` open)* |
| Authorization coverage | ⚠️ **39 / 104 = 37.5%** — ⭐ **22** `ADR-0151` + ⭐ **17** `ADR-0153` |
| §2B declarations | ⭐ D1 **PASS** · ⭐ D2 **PASS** · ⚠️ **D3 `PARTIAL`** · ⭐ D4 **PASS** · ⭐ D5 **PASS** |
| App-Boundary QA | ⭐⭐ **13 / 13 PASS**, 0 GAP |
| New `PERM-*` / roles / actions / scopes | ⛔ **0 / 0 / 0 / 0** |
| Frozen documents modified | ⛔ **0** |
| Runtime code changed | ⛔ **0 lines** |

⛔⛔ **`DD-0007` is STILL NOT design-ready under README §2B.5** — ⭐ and v0.3
narrows the reason to **one**, rather than removing it.

⚠️⚠️ **DECLARATION 3 IS STILL THE SOLE REMAINING BLOCKER, AND IT IS THE REAL ONE.**
⛔ `ADR-0151` *(22)* and `ADR-0153` *(17)* are the **only** operation×role
sources for any `BC-25` parameter and together they cover **39 of 104**. ⛔ The
other **65 remain `NOT YET AUTHORIZED`** — ⛔ no role, ⛔ no action class, ⛔ no
scope, ⛔ no `PERM-*`. ⭐ Under README §2B.5 an unsourced declaration is not
design-ready, ⭐ and **`PARTIAL` is disclosed exactly as measured**, ⛔ never
rounded to `PASS`. ⭐ **This document is the classification.**

⭐⭐ **What v0.4 changed, stated narrowly:** ⭐ authorization coverage
**22/104 → 39/104**, by recording `Accepted` **`ADR-0153`**'s allocation of
**17** `ATT-CFG-*` parameters. ⛔ **D3 remains `PARTIAL`** — ⛔ it does **not**
become `PASS`, and ⛔ **104/104 is NOT claimed**. ⛔ **Nothing else moved.**

⛔⛔ **WHAT v0.4 EXPRESSLY DID NOT DO:** ⛔ **`CNF-GAP-002` remains OPEN**
*(High, Stage 6)* · ⛔ **`CNF-GAP-007` remains OPEN** *(Stage 6)* · ⛔ **D1, D2,
D4, D5 untouched** · ⛔ **7 `ATT-CFG-*` held** — `013`…`016`, `022`, `023`,
`024` · ⛔ **0** `PERM-*`, roles, action classes or scopes minted · ⛔
`ADR-0151`, `ADR-0152`, `PRD-006`, `PRD-023` and `AUTH-7.22` **byte-unchanged**
· ⛔ **`G-5` NOT corrected** — still an **Architecture Owner** item
(`ADR-0153` §6) · ⛔ **0** lines of runtime code · ⚠️ **no new surface designed**
— the 17 are **authorized, not designed** (`DD7-GAP-003`).

⭐⭐ **What v0.3 changed, stated narrowly:** ⭐ **D5 `GAP` → `PASS`**, because the
cross-app position is **declared and sourced** as a measured **negative** —
`ADR-0151` §2.3 places every authorized role in **APP 2**, §5.2 measures
**APP 1 = 0**, `ADR-0152` §7 settles **APP 3 = 0**, and `DD-0001` §4.0.4 holds
that a bounded-context edge is not an app boundary. ⛔ **Nothing else moved.**

⛔⛔ **WHAT v0.3 EXPRESSLY DID NOT DO:** ⛔ **`CNF-GAP-002` remains OPEN**
*(High, 7 consumers / 0 providers, **Stage 6**, Technical Owner)* · ⛔
**`CNF-GAP-007` remains OPEN** *(**Stage 6**)* — ⭐ v0.3 records only that
**neither is a Declaration 5 blocker** (§5.4.3), ⛔ **not** that either is
resolved · ⛔ **D3 is untouched at 22 / 104** · ⛔ **0** of the 82 parameters
authorized · ⛔ **0** `PERM-*`, roles, action classes or scopes minted · ⛔
`ADR-0151`, `ADR-0152`, `PRD-023` and `AUTH-7.22` **byte-unchanged** · ⛔ **0**
lines of runtime code.

---

## 27. Traceability

| `PRD-023` requirement | Where honoured |
|---|---|
| `CNF-FR-009`, `CNF-FR-010`, `CNF-FR-011` | §7 |
| `CNF-FR-018`, `CNF-FR-019` | §10.1, §17 |
| `CNF-FR-020` | §7, §8, §13, `DD7-AC-012` |
| `CNF-FR-022`, `CNF-FR-024` | §15.1, §15.3 |
| `CNF-FR-060`…`063` | §17 |
| `CNF-FR-064`, `CNF-FR-066`, `CNF-FR-067` | §8, §15.2, §16 |
| `CNF-FR-076`…`CNF-FR-082` | §8, §10, §11, §14, §15, §24 |
| `CNF-BR-006`, `CNF-BR-007`, `CNF-BR-008`, `CNF-BR-009`, `CNF-BR-010` | §8, §13, §17, §18 |
| `CNF-INV-001`…`004` | §16, journey 6 |
| `CNF-XC-001`, `002`, `006`, `010`, `014`, `016` | §1.2, §8, §10, §16, §17 |
| `CNF-AC-011`, `CNF-AC-056` | `DD7-AC-012`, `DD7-AC-003` |
| `CNF-GAP-001`…`008` | §22 — preserved OPEN |
| `ADR-0151` §2.3, §2.4, §3.2, §3.5, §5, §6, §7 | §6, §8, §12, §22, §23 |
| ⭐ **`ADR-0152`** §3, §4.1, §4.2, §7, §8.1, §8.2, §8.3, §8.4, §8.5 | §3, §5, §5.3, §5.5, §22, §23, §24, §25, §26, §30 |
| `SECP-HRO-005`, `SECP-BR-004` *(⛔ Unranked)* | §3, §5.3 |
| `MP-NFR-06`, `MP-NFR-08`, `MP-CON-11` | §11.3, §14, §15.4 |
| `AC-7.8`, `AP-3`, `AUTH-2.5`, `AUTH-2.9` | §5.3, §8.2, §12.3, §16 |
| `E-19`, `E-20`, `E-22` | §5.4, §17, §23 |
| README §2B.1…§2B.5 | §5 |

---

## 28. Risks

| # | Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|---|
| 1 | ⛔ An implementer renders all 104 because they are inventoried here | Medium | ⭐⭐ **High — unauthorized write paths** | §6.2 banner; `DD7-AC-002`; per-row `Design` column |
| 2 | ⛔ Deny-read rendered as greyed rather than absent | ⭐⭐ **High — it is the intuitive pattern** | High — `AC-7.8` breach | §8.2; `DD7-AC-009` |
| 3 | ⛔ `TR-2` hard-coded as ALLOW on the 18 non-commercial | Medium | High — `AP-3` breach | §8.1; §12.2; journey 2 |
| 4 | ⛔ Platform-default rows given a write control | Medium | High — `CNF-FR-020` breach | §3.5 of `ADR-0151`; `DD7-AC-012` |
| 5 | ⛔ Reset implemented as "set to parent's value" | ⭐⭐ High | Medium — silent pinning | §10.1; §19; `DD7-AC-005` |
| 6 | ⛔ APP 3 panel built from `SECP-HRO-005` alone | Low | ⭐⭐ **High** | §5.3; `DD7-AC-020`; ⭐ **`ADR-0152`** §7 settles it |
| 7 | ⚠️ Concurrency handled ad hoc per implementer | ⭐ High | Medium — divergent behaviour | `DD7-GAP-011`; journey 8 BLOCKED |

---

## 29. Future / V2

⛔ Recorded, ⛔ not designed: branch (scope 4) and user (scope 5) surfaces
(`CNF-FR-011`, `CNF-GAP-003`) · the other **82** parameters · `C-4` change
history · a second locale (`LCFG-2`) · Indian digit grouping *(declined — the
`DD6-TBD-001` precedent)* · runtime configuration and config cache *(EA places
both at **V2**, `PRD-023` §0.3)*.

---

## 30. Changelog

| Version | Date | Change |
|---|---|---|
| ⭐⭐ **v0.4** | 2026-09-19 | ⭐⭐ **AUTHORIZATION COVERAGE 22 / 104 → 39 / 104**, recording `Accepted` **[`ADR-0153`](../../00-governance/adr/ADR-0153-att-cfg-attendance-configuration-authorization-allocation.md)** — the successor act `ADR-0151` §7 anticipated *("Each needs the same act, by the same route")*. ⭐ **17 `ATT-CFG-*` parameters AUTHORIZED**: `ATT-CFG-001`…`012` and `017`…`021` — **`READ` = `TR-1` + `TR-2` + `TR-3`**, **`NOT COMMERCIAL`**, **Scope = `Tenant`**. ⭐⭐ **`WRITE` is CONSUMED, not decided** — FROZEN `PRD-006` §16.3 (`TR-1` on 16; **`TR-1` + `TR-2` on `ATT-CFG-008`**, `D-12`); ⛔ unchanged. ⭐⭐ **`READ` was DECIDED, ⛔ NOT DERIVED** (`CNF-BR-010`) — `TR-2`/`TR-3` hold `READ` where `WRITE` is denied on **16 of 17**, which **`CNF-FR-081`** renders **read-only** *(⚠️ the opposite of §8.2's deny-read ABSENT treatment for `MM-CFG-007`/`009`, where `AC-7.8` denies the read — ⛔ neither rule weakened)*. ⚠️⚠️ **A first formulation proposed `Scope = Library`; it was REPORTED AS A CONFLICT AND NOT APPLIED** — `ATT-FR-032`, **`ATT-FR-041`**, **`ATT-FR-042`** each say *"**MUST** be configurable **per tenant**"*, ⭐ including for `ATT-CFG-010` *"Library coordinates"*, whose **name is not a scope declaration**; the Product Owner then decided **`Tenant`**. ⛔ **No frozen text was bent to fit a decision.** ⛔⛔ **7 `ATT-CFG-*` REMAIN `NOT YET AUTHORIZED`** — `013`/`015`/`016` and **`014`** *(Face, V1/V3; `ADR-0021` requires **Security Owner** input for `014`)*, **`022`**, **`023`**, **`024`** *(⛔ **authorization-semantic** — `022` gates `TR-2`/`TR-3` correction rights, `024` gates `TR-5` parent visibility, §19.2 **L1980**/**L1983**; **Authorization Owner** required)*. ⭐⭐ **A `WRITE` role in §16.3 was NOT treated as sufficient to authorize them.** ⚠️⚠️ **AUTHORIZED ≠ DESIGNED** — ⛔ the 17 are **not designed here**; **`DD7-GAP-003`** is still open and `DD-0003` `S-L8` already renders them as a **`BC-06`** surface, so ⛔ parameters designed stays **22** and ⛔ surfaces stay **3 of 4**. ⚠️⚠️ **D3 REMAINS `PARTIAL`** — ⛔ **104/104 is NOT claimed**, **65** remain unauthorized, and ⛔⛔ **`DD-0007` REMAINS NOT DESIGN-READY**. ⚠️ **`G-5` DISCLOSED, ⛔ NOT CORRECTED** — `ADR-0151` §1's *"0 of 104 carries a write-authority declaration"* is inaccurate *(true: **24 of 104**)*, ⛔ but correcting an `Accepted` Rank 2 ADR is an **Architecture Owner** act (`ADR-0153` §6). ⛔⛔ **PRESERVED BYTE-UNCHANGED:** `ADR-0151` · `ADR-0152` · `PRD-006` · `PRD-023` · `AUTH-7.22` · the **104**-parameter inventory · D1/D2/D4/D5 · `CNF-GAP-002` and `CNF-GAP-007` **both OPEN at Stage 6** · `DD7-GAP-013` · §7–§21 and §23–§24 and §27–§29. ⛔ **0** `PERM-*` · **0** roles/actions/scopes · **0** frozen documents modified · **0** lines of runtime code. |
| ⭐⭐ **v0.3** | 2026-09-19 | ⭐⭐ **DECLARATION 5 MOVES `GAP` → `PASS` ON EXISTING AUTHORITY. ⛔ NO NEW AUTHORITY WAS CREATED, SOUGHT OR IMPLIED — ⛔ no ADR, ⛔ no PRD amendment, ⛔ no register touched.** ⭐ The cross-app position is **declared and sourced** as a **measured NEGATIVE**: ⛔ **there is no cross-APP dependency** for the `BC-25` runtime configuration surface, because `ADR-0151` §2.3 allocates to `TR-1`/`TR-2`/`TR-3` **only** — ⭐ all **APP 2** by README §2B.1 — while ⛔ **APP 1 = 0 surfaces** (§5.2, four sources) and ⛔ **APP 3 = 0 `BC-25` runtime surfaces** (`Accepted` `ADR-0152` §7). ⭐⭐ **A feature whose every authorized surface lives in one app cannot contain a jump between apps**, and README §2B.3's stated failure mode — *"an **undeclared jump between apps**"* — is measured **absent**. ⭐ README §2B.3 asks for cross-app dependencies *"**if any**"*, ⭐ which a sourced negative satisfies — the instrument `DD-0001` §4.0.4 used for the same declaration. ⭐⭐ **`E-19` IS A BOUNDED-CONTEXT EDGE AND MUST NOT BE TREATED AS AN APP BOUNDARY** (§5.4.2): its *"All contexts"* quantifies the 31 **bounded contexts** (Rank 4), ⛔ not APP 1/2/3 (a Design-README vocabulary) — ⭐ `DD-0001` §4.0.4: *"a bounded-context edge is not an app boundary"*. ⛔ `E-19` and `E-22` are **byte-unchanged** and BC Map is **untouched**. ⚠️⚠️ **`CNF-GAP-002` AND `CNF-GAP-007` REMAIN OPEN AND ARE ⛔ NOT CLOSED BY THIS AMENDMENT** — ⭐ `CNF-GAP-002` *(7 consumers / 0 providers, **High**, `ADR-0053` **L131** "OPEN. Scheduled, not resolved", **Technical Owner**)* is dispositioned by `FROZEN` `PRD-023` **L1368** to *"**Stage 6** — closed by the implementation task that declares the provider"*; ⭐ `CNF-GAP-007` is **Stage 6** (**L1373**), which `PRD-023` §1.3 calls *"a Stage 6 obligation… **not a defect in the manifest**"*. ⭐⭐ **Both are real, both stay OPEN, and ⛔ NEITHER IS A DECLARATION 5 BLOCKER** (§5.4.3) — README §2B.3 requires **no** provider *(**0** occurrences of provider/implementation/binding/manifest in §2B.3 or §2B.5)*; README §5.1 holds a Design Doc *"is **not** a precondition of implementation"*; the condition is **repository-wide** *(**25 of 35** consumed ports have no provider declaration; `provides_ports` used by **3 of 18** modules; **7 of 22** ranked modules have no module block; `check_module_boundaries.dart` reads `provides_ports` **0** times across **12** categories; manifest **L14** defines a port as *"interface declared by **consumer**"*)*; and ⭐ **precedent is unanimous** — `DD-0006` §5.3 recorded **D5 PASS** on `platform/analytics:read_model`, declared at the **same app root** (**L539**, adjacent to `settings` at **L540**) with **no** provider, and `DD-0005` §3.3 likewise. ⭐ **The app-root observation is preserved and tested** (§5.4.4): the manifest has **0** per-app submodules, **all 11** `app` ports are root-declared, ⭐ *"port visibility is not authorization"*, and authorization is app-determinate from **Rank 2** per README §2B.4 rule 4 — ⛔ never from a build manifest. ⚠️ Its residue is recorded as ⭐ **new `DD7-GAP-013`** *(Architecture Owner, Rank 4 manifest question, ⛔ **not** an ADR, ⛔ **not** blocking)*. ⚠️⚠️ **SELF-REPORTED CORRECTION:** ⭐ v0.2's four numbered blockers were **all factually true and all are preserved above**; ⛔ what was wrong was the **adjudication** — three are **Stage 6 implementation** facts and the fourth is the affirmative **ground for PASS**. ⛔ The error was applying an **implementation-readiness** test to a **design-readiness** declaration; ⛔ it is corrected, not quietly replaced. ⭐ **App-Boundary QA 12/13 → 13/13** *(check 11)*; ⭐ **Figma blockers 4 → 3**. ⚠️⚠️ **`DD-0007` REMAINS NOT DESIGN-READY — ⭐ D3 `PARTIAL` at 22 / 104 is now the SOLE blocker**, and ⛔ the **82** parameters remain **`NOT YET AUTHORIZED`**. ⛔⛔ **PRESERVED BYTE-UNCHANGED:** `ADR-0151` · `ADR-0152` · `PRD-023` · `AUTH-7.22` · BC Map · `tool/module_dependencies.yaml` · all frozen PRDs · the **104**-parameter inventory *(18 + 4 + 82)* · §6–§21 and §23–§24 and §27–§29 · every authorization decision · roles, action classes, scopes · `PERM-*` *(**0** minted)*. ⛔ **0** parameters authorized · ⛔ **0** new roles/actions/scopes/`PERM-*` · ⛔ **0** registers extended *(`CNF-GAP-*` stays **8**)* · ⛔ **0** frozen documents modified · ⛔ **0** lines of runtime code. ⭐ **Smallest lawful diff — ⛔ no section rewritten for style, ⛔ no unrelated section touched.** |
| ⭐⭐ **v0.2** | 2026-09-19 | ⭐⭐ **AMENDED under `Accepted` [`ADR-0152`](../../00-governance/adr/ADR-0152-secp-hro-005-is-a-governance-act-not-an-app-3-runtime-configuration-surface.md) — the follow-up that ADR itself routed as `ADR-0152-F-1`.** ⭐⭐ **`DD7-GAP-001` is CLOSED** and ⭐⭐ **Declaration 1 moves `GAP` → `PASS`**: **APP 2** *(`TR-1`/`TR-2`/`TR-3`)* · ⛔ **APP 1 = 0** · ⛔ **APP 3 = 0 `BC-25` runtime configuration surfaces**. ⚠️⚠️ **A SELF-REPORTED FACTUAL CORRECTION IS RECORDED RATHER THAN QUIETLY REPLACED (§5.3):** v0.1 called this a *"**Rank 3 vs Rank 3** contradiction"* where *"precedence cannot break a same-rank tie"* — ⛔ **the premise was false.** `PRD-012a` Part 2's own header reads *"**Unranked.** … **Not** Rank 3; **MUST NOT** be cited as authority against any ranked document"*, measured identically across **all 8** parts, `Status` **`DRAFT`**. ⚠️ The error was reading `PRD-012a`'s **module rank 2** as a **document precedence rank** — ⭐ different ladders. ⭐ A second independent ground stands alone: Part 2 **§0.2** excludes *"… **UI**…"* from what it specifies. ⭐ **`DD7-GAP-002` → MOOT for the runtime APP 3 surface**, ⚠️⚠️ **but NOT answered** — *"platform configuration"* **still has 0 definitions** as a parameter set, re-measured here and carried as **`ADR-0152-F-2`**. ⭐ **App-Boundary QA 11/13 → 12/13** *(check 7 closed; ⛔ check 11 still `GAP`)*. ⭐ **Figma blockers 5 → 4.** ⛔⛔ **D5 IS UNCHANGED AND REMAINS `GAP`** — `CNF-GAP-002` re-verified **OPEN** (`ADR-0053`: *"OPEN. Scheduled, not resolved"*), `CNF-GAP-007` open, `E-19` wording and the app-root port declaration unchanged — so ⛔⛔ **`DD-0007` REMAINS NOT DESIGN-READY**. ⛔⛔ **PRESERVED UNCHANGED:** the `ADR-0151` 22-parameter allocation · the **104**-parameter inventory *(18 + 4 + 82)* · every authorization decision · roles, action classes, scopes · `PERM-*` vocabulary *(**0** minted)* · `AUTH-7.22` · all frozen PRDs · the UI architecture, design recommendations and NFR decisions · §6–§21 and §27–§29 byte-unchanged apart from the cited-source rows. ⭐ **Smallest lawful diff — ⛔ no section rewritten for style.** ⛔ **0 lines of runtime code.** |
| **v0.1** | 2026-09-19 | ⭐⭐ **Created** as the `BC-25` Configuration surface design, after a **six-gate governance check** (§2) that verified ownership, freeze, README §2A/§2B permission, number availability, non-existence and path convention **before** authoring. ⭐ `configuration/` is the **EIGHTH** context directory, created at the moment this document was written, per README §2 and the `analytics/` precedent. ⭐⭐ **The governing discovery is `ADR-0151`**: it is the **only** operation×role source for any `BC-25` parameter, and it covers **22 of 104** — so ⭐ **exactly 22 parameters are designable and 82 are not**. ⭐ **4 surfaces** `C-1`…`C-4` *(⭐ 3 designable · ⛔ 1 BLOCKED)*, **18 editable + 4 read-only** parameters, **11 user journeys**, a **19-row impact model**, **12 design-system reuses** and ⚠️ **3 new components requested** — each named by `PRD-023` §12.2, ⛔ none invented. ⚠️⚠️ **Authorization coverage is published as measured: 21.2%.** ⛔ The 82 unallocated parameters are inventoried with **Scope `OPEN`**, **Comm `OPEN`**, **`NOT YET AUTHORIZED`** and **⛔ Not designed** — ⛔ **inventory is not authorization**, and the banner at §6.2 says so. ⭐⭐ **The sharpest design finding is §8.2: deny-read renders ABSENT, not greyed** — because a greyed row discloses that a parameter exists and has a value, which for `MM-CFG-007`/`009` is the financial disclosure `AC-7.8` denies *"regardless of other roles held anywhere"*; ⭐ so `TR-3` sees **13 rows, not 22 with 9 greyed**. ⭐ **`TR-2` is NOT hard-coded as ALLOW** on the 18 non-commercial parameters — `ADR-0151` §2.4's *existing model* is carried as a **runtime-resolved** rendering (§8.1), ⛔ not converted into a grant. ⭐ **The 4 platform-default parameters get 0 write affordance for every role** (`CNF-FR-020`, `CNF-AC-011`). ⚠️⚠️ **TWO DECLARATIONS ARE `GAP` AND ARE NOT ROUNDED TO PASS** — **D1** because `SECP-HRO-005` *(Rank 3)* and `CNF-FR-020` *(Rank 3)* contradict each other on whether `PR-1` has a runtime configuration surface, and ⛔ precedence cannot break a same-rank tie; **D5** because `CNF-GAP-002` is OPEN at **7 consumers / 0 providers** and `E-19`'s *"All contexts"* is not an app-boundary statement. ⭐ **App-Boundary QA reported as 11 of 13 with 2 GAP**, on the `DD-0006` precedent of publishing rather than rounding. ⛔⛔ **`DD7-GAP-002` is carried forward OPEN** — measured **0** prior occurrences and **0** ADRs citing `SECP-HRO-005`, so ⭐ the brief's *"Decision B"* was applied **as a design constraint** *(⛔ no APP 3 panel, API, write path or permission)* ⛔ **but is NOT recorded as repository-accepted governance**, and the gap is not closed. ⭐ **12 `DD7-GAP-*` raised**, ⛔ all carrying **no authority**; ⭐ `CNF-GAP-*` stays **8** and `CNF-AC-*` stays **59** — ⛔ no closed register is extended. ⭐ **New: `CNF-D-3`** — `PRD-023` §3.6 cites `PRD-005` *"FROZEN v1.4"* while the repository is at **v1.6**; ⛔ a stale citation, ⛔ not a register change *(`MM-CFG-*` verified still **9**)*, ⛔ not repaired because `PRD-023` is FROZEN. ⭐ **UI/UX Pro Max @ `15de38f`: 4 APPLIED · 1 ADAPTED · 3 REJECTED** — ⛔ every rejection names a Liboora source, and ⛔ all visual-token domains were rejected under `CNF-XC-016`. ⭐ **`MeterBar` PROHIBITED** — the **fourth** consecutive Design Doc to prohibit it, for a fourth distinct reason. ⛔⛔ **0 `PERM-*` · 0 new roles · 0 new action classes · 0 new scope classes · `AUTH-7.22` untouched · `ADR-0151` untouched · 0 frozen documents modified · 0 lines of runtime code.** ⚠️ **2 acceptance criteria left deliberately OPEN** *(`DD7-AC-021`, `DD7-AC-022`)* because no authoritative NFR budget or UI Design System exists — ⛔ inventing numbers was declined. ⛔⛔ **Figma gate NOT OPEN — 5 blockers.** ⭐ Verdict: ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS**; ⛔ **`DD-0007` is NOT design-ready**, and this document is the classification, not a claim of readiness. |
