# `PRD-006` Attendance Management — Stage 4 Requirements **Re-Review**

| Field | Value |
|---|---|
| **Lifecycle stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` L108–119) — **re-review** |
| **Subject** | `PRD-006_ATTENDANCE-MANAGEMENT.md` **v1.3 — DRAFT** |
| **Subject hash at re-review** | `93ab1c60d740c4e0fe8c82828556491a3f43d77ed47cb7e2b43ef106464ab97b` |
| **Hash at the original review** | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` (**v1.2**) — **different document** |
| **Why this exists** | `PRD-006_REQUIREMENTS_REVIEW.md` L14: *"A Stage 4 **re-review** remains for an independent reviewer"* |
| **Status of this file** | **Unranked.** A review record. Where it disagrees with the PRD, **the PRD is right and this file is a defect** |
| **Mandate** | Stage 4 only. **Read-only** — no document was modified, no ADR created, no gap closed, nothing frozen |
| **Verdict** | ⚠️ **CONDITIONALLY PASSED** — 5 of 6 checks PASS · check 3 🔴 **FAILS** · the **gate** is ✅ **SATISFIED** |

> **This verdict was established independently, not inherited.** It coincides with the v1.2 verdict. That
> coincidence is a *result*, not a starting assumption — §1 records why a re-review was owed, and §2 re-measures
> all six checks from the current bytes. **A verdict is not upgraded because documents were added around the PRD.**

---

## 1. Whether a re-review was required — the determination

Two facts settle it, and the second is decisive.

| Fact | Evidence |
|---|---|
| The Stage 4 record **says** one is outstanding | `PRD-006_REQUIREMENTS_REVIEW.md` L14, verbatim above |
| **The reviewed document no longer exists** | The review names subject hash `600c59ec…` (**v1.2**). The current file is `93ab1c60…` (**v1.3**) |

The correction record is explicit about the size of the change: **134 insertions, 28 deletions**, line count
2260 → **2366**, and the registers grew — `ATT-FR` 148 → **151**, `ATT-BR` 42 → **45**, `ATT-AC` 209 → **213**,
total 506 → **516**, obligation-bearing 279 → **285**.

**Ten new obligations have never been reviewed by any Stage 4 reviewer**: `ATT-FR-149`, `ATT-FR-150`,
`ATT-FR-151`, `ATT-BR-043`, `ATT-BR-044`, `ATT-BR-045`, and four new `ATT-AC-*`.

The correction record re-verified *counts and coverage* — and said so honestly — but drew the line itself:

> *"This review's verdict and findings below are **left exactly as issued**; the correction record is a separate
> artefact and **does not re-verdict this one**."*

**A re-review is therefore owed.** It is owed because the subject changed, not because the previous verdict was
unsatisfying.

### 1.1 What did *not* trigger it

Recorded so the trigger is not overstated. None of the following would have justified a re-review, and none is
relied on: the four documents created in Phases 2–4; the two `Proposed` ADRs; the Face V3 product decision (ARB
pending); or the Stage 5/6 gate runs. **No requirement changed in any of them.** The trigger is the v1.2 → v1.3
delta alone.

---

## 2. The six checks, re-measured from v1.3

| # | Check | Verdict | Method |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | §2.1 |
| 2 | Every exclusion states what must be **impossible** | ✅ **PASS** | §2.2 |
| 3 | Every configurable has a default **and** a range | 🔴 **FAIL** | §2.3 |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** | §2.4 |
| 5 | No requirement restates another PRD's | ✅ **PASS** | §2.5 |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | §2.6 |
| — | **The gate** — conflicts closed or explicitly deferred **with a reason and an owner** | ✅ **SATISFIED** | §3 |

### 2.1 Check 1 — testability ✅ PASS

151 `ATT-FR-*` scanned for unverifiable constructions (*"should be fast"*, *"user-friendly"*, *"appropriate"*,
*"reasonable"*, *"as needed"*, *"etc."*). **Zero hits.**

The three new requirements were read individually, since a scan cannot judge them:

* **`ATT-FR-149`** — a mode whose required setting is unresolved and unconfigured **MUST NOT** be enableable.
  Testable: attempt to enable it and assert refusal.
* **`ATT-FR-150`** — no attendance may be recorded, accepted or rejected by evaluating a valueless setting.
  Testable: assert no record is produced on that path.
* **`ATT-FR-151`** — the Owner **MUST** be shown at configuration time that a setting has no platform default.
  Testable: assert the disclosure is present.

**All three are observable.** Notably, none of them invents a value — they specify behaviour *in the absence* of
one, which is why they mitigate `RQ-1` without resolving it.

### 2.2 Check 2 — exclusions state impossibility ✅ PASS

**22** `ATT-XC-*` definitions. All 22 carry `MUST NOT` / `SHALL NOT`.

One apparent exception was inspected rather than counted: **L2345** matches an `ATT-XC-010` pattern but is a §33
back-reference (*"`ATT-XC-010` (§7.1) is the binding rule"*), not a definition. The definition at **L492** reads
*"V1 **MUST NOT** define a seventh mode… and **MUST NOT** appear as a V1 mode, requirement, configurable, event or
acceptance criterion."* **A citation is not a definition** — the same principle the collision gate applies.

### 2.3 Check 3 — default and range 🔴 **FAIL**

**24** configurables. **7** carry `ATT-GAP-017` in the Default column and therefore have neither a default nor a
range:

| L | ID | Setting |
|---|---|---|
| 1159 | `ATT-CFG-005` | Dynamic QR rotation interval |
| 1160 | `ATT-CFG-006` | Dynamic QR validity window |
| 1165 | `ATT-CFG-011` | GPS acceptance radius |
| 1166 | `ATT-CFG-012` | Minimum acceptable location accuracy |
| 1168 | `ATT-CFG-014` | Face match confidence |
| 1173 | `ATT-CFG-019` | OCR high-confidence threshold |
| 1177 | `ATT-CFG-023` | Correction window |

**17 of 24 pass; 7 fail — unchanged from v1.2.** The PRD names it at L1188: *"**This is a live breach of
`LIB-16.2`**."*

> **A counting note, because the raw grep misleads.** `grep -cE '^\| .*ATT-CFG-[0-9]{3}'` returns **30**. Six of
> those (L1139–1144) are a *mode → configurable* mapping table citing IDs defined at L1155+. Unique IDs: **24**,
> matching the register and the Stage 5 gate. **The discrepancy was resolved by inspection, not by preferring the
> number that agreed with the register.**

**`ATT-CFG-014` is still counted.** The Product Owner has ruled Face = V3, but ARB approval is ⏳ **PENDING**, and
a Stage 4 check measures the document as it stands. **The measured breach today is seven, not six.**

### 2.4 Check 4 — every AC maps to a requirement ✅ PASS

Measured mechanically by `tool/docs_check/prd006_traceability.py` rather than by hand: **213 AC rows / 328
Verifies citations · dangling references 0 · orphan criteria 0.**

### 2.5 Check 5 — no restatement of another PRD ✅ PASS

The v1.3 additions were checked specifically, since restatement risk rises when text is added late.
**`ATT-BR-045`** — *"Neither module **SHALL** hold a shadow copy of the other's system of record"* — is a boundary
assertion **against** duplication, and `ATT-BR-044` performs a `LIB-16.2` compliance *check* without restating
`LIB-16.2` as an attendance requirement. Cross-register collision scan: **0 collisions outside the module.**

### 2.6 Check 6 — no contradiction of Rank 1 ✅ PASS

The single `contradict` hit (L1544) is a *prohibition* — derived figures **MUST NOT** be used to contradict the
attendance aggregate — not a contradiction.

`ATT-BR-045` and `ATT-FR-149`…`151` were tested against Rank 1 `MP-GBR-*`. **No conflict.** The `LIB-16.2` breach
is with **Rank 3**, not Rank 1, and check 6 concerns Rank 1.

---

## 3. The gate ✅ SATISFIED

`PRD_LIFECYCLE.md` L119: *"conflicts closed or explicitly deferred **with a reason and an owner**."*

**The gate is not the six checks.** A check may fail while the gate holds, provided the failure is deferred
properly. Check 3's failure is:

| Requirement | Evidence |
|---|---|
| **Named** | `ATT-GAP-017`, in the §32 register |
| **Reasoned** | *"No Rank 1–5 source. `LIB-16.2` requires every setting to have a documented default"* |
| **Owned** | **Product owner** |
| **Not concealed** | L1188 calls it *"a live breach"* — the only such self-declaration in any module PRD |
| **Not resolved by invention** | `ATT-BR-043` forbids substitution; the seven settings are blocked from use |

That is the textbook shape of an explicit deferral. **The gate holds — and it held for the same reason at v1.2.**

---

## 4. Why the verdict is not upgraded

Stated plainly, because the instruction warns against exactly this:

| Tempting argument | Why it is rejected |
|---|---|
| *v1.3 added `ATT-FR-149`…`151`, so the configurables issue is handled* | They specify behaviour **in the absence** of a value. Check 3 asks for a **default and a range**. Seven still have neither |
| *Face is V3 now, so `ATT-CFG-014` shouldn't count* | ARB approval is **pending**. A check measures the document, not an anticipated one |
| *Stage 5 and Stage 6 both PASS* | Different gates, different questions. Neither tests defaults |
| *`ADR-0022`/`ADR-0023` now exist* | Both **`Proposed`**, both decide nothing, and neither concerns `ATT-GAP-017` |
| *Four governance documents were produced* | **None changed a requirement.** Documents about a PRD do not improve it |

**No finding from the original review was reopened, and no new finding is raised.** The v1.3 additions are sound;
they simply do not address check 3, and the correction record already said they would not — *"`RQ-1` **MITIGATED
— not resolved**."*

---

## 5. What this re-review did not do

| Not done | Why |
|---|---|
| Upgrade the verdict | §4. Check 3 fails on measurement |
| Downgrade it | Nothing regressed; the ten new obligations are sound |
| Propose a default or range | `ATT-BR-043`; §0.4. **Zero values appear in this document** |
| Close `ATT-GAP-017` or any gap | Owner decisions. `ATT-GAP-017` remains 🔴 OPEN |
| Modify `PRD-006` | Read-only. Hash unchanged |
| Re-verdict the v1.2 review | It stands as issued against the document it examined |
| Confer Stage 7 or freeze anything | Stage 7's gate is a baseline row |

---

## 6. Verification

| Claim | Method | Result |
|---|---|---|
| Subject differs from the reviewed document | `sha256sum` vs recorded hash | `93ab1c60…` ≠ `600c59ec…` ✅ |
| 24 configurables, 7 valueless | grep + inspection of the 6 mapping rows | **24 / 7** ✅ |
| 22 exclusions, all prohibitive | grep + inspection of L2345 | **22 / 22** ✅ |
| 0 orphan criteria, 0 dangling | `prd006_traceability.py` | **exit 0** ✅ |
| 0 collisions | same | **0** ✅ |
| No untestable phrasing | 151 `ATT-FR-*` scanned | **0 hits** ✅ |
| `PRD-006` unmodified | `sha256sum` after | `93ab1c60d740c4e0` ✅ |
| Zero values proposed | scan for numerics near `ATT-CFG-*` | **none** ✅ |

---

## 7. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as the **independent Stage 4 re-review** the original review left outstanding at L14. Establishes first that a re-review was genuinely **owed** — the v1.2 review names subject hash `600c59ec…` while the current file is `93ab1c60…`, so **the reviewed document no longer exists** and ten obligations added by the correction pass (`ATT-FR-149`…`151`, `ATT-BR-043`…`045`, four `ATT-AC-*`) have never been examined by any Stage 4 reviewer. Records what did **not** trigger it, so the trigger is not overstated. Re-measures all six checks from the current bytes: **5 PASS, check 3 FAILS at 7 of 24 configurables**, gate **SATISFIED**. Resolves a raw-grep discrepancy of 30 vs 24 CFG rows **by inspection** — six rows at L1139–1144 are a mode-mapping table citing IDs defined later — and an apparent 22nd exclusion without a prohibition verb, which proved to be a §33 back-reference to `ATT-XC-010`, whose definition at L492 does carry **MUST NOT**. Counts `ATT-CFG-014` in the breach **because ARB approval of Face V3 is pending** and a check measures the document as it stands, giving **seven**, not six. **Verdict ⚠️ CONDITIONALLY PASSED, established independently rather than inherited**, and §4 records five tempting arguments for upgrading it and rejects each — most importantly that `ATT-FR-149`…`151` specify behaviour *in the absence* of a value and so do not satisfy a check that asks for a default and a range. **No value proposed, no gap closed, no finding reopened, `PRD-006` unmodified, nothing frozen.** |
