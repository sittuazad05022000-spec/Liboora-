<!-- LIBOORA Design Doc | DD-0009 | BC-25 Configuration (C-5, APP 3) -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, configuration
> parameters or backend contracts.

# **DD-0009** — APP 3 (read-only) platform configuration viewer surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0009` |
| **Version** | **v0.1** — first issue |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-25` Configuration** `[GENERIC]` — **FOUNDATIONAL** band (BC Map L271), V1 |
| **Subject PRD** | `PRD-023` Settings & Configuration — **`FROZEN` v0.1**, Rank 3, admitted 2026-08-20 by **`ACCEPTED` `ADR-0053`** under **`BASELINE-2026-08-20-A`** · `Student_Identity_PRD_v1.md` §5.5 · `Authentication_PRD_v2.md` §2.3/§2.4 |
| ⭐⭐ **Governing authorization authority** | **`ADR-0154`** *(Rank 2, **Accepted** — 2026-09-19)* ⭐ **`ADR-0155`** *(Rank 2, **Accepted** — 2026-09-19)* — ⛔ **the only** operation×role sources for C-5's parameters. ⛔ **Neither is amended, reopened or superseded.** Together they authorize **exactly 19** parameters as **READ-only** to `PR-1`+`PR-2` |
| **Preceded by** | ⭐⭐ `DDR-0024` (9-hold triage) · ⭐⭐ **`DDR-0025`** (C-4/C-5 binding-blocker diagnosis). ⛔ **Neither closed C-4 or C-5** — each is **OPEN** (§21) and ⛔ **nothing is decided here on their behalf** |
| **Owner** | **UX Architecture Owner** *(role, never a personal name)* |
| **External method** | ⛔⛔ `nextlevelbuilder/ui-ux-pro-max-skill` @ commit **`09170ee`** (v2.13.0), MIT — ⛔ **NOT cloned into the workspace**. ⛔ **Reference only, subordinate to every Liboora source.** ⚠️ **Version caveat:** `LIBOORA_UIUX_PRO_MAX_RULES.md` governs adoption at **`15de38f`**; this engagement cloned **`09170ee`** and ran its `search.py` workflow (`--domain ux`, `stack flutter`) per `LIBOORA_UIUX_PRO_MAX_RULES.md` §4. All rules below cite the governing Liboora source, ⛔ never the skill |
| **Purpose** | ⛔ **Design ONLY.** Specify the **read-only** `BC-25` platform-configuration viewer surface **C-5** — the 19 parameters `PR-1` + `PR-2` may **read**, per `Accepted` `ADR-0154`/`ADR-0155`, precisely enough that a Figma prototype or Flutter implementation could be built **without inventing UX, parameters, roles or authority** |
| **Verdict** | ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS — §24.** ⛔⛔ **Figma gate NOT OPEN.** ⛔ **APP 3 runtime NOT authorized.** |

---

> ⚠️⚠️ **THIS DOCUMENT DESIGNATES NOTHING AND AUTHORIZES NOTHING.** ⛔ It does not create a role, a permission, a `PERM-*` identifier, an app, an execution path, a UI component, or a configuration value. ⛔ It does **not** open the design gates closed by `DD-0007` (Figma gate ⛔ BLOCKED; `DBT-001`/`DBT-005`/`DBT-008` ⛔ OPEN). ⛔ It does **not** close C-4 or C-5; those open questions are routed to their owners at §21. ⛔ It does **not** authorize APP 3 runtime or implementation (`SECP-FR-007`, `ADR-0154` D-7). It **specifies** one read-only surface, **cites** the lawful 19 parameters, and **records** the open items that block readiness.

---

---

> ⚠️⚠️ **THIS DOCUMENT DESIGNATES NOTHING AND AUTHORIZES NOTHING.** ⛔ It does not create a role, a permission, a `PERM-*` identifier, an app, an execution path, a UI component, or a configuration value. ⛔ It does **not** open the design gates closed by `DD-0007` (Figma gate ⛔ BLOCKED; `DBT-001`/`DBT-005`/`DBT-008` ⛔ OPEN). ⛔ It does **not** close C-4 or C-5; those open questions are routed to their owners at §21. ⛔ It does **not** authorize APP 3 runtime or implementation (`SECP-FR-007`, `ADR-0154` D-7). It **specifies** one read-only surface, **cites** the lawful 19 parameters, and **records** the open items that block readiness.

---

## 1. Document identity

### 1.1 What this document does

It specifies the **presentation and interaction behaviour** of surface **C-5** — the read-only viewer of the **19** platform-default `BC-25` configuration parameters that `Accepted` `ADR-0154` §2.5 and `ADR-0155` §2.5 authorize `PR-1` + `PR-2` to **read**, at the fidelity an implementer needs to build **without guessing**.

### 1.2 ⛔⛔ What this document does NOT do

| ⛔ Not done | Why |
|---|---|
| ⛔ Amend a PRD or ADR | **0 bytes** of any frozen source changed |
| ⛔ Create or alter a role | `PRD-001` §2.3 — the platform-role set is **closed at two** |
| ⛔ Create or imply a permission | ⛔ **`AUTH-7.22` remains closed at zero** — `ADR-0154` §3.1; `ADR-0155` invariants 1–10 |
| ⛔ Expand the parameter set | ⛔ **Exactly 19** parameters; `CFG-10`/`CFG-12`/`SCFG-2`/`SCFG-4` remain **HELD** (§6.3) |
| ⛔ Create a write capability | ⛔ **No editable control, no submit, no reset, no override store** (`ADR-0154` D-4, `ADR-0155` S-4) |
| ⛔ Authorize APP 3 runtime or implementation | ⛔ `SECP-FR-007`; `ADR-0154` D-7; `lib/app/platform_admin/` is ⛔ **reserved and empty** |
| ⛔ Design surface C-4 | ⛔ `ADR-0171` — **NO V1 read surface** for BC-24 audit entries |
| ⛔ Invent a design token or radius | ⛔ `CNF-XC-016` — `PRD-023` **MUST NOT** define design tokens; owner = UI Design System |
| ⛔ Confer freeze, approval or baseline | Those are conferred, not claimed |

---

## 2. Governance gate — verified before authoring

⭐ Each row was measured in this repository, not assumed.

| # | Gate | Evidence | Verdict |
|---|---|---|---|
| 1 | **`DD-0009` is the next lawful number** | `README` §3 L440: *"the next Design Doc is `DD-0007`"* — ⛔ **stale**, measured `DD-0007` and `DD-0008` already exist · ⛔ **0** files named `DD-0009*` measured | ⭐ **PASS** |
| 2 | **No existing `DD-0009` elsewhere** | `find docs -iname 'DD-0009*'` → **0**; `grep -rn 'DD-0009' docs/` → **0** in tracked docs (pre-creation) | ⭐ **PASS** |
| 3 | **Title / path are convention-backed** | `README` §3 pattern `DD-NNNN-short-kebab-title.md`; `README` §2.3 naming rule; existing precedent `DD-0007-configuration-surface-design.md` | ⭐ **PASS** |
| 4 | **`BC-25` is owned by `PRD-023`** | `PRD_OWNERSHIP_MODEL.md` L205 · `ADR-0017` §3 | ⭐ **PASS** |
| 5 | **`PRD-023` is sufficiently frozen** | `Status` = **`FROZEN`** (`ADR-0053`, `BASELINE-2026-08-20-A`); Stage 7 PASSED; Rank 3 | ⭐ **PASS** |
| 6 | **README §2A/§2B permits creation** | §2A.3 discriminator satisfied by `PRD-023` §12 · §2B.3 declarations present and sourced | ⭐ **PASS** |
| 7 | **Authorization is complete for the designed set** | `ADR-0154` — 10 `CFG-*`; `ADR-0155` — 9 `SCFG-*`; **both `Accepted`** | ⭐ **PASS** |
| 8 | **`C-4` is OUT OF SCOPE — no V1 audit read surface** | ⛔ `ADR-0171` — **NO V1 read surface** for BC-24 configuration audit entries | ⛔⛔ **C-4 NOT DESIGNED** |

⭐⭐ **Path:** `docs/35-design/configuration/DD-0009-app-3-read-only-platform-configuration-viewer.md`
⭐ `configuration/` is the **EIGHTH** context directory, created at the moment `DD-0007` was written, per `README` §2. ⛔ **No new directory is created by this document** — it shares the existing `configuration/` directory.

---
## 3. Sources of truth

| Rank | Document | What is consumed |
|---:|---|---|
| 1 | `MASTER_PRD.md` | `MP-NFR-06` (mobile-first, portrait-optimized); `MP-NFR-08` (WCAG-aligned, owner = UI Design System) |
| 2 | ⭐⭐ **`ADR-0154`** | **APP 3 may hold a READ-ONLY `BC-25` surface**; allocates **10 `CFG-*`** — `READ` = `PR-1`+`PR-2`, ⛔ **no WRITE** (D-4) |
| 2 | ⭐⭐ **`ADR-0155`** | **Allocates 9 `SCFG-*`** — `READ` = `PR-1`+`PR-2`, ⛔ **no WRITE** (S-4); `SID-5.45` platform-wide |
| 2 | `ADR-0017` | `BC-25` ownership |
| 2 | `ADR-0171` | ⛔ **C-4 is OUT OF SCOPE** — no V1 read surface for BC-24 audit entries |
| 2 | `ADR-0152` | **§7 limb 3 PRESERVED** — *"No runtime write path to Scope 1 exists or may be built"* |
| 3 | ⭐ **`PRD-023`** | §3 hierarchy; §4.5 failure modes; §9 authority; §10 isolation; §11 observability; **§12 UI/UX** (CNF-FR-076–082, CNF-AC-059); §13 acceptance criteria |
| 3 | `PRD-001` v2.0 | `TR-1`…`TR-5`, `PR-1`, `PR-2`; `AUTH-2.5` |
| 3 | `PRD-002` Library v1.0 | `LCFG-*` definitions |
| 3 | `Student_Identity_PRD_v1` | §5.5 `SCFG-1`…`SCFG-11`; `SID-5.45`; `SID-5.41`/`SID-5.44` |
| 4 | BC Map v1.11 | L134 `BC-25`; L271 FOUNDATIONAL band; L316 `E-19` |
| 7 | `CONFIGURATION_GUIDE.md` | §2 `CFG-1`…`CFG-12` defaults/ranges; §4 scope model |
| 2 | ⛔ **`DDR-0025`** | ⛔ **Primary design-review input** — C-4 genuine absence, C-5 misclassified as blocker but its read-only design is permitted by `ADR-0154` B3; APP 3 runtime authorization **NOT** required for V1 design; §4 open questions (Q2: §2B.5 gate criterion; Q5: "approved use" for APP 3) |
| — | `DDR-0024` | 9-hold triage context |
| — | `DD-0007` §6.3.3/§6.3.5 | **19 parameters = authorized, not designed** |
| — | `DESIGN_DEBT.md` | `DBT-001`/`DBT-005`/`DBT-008` — all **OPEN** |
| ⛔ **Unranked** | `PRD-012a` Part 2 | `SECP-FR-007` (gated reference only — ⛔ not authority) |
| — | `lib/app/shared/` | Existing Flutter design system components (§10) |
| — | `lib/app/platform_admin/README.md` | ⛔ **APP 3 reserved, empty, implementation NOT authorized** |

---
## 4. ⭐⭐ APP + ROLE BOUNDARY

### 4.1 ⭐ All five declarations (README §2B.3)

| # | Declaration | Value | Verdict |
|---|---|---|---|
| **1** | **Target App** | ⭐⭐ **A JUSTIFIED TWO-APP SET** — ⭐ **APP 2** *(Library App)* holds the write/tenant-configured surfaces (§11.3) · ⭐⭐ **APP 3** *(Platform Admin)* holds **C-5**, the read-only viewer · ⛔ **APP 1 = 0 surfaces** · ⛔ **APP 3 = 0 writable surfaces** (`ADR-0154` D-4) | ⭐ **PASS** |
| **2** | **Target Roles** | ⭐ `PR-1` Platform Administrator · `PR-2` Platform Support · ⛔ `TR-1`/`TR-2`/`TR-3` **excluded** (`*READ` = ⛔ none; `AUTH-7.24`) · ⛔ `TR-4`/`TR-5` **excluded** | ⭐ **PASS** |
| **3** | **Permission Scope** | ⛔ **READ ONLY.** Source: ⭐⭐ `ADR-0154` §2.5 (10 `CFG-*`) **+ ⭐⭐ `ADR-0155` §2.5 (9 `SCFG-*`)** — **READ** = `PR-1`+`PR-2`; ⛔ **WRITE = ⚪ N/A on all 19** (`ADR-0154` D-4, `ADR-0155` S-4) | ⭐ **PASS** |
| **4** | **Tenant / Library / Platform scope** | ⭐ **Platform default** — all 19 resolve at scope 1 (`PRD-023` L316; `SID-5.45`) · ⛔ **no tenant** / library scope · ⛔ **cross-tenant impossible** (`CNF-INV-003`/`004`; `SID-4.49`) | ⭐ **PASS** |
| **5** | **Cross-App dependencies** | ⭐⭐ **ONE, DECLARED.** App 2 *(read)* ↔ App 3 *(read)* of the same scope-1 values · ⭐ **one-directional, read-only** · ⛔ **no app writes them** (`CNF-FR-020`, `CNF-AC-011`) · ⛔ **no navigation between the two surfaces** (README §2B.4 rule 2/7) | ⭐ **PASS** |

### 4.2 ⭐⭐ Why APP 1 = 0 surfaces — measured, not assumed

| # | Evidence | Text |
|---|---|---|
| 1 | `PRD-001` §2.3 | The platform-role set is **closed at two** (`PR-1`, `PR-2`); ⛔ `TR-4`/`TR-5` receive **no** read or write on any of the 19 |
| 2 | `ADR-0154` §2.5 | `READ` = `PR-1`+`PR-2` only; ⛔ tenant roles receive **0** |
| 3 | `ADR-0155` S-1 | `No tenant-role authority is created.` |
| 4 | `AP-3` | Deny by default — ⛔ silence is not a grant |

### 4.3 ⭐⭐ APP 3 holds a READ-ONLY surface — settled by `ADR-0152` as superseded in part by `ADR-0154`

| | |
|---|---|
| ⭐ **`ADR-0154` D-2** | **APP 3 MAY hold a READ-ONLY `BC-25` configuration surface** for `PR-1` and `PR-2` |
| ⛔⛔ **`ADR-0152` §7 limb 3** *(preserved in full)* | **"No runtime write path to Scope 1 exists or may be built"** |

⭐⭐ **`ADR-0154` §4.3 supersedes `ADR-0152` IN PART and IN EFFECT ONLY**, in exactly two places — §7's word "surface" and §8.5's one table row — on the `ADR-0130` instrument. ⛔⛔ **`ADR-0152` is byte-unchanged** and ⛔ **remains `Accepted`**.

### 4.4 ⭐⭐ The one cross-app dependency — declared, sourced, one-directional, READ-only

> ⭐ The **19** platform-default parameters (10 `CFG-*` + 9 `SCFG-*`) resolve at **scope 1** and are **READ** in **two apps**:
> · ⭐ **APP 2 — Library App**: `TR-1`/`TR-2`/`TR-3` experience them as resolved effective values behind other surfaces.
> · ⭐ **APP 3 — Platform Admin**: `PR-1`/`PR-2` may view them **read-only** (`ADR-0154` D-3, `ADR-0155` D-1).
>
> ⛔⛔ **The dependency is ONE-DIRECTIONAL and READ-ONLY.** ⛔ **Neither app writes them** — values originate from the **environment profile at deployment** (`PRD-023` §4) and are unwritable at runtime by **any** actor (`CNF-FR-020`, `CNF-AC-011`).
> ⛔ **No navigation between the two surfaces**, no shared shell, no mixed-role screen.

| Property | Value |
|---|---|
| Endpoints | **APP 2** *(read)* · **APP 3** *(read)* |
| Direction | ⭐ **One-directional** — both readers of a deployment-supplied value |
| Action | ⭐ **READ only** — `AUTH-7.24` |
| Shared UI | ⛔ **NONE** — materially different UX |
| Writer | ⛔ **NONE at runtime** — environment profile at deployment |

---
### 4.5 ⛔⛔ `PR-2` scope ceiling — thresholds only

⭐ The **B2 decision** (`ADR-0154` §2.2) is bounded:

| `PR-2` may read | ⛔ `PR-2` cannot |
|---|---|
| ⭐ Configured thresholds — *"the OTP quota is 5 per hour"* | ⛔ **Authentication factors** — any OTP code, any Google token |
| ⭐ Lockout duration | ⛔ **Session secrets** — any token or session identifier |
| ⭐ Session lifetime ceiling | ⛔ Any **tenant business data** (`AUTH-2.5`) |
| ⭐ Device limit | ⛔ Any **write** to any scope (`CNF-FR-020`) |

⭐⭐ **All 19 parameters in this surface are within the B2 ceiling.** None are factors, sessions, or tenant business data. `AUTH-2.5` is **not engaged** (`ADR-0154` §3.2).

---

## 5. ⛔⛔ C-5 authorization boundary — the invariant that governs everything

| # | Invariant | Source | Verdict |
|---|---|---|---|
| 1 | Permission catalogue stays closed at zero | `AUTH-7.22`, `ADR-0132` | ⭐ **PASS** — ⛔ **0** `PERM-*` minted |
| 2 | Platform-role set closed at two | `PRD-001` §2.3 | ⭐ **PASS** — `PR-1`, `PR-2` cited; ⛔ **0** created |
| 3 | Scope 1 not writable by any actor | `CNF-FR-020`, `CNF-AC-011` | ⭐ **PASS** — ⛔ **all 19 WRITE cells are ⚪ N/A**, not DENY |
| 4 | Read granted independently of write | `CNF-BR-010` | ⭐ **PASS** — READ was **decided**, ⛔ not derived |
| 5 | Read implies no other action | `AUTH-7.24` | ⭐ **PASS** — ⛔ no Create/Update/Delete |
| 6 | No role hierarchy | `AUTH-7.28` | ⭐ **PASS** — `PR-1` and `PR-2` granted **separately** |
| 7 | Platform roles confer no tenant data | `AUTH-2.5` | ⭐ **PASS** — these are **platform-level objects**, ⛔ not tenant business data |
| 8 | `CFG-5`/`CFG-6` remain one parameter each | `ADR-0154` D-7 / Product Owner | ⭐ **PASS** — two value limbs, ⛔ **0** new IDs |
| 9 | `ICFG-1`…`10` NOT batched — no read surface | `ADR-0164` Outcome B | ⛔ **C-4 boundary** — ⛔ not in this surface |
| 10 | Held parameters NOT advanced | `ADR-0154` D-6, `ADR-0155` S-2/S-3, `ADR-0165`/`0166` | ⛔⛔ **`CFG-10`/`CFG-12`/`SCFG-2`/`SCFG-4` ⛔ NOT AUTHORIZED** |

### 5.1 ⛔ `CFG-10`, `CFG-12`, `SCFG-2`, `SCFG-4` — the 4 HELD parameters ⛔ NOT in this design

| Parameter | Status | Reason | Owner |
|---|---|---|---|
| `CFG-10` | ⛔ **HELD** | DPDP erasure obligation; retention question | Legal + Security |
| `CFG-12` | ⛔ **HELD** | Self-referential: bounds `PR-2`'s own elevation | Authorization Owner |
| `SCFG-2` | ⛔ **HELD** | Review authority not identifiable | Authorization Owner |
| `SCFG-4` | ⛔ **HELD** | DPDP-adjacent retention (24 months) | Privacy Owner |

⛔⛔ **These 4 are ⛔ NOT DESIGNED, ⛔ NOT AUTHORIZED, ⛔ NOT DISPLAYED in C-5.** Their `READ` is ⛔ **HELD**, not allocated. ⚠️ Do NOT re-refer to an Authorization Owner — `ADR-0165`/`0166` are **`Accepted` Rank-2 ADRs**, and re-referral would attempt to reverse a decided act.

### 5.2 ⛔ APP 3 runtime is NOT authorized

| Source | Text |
|---|---|
| `ADR-0154` D-7 | **`READ` allocation may precede APP 3 runtime implementation** ⛔ **This ADR does NOT authorize APP 3 implementation** |
| ⛔ `ADR-0154` D-4 / B1 limb 4 | ⛔⛔ **"NO WRITE AUTHORITY IS CREATED FOR ANY ACTOR AT ANY SCOPE"** |
| ⛔ `ADR-0154` B1 limb 11 | ⛔⛔ **APP 3 runtime implementation is NOT authorized** |
| ⛔ `SECP-FR-007` | ⛔⛔ *"A privileged capability MUST NOT be granted in anticipation of need."* |
| ⛔ `lib/app/platform_admin/README.md` §2 | ⛔ *"Nothing here may be implemented until the governance decision in §3 is taken."* — ⛔ **§3 is NOT taken for implementation.** It was a **naming** decision only (Product Owner OPTION A) |
| ⛔ `DDR-0025` §F | ⛔ *"Pursuing APP 3 runtime authorization is unlawful — `SECP-FR-007` forbids authorizing in order to design."* |

⛔⛔ This document **designs** C-5 ⛔ **does not authorize its implementation.** `lib/app/platform_admin/` remains **reserved, empty, 0 Dart files**.

### 5.3 ⛔ Design ≠ authorization

| Fact | Source |
|---|---|
| A Design Doc is **UNRANKED** and **cannot change a requirement** | `README` §5.1 |
| `README` §5.1: *"It is **not** a precondition of implementation"* | `README` §5.1 |
| `ADR-0154` B3: READ allocation may **precede** runtime | `ADR-0154` §2.3 |
| `DDR-0025` §B.5: design ordering is **inverted** — design waits for a use case, ⛔ design cannot create one | `DDR-0025` §B.5 |

⛔ **This Design Doc does NOT confer the runtime authorization its surface would enable.** That remains a separate future act, gated on `SECP-FR-007`'s *"approved use"* (§21, `DDR-0025` §4 Q5 — ⛔ **OPEN**, **Product Owner**).

---
## 6. ⭐ The authorized parameter inventory — exactly 19

### 6.1 ⛔ INVENTORY IS AUTHORIZATION IS RECORDED AS MEASURED

| Group | Register | Count | READ PR-1 | READ PR-2 | WRITE | Scope | Commercial | Source |
|---|---|---:|:--:|::/:|:--|:--:|---|
| ⭐ **Authentication** | `CFG-1`…`CFG-9`, `CFG-11` | **10** | ✅ | ✅ | ⚪ **N/A** | Platform default | NOT COMMERCIAL | `ADR-0154` §2.5 |
| ⭐ **Student Identity** | `SCFG-1`, `SCFG-3`, `SCFG-5`…`SCFG-11` | **9** | ✅ | ✅ | ⚪ **N/A** | Platform default | NOT COMMERCIAL | `ADR-0155` §2.5 |
| — | `CFG-10`, `CFG-12`, `SCFG-2`, `SCFG-4` | ⛔ **4 HELD** | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ | ⛔ excluded |
| **Total** | | **19** | | | ⛔ **0 writable** | | | |

⭐⭐ **Verified mechanically: 10 + 9 = 19.** ⛔⛔ **0 write authority created.** ⛔⛔ **4 held parameters explicitly excluded.**

### 6.2 ⭐ The 10 `CFG-*` — Authentication policy (ADR-0154 D-3)

| # | Parameter | Default | Range | Owner | `PR-1` R | `PR-2` R | WRITE | Source |
|---|---|---|---|---|::/:|:--:|--|:--:|---|
| 1 | `CFG-1` OTP requests per mobile number / hour | **5** | 3–10 | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L78 |
| 2 | `CFG-2` Min interval between OTP requests | **30 sec** | 15–60 sec | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L99 |
| 3 | `CFG-3` OTP requests per network origin / hour | **100** | 50–500 | Security+Ops | ✅ | ✅ | ⚪ **N/A** | Guide §2 L121 |
| 4 | `CFG-4` Temporary lock after quota exhaustion | **30 min** | 15–60 min | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L152 |
| 5 | `CFG-5` Idle session timeout (mobile / staff) | **30 d / 30 min** | mobile 7–90 d · staff 15–60 min | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L174 |
| 6 | `CFG-6` Absolute session lifetime (mobile / staff) | **90 d / 12 h** | mobile 30–180 d · staff 8–24 h | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L199 |
| 7 | `CFG-7` Trusted-device trust lifetime | **90 d** | 30–180 d | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L223 |
| 8 | `CFG-8` Max concurrent registered devices | **10** | 3–20 | Product+Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L244 |
| 9 | `CFG-9` Pending-verification retention | **24 h** | 1–72 h | Engineering | ✅ | ✅ | ⚪ **N/A** | Guide §2 L262 |
| 10 | `CFG-11` Account-claim failures before lock | **5 / 24 h** | 3–10 / 24 h | Security | ✅ | ✅ | ⚪ **N/A** | Guide §2 L301 |

⛔ **`CFG-5` and `CFG-6` remain ONE parameter each** despite two value limbs (`ADR-0154` D-7) — ⛔ **0 new IDs created**.

### 6.3 ⭐ The 9 `SCFG-*` — Student identity policy (ADR-0155 D-1)

| # | Parameter | Default | Range | Owner | `PR-1` R | `PR-2` R | WRITE | Source |
|---|---|---|---|---|::/:|:--:|--|:--:|
| 1 | `SCFG-1` Username length | **3–30 chars** | 3–50 | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1335 |
| 2 | `SCFG-3` Username rename cooldown | **30 days** | 0–365 days | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1337 |
| 3 | `SCFG-5` Released-username hold period | **90 days** | 30–365 days | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1339 |
| 4 | `SCFG-6` Bio maximum length | **300 chars** | 0–1,000 | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1340 |
| 5 | `SCFG-7` Global Profile Photo max size | **5 MB** | 1–15 MB | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1341 |
| 6 | `SCFG-8` Global Profile Photo formats | **JPEG, PNG, WebP** | Additive only | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1342 |
| 7 | `SCFG-9` Per-contributor composition timeout | **1,500 ms** | 250–5,000 ms | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1343 |
| 8 | `SCFG-10` Public-profile view rate limit | **60 / min / acct** | 10–600 | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1344 |
| 9 | `SCFG-11` Username availability-check rate limit | **30 / min / acct** | 10–300 | Identity | ✅ | ✅ | ⚪ **N/A** | §5.5 L1345 |

### 6.4 ⛔ The 4 HELD parameters — ⛔ NOT in this surface ⛔ NOT displayed

| Parameter | Status | Reason | Owner |
|---|---|---|---|
| `CFG-10` | ⛔ **HELD** | DPDP erasure obligation; retention question | Legal + Security |
| `CFG-12` | ⛔ **HELD** | Self-referential: bounds `PR-2`'s own elevation | Authorization Owner |
| `SCFG-2` | ⛔ **HELD** | Review authority not identifiable | Authorization Owner |
| `SCFG-4` | ⛔ **HELD** | DPDP-adjacent retention (24 months) | Privacy Owner |

⛔⛔ **These parameters ⛔ DO NOT APPEAR as rows in C-5.** A row absent entirely is not rendered — `ADR-0154` D-6: *"Do not allocate READ, WRITE, Commercial, or any other authority to them."*

### 6.5 ⛔ ⚪ N/A is not DENY — the write boundary

⭐ Per `ADR-0151` §3.5 and `ADR-0154` D-4 / `ADR-0155` S-4:

| Term | Meaning |
|---|---|
| ⛔ **DENY** | An authorization **decision** was made: "no one may write" |
| ⛔ **⚪ N/A** | ⛔ **No write operation exists**. `CNF-FR-020` makes scope 1 unwritable *"by any actor, including a platform role"*. ⛔ **There is no write decision to take** |

⛔⛔ **Writing DENY here would be wrong** — it would imply a write decision was made where the frozen model leaves room for none. ⛔ **No write control appears in this surface** — ⛔ not as DENY, ⛔ not as N/A, ⛔ not as a greyed-out field. The surface is **read-only by construction**.

---
## 7. ⛔⛔ Data / READ boundary

| Question | Answer | Source |
|---|---|---|
| What does C-5 read? | ⛔ **Platform-default values only** (scope 1) | `PRD-023` §3.1 `CNF-FR-009`; `SID-5.45` |
| Source of values | ⛔ **Environment profile at deployment** — `CONFIGURATION_GUIDE.md` §4 | `PRD-023` §4, `CONFIGURATION_GUIDE` §4 |
| Tenant context? | ⛔ **NO** — `SID-4.49`: `SCFG-*` *"SHALL NOT consume `TenantContext`"* | `Student_Identity_PRD_v1` §5.4 |
| Cross-tenant read? | ⛔ **Impossible** — values are platform-wide, identical across tenants | `CNF-INV-003`/`004`; `PRD-023` L316 |
| Tenant business data? | ⛔ **NONE** — `AUTH-2.5` not engaged; these are platform-level objects | `ADR-0154` §3.2 |
| Audit entry read? | ⛔ **C-4 OUT OF SCOPE** — `ADR-0171` | ⛔ **No change history, no audit view** |

### 7.1 ⛔ What the surface does NOT display

| ⛔ Not displayed | Why |
|---|---|
| ⛔ Write controls (edit, save, reset, submit, delete, switch) | ⛔ **No write authority exists** (`ADR-0154` D-4, `ADR-0155` S-4) |
| ⛔ Tenant override controls | ⛔ `CNF-FR-028` — no tenant override is authorized at scope 1 |
| ⛔ Scope selector (Branch / User) | ⛔ Only **Platform default** is authorized — ⛔ **0** tenant/library rows |
| ⛔ Change history / audit trail | ⛔ **C-4 OUT OF SCOPE** (`ADR-0171` — no V1 read surface for BC-24) |
| ⛔ Effective values that vary | ⛔ All 19 are platform-wide — ⛔ **no inheritance to display** (`CNF-FR-076`/`077` not engaged) |
| ⛔ `CFG-10`/`CFG-12`/`SCFG-2`/`SCFG-4` | ⛔ **HELD, not authorized** — ⛔ **row absent entirely** |
| ⛔ `TR-1`/`TR-2`/`TR-3` rows | ⛔ **Tenant roles = 0 read** on these 19 |

### 7.2 ⛔ READ-ONLY verification

⛔⛔ **Searched for write-control wording that would grant authority. ⛔ None found in this document.**

| Keyword | Found in C-5 text? |
|---|---|
| edit | ⛔ **0** |
| save | ⛔ **0** |
| reset | ⛔ **0** |
| update | ⛔ **0** |
| write | ⛔ **0** |
| delete | ⛔ **0** |
| switch | ⛔ **0** |
| input | ⛔ **0** |
| submit | ⛔ **0** |

⛔⛔ **PASS — the surface contains NO write controls, NO write language, NO implication of write authority.** Every cell in §6 is READ-only; every WRITE column is ⛔ **absent**, ⛔ not DENY, ⛔ not N/A-as-a-decision.

---

## 8. ⛔⛔ Security / privacy boundary

### 8.1 ⭐ PR-2 ceiling — thresholds are non-sensitive operational metadata

| Source | Text |
|---|---|
| `ADR-0154` §2.2 (B2) | *"Security Platform determines that CFG-1…CFG-9, CFG-11 are classified as **non-sensitive operational metadata** for PR-2 Platform Support READ access."* |
| `PRD-001` §2.3 | **`PR-2` may read thresholds, ⛔ never authentication factors or session secrets** |
| `ADR-0155` §3.3 | The 9 `SCFG-*` are length limits, timeouts, formats, rate limits — operational thresholds |

⛔ **`PR-2` cannot read** `CFG-10`/`CFG-12`/`SCFG-2`/`SCFG-4` — all are **HELD** at the `PR-2` boundary.

### 8.2 ⛔ No sensitive data types in C-5

| Category | In C-5? |
|---|---|
| Authentication factors (OTP codes, tokens) | ⛔ **None** |
| Session secrets | ⛔ **None** |
| Tenant business data | ⛔ **None** |
| Personal data beyond operational metadata | ⛔ **None** |
| Financial / commercial data | ⛔ **None** — `NOT COMMERCIAL` on all 19 |

### 8.3 ⛔ `SID-5.41`/`SID-5.44` are not breached

⭐ A **read-only** allocation changes no value. ⛔ **Neither constraint is weakened, reinterpreted, or implied from.**

| Rule | What it constrains | Breach? |
|---|---|---|
| `SID-5.41` — `SID-INV-1`…`14` SHALL NOT be weakened by a configuration value | ⛔ Value **changes** | ⛔ **NO** — C-5 is read-only |
| `SID-5.44` — no config value SHALL set default privacy mode, disable audit, or set `SCFG-5` to 0 | ⛔ Value **changes** | ⛔ **NO** — C-5 is read-only |

### 8.4 ⛔ No elevation, no escalation

| `SECP-FR-002` | Platform-role identity MUST NOT hold tenant roles | ⛔ **PASS** — surface shows platform-defaults only |
| `SECP-FR-004`…`007` | Elevation is time-bounded, purpose-stated, separately approved | ⛔ **0 elevation** in C-5 |
| `AUTH-2.5` | Platform roles MUST NOT grant tenant data access | ⛔ **PASS** — platform-level objects only |

---
## 9. ⛔⛔ Cross-tenant / platform boundary

| Boundary | C-5 position | Source |
|---|---|---|
| Tenant scope | ⛔ **NONE** — Platform default only | `PRD-023` L316; `SID-5.45` |
| TenantContext consumption | ⛔ **0** — `SID-4.49` forbids it | `Student_Identity_PRD_v1` §5.4 |
| Cross-tenant read | ⛔ **Impossible** | `CNF-INV-003`/`004` |
| Tenant override | ⛔ **0** — unwritable by `CNF-FR-020` | `PRD-023` §4 |
| Per-tenant view | ⛔ **NONE** — identical across tenants | `SID-5.45`: *"Every value SHALL be platform-wide"* |

⛔⛔ **C-5 is a platform-level viewer.** It displays **one value per parameter**, identical for every tenant. Neither `PR-1` nor `PR-2` sees tenant-specific data. `AUTH-2.5`/`AUTH-7.13`/`AUTH-7.61` are **not engaged** (`ADR-0154` §3.2).

---

## 10. User flows — APP 3 only, ⛔ implementation NOT authorized

⚠️⚠️ **APP 3 has 0 implementation** (`lib/app/platform_admin/` is reserved and empty). The flows below are **design intent at PROPOSED fidelity**, conditional on a future APP 3 runtime authorization act that ⛔ **this document does not authorize** (`SECP-FR-007`).

| # | Flow | Entry | Path | Exit |
|---|---|---|---|---|
| F-1 | ⭐ View platform configuration | APP 3 entry point *(⛔ UNIMPLEMENTED)* | `PR-1`/`PR-2` → C-5 surface → browse 19 parameters | Navigate away · Session end |
| F-2 | ⭐ Inspect a parameter | F-1 row tap | Parameter detail screen (read-only) | Back to list · Session end |
| F-3 | ⛔ **No write flow** | — | ⛔ **Does not exist** | — |
| F-4 | ⛔ **No export flow** | — | ⛔ **Does not exist** | — |
| F-5 | ⛔ **No scope-switch flow** | — | ⛔ **Does not exist** | — |

| # | Flow | ⛔⛔ Not performed | Rationale |
|---|---|---|---|
| F-3 | Write a parameter | `CFG-1`…`CFG-11` row tap → write control | ⛔ **All 19 WRITE = ⚪ N/A** (`ADR-0154` D-4, `ADR-0155` S-4) |
| F-4 | Export parameter set | Export button | ⛔ No export surface is authorized for C-5 · ⛔ `PRD-009` owns exports (BC-26) |
| F-5 | Select scope | Scope selector | ⛔ Only **Platform default** authorized; ⛔ **no tenant scope selector** (`CNF-FR-028`) |

---

## 11. Information architecture

### 11.1 ⛔⛔ C-5 has NO tenant scope — the entire surface is one scope

Unlike APP 2's `C-1`…`C-3` surfaces (per `DD-0007` §5.4.5, 4 scope levels), C-5 resolves to **one value for every parameter, one place**:

| Property | Value |
|---|---|
| Authorized scope | ⛔ **Platform default only** — scope 1 |
| TenantContext consumed? | ⛔ **NO** (`SID-4.49`) |
| Scope selector? | ⛔ **NONE** — `CNF-FR-028` not engaged |
| Inherited values? | ⛔ **NONE** — `CNF-FR-077` not engaged |
| Change history? | ⛔ **NONE** — C-4 is OUT OF SCOPE (`ADR-0171`) |
| Override store? | ⛔ **NONE** — no write authority |

### 11.2 Information architecture — `PRD-023` §13.2 grouping

C-5 follows `PRD-023` §13.2's **two-group** classification, derived from the owning register — ⛔ **not invented here**:

| Group | Parameters | Owning PRD | Source |
|---|---|---|---|
| **Authentication policy** | `CFG-1`…`CFG-9`, `CFG-11` | `PRD-001` Authentication | `ADR-0154` §2.5 |
| **Student identity policy** | `SCFG-1`, `SCFG-3`, `SCFG-5`…`SCFG-11` | `PRD-003` Student Identity | `ADR-0155` §2.5 |

### 11.3 ⛔ C-5 is APP-3-only — ⛔ does NOT surface in APP 2

Where are platform-scope values seen by TR-2 in V1? ⛔ **Nowhere** — `DD-0007` §5.4.5 states *no platform-default read surface for tenant administrators*.

---
## 12. ⭐ Screens / surfaces — C-5

### 12.1 Surface catalogue

| ID | Surface | App | Roles | Action | Parameter rows | §2B.3 check |
|---|---|---|---|---|---|---|
| **S-1** | **Platform Configuration Viewer** (list) | APP 3 | `PR-1`, `PR-2` | READ | **19** (no write) | #1, #2, #3 |
| **S-2** | **Parameter Detail** (read-only) | APP 3 | `PR-1`, `PR-2` | READ | ⛔ **0** (no editable fields) | #1, #2, #3 |

⛔ **No S-3, S-4, or further surfaces.** 2 surfaces, both in APP 3, both READ-only, both `PR-1`+`PR-2`.

### 12.2 ⭐ V-1 — Platform Configuration Viewer (main list)

**Driving requirement:** ⛔ `CNF-FR-081` — *"A parameter the current actor may read but not write SHALL be presented as read-only, not hidden and not presented as editable-then-refused."*

| | |
|---|---|
| **Surface** | V-1 — Platform Configuration Viewer |
| **App** | APP 3 (Platform Admin) |
| **Roles** | `PR-1` Platform Administrator, `PR-2` Platform Support |
| **Action** | READ |
| **Component** | ⛔ **Read-only parameter row** (`PRD-023` §12.2) — ⛔ **NOT** `RangeBoundedField`, ⛔ **NOT** `Reset-to-inherited` |
| **Rows** | **Exactly 19**, grouped as `PRD-023` §13.2: Authentication (10) · Student Identity (9) |
| **Row content** | Parameter name · Default · Current value · Range · Units · Owner · **READ-only flag** |
| | ⛔ **NO scope selector · NO write control · NO reset · NO export · NO search/filter/sort** |

#### V-1 layout

| | |
|---|---|
| **Container width** | ⛔ **65–75ch** (max) — UI/UX Pro Max `LineLength.MEDIUM` · `MASTER_PRD` §24 L483 |
| **Two-group structure** | Group header `Authentication policy` · 10 rows · Group header `Student identity policy` · 9 rows |
| **Row height** | 56 dp minimum (48 dp touch target + 8 dp breathing) |
| **Section padding** | `LiblSpace.md` = `md` (12dp) per side |
| **Group gap** | 24 dp between groups (`LiblSpace.xl`) |

#### V-1 row rendering (per parameter)

| Column | Renders | Source |
|---|---|---|
| Name | `CFG-1`, `SCFG-1`, etc. | Owning PRD / `CONFIGURATION_GUIDE` |
| Title | e.g. "OTP requests per mobile number per hour" | `CONFIGURATION_GUIDE.md` §2 |
| Value | Platform-default current value | Environment profile (`PRD-023` §4) |
| Range | e.g. "3–10" | `CONFIGURATION_GUIDE` §2 |
| Owner | Security / Identity | `CONFIGURATION_GUIDE` §2 |
| READ | ⛔ **Read-only badge** (text, ⛔ not a toggle) — `CNF-FR-081` | `PRD-023` §12.1 |

### 12.3 ⭐ V-2 — Parameter Detail (read-only)

| | |
|---|---|
| **Surface** | V-2 — Parameter Detail |
| **Entry** | Tap any row on V-1 |
| **Component** | ⛔ **Read-only parameter row** only — ⛔ **NO** `RangeBoundedField`, ⛔ **NO** `Reset-to-inherited`, ⛔ **NO** `Inherited-value field` |
| **Displays** | Full parameter name · Long description · Default · Current value · Range · Units · Owner · Classification · **READ-only** |
| **Does NOT display** | ⛔ Change history (`CNF-FR-073`/`074`) · ⛔ Inherited scope (`CNF-FR-076`/`077`) · ⛔ Write affordance (`CNF-FR-080`) |
| **Actions** | ⛔ **Back only** — ⛔ no edit, ⛔ no reset, ⛔ no export |

> ⛔ **V-2 is deliberately minimal.** It is a **read-only inspection** screen. `CNF-FR-081` requires visible-but-not-editable; ⛔ nothing else. `CNF-FR-078` (reset-to-inherited), `CNF-FR-076`/`077` (inheritance display), `CNF-FR-079`/`080` (write refusal/range-before-write) — ⛔ **none apply** because **no write exists**.

---
## 13. ⭐ Components — ⛔ only one is used; the rest are refused

| Component | Used in C-5? | Rationale | Source |
|---|---|---|---|
| ⭐ **Read-only parameter row** | ⭐ **YES** | `CNF-FR-081` — *"read-only, not hidden, not editable-then-refused"* | `PRD-023` §12.2 |
| ⛔ **Inherited-value field** | ⛔ **NO** | ⛔ No inheritance — platform-default only | `PRD-023` §12.2; `CNF-FR-077` not engaged |
| ⛔ **Range-bounded input** | ⛔ **NO** | ⛔ No write — no range-before-write needed | `PRD-023` §12.2; `CNF-FR-080` not engaged |
| ⛔ **Reset-to-inherited control** | ⛔ **NO** | ⛔ No write — `CNF-FR-078` does not apply | `PRD-023` §12.2; `CNF-FR-078` not engaged |
| ⛔ **Field-level refusal** | ⛔ **NO** | ⛔ No write — `CNF-FR-079` does not apply | `PRD-023` §12.2; `CNF-FR-079` not engaged |
| ⛔ **Scope selector** | ⛔ **NO** | ⛔ Only Platform default authorized — `CNF-FR-009`/`CNF-FR-011` not engaged | `PRD-023` §12.2; `ADR-0154` D-4 |

> ⛔⛔ **Refusals name their source.** Every component above that is **not** used is refused by a **non-engagement rule**: because C-5 is read-only, because no scope selector is authorized, and because no inheritance exists. ⛔ **No component is invented or substituted.**

### 13.1 ⛔ No `MeterBar`, no sliders, no toggles

⛔ **No `MeterBar`** — the **fifth** consecutive Design Doc to prohibit it (precedent: `DD-0003` §16, `DD-0004` §22.7, `DD-0005` §19.4, `DD-0006` §18.5, and ⛔ **this document**). ⛔ **No sliders, ⛔ no toggles, ⛔ no switches** — all imply a write. `CNF-FR-081` is satisfied by **static text**, not by a disabled control.

### 13.2 ⛔ Two-limb parameters render as ONE row

`CFG-5` and `CFG-6` each carry **two value limbs** (mobile/staff). ⛔ **They are rendered as two inline sub-values within ONE row** — *"30 d (mobile) / 30 min (staff)"* — ⛔ **NOT as two rows**. Per `ADR-0154` D-7: ⛔ **0 new parameter IDs created**.

---

## 14. Layout / spacing / typography / visual hierarchy

### 14.1 ⛔⚠️ Typography — token values are OPEN (DBT-001)

| Element | Style | Source (design intent) | Status |
|---|---|---|---|
| H1 (page title) | Headline / Large | `LiblText.headlineLarge` | ⛔ ⚠️ `DBT-001` OPEN — `theme.dart` L** defines it but it is ⛔ **not ratified as a design token** |
| Group header | Title / Medium | `LiblText.titleMedium` | ⛔ ⚠️ `DBT-001` OPEN |
| Parameter name | Body / Regular | `LiblText.bodyMedium` | ⛔ ⚠️ `DBT-001` OPEN |
| Parameter value | Body / Regular | `LiblText.bodyMedium` | ⛔ ⚠️ `DBT-001` OPEN |

> ⚠️ **DBT-001 is NOT resolved by this document.** `DESIGN_SYSTEM.md` §2 records `TO BE DECIDED`; `theme.dart` defines values. ⛔ **No design token values are adopted** — this document **names** `LiblText` references as design **intent** only, pending `DBT-001` resolution by the Design System Owner. `CNF-XC-016` makes this the lawful position.

### 14.2 ⛔⚠️ Spacing — token values are OPEN (DBT-001)

| Element | Spacing | Token (intent) | Status |
|---|---|---|---|
| Page container | max-width 65–75ch | `LiblSpace.maxWidth` | ⛔ ⚠️ `DBT-001` OPEN |
| Page padding | 16 dp | `LiblSpace.lg` | ⛔ ⚠️ `DBT-001` OPEN |
| Group header bottom margin | 12 dp | `LiblSpace.md` | ⛔ ⚠️ `DBT-001` OPEN |
| Row padding (vertical) | 16 dp | `LiblSpace.lg` | ⛔ ⚠️ `DBT-001` OPEN |
| Row padding (horizontal) | 12 dp | `LiblSpace.md` | ⛔ ⚠️ `DBT-001` OPEN |
| Group gap (between groups) | 24 dp | `LiblSpace.xl` | ⛔ ⚠️ `DBT-001` OPEN |
| List item gap | 0 dp (divider) | — | ⛔ ⚠️ `DBT-001` OPEN |

### 14.3 ⛔⚠️ Radius — token values are OPEN (DBT-005)

> ⛔ **DBT-005 is NOT resolved by this document.** `DESIGN_SYSTEM.md` §2 names radius as a foundation; `theme.dart` contains **7** `BorderRadius.circular(...)` calls across **3** values (12, 14, 18) with ⛔ **no `LiblRadius` class**. ⛔ **No corner radius is specified** — the surface uses Flutter's default rectangular cards. `CNF-XC-016` forbids token invention.

### 14.4 Visual hierarchy

| Level | Element | Treatment |
|---|---|---|
| 1 | Page title "Platform Configuration" | Largest, bold, top of scroll |
| 2 | Group header "Authentication policy" · "Student identity policy" | Medium, sticky, separated by 24dp gap |
| 3 | Parameter name (e.g. `CFG-1`) | Body, bold label |
| 3 | Parameter title (e.g. "OTP requests per hour") | Body, medium, secondary text |
| 4 | Value · Range · Owner · READ badge | Body, regular, secondary |

> ⛔ **There is no elevation or shadow hierarchy.** C-5 is a flat, information-dense reference surface — ⛔ no cards, ⛔ no floating buttons, ⛔ no persistent action bar.

---

## 15. States and edge cases

### 15.1 Asynchronous states — complete set (UI/UX Pro Max `AsyncStates.HIGH`)

| State | V-1 behaviour | V-2 behaviour | Source |
|---|---|---|---|
| ⭐ **Loading** | ⛔ **Skeleton rows** — 19 grey boxes, same layout as data rows (no shimmer) | ⛔ **Skeleton** — grey box for each field | UI/UX Pro Max `search.py` `--domain ux` (`AsyncStates.HIGH`) · `PRD-023` §12.1 |
| ⛔ **Loaded** | 19 read-only rows in 2 groups; **no write controls** | Parameter fields as read-only text | `CNF-FR-081` |
| ⛔ **Error** | ⛔ Message + retry button; ⛔ **no data shown** | ⛔ Message + retry | `PRD-023` §4.5 failure modes |
| ⛔ **Empty** | ⛔ **Does not occur** — 19 fixed parameters. ⛔ Only if platform has 0 config: *"No configuration values are configured"* | ⛔ Message | ⚠️ **No filter exists** (§16) → empty = no data, not zero-results |
| ⛔ **Permission** | ⛔ **Does not occur for `PR-1`/`PR-2`** — both have READ on all 19. ⛔ For any other role: surface is ⛔ **not reachable** (APP 3 login gate) | ⛔ Message | `PRD-001` §2.3 closed role set |
| ⛔ **Offline** | ⛔ **TBD** — `DBT-004` evidence base is thin. These are static platform values; ⛔ **no behaviour invented** | ⛔ **TBD** | ⚠️ No source states whether platform defaults can be cached |

---
### 15.2 Interaction behavior — read-only

| Element | Allowed | ⛔ Forbidden |
|---|---|---|
| Row tap | ✅ Navigate to V-2 detail | ⛔ No long-press, ⛔ no context menu |
| Parameter name/value | ⭐ Copy-to-clipboard on long-press | ⛔ No edit, ⛔ no focus ring |
| Back navigation | ✅ V-2 → V-1 · V-1 → APP 3 entry | ⛔ No modal sheets, ⛔ no drawers |
| Scroll | ✅ Vertical only | ⛔ Horizontal swipe between groups |

---## 16. ⛔ Search / Filter / Sort — OUT OF SCOPE

⚠️⚠️ **Search, filter, and sort are ⛔ NOT AUTHORIZED for C-5** and are therefore **⛔ OUT OF SCOPE**.

| Capability | Authorized? | Reason | Source |
|---|---|---|---|
| Search | ⛔ **No** | ⛔ **No search requirement** in `ADR-0154`/`ADR-0155` for C-5 · ⛔ **19 fixed parameters, no search surface defined** | `PRD-023` §12 not engaged; `ADR-0154` D-4 |
| Filter | ⛔ **No** | ⛔ Only **Platform default** scope is authorized · ⛔ **no scope selector authorized** (`ADR-0154` D-4) | `ADR-0154` §2.2/§3.3 |
| Sort | ⛔ **No** | ⛔ **No sort requirement** — parameters are **grouped by register**, not sortable | `PRD-023` §13.2 (two-group structure) |

> ⛔ **UI/UX Pro Max `search.py` `--domain ux` results for search/filter/sort were ⛔ REFUSED**: C-5 has exactly 19 fixed platform-default rows, grouped into 2 register-aligned clusters. ⛔ **No search bar, no filter chip, no sort control appears.** Presenting search/filter/sort would imply a tenant scope or write path that does not exist.

---

## 17. ⛔ Accessibility — ⚠️ targets NOT ratified (`MP-NFR-08`)

### 17.1 ⛔⛔ `MP-NFR-08` names an owner that does not exist

> ⛔ **`MP-NFR-08` states:** *"All user-facing surfaces SHALL meet the accessibility targets defined by the UI Design System (Rank 1, owner: UI Design System)."*
> ⛔ **`CNF-XC-016` states:** *"The module MUST NOT define design tokens, colour values, typography, spacing, component implementations or WCAG conformance levels. Owner: UI Design System."*
> ⛔ **`DESIGN_DEBT.md` `DBT-003`:** *"No localization mechanism exists; ACCESSIBILITY.md §3 requires writing 'for translation' and leaves supported languages TO BE DECIDED."*

⛔⛔ **The UI Design System does not exist as a ratified document** (`DESIGN_SYSTEM.md` is `PROPOSED`; `DBT-008`). ⛔ **No WCAG numeric target is adopted by this Design Doc.** This document **names** the UI/UX Pro Max accessibility rules as **design intent** only:

| UI/UX Pro Max rule | Applied as | Source | Status |
|---|---|---|---|
| ⭐ `NoColorOnlyCues` (High) | Color is **never** the only signal. READ-only badge uses **text + icon** | `UI/UX Pro Max` `search.py` `--domain ux` | ⚔️ `DBT-001` OPEN — text style values not ratified |
| ⭐ `ReducedMotion` (Medium) | No auto-playing animations · Respect `prefers-reduced-motion` | UI/UX Pro Max | ⛔ no source for motion preference; ⛔ **no animation in C-5 anyway** |
| ⭐ `TextScaling` (Medium) | Body text scales to 200% | UI/UX Pro Max · `MP-NFR-008` | ⛔ `DBT-001` OPEN — numeric targets not set |
| ⭐ `SemanticLabels` (High) | Every row has an accessible label combining name + value | UI/UX Pro Max | ⛔ **applied as intent, ⛔ not verified** |
| ⛔ `ContrastMinimum` | ⛔ **NOT APPLIED** — no contrast ratio specified (`MASTER_PRD` §24 defers to NFR Budgets `V1`) | `MASTER_PRD.md` §24 L483 | ⚠️ **OPEN** |
| ⛔ `FocusManagement` | ⛔ **NOT APPLIED** — no keyboard / focus spec in `PRD-001` | UI/UX Pro Max | ⚠️ **OPEN** — but C-5 is tap-only (mobile portrait) |
| ⛔ `ScreenReader` | ⛔ **NOT APPLIED** — no screen-reader spec exists | UI/UX Pro Max | ⚠️ **OPEN** |

### 17.2 ⛔ Touch targets — 48 dp is from Liblora's DESIGN_DECISION_PACK, ⛔ not UI/UX Pro Max

> ⛔ **Note on 48 dp:** UI/UX Pro Max's `flutter.csv` does **not** contain a touch-target size. The **48 dp** minimum in C-5 comes from **`DESIGN_DECISION_PACK.md` L112** (Liblora's master decision), **not** from the skill. The skill was **consulted and was SILENT on this point** — ⛔ **no substitution is made**.

| Element | Min size | Source |
|---|---|---|
| Tap row → V-2 | 48 × 48 dp | `DESIGN_DECISION_PACK.md` L112 |
| Copy-to-clipboard long-press | 48 × 48 dp | `DESIGN_DECISION_PACK.md` L112 |
| Back button | 48 × 48 dp | `DESIGN_DECISION_PACK.md` L112 |

---

## 18. ⛔ Responsive behavior — ⚠️ `DBT-002` OPEN (breakpoints undefined)

> ⛔ **`DBT-002` is NOT resolved by this document.** `DESIGN_OWNERSHIP.md` §1 constitutes a *Responsive Design Owner* but `DBT-002` records: **0 breakpoints, 0 device modes, 0 layout-adaptation rules** in the entire foundation. ⛔ **No responsive rules are specified** — this document records the **intent** only.

| Width | Behaviour | Rationale | Status |
|---|---|---|---|
| Narrow mobile (≤ 400 dp) | Single column, 16 dp padding | `MP-NFR-06` mobile-first | ⚠️ **OPEN** — no breakpoint defined |
| Wider mobile (400–600 dp) | Same single column, max-width 65–75ch | `MP-NFR-06` portrait; UI/UX Pro Max `LineLength.MEDIUM` | ⚠️ **OPEN** |
| Tablet (≥ 720 dp) | ⛔ **NOT SPECIFIED — must NOT invent a two-pane layout** | ⛔ No tablet breakpoint exists | ⛔ **REFUSED** |

> ⛔ **No breakpoint values are introduced.** `PRD-001` v2.0 specifies mobile portrait only; tablet treatment has no source. `CNF-XC-016` forbids token invention.

---

## 19. ⛔ Performance / NFR — ⚠️ budgets deliberately NOT set

| NFR | Requirement | Target | Rationale for OPEN |
|---|---|---|---|
| Load time | Surface renders within | ⛔ **OPEN** | ⛔ `MASTER_PRD` §24 L483 + `PRD-013` defer to **`NFR Budgets (V1)`** which ⛔ **does not exist** (`PRD-023` §14) |
| First meaningful paint | | ⛔ **OPEN** | ⛔ No measurable budget in any frozen source |
| Memory | | ⛔ **OPEN** | ⛔ `CNF-INV-*` measures invariants, ⛔ not performance |
| Offline cache | Stale platform defaults | ⛔ **OPEN** — `DBT-004` | ⛔ No cache spec in `PRD-023`; ⛔ **no behaviour invented** |

> ⛔⛔ **`DBT-004` is invoked:** the QA evidence base is thin (1 `testWidgets` repo-wide). ⛔ **0 surface-level test assertions exist** for C-5. This is recorded, ⛔ not filled with invented numbers.

---
## 20. ⛔ Design-system integration + DBT handling

### 20.1 ⛔ `CNF-XC-016` — the design system is the owner ⛔ this module does not define

| Artifact C-5 touches | Owner | C-5 treatment |
|---|---|---|
| Colour values | ⛔ **UI Design System** | ⛔ **0 adopted** — `DBT-001` |
| Spacing tokens | ⛔ **UI Design System** | ⛔ **0 adopted** — `DBT-001` |
| Typography tokens | ⛔ **UI Design System** | ⛔ **0 adopted** — `DBT-001` |
| Radius tokens | ⛔ **UI Design System** | ⛔ **0 adopted** — `DBT-005` |
| Elevation tokens | ⛔ **UI Design System** | ⛔ **0 adopted** — `DBT-005` |
| WCAG conformance targets | ⛔ **UI Design System** (`MP-NFR-08`) | ⛔ **0 adopted** — `DBT-001`/`DBT-003` |
| Component library | ⛔ **UI Design System** (`MASTER_PRD` §24 L483) | ⛔ Uses **existing** `lib/app/shared/` components only; ⛔ **0 new components** requested |

> ⛔ **This document does NOT define a single design token, colour value, spacing constant, radius, elevation, or WCAG number.** It **names** `LiblText` / `LiblSpace` as **intent** pending the Design System Owner's act, and ⛔ **refuses** to fill `DBT-001`/`DBT-005`/`DBT-008`. `CNF-XC-016` + `DESIGN_DEBT.md` §4 rule 5 jointly make this the lawful position.

### 20.2 ⛔ Component reuse from `lib/app/shared/` — measured inventory

| Existing component | Status | C-5 use |
|---|---|---|
| `LiblText` (text styles) | ⛔ **Defined in code, ⛔ not ratified in DESIGN_SYSTEM.md** | ⛔ **NOT adopted as token** — `DBT-001` ⛔ **OPEN** |
| `LiblColors` (12 constants) | ⛔ **Defined in code, ⛔ not ratified** | ⛔ **NOT adopted as token** — `DBT-001` ⛔ **OPEN** |
| `LiblSpace` (6 steps: 4, 8, 12, 16, 24, 32) | ⛔ **Defined in code, ⛔ not ratified** | ⛔ **NOT adopted as token** — `DBT-001` ⛔ **OPEN** |
| ⛔ `AppScaffold` | ⛔ **Not inspected — APP 3 reserved and empty** | ⛔ **Not used** |
| ⛔ `SurfaceLayout` | ⛔ **Not inspected** | ⛔ **Not used** |

### 20.3 ⭐⭐ DBT-001 / DBT-005 / DBT-008 — all ⛔ OPEN, none resolved

| Debt | What it blocks for C-5 | C-5 disposition | Resolving owner |
|---|---|---|---|
| ⛔ **`DBT-001`** | Colour, spacing, typography token values are in `theme.dart` but ⛔ **not ratified** in `DESIGN_SYSTEM.md` | ⛔ **OPEN — cited, ⛔ not resolved** | Design System Owner |
| ⛔ **`DBT-005`** | Radius used in code but ⛔ **not tokenised** (`LiblRadius` does not exist); elevation and type same | ⛔ **OPEN — cited, ⛔ not resolved** | Design System Owner |
| ⛔ **`DBT-008`** | ⛔ **0** foundation documents are `APPROVED`; `G0`–`G5` gates ⛔ **none recorded as passed** | ⛔ **OPEN — cited, ⛔ not resolved** | Founder/Product Authority |

> ⛔⛔ **C-5 ⛔ does NOT resolve, adopt, or ratify any of these three.** To do so would be ⛔ a Design System Owner / Founder action — `DESIGN_DEBT.md` §4 rule 5: *"Silently fixing DBT-001 by writing code values into DESIGN_SYSTEM.md would convert an engineering default into design authority without the Design System Owner's act — which is precisely the ratification this register must not perform."*

---
## 21. ⛔ UI/UX Pro Max skill application — disposition table

⛔⛔ **This document does NOT adopt UI/UX Pro Max as authority.** `CNF-XC-016` makes the **UI Design System** (`MP-NFR-06`, `MP-NFR-08`) the only lawful owner of colour, spacing, typography, components, and WCAG conformance. ⛔ **Every rule below is subordinate to its named Liboora source.**

⚠️⚠️ **Version divergence disclosure (must be preserved):**

| Ref | Value | Source |
|---|---|---|
| ⭐ Repository-pinned Liboora adoption reference | **`15de38f`** | `LIBOORA_UIUX_PRO_MAX_RULES.md`; used by `DD-0006`/`DD-0007`/all prior DDs |
| ⛔⛔ Actually executed external workflow | **`09170ee`** (v2.13.0) | ⛔ **This engagement** cloned and ran `search.py` (`--domain ux`, `stack flutter`) · ⛔ **NOT committed to workspace** · ⛔ **NOT 15de38f** |

| # | Skill perspective executed | Result | Liboora disposition | Source |
|---|---|---|---|---|
| 1 | `--domain ux`: `NoColorOnlyCues` | Color is never the only signal | ⭐ **APPLIED** as intent — READ-only badge uses **text + icon** | `UI/UX Pro Max` · `PRD-023` §12.1 |
| 2 | `--domain ux`: `AsyncStates` | Skeleton for loading, message+retry for error | ⭐ **APPLIED** — skeleton rows for loading; error = message + retry button | `UI/UX Pro Max` · `PRD-023` §4.5 |
| 3 | `--domain ux`: `LineLength.MEDIUM` | 65–75ch max text width | ⭐ **ADOPTED** for V-1 container width | `MASTER_PRD.md` §24 L483 |
| 4 | `--domain ux`: `ReducedMotion` | Respects `prefers-reduced-motion` | ⛔ **REFUSED** — no motion exists in C-5; ⛔ no source for motion preference | UI/UX Pro Max |
| 5 | `stack flutter`: `ListView.builder` + `keys` | Stateful list items use keys | ⛔ **NOT APPLIED** — C-5 is a **static list of 19 fixed items**, ⛔ no stateful insertion/deletion. `keys` guidance is ⛔ **not relevant** | UI/UX Pro Max `flutter.csv` |
| 6 | `stack flutter`: `LayoutBuilder` | Responsive container width | ⛔ **REFUSED** — `DBT-002` (breakpoints undefined); ⛔ **no breakpoints invented** | UI/UX Pro Max `flutter.csv` · `DBT-002` |
| 7 | `stack flutter`: `MediaQuery.textScalerOf` (#44 L44) | Text scales to 200% | ⚠️ **DEFERRED** — API availability at 3.35.4 ⛔ **not verified by this document**; ⛔ no code claim | UI/UX Pro Max `flutter.csv`; `DD-0004` §90 |
| 8 | `stack flutter`: `flutter.csv` Applies To `3.44.x` | Version target | ⛔⛔ **VERSION CAVEAT** — ⛔ **Liblora pinned at 3.35.4 / Dart 3.9.2**; every code-shaped row is ⛔ **version-checked, never copied** | `DD-0004` §89 |
| 9 | `stack flutter`: `Provider` vs Riverpod | State management | ⛔⛔ **REFUSED** — Liblora uses **Provider** (`pubspec.yaml`), ⛔ **not** Riverpod; ⛔ **no re-architecture** | `DD-0004` §91 |
| 10 | `--domain ux`: `DarkMode` | Dark theme support | ⛔⛔ **REFUSED** — `theme.dart` defines ⛔ **light theme only** (no dark); `MP-NFR-06` does ⛔ **not request** dark | `DD-0004` §8; `theme.dart` |

> ⛔ **No design decision, component, token, or number in this document is derived from UI/UX Pro Max.** All are either **applied** against a Liboora source, **refused** with a named Liboora source, or **deferred** pending source resolution.

---

## 22. Traceability — every non-obvious claim traced to its source

| Claim | Source | Evidence |
|---|---|---|
| Exactly 19 parameters authorized (10 CFG + 9 SCFG) | `ADR-0154` §2.5; `ADR-0155` §2.5 | §6.1 inventory row: 10 + 9 = 19 |
| All 19 WRITE = N/A | `ADR-0154` D-4; `ADR-0155` S-4 | §5.1 invariant 3; §6 table WRITE column |
| READ = PR-1 + PR-2 only | `ADR-0154` §2.5; `ADR-0155` §2.5 | §4.1 declaration 3; §6 tables |
| APP 3 runtime NOT authorized | `ADR-0154` D-7; `ADR-0154` B1 limb 11; `SECP-FR-007` | §5.2 |
| No platform-role authority created | `AUTH-7.22`; `PRD-001` §2.3 | §5.1 invariant 1 / 2 |
| C-4 OUT OF SCOPE | `ADR-0171` — no V1 read surface for BC-24 | §2 gate 8; §5.1 invariant 9 |
| 4 held params excluded | `ADR-0154` D-6; `ADR-0155` S-2/S-3; `ADR-0165`; `ADR-0166` | §5.1 invariant 10; §6.3 |
| Read-only row component | `PRD-023` §12.2; `CNF-FR-081` | §12.1; §12.2; §13 component table |
| Container width 65–75ch | `MASTER_PRD.md` §24 L483 | §12.2 V-1 layout |
| Platform default scope only | `PRD-023` §4, L316; `SID-5.45` | §7 data boundary; §9 cross-tenant |
| PR-2 thresholds only ceiling | `ADR-0154` §2.2 (B2); `PRD-001` §2.3 | §8.1; §4.5 |
| Two-group IA | `PRD-023` §13.2 | §11.2 |
| `CFG-5`/`CFG-6` one parameter each | `ADR-0154` D-7 | §6.2 footnote |
| Token values OPEN | `DESIGN_DEBT.md` `DBT-001` | §14.1, §14.2, §20 |
| Radius tokenised | `DESIGN_DEBT.md` `DBT-005` | §14.3, §20.3 |
| Foundation unapproved | `DESIGN_DEBT.md` `DBT-008` | §20.3 |
| No breakpoints | `DESIGN_DEBT.md` `DBT-002` | §18 |
| Thin UI QA evidence | `DESIGN_QA.md` §2 (`DBT-004`) | §19 |
| No search/filter/sort | `ADR-0154` D-4; `PRD-023` §13.2 | §16 |
| Cross-app dependency declared one-directional | `ADR-0154` §3.2; `DDR-0025` §B.3 | §4.4 |
| Design ≠ authorization | `README` §5.1; `ADR-0154` B3; `DDR-0025` §B.5 | §5.3 |

---
## 23. ⚠️ Open issues / blockers — ⛔ NOT resolved here, routed to owners

⚠️⚠️ **These questions are recorded, ⛔ not answered.** A Design Doc does not decide items in another office's lane.

| ID | Question | Owner | Status in C-5 | Source |
|---|---|---|---|---|
| **QQ-1** | ⛔ Does `PRD-023` L316's scope-1 read surface for platform admins have an operational meaning? | Product Owner | ⛔ **OPEN — recorded, ⛔ not decided** | `ADR-0154` §2.2 (B2) |
| **QQ-2** | ⛔ Does §2B.5 design-readiness require a surface a ranked rule forbids designing? | Design Governance Owner | ⛔ **OPEN** — `DD-0008` precedent noted | `DDR-0025` §B.3 / §4 Q2 |
| **QQ-3** | ⛔ Is there *"a current approved use"* for APP 3 in V1? | Product Owner | ⛔ **OPEN — blocks runtime, ⛔ not design** | `SECP-FR-007`; `DDR-0025` §4 Q5 |
| **QQ-4** | ⛔ Does `SECP-FR-007`'s "approved use" gate apply to a **design-only** act? | ⛔ **Answered — no** | ⛔ Design ≠ authorization | `DDR-0025` §B.5; `ADR-0154` B3 |
| **QQ-5** | ⛔ What is the APP 3 entry point? (no app shell exists) | Architecture Owner | ⛔ **OPEN — ⛔ no navigation invented** | `lib/app/platform_admin/` is reserved and empty |
| **QQ-6** | ⛔ Offline behavior for platform-default reads | Engineering Owner | ⛔ **OPEN — ⛔ no cache behaviour invented** | `DBT-004` evidence thin |
| **QQ-7** | ⛔ `lib/app/platform_admin/README.md` L6 → §3 stale pointer | Technical Owner (+ Design Governance) | ⛔ **OPEN — disclosed, ⛔ not corrected** | `DDR-0025` §B.4 |

> ⛔⛔ **C-4** and **C-5 (runtime authorization)** are ⛔ **NOT closed** — see `DDR-0025` §4 for the routed owners. ⛔ **This document does not and cannot answer them.**

---

## 24. ⛔ Out-of-scope items

| Item | ⛔ Why out of scope |
|---|---|
| ⛔ C-4 — Change history / audit read | ⛔ `ADR-0171` — no V1 read surface for BC-24 |
| ⛔ Write surface (C-1–C-3) | ⛔ `ADR-0154` D-4 — no write authority created |
| ⛔ APP 2 tenant configuration | ⛔ This DD is APP 3 only; APP 2 surfaces are `DD-0007`'s domain |
| ⛔ `CFG-10`, `CFG-12`, `SCFG-2`, `SCFG-4` | ⛔ HELD — `ADR-0154` D-6, `ADR-0155` S-2/S-3, `ADR-0165`/`0166` |
| ⛔ `SCFG-1`, `SCFG-2`, `SCFG-3`, `SCFG-4` gaps | ⛔ `SCFG-2` held (`ADR-0166`) — `SCFG-1`/`3`/`4` are not in this surface's authorization (`ADR-0155` §2.5) |
| ⛔ Search / filter / sort | ⛔ Not authorized for C-5 (`ADR-0154` D-4) |
| ⛔ Export / report | ⛔ `PRD-009` (BC-26) owns exports — ⛔ **not C-5** |
| ⛔ Scope selector | ⛔ Only Platform default authorized (`ADR-0154` D-4) |
| ⛔ Inherited-value display | ⛔ `CNF-FR-076`/`077` not engaged (platform-default only) |
| ⛔ Reset-to-inherited | ⛔ `CNF-FR-078` not engaged (no write) |
| ⛔ Range-before-write display | ⛔ `CNF-FR-080` not engaged (no write) |
| ⛔ Field-level refusal | ⛔ `CNF-FR-079` not engaged (no write) |
| ⛔ Design tokens / radius / WCAG numbers | ⛔ `CNF-XC-016`; `DBT-001`/`DBT-005`/`DBT-008` remain OPEN |
| ⛔ Responsive breakpoints | ⛔ `DBT-002` — ⛔ **0 breakpoints invented** |
| ⛔ Performance budgets | ⛔ `MASTER_PRD` §24 defers to `NFR Budgets (V1)` which ⛔ **does not exist** |
| ⛔ UI/UX Pro Max as authority | ⛔ `CNF-XC-016`; skill is **reference only** at `09170ee` |
| ⛔ Implementation / code | ⛔ `SECP-FR-007`; `ADR-0154` D-7; `lib/app/platform_admin/` ⛔ **reserved, 0 Dart files** |
| ⛔ APP 3 runtime authorization | ⛔ `SECP-FR-007`; `ADR-0154` B1 limb 11; `DDR-0025` §F |
| ⛔ New roles / permissions / action classes | ⛔ `AUTH-7.22` closed at zero; `README` §2B.6 |

---
## 25. ⛔ 13-check App-Boundary QA (README §2B.5)

⚠️⚠️ **Same 13-check instrument as `DD-0003`/`DD-0007`/all prior DDs** — per `README` §2A.1. ⛔ **Not rounded to 13/13**; each check carries its measured verdict.

| # | Check (README §2B.5) | C-5 evidence | Verdict |
|---|---|---|---|
| 1 | Every surface assigned to exactly one app | §12.1: S-1, S-2 → APP 3 ⛔ only | ⭐ **PASS** |
| 2 | Every surface assigned to named roles | §12.1: S-1, S-2 → `PR-1`, `PR-2` ⛔ only | ⭐ **PASS** |
| 3 | No role invented | `PRD-001` §2.3: closed at 2; `AUTH-7.22`: 0 created | ⛔ **PASS** — ⛔ 0 roles minted |
| 4 | Parent inside APP 1, not separate | ⛔ **VACUOUS** — APP 1 = 0 surfaces (§4.2) | ⛔ **PASS** — vacuously |
| 5 | Student data scoped to self | ⛔ **N/A** — no `TR-4`/`TR-5`; `SID-4.49` forbids `TenantContext` | ⛔ **PASS** — vacuously |
| 6 | Cross-role differences respected | ⛔ **VACUOUS** — `PR-1`+`PR-2` have **identical READ** on all 19 | ⛔ **PASS** — ⛔ no role-based hiding (§4.5) |
| 7 | Platform roles separated (`AUTH-2.5`) | §4.5: PR-2 reads thresholds only; platform-level objects only | ⛔ **PASS** |
| 8 | Figma preserves boundaries | ⛔⛔ **BLOCKED** — §25.3 Figma gate NOT OPEN | ⛔ **GAP** — gate closed |
| 9 | No mixed-role shell | §4.4: ⛔ no shared shell · ⛔ no navigation between APP 2 and APP 3 | ⛔ **PASS** |
| 10 | Tenant scope explicit | §11.1: ⛔ Platform default only · ⛔ no tenant scope | ⛔ **PASS** |
| 11 | Cross-app dependency named | §4.4: ⭐ one declared ONE-directional READ-only dep (APP 2 ↔ APP 3) | ⛔ **PASS** |
| 12 | No permission inferred from visibility | §6.1: READ allocated by `ADR-0154` §2.5 + `ADR-0155` §2.5, ⛔ not from row presence | ⛔ **PASS** |
| 13 | Evidence cited per declaration | §22: traceability table, **17** rows · ⛔ **0** uncited claims | ⛔ **PASS** |

| 8 | Figma preserves boundaries | ⛔ **BLOCKED** — §25.3 Figma gate NOT OPEN | ⛔ **GAP** — gate closed |

### 25.1 ⛔ DESIGN_QA checklist (DESIGN_QA.md §1) — applied

| Category | Question | Result |
|---|---|---|
| Source and scope | No frozen PRD/ADR changed | ⛔ **PASS** — 0 bytes changed |
| Source and scope | Every new design claim traced | ⛔ **PASS** — §22 traceability table |
| UX and IA | Entry point / primary action / failure / recovery / return clear | ⚠️ **TBD** — entry point ⛔ OPEN (§23 QQ-5) · return = back button |
| Visual and component | Components use design system | ⛔ **PASS** — ⛔ **0** new components; existing `lib/app/shared/` only |
| Visual and component | Illustration/effects/motion earn cost | ⛔ **PASS** — ⛔ **0** illustrations · ⛔ **0** effects · ⛔ **0** motion |
| Accessibility | Focus / names / labels / contrast / scaling / non-color cues / reduced motion / error recovery | ⚠️ **PARTIAL** — non-color cues ⭐; contrast ⛔ OPEN (`DBT-001`); focus ⛔ OPEN |
| Responsive | Narrow mobile / wider mobile / larger-width | ⚠️ **PARTIAL** — intent only (`DBT-002` OPEN) |
| Responsive | Long content / slow network / offline / low-end | ⚠️ **PARTIAL** — offline ⛔ OPEN; no NFR budgets |
| Handoff | Figma artifact linked | ⛔ **BLOCKED** — §25.3 gate NOT OPEN |
| Security/privacy | No security behavior depicted that no source defines | ⛔ **PASS** — read-only; ⛔ 0 new behaviors |

---

### 25.2 ⛔ Figma gate — ⛔ NOT OPEN (explicit blockers)

| Blocker | Detail |
|---|---|
| 1 | ⛔ **`DBT-001`** — colour/spacing/typography token values not ratified by Design System Owner |
| 2 | ⛔ **`DBT-005`** — no `LiblRadius` token class (radius, elevation, type un-tokenised) |
| 3 | ⛔ **`DBT-008`** — ⛔ **0** foundation documents `APPROVED`; no `G0`–`G5` gate passed |
| 4 | ⛔ **`DBT-002`** — ⛔ **0** responsive breakpoints in any source document |
| 5 | ⛔ **`DBT-003`** — ⛔ **0** localization mechanism; ⛔ **0** supported languages |
| 6 | ⛔ **`DBT-004`** — ⛔ **0** UI test assertions for surfaces; ⛔ no implementation |
| 7 | ⛔ **`SECP-FR-007`** — ⛔ **APP 3 runtime authorization NOT granted** — no approved use |
| 8 | ⛔ **`README` §2A.3** — ⛔ No Figma file exists (same repo fact as `DD-0001`…`DD-0008`) |

> ⛔⛔ **Figma gate verdict: ⛔ NOT OPEN — 8 blockers. This document is `PROPOSED` and ⛔ does not open it.**
## 26. ⚠️ Approval / readiness

| Gate | Status | Notes |
|---|---|---|
| Source freeze | NOT a Design Doc decision — PRD-023 is FROZEN Rank 3 |
| Authorization complete for 19 params | Design fact, not approval — ADR-0154/ADR-0155 Accepted |
| §2B.3 declarations | 5/5 declared — §4 |
| App-Boundary QA (13 checks) | 12/13 PASS, 1 GAP (Figma gate) — not rounded |
| DESIGN_QA | Partial — 5 PASS, 4 PARTIAL, 1 BLOCKED |
| Figma gate | NOT OPEN — §25.3 lists 8 blockers |
| APP 3 runtime authorization | NOT granted — SECP-FR-007 |
| Token values DBT-001 | OPEN — Design System Owner |
| Radius DBT-005 | OPEN — Design System Owner |
| Foundation approval DBT-008 | OPEN — Founder/Product Authority |
| Responsive breakpoints DBT-002 | OPEN — Responsive Design Owner |
| C-4 reader allocation | OPEN — Authorization Owner + PRD-016/BC-24 Owner (joint) | DDR-0025 |
| C-5 / §2B.5 gate criterion | OPEN — Design Governance Owner | DDR-0025 |
| APP 3 approved use (SECP-FR-007) | OPEN — Product Owner | DDR-0025 |

> NOT READY WITH EXPLICIT BLOCKERS is the only verdict this document may record. Figma gate NOT OPEN. APP 3 runtime NOT authorized. DBT-001/005/008 all OPEN.

---

## 27. Changelog

| Version | Date | Change | Rationale |
|---|---|---|---|
| v0.1 | 2026-09-27 | Created. 19 params, read-only, C-4 OUT OF SCOPE, APP 3 NOT authorized, DBT-001/005/008 OPEN, Figma gate NOT OPEN | First design act permitted by ADR-0154 B3 |

---
## 28. Document completeness map

| Section | Status |
|---|---|
| Metadata + status header | Complete |
| Purpose / Scope / Non-goals | Complete |
| APP 3 boundary | Complete |
| PR-1 / PR-2 role boundary | Complete |
| C-5 authorization boundary | Complete |
| Exact 19-parameter inventory | Complete |
| 10 CFG parameters | Complete |
| 9 SCFG parameters | Complete |
| Excluded/HELD parameters | Complete |
| Strict read-only boundary | Complete |
| Data/read boundary | Complete |
| Security/privacy boundary | Complete |
| Cross-tenant/platform boundary | Complete |
| User flow | Complete |
| Information architecture | Complete |
| Main viewer screen (V-1) | Complete |
| Parameter detail screen (V-2) | Complete |
| Components | Complete |
| Layout | Partial — dimensions named as intent, values OPEN (DBT-001) |
| Spacing | Partial — token names cited, values OPEN (DBT-001) |
| Typography | Partial — style names cited, values OPEN (DBT-001) |
| Visual hierarchy | Complete |
| Loading state | Complete (skeleton) |
| Error state | Complete (message + retry) |
| Empty state | Complete (does not occur / no-data message) |
| Permission state | Complete (not reachable for non-platform roles) |
| Offline state | Partial — OPEN, no behaviour invented |
| Accessibility | Partial — intent named, targets OPEN (DBT-001/003) |
| Responsive behavior | Partial — intent named, OPEN (DBT-002, 0 breakpoints) |
| Interaction behavior | Complete |
| Search/filter/sort disposition | Partial — OUT OF SCOPE, refused with source |
| Design-system integration | Partial — 0 adopted, all OPEN |
| DBT-001 treatment | OPEN — cited, not resolved |
| DBT-005 treatment | OPEN — cited, not resolved |
| DBT-008 treatment | OPEN — cited, not resolved |
| UI/UX Pro Max usage @ 09170ee | Complete |
| Traceability matrix | Complete |
| Open questions/blockers | Complete |
| Out-of-scope | Complete |
| 13-check QA | 12 PASS / 1 GAP (Figma gate) |
| Approval/readiness | 8 Figma blockers, not ready |
| Changelog | Complete |

> DESIGNED WITH EXPLICIT BLOCKERS. Figma gate NOT OPEN. APP 3 runtime NOT authorized. DBT-001/005/008 all OPEN.
