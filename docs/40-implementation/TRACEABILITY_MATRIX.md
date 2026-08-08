# Liboora — Requirements Traceability Matrix

| Field | Value |
|---|---|
| **Version** | v1.3 |
| **Status** | Active — updated with every requirement implemented |
| **Date** | 2026-08-02 · extended 2026-08-03 · **extended 2026-08-04** |
| **Baseline** | **BASELINE-2026-08-04-B** |
| **Sources** | Authentication PRD v2.0 · Library PRD **v1.1** + §14A + §14B + Invitation Security Specification · Student Identity & Profile PRD v1.0 · **Student Management PRD v1.0 (`PRD-004`, `DRAFT`)** |
| **ADRs applied** | `ADR-0001` … **`ADR-0017`** |

---

## 1. Purpose

Maps every specification identifier to the artefact that satisfies it. Answers three questions that would
otherwise be answered by memory:

1. **Is this requirement implemented?**
2. **Which test proves it?**
3. **If I change this code, which requirements might I break?**

The **Status** column is the live record. It is updated in the same commit as the code, per `DEFINITION_OF_DONE.md`
Gate 2.

---

## 2. Identifier inventory — Authentication

Verified mechanically against `Authentication_PRD_v2.md`. **Zero collisions.**

| Prefix | Meaning | Count | Range |
|---|---|---|---|
| `AUTH-c.n` | Functional requirement | **588** | `AUTH-1.1` … `AUTH-11.81` |
| `BR-c.n` | Business rule | **297** | Chapters 2–10 |
| `XC-c.n` | Exclusion — must be impossible | **212** | Chapters 2–10 |
| `AC-c.n` | Acceptance criterion | **321** | Chapters 2–11 |
| `PR-n` | Product principle | 2 | Chapter 1 |
| `TR-n` | Trust requirement | 5 | Chapter 1 |
| `EV-n` | Domain event | **26** | Chapter 10 |
| `AERR-n` | Error class (closed set) | **13** | Chapter 11 |
| `CFG-n` | Configurable parameter | **12** | Cover §E |
| `SO-n` | Security objective | 10 | Chapter 8 |
| `PP-n` | Privacy principle | 10 | Chapter 8 |
| `AU-n` | Audit principle | 9 | Chapter 10 |
| `EP-n` | Event principle | 12 | Chapter 10 |

**Total normative identifiers: 1,517.**

---

## 2A. Identifier inventory — Library Management

Verified mechanically across the four Library specification documents. **Zero collisions with the authentication
register** — every Library prefix is distinct from every authentication prefix, deliberately.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `LIB-n.m` | Functional requirement | ~**130** | `LIB-4.1` … `LIB-26.2` | `Library_PRD_v1.md` §§1–25 |
| `LIB-14B.n` | Public preview requirement | **51** | `LIB-14B.1` … `LIB-14B.51` | §14B |
| `LIB-DISC-n` | Discovery requirement | **13** | `LIB-DISC-001` … `013` | §14A |
| `INV-SEC-n` | Invitation security requirement | **71** | `INV-SEC-001` … `071` | Invitation Security Specification |
| `LBR-n` | Library business rule | 8 | `LBR-1` … `LBR-8` | `Library_PRD_v1.md` |
| `LIB-PREV-n` | Preview business rule | 13 | `LIB-PREV-001` … `013` | §14B |
| `LXC-n` | Library exclusion — must be impossible | 10 | `LXC-1` … `LXC-10` | `Library_PRD_v1.md` |
| `INV-XC-n` | Invitation exclusion — out of scope, not deferred | 7 | `INV-XC-1` … `INV-XC-7` | Invitation Security Specification |
| `LAC-n` | Library acceptance criterion | 12 | `LAC-1` … `LAC-12` | `Library_PRD_v1.md` |
| `LAC-14B-n` | Preview acceptance criterion | 16 | `LAC-14B-1` … `16` | §14B |
| `IAC-n` | Invitation acceptance criterion | 25 | `IAC-1` … `IAC-25` | Invitation Security Specification |
| `LCFG-n` | Library configurable | 13 | `LCFG-1` … `LCFG-13` | §16.1, §14B.9 |
| `ICFG-n` | Invitation configurable | 10 | `ICFG-1` … `ICFG-10` | Invitation Security Specification §11 |
| `LEV-n` | Library domain event | 28 | `LEV-1` … `LEV-28` | §21.1 + invitation events |
| `PO-n` | Protected operation (**closed list**) | 12 | `PO-1` … `PO-12` | §14B.6 |
| `IT-n` | Invitation type (**closed set**) | 3 | `IT-1`, `IT-2`, `IT-3` | Invitation Security Specification §2 |

**Total Library normative identifiers: ~422.**

### 2A.1 Two registers that must not be confused

| Looks similar | Actually |
|---|---|
| `INV-n` | **Platform invariant** — `INV-1`…`INV-16`, in `CONFIGURATION_GUIDE.md` §3. A relationship between configurable values that must hold at startup |
| `INV-SEC-n` | **Invitation security requirement** — a numbered requirement in the Invitation Security Specification |
| `INV-XC-n` | **Invitation exclusion** — something deliberately out of scope |

These three share a prefix and mean different things. When citing one, cite it in full. `INV-4` and `INV-SEC-004`
are unrelated.

---

## 2B. Identifier inventory — Student Identity & Profile

Verified mechanically against `Student_Identity_PRD_v1.md`. **Zero gaps and zero out-of-range identifiers in
every register** — each range below is contiguous from 1 to its stated maximum, because §0 of that PRD publishes
the ranges as a promise and a gap would make the promise false.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `SID-c.n` | Functional requirement | **226** | `SID-1.1` … `SID-5.51` | Chapters 1–5 |
| `SID-BR-n` | Business rule | 18 | `SID-BR-1` … `SID-BR-18` | §2.9 |
| `SXC-n` | Exclusion — must be impossible | 11 | `SXC-1` … `SXC-11` | §1.8 |
| `SPO-n` | Protected operation (**closed list**) | 9 | `SPO-1` … `SPO-9` | §5.1 |
| `SEV-n` | Domain event (**closed set**) | 16 | `SEV-1` … `SEV-16` | §4.14 |
| `SID-INT-n` | Forbidden integration | 12 | `SID-INT-1` … `SID-INT-12` | §4.16 |
| `SID-INV-n` | Domain invariant | 14 | `SID-INV-1` … `SID-INV-14` | §5.4 |
| `SCFG-n` | Configurable parameter | 11 | `SCFG-1` … `SCFG-11` | §5.5 |
| `SID-AC-n` | Acceptance criterion — **the module's only acceptance register** | 26 | `SID-AC-1` … `SID-AC-26` | §5.6 |

**Total Student Identity normative identifiers: 343.**

Per-chapter requirement counts: Ch 1 = 38 · Ch 2 = 42 · Ch 3 = 39 · Ch 4 = 56 · Ch 5 = 51.

### 2B.1 Prefix collisions checked, and the two that nearly happened

Every Student Identity prefix is distinct from every authentication and Library prefix. Two were changed
deliberately during authoring to keep them so:

| Candidate | Rejected because | Used instead |
|---|---|---|
| `INV-n` for Student Identity invariants | Already means **platform invariant** (`CONFIGURATION_GUIDE.md` §3) and is already overloaded with `INV-SEC-n` and `INV-XC-n` — see §2A.1 | `SID-INV-n` |
| `AC-n` for Student Identity acceptance | Already means **authentication acceptance criterion**, 321 of them | `SID-AC-n` |

`SPO-n` and `PO-n` are the pair most likely to be confused in conversation, and they are **not** the same
register:

| Looks similar | Actually |
|---|---|
| `PO-1` … `PO-12` | **Protected operations behind the public Library preview** — the authentication boundary for anonymous visitors (`14B-Public-Library-Preview.md` §14B.6) |
| `SPO-1` … `SPO-9` | **Protected operations on a Global Person Identity** — who may mutate global profile state (`Student_Identity_PRD_v1.md` §5.1) |

One governs an anonymous read surface; the other governs authenticated writes to a person's own identity.
Citing `PO-3` when `SPO-3` was meant would move a requirement from one bounded context to another.

`SEV-n` versus `EV-n` versus `LEV-n` are three separate event registers — `BC-18`, Global Person Identity and
Library Management respectively. They are numbered independently and overlap numerically on purpose; the prefix
carries the producer.

---

## 2C. Identifier inventory — Student Management & Library Members Directory

Verified mechanically against `Student_Management_PRD_v1.md` (`PRD-004`, **`DRAFT`**). Every range below is
contiguous from 1 to its stated maximum.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `SM-c.n` | Functional requirement | **105** | `SM-1.1` … `SM-10.10` | Chapters 1–4, 6–8, 10 |
| `SM-BR-n` | Business rule | 16 | `SM-BR-1` … `SM-BR-16` | §9.1 |
| `SM-XC-n` | Exclusion — must be impossible | 14 | `SM-XC-1` … `SM-XC-14` | §1.5 |
| `SM-INV-n` | Domain invariant | 11 | `SM-INV-1` … `SM-INV-11` | §2.6 |
| `SM-EV-n` | Domain event (**closed set**) | 9 | `SM-EV-1` … `SM-EV-9` | §7.4 |
| `SM-PO-n` | Protected operation (**closed list**) | 12 | `SM-PO-1` … `SM-PO-12` | §8.2 |
| `SM-AC-n` | Acceptance criterion | 28 | `SM-AC-1` … `SM-AC-28` | §10.4 |
| `SMCFG-n` | Configurable parameter | 7 | `SMCFG-1` … `SMCFG-7` | §10.3 |
| `LMD-n` | **Library Members Directory requirement** | 31 | `LMD-1` … `LMD-31` | Chapter 5 |
| `SM-GAP-n` | **PROPOSED GAP** — no authoritative source | 9 | `SM-GAP-1` … `SM-GAP-9` | §10.6 |

**Total Student Management normative identifiers: 242**, of which **9 are proposed gaps carrying no authority**.

Per-chapter `SM-c.n` counts: Ch 1 = 8 · Ch 2 = 16 · Ch 3 = 17 · Ch 4 = 12 · **Ch 5 = 0** · Ch 6 = 8 · Ch 7 = 17 ·
Ch 8 = 17 · **Ch 9 = 0** · Ch 10 = 10.

**Chapters 5 and 9 hold no `SM-c.n`, by design.** Chapter 5 numbers exclusively in `LMD-n` so that a
read-composition requirement can never be mistaken for a `BC-01` domain requirement; chapter 9 numbers
exclusively in `SM-BR-n`. Both are intentional, which is why the per-chapter table above exists instead of a
single unchecked range.

> ⚠ **This register was corrected by validation before first use.** §0 of `PRD-004` initially declared **118**
> `SM-c.n` over `SM-1.1` … `SM-10.6`, giving a total of 246. A mechanical count returned **105** over
> `SM-1.1` … `SM-10.10`, total **242**. **The register was corrected to match the chapters; no filler requirement
> was added to reach 118.** Padding would have satisfied the declared number while corrupting the specification —
> the precise failure `SID-4.56` describes.

### 2C.1 Prefix collisions checked — and the substring that is *not* one

**Zero collisions** against all three existing registers (authentication `AUTH`/`BR`/`XC`/`AC`/`PO`/`EV`/`CFG`,
Library `LIB`/`LCFG`/`LXC`/`LEV`/`LAC`, Student Identity `SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/`SID-INV`/
`SCFG`/`SID-AC`). Three near-collisions were avoided deliberately:

| Candidate | Rejected because | Used instead |
|---|---|---|
| `BR-n` for business rules | Already means **authentication business rule**, 297 of them | `SM-BR-n` |
| `PO-n` for protected operations | Already the public-preview register (§2B.1), and `SPO-n` had already been added to disambiguate | `SM-PO-n` |
| A broad `SM-` match | Matches **`MP-SM-01`…`MP-SM-09`** in `MASTER_PRD.md` lines 653–661 | see below |

**`MP-SM-0n` is a true negative, not a suppressed hit.** Those nine identifiers are **Certified Metric** IDs
under the prefix `MP-SM-`, not requirements. A strict word-boundary search returns empty:

```
grep -rIno "\(^\|[^-A-Za-z]\)SM-[0-9]\+\.[0-9]\+" docs --include=*.md | grep -v student-management/   → (empty)
```

The loose match was **inspected rather than accepted as a failure**, because a checker that cannot distinguish a
real collision from a substring is a checker that gets switched off.

`LMD-n` and `LIB-n.m` are also distinct registers despite both concerning library surfaces: `LMD-n` is the
Directory read composition inside `BC-01`; `LIB-n.m` is Library Management (`BC-06`/`BC-19`). `LCFG-5` is cited by
`SMCFG-1` rather than duplicated — `SMCFG-1` **is** `LCFG-5`, consumed through `E-19`.

---

## 3. Chapter map

| Ch | Title | `AUTH` | `BR` | `XC` | `AC` | Implementation task | Status |
|---|---|---|---|---|---|---|---|
| 1 | Purpose and Goals | 1.1–1.5 | — | — | — | *(non-functional framing)* | N/A |
| 2 | User Types and Roles | 2.1–2.26 | 2.1–2.20 | 2.1–2.16 | 2.1–2.20 | `IMPL-050` | ⬜ Not started |
| 3 | Authentication Methods | 3.1–3.31 | 3.1–3.20 | 3.1–3.14 | 3.1–3.20 | `IMPL-020`, `IMPL-030` | ⬜ Not started |
| 4 | Registration and Account Claim | 4.1–4.37 | 4.1–4.25 | 4.1–4.16 | 4.1–4.26 | `IMPL-031` | ⬜ Not started |
| 5 | Login and Library Selection | 5.1–5.38 | 5.1–5.22 | 5.1–5.18 | 5.1–5.24 | `IMPL-030`, `IMPL-040` | ⬜ Not started |
| 6 | Session and Device Management | 6.1–6.75 | 6.1–6.34 | 6.1–6.22 | 6.1–6.34 | `IMPL-040`, `IMPL-041` | ⬜ Not started |
| 7 | Roles, Permissions, Access Policies | 7.1–7.73 | 7.1–7.33 | 7.1–7.26 | 7.1–7.32 | `IMPL-050`, `IMPL-051`, `IMPL-052` | ⬜ Not started |
| 8 | Security and Privacy | 8.1–8.105 | 8.1–8.64 | 8.1–8.36 | 8.1–8.44 | `IMPL-021`, `TASK-D10` | ⬜ Not started |
| 9 | Account Lifecycle | 9.1–9.80 | 9.1–9.44 | 9.1–9.36 | 9.1–9.46 | `IMPL-060` | ⬜ Not started |
| 10 | Events, Audit, Notifications | 10.1–10.37 | 10.1–10.35 | 10.1–10.28 | 10.1–10.38 | `IMPL-061`, `IMPL-062` | ⬜ Not started |
| 11 | NFR, Compliance, Final Acceptance | 11.1–11.81 | — | — | 11.1–11.37 | `IMPL-070`…`IMPL-073` | ⬜ Not started |

**Status vocabulary:** ⬜ Not started · 🟨 In progress · ✅ Implemented and tested · ⛔ Blocked

**Everything is `Not started`.** The specification was authored this baseline; no chapter has been implemented
against it. Existing code predates the specification and must be verified against it, not assumed to conform.

---

## 3A. Chapter map — Library Management

| § | Subject | Requirements | Implementation task | Status |
|---|---|---|---|---|
| 1–3 | Purpose, scope, definitions | `LIB-1.*`…`LIB-3.*` | *(framing)* | N/A |
| 4 | Roles consumed from `BC-18` | `LIB-4.1`…`LIB-4.4` | `IMPL-112` | ⬜ Not started |
| 5 | Staff as accounts holding roles | `LIB-5.1`…`LIB-5.4` | `IMPL-112` | ⬜ Not started |
| 6 | Library profile | `LIB-6.1`…`LIB-6.6` | `IMPL-102`, `IMPL-109` | ⬜ Not started |
| 7 | Public visibility | `LIB-7.1`…`LIB-7.3` | `IMPL-120` | ⬜ Not started |
| 8 | Lifecycle | `LIB-8.1`…`LIB-8.11` | `IMPL-101` | ⬜ Not started |
| 9–11 | Branch, floor, zone | `LIB-9.*`…`LIB-11.5` | `IMPL-104` | ⬜ Not started |
| 12 | Operating hours, holidays, closure | `LIB-12.1`…`LIB-12.8` | `IMPL-105` | ⬜ Not started |
| 13 | Facilities | `LIB-13.1`…`LIB-13.6` | `IMPL-106` | ⬜ Not started |
| 14 | Visibility (Public / Private) | `LIB-14.1`…`LIB-14.7` | `IMPL-101`, `IMPL-120` | ⬜ Not started |
| **14A** | Discovery and enrollment | `LIB-DISC-001`…`013` | `IMPL-122` | ⬜ Not started |
| **14B** | **Public preview** | `LIB-14B.1`…`51`, `PO-1`…`PO-12` | `IMPL-120`, `121`, `123`, `124`, `125` | ⬜ Not started |
| 15 | Staff and role assignment | `LIB-15.1`…`LIB-15.13` | `IMPL-112` | ⬜ Not started |
| 16 | Settings | `LIB-16.1`…`LIB-16.9` | `IMPL-107`, `IMPL-127` | ⬜ Not started |
| 17 | Business policies | `LIB-17.1`…`LIB-17.5` | `IMPL-108` | ⬜ Not started |
| 18 | Identifiers | `LIB-18.1`…`LIB-18.4` | `IMPL-100` | ⬜ Not started |
| 19 | Read models | `LIB-19.1`…`LIB-19.10` | `IMPL-120` | ⬜ Not started |
| 20 | Audit | `LIB-20.*` | `IMPL-103` | ⬜ Not started |
| 21 | Events and integration boundaries | `LIB-21.1`…`LIB-21.5`, `LEV-1`…`LEV-28` | `IMPL-126` | ⬜ Not started |
| 22–25 | NFR, exclusions, acceptance | `LXC-1`…`10`, `LAC-1`…`12` | All | ⬜ Not started |
| 26 | Ownership boundary | `LIB-26.1`, `LIB-26.2` | *(governance)* | N/A |
| — | **Invitation security** | `INV-SEC-001`…`071` | `IMPL-110`…`IMPL-114` | ⬜ Not started |

**Every Library row is `Not started`, and this is not a formality.** There is no tenancy module, no library
aggregate, no public projection and no invitation mechanism in `lib/`. Unlike authentication — where code predates
the specification and must be *verified* against it — Library Management has nothing to verify. The two situations
look identical in this column and are not: one is unproven, the other is absent.

---

## 3B. Chapter map — Student Identity & Profile

| § | Subject | Requirements | Implementation task | Status |
|---|---|---|---|---|
| 0 | How to read; register index | — | *(framing)* | N/A |
| 1.1–1.7 | Purpose, problem, responsibilities, objectives, scope, metrics | `SID-1.1`…`SID-1.24` | *(framing)* | N/A |
| **1.8** | **Exclusion register** | `SXC-1`…`SXC-11` | `IMPL-220`, `IMPL-226` | ⬜ Not started |
| 1.9–1.10 | Assumptions, constraints | `SID-1.25`…`SID-1.33` | *(framing)* | N/A |
| **1.11** | **Identity architecture** *(authoritative, `ADR-0011`)* | `SID-1.34`…`SID-1.38` | `IMPL-200`, `IMPL-203` | ⬜ Not started |
| 2.1 | Identity model — `1:1` Account ↔ Identity | `SID-2.1`…`SID-2.8` | `IMPL-202`, `IMPL-203` | ⬜ Not started |
| 2.2 | Global Profile fields | `SID-2.9`…`SID-2.16` | `IMPL-210` | ⬜ Not started |
| 2.3 | Internal identity — `PersonId`, Username | `SID-2.17`…`SID-2.26` | `IMPL-201`, `IMPL-211` | ⬜ Not started |
| **2.4** | **Profile privacy — Private is the default** | `SID-2.27`…`SID-2.33` | `IMPL-213` | ⬜ Not started |
| 2.5 | Identity lifecycle | `SID-2.34`…`SID-2.38` | `IMPL-204` | ⬜ Not started |
| 2.6 | Duplicate prevention | `SID-2.39`, `SID-2.40` | `IMPL-211`, `IMPL-224` | ⬜ Not started |
| 2.7 | Profile composition | `SID-2.41`, `SID-2.42` | `IMPL-216` | ⬜ Not started |
| 2.8–2.9 | Ownership boundary; business rules | `SID-BR-1`…`SID-BR-18` | `IMPL-220` | ⬜ Not started |
| 3.1–3.2 | Profile creation | `SID-3.1`…`SID-3.12` | `IMPL-203`, `IMPL-210` | ⬜ Not started |
| 3.3 | View profile | `SID-3.13`…`SID-3.18` | `IMPL-216` | ⬜ Not started |
| 3.4 | Update profile | `SID-3.19`…`SID-3.22` | `IMPL-210` | ⬜ Not started |
| 3.5 | **Global Profile Photo** *(independent of the Library Identification Photo)* | `SID-3.23`…`SID-3.28` | `IMPL-212` | ⬜ Not started |
| 3.6 | Profile privacy controls | `SID-3.29`, `SID-3.30` | `IMPL-213` | ⬜ Not started |
| 3.7 | Profile timeline | `SID-3.31`, `SID-3.32` | `IMPL-215` | ⬜ Not started |
| 3.8 | Permissions | `SID-3.33`, `SID-3.34` | `IMPL-221` | ⬜ Not started |
| 3.9 | Audit events | `SID-3.35`…`SID-3.37` | `IMPL-205` | ⬜ Not started |
| 3.10 | Edge cases | `SID-3.38`, `SID-3.39` | `IMPL-204`, `IMPL-211` | ⬜ Not started |
| 4.1–4.2 | Integration principles; rank 7.5 | `SID-4.1`…`SID-4.10` | `IMPL-200` | ⬜ Not started |
| 4.3 | `BC-18` upstream — `E-12`, atomic creation | `SID-4.11`…`SID-4.16` | `IMPL-203` | ⬜ Not started |
| **4.4** | **`BC-01` downstream — `E-13` ACL, non-nullable `PersonId`** | `SID-4.17`…`SID-4.20` | `IMPL-214` | ⛔ Blocked — `BC-01` absent |
| 4.5–4.6 | `BC-02`…`BC-05`, `BC-26` contributors | `SID-4.21`…`SID-4.30` | `IMPL-216` | ⛔ Blocked — contexts absent |
| **4.7** | **`BC-11`…`BC-13` consumers only — the falsifiable test** | `SID-4.31`…`SID-4.35` | `IMPL-222` | ⬜ Not started |
| 4.8–4.13 | `BC-29`, `BC-23`, `BC-22`, `BC-24`, `BC-25`; `BC-19` not integrated | `SID-4.36`…`SID-4.42` | `IMPL-212`, `223`, `205`, `206` | ⬜ Not started |
| **4.14** | **Domain events** | `SEV-1`…`SEV-16`, `SID-4.43`…`SID-4.54` | `IMPL-201`, `IMPL-222` | ⬜ Not started |
| 4.15 | Events consumed | `SID-4.55` | `IMPL-222` | ⬜ Not started |
| **4.16** | **Forbidden integrations** | `SID-INT-1`…`SID-INT-12`, `SID-4.56` | `IMPL-220` | ⛔ Blocked — `IMPL-014` absent |
| **5.1** | **Protected operations** | `SPO-1`…`SPO-9`, `SID-5.1`…`SID-5.7` | `IMPL-221` | ⬜ Not started |
| 5.2 | Data protection and minimisation | `SID-5.8`…`SID-5.14` | `IMPL-202`, `IMPL-205` | ⬜ Not started |
| **5.3** | **NFR — measurable targets** | `SID-5.15`…`SID-5.41` | `IMPL-225` | ⬜ Not started |
| **5.4** | **Domain invariants** | `SID-INV-1`…`SID-INV-14`, `SID-5.42`, `SID-5.43` | `IMPL-224`, `IMPL-226` | ⬜ Not started |
| 5.5 | Configurables | `SCFG-1`…`SCFG-11`, `SID-5.44`…`SID-5.46` | `IMPL-206` | ⬜ Not started |
| **5.6** | **Acceptance criteria — the only register** | `SID-AC-1`…`SID-AC-26`, `SID-5.47`…`SID-5.49` | `IMPL-226` | ⬜ Not started |
| 5.7 | Future scope | `SID-5.50`, `SID-5.51` | *(governance)* | N/A |

**Status vocabulary is the same as §3.** Four rows are ⛔ rather than ⬜, and the distinction is load-bearing:
those four are blocked on artefacts outside this module — `BC-01` Student Management does not exist, and
`IMPL-014`, the module boundary checker, does not exist either. Marking them ⬜ would imply they are merely
unstarted and could be picked up next.

**Nothing in this module is `In progress`.** There is no `domain/person` directory, no `PersonId`, no `Person`
aggregate and no rank-7.5 tier in `tool/module_dependencies.yaml`'s enforcement path beyond the declaration
itself. The specification is complete; the implementation is empty.

---

## 4. Decision traceability — ADR to specification

| ADR | Promotes | Governs | Chapters | Task |
|---|---|---|---|---|
| `ADR-0001` | — | Modular monolith | All | `IMPL-014` |
| `ADR-0002` | `MP-GBR-25`, `MP-CON-11` | OTP sole factor | 3, 8 | `IMPL-020`, `TASK-D10` |
| `ADR-0003` | BC Map §11 | Hybrid tenancy | 2, 7 | `IMPL-050` |
| `ADR-0004` | `AR-6` | Two-stage auth | 4, 5, 6 | `IMPL-030` |
| `ADR-0005` | `AR-2` | Account creation on first OTP | 4, 9 | `IMPL-031` |
| `ADR-0006` | `AR-5` | Display name before verification | 4, 9 | `IMPL-031` |
| `ADR-0007` | `AR-7` | Behavioural conformance | 8 | `TASK-D10` D10-8 |
| `ADR-0008` | Closes `D-7` | v2.0 baseline | All | — |
| `ADR-0009` | Completes `AR-4` | Invitation is a claim, not a credential | Invitation spec; Library §15 | `IMPL-110`…`IMPL-114` |
| `ADR-0010` | Extends `AR-3` | Anonymous public access via projection | §14A, §14B | `IMPL-120`…`IMPL-125` |
| **`ADR-0011`** | **Amends BC Map §4 (Identity Triad) and `MP-GBR-02`** | **Global Person Identity: `1:1` with the account, mandatory, `[CORE]`, rank 7.5** | Student Identity §§1.11, 2.1, 4.2–4.4 | `IMPL-200`, `IMPL-203`, `IMPL-214` |

**`ADR-0011` is the only ADR so far that amends the Bounded Context Map's Identity Triad.** Three consequences
are traced rather than left to the ADR text:

| Change | Was | Is | Traced to |
|---|---|---|---|
| `BC-10` cardinality | `0..1`, opt-in, may never exist | **`1:1`, mandatory, created atomically with the account** | `SID-2.1`…`SID-2.8`, `IMPL-203`, `SID-INV-1` |
| `ID-4` — `PersonId` on a Student Record | Nullable | **Non-nullable** | `SID-4.17`, `IMPL-214` |
| `BC-10` rank | 8, inside the Social cluster | **7.5, its own tier below every domain** | `SID-4.1`…`SID-4.3`, `IMPL-200` |

**`ID-1` … `ID-6` are otherwise preserved, and `ID-5` is why.** Account erasure anonymises the Person but does
**not** delete Student Record financial or attendance history. That is the load-bearing reason the three-way
split survives a change that made two of its three parts `1:1` — a `1:1` mapping between account and person does
not imply a `1:1` mapping between person and organisation record, and collapsing the third part would make `ID-5`
unsatisfiable. Traced at `SID-4.23`, `SID-4.54`.

**`X-05` was rescoped, not weakened.** The prohibition now reads `BC-11`…`BC-17`, because `BC-10` is no longer
the social side of it. The operational half is traced at `SID-4.21`: Global Person Identity is not on the critical
path of check-in, seat allocation, fee collection or membership.

---

## 5. Global rule traceability

Master PRD rules constrain the whole platform and outrank the Authentication PRD.

| Rule | Line | Statement | Enforced by | Gate |
|---|---|---|---|---|
| **`MP-GBR-02`** | — | **`PersonId` is mandatory and `1:1` with the account** — amended by `ADR-0011`. Previously: *"opt-in and may never exist; Library operation must degrade gracefully when it is null"* | `IMPL-203`, `IMPL-214`, **`IMPL-224`** | **Merge + Release** |
| `MP-GBR-08` | — | Tenant key mandatory on tenant data | `IMPL-052`, **`IMPL-100`** | Merge + Release |
| `MP-GBR-25` | 378 | Mobile OTP sole V1 factor; no passwords | `ADR-0002`, `IMPL-020` | Merge |
| `MP-GBR-26` | 379 | Revocation immediate and global; no propagation window | `IMPL-040` | Release |
| `MP-GBR-27` | 380 | *(per Master PRD)* | `IMPL-040` | Release |
| `MP-CON-11` | 521 | **No demo or guest accounts in any release build** | **`TASK-D10`** | **Release — blocking** |
| `MP-DEP-03` | 569 | SMS/DLT dependency | `IMPL-020`, **`IMPL-112`** | Release |
| `MP-DEP-06` | — | Module boundary manifest | `IMPL-014` | Merge |

**`MP-GBR-02` is the only global business rule amended since the baseline was established**, and it is traced
here rather than only in the Master PRD changelog because its enforcement is not a code review matter. A rule
stating that something *must always exist* is satisfiable only by a continuously running check: `IMPL-224`
maintains counters for accounts-without-identity and identities-without-account, and both must read zero.
A `1:1` invariant asserted in prose and tested once at merge is not enforced — a later migration can violate it
without any test failing (`SID-5.43`).

---

## 6. Configurable parameter traceability

| `CFG` | Chapters | Governing requirements | Invariants | Task |
|---|---|---|---|---|
| `CFG-1` | 8 | `AUTH-8.16`–`8.23` | `INV-4`, `INV-5` | `IMPL-021` |
| `CFG-2` | 8 | `AUTH-8.16`–`8.23` | `INV-4`, `INV-6` | `IMPL-021` |
| `CFG-3` | 8 | `AUTH-8.16`–`8.23` | `INV-5` | `IMPL-021` |
| `CFG-4` | 8, 9 | `AUTH-8.24`–`8.28` | `INV-4` | `IMPL-021` |
| `CFG-5` | 6 | `AUTH-8.34`–`8.40` | `INV-1`, `INV-2`, `INV-7` | `IMPL-040` |
| `CFG-6` | 6 | `AUTH-8.34`–`8.40` | `INV-1`, `INV-2`, `INV-3`, `INV-8` | `IMPL-040` |
| `CFG-7` | 6 | `AUTH-6.46`, `AUTH-8.41`–`8.47` | `INV-3` | `IMPL-041` |
| `CFG-8` | 6 | `AUTH-8.41`–`8.47` | — | `IMPL-041` |
| `CFG-9` | 9 | Chapter 9 retention | — | `IMPL-060` |
| `CFG-10` | 9 | Chapter 9 retention | — | `IMPL-060` |
| `CFG-11` | 4 | Chapter 4 claim | — | `IMPL-031` |
| `CFG-12` | 2, 7 | `AUTH-7.19` | — | `IMPL-051` |

### 6A. Library and invitation configurables

| Group | Range | Governing requirements | Invariants | Task |
|---|---|---|---|---|
| Library settings | `LCFG-1` … `LCFG-10` | `LIB-16.1`…`LIB-16.9` | *(none — each is independently bounded)* | `IMPL-107`, `IMPL-127` |
| Preview | `LCFG-11` … `LCFG-13` | `LIB-14B.32`…`LIB-14B.42` | `INV-10`, `INV-11`, `INV-12` | `IMPL-124`, `IMPL-125` |
| Invitation TTL | `ICFG-1` … `ICFG-4` | `INV-SEC-016`…`022`, `INV-SEC-035` | `INV-13`, `INV-14`, `INV-15` | `IMPL-111` |
| Invitation limits | `ICFG-5` … `ICFG-10` | `INV-SEC-057`…`063` | `INV-16` | `IMPL-114` |

Stated in full:

| Invariant | Constraint | What breaks if it is violated |
|---|---|---|
| `INV-10` | `LCFG-11` ≤ `CFG-6` | A preserved intent outlives the longest session that could resume it — it can never be used |
| `INV-11` | `LCFG-11` > `CFG-2` × `CFG-1` | A user who takes the full permitted OTP retry cycle loses the thing they were trying to do |
| `INV-12` | `LCFG-13` ≤ 3600 s | Preview cache staleness becomes indefinite |
| `INV-13` | `ICFG-1` ≤ 7 d | A staff invitation outlives any plausible administrative window |
| `INV-14` | `ICFG-3` ≤ `ICFG-2` | The **weakest** artefact (`IT-3`, ≥40 bits, multi-use, read aloud) lives **longest** |
| `INV-15` | `ICFG-4` > `CFG-2` × `CFG-1` | An invitee times out part-way through authentication |
| `INV-16` | `ICFG-6` ≥ 1 | An `IT-3` code is created that nobody can ever redeem |

**`INV-11` and `INV-15` are the same constraint applied twice**, and they exist because the failure they prevent is
invisible in testing. Both bound a Library timeout *below* the maximum legitimate duration of an authentication
flow. A developer testing with a fast OTP will never see the failure; a real user on a slow network, using the
retries `CFG-1` explicitly permits, hits it every time. Neither value can be chosen by looking only at the document
that defines it.

**`INV-14` is the one that looks arbitrary and is not.** `IT-3` access codes have the lowest entropy of the three
types by design — they are short, unambiguous and meant to be spoken aloud to a room. That is acceptable only while
their exposure window stays short. Permitting `ICFG-3` to exceed `ICFG-2` would leave the weakest artefact in
circulation longest, which inverts the entire rationale for allowing a weak artefact at all.

**`LCFG-6` is the one that will be misread.** It is a search-index propagation delay and it applies to *removal
latency only*. It must never gate an authorization, membership, suspension or revocation decision (`LIB-16.9`).
`MP-GBR-26` requires revocation to be immediate and global with no propagation window, and a 60-second index delay
is exactly the propagation window that rule forbids — if anyone wires it into a policy path.

---

### 6B. Student Identity configurables

| Group | Range | Governing requirements | Task |
|---|---|---|---|
| Username rules | `SCFG-1` … `SCFG-5` | `SID-2.17`…`SID-2.26`, `SID-3.38` | `IMPL-211` |
| Profile content | `SCFG-6` … `SCFG-8` | `SID-2.9`…`SID-2.16`, `SID-3.23`…`SID-3.28` | `IMPL-210`, `IMPL-212` |
| Composition timeout | `SCFG-9` | `SID-2.41`, `SID-5.24` | `IMPL-216` |
| Rate limits | `SCFG-10`, `SCFG-11` | `SID-5.36`, anti-enumeration | `IMPL-223`, `IMPL-221` |

**`SCFG-1` … `SCFG-11` are deliberately free of cross-register invariants**, unlike `LCFG-11` and `ICFG-4`,
which are bounded against authentication timeouts by `INV-10`…`INV-16`. No Student Identity configurable sits in
an authentication or session flow, so none can be set to a value that silently truncates one. This is a property
of rank 7.5, not a coincidence: the module is not on the critical path of any timed flow (`SID-4.21`).

Two bounds are nonetheless not free choices:

| Configurable | Constraint | What breaks if it is violated |
|---|---|---|
| `SCFG-5` | Released-username hold period **SHALL NOT** be 0 in production | A username released by one person is claimable by another the same instant, enabling impersonation of a person whose old handle is still in circulation (`SID-2.24`) |
| `SCFG-6` | Bio maximum of 0 **disables** the field | It does not make the field public. A length of 0 is a content decision, never a privacy decision (`SCFG-6` note) |

**No configuration value can change the privacy default.** `SID-5.44` forbids configuration from altering the
default privacy mode, changing the allow-list, disabling an audit event or zeroing `SCFG-5` in production.
`IMPL-206` must reject such a configuration at startup rather than accept it and log a warning — a rejected
configuration is a fixed deployment, an accepted one is a published minor's profile.

---

## 7. Event traceability

| Group | Events | Producer | Task |
|---|---|---|---|
| Identity | `EV-1` … `EV-7` | `BC-18` | `IMPL-061` |
| Authentication | `EV-8` … `EV-12` | `BC-18` | `IMPL-061` |
| Session / Device | `EV-13` … `EV-19` | `BC-18` | `IMPL-061`, `IMPL-041` |
| Authorization | `EV-20` … `EV-26` | `BC-18` | `IMPL-061`, `IMPL-050` |

### 7A. Library events

| Group | Events | Producer | Task |
|---|---|---|---|
| Library lifecycle | `LEV-1` … `LEV-8` | Library Management | `IMPL-126` |
| Structure and hours | `LEV-9` … `LEV-15` | Library Management | `IMPL-126` |
| Staff and settings | `LEV-16` … `LEV-22` | Library Management | `IMPL-126` |
| Invitation | `LEV-23` … `LEV-28` | Library Management | `IMPL-111`, `IMPL-126` |

**No Library event may carry a credential or an unmasked mobile number** (`LIB-21.5`). An event is the one artefact
in the system that is deliberately copied to subscribers who were not part of the original authorization decision;
whatever it carries, it carries everywhere.

**`EV-16` — unrecognised device notification — is security-critical.** It is the sole compensating control for
SIM swap in a single-factor system (`ADR-0002`). It is traced separately in `AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md`.

---

### 7B. Student Identity events

| Group | Events | Producer | Task |
|---|---|---|---|
| Identity lifecycle | `SEV-1`, `SEV-2`, `SEV-12` … `SEV-16` | Global Person Identity (`BC-10`) | `IMPL-203`, `IMPL-204`, `IMPL-222` |
| Profile mutation | `SEV-3`, `SEV-4`, `SEV-7`, `SEV-8` | Global Person Identity | `IMPL-210`, `IMPL-212`, `IMPL-222` |
| Username | `SEV-5`, `SEV-6` | Global Person Identity | `IMPL-211`, `IMPL-222` |
| Privacy and visibility | `SEV-9` … `SEV-11` | Global Person Identity | `IMPL-213`, `IMPL-222` |

**Events consumed** — four, all inbound from higher-authority contexts:

| Event | From | Effect | Task |
|---|---|---|---|
| `iam.AccountErased` | `BC-18` | Anonymise the identity, emit `SEV-16`. **Does not delete organisation history** (`ID-5`, `SID-4.54`) | `IMPL-222` |
| `iam.MobileNumberChanged` | `BC-18` | **No effect on any stored field** — this module never stores a mobile number | `IMPL-222` |
| `iam.AccountSuspended` | `BC-18` | Identity becomes unusable for authenticated action; existence is unaffected | `IMPL-222` |
| `safety.EnforcementActionTaken` | `BC-13` | Restricts the **public projection only** — never lifecycle, never existence | `IMPL-222` |

**The last row is the one a reviewer should check first.** `safety.EnforcementActionTaken` originates in the
social product, and a Trust & Safety action that could suspend or archive a Global Person Identity would make the
social product able to disable a person's identity for the paying library product. `SID-4.32` and `SID-4.33`
restrict its effect to the public projection; `SID-4.31` states the falsifiable test that proves the restriction
holds — **deactivating, disabling or never launching the social product must not affect the existence, validity
or usability of any Global Person Identity.** `IMPL-226` requires a test for it, not an argument.

**No `SEV-n` payload may carry a mobile number, email, parent contact, address, `StudentRecordId`, `tenantId`,
credential or OTP** (`SID-4.52`). Two of those exclusions are structural rather than merely privacy-motivated:
`StudentRecordId` would violate `ID-2` by letting a per-tenant identifier leave its tenant, and `tenantId` would
give a rank-7.5 module knowledge of a tenancy model it is defined not to have (`SID-4.42`, `SID-INT-9`).

**`SEV-1` is not the trigger for identity creation.** Creation is synchronous and transactional with account
creation; `SEV-1` is *"a notification of a completed fact"* (`SID-4.11`, `SID-4.12`). Wiring creation to the event
would open a window in which an account exists without an identity, which the amended `MP-GBR-02` forbids. This is
the most likely way for an implementer to break the `1:1` invariant while believing they are following the
event-driven architecture correctly.

---

## 8. Existing code — conformance unknown

The code predates the specification. These files touch `BC-18` and must be **verified against v2.0**, not assumed
conformant.

| File | Concern | Known status |
|---|---|---|
| `lib/platform/identity/identity.dart` | `AuthService`, challenge issuance, verification | Contains `debugPeekChallenge` — `TASK-D10` |
| `lib/app/session.dart` | Session controller, role resolution | Contains `kDemoChildPhone`, `_otpHint` — `TASK-D10` |
| `lib/app/shell/login_screen.dart` | Login UI | Contains `_seededAccounts()`, OTP auto-fill — `TASK-D10` |
| `lib/bootstrap/di.dart` | Service wiring | Sets `challengePeekEnabled` — `TASK-D10` |
| `test/authentication_conformance_test.dart` | 34 conformance tests | 13 call sites on `debugPeekChallenge` — must migrate to a test-only SMS sink per `ADR-0007` |

**The 34 passing conformance tests do not evidence conformance to v2.0.** They were written against earlier
rulings and cover a fraction of 588 requirements. Re-verification is part of Gate 2, per requirement.

### 8A. Student Identity — existing code implements the *superseded* architecture

**This is not a greenfield module, and treating it as one is the main risk.** Identity code already exists in
`lib/` and `packages/liboora_contracts`, committed in `a44ebb0` (the original scaffold). All of it implements the
**pre-`ADR-0011`** model: a nullable, opt-in, social-owned `PersonId`. Every row below was verified by search.

| Artefact | Location | State | Conflicts with |
|---|---|---|---|
| `PersonId` value object | `packages/liboora_contracts/lib/src/value_objects/identifiers.dart:61` | Exists. Doc comment reads *"the cross-library **social persona**… **May legitimately not exist**"* | `ADR-0011`, `SID-2.1`, amended `MP-GBR-02` |
| `Account.personId` | `lib/platform/identity/identity.dart:43` | **Nullable.** *"Nullable by design — an account may never opt into the social product"* | `SID-INV-1` (`1:1` mandatory) |
| `StudentRecord.personId` | `lib/domain/library/enrollment/domain/student_record.dart:53` | **Nullable.** *"Nullable by design. The consented social bridge (edge E-13)"* | **amended `ID-4`** (non-nullable), `SID-4.17` |
| `GlobalStudentProfile` aggregate | `lib/domain/social/social.dart` | Exists **inside `domain/social`** (rank 8) | `SID-4.1`–`SID-4.3` — identity must be rank 7.5, outside the Social cluster |
| `GlobalProfileReader`, `InMemoryGlobalProfileRepository` | `lib/domain/social/social.dart`; wired at `lib/bootstrap/di.dart:93,206` | Exists, unimplemented port + in-memory store | Ownership: belongs to `domain/person` |
| Seed data | `lib/bootstrap/seed.dart:192,210` | **1 of 5 seeded accounts has a `personId`** | `SID-INV-1` — 4 accounts exist with no identity |
| Rank 7.5 tier declaration | `tool/module_dependencies.yaml` | ✅ **Declared** — `domain/person: 7.5`, ports, banned imports, banned symbols | — |
| Boundary enforcement of that declaration | `tool/check_module_boundaries.dart` | ⛔ **File does not exist** | `IMPL-014` |
| `domain/person` module | `lib/domain/person/` | ⬜ **Absent** — the directory does not exist | `IMPL-202` |
| `SEV-1` … `SEV-16` schemas | `packages/liboora_contracts` | ⬜ Absent | `IMPL-201` |

**The manifest and the code now disagree, and the manifest is the one that is right.**
`tool/module_dependencies.yaml` declares `domain/social` contexts as `[graph, messaging, safety]` — `identity`
was removed per `ADR-0011`. But `GlobalStudentProfile`, which *is* the identity context, still sits in
`lib/domain/social/social.dart`. The manifest describes the decided architecture; the code describes the one it
replaced. That divergence is recorded here rather than resolved by editing the manifest back, because the
architecture decision outranks the scaffold.

**Three consequences that a reader should not have to infer:**

1. **`IMPL-202` is a migration, not a creation.** `GlobalStudentProfile` must move out of `domain/social` into
   `domain/person`, and `domain/social` must be left consuming it rather than owning it. The task list treats
   this explicitly at `IMPL-207` and `IMPL-208`.
2. **The two nullable fields are the amended `ID-4` in reverse.** Both carry doc comments asserting that
   nullability is *"by design"*, which was true when written and is now wrong. Changing the type is the small
   part; every call site that branches on null encodes the old assumption that a library must
   *"degrade gracefully"* when identity is absent — the exact wording of the superseded `MP-GBR-02`.
3. **The seed data would fail `IMPL-224` today.** Four of five accounts have no identity, so the
   accounts-without-identity counter would read 4, not 0. The seed file is separately release-blocking under
   `TASK-D10` (`MP-CON-11`, no demo accounts), so this is not fixed by editing the seed — it is fixed by
   deleting the demo surface and building identity creation into the real account path (`IMPL-203`).

**No code was changed while reconciling the specification.** The conflicts above are recorded as tasks
(`IMPL-207`, `IMPL-208`) rather than silently patched, because changing a domain aggregate's owning module is an
implementation change with test consequences, and the specification review that produced `ADR-0011` was not
authorised to make one.

**The two boundary rows remain the standing risk.** The manifest declares that `domain/person` may not import
`domain/library`, may not import `domain/social`, and may not reference `StudentRecordId`, `TenantId`,
`TenantContext`, `mobileNumber` or `otp`. Nothing checks any of it. Until `IMPL-014` exists, every
`SID-INT-1` … `SID-INT-12` rule is review-verified and **counted as unmet, not as satisfied by intent**
(`SID-4.56`). A declared-but-unenforced boundary is more dangerous than an undeclared one, because it reads as
protection.

---

## 9. Maintenance

1. Update this matrix **in the same commit** as the code — `DEFINITION_OF_DONE.md` Gate 1.
2. A requirement moves to ✅ only when its `AC-n.n` are verified by automated tests.
3. An `XC-n.n` needs a test proving the behaviour is **impossible**, not merely absent.
4. When a chapter reaches 100% ✅, record the verifying commit in the chapter map.
5. A requirement that cannot be implemented as written is a **specification defect** — raise a PRD amendment. Do
   not silently reinterpret it.

---

## 10. References

`Authentication_PRD_v2.md` · `DOCUMENTATION_BASELINE.md` · `IMPLEMENTATION_ROADMAP.md` ·
`AUTHENTICATION_IMPLEMENTATION_CHECKLIST.md` · `DEFINITION_OF_DONE.md` · `CONFIGURATION_GUIDE.md` ·
[`Library_PRD_v1.md`](../30-product/library/Library_PRD_v1.md) ·
[`14B-Public-Library-Preview.md`](../30-product/library/14B-Public-Library-Preview.md) ·
[`INVITATION_SECURITY_SPECIFICATION.md`](../30-product/library/INVITATION_SECURITY_SPECIFICATION.md) ·
[`LIBRARY_IMPLEMENTATION_TASKS.md`](./LIBRARY_IMPLEMENTATION_TASKS.md) ·
[`Student_Identity_PRD_v1.md`](../30-product/student-identity/Student_Identity_PRD_v1.md) ·
[`STUDENT_IDENTITY_ALIGNMENT.md`](../30-product/student-identity/STUDENT_IDENTITY_ALIGNMENT.md) ·
[`STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md`](./STUDENT_IDENTITY_IMPLEMENTATION_TASKS.md) ·
[`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md)

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.3** | 2026-08-04 | Added the **Student Management** identifier inventory (**§2C**, `PRD-004` `DRAFT`, **242** identifiers across ten registers, every range verified contiguous) and the collision record **§2C.1**. Records that the register **was corrected by validation before first use**: §0 of `PRD-004` declared **118** `SM-c.n` (total 246); a mechanical count found **105** (total **242**), and **the register was corrected rather than the chapters padded with filler requirements**. Documents that chapters 5 and 9 deliberately hold **no** `SM-c.n` — chapter 5 numbers in `LMD-n` so a read-composition requirement can never be mistaken for a `BC-01` domain requirement. §2C.1 records `MP-SM-01`…`MP-SM-09` in `MASTER_PRD.md` as a **true negative** — Certified Metric IDs, not requirements — **inspected rather than accepted as a collision**, since a checker that cannot tell a substring from a real hit is one that gets switched off. Header updated to baseline **`-B`**, Library PRD **v1.1**, ADRs **`ADR-0001`…`ADR-0017`**. **No authentication, Library or Student Identity row changed. No code changed.** |
| **v1.2** | 2026-08-04 | Added the Student Identity identifier inventory (§2B, 343 identifiers, all nine registers verified gap-free), the prefix-collision record (§2B.1, including the `PO-n` / `SPO-n` hazard), the Student Identity chapter map (§3B, 38 rows, four marked ⛔ rather than ⬜), configurable traceability (§6B) and event traceability (§7B). Added `ADR-0011` to §4 with its three amendments to the Identity Triad traced individually. **Added `MP-GBR-02` to §5 as an amended rule** — the first global business rule to appear in this matrix as changed rather than as baseline. Added §8A recording that **existing scaffold code implements the superseded pre-`ADR-0011` identity model** — nullable `Account.personId`, nullable `StudentRecord.personId`, `GlobalStudentProfile` owned by `domain/social`, and 4 of 5 seeded accounts with no identity — and that the rank-7.5 boundary is *declared but unenforced* pending `IMPL-014`. No authentication or Library row changed. No code changed. |
| **v1.1** | 2026-08-03 | Added the Library identifier inventory (§2A, ~422 identifiers, zero collisions with the authentication register), the Library chapter map (§3A, 22 rows), Library configurable traceability (§6A) and Library event traceability (§7A). Added `ADR-0009` and `ADR-0010` to §4. Named `IMPL-100` as a second enforcer of `MP-GBR-08` and `IMPL-112` as a second consumer of `MP-DEP-03`. Recorded the `INV-n` / `INV-SEC-n` / `INV-XC-n` prefix hazard in §2A.1, and stated `INV-10`…`INV-16` in full with the failure each prevents. No authentication row changed. |
| v1.0 | 2026-08-02 | Created. 1,517 authentication identifiers mapped. Closes audit finding `G-9`. |
