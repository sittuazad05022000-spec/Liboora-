# `PRD-006` — Human Decision Handoff Package

| Field | Value |
|---|---|
| **Document** | The single consolidated decision sheet for [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.4 DRAFT** (sha256 `28965ddbb4480a50`, moved from `93ab1c60d740c4e0` by the §16.3 amendment — the move is what re-triggers Stage 4) |
| **Result** | ⛔ **NOT FROZEN — 9 of 15 conditions now satisfied** (§8). The Product Owner has now decided **all six V1 defaults *and* all six V1 allowed ranges**, `ATT-GAP-017` is **RESOLVED at 12/12**, `LIB-16.2` is satisfied in **both** sentences, and §16.3 is **amended in v1.4**. **Every Product-Owner-owned condition is discharged.** The six that remain are **all** Architecture-Owner-side: three `Proposed` ADRs, the ARB half of Face V3, D-9, the admitting ADR's two co-signatures, the baseline rank row and the registry status |
| **Version** | v1.2 · 2026-08-04 |
| **Purpose** | One place where every remaining `PRD-006` decision can be made by its existing role-holder. Replaces the need for any further investigation document |
| **Supersedes as the operative sheet** | `PRD-006_CONSOLIDATED_DECISION_PACKAGE.md` · `PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md` · `PRD-006_ATT-GAP-017_DECISION_SHEET.md` — all retained as evidence, none contradicted |
| **Roles used** | **Architecture Owner (ARB)** · **Product Owner** · **Security Platform** — all three pre-existing. **No new role, authority, person, rule, value or range is created** |

---

## 0. How to use this sheet

Personal names are **not** recorded here. `PRD_OWNERSHIP_MODEL.md` §7 rule 4: *"**Never**
record a personal name. If a name is needed operationally, it belongs in a **team
directory outside the repository**."* Each block below therefore names the **role** that
must act. The holder identifies themselves through the team directory, then acts through
the role — exactly as `ADR-0013` describes: *"acting through the **Architecture Owner
role** defined in `PRD_OWNERSHIP_MODEL.md` §2.2."*

Boxes are `☐`. **A tick is a human act.** No box in this repository has ever been ticked by
a reviewer, and none is ticked here.

---

## 1. Dependency order — the critical path

```
        D-0  Architecture Owner exists (external directory)
              │  §5: "Only the Architecture Owner approves."
              ▼
   ┌──────────┴───────────┬─────────────────────┐
   ▼                      ▼                     ▼
 D-6 (ADR-0023          D-7 (ADR-0022        D-8 Security Platform
  option A/B/C/D)        option A/B/C/D)      unit bound by ADR (§7 rule 2)
   │                      │                     │
   ▼                      │                     ▼
 D-4 ATT-CFG-019          │             D-1 ATT-CFG-005  ─┐ paired:
  default + domain        │             D-2 ATT-CFG-006  ─┘ 006 ≥ 005
   │                      │                     │
   │                      │              D-3 ATT-CFG-014 envelope
   │                      │              (Security input + ARB)
   └──────────┬───────────┴──────────┬──────────┘
              ▼                      ▼
        D-5 ADR-0021 D-1 route   D-9 ADR-0021 D-2 (governance)
              └──────────┬───────────┘
                         ▼
              D-10 §16.3 amendment → v1.4
                         ▼
              D-11 Stage 4 re-review (re-triggered by the edit)
                         ▼
              D-12 Stage 5 + Stage 6 re-verify
                         ▼
              D-13 Admitting ADR (PO + PEA + reviewer)
                         ▼
              D-14 DOCUMENTATION_BASELINE §3 row + rank
                         ▼
              D-15 PRD_REGISTRY status → FROZEN
```

**D-0 gates everything.** Three orderings are load-bearing:
`D-6` **before** `D-4` (an OCR threshold for a capability no context owns is unusable) ·
`D-8` **before** `D-1`/`D-2` (only Security may set QR durations) ·
`D-1` **before** `D-2` (`ATT-CFG-006`'s validation is *"Must be ≥ rotation interval"*).

---

## 2. Decisions for the **Product Owner**

> **STATUS 2026-08-04 — all three Product Owner decisions RECEIVED and RECORDED.** The
> Product Owner has ruled on **D-5**, **D-3a** and **D-16**. Each is transcribed below
> exactly as authorised. **`ATT-GAP-017`'s owner column (L2178) reads *"Product owner"* —
> singular** — so D-5 is within this role's sole authority and is validly decided.

### D-5 · `ADR-0021` D-1 — by what route are the seven defaults *and ranges* established?

`ADR-0021` §4 costs four options and recommends none.

- ✅ **APPROVED** — Product Owner, 2026-08-04. Authority: `PRD-006` §32 L2178 names
  *"Product owner"* alone as `ATT-GAP-017`'s owner; `ADR-0021` §4.1 — *"Each requires **the
  product owner to act**."*

**Which of the four options was not named, and none is inferred here.** The approval is
recorded as given. What the approval *does* and *does not* produce is arithmetic, not
interpretation:

| Route | What it would still require |
|---|---|
| **A** — owner supplies values and ranges directly | The six missing answers, from the Product Owner |
| **B** — commissioned anchored analysis | An analysis, then *"the product owner still ratifies"* |
| **C** — PRD holds envelopes, `CONFIGURATION_GUIDE` holds values | Six envelope halves, then six value halves |
| **D** — descope the affected capabilities | An explicit Product Owner ruling descoping **Dynamic QR** and the **register-image OCR workflow** from V1. Not stated |

**Measured consequence: D-5 = APPROVED authorises the route but does not itself supply a
number.** Under A, B and C the remaining answers are still owed; under D a further explicit
descope ruling is owed. See §3.1 for the recomputed arithmetic.

### D-3a · `ATT-CFG-014` — is Face attendance V1 at all?

`ATT-GAP-015` (Owner: *"Product owner + architecture owner"*) records the conflict: EA
v2.1 L754 lists `Face Recognition (V3)`; the product instruction says V1.

- ✅ **APPROVED → Face Attendance = V3.** Product Owner, 2026-08-04. Consistent with the
  prior ruling in `PRD-006_ATT-GAP-015_DECISION_RECORD.md` §1, which is **preserved
  unchanged**, and with EA v2.1 L754 — the only face reference in the EA.

**Effect, and its limit.** `ATT-CFG-014` leaves the V1 configuration surface, so
`ATT-GAP-017` drops from **14 required answers to 12** and the `LIB-16.2` shortfall drops
from four settings to **three**. **`ATT-GAP-015` does not close.** L2175's owner column is a
**conjunction** — *"Product owner **+** architecture owner"* — and the ledger verdict at
L2209 states the gap *"**cannot self-close**."* The Product Owner half is now final; the
Architecture Owner half is listed in §5.

### D-16 · Admitting-ADR co-authority

Per `ADR-0018`/`0019`/`0020`, freeze authorisation is *"**Product owner** (freeze
authorisation); **Principal Enterprise Architect**; independent reviewer."*

- ✅ **APPROVED — Product Owner freeze authorisation given**, 2026-08-04. Recorded as the
  **first of the three signatures** the precedent requires. It is held on the record and
  takes effect when D-10 … D-12 pass and the two co-signatures exist. **It is not treated
  as, and does not substitute for, the other two.**

---

## 3. **Preserved** — do not re-decide

These three carry genuine human values and are **unchanged**. Recorded in
`PRD-006_ATT-GAP-017_PO_VALUE_DECISION_RECORD.md`; each verified against its own §16.3
validation predicate.

| ID | Setting | Default | Allowed range | Predicate | Verified |
|---|---|---|---|---|---|
| `ATT-CFG-011` | GPS acceptance radius | **50 m** | **20–200 m** | *"Must be > 0 and within bound"* | ✅ both endpoints |
| `ATT-CFG-012` | Min. acceptable location accuracy | **30 m** | **5–100 m** | *"Must be > 0"* | ✅ both endpoints |
| `ATT-CFG-023` | Correction window | **15 min** | **0–60 min** | *"Must be ≥ 0"* | ✅ both endpoints |

**Important status note.** These values live in the decision record, **not yet in the
PRD** — §16.3 L1165/1166/1177 still read *"Bounded distance — unresolved"* / *"Bounded
duration — unresolved"*. They transfer into the PRD at **D-10**, in one coherent
amendment together with the other four rows. Amending three rows alone would falsify
§16.3's own preamble and leave the ten dependent *"seven configurables"* statements stale.

**Re-confirmed 2026-08-04** by the Product Owner in the same instruction that supplied D-5,
D-3a and D-16. Transcribed identically; not changed, widened, narrowed or reinterpreted.

### 3.1 Recomputed arithmetic after D-5, D-3a and D-16

`ATT-GAP-017` (L2178) asks for *"the **default values and allowed ranges**"* — two answers
per setting. **D-3a removes `ATT-CFG-014` from the V1 surface**, so the denominator falls
from 14 to 12.

| Setting | Default | Allowed range | State |
|---|---|---|---|
| `ATT-CFG-011` | ✅ 50 m | ✅ 20–200 m | **COMPLETE** |
| `ATT-CFG-012` | ✅ 30 m | ✅ 5–100 m | **COMPLETE** |
| `ATT-CFG-023` | ✅ 15 min | ✅ 0–60 min | **COMPLETE** |
| `ATT-CFG-014` | — | — | **OUT OF V1** by D-3a |
| `ATT-CFG-005` | ✅ 30 s | ✅ 15–120 s | **COMPLETE** |
| `ATT-CFG-006` | ✅ 60 s | ✅ 30–300 s | **COMPLETE** |
| `ATT-CFG-019` | ✅ 0.90 | ✅ 0.80–1.00 | **COMPLETE** |

| Measure | Two instructions ago | After the six defaults | **After the three ranges** | Freeze needs |
|---|---|---|---|---|
| `ATT-GAP-017` answers | 6 of 14 | 9 of 12 = 75.0% | ✅ **12 of 12 = 100%** | 12 of 12 |
| Settings of the seven complete | 3 | 3 + 1 descoped | ✅ **6 complete + 1 descoped = 7 of 7 disposed** | 7 |
| V1 settings still lacking a default | 4 | 0 | ✅ **0** | 0 |
| V1 settings still lacking a range | 4 | 3 — `005`, `006`, `019` | ✅ **0** | 0 |
| `LIB-16.2` sentence 1 | 🔴 breached at 4 | ✅ satisfied 24/24 | ✅ **satisfied 24/24** | satisfied |
| `LIB-16.2` sentence 2 | 🔴 latent | 🟡 latent | ✅ **satisfied — no longer latent** | satisfied |
| §16.3 rows reading *"unresolved"* | 7 | **7 — unchanged; nothing written yet** | 0 |

**The precondition on step 2 of the instruction is therefore measurably unmet.** It reads
*"complete the PRD-006 v1.3 → v1.4 amendment **only when all required configuration
defaults/ranges are legitimately available**."* Six of twelve are available. `ATT-CFG-005`,
`ATT-CFG-006` and `ATT-CFG-019` have **no value from any authority anywhere in the
repository** — re-searched this run. Writing any of the six missing answers would be
inventing a value, which the same instruction forbids.

**Why D-5 = APPROVED does not by itself supply them.** D-5 authorises the *route*.
`ADR-0021` §4 Option A's own text confirms the distinction: *"Who acts | **Product owner**"* —
the option names the actor, and the actor must then act by naming numbers. None was named.

---

## 4. Decisions for **Security Platform** — *or, per `ADR-0021` §4, for the Product Owner directly*

> **⚠️ CORRECTION RECORDED 2026-08-04 — this section is narrower than previously stated.**
> `ADR-0021` §4 Option A, quoted verbatim, distinguishes two strengths of security
> involvement: *"Who acts | **Product owner; security input required for `ATT-CFG-014`
> (face) and advisable for `ATT-CFG-005`/`006` (QR rotation)**."*
>
> | Setting | Security involvement, verbatim | Effect now |
> |---|---|---|
> | `ATT-CFG-014` | *"**required**"* | Moot — D-3a = V3 removes it from V1 |
> | `ATT-CFG-005` | *"**advisable**"* | **Not a hard gate.** The Product Owner may supply it |
> | `ATT-CFG-006` | *"**advisable**"* | **Not a hard gate.** The Product Owner may supply it |
>
> **Consequence: `ATT-CFG-005` and `ATT-CFG-006` are NOT blocked on a Security Platform that
> does not exist.** They are blocked only on **two defaults and two ranges that no one has
> stated**. `ATT-GAP-017`'s owner column (L2178) reads *"Product owner"* — singular — so the
> Product Owner may supply all four answers, taking the *advisable* security input if and
> when the platform is constituted. **This is the shortest legitimate path to closing the
> `LIB-16.2` breach for these two settings, and it requires no new authority.**
>
> Nothing is written for them here, because no value was given. The forbidden borrow recorded
> below still stands.

**Precondition D-8** *(now optional for `005`/`006`, per the correction above)*. The role is
registered at `PRD_OWNERSHIP_MODEL.md` **L180**
(`PRD-012a` → Domain Owner *"Security Platform"*) but has never been constituted: the
platform is `[RECONSTRUCTED]` (`LIBOORA_ENTERPRISE_ARCHITECTURE.md` L88; L50 = *"not
present in the transmitted text… architected to enterprise standard"*), `PRD-012a` *"has
not been opened"* (L331), and `SECURITY` is a **platform, not a bounded context**, so
`PRD_LIFECYCLE.md` Stage 1's gate cannot be cleared.

**Legitimate mechanism that already exists:** `PRD_OWNERSHIP_MODEL.md` §7 rule 2 — *"A
**Domain Owner** change is a **context-ownership change** — ADR required."* Exercised by
`ADR-0013` and `ADR-0017`. It binds an **organizational unit**, never a person.

- ☐ **D-8** Architecture Owner binds the registered Security Platform Domain Owner by ADR

### D-1 · `ATT-CFG-005` — Dynamic QR rotation interval

| Field | Value |
|---|---|
| Current §16.3 (L1159) | Default `ATT-GAP-017` · Domain **`Bounded duration — unresolved`** · Validation *"Must be > 0 and ≤ validity window"* |
| Also blocks | `ATT-GAP-006` — *"What cryptographic construction secures a dynamic QR code?"* |

- ✅ **Default: 30 seconds** — Product Owner, 2026-08-04. Verified `30 > 0` and `30 ≤ 60`
- ✅ **Allowed range: 15–120 seconds** — Product Owner, 2026-08-04. Verified against the
  register predicate at both endpoints: `15 > 0` ✅ and `120 > 0` ✅, and the default sits
  inside it — `15 ≤ 30 ≤ 120` ✅. Now written to §16.3 L1159 in `PRD-006` **v1.4**

### D-2 · `ATT-CFG-006` — Dynamic QR validity window

| Field | Value |
|---|---|
| Current §16.3 (L1160) | Default `ATT-GAP-017` · Domain **`Bounded duration — unresolved`** · Validation *"Must be ≥ rotation interval"* |
| Constraint | Must be **≥ D-1**. Decide D-1 first |

- ✅ **Default: 60 seconds** — Product Owner, 2026-08-04. Verified `60 ≥ 30` — the D-1/D-2
  ordering constraint is satisfied, and `005` ≤ `006` holds in both directions
- ✅ **Allowed range: 30–300 seconds** — Product Owner, 2026-08-04. Verified `30 > 0` ✅,
  `30 ≤ 60 ≤ 300` ✅, and against D-1: the floor `30 ≥ 15` and the ceiling `300 ≥ 120`, so
  every D-1 value has at least one admissible D-2 partner. Now written to §16.3 L1160 in v1.4

> **Disclosed, not corrected — the ranges overlap at their extremes.** Taken *as ranges*, the
> pair admits one combination the predicate rejects: rotation at its maximum `120 s` with
> validity at its minimum `30 s` gives `120 ≤ 30` = **false**. This is recorded rather than
> repaired, on two grounds. Narrowing either approved endpoint would **change a Product-Owner
> approved value**, which the instruction forbids; adding a cross-setting guard would **invent
> a rule**. And it needs neither: `LIB-16.2`'s companion rule `LIB-16.3` already requires that
> *"every setting change **MUST** be validated before persistence"* and that an invalid value
> *"**MUST** be rejected with a specific reason"*, so the combination is refused at write time
> by a rule that already exists. This follows the §8.1 precedent, where the 5.0× GPS
> radius-to-accuracy ratio was disclosed and deliberately left unacted-upon.

> **Forbidden source, recorded so it is not re-proposed.** `Authentication_PRD_v2.md` L92
> carries *"OTP challenge validity | 5 minutes"* and L72 *"Minimum interval between OTP
> requests | 30 seconds"*. `ADR-0021` §2.1 pre-adjudicates the borrow: *"Same word,
> different threat model, different bounded context, different owner. Borrowing the number
> would import a security parameter across a context boundary and **dress an invention as
> a citation**."* These figures **must not** be copied into D-1/D-2.

### D-3 · `ATT-CFG-014` — Face match confidence envelope *(only if D-3a = V1)*

- ⬜ **NO LONGER REQUIRED FOR V1 FREEZE.** D-3a = **V3**, so `ATT-CFG-014` leaves the V1
  configuration surface and **no V1 default or envelope is owed for it**. `ADR-0021` §4
  Option D states the principle: *"The settings cease to exist in V1, so **no default is
  owed**."*

**Deferred, not cancelled.** The setting still exists in §16.3 and will need a default and
an envelope when Face is built in V3, at which point `ADR-0021` L7's *"security input
required for `ATT-CFG-014`"* applies in full, together with `ATT-GAP-012`, `ATT-GAP-013` and
`ATT-GAP-014`. `ADR-0021` §2.3 remains on the record for that occasion: *"`Bounded 0–1` is a
**type**, not a range… a face-match threshold of `0.01` authorises impersonation."*

---

## 5. Decisions for the **Architecture Owner (ARB)**

### D-6 · `ADR-0023` — who owns OCR/Vision? *(blocks D-4)*

`ADR-0023` §4 costs four options and recommends none:

- ☐ **A** Extend `BC-27` AI Assistance to own OCR/Vision *(context count stays 31)*
- ☐ **B** Create a new capability context *(31 → 32)*
- ☐ **C** Assign to an existing non-AI platform context — *"**No candidate is nominated here**"*, so this option **requires naming one**
- ☐ **D** Defer; §13B is not built *(legitimate on the `ADR-0020` fourteen-gap precedent)*

### D-4 · `ATT-CFG-019` — OCR high-confidence threshold *(after D-6)*

Current §16.3 (L1173): Domain **`Bounded 0–1 — unresolved`** · Validation *"Within bound"*.

- ✅ **Default: 0.90** — Product Owner, 2026-08-04. Verified `0 ≤ 0.90 ≤ 1`
- ✅ **Allowed domain: 0.80–1.00** — Product Owner, 2026-08-04. Verified `0 ≤ 0.80 ≤ 1` ✅,
  `0 ≤ 1.00 ≤ 1` ✅, and `0.80 ≤ 0.90 ≤ 1.00` ✅. This **closes the exact risk** `ADR-0021`
  §2.3 named: *"`Bounded 0–1` is a **type**, not a range: it excludes `1.7` but admits `0.01`
  and `0.99` equally."* `0.80–1.00` is a genuine narrowing of that type, and the `0.01`
  configuration the ADR warned about is now rejected by the register itself rather than only
  discouraged by the default. Now written to §16.3 L1173 in v1.4

> **Note on D-6.** OCR = **V1** is now ruled, so `ATT-CFG-019` is firmly inside the V1
> surface. This **strengthens** rather than removes the need for D-6: a V1 setting must have
> an owner, and `ADR-0023` — still `Proposed` — records that *"no context owns an OCR/Vision
> capability."* `ATT-FR-080` also still blocks the workflow build until `ATT-GAP-010` **and**
> `ATT-GAP-011` are answered by their named owners.

### D-7 · `ADR-0022` — may `BC-03` hold a `FileRef` from `BC-29`?

- ☐ **A** Add `BC-03` to `E-22`'s consumer list
- ☐ **B** Refuse; `BC-03` never holds imagery
- ☐ **C** Route the image through an existing `E-22` consumer
- ☐ **D** Defer

> `ADR-0023` records that `ATT-FR-080` blocks on **both** `ATT-GAP-010` (D-7) and
> `ATT-GAP-011` (D-6), so *"deciding either alone lifts nothing."*

### D-9 · `ADR-0021` D-2 — does a CONDITIONAL Stage 3/4 verdict permit Stage 7?

`PRD-006` holds ⚠️ **CONDITIONALLY ALIGNED** (Stage 3, 21/22) and ⚠️ **CONDITIONALLY
PASSED** (Stage 4, 5/6). Every previously frozen PRD reached Stage 7 on **A — PASS**.

`ADR-0021` §5 offers four supporting readings and then refuses to settle it: *"All four are
**readings**… Bases 1–2 argue from silence… **This is recorded as a supported reading and
referred for confirmation. It is not asserted as settled.** Inferring a governance rule
from four silences and acting on it would be **inventing governance**."*

- ☐ CONDITIONAL **does** permit Stage 7 · ☐ It does **not**; PRD-006 must reach **A — PASS** first

**Owner note.** `ADR-0021` L7 assigns D-2 to a *"Governance owner"*. That role is **not**
among the four `PRD_OWNERSHIP_MODEL.md` §2.1 derives and has **no §4 assignment row**.
Establishing where D-2 sits among the four existing roles is itself an Architecture Owner
determination — **recorded here, not resolved.**

- ☐ **D-9a** Architecture Owner records which existing role holds D-2

### D-17 · ADR dispositions and acceptance

- ☐ `ADR-0021` → Accepted / Rejected *(after D-5, D-9)*
- ☐ `ADR-0022` → Accepted / Rejected *(after D-7)*
- ☐ `ADR-0023` → Accepted / Rejected *(after D-6)*

**Rejection is equally an ARB act.** All three are currently `Proposed` — *"not binding"* —
and each is self-describedly non-deciding (`ADR-0021` Amends: *"**No document.**"*).

---

## 6. What happens automatically once §2–§5 are complete

These are **mechanical**, need no further human decision, and are executable in one
operation. They are listed so the approvers know exactly what their signatures set in
motion.

| # | Step | Requirement, from the repository |
|---|---|---|
| **D-10** | **§16.3 amendment → v1.4** | One coherent amendment covering **all seven** rows. Synchronise the ten dependent *"seven configurables"* statements at **L1185, 1187, 1190, 1214 (`ATT-BR-044`), 1229, 2059 (`ATT-AC-199`), 2071 (`ATT-AC-212`), 2178 (gap text), 2212 (ledger verdict), 2316 (§33 scope)**. Leaving any stale creates a fourth instance of the `GCP-01`/`07`/`08` defect class — *"a derived statement left behind by a change to the thing it describes"* |
| **D-11** | **Stage 4 re-review** | Editing the subject changes its sha256 and **re-triggers** Stage 4. Must reach the verdict D-9 requires |
| **D-12** | **Stage 5 + Stage 6** | `prd006_traceability.py` and `prd006_task_coverage.py` at **exit 0**, re-run immediately before acceptance, per the `ADR-0020` precedent. `ALLOWED` lists **must not** be widened to force a pass |
| **D-13** | **Admitting ADR** | New sequential number on the `ADR-0018`/`0019`/`0020` model. Written **before** any ranked document is touched (`ADR-INDEX` Process 1; Baseline §7 step 1). Deciders: **Product owner + Principal Enterprise Architect + independent reviewer** |
| **D-14** | **`DOCUMENTATION_BASELINE.md` §3 row** | Stage 7's actual gate: *"a row in `DOCUMENTATION_BASELINE.md` §3 **at an assigned precedence rank**"* — Rank 3, plus a new `BASELINE-2026-08-04-x` declaration (§7 step 4) and Rank 2 extended to the new ADR |
| **D-15** | **`PRD_REGISTRY.md`** | L236 `` `PLANNED` `` → `` `FROZEN` ``; §7 counts `FROZEN` 6 → 7, `PLANNED` 17 → 16 |
| **D-18** | **Freeze conferred** | *"Freeze is **conferred, not claimed**. No PRD in this repository declares itself frozen."* `FROZEN` ≠ `VERIFIED` — 0 of 80 tasks and 0 of 213 `ATT-AC-*` are test-proven |

**One independent obstacle that D-5 alone does not clear.** `ADR-0021` L286: *"**D-2 is not
a workaround for D-1.** Even confirmed in the affirmative, it does not close
`ATT-GAP-017`, and the `LIB-16.2` breach in §2.5 stands **independently** of it."* A search
of all seven admission ADRs for a live Rank 3 breach returns **0 hits** — no PRD here has
ever frozen carrying one. The breach clears when `ATT-GAP-017` reaches 14 of 14.

**A finding in the PRD's favour, recorded for the approvers.** `ADR-0020` L128 states the
real admission test: behaviour must be *"**deterministic under every candidate
resolution**."* **PRD-006 passes it** — `ATT-BR-043`, `ATT-FR-149`, `ATT-FR-150`,
`ATT-FR-151` and `ATT-BR-044` give 17 combined citations, no task closes a gap, and all 12
BLOCKED tasks name their blocking gap. On the `ADR-0018` (2 gaps), `ADR-0019` (5) and
`ADR-0020` (14) precedent, **open gaps alone would not bar freeze.** The bar is the
`LIB-16.2` breach and D-9, not the gap count.

---

## 7. Signature block

Not pre-filled. Signing is a human act and no signature is fabricated here.

| Role | Decisions owned | Signature | Date |
|---|---|---|---|
| **Product Owner** | D-5, D-3a, D-16 | ✅ **DECIDED — recorded §2** | **2026-08-04** |
| **Security Platform** | D-1, D-2 *(input — advisable, not required)* | ______________________ | __________ |
| **Architecture Owner (ARB)** | D-6, D-4, D-7, D-9, D-9a, D-17, D-8, `ATT-GAP-015` half | ______________________ | __________ |
| **Principal Enterprise Architect** | D-13 co-signature | ______________________ | __________ |
| **Independent reviewer** | D-13 co-signature | ______________________ | __________ |

**Product Owner row recorded as a decision, not a transcribed personal signature.** No name
is written: `PRD_OWNERSHIP_MODEL.md` §7 rule 4 — *"**Never** record a personal name"* — and
§6 rule 3 — *"**No row names a person.**"* The authority is the role, and the role has ruled.

**D-3 is struck from the Security Platform row.** D-3a = V3 removes `ATT-CFG-014` from V1, so
the one item for which `ADR-0021` L7 made security input *"required"* is no longer owed for
this freeze. What remains for `005`/`006` is described by §4 Option A as *"**advisable**"* —
which is why §4 below now records that the Product Owner may supply those two directly.

---

## 8. Freeze determination — this run

Re-measured **2026-08-04, after the PRODUCT OWNER FINAL APPROVAL instruction** supplied the
three outstanding allowed ranges — `ATT-CFG-005` **15–120 s**, `ATT-CFG-006` **30–300 s**,
`ATT-CFG-019` **0.80–1.00** — completing a set whose defaults (30 s / 60 s / 0.90), scope
rulings (Dynamic QR = V1, OCR = V1, Face = V3) and D-5/D-3a/D-16 approvals were already
recorded. Every row below was re-measured against the repository in this run, not carried
forward from the previous one.

| # | Condition | Status |
|---|---|---|
| 1 | `ATT-CFG-005` **default** | ✅ **30 s** — verified `30 > 0`, `30 ≤ 60` |
| 2 | `ATT-CFG-006` **default** | ✅ **60 s** — verified `60 ≥ 30` |
| 3 | `ATT-CFG-019` **default** | ✅ **0.90** — verified `0 ≤ 0.90 ≤ 1` |
| 4 | `ATT-CFG-011`/`012`/`023` defaults + ranges | ✅ complete and re-confirmed |
| 5 | `ATT-CFG-014` envelope | ✅ **CLEARED by D-3a** — V3; no V1 default owed |
| 6 | **`LIB-16.2` sentence 1** — *"every setting MUST have a documented default"* | ✅ **SATISFIED 24/24** |
| 7 | **Allowed ranges for `005`, `006`, `019`** | ✅ **15–120 s · 30–300 s · 0.80–1.00** — each endpoint *and* each default verified against its own register predicate, and `005`/`006` verified mutually |
| 8 | `ATT-GAP-017` closure | ✅ **12 of 12 = 100% — RESOLVED**; `LIB-16.2` satisfied in **both** sentences |
| 9 | §16.3 amended → v1.4 | ✅ **DONE** — six *Default* + six *Allowed domain* cells written, `ATT-CFG-014` = *Not in V1*; Stage 5 and Stage 6 both re-run **PASS** |
| 10 | `ADR-0021`/`0022`/`0023` dispositions | ⛔ all three still `Proposed` — **re-read this run** at L5 of each file: *"Proposed — not binding"* |
| 11 | `ATT-GAP-015` closure (Face V3) | ⛔ **PO half ✅ / ARB half ⛔** — L2175 owner is a conjunction |
| 12 | D-9 governance confirmation | ⛔ *"not asserted as settled"* |
| 13 | Admitting ADR for `BC-03` | ⛔ does not exist; needs **PEA + independent reviewer** beside D-16 |
| 14 | `DOCUMENTATION_BASELINE.md` §3 row | ⛔ **0** rows for `attendance-management` |
| 15 | `PRD_REGISTRY.md` status | ⛔ `` `PLANNED` `` (L236) |

**Verdict: ⛔ NOT FROZEN — nine of fifteen conditions are now satisfied, and the six that
remain are all held by a single party that is not the Product Owner.**

| Measure | Previous run | **This run** |
|---|---|---|
| **Defaults supplied** | 6 of 6 | ✅ **6 of 6 — COMPLETE** |
| **Allowed ranges supplied** | 3 of 6 | ✅ **6 of 6 — COMPLETE** |
| `ATT-GAP-017` answers | 9 of 12 = 75.0% | ✅ **12 of 12 = 100% — RESOLVED** |
| `LIB-16.2` sentence 1 | ✅ satisfied 24/24 | ✅ **satisfied 24/24** |
| `LIB-16.2` sentence 2 | 🟡 latent only | ✅ **satisfied on two independent grounds** |
| §16.3 amended | ⛔ blocked | ✅ **v1.4, one coherent amendment** |
| Conditions satisfied | 6 of 15 | ✅ **9 of 15** |
| **Product Owner conditions outstanding** | 3 | ✅ **0 — the role is fully discharged** |
| Architecture-Owner-side conditions outstanding | 6 | ⛔ **6 — unchanged, and unchangeable from here** |

**The blocking set is now single-party.** Conditions 10, 11, 12, 13, 14 and 15 all require the
**Architecture Owner** or a co-signature the Architecture Owner's process produces. There is no
longer any product-side decision, value, range or scope ruling that would move any of them:

1. **Conditions 10 / 11 / 12** — `ADR-0021`, `ADR-0022` and `ADR-0023` acceptance; the
   **architecture-owner half** of `ATT-GAP-015` (its §32 owner cell is the conjunction
   *"Product owner + architecture owner"*, and only the first half has ruled); and the **D-9**
   governance reading, which `ADR-0021` §5 records as *"a supported reading… not asserted as
   settled"*.
2. **Condition 13** — the admitting ADR for `BC-03`, which needs the **Principal Enterprise
   Architect** and an **independent reviewer** beside the already-recorded D-16.
3. **Conditions 14 / 15** — the `DOCUMENTATION_BASELINE.md` §3 row at an assigned precedence
   rank (measured **0** rows for `attendance-management` this run) and the `PRD_REGISTRY.md`
   status, still `` `PLANNED` `` at L236. Both are *conferred*, per `PRD_LIFECYCLE.md`:
   *"Freeze is **conferred, not claimed**."*

> **Why the Product Owner cannot take this further, stated plainly.** `PRD_OWNERSHIP_MODEL.md`
> §2.2 gives the Product Owner *"whether a requirement is correct and in scope"* and gives the
> Architecture Owner *"ADR approval; any Rank 1–5 document change; every §11 exception"*, with
> §5 adding *"**Only the Architecture Owner approves.**"* The value decisions recorded in this
> sheet were inside product authority and have been executed in full. The remaining six are
> outside it. Supplying them from here would be fabricating an approval, which is the one thing
> this package exists to avoid.

---

## 9. What this package did **not** do

| Boundary | Held |
|---|---|
| Guess or appoint a person | ✅ Roles only; §7 rule 4 respected |
| Choose a missing value or range | ✅ Every blank left blank; the OTP figures explicitly refused |
| Accept or reject an ADR | ✅ All three left `Proposed` |
| Fabricate a signature or tick | ✅ 0 ticked boxes; §7 blanks unfilled |
| Invent a role, authority, rule or shortcut | ✅ Only Architecture Owner, Product Owner, Security Platform — all pre-existing |
| Weaken a gate | ✅ `ALLOWED` lists untouched; no gate re-run until it agreed |
| Modify `PRD-006`, Registry, Baseline, ADRs or frozen documents | ✅ 0 changes — 12 protected hashes re-verified |
| Code / API / DB change | ✅ 0 — documentation only |
| Create further investigation files | ✅ One consolidated package, as instructed |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-08-04 | **The three outstanding allowed ranges recorded; every Product-Owner-owned condition on this sheet is now discharged.** D-1 `ATT-CFG-005` **15–120 s**, D-2 `ATT-CFG-006` **30–300 s**, D-4 `ATT-CFG-019` **0.80–1.00**, all Product Owner, 2026-08-04. Each was verified against the validation predicate stated in its own §16.3 row at **both endpoints and at the default** — nine checks, all passing — and `005`/`006` were verified **mutually**, since each predicate references the other. One computed observation is **disclosed and deliberately left unrepaired**: across the full ranges, rotation `120 s` with validity `30 s` violates *"≤ validity window"*; narrowing an approved endpoint would change a Product-Owner approved value and adding a cross-setting guard would invent a rule, so neither was done — `LIB-16.3` already rejects that combination before persistence, and the §8.1 GPS-ratio precedent is followed. `ATT-CFG-019`'s `0.80–1.00` is recorded as a **genuine narrowing of the type**, closing the `0.01` risk `ADR-0021` §2.3 named. `ATT-GAP-017` moves **9 of 12 → 12 of 12 = 100%, RESOLVED**, and `LIB-16.2` is satisfied in **both** sentences. Header updated to the amended subject document: **v1.4 DRAFT**, sha256 **`28965ddbb4480a50`** (from `93ab1c60d740c4e0`) — the move is what re-triggers Stage 4. §8 re-measured **6 of 15 → 9 of 15** satisfied, with conditions 10/11/14/15 **re-read from the repository this run** rather than carried forward: three ADRs still `Proposed` at L5 of each file, **0** baseline rows for `attendance-management`, registry still `PLANNED` at L236, `ATT-GAP-015`'s owner still a conjunction with the architecture-owner half open. The blocking set is now recorded as **single-party** — all six remaining conditions are Architecture-Owner-side — and **Product Owner conditions outstanding = 0**. Also records the `ATT-CFG-005` = 30 s coincidence with `Authentication_PRD_v2.md` L72 as raising rather than lowering the §2.1 prohibition. **No approval, signature, authority, value, range or governance rule was invented; no ADR was accepted; no ranked document was modified; no gate script was touched.** |
| **v1.1** | 2026-08-04 | *(Row added retrospectively in v1.2 — the v1.1 edit updated the header to v1.1 but did not append its own change-history row. Recorded here rather than silently corrected.)* Registered the six Product Owner **defaults** (`ATT-CFG-005` 30 s, `006` 60 s, `019` 0.90 alongside the pre-existing `011`/`012`/`023`), the scope rulings **Dynamic QR = V1**, **OCR = V1**, **Face = V3** (`D-3a`), and **D-5 / D-3a / D-16 = APPROVED**. Struck D-3 from the Security Platform row, since D-3a removes `ATT-CFG-014` from V1. Recorded `LIB-16.2` sentence 1 as **satisfied 24/24 for the first time**, `ATT-GAP-017` at **9 of 12**, and the freeze determination at **6 of 15** conditions satisfied, with the three allowed ranges left explicitly **⛔ NOT SUPPLIED** rather than derived. |
| **v1.0** | 2026-08-04 | Created as the single consolidated human-decision handoff, replacing further investigation documents. Consolidates **all** remaining `PRD-006` decisions into one sheet: D-1 `ATT-CFG-005`, D-2 `ATT-CFG-006`, D-3 `ATT-CFG-014` envelope, D-3a Face V1-vs-V3, D-4 `ATT-CFG-019`, D-5 `ADR-0021` D-1 route, D-6 `ADR-0023`, D-7 `ADR-0022`, D-8 Security Platform binding, D-9 `ADR-0021` D-2, D-9a where D-2 sits, D-10…D-15 the mechanical amendment/gate/baseline/registry chain, D-16/D-13 admitting-ADR authorisation, D-18 freeze. Dependency order given as a graph with three load-bearing orderings (D-6 → D-4; D-8 → D-1/D-2; D-1 → D-2 per *"Must be ≥ rotation interval"*). Uses only the three pre-existing roles and records **no personal name**, per §7 rule 4. Preserves the three PO decisions unchanged and discloses that they are **not yet in §16.3**, transferring at D-10 with the other four rows. Records the forbidden OTP borrow (`ADR-0021` §2.1) so it is not re-proposed, the 14-answer arithmetic (6 available), the ten dependent *"seven configurables"* statements, the independent `LIB-16.2` breach (`ADR-0021` L286; 0 precedent for freezing with a live Rank 3 breach), and — in the PRD's favour — that **PRD-006 passes the `ADR-0020` L128 determinism test**, so open gaps alone would not bar freeze. Freeze determination: **NOT FROZEN**, 12 conditions blocking, measured at 0 ticked approvals / 32 open boxes / 0 signed commits / all seven §16.3 rows *"unresolved"*. No value chosen, no ADR accepted, no signature fabricated, no authority invented, no gate weakened, no ranked document modified. |
