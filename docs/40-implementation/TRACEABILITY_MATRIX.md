# Liboora — Requirements Traceability Matrix

| Field | Value |
|---|---|
| **Version** | v1.15 |
| **Status** | Active — updated with every requirement implemented |
| **Date** | 2026-08-02 · extended 2026-08-03 · **extended and §2C corrected 2026-08-04** · **§2D added 2026-08-04** · **§2E added 2026-08-04** · **§2F added 2026-08-04** · **§2G added 2026-08-15** · **§2H added 2026-08-15** · **§2I added 2026-08-17** · **§2J added 2026-08-19** · **§2K added 2026-08-19** |
| **Baseline** | **BASELINE-2026-08-04-D** — ⚠ **not re-issued by §2G.** `DOCUMENTATION_BASELINE.md` §7 step 4 moves the baseline identifier only *"when a Rank 1–3 document changes version"*. `PRD-008` is **byte-unchanged** by this pass, so no baseline change is due, and this matrix is **unranked** — it confers nothing |
| **Sources** | Authentication PRD v2.0 · Library PRD **v1.1** + §14A + §14B + Invitation Security Specification · Student Identity & Profile PRD v1.0 · **Student Management PRD v1.2 (`PRD-004`, `FROZEN`)** · **Membership Management PRD v1.4 (`PRD-005`, `FROZEN`)** · **Seat Management PRD v1.0 (`PRD-007`, `DRAFT`)** · **Attendance Management PRD v1.3 (`PRD-006`, `DRAFT`)** · **Revenue & Finance PRD v1.7 (`PRD-008`, `DRAFT`)** · **Integration PRD v0.2 (`PRD-019`, `DRAFT`)** · **Tenancy PRD v0.1 (`PRD-013`, `FROZEN`)** · **Audit Trail PRD v0.1 (`PRD-016`, `DRAFT`)** · **Entitlement PRD v0.1 (`PRD-014`, `DRAFT`)** |
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
