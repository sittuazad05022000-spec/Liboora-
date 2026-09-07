# PLATFORM ADMIN APP BOUNDARY — reserved, deliberately empty

This directory is the structural home of the future **`liboora-platform-admin`**
app. It contains **no Dart code**, and that is the correct state.

⛔ **Nothing here may be implemented until the governance decision in §3 is taken.**

---

## 1. What the repository actually establishes today

The audit that created this directory measured the following, rather than assuming it.

| Question | Measured answer |
|---|---|
| Are platform roles established anywhere? | ⭐ **YES.** `PRD-001` Authentication v2.0 **§2.3 Platform Roles** defines them |
| Which roles? | **`PR-1` Platform Administrator** and **`PR-2` Platform Support** |
| Is that set open? | ⛔ **No — closed.** §2.3: *"Two exist. The set is closed."* Reinforced by `PRD-012a` Part 2 **`SECP-FR-003`** (*"MUST be closed at `PR-1` and `PR-2`"*) and **`SECP-XC-012`** (*"MUST NOT extend the platform-role set … nor create a role, capability or account class that carries platform authority under another name"*) |
| What authority does `PRD-001` hold? | **Rank 3**, `DOCUMENTATION_BASELINE.md` L146 — *"Authoritative — the baseline"*, v2.0 |
| Is **"Platform Owner"** established? | ⛔ **NO. Zero occurrences** in `PRD-001`, `MASTER_PRD.md` or `PRD-012a` Part 2 |
| Does `MASTER_PRD.md` (Rank 1) §6 mention platform roles? | ⛔ **No — 0 occurrences.** Its role table lists only the five tenant roles |
| Does any platform-role code exist? | ⛔ **No.** `AccessRole` (`lib/platform/identity/identity.dart`) holds exactly five values: `owner`, `manager`, `reception`, `student`, `parent` — all **tenant** roles |

### 1.1 The distinction this boundary exists to preserve

| | Owns | Scope | Lives in |
|---|---|---|---|
| **`TR-1` Owner** (*"Library Owner"*) | One library / tenant | *"Entire library"* | `lib/app/staff/**` |
| **`PR-1` / `PR-2`** | The Liboora platform | Platform-level objects only | `lib/app/platform_admin/**` |

⚠ `PRD-001` **`AUTH-2.5`**: platform roles **MUST NOT** grant access to tenant business data;
such access comes only through time-bounded elevation. **`SECP-FR-002`**: a platform-role identity
**MUST NOT** hold or obtain any tenant role by its own action. A single shell serving both would
make that separation a runtime convention instead of a structural fact.

---

## 2. Why this directory is empty rather than scaffolded

`SECP-FR-007` — *"A privileged capability **MUST NOT** be granted in anticipation of need.
A capability with no current approved use **MUST** be absent, not dormant behind a flag."*

A placeholder shell with a role enum entry, a navigation set or a stub dashboard would be exactly
the dormant capability that rule forbids. So the boundary is **reserved by directory and documented
by this file** — enough for a future extraction to have an obvious home, and nothing more.

---

## 3. ⭐ THE NAMING DECISION — **OPTION A, SELECTED BY THE PRODUCT OWNER**

The request named **"Platform Owner"** and **"Platform Admin"** as the two roles of this app.
Measured against the repository:

| Requested role | Status |
|---|---|
| **Platform Admin** | ⭐ **Already established** as `PR-1` Platform Administrator (`PRD-001` §2.3) |
| **Platform Owner** | ⭐ **A business/product-facing NAME for that same `PR-1`** — not a role of its own. It is **not** `PR-2` Platform Support, whose purpose is *"Resolve user- and library-reported problems"* with **read-only** metadata scope |

⭐⭐ **DECISION RECORDED — the Product Owner selected OPTION A.**

> **"Platform Owner" is the business/product-facing name for the EXISTING `PR-1` Platform
> Administrator.** `PR-1` remains the authoritative platform-admin identity. `PR-2` Platform
> Support remains a **separate** role and is **not** Platform Owner. Platform Owner is **not** a
> third platform role.

⛔ **This is a naming clarification and nothing else.** It creates no third platform role, no
permission set, no authority, no security scope, no bounded context, no ADR, no frozen-PRD
amendment, no registry or rank change, no implementation change and no UI change.

### 3.1 Why Option A is lawful — and why the alternatives were not taken

The platform-role set is **closed at two**, in three separate places:

1. `PRD-001` §2.3 — *"Two exist. The set is closed."*
2. `PRD-012a` `SECP-FR-003` — the set **MUST** be closed at `PR-1` and `PR-2`
3. `PRD-012a` `SECP-XC-012` — no role *"under another name"* may carry platform authority

⭐ Option A **satisfies all three** precisely because it adds nothing: the authority still resolves
to `PR-1`, so `SECP-AC-017`'s requirement that *"every platform-authority path … resolves to `PR-1`
or `PR-2`; no third platform role name exists anywhere"* continues to hold. A business synonym is
not a role; `SECP-XC-012` forbids a **role, capability or account class** carrying platform
authority under another name, and a naming clarification confers no authority to carry.

⭐⭐ **This is an EXISTING repository pattern, not a new one.** `Library_PRD_v1.md` §4 already maps
the same two words to the same authoritative role:

> | Platform Owner | **Platform Administrator** | Platform-wide, platform objects only | `AUTH-7.12`, `AUTH-7.13` |

and records the reasoning this decision follows: *"Naming was corrected, not changed … Two
vocabularies for one role is how permission bugs are written, so this document adopts the
authoritative names. **No actor was added or removed.**"* `LIB-4.1` binds that module to the
authoritative names, which is exactly what Option A does here.

⭐ **`PRD-008` independently recommends the same answer.** Its `FEE-GAP-015` asks whether
*"`Platform Owner / Super Admin`"* is a third platform role, and its recommendation reads: *"**Do
NOT create a third platform role.** ‘Two, closed’ stands; `PR-1`'s own Purpose and Scope already
cover platform configuration."*

⛔ The alternatives, recorded so the decision is traceable:

| Option | What it meant | Outcome |
|---|---|---|
| **A — Map, don't create** | "Platform Owner" is the business name for the existing `PR-1` | ⭐ **SELECTED.** No ADR needed for the role set; nothing amended |
| **B — Extend the set to three** | Add a genuine third platform role above `PR-1` | ⛔ **NOT TAKEN.** Would require an `Accepted` ADR amending `PRD-001` §2.3 **and** `PRD-012a` `SECP-FR-003`/`SECP-XC-012`, plus a Rank-1 `MASTER_PRD.md` §6 amendment. Both PRDs are **FROZEN** |
| **C — Defer** | Leave "Platform Owner" unresolved | ⛔ **NOT TAKEN.** Superseded by this decision |

⚠ **`FEE-GAP-015` is NOT closed by this record.** That gap's open parts (b) and (c) are about an
**enumerated permission** and a **configuration parameter** — *"Naming who may act does not
enumerate the grant that lets them"* — and neither is a naming question. This decision answers the
naming limb only and leaves the permission and parameter limbs exactly as they stand, for their own
owners.

### 3.2 What this record does NOT do

- ⛔ No third platform role — the set stays **closed at `PR-1` and `PR-2`**
- ⛔ No role added to `AccessRole` — it still holds exactly its five **tenant** values
- ⛔ No permission, capability, authority boundary, scope, role count or security rule changed
- ⛔ No frozen PRD amended; `PRD-001`, `PRD-012a` and `MASTER_PRD.md` are **byte-unchanged**
- ⛔ **No ADR created** — and none is required, because no Rank 1–5 document is changed
- ⛔ No requirement identifier created, reused or renumbered
- ⛔ No registry, rank, baseline or bounded-context change
- ⛔ No `platform_admin` shell written, and **no implementation authorised** — §2's `SECP-FR-007`
  reasoning still governs, and §4 below still describes work that is **not** authorised by this file

---

## 4. What a future implementer inherits

Once §3 is decided, the work is additive and does not touch the shared domain:

1. Represent platform roles **separately** from `AccessRole`, since `SECP-FR-002` and
   `SECP-FR-014` require the two namespaces not to convert into one another. A sixth `AccessRole`
   value would model a platform role as a tenant role and breach both.
2. Add `platform_admin/platform_admin_app_shell.dart` following the shape of
   `staff/staff_app_shell.dart` — its own navigation, its own account surface.
3. Register the boundary in `lib/app/liboora_app.dart`'s composition root.
4. Extend `test/architecture/app_boundary_test.dart`, which already asserts this directory holds
   no role-routing code, so it will need updating **deliberately** rather than by accident.
5. Honour elevation (`SECP-FR-004`…`007`): tenant access is time-bounded, purpose-stated and
   separately approved — never standing.

⛔ Steps 1–5 are **not authorised by this file**. It records what would be required; it confers
nothing.
