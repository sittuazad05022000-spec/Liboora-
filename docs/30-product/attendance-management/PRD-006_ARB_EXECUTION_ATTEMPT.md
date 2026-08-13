# `PRD-006` — ARB Execution Attempt and Security Path Determination

| Field | Value |
|---|---|
| **Version** | v1.0 · 2026-08-04 |
| **Instruction** | Master Authority → Final Freeze. Step 1 — exercise ARB authority for `ATT-CFG-019`, ratify Face V3, accept/reject `ADR-0021`/`0022`/`0023`, prepare the admitting ADR. Step 2 — resolve the Security path for `ATT-CFG-005`/`006` via `PRD-012a` **or** an ARB reassignment, else report MISSING AUTHORITY. |
| **Result** | ⛔ **NOT FROZEN.** ARB authority **exists** but **cannot be exercised by this reviewer** (§2). Both Security paths tested and **both fail** (§3). |
| **Values recorded** | **None.** No value, range, authority, owner, approval or governance rule was invented. |
| **`PRD-006`** | **NOT amended.** v1.3 DRAFT, sha256 `93ab1c60d740c4e0`, byte-identical. |

---

## 1 · What was attempted

The instruction directs the ARB's authority to be *used*. The prior audit established that the ARB is a real, constituted authority competent over ADR approval and Rank 1–5 changes. This document tests whether that authority can be **exercised here**, and whether either Security path is **available under existing governance**. Both tests are evidential, not argumentative.

---

## 2 · Can this reviewer exercise ARB authority? — Tested, and NO

Every accepted ADR in this repository records **who** decided. Measured, verbatim:

| ADR | `Deciders` field |
|---|---|
| `ADR-0013` | *"**Architecture Review Board**, acting through the **Architecture Owner role** defined in `PRD_OWNERSHIP_MODEL.md` §2.2"* |
| `ADR-0017` | *"**Architecture Review Board**, acting through the **Architecture Owner and Product Owner roles** defined in `PRD_OWNERSHIP_MODEL.md` §2.2"* |
| `ADR-0020` | *"**Product owner** (freeze authorisation); **Principal Enterprise Architect**; independent reviewer"* |

**The ARB is a body of named human role-holders acting through defined roles.** It is not a procedure a document-producing agent can execute on its own authority. `PRD_OWNERSHIP_MODEL.md` L90–95 reinforces this: `ADR-0011` required *"three roles for one decision, precisely because scope, structure and domain correctness are **separable judgements**."*

Writing *"Deciders: Architecture Review Board"* into an ADR and setting its status to `Accepted` — with no role-holder having decided — is precisely the **fake approval** the instruction prohibits. `ADR-0021` names the same hazard: doing so *"would be **inventing governance** — the thing this ADR exists to avoid."*

**Consequence.** ARB authority is **available to the project** but **not exercisable by this operation**. Therefore:

- `ATT-CFG-019` — **not** resolved. Selecting an `ADR-0023` option is an ARB act.
- `ATT-CFG-014` Face V3 — **not** ratified. Per the instruction's own step 3 and CF-3, ratification requires the ARB.
- `ADR-0021`/`0022`/`0023` — **left `Proposed`.** No accept, no reject: rejecting is equally an ARB decision.
- **Admitting ADR — not created.** Its substantive prerequisites are unmet regardless (§4).

Measured confirmation that no ARB assent exists to record: ADR status has only ever been `Proposed` across full git history · **0** commits ever added a ticked approval box · **24** `☐` unticked and **8** blank signature lines in the decision package.

---

## 3 · The two Security paths for `ATT-CFG-005`/`006` — both tested, both fail

The instruction names two candidate paths and asks that a legitimate one be used if it exists.

### 3.1 Path A — open `PRD-012a`. **Governance permits it. It does not deliver the values.**

This path is genuinely authorised, and that must be stated plainly. `PRD_REGISTRY.md` **L272**:

> *"records that the reservation above is the correct and complete expression of that Rank 1 correction, and that **`PRD-012a`/`PRD-012b` may be opened without a further ADR**."*

So opening it needs no ADR. **Three measurements nevertheless defeat this path.**

**1. `SECURITY` is a platform, not a bounded context — so Stage 1 cannot be passed.**
`PRD_LIFECYCLE.md` Stage 1's gate is *"a context identified in the **Bounded Context Map**, not already owned in `PRD_REGISTRY.md` §6."* Searching the BC Map for a security context returns only `BC-18`'s audit event stream (*"Security audit"*), not a security-owning context. `PRD_REGISTRY.md` L242 records `PRD-012`'s owner as **`SECURITY` platform + `BC-28` Workflow** — a *platform* at rank 2, not a `BC-*`. Opening `PRD-012a` therefore cannot clear the Stage 1 gate on the evidence available.

**2. Opening a reservation is not authoring a specification.** L275–276 is explicit: *"`PRD-012` has never been written, so there is no requirement text to divide. **The split is of a *reservation*, not of a specification.**"* Opening `PRD-012a` would produce an empty document with a registry row. It would contain no QR cryptography and no duration envelope.

**3. What `ATT-CFG-005`/`006` actually need is a decision, not a document.** `ATT-GAP-006` reads:

> Question: *"What cryptographic construction secures a dynamic QR code?"* · Source: *"No Rank 1–5 source. **Secrets owned by Security Platform**"* · Owner: *"**Security Platform owner**"*

The blocker is the **owner**, not the filing. Opening `PRD-012a` creates a place to write the answer; it does not create the **Security Platform owner** who must decide it, and this operation cannot appoint one. `PRD_OWNERSHIP_MODEL.md` L285 confirms the assignability finding persists *"**until the split is executed**, not until it is confirmed"* — and execution requires an authoring owner.

**Verdict on Path A: authorised in principle, unavailable in fact.** Opening it here would produce an empty shell and a false impression of progress, while the actual decision remained unmade. Not done.

### 3.2 Path B — ARB reassigns the decision. **No such mechanism exists.**

Searched for any rule permitting the ARB to decide, supply or reassign another owner's *value*:

```
grep -rniE 'ARB (may|can) (decide|supply|set).{0,60}(value|threshold|range)
            |reassign.{0,40}(decision|authority)'  docs/
  →  0 hits  (the only match is this workstream's own prior report)
```

`PRD_OWNERSHIP_MODEL.md` L85 bounds the ARB precisely: it decides *"ADR approval; any Rank 1–5 document change; every §11 exception"*, and its **"Does not decide"** cell reads *"Business scope or priority."* Reassigning *ownership of a context* is an established ARB act — `ADR-0013` and `ADR-0017` both did exactly that, and both are `Accepted`. But **neither supplied a value**; each assigned a context to a platform and left the specification to the new owner.

`ADR-0020` L233 states the governing principle directly:

> *"Each gap belongs to a named owner outside `BC-04` … resolving them here would be **deciding another owner's question**."*

**Verdict on Path B: no mechanism.** Even a properly constituted ARB could reassign *who owns* the QR question; it could not itself answer it without becoming the Security owner.

### 3.3 Determination

> ## ⛔ MISSING AUTHORITY — `ATT-CFG-005`, `ATT-CFG-006`
>
> **Owner:** Security Platform owner (registered at `PRD_OWNERSHIP_MODEL.md` L180; named by `ATT-GAP-006`).
> **Missing decision:** the cryptographic construction (`ATT-GAP-006`) and, derived from it, the default and bounded duration domain for rotation interval and validity window.
> **Dependency:** `PRD-012a` is authorised to open but has no bounded context to claim and no authoring owner; `PRD-012` is *"a placeholder that will never be authored"* (L248).
> **Legitimate resolution path:** a human with Security Platform authority either (a) authors `PRD-012a` and supplies the envelope, or (b) supplies the envelope directly as recorded owner input on the `AR-4` precedent, where *"the deferral lifted because the Library PRD §§1–25 has been received"* — owner input, not reviewer inference.

No QR value or range was invented, borrowed from the Authentication OTP figures, or guessed.

---

## 4 · Why the freeze conditions cannot be reached from here

| # | Freeze condition | State | Blocking |
|---|---|---|---|
| 1 | Seven configurables complete | **6 of 14 answers** (3 PO decisions × default + range) | ⛔ |
| 2 | `ATT-CFG-019` domain + default | ARB decision absent | ⛔ |
| 3 | `ATT-CFG-014` ratified | ARB ratification absent | ⛔ |
| 4 | `ATT-CFG-005`/`006` | **MISSING AUTHORITY** (§3.3) | ⛔ |
| 5 | `ADR-0021`/`0022`/`0023` resolved | all `Proposed`; not exercisable here (§2) | ⛔ |
| 6 | Admitting ADR accepted | not created; prerequisites unmet | ⛔ |
| 7 | `LIB-16.2` satisfied | live Rank 3 breach; **0 of 7** admission ADRs ever froze carrying one | ⛔ |
| 8 | **D-2** confirmed | never put; `ADR-0021` §5 calls its own support *"readings … not asserted as settled"* | ⛔ |
| 9 | Baseline §3 row + rank | absent — and it is **conferred, not claimed** | ⛔ |

**§16.3 was therefore not amended and no version increment was made.** The instruction conditions the amendment on the seven being *"legitimately complete"*; they are at 6 of 14. Amending partially would falsify §16.3's own preamble (which makes *allowed domain* a stated obligation) and the ten dependent "seven" statements — the logged `GCP-01`/`07`/`08` defect class.

**Protected documents were not modified**: `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and `ADR-INDEX.md` are untouched, because each edit requires the governance approval that §2 shows is unavailable.

---

## 5 · Preserved decisions (unchanged)

| ID | Default | Range | Verified |
|---|---|---|---|
| `ATT-CFG-011` | **50 m** | 20–200 m | `20 ≤ 50 ≤ 200` ✅ |
| `ATT-CFG-012` | **30 m** | 5–100 m | `5 ≤ 30 ≤ 100` ✅ |
| `ATT-CFG-023` | **15 min** | 0–60 min | `0 ≤ 15 ≤ 60` ✅ |

No contradictory authority arrived, so none was changed.

---

## 6 · What this document did not do

| # | Not done | Why |
|---|---|---|
| 1 | Did not accept or reject any ADR | ARB not exercisable by this reviewer (§2) |
| 2 | Did not ratify Face V3 | Same |
| 3 | Did not set an OCR domain or default | Same |
| 4 | Did not open `PRD-012a` | Authorised, but no BC to claim, no authoring owner, and it would not yield the values (§3.1) |
| 5 | Did not reassign the QR decision to the ARB | No mechanism exists (§3.2) |
| 6 | Did not invent, borrow or guess a QR value | `ADR-0021` L75–80 pre-adjudicated the OTP borrow as *"dress an invention as a citation"* |
| 7 | Did not amend §16.3 or increment the version | 6 of 14 answers (§4) |
| 8 | Did not touch baseline, registry or ADR-INDEX | Freeze is conferred, not claimed |
| 9 | Did not create a new authority, role or delegation | Instruction; `PRD_OWNERSHIP_MODEL.md` L35 |
| 10 | Did not weaken or modify a gate | Both re-run unmodified at exit 0 |

---

## 7 · Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | ARB execution attempted and found not exercisable by this reviewer — all accepted ADRs record **named human role-holders** as Deciders (`ADR-0013`, `ADR-0017`, `ADR-0020` quoted). Both Security paths tested: Path A (`PRD-012a`) is **authorised without an ADR** per `PRD_REGISTRY.md` L272 but fails on three measurements — `SECURITY` is a platform not a bounded context so Stage 1 cannot pass, the split is *"of a reservation, not of a specification"*, and `ATT-GAP-006` needs an owner's decision rather than a filing. Path B (ARB reassignment) has **0** supporting rules; `ADR-0013`/`0017` reassigned *contexts*, never *values*. **MISSING AUTHORITY** recorded for `ATT-CFG-005`/`006` with owner, dependency and two legitimate resolution paths. Nine freeze conditions listed, all blocking. No value, approval or authority invented. |
