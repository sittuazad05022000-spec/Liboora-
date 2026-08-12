# PRD-008 — Attendance Management v1.1 — Verification Report

| Field | Value |
|---|---|
| **Report for** | [`PRD-008_ATTENDANCE-MANAGEMENT.md`](./PRD-008_ATTENDANCE-MANAGEMENT.md) v1.1 **DRAFT** |
| **Bounded Context** | **`BC-03` Attendance** — determined from `LIBOORA_BOUNDED_CONTEXT_MAP.md` §3.1 L98, **not assumed** |
| **Aggregate** | `AttendanceDay` — BC Map §8 L372 |
| **Lifecycle stage** | `PRD_LIFECYCLE.md` **Stage 2 — Draft**. Not reviewed, **not frozen**, unranked |
| **Report date** | 2026-08-04 |
| **Baseline in force** | `BASELINE-2026-08-04-E` |
| **Verdict** | **CONDITIONAL PASS — unchanged after the v1.1 gap re-audit.** Internally complete and mechanically re-verified. The re-audit **resolved 2 gaps and narrowed 1**, leaving **18 open**, and **upgraded 2 in severity**. A full architectural PASS is still **not** claimed, and the verdict deliberately did not improve — see §16 |
| **Files created by this task** | Exactly **2** — the PRD and this report. The v1.1 re-audit **created none** and modified only these same two |
| **Authoritative documents modified** | **ZERO** |

---

## 1. Scope and honesty statement

This report verifies the **internal integrity** of `PRD-008` and its **conformance to authorities that already
exist**. It does **not** certify that the module is architecturally complete, because it is not: two of the six V1
modes depend on architecture no ranked document provides, and the PRD's own number is contested by the registry.

> **`ATT-NFR-010` is the governing standard of this report:** *"A rule that cannot be checked **MUST** be treated
> as unmet."* Every figure below was produced by executing a command against the file, not by reading the PRD's
> own claims. Where the PRD's claim and the measurement disagreed, **the measurement won and the PRD was fixed.**

---

## 2. The defect this verification actually caught

The most important finding is not a gap — it is that **the PRD's first internal pass published a false coverage
figure**, and the mechanical check caught it.

| | Claimed by the draft | Measured by this report |
|---|---|---|
| Obligation coverage | **100%** | **137 / 279 = 49.1%** |
| Obligations with **no** criterion | 0 | **142** |
| Registers with **zero** coverage | none | **`ATT-PO-*` — 0 / 14** |

`ATT-PO-*` (ports), `ATT-CFG-*` (configurables) and `ATT-NFR-*` (non-functional) were almost entirely unverified.
Those are precisely the registers that encode **boundary discipline** — the rules whose violation is silent.

**This was fixed by writing the 91 missing criteria (`ATT-AC-119`…`ATT-AC-209`), not by lowering the claim.**
Lowering the claim would have produced an honest document describing an unverifiable module. The precedent is
`TR-2` in `PRD-005`, where a false 100% was retracted; here the figure was made *true* instead of retracted.

---

## 3. Internal reconciliation performed in this pass

The instruction authorises fixing internal wording and consistency defects where the fix does not change an
authoritative external decision. Seven were found and fixed. **None required an external decision; none was
invented around.**

| # | Defect | Evidence it was a defect | Fix | External decision needed? |
|---|---|---|---|---|
| **R-1** | Ten identifiers written as bracketed *"out of declared range — not used"* placeholders (`ATT-XC-021`/`022`/`024`/`025`, `ATT-BR-043`…`046`, `ATT-FR-149`, `ATT-FR-148a`) | Each defined **no obligation** and named the in-range identifier already carrying the rule | **Deleted all ten.** No obligation lost — proven by re-running full coverage afterwards | No |
| **R-2** | `ATT-XC-023` used **normatively** at §17 while §0.3 declared `ATT-XC-001…020` | A normative rule outside the published range makes the range false — `PRD_LIFECYCLE.md` Stage 2 rule 3 | Renumbered **`ATT-XC-023` → `ATT-XC-021`**; range closes at **21**, contiguous, no gap | No |
| **R-3** | `ATT-XC-021` (Device Management exclusion) was **missing from the §29 exclusion register** | A reader consulting only §29 would conclude the prohibition did not exist | Added the row; §29 now states it is the complete register of all 21 | No |
| **R-4** | §0.3 declared *"Total: 296 identifiers … 278 obligation-bearing"* | **Arithmetically impossible** — the ten declared ranges sum to 414, not 296 | Corrected to **506 total / 279 obligation-bearing / 209 AC / 18 gap numbers**, with the counting convention stated | No |
| **R-5** | §32 presented **21 gap rows against 18 declared numbers**, disclosed only at the bottom of §32 | The register is a promise made in §0.3; a reader learns the discrepancy ~1,900 lines late | §0.3 now declares **"18 numbers / 21 rows"** up front and names the three suffixed successors, citing the `MM-GAP-006a`/`007a`/`010a` precedent | No |
| **R-6** | §29 carried a note about *"the four bracketed out-of-range notes"* then listed **seven** sections | Self-contradictory, and described text deleted by R-1 | Replaced with a statement of why three prohibitions are `MUST NOT` requirements rather than exclusions | No |
| **R-7** | **False 100% coverage claim** in §31.1 (see §2) | Measured 137/279 | 91 criteria written; §31.1 now carries the measured figure **and** an explicit retraction of the false one | No |

**Net effect on obligations: zero removed, zero reworded, 91 acceptance criteria added, one exclusion renumbered.**

---

## 4. Mechanical verification — identifier registers

Method: every token matching `\bATT-(FR|BR|INV|EVT|XC|PO|CFG|NFR|AC|GAP)-\d+[a-z]?\b` extracted from the file and
compared against the §0.3 declaration.

| Register | Declared range | Count | Observed | Missing | Above range | Duplicates | Verdict |
|---|---|---|---|---|---|---|---|
| `ATT-FR-*` | 001…148 | 148 | 148 | none | none | none | **PASS** |
| `ATT-BR-*` | 001…042 | 42 | 42 | none | none | none | **PASS** |
| `ATT-INV-*` | 001…012 | 12 | 12 | none | none | none | **PASS** |
| `ATT-EVT-*` | 001…004 | 4 | 4 | none | none | none | **PASS** |
| `ATT-XC-*` | 001…021 | 21 | 21 | none | none | none | **PASS** |
| `ATT-PO-*` | 001…014 | 14 | 14 | none | none | none | **PASS** |
| `ATT-CFG-*` | 001…024 | 24 | 24 | none | none | none | **PASS** |
| `ATT-NFR-*` | 001…014 | 14 | 14 | none | none | none | **PASS** |
| `ATT-AC-*` | 001…209 | 209 | 209 | none | none | none | **PASS** |
| `ATT-GAP-*` | 001…018 + 3 suffixed | 18 / 21 rows | 18 + 3 | none | none | none | **PASS** |

- **Contiguity:** every numeric range is gap-free. `PRD_LIFECYCLE.md` Stage 2 rule 3 — *"A gap makes the published
  range false"* — is satisfied for all ten registers.
- **Totals:** 279 obligation-bearing + 209 AC + 18 gap numbers = **506**, matching §0.3 exactly.
- **Dangling references: 0.** Every `ATT-*` token in the document, including in prose and the changelog, resolves
  to a declared identifier.
- **External identifiers: 71 distinct** (`BC-*`, `E-*`, `ADR-*`, `X-*`, `ID-*`, `AR-*`, `SEAT-*`, `MM-*`, `MP-*`,
  `LIB-*`, `AUTH-*`). **All 71 verified to exist elsewhere in `docs/`. Zero invented.**

### 4.1 Prefix collision — re-executed, not cited

```
grep -rhoE '\bATT-[A-Z]+-[0-9]+\b' docs/ --include='*.md' \
  | grep -v attendance-management | sort -u | wc -l   →  0
```

**`ATT-*` collides with nothing.** `PRD_LIFECYCLE.md` Stage 2 rule 2 (collision procedure executed **before**
writing) is satisfied. The three suffixed gap numbers are the only suffixed `ATT-*` tokens, and all three are
declared in §0.3.

---

## 5. Mechanical verification — acceptance criteria coverage

Method: for each of the 209 `ATT-AC-*` rows in §30, the *Verifies* column was parsed and every obligation
identifier extracted (including expansion of `…` ranges). The union was compared against all 279 obligations.

| Register | In force | Covered by ≥1 criterion | Coverage |
|---|---|---|---|
| `ATT-FR-*` | 148 | 148 | **100%** |
| `ATT-BR-*` | 42 | 42 | **100%** |
| `ATT-INV-*` | 12 | 12 | **100%** |
| `ATT-EVT-*` | 4 | 4 | **100%** |
| `ATT-XC-*` | 21 | 21 | **100%** |
| `ATT-PO-*` | 14 | 14 | **100%** |
| `ATT-CFG-*` | 24 | 24 | **100%** |
| `ATT-NFR-*` | 14 | 14 | **100%** |
| **Total obligations** | **279** | **279** | **100.0%** |
| `ATT-GAP-*` | 18 | **0 — by design** | A gap is a question; a question cannot pass |

- **Orphan requirements: 0.** Every obligation has at least one criterion.
- **Orphan criteria: 0.** All 209 criteria name at least one obligation.
- **No criterion verifies a `GAP`** — confirmed by scanning the *Verifies* column of all 209 rows.

> **What 100% here does and does not mean.** It means every obligation is *checkable*. It does **not** mean any
> obligation is *checked* — **0 of 209 criteria are proven by a test**, because no code exists. Under `SID-4.56`
> (*"a rule that cannot be checked SHALL be treated as unmet"*) and `ATT-NFR-010`, this module is **specified**,
> not **verified**.

---

## 6. Architecture conformance — the `BC-03` boundary

### 6.1 Integration edges — the decisive check

BC Map §7 L292: *"If an edge is not in this table, it does not exist and adding it requires an ADR."*

| Edge | Direction | Authorised for `BC-03`? | Used by PRD-008 | Verdict |
|---|---|---|---|---|
| `E-03` | `BC-02` → `BC-03` | Yes — BC Map §7.1 | Consumed, `ATT-PO-001` | **PASS** |
| `E-04` | `BC-06` → `BC-03` | Yes — BC Map §7.1 | Consumed, `ATT-PO-002` | **PASS** |
| `E-08` | `BC-03` → `BC-04` | Yes — BC Map §7.1 | Published, `ATT-PO-008` | **PASS** |
| `E-17` | → `BC-21` | Yes — §7.3 universal | Consumed, `ATT-PO-003` | **PASS** |
| `E-18` | → `BC-19` | Yes — §7.3 universal | Consumed, `ATT-PO-004` | **PASS** |
| `E-19` | → `BC-25` | Yes — §7.3 universal | Consumed, `ATT-PO-005` | **PASS** |
| `E-20` | → `BC-24` | Yes — §7.3 universal | Published, `ATT-PO-009` | **PASS** |
| `E-23` | → `BC-22` | Yes — §7.3 universal | Published, `ATT-PO-010` | **PASS** |
| `E-24` | `BC-03` → `BC-30` | Yes — BC Map §7.3 | Consumed, `ATT-PO-006` | **PASS** |

**Edges asserted by PRD-008 that are not in BC Map §7: ZERO.**

Five further edge identifiers appear in the text (`E-01`, `E-10`, `E-11`, `E-21`, `E-22`). Each was inspected
individually, and **none is asserted as a `BC-03` edge**:

| Token | How it appears | Verdict |
|---|---|---|
| `E-01`, `E-10` | Only as the bounds of the Core Library cluster allow-list, demonstrating `E-03`/`E-04`/`E-08` fall inside it | Compliance evidence, not an edge |
| `E-11` | Cited to state `E-11` is `BC-18 → BC-01`, **not** `BC-18 → BC-03` → `ATT-GAP-002` | Denial, not an edge |
| `E-21` | Cited in `ATT-XC-006` to **prohibit** consuming `BC-23` | Exclusion |
| `E-22` | Cited in `ATT-XC-004` to **prohibit** consuming `BC-29` → `ATT-GAP-010` | Exclusion |

### 6.2 Events — exactly the BC Map §9 four

| Event | BC Map §9 | In PRD-008 | Naming convention |
|---|---|---|---|
| `attendance.StudentCheckedIn` | Yes | `ATT-EVT-001` | `<Context>.<Aggregate><PastTenseVerb>` — **PASS** |
| `attendance.StudentCheckedOut` | Yes | `ATT-EVT-002` | **PASS** |
| `attendance.AttendanceCorrected` | Yes | `ATT-EVT-003` | **PASS** |
| `attendance.FraudSignalDetected` | Yes | `ATT-EVT-004` | **PASS** |

A pattern scan for `attendance.*` returned **exactly these four names and no others**. **No event was invented.**

### 6.3 Dependency prohibitions

| Rule | Requirement | Where honoured | Verdict |
|---|---|---|---|
| `X-04` | No sync domain → communication | `ATT-FR-148`, `ATT-PO-010`, `ATT-NFR-007` | **PASS** |
| `X-07` | No cross-context call bypassing EVENT | `ATT-XC-007`, all ports in §5.2 | **PASS** |
| `X-09` | No `DateTime.now()` in domain | `ATT-BR-032`, `ATT-NFR-011` | **PASS** |
| `X-10` | Audit has no update/delete path | `ATT-FR-130`, `ATT-INV-008` | **PASS** |
| `X-13` | No cache/index key without `tenantId` | `ATT-FR-124`…`127`, `ATT-INV-006`, `ATT-NFR-006` | **PASS** |
| `L2` / `L3` | Rank ladder; domain declares ports | §5, R8 cluster allow-list | **PASS** |
| `ADR-0001` | Modular monolith | `ATT-XC-002` | **PASS** |
| `ID-1`…`ID-6` | Identity Triad; `ID-2` tenant confinement | `ATT-FR-123`, `ATT-FR-125` | **PASS** |

### 6.4 The `E-03` asymmetry — preserved, not "fixed"

BC Map `E-03`, `MP-GBR-16` and `MM-BR-007` all hold that **Seating blocks, Attendance flags**. `ATT-NFR-009` and
`ATT-AC-206` encode this, with the reason recorded in prose so a later reader does not "correct" it into a block.
**PASS.**

### 6.5 PRD-007 boundary — the frozen neighbour

| `PRD-007` rule | Requirement | PRD-008 response | Verdict |
|---|---|---|---|
| `SEAT-BR-020` | Seating must not create/verify attendance | Attendance is sole owner (`ATT-FR-001`); no reciprocal claim on seating (`ATT-FR-138`/`139`) | **PASS** |
| `SEAT-FR-109`/`110` | Consume `E-08` for occupancy | Published per `ATT-PO-008` | **PASS** |
| `SEAT-FR-111` | Idempotent by event identifier | `ATT-FR-141` stable event id; `ATT-FR-136` | **PASS** |
| `SEAT-FR-115` | Occupancy advisory; stale event must not corrupt allocation | `ATT-FR-142`, and **`ATT-FR-143` forbids emitting a check-out that did not occur** | **PASS** |
| **`SEAT-XC-012`** | Seat QR ≠ attendance QR; **flows must not merge** | `ATT-FR-144`, `ATT-AC-118` | **PASS** |

**PRD-007 verified byte-identical after this pass** — SHA-256
`c8760a46a8a371a6548e56e50c867bc4ae8e86d26f73e8f119ae003dced4b7c6`.

---

## 7. Product conformance — the six modes

| # | Mode constant | V1 | Independently enableable | Specified | Buildable today |
|---|---|---|---|---|---|
| 1 | `ATTENDANCE_MODE_FIXED_QR` | Yes | `ATT-CFG-001` | §8 | **Yes** |
| 2 | `ATTENDANCE_MODE_DYNAMIC_QR` | Yes | `ATT-CFG-002` | §9 | Yes — crypto deferred to Security Platform (`ATT-GAP-006`) |
| 3 | `ATTENDANCE_MODE_FIXED_QR_WIFI` | Yes | `ATT-CFG-003` | §10 | Yes — no anti-spoof claim permitted (`ATT-GAP-007`) |
| 4 | `ATTENDANCE_MODE_FIXED_QR_GPS` | Yes | `ATT-CFG-004` | §11 | Yes — no anti-spoof claim permitted (`ATT-GAP-008a`) |
| 5 | `ATTENDANCE_MODE_FACE` | Yes | `ATT-CFG-016` | §12 | **BLOCKED** by `ATT-FR-064` until `ATT-GAP-012`/`014` answered |
| 6 | `ATTENDANCE_MODE_MANUAL` | Yes | `ATT-CFG-017` | §13 | **13A yes; 13B blocked** by `ATT-FR-080` |

- **Exactly six.** No seventh mode token exists anywhere in the document; `ATT-XC-010` forbids one.
- **`ATTENDANCE_MODE_RFID` appears zero times.** RFID is Future-only (§33.3) with **no** V1 requirement,
  configurable, acceptance criterion, event, device requirement or implementation task — verified by pattern
  search. The only RFID mentions are the classification itself and the rules excluding it.
- **Mode independence holds.** `ATT-BR-004`/`005` require any single enabled mode to be sufficient;
  `ATT-BR-006` records that modes 3 and 4 are *single modes with a compound condition*, not compositions of two
  modes; `ATT-AC-127` and `ATT-AC-128` verify both.
- **No verification layer.** `ATT-XC-011` prohibits a pipeline/chain/sequence; `ATT-AC-190` verifies it. There is
  **no** `QR → GPS → Wi-Fi → Face → Attendance` flow anywhere in the document.

### 7.1 Manual attendance — first-class, and deliberately split

| Workflow | Section | Status | Rationale |
|---|---|---|---|
| **11A** individual entry | §13A | **Buildable now** | Requires no capability the architecture lacks |
| **11B** register image → OCR/Vision | §13B | **Blocked** — `ATT-FR-080` | No `BC-03 → BC-27` edge (`ATT-GAP-011`); no `BC-03 → BC-29` edge (`ATT-GAP-010`) |
| **11C** OCR failure → `NEEDS_MANUAL_VERIFICATION` | §13C | Specified | `ATT-INV-009` forbids a record from an unresolved OCR entry |
| **11D** register-image audit | §13D | Specified | Subject to `ATT-GAP-010`/`016` |

> **The split is the substantive product decision in this PRD.** Had 11A and 11B been specified as one workflow,
> the whole of Manual mode would be blocked on an AI-architecture decision — and the students Manual exists to
> serve are precisely those without smartphones. Splitting them keeps that population served today.

---

## 8. Configurables — §16.3

| Check | Result |
|---|---|
| Configurables declared | **24**, `ATT-CFG-001`…`024` |
| Each has a named owner | **24 / 24** — Owner role |
| Each stored through `BC-25` via `E-19` (`LIB-16.1`) | **24 / 24** — `ATT-FR-097` |
| Each validated before persistence (`LIB-16.3`) | **24 / 24** — `ATT-FR-101`/`102` |
| Each has a stated failure behaviour | **24 / 24** — reject; previous value stands |
| Each has a stated effective point (`LIB-12.8`, `MP-GBR-19`) | **24 / 24** — never retroactive |
| Each audited | **24 / 24** — `ATT-FR-105` |
| Each has a documented default (`LIB-16.2`) | **17 / 24 — FAIL, disclosed** |

**Seven configurables have no default** — `ATT-CFG-005`, `006`, `011`, `012`, `014`, `019`, `023`. `LIB-16.2`
requires *every* setting to have a documented default, so this is a **genuine non-conformance**, recorded as
**`ATT-GAP-017`** and owned by the Product owner.

> **No default was invented to close this.** A fabricated Dynamic-QR validity window or face-match confidence
> threshold would become a false acceptance criterion and, worse, a security parameter chosen by whoever drafted
> fastest. `ATT-AC-199` **blocks** these seven from use until the owner answers.

---

## 9. Gap register — 18 numbers, 21 rows, all OPEN

| Gap | Question | Owner | Blocks |
|---|---|---|---|
| **`ATT-GAP-001`** | **Is this PRD-008 or PRD-006?** Registry L236 allocates **`PRD-006`** to Attendance and **`PRD-008`** to Revenue & Finance; the frozen `PRD-007` cites `PRD-006` twice | Governance owner | Document identity |
| `ATT-GAP-002` | Where is the authenticated `BC-18` context composed for a `BC-03` operation? | Architecture owner | Nothing at product level |
| `ATT-GAP-003` | `BC-26` named a consumer in BC Map §9, denied by §7 | Architecture owner | Analytics consumption |
| `ATT-GAP-004` | `BC-13` named a consumer in BC Map §9, denied by §7 | Architecture owner | Fraud-signal consumption |
| `ATT-GAP-005` | Attendance retention (`Q-04`, open in BC Map) | Legal + Product | Retention design |
| `ATT-GAP-006` | Dynamic-QR cryptographic construction | Security Platform | Mode 2 hardening |
| `ATT-GAP-007` | Network identification / spoof detection | Architecture owner | Mode 3 anti-spoof claims |
| `ATT-GAP-008` | Attendance hardware ownership | Architecture owner | Scanner association |
| **`ATT-GAP-008a`** | Is mock-location detection authorised, and who provides it? | Architecture owner | Mode 4 anti-spoof claims |
| `ATT-GAP-009` | Who owns attendance devices? `BC-18`'s `Device` is an **auth** device; `BC-08` is V2 | Architecture owner | Face scanner |
| `ATT-GAP-010` | How is a register image stored with no `BC-03 → BC-29` edge? | Architecture owner | Workflow 11B |
| `ATT-GAP-011` | Who provides OCR/Vision? No `BC-03 → BC-27` edge; **zero OCR capability exists in `docs/`** | Architecture owner | Workflow 11B |
| `ATT-GAP-012` | Where are biometric templates stored? | Security + Legal | **Face mode entirely** |
| `ATT-GAP-013` | What liveness capability exists, and who provides it? | Architecture owner | Liveness claims |
| `ATT-GAP-014` | Biometric retention/deletion, incl. `ID-5` erasure and minors | Legal + Security | **Face mode entirely** |
| `ATT-GAP-015` | **Is Face V1 or V3?** EA v2.1 says `Face Recognition (V3)`; the product instruction says V1 | Product + Architecture | Face scheduling |
| `ATT-GAP-016` | Retention for a register image containing many students' handwriting | Legal + Architecture | Workflow 11B |
| **`ATT-GAP-016a`** | Offline behaviour of Dynamic QR, which cannot be server-validated offline | Architecture owner | Offline mode 2 |
| `ATT-GAP-017` | Defaults/ranges for the seven unresolved configurables | Product owner | Those seven |
| **`ATT-GAP-017a`** | Latency/throughput targets for attendance capture | Product + Architecture | `ATT-NFR-003` |
| `ATT-GAP-018` | Is an "at least one mode enabled" constraint authorised? | Product owner | `ATT-FR-106` |

**All 21 rows are OPEN. Not one was resolved by invention.** Each names the authority that must decide it, per
§0.4 and the `SEAT-BR-045` precedent.

### 9.1 The four conflicts between authorities

These are **defects in the source documents**, raised rather than chosen, per `DOCUMENTATION_BASELINE.md` §4:
*"A conflict is a defect. If you find one, do not choose — raise it."*

| Conflict | Higher authority | Lower authority | Action taken |
|---|---|---|---|
| **PRD number** | `PRD_REGISTRY.md` (governance): Attendance = **`PRD-006`** | The product instruction: **`PRD-008`** | **`ATT-GAP-001`.** Filed under the instructed name with the conflict flagged in the header field itself. Registry §8 rule 1 — *"Numbers are never reused or reassigned"* — means a PRD cannot settle this |
| **Face version** | No Rank 1–5 document places Face in V1 | EA v2.1 (**Rank 6, descriptive**) says V3 | **`ATT-GAP-015`.** Rank 6 is *"never the reverse"*, so EA cannot overrule a product decision — but no Rank 1–5 document authorises V1 either. Specified as V1 per instruction; **blocked** by `ATT-GAP-012`/`014` regardless |
| **`BC-26`/`BC-13` consumers** | BC Map §7 (edge table) — no edge | BC Map §9 (event table) — names them | **`ATT-GAP-003`/`004`.** The same Rank 4 document contradicts itself; instances of the systemic `MM-GAP-010`. §7 L292 applied: **no edge asserted** |
| **Configurable defaults** | `LIB-16.2` — every setting needs a default | Seven have none | **`ATT-GAP-017`.** Non-conformance disclosed, not papered over |

---

## 10. §31 Architecture Consistency Audit — 20 items

| # | Item | Result |
|---|---|---|
| 1 | BC determined from the BC Map, not assumed | **PASS** — `BC-03`, §3.1 L98 |
| 2 | Aggregate matches BC Map §8 | **PASS** — `AttendanceDay`, one student-day not one punch |
| 3 | Aggregate invariants preserved | **PASS** — `ATT-INV-001`…`012` |
| 4 | Idempotency by `(studentRecordId, date, idempotencyKey)` | **PASS** — `ATT-INV-003`, `MP-GBR-18` |
| 5 | No more than one open session per student | **PASS** — `ATT-INV-004`/`010` |
| 6 | Corrections append-only with actor + reason | **PASS** — `ATT-INV-005`/`011`, `MP-GBR-11` |
| 7 | Only BC Map §7 edges used | **PASS** — 9 edges, 0 invented |
| 8 | Exactly the BC Map §9 events | **PASS** — 4, no more, no fewer |
| 9 | Event naming convention | **PASS** — `ATT-FR-135` |
| 10 | Identity Triad respected | **PASS** — `ATT-FR-125`, `ID-2` |
| 11 | Tenancy — `X-13` | **PASS** — `ATT-FR-124`…`127`, `ATT-NFR-006` |
| 12 | Authorization delegated to `BC-18` | **PASS** — `ATT-FR-117`/`118` |
| 13 | Configuration through `BC-25` (`ADR-0017`) | **PASS** — `ATT-FR-097`/`098` |
| 14 | Audit through `BC-24`, asynchronous | **PASS** — `ATT-FR-129`, `X-10` |
| 15 | No `DateTime.now()` in domain (`X-09`) | **PASS** — `ATT-BR-032` |
| 16 | Modular monolith (`ADR-0001`) | **PASS** — `ATT-XC-002` |
| 17 | Core Library cluster allow-list `E-01`…`E-10` | **PASS** — uses `E-03`/`E-04`/`E-08` only |
| 18 | PRD-007 boundary respected | **PASS** — §6.5; `SEAT-XC-012` honoured |
| 19 | Offline via `E-24` — policy here, execution there | **PASS** — `ATT-PO-011`…`014` |
| 20 | **No architecture invented** | **PASS** — 4 conflicts + 3 absent capabilities raised as gaps, 0 resolved |

**20 / 20 structural PASS — subject to the verdict caveat in §13.**

---

## 11. §32 Product Consistency Audit — 21 items

| # | Item | Result |
|---|---|---|
| 1 | Exactly 6 V1 modes | **PASS** |
| 2 | Mode constants exactly as instructed | **PASS** — all six verified by pattern search |
| 3 | RFID not V1 | **PASS** — Future only, zero V1 artefacts |
| 4 | No generic verification layer | **PASS** — `ATT-XC-011`, `ATT-AC-190` |
| 5 | Modes independent | **PASS** — `ATT-BR-004`…`007`, `ATT-AC-127` |
| 6 | No mandatory mode sequence | **PASS** — no such flow exists |
| 7 | Modes 3/4 are compound-condition single modes | **PASS** — `ATT-BR-006`, `ATT-AC-128` |
| 8 | Manual is a first-class V1 mode | **PASS** — §13, `ATT-CFG-017` |
| 9 | Manual 11A individual entry | **PASS** — §13A, buildable |
| 10 | Manual 11B register image → OCR | **PASS** — §13B, specified and blocked |
| 11 | 11C OCR failure → `NEEDS_MANUAL_VERIFICATION` | **PASS** — §13C, `ATT-INV-009` |
| 12 | 11D register-image audit | **PASS** — §13D |
| 13 | Five roles only | **PASS** — `ATT-FR-003`, `ATT-AC-121` |
| 14 | Scope register closed | **PASS** — `ATT-FR-005`, `MP-GBR-20`/`21` |
| 15 | Entry/exit deterministic | **PASS** — `ATT-FR-081` four-row table |
| 16 | Duplicate prevention specified | **PASS** — §15, `ATT-AC-144`…`146` |
| 17 | Owner configuration per tenant | **PASS** — 24 configurables |
| 18 | Every configurable has a default | **FAIL — 7 missing, `ATT-GAP-017`** |
| 19 | No overstated security claim | **PASS** — `ATT-BR-041`/`042`, `ATT-AC-194` |
| 20 | Every AC maps to a requirement | **PASS** — 209 / 209 |
| 21 | No orphan requirement | **PASS** — 279 / 279 covered |

**20 PASS / 1 FAIL.** The failure is disclosed, owned and blocking — not silently resolved.

---

## 12. §35 Final Integrity Check — 19 items

| # | Item | Result |
|---|---|---|
| 1 | PRD file exists | **PASS** — 135,020 bytes, 2,063 lines |
| 2 | Verification report exists | **PASS** — this file |
| 3 | Only those two files created/changed | **PASS** — `git status` shows exactly the two attendance-management paths |
| 4 | **PRD-007 byte-identical** | **PASS** — `c8760a46…4b7c6` |
| 5 | All registers contiguous, no collision | **PASS** — §4 |
| 6 | No dangling reference | **PASS** — 0 internal, 0 external |
| 7 | Every AC maps to a requirement | **PASS** — 209 / 209 |
| 8 | No orphan requirement | **PASS** — 279 / 279 |
| 9 | Configurables complete | **PARTIAL** — 7 defaults missing, `ATT-GAP-017` |
| 10 | Exclusions complete | **PASS** — 21, all covered by criteria |
| 11 | Exactly 6 modes | **PASS** |
| 12 | RFID Future-only | **PASS** |
| 13 | Manual individual entry present | **PASS** — §13A |
| 14 | Register OCR workflow present | **PASS** — §13B |
| 15 | OCR fallback present | **PASS** — §13C |
| 16 | Architecture boundaries respected | **PASS** — §10 |
| 17 | No invented edge | **PASS** — 0 |
| 18 | Git status clean of unintended change | **PASS** — no protected path touched |
| 19 | **PRD-008 NOT frozen** | **PASS** — Status `DRAFT`, Stage 2, Rank **Unranked**, **no ADR raised** |

### 12.1 Protected documents — verified untouched

`PRD-007` · `MASTER_PRD.md` · BC Map · Architecture Rulings · Module Dependency Matrix · Authentication PRD ·
Student Management PRD · Membership PRD · Library PRD · all ADRs · `PRD_REGISTRY.md` ·
`DOCUMENTATION_BASELINE.md` · `TRACEABILITY_MATRIX.md` · all governance files — **all unmodified**, confirmed by
`git status --porcelain` returning only the two attendance-management paths.

### 12.2 Prohibited artefacts — verified not created

No ADR · no API specification · no database schema · no SQL migration · no implementation tasks · no code · no
technical specification. **Nothing under `lib/`, `test/`, `tool/` or `android/` was touched.**

---

## 13. Verdict

**CONDITIONAL PASS.**

**What is proven.** The document is internally sound: ten registers contiguous and collision-free across 506
identifiers, zero dangling references, zero orphan requirements, zero orphan criteria, **100% obligation coverage
measured rather than asserted**, exactly the nine authorised edges, exactly the four authorised events, exactly
six modes, RFID excluded from V1 entirely, and the frozen `PRD-007` untouched to the byte.

**What is not proven, and is not claimed:**

1. **No full architectural PASS.** Eighteen gap numbers carrying 21 questions are OPEN. Four of them —
   `ATT-GAP-010`, `ATT-GAP-011`, `ATT-GAP-012` and `ATT-GAP-014` — block real V1 scope: the register-image
   workflow and the Face mode cannot be built until an architecture owner answers.
2. **The document's own number is contested** (`ATT-GAP-001`). `PRD_REGISTRY.md` allocates `PRD-006` to this
   context and `PRD-008` to Revenue & Finance, and the **frozen** `PRD-007` refers to the Attendance PRD as
   `PRD-006` twice. This must be settled by the governance owner before the number is relied upon elsewhere.
3. **`LIB-16.2` is not satisfied** — seven configurables have no documented default (`ATT-GAP-017`).
4. **0 of 209 acceptance criteria are proven by a test.** The module is **specified**, not **verified**.

**Stage 2 of `PRD_LIFECYCLE.md` is met.** Stage 3 Architecture Review is the next gate, and it cannot be entered
until at least `ATT-GAP-001`, `ATT-GAP-003`/`004`, `ATT-GAP-010`, `ATT-GAP-011` and `ATT-GAP-015` have their
owners' answers. **PRD-008 is NOT frozen, and no ADR has been raised.**

---

## 14. Reproducing every figure in this report

```bash
cd /home/user/flutter_app/docs/30-product/attendance-management
F=PRD-008_ATTENDANCE-MANAGEMENT.md

# Register contents, per family
grep -ohE '\bATT-(FR|BR|INV|EVT|XC|PO|CFG|NFR|AC|GAP)-[0-9]+[a-z]?\b' $F | sort -u

# Prefix collision across the repository — expect empty
grep -rhoE '\bATT-[A-Z]+-[0-9]+\b' ../../ --include='*.md' \
  | grep -v attendance-management | sort -u

# Events — expect exactly four distinct names
grep -oE 'attendance\.[A-Za-z]+' $F | sort -u

# Mode constants — expect six, and zero matches for RFID
grep -oE 'ATTENDANCE_MODE_[A-Z_]+' $F | sort -u

# PRD-007 byte-identity
sha256sum ../seat-management/PRD-SEAT-MANAGEMENT.md
# expect c8760a46a8a371a6548e56e50c867bc4ae8e86d26f73e8f119ae003dced4b7c6
```

Coverage and contiguity were computed by parsing the *Verifies* column of every §30 row and comparing the union
against the §0.3 declaration. The analysis scripts were written to `/tmp` deliberately and **not** committed: the
instruction forbids creating implementation tooling, and a `prd008_*` gate script would be exactly that. When
`PRD-008` reaches Stage 5, a permanent gate belongs in `tool/docs_check/` — that is a Stage 5 deliverable, not a
Stage 2 one.

---

## 16. Re-audit of `PRD-008` v1.1 — gap resolution

This section records the second pass. Its remit was narrow and explicit: **re-audit the PRD and this report,
establish OCR/Vision and Face/Biometric boundaries *only where existing governance allows*, resolve the `ATT-GAP`
register against authoritative sources without inventing anything, re-verify the numbering conflict without
modifying `PRD_REGISTRY.md`, preserve the six V1 modes and the OCR-failure rule, and modify these two files
only.** No ADR was created, nothing was frozen, and no API, schema, task or code artefact was produced.

### 16.1 What the re-audit changed in the PRD

| # | Change | Nature |
|---|---|---|
| 1 | **§5.2** — `ATT-GAP-002` marked **RESOLVED**, citing frozen `PRD-007`'s pattern of consuming `BC-18` with no `E-` edge | Resolution from a Rank 3 frozen source |
| 2 | **§5.4** — the OCR direction ruling: BC Map §7.4 `F-1`/`F-3`/`F-4` refute the requested `BC-03` → `BC-27` edge | **Refutation** of the PRD's own earlier request |
| 3 | **§5.4** — `ATT-XC-003` corrected to attribute `BC-26` to `ATT-GAP-003` and `BC-13` to `ATT-GAP-004` | Citation precision |
| 4 | **§12.4a** — new: the biometric boundary audited across eight dimensions | 2 resolved, 6 unresolved, each with its source or its stated absence |
| 5 | **§13E** — blocker table re-framed; the "missing `BC-27` edge" row corrected | Removes a **false prerequisite** |
| 6 | **§32.1** — new: the gap resolution ledger, all 21 rows | The central deliverable |
| 7 | **§32.2** — new: the numbering conflict re-verified against primary sources | `PRD_REGISTRY.md` untouched |

**No requirement identifier was added, removed, renumbered or reworded.** All ten registers are byte-stable at
506 identifiers.

### 16.2 The single most consequential finding — a request refuted, not granted

`PRD-008` v1.0 asked the architecture owner for a `BC-03` → `BC-27` edge so that OCR could be processed. **The
re-audit found that edge would be architecturally backwards**, and that its absence from BC Map §7 is correct
rather than a defect:

| Rule | Source | Statement |
|---|---|---|
| `F-1` | BC Map §7.4 L341 | *"**No capability context may import, reference, or query a domain context.** Not AI, not Analytics, not Search, not Notification, not Workflow, not Audit."* |
| `F-3` | BC Map §7.4 L343 | *"Where a capability must *cause* a domain change… it does so by **invoking the domain's public command API** through a registered port — with the domain re-validating every invariant. **The capability is an untrusted caller.**"* |
| `F-4` | BC Map §7.4 L344 | *"AI-initiated domain writes additionally require a **Human-in-the-Loop approval record** (`BC-27`) and produce an `AI Action Log` entry (`BC-24`). **No exceptions in V1.**"* |
| `MP-GBR-29`…`32` | `MASTER_PRD.md` **Rank 1** | Restates all four at the highest rank |

Two consequences were recorded in the PRD:

1. **`ATT-XC-005` is strengthened, not relaxed.** An ADR adding a `BC-03` → `BC-27` edge would now be *wrong*.
2. **§13C's staff-verification step is `F-4`'s Human-in-the-Loop approval record.** `ATT-INV-009` and
   `NEEDS_MANUAL_VERIFICATION` were written as a product safeguard; they turn out to satisfy a Rank 1 and Rank 4
   architectural mandate. This is the reason the rule was preserved **verbatim** — it is now load-bearing.

**This did not unblock the workflow, and the report does not pretend otherwise.** `ATT-FR-080` stands unchanged.
A repository-wide search for `OCR`, `computer vision`, `document AI` and `image recognition` across `docs/**`
returns **zero** capability nodes — including in EA v2.1's AI Platform tree — and `BC-27`'s charter (BC Map L136)
lists *"prompts, agents, RAG retrieval, memory, guardrails, PII redaction, human-in-the-loop, model routing"*
with **no vision function**. `ATT-GAP-011` is therefore **narrowed, not closed**: the edge question is answered,
the ownership question is not.

### 16.3 Biometric boundary — the eight dimensions

| Dimension | Verdict | One-line basis |
|---|---|---|
| Ownership | ❌ OPEN | No context claims biometrics; Authentication PRD L968 **excludes** biometric login outright |
| Processing | ⚠️ Direction only | `F-1`/`F-3` fix *how*; no capability exists to say *who* |
| Enrollment | ❌ OPEN | No owner, no storage path; `ID-6`'s guardian-consent gate was not written for biometrics |
| Liveness | ❌ OPEN | Only `liveness` hits repo-wide are infrastructure health probes (EA L1984) |
| **Storage** | ✅ **RESOLVED — negatively** | `E-22` excludes `BC-03` (BC Map L331); L292 makes the edge non-existent. **`BC-03` cannot store a template at all** |
| **Privacy / PII** | ✅ **RESOLVED — binding** | `MP-GBR-32` + `F-4` already constrain any future design. A handling constraint is **not** a licence to collect |
| Retention / deletion | ❌ OPEN — **and worse than a void** | `ID-5`/`MP-GBR-04` promise erasure by **pseudonymisation**, structurally inapplicable to data that *is* the identifier |
| Device boundary | ❌ OPEN | `BC-18` owns `Device` for *auth*; `BC-08` owns physical devices but is **V2**. No V1 context can own a V1 scanner |

> **The retention row is the strongest result in the re-audit, and it makes the PRD more restrictive.**
> `ATT-FR-064`'s outright build block was previously justified by the *absence* of a rule. It is now justified by
> the *presence* of one it conflicts with. That is a worse position for the feature and a better one for the
> document.

### 16.4 Gap ledger summary

| Status | Count | Gaps |
|---|---|---|
| ✅ **RESOLVED** | **2** | `ATT-GAP-002` (frozen `PRD-007` pattern) · storage sub-question of `ATT-GAP-012` (settled negatively) |
| 🟡 **NARROWED** | **1** | `ATT-GAP-011` (direction refuted; ownership open) |
| 🔺 **UPGRADED in severity** | **2** | `ATT-GAP-004` (no path in *either* direction) · `ATT-GAP-014` (a conflict, not a void) |
| 🔴 **OPEN** | **18** | All others, each naming the owner who must decide |

**The verdict did not improve, and that is the correct outcome.** Two gaps closed; two got worse. A re-audit that
resolved most of its own open questions would almost certainly have re-labelled them rather than answered them.

### 16.5 `ATT-GAP-001` — re-verified, escalated, and NOT resolved

Re-checked against primary sources with **`PRD_REGISTRY.md` left byte-for-byte unmodified**:

| Source | Line | Says |
|---|---|---|
| `PRD_REGISTRY.md` | 236 | `PRD-006` · Attendance Management · `BC-03` |
| `PRD_REGISTRY.md` | 238 | `PRD-008` · **Revenue & Finance** · `BC-05` |
| `PRD-007` **FROZEN** | 223 | *"`BC-03` Attendance (**`PRD-006`**, PLANNED)"* |
| `PRD-007` **FROZEN** | 862 | *"…**`PRD-006`** is its PRD."* |

Three authorities — one of them a **frozen Rank 3 document, twice** — call this `PRD-006`, and `PRD-008` is
already allocated. §8 rule 5 (*"fix this register"*) does **not** rescue the instructed number: the disagreement
is not registry-vs-PRD but registry **and a frozen PRD** vs a draft, and acting on it would require modifying the
registry, which both rule 1 and the re-audit instruction forbid. **The document keeps the instructed filename and
header while recording that the evidence points elsewhere, and `ATT-GAP-001` now explicitly blocks any Stage 7
freeze.**

### 16.6 Preservation — verified mechanically, not asserted

| Guarantee | Check | Result |
|---|---|---|
| Six V1 modes, exactly | `ATTENDANCE_MODE_*` distinct constants | **6** ✅ |
| RFID not a V1 mode | `ATTENDANCE_MODE_RFID` occurrences | **0** ✅ |
| Manual §13A buildable | *"13A individual manual entry is **unaffected**"* present | ✅ |
| OCR failure → staff verification | `ATT-INV-009` ×4, `NEEDS_MANUAL_VERIFICATION` ×10 | ✅ |
| Face build block | `ATT-FR-064` present | ✅ |
| OCR build block | `ATT-FR-080` present | ✅ |
| No seventh mode / no generic verification layer | `ATT-XC-010`, `ATT-XC-011` | ✅ |
| Four events, exactly | `attendance.*` distinct names | **4** ✅ |
| All ten registers contiguous | range scan | **10/10** ✅ |
| Obligation coverage | `ATT-AC` *Verifies* parse | **279/279 = 100.0%** ✅ |
| External identifiers exist | 28 newly-cited tokens grepped outside this module | **28/28** ✅ |
| `PRD-007` byte-identical | SHA-256 | `c8760a46…4b7c6` ✅ |
| Protected paths untouched | `git diff` across all authoritative paths | **empty** ✅ |

> **One scanner result that needs explaining rather than fixing.** A range scan across *both* files reports three
> out-of-range tokens — `ATT-FR-149`, `ATT-BR-043` and `ATT-XC-023`. **All three are in this report, none is in
> the PRD**, and all three sit in §3's reconciliation table (`R-1`, `R-2`), whose entire purpose is to record
> *which identifiers were deleted or renumbered* in v1.0. Removing them would delete the evidence that the
> reconciliation happened. **The PRD itself scans clean at zero dangling references**, which is the figure that
> matters, and the two are reported separately here rather than blended into one flattering number.

### 16.7 What is still FAILING, and what a freeze would still require

The single product **FAIL** from v1.0 is **unchanged**: seven configurables (`ATT-CFG-005`, `006`, `011`, `012`,
`014`, `019`, `023`) have no default, and `LIB-16.2` (Rank 3) requires that *"every setting **MUST** have a
documented default."* The re-audit found no source supplying them, and **did not invent seven numbers to turn the
FAIL green.**

Before Stage 7 freeze, at minimum: `ATT-GAP-001` (numbering — a hard blocker), `ATT-GAP-017` (the `LIB-16.2`
breach), and the Face cluster `ATT-GAP-012`/`013`/`014`/`015` must be decided by their named owners. **None of
them is a product decision this document may make.**

---

## 15. Change log

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-08-04 | **Re-audit of `PRD-008` v1.1. Verdict CONDITIONAL PASS — deliberately unchanged.** §16 added. Gap register re-tested against authoritative sources: **2 resolved, 1 narrowed, 18 open, 2 upgraded in severity.** `ATT-GAP-002` closed on frozen `PRD-007`'s ratified pattern of consuming `BC-18` without an `E-` edge. The PRD's own request for a `BC-03` → `BC-27` edge was **refuted** — BC Map §7.4 `F-1`/`F-3`/`F-4` and `MP-GBR-29`…`32` make that direction forbidden, so `ATT-XC-005` was strengthened and §13C's staff verification was identified as already being `F-4`'s mandatory Human-in-the-Loop approval record. Biometrics audited across eight dimensions: storage **resolved negatively** (`BC-03` has no `E-22` path, so it cannot hold a template at all) and PII constraints confirmed binding, while ownership, enrollment, liveness, retention and device boundary remain open. `ATT-GAP-004` and `ATT-GAP-014` were **upgraded in severity** — the first because `E-14` and BC Map §6 rule 2 leave fraud escalation with no authorised path in either direction, the second because `ID-5`'s pseudonymisation guarantee is structurally inapplicable to a biometric template, converting a void into a conflict and hardening `ATT-FR-064`. `ATT-GAP-001` re-verified against primary sources with **`PRD_REGISTRY.md` unmodified** and escalated to a freeze blocker. Preservation verified mechanically: 6 modes, 0 RFID, 4 events, 10/10 registers contiguous, 279/279 coverage, 28/28 new external identifiers confirmed, `PRD-007` byte-identical, protected-path diff empty. The seven-configurable `LIB-16.2` **FAIL is unchanged and was not papered over.** No authoritative document modified; no ADR, schema, API, task or code created; **`PRD-008` is NOT frozen.** |
| **v1.0** | 2026-08-04 | Initial verification of `PRD-008` v1.0 DRAFT. **Verdict CONDITIONAL PASS.** Ten registers verified contiguous and collision-free (506 identifiers, 0 dangling references, 71 external identifiers all confirmed to exist); obligation coverage **measured at 100.0% (279/279)** after the audit found the draft's published 100% was false at **137/279 = 49.1%**, with 142 obligations unverified and the entire `ATT-PO` register at zero — corrected by **writing the 91 missing criteria (`ATT-AC-119`…`ATT-AC-209`)**, not by lowering the claim, on the `TR-2` precedent from `PRD-005`. Seven internal reconciliations applied, none requiring an external decision: ten out-of-range placeholder identifiers deleted, `ATT-XC-023` renumbered `ATT-XC-021` and added to the §29 register, the §0.3 total corrected from an arithmetically impossible 296 to 506, and the 18-numbers/21-rows gap convention declared up front. **Zero invented edges, events, roles or defaults.** Twenty-one gap rows recorded OPEN across 18 numbers, including `ATT-GAP-001` (the registry allocates `PRD-006` to Attendance and `PRD-008` to Revenue & Finance) and `ATT-GAP-012`/`014` (which block the Face mode entirely). One product FAIL disclosed: seven configurables lack the default `LIB-16.2` requires. `PRD-007` verified byte-identical; no authoritative document modified; no ADR, schema, API spec, migration, task list or code created. **`PRD-008` is NOT frozen.** |
