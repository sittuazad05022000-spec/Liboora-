# ADR-0064 — `PRD-012a` Security Automation v0.8 admitted to the baseline at Rank 3

| Field | Value |
|---|---|
| **Status** | `Accepted` |
| **Date** | 2026-08-21 |
| **Deciders** | **Governance owner** — the role `PRD_LIFECYCLE.md` §6 **L282** assigns *Stage 7; the baseline* — exercised by **direct conferral** from the human principal of this engagement, in the form `ADR-0033` §7.2 records and `ADR-0049`…`ADR-0054` have each exercised |
| **Subject** | `PRD-012a` Security Automation, **Parts 1–8**, at **v0.8** — `docs/30-product/security/PRD-012a_SECURITY_AUTOMATION.md` and `PRD-012a_PART2…PART8_*.md` |
| **Amends** | **No ranked document's content.** Admits a document to **Rank 3** and records the admission in `DOCUMENTATION_BASELINE.md` §3.1/§3.3/§4/§6/§8, `ADR-INDEX.md`, `PRD_REGISTRY.md` §4.1/§7 and `TRACEABILITY_MATRIX.md` §2N.2 |
| **Baseline** | **`BASELINE-2026-08-21-A`** — issued because a **Rank 3** document enters the baseline (§7 rule 4). Supersedes `BASELINE-2026-08-20-C` |
| **Closes** | `SECP-ADR-005`; `SECP-DEP-007`; `SECP-GAP-012`, `SECP-GAP-013`, `SECP-GAP-044`; Stage 7 blockers **`B7-1`** and **`B7-2`**; registry `PLANNED` → `FROZEN`; retires `PRD-012` |
| **Precedence** | **Rank 2** as an accepted ADR. It confers Rank 3 on its subject; it does not itself hold Rank 3 |

---

## 1. The question

**May `PRD-012a` Security Automation, Parts 1–8 at v0.8, be admitted to `DOCUMENTATION_BASELINE.md` §3 at an
assigned precedence rank — and if so, at which rank and with what scope?**

`PRD-012a` asks this of itself as `SECP-ADR-005`. Part 8 §8 states the request correctly and does not answer it:
*"These are **requests**, not decisions."* Stage 7's gate is *"a row in `DOCUMENTATION_BASELINE.md` §3 at an
assigned precedence rank"*, and `PRD_LIFECYCLE.md` L160 fixes who may write it: **freeze is *conferred, not
claimed***.

Two things made this question harder than its five predecessors, and both are now settled by decisions this ADR
**cites rather than makes**:

1. `PRD-012a` **owns no bounded context** — settled by `ACCEPTED` `ADR-0060`, which determined the SECURITY
   platform gets **no** `BC-nn` and that Stage 1 is **`NOT APPLICABLE`** because its gate is context-scoped.
2. Every Rank 3 row in §4 was believed to be bounded-context scoped, which would have left a platform-scoped
   document with **no lawful row shape**. **That belief is false** — see §2.2.

---

## 2. Evidence

### 2.1 The prior gates, measured rather than assumed

| Stage | Gate (`PRD_LIFECYCLE.md`) | State | Evidence |
|---|---|---|---|
| **1 — Discovery** | Four questions + a `BC-nn` gate | **`NOT APPLICABLE`** | `ACCEPTED` `ADR-0060` §4. The gate is context-scoped and does not *reach* a platform-scoped specification. **No `BC-32` was created** |
| **2 — Draft** | Version/status header; registers declared up front with ranges | **MET** | Part 1 §0.2/§0.3 publish all 15 registers with ranges before use; four are declared **CLOSED** and three **EMPTY** with reasons |
| **3 — Architecture** | Architecture reviewer's alignment | **CONFERRED** | `PRD-012a_ARCHITECTURE_ALIGNMENT.md` L10 — *"⚠ ALIGNED WITH ONE STRUCTURAL FINDING — 5 of 6 checks PASS, 1 PASS-BY-CONSTRUCTION-WITH-FINDING"*. The structural finding **is** the no-`BC-nn` question, now closed by `ADR-0060` |
| **4 — Requirements** | Requirements reviewer's review | **CONFERRED** | `PRD-012a_STAGE4_REQUIREMENTS_REVIEW.md` L10 — *"✅ PASS — 6 of 6 checks"* |
| **5 — Traceability** | Prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, **verified mechanically**, zero collisions | **MET** | Matrix **v1.18 §2N**: **427** identifiers / **15** registers / **all 15 contiguous** / **0 collisions in four directions**. `SECP-DEP-006` is discharged by this section's existence |
| **6 — Implementation tasks** | Task backlog with an allocated `IMPL-*` range | **PASS** | `PRD-012a_STAGE6_IMPLEMENTATION_TASKS.md` L15 — *"✅ A — PASS"*; `IMPL-1300`…`1359`, reserve `1360`…`1399` |
| **7 — Freeze** | **A row in §3 at an assigned rank** | **This ADR authorises it** | §4 below |

⚠ **`PRD-012a` has no `_STAGE1_DISCOVERY.md` and no Stage 2 record, and neither absence is a hole.** Stage 1 is
`NOT APPLICABLE` by `ADR-0060`, so a record of it would record a gate that does not apply. Stage 2's gate is a
**property of the subject** — a header and declared ranges — not a separate artefact; `PRD-013` and `PRD-017` were
both admitted without a Stage 2 record for the same reason. This is stated because the *pattern* of five files in
`docs/30-product/<module>/` is the kind of thing a reader counts, and coming up two short here is explicable
rather than deficient.

### 2.2 The row-shape question — measured, and the assumption falsified

Matrix §2N.2 asserts that §4 holds *"13 Rank 3 module baselines and **every one is scoped to a bounded context or
a named domain**"*. Read against §4 itself, the second half of that disjunction is load-bearing and true:

> `| **3** | **Library PRD v1.1** + §14A + §14B + Invitation Security Specification | Everything inside the **Library Management domain** |`

**That row is not scoped to a `BC-nn`.** It names a *domain*. So the table already admits a Rank 3 scope expressed
in something other than a bounded-context identifier, and a platform-scoped row is a **third instance of an
existing shape**, not a new kind of row. Had every one of the thirteen been `BC-nn`-scoped, this admission would
have required the Architecture Owner to authorise a new scope form, and this ADR would have stopped.

### 2.3 What the subject is, measured

| Property | Value | Source |
|---|---|---|
| Identifiers | **427** across **15** registers, all contiguous | Matrix §2N.0; re-derived here by a third independent instrument (§8) |
| Normative obligations | **109** (`SECP-FR-*` 84 + `SECP-BR-*` 25) | Matrix §2N |
| Acceptance criteria | **128**; coverage **109/109 = 100.0%** | Matrix §2N |
| Owned bounded context | **None** | Part 1 header; `ADR-0060` |
| Owned aggregate | **None declared** | Part 1 L15; `SECP-GAP-010` |
| Invariants | **0 — register declared EMPTY** | `SECP-GAP-010`: an invariant needs an owned aggregate |
| Events published | **0 — register declared EMPTY** | `SECP-OWN-023`: no BC Map §9 producer row exists |
| Configurables | **0 — register declared EMPTY** | `SECP-XC-014`: `BC-25` owns parameters |
| `E-*` edges added | **0** | BC Map holds 26 `E-nn` rows before and after |
| Gaps | **44**, plus **3** opened by `ADR-0060`/`ADR-0062` = **47** | Part 8 §6; §4 item 8 below |
| Proven by a test | **0 of 128** | Part 8 §9 |
| Code written | **0 lines**; `lib/platform/security` **does not exist** | Measured: `find lib packages -type d -name security` returns empty |

### 2.4 The subject's bytes are the bytes every gate measured

`git diff --stat bd85a31 HEAD` over all eight Part files returns **empty** — byte-identical since the Stage 5
registration commit named in matrix §2N's *"Registered at"* field. Current digests:

| Part | sha256 (16) | Part | sha256 (16) |
|---|---|---|---|
| 1 | `dbd01d4d00165c77` | 5 | `254f45e29977de30` |
| 2 | `6752e5a01244e1d0` | 6 | `2620bad1e56e6b86` |
| 3 | `0908005425958477` | 7 | `a1e95f1e694fa934` |
| 4 | `d2794ab294731707` | 8 | `a8c45d79eb8154f7` |

**No alignment supplement is required and none is written** — the `PRD-016`/`PRD-023` condition, not the
`PRD-008`/`PRD-013` one.

### 2.5 The five `SECP-ADR-*` requests, and who answered them

| Request | Answered by | Authority exercised |
|---|---|---|
| `SECP-ADR-001` SECURITY platform: `BC-nn` or exemption? | `ADR-0060` | **Architecture Owner** |
| `SECP-ADR-002` Rank 3 alertability vs EA-V2 `Alerting` | `ADR-0061` | **Architecture Owner** |
| `SECP-ADR-003` step-up re-auth: security obligation or auth requirement? | `ADR-0063` | **`BC-18` Identity & Access owner** |
| `SECP-ADR-004` declare `platform/security`'s outbound dependencies | `ADR-0062` | **Architecture Owner** |
| `SECP-ADR-005` baseline `PRD-012a` v0.8 | **this ADR** | **Governance Owner** |

**Four different questions, three different roles, five separate acts.** This ADR decides only the fifth. It does
not restate, re-open or lean on the merits of the other four; it records that they exist, are `Accepted`, and that
the structural obstacles to a Rank 3 row are therefore removed by decisions **other than this one**.

---

## 3. Findings routed, not resolved here

### 3.1 What this admission declines to do

| Tempting move | Refused because |
|---|---|
| Edit `SECP-FR-018`'s **`PENDING-AUTHORITY`** marker now that `ADR-0063` has ruled | The condition is satisfied *in fact*, and the marker's removal is an **amendment to the subject**, which needs its own ADR and would invalidate the four gate records anchored to Part 2's hash. Exactly the `PRD-017` precedent: `FIL-GAP-012`'s implementation half was *"closed in fact by `ADR-0059`"* while *"its row may not be edited without amendment authority."* The **baseline row discloses the divergence instead** |
| Close `SECP-GAP-010` (no owned aggregate) | Whether the SECURITY platform *should* hold an aggregate is an **Architecture Owner** question and is undecided. `ADR-0060` deliberately did not decide it |
| Mark the three declared-EMPTY registers as defects to be filled | Each emptiness is a **finding with a published reason**. The `PRD-016` precedent (`ADR-0051` §2.4) admits empty registers to the baseline rather than inventing members |
| Repair **`GCP-20`** while editing §4 | Out of scope on **standing instruction**. §4 holding one fewer Rank 3 row than §3.3 is a pre-existing defect; repairing it as a side effect of an unrelated admission is how derived statements acquire untraceable history |
| Advance the version v0.8 → v1.0 to mark the freeze | `ADR-0020` §4 item 2: *"Freeze confers status; it does not renumber"*; §5 expressly rejects renumbering to mark a freeze. **The sixth v0.x admission** |
| Promote `ADR-0022`, or any `Proposed` ADR, as a convenience | Nothing in this admission tests any question a `Proposed` ADR frames. `proposed` stays at **13** |

### 3.2 The authority restraint

**Knowing the right amendment is not the same as holding the right to make it.**

The conferral here is **Governance Owner**. It reaches Stage 7 and the baseline. It does **not** reach:

- **The Bounded Context Map or the Module Dependency Matrix** (Rank 4 — Architecture Owner). `SECP-GAP-046` and
  `SECP-GAP-047`, opened by `ADR-0062`, are **routed and left open**.
- **Any frozen Rank 3 PRD.** `PRD-001` is byte-unchanged; so is the Authentication PRD's `AUTH-8.81`.
- **The subject itself.** Every one of the eight Parts is byte-unchanged by this ADR.
- **`PRD_LIFECYCLE.md`** (Rank 1 by citation). `ADR-0060` refused to amend Stage 1 *on scope, not merit*, and this
  ADR does not revisit that.

### 3.3 Deliberately left open

| Item | Owner | Why not settled here |
|---|---|---|
| `SECP-DEP-005` — `BC-24`'s support-access category list (`AUD-GAP-004`) | `BC-24` owner | A frozen Rank 3 document's gap. Not this role's |
| `SECP-GAP-010` — should the platform own an aggregate? | Architecture Owner | Rank 4 structural question |
| `SECP-GAP-045` — Stage 1 names no owner (`PRD_LIFECYCLE.md` §6) | Governance Owner, as a **lifecycle amendment** | Amending Rank 1 process text is a separate act from admitting a document. Recorded, not performed |
| `SECP-GAP-046`, `SECP-GAP-047` — manifest block / rank-0 contract route | Architecture Owner | Opened by `ADR-0062`; Rank 4 |
| `SECP-GAP-014`, `SECP-GAP-043` — the `PENDING-AUTHORITY` marker text | Product Owner + `BC-18` | **Substantively answered** by `ADR-0063`; the *marker* needs a subject amendment (§3.1) |
| `GCP-20`…`GCP-25` | Governance Owner | Standing deferral |

---

## 4. Decision

**`PRD-012a` Security Automation, Parts 1–8 at v0.8, is ADMITTED to `DOCUMENTATION_BASELINE.md` §3.3 and assigned
Rank 3 in §4.** Specifically:

1. **Rank 3, scoped to the SECURITY platform** — *"Everything inside the SECURITY platform (rank 2) — platform and
   admin security, zero-trust direction, application/API/session/data security, threat detection, security
   automation and incident response, security audit, vulnerability management and resilience."* The scope is
   expressed as a **platform**, on the Library PRD's *"Library Management domain"* precedent (§2.2), because
   `ADR-0060` determined this subject owns **no bounded context** and creating one to furnish a row shape was
   refused there on three independent grounds.

2. **The version is NOT incremented.** Admitted at **v0.8** — the sixth v0.x admission, per `ADR-0020` §4 item 2.

3. **The baseline identifier advances to `BASELINE-2026-08-21-A`**, superseding `BASELINE-2026-08-20-C`, because a
   **Rank 3** document enters the baseline — §7 rule 4, applied and not assumed. The other documents this pass
   touches are `ADR-INDEX.md` (unranked), `PRD_REGISTRY.md` (unranked), `TRACEABILITY_MATRIX.md` (unranked) and
   five new ADR **files** — and `BASELINE-2026-08-20-C`'s own changelog fixes that *"an ADR being **added** is not
   a Rank 1–3 document **changing version**."* The advance is owed to `PRD-012a` alone.

4. **`PRD-012` is RETIRED, and its number is not reused.** `PRD_REGISTRY.md` §8 rule 1 and §4.1 L264 tie
   retirement to *"the day `PRD-012a` is **opened**"*. Eight Parts exist at v0.8 and have passed Stages 3–6, so
   `PRD-012a` is opened as a matter of fact; L287's *"`PRD-012` is not retired yet"* was true when written and is
   now false. This closes `SECP-GAP-012`. ⚠ **This is execution of an existing Rank 1-derived rule, not a new
   decision** — Master PRD §8 Correction 2 mandated the split, and `PRD_REGISTRY.md` records that
   `PRD-012a`/`PRD-012b` *"may be opened without a further ADR."*

5. **`PRD-012a` moves `PLANNED` → `FROZEN`** in `PRD_REGISTRY.md` §4.1, and is **counted in §7** rather than held
   under *"Reserved, not counted above"* — that reservation was expressly conditioned on `PRD-012` not yet being
   retired. This closes `SECP-GAP-013` and `SECP-GAP-044`, and discharges `SECP-DEP-007` for the registry.
   ⚠ **`PRD-012b` remains reserved, `PLANNED`, and uncounted.** It is not opened by this ADR and nothing here
   confers anything on it.

6. **`TRACEABILITY_MATRIX.md` §2N.2 is corrected**, not rewritten: its cells asserting *"`PRD-012a` holds NO rank
   and is NOT frozen"* and *"no such row exists"* become false the moment §3.3 is written, and §8 rule 5 of the
   registry family requires the register to be fixed. Prior text is **retained verbatim** beside the correction.

7. **`ADR-0060`…`ADR-0064` are registered in `ADR-INDEX.md`** and the Rank 2 count is **re-derived by measurement**
   (§8), not incremented.

8. ⛔ **`FROZEN` is not `VERIFIED`.** **0 of 128** acceptance criteria and **0 of 60** `IMPL-1300`…`1359` tasks are
   proven by a test. **All 47 `SECP-GAP-*` are admitted OPEN** — the 44 the subject declares plus `SECP-GAP-045`,
   `046`, `047` opened by `ADR-0060`/`ADR-0062`. **No file under `lib/`, `packages/`, `test/` or `web/` is touched
   — 0 lines.** `platform/security` does not exist as a directory and this ADR does not create it.

9. **Three registers are admitted EMPTY** (`SECP-INV-*`, `SECP-EVT-*`, `SECP-CFG-*`) and **four admitted CLOSED**
   (`SECP-HRO-*`, `SECP-SIG-*`, `SECP-SEV-*`, `SECP-TST-*`), each with the reason its own document publishes. No
   member is invented to populate an empty register and no closed register is extended.

### 4.1 What this decision rests on

- `PRD_LIFECYCLE.md` Stage 7 — the gate is a §3 row at an assigned rank; freeze is *conferred, not claimed*.
- `PRD_LIFECYCLE.md` §6 **L282** — the **Governance owner** holds Stage 7 and the baseline.
- `DOCUMENTATION_BASELINE.md` §7 rules 1–4 — ADR first; version and changelog in the same commit; the declaration
  updated in the same commit; the identifier moves on a Rank 1–3 version change.
- `ADR-0020` §4 item 2 and §5 — freeze does not renumber.
- `ADR-0049`…`ADR-0054` — six prior admissions under the same conferred role, four of them at v0.x.
- `ADR-0060`, `ADR-0061`, `ADR-0062`, `ADR-0063` — the four structural decisions that removed the obstacles, made
  by **other** authorities.
- §4's own Library PRD row — the measured precedent for a non-`BC-nn` Rank 3 scope.

### 4.2 What it does NOT rest on

- **Not** on `PRD-012a`'s own assertion of anything. Part 8 §8 asks; it does not answer.
- **Not** on the absence of objection. Silence is not approval.
- **Not** on an ARB meeting, a quorum, a Security review, a PEA sign-off or a Product Owner signature. **None was
  held and none is claimed.**
- **Not** on `SECP-GAP-041` having been *repaired*. It was **dissolved** by `ADR-0060`'s finding that the gate does
  not reach this subject — a different thing, and the difference is why no `BC-32` exists.
- **Not** on the count in `ADR-INDEX.md`. The Rank 2 figure was measured with an independent instrument (§8),
  because two records agreeing is only evidence if they were derived independently.

---

## 5. What acceptance does not license

| Reading | Licensed? |
|---|---|
| `PRD-012a`'s requirements may now be implemented | ✅ Yes — Stage 8 may begin. `ADR-0020` §6.2: *freeze authorises implementation to begin; it does not perform it* |
| `PRD-012a` is verified, tested or proven | ❌ **No.** 0 of 128 criteria proven |
| The SECURITY platform now has a bounded context | ❌ **No.** 31 contexts, unchanged. `ADR-0060` |
| `platform/security` may declare outbound `ports` in the manifest | ❌ **No.** Refused by `ADR-0062`; the manifest is byte-unchanged |
| `SECP-FR-018` may be implemented | ⚠ **Substantively yes** by `ADR-0063`, but the subject's own `PENDING-AUTHORITY` marker still stands and was not edited (§3.1). An implementer must read `ADR-0063` beside Part 2 |
| A 32nd bounded context, a new `E-*` edge, a role, permission, factor, endpoint, schema or configurable is created | ❌ **No.** Zero of each |
| `PRD-012b` is opened, or Workflow Orchestration is specified | ❌ **No.** Still reserved and `PLANNED` |
| The 47 open gaps are closed, or may be treated as closed | ❌ **No.** All 47 OPEN |
| This role may now amend Rank 4, or a frozen Rank 3 PRD | ❌ **No.** `ADR-0033` §7.1: *a conferral for one act is not a standing licence* |

---

## 6. Authority

The authority is a **direct, explicit conferral by the human principal of this engagement** for this act:
*"Establish the required admission decision/ADR through the authorized Governance/Architecture process"*, followed
by *"update the required baseline/registry/traceability records according to `PRD_LIFECYCLE.md`"*. **That
instruction is the authority, and it is the only authority claimed.**

It is a *separate* act of conferral from the ones recorded in `ADR-0032` §5.2 and `ADR-0033` §5.2, and from the one
under which `ADR-0060`…`ADR-0062` were written in this same pass — those exercised **Architecture Owner** authority,
and `ADR-0063` exercised the **`BC-18` owner's**. A conferral for one act is not a standing licence
(`ADR-0033` §7.1), which is precisely why this ADR is a fifth document rather than a section of the first.

### 6.1 The conditions tested before exercising it

| Condition | Tested |
|---|---|
| Is an ADR required *before* the change? | **Yes** — baseline §7 rule 1. This ADR precedes every edit |
| Is the conferred role the one the lifecycle names for Stage 7? | **Yes** — `PRD_LIFECYCLE.md` §6 L282 |
| Are all prior gates genuinely satisfied? | **Yes** — §2.1, each with a cited record; Stage 1 `NOT APPLICABLE` by a *different* authority |
| Are the subject's bytes the bytes those gates measured? | **Yes** — §2.4, `git diff` empty |
| Does a lawful row *shape* exist for a platform-scoped document? | **Yes** — §2.2, measured; the assumption that none existed was **false** |
| Was the structural blocker removed by an authority competent to remove it? | **Yes** — `ADR-0060`, Architecture Owner. This role could not have decided it |
| Does this ADR contain any question addressed to another authority? | **No** — every matter it cannot decide is named with an owner in §3.3 |

---

## 7. Counts, by measurement

| Figure | Before | After | Method |
|---|---|---|---|
| Baseline identifier | `BASELINE-2026-08-20-C` | **`BASELINE-2026-08-21-A`** | §7 rule 4 applied to the one Rank 3 entrant |
| §4 Rank 3 module baselines | 13 | **14** | Counted in §4, not incremented from prose |
| ADR files | 59 | **64** | `ls docs/00-governance/adr/ADR-0*.md \| wc -l` |
| ADR `Accepted` | 46 | **51** | Each file's own `Status` row classified |
| ADR `Proposed` | 13 | **13** | Unchanged — **no ADR promoted, demoted, superseded or deprecated** |
| Registry: registered PRDs | 24 | **24** | `PRD-012a` replaces retired `PRD-012`; no number created or reused |
| Registry: `FROZEN` | 13 | **14** | §7 recount |
| Registry: `PLANNED` | 8 | **7** | `PRD-012` retired out of the count |
| Bounded contexts | 31 | **31** | `ADR-0060` created none |
| BC Map `E-nn` edges | 26 | **26** | Zero added |
| `SECP-GAP-*` OPEN | 44 | **47** | +3 opened by `ADR-0060`/`ADR-0062`; **none closed** |
| Lines of code changed | — | **0** | No file under `lib/`, `packages/`, `test/`, `web/` touched |

### 7.1 Drifts found while making these edits

Recorded here rather than absorbed, on the `ADR-0020` §3.6 / `ADR-0051` §8.1 precedent. **The search was performed
and did not return empty.**

1. **An instrument of this pass was wrong before any document was, and it is disclosed rather than quietly
   replaced.** A register census written to re-derive `PRD-012a`'s identifier count returned **345 / 15 registers**
   with apparent gaps in `SECP-BR-*`, `SECP-FR-*` and `SECP-XC-*`, and `SECP-OWN-*` at **15** against a published
   **30** — contradicting figures two independent checkers had derived at Stage 5. The **parser was the defect**:
   it matched only definitions appearing as the *first cell of a table row*, and several registers are defined in
   **prose paragraph form** — `SECP-OWN-016`/`017`/`018` among them. Re-derived by distinct-token scan, the result
   is **427 / 15 / all contiguous**, matching §2N exactly. ⚠ **The wrong figure was never published**: had `345`
   been written into this ADR or the baseline, it would have been a `GCP-13`-class false count in a *locked*
   declaration. It is recorded because an instrument that fails quietly is not evidence.
2. **`TRACEABILITY_MATRIX.md` §2N.2 asserts a fact this admission falsifies** — *"no such row exists"* — which is
   the `GCP-11`/`GCP-15`/`GCP-16`/`GCP-19`/`GCP-21`/`GCP-25` derived-statement class in its **matrix** form.
   Repaired in the same commit under §7 rule 3, with prior text retained verbatim.
3. **`PRD_REGISTRY.md` §4.1 L287 reads *"`PRD-012` is not retired yet."*** True when written; falsified by the
   authoring of eight Parts. Repaired here, prior text retained.
4. **`GCP-20` was found still open and deliberately NOT repaired** — §4 holds one fewer Rank 3 row than §3.3 (the
   missing `PRD-014` row). Carried on standing instruction. Recorded so that the fourteen-row count in §7 above is
   read as *§4 rows after this admission*, not as a claim that §3.3 and §4 now agree.

---

## 8. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-21 | Created `Accepted`. Admits `PRD-012a` Parts 1–8 v0.8 to Rank 3 scoped to the **SECURITY platform**, on the measured Library-PRD precedent for a non-`BC-nn` scope. Issues `BASELINE-2026-08-21-A`. Retires `PRD-012`; moves `PRD-012a` `PLANNED` → `FROZEN` and into the §7 counts. Closes `SECP-ADR-005`, `SECP-DEP-007`, `SECP-GAP-012`/`013`/`044`, `B7-1`, `B7-2`. **Version not incremented** (sixth v0.x admission). **47 gaps OPEN, 0 of 128 criteria proven, 0 lines of code.** Four instrument/derived-statement drifts disclosed, one of them this pass's own **345-vs-427** parser defect caught before publication; `GCP-20` deliberately not repaired |
