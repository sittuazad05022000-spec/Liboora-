# Library PRD v1.0 — Validation and Alignment Record

| Field | Value |
|---|---|
| **Reviewed** | [`Library_PRD_v1.md`](./Library_PRD_v1.md) v1.0, §§1–25 · [`14A`](./14A-Library-Discovery-And-Enrollment.md) · [`14B`](./14B-Public-Library-Preview.md) |
| **Date** | 2026-08-03 |
| **Reviewer roles** | Principal Enterprise PM · Enterprise Software Architect · Documentation Architect · Security Architect · SaaS Multi-Tenant Architect · Technical Lead |
| **Verdict** | ✅ **APPROVED — authoritative.** 14 conflicts resolved, 0 blocking, 3 items deferred with reasons |
| **Closes** | `U-4` · `CC-3` residue · `CC-5` · `CC-6` · `CC-7` · `AR-4` deferral · `R-A`…`R-G` |

---

## 1. Method

Every finding below cites a document **on disk in this repository**. Nothing is
asserted from conversation memory. Where the PRD text conflicts with a
higher-precedence document, the precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §4
decides which document is wrong — never which one to quietly ignore.

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD v1.5 | `../MASTER_PRD.md` | 1 |
| 2 | ADRs `ADR-0001`…`ADR-0010` | `../../00-governance/adr/` | 2 |
| 3 | Authentication PRD v2.0 | `../authentication/Authentication_PRD_v2.md` | 3 |
| 4 | Bounded Context Map v1.2 | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 |
| 5 | Module Dependency Matrix + `tool/module_dependencies.yaml` | `../../10-architecture/` | 4 |
| 6 | Architecture Rulings v1.1 `AR-1`…`AR-7` | `../../10-architecture/ARCHITECTURE_RULINGS.md` | 5 |
| 7 | Enterprise Architecture v2.1 | `../../10-architecture/LIBOORA_ENTERPRISE_ARCHITECTURE.md` | 6 |
| 8 | Configuration Guide | `../../20-configuration/CONFIGURATION_GUIDE.md` | 7 |
| 9 | Documentation Baseline | `../../00-governance/DOCUMENTATION_BASELINE.md` | — |

### 1.2 Preservation rule applied

The instruction was: *"Do not rewrite it unless required. Preserve all existing
requirements and modify only where genuine conflicts, ambiguity, duplication, or
missing enterprise requirements exist."*

Accordingly:

- **Every** capability, entity, actor, function, setting, policy, facility, rule
  and acceptance criterion in the source text is present in v1.0.
- **Nothing was deleted.** Where wording conflicted with a higher-ranked
  document, the wording was corrected and the correction is recorded below with
  its authority.
- Additions are of two kinds only: **enforceable form** for a requirement already
  stated (e.g. §13's *"expansion without database redesign"* → `LIB-13.1`
  naming the mechanism that achieves it), and **enterprise requirements the
  source omitted** (event register, exclusion list, ownership boundary).

---

## 2. Conflicts found and resolved

### 2.1 Blocking — would have caused a security or data defect

#### `LC-1` · Two competing public-visibility lists

| | |
|---|---|
| **Found** | §7 publishes 9 fields; §14A.5 publishes 14 — adding Cover Image, Business Address, Map Location, Membership Plans & Pricing, Business Contact Information |
| **Why it matters** | An implementer trusting §7 breaks discovery by omitting plans; one trusting §14A.5 publishes a field §7 never authorised. One of them is wrong and the document does not say which |
| **Resolution** | §14A.5 governs as the reviewed superset. `LIB-7.1` states the list is defined once; `LIB-7.2` makes public visibility **allow-list only** |
| **Removed?** | Nothing. §7's nine fields are a subset of the fourteen |

#### `LC-2` · Business contact number vs the authentication credential

| | |
|---|---|
| **Found** | §6 requires "Mobile Number" as profile data. §14A.5 publishes "Business Contact Information". §14A.10 requires the two be separate — but §6 does not say so |
| **Why it matters** | `MP-GBR-25` makes the mobile number the **sole authentication factor**. If the profile field reads the owner's login number, publishing the public profile publishes half of every owner's credential |
| **Resolution** | `LIB-6.4` — separate fields, separate lifecycles, separate visibility. They may coincide in value; they are never the same field |
| **Severity** | Blocking. This is a credential-disclosure path |

#### `LC-3` · Owner modelled as a single value

| | |
|---|---|
| **Found** | §6 requires an "Owner Name" field; §19 reserves critical operations to "the Owner". Together these imply one owner column |
| **Why it matters** | Three separate collisions. `AP-5` (`AUTH-7.8`) forbids an account approving its own elevation — impossible to honour with exactly one Owner. `LIB-15.9`/`LBR-2` would make a sole Owner unremovable. `AUTH-9.46` gives every account the right to request erasure, which a sole Owner could never exercise |
| **Resolution** | `LIB-15.13` — Owner is a **multi-holder role**, never a single-valued foreign key. §6's "Owner Name" remains as **profile display text** |
| **Removed?** | Nothing. Both §6 and §19 are satisfied |

#### `LC-4` · Public seat information unbounded

| | |
|---|---|
| **Found** | §7 and §14A.5 publish "Seat Capacity (Optional)" without stating granularity |
| **Why it matters** | Read permissively, this authorises a live per-seat occupancy map. In a study hall where regulars hold the same desk daily, that is a public attendance feed for identifiable individuals |
| **Resolution** | `LIB-7.3`, `LIB-14B.11`, `LIB-14B.12` — aggregate capacity plus a coarse indicator. Live occupancy stays **V2** behind a privacy review (`LIB-24.2`) |
| **Removed?** | Nothing. The stated field is published |

### 2.2 Boundary violations — would have produced forbidden code

#### `LC-5` · Notifications listed as a direct integration — closes `CC-5`

| | |
|---|---|
| **Found** | §21 and §14A.12 list "Notifications" as an integration; §3 and §14A.3 place it **out of scope**; `tool/module_dependencies.yaml` bans `platform/communication/**` from `domain/library` (`X-04`) |
| **Resolution** | `LIB-21.2` — the library **emits events**, `BC-22` subscribes and delivers. Capability preserved, mechanism named correctly |
| **Status** | ✅ `CC-5` **closed** |

#### `LC-6` · Maps named as a vendor integration — closes `CC-6`

| | |
|---|---|
| **Found** | §6 "Google Maps Location"; §21/§14A.12 "Maps"; `banned_imports` blocks `platform/integration/**` (`X-03`) |
| **Resolution** | `LIB-6.5` — geocoded coordinates, reached through a port; the vendor contract belongs to `BC-31` |
| **Status** | ✅ `CC-6` **closed** |

#### `LC-7` · `Staff` as an independent entity

| | |
|---|---|
| **Found** | §5 lists `Staff` among ten core entities with no owner stated |
| **Why it matters** | The natural implementation is a `Staff` table with a phone number — a **second credential store**, violating `BC-18`'s ownership of *"credentials, sessions, devices, OTP"* |
| **Resolution** | `LIB-5.1`, `LIB-15.1` — a staff member is an `Account` holding a library role. This module stores the **assignment**, never a credential |

#### `LC-8` · Role vocabulary divergence

| | |
|---|---|
| **Found** | §4 names "Platform Owner", "Library Owner", "Library Manager", "Reception Staff". `AUTH-7.21` states the closed set is `TR-1`…`TR-5` + Platform Administrator, and that **no other role exists** |
| **Resolution** | `LIB-4.1` adopts the authoritative names, mapped 1:1 in §4's table. **No actor added or removed** |
| **Note** | `LIB-4.2` additionally records that Platform Administrator confers **no** tenant-data permission without audited elevation (`AUTH-7.13`) |

#### `LC-9` · "Premium Zone" invites pricing into the library domain

| | |
|---|---|
| **Found** | §11 names a Premium Zone; §16 stores Currency. Nothing forbids attaching a price to a zone |
| **Resolution** | `LIB-11.3`, `LIB-11.4` — zone attributes are descriptive; price lives on the `BC-02` plan. `LXC-7` states the prohibition |

### 2.3 Roadmap and internal contradictions

#### `LC-10` · Multi-Branch tiered inconsistently

| | |
|---|---|
| **Found** | §9 "Architecture Ready"; §24 "Future Scope (V2+)"; Master PRD §32 places Multi-Branch in **V3** |
| **Resolution** | `LIB-9.4`, §24 table — **V3**. `V2+` is not false but is unusably vague: a team reading it plans multi-branch for the next release and discovers the enterprise tier is unfunded |
| **Preserved** | `LIB-2.2`, `LIB-9.2` keep `branchId` in the V1 schema (Context Map `Q-02`) |

#### `LC-11` · Public Library Discovery listed as both V1 and Future

| | |
|---|---|
| **Found** | §24 lists "Public Library Discovery" under Future Scope (V2+); §14A specifies it as a V1 capability with its own acceptance criteria |
| **Resolution** | §24 table marks it **V1 — already delivered by §14A**. §14A governs |

#### `LC-12` · Floor Capacity vs seat inventory

| | |
|---|---|
| **Found** | §10 "Floor Capacity" is undefined — a design figure, or the seat count owned by `BC-04`? |
| **Why it matters** | Undecided, the number gets written in two places and drifts |
| **Resolution** | `LIB-10.4` planning figure owned here; `LIB-10.5` `BC-04` authoritative for operations, discrepancy surfaced not silently reconciled |

#### `LC-13` · "Silent Zone" is both a facility and a zone kind

| | |
|---|---|
| **Found** | §13 lists Silent Zone as a facility; §11 lists it as a zone kind. Neither says whether they are the same fact |
| **Resolution** | `LIB-13.6` — the facility advertises; the zone is addressable. Neither derives from the other |

#### `LC-14` · Facility expansion requirement unachievable as usually built

| | |
|---|---|
| **Found** | §13 requires expansion *"without database redesign"* — unachievable with the boolean-per-facility schema most teams reach for first |
| **Resolution** | `LIB-13.1`, `LIB-13.2` — reference list plus association. The **requirement is the product owner's**; only the mechanism is added |

---

## 3. Enterprise requirements the source omitted

Added because their absence would have forced an implementer to invent them.

| Added | Why |
|---|---|
| `LXC-1`…`LXC-10` explicit exclusions | "Out of scope" reads as "not yet built here". Prohibitions are enforceable; two are compile-time checkable via `IMPL-014` |
| `LEV-1`…`LEV-22` event register | §21 requires integration but named no event. `X-04` permits **only** event emission to `BC-22`, so the events are the integration |
| `LCFG-1`…`LCFG-10` configurable register | §16 lists settings with no defaults, ranges or owners. Every one would have been invented in code |
| §26 ownership boundary table | `LBR-8` forbids duplication but the source never says who owns what. This is the table an implementer needs on day one |
| `LAC-10`…`LAC-12` | The original nine criteria did not prove `LBR-5` (public exposure), `LBR-7` (suspension) or `LIB-21.5` (no credentials in events) |
| §25.1 falsifiable forms | *"Library profile can be managed"* cannot fail. Each criterion is given a pass **and** fail condition. **No criterion was weakened** |
| `LIB-8.9`…`LIB-8.11` erasure interaction | §8 says deletion is out of scope; `AUTH-9.46`…`AUTH-9.60` bind the platform to account erasure. Without these, two documents pull opposite ways the first time a staff member asks to be deleted — and erasure could orphan a library with no owner |
| `LIB-12.8`, `LIB-17.3` forward-only rules | Without them, correcting last month's opening time silently reclassifies a month of attendance as late |
| `LIB-16.9` propagation-window fence | Introducing `LCFG-6` invites the reading that other state is eventually consistent, contradicting `MP-GBR-26`. The window applies to a **search index** and nothing else |
| `LIB-18.2` identifier opacity | `LIB-18.1` alone permits a sequential integer, disclosing customer count and making tenants enumerable |
| `LIB-19.10` projection requirement | The difference between a filtered query and a separate read model is the difference between one forgotten `SELECT *` and a structural impossibility |

---

## 4. §14A boundary re-validation

Objective 4 required confirming §14A's boundaries against six modules. Verified
against the Bounded Context Map and `tool/module_dependencies.yaml`:

| Boundary | §14A position | Verdict |
|---|---|---|
| **Authentication** `BC-18` | §14A.8 — never performs authentication, registration, OTP or session management | ✅ Correct. Reinforced by `LXC-1`, `LIB-14B.30` |
| **Authorization** `BC-18` | §15 "Role permissions are governed by the Authorization PRD" | ✅ Correct. `LIB-15.3` makes it a request; `LIB-14B.29` requires evaluation **in addition to** authentication |
| **Student Identity** `BC-10`/`BC-01` | `LIB-DISC-010` — owned by Student Identity | ✅ Correct. `LXC-4` |
| **Membership** `BC-02` | `LIB-DISC-009` — creation owned by Membership | ✅ Correct. `LXC-3`; `LIB-14B.15` makes plan display read-only |
| **Attendance** `BC-03` | Out of scope §14A.3 | ✅ Correct. `LXC-5`; `LIB-14B.14` additionally forbids deriving public data from attendance |
| **Seat Management** `BC-04` | Out of scope §14A.3; capacity publishable | ✅ Correct **with the `LC-4` constraint applied** — aggregate only |

`LIB-DISC-001`…`LIB-DISC-013` are **carried forward unchanged**. §14B adds no
public field and relaxes no restriction (`LIB-14B.1`).

### 4.1 One boundary strengthened

§14A.9 lists protected operations in prose. `LIB-14B.27` converts this to a
**closed** register `PO-1`…`PO-12` and adds `PO-10`…`PO-12` — any write to tenant
data, any read of personally identifying data, any administrative function — with
`LIB-14B.28` making the residual case deny-by-default. Prose lists acquire
exceptions; closed registers do not.

---

## 5. Issues closed

| Issue | Was | Now | Justification |
|---|---|---|---|
| **`U-4`** | §§1–25 never supplied — *"the largest gap"*, sole blocker to freeze | ✅ **CLOSED** | Received in full and captured as `Library_PRD_v1.md` v1.0 |
| **`CC-3`** residue | §14A.5 / §14A.7 / `LIB-DISC-007` wording outstanding | ✅ **CLOSED** | §26 ownership table + `LIB-1.2` state reference-not-duplicate in enforceable form |
| **`CC-5`** | Notifications contradiction | ✅ **CLOSED** | `LIB-21.2` — event emission, `BC-22` delivers |
| **`CC-6`** | Maps vendor knowledge | ✅ **CLOSED** | `LIB-6.5`, `LIB-21.3` — port; vendor owned by `BC-31` |
| **`CC-7`** | Invitation ownership settled, security deferred | ✅ **CLOSED IN FULL** | `INVITATION_SECURITY_SPECIFICATION.md` specifies all six `AR-4` items; `ADR-0009` records the model |
| **`AR-4` deferral** | Six items *"DO NOT INVENT"* | ✅ **CLOSED** | Deferral lifted on evidence: §§1–25 confirm the feature exists. §13 traceability table maps each item |
| **`R-A`…`R-G`** | Documentation wording recommendations | ✅ **CLOSED** | Superseded — v1.0 is a complete document with the wording applied |
| **`U-1`** Foundation ambiguity | Unverified | ✅ **CLOSED** | Master PRD v1.5 is the foundation; precedence fixed by `DOCUMENTATION_BASELINE.md` §4 |
| **`U-5`, `U-6`** | Unverified | ✅ **CLOSED** | Resolved by the §26 ownership table and the §21.1 event register |

### 5.1 Not closed — and why

| Item | Status | Reason |
|---|---|---|
| **`CC-4`** | ◐ Architecture confirmed; **implementation gap OPEN** | `AR-2`/`ADR-0005` settled the design. The code does not yet implement it. Documentation cannot close a code gap — tracked as `IMPL-030`/`IMPL-031` |
| **`U-3`** Development Standards | ⬜ **OPEN** | Only stock `flutter_lints` exists. Governance task `R-4`, P3 |
| **`R-5`** `lib/contracts` defect | ⬜ **OPEN** | Module Dependency Matrix declares a path that does not exist. Documentation defect, P2 |
| **`D-10`** demo surfaces | ⬜ **OPEN — implementation** | Per objective 9, explicitly **not** closed. `TASK-D10`, P0 |
| **`IMPL-020`** SMS provider | ⬜ **OPEN — implementation** | Per objective 9, explicitly **not** closed. Critical path |

> **Objective 9 was applied literally.** Every item that is an implementation task
> rather than a documentation defect remains open with a task, acceptance criteria
> and a backlog entry. Nothing was closed by writing about it.

---

## 6. Multi-tenant and security validation

| Control | Requirement | Verified |
|---|---|---|
| Tenant key mandatory | `MP-GBR-08`, `SE-1`, `X-13` | ✅ `LIB-18.8` refuses a tenant-less query; `LIB-9.3` states `branchId` is not a substitute |
| Public index ≠ tenant index | `AR-3` | ✅ `LIB-14B.51` restates the rules unmodified; projection is Platform Public Discovery Index class |
| Revocation immediate and global | `MP-GBR-26` | ✅ `LIB-8.3`, `LIB-15.5`, `INV-SEC-024`; `LIB-16.9` fences the only propagation window to the search index |
| No demo or guest accounts | `MP-CON-11` | ✅ No demo library, test tenant or bypass path in any of the three documents. No test invitation type |
| OTP sole factor preserved | `MP-GBR-25` | ✅ `INV-SEC-002` — an invitation never authenticates; `LIB-14B.5` — no number collected to browse |
| Deny by default | `AP-3`, `AUTH-7.6` | ✅ `LIB-14.2` visibility defaults Private; `LCFG-5` directory off; `LIB-14B.28` `PO-9` deny-by-default; `LIB-7.2` allow-list |
| Separation of duties | `AP-5`, `AUTH-7.8` | ✅ `LIB-15.8`; enabled by `LIB-15.13` multi-holder Owner |
| Audit append-only, survives erasure | `AUTH-9.57` | ✅ `LIB-19.5`, `LIB-19.6`, `INV-SEC-051`, `INV-SEC-052` |
| Anti-enumeration | `AR-7` reasoning | ✅ `LIB-14B.24` libraries; `INV-SEC-043` invitations — both include timing class |
| No vendor in domain | `X-03` | ✅ `LIB-6.5`, `LIB-21.3`, `LXC-9` |
| No direct communication | `X-04` | ✅ `LIB-21.2`, `INV-SEC-064`, `LXC-8` |

---

## 7. Configuration additions

23 new parameters, each with a default, a range and a stated anchor. All are
startup-validated under `IMPL-015`.

| Group | IDs | Count |
|---|---|---|
| Library settings | `LCFG-1`…`LCFG-10` | 10 |
| Public preview | `LCFG-11`…`LCFG-13` | 3 |
| Invitation security | `ICFG-1`…`ICFG-10` | 10 |

New invariants `INV-10`…`INV-16` extend `INV-1`…`INV-9`. The load-bearing ones:

| ID | Invariant | Consequence if violated |
|---|---|---|
| `INV-10` | `LCFG-11` ≤ `CFG-6` | Intent outlives the session that would resume it |
| `INV-11` | `LCFG-11` > `CFG-2` × `CFG-1` | Legitimate user times out mid-OTP |
| `INV-14` | `ICFG-3` ≤ `ICFG-2` | The weakest artefact (`IT-3`) lives longest |
| `INV-15` | `ICFG-4` > `CFG-2` × `CFG-1` | Invitee times out mid-authentication |

---

## 8. Documentation redesign risk

Objective 10 asked whether future redesign is required. Assessed against the
things that historically force one:

| Risk | Mitigated by | Residual |
|---|---|---|
| Multi-branch retrofit | `branchId` in V1 schema (`LIB-2.2`, `LIB-9.2`) | **None** — schema is branch-ready |
| Facility expansion | Reference list, not columns (`LIB-13.1`) | **None** |
| New public field leaking | Allow-list + reviewed change (`LIB-7.2`, `LIB-7.4`) | **None** |
| New role introduced | Closed set `TR-1`…`TR-5` (`AUTH-7.21`, `LIB-4.1`) | **None** — needs an Auth PRD revision |
| New invitation type | `INV-SEC-003` closed list | **Low** — requires a spec revision, which is the intent |
| Live occupancy in V2 | Deferred behind privacy review (`LIB-24.2`, `LIB-14B.13`) | **Low** — decision deliberately unmade |
| Reviews & Ratings (V2) | Not in the 31 contexts | **Medium** — will need a new context and an ADR when tiered |
| Ownership boundary change | Requires an ADR (`LIB-26.2`) | **None** — cannot drift via PRD edit |

**No redesign is required for V1 or V2.** The one genuine V2 gap is Reviews &
Ratings, which has no bounded context — correctly, since it is not V1 scope.

---

## 9. Verdict

✅ **APPROVED — authoritative.**

| Criterion | Result |
|---|---|
| Conflicts with higher-precedence documents | **0 remaining** — 14 found, 14 resolved |
| Requirements removed from the source | **0** |
| Module boundaries correct | ✅ Six re-validated; one strengthened to a closed register |
| Multi-tenant isolation | ✅ Preserved unmodified |
| Security posture | ✅ Deny-by-default throughout; two anti-enumeration surfaces |
| Verifiable | ✅ 53 acceptance criteria across the three documents |
| Freeze-ready | ✅ `U-4` closed; nothing blocks |

**This PRD may be frozen and handed to developers.** Implementation tasks are in
[`../../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md`](../../40-implementation/LIBRARY_IMPLEMENTATION_TASKS.md).

---

## 10. Change history

| Date | Change |
|---|---|
| 2026-08-03 | Created. Validated `Library_PRD_v1.md` v1.0, §14A and §14B against nine authoritative sources. 14 conflicts resolved, 9 issues closed, 5 correctly held open as implementation tasks. `U-4` closed — §§1–25 received. `AR-4` deferral lifted. |
