# `PRD-007` Seat Management v1.0 — Independent Stage 4 Re-Review

| Field | Value |
|---|---|
| **Review** | Independent Stage 4 **re-review** — adversarial, audit-only |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, `BC-04` Seating, **v1.0 `DRAFT`** |
| **Gate** | [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–119 — six checks, re-derived from source, not inherited |
| **Prior review** | [`PRD-007_REQUIREMENTS_REVIEW.md`](PRD-007_REQUIREMENTS_REVIEW.md) — verdict **B**, findings `RQ-1`…`RQ-4`, rejected `RQ-R1`…`RQ-R6` |
| **Correction under audit** | [`PRD-007_CORRECTION_RECORD.md`](PRD-007_CORRECTION_RECORD.md) — claims `RQ-1`/`RQ-3`/`RQ-4` resolved, `RQ-2` deferred |
| **Stage 3 record** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](PRD-007_ARCHITECTURE_ALIGNMENT.md) — **ALIGNED**, 6/6 |
| **Reviewed at** | `1e2a2e3` (working tree clean) |
| **PRD hash before review** | `9c32cd4725187cb722d34a56b9fbf5ac7d1658e08f8ca309f8661018c6725c8a` |
| **PRD hash after review** | `9c32cd4725187cb722d34a56b9fbf5ac7d1658e08f8ca309f8661018c6725c8a` — **unchanged, nothing modified** |
| **Date** | 2026-08-10 |
| **Mandate** | **Audit only.** Nothing fixed, no PRD edit, no ADR, no specification, no schema, no code, no Stage 5/6/7, no freeze |
| **Verdict** | **B — MINOR CORRECTIONS** (§14). 0 CRITICAL · 0 HIGH · **1 MEDIUM** · 3 LOW. The MEDIUM is a **surviving instance of the `RQ-1` contradiction that the correction did not reach** |

---

## 0. Verdict

> ### **B — MINOR CORRECTIONS**
>
> **All six Stage 4 gate checks pass**, but gate check 3 (*every configurable has a deterministic default*) and
> gate check 6 (*business rules must not contradict*) pass **only at `SEAT-CFG-017` and `SEAT-FR-265`.**
>
> **`RQ-1` is NOT fully resolved.** The correction fixed the two sites the previous review named and missed a
> third: **`SEAT-FR-212` (L1478–1479)** still states *"Where none is configured, the module **MUST** default to
> **90%** of active seat capacity."* That is the **exact proposition** the correction was commissioned to
> eliminate, in a requirement the previous review never cited.
>
> This is not a rediscovery of a closed finding. It is a **new site** of the same defect, and it means the PRD
> currently contains two contradictory `MUST` rules about the same configurable.
>
> I am not recording **A**. The blocking severity is MEDIUM, not HIGH, because behaviour on the live V1 path is
> still determinable from three concurring statements — but a reader who reaches §22.2 first will implement the
> wrong behaviour.

---

## 1. Method

Independent. I re-derived the gate from `PRD_LIFECYCLE.md` L108–119 rather than copying the previous review's
table, wrote a **new** verifier (`.rereview/rereview.py`, untracked, not committed) rather than re-running the
previous one, and re-tested all six rejected findings from first principles.

Two of my own detector results proved wrong on inspection and are recorded as such (§11.2, §11.7). Two
measurements in the **previous** review proved method-dependent and are corrected here (§5.3, §9.1).

### 1.1 Sources consulted at source, not via the PRD's summary

`PRD_LIFECYCLE.md` L108–119 · `MASTER_PRD.md` L357, L358, L673 (Rank 1) ·
`LIBOORA_BOUNDED_CONTEXT_MAP.md` L302 (Rank 4) · `PRD-MEMBERSHIP-MANAGEMENT.md` L1351 (frozen Rank 3) ·
`PRD-005_FIFTH_INDEPENDENT_REVIEW.md` and `PRD-004_INDEPENDENT_REVIEW_REPORT.md` (format precedent).

### 1.2 Severity scheme (as `PRD-004` §19)

**CRITICAL** ships wrong behaviour · **HIGH** blocks a stage · **MEDIUM** a real defect with a determinable
workaround · **LOW** clarity/traceability · **OBSERVATION** no action required.

---

## 2. Gate-by-gate result

| # | Check (`PRD_LIFECYCLE.md` L112–117) | Result | Evidence |
|---|---|---|---|
| 1 | Every requirement testable | **PASS** | 1 vague-language hit, adjudicated as a quotation of frozen Rank 3 (§11.1). 225 ACs, 0 malformed, all deterministic Given/When/Then |
| 2 | Every exclusion states what must be **impossible** | **PASS** | 22/22 `SEAT-XC-*` carry impossibility language. 1 detector flag disproved (§11.7) |
| 3 | Every configurable has a default and a range | **PASS with `SR-1`** | 18/18 rows carry a non-empty default **and** a domain. But the threshold default is stated **twice, differently** — `SEAT-CFG-017` vs `SEAT-FR-212` |
| 4 | Every acceptance criterion maps to a requirement | **PASS** | **0 orphans / 225.** Every Verifies column cites ≥1 non-AC identifier |
| 5 | No requirement restates another PRD's | **PASS** | `E-05` payload reproduced exactly (L192 == BC Map L302); §27.2 explicitly disclaims 5 foreign values |
| 6 | Business rules do not contradict Rank 1 | **PASS** | `MP-GBR-16`/`MP-GBR-17` verified verbatim at `MASTER_PRD.md` L357–358; `Q-01` still Open and not pre-empted. **Internal** contradiction found (`SR-1`) — not a Rank 1 conflict |

**Gate (L119): "conflicts closed or explicitly deferred with a reason and an owner."**
`SR-1` is **neither closed nor deferred** — it is unrecorded. The gate is therefore **not fully satisfied**, which
is why this is **B** and not **A**.

---

## 3. `RQ-1` — verified **PARTIALLY RESOLVED**

### 3.1 What the correction did achieve

Both sites the previous review named are genuinely fixed.

`SEAT-CFG-017` (L1882) Default column now reads:

> **Unset in V1 — no event is emitted and no value is substituted** (explicit unset behaviour per `SEAT-FR-265`);
> **90%** applies only once `E-05` carries the threshold (`SEAT-GAP-005`)

This does trigger `SEAT-FR-265`'s escape clause *"except where the default column says so explicitly"* — the
clause is now genuinely satisfied, where before it was not. `SEAT-FR-265` (L1853–1860) states the unset/set rule
deterministically. **Value domain unchanged** at *"Integer 1–100, or unset"* — correctly, since `unset` must
survive for `SEAT-GAP-005`.

**Preserve targets verified byte-identical against `4d3e39c`:**

| Target | Line | Verdict |
|---|---|---|
| `SEAT-FR-241` | 1668–1670 | ✅ unchanged |
| `SEAT-FR-267` | 1899–1902 | ✅ unchanged |
| `SEAT-AC-169` | 2520 | ✅ unchanged |
| `SEAT-AC-170` | 2521 | ✅ unchanged |
| `SEAT-GAP-005` | 2221 | ✅ unchanged |

### 3.2 What the correction missed — `SR-1`

`SEAT-FR-212`, §22.2 *Threshold alerting*, L1478–1479, **verbatim**:

> `SEAT-FR-212` — Threshold values are tenant configuration. Where none is configured, the module **MUST** default
> to **90%** of active seat capacity and **MUST** remain operable.

This is byte-identical in `4d3e39c` (pre-correction), so it is **pre-existing and untouched**. It contradicts, on
its face:

| Contradicts | Which says |
|---|---|
| `SEAT-CFG-017` (as corrected) | unset → *"no event is emitted and no value is substituted"* |
| `SEAT-FR-265` (as corrected) | unset → *"the **90%** figure **MUST NOT** be applied as a fallback"* |
| `SEAT-FR-241` | *"the module **MUST NOT** substitute a hard-coded value"* |
| `SEAT-FR-267` | *"Until confirmed, no threshold is set"* |
| `SEAT-AC-170` | unset + 100% occupancy → *"No `SEAT-EVT-004` is emitted"* |
| `SEAT-BR-037` | every configurable **MUST** have *"exactly one default"* |

`SEAT-FR-212` says *"MUST default to 90%"*. `SEAT-FR-265` says *"MUST NOT be applied as a fallback"*. **Two `MUST`
rules, same subject, opposite outcomes.** `SEAT-FR-265`'s claim that *"Exactly one row exercises that escape
clause"* is true of the §27.1 table but does not reach a requirement stated 374 lines earlier.

Second, smaller defect in the same requirement: **`SEAT-FR-212` has no acceptance criterion** — a grep for
`SEAT-FR-212` returns exactly one hit, its own definition. Under `SEAT-NFR-011` and the `MM-NFR-014` doctrine the
PRD itself adopts, an uncited rule is *"a rule that cannot be checked."* This is why the previous review's
FR-coverage figure of 71.1% is not merely cosmetic: `SEAT-FR-212` is precisely the kind of requirement that an
untested gap conceals.

### 3.3 The four-state test — run against **all** governing statements

The previous review and correction tested four states against `SEAT-CFG-017`, `SEAT-FR-265`, `SEAT-FR-241`,
`SEAT-FR-267`, `SEAT-AC-169`, `SEAT-AC-170`. I added `SEAT-FR-211`, `SEAT-FR-212`, `SEAT-FR-242`, §24.1 L1658 and
`SEAT-EVT-004`'s own definition at L1449.

| State | `SEAT-CFG-017` + `FR-265` + `FR-241` + `FR-267` + `AC-170` | `SEAT-FR-212` | Determinate? |
|---|---|---|---|
| **`unset`** | No threshold. `SEAT-EVT-004` **never** emitted, including at 100%. 90% must **not** be substituted | **"MUST default to 90%"** → threshold **is** 90%, event **is** emitted on crossing | ❌ **CONTRADICTION** |
| **`1`** | Threshold = 1%; emitted on crossing 1% (`SEAT-FR-242`) | Silent (a value *is* configured) | ✅ determinate |
| **`90`** | Threshold = 90%; emitted once on crossing, re-arms downward (`SEAT-AC-169`) | Silent | ✅ determinate |
| **`100`** | Threshold = 100%; emitted on crossing when set. When unset, 100% emits nothing (`SEAT-AC-170`) | Silent | ✅ determinate |

**Three of four states are deterministic. The `unset` state — which per `SEAT-GAP-005` is the actual V1 state — is
not.** The correction record's §1.4 claim that *"No state is now ambiguous, and no two statements in the PRD
disagree about any of the four"* is **incorrect as measured**: it is true of the six statements the author
examined and false of the document as a whole.

### 3.4 Two boundary observations, non-blocking

- **`SEAT-AC-169` reads *"the threshold at its default 90%"***. After the correction, 90% is no longer *the
  default* — it is a proposal pending `E-05`. The AC remains valid if read as *"threshold set to 90"*, and it was
  an explicit preserve target, so I record this as wording drift, not a defect (`SR-4`).
- **Domain `1–100` vs crossing semantics.** At threshold `100`, occupancy cannot *exceed* 100%, so a crossing is
  only observable on reaching exactly 100% and re-arming downward. `SEAT-FR-211`'s *"crosses… in either
  direction"* and `SEAT-FR-242`'s re-arm cover this adequately. **No finding.**

---

## 4. `RQ-2` — deferral **ACCEPTED**, with one qualification

The previous review measured 18 of 24 `SEAT-PO-*` uncited; I reproduce **exactly 18 uncited, 6 cited**
(`SEAT-PO-009/010/011/012/013/016`) across 5 AC rows.

I independently agree the deferral is legitimate, for reasons I verified rather than accepted:

1. **The behaviour is not untested — the *register* is uncited.** `SEAT-AC-044`, `045`, `080`, `114`, `120`, `194`,
   `200`, `218` all exercise role-gated behaviour. `SEAT-AC-200` tests export denial for Reception, student *and*
   guardian without citing `SEAT-PO-014`.
2. **§28.2's matrix is fully populated** — 24 rows × 4 role columns, zero undefined cells. `PRD-004` shipped two
   literal `**GAP**` cells and still passed its stage with findings.
3. **Citing `SEAT-PO-*` on gate/invariant ACs would be decorative.** I checked the specific rows the correction
   record names: `SEAT-AC-030` tests gate step G7, `SEAT-AC-153` tests `SEAT-INV-008`, `SEAT-AC-196` tests
   `SEAT-FR-273`. None is governed by a `SEAT-PO-*`. The author's refusal to pad was correct.
4. **The gate permits it** — L119 allows explicit deferral with a reason and an owner; both are recorded.

**Qualification (`SR-2`, LOW).** `SEAT-FR-272` declares the list **closed** — *"An operation not in this list does
not exist in V1"* — and `SEAT-FR-303` requires that where a requirement's only observable consequence is an
**absence**, *"the absence itself **MUST** be the criterion."* No AC tests the **closure** of the list. That is a
genuine missing criterion of a kind `SEAT-FR-303` specifically mandates, distinct from per-operation coverage.
It remains LOW: `SEAT-AC-196` and `SEAT-AC-195` test adjacent absences.

---

## 5. `RQ-3` — `SEAT-NFR-009` is **NOT sufficiently testable**. Finding `SR-3`.

### 5.1 The citations added are accurate

`SEAT-NFR-007` → `SEAT-AC-108` (duplicate redelivery, idempotent by event id) and `SEAT-AC-111` (missed/stale
`E-08`, converges). Those two rows do test duplicate **and** out-of-order tolerance. `SEAT-NFR-007` is
**adequately covered.** ✅

`SEAT-NFR-009` → `SEAT-AC-125` (100 rows, row 57 fails, no row applied) and `SEAT-AC-130` (bulk reassign, none
applied). Both test all-or-nothing. ✅ *for that limb only.*

### 5.2 What remains untestable

`SEAT-NFR-009` states three obligations. Measured coverage:

| Limb | Tested? |
|---|---|
| Complete or fail as a unit | ✅ `SEAT-AC-125`, `SEAT-AC-130` |
| *"at the maximum row count the entitlement permits"* | ❌ no AC; no numeric bound anywhere |
| *"MUST NOT hold a lock… in a way that blocks counter operations"* — counter ops take precedence | ❌ no AC |

The second limb is **unbounded**: the maximum row count is never stated, and `grep` for *"maximum row"* returns
only `SEAT-NFR-009` itself. The third is a **priority requirement** ("counter operations take precedence") with no
observable criterion. Against gate check 1's own failure example, *"MUST NOT hold a lock… in a way that blocks"*
is closer to *"the system should be fast"* than to a testable statement.

**The correction record disclosed this honestly** (§2.3, *"partially, not fully, covered"*), which I credit. But
disclosure is not resolution: `RQ-3` was raised as *"`SEAT-NFR-009` is behavioural and testable"* and it is only
**partly** so. Recorded as `SR-3`, LOW — the untested limbs are performance-shaped, and `SEAT-NFR-004` forbids
this document from stating its own figures, so the fix likely belongs upstream.

### 5.3 A correction to the previous review's measurement

The previous review reported NFR coverage rising 5/12 → 7/12. I measure **7/12** and confirm it. Uncited:
`SEAT-NFR-001`, `003`, `004`, `011`, `012` — all correctly uncited (`004` forbids local figures; `003` defers to
frozen `MM-NFR-011`; `011`/`012` are document meta-rules).

---

## 6. `RQ-4` — verified **RESOLVED**

L31–32 now reads:

> This constraint is the source draft's §43 — that number is the source draft's own numbering, not a section of
> this document, which has 36 sections — retained verbatim in intent.

Unambiguous: it names the foreign namespace, states this document's section count, and cannot be misread as an
internal reference. My scanner still reports `unresolvable: ['43']`, which is **correct behaviour** for a
heading-resolution tool and not a defect. **Closed.**

---

## 7. `SEAT-AC-170 → SEAT-GAP-005` — **NOT a defect.** Observation withdrawn.

The previous conversation flagged this as a possible §0.3 violation. **I independently disagree, and the earlier
framing was incomplete in a way that matters.**

§0.3 states: *"`SEAT-GAP-*` identifiers are **questions, not requirements**, and must never be cited **as
verifiable**."*

Three findings:

1. **`SEAT-AC-170` is not unique.** Measured, **three** AC rows cite a `SEAT-GAP-*`: `SEAT-AC-033`
   (`SEAT-GAP-002`), `SEAT-AC-102` (`SEAT-GAP-003`), `SEAT-AC-170` (`SEAT-GAP-005`). Treating `SEAT-AC-170` as a
   singular anomaly was a measurement error.
2. **All three also cite a real requirement** — `SEAT-CFG-003`, `SEAT-FR-155`, `SEAT-FR-241` respectively. So in
   every case the *verifiable* subject is a requirement; the `SEAT-GAP-*` is a **context pointer** explaining why
   the criterion's precondition exists.
3. **The rule prohibits citing a gap *as verifiable*, not mentioning one.** None of the three tests a gap. Reading
   §0.3 to forbid the mention would also forbid `SEAT-GAP-005`'s own impact column referencing `SEAT-FR-241`.

**Disposition: OBSERVATION, no action.** A consistent house style might move gap pointers out of the Verifies
column into a Notes column, but that is preference, not a gate failure. Recorded so no future reviewer re-raises
it as a defect.

---

## 8. Deletion / weakening audit — **PASS**

Diffed `4d3e39c` → `1e2a2e3`.

| Property | Before | After | Verdict |
|---|---|---|---|
| Registers `FR/BR/INV/EVT/XC/PO/CFG/NFR/AC/GAP` | 304/45/14/4/22/24/18/12/225/14 | **identical** | ✅ |
| §0.3 declared ranges vs measured | contiguous 1..max, 0 gaps | **contiguous, 0 missing, 0 extra** | ✅ |
| Identifiers created / deleted / renumbered | — | **0 / 0 / 0** | ✅ |
| AC table rows | 225 | **225** | ✅ |
| Requirement weakened | — | **none** — the only requirement-bearing edit (`SEAT-FR-265`) *added* `MUST NOT` constraints | ✅ |
| `MUST` / `MUST NOT` | — | 369 / 223 | ✅ no prohibition removed |
| Status / version | v1.0 `DRAFT` | **v1.0 `DRAFT`** | ✅ correctly not bumped |

Diff was 15 insertions / 8 deletions across 5 sites, as the correction record claims. **Verified accurate.**

---

## 9. Mechanical verification

Run with a purpose-built verifier, independent of the previous review's script.

| Check | Result |
|---|---|
| Register counts vs §0.3 declared ranges | **PASS** — all 10 contiguous, max == declared max, 0 missing, 0 extra |
| Identifiers used but never defined | **PASS — 0** |
| Identifiers defined more than once | **PASS — 0** (my stricter definition-site rule resolves the previous review's 14 flags to 0; they were line-wrap artefacts, as `RQ-R4` concluded) |
| Orphan ACs (Verifies cites no requirement) | **PASS — 0 / 225** |
| Malformed AC rows (< 5 cells) | **PASS — 0** |
| Dangling citations (outside declared range) | **PASS — 0** |
| Configurables with empty default or domain | **PASS — 0 / 18** |
| Vague language in normative lines | 1 — adjudicated (§11.1) |
| Unresolvable `§` refs | 1 — `§43`, correct by design (§6) |
| Modals | MUST 369 · MUST NOT 223 · MAY 17 · SHOULD 1 · SHOULD NOT 1 |

### 9.1 A measurement correction to the previous review

The previous review reported `SEAT-FR-302`'s promise at **85/85 = 100.0%**. Measured strictly against the
**Verifies column**, it is **83/85 = 97.6%**: `SEAT-EVT-001` and `SEAT-EVT-004` appear only in the *Then* column
(`SEAT-AC-166`; `SEAT-AC-169`/`170`), never in a Verifies column.

`SEAT-FR-302`'s literal words are *"cited by at least one `SEAT-AC-*` criterion"* — not "in the Verifies column" —
so **the PRD's own promise is met at 85/85 and gate check 4 passes.** But §33's stated purpose is that
*"a reader can go from any requirement to its test **and back**"*, and that round-trip fails for those two events.
Recorded as `SR-5`, LOW. **This does not change the verdict**; it corrects the record so the 100% figure is not
over-read.

---

## 10. Stage 3 / tenancy / security regression — **PASS**

| Surface | Stage 3 record | Measured now | Verdict |
|---|---|---|---|
| Edges cited | 13, ⊂ 26 declared, 0 invented | **13, identical** `E-01 E-02 E-03 E-04 E-05 E-08 E-13 E-17 E-18 E-19 E-20 E-21 E-23` | ✅ |
| `E-05` payload fidelity | conforms to BC Map | L192 == `LIBOORA_BOUNDED_CONTEXT_MAP.md` L302 **verbatim**; threshold still *"Proposed"* only | ✅ |
| Scope register | `self` / `guardianOf` / `tenantWide` only | `guardianOf` 4 · `tenantWide` 4 · no invented scope | ✅ |
| Tenant isolation | tenant-bearing surfaces intact | `tenantId` 19 · explicit *"tenant isolation"* 2 · `SEAT-AC-109` still fails loudly, never defaults a tenant | ✅ |
| Authorisation | consumed, not invented | §28.1 unchanged; `SEAT-AC-195` denies override to every role incl. Owner | ✅ |
| `SEAT-GAP-001` | open, false positive | **still open, 3 mentions, untouched** | ✅ |
| `SEAT-GAP-003` / `Q-01` | open, non-blocking | **still open, 5 mentions**; `MASTER_PRD.md` L673 still *"Open"* — not pre-empted | ✅ |
| Rank 1 | no contradiction | `MP-GBR-16`, `MP-GBR-17` verified verbatim at source | ✅ |
| Headings | 136 | **136** | ✅ |

**No Stage 3 decision regressed. No security or tenancy text was touched by the correction.**

---

## 11. Rejected findings — independently re-evaluated

Each of the previous review's six rejections was re-tested from source, not accepted.

| ID | Previous rejection | My independent verdict |
|---|---|---|
| `RQ-R1` | `SEAT-NFR-003`'s *"fast"* quotes frozen `MM-NFR-011` | **REJECTION UPHELD.** Verified at `PRD-MEMBERSHIP-MANAGEMENT.md` L1351. `SEAT-NFR-004` forbids a local figure. Inventing one would create the two-sources-of-truth defect gate check 5 exists to prevent |
| `RQ-R2` | FR coverage 71.1% not a gate failure | **UPHELD, with a caveat.** `SEAT-FR-302` promises only BR/INV/EVT/XC. But `SR-1` shows an uncited FR (`SEAT-FR-212`) concealed a live contradiction — so the figure is a genuine **risk indicator**, not merely cosmetic |
| `RQ-R3` | PO coverage 25% mitigated by the matrix | **UPHELD**, with `SR-2` split out: list-closure is a distinct missing criterion under `SEAT-FR-303` |
| `RQ-R4` | 14 "double definitions" are line-wrap artefacts | **UPHELD and independently reproduced.** My stricter rule yields **0** multi-defined identifiers |
| `RQ-R5` | Judging against an unstated coverage gate would invent a requirement | **UPHELD.** Correct method |
| `RQ-R6` | `SEAT-GAP-003`/`Q-01` does not block | **UPHELD.** `Q-01` is Open at Rank 1; deciding it here would silently amend Rank 1 (L177). `PRD-005` was frozen carrying `MM-GAP-001` |

### 11.1 My own detector hit — vague language

`SEAT-NFR-003` L2249, *"MUST be fast enough not to dominate the seat-assignment path"*. **Not a finding**, per
`RQ-R1`, on evidence I re-verified at source.

### 11.2 My own detector hit — false positive, recorded

My exclusion scanner flagged `SEAT-XC-020` for deferral language without impossibility language. **Disproved on
inspection**: it reads *"It **MUST NOT** be invented here."* The impossibility clause is on the wrapped
continuation line. Detector artefact; **no finding**.

### 11.7 Duplicate-citation flags

Eight AC rows repeat an identifier across scenario text and Verifies column (`SEAT-AC-033`, `053`, `056`, `060`,
`062`, `080`, `224`, `225`). **Byte-identical in `4d3e39c`** — pre-existing, not introduced, and harmless: the
repetition is between two columns with different roles. **No finding.**

---

## 12. Findings register

**4 findings. 0 CRITICAL · 0 HIGH · 1 MEDIUM · 3 LOW.**

| ID | Severity | Location | Finding | Evidence | Recommendation | Owner | ADR? |
|---|---|---|---|---|---|---|---|
| `SR-1` | **MEDIUM** | `SEAT-FR-212` L1478–1479 | **Surviving instance of the `RQ-1` contradiction.** *"Where none is configured, the module **MUST** default to **90%**"* directly contradicts corrected `SEAT-FR-265` (*"**MUST NOT** be applied as a fallback"*), `SEAT-CFG-017`, `SEAT-FR-241`, `SEAT-FR-267` and `SEAT-AC-170`, and breaches `SEAT-BR-037`'s *"exactly one default"*. Also has **no AC** | Verbatim quoted §3.2; byte-identical in `4d3e39c`; `grep SEAT-FR-212` = 1 hit (its own definition) | Align `SEAT-FR-212` with the unset rule — e.g. *"Where none is configured, no threshold event is emitted (`SEAT-FR-241`)"* — and give it a criterion. **Clarifying edit; no ADR** | `PRD-007` author | **No** |
| `SR-2` | LOW | `SEAT-FR-272` / §28.2 | Closed-list **closure** is untested. `SEAT-FR-303` requires an absence to be its own criterion; no AC asserts that no operation outside the 24 exists | 5 AC rows cite `SEAT-PO-*`; none tests closure | Add one closure criterion at Stage 6 | `PRD-007` author (Stage 6) | No |
| `SR-3` | LOW | `SEAT-NFR-009` L2270–2273 | Two of three limbs untestable: *"maximum row count the entitlement permits"* is never bounded anywhere; *"MUST NOT hold a lock… in a way that blocks"* has no observable criterion | `grep "maximum row"` → only `SEAT-NFR-009`; no AC for either limb | Either bound the row count by citing the entitlement source, or restate the lock limb observably | `PRD-007` author | No |
| `SR-4` | LOW | `SEAT-AC-169` L2520 | Says *"the threshold at its default 90%"*; after the correction 90% is a **proposal**, not the default. Wording drift, not a behavioural error | `SEAT-CFG-017` + `SEAT-FR-267` | Reword to *"threshold set to 90"* when next edited. Was a preserve target — deliberately not corrected | `PRD-007` author | No |
| `SR-5` | LOW | `SEAT-EVT-001`, `SEAT-EVT-004` | Cited only in AC *Then* columns, never in a *Verifies* column, so §33's *"requirement to its test and back"* round-trip fails for 2 of 85 | Measured 83/85 by Verifies column; 85/85 by `SEAT-FR-302`'s literal wording | Add to the Verifies column of `SEAT-AC-166` / `SEAT-AC-169` | `PRD-007` author | No |

### 12.1 By severity

| Severity | Count | IDs |
|---|---|---|
| CRITICAL | **0** | — |
| HIGH | **0** | — |
| MEDIUM | **1** | `SR-1` |
| LOW | **4** | `SR-2`, `SR-3`, `SR-4`, `SR-5` |
| OBSERVATION | **1** | `SEAT-AC-170` gap citation (§7) — withdrawn as a defect |
| REJECTED (re-upheld) | **6** | `RQ-R1`…`RQ-R6` |

---

## 13. `RQ-1`…`RQ-4` disposition

| ID | Correction record claims | My independent verdict |
|---|---|---|
| `RQ-1` | **RESOLVED** | **PARTIALLY RESOLVED.** Both named sites genuinely fixed; a third site (`SEAT-FR-212`) still contradicts. 3 of 4 states deterministic; `unset` is not. → `SR-1` |
| `RQ-2` | Deferred, no edit | **DEFERRAL ACCEPTED.** Independently verified as a legitimate L119 deferral, and the refusal to pad was correct. One distinct sub-gap split out → `SR-2` |
| `RQ-3` | RESOLVED, `SEAT-NFR-009` partial | **PARTIALLY RESOLVED, as disclosed.** `SEAT-NFR-007` adequately covered; `SEAT-NFR-009` has two untestable limbs → `SR-3` |
| `RQ-4` | **RESOLVED** | **RESOLVED.** Unambiguous. Closed |

**On the correction record's accuracy:** its §1.4 assertion that *"No state is now ambiguous, and no two
statements in the PRD disagree"* is **not sustained** — true of the six statements examined, false of the
document. Its `RQ-2` reasoning, `RQ-3` partial-coverage disclosure, diff accounting and containment claims are all
**accurate as verified**. The author's self-discipline in refusing to pad coverage was correct and is credited.

---

## 14. Final verdict

> ### **B — MINOR CORRECTIONS**
>
> All six Stage 4 checks pass as written. Registers are contiguous and unchanged; there are zero orphan criteria,
> zero dangling citations, zero undefined or duplicate identifiers, zero deleted or weakened requirements, and no
> Stage 3, tenancy, security or Rank 1 regression. `SEAT-GAP-001` and `SEAT-GAP-003` remain open and untouched.
> `RQ-4` is closed; `RQ-2`'s deferral is legitimate; `RQ-3` is closed to the extent it was resolvable.
>
> **But `RQ-1` is not fully resolved.** `SEAT-FR-212` still mandates the 90% fallback that four other statements
> forbid, and it carries no acceptance criterion. That is one MEDIUM defect, on the live V1 path, unrecorded in
> any register or deferral — so `PRD_LIFECYCLE.md` L119's gate is not fully met.
>
> **I am not recording A — PASS.** The remedy is a single clarifying edit plus one criterion, well within a
> targeted correction, requiring no ADR. Once `SR-1` is closed, this PRD should reach **A** on the next pass.

### 14.1 What this review did **not** do

Did not modify the PRD (hash identical before and after) · did not fix any finding · did not create an ADR,
specification, schema, API spec or code · did not begin Stage 5, 6 or 7 · did not register traceability, allocate
`IMPL-*`, or freeze · did not resolve `SEAT-GAP-001` or `SEAT-GAP-003` · did not modify any governance,
architecture or frozen document · did not alter the previous review's verdict or the correction record.

### 14.2 Status of this document

**Validation record — not part of the specification**, per `DOCUMENTATION_BASELINE.md` §3.3. It confers no rank
and freezes nothing.
