# LIBOORA — Legal-Risk Register

| Field | Value |
|---|---|
| **Document** | Legal-Risk Register |
| **Version** | **v1.0** |
| **Rank** | **7** — descriptive and **MUTABLE**. ⛔ This document confers no authority and amends no requirement. |
| **Authority** | `Accepted` [`ADR-0137`](adr/ADR-0137-q-04-reframed-mp-dep-07-discharged-legal-risk-opened-as-lr-01.md) |
| **Purpose** | Record **unresolved legal risk** that Liboora governance has **identified but CANNOT resolve**, so that it remains visible, owned, dated and escalating instead of hidden inside a blocked question. |
| **Identifier namespace** | `LR-*` — reserved exclusively for this document, collision-free against every other register |
| **Entries** | **1** — `LR-01` |
| **Last Updated** | 2026-09-11 |

---

## 0. ⛔⛔ WHAT THIS REGISTER IS, AND WHAT IT IS NOT

### 0.1 It is NOT a legal-opinion register

⛔⛔ **This document contains NO legal advice, NO legal opinion, and NO legal determination.** Every legal reading recorded here was produced by an **AI research assistant**, is ⛔ **NOT legal advice**, has ⛔ **NOT been reviewed by any qualified Indian advocate**, and ⛔ **MUST NOT be relied on as a determination**.

⛔ **Nothing in this register may be cited as establishing that any Liboora practice is lawful, compliant, safe, defensible or sufficient.**

### 0.2 It is NOT a blocker register

⭐ Implementation blockers live in [`../40-implementation/IMPLEMENTATION_BLOCKER_REGISTER.md`](../40-implementation/IMPLEMENTATION_BLOCKER_REGISTER.md).

⛔⛔ **`LR-01` is NOT an implementation blocker.** It does ⛔ **not** block the V1 schema freeze; it **accompanies** it. ⭐ The distinction is deliberate: a blocker halts work until discharged, whereas a legal-risk item is **carried, reviewed and escalated while work proceeds**.

⚠ **Blocker 7a in that register remains OPEN and UNAMENDED**, and `LR-01` does not change, close, mitigate-away or re-status it.

### 0.3 ⭐⭐ THE DISTINCTION THIS REGISTER EXISTS TO PRESERVE

| | **Unresolved legal uncertainty** | **Internal interim product policy** |
|---|---|---|
| **Identifier** | `U-1`…`U-13` | `RET-01`…`RET-13` |
| **What it is** | A question about what **external law requires** | A choice about what **Liboora's product does** |
| **Who may decide it** | ⛔ **NOT this governance system** — no constituted office has the authority | ⭐ Product Owner + Architecture Owner |
| **Current state** | ⛔⛔ **ALL THIRTEEN UNRESOLVED** | ⭐ Adopted by `ADR-0137` §4 |
| **Legal status** | ⛔ Undetermined | ⛔ **Undetermined — adopting a policy does NOT make it lawful** |

⛔⛔ **These two things must NEVER be conflated.** A `RET-*` rule is **not** an answer to a `U-*` uncertainty. ⭐ Adopting `RET-01`…`RET-13` reduced the **surface** of Liboora's exposure; ⛔ it did **not** resolve one single legal question, and ⛔ **mitigation is not compliance**.

---

## 1. Register

| ID | Title | Status | Opened by | Severity |
|---|---|---|---|---|
| **`LR-01`** | Data-retention legal basis for `StudentAttendance`, `StudentRecord` financial history, biometric-adjacent data and register images is **UNDETERMINED** | ⛔⛔ **PERMANENTLY OPEN** | `ADR-0137` | ⚠⚠ **HIGH and UNQUANTIFIED** |

---

## 2. `LR-01` — full entry

| Field | Value |
|---|---|
| **ID** | **`LR-01`** |
| **Title** | Data-retention legal basis for `StudentAttendance`, `StudentRecord` financial history, biometric-adjacent data and register images is **UNDETERMINED** |
| **Opened** | 2026-09-11, by `Accepted` [`ADR-0137`](adr/ADR-0137-q-04-reframed-mp-dep-07-discharged-legal-risk-opened-as-lr-01.md) |
| **Origin** | The legal content of BC Map `Q-04`, **transferred — NOT extinguished** — when `ADR-0137` reframed `Q-04` from a legal question into an internal data-governance question |
| **Status** | ⛔⛔ **PERMANENTLY OPEN.** Closable **ONLY** by an authoritative external determination (§5). ⛔ **NOT closable by Product, Domain, Architecture, Technical, Privacy, Governance, SRE, EVENT-platform or DATA/EVENT Owner, jointly or severally.** ⛔ **NOT closable by the passage of time.** ⛔ **NOT closable by this agent.** |
| **Type** | **Legal risk.** ⛔ **NOT an implementation blocker** (§0.2) |
| **Risk custodian** | **Architecture Owner** — custodian of the record only |
| **Risk bearer** | ⭐ **The human principal of this engagement** — the risk is borne, not delegated |
| **Severity** | ⚠⚠ **HIGH and UNQUANTIFIED.** ⛔ **No severity score, likelihood or impact figure is asserted** — scoring would require the legal analysis that **does not exist** |
| **Mitigations** | `RET-01`…`RET-13` (`ADR-0137` §4). ⚠⚠ **Mitigation is NOT compliance** |
| **Blocks** | ⛔ **Nothing.** ⭐ It accompanies the V1 schema freeze rather than blocking it |
| **Related, all still OPEN and UNAMENDED** | blocker **7a** · `ATT-GAP-005` · `ATT-GAP-014` · `ATT-GAP-016` · `AUD-GAP-001` · `MP-NFR-10` (*"SECURITY + DATA Governance"* — constituted nowhere) · `MP-GBR-04` (*"retained under legal basis"* — **UNSUPPORTED**) |

---

## 3. `LR-01` §D-1 — What is unresolved

⛔⛔ **All thirteen uncertainties below are UNRESOLVED.** They are carried from `ADR-0137` §6 and are reproduced here in full because this register, not the ADR, is the living record.

| # | Uncertainty | Status |
|---|---|---|
| `U-1` | Whether DPDP Act 2023 §8(7) purpose-cessation erasure reaches `StudentAttendance` | ⛔ **UNRESOLVED** |
| `U-2` | Whether DPDP Rules 2025 r.8(3)'s one-year floor is a general floor (Construction 1), Seventh-Schedule-limited (Construction 2), or hybrid (Construction 3) | ⛔ **UNRESOLVED** — three live constructions, none authoritative |
| `U-3` | Whether §12(3)'s *"necessary for the specified purpose"* limb permits refusal of a student erasure request | ⛔ **UNRESOLVED** |
| `U-4` | Whether §9 verifiable-parental-consent duties attach to Liboora's under-18 users | ⛔ **UNRESOLVED** |
| `U-5` | Whether §9(3)'s behavioural-monitoring prohibition reaches attendance analytics | ⛔ **UNRESOLVED** |
| `U-6` | Whether SPDI Rules 2011 r.5(4) governs attendance at all — r.3 is a **CLOSED list of 8** categories and ordinary attendance appears to fall within none | ⛔ **UNRESOLVED** — prospect materially reduced, **not eliminated** |
| `U-7` | Whether *Puttaswamy* ¶205 (⚠ in **A.K. SIKRI, J.**'s opinion) constrains multi-year archival of minors' records in a private context | ⛔ **UNRESOLVED** |
| `U-8` | Whether the §40(2)(z) residual rule-making power cures a r.8(3) *ultra vires* argument | ⛔ **UNRESOLVED** — ⚠ the counter-argument **AGAINST** Liboora's convenient reading |
| `U-9` | Whether any state education, tax, or record-keeping statute imposes an independent retention floor | ⛔ **NOT RESEARCHED** |
| `U-10` | Whether pseudonymisation under `MP-GBR-04` has any legal effect on retention obligations | ⛔ **UNRESOLVED** — treated as **security only** (`RET-09`) |
| ⭐⭐ `U-11` | Whether *"no automatic deletion"* is itself lawful as an interim posture — i.e. **whether indefinite retention is permissible at all** | ⛔⛔ **UNRESOLVED — THE CENTRAL RESIDUAL RISK** |
| `U-12` | Whether Liboora will be notified a Significant Data Fiduciary (§10) | ⛔ **UNRESOLVED** |
| ⭐⭐ `U-13` | Whether managed-BaaS backup / PITR expiry constitutes retention-relevant deletion — **and what the actual configured window IS** | ⛔⛔ **NOT MEASURED, NOT RATIFIED** |

### 3.1 ⛔⛔ `U-11` — stated plainly

⛔⛔ **`RET-03` ("no automatic deletion in application code or configuration") is an INTERNAL INTERIM PRODUCT CHOICE MADE IN THE ABSENCE OF A DETERMINATION.**

⛔ It is **NOT** a finding that indefinite retention is legally permissible.
⛔ It **MUST NEVER** be cited as one.
⭐ Whether that posture is lawful at all is **`U-11`**, and it is **UNRESOLVED**.

### 3.2 ⭐⭐ `U-13` — the boundary Liboora does not control

⚠⚠ The V1 backend runtime is a **managed BaaS (Supabase)** — established by `Accepted` [`ADR-0116`](adr/ADR-0116-v1-backend-runtime-supabase.md) (`BC-30` Offline Sync) and `Accepted` [`ADR-0124`](adr/ADR-0124-v1-authentication-backend-runtime-baas.md) (authentication).

⚠ Managed BaaS backup / point-in-time-recovery data **may auto-expire on a VENDOR-SET schedule that Liboora has NOT chosen, reviewed or ratified.** ⛔ Liboora's application **cannot bind vendor infrastructure** to an internal retention rule, so `RET-02` and `RET-03` do **not** reach it.

⚠⚠ **MEASURED DISCLOSURE, so that no reader over-reads the citation above:** ⛔ **NEITHER `ADR-0116` NOR `ADR-0124` governs, references, ratifies or mentions any backup, PITR or expiry schedule.** `ADR-0124` contains **0** occurrences of *backup*, *PITR*, *point-in-time*, *retention* or *restore*; `ADR-0116` mentions retention **only** to say *"**no** retention period"* and *"⛔ **No value.** `Q-04` open"*. ⛔⛔ **NO governed Liboora document addresses backup/PITR expiry at all.** ⭐ **That makes this gap WIDER, not narrower.**

⛔ This possible **de-facto infrastructure retention boundary** is:
- ⛔ **NOT adopted** as Liboora's retention period
- ⛔ **NOT endorsed** as lawful
- ⛔ **NOT a product retention decision**

⭐⭐ **Its actual configured window MUST BE MEASURED at the first `LR-01` review** (§6).

⛔⛔ **Until that window is measured, NO unqualified global statement such as *"there is no automatic deletion anywhere"* may be made in any Liboora document.** ⭐ Wherever the interim posture is described, it must be qualified as applying **at the application layer only**.

---

## 4. `LR-01` §D-2 — Primary sources read, and their limits

⚠⚠ **All readings below are AI research-assistant output. ⛔ NOT legal advice. ⛔ NOT reviewed by any qualified Indian advocate. ⛔ NOT a determination.**

| Source | What was established | ⛔ What was NOT established |
|---|---|---|
| **DPDP Act 2023** (Act 22 of 2023), Gazette `CG-DL-E-12082023-248045` | §1(2) commencement by notification; §8(5); §8(7)(a)–(b) + Illustration II; §8(8); §9(1)–(5); §12(1)–(3); §17(2)(b); §40(1), §40(2)(a)–(z); §44(2)(a) | ⛔ Whether any of it reaches `StudentAttendance`; ⛔ **no retention period is stated anywhere in the Act** |
| **DPDP Rules 2025**, G.S.R. 846(E), `CG-DL-E-14112025-267650` | r.1(2)–(4); r.3; r.8(1)–(3) + Illustrations 1–2; **r.9 (contact-information publication — ⛔ NOT retention)**; r.10; r.12; r.13; r.14; r.16; r.23(1); Second/Third/Fourth/Seventh Schedules | ⛔ Which of **three** live constructions of r.8(3) is correct (`U-2`) |
| **G.S.R. 843(E)**, `CG-DL-E-14112025-267647`, 13.11.2025 | Clause (c): §§3–5, §6(1)–(8)&(10), **§§7–10**, **§§11–17**, §27 (except cl.(d) of sub-s.(1)), §§28–34, 36, 37 and §44(2) commence **eighteen months** from publication — **approximately 13 May 2027**. ⚠ **This is a legal COMMENCEMENT date ONLY; ⛔ it is NOT a retention period** | ⛔ Nothing about the **content** of any substantive obligation |
| **SPDI Rules 2011** | r.3 is a **CLOSED list of 8** categories; r.5(4) imposes purpose-limitation with ⛔ **no period** | ⛔ Whether attendance falls within any r.3 category — on this reading it does **not**, materially **reducing but NOT eliminating** the prospect (`U-6`) |
| ***K.S. Puttaswamy* (2018)**, official SCI source | ¶205 + conclusion (a): five-year archival *"held to be bad in law"*. ⚠ **¶205 sits in A.K. SIKRI, J.'s opinion** | ⛔ Whether it binds a private library-management context (`U-7`) |
| ⭐⭐ **Managed-BaaS backup / PITR window** | ⛔ **NOTHING — NOT MEASURED, NOT RATIFIED, and addressed by NO governed Liboora document** (`U-13`, §3.2) | ⛔ The configured window; ⛔ whether its expiry is retention-relevant |

⚠ **Source-provenance caveat:** two primary instruments were read via **third-party mirrors** — **G.S.R. 843(E)** via `dpdpa.com` and the **SPDI Rules 2011** via `dataguidance.com`. ⛔ **Both require confirmation against the e-Gazette** before any reliance.

---

## 5. `LR-01` §D-3 — Closure conditions

⛔⛔ **ALL FIVE are required. `LR-01` does not close on any subset.**

1. ⭐ A **written determination from a qualified Indian advocate** — or a competent authority, court, or Data Protection Board ruling — addressing `U-1`…`U-13`
2. ⭐ That determination recorded in a **NEW ADR** — ⛔ `ADR-0137` may **not** be edited (`ADR-INDEX` **L206**)
3. ⭐ A retention **period**, or an express determination that **none is required**, adopted by **the office the determination identifies**
4. ⭐ `ATT-GAP-005`, `ATT-GAP-014`, `ATT-GAP-016`, `AUD-GAP-001` and blocker **7a** each **dispositioned**
5. ⭐ `MP-GBR-04`'s *"retained under legal basis"* clause either **substantiated or amended** — ⛔ it is currently **UNSUPPORTED**

---

## 6. `LR-01` §D-4 — Escalation ladder and review triggers

⚠⚠ **EVERY DATE IN THIS SECTION IS A REVIEW OR COMMENCEMENT DATE. ⛔ NONE IS A RETENTION PERIOD, DELETION DEADLINE, TTL OR PURGE SCHEDULE.**

| When | Action |
|---|---|
| On adoption of `ADR-0137` | `LR-01` recorded; risk **accepted in writing** by the human principal |
| Any trigger `T-1`…`T-12` fires | ⭐ **Mandatory review within 30 days** ⚠ *(a review turnaround target — ⛔ NOT a retention or deletion period)* |
| **2026-11-01** | First scheduled review ⚠ *(a **review date only** — ⛔ NOT a retention period)* |
| **2027-02-01** | ⚠⚠ **HARD ESCALATION.** If `LR-01` is still open, engaging counsel becomes **unavoidable** and this becomes a **release-blocking** risk ⚠ *(a **review/escalation date only** — ⛔ NOT a retention period)* |
| **~2027-05-13** | ⛔⛔ DPDP §§7–17 **COMMENCE** (G.S.R. 843(E) cl. (c)). Operating past this date with `LR-01` open is **unmitigated exposure** ⚠ *(a **legal commencement date only** — ⛔ NOT a retention period)* |

### 6.1 Review triggers

| ID | Trigger | Priority |
|---|---|---|
| **`T-1`** | ⭐⭐ **DPDP §§7–17 COMMENCE — ~2027-05-13** (G.S.R. 843(E) cl. (c): eighteen months from 2025-11-13). ⚠ **HARD DEADLINE.** ⛔ *Commencement timing only — NOT a retention period* | ⛔⛔ **HIGHEST** |
| **`T-2`** | Any further commencement notification, amendment or correction to the DPDP Act or Rules — including any change to r.8(3) or the Seventh Schedule | ⛔ CRITICAL |
| **`T-3`** | Any **Data Protection Board** order, direction, guidance, FAQ or enforcement action touching retention or erasure | ⛔ CRITICAL |
| **`T-4`** | Any **binding judicial decision** on DPDP retention/erasure, on the §8(7)/§12(3) interaction, or applying *Puttaswamy* ¶205 to private-sector retention | ⛔ CRITICAL |
| **`T-5`** | ⭐ Liboora is **notified a Significant Data Fiduciary** (§10), or crosses any threshold making notification foreseeable | ⛔ CRITICAL |
| **`T-6`** | Any **state or sectoral** education, tax or record-keeping obligation identified (⚠ `U-9` — **NOT RESEARCHED**) | ⚠ HIGH |
| **`T-7`** | ⭐ Liboora **engages a qualified Indian advocate for ANY purpose** — `LR-01` must be tabled in that engagement | ⚠ HIGH |
| **`T-8`** | Any **erasure request received** (`RET-07`) — the **first** request triggers review regardless of outcome | ⚠ HIGH |
| **`T-9`** | Any actual or suspected **personal-data breach** involving retained attendance, financial, biometric-adjacent or register-image data | ⚠ HIGH |
| **`T-10`** | ⭐ Any proposal to **set a retention period, add a TTL, add a cron/purge job, add automatic deletion, compute a duration under `RET-12`, or amend `RET-01`…`RET-13`** — ⛔ **NOT implementable without a NEW ADR** and the authority the law identifies | ⚠ HIGH |
| **`T-11`** | ⭐ Any proposal to **cite `RET-03`, `RET-06` or `RET-13` as legal justification** — ⛔ **automatic REJECT** + mandatory review | ⚠ HIGH |
| **`T-12`** | ⭐⭐ **Measure the managed-BaaS backup/PITR window** (`U-13`) — mandatory at the **first** review; thereafter **quarterly review cadence**, unconditionally ⚠ *(a **review cadence only** — ⛔ NOT a retention period)* | ⚠ **HIGH** |

---

## 7. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-11 | ⭐⭐ **Created by `Accepted` [`ADR-0137`](adr/ADR-0137-q-04-reframed-mp-dep-07-discharged-legal-risk-opened-as-lr-01.md).** Register constituted at **Rank 7**, **mutable**, with the sole initial entry **`LR-01`** — ⛔ **PERMANENTLY OPEN**, carrying uncertainties **`U-1`…`U-13`** (all UNRESOLVED) and triggers `T-1`…`T-12`. ⛔ **No legal opinion. No compliance claim. No retention period, TTL, purge schedule, cron or deletion deadline. No legal uncertainty resolved. `LR-01` is NOT a blocker, and blocker 7a remains OPEN and UNAMENDED.** |

---

*End of the Legal-Risk Register v1.0. ⛔ **This document records unresolved legal risk. It does NOT resolve it, and it is NOT legal advice.*** ⚠ **`LR-01` is OPEN.**
