<!-- LIBOORA Governance | Architecture Decision Record | 2026-10-26 -->

> This document is a governance record. It is an **ACCEPTED** ADR that **adopts `GSD Core` as methodology/reference only** — Liboora `PRD-*` (**FROZEN** via `DOCUMENTATION_BASELINE.md`) remains the **sole source of requirements**. ⛔ **No product requirement, NFR, `ATT-GAP-*` disposition, `IMPL` ID, Face `V1`, `RFID`/`NFC`/`BLE` `V1`, `Q-04`/`MP-DEP-07` reopening, `50K`/`10K` frozen `NFR`, `RPS`/latency/`Redis`/pooling/cache threshold, architecture/migration change, or gate weakening is authorized.**

# ADR-0177 — **GSD Core adopted as methodology/reference only — Liboora remains sole source**

| Field | Value |
|---|---|
| **Status** | ⭐⭐ **Accepted** — 2026-10-26, by **Architecture Owner + Founder/Product Authority** one-act conferral recorded verbatim at §6 (one-principal form; ⛔ no independent review / ARB quorum / external audit claimed — `ADR-0103`/`ADR-0146` disclosure form; authority **reverts** on completion of the authorized act per `ADR-0033` §7.1) |
| **Rank** | **5 — Implementation Governance Decision** |
| **Date prepared** | 2026-10-26 |
| **Bounded context** | ⛔ **NONE at filing** · Cross-cutting workflow reference |
| **Route** | ⭐ **Standalone methodology-adoption act** — not a `PRD_LIFECYCLE.md` §4 PRD amendment route |
| **Supersedes** | ⛔ **NOTHING** |
| **Superseded by** | — |
| **Amends** | ⭐ `docs/40-implementation/DEFINITION_OF_DONE.md` **`v1.2 → v1.3`** (§7 + `v1.3` change-history row, 35 lines) · ⛔ **NOTHING else** · No Rank 1–3 document · No PRD / `ATT-GAP-*` · No `IMPL` range · No `ADR` text · No BC aggregate / edge / invariant · No API / schema / code / security specification |
| **Closes** | ⛔ **NOTHING** · `ATT-GAP-005` / `ATT-GAP-012` / `ATT-GAP-014` / `ATT-GAP-015` / `ATT-GAP-015` `OPENARBPending` / `ATT-GAP-017` / `ATT-GAP-017a` remain **OPEN** — no gap is closed or dispositioned by this ADR |
| **Decides** | ⭐ **One matter only:** **`GSD Core` is adopted as methodology/reference only** — the 8-step workflow (`slice by aggregate/BC/invariant · contract from Liboora `ATT-*` registers / `FROZEN` PRDs · ports/fakes first · thin implementation · boundary/invariant tests · evidence-bound acceptance · dependency-safe order · governance as gate) as written in `DEFINITION_OF_DONE.md` §7, with its 8-row Liboora adaptation table |
| **Expressly does NOT decide** | ⛔ **No product requirement** · ⛔ **No NFR** · ⛔ **`50K` / `10K` as frozen NFR** — `50K` registered / `10K` concurrent active users remain **UNRATIFIED planning assumptions** · ⛔ **No `RPS`** / **latency** / `Redis` / **pooling** / **cache** threshold · ⛔ **No `ATT-GAP-*` disposition** · ⛔ **No `IMPL` ID** · ⛔ `Face` remains **`V3`** per `D-3a` / `ATT-GAP-015` · ⛔ `RFID`/`NFC`/`BLE` remain **excluded** from `V1` per `ATT-XC-010`; seventh mode only via §7.1a · ⛔ **No reopening of `Q-04` / `MP-DEP-07`** (DISCHARGED in effect) · ⛔ **No architecture/migration change** · ⛔ **No gate weakening** — `Gate 3` / `ADR-0001` boundaries unchanged; **no existing gate was weakened or removed** |
| **Deciding authority** | ⭐ **Architecture Owner + Founder/Product Authority** — one-act, one-principal conferral recorded verbatim at §6 (2026-10-26) · ⛔ **no ARB quorum / attendee list / sign-off date / Security review asserted** (`ADR-0103`/`ADR-0146` disclosure form) · each conferral **reverts on completion** (`ADR-0033` §7.1) |
| **Origin** | This ADR **does not originate** from `ADR-0103`/`ADR-0146`/`ADR-0176` — it is a **standalone** one-act conferral. `ADR-0103`/`ADR-0146` are cited only as the **disclosure-form precedent** for the one-principal form. `ADR-0176` (`Legal/Counsel` office constitution) is the most recent one-act precedent but governs a different subject. |

---

## 1. ⭐ Purpose

This ADR **adopts `GSD Core`** — the slice → contract → thin-implementation → test loop — **as methodology/reference only**. Liboora's **frozen `PRD-*`**, `ADR`/`DDR`/`BC Map` governance, aggregate catalogue, ERDs and `IMPLEMENTATION_ROADMAP.md` §11 remain the **sole source of requirements**.

The 8-step workflow and its 8-row adaptation table are those already written as the `DEFINITION_OF_DONE.md` §7 proposal (35 lines: `v1.3` change-history row + `§7.1` + `§7.2`). This ADR **authorizes that §7** — it does not redesign, rewrite, or widen it.

---

## 2. ⭐ The one matter decided

**`GSD Core` → Liboora adaptation:** the 8-step workflow (§7.1) with the 8-row Liboora adaptation table (§7.2):

1. Slice by aggregate / bounded context / invariant — NOT by UI/API
2. Derive the implementation contract from the authoritative Liboora registers, `FROZEN` PRDs, `ADR`s/`DDR`s and existing architecture decisions
3. Establish ports/interfaces and fakes/test boundaries first where appropriate
4. Implement thinly: one authorized aggregate/boundary at a time
5. Add boundary and invariant tests
6. Produce evidence that binds the relevant acceptance criteria/invariants to the running implementation/tests
7. Respect the existing dependency graph
8. Treat governance as a gate/constraint, not as a product feature

All 8 steps are cited *per step* in the table to an existing `FROZEN`/Liboora-governed artifact; Liboora requirements listed are sourced from the same artifacts as the rest of `DEFINITION_OF_DONE.md`.

---

## 3. ⛔ Disclosure / non-claim — what this ADR is NOT

> **Required disclosure (`ADR-0103`/`ADR-0146` form):**
>
> *"No ARB was convened. No quorum, attendee list, sign-off date, or Security review is asserted.
> The Architecture Owner + Founder/Product Authority authorities are exercised by one principal. ⛔ No product
> requirement, NFR, ATT-GAP-* disposition, IMPL ID, Face V1, RFID/NFC/BLE V1, Q-04/MP-DEP-07 reopening,
> 50K/10K frozen NFR, RPS/latency/Redis/pooling/cache threshold, architecture/migration change, or gate
> weakening is authorized by this act. The 8-step workflow in DEFINITION_OF_DONE.md §7 is already written and is
> committed under the authorization it carries. `Q-04`/`MP-DEP-07` interim-policy (RET-01…RET-13) remains DISCHARGED
> in effect; Face remains V3; RFID/NFC/BLE remain excluded from V1; ATT-GAP-* remain OPEN. `GSD Core` is
> methodology/reference only; Liboora requirements remain authoritative. The one-act authority reverts immediately
> upon completion of the act."*

---

## 4. ⛔ What this ADR does NOT do

- ⛔ Does **NOT** create any product requirement, NFR, acceptance criterion or `ATT-AC-*`.
- ⛔ Does **NOT** close or decide any `ATT-GAP-*` (`ATT-GAP-005`/`012`/`014`/`015`/`017`/`017a` remain **OPEN**).
- ⛔ Does **NOT** mint any `IMPL` ID or extend any `IMPL-*` range.
- ⛔ Does **NOT** authorize Face as `V1`; `Face` remains `V3`.
- ⛔ Does **NOT** authorize `RFID`/`NFC`/`BLE` in `V1`.
- ⛔ Does **NOT** reopen, re-decide, or narrow `Q-04` / `MP-DEP-07`.
- ⛔ Does **NOT** freeze `50K` / `10K` as product `NFR`s — both remain **UNRATIFIED planning assumptions**.
- ⛔ Does **NOT** invent any `RPS` / latency / `Redis` / pooling / cache threshold.
- ⛔ Does **NOT** modify any API, schema, code, or security specification — `ADR-0121`…`ADR-0169` byte-unchanged; no file under `lib/`, `test/`, `tool/`, `packages/`, or `web/` is touched.
- ⛔ Does **NOT** weaken any existing gate — `Gate 3` / `ADR-0001` boundaries unchanged; **`| **v1.3** |`| records *"No existing gate was weakened or removed."* is an accurate statement.

---

## 5. ⛔ Registration hygiene

| Check | Result |
|---|---|
| Number | ⭐ `ADR-0177` is the next unregistered ADR; no number reused, reserved, or renumbered |
| Citation cost | ⭐⭐ **ZERO** — this file adds one ADR doc; the end-of-file addendum to `ADR-INDEX.md` does **not** re-derive the `Count` cell nor touch the `Date` header; both remain for a later `ADR-0146`-conforming registration pass |
| Status act | **`Accepted` itself** — this ADR is **not registered via an end-of-file addendum**: it is registered **in the same commit in which it was written and accepted**, per the `ADR-0057` late-registration discipline (the addendum at the end of `ADR-INDEX.md` is included **in the same commit**) |
| `DEFINITION_OF_DONE.md` version cell | ⭐⭐ `v1.2 → v1.3` is recorded as the `v1.3` change-history row **in the same commit**; the file's own `Version` row remains `v1.2` (`GCP-25` class — two readings of one derived-statement change; the row stays for a same-commit repair, per the pattern `GCP-15` drafted) |

---

## 6. ⭐⭐ Conferral and reversion

| Field | Value |
|---|---|
| **Form** | ⭐ **ONE one-act conferral** — by the **Architecture Owner + Founder/Product Authority** principals (one-principal form) — 2026-10-26 |
| **Scope** | ⭐ *Adoption of `GSD Core` as methodology/reference only — `DEFINITION_OF_DONE.md` §7 as written (35 lines: `v1.3` change-history row + §7.1 + §7.2)* |
| ⛔ **Not claimed** | ⛔ No independent review · ⛔ No ARB quorum / attendee list / sign-off date · ⛔ No external audit (`ADR-0103` / `ADR-0146` disclosure form) · ⛔ No product requirement / NFR / `ATT-GAP-*` decision · ⛔ No `IMPL` ID · ⛔ No Face `V1` · ⛔ No `RFID`/`NFC`/`BLE` `V1` · ⛔ No `Q-04`/`MP-DEP-07` reopening · ⛔ No `50K`/`10K` frozen `NFR` · ⛔ No `RPS`/latency/`Redis`/pooling/cache threshold · ⛔ No architecture/migration change · ⛔ No gate weakening |
| ⭐ **Reversion** | ⭐ Authority **reverts automatically** upon completion of the authorized act; the conferral has **no continuing authority** |

### 6.1 ⭐ The conferral, recorded verbatim (2026-10-26)

> **Architecture Owner + Founder/Product Authority:** *"I explicitly confer the one-act authority for ADR-0177: Architecture Owner + Founder/Product Authority authority is conferred for this single act only, authorizing GSD Core as methodology/reference only, with Liboora PRD-* remaining the sole source of requirements. This authority authorizes recording ADR-0177 and committing the already-existing DEFINITION_OF_DONE.md §7 exactly as it currently stands. No product requirement, NFR, ATT-GAP disposition, IMPL ID, Face V1, RFID/NFC/BLE V1, Q-04/MP-DEP-07 reopening, 50K/10K frozen NFR, RPS/latency/Redis/pooling/cache threshold, architecture/migration change, or gate weakening is authorized. The one-act authority reverts immediately upon completion of the act. No ARB quorum, attendee list, sign-off date, or Security review is asserted."*

Source: conferred during the 2026-10-26 `ADOPT-WITH-ADAPTATION` authorization session (`5ab4155` → presentation at close).

---

> **This ADR is now ACCEPTED (2026-10-26).** Its decision substance in §1–§6 is **byte-preserved** per
> Process rule 2 (*"Never edit an Accepted ADR's decision text"*). The `DEFINITION_OF_DONE.md` `§7`
> workflow and its `v1.3` change-history row are **committed in the same commit** under the authorization
> this ADR records; they are not separate decisions. No file under `lib/`, `test/`, `tool/`, `packages/`,
> `web/`, `l10n/`, `supabase/`, `migrations/` or `infrastructure/` is touched; no API, schema, code, or
> security specification is modified. **The constituted office's authority reverts automatically** upon
> completion of the authorized act; the recording of any subsequent disposition for `Q-04`/`LR-01`/`MP-NFR-10`
> is a **separate, later named act** and must carry its own disclosure form.

---

