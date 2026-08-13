# `PRD-006` — Human Decision Handoff Package

| Field | Value |
|---|---|
| **Document** | The single consolidated decision sheet for [`PRD-006_ATTENDANCE-MANAGEMENT.md`](PRD-006_ATTENDANCE-MANAGEMENT.md) v1.3 DRAFT (sha256 `93ab1c60d740c4e0`) |
| **Result** | ⛔ **NOT FROZEN.** No human decision has arrived. Measured this run: **0** genuine ticked approvals, **32** unticked decision boxes, **0** signed commits, and all **seven** §16.3 rows still read *"— unresolved"* |
| **Purpose** | One place where every remaining `PRD-006` decision can be made by its existing role-holder. Replaces the need for any further investigation document |
| **Supersedes as the operative sheet** | `PRD-006_CONSOLIDATED_DECISION_PACKAGE.md` · `PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST.md` · `PRD-006_ATT-GAP-017_DECISION_SHEET.md` — all retained as evidence, none contradicted |
| **Roles used** | **Architecture Owner (ARB)** · **Product Owner** · **Security Platform** — all three pre-existing. **No new role, authority, person, rule, value or range is created** |
| **Version** | v1.0 |

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

### D-5 · `ADR-0021` D-1 — by what route are the seven defaults *and ranges* established?

`ADR-0021` §4 costs four options and recommends none. Choose exactly one:

- ☐ **Option A** — The owner supplies the seven values and their ranges directly
- ☐ **Option B** — Commission an anchored analysis; the owner ratifies its output
  *(§4 note: "Whoever the owner commissions produces the anchors; **the product owner still ratifies.** An anchor is evidence, not authority")*
- ☐ **Option C** — `PRD-006` supplies the **envelopes**; `CONFIGURATION_GUIDE.md` supplies the **values**
- ☐ **Option D** — Descope the affected capabilities from V1

**Note on arithmetic.** `ATT-GAP-017` (L2178) asks for *"the **default values and allowed
ranges**"* for seven settings = **14 answers**. Three defaults and three ranges exist
(§3 below) = **6**. Whichever option is chosen must produce the remaining **8**.

### D-3a · `ATT-CFG-014` — is Face attendance V1 at all?

`ATT-GAP-015` (Owner: *"Product owner + architecture owner"*) records the conflict: EA
v2.1 lists `Face Recognition (V3)`; the product instruction says V1. A prior Face V3
decision is on record and **preserved unchanged** — but it has never been **ratified by
ARB**, so it is carried, not resolved.

- ☐ Confirm **Face is V3** → `ATT-CFG-014` needs no V1 value; `ATT-GAP-017` drops to 12 answers
- ☐ Confirm **Face is V1** → `ATT-CFG-014` needs a default + envelope (D-3)

### D-16 · Admitting-ADR co-authority

Per `ADR-0018`/`0019`/`0020`, freeze authorisation is *"**Product owner** (freeze
authorisation); **Principal Enterprise Architect**; independent reviewer."*

- ☐ Product Owner authorises freeze *(only after D-10 … D-12 pass)*

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

---

## 4. Decisions for **Security Platform**

**Precondition D-8.** The role is registered at `PRD_OWNERSHIP_MODEL.md` **L180**
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

- ☐ Default: `__________` · ☐ Allowed range: `__________`

### D-2 · `ATT-CFG-006` — Dynamic QR validity window

| Field | Value |
|---|---|
| Current §16.3 (L1160) | Default `ATT-GAP-017` · Domain **`Bounded duration — unresolved`** · Validation *"Must be ≥ rotation interval"* |
| Constraint | Must be **≥ D-1**. Decide D-1 first |

- ☐ Default: `__________` · ☐ Allowed range: `__________`

> **Forbidden source, recorded so it is not re-proposed.** `Authentication_PRD_v2.md` L92
> carries *"OTP challenge validity | 5 minutes"* and L72 *"Minimum interval between OTP
> requests | 30 seconds"*. `ADR-0021` §2.1 pre-adjudicates the borrow: *"Same word,
> different threat model, different bounded context, different owner. Borrowing the number
> would import a security parameter across a context boundary and **dress an invention as
> a citation**."* These figures **must not** be copied into D-1/D-2.

### D-3 · `ATT-CFG-014` — Face match confidence envelope *(only if D-3a = V1)*

Requires **Security input + ARB ratification** (`ADR-0021` L7: *"security input required
for `ATT-CFG-014`"*; `ATT-GAP-012` owner: *"Architecture owner + Security Platform"*).

`ADR-0021` §2.3 states why a type is not an envelope: *"`Bounded 0–1` is a **type**, not a
range: it excludes `1.7` but admits `0.01` and `0.99` equally, and a face-match threshold
of `0.01` authorises impersonation."*

- ☐ Allowed range: `__________` · ☐ Default within it: `__________`

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

- ☐ Allowed domain: `__________` · ☐ Default within it: `__________`

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
| **Product Owner** | D-5, D-3a, D-16 | ______________________ | __________ |
| **Security Platform** | D-1, D-2, D-3 *(input)* | ______________________ | __________ |
| **Architecture Owner (ARB)** | D-6, D-4, D-7, D-9, D-9a, D-17, D-8 | ______________________ | __________ |
| **Principal Enterprise Architect** | D-13 co-signature | ______________________ | __________ |
| **Independent reviewer** | D-13 co-signature | ______________________ | __________ |

---

## 8. Freeze determination — this run

| # | Condition | Status |
|---|---|---|
| 1 | `ATT-CFG-005` default + range | ⛔ absent |
| 2 | `ATT-CFG-006` default + range | ⛔ absent |
| 3 | `ATT-CFG-014` envelope + ARB ratification | ⛔ absent |
| 4 | `ATT-CFG-019` default + domain | ⛔ absent |
| 5 | `ATT-CFG-011`/`012`/`023` in §16.3 | ⚠️ values decided, **not yet in the PRD** (transfer at D-10) |
| 6 | `ADR-0021`/`0022`/`0023` dispositions | ⛔ all `Proposed` |
| 7 | D-2 governance confirmation | ⛔ *"not asserted as settled"* |
| 8 | `LIB-16.2` breach cleared | ⛔ 6 of 14 answers |
| 9 | Admitting ADR | ⛔ does not exist |
| 10 | `DOCUMENTATION_BASELINE.md` §3 row | ⛔ 0 rows for `attendance-management` |
| 11 | `PRD_REGISTRY.md` status | ⛔ `` `PLANNED` `` |
| 12 | Human decisions available in-repo or via directory | ⛔ **0 ticked approvals, 32 open boxes, 0 signed commits** |

**Verdict: ⛔ NOT FROZEN.** Twelve conditions blocking; **D-0** (an Architecture Owner
existing in the external team directory) gates the resolution of every one.

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
| **v1.0** | 2026-08-04 | Created as the single consolidated human-decision handoff, replacing further investigation documents. Consolidates **all** remaining `PRD-006` decisions into one sheet: D-1 `ATT-CFG-005`, D-2 `ATT-CFG-006`, D-3 `ATT-CFG-014` envelope, D-3a Face V1-vs-V3, D-4 `ATT-CFG-019`, D-5 `ADR-0021` D-1 route, D-6 `ADR-0023`, D-7 `ADR-0022`, D-8 Security Platform binding, D-9 `ADR-0021` D-2, D-9a where D-2 sits, D-10…D-15 the mechanical amendment/gate/baseline/registry chain, D-16/D-13 admitting-ADR authorisation, D-18 freeze. Dependency order given as a graph with three load-bearing orderings (D-6 → D-4; D-8 → D-1/D-2; D-1 → D-2 per *"Must be ≥ rotation interval"*). Uses only the three pre-existing roles and records **no personal name**, per §7 rule 4. Preserves the three PO decisions unchanged and discloses that they are **not yet in §16.3**, transferring at D-10 with the other four rows. Records the forbidden OTP borrow (`ADR-0021` §2.1) so it is not re-proposed, the 14-answer arithmetic (6 available), the ten dependent *"seven configurables"* statements, the independent `LIB-16.2` breach (`ADR-0021` L286; 0 precedent for freezing with a live Rank 3 breach), and — in the PRD's favour — that **PRD-006 passes the `ADR-0020` L128 determinism test**, so open gaps alone would not bar freeze. Freeze determination: **NOT FROZEN**, 12 conditions blocking, measured at 0 ticked approvals / 32 open boxes / 0 signed commits / all seven §16.3 rows *"unresolved"*. No value chosen, no ADR accepted, no signature fabricated, no authority invented, no gate weakened, no ranked document modified. |
