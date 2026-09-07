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

## 3. ⛔ THE GOVERNANCE DECISION REQUIRED — NOT TAKEN HERE

The request named **"Platform Owner"** and **"Platform Admin"** as the two roles of this app.
Measured against the repository:

| Requested role | Status |
|---|---|
| **Platform Admin** | ⭐ **Already established** as `PR-1` Platform Administrator (`PRD-001` §2.3). **No new decision needed to name it** |
| **Platform Owner** | ⛔ **NOT established anywhere.** It is **not** a synonym for `PR-2` Platform Support, whose purpose is *"Resolve user- and library-reported problems"* with **read-only** metadata scope |

### 3.1 What is therefore required

Establishing **Platform Owner** as a *third* platform role would breach three requirements in
**FROZEN, Rank-3** documents:

1. `PRD-001` §2.3 — *"Two exist. The set is closed."*
2. `PRD-012a` `SECP-FR-003` — the set **MUST** be closed at `PR-1` and `PR-2`
3. `PRD-012a` `SECP-XC-012` — no role *"under another name"* may carry platform authority

⭐ **`DOCUMENTATION_BASELINE.md` §7 rule 1**: *"A change to any Rank 1–5 document requires an ADR
**before** the change."* `PRD-001` is Rank 3 and `FROZEN`.

**So the decision required is one of these three — and it is a PRODUCT DECISION, not an
implementation detail:**

| Option | What it means | What it costs |
|---|---|---|
| **A — Map, don't create** *(no new role)* | Treat "Platform Owner" as the business name for the already-established **`PR-1` Platform Administrator**, and "Platform Admin" as `PR-2` or as `PR-1` too | ⭐ **No ADR needed for the role set.** Cheapest and fully lawful. Requires only a naming confirmation from the product owner |
| **B — Extend the set to three** | Add a genuine third platform role above `PR-1` | ⛔ Requires an **`Accepted` ADR** amending `PRD-001` §2.3 **and** `PRD-012a` `SECP-FR-003`/`SECP-XC-012`, plus a `MASTER_PRD.md` §6 amendment (Rank 1). Both PRDs are **FROZEN** — needs Governance Owner conferral |
| **C — Defer** | Build the boundary for `PR-1`/`PR-2` only; leave "Platform Owner" unresolved | Lawful today. Costs nothing now |

⛔ **I have taken none of these.** Choosing between them is a product decision reserved to the
**Product Owner**, and amending a frozen Rank-3 PRD is reserved to the **Governance Owner** under
direct conferral. Recording a choice here would be fabricating authority.

### 3.2 What was deliberately NOT done

- ⛔ No role added to `AccessRole` — it still holds exactly its five tenant values
- ⛔ No permission, capability or navigation invented for any platform role
- ⛔ No frozen PRD modified; `PRD-001` and `PRD-012a` are **byte-unchanged**
- ⛔ No requirement identifier created, reused or renumbered
- ⛔ No `platform_admin` shell written

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
