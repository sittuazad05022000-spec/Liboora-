# PRD-005 — Second Independent Review

**Subject:** `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` (v1.1 `DRAFT`, 1603 lines, 120,340 bytes)
**Primary source under test:** `PRD-005_CORRECTION_REPORT.md` (404 lines) and `PRD-005_BLOCKER_ANALYSIS.md` (428 lines)
**Baseline:** HEAD `f65fd5a`, working tree clean, `BASELINE-2026-08-04-C`
**Date:** 2026-08-04
**Reviewer posture:** adversarial — the objective was to **disprove** the corrected PRD, not to confirm it

---

## 0. Verdict

> ## **B — MINOR CORRECTIONS REQUIRED**

Four findings are recorded. **None is architectural**, none requires an ADR, and none requires modifying a
frozen or ranked document — every one is repairable inside PRD-005 alone, and for the most serious of them the
repair is *exactly what frozen `PRD-004` already did*.

Per the authorising instruction, **nothing has been fixed.** This review is the only artefact produced.

| # | Finding | Area | Severity | Repairable inside PRD-005 alone? |
|---|---|---|---|---|
| **F-1** | `BC-26` is named a consumer on 6 of 7 events and in the header, but PRD-005's own closed edge list (`MM-BR-006`) contains **no edge to `BC-26`**, and the "no new edge" claim at line 1027 is **factually false** | Cross-context dependencies (4) | **Moderate** | **Yes** — frozen `PRD-004` set the no-ADR precedent (`SM-GAP-11`) |
| **F-2** | §12 asserts a *"closed set"* of 7 events but contains **no normative requirement** enforcing closure — no analogue of frozen `SM-7.12` | C-3 / event surface (2) | Minor | Yes |
| **F-3** | Line 898 (`MM-CFG-009`) permits `endDate` to be *"recomputed from the activation date"*, contradicting `MM-FR-057` and `MM-FR-058` with no reconciliation | Payment/finance boundary (9) | Minor | Yes |
| **F-4** | Acceptance-criteria coverage of comparable registers is **13.8%** against frozen `PRD-004`'s **100%**; 33 of 34 `MM-BR` and 15 of 16 `MM-XC` are unverified, which `MM-NFR-014` itself declares *unmet* | Acceptance criteria (7) | Minor | Yes |

**Areas where the attempt to disprove failed — PRD-005 is upheld:** C-2 and its `MembershipStatus` reasoning (1),
Membership vs Enrollment ownership (3), requirement/identifier integrity (5), traceability (6), V1/V2/V3 scope (8),
security/tenancy/audit (10).

---

## 0.1 Two corrections to the *previous* review's own working notes

Because the instruction was *"do not accept the previous review or correction report blindly"*, this review also
re-tested claims that the prior session had recorded as findings. **Two of them were wrong, and both are corrected
here in PRD-005's favour or against it as the evidence dictates.**

| Prior working claim | Mechanical result | Effect |
|---|---|---|
| *"The correction report's C-2 premise is weak — `AccessRole` appears **zero** times in the Authentication PRD, so equating `TR-1…TR-5` with `AccessRole` was an inference."* | **Misdirected.** PRD-005 §5.1 does **not** cite `AccessRole` or `TR-n`. It cites *"§2.2.6, §2.2.7"* and *"`BR-2.9`"*. All three verify **exactly**: `### 2.2.6 Platform Support` at L517, `### 2.2.7 Platform Administrator` at L526, and L773 `` | `BR-2.9` | Owner, Manager, Reception, and both platform roles are invite-only | `` | **In PRD-005's favour.** Its argument never depended on the type name; the "5 vs 3" count is carried by user *categories* and `BR-2.9`'s *"both platform roles"*. C-2 stands on PRD-005's own citations, without needing `REVIEW_14A` or `identity.dart` |
| *"AC coverage 24% is acceptable because frozen `PRD-004` is **0.0%**."* | **Inverted.** `PRD-004`'s AC section cites **106** distinct identifiers; on its prefixed registers it is **63/63 = 100.0%**. The "0.0%" was an artefact of a regex that missed `SM-BR-*`/`SM-XC-*` etc. | **Against PRD-005.** The precedent does not excuse low coverage — it sets a **100%** bar. This is why **F-4** is recorded rather than dismissed |

The second correction is the single most consequential result of this review: it converts what the prior pass had
filed as a benign observation into a genuine, if minor, defect.

---

## 1. Method

Every claim below was reproduced from the primary source with a command, not read from a summary.

| Check | Command class |
|---|---|
| Section numbering of the BC Map | `grep -nE '^## [0-9]+\.'` |
| BC Map §5 row decomposition | `awk -F'\|'` on line 209 / 212 |
| Complete §7 edge inventory | `grep -nE '^\| E-[0-9]+ '` over lines 290–363 |
| §9 consumer lists | `grep -n 'BC-26'` over the whole map |
| Closure / ADR-trigger census | `grep -nE 'closed at\|requires an ADR\|new event'` |
| Register census + contiguity | Python over all `MM-[A-Z]+-\d+` |
| AC coverage, both PRDs | Python, section-scoped, like-for-like registers |
| Frozen-document integrity | `git diff HEAD --stat` over ranked paths |

**Constraint compliance for this review:** PRD-005 **not modified** · no frozen or ranked document modified
(`git diff HEAD` over `docs/10-architecture/`, `docs/00-governance/`, `docs/30-product/student-management/` and
`docs/30-product/authentication/` is **empty**) · **no ADR created or accepted** (ADR count remains **18** plus
`ADR-INDEX.md` = 19 files) · **no code modified** · exactly **one** file created, this one.

---

## 2. Area 1 — C-2, BC Map §5 and `MembershipStatus` → **UPHELD**

### 2.1 The claim under test

PRD-005 `MM-FR-072` defines `MembershipStatus` as six values — `PendingPayment`, `Scheduled`, `Active`, `Expired`,
`Superseded`, `Cancelled` — where BC Map line 209 glosses `BC-02` as `Valid/Expired/Frozen`. C-2 was ratified as
*compliant, not a conflict*.

### 2.2 Reproduction

Line 209 decomposes into four columns:

| Col | Content |
|---|---|
| 1 | `**Status**` |
| 2 | `BC-01: Active/Inactive/Suspended/Archived enrollment state` |
| 3 | `BC-02: Valid/Expired/Frozen membership state` |
| 4 | `` `EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can be Active with an Expired membership. `` |

Header (L197): `| Ambiguous word | Context A meaning | Context B meaning | Resolution (binding) |`.
Preamble (L195), verbatim: *"Each row is a word that means **different things in different contexts**… The
resolution column is binding: these are the names that must appear in code, APIs, events and UI copy."*

So the binding artefact is **column 4**. It requires (a) the type name `MembershipStatus`, (b) independence from
`EnrollmentStatus`, (c) the case *Active enrollment + Expired membership* be representable. PRD-005 satisfies all
three — `MM-FR-072` names the type, `MM-XC-002`/§1.3 assert independence, `MM-FR-065` preserves the case.

### 2.3 Attempted disproof 1 — is column 3 an enumeration after all?

The falsification test is the sibling `Role` row at L212, whose column 2 reads
`BC-18: a permission bundle (Owner/Manager/Reception)` — **three** values. If per-context columns closed value sets,
a Rank 3 PRD naming more would be in breach. Reproduced:

```
517:### 2.2.6 Platform Support
526:### 2.2.7 Platform Administrator
773:| `BR-2.9` | Owner, Manager, Reception, and both platform roles are invite-only |
```

Five user categories in the role space where L212 glosses three, and `BR-2.9` speaks of *"both platform roles"* as
first-class. The Rank 3 Authentication PRD is **not** in breach. Therefore column 3 illustrates meaning and does not
close a set. **H₀ falsified. The disproof fails.**

*(Independent corroboration exists but is not needed: `docs/30-product/library/REVIEW_14A.md` L376 records
`` `AccessRole` 5 `` as a closed register, and `lib/platform/identity/identity.dart` L14 ships
`enum AccessRole { owner, manager, reception, student, parent }` — 5 values against the Map's 3.)*

### 2.4 Attempted disproof 2 — does Rank 2 bind the values?

`ADR-0018` outranks the BC Map and cites line 209. If it adopted the value set, C-2 would collapse. It does not.
§2.4 (L73–78) cites L209 solely for *"Two independent state machines"* and concludes: **"`PRD-004` owns no
membership state."** No Rank 1 or Rank 2 document enumerates `MembershipStatus`. **Disproof fails.**

### 2.5 Attempted disproof 3 — is `PendingPayment` an invention?

No. `E-10` (L307): *"`FeePaymentReceived` → may activate a **pending** membership (saga in V2, direct handler in
V1)"*, and §9 L421 gives that event the purpose *"**Activates membership**, receipt"*. `Valid/Expired/Frozen` cannot
represent *"a pending membership"*. A pre-activation state is **required by Rank 4 itself**. Symmetrically, `Frozen`
is unreachable in V1 because Membership Freeze is **V2** (EA L728) and its stated purpose is *"Proration + seat
hold"* with Proration also **V2** (EA L731) — reading column 3 as the V1 set would mandate a V1 status reachable
only by a V2 feature. `MM-FR-073` correctly forbids it while allowing later modelling.

### 2.6 Result

**C-2 is correctly closed. No ADR is required and the BC Map rightly remains unmodified.** The residual observation
carried as `MM-GAP-006a` (annotate §5's columns *"illustrative, not exhaustive"*; name a `BC-02` pre-activation
state given `E-10`) is properly directed at the Rank 4 owner and properly marked non-blocking.

---

## 3. Area 2 — C-3, event additions and the §9 event surface → **REASONING UPHELD, ONE DEFECT (F-2)**

### 3.1 The §8 → §9 correction is right

Authoritative numbering, reproduced by `grep -nE '^## [0-9]+\.'`: **§8 = Aggregate & Invariant Register (L364)**,
**§9 = Published Language — Event Surface (L397)**. The event surface is §9. The correction is correct.

Worth recording: frozen `PRD-004` §7.4 (L776) cites *"BC Map **§8** convention"* for the event surface — the
identical mis-citation. It is in a **frozen** document and is out of scope here; noted only so the correction is not
mistaken for a divergence from precedent.

### 3.2 The closure argument survives

Two censuses were run against the BC Map:

- **Closure markers.** The only *"closed set"* in the entire map is L429 — `` | BC-10 | *(full register)* | — | `SEV-1`…`SEV-16` — closed set, see Student Identity PRD §4.14 | `` — and it closes the register by **delegating to that context's Rank 3 PRD**. `BC-02` carries no such marker.
- **ADR triggers.** Exactly one, L292: *"Every edge that crosses a context boundary in V1. If an edge is not in this table, it **does not exist** and adding it requires an ADR."* Scoped to **edges**, in **§7**.

§9's own preamble (L399) self-describes as *"the **seed of the full Event Catalog** (open action item #4…) — names,
producers and consumers are fixed here; payload schemas and versioning belong in the catalog."* *"Names… are fixed"*
binds **spelling**, not cardinality. And the precedent is decisive: frozen `PRD-004` §7.4 registers **ten** `BC-01`
events (`SM-EV-1`…`SM-EV-10`) where §9 lists **four** (L405–406), ratified by `ADR-0018` with no BC Map amendment.

Per-event sourcing also verifies. `MembershipUpgraded` is **already in the Map** — `E-07` (L304):
*"`MembershipCreated/Renewed/Upgraded/Frozen` → generates or adjusts `FeeDue`"* — so its absence from §9 is an
internal Rank 4 omission. `MembershipActivated` follows `E-10`/L421. `MembershipVoided` follows §5.4. Excluding
`Frozen`/`Unfrozen` (§9 L413) is correct: both are V2. **The additions are sourced, not invented.**

### 3.3 F-2 — the closure claim is not enforceable

§12's heading reads *"Domain Events — `MM-EVT-001` … `MM-EVT-007`, closed set"*, and §0.2 declares the count as 7.
But the closure is **asserted, never required**:

```
$ grep -nE 'MM-(BR|FR)-[0-9]+.*(closed at|requires an ADR|new event)' PRD-MEMBERSHIP-MANAGEMENT.md
(exit 1 — no match)
```

The three surviving matches for *"requires an ADR"* (L308, L921, L1025) are all **quotations of BC Map L292 about
edges**, not obligations on this register. Frozen `PRD-004` shows precisely what is missing — `SM-7.12` (L817):

> `` `SM-7.12` — This set **MUST** be closed at **ten** events. A new event requires an ADR. ``

PRD-005 has no analogue. By its own `MM-NFR-014` — *"a rule that cannot be checked is **unmet**, not satisfied by
intent"* (`SID-4.56`) — an unenforced closure claim is unmet. **F-2: minor, and repairable by adding one `MM-BR-*`
sentence.**

---

## 4. Area 4 — Cross-context dependencies → **F-1, the most serious finding**

This area was examined by extracting the **entire** §7 edge table mechanically rather than trusting PRD-005's list.

### 4.1 The ten declared edges are all accurate

Every edge in PRD-005's `MM-BR-006` table (`E-01`, `E-02`, `E-03`, `E-07`, `E-10`, `E-17`, `E-18`, `E-19`, `E-20`,
`E-23`) matches §7 in direction, pattern and mechanism. `MM-BR-007` (the `E-02`/`E-03` block-vs-flag asymmetry),
`MM-BR-008` (no `BC-06` → `BC-02`) and `MM-BR-009` (`E-21` names only `BC-01` and `BC-10`) all verify. **No
invented edge.** This is a genuinely strong section — which is what makes the exception below stand out.

### 4.2 `BC-26` has exactly one inbound edge, and it is not from `BC-02`

```
$ grep -n 'BC-26' <§7 edge table, lines 290-363>
335:| E-26 | BC-27 AI | BC-26 Analytics, BC-23 Search | `CF` | Sync port | …
```

`BC-26`'s **only** inbound edge in the whole of §7 is `E-26`, from `BC-27` AI. There is **no `BC-02` → `BC-26`
edge**, and no `BC-01` → `BC-26` edge either.

### 4.3 Yet PRD-005 publishes to `BC-26` in eight places

```
15:| **Publishes to** | … `BC-26` Analytics · `BC-22` Notification |
984:| MM-EVT-001 | … | `BC-05`, `BC-04`, `BC-26`, `BC-22` | …
985:| MM-EVT-002 | … | `BC-04`, `BC-03`, `BC-26`, `BC-22` | …
986:| MM-EVT-003 | … | `BC-05`, `BC-26`, `BC-22` | …
987:| MM-EVT-004 | … | `BC-05`, `BC-04`, `BC-26`, `BC-22` | …
988:| MM-EVT-005 | … | `BC-04`, `BC-26`, `BC-22` | …
990:| MM-EVT-007 | … | `BC-05`, `BC-26`, `BC-24` | …
```

Six of seven events, plus the document header. This is in direct tension with PRD-005's own **`MM-BR-006`**:
*"This module **MUST NOT** use any integration edge not listed below"* — and `BC-26` is not in that list.

### 4.4 The "no new edge" claim at line 1027 is factually false

The C-3 ratification rests partly on this sentence:

> *"These three events introduce **no new edge**: `BC-05`, `BC-04`, `BC-03`, `BC-26`, `BC-22` and `BC-24` are all
> reachable on existing `E-07`, `E-02`, `E-03`, `E-20` and `E-23`."*

Reproduced destinations:

```
299:| E-02 | BC-02 Membership | BC-04 Seating          | …
300:| E-03 | BC-02 Membership | BC-03 Attendance       | …
304:| E-07 | BC-02 Membership | BC-05 Fee & Collection | …
329:| E-20 | All contexts     | BC-24 Audit Trail      | …
332:| E-23 | All contexts     | BC-22 Notification Delivery | …
```

`BC-05` ✅ `BC-04` ✅ `BC-03` ✅ `BC-24` ✅ `BC-22` ✅ — and **`BC-26` ✗**. **Not one of the five cited edges
terminates at `BC-26`.** The claim is true for five of six named contexts and false for the sixth. Because L292's
ADR trigger *is* scoped to edges, this is the one place in the C-3 argument where the trigger genuinely could bite.

### 4.5 Mitigation — and why it is nevertheless a defect

In fairness, BC Map **§9 itself** names `BC-26` a consumer of `BC-02` events (L409, L410, L412, L413). So PRD-005 is
consistent with Rank 4 §9 while inconsistent with Rank 4 §7. That is a **tension internal to the BC Map**, not one
PRD-005 created.

But the repository has already ruled on this exact tension. Frozen `PRD-004` §7.4 (L799–815), verbatim:

> *"**`BC-26` Study Analytics** — BC Map §8 names `BC-26` a primary consumer of `enrollment.StudentEnrolled` and
> `enrollment.StudentProfileUpdated`, while BC Map §7 declares no `BC-01`→`BC-26` edge (`BC-26`'s only inbound edge
> is `E-26` from `BC-27`). BC Map line 292 states that an edge absent from §7 "does not exist" and that adding one
> requires an ADR. That is a **tension internal to the Bounded Context Map (Rank 4)**, not a decision this document
> may take: `BC-26` is therefore **not listed as a consumer here**, and this module emits nothing additional for it.
> Recorded as **`SM-GAP-11`** for the architecture owner."*

The frozen sibling met the identical situation, **declined to list `BC-26`**, and raised a gap. PRD-005 lists it
eight times, asserts reachability that does not exist, and never mentions the tension:

```
$ grep -c 'SM-GAP-11' PRD-MEMBERSHIP-MANAGEMENT.md
0
```

Under `DOCUMENTATION_BASELINE.md` §4 — *"**A conflict is a defect.** If you find one, do not choose — raise it"* —
PRD-005 has chosen where its frozen sibling raised.

### 4.6 Why this is B and not C

No ADR is needed and no architecture changes: the precedent supplies a no-ADR repair entirely inside PRD-005 —
remove `BC-26` from the header and the six event rows (or annotate it as unreachable pending the Rank 4 tension),
correct the line-1027 reachability sentence to the five contexts that actually verify, and record the tension as a
new `MM-GAP-*` cross-referencing `SM-GAP-11`. The event set, the model, the invariants and every other edge are
untouched. **Moderate severity, minor blast radius.**

---

## 5. Area 3 — Membership vs Enrollment ownership → **UPHELD**

The boundary is clean and, unusually, defended at the projection rather than the record.

- `MM-BR-010` — profile and enrollment relationship → `BC-01`; **membership lifecycle and entitlement → `BC-02`**.
- `MM-BR-021` — the aggregate **MUST NOT** contain any field owned by `BC-01`, `BC-10`, `BC-05`'s ledger, `BC-03` or `BC-04`. The §13.1 field table bears this out: `studentRecordId` is owned by `BC-01`, `tenantId` by `BC-19`, `branchId` by `BC-06`, `paymentReference` by `BC-05` and is explicitly *"Opaque; **not** an amount or ledger entry"*.
- `MM-FR-077` — a student suspension (`E-01`) **MUST NOT** change `MembershipStatus`; it suppresses the projection to `isValid: false` without mutating the record.

The attempted disproof was that `MM-FR-077` under-delivers on `PRD-004` L288 (*"`BC-02` Membership MUST react by
refusing new seat…"*). It fails: the ranked requirement is to **refuse entitlement**, which suppression achieves,
and PRD-005's rationale is the stronger reading — mutating status would destroy a paid term irreversibly.
`MM-FR-076` aligns with `SM-2.7` on storing and displaying the two statuses separately. **Upheld.**

---

## 6. Area 5 — Requirement and identifier integrity → **UPHELD**

Full census reproduced in Python over all `MM-[A-Z]+-\d+[a-z]?` occurrences:

| Register | Count | Max | Gaps |
|---|---|---|---|
| `MM-FR` | 118 | 118 | none |
| `MM-BR` | 34 | 34 | none |
| `MM-XC` | 16 | 16 | none |
| `MM-NFR` | 14 | 14 | none |
| `MM-INV` | 12 | 12 | none |
| `MM-PO` | 11 | 11 | none |
| `MM-GAP` | 11 | 9 (+`006a`,`007a`) | none |
| `MM-CFG` | 9 | 9 | none |
| `MM-EVT` | 7 | 7 | none |
| `MM-AC` | 58 | 58 | none |
| **Total** | **290** | | **zero gaps, zero duplicates** |

§0.2 declares *"**Total: 290 identifiers**, of which **279 carry obligation** and 11 are `MM-GAP-*`"*. 290 − 11 =
279 ✅. The `MM-GAP-n` row declares **11** and documents the suffix convention for `006a`/`007a` — retaining closed
numbers so prior citations stay resolvable, rather than renumbering. Every count matches ground truth. **Upheld.**

---

## 7. Area 6 — Traceability → **UPHELD**

- All identifiers referenced by acceptance criteria resolve to definitions in this document; no dangling reference.
- `MM-BR-030` is defined once in §9 and the §14.1 occurrence is explicitly marked *"Restated from §9, which is the definition site"* — no duplicate definition.
- The four gap cross-references that pointed at renumbered targets (L369–370, `MM-FR-054`, §5.3, §24.1) resolve correctly at v1.1.
- Frozen `PRD-004` traceability is untouched: `prd004_traceability.py` → `TOTAL 251 218 9 13` (227/240 = 94.6%), matching `ADR-0018` §2.

---

## 8. Area 7 — Acceptance criteria → **F-4**

58 criteria, `MM-AC-001`…`MM-AC-058`, contiguous, **zero empty *Verifies* fields**. Structurally sound. The problem
is coverage, and it only becomes visible when the frozen precedent is computed rather than assumed.

**All registers:** 62 of 221 obligation-bearing identifiers are cited by an AC = **28.1%**.

**Like-for-like against frozen `PRD-004`** (business rules, invariants, policy obligations, exclusions, events —
excluding the `FR` register, which `PRD-004` does not use):

| | Covered / total | Coverage |
|---|---|---|
| **PRD-005** (`MM-BR`,`MM-INV`,`MM-PO`,`MM-XC`,`MM-EVT`) | **11 / 80** | **13.8%** |
| **Frozen `PRD-004`** (`SM-BR`,`SM-INV`,`SM-PO`,`SM-XC`,`SM-EV`) | **63 / 63** | **100.0%** |

Per-register detail for PRD-005: `MM-BR` **1/34** · `MM-XC` **1/16** · `MM-INV` **2/12** · `MM-PO` **2/11** ·
`MM-EVT` 5/7 · `MM-NFR` 5/14 · `MM-CFG` 2/9 · `MM-FR` 44/118.

Thirty-three of thirty-four business rules and fifteen of sixteen scope exclusions have **no** verifying criterion —
including `MM-BR-020` (aggregate/transaction boundary), `MM-BR-023` (the `X-13` tenant-key rule enforced by
`ADR-0014`) and `MM-BR-024` (no hard deletes). PRD-005's own `MM-NFR-014` settles how to score this:

> *"Every rule in this document **MUST** be falsifiable by a test. Per `SID-4.56`, a rule that cannot be checked is
> **unmet**, not satisfied by intent."*

By that standard the majority of PRD-005's normative rules are currently **unmet**, and the frozen sibling
demonstrates 100% is achievable at this scale. **F-4: minor — additive AC work, no model change.**

---

## 9. Area 8 — V1 / V2 / V3 scope → **UPHELD**

§22 was checked line-by-line against EA L718–735. Exact correspondence: Plans / Creation / Renewal / Upgrade **V1**;
Downgrade, Freeze (L728), Transfer, Cancellation, Proration (L731), History **V2**; Auto Renewal and Analytics
(L734) **V3**; Cross-Library **Future**. Master PRD L158 confirms `| 6 | Membership Management | BC-02 Membership |
[CORE] | V1 |`. Nothing is pulled forward.

The two scope-boundary judgements were probed and both hold. §5.4 (voiding a `PendingPayment`/`Scheduled` membership)
is **not** V2 Membership Cancellation — no refund, no `Active` membership, and without it a mis-keyed membership
blocks the correct one forever via `MM-INV-001`; correctly separated by `MM-FR-079`/`MM-XC-011`. And the EA's own
V2/V3 self-contradiction on Membership Analytics (L734 vs L837 vs L1607) is **disclosed** as C-1 and left to the EA
owner — the right move, since EA is Rank 6 *descriptive* and `MP-CON-08` makes EA disagreement *"a defect to be
raised"*. All three readings agree it is not V1, so PRD-005 is unaffected either way.

---

## 10. Area 9 — Payment / finance boundary → **F-3**

### 10.1 The boundary itself is correct

`MM-BR-003` — this module emits events so `BC-05` can raise a `FeeDue` via `E-07`, and **MUST NOT** create the
`FeeDue` itself. `priceSnapshot` is a snapshot, not a ledger entry; `paymentReference` is opaque. `MM-BR-004`'s
reconciliation queue is not invented — BC Map §10 L465 mandates *"a visible reconciliation queue for failures —
deliberately not hidden behind a fake atomic button"*, with the saga deferred to V2 (`BC-28`, confirmed V2 at BC Map
L137). §10.2's six failure rows are deterministic, and *"Payment received for a voided membership"* correctly refuses
activation and refuses to initiate the refund. This section is the document's strongest.

### 10.2 F-3 — one row contradicts §4.3

Line 898, *"Payment confirmation delayed"*, verbatim:

> *"…if `startDate` has passed it activates with the **original** `startDate` — the student is not charged days they
> could not use, so `endDate` **MUST** be recomputed from the activation date if `MM-CFG-009` is enabled; otherwise
> the original term stands"*

Against §4.3:

- `MM-FR-057` — `` endDate **MUST** be computed as `startDate + (durationDays − 1)` ``
- `MM-FR-058` — *"The computation **MUST** be a pure function of (`startDate`, `durationDays`, tenant timezone). It **MUST NOT** depend on the current clock…"*

An `endDate` recomputed from the activation date is a function of **when the payment arrived** — i.e. of the clock —
and no longer equals `startDate + (durationDays − 1)` while `startDate` is held at its original value. When
`MM-CFG-009` is enabled, `MM-FR-057` and `MM-FR-058` are both violated. §4.3 grants no exemption:

```
$ grep -n 'MM-CFG-009' PRD-MEMBERSHIP-MANAGEMENT.md
898, 1098, 1112, 1370      # §10.2, §13.4 heading, §13.4 row, §21 — never in §4.3
```

Two mitigations, neither sufficient. The default is `false` (L1112), so the shipped configuration is consistent —
but the PRD still defines a *permitted* configuration that breaks its own normative invariant, which is exactly what
`MM-NFR-014` forbids leaving unresolved. And the prose is internally strained regardless: *"activates with the
**original** `startDate`"* followed by *"so `endDate` **MUST** be recomputed from the activation date"* is a
non-sequitur — the stated goal (not charging for unusable days) is achieved by moving `startDate`, not by holding it
and moving only `endDate`, which silently lengthens the term beyond `durationDays`.

**F-3: minor** — resolvable by an explicit exemption in §4.3 stating that `MM-CFG-009` re-derives the term from a new
effective `startDate` (preserving `MM-FR-057`'s formula and purity), or by deleting `MM-CFG-009` and deferring the
question. Either is a local edit.

---

## 11. Area 10 — Security, tenancy and audit → **UPHELD**

- **Tenancy.** `MM-BR-023` — every table **MUST** carry `tenantId` in its primary or unique key, per `X-13`, enforced by `ADR-0014`. `tenantId` is immutable and *"Must equal ambient `TenantContext`"* (§13.1). `E-18` carries it as **ambient context, never a domain method parameter** — matching BC Map §11's `SK` pattern.
- **Authorisation.** Not modelled here. §11.2 routes it to `BC-18`; the 11 `MM-PO-*` obligations state *what* must be authorised without inventing roles or permissions. `MM-NFR-008` keeps the payment gate separate from the entitlement gate.
- **Audit.** Emitted via `E-20`, *"outbox-backed"*, and `MM-BR-006`'s table records *"never synchronous"* — matching BC Map L329 (*"Domain never calls audit synchronously"*). Void reasons are captured (`voidReason`/`voidedBy`, write-once, required when `Cancelled`). No PII is placed in event payloads.
- **Deletion.** `MM-BR-024` — membership records **MUST NOT** be hard-deleted; terminal states are the retirement path. Consistent with `ADR-0014`'s mutation-enforcement stance.
- **Concurrency (§15).** Twelve scenarios with deterministic outcomes; `MM-NFR-001` requires optimistic `version` concurrency *plus* database-level overlap and idempotency constraints — enforcement by constraint, not by read-check. Idempotency is required on both `idempotencyKey` and `paymentReference`, so a duplicate callback cannot double-activate. Genuinely rigorous.

---

## 12. Governance and lifecycle checks

| Check | Result |
|---|---|
| PRD-005 status | **`DRAFT`**, Stage 2. `PRD_REGISTRY.md` L225 shows `PRD-005` = **`PLANNED`** — correctly not claiming a frozen or baselined row |
| Freeze claimed? | **No.** §25.4: *"Freeze is **conferred, not claimed**"* |
| Ranked documents modified? | **None.** `git diff HEAD` over all ranked paths is empty; the BC Map is byte-identical |
| ADRs | **18** + `ADR-INDEX.md`. None created; none accepted |
| Conflicts silently resolved? | No. §25.1 records seven and marks which block |
| §25.3 self-assessment accuracy | Accurate on registers, terminology and ownership. **One line is now stale:** *"Conflicting requirements — **7 recorded**… **2 block freeze**"*. C-2 and C-3 were the two blockers and both are now closed, so the correct statement is *7 recorded, 0 blocking* — with F-1/F-3 being newly identified, not previously counted. Editorial, folded into F-1's repair |

---

## 13. What survived the attempt to disprove

Recorded explicitly so the four findings are not read as a general indictment. The following were attacked and held:

1. **C-2's §5 reading** — and on PRD-005's *own* citations (§2.2.6, §2.2.7, `BR-2.9`), which verify exactly.
2. **No Rank 1/Rank 2 document enumerates `MembershipStatus`** — `ADR-0018` cites L209 only for the two state machines.
3. **`PendingPayment` is recovered from Rank 4**, not asserted against it (`E-10`, §9 L421).
4. **`Frozen`'s exclusion is correct** — V2 by EA L728/L731.
5. **§9 declares closure only for `BC-10`** (L429), by delegation to a Rank 3 PRD.
6. **The sole ADR trigger (L292) is edge-scoped**, and the `PRD-004`/`ADR-0018` precedent (10 events vs §9's 4) is exact.
7. **Ten of ten declared edges verify** against §7 in direction, pattern and mechanism.
8. **Ownership boundary is clean**, and suppression-not-mutation is the stronger reading of `PRD-004` L288.
9. **290 / 279 / 10 registers, zero gaps, zero duplicates.**
10. **§22 scope matches EA L718–735 exactly**; Master PRD L158 verifies.
11. **Payment boundary, reconciliation queue and idempotency are correct and correctly sourced.**
12. **Security, tenancy and audit are rigorous**; nothing outside `BC-02` is written.
13. **No ADR was created; the BC Map was not modified; freeze was not claimed.**

---

## 14. Conclusion

The corrected PRD-005 is a strong document. Its two headline ratifications — **C-2** and **C-3** — survive
independent adversarial testing, and C-2 survives on its own citations rather than on the correction report's
looser framing. Its edge discipline, ownership boundary, payment boundary, concurrency model and identifier
integrity all reproduce cleanly from primary sources.

It is not yet ready to freeze. One finding is substantive: PRD-005 publishes to **`BC-26`** in eight places while
its own closed edge list contains no such edge, and it supports this with a reachability claim that is **false for
`BC-26`** against BC Map §7 — where the ADR trigger genuinely applies. Its frozen sibling met the identical tension,
**refused to list `BC-26`**, and raised `SM-GAP-11`; PRD-005 chose instead, and never mentions the tension. Three
smaller findings follow: an unenforceable event-closure claim, a configurable that contradicts the term-calculation
invariant, and acceptance-criteria coverage of **13.8%** where the frozen precedent achieves **100%**.

All four are repairable inside PRD-005 alone, with no ADR, no BC Map amendment and no change to any frozen document.

> ## Verdict: **B — MINOR CORRECTIONS REQUIRED**

**Per the authorising instruction, nothing has been fixed.** No file was modified; this review is the only artefact
created. PRD-005 remains at v1.1 `DRAFT` / `PLANNED`, and HEAD remains `f65fd5a` plus this document.

### Recommended repair order, if and when correction is authorised

1. **F-1** — remove `BC-26` from the header and the six event rows (or mark it unreachable pending the Rank 4 tension); correct the line-1027 reachability sentence to the five contexts that verify; raise a new `MM-GAP-*` cross-referencing `SM-GAP-11`; refresh the §25.3 *"2 block freeze"* line.
2. **F-3** — add an explicit §4.3 exemption reconciling `MM-CFG-009` with `MM-FR-057`/`MM-FR-058`, or delete `MM-CFG-009`.
3. **F-2** — add one `MM-BR-*` requiring the event set to be closed at seven, with the trigger for extension stated.
4. **F-4** — extend the AC register toward the `PRD-004` precedent, prioritising `MM-BR` and `MM-XC`.

---

## 15. Document control

| Field | Value |
|---|---|
| Document | `PRD-005_SECOND_INDEPENDENT_REVIEW.md` |
| Reviewed | `PRD-MEMBERSHIP-MANAGEMENT.md` v1.1 `DRAFT` at HEAD `f65fd5a` |
| Primary sources | BC Map (Rank 4) · `MASTER_PRD.md` (Rank 1) · `ADR-0018` (Rank 2) · `Student_Management_PRD_v1.md` v1.2 FROZEN (Rank 3) · `Authentication_PRD_v2.md` (Rank 3) · `LIBOORA_ENTERPRISE_ARCHITECTURE.md` (Rank 6) · `DOCUMENTATION_BASELINE.md` · `PRD_REGISTRY.md` · `PRD-005_CORRECTION_REPORT.md` · `PRD-005_BLOCKER_ANALYSIS.md` · `REVIEW_14A.md` · `lib/platform/identity/identity.dart` |
| Areas mandated | 10 |
| Areas upheld | 6 |
| Findings | 4 (0 architectural, 1 moderate, 3 minor) |
| Prior-review claims overturned | 2 (§0.1) |
| Verdict | **B — MINOR CORRECTIONS REQUIRED** |
| Corrections applied | **None** — forbidden by the instruction for verdict B |
