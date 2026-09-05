# Liboora — Requirements Traceability Matrix

| Field | Value |
|---|---|
| **Version** | **v1.23** |
| **Status** | Active — updated with every requirement implemented |
| **Date** | 2026-08-02 · extended 2026-08-03 · **extended and §2C corrected 2026-08-04** · **§2D added 2026-08-04** · **§2E added 2026-08-04** · **§2F added 2026-08-04** · **§2G added 2026-08-15** · **§2H added 2026-08-15** · **§2I added 2026-08-17** · **§2J added 2026-08-19** · **§2K added 2026-08-19** · **§2L added 2026-08-20** · **§2M added 2026-08-20** · **§2N added 2026-08-21** · **§2N corrected 2026-08-21** — six §2N.2 cells and two §2N header cells superseded by the Stage 7 admission, prior text retained verbatim; on the **v1.4 precedent**, where *"§2C corrected"* was itself a version increment · **§2O added 2026-08-23** · **§2P added 2026-09-01** · **§2Q added 2026-09-02** |
| **Baseline** | **BASELINE-2026-08-04-D** — ⚠ **not re-issued by §2G.** `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier only *"when a Rank 1–3 document changes version"*. `PRD-008` is **byte-unchanged** by this pass, so no baseline change is due, and this matrix is **unranked** — it confers nothing |
| **Sources** | Authentication PRD v2.0 · Library PRD **v1.1** + §14A + §14B + Invitation Security Specification · Student Identity & Profile PRD v1.0 · **Student Management PRD v1.2 (`PRD-004`, `FROZEN`)** · **Membership Management PRD v1.4 (`PRD-005`, `FROZEN`)** · **Seat Management PRD v1.0 (`PRD-007`, `DRAFT`)** · **Attendance Management PRD v1.3 (`PRD-006`, `DRAFT`)** · **Revenue & Finance PRD v1.7 (`PRD-008`, `DRAFT`)** · **Integration PRD v0.2 (`PRD-019`, `DRAFT`)** · **Tenancy PRD v0.1 (`PRD-013`, `FROZEN`)** · **Audit Trail PRD v0.1 (`PRD-016`, `DRAFT`)** · **Entitlement PRD v0.1 (`PRD-014`, `DRAFT`)** · **Settings & Configuration PRD v0.1 (`PRD-023`, `DRAFT`)** · **File & Media PRD v0.1 (`PRD-017`, `DRAFT`)** |
| **ADRs applied** | `ADR-0001` … **`ADR-0018`**, **`ADR-0020`**, **`ADR-0032`** |

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
| `SM-c.n` | Functional requirement | **107** | `SM-1.1` … `SM-10.12` | Chapters 1–4, 6–8, 10 |
| `SM-BR-n` | Business rule | 16 | `SM-BR-1` … `SM-BR-16` | §9.1 |
| `SM-XC-n` | Exclusion — must be impossible | 14 | `SM-XC-1` … `SM-XC-14` | §1.5 |
| `SM-INV-n` | Domain invariant | 11 | `SM-INV-1` … `SM-INV-11` | §2.6 |
| `SM-EV-n` | Domain event (**closed set**) | **10** | `SM-EV-1` … `SM-EV-10` | §7.4 |
| `SM-PO-n` | Protected operation (**closed list**) | 12 | `SM-PO-1` … `SM-PO-12` | §8.2 |
| `SM-AC-n` | Acceptance criterion | **32** | `SM-AC-1` … `SM-AC-32` | §10.4 |
| `SMCFG-n` | Configurable parameter | 7 | `SMCFG-1` … `SMCFG-7` | §10.3 |
| `LMD-n` | **Library Members Directory requirement** | 31 | `LMD-1` … `LMD-31` | Chapter 5 |
| `SM-GAP-n` | **PROPOSED GAP** — no authoritative source | **11** | `SM-GAP-1` … `SM-GAP-11` | §10.6 |

**Total Student Management normative identifiers: 251 base**, of which **11 are proposed gaps carrying no
authority**, plus **15 sub-lettered clarifications** (`PRD-004` §0.2) giving **266** in total.

Per-chapter `SM-c.n` counts: Ch 1 = 8 · Ch 2 = 16 · Ch 3 = 17 · Ch 4 = 12 · **Ch 5 = 0** · Ch 6 = 8 · Ch 7 = 17 ·
Ch 8 = 17 · **Ch 9 = 0** · Ch 10 = 12.

**Measured traceability coverage: 227 / 240 = 94.6%**, computed by
[`tool/docs_check/prd004_traceability.py`](../../tool/docs_check/prd004_traceability.py). The 11 proposed gaps are
excluded from the denominator; the 13 untraced identifiers are named in `PRD-004` §10.5.1.

> ⚠ **This register was stale and was corrected on 2026-08-04 — second-review finding `SR-01` (HIGH).** It declared
> `SM-c.n` 105, `SM-EV-n` 9, `SM-AC-n` 28, `SM-GAP-n` 9, total **242**, and per-chapter Ch 10 = 10. Those were the
> **pre-correction** figures: two `PRD-004` correction passes had since added `SM-10.11`, `SM-10.12`, `SM-EV-10`,
> `SM-AC-29`–`SM-AC-32` and `SM-GAP-10`–`SM-GAP-11`. `PRD_LIFECYCLE.md` Stage 5 requires these counts to be
> *"verified mechanically — counted by a tool, not by reading"*, and a tool **disproved** them. The figures above
> are now reproduced by the counting script. **This document is unranked, so no ADR was required to correct it.**

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

## 2D. Identifier inventory — Membership Management

Verified mechanically against `PRD-MEMBERSHIP-MANAGEMENT.md` (`PRD-005`, **v1.4**, **`DRAFT`**) by
[`tool/docs_check/prd005_traceability.py`](../../tool/docs_check/prd005_traceability.py). Every count below is
**computed, not asserted**, and every range is verified contiguous from 1 to its stated maximum.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `MM-FR-n` | Functional requirement | **119** | `MM-FR-001` … `MM-FR-118` + `MM-FR-057a` | §§2–11, 19–20 |
| `MM-BR-n` | Business rule | **35** | `MM-BR-001` … `MM-BR-035` | §12, §14 |
| `MM-INV-n` | Domain invariant (enforced inside the aggregate) | **12** | `MM-INV-001` … `MM-INV-012` | §14.2 |
| `MM-EVT-n` | Domain event (**closed set**) | **7** | `MM-EVT-001` … `MM-EVT-007` | §12 |
| `MM-XC-n` | Exclusion — must be impossible | **16** | `MM-XC-001` … `MM-XC-016` | §1.5 |
| `MM-AC-n` | Acceptance criterion | **97** | `MM-AC-001` … `MM-AC-094` + `MM-AC-074a`, `076a`, `080a` | §23 |
| `MM-NFR-n` | Non-functional requirement | **14** | `MM-NFR-001` … `MM-NFR-014` | §16.5 |
| `MM-PO-n` | Protected operation (**closed list**) | **11** | `MM-PO-001` … `MM-PO-011` | §16.3 |
| `MM-CFG-n` | Configurable | **9** | `MM-CFG-001` … `MM-CFG-009` | §13.4 |
| `MM-GAP-n` | **Proposed gap / open question — not a requirement** | **13** | `MM-GAP-001` … `MM-GAP-010` + `006a`, `007a`, `010a` | §25.2 |

**Total Membership Management identifiers: 333**, of which **320 carry obligation** and **13 are `MM-GAP-*` open
questions carrying no authority**. Of the 320, **223 are obligations an acceptance criterion can verify** (every
register except `MM-AC-*` itself).

**Measured coverage — 134 / 223 = 60.1%**, and **77 / 81 = 95.1%** across the five *rule* registers
(`MM-BR`, `MM-INV`, `MM-EVT`, `MM-XC`, `MM-PO`). Per register: `MM-BR` **31/35** · `MM-INV` **12/12** ·
`MM-EVT` **7/7** · `MM-XC` **16/16** · `MM-PO` **11/11** · `MM-FR` **48/119** · `MM-NFR` **7/14** ·
`MM-CFG` **2/9**.

> **The counting rule is deliberately strict, and it is the PRD's own.** `PRD-005` §0.2 binds every coverage figure
> to one test: an obligation counts as verified **iff its identifier appears in the *Verifies* column of an
> `MM-AC-*` row in §23**. A mention in criterion text, in a surrounding note, or in prose asserting that a rule is
> covered elsewhere does **not** count. The four rule-register obligations not verified under it — `MM-BR-012`,
> `MM-BR-022`, `MM-BR-027`, `MM-BR-028` — are named in `PRD-005` §0.2, §23.1 and §25.3 rather than argued away.
> This follows `MM-NFR-014` / `SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet, not as
> satisfied by intent."* A coverage metric that can be raised by writing prose measures prose.

**`PRD-005` is `DRAFT`, not frozen.** Registering its identifiers here satisfies `PRD_LIFECYCLE.md` **Stage 5**
only. Stage 6 (`IMPL-*` allocation) and Stage 7 (freeze) are **not** addressed by this section, and nothing here
confers baseline status — that is `DOCUMENTATION_BASELINE.md` §3's to confer.

### 2D.1 Prefix collisions checked — zero, and the one substring that is *not* one

**Zero collisions** against all four existing registers: authentication
(`AUTH`/`BR`/`XC`/`AC`/`PR`/`TR`/`EV`/`CFG`), Library (`LIB`/`LCFG`/`LXC`/`LEV`/`LAC`/`PO`/`IT`/`INV`), Student
Identity (`SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/`SID-INV`/`SCFG`/`SID-AC`) and Student Management
(`SM`/`SM-BR`/`SM-XC`/`SM-INV`/`SM-EV`/`SM-PO`/`SM-AC`/`SMCFG`/`LMD`/`SM-GAP`).

**Every `MM-*` register carries its own infix**, which is why the collision surface is small: `MM-BR-n` cannot be
confused with authentication's `BR-c.n` (297 of them) or with `SM-BR-n`; `MM-PO-n` cannot be confused with the
public-preview `PO-n` register or with `SPO-n` — the two-register hazard §2B.1 records; `MM-INV-n` is distinct from
the Library `INV-n` invariants; `MM-XC-n`, `MM-AC-n`, `MM-EVT-n` and `MM-CFG-n` are likewise infixed. `MM-EVT-n`
deliberately does **not** reuse `SM-EV-n`'s shape.

A whole-repository word-boundary search returns empty:

```
grep -rIno '\(^\|[^-A-Za-z]\)MM-[A-Z]\+-[0-9]' docs --include=*.md | grep -v membership-management/   → (empty)
```

**`YYYY-MM-DD` is a true negative, not a suppressed hit.** A loose `MM-` search returns exactly one line outside
the module — `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` line 624, *"`expires: YYYY-MM-DD`"* — where `MM` is the
**month** field of a date format, not a register. It was **inspected rather than counted as a failure**, on the
§2C.1 principle: a checker that cannot distinguish a real collision from a substring is a checker that gets
switched off.

### 2D.2 Three conventions the counter models explicitly

A first run of the script reported three failures. **All three were correct `PRD-005` behaviour**, and each is now
modelled in the tool rather than silenced — the count is only trustworthy if it knows what it is looking at.

| Observation | Why it is not a defect | How it is counted |
|---|---|---|
| `MM-GAP-006` and `MM-GAP-007` have **no definition row** — §25.2 holds 11 rows for a 13-identifier register | Both were **closed at v1.1** (`PRD-005` §5.1, §12). Their numbers are **retained, not reused**, so citations written against them stay resolvable, and each leaves a suffixed successor (`MM-GAP-006a`, `MM-GAP-007a`) | Both are counted as **declared identifiers** with no row. Contiguity is judged over the declared set, so `MM-GAP-001`…`010` is contiguous |
| `MM-BR-030` appears **twice** (lines 886 and 1235) | Line 886 is the definition; line 1235 states *"Restated from §9, which is the definition site."* | The restatement is **skipped**. Counting it would inflate the register; flagging it as a duplicate would be false |
| **11** `MM-AC-*` rows name no `MM-*` ID in *Verifies* — e.g. `MM-AC-014` → "Edge 1", `MM-AC-032` → "§6.3" | Those cells are **populated and meaningful**; they verify a section or an integration edge rather than a registered identifier | Only a genuinely **blank** cell is a defect. Blank cells: **0** |

### 2D.3 Stage 5 exit gate — mechanically verifiable

`PRD_LIFECYCLE.md` Stage 5 requires counts *"verified mechanically — counted by a tool, not by reading"*, with
**zero collisions**. Re-run the gate at any time:

```
python3 tool/docs_check/prd005_traceability.py     # exit 0 = gate satisfied
```

The script fails (exit 1) if any declared count drifts from the document, any range develops a hole, an identifier
is defined twice, a `Verifies` cell is blank, a `MM-GAP-*` is cited as verifiable, a dangling identifier appears,
or the `MM-` prefix collides anywhere in `docs/`. **This is the defence §2C did not have**: §2C carried stale
`PRD-004` figures through two correction passes until a script disproved them (finding `SR-01`, HIGH). The same
class of defect cannot silently reach `PRD-005`.

---

## 2E. Identifier inventory — Seat Management

Verified mechanically against `PRD-SEAT-MANAGEMENT.md` (`PRD-007`, **v1.0**, **`DRAFT`**) by
[`tool/docs_check/prd007_traceability.py`](../../tool/docs_check/prd007_traceability.py). Every count below is
**computed, not asserted**, and every range is verified contiguous from 1 to its stated maximum.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `SEAT-FR-n` | Functional requirement | **304** | `SEAT-FR-001` … `SEAT-FR-304` | §§1–30, §33.14, §36.2 |
| `SEAT-BR-n` | Business rule (cross-cutting, testable) | **45** | `SEAT-BR-001` … `SEAT-BR-045` | §§2–31 |
| `SEAT-INV-n` | Domain invariant, enforced **synchronously inside the aggregate** | **14** | `SEAT-INV-001` … `SEAT-INV-014` | §7.1, §23.2, §29, §30.1 |
| `SEAT-EVT-n` | Domain event (**closed set**, fixed by BC Map §9) | **4** | `SEAT-EVT-001` … `SEAT-EVT-004` | §22.1 |
| `SEAT-XC-n` | Exclusion — must be impossible **or is out of scope** | **22** | `SEAT-XC-001` … `SEAT-XC-022` | §§6.4–27.3 |
| `SEAT-PO-n` | Protected operation (**closed list**) | **24** | `SEAT-PO-001` … `SEAT-PO-024` | §28.2 |
| `SEAT-CFG-n` | Configurable, with an owner and a default | **18** | `SEAT-CFG-001` … `SEAT-CFG-018` | §27.1 |
| `SEAT-NFR-n` | Non-functional requirement | **12** | `SEAT-NFR-001` … `SEAT-NFR-012` | §32 |
| `SEAT-AC-n` | Acceptance criterion | **226** | `SEAT-AC-001` … `SEAT-AC-226` | §§33.1–33.13 |
| `SEAT-GAP-n` | **Proposed gap / open question — not a requirement** | **14** | `SEAT-GAP-001` … `SEAT-GAP-014` | §31 |

**Total Seat Management identifiers: 683**, of which **669 carry obligation** and **14 are `SEAT-GAP-*` open
questions carrying no authority**. Of the 669, **443 are obligations an acceptance criterion can verify** (every
register except `SEAT-AC-*` itself). Across the whole document these 683 identifiers are referenced **1,641** times
with **zero dangling references**; the 226 acceptance-criterion rows carry **363** citations in their *Verifies*
columns, resolving to **325** distinct obligations, with **zero orphan criteria** and **zero blank cells**.

**Measured coverage — 325 / 443 = 73.4%**, and **85 / 85 = 100%** across the four *rule* registers
(`SEAT-BR-*`, `SEAT-INV-*`, `SEAT-EVT-*`, `SEAT-XC-*`). The second figure is the one `SEAT-FR-302` actually
mandates, and it is met exactly. The 118 uncovered obligations are **86** `SEAT-FR-*`, **18** `SEAT-PO-*`, **9**
`SEAT-CFG-*` and **5** `SEAT-NFR-*` — the four registers `SEAT-FR-302` deliberately excludes from its mandate.
They are **named here rather than argued away**, per `SEAT-NFR-011` / `SID-4.56`: *"a rule that cannot be checked
SHALL be treated as unmet, not as satisfied by intent."*

**`PRD-007` is `DRAFT`, not frozen.** Registering its identifiers here satisfies `PRD_LIFECYCLE.md` **Stage 5**
only. Stage 6 (`IMPL-*` allocation) and Stage 7 (freeze) are **not** addressed by this section, and nothing here
confers baseline status — that is `DOCUMENTATION_BASELINE.md` §3's to confer.

### 2E.1 Prefix collisions checked — zero, in both directions

**Zero collisions** against all five existing registers — authentication (`AUTH`/`BR`/`XC`/`AC`/`PR`/`TR`/`EV`/
`AERR`/`CFG`/`SO`/`PP`/`AU`/`EP`), Library (`LIB`/`LIB-14B`/`LIB-DISC`/`INV-SEC`/`LBR`/`LIB-PREV`/`LXC`/`INV-XC`/
`LAC`/`LAC-14B`/`IAC`/`LCFG`/`ICFG`/`LEV`/`PO`/`IT`), Student Identity (`SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/
`SID-INV`/`SCFG`/`SID-AC`), Student Management (`SM`/`SM-BR`/`SM-XC`/`SM-INV`/`SM-EV`/`SM-PO`/`SM-AC`/`SMCFG`/
`LMD`/`SM-GAP`) and Membership (`MM-FR`/`MM-BR`/`MM-INV`/`MM-EVT`/`MM-XC`/`MM-AC`/`MM-NFR`/`MM-PO`/`MM-CFG`/
`MM-GAP`). `PRD-007` §0.3 records that `SM-*` was **rejected as a candidate prefix** and `SEAT-*` adopted instead,
per `PRD_LIFECYCLE.md` §5 rule 3 — *"on collision, change the **new** prefix, never the existing one."*

**Checked in both directions**, because a one-way check cannot catch the `PO-n` / `SPO-n` class of error §2B.1
records:

| Direction | Question | Result |
|---|---|---|
| Outward | Does any `SEAT-<REG>-<n>` identifier exist outside the module? — `grep -rIno '\(^\|[^-A-Za-z]\)SEAT-[A-Z]\+-[0-9]' docs --include=*.md \| grep -v seat-management/` | **(empty)** |
| Outward, loose | Does the bare substring `SEAT-` appear outside the module at all? | **0 hits** |
| Outward, code | Does `SEAT-*` appear in `tool/`, `lib/` or `test/`? | **0 hits** |
| Inward | Does `PRD-007` cite a foreign register by a bare prefix? | **5 prefixes, 36 hits — every one a correct foreign citation** |

The inward direction is the one that matters here, and it is the direction a naive check omits. **Every hit was
inspected at its line rather than counted as a failure**, on the §2C.1 principle:

| Bare token in `PRD-007` | Hits | What it actually is | Verdict |
|---|---:|---|---|
| `BR-2.9`, `BR-2.12` | 3 | **Authentication** business rules — role-assignment authority, and Reception's denial of *"revenue and financial data in all circumstances"* | ✅ correct foreign citation. Authentication numbers as `BR-c.n`, so `SEAT-BR-nnn` cannot collide with it |
| `BR-001` … `BR-018` | 20 | The **source draft's** eighteen original business rules, in the left column of the §36.1 *carried-by* table whose right column names the `SEAT-*` identifiers carrying each | ✅ **not a register** — a historical draft token. `BR-0nn` does not exist as an authentication identifier: a word-boundary search of `docs/**` outside the module returns **0 hits** |
| `LCFG-9`, `LCFG-10` | 4 | **Library** configurables, bounding floors and seats per branch | ✅ correct foreign citation |
| `LXC-7` | 3 | A **Library** exclusion — no price attached to a zone or a seat | ✅ correct foreign citation |
| `LMD-23`, `LMD-24` | 4 | **Student Management** Library Members Directory requirements | ✅ correct foreign citation |
| `TR-2` | 2 | An **authentication** trust requirement, bounding Manager authority | ✅ correct foreign citation |

**Numeric ranges are per-register, not global.** `PRD_LIFECYCLE.md` §5 rule 1 makes the *identifier* unique across
the platform — not the number — and §2B.1 states that independently numbered registers *"overlap numerically on
purpose; the prefix carries the producer."* `SEAT-FR-001` therefore does not collide with `MM-FR-001`, `SM-1.1` or
`AUTH-1.1`, and **no range-overlap prohibition applies to this section**. The one range this repository does
allocate globally is `IMPL-*`, governed by `PRD_LIFECYCLE.md` Stage 6 (*"take the next free range. Never reuse or
reassign a number"*). **`PRD-007` contains 0 occurrences of `IMPL-`**, so this registration consumes none of that
range and allocates none — Stage 6 remains untouched.

### 2E.2 Stage 5 exit gate — mechanically verifiable

`PRD_LIFECYCLE.md` Stage 5 requires counts *"verified mechanically — counted by a tool, not by reading"*, with
**zero collisions**. Re-run the gate at any time:

```
python3 tool/docs_check/prd007_traceability.py     # exit 0 = gate satisfied
```

The script fails (exit 1) if any count declared in §2E drifts from the document, any range declared in §2E or in
`PRD-007` §0.3 disagrees with the definition sites, a range develops a hole, an identifier is defined twice, an
acceptance-criterion row is malformed or its `Verifies` cell blank, a `SEAT-GAP-*` is cited as verifiable, a
dangling identifier appears, `SEAT-FR-302` coverage falls below **85 / 85**, or the `SEAT-` prefix appears anywhere
outside the module. This is the defence §2D built and §2C lacked.

**One convention the script models explicitly.** Definition form is **per register**, and was established by
inspection rather than assumed: `SEAT-FR-*`, `SEAT-BR-*`, `SEAT-INV-*`, `SEAT-XC-*` and `SEAT-NFR-*` are defined in
**prose** — a line-initial `` `SEAT-XX-nnn` `` followed by an em dash — while `SEAT-EVT-*`, `SEAT-PO-*`,
`SEAT-CFG-*`, `SEAT-AC-*` and `SEAT-GAP-*` are defined in **table rows**. The two forms have **zero overlap**. A
pattern loose enough to accept both counts line-initial *citations* as definitions and returns **307**
`SEAT-FR-*` for a register of **304** — a phantom duplicate in the checker, not a defect in the PRD.

---

## 2F. Identifier inventory — Attendance Management

Verified mechanically against `PRD-006_ATTENDANCE-MANAGEMENT.md` (`PRD-006`, **v1.3**, **`DRAFT`**) by
[`tool/docs_check/prd006_traceability.py`](../../tool/docs_check/prd006_traceability.py). Every count below is
**computed, not asserted**, and every range is verified contiguous from 1 to its stated maximum. The meanings are
`PRD-006` §0.3's own, not this section's paraphrase — `ATT-PO-*` in particular is a **port**, not a protected
operation, and does not correspond to `PO-n` in §2A or `SPO-n` in §2B.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `ATT-FR-n` | Functional requirement — what the module does | **151** | `ATT-FR-001` … `ATT-FR-151` | §§3.2–25, across **57** sections incl. §13A–§13E and §12.4a |
| `ATT-BR-n` | Business rule — a decision the domain enforces | **45** | `ATT-BR-001` … `ATT-BR-045` | §§4.1–23.4, across **35** sections incl. §13A–§13C |
| `ATT-INV-n` | Invariant — must hold at every observable moment | **12** | `ATT-INV-001` … `ATT-INV-012` | §3.5, §6.2, §13C, §14.1, §18, §20 |
| `ATT-EVT-n` | Domain event this module publishes | **4** | `ATT-EVT-001` … `ATT-EVT-004` | §22.1 |
| `ATT-XC-n` | Exclusion — what this module must never do | **21** | `ATT-XC-001` … `ATT-XC-021` | §§3.4–17, across **18** sections |
| `ATT-PO-n` | **Port** — what it consumes, and from whom | **14** | `ATT-PO-001` … `ATT-PO-014` | §5.2, §5.3, §27.1 |
| `ATT-CFG-n` | Configurable value | **24** | `ATT-CFG-001` … `ATT-CFG-024` | §16.3 |
| `ATT-NFR-n` | Non-functional requirement | **14** | `ATT-NFR-001` … `ATT-NFR-014` | §15.4, §27 |
| `ATT-AC-n` | Acceptance criterion | **222** | `ATT-AC-001` … `ATT-AC-222` | §§30.1–30.20 |
| `ATT-GAP-n` | **Open question — not a requirement** | **18** | `ATT-GAP-001` … `ATT-GAP-018` | §32.1 |

**Total Attendance Management identifiers: 525**, of which **285 carry obligation**, **222 are `ATT-AC-*`
acceptance criteria** and **18 are `ATT-GAP-*` open questions carrying no authority**. The `ATT-GAP-*` register's
18 numbers carry **23 rows**: `ATT-GAP-002a`, `ATT-GAP-002b`, `ATT-GAP-008a`, `ATT-GAP-016a` and `ATT-GAP-017a` are
**suffixed successors declared up front in §0.3**, following the `MM-GAP-006a`/`007a`/`010a` precedent §2D records for the frozen `PRD-005`. The
numeric range `001…018` remains contiguous — a suffix is an addition to a declared number, never a break in the
sequence — and both figures, 18 and 21, are checked separately. Across the whole document these identifiers are
referenced **1,262** times, resolving to **519** distinct identifiers (516 numbers plus the 3 suffixed rows), with
**zero dangling references**; the 213 acceptance-criterion rows carry **328** citations in their *Verifies*
columns, with **zero orphan criteria**, **zero blank cells** and **zero `ATT-GAP-*` cited as verifiable**.

**Measured coverage — 285 / 285 = 100%.** Every obligation-bearing identifier in all eight obligation registers is
cited by at least one `ATT-AC-*` *Verifies* cell. Prose never counts. **This threshold is stricter than
`PRD-007`'s**, and deliberately so: `SEAT-FR-302` mandates coverage across four *rule* registers only (85/85, with
118 obligations outside its mandate uncovered at 73.4% overall), whereas `ATT-NFR-010` states that *"a rule that
cannot be checked **MUST** be treated as unmet. A requirement in this document with no acceptance criterion is not
satisfied by assertion."* That claim admits no excluded register, so the gate script enforces **285/285** and fails
on a single uncovered obligation. The figure is **measured, not asserted** — `PRD-006` v1.0 published *"100%
coverage"* while the true figure was 137/279 = 49.1%, and the last coverage hole (`ATT-BR-045`, which had no
criterion at all) was closed during Stage 4 reconciliation by **extending `ATT-AC-152`, not by inventing a
criterion**.

**`PRD-006` is v1.3 `DRAFT`, not frozen.** Registering its identifiers here satisfies `PRD_LIFECYCLE.md` **Stage 5**
only. Stage 6 (`IMPL-*` allocation) and Stage 7 (freeze) are **not** addressed by this section. `PRD-006` contains
**one** occurrence of the token `IMPL-`, at line 90 — the generic phrase *"ADRs, `IMPL-*` tasks and PRD numbers —
cross-references outlive documents"*, **inspected at its line**: it is a statement of the never-reuse rule, not an
allocation. **No `IMPL-*` number is claimed or consumed**, so Stage 6 remains untouched. Nothing here confers
baseline status — that is `DOCUMENTATION_BASELINE.md` §3's to confer, and `PRD-006`'s own header records that it is
*"not frozen, not ranked, not admitted to any baseline."* Its Stage 3 and Stage 4 verdicts were both
**⚠️ CONDITIONAL**; **this section does not upgrade them.**

### 2F.1 Prefix collisions checked — zero, in both directions

**Zero collisions** against all six existing registers — authentication (`AUTH`/`BR`/`XC`/`AC`/`PR`/`TR`/`EV`/
`AERR`/`CFG`/`SO`/`PP`/`AU`/`EP`), Library (`LIB`/`LIB-14B`/`LIB-DISC`/`INV-SEC`/`LBR`/`LIB-PREV`/`LXC`/`INV-XC`/
`LAC`/`LAC-14B`/`IAC`/`LCFG`/`ICFG`/`LEV`/`PO`/`IT`), Student Identity (`SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/
`SID-INV`/`SCFG`/`SID-AC`), Student Management (`SM`/`SM-BR`/`SM-XC`/`SM-INV`/`SM-EV`/`SM-PO`/`SM-AC`/`SMCFG`/
`LMD`/`SM-GAP`), Membership (`MM-FR`/`MM-BR`/`MM-INV`/`MM-EVT`/`MM-XC`/`MM-AC`/`MM-NFR`/`MM-PO`/`MM-CFG`/`MM-GAP`)
and Seat Management (`SEAT-FR`/`SEAT-BR`/`SEAT-INV`/`SEAT-EVT`/`SEAT-XC`/`SEAT-PO`/`SEAT-CFG`/`SEAT-NFR`/`SEAT-AC`/
`SEAT-GAP`). `PRD-006` §0.3 records that the collision procedure was **executed before writing**, per
`PRD_LIFECYCLE.md` Stage 2 rule 2, and that `ATT-*` was free at that time.

**Checked in both directions**, because a one-way check cannot catch the `PO-n` / `SPO-n` class of error §2B.1
records — and this module is precisely where that hazard recurs, since `ATT-PO-*` is a **port** while `PO-n` is a
Library protected operation:

| Direction | Question | Result |
|---|---|---|
| Outward | Does any `ATT-<REG>-<n>` identifier exist outside the module? — `grep -rIno '\(^\|[^-A-Za-z]\)ATT-[A-Z]\+-[0-9]' docs --include=*.md \| grep -v attendance-management/ \| grep -v TRACEABILITY_MATRIX.md` | **(empty)** |
| Outward, loose | Does the bare token `ATT-<CAPITAL>` appear outside the module at all? | **0 hits** |
| Outward, code | Does `ATT-*` appear in `tool/`, `lib/` or `test/`? | **0 hits** (excluding the gate script itself) |
| Inward | Does `PRD-006` cite a foreign register by a bare prefix? | **19 prefixes — every one a correct foreign citation or a substring** |

This section's own citations are **not** counted as outward hits. `TRACEABILITY_MATRIX.md` is where the register is
*registered*, so it necessarily names these identifiers; the allow-list in the gate script is enumerated **file by
file** rather than widened to a directory, so a stray `ATT-` in any *other* document still fails the run.

The inward direction is the one that matters, and **every hit was inspected at its line rather than counted as a
failure**, on the §2C.1 principle — *a checker that cannot tell a substring from a real hit is one that gets
switched off*:

| Bare token in `PRD-006` | Hits | What it actually is | Verdict |
|---|---:|---|---|
| `BC-nn` | 312 | Bounded-context identifiers from `LIBOORA_BOUNDED_CONTEXT_MAP.md` | ✅ correct foreign citation |
| `PRD-nnn` | 99 | Sibling PRD numbers from `PRD_REGISTRY.md` | ✅ correct foreign citation |
| `MP-GBR-nn` | 29 | **Master PRD** global business rules (Rank 1) | ✅ correct foreign citation |
| `LIB-n.n` | 27 | **Library** PRD requirements | ✅ correct foreign citation |
| `ID-n` | 23 | **Student Identity** requirements (`ID-1`, `ID-2`, `ID-5`, `ID-6`) | ✅ correct foreign citation |
| `ADR-nnnn` | 20 | Architecture decision records (Rank 2) | ✅ correct foreign citation |
| `RQ-n` | 11 | **This document's own** Stage 4 review findings `RQ-1`…`RQ-8`, cited in the §34 changelog | ✅ **not a register** — review-finding labels, scoped to `PRD-006_REQUIREMENTS_REVIEW.md` |
| `NG-n` | 10 | The **non-goals** table at line 168 — *"`NG-1` \| Authenticating a person \| `BC-18` Identity & Access"* | ✅ **not a register** — a local scoping table, no obligation attached |
| `SEAT-BR-n`, `SEAT-FR-n`, `SEAT-XC-n` | 18 | **Seat Management** identifiers registered in §2E above | ✅ correct foreign citation |
| `MM-GAP-nnn` | 7 | **Membership** gaps — `MM-GAP-010` (the systemic missing-edge defect) and the `MM-GAP-006a`/`007a`/`010a` suffix precedent | ✅ correct foreign citation |
| `AUTH-n.n` | 6 | **Authentication** requirements (`AUTH-1.1`, `AUTH-2.8`, `AUTH-2.16`) | ✅ correct foreign citation |
| `SXC-n` | 3 | A **Student Identity** exclusion — line 813, *"the only adjacent statement is `SXC-4` in `PRD-003`"* | ✅ correct foreign citation |
| `MP-ASM-nn` | 3 | **Master PRD** assumptions — `MP-ASM-03`, on offline capture | ✅ correct foreign citation |
| `GCP-nn` | 3 | Governance conformance points `GCP-01`/`07`/`08`, line 2295 | ✅ correct foreign citation |
| `TR-n` | 1 | An **authentication** trust requirement — `TR-2`, line 2107 | ✅ correct foreign citation |
| `SM-GAP-nn` | 1 | A **Student Management** gap — `SM-GAP-11`, line 2196 | ✅ correct foreign citation |
| `SM-n.n` | 1 | A **Student Management** requirement — `SM-4.3`, line 834, the Library Identification Photo | ✅ correct foreign citation |
| `SM-03` | 3 | **A substring, not a hit.** Lines 1647, 2177, 2211 contain **`MP-ASM-03`**; a bare-substring search for `SM-0` finds `SM-03` inside it. A word-boundary search returns these **0 times** | ✅ **true negative** — recorded here for the same reason §2C.1 records `MP-SM-01`…`09` and §2D.1 records `YYYY-MM-DD` |

**Numeric ranges are per-register, not global.** `PRD_LIFECYCLE.md` §5 rule 1 makes the *identifier* unique across
the platform — not the number — and §2B.1 states that independently numbered registers *"overlap numerically on
purpose; the prefix carries the producer."* `ATT-FR-001` therefore does not collide with `SEAT-FR-001`,
`MM-FR-001`, `SM-1.1` or `AUTH-1.1`, and **no range-overlap prohibition applies to this section**. The one range
this repository allocates globally is `IMPL-*`, governed by Stage 6 — **untouched here**, per §2F above.

### 2F.2 Stage 5 exit gate — mechanically verifiable

`PRD_LIFECYCLE.md` Stage 5 requires counts *"verified mechanically — counted by a tool, not by reading"*, with
**zero collisions**. Re-run the gate at any time:

```
python3 tool/docs_check/prd006_traceability.py     # exit 0 = gate satisfied
```

The script fails (exit 1) if any count registered in §2F drifts from the document, any range registered in §2F or
declared in `PRD-006` §0.3 disagrees with the definition sites, a range develops a hole, a suffixed successor is
defined without being declared in §0.3, an identifier is defined twice, an acceptance-criterion row is malformed or
its *Verifies* cell blank, an `ATT-GAP-*` is cited as verifiable, a dangling identifier appears, `ATT-NFR-010`
coverage falls below **285 / 285**, the §32.1 gap ledger's own verdict cells disagree with the tally the prose
states, or the `ATT-` prefix appears outside the module. **Three declarations, one computation**: §0.3's ranges,
§0.3's totals and §2F's registrations are each checked against the same measured figures, so no two can drift apart
unnoticed. The gap-ledger check is Stage 4 finding `RQ-3` — which found the document stating **three different**
open-gap counts — turned into a permanent check.

**Two conventions the script models explicitly, both established by inspection rather than assumed.**

**First, `PRD-006` does not follow `PRD-007`'s definition-form convention, and a script ported without
re-inspection gets the wrong answer.** §2E.2 records that `PRD-007` defines each register in exactly *one* shape —
five in prose, five in table rows, zero overlap. **`PRD-006` uses both shapes for the same register** — three of
them do:

| Register | Prose | Table | Total | Form |
|---|---:|---:|---:|---|
| `ATT-FR-*` | 110 | 41 | 151 | **BOTH** |
| `ATT-BR-*` | 39 | 6 | 45 | **BOTH** |
| `ATT-PO-*` | 5 | 9 | 14 | **BOTH** |
| `ATT-INV-*`, `ATT-XC-*`, `ATT-NFR-*` | 12, 21, 15 | 0 | 48 | prose only |
| `ATT-EVT-*`, `ATT-CFG-*`, `ATT-AC-*`, `ATT-GAP-*` | 0 | 4, 24, 222, 23 | 273 | table only |

The table-form definitions of `ATT-FR-*`, `ATT-BR-*` and `ATT-PO-*` sit in ordinary content sections — §8.3, §9.3,
§10.3, §11.3, §12.2, §5.2, §5.3, §27.1 — **not** in an index, and are genuine definitions. So **form alone cannot
separate a definition from a restatement here — location can.** Six sections are *indexes*, restating identifiers
defined elsewhere for navigation: §0 (incl. the §0.3 register table), §28 (the business-rule index, which carries a
back-pointer column), §29 (the exclusion index, which carries an *"Owner instead"* column), §31.1 and §31.2
(coverage and upstream traceability), and §32 (which restates §32.1's 21 ledger rows in a different shape —
counting both would double every gap). Counting those six as definition sites produces **95 phantom duplicates**
(45 `ATT-BR-*`, 21 `ATT-XC-*`, 21 `ATT-GAP-*`, 6 `ATT-CFG-*`, 1 `ATT-FR-*`, 1 `ATT-NFR-*`) — the class of false
positive §2C.1 warns about, and the class the Stage 4 review rejected as finding `R-1` by **opening the pairs
rather than trusting the count**. Honouring the list leaves exactly **one** duplicate, `ATT-NFR-001`, described
next. §16.2 is the trap in the other direction: it *looks* like an index because it contains a two-column mode
map, but its **prose** is the real definition site for `ATT-FR-099` and `ATT-FR-100`, so it is excluded for table
definitions only.

**Second, `ATT-NFR-001` is defined once and restated once.** Line 1110 (§15.4) defines it; line 1607 (§27) repeats
it prefixed *"(stated in §15.4)"* — a **self-declared restatement**, inspected at its line, not a second
definition. It is allow-listed by identifier rather than by pattern, so a *new* duplicate must be justified rather
than silently absorbed, and the script emits a note if the allow-listed pair ever stops having two sites. This
mirrors `MM-BR-030` in §2D.2.

---

## 2G. Identifier inventory — Revenue & Finance

Verified mechanically against `PRD-008_REVENUE-AND-FINANCE.md` (`PRD-008`, **v1.7**, **`DRAFT`**) by
[`tool/docs_check/prd008_stage5.py`](../../tool/docs_check/prd008_stage5.py), which reads the counts from the
document body and compares them against the rows below. Every count is **computed, not asserted**, and every range
is verified contiguous from 1 to its stated maximum. The meanings are `PRD-008` §0.2's own, not this section's
paraphrase — **`FEE-PO-*` is a port / integration obligation**, and does **not** correspond to `PO-n` in §2A or
`SPO-n` in §2B. That distinction is the whole reason §2G.1 exists, and it is tested rather than asserted.

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `FEE-FR-n` | Functional requirement — what the module does | **62** | `FEE-FR-001` … `FEE-FR-062` | §§8–28.1 and §42.4, across **28** definition sections |
| `FEE-BR-n` | Business rule — a decision the domain enforces | **28** | `FEE-BR-001` … `FEE-BR-028` | §30 (29 rows) plus §§8–26 and §42.4, across **25** sections |
| `FEE-INV-n` | Invariant — must hold at every observable moment | **10** | `FEE-INV-001` … `FEE-INV-010` | §31 plus §§10–25 and §42.4, across **13** sections |
| `FEE-EVT-n` | Domain event published by `BC-05` | **3** | `FEE-EVT-001` … `FEE-EVT-003` | §26, §18.1 |
| `FEE-XC-n` | Explicit exclusion — what this module MUST NEVER do | **23** | `FEE-XC-001` … `FEE-XC-023` | §32 plus §§9.3–28.1, §42.4, §42.7, across **19** sections |
| `FEE-PO-n` | **Port / integration obligation** — what it consumes, and from whom | **8** | `FEE-PO-001` … `FEE-PO-008` | §14.1, §24, §25, §26, §27, §28.1, §33 |
| `FEE-AC-n` | Acceptance criterion | **98** | `FEE-AC-001` … `FEE-AC-098` | §§35.1–35.16, §26 |
| `FEE-GAP-n` | **Governance gap / open question — not a requirement** | **17** | `FEE-GAP-001` … `FEE-GAP-017` | §39 |
| `FEE-RSK-n` | Risk register entry — **⚠ registered here, but NOT declared in `PRD-008` §0.2** | **10** | `FEE-RSK-001` … `FEE-RSK-010` | §38 |

Total Revenue & Finance identifiers — **259**. Of these, **134 carry obligation** (62 + 28 + 10 + 3 + 23 + 8),
**98 are `FEE-AC-*` acceptance criteria**, **17 are `FEE-GAP-*` open questions carrying no authority** and **10 are
`FEE-RSK-*` risk entries**. `FEE-AC-*` are *verified by* tests and `FEE-GAP-*` are *open questions*; neither is an
obligation, exactly as §2F treats `ATT-AC-*` and `ATT-GAP-*`. **Measured coverage — 134 / 134 = 100%:** every
obligation-bearing identifier appears in §36.1 and cites at least one `FEE-AC-*`, and every one of the 98 declared
criteria is used, with **zero orphans in either direction**. That figure is enforced by the pre-existing
[`tool/docs_check/prd008_traceability.py`](../../tool/docs_check/prd008_traceability.py) and is **not re-asserted
here** — the two gates check different things and both must pass.

> **⚠ `FEE-RSK-*` is registered with a disclosure, not quietly normalised.** It is defined in `PRD-008` §38 as ten
> contiguous entries and is well formed, but it is **absent from that document's own §0.2 register table**, which
> §0.1 requires to be *"declared up front with ranges — publishing the ranges as a promise."* That is a
> **pre-existing Stage 2 register-declaration defect**, found by counting rather than reading, and it belongs to
> **`PRD-008`'s document owner** — adding a §0.2 row is an edit to the PRD, not to this matrix.
>
> **Two readings were available and the flattering one was refused.** Omitting the register here would have let
> §2G claim a tidy eight-register inventory that matched §0.2 exactly and passed without a footnote. It would also
> have meant that ten identifiers existed in a Rank 3 document and in **no** register anywhere — the precise
> condition Stage 5 exists to prevent. **Registering it and disclosing the omission is therefore the honest
> reading, and it is deliberately the inconvenient one:** the Stage 5 gate script prints the finding on **every
> run** and cannot be silenced without editing the script. Registering a prefix in this matrix does **not** repair
> `PRD-008` §0.2, and this section does not claim it does.

**`PRD-008` is v1.7 `DRAFT`, not frozen.** Registering its identifiers here satisfies `PRD_LIFECYCLE.md` **Stage 5**
only. Stage 6 (`IMPL-*` allocation) and Stage 7 (freeze) are **not** addressed by this section, and neither is
claimed: `docs/40-implementation/` contains **no `revenue-finance/` subdirectory**, so no `IMPL-*` task document
exists, and `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-008`**, which is the only place a freeze
can be conferred. `PRD-008` contains **zero** occurrences of the token `IMPL-`, so **no `IMPL-*` number is claimed
or consumed** and Stage 6's *"never reuse or reassign a number"* rule is untouched. Nothing here confers baseline
status. **`PRD-008`'s Stage 3 verdict remains ⛔ NOT ALIGNED 5/6; this section does not upgrade it** — Stage 5 asks
whether the registers are registered, not whether the architecture review passed, and the two gates are independent.

### 2G.1 Prefix collisions checked — zero, in both directions

**Zero collisions** against all seven existing registers — authentication (`AUTH`/`BR`/`XC`/`AC`/`PR`/`TR`/`EV`/
`AERR`/`CFG`/`SO`/`PP`/`AU`/`EP`), Library (`LIB`/`LIB-14B`/`LIB-DISC`/`INV-SEC`/`LBR`/`LIB-PREV`/`LXC`/`INV-XC`/
`LAC`/`LAC-14B`/`IAC`/`LCFG`/`ICFG`/`LEV`/`PO`/`IT`), Student Identity (`SID`/`SID-BR`/`SXC`/`SPO`/`SEV`/`SID-INT`/
`SID-INV`/`SCFG`/`SID-AC`), Student Management (`SM`/`SM-BR`/`SM-XC`/`SM-INV`/`SM-EV`/`SM-PO`/`SM-AC`/`SMCFG`/
`LMD`/`SM-GAP`), Membership (`MM-FR`/`MM-BR`/`MM-INV`/`MM-EVT`/`MM-XC`/`MM-AC`/`MM-NFR`/`MM-PO`/`MM-CFG`/`MM-GAP`),
Seat Management (`SEAT-FR`/`SEAT-BR`/`SEAT-INV`/`SEAT-EVT`/`SEAT-XC`/`SEAT-PO`/`SEAT-CFG`/`SEAT-NFR`/`SEAT-AC`/
`SEAT-GAP`) and Attendance Management (`ATT-FR`/`ATT-BR`/`ATT-INV`/`ATT-EVT`/`ATT-XC`/`ATT-PO`/`ATT-CFG`/`ATT-NFR`/
`ATT-AC`/`ATT-GAP`). No `FEE-<REG>` prefix equals any of them.

**⚠ This module is where the `PO-n` / `SPO-n` hazard recurs, and it is the sharpest instance in the repository so
far.** `PRD_LIFECYCLE.md`'s Stage 5 text names that near-miss as the reason the stage exists — *"citing `PO-3` when
`SPO-3` was meant would move a requirement from one bounded context to another … which no amount of careful reading
reliably catches."* `PRD-008` owns `FEE-PO-001`…`FEE-PO-008`, so the substring `PO-` is present in this register,
and **three different meanings now share it across three bounded contexts**:

| Identifier | Meaning | Context | Surface |
|---|---|---|---|
| `PO-1`…`PO-12` | **Protected operation** | Library Management | Anonymous **read** (public library preview) |
| `SPO-1`…`SPO-9` | **Protected operation** | Student Identity | Authenticated **write** |
| **`FEE-PO-001`…`FEE-PO-008`** | **Port / integration obligation** | **`BC-05` Fee & Collection** | Neither — an outbound dependency declaration |

A mistaken citation between these would be **silent**: all three are well-formed identifiers, and `FEE-PO-*` is not
even the same *kind* of thing as the other two. It follows the `ATT-PO-*` convention §2F records, not the `PO-n`
one. **So the check was run mechanically, in both directions, rather than reasoned about:**

| Direction | Question | Result |
|---|---|---|
| Inward, tokenisation | Does a word-boundary search for `PO-n` or `SPO-n` reach `FEE-PO-n`? — `re.findall(r'(?<![-A-Za-z])([A-Z][A-Z0-9]*(?:-[A-Z]+)*)-\d+', 'FEE-PO-003')` | **`['FEE-PO']`** — the whole hyphenated prefix is the token, so **no**. Asserted in the gate script, so it fails if the rule ever changes |
| Inward, reverse | Does `PRD-008` contain a **bare** `PO-n` or `SPO-n` token that is not the tail of a `FEE-PO-n`? — `grep -no '\(^\|[^-A-Za-z]\)S\?PO-[0-9]'` | **0 hits.** `PRD-008` never cites the Library or Student Identity protected-operation registers at all, so the class of error cannot occur in this document |
| Inward, foreign prefixes | Does `PRD-008` cite foreign registers by a bare prefix? | **52 prefixes** — every one a correct foreign citation, led by `BC-nn` (695), `PRD-nnn` (261), `ADR-nnnn` (206), `E-nn` (152) and `MP-GBR-nn` (90) |
| Outward | Does any document outside `docs/30-product/revenue-finance/` **define** a `FEE-*` identifier? | **0.** **18** line-start occurrences exist — **16** in `ADR-0035`/`0037`/`0039`/`0040`/`0041`/`0042` and **2 in this file, added by this section** — and **all 18 resolve to an identifier `PRD-008` already defines**, so every one is a citation, not a definition |
| Outward, code | Does `FEE-*` appear in `tool/`, `lib/` or `test/`? | **0**, excluding the two gate scripts themselves and three explanatory comments in `prd006_traceability.py` naming `FEE-AC-*`/`FEE-GAP-*` as the obligation-counting precedent |

**A citation is not a collision, and the outward hits are the case that proves why the check must resolve rather
than count.** A naive line-start search returns 18 hits outside the module and *looks* like eighteen collisions. Each
was resolved against the set of 259 identifiers `PRD-008` actually defines, and **all 18 matched** — 16 are table
rows in `ACCEPTED` ADRs citing `FEE-GAP-002`, `FEE-XC-022`, `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-007`, `FEE-BR-019`,
`FEE-AC-032`/`033`/`034` and `FEE-GAP-001`; the other **2 are in this section itself**, where a sentence explaining
the collision check happens to begin with a backticked identifier. ⚠ **Those two are this pass's own additions, and
the count above was stale for one draft because of them** — it read *"16"* until the figure was re-measured after
§2G was written, which is the same derived-statement drift class the repository tracks as `GCP-01`/`07`/`08`.
§2F records the same self-reference — *"this section's own citations are **not** counted as outward hits …
`TRACEABILITY_MATRIX.md` is where the register is registered, so it necessarily names these identifiers"* — but
this gate goes one step further and **counts them anyway**, then resolves them, so the matrix earns no exemption a
governance document is denied. Governance cannot record a decision *about* a register without naming the
identifiers it concerns, which is the same reason §2F allow-lists `ADR-0021` and §2D allow-lists `ADR-0019`. The
gate script resolves each hit against the defined set instead of allow-listing files, so a genuinely **new**
`FEE-*` definition in any of those same ADRs would still fail the run. This is §2C.1's principle applied
mechanically: *a checker that cannot tell a substring from a real hit is one that gets switched off.*

**Numeric ranges are per-register, not global.** `PRD_LIFECYCLE.md` §5 rule 1 makes the *identifier* unique across
the platform — not the number — and §2B.1 states that independently numbered registers *"overlap numerically on
purpose; the prefix carries the producer."* `FEE-FR-001` therefore does not collide with `ATT-FR-001`,
`SEAT-FR-001`, `MM-FR-001`, `SM-1.1` or `AUTH-1.1`, and **no range-overlap prohibition applies to this section**.
The one range this repository allocates globally is `IMPL-*`, governed by Stage 6 — **untouched here**, per §2G.

**§5 rule 3 was not needed, and that is recorded rather than left to inference.** The rule is *"on collision, change
the new prefix, never the existing one."* Because the measured collision count is **zero in both directions**, no
prefix was changed, and `FEE-*` stands exactly as `PRD-008` published it at Stage 2. Had `FEE-PO-*` collided, it is
**`FEE-PO-*` that would have moved** — the new register — and not Library's `PO-n`.

### 2G.2 Stage 5 exit gate — mechanically verifiable

`PRD_LIFECYCLE.md` Stage 5 requires counts *"verified mechanically — counted by a tool, not by reading"*, with
**zero collisions**. Two independent scripts must both pass, and neither subsumes the other:

```
python3 tool/docs_check/prd008_traceability.py   # exit 0 = PRD-008 agrees with itself
python3 tool/docs_check/prd008_stage5.py         # exit 0 = the matrix agrees with PRD-008
```

**Why two scripts and not one.** The pre-existing `prd008_traceability.py` checks `PRD-008` against **itself** —
§0.2's declarations against the body, §36.1 coverage, criterion orphans in both directions, and the gap ledger's own
arithmetic. It **never opens this file**, so before `prd008_stage5.py` existed the Stage 5 gate had no mechanical
enforcement for this module at all: §2G could have been written with any numbers in it and nothing would have
objected. The new script closes exactly that hole and **weakens nothing** — `prd008_traceability.py` is byte-
unchanged and must still pass independently. `prd008_stage5.py` fails (exit 1) if §2G is missing entirely, if any
row's count or range maximum disagrees with the figure computed from the body, if a range develops a hole or fails
to start at 1, if §2G registers a prefix the gate does not know about, if the prefix tokenisation that separates
`FEE-PO-n` from `PO-n`/`SPO-n` ever becomes ambiguous, if a bare `PO-n`/`SPO-n` token appears in `PRD-008`, if any
document outside the module **defines** a `FEE-*` identifier, or if §2G's stated obligation and total figures do not
match the recomputed sums.

**The missing-section case is reported as the Stage 5 failure it is, not as a missing file.** Run against the
matrix *before* this section was added, the script printed *"TRACEABILITY_MATRIX.md has no section 2G — `PRD-008`'s
Stage 5 registration is MISSING, which IS the Stage 5 failure"* and exited 1. That was the true state of the
repository until this commit: `grep -c 'FEE-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**.

**Three declarations, one computation.** §0.2's ranges, §0.2's counts and §2G's registrations are each checked
against the same measured figures, so no two can drift apart unnoticed — the defence §2C lacked when it carried
stale figures through two correction passes until a script disproved them. The class of error is not hypothetical
for this module either: `PRD-008` §0.2 carried a stale `FEE-GAP-*` row (15 / total 231) for a whole version after
`FEE-GAP-016` was added, and the error ran in the **flattering** direction, since a smaller gap count makes a module
look closer to Freeze than it is.

**One convention the script models explicitly, established by inspection rather than assumed.** `PRD-008` defines
the same register in **both** prose and table form — every one of the nine does, except `FEE-RSK-*` (table only) and
`FEE-AC-*` (98 of 103 sites in tables). A count that accepted every *occurrence* returns **129** `FEE-FR-*` for a
register of **62**, **85** `FEE-BR-*` for **28** and **103** `FEE-AC-*` for **98** — phantom duplicates in the
checker, not defects in the PRD, because §36.1 (coverage), §36.1a (the orphan-criteria record), §39.1 (gap
reconciliation), §39.2 and §42.3 **restate** identifiers defined elsewhere. The definition rule is therefore
**deliberately identical** to `prd008_traceability.py`'s — a line beginning with the backticked identifier, or a
table row whose first cell is the identifier — so the two gates cannot disagree about what a definition is. Under
that rule, **zero** identifiers are defined only in a restating section, so no allow-list is needed.

---

## 2H. Identifier inventory — Integration (`PRD-019`, the payment webhook contract)

Registers the `ITG-*` prefix so that **111 identifiers in a Rank-3-registered document are not registered nowhere** —
the exact condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for `PRD-008`.

⛔ **This section STILL does not claim Stage 5 for `PRD-019` — and at v1.11 the reason has changed, which is worth
reading rather than skipping.** The v1.10 reason is quoted so it is not silently replaced: *"`PRD-019`'s `ITG-AC-*`
register is **empty**, so coverage is **0/54** and no obligation is *verified*."* **That reason is gone.**
`PRD-019` v0.3 authors **54** criteria and coverage is **54/54 = 100%**, computed by script, so every obligation now
appears in an `…-AC-*` **Verifies** column exactly as `PRD-008` §0.2 requires.

**Two different reasons now withhold the stage, and neither is coverage:**

| # | Reason | Consequence |
|---|---|---|
| **1** | **Stage 4's verdict is not conferred.** `PRD-019` §6 records Stage 3 and Stage 4 as **RUN and MEASURED** — now **6/6 aligned and 6/6 pass** at `PRD-019` **v0.4**, where v1.11 of this matrix recorded **5/6 pass** — but `PRD_LIFECYCLE.md` §6 assigns those stages to the **architecture reviewer** and the **requirements reviewer**, and the authoring pass held neither role. **Stages are sequential**; Stage 5 cannot be claimed over an unconferred Stage 4. ⚠ **The measured figure improved and this reason did NOT weaken** — that is the substance of the v1.12 edit. The last **substantive** Stage 4 finding (check 3, `ITG-FR-017`'s unbounded retention) is **closed**; the obstacle here was never the finding but the **role**, so closing it moves this reason not at all. *6 of 6 measured is not 6 of 6 conferred.* | `ADR-0048` §3; `PRD-019` §6.2 |
| **2** | **No gate script exists for `ITG-*`.** Stage 5's gate demands counts and ranges *"verified **mechanically**"*. The counts in the table below **are** computed by script — but by a **one-off** script in this pass, not by a committed checker under `tool/` that CI re-runs. **A number computed once is not a number verified mechanically on every commit** | §2H.2 |

⚠ **Reason 2 is the one that would have been easiest to gloss over**, because the table below genuinely is computed
rather than typed. The distinction that matters for a *gate* is **repeatability**: `PRD-008` has
`prd008_stage5.py` in `tool/`, `PRD-019` has nothing, and until it does, every `ITG-*` figure is only as current as
the last manual run. **Registration is performed; the stage is withheld — for two stated reasons instead of one.**

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `ITG-FR-*` | Functional requirements — route, transport, schema, signature, dedup, retry, events | **28** | `001`–`028` | `PRD-019` §4.1–§4.6 |
| `ITG-BR-*` | Business rules — TLS, port narrowing, IP reachability, order, minor-unit carry, verification-first, secret custody, layer separation, port routing, authorisation-vs-capture | **11** | `001`–`011` | `PRD-019` §4.1–§4.6 |
| `ITG-INV-*` | Invariants — once-only event identity, no effect before verification, one evidence attempt, tenant on every record, no synthesised state | **5** | `001`–`005` | `PRD-019` §4.2–§4.6 |
| `ITG-XC-*` | Exclusions — vendor name on the wire, raw payload as financial state, unsigned/IP-trust bypass, provider IP/SDK transcription, age-based rejection, dead-letter, webhook-as-sole-path, `order.paid`, downtime events, refund/settlement/subscription events | **10** | `001`–`010` | `PRD-019` §4.1–§4.6 |
| `ITG-GAP-*` | Open questions | **3** | `001`–`003` | `PRD-019` §7 |
| **`ITG-AC-*`** | **Acceptance criteria** — one per obligation, bijective | **54** | `001`–`054` | **`PRD-019` §4.10** |
| **Total** | | **111** | | **54 obligation-bearing + 54 `ITG-AC-*` + 3 `ITG-GAP-*`** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by script rather than
read** — the `SR-01` failure class this matrix has already suffered once.

**Coverage, measured at `PRD-019` v0.3:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers | **54** (28 `ITG-FR-*` + 11 `ITG-BR-*` + 5 `ITG-INV-*` + 10 `ITG-XC-*`) |
| Obligations carrying an `ITG-AC-*` | **54** |
| **Coverage** | **54 / 54 = 100.0%** |
| Orphan criteria (verify nothing) | **0** |
| Obligations verified twice | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 54** |

⚠ **The last row is why the coverage row above is safe to print.** v1.10 refused to publish a percentage because it
would have been **0%** and *"printing a computed 0% as though it were a result would dress a shortfall as a metric."*
The symmetric error at v1.11 would be publishing **100%** and letting a reader take it for verification. It means
every obligation **has a criterion**; **no criterion has passed**, because no implementation exists
(`docs/40-implementation/integration/` still does not exist). This matrix has been wrong about a coverage figure
before — `PRD-006` v1.0 published *"100% coverage"* against a true **49.1%** — so the figure is computed **and**
qualified, not merely computed.

### 2H.1 Prefix collisions checked — in both directions

| Direction | Result |
|---|---|
| `ITG-` **defined** outside `PRD-019` | **0** — the prefix was collision-checked at reservation (`PRD-019` §5: `ITG-` occurred **0 times** repository-wide) |
| `ITG-` **cited** outside `PRD-019` | Governance citations only — `ADR-0043`, `ADR-0044`, `ADR-0045`, `ADR-0046`, `ADR-0047`, **`ADR-0048`**, **`PRD-019_ARCHITECTURE_ALIGNMENT.md`** and this section. **A citation is not a collision** (the §2C.1 principle) |
| Foreign prefixes **inside** `PRD-019` | `FEE-*` (cited, `BC-05`-owned, **never defined** there — §3 of that document forbids it), `SAAS-XC-006`, `SID-INT-*`, `MP-*`, `Q-B31`. All **inspected at their lines** as correct foreign citations |
| `INT-*` | **Refused at reservation, not merely avoided.** `Student_Identity_PRD_v1.md` §4.16 owns `SID-INT-1`…`SID-INT-12`, so a bare `INT-12` would grep-collide. Per `PRD_LIFECYCLE.md` §5 rule 3 — *"on collision, change the new prefix, never the existing one"* — the **new** prefix moved |
| `ITG-` vs `ATT-`/`MM-`/`SEAT-`/`SM-`/`FEE-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

### 2H.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| **Claim Stage 5 for `PRD-019`** | ⚠ **Coverage is no longer the reason.** It is **54/54**. The stage is withheld because **Stage 4's verdict is not conferred** and **no committed `ITG-*` gate script exists**. See the callout above |
| **Present coverage as verification** | The percentage **is** published at v1.11 (**100%**) because it is now non-zero and computed — but the table states **0 of 54 criteria pass**, because none can until an implementation exists. v1.10 withheld the figure to avoid dressing a shortfall as a metric; v1.11 qualifies it to avoid the mirror-image error |
| **Allocate an `IMPL-*` range** | Stage 6. `docs/40-implementation/integration/` does not exist and `PRD-019` allocates **0 numbered `IMPL-nnn` identifiers** (measured as `IMPL-\d+`; the bare token `IMPL-` *is* present there, as the wildcard `IMPL-*` in sentences denying an allocation, so a bare-prefix count is the **wrong instrument** — the same correction is applied at `PRD-019` §6 and `ADR-0047` §5/§8). Rule 1: *"Never reuse or reassign a number"* — so allocation is not speculative |
| **Add a gate script for `ITG-*`** | No file under `tool/` is created or modified by this pass; all 9 `tool/docs_check/*.py` are **byte-unchanged**. ⚠ **The condition v1.10 stated for this debt has now ARRIVED** — it read *"a `PRD-019` gate is owed **when `ITG-AC-*` exists**"*, and `ITG-AC-*` now exists with 54 members. **The debt is therefore restated as DUE rather than quietly carried**, and it is one of the two reasons Stage 5 is still withheld. It is **not** stubbed here: a checker written in the same pass as the register it checks, by the same author, verifies agreement with itself |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-019` is **Rank 3-registered, not Rank 3-holding** — *"Not admitted"* to the baseline — and this matrix is **unranked**, so it confers nothing |
| **Touch any `PRD-008` row** | §2G is byte-unchanged, as is `PRD-008` itself |

---

## 2I. Identifier inventory — Tenancy (`PRD-013`, the tenant aggregate and its boundary)

Registers the `TEN-*` prefixes so that **51 identifiers in a Rank-3-registered document are not registered nowhere** —
the exact condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for `PRD-008` and
§2H for `PRD-019`. Before this commit `grep -c 'TEN-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**.

⛔ **This section does not claim Stage 5 for `PRD-013`.** `PRD-013`'s Stage 4 was **run and re-run**, and the
re-review returned **6 of 6 gate checks PASS with 0 findings** after four corrections were applied. That is a better
measured position than §2H held at either v1.10 or v1.11 — and it moves neither of the two reasons below, which is
the point worth reading rather than skipping.

**Two reasons withhold the stage, and neither is coverage or correctness:**

| # | Reason | Consequence |
|---|---|---|
| **1** | **Stage 4's verdict is not conferred.** `PRD_LIFECYCLE.md` §6 assigns Stage 4 to the **requirements reviewer** and Stage 5 to the **traceability owner**; the authoring pass held neither role, and L283 records that *"**Every PRD needs a named owner. None has one**"* (`PRD_GAP_ANALYSIS.md` `PGA-08`). **Stages are sequential**; Stage 5 cannot be claimed over an unconferred Stage 4. The same logic §2H applies to `PRD-019` applies here without weakening: *6 of 6 measured is not 6 of 6 conferred* | `PRD_LIFECYCLE.md` §6 L270–284; `PGA-08` |
| **2** | **No gate script exists for `TEN-*`.** Stage 5's gate demands counts and ranges *"verified **mechanically**"*. The counts below **are** computed by script — but by a **one-off** script in this pass, not by a committed checker under `tool/` that CI re-runs. **A number computed once is not a number verified mechanically on every commit** | §2I.2 |

⚠ **Reason 2 is the one that would have been easiest to gloss over**, because the table below genuinely is computed
rather than typed. The distinction that matters for a *gate* is **repeatability**: `PRD-008` has `prd008_stage5.py`
in `tool/`, `PRD-013` has nothing, and until it does, every `TEN-*` figure is only as current as the last manual run.
**Registration is performed because the alternative is 51 identifiers registered nowhere; the stage is withheld
because the traceability it also demands does not exist.**

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `TEN-FR-*` | Functional requirements — purpose, the `Tenant` aggregate and its five value objects, context resolution, event envelope, row/cache/index partitioning, security review | **18** in force (**21** declared) | `001`–`021` | `PRD-013` §1–§3 |
| `TEN-BR-*` | Business rules — suspended tenant rejects all writes; cross-tenant reach | **2** in force (**4** declared) | `001`–`004` | `PRD-013` §4 |
| `TEN-INV-*` | Invariants — tenant ID immutable; residency region immutable after first write | **2** in force (**5** declared) | `001`–`005` | `PRD-013` §5 |
| `TEN-EVT-*` | Domain events — `tenancy.TenantProvisioned`, `tenancy.TenantSuspended`. **Register closed at two** per Bounded Context Map L435 | **2** | `001`–`002` | `PRD-013` §6 |
| `TEN-XC-*` | Exclusions — `TenantOrganisation`, `StaffAssignment`, authorisation outcomes, credentials, subscription state, cross-tenant reach, lifecycle state machine, third event type, cached-authorisation bypass | **10** | `001`–`010` | `PRD-013` §7 |
| `TEN-CFG-*` | Configurables — **declared EMPTY.** Rank 7 `CONFIGURATION_GUIDE.md` defines no tenancy parameter, so `TEN-CFG-001` was **retired rather than published**: an unbounded configurable is Stage 4 check 3's *"specification hole"* | **0** in force (**1** declared, retired) | `001` | `PRD-013` §9 |
| **`TEN-AC-*`** | **Acceptance criteria** | **13** in force (**16** declared) | `001`–`016` | **`PRD-013` §8** |
| `TEN-GAP-*` | Open gaps — absent decisions owned elsewhere | **4** | `001`–`004` | `PRD-013` §10 |
| **Total** | | **51** in force (**63** declared) | | **34 obligation-bearing + 13 `TEN-AC-*` + 4 `TEN-GAP-*`; 12 retired** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by script rather than
read** — the `SR-01` failure class this matrix has already suffered once.

⚠ **Contiguity here is judged over the DECLARED set, not the in-force set, and that distinction is load-bearing.**
Five of the eight registers carry **holes**: `TEN-FR` skips `012`/`016`/`017`, `TEN-BR` skips `002`/`003`, `TEN-INV`
skips `003`–`005`, `TEN-AC` skips `003`–`005`, and `TEN-CFG-001` is retired leaving the register empty. Read against
the in-force set alone, **five registers would fail the gate**. They do not fail, on this matrix's own established
rule — **§2D.2**, where `MM-GAP-006`/`007` have no definition row and are *"retained, not reused, so citations
written against them stay resolvable"*, and *"**Contiguity is judged over the declared set**, so `MM-GAP-001`…`010`
is contiguous."* Declared = in force ∪ retired. Measured: `51 + 12 = 63` and every register contiguous `1..max`.
The 12 retired identifiers are enumerated with their reasons at `PRD-013` §9 and **may never be reused**
(`PRD_LIFECYCLE.md` Stage 6 rule 1).

**Coverage, measured at `PRD-013` v0.1:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers | **34** (18 `TEN-FR-*` + 2 `TEN-BR-*` + 2 `TEN-INV-*` + 2 `TEN-EVT-*` + 10 `TEN-XC-*`) |
| Obligations carrying a `TEN-AC-*` | **22** |
| **Coverage** | **22 / 34 = 64.7%** |
| Orphan criteria (verify nothing) | **0** |
| Dangling `TEN-*` citations | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 13** |

⚠ **The last two rows are why the coverage row is safe to print.** The percentage is **not** 100%, and it is
published unrounded rather than framed as *"substantially covered"*. The **12** uncovered obligations are named in
`PRD-013` §8's reverse-coverage paragraph — `TEN-FR-001`…`009`, `TEN-FR-013`, `TEN-FR-015`, `TEN-BR-004` — each a
**structural or ownership statement** verified by the module's shape rather than by a runtime assertion. That is a
stated reason, not an excuse, and it is recorded here so a later reader does not have to rediscover whether the
shortfall was noticed. `TEN-XC-002`…`006` count as covered via `TEN-AC-008`'s **range notation**, which is
established practice in frozen `PRD-007` (`SEAT-AC-166` maps via `SEAT-EVT-001`…`004`); a literal per-identifier
grep cannot resolve a range and will under-report. **0 of 13 criteria pass**, because no implementation exists —
`docs/40-implementation/tenancy/` does not exist. This matrix has been wrong about a coverage figure before —
`PRD-006` v1.0 published *"100% coverage"* against a true **49.1%** — so the figure is computed **and** qualified.

### 2I.1 Prefix collisions checked — in both directions

| Direction | Result |
|---|---|
| `TEN-` **defined** outside `PRD-013_TENANCY.md` | **0.** A repository-wide search for `TEN-[A-Z]+-[0-9]+` across `docs/`, `tool/`, `lib/` and `test/` returns exactly **two** files: the PRD itself and `PRD-013_ARCHITECTURE_ALIGNMENT.md` |
| `TEN-` **cited** outside `PRD-013_TENANCY.md` | `PRD-013_ARCHITECTURE_ALIGNMENT.md` — the document's own Stage 3 review record — and this section. **A citation is not a collision** (the §2C.1 principle) |
| Foreign prefixes **defined** inside `PRD-013` | **0.** Every foreign identifier in the PRD (`LIB-8.*`, `AUTH-5.*`, `BR-5.20`, `XC-7.14`, `MP-GBR-*`, `E-18`, `X-13`, `BC-19`, `BC-21`) appears **only** as an attributed citation, never in a first table cell or at a line start — the `PRD-008` §C5 test, *"all attributed quotations, 0 unattributed restatements"* |
| `TEN` vs the **47** prefix stems already registered in this matrix | **No overlap.** The registered stems are `ATT`, `ATT-AC`, `ATT-BR`, `ATT-CFG`, `ATT-EVT`, `ATT-FR`, `ATT-GAP`, `ATT-INV`, `ATT-NFR`, `ATT-PO`, `ATT-XC`, `FEE`, `FEE-AC`, `FEE-BR`, `FEE-EVT`, `FEE-FR`, `FEE-GAP`, `FEE-INV`, `FEE-PO`, `FEE-RSK`, `FEE-XC`, `IMPL`, `INT`, `ITG`, `ITG-AC`, `ITG-BR`, `ITG-FR`, `ITG-GAP`, `ITG-INV`, `ITG-XC`, `MM`, `MM-AC`, `MM-GAP`, `MP`, `SEAT`, `SEAT-AC`, `SEAT-BR`, `SEAT-CFG`, `SEAT-EVT`, `SEAT-FR`, `SEAT-GAP`, `SEAT-INV`, `SEAT-NFR`, `SEAT-PO`, `SEAT-XC`, `SID-INT`, `SM` — **none is `TEN` or a `TEN-` stem** |
| Substring hazard — `TEN` inside a longer token | **Checked, not assumed.** `TEN-FR-021` tokenises as `['TEN-FR']`, the whole hyphenated stem; a reverse search for `(FR)-\d+` against `TEN-FR-021` returns `[]`, so `TEN-FR-*` cannot be mistaken for a bare `FR-*` register. This is the §2B.1 `PO-n`/`SPO-n` hazard class — the near-miss Stage 5 exists to catch — tested rather than reasoned about |
| `TEN-` vs `ATT-`/`MM-`/`SEAT-`/`SM-`/`FEE-`/`ITG-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

**Collision result: zero, in both directions.**

### 2I.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| **Claim Stage 5 for `PRD-013`** | The stage is withheld because **Stage 4's verdict is not conferred** (no role holder exists — `PGA-08`) and **no committed `TEN-*` gate script exists**. Correctness is not the obstacle; the re-review returned 0 findings. See the callout above |
| **Present coverage as verification** | **64.7%** is published because it is computed, non-zero and honest — but the table states **0 of 13 criteria pass**, because none can until an implementation exists, and the **12** uncovered obligations are named rather than absorbed into a percentage |
| **Add a gate script for `TEN-*`** | No file under `tool/` is created or modified by this pass. The debt is recorded as **DUE**, not stubbed: *a checker written in the same pass as the register it checks, by the same author, verifies agreement with itself* (§2H.2). The `PRD-008` pattern — `prd013_traceability.py` for internal agreement, `prd013_stage5.py` for agreement with this matrix, neither subsuming the other — is what is owed |
| **Allocate a `TEN-IMPL-*` or `IMPL-*` range** | Stage 6. `docs/40-implementation/tenancy/` does not exist and `PRD-013` allocates **0** numbered implementation identifiers. Rule 1: *"Never reuse or reassign a number"* — so allocation is not speculative |
| **Reuse any of the 12 retired identifiers** | `PRD-013` §9 retires them permanently. They are registered here as **declared** so citations against them stay resolvable and the ranges stay contiguous — the §2D.2 treatment — **not** as available numbers |
| **Assert a `ResidencyRegion` value** | `TEN-INV-002` makes the region immutable after first write **without** naming a permitted set; the set is `TEN-GAP-001`, open and owned elsewhere. No value is invented here, in the PRD, or in its alignment record — the restraint `ADR-0041` L214 exercises when it declines to *"name a period, a statute or a jurisdiction rule"* |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-013` is **Rank 3-registered, not Rank 3-holding**, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| **Touch any existing section, `PRD_REGISTRY.md`, or any ADR** | §2 through §2H are **byte-unchanged**, as are `PRD-013_TENANCY.md`, `PRD-013_ARCHITECTURE_ALIGNMENT.md`, `PRD_REGISTRY.md` and all 49 ADRs. This pass appends §2I, three header fields and one change-history row |
| **Resolve the alignment record's stale hash** | `PRD-013_ARCHITECTURE_ALIGNMENT.md` cites the PRD hash `fcd99ff7…f97e` as reviewed at Stage 3; the PRD is now `688239cb…ba9c` after the Stage 4 corrections. The citation is **historically correct** — it records what Stage 3 actually read — but `alignment_record_freshness` will flag it. Re-confirming Stage 3 is the architecture reviewer's decision, not this pass's |

---

## 2J. Identifier inventory — Audit Trail (`PRD-016`, the `AuditEntry` aggregate)

Registers the `AUD-*` prefixes so that **58 identifiers in a Rank-3-registered document are not registered
nowhere** — the exact condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for
`PRD-008`, §2H for `PRD-019` and §2I for `PRD-013`. Before this commit
`grep -c 'AUD-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**.

✅ **Stage 5 IS claimed for `PRD-016`, and the two reasons that withheld it from `PRD-013` at v1.13 are both
discharged.** That is the substantive content of this section, so the discharge is shown rather than asserted:

| # | Reason §2I withheld the stage | Status for `PRD-016` |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`). Self-conferral was refused | **DISCHARGED by conferral**, recorded at [`PRD-016_STAGE5_CONFERRAL.md`](../30-product/audit/PRD-016_STAGE5_CONFERRAL.md) in the identical form `PRD-008_STAGE4_CONFERRAL.md` and `PRD-013_STAGE5_CONFERRAL.md` used. ⚠ **`PGA-08` is a standing repository gap and is NOT cured here** — the conferral is per-act, not an owner appointment (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*) |
| **2** | **No committed gate script.** Stage 5 demands counts *"verified **mechanically**"*, and *"a number computed once is not a number verified mechanically on every commit"* | **DISCHARGED by construction.** [`prd016_traceability.py`](../../tool/docs_check/prd016_traceability.py) and [`prd016_stage5.py`](../../tool/docs_check/prd016_stage5.py) are committed under `tool/docs_check/` and re-run on every invocation. Neither imports the other, and they use **different parsing strategies** — see §2J.3 |

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `AUD-FR-*` | Functional requirements — ownership of `AuditEntry`, the aggregate and its four value objects, recording and the event envelope, integration edges, query confinement | **16** | `001`–`016` | `PRD-016` §1–§3, §6–§7 |
| `AUD-BR-*` | Business rules — correction by appending; immutability for every role including Platform Administrator; erasure by key destruction, never removal | **3** | `001`–`003` | `PRD-016` §4 |
| `AUD-INV-*` | Invariants — entry immutable in its entirety; non-null `tenantId`; actor of record; no credential or unmasked personal data | **4** | `001`–`004` | `PRD-016` §5 |
| `AUD-EVT-*` | Domain events — **DECLARED EMPTY, and registered as empty rather than omitted.** `BC-24` publishes **no** domain event: scanning Bounded Context Map §9's event table for rows whose *producer* is `BC-24` returns **0**, while `BC-24` appears **25 times as a consumer** — the widest event fan-in in the map. Publishing one would require an ADR (BC Map §7: *"If an edge is not in this table, it does not exist"*) | **0** | *none issued* | `PRD-016` §0.3, §6 |
| `AUD-XC-*` | Exclusions — what **MUST be impossible**: mutation paths, authorisation decisions, credential capture, deciding another context's auditable list, retention periods, legal-hold mechanism, notification, search indexing | **12** | `001`–`012` | `PRD-016` §8 |
| `AUD-CFG-*` | Configurables — **DECLARED EMPTY, and no identifier issued at all.** Rank 7 `CONFIGURATION_GUIDE.md` defines no audit, retention or legal-hold parameter (`CFG-1`…`CFG-12` are SMS, session, device, lock and *account* values; `CFG-9`/`CFG-10` are **account** retention). Stage 4 check 3 rates an unbounded configurable *"a specification hole"*, so none is published. ⚠ **This differs deliberately from `TEN-CFG-001`**, which was issued then retired: a retired number is permanently unusable, so `PRD-016` burns none | **0** | *none issued* | `PRD-016` §0.3 |
| **`AUD-AC-*`** | **Acceptance criteria** | **18** | `001`–`018` | **`PRD-016` §9** |
| `AUD-GAP-*` | Open gaps — absent decisions owned elsewhere (retention period, `AUTH-10.27` vs `E-20`, legal-hold mechanism, support-access boundary, the Class A register) | **5** | `001`–`005` | `PRD-016` §10 |
| **Total** | | **58** | | **35 obligation-bearing + 18 `AUD-AC-*` + 5 `AUD-GAP-*`; 0 retired** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by two independent
scripts rather than read** — the `SR-01` failure class this matrix has already suffered once.

⚠ **Contiguity here is judged over a set where declared EQUALS in force, and that is a difference from §2I worth
naming rather than inheriting silently.** `PRD-013` retires 12 identifiers, so five of its registers carry holes and
contiguity must be judged over the **declared** set per §2D.2. `PRD-016` §0.2 states *"No identifier is retired;
none has ever been issued before"* — so no hole exists, one count per register is unambiguous, and no
declared-versus-in-force distinction arises. **That simplicity is itself enforced, not assumed:** both scripts fail
if a retirement section ever appears, because a single published count would then become ambiguous and both
instruments would need revision before the gate could be trusted again.

**Coverage, measured at `PRD-016` v0.1:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers (Class A) | **35** (16 `AUD-FR-*` + 3 `AUD-BR-*` + 4 `AUD-INV-*` + 0 `AUD-EVT-*` + 12 `AUD-XC-*`) |
| Obligations carrying an `AUD-AC-*` | **27** |
| **Coverage** | **27 / 35 = 77.1%** |
| Orphan criteria (verify nothing) | **0** |
| Dangling `AUD-*` citations | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 18** |

⚠ **The last two rows are why the coverage row is safe to print.** The percentage is **not** 100%, and it is
published unrounded rather than framed as *"substantially covered"*. The **8** uncovered obligations are named in
`PRD-016` §9's reverse-coverage paragraph — `AUD-FR-001`…`004`, `AUD-FR-010`, `AUD-FR-011`, `AUD-XC-009` and
`AUD-XC-011` — each a **scope or ownership statement** whose violation is observable as the *presence of a type or a
subscription* rather than as a runtime behaviour, the same treatment §2I records for `TEN-FR-001`…`009`. That is a
stated reason, not an excuse. **0 of 18 criteria pass**, because no implementation exists — `docs/40-implementation/audit/`
is empty and `lib/platform/audit/audit.dart` has **no test file at all**. This matrix has been wrong about a coverage
figure before — `PRD-006` v1.0 published *"100% coverage"* against a true **49.1%** — so the figure is computed
**and** qualified, and `prd016_stage5.py` check 8 fails the run if the number above ever stops matching the PRD.

⚠ **The 77.1% figure was itself the subject of a corrected measurement, and the correction is recorded because it
changes what a future checker must do.** `AUD-AC-017` traces to ``AUD-FR-013`, `AUD-XC-005`…`008`` — an **ellipsis
range**. A token-only scanner sees `005` and `008` but not `006` or `007`, under-counting coverage by **3** and
reporting **11** uncovered where the true figure is **8**. The Stage 4 review's own first script made exactly that
error and recorded the constraint as finding **`S4-D-01`**: *"Any mechanical checker for `AUD-*` must expand
ellipsis ranges."* Both committed scripts expand them. Range notation is established practice in frozen `PRD-007`
(`SEAT-AC-166` maps via `SEAT-EVT-001`…`004`), so expansion is compliance with existing convention, not an
accommodation invented for this module.

### 2J.1 Prefix collisions checked — in three directions

| Direction | Result |
|---|---|
| `AUD-` **defined** outside `docs/30-product/audit/` | **0.** Every `.md` under `docs/` is walked by `prd016_stage5.py` check 4c; `grep -rn "AUD-" lib/ tool/ test/ packages/` returns **0** hits in source as well |
| `AUD-` **cited** outside the module | **0 at present.** Each occurrence would be resolved against the defined set rather than counted as a failure — **a citation is not a collision** (the §2C.1 principle) — so a genuinely new `AUD-*` *definition* in any outside document still fails the run |
| Foreign prefixes **defined** inside `PRD-016` | **0.** Every foreign identifier in the PRD (`AU-1`…`AU-9`, `AUTH-10.*`, `MP-GBR-*`, `MP-NFR-10`, `E-19`…`E-23`, `X-10`, `X-13`, `ID-1`…`ID-6`, `F-1`…`F-4`, `SEAT-FR-232`, `ATT-FR-*`, `TEN-*`, `Q-04`, `BC-18`…`BC-27`) appears **only** as an attributed citation, never in a first table cell or at a line start — the `PRD-008` §C5 test, *"all attributed quotations, 0 unattributed restatements"*. Measured at Stage 4: **32** foreign identifiers across **88** citations, **0** restatements |
| `AUD` vs the **59** prefix stems already registered in this matrix | **No overlap.** No registered stem is `AUD` or an `AUD-` stem, verified by `prd016_stage5.py` check 4a rather than by reading the list |
| ⚠ Substring hazard — a bare `FR-*` register **exists in this matrix** | **Checked, not assumed, and this is the live case.** The matrix registers a bare **`FR-*`** stem (from the Authentication chapter map), so the `PO-n`/`SPO-n` error class Stage 5 names as its reason for existing is **not hypothetical here.** `AUD-FR-001` tokenises as `['AUD-FR']`; a word-boundary search for `(?<![A-Z-])FR-\d+` against `AUD-FR-001` returns **no match**, so `AUD-FR-*` cannot be mistaken for the bare `FR-*` register |
| ⚠⚠ Substring hazard — **`AU-n` names two OTHER registers** | **Checked in both directions.** `AU-1`…`AU-9` are Authentication PRD §10.4's audit **principles** (Rank 3, `FROZEN`) **and, separately, the module manifest's assertions** — where `AU-4` means *"Independence"* in the first and *"erasure by key destruction"* in the second. Both predate `PRD-016`. Measured: a search for `(?<![A-Z])AU-\d` against `AUD-FR-001` returns **no match**, and a search for `AUD-` against `AU-1`/`AU-4`/`AU-9` returns **no match**. `PRD-016` §0.4 additionally forbids citing a bare `AU-n`, requiring *"`AU-4` (Auth §10.4)"* or *"manifest `AU-4`"*; **0** bare citations appear in the PRD or its three review records |
| `AUD-` vs `ATT-`/`TEN-`/`SEAT-`/`FEE-`/`ITG-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

**Collision result: zero, in all three directions.**

### 2J.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| **Confer Stage 6, freeze, or verification** | Stage 5 confers **registration**. `PRD-016` remains **v0.1 `DRAFT`** and **`PLANNED`** in `PRD_REGISTRY.md` §4.2. Freeze can be conferred only by a row in `DOCUMENTATION_BASELINE.md` §3, and no such row exists — *"never claim FROZEN merely by changing a status field"* |
| **Present coverage as verification** | **77.1%** is published because it is computed, non-zero and honest — but the table states **0 of 18 criteria pass**, because none can until an implementation exists, and the **8** uncovered obligations are **named** rather than absorbed into a percentage |
| **Allocate an `IMPL-*` range** | Stage 6. `docs/40-implementation/audit/` exists but is **empty**, and `PRD-016` allocates **0** numbered implementation identifiers. The next free block is `IMPL-900`+ — `IMPL-800`…`829` is `PRD-013`'s and `IMPL-830`…`899` is **reserved for its growth**. Rule 1: *"Never reuse or reassign a number"*, so allocation is not made speculatively here |
| **Issue any `AUD-CFG-*`** | No authority at any rank supplies a default or a bound for audit retention or legal hold. Stage 4 check 3 rates an unbounded configurable *"a specification hole"*; `AUD-GAP-001` records the absence and routes it to **SECURITY + DATA Governance**, with counsel, per `MP-NFR-10` |
| **Name a retention period, jurisdiction or legal rule** | Forbidden by the authoring mandate and owned elsewhere: `MP-NFR-10` assigns retention and legal hold to **SECURITY + DATA Governance**, and `Q-04` is *"Open — needs counsel"*. The restraint `ADR-0041` L214 exercises when it declines to *"name a period, a statute or a jurisdiction rule"* |
| **Close any `AUD-GAP-*`** | All **5** remain **OPEN** after this registration. Stage 5 closes the *registration*, not the gaps |
| **Repair the three code contradictions** | `D-016-01` (`recent()` and `count` on `AuditTrail` expose entries across tenants — `X-13`, `MP-RSK-01`), `D-016-02` (`append()` defaults an absent timestamp to epoch 0, against `AUD-FR-007`) and `D-016-03` are **recorded and measured** in `PRD-016` §11 and §10 of its alignment record. `lib/platform/audit/audit.dart` is **byte-unchanged** by this pass, and `git status --short lib/ packages/ test/` returns **0 lines**. Repair is Stage 8 |
| **Amend `PRD_LIFECYCLE.md`'s `X-13` mis-citation** | Stage 3's check table names `X-13` (a tenant-key rule) as the authority for the *authorisation-location* check, where the substantive authority is BC Map L127 + §7.4. Recorded as `S3-A-02` in the alignment record and **left unrepaired**; amending a governance document is neither a Stage 3 nor a Stage 5 act, and `PRD-013`'s review recorded the identical finding |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-016` is **Rank 3-registered, not Rank 3-holding**, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| **Touch any existing section, `PRD_REGISTRY.md`, or any ADR** | §2 through §2I are **byte-unchanged**, as are all four `PRD-016` documents, `PRD_REGISTRY.md` and all **50** ADRs. This pass appends §2J, three header fields and one change-history row, and adds two new files under `tool/docs_check/` |
| **Modify any existing gate script** | All **14** pre-existing scripts under `tool/docs_check/` are **byte-unchanged**, including `prd013_stage5.py` and `prd013_traceability.py`. The two new files **add** checks and weaken none. The four pre-existing exit-1 checkers (`alignment_record_freshness`, `prd004_traceability`, `prd005_traceability`, `prd007_traceability`) are **not** repaired by this pass and remain failing for their own recorded reasons |

### 2J.3 Why the two checkers can disagree with each other

§2H.2 names the failure mode this pair exists to avoid: *"a checker written in the same pass as the register it
checks, by the same author, verifies agreement with itself."* Two mitigations are applied, and the second goes
beyond what §2I's pair required.

| Script | Subject | Opens the matrix? | Parsing strategy |
|---|---|---|---|
| `prd016_traceability.py` | `PRD-016` against **itself** — §0.2's declarations against the body | **No, never** | Classifies each **line** by an ordered list of line-start patterns |
| `prd016_stage5.py` | §2J against **the PRD body**, recomputed independently | Yes | Walks the document **section by section** and accepts an identifier only where that section is entitled to define it |

`prd016_stage5.py` does not import from `prd016_traceability.py`. **Both arrive at 58 by structurally different
routes** — one by line form, one by section position — which is evidence; agreement by one route repeated twice
would not be. The section-position parser additionally fails if any register is defined in a section that has no
business defining it, a class of defect the line parser cannot see at all.

### 2J.4 Three defects the checkers found **in themselves**, recorded rather than quietly patched

A tool's failure history is evidence about the tool. All three were found by running the `PRD-013` rules against
this document and getting an answer that was **obviously** wrong — and in all three **the PRD was right and the
instrument was wrong.**

| # | Defect | Consequence had it shipped |
|---|---|---|
| **1** | **Bold-wrapped definitions.** `PRD-013` opens a requirement with a bare backticked identifier; `PRD-016` opens it with a **bold** one (`**`AUD-FR-001`** — The module SHALL …`). The inherited rule matched **1 of 16** `AUD-FR-*` and reported five registers absent | A correct document declared catastrophically broken — or, far worse, "fixed" by editing the PRD to suit the tool |
| **2** | **Ellipsis ranges** — finding `S4-D-01`. A token-only trace scanner missed `AUD-XC-006` and `AUD-XC-007` inside ``AUD-XC-005`…`008`` | Coverage under-reported by 3, and a **false gap** published against a document that does not have one |
| **3** | **Sentence-final identifiers.** Fixing defect 1 by accepting any line opening with a bold identifier also accepted §0.3's closing sentence — *"Retention is recorded as **`AUD-GAP-001`**."* — and reported `AUD-GAP-001` defined twice. Two further lines (§9's reverse-coverage paragraph) open with a plain identifier mid-sentence | A phantom duplicate-definition failure. Fixed by encoding the document's **actual** convention: a prose definition is a bold identifier followed by an **em-dash** and normative text. **23** such lines (16 + 3 + 4) plus **35** table first cells = **58**, §0.2's published total |

**No PRD content was changed to make a checker pass.** The rule was changed to match the document — the direction
`PRD-013_STAGE5_CONFERRAL.md` §3.2 records as correct.

---

## 2K. Identifier inventory — Entitlement (`PRD-014`, the `EntitlementSet` aggregate)

Registers the `ENT-*` prefixes so that **88 identifiers in a Rank-3-registered document are not registered
nowhere** — the condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for
`PRD-008`, §2H for `PRD-019`, §2I for `PRD-013` and §2J for `PRD-016`.

⚠ **The pre-commit measurement is stated with its regex, because the bare-`grep -c` form every previous section
used is UNSAFE for this prefix.** `grep -c 'ENT-'` is the command §2G…§2J each published, and repo-wide it returns
non-zero for `ENT-` **as a substring of `MANAGEMENT-`** (11 occurrences) and of `ALIGNMENT-` (1). Inside this file
both the unanchored and the anchored counts happened to agree at **0**, so the loose form would not have misled
anyone here — but it would have been *luck*, not method, and the same command run one directory away reports
phantom hits. The measurement actually taken was therefore anchored:

```
grep -cE '(^|[^A-Z-])ENT-(FR|BR|INV|EVT|XC|CFG|AC|GAP)-[0-9]+' docs/40-implementation/TRACEABILITY_MATRIX.md
→ 0
```

✅ **Stage 5 IS claimed for `PRD-014`**, on the same two discharges §2J recorded, shown rather than asserted:

| # | Reason §2I withheld the stage | Status for `PRD-014` |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`) | **DISCHARGED by conferral**, recorded at [`PRD-014_STAGE5_CONFERRAL.md`](../30-product/entitlement/PRD-014_STAGE5_CONFERRAL.md) in the identical form `PRD-008_STAGE4_CONFERRAL.md`, `PRD-013_STAGE5_CONFERRAL.md` and `PRD-016_STAGE5_CONFERRAL.md` used. ⚠ **`PGA-08` is a standing repository gap and is NOT cured here** — the conferral is per-act, not an owner appointment (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*) |
| **2** | **No committed gate script.** Stage 5 demands counts *"verified **mechanically**"*, and *"a number computed once is not a number verified mechanically on every commit"* | **DISCHARGED by construction.** [`prd014_traceability.py`](../../tool/docs_check/prd014_traceability.py) and [`prd014_stage5.py`](../../tool/docs_check/prd014_stage5.py) are committed under `tool/docs_check/` and re-run on every invocation. Neither imports the other, and they use **different parsing strategies** — see §2K.3 |

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `ENT-FR-*` | Functional requirements — ownership of `EntitlementSet` and its three value objects, derivation from Billing events, the `E-17` synchronous port, event consumption, query confinement | **28** | `001`–`028` | `PRD-014` §2–§4, §7–§8 |
| `ENT-BR-*` | Business rules — entitlement written only by `billing.EntitlementChanged`; recomputability; tenant context fails loudly; grace period configured never implicit | **8** | `001`–`008` | `PRD-014` §5 |
| `ENT-INV-*` | Invariants — rebuild-from-events yields identical output; no cross-tenant reachability; derived state never hand-edited | **6** | `001`–`006` | `PRD-014` §6 |
| `ENT-EVT-*` | Domain events — **DECLARED EMPTY, and registered as empty rather than omitted.** `BC-21` publishes **no** domain event: it appears in exactly three rows of BC Map §9 — **L435**, **L436**, **L437** — and in *every one* it sits in the **consumer** column; producer rows for `BC-21`: **0**. A register of published events would have to invent its first entry. `ENT-FR-024` states the prohibition positively so the emptiness is **enforceable rather than incidental** | **0** | *none issued* | `PRD-014` §0.3, §7 |
| `ENT-XC-*` | Exclusions — what **MUST be impossible**: pricing, proration, payment capture, authorisation decisions, feature-flag evaluation, seat allocation, deciding another context's gated list, publishing events | **12** | `001`–`012` | `PRD-014` §9 |
| `ENT-CFG-*` | Configurables — **DECLARED EMPTY, and no identifier issued at all.** BC Map **L326** (`E-17`) says the per-feature fail disposition is *"decided per feature, **recorded in Config**"* — **the register it points at does not exist.** Rank 7 `CONFIGURATION_GUIDE.md` (585 lines) searched for `entitlement\|BC-21\|quota\|feature.?gate\|usage.?count` returns **7 hits, every one an OTP/SMS value** (`CFG-1`…`CFG-4`, `INV-4`). Populating it would mean choosing a default and a range for a value `Q-03` has **not decided** — Open at Rank 4 (BC Map L542) and Rank 1 (`MASTER_PRD.md` L675). Stage 4 check 3 rates an unbounded configurable *"a specification hole"*; recorded as `ENT-GAP-001`/`ENT-GAP-002` instead | **0** | *none issued* | `PRD-014` §0.3, §11 |
| **`ENT-AC-*`** | **Acceptance criteria** | **26** | `001`–`026` | **`PRD-014` §10** |
| `ENT-GAP-*` | Open gaps — absent decisions owned elsewhere (fail-open/closed disposition, the missing Config register, proration ownership, `PRD-022`'s silence, `H-1`, the shared-module split, roadmap absence) | **8** | `001`–`008` | `PRD-014` §12 |
| **Total** | | **88** | | **54 obligation-bearing + 26 `ENT-AC-*` + 8 `ENT-GAP-*`; 0 retired** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by two independent
scripts rather than read** — the `SR-01` failure class this matrix has already suffered once.

**Contiguity here is judged over a set where declared EQUALS in force**, as for `PRD-016` and unlike `PRD-013`:
`PRD-014` §0.2 states *"No identifier is retired; none has ever been issued before"*, so no register carries a
hole, one count per register is unambiguous, and no declared-versus-in-force distinction arises. Both scripts
fail if a retirement section ever appears, because a single published count would then become ambiguous.

**Coverage, measured at `PRD-014` v0.1:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers (Class A) | **54** (28 `ENT-FR-*` + 8 `ENT-BR-*` + 6 `ENT-INV-*` + 0 `ENT-EVT-*` + 12 `ENT-XC-*`) |
| Obligations carrying an `ENT-AC-*` | **51** |
| **Coverage** | **51 / 54 = 94.4%** |
| Orphan criteria (verify nothing) | **0** |
| Dangling `ENT-*` citations | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 26** |

⚠ **The last two rows are why the coverage row is safe to print.** The percentage is **not** 100%, it is published
unrounded, and the **3** uncovered obligations are **named** — `ENT-FR-017`, `ENT-FR-018` and `ENT-FR-026` — each
with a stated reason in `PRD-014` §10.1 rather than absorbed into a percentage: `ENT-FR-017` because proving *no
caller needs a duplicate limit* would test `BC-04`'s and `BC-02`'s code, which this PRD does not govern;
`ENT-FR-018` because the configured per-feature disposition **does not exist** (`ENT-GAP-002`) and a criterion
would have to name a value this document may not invent; `ENT-FR-026` because it depends on whether a `BC-21`→`BC-24`
edge is lawful, which is `H-1` (`ENT-GAP-005`). **0 of 26 criteria pass**, because no implementation exists —
`docs/40-implementation/entitlement/` does not exist and `lib/platform/business/business.dart` has **no test file
at all** (`D-014-05`). This matrix has been wrong about a coverage figure before — `PRD-006` v1.0 published
*"100% coverage"* against a true **49.1%** — so the figure is computed **and** qualified, and `prd014_stage5.py`
check 8 fails the run if the number above ever stops matching the PRD.

⚠ **The reverse-coverage figure was recomputed from §0.2's DECLARED RANGES, not from what the document cites**, so
an obligation omitted from **both** §10 and §10.1 would still have been counted as uncovered. It agreed with §10.1
exactly, including the three named identifiers. Agreement between a table and a recomputation that reads the same
table would have been worthless.

### 2K.1 Prefix collisions checked — in three directions

| Direction | Result |
|---|---|
| `ENT-` **defined** outside `docs/30-product/entitlement/` and `docs/40-implementation/entitlement/` | **0.** Every `.md` under `docs/` is walked by `prd014_stage5.py` check 4c. An anchored scan of `docs/ tool/ lib/ packages/ test/` returns `ENT-*` register tokens in **exactly six files** — the four `PRD-014` documents and the two new checkers — and **nowhere else** |
| `ENT-` **cited** outside the module | **0 at present.** Each occurrence would be resolved against the defined set rather than counted as a failure — **a citation is not a collision** (the §2C.1 principle) — so a genuinely new `ENT-*` *definition* in any outside document still fails the run |
| Foreign prefixes **defined** inside `PRD-014` | **0.** Every foreign identifier (`BC-18`…`BC-27`, `E-17`, `F-1`…`F-4`, `X-11`, `X-13`, `MP-GBR-*`, `BZ-1`/`BZ-2`, `Q-03`, `Q-06`, `H-1`, `MM-BR-013`, `SEAT-FR-296`, `TEN-*`, `AUD-*`, `ADR-*`) appears **only** as an attributed citation, never in a first table cell or at a line start. Measured at Stage 4: **2** foreign identifiers inside the 42 requirement texts, **both attributed with document, line and status**, **0** unattributed restatements |
| `ENT` vs the **68** prefix stems already registered in this matrix | **No overlap.** No registered stem is `ENT` or an `ENT-` stem, verified by `prd014_stage5.py` check 4a rather than by reading the list |
| ⚠⚠ Substring hazard — **`INV-n` names three OTHER registers, and this is the live case** | **Checked in both directions.** §2A.1 of this matrix records that `INV-n` is a **platform invariant** (`INV-1`…`INV-16`, `CONFIGURATION_GUIDE.md` §3), separately from `INV-SEC-n` (invitation security) and `INV-XC-n` (invitation exclusion) — **three meanings before `ENT-INV-*` was minted**, and bare `INV-n` occurs **23 times in this file**. So the `PO-n`/`SPO-n` error class Stage 5 names as its reason for existing is **not hypothetical here.** Measured: `re.search(r'(?<![A-Z-])INV-\d+', 'ENT-INV-001')` returns **no match**, and a search for `ENT-` against `INV-1`/`INV-4`/`INV-16` returns **no match**. ⚠ Sharpened by the fact that `PRD-014` §0.3 **legitimately cites `INV-4`** when it reports the `CONFIGURATION_GUIDE` scan — so both registers coexist in one document and must stay distinguishable |
| ⚠ Substring hazard — the **reverse** direction, `ENT-` inside a longer word | **This is the direction unique to this prefix and it is LIVE.** Unlike `AUD-`, `TEN-`, `FEE-` or `ITG-`, the token `ENT-` occurs as a **substring of ordinary governance vocabulary**: `MANAGEMENT-` (11 occurrences repo-wide, e.g. `PRD-MEMBERSHIP-MANAGEMENT.md`) and `ALIGNMENT-` (1). Measured: `re.search(r'ENT-', 'MANAGEMENT-MEMBERSHIP')` → **MATCH**; `re.search(r'ENT-', 'PRD-014_ALIGNMENT-RECORD')` → **MATCH**. Both are **false positives that an unanchored scan reports as `ENT-` identifiers.** The anchored form `(?<![A-Z])ENT-\w+-\d+` against `MANAGEMENT-FR-001` returns **no match**. Every scan in both checkers and in this section is anchored for that reason |
| `ENT-` vs `AUD-`/`TEN-`/`SEAT-`/`FEE-`/`ITG-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

**Collision result: zero, in all three directions.**

⚠ **A defect in §2J's own prose, found while checking that section's hazard claim against this file, is recorded
here rather than silently not inherited — and §2J is NOT edited.** §2J.1 states *"a bare `FR-*` register **exists in
this matrix** (from the Authentication chapter map)"* and calls it *"the live case"*. Measured: the **only**
occurrences of a bare `FR-` token anywhere in this file are §2I's and §2J's own hazard prose plus the v1.14
changelog entry — the `## 3. Chapter map` columns are headed `AUTH`, `BR`, `XC`, `AC`, and there is **no `FR`
column**. Bare `FR-\d+` genuinely exists elsewhere in `docs/` (`README.md` L111–112, `ADR-INDEX.md` L75,
`ADR-0018` L45), so the hazard **class** is real and §2J's *conclusion* — that `AUD-FR-001` is unreachable by a
bare `FR-n` search — is **correct**; only its stated *location* is wrong. The identical test was run here for
`ENT-FR-001` and returns **no match**. This is disclosed because a future author copying §2J's sentence would
inherit a false premise about this document's contents, and because *"a stale review is corrected by a dated
re-run beside it, not by editing what it concluded"* (`PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md` L8,
admitted by `DOCUMENTATION_BASELINE.md` §3.3). Registered as **`S5-F-01`**, Low, owner traceability owner,
disposition **DISCLOSED not repaired** — amending §2J is a change to a baselined section and not a Stage 5 act.

### 2K.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| **Confer Stage 6, freeze, or verification** | Stage 5 confers **registration**. `PRD-014` remains **v0.1 `DRAFT`** and **`PLANNED`** in `PRD_REGISTRY.md` L304. Freeze can be conferred only by a row in `DOCUMENTATION_BASELINE.md` §3, and no such row exists — *"never claim FROZEN merely by changing a status field"* |
| **Present coverage as verification** | **94.4%** is published because it is computed, non-zero and honest — but the table states **0 of 26 criteria pass**, because none can until an implementation exists, and the **3** uncovered obligations are **named** rather than absorbed into a percentage |
| **Allocate an `IMPL-*` range** | Stage 6. `docs/40-implementation/entitlement/` **does not exist** and `PRD-014` allocates **0** numbered implementation identifiers. The next free block is **`IMPL-1000`+**, established **by measurement** — 489 distinct `IMPL-\d+` identifiers exist repo-wide, the tail being `…927, 928, 929, 930, 999, 1000`, and all **5** occurrences of `IMPL-1000` are **boundary labels** (`\| IMPL-1000 + \| Unallocated \| — \|`) rather than assignments. ⚠ It is **not** taken from `PRD_LIFECYCLE.md` L147–153, whose `IMPL-014`…`IMPL-227+` table is **stale** — `IMPL-227` is in fact held by Student Identity growth. Rule 1: *"Never reuse or reassign a number"*, so allocation is not speculative here |
| **Issue any `ENT-CFG-*`** | No authority at any rank supplies a default or a bound for a fail disposition, a grace period or a usage window. `ENT-BR-008` is the sharpest case: it governs the grace period and states only *"a **configured** value, never an implicit one"*. ⚠ Verified that the emptiness is **real and not merely described**: `grep -cE '\bENT-CFG-[0-9]+'` returns **0**, and a complementary numeric-literal scan across all **42** requirement texts finds **0** hardcoded durations, counts or percentages — so no tunable is smuggled in under another register. Deliberately **unlike `TEN-CFG-001`**, which was issued then retired, **no `ENT-CFG-*` number is burned at all** |
| **Decide `Q-03` or `Q-06`** | `Q-03` (fail-open vs fail-closed per feature) and `Q-06` (proration ownership) are **Open** at Rank 4 (BC Map L542, L545) and Rank 1 (`MASTER_PRD.md` L675, L678). Both are recorded as gaps and neither is answered. BC Map §13's column is headed *"Recommendation"* and its preamble says each *"should become an ADR"* — so closing one here would be inventing an architecture decision |
| **Close any `ENT-GAP-*`** | All **8** remain **OPEN** after this registration. Stage 5 closes the *registration*, not the gaps |
| **Add the `E-17` edge, or any edge** | `PRD-014` §7.1 records *"Edges added by this PRD: **zero**"*. `E-17` already exists at BC Map **L326**; the PRD cites it and does not create it. BC Map §7's preamble is explicit: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR"* |
| **Repair the six code contradictions** | `D-014-01`…`D-014-06` are **recorded and measured** in `PRD-014` §13 — including `check(Feature f, {int delta = 1})` carrying **no `tenantId`** against `E-17`'s stated signature, a silent `_tier` default to `TenantTier.starter` against `MP-GBR-07`'s *"fails loudly, never defaults"*, hardcoded `_limits`/`_gates` against `ENT-INV-001`, the `seed.dart:95–96` direct write against `X-11`/`BZ-1`, and `D-014-05`, the **complete absence of any test file**. `lib/`, `packages/` and `test/` are **byte-unchanged** by this pass. Repair is Stage 8 |
| **Resolve the shared-module question** | `BC-21` shares module `platform/business` with `BC-20` Billing, and `ADR-0035` L123 says that module holds *"**Exactly two**"* contexts. Whether the two need a physical split is `ENT-GAP-006`, **open and owned by the Architecture Owner**. No split is asserted or designed here |
| **Repair the Stage 3 record's missing hash row** | `PRD-014_ARCHITECTURE_ALIGNMENT.md` carries **no "PRD hash at review" row**, while `alignment_record_freshness.py` requires *"at least one 64-hex candidate"* per record or fails with *"anchor missing"*. Recorded at Stage 4 as **`S4-F-03`**, Medium, owner **architecture reviewer**, and **left unrepaired** — whether a dated supplement is owed is that role's decision, and editing a review record in place is the precise act the freshness gate exists to prevent |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-014` is **Rank 3-registered, not Rank 3-holding**, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| **Touch any existing section, `PRD_REGISTRY.md`, or any ADR** | §2 through §2J are **byte-unchanged** — including §2J.1, whose defect `S5-F-01` is *disclosed above rather than edited* — as are all four `PRD-014` documents (`PRD-014_ENTITLEMENT.md` at `d4ca7e11…c175`, re-verified before and after this pass), `PRD_REGISTRY.md` and all **51** ADRs. This pass appends §2K, three header fields and one change-history row |
| **Modify any existing gate script** | All **16** pre-existing scripts under `tool/docs_check/` are **byte-unchanged**, including `prd016_stage5.py` and `prd016_traceability.py`. The two new files **add** checks and weaken none. The four pre-existing exit-1 checkers (`alignment_record_freshness`, `prd004_traceability`, `prd005_traceability`, `prd007_traceability`) are **not** repaired by this pass and remain failing for their own recorded reasons |

### 2K.3 Why the two checkers can disagree with each other

§2H.2 names the failure mode this pair exists to avoid: *"a checker written in the same pass as the register it
checks, by the same author, verifies agreement with itself."* Both §2J mitigations are applied.

| Script | Subject | Opens the matrix? | Parsing strategy |
|---|---|---|---|
| `prd014_traceability.py` | `PRD-014` against **itself** — §0.2's declarations against the body | **No, never** | Classifies each **line** by an ordered list of line-start patterns |
| `prd014_stage5.py` | §2K against **the PRD body**, recomputed independently | Yes | Splits at **both `## ` and `### `** and accepts an identifier only where that scope is entitled to define it |

`prd014_stage5.py` does not import from `prd014_traceability.py`. **Both arrive at 88 by structurally different
routes** — one by line form, one by scope position — which is evidence; agreement by one route repeated twice would
not be. The scope-position parser additionally fails if the authorisation table no longer describes the document,
and it resolves **`ENT-` definitions outside the module** (0) separately from **`ENT-` citations outside the module**
(0), a distinction the line parser cannot make at all.

⚠ **`prd014_stage5.py` was run BEFORE §2K existed, and its failure is part of the evidence.** It exited **1** with
*"TRACEABILITY_MATRIX.md has no section 2K — the Stage 5 gate is not satisfied. The gate is the registration, not
the intention to register"* — while simultaneously recomputing **88** identifiers across **8** registers from the
PRD body. A gate that cannot fail is not a gate, and this one demonstrably fails on the exact condition it exists
to detect.

### 2K.4 Two defects the checkers found **in themselves**, recorded rather than quietly patched

A tool's failure history is evidence about the tool. In both cases **the PRD was right and the instrument was
wrong**, and in both the rule was changed rather than the document.

| # | Defect | Consequence had it shipped |
|---|---|---|
| **1** | **The inherited §0.2 parser read nothing.** `PRD-016` §0.2 puts the **range span** in cell 0 (`` \| `AUD-FR-001` … `AUD-FR-016` \| contiguous \| **16** \| ``); `PRD-014` puts the **bare prefix** in cell 0 with the range in cell 3. Running `prd016_traceability.py`'s `declared_counts()` unchanged yields **zero** declared registers — every one of the eight reported as *"defined in the body but NOT declared in §0.2"* | **A catastrophic false FAIL**: a correct document declared wholly unregistered. This is the §2J.4 defect-1 class recurring **one structural layer up** — an instrument inherited across documents encodes the previous document's *layout*, not the *rule*. Fixed by accepting **three** §0.2 shapes and **failing loudly** on a fourth, plus an `if not published: fail(...)` guard so a parser that reads nothing can never report a clean run. Recorded as **`S5-C-01`** |
| **2** | **A coverage table's rows read as definitions.** `PRD-014` §10.1 names its three uncovered obligations in a **table** whose rows open `` \| `ENT-FR-017` \| ``, indistinguishable from a table-cell definition. First run: **EXIT=1**, `ENT-FR-017` *"defined at 2 sites (lines 298, 553)"*, and likewise `ENT-FR-018` and `ENT-FR-026` | **A phantom duplicate-definition failure on a correct document.** `PRD-016` never hit this because it names uncovered obligations in **prose**. Fixed **positionally** — `NON_DEFINING_SECTIONS = ['### 10.1 Coverage']` is masked while **preserving original line numbers**, with a guard that fails if that section is ever renamed, so the fix cannot rot into a blanket exemption. Re-run: **EXIT=0**. Recorded as **`S5-C-02`** |

**No PRD content was changed to make a checker pass.** The rule was changed to match the document — the direction
`PRD-013_STAGE5_CONFERRAL.md` §3.2 records as correct, and the same direction §2J.4 took.

⚠ **Two further instrument defects, found at Stage 4 rather than Stage 5, are cross-referenced rather than
re-litigated here**: `S4-C-01`, a modality regex testing only `SHALL`/`MUST` that reported **10 false failures**
and would have produced a **false FAIL of Stage 4 check 1**; and `S4-C-02`, a citation regex requiring a trailing
parenthetical that falsely flagged `ENT-FR-001` and `ENT-FR-019`, both of which cite **inline**. Both are recorded
in §10 of [`PRD-014_STAGE4_REQUIREMENTS_REVIEW.md`](../30-product/entitlement/PRD-014_STAGE4_REQUIREMENTS_REVIEW.md).
**Four instrument defects across two stages, all disclosed, none hidden.**

---

## 2L. Identifier inventory — Settings & Configuration (`PRD-023`, the `BC-25` resolution machinery)

Registers the `CNF-*` prefixes so that **180 identifiers in a Rank-3-registered document are not registered
nowhere** — the condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for
`PRD-008`, §2H for `PRD-019`, §2I for `PRD-013`, §2J for `PRD-016` and §2K for `PRD-014`.

**The pre-commit measurement, stated with its regex** because §2K established that a bare `grep -c` is unsafe for
any prefix that can occur as a substring:

```
grep -cE '(^|[^A-Z-])CNF-(FR|BR|INV|EVT|XC|CFG|AC|GAP)-[0-9]+' docs/40-implementation/TRACEABILITY_MATRIX.md
→ 0
```

⚠ **The reverse hazard §2K carried is ABSENT here, and saying so is more useful than manufacturing a decoy.**
`ENT-` is a live substring of `MANAGEMENT-` and `ALIGNMENT-`; `CNF-` is the tail of no word in this repository. A
corrected scan for an alphanumeric immediately preceding `CNF-` returns **exactly 3 hits, all of them the `b` of
the regex escape `\bCNF-`** inside quoted grep commands — prose *about* a pattern, not a word embedding the prefix.
The first form of that scan reported `645` hits and was **wrong**: it read the first character of its own match
rather than the character before it. That instrument defect is recorded as **`S5-C-02`** in the conferral record
rather than quietly corrected, because a scan that over-reports by 645 would have justified a decoy test that
proved nothing.

✅ **Stage 5 IS claimed for `PRD-023`**, on the same two discharges §2J and §2K recorded, shown rather than asserted:

| # | Reason §2I withheld the stage | Status for `PRD-023` |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`) | **DISCHARGED by conferral**, recorded at [`PRD-023_STAGE5_CONFERRAL.md`](../30-product/configuration/PRD-023_STAGE5_CONFERRAL.md) in the identical form §2J and §2K used. ⚠ **`PGA-08` is a standing repository gap and is NOT cured here** — the conferral is per-act, not an owner appointment (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*) |
| **2** | **No committed gate script.** Stage 5 demands counts *"verified **mechanically**"*, and *"a number computed once is not a number verified mechanically on every commit"* | **DISCHARGED by construction.** [`prd023_traceability.py`](../../tool/docs_check/prd023_traceability.py) and [`prd023_stage5.py`](../../tool/docs_check/prd023_stage5.py) are committed under `tool/docs_check/` and re-run on every invocation. Neither imports the other, and they use **different parsing strategies** — see §2L.3 |

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `CNF-FR-*` | Functional requirements — the settings/configuration distinction, the five-level hierarchy and its resolution, validation, environment profiles, the `E-19` typed-accessor contract, `INV-1`…`INV-16` enforcement, feature flags, branding values, secret references, change audit, write authority, tenant isolation, observability, UI | **82** | `001`–`082` | `PRD-023` §2–§12 |
| `CNF-BR-*` | Business rules — flag/entitlement separation, audit obligations, write authority, observability | **11** | `001`–`011` | `PRD-023` §6, §8, §9, §11 |
| `CNF-INV-*` | Invariants — resolution determinism, invariant-shortfall detectability, tenant non-reachability, tenant scope explicitness | **4** | `001`–`004` | `PRD-023` §5, §10 |
| `CNF-EVT-*` | Domain events — **DECLARED EMPTY, and registered as empty rather than omitted.** `BC-25` publishes **no** domain event. BC Map §9 enumerates **14 producing contexts** and `BC-25` is not among them; a grep of §9 for `configuration\|config\|settings\|flag` returns **0**. `BC-25`'s only appearance in BC Map §7 is **`E-19`**, a **synchronous port**, not an event edge, and L292 rules that an edge not in the table does not exist. **`CNF-FR-051`** states the prohibition positively so the emptiness is **enforceable rather than incidental**, and **`CNF-FR-052`** routes the audit obligation through `E-20`, which already exists. **The fourth consecutive platform PRD to declare an event register empty for a measured reason** | **0** | *none issued* | `PRD-023` §0.2, §0.3 |
| `CNF-XC-*` | Exclusions — what **MUST be impossible**: restating the 104 configurable values, `LCFG-*` definitions, `INV-*` statements, entitlement gates and quotas, authorisation decisions, the `LibraryBranding` aggregate, image bytes, secret material, audit persistence, tenant lifecycle, branch policy, role definitions, design tokens | **16** | `001`–`016` | `PRD-023` §3.6, §5, §6.2, §7, §8, §9.2, §10.2, §11.2, §12.2 |
| `CNF-CFG-*` | Configurables — **DECLARED EMPTY, and no identifier issued at all.** ⚠ **This is the most consequential empty register in the repository, because the module that owns configuration owns no configurable.** `ADR-0017` §3.1 item 6: *"`PRD-023` owns the resolution machinery, **not the value list**."* All **104** configurables measured in this repository belong to one of **eight other PRDs, every one FROZEN** — `CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `MM-CFG-001`…`009`, `SEAT-CFG-001`…`018`, `ATT-CFG-001`…`024`. Publishing a `CNF-CFG-*` would require inventing a default and a range for a parameter no document at any rank bounds — the Stage 4 failure *"unbounded configuration is a specification hole"*, and `ADR-0017` §5.3's pre-registered risk *"`PRD-023` grows to absorb entitlement or security scope"* in its most seductive form. Four tempting candidates were named and refused in §0.3. **Verified empty in fact, not merely in description**: `grep -cE '\bCNF-CFG-[0-9]+'` → **0** | **0** | *none issued* | `PRD-023` §0.2, §0.3 |
| **`CNF-AC-*`** | **Acceptance criteria** | **59** | `001`–`059` | **`PRD-023` §13** |
| `CNF-GAP-*` | Open gaps — the contested `LibrarySettings` aggregate, the orphan `settings` port, the empty branch/user scopes, the shared-kernel port question, the `INV-1`…`INV-9`/`INV-16` shortfall, the EA V1/V2 conflict, the missing module block, the missing `tenant_isolation_test.dart` | **8** | `001`–`008` | `PRD-023` §14 |
| **Total** | | **180** | | **113 obligation-bearing + 59 `CNF-AC-*` + 8 `CNF-GAP-*`; 0 retired** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by two independent
scripts rather than read** — the `SR-01` failure class this matrix has already suffered once.

**Contiguity here is judged over a set where declared EQUALS in force**, as for `PRD-016` and `PRD-014` and unlike
`PRD-013`: `PRD-023` §0.2 states *"None is retired; none has ever been issued before"*, so no register carries a
hole and one count per register is unambiguous. Both scripts fail if a retirement section ever appears.

⚠ **The published counts are not the counts §0.2 was first written with, and the document says so.** The registers
were declared *before* the body was drafted, as L82 rule 2 requires; the first declaration read `CNF-FR-` **67**,
`CNF-BR-` **12**, `CNF-INV-` **8**, `CNF-AC-` **45**. Drafting moved four of them — functional requirements rose to
**82** and criteria to **59**, while business rules and invariants **fell** to **11** and **4** because obligations
first imagined as separate rules resolved into requirements with criteria attached. Rule 3 requires ranges
*contiguous*, not *predicted*, so the ranges were **closed to the delivered counts rather than padded to the
estimates**. A range that ran ahead of its register would make the published range false, which is the defect
rule 3 exists to prevent.

**Coverage, measured at `PRD-023` v0.1:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers (Class A) | **113** (82 `CNF-FR-*` + 11 `CNF-BR-*` + 4 `CNF-INV-*` + 0 `CNF-EVT-*` + 16 `CNF-XC-*`) |
| Obligations carrying a `CNF-AC-*` | **76** |
| **Coverage** | **76 / 113 = 67.3%** |
| Orphan criteria (verify nothing) | **0** |
| Dangling `CNF-*` citations | **0** |
| Undisclosed uncovered obligations | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 59** |

⚠ **67.3% is the lowest coverage figure this matrix has ever published, and it is published unrounded because the
uncovered set is fully named and classified.** All **37** uncovered obligations appear in §13's *Coverage*
paragraph, and Stage 4 classified every one as definitional (21 `CNF-FR-*` that fix vocabulary or state a
structural fact), rule-restating (3 `CNF-BR-*`), or **exclusionary — all 16 `CNF-XC-*`**. An exclusion states what
must be *impossible*; a criterion asserting that something never happens is unfalsifiable by observation, which is
why `PRD-013` §7 established that naming the uncovered set is the correct discipline rather than manufacturing
criteria to raise a percentage. **This matrix has been wrong about a coverage figure before** — `PRD-006` v1.0
published *"100% coverage"* against a true **49.1%** — so the figure is computed **and** qualified, and
`prd023_stage5.py` check 8 fails the run if it ever stops matching the PRD.

⚠ **The reverse figure was recomputed independently and DISAGREED with the document in one direction.** The
Coverage paragraph names **40** identifiers; only **37** are in fact uncovered. `CNF-XC-005`, `CNF-XC-008` and
`CNF-XC-014` are named as uncovered but *are* cited by `CNF-AC-038`, `CNF-AC-041` and `CNF-AC-048`. The document
**over-declares its own uncovered set by three** — it understates its verification coverage, which is the safe
direction to be wrong in, and is the exact opposite of the failure Stage 4 guards (an untested obligation presented
as tested). Recorded as `S4-D-01`, **Low**, and **deliberately not repaired**: editing the PRD would change its
`sha256` and invalidate the Stage 3 and Stage 4 records that measured it at the current hash.

### 2L.1 Prefix collisions checked — in three directions

| Direction | Result |
|---|---|
| `CNF-` **defined** outside `docs/30-product/configuration/` and `docs/40-implementation/configuration/` | **0.** Every `.md` under `docs/` is walked by `prd023_stage5.py` check 4c. An anchored scan of `docs/ tool/ lib/ test/` returns `CNF-*` register tokens in **exactly five files** — the four `PRD-023` documents and this matrix's §2L — and **nowhere else** |
| `CNF-` **cited** outside the module | **0 at present.** Each occurrence would be resolved against the defined set rather than counted as a failure — **a citation is not a collision** (the §2C.1 principle) — so a genuinely new `CNF-*` *definition* in any outside document still fails the run |
| Foreign prefixes **defined** inside `PRD-023` | **0.** All **39** foreign identifiers (`ADR-0017`, `BC-18`…`BC-31`, `E-17`…`E-20`, `X-13`, `ID-1`, `MP-GBR-06`…`09`, `MP-NFR-06`/`08`, `INV-1`…`INV-16`, `LCFG-*`, `CFG-*`, `SCFG-*`, `SMCFG-*`, `MM-CFG-*`, `SEAT-CFG-*`, `ATT-CFG-*`, `ICFG-*`, `TR-1`…`TR-5`, `LIB-*`, `SID-4.56`, `TEN-*`, `AUD-*`, `ENT-BR-004`) appear **only** as attributed citations, never in a first table cell or at a line start. Measured at Stage 4: **0** unattributed restatements across 113 requirement texts |
| `CNF` vs the **78** prefix stems already registered in this matrix | **No overlap**, and no bare `CNF` stem, verified by `prd023_stage5.py` check 4a against the parsed stem set rather than by reading the list |
| ⚠⚠ Substring hazard — **`CFG-1`…`CFG-12` is an OCCUPIED register, and this is the sharpest case any module here has carried** | **Checked in both directions.** Every predecessor's inward hazard was a register that *might* be confused. This one is a **live register with real members**, owned by `PRD-001` (**FROZEN v2.0**), and the colliding sub-register `CNF-CFG-*` is **empty** — so a naive scan for `CFG-\d+` that swept up `CNF-CFG-*` would be counting members of a register that has none. Measured: `re.search(r'(?<![A-Z-])CFG-\d+', 'CNF-CFG-001')` → **no match**. ⚠ Sharpened by the fact that `PRD-023` **legitimately cites `CFG-1`…`CFG-12`** when reporting the 104-configurable census, so both registers coexist in one document |
| ⚠⚠ Substring hazard — **`INV-1`…`INV-16` are this module's SUBJECT MATTER** | **Checked in both directions.** §2A.1 records `INV-n` as a **platform invariant** (`CONFIGURATION_GUIDE.md` §3), separately from `INV-SEC-n` and `INV-XC-n` — **three meanings before `CNF-INV-*` was minted**, with bare `INV-n` occurring **23 times in this file**. Unlike every predecessor, `PRD-023` §5 is *about* `INV-1`…`INV-16`: it cites them heavily **in the same section** that defines `CNF-INV-001`…`CNF-INV-004`. This is the `PO-n`/`SPO-n` class the lifecycle names as Stage 5's reason for existing, at its highest density anywhere in the repository. Measured: `re.search(r'(?<![A-Z-])INV-\d+', 'CNF-INV-001')` → **no match**; a search for `CNF-` against `INV-1`/`INV-4`/`INV-16` → **no match** |
| ⚠ Substring hazard — the **reverse** direction, `CNF-` inside a longer word | **ABSENT, measured rather than assumed.** See the preamble: 3 apparent hits, all the `b` of `\bCNF-`. The anchored form is still asserted to match `CNF-FR-001` (or every register would silently under-count) and asserted **not** to match inside `XCNF-FR-001` |
| `CNF-` vs `ENT-`/`AUD-`/`TEN-`/`SEAT-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

**Collision result: zero, in all three directions.**

### 2L.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| **Confer Stage 6, freeze, or verification** | Stage 5 confers **registration**. `PRD-023` remains **v0.1 `DRAFT`** and **`PLANNED`** in `PRD_REGISTRY.md` L327. Freeze can be conferred only by a row in `DOCUMENTATION_BASELINE.md` §3 — *"never claim FROZEN merely by changing a status field"* |
| **Issue any `CNF-CFG-*` or `CNF-EVT-*` member** | The Stage 5 mandate is explicit that numbered members may not be created *"unless Stage 5 finds authoritative evidence requiring them."* **It found none, and looked**: BC Map §9 producer rows for `BC-25` = **0**; the 104-configurable census assigns every value to one of eight other FROZEN PRDs. Both emptinesses are now enforced as **tests** — `prd023_stage5.py` check 7 fails if a member of either register ever appears |
| **Allocate an `IMPL-*` range** | Stage 6. `docs/40-implementation/configuration/` **does not exist**. The next free block is **`IMPL-1100`+**, established by measurement — `IMPL-1030`–`1099` is `PRD-014`'s declared growth reserve (`PRD-014_IMPLEMENTATION_TASKS.md` L123, ratified `ADR-0052`), and L124 reads `IMPL-1100 + | Unallocated`. ⚠ **Not** taken from `PRD_LIFECYCLE.md` L147–153, whose table is **stale**. Rule 1: *"Never reuse or reassign a number"* |
| **Resolve `CNF-GAP-001`** | The `LibrarySettings` aggregate conflict — `Library_PRD_v1.md` L188 assigns it to `BC-25`; BC Map §8's 17-row table has **no `BC-25` row**. Stage 3 disposed of it as **raised, not resolved**, owner Architecture Owner, and an ADR is required. §4 of the baseline: *"A conflict is a defect… do not choose — raise it"* |
| **Close any `CNF-GAP-*`** | All **8** remain **OPEN** after this registration. Stage 5 closes the *registration*, not the gaps |
| **Add any edge** | `PRD-023` creates **zero** edges. `E-19` already exists at BC Map **L328** and `E-20` at **L329**; both are cited, not created. §7's preamble: *"If an edge is not in this table, it **does not exist** and adding it requires an ADR"* |
| **Repair `S4-D-01`** (the 3 over-declared exclusions) | Editing the PRD changes its `sha256` and invalidates the Stage 3 and Stage 4 measurements taken at hash `e974960…` — the precise drift `alignment_record_freshness.py` exists to catch. *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded"* |
| **Repair the orphan-port finding** | `platform/configuration:settings` has **7 consumers and 0 providers** — but Stage 3 measured that **8 of 20 ranked modules have no manifest block at all**, `platform/services` carrying **14** inbound references. It is a **manifest-wide convention**, not a `BC-25` defect, and is Stage 6 work (`CNF-GAP-002`, `CNF-GAP-007`) |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-023` is Rank 3-**registered**, not Rank 3-**holding**, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| **Touch any existing section, `PRD_REGISTRY.md`, or any ADR** | §2 through §2K are **byte-unchanged**, as are all four `PRD-023` documents (the PRD at `e974960…`, re-verified before and after), `PRD_REGISTRY.md` and all **53** ADRs. This pass appends §2L, three header fields and one change-history row |
| **Modify any existing gate script** | All **21** pre-existing scripts under `tool/docs_check/` are **byte-unchanged**. The two new files **add** checks and weaken none. The **5** pre-existing exit-1 checkers are **not** repaired and remain failing for their own recorded reasons |

### 2L.3 Why the two checkers can disagree with each other

§2H.2 names the failure mode this pair exists to avoid: *"a checker written in the same pass as the register it
checks, by the same author, verifies agreement with itself."* Both mitigations are applied.

| Script | Subject | Opens the matrix? | Parsing strategy |
|---|---|---|---|
| `prd023_traceability.py` | `PRD-023` against **itself** — §0.2's declarations against the body | **No, never** | Classifies each **line** by ordered line-start patterns |
| `prd023_stage5.py` | §2L against **the PRD body**, recomputed independently | Yes | Splits at **both `## ` and `### `** and accepts an identifier only where that scope is entitled to define it |

`prd023_stage5.py` does not import from `prd023_traceability.py`. **Both arrive at 180 by structurally different
routes** — one by line form, one by scope position — which is evidence; agreement by one route repeated twice would
not be. The scope parser carries a **37-entry authorisation table**, by far the largest in this repository, because
`PRD-023` defines `CNF-FR-*` across **21 distinct scopes** where `PRD-014` used six; it fails if any listed scope
disappears, so a register could never be defined somewhere the parser does not look.

⚠ **`prd023_stage5.py` was run BEFORE §2L existed, and its failure is part of the evidence.** It exited **1** with
*"TRACEABILITY_MATRIX.md has no section 2L — the Stage 5 gate is not satisfied. The gate is the registration, not
the intention to register"* — while simultaneously recomputing **180** identifiers across **8** registers from the
PRD body. A gate that cannot fail is not a gate.

### 2L.4 Three defects the checkers found **in themselves**, recorded rather than quietly patched

A tool's failure history is evidence about the tool. In **all three** cases **the PRD was right and the instrument was
wrong**, and in each the rule was changed rather than the document.

| # | Defect | Consequence had it shipped |
| **3** | **A dangling-citation rule that could not tell a CITATION from a REGEX TEST VECTOR.** After §2L was written, `prd023_stage5.py` exited **1** with *"… is cited … but is defined nowhere"* — pointing at §2L.1's own **measurement**, the `re.search` line that feeds a would-be `CNF-CFG` member to the bare `CFG-\d+` pattern and reports **no match**. That token is a **string fed to a pattern to prove the pattern does NOT match it**; no reader is pointed at a requirement, and `CNF-CFG-*` is declared EMPTY precisely so no such member exists. It is the **`S5-C-02` family one layer on** — an instrument mistaking prose **about** a pattern for a **use of** the thing. ⚠ Two corrections were made **to the prose, not the rule**, because there the checker was RIGHT: while describing the mutation runs I had named four identifiers — an out-of-range invariant, an in-range business rule, and one member in each of the two empty registers — that **exist in no version of the PRD** — exactly the dangling citation §2J mutation-tested with `AUD-FR-099`, reintroduced by me in the very row claiming the gate catches it. The mutations are now described **by kind, not by phantom number**. Only the genuine test-vector case was excluded, **narrowly and guarded**: single-quoted tokens inside an inline-code span containing `re.search`, in the matrix only, and the guard **fails loudly if that convention ever disappears**, so it cannot rot into a blanket exemption. Recorded as **`S5-C-03`**. Citations outside the module fall **21 → 20**, and **0 definitions** outside it either way |
|---|---|---|
| **1** | **A duplicate-definition rule that was too narrow, and a claim I nearly called false.** `prd023_traceability.py`'s first form asserted that each gap §14 names as *"raised in the body"* must carry a **line-start** definition site. It failed for **six of the seven** — `CNF-GAP-001`, `003`, `004`, `005`, `007`, `008`. The document was **right**: `PRD-023` raises gaps **inline, mid-sentence** (*"Recorded as **`CNF-GAP-001`**"*, *"recorded as **`CNF-GAP-004`** rather than assumed"*), which is prose, not a definition row. Only `CNF-GAP-006` happens to begin its line | **Six false defects against a correct document**, and worse, an accusation that §14 misdescribes itself. The rule was changed to something **stronger, not weaker**: §14 states not merely *that* each gap was raised but **where**, so each `CNF-GAP-nnn at §x.y` pointer is now **resolved against that section's actual text**. A stale section pointer now fails — which the line-start rule could never have detected. Recorded as **`S5-C-01`** |
| **2** | **A reverse-hazard scan that over-reported by 645.** The first form looked for an alphanumeric before `CNF-` but read `m.group(0)[0]` — **the first character of its own match** — so every one of the **645** plain `CNF-` occurrences registered as a hazard hit, plus 3 real ones | **A fabricated substring hazard.** Believed, it would have justified an elaborate decoy test in §2L modelled on §2K's — proving nothing, since the hazard does not exist for this prefix. Driven to root cause with a true lookbehind: **3 hits, all the `b` of `\bCNF-`**. Recorded as **`S5-C-02`**; §2L now states the hazard is **absent** rather than manufacturing a decoy |

**No PRD content was changed to make a checker pass.** The rule was changed to match the document — the direction
`PRD-013_STAGE5_CONFERRAL.md` §3.2 records as correct, and the same direction §2J.4 and §2K.4 took.

⚠ **Two further instrument defects, found at Stage 4 rather than Stage 5, are cross-referenced rather than
re-litigated here**: `S4-C-01`, a modality scan that flagged `CNF-FR-069` as carrying no prescriptive keyword when
it carries **both** `SHALL` and `SHALL NOT` across a wrapped line; and `S4-C-02`, a fixed-slice `lines[1100:1130]`
that missed the *Coverage* paragraph at **L1333** and reported **23 undisclosed obligations** against a document
that discloses all **37** — which, believed uncritically, **would have produced a false Stage 4 FAIL**. Both are
recorded in §10 of [`PRD-023_STAGE4_REQUIREMENTS_REVIEW.md`](../30-product/configuration/PRD-023_STAGE4_REQUIREMENTS_REVIEW.md).
**Four instrument defects across two stages, all disclosed, none hidden.**

---

## 2M. Identifier inventory — File & Media (`PRD-017`, the `BC-29` stored-object capability)

Registers the `FIL-*` prefixes so that **232 identifiers in a Stage-5-seeking document are not registered
nowhere** — the condition `PRD_LIFECYCLE.md` Stage 5 exists to prevent, and the one §2G was added to fix for
`PRD-008`, §2H for `PRD-019`, §2I for `PRD-013`, §2J for `PRD-016`, §2K for `PRD-014` and §2L for `PRD-023`.
**232 is the largest register set this matrix has ever admitted**, exceeding `PRD-023`'s 180.

**The pre-commit measurement, stated with its regex** because §2K established that a bare `grep -c` is unsafe for
any prefix that can occur as a substring:

```
grep -cE '(^|[^A-Za-z-])FIL-(FR|BR|INV|EVT|XC|AC|CFG|GAP)-[0-9]+' docs/40-implementation/TRACEABILITY_MATRIX.md
→ 0
```

⚠ **The reverse hazard is PRESENT AS PROSE ABOUT ITSELF, which no predecessor carried.** A scan for an
alphanumeric immediately preceding `FIL-` across the whole of `docs/` returns **exactly one context**, and it is
`PRD-017` §0.4 line 124 — the sentence recording the measurement `grep -roE '\b[A-Z]*FIL-'` → **0 matches**, whose
own words name *"a hypothetical `PROFIL-`"*. That is prose **about** a pattern, not a word embedding the prefix —
the `S5-C-02` family §2L.4 item 3 records one layer on. §2L could state its reverse hazard **absent**; here it is
absent *in fact* but *present in text*, so `prd017_stage5.py` check 4b asserts the anchored form rejects `XFIL-`,
`PROFIL-` and `AFIL-` and still finds a genuine `FIL-FR-001` in ordinary prose. **The document's own claim about
itself is tested, not believed.**

⛔ **Stage 5 is claimed for `PRD-017`; Stage 6, freeze and architecture alignment are NOT.** The two discharges §2J,
§2K and §2L recorded are shown rather than asserted, and a third row is added that no predecessor needed:

| # | Reason §2I withheld the stage | Status for `PRD-017` |
|---|---|---|
| **1** | **No role holder.** `PRD_LIFECYCLE.md` §6 assigns Stage 5 to the **traceability owner**; L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`) | **DISCHARGED by conferral**, recorded at [`PRD-017_STAGE5_CONFERRAL.md`](../30-product/file-media/PRD-017_STAGE5_CONFERRAL.md) in the identical form §2J, §2K and §2L used. ⚠ **`PGA-08` is a standing repository gap and is NOT cured here** — the conferral is per-act, not an owner appointment (`ADR-0033` §7.1: *"A conferral for one act is not a standing licence"*) |
| **2** | **No committed gate script.** Stage 5 demands counts *"verified **mechanically**"*, and *"a number computed once is not a number verified mechanically on every commit"* | **DISCHARGED by construction.** [`prd017_traceability.py`](../../tool/docs_check/prd017_traceability.py) and [`prd017_stage5.py`](../../tool/docs_check/prd017_stage5.py) are committed under `tool/docs_check/` and re-run on every invocation. Neither imports the other, and they use **different parsing strategies** — see §2M.3 |
| **3** | ⛔ **NOT A DISCHARGE — an unresolved architecture dependency, carried forward openly** | **`FIL-GAP-012` is OPEN.** BC Map L331 lists `E-22`'s consumers as `BC-01`, `BC-10`, `BC-14`; **`BC-12` Messaging is not among them**, and L292 rules that *"if an edge is not in this table, it does not exist and adding it requires an ADR."* Student-to-student file sharing is a **V1** capability, so a `BC-12` consumer grant is required and **has not been made**. Stage 5 registers identifiers; **it does not confer architecture alignment**, and `prd017_stage5.py` **check 10** fails the run if this section ever claims otherwise while the gap is open — the only check of its kind in this repository |

| Prefix | Meaning | Count | Range | Source |
|---|---|---|---|---|
| `FIL-FR-*` | Functional requirements — architectural position, the video/audio V1 line, the two frozen consumers, the consumed permission model, upload, the `FileRef` contract, metadata and ownership, read and access, tenant isolation on every surface, lifecycle operations, derivatives and thumbnails, failure/retry/idempotency, progress, extensibility, shared-object access, and — **added at v0.2 by `ADR-0056`** — media optimization: derivative inheritance, document-like vs photographic classification, the document-aware and perceptual profiles, adaptive profile selection from measured input, original-byte preservation, original-quality as a consumed entitlement, lossless-only document handling, serving variants, the `RECEIVED → VALIDATING → PROCESSING → READY`/`FAILED` lifecycle, idempotency and bounded retry, progress without leakage, and the stall timeout | **95** | `001`–`095` | `PRD-017` §2.1, §2.4, §2.5, §3.2, §4.1–§4.12 |
| `FIL-BR-*` | Business rules — the permission model is consumed and never defined, plus the fifteen rules governing bytes, ownership, isolation, retention and sharing, and the two v0.2 media rules — *a document has no lossy path* and *readability outranks size* | **19** | `001`–`019` | `PRD-017` §3.2, §5 |
| `FIL-INV-*` | Invariants — required properties of the stored-object record, plus the two v0.2 invariants: document bytes are byte-exactly recoverable, and **an object is servable only in `READY`** | **13** | `001`–`013` | `PRD-017` §6.2 |
| `FIL-EVT-*` | Domain events — **DECLARED EMPTY, and registered as empty rather than omitted.** `BC-29` publishes **no** domain event, and the reason is architectural rather than editorial: BC Map §9 carries **no `BC-29` producer row**, and L292 rules that an edge absent from the table does not exist. `PRD-017` §13.2 draws the consequence the predecessors did not have to — **`E-20` is therefore *not available* to this module**, so the audit obligation cannot be routed the way `PRD-023` routed its own (`CNF-FR-052`). Minting even one numbered member of this register would **assert an edge the BC Map does not carry**. `prd017_stage5.py` check 7 fails if a member ever appears. **The fifth consecutive platform PRD to declare an event register empty for a measured reason** | **0** | *none issued* | `PRD-017` §0.2, §0.3, §13.2 |
| `FIL-XC-*` | Exclusions — what **MUST be impossible**: owning the permission model, minting authorisation decisions, defining conversations or messages, moderation, the friendship graph, virus-scanner implementation, transcoding, CDN policy, reference counting, de-duplication, tenant lifecycle, event publication, and nine more — plus `FIL-XC-023` at v0.2, which refuses both the original-quality **policy** decision and **video/audio optimization**, restating `FIL-XC-016` so adaptive machinery cannot be misread as admitting video | **23** | `001`–`023` | `PRD-017` §2.3 |
| **`FIL-AC-*`** | **Acceptance criteria** | **96** | `001`–`096` | **`PRD-017` §14.1–§14.5** |
| `FIL-CFG-*` | Configurables — size ceilings, MIME allow-lists, scan timeouts, retention windows, derivative dimensions, share-grant limits, and the six v0.2 media parameters — document quality floor, document minimum long edge, photographic profile bound, output-encoding allow-list, processing retry bound and processing timeout. ⚠ **`FIL-CFG-010`, `011` and `015` are published WITHOUT defaults**, an explicit departure from the Stage 4 rule that *"unbounded configuration is a specification hole"*, taken on `FIL-CFG-006`'s precedent because **no Rank 1–4 authority supplies a value** and inventing one would be a determination made without standing — `FIL-GAP-014` carries them, and `FIL-FR-052`'s startup refusal is why the hole is a refusal rather than a silent zero | **15** | `001`–`015` | `PRD-017` §8.5 |
| `FIL-GAP-*` | Open gaps — no `BC-29` aggregate in BC Map §8, no `platform/services` manifest block, **`FIL-GAP-012`, whose architecture half is now CLOSED by `ADR-0055` and whose implementation half remains OPEN**, no RLS architecture document, the missing architecture tests, and eight more — plus the three v0.2 findings: the owed compression/timeout values (`FIL-GAP-014`), the Job Runtime V1/V2 sequencing gap (`FIL-GAP-015`), and ⛔ **the REFUSED V1 video/audio optimization request (`FIL-GAP-016`)** | **16** | `001`–`016` | `PRD-017` §16 |
| **Total** | | **277** | | **150 obligation-bearing + 96 `FIL-AC-*` + 15 `FIL-CFG-*` + 16 `FIL-GAP-*`; 0 retired** |

**Every range is contiguous from `001` to its stated maximum, and the counts are computed by two independent
scripts rather than read** — the `SR-01` failure class this matrix has already suffered once.

**Contiguity here is judged over a set where declared EQUALS in force**, as for `PRD-016`, `PRD-014` and `PRD-023`
and unlike `PRD-013`: `PRD-017` §0.2 issues no retirement, so no register carries a hole and one count per register
is unambiguous. Both scripts fail if a retirement ever appears.

⚠ **The published counts are not the counts §0.2 was first written with, and the document says so.** The registers
were declared *before* the body was drafted, as L82 rule 2 requires. Two of them moved **during Stage 4 itself**:
acceptance criteria rose **76 → 78** when the review's own repairs introduced observable behaviour no criterion
asserted, and the published total rose **230 → 232**. Rule 3 requires ranges *contiguous*, not *predicted*, so the
ranges were **closed to the delivered counts rather than padded to the estimates**.

**Coverage, measured at `PRD-017` v0.1:**

| Measure | Value |
|---|---|
| Obligation-bearing identifiers (Class A) | **150** (95 `FIL-FR-*` + 19 `FIL-BR-*` + 13 `FIL-INV-*` + 0 `FIL-EVT-*` + 23 `FIL-XC-*`) — **v0.2**, recomputed by both checkers |
| Obligations carrying a `FIL-AC-*` | **112** |
| **Coverage** | **112 / 150 = 74.7%** — ⚠ **recomputed at v0.2, not adjusted.** The amendment added **18** obligations and **18** criteria and **every new obligation is covered**, so the uncovered set stayed at **38** and only the denominator moved |
| Orphan criteria (verify nothing) | **0** |
| Dangling `FIL-*` citations | **0** |
| Undisclosed uncovered obligations | **0** |
| Criteria **proven by a passing test** | ⛔ **0 of 78** |

⚠ **71.2% is published unrounded, and the 38 uncovered obligations are classified rather than merely counted.**
They are **17 `FIL-XC-*`**, **17 `FIL-FR-*`**, **3 `FIL-BR-*`** and **1 `FIL-INV-*`** — a distribution recomputed by
both scripts. The exclusions are uncovered **by construction**: an exclusion states what must be *impossible*, and a
criterion asserting that something never happens is unfalsifiable by observation, which is why `PRD-013` §7
established that naming the uncovered set is the correct discipline rather than manufacturing criteria to raise a
percentage. **Five exclusions ARE covered** — `FIL-XC-008`, `019`, `020`, `021`, `022` — because each has an
observable positive consequence, so the 22 split 5 covered / 17 not. The remaining 21 are definitional: requirements
that fix vocabulary or state a structural fact. **This matrix has been wrong about a coverage figure before** —
`PRD-006` v1.0 published *"100% coverage"* against a true **49.1%** — so the figure is computed **and** qualified,
and `prd017_stage5.py` check 8 fails the run if it ever stops matching the PRD.

⚠ **This module's uncovered set is DISCLOSED AS A CLASS, not as a list of 38 names, and that is deliberate.**
`PRD-017` §14.3 names the 21 definitional identifiers individually and then discloses the exclusions by the rule
*"all `FIL-XC-*` except `FIL-XC-008`, `019`, `020`, `021`, `022`"*. A class claim with a determinate complement is
**stronger** than an enumeration, because it cannot go stale when a criterion is added — but it is also harder to
check, and the first form of `prd017_traceability.py` **reported 17 false defects against a correct document** for
exactly this reason. The rule was changed rather than the document, and the checker now accepts a class claim only
if its arithmetic is true (22 − 5 = 17). Recorded as **`S5-C-01`** in the conferral record. ⚠ Contrast §2L, where
`PRD-023` **over-declares** its uncovered set by three: that document is wrong in the safe direction, this one is
wrong in neither, and the difference was established by measurement rather than by reading either claim.
### 2M.1 Prefix collisions checked — in three directions

| Direction | Result |
|---|---|
| `FIL-` **defined** outside `docs/30-product/file-media/` and `docs/40-implementation/file-media/` | **0.** Every `.md` under `docs/` plus every `.py`/`.dart`/`.yaml` under `tool/`, `lib/` and `test/` is walked by `prd017_stage5.py` check 4c, which **fails as vacuous if fewer than 50 files are scanned** — a guard §2L did not carry. An anchored scan returns `FIL-*` register tokens in **exactly four files**: the three `PRD-017` documents and `prd017_traceability.py`, plus this matrix's §2M — and **nowhere else** |
| `FIL-` **cited** outside the module | **0 at present.** Each occurrence would be resolved against the defined set rather than counted as a failure — **a citation is not a collision** (the §2C.1 principle) — so a genuinely new `FIL-*` *definition* in any outside document still fails the run. ⚠ One narrow exclusion: single tokens inside `tool/*.py`, because a checker naming its own **test vectors** is not citing a requirement — the `S5-C-03` family, scoped to `tool/` only so it cannot rot into a blanket exemption for `docs/` |
| Foreign prefixes **defined** inside `PRD-017` | **0.** Every foreign identifier — `ADR-0013`, `ADR-0016`, `ADR-0022`, `BC-01`…`BC-31`, `E-14`, `E-16`, `E-20`, `E-22`, `X-05`, `X-13`, `ID-1`, `ID-2`, `L2`, `L3`, `MP-GBR-08`, `TEN-FR-018`, `TEN-AC-014`, `SID-4.35`, `LIB-6.6`, `ATT-GAP-010`, `CFG-1`…`CFG-12`, `INV-1`…`INV-16` — appears **only** as an attributed citation, never in a first table cell or at a line start. Measured at Stage 4: **0** unattributed restatements across 132 obligation texts |
| `FIL` vs the **78** prefix stems already registered in this matrix | **No overlap**, and no bare `FIL` stem, verified by `prd017_stage5.py` check 4a against the **parsed** stem set rather than by reading the list. The check **fails as vacuous if zero stems are parsed**, so "no collision" cannot be an artefact of a broken parser |
| ⚠⚠⚠ Substring hazard — **`CFG-1`…`CFG-12` is an OCCUPIED register AND `FIL-CFG-*` HAS NINE REAL MEMBERS. This is strictly sharper than §2L's case, and the difference is arithmetic rather than rhetorical** | **Checked in both directions.** §2L called its own `CFG-` hazard the sharpest any module had carried — but `CNF-CFG-*` is **empty**, so a naive scan sweeping it up would have been counting members of a register with none. Here **both** registers are live: `CFG-1`…`CFG-12` owned by `PRD-001` (**FROZEN v2.0**), and `FIL-CFG-001`…`FIL-CFG-009` owned by this module. A naive `CFG-\d+` scan would **silently merge two live registers owned by two different documents, one of them FROZEN**. Measured: `re.search(r'(?<![A-Z-])CFG-\d+', 'FIL-CFG-001')` → **no match**; and the anchored form is asserted to **still match** `FIL-CFG-001`, without which the negative result would prove nothing |
| ⚠⚠ Substring hazard — **`INV-1`…`INV-16` are platform invariants this module must not be confused with** | **Checked in both directions.** §2A.1 records `INV-n` as a **platform invariant** (`CONFIGURATION_GUIDE.md` §3), separately from `INV-SEC-n` and `INV-XC-n`. Measured: `re.search(r'(?<![A-Z-])INV-\d+', 'FIL-INV-001')` → **no match**, and the anchored form still matches its own member |
| ⚠ Substring hazard — the **reverse** direction, `FIL-` inside a longer word | **ABSENT IN FACT, PRESENT IN TEXT — and tested rather than asserted.** Exactly one context in the whole of `docs/`: `PRD-017` §0.4's own sentence about a *"hypothetical `PROFIL-`"*. Check 4b asserts the anchored form rejects `XFIL-FR-001`, `PROFIL-FR-001` and `AFIL-CFG-001`, **and** that it still finds `FIL-FR-001` in ordinary prose |
| `FIL-` vs `ENT-`/`AUD-`/`TEN-`/`CNF-`/`SEAT-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |

**Collision result: zero, in all three directions.**

### 2M.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| ⛔ **Confer architecture alignment** | **`FIL-GAP-012` is OPEN.** `E-22`'s consumer cell does not list `BC-12`, and student-to-student sharing is a **V1** capability. `PRD-017_ARCHITECTURE_ALIGNMENT.md` §9 records the finding as `S3-A-01` and narrowed it — `BC-11` and `BC-13` need **no** `FileRef` access, so the required amendment is **one context, not three**. That amendment requires an ADR on the `ADR-0016` precedent and **has not been made**. `prd017_stage5.py` **check 10** fails the run if this section claims alignment, Stage 6, or FROZEN status while the gap is open |
| **Confer Stage 6, freeze, or verification** | Stage 5 confers **registration**. `PRD-017` remains **v0.1 `DRAFT`** and **`PLANNED`** in `PRD_REGISTRY.md` L307. Freeze can be conferred only by a row in `DOCUMENTATION_BASELINE.md` §3 — *"never claim FROZEN merely by changing a status field"* |
| **Issue any `FIL-EVT-*` member** | The Stage 5 mandate is explicit that numbered members may not be created *"unless Stage 5 finds authoritative evidence requiring them."* **It found none, and looked**: BC Map §9 producer rows for `BC-29` = **0**. Minting one would assert an edge L292 says does not exist. Enforced as a test — check 7 |
| **Allocate an `IMPL-*` range** | Stage 6. `docs/40-implementation/file-media/` **does not exist**. The next free block is **`IMPL-1200`+**, established by measurement — `PRD-023_IMPLEMENTATION_TASKS.md` L88 reserves `IMPL-1130`–`1199` as `PRD-023`'s growth reserve and **L89 reads `| IMPL-1200 + | Unallocated | — |`**. ⚠ **Not** taken from `PRD_LIFECYCLE.md` L147–153, whose table is **stale** (it still reads `IMPL-227+`). Rule 1: *"Never reuse or reassign a number"* |
| **Add any edge, or amend any cell** | `PRD-017` creates **zero** edges and amends **zero** cells. `E-22` already exists at BC Map **L331**; it is cited, not created. The `BC-12` question is **raised**, not silently answered — the `ADR-0016` §4.3 discipline, *"One cell, one edge, named explicitly"* |
| **Close any `FIL-GAP-*`** | All **13** remain **OPEN** after this registration. Stage 5 closes the *registration*, not the gaps |
| **Repair the stale Stage 3 subject hash** | `PRD-017_ARCHITECTURE_ALIGNMENT.md` publishes the subject at `85adb6fa…`, and the Stage 4 review **edited the subject**, so that hash is now stale. Disclosed in §2 of [`PRD-017_STAGE4_REQUIREMENTS_REVIEW.md`](../30-product/file-media/PRD-017_STAGE4_REQUIREMENTS_REVIEW.md) with a before/after table rather than repaired: *"a stale review is corrected by a dated re-run beside it, not by editing what it concluded."* All Stage 4 edits were **non-boundary** — 0 edges, 0 consumers, 0 aggregates, 0 ranks, 0 isolation classes — so Stage 3's conclusions survive |
| **Re-issue the baseline identifier** | `DOCUMENTATION_BASELINE.md` §7 step 4 moves it only when a **Rank 1–3** document changes version. `PRD-017` holds **no rank at all** yet, is `DRAFT` at v0.1, and this matrix is **unranked** — it confers nothing |
| **Touch any existing section, `PRD_REGISTRY.md`, or any ADR** | §2 through §2L are **byte-unchanged**, as are `PRD_REGISTRY.md` and all **53** ADRs. This pass appends §2M, one version field and one change-history row |
| **Modify any existing gate script** | All **23** pre-existing scripts under `tool/docs_check/` are **byte-unchanged**. The two new files **add** checks and weaken none. The **5** pre-existing exit-1 checkers are **not** repaired and remain failing for their own recorded reasons |

### 2M.3 Why the two checkers can disagree with each other

§2H.2 names the failure mode this pair exists to avoid: *"a checker written in the same pass as the register it
checks, by the same author, verifies agreement with itself."* Both mitigations are applied.

| Script | Subject | Opens the matrix? | Parsing strategy |
|---|---|---|---|
| `prd017_traceability.py` | `PRD-017` against **itself** — §0.2's declarations against the body | **No, never** | Classifies each **line** by ordered line-start patterns, indifferent to where the line sits |
| `prd017_stage5.py` | §2M against **the PRD body**, recomputed independently | Yes | Splits at **both `## ` and `### `** and accepts an identifier only where that scope is **entitled** to define it |

`prd017_stage5.py` does not import from `prd017_traceability.py`. **Both arrive at 232 by structurally different
routes** — one by line form, one by scope position — which is evidence; agreement by one route repeated twice would
not be. The scope parser carries a **24-entry authorisation table**, and it was **derived from a measurement of the
document rather than guessed**: a guessed table either forbids something the document legitimately does (a false
failure) or permits a scope the document never uses (a hole the parser cannot see through). It fails if any listed
scope disappears, so a register could never migrate somewhere the parser does not look.

**The difference is load-bearing.** The scope parser catches a class the line parser cannot see at all — a
`FIL-INV-*` minted inside §11 UI/UX, or a `FIL-FR-*` minted among the acceptance criteria in §14. Conversely the
line parser catches shapes this one would miss. Neither subsumes the other.

⚠ **`prd017_stage5.py` was run BEFORE §2M existed, and its failure is part of the evidence.** It exited **1** with
*"TRACEABILITY_MATRIX.md has no section 2M — the Stage 5 gate is not satisfied. The gate is the registration, not
the intention to register"* — while simultaneously recomputing **232** identifiers across **7** non-empty registers
from the PRD body. **A gate that cannot fail is not a gate.**

### 2M.4 Four defects the checkers found **in themselves**, recorded rather than quietly patched

A tool's failure history is evidence about the tool. In **all four** cases **the PRD was right and the instrument was
wrong**, and in each the rule was changed rather than the document. **This is the third time in this module's
history that a census tool has blamed a correct document** — bold-wrapped `FIL-GAP-*` table rows defeated a
prose-only regex at Stage 2, and a register census under-counted two registers by 22 at Stage 4.

| # | Defect | Consequence had it shipped |
|---|---|---|
| **1** | **A coverage-disclosure rule that could not read a CLASS CLAIM.** `prd017_traceability.py`'s first form demanded that every uncovered obligation be named individually, and reported **17 undisclosed** `FIL-XC-*`. The document was **right**: §14.3 discloses the exclusions by rule — *"all `FIL-XC-*` except `FIL-XC-008`, `019`, `020`, `021`, `022`"* — a claim with a determinate complement | **Seventeen false defects against a correct document**, and worse, "fixing" it would have **degraded** the disclosure from a stale-proof rule to an enumeration that decays whenever a criterion is added. The rule was changed to something **stronger, not weaker**: a class claim is accepted only if its arithmetic is **true** — register size, named-exception count and uncovered count must reconcile (22 − 5 = 17). A miscounted class claim now fails, which an enumeration check never tested. Recorded as **`S5-C-01`** |
| **2** | **A live-claim scan that punished disclosure.** The same run reported *"prose states 114"* against a document whose true Class A count is 132. The string existed **only inside a `>` correction note quoting the dead figure** — the note added at Stage 4 to record that the number had been wrong | **A checker that cannot tell a live claim from a quoted dead one PUNISHES DISCLOSURE and rewards silent edits.** Believed, it would have pressured the removal of the very note that documents the repair. Recorded as **`S5-C-02`**; the scan now excludes **correction-note** lines specifically, identified by `⚠` and phrases such as *"Corrected at Stage"* and *"As first written"* |
| **3** | ⚠⚠ **And the fix for `S5-C-02` immediately created a WORSE hole, which only mutation testing found.** Excluding `>` lines swallowed the **authoritative total itself**, because §0.2's `> **Totals: 232 identifiers…` IS a blockquote. Mutant **M6** corrupted `232 → 999` and the checker **passed it** | **The single most important live number in the document became uncheckable.** The vacuity guard missed it too: *a guard that counts claims cannot detect the loss of the RIGHT claim.* Recorded as **`S5-C-03`**; the exclusion was narrowed to correction-note markers only, and a new **check 10a** asserts the `Totals:` declaration stays in scope — so the guard now protects a **named** claim, not a population |
| **4** | **A membership test over too wide a window.** Mutant **M11** dropped `FIL-XC-008` from the exception **sentence**, and the run still passed, because the identifier is cited elsewhere within the same 4000-character block | **A rule that cannot distinguish "named as an exception" from "mentioned nearby"** — the exact hole that makes a class claim unverifiable. *Scope, not pattern, was the defect.* Recorded as **`S5-C-04`**; the exception sentence is now delimited precisely, from `are the exception` to the following `The remaining`, so a name dropped from it cannot be satisfied by a mention two paragraphs later |

**No PRD content was changed to make a checker pass.** The rule was changed to match the document — the direction
`PRD-013_STAGE5_CONFERRAL.md` §3.2 records as correct, and the same direction §2J.4, §2K.4 and §2L.4 took.

⚠ **Two of these four were found by MUTATION TESTING, not by the clean run**, and that distinction matters more
than the count. A checker that passes proves nothing about what it would reject. `prd017_traceability.py` was driven
through **three rounds** — 8 mutants (M6 and M8 escaped), 12 mutants (M11 escaped), then **14 mutants, 14 killed, 0
escapes, baseline still passing**. One escape (**M8**) turned out to be a **bad mutant** rather than a checker
defect — it injected a second definition site for `FIL-BR-013`, which carries no `SHALL`/`MUST` and so was never a
valid definition — and it was **replaced rather than counted as a kill**. Full record in §4 of
[`PRD-017_STAGE5_CONFERRAL.md`](../30-product/file-media/PRD-017_STAGE5_CONFERRAL.md).

---

## 2N. `PRD-012a` Security Automation — `SECP-*` identifier inventory

| Field | Value |
|---|---|
| **Subject** | `PRD-012a` Security Automation, **Parts 1–8**, **v0.8 `FROZEN` at Rank 3** — `docs/30-product/security/PRD-012a_*.md`. ⚠ *This cell read `v0.8 DRAFT` when §2N was registered at Stage 5 and was corrected 2026-08-21 when `ACCEPTED` `ADR-0064` conferred Stage 7 under `BASELINE-2026-08-21-A`. **The version did not move** — v0.8 both before and after, the sixth v0.x admission; freeze confers status, not content.* ⚠ **The 8 Parts are byte-identical to the bytes registered below** — `git diff --stat bd85a31 HEAD` over all 8 files returns **empty**, so **no alignment supplement is required and none was written** |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` L121–133) |
| **Prefix stem** | **`SECP-`** — *not* `SEC-`; see §2N.1 for the measured rejection |
| **Registers** | **15** |
| **Identifiers** | **427**, every register contiguous from `001` to its stated maximum |
| **Normative requirements** | **109** (`SECP-FR-*` 84 + `SECP-BR-*` 25) |
| **Acceptance criteria** | **128** — coverage **109/109, zero uncovered** |
| **Collisions** | **ZERO**, measured in **four** directions — §2N.1 |
| **Registered at** | `bd85a31d0b93da809706cf351a282adedb05149a` |
| **⛔ What this registration does NOT confer** | **Rank, freeze, `IMPL-*` allocation, architecture closure, or gap closure.** See §2N.2. ⚠⚠ **STILL TRUE OF THIS SECTION, and the distinction is the whole point of retaining it:** rank and freeze were subsequently conferred by **`ADR-0064`** and the `IMPL-1300`…`1359` range allocated at **Stage 6** — *by those acts, not by this registration*. **Architecture closure and gap closure were never conferred by anyone**: the three architecture conflicts were decided by `ADR-0061`/`ADR-0062` (**Architecture Owner**) and one by `ADR-0063` (**`BC-18` owner**), while **all 47 `SECP-GAP-*` remain OPEN** |

### 2N.0 The inventory

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `SECP-FR-NNN` | Functional requirement | **84** | `001`…`084` | ✅ | `085` |
| `SECP-BR-NNN` | Business rule | **25** | `001`…`025` | ✅ | `026` |
| `SECP-XC-NNN` | Cross-cutting exclusion | **37** | `001`…`037` | ✅ | `038` |
| `SECP-OWN-NNN` | Ownership boundary | **30** | `001`…`030` | ✅ | `031` |
| `SECP-AC-NNN` | Acceptance criterion | **128** | `001`…`128` | ✅ | `129` |
| `SECP-GAP-NNN` | Gap-ledger entry | **44** | `001`…`044` | ✅ | `045` |
| `SECP-OBJ-NNN` | Objective | **12** | `001`…`012` | ✅ | `013` |
| `SECP-PRN-NNN` | Directional principle | **12** | `001`…`012` | ✅ | `013` |
| `SECP-HRO-NNN` | High-risk admin operation | **12** | `001`…`012` | ⛔ **CLOSED** by `SECP-BR-004` | — |
| `SECP-SIG-NNN` | Detection signal | **10** | `001`…`010` | ⛔ **CLOSED** | — |
| `SECP-SEV-NNN` | Severity level | **4** | `001`…`004` | ⛔ **CLOSED** | — |
| `SECP-TST-NNN` | Test obligation | **8** | `001`…`008` | ⛔ **CLOSED** | — |
| `SECP-TRC-NNN` | Traceability record | **9** | `001`…`009` | ✅ | `010` |
| `SECP-DEP-NNN` | External dependency | **7** | `001`…`007` | ✅ | `008` |
| `SECP-ADR-NNN` | ADR request | **5** | `001`…`005` | ✅ | `006` |
| **Total** | | **427** | | **15 of 15 contiguous** | |

⚠ **Four registers are CLOSED and may not be extended without an ADR** — `PRD_LIFECYCLE.md` §5 rule 6: *"a register
declared closed may not be extended without an ADR."* `SECP-HRO-*` is closed by `SECP-BR-004`'s default-refuse rule,
which makes any platform-scoped, irreversible or tenant-affecting operation absent from the set **refused** rather
than implicitly permitted. Extending the set by one member without an ADR would silently authorise an operation the
closure rule currently denies.

⚠⚠ **Three registers are DECLARED EMPTY, each with a published reason, and each absence is a finding rather than an
omission:**

| Register | Members | Reason published by the subject |
|---|---|---|
| `SECP-INV-*` | **0** | No owned aggregate — `SECP-GAP-010`. An invariant implies an aggregate; `PRD-012a` owns none |
| `SECP-EVT-*` | **0** | No `BC-nn` producer row exists for the SECURITY platform — `SECP-OWN-023`. Minting one would assert an edge BC Map L292 says does not exist |
| `SECP-CFG-*` | **0** | Would duplicate `PRD-001`/`PRD-023` parameters — `SECP-XC-014`. `BC-25` owns parameters, validation and typed accessors |

The `PRD-016` precedent governs: `AUD-EVT-*` and `AUD-CFG-*` were both admitted to the baseline **empty**, on the
reasoning that `BC-24` publishes nothing and no authority supplied a retention bound, so a default *"would have been
a legal determination by a document with no standing to make one"* (`ADR-0051` §2.4).

### 2N.0.1 Per-Part distribution — measured by range, not by file order

| Part | File | Identifiers |
|---|---|---|
| 1 | `PRD-012a_SECURITY_AUTOMATION.md` | **72** |
| 2 | `PRD-012a_PART2_PLATFORM_ADMIN_SECURITY.md` | **85** |
| 3 | `PRD-012a_PART3_ZERO_TRUST_IAM_TENANT_SECURITY.md` | **41** |
| 4 | `PRD-012a_PART4_APPLICATION_API_SESSION_DATA_SECURITY.md` | **48** |
| 5 | `PRD-012a_PART5_THREAT_DETECTION_MONITORING_ALERTS.md` | **51** |
| 6 | `PRD-012a_PART6_SECURITY_AUTOMATION_INCIDENT_RESPONSE.md` | **43** |
| 7 | `PRD-012a_PART7_AUDIT_VULNERABILITY_TESTING_RESILIENCE.md` | **54** |
| 8 | `PRD-012a_PART8_TRACEABILITY_AND_ACCEPTANCE.md` | **33** |
| **Total** | | **427** |

⚠ **Part 1 declares no `SECP-FR-*` and no `SECP-BR-*`.** `FR-001`…`018` and `BR-001`…`008` belong to **Part 2**. This
is recorded because a per-Part count that assumed Part 1 opened the functional register produced a **false mismatch**
on Parts 1 and 2 during authoring; the ranges were re-measured and the *instrument* corrected, not the documents.
Anyone re-deriving this table must measure the ranges rather than infer them from Part order.

### 2N.1 Prefix collisions checked — in four directions

| Direction | Result |
|---|---|
| `SECP-` **defined** outside `docs/30-product/security/` | **0.** All fifteen registers were probed individually — `grep -roE "\bSECP-<REG>-[0-9]{3}" docs/ --include=*.md` filtered to exclude the owning directory returns **0 for every one of the 15**. Not a single aggregate `grep`, because an aggregate count of zero cannot say *which* register is clean |
| Foreign prefixes **defined** inside `PRD-012a` | **0.** Every foreign identifier — `MP-GBR-*`, `MP-NFR-*`, `MP-RSK-*`, `MP-CON-11`, `AUTH-2.26`, `AUTH-8.16`…`8.39`, `AUTH-11.20`…`11.59`, `TEN-*`, `AUD-*`, `CNF-*`, `FIL-*`, `SPO-*`, `SEV-*`, `BC-01`…`BC-31`, `E-20`, `E-22`, `X-13`, `ID-1`, `L2`, `ADR-0002`/`0003`/`0004`/`0011`/`0014`, `INV-SEC-*` — appears **only** as an attributed citation, never as a first-cell definition. Confirmed at Stage 4 across 109 obligation texts: **0** unattributed restatements |
| ⚠⚠⚠ **Substring hazard — the reason this prefix is `SECP-` and not `SEC-`** | **`SEC-` WAS MEASURED AND REJECTED.** The Invitation Security Specification (`docs/30-product/library/INVITATION_SECURITY_SPECIFICATION.md`, **v1.0, Rank 3, in the baseline**) owns `INV-SEC-001`…`071`, registered in this matrix's §2 at L62. A bare `SEC-` stem was measured at **155 hits** and **rejected** — recorded in `PRD-012a` Part 1 §0.4 and Part 7 L78. `PRD_LIFECYCLE.md` §5 **rule 3** compelled the direction of the fix: *"on collision change the **NEW** prefix, never the existing one."* Had `SEC-` been taken, a citation of `SEC-004` would have been ambiguous between a **frozen Rank 3 Library invariant** and a security-platform requirement. Measured now: `re.search(r'(?<![A-Z-])SEC-\d+', 'SECP-FR-001')` → **no match**; and the four residual bare-`SEC-` hits inside `PRD-012a` were each inspected and are all **`INV-SEC-*` citations** in the prose explaining this very rejection — *a citation is not a collision* (the §2C.1 principle) |
| ⚠⚠ **Substring hazard — the reverse direction, `SECP-` inside a longer token** | **ABSENT IN FACT.** `grep -rhoE "\b[A-Z]{2,6}SECP-\|SECP[A-Z]" docs/ --include=*.md` returns **nothing** — no `XSECP-`, no `SECPX`, no prefix stem ending in `SECP`. The `PROFIL-`/`FIL-` hazard §2M had to test for has no analogue here |
| `SECP-` vs every prefix stem already registered in this matrix | **No overlap**, and no bare `SECP` stem anywhere |
| `SECP-` vs `FIL-`/`CNF-`/`AUD-`/`TEN-`/`ENT-`/`SEAT-` numerics | **Not a collision.** Numeric ranges are **per register**, as §2B.1 records: registers *"overlap numerically on purpose"* |
| ⚠ **`SECP-SEV-*` vs `PRD-003`'s `SEV-1`…`SEV-16`** | **Checked in both directions and it is the second-sharpest hazard here.** `PRD-003` owns `SEV-1`…`SEV-16`; `PRD-012a` owns `SECP-SEV-001`…`004`. **Both registers are live.** A naive `SEV-\d+` scan would silently merge a Rank 3 register with this one. Measured: `re.search(r'(?<![A-Z-])SEV-\d+', 'SECP-SEV-001')` → **no match**, and the anchored form still matches `SEV-16` in ordinary prose — without that second assertion the negative result would prove nothing. Note the register uses **three-digit** members (`001`) against `PRD-003`'s **one-and-two-digit** (`1`…`16`), which is a second independent discriminator |

**Collision result: ZERO, in all four directions.**

### 2N.2 What this registration deliberately does not do

| Not done | Why |
|---|---|
| ⛔ **Confer a rank, or freeze** | ⚠⚠ **SUPERSEDED 2026-08-21 — this cell was TRUE WHEN WRITTEN at Stage 5 and IS NOW FALSE.** `PRD-012a` **holds Rank 3 and IS frozen**: `DOCUMENTATION_BASELINE.md` §3.3 now carries the admitting row and §4 carries a Rank 3 precedence row, conferred by `ACCEPTED` [`ADR-0064`](../00-governance/adr/ADR-0064-prd-012a-security-automation-v0.8-baseline.md) under **`BASELINE-2026-08-21-A`**. **This section still confers nothing** — the correction records that the gate was met **elsewhere**, by the Governance Owner, and Stage 5 remains the only stage this section claims. ⚠⚠ **One clause of the superseded text was not merely stale but WRONG WHEN WRITTEN, and correcting it is the reason the admission was lawful.** It asserted §4 holds *"13 Rank 3 module baselines and **every one is scoped to a bounded context or a named domain**"* — the second half is **falsified by §4's own Library PRD row**, which reads *"Everything inside the **Library Management domain**"*: a **domain**-scoped row, not a `BC-nn`-scoped one. So a non-`BC-nn` Rank 3 scope was **already an established shape**, and `PRD-012a`'s platform-scoped row is a **third instance of an existing form rather than a new one**. ⛔ **Had all 13 genuinely been context-scoped, the admission would have STOPPED** and returned the row-shape question to the Architecture Owner; it proceeded on a **measured precedent**, recorded at `ADR-0064` §2.2. ⚠ **The claim that `PRD-012a` owns no bounded context REMAINS TRUE and is not softened** — `ADR-0060` (Architecture Owner) determined the SECURITY platform **is not** a bounded context and **refused to create `BC-32`**; contexts stay at **31**. `PRD-012a` is the **first `FROZEN` PRD in the repository owning no bounded context**. Freeze remains *"conferred, not claimed"* — and here it **was** conferred. *Prior text retained verbatim:* **`PRD-012a` holds NO rank and is NOT frozen.** Stage 7's gate is a row in `DOCUMENTATION_BASELINE.md` §3 at an assigned precedence rank, and **no such row exists**. Measured: the baseline's §4 precedence table holds **13 Rank 3 module baselines and every one is scoped to a bounded context or a named domain**; a probe for a platform-scoped row returns **0**. `PRD-012a` owns **no bounded context** and says so in its own header. Freeze is *"conferred, not claimed"* — see `PRD-012a_STAGE7_READINESS.md` |
| ⛔ **Change the registry status** | ⚠⚠ **SUPERSEDED 2026-08-21 — true when written, now false.** `PRD_REGISTRY.md` §4.1 records `PRD-012a` as **`FROZEN`** and `PRD-012` as **`RETIRED`**; §7 counts it (`FROZEN` **13 → 14**, `PLANNED` **8 → 7**). The *"not separately registered until `PRD-012` is retired"* reservation was **expressly conditional and its condition has been MET** — eight Parts exist at v0.8 and passed Stages 3–6, so `PRD-012a` is *opened* as a matter of fact and §8 rule 1 retires `PRD-012`; **the number `012` is not reused**. ⚠ **`PRD-012b` remains reserved, `PLANNED` and uncounted — the V2 half of the split is NOT executed.** ⚠ **The cell's governing principle is unchanged and is what compels this correction:** this matrix is **unranked and confers nothing**, and §8 rule 5 requires that where the register disagrees with the documents it describes, **the register is fixed**. The status was changed **by `ADR-0064`, not by this section**; *Registration ≠ status* still holds. *Prior text retained verbatim:* `PRD_REGISTRY.md` §4.1 L260 still reads **`PLANNED`**, and §7 L547–548 records that `PRD-012a` is *"**not separately registered until `PRD-012` is retired**."* This matrix is **unranked — it confers nothing**, and §8 rule 5 says that where this register disagrees with a PRD, **this register is fixed**. Registration ≠ status |
| ⛔ **Confer architecture closure** | ⚠ **PARTLY SUPERSEDED 2026-08-21 — the three conflicts are now RESOLVED, but NOT by this section.** Each was decided by the authority that held it, after this cell was written: `SECP-GAP-023` by [`ADR-0061`](../00-governance/adr/ADR-0061-alertability-rank-3-outranks-ea-v2-tag.md) (**Architecture Owner** — precedence, decided on **Rank 1** `MP-RSK-01` L551, with **no EA edit**), `SECP-GAP-031` likewise by `ADR-0061`, and `SECP-GAP-042` by [`ADR-0062`](../00-governance/adr/ADR-0062-platform-security-outbound-reach-refused-as-ports.md) (**Architecture Owner** — which **REFUSED** the four proposed ports as L2 violations and left `tool/module_dependencies.yaml` **byte-unchanged**). ⚠ **`ADR-0062` also falsified this cell's framing of `SECP-GAP-042` as an anomaly**: **8 of 22** modules lack a block and **0 of 7** at ranks 1–3 have one, so a missing block is the **norm** at that rank, not a defect peculiar to `platform/security`. ⚠ **The quoted rule was FOLLOWED, not set aside** — `DOCUMENTATION_BASELINE.md` L253 says *"do not choose — raise it"*, and this section **raised** all three rather than choosing; they were then chosen by the owners who could. **Architecture closure is still not conferred here**, and `ADR-0062` **opened two new gaps** (`SECP-GAP-046`, `047`). *Prior text retained verbatim:* **Three conflicts remain OPEN**, each routed to a named owner: `SECP-GAP-023` (Rank 1 `MP-RSK-01` Critical vs Rank 6 EA V2), `SECP-GAP-031` (Rank 3 FROZEN `AUTH-11.26`…`11.28` vs Rank 6 EA V2), `SECP-GAP-042` (`platform/security` has no block in `tool/module_dependencies.yaml` while `default_decision: deny` stands → `SECP-ADR-004`). `DOCUMENTATION_BASELINE.md` L253: *"A conflict is a defect. If you find one, do not choose — raise it"* |
| ⛔ **Close any `SECP-GAP-*`** | ⚠ **STILL TRUE IN SUBSTANCE, and the COUNT has risen rather than fallen — recorded because the intuitive direction is the wrong one.** **All 47** `SECP-GAP-*` remain **OPEN** as of 2026-08-21: the **44** counted here plus **`SECP-GAP-045`** (`ADR-0060` — no exemption instrument exists in the governance set), **`SECP-GAP-046`** and **`SECP-GAP-047`** (`ADR-0062`). Revised severity split: **22 High · 23 Medium · 2 Low**. ⚠ **Not one gap was closed by the freeze**, and `ADR-0064` §8 admits all 47 OPEN — *a specification admitted to the baseline is not a specification with its questions answered*. **Stage 5 closes the registration, not the gaps — and neither does Stage 7.** *Prior text retained verbatim:* All **44** remain **OPEN** after this registration — 22 High, 20 Medium, 2 Low. Stage 5 closes the *registration*, not the gaps |
| ⛔ **Issue any `SECP-INV-*`, `SECP-EVT-*` or `SECP-CFG-*` member** | All three registers are **declared empty with published reasons** (§2N.0). Minting an `SECP-EVT-*` member would assert a producer edge BC Map L292 says does not exist; minting a `SECP-CFG-*` member would create the second source of truth Stage 4's check D5 forbids |
| ⛔ **Extend a closed register** | `SECP-HRO-*`, `SECP-SIG-*`, `SECP-SEV-*` and `SECP-TST-*` are closed. §5 rule 6 requires an **ADR** to extend any of them |
| **Allocate an `IMPL-*` range** | Stage 6, recorded separately. The next free block is **`IMPL-1300`+**, established by measurement — `PRD-017_IMPLEMENTATION_TASKS.md` **L98 reads `\| IMPL-1300 + \| Unallocated \| — \|`**, with `IMPL-1261`…`1299` reserved as `PRD-017`'s growth. ⚠ **Not** taken from `PRD_LIFECYCLE.md` L147–153, whose table is **stale** (it still reads `IMPL-227+`) and which `PRD-017` also declined to follow. Rule 1: *"Never reuse or reassign a number"* |
| **Add any integration edge, or amend any BC Map cell** | `PRD-012a` creates **0** edges and amends **0** cells. The BC Map carries **26 `E-nn`** rows before and after this registration |
| **Re-issue the baseline identifier** | ⚠ **SUPERSEDED 2026-08-21 as to its premise, UNCHANGED as to its rule.** The identifier **has** advanced to **`BASELINE-2026-08-21-A`** (superseding `BASELINE-2026-08-20-C`) — but **not by this section, and not because this matrix changed.** §7 rule 4 was applied exactly as quoted: a **Rank 1–3** document changed state, namely `PRD-012a` entering at **Rank 3**, and `ADR-0064` §4 item 3 records that the advance *"is owed to `PRD-012a` alone"*. ⚠ **The premise that failed is the middle clause, twice over**: `PRD-012a` no longer *"holds no rank at all"* (it holds Rank 3) and is no longer `DRAFT` (it is `FROZEN`) — though it **is still at v0.8**, the version being **deliberately not incremented** as the sixth v0.x admission (`ADR-0020` §4 item 2 — *freeze does not renumber*). ⚠ **This matrix remains UNRANKED**, so its own edits — including this one — **do not and cannot** move the identifier; the four new ADRs did not move it either, because *"an ADR being **added** is not a Rank 1–3 document **changing version**."* *Prior text retained verbatim:* `DOCUMENTATION_BASELINE.md` §7 rule 4 moves it only when a **Rank 1–3** document changes version. `PRD-012a` holds **no rank at all**, is `DRAFT` at v0.8, and this matrix is **unranked** |
| **Touch any existing section or any ADR** | ⚠ **TRUE OF THE STAGE 5 PASS THAT WROTE IT; the Stage 7 pass that followed DID touch three of these, and says so rather than leaving the sentence to be read as still current.** §2 through §2M remain **byte-unchanged** and **no ADR file was modified** — both still hold. But `DOCUMENTATION_BASELINE.md` and `PRD_REGISTRY.md` **were edited** on 2026-08-21 to carry the admission (baseline §3.1/§3.3/§4/§6/§8 and header; registry §4.1/§7/§10), and the ADR count is **64 files**, not 59 — **five were ADDED** (`ADR-0060`…`ADR-0064`), which is why *"all 59 ADR files"* no longer names the set. ⚠ **Adding a file is not touching an existing one**: the **51 Accepted / 13 Proposed** split moved only by the five additions, and **no pre-existing ADR was promoted, demoted, superseded or deprecated**. ⚠ **This §2N.2 correction pass touches §2N.2, the version field and one change-history row — and nothing else in this matrix.** *Prior text retained verbatim:* §2 through §2M are **byte-unchanged**, as are `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md` and all **59** ADR files. This pass appends §2N, one version field and one change-history row |

### 2N.3 Stage 5 exit gate — mechanically verifiable

`PRD_LIFECYCLE.md` L123–126: *"prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified
mechanically, **zero collisions**. Mechanical means **counted by a tool, not by reading**."*

| Gate clause | How satisfied | Evidence |
|---|---|---|
| Registered in §2 | **§2N**, appended before §3 Chapter map | This section exists |
| With counts **and** ranges | 15 rows + Total, each carrying a count **and** a range | §2N.0 |
| Verified **mechanically** | Register census by **distinct-token** scan across all 8 Parts; contiguity computed per register; **427 / 15 / all contiguous** | §2N.3.1 |
| **Zero collisions** | Four directions, each measured separately | §2N.1 |

#### 2N.3.1 The measurements, published with their method

| Measurement | Method | Result |
|---|---|---|
| Register census | distinct-token scan `SECP-([A-Z]+)-(\d{3})` over all 8 Parts, deduplicated per register | **15 registers, 427 identifiers** |
| Contiguity | for each register, `set(1..max) - observed` | **0 holes in 15 of 15** |
| Duplicate declarations | count of identifiers declared in more than one Part | **0** |
| Phantom identifiers | for each register, probe `max+1` — 15 probes | **0 hits on all 15** |
| Acceptance coverage | **paragraph-aware** binding scan, `SECP-FR-*`/`SECP-BR-*` → `SECP-AC-*` | **109 / 109 bound, 0 uncovered** |
| Prohibited absolute claims | 6 phrasings, all 9 hits inspected individually | **9 hits, every one a negation or prohibition — 0 claims** |
| Fenced code blocks | ``` count per Part | **0** in all 8 |
| `SECP-*` outside the owning directory | 15 per-register probes | **0** |

⚠⚠ **The phantom probe is not decoration — it has caught a real defect in this document twice.** Part 4's first draft
wrote a reserved placeholder one past its declared functional maximum, and Part 7's first draft wrote a "not declared"
annotation one past its declared exclusion maximum. Worse, the **paragraph that codifies the rule against phantoms
(`SECP-BR-025`) had itself written one** — the disclosure explaining why a token must not be written had written the
token. Both were removed, and Part 8 §1.3 now describes their *positions* without reproducing the tokens.

#### 2N.3.2 ⚠ Why the coverage measurement must be paragraph-aware

A **line-scoped** coverage check produces **false negatives** against this document, and it has done so twice on
different reviewers' instruments. Criteria wrap onto continuation lines:

```
**`SECP-BR-002`** — … the outcome **MUST** be denial. *(Cites `AUTH-2.26`…)* — verified by
**`SECP-AC-023`**.
```

The binding sits on the **next physical line**. A line-scoped scan reports `SECP-BR-002` and `SECP-BR-003` uncovered;
both reports are **false**. The paragraph-aware scan returns **0 uncovered**.

`SECP-AC-124` makes re-measurement a standing obligation, and its wording records why: *"The check is re-run after
any amendment, **because this criterion has already failed once against this document**."* It did fail once — against
`SECP-FR-084`, which Part 8 found unbound **while §5 already claimed zero uncovered**. `SECP-AC-128` was added to
close it and every dependent count corrected (426→427, 127→128). **The document that asserts coverage introduced the
coverage defect**, which is exactly why the assertion is trustworthy only once measured.

### 2N.4 Three defects the instruments found **in themselves**, recorded rather than quietly patched

§2H.2 names the failure mode: *"a checker written in the same pass as the register it checks, by the same author,
verifies agreement with itself."* Three instruments used to produce this registration were **defective, and all three
failed in the direction of accusing the subject.**

| # | Instrument | False result | Real cause |
|---|---|---|---|
| **`I-1`** | Testability regex | **44 requirements** "lack a normative keyword" | Recognised only the bold ``**`ID`**`` form; missed the `` `ID` — `` prose form used throughout Parts 3–7. Spot-checks showed `SECP-FR-019` carries **SHALL** and `SECP-XC-020` carries **MUST NOT** |
| **`I-2`** | Line-scoped coverage check | `SECP-BR-002`, `SECP-BR-003` "uncovered" | Continuation-line bindings — §2N.3.2. Part 8 §5 had **already documented this exact false-negative class** before the instrument was written |
| **`I-3`** | Definition locator | `SECP-BR-004` "has no definition" | Defined as *"**Closure rule — `SECP-BR-004`:**"* at Part 2 L222, a legitimate variant heading form |

**In all three cases the instrument was corrected and the subject left untouched.** Had any been trusted, this
registration would have published corrections to 44 already-correct requirements, two unnecessary criteria, and one
business rule wrongly reported as undefined. A first per-Part count also produced a **false mismatch** on Parts 1–2
by assuming Part 1 opened the functional register; it does not (§2N.0.1). **Four instrument defects, zero subject
defects — the ratio is the finding.**

---

## 2O. `PRD-020` Trust & Safety — `TSF-*` identifier inventory

| Field | Value |
|---|---|
| **Subject** | `PRD-020` Trust & Safety, **v0.5 `DRAFT`, Unranked** — `docs/30-product/trust-safety/PRD-020_TRUST_AND_SAFETY.md`, sha256 `685fb65af95668df9bce8757bcd7d04ec9838a56f8dd108652e80d7e7579497b`, 226,262 bytes. ⚠ **The header reads v0.1 and the content is v0.5**; the subject's own §0 records the four re-measurement passes. This registration does **not** correct that header — amending the subject's version is a **document-owner act**, and the discrepancy is published here rather than silently normalised |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` L122–137) |
| **Prefix stem** | **`TSF-`** — measured free in four directions before use; see §2O.1 |
| **Registers** | **9** |
| **Identifiers** | **400**, every register contiguous from `001` to its stated maximum |
| **Normative requirements** | **187** (`TSF-FR-*` 146 + `TSF-BR-*` 41) |
| **Acceptance criteria** | **62** — coverage **76/187 = 40.6%**, ⚠ **111 uncovered, named by register in §2O.2**. ⛔ **This is NOT the 109/109 of §2N and is not presented as such** |
| **Collisions** | **ZERO**, measured in **four** directions — §2O.1 |
| **Registered at** | `940f78a47e9561709a9b674ee8c3b4a8d0107a04` |
| **Instruments** | [`../../tool/docs_check/prd020_traceability.py`](../../tool/docs_check/prd020_traceability.py) (subject) and [`../../tool/docs_check/prd020_stage5.py`](../../tool/docs_check/prd020_stage5.py) (this section). **Neither imports the other**; both recompute 400 independently |
| **⛔ What this registration does NOT confer** | **Rank, freeze, `IMPL-*` allocation, architecture closure, gap closure, or `READY`.** See §2O.3. **All 16 `TSF-GAP-*` remain OPEN**, including the implementation half of `TSF-GAP-003`, which `TSF-BR-033` makes a bar to `READY` |

### 2O.0 The inventory

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `TSF-FR-NNN` | Functional requirement | **146** | `001`…`146` | ✅ | `147` |
| `TSF-BR-NNN` | Business rule | **41** | `001`…`041` | ✅ | `042` |
| `TSF-XC-NNN` | Exclusion / negative constraint | **70** | `001`…`070` | ✅ | `071` |
| `TSF-INV-NNN` | Invariant enforced inside the aggregate | **21** | `001`…`021` | ✅ | `022` |
| `TSF-EVT-NNN` | Published domain event | **2** | `001`…`002` | ⛔ **CLOSED** by BC Map §9 | ⛔ **none — ADR required** |
| `TSF-CFG-NNN` | Configurable | **30** | `001`…`030` | ✅ | `031` |
| `TSF-AC-NNN` | Acceptance criterion | **62** | `001`…`062` | ✅ | `063` |
| `TSF-GAP-NNN` | Open gap blocking implementation | **16** | `001`…`016` | ✅ | `017` |
| `TSF-RSK-NNN` | Risk | **12** | `001`…`012` | ✅ | `013` |
| **Total** | | **400** | | **9 of 9 contiguous** | |

⚠ **`TSF-EVT-*` is CLOSED at TWO members and the closure is an external fact, not an authorial choice.**
`PRD_LIFECYCLE.md` §5 rule 6: *"a register declared closed may not be extended without an ADR."* BC Map **L432**
and **L433** publish exactly two `BC-13` events — `safety.AbuseReportFiled` and `safety.EnforcementActionTaken` —
and BC Map §7's rule is that an integration surface absent from the register **does not exist**. A third event is a
**Rank 4 amendment requiring an ADR**, so none was invented. The subject records this as `TSF-GAP-004`.

⛔⛔ **The "next free" cell for `TSF-EVT-*` reads *none — ADR required*, and the first draft of this section got
that wrong in the most instructive way available.** It read `003` — the arithmetic answer — and
`prd020_traceability.py` **failed the run**, because the token one past the `TSF-EVT-*` maximum is not a defined
identifier and had just been written into the repository by the very section explaining that it may not exist.
⚠ **This paragraph deliberately does not reproduce that token either** — it describes its *position*, on the
`PRD-012a` Part 8 §1.3 remedy, because a disclosure that writes the phantom it discloses has not removed it. This is the
self-referential phantom §2N.3.1 records twice for `PRD-012a`, where *"the paragraph that codifies the rule
against phantoms had itself written one."* **It has now happened a third time, in a section whose author had read
that warning.** The cell states the governance answer, not the arithmetic one; `max+1` is a number, but a closed
register has **no next free member** until an ADR says so. Recorded as `I-4` in §2O.4.

⚠⚠ **No register is declared empty.** Unlike §2N (three empty registers) and §2M, every `TSF-*` register this
subject declares has members. There is therefore no `ADR-0051` §2.4 *"legal determination by a document with no
standing"* question in this module, and none is manufactured.

### 2O.1 Prefix collisions checked — in four directions

`PRD_LIFECYCLE.md` Stage 5 exists for the `PO-3`/`SPO-3` class of error, where *"citing `PO-3` when `SPO-3` was
meant would move a requirement from one bounded context to another."* A one-way check does not detect it.

| # | Direction | Method | Result |
|---|---|---|---|
| **(a)** | `TSF-` already used in this matrix | `grep -c 'TSF-'` over §2…§2N before this section was written | **0** — the stem was wholly unregistered; 400 identifiers were recorded nowhere |
| **(b)** | Another stem collides with `TSF-` | Every stem matching `[A-Z][A-Z0-9]{1,6}-(FR\|BR\|XC\|INV\|EVT\|CFG\|AC\|GAP\|RSK)-\d{3}` harvested from all of `docs/` and tested for prefix containment in **both** directions | **19 stems observed** — `AFIL ATT AUD CNF ENT FEE FIL ITG MM PROFIL SAAS SEAT SECP SID SM TEN TSF XCNF XFIL`. **0 collide with `TSF`**. ⚠ **This cell first read "20" against a list of 19 names, and the gate caught it** — recorded as `I-3` in §2O.4 |
| **(c)** | A near-miss stem is live | Probe `TS-`, `TSA-`, `TFS-`, `TNS-`, `TSFY-` against the same register suffixes | **0 hits on all five.** ⚠ The probe is only meaningful because it **does** match `TSF-` when the exclusion is removed — a negative that cannot go positive proves nothing |
| **(d)** | `TSF-*` defined outside `PRD-020` | Search every file under `docs/30-product/` except `trust-safety/` for a row-initial `` \| `TSF- `` definition | **0** |

⚠ **11 files outside the subject cite `TSF-*`, and NOT ONE is a collision.** They are `ADR-INDEX.md`,
`ADR-0065`, four `PRD-020_STAGE*` records, the `IMPL-1410` evidence record, `lib/bootstrap/di.dart`,
`lib/domain/social/messaging/enforcement_projection.dart` and `test/domain/social/messaging_enforcement_test.dart`.
All **28** distinct identifiers they cite **resolve to identifiers `PRD-020` defines** — **0 dangling**. This is
the §2C.1 principle applied: *a citation is not a collision*, and the gate resolves each hit against the defined
set rather than allow-listing files, so a genuinely foreign `TSF-*` **definition** in any of those same files would
still fail the run.

⚠⚠ **`TSF-` was NOT the naive choice, and the rejected one is worth recording.** The obvious stem for
*Trust & Safety* is `TS-`, which is two characters and collides with nothing today. It was rejected **before**
measurement, on §5 rule 3's reasoning rather than on a hit count: a two-letter stem has a far higher future
collision probability against a repository that already carries `SM-`, `MM-`, `TEN-` and `SID-`, and rule 3
directs that *"on collision change the NEW prefix, never the existing one"* — a rule whose cost falls entirely on
whichever document arrives second. **A stem chosen to survive is cheaper than a stem chosen to fit.**

### 2O.2 ⚠ Acceptance coverage is **40.6%**, and the 111 uncovered obligations are named rather than argued away

This is the **lowest coverage figure registered in this matrix**, and publishing it is the point. Measured
**paragraph-aware** — §2N.3.2 records that a line-scoped scan produces false negatives against wrapped criteria,
and that defect has bitten two different reviewers' instruments — and by **three** binding routes unioned
together: an `TSF-AC-*` row citing a requirement, a requirement stated in the same paragraph as a criterion, and
a §30 task row naming both a requirement and a criterion.

| Register | Total | Covered | Uncovered |
|---|---|---|---|
| `TSF-FR-*` | 146 | **63** | **83** |
| `TSF-BR-*` | 41 | **13** | **28** |
| **Class A total** | **187** | **76** | **111** |

⛔ **A low figure is not a failed gate, and the distinction is load-bearing.** Stage 5's gate is *"prefixes
registered … with counts and ranges, verified mechanically, zero collisions"* — **coverage is not in it**. The
precedent is settled in this matrix's own history: **§2E registered `PRD-007` at 73.4%**, **§2D registered
`PRD-005` at 60.1%**, **§2M registered `PRD-017` at 71.2%** and **§2C registered at 94.6%**. What Stage 5 forbids
is an *unmeasured* or *overstated* figure. `PRD-006` v1.0 published *"100% coverage"* against a true **49.1%**,
and §2F records that the correction was made by **extending an existing criterion, not by inventing one**.

⚠⚠ **The obvious "fix" — minting criteria until the ratio rises — is REFUSED here, and the refusal is the
finding.** 111 new `TSF-AC-*` would take the register from 62 to 173, make every count in this section wrong,
and satisfy a gate that was never asked. More seriously it would repeat the error Stage 4 caught in this very
module: `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §4 records a **retracted** finding in which a new `TSF-FR-*`
was nearly minted for `TSF-AC-010`, when **`TSF-FR-099` already stated the obligation** — a fix to one check that
would have broken another. **Minting identifiers to move a percentage is the same act at larger scale.** The
uncovered set is disclosed under `SID-4.56` (*"a rule that cannot be checked SHALL be treated as unmet"*) and is
`IMPL-1449`'s declared work: *"Full `TSF-AC-001`…`062` traceability sweep."*

### 2O.3 What this registration deliberately does **not** do

| # | Not conferred | Why not, and who could |
|---|---|---|
| 1 | **Rank** | Only `DOCUMENTATION_BASELINE.md` §3 admits a document to a rank. It contains **0** occurrences of `PRD-020`. **Governance Owner** |
| 2 | **Freeze / Stage 7** | `PRD_LIFECYCLE.md` §7 L294: *"No fast path. Stage 7 is not skippable."* **Governance Owner**, by an ADR of the `ADR-0053`/`0054`/`0064` form |
| 3 | **`PLANNED` → `DRAFT`** | `PRD_REGISTRY.md` **L320** still reads `PLANNED`. **L317** of that register is explicit that a status move *"is an amendment act requiring amendment authority, **not a side effect**"*. **Governance Owner**; the subject routes it as `TSF-GAP-013` |
| 4 | **Architecture closure** | `TSF-GAP-003`'s **architecture half** was closed by `ADR-0065` (Accepted). Its **implementation half is OPEN**, and no act in this section touches it. **Architecture Owner** |
| 5 | **Gap closure** | **All 16 `TSF-GAP-*` remain OPEN.** Not one is closed, narrowed or reworded by this registration |
| 6 | **`READY`** | `TSF-BR-033` and §24.2 **L2046** forbid `READY` while `TSF-GAP-003`'s implementation half is open. `IMPL-1410` is **built and tested** — see `PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md` — but *built* is not *closed*, and closing the half is an **Architecture Owner** act |
| 7 | **A baseline re-issue** | `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only on a **Rank 1–3 version change**. This matrix is **unranked**, so it confers nothing and re-issues nothing. The `Baseline` header field is deliberately **not** advanced, on the §2G precedent |

⛔ **Nothing outside this matrix was modified to produce this section.** `PRD-020` is **byte-unchanged** — sha256
`685fb65a…` before and after. No ADR file, no Rank 1–5 document, no `PRD_REGISTRY.md`, no
`DOCUMENTATION_BASELINE.md`, no `LIBOORA_BOUNDED_CONTEXT_MAP.md`, no `LIBOORA_MODULE_DEPENDENCY_MATRIX.md`, no
`tool/module_dependencies.yaml`, and **no Dart source** was touched.

### 2O.4 Why the two instruments can disagree — and the defect they found in **me**, not in the subject

`prd020_traceability.py` never opens this matrix; `prd020_stage5.py` never trusts the subject's §0.2 declaration
table except to contradict it. They agree on **400** by different routes. §2H.2 names the failure they exist to
avoid: *"a checker written in the same pass as the register it checks, by the same author, verifies agreement
with itself."*

⚠ **`prd020_stage5.py` was run BEFORE this section existed and exited 1** — *"has no `## 2O.` section"*. A gate
that cannot fail is not a gate.

| # | Instrument | False result | Real cause |
|---|---|---|---|
| **`I-1`** | Register census by **definition row** | `TSF-GAP-*` = **8**, against a subject declaring **16** | The scan counted row-initial and prose-initial definition forms. **8 of the 16 gaps are defined mid-sentence** — e.g. `` `TSF-GAP-009` **OPEN** — no referral transport exists… `` — a legitimate form the regex did not model. Re-measured by **distinct-token occupancy** rather than definition site: **16, contiguous**. ⛔ **Had the 8 been published, this section would have registered a false count for a live register** |
| **`I-2`** | `IMPL-*` phantom probe | `IMPL-1450` written *"one past the declared maximum"* | **Not a phantom.** L2434 reads *"`IMPL-1450`…`1499` **reserved** for the V2 community work of §25"* — a **range-boundary reservation**, which allocation rule 2 (*"leave the previous group room to grow"*) positively requires. The probe was right that the token exists and wrong about what it means. **Rejected as a finding** |
| **`I-3`** | §2O.1 direction (b), **written by hand** | *"**20** stems observed"* against a list naming **19** | ⛔ **A defect in THIS SECTION, not in an instrument and not in the subject.** The stem list was correct; the count beside it was not, and no human reader had caught it across a full drafting pass. `prd020_stage5.py` recomputed the stems and reported **19**. **A hand-written count adjacent to the evidence that contradicts it is the single easiest defect to introduce and the hardest to see** — which is why the gate recomputes rather than reads |
| **`I-4`** | §2O.0 *"next free"* column, **written by hand** | The `TSF-EVT-*` cell read `003` | ⛔⛔ **THE MOST INSTRUCTIVE DEFECT IN THIS PASS, and it is mine.** `TSF-EVT-*` is **CLOSED**; the arithmetic successor is a number, but a closed register has **no next free member** until an ADR confers one. Writing it **created a phantom identifier in the same table that declares the register closed**. `prd020_traceability.py` failed the run on it as a dangling reference. This is the **third** recorded instance of the self-referential phantom — §2N.3.1 records two in `PRD-012a`, one of them in *"the paragraph that codifies the rule against phantoms"* — and this one was written **by an author who had read that warning in this very file hours earlier**. Fixed in **three** places, not one: the cell now reads *"none — ADR required"*, the explanatory prose describes the token's **position** without reproducing it (the Part 8 §1.3 remedy), and **`prd020_stage5.py` now FAILS any closed register that publishes a numeric next-free cell**, so the class cannot recur silently |

**Four instrument-or-authoring defects, zero subject defects** — the same ratio §2M and §2N found, reached independently. In
all four cases **the instrument or this section was corrected and the subject left untouched.** ⚠⚠ **Note the
split: `I-1` and `I-2` are defects in instruments, but `I-3` and `I-4` are defects in THIS SECTION'S OWN PROSE,
caught by the instruments.** That is the ratio inverting, and it is worth recording plainly — the tools found two
of their own faults and two of mine. Had the gates been written after the section rather than before it, `I-3`
would have published a false stem count and `I-4` a phantom identifier, both inside a registration whose entire
purpose is to be countable. ⚠ `I-1` is a **recurrence**: the
identical mid-sentence-definition blind spot is recorded as `I-1` in
`PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` §5, where it falsely flagged `TSF-CFG-030` and `TSF-BR-030` as undefined.
**A disclosed defect that recurs in a later instrument is evidence the disclosure was not read — including by its
own author.**

---

## 2P. `PRD-021A` A1–A8 Library Community — eight-stem identifier inventory

| Field | Value |
|---|---|
| **Subject** | `PRD-021A` Library Community, **A1–A8, all `DRAFT`, all Unranked** — eight documents in `docs/30-product/social-graph/`, **11,617 lines**, sha256 recorded per part in §2P.5. ⚠ **This is the first registration in this matrix whose subject is EIGHT documents rather than one**, and the difference is load-bearing: eight documents mint eight stems, cite one another 253 times across part boundaries, and can therefore fail in a way no single-document registration can — by citing a sibling's identifier that the sibling never minted. That direction is measured in §2P.1 (e) and is **0** |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` L121–133) |
| **Prefix stems** | **8** — `LCM-` `LCF-` `LCR-` `LCG-` `LCO-` `LCS-` `LCN-` `LCT-`, each measured free in **five** directions before use; see §2P.1 |
| **Registers** | **105** |
| **Identifiers** | **1,982** — **104 of 105 registers contiguous** from `001` to their stated maximum. ⚠ **The one exception is deliberate, is A1's, and is NOT a defect**; see §2P.0's note and §2P.3 |
| **Normative requirements** | **757** (`*-FR-*` 710 + `*-BR-*` 47) |
| **Acceptance criteria** | **233** — coverage **206/757 = 27.2%**, ⚠⚠ **551 uncovered**. ⛔⛔ **This is the LOWEST coverage figure ever registered in this matrix, below §2O's 40.6%, and it is registered at its measured value rather than repaired to a flattering one.** See §2P.2 |
| **Collisions** | **ZERO**, measured in **five** directions — §2P.1 |
| **Registered at** | This commit |
| **Instruments** | [`../../tool/docs_check/prd021a_traceability.py`](../../tool/docs_check/prd021a_traceability.py) (subjects) and [`../../tool/docs_check/prd021a_stage5.py`](../../tool/docs_check/prd021a_stage5.py) (this section). **Neither imports the other**; both reach **105 / 1,982** by structurally different routes |
| **⛔ What this registration does NOT confer** | **Rank, freeze, `IMPL-*` allocation, architecture closure, gap closure, `READY`, or any status move.** See §2P.4. ⛔ **All 97 `*-GAP-*` remain exactly as their subjects left them** — not one is closed, narrowed or reworded here, including `LCG-GAP-001` and `LCG-GAP-006`, which A4 makes hard blockers |

### 2P.0 The inventory

⚠ Counted by **distinct-token occupancy**, not by definition site. §2O.4 defect `I-1` records a census that
counted definition rows and undercounted a live register by half, because members defined mid-sentence were
invisible to it. That defect was read before this section was written, and the census was written to avoid it.

**A1 — `LCM-` Library Community Membership foundation (19 registers, 462 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCM-AC-NNN` | Acceptance criterion | **60** | `001`…`060` | ✅ | `061` |
| `LCM-ADR-NNN` | ADR requirement | **2** | `001`…`002` | ✅ | `003` |
| `LCM-API-NNN` | API surface rule | **24** | `001`…`024` | ✅ | `025` |
| `LCM-AUTH-NNN` | Authorisation rule | **18** | `001`…`018` | ✅ | `019` |
| `LCM-BR-NNN` | Business rule | **18** | `001`…`018` | ✅ | `019` |
| `LCM-CFG-NNN` | Configurable | **14** | `001`…`014` | ✅ | `015` |
| `LCM-CHK-NNN` | Implementation checklist item | **30** | `001`…`030` | ✅ | `031` |
| `LCM-DEC-NNN` | Decision requiring an owner | **12** | `001`…`012` | ✅ | `013` |
| `LCM-FR-NNN` | Functional requirement | **66** | `001`…`067` | ⚠ **ONE number unassigned** — see the note below | `068` |
| `LCM-GAP-NNN` | Open gap | **8** | `001`…`008` | ✅ | `009` |
| `LCM-GWT-NNN` | Given/When/Then scenario | **32** | `001`…`032` | ✅ | `033` |
| `LCM-INV-NNN` | Invariant | **20** | `001`…`020` | ✅ | `021` |
| `LCM-NFR-NNN` | Non-functional requirement | **22** | `001`…`022` | ✅ | `023` |
| `LCM-OBS-NNN` | Observability obligation | **14** | `001`…`014` | ✅ | `015` |
| `LCM-RM-NNN` | Read-model rule | **28** | `001`…`028` | ✅ | `029` |
| `LCM-RSK-NNN` | Risk | **26** | `001`…`026` | ✅ | `027` |
| `LCM-SEC-NNN` | Security obligation | **20** | `001`…`020` | ✅ | `021` |
| `LCM-SIG-NNN` | Signalling / event prohibition | **14** | `001`…`014` | ✅ | `015` |
| `LCM-XC-NNN` | Exclusion / negative constraint | **34** | `001`…`034` | ✅ | `035` |

⚠⚠ **`LCM-FR-*` has 66 members across a range of 67, and the missing number is not written here.**
A1 §24 discloses the skip itself and states that the number *"is deliberately **not written out anywhere in this
document**, because reproducing an unassigned identifier in prose is exactly what makes a phantom look defined to a
grep-based or automated continuity check."* **This section is exactly such a downstream document**, so it records
the skip by **position** — the register resumes two numbers after `LCM-FR-046` — and never by token, on the
`PRD-012a` Part 8 §1.3 remedy that §2O.4 `I-4` applies. Both instruments hold the position **arithmetically**
(`A1_GAP_AFTER = 46`) for the same reason: a checker that writes the phantom while enforcing the rule against
phantoms has not enforced it. Measured: occurrences of that token in A1 = **0**, in this section = **0**, in both
instruments = **0**. ⛔ **The skip has NOT been closed by inventing a requirement to occupy the number, and NOT by
renumbering 048…067 downward.** Either would have been a Product Owner act; neither was available here.

**A2 — `LCF-` Community Feed & Content (16 registers, 319 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCF-AC-NNN` | Acceptance criterion | **36** | `001`…`036` | ✅ | `037` |
| `LCF-ADR-NNN` | ADR requirement | **7** | `001`…`007` | ✅ | `008` |
| `LCF-API-NNN` | API surface rule | **14** | `001`…`014` | ✅ | `015` |
| `LCF-AUTH-NNN` | Authorisation rule | **12** | `001`…`012` | ✅ | `013` |
| `LCF-BR-NNN` | Business rule | **13** | `001`…`013` | ✅ | `014` |
| `LCF-DEC-NNN` | Decision requiring an owner | **6** | `001`…`006` | ✅ | `007` |
| `LCF-DEP-NNN` | Dependency | **5** | `001`…`005` | ✅ | `006` |
| `LCF-EVT-NNN` | Published domain event | **6** | `001`…`006` | ⛔ **CLOSED** by `LCF-FR-104` | ⛔ **none — ADR required** |
| `LCF-FR-NNN` | Functional requirement | **110** | `001`…`110` | ✅ | `111` |
| `LCF-GAP-NNN` | Open gap | **14** | `001`…`014` | ✅ | `015` |
| `LCF-INV-NNN` | Invariant | **16** | `001`…`016` | ✅ | `017` |
| `LCF-NFR-NNN` | Non-functional requirement | **12** | `001`…`012` | ✅ | `013` |
| `LCF-RM-NNN` | Read-model rule | **5** | `001`…`005` | ✅ | `006` |
| `LCF-RSK-NNN` | Risk | **18** | `001`…`018` | ✅ | `019` |
| `LCF-SEC-NNN` | Security obligation | **16** | `001`…`016` | ✅ | `017` |
| `LCF-XC-NNN` | Exclusion / negative constraint | **29** | `001`…`029` | ✅ | `030` |

⛔⛔ **`LCF-EVT-*`'s next-free cell reads *none — ADR required*, and §2O.4 defect `I-4` is the reason it does.**
A2 `LCF-FR-104`: *"The event set SHALL be closed at these six. A seventh SHALL require a PRD…"* — and
`PRD_LIFECYCLE.md` §5 rule 6 makes extending a closed register an ADR act. The arithmetic successor is a number;
a **closed register has no next free member** until an ADR confers one, so writing that number would mint a phantom
inside the table that declares the register closed. That is precisely what §2O.0's first draft did for
`TSF-EVT-*`, and §2O.4 calls it *"the most instructive defect in this pass."* ⚠ **`prd021a_stage5.py` FAILS any
closed register that publishes a numeric next-free cell**, so the class cannot recur silently here either.
⚠ Separately, `LCF-RSK-001`, `-002` and `-014` are marked **RETIRED** by A2 with *"positions retained, never
renumbered"* — the register count above is **18 minted**, which is the number the matrix registers, because a
retired position is still an allocated number.

**A3 — `LCR-` Community Feed Ranking (12 registers, 234 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCR-AC-NNN` | Acceptance criterion | **22** | `001`…`022` | ✅ | `023` |
| `LCR-API-NNN` | API surface rule | **10** | `001`…`010` | ✅ | `011` |
| `LCR-BR-NNN` | Business rule | **15** | `001`…`015` | ✅ | `016` |
| `LCR-DEC-NNN` | Decision requiring an owner | **9** | `001`…`009` | ✅ | `010` |
| `LCR-FND-NNN` | Finding (measured observation) | **13** | `001`…`013` | ✅ | `014` |
| `LCR-FR-NNN` | Functional requirement | **101** | `001`…`101` | ✅ | `102` |
| `LCR-GAP-NNN` | Open gap | **10** | `001`…`010` | ✅ | `011` |
| `LCR-INV-NNN` | Invariant | **11** | `001`…`011` | ✅ | `012` |
| `LCR-NFR-NNN` | Non-functional requirement | **7** | `001`…`007` | ✅ | `008` |
| `LCR-RS-NNN` | Ranking signal | **9** | `001`…`009` | ✅ | `010` |
| `LCR-RSK-NNN` | Risk | **11** | `001`…`011` | ✅ | `012` |
| `LCR-XC-NNN` | Exclusion / negative constraint | **16** | `001`…`016` | ✅ | `017` |

**A4 — `LCG-` Community Groups & Roles (15 registers, 148 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCG-AC-NNN` | Acceptance criterion | **18** | `001`…`018` | ✅ | `019` |
| `LCG-ADR-NNN` | ADR requirement | **4** | `001`…`004` | ✅ | `005` |
| `LCG-BR-NNN` | Business rule | **1** | `001`…`001` | ✅ | `002` |
| `LCG-DEC-NNN` | Decision requiring an owner | **6** | `001`…`006` | ✅ | `007` |
| `LCG-DEP-NNN` | Dependency on another part | **10** | `001`…`010` | ✅ | `011` |
| `LCG-EC-NNN` | Edge case | **10** | `001`…`010` | ✅ | `011` |
| `LCG-FR-NNN` | Functional requirement | **27** | `001`…`027` | ✅ | `028` |
| `LCG-FS-NNN` | Fail-safe behaviour | **6** | `001`…`006` | ✅ | `007` |
| `LCG-GAP-NNN` | Gap | **14** | `001`…`014` | ✅ | `015` |
| `LCG-INV-NNN` | Invariant | **8** | `001`…`008` | ✅ | `009` |
| `LCG-NFR-NNN` | Non-functional requirement | **4** | `001`…`004` | ✅ | `005` |
| `LCG-OBS-NNN` | Observability obligation | **5** | `001`…`005` | ✅ | `006` |
| `LCG-RSK-NNN` | Risk | **10** | `001`…`010` | ✅ | `011` |
| `LCG-SEC-NNN` | Security obligation | **9** | `001`…`009` | ✅ | `010` |
| `LCG-XC-NNN` | Exclusion / negative constraint | **16** | `001`…`016` | ✅ | `017` |

⚠ **A4's gap register is `13 OPEN + 1 DEFERRED + 0 closed`**, not 14 open — `LCG-GAP-010` is deferred with a named
reason and two named owners. The distinction is not cosmetic: `PRD_LIFECYCLE.md` **L119** makes Stage 4's gate
*"conflicts closed **or explicitly deferred with a reason and an owner**"*, so a deferral **satisfies** that gate
where a bare open item does not. **This registration closes none of the 14.**

**A5 — `LCO-` Official Library Communication (13 registers, 330 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCO-AC-NNN` | Acceptance criterion | **21** | `001`…`021` | ✅ | `022` |
| `LCO-ADR-NNN` | ADR requirement | **4** | `001`…`004` | ✅ | `005` |
| `LCO-API-NNN` | API surface rule | **11** | `001`…`011` | ✅ | `012` |
| `LCO-AUTH-NNN` | Authorisation rule | **11** | `001`…`011` | ✅ | `012` |
| `LCO-DEC-NNN` | Decision requiring an owner | **8** | `001`…`008` | ✅ | `009` |
| `LCO-EC-NNN` | Edge case | **16** | `001`…`016` | ✅ | `017` |
| `LCO-FR-NNN` | Functional requirement | **133** | `001`…`133` | ✅ | `134` |
| `LCO-GAP-NNN` | Open gap | **26** | `001`…`026` | ✅ | `027` |
| `LCO-INV-NNN` | Invariant | **33** | `001`…`033` | ✅ | `034` |
| `LCO-NFR-NNN` | Non-functional requirement | **4** | `001`…`004` | ✅ | `005` |
| `LCO-RSK-NNN` | Risk | **12** | `001`…`012` | ✅ | `013` |
| `LCO-SEC-NNN` | Security obligation | **24** | `001`…`024` | ✅ | `025` |
| `LCO-XC-NNN` | Exclusion / negative constraint | **27** | `001`…`027` | ✅ | `028` |

⚠ **All 26 `LCO-GAP-*` are OPEN** — the subject's own footer records *"Gaps open — 26 of 26"*. This registration
leaves that figure exactly where it found it.

**A6 — `LCS-` Community Safety, Privacy & Moderation (11 registers, 147 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCS-AC-NNN` | Acceptance criterion | **20** | `001`…`020` | ✅ | `021` |
| `LCS-ADR-NNN` | ADR requirement | **1** | `001`…`001` | ✅ | `002` |
| `LCS-AP-NNN` | Authoring principle | **7** | `001`…`007` | ✅ | `008` |
| `LCS-DEC-NNN` | Decision requiring an owner | **3** | `001`…`003` | ✅ | `004` |
| `LCS-EDGE-NNN` | Edge case | **12** | `001`…`012` | ✅ | `013` |
| `LCS-FR-NNN` | Functional requirement | **78** | `001`…`078` | ✅ | `079` |
| `LCS-G-NNN` | Goal | **6** | `001`…`006` | ✅ | `007` |
| `LCS-GAP-NNN` | Open gap | **6** | `001`…`006` | ✅ | `007` |
| `LCS-NG-NNN` | Non-goal | **6** | `001`…`006` | ✅ | `007` |
| `LCS-OWN-NNN` | Ownership statement | **6** | `001`…`006` | ✅ | `007` |
| `LCS-SEC-NNN` | Security obligation | **2** | `001`…`002` | ✅ | `003` |

**A7 — `LCN-` Community Notifications (6 registers, 116 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCN-AC-NNN` | Acceptance criterion | **21** | `001`…`021` | ✅ | `022` |
| `LCN-ADR-NNN` | ADR requirement | **1** | `001`…`001` | ✅ | `002` |
| `LCN-DEC-NNN` | Decision requiring an owner | **3** | `001`…`003` | ✅ | `004` |
| `LCN-EVT-NNN` | Community event | **7 minted** — **3 ACTIVE, 4 WITHDRAWN** | `001`…`007` | ✅ **as minted** | ⛔ **none published here** — see below |
| `LCN-FR-NNN` | Functional requirement | **76** | `001`…`076` | ✅ | `077` |
| `LCN-GAP-NNN` | Open gap | **8** | `001`…`008` | ✅ | `009` |

⚠⚠ **`LCN-EVT-*` registers SEVEN, and the count deliberately does not fall to three.**
A7 **L870**: *"7 minted · 3 ACTIVE · 4 WITHDRAWN … Withdrawn by SD-1: 004, 005, 006, 007 — **identifiers retained,
never reused**."* `PRD_LIFECYCLE.md` **L258** §5 rule 5 is the authority: *"Numbers are never reused, even after
withdrawal. A withdrawn requirement is marked withdrawn."* A register that reported **3** would be reporting the
live set, not the allocated one, and would invite the next author to mint `004` a second time — which is the exact
harm rule 5 exists to prevent. ⛔ **This registration does not reinstate the four, does not renumber the three
survivors, and does not publish a numeric next-free cell**: A8 `LCT-CONF-001` records the seven-versus-six event
conflict as **RAISED, NOT RESOLVED** and routes it to `LCT-ADR-001`, so the number after `007` is an open
architecture question rather than an arithmetic one. ⚠ A7 also retains `LCN-FR-019`, `-020` and `-022` as **VOID**
rows for the same reason — positions held, never recycled.

**A8 — `LCT-` Technical & Production Architecture (13 registers, 226 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LCT-AC-NNN` | Acceptance criterion | **35** | `001`…`035` | ✅ | `036` |
| `LCT-ADR-NNN` | ADR requirement | **2** | `001`…`002` | ✅ | `003` |
| `LCT-AP-NNN` | Authoring principle | **7** | `001`…`007` | ✅ | `008` |
| `LCT-CONF-NNN` | Cross-part conflict | **2** | `001`…`002` | ✅ | `003` |
| `LCT-FR-NNN` | Functional requirement | **119** | `001`…`119` | ✅ | `120` |
| `LCT-G-NNN` | Goal | **6** | `001`…`006` | ✅ | `007` |
| `LCT-GAP-NNN` | Open gap | **11** | `001`…`011` | ✅ | `012` |
| `LCT-INV-NNN` | Invariant | **7** | `001`…`007` | ✅ | `008` |
| `LCT-NG-NNN` | Non-goal | **10** | `001`…`010` | ✅ | `011` |
| `LCT-OWN-NNN` | Ownership statement | **6** | `001`…`006` | ✅ | `007` |
| `LCT-R-NNN` | Rejected alternative | **8** | `001`…`008` | ✅ | `009` |
| `LCT-SEC-NNN` | Security obligation | **10** | `001`…`010` | ✅ | `011` |
| `LCT-XC-NNN` | Exclusion / negative constraint | **3** | `001`…`003` | ✅ | `004` |

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| **Total** | **105 registers across 8 stems** | **1,982** | | **104 of 105 contiguous; the 1 exception is A1's declared skip** | |

### 2P.1 Prefix collisions checked — in **five** directions

`PRD_LIFECYCLE.md` Stage 5 exists for the `PO-3`/`SPO-3` class of error, recorded at **L132** of this matrix and
quoted back at **L132** of the lifecycle: *"citing `PO-3` when `SPO-3` was meant would move a requirement from one
bounded context to another."* A one-way check does not detect it.

⚠ **§2O checked four directions. This subject requires a fifth**, because it is eight documents rather than one and
the four-direction test is blind to a sibling citing an identifier the owning sibling never minted.

| # | Direction | Method | Result |
|---|---|---|---|
| **(a)** | The eight stems already used in this matrix | Count `LC[MFRGOSNT]-[A-Z]+-\d+` over §2…§2O, before this section was written | **0 for all eight.** ⛔ **1,982 identifiers across 105 registers were recorded nowhere** — the exact condition Stage 5 exists to prevent |
| **(b)** | Another stem collides with one of the eight | Every stem matching `[A-Z][A-Z0-9]{1,6}-[A-Z]+-\d{3}` harvested from `docs/` and tested for prefix containment in **both** directions | **23 stems observed** — `A1 AFIL ATT AUD CNF ENT FEE FIL INV ITG LIB MM PROFIL SAAS SEAT SEC SECP SID SM TEN TSF XCNF XFIL`. **0 collide with any of the eight.** ⚠ **This cell first read "28" against a list of 28 names, and the recount caught it** — recorded as `J-5` in §2P.7. The **19** the gate reports is the same measurement scoped to this matrix before §2P; **29** is the same harvest with the digit-width anchor removed, adding `EDGE MP S3 S4 S5 S6`. **All three sets were containment-tested and all three return 0** |
| **(c)** | A near-miss stem is live | Probe `LC-`, `LCFG-`, `LCMS-`, `LCRS-`, `LCGS-`, `LCOS-`, `LCSS-`, `LCNS-`, `LCTS-`, `LCA-`, `LCB-`, `LCC-`, `LCD-`, `LCE-` against the same register suffixes | **0 hits on all fourteen.** ⚠ The probe is only meaningful because it **does** fire on the real stems when the exclusion is removed — `LCM` 881, `LCF` 4,609, `LCR` 2,686, `LCG` 369, `LCO` 609, `LCS` 255, `LCN` 249, `LCT` 314. *A negative that cannot go positive proves nothing*, and the control is published so the reader need not take the zeroes on trust |
| **(d)** | One of the eight stems **defined** outside its owning part | Every file under `docs/` and `lib/`/`test/` scanned for a definition of `LC[MFRGOSNT]-*`, resolved against the owning part's defined set, **excluding the ten superseded self-drafts** | **0 collisions. 8 unresolved foreign tokens, each inspected and each a citation or a reservation rather than a definition** — enumerated in §2P.6 |
| **(e)** | ⭐ **A part cites a sibling identifier the sibling never minted** | All **253** distinct cross-part citations among A1…A8 resolved against the owning part's occupancy set | **0 dangling.** ⚠ **This is the direction §2O did not need and this subject does**, and it is the one a single-document registration structurally cannot run |

⚠⚠ **`LCFG-` is the near miss worth naming, because it is real and it is already registered in this matrix.**
**L70** registers `` `LCFG-n` `` — *Library configurable*, 13 members — and a bare-substring search for `LCF`
**does** match `LCFG-13`. The stems are nevertheless disjoint **in shape**, verified both ways: `LCF-[A-Z]+-\d+`
does not match `LCFG-13`, and `LCFG-\d+` does not match `LCF-FR-001`. ⛔ **The residual hazard is not in the data
but in future instruments**, so it is recorded as an obligation rather than a clean bill: **any checker touching
this family must anchor on `LCF-` with the hyphen, never on `LCF`.** Both instruments in this registration do.
⚠ A1 `LCM-ADR-002` cites `LCFG-5` by name as an existing parameter it reuses — a citation, not a collision, and
the §2C.1 principle applies.

⚠ **The eight stems were not free-form choices and the naive alternatives were rejected before measurement.**
`LC-` alone is two characters and, on `PRD_LIFECYCLE.md` §5 rule 3's reasoning — *"on collision change the NEW
prefix, never the existing one"* — a short stem shifts the entire cost of any future collision onto whichever
document arrives second. The three-letter forms carry the part's subject in the third character (`M` membership,
`F` feed, `R` ranking, `G` groups, `O` official, `S` safety, `N` notifications, `T` technical), which is why
`LCS-` and `LCN-` do not collide despite both being safety-adjacent.

### 2P.2 ⚠⚠ Acceptance coverage is **27.2%** — the lowest in this matrix — and the 551 uncovered obligations are named rather than argued away

Measured **paragraph-aware** unioned with row-scoped: §2N.3.2 records that a line-scoped scan produces false
negatives against wrapped criteria, *"and that defect has bitten two different reviewers' instruments."*

| Part | Class A (`FR`+`BR`) | `AC` | Covered | Uncovered | Coverage |
|---|---|---|---|---|---|
| A1 `LCM-` | 84 | 60 | **41** | **43** | 48.8% |
| A2 `LCF-` | 123 | 36 | **38** | **85** | 30.9% |
| A3 `LCR-` | 116 | 22 | **29** | **87** | 25.0% |
| A4 `LCG-` | 28 | 18 | **10** | **18** | 35.7% |
| A5 `LCO-` | 133 | 21 | **16** | **117** | 12.0% |
| A6 `LCS-` | 78 | 20 | **18** | **60** | 23.1% |
| A7 `LCN-` | 76 | 21 | **31** | **45** | 40.8% |
| A8 `LCT-` | 119 | 35 | **23** | **96** | 19.3% |
| **Total** | **757** | **233** | **206** | **551** | **27.2%** |

⛔ **A low figure is not a failed gate, and the distinction is load-bearing.** Stage 5's gate is *"the PRD's
prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically, zero
collisions"* — **coverage is not in it**. The precedent is settled in this matrix's own history and was measured
before being relied on: **§2O registered `PRD-020` at 40.6%**, **§2E `PRD-007` at 73.4%**, **§2D `PRD-005` at
60.1%**, **§2M `PRD-017` at 71.2%**, **§2C at 94.6%**. What Stage 5 forbids is an **unmeasured or overstated**
figure — the `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%**.

⚠⚠ **The obvious "fix" is REFUSED here, and the refusal is the finding.** Minting 551 acceptance criteria would
take the register from 233 to 784, falsify every count in §2P.0, and satisfy a gate nobody asked for. §2O.2
refused the same move at a quarter of the scale and named why: *"Minting identifiers to move a percentage is the
same act at larger scale."* ⛔ **It would also be a Product Owner act.** The conferral behind this section is for
a **Stage-5 traceability act only**; writing 551 new obligations is authoring, not registering.

⚠ **A5's 12.0% is the lowest single figure and it is not anomalous — it is diagnostic.** A5 holds **133** `LCO-FR-*`
against **21** `LCO-AC-*` and **26 open gaps**, which is the profile of a part specified ahead of its acceptance
work rather than one with a measurement defect. It is disclosed under `SID-4.56` — *"a rule that cannot be checked
SHALL be treated as unmet"* — and routed to the Product Owner as existing open work, **not** closed here.

### 2P.3 What was preserved, and what preserving it cost

| # | Thing preserved | Authority | What the easy alternative would have been |
|---|---|---|---|
| 1 | **A1's single unassigned `LCM-FR` number** | A1 §24; `PRD-012a` Part 8 §1.3 | Mint a requirement to occupy it (Product Owner act, invents an obligation) or renumber `048`…`067` down by one (breaks every citation of those 20 identifiers across A2…A8) |
| 2 | **A1's unassigned number is not WRITTEN, even here** | A1 §24: *"deliberately not written out anywhere in this document"* | Quote the token while explaining it must not exist — the self-referential phantom §2N.3.1 records twice and §2O.4 `I-4` a third time |
| 3 | **A7's four withdrawn `LCN-EVT-*`** | `PRD_LIFECYCLE.md` **L258** §5 rule 5 | Report the register as **3** — arithmetically defensible, and it would free `004` for reuse, which rule 5 forbids precisely because a reused number silently retargets every historical citation |
| 4 | **A7's three VOID `LCN-FR-*` positions** | Same rule | Compact the register |
| 5 | **A2's closed `LCF-EVT-*` publishes no next free** | `LCF-FR-104`; §5 rule 6; §2O.4 `I-4` | Write the arithmetic successor — the exact defect §2O.4 calls *"the most instructive in this pass"* |
| 6 | **A2's three RETIRED `LCF-RSK-*` positions** | A2 §register summary: *"positions retained, never renumbered"* | Report 15 instead of 18 |
| 7 | **A8's `LCT-CONF-001` left RAISED, NOT RESOLVED** | A8 §15.3 routes it to A2's owner | Pick a winner between A7's seven events and A2's closure at six — an **Architecture Owner** act, and the conferral behind this section is not that |

### 2P.4 What this registration deliberately does **not** do

| # | Not conferred | Why not, and who could |
|---|---|---|
| 1 | **Rank** | Only `DOCUMENTATION_BASELINE.md` §3 admits a document to a rank, and **L139** of it still reads *"PRD-021A remains NOT READY / NOT FROZEN."* **Governance Owner** |
| 2 | **Freeze / Stage 7** | `PRD_LIFECYCLE.md` §7: *"No fast path. Stage 7 is not skippable."* `ADR-0082` records Stage 7 as **not enterable** for this subject. **Governance Owner** |
| 3 | **Stage 6 / `IMPL-*` allocation** | Stage 6's gate is at `PRD_LIFECYCLE.md` L137 and the next unallocated range is at **L153**. ⛔ **Not one `IMPL-` identifier is minted by this section**, and `prd021a_stage5.py` fails the run if one appears. **Not this act, and not this conferral** |
| 4 | **Architecture closure** | `LCT-CONF-001` is **RAISED, NOT RESOLVED**; `LCG-GAP-006` (*"no published contract mints or resolves `communityId`"*) is **OPEN**. **Architecture Owner** |
| 5 | **Gap closure** | **All 97 `*-GAP-*` stand as their subjects left them** — 8 `LCM` · 14 `LCF` · 10 `LCR` · 14 `LCG` (13 open + 1 deferred) · 26 `LCO` · 6 `LCS` · 8 `LCN` · 11 `LCT`. Not one is closed, narrowed or reworded |
| 6 | **`READY`** | `LCG-GAP-001` (*"no document allocates scope to Part A4"*) is a **Product Owner** blocker and is open |
| 7 | **A status move in `PRD_REGISTRY.md`** | A status move *"is an amendment act requiring amendment authority, **not a side effect**."* **Governance Owner** |
| 8 | **An ADR number for any `*-ADR-*` requirement** | A1 `LCM-FR-049`: *"The ADR number … SHALL be allocated by the Governance Owner. This document SHALL NOT mint one."* **21 `*-ADR-*` requirements are registered above; ZERO ADR numbers are minted here.** **Governance Owner** |
| 9 | **A baseline re-issue** | `DOCUMENTATION_BASELINE.md` §7 rule 4 moves the identifier only on a **Rank 1–3 version change**. This matrix is **unranked**, so it re-issues nothing; the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G precedent |

⛔ **Nothing outside this matrix was modified to produce this section.** All eight subjects are **byte-unchanged** —
sha256 recorded in §2P.5, identical before and after. No ADR file, no Rank 1–5 document, no `PRD_REGISTRY.md`, no
`DOCUMENTATION_BASELINE.md`, no `PRD_LIFECYCLE.md`, no bounded-context map, and **no Dart source** was touched.

### 2P.5 Subject hashes at registration

| Part | File | Lines | Bytes | sha256 |
|---|---|---|---|---|
| A1 | `PRD-021A_A1_LIBRARY_COMMUNITY_FOUNDATION_DRAFT_v0.2.md` | 1,532 | 112,505 | `4c6e0652f4ceb9ff488adf68ad1061e3392256e591197ee281d6bc10056849fb` |
| A2 | `PRD-021A_A2_LIBRARY_COMMUNITY_FEED_CONTENT_DRAFT_v0.8.md` | 1,959 | 133,400 | `1aca384098a7257449dc487a424d876515d9366ab85c6c74bc49621b980d685d` |
| A3 | `PRD-021A_A3_COMMUNITY_FEED_RANKING_DRAFT_v0.6.md` | 1,330 | 115,575 | `fd1a4ca0653f6a0402040aafe4e47594974380d4dec60a1651be7a70a666cffc` |
| A4 | `PRD-021A_A4_COMMUNITY_GROUPS_AND_ROLES_DRAFT_v0.1.md` | 766 | 45,397 | `95af7e30a58cbc37a65f00c86a902ec61fbedce0691b9c70c6e84d7794746f24` |
| A5 | `PRD-021A_A5_OFFICIAL_LIBRARY_COMMUNICATION_DRAFT_v0.1.md` | 1,964 | 105,474 | `44713670aa112e5a73123c226d381067e7d0b773de5e204d24430aa5678df492` |
| A6 | `PRD-021A_A6_COMMUNITY_SAFETY_PRIVACY_MODERATION_DRAFT_v0.1.md` | 1,188 | 76,841 | `b5e16450476fd3e535822fe01d917b5c582f0237004685c1b6d83f1b52c0d917` |
| A7 | `PRD-021A_A7_COMMUNITY_NOTIFICATIONS_DRAFT_v0.1.md` | 953 | 54,248 | `01097dc13691bbfcf647de802e7fbd22760d4e3cdcf942b2f4e44a923d46146d` |
| A8 | `PRD-021A_A8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` | 1,925 | 96,400 | `cf5670ad89c039e54d6be1ec0c31d93f66ae8492a030275ef01c8d6723dc8585` |
| | **Total** | **11,617** | **739,840** | |

⚠ **The eight are enumerated by name and never globbed.** `PRD-021A_A*_*DRAFT_v*.md` matches **eighteen** files —
the eight above plus **ten superseded drafts** (A2 v0.3…v0.7, A3 v0.1…v0.5) — and counting all eighteen yields
**25,230** lines against a true **11,617**. Both instruments enumerate explicitly for this reason.

### 2P.6 The eight foreign tokens — and why **none** is a collision, but **two** are findings

Direction (d) surfaced **8 tokens** carrying one of the eight stems in files outside their owning part. Each was
read **at its line**, on §2C.1's principle that *a citation is not a collision*.

| Token | Where | Reading at the line | Verdict |
|---|---|---|---|
| `LCF-GAP-015` | `ADR-0082` **L398**, **L434**, plus `ADR-INDEX.md` and three PRD-021A records | L398: *"New gap opened: ⛔ `LCF-GAP-015`"*; L434: *"Identifiers minted: ZERO (except `LCF-GAP-015`, §7, which records a found defect)"* | ⚠ **Not a collision — a genuine DRIFT finding.** The ADR minted a gap **one past A2 v0.8's maximum of `LCF-GAP-014`**, and A2 has not absorbed it. ⛔ **This registration counts 14, because 14 is what the subject defines**, and publishes the drift rather than reconciling it: absorbing an ADR-minted gap into a PRD is a **document-owner act** |
| `LCM-GAP-011` | `ADR-0083` **L12** | *"the `LCM-GAP-011`-adjacent window-boundary row"* | ⚠ **Not a collision — a second DRIFT finding.** A1's maximum is `LCM-GAP-008`. The ADR cites a number A1 does not define. **Published, not reconciled** |
| `LCN-EVT-008` | `ADR-0083` **L240** | *"`LCN-EVT-008` is the next free number. A2 is not expanded, and no seventh A2 event exists."* | ✅ **Not a collision and not a defect** — a **next-free reservation**, the form §2O.4 `I-2` inspected and **rejected as a finding**. ⚠ Note this section does **not** repeat that token in its own next-free cell, because A7's register is under an unresolved conflict |
| *A1's unassigned `LCM-FR` number* — **not reproduced here** | ⛔ `PRD-021A_STAGE4_CONFERRAL_2026-09-01.md` **L293** | Written three times, inside the row explaining that A1's gap must not be closed | ⛔⛔ **A PHANTOM, AND IT IS MINE** — see §2P.7 `J-1`. ⚠ This row names it by **position** (the number after `LCM-FR-046`) because writing it here would be the same defect one row further down |

**Per-stem resolution:** `LCF` 34 foreign files / 133 tokens / 5 unresolved · `LCG` 17 / 22 / 0 · `LCM` 14 / 52 / 2 ·
`LCN` 6 / 19 / 1 · `LCO` 13 / 16 / 0 · `LCR` 27 / 68 / 0 · `LCS` 10 / 19 / 0 · `LCT` 8 / 12 / 0. **509 files
scanned.** Every other token resolves to an identifier its owning part defines: **0 dangling**.

⚠ **`ADR-0080` **L193–196** already records `LCF-` and `LCR-` as *"✅ REGISTERED"* to A2 and A3.** That is an ADR's
note about prefix ownership, not a §2 matrix registration — **`grep -c 'LCF-' TRACEABILITY_MATRIX.md` returned
0** before this section. This section does not contradict `ADR-0080`; it performs the matrix act `ADR-0080`
assumed had a home.

### 2P.7 The defects these instruments found — including two in **me**

`prd021a_traceability.py` never opens this matrix; `prd021a_stage5.py` never trusts §2P.0 except to contradict it.
They agree on **105 / 1,982** by different routes. §2H.2 names the failure they exist to avoid: *"a checker written
in the same pass as the register it checks, by the same author, verifies agreement with itself."*

⚠ **`prd021a_stage5.py` was run BEFORE this section existed and exited 1** — *"has no `## 2P.` section — PRD-021A
A1–A8 registers 1982 identifiers across 105 registers NOWHERE."* **A gate that cannot fail is not a gate.**

⚠ **`prd021a_traceability.py` was mutation-tested in four independent ways and failed all four**, because a gate
that passes is only evidence if it could have done otherwise: removing the declared gap → *"LCM-FR: NON-CONTIGUOUS,
missing [47]"*; adding a fifth withdrawn A7 event → *"LCN-EVT-008 row is GONE"*; declaring `LCF-EVT` closed at five
→ *"declared CLOSED at 5 but reaches 006"*; moving the A1 gap position → three simultaneous failures including
*"the declared intentional gap has been FILLED."*

| # | Defect | False result | Real cause |
|---|---|---|---|
| **`J-1`** | ⛔⛔ **A1's unassigned `LCM-FR` number written into `PRD-021A_STAGE4_CONFERRAL_2026-09-01.md` L293** | The conferral record reproduced the identifier **three times**, in the very row explaining that the gap must not be closed | ⛔⛔ **THE MOST INSTRUCTIVE DEFECT IN THIS PASS, and it is mine.** A1 §24 withholds the number *"because reproducing an unassigned identifier in prose is exactly what makes a phantom look defined to a grep-based or automated continuity check"* — and a Stage-4 conferral record is **precisely** such a downstream document. A1's precaution was defeated by the document conferring its stage. Remedied at §2P.8 by the Part 8 §1.3 route: the row now states the **position**, not the token |
| **`J-1a`** | ⛔⛔ **THE SAME TOKEN, TWICE, IN §2P.6 AND §2P.7 — the rows disclosing `J-1`** | This section's first draft quoted the identifier in the §2P.6 evidence table and again in the `J-1` row above | ⛔⛔ **THE FIFTH RECORDED INSTANCE OF THE SELF-REFERENTIAL PHANTOM, and it is the worst-sited of the five.** §2N.3.1 records two in `PRD-012a` — one in *"the paragraph that codifies the rule against phantoms"* — §2O.4 `I-4` a third, `J-1` a fourth. This one was written **into the section that enumerates all four**, by an author who had just read and cited every one of them, while the same author's `A1_GAP_AFTER = 46` constant in both instruments existed specifically to make this impossible in code. ⚠⚠ **`prd021a_stage5.py` caught it, this author did not**, which is the entire argument for the two-instrument rule: *the disclosure of a phantom is not exempt from the rule against phantoms, and the author least able to see the violation is the one writing the disclosure.* ⛔ Repository occurrences are now **0**; the count is published at §2P.8 rather than asserted |
| **`J-2`** | §2P.0's `LCN-EVT-*` next-free cell, first draft | Read `008` | ⛔ **`I-4` recurring, in a section that cites `I-4` by name.** A7's event register is under `LCT-CONF-001` — **RAISED, NOT RESOLVED** — and `ADR-0083` L240 independently names `LCN-EVT-008` as next free. The number is defensible; publishing it **from this matrix** is not, because it would resolve by arithmetic a conflict A8 routed to an owner. The cell now reads *"none published here."* ⚠ **The disclosure above deliberately quotes the token only inside the `ADR-0083` row**, where it is that ADR's published reservation, and not in the cell |
| **`J-3`** | Register census by **glob** | 8 subjects → 18 files, 25,230 lines | `PRD-021A_A*_*DRAFT_v*.md` matches ten superseded drafts. Had the census run, A2's and A3's registers would have been reported at their **superseded** maxima. Fixed by explicit enumeration in both instruments — the §2O.4 `I-1` lesson (*count what the subject defines, by a method that models how it actually writes*) reappearing as a **file-selection** rather than a **regex** problem |
| **`J-4`** | Direction (c) probe, before the control was added | 14 zeroes | Not a wrong answer — an **unfalsifiable** one. Zeroes from a probe never shown to fire are indistinguishable from a broken probe. The control (`LCM` 881 … `LCT` 314) was added and is published beside the zeroes |
| **`J-5`** | §2P.1 direction (b), **written by hand** | *"**28** stems observed"* against a list naming **28** — both wrong | ⛔ **A defect in THIS SECTION, and it is `I-3` of §2O.4 recurring almost verbatim**, in a section that cites `I-3`. The count matched its list, which is what made it invisible: **both** came from an earlier harvest whose regex omitted the `\d{3}` anchor, admitting `EDGE MP S3 S4 S5 S6` — six tokens that are section numbers and register suffixes, not prefix stems. Re-measured by the §2O method: **23**. ⚠ **The remedy is not just the corrected number but the published disagreement**: all three harvests (19 matrix-scoped, 23 strict, 29 loose) are named with their scopes and **all three return 0 collisions**, so the collision claim does not depend on which harvest a reader reproduces. §2O.4 said it exactly: *"a hand-written count adjacent to the evidence that contradicts it is the single easiest defect to introduce and the hardest to see"* |
| **`J-6`** | §2P.0 `LCN-EVT-*` next-free, second look | The gate reported the non-numeric cell as a **failure**, because `LCN-EVT-*` is not closed by any rule | ✅ **The gate was right to ask and the cell was right to refuse — the INSTRUMENT was incomplete.** `NO_NEXT_FREE` modelled only *rule-closed* registers, and A7's is *conflict-suspended*: `LCT-CONF-001` is **RAISED, NOT RESOLVED** and routed to `LCT-ADR-001`, so `max+1` is an arithmetic answer to an open architecture question. ⚠ **The tempting fix was to write the number and satisfy the gate.** That is `I-4` exactly. The instrument was widened to model both grounds instead, each with its authority recorded in code |

**Six defects, ZERO subject defects** — the same ratio §2M, §2N and §2O reached independently, at twice the count.
⚠⚠ **Note the split: `J-3`, `J-4` and `J-6` are instrument defects; `J-1`, `J-1a` and `J-5` are defects in
GOVERNANCE PROSE** — one in a record already conferred and pushed, and two **inside this very section**. In all six
cases **the instrument or the record was corrected and the eight subjects were left untouched.** ⛔⛔ **Three of the
six (`J-1`, `J-1a`, `J-5`) are recurrences of defects this matrix had already disclosed and which this section
cites by name.** That is the finding worth keeping: *a disclosure that its own author has read, cited, and then
repeated is evidence that disclosure alone does not prevent the class — only an instrument that runs does.*

### 2P.8 The `J-1` remedy, applied and measured

`PRD-021A_STAGE4_CONFERRAL_2026-09-01.md` L293 is corrected **in place** by the `PRD-012a` Part 8 §1.3 route: the
row states the unassigned number's **position** relative to `LCM-FR-046` and no longer reproduces the token.
⛔ **Nothing else in that record is altered** — the conferral it carries is untouched, and correcting a phantom is
not re-conferring a stage. §2N's precedent governs the form: *"corrected, not rewritten."*

**Measured after the remedy** — occurrences of A1's unassigned identifier, repository-wide:

| Location | Before | After |
|---|---|---|
| A1 itself | **0** | **0** |
| `PRD-021A_STAGE5_READINESS_AUDIT_2026-09-01.md` | **0** (removed in that record's own §3.3) | **0** |
| `PRD-021A_STAGE4_CONFERRAL_2026-09-01.md` L293 | **3** | **0** |
| ⛔ **This section §2P** — §2P.6 evidence row + §2P.7 `J-1` row | **2** (`J-1a`) | **0** |
| Both instruments | **0** — held as `A1_GAP_AFTER = 46` | **0** |
| `lib/`, `test/` | **0** | **0** |
| **Repository total** | **5** | **0** |

⚠⚠ **The "before" column is the point of the table.** Five occurrences existed at the moment this section was
first drafted — three in a record already conferred and pushed, **two in the section disclosing them** — and the
repository total is now **0**, verified by `grep -rn` over `docs/`, `lib/`, `test/` and `tool/`. ⛔ **A1's own count
was 0 throughout.** The subject never wrote it; every occurrence was created downstream by the governance
apparatus built to protect it.

---

## 2Q. `PRD-021B` B0–B9 Social Graph, Discovery, Messaging — ten-stem identifier inventory

| Field | Value |
|---|---|
| **Subject** | `PRD-021B` Social Graph / Discovery / Messaging, **B0–B9, all `DRAFT`, all Unranked** — ten documents in `docs/30-product/social-graph/`, **6,613 lines / 352,765 bytes**, sha256 recorded per part in §2Q.4. ⚠ **This is the largest multi-document subject yet registered here** — ten documents, two more than §2P's eight — and the fifth collision direction §2P introduced is load-bearing again: the parts cite one another **196** times across part boundaries, and can fail by citing a sibling identifier the sibling never minted. That direction is measured in §2Q.1 (e) and is **0** |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` L121–133) |
| **Prefix stems** | **10** — `XPA-` `SGR-` `SSF-` `SDS-` `DRK-` `PYK-` `GLS-` `MSG-` `RTM-` `TPA-`, each measured free in **five** directions before use; see §2Q.1 |
| **Registers** | **113** |
| **Identifiers** | **1,300** — ⭐ **113 of 113 registers contiguous** from `001` to their stated maximum, **with no exception to preserve**; a stronger result than §2P's 104 of 105 |
| **Normative requirements** | **365** (`*-FR-*` 196 + `*-BR-*` 169) |
| **Acceptance criteria** | **242** — coverage **195/365 = 53.4%**, ⚠ **170 uncovered**. Registered at its measured value; see §2Q.2 |
| **Collisions** | **ZERO**, measured in **five** directions — §2Q.1 |
| **Registered at** | This commit |
| **Instruments** | Five scripts (census · collision · near-miss-with-controls · foreign resolution · trace legs). ⚠ **Deliberately NOT committed to `tool/docs_check/`** — see §2Q.6; the measurements are published with their rules and controls for independent reproduction instead |
| **Consolidated record** | [`../30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md`](../30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md) — verdict **PASS, 4 of 4 gate conjuncts**. ⚠ On the `DOCUMENTATION_BASELINE.md` **L199** principle, **this section IS the gate**; the record carries what does not belong in a register |
| **⛔ What this registration does NOT confer** | **Rank, freeze, `IMPL-*` allocation, architecture closure, gap closure, `READY`, or any status move.** See §2Q.3. ⛔ **All 30 own-stem `*-GAP-*` and 2 foreign gap citations remain exactly as their subjects left them**; **6 `XPB-CONF-*` and 2 `XPB-DRIFT-*` owner decisions remain OPEN**; `PRD-021` itself remains **`PLANNED`** at `PRD_REGISTRY.md` §4.2 **L321** |

⛔⛔ **The pre-commit measurement, published with its command, because it is the whole substance of the gate's
first clause:**

```
$ grep -c "PRD-021B" docs/40-implementation/TRACEABILITY_MATRIX.md
0
```

Ten further probes, one per stem, over the full 2,728 lines returned **0** for every one. **So 1,300 identifiers
across 113 registers were registered NOWHERE** — the exact condition Stage 5 exists to prevent, and the honest
pre-registration answer to this gate was **BLOCKED on that clause**.

### 2Q.0 The inventory

⚠ Counted by **distinct-token occupancy**, not by definition site — §2O.4 defect `I-1` and §2P.0's note. B0–B9
define register members in prose as well as in tables, so a definition-site census would have undercounted here
too.

**B0 — `XPA-` cross-part architecture and open decisions (4 registers, 22 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `XPA-ACGAP-NNN` | Acceptance-criteria gap | **3** | `001`…`003` | ✅ | `004` |
| `XPA-BND-NNN` | Boundary allocation | **6** | `001`…`006` | ✅ | `007` |
| `XPA-DEP-NNN` | Cross-part dependency | **6** | `001`…`006` | ✅ | `007` |
| `XPA-PREC-NNN` | Precedence rule | **7** | `001`…`007` | ✅ | `008` |

⚠ **B0 mints 0 `FR` and 0 `BR`, and this is not an omission.** B0 is the allocation part: its §2 capability matrix
is the **ownership allocation instrument** for the whole set (§2Q.1 (f)). It allocates and constrains rather than
requiring.

**B1 — `SGR-` social graph (14 registers, 183 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `SGR-AC-NNN` | Acceptance criterion | **30** | `001`…`030` | ✅ | `031` |
| `SGR-API-NNN` | API surface rule | **14** | `001`…`014` | ✅ | `015` |
| `SGR-BR-NNN` | Business rule | **18** | `001`…`018` | ✅ | `019` |
| `SGR-CACHE-NNN` | Cache rule | **6** | `001`…`006` | ✅ | `007` |
| `SGR-DM-NNN` | Data model element | **12** | `001`…`012` | ✅ | `013` |
| `SGR-EC-NNN` | Edge case | **18** | `001`…`018` | ✅ | `019` |
| `SGR-EVT-NNN` | Event | **8** | `001`…`008` | ✅ | `009` |
| `SGR-FR-NNN` | Functional requirement | **27** | `001`…`027` | ✅ | `028` |
| `SGR-GAP-NNN` | Gap | **3** | `001`…`003` | ✅ | `004` |
| `SGR-PERF-NNN` | Performance rule | **7** | `001`…`007` | ✅ | `008` |
| `SGR-PRV-NNN` | Privacy rule | **7** | `001`…`007` | ✅ | `008` |
| `SGR-SCOPE-NNN` | Scope allocation | **8** | `001`…`008` | ✅ | `009` |
| `SGR-SEC-NNN` | Security rule | **11** | `001`…`011` | ✅ | `012` |
| `SGR-XC-NNN` | Exclusion | **14** | `001`…`014` | ✅ | `015` |

**B2 — `SSF-` social safety (14 registers, 174 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `SSF-AC-NNN` | Acceptance criterion | **28** | `001`…`028` | ✅ | `029` |
| `SSF-API-NNN` | API surface rule | **10** | `001`…`010` | ✅ | `011` |
| `SSF-BR-NNN` | Business rule | **22** | `001`…`022` | ✅ | `023` |
| `SSF-CACHE-NNN` | Cache rule | **6** | `001`…`006` | ✅ | `007` |
| `SSF-DM-NNN` | Data model element | **10** | `001`…`010` | ✅ | `011` |
| `SSF-EC-NNN` | Edge case | **16** | `001`…`016` | ✅ | `017` |
| `SSF-EVT-NNN` | Event | **6** | `001`…`006` | ✅ | `007` |
| `SSF-FR-NNN` | Functional requirement | **27** | `001`…`027` | ✅ | `028` |
| `SSF-GAP-NNN` | Gap | **3** | `001`…`003` | ✅ | `004` |
| `SSF-PERF-NNN` | Performance rule | **6** | `001`…`006` | ✅ | `007` |
| `SSF-PRV-NNN` | Privacy rule | **8** | `001`…`008` | ✅ | `009` |
| `SSF-SCOPE-NNN` | Scope allocation | **6** | `001`…`006` | ✅ | `007` |
| `SSF-SEC-NNN` | Security rule | **10** | `001`…`010` | ✅ | `011` |
| `SSF-XC-NNN` | Exclusion | **16** | `001`…`016` | ✅ | `017` |

**B3 — `SDS-` student discovery (14 registers, 161 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `SDS-AC-NNN` | Acceptance criterion | **32** | `001`…`032` | ✅ | `033` |
| `SDS-API-NNN` | API surface rule | **4** | `001`…`004` | ✅ | `005` |
| `SDS-BR-NNN` | Business rule | **19** | `001`…`019` | ✅ | `020` |
| `SDS-CACHE-NNN` | Cache rule | **8** | `001`…`008` | ✅ | `009` |
| `SDS-DM-NNN` | Data model element | **6** | `001`…`006` | ✅ | `007` |
| `SDS-EC-NNN` | Edge case | **18** | `001`…`018` | ✅ | `019` |
| `SDS-FR-NNN` | Functional requirement | **17** | `001`…`017` | ✅ | `018` |
| `SDS-GAP-NNN` | Gap | **3** | `001`…`003` | ✅ | `004` |
| `SDS-IDX-NNN` | Index requirement | **10** | `001`…`010` | ✅ | `011` |
| `SDS-PERF-NNN` | Performance rule | **8** | `001`…`008` | ✅ | `009` |
| `SDS-PRV-NNN` | Privacy rule | **9** | `001`…`009` | ✅ | `010` |
| `SDS-SCOPE-NNN` | Scope allocation | **3** | `001`…`003` | ✅ | `004` |
| `SDS-SEC-NNN` | Security rule | **8** | `001`…`008` | ✅ | `009` |
| `SDS-XC-NNN` | Exclusion | **16** | `001`…`016` | ✅ | `017` |

**B4 — `DRK-` discovery ranking (14 registers, 133 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `DRK-AC-NNN` | Acceptance criterion | **26** | `001`…`026` | ✅ | `027` |
| `DRK-BR-NNN` | Business rule | **11** | `001`…`011` | ✅ | `012` |
| `DRK-CFG-NNN` | Configuration parameter | **8** | `001`…`008` | ✅ | `009` |
| `DRK-DET-NNN` | Determinism rule | **6** | `001`…`006` | ✅ | `007` |
| `DRK-EC-NNN` | Edge case | **12** | `001`…`012` | ✅ | `013` |
| `DRK-EVAL-NNN` | Evaluation rule | **5** | `001`…`005` | ✅ | `006` |
| `DRK-EXP-NNN` | Explainability rule | **6** | `001`…`006` | ✅ | `007` |
| `DRK-FR-NNN` | Functional requirement | **14** | `001`…`014` | ✅ | `015` |
| `DRK-GAP-NNN` | Gap | **5** | `001`…`005` | ✅ | `006` |
| `DRK-PRV-NNN` | Privacy rule | **5** | `001`…`005` | ✅ | `006` |
| `DRK-SCOPE-NNN` | Scope allocation | **5** | `001`…`005` | ✅ | `006` |
| `DRK-SEC-NNN` | Security rule | **4** | `001`…`004` | ✅ | `005` |
| `DRK-SIG-NNN` | Ranking signal | **10** | `001`…`010` | ✅ | `011` |
| `DRK-XC-NNN` | Exclusion | **16** | `001`…`016` | ✅ | `017` |

**B5 — `PYK-` student recommendations (16 registers, 135 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `PYK-AC-NNN` | Acceptance criterion | **24** | `001`…`024` | ✅ | `025` |
| `PYK-BR-NNN` | Business rule | **5** | `001`…`005` | ✅ | `006` |
| `PYK-CFG-NNN` | Configuration parameter | **7** | `001`…`007` | ✅ | `008` |
| `PYK-EC-NNN` | Edge case | **12** | `001`…`012` | ✅ | `013` |
| `PYK-FB-NNN` | Feedback rule | **6** | `001`…`006` | ✅ | `007` |
| `PYK-FR-NNN` | Functional requirement | **6** | `001`…`006` | ✅ | `007` |
| `PYK-FRQ-NNN` | Frequency rule | **6** | `001`…`006` | ✅ | `007` |
| `PYK-GAP-NNN` | Gap | **5** | `001`…`005` | ✅ | `006` |
| `PYK-POL-NNN` | Policy rule | **8** | `001`…`008` | ✅ | `009` |
| `PYK-PRS-NNN` | Presentation rule | **7** | `001`…`007` | ✅ | `008` |
| `PYK-PRV-NNN` | Privacy rule | **7** | `001`…`007` | ✅ | `008` |
| `PYK-SCOPE-NNN` | Scope allocation | **5** | `001`…`005` | ✅ | `006` |
| `PYK-SEC-NNN` | Security rule | **4** | `001`…`004` | ✅ | `005` |
| `PYK-SRC-NNN` | Source rule | **7** | `001`…`007` | ✅ | `008` |
| `PYK-SUP-NNN` | Suppression rule | **8** | `001`…`008` | ✅ | `009` |
| `PYK-XC-NNN` | Exclusion | **18** | `001`…`018` | ✅ | `019` |

⚠ **B5 carries the lowest per-part coverage in this registration — 2 of 11 FR+BR = 18.2%** — and it is
**diagnostic rather than anomalous**: B5's 24 acceptance criteria bind overwhelmingly to `PYK-POL-*`, `PYK-PRS-*`,
`PYK-SRC-*`, `PYK-FB-*` and `PYK-FRQ-*`, registers the FR+BR denominator excludes **by construction**. ⛔ **The
denominator was NOT widened to move the figure** — see §2Q.2.

**B6 — `GLS-` discovery scope (12 registers, 100 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `GLS-AC-NNN` | Acceptance criterion | **20** | `001`…`020` | ✅ | `021` |
| `GLS-BR-NNN` | Business rule | **8** | `001`…`008` | ✅ | `009` |
| `GLS-CFG-NNN` | Configuration parameter | **5** | `001`…`005` | ✅ | `006` |
| `GLS-DEF-NNN` | Definition | **6** | `001`…`006` | ✅ | `007` |
| `GLS-EC-NNN` | Edge case | **10** | `001`…`010` | ✅ | `011` |
| `GLS-FR-NNN` | Functional requirement | **11** | `001`…`011` | ✅ | `012` |
| `GLS-FUT-NNN` | Future consideration | **8** | `001`…`008` | ✅ | `009` |
| `GLS-GAP-NNN` | Gap | **3** | `001`…`003` | ✅ | `004` |
| `GLS-INV-NNN` | Invariant | **6** | `001`…`006` | ✅ | `007` |
| `GLS-SCOPE-NNN` | Scope allocation | **4** | `001`…`004` | ✅ | `005` |
| `GLS-SEC-NNN` | Security rule | **5** | `001`…`005` | ✅ | `006` |
| `GLS-XC-NNN` | Exclusion | **14** | `001`…`014` | ✅ | `015` |

**B7 — `MSG-` messaging (10 registers, 137 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `MSG-AC-NNN` | Acceptance criterion | **30** | `001`…`030` | ✅ | `031` |
| `MSG-API-NNN` | API surface rule | **14** | `001`…`014` | ✅ | `015` |
| `MSG-BR-NNN` | Business rule | **17** | `001`…`017` | ✅ | `018` |
| `MSG-CFG-NNN` | Configuration parameter | **6** | `001`…`006` | ✅ | `007` |
| `MSG-EVT-NNN` | Event | **1** | `001`…`001` | ✅ | `002` |
| `MSG-FR-NNN` | Functional requirement | **33** | `001`…`033` | ✅ | `034` |
| `MSG-GAP-NNN` | Gap | **2** | `001`…`002` | ✅ | `003` |
| `MSG-INV-NNN` | Invariant | **6** | `001`…`006` | ✅ | `007` |
| `MSG-SEC-NNN` | Security rule | **6** | `001`…`006` | ✅ | `007` |
| `MSG-XC-NNN` | Exclusion | **22** | `001`…`022` | ✅ | `023` |

⚠ **`MSG-GAP-002` names a live governance fact and it is registered rather than resolved**: `PRD-021` itself is
still **`PLANNED`** (`PRD_REGISTRY.md` §4.2 **L321**) while B0–B9 accumulate as drafts. That is a **Governance
Owner** matter and **not** a Stage 5 blocker — this gate asks whether prefixes are registered with counts and
ranges, not what status the parent PRD holds.

**B8 — `RTM-` realtime, media and safety (7 registers, 109 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `RTM-AC-NNN` | Acceptance criterion | **28** | `001`…`028` | ✅ | `029` |
| `RTM-BR-NNN` | Business rule | **20** | `001`…`020` | ✅ | `021` |
| `RTM-CFG-NNN` | Configuration parameter | **3** | `001`…`003` | ✅ | `004` |
| `RTM-FR-NNN` | Functional requirement | **30** | `001`…`030` | ✅ | `031` |
| `RTM-GAP-NNN` | Gap | **2** | `001`…`002` | ✅ | `003` |
| `RTM-SEC-NNN` | Security rule | **3** | `001`…`003` | ✅ | `004` |
| `RTM-XC-NNN` | Exclusion | **23** | `001`…`023` | ✅ | `024` |

**B9 — `TPA-` technical production architecture (8 registers, 146 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `TPA-AC-NNN` | Acceptance criterion | **24** | `001`…`024` | ✅ | `025` |
| `TPA-BR-NNN` | Business rule | **49** | `001`…`049` | ✅ | `050` |
| `TPA-FR-NNN` | Functional requirement | **31** | `001`…`031` | ✅ | `032` |
| `TPA-GAP-NNN` | Gap | **4** | `001`…`004` | ✅ | `005` |
| `TPA-GOAL-NNN` | Goal | **4** | `001`…`004` | ✅ | `005` |
| `TPA-INV-NNN` | Invariant | **8** | `001`…`008` | ✅ | `009` |
| `TPA-PRIN-NNN` | Principle | **9** | `001`…`009` | ✅ | `010` |
| `TPA-XC-NNN` | Exclusion | **17** | `001`…`017` | ✅ | `018` |

**Totals — 113 registers · 1,300 identifiers · 113 of 113 contiguous · 0 non-contiguous**

| Register class | Total | Register class | Total | Register class | Total |
|---|---|---|---|---|---|
| `AC` | **242** | `CFG` | 29 | `PREC` | 7 |
| `FR` | **196** | `DM` | 28 | `PRS` | 7 |
| `BR` | **169** | `PERF` | 21 | `SRC` | 7 |
| `XC` | **156** | `CACHE` | 20 | `BND` | 6 |
| `EC` | 86 | `INV` | 20 | `DEP` | 6 |
| `SEC` | 51 | `EVT` | 15 | `DET` | 6 |
| `API` | 42 | `IDX` | 10 | `EXP` | 6 |
| `PRV` | 36 | `SIG` | 10 | `FB` | 6 |
| `SCOPE` | 31 | `PRIN` | 9 | `FRQ` | 6 |
| `GAP` | 30 | `POL` | 8 | `DEF` | 6 |
| | | `SUP` | 8 | `EVAL` | 5 |
| | | `FUT` | 8 | `GOAL` | 4 |
| | | | | `ACGAP` | 3 |

**`FR` 196 + `BR` 169 = 365 normative requirements. 242 acceptance criteria.**

⚠ **113 `max+1` phantom probes were run — one per register — and returned 0 hits.** No part cites one past any
register's ceiling.

### 2Q.1 Collision freedom, six directions

Five directions follow §2O.1 as extended by §2P.1; a sixth is added because this subject allocates ownership.

| Dir | Question | Measured | Result |
|---|---|---|---|
| **(a)** | Is any of the ten stems already in this matrix? | 10 probes over 2,728 lines | **0** |
| **(b)** | Does any stem collide with a foreign stem in use? | **465 files**, **42** stems observed, **32** foreign, containment-tested **both ways** | **0 collide** |
| **(c)** | Does a near-miss variant resolve to anything? | **20** probes, each with a control | **0** |
| **(d)** | Does any part cite a foreign token resolving nowhere? | **89** distinct foreign tokens | **0 unresolved** |
| **(e)** | Does any part cite a **sibling's** identifier the sibling never minted? | **196** cross-part citations | **0** |
| **(f)** | Does any bounded context get claimed by **two** parts? | B0 §2 capability matrix, single-valued `Owner` column | **0 conflicts** |

The 32 foreign stems observed in (b): `A1` `AFIL` `ATT` `AUD` `CNF` `ENT` `FEE` `FIL` `INV` `ITG` `LCF` `LCG`
`LCM` `LCN` `LCO` `LCR` `LCS` `LCT` `LIB` `MM` `PROFIL` `SAAS` `SEAT` `SEC` `SECP` `SID` `SM` `TEN` `TSF` `XCNF`
`XFIL` `XPB`.

⚠ **Every zero in direction (c) is published beside the control that proves the probe fires** — §2P.1's `J-4` rule
that *a negative that cannot go positive proves nothing*:

| Probe | Hits | Control | Control hits |
|---|---|---|---|
| `XP-` | 0 | `XPA-` | **26** |
| `SG-` | 0 | `SGR-` | **343** |
| `SS-` | 0 | `SSF-` | **306** |
| `SD-` | 0 | `SDS-` | **361** |
| `DR-` | 0 | `DRK-` | **324** |
| `PY-` | 0 | `PYK-` | **305** |
| `GL-` | 0 | `GLS-` | **226** |
| `MS-` | 0 | `MSG-` | **347** |
| `RT-` | 0 | `RTM-` | **303** |
| `TP-` | 0 | `TPA-` | **260** |
| `XPAS-` `SGRS-` `SSFS-` `SDSS-` `DRKS-` `PYKS-` `GLSS-` `MSGS-` `RTMS-` `TPAS-` | **all 0** | as above | — |

⚠⚠ **`XPA-` / `XPB-` is the near miss worth naming, and it is this stage's own `PO-3`/`SPO-3`.** `XPA-` is B0's
stem (**26** strict-shape occurrences). `XPB-` is a **different family with 257**. Tested in both directions:
`XPA-[A-Z]{2,6}-\d{3}` does **not** match `XPB-CONF-001`, and `XPB-[A-Z]{2,6}-\d{3}` does **not** match
`XPA-PREC-001`; **containment collisions 0**. ⚠ **But a bare `'XP'` substring matches BOTH.** So this is recorded
as a measurement **plus a standing obligation** rather than a clean bill, on §2P's `LCFG-` precedent:

> **Any checker touching this family MUST anchor on `XPA-` with the hyphen — never on `XPA`, never on `XP`.**

⛔ **`XPB-` is NOT registered by this section, and that refusal is a finding — see §2Q.7.**

Direction **(f)**: B0 **§2** is the ownership allocation instrument — a 15-capability matrix whose `Owner` column
is single-valued and whose B1/B2/B3 columns carry ✅ owns / ▶ consumes / ⛔ must not touch; §2.1 allocates entity
ownership and §2.2 API ownership. **0 rows assign ✅ to more than one part.** ⭐ **B7 L34 is the affirmative
case**: it **declines** to confer ownership that `BC-12` already holds under FROZEN `PRD-020` §10 **L633–634**.

### 2Q.2 Coverage — 195/365 = 53.4%, with 170 uncovered

**Both trace directions were measured, including the unflattering one.**

| Direction | Measure | Result |
|---|---|---|
| **AC → requirement** | 242 ACs | **242 requirement-backed · 0 orphan ACs · 0 gap-backed · 0 dangling · 0 duplicate GWT triples** |
| **requirement → AC** | 365 FR+BR | **195 covered · ⚠ 170 UNCOVERED · 53.4%** |

Per part: B1 22/45 **48.9%** · B2 24/49 **49.0%** · B3 17/36 **47.2%** · B4 12/25 **48.0%** · B5 2/11 **18.2%** ·
B6 13/19 **68.4%** · B7 34/50 **68.0%** · B8 35/50 **70.0%** · B9 36/80 **45.0%** · B0 mints no FR/BR.

On this matrix's published ladder: §2C **94.6%** · §2E **73.4%** · §2M **71.2%** · §2D **60.1%** · **this
registration 53.4%** · §2O **40.6%** · §2P **27.2%**. Neither the highest nor the lowest; **registered at its
measured value**.

⛔⛔ **A DENOMINATOR TRAP WAS CAUGHT BEFORE PUBLICATION.** The count of distinct requirements cited by at least one
AC across the **full normative pool** is **375**; the coverage denominator is **365** (FR+BR only, §2P's
convention). Combining them yields **102.7%** — a coverage figure **above 100%**, manufactured by accident rather
than by measurement. Both figures now carry their denominator in the same sentence wherever they appear.

⛔ **The 170 uncovered requirements are NOT closed by minting criteria**, on four independent grounds: it would
take the AC register **242 → 412** and falsify every count in §2Q.0 **in the commit that publishes them**; it is a
**Product Owner** authoring act; **coverage is not in this gate** (*"prefixes registered … with counts and ranges,
verified mechanically, zero collisions"*); and §2O.2 names the act — *"minting identifiers to move a percentage is
the same act at larger scale."* §2P refused **551** on the same reasoning. ⛔ **Nor was the denominator widened**
to lift B5's 18.2%: *changing a denominator to move a number is the same act as minting criteria to move it.*

### 2Q.3 ⛔ What this registration does not confer

| # | Not conferred | Who could confer it |
|---|---|---|
| 1 | **Rank.** All ten remain **Unranked** | Governance Owner, by ADR |
| 2 | **Freeze.** Freeze is *conferred, not claimed* (`PRD_LIFECYCLE.md` **L161–164**) | Governance Owner, by ADR |
| 3 | **Stage 6.** No `IMPL-*` range, no task document, no task-to-requirement mapping | Governance Owner, per **L135+** |
| 4 | **`IMPL-*` allocation.** **0** `IMPL-*` identifiers written | Governance Owner |
| 5 | **Architecture closure.** 24 BCs cited of 31, 16 edges of 29, **0 created** | Architecture Owner, by ADR |
| 6 | **Gap closure.** All 30 own-stem gaps + 2 foreign gap citations stand as their subjects left them | Named owner per gap |
| 7 | **`READY` or any status move.** §2P.4 item 7: a status move *"is an amendment act requiring amendment authority, **not a side effect**"* | Governance Owner |
| 8 | **Owner-decision closure.** 6 `XPB-CONF-*` and 2 `XPB-DRIFT-*` remain **OPEN**; 3 `FOD-*` remain **OPEN** | Product / Architecture / Governance Owner |
| 9 | **An ADR number.** None is minted, and §2Q.5 measures that none is required | Governance Owner |

⛔ **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended:
ZERO. Gaps closed: ZERO. BCs, events, edges and APIs created: ZERO.**

### 2Q.4 Subject hashes — all ten byte-unchanged

| Part | Lines | Bytes | sha256 |
|---|---|---|---|
| B0 | 393 | 21,735 | `69dae44e5c8f99fa2fcae71d60f88fac7032ba116d9ba04280752f3c2ec94954` |
| B1 | 773 | 35,883 | `503c804504f2d04e315c0cf3c99d89e6465eaa1ef668e42e938db65db7532816` |
| B2 | 589 | 27,202 | `7339862f8cf9fc1174686126f3f49f441316f910352b37e0300f64b90c7963af` |
| B3 | 565 | 28,079 | `a3ccec3de060144efb932cdf7869c83c21b9a423d70854c6960017946953b533` |
| B4 | 601 | 36,490 | `429ed76f94042e8988391f6add4dad04ab0ed8afb931750bdc6012e969e2d0cd` |
| B5 | 533 | 31,864 | `2c8f1c3dba8840c18488d81b3e7397af54b05b301b8b73fba59453c375ebe5bc` |
| B6 | 426 | 24,316 | `1c481c6ae7557568d80e0a7156667d9132ef1a05ba812caa9be82e296f31137b` |
| B7 | 940 | 53,311 | `01e2a7fad860abe2a01398a6ac288f73e6532e9d69fcdee1ff99b7af4afc9b4a` |
| B8 | 810 | 45,340 | `a075ba341baa90037d0290c096f4bf886d9b622410c042f13791042f88506f22` |
| B9 | 983 | 48,545 | `21561f8b53af7602b0f04182645a75c6fff57226af61359f241054ace2d383a5` |

**All ten are identical to the bytes Stage 3 and Stage 4 measured.** ⚠ Stage 3 and Stage 4 recorded **6,603**
lines where this section records **6,613**: the difference is a **trailing-newline counting convention**, the
**hashes are identical**, and both conventions are published rather than one silently replacing the other.

### 2Q.5 Lawfulness of this edit — measured, not assumed

Three independent measurements, because the matrix's own self-description is not sufficient evidence about its
rank:

| # | Check | Finding |
|---|---|---|
| 1 | This matrix's header **L9** | *"this matrix is **unranked** — it confers nothing"* |
| 2 | Is it in `DOCUMENTATION_BASELINE.md` **§4**'s Rank 1–6 precedence table? | ⛔ **0 occurrences — absent** |
| 3 | Where is it listed instead? | **L216**, in **§3.4** *Configuration and implementation*, at **v1.1** |

`PRD_LIFECYCLE.md` **L164** quotes baseline §7 — *"A change to any Rank 1–5 document requires an ADR **before** the
change."* This matrix holds **no Rank 1–5 row**, so **L164 does not reach it**: ⛔ **no ADR is required for §2Q and
none is minted.** ⛔⛔ **Had §4 listed it at any rank, registration would have STOPPED and been returned to the
Governance Owner.**

⚠ **No baseline re-issue.** §7 rule 4 moves the identifier only on a **Rank 1–3** version change; this matrix is
unranked, so the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G/§2O/§2P precedent.

### 2Q.6 Foreign tokens and instrument disclosures

**89 distinct foreign tokens are cited; all 89 resolve; 0 unresolved:** `FEE-` 1 · `FIL-` 18 · `LCM-` 8 · `LCN-` 2
· `LCR-` 8 · `MM-` 4 · `TSF-` 31 · `XPB-` 17.

⚠ A minting test returned **15** declaration-shaped foreign lines. ⛔ **A count alone would have published a false
finding of foreign minting in eight files.** All 15 were **read at their line** (§2C.1): B2 **L353** and B5
**L249** quote `TSF-*` authority **verbatim**; B7 **L620** records `LCN-FR-019` as **`VOID`**; the remaining 12 are
`XPB-CONF-*` **disposition-table rows** (B7 **L882–887**, B8 **L762–766**, B9 **L934**). **Genuine foreign
minting: 0.**

⚠ **`LCM-FR-013` was explicitly verified and explicitly NOT applied — 0 occurrences in all ten parts** — and
`LCM-FR-012` was measured alongside it and is **also 0 of 10**, which shows the zero is not a suspicious
single-token gap. The 8 `LCM-*` tokens B0–B9 **do** cite (36 citations: `LCM-RM-006` 8 · `LCM-RM-025` 7 ·
`LCM-RM-021` 7 · `LCM-RM-023` 6 · `LCM-API-013` 4 · `LCM-RM-001` 2 · `LCM-XC-001` 1 · `LCM-RM-017` 1) all resolve
to A1, registered at §2P.

⚠ **The five instruments are deliberately NOT committed to `tool/docs_check/`.** Everything there runs in the
standing sweep, so committing five new checkers in the commit that registers §2Q would make this registration's
verdict depend on instruments it wrote and nobody reviewed — adding a standing checker is a **Governance Owner**
act. The measurements are published with their rules and controls for independent reproduction instead.

⚠ **`prd020_stage5.py` fails before and after this commit** on two pre-existing problems, and this commit is
expected to **enlarge both** (its *"§2\* line(s) outside §2O"* count and its 4-entry file list), because §2Q and
the consolidated record both cite `TSF-*`. Both are artefacts of its **leading-cell heuristic** (**L295–312**),
which cannot distinguish a citation from a definition. ⛔ **Two cheaper alternatives are refused by name**:
deleting true evidence rows, and editing the checker that judges a neighbouring registration — **§2H.2's named
failure**.

### 2Q.7 Defects — five instrument, zero subject, and one new finding

⚠ **FIVE instrument defects and ZERO subject defects — and two of the five are the SAME CLASS, caught twice in
one review by an author who had read §2O.4 `I-1` before starting.**

| # | Defect | Correction |
|---|---|---|
| `I5-1` | Gap-row census returned **57** against Stage 4's **56** | Re-measured under **four** explicit rules — **97** any-mention rows / **84** own-stem rows / **30** declaration rows / **56** Stage 4's rule — all correct for their rule; **the rule now travels with every number** |
| `I5-2` | Ownership probe found **6** `\| Owner \|` rows and declared 0 conflicts — **an unfalsifiable zero**, the §2P `J-4` class | Re-run against **B0 §2**, the actual allocation instrument, which *could* have produced a conflict: **0 rows assign ✅ twice** |
| `I5-3` | A row window reported **16** capability rows against a heading declaring **15** | ⭐ **The subject was right and the instrument wrong** — recorded rather than quietly adjusted |
| `I5-4` | A shell `\|\| echo 0` fallback **doubled** the `LCM-FR-013` output | Counts correct, presentation not; re-run cleanly, gaining the `LCM-FR-012` column the first pass lacked |
| `I5-5` | `XPA-`/`XPB-` reported as **26/257** in one pass and **40/259** in another | ⚠ **Not a scope difference but a RULE difference** — identical across `docs/`, `docs/+tool/` and all tracked files. **26/257 = strict identifier shape; 40/259 = bare stem literal.** Both published with their rule. **The fifth appearance of the `I5-1` class here** |

⭐⭐ **NEW FINDING `S5-F-1` — the ELEVENTH STEM, `XPB-`, WHICH NO PART OWNS.** B0's stem is `XPA-` (**26** strict
occurrences); `XPB-` has **257**, roughly ten times as many, and carries **19 identifiers** —
`XPB-CONF-001`…`017` (17, contiguous) and `XPB-DRIFT-001`…`002` (2, contiguous) — minted across **14 files
including `PRD_REGISTRY.md` (23 occurrences) and accepted `ADR-0091` (20)**, of which **six `XPB-CONF-*` are still
OPEN owner decisions**. ⛔⛔ **Its authoritative enumeration lives in a REVIEW RECORD** —
`PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1 L354** — **not in any PRD.** A review record is evidence
about a subject; it is not a subject.

⛔ **It is deliberately NOT registered here.** §2Q's subject is B0–B9, and `XPB-` is not B0's stem; registering
another document's family inside this one's registration would be **registration without a subject** and would
assert an ownership this registration has no authority to confer. **Routed to the Governance Owner, raised and not
resolved.**

### 2Q.8 Items registered as OPEN, none closed

`S5-F-1` (new) · `XPB-CONF-011` Help→Message · `XPB-CONF-013` `FIL-GAP-013` confinement · `XPB-CONF-014` read
receipts · `XPB-CONF-015` configurable retention · `XPB-CONF-016` message deletion · `XPB-CONF-017`
presence/typing · `XPB-DRIFT-001` EA wave drift · `XPB-DRIFT-002` `PRD_LIFECYCLE.md` **L96** mis-cites `X-13` ·
`FOD-1` · `FOD-2` · `FOD-3` · `MSG-GAP-002` · **170 uncovered requirements**.

⚠ **`FOD-4` is recorded as DISCHARGED BY B0 ITSELF** at B0 **L329–345** (*"Blocks B1/B2/B3 authoring? ⛔ No"*,
*"Blocks later implementation? ⛔ No"*) — **not** discharged by this registration.

⚠ Three carried-forward corrections are registered **recorded, NOT applied**
(`PRD-021B_STAGE3_RESOLUTION_AND_RE_REVIEW.md` §5 **L127–141**): `C-1` (B3 **L177–179**, `SDS-FR-003` cites `E-22`
wrongly), `C-2` (B3 **L154–162**, `SDS-FR-002` relabels FROZEN `PRD-020` §8.3 — ⛔ **`PRD-020` MUST NOT be
edited**) and `C-3` (B0 **L240**, chain link 2 incomplete authority). **All three are citation defects, not
requirement defects**, and none affects a count in §2Q.0.

---

## 2R. `PRD-021C` C0–C8 Library Marketplace — nine-stem identifier inventory

| Field | Value |
|---|---|
| **Subject** | `PRD-021C` Library Marketplace, **C0–C8, all `DRAFT`, all Unranked** — nine documents in `docs/30-product/library-marketplace/`, **6,023 lines**; per-part sha256 at §2R.4 |
| **Stage** | **5 of 9 — Traceability** (`PRD_LIFECYCLE.md` **L121–133**) |
| **Prefix stems** | **9** — `XPC-` `LMP-` `LSD-` `LPP-` `LSB-` `LRR-` `LDR-` `LTS-` `LMT-`, each measured free in **five** directions before use; see §2R.1 |
| **Registers** | **30** |
| **Identifiers** | **528** — ⭐ **30 of 30 registers contiguous** from `001` to their stated maximum, **with no exception to preserve** |
| **Normative requirements** | **258** (`*-FR-*` 220 + `*-BR-*` 38), counted on **own-stem occupancy**. ⚠ The whole-text figure is **263**; the two are different denominators and §2R.2 keeps them apart |
| **Exclusions** | **118** own-stem `*-XC-*` |
| **Acceptance criteria** | **123** — every one maps to at least one requirement (**123/123, 0 orphans**, Stage-4 check 4). Reverse coverage **210/258 = 81.4%**, ⚠ **48 uncovered**. Registered at its measured value; see §2R.2 |
| **Collisions** | **ZERO**, measured in **five** directions — §2R.1 |
| **Registered at** | This commit |
| **Stage 4** | ✅ **PASSED and CONFERRED** — [`PRD-021C_C0_C8_STAGE4_CONFERRAL.md`](../30-product/library-marketplace/PRD-021C_C0_C8_STAGE4_CONFERRAL.md), six of six checks, gate `L119` satisfied. This is the Stage-5 **entry** condition and it is met |
| **Instruments** | Six scripts (census/contiguity · collision · near-miss-with-controls · foreign-resolution · phantom-slot · coverage-with-denominator). ⚠ **Deliberately NOT committed to `tool/docs_check/`** — following §2Q, a one-off registration instrument that no gate runs is not a validator, and adding an unrun script to the suite implies coverage that does not exist |
| **Consolidated record** | [`../30-product/library-marketplace/PRD-021C_C0_C8_STAGE5_TRACEABILITY.md`](../30-product/library-marketplace/PRD-021C_C0_C8_STAGE5_TRACEABILITY.md) — verdict ✅ **PASS**, 4 of 4 gate conjuncts |
| **⛔ What this registration does NOT confer** | **Rank, freeze, `IMPL-*` allocation, architecture closure, gap closure, `READY`, or any status move.** See §2R.3. ⛔ **All nine parts remain `DRAFT` and Unranked; `PRD-021C` remains unadmitted to `DOCUMENTATION_BASELINE.md`** |

⛔⛔ **The pre-commit measurement, published with its command, because it is the whole substance of the gate's
first clause:**

```
$ grep -c "PRD-021C" docs/40-implementation/TRACEABILITY_MATRIX.md
0

$ for s in XPC LMP LSD LPP LSB LRR LDR LTS LMT; do \
    grep -cE "\b${s}-[A-Z]{2,6}-[0-9]{3}\b" docs/40-implementation/TRACEABILITY_MATRIX.md; done
0 0 0 0 0 0 0 0 0
```

⭐ **The instrument was proved live on the same run, because a probe that returns 0 because it is broken is
indistinguishable from one that returns 0 because the thing is absent.** The identical expression over stems
already registered here returned: `XPB` **6**, `MSG` **3**, `SGR` **1**, `TSF` **10**, `FIL` **16**.

**So 528 identifiers across 30 registers were registered NOWHERE** — the exact condition Stage 5 exists to
prevent, and the honest pre-registration answer to this gate was **BLOCKED on that clause**.

### 2R.0 The inventory

⚠ Counted by **distinct-token occupancy**, not by definition site — §2O.4 defect `I-1`, §2P.0's note and
§2Q.0's. C0–C8 define register members in **prose** as well as in tables, and a definition-site census
undercounted this subject too: the first pass over C1–C8 read **193** obligations against a true **258**,
because it required a table row. The corrected instrument is the one whose result is published here.

⚠⚠ **A second, sharper instrument defect was caught in this same pass and is disclosed rather than smoothed.**
A keyword scan for testability first flagged **34** obligations as carrying no normative verb. Every one of the
34 was either a `*-FR-001` or a register **maximum** — the signature of a **range-declaration row**
(`| `LMP-FR-*` | `LMP-FR-001` … `LMP-FR-024` | 24 | Yes |`), not of a definition. Excluding range rows reduced
the flag set to 16, and reading all 16 at their true definition sites resolved 14 outright. The lesson is §2Q's:
**a census that reads the first occurrence of an identifier will read its register header, not its meaning.**

**C0 — `XPC-` cross-part architecture and open decisions (2 registers, 29 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `XPC-CONF-NNN` | Cross-part conflict resolution | **19** | `001`…`019` | ✅ | `020` |
| `XPC-OD-NNN` | Open decision | **10** | `001`…`010` | ✅ | `011` |

**C1 — `LMP-` marketplace foundation (3 registers, 46 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LMP-FR-NNN` | Functional requirement | **24** | `001`…`024` | ✅ | `025` |
| `LMP-XC-NNN` | Exclusion | **10** | `001`…`010` | ✅ | `011` |
| `LMP-AC-NNN` | Acceptance criterion | **12** | `001`…`012` | ✅ | `013` |

**C2 — `LSD-` library search and local discovery (3 registers, 60 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LSD-FR-NNN` | Functional requirement | **32** | `001`…`032` | ✅ | `033` |
| `LSD-XC-NNN` | Exclusion | **12** | `001`…`012` | ✅ | `013` |
| `LSD-AC-NNN` | Acceptance criterion | **16** | `001`…`016` | ✅ | `017` |

**C3 — `LPP-` library public profile (3 registers, 83 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LPP-FR-NNN` | Functional requirement | **44** | `001`…`044` | ✅ | `045` |
| `LPP-XC-NNN` | Exclusion | **17** | `001`…`017` | ✅ | `018` |
| `LPP-AC-NNN` | Acceptance criterion | **22** | `001`…`022` | ✅ | `023` |

**C4 — `LSB-` live seat availability and booking (3 registers, 68 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LSB-FR-NNN` | Functional requirement | **36** | `001`…`036` | ✅ | `037` |
| `LSB-XC-NNN` | Exclusion | **14** | `001`…`014` | ✅ | `015` |
| `LSB-AC-NNN` | Acceptance criterion | **18** | `001`…`018` | ✅ | `019` |

**C5 — `LRR-` library ratings and reviews (4 registers, 54 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LRR-FR-NNN` | Functional requirement | **18** | `001`…`018` | ✅ | `019` |
| `LRR-BR-NNN` | Business rule | **8** | `001`…`008` | ✅ | `009` |
| `LRR-XC-NNN` | Exclusion | **16** | `001`…`016` | ✅ | `017` |
| `LRR-AC-NNN` | Acceptance criterion | **12** | `001`…`012` | ✅ | `013` |

⚠ **This part's subject is `Reviews & Ratings`, which `Library_PRD_v1.md` **L1016** fixes as **V2** and FROZEN.**
Registering C5's identifiers registers a **specification of a refusal**, not a V1 capability: `LRR-BR-006`
records that manipulation controls are *impossible, not deferred*, and `LRR-BR-008` records that determinism
holds **because** the rating input is absent. ⛔ Registration does not move the feature to V1.

**C6 — `LDR-` library discovery presentation (4 registers, 59 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LDR-FR-NNN` | Functional requirement | **22** | `001`…`022` | ✅ | `023` |
| `LDR-BR-NNN` | Business rule | **9** | `001`…`009` | ✅ | `010` |
| `LDR-XC-NNN` | Exclusion | **14** | `001`…`014` | ✅ | `015` |
| `LDR-AC-NNN` | Acceptance criterion | **14** | `001`…`014` | ✅ | `015` |

**C7 — `LTS-` marketplace trust and safety integration (4 registers, 55 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LTS-FR-NNN` | Functional requirement | **18** | `001`…`018` | ✅ | `019` |
| `LTS-BR-NNN` | Business rule | **9** | `001`…`009` | ✅ | `010` |
| `LTS-XC-NNN` | Exclusion | **15** | `001`…`015` | ✅ | `016` |
| `LTS-AC-NNN` | Acceptance criterion | **13** | `001`…`013` | ✅ | `014` |

**C8 — `LMT-` technical and production architecture (4 registers, 74 identifiers)**

| Register | Meaning | Count | Range | Contiguous | Next free |
|---|---|---|---|---|---|
| `LMT-FR-NNN` | Functional requirement | **26** | `001`…`026` | ✅ | `027` |
| `LMT-BR-NNN` | Business rule | **12** | `001`…`012` | ✅ | `013` |
| `LMT-XC-NNN` | Exclusion | **20** | `001`…`020` | ✅ | `021` |
| `LMT-AC-NNN` | Acceptance criterion | **16** | `001`…`016` | ✅ | `017` |

**Totals — 30 registers · 528 identifiers · 30 of 30 contiguous from `001`.**

| Part | Registers | Identifiers |
|---|---|---|
| C0 | 2 | 29 |
| C1 | 3 | 46 |
| C2 | 3 | 60 |
| C3 | 3 | 83 |
| C4 | 3 | 68 |
| C5 | 4 | 54 |
| C6 | 4 | 59 |
| C7 | 4 | 55 |
| C8 | 4 | 74 |
| **Total** | **30** | **528** |

### 2R.1 Collisions — ZERO, measured in five directions

The gate's operative words are **zero collisions**, and `PRD_LIFECYCLE.md` **L129–133** explains why one
direction is not enough: the `PO-*` / `SPO-*` near miss it records would have *"moved a requirement from one
bounded context to another"*, and it was not the kind of error careful reading catches.

| # | Direction | Instrument | Result |
|---|---|---|---|
| **a** | Do the nine stems already appear **in this matrix**? | `grep -cE` per stem over all 3,169 lines | **0** for all nine — with five live controls proving the expression works |
| **b** | Does any stem **contain or is contained by** a foreign stem, repo-wide? | Extracted every `STEM-XXX-NNN` token from **432** files under `docs/` and `tool/`; **51** distinct stems, **42** foreign; containment tested in **both** directions | **0 collisions** |
| **c** | Do near-miss stems exist that a careless citation could land on? | **20** deliberate probes — `XP` `XPCA` `LM` `LMPX` `LS` `LSDX` `LP` `LPPX` `LSBX` `LR` `LRRX` `LD` `LDRX` `LT` `LTSX` `LMTX` `LMTS` `LSDS` `LPPS` `LSBS` | **all 0** |
| **d** | Do the nine stems appear **outside** the subject directory, and if so is any of them a **definition**? | Scanned all 432 files excluding `docs/30-product/library-marketplace/` | **210 occurrences in 8 files** — ⭐ **0 definitions, 0 dangling.** All 210 are lawful **citations**; see below |
| **e** | Do the parts cite **each other's** identifiers correctly? | **385** cross-part sibling citations resolved against the authoritative register | **2 unresolved**, both the same token; see below |

**⭐ Direction (d), read rather than reported.** 210 occurrences is a large number and it was tested, not
assumed. The eight files are `ADR-INDEX.md`, `ADR-0093`, `ADR-0094`, `ADR-0095`, `ADR-0096`, `ADR-0097`,
`PRD_REGISTRY.md` and `LIBOORA_BOUNDED_CONTEXT_MAP.md` — precisely the instruments that **resolved C0's open
decisions** (`XPC-OD-002`, `-003`, `-007`). A definition site outside the owning part would be a genuine
collision; a citation is the system working. Measured: **0 definition sites, 0 citations of an identifier no
part defines.**

**⚠ Direction (e), the two unresolved citations — a carried defect, NOT a collision and NOT a phantom mint.**
Both occurrences are the same token, both in **C0**, and both are the withdrawn `LDR-FR` slot **023**. C0
**L128** describes it in terms of *"its **withdrawn** fallback slot as a bare … token, so a contiguity"*
check would see it. C6's `LDR-FR` register ends at **022**, and the count of that token **inside C6 is 0**.

⭐ **This is the identifier-tokenisation defect, and it is the sixth recorded instance in this engagement.** A
backtick-delimited identifier is greppable regardless of the prose around it, so **a disclosure that spells an
unminted slot in order to assert that it is unused makes every census counting that file read it as minted.**
It is carried as Stage-4 audit item **`S4-A-5`** and routed to the **Architecture Owner**. ⛔ It is **not**
cured here: curing it would edit C0, and this registration edits no subject.

**Phantom-slot probe.** For each of the 30 registers, the `max+1` token was searched across all nine parts —
the test for a requirement that is cited but never defined. **1 of 30 fired**, and it is the same withdrawn
slot as direction (e). The other **29** returned 0.

### 2R.2 Coverage — published with its denominator, in the same sentence

⚠⚠ **§2Q records that mixing denominators once produced a coverage figure ABOVE 100%, manufactured by
accident.** That failure mode is designed out here by never stating a percentage without the count it is over.

| Denominator | What it counts | Value |
|---|---|---|
| **A — own-stem** | `*-FR-*` + `*-BR-*` whose stem belongs to the part that defines them. **This is the register.** | **258** |
| **B — whole-text** | Every `*-FR-*`/`*-BR-*` token appearing anywhere in C0–C8, including **foreign** identifiers the parts lawfully cite | **263** |

**Reverse coverage — obligations exercised by at least one acceptance criterion:**

- Against **denominator A**: **210 of 258 = 81.4%**, ⚠ **48 uncovered.**
- Against denominator B, for disclosure only: **211 of 263 = 80.2%.**

**Forward coverage — acceptance criteria that cite at least one requirement: 123 of 123 = 100%, 0 orphans.**
⭐ That figure is Stage-4 check 4, and it reached 100% by **citation of existing requirements**, not by writing
new ones: the identifier count was **528 before and 528 after**, and the obligation count **258 before and 258
after**.

⛔ **The 48 uncovered obligations are registered at their measured value and NOT closed here.** Minting
acceptance criteria to raise the percentage is a Product Owner act and, per §2O.2, *"minting identifiers to move
a percentage is the same act at larger scale"*. ⛔ Nor is the denominator widened to flatter the ratio — B is
the larger number and is published only as a disclosure.

### 2R.3 ⛔ What this registration does NOT confer

| # | Not conferred | Who could, and how |
|---|---|---|
| 1 | **No rank.** All nine parts remain **Unranked** and `DRAFT`; `PRD-021C` is not in `DOCUMENTATION_BASELINE.md` §3.3 or §4 | Governance Owner, by ADR |
| 2 | **No freeze and no baseline re-issue.** Freeze is conferred, never claimed (`PRD_LIFECYCLE.md` **L161–164**) | Governance Owner, by ADR |
| 3 | **No `IMPL-*` allocation.** Stage 6's gate is *"an `IMPL-*` range allocated and a task document in which every task traces back to requirements"* — **0** `IMPL-*` exist for `PRD-021C`, and none is minted here | Technical Owner, at Stage 6 |
| 4 | **No architecture closure.** Bounded contexts remain **31**; edges **29** with slot 27 permanently vacant; **0** new BC, entity, event or edge is created by this registration | Architecture Owner, by ADR |
| 5 | **No gap or decision closure.** `XPC-OD-005` stays **DEFERRED — OPEN** with its owner role (**Privacy Owner**) **vacant as constituted**; `XPC-OD-010` stays **RESOLVED IN PART** with one half blocked upstream (`TSF-GAP-009`) | The named owners |
| 6 | **No coverage claim.** 48 obligations carry no acceptance criterion; `S4-A-5` is open | Product Owner / Architecture Owner |
| 7 | **No rank for THIS matrix.** It remains **unranked** — L9: *"this matrix is **unranked** — it confers nothing"* | — |

⭐ **Why no ADR was minted to make this edit.** `PRD_LIFECYCLE.md` **L164** requires an ADR *before* a change to
any **Rank 1–5** document. The matrix's rank was established by **three independent measurements**, not by
assumption: (i) its own L9 self-declaration as unranked; (ii) **0** occurrences of `TRACEABILITY_MATRIX` in the
**22 rank rows** of `DOCUMENTATION_BASELINE.md` §4's precedence table (measured over the section's L239–L282
span); and (iii) its presence instead in §3.4 *Configuration and implementation* at **L218**. ⛔ **Had §4
listed it at any rank, this registration would have STOPPED** and returned to the Governance Owner.

⭐ **And no baseline re-issue is due.** `DOCUMENTATION_BASELINE.md` §7 rule 4 fires on a **Rank 1–3** version
change; this matrix is unranked, so its `v1.22 → v1.23` bump does not trigger one. `BASELINE-2026-08-04-D`
stands. This follows §2G, §2O, §2P and §2Q, all of which left it standing.

### 2R.4 Subject hashes at registration

Recorded so that a later reader can prove **which** text was registered. ⭐ **The registration edited no
subject** — these are the same nine files the Stage-4 conferral verified.

| Part | File | Lines | sha256 (first 16) |
|---|---|---|---|
| C0 | `PRD-021C_C0_CROSS_PART_ARCHITECTURE_AND_OPEN_DECISIONS_v0.1.md` | 576 | `27722b18f3e2285e` |
| C1 | `PRD-021C_C1_MARKETPLACE_FOUNDATION_DRAFT_v0.1.md` | 365 | `c66f8de6eb648d09` |
| C2 | `PRD-021C_C2_LIBRARY_SEARCH_AND_LOCAL_DISCOVERY_DRAFT_v0.1.md` | 472 | `ea2e3e73f4efab81` |
| C3 | `PRD-021C_C3_LIBRARY_PUBLIC_PROFILE_DRAFT_v0.1.md` | 1039 | `930ac35443fc5b40` |
| C4 | `PRD-021C_C4_LIVE_SEAT_AVAILABILITY_AND_BOOKING_DRAFT_v0.1.md` | 593 | `6d22b31172f9e75a` |
| C5 | `PRD-021C_C5_LIBRARY_RATINGS_AND_REVIEWS_DRAFT_v0.1.md` | 726 | `4327033aae82486d` |
| C6 | `PRD-021C_C6_LIBRARY_DISCOVERY_PRESENTATION_DRAFT_v0.1.md` | 755 | `0bd6572931dc104c` |
| C7 | `PRD-021C_C7_MARKETPLACE_TRUST_AND_SAFETY_INTEGRATION_DRAFT_v0.1.md` | 719 | `c90376fcaed9161f` |
| C8 | `PRD-021C_C8_TECHNICAL_AND_PRODUCTION_ARCHITECTURE_DRAFT_v0.1.md` | 778 | `1cfbb5e6beb5e639` |

---


## 2S. Identifier inventory — Search Indexing (`PRD-015`, the `BC-23` discovery index)

**Stage 5 — CLAIMS registration.** Registered 2026-09-05, matrix **v1.23 → v1.24**, under the
Stage-5 conferral at `docs/30-product/search/PRD-015_STAGE5_CONFERRAL.md`.

⚠⚠ **The pre-commit measurement is published WITH ITS REGEX**, per the §2K/§2L lesson, because a
bare `grep -c 'SRCH-'` is unsafe for this prefix — the token also occurs inside `SRCHPO-*` and
`SRCHAO-*`, the Product-Owner and Architecture-Owner decision registers, which are **not** PRD
identifiers. Anchored:
`grep -cE '(^\|[^A-Za-z-])SRCH-(FR|BR|INV|EVT|XC|CFG|AC|GAP)-[0-9]+'` → **0**, so **165 identifiers
in a document whose Stage 3 and Stage 4 are CONFERRED were registered nowhere**.

### 2S.1 The registers

| Register | Members | Range | Contiguous from 001 | Duplicate definitions | Notes |
|---|---|---|---|---|---|
| `SRCH-FR-*` | **42** | `001`–`042` | ✅ | **0** | functional requirements |
| `SRCH-BR-*` | **14** | `001`–`014` | ✅ | **0** | business rules |
| `SRCH-INV-*` | **6** | `001`–`006` | ✅ | **0** | invariants — ⚠ one lawful restatement, §2S.4 |
| `SRCH-XC-*` | **16** | `001`–`016` | ✅ | **0** | exclusions |
| `SRCH-AC-*` | **78** | `001`–`078` | ✅ | **0** | acceptance criteria, all Given/When/Then |
| `SRCH-GAP-*` | **9** | `001`–`009` | ✅ | **0** | ⛔ **all 9 remain OPEN** — registration is not resolution |
| `SRCH-EVT-*` | ⭐ **0** | — | — | — | ⭐ **EMPTY, verified** — §2S.3 |
| `SRCH-CFG-*` | ⭐ **0** | — | — | — | ⭐ **EMPTY, verified** — §2S.3 |

⭐ **Obligation-bearing: 42 + 14 + 6 + 16 = 78.** ⭐ **Total identifiers: 165.** ⛔ **0 retired.**
⛔ **Zero collisions in all three directions** (§2S.5).

### 2S.2 ⭐⭐ Coverage — 78 / 78 = 100.0 %, computed in BOTH directions

| Measurement | Value |
|---|---|
| Obligation-bearing identifiers | **78** |
| `SRCH-AC-*` defined | **78** |
| Distinct obligations cited in AC `Verifies` cells | **78** |
| ⛔ Obligations with **no** criterion | ⭐ **0** |
| ⛔ Criteria citing a **non-existent** obligation | ⭐ **0** |

⭐⭐ **This is the first inventory in this matrix to register 100.0 % criterion coverage**, and the
figure is published for what it is: **every obligation has a criterion**. ⚠⚠ **It does NOT mean any
criterion is satisfied — 0 of 78 are proven by a passing test**, because no implementation exists.
`SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet."* Both gate scripts print the
coverage on every run and fail if it drifts.

### 2S.3 ⭐ Two registers are registered AS EMPTY rather than omitted

⚠ **An omitted empty register is indistinguishable from an oversight**, which is why both are
registered and both are enforced as tests.

| Register | Why it is empty | Verified |
|---|---|---|
| `SRCH-EVT-*` | ⭐ **`BC-23` publishes no domain event.** `SRCH-FR-004` requires every index to be populated *"from events on `E-21` only"* and `SRCH-INV-001` holds that `BC-23` *"holds **no** source of truth"* — a pure **projection consumer** produces no event | `grep -cE '\bSRCH-EVT-[0-9]+'` → **0** |
| `SRCH-CFG-*` | ⭐ **`BC-23`'s configuration carriage belongs to `BC-25`.** `ADR-0017` gives `BC-25` parameters and validation; `ADR-0099` §2.4 records that `LCFG-6` and `LCFG-12` are *"the shape `BC-25` carriage actually takes for `BC-23`"*. The `PRD-023` precedent is exact — that module *owns configuration and owns no configurable* | `grep -cE '\bSRCH-CFG-[0-9]+'` → **0** |

⛔ **No number is burned in either register** — deliberately unlike `TEN-CFG-001`, which was issued
then retired. Stage 5 **looked** for authoritative evidence requiring one and found none. ⭐ Both
checkers **fail** if a numbered member ever appears.

### 2S.4 ⚠ `SRCH-INV-005` — one lawful RESTATEMENT, disclosed rather than failed

Both gate scripts report, and neither fails on:

> `SRCH-INV-005`: **1 definition at line 358** (§11 *Index lifecycle*), **1 restatement at line 798**
> (§34 *Rebuild and recovery*).

⭐ **A restatement in a later topical section is not a register collision**, and `PRD-023` does the
same with `CNF-INV-001`…`004` defined and enforced in one section. ⚠ **It is reported by line number
anyway**, for two reasons: an undisclosed restatement is indistinguishable from an accidental second
definition, and a restatement that later **drifts** from its definition is a real defect this output
makes visible.

⛔ **The subject was NOT edited to remove it.** `PRD-015_SEARCH_INDEXING.md` is hash-locked at
`fe3093e60a3fae5516f0f65c9c62ac2bb28bdfa514a5b1870352d9bdbc2c4544` across the Stage-3 and Stage-4
conferrals; changing a byte would invalidate both measurements — the precise drift
`alignment_record_freshness.py` exists to catch.

### 2S.5 ⭐⭐ Collision safety — three directions, and the hazard here is REAL

| Direction | Test | Result |
|---|---|---|
| **Inward** | does another prefix end in something that makes `X-SRCH-` parse as a member? `[A-Za-z0-9]-SRCH-` | ⭐ **0** |
| **Reverse** | is `SRCH-` embedded in a longer token? `(?<=[A-Za-z0-9])SRCH-` | ⭐ **0** |
| **Bare form** | is the ambiguous `SRCH-n` form used? `\bSRCH-\d+\b` | ⭐ **0** |

⚠⚠ **The reverse hazard for this prefix is NOT manufactured — it is genuine, unlike §2L's, which was
measured absent.** `SRCHPO-1`…`19`, `SRCHPO-A1`…`A12`, `SRCHPO-X1`…`X17`, `SRCHPO-C1`/`C2` and
`SRCHAO-F5`/`SRCHAO-HB1` all begin with the four characters `SRCH`. ⭐ **A loose `SRCH` scan would
sweep 60+ decision-register identifiers into a PRD inventory** and report a phantom count. The
anchored regex published above requires the `-` and one of the eight sub-registers, so it matches
**0** of them.

### 2S.6 The two gate instruments, and why there are two

| Script | Route | Exit |
|---|---|---|
| `tool/docs_check/prd015_traceability.py` | classifies **LINES** by their own form; requires the em-dash separator that every definition uses and no prose citation does | **0** |
| `tool/docs_check/prd015_stage5.py` | splits the document at `## ` **and** `### ` into **SECTIONS**, gathers per-section, then unions; also runs the three collision directions and compares the PRD's **self-published** total | **0** |

⭐⭐ **Neither imports the other, and they reach 78 / 78 / 165 by different strategies.** §2H.2 names
the failure the pair exists to avoid: *"a checker written in the same pass as the register it checks,
by the same author, verifies agreement with itself."*

⚠ **Both were run BEFORE this section existed and both exited 1** — *"has no section 2S — the gate is
the registration, not the intention to register"* — while still computing 78 / 78. ⭐ **A gate that
cannot fail is not a gate.**

⚠⚠ **A DEFECT IN THE FIRST VERSION OF THESE SCRIPTS IS DISCLOSED RATHER THAN SMOOTHED OVER.** The
initial `check_register` treated **any** repeated em-dash form as a duplicate **definition** and
failed on `SRCH-INV-005`. Root-causing it by **reading L358 and L798** — not by adjusting a regex
until it passed — showed the PRD was **right** and the instrument's *model* was wrong: a definition
and a topical restatement are different things. ⭐ **No PRD content was changed to make a checker
pass.**

### 2S.7 ⛔ What this registration does NOT do

| ⛔ Not done |
|---|
| ⛔ **No `IMPL-*` range allocated** — that is Stage 6. `docs/40-implementation/search/` **does not exist** |
| ⛔ **No freeze** — Stage 7. `DOCUMENTATION_BASELINE.md` §3 contains **no** row admitting `PRD-015` |
| ⛔ **No verification** — registered is not verified; **0 of 78** criteria proven |
| ⛔ **All 9 `SRCH-GAP-*` remain OPEN**, as do `SRCHPO-A11`, `SRE-GAP-001`, the four **DEFER** rulings, and the `P1`/`P7` limbs |
| ⛔ **`PRD-015` stays `DRAFT` / `PLANNED`** — `PRD_REGISTRY.md` **L315** unchanged |
| ⛔ **Subject byte-unchanged**; **0** application-code files touched |

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
[`ADR-0011`](../00-governance/adr/ADR-0011-global-person-identity.md) ·
[`Student_Management_PRD_v1.md`](../30-product/student-management/Student_Management_PRD_v1.md) ·
[`PRD-MEMBERSHIP-MANAGEMENT.md`](../30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md) ·
[`tool/docs_check/prd005_traceability.py`](../../tool/docs_check/prd005_traceability.py) ·
[`PRD-SEAT-MANAGEMENT.md`](../30-product/seat-management/PRD-SEAT-MANAGEMENT.md) ·
[`tool/docs_check/prd007_traceability.py`](../../tool/docs_check/prd007_traceability.py) ·
[`ADR-0018`](../00-governance/adr/ADR-0018-student-management-prd-v1.2-baseline.md)

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| **v1.23** | 2026-09-03 | **Added the `PRD-021C` C0–C8 Library Marketplace identifier inventory (§2R) — registering NINE prefix stems (`XPC-` `LMP-` `LSD-` `LPP-` `LSB-` `LRR-` `LDR-` `LTS-` `LMT-`) minted across nine separate documents — and **CLAIMS Stage 5**, recorded at [`../30-product/library-marketplace/PRD-021C_C0_C8_STAGE5_TRACEABILITY.md`](../30-product/library-marketplace/PRD-021C_C0_C8_STAGE5_TRACEABILITY.md) in the form §2N/§2O/§2P/§2Q used.** ⛔⛔ **The pre-commit measurement is published with its command: `grep -c "PRD-021C"` over this matrix returned 0, and all nine stems returned 0 individually, so 528 identifiers across 30 registers were registered NOWHERE** — the exact condition Stage 5 exists to prevent, and the honest pre-registration answer to this gate was **BLOCKED on its first clause**. ⭐ **The instrument was proved live in the same run** — the identical expression over already-registered stems returned `XPB` 6 · `MSG` 3 · `SGR` 1 · `TSF` 10 · `FIL` 16 — because *a negative that cannot go positive proves nothing*. **30 registers, 528 identifiers, ⭐ 30 of 30 contiguous** from `001` **with no exception to preserve** — **258 normative requirements** (220 `*-FR-*` + 38 `*-BR-*`), **118 exclusions**, **123 acceptance criteria**, **zero collisions**. ⛔⛔ **THE DECISIVE PRECONDITION: Stage 5 was entered ONLY because Stage 4 is CONFERRED.** Two prior turns reported Stage 4 **NOT CONFERRED** despite a complete evidence set, because `PRD_LIFECYCLE.md` **L278**'s Requirements Reviewer role had no holder; this act rests on the **direct, explicit and unconditional conferral of the human principal**, recorded at [`../30-product/library-marketplace/PRD-021C_C0_C8_STAGE4_CONFERRAL.md`](../30-product/library-marketplace/PRD-021C_C0_C8_STAGE4_CONFERRAL.md) with the instruction quoted verbatim as **the only authority claimed**, scoped to **this specific act only** (`ADR-0033` §7.1: *"a conferral for one act is not a standing licence"*), ⛔ **with NO personal name recorded and none invented** (`PRD_OWNERSHIP_MODEL.md` §7 rule 4). **Six of six Stage-4 checks PASS and the L119 gate is SATISFIED** — all ten `XPC-OD-*` carrying a status, a reason and an owner (or an explicit *no decision required*). ⭐⭐ **Check 4 moved from 64/123 to 123/123 WHILE THE REQUIREMENT COUNT DID NOT MOVE AT ALL** — 528 identifiers and 258 obligations before and after — which is the decisive audit fact, because `PRD-008_STAGE4_CONFERRAL.md` §4 names the corrupting alternative: *"the most corrupting way to pass a requirements review is to write the missing requirement."* **Collisions measured in FIVE directions**: **(a)** 0 for all nine stems in this matrix; **(b)** **432 files** scanned under `docs/` and `tool/`, **51** stems observed, **42 foreign**, containment-tested in **both** directions, **0 collide**; **(c)** **20** near-miss probes (`XP` `XPCA` `LM` `LMPX` `LS` `LSDX` `LP` `LPPX` `LSBX` `LR` `LRRX` `LD` `LDRX` `LT` `LTSX` `LMTX` `LMTS` `LSDS` `LPPS` `LSBS`) **all 0**; **(d)** ⭐ **210 occurrences of the nine stems OUTSIDE the subject directory, READ rather than reported** — the eight files are `ADR-INDEX.md`, `ADR-0093`…`ADR-0097`, `PRD_REGISTRY.md` and the BC Map, precisely the instruments that RESOLVED C0's open decisions, and the test that matters returned **0 foreign definition sites and 0 dangling citations**, so all 210 are lawful citations and the system working; **(e)** **385** cross-part sibling citations with **2 unresolved**. **30 `max+1` phantom probes — one per register — returned 1 hit.** ⚠⚠ **THE PHANTOM HIT AND THE 2 UNRESOLVED CITATIONS ARE THE SAME TOKEN, AND IT IS A CARRIED DEFECT, NOT A COLLISION AND NOT A PHANTOM MINT**: both sit in **C0** and name the **withdrawn** `LDR-FR` slot **023**, which C0 **L128** itself describes as *"its **withdrawn** fallback slot as a bare … token, so a contiguity"* check would see it; C6's `LDR-FR` register ends at **022** and the count of that token **inside C6 is 0**. ⭐ **This is the identifier-tokenisation defect — the SIXTH recorded instance in this engagement** — a backtick-delimited identifier being greppable regardless of prose, so **a disclosure that spells an unminted slot in order to assert it is unused makes every census reading that file see it as minted**; carried as **`S4-A-5`** and routed to the **Architecture Owner**, and ⛔ **NOT cured here, because curing it would edit C0 and this registration edits no subject**. ⭐⭐ **THE SAME DEFECT WAS CAUGHT IN THIS COMMIT'S OWN NEW ARTEFACT AND FIXED BEFORE COMMIT**: the Stage-4 conferral initially spelled the rejected bounded-context slot and the would-be-next edge slot as live tokens while asserting they do not exist; both rows were rewritten **by number only**, and all eight tokenisation guards now return 0. ⚠⚠ **A DENOMINATOR DISCLOSURE, published with every percentage in the same sentence** because §2Q records that mixing denominators once produced *"102.7% — a coverage figure ABOVE 100%, manufactured by accident"*: **own-stem FR+BR = 258** (the register) versus **whole-text FR+BR = 263** (which counts lawfully cited foreign identifiers as if owned). **Reverse coverage 210 of 258 = 81.4%, ⚠ 48 uncovered**; against the wider denominator, for disclosure only, **211 of 263 = 80.2%**. **Forward coverage 123 of 123 = 100%, 0 orphan ACs.** ⛔ **The 48 are NOT minted** — a **Product Owner** authoring act, and §2O.2 names it: *"minting identifiers to move a percentage is the same act at larger scale"*; ⛔ **nor was the denominator widened to flatter the ratio.** ⚠⚠ **TWO INSTRUMENT DEFECTS CAUGHT AND DISCLOSED, ZERO SUBJECT DEFECTS.** A definition-site census read **193** obligations against a true **258**, because it required a table row while C0–C8 define register members in **prose** (the §2O.4 `I-1` class, recurring). Worse, a testability scan first flagged **34** obligations as carrying no normative verb — and **every one of the 34 was either a `*-FR-001` or a register MAXIMUM**, the signature of a **range-declaration row** rather than a definition; excluding range rows cut the flag set to 16, and **reading all 16 at their true definition sites resolved 14 outright**, the remaining 2 (`LRR-BR-008`, `LDR-BR-009`) being testable on their own terms — one recording a **satisfied** condition (*"a quantity that is never computed cannot be computed inconsistently"*) and the other enforced by `LDR-XC-008`'s **MUST NOT**. ⭐ **Neither was fixed by re-running an instrument until it agreed**, per `PRD-021A_STAGE4_CONFERRAL` §1: *"a reviewer who reaches a PASS by re-running an instrument until it agrees has reviewed nothing."* **Two Stage-4 scanner flags were likewise adjudicated BY READING**: seven C3 exclusions matched a deferral vocabulary only because *V2* appears in their **Authority** column as the ground for a prohibition, under a header reading `| ID | C3 does **not** |` — **header-carried negation**, the `RJ-1` cell-position class; and six apparent foreign definitions in C6 sit under `| C2 requirement | What it already fixes |`, a **citation** table proving C6 does not restate C2. **Thirteen rejected findings (`S4-R-1`…`S4-R-13`) were re-derived from source and 13 of 13 UPHELD.** ⚠ **THE MATRIX EDIT'S LAWFULNESS WAS RE-ESTABLISHED BY THREE INDEPENDENT MEASUREMENTS rather than by trusting this matrix's own header**: its L9 self-declaration as *"unranked"*, **0** occurrences of `TRACEABILITY_MATRIX` in the **22 rank rows** of `DOCUMENTATION_BASELINE.md` §4's precedence table (measured over its L239–L282 span, the section read directly rather than inferred from a whole-file `grep` that returns **16** hits, all of them **other documents' rows** or §6 gap text), and its presence instead in **§3.4 at L218**. `PRD_LIFECYCLE.md` **L164** — *"A change to any Rank 1–5 document requires an ADR **before** the change"* — therefore does not reach it, so ⛔ **no ADR is required and none is minted**; ⛔⛔ **had §4 listed it at any rank, registration would have STOPPED and been returned to the Governance Owner.** ⚠ **The artefact shape follows the §2Q precedent and `DOCUMENTATION_BASELINE.md` L199's reasoning**: **this section IS the gate**, so ⛔ **no separate Stage-5 conferral file is written** (unlike `PRD-021A`, whose §2P did not yet exist when its audit was taken), and ⛔ **the 528-identifier census is published ONCE, here in §2R.0** — duplicating 30 register rows into the consolidated record would create a **`GCP-15`** derived-statement defect in the same commit that published it. ⚠ **The six instruments are deliberately NOT committed to `tool/docs_check/`**, because everything there runs in the standing sweep and committing new checkers here would make this registration's verdict depend on instruments it wrote and nobody reviewed — a **Governance Owner** act; the measurements are published with their rules and controls for independent reproduction instead. **Stage 5 ONLY.** ⛔ **No rank, no freeze, no Stage 6, no `IMPL-*` allocation, no architecture closure, no gap closure, no `READY`, no status move and no ADR number** — §2R.3 refuses each explicitly and names the owner who could confer it. **All OPEN items are carried forward unchanged**, including `XPC-OD-005` **DEFERRED — OPEN** whose owner role (**Privacy Owner**) is **vacant as constituted** and may not perform its own conferral, and `XPC-OD-010` **RESOLVED IN PART** with one half blocked upstream (`TSF-GAP-009`). **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended: ZERO. Gaps closed: ZERO. Owner decisions closed: ZERO. BCs, entities, events and edges created: ZERO. `IMPL-*` written: ZERO. ADRs minted: ZERO.** ⛔ **All nine subjects are byte-unchanged** — sha256 recorded per part at §2R.4, **6,023 lines**, identical to what the Stage-4 conferral verified; bounded contexts remain **31**, edges **29** with slot 27 permanently vacant, and ADR files **85** with slots 0088/0089/0090 unwritten. **§2 through §2Q are byte-unchanged**, as are `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `PRD_OWNERSHIP_MODEL.md`, all ADR files, FROZEN `PRD-020`, FROZEN `PRD-017`, FROZEN `PRD-007` and both Stage-4 evidence records — **retained verbatim, the correction living in the later record** (`PRD-008` §3.3). **No baseline re-issue** — §7 rule 4 moves the identifier only on a **Rank 1–3** version change and this matrix is **unranked, so it confers nothing**; the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G/§2Q precedent. **No Dart source changed**; `git status --short lib/ test/ web/ android/ tool/` returns **0 lines**. |
| **v1.22** | 2026-09-02 | **Added the `PRD-021B` B0–B9 Social Graph / Discovery / Messaging identifier inventory (§2Q) — registering TEN prefix stems (`XPA-` `SGR-` `SSF-` `SDS-` `DRK-` `PYK-` `GLS-` `MSG-` `RTM-` `TPA-`) minted across ten separate documents — and **CLAIMS Stage 5**, recorded at [`../30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md`](../30-product/social-graph/PRD-021B_B0_B9_STAGE5_TRACEABILITY.md) in the form §2N/§2O/§2P used.** ⛔⛔ **The pre-commit measurement is published with its command: `grep -c "PRD-021B"` over this matrix returned 0, and all ten stems returned 0 individually, so 1,300 identifiers across 113 registers were registered NOWHERE** — the exact condition Stage 5 exists to prevent, and the honest pre-registration answer to this gate was **BLOCKED on its first clause**. **113 registers, 1,300 identifiers, ⭐ 113 of 113 contiguous** from `001` **with no exception to preserve** — a stronger result than §2P's 104 of 105 — **365 normative requirements** (196 `*-FR-*` + 169 `*-BR-*`), **242 acceptance criteria**, **zero collisions**. ⛔⛔ **THE DECISIVE DIFFERENCE FROM §2P: this is the largest multi-document subject yet registered — TEN documents, two more than §2P's eight — and it required a SIXTH collision direction that no prior §2x needed.** Ten documents that **allocate ownership among themselves** can fail in a way even an eight-document subject cannot: by two parts claiming the same bounded context. Direction **(f)** tests it against **B0 §2**, a 15-capability matrix whose `Owner` column is single-valued and whose B1/B2/B3 columns carry ✅ owns / ▶ consumes / ⛔ must not touch — **0 rows assign ✅ to more than one part**, and ⭐ **B7 L34 is the affirmative case, DECLINING ownership `BC-12` already holds under FROZEN `PRD-020` §10 L633–634**. The other five follow §2P.1: **(a)** 0 for all ten stems; **(b)** **465 files** scanned, **42** stems observed, **32 foreign**, containment-tested in **both** directions, **0 collide**; **(c)** **20** near-miss probes all **0**, each published **beside the control that proves the probe fires** (`XPA-` 26 · `SGR-` 343 · `SSF-` 306 · `SDS-` 361 · `DRK-` 324 · `PYK-` 305 · `GLS-` 226 · `MSG-` 347 · `RTM-` 303 · `TPA-` 260), because *a negative that cannot go positive proves nothing*; **(d)** **89** distinct foreign tokens, **0 unresolved**; **(e)** **196** cross-part sibling citations, **0** citing an unminted sibling. **113 `max+1` phantom probes — one per register — returned 0 hits.** ⚠⚠ **`XPA-`/`XPB-` IS THE NEAR MISS WORTH NAMING, and it is this stage's own `PO-3`/`SPO-3`**: `XPA-` is B0's stem with **26** strict-shape occurrences, while **`XPB-` is a DIFFERENT family with 257** — roughly ten times as many. Tested **both ways**, `XPA-[A-Z]{2,6}-\d{3}` does not match `XPB-CONF-001` and `XPB-[A-Z]{2,6}-\d{3}` does not match `XPA-PREC-001`, **containment collisions 0**; ⚠ **but a bare `'XP'` substring matches BOTH**, so it is recorded as a **standing obligation rather than a clean bill**, on the §2P `LCFG-` precedent: *any checker touching this family must anchor on `XPA-` with the hyphen, never on `XPA` or `XP`.* ⭐⭐ **NEW FINDING `S5-F-1` — THE ELEVENTH STEM, `XPB-`, WHICH NO PART OWNS**, surfaced by the very near-miss probes built to catch this shape. It carries **19 identifiers** (`XPB-CONF-001`…`017` and `XPB-DRIFT-001`…`002`, both registers contiguous) minted across **14 files including `PRD_REGISTRY.md` (23) and ACCEPTED `ADR-0091` (20)**, of which **SIX `XPB-CONF-*` are still OPEN owner decisions** — and ⛔⛔ **its authoritative enumeration lives in a REVIEW RECORD**, `PRD-021B_B0_B9_STAGE3_ARCHITECTURE_ALIGNMENT.md` **§7.1 L354**, **not in any PRD**; a review record is evidence about a subject, not a subject. ⛔ **It is deliberately NOT registered here** — §2Q's subject is B0–B9 and `XPB-` is not B0's stem, so registering another document's family would be **registration without a subject** and would assert an ownership this registration cannot confer; **routed to the Governance Owner, raised and not resolved**. ⚠⚠ **BOTH TRACE DIRECTIONS WERE MEASURED, INCLUDING THE UNFLATTERING ONE.** Forward: **242 ACs, 242 requirement-backed, 0 orphan ACs, 0 gap-backed, 0 dangling, 0 duplicate GWT triples**. Reverse: **195 of 365 FR+BR covered = 53.4%, with 170 ORPHAN REQUIREMENTS** — between §2D's 60.1% and §2O's 40.6% on this matrix's ladder, **registered at its measured value**. ⛔⛔ **A DENOMINATOR TRAP WAS CAUGHT BEFORE PUBLICATION**: the count of distinct requirements cited by ≥1 AC across the **full normative pool** is **375** while the coverage denominator is **365** (FR+BR only, §2P's convention), and combining them yields **102.7% — a coverage figure ABOVE 100%, manufactured by accident rather than by measurement**; both figures now carry their denominator in the same sentence wherever they appear. **B5's 18.2% is the lowest single figure and is diagnostic rather than anomalous** — its 24 ACs bind to `PYK-POL-*`/`PRS-*`/`SRC-*`/`FB-*`/`FRQ-*`, registers the FR+BR denominator excludes **by construction**. ⛔ **The 170 are NOT minted** — it would take the AC register **242 → 412** and falsify every count in §2Q.0 **in the commit that publishes them**, it is a **Product Owner** authoring act, **coverage is not in this gate**, and §2O.2 names it: *"minting identifiers to move a percentage is the same act at larger scale"* (§2P refused **551** on the same reasoning). ⛔ **Nor was the denominator widened** to lift B5: *changing a denominator to move a number is the same act as minting criteria to move it.* ⚠ **ALL SIX REMAINING TRACE LEGS MEASURED** — BC ownership (**24 of 31** cited, **0** unresolved, **0** minted, **0** conflicts); upstream authority (`MP-*` **3 of 125**, `AR-*` **2 of 7**, 0 unresolved); integration edges (**16 of 29** cited, ⛔ **0 created**, and ⭐ **all 8 `E-27` occurrences READ AT SOURCE and found to ASSERT VACANCY** — B7 L220/L253/L903, B8 L236, B9 L211/L269/L769/L840 — asserting an edge is vacant being the opposite of creating one); events/data/signals (`EVT` **15**, `DM` 28, `SIG` 10, `IDX` 10, ⛔ **0 new events**, `SGR-EVT-002` positively **prohibiting** minting); scope/wave (`SCOPE` 31, `FUT` 8, **V1 177 · V2 117 · V3 29**, and ⚠ **"Wave 1/2/3" = 0** — a vocabulary mismatch, not absent scope allocation); exclusions (`XC` **156**). **11 multi-AC requirements inspected, 0 duplicate-mapping defects**, including the only cross-part instance **`SGR-BR-014`**, read at four sites (B1 **L324** mints it, **L677**, **L730**; B3 **L294** cites it *as B1's*, **L510** `SDS-AC-007`) and determined **lawful — one rule, two surfaces, one owner**. ⭐ **`LCM-FR-013` WAS EXPLICITLY VERIFIED AND EXPLICITLY NOT APPLIED — 0 occurrences in ALL TEN parts — and `LCM-FR-012` was measured alongside it and is ALSO 0 of 10**, a column Stage 4 did not take, which shows the zero is not a suspicious single-token gap in an otherwise-cited run; the 8 `LCM-*` tokens B0–B9 **do** cite (36 citations: `LCM-RM-006` 8 · `LCM-RM-025` 7 · `LCM-RM-021` 7 · `LCM-RM-023` 6 · `LCM-API-013` 4 · `LCM-RM-001` 2 · `LCM-XC-001` 1 · `LCM-RM-017` 1) all resolve to A1, registered at §2P. ⚠ **A minting test returned 15 declaration-shaped foreign lines and a COUNT ALONE WOULD HAVE PUBLISHED A FALSE FINDING of foreign minting in eight files**; all 15 were **read at their line** (§2C.1) — B2 **L353** and B5 **L249** quote `TSF-*` authority **verbatim**, B7 **L620** records `LCN-FR-019` as **`VOID`**, and the remaining 12 are `XPB-CONF-*` **disposition-table rows** (B7 L882–887, B8 L762–766, B9 L934) — **genuine foreign minting: 0**. ⚠⚠ **FIVE INSTRUMENT DEFECTS AND ZERO SUBJECT DEFECTS — and TWO of the five are the SAME CLASS, caught twice in one review by an author who had read §2O.4 `I-1` before starting.** **`I5-1`**: a gap-row census returned **57** against Stage 4's **56**, re-measured under **four** explicit rules (**97** any-mention / **84** own-stem rows / **30** declaration rows / **56** Stage 4's rule), all correct for their rule — **the rule now travels with every number**. **`I5-5`**: `XPA-`/`XPB-` reported as **26/257** in one pass and **40/259** in another, ⚠ **not a scope difference but a RULE difference** (identical across `docs/`, `docs/+tool/` and all tracked files) — **strict identifier shape vs bare stem literal** — both published. **`I5-2`**: the ownership probe found only **6** `| Owner |` rows across ten documents and declared 0 conflicts, **an unfalsifiable zero of the §2P `J-4` class**, re-run against B0 §2's capability matrix which *could* have produced a conflict. **`I5-3`**: a row window reported **16** capability rows against a heading declaring **15** — ⭐ **the subject was right and the instrument wrong**, recorded rather than quietly adjusted. **`I5-4`**: a shell `|| echo 0` fallback **doubled** the `LCM-FR-013` output; counts correct, presentation not. ⚠ **NINE REJECTED FINDINGS are published with their reasons** in the consolidated record (`S5-R-1`…`S5-R-9`), per `PRD_LIFECYCLE.md` **L104–106** — *"a review that records only accepted findings is indistinguishable from a review that found nothing"* — among them **82 apparently malformed ACs** (an artefact of a **table-only probe** meeting a lawful **prose GWT form**: B0–B6 use a 5-column table for **160**, B7/B8/B9 prose for **82**), **three foreign gap tokens** (one of the three, `LCF-GAP-012`, appears **only inside a FILENAME** at B8 **L225** — true count of foreign gap citations: **2**), and **B0's zero FR/BR** (it is the **allocation** part, whose §2 is the ownership instrument for the whole set). ⚠ **THE MATRIX EDIT'S LAWFULNESS WAS ESTABLISHED BY THREE INDEPENDENT MEASUREMENTS RATHER THAN BY TRUSTING THIS MATRIX'S OWN HEADER**: its self-declaration as *"unranked"* (L9), its **absence** from `DOCUMENTATION_BASELINE.md` §4's Rank 1–6 precedence table (**0 occurrences**), and its presence instead at **L216 in §3.4** at **v1.1**. `PRD_LIFECYCLE.md` **L164** — *"A change to any Rank 1–5 document requires an ADR **before** the change"* — therefore **does not reach it**, so ⛔ **no ADR is required and none is minted**; ⛔⛔ **had §4 listed it at any rank, registration would have STOPPED and been returned to the Governance Owner.** ⚠ **The artifact shape follows `DOCUMENTATION_BASELINE.md` L199** (*"Stage 5 has no separate conferral file … the record and the gate are the same artefact"*): **this section IS the gate**, and ⛔ **the 1,300-identifier census is published ONCE, here in §2Q.0** — duplicating 113 register rows into the record would create a **`GCP-15`** derived-statement defect in the same commit that published it. ⚠ **The five instruments are deliberately NOT committed to `tool/docs_check/`**, because everything there runs in the standing sweep and committing five new checkers in this commit would make this registration's verdict depend on instruments it wrote and nobody reviewed — a **Governance Owner** act; the measurements are published with their rules and controls for independent reproduction instead. ⚠ **`prd020_stage5.py` fails before AND after on two pre-existing problems and this commit ENLARGES both** (its *"§2\* line(s) outside §2O"* count and its 4-entry file list), artefacts of its **leading-cell heuristic** at **L295–312** which cannot distinguish a citation from a definition — **disclosed in advance, not suppressed**, and ⛔ **two cheaper alternatives refused by name**: deleting true evidence rows, and editing the checker that judges a neighbouring registration (**§2H.2's named failure**). **Stage 5 ONLY.** ⛔ **No rank, no freeze, no Stage 6, no `IMPL-*` allocation, no architecture closure, no gap closure, no `READY`, no status move and no ADR number** — §2Q.3 refuses each explicitly and names the owner who could confer it, on §2P.4 item 7's rule that a status move *"is an amendment act requiring amendment authority, **not a side effect**."* **All 30 own-stem `*-GAP-*` and 2 foreign gap citations stand exactly as their subjects left them** (**0** without a reason, **0** without an owner, **32 of 32** *"Blocks authoring?"* = ⛔ No), and **all OPEN items are carried forward unchanged**: **6** `XPB-CONF-*`, **2** `XPB-DRIFT-*`, **3** `FOD-*` — with ⚠ **`FOD-4` recorded as DISCHARGED BY B0 ITSELF** at B0 **L329–345**, not by this registration — plus `C-1`/`C-2`/`C-3` registered ***recorded, NOT applied*** (all three **citation defects, not requirement defects**, and ⛔ **`PRD-020` MUST NOT be edited** for `C-2`), and **`MSG-GAP-002`**, which names the live fact that **`PRD-021` itself is still `PLANNED`** at `PRD_REGISTRY.md` §4.2 **L321** while B0–B9 accumulate as drafts — a **Governance Owner** matter and **not** a Stage 5 blocker, since this gate asks whether prefixes are registered, not what status the parent PRD holds. **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended: ZERO. Gaps closed: ZERO. Owner decisions closed: ZERO. BCs, events, edges and APIs created: ZERO. `IMPL-*` written: ZERO. ADRs minted: ZERO.** ⛔ **All ten subjects are byte-unchanged** — sha256 recorded per part at §2Q.4, identical before and after and identical to what Stage 3 and Stage 4 measured, **6,613 lines / 352,765 bytes**; ⚠ Stage 3/4 recorded **6,603** under a different **trailing-newline convention**, the **hashes are identical**, and **both conventions are published** rather than one silently replacing the other. **§2 through §2P are byte-unchanged**, as are `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `MASTER_PRD.md`, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `ARCHITECTURE_RULINGS.md`, `PRD_REGISTRY.md`, all ADR files including `ADR-0091`, FROZEN `PRD-020`, FROZEN `PRD-017` and all Stage 3/Stage 4 records. **No baseline re-issue** — §7 rule 4 moves the identifier only on a **Rank 1–3** version change and this matrix is **unranked, so it confers nothing**; the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G precedent. **No Dart source changed**; `git status --short lib/ test/ web/ tool/` returns **0 lines**. |
| **v1.21** | 2026-09-01 | **Added the `PRD-021A` A1–A8 Library Community identifier inventory (§2P) — registering EIGHT prefix stems (`LCM-` `LCF-` `LCR-` `LCG-` `LCO-` `LCS-` `LCN-` `LCT-`) minted across eight separate documents — and **CLAIMS Stage 5**, conferred at [`../30-product/social-graph/PRD-021A_STAGE5_CONFERRAL_2026-09-01.md`](../30-product/social-graph/PRD-021A_STAGE5_CONFERRAL_2026-09-01.md) in the form §2O used for `PRD-020`.** The pre-commit measurement is published with its command: a count of `LC[MFRGOSNT]-[A-Z]+-\d+` over §2…§2O returned **0 for all eight stems**, so **1,982 identifiers across 105 registers were registered nowhere** — the exact condition Stage 5 exists to prevent. **105 registers, 1,982 identifiers, 104 of 105 contiguous** from `001`, **757 normative requirements** (710 FR + 47 BR), **233 acceptance criteria**, **zero collisions**. ⛔⛔ **THE DECISIVE DIFFERENCE FROM EVERY PREDECESSOR: this is the first registration in this matrix whose subject is EIGHT DOCUMENTS rather than one, and that fact required a FIFTH collision direction that no prior §2x needed.** Eight documents cite one another **253** times across part boundaries and can therefore fail in a way a single-document subject structurally cannot — by citing a sibling's identifier the sibling never minted. Direction **(e)** resolves all 253 against the owning part's occupancy set: **0 dangling.** The other four follow §2O.1: **(a)** 0 for all eight stems; **(b)** **23** foreign stems harvested from `docs/` and containment-tested in **both** directions, **0 collide**; **(c)** **14** near-miss probes (`LC-` `LCFG-` `LCMS-` `LCRS-` `LCGS-` `LCOS-` `LCSS-` `LCNS-` `LCTS-` `LCA-`…`LCE-`) all **0**, published **beside the control that proves the probe fires** (`LCM` 881 · `LCF` 4,609 · `LCR` 2,686 · `LCG` 369 · `LCO` 609 · `LCS` 255 · `LCN` 249 · `LCT` 314), because *a negative that cannot go positive proves nothing*; **(d)** **509 files** scanned, **8 unresolved foreign tokens** each read at its line and each classified — **none a collision**, but **two are genuine DRIFT findings** published rather than reconciled (`ADR-0082` **L398** minted `LCF-GAP-015` one past A2 v0.8's maximum of `LCF-GAP-014`; `ADR-0083` **L12** cites an `LCM-GAP` number past A1's maximum of `LCM-GAP-008`). ⚠ **`LCFG-` is the near miss worth naming**: it is **already registered at L70** of this matrix, and a bare `LCF` substring **does** match `LCFG-13`. The stems are disjoint *in shape* — verified both ways — so the hazard is recorded as a standing obligation on future instruments rather than a clean bill: **any checker touching this family must anchor on `LCF-` with the hyphen.** ⛔⛔ **THE LOWEST ACCEPTANCE COVERAGE EVER REGISTERED IN THIS MATRIX — 206/757 = 27.2%, with 551 UNCOVERED — registered at its measured value rather than repaired to a flattering one**, below §2O's 40.6%, §2D's 60.1%, §2M's 71.2%, §2E's 73.4% and §2C's 94.6%. Stage 5's gate is *"prefixes registered … with counts and ranges, verified mechanically, zero collisions"* and **coverage is not in it**; what it forbids is an *unmeasured or overstated* figure, the `PRD-006` v1.0 error of publishing *"100% coverage"* against a true 49.1%. **Minting 551 criteria would take the register 233 → 784, falsify every count in §2P.0, and be a Product Owner authoring act** — refused, on §2O.2's reasoning that *"minting identifiers to move a percentage is the same act at larger scale."* A5's **12.0%** is the lowest single figure and is diagnostic rather than anomalous: 133 `LCO-FR-*` against 21 `LCO-AC-*` and 26 open gaps is the profile of a part specified ahead of its acceptance work; disclosed under `SID-4.56` and left as existing open work. ⚠⚠⚠ **SEVEN PRESERVATION ACTS, each with a cheaper alternative that was available and refused — §2P.3 names both halves.** **(1)** A1's `LCM-FR-*` register holds **66 members across a range of 67**, and the unassigned number is preserved rather than closed: minting a requirement to occupy it is a Product Owner act, and renumbering `048`…`067` downward would break every citation of those twenty identifiers across A2…A8. **(2)** ⛔ **That number is NOT WRITTEN ANYWHERE — not in §2P, not in either instrument, not in the corrected Stage-4 record.** A1 **§24 L885** withholds it *"because reproducing an unassigned identifier in prose is exactly what makes a phantom look defined to a grep-based or automated continuity check"*, and every downstream document here records it by **position** (the number after `LCM-FR-046`); both instruments hold it arithmetically as `A1_GAP_AFTER = 46`. **(3)** A7's `LCN-EVT-*` registers **7 minted · 3 ACTIVE · 4 WITHDRAWN**, and the count deliberately **does not fall to three** — `PRD_LIFECYCLE.md` **L258** §5 rule 5: *"Numbers are never reused, even after withdrawal."* Reporting 3 would free `004` for reuse and silently retarget every historical citation. **(4)** A7's three **VOID** `LCN-FR-*` positions retained on the same rule. **(5)** A2's `LCF-EVT-*` is **CLOSED at six** by `LCF-FR-104` and its next-free cell reads *none — ADR required*. **(6)** A2's three **RETIRED** `LCF-RSK-*` positions counted as minted, *"positions retained, never renumbered."* **(7)** A8's `LCT-CONF-001` — A7's seven events against A2's closure at six — left **RAISED, NOT RESOLVED**: picking a winner is an **Architecture Owner** act. ⚠⚠⚠ **§2P.7 records SIX defects and ZERO subject defects — twice the count of any predecessor — and THREE of the six are recurrences of defects this matrix had already disclosed and which §2P cites BY NAME.** **`J-1`**: the already-conferred-and-pushed `PRD-021A_STAGE4_CONFERRAL_2026-09-01.md` **L293** reproduced A1's unassigned identifier **three times**, inside the very row explaining the gap must not be closed — A1's precaution defeated by the document conferring its stage; corrected in place on §2N's *"corrected, not rewritten"* precedent, **the conferral itself untouched**. **`J-1a`**: ⛔⛔ **the same token twice more, in the §2P.6 and §2P.7 rows DISCLOSING `J-1`** — the **fifth** recorded instance of the self-referential phantom (§2N.3.1 records two, one in *"the paragraph that codifies the rule against phantoms"*; §2O.4 `I-4` a third; `J-1` a fourth), written into the section that enumerates all four, by an author who had just cited every one, while that author's own `A1_GAP_AFTER` constant existed to make it impossible in code. **`prd021a_stage5.py` caught it; the author did not** — which is the entire argument for the two-instrument rule. **`J-5`**: `I-3` recurring almost verbatim — direction (b) read *"28 stems"* against a list of **28**, count and list agreeing because **both** came from a harvest missing the `\d{3}` anchor, admitting `EDGE MP S3 S4 S5 S6`; re-measured **23**, and all three harvests (19 matrix-scoped · 23 strict · 29 loose) are now published with their scopes and **all return 0**, so the collision claim survives whichever a reader reproduces. **`J-3`**: a census by **glob** — `PRD-021A_A*_*DRAFT_v*.md` matches **18** files, not 8, because ten superseded drafts sit beside the subjects (**25,230** lines against a true **11,617**); had it run, A2's and A3's registers would have been registered at their *superseded* maxima. **`J-4`**: fourteen unfalsifiable zeroes before the control was added. **`J-6`**: ✅ **the gate flagged A7's non-numeric next-free cell as a failure and the INSTRUMENT was the thing that was wrong** — it modelled only *rule-closed* registers, not *conflict-suspended* ones; **the tempting fix was to write `max+1` and satisfy the gate, which is `I-4` exactly**, so the instrument was widened instead, each ground carrying its authority in code. ⚠ **Both instruments are committed and neither imports the other** — [`../../tool/docs_check/prd021a_traceability.py`](../../tool/docs_check/prd021a_traceability.py) never opens this matrix; [`../../tool/docs_check/prd021a_stage5.py`](../../tool/docs_check/prd021a_stage5.py) never trusts §2P.0 except to contradict it; **both reach 105 / 1,982 by structurally different routes**, avoiding §2H.2's named failure. **`prd021a_stage5.py` was run BEFORE §2P existed and exited 1** — *"has no `## 2P.` section … registers 1982 identifiers across 105 registers NOWHERE"* — and **`prd021a_traceability.py` was MUTATION-TESTED in four independent ways and failed all four** (gap removed → *"NON-CONTIGUOUS"*; a fifth withdrawn A7 event → *"row is GONE"*; `LCF-EVT` declared closed at five → *"reaches 006"*; gap position moved → *"the declared intentional gap has been FILLED"*), because a gate that passes is only evidence if it could have done otherwise. **Stage 5 ONLY.** ⛔ **No rank, no freeze, no Stage 6, no `IMPL-*` allocation, no architecture closure, no gap closure, no `READY`, no status move, and no ADR number** — §2P.4 refuses each explicitly and names the owner who could confer it. **All 97 `*-GAP-*` stand exactly as their subjects left them** (8 `LCM` · 14 `LCF` · 10 `LCR` · 14 `LCG` = **13 open + 1 deferred** · 26 `LCO` · 6 `LCS` · 8 `LCN` · 11 `LCT`), including `LCG-GAP-001` (*"no document allocates scope to Part A4"*) and `LCG-GAP-006` (*"no published contract mints or resolves `communityId`"*), which A4 makes hard blockers. **21 `*-ADR-*` requirements are registered and ZERO ADR numbers are minted** — A1 `LCM-FR-049`: *"The ADR number … SHALL be allocated by the Governance Owner. This document SHALL NOT mint one."* **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended: ZERO. Gaps closed: ZERO. ADRs written: ZERO.** ⛔ **All eight subjects are byte-unchanged** — sha256 recorded per part at §2P.5, identical before and after, **11,617 lines / 739,840 bytes**. **§2 through §2O are byte-unchanged**, as are `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md`, all **75** ADR files, `LIBOORA_BOUNDED_CONTEXT_MAP.md` and `tool/module_dependencies.yaml`. **No baseline re-issue** — §7 rule 4 moves the identifier only on a **Rank 1–3** version change and this matrix is **unranked, so it confers nothing**; the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G precedent. **No Dart source changed**; `git status --short lib/ test/` returns **0 lines**. |
| **v1.20** | 2026-08-23 | **Added the `PRD-020` Trust & Safety identifier inventory (§2O) — registering the `TSF-*` prefix stem that `PRD-020` v0.5 minted when it authored the `BC-13` moderation capability — and **CLAIMS Stage 5**, conferred at [`../30-product/trust-safety/PRD-020_STAGE5_CONFERRAL.md`](../30-product/trust-safety/PRD-020_STAGE5_CONFERRAL.md) in the form `PRD-008`/`PRD-013`/`PRD-014`/`PRD-016`/`PRD-017`/`PRD-023` used.** The pre-commit measurement is published with its command: `grep -c 'TSF-' TRACEABILITY_MATRIX.md` → **0**, so **400 identifiers across nine registers were registered nowhere** — the exact condition Stage 5 exists to prevent. Nine registers, **400 identifiers** (146 `TSF-FR-*` + 41 `TSF-BR-*` + 70 `TSF-XC-*` + 21 `TSF-INV-*` + 2 `TSF-EVT-*` + 30 `TSF-CFG-*` + 62 `TSF-AC-*` + 16 `TSF-GAP-*` + 12 `TSF-RSK-*`), **every register contiguous from `001`**, **0 phantom identifiers** (all nine `max+1` probes return 0), **0 dangling citations**, **zero collisions in FOUR directions**. ⛔⛔ **THE DECISIVE DIFFERENCE FROM EVERY PREDECESSOR: this is the LOWEST acceptance coverage ever registered in this matrix — 76/187 = 40.6%, with 111 obligations UNCOVERED — and it is registered at that figure rather than repaired to a flattering one.** Precedent is settled and was measured before relying on it: **§2E registered `PRD-007` at 73.4%**, **§2D `PRD-005` at 60.1%**, **§2M `PRD-017` at 71.2%**, **§2C at 94.6%** — Stage 5's gate is *"prefixes registered … with counts and ranges, verified mechanically, zero collisions"*, and **coverage is not in it**. What the gate forbids is an *unmeasured or overstated* figure, the `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%**. ⚠⚠ **THE OBVIOUS FIX WAS AVAILABLE AND IS REFUSED, and the refusal is the finding.** Minting 111 `TSF-AC-*` would take the register 62 → 173, falsify every count in §2O, and satisfy a gate nobody asked for — while repeating **at larger scale** the precise error Stage 4 caught in this same module days earlier, where a new `TSF-FR-*` was nearly minted for `TSF-AC-010` before **`TSF-FR-099` was found already stating the obligation** (`PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §4, a **retracted** finding). *A fix that moves a percentage by creating identifiers is not a fix; it is the defect Stage 5 registers against.* The 111 are **named by register** (83 `TSF-FR-*`, 28 `TSF-BR-*`) under `SID-4.56` and routed to `IMPL-1449`. ⚠⚠ **§2O.4 records TWO instrument defects, ZERO subject defects — the same ratio §2M and §2N reached independently, and one of them is a RECURRENCE of a defect this very module had already disclosed.** **`I-1`**: a register census counting **definition rows** returned `TSF-GAP-*` = **8** against a subject declaring **16**, because **8 of the 16 gaps are defined mid-sentence** (`` `TSF-GAP-009` **OPEN** — no referral transport exists… ``), a legitimate prose form the regex did not model; re-measured by **distinct-token occupancy** it is **16, contiguous**. ⛔ **Had 8 been published, this matrix would have registered a false count for a live register.** The identical blind spot is already recorded as `I-1` in `PRD-020_STAGE4_REQUIREMENTS_REVIEW.md` §5, where it falsely flagged `TSF-CFG-030` and `TSF-BR-030` as undefined — *a disclosed defect that recurs in a later instrument is evidence the disclosure was not read, including by its own author.* **`I-2`**: an `IMPL-*` phantom probe flagged `IMPL-1450` as written one past the declared maximum; **inspected at its line it is a range-boundary reservation** (*"`IMPL-1450`…`1499` reserved for the V2 community work of §25"*) that allocation **rule 2 positively requires** — **rejected as a finding**, the §2C.1 principle that a token must be read at its line, not counted. ⚠ **`TSF-` was not the naive stem.** `TS-` collides with nothing today and was rejected **before** measurement on §5 rule 3's reasoning — a two-letter stem in a repository already carrying `SM-`, `MM-`, `TEN-` and `SID-` shifts the whole cost of a future collision onto whichever document arrives second. Twenty stems were harvested from `docs/` and tested for containment **in both directions**; **0 collide**. **11 files outside the subject cite `TSF-*` and NOT ONE is a collision** — all **28** distinct identifiers resolve to definitions `PRD-020` owns, the §2C.1 *"a citation is not a collision"* principle, and the gate resolves each hit against the defined set rather than allow-listing files. ⚠ **Both instruments are committed and neither imports the other** — [`../../tool/docs_check/prd020_traceability.py`](../../tool/docs_check/prd020_traceability.py) never opens this matrix; [`../../tool/docs_check/prd020_stage5.py`](../../tool/docs_check/prd020_stage5.py) never trusts the subject's §0.2 table except to contradict it; **both reach 400 by structurally different routes**, avoiding §2H.2's named failure. **`prd020_stage5.py` was run BEFORE §2O existed and exited 1** — *"has no `## 2O.` section"* — because a gate that cannot fail is not a gate. ⚠ **`TSF-EVT-*` is registered CLOSED at two members** by an **external fact**, not an authorial choice: BC Map **L432**/**L433** publish exactly two `BC-13` events and §7 rules that a surface absent from the register does not exist, so a third is a **Rank 4 amendment requiring an ADR** (`TSF-GAP-004`). **No register is declared empty** — unlike §2N's three — so no `ADR-0051` §2.4 question arises here and none is manufactured. ⚠ **The subject's header reads v0.1 while its content is v0.5; the discrepancy is PUBLISHED, not normalised**, because amending it is a document-owner act. **Stage 5 ONLY.** ⛔ **No rank, no freeze, no `IMPL-*` allocation, no architecture closure, no gap closure, no `READY`** — §2O.3 refuses each explicitly and names the owner who could confer it. **All 16 `TSF-GAP-*` remain OPEN**, including the **implementation half of `TSF-GAP-003`**, which `TSF-BR-033` and §24.2 **L2046** make a bar to `READY`; `IMPL-1410` is **built and tested** (`PRD-020_IMPL-1410_IMPLEMENTATION_EVIDENCE.md`) but *built is not closed*, and closing it is an **Architecture Owner** act requiring an ADR that **does not exist**. `PRD-020` remains **`PLANNED`** at `PRD_REGISTRY.md` **L320** and **Unranked** — `DOCUMENTATION_BASELINE.md` contains **0** occurrences of `PRD-020`. **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO. Registers extended: ZERO. Edges added: ZERO. ADRs written: ZERO.** ⛔ **`PRD-020` is byte-unchanged** — sha256 `685fb65af95668df9bce8757bcd7d04ec9838a56f8dd108652e80d7e7579497b` before and after. **§2 through §2N are byte-unchanged**, as are `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, all **65** ADR files, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` and `tool/module_dependencies.yaml`. **No baseline re-issue** — §7 rule 4 moves the identifier only on a **Rank 1–3** version change, and this matrix is **unranked, so it confers nothing**; the `Baseline` field deliberately still reads `BASELINE-2026-08-04-D`, on the §2G precedent. **No Dart source changed**; `git status --short lib/ packages/ test/` returns **0 lines**. |
| **v1.19** | 2026-08-21 | **Corrected §2N — six false cells in §2N.2 and two in the §2N header block — under `ADR-0064` §4 item 6, which directs that the section be *"corrected, not rewritten"* with *"prior text retained verbatim beside the correction."* This is a **CORRECTION-ONLY pass on the v1.4 precedent** (*"§2C corrected"*), and it follows that precedent in incrementing the version: a correction is a change, and a matrix that silently corrects itself cannot be audited. ⛔⛔ **THE DECISIVE POINT: §2N.2 was a list of things the Stage 5 registration deliberately did NOT do, and Stage 7 subsequently DID six of them. A refusal that has been overtaken is not merely stale — read as current it is a FALSE STATEMENT ABOUT THE REPOSITORY'S PRESENT STATE**, and §2N.2 is the one section in this matrix a reader consults precisely to learn what `PRD-012a` does *not* hold. Each cell is therefore marked `SUPERSEDED`, `PARTLY SUPERSEDED` or `STILL TRUE IN SUBSTANCE`, the naming authority for the superseding act is cited, and **the prior text is retained verbatim inside the same cell** — `PRD_REGISTRY.md` §8 rule 5's direction to fix the register rather than the subject, applied to a register correcting itself. **Nothing was deleted.** ⚠⚠⚠ **ONE CLAUSE WAS NOT STALE BUT WRONG WHEN WRITTEN, and finding that out is the reason the Stage 7 admission was lawful rather than merely convenient.** The rank/freeze cell asserted the baseline's §4 precedence table holds *"13 Rank 3 module baselines and **every one is scoped to a bounded context or a named domain**"*, offered in support of the proposition that a platform-scoped Rank 3 row would be a new and unprecedented shape. Tested against §4 itself, the second half is **falsified by §4's own Library PRD row**, which scopes to *"Everything inside the **Library Management domain**"* — **a domain, not a `BC-nn`**. A non-`BC-nn` Rank 3 scope was therefore **already an established form**, and `PRD-012a`'s platform-scoped row is a **third instance of an existing shape rather than the first of a new one**. ⛔ **Had all 13 genuinely been `BC-nn`-scoped, the admission would have STOPPED and returned the row-shape question to the Architecture Owner** instead of proceeding; it proceeded on a **measured precedent**, recorded at `ADR-0064` §2.2 and now in the corrected cell. *A refusal repeated from a document's own earlier draft is still a claim, and it decays — or was never true — exactly like a count.* ⚠⚠ **THE GAP COUNT ROSE RATHER THAN FELL, and it is recorded because the intuitive direction is the wrong one.** A pass that resolves four blockers and five routed decisions would be expected to close gaps; instead **44 → 47** (**22 High · 23 Medium · 2 Low**), because `ADR-0060` opened `SECP-GAP-045` (**no exemption instrument exists** anywhere in `PRD_LIFECYCLE.md` for a platform that owns no bounded context — the lifecycle has **zero** exemption or waiver provisions, measured) and `ADR-0062` opened **`SECP-GAP-046`** and **`SECP-GAP-047`**. **All 47 remain OPEN. Not one `SECP-GAP-*` was closed by the Stage 7 pass**, and the *"confer architecture closure"* cell is therefore corrected only as to the three **routed conflicts** — `SECP-GAP-023` and `SECP-GAP-031` decided by [`ADR-0061`](../00-governance/adr/ADR-0061-alertability-rank-3-outranks-ea-v2-tag.md) on **Rank 1** `MP-RSK-01` L551, `SECP-GAP-042` by [`ADR-0062`](../00-governance/adr/ADR-0062-platform-security-outbound-reach-refused-as-ports.md), which **REFUSED all four proposed ports** and left `tool/module_dependencies.yaml` **byte-unchanged** — and **not** as to closure of the gap register. ⚠ **`SECP-GAP-042`'s own framing was falsified in passing and the correction is published:** the cell described `platform/security` having no manifest block as an *"anomaly"*; measured, **8 of 22 modules lack one and 0 of the 7 modules at ranks 1–3 have one**, so the absence is the **majority condition**, not an outlier. The quoted `default_decision: deny` rule *"was FOLLOWED, not set aside."* ⚠ **The byte-unchanged cell is corrected in BOTH directions rather than simply withdrawn.** Its Stage 5 claim was true of the pass that wrote it; the Stage 7 pass that followed **did** edit `DOCUMENTATION_BASELINE.md`, `PRD_REGISTRY.md` and `ADR-INDEX.md`, and says so. But two halves of the original claim **survive and are re-measured rather than assumed**: **§2 through §2M remain byte-unchanged**, and **no ADR file was modified** — the ADR count moves **59 → 64** because **five files were ADDED** (`ADR-0060`…`ADR-0064`), which is not the same event as an amendment and is not allowed to read as one. ⚠ **The baseline re-issue cell is superseded AS TO ITS PREMISE and UNCHANGED AS TO ITS RULE** — the identifier **has** advanced to **`BASELINE-2026-08-21-A`**, but **not by this section and not because this matrix changed**: §7 rule 4 moves it only on a **Rank 1–3 version change**, `PRD-012a` v0.8 is such a document, and **this matrix remains unranked, so it still confers nothing**. Consequently **the `Baseline` field in this header is deliberately NOT advanced** and still reads `BASELINE-2026-08-04-D`, on the §2G precedent recorded in that same field: an unranked document does not re-issue a baseline by editing itself. ⚠ **The §2N header's `Subject` cell moves `v0.8 DRAFT` → `v0.8 FROZEN at Rank 3`, and the version deliberately does NOT move with it** — `PRD-012a` is the **sixth v0.x document frozen at its authored version** in this repository, and the subject's **eight Parts are byte-identical to `bd85a31`**, verified by `git diff --stat bd85a31 HEAD` over all eight paths returning **EMPTY**. **No alignment supplement was therefore required and none was written**; freezing a document is not editing it. ⚠ **The *"does NOT confer"* cell is retained rather than deleted, with a distinction added that the original could not have drawn:** rank, freeze and the `IMPL-1300`…`1359` allocation were all conferred — **by other acts, in other documents, by named authorities** — whereas **architecture closure and gap closure were conferred by NO ONE**, and remain open. *The list did not become wrong; it became a list of two different kinds of thing, and it now says which is which.* **Registers extended: ZERO** — the register census stands at **427 identifiers across 15 registers, every one contiguous 1..max**, re-measured independently this pass and matching §2N exactly. **Identifiers minted: ZERO. Requirements changed: ZERO. Acceptance criteria changed: ZERO.** ⛔ **No `SECP-*` identifier, count, requirement or criterion in `PRD-012a` was altered to make any gate pass**, and the eight Parts were not opened for writing at all. **§2 through §2M byte-unchanged. No ADR file modified. No Dart source changed** — `git status --short lib/ packages/ test/` returns **0 lines**, and `lib/platform/security/` **does not exist** (measured). |
| **v1.18** | 2026-08-21 | **Added the `PRD-012a` Security Automation identifier inventory (§2N) — `PRD_LIFECYCLE.md` Stage 5 for a document that owns NO BOUNDED CONTEXT, the first such registration in this matrix.** **Fifteen registers, 427 identifiers**, every register **contiguous from 001** to its stated maximum, **0 duplicate declarations**, **0 phantom identifiers** (all 15 `max+1` probes return 0), **zero collisions in FOUR directions**. **109 normative requirements** (84 `SECP-FR-*` + 25 `SECP-BR-*`) bound by **128 `SECP-AC-*`** — coverage **109/109, 0 uncovered**, measured **paragraph-aware**. ⛔⛔ **THE DECISIVE DIFFERENCE FROM EVERY PREDECESSOR: this registration is granted to a PLATFORM, not a bounded context, and §2N.2 refuses rank explicitly rather than letting registration be mistaken for standing.** Every prior §2x registered a PRD owning a `BC-nn`; `PRD-012a` owns none and says so in its own header (*"the SECURITY platform is a platform, not a bounded context; it appears in no `BC-nn` row"*). Measured independently: **87 `BC-nn` rows** in the BC Map, and a case-insensitive search for a context named *security* returns **three hits, none of them a context definition** (`ID-1` at L178 is a rule, L434 is `BC-18`'s event list, L486 is *row-level security*, a mechanism). ⚠⚠⚠ **THE PREFIX IS `SECP-` BECAUSE `SEC-` WAS MEASURED AND REJECTED — at 155 hits.** `INV-SEC-001`…`071` is owned by the **Invitation Security Specification v1.0, Rank 3, in the baseline**, registered in this matrix at **L62**. `PRD_LIFECYCLE.md` §5 **rule 3** compelled the direction of the fix — *"on collision change the NEW prefix, never the existing one"* — so the new document moved and the frozen register did not. Had `SEC-` been taken, a citation of `SEC-004` would have been ambiguous between a frozen Rank 3 Library invariant and a security-platform requirement. The **four residual bare-`SEC-` hits** inside `PRD-012a` were each inspected and are all **`INV-SEC-*` citations in the prose explaining this very rejection** — *a citation is not a collision*, the §2C.1 principle. ⚠⚠ **The second-sharpest hazard is `SECP-SEV-*` against `PRD-003`'s `SEV-1`…`SEV-16`, and BOTH REGISTERS ARE LIVE** — a naive `SEV-\d+` scan would silently merge a Rank 3 register with this one. Measured in both directions: the anchored form does **not** match `SECP-SEV-001` **and still matches** `SEV-16` in ordinary prose, without which the negative result would prove nothing; three-digit members against one- and two-digit is a second independent discriminator. The **reverse** hazard (`SECP-` inside a longer token) is **absent in fact** — no `XSECP-`, no `SECPX`, no stem ending in `SECP` anywhere in `docs/` — so the `PROFIL-`/`FIL-` case §2M had to test for has no analogue. ⚠ **FOUR registers are CLOSED and may not be extended without an ADR** (§5 rule 6): `SECP-HRO-*` (12, closed by `SECP-BR-004`'s **default-refuse** rule, so extending it by one member without an ADR would silently authorise an operation the closure currently denies), `SECP-SIG-*` (10), `SECP-SEV-*` (4), `SECP-TST-*` (8). ⚠ **THREE registers are DECLARED EMPTY with published reasons, each absence a FINDING rather than an omission:** `SECP-INV-*` = 0 (**no owned aggregate** — `SECP-GAP-010`; an invariant implies an aggregate), `SECP-EVT-*` = 0 (**no `BC-nn` producer row**; minting one would assert an edge BC Map L292 says does not exist — `SECP-OWN-023`), `SECP-CFG-*` = 0 (would duplicate `PRD-001`/`PRD-023` — `SECP-XC-014`), on the **`PRD-016`** precedent where `AUD-EVT-*`/`AUD-CFG-*` were admitted empty because a default *"would have been a legal determination by a document with no standing to make one"* (`ADR-0051` §2.4). ⚠⚠ **§2N.4 records FOUR instrument defects, and IN ALL FOUR THE DOCUMENT WAS RIGHT AND THE TOOL WRONG** — the same ratio §2M found, reached independently. **`I-1`**: a testability regex reported **44 requirements lacking a normative keyword**, because it recognised only the bold ``**`ID`**`` form and missed the `` `ID` — `` prose form Parts 3–7 predominantly use; spot-checks showed `SECP-FR-019` carries **SHALL** and `SECP-XC-020` carries **MUST NOT**. **`I-2`**: a line-scoped coverage check reported `SECP-BR-002`/`003` uncovered — **false**, their criteria wrap onto continuation lines, and **Part 8 §5 had already documented this exact false-negative class before the instrument was written**. **`I-3`**: a definition locator reported `SECP-BR-004` undefined; it is defined as *"Closure rule — `SECP-BR-004`:"* at Part 2 L222, a legitimate variant heading form. **`I-4`**: a first per-Part count produced a false mismatch on Parts 1–2 by assuming Part 1 opened the functional register — **it does not; `FR-001`…`018` and `BR-001`…`008` belong to Part 2**. In all four the **instrument was corrected and the subject left untouched**; had any been trusted, this registration would have published corrections to 44 already-correct requirements, two unnecessary criteria, and one business rule wrongly reported as undefined. ⚠ **The phantom probe has caught real defects in this document TWICE, once self-referentially:** Part 4's first draft wrote a reserved placeholder one past its declared functional maximum, Part 7's wrote a *"not declared"* annotation one past its declared exclusion maximum, and **the paragraph codifying the rule against phantoms (`SECP-BR-025`) had itself written one** — the disclosure explaining why a token must not be written had written the token. Both removed; Part 8 §1.3 now describes their *positions* without reproducing the tokens. ⚠ **A genuine coverage defect was found by the document that asserts coverage:** `SECP-FR-084` was unbound while Part 8 §5 already claimed zero uncovered; `SECP-AC-128` was added and every dependent count corrected (**426→427, 127→128**). `SECP-AC-124` now requires re-measurement after any amendment *"because this criterion has already failed once against this document."* **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — the next free block is **`IMPL-1300`+**, established by measurement from `PRD-017_IMPLEMENTATION_TASKS.md` **L98** (`| IMPL-1300 + | Unallocated | — |`), ⚠ **explicitly NOT from `PRD_LIFECYCLE.md` L147–153, whose table is STALE at `IMPL-227+`** and which `PRD-017` also declined to follow. **No freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-012a`**, and its §4 precedence table holds **13 Rank 3 module baselines every one of which is scoped to a bounded context or named domain**, with a probe for a platform-scoped row returning **0**. **Three conflicts remain OPEN and are ROUTED, not decided** — `SECP-GAP-023` (Rank 1 `MP-RSK-01` **Critical** vs Rank 6 EA **V2**), `SECP-GAP-031` (Rank 3 **FROZEN** `AUTH-11.26`…`11.28` vs Rank 6 EA **V2**), `SECP-GAP-042` (`platform/security` has **no block** in `tool/module_dependencies.yaml` while `default_decision: deny` stands → `SECP-ADR-004`) — under `DOCUMENTATION_BASELINE.md` **L253**: *"A conflict is a defect. If you find one, do not choose — raise it."* All **44** `SECP-GAP-*` remain **OPEN** (22 High, 20 Medium, 2 Low). **Edges added: ZERO** (26 `E-nn` before and after). **Cells amended: ZERO. ADRs written: ZERO. Registers extended: ZERO.** `PRD-012a` stays **v0.8 `DRAFT`** and **`PLANNED`** at `PRD_REGISTRY.md` **L260**, and holds **no rank at all**. **§2 through §2M are byte-unchanged**, as are `PRD_REGISTRY.md`, `DOCUMENTATION_BASELINE.md`, all **59** ADR files, `LIBOORA_BOUNDED_CONTEXT_MAP.md` and `tool/module_dependencies.yaml`. `tool/docs_check/*.py` → **TOTAL NONZERO = 5 (baseline 5)**, no regression; the five pre-existing exit-1 checkers are **not** repaired and remain failing for their own recorded reasons. No baseline re-issue — §7 rule 4 moves the identifier only for a **Rank 1–3** version change, and this matrix is **unranked, so it confers nothing**. **No Dart source changed**; `git status --short lib/ packages/ test/` returns **0 lines**. |
| **v1.17** | 2026-08-20 | **Added the File & Media identifier inventory (§2M) — registering the `FIL-*` prefixes that `PRD-017` v0.1 minted when it authored the `BC-29` stored-object capability — and, like §2J, §2K and §2L, **CLAIMS Stage 5**, because both withholding reasons are discharged. ⛔ **But it does NOT claim architecture alignment, and a checker now enforces that refusal.**** The pre-commit measurement is published **with its regex**, per the §2K lesson: `grep -cE '(^\|[^A-Za-z-])FIL-(FR\|BR\|INV\|EVT\|XC\|AC\|CFG\|GAP)-[0-9]+'` → **0**, so **232 identifiers were registered nowhere**. Eight registers, **232 identifiers** (**132** obligation-bearing = 82 `FIL-FR-*` + 17 `FIL-BR-*` + 11 `FIL-INV-*` + **0** `FIL-EVT-*` + 22 `FIL-XC-*`, plus **78** `FIL-AC-*`, **9** `FIL-CFG-*` and **13** `FIL-GAP-*`) — **the largest register set yet registered here**, exceeding §2L's 180 — **0 retired**, every range **contiguous from 001**, **0 orphan criteria**, **0 dangling citations**, **0 duplicate definitions**, **zero collisions in all three directions**. ⛔⛔ **THE DECISIVE DIFFERENCE FROM EVERY PREDECESSOR: this registration is granted while an architecture dependency is UNRESOLVED, and the refusal to paper over it is MECHANISED rather than promised.** `FIL-GAP-012` is **OPEN** — BC Map **L331** lists `E-22`'s consumers as `BC-01`, `BC-10`, `BC-14`, and **`BC-12` Messaging is not among them**, while **L292** rules that *"if an edge is not in this table, it does not exist and adding it requires an ADR."* Student-to-student text **and file/media** sharing is retained in **V1**, so a `BC-12` consumer grant **is required and has not been made**. §2M.2's first row therefore refuses alignment explicitly, and **`prd017_stage5.py` check 10 FAILS THE RUN if §2M ever claims architecture alignment, Stage 6, or FROZEN status while the gap is open** — reading the gap's openness **from the PRD**, so the matrix cannot exempt itself by simply not mentioning it. **No comparable check exists anywhere else in this repository**, and it exists because the Stage 5 instruction for this module said, in terms, *"do not falsely mark alignment if a governance/architecture dependency remains unresolved."* ⚠ **The E-22 finding was NARROWED by measurement rather than accepted as stated.** The brief named `BC-11`, `BC-12` and `BC-13` as needing `PRD-017` File capability; Stage 3 tested necessity **per context** against BC Map §8 aggregate rows and found only **`BC-12`** needs it — `BC-11` Social Graph (**L377**, `Friendship`·`BlockList`) answers `canMessage` **without touching a file**, and `BC-13` Trust & Safety (**L379**, `ModerationCase`) reaches files via **`E-14`, which is OUTBOUND**. A repo-wide search for a `FileRef` obligation on `BC-11`/`BC-13`/`domain/social` returns **0 results**. Recorded as `S3-A-01`: the required amendment is **one consumer cell, not three**, on the **`ADR-0016`** precedent whose §4.3 names over-broad amendment as the **High** risk with mitigation *"One cell, one edge, named explicitly."* **A narrower finding is a stronger finding, and it was reached by measuring each context separately rather than by trusting the brief.** ⚠ **Freezing with an OPEN `E-22` consumer gap has PRECEDENT, verified rather than assumed:** `PRD-006_ATTENDANCE-MANAGEMENT.md` **L1564** and **L2973** show `ATT-GAP-010` — `BC-03` absent from `E-22`, *"OPEN — needs an ADR"* — carried **through freeze**. So an unresolved `E-22` question does not by itself bar the lifecycle; it must be **carried transparently**, which is what §2M.2 does. **The two withholding reasons, discharged rather than argued away: (1)** the **no-role-holder** objection (`PGA-08`) is discharged by conferral at `PRD-017_STAGE5_CONFERRAL.md` in the form §2J/§2K/§2L used — ⚠ **`PGA-08` is a standing gap and is NOT cured** (`ADR-0033` §7.1, per-act not standing); **(2)** the **no-committed-checker** objection is discharged **by construction**, with `prd017_traceability.py` and `prd017_stage5.py` committed under `tool/docs_check/`, **neither importing the other** and parsing by **different strategies** — one classifies **lines** by form and never opens the matrix, the other splits at **both `## ` and `### `** and accepts an identifier only where that scope may define it, via a **24-entry authorisation table derived from a MEASUREMENT of the document rather than guessed**, because a guessed table either forbids what the document legitimately does or permits a scope it never uses. **Both reach 232 by structurally different routes**, and both independently reproduce **132 Class A / 94 covered / 71.2% / 38 uncovered** — §2H.2's named failure, *"a checker written in the same pass as the register it checks, by the same author, verifies agreement with itself"*, avoided in fact. ⚠ **`prd017_stage5.py` was run BEFORE §2M existed and exited 1** — *"has no section 2M — the gate is the registration, not the intention to register"* — while still recomputing **232** across 7 non-empty registers: **a gate that cannot fail is not a gate.** ⚠⚠ **`prd017_traceability.py` was MUTATION-TESTED THROUGH THREE ROUNDS, and the first two rounds FAILED — which is the point.** Round 1 (8 mutants): **M6 and M8 escaped**. **M6** corrupted the authoritative total **232 → 999** and passed, because that total is **itself a blockquote** (`> **Totals: 232 identifiers…`) and the `>`-exclusion built to ignore quoted dead numbers **had swallowed the single most important live number in the document**; the vacuity guard missed it too, because *a guard that counts claims cannot detect the loss of the RIGHT claim* — fixed as **`S5-C-03`** by narrowing the exclusion to correction-note markers (`⚠`, *"Corrected at Stage"*, *"As first written"*) and adding **check 10a** asserting the `Totals:` line stays in scope. **M8 was a BAD MUTANT, not a gate blind spot** — it injected a second definition site for `FIL-BR-013`, which carries no `SHALL`/`MUST` and so was never a valid definition; it was **replaced with a `FIL-FR-024` mutant rather than counted as a kill**, and the replacement was killed. Round 2 (12 mutants): **M11 escaped** — dropping `FIL-XC-008` from the exception **sentence** still passed because the identifier is cited later within the same 4000-character window: *a membership test over too wide a window cannot distinguish "named as an exception" from "mentioned nearby"; **scope, not pattern, was the defect***, fixed as **`S5-C-04`** by delimiting the sentence precisely from `are the exception` to the following `The remaining`. **Round 3: 14 mutants, 14 killed, 0 escapes, baseline still PASS.** ⚠ **§2M.4 records FOUR defects the checkers found IN THEMSELVES, and in ALL FOUR the PRD was right and the instrument wrong** — the **third** time in this module's history a census tool has blamed a correct document, after bold-wrapped `FIL-GAP-*` table rows defeated a prose-only regex at Stage 2 and a register census under-counted two registers by 22 at Stage 4. Beyond `S5-C-03`/`S5-C-04` above: **`S5-C-01`** — the coverage rule demanded every uncovered obligation be named individually and reported **17 undisclosed `FIL-XC-*`** against a document that discloses them **as a CLASS** with a determinate complement (*"all `FIL-XC-*` except `FIL-XC-008`, `019`, `020`, `021`, `022`"*); "fixing" the document would have **DEGRADED** a stale-proof rule into an enumeration that decays whenever a criterion is added, so the rule was made **stronger** — a class claim is accepted only if its **arithmetic is true** (22 − 5 = 17), which an enumeration check never tested. **`S5-C-02`** — the same run reported *"prose states 114"* against a true 132, where the string existed **only inside a `>` correction note quoting the dead figure**: *a checker that cannot tell a live claim from a quoted dead one **punishes disclosure and rewards silent edits***. **No PRD content was changed to make a checker pass.** ⚠ **The Stage 4 review EDITED ITS SUBJECT, departing from `PRD-023`'s precedent, and the consequence is disclosed rather than hidden.** `PRD-023`'s Stage 4 record argues a review must not edit its subject because it invalidates the recorded hash; the instruction here was *"fix only genuine PRD-017 defects"*, so **six** were fixed and **both** hash endpoints are published (`880de96a…` → `202ccf5e…`, then further changed by the sixth fix). The downstream effect — `PRD-017_ARCHITECTURE_ALIGNMENT.md`'s subject hash `85adb6fa…` is now **stale** — is disclosed in §2 of the Stage 4 record with a before/after table on the `PRD-023_STAGE7_FREEZE.md` §3 pattern, and **not repaired**: *"a stale review is corrected by a dated re-run beside it, not by editing what it concluded."* All edits were **non-boundary** — **0 edges, 0 consumers, 0 aggregates, 0 ranks, 0 isolation classes** — so Stage 3's conclusions survive. ⚠ **Two of the six Stage 4 defects were INTRODUCED BY THE REVIEW'S OWN REPAIRS**, and the detector that caught them was the right one: wording similarity between `FIL-AC-058` and the newly added `FIL-AC-077` was only **0.55** — below any usable threshold, because they are genuine paraphrases — but **citation-set comparison** found an **exact collision** on `('FIL-FR-076', 'FIL-XC-019')`. *Two criteria that cite exactly the same requirements are testing the same thing, whatever they sound like*, and **a review that repairs a requirement must re-run duplicate detection over its own additions**, because the fixer is the party least likely to notice that the fix restates something. Investigating it exposed a **sharper** defect underneath: `FIL-FR-075` listed **five** grant properties with no eligibility-decision reference while `FIL-FR-076` obliged **recording** one — not redundancy but **unimplementable**, and no criterion could have proven it either way (`S4-D-04`). ⚠ **And a self-refuting sentence survived three passes:** §14.3 read *"114 obligation-bearing identifiers (82 + 17 + 11 + 0 + 22)"* — a breakdown that **sums to 132** — with the ratio two lines below reading `94 of 132`. The claim contradicted **its own parenthesis** and **its own neighbour**, and was found only because the new checker **recomputed instead of reading** (`S4-D-06`). **A count written in prose is a claim, and it decays every time the thing it counts changes.** Coverage is published as **94 / 132 = 71.2%**, unrounded, with **⛔ 0 of 78 criteria proven by a passing test** because no implementation exists, and **0 undisclosed** uncovered obligations. The 38 uncovered are classified rather than merely counted — **17 `FIL-XC-*`** (uncovered **by construction**, since an exclusion states what must be *impossible* and a criterion asserting something never happens is **unfalsifiable by observation**; **five exclusions ARE covered** — `FIL-XC-008`, `019`, `020`, `021`, `022` — each having an observable positive consequence), plus **17 `FIL-FR-*`**, **3 `FIL-BR-*`** and **1 `FIL-INV-*`** that are definitional. The `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated, and check 8 fails the run if the figure drifts. ⚠ Contrast §2L, where `PRD-023` **over-declares** its uncovered set by three: that document is wrong in the **safe** direction, this one in **neither**, and the difference was established by measurement rather than by reading either claim. ⚠⚠⚠ **The inward substring hazard is STRICTLY SHARPER than §2L's, and the difference is arithmetic rather than rhetorical.** §2L called its `CFG-` hazard the sharpest any module had carried — but `CNF-CFG-*` is **EMPTY**, so a naive sweep would have counted members of a register with none. Here **both registers are live**: `CFG-1`…`CFG-12` owned by `PRD-001` (**FROZEN v2.0**) and **`FIL-CFG-001`…`FIL-CFG-009`** owned by this module, so a naive `CFG-\d+` scan would **silently merge two live registers owned by two different documents, one of them FROZEN**. Measured `re.search(r'(?<!\[A-Z-\])CFG-\d+', 'FIL-CFG-001')` → **no match**, **and** the anchored form is asserted to **still match** its own member, without which the negative result would prove nothing. Same treatment for `INV-1`…`INV-16`. ⚠ **The REVERSE hazard is absent IN FACT but PRESENT IN TEXT — which no predecessor carried.** A lookbehind scan across all of `docs/` returns **exactly one context**: `PRD-017` §0.4's own sentence recording `grep -roE '\b\[A-Z\]*FIL-'` → 0 matches and naming *"a hypothetical `PROFIL-`"*. That is prose **about** a pattern, so check 4b asserts the anchored form **rejects** `XFIL-FR-001`, `PROFIL-FR-001` and `AFIL-CFG-001` **and still finds** `FIL-FR-001` in ordinary prose — **the document's own claim about itself is tested, not believed.** Check 4c additionally **fails as vacuous if fewer than 50 files are scanned**, and check 4a **fails as vacuous if zero prefix stems are parsed** — guards §2L did not carry, so "no collision" can never be an artefact of not looking. ⚠ **One register is registered AS EMPTY rather than omitted, and its emptiness is ARCHITECTURAL:** `FIL-EVT-*` is empty because **BC Map §9 carries no `BC-29` producer row** and L292 rules that an absent edge does not exist — so `PRD-017` §13.2 draws the consequence its predecessors did not have to: **`E-20` is NOT AVAILABLE to this module**, and the audit obligation cannot be routed the way `PRD-023` routed its own via `CNF-FR-052`. Minting even one numbered member of this register would **assert an edge the BC Map does not carry**; check 7 fails if a member ever appears. **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — `docs/40-implementation/file-media/` **does not exist**; the next free block is **`IMPL-1200`+**, established by measurement from `PRD-023_IMPLEMENTATION_TASKS.md` **L88** (reserving `IMPL-1130`–`1199`) and **L89** (`\| IMPL-1200 + \| Unallocated \| — \|`), ⚠ **explicitly NOT from `PRD_LIFECYCLE.md` L147–153, whose table is STALE at `IMPL-227+`**; **no freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-017`**, the only place freeze can be conferred; **no verification** — registered is not verified. **Edges added: ZERO. Cells amended: ZERO. ADRs written: ZERO.** All **13** `FIL-GAP-*` remain **OPEN**, including `FIL-GAP-012` above and the missing `platform/services` manifest block (`FIL-GAP-010`). `PRD-017` stays **v0.1 `DRAFT`** and **`PLANNED`** at `PRD_REGISTRY.md` L307, and holds **no rank at all**. **§2 through §2L are byte-unchanged**, as are `PRD_REGISTRY.md`, all **53** ADRs, `LIBOORA_BOUNDED_CONTEXT_MAP.md`, `tool/module_dependencies.yaml`, and **all 23 pre-existing scripts** under `tool/docs_check/` — the two new files **add** checks and weaken none. The **5** pre-existing exit-1 checkers are **not** repaired and remain failing for their own recorded reasons. ⚠ `GCP-20`, `GCP-21`, `PRD_DEPENDENCY_GRAPH.md:113`'s stale *"PRD-002 owns BC-29"*, and the stale `PRD_LIFECYCLE.md` IMPL table are **carried forward, not repaired** — none is a Stage 5 act. No baseline re-issue — `PRD-017` is `DRAFT` at v0.1 and this matrix is **unranked**, so it confers nothing. **No Dart source changed**; `git status --short lib/ packages/ test/` returns **0 lines**. |
| **v1.16** | 2026-08-20 | **Added the Settings & Configuration identifier inventory (§2L) — registering the `CNF-*` prefixes that `PRD-023` v0.1 minted when it authored the `BC-25` resolution machinery — and, like §2J and §2K, **CLAIMS Stage 5**, because both withholding reasons are discharged.** The pre-commit measurement is published **with its regex**, per the §2K lesson: `grep -cE '(^\|[^A-Za-z-])CNF-(FR\|BR\|INV\|EVT\|XC\|CFG\|AC\|GAP)-[0-9]+'` → **0**, so **180 identifiers in a document scoped by an ACCEPTED ADR were registered nowhere**. Eight registers, **180 identifiers** (**113** obligation-bearing = 82 `CNF-FR-*` + 11 `CNF-BR-*` + 4 `CNF-INV-*` + **0** `CNF-EVT-*` + 16 `CNF-XC-*`, plus **59** `CNF-AC-*` and **8** `CNF-GAP-*`) — **the largest register set yet registered here**, twice §2K's 88 — **0 retired**, every range **contiguous from 001**, **0 orphan criteria**, **0 dangling citations**, **zero collisions in all three directions**. ⚠⚠ **The two inward substring hazards are SHARPER here than in any predecessor, and both are tested rather than asserted. (1)** `CFG-1`…`CFG-12` is an **OCCUPIED** register owned by `PRD-001` (`FROZEN` v2.0) while the colliding sub-register `CNF-CFG-*` is **EMPTY**, so a naive `CFG-\d+` sweep would report members of a register that has none; the anchored measurement published in §2L.1 returns **no match** in either direction. **(2)** `INV-1`…`INV-16` are **this module's own subject matter** — §2A.1 records three prior meanings, bare `INV-n` occurs **23 times in this file**, and `PRD-023` §5 *is about enforcing* `INV-1`…`INV-16` while defining `CNF-INV-001`…`004` **in the same section**: the highest density of the `PO-n`/`SPO-n` class in the repository. Neither direction matches. ⚠ **The REVERSE hazard, unlike §2K's, is measured ABSENT rather than manufactured.** A corrected lookbehind scan `(?<=[A-Za-z0-9])CNF-` across `docs/ tool/ lib/ test/` returns exactly **3** hits, **all the `b` of the regex escape `\bCNF-`** inside quoted grep commands — prose *about* a pattern, not words embedding the prefix. `ENT-` needed a `MANAGEMENT-`/`ALIGNMENT-` decoy because that hazard was real; **inventing one here would have proved nothing**, so §2L states absence and tests only what exists. **The two withholding reasons, discharged rather than argued away: (1)** the **no-role-holder** objection (`PGA-08`) is discharged by conferral at `PRD-023_STAGE5_CONFERRAL.md` in the form `PRD-008`/`PRD-013`/`PRD-016`/`PRD-014` used — ⚠ **`PGA-08` is a standing gap and is NOT cured** (`ADR-0033` §7.1, per-act not standing); **(2)** the **no-committed-checker** objection is discharged **by construction**, with `prd023_traceability.py` and `prd023_stage5.py` committed under `tool/docs_check/`, **neither importing the other** and parsing by **different strategies** — one classifies **lines** by form, the other splits at **both `## ` and `### `** and accepts an identifier only where that scope may define it, via a **37-entry authorisation table**, the largest here, because `PRD-023` defines `CNF-FR-*` across **21 distinct scopes** where `PRD-014` used six. **Both reach 180 by different routes**, which is the evidence the pair exists to produce; §2H.2 names the failure it avoids — *"a checker written in the same pass as the register it checks, by the same author, verifies agreement with itself"*. ⚠ **`prd023_stage5.py` was run BEFORE §2L existed and exited 1** — *"has no section 2L — the gate is the registration, not the intention to register"* — while still recomputing 180: a gate that cannot fail is not a gate. **Mutation-tested: 12 defects injected, 12 caught**, each by the script owning that class — **matrix-side 5/5** (FR count 82→81; Total 180→179; coverage 76→77; §2L deleted entirely; the `CNF-EVT-*` empty row removed, *"an omitted empty register is indistinguishable from an oversight"*), all five correctly **invisible** to the checker that never opens the matrix; **PRD-side 7/7** (a contiguity break caught by **both**; **minting a numbered member into each of the two registers declared EMPTY** — the precise Stage 5 prohibition — each caught; an obligation stripped from the Coverage paragraph; a **stale §14 cross-reference**; and two **scope violations** injected into §12.1 — an out-of-range invariant and an in-range business rule — the second leaving contiguity **intact**, so the scope-authorisation rule is the *only* thing that can catch it). ⚠ **The twelfth result was initially a MISS, and was driven to root cause rather than believed in either direction:** the first scope-violation injection used a `sed` address matching a **table-row** form, but §12.1 defines requirements as `**\`CNF-FR-076\`** — …` prose, so the mutation **never applied** — a **harness** defect, not a gate blind spot; re-run against the real line form, both variants fail loudly by name. Both documents were restored **byte-identical**, verified by sha256 (`e974960…`) after every mutation. Coverage is published as **76 / 113 = 67.3%** — ⚠ **the LOWEST figure this matrix has ever published, stated plainly rather than softened** — with **⛔ 0 of 59 criteria proven by a passing test** because no implementation exists, and **all 37** uncovered obligations **named** in §13's Coverage paragraph, located **by anchor rather than a fixed line slice** (the `S4-C-02` lesson). It is low for a **structural** reason, not a careless one: **all 16 `CNF-XC-*` are uncovered by construction**, because an exclusion states what must be **impossible** and a criterion asserting something never happens is **unfalsifiable by observation**; the remaining 21 are definitional `CNF-FR-*` and 3 rule-restating `CNF-BR-*`. The `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated, and both scripts fail the run if the figure drifts. ⚠ **`S4-D-01` is DISCLOSED, NOT REPAIRED: the document OVER-declares its own uncovered set by three** — the Coverage paragraph names **40** where only **37** are uncovered, since `CNF-XC-005`/`008`/`014` *are* cited by `CNF-AC-038`/`041`/`048`. It therefore **understates** its own verification coverage, the **safe** direction and the exact opposite of the failure the check guards; repairing it would change the PRD's `sha256` and invalidate the Stage 3 and Stage 4 measurements taken at hash `e974960…` — the precise drift `alignment_record_freshness.py` exists to catch. ⚠ **§2L.4 records two defects the checkers found IN THEMSELVES, and in both the PRD was right and the instrument wrong: (1) `S5-C-01`** — the inherited **line-start** definition rule accused §14 of claiming **six of seven** gaps were raised in the body when no body site existed; root-causing showed `PRD-023` raises gaps **INLINE, mid-sentence** (*"Recorded as `CNF-GAP-001`."*), only `CNF-GAP-006` happening to begin its line. The fix was made **stronger, not weaker**: §14 states not merely *that* each gap was raised but **where**, so every `CNF-GAP-nnn at §x.y` pointer is now resolved against that section's actual text — **a stale pointer now fails, which the line-start rule could never detect**. **(2) `S5-C-02`** — the first reverse-hazard scan returned **645** hits by reading the first character of its own match instead of the character before it; had it been believed, an elaborate decoy test would have been built **proving nothing**, since the hazard does not exist for this prefix. **No PRD content was changed to make a checker pass.** ⚠ **Two registers are registered AS EMPTY rather than omitted**, and `CNF-CFG-*` is **the most consequential empty register in the repository, because the module that owns configuration owns no configurable**: `PRD-023` owns the **resolution machinery, not the value list** (`ADR-0017` §3.1 item 6), and the clean census places **all 104** configurables with **8 other owning PRDs, every one FROZEN** — `CFG-1`…`12`, `LCFG-1`…`13`, `ICFG-1`…`10`, `SCFG-1`…`11`, `SMCFG-1`…`7`, `MM-CFG-001`…`009`, `SEAT-CFG-001`…`018`, `ATT-CFG-001`…`024`. `CNF-EVT-*` is empty because **`BC-25` publishes no domain event** — BC Map §9 producer rows for `BC-25`: **0**. Emptiness is verified **real, not merely described** (`grep -cE '\bCNF-CFG-[0-9]+'` → **0**) and is now **enforced as a test**: both checkers fail if a numbered member ever appears. ⚠ Deliberately **unlike `TEN-CFG-001`**, which was issued then retired, **no `CNF-CFG-*` or `CNF-EVT-*` number is burned at all** — Stage 5 **looked** for authoritative evidence requiring one and found none. **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — `docs/40-implementation/configuration/` **does not exist** and the next free block is **`IMPL-1100`+**, established by measurement and by `PRD-014_IMPLEMENTATION_TASKS.md` **L124** (`IMPL-1100 + \| Unallocated`), ⚠ **explicitly NOT from `PRD_LIFECYCLE.md` L147–153, whose table is STALE**; **no freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-023`**, the only place freeze can be conferred; **no verification** — registered is not verified. All **8** `CNF-GAP-*` remain **OPEN**, including `CNF-GAP-007` (no `platform/configuration` block in `tool/module_dependencies.yaml`, which `check_module_boundaries.dart` **L778** exempts from the deny default) and `CNF-GAP-008` (all **seven** §10.3 architecture tests missing, `SID-4.56`: *"A rule that cannot be checked SHALL be treated as unmet"*). `PRD-023` stays **v0.1 `DRAFT`** and **`PLANNED`** at `PRD_REGISTRY.md` L327, and `ADR-0017` §3.1/§3.2 scope is **preserved unaltered** — §3.2's *"This ADR moves no requirement"* still holds, **0 requirements moved**. `ADR-0017` §5.3's pre-registered number-collision risk, *"Deferred to Stage 5, which is the stage that decides it mechanically"*, is **now decided: zero collisions in three directions**. **§2 through §2K are byte-unchanged**, as are all four `PRD-023` documents (the PRD at `e974960…`, re-verified before and after every mutation), `PRD_REGISTRY.md`, all **53** ADRs, and **all 21 pre-existing scripts** under `tool/docs_check/` — the two new files **add** checks and weaken none. The five pre-existing exit-1 checkers are **not** repaired and remain failing for their own recorded reasons. ⚠ **`GCP-20` is carried forward, not repaired:** `DOCUMENTATION_BASELINE.md` §4 is missing its `PRD-014` Entitlement row, an **unrelated** governance defect whose repair is not a Stage 5 act. No baseline re-issue — `PRD-023` is `DRAFT` at v0.1 and this matrix is **unranked**, so it confers nothing. **No Dart source changed**; `git status --short lib/ packages/ test/` returns **0 lines**. |
| **v1.15** | 2026-08-19 | **Added the Entitlement identifier inventory (§2K) — registering the `ENT-*` prefixes that `PRD-014` v0.1 minted when it authored the `EntitlementSet` aggregate — and, like §2J, **CLAIMS Stage 5**, because both reasons that withheld it from `PRD-013` are discharged.** ⚠ **The pre-commit measurement is published WITH ITS REGEX, because the bare `grep -c 'ENT-'` form §2G…§2J each used is UNSAFE for this prefix:** `ENT-` occurs as a **substring of ordinary governance vocabulary** — `MANAGEMENT-` (11 occurrences repo-wide) and `ALIGNMENT-` (1) — so the loose command reports **phantom identifiers**. Inside this file the anchored and unanchored counts happened to agree at **0**, which would have been *luck, not method*. The measurement actually taken was `grep -cE '(^\|[^A-Z-])ENT-(FR\|BR\|INV\|EVT\|XC\|CFG\|AC\|GAP)-[0-9]+'` → **0**, so **88 identifiers in a Rank-3-registered document were registered nowhere** — the condition Stage 5 exists to prevent. Eight registers, **88 identifiers** (**54** obligation-bearing = 28 `ENT-FR-*` + 8 `ENT-BR-*` + 6 `ENT-INV-*` + **0** `ENT-EVT-*` + 12 `ENT-XC-*`, plus **26** `ENT-AC-*` and **8** `ENT-GAP-*`), **0 retired**, every range **contiguous from 001**, **0 orphan criteria**, **0 dangling citations**, **zero collisions in all three directions**. Contiguity is judged over a set where **declared EQUALS in force** (as `PRD-016`, unlike `PRD-013`'s 12 retirements), and both scripts fail if a retirement section ever appears. **The two withholding reasons, discharged rather than argued away: (1)** the **no-role-holder** objection (`PGA-08`, *"Every PRD needs a named owner. None has one"*) is discharged by conferral at `PRD-014_STAGE5_CONFERRAL.md` in the identical form `PRD-008`/`PRD-013`/`PRD-016` used — ⚠ **`PGA-08` is a standing gap and is NOT cured**, the conferral being per-act, not an owner appointment (`ADR-0033` §7.1); **(2)** the **no-committed-checker** objection is discharged **by construction**, with `prd014_traceability.py` and `prd014_stage5.py` committed under `tool/docs_check/`, neither importing the other and **parsing by different strategies** — one classifies **lines** by form, the other splits at **both `## ` and `### `** and accepts an identifier only where that scope may define it. **Both reach 88 by different routes**, which is evidence. ⚠ **`prd014_stage5.py` was run BEFORE §2K existed and exited 1** with *"has no section 2K — the gate is the registration, not the intention to register"* while still recomputing 88 from the PRD body: a gate that cannot fail is not a gate. Coverage is published as **51 / 54 = 94.4%**, **not** rounded or softened, with **⛔ 0 of 26 criteria proven by a passing test** because no implementation exists (`docs/40-implementation/entitlement/` does not exist; `lib/platform/business/business.dart` has **no test file at all** — `D-014-05`), and the **3** uncovered obligations **named** with reasons: `ENT-FR-017` (proving *no caller needs a duplicate limit* would test `BC-04`'s and `BC-02`'s code), `ENT-FR-018` (the configured disposition **does not exist**, `ENT-GAP-002`, and a criterion would name an invented value), `ENT-FR-026` (depends on `H-1`). ⚠ **The reverse-coverage figure was recomputed from §0.2's DECLARED RANGES rather than from what the document cites**, so an obligation omitted from **both** §10 and §10.1 would still have been caught; agreement between a table and a recomputation reading that same table would be worthless. The `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated, and check 8 fails the run if the figure drifts. ⚠ **§2K.4 records TWO defects the checkers found in THEMSELVES, and in both the PRD was right and the instrument wrong: (1) `S5-C-01`** — `PRD-016` §0.2 puts the **range span** in cell 0 while `PRD-014` puts the **bare prefix** there, so the inherited `declared_counts()` read **zero** declared registers and reported all eight as undeclared: **a catastrophic false FAIL**, and the §2J.4 defect-1 class recurring **one structural layer up**, an instrument encoding the previous document's *layout* rather than the *rule*. Fixed by accepting three §0.2 shapes, **failing loudly on a fourth**, and adding an `if not published: fail()` guard so a parser that reads nothing can never report a clean run. **(2) `S5-C-02`** — §10.1's coverage table opens rows with `` \| `ENT-FR-017` \| ``, indistinguishable from a definition, producing **EXIT=1** with three **phantom duplicate definitions** (`ENT-FR-017`/`018`/`026`); `PRD-016` never hit this because it names uncovered obligations in **prose**. Fixed **positionally** by masking `### 10.1 Coverage` while **preserving original line numbers**, guarded to fail if that section is renamed so the fix cannot rot into a blanket exemption. **No PRD content was changed to make a checker pass.** ⚠ Two further instrument defects from Stage 4 are cross-referenced, not re-litigated: **`S4-C-01`**, a modality regex testing only `SHALL`/`MUST` that reported **10 false failures** and would have caused a **false FAIL of Stage 4 check 1**, and **`S4-C-02`**, a citation regex that falsely flagged `ENT-FR-001`/`ENT-FR-019` for citing **inline** — **four instrument defects across two stages, all disclosed, none hidden.** ⚠⚠ **A DEFECT IN §2J'S OWN PROSE is disclosed as `S5-F-01` (Low, traceability owner) rather than silently not inherited, and §2J is NOT edited:** §2J.1 calls a bare `FR-*` register *"the live case"* and attributes it to *"the Authentication chapter map"*, but the **only** bare `FR-` tokens in this file are §2I's and §2J's own hazard prose plus the v1.14 entry — the `## 3. Chapter map` columns are headed `AUTH`, `BR`, `XC`, `AC`, with **no `FR` column**. Bare `FR-\d+` does exist elsewhere in `docs/` (`README.md` L111–112, `ADR-INDEX.md` L75, `ADR-0018` L45), so the hazard **class** is real and §2J's **conclusion** is correct; only its stated **location** is wrong. Disposition **DISCLOSED not repaired** — amending a baselined section is not a Stage 5 act, and *"a stale review is corrected by a dated re-run beside it, not by editing what it concluded"*. ⚠ **The substring hazard is LIVE here in BOTH directions and is tested in both:** inward, **`INV-n` already names THREE registers** per this matrix's own §2A.1 — platform invariant (`INV-1`…`INV-16`, `CONFIGURATION_GUIDE.md` §3), `INV-SEC-n` and `INV-XC-n` — with bare `INV-n` occurring **23 times in this file**, and sharpened because `PRD-014` §0.3 **legitimately cites `INV-4`**, so both registers coexist in one document; `(?<![A-Z-])INV-\d+` against `ENT-INV-001` returns **no match** and `ENT-` against `INV-4` returns **no match**. Outward, the `MANAGEMENT-`/`ALIGNMENT-` substring case above — **unique to this prefix among all five registered so far.** ⚠ **Two registers are registered AS EMPTY rather than omitted**, because an omitted empty register is indistinguishable from an oversight: `ENT-EVT-*` because **`BC-21` publishes no domain event** — it appears in exactly three BC Map §9 rows (**L435**, **L436**, **L437**) and in **every one** sits in the **consumer** column, producer rows **0** — with `ENT-FR-024` stating the prohibition positively so emptiness is **enforceable rather than incidental**; and `ENT-CFG-*` because **BC Map L326 (`E-17`) points at a Config register that DOES NOT EXIST** (*"decided per feature, recorded in Config"*), Rank 7 `CONFIGURATION_GUIDE.md` returning **7 hits, every one an OTP/SMS value**. ⚠ Emptiness verified **real, not merely described**: `grep -cE '\bENT-CFG-[0-9]+'` → **0**, plus a complementary numeric-literal scan across all **42** requirement texts finding **0** hardcoded durations, counts or percentages, so no tunable is smuggled in under another register. Deliberately **unlike `TEN-CFG-001`**, which was issued then retired, **no `ENT-CFG-*` number is burned at all**. **No configuration value, fail disposition, grace period or business rule was invented**: `Q-03` (fail-open vs fail-closed) and `Q-06` (proration ownership) stay **Open** at Rank 4 (BC Map L542, L545) and Rank 1 (`MASTER_PRD.md` L675, L678), recorded as gaps and **not answered** — BC Map §13's preamble says each *"should become an ADR"*. **Edges added: ZERO** — `PRD-014` §7.1 records it, and `E-17` already exists at BC Map L326 and is cited, not created. **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — `docs/40-implementation/entitlement/` **does not exist**; the next free block is **`IMPL-1000`+**, established **by measurement** (489 distinct `IMPL-\d+` repo-wide, tail `…927, 928, 929, 930, 999, 1000`, and all **5** `IMPL-1000` occurrences are **boundary labels**, not assignments) and ⚠ **explicitly NOT from `PRD_LIFECYCLE.md` L147–153, whose `IMPL-014`…`IMPL-227+` table is STALE** — `IMPL-227` is held by Student Identity growth; **no freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-014`**, the only place freeze can be conferred; **no verification** — registered is not verified. All **8** `ENT-GAP-*` remain **OPEN**. `PRD-014` stays **v0.1 `DRAFT`** and **`PLANNED`** at `PRD_REGISTRY.md` L304. **The six code contradictions are recorded, not repaired**: `D-014-01` (`check(Feature f, {int delta = 1})` carries **no `tenantId`**, against `E-17`'s stated signature), `D-014-02` (silent `_tier` default to `TenantTier.starter`, against `MP-GBR-07`'s *"fails loudly, never defaults"*), `D-014-03`/`04` (hardcoded `_limits`/`_gates` and in-memory `_usage`, against `ENT-INV-001` recomputability), `D-014-05` (**no test file at all**) and `D-014-06` (`seed.dart:95–96` direct write, against `X-11`/`BZ-1`) all await Stage 8; `lib/`, `packages/` and `test/` are **byte-unchanged** and `git status --short lib/ packages/ test/` returns **0 lines**. **The shared-module question is NOT resolved**: `BC-21` shares `platform/business` with `BC-20` where `ADR-0035` L123 permits *"exactly two"* contexts; whether a physical split is needed is `ENT-GAP-006`, **open and owned by the Architecture Owner**, and none is asserted or designed. **`S4-F-03` is left unrepaired** — `PRD-014_ARCHITECTURE_ALIGNMENT.md` carries **no "PRD hash at review" row** while `alignment_record_freshness.py` requires *"at least one 64-hex candidate"* or fails *"anchor missing"*; whether a dated supplement is owed is the **architecture reviewer's** decision, and editing a review record in place is the precise act that gate exists to prevent. **§2 through §2J are byte-unchanged**, as are all four `PRD-014` documents (`PRD-014_ENTITLEMENT.md` at `d4ca7e11…c175`, re-verified before and after this pass), `PRD_REGISTRY.md`, all **51** ADRs, and **all 16 pre-existing scripts** under `tool/docs_check/` including `prd016_stage5.py` and `prd016_traceability.py` — the two new files **add** checks and weaken none. The four pre-existing exit-1 checkers are **not** repaired here and remain failing for their own recorded reasons. No baseline re-issue — `PRD-014` is `DRAFT` at v0.1 and this matrix is **unranked**, so it confers nothing. **No Dart source changed.** |
| **v1.14** | 2026-08-19 | **Added the Audit Trail identifier inventory (§2J) — registering the `AUD-*` prefixes that `PRD-016` v0.1 minted when it authored the `AuditEntry` aggregate — and, unlike §2G/§2H/§2I, **CLAIMS Stage 5**, because both reasons that withheld it from `PRD-013` are discharged.** Before this commit `grep -c 'AUD-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**, so **58 identifiers in a Rank-3-registered document were registered nowhere** — the condition Stage 5 exists to prevent. Eight registers, **58 identifiers** (**35** obligation-bearing = 16 `AUD-FR-*` + 3 `AUD-BR-*` + 4 `AUD-INV-*` + **0** `AUD-EVT-*` + 12 `AUD-XC-*`, plus **18** `AUD-AC-*` and **5** `AUD-GAP-*`), **0 retired**, every range **contiguous from 001**, **0 orphan criteria**, **0 dangling citations**, **zero collisions in all three directions**. ⚠ **Contiguity is judged over a set where declared EQUALS in force — a difference from §2I named rather than inherited silently.** `PRD-013` retires 12 identifiers so five of its registers carry holes and §2D.2's declared-set rule is required; `PRD-016` §0.2 states *"No identifier is retired"*, so one count per register is unambiguous. **That simplicity is enforced, not assumed**: both scripts fail if a retirement section ever appears. **The two withholding reasons, discharged rather than argued away: (1)** the **no-role-holder** objection (`PGA-08`, *"Every PRD needs a named owner. None has one"*) is discharged by conferral, recorded at `PRD-016_STAGE5_CONFERRAL.md` in the identical form `PRD-008_STAGE4_CONFERRAL.md` and `PRD-013_STAGE5_CONFERRAL.md` used — ⚠ **`PGA-08` is a standing gap and is NOT cured**, the conferral being per-act, not an owner appointment (`ADR-0033` §7.1); **(2)** the **no-committed-checker** objection (*"a number computed once is not a number verified mechanically on every commit"*) is discharged **by construction**, with `prd016_traceability.py` and `prd016_stage5.py` committed under `tool/docs_check/`. ⚠ **Independence of the pair is structural and goes beyond what §2I's pair required:** neither imports the other **and they parse by different strategies** — one classifies **lines** by form, the other walks **sections** and accepts an identifier only where that section may define it. **Both reach 58 by different routes**, which is evidence; agreement by one route repeated twice would not be. **Both were mutation-tested, because a gate that cannot fail is not a gate: 6 deliberate defects injected, 6 caught**, each by the script owning that class — matrix count 16→15, §2J deleted entirely, total 58→57 and coverage 27/35→30/35 caught by `prd016_stage5.py` alone; a PRD contiguity break caught by **both**; a dangling `AUD-FR-099` citation caught by `prd016_traceability.py` alone. Both documents were restored **byte-identical** afterwards, verified by sha256. Coverage is published as **27 / 35 = 77.1%**, **not** rounded up or softened, with **⛔ 0 of 18 criteria proven by a passing test** because no implementation exists, and the **8** uncovered obligations **named** (`AUD-FR-001`…`004`, `AUD-FR-010`, `AUD-FR-011`, `AUD-XC-009`, `AUD-XC-011`), each a scope or ownership statement — the `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated, and check 8 now fails the run if the figure ever drifts. ⚠ **§2J.4 records THREE defects the checkers found in THEMSELVES, rather than quietly patching them, because in all three the PRD was right and the instrument was wrong: (1)** `PRD-016` opens requirements with a **bold** identifier where `PRD-013` uses a bare one, so the inherited rule matched **1 of 16** `AUD-FR-*` and reported five registers absent — a correct document nearly declared broken, or worse, "fixed" by editing the PRD to suit the tool; **(2)** finding **`S4-D-01`** — a token-only scanner misses `AUD-XC-006`/`007` inside the **ellipsis range** ``AUD-XC-005`…`008``, under-counting coverage by 3 and publishing a **false gap** of 11 where the truth is 8; **(3)** fixing (1) too loosely then accepted §0.3's closing sentence *"Retention is recorded as **`AUD-GAP-001`**."* as a definition and reported a phantom duplicate. Fixed by encoding the document's **actual** convention — bold identifier + em-dash + normative text, **23** such lines plus **35** table cells = **58**. **No PRD content was changed to make a checker pass.** ⚠ **Two registers are registered AS EMPTY rather than omitted**, because an omitted empty register is indistinguishable from an oversight: `AUD-EVT-*` because `BC-24` **publishes no domain event** (producer rows for `BC-24` in BC Map §9: **0**; it appears **25 times as a consumer**, the widest fan-in in the map), and `AUD-CFG-*` because **no authority at any rank** supplies a default or bound for audit retention or legal hold — `CFG-1`…`CFG-12` are SMS, session, device, lock and **account** values. **No retention period, jurisdiction or legal rule was invented**; `AUD-GAP-001` routes it to **SECURITY + DATA Governance** with counsel per `MP-NFR-10`, and `Q-04` stays *"Open — needs counsel"*. ⚠ Deliberately **unlike `TEN-CFG-001`**, which was issued then retired, **no `AUD-CFG-*` number is burned at all**. ⚠ **The substring hazard is LIVE here, not hypothetical**, and is tested in three directions: this matrix registers a bare **`FR-*`** stem, so `AUD-FR-001` is checked to be unreachable by a bare `FR-n` search; and **`AU-n` names TWO OTHER registers** — Authentication §10.4's `FROZEN` audit principles **and** the module manifest's assertions, where `AU-4` means *"Independence"* in one and *"erasure by key destruction"* in the other — so `AUD-` and `AU-n` are proven mutually unreachable, and `PRD-016` §0.4's ban on bare `AU-n` citation holds with **0** violations across the PRD and its three review records. **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — `docs/40-implementation/audit/` is **empty** and the next free block is **`IMPL-900`+**, `IMPL-830`…`899` being reserved for `PRD-013`'s growth; **no freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-016`**, the only place freeze can be conferred; **no verification** — registered is not verified. All **5** `AUD-GAP-*` remain **OPEN**. `PRD-016` stays **v0.1 `DRAFT`** and **`PLANNED`** in `PRD_REGISTRY.md` §4.2. **The three code contradictions are recorded, not repaired**: `D-016-01` (`recent()` and `count` expose entries across tenants — `X-13`, `MP-RSK-01`), `D-016-02` (`append()` defaults an absent timestamp to epoch 0) and `D-016-03` await Stage 8; `lib/platform/audit/audit.dart` is **byte-unchanged** and `git status --short lib/ packages/ test/` returns **0 lines**. `PRD_LIFECYCLE.md`'s `X-13` mis-citation (`S3-A-02`) is **left unrepaired** — amending a governance document is not a Stage 5 act. **§2 through §2I are byte-unchanged**, as are all four `PRD-016` documents (`PRD-016_AUDIT_TRAIL.md` at `281f15e8…39be`, re-verified before and after this pass), `PRD_REGISTRY.md`, all **50** ADRs, and **all 14 pre-existing scripts** under `tool/docs_check/` including `prd013_stage5.py` and `prd013_traceability.py` — the two new files **add** checks and weaken none. The four pre-existing exit-1 checkers are **not** repaired here and remain failing for their own recorded reasons. No baseline re-issue — `PRD-016` is `DRAFT` at v0.1 and this matrix is **unranked**, so it confers nothing. **No Dart source changed.** |
| **v1.13** | 2026-08-17 | **Added the Tenancy identifier inventory (§2I) — registering the `TEN-*` prefixes that `PRD-013` v0.1 minted when it authored the `Tenant` aggregate and its boundary.** Before this commit `grep -c 'TEN-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**, so **51 identifiers in a Rank-3-registered document were registered nowhere** — the same condition §2G fixed for `PRD-008` and §2H for `PRD-019`. Eight registers, **51 identifiers in force** across a **63-identifier declared set** (34 obligation-bearing + 13 `TEN-AC-*` + 4 `TEN-GAP-*`, plus **12 retired**), **zero collisions in both directions**, **0 orphan criteria**, **0 dangling citations**, all counts computed by script rather than read. ⚠ **Contiguity is judged over the DECLARED set, not the in-force set** — five registers carry retirement holes (`TEN-FR` skips `012`/`016`/`017`, `TEN-BR` `002`/`003`, `TEN-INV` `003`–`005`, `TEN-AC` `003`–`005`, `TEN-CFG-001` retired leaving that register **declared empty**) and would fail a naive in-force contiguity test; they pass on this matrix's own §2D.2 rule, *"Contiguity is judged over the declared set"*, which retains retired numbers so citations stay resolvable. Coverage is published as **22 / 34 = 64.7%**, **not** rounded up or softened: the **12** uncovered obligations are **named** (`TEN-FR-001`…`009`, `TEN-FR-013`, `TEN-FR-015`, `TEN-BR-004`), each a structural or ownership statement verified by the module's shape, and the table records **0 of 13 criteria proven by a passing test** because no implementation exists — the `PRD-006` v1.0 error of publishing *"100% coverage"* against a true **49.1%** is not repeated. ⛔ **Stage 5 is NOT claimed for `PRD-013`, and the reason is neither coverage nor correctness** — its Stage 4 re-review returned **6 of 6 checks PASS with 0 findings**. The stage is withheld for the two reasons §2H states: **(1)** `PRD_LIFECYCLE.md` §6 assigns Stage 4 to the requirements reviewer and Stage 5 to the traceability owner, and L283 records *"Every PRD needs a named owner. None has one"* (`PGA-08`), so the verdict is **measured, not conferred** — *6 of 6 measured is not 6 of 6 conferred*; **(2)** no committed `TEN-*` checker exists under `tool/`, and *a number computed once is not a number verified mechanically on every commit*. **Registration is performed because the alternative is 51 identifiers registered nowhere; the stage is withheld because the traceability it also demands does not exist.** §2 through §2H are **byte-unchanged**; `PRD-013_TENANCY.md` (`688239cb…ba9c`), `PRD-013_ARCHITECTURE_ALIGNMENT.md` (`5076b742…f3cf`), `PRD_REGISTRY.md`, all 49 ADRs and every file under `tool/` are untouched. No baseline re-issue — `PRD-013` is `DRAFT` and this matrix is **unranked**. No `IMPL-*` range allocated (Stage 6). No `ResidencyRegion` value asserted (`TEN-GAP-001` stays open). ⚠ Discloses that `PRD-013_ARCHITECTURE_ALIGNMENT.md` still cites the pre-correction PRD hash `fcd99ff7…f97e`, which is historically correct but will trip `alignment_record_freshness`; re-confirming Stage 3 is the architecture reviewer's call, not this pass's. |
| **v1.12** | 2026-08-16 | **Recorded `PRD-019` v0.4's closure of the LAST substantive Stage 4 finding — and deliberately changed almost nothing else, because almost nothing else changed.** `ITG-FR-017` moved from *"retained for **at least** 30 days"* to *"retained for **exactly 30 days**"*, **FIXED for V1 and not configurable**, so Stage 4 **check 3 now PASSES** and `PRD-019` §6 reads **6 of 6** where v1.11 recorded **5 of 6**. ⚠ **NOT ONE IDENTIFIER, COUNT OR RANGE IN §2H MOVES, and that is the point:** `ITG-*` stays at **111** (28 `ITG-FR-*` + 11 `ITG-BR-*` + 5 `ITG-INV-*` + 10 `ITG-XC-*` + **54** `ITG-AC-*` + **3** `ITG-GAP-*`), every range still contiguous from 001. **Fixing the VALUE inside a requirement changes no identifier**, and a register that moved here would have been a register reporting something it does not measure. The coverage table is likewise untouched — still **54/54 have a criterion** and still **⛔ 0 of 54 proven by a passing test**, because closing a specification finding proves no test. ⛔ **STAGE 5 IS STILL NOT CLAIMED, AND NEITHER WITHHOLDING REASON WEAKENS.** **Reason 1** is edited only to carry the new figure: the measured result improved from 5/6 to **6/6**, and the reason stands **unchanged in force**, because it was never about the finding — it is about the **role**. `PRD_LIFECYCLE.md` §6 assigns the Stage 4 verdict to the **requirements reviewer**, and the authoring pass still does not hold it. ⚠ **This is the edit most open to being misread as progress toward Stage 5, so it is labelled: *6 of 6 measured is not 6 of 6 conferred.*** Closing the last substantive finding removed the *substantive* obstacle and left the *procedural* one exactly where it stood. **Reason 2 is entirely unchanged**: there is still **no committed gate script for `ITG-*`** under `tool/`, all 9 checkers remain **byte-identical**, and *a number computed once is not a number verified mechanically on every commit*. The v1.10 conditional gate debt therefore remains **DUE**. ⚠ **A defect in `PRD-019`'s own v0.3 reasoning is recorded rather than absorbed:** the v0.3 deferral justified itself by asserting the ceiling *"interacts with `ID-5`"*, but `ID-5` (BC Map **L182**) governs Account deletion, `Person` anonymisation and `StudentRecord` financial/attendance history — and a dedup identity is an opaque `(tenant, event-id)` pair that is **none of those**. It was a **category error**, and it routed a decision to an owner who was never needed. **No ceiling was invented to achieve the closure**: the fixed value is the floor v0.2 had already derived and published, and `PRD-019`'s own post-write audit confirms the **set of durations in §4.4 is IDENTICAL before and after — {15, 24, 30}**. ⛔ **`ITG-GAP-001`, `ITG-GAP-002` and `ITG-GAP-003` remain OPEN** — none concerns retention and none was closed. **`PRD-008` and §2G are byte-unchanged — not one byte**; the `FEE-*` identifier set is **identical as a set**; **no `PRD-008` freeze conferred or requested**; no authentication, Library, Student Identity, Student Management, Membership, Seat or Attendance row changed; **no file under `tool/` modified**; **no ranked document changed**; no checker weakened; **no Dart source changed**; **no baseline identifier issued**. |
| **v1.11** | 2026-08-16 | **Registered `PRD-019`'s 54 acceptance criteria in §2H — `ITG-AC-*` moves from an empty register to `001`–`054`, and the total from 56 to 111.** `PRD-019` v0.3 authored one criterion per obligation, **bijectively**: 54 obligations, 54 criteria, exactly one identifier in each **Verifies** cell, so **0 orphans** and **0 obligations verified twice** — both computed, not asserted. §2H now publishes a **coverage table** where v1.10 deliberately published none. ⚠ **The reason for that reversal is stated rather than assumed:** v1.10 withheld the percentage because it would have been **0%** and *"printing a computed 0% as though it were a result would dress a shortfall as a metric"*; at v1.11 it is **54/54 = 100%**, and the **mirror-image error** — letting a reader take 100% for verification — is blocked by a row in the same table reading **`0 of 54` criteria proven by a passing test**. It means every obligation **has** a criterion; it does **not** mean any criterion **passes**, because no implementation exists. This matrix has published a false *"100% coverage"* once already (`PRD-006` v1.0, true **49.1%**), so the figure is **computed AND qualified**. ⛔ **STAGE 5 IS STILL NOT CLAIMED — and the reason has changed, which is the substantive content of this entry.** The v1.10 reason (*"`ITG-AC-*` is **empty**, so coverage is **0/54**"*) is **quoted and retired**. **Two new reasons replace it, neither about coverage: (1)** `PRD-019` §6 records Stage 3 and Stage 4 as **RUN and MEASURED** — 6/6 aligned, 5/6 pass — but **neither verdict is CONFERRED**, because `PRD_LIFECYCLE.md` §6 assigns those stages to the **architecture reviewer** and the **requirements reviewer** and the authoring pass held neither role (`ADR-0048` §3); **stages are sequential**, so Stage 5 cannot be claimed over an unconferred Stage 4. **(2)** **No committed gate script exists for `ITG-*`.** Stage 5 demands counts *"verified **mechanically**"*, and while the §2H figures **are** script-computed, they come from a **one-off** script rather than a checker under `tool/` that CI re-runs — **a number computed once is not a number verified on every commit**. ⚠ **Reason 2 was the easiest to gloss over and is recorded most explicitly**, because the table genuinely is computed; what a *gate* additionally requires is **repeatability**, and `PRD-008` has `prd008_stage5.py` while `PRD-019` has nothing. **v1.10's own conditional debt is therefore marked DUE, not carried:** it read *"a `PRD-019` gate is owed **when `ITG-AC-\*` exists**"*, and it now does. It is **not stubbed in this pass** — a checker written by the same author in the same pass as the register it checks verifies agreement with itself. **`ITG-GAP-*` moves 2 → 3**: **`ITG-GAP-003`** records that webhook-disablement detection is **notification-driven, not programmatic** — the only published status-bearing API is a provider **Partner** API whose availability to this account type is not established, so **no polling rule was invented**. ⚠ **`ITG-GAP-001` and `ITG-GAP-002` remain OPEN and were not closed.** **`PRD-008` and §2G are byte-unchanged — not one byte**; the `FEE-*` identifier set is **identical** (compared as a set, which is stricter than comparing a count); **no `PRD-008` freeze conferred or requested**; no authentication, Library, Student Identity, Student Management, Membership, Seat or Attendance row changed; **no file under `tool/` modified**; no ranked document changed; no checker weakened; **no Dart source changed**. |
| **v1.10** | 2026-08-15 | **Added the Integration identifier inventory (§2H) — registering the `ITG-*` prefixes that `PRD-019` v0.2 minted when it authored the V1 payment webhook contract and closed `Q-B31`.** Before this commit `grep -c 'ITG-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**, so **56 identifiers in a Rank-3-registered document were registered nowhere** — the same condition §2G was added to fix for `PRD-008`. Six registers, **56 identifiers** (**54** obligation-bearing = 28 `ITG-FR-*` + 11 `ITG-BR-*` + 5 `ITG-INV-*` + 10 `ITG-XC-*`, plus **2** `ITG-GAP-*`), every range verified **contiguous from 001**, **zero collisions in both directions**, and **zero dangling references**. Counts are **computed, not asserted**. ⛔ **STAGE 5 IS EXPLICITLY NOT CLAIMED, and that is the substantive content of §2H rather than a caveat on it:** `ITG-AC-*` is **empty**, so coverage is **0/54** and nothing is *verified* in the sense `PRD-008` §0.2 requires (*"prose never counts"*). **Registration is performed because the alternative is 56 identifiers registered nowhere; the stage is withheld because the traceability it also demands does not exist.** No coverage percentage is published, because it would be **0%** and printing it would dress a shortfall as a metric. §2H.1 records the collision check in **both directions** — `ITG-` defined outside `PRD-019`: **0**; cited outside: governance records only, and *a citation is not a collision* (§2C.1) — and re-states that **`INT-*` was refused at reservation** because `SID-INT-1`…`12` already exist, per `PRD_LIFECYCLE.md` §5 rule 3 (*"change the new prefix, never the existing one"*). §2H.2 records what this pass declines to do: **no `IMPL-*` allocation** (Stage 6; `docs/40-implementation/integration/` does not exist and `PRD-019` allocates **0 numbered `IMPL-nnn` identifiers**, measured as `IMPL-\d+` rather than as the bare prefix, which is non-zero because the wildcard `IMPL-*` appears in sentences *denying* an allocation — ⚠ **the looser *"holds 0 `IMPL-` tokens"* wording was in this entry's own first draft and was corrected in the same pass, alongside identical corrections at `PRD-019` §6 and `ADR-0047` §5 and §8; the post-write assertion that caught it tested the **whole file** for the stale claim rather than the edit anchor, which is why a second occurrence in this very entry could not slip through), **no new or modified gate script** — a `PRD-019` gate is **owed rather than stubbed**, and `prd008_stage5.py` / `prd008_traceability.py` are **byte-unchanged** — and **no baseline re-issue** (§7 step 4; `PRD-019` is Rank 3-*registered*, not Rank 3-*holding*, and this matrix is unranked). **`PRD-008` and §2G are byte-unchanged — not one byte**; no `FEE-*` identifier, count, range or gap was added, removed, renumbered or altered; **no `PRD-008` freeze was conferred or requested**; no authentication, Library, Student Identity, Student Management, Membership, Seat or Attendance row changed; no ranked document changed; no checker weakened; no code changed. |
| **v1.9** | 2026-08-15 | **Added the Revenue & Finance identifier inventory (§2G) — `PRD-008` v1.7's `PRD_LIFECYCLE.md` Stage 5 gate, which was previously UNMET and is now measured as satisfied.** Before this commit `grep -c 'FEE-' docs/40-implementation/TRACEABILITY_MATRIX.md` returned **0**: `PRD-008`'s prefixes were registered **nowhere**, and since Stage 5's gate *is* registration in §2, the stage could not pass. Nine registers, **259 identifiers** (**134** obligation-bearing = 62 `FEE-FR-*` + 28 `FEE-BR-*` + 10 `FEE-INV-*` + 3 `FEE-EVT-*` + 23 `FEE-XC-*` + 8 `FEE-PO-*`, plus **98** `FEE-AC-*`, **17** `FEE-GAP-*` open questions and **10** `FEE-RSK-*` risks), every range verified **contiguous from 1 to its stated maximum**, **zero collisions in both directions**, and coverage **134/134 = 100%** with zero orphan criteria in either direction. Counts are **computed, not asserted**, by the new [`tool/docs_check/prd008_stage5.py`](../../tool/docs_check/prd008_stage5.py). **That script ADDS a gate and weakens none:** the pre-existing `prd008_traceability.py` checks `PRD-008` against **itself** and never opens this file, so Stage 5 had **no mechanical enforcement** for this module — §2G could have carried any numbers and nothing would have objected. Both scripts must now pass independently, and `prd008_traceability.py` is **byte-unchanged**. **§2G.1 records the collision check run in both directions, and this module is the sharpest instance of the hazard Stage 5 exists for:** `PRD-008` owns `FEE-PO-001`…`FEE-PO-008`, so the `PO-` substring is present where `PO-1`…`PO-12` are Library protected operations (anonymous **read**) and `SPO-1`…`SPO-9` are Student Identity protected operations (authenticated **write**) — **three meanings across three bounded contexts**, and `FEE-PO-*` is not even the same *kind* of thing, being a **port / integration obligation** on the `ATT-PO-*` convention. **The separation is tested, not asserted:** prefix tokenisation is asserted in the gate script (`'FEE-PO-003'` → `['FEE-PO']`), and a reverse search for a **bare** `PO-n`/`SPO-n` token in `PRD-008` returns **0** — the document never cites those registers at all. ⚠ **The outward direction is the case that proves a checker must resolve rather than count:** a naive line-start search returns **18** hits outside the module and *looks* like eighteen collisions; **all 18 resolve to identifiers `PRD-008` already defines** (16 in `ACCEPTED` `ADR-0035`/`0037`/`0039`/`0040`/`0041`/`0042`, **2 in this file, added by this section**), so the true count of foreign **definitions** is **0**. The gate resolves each hit against the defined set instead of allow-listing files, so a genuinely new `FEE-*` definition in any of those same ADRs would **still fail the run** — and the matrix is granted **no self-exemption** that a governance document is denied. ⚠ **`FEE-RSK-*` is registered WITH A DISCLOSURE rather than quietly normalised or omitted.** It is well formed (§38, ten contiguous entries) but is **absent from `PRD-008` §0.2**, which §0.1 requires. Omitting it here would have produced a tidier eight-register section matching §0.2 exactly and passing without a footnote — while leaving ten identifiers in a Rank 3 document and in **no register anywhere**, the exact condition Stage 5 prevents. Registering it does **not** repair §0.2; that is a **document-owner act on `PRD-008`**, and the gate prints the finding on **every run**. ⚠ **One derived-statement drift of this pass's own making is disclosed, not absorbed:** §2G.1's outward figure read *"16"* until it was re-measured after §2G itself added two self-citations — the same `GCP-01`/`07`/`08` class the repository tracks. **Stage 5 ONLY.** No `IMPL-*` range allocated (Stage 6) — `docs/40-implementation/` has **no `revenue-finance/` subdirectory** and `PRD-008` contains **0** occurrences of `IMPL-`; **no freeze** (Stage 7) — `DOCUMENTATION_BASELINE.md` §3 contains **no row admitting `PRD-008`**, and that is the only place a freeze can be conferred. **`PRD-008`'s Stage 3 verdict remains ⛔ NOT ALIGNED 5/6 and §2G does not upgrade it.** The **baseline identifier is deliberately NOT re-issued**: §7 step 4 moves it only when a Rank 1–3 document changes version, and `PRD-008` is byte-unchanged. **`PRD-008` itself unchanged — not one byte.** No requirement, acceptance criterion, exclusion, port or identifier was added, removed, renumbered or reworded; no `FEE-GAP-*` was resolved, narrowed or altered; **no prefix was changed, because §5 rule 3 was not triggered — zero collisions**; no authentication, Library, Student Identity, Student Management, Membership, Seat or Attendance row changed; no ranked document changed; no ADR required, this document being unranked; no checker weakened; no code changed. |
| **v1.7** | 2026-08-04 | **Added the Attendance Management identifier inventory (§2F) — `PRD-006` v1.3's `PRD_LIFECYCLE.md` Stage 5 gate.** Ten registers, **516 identifiers** (285 obligation-bearing, 213 `ATT-AC-*`, 18 `ATT-GAP-*` open questions carrying **21 rows** via the declared suffixed successors `ATT-GAP-008a`/`016a`/`017a`), every range verified **contiguous from 1 to its stated maximum**, **zero collisions**, **zero duplicate definitions**, **zero dangling references** across **1,262** occurrences, and **zero orphan acceptance criteria**, **zero blank *Verifies* cells** and **zero `ATT-GAP-*` cited as verifiable** across **213** rows carrying **328** citations. Counts are **computed, not asserted**, by the new [`tool/docs_check/prd006_traceability.py`](../../tool/docs_check/prd006_traceability.py), which checks **three declarations against one computation** (§0.3's ranges, §0.3's totals, §2F's registrations). Records the measured coverage **285/285 = 100%** — **stricter than `PRD-007`'s** by the PRD's own choice, since `ATT-NFR-010` admits no excluded register where `SEAT-FR-302` mandates only four, so the script enforces 100% of *all* obligations and fails on one uncovered. The figure is **measured, not asserted**: `PRD-006` v1.0 published *"100% coverage"* against a true 137/279 = 49.1%, and the last hole (`ATT-BR-045`) was closed by **extending `ATT-AC-152`, not by inventing a criterion**. **§2F.1** records the collision check run in **both directions** — outward **0**, code **0** — and resolves **19 inward foreign prefixes** as **correct foreign citations, inspected at their lines rather than counted as failures** (the §2C.1 principle), with two recorded **true negatives**: `NG-1`…`NG-10` at line 168 is the **non-goals table**, not a register, and `SM-03` at lines 1647/2177/2211 is a **substring of `MP-ASM-03`** that a word-boundary search returns **0 times** — the same class as §2C.1's `MP-SM-01`…`09` and §2D.1's `YYYY-MM-DD`. It also records that **numeric ranges are per-register, not global**, so `ATT-FR-001` does not collide with `SEAT-FR-001` or `MM-FR-001`. **§2F.2** records the exit gate and the one convention that **differs from `PRD-007`**: where §2E.2 found definition form to be **per register** with zero overlap, `PRD-006` defines the *same* register in **both** prose and table form — three do: `ATT-FR-*` 110 + 41, `ATT-BR-*` 39 + 6, `ATT-PO-*` 5 + 9, with the table-form definitions sitting in **ordinary content sections** (§8.3, §9.3, §10.3, §11.3, §12.2, §5.2, §5.3, §27.1), not in an index — so **location, not form, separates a definition from a restatement**. Six index sections (§0, §28, §29, §31.1, §31.2, §32) restate rather than define, and counting them as definition sites produces **95 phantom duplicates** (45 `ATT-BR-*`, 21 `ATT-XC-*`, 21 `ATT-GAP-*`, 6 `ATT-CFG-*`, 1 `ATT-FR-*`, 1 `ATT-NFR-*`), the class Stage 4 rejected as finding `R-1` by opening the pairs rather than trusting the count; honouring the list leaves exactly **one** duplicate, the self-declared restatement below. §16.2 is excluded for table definitions **only**, because its prose genuinely defines `ATT-FR-099`/`100`. `ATT-NFR-001` line 1607, marked *"(stated in §15.4)"*, is allow-listed **by identifier** as a self-declared restatement, mirroring `MM-BR-030` in §2D.2. `PRD-006` v1.3 `DRAFT` added to Sources. **Stage 5 only** — no `IMPL-*` range allocated (Stage 6), no freeze (Stage 7); the document's single `IMPL-` token, at line 90, was **inspected at its line** and is the generic never-reuse rule, **not an allocation**. **`PRD-006`'s Stage 3 and Stage 4 verdicts remain ⚠️ CONDITIONAL — this section does not upgrade them.** **No authentication, Library, Student Identity, Student Management, Membership or Seat Management row changed. No ranked document changed. `PRD-006` itself unchanged — not one byte. No requirement, acceptance criterion or identifier was added, removed, renumbered or reworded. No mapping was invented and no `ATT-GAP-*` was resolved, narrowed or altered. No ADR required: this document is unranked. No code changed.** |
| **v1.6** | 2026-08-04 | **Added the Seat Management identifier inventory (§2E) — `PRD-007` v1.0's `PRD_LIFECYCLE.md` Stage 5 gate.** Ten registers, **683 identifiers** (669 obligation-bearing, 14 `SEAT-GAP-*` open questions), every range verified **contiguous from 1 to its stated maximum**, **zero collisions**, **zero duplicate definitions**, **zero dangling references** across **1,641** occurrences, and **zero orphan acceptance criteria** across **226** rows. Counts are **computed, not asserted**, by the new [`tool/docs_check/prd007_traceability.py`](../../tool/docs_check/prd007_traceability.py). Records the measured coverage **325/443 = 73.4%** overall and **85/85 = 100%** across the four rule registers — the figure `SEAT-FR-302` actually mandates — with the 118 uncovered obligations **named by register rather than argued away** (86 `SEAT-FR-*`, 18 `SEAT-PO-*`, 9 `SEAT-CFG-*`, 5 `SEAT-NFR-*`), per `SEAT-NFR-011`/`SID-4.56`. **§2E.1** records the collision check run in **both directions** — the direction a one-way check omits — and resolves **five bare foreign prefixes, 36 hits**, inside `PRD-007` as **correct foreign citations, inspected at their lines rather than counted as failures** (the §2C.1 principle): `BR-2.9`/`BR-2.12` and `TR-2` are authentication, `LCFG-9`/`LCFG-10` and `LXC-7` are Library, `LMD-23`/`LMD-24` is Student Management, and `BR-001`…`BR-018` are the **source draft's** rules in the §36.1 carried-by table — **not a register**, and absent from `docs/**` outside the module. It also records that **numeric ranges are per-register, not global** (§5 rule 1 makes the *identifier* unique, and §2B.1 states registers *"overlap numerically on purpose"*), so **no range-overlap prohibition applies**. **§2E.2** models the one convention a first tool run misreads: definition form is **per register** — five registers in prose, five in table rows, **zero overlap** — and a pattern loose enough to accept both returns **307** `SEAT-FR-*` for a register of **304**, a phantom duplicate in the checker, not a defect in the PRD. Header bumped to baseline **`-D`**, `PRD-005` **`FROZEN`** (per `ADR-0019`), and `PRD-007` v1.0 `DRAFT` added to Sources. **Stage 5 only** — no `IMPL-*` range allocated (Stage 6), no freeze (Stage 7); `PRD-007` contains **0** occurrences of `IMPL-`. **No authentication, Library, Student Identity, Student Management or Membership row changed. No ranked document changed. `PRD-007` itself unchanged — not one byte. No requirement, acceptance criterion or identifier was added, removed, renumbered or reworded. No `SEAT-GAP-*` was resolved or altered. No ADR required: this document is unranked. No code changed.** |
| **v1.5** | 2026-08-04 | **Added the Membership Management identifier inventory (§2D) — `PRD-005` v1.4's `PRD_LIFECYCLE.md` Stage 5 gate.** Ten registers, **333 identifiers** (320 obligation-bearing, 13 `MM-GAP-*` open questions), every range verified contiguous, **zero collisions**, **zero duplicate definitions**. Counts are **computed, not asserted**, by the new [`tool/docs_check/prd005_traceability.py`](../../tool/docs_check/prd005_traceability.py) — the defence §2C lacked, since §2C carried stale figures through two correction passes until a script disproved them (`SR-01`, HIGH). Records the measured coverage **134/223 = 60.1%** overall and **77/81 = 95.1%** across the five rule registers, under `PRD-005` §0.2's strict rule (*verified* **iff** the identifier appears in an `MM-AC-*` **Verifies** column — prose never counts), with the four uncovered rules `MM-BR-012`/`022`/`027`/`028` **named rather than argued away** per `MM-NFR-014`/`SID-4.56`. **§2D.1** records zero collisions against all four existing registers and treats `YYYY-MM-DD` in `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` line 624 as a **true negative** — `MM` is a month field, **inspected rather than counted as a failure** (the §2C.1 principle). **§2D.2** models three conventions the first tool run misread as defects: `MM-GAP-006`/`007` are **closed-but-retained** numbers with no definition row; `MM-BR-030` line 1235 is a **self-declared restatement**, not a duplicate; 11 `MM-AC-*` rows verify a **section or edge** rather than a registered ID, and blank cells number **0**. Header bumped to baseline **`-C`**, `ADR-0018`, and `PRD-004` **`FROZEN`**. **Stage 5 only** — no `IMPL-*` range allocated (Stage 6), no freeze (Stage 7). **No authentication, Library, Student Identity or Student Management row changed. No ranked document changed. `PRD-005` itself unchanged — not one byte. No ADR required: this document is unranked. No code changed.** |
| **v1.4** | 2026-08-04 | **§2C corrected — second-review finding `SR-01` (HIGH), the one defect that blocked `PRD-004`'s Stage 5 gate.** §2C still carried the **pre-correction** figures (`SM-c.n` 105, `SM-EV-n` 9, `SM-AC-n` 28, `SM-GAP-n` 9, total **242**, Ch 10 = 10) after two `PRD-004` correction passes had changed them. `PRD_LIFECYCLE.md` Stage 5 requires the registered counts to be *"verified mechanically — counted by a tool, not by reading"*, and the counting script **disproved** them. §2C now reads `SM-c.n` **107**, `SM-EV-n` **10**, `SM-AC-n` **32**, `SM-GAP-n` **11**, total **251 base + 15 sub-lettered = 266**, Ch 10 = **12**, and records the measured coverage **227/240 = 94.6%**. Header source bumped to `PRD-004` **v1.2**. **No authentication, Library or Student Identity row changed. No ranked document changed. No ADR required — this document is unranked. No code changed.** |
| **v1.3** | 2026-08-04 | Added the **Student Management** identifier inventory (**§2C**, `PRD-004` `DRAFT`, **242** identifiers across ten registers, every range verified contiguous) and the collision record **§2C.1**. Records that the register **was corrected by validation before first use**: §0 of `PRD-004` declared **118** `SM-c.n` (total 246); a mechanical count found **105** (total **242**), and **the register was corrected rather than the chapters padded with filler requirements**. Documents that chapters 5 and 9 deliberately hold **no** `SM-c.n` — chapter 5 numbers in `LMD-n` so a read-composition requirement can never be mistaken for a `BC-01` domain requirement. §2C.1 records `MP-SM-01`…`MP-SM-09` in `MASTER_PRD.md` as a **true negative** — Certified Metric IDs, not requirements — **inspected rather than accepted as a collision**, since a checker that cannot tell a substring from a real hit is one that gets switched off. Header updated to baseline **`-B`**, Library PRD **v1.1**, ADRs **`ADR-0001`…`ADR-0017`**. **No authentication, Library or Student Identity row changed. No code changed.** |
| **v1.2** | 2026-08-04 | Added the Student Identity identifier inventory (§2B, 343 identifiers, all nine registers verified gap-free), the prefix-collision record (§2B.1, including the `PO-n` / `SPO-n` hazard), the Student Identity chapter map (§3B, 38 rows, four marked ⛔ rather than ⬜), configurable traceability (§6B) and event traceability (§7B). Added `ADR-0011` to §4 with its three amendments to the Identity Triad traced individually. **Added `MP-GBR-02` to §5 as an amended rule** — the first global business rule to appear in this matrix as changed rather than as baseline. Added §8A recording that **existing scaffold code implements the superseded pre-`ADR-0011` identity model** — nullable `Account.personId`, nullable `StudentRecord.personId`, `GlobalStudentProfile` owned by `domain/social`, and 4 of 5 seeded accounts with no identity — and that the rank-7.5 boundary is *declared but unenforced* pending `IMPL-014`. No authentication or Library row changed. No code changed. |
| **v1.1** | 2026-08-03 | Added the Library identifier inventory (§2A, ~422 identifiers, zero collisions with the authentication register), the Library chapter map (§3A, 22 rows), Library configurable traceability (§6A) and Library event traceability (§7A). Added `ADR-0009` and `ADR-0010` to §4. Named `IMPL-100` as a second enforcer of `MP-GBR-08` and `IMPL-112` as a second consumer of `MP-DEP-03`. Recorded the `INV-n` / `INV-SEC-n` / `INV-XC-n` prefix hazard in §2A.1, and stated `INV-10`…`INV-16` in full with the failure each prevents. No authentication row changed. |
| v1.0 | 2026-08-02 | Created. 1,517 authentication identifiers mapped. Closes audit finding `G-9`. |
