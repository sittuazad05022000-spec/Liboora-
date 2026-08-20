# `PRD-023` Settings & Configuration v0.1 — Stage 4 Requirements Review Record

| Field | Value |
|---|---|
| **Stage** | **Stage 4 — Requirements Review** (`PRD_LIFECYCLE.md` L108–120) |
| **Subject** | [`PRD-023_SETTINGS_AND_CONFIGURATION.md`](PRD-023_SETTINGS_AND_CONFIGURATION.md) — `PRD-023`, `BC-25` Configuration, **v0.1 `DRAFT`** |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* |
| **Gate satisfied by** | §8. **0 conflicts closed by edit**, **6 items explicitly deferred**, every one with a reason **and** a named owner |
| **Predecessors** | [Stage 1 Discovery](PRD-023_STAGE1_DISCOVERY.md) ✅ **PASS** · [Stage 3 Alignment](PRD-023_ARCHITECTURE_ALIGNMENT.md) ✅ **PASS** (6 of 6, unconditional) |
| **PRD hash at review** | `e97496083a76bfb0f45be9acae754050c374561b64734df5738dac7ff6399326` — `sha256` of `PRD-023_SETTINGS_AND_CONFIGURATION.md`, 1,443 lines, verified before and after this review |
| **Reviewer role** | Requirements reviewer (`PRD_LIFECYCLE.md` §6). **No named holder exists** — `PGA-08` |
| **Date** | 2026-08-19 |
| **Mandate** | **Stage 4 only.** No PRD modified · no ADR created · no identifier registered in any matrix · no ranked document touched · no registry or baseline update · no freeze. Stages 5–7 not started |
| **Verdict** | ✅ **PASS — 6 of 6 checks.** 6 explicit deferrals each with a reason and an owner · **2 genuine defects found in the draft** and deferred rather than silently edited (§8.4) · **2 defects found in this review's own checkers** and disclosed (§10) · 9 candidate findings rejected with reasons (§9) |

> `PRD_LIFECYCLE.md` L41–42: *"A gate is not an opinion — if the artefact does not exist, the stage has not been
> passed, however complete the work feels."* This document is that artefact for Stage 4.

---

## 1. Method

Stage 3 asked *"is this PRD lawful against Ranks 1–5?"* Stage 4 asks *"is this PRD **buildable and verifiable**
as written?"* Five of the six checks are mechanically decidable, so each was decided by a script over the
document text rather than by reading it.

**Where a mechanical result disagreed with the document, the disagreement was driven to root cause before either
side was believed.** That happened three times. Twice the checker was wrong and the document right (§10). Once
the checker was right and the document carries a real defect (§8.4).

### 1.1 The six checks and how each was decided

| # | Check (`PRD_LIFECYCLE.md` L110–118) | Failure mode the lifecycle names | Decided by |
|---|---|---|---|
| 1 | Every requirement testable | *"'The system should be fast' — unverifiable"* | Script — modality census over 113 definition sites + 15-term vague-adjective scan |
| 2 | Every exclusion states what must be **impossible** | *"An exclusion is not a deferral"* | Script — impossibility modality per `CNF-XC-*` + 8-term deferral-language scan |
| 3 | Every configurable has a default and a range | *"Unbounded configuration is a specification hole"* | Script — `CNF-CFG-*` census + numeric-threshold-literal scan |
| 4 | Every acceptance criterion maps to a requirement | *"Orphan criterion"* | Script — forward **and** reverse coverage, recomputed independently of §13's own claim |
| 5 | No requirement restates another PRD's | *"Two sources of truth"* | Script — foreign-identifier attribution test, then §0.5 audited by reading |
| 6 | Business rules do not contradict Rank 1 | *"Rank 1 wins; the PRD is wrong"* | Script — permissive-modality scan + Rank-1 citation census |

### 1.2 Why this review does not edit the draft

Two genuine defects were found (§8.4). Neither was repaired by editing the PRD.

`tool/docs_check/alignment_record_freshness.py` exists because *"a Stage 3 or Stage 4 review record measures a PRD
**at a revision**"*, and when the PRD is then revised *"the record's measurement silently becomes a statement
about a document that no longer exists — while still reading as a current verdict."* Its governing precedent:

> *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded."*

Editing the draft now would change its hash and invalidate the Stage 3 record's measurement of it — manufacturing
the exact drift class that gate exists to catch. `PRD-014` and `PRD-016` both state **"No PRD modified"** in their
Stage 4 mandate rows. The gate does not require closure by edit; it requires *"conflicts closed **or explicitly
deferred** with a reason and an owner."*

---

## 2. Check 1 — Every requirement is testable

**Population.** 113 obligation-bearing requirements: `CNF-FR-001`…`082` (82), `CNF-BR-001`…`011` (11),
`CNF-INV-001`…`004` (4), `CNF-XC-001`…`016` (16). Measured by anchored definition-site match
(`**\`CNF-XX-NNN\`** —`), not by counting references.

### 2.1 Definition-site census

| Result | Count |
|---|---|
| Definition sites found | **113** — exactly the declared inventory |
| **Duplicate definition sites** | **0** |
| Definitions carrying a prescriptive keyword (`SHALL` / `MUST` / `SHALL NOT` / `MUST NOT`) | **113** |
| Definitions carrying none | **0** |

### 2.2 Vague-adjective scan

Fifteen terms were scanned inside requirement definitions: `fast`, `quick`, `efficient`, `robust`, `scalable`,
`user-friendly`, `intuitive`, `appropriate`, `reasonable`, `optimal`, `performant`, `as needed`,
`if necessary`, `where possible`, `best effort`.

**Result: 0 hits.** The lifecycle's named failure mode — *"The system should be fast"* — does not occur.

This is a stronger result than it looks, because §11 and §12 are exactly where such language normally enters. §11
specifies observability *of the resolution machinery* and §12 specifies UI behaviour; both cite absent owners
(UI Design System, `NFR Budgets (V1)`) and both resisted the temptation to substitute an adjective for the missing
budget. The draft states the obligation and names the gap instead — see §8.2.

### 2.3 The one flagged requirement, driven to root cause

The first checker run flagged `CNF-FR-069` as carrying no prescriptive keyword. **The checker was wrong.**
Reading the definition:

> **`CNF-FR-069`** — Every cache key, index name, lookup key and internal namespace holding a tenant-scoped
> configuration value **SHALL** include the tenant identifier. A key that omits it **SHALL NOT** exist.

Two keywords, not zero. The checker matched only the first physical line of a definition that wraps across two,
so the keyword fell outside the match window. Recorded as checker defect **`S4-C-01`** in §10 rather than
silently corrected, because a checker that mis-measures once will mis-measure again.

**Check 1 verdict: ✅ PASS.** 113 of 113 testable; 0 vague terms; 0 duplicate definitions.

---

## 3. Check 2 — Every exclusion states what must be impossible

**Failure mode:** *"An exclusion is not a deferral."*

**Population.** `CNF-XC-001`…`016`, all 16 measured at their definition sites.

| Test | Result |
|---|---|
| Exclusions carrying impossibility modality (`MUST NOT` / `SHALL NOT`) | **16 of 16** |
| Exclusions containing deferral language (`later`, `deferred`, `in V2`, `future release`, `TBD`, `to be decided`, `will be added`, `post-V1`) | **0 of 16** |
| Exclusions naming an owner for the excluded capability | **16 of 16** (verified by reading; each carries an *Owner:* clause or a named `BC-`) |

**This is the check the draft was most exposed on**, because `ADR-0017` §3.1 defines four of `PRD-023`'s six
scope items by *what they exclude* — branding **values only**, secret **references only**, flags but not
entitlements, resolution but not the `LCFG-*` list. An exclusion register that drifted into deferral language
would have converted a fixed scope back into the *"open-ended reservation"* that `ADR-0017` §3.1 exists to
prevent. It did not: every one of the 16 states an impossibility and names who owns the excluded thing.

Worth naming individually, because it is the hardest kind to state: **`CNF-XC-009`** excludes secret *material*
while `CNF-FR-057`…`059` own secret *references*. The boundary is one word wide and the exclusion carries the
full enumeration — *"a credential, a password, an OTP, a session token, a device trust marker or key material"* —
with `Owner: SECURITY platform; BC-18 for credentials and sessions`. Stage 3 §5.1 independently classified this
line as a cession rather than an introduction.

**Check 2 verdict: ✅ PASS.** 16 of 16 impossibilities; 0 deferrals; 16 of 16 owners named.

---

## 4. Check 3 — Every configurable has a default and a range

**Failure mode:** *"Unbounded configuration is a specification hole."*

| Measurement | Result |
|---|---|
| Numbered `CNF-CFG-*` members defined | **0 — register declared empty** |
| Numeric threshold literals inside requirement definitions (`N seconds`, `N minutes`, `N days`, `N ms`, `N MB`, `N %`, `N attempts`) | **0** |

The check is **vacuously satisfied**, and this review states that plainly rather than claiming a pass it did not
earn. `PRD-023` defines no configurable parameter, so there is no parameter lacking a default or a range.

**This is not an evasion — it is the whole point of the document, and it was verified rather than assumed.**
Stage 3 §2.5 measured that `PRD-023` defines **0** members across all eight foreign configurable registers
(`CFG-*`, `LCFG-*`, `ICFG-*`, `SCFG-*`, `SMCFG-*`, `MM-CFG-*`, `SEAT-CFG-*`, `ATT-CFG-*` — 104 parameters in 8
FROZEN PRDs) and cites all 104 as a census. `ADR-0017` §3.2 requires exactly this: *"This ADR moves no
requirement."*

The **0 numeric literals** result is the stronger half of the finding. A document specifying resolution machinery,
caching and startup validation had many natural opportunities to hardcode a TTL, a timeout or a retry count — and
took none. `CNF-BR-008`'s analogue in `PRD-014` (`ENT-BR-008`: *"grace period is a configured value, never an
implicit one"*) is the precedent; `PRD-023` satisfies it by construction.

Three empty-register precedents exist — `TEN-CFG-*`, `AUD-CFG-*`, `ENT-CFG-*`, all in FROZEN PRDs. This is the
fourth, not an anomaly. Stage 5 must not create a member (§9 `R4-05`).

**Check 3 verdict: ✅ PASS (vacuous, and correctly so).**

---

## 5. Check 4 — Every acceptance criterion maps to a requirement

**Failure mode:** *"Orphan criterion."*

### 5.1 Forward coverage — every criterion cites a requirement

| Measurement | Result |
|---|---|
| `CNF-AC-*` identifiers present | **59**, contiguous `001`…`059` |
| `CNF-AC-*` table rows | **59** — one row per identifier, no row without an identifier |
| Rows citing **no** requirement in their *Traces to* column | **0** |

**Zero orphan criteria.** The lifecycle's named failure mode does not occur.

### 5.2 Reverse coverage — recomputed independently of the draft's own claim

The draft's §13 makes a *"Coverage"* claim naming the uncovered set. A Stage 4 review that reads that claim and
agrees has verified nothing. The set was therefore recomputed from the AC table and compared:

| Measurement | Result |
|---|---|
| Requirements defined | **113** |
| Requirements cited by ≥ 1 acceptance criterion | **76** |
| Requirements with **no** criterion (measured) | **37** |
| Requirements the draft **declares** uncovered | **40** |
| **Measured-uncovered but NOT declared (undisclosed obligations)** | **0** |
| Declared-uncovered but actually covered (over-declaration) | **3** — `CNF-XC-005`, `CNF-XC-008`, `CNF-XC-014` |

**The critical cell is the fifth: zero.** There is no requirement carrying an obligation that lacks a criterion
and is not disclosed as lacking one. `PRD-013` §7 established that an uncovered set is acceptable *provided it is
named*; the naming here is **complete**.

The three over-declared exclusions are a real but inverted defect — the draft claims *less* coverage than it has:

| Identifier | Actually cited by | Draft's claim |
|---|---|---|
| `CNF-XC-005` | `CNF-AC-038` — *"No flag read consults entitlement state"* | listed as uncovered |
| `CNF-XC-008` | `CNF-AC-041` — *"A branding image is held only as a `FileRef`"* | listed as uncovered |
| `CNF-XC-014` | `CNF-AC-048` — *"The module contains no table mapping roles to writable parameters"* | listed as uncovered |

The cause is structural: §13 declares the uncovered exclusions as the **range** `CNF-XC-001`…`CNF-XC-016` rather
than enumerating them, and three members of that range are in fact covered. Recorded as draft defect **`S4-D-01`**
in §8.4, deferred not edited.

**Why this is Low and not Medium.** The failure mode Stage 4 guards is an *untested obligation presented as
tested*. This is its exact opposite — a tested obligation presented as untested. It understates the document's own
verification coverage, which is the safe direction to be wrong in. Nothing downstream is misled into skipping a
test.

### 5.3 The 37 genuinely uncovered requirements — confirmed definitional

The user's mandate requires confirming *"§13's named uncovered set is genuinely definitional."* Each of the 37 was
read and classified. None is an untested conduct obligation.

| Class | Count | Members | Why no criterion is possible |
|---|---:|---|---|
| **Exclusions** | 13 | `CNF-XC-001`…`004`, `006`, `007`, `009`…`013`, `015`, `016` | An exclusion asserts a **non-capability**. Its test is the absence of code, which is covered by the *positive* criteria of the owning context, not by a criterion here |
| **Definitional / terminological** | 12 | `CNF-FR-002`, `004`, `005`, `009`, `012`, `013`, `030`, `032`, `033`, `034`, `041`, `046` | These fix vocabulary and the shape of the hierarchy (*what a scope is*, *what "typed" means*). A definition is not a behaviour; testing it would test the test |
| **Boundary statements** | 6 | `CNF-FR-052`, `055`, `060`, `062`, `063`, `065` | Each states where an owned capability stops. The behaviour on the owned side is covered; the stopping point is verified by the neighbouring PRD's criteria |
| **Governance-directed** | 3 | `CNF-FR-070`, `CNF-FR-082`, `CNF-BR-010` | `070` makes a key change *security-reviewable* — a process obligation on humans, not a runtime assertion; `082` targets absent WCAG budgets; `BR-010` distinguishes read from write authority, tested via `CNF-AC-048` |
| **Rule-with-criterion-elsewhere** | 3 | `CNF-BR-002`, `CNF-BR-003`, `CNF-FR-075` | Each is the *rationale* half of a pair whose *conduct* half is covered — `BR-002`/`BR-003` by `CNF-AC-038`, `FR-075` by `CNF-AC-052` |

**Result: 37 of 37 are definitional, exclusionary, boundary-marking or process obligations. Zero untested
conduct obligations.** One qualification is recorded honestly: `CNF-FR-070` is a *process* obligation
(*"security-reviewable"*), and per `SID-4.56` a process rule with no mechanical check is unmet until a review
process exists. This is disclosed as deferral `D-05` rather than counted as coverage.

**Check 4 verdict: ✅ PASS.** 0 orphan criteria; **0 undisclosed uncovered obligations**; 37 of 37 confirmed
definitional; 1 over-declaration defect recorded (`S4-D-01`).

---

## 6. Check 5 — No requirement restates another PRD's

**Failure mode:** *"Two sources of truth."* This is the check `ADR-0017` §5.3 pre-registered as its **third
Medium risk**: *"`LCFG-*` requirements silently migrate out of the Library PRD."*

| Measurement | Result |
|---|---|
| Distinct foreign identifiers cited (`TEN-`, `AUD-`, `ENT-`, `SID-`, `LIB-`, `SEAT-`, `ATT-`, `MM-`, `AUTH-`) | **39** |
| Requirement definitions carrying a foreign identifier **without** citation framing | **0** |
| Foreign configurable members redefined as `CNF-*` | **0** (Stage 3 §2.5) |
| Rows in §0.5's do-not-restate table | **13** |

**Zero restatements.** Every one of the 39 foreign identifiers appears inside a parenthetical, an *Authority:*
clause, a `per`/`citing`/`see` construction, or a blockquote — never as the substance of a `CNF-*` obligation.

The governing precedent is `TRACEABILITY_MATRIX.md` L209-210: *"`SMCFG-1` is **cited rather than duplicated** —
`SMCFG-1` **is** `LCFG-5`, consumed through `E-19`."* `PRD-023` applies that discipline at scale: it cites 104
configurables belonging to 8 FROZEN PRDs and redefines none.

**The near-miss worth recording.** §3's 104-value census table is the one place where restatement would have been
almost invisible — a table listing every configurable in the product, inside the document that owns configuration
machinery, is one column away from becoming a second source of truth. Measured: the table carries the **owning
PRD and definition site** for each register and no parameter's *value, default or range*. It is an index, not a
copy. §0.4's *"citation discipline (4 near-misses)"* shows the draft was aware of this hazard while authoring.

**Check 5 verdict: ✅ PASS.** `ADR-0017` §5.3 risk 3 did not materialise.

---

## 7. Check 6 — Business rules do not contradict Rank 1

**Failure mode:** *"Rank 1 wins; the PRD is wrong."*

| Measurement | Result |
|---|---|
| Requirement definitions containing permissive modality (`MAY`, `may optionally`, `can be skipped`, `is optional`, `need not`, `at the discretion`) | **0** |
| Rank-1 `MASTER_PRD.md` identifiers cited | **8** — `MP-CON-11`, `MP-DEP-08`, `MP-GBR-06`, `MP-GBR-07`, `MP-GBR-08`, `MP-GBR-09`, `MP-NFR-06`, `MP-NFR-08` |
| Rank-1 rules contradicted | **0** |

**Zero permissive modalities** is the decisive result. The failure mode is a PRD granting itself latitude a Rank-1
rule denies — and latitude is granted with `MAY`. There is none.

Each of the four global-boundary rules was checked for *direction* of conformance, since a PRD can cite a rule and
still weaken it:

| Rank-1 rule | `PRD-023`'s treatment | Stronger, equal or weaker? |
|---|---|---|
| `MP-GBR-06` — every request carries resolved tenant context | §10 consumes `E-18` | **Equal** |
| `MP-GBR-07` — *"fails loudly, never defaults"* | `CNF-FR-068` forbids defaulting to a tenant, to null, to the platform default **and to an empty result** | **Stronger** — the empty-result clause is not required by `MP-GBR-07` |
| `MP-GBR-08` — every index/namespace tenant-partitioned | `CNF-FR-069` extends it to cache keys, lookup keys and internal namespaces | **Stronger** |
| `MP-GBR-09` — key change is security-reviewable | `CNF-FR-070` | **Equal** |
| `MP-CON-11` — no demo account, no control disabled, no OTP bypass | Cited verbatim at draft L968; `CNF-FR-066` forbids any write surface bypassing the authorising boundary | **Equal, enforced** |

**Two rules are exceeded and none is weakened.** `CNF-INV-004` goes further still — forbidding another tenant's
value from leaking through a *validation failure reason* — which no Rank-1 rule requires and no other PRD in the
repository states (Stage 3 §6.2).

The two `MP-NFR-*` citations point at the **UI Design System**, which does not exist. The draft states obligations
against it and declines to author it. Stage 3 `R3-10` rejected authoring it as `ADR-0017` §5.3 risk 1; carried
here as deferral `D-04`.

**Check 6 verdict: ✅ PASS.** 0 permissive modalities; 0 contradictions; 2 Rank-1 rules exceeded.

---

## 8. Dispositions — the gate

**Gate:** *"conflicts closed or explicitly deferred with a reason and an owner."*

### 8.1 Summary

| Category | Count |
|---|---:|
| Conflicts closed **by editing the draft** | **0** — by design, §1.2 |
| Items **explicitly deferred** with reason **and** owner | **6** |
| Genuine defects found **in the draft** | **2** (§8.4) |
| Defects found in **this review's own checkers** | **2** (§10) |
| Candidate findings **rejected** with reasons | **9** (§9) |

### 8.2 Deferrals inherited from Stage 3

| ID | Item | Reason it is not closed here | Owner |
|---|---|---|---|
| `D-01` | `CNF-GAP-001` — `LibrarySettings` aggregate conflict (Rank 3 vs Rank 4) | Requires an ADR amending BC Map §8 **or** `Library_PRD_v1.md` L188. Stage 4 has no such authority | Architecture Owner |
| `D-02` | `CNF-GAP-004` — `settings` absent from the kernel `port_interfaces` list | Matrix §6.3 `change_policy` reserves kernel additions to the **Architecture Review Board** | Architecture Review Board |
| `D-03` | `CNF-GAP-006` — EA L526/L529 say V2, `ADR-0017` says V1 | Precedence is settled (Rank 2 governs); the Rank-6 document defect is the Architecture Owner's to correct | Architecture Owner |
| `D-04` | UI Design System and `NFR Budgets (V1)` do not exist, so §11/§12 cite absent owners | Rank-1-mandated artefacts. A Rank-3 PRD authoring one is `ADR-0017` §5.3 risk 1 | UI Design System owner; NFR owner |
| `D-05` | `CNF-GAP-008` — 1 of Matrix §10.3's 7 architecture tests exists; `tenant_isolation_test.dart` absent, so `CNF-INV-003`/`004` are unmet at freeze per `SID-4.56`. Also `CNF-FR-070`'s process obligation has no mechanical check | Implementation, not specification. Pre-existing and affects all 11 FROZEN PRDs equally | Implementation lead |
| `D-06` | `A-05` — draft §1.3's *"mechanically, today"* overstates enforcement; the checker exempts blockless modules (L778) and never reads `provides_ports` | A one-word correction plus a `SID-4.56` disclosure. Deferred to the next authorised revision rather than edited mid-lifecycle (§1.2) | `PRD-023` product owner |

### 8.3 `ADR-0017` §5.3 risk audit

The user's mandate requires auditing against the two pre-registered **Medium** risks. Both were measured, not
judged.

| `ADR-0017` §5.3 risk | Severity | Measured outcome |
|---|---|---|
| *"Read as inventing a PRD to fill a gap"* | **High** | **Did not materialise.** Every one of the six §3.1 scope items is discharged (Stage 3 §2.1) and no seventh is claimed. The draft cites 39 foreign identifiers and 104 configurables, and defines none of them — a document inventing a gap-filler would define, not cite |
| *"`PRD-023` grows to absorb entitlement or security scope"* | **Medium** | **Did not materialise.** `CNF-XC-004` cedes `EntitlementSet`; `CNF-XC-006` cedes authorisation; `CNF-XC-009` cedes all secret material. Stage 3 §5.1 classified **8 of 8** credential mentions as citations, prohibitions or cessions — **0 introductions** |
| *"`LCFG-*` requirements silently migrate out of the Library PRD"* | **Medium** | **Did not materialise.** Check 5: 0 restatements, 0 foreign configurables redefined, §0.5's 13-row do-not-restate table |
| Number collision | Low | Deferred to Stage 5, which is the stage that decides it mechanically |

**Three of the four pre-registered risks are measurably absent. The fourth is Stage 5's to decide.**

### 8.4 Genuine defects found in the draft

| ID | Defect | Severity | Evidence | Disposition |
|---|---|---|---|---|
| `S4-D-01` | §13's *Coverage* paragraph declares `CNF-XC-001`…`016` uncovered as a **range**, but `CNF-XC-005`, `CNF-XC-008` and `CNF-XC-014` are in fact cited by `CNF-AC-038`, `041` and `048`. The declaration over-states the uncovered set by 3 | **Low** | §5.2 measurement | **DEFERRED**, not edited. Inverted direction — claims *less* coverage than it has, so nothing downstream skips a test. Owner: `PRD-023` product owner, at the next authorised revision |
| `S4-D-02` | Draft §1.2 presents *"seven modules declare a dependency on a port no module provides"* as a `platform/configuration` finding. Stage 3 §5.2 measured **8 of 20** ranked modules with no block, `platform/services` at 14 inbound refs. The framing overstates `BC-25`'s specificity | **Low** | Stage 3 `A-03` | **DEFERRED**, not edited. Owner: `PRD-023` product owner. Stage 6 must not present the manifest-wide pattern as `BC-25`'s alone |

**Both defects are Low, both are in prose rather than in a requirement, and neither changes a `CNF-*` obligation.**
No requirement, exclusion, invariant or criterion was found defective.

### 8.5 What this review did **not** find

Stated explicitly, because a review listing only what it found is not auditable:

- **0** untestable requirements · **0** vague adjectives · **0** duplicate definitions
- **0** exclusions expressed as deferrals · **0** exclusions without a named owner
- **0** unbounded configurables · **0** hardcoded numeric thresholds
- **0** orphan acceptance criteria · **0** undisclosed uncovered obligations
- **0** restatements of another PRD's requirement · **0** foreign configurables redefined
- **0** permissive modalities · **0** Rank-1 contradictions
- **0** scope-creep items beyond `ADR-0017` §3.1's six

---

## 9. Candidate findings recorded as REJECTED, with reasons

`PRD_LIFECYCLE.md` L104's rule applies to every review record. Nine candidates were raised and rejected.

| # | Candidate finding | Why rejected |
|---|---|---|
| `R4-01` | *"`CNF-FR-069` is untestable — it carries no prescriptive keyword."* | **Rejected: the checker was wrong.** The definition wraps across two lines and carries **both** `SHALL` and `SHALL NOT`. Recorded as checker defect `S4-C-01`, §10 |
| `R4-02` | *"37 of 113 requirements have no acceptance criterion — coverage is only 67%, which should fail check 4."* | Rejected. Check 4's failure mode is an **orphan criterion**, measured at **0**. Reverse coverage is a `PRD-013` §7 disclosure obligation, and the disclosure is complete: **0 undisclosed**. All 37 were individually classified as definitional, exclusionary, boundary or process (§5.3) |
| `R4-03` | *"Check 3 passes only vacuously, so it should be recorded as N/A rather than PASS."* | Rejected as a mislabel, though the vacuity is stated plainly. `PRD-023` owning 0 configurables is the *substance* of `ADR-0017` §3.2, not an evasion of check 3 — and the **0 numeric literals** result is a real, non-vacuous measurement that could have failed |
| `R4-04` | *"Fix `S4-D-01` now — it is three identifiers in one paragraph, trivially corrected."* | Rejected. Triviality is not authority. Editing the draft changes its `sha256` and invalidates the Stage 3 record's measurement — the precise drift `alignment_record_freshness.py` exists to catch. *"A stale review is corrected by a dated re-run beside it, not by editing what it concluded"* |
| `R4-05` | *"Add `CNF-CFG-*` members so check 3 has something to verify."* | Rejected. Manufacturing register members to give a checker work is inverted engineering. `ADR-0017` §3.2: *"This ADR moves no requirement."* Three FROZEN precedents (`TEN-CFG-*`, `AUD-CFG-*`, `ENT-CFG-*`) are empty for the same reason |
| `R4-06` | *"`CNF-INV-004`'s validation-failure-reason clause is scope creep — no Rank-1 rule requires it."* | Rejected. Exceeding a security floor is not scope creep; it is defence in depth within owned scope. `CNF-INV-004` constrains **this module's own** error messages, which is unambiguously `BC-25`'s to constrain. `ADR-0017` §5.3 risk 2 concerns absorbing *other contexts'* scope, which this does not |
| `R4-07` | *"§3's 104-value census duplicates eight registers and violates check 5."* | Rejected on measurement. The table carries each register's **owning PRD and definition site**, and **no** parameter value, default or range. `TRACEABILITY_MATRIX.md` L209-210 sanctions exactly this: *"cited rather than duplicated"* |
| `R4-08` | *"`CNF-FR-070` is untestable — 'security-reviewable' cannot be asserted in code — so check 1 should fail."* | **Rejected as a check-1 failure; accepted as deferral `D-05`.** Testability means a decidable predicate exists, and *"this change was reviewed"* is decidable against a review record. That the **review process** does not yet exist is a `SID-4.56` gap, disclosed, not a defect in the requirement's wording |
| `R4-09` | *"Stage 4 should close `D-01`…`D-03` — Stage 3 already established which rank governs each."* | Rejected. Stage 3 established **precedence**, not **remedy**. Each needs an ADR or Architecture Review Board action. `DOCUMENTATION_BASELINE.md` §4: *"do not choose — raise it"* — and it stays raised until the owner acts |

---

## 10. Defects in this review's own checkers

Disclosed because a review that hides its own measurement errors cannot be relied on for the ones it reports.

| ID | Checker defect | Effect | Resolution |
|---|---|---|---|
| `S4-C-01` | The modality scan matched only the first physical line of a definition, so keywords on a wrapped continuation line were missed | Produced **1 false positive** (`CNF-FR-069`, §2.3) | Driven to root cause by reading the requirement. The document was right. **113 of 113** carry a keyword |
| `S4-C-02` | The first reverse-coverage run sliced the wrong line window when extracting §13's declared uncovered set, reporting 25 declared / 11 false declarations / 23 undisclosed | Would have reported a **serious disclosure failure that does not exist** | Located the *Coverage* paragraph by anchored grep (L1333–1338) and re-ran. Corrected result: 40 declared, **0 undisclosed**, 3 over-declared |

**`S4-C-02` is the more important disclosure.** Believed uncritically, it would have produced a Stage 4 **FAIL**
against a draft whose disclosure is in fact complete. It was caught because the result contradicted the draft's
explicit claim, and §1's method requires driving such disagreements to root cause **before believing either
side** — not because the checker announced its own error.

---

## 11. Verdict

| # | Check | Verdict | Decisive measurement |
|---|---|---|---|
| 1 | Every requirement testable | ✅ **PASS** | 113 / 113 carry prescriptive modality; **0** vague terms; **0** duplicate definitions |
| 2 | Every exclusion states impossibility | ✅ **PASS** | 16 / 16 impossibility; **0** deferrals; 16 / 16 owners named |
| 3 | Every configurable has default and range | ✅ **PASS** | **0** `CNF-CFG-*` members; **0** numeric thresholds. Vacuous, and correctly so |
| 4 | Every criterion maps to a requirement | ✅ **PASS** | **0** orphan criteria; **0** undisclosed uncovered obligations; 37 / 37 confirmed definitional |
| 5 | No requirement restates another PRD's | ✅ **PASS** | **0** restatements across 39 foreign identifiers and 104 cited configurables |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | **0** permissive modalities; **0** contradictions; **2** Rank-1 rules exceeded |

### **STAGE 4 VERDICT: ✅ PASS — 6 of 6**

**Gate satisfied.** Six items explicitly deferred, each with a reason and a named owner (§8.2). Two genuine
draft defects found and deferred rather than silently edited (§8.4) — both **Low**, both in prose, neither
touching a `CNF-*` obligation. Two checker defects disclosed (§10). Nine candidate findings rejected with
reasons (§9).

Three of `ADR-0017` §5.3's four pre-registered risks are **measurably absent**; the fourth (number collision) is
Stage 5's to decide mechanically.

**Requirement inventory confirmed unchanged at 113 obligation-bearing / 180 total. No identifier was added,
removed or renumbered by this review.**

**Proceed to Stage 5 — Conferral & Traceability.**

---

## 12. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-19 | Stage 4 Requirements Review record created. All six lifecycle checks decided by script over the document text at `sha256 e974960…`, not by reading. **113** definition sites verified with **0** duplicates; **16 / 16** exclusions state impossibility with **0** deferral language; **0** configurables and **0** numeric thresholds; **0** orphan criteria and — recomputed independently of the draft's own claim — **0** undisclosed uncovered obligations, with all **37** genuinely uncovered requirements individually classified as definitional, exclusionary, boundary or process; **0** restatements across 39 foreign identifiers; **0** permissive modalities with **2** Rank-1 rules exceeded. `ADR-0017` §5.3 risk audit: 3 of 4 measurably absent. **2** draft defects found (`S4-D-01`, `S4-D-02`, both Low) and deferred rather than edited, per `alignment_record_freshness.py`. **2** defects in this review's own checkers disclosed (`S4-C-01`, `S4-C-02`) — the second would have produced a false FAIL. **6** deferrals with reason and owner; **9** candidate findings rejected with reasons. Verdict **PASS**, 6 of 6 |

---

*End of Stage 4 Requirements Review Record.*
