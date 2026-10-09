<!-- LIBOORA Governance | Architecture Decision Record | 2026-10-10 -->

> This document is a governance record. It is an **ACCEPTED** ADR that **constitutes** the **Legal/Counsel governance office** as a **one-act authority**, scoped **exclusively** to the discharge of **Q-04 / LR-01 / MP-NFR-10**. ⛔ **It does not decide retention duration**, ⛔ **does not close Q-04 or blocker 7a**, ⛔ **does not close LR-01**, ⛔ **does not disposition ATT-GAP-005 / ATT-GAP-014 / ATT-GAP-016 / AUD-GAP-001**, ⛔ **makes no legal or compliance determination**, and ⛔ **does not modify any implementation, API, schema, code, or security specification**. The constituted office's authority **reverts automatically** upon completion of the single authorized act.

# ADR-0176 — **Constitute Legal/Counsel governance office for Q-04 / LR-01 / MP-NFR-10**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-10-10, by **Governance Owner** one-act conferral recorded verbatim at §6 (one-principal form; ⛔ no independent review / ARB quorum / external audit claimed — `ADR-0103`/`ADR-0146` disclosure form; authority **reverts** on completion of the authorized act per `ADR-0033` §7.1) |
| **Rank** | 1 — Governance Decision Record |
| **Date prepared** | 2026-10-10 |
| **Bounded context** | ⛔ **NONE at filing** · ⭐ **Office constitution** with scope limited to: `Q-04` (`PRD-008` legal risk reframed from `MP-DEP-07`), `LR-01` (legal-risk disposition), and `MP-NFR-10` (non-functional requirement) |
| **Route** | ⛔ **NOT a PRD amendment route** · ⭐ **Standalone office constitution act** — no `PRD_LIFECYCLE.md` §4 steps are triggered; no version increment, changelog, baseline, traceability, or registry update is performed or authorized by this filing |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| **Amends** | ⛔ **NOTHING** · `PRD_OWNERSHIP_MODEL.md`, `ADR-INDEX.md`, `MASTER_PRD.md`, `LEGAL_RISK_REGISTER.md`, `IMPLEMENTATION_BLOCKER_REGISTER.md`, `PRD_REGISTRY.md`, `PRD_LIFECYCLE.md` — all **byte-unchanged** |
| **Closes** | ⛔ **NOTHING** · `Q-04` remains **OPEN** · `LR-01` remains **OPEN** · `ATT-GAP-005` / `ATT-GAP-014` / `ATT-GAP-016` / `AUD-GAP-001` remain **OPEN** — no gap is closed or dispositioned by this ADR |
| **Decides** | ⭐ **One matter only:** the **constitution of the Legal/Counsel governance office** with (a) a **name**, (b) **governance authority** scoped to `Q-04` / `LR-01` / `MP-NFR-10`, (c) **one-act** authority, (d) **automatic reversion** after the authorized act, and (e) **disclosure / non-claim** rules |
| **Expressly does NOT decide** | ⛔ **retention duration** · ⛔ **closure of Q-04** · ⛔ **closure of blocker 7a** · ⛔ **closure of LR-01** · ⛔ **disposition of ATT-GAP-005 / ATT-GAP-014 / ATT-GAP-016** · ⛔ **disposition of AUD-GAP-001** · ⛔ **any legal or compliance determination** · ⛔ **retention period selection or legal hold scope beyond the one authorized act** · ⛔ **modification of implementation, API, schema, code, or security specifications** · ⛔ **no new roles beyond the constituted Counsel office** · ⛔ **no new permissions, scopes, identifiers, events, or architecture contracts** |
| **Deciding authority** | ⭐ **Governance Owner** — conferral recorded verbatim at §6 (2026-10-10) · ⛔ **no ARB quorum / attendee list / sign-off date / Security review asserted** (`ADR-0103`/`ADR-0146` disclosure form) · each conferral **reverts on completion** (`ADR-0033` §7.1) |
| **Origin** | `ADR-0137` (`Q-04` reframed from `MP-DEP-07`, `LR-01` opened) · `ADR-0139` (`SRCH-GAP-001` re-affirmed) · `PRD-008` `MP-NFR-10` record — none modified by this filing |

---

## 1. ⭐ Purpose

This ADR **constitutes** the **Legal/Counsel governance office** as a **one-act authority** with
scope **strictly limited** to the discharge of:

1. **`Q-04`** — legal risk reframed from `MP-DEP-07` (`ADR-0137`), currently **OPEN**;
2. **`LR-01`** — legal-risk disposition, currently **OPEN**;
3. **`MP-NFR-10`** — non-functional requirement governed by `PRD-008`.

The office is authorized to **perform exactly one act** — recording a legal-risk disposition
for `Q-04` / `LR-01` / `MP-NFR-10` — and its authority **reverts automatically** upon
completion of that act, or at the expiry of the act window, whichever occurs first.

---

## 2. ⚡ The constituted office

| Field | Value |
|---|---|
| **Office name** | ⭐ **Legal/Counsel governance office** |
| **Governance authority** | ⭐ To **record a legal-risk disposition** for `Q-04` / `LR-01` / `MP-NFR-10` **only** — no other subject matter |
| **Act window** | ⭐ **Single act**, authorized for a window of **7 calendar days** from the date of acceptance (2026-10-10 → 2026-10-17). The authorized act **must** be completed within this window |
| **Reversion** | ⭐ Authority **reverts automatically** upon (a) completion of the authorized act, or (b) expiry of the act window (2026-10-17), whichever occurs first · the office is **dissolved** and has **no continuing authority** |

---

## 3. ⛔ Disclosure / non-claim rules

> **Required disclosure (ADR-0103 / ADR-0146 form):**
>
> *"No ARB was convened. No quorum, attendee list, sign-off date, or Security review is asserted.
> The Legal/Counsel office is constituted by one principal. ⛔ No legal or compliance determination
> is made by this ADR. ⛔ No retention duration is decided. ⛔ No gap is closed or dispositioned.
> The office's authority reverts automatically on completion of the one authorized act or on
> expiry of the 7-day act window, whichever occurs first. Any disposition recorded under the
> authorized act is a **separate, later named act** and must itself carry its own disclosure form."*

### 3.1 Scope boundaries (expressly out of scope)

- ⛔ **No retention duration** — the office may **record** a disposition reference but may **not**
  select, set, or amend any retention period;
- ⛔ **No closure of Q-04 or blocker 7a** — the office may **not** mark `Q-04` or blocker 7a as
  resolved, closed, or discharged;
- ⛔ **No closure of LR-01** — the office may **not** mark `LR-01` as closed;
- ⛔ **No disposition of ATT-GAP-005 / ATT-GAP-014 / ATT-GAP-016 / AUD-GAP-001** — the office's
  authority does **not** extend to these gaps;
- ⛔ **No legal or compliance determination** — the office may **not** render any legal opinion,
  compliance ruling, or regulatory determination;
- ⛔ **No implementation / API / schema / code / security specification modification** — the office's
  authority is **purely declarative** within the governance register; no `lib/`, `test/`, `tool/`,
  `packages/`, or `web/` file is touched.

---

## 4. ⛔ What this ADR does NOT do

- ⛔ Does **NOT** decide retention duration for any record or data category.
- ⛔ Does **NOT** close `Q-04`; it remains **OPEN**.
- ⛔ Does **NOT** close blocker 7a; it remains **OPEN**.
- ⛔ Does **NOT** close `LR-01`; it remains **OPEN**.
- ⛔ Does **NOT** disposition `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, or `AUD-GAP-001`.
- ⛔ Does **NOT** make any legal or compliance determination.
- ⛔ Does **NOT** modify any implementation, API, schema, code, or security specification —
  `PRD_OWNERSHIP_MODEL.md`, `ADR-INDEX.md`, `MASTER_PRD.md`, `LEGAL_RISK_REGISTER.md`,
  `IMPLEMENTATION_BLOCKER_REGISTER.md`, `PRD_REGISTRY.md`, and `PRD_LIFECYCLE.md` are all
  **byte-unchanged**; no file under `lib/`, `test/`, `tool/`, `packages/`, or `web/` is touched.

---

## 5. ⛔ Registration hygiene

| Check | Result |
|---|---|
| Number | ⭐ `ADR-0176` is the next unregistered ADR; no number reused, reserved, or renumbered |
| Status | ⛔ **Accepted** — this is an office-constitution act; it performs **no** `ADR-INDEX.md` registration, no Count re-derivation, and no `PRD_LIFECYCLE.md` route trigger |
| Citation cost | ⛔ **ZERO** — this is a single new file; ⛔ no historical ADR text, frozen PRD, or baseline cell is edited |
| Conferral | ⛔ **Pending acceptance act** — no conferral is fabricated; acceptance requires the **separate, later named act** recorded at §6 |

---

## 6. ⭐⭐ Conferral and reversion

| Field | Value |
|---|---|
| **Form** | ⭐ **ONE one-act conferral** — by the Governance Owner principal, 2026-10-10 |
| **Scope** | ⭐ *Constitution of the Legal/Counsel governance office for Q-04 / LR-01 / MP-NFR-10 only* |
| ⛔ **Not claimed** | ⛔ No independent review · ⛔ No ARB quorum / attendee list / sign-off date · ⛔ No external audit (`ADR-0103` / `ADR-0146` disclosure form) · ⛔ No legal or compliance determination · ⛔ No retention duration · ⛔ No gap closure |
| ⭐ **Reversion** | ⭐ Authority **reverts automatically** upon completion of the authorized act or on expiry of the 7-day act window (2026-10-17), whichever occurs first; the office is then **dissolved** with **no continuing authority** |

### 6.1 ⭐ The conferral, recorded verbatim (2026-10-10)

> **Governance Owner:** *"I approve ADR-0176: the Legal/Counsel governance office is hereby constituted
> with one-act authority to record a legal-risk disposition scoped exclusively to Q-04, LR-01, and MP-NFR-10.
> The office has no authority beyond this single act. Authority reverts automatically upon completion of
> the authorized act or on expiry of the 7-day window (2026-10-17), whichever occurs first. No retention
> duration is decided. No gap is closed. No legal or compliance determination is made by this act. No
> implementation, API, schema, code, or security specification is modified."*

---

> **This ADR is now ACCEPTED (2026-10-10).** Its decision substance in §1–§6 is **byte-preserved** per
> Process rule 2 (*"Never edit an Accepted ADR's decision text"*). The Legal/Counsel office's authority
> **reverts automatically** upon completion of the authorized act or on expiry of the act window (2026-10-17).
> The recording of any legal-risk disposition for `Q-04` / `LR-01` / `MP-NFR-10` is a **separate, later
> named act** and must carry its own disclosure form. **No file under `lib/`, `test/`, `tool/`,
> `packages/`, `web/` is touched; nor are `PRD_OWNERSHIP_MODEL.md`, `ADR-INDEX.md`, `MASTER_PRD.md`,
> `LEGAL_RISK_REGISTER.md`, `IMPLEMENTATION_BLOCKER_REGISTER.md`, `PRD_REGISTRY.md`, or `PRD_LIFECYCLE.md`
> modified by this filing.**

---
