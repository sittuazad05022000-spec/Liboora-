# `PRD-006` Attendance Management v1.2 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3, lines **89–107**) |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) — `PRD-006`, `BC-03` Attendance, **v1.2 `DRAFT`** |
| **Gate satisfied by** | This document — *"a written alignment record naming every conflict and its disposition"* (`PRD_LIFECYCLE.md` L103) |
| **Worked examples followed** | [`LIBRARY_PRD_ALIGNMENT.md`](../library/LIBRARY_PRD_ALIGNMENT.md) · [`STUDENT_IDENTITY_ALIGNMENT.md`](../student-identity/STUDENT_IDENTITY_ALIGNMENT.md) · [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md) |
| **Prior records consumed** | [`PRD-006_VERIFICATION_REPORT.md`](PRD-006_VERIFICATION_REPORT.md) v1.2 — CONDITIONAL PASS · [`PRD-006_NUMBERING_RECONCILIATION.md`](PRD-006_NUMBERING_RECONCILIATION.md) v1.0 |
| **Reviewed at** | `17e7205` |
| **PRD hash at review** | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` — verified identical before and after |
| **Date** | 2026-08-04 |
| **Status** | **Unranked.** A review record is a validation artefact, not a specification. It claims no authority and confers no status |
| **Mandate** | **Stage 3 only.** No PRD modified, no ADR raised, no ranked document touched, no registry or baseline update, no freeze. Stages 4–7 not started |
| **Verdict** | ⚠️ **CONDITIONALLY ALIGNED — 21 of 22 checks PASS, 1 GAP-BEARING (Check 12).** 0 architectural conflicts against Ranks 1–5 · 1 internal documentation defect (§10.1, `F-1`) · 20 open gaps, 2 of which block a *mode*, none of which block Stage 3 · 6 candidate findings rejected with reasons (§11) |

---

## 1. Method

Every finding below cites a document **on disk in this repository**, by path and line. Nothing is asserted from
conversation memory, and no claim the PRD makes about a ranked document is taken on trust — each was re-read at
its source.

Where the PRD conflicts with a higher-precedence document, the precedence order in
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) decides which document is *wrong* —
never which one to quietly ignore. **A conflict is raised, never resolved here.**

Per the reviewer's mandate: where something is architecturally unresolved, it is recorded as an **existing**
`ATT-GAP-*` or raised as a **candidate** gap for the PRD author — **no solution is invented**, and no new
identifier is written into the PRD by this review.

### 1.1 Sources actually read

Line numbers are those consulted. A source is listed only if it was opened.

| # | Source | Path | Rank | Lines read |
|---|---|---|---|---|
| 1 | **PRD Lifecycle** — Stage 3 definition and gate | `../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | — | **40–54**, **89–107** |
| 2 | Documentation Baseline — precedence ladder | `../../00-governance/DOCUMENTATION_BASELINE.md` | — | 200–225, 284–300 |
| 3 | Master PRD v1.7 — `MP-GBR-*`, `MP-RSK-*` | `../MASTER_PRD.md` | **1** | grep-verified, 10 identifiers |
| 4 | ADRs `0001`, `0011`, `0012`, `0016`, `0017` | `../../00-governance/adr/` | **2** | cited-identifier verification |
| 5 | Authentication PRD v2.0 | `../authentication/Authentication_PRD_v2.md` | **3** | 3 identifiers verified |
| 6 | Library PRD v1.1 | `../library/Library_PRD_v1.md` | **3** | 8 identifiers verified |
| 7 | Membership Management PRD v1.4 — **FROZEN** | `../membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **3** | 4 identifiers verified |
| 8 | **Seat Management PRD v1.0 — FROZEN** | `../seat-management/PRD-SEAT-MANAGEMENT.md` | **3** | **227**, **1347**, 2493; 7 identifiers |
| 9 | **Bounded Context Map v1.5** — §3, §4, §7, §8, §9 | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | **90–145**, **155–192**, **290–348**, **364–388**, **397–440** |
| 10 | **Module Dependency Matrix v1.3** — `L1`–`L5`, `X-13` | `../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md` | **4** | **49–54**, 72, 85–94, **362**, 573–579 |
| 11 | Architecture Rulings v1.2 | `../../10-architecture/ARCHITECTURE_RULINGS.md` | **5** | `AR-*` citation check |
| 12 | PRD-007 Stage 3 record — **precedent for this document** | `../seat-management/PRD-007_ARCHITECTURE_ALIGNMENT.md` | — | 1–60, structure |

**Ranks 6 and 7 are not Stage 3 authorities.** The lifecycle scopes this stage to *"Ranks 1–5"* (L91). Enterprise
Architecture v2.1 is **descriptive only** and is cited below only where it corroborates an absence.

### 1.2 Classification scheme

| Class | Meaning |
|---|---|
| **PASS** | Verified compliant against the named authority |
| **GAP** | A genuine absent architectural decision. Recorded against an **existing** `ATT-GAP-*`; never solved here |
| **CONFLICT** | Two documents assert incompatible facts. Raised, never resolved |
| **DEFECT** | An internal inconsistency *within* the PRD. Reported for the author; **not corrected by this review** |
| **REJECTED** | A candidate finding examined and rejected, with its reason recorded |

Findings are **not** raised for stylistic variation, differing detail levels, or one document being silent where
another speaks.

---

## 2. Check results — the 22 required checks

| # | Check | Result | Authority | §  |
|---|---|---|---|---|
| 1 | Attendance BC ownership + Single Owner Rule | ✅ **PASS** | BC Map §3, §8 | §3 |
| 2 | Dependency DAG, downward direction | ✅ **PASS** | Matrix `L1`, `L2` | §4 |
| 3 | Every integration edge exists in BC Map §7 | ✅ **PASS** | BC Map §7 L292 | §5 |
| 4 | No direct cross-module database access | ✅ **PASS** | `ATT-XC-007`, `L3` | §6 |
| 5 | Identity Triad preserved | ✅ **PASS** | BC Map §4, `ID-2`, `ID-4` | §7 |
| 6 | `BC-18` authentication boundary | ✅ **PASS** | `ID-1` | §8 |
| 7 | Authorisation stays with existing architecture | ✅ **PASS** | `X-13`, BC Map L227 | §8.3 |
| 8 | Tenant isolation + `StudentRecordId` scoping | ✅ **PASS** | `MP-GBR-08`, `X-13`, `ID-2` | §9 |
| 9 | Existing configuration ownership | ✅ **PASS** | `ADR-0017`, `E-19` | §10 |
| 10 | Existing audit ownership | ✅ **PASS** | `E-20`, `X-10` | §10 |
| 11 | Existing device/scanner boundary | ⚠️ **PASS w/ GAP** | BC Map L103, L380 | §10 · `ATT-GAP-009` |
| 12 | Existing event/integration boundaries | ⚠️ **GAP-BEARING** | BC Map §9 vs §7 | §5.3 · `ATT-GAP-003`/`004` |
| 13 | Notification + analytics boundaries | ⚠️ **PASS w/ GAP** | `E-23`; `BC-26` unedged | §10 · `ATT-GAP-003` |
| 14 | Existing offline architecture | ✅ **PASS** | `E-24` | §10 |
| 15 | `PRD-007` Seat Management boundary | ✅ **PASS** | BC Map `E-08` | §12 |
| 16 | Six V1 modes remain independent | ✅ **PASS** | `ATT-BR-004`, `ATT-XC-011` | §13 |
| 17 | RFID remains FUTURE only | ✅ **PASS** | `ATT-XC-010`, `NG-9` | §13.2 |
| 18 | QR is not authentication | ✅ **PASS** | `ID-1`, `SEAT-BR-030` | §8.2 |
| 19 | Manual individual attendance first-class | ✅ **PASS** | `ATT-BR-023`, `G-6` | §13.3 |
| 20 | OCR/Vision + Face blocked where unauthorised | ✅ **PASS** | `F-1`/`F-3`/`F-4`, `E-22` | §14 |
| 21 | No invented API/database/schema | ✅ **PASS** | measured — 0 artefacts | §15 |
| 22 | `ATT-*` references — dangling/invalid | ⚠️ **PASS w/ 1 DEFECT** | mechanical scan | §10.1, §16 |

**Score: 21 PASS · 1 GAP-BEARING · 0 CONFLICTS against Ranks 1–5 · 1 internal DEFECT.**

---

## 3. Check 1 — Context ownership and the Single Owner Rule

**PASS.**

BC Map line **98** registers `BC-03` Attendance as `[CORE]`, Library Management, V1: *"Owns the verified record of
physical presence: check-in, check-out, verification method, fraud controls, corrections."* The PRD's header claims
exactly this scope and no more.

**Aggregate.** BC Map line **372** assigns `BC-03` the aggregate **`AttendanceDay`** — *"one student-day, not one
punch"* — with entities `Punch`, `VerificationEvidence(GPS/WiFi/QR)`, `CorrectionRecord`. PRD line **8** claims
`AttendanceDay`, and line **175** states the sizing was *"inherited not invented"*, citing BC Map §8.1. `ATT-FR-001`
(line 193) claims sole ownership. **The claim matches the register exactly — no aggregate was renamed, split or
added.**

**Exclusivity.** An exhaustive search for another PRD claiming `BC-03` returns only: this module's three files, and
Rank 3 documents *referring* to `BC-03` as a neighbour (`Library_PRD_v1.md`, `PRD-MEMBERSHIP-MANAGEMENT.md`,
`PRD-SEAT-MANAGEMENT.md`, `Student_Management_PRD_v1.md`). **No second owner exists.**

**The staff-attendance boundary is respected.** BC Map line **102** gives `BC-07` Staff & Shift *"**staff**
attendance (distinct from BC-03)"*, and line **201** names the collision pair `StudentAttendance` vs
`StaffAttendance` — *"Never a shared table."* `ATT-XC-001` forbids recording staff attendance *"in any form"*,
owner `BC-07` (V2). **The most likely ownership error in this module is explicitly excluded.**

---

## 4. Check 2 — Dependency DAG and downward direction

**PASS.**

Matrix line **49**, `L2`: *"A module may depend only on modules of **strictly lower rank**… Same-rank dependencies
are forbidden except within a declared cluster."*

PRD line **397** records the cluster rule — *"Core Library cluster may use only `E-01`…`E-10`"* — and states this
module uses `E-03`, `E-04`, `E-08`, all inside the allow-list. **Verified:** those three are the module's only
Core↔Core edges, and all three are within `E-01`…`E-10` (BC Map §7.1).

Every other consumed edge (`E-17`, `E-18`, `E-19`, `E-24`) is **Domain → Capability**, BC Map §7.3 — *"downward,
ports only"* — which is `L2`-compliant by construction. Every published edge (`E-08`, `E-20`, `E-23`) is an event,
not an import.

**The forbidden upward direction is honoured.** `ATT-XC-005` and `ATT-XC-006` refuse `BC-27`, `BC-23`, `BC-31` and
`BC-11`…`BC-17`. The PRD's own §32.1 records that its first draft *requested* a `BC-03` → `BC-27` edge and that the
request was **refuted** by BC Map §7.4 `F-1`/`F-3`/`F-4` — a capability is an untrusted caller *into* the domain,
never the reverse. **The draft withdrew its own request on reading the law.** That is the behaviour `L2` exists to
produce.

---

## 5. Check 3 — Every integration edge exists in BC Map §7

**PASS on every claimed edge.** BC Map line **292** is absolute: *"If an edge is not in this table, it **does not
exist** and adding it requires an ADR."*

### 5.1 Mechanical comparison

The PRD cites the edge tokens `E-01`, `E-03`, `E-04`, `E-08`, `E-10`, `E-11`, `E-14`, `E-17`…`E-24`. The BC Map
defines `E-01`…`E-26`. **Every token the PRD cites is defined. Zero invented edges.**

> One scan artefact, resolved: a naïve `E-[0-9]+` match yields a phantom `E-2026` from the string
> `BASELINE-2026-08-04-E` at PRD lines 13 and 339. **Not an edge reference.** Rejected as a finding (§11, `R-1`).

### 5.2 The claimed edge set is a subset of `BC-03`'s actual edges

| Edge | Direction per BC Map | Line | PRD port | Match |
|---|---|---|---|---|
| `E-03` | `BC-02` → `BC-03`, read projection | **300** | `ATT-PO-001` | ✅ Contract quoted verbatim, including *"records and flags"*, never blocks |
| `E-04` | `BC-06` → `BC-03`, sync port | **301** | `ATT-PO-002` | ✅ `AttendanceRules{...}` field-for-field; *"conform, do not translate"* preserved |
| `E-17` | All write paths → `BC-21` | **330** | `ATT-PO-003` | ✅ *"before the aggregate mutates"* preserved |
| `E-18` | All contexts → `BC-19` | **331** | `ATT-PO-004` | ✅ Ambient, *"never a domain method parameter"* |
| `E-19` | All contexts → `BC-25` | **332** | `ATT-PO-005` | ✅ Typed accessors, no raw strings |
| `E-24` | `BC-03` → `BC-30` | **333** | `ATT-PO-006` | ✅ *"Attendance defines the policy; Sync executes it"* |
| `E-08` | `BC-03` → `BC-04`, event | **305** | `ATT-PO-008` | ✅ **"Seating is the occupancy owner; Attendance is the trigger"** quoted |
| `E-20` | All contexts → `BC-24` | **333** | `ATT-PO-009` | ✅ Fire-and-forget, outbox; *"never synchronously"* |
| `E-23` | All contexts → `BC-22` | **335** | `ATT-PO-010` | ✅ Facts only, never *"send an SMS"* |

**Nine edges claimed, nine verified, contracts quoted rather than paraphrased.** `E-01`, `E-10`, `E-11`, `E-14`,
`E-21`, `E-22` appear only in *exclusion* or *refutation* passages — they are cited to prove `BC-03` is **not** on
them. That is the correct use of a foreign edge.

### 5.3 The one structural gap — Check 12

**GAP — `ATT-GAP-003` and `ATT-GAP-004`. Not resolvable at Stage 3, and correctly not resolved.**

BC Map §9 names event consumers that BC Map §7 provides no edge for:

| Event | §9 consumers (L414–417) | Edge in §7? |
|---|---|---|
| `attendance.StudentCheckedIn` | `BC-04`, `BC-26`, `BC-22` | `BC-04` = `E-08` ✅ · `BC-22` = `E-23` ✅ · **`BC-26` — none** |
| `attendance.StudentCheckedOut` | `BC-04`, `BC-26` | **`BC-26` — none** |
| `attendance.AttendanceCorrected` | `BC-24`, `BC-26` | `BC-24` = `E-20` ✅ · **`BC-26` — none** |
| `attendance.FraudSignalDetected` | `BC-24`, `BC-13`, `BC-22` | **`BC-13` — none** |

**This is a defect in the BC Map, not in the PRD.** Two Rank 4 sections of one document disagree. The PRD's response
(`ATT-FR-137`, line 1400) is exactly right: publish the four events as facts to the backbone, **MUST NOT** assert a
direct edge to `BC-26` or `BC-13`, and **MUST NOT** be built to depend on either consuming them.

`ATT-GAP-003` is explicitly identified as an instance of the **systemic** `SM-GAP-11`/`MM-GAP-010` defect affecting
ten producing contexts, which `ADR-0018` §3.2 says *"requires the architecture owner and a separate ADR."* **Frozen
`PRD-004` and `PRD-005` both declined to resolve it.** This PRD follows the frozen precedent exactly.

`ATT-GAP-004` is **worse and the PRD says so.** BC Map §6 rule 2: `BC-13` *"acts **on** other contexts, not beside
them… T&S never reaches into their models."* `E-14`'s targets are `BC-11`, `BC-12`, `BC-14`, `BC-15` — **`BC-03` is
not among them.** So `BC-03` is not even a self-restriction subscriber, and fraud escalation has **no authorised
path in either direction**. Correctly escalated, correctly unresolved.

**Disposition: GAP, owner = architecture owner, ADR required, does not block Stage 3.** Inventing either edge here
would be precisely the violation of BC Map L292 that this check exists to catch.

### 5.4 Event surface matches §9 exactly

Four events declared (`ATT-EVT-001`…`004`, PRD L1380–1383). Names, consumer lists and purposes are **character-for-
character** BC Map L414–417. **No fifth event invented; no consumer list altered.**

---

## 6. Check 4 — No direct cross-module database access

**PASS.**

`ATT-XC-007` (line **405**): *"This module **MUST NOT** read from, write to, or query the database, table or store
of any other…"* — owner cited as the **Single Owner Rule, `L3`** (line 1650). `ATT-AC-188` makes it testable:
*"No attendance path reads from or writes to another bounded context's database, table or store."*

Every inbound dependency is a **port or a projection** (§5.2), never a table read. `ATT-XC-009` additionally forbids
distributed transactions and cross-aggregate locks, citing BC Map §8 — closing the loophole where a module obeys
"no direct DB access" while still reaching across an aggregate boundary transactionally.

---

## 7. Check 5 — Identity Triad preserved

**PASS.**

BC Map §4 (lines **155–182**) defines the triad and its linkage rules. Against the PRD:

| Rule | Requirement | PRD | Verdict |
|---|---|---|---|
| **`ID-4`** | Library contexts (`BC-01`→`09`) key **exclusively** on `StudentRecordId` | `StudentRecordId` is the keying identifier throughout — `ATT-INV-006`, `ATT-FR-092`, event payloads L1380–1383 | ✅ |
| **`ID-2`** | `StudentRecordId` **never** leaves its tenant; must not appear in any global context, event or index | Events publish to `BC-04`/`BC-22`/`BC-24`/`BC-26` — **all tenant-scoped library/capability contexts.** No `BC-10`…`BC-17` consumer exists; `ATT-XC-006` forbids `BC-11`…`BC-17` outright | ✅ |
| **`ID-1`** | No context outside `BC-18` may store a credential | §8 below | ✅ |
| **Triad separation** | Three identities, never collapsed | `AccountId` 6 mentions, `PersonId` 5, `StudentRecordId` 14 — used **distinctly**; `ATT-XC-012` forbids putting any of the three in a QR | ✅ |

**The triad is consumed, never redefined.** The PRD introduces no fourth identity and no identity resolution of its
own — `ATT-PO-007` requires the actor to *arrive* from an established `BC-18` session.

---

## 8. Checks 6, 7, 18 — `BC-18` boundary, authorisation, and QR

### 8.1 Check 6 — No credential, OTP or session outside `BC-18` — PASS

`ID-1` is the rule; the PRD applies it three ways rather than once:

- **`ATT-XC-008`** (L432) — `VerificationEvidence` **MUST NOT** contain *"a password, OTP, session token,
  credential, secret, key, biometric template, or raw facial image."*
- **`ATT-BR-002`** (L429) — evidence describes *"**what was verified**, not **who the person is**"*; identity is
  `BC-01`/`BC-10`/`BC-18`.
- **`ATT-XC-012`** (L538) — the QR prohibition, below.

Every occurrence of "password", "OTP", "session token" and "credential" in the document is inside a **prohibition**
or an explanation of one. **Zero occurrences describe the module holding such a value.**

### 8.2 Check 18 — QR is not authentication — PASS, and stated three times

`ATT-BR-009` (L536): a fixed attendance QR *"**identifies the library / attendance context**. It **MUST NOT** be
treated as authentication, identity or a credential."* `ATT-XC-012` forbids it encoding a password, OTP, session
token, credential, secret, `AccountId`, `PersonId` **or** `StudentRecordId`.

The PRD's own justification (L541–544) is architecturally correct: *"A QR that authenticates is a QR that can be
photographed and shared. The authenticated actor comes from the `BC-18` session in the app; the QR supplies only the
context being attended."*

**This aligns with frozen `PRD-007`.** `SEAT-BR-030` (`PRD-SEAT-MANAGEMENT.md` line **1347**): *"A QR scan **MUST
NOT** authenticate anybody. Authentication is `BC-18`'s exclusively."* **Two Core contexts, same rule, no
divergence.**

### 8.3 Check 7 — Authorisation remains with the existing architecture — PASS

The PRD defines no role, no scope and no permission model. It consumes `BC-21` Entitlement via `E-17`
(`ATT-PO-003`) *"before the aggregate mutates"*, which is BC Map §7.3's contract verbatim.

This matches frozen `PRD-007`'s ratified stance at `PRD-SEAT-MANAGEMENT.md` line **227** — `BC-18` is **consumed**
(*"the existing RBAC + scope model"*), and the forbidden column reads *"Invent an authorization framework, define a
role, or store a credential."* **`PRD-006` invents none of the three.**

**On `ATT-GAP-002`.** The PRD asks where the authenticated `BC-18` context is composed for a `BC-03` operation,
given `E-11` is `BC-18` → `BC-01` and no `BC-18` → `BC-03` edge exists. §32.1 closes this on frozen `PRD-007`'s
precedent: a Core context receiving an established session **without its own identity edge** is a ratified pattern.
**I verified that precedent at source** (`PRD-SEAT-MANAGEMENT.md` L227) and **accept the closure**. See §10.1 for a
documentation defect in how that closure is recorded.

---

## 9. Check 8 — Tenant isolation and `StudentRecordId` scoping

**PASS.**

`X-13` (Matrix line **362**) classes a cache/index/vector key without `tenantId` as *"**Cross-tenant data leak —
highest-severity failure class in the system**"*, enforced by lint plus the Multi-Tenant Test Suite.

| Surface | PRD rule | Verdict |
|---|---|---|
| Aggregate | `ATT-INV-006` — every `AttendanceDay` **MUST** carry exactly one `tenantId`, and every punch within it likewise | ✅ |
| **Idempotency key** | `ATT-FR-092` — **MUST** be tenant-scoped, citing **`X-13`** | ✅ The precise surface `X-13` targets |
| Wi-Fi config | `ATT-BR-017` — one tenant's approved network **MUST NOT** validate another tenant's attendance | ✅ |
| GPS config | `ATT-BR-019` — tenant-scoped | ✅ |
| Face enrollment | `ATT-BR-021` — *"A student enrolled at one library **MUST NOT** be matchable at another"* | ✅ Tenant isolation applied to biometrics **before** the biometric architecture exists |
| Ambient context | `ATT-PO-004` / `E-18` — propagated, never a domain parameter | ✅ |

The aggregate's identity is `(studentRecordId, date, idempotencyKey)` per BC Map L372, and the PRD scopes the key by
tenant. **The highest-severity failure class in the system is addressed at the exact surface the rule names.**

---

## 10. Checks 9–14 — Configuration, audit, device, events, notification, analytics, offline

**PASS on 9, 10, 14. PASS-with-existing-GAP on 11 and 13. GAP-bearing on 12 (§5.3).**

| # | Boundary | Owner per architecture | PRD position | Verdict |
|---|---|---|---|---|
| 9 | **Configuration** | `BC-25`, `PRD-023` under `ADR-0017`; consumed via `E-19` | `ATT-FR-098` (L1110) — **MUST NOT** implement a configuration store, settings hierarchy or feature-flag system | ✅ PASS |
| 10 | **Audit** | `BC-24` via `E-20`, append-only (`X-10`) | `ATT-FR-130` (L1355) — **MUST NOT** create an attendance-specific audit store; cites `X-10`'s no-update/no-delete rule. `ATT-AC-143` tests it | ✅ PASS |
| 11 | **Device / scanner** | `BC-18` owns `Device` for *authentication* (BC Map L380); `BC-08` owns physical devices but is **V2** (L103) | `ATT-XC-021` — **MUST NOT** create a Device Management context or own device lifecycle. `ATT-BR-039` — *"an auth device is not an attendance scanner"* | ⚠️ PASS + **`ATT-GAP-009`** |
| 12 | **Events / integration** | BC Map §9 vs §7 | §5.3 above | ⚠️ **GAP** — `ATT-GAP-003`/`004` |
| 13 | **Notification** | `BC-22` via `E-23`, facts only | `ATT-PO-010` — events, never *"send an SMS"*; `X-04` compliance noted at L399 | ✅ PASS |
| 13 | **Analytics** | `BC-26` — **no inbound edge exists** | `ATT-FR-146` (L1462) — **MUST NOT** own analytics, define a metric or compute a certified figure | ⚠️ PASS + **`ATT-GAP-003`** |
| 14 | **Offline** | `BC-30` via `E-24` — *"Attendance defines the policy; Sync executes it"* | `ATT-PO-006`, `ATT-PO-011`…`013`. `ATT-PO-012` preserves every §6.2 invariant on replay; `ATT-PO-013` — a replayed punch **MUST NOT** overwrite a correction made while offline | ✅ PASS |

**`ATT-GAP-009` is a genuine V1 hole and is correctly owned elsewhere.** `BC-18` owns `Device` only for
authentication; `BC-08` is V2. **No V1 context can own a V1 face scanner's lifecycle.** The PRD does not solve this
by annexing device ownership — it records the gap and excludes itself. That is the correct Stage 3 behaviour.

**On `E-24` and `L2`.** Matrix line **387** records a *prior* violation of exactly this shape:
`PlatformServices.OfflineSync ──► Attendance` marked *"✖ L2 violation"*, fixed by port inversion. The PRD's
direction — Attendance **defines** the policy, Sync **executes** it — is the corrected direction. **The PRD is on
the right side of a violation this repository has already had once.**

### 10.1 DEFECT — `ATT-GAP-002` status divergence *(Check 22)*

**Reported. Not corrected by this review.**

A mechanical comparison of the §32 gap register against the §32.1 resolution ledger finds **one** genuine
divergence:

| Location | Line | Says |
|---|---|---|
| §32 gap register | **2058** | Presents `ATT-GAP-002` as an **open question** — *"Where is the authenticated `BC-18` context composed…"* — with owner *"Architecture owner"* |
| §32.1 ledger | **2092** | ✅ **RESOLVED** — on frozen `PRD-007`'s ratified pattern |
| §5.2 body note | **310** | *"`ATT-GAP-002` is now **RESOLVED** from existing governance (§32.1)"* |

Two of the three locations say RESOLVED; the register row was not updated when the ledger closed it. **The
resolution itself is sound** — I verified `PRD-SEAT-MANAGEMENT.md` L227 independently (§8.3). This is a
**documentation-consistency defect, not an architectural one**, and it has no effect on any boundary, edge or rule.

**Severity: Low.** **Owner: PRD author.** **Disposition: fix at Stage 4**, where requirement-level consistency is
the gate. **It does not block Stage 3.**

> **The count consequence.** The PRD's §32 preamble states *"3 resolved, 1 narrowed, 17 open."* Counting the
> **register** rows yields 1 resolved / 20 open; counting the **ledger** yields 3 resolved / 1 narrowed / 17 open.
> The ledger is the one the summary matches. **This review does not adjudicate which count is intended** — it
> reports that two tables in one document disagree, which is the author's to reconcile.

Two further apparent divergences were examined and **rejected** as scanner artefacts — see §11, `R-2`.

---

## 11. Rejected findings — recorded as rejected, with reasons

Per `PRD_LIFECYCLE.md` L105: *"A review that records only accepted findings is indistinguishable from a review that
found nothing."*

| # | Candidate finding | Why rejected |
|---|---|---|
| **R-1** | *"The PRD cites a non-existent edge `E-2026`."* | **Scanner artefact.** A greedy `E-[0-9]+` match on `BASELINE-2026-08-04-E` (lines 13, 339). Not an edge citation. No such claim exists |
| **R-2** | *"`ATT-GAP-011` and `ATT-GAP-012` diverge between register and ledger."* | **False positive of my own status classifier.** Both ledger rows read *"🔴 **OPEN** — …"* with the word RESOLVED appearing inside a qualifying clause (*"storage sub-question RESOLVED negatively"*, *"direction resolved, ownership open"*). Register and ledger **agree**: both are open. Only `ATT-GAP-002` genuinely diverges |
| **R-3** | *"The PRD cites `LIB-*` identifiers that don't resolve in the Dependency Matrix."* | **Wrong source.** `LIB-*` belongs to `Library_PRD_v1.md`, where **all 8 resolve**. The apparent miss was my prefix regex `L` capturing `LIB-` against the matrix. Zero dangling |
| **R-4** | *"`ATT-XC-005` refuses `BC-27`, so OCR/Vision can never work — the PRD blocked its own feature."* | **Correct as written, and deliberately so.** BC Map §7.4 `F-3` says a capability reaches the domain by *invoking the domain's command API as an untrusted caller* — never the reverse. A `BC-03` → `BC-27` edge would be architecturally backwards. The PRD **refuted its own earlier request** on reading the law. Rejecting a feature request from the correct direction is not a defect |
| **R-5** | *"Only 4 of 26 edges are used — the module is under-integrated."* | **Not a finding.** BC Map L292 makes the edge table exhaustive, not aspirational. Using fewer edges is restraint, and §7.3's `E-17`/`E-18`/`E-19`/`E-20`/`E-23` are *"All contexts"* edges available by definition |
| **R-6** | *"`ATT-GAP-005` should be closed using the BC Map's stated retention defaults."* | **Must not be closed.** BC Map `Q-04` (L543) is an **open question in the authoritative document itself**, carrying only an unratified note (*"default 7 years financial, 2 years attendance"*). A PRD may not promote a Rank 4 document's own open question into an answer |

---

## 12. Check 15 — `PRD-007` Seat Management boundary

**PASS — the sharpest boundary in the document.**

BC Map `E-08` (line **305**): *"`StudentCheckedIn/CheckedOut` → Seating updates live occupancy. **Seating is the
occupancy owner**, Attendance is the trigger."*

| Obligation | PRD | Verdict |
|---|---|---|
| Attendance triggers, does not own occupancy | `ATT-PO-008` (L325) quotes the ruling **verbatim** | ✅ |
| No second presence system | `ATT-BR-033` (L1050) — **MUST NOT** create a second presence, occupancy or *"currently inside"* system | ✅ |
| No occupancy computation | `ATT-FR-140` (L1425) — **MUST NOT** own, compute or publish live occupancy or counts | ✅ |
| Ownership table | L1419 — **Live occupancy → `BC-04`**, citing `E-08` | ✅ |
| Testable | `ATT-AC-175` — events reach `BC-04` through `E-08` *"and Seating remains the occupancy owner"* | ✅ |

**Frozen `PRD-007` is Rank 3 and byte-identical at `c8760a46…`.** Its two citations of `PRD-006` (lines 223, 862)
are satisfied by the numbering reconciliation. The two documents agree on the occupancy boundary, the QR rule
(§8.2) and the authorisation stance (§8.3). **No conflict on any shared surface.**

---

## 13. Checks 16, 17, 19 — Modes, RFID, Manual

### 13.1 Check 16 — Six independent modes — PASS

`ATT-BR-004` (L491): the six modes are *"**independent attendance methods**. Each one, on its own, is sufficient."*
`ATT-FR-009` (L521) requires each to be independently enableable per tenant. `ATT-BR-013` requires Dynamic QR to be
independent of Fixed QR — enabling one *"**MUST NOT** enable, disable, alter"* the other.

**Critically, `ATT-XC-011` forbids a generic verification layer, pipeline or chain** (L498) — *"any construct in
which one attendance requires a sequence of methods."* This is the abstraction that would silently destroy mode
independence, and it is excluded by name.

Verified mechanically: exactly **six** mode constants exist —
`ATTENDANCE_MODE_MANUAL`, `_FACE`, `_FIXED_QR`, `_FIXED_QR_WIFI`, `_FIXED_QR_GPS`, `_DYNAMIC_QR`.

### 13.2 Check 17 — RFID is FUTURE only — PASS

`NG-9` (L170) classifies RFID/NFC/BLE as **Future/V3**. `ATT-XC-010` (L486) forbids a seventh V1 mode.
`ATT-FR-100` (L1130): *"RFID **MUST NOT** appear as a V1 configurable mode."* `ATT-BR-020` confirms Face must not
require RFID.

Verified mechanically: **`ATTENDANCE_MODE_RFID` occurrences = 0.** No V1 artefact of any kind.

### 13.3 Check 19 — Manual individual attendance is first-class — PASS

`G-6` (L154): serve students without a smartphone as first-class users — *"Manual attendance is a **mode**, not a
fallback."* `ATT-BR-023` (L868): **MUST** be treated as first-class, *"not a temporary fallback."* `ATT-BR-024`
forbids a manual entry silently becoming QR, Face or automated attendance.

**The architecturally significant decision** (§33 changelog, L2256): the two Manual workflows were **deliberately
separated** — individual entry (buildable today) from physical-register OCR (blocked on missing edges) — *"so the
smartphone-less student is served without waiting for an AI architecture decision."* **The unbuildable half does
not take the buildable half hostage.** This is correct decomposition, not a workaround.

---

## 14. Check 20 — OCR/Vision and Face blocked where unauthorised

**PASS.** Both are blocked, and the blocks rest on cited law rather than caution.

**OCR/Vision — `ATT-GAP-011`, NARROWED.** No context owns OCR. A repository-wide search for `OCR`, `computer
vision`, `document AI` and `image recognition` across `docs/**` returns **zero capability nodes**, including in
EA v2.1's AI tree; `BC-27`'s charter (BC Map L136) reads *"human-in-the-loop, model routing"* — no vision, no image
ingestion. The PRD does not assign OCR to a context. The *direction* is settled (`F-1`/`F-3`/`F-4`); the
*ownership* is open. **Owner: architecture owner. Blocks: the register-image workflow only.**

**Face — `ATT-GAP-012`, `013`, `014`, OPEN; Face mode blocked entirely.** The PRD audits the biometric boundary
across eight dimensions (§12.4a) and closes the **storage** sub-question *negatively and definitively*: `E-22`'s
consumer list is `BC-01`, `BC-10`, `BC-14` (BC Map L331, amended by `ADR-0016`) — **`BC-03` is absent**, and L292
rules an unlisted edge does not exist. **`BC-03` therefore has no authorised byte-storage path of any kind, so it
cannot hold a biometric template.** `ATT-XC-020` forbids specifying biometric storage/retention design;
`ATT-XC-019` forbids specifying a liveness algorithm; `ATT-XC-018` forbids Face becoming an authentication method.

`ATT-GAP-014` is a **conflict, not a void**: `ID-5` guarantees erasure by **pseudonymisation**, which is
structurally inapplicable to data that *is* the identifier. Correctly escalated to `MP-GBR-04`/`ID-5` grounds.

**Assessment: the PRD specifies a mode it cannot build and says so, rather than inventing a biometric architecture
to make it buildable.** That is the required behaviour.

---

## 15. Check 21 — No invented API, database or schema

**PASS — measured, not assumed.**

A scan for `CREATE TABLE`, `POST /`, `GET /`, `endpoint` and `REST API` across all 2,260 lines returns **0
occurrences**. No table definition, no HTTP surface, no migration, no wire schema. Event payloads are described as
**field lists with explicit exclusions** (*"Credentials · evidence internals · biometric data · profile · membership
detail"*), which is contract description at the published-language level — BC Map §9's own form — not schema design.

---

## 16. Check 22 — `ATT-*` and external reference integrity

**PASS, with the single defect at §10.1.**

| Scan | Result |
|---|---|
| Distinct `ATT-*` identifiers cited | **506** |
| **Invalid / out-of-range internal references** | **0** |
| Ten registers contiguous 1→max | ✅ 148 / 42 / 12 / 4 / 21 / 14 / 24 / 14 / 209 / 18 |
| **Dangling external references** | **0** across `MP-GBR`, `ID-`, `X-`, `AR-`, `SEAT-`, `MM-`, `LIB-`, `AUTH-`, `F-` |
| `L2`, `L3` citations | Both exist in the Matrix |
| Obligation coverage | 279/279 = **100.0%**, 0 orphan criteria |

**Every external identifier the PRD cites was verified to exist in the file that owns it.** Nothing points at a rule
that isn't there.

---

## 17. Conflicts found

**Against Ranks 1–5: ZERO.**

No boundary, edge, rank, identity rule, authorisation rule or tenancy rule in this PRD contradicts the Master PRD,
any ADR, any frozen Rank 3 PRD, the BC Map, the Dependency Matrix or the Architecture Rulings.

**Two conflicts are *carried* by the PRD rather than caused by it**, both pre-existing and both in Rank 4:

| # | Conflict | Between | Status |
|---|---|---|---|
| **C-A** | Event consumers named in BC Map §9 have no edge in BC Map §7 (`BC-26`, `BC-13`) | **Rank 4 vs itself** | Systemic — `SM-GAP-11` / `MM-GAP-010`; `ADR-0018` §3.2 assigns it to the architecture owner. Frozen `PRD-004` and `PRD-005` both declined it |
| **C-B** | `ID-5` promises erasure by pseudonymisation; a biometric template cannot be pseudonymised | **Rank 4 vs a V1 product mode** | `ATT-GAP-014`; blocks Face mode |

**Neither is resolved here.** Both would require an ADR from the architecture owner.

**One internal defect** (§10.1): the `ATT-GAP-002` register/ledger divergence. Reported, uncorrected.

---

## 18. `ATT-GAP-*` items — owner and reason

**No new `ATT-GAP-*` identifier was created by this review.** All twenty open items below already exist in the
PRD's register. This review **confirms** each is a genuine absent decision rather than an authoring omission, and
**verified each stated owner against the source that assigns it**.

| Gap | Reason it cannot close at Stage 3 | Owner | Blocks |
|---|---|---|---|
| `ATT-GAP-002` | **Closed in §32.1** on `PRD-007` L227 — verified sound. Register row stale (§10.1) | *Closed* | Nothing |
| `ATT-GAP-003` | BC Map §9 names `BC-26` a consumer; §7 declares no edge. Systemic across ten contexts | Architecture owner — **ADR** | Analytics consumption |
| `ATT-GAP-004` | `E-14` targets exclude `BC-03`; no authorised path **in either direction** | Architecture owner — **ADR** | Fraud escalation |
| `ATT-GAP-005` | BC Map `Q-04` (L543) is open **in the authoritative document itself** | Legal + architecture owner | Retention |
| `ATT-GAP-006` | No Rank 1–5 source defines a cryptographic construction | Security Platform | Dynamic QR hardening |
| `ATT-GAP-007` | No source identifies a network technically or authorises spoof detection | Security Platform | Wi-Fi claims |
| `ATT-GAP-008` | `LIB-6.5` Map Location is `BC-06`'s and silent on attendance use | Library PRD owner | GPS source |
| `ATT-GAP-008a` | No source authorises mock-location detection | Security Platform | GPS assurance |
| `ATT-GAP-009` | `BC-18` owns `Device` for auth only; `BC-08` is **V2**. No V1 device owner exists | Architecture owner | Scanner lifecycle |
| `ATT-GAP-010` | No authorised byte-storage path (`E-22` excludes `BC-03`) | Architecture owner | Register images |
| `ATT-GAP-011` | **Direction settled, ownership open.** No context owns OCR/Vision anywhere in `docs/**` | Architecture owner — **ADR** | Register-image workflow |
| `ATT-GAP-012` | Storage settled negatively; **ownership** unassigned by every source | Architecture + Security | **Face mode entirely** |
| `ATT-GAP-013` | Liveness is a security design; §0.4 forbids inventing one | Security Platform | **Face mode** |
| `ATT-GAP-014` | `ID-5` pseudonymisation is structurally inapplicable to biometrics — a **conflict** | Legal + architecture owner | **Face mode** |
| `ATT-GAP-015`…`018`, `016a`, `017a` | Product and policy decisions with named owners; none is an architecture question | Per register | Non-blocking |

**Two gaps (`012`, `013`) plus the `014` conflict block the Face mode from being built. They do not block Stage 3**,
because Stage 3 asks whether the *specification* respects the architecture — and refusing to build an unauthorised
capability is respect, not failure.

---

## 19. Containment audit

| Constraint | Evidence |
|---|---|
| PRD-006 not modified | Hash `600c59ec…` before **and** after this review |
| No authoritative document modified | `git status --porcelain` empty at review start; only this file added |
| `PRD-007` untouched | `c8760a46…` |
| `PRD_REGISTRY.md` untouched | `f8e71ce8…` |
| BC Map, Dependency Matrix, ADRs, Master PRD | Read-only; zero writes |
| No ADR created | 20 ADRs + `ADR-INDEX.md` = 21 files, unchanged |
| No architecture invented | No edge, event, role, port, aggregate, config key, audit surface, device model, notification path, analytics metric or offline mechanism defined by this review |
| No `ATT-*` identifier created | This review adds none to the PRD |
| No freeze | PRD-006 remains **`DRAFT`, Stage 2→3, Unranked** |

---

## 20. Verdict

### ⚠️ CONDITIONALLY ALIGNED

**21 of 22 checks PASS. Zero conflicts against Ranks 1–5. One internal documentation defect. One check
(12) is GAP-bearing on a defect the PRD did not cause and correctly declined to fix.**

Measured against `PRD_LIFECYCLE.md` L92–99, the six formal Stage 3 checks are **all PASS**:

| Lifecycle check | Authority | Result |
|---|---|---|
| Context ownership is exclusive | BC Map §3 | ✅ **PASS** — sole owner of `AttendanceDay`; `BC-07` staff boundary excluded by name |
| Every integration edge exists in §7 | BC Map §7 | ✅ **PASS** — 9 claimed, 9 verified, contracts quoted; **0 invented** |
| Rank direction is downward | Matrix `L2` | ✅ **PASS** — cluster rule honoured; the one upward request was **self-refuted** |
| No authorisation outside `BC-18` | `X-13` | ✅ **PASS** — no role, scope or framework defined |
| No credential, OTP or session outside `BC-18` | `ID-1` | ✅ **PASS** — every mention is a prohibition |
| Tenant scoping correct | `MP-GBR-08`, `X-13` | ✅ **PASS** — including the idempotency key, the exact `X-13` surface |

**What "conditional" means here.** The condition is **not** an architectural failure. It is one low-severity
documentation defect — the `ATT-GAP-002` register row (line 2058) contradicting its own ledger (line 2092) and body
note (line 310). Two of three locations are right; one is stale. **Fix at Stage 4**, where internal consistency is
the gate. Nothing about a boundary, edge or rule depends on it.

**What this review did not do.** It did not resolve `C-A` or `C-B`, did not create the OCR context the PRD needs,
did not grant `BC-03` a `BC-26` or `BC-13` edge, did not assign biometric ownership, and did not correct the
divergent row. **Every one of those would have been an invention, and each is recorded against a named owner
instead.**

**The strongest evidence for this verdict** is what the PRD refuses to do. It specifies a Face mode it cannot build
and says so. It requested a `BC-03` → `BC-27` edge, read `F-1`/`F-3`, and withdrew its own request. It inherited a
Rank 4 defect that ten contexts share and followed two frozen PRDs in declining to resolve it. **A draft that
refuses to invent its way past an architectural absence is the outcome Stage 3 is designed to produce.**

### Stage status

| | |
|---|---|
| **Stage 3 gate** | ✅ **Satisfied by this document** — a written alignment record naming every conflict and its disposition |
| **Registry status this implies** | `IN_REVIEW` — **to be recorded by the registry owner, not by this file** |
| **`PRD-006` lifecycle status** | **`DRAFT` — Stage 2 as declared in its own header. NOT frozen. NOT ranked. NOT admitted to any baseline** |
| **Next stage** | **Stage 4 — Requirements Review.** Carry forward: the §10.1 defect, the §17 gap-count discrepancy, and the `LIB-16.2` seven-configurable **FAIL** already recorded in the verification report |
| **Blocking Stage 7** | `ATT-GAP-003`, `004`, `005`, `009`, `012`, `013`, `014` — each needs a decision from a named owner, several needing an ADR |

---

*End of `PRD-006_ARCHITECTURE_ALIGNMENT.md` v1.0. This record confers no status and advances no stage by itself.*
