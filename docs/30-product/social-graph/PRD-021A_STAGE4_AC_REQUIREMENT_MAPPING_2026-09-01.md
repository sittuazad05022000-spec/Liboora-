# `PRD-021A` A1–A8 — Stage 4 Check-4 Repair and Complete Six-Check Rerun

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` **L108–119**) |
| **Subject** | `PRD-021A` parts **A1–A8**, treated as one multi-part PRD, evaluated **individually** |
| **Repaired check** | **Check 4** — *"Every acceptance criterion maps to a requirement"* (**L115**); failure mode *"Orphan criterion"* |
| **Predecessor record** | `PRD-021A_STAGE4_REQUIREMENTS_REVIEW_2026-08-31.md` (585 L, v1.1, committed `35d1f76`) — ⛔ **NOT overwritten.** Its conclusion (**211 of 232** ACs orphaned) stands as the historical measurement of that date |
| **Convention followed** | `PRD-020_TRUST_AND_SAFETY.md` **§27** — inline parenthetical citation appended to the criterion cell. Method: `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §1.1 / §1.2 / §6 |
| **⚠ This record edited its subject** | **Yes** — **206** acceptance-criterion rows gained a requirement citation across all eight parts. Precedent: `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` **L11**, itself citing `PRD-017_STAGE4_REQUIREMENTS_REVIEW.md` |
| **Line-count impact** | ⭐ **ZERO.** All eight parts unchanged in length (11 617 lines total). The edit is **206 pure in-place line rewrites**, so every `**L…**` citation in the repository and every line-count assertion in `PRD_REGISTRY.md` and both Stage-3 records **remains valid**. No registry edit was required |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6 **L278**). ⚠ **No named holder exists** — `PGA-08` |
| **Authority claimed** | ⛔ **Mechanical citation only.** No requirement invented · no identifier minted · no requirement text altered · no product behaviour changed. See §4 |
| **Mandate** | **Stage 4 only.** ⛔ No ADR created · no Rank 1–5 document touched · no registry/baseline/matrix update · no Stage-3 record edited · no Stage 5 · no Stage 6 · no freeze · no code · no push |
| **Date** | 2026-09-01 |
| **Verdict** | ⚠️ **STAGE-4 EVIDENCE PASS — FORMAL CONFERRAL PENDING.** Check 4 repaired: **233 of 233** ACs now cite a defined normative requirement, **0 orphans**. All six checks measured across A1–A8: **C1 PASS ×8 · C2 6 PASS + 1 N/A + 1 FINDING · C3 N/A ×8 · C4 PASS ×8 · C5 PASS ×8 · C6 PASS ×8.** **1 residual check-2 finding** (`LCM-XC-034`), **1 partially-grounded AC** (`LCM-AC-036`), **4 pre-existing repository defects** disclosed, **2 new instrument defects** disclosed. ⛔ **NOT CONFERRED** — §11 |

> ⛔ **This record does not make Stage 4 pass by interpretation.**
> The original blocker was real: 211 acceptance criteria cited no requirement. It was closed by
> *finding* the requirement that each criterion already tested and *citing* it — not by writing
> new requirements, not by weakening criteria, and not by redefining what counts as a
> requirement. Where no requirement exists, this record says so and routes the item to an
> owner (§6). `PRD-008_STAGE4_CONFERRAL.md` §4: *"the most corrupting way to pass a
> requirements review is to write the missing requirement."*

---

## 1. Method

Four steps, per `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §1.1.

1. **Extract every acceptance criterion** from all eight parts. The AC tables use **three
   distinct physical shapes** — 2-column and 3-column pipe tables (A1 §17, A1 §38.9, A2, A3,
   A4), leading-and-trailing-pipe 4-column tables (A6, A7), and **hard-wrapped multi-line
   prose** (A5, A8). A single-shape extractor silently loses the wrapped blocks; the extractor
   used here handles all three and was reconciled against a per-part identifier census.
2. **Build a requirement pool from normative registers only.** Included:
   `FR · BR · INV · XC · NFR · SEC · AUTH · API · EVT · RM · SIG · CFG · EC · FS · OBS · DEP`.
   ⛔ Excluded: `DEC` (a decision), `GAP` (a disclosed hole), `ADR` (a ruling), `RSK` (a risk),
   and A8's `CONF` **conflict** register. None of these is a normative requirement, so none may
   satisfy L115.
3. **Match only where a requirement states the same obligation in normative language.**
   ⭐ **Thematic adjacency was not accepted as a match.** Semantic equivalence was required, not
   similar wording.
4. **Verify every citation added is a *defined* identifier**, not merely one referenced
   somewhere in prose.

### 1.1 What this record did NOT do

| Not done | Why |
|---|---|
| Invent a requirement to absorb an orphan | A fabricated register entry is worse than a disclosed gap |
| Map a goal, decision, gap, ADR, risk, section, step, edge or authority statement to an AC | L115 requires an actual **normative requirement** |
| Renumber, reuse or create any identifier | The registers are append-only and owner-held |
| Alter any requirement's text | **Only criterion rows were touched** |
| Downgrade, reword or delete an acceptance criterion to reduce the count | The count is evidence, not a target |
| Change a `GAP-*` status | *A gap's status is an owner's act* |
| Modify the matrix, registry, baseline, any ADR, or any Rank 1–5 document | Out of mandate |
| Edit either Stage-3 alignment record | Stage-3 decisions are conferred and closed |
| Overwrite the 2026-08-31 Stage-4 record | Dated reruns are the repository's precedent |

---

## 2. Subject hashes — before and after

The predecessor record's header states its subject hashes were *"byte-unchanged **by this
review**"*. ⭐ **That statement was and remains true of its own scope** — the 2026-08-31 review
measured only. The bytes changed under **this** record, which is why this record publishes both
values. The predecessor's hash table (its **L57–64**) is therefore the **BEFORE** column here.

| Part | sha256 BEFORE (16) | sha256 AFTER (16) | Lines before | Lines after | Δ |
|---|---|---|---|---|---|
| A1 | `bbd3f3945ecc947c` | `f5347b0480687c11` | 1532 | 1532 | **0** |
| A2 | `a81759234ce7a4c8` | `1aca384098a72574` | 1959 | 1959 | **0** |
| A3 | `ecbccedcdde3cf01` | `fd1a4ca0653f6a04` | 1330 | 1330 | **0** |
| A4 | `ce37c794e345a733` | `95af7e30a58cbc37` | 766 | 766 | **0** |
| A5 | `32c09960753476c4` | `da2830c6dc445045` | 1964 | 1964 | **0** |
| A6 | `abf9c88b59de90c7` | `b5e16450476fd3e5` | 1188 | 1188 | **0** |
| A7 | `82b37001d344028d` | `01097dc13691bbfc` | 953 | 953 | **0** |
| A8 | `7712e933235ff373` | `cf5670ad89c039e5` | 1925 | 1925 | **0** |
| | | | **11 617** | **11 617** | **0** |

Full-length AFTER values:

```
A1  f5347b0480687c11517cb2e924e45430c5810f58fe123ca55a15f9410a914aab
A2  1aca384098a7257449dc487a424d876515d9366ab85c6c74bc49621b980d685d
A3  fd1a4ca0653f6a0402040aafe4e47594974380d4dec60a1651be7a70a666cffc
A4  95af7e30a58cbc37a65f00c86a902ec61fbedce0691b9c70c6e84d7794746f24
A5  da2830c6dc44504581f3961ea8b7ad50302239202aed1815288d0ff790c0fdf8
A6  b5e16450476fd3e535822fe01d917b5c582f0237004685c1b6d83f1b52c0d917
A7  01097dc13691bbfcf647de802e7fbd22760d4e3cdcf942b2f4e44a923d46146d
A8  cf5670ad89c039e54d6be1ec0c31d93f66ae8492a030275ef01c8d6723dc8585
```

### 2.1 Why the zero line delta matters

Measurement **before** writing established that three documents assert the subjects' line
counts **as facts** — `PRD_REGISTRY.md` **L768** (A6 1 188), **L769** (A7 953), **L770**
(A8 1 925); `PRD-021A_STAGE3_ALIGNMENT_2026-08-31.md` L44/L47/L57/L464; and
`PRD-021A_STAGE3_ALIGNMENT_A4_A6_RESOLUTION_2026-08-31.md` L40/L43/L46/L175 — and that
roughly 204 line-citations elsewhere point into the registry. Both Stage-3 records are
**closed and unamendable**.

Any repair that inserted lines would have invalidated those assertions and forced edits to a
registry and to two conferred Stage-3 records. The repair was therefore designed as **in-place
rewrites of existing lines only**. Consequence: **no registry edit, no Stage-3 edit, no
citation drift anywhere in the repository.**

---

## 3. The mapping convention — found, not invented

`PRD-020_TRUST_AND_SAFETY.md` §27 is the repository's established `Acceptance Criterion →
Requirement` syntax. It is an **inline parenthetical appended at the end of the criterion
cell**, with the table header left as `| ID | Given / When / Then |`. ⭐ **No mapping column is
added.** Multiple requirements are comma-separated inside one parenthesis. Verbatim, from
`PRD-020` L2178 / L2184 / L2186:

```
| `TSF-AC-001` | **Given** a signed-in student viewing a person's profile, **when** they
report it, **then** a case is created and an acknowledgement is shown
(`TSF-FR-044`, `TSF-FR-045`, `TSF-FR-046`) |

| `TSF-AC-009` | **Given** any report, **when** it is stored, **then** the reporter's identity
is absent from `TSF-EVT-001` (`TSF-EVT-001`, `TSF-INV-009`) |
```

⚠ **A "Requirement" or "RQ" column would have been a NEW convention.** An established one
exists, so it was used. The 206 edits reproduce this form exactly, matching each part's local
emphasis style (plain `(…)` in A1–A5, italic `*(…)*` where A8's surrounding rows already use it).

---

## 4. Requirement authority — what was safe and what was not

| Class | Count | Action taken |
|---|---|---|
| **SAFE** — AC tests a behaviour an **existing** requirement already specifies | **232** | Citation added mechanically |
| **PART-SAFE** — AC tests two obligations; one is specified, one is not | **1** (`LCM-AC-036`) | Supported half cited; unsupported half routed to the Product Owner (§6) |
| **NOT SAFE** — AC would require a requirement to be invented | **0** | — |

Because zero criteria required an invented requirement, no criterion was left uncited and no
requirement was fabricated. The single partially-grounded criterion is disclosed rather than
papered over.

---

## 5. Phase 10 — complete six-check rerun, A1–A8

All six L112–L117 checks were re-run against every part, not check 4 alone. Verdicts below are
**adjudicated** — every heuristic failure was read against the actual document text before being
recorded, and the instrument was corrected where it was wrong (§8).

| Part | C1 testable | C2 exclusions | C3 configurables | C4 AC→RQ | C5 no restatement | C6 vs Rank 1 |
|---|---|---|---|---|---|---|
| **A1** | ✅ PASS 190/190 | ⚠️ **FINDING** 29/34 | ➖ N/A declares 0 | ✅ PASS 60/60 | ✅ PASS | ✅ PASS |
| **A2** | ✅ PASS 170/170 | ✅ PASS 29/29 | ➖ N/A declares 0 | ✅ PASS 36/36 | ✅ PASS | ✅ PASS |
| **A3** | ✅ PASS 124/124 | ✅ PASS 16/16 | ➖ N/A declares 0 | ✅ PASS 22/22 | ✅ PASS | ✅ PASS |
| **A4** | ✅ PASS 44/44 | ✅ PASS 16/16 | ➖ N/A declares 0 | ✅ PASS 18/18 | ✅ PASS | ✅ PASS |
| **A5** | ✅ PASS 180/180 | ✅ PASS 27/27 | ➖ N/A declares 0 | ✅ PASS 21/21 | ✅ PASS | ✅ PASS |
| **A6** | ✅ PASS 78/78 | ✅ PASS 6/6 (`NG-*`) | ➖ N/A declares 0 | ✅ PASS 20/20 | ✅ PASS | ✅ PASS |
| **A7** | ✅ PASS 74/74 | ➖ **N/A — no register** | ➖ N/A declares 0 | ✅ PASS 21/21 | ✅ PASS | ✅ PASS |
| **A8** | ✅ PASS 131/131 | ✅ PASS 12/12 | ➖ N/A declares 0 | ✅ PASS 35/35 | ✅ PASS | ✅ PASS |
| **Total** | **991 / 991** | **151 rows; 5 flagged** | **0 configurables** | **233 / 233** | **0 restatements** | **0 contradictions** |

### 5.1 Check 1 — every requirement testable (L112)

Measured to the standard set by `PRD-016_STAGE4_REQUIREMENTS_REVIEW.md` §2 (**L40–72**), which
scopes the check to *"every **obligation-bearing** requirement"* and tests for an
RFC-2119 modal, then scans for unverifiable language.

- **Population: 991 obligation-bearing requirement rows.** ⭐ **236 further rows are outside the
  population** and were excluded with cause, not silently: A2 `LCF-FR-001`…`004` sit under
  `## 2. Problem Statement`; `LCF-FR-006`…`015` under `## 3. Goals`; A1 `LCM-FR-052`…`060`
  under `### 37.1 In V1` whose header is `ID | Included`; A2 `LCF-API-001`…`010` are an
  availability inventory (`✅ Yes` / `⛔ NOT PROVIDED`). These are enumerations and scope
  statements, not obligations.
- **Rows lacking a normative verb: 0.** The modal set is the full RFC-2119 range —
  `MUST · MUST NOT · SHALL · SHALL NOT · SHOULD · SHOULD NOT · MAY`. A1 `LCM-FR-012` uses
  **SHOULD** and `LCM-FR-013` uses **MAY**; both are legitimate.
- **Unverifiable constructions: 0**, across the ten searched for, including the lifecycle's own
  example *"should be fast"*, plus *as needed · appropriate · reasonable · efficient ·
  user-friendly · robust · as soon as possible · etc. · and so on*.
- **36 universal negatives** (e.g. `LCM-INV-001` *"A1 holds no persisted state"*,
  `LCM-INV-005` *"A1 emits no event"*) were read individually. Per `PRD-016` §2.3, an assertion
  of **absence** is testable when the draft supplies an **observation point**. Each does.
  ⭐ These are the hardest rows to test and were therefore not accepted mechanically.

### 5.2 Check 2 — every exclusion states what must be impossible (L113)

Measured to `PRD-016` §3, which tests **two** dimensions: a prohibition/impossibility clause,
and a **non-empty owner cell** — because the lifecycle's failure mode is *"an exclusion that
defers rather than excludes"*.

⭐ **The prohibition lives in the table header, not in each row.** A1 §19's header is
`ID | Excluded from A1 | Held instead by`, which asserts exclusion for all 24 rows beneath it.
For A4 §2.2 and A5 §2.4 there is **no table at all** — they are prose registers, and the
assertion is carried by the **section heading** (`### 2.2 Explicitly NOT in scope — with the
owner who holds it`; `### 2.4 Non-goals`). Testing rows in isolation produced over 100 false
failures; see `I-12` in §8.

Register shapes differ materially per part and were enumerated rather than assumed:

| Part | Register | Rows | Governing form |
|---|---|---|---|
| A1 | `XC-*` | 34 | §19 table ×24 · §19 prose ×3 · §31 `ID \| Rule \| Authority` ×2 · **§37.2 `ID \| Deferred` ×5** |
| A2 | `XC-*` | 29 | §4 `\| ID \| Excluded \| Owner / authority \|` ×24 + prose ×5 |
| A3 | `XC-*` | 16 | §4 `ID \| Excluded \| Owner / reason` |
| A4 | `XC-*` | 16 | **prose** under `### 2.2 Explicitly NOT in scope — with the owner who holds it` |
| A5 | `XC-*` | 27 | **prose** under `### 2.4 Non-goals` |
| A6 | `NG-*` | 6 | §4 `\| ID \| Non-goal \|`, holders in `LCS-OWN-001`…`006` + §6 |
| A7 | — | **0** | ⚠ **A7 has no exclusion register of any kind — check 2 is N/A, not PASS** |
| A8 | `XC-*` + `NG-*` | 2 + 10 | §0.3 `\| Prohibited \| A8 introduces it? \| Independent EA position \|` · §4 `\| ID \| Non-goal \| Why \|` |

- **Dimension (b) — holder named: 100 % on every part.** Zero empty owner cells anywhere.
- **A8's 10 `LCT-NG-*` rows were measured on their own** rather than being skipped because A8
  also has an `XC` register: all 10 sit under `## 4. Non-Goals` with a populated *Why* column
  naming the holder (`BC-13`/`PRD-020`, `BC-22`, A3 §12.1, EA Rank 6, Platform Engineering).
  **PASS.**
- ⚠️ **One genuine finding: A1 §37.2, `LCM-XC-030`…`034` (L1189–1193)** sit under a column
  headed literally **`Deferred`** — exactly what L113 forbids. The column header is decisive and
  overrides the permissive section heading *"Not in V1"*. Materiality was then tested row by row:

```
LCM-XC-030  <- restates §19 XC-002 L720 / XC-003 L721 / XC-004 L722 / XC-005 L723 / XC-006 L724
LCM-XC-031  <- restates §19 XC-007 L725
LCM-XC-032  <- restates §19 XC-026 L744
LCM-XC-033  <- restates §19 XC-022 L740
LCM-XC-034  <- NO §19 COUNTERPART — exclusion asserted only under the "Deferred" header
```

  ⭐ **4 of the 5 are restatements of §19 rows that DO state exclusion with a named holder.**
  Only **`LCM-XC-034`** (integration-level fault-injection verification, pending
  `LCM-GAP-005`) is a bare deferral. It is routed to an owner in §6, not repaired here —
  converting a deferral into an exclusion is a scope act.

### 5.3 Check 3 — every configurable has a default and a range (L114)

➖ **N/A ×8 — no part declares a configurable.** This is stated by the parts themselves, not
inferred: A1 `LCM-INV-017` (**L1007**) — *"A1 declares no `LCFG-*` identifier. The register
remains `LCFG-1` … `LCFG-13`."* A2 declines three times (**L765**, **L1383** *"this part mints
no `LCF-CFG-*`"*, **L1519**). A3–A8 have **no `CFG` register at all**.

⚠ A1 is the only part with a `CFG` register (14 rows), and it holds **rules about a reused
parameter**, `LCFG-5`, which A1 does not own. A1 nonetheless states that parameter's default and
range where it constrains it: **L457** `LCM-CFG-002` — default **Disabled**, owner **Security**,
*"No parameter is created"*; **L1001** `LCM-CFG-010`; **L1003** `LCM-CFG-012` — indeterminate
values treated as Disabled; **L1045** `LCM-API-022` — when Disabled the surface behaves as if it
does not exist. Range is the binary Enabled/Disabled. **No specification hole exists.**

⚠ `LCT-CONF-001`/`002` is A8's **conflict** register and was excluded from this check.

### 5.4 Check 4 — every acceptance criterion maps to a requirement (L115)

✅ **PASS ×8. 233 of 233 criteria cite at least one defined normative requirement. 0 orphans**
(was 211 orphaned). Per-part: A1 60/60 · A2 36/36 · A3 22/22 · A4 18/18 · A5 21/21 ·
A6 20/20 · A7 21/21 · A8 35/35.

### 5.5 Check 5 — no requirement restates another PRD's (L116)

✅ **PASS ×8.** Eight rows were flagged by a single-line heuristic and **all eight were false
positives** once the full hard-wrapped block was read. Each states an obligation on `BC-15`'s
**own** side while naming the foreign requirement as the authority it defers to — consumption,
not restatement. Examples: A6 `LCS-FR-033` *"A person restricted by `TSF-EVT-002` … **SHALL** be
prevented from posting … by `BC-15` self-restriction (§9)"*; A8 `LCT-SEC-010` *"…SHALL be
`BC-11`'s … ⛔ A8 mints no limit value"*; A7 `LCN-FR-025` *"…never as a re-broadcast of
`TSF-EVT-002`"*. **No second source of truth is created.**

### 5.6 Check 6 — business rules do not contradict Rank 1 (L117)

✅ **PASS ×8.** Rank 1 is `MASTER_PRD.md`'s `MP-GBR-*` / `MP-CON-*` / `MP-DEP-*`
(`DOCUMENTATION_BASELINE.md` §4, **L233–262**).

Two rows were flagged for the token *override*; **both are prohibitive uses that *enforce*
Rank 1**:

```
A3 LCR-BR-012  L744  "...SHALL never override authorisation, privacy, block or community isolation."
A5 LCO-INV-020 L1078 "Priority SHALL NOT override authorisation, visibility, block enforcement
                      or community isolation."
```

⭐ Additionally measured: **no `BR` or `INV` row in any part cites a Rank 1 `MP-*` identifier**
(0/8 parts), while the parts do cite Rank 1 elsewhere — A1/A4 `MP-SCOPE-04`; A2/A3/A6
`MP-CON-08` + `MP-SCOPE-04`; A8 `MP-GBR-26`; A5 and A7 none. No business rule asserts anything
against a Rank 1 rule.

### 5.7 AC count reconciliation

The mandated figures were A1=60, A2=36, A3=22, A4=18, A5=21, A6=20, A7=21, **A8=34**,
**TOTAL=232**. Measured: identical for A1–A7, and **A8=35**, **TOTAL=233**.

⭐ **The difference is a measurement correction, not a change to the drafts.** A8 defines
`LCT-AC-001`…**`035`**. `LCT-AC-035` sits at **L1745–1747** behind a `⚠ **` wrapper that
defeats a backtick-then-pipe anchor:

```
⚠ **`LCT-AC-035`** | **Given** A4 remains a CANDIDATE, **when** role-gated post types are
sought, **then** the capability is absent — **this criterion asserts absence and is expected
to remain asserted until A4 is resolved.**
```

The mandated 34 covers `LCT-AC-001`…`034` only. **The true grand total is 233.** No criterion
was added, removed, renumbered or reworded to reach it. Disclosed as defect **`I-8`** (§8).

---

## 6. Product Owner decision package

⛔ **These items are NOT repaired here.** Each would require creating a requirement, changing
scope, or exercising an owner's judgement. `PRD_LIFECYCLE.md` **L119** requires a **reason and
an owner** — both are given.

| Item | Why no requirement exists | Owner | Required decision |
|---|---|---|---|
| **`LCM-AC-036`** (partially grounded) | The criterion tests two obligations. `LCM-AUTH-007` requires each role's explicit treatment, and the table at A1 **L440** records TR-3 as *Interim DENY* under `AP-3`. But **no normative requirement states that the interim status must NAME the Product Owner** — that half of the criterion has no requirement behind it | **Product Owner** | Either (a) mint a requirement obliging the interim-status statement to name its holder, or (b) confirm the naming is narrative and amend the criterion. ⛔ Do not silently drop the clause |
| **`LCM-XC-034`** (check-2 finding) | The row's exclusion is asserted **only** under A1 §37.2's `Deferred` column, and it has **no §19 counterpart** that states a prohibition with a named holder. Pending `LCM-GAP-005` (integration-level fault-injection verification) | **Product Owner** (with Governance Owner on the register form) | Either (a) promote it to §19 with an explicit *what must be impossible* + holder, or (b) accept it as a **declared deferral with a reason and an owner** under L119. Converting a deferral into an exclusion is a scope act |
| **`I-7`** — `LCM-GAP-002` misattribution | A1 **L440**/**L579** cite `LCM-GAP-002` as the TR-3 Reception open item, but the gap register at **L756** defines it as *"Final architecture placement of A1 is not recorded in any register"* (owner Governance Owner). **The TR-3 question has no gap identifier at all** | **Governance Owner** | Mint a gap for the TR-3 Reception question, or correct the two citations. Pre-existing defect — disclosed, not repaired |
| **`I-8`** — A8 AC-count understatement | 35 criteria exist; 34 were counted. Cause is a wrapper on **L1745**, not a missing criterion | **Requirements reviewer** (measurement) | Accept **233** as the grand total in all downstream Stage-4 arithmetic |
| **`I-9`** — 10 A8 non-requirement citations | Ten A8 criteria already carried a citation, but to a **section, step, edge, external line or BC-Map line** — not to a normative requirement, so none satisfied L115: `AC-006` (BC Map L446), `AC-007` (A5 §19), `AC-008` (A7 §8), `AC-009` (`ID-2`; yaml L266–267), `AC-010` (§20.3), `AC-018` (§8.1 step 4), `AC-021` (§13.3), `AC-027` (BC Map L452), `AC-030` (`E-20`), `AC-032` (§19) | **Requirements reviewer** (closed) | ✅ **Already repaired** — all ten now additionally cite a genuine `LCT-*` requirement. Recorded because it is a **distinct class of check-4 failure**: the row *looks* cited but the citation is not a requirement |
| **`I-10`** — A8 extractor mis-measurement | An earlier instrument reported A8 as *"0 of 34 mapped"*; it inspected only each block's anchor line while A8's parentheticals sit on the **final continuation line** | **Requirements reviewer** (closed) | ✅ Corrected. True pre-existing state: **13 fully valid + 7 partially valid** citations. A8 was never the *"0 mapped"* part |

⭐ **No item in this table was resolved by inventing a requirement.** Two require an owner's
act; four are disclosures, two of which are already closed.

---

## 7. Phase 7 — special cases verified

| Case | Requirement | Result |
|---|---|---|
| **A1** `LCM-NFR-012` / `S4-R1` | Not to be marked resolved merely because PO-1 was answered | **L1151 still unquantified.** ⭐ This is a **check-1** concern about a target value, not a check-4 orphan. `S4-R1` **remains OPEN** |
| **A1** `LCM-AC-041` / `S4-R4` | Wording preserved | ✅ **L671** unchanged; `S4-R4` remains open |
| **A1** `LCM-GWT-020` / `S4-R5` | Intact | ✅ **L1247** unchanged |
| **A1** ADR safety | — | ✅ `LCM-FR-051` **L778**: *"No ACCEPTED ADR is amended, superseded, weakened or re-scoped by this document."* |
| **A4** `LCG-AC-015` / `LCG-AC-016` | Verify against closed `OWNER > MODERATOR > MEMBER`, `PUBLIC`/`PRIVATE`, ownerless rule | ✅ `LCG-AC-015` → `LCG-FR-016`; `LCG-AC-016` → `LCG-FR-015`. Both consistent with the closed model |
| **A4** stale `LCG-DEC-003` refs | Verify | ✅ **L208** and **L663** both read ✅ **CLOSED — 2026-08-31 (PO-4)**. No stale reference remains |
| **A6** best-mapped part | Preserve correct mappings; do not weaken `LCS-FR-030` | ✅ 3 pre-existing correct mappings preserved untouched; **`LCS-FR-030` L659 byte-unchanged** |
| **A7** event contract | `CommentPublished` · `ReactionChanged` present; 4 withdrawn retained and never reused | ✅ `LCN-EVT-001` `community.PostPublished`; `EVT-002` `community.CommentPublished`; `EVT-003` `community.ReactionChanged`; `EVT-004`…`007` ⛔ **WITHDRAWN**, retained, not reused. `grep -c WITHDRAWN` = 10 |
| **A8** resolved A2/A7 contract | Must not restore stale *"OPEN OWNER DECISION"* wording | ✅ Occurrences **11 before → 11 after**. No stale wording restored. `LCT-AC-032` byte-unchanged (AO-9) |

---

## 8. Instrument defects disclosed

Two defects **in this record's own measurement tooling** were found and corrected. Both are
disclosed because an undisclosed instrument defect is indistinguishable from a false finding.

| ID | Defect | Consequence if undisclosed |
|---|---|---|
| **`I-11`** | **Block terminator.** The register-block extractor treated any line starting with a backticked identifier as a new block. A8 **L1613** is a *continuation* line closing `LCT-AC-004`'s citation and reads `` `LCS-FR-019`)* `` — no delimiter follows the identifier. It was misread as a new block, **truncating 11 A8 criteria** and producing a false check-4 result of **24/35**. Corrected by requiring a trailing delimiter (`\|`, em-dash, `-`, `:`) after the identifier | This window would have reported a **false check-4 FAILURE on A8**. Caught only by cross-checking against the independently verified 35/35 |
| **`I-12`** | **Exclusion-header detection**, two faults. (a) The token `exclud` cannot match the word *"Exclusion**s**"* (E-x-c-l-u-s), leaving A3 §4's header unclassified. (b) A4 §2.2 and A5 §2.4 are **prose registers with no table header**, so the assertion is carried by the section heading; a header-only walk found nothing and flagged 32 rows | Together these produced **over 100 false check-2 failures** across A1–A5 |

Neither defect altered a single subject byte. Both are recorded in `/tmp/s4/defects.tsv`
alongside `I-7`…`I-10`.

⭐ **Discipline applied throughout:** every heuristic failure was read against the document text
before being recorded. Of the ~200 raw flags produced across six checks, **exactly one**
survived adjudication as a genuine finding (`LCM-XC-034`). The rest were instrument artefacts —
an omitted modal set, a wrong population, mis-classified universal negatives, a trailing-pipe
cell-index bug, a misread `CFG` register, and the two defects above.

---

## 9. Verification — executed, not asserted

Replicating `PRD-020_STAGE4_AC_REQUIREMENT_MAPPING.md` §6. Every row below was **measured by
re-reading the live files**, not carried forward from the planning stage.

| # | Verification | Result |
|---|---|---|
| 1 | AC rows in scope | **233** (A1 60 · A2 36 · A3 22 · A4 18 · A5 21 · A6 20 · A7 21 · A8 35) |
| 2 | AC rows citing ≥ 1 normative requirement | **233** |
| 3 | AC rows marked `UNMAPPED` | **0** |
| 4 | AC rows silently uncited | **0** |
| 5 | Distinct requirements cited | **286** (333 citation occurrences) |
| 6 | Cited identifiers that are **undefined** *(must be 0)* | **0** |
| 7 | New identifiers minted *(must be 0)* | **0** |
| 8 | Requirement register text altered *(must be None)* | **None** — 0 non-AC lines changed in any part |
| 9 | Rank 1–5 / matrix / registry / baseline / ADRs byte-unchanged | ✅ **Verified** — see §10 |

Additional integrity measures:

- **Pure-insertion proof:** a difflib audit of all eight before/after pairs reports **206 changed
  lines, 0 violations** — every change is an append inside an existing criterion cell.
- **Citation class:** by register — `FR` 173, `INV` 34, `SEC` 30, `RM` 9, `BR` 8, `CFG` 8,
  `AUTH` 7, `API` 4, `NFR` 3, `SIG` 3, `FS` 3, `XC` 3, `EVT` 1.
  ⭐ **Citations to `DEC` / `GAP` / `ADR` / `RSK`: 0.**
- **Cross-PRD citations: 10**, all resolving **inside `PRD-021A`** except one deliberate
  `TSF-EVT-001` reference in A7. Five criteria are grounded only in a sibling part
  (`LCT-AC-002`/`003`/`004`/`008`/`028`) — all within the same multi-part PRD.
- **Newly cited identifiers: 257 distinct**, of which **0 lie outside `PRD-021A`**.

---

## 10. Phase 12 — safety audit

| Invariant | Expected | Measured | Result |
|---|---|---|---|
| `git status --porcelain` | empty | empty | ✅ |
| `docs_check` suite | 28 checkers / 6 baseline failures | `CHECKERS=28 TOTAL_NONZERO=6` — `alignment_record_freshness prd004_traceability prd005_traceability prd006_traceability prd007_traceability prd020_stage5` | ✅ **exactly baseline, same six** |
| Module boundary checker | 9 violations / 1 category (`ADR-0012`, expires 2026-10-31) | `FAIL — 9 violation(s) in 1 category(ies)` | ✅ baseline |
| Citation integrity | 0 undefined | 286 distinct, **0 undefined** | ✅ |
| Protected hashes | unchanged | `DOCUMENTATION_BASELINE` `7e1c69f92363a5e5` · `PRD_LIFECYCLE` `5031fcc97a95980e` · `MASTER_PRD` `5c31a3363d99a5f6` · `TRACEABILITY_MATRIX` `bf16eb2de31d2994` · `LIBOORA_ENTERPRISE_ARCHITECTURE` `34761df53bfbf149` · `PRD-021A_STAGE3_ARCHITECTURE_ALIGNMENT` `eab88c9ab3be6f91` | ✅ all 6 identical |
| Stage-3 records | unchanged | `1270a7689e107c19` (529 L) · `453e781d95543d66` (344 L) | ✅ untouched |
| `ADR-0083` / `ADR-0084` | unchanged | `7fbbbcb0564589da` (356 L) · `e759172f732354cc` (348 L) | ✅ |
| ADR count | 75 | 75 files; `ADR-INDEX` L9 *"75 ADR files exist and all 75 are registered"* | ✅ |
| **Bounded-context count** | 31 | **31** | ✅ unchanged |
| **Edge count** | **28** | **28** — `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L649**: *"`E-01`…`E-26`, `E-28`, `E-29` — 28 edges, with `E-27` a deliberate gap"*; 28 defined rows | ✅ **28** |
| New `PERM-*` | 0 | 0 | ✅ |
| New bounded context / new event | 0 | 0 | ✅ |
| Stage-5 registration for `PRD-021A` | 0 | 0 | ✅ |
| `IMPL-*` in subjects | 0 | 0 before, 0 after, **delta 0** in all eight parts | ✅ |
| Files changed vs `35d1f76` | 8 subjects only | `8 files changed, 206 insertions(+), 206 deletions(-)` | ✅ no collateral file |
| Push | none | none | ✅ |

⚠ **Edge-count note:** a naïve `E-\d+` scan returns **29** distinct tokens. The map itself
resolves this at **L649** — `E-27` is a **deliberate gap**, and the defined-row count is 28. The
invariant holds; the raw token count is not the edge count.

---

## 11. Conferral boundary

⛔ **STAGE 4 IS NOT CONFERRED BY THIS RECORD.**

All six checks now read PASS or N/A across A1–A8, with one disclosed finding
(`LCM-XC-034`) and one partially-grounded criterion (`LCM-AC-036`) held with a reason and an
owner. That is **evidence**, not authority.

> **Determination: `STAGE-4 EVIDENCE PASS — FORMAL CONFERRAL PENDING`.**

- No explicit conferral authority was granted for this work, and **Stage-3 conferral does not
  imply Stage-4 authority** (`PRD-008_STAGE4_CONFERRAL.md`).
- The **Requirements reviewer** role (`PRD_LIFECYCLE.md` §6 **L278**) has **no named holder** —
  `PGA-08`. A conferral requires one.
- ⛔ **No Stage-5 registration was made.** The `PRD-021A` Stage-5 registration count is **0**
  before and after.
- The two owner-held items in §6 must be closed or explicitly deferred with a reason and an
  owner before conferral is considered under **L119**.

---

## 12. Determination

| Question | Answer |
|---|---|
| Was the Check-4 blocker real? | **Yes.** 211 of the criteria cited no requirement |
| Was it closed correctly? | **Yes** — by citing requirements that **already existed**, using the repository's own §27 convention |
| Was any requirement invented? | ⛔ **No. Zero.** |
| Was any acceptance criterion weakened, reworded or removed? | ⛔ **No.** 0 non-AC lines and 0 criterion semantics changed; only citations were appended |
| Was any identifier minted or renumbered? | ⛔ **No. Zero.** |
| Was any Stage-3 decision, Rank 1–5 document or accepted ADR touched? | ⛔ **No.** All hashes re-measured identical |
| Do genuine orphan criteria remain? | ⛔ **No — 0 orphans.** One criterion (`LCM-AC-036`) is **partially** grounded and is routed to the Product Owner rather than forced |
| Is Stage 4 conferred? | ⛔ **No.** `STAGE-4 EVIDENCE PASS — FORMAL CONFERRAL PENDING` |

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-01 | Check-4 repair executed: 206 criterion rows across A1–A8 gained an inline requirement citation under the `PRD-020` §27 convention, at **zero line-count delta**. Complete six-check rerun for A1–A8. Product Owner package for `LCM-AC-036` and `LCM-XC-034`. Instrument defects `I-11` and `I-12` disclosed. Subject BEFORE/AFTER hashes published. ⛔ Not conferred |
