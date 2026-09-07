# `PRD-004` — Second Independent Review (Final Pre-Freeze Review)

| Field | Value |
|---|---|
| **Document** | Second Independent Review of [`Student_Management_PRD_v1.md`](Student_Management_PRD_v1.md) (`PRD-004`, `BC-01` Enrollment) |
| **Version** | v1.0 |
| **Status** | Audit record. **Not ranked**, therefore editable without an ADR. Carries no requirements |
| **Date** | 2026-08-04 |
| **Reviewed commit** | **`a030b078982c446f8d73bda9cba559aceddc6122`** — verified live, working tree clean |
| **Review board** | 6 personas — 1 Principal Product Architect · 2 DDD / Bounded Context Architect · 3 Requirements & Traceability Auditor · 4 Enterprise SaaS Architect · 5 QA / Acceptance Criteria Architect · 6 Governance & Documentation Auditor |
| **Predecessor** | [`PRD-004_INDEPENDENT_REVIEW_REPORT.md`](PRD-004_INDEPENDENT_REVIEW_REPORT.md) — 21 findings, verdict **C** · [`PRD-004_CORRECTION_REPORT.md`](PRD-004_CORRECTION_REPORT.md) — verdict **B, needs another review** |
| **Mandate** | AUDIT ONLY. No document was modified. No correction was made. `PRD-004` was **not** frozen |
| **Method** | Live repository inspection. The two predecessor reports were treated as **hypotheses to be tested**, never as evidence |
| **Governing principle** | `SID-4.56` — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* Applied to this report as much as to the PRD |
| **Precedence** | Below every document it cites. Where this report disagrees with a ranked document, **the ranked document is right and this report is the defect** |

---

## 1. Executive Verdict

**Verdict: B — MINOR CORRECTIONS REQUIRED.**

`PRD-004` is **materially sound**. The three HIGH findings of the first review are genuinely resolved, and the resolutions survive independent challenge. The document is architecturally valid, its ownership boundaries hold, its state machines are correctly separated, and its central architectural claim — that the Library Members Directory is an application-layer read composition rather than a new bounded context — is **correct**, though its *citation* is imprecise.

I actively attempted to disprove the corrected PRD and produced **17 findings**, of which **0 are CRITICAL**, **2 are HIGH**, **7 are MEDIUM**, **5 are LOW** and **3 are OBSERVATIONS**. None is an architectural blocker. None requires an ADR *caused by* `PRD-004`.

The two HIGH findings are:

- **`SR-01`** — Two supporting documents inside the `PRD-004` ecosystem are **stale after the correction pass**: `TRACEABILITY_MATRIX.md` §2C still records 242 identifiers / 9 events / 28 criteria, and `PRD-004_IMPLEMENTATION_TASKS.md` still stops at `IMPL-317` while the PRD runs to `IMPL-323`. `PRD_LIFECYCLE.md` Stage 5 makes matrix registration a **freeze gate**, so this one blocks freeze on its own terms. Both documents are unranked and correctable without an ADR.
- **`SR-02`** — Three requirements are written as **`No X MUST Y`**, which in the normative vocabulary the PRD itself defines in §0.1 states the *opposite* of the intent. `SM-10.9` literally reads *"No endpoint **MUST** accept `tenant_id` as an authorisation input"* — a tenant-isolation requirement rendered permissive. This is a grammar defect, not a design defect, but it lands on `X-13`.

Everything else is smaller: an over-claimed `AR-1` precedent that is rescued by a *higher-ranked* authority the PRD already cites; a missing `BC-26` consumer; two acceptance criteria citing the wrong requirement; two DOB paths with no acceptance criterion; and a §2.4/§2.2 section miscitation repeated in three places.

**The correction pass did not introduce an architectural regression, did not weaken enforcement, and did not inflate its own metrics.** On the last point the evidence is unusually clean: the traceability figure moved *down*, from a withdrawn 96.3% to a measured 92.9%, and I reproduced 221/238 independently.

---

## 2. Repository State

Verified live, not taken from either predecessor report.

| Check | Command | Result |
|---|---|---|
| HEAD commit | `git log -1 --format=%H` | **`a030b078982c446f8d73bda9cba559aceddc6122`** |
| Commit subject | — | *"docs: PRD-004 controlled correction — 3 HIGH findings resolved, no ADR required"* |
| Commit date | — | `2026-08-08 17:58:43 +0000` |
| Working tree | `git status --porcelain` | **empty — clean** |
| Branch | — | `main` |
| Claimed correction commit | Correction report §12 | `a030b07…` — **matches HEAD exactly** |

**The commit under audit is the commit that is live.** No drift, no uncommitted work, nothing staged.

### 2.1 Frozen / ranked document integrity

Diffed against `1922f8d` (the pre-correction baseline), which is the only baseline that answers the question *"did the correction pass touch anything it was forbidden to touch?"*

| Document | Rank | Result |
|---|---|---|
| `docs/30-product/MASTER_PRD.md` | 1 | **OK unchanged** |
| `docs/30-product/student-identity/Student_Identity_PRD_v1.md` | 3 | **OK unchanged** |
| `docs/30-product/authentication/Authentication_PRD_v2.md` | 3 | **OK unchanged** |
| `docs/30-product/library/Library_PRD_v1.md` | 3 | **OK unchanged** |
| `docs/10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md` | 4 | **OK unchanged** |
| `docs/10-architecture/ARCHITECTURE_RULINGS.md` | 5 | **OK unchanged** |
| `docs/20-configuration/CONFIGURATION_GUIDE.md` | 7 | **OK unchanged** |
| `tool/module_dependencies.yaml` | 4 (Matrix) | **OK unchanged** |
| `tool/check_module_boundaries.dart` | tooling | **OK unchanged** |
| `docs/00-governance/adr/` (whole directory) | 2 | **diff empty** |

Application code: `git diff --stat 1922f8d HEAD -- lib/ test/ pubspec.yaml web/ packages/ android/` → **empty**.

**Finding: the correction pass respected every boundary it was given.** It changed only `PRD-004`, three unranked supporting documents, and one unranked roadmap row. That is exactly what a controlled correction should look like, and it is the strongest single piece of evidence in the correction pass's favour.

### 2.2 What this review changed

**Nothing.** This document is the only file created. `PRD-004` was not touched. No commit of any correction was made. `PRD-004` remains `DRAFT`.

---

## 3. Priority 1 — `RF-01` / `AR-1` Review

This was designated *"the MOST IMPORTANT review target"*, and I treated the correction's claim as an assertion to be broken rather than a conclusion to be confirmed.

### 3.1 The claim under test

The correction rewrote the Directory's interpretation from a **domain-layer read dependency** on `BC-02`/`BC-03`/`BC-04`/`BC-05` (which `SM-7.1` forbade, producing the self-contradiction `RF-01` identified) to an **`AR-1` application-layer composition**. It claimed *"AR-1 already provides an identical precedent (BC-02 Membership Plans, BC-04 Seat Capacity, application-layer composition, no new BC identifier, no new domain-layer edge)."*

### 3.2 What `AR-1` actually says

Read verbatim from `ARCHITECTURE_RULINGS.md` lines 23–58:

> *"**Ruled:** Library Discovery & Enrollment is **NOT a new bounded context.** It is an **application / read composition capability of the Library domain**. It: owns **no aggregate** · owns **no invariant** · owns **no business state** · only orchestrates **public read models** · delegates **all** domain operations to their owning modules. **Effect.** The context count remains **31 (23 in V1)**. No `BC-` identifier is assigned."*

`AR-1`'s "Read models composed" table names an **exact, enumerable set**:

`BC-19` Tenancy · `BC-25` Configuration · `BC-29` File & Media · `BC-06` Library Policy · **`BC-02` Membership** · **`BC-04` Seating** · `BC-23` Search Indexing.

⇒ **{BC-02, BC-04, BC-06, BC-19, BC-23, BC-25, BC-29}**.

**`BC-03` and `BC-05` are absent.** Mechanically confirmed: `grep -c "BC-03" ARCHITECTURE_RULINGS.md` → **0**. `BC-05` → no hits.

### 3.3 The claim is **partly disproved**

`PRD-004` §5.4 marks **four** rows as `AR-1` composition: `BC-02` (plan/status/`validUntil`/seat quota), `BC-03` (attendance percentage/present days), `BC-04` (current seat/shift/zone), `BC-05` (fee status/outstanding balance).

Two of those four — `BC-03` and `BC-05` — appear **nowhere in `AR-1`**. The correction's word *"identical"* is therefore **false for half the rows**. `AR-1` is a precedent for the *mechanism*; it is not authority for *these specific contexts*.

Had `AR-1` been the only authority cited, this would be a HIGH finding and the answer to Q2 would be *no*.

### 3.4 The authority that does cover all four — `SID-2.7`

`AR-1` is not the only authority, and it is not the highest one. `Student_Identity_PRD_v1.md` §2.7 *"Profile composition"* (lines 455–495) is **Rank 3** — two ranks *above* `AR-1`'s Rank 5 — and it is **frozen**. Its contributor table:

| Contributor | Contributes | Context |
|---|---|---|
| Student Management / Member Directory | Library ID Photo · joined orgs · org status · parent/guardian contact | `BC-01` |
| Membership | plan · status · expiry | **`BC-02`** |
| Attendance | percentage · present days · summary | **`BC-03`** |
| Seat Management | current seat · shift · zone | **`BC-04`** |
| Finance | payment status · outstanding balance | **`BC-05`** |
| Study Analytics / Achievements | study hours · streak · badges | `BC-26` |

Its normative rules:

- `SID-2.38` — *"Aggregation **SHALL** be read-only composition. This module **SHALL NOT** store, cache beyond a display request, or become the authority for any contributed value."*
- `SID-2.39` — *"Every contributed value **SHALL** be fetched under the caller's own authorisation."*
- `SID-2.40` — *"Composition **SHALL** degrade gracefully."*
- `SID-2.41` — *"Composition **SHALL NOT** be performed inside this module's domain layer. It is an application-layer read composition, consistent with ruling `AR-1`."*

This covers **precisely** the four contexts `PRD-004` §5.4 composes, field-group for field-group — `BC-02` plan/status/expiry, `BC-03` percentage/present days, `BC-04` seat/shift/zone, `BC-05` payment status/balance.

**And the doctrine is load-bearing, not decorative.** I verified that `BC-10` — the context `SID-2.7` governs — holds **no BC Map §7 edge** to `BC-02`, `BC-03`, `BC-04` or `BC-05`. `BC-10`'s only edges are `E-12`, `E-13`, `E-15`, `E-21`, `E-22`. Yet `SID-2.7` composes all four regardless, under `SID-2.41`. **Composition-without-a-declared-edge is therefore established Rank 3 doctrine, applied by a frozen document to exactly the context set `AR-1` omits.**

`PRD-004` cites this. §5.4's `LMD-24` cites `SID-2.38`; `LMD-24a` cites `SID-2.38`–`SID-2.41`; the §5.4 mechanism preamble cites `SID-2.41`; §10.5 row 5 cites `SID-2.38`–`SID-2.41`. The authority is **present and correct**. What is wrong is the *emphasis*: the narrative leans on `AR-1`, which covers two rows, while under-citing `SID-2.7`, which covers all four.

### 3.5 The nine mandated questions

| # | Question | Answer | Evidence |
|---|---|---|---|
| **1** | Is the composition actually identical in architectural terms? | **Partly.** Identical in *mechanism* (application-layer read of a public read model, no aggregate, no invariant, no edge). **Not identical in scope** — `AR-1` composes `BC-02`/`BC-04` but never `BC-03`/`BC-05` | `AR-1` table = {BC-02, BC-04, BC-06, BC-19, BC-23, BC-25, BC-29}; `grep -c BC-03` → 0 |
| **2** | Does `AR-1` genuinely authorize this pattern? | **Yes for the pattern; only partly for these contexts.** `AR-1` authorises "application / read composition capability… only orchestrates public read models… no `BC-` identifier". For `BC-03`/`BC-05` the authorising instrument is **`SID-2.7`/`SID-2.38`–`2.41`**, Rank 3, which `PRD-004` cites | `AR-1` L23–58; `SID-2.41` L493 |
| **3** | Does the correction accidentally weaken `SM-7.1`? | **No.** Verified against tooling, not narrative — see §3.6 | `module_dependencies.yaml` `app:` rank 9 |
| **4** | Does the Directory remain a read composition? | **Yes.** `LMD-2` forbids an aggregate; `LMD-28` forbids any write; `LMD-24b` forbids authority; `SM-10.6` forbids a `library_member` table; `SM-AC-18` tests for it by schema scan | `LMD-2`, `LMD-24`, `LMD-24a`, `LMD-24b`, `LMD-28`, `SM-10.6`, `SM-AC-18` |
| **5** | Does `BC-01` remain owner of `StudentRecord`? | **Yes.** §5.4 row 2 marks enrollment number / `EnrollmentStatus` / contact / guardian / documents *"**This module** — Owned — Strong"*. Matches BC Map §370 exactly | BC Map L370; §5.4 |
| **6** | Does `BC-01` accidentally become an owner/consumer dependency architecture forbids? | **No.** `LMD-24b` explicitly forbids `BC-01` becoming authoritative over `MembershipStatus`, seat, attendance or fee; every write delegates to the owner's command API under rule `F-3` | `LMD-24b`, `LMD-28` |
| **7** | Is any new BC edge implicitly required? | **No.** §5.4 marks the four rows *"none — none required"*, and the rationale blockquote states the existing `E-01`/`E-09` are **event** edges *"not read edges. That is correct and **MUST NOT** be changed to suit this screen"* | §5.4 L594–599 |
| **8** | Does any module dependency become illegal? | **No.** `module_dependencies.yaml` already grants `app` (rank 9) ports to `domain/library`, `domain/person`, `domain/social`. `default_decision: deny` — and composition is on the *allow* side already. **No manifest change is needed or implied** | `module_dependencies.yaml` `app:` block |
| **9** | Does the correction introduce a hidden architecture contradiction? | **No contradiction.** One **citation-precision defect** (`SR-03`, MEDIUM): the narrative over-claims `AR-1` for `BC-03`/`BC-05` | §3.3 above |

### 3.6 Testing Q3 properly — did narrowing `SM-7.1` create an escape hatch?

`SM-7.1` changed from binding *"this module"* to binding *"this module's **domain layer**"*. On its face that is a narrowing, and a narrowing of a prohibition deserves suspicion. I tested whether it opens a hole the tooling cannot see.

It does not, for a mechanical reason. `tool/module_dependencies.yaml` models **modules**, and its `app` block (rank 9) *already* declares ports to `domain/library`, `domain/person` and `domain/social`, under `default_mode: port` and `default_decision: deny` (*"anything not listed is forbidden"*). An application-layer read composition is therefore **already legal under the committed manifest, with no amendment**. The narrowed `SM-7.1` aligns the PRD's prose with the enforcement model that already exists; it does not carve an exception out of it.

Nor is the prohibition lost. The narrowed `SM-7.1` retains *"A **domain-layer** dependency on another bounded context that BC Map §7 does not declare is a defect, and adding such an edge requires an ADR (BC Map line 292)"*, and `SM-7.1a` plus `LMD-24a` restate the domain-layer bar at the point of use. `LMD-24a` also forbids persisting or caching a composed value, and forbids using one to evaluate any invariant `BC-01` owns — which closes the route by which a "read-only" composition would otherwise leak into domain logic.

### 3.7 `RF-01` verdict

> ## **PASS**
>
> The corrected interpretation is **architecturally valid**. The Directory is a read composition; `BC-01` retains sole ownership of `StudentRecord`; no new bounded context is created; no `BC-` identifier is assigned; no BC Map §7 edge is added or implied; no module dependency becomes illegal; `SM-7.1` is narrowed in alignment with the enforcement model rather than in escape from it.
>
> **No architectural decision is required. No ADR is required.**
>
> One MEDIUM defect stands: the PRD's *narrative* over-claims `AR-1` as an *"identical"* precedent for `BC-03` and `BC-05`, which `AR-1` does not mention. The **operative authority** — `SID-2.7` with `SID-2.38`–`SID-2.41`, Rank **3**, two ranks above `AR-1` — does cover all four rows and **is already cited** in `LMD-24`, `LMD-24a`, the §5.4 preamble and §10.5. The architecture is right; one sentence of attribution is imprecise. Recorded as `SR-03`, not as a blocker.

---

## 4. Priority 2 — `SM-EV-10` Review

Verified from the BC Map and other authoritative sources, not from the PRD's own account of itself.

| Property | Finding | Evidence |
|---|---|---|
| **Producer** | **`BC-01`** | BC Map §8 L408: `| BC-01 | enrollment.StudentLinkedToPerson | BC-10 (via ACL) | The consented social bridge |` |
| **Ownership** | **Owned by `BC-01`.** Rank 4 assigns it to `BC-01` as producer; `PRD-004` is `BC-01`'s PRD, so recording it is an obligation, not a design choice | BC Map §8; `PRD_REGISTRY.md` L224 |
| **Meaning** | The **consented social bridge** — the fact that a tenant-scoped `StudentRecord` has been linked to a global `Person` after consent | BC Map §8 "Purpose" column |
| **Payload** | `personId`, `tenantId`, `at`, `consentRecordRef`. **Never `studentRecordId`** | §7.4 L762; `SM-7.12b` |
| **Consumer** | **`BC-10`, via the `E-13` ACL** — matches Rank 4 exactly | BC Map §8 L408 = `BC-10 (via ACL)`; PRD §7.4 = `BC-10` **via the `E-13` ACL` ✅ |
| **Relation to Global Identity** | It *is* the `BC-01`→`BC-10` bridge. `E-13` is a declared BC Map §7 edge (`BC-01`→`BC-10`, ACL sync port), so this event needs no new edge | BC Map §7 `E-13` |
| **Relation to Social** | Indirect and correctly gated. `SM-7.12a`: emitted **only** after `BC-18` Consent Management has recorded consent (`ID-6`); absent consent it **MUST NOT** be emitted **and enrollment MUST still succeed** — *"the social profile simply remains inactive"*. `BC-01` does not evaluate the consent rule, it consumes the `BC-18` decision. This is consistent with `SID-5.14` (guardian consent linked before any social context activates) | `SM-7.12a`, `SM-4.8`, `SID-5.14` |
| **Idempotency** | **Covered both sides.** Producer: `SM-7.7a`/`SM-7.7b` transactional outbox in the same transaction as the state change. Consumer: `SM-7.5`/`SM-7.7`. Existence condition: `SM-10.12` — the event **MUST** exist in the outbox iff consent recorded and enrollment committed | `SM-7.7a`, `SM-7.7b`, `SM-10.12` |
| **Ordering** | `SM-7.16` — per-`studentRecordId` only; global ordering **MUST NOT** be assumed. Correct for a partitioned outbox; `SM-7.7b` requires tenant partitioning and per-aggregate order | `SM-7.16`, `SM-7.7b` |
| **Retry** | `SM-7.7` bounded retry with idempotent consumer; §9.2 *"Failed integration → bounded retry, idempotent, no duplicate effect"* | `SM-7.7`, §9.2 |
| **Privacy** | **Strong and correctly reasoned.** `SM-7.12b` forbids `StudentRecordId` in the payload because `BC-10` is a *global* context — carrying it would let a global consumer correlate a human across tenants, the exact leak `MP-GBR-03`/`ID-2` forbid and `SM-AC-28` tests. `SM-7.14` forbids credentials, OTPs, bytes, resolvable `FileRef`s and `BC-10`-owned personal fields in any payload | `SM-7.12b`, `SM-7.14`, `SM-7.15`, `SM-AC-28` |

### 4.1 Classification — the question the instruction posed

Is `SM-EV-10` a `BC-01` domain event, an integration event, a cross-context event, or *"merely referenced rather than owned"*?

**It is a `BC-01`-owned domain event published as an integration event across a declared ACL edge.** It is **not** "merely referenced". BC Map §8 places `BC-01` in the **Producer** column, and BC Map §8 is the authoritative ownership register at Rank 4. A context that produces an event owns it. `PRD-004` states this correctly at §7.4: *"**`SM-EV-10` is not a new event.** It is an existing architectural obligation that an earlier draft of this document omitted… the BC Map is **not** modified, and no ADR is required."*

That characterisation survives scrutiny. The first review's `RF-02` was **correct**: the PRD's "closed set of nine" omitted an event Rank 4 already assigned to `BC-01`. Adding it *restores* alignment rather than creating anything.

### 4.2 `SM-EV-10` verdict

**PASS.** Producer, ownership, consumer, edge, payload, consent gate, idempotency, ordering, retry and privacy posture all verified against Rank 4 and Rank 3 sources and all correct. `SM-7.12` correctly re-closes the set at **ten**. No event was invented; the BC Map was not modified.

### 4.3 A separate finding surfaced by this check — the `BC-26` omission

Auditing §7.4 against BC Map §8 row-by-row exposed a divergence the first review did not report:

| Event | BC Map §8 consumers (Rank 4) | `PRD-004` §7.4 consumers | Delta |
|---|---|---|---|
| `enrollment.StudentEnrolled` | `BC-02`, `BC-23`, **`BC-24`**, **`BC-26`**, **`BC-22`** | `BC-02`, `BC-23` | 3 omitted |
| `enrollment.StudentProfileUpdated` | `BC-23`, **`BC-24`**, **`BC-26`** | `BC-23` | 2 omitted |
| `enrollment.StudentStatusChanged` | `BC-02`, `BC-04`, `BC-23`, **`BC-24`** | `BC-02`, `BC-04`, `BC-23` | 1 omitted |
| `enrollment.StudentLinkedToPerson` | `BC-10` (via ACL) | `BC-10` via `E-13` ACL | ✅ exact |

- **`BC-24` Audit** — omission is **immaterial**. `E-20` is a generic *"All contexts → BC-24 Audit (Event, fire-and-forget, outbox-backed)"* edge and `SM-8.10` enumerates twelve audited actions. Covered.
- **`BC-22` Notification** — **immaterial**. `E-23` is generic *"All contexts → BC-22"*, and `SM-EV-6` cites `E-23` explicitly.
- **`BC-26` Study Analytics — material.** `grep -c "BC-26"` in `PRD-004` → **0**. `BC-26` appears nowhere in the PRD, and BC Map §7 declares **no `BC-01`→`BC-26` edge** (`BC-26`'s only inbound edge is `E-26` from `BC-27`). So Rank 4 names `BC-26` a consumer of two `BC-01` events in §8 while §7 provides no edge to reach it.

This is simultaneously a **PRD omission** (`SR-04`, MEDIUM) and a **Rank 4 internal tension** (`SR-05`, reported under §17 Governance, not chargeable to `PRD-004`). Note also that `SID-2.7` lists `BC-26` as a profile contributor, which reinforces that `BC-26`'s integration story is under-specified platform-wide rather than mis-specified here.

---

## 5. Priority 3 — Traceability Verification

*"Verify this mechanically from the actual repository. Do NOT accept the number blindly."*

### 5.1 Independent reproduction

| Measure | PRD §10.5.1 claims | This review measured | Agrees? |
|---|---|---|---|
| Base identifiers located | 248 | **248** | ✅ |
| Proposed gaps excluded | 10 | **10** | ✅ |
| Denominator | 238 | **238** | ✅ |
| Traced DIRECT | 211 | **211** | ✅ |
| Traced DERIVED | 10 | **10** | ✅ |
| Untraced | 17 | **17** | ✅ |
| **Coverage** | **221/238 = 92.9%** | **221/238 = 92.9%** | ✅ |
| Script exit code | 1 (untraced remain) | **1** | ✅ |

The 248 count was **independently re-derived with a regex written for this review** (definition sites only, §0 declaration block skipped): 107 `SM-c.n` + 16 `SM-BR` + 14 `SM-XC` + 11 `SM-INV` + 10 `SM-EV` + 12 `SM-PO` + 30 `SM-AC` + 7 `SMCFG` + 31 `LMD` + 10 `SM-GAP` = **248**. Matches §0.2's declaration exactly.

**The 221/238 figure is correct.** It does not need replacing.

### 5.2 Hand-verification of all 17 allegedly untraced identifiers

Each was read in place with surrounding context, and the script's judgement was independently tested by widening the search window to ±10 lines to see whether any citation was being *dropped*.

| # | ID | Line | Subject | Genuinely sourceless? | Note |
|---|---|---|---|---|---|
| 1 | `SM-2.8` | 265 | Every transition carries actor, timestamp, reason where the table requires | **Yes** | Nearby `TR-1`/`TR-2`/`E-09` tokens belong to the **transition table rows above**, not to `SM-2.8`. Script correct to exclude |
| 2 | `SM-3.12` | 364 | Duplicate check uses `personId`, never name/mobile/email | **Yes** | Nearby `AR-2`/`14A` belong to §3.2. Reasoning is self-justifying (*"Names collide; identities do not"*) |
| 3 | `SM-3.13` | 367 | Rejection returns existing `StudentRecordId` to authorized caller | **Yes** | UX/ergonomics decision |
| 4 | `SM-3.14` | 370 | `Archived` record offers restore rather than a second record | **Yes** | ±10-line window genuinely empty |
| 5 | `SM-3.16` | 392 | Concurrency resolved by DB unique constraint, not app check | **Yes** | Nearby `MP-ASM-04`/`ID-5` belong to `SM-3.15` |
| 6 | `SM-3.17` | 395 | `enrollmentNumber` allocation collision-free | **Yes** | Implementation strategy for `SM-INV-1` but does not cite it |
| 7 | `SM-4.1` | 403 | What this module stores | **Yes** | Its **converse** `SM-4.2` is fully cited (`SID-2.8`, `E-13`) — see `SR-07` |
| 8 | `SM-6.1` | 643 | The eight operations this module provides | **Yes** | Scope statement |
| 9 | `SM-6.3` | 649 | Optimistic concurrency on record version | **Yes** | Implementation strategy |
| 10 | `SM-6.5` | 655 | Member history exposes transitions/changes with actor, timestamp, reason | **Yes** | Overlaps `SM-8.11`, also untraced |
| 11 | `SM-6.6` | 658 | History read from `BC-24`; no parallel audit store | **Partly** — arguably should cite `E-20`/`X-10` | The *strongest* candidate for a missing citation. `BC-24` is named but no edge/rule identifier is given |
| 12 | `SM-6.8` | 664 | Membership renewal delegated to `BC-02` | **Partly** — preamble carries `ID-2` from `SM-6.7` | Delegation to `BC-02` is a BC Map §3 ownership consequence; could cite it |
| 13 | `SM-8.11` | 863 | Audit entry field set | **Partly** — arguably `X-10`/`AUTH-7.x` | `SM-8.10` immediately above is cited; the field list is not |
| 14 | `SM-8.15` | 875 | Data minimisation | **Partly** — `SID-5.7`/`SID-2.5` say almost exactly this | A real candidate: Rank 3 has a near-verbatim rule |
| 15 | `SM-10.1` | 935 | `student_record` table shape | **Yes** | Schema design, correctly local |
| 16 | `SM-10.7` | 972 | Idempotency key on every mutating endpoint | **Yes** | Verified by `SM-AC-26`; a design standard |
| 17 | `SM-10.8` | 975 | Typed domain errors, no generic 500 | **Yes** | API quality standard |

**Conclusion.** The script is **not** losing citations. In 13 of 17 cases the identifier is genuinely a local design decision within `BC-01`'s own aggregate, which is exactly what the PRD's §10.5.1 prose claims (*"Each is a design decision this module is entitled to make within its own aggregate"*). In **4 cases** (`SM-6.6`, `SM-6.8`, `SM-8.11`, `SM-8.15`) an external citation plausibly exists and would improve the figure — `SM-8.15` most clearly, since `SID-5.7` states data minimisation in nearly the same words. Recorded as `SR-07`, **LOW**: this is an improvement opportunity, not a defect. `SM-10.11` explicitly permits a requirement to be satisfied by a task or criterion instead of a citation, and all four are task-covered.

### 5.3 Integrity checks — fake, stale, dangling, duplicate, incorrect

| Check | Method | Result |
|---|---|---|
| **Dangling internal references** | Every `` `SM-*` ``/`` `LMD-*` ``/`` `IMPL-*` `` reference cross-checked against definition sites | **2**: `IMPL-214` (×2) is a deliberate **foreign** reference to another PRD's task, disclosed as such; `SM-PO` (×1) is a **register-name mention**, not an identifier reference. **No genuine dangling identifier** |
| **Duplicate definitions** | Definition-site counter over 303 distinct identifiers | **2 apparent**: `SM-7.1a` (L69 register row / L688 definition) and `SM-8.4a` (L76 / L831). Both are the §0.2 suffix-register row plus the real definition — **benign by construction, not duplicates** |
| **Stale external references** | Every `AR-n` cited (`AR-1`, `AR-2`, `AR-7`) checked against `ARCHITECTURE_RULINGS.md` | All three exist (`AR-1`…`AR-7` defined). **No stale ruling reference** |
| **`AP-3` resolves** | Repo-wide search for definition | Defined at `Authentication_PRD_v2.md` L2263 / `07-Roles-Permissions…md` L51. **Resolves** |
| **BC Map line citations** | `SM-INV-3` cites *"BC Map line 370"*; `SM-BR-2`/`SM-AC-5` cite *"line 209"* | L370 **is** the aggregate/invariant table containing *"guardian mandatory if age < 18"* ✅. L209 **is** the `EnrollmentStatus` vs `MembershipStatus` *"Two independent state machines"* row ✅. **Both accurate** |
| **Incorrect source mappings** | Every `SM-AC-n` "Verifies" cell checked against the cited requirement's actual text | **3 wrong** — see §5.4 |
| **Fake traceability** | Script `EXTERNAL` regex audited for self-citation loophole | Loophole exists but is **immaterial** — see §5.5 |
| **ID contiguity** | Per-register range check | `SM-c.n` 107 contiguous per chapter; BR 1-16, XC 1-14, INV 1-11, EV 1-10, PO 1-12, AC 1-30, SMCFG 1-7, LMD 1-31, GAP 1-10 — **zero gaps**. `IMPL-300`…`323` contiguous |

### 5.4 Three incorrect acceptance-criterion mappings (new)

Not reported by the first review. Each cited requirement was read in full:

| AC | Cites | The cited requirement actually says | Should cite |
|---|---|---|---|
| `SM-AC-5` | `SM-2.2` | `SM-2.2` is the **field list** of `StudentRecord` (*"MUST hold: studentRecordId, tenantId, personId…"*). It says nothing about `Expired` | **`SM-2.7`** — *"`Expired` **MUST NOT** be an `EnrollmentStatus` value"* — which is the requirement this AC tests |
| `SM-AC-6` | `SM-2.4` | `SM-2.4` forbids **holding** a `MembershipId`/seat/attendance/fee as state. The AC tests that a student *stays `Active` when membership expires* | **`SM-2.7`** and/or `SM-BR-3` |
| `SM-AC-25` | `SM-8.17` | `SM-8.17` is about **export** field minimisation and auditing. The AC tests **bulk partial-failure** reporting | **`LMD-30`** / `SM-BR-14` |

`SM-AC-11` was checked as a fourth candidate and is **correct** — `SM-8.11`'s audit-entry field set plus `X-10` append-only does support *"status history is append-only"*.

Recorded as `SR-06`, **MEDIUM**. `SM-10.11` makes the `Verifies` column *"mechanically checkable"*; a mapping that names the wrong requirement defeats exactly that mechanism, and would let `SM-2.7` — the PRD's self-described *"single most important correction in this chapter"* — appear verified when nothing verifies it.

### 5.5 Script bias audit — a loophole found, and tested rather than assumed

`tool/docs_check/prd004_traceability.py`'s `EXTERNAL` regex includes `r'\bPRD-0\d\d\b'`. That pattern **matches `PRD-004` itself**, so in principle the document could count a **self-citation** as external authority — precisely the fault the script's own prose forbids (*"a document cannot be its own authority"*).

I tested rather than asserting. Every definition line citing any `PRD-0nn`:

```
L524   LMD-13      → PRD-015
L1115  SM-GAP-9    → PRD-006
L1116  SM-GAP-10   → PRD-003
count: 3
```

**All three cite other PRDs. None is a self-citation. Two are `SM-GAP-*`, excluded from the denominator anyway.** Material effect on 92.9%: **zero**.

Recorded as `SR-14`, **OBSERVATION** — script hygiene, not a finding against the PRD. Inflating this to a finding would be manufacturing one.

### 5.6 On the direction of the metric

Worth stating plainly, because it is the best available evidence about the correction pass's honesty. The traceability figure moved **96.3% (asserted, withdrawn) → 92.9% (measured)**. The correction pass replaced a favourable unverifiable number with a **worse** reproducible one, and said so in §10.5.1. A pass that was tuning its metrics would not have done that.

---

## 6. Priority 4 — `RF-17` DOB Governance Review

| # | Question | Answer |
|---|---|---|
| **1** | Is this genuinely a contradiction? | **It is a genuine tension, not a strict logical contradiction.** `SID-5.9`: *"Date of Birth **SHALL** be stored, because minor-safety obligations (`ID-6`) depend on it."* The §2.2 Global Profile table lists Date of Birth under **Optional**, and `SID-2.5` says *"Only the minimum information required for identity **SHALL** be mandatory."* The two can be reconciled — `SID-5.9` can be read as *"where present, it SHALL be stored here rather than elsewhere, and SHALL never be public"* (its second clause is entirely about non-visibility), which is a **storage-location** rule rather than a **collection-mandate**. But that reconciliation is an interpretation, and the document does not state it. Under `SID-4.56` an unstated reconciliation is not a fact |
| **2** | Which document has authority? | **`Student_Identity_PRD_v1.md` itself — the tension is internal to one Rank 3 document.** Both `SID-5.9` and the §2.2 Optional list live in the same frozen file, so precedence cannot resolve it. Only the `BC-10` owner can, and only through an ADR (Rank 2) or an amendment to that Rank 3 PRD |
| **3** | Does `PRD-004` depend on the conflicting interpretation? | **No — and this is the decisive answer.** `PRD-004` is deliberately **interpretation-independent**. §4.2.1 specifies all three cases; `SM-4.5a` forbids inferring an age; `SM-4.5b` fails safe to minor; `SM-4.5c` states *"This module **MUST NOT** require, request or cause a Date of Birth to become mandatory at `BC-10`."* Whichever way `BC-10` resolves it, `PRD-004`'s behaviour is unchanged |
| **4** | Can `PRD-004` safely freeze while it is unresolved? | **Yes.** `PRD-004` neither asserts nor requires either reading. It records the tension as proposed gap `SM-GAP-10` with the correct owner, and specifies deterministic behaviour for the absent-DOB case that is safe under either resolution |
| **5** | Does an ADR actually need creating? | **Yes — but for `PRD-003`/`BC-10`, not for `PRD-004`.** Because the tension is *inside* a frozen Rank 3 document, only Rank 1 or Rank 2 can settle it, and Rank 1 is silent on DOB. So an accepted ADR is the instrument. **This review does not create it** (§7.1 of the correction report already escalated it; this review confirms the escalation is correct and complete) |
| **6** | `PRD-004` blocker or external governance issue? | **External governance issue.** Not chargeable to `PRD-004`. The first review classified `RF-17` as an OBSERVATION *"`PRD-003` (not this PRD)… **Not chargeable to `PRD-004`**"* — and that classification is **correct** |

### 6.1 A citation defect found while verifying this

`PRD-004` cites the Optional list as **"`PRD-003` §2.4"** in three places (§4.2.1 L426, `SM-4.5c` context, `SM-GAP-10` L1116). Verified mechanically:

```
L298  ### 2.2 Global Profile     ← the Optional list is at L311, inside §2.2
L368  ### 2.4 Profile privacy    ← §2.4 is a different section entirely
```

**The Optional list is in §2.2 "Global Profile", not §2.4 "Profile privacy".** The first review cited it correctly as *"`PRD-003` line 311"*; the correction pass converted a correct line reference into an incorrect section reference. `SID-5.9` is likewise in **§5.2 Data protection**, not §5.9 — though the PRD cites that one by identifier, which is unambiguous.

Recorded as `SR-08`, **LOW** — it points a reader at the wrong section of a frozen Rank 3 document, in the one place where an auditor most needs to check the claim.

### 6.2 `RF-17` verdict

**Correctly handled, correctly escalated, correctly not resolved.** `PRD-004` does not depend on the outcome and can freeze while it is open. An ADR is required — **against `PRD-003`/`BC-10`, by the `BC-10` owner**. This review reports it and does nothing more.

---

## 7. Priority 5 — Guardian / DOB Logic Review

### 7.1 The three cases

`PRD-004` §4.2.1 is a normative table. Verified in full:

| Case | Specified behaviour | Deterministic? |
|---|---|---|
| **A — DOB present, age < 18** | `GuardianLink` **mandatory**; enrollment without it rejected with a typed error (`SM-4.4`, `SM-INV-3`) | ✅ Yes |
| **B — DOB present, age ≥ 18** | `GuardianLink` **optional**; **MUST** be accepted if supplied; absence **MUST NOT** block enrollment | ✅ Yes |
| **C — DOB absent** | `SM-4.5a` governs; `SM-INV-3` is **indeterminate, not satisfied**. Minor-status recorded `Unknown`; a staff-recorded `TR-1`/`TR-2`/`TR-3` **age declaration** required before the record leaves `Pending`; declaration audited (`SM-8.13`). `SM-4.5b`: until derived or declared, treated as **minor** — guardian required, `ID-6`-gated capability closed | ✅ Yes |

All three paths are specified. `RF-06`'s core complaint — that case C left `SM-INV-3` unevaluable — is **resolved**.

### 7.2 Does `AP-3` actually authorize the fail-safe? — verified verbatim

The instruction was explicit that this must be checked, not assumed. `AP-3` read from source (`Authentication_PRD_v2.md` L2263, and identically at `07-Roles-Permissions-and-Access-Policies.md` L51):

> `| AP-3 | **Deny by default** | AUTH-7.6 — Absence of an explicit grant is refusal. A newly introduced permission is unreachable by every role until explicitly granted |`

**Assessment — `AP-3` authorizes part of `SM-4.5b`, and is analogical for the rest.**

- ✅ **The `ID-6`-gated-capability half is squarely within `AP-3`.** `SM-4.5b` closes capabilities gated on minor consent while minor-status is unknown. That is literally *"absence of an explicit grant is refusal"* — the grant (consent) is absent, so the capability is refused. Direct application.
- ⚠️ **The guardian-required half is analogical.** *"`GuardianLink` is required"* is an affirmative **data-collection obligation**, not the withholding of a permission. `AP-3` is an **authorisation** policy about grants. Requiring a data field is a stricter-default decision of the same *spirit* but not the same *subject*.

The stronger authority for the second half is one `PRD-004` already cites: **`SID-4.56`** — *"A rule that cannot be checked SHALL be treated as unmet, not as satisfied by intent."* If `SM-INV-3` (guardian mandatory if minor) cannot be evaluated, it is **unmet**, and the behaviour for an unmet guardian invariant is precisely *"require the guardian."* That is a direct derivation, not an analogy. `SID-5.14` reinforces it: *"Minor-safety obligations **SHALL** be honoured."* And the frozen `STUDENT_IDENTITY_ALIGNMENT.md` `SC-5` reasoning applies the identical logic — *"The platform serves a minor-heavy user base; `BC-13` Trust & Safety is classified `[CORE]`… precisely because minor safety is existential legal risk"* — to resolve a comparable question in the protective direction.

**So the conclusion is right and the reasoning is 80% right.** `SM-4.5b`'s own blockquote actually leads with `SID-4.56` and adds `AP-3` second, which is the correct order of strength; but the requirement text itself says *"it is the deny-by-default posture required by `AP-3`"*, presenting the weaker authority as the operative one. Recorded as `SR-09`, **LOW** — citation-strength, not substance. Notably the PRD does **not** overclaim: it says explicitly *"This is a **fail-safe**, not a legal determination."*

### 7.3 The mandated sub-checks

| Check | Result | Evidence |
|---|---|---|
| Guardian requirement deterministic? | ✅ **Yes** for all three cases | §4.2.1 table; `SM-4.5a`; `SM-4.5b` |
| Legal rule invented? | ✅ **No.** Explicitly disclaimed: *"a **fail-safe**, not a legal determination."* No jurisdiction, statute or age of majority beyond the pre-existing 18 is asserted; `SM-GAP-1` refuses to invent a retention period on the same principle | `SM-4.5b`; `SM-GAP-1` |
| Contradiction with Identity? | ✅ **No.** `SM-4.5c` forbids requiring/requesting/causing DOB to become mandatory at `BC-10`, and refers the question to the `BC-10` owner via `SM-GAP-10`. `SM-4.5` derives age through `E-13`, never storing it (`SM-4.2`) | `SM-4.5`, `SM-4.5c`, `SM-XC-2`, `SID-2.42` |
| ACs cover all three paths? | ❌ **No — only case C.** See §7.4 | `SM-AC-29` only |
| `StudentRecord` remains authoritative? | ✅ **Yes** for `GuardianLink` and guardian **contact**. `SID-2.8` (Rank 3): *"Parent / guardian contact information **SHALL NOT** be a field of this profile. It is owned per organisation by `BC-01`."* `SM-4.6` mirrors it exactly and cites it. `SID-5.8` reinforces by forbidding guardian contact as a `BC-10` field | `SID-2.8`, `SID-5.8`, `SM-4.6` |
| Guardian data duplication? | ✅ **None.** `BC-01` owns guardian contact; `BC-10` forbids the field. `SID-2.7` lists guardian contact as a **`BC-01` contribution** to `BC-10`'s profile screen — a read composition, not a copy, governed by `SID-2.38` (*never store, never cache beyond a display request, never become the authority*). Single source of truth, in the right context | `SID-2.7`, `SID-2.8`, `SID-2.38`, `SM-4.6` |
| Guardian `Account`/role creation? | ✅ Correctly excluded. `SM-4.7` — a guardian's own `Account` and `TR-5` Parent role **MUST NOT** be created here. `SM-4.8` — minor consent gated by `BC-18` (`ID-6`); no consent record here | `SM-4.7`, `SM-4.8` |

### 7.4 The AC gap (new finding)

Mechanical check of all 30 criteria for guardian/DOB/minor coverage returned exactly **one** row:

```
SM-AC-29 → case C (DOB absent)   Verifies: SM-INV-3, SM-4.5a, SM-4.5b, AP-3, SID-4.56
```

**Cases A and B have no acceptance criterion.**

- **Case A** — the single most safety-critical path in the chapter (*minor present, guardian missing ⇒ reject*) — is verified by **nothing**. `SM-4.4` and the case-A row are named by no AC.
- **Case B** — *adult, no guardian, must not be blocked* — is verified by nothing. This is the false-positive direction: an implementation that requires a guardian for everyone would satisfy every existing AC while being wrong.

By the PRD's own `SM-10.11`, a requirement verified by no criterion and no task is **unmet** under `SID-4.56`. `IMPL-322` does cover `SM-4.5a`–`SM-4.5c` and `SM-INV-3`, so `SM-10.11`'s three-way test is technically satisfied via the task route — which is why this is **HIGH-adjacent but recorded MEDIUM** (`SR-10`), not HIGH. Still: the correction pass added an AC for the case the review complained about and left the two pre-existing cases untested.

### 7.5 Guardian/DOB verdict

**PASS with one MEDIUM gap.** The three-case logic is deterministic, invents no legal rule, contradicts no Rank 3 authority, keeps `BC-01` authoritative over guardian data, and duplicates nothing. Two of three paths lack acceptance criteria (`SR-10`), and the fail-safe leans on `AP-3` where `SID-4.56` is the stronger authority (`SR-09`).

---

## 8. Priority 6 — First Review Findings Reconciliation

All 21 findings re-tested against the live document. The first review was **not** assumed correct.

| # | Sev (1st) | Status | Evidence from the corrected document |
|---|---|---|---|
| `RF-01` | HIGH | ✅ **RESOLVED** | §5.4 rebuilt with a normative Mechanism column; `SM-7.1` scoped to domain layer; `SM-7.1a`, `LMD-24a`, `LMD-24b` added. Verdict **PASS** (§3). Residual citation imprecision → `SR-03` |
| `RF-02` | HIGH | ✅ **RESOLVED** | `SM-EV-10` added at §7.4 L762 with `BC-10` via `E-13` ACL; `SM-7.12` re-closed at **ten**; `SM-7.12a` consent gate; `SM-7.12b` payload limit; `SM-10.12` existence condition; `IMPL-320`. Matches BC Map §8 L408 exactly. Verdict **PASS** (§4) |
| `RF-06` | HIGH | ✅ **RESOLVED** | §4.2.1 three-case table; `SM-4.5a`/`b`/`c`; `SM-INV-3` amended to *"or if minor-status is `Unknown`"*; `SM-AC-29`; `IMPL-322`. Residual: cases A/B untested → `SR-10`; `AP-3` citation strength → `SR-09` |
| `RF-03` | MEDIUM | ✅ **RESOLVED** | All ten events now carry the `enrollment.` prefix (§7.4 L753–762), satisfying BC Map §8's binding `<Context>.<Aggregate><PastTenseVerb>` convention. Verified row by row |
| `RF-04` | MEDIUM | ✅ **RESOLVED** | `PRD-004_TRACEABILITY.md` §4 rebuilt to ten individually-enumerated prefixed events; numbering now matches PRD §7.4 exactly (`SM-EV-3`=`StudentArchived`, `SM-EV-10`=`StudentLinkedToPerson`); a correction blockquote records the prior disagreement |
| `RF-05` | MEDIUM | ✅ **RESOLVED** | §0.1 *"Normative language"* added (L23–35) defining MUST/SHOULD/MAY, citing the Stage 2 rule it satisfies, and stating that prose and rationale blockquotes carry no obligation. Also adds a precedence clause. **Stage 2 rule 4 now met** |
| `RF-07` | MEDIUM | ✅ **RESOLVED** | 96.3% claim withdrawn in §10.5.1 with the reason (*"the table has ten rows, so no per-identifier mapping existed"*); replaced by a reproducible 92.9% from a committed script; the 17 untraced are named. Independently reproduced (§5) |
| `RF-08` | MEDIUM | ✅ **RESOLVED** | §10.4 now has a **`Verifies`** column; all 30 criteria populated, **0 empty**. Residual: 3 mappings name the wrong requirement → `SR-06` |
| `RF-09` | MEDIUM | ⚠️ **PARTIALLY RESOLVED** | The specific gap the review named is closed — `IMPL-318` now covers `LMD-25`–`LMD-29`, and `IMPL-320`…`323` were added. But a fresh mechanical set-difference over the 153 behavioural requirements finds **32 still named by no task**, including `SM-1.1`–`SM-1.8` (all of chapter 1), `SM-7.1`, `SM-7.2`, `SM-7.5`, `SM-7.6`, `SM-7.7`–`SM-7.11`, `SM-4.1`–`SM-4.3`, `SM-4.5b`, `SM-8.4`, `SM-8.15`–`SM-8.17`, `SM-10.8`–`SM-10.11`. Many are prohibitions verified by AC schema scans instead, so this is coverage-shape rather than a hole → `SR-11` |
| `RF-10` | MEDIUM | ✅ **RESOLVED** | `SM-2.14` rewritten; a **Citation note** blockquote now states `MP-GBR-16` is *"**analogous** here rather than authoritative"* and names `E-01` plus reacting-context ownership as the real authority. Sentence fragment gone. Exemplary handling — the wrong citation was **downgraded and explained**, not quietly deleted |
| `RF-11` | MEDIUM | ✅ **RESOLVED** | `LMD-15a` splits filters **Authoritative** vs **Best-effort**; `LMD-15b` limits `LMD-11` cursor stability to authoritative filters only; a rationale blockquote states the limit is real rather than a workaround. Jointly satisfiable now |
| `RF-12` | LOW | ✅ **RESOLVED** | §8.2 L819/L827 now carry explicit `❌ *(interim — SM-8.4a)*`; `SM-8.4a` records the interim `TR-5` deny under `AP-3`/`SID-4.56`; `SM-GAP-4` annotated **"Still open."** The closed list no longer contains an undefined cell **and** the open question is not falsely closed. Both halves correct |
| `RF-13` | MEDIUM | ✅ **RESOLVED** | `SM-INV-6` reworded to *"One **non-`Archived`**… Archived records are exempt"*; `SM-3.14a` states more than one archived record **MAY** exist; `SM-3.14b` requires the count be presented; restore targets most-recently-archived; `SM-AC-30`; `IMPL-323`. `SM-10.2` partiality now consistent with the invariant it implements |
| `RF-14` | LOW | ✅ **RESOLVED** | `docs/30-product/student-management/README.md` exists; all **4 of 4** sibling modules now have one |
| `RF-15` | OBSERVATION | ⏹️ **REJECTED — rejection upheld** | `grep BC-20` in the PRD → **0 hits**, so `BC-20` remains unexcluded. But `SM-XC-*` is a *closed* list of 14 exclusions and a 15th was optional even in the original finding. Rejection was legitimate and is recorded as rejected with a reason in correction report §3 — which is exactly what `PRD_LIFECYCLE.md` Stage 3 demands (*"A rejected finding must be recorded as rejected, with its reason"*) |
| `RF-16` | MEDIUM | ✅ **RESOLVED** | `PRODUCT_IMPLEMENTATION_ROADMAP.md` L60 updated to v1.1, 0 of **24** tasks, 0 of **30** ACs, with links to both review reports. The document is unranked, so no ADR was needed. *(Correction report §3 lists `RF-16` as rejected-as-out-of-scope yet §7.2 records the update as performed — see `SR-13`)* |
| `RF-17` | OBSERVATION | ⏹️ **CORRECTLY ESCALATED, NOT RESOLVED** | `SM-GAP-10` opened; `SM-4.5c` forbids resolving it here; correction report §7.1 escalates to the `BC-10` owner. Verdict §6: `PRD-004` does not depend on it and may freeze. Residual: §2.4 vs §2.2 miscitation → `SR-08` |
| `RF-18` | OBSERVATION | ⚠️ **PARTIALLY RESOLVED** | §0.1 now *defines* SHOULD/MAY, which was the substantive half. But usage is still lopsided: **MUST ×159, SHOULD ×0, MAY ×2** (`SM-3.14a`, `LMD-15a`) — SHOULD is defined and never used, so the two design preferences the review named (`LMD-11` cursor-based, `LMD-17` tie-breaker) remain **MUST**. Note the MUST count *rose* 125→159 → `SR-12`, LOW |
| `RF-19` | MEDIUM | ✅ **RESOLVED** | `SM-7.7a` requires the event be written to a transactional **outbox within the same transaction as the state change**, dispatched afterwards, and declares commit-without-publish a defect; `SM-7.7b` requires tenant partitioning and per-aggregate ordering; rationale cites `E-20`'s existing *"outbox-backed"* precedent; `IMPL-321`. Producer-side gap closed |
| `RF-20` | OBSERVATION | ✅ **RESOLVED** | `SM-EV-3` note now reads *"emitted **after** the dues pre-condition has passed and the archive is committed (`SM-7.17`)"* — event and pre-condition no longer conflated. `SM-EV-6` now cites `E-23` explicitly with *"the domain emits a **fact**, never 'send an SMS'"* |
| `RF-21` | MEDIUM | ✅ **RESOLVED** | `grep abridged` → **0 hits**. §10.4's heading now states *"Every criterion **MUST** name the requirement it verifies… The `Verifies` column makes both conditions mechanically checkable."* The undefined boundary is gone |

### 8.1 Tally

| Status | Count | IDs |
|---|---|---|
| ✅ Resolved | **17** | `RF-01`, `RF-02`, `RF-03`, `RF-04`, `RF-05`, `RF-06`, `RF-07`, `RF-08`, `RF-10`, `RF-11`, `RF-12`, `RF-13`, `RF-14`, `RF-16`, `RF-19`, `RF-20`, `RF-21` |
| ⚠️ Partially resolved | **2** | `RF-09` (32 requirements still untasked), `RF-18` (SHOULD defined, never used) |
| ⏹️ Rejected — upheld | **1** | `RF-15` |
| ⏹️ Escalated, not resolved (correct) | **1** | `RF-17` |
| ❌ Unresolved | **0** | — |
| ❌ Incorrectly reported by the first review | **0** | Every one of the 21 was independently reproducible |
| ⚠️ Newly introduced by the correction pass | **3** | `SR-01` (stale supporting docs), `SR-08` (§2.4 miscitation), `SR-13` (correction report internal inconsistency) |

**On the first review's quality.** I looked for findings that were wrong and found none. All 21 were reproducible from primary sources. `RF-15` and `RF-18` were correctly self-classified as OBSERVATIONS, and `RF-17` was correctly marked *"not chargeable to `PRD-004`."* The first review did not inflate.

**On findings the first review missed.** It missed the `BC-26` consumer omission (`SR-04`), the three incorrect AC mappings (`SR-06`), the negated-MUST grammar defect (`SR-02`), and the DOB cases A/B AC gap (`SR-10`) — the last being a partial miss, since `RF-06` opened the area. `SR-01`, `SR-08` and `SR-13` did not exist at the time.

---

## 9. PRD Internal Consistency

Special attention was directed at the 413 changed lines.

| Check | Result |
|---|---|
| §0.2 register counts vs mechanical count | ✅ **Exact.** 107/16/14/11/10/12/30/7/31/10 = **248**, matching the declaration. Sub-lettered total 15, grand total **263** — the suffix table lists exactly 15 rows |
| Per-chapter `SM-c.n` allocation table | ✅ Contiguous per chapter: Ch1 8, Ch2 16, Ch3 17, Ch4 12, Ch5 0, Ch6 8, Ch7 17, Ch8 17, Ch9 0, Ch10 12 = 107. Chapters 5 and 9 are declared empty **by design** with a stated reason |
| Sub-lettering scheme | ✅ Coherent. `SM-7.1a` qualifies `SM-7.1`; `SM-4.5a`/`b`/`c` complete `SM-4.5`. Preserves pre-existing identifiers, which matters because three supporting documents cite them |
| ID contiguity, all 10 registers | ✅ Zero gaps |
| Duplicate definitions | ✅ None genuine (2 benign register/definition pairs) |
| Dangling internal references | ✅ None genuine (`IMPL-214` is a disclosed foreign reference) |
| Normative-language definition | ✅ §0.1 present; Stage 2 rule 4 satisfied |
| §0.1 vs actual usage | ⚠️ SHOULD defined, used **0** times (`SR-12`) |
| **Negated-MUST grammar** | ❌ **3 defects** — see below (`SR-02`) |
| Closed-set declarations honoured | ✅ `EnrollmentStatus` 4 values (`SM-2.5`); events **ten** (`SM-7.12`); `SM-PO` 12 with no undefined cell after `SM-8.4a`; `SM-XC` 14 |
| Rationale blockquotes non-normative | ✅ Stated in §0.1 and observed — blockquotes explain, they do not require |
| Self-contradiction sweep | ✅ None found. `SM-2.7` (`Expired` forbidden) is consistent with `SM-2.4`, `LMD-3`, `LMD-25`, `SM-BR-2`, `SM-BR-3`, `SM-AC-5`, `SM-AC-6` |

### 9.1 `SR-02` — three requirements state the opposite of their intent

§0.1 defines **MUST** as *"An absolute requirement"* and **MUST NOT** as its negation. Under that vocabulary, `No X MUST Y` parses as *"there is no X that is required to Y"* — a statement that Y is **not obligatory**, i.e. permissive. Three requirements are written that way:

| ID | Line | As written | Evidently intended |
|---|---|---|---|
| `SM-10.9` | 977 | *"**No** endpoint **MUST** accept `tenant_id` as an authorisation input"* | *"**No** endpoint **MAY** accept…"* / *"Every endpoint **MUST NOT** accept…"* |
| `SM-7.14` | 780 | *"**No** event payload **MUST** contain a credential, an OTP, a raw document byte…"* | *"…**MUST NOT** contain…"* |
| `LMD-24a` | 604 | *"**No** row in this table **MUST** be read from this module's **domain layer**"* | *"…**MUST NOT** be read from…"* |

Severity is driven by subject matter, not by count:

- `SM-10.9` implements **`X-13`**, which `PRD_LIFECYCLE.md` Stage 3 calls *"**A security defect that passes its own tests**"* when got wrong, and which Stage 3 lists as a **hard freeze gate**. A tenant-isolation prohibition rendered permissive is the exact failure mode that clause names.
- `SM-7.14` is the **credential/OTP/PII payload prohibition** — `ID-1` territory.
- `LMD-24a` is one of the three requirements that **implements the `RF-01` fix**. The correction pass's central repair is expressed in inverted grammar.

Mitigation, which is why this is **HIGH** and not CRITICAL: intent is unambiguous from context; `SM-8.2` states the `SM-10.9` rule correctly and `SM-AC-14` tests it (*"A client-supplied `tenant_id` cannot widen access"*); `SM-7.15`/`SM-7.12b` restate the payload bar correctly; `SM-7.1`/`SM-7.1a` state the domain-layer bar correctly. **No implementer would build the wrong thing.** But under `SID-4.56` — the PRD's own governing principle — a rule that says the opposite of its intent cannot be checked *as written*, and a frozen document is read literally by people who were not in the room.

---

## 10. Library Members Directory Review

Chapter 5, `LMD-1`…`LMD-31` plus `LMD-15a`/`15b`/`24a`/`24b`.

| Requirement of the mandate | Result | Evidence |
|---|---|---|
| Read composition only | ✅ | §5.4 Mechanism column normative; `LMD-24` |
| No aggregate | ✅ | `LMD-2`; `AR-1` *"owns no aggregate"*; `SM-AC-18` schema scan for absence of `library_member` |
| No independent invariant | ✅ | No `SM-INV-*` is owned by chapter 5; `LMD-24b` forbids authority over composed values |
| No DB ownership | ✅ | `SM-10.6` — no `library_member` table, no `member_directory` table, **no denormalised copy** of membership/seat/attendance/fee data. Tested by `SM-AC-18` |
| No duplicate membership record | ✅ | `SM-2.4` forbids `StudentRecord` holding `MembershipId`/seat/attendance/fee as state; `SM-10.6` forbids the copy |
| No second lifecycle | ✅ | `LMD-3` — the Directory **MUST NOT** define a `MemberStatus` of its own |
| No second source of truth | ✅ | `LMD-24`, `LMD-24b`, `SM-BR-13`, `SID-2.38` |
| No unauthorized write | ✅ | `LMD-28` — no write at all; every action delegates to the owning module's command API which **re-validates every invariant** (rule `F-3`). `LMD-29` — visibility **MUST NOT** imply permission to act |
| No accidental cross-context dependency | ✅ | §5.4 marks four rows *"none — none required"*; `LMD-24a` bars domain-layer reads; `SM-7.1`/`SM-7.1a` bar undeclared domain-layer edges. Manifest already permits app-layer ports |

### 10.1 Per-surface classification, as required

| Surface | Composition or reference? | Verified |
|---|---|---|
| **Search** | Reference — served by **`BC-23`** via `E-21`, a **declared** edge | `LMD-12`; `SM-AC-21` (*"results come from `BC-23`, not a domain table query"*) |
| **Filtering** | Split, correctly. `LMD-15a`: **Authoritative** = `EnrollmentStatus`, registration date range, guardian-required (owned locally, cursor-stable). **Best-effort** = shift/seat/fee/membership (foreign projections) | `LMD-15`, `LMD-15a`, `LMD-15b` |
| **Pagination** | Local, over owned data; cursor stability guaranteed **only** for authoritative filters | `LMD-10`, `LMD-11`, `LMD-15b`; `SM-AC-17` (page size clamped to `SMCFG-2`) |
| **Member details** | Composition. §5.4: `BC-10` via declared `E-13`; `BC-02`/`BC-03`/`BC-04`/`BC-05` by `AR-1`/`SID-2.7` composition; `BC-29` via declared `E-22` | §5.4; `LMD-24a` |
| **Status** | Composition of two **independent** indicators, never merged | `LMD-3`, `LMD-25`; `SM-AC-19`; BC Map L209 |
| **Expiry** | Composition from the `BC-02` projection; threshold `SMCFG-3` | `LMD-26` |
| **Seat** | Composition of the `BC-04` public read model; no edge required | §5.4 row 5; `LMD-24b` |
| **Attendance** | Composition of the `BC-03` public read model. Formula **not** invented — deferred to `BC-03` as `SM-GAP-9` | §5.4 row 4; `SM-GAP-9` |
| **Fee** | Composition of the `BC-05` public read model; `BC-05` remains authoritative for balance | §5.4 row 6; `LMD-24b` |

### 10.2 Deny-by-default and graceful degradation

`LMD-5`/`SM-BR-12`: the Directory is **off** unless `LCFG-5` is enabled — matching `CONFIGURATION_GUIDE.md` L341 (*"**Disabled**… **Deny by default** (`AP-3`). Exposes members to members; must be opted into"*). Tested both directions by `SM-AC-15`/`SM-AC-16` including *"no data loss"* on re-enable. `LMD-21`/`SID-2.40` require graceful degradation, tested by `SM-AC-20` (*"An unavailable `BC-02` projection renders that section unavailable only"*). `LMD-23`/`SID-2.38` forbid a stale projection being used in an authorisation decision, tested by `SM-AC-22`. **All three of the highest-risk Directory behaviours are AC-covered.**

### 10.3 Directory verdict

**PASS.** The Directory is a genuine read composition with no aggregate, no invariant, no table, no lifecycle, no write and no undeclared domain-layer dependency. This is the strongest chapter in the document.

---

## 11. Global Identity Review

Against `PRD-003` (`Student_Identity_PRD_v1.md`, Rank 3, frozen) and `ADR-0011` (Rank 2).

| Check | Result | Evidence |
|---|---|---|
| `personId` non-nullable, immutable | ✅ | `SM-INV-5`, `SM-BR-11` cite `ADR-0011` + `ID-4`; `SM-AC-3` tests schema rejection |
| Identity triad respected | ✅ | `Account`/`BC-18` · `Person`/`BC-10` · `StudentRecord`/`BC-01` per-tenant. `SM-1.2`, §1.3 ownership table |
| `BC-10`-owned fields not stored | ✅ | `SM-4.2` forbids Full Name, Username, Global Profile Photo, Bio, Gender, **Date of Birth**, Address, Email, Occupation — citing `SID-2.8` and read through `E-13`. Matches `SID-2.8`'s ownership boundary exactly |
| No credential/OTP/session | ✅ | `SM-XC-1`; `SM-AC-4` schema scan; `SM-7.14`. Consistent with `ID-1` and `SID-5.8` |
| Two-photo distinction | ✅ | `SM-4.3` — Library Identification Photo owned here, **distinct** from the Global Profile Photo, citing `Student_Identity_PRD_v1.md` line 122. Rationale is sound: *"a student changing their avatar changes the reception desk's identification photo"* — and matches `SID-5.8` which forbids the Library ID Photo as a `BC-10` field |
| Guardian contact ownership | ✅ | `SM-4.6` cites `SID-2.8` L498. `SID-2.8` verbatim: *"It is owned per organisation by `BC-01`"*. Correct direction |
| Cross-tenant correlation prevented | ✅ | `SM-7.15`, `SM-7.12b`, `SM-BR-10`; `SM-AC-28`; `PRD-004_OWNERSHIP_MATRIX.md` `OWN-6` |
| `E-13` used as declared | ✅ | ACL sync port, `BC-01`→`BC-10`, present in BC Map §7. `SM-EV-10` travels it |
| `StudentRecordId` never at `BC-10` | ✅ | `SM-7.12b`; and `SID-5.8` independently forbids `StudentRecordId` as a `BC-10` field. Both sides agree |
| Per-tenant record independence | ✅ | `SM-3.15` — same `personId` at a different tenant **MUST** be permitted with an independent `StudentRecordId` (`MP-ASM-04`, BC Map §4.1); `SM-AC-2` |
| Duplicate prevention by identity | ✅ | `SM-3.12` — check **MUST** use `personId`, never name/mobile/email |

**No overlap, no duplication, no second source of truth.** `PRD-004` and `PRD-003` are disjoint, as `PRD_REGISTRY.md` L415 asserts of the Rank 3 set (*"`PRD-001`, `PRD-002` and `PRD-003` are disjoint"*). The only `BC-10`-related open item is `SM-GAP-10`, correctly owned elsewhere.

**Verdict: PASS.**

---

## 12. Enrollment vs Membership Review

The mandate: `EnrollmentStatus` / `StudentStatus` / `MembershipStatus` / `SubscriptionStatus` / `PaymentStatus` must **not** be one state machine.

| Machine | Owner | Treated as separate in `PRD-004`? |
|---|---|---|
| `EnrollmentStatus` — `Active`/`Inactive`/`Suspended`/`Archived` | **`BC-01`** | ✅ Owned; closed set of 4 (`SM-2.5`, `SM-INV-7`) |
| `MembershipStatus` — `Valid`/`Expired`/`Frozen` | `BC-02` | ✅ Never owned; composed only (§5.4 row 3); `LMD-24b` forbids authority |
| `SubscriptionStatus` (tenant billing) | `BC-20` | ✅ Absent from the PRD entirely — correct, it is a **tenant** concern not a student one |
| `PaymentStatus` / fee balance | `BC-05` | ✅ Never owned; `SM-2.4` forbids holding a fee balance; composed only (§5.4 row 6) |
| `StudentStatus` (as a merged concept) | — | ✅ **Does not exist.** `LMD-3` forbids a Directory `MemberStatus`; `LMD-25` forbids a single merged badge |

Supporting evidence:

- `SM-2.7` — *"`Expired` **MUST NOT** be an `EnrollmentStatus` value. Expiry is a `MembershipStatus` owned by `BC-02`."* The PRD calls this *"the single most important correction in this chapter"* and it is right to.
- `SM-2.6` — `Prospective`/`Registered` **MUST NOT** be `EnrollmentStatus` values.
- `SM-BR-2` — the two are independent state machines (BC Map L209).
- `SM-BR-3` — a student **may** be `Active` with an expired membership.
- `SM-AC-5` — setting `EnrollmentStatus = Expired` is rejected.
- `SM-AC-6` — a student remains `Active` when membership expires.
- `SM-AC-19` — the Directory shows the two as **two fields**.

BC Map L209 verbatim: *"`EnrollmentStatus` vs `MembershipStatus`. **Two independent state machines** — a student can be Active with an Expired membership."*

**Verdict: PASS.** The separation is specified, tested in both directions, and matches Rank 4 exactly. Caveat: `SM-AC-5` and `SM-AC-6` cite the **wrong requirement** in their `Verifies` column (`SR-06`) — the behaviour is tested, the traceability of the test is not.

---

## 13. API / Data / Event Review

### 13.1 API surface (§10.2)

12 endpoints, each with an owner (`BC-01`), an `SM-PO` protected operation, an idempotency marker and a note. Authorisation is stated to be a `BC-18` decision (`SM-8.6`) — correct under `X-13`.

| Check | Result |
|---|---|
| Every endpoint maps to a protected operation | ✅ All 12 |
| Mutating endpoints marked idempotent | ✅ All 8 mutating carry ✅; `SM-10.7` requires the key; `SM-AC-26` tests it |
| Read endpoints marked `n/a` | ✅ 4 |
| Authorisation outside `BC-18`? | ✅ None. `SM-8.6` delegates; `SM-10.9` bars `tenant_id` as an authz input (**grammar defect `SR-02`**) |
| Search routed to `BC-23` | ✅ `GET /students/search` → *"Served by `BC-23` (`LMD-12`)"* |
| History routed to `BC-24` | ✅ *"From `BC-24` (`SM-6.6`)"* — no parallel audit store |
| Typed errors | ✅ `SM-10.8` |
| Bulk capped | ✅ `SMCFG-4`, per-record results |

### 13.2 Data model (§10.1)

`SM-10.1` table shape; `SM-10.2` unique constraints with the **deliberately partial** `(tenant_id, person_id)` where status ≠ `Archived`, now consistent with the reworded `SM-INV-6` and explained by `SM-3.14a`; `SM-10.3` tenant partitioning under `X-13`; `SM-10.4` archive-is-status-not-deletion (`MP-GBR-14`); `SM-10.5` indexes matching the §5.2 filters; `SM-10.6` the negative constraint. Coherent, and the `RF-13` repair holds.

### 13.3 Events (§7.4)

| Check | Result |
|---|---|
| Naming convention | ✅ All 10 carry `enrollment.` prefix; all past-tense; none imperative |
| Closed set declared and honoured | ✅ `SM-7.12` closes at ten; exactly 10 rows |
| Envelope | ✅ `SM-7.13` — `eventId`, `occurredAt`, `correlationId`, `tenantId`, `actor` |
| Payload prohibitions | ✅ `SM-7.14` (grammar defect `SR-02`), `SM-7.15`, `SM-7.12b` |
| Ordering | ✅ `SM-7.16` per-aggregate only |
| Emission discipline | ✅ `SM-7.17` — only on committed state change; no CRUD event for a read |
| Producer idempotency | ✅ `SM-7.7a`/`SM-7.7b` transactional outbox |
| Consumer idempotency | ✅ `SM-7.5`, `SM-7.7` |
| Consumers match BC Map §8 | ⚠️ **`BC-26` missing** (`SR-04`); `BC-24`/`BC-22` omitted but generically covered by `E-20`/`E-23` |
| Every event has a named consumer | ✅ No orphan events |

**Verdict: PASS with `SR-04` (MEDIUM) and the `SR-02` grammar defect touching `SM-7.14`.**

---

## 14. Acceptance Criteria Review

*"Verify the current acceptance criteria count mechanically."* Done. **No application implementation test was used as proof of PRD correctness** — the Dart test suite verifies code, not this document, and was run only for §18 gate reproduction.

| Measure | Value |
|---|---|
| Criteria declared (§0.2, §10.4 heading) | **30** (`SM-AC-1`…`SM-AC-30`) |
| Criteria mechanically counted | **30** |
| Range contiguous | ✅ 1–30, zero gaps |
| Rows with an empty `Verifies` cell | **0** |
| Distinct requirements referenced across all `Verifies` cells | **65** |
| Criteria citing the **wrong** requirement | **3** (`SM-AC-5`, `SM-AC-6`, `SM-AC-25`) → `SR-06` |
| Orphan criteria (verify nothing) | **0** |

### 14.1 Sufficiency by risk area

| Area | Sufficient? | Covering criteria |
|---|---|---|
| Tenant isolation / `X-13` | ✅ **Strong** | `SM-AC-12`, `SM-AC-13`, `SM-AC-14` |
| Identity integrity | ✅ Strong | `SM-AC-1`, `SM-AC-2`, `SM-AC-3`, `SM-AC-28` |
| Credential exclusion | ✅ | `SM-AC-4` (schema scan) |
| State-machine separation | ✅ Both directions | `SM-AC-5`, `SM-AC-6`, `SM-AC-19` |
| Archive/dues/history | ✅ | `SM-AC-7`, `SM-AC-8`, `SM-AC-9` |
| Audit | ✅ | `SM-AC-10`, `SM-AC-11`, `SM-AC-24` |
| Directory config gating | ✅ Both directions | `SM-AC-15`, `SM-AC-16` |
| Directory composition discipline | ✅ | `SM-AC-18`, `SM-AC-20`, `SM-AC-21`, `SM-AC-22` |
| Authorisation by role | ⚠️ **Thin** | Only `SM-AC-23` for 12 protected operations × 5 roles. §8.2's *closed list* is largely untested → `SR-15`, LOW |
| Bulk operations | ✅ | `SM-AC-25` (wrong `Verifies`) |
| Idempotency | ⚠️ Consumer/API only | `SM-AC-26`. The new **producer-side outbox** (`SM-7.7a`/`SM-7.7b`, the `RF-19` repair) has **no AC** — only `IMPL-321` → `SR-16`, LOW |
| Documents / `FileRef` | ✅ | `SM-AC-27` |
| **Guardian / DOB** | ❌ **Insufficient — 1 of 3 paths** | `SM-AC-29` only → `SR-10`, MEDIUM |
| Restore determinism | ✅ | `SM-AC-30` |
| `SM-EV-10` consent gate | ⚠️ | `SM-10.12` states the condition; no AC tests it → folded into `SR-16` |

### 14.2 Missing criteria (named, not counted vaguely)

1. **Case A** — DOB present, age < 18, guardian absent ⇒ typed rejection (`SM-4.4`, `SM-INV-3`). *Safety-critical.*
2. **Case B** — DOB present, age ≥ 18, guardian absent ⇒ enrollment **not** blocked.
3. **Producer outbox** — a committed state change with an unpublished event is impossible (`SM-7.7a`).
4. **`SM-EV-10` consent gate** — not emitted absent consent, **and enrollment still succeeds** (`SM-7.12a`, `SM-10.12`).
5. **Protected-operation matrix** — broader `SM-PO` × role coverage than `SM-AC-23` alone.

**Verdict: 30 criteria, sound in structure (every row names a requirement), with 3 incorrect mappings and 5 named gaps. Sufficient to freeze only if items 1–2 are added, because they cover the chapter with the highest safeguarding risk.**

---

## 15. Proposed Gap Review

**No gap is promoted by this review.** Each was assessed only for whether it is *legitimately* a gap — i.e. whether an authoritative source exists that the PRD failed to find.

| Gap | Subject | Legitimate gap? | Assessment |
|---|---|---|---|
| `SM-GAP-1` | Retention period for financial/attendance history | ✅ **Yes** | `ID-5` mandates retention *"under legal basis"* with no duration. Inventing "7 years" would fabricate a legal position. Correctly refused |
| `SM-GAP-2` | `enrollmentNumber` format / human-meaningfulness | ✅ Yes | `SM-INV-1` requires uniqueness only; `SMCFG-5`'s default is disclosed as a placeholder |
| `SM-GAP-3` | Whether `Inactive` blocks seat allocation | ✅ Yes | `MP-GBR-16` covers membership validity, `SM-2.14` covers `Suspended`; `Inactive` genuinely unspecified. Also correctly a `BC-04` decision |
| `SM-GAP-4` | `TR-5` Parent access to Directory / member detail | ✅ Yes, **and correctly still open** | Parent Portal is Master PRD module 5, a composition with **no PRD**. `SM-8.4a` records an interim **deny** so §8.2 stays an executable closed list, while the annotation states *"**Still open.** …the interim value is a safe default under `AP-3`, not an answer to the question"*. **This is the right pattern**: a safe default that does not masquerade as a decision |
| `SM-GAP-5` | Member tags / free-text notes | ✅ Yes | Requested in the original brief; *"no authoritative source anywhere in the repository"*. Verified — correctly refused rather than invented |
| `SM-GAP-6` | Emergency contact distinct from guardian contact | ✅ Yes | `SID-2.8` names *"parent/guardian contact"* only. Confirmed against `SID-2.8` |
| `SM-GAP-7` | Directory visibility of members to other members | ✅ Yes | `LCFG-5` says the directory *"exposes members to members"* but no requirement defines the member-facing field set. Confirmed against `CONFIGURATION_GUIDE.md` L341 |
| `SM-GAP-8` | Bulk import / `registrationSource = Import` validation | ✅ Yes | `SM-3.8` names the source; no import specification exists |
| `SM-GAP-9` | Attendance-percentage definition | ✅ Yes | Owned by `BC-03`; `PRD-006` unwritten, so the formula has no owner. Correct — inventing it would make `BC-01` authoritative over a `BC-03` value, breaching `LMD-24b` |
| `SM-GAP-10` | Whether DOB should become mandatory at `BC-10` | ✅ Yes | The `RF-17` tension. Correctly owned by `BC-10` + ADR; `SM-4.5c` forbids resolving it here. Residual: §2.4 miscitation (`SR-08`) |

**All 10 are legitimate.** None is a disguised design abdication; each names a specific missing authority and the party who owns it. `SM-GAP-9` and `SM-GAP-10` are especially well-formed — both refuse to legislate for another bounded context.

Correctly excluded from the traceability denominator: *"carrying no source is what makes a gap a gap."*

---

## 16. Implementation Task Review

**No task was executed.** `IMPL-300`…`IMPL-323` reviewed as documentation only.

| Check | Result |
|---|---|
| Range allocated and contiguous | ✅ `IMPL-300`…`IMPL-323`, **24** tasks, zero gaps |
| No reuse of an existing `IMPL` number | ✅ 300-block is new; `IMPL-214` appears only as a disclosed **dependency** on another PRD's task |
| Every task names requirements | ✅ All 24 populate the requirements column |
| Every task names a module | ✅ `domain/library`, `platform/event`, etc. |
| Dependencies form a DAG | ✅ All predecessors are lower-numbered within the block (or the foreign `IMPL-214`) — acyclic by construction |
| Module targets legal under the manifest | ✅ `domain/library` rank 8, `platform/event` — all declared in `module_dependencies.yaml` |
| Every task has an exit condition | ✅ Each row states a verifiable outcome (*"`SM-AC-29` passes"*, *"Commit-without-publish impossible"*) |
| New tasks cover the new requirements | ✅ `IMPL-320` (`SM-EV-10`), `IMPL-321` (outbox), `IMPL-322` (absent-DOB), `IMPL-323` (restore determinism), `IMPL-318` (`LMD-25`–`29`) |
| **Reverse coverage** | ⚠️ **32 of 153 behavioural requirements are named by no task** (`SR-11`) |
| **Task document synchronised** | ❌ `PRD-004_IMPLEMENTATION_TASKS.md` contains **18** tasks, `IMPL-300`…`IMPL-317` — it **stops at 317** while the PRD runs to **323**. Six tasks exist in the PRD and in no task document (`SR-01`) |

`PRD_LIFECYCLE.md` Stage 6 gate: *"an `IMPL-*` range allocated and a task document in which **every task traces back to requirements**."* The range is allocated and §10.7 satisfies the tracing requirement — but the **task document** is six tasks behind. The PRD's own `README.md` discloses this (*"⚠ The PRD §10.7 now runs to `IMPL-323`; this file still stops at `IMPL-317`"*), which is honest, but disclosure is not synchronisation.

**Verdict: task structure sound; the task document is stale (`SR-01`).**

---

## 17. Governance Review

### 17.1 Lifecycle stage gates

| Stage | Gate | Met? |
|---|---|---|
| **1 Proposed** | Registered in `PRD_REGISTRY.md` | ✅ L224 `PRD-004` … **`DRAFT`** with file path |
| **2 Draft** | (1) unique IDs · (2) prefixes collision-checked · (3) contiguous ranges · (4) normative language defined | ✅ **All four.** (1) 303 distinct, no genuine duplicate · (2) `TRACEABILITY_MATRIX.md` §3 documents `SM-BR-n`/`SM-PO-n`/`SM-c.n` collision avoidance and proves `MP-SM-0n` is a true negative · (3) all 10 registers contiguous · (4) **§0.1 added — `RF-05` resolved** |
| **3 Architecture Review** | A written alignment record naming every conflict and its disposition | ✅ `PRD-004_ALIGNMENT_REPORT.md` exists. ⚠️ Two Stage 3 checks carry residual risk: *"Every integration edge exists in §7"* — satisfied, but see `SR-03`/`SR-04`; *"No authorisation decided outside `BC-18`"* — satisfied in substance, but `SM-10.9`'s inverted grammar (`SR-02`) lands exactly on the `X-13` check the stage calls *"a security defect that passes its own tests"* |
| **4 Requirements Review** | Conflicts closed or explicitly deferred **with a reason and an owner** | ✅ 10 gaps each with reason + owner; 2 rejected findings recorded **as rejected with reasons** (correction report §3), which Stage 3 explicitly demands. ⚠️ *"Every acceptance criterion maps to a requirement"* — 3 map to the **wrong** one (`SR-06`) |
| **5 Traceability** | Prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, **verified mechanically, zero collisions** | ❌ **NOT MET.** §2C is stale — see §17.2. **This is the binding freeze blocker** |
| **6 Implementation Tasks** | Range allocated + task document where every task traces to requirements | ⚠️ Range ✅; task document 6 tasks behind (`SR-01`) |

### 17.2 `SR-01` — stale supporting documents (the freeze blocker)

`TRACEABILITY_MATRIX.md` §2C, read live:

| Register | Matrix §2C says | PRD (post-correction) says | Stale? |
|---|---|---|---|
| `SM-c.n` | **105** (`SM-1.1`…`SM-10.10`) | **107** (`SM-1.1`…`SM-10.12`) | ❌ |
| `SM-EV-n` | **9** (`SM-EV-1`…`SM-EV-9`) | **10** (…`SM-EV-10`) | ❌ |
| `SM-AC-n` | **28** (`SM-AC-1`…`SM-AC-28`) | **30** (…`SM-AC-30`) | ❌ |
| `SM-GAP-n` | **9** | **10** | ❌ |
| **Total** | *"**Total Student Management normative identifiers: 242**"* | **248** base + 15 sub-lettered = **263** | ❌ |
| Per-chapter | *"Ch 1 = 8 · Ch 2 = 16 …"* with Ch 10 at the old count | Ch 10 = 12 | ❌ |

`PRD_LIFECYCLE.md` Stage 5 is unambiguous: the gate is *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, **verified mechanically**"*, and *"Mechanical means counted by a tool, not by reading."* The matrix currently records counts that a tool **disproves**. Under `SID-4.56` the Stage 5 gate is therefore **unmet**, not merely untidy.

Second stale document: `PRD-004_IMPLEMENTATION_TASKS.md` — 18 tasks, `IMPL-300`…`IMPL-317`, versus the PRD's 24 tasks to `IMPL-323`.

Third, minor: `PRD-004_OWNERSHIP_MATRIX.md` cites `SM-AC-28` (still valid, so no defect) but was not re-checked against the new `SM-AC-29`/`SM-AC-30` or `SM-EV-10`. No incorrect statement found — noted for completeness only.

**Both documents are UNRANKED**, so correcting them requires **no ADR**. This is the cheapest possible blocker: two mechanical count updates and six task rows.

### 17.3 Required changes to frozen / ranked documents

Per the mandate: **reported, not made.**

| # | Document | Rank | Section | Conflict | Proposed resolution | ADR required? |
|---|---|---|---|---|---|---|
| **G-1** | `Student_Identity_PRD_v1.md` | **3, frozen** | §2.2 Optional list (L311) vs `SID-5.9` (L1120) | DOB listed **Optional** while `SID-5.9` says it *"**SHALL** be stored"*. Internal to one Rank 3 document, so precedence cannot resolve it | The `BC-10` owner clarifies whether `SID-5.9` is a **storage-location** rule (*where present, store here, never public*) or a **collection mandate** (*always collect*). The former is the reading consistent with `SID-2.5` and would need only a clarifying sentence | **Yes** — `RF-17`/`SM-GAP-10`. **Not caused by `PRD-004`** |
| **G-2** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` | **4, frozen** | §8 (L404–405) vs §7 (L316–335) | §8 names **`BC-26`** a primary consumer of `enrollment.StudentEnrolled` and `enrollment.StudentProfileUpdated`, but §7 declares **no `BC-01`→`BC-26` edge**. L292: *"If an edge is not in this table, it **does not exist**."* Rank 4 is internally inconsistent | Either add a `BC-01`→`BC-26` event edge to §7, **or** remove `BC-26` from those §8 rows, **or** state that analytics consumes via a generic projection edge as `E-20`/`E-23` do for audit/notification | **Yes** — BC Map L292 requires an ADR to add an edge. **Not caused by `PRD-004`**; surfaced by it |
| **G-3** | *(none)* | — | — | No change to `MASTER_PRD.md`, any ADR, `Authentication_PRD_v2.md`, `Library_PRD_v1.md`, `ARCHITECTURE_RULINGS.md`, `CONFIGURATION_GUIDE.md` or `module_dependencies.yaml` is required by `PRD-004` | — | **No** |

**`PRD-004` itself requires no ADR.** Every change it needs is inside itself or inside unranked supporting documents.

### 17.4 `SR-13` — correction report internal inconsistency

`PRD-004_CORRECTION_REPORT.md` §3 lists `RF-16` among findings **rejected** as out-of-scope, while §7.2 records that `PRODUCT_IMPLEMENTATION_ROADMAP.md` L60 **was** updated — and `git diff` confirms it was. So the report classifies as rejected a finding it in fact acted on. The **action** was correct (the roadmap is unranked and its old text was demonstrably false). The **record** is wrong. **LOW** — a defect in an unranked audit record, not in the PRD.

### 17.5 Registry and roadmap consistency

| Document | State | Consistent? |
|---|---|---|
| `PRD_REGISTRY.md` L224 | `PRD-004` … **`DRAFT`** | ✅ Correct — `PRD-004` is not frozen |
| `PRD_REGISTRY.md` L338 | Directory *"**No PRD.** Belongs to `PRD-004` — placement executed"* | ✅ Matches chapter 5 |
| `PRD_REGISTRY.md` §7 counts | 1 `DRAFT`, 19 `PLANNED`, 19 missing V1 | ✅ |
| `PRODUCT_IMPLEMENTATION_ROADMAP.md` L60 | v1.1, 0/24 tasks, 0/30 ACs, links to both reports | ✅ Updated |
| `docs/README.md` | Correction report row present; traceability row v1.1 | ✅ |
| `student-management/README.md` | Verdict **C** → corrected → decision **B**; *"May implementation begin? No"* | ✅ Honest |
| `PRD-004_TRACEABILITY.md` v1.1 | Coverage claim **withdrawn**; §7 *"That this document measures coverage → **It does not.**"* | ✅ Exemplary self-limitation |
| `TRACEABILITY_MATRIX.md` §2C | 242 / 9 events / 28 ACs | ❌ **STALE** (`SR-01`) |
| `PRD-004_IMPLEMENTATION_TASKS.md` | `IMPL-300`…`317` | ❌ **STALE** (`SR-01`) |

---

## 18. Validation Results

All gates reproduced live at `a030b07`. Matrix §10.4 order.

| # | Gate | Command | Result | Caused/changed by `PRD-004`? |
|---|---|---|---|---|
| **1** | Format | `dart format --output=none --set-exit-if-changed .` | ✅ **exit 0** — `Formatted 59 files (0 changed) in 2.82s` | No |
| **2** | Analyze | `flutter analyze` | ✅ **`No issues found! (ran in 2.0s)`** | No |
| **3** | **Boundary checker** ◄ blocks merge | `dart run tool/check_module_boundaries.dart` | ❌ **exit 1** — 4 pre-existing `ADR-0012` debts: `platform/business → platform/tenancy`, `platform/analytics → platform/event`, `domain/library → platform/services` (2 sites), `PolicyDecisionPoint` across five contexts | **NO — see §18.1** |
| **4** | **Architecture tests** ◄ blocks merge | `flutter test test/architecture/` | ✅ **`00:34 +20: All tests passed!`** | No |
| **5** | Full suite | `flutter test` | ✅ **`00:35 +77: All tests passed!`** | No |
| **6** | Web build | not re-run — no code changed since it last passed | n/a | No |
| — | Link check | 524 relative links | ✅ **0 broken** | No |
| — | YAML parse | 5 tracked files | ✅ All parse |  No |
| — | ID continuity | 10 registers | ✅ Zero gaps | No |
| — | Traceability script | `python3 tool/docs_check/prd004_traceability.py` | ⚠️ **exit 1** — 221/238 = 92.9%, **17 untraced**. Exit 1 is the script's designed signal that untraced identifiers remain; it is **not** a repository gate | Yes — by design |
| — | Frozen-doc integrity | 9 ranked/frozen docs + ADR dir vs `1922f8d` | ✅ **All unchanged** | No |
| — | Code integrity | `git diff 1922f8d HEAD -- lib/ test/ pubspec.yaml web/ packages/ android/` | ✅ **Empty** | No |
| — | Git sync | HEAD == claimed correction commit; tree clean | ✅ | — |

### 18.1 Does `PRD-004` cause or change the gate-3 result? — **NO**

The mandate requires this be judged, not assumed.

1. **`PRD-004` changed no code.** `git diff 1922f8d HEAD -- lib/ test/ packages/ android/ web/ pubspec.yaml` → **empty**. A documentation-only commit cannot alter a checker that reads Dart imports.
2. **The four violations are all pre-existing `ADR-0012` debts**, each with its own ADR reference and expiry, and none in a `BC-01`/Student-Management module. They are owned by `TASK-D10`/`BLK-01` and siblings.
3. **`PRD-004` adds no illegal dependency.** Its composition pattern runs at the application layer, and `module_dependencies.yaml`'s `app` block (rank 9) already declares ports to `domain/library`, `domain/person` and `domain/social`. **No manifest amendment is requested or implied.**
4. **`PRD-004` did not modify the manifest or the checker** — both verified `OK unchanged`.
5. The exception list test *"`app -> domain/library` is deliberately NOT waived"* still passes, so the boundary that matters for `PRD-004`'s pattern remains enforced rather than excused.

**Conclusion: gate 3's red status is pre-existing, externally owned (`BLK-01`), and does not fail `PRD-004`.** Equally, `PRD-004` cannot be credited with fixing it. Per the instruction, this is excluded from the freeze decision.

### 18.2 On not confusing test results with PRD correctness

The 77 passing tests and 20 architecture tests verify the **existing application code**. They are **not** evidence that `PRD-004` is correct — `PRD-004` has 0 of 30 acceptance criteria implemented and 0 of 24 tasks executed. They are reported only to establish that the repository is otherwise healthy and that the correction pass broke nothing.

---

## 19. Findings Register

17 findings. Severity assigned by consequence, not by count. Nothing was inflated to appear thorough; nothing was suppressed to appear favourable.

| ID | Severity | Location | Finding | Evidence | Recommendation | Freeze Impact |
|---|---|---|---|---|---|---|
| `SR-01` | **HIGH** | `TRACEABILITY_MATRIX.md` §2C; `PRD-004_IMPLEMENTATION_TASKS.md` | Two supporting documents are stale after the correction pass. Matrix §2C records `SM-c.n`=105, `SM-EV-n`=9, `SM-AC-n`=28, `SM-GAP-n`=9, total **242**; the PRD now has 107/10/30/10, **248** base + 15 sub-lettered = **263**. The task document holds 18 tasks (`IMPL-300`…`317`) against the PRD's 24 (`IMPL-300`…`323`) | Matrix L147–158 quoted live; mechanical count returns 248; `grep -oE 'IMPL-3[0-9][0-9]'` on the task file → 18 unique, max `IMPL-317` | Update §2C counts, ranges and per-chapter table; add `IMPL-318`…`IMPL-323` to the task document. **Both unranked — no ADR** | **YES — blocks.** `PRD_LIFECYCLE.md` Stage 5 makes mechanically-verified matrix registration a gate; it is currently disproved by a tool |
| `SR-02` | **HIGH** | `SM-10.9` (L977), `SM-7.14` (L780), `LMD-24a` (L604) | Three requirements written `No X **MUST** Y`, which under the PRD's own §0.1 vocabulary states that Y is **not obligatory** — the opposite of intent. `SM-10.9` reads *"**No** endpoint **MUST** accept `tenant_id` as an authorisation input"* | The three lines quoted verbatim; §0.1 defines MUST as *"An absolute requirement"* and MUST NOT as its negation | Rewrite as `MUST NOT` (or `No X **MAY** Y`). Priority `SM-10.9` (`X-13`), then `SM-7.14` (`ID-1`), then `LMD-24a` (the `RF-01` repair) | **YES — blocks.** `SM-10.9` implements `X-13`, which Stage 3 calls *"a security defect that passes its own tests"*. Mitigated by correct `SM-8.2`/`SM-7.15`/`SM-7.1a` and by `SM-AC-14` |
| `SR-03` | MEDIUM | §5.4 rationale; correction report §2 | The `AR-1` precedent is over-claimed. `AR-1` composes {`BC-02`, `BC-04`, `BC-06`, `BC-19`, `BC-23`, `BC-25`, `BC-29`}; §5.4 marks `BC-02`, **`BC-03`**, `BC-04`, **`BC-05`** as `AR-1` composition. `BC-03`/`BC-05` appear nowhere in `AR-1`, so *"identical"* is false for half the rows | `AR-1` table L38–50; `grep -c "BC-03" ARCHITECTURE_RULINGS.md` → **0**; `BC-05` → no hits | Lead the §5.4 rationale with **`SID-2.7`** + `SID-2.38`–`SID-2.41` (Rank **3**, frozen), which composes exactly `BC-02`/`BC-03`/`BC-04`/`BC-05`, and cite `AR-1` as the supporting classification. **Both already cited** — this is emphasis, not new authority | **No.** The architecture is authorised at a *higher* rank than claimed. Citation precision only |
| `SR-04` | MEDIUM | §7.4 consumer column | BC Map §8 names **`BC-26`** a primary consumer of `enrollment.StudentEnrolled` and `enrollment.StudentProfileUpdated`; `PRD-004` omits it and `grep -c "BC-26"` on the PRD returns **0**. (`BC-24`/`BC-22` also omitted but generically covered by `E-20`+`SM-8.10` and `E-23`+`SM-EV-6`) | BC Map §8 L404–405; PRD §7.4 L753, L757; grep count 0 | Record `BC-26`'s status explicitly — as a consumer, or as out of V1 scope with a reason. See `SR-05` for the Rank 4 tension that makes this non-trivial | **No.** A disclosure gap, not a design defect |
| `SR-05` | MEDIUM | `LIBOORA_BOUNDED_CONTEXT_MAP.md` §8 vs §7 | **Rank 4 internal tension.** §8 names `BC-26` a consumer of two `BC-01` events; §7 declares no `BC-01`→`BC-26` edge; L292 states *"If an edge is not in this table, it **does not exist**"* | BC Map §7 L316–335 (no such edge; `BC-26`'s only inbound is `E-26` from `BC-27`); §8 L404–405; L292 | **Report only.** Add the edge to §7, remove `BC-26` from §8, or declare a generic analytics projection edge. **Requires an ADR** (BC Map L292) | **No — not chargeable to `PRD-004`.** External governance item (`G-2`) |
| `SR-06` | MEDIUM | §10.4 `SM-AC-5`, `SM-AC-6`, `SM-AC-25` | Three criteria cite the wrong requirement. `SM-AC-5` (Expired rejected) cites `SM-2.2`, the **field list**; should cite `SM-2.7`. `SM-AC-6` (Active with expired membership) cites `SM-2.4`, about **not holding** membership state; should cite `SM-2.7`/`SM-BR-3`. `SM-AC-25` (bulk partial failure) cites `SM-8.17`, about **export**; should cite `LMD-30`/`SM-BR-14` | All six requirement texts read in full at L218, L224, L881 vs the AC rows | Correct the three `Verifies` cells | **No** — but it defeats `SM-10.11`'s *"mechanically checkable"* guarantee, and would leave `SM-2.7` (*"the single most important correction in this chapter"*) apparently unverified |
| `SR-07` | LOW | `SM-6.6`, `SM-6.8`, `SM-8.11`, `SM-8.15` | Of the 17 untraced identifiers, **4** plausibly have an external source the PRD does not cite. `SM-8.15` (data minimisation) is closest — `SID-5.7` states almost the same rule verbatim. `SM-6.6` names `BC-24` without citing `E-20`/`X-10`; `SM-8.11` follows a fully-cited `SM-8.10`; `SM-6.8`'s `BC-02` delegation is a BC Map §3 consequence | All 17 hand-verified in place with a ±10-line window; script confirmed to drop no citation | Consider adding the four citations. The other **13** are correctly local design decisions within `BC-01`'s aggregate, as §10.5.1 claims | **No.** 92.9% is honest; `SM-10.11` permits task/AC coverage instead, and all four are task-covered |
| `SR-08` | LOW | §4.2.1 (L426), `SM-GAP-10` (L1116) | The `PRD-003` Optional list is cited as **§2.4**, but §2.4 is *"Profile privacy"* — the Optional list is at L311 under **§2.2 "Global Profile"**. The first review cited it correctly by line; the correction converted a correct reference into an incorrect one | `grep -nE '^#{2,3} 2\.'` → `L298 ### 2.2 Global Profile`, `L368 ### 2.4 Profile privacy`; Optional list at L311 | Cite **§2.2** (or line 311). Also note `SID-5.9` lives in §5.2, not §5.9 — though the identifier citation is unambiguous | **No.** Newly introduced by the correction pass; misdirects an auditor checking a frozen Rank 3 claim |
| `SR-09` | LOW | `SM-4.5b` | The fail-safe-to-minor is attributed to `AP-3`. Verified verbatim, `AP-3` is *"**Deny by default** — `AUTH-7.6` — Absence of an explicit grant is refusal"*, an **authorisation** policy. It squarely covers closing `ID-6`-gated capabilities; it is **analogical** for the affirmative *"`GuardianLink` is required"*, which is a data-collection obligation. `SID-4.56` (already cited in the adjacent blockquote) supports that half **directly** | `AP-3` at `Authentication_PRD_v2.md` L2263; `SM-4.5b` text | Lead with `SID-4.56` (+ `SID-5.14`); cite `AP-3` for the capability-closure half | **No.** Conclusion correct; the PRD explicitly disclaims *"a **fail-safe**, not a legal determination"* |
| `SR-10` | MEDIUM | §10.4 vs §4.2.1 | Of the three DOB cases, **only case C has an acceptance criterion** (`SM-AC-29`). Case A (DOB present, <18, guardian absent ⇒ reject) and case B (18+, guardian absent ⇒ must not block) are verified by **no criterion** | Mechanical scan of all 30 criteria for guardian/DOB/minor → exactly 1 hit | Add two criteria for cases A and B | **YES — should block.** Case A is the most safety-critical path in the chapter. Technically survives `SM-10.11` via `IMPL-322`, which is why this is MEDIUM not HIGH |
| `SR-11` | LOW | §10.7 | **32 of 153** behavioural requirements are named by no `IMPL` task — including all of chapter 1 (`SM-1.1`–`SM-1.8`), `SM-7.1`, `SM-7.2`, `SM-7.5`–`SM-7.11`, `SM-4.1`–`SM-4.3`, `SM-4.5b`, `SM-8.4`, `SM-8.15`–`SM-8.17`, `SM-10.8`–`SM-10.11`. `RF-09`'s specific complaint (`LMD-25`–`29`) **is** fixed by `IMPL-318` | Set-difference over expanded task ranges, run for this review | Extend task requirement columns, or state that scope/prohibition requirements are verified by AC schema scans instead | **No.** Most are prohibitions or scope statements verified by ACs; `SM-10.11` permits three routes |
| `SR-12` | LOW | Whole document | **SHOULD** is defined in §0.1 and used **zero** times; **MUST** ×159 (up from 125), **MAY** ×2. The design preferences `RF-18` named (`LMD-11` cursor-based, `LMD-17` tie-breaker) remain absolute **MUST** | `grep -o '\*\*SHOULD\*\*'` → 1 hit, the §0.1 definition row only | Consider demoting genuine defaults to **SHOULD** now that the vocabulary exists | **No.** `RF-18` was an OBSERVATION; the substantive half (defining the vocabulary) is resolved |
| `SR-13` | LOW | `PRD-004_CORRECTION_REPORT.md` §3 vs §7.2 | `RF-16` is listed among **rejected** findings in §3, yet §7.2 records the roadmap update as performed — and `git diff` confirms L60 was changed. The action was right; the classification is wrong | Correction report §3 and §7.2; `git diff 1922f8d HEAD -- …ROADMAP.md` | Reclassify `RF-16` as accepted-and-applied | **No.** Defect in an unranked audit record |
| `SR-14` | OBSERVATION | `tool/docs_check/prd004_traceability.py` | The `EXTERNAL` regex includes `r'\bPRD-0\d\d\b'`, which matches **`PRD-004` itself** — in principle letting the document count a self-citation as external authority, the exact fault the script's prose forbids. **Tested: immaterial.** Only 3 definition lines cite any `PRD-0nn` (`LMD-13`→`PRD-015`, `SM-GAP-9`→`PRD-006`, `SM-GAP-10`→`PRD-003`); none is a self-citation and two are excluded gaps | Exhaustive scan of definition lines for `PRD-0nn` → 3 hits, listed | Exclude `PRD-004` from the pattern for hygiene | **No.** Zero effect on 92.9%. Reported as an observation rather than inflated into a finding |
| `SR-15` | OBSERVATION | §10.4 vs §8.2 | §8.2 is a **closed list** of 12 protected operations × 5 roles = 60 cells, verified by a single criterion (`SM-AC-23`, covering `SM-PO-7` for three roles). Authorisation coverage is thin relative to its security weight | `SM-AC-23` is the only role-matrix criterion among 30 | Consider criteria for the deny paths, especially the `SM-8.4a` interim `TR-5` denial | **No.** `SM-8.6` delegates the decision to `BC-18`, whose own PRD carries the authorisation tests |
| `SR-16` | OBSERVATION | §10.4 vs `SM-7.7a`, `SM-7.12a`, `SM-10.12` | Two of the correction pass's own new requirements have **no acceptance criterion**: the producer-side outbox (`SM-7.7a` — *"A committed state change with an unpublished event… is a defect"*, the `RF-19` repair) and the `SM-EV-10` consent gate (`SM-7.12a`/`SM-10.12`, the `RF-02` repair). Both are task-covered (`IMPL-321`, `IMPL-320`) | Scan of all 30 `Verifies` cells for `SM-7.7a`/`SM-7.12a`/`SM-10.12` → no hits | Consider two criteria; `SM-10.12` is already phrased as a testable biconditional | **No.** `SM-10.11`'s task route is satisfied |
| `SR-17` | LOW | `PRD-004_TRACEABILITY.md` §1 | Declares **248** and matches the PRD. But it is the *fourth* document in the ecosystem carrying identifier counts (PRD §0.2, this file, `README.md`, `TRACEABILITY_MATRIX.md` §2C) — and one of the four is already stale (`SR-01`). Four hand-maintained copies of a number a script computes | Counts compared across all four documents | Consider having the counting script emit the register table, so a single source generates all four | **No.** Structural fragility observation; the immediate instance is `SR-01` |

### 19.1 Severity distribution

| Severity | Count | Blocks freeze |
|---|---|---|
| **CRITICAL** | **0** | — |
| **HIGH** | **2** | `SR-01`, `SR-02` |
| **MEDIUM** | **5** | `SR-10` should block; `SR-03`, `SR-04`, `SR-06` should not; `SR-05` is external |
| **LOW** | **7** | None |
| **OBSERVATION** | **3** | None |
| **Total** | **17** | **3** |

**On not inflating.** `SR-14` had every surface feature of a HIGH finding — a real loophole, in the metric-computing tool, defeating the tool's own stated principle. I tested it and it moves the number by **zero**, so it is an OBSERVATION. `SR-03` could be argued as HIGH ("the central architectural claim is wrong"), but the architecture is authorised by `SID-2.7` at a *higher* rank than the ruling the PRD over-cites, and `PRD-004` already cites it — so the defect is attribution, and it is MEDIUM.

---

## 20. Freeze Readiness

### 20.1 Gate-by-gate

| Stage | Gate | Status |
|---|---|---|
| 1 Proposed | Registered | ✅ **MET** |
| 2 Draft | Unique IDs · collision-checked prefixes · contiguous ranges · **normative language defined** | ✅ **MET** (all four; `RF-05` resolved) |
| 3 Architecture Review | Written alignment record; edges exist; rank direction; authz only in `BC-18`; no credentials; tenant scoping | ⚠️ **MET WITH RISK** — `SM-10.9`'s inverted grammar lands on the `X-13` check (`SR-02`) |
| 4 Requirements Review | Testable · exclusions absolute · configurables bounded · **every AC maps to a requirement** · no restatement · no Rank 1 conflict | ⚠️ **MET WITH DEFECT** — 3 ACs map to the wrong requirement (`SR-06`); guardian cases A/B untested (`SR-10`) |
| 5 Traceability | Prefixes registered in `TRACEABILITY_MATRIX.md` §2, **mechanically verified**, zero collisions | ❌ **NOT MET** — §2C stale (`SR-01`) |
| 6 Implementation Tasks | Range allocated + task document tracing to requirements | ⚠️ **PARTIAL** — task document 6 tasks behind (`SR-01`) |

### 20.2 What blocks freeze

| # | Blocker | Severity | Fix | ADR? |
|---|---|---|---|---|
| 1 | `TRACEABILITY_MATRIX.md` §2C stale (242/9/28/9 → 248/10/30/10) | HIGH | Update counts, ranges, per-chapter table. **Unranked** | No |
| 2 | `PRD-004_IMPLEMENTATION_TASKS.md` stops at `IMPL-317` | HIGH | Add `IMPL-318`…`IMPL-323`. **Unranked** | No |
| 3 | Three negated-MUST requirements (`SM-10.9`, `SM-7.14`, `LMD-24a`) | HIGH | Rewrite as `MUST NOT`. Inside `PRD-004` | No |
| 4 | Guardian cases A and B have no acceptance criterion | MEDIUM | Add two criteria (→ `SM-AC-31`, `SM-AC-32`) | No |

### 20.3 Strongly recommended, not blocking

`SR-03` (lead §5.4 with `SID-2.7`), `SR-06` (fix 3 `Verifies` cells), `SR-04` (record `BC-26`'s status), `SR-08` (§2.4 → §2.2).

### 20.4 Not `PRD-004`'s to fix

| Item | Owner |
|---|---|
| `G-1` — `PRD-003` DOB tension (`RF-17`, `SM-GAP-10`) | `BC-10` owner, **ADR required** |
| `G-2` — BC Map §8 vs §7 on `BC-26` (`SR-05`) | Architecture owner, **ADR required** |
| Gate 3 red — `ADR-0012` debts | `TASK-D10`/`BLK-01` (P0, expires 2026-10-31) |
| `SM-GAP-1`…`SM-GAP-9` | Named owners; correctly deferred |

### 20.5 Cost of the remaining work

All four blockers are **text edits to unranked or draft documents**. No ADR. No ranked document. No code. No architectural decision. Estimated scope: two count tables, six task rows, three requirement rewrites, two acceptance criteria.

That is the profile of a **B**, not a **C**. A `C` would mean requirements must be redesigned; a `D` would mean the architecture is wrong. Neither is the case: the architecture **passed**, on both Priority 1 and Priority 2, under adversarial examination.

### 20.6 What the correction pass got right — recorded, because a review that reports only defects is not a review

- **It did not touch what it was forbidden to touch.** 9 ranked/frozen documents and the entire ADR directory verified byte-identical; no application code changed.
- **It reported a worse number about itself.** 96.3% asserted → 92.9% measured, with the reason stated and the direction of travel called out explicitly.
- **It shipped the tool that can disprove it.** `tool/docs_check/prd004_traceability.py` is committed and exits 1; anyone can re-run it, and I did.
- **It refused to resolve what it did not own** — `RF-17` escalated, `SM-4.5c` forbidding self-resolution, `SM-GAP-9` refusing to invent an attendance formula, `SM-GAP-1` refusing to invent a retention period.
- **It kept `SM-GAP-4` open while making §8.2 executable** — an interim deny that explicitly disclaims being an answer. That is the hardest pattern to get right and it got it right.
- **It downgraded a wrong citation instead of deleting it** (`SM-2.14`'s note that `MP-GBR-16` is *"analogous rather than authoritative"*), preserving the audit trail.
- **It recorded its rejections with reasons**, which `PRD_LIFECYCLE.md` Stage 3 demands and which distinguishes a real review from a rubber stamp.

---

## 21. Final Verdict

> ## **B — MINOR CORRECTIONS REQUIRED**

`PRD-004` is architecturally valid, internally consistent in substance, traceable at a measured and reproducible 92.9%, and testable through 30 acceptance criteria that all name what they verify. Its central architectural claim — the Library Members Directory as an application-layer read composition, not a new bounded context — **survives adversarial examination and PASSES**, authorised by `SID-2.7`/`SID-2.38`–`2.41` at Rank 3 and classified by `AR-1` at Rank 5. `SM-EV-10` is correctly owned, correctly consented, correctly payload-limited and **PASSES**. `BC-01` remains the sole owner of `StudentRecord`. No bounded context was created. No BC Map edge was added or implied. No module dependency became illegal. No frozen document was touched. No `ADR` is required *by `PRD-004`*.

Four defects block the freeze, and all four are text edits: two stale unranked supporting documents (`SR-01`), three requirements whose negated-MUST grammar states the opposite of their intent (`SR-02`), and two missing acceptance criteria on the guardian/DOB paths (`SR-10`). None requires an architectural decision. None requires touching a ranked document. None requires code.

This is **not** verdict `A`, because `PRD_LIFECYCLE.md` Stage 5's mechanically-verified-registration gate is currently **disproved by a tool**, and because `SID-4.56` — the PRD's own governing principle — does not permit treating a rule that says the opposite of its intent as satisfied by intent. It is **not** `C`, because no requirement needs redesigning. It is **not** `D`, because the architecture is sound.

---

### The four closing questions

| Question | Answer | Because |
|---|---|---|
| **Can `PRD-004` be frozen?** | **NO** | Four blockers: `SR-01` (Stage 5 gate disproved by a tool — matrix §2C says 242/9/28/9, reality is 248/10/30/10; task document stops at `IMPL-317` vs `IMPL-323`), `SR-02` (`SM-10.9`, `SM-7.14`, `LMD-24a` state the opposite of their intent, and `SM-10.9` carries `X-13`), `SR-10` (guardian cases A and B have no acceptance criterion). All four are text edits to unranked or draft documents |
| **Are corrections required?** | **YES** | 4 blocking (`SR-01` ×2, `SR-02`, `SR-10`) + 4 strongly recommended (`SR-03`, `SR-04`, `SR-06`, `SR-08`). **No ADR, no ranked document, no code, no architectural decision** |
| **Is an ADR required?** | **YES — but not for `PRD-004`, and not caused by it.** Two external items: **`G-1`** the `PRD-003` §2.2-Optional vs `SID-5.9` DOB tension, internal to a frozen Rank 3 document, owned by the `BC-10` owner (`RF-17`/`SM-GAP-10`) — `PRD-004` is interpretation-independent via `SM-4.5a`/`b`/`c` and can freeze while it is open. **`G-2`** BC Map §8 names `BC-26` a consumer of two `BC-01` events while §7 declares no such edge, and L292 requires an ADR to add one (`SR-05`). **`PRD-004` itself requires no ADR** |
| **Can implementation begin?** | **NO** | Three independent reasons. **(1)** `PRD-004` is `DRAFT`, not frozen — `PRD_REGISTRY.md` L224; implementing an unfrozen PRD builds against a moving specification. **(2)** Its own supporting documents disagree with it about how many requirements, events, criteria and tasks exist (`SR-01`), so an implementer cannot know the scope. **(3)** Gate 3 is red on pre-existing `ADR-0012` debt owned by `TASK-D10`/`BLK-01` (P0, expires 2026-10-31) — **not caused by `PRD-004`**, but it blocks merge regardless. Fix the four blockers, freeze the PRD, then begin at `IMPL-300` |

---

## Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-04 | Second independent review of `PRD-004` at commit `a030b078982c446f8d73bda9cba559aceddc6122`. 6-persona board. 17 findings (0 CRITICAL · 2 HIGH · 5 MEDIUM · 7 LOW · 3 OBSERVATION). `RF-01`/`AR-1`: **PASS**. `SM-EV-10`: **PASS**. Traceability 221/238 = 92.9% **independently reproduced**; all 17 untraced identifiers hand-verified. All 21 first-review findings reconciled: 17 resolved · 2 partial · 1 rejection upheld · 1 correctly escalated · **0 unresolved** · **0 incorrectly reported**. 3 newly-introduced defects identified. Verdict **B — MINOR CORRECTIONS REQUIRED**. No document was modified; `PRD-004` was not frozen |

---

**END OF REVIEW.**
