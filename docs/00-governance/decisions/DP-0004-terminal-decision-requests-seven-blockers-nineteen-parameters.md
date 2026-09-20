# DP-0004 — Terminal decision requests: **7 blockers · 19 parameters**

| Field | Value |
|---|---|
| **Document** | ⭐ **Decision Request** — reusing the repository's `Pack → Request` pattern *(`PRD-006_ATT-GAP-017_OWNER_DECISION_REQUEST`, `DP-0003`)* |
| **Version** | v1.0 · **Date** 2026-09-19 |
| **Status** | ⛔ **OPEN** · ⛔ **0 responses received** |
| **Supersedes** | ⛔ **NOTHING.** ⭐ `DP-0002` Part B and `DP-0003` remain on the record; ⭐ this sheet is the **terminal** statement after `ADR-0162` / `ADR-0163` |
| **Coverage at issue** | ⭐ **85 / 104 authorized · ⛔ 19 held** |
| **Values / allocations proposed here** | ⛔⛔ **ZERO** |

> ⭐⭐ **Why this document is terminal.** ⭐ Every blocker below has been tested against
> the evidence **at least twice** — by `ADR-0160`, `ADR-0161`, `ADR-0162` and
> `ADR-0163`. ⛔ **No further repository-side progress is legitimately available.**
> ⭐ Each now requires a **named human or external principal**.
>
> ⛔⛔ **It decides nothing and changes no count.**

---

## 0. ⛔⛔ Constraints binding every answer

| # | Constraint | Source |
|---|---|---|
| 1 | ⛔ Platform roles closed at **two**; library roles at **five** | `AUTH` ch.07 **L79**, **L87** |
| 2 | ⛔⛔ Permission catalogue **CLOSED at ZERO** | **`AUTH-7.22`** *(**L2336**)* |
| 3 | ⛔ `READ` and `WRITE` **independent** | **`AUTH-7.24`**, `CNF-BR-010` |
| 4 | ⛔ No permission hierarchy | **`AUTH-7.28`** |
| 5 | ⛔ Frozen PRDs **MUST NOT** be amended to fit a decision | `ADR-INDEX` process |
| 6 | ⛔ The **104** inventory **MUST NOT** change | standing |
| 7 | ⚠️ ⚪ **`N/A` ≠ ⛔ `DENY`** | `ADR-0151` §3.5 · `ADR-0155` `S-4` |
| 8 | ⭐⭐ **`HOLD` is a correct answer.** ⛔ Do **NOT** decide to reach 104/104 | standing |
| 9 | ⭐ Offices are exercised by **one-act conferral**; ⛔ **no personal name** is recorded | `PRD_OWNERSHIP_MODEL` §7 rule 4, §12.1 |
| 10 | ⭐⭐ **A shared band is not a shared decision** | `ADR-0155` |

---

# PART A — ⭐ INTERNAL *(4 blockers · 13 parameters)*

## `A-1` · `B-3′` — `ICFG` `READ` — ⭐ **the largest single block**

| | |
|---|---|
| **Question** | ⭐ **Who may `READ` `ICFG-1`…`ICFG-10`?** |
| **Authority** | ⭐ **Product Owner + SECURITY PLATFORM**, jointly *(the pairing `ADR-0154` §7 names)* |
| ⭐ **Already resolved — ⛔ do NOT re-decide** | ⭐ **Scope = `Platform default`** *(`ADR-0163` §3, on `CNF-FR-026` + `CNF-FR-003` + `CNF-FR-028`)* · ⭐ **`WRITE` = ⚪ `N/A`** · ⭐ **Commercial = `NOT COMMERCIAL`** *(`ADR-0162` §5)* |
| **What is missing** | ⛔⛔ **A `READ` statement.** Measured **0** across `INVITATION_SECURITY_SPECIFICATION` and `CONFIGURATION_GUIDE` §2B, over 7 anchored phrasings |
| **Choices** | ⭐ **(a)** `PR-1` + `PR-2` · **(b)** a named `TR-n` subset · **(c)** ⚪ `N/A` *(**with its own reasoning** — ⛔ **not** "by symmetry": ⚪ `N/A` rests on `CNF-FR-020`, a **write-only** rule)* · **(d)** ⛔ **HOLD** |
| ⛔ **MUST NOT** | ⛔⛔ Adopt **(a)** merely because the scope-1 `CFG-*` and `SCFG-*` have it — ⭐⭐ **that is the band argument, refused FOUR times** *(`ADR-0158` §2.4b, `ADR-0160`, `ADR-0162` §5, `ADR-0163` §3.3)* · ⛔ derive `READ` from `WRITE` · ⛔ treat `INV-SEC-018`'s denial of `TR-n` as a grant to `PR-n` *(`AUTH-7.28`)* · ⛔ treat *"Matches `CFG-4`"* as an authority statement |
| **Parameters** | ⭐ **10** |

> **`A-1` — DECISION (Product Owner + SECURITY PLATFORM).**
> `READ` for `ICFG-1`…`10`: ☐ (a) `PR-1`+`PR-2` ☐ (b) `TR-n`: ______ ☐ (c) ⚪ `N/A` ☐ (d) HOLD
> Reasoning *(⛔ may not be "same band as `CFG-*`")*: ______________________________
> On the four prior refusals: ☐ **CONFIRMED** ☐ **OVERRULED** — express authority: ______
> I confirm scope/`WRITE`/commercial were **not** re-decided, and `READ` was decided **independently**.
> Product Owner: ____________ SECURITY PLATFORM: ____________ Date: ________

---

## `A-2` · `B-2` — `SCFG-2`'s review authority

| | |
|---|---|
| **Question** | ⭐ Who performs the *"review"* required before a reserved username may be removed? |
| **Authority** | ⭐ **Authorization Owner** *(`ADR-0155` `S-3`)* |
| **Evidence** | ⭐ `Student_Identity_PRD_v1` **L1336** — *"Additive only; **removing an entry requires review**"*. ⭐ Re-swept: **2** lines repository-wide *(**L356**, **L1336**)*, ⛔ **neither naming an actor** |
| **Choices** | ⭐ **(a)** name an existing office · **(b)** name an existing role · **(c)** ⛔ **HOLD** — ⭐ **expressly permitted**: *"If the Authorization Owner cannot identify an authoritative role, keep `SCFG-2` **HELD**"* |
| ⛔ **MUST NOT** | ⛔⛔ Infer from naming, ownership, hierarchy or UI visibility *(`S-3`)* · ⛔ weaken `SID-5.45` |
| **Parameters** | **1** |

> **`A-2` — DECISION (Authorization Owner).** ☐ Reviewer: ____________ Source conferring it: ____________ ☐ **HOLD**
> Authorization Owner *(one-act)*: ____________ Date: ________

---

## `A-3` · `B-1″` — `CFG-12` `READ`

| | |
|---|---|
| **Question** | ⭐ May `PR-1`/`PR-2` `READ` the parameter that bounds `PR-2`'s **own** elevation ceiling? |
| **Authority** | ⭐ **Authorization Owner** |
| **Evidence** | ⭐ **8** citations, ⭐⭐ **all enforcement rules** — `BR-2.14`, `XC-2.5`, `AC-2.11`, `AUTH-7.19`, `BR-7.21`, `XC-7.11`, `AC-7.19`, `AUTH-8.70`. ⛔ **0 read grants** · ⭐ `ADR-0154` §6 **self-reference** hold · ⭐ `ADR-0154` allocated `READ` to **ten** `CFG-*` and **expressly excluded** this one |
| ⭐ **Narrowed** | ⭐⭐ **The legal limb is WITHDRAWN** *(`ADR-0162` §7.2 — **0** hits for `CFG-12`/*"elevated"*/*"elevation"* in `LEGAL_RISK_REGISTER`)*. ⭐ **This is now purely internal** |
| ⛔ **MUST NOT** | ⛔⛔ Infer a `READ` from `XC-2.5`'s *"approved by a distinct Platform Administrator"* — ⭐ **tested and refused** *(`ADR-0163` §5.1)*: `PR-1` approves an **elevation request**, and expiry is **automatic** ⇒ ⭐ **the system enforcing a value is not a human reading a parameter** *(`AUTH-7.24`)* |
| **Parameters** | **1** |

> **`A-3` — DECISION (Authorization Owner).** `READ`: ☐ `PR-1`+`PR-2` ☐ `PR-1` only ☐ ⚪ `N/A` ☐ **HOLD**
> How the **self-reference** concern is addressed: ______________________________
> Authorization Owner *(one-act)*: ____________ Date: ________

---

## `A-4` · `B-8′` — `SEAT-CFG-017` / the `E-05` payload

| | |
|---|---|
| **Question** | ⭐ Shall `E-05`'s `SeatRules` payload be **amended** to carry an occupancy threshold? |
| **Authority** | ⭐⭐ **Architecture Owner** *(corrected — `SEAT-GAP-005`'s own owner column reads **Architecture**; ⛔ **not** the `PRD-002` Domain Owner, as `DP-0002` wrongly stated)* **+ Product Owner** for any resulting value |
| **Evidence** | ⭐ BC Map **L302** — `E-05 \| BC-06 → BC-04 \| CF \| Sync port \| SeatRules{maxTransfersPerDay, reservationWindow}` — ⛔ **no threshold** · ⭐ `SEAT-FR-267` requires **Stage-3 confirmation** · ⭐ BC Map §7: changing an edge **requires an ADR** *(**Rank 1**)* |
| ⚠️⚠️ **A second, independent bar** | ⭐⭐ **`LIB-14B.13`** — *"Public Live Occupancy is **V2** and **MUST NOT** be implemented in V1"*. ⛔ **Even a resolved `E-05` would not make this a V1 parameter** |
| ⛔ **MUST NOT** | ⛔⛔ Apply **90%** as a fallback *(`SEAT-FR-241`, `SEAT-AC-170`, §27.1 forbid it in terms)* · ⛔ alter `E-05`'s **Conformist** character · ⛔ convert branch scope to `Tenant` by inference |
| **Parameters** | **1** |

> **`A-4` — DECISION (Architecture Owner + Product Owner).**
> ☐ `E-05` **amended** *(separate Rank-1 ADR: __________)* ☐ **NOT amended — `SEAT-CFG-017` stays unset** ☐ **HOLD**
> On `LIB-14B.13`'s V2 bar: ______________________________
> Architecture Owner: ____________ Product Owner: ____________ Date: ________

---

# PART B — ⛔⛔ EXTERNAL / LEGALLY GATED *(3 blockers · 6 parameters)*

## `B-1` · `B-6` — ⭐⭐ THE CRITICAL PATH

| | |
|---|---|
| **Exact legal question** | ⛔⛔ **What does Indian law require of Liboora's retention of `StudentAttendance`, `StudentRecord` financial history, biometric-adjacent data and register images — and consequently, who may set a retention period?** |
| **Responsible principal** | ⛔⛔ **NOT a governance office.** ⭐ `LR-01` §5: *"a written determination from a **qualified Indian advocate** — or a competent authority, court, or **Data Protection Board** ruling"*. ⭐ **Risk bearer: the human principal of this engagement** — *"the risk is **borne, not delegated**"* |
| ⭐ **`LR-01` conditions — ALL FIVE required** | **(1)** a written external determination addressing **`U-1`…`U-13`** · **(2)** recorded in a **NEW ADR** *(⛔ `ADR-0137` may not be edited)* · **(3)** a retention **period** — or an express determination that none is required — adopted by **the office the determination identifies** · **(4)** `ATT-GAP-005`, **`ATT-GAP-014`**, `ATT-GAP-016`, `AUD-GAP-001` and blocker **7a** each dispositioned · **(5)** `MP-GBR-04`'s *"retained under legal basis"* clause **substantiated or amended** |
| ⭐ **Evidence to supply counsel** | ⭐ `LEGAL_RISK_REGISTER` §3 *(`U-1`…`U-13`)*, §5, §6 *(`T-1`…`T-12`)* · `ADR-0137` · `ADR-0133` · `CFG-10`'s rationale *("defensible as erasure under DPDP")* · `SCFG-4` *(24 months)* · `ATT-GAP-014` · `MP-GBR-04` · `ID-5` |
| ⭐ **The central uncertainty** | ⭐⭐ **`U-11`** — *"whether **indefinite retention is permissible at all**"* |
| ⛔ **MUST NOT** | ⛔⛔ Constitute a **`Legal Owner`** internally — ⭐ *"Legal Owner"* measures **0** repository-wide and `Accepted` **`ADR-0137`** *"does **not** constitute Legal Counsel as an office"*; doing so would **overturn an `Accepted` ADR by implication** · ⛔ close `LR-01` on any **subset** of the five · ⛔ treat mitigation as compliance · ⛔ cite `RET-03`/`RET-06`/`RET-13` as legal justification *(**`T-11`** — **automatic REJECT**)* |
| ⭐ **Trigger already live** | ⭐⭐ **`T-7`** — *"Liboora **engages a qualified Indian advocate for ANY purpose** — `LR-01` **must be tabled** in that engagement"* · ⚠️ **`2027-02-01`** = **HARD ESCALATION**; ⚠️ **~`2027-05-13`** = DPDP §§7–17 **commence** |
| **Parameters gated** | ⭐ **6** — `CFG-10`, `SCFG-4` *(direct)* + the Face family *(via `B-3`)* |

## `B-2` · `B-5′` — `CFG-10` / `SCFG-4` allocation, once the value limb clears

⭐ **Value limb ⇒ ⛔ external** *(above)*. ⭐⭐ **Allocation limb ⇒ Authorization Owner**
— ⛔ **NOT** the Privacy Owner, whom `LR-01` names among those who **cannot** close the
retention question *(the `DP-0001` §3 routing error, corrected at `ADR-0162` §6.1)*.
⛔ **Nothing may be allocated before the value limb clears** *(`T-10`)*. **2 parameters.**

## `B-3` · `B-10` — biometrics: `ATT-GAP-012` + `ATT-GAP-014`

| Limb | Authority | Status |
|---|---|---|
| ⛔ **`ATT-GAP-012`** — which context **owns** biometric templates | ⭐⭐ **Architecture Owner** *(a **Rank-1 BC Map** act)* — ⛔ **not** the Security Owner, whom `PRD_OWNERSHIP_MODEL` §17.1 denies **architecture authority** | ⭐⭐ **`biometric` measured ZERO times in the entire BC Map** — ⛔ **no context claims it** |
| ⛔ **`ATT-GAP-014`** — retention / deletion | ⛔⛔ **External** — ⭐ it **is** `LR-01` §5 condition **4** | ⛔ **Gated by `B-1` above** |

⭐⭐ **`ATT-FR-064` requires BOTH**: *"Until `ATT-GAP-012` and `ATT-GAP-014` are **both**
answered by their named owners, face verification **MUST NOT** be implemented. The mode
is specified; it is **not** authorised to be built."*

⛔⛔ **Configuration authority MUST NOT be allocated ahead of build authorization** —
⭐ `ADR-0160` declined this as **authorization theatre**; ⛔ a default value is **not**
authorization. ⚠️ **`ATT-CFG-014` carries a SECOND, INDEPENDENT bar** — outside V1 by
`D-3a` *(Face = **V3**)*. ⭐⭐ **It would NOT move even if both gaps cleared.**
**4 parameters.**

---

## 1. ⭐ Summary

| Blocker | Authority | Internal / External | Params |
|---|---|---|---:|
| `A-1` `ICFG` `READ` | PO + SECURITY PLATFORM | ⭐ Internal | **10** |
| `A-2` `SCFG-2` reviewer | Authorization Owner | ⭐ Internal | **1** |
| `A-3` `CFG-12` `READ` | Authorization Owner | ⭐ Internal | **1** |
| `A-4` `SEAT-CFG-017` / `E-05` | Architecture + Product Owner | ⭐ Internal *(⛔ **Rank-1**)* | **1** |
| `B-1` `LR-01` legal basis | ⛔⛔ **Qualified Indian advocate / court / DPB** | ⛔⛔ **EXTERNAL** | *(gates 6)* |
| `B-2` retention allocation | Authorization Owner, **after** `B-1` | ⛔ Gated | **2** |
| `B-3` biometrics | Architecture Owner **+** ⛔ external | ⛔ Mixed | **4** |
| | | ⭐ **TOTAL** | ⭐ **19** |

⭐⭐ **85 authorized + 19 held = 104.**

## 2. ⛔ On receipt — what will **NOT** be done

⛔ No answer will be inferred from silence · ⛔ no `PERM-*` minted · ⛔ no role, action
class or scope class created · ⛔ no frozen PRD amended · ⛔ no `Accepted` ADR overturned
· ⛔ **no parameter authorized to reach a number** · ⭐⭐ **`HOLD` will be recorded as
`HOLD`.**

## 3. ⛔ If nothing is decided

⭐ Coverage stays **85 / 104** · ⛔ **D3 `PARTIAL`** · ⛔⛔ **`DD-0007` NOT design-ready**
· ⛔ the **Face mode may not be built** *(`ATT-FR-064`)* · ⚠️ **`LR-01` escalates on
`2027-02-01`** and becomes release-blocking.

## 4. ⭐ Separately — the one act needing **no** decision

⭐ **`DD-0007` v0.9's coverage figure is stale at 79 / 104** *(true: **85**)*. ⭐ The
document is **UNRANKED**, **`PROPOSED`** and ⛔ **not frozen**, so ⭐ its **UX
Architecture Owner** may update it as an **ordinary owner act**. ⭐ **The exact minimum
change is prepared at `ADR-0163` §4.4.** ⛔ **It is not a blocker and gates nothing.**

---

*End of `DP-0004`. ⛔ **OPEN · 0 responses.** ⭐ **85 / 104 · 19 held · D3 `PARTIAL`.***
