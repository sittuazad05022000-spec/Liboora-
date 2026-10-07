<!-- LIBOORA Design Documentation | Design Decision Record | 2026-10-06 -->

> This document is design governance and documentation. It does **not** approve a
> foundation artifact, PRD, ADR, gate outcome, implementation, or release. It is a
> supersession record **ACCEPTED** 2026-10-07 under the recorded Founder/Product Authority
> one-act conferral (see the verbatim Conferral block below).

# DDR-0037 — `DDR-0002` V1 Indic/Devanagari student-name support superseded and moved to V2

| Field | Value |
|---|---|
| **Register** | Filed under [`README.md`](README.md) §2 template and §4 filing rules · global identifier `DDR-0037` (`DDR-0036` is the last filed — *never reused, never reassigned*; identifier verified free: 0 occurrences repository-wide at filing) |
| ⭐ **Status** | ⭐ **ACCEPTED** — 2026-10-07, under the **Founder/Product Authority** one-act conferral recorded **verbatim** in the *Conferral* block below · ⛔ **no gate is passed, closed, or re-statused** · ⛔ `G5` stays **PROPOSED / V2-deferred** · ⛔ the paired search-track limb supersession (`ADR-0174`) **remains a separate pending governance act** |
| **Date** | 2026-10-06 (drafting date = session date; no date invented beyond it) |
| ⭐ **Owner** | ⭐ **Design Governance Owner** *(role, never personal name)* — drafts the supersession · **Design System Owner** *(the supersession schedules their `DDR-0002`-derived duty, it does not substitute for its later discharge)* · final foundation/status authority: **Founder/Product Authority** |
| ⭐ **Approver** | ⭐ **Founder/Product Authority** — conferral **RECORDED 2026-10-07** (verbatim in the *Conferral* block below; supplied by the authority this session, not invented). ⛔ **No independent review claimed.** ⛔ The conferral is limited to accepting `DDR-0037` only; it does **NOT** accept, concur, or record any act for `ADR-0174` or any other record |
| ⭐ **Authority instrument** | ⭐ **Recorded one-act conferral** of the **Founder/Product Authority** office, verbatim below — a D5 product/authority act (the supersession of `DDR-0002`'s V1 requirement limb to V2), recorded this session. ⛔ Not self-assigned. ⛔ The `ADR-0174` route ([`ADR-0174`](../../00-governance/adr/ADR-0174-bc-23-v1-script-scope-narrowed-to-latin-hindi-deferred-to-v2.md)) is a **separate, still-PENDING** governance act; it is NOT conferred by this record |
| **Scope** | ⭐ **Supersession, not amendment-in-place** — moves the `DDR-0002` **requirement limb** (V1 Indic/Devanagari student-name support + guaranteed rendering) to **V2**. ⛔ The historical `DDR-0002` record (`DDR-0001-to-0009-…md` §47–61 + status register row §219) is **byte-unchanged** and preserved; this record **supersedes for V1** the requirement limb and **names itself as successor** per `DESIGN_DEBT.md` §3 rule 3 *(name successor; mark SUPERSEDED; never reuse the identifier; never rewrite the superseded record)* |
| **Change class** | ⭐ **D5 — Product / scope decision (design layer)** *(`DESIGN_CHANGE_MANAGEMENT.md` §1): this record is **a V1 scope cut at the design layer** for the Indic/Devanagari name-rendering duty; it changes **what V1 must support** (V1 name fields become script-agnostic with no Indic-rendering guarantee; Indic/Devanagari rendering is scheduled to V2, **not waived**)* · ⛔ This is the **reversal** of the `D5 = NO V1 SCOPE CUT` posture held in `DDR-0035`/`DDR-0036`; a **later authority act supersedes the earlier routing act** — those two records are **byte-unchanged and not edited**, only their retained-posture reading is overtaken by this D5 act when accepted |
| **Source references** | `DDR-0001-to-0009-founder-product-authority-decisions.md` §47–61 (`DDR-0002` clause) + status register row §219 *(APPROVED requirement / TBD family)* · `LIBOORA_HUMAN_DECISION_SHEET.md` **D-2** *(the human decision behind `DDR-0002`)* · `MASTER_PRD.md` **L523 `MP-CON-12`** *(India-first posture cited by `DDR-0002`; **pointer only, NOT edited** — `DESIGN_GOVERNANCE.md` §3 rule 1: frozen/inherited material is cited, never rewritten)* · `DESIGN_DEBT.md` §3 rule 3 *(supersession discipline)* · `DDR-0035` *(G5→V2 deferral that retained the `DDR-0002` V1 requirement)* · `DDR-0036` *(CP-B1/M1→V2 deferral that retained the `DDR-0002` V1 requirement)* |
| ⭐ **Decision (core disposition, verbatim)** | ⭐ **"The `DDR-0002` V1 requirement that student names **MUST** be supported in Indic/Devanagari characters with guaranteed proper rendering is **SUPERSEDED for V1** and the Indic/Devanagari name-support duty is **moved to V2**. In **V1** the student-name fields are **script-agnostic** and carry **no Indic/Devanagari rendering guarantee**; in **V2** the Indic/Devanagari name-rendering duty (and its `CP-B1`/`M1`/`DDR-0012` verification chain) is **scheduled, NOT waived**. The historical `DDR-0002` record and its `D-2` / `MP-CON-12` provenance are **preserved, not rewritten**. **`DDR-0012` remains reserved-and-free.** **D5 = V1 SCOPE CUT (design layer).**" |
| ⭐ **D5 disposition** | ⭐ **D5 = V1 SCOPE CUT (design layer).** Per `DESIGN_CHANGE_MANAGEMENT.md` §1, `D5` is a *Product or architecture change*; moving an Indic/Devanagari rendering duty out of the V1 contract **is** a D5 act and **requires** the **Founder/Product Authority** conferral recorded in the `Approver` field above — ⛔ which is **PENDING and unrecorded**, so this draft does **not** take effect on its own. This disposition **reverses** the `D5 = NO V1 SCOPE CUT` posture of `DDR-0035`/`DDR-0036` for this specific duty. |
| **Alternatives** | ⛔ **Retain the `DDR-0002` V1 requirement (the `DDR-0035`/`DDR-0036` posture)** — *now rejected by this D5 act:* the principal's Option A instruction moves all Hindi/Devanagari support to V2; the retained-posture record is therefore overtaken, **not** re-opened · ⛔ **Amend `DDR-0002` in place** — *rejected:* frozen/approved historical records are **superseded, never edited** (`DESIGN_DEBT.md` §3 rule 3; `DESIGN_GOVERNANCE.md` §3 rule 1) · ⛔ **Waive the duty entirely (no V2 schedule)** — *rejected:* the duty is moved to V2, **not waived**; V2 still owes Indic/Devanagari name rendering |
| **Consequences** | ⭐ On acceptance: the `DDR-0002` requirement limb is **SUPERSEDED-for-V1**; V1 name fields become **script-agnostic** (no Indic guarantee); the Indic/Devanagari name-rendering duty + its `CP-B1`/`M1`/`DDR-0012` chain is **scheduled to V2, not waived** · ⭐ the accepted search-track ADR limbs that bind V1 to a two-set English+Hindi inventory (`ADR-0099` `C-8`, `ADR-0100` §223–225, `ADR-0101` `D-10`, `ADR-0103` `C-8`/Supplement B) are **superseded-for-V1** by `ADR-0174` (Hindi/Devanagari → V2); the ADR files themselves are **byte-unchanged** · ⭐ `PRD-015` `SRCHPO-1` **value** (V1 canonical script set) narrows to **English/Latin only** in V1, with **Hindi/Devanagari scheduled to V2**; the `SRCH-FR-024` conditional text and the `N1–N6` normalization limbs are **textually unchanged** (they remain conditional on the declared script/scope; only the consumed *value* changes) · ⭐ `G5` **stays PROPOSED / V2-deferred** · ⭐ `DBT-008` **stays OPEN** · ⭐ `CP-B1` / `FA-GAP-003` **stay BLOCKED / UNVERIFIED** · ⭐ **no M1 PASS/FAIL/BLOCKED result is asserted** · ⭐ `DDR-0012` **stays reserved-and-free** |
| **Open questions** | ⭐ **Founder/Product Authority conferral** — **RECORDED 2026-10-07** (verbatim below); ⛔ a **new** conferral is required for any later re-entry of Indic/Devanagari into the V1 contract · ⭐ **V2 discharge** — **Design System Owner**: schedule and later discharge the Indic/Devanagari name-rendering duty (V2 `CP-B1`/`M1`/`DDR-0012` chain) · ⛔ the **search-track limb supersession** (`ADR-0174` acceptance + ARB concurrence + the held `PRD-015` v0.2 / `SUPPLEMENT_D` route) **remains open and is a separate pending act** |
| **Review trigger** | Any recorded Founder/Product Authority conferral on this record · any re-entry of Indic/Devanagari into the V1 contract · entry into V2 · any `DDR-0002` successor naming change |

---

## ⭐ Conferral — Founder/Product Authority, recorded verbatim (2026-10-07)

⭐ **Office named:** Founder/Product Authority · ⭐ **Act:** acceptance of `DDR-0037` ·
⭐ **Scope:** the single D5 decision to move the `DDR-0002` V1 Indic/Devanagari
student-name requirement limb to V2 (scheduled, **not waived**) · ⛔ the conferral
**reverts on completion** of this act (*`ADR-0033` §7.1*) · ⚠️ **no independent review
claimed** · the conferral text below was **supplied by the authority this session; it is
recorded verbatim, not invented or reworded.**

> *"I hereby confer/accept DDR-0037. The V1 Indic/Devanagari student-name requirement is moved to V2 as a scheduled scope decision, not waived."*

⛔ **Out of scope for this conferral (separate pending acts, NOT performed here):** the
`ADR-0174` acceptance / ARB concurrence · the held `PRD-015` v0.2 seven-step route incl.
`SUPPLEMENT_D` · the `DDR-0038` identifier (not created) · `G5` closure (stays
PROPOSED / V2-deferred) · the `CP-B1`/`M1`/`DDR-0012` discharge (V2).

## What this record does NOT do

- ⛔ Does **NOT** assert any M1 PASS/FAIL/BLOCKED result — M1 remains **pending / unverified**; no evidence is fabricated or inferred.
- ⛔ Does **NOT** edit, amend, or rewrite the historical `DDR-0002` record or its `D-2` / `MP-CON-12` provenance — those are **superseded-for-V1, preserved, and byte-unchanged** (`DESIGN_DEBT.md` §3 rule 3; `DESIGN_GOVERNANCE.md` §3 rule 1).
- ⛔ Does **NOT** fabricate the **Founder/Product Authority** approval — the conferral was **supplied by the authority and is recorded verbatim** in the *Conferral* block above; the `Approver` / `Authority instrument` fields now reference that recorded conferral (they were PENDING before 2026-10-07).
- ⛔ Does **NOT** close, re-status, or pass `G5` — it **stays PROPOSED / V2-deferred** (`DDR-0035`). Does **NOT** create `DDR-0038`.
- ⛔ Does **NOT** change `DBT-008` (stays **OPEN**) or `CP-B1` / `FA-GAP-003` verdict cells (stay **BLOCKED / UNVERIFIED**).
- ⛔ Does **NOT** create, reference-as-existing, or imply that `DDR-0012` exists — it **stays reserved-and-free**.
- ⛔ Does **NOT** revoke, edit, or re-status `DDR-0035` / `DDR-0036` — they are **byte-unchanged**; their retained-posture reading is overtaken, not edited.
- ⛔ Does **NOT** modify `theme.dart`, `pubspec.yaml`, fonts, fallback configuration, or any application code.
- ⛔ Does **NOT** modify `DEVANAGARI_RENDERING_PROBE.md`, `CP-B1_EQUIVALENT_TARGET_PROPOSED_ACCEPTANCE.md`, `DDR-0001-to-0009-…md` (`DDR-0002`), any frozen PRD (`PRD-003`, `MASTER_PRD`, `PRD-015` v0.1), any accepted ADR file, or other historical/frozen record.
- ⛔ Does **NOT** change any action-plan tally number, gate count, debt-row status, owner/role/permission; no Figma artifact, commit, or push.

## Change-control note

Per `DESIGN_CHANGE_MANAGEMENT.md` §4: decision ID `DDR-0037` · artifact = this supersession record (design governance) · decision status **ACCEPTED** (**D5 = V1 SCOPE CUT, design layer**; supersedes `DDR-0002` requirement limb for V1; moves the Indic/Devanagari name-rendering duty to V2, **not waived**) · owner **Design Governance Owner** (with **Design System Owner** as the later V2 discharger) · **Approver: Founder/Product Authority — conferral RECORDED 2026-10-07 (verbatim in the Conferral block; reverts on completion; no independent review claimed)** · drafting date **2026-10-06**; acceptance date **2026-10-07** · source references per the table above · **the search-track limb supersession (`ADR-0174`) remains a SEPARATE pending act** — acceptance of `ADR-0174` + ARB concurrence and the held `PRD-015` v0.2 / `SUPPLEMENT_D` route are **NOT performed or implied by this record**; when `ADR-0174` is accepted, its limbs are superseded-for-V1 and the `PRD-015` `SRCHPO-1` V1 script-set value narrows to English/Latin only, with the V2 duty **scheduled, not waived**.
