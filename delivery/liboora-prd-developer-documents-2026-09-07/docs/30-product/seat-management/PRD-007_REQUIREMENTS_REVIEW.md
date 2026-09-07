# `PRD-007` Seat Management v1.0 — Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) L108–118) |
| **Subject** | [`PRD-SEAT-MANAGEMENT.md`](PRD-SEAT-MANAGEMENT.md) — `PRD-007`, `BC-04` Seating, **v1.0 `DRAFT`** |
| **Gate satisfied by** | This document — *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Precedent followed** | [`PRD-004_INDEPENDENT_REVIEW_REPORT.md`](../student-management/PRD-004_INDEPENDENT_REVIEW_REPORT.md) — findings register, severity scheme, rejected findings · [`PRD-005_FIFTH_INDEPENDENT_REVIEW.md`](../membership-management/PRD-005_FIFTH_INDEPENDENT_REVIEW.md) — header, verdict form, containment audit |
| **Stage 3 record consumed** | [`PRD-007_ARCHITECTURE_ALIGNMENT.md`](PRD-007_ARCHITECTURE_ALIGNMENT.md) — **ALIGNED**, 6/6 checks PASS |
| **Prior record consumed** | [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](PRD-007_INDEPENDENT_GAP_VERIFICATION.md) — `SEAT-GAP-001` false positive, `SEAT-GAP-003` open/non-blocking |
| **Reviewed at** | `72e941d` |
| **PRD hash at review** | `623b8945ba03161fda507137315ee04f64cd72e99af9c08036a7441243be386a` — verified identical before and after |
| **Date** | 2026-08-10 |
| **Mandate** | **Review only.** No PRD modified, no ADR, no architecture document, no traceability matrix, no implementation tasks, no specification, no code, no freeze, no registry or baseline change |
| **Verdict** | **B — MINOR CORRECTIONS.** 1 MEDIUM · 3 LOW · 6 rejected. 0 CRITICAL, 0 HIGH. All six Stage 4 gate checks pass; the single MEDIUM is an internal wording conflict resolvable inside the PRD without an ADR |
| **Disposition of findings** | Acted on after this review by [`PRD-007_CORRECTION_RECORD.md`](PRD-007_CORRECTION_RECORD.md): `RQ-1` **RESOLVED** · `RQ-3` **RESOLVED** (partially for `SEAT-NFR-009`) · `RQ-4` **RESOLVED** · `RQ-2` **deferred, no edit** — reason and owner recorded. **This review's verdict and findings below are left exactly as issued;** the correction record is a separate artefact and does not re-verdict this one. A Stage 4 **re-review** remains for an independent reviewer |

---

## 0. Verdict

> ### **B — MINOR CORRECTIONS**

**4 findings: 0 CRITICAL · 0 HIGH · 1 MEDIUM · 3 LOW. 6 candidate findings rejected with reasons (§9).**

All six of Stage 4's named gate checks pass. Every requirement is testable, every exclusion states what must be
impossible, every configurable has an owner and a default, every acceptance criterion maps to a requirement, no
requirement restates another PRD's, and no business rule contradicts Rank 1.

The single MEDIUM (`RQ-1`) is a genuine internal contradiction — **not** an architecture conflict and **not** a gap
requiring an ADR. `SEAT-CFG-017` is the only configurable whose value domain includes *"or unset"*, and that collides
with `SEAT-FR-265`'s absolute rule that an unset configurable takes its stated default. The behaviour the document
actually wants is unambiguous everywhere else it is stated (`SEAT-FR-241`, `SEAT-FR-267`, `SEAT-AC-170`), so this is a
one-row wording defect, correctable inside the PRD under `PRD_LIFECYCLE.md` L171 as a clarifying edit.

**Why this is B and not A.** `RQ-1` is a real contradiction between two normative statements, both carrying **MUST**.
Under Stage 4's own standard — *"Every configurable has a default and a range"*, whose failure mode is *"Unbounded
configuration is a specification hole"* — a configurable that is simultaneously required to default to 90% and
permitted to be unset is not yet fully specified. It is minor because the intended behaviour is stated three times
elsewhere and no invariant, gate step or security rule depends on the ambiguity.

**Why this is not C.** Nothing is missing, nothing contradicts a higher rank, no capability is dropped, no acceptance
criterion is orphaned, and no register is inconsistent. `PRD-004` earned a C for defects of a different order — a
requirement demanding edges that do not exist, an event set contradicting Rank 4, an unevaluable invariant. `PRD-007`
has none of those.

---

## 1. Method

Every finding cites the PRD by line and, where a claim about another document is load-bearing, the source document by
path and line. Counts were produced mechanically, not by reading. Three checks are stated as reproducible commands in
§10 so a third party can re-derive them.

I attempted to falsify the document rather than confirm it. Where a mechanical check flagged something, I inspected
every hit and classified it — a detector hit is a candidate finding, not a finding. Fourteen flagged "duplicate
definitions" and one flagged "vague word" turned out to be detector artifacts, and they are recorded as rejected in §9
rather than silently dropped, per Stage 4's rule that *"a review that records only accepted findings is
indistinguishable from a review that found nothing."*

### 1.1 Sources validated against

| # | Source | Path | Rank |
|---|---|---|---|
| 1 | Master PRD v1.7 | `../MASTER_PRD.md` | **1** |
| 2 | `ADR-0018`, `ADR-0019` | `../../00-governance/adr/` | **2** |
| 3 | Authentication PRD v2.0 | `../authentication/Authentication_PRD_v2.md` | **3** |
| 4 | Library PRD v1.1 | `../library/Library_PRD_v1.md` | **3** |
| 5 | Membership PRD v1.4 — **FROZEN** | `../membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` | **3** |
| 6 | Student Management PRD v1.2 — **FROZEN** | `../student-management/Student_Management_PRD_v1.md` | **3** |
| 7 | Bounded Context Map | `../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4** |
| 8 | PRD Lifecycle · Documentation Baseline | `../../00-governance/` | — |

### 1.2 Severity scheme

Following `PRD-004_INDEPENDENT_REVIEW_REPORT.md` §19.

| Severity | Meaning |
|---|---|
| **CRITICAL** | Ships a security or data-integrity defect, or contradicts Rank 1. Blocks the stage |
| **HIGH** | A requirement is unimplementable, unevaluable, or self-contradictory in a way that changes behaviour |
| **MEDIUM** | A genuine defect in specification quality; behaviour is recoverable from elsewhere in the document |
| **LOW** | Cosmetic, navigational, or a precision improvement with no behavioural consequence |
| **REJECTED** | Considered and dismissed, with the reason recorded |

---

## 2. The six Stage 4 gate checks

`PRD_LIFECYCLE.md` L110–116 names exactly six checks. Each is answered below against measured evidence.

| # | Check | Failure mode named by the lifecycle | Result |
|---|---|---|---|
| 1 | Every requirement testable | *"The system should be fast" — unverifiable* | ✅ **PASS** (§3) |
| 2 | Every exclusion states what must be **impossible** | *An exclusion is not a deferral* | ✅ **PASS** (§4) |
| 3 | Every configurable has a default and a range | *Unbounded configuration is a specification hole* | ⚠️ **PASS with `RQ-1`** (§5) |
| 4 | Every acceptance criterion maps to a requirement | *Orphan criterion* | ✅ **PASS** (§6) |
| 5 | No requirement restates another PRD's | *Two sources of truth* | ✅ **PASS** (§7) |
| 6 | Business rules do not contradict Rank 1 | *Rank 1 wins; the PRD is wrong* | ✅ **PASS** (§8) |

---

## 3. Check 1 — Every requirement testable

### 3.1 Normative language is defined

§0.2 *"Normative language"* exists (L34), satisfying the precondition `PRD-004` failed (`RF-05`: no such section).
Measured modal usage across 2,833 lines:

| Modal | Count |
|---|---|
| **MUST** | 615 |
| **MUST NOT** | 228 |
| **MAY** | 18 |
| **SHOULD** | 2 |
| **SHOULD NOT** | 1 |

`SHOULD` is used sparingly rather than not at all — `PRD-004` was flagged (`RF-18`) for 125 `MUST` and zero `SHOULD`,
which made every design preference mandatory. `PRD-007` distinguishes the two.

### 3.2 Vague language scan

A scan of every line containing `MUST`, `SHOULD` or `MAY` against twenty vagueness patterns (`fast`, `appropriate`,
`reasonable`, `sufficient`, `efficient`, `etc.`, `where possible`, `typically`, `as needed`, and others) returned
**exactly one hit**:

```
L2242  SEAT-NFR-003 — "The membership validity check MUST be fast enough not to
       dominate the seat-assignment path, consistent with MM-NFR-011"
```

**Not a finding.** Verified at source: `PRD-MEMBERSHIP-MANAGEMENT.md:1351` states `MM-NFR-011` as *"A validity check
**MUST** complete fast enough to sit in the seat-assignment and check-in paths without becoming their bottleneck."*
The wording is a deliberate quotation of a **frozen Rank 3** requirement, and the obligation is explicitly assigned to
the publishing side. `SEAT-NFR-004` then forbids this module from stating a latency figure of its own, citing
`LIB-20.1` as precedent. Restating a number here would create the two-sources-of-truth defect check 5 exists to
prevent. Recorded as rejected finding `RQ-R1`.

### 3.3 Non-functional requirements are bounded

All 12 `SEAT-NFR-*` were inspected individually. None states a bare aspiration; each either cites a platform figure,
names a bound (`LCFG-9`/`LCFG-10` seat maxima), or states a structural property (strong consistency, convergence,
duplicate tolerance, all-or-nothing). `SEAT-NFR-011` closes the loop by requiring every requirement to be observable
through a reachable surface.

### 3.4 Result

> ✅ **PASS.** No unverifiable requirement found. The one flagged phrase is a quotation of a frozen Rank 3 obligation,
> deliberately not restated as a local figure.

---

## 4. Check 2 — Every exclusion states what must be impossible

### 4.1 The register

22 `SEAT-XC-*` identifiers, contiguous `001`…`022`, each cited by at least one acceptance criterion (§6).

### 4.2 Exclusions are prohibitions, not deferrals

The lifecycle's failure mode is *"an exclusion is not a deferral"* — an exclusion that merely postpones a feature
leaves the V1 surface undefined. Sampled verification:

| Exclusion | Form | Verdict |
|---|---|---|
| `SEAT-XC-001` | `Locked` never returned as a state value; `SEAT-AC-021` asserts the flag form | Prohibition |
| `SEAT-XC-002` | No code path sets state directly; `SEAT-AC-023` asserts read-twice stability | Prohibition |
| `SEAT-XC-005` | *"Waiting lists, queues … are out of scope"*; `SEAT-AC-078`: *"No waiting-list affordance exists"* | Prohibition |
| `SEAT-XC-014` | `SEAT-AC-153`: edit or delete attempted *"by any role including Owner"* → *"No such operation exists"* | Prohibition |
| `SEAT-XC-020` | Public live occupancy deferred by `ARCHITECTURE_RULINGS.md` §6; *"**MUST NOT** be invented here"* | Prohibition enforcing a ruling |
| `SEAT-XC-021` | *"**MUST NOT** publish to the search index in V1, and **MUST NOT** be given an edge to it without an ADR"* | Prohibition |

### 4.3 Deferred features carry no requirements

`SEAT-FR-304` claims *"nothing classified **V2**, **V3**, **Future** or **Not recommended** carries a requirement
identifier anywhere in this document — a deferred feature that still had requirements would be V1 by the back door."*

**Tested mechanically.** Scanning every line containing a bold `V2`/`V3`/`Future`/`Not recommended` marker for
requirement identifiers returned exactly three: `SEAT-FR-101`, `SEAT-XC-005`, `SEAT-XC-020`. All three were read in
full:

- `SEAT-FR-101` — *"A waiting list **MUST NOT** be implemented in V1"*
- `SEAT-XC-005` — the waiting-list exclusion itself
- `SEAT-XC-020` — *"Public live occupancy is deferred to V2 … It **MUST NOT** be invented here"*

Each is a **prohibition that enforces the deferral**, not a requirement that builds the deferred feature. The claim
holds. Recorded as rejected finding `RQ-R2`.

### 4.4 Result

> ✅ **PASS.** Every exclusion states an impossibility. No deferred feature carries an implementing requirement.

---

## 5. Check 3 — Every configurable has a default and a range

### 5.1 The register is complete on its face

18 `SEAT-CFG-*`, contiguous `001`…`018`. §27.1 is a six-column table: ID · Configurable · **Owner** · **Default** ·
**Value domain** · Defined at. Every one of the 18 rows populates all six columns — measured, no blanks.

`SEAT-BR-037` states the rule the document holds itself to: *"Every configurable in this module **MUST** have exactly
one owner, exactly one default, and a defined behaviour when unset."*

### 5.2 `RQ-1` — MEDIUM — `SEAT-CFG-017`'s value domain contradicts `SEAT-FR-265`

This is the one place where the register and the rules governing it disagree.

**`SEAT-FR-265` (L1851), absolute:**

> *"Where a configurable is unset and the table below states a default, the default **MUST** apply. The module **MUST
> NOT** treat an unset configurable as *unlimited*, *permitted* or *disabled* except where the default column says so
> explicitly."*

**`SEAT-CFG-017` (L1875), the register row:**

```
| SEAT-CFG-017 | Occupancy percentage that emits SEAT-EVT-004 | BC-06 via E-05 | 90% | Integer 1–100, or unset | ... |
```

The **Default** column says `90%`. The **Value domain** column admits `unset`. `SEAT-FR-265` says an unset
configurable takes the stated default — so on the register's own terms, `unset` must resolve to 90%, and a threshold
event must fire at 90%.

**But three other statements require the opposite:**

- `SEAT-FR-241` (L1670): *"Where the threshold is unset, no threshold event is emitted; the module **MUST NOT**
  substitute a hard-coded value."*
- `SEAT-FR-267` (L1892): *"Until confirmed, no threshold is set and `SEAT-FR-241`'s unset behaviour applies — no event
  is emitted."*
- `SEAT-AC-170` (L2514): *"No occupancy threshold configured / Occupancy rises to 100% / **No `SEAT-EVT-004` is
  emitted**."*

**The contradiction is real and both sides carry `MUST`.** `SEAT-FR-265` says default-on-unset with an exception only
*"where the default column says so explicitly"* — and the default column says `90%`, not *"unset"*. So the escape
clause `SEAT-FR-265` provides is not triggered by this row as written.

**Why it matters.** `SEAT-CFG-017` is the **only** configurable of the 18 whose value domain contains `unset`
(measured). It is also the only one whose owner is `BC-06` via `E-05` rather than `BC-25` — and per `SEAT-FR-267` and
`SEAT-GAP-005`, the `E-05` payload does not yet carry it, so **unset is the actual V1 state**, not a hypothetical.
The contradiction therefore sits on the live path: an implementer reading §27 alone would emit threshold events at
90%; an implementer reading §24.1 would emit none.

**Severity MEDIUM, not HIGH.** The intended behaviour is unambiguous — stated three times, including in an acceptance
criterion that a test would enforce. No invariant, gate step, authorisation rule or tenancy rule depends on it. The
worst realistic outcome is a spurious notification, not a seating defect or a leak.

**Not an architecture conflict, and no ADR required.** The `E-05` payload question is already recorded as
`SEAT-GAP-005` and was carried at Stage 3 as open/non-blocking. `RQ-1` is narrower: two statements *inside this PRD*
disagree about unset semantics. Correcting it needs no change to `E-05`, the BC Map, or any ranked document.

**Owner:** the `PRD-007` author. **Deferral basis:** none needed — resolvable inside the PRD. **Not corrected here**,
per the review-only mandate.

### 5.3 The other 17 configurables

Each has one owner, one default, and a bounded domain. Spot-verified for prose/table agreement:

| Configurable | Prose default | Table default | Agree? |
|---|---|---|---|
| `SEAT-CFG-008` | disabled (§20 prose L1351) | **disabled** | ✅ |
| `SEAT-CFG-010` | closed value set (L730) | `ApprovalRequired`; `Direct`\|`HoldThenConfirm`\|`ApprovalRequired` | ✅ |
| `SEAT-CFG-012` | default **3** (L794) | **3**, positive integer | ✅ |
| `SEAT-CFG-013` | default **7 days** (L795) | **7 days**, 1–365 days | ✅ |

`SEAT-CFG-015`'s upper bound is `reservationWindow`, a foreign value. **Not a finding:** `reservationWindow` is named
in the BC Map's own `E-05` contract (`LIBOORA_BOUNDED_CONTEXT_MAP.md:302`), `SEAT-FR-266` lists it as explicitly *not*
this module's configurable, and `SEAT-AC-191` asserts its provenance. A bound delegated to a declared contract field
is bounded. Recorded as rejected finding `RQ-R3`.

### 5.4 Result

> ⚠️ **PASS with one MEDIUM finding.** 17 of 18 configurables are fully and consistently specified. `SEAT-CFG-017`
> carries an internal contradiction on unset semantics (`RQ-1`), resolvable inside the PRD.

---

## 6. Check 4 — Every acceptance criterion maps to a requirement

### 6.1 Zero orphan criteria

The lifecycle's failure mode is *"Orphan criterion"* — a test asserting something no requirement demands.

```
AC table rows found          : 225
AC citing >=1 requirement    : 225
ORPHAN AC (no requirement)   : 0
```

Every one of the 225 criteria names at least one `SEAT-FR/BR/INV/EVT/XC/PO/CFG/NFR` identifier in its *Verifies*
column. This is the defect `PRD-004` was flagged for (`RF-08`: *"no acceptance criterion links to a requirement …
grep → 0"*). `PRD-007` carries the source column throughout.

### 6.2 Zero dangling citations

Every `SEAT-*` identifier cited anywhere in the document has a definition site. Measured: **0 dangling**.

### 6.3 Reverse coverage — requirement → criterion

| Register | Covered | Total | % |
|---|---|---|---|
| `SEAT-BR` | 45 | 45 | **100.0%** |
| `SEAT-INV` | 14 | 14 | **100.0%** |
| `SEAT-EVT` | 4 | 4 | **100.0%** |
| `SEAT-XC` | 22 | 22 | **100.0%** |
| `SEAT-FR` | 216 | 304 | 71.1% |
| `SEAT-CFG` | 14 | 18 | 77.8% |
| `SEAT-NFR` | 5 | 12 | 41.7% |
| `SEAT-PO` | 6 | 24 | 25.0% |

**The promise the document makes is met exactly.** `SEAT-FR-302` (L2587) commits to: *"Every `SEAT-BR-*`,
`SEAT-INV-*`, `SEAT-EVT-*` and `SEAT-XC-*` identifier in this document **MUST** be cited by at least one `SEAT-AC-*`
criterion."* All four of those registers measure **100%**. The document does not promise FR/NFR/PO/CFG coverage, and
`SEAT-FR-303` explains the principle: where a requirement's only observable consequence is the absence of a
capability, the absence is the criterion.

The 71.1% FR figure is therefore not a shortfall against a stated promise. It is nonetheless recorded below as `RQ-2`
(LOW) because two sub-registers are thin enough to be worth naming.

### 6.4 `RQ-2` — LOW — `SEAT-PO-*` role permissions are largely untested directly

18 of 24 protected operations carry no acceptance criterion, and tracing each `SEAT-PO` row through the requirement it
cites leaves 16 of 24 with no AC-covered requirement.

**Mitigation, verified.** The permission matrix itself is complete — all 24 rows × 4 role columns are populated with
`Y`/`—`/`C`/`G`, with **no undefined cells**. This is materially better than `PRD-004`, which shipped a matrix
declared *"closed"* containing two literal `**GAP**` cells (`RF-12`). Nine criteria do test role behaviour at the
points where it is most likely to fail: `SEAT-AC-014` (Manager without grant), `SEAT-AC-114` (Reception denied
locking), `SEAT-AC-118` (Owner override recorded), `SEAT-AC-120` (Reception may report but not start maintenance),
`SEAT-AC-194` (Reception denied all financial data, matching Authentication `BR-2.12`), `SEAT-AC-195` (no role
including Owner overrides G7 or tenant isolation), `SEAT-AC-196` (Platform Support holds nothing by default),
`SEAT-AC-218` (Manager scope).

**LOW, not MEDIUM:** the specification is unambiguous — a matrix cell is a testable statement whether or not an AC
restates it. This is a Stage 6 test-coverage observation more than a Stage 4 specification defect.

**Owner:** `PRD-007` author, at Stage 6 task authoring.

### 6.5 `RQ-3` — LOW — 7 of 12 `SEAT-NFR-*` carry no acceptance criterion

Uncovered: `SEAT-NFR-001`, `003`, `004`, `007`, `009`, `011`, `012`. Several are inherently structural
(`SEAT-NFR-004` forbids stating a figure; `SEAT-NFR-011` is a meta-rule about observability), so an AC would be
circular. `SEAT-NFR-007` (duplicate/out-of-order `E-08` tolerance) and `SEAT-NFR-009` (bulk atomicity at maximum row
count) are behavioural and would benefit from criteria.

**LOW:** outside `SEAT-FR-302`'s promise; no behaviour is unspecified, only untested.

**Owner:** `PRD-007` author, at Stage 6.

### 6.6 Result

> ✅ **PASS.** Zero orphan criteria, zero dangling citations, and 100% coverage of every register the document promises
> to cover. Two LOW observations on registers outside that promise.

---

## 7. Check 5 — No requirement restates another PRD's

### 7.1 Foreign requirements are cited as authority, never re-legislated

The failure mode is *"Two sources of truth."* The 25 most-cited foreign identifiers were enumerated and the four
heaviest verified at source:

| Citation | Uses | Source verified | Accurate? |
|---|---|---|---|
| `MP-GBR-16` | 8 | `MASTER_PRD.md:357` — *"A student may not be **seated** without a valid membership. Seating **blocks**; Attendance **records and flags**"* | ✅ Exact |
| `MM-FR-025` | 7 | `PRD-MEMBERSHIP-MANAGEMENT.md:300` — *"A change to `seatQuota` **MUST NOT** alter the `seatQuota` already published for an active membership"* | ✅ Exact |
| `MP-GBR-17` | 5 | `MASTER_PRD.md:358` — *"One active seat allocation per seat per time window, enforced by a database constraint and a pessimistic lock — never optimistically"* | ✅ Exact; PRD says *"`MP-GBR-17` states this in those words"* — true |
| `MM-NFR-014` | 5 | `PRD-MEMBERSHIP-MANAGEMENT.md:71` — *"a rule that cannot be checked"* | ✅ Exact |

In each case the PRD **cites the rule and states its own local consequence**, rather than copying the rule as a
`SEAT-*` requirement. `SEAT-BR-014` is the clearest example: it does not restate `MP-GBR-16`, it declares that gate
step G7 is *"absolute and applies to every role, including Owner"* — a local, testable consequence.

### 7.2 The module declines to hold foreign values

`SEAT-FR-266` (L1880) explicitly lists what are *"**not** this module's configurables"* — arriving over `E-05` as
`SeatRules` — and forbids defining a copy, translating, caching indefinitely, or offering a local override.
`SEAT-FR-025` removes membership expiry, current student, current shift and join date from the seat record, citing
`MM-FR-025` for why a second home for a `BC-02` value is unsafe. `SEAT-FR-010` forbids holding name, photograph,
contact details, guardian data, fee balance or attendance total.

### 7.3 Result

> ✅ **PASS.** No foreign requirement is restated as a local one. Every sampled citation is accurate at source.

---

## 8. Check 6 — Business rules do not contradict Rank 1

### 8.1 The 45 business rules against Master PRD

`SEAT-BR-001`…`045` were read against the Rank 1 global business rules they touch.

| Rank 1 rule | `MASTER_PRD.md` | PRD-007 treatment | Contradiction? |
|---|---|---|---|
| `MP-GBR-16` seating blocks on invalid membership | L357 | `SEAT-BR-014` makes G7 absolute for every role including Owner; `SEAT-AC-030` and `SEAT-AC-195` assert no override exists | **None** — strengthens |
| `MP-GBR-17` pessimistic lock, never optimistic | L358 | `SEAT-INV-001` enforced *"synchronously inside the aggregate **and** at the storage layer"*; `SEAT-BR-031`; *"A read-then-write check without a lock is defective even if it appears to work"* | **None** |
| `MP-GBR-20`…`22` scope-bearing grants, non-disclosing denial | L119–122 | §28.1–28.4; `SEAT-FR-269` adds no fourth scope; denial closes the response-time channel | **None** — exceeds |
| `MP-GBR-03` `StudentRecordId` never leaves tenant | — | `SEAT-FR-291` | **None** |
| `MP-GBR-06`/`07` fail loudly, never default | — | `SEAT-FR-113` unresolvable `tenantId` **MUST** fail | **None** |
| `MP-GBR-08` tenant-partitioned indexes | L339 | Satisfied by abstention — `SEAT-XC-021` declines the index | **None** |

### 8.2 The one place a rule could have over-reached, and does not

`SEAT-BR-043` is the discipline that prevents this module from legislating another context's semantics:

> *"No rule in this document **MUST** cause a seated student to lose their seat automatically except the two cases
> where a higher authority requires it: enrollment suspension and archival. Every other adverse change **MUST** retain
> and flag."*

This is exactly why `SEAT-GAP-003` (`Q-01`) stays open rather than being decided here. `SEAT-FR-155` flags affected
allocations for release and auto-cancels unexpired reservations — it does **not** release the seat. That is correct
under either resolution of `Q-01`, which is the standard `ADR-0019` §3.3 set. **Not resolved by this review**, per
mandate.

### 8.3 Result

> ✅ **PASS.** No business rule contradicts Rank 1. Several are deliberately stricter, and each states why.

---

## 9. Additional review dimensions requested

The twelve requested checks map onto the six gate checks above plus the following.

### 9.1 Requirements completeness — and check 12, missing requirements for stated V1 capabilities

§36 is a 58-row capability checklist plus §36.1's 18 original business rules — **76 rows examined mechanically**.
Every row names at least one carrying requirement or section, and **every requirement identifier cited in those 76
rows exists in the document**. Zero rows with no carrier; zero rows citing an undefined identifier.

The ten objectives of `SEAT-FR-003` each name where they are proven. The 16-step acquisition gate (`G1`…`G16`) is
fully defined — every step has a rejection behaviour and a cited authority — and `SEAT-AC-028` asserts all eight
acquisition paths evaluate the same gate in the same order, which is the defect (per-feature eligibility rules) that
§34.1 item 6 records as corrected.

**No missing requirement was found for any stated V1 capability.**

### 9.2 Internal consistency and contradictions

One contradiction found: `RQ-1` (§5.2). Specifically tested and found consistent:

- `SEAT-FR-091`'s conversion re-evaluates a **subset** of gates (G6, G7, G8, G11, G12) — deliberate and explained:
  a reservation is a hold, not a right to be seated. Consistent with `MP-GBR-16` evaluated at seating.
- `SEAT-INV-001` and gate step `G16` state the same rule at two layers (aggregate, storage) — reinforcement, not
  contradiction.
- Gate identifiers `G1`…`G16` are used consistently; no reference to a `G17` or a gap in the sequence.
- All 136 headings and 75 `§` cross-references resolve except one (`RQ-4`, below).

### 9.3 Duplicate or conflicting requirements

Zero duplicate definitions. All ten registers are contiguous from `001` to their stated maximum with no gaps and no
double-definitions:

```
FR 304 · BR 45 · INV 14 · EVT 4 · XC 22 · PO 24 · CFG 18 · NFR 12 · AC 225 · GAP 14
```

Fourteen candidates flagged by the detector were all line-wrapped citations, not second definitions — see `RQ-R4`.

### 9.4 Requirement clarity and determinism

`SeatState` is **derived** from five stored facts rather than stored (§34.1 item 3), removing the class of defect where
a stored status disagrees with the facts beneath it. `SEAT-AC-023` asserts read-twice stability. `SEAT-BR-041` gives
an explicit operation priority order. `SEAT-CFG-010`'s value set is closed. Auto-assignment is *"deterministic and
staff-invoked."*

### 9.5 Edge cases and failure cases

§30 is a **34-row** edge-case audit; §30.1 records the rules added because the audit found a gap, and §30.2 the
operation priority. Measured failure-path emphasis: 88 uses of *reject*, 52 *fail*, 17 *denied*, 12 *retry*.
**121 of 225 acceptance criteria (53.8%) assert a negative or failure outcome** — the document tests what must not
happen at least as hard as what must.

Edge case 7 (student becomes `Inactive` while seated) is dispositioned to `SEAT-CFG-003` with `SEAT-GAP-002` recorded
because `PRD-004` `SM-GAP-3` leaves it unspecified upstream — correctly deferred to the `BC-01` owner rather than
decided here.

### 9.6 Role permissions

All five Authentication `TR-*` roles are accounted for. `TR-1` Owner, `TR-2` Manager, `TR-3` Reception and `TR-4`
Student are the four matrix columns; `TR-5` Parent is handled by `SEAT-FR-274` (holds no operation; may read under
`guardianOf` scope, restricted to exactly what `SEAT-FR-277` permits a student to see about themselves; **MUST NOT**
book, request, release or cancel). Platform Support holds nothing by default (`SEAT-FR-273`, `SEAT-AC-196`).
Reception is denied all financial data (`SEAT-AC-194`), matching Authentication `BR-2.12`. See `RQ-2` for the
test-coverage observation.

### 9.7 Cross-section consistency

`RQ-4` — **LOW** — one unresolvable section reference. L31 cites *"the source draft's §43"*:

> *"This constraint is the source draft's §43, retained verbatim in …"*

The document has 36 sections, so `§43` cannot resolve internally. Read in context it is explicitly a reference to the
**source draft's** numbering, not this document's — so it is arguably correct as written. It is recorded as LOW
because a reader or a link-checker cannot distinguish an intentional foreign reference from a stale internal one
without reading the surrounding sentence. A parenthetical *"(source draft numbering)"* would remove the ambiguity.
**Owner:** `PRD-007` author.

### 9.8 V1 scope discipline

41 `V1` mentions, 18 `V2`, 4 `V3`. §34 classifies every change to the source draft; §34.1 required corrections,
§34.3 deferrals traced to existing platform rulings. Verified in §4.3: no V2/V3 item carries an implementing
requirement. Deferrals rest on existing rulings (`ARCHITECTURE_RULINGS.md` §6, `LIB-24.2`, `LIB-14B.13`) rather than
on decisions taken in this document.

---

## 10. Findings register

**4 findings. 0 CRITICAL · 0 HIGH · 1 MEDIUM · 3 LOW.**

| ID | Severity | Location | Finding | Evidence | Recommendation | Owner | ADR? |
|---|---|---|---|---|---|---|---|
| `RQ-1` | **MEDIUM** | `SEAT-CFG-017` L1875 vs `SEAT-FR-265` L1851 | Value domain *"Integer 1–100, **or unset**"* contradicts the absolute rule that an unset configurable takes its stated default (90%). Three other statements (`SEAT-FR-241`, `SEAT-FR-267`, `SEAT-AC-170`) require the opposite — no event while unset. The only one of 18 configurables admitting `unset`, and per `SEAT-GAP-005` unset is the actual V1 state | Four lines quoted verbatim in §5.2; measured: 1 of 18 CFG rows contains `unset` | Either set the Default column to *"unset — no event emitted"*, or add the `SEAT-CFG-017` exception to `SEAT-FR-265`'s escape clause. Behaviour is already unambiguous elsewhere | `PRD-007` author | **No** — internal wording, no `E-05`/BC Map change |
| `RQ-2` | LOW | §19 / §28.2 `SEAT-PO-*` | 18 of 24 protected operations carry no acceptance criterion; 16 of 24 have no AC-covered requirement even indirectly | Measured per-`SEAT-PO` trace; mitigated by a fully populated 24×4 matrix with zero undefined cells and 9 role-behaviour criteria | Add criteria for the highest-risk denials at Stage 6 task authoring | `PRD-007` author (Stage 6) | No |
| `RQ-3` | LOW | §32 `SEAT-NFR-*` | 7 of 12 NFRs carry no acceptance criterion; `SEAT-NFR-007` and `SEAT-NFR-009` are behavioural and testable | Measured; outside `SEAT-FR-302`'s stated promise | Add criteria for duplicate/out-of-order `E-08` tolerance and bulk atomicity at maximum row count | `PRD-007` author (Stage 6) | No |
| `RQ-4` | LOW | L31 | `§43` cannot resolve — the document has 36 sections. Context shows it means the *source draft's* §43 | 136 headings measured; 75 `§` refs, 1 unresolvable | Mark it *"(source draft numbering)"* | `PRD-007` author | No |

### Findings by severity

| Severity | Count | IDs |
|---|---|---|
| CRITICAL | **0** | — |
| HIGH | **0** | — |
| MEDIUM | **1** | `RQ-1` |
| LOW | **3** | `RQ-2`, `RQ-3`, `RQ-4` |
| REJECTED | **6** | `RQ-R1`…`RQ-R6` |
| **Total raised** | **4** | |

---

## 11. Rejected findings — recorded as rejected, with reasons

Per `PRD_LIFECYCLE.md`: *"A rejected finding must be recorded as rejected, with its reason … A review that records
only accepted findings is indistinguishable from a review that found nothing."*

| # | Candidate finding | Rejected because |
|---|---|---|
| `RQ-R1` | *"`SEAT-NFR-003` uses the unverifiable word 'fast' — Stage 4's named failure mode."* | It quotes frozen Rank 3 `MM-NFR-011` (`PRD-MEMBERSHIP-MANAGEMENT.md:1351`) and assigns the obligation to the publishing side. `SEAT-NFR-004` forbids stating a local latency figure, citing `LIB-20.1`. Inventing a number here would create the two-sources-of-truth defect check 5 exists to prevent. The word is inherited, deliberate, and the measurable obligation lives with its owner |
| `RQ-R2` | *"`SEAT-FR-101`, `SEAT-XC-005` and `SEAT-XC-020` appear on V2 lines, so `SEAT-FR-304`'s 'no deferred feature carries a requirement' claim is false."* | All three were read in full. Each is a **prohibition enforcing the deferral** (*"MUST NOT be implemented in V1"*, *"MUST NOT be invented here"*), not a requirement building the deferred feature. A rule that forbids a V2 feature in V1 is a V1 requirement. The claim holds as stated |
| `RQ-R3` | *"`SEAT-CFG-015`'s range is unbounded — its upper bound `reservationWindow` is not defined in this document."* | `reservationWindow` is a field of the BC Map's own `E-05` contract (`LIBOORA_BOUNDED_CONTEXT_MAP.md:302`). `SEAT-FR-266` lists it as explicitly *not* this module's configurable and forbids a local copy; `SEAT-AC-191` asserts its provenance. A bound delegated to a declared Rank 4 contract field is bounded — defining a local number would violate the Conformist edge |
| `RQ-R4` | *"14 identifiers are defined twice — a duplicate-requirement defect."* | All 14 were classified by inspection. Each has **exactly one** definition site (`` `ID` — text `` in prose, or a leading table cell); the second hit is a **line-wrapped citation** where a sentence happens to begin with the identifier — e.g. L325 *"`SEAT-BR-005`, and **MUST NOT** alter…"*, L2706 *"`SEAT-BR-025`), and `SEAT-FR-161` guarantees…"*. Zero genuine duplicates. A detector artifact of hard-wrapped Markdown |
| `RQ-R5` | *"FR coverage is only 71.1% and PO coverage 25% — acceptance criteria are inadequate."* | The document promises coverage of `SEAT-BR/INV/EVT/XC` only (`SEAT-FR-302`), and those measure **100.0%**. `SEAT-FR-303` explains that ownership and exclusion requirements are verified by the absence of a capability. Judging the document against a promise it explicitly did not make would be inventing a gate. The genuinely thin sub-registers are raised as LOW `RQ-2`/`RQ-3` instead |
| `RQ-R6` | *"`SEAT-GAP-003` (`Q-01`) leaves membership-expiry seat release unspecified — Stage 4 cannot pass with an open behavioural question."* | Already verified as open/non-blocking in [`PRD-007_INDEPENDENT_GAP_VERIFICATION.md`](PRD-007_INDEPENDENT_GAP_VERIFICATION.md) and carried at Stage 3. `Q-01` is Open at Rank 1 (`MASTER_PRD.md:673`) and Rank 4 (BC Map L540); deciding it here would silently amend a Rank 1 register — the failure `PRD_LIFECYCLE.md` L177 prohibits and that `ADR-0019` §3.3 refused for this same question. `SEAT-FR-155` flags without releasing, so V1 is correct under either resolution. `PRD-005` was frozen carrying the identical `MM-GAP-001`. Stage 4's gate is *"conflicts closed **or explicitly deferred with a reason and an owner**"* — this one is deferred, with both |

---

## 12. Requirement and acceptance-criteria coverage

### 12.1 Registers — declared, measured, contiguous

| Register | Count | Max | Contiguous | Duplicates |
|---|---|---|---|---|
| `SEAT-FR` | 304 | 304 | ✅ | 0 |
| `SEAT-BR` | 45 | 45 | ✅ | 0 |
| `SEAT-INV` | 14 | 14 | ✅ | 0 |
| `SEAT-EVT` | 4 | 4 | ✅ | 0 |
| `SEAT-XC` | 22 | 22 | ✅ | 0 |
| `SEAT-PO` | 24 | 24 | ✅ | 0 |
| `SEAT-CFG` | 18 | 18 | ✅ | 0 |
| `SEAT-NFR` | 12 | 12 | ✅ | 0 |
| `SEAT-AC` | 225 | 225 | ✅ | 0 |
| `SEAT-GAP` | 14 | 14 | ✅ | 0 |

Declared == measured == maximum for all ten. No identifier lacks a definition site; none is defined twice.

*(Mechanical prefix registration in `TRACEABILITY_MATRIX.md` is **Stage 5** and was not performed.)*

### 12.2 Acceptance-criteria coverage

| Direction | Result |
|---|---|
| AC → requirement (orphan check) | **225 / 225 = 100%**, 0 orphans |
| `SEAT-BR` → AC | **45 / 45 = 100.0%** |
| `SEAT-INV` → AC | **14 / 14 = 100.0%** |
| `SEAT-EVT` → AC | **4 / 4 = 100.0%** |
| `SEAT-XC` → AC | **22 / 22 = 100.0%** |
| `SEAT-FR` → AC | 216 / 304 = 71.1% |
| `SEAT-CFG` → AC | 14 / 18 = 77.8% |
| `SEAT-NFR` → AC | 5 / 12 = 41.7% |
| `SEAT-PO` → AC | 6 / 24 = 25.0% |
| **`SEAT-FR-302` promise (BR+INV+EVT+XC)** | **85 / 85 = 100.0% — met exactly** |
| Failure-outcome criteria | 121 / 225 = 53.8% |

### 12.3 Reproducible commands

```bash
# PRD integrity
sha256sum docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md
# expect 623b8945ba03161fda507137315ee04f64cd72e99af9c08036a7441243be386a

# Register counts (repeat per prefix)
grep -oE 'SEAT-FR-[0-9]{3}' docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md | sort -u | wc -l   # 304

# Orphan acceptance criteria — every AC row must cite a requirement
grep -cE '^\| `SEAT-AC-[0-9]{3}` \|' docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md            # 225

# Configurables admitting "unset" — the RQ-1 surface
grep -nE '^\| `SEAT-CFG-[0-9]{3}`' docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md | grep -ci unset  # 1

# Modal usage
grep -o '\bMUST NOT\b' docs/30-product/seat-management/PRD-SEAT-MANAGEMENT.md | wc -l                 # 228
```

---

## 13. Regression and containment verification

### 13.1 Regression — nothing earlier was undone

| Check | Result |
|---|---|
| Stage 3 verdict still holds | ✅ All six architecture checks re-confirmed incidentally: 13 edges cited / 26 declared / 0 invented; `ID-1` scan still exactly 4 hits, all prohibitions or `BC-03` attendance sessions; no scope added beyond `MP-GBR-21`'s closed register |
| `SEAT-GAP-001` still a false positive | ✅ Not re-litigated; carried per the independent verification |
| `SEAT-GAP-003` still open, still non-blocking | ✅ Not resolved, not invented (`RQ-R6`) |
| No requirement deleted or weakened by this review | ✅ Review-only; PRD byte-identical |
| `SEAT-FR-304` capability promise | ✅ 76 checklist rows verified mechanically, 0 problems |
| Frozen documents (`PRD-004` v1.2, `PRD-005` v1.4) | ✅ Read only; unmodified |

### 13.2 Containment audit

| Check | Result |
|---|---|
| `PRD-SEAT-MANAGEMENT.md` modified | **No** — SHA-256 `623b8945…be386a` identical before and after |
| PRD status / version changed | **No** — remains **v1.0 `DRAFT`** |
| PRD frozen | **No** |
| Any other PRD modified | **No** |
| ADR created or modified | **No** |
| BC Map · Master PRD · Rulings · Dependency Matrix · EA modified | **No** |
| Library · Authentication · Student Management · Membership PRDs modified | **No** |
| `TRACEABILITY_MATRIX.md` modified (Stage 5) | **No** |
| `PRD_REGISTRY.md` · `DOCUMENTATION_BASELINE.md` · `PRD_LIFECYCLE.md` modified | **No** |
| Implementation tasks created (Stage 6) | **No** |
| Specification · API spec · DB schema · SQL · code | **None created** |
| Existing gap resolved by this review | **No** — `SEAT-GAP-003` and 12 others remain open with named owners |
| Findings corrected by this review | **No** — `RQ-1`…`RQ-4` are reported, not fixed |
| Files added | **1** — this document |

This record is a **historical validation record and is not part of the specification**, following
`DOCUMENTATION_BASELINE.md` §3.3's treatment of `PRD-004_ALIGNMENT_REPORT.md` (L160) and the eight `PRD-005` records
(L163). It confers no status.

---

## 14. Verdict

> ## **B — MINOR CORRECTIONS**

| # | Stage 4 gate check | Result |
|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** |
| 2 | Every exclusion states what must be impossible | ✅ **PASS** |
| 3 | Every configurable has a default and a range | ⚠️ **PASS with `RQ-1`** |
| 4 | Every acceptance criterion maps to a requirement | ✅ **PASS** |
| 5 | No requirement restates another PRD's | ✅ **PASS** |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** |

**Gate status.** Stage 4's gate is *"conflicts closed or explicitly deferred with a reason and an owner."* Four
findings are raised, each with a named owner and a stated basis; `SEAT-GAP-003` is explicitly deferred with both. One
finding (`RQ-1`) is a genuine contradiction and should be closed before Stage 7, since a frozen document should not
contain two `MUST` statements that disagree. None of the four requires an ADR, and none touches a ranked document.

**What the document does unusually well.** Zero orphan acceptance criteria and a source column on all 225 rows — the
exact defect `PRD-004` was flagged for. A 16-step acquisition gate applied identically across all eight acquisition
paths, with `SEAT-AC-028` asserting it. `SeatState` derived rather than stored, removing a whole class of
status-disagrees-with-facts defect. 53.8% of criteria asserting a failure outcome. A permission matrix with no
undefined cells, where `PRD-004` shipped two. And a discipline (`SEAT-BR-043`) that keeps the module from legislating
another context's semantics — which is why `Q-01` is still correctly open rather than quietly decided.

**Next stage:** Stage 5 — Traceability (mechanical prefix registration in `TRACEABILITY_MATRIX.md`). **Not started.**

**Per the mandate, no PRD was modified, no ADR was created, no architecture or governance document was touched, no
gap was resolved, no finding was corrected, and Specification, Implementation Tasks and Freeze were not started.
Stage 4 is complete and stops here.**
