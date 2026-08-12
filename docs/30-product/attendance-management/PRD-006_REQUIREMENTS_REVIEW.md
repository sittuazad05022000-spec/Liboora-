# PRD-006 Attendance Management — Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Lifecycle stage** | **Stage 4 — Requirements Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–119) |
| **Subject** | [`PRD-006_ATTENDANCE-MANAGEMENT.md`](./PRD-006_ATTENDANCE-MANAGEMENT.md) **v1.2 — DRAFT** |
| **Subject hash at review** | `600c59ecbbc9f92c28f36d98ebc01a8d7339c51e04b28990a5cd152bdd19980a` |
| **Repository state reviewed** | `9f757ca` — working tree clean |
| **Precedent followed** | [`PRD-007_REQUIREMENTS_REVIEW.md`](../seat-management/PRD-007_REQUIREMENTS_REVIEW.md) (676 lines), severity scheme from `PRD-004_INDEPENDENT_REVIEW_REPORT.md` §19 |
| **Stage 3 predecessor** | [`PRD-006_ARCHITECTURE_ALIGNMENT.md`](./PRD-006_ARCHITECTURE_ALIGNMENT.md) — ⚠️ CONDITIONALLY ALIGNED, 21/22 |
| **Status of this file** | **Unranked.** A review record. It claims no authority. Where this file disagrees with the PRD, the PRD is right and this file is a defect |
| **Mandate** | **Stage 4 only.** Read-only. No document was modified. No ADR was created. PRD-006 is **not frozen** by this review |
| **Verdict** | ⚠️ **CONDITIONALLY PASSED** — 5 of 6 gate checks PASS · 1 FAILS and is carried as an explicit deferral with a named reason and a named owner · 8 findings · Stage 4 **gate satisfied** |

---

## 0. Verdict in one page

`PRD_LIFECYCLE.md` L119 states the Stage 4 gate exactly: *"conflicts closed or **explicitly deferred with a
reason and an owner**."* That is the gate. The six checks at L110–116 are the tests; the gate is the disposition
requirement. **The two are not the same thing, and this document passes one while failing a test inside the
other.**

| | Result |
|---|---|
| **Gate check 1** — every requirement testable | ✅ **PASS** (§3) |
| **Gate check 2** — every exclusion states what must be **impossible** | ✅ **PASS** (§4) |
| **Gate check 3** — every configurable has a default and a range | 🔴 **FAIL** — `RQ-1` (§5) |
| **Gate check 4** — every acceptance criterion maps to a requirement | ✅ **PASS** (§6) |
| **Gate check 5** — no requirement restates another PRD's | ✅ **PASS** (§7) |
| **Gate check 6** — business rules do not contradict Rank 1 | ✅ **PASS** (§8) |
| **The gate itself** — conflicts closed or deferred with reason + owner | ✅ **SATISFIED** (§13) |

The single FAIL is **`RQ-1`**: seven of twenty-four configurables carry no default and no allowed domain,
breaching `LIB-16.2` (Rank 3). It is a real breach and it is recorded as one. It nonetheless **satisfies the
gate**, because the PRD does not conceal it — it names it `ATT-GAP-017`, assigns it to the **product owner**,
states the reason it cannot self-close, and blocks the seven settings from use (`ATT-AC-199`) rather than
inventing values. That is the textbook shape of *"explicitly deferred with a reason and an owner."*

**What Stage 4 does not license.** This review does not advance the document past Stage 4, does not close
`ATT-GAP-017`, and does not authorise a Stage 7 freeze. Three MEDIUM findings (`RQ-2`, `RQ-3`, `RQ-4`) are
bookkeeping defects inside the PRD's own registers and should be dispositioned before Stage 5, because Stage 5 is
a **mechanical count** and two of the three are miscounts.

---

## 1. Method

### 1.1 Sources actually read

Only documents listed here were opened. Line numbers are the ones actually cited in this review.

| # | Source | Path | Rank | What was read |
|---|---|---|---|---|
| 1 | **PRD Lifecycle** | `../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md` | — | **L108–119** Stage 4 checks + gate · L121–127 Stage 5 · L104–106 rejected-finding rule |
| 2 | **Master PRD** | `../MASTER_PRD.md` | **1** | L119 `MP-GBR-20` · L120 `MP-GBR-21` · L352 `MP-GBR-11` · L357 `MP-GBR-16` · L359 `MP-GBR-18` · L360 `MP-GBR-19` · L361 `MP-GBR-20`…`23` |
| 3 | **Library PRD v1.1** | `../library/Library_PRD_v1.md` | **3** | **L673–680** — `LIB-16.1`, **`LIB-16.2`**, `LIB-16.3` verbatim |
| 4 | **Seat Management PRD v1.0 — FROZEN** | `../seat-management/PRD-SEAT-MANAGEMENT.md` | **3** | L892 `SEAT-FR-109` · L895 `SEAT-FR-110` · L898 `SEAT-FR-111` · L917 `SEAT-FR-115` · L1347 `SEAT-BR-030` · L1358 `SEAT-XC-012` · L432 `SEAT-BR-020` · L71 `SEAT-BR-045` range |
| 5 | **Bounded Context Map** | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** | **L364–372 §8** aggregate/invariant register, `BC-03` row read verbatim · L388 §8.1 `AttendanceDay` sizing note |
| 6 | **PRD-007 Requirements Review** | `../seat-management/PRD-007_REQUIREMENTS_REVIEW.md` | — | **L60–99** — sources table, §1.2 severity scheme, §2 six-check table. Used as the structural precedent |
| 7 | **PRD-006 Architecture Alignment** (Stage 3) | `./PRD-006_ARCHITECTURE_ALIGNMENT.md` | — | §10.1 the `ATT-GAP-002` defect · §18 gap table · §11 rejected findings |
| 8 | **PRD-006 Attendance Management v1.2** | `./PRD-006_ATTENDANCE-MANAGEMENT.md` | Unranked | **Read in full.** Sections cited individually throughout |

**Deliberately not consulted as authority:** `PRD_REGISTRY.md` (not on the Rank ladder), EA v2.1 (Rank 6,
descriptive), the Configuration Guide (Rank 7). Stage 4 tests requirements against Rank 1–5 and against the PRD's
own internal consistency; Ranks 6–7 cannot fail a requirement.

### 1.2 Severity scheme

Inherited unchanged from `PRD-007_REQUIREMENTS_REVIEW.md` §1.2, which inherits it from
`PRD-004_INDEPENDENT_REVIEW_REPORT.md` §19.

| Severity | Meaning |
|---|---|
| **CRITICAL** | Ships a security or data-integrity defect, or contradicts Rank 1. Blocks the stage |
| **HIGH** | A requirement is unimplementable, unevaluable, or breaches a Rank 1–5 rule |
| **MEDIUM** | A genuine defect in specification quality; behaviour is recoverable from elsewhere in the document |
| **LOW** | Cosmetic, navigational, or a precision improvement with no behavioural consequence |
| **REJECTED** | Considered and dismissed, with the reason recorded |

### 1.3 Measurement, not assertion

Every count in this review was produced by a script over the PRD text, not by reading. Two scripts were used:
`/tmp/att_verify.py` (register contiguity, mode constants, event surface) and `/tmp/att_cov.py` (acceptance-
criterion coverage, with ellipsis-range expansion). Both are throwaway tooling in `/tmp` and are **not**
repository artefacts — a `prd006_*` gate script is a **Stage 5** deliverable and none was created here.

> **Two of my own scripts were wrong before they were right, and that is recorded.** A first coverage script
> reported `0/279 = 0.0%`; its regex consumed the trailing table pipe and left the *verifies* column empty. A
> second reported `276/279`, missing `ATT-EVT-002`…`004`, because it did not expand the ellipsis range
> `` `ATT-EVT-001`…`004` `` used by `ATT-AC-117` at L1861. **The PRD was correct both times and the tool was
> wrong both times.** The figure below is from the corrected tool.

---

## 2. The six Stage 4 gate checks

`PRD_LIFECYCLE.md` L110–116 names exactly six. Each is answered against measured evidence, in the lifecycle's own
order.

| # | Check | Failure mode named by the lifecycle | Result | Section |
|---|---|---|---|---|
| 1 | Every requirement testable | *"The system should be fast" — unverifiable* | ✅ **PASS** | §3 |
| 2 | Every exclusion states what must be **impossible** | *An exclusion is not a deferral* | ✅ **PASS** | §4 |
| 3 | Every configurable has a default and a range | *Unbounded configuration is a specification hole* | 🔴 **FAIL** `RQ-1` | §5 |
| 4 | Every acceptance criterion maps to a requirement | *Orphan criterion* | ✅ **PASS** | §6 |
| 5 | No requirement restates another PRD's | *Two sources of truth* | ✅ **PASS** | §7 |
| 6 | Business rules do not contradict Rank 1 | *Rank 1 wins; the PRD is wrong* | ✅ **PASS** | §8 |

---

## 3. Check 1 — Every requirement testable ✅ PASS

### 3.1 Normative language is defined before it is used

§0.2 (L37–47) defines **MUST/MUST NOT**, **SHALL**, **SHOULD**, **MAY**, and closes the loophole explicitly:

> *"A statement without one of these words is **explanatory prose** and carries no obligation."*

This matters for the scan below, because it means a sentence without a normative verb is not a weak requirement —
it is not a requirement. The document therefore cannot accumulate untestable obligations by accident.

### 3.2 Vague-language scan — 31 patterns across all definition rows

Patterns scanned: *fast · slow · quick · appropriate · reasonable · sufficient · easy · user-friendly · intuitive
· robust · seamless · efficient · as needed · if necessary · where possible · etc. · and so on · some · many ·
various · good · better · optimal · minimal · acceptable · properly · correctly · simple · flexible · scalable ·
modern.*

**Three hits. All three inspected. None is a defect.**

| Hit | Location | Verdict |
|---|---|---|
| *"…by **many** students"* | `ATT-FR-028` L639 | **Not vague.** The word quantifies the *scenario*, and the obligation is exact: *"MUST each be processed independently; one student's outcome MUST NOT depend on another's."* Testable with two students |
| *"Minimum **acceptable** location accuracy"* | `ATT-CFG-012` L1150 | **Not vague prose — it is the setting's name.** The imprecision here is `RQ-1`, the missing default, not the noun phrase |
| *"each is **sufficient** alone"* | `ATT-BR-004` L1596 | **Not vague.** It is the precise statement of mode independence: one mode alone produces an `AttendanceRecord`. `ATT-AC-046`…`051` test it |

**Zero hits across all 209 acceptance criteria.** The criteria are the layer where vagueness would actually
damage verification, and that layer is clean.

### 3.3 The lifecycle's own example does not occur

*"The system should be fast"* has no analogue here. `ATT-NFR-003` (L1535) does the opposite:

> *"This document **MUST NOT** state a latency figure, throughput number or percentile target. No Rank 1–5
> document defines one for attendance, and an invented number becomes a false acceptance criterion —
> **`ATT-GAP-017a`**."*

This is a **refusal to state an untestable target**, which is the behaviour Stage 4 wants, and it is itself
tested by `ATT-AC-201`. Recorded as **rejected finding `R-4`** in §11, not as a gap in testability.

### 3.4 Two hedged obligations — findings, not failures

| ID | Text | Finding |
|---|---|---|
| `ATT-FR-096` L1087 | *"The module **MUST conceptually** support 50+ students entering rapidly…"* | **`RQ-7` — LOW** |
| `ATT-FR-078` L947 | *"**Where the existing architecture supports it**, the audit relationship **MUST** be retained…"* | **`RQ-6` — LOW** |

`ATT-FR-096` is rescued by `ATT-AC-104`: *"50+ students checking in within one burst all succeed, with every §6.2
invariant intact."* That criterion is executable; the adverb is redundant, not disabling.

`ATT-FR-078` is the weaker of the two. Its condition — *"where the existing architecture supports it"* — is
undecided, because the architecture in question is `ATT-GAP-010` (may `BC-03` hold a `BC-29` `FileRef`?), which is
open. Its criterion `ATT-AC-086` is written **unconditionally**: *"The audit chain links image → detection → match
→ verification → record → corrections."* A conditional obligation with an unconditional test is a mismatch. It is
**LOW** rather than MEDIUM only because the entire §13B workflow it belongs to is already build-blocked by
`ATT-FR-080`, so no implementer can reach the ambiguity.

### 3.5 Verdict

**✅ PASS.** Normative language defined; zero vague criteria; three register hits all benign on inspection; two
hedges recorded as LOW findings.

---

## 4. Check 2 — Every exclusion states what must be impossible ✅ PASS

### 4.1 The register is complete and uniformly phrased

§29 (L1638–1660) contains **21 `ATT-XC` rows**, mechanically confirmed contiguous `001`…`021`. The table's own
column header enforces the required form:

> *"| ID | Exclusion — this module **MUST NOT**… | Owner instead |"*

and its preamble (L1640) states the Stage 4 test verbatim before the reader reaches a single row:

> *"Each exclusion states what is **impossible**, not merely discouraged."*

Every one of the 21 rows completes the *"MUST NOT…"* stem. There is no row phrased as *"is out of scope"*,
*"will be added later"*, or *"is not required for V1"* — the three shapes that turn an exclusion into a deferral.

### 4.2 The two rows that mention a later version — inspected, not defects

A deferral scan for *V2 · V3 · later · defer · future · not yet* returned two rows:

| Row | Text | Why it is not a deferral |
|---|---|---|
| `ATT-XC-001` | *"…record staff attendance in any form"* → **`BC-07` (V2)** | The prohibition is **absolute and present-tense**: this module may never record staff attendance, in V1 or after. `BC-07 (V2)` is the *owner instead* column — it names who will own it, which is what the column is for. Attendance does not acquire the capability when `BC-07` ships |
| `ATT-XC-010` | *"…define a seventh V1 mode, including RFID/NFC/BLE"* → **§33 Future** | Same shape. The impossibility is stated (`MUST NOT` define a seventh mode); §33 is the classification of where RFID lives instead. Verified mechanically: **zero** `ATTENDANCE_MODE_RFID` occurrences in the document |

### 4.3 The four rows whose owner is a gap — still impossibilities

Four rows name an `ATT-GAP-*` in the *Owner instead* column: `ATT-XC-003` → `ATT-GAP-003`/`004`, `ATT-XC-013` →
`ATT-GAP-006`, `ATT-XC-015` → `ATT-GAP-007`, `ATT-XC-017` → `ATT-GAP-008a`.

This is the pattern that most easily degrades into a deferral, so each was read in full. **All four still state
what is impossible now**, and the gap identifies who must decide *whether that ever changes* — it does not soften
the prohibition in the meantime. `ATT-XC-013`, for example, forbids this module from specifying dynamic-QR
cryptography **at all**; `ATT-GAP-006` names the Security Platform owner who must specify it elsewhere.

### 4.4 The three prohibitions carried as FRs — disclosed, not hidden

L1663–1670 records that `ATT-FR-098` (no configuration store), `ATT-FR-130` (no audit store) and `ATT-FR-146` (no
analytics ownership) are carried as `MUST NOT` **functional requirements** rather than exclusions, *"because each
is a boundary against a named owner rather than a general prohibition."* The note exists precisely so a reader
searching only the exclusion register does not conclude the prohibition is absent. All three are `MUST NOT`
phrased and all three are covered by criteria. **No finding.**

### 4.5 Verdict

**✅ PASS.** 21 of 21 exclusions state impossibility. Zero deferrals disguised as exclusions.

---

## 5. Check 3 — Every configurable has a default and a range 🔴 FAIL

### 5.1 Structural completeness — 24 of 24, all nine columns

§16.3 (L1132–1162) declares its own obligation at L1134:

> *"Every entry carries owner, default, allowed domain, validation, failure behaviour, effective behaviour and
> audit — as required by §0.3 and `LIB-16.2`/`LIB-16.3`."*

The register's columns are `ID | Configurable | Owner | Default | Allowed domain | Validation | Failure behaviour
| Effective behaviour | Audit` — nine columns, exceeding the six the review request enumerates. **All 24 rows
populate all nine cells. No cell is blank.** Owner is `Owner` (the Library Owner role) on all 24; audit is `Yes`
on all 24; failure behaviour is a reject-and-retain form on all 24.

Structurally, this register is more complete than the check requires. **The failure is in content, not
structure.**

### 5.2 `RQ-1` — seven configurables have no default and no allowed domain · **HIGH**

Seven rows carry the literal string **`ATT-GAP-017`** where a default belongs, and *"— **unresolved**"* where an
allowed domain belongs:

| ID | Configurable | Default cell | Allowed-domain cell | Validation cell |
|---|---|---|---|---|
| `ATT-CFG-005` | Dynamic QR rotation interval | **`ATT-GAP-017`** | Bounded duration — **unresolved** | Must be > 0 and ≤ validity window |
| `ATT-CFG-006` | Dynamic QR validity window | **`ATT-GAP-017`** | Bounded duration — **unresolved** | Must be ≥ rotation interval |
| `ATT-CFG-011` | GPS acceptance radius | **`ATT-GAP-017`** | Bounded distance — **unresolved** | Must be > 0 and within bound |
| `ATT-CFG-012` | Minimum acceptable location accuracy | **`ATT-GAP-017`** | Bounded distance — **unresolved** | Must be > 0 |
| `ATT-CFG-014` | Face match confidence threshold | **`ATT-GAP-017`** | Bounded 0–1 — **unresolved** | Within bound |
| `ATT-CFG-019` | OCR high-confidence threshold | **`ATT-GAP-017`** | Bounded 0–1 — **unresolved** | Within bound |
| `ATT-CFG-023` | Correction window | **`ATT-GAP-017`** | Bounded duration — **unresolved** | Must be ≥ 0 |

**The rule breached, verified at source.** `Library_PRD_v1.md` **L676–677**, Rank 3:

> `LIB-16.2` — *"Every setting **MUST** have a documented default. A library that has changed nothing **MUST** be
> fully operable."*

Seven settings have no documented default. **That is a breach of a Rank 3 requirement, and this review records it
as one.** Severity **HIGH**: a Rank 3 rule is violated, and configuration validation for four of the seven
(`005`, `006`, `011`, `012`) is expressed as a relative constraint (*"within bound"*, *"≤ validity window"*)
against a bound that does not exist — which is not implementable as written.

### 5.3 What the PRD does about it — four mitigations, verified

None of these closes `RQ-1`. All four are load-bearing for the **gate** question in §13, so each was checked
rather than accepted.

**1 — The failure is named, owned and reasoned.** `ATT-GAP-017` (L2075) states the question, names the
authoritative void (*"No Rank 1–5 source"*), cites `LIB-16.2` as the rule in tension, and assigns **product
owner**. The ledger at L2109 is blunter than most reviews would be:

> *"🔴 **OPEN — and it is a live `LIB-16.2` breach.** Seven configurables have no default… **Inventing seven
> numbers would satisfy the letter and destroy the point.** Product owner. Recorded as the single **FAIL** in the
> verification report."*

**2 — The seven are blocked from use, not silently defaulted.** `ATT-AC-199` (L1979): *"Each of the seven
configurables whose default is unresolved is blocked from use until `ATT-GAP-017` is answered, and no default is
invented for it."*

**3 — A tenant that configures nothing is still operable — the second half of `LIB-16.2` is satisfied.**
`ATT-BR-038` (L1163–1166) states the default policy and its justification:

> *"Every default above is **Disabled** for a mode unless the mode requires nothing that does not already exist.
> Manual (`ATT-CFG-017`) defaults **Enabled** because it needs no device, no edge and no unresolved decision — and
> because `LIB-16.2` requires that 'a library that has changed nothing MUST be fully operable.' **A tenant that
> configures nothing can still take attendance, by reception, on day one.**"*

**4 — None of the seven is reachable in a default tenant.** Cross-checking each unresolved setting against the
mode that owns it:

| Unresolved setting | Owning mode | That mode's default |
|---|---|---|
| `ATT-CFG-005`, `006` | Dynamic QR | `ATT-CFG-002` = **Disabled** |
| `ATT-CFG-011`, `012` | Fixed QR + GPS | `ATT-CFG-004` = **Disabled** |
| `ATT-CFG-014` | Face | `ATT-CFG-016` = **Disabled** (and `ATT-FR-064` blocks the build entirely) |
| `ATT-CFG-019` | Register OCR workflow | `ATT-CFG-018` = **Disabled** (and `ATT-FR-080` blocks the build) |
| `ATT-CFG-023` | Correction window | Optional — `ATT-FR-115` applies only *"where a correction window is configured"* |

**Every one of the seven belongs to a capability that is off by default.** A tenant on day one uses Manual, which
has a concrete default and no unresolved setting. The breach is therefore real but **latent** — it cannot be
reached without an Owner deliberately enabling a mode whose settings the document has refused to invent.

### 5.4 `RQ-2` — `ATT-AC-199` says "the seven" and cites four · **MEDIUM**

The criterion that carries mitigation 2 reads, verbatim at L1979:

```
| `ATT-AC-199` | **Each of the seven configurables whose default is unresolved is blocked from use
until `ATT-GAP-017` is answered, and no default is invented for it** |
`ATT-CFG-006`, `ATT-CFG-014`, `ATT-CFG-019`, `ATT-CFG-023` |
```

**The prose says seven. The verifies column names four.** `ATT-CFG-005`, `ATT-CFG-011` and `ATT-CFG-012` are
absent from it.

Those three are not uncovered — the coverage tool finds them at `ATT-AC-017` (`ATT-CFG-005`), `ATT-AC-041`
(`ATT-CFG-011`) and `ATT-AC-038` (`ATT-CFG-012`), which is why total coverage is 279/279 and this is not a
coverage failure. **But none of those three criteria tests the blocked-until-answered property.** `ATT-AC-017`
tests that *"codes rotate at the configured interval"*; `ATT-AC-038` tests that *"accuracy worse than threshold →
rejected"*. Both **presume a configured value exists** — the precise thing `ATT-AC-199` exists to forbid.

So three of the seven settings are covered for their *functional* behaviour and uncovered for their *blocked*
behaviour, while the criterion that asserts all seven are blocked names only four. Severity **MEDIUM**: the
document's own safety net has three holes in it, and the mismatch is between a criterion's prose and its own
citation list — exactly the class Stage 5's mechanical count will not catch, because the count only sees the
citation list.

### 5.5 The other seventeen — checked, clean

`ATT-CFG-001`…`004`, `007`, `009`, `013`, `015`…`018`, `020`…`022`, `024` carry concrete defaults (`Disabled`,
`Enabled`, `Strict`) with closed domains (`true`/`false`, `strict` only in V1). `ATT-CFG-008` (approved Wi-Fi
networks) defaults **Empty** with domain *"Tenant-scoped list"* and validation *"Non-empty when `ATT-CFG-003`
enabled"*; `ATT-CFG-010` (library coordinates) defaults **Unset** with *"Required when `ATT-CFG-004` enabled"*.

`Empty` and `Unset` were tested against `LIB-16.2` rather than assumed acceptable. Both **are** documented
defaults — an empty list is a value, and both rows make the dependent mode un-enableable until the value is
supplied (*"Reject; mode cannot enable"*). Neither leaves a tenant inoperable. **No finding.**

### 5.6 Verdict

🔴 **FAIL** on the check, with `RQ-1` **HIGH** and `RQ-2` **MEDIUM**.

Configurable coverage, stated numerically: **24/24 structurally complete** (nine columns each) · **17/24 with a
concrete default and a closed domain** · **7/24 with neither** · **24/24 covered by at least one acceptance
criterion** · **4/7 covered by the criterion that asserts they are blocked.**

---

## 6. Check 4 — Every acceptance criterion maps to a requirement ✅ PASS

### 6.1 Measured coverage

Parsed from `## 30. Acceptance Criteria` (L1675) to `## 31.` (L1992), with ellipsis ranges expanded.

```
AC rows parsed:                     209
ORPHAN ACs (naming no requirement):   0        []
Dangling AC citations:                0

ATT-FR   148/148   uncovered = 0
ATT-BR    42/42    uncovered = 0
ATT-INV   12/12    uncovered = 0
ATT-EVT     4/4    uncovered = 0
ATT-XC     21/21   uncovered = 0
ATT-PO     14/14   uncovered = 0
ATT-CFG    24/24   uncovered = 0
ATT-NFR    14/14   uncovered = 0
────────────────────────────────────
TOTAL     279/279  =  100.0%
```

**Zero orphan criteria** — the failure mode Stage 4 names for this check — and zero orphan requirements, which is
the converse the check does not require but `ATT-NFR-010` does: *"A rule that cannot be checked MUST be treated as
unmet."*

### 6.2 The PRD's §31.1 claim is true

§31.1 (L1994–2007) publishes exactly these figures. **They reproduce.** This is worth stating plainly because the
same table was once false, and the PRD says so itself at L2011:

> *"This table previously read 100% while the measured value was 49.1% — 137 of 279 obligations, with 142 having
> no criterion at all… it was fixed by **writing the 91 missing criteria (`ATT-AC-119`…`ATT-AC-209`), not by
> lowering the claim**."*

A document that discloses its own retracted metric and then republishes a reproducible one is behaving the way
`ATT-NFR-010` demands.

### 6.3 Distribution across the six modes and the workflows

| §30 subsection | ACs |
|---|---|
| 30.1 Fixed QR (mode 1) | 13 |
| 30.2 Dynamic QR (mode 2) | 10 |
| 30.3 Fixed QR + Wi-Fi (mode 3) | 10 |
| 30.4 Fixed QR + GPS (mode 4) | 12 |
| 30.5 Face (mode 5) | 16 |
| 30.6 Manual — individual entry (mode 6, §13A) | 9 |
| 30.7 Manual — register image → OCR (§13B) | 6 |
| 30.8 OCR failure → manual verification (§13C) | 10 |
| 30.9 Entry / exit determinism (§14) | 12 |
| 30.10 Duplicate, concurrency, volume (§15) | 8 |
| 30.11 Owner configuration (§16) | 6 |
| 30.12 Tenancy, authorization, events, boundary | 6 |
| 30.13 Ownership, roles and scope (§3) | 6 |
| 30.14 Mode set and mode independence (§7) | 6 |
| 30.15 Mode-level rules not covered above (§8–§13) | 14 |
| 30.16 Invariants, timing and concurrency (§6, §14, §15) | 9 |
| 30.17 Corrections, audit and authorization (§18–§20) | 15 |
| 30.18 Ports, events and downstream boundary | 17 |
| 30.19 Exclusions, configurables, NFRs | 24 |
| **Total** | **209** |

Every one of the six V1 modes has a dedicated criterion block. No mode is covered only by generic criteria.

### 6.4 Verdict

**✅ PASS.** 209 criteria, 0 orphans, 279/279 = 100.0%.

---

## 7. Check 5 — No requirement restates another PRD's ✅ PASS

### 7.1 Foreign-prefix scan inside requirement statements

Scanning every `ATT-FR/BR/INV/EVT/XC/PO/NFR` statement line for identifiers belonging to other documents:

| Foreign prefix | Occurrences inside requirement statements |
|---|---|
| `MP-*` (Master PRD, Rank 1) | 9 |
| `LIB-*` (Library PRD, Rank 3) | 5 |
| `AUTH-*` (Authentication PRD, Rank 3) | 3 |
| `ADR-*` (Rank 2) | 3 |

**Every one is a citation, not a restatement.** The distinguishing test: does the sentence create an obligation on
`BC-03`, or does it re-declare the other document's obligation? All 20 do the former — e.g. `ATT-FR-092`:
*"The idempotency key **MUST** be tenant-scoped (`X-13`)."* The obligation is Attendance's; `X-13` is the reason.

### 7.2 The hard case — §23 Seat Management Integration

§23 is where a restatement would most plausibly occur, because it discusses a **frozen** Rank 3 PRD at length.
Each identifier it cites was checked against `PRD-SEAT-MANAGEMENT.md` at source:

| Cited | Found at | Cited correctly? |
|---|---|---|
| `SEAT-BR-020` | L432 | ✅ |
| `SEAT-FR-109` | L892 | ✅ *"On `attendance.StudentCheckedIn` (`E-08`), the module MUST mark the student's active allocation…"* |
| `SEAT-FR-110` | L895 | ✅ |
| `SEAT-FR-111` | L898 | ✅ *"`E-08` handling MUST be idempotent by event identifier."* |
| `SEAT-FR-115` | L917 | ✅ *"A stale or missed `E-08` event MUST NOT corrupt the allocation. Occupancy is an advisory…"* |
| `SEAT-XC-012` | L1358 | ✅ |
| `SEAT-BR-030` | L1347 | ✅ |

**Zero dangling citations.** More importantly, §23's own requirements are Attendance-side obligations that are
*complementary* to PRD-007's, not copies of them:

- `ATT-FR-141` — *publish* with a stable event identifier **so that** `SEAT-FR-111`'s idempotency is achievable.
  PRD-007 owns the consuming idempotency; PRD-006 owns the producing stability. Two distinct obligations.
- `ATT-FR-142` — MUST NOT rely on `BC-04` having processed an event.
- `ATT-FR-143` — MUST NOT emit a check-out that did not occur, *because* `BC-04` frees a seat on it.
- `ATT-FR-144` — an attendance QR must not move a seat, and a seat QR must not produce attendance.

`ATT-FR-144` is the closest thing to a restatement, since `SEAT-XC-012` already forbids the seat-QR direction. But
`SEAT-XC-012` binds **`BC-04`** (*"…by this module"*) and `ATT-FR-144` binds **`BC-03`**. A prohibition needs
stating on both sides of a boundary to be enforceable on both sides. **Not a second source of truth.**

### 7.3 Ownership deferrals are stated as MUST NOTs, not as re-specifications

`ATT-FR-098` (no config store — `BC-25`/`ADR-0017`), `ATT-FR-130` (no audit store — `BC-24`), `ATT-FR-140` (no
occupancy — `BC-04`), `ATT-FR-146` (no analytics — `BC-26`). Each names the owner and specifies nothing of the
owner's model. This is the correct shape: the PRD says what it will not own, rather than describing how the owner
works.

### 7.4 Verdict

**✅ PASS.** No requirement in PRD-006 restates another PRD's requirement as its own.

---

## 8. Check 6 — Business rules do not contradict Rank 1 ✅ PASS

### 8.1 Every Rank 1 anchor verified at source

`MASTER_PRD.md` was opened and each cited global business rule read verbatim:

| Rank 1 rule | Master PRD line | Text (abbreviated) | PRD-006 carrier | Contradiction? |
|---|---|---|---|---|
| `MP-GBR-11` | **L352** | *"Attendance cannot be **silently** manipulated. Corrections exist, but are **append-only, carry an actor and a reason, and emit `attendance.AttendanceCorrected`**"* | `ATT-INV-005`, `ATT-INV-011`, `ATT-BR-040`, `ATT-FR-111` | **None.** All three elements present: append-only, actor+reason, `ATT-EVT-003` emitted |
| `MP-GBR-16` | **L357** | *"A student may not be **seated** without a valid membership. Seating **blocks**; Attendance **records and flags** — a paying student is never locked out at the door"* | `ATT-NFR-009` | **None — and the asymmetry is honoured.** `ATT-NFR-009`: *"Where membership validity (`E-03`) is stale or unavailable, attendance MUST still be recordable and MUST be flagged rather than blocked"* |
| `MP-GBR-18` | **L359** | *"Attendance check-in is **idempotent** by `(studentRecordId, date, idempotencyKey)`"* | `ATT-INV-003`, `ATT-FR-090` | **None.** Key tuple reproduced exactly |
| `MP-GBR-19` | **L360** | *"Policy changes are **versioned with `effectiveFrom` and never retroactive**"* | `ATT-FR-089`, `ATT-FR-103` | **None.** `ATT-FR-089`: evaluated against rules *"in force at the moment it was recorded"* |
| `MP-GBR-20` | **L119** | *"A permission grant is **scope-bearing**. Holding a permission is not the same as being able to exercise it on a given resource"* | `ATT-BR-001` | **None.** Near-verbatim, then adds the operational obligation to evaluate both |
| `MP-GBR-21` | **L120** | *"The scope register is closed: `self`, `guardianOf`, `tenantWide`. No fourth scope may be introduced without an ADR"* | `ATT-FR-005` | **None.** *"MUST NOT introduce a fourth scope"* |

### 8.2 The Rank 4 invariant set is adopted, not reinterpreted

BC Map §8 (**L372**), the `BC-03` row, states four invariants inside the `AttendanceDay` boundary: *"Check-out
cannot precede check-in; **idempotent by (studentRecordId, date, idempotencyKey)**; no more than one open session
per student; corrections are append-only with actor + reason."*

§6.2 (L437–445) reproduces all four as `ATT-INV-002`…`005` and says so: *"These four are quoted from **BC Map §8**
and are adopted unchanged."* Verified word-for-word. `ATT-INV-006`…`008` are additions declared as such
(*"Added by this document, consistent with the above"*) and none weakens a quoted invariant.

`ATT-BR-003` (*"One `AttendanceDay`, one database transaction"*) matches BC Map §8's framing sentence at L366:
*"**The aggregate is the transaction boundary** — one aggregate, one database transaction, no exceptions."*

### 8.3 The five roles are taken, not invented

`ATT-FR-003` (L251): *"This module **MUST** use only the five roles defined in Master PRD §6. It **MUST NOT**
define, introduce, extend or infer any role."* The §4.1 table quotes Master PRD §6's own wording per role, and
`ATT-FR-004` correctly narrows `parent` to read-only on the grounds that *"visibility is not mutation."*

### 8.4 Verdict

**✅ PASS.** No business rule contradicts Rank 1. Six global rules and four Rank 4 invariants verified at source.

---

## 9. Review-request points 1 and 5–8

The six lifecycle checks above are the gate. The review request adds specific verification points; those not
already answered are answered here.

### 9.1 Point 1 — uniqueness, determinism, non-duplication ✅ PASS

**Uniqueness.** All ten registers are mechanically contiguous with no collision:

```
ATT-FR   148/148  max=148  contiguous  ATT-BR   42/42  max=42   contiguous
ATT-INV   12/12   max=12   contiguous  ATT-EVT   4/4   max=4    contiguous
ATT-XC    21/21   max=21   contiguous  ATT-PO   14/14  max=14   contiguous
ATT-CFG   24/24   max=24   contiguous  ATT-NFR  14/14  max=14   contiguous
ATT-AC   209/209  max=209  contiguous  ATT-GAP  18/18  max=18   contiguous
TOTAL identifiers: 506 (declared 506)      out-of-range tokens: 0
```

**Determinism.** The two places where non-determinism would matter are both resolved by table, not by prose:
`ATT-FR-081`'s four-row check-in/check-out state table (§9.4) and `ATT-FR-007`'s closed six-mode set (§9.2).

**Non-duplication — 14 apparent duplicate definitions, all rejected.** A scan for identifiers appearing in the
first cell of more than one table row returned 14. Each was opened. **All 14 are summary-index rows, not competing
definitions:**

| Group | Rows | What the second occurrence is |
|---|---|---|
| `ATT-BR-010`, `014`, `017`, `019`, `021`, `022` | §8–§12 body → §28 | §28 is *"The complete `ATT-BR-*` register, with the section that states each in context"* — a one-line index with a `§` back-pointer. Compare L698 (*"Wi-Fi configuration **MUST** be tenant-scoped; one tenant's approved network **MUST NOT** validate another tenant's attendance"*) with L1609 (*"Wi-Fi configuration is tenant-scoped \| §10.3"*). The second is a table-of-contents entry |
| `ATT-CFG-001`…`004`, `016`, `017` | §16.2 → §16.3 | §16.2 is the six-row *mode-to-configurable* map; §16.3 is the nine-column register. Different tables, different purposes |
| `ATT-BR-037`, `ATT-XC-002` | §28/§29 → §31.2 | §31.2 is the **upstream traceability** table (*"This document \| Traces to \| Rank"*) |

Recorded as **rejected finding `R-1`** in §11.

**A related scan artefact, also rejected.** Fourteen identifiers appeared to lack a normative verb. Twelve resolve
immediately — the scan had matched their §28 index row rather than their statement (`ATT-BR-003` L459, `ATT-BR-009`
L535, `ATT-BR-025` L892, `ATT-BR-033` L1050, `ATT-BR-040` L1242, `ATT-FR-125` L1336, and others all carry **MUST**
or **MUST NOT** at their point of definition). The remaining three — `ATT-BR-035` (L1076), `ATT-BR-037` (L1113),
`ATT-BR-038` (L1164) — are genuinely declarative rather than modal (*"Presence is a property of the student-day,
not of the method"*). Under §0.2 that would make them prose, **but each states a definitional fact that its
criteria test** (`ATT-AC-103`, `ATT-AC-196`, `ATT-AC-070` respectively), so each is verifiable. Recorded as
**rejected finding `R-3`**.

### 9.2 Point 5 — the six V1 modes ✅ PASS

| Property | Evidence | Result |
|---|---|---|
| Closed set of exactly six | `ATT-FR-007` L475 — *"V1 **MUST** support exactly these six attendance modes, and no others"* | ✅ |
| Six mode constants exist | Mechanical: `FIXED_QR`, `DYNAMIC_QR`, `FIXED_QR_WIFI`, `FIXED_QR_GPS`, `FACE`, `MANUAL` | ✅ **6** |
| No seventh | `ATT-XC-010` L486 — no seventh mode, *"requirement, configurable, event or acceptance criterion"* | ✅ |
| RFID absent | Mechanical: `ATTENDANCE_MODE_RFID` occurrences = **0** | ✅ |
| Independence, not composition | `ATT-BR-004` (each sufficient alone), `ATT-BR-005` (any one may be used; never two for one attendance) | ✅ |
| No verification pipeline | `ATT-XC-011` L493 — no *"verification-layer architecture, pipeline, chain, or any construct in which one attendance requires a sequence of methods"* | ✅ |
| Compound ≠ composed | `ATT-BR-006` — modes 3 and 4 are *"single modes with a compound condition"* | ✅ |
| No condition leakage | `ATT-BR-007` — Wi-Fi only to mode 3, GPS only to mode 4; *"Neither **SHALL** be applied to Fixed QR, Dynamic QR, Face or Manual"* | ✅ |
| Method immutable | `ATT-FR-008` — *"A Manual entry never becomes a QR entry"* | ✅ |
| Per-tenant switching | `ATT-FR-009`, `ATT-FR-099`, §16.2 six-row map | ✅ |
| Smartphone never mandatory | `ATT-BR-008` — Manual is *"a **first-class mode**, not a degraded path"* | ✅ |

The document supplies its own worked disproof of the composition reading at L505–508 — six students, six modes,
one attendance each — which is the strongest form of a testable statement of independence.

**Observation, not a finding.** Of the six modes, **two are specified but build-blocked by their own
requirements**: Face by `ATT-FR-064` (pending `ATT-GAP-012`/`014`) and the §13B register workflow by
`ATT-FR-080` (pending `ATT-GAP-010`/`011`). A third, Dynamic QR, is specified without its cryptographic
construction (`ATT-GAP-006`, `ATT-XC-013`). This is disclosed, not concealed, and the corresponding configurables
default **Disabled** with *"blocked by `ATT-FR-064`"* / *"blocked by `ATT-FR-080`"* written into the validation
column. It is a scheduling fact for Stage 6, not a Stage 4 defect.

### 9.3 Point 6 — Manual + Register OCR/Vision ✅ PASS

**The deliberate separation is the strongest structural decision in the document.** §13A (individual manual entry)
and §13B (register image → OCR) are specified independently, and only §13B is blocked.

**§13A — fully specified, buildable.** `ATT-FR-065`…`069`, `ATT-BR-023`…`025`. The flow is stated as an ordered
sequence (`ATT-FR-066`), the persisted fields are enumerated to ten items (`ATT-FR-067`), it is subject to the
same duplicate/sequence/idempotency rules as every other mode (`ATT-FR-068`), it emits an audit fact naming the
acting staff member (`ATT-FR-069`), and it cannot cross a tenant (`ATT-BR-025`).

**§13B — the workflow is a nine-step pipeline** (`ATT-FR-071`), and every hazard is closed:

| Hazard | Requirement |
|---|---|
| Becoming a seventh mode | `ATT-FR-072` — every record carries `AttendanceMethod = MANUAL` |
| Becoming authentication | `ATT-BR-026` — *"a **data-capture assistance mechanism**… not authentication, not student-identity ownership"* |
| A private student directory | `ATT-FR-073` — MUST resolve against authoritative records via the proper boundary |
| Silent creation from a guess | `ATT-INV-009` — *"An attendance record **MUST NOT** be created solely from an unresolved OCR result"* |
| Self-certifying confidence | `ATT-BR-027` — high confidence that matches no authoritative record still enters `NEEDS_MANUAL_VERIFICATION` |
| Autonomous creation | `ATT-BR-028` — presented for creation, not created, unless `ATT-CFG-020` (default **Disabled**) is enabled |

`ATT-FR-074` names a single deterministic failure state, **`NEEDS_MANUAL_VERIFICATION`**, covering five distinct
failure causes — the correct design, because it prevents each cause growing its own semi-state.

**§13E is honest about the blockers** and, unusually, corrects its own earlier framing in place: the second row is
struck through and re-stated, because the original *"no `BC-03` → `BC-27` edge"* framing was refuted by BC Map
§7.4 `F-1`/`F-3` — that edge **would be architecturally backwards**, so its absence is correct and the real gap is
that *no context owns an OCR capability at all*. The note that follows (L972–978) is careful to say what the
finding does **not** change: *"It does not unblock the workflow. `ATT-FR-080` stands unchanged."*

`ATT-FR-078` is the one weakness here — see `RQ-6`, §3.4.

### 9.4 Point 7 — duplicate, concurrency, check-in/check-out ✅ PASS

**Check-in/check-out is a four-row table with no escape hatch.** `ATT-FR-081` (L987): *"Check-in and check-out
**MUST** be resolved by this table, **and by no other logic**."*

| # | Current state | Operation | Outcome |
|---|---|---|---|
| 1 | No open presence | Check-in | Check-in recorded; presence opens |
| 2 | Open presence exists | Check-in | **Duplicate.** Rejected; existing presence unchanged |
| 3 | Open presence exists | Check-out | Check-out recorded; presence closes |
| 4 | No open presence | Check-out | **Invalid.** Rejected; no record created |

All four rows are total over the state × operation space, and rows 3–4 are made unreachable rather than undefined
when `ATT-CFG-021` disables check-out (`ATT-BR-029`) — with the explicit statement that a check-in-only day is
*"a complete, valid record — not an error state."*

| Concern | Requirements | Assessment |
|---|---|---|
| Idempotency | `ATT-FR-090` `(studentRecordId, date, idempotencyKey)` · `ATT-FR-091` returns the original outcome · `ATT-FR-092` tenant-scoped (`X-13`) | Complete |
| Idempotency **enforcement point** | `ATT-BR-034` — *"inside the aggregate boundary, not by a pre-check followed by a write. **A check-then-write is not idempotency under concurrency**"* | Precise, and rules out the common wrong implementation |
| Cross-mode duplicates | `ATT-FR-093` — QR then Manual produces no second open presence · `ATT-BR-035` — *"The mode does not create a separate namespace"* | Complete |
| Concurrency | `ATT-FR-084` (concurrent check-ins → exactly one open) · `085` (→ exactly one closed) · `086` (mixed → deterministic; aggregate is the serialisation point) | Complete |
| Replay | `ATT-FR-094` (Dynamic QR) · `ATT-FR-095` (transport, absorbed by idempotency) | Complete |
| Partial application | `ATT-FR-087` — rejected with a specific reason, no partial apply, no intermediate state | Complete |
| Missed check-out | `ATT-FR-082` marks it · `ATT-BR-030` forbids auto-completion with an invented timestamp · `ATT-BR-031` forbids retracting the check-in · `ATT-FR-083` forbids a fabricated `E-08` | Complete, and the reasoning is given: a fabricated check-out *"would silently free a seat that is still occupied"* |
| Time | `ATT-FR-088` platform time port, never `DateTime.now()`, never the client (`X-09`) · `ATT-BR-032` explicit tenant time zone | Complete |
| Contention | `ATT-NFR-001` — confined to one student-day; two students never contend | Complete |
| Throughput integrity | `ATT-BR-036` — MUST NOT be achieved by relaxing an invariant, batching across aggregates, or deferring duplicate detection | Complete |
| Bulk decomposition | `ATT-FR-006` — one independent, independently-idempotent, independently-failable transaction per `AttendanceDay` | Complete, and consistent with `ATT-XC-009`'s ban on distributed transactions |

#### `RQ-8` — `ATT-INV-010` is described as a restatement when it narrows scope · **LOW**

`ATT-INV-004` (L443), quoted from BC Map §8: *"There **MUST** be **no more than one open session per student** at
any moment."*

`ATT-INV-010` (L996): *"At most one presence **SHALL** be open for one student **in one tenant** at one time
(`ATT-INV-004` **restated at the operation level**)."*

These are not the same proposition. Read literally, `ATT-INV-004` forbids a person holding open presences at two
different libraries simultaneously; `ATT-INV-010` permits it. **`ATT-INV-010` is the correct rule** — `ID-2` makes
`StudentRecordId` per-tenant, so BC Map's *"per student"* is already tenant-bound in context, and a person
enrolled at two libraries is two student records. **The rule is right; the word "restated" is wrong.** It is a
narrowing clarification, and calling it a restatement invites a later reader to treat one as redundant and delete
it. **LOW** — no behavioural consequence.

### 9.5 Point 8 — authorization, tenant isolation, PRD-007 boundary ✅ PASS

**Authorization** — `BC-18` is the sole decider, and nothing is cached:

- `ATT-FR-117` — every operation authorised by `BC-18`; this module *"**MUST NOT** evaluate, grant, cache or
  infer an authorisation decision (`X-13`)"*
- `ATT-FR-118` — no new RBAC system, role, permission model or scope
- `ATT-FR-119` — a `parent` MUST NOT create, correct or delete
- `ATT-FR-120` — no role in the active tenant = no access (`AUTH-2.16`)
- `ATT-FR-121` — roles never inherited across tenants (`AUTH-2.8`)
- `ATT-FR-123` — no credential, OTP, session token or key in any record, evidence object, event payload, audit
  fact **or log line** (`ID-1`)
- §19.2's operation × role × scope table covers all seven operation classes, and every scope value is drawn from
  the closed `MP-GBR-21` register

§19.1's five-concept table is the substantive contribution: authentication (`BC-18`) · student identity
(`BC-01`/`BC-10`) · attendance method · environment verification · attendance record. `ATT-BR-041` then forbids
the six specific confusions by name — *"QR = authentication · GPS = identity · Wi-Fi = identity · OCR =
authentication · OCR = definitive identity without verification · Face = a new authentication framework."* This is
consistent with frozen `PRD-007`'s `SEAT-BR-030` at L1347.

**Tenant isolation** — `ATT-INV-012` (*"Every attendance-owned fact and configuration **MUST** be tenant-scoped.
No exception exists"*), then `ATT-FR-124` enumerates eighteen specific artefacts that must carry `tenantId`,
including the ones normally forgotten: **idempotency keys, caches, projections, exports**. `ATT-FR-126` restates
the `X-13` key-construction rule; `ATT-FR-127` requires **fail-closed** on missing or ambiguous tenant context
with an explicit ban on inferring or reusing the last-known tenant; `ATT-FR-128` rejects writes for a suspended
tenant, matching BC Map §8's `Tenant` invariant.

**PRD-007 boundary** — see §7.2. The ownership split at §23.1 matches BC Map `E-08` (*"Seating is the occupancy
owner, Attendance is the trigger"*) and PRD-007's `SEAT-BR-020`. `ATT-FR-138`/`139`/`140` prohibit reading or
mutating `BC-04` state and prohibit owning occupancy; §24's note resolves the *"students currently inside"*
ambiguity by naming both facts separately rather than picking one.

#### `RQ-5` — §23.4 is an empty section · **LOW**

L1452 declares `### 23.4 No second attendance system` and is followed immediately by the section rule and
`## 24`. **It has no body.** A whole-document scan for empty sections returns fourteen further headings, but all
fourteen are `##`-level chapter titles immediately followed by a `###` subsection — normal structure. **§23.4 is
the only heading in the document that promises a rule and delivers nothing.**

The rule it names is not missing from the document: `ATT-BR-033` at §14.7 (L1050) states *"This module **MUST NOT**
create a second presence, occupancy or 'currently inside' system of record beyond the `AttendanceDay` aggregate"*,
and `ATT-FR-140` covers the seating direction. **LOW** — navigational only, no obligation is lost.

---

## 10. Point 9 — review of all `ATT-GAP-*` items

Per the mandate, every gap was reviewed and **no architectural resolution was invented for any of them.** No new
gap identifier was created by this review.

### 10.1 The register as it stands

21 rows against 18 numbers (three suffixed successors following the `PRD-005` `MM-GAP-010a` precedent, disclosed
at L2079). Statuses as written in the §32.1 ledger:

| Gap | Ledger status (L2091–2111) | Owner named | Reviewed disposition |
|---|---|---|---|
| `ATT-GAP-001` | ✅ RESOLVED | *(closed by conformance)* | Accepted — verified in the Stage 3 record and the reconciliation record |
| `ATT-GAP-002` | ✅ RESOLVED | Architecture owner *(in the register)* | **Conflicting bookkeeping — `RQ-4`** |
| `ATT-GAP-003` | 🔴 OPEN — inherited | Architecture owner | Accepted. Systemic §9-vs-§7 defect; frozen PRD-004/PRD-005 both declined it; `ADR-0018` §3.2 requires a separate ADR |
| `ATT-GAP-004` | 🔴 OPEN — worse than `003` | Architecture owner | Accepted. `E-14`'s targets exclude `BC-03`, so fraud escalation has no authorised path in either direction |
| `ATT-GAP-005` | 🔴 OPEN | Legal counsel + architecture owner | Accepted. BC Map `Q-04` is open in the authoritative document itself; a PRD may not promote it |
| `ATT-GAP-006` | 🔴 OPEN | Security Platform owner | Accepted. Blocks Dynamic QR build |
| `ATT-GAP-007` | 🔴 OPEN | Architecture owner | Accepted |
| `ATT-GAP-008` | 🔴 OPEN | Library PRD owner | Accepted. Merging with `LIB-6.5` would take ownership of a Rank 3 field |
| `ATT-GAP-008a` | 🔴 OPEN | Architecture owner | Accepted |
| `ATT-GAP-009` | 🔴 OPEN — *"a genuine V1 hole"* | Architecture owner | Accepted. `BC-18` owns auth devices; `BC-08` is V2; **no V1 context can own a V1 face scanner** |
| `ATT-GAP-010` | 🔴 OPEN — needs an ADR | Architecture owner | Accepted. `ADR-0016` named as the precedent mechanism, and the PRD correctly notes its own case is *weaker* |
| `ATT-GAP-011` | 🟡 NARROWED | Architecture owner | Accepted. Narrowed **by refutation** — the requested edge was shown to be backwards |
| `ATT-GAP-012` | 🔴 OPEN — storage sub-question resolved negatively | Architecture owner + Security Platform | Accepted. Blocks Face entirely. **Contributes to `RQ-3`** |
| `ATT-GAP-013` | 🔴 OPEN | Architecture owner | Accepted |
| `ATT-GAP-014` | 🔴 OPEN — a conflict, not a void | Legal counsel + Security Platform | Accepted. `ID-5` pseudonymisation is structurally inapplicable to a template that *is* the identifier |
| `ATT-GAP-015` | 🔴 OPEN | Product owner + architecture owner | Accepted. EA is Rank 6 and cannot force V3; no Rank 1–5 document places Face in V1 either |
| `ATT-GAP-016` | 🔴 OPEN | Legal counsel + architecture owner | Accepted. Third-party handwriting aggravates it |
| `ATT-GAP-016a` | 🔴 OPEN | Architecture owner | Accepted |
| `ATT-GAP-017` | 🔴 OPEN — *"a live `LIB-16.2` breach"* | **Product owner** | Accepted. **This is `RQ-1`** |
| `ATT-GAP-017a` | 🔴 OPEN | Product owner + architecture owner | Accepted |
| `ATT-GAP-018` | 🔴 OPEN | Product owner | Accepted. `ATT-FR-106` preserves permissive behaviour rather than inventing a restriction |

**Every open row names an owner.** That is the Stage 4 gate's requirement, and it is met by 20 of 20 open rows.

### 10.2 The gap classification rule is sound

§0.4 (L86–95) is the reason none of these can be quietly resolved by an implementer:

> *"A gap resolved by implementation choice is not resolved — **it is an undocumented architecture decision made
> by whoever happened to write the code first.**"*

This mirrors `SEAT-BR-045` in frozen PRD-007. `ATT-GAP-*` items are correctly excluded from acceptance-criterion
coverage (§31.1: *"0 — by design. Gaps are questions, never criteria"*), which is right: a question cannot be
tested.

### 10.3 `RQ-3` — three mutually exclusive gap counts · **MEDIUM**

Three statements about the same register, in the same section, cannot all be true.

| Location | Statement | Implied partition |
|---|---|---|
| **L2045** (§32 header) | *"**Eighteen questions — 17 still open.**"* | denominator **18** (numbers) → 1 resolved |
| **L2049** (§32 banner) and **L2113** (ledger result) | *"**3 resolved, 1 narrowed, 17 open.**"* | denominator **21** (rows) |
| **Mechanical scan of the ledger's own verdict column** | **2 RESOLVED · 1 NARROWED · 18 OPEN** | denominator **21** (rows) |

The first uses numbers as its denominator and the second uses rows, which is defensible on its own but confusing
side by side. **The third is the real defect: the ledger's stated result does not match the ledger's own rows.**

The discrepancy is locatable. `ATT-GAP-012`'s verdict cell reads *"🔴 **OPEN** — storage sub-question **RESOLVED**
negatively"*. It is a row whose status is OPEN and which the tally appears to count among the resolved. The v1.1
changelog corroborates this: it recorded *"2 gaps resolved, 1 narrowed, 18 open"* at a time when only
`ATT-GAP-002` was fully resolved — meaning the second was already the `012` storage sub-question — and v1.2 then
added `ATT-GAP-001` to reach three.

**No invention is offered here as to which figure is intended.** Either reading is defensible: partial resolutions
may reasonably be counted, or may reasonably not be. What is not defensible is publishing both. Severity
**MEDIUM**, and it matters more than it looks, because **Stage 5 is a mechanical count** (`PRD_LIFECYCLE.md` L126:
*"Mechanical means counted by a tool, not by reading"*) and a tool reading the verdict column will produce 2/1/18
and disagree with the document.

### 10.4 `RQ-4` — `ATT-GAP-002` status conflicts across three locations · **MEDIUM**

Carried forward from the Stage 3 record §10.1 and re-verified here at all three sites.

| Location | What it says |
|---|---|
| **L2058** — §32 register row | *"Where is the authenticated `BC-18` context composed for a `BC-03` operation? `E-11` is `BC-18 → BC-01`; no `BC-18 → BC-03` edge exists"* — posed as an **open question**, owner *"Architecture owner"* |
| **L2092** — §32.1 ledger | ✅ **RESOLVED** — *"Frozen `PRD-007` (Rank 3) consumes `BC-18` with **no `E-` edge**… A Core context receiving an established session without its own identity edge is a **ratified pattern**"* |
| **L310–316** — §5.2 body note | *"`ATT-GAP-002` is now **RESOLVED** from existing governance (§32.1)"* |

Two of three say resolved; one still poses the question with an owner attached.

**The underlying resolution is sound** — independently re-verified at `PRD-SEAT-MANAGEMENT.md` **L227** (`BC-18`
listed as consumed with no `E-` edge) and **L1347** (`SEAT-BR-030`). This is a **documentation-consistency
defect, not an architectural one.** The §32 preamble at L2047 does mitigate it — *"The table below is the original
register, **preserved**. §32.1 is the resolution ledger and is **the authoritative status for each row**"* — which
makes the register a deliberate historical snapshot rather than a contradiction. **MEDIUM rather than LOW** only
because `ATT-GAP-002`'s register row still names an owner and a pending decision, and an owner reading their own
name in a register does not necessarily read the ledger three sections later.

Owner: PRD author. Disposition: reconcile before Stage 5.

### 10.5 Point 10 — the two known items, rechecked

| Item | Recheck result |
|---|---|
| **`ATT-GAP-002` bookkeeping inconsistency** | **Confirmed, unchanged.** Located at L2058 vs L2092 vs L310. Underlying resolution independently re-verified as sound. Recorded as `RQ-4`, **MEDIUM**. Not fixed here — this review is read-only |
| **`LIB-16.2` configurable-default FAIL** | **Confirmed, unchanged.** Seven configurables (`005`, `006`, `011`, `012`, `014`, `019`, `023`). Rule verified at source, `Library_PRD_v1.md` **L676**. Recorded as `RQ-1`, **HIGH**. Four mitigations verified (§5.3), one of which was found defective and recorded separately as `RQ-2` |

---

## 11. Findings recorded as REJECTED

`PRD_LIFECYCLE.md` L104–106 requires this section: *"A review that records only accepted findings is
indistinguishable from a review that found nothing."* Five candidate findings were considered and dismissed —
three of them artefacts of my own tooling.

| # | Candidate finding | Why rejected |
|---|---|---|
| **`R-1`** | *14 requirement identifiers are defined twice* | **Scanner artefact.** All 14 second occurrences are summary-index rows in §16.2, §28 or §31.2 — tables that exist to index requirements, not to define them. Verified by opening all 14 pairs (§9.1) |
| **`R-2`** | *Three vague words appear in requirement text* | **Inspected, all benign.** *"many students"* quantifies a scenario whose obligation is exact; *"acceptable"* is part of a setting's name; *"sufficient alone"* is the precise statement of mode independence (§3.2) |
| **`R-3`** | *14 rules lack a normative verb* | **Twelve are scanner artefacts** — the scan matched a §28 index row rather than the definition, which carries **MUST**. The remaining three (`ATT-BR-035`, `037`, `038`) are declarative statements of fact, each tested by a criterion, therefore verifiable (§9.1) |
| **`R-4`** | *`ATT-NFR-003` states no performance target, so performance is untestable* | **This is compliance, not a defect.** Stage 4's named failure is *"The system should be fast"* — an invented, unverifiable target. `ATT-NFR-003` refuses to invent one, cites the absence of any Rank 1–5 figure, records `ATT-GAP-017a` with an owner, and is itself tested by `ATT-AC-201`. Inventing a percentile here would *create* the failure this check exists to catch |
| **`R-5`** | *Two exclusions reference V2/Future, so they are deferrals* | **Column misread.** `BC-07 (V2)` and `§33 Future` appear in the *Owner instead* column, naming who owns the capability elsewhere. The prohibition in the middle column is absolute and present-tense in both rows (§4.2) |

---

## 12. All findings, with severity

| ID | Finding | Severity | Location | Owner | Blocks |
|---|---|---|---|---|---|
| **`RQ-1`** | **Seven of 24 configurables have no default and no allowed domain — a live breach of `LIB-16.2` (Rank 3). Validation for four of them references a bound that does not exist** | 🔴 **HIGH** | §16.3 L1143, 1144, 1149, 1150, 1152, 1156, 1160 | **Product owner** (`ATT-GAP-017`) | Use of those seven settings. **Does not block Stage 4** — deferred with reason + owner |
| **`RQ-2`** | **`ATT-AC-199` asserts "each of the seven" configurables is blocked, but its verifies column names only four; `ATT-CFG-005`, `011`, `012` are covered only by criteria that presume a configured value exists** | 🟠 **MEDIUM** | L1979 | PRD author | Should close before Stage 5 |
| **`RQ-3`** | **Three mutually exclusive gap counts: L2045 implies 1 resolved of 18; L2049/L2113 state 3/1/17 of 21; the ledger's own verdict column mechanically yields 2/1/18 of 21** | 🟠 **MEDIUM** | L2045, L2049, L2103, L2113 | PRD author | **Stage 5 is a mechanical count** — should close first |
| **`RQ-4`** | **`ATT-GAP-002` reads OPEN with an assigned owner in the §32 register but RESOLVED in the §32.1 ledger and the §5.2 body note.** Underlying resolution independently verified as sound | 🟠 **MEDIUM** | L2058 vs L2092 vs L310 | PRD author | Should close before Stage 5. Carried from Stage 3 §10.1 |
| **`RQ-5`** | **§23.4 "No second attendance system" is a heading with no body.** The rule exists as `ATT-BR-033` at §14.7 | 🔵 **LOW** | L1452 | PRD author | Nothing |
| **`RQ-6`** | **`ATT-FR-078` is conditional (*"where the existing architecture supports it"*) on a condition that is itself open (`ATT-GAP-010`), while its criterion `ATT-AC-086` is unconditional** | 🔵 **LOW** | L947 vs L1810 | PRD author | Nothing — §13B is build-blocked by `ATT-FR-080` |
| **`RQ-7`** | **`ATT-FR-096` says "MUST *conceptually* support".** Rescued by `ATT-AC-104`, which is executable | 🔵 **LOW** | L1087 | PRD author | Nothing |
| **`RQ-8`** | **`ATT-INV-010` is labelled a restatement of `ATT-INV-004` but narrows its scope to one tenant.** The narrowing is correct; the label is not | 🔵 **LOW** | L996 | PRD author | Nothing |

**Totals:** 0 CRITICAL · **1 HIGH** · **3 MEDIUM** · **4 LOW** · 5 REJECTED.

**No finding contradicts Rank 1.** `RQ-1` breaches Rank 3 and is explicitly deferred to a named owner.

---

## 13. The Stage 4 gate

The gate is not the six checks. `PRD_LIFECYCLE.md` **L119**:

> **Gate:** conflicts closed or explicitly deferred **with a reason and an owner**.

| Conflict / failure | Closed or deferred? | Reason recorded? | Owner named? |
|---|---|---|---|
| `RQ-1` — `LIB-16.2` breach, 7 configurables | **Deferred** as `ATT-GAP-017` | ✅ *"No Rank 1–5 source… Inventing seven numbers would satisfy the letter and destroy the point"* | ✅ **Product owner** |
| 20 open `ATT-GAP-*` items | **Deferred** | ✅ Each row states the sources in tension or their absence | ✅ **20 of 20** name an owner |
| `RQ-2`, `RQ-3`, `RQ-4` | **Open, newly raised by this review** | ✅ Recorded above | ✅ PRD author |
| `RQ-5`…`RQ-8` | **Open, newly raised** | ✅ Recorded above | ✅ PRD author |
| Stage 3 carry-forwards (`ATT-GAP-003`/`004` §9-vs-§7; `ID-5`-vs-biometrics) | **Deferred, unchanged** | ✅ `ADR-0018` §3.2 requires a separate ADR; frozen PRD-004/PRD-005 precedent followed | ✅ Architecture owner |

**✅ Gate SATISFIED.** Nothing is silently carried. Every conflict is either closed, or deferred with both a
reason and a named owner.

---

## 14. Containment audit

| Obligation | Result |
|---|---|
| PRD-006 not modified | ✅ `600c59ec…` — identical before and after this review |
| PRD-007 not modified | ✅ `c8760a46…` |
| Registry / BC Map / Dependency Matrix / ADRs not modified | ✅ Untouched; read-only access only |
| No ADR created | ✅ None |
| No architecture, requirement, edge, event, role, port, configurable or gap invented | ✅ None. No new `ATT-*` identifier of any register was created by this review |
| No `ATT-GAP-*` resolved | ✅ None. All 20 open rows remain open with their owners intact |
| PRD-006 not frozen | ✅ Still **v1.2 DRAFT** |
| No Stage 5 artefact created | ✅ No `prd006_*` gate script; `TRACEABILITY_MATRIX.md` untouched |
| Only the review report produced | ✅ This file |

---

## 15. Final Stage 4 verdict

### ⚠️ CONDITIONALLY PASSED

**Gate checks:** 5 PASS · **1 FAIL** (check 3, `LIB-16.2`).
**Gate itself:** ✅ **SATISFIED** — every conflict deferred with a reason and an owner.

**Coverage, measured:** 209 acceptance criteria · **0 orphan criteria** · 0 dangling citations · **279/279
obligations covered = 100.0%** · 506 identifiers across ten contiguous registers.

**Configurable coverage, measured:** 24/24 structurally complete across nine columns · **17/24 with a concrete
default and closed domain** · **7/24 with neither** · 24/24 criterion-covered · 4/7 covered by the criterion that
asserts they are blocked.

**Findings:** 0 CRITICAL · 1 HIGH · 3 MEDIUM · 4 LOW · 5 REJECTED.

**Unresolved gaps carried forward:** 20 open (of 21 rows / 18 numbers), each with a named owner. Two of them —
`ATT-GAP-012` and `ATT-GAP-014` — block the Face mode from being built at all; two more — `ATT-GAP-010` and
`ATT-GAP-011` — block the §13B register workflow. `ATT-GAP-010` requires an ADR. None was resolved here.

### What must happen before Stage 5

Stage 5 is a **mechanical count with zero collisions**. Two of the three MEDIUM findings are miscounts that a
counting tool will surface as disagreements with the document:

1. **`RQ-3`** — reconcile the gap arithmetic to a single stated partition and denominator.
2. **`RQ-4`** — reconcile `ATT-GAP-002`'s status across the register, the ledger and the §5.2 note.
3. **`RQ-2`** — align `ATT-AC-199`'s citation list with its own prose, or amend the prose.

`RQ-1` does **not** block Stage 5. It blocks **Stage 7**, because a frozen document containing seven settings with
no default would freeze a `LIB-16.2` breach into a Rank 3-citable artefact. It closes when the **product owner**
answers `ATT-GAP-017` — not by this review, and not by an implementer.

### What this review deliberately did not do

It did not resolve `ATT-GAP-017` by proposing seven numbers, though the seven bounds are all obvious enough to
guess. `ATT-GAP-017`'s own ledger entry explains why that would be the wrong kind of help: *"Inventing seven
numbers would satisfy the letter and destroy the point."* A rotation interval chosen by a reviewer is not a
product decision; it is a product decision made by whoever happened to write the review first.

---

*End of `PRD-006_REQUIREMENTS_REVIEW.md`. Stage 4 — Requirements Review. Unranked. PRD-006 remains v1.2 DRAFT and
is not frozen.*
