# `ATT-GAP-017` — Owner Decision Request: the six remaining V1 configurables

| Field | Value |
|---|---|
| **Document** | `ATT-GAP-017` Owner Decision Request |
| **Version** | v1.0 |
| **Date** | 2026-08-04 |
| **Scope** | `ATT-CFG-005` · `006` · `011` · `012` · `019` · `023` — **six**, after the Face V3 product decision removes `ATT-CFG-014` on ARB approval |
| **Source** | `PRD-006_ATT-GAP-017_DECISION_SHEET.md` v1.0 · `PRD-006_ATT-GAP-015_DECISION_RECORD.md` v1.0 — sole sources |
| **`ATT-GAP-017` status** | 🔴 **OPEN — unchanged** |
| **Values proposed here** | **Zero** |

> **Why this document exists.** Phase 3 tested whether any owner decision exists for the six. **None does** —
> all six still carry `ATT-GAP-017` in their Default column, and no decision record names any of them. This is
> the owner-facing request that stops each decision at its owner boundary, following the same
> Pack → Request pattern used for `ATT-GAP-015`.

---

## 1. Scope note — six, not seven, and only conditionally

`ATT-CFG-014` (Face match confidence) is **excluded** from this request because the Product Owner has ruled
Face = **V3**. That exclusion is **conditional on ARB approval**, which is ⏳ **PENDING**.

| State | Settings in the `LIB-16.2` breach |
|---|---|
| **Today** — ARB pending | **7** — `014` still counted |
| On ARB approval | **6** — this request's scope |

**This request addresses the six that are V1 regardless of how `ATT-GAP-015` completes.**

---

## 2. The rule being breached

`LIB-16.2` (Rank 3, `Library_PRD_v1.md` L676): *"Every setting **MUST** have a documented default."*

`ATT-BR-043` forbids the obvious shortcut: a configurable whose Default column names an unresolved gap has
*"**no default value, and no value SHALL be substituted for it** — not zero, not a framework default, not a
value copied from another tenant, another mode, another product or an example in this document."*

---

## 3. The six decisions

Each row states what is required, who owns it, whether it is decidable today, and what blocks it.
**Options and trade-offs are in the Decision Sheet §3 and are not restated here.**

| ID | Setting | Decision required | Owner | Decidable today? | Blocked by |
|---|---|---|---|---|---|
| `ATT-CFG-011` | GPS acceptance radius | A default **and** a bounded range | **Product Owner** (sole) | 🟢 **Yes** | Nothing |
| `ATT-CFG-012` | Min. location accuracy | A default, ideally expressed relative to `011` | **Product Owner** (sole) | 🟢 **Yes** | Nothing |
| `ATT-CFG-023` | Correction window | Whether *"no window"* is the documented default | **Product Owner** (sole) | 🟢 **Yes** | Nothing |
| `ATT-CFG-005` | Dynamic QR rotation interval | A range from Security Platform, then a value | **Product Owner** + **Security Platform** | 🟡 **Partially** | `ATT-GAP-006` — cryptographic construction |
| `ATT-CFG-006` | Dynamic QR validity window | A range and the `006`:`005` ratio, then a value | **Product Owner** + **Security Platform** | 🟡 **Partially** | `ATT-GAP-006` |
| `ATT-CFG-019` | OCR high-confidence threshold | A threshold measurable against a selected engine | **Architecture Owner** (prereq) **then Product Owner** | 🔴 **No** | `ATT-GAP-010`, `ATT-GAP-011`; build-blocked by `ATT-FR-080` |

### 3.1 Evidence available, per setting

| ID | Evidence in the repository | Authoritative value source |
|---|---|---|
| `ATT-CFG-011` | `ATT-FR-042` mandates *"a default **and** a bounded allowed range"* — **a second, independent obligation beyond `LIB-16.2`**; `ATT-FR-046`; `ATT-AC-041` untestable without a range | **None** |
| `ATT-CFG-012` | `ATT-FR-045`; `ATT-AC-038` | **None** |
| `ATT-CFG-023` | `ATT-FR-115` — *"**Where** a correction window is configured"*, conditional phrasing making *"no window"* an already-**defined** behaviour; `ATT-AC-157`; `ATT-BR-040` and `ATT-FR-116` bound the audit risk | **None** — but no number need be invented |
| `ATT-CFG-005` | `ATT-FR-025` requires rotation *"on a configured interval"*; `ATT-FR-149` makes the mode un-enableable without it; `ATT-XC-013` forbids this PRD specifying cryptography | **None** |
| `ATT-CFG-006` | `ATT-FR-024` requires a *"bounded validity window"*; `ATT-FR-026` requires a distinguishable *"expired"* rejection | **None** |
| `ATT-CFG-019` | `ATT-FR-077`; `ATT-BR-027`; blast radius limited by `ATT-BR-028` + `ATT-CFG-020` (default **Disabled**) | **None** — and `ATT-GAP-011` records *no OCR capability is defined anywhere in `docs/**`* |

**No authoritative source exists for any of the six.** That is the finding, re-measured in Phase 3 and
unchanged from `ADR-0021` §2.1.

---

## 4. Consequence of not deciding

| Consequence | Detail |
|---|---|
| `LIB-16.2` stays breached | 6 settings (7 while ARB is pending) |
| `ATT-GAP-017` stays OPEN | Stage 4 gate check 3 continues to FAIL |
| **`PRD-006` cannot be frozen** | Freeze is conferred by a baseline row; the live Rank 3 breach bars it |
| 12 `IMPL-*` tasks stay BLOCKED | `IMPL-630`, `631`, `633`, `634`, `638`, `639`, `643`, `648`, `649`, `667`, `677`, `679` |
| Risk of the wrong fix | `PRD-006` §0.4: *"A gap resolved by implementation choice is not resolved — it is an undocumented architecture decision made by whoever happened to write the code first."* |

---

## 5. What is requested, from whom

### 5.1 Product Owner — three decisions available **today**

> **`ATT-GAP-017` — PARTIAL DECISION (Product Owner).**
> I supply the following defaults and ranges for the V1 attendance configuration surface:
> · `ATT-CFG-011` GPS acceptance radius — default: __________ range: __________
> · `ATT-CFG-012` Minimum location accuracy — default: __________ range: __________
> · `ATT-CFG-023` Correction window — default: __________ range: __________
> Basis for each value: ______________________________________________
> I confirm these are product decisions, not values copied from another product, tenant or mode (`ATT-BR-043`).
>
> Product Owner: ______________________ Date: __________

> **On `ATT-CFG-011`.** It is the only one of the six carrying **two** mandates — `LIB-16.2` *and* `ATT-FR-042`.
> **On `ATT-CFG-012`.** Setting it looser than `011` silently disables the radius check while appearing to
> enforce it. Both values look reasonable in isolation; the Decision Sheet recommends expressing `012`
> *relative to* `011` for that reason.
> **On `ATT-CFG-023`.** This is the only row where **no number need be invented** — *"no window"* is already a
> defined behaviour under `ATT-FR-115`.

### 5.2 Security Platform (Domain Owner, `PRD-012a`) — range for two settings

> **`ATT-GAP-017` — SECURITY RANGE (Security Platform).**
> · `ATT-CFG-005` Dynamic QR rotation interval — permitted range: __________
> · `ATT-CFG-006` Dynamic QR validity window — permitted range: __________ ; permitted `006`:`005` ratio: ______
> I confirm these bound the replay-attack window for a **broadcast display artefact** scanned by many students
> (`ATT-BR-014`), and are **not** transferred from the `BC-18` OTP model, which governs a one-time secret sent
> to a single phone.
>
> Security Platform: ______________________ Date: __________
> Product Owner (value within the range): ______________________ Date: __________

### 5.3 Architecture Owner — prerequisite for the sixth

> **`ATT-CFG-019` is not requested of anyone yet.** It cannot be decided until `ATT-GAP-010` (may `BC-03` hold a
> `FileRef` from `BC-29`?) and `ATT-GAP-011` (who owns OCR/Vision?) are answered by the **Architecture Owner**.
> `ADR-0021` §3 and the Decision Sheet both record that these two need their own ADR. Until then there is no
> engine whose confidence scale a threshold would refer to, and `ATT-FR-080` build-blocks the workflow.

---

## 6. Sequence and what each step closes

| Step | Who | Closes | Breach after (post-ARB basis) |
|---|---|---|---|
| 1 | Product Owner — `023` | 1 of 6 | 5 |
| 2 | Product Owner — `011` + `012` | 3 of 6 | 3 |
| 3 | Security Platform range → Product Owner — `005` + `006` | 5 of 6 | 1 |
| 4 | Architecture Owner — `ATT-GAP-010`/`011`, engine selected, then `019` | 6 of 6 | **0** |

**`ATT-GAP-017` closes only at step 4.** Steps 1–3 close five of six and are unblocked today, but **partial
progress does not make `PRD-006` freezable** — `LIB-16.2` is breached while any one setting lacks a default.

---

## 7. What this request deliberately did not do

| Not done | Why |
|---|---|
| Propose any value or range | `ATT-BR-043`; `PRD-006` §0.4; the instruction. **Zero values appear** |
| Choose between the documented options | Options are in Decision Sheet §3; choosing is the owner's act |
| Resolve `ATT-GAP-017` | It remains 🔴 **OPEN**. Requesting a decision is not making one |
| Resolve `ATT-GAP-006`, `010`, `011` | Each has its own named owner; cited here only as blockers |
| Modify `PRD-006` §16.3 | The Default columns stay as they are until an owner supplies values |
| Create or accept an ADR | Phase 4 determines the ADR position separately |
| Freeze anything | §4 states the freeze consequence; it does not act on it |

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-04 | Created as the Phase 3 owner-boundary artefact after re-measurement confirmed **no owner decision exists for any of the six** — all six still carry `ATT-GAP-017` in their Default column and no decision record names any of them. Scopes to **six**, noting the exclusion of `ATT-CFG-014` is **conditional on ARB approval** of the Face V3 ruling, which is pending, so the measured breach today is still **seven**. States for each setting the decision required, the named owner, decidability, blocking gap and available evidence, and records that **no authoritative value source exists for any of the six**. Supplies three signature blocks — Product Owner for `011`/`012`/`023`, Security Platform plus Product Owner for `005`/`006`, and none for `019`, which is not requestable until the Architecture Owner answers `ATT-GAP-010`/`011`. **Proposes no value and no range.** `ATT-GAP-017` remains OPEN. |
