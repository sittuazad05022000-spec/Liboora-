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
| 2 | **No existing `DD-0009` elsewhere** | `find docs -iname 'DD-0009*'` → **0**; `grep -rn 'DD-0009' docs/` → **0** in tracked docs | ⭐ **PASS** |
| 3 | **Title / path are convention-backed** | `README` §3 pattern `DD-NNNN-short-kebab-title.md`; `README` §2.3 naming rule; existing precedent `DD-0007-configuration-surface-design.md` | ⭐ **PASS** |
| 4 | **`BC-25` is owned by `PRD-023`** | `PRD_OWNERSHIP_MODEL.md` L205 · `ADR-0017` §3 | ⭐ **PASS** |
| 5 | **`PRD-023` is sufficiently frozen** | `Status` = **`FROZEN`** (`ADR-0053`, `BASELINE-2026-08-20-A`); Stage 7 PASSED; Rank 3 | ⭐ **PASS** |
| 6 | **README §2A/§2B permits creation** | §2A.3 discriminator satisfied by `PRD-023` §12 · §2B.3 declarations present and sourced | ⭐ **PASS** |
| 7 | **Authorization is complete for the designed set** | `ADR-0154` — 10 `CFG-*`; `ADR-0155` — 9 `SCFG-*`; **both `Accepted`** | ⭐ **PASS** |
| 8 | **`C-4` is OUT OF SCOPE — no V1 audit read surface** | ⛔ `ADR-0171` — **NO V1 read surface** for BC-24 configuration audit entries | ⛔⛔ **C-4 NOT DESIGNED** |

⭐⭐ **Path:** `docs/35-design/configuration/DD-0009-app-3-read-only-platform-configuration-viewer.md`
⭐ `configuration/` is the **EIGHTH** context directory (after membership, student-management, attendance, fees-finance, seat-management, analytics, and DD-0007), created at the moment `DD-0007` was written, per `README` §2. ⛔ **No new directory is created by this document** — it shares the existing `configuration/` directory.

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

⭐⭐ **`ADR-0154` §4.3 supersedes `ADR-0152` IN PART and IN EFFECT ONLY**, in exactly two places — §7's word *"surface"* and §8.5's one table row — on the `ADR-0130` instrument. ⛔⛔ **`ADR-0152` is byte-unchanged** (md5 `7fc60c7ff06a8fb6e47c17d88dec9071`) ⛔ **and remains `Accepted`**.

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

| Parameter | Reason held | Owner |
|---|---|---|
| ⛔ **`CFG-10`** Soft-deleted account retention | ⚠️ **DPDP erasure obligation** — Guide §2: *"defensible as erasure under DPDP"** | **Legal + Security** |
| ⛔ **`CFG-12`** Platform Support elevated-access duration | ⛔⛔ **Authorization-semantic** — bounds **`PR-2`'s own elevation ceiling** (`AUTH-7.19`, `XC-2.5`); self-referential ⛔ **HELD by DETERMINATION** (`ADR-0165`) | ⭐⭐ **Authorization Owner** |
| ⛔ **`SCFG-2`** Reserved-username list | ⛔⛔ **Review authority not identifiable** from any source ⛔ **HELD by DETERMINATION** (`ADR-0166` outcome c) | ⭐⭐ **Authorization Owner** |
| ⛔ **`SCFG-4`** Username-history retention | ⚠️ **DPDP-adjacent retention** — same question as `CFG-10` | **Privacy Owner** |

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
|---|---|---|---|---|:--:|::/:|:--:|---|
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
