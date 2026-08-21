# `PRD-012a` Security Automation — Stage 4 Requirements Review

| Field | Value |
|---|---|
| **Document** | `PRD-012a_STAGE4_REQUIREMENTS_REVIEW.md` |
| **Subject** | `PRD-012a` Security Automation, Parts 1–8, **v0.8 `DRAFT`** |
| **Stage** | **4 of 9 — Requirements Review** (`PRD_LIFECYCLE.md` §3, L108–119) |
| **Gate** | *"conflicts closed or explicitly deferred **with a reason and an owner**"* (L119) |
| **Gate satisfied by** | **This document** — §7's disposition table gives every open conflict a reason **and** a named owner |
| **Verdict** | ✅ **PASS — 6 of 6 checks** |
| **Findings** | **0 CRITICAL · 0 HIGH · 0 MEDIUM · 2 LOW** (`L4-1`, `L4-2`, both accepted and carried) |
| **Candidate findings rejected** | **4** (`R4-1`…`R4-4`), each with the evidence that defeated it |
| **Instrument defects found in this review's own tooling** | **3** — §8.4. All three would have produced **false accusations against the subject** |
| **Prerequisite for Stage 4 (Stage 3)** | ✅ [`PRD-012a_ARCHITECTURE_ALIGNMENT.md`](PRD-012a_ARCHITECTURE_ALIGNMENT.md) — ALIGNED, 5 PASS + 1 PASS-with-finding |
| **Repository validation tools** | `tool/docs_check/*.py` → **TOTAL NONZERO = 5 (baseline 5)** — no regression. `flutter analyze` → see §8.3 |
| **Subject modified** | **No.** Zero bytes of Parts 1–8 changed to produce this record |
| **Code modified** | **No** |
| **Reviewed at** | `bd85a31d0b93da809706cf351a282adedb05149a` |
| **Registry status this permits** | `IN_REVIEW` — *not written by this pass; see §9* |
| **Authority of this record** | **Unranked. Navigational and evidential only.** It confers nothing |
| **Date** | 2026-08-21 |

---

## 1. What Stage 4 actually requires

`PRD_LIFECYCLE.md` L110–117 fixes six checks, each with a named failure mode:

| # | Check | Failure |
|---|---|---|
| **D1** | Every requirement testable | *"The system should be fast"* — unverifiable |
| **D2** | Every exclusion states what must be **impossible** | An exclusion is not a deferral |
| **D3** | Every configurable has a default and a range | Unbounded configuration is a specification hole |
| **D4** | Every acceptance criterion maps to a requirement | Orphan criterion |
| **D5** | No requirement restates another PRD's | Two sources of truth |
| **D6** | Business rules do not contradict Rank 1 | Rank 1 wins; the PRD is wrong |

L119 fixes the exit gate: **conflicts closed or explicitly deferred with a reason and an owner.** Note what the gate
does *not* say: it does not require zero open conflicts. It requires that every open conflict be *explicitly*
deferred, *with a reason*, *to an owner*. A conflict deferred to nobody fails this gate; a conflict deferred to a
named owner with a stated reason satisfies it.

### 1.1 The one instruction this review followed above all others

The user instruction governing this stage reads: *"Correct only permitted defects."* Combined with
`DOCUMENTATION_BASELINE.md` L253 (*"A conflict is a defect. If you find one, do not choose — raise it"*), the
operating rule for this pass was: **measure aggressively, correct nothing that belongs to another owner.**

**Zero bytes of the subject were changed.** Every candidate defect this review raised was either (a) disproved by
evidence, or (b) already disclosed by the subject with an owner. No third category arose, so no edit was permitted
and none was made.

---

## 2. D1 — Every requirement testable ✅ PASS

**Population: 109 normative requirements** — 84 `SECP-FR-*` + 25 `SECP-BR-*`.

### 2.1 Result

| Measurement | Result |
|---|---|
| Requirements with a locatable definition | **109 of 109** |
| Definitions carrying a normative keyword (**MUST** / **MUST NOT** / **SHALL** / **SHALL NOT** / **SHOULD** / **MAY**) | **103** |
| Definitions stating the rule **definitionally** rather than modally | **6** — `SECP-BR-001`, `003`, `009`, `011`, `014`, `024` |
| Definitions containing an unverifiable vague adjective (*fast*, *robust*, *secure enough*) | **0** |

### 2.2 The six definitional business rules — inspected individually, all testable

The lifecycle's failure example is *"The system should be fast"* — a statement with **no observable referent**. Each
of the six states a **falsifiable equality or classification**:

| Rule | Form | Why it is testable |
|---|---|---|
| `SECP-BR-001` | *"effective authority … is **exactly** the union of its active approved elevations, and is **empty** when none is active"* | An equality over two computable sets. Falsified by exhibiting one authority outside the union |
| `SECP-BR-003` | *"Absence of an explicit grant on a privileged path is **refusal**"* | An outcome assertion. Falsified by one non-refusal. Bound by `SECP-AC-022` |
| `SECP-BR-009` | *"Presence of a tenant identifier is not evidence of entitlement … is a defect regardless of whether a leak has been observed"* | A defect classification. Falsified by exhibiting a control that so treats it and is accepted |
| `SECP-BR-011` | *"A secret that has been emitted is compromised, and rotation is the only remedy"* | Names a **bounded, stated weakness** (V1 has no rotation — EA tags it V2) rather than assuming safety |
| `SECP-BR-014` | *"A session's continued existence is not evidence of continued entitlement"* | Falsified by one control inferring permission from session presence. Cites `AUTH-8.38` |
| `SECP-BR-024` | *"a control bounded by a configurable value is only as strong as the weakest permitted value … the range is the defect, not the setting"* | A review criterion with a decision rule |

A rule of the form *"X is not evidence of Y"* is **more** testable than a modal restatement, because it names the
exact observation that falsifies it. **All six are retained unchanged.** Every one is bound by at least one
`SECP-AC-*` (§5).

### 2.3 What this check nearly got wrong — recorded because it matters

My first instrument reported **44 requirements lacking a normative keyword**. That result was **false**, and its
cause was the instrument, not the subject: the regex recognised only the bold form ``**`SECP-FR-019`**`` and missed
the plain prose form `` `SECP-FR-019` — Every operation … **SHALL** … ``, which is the form Parts 3–7 predominantly
use. Spot-checking two of the accused — `SECP-FR-019` (*"**SHALL** be preceded by an authorisation"*) and
`SECP-XC-020` (*"**MUST NOT** be read as placing network segmentation…"*) — showed both carried the keyword the
instrument said was missing.

**The instrument was corrected; the subject was not touched.** This is the same discipline the prior span applied
when a range table wrongly accused Parts 1–2 of a count mismatch. It is logged as instrument defect `I-1` in §8.4.

---

## 3. D2 — Every exclusion states what must be impossible ✅ PASS

**Population: 37 `SECP-XC-*`.** The failure mode is precise: *"An exclusion is not a deferral."* A register entry
saying *"we will do this later"* is not an exclusion; one saying *"this must not exist"* is.

**Measured: 37 of 37** exclusion definitions state a prohibition or impossibility — **MUST NOT**, **SHALL NOT**,
*prohibited*, *forbidden*, *never*, *excluded*, *not owned*. **Zero** are bare deferrals.

Worked example, `SECP-XC-020`: *"Part 3 **MUST NOT** be read as placing network segmentation, continuous
verification, service …"* — this forbids a **reading**, which is the correct form for a scope exclusion, because the
risk being closed is a future reader inferring a capability from a directional principle.

The sharpest instance is Part 2's break-glass decision: `PRD-012a` **prohibits** a break-glass credential rather
than deferring one, following `AUTH-11.53`/`11.54`. A deferral there would have left the most dangerous capability
in the document as future work; a prohibition makes it a defect if it ever appears.

---

## 4. D3 — Every configurable has a default and a range ✅ PASS (vacuously, with a published reason)

`PRD-012a` declares **zero** `SECP-CFG-*` identifiers. Measured: **0** occurrences of any `SECP-CFG-` token across
all eight Parts.

This passes D3 **vacuously** — there is no configurable lacking a default because there is no configurable. What
makes that a finding rather than an evasion is the **published reason**: `SECP-XC-014` excludes the register because
parameters would duplicate `PRD-001`/`PRD-023`, and `SECP-OWN-021`/`OWN-030` defer *"Parameters, validation, typed
accessors"* to `BC-25` Configuration (`PRD-023`, **FROZEN**).

The precedent is exact and recent. `PRD-016` was admitted to the baseline with `AUD-CFG-*` **declared empty** because
*"no Rank 1–7 authority supplies a bound"*, on the reasoning that *"a default here would have been a legal
determination by a document with no standing to make one"* (`ADR-0051` §2.4). `PRD-012a`'s reason is structurally the
same: inventing a default would create the second source of truth D5 forbids.

⚠ **What this review will not claim:** it will not claim `PRD-012a` has *solved* configuration. `SECP-BR-024` records
the residual risk explicitly — *"a control bounded by a configurable value is only as strong as the weakest permitted
value"* — and routes range-setting to `PRD-023`. The risk is **stated, owned and unresolved**, which is the honest
disposition.

---

## 5. D4 — Every acceptance criterion maps to a requirement ✅ PASS

**Population: 128 `SECP-AC-*`.**

| Direction | Question | Result |
|---|---|---|
| **Forward** | Is every normative requirement bound by ≥1 criterion? | **109 of 109 bound. 0 uncovered** |
| **Reverse** | Is every criterion bound to ≥1 requirement or register entry? | **128 of 128 bound. 0 orphans** |

Both directions must be measured, and this is the check where **method decides the answer**. A line-scoped check run
during this review reported `SECP-BR-002` and `SECP-BR-003` uncovered. **Both reports were false** — their criteria
wrap onto continuation lines:

```
**`SECP-BR-002`** — … the outcome **MUST** be denial. *(Cites `AUTH-2.26`…)* — verified by
**`SECP-AC-023`**.
```

The binding sits on the **next physical line**. Part 8 §5 had already documented this exact false-negative class
before this review ran, which means the subject's own disclosure predicted my instrument's error. The
**paragraph-aware** measurement returns **109 covered / 0 uncovered**, matching the subject's published claim.

`SECP-AC-124` makes re-measurement a standing obligation — *"The check is re-run after any amendment, because this
criterion has already failed once against this document."* This review is such a re-run, and it passes. Logged as
instrument defect `I-2` in §8.4.

---

## 6. D5 — No requirement restates another PRD's ✅ PASS

This is where rejected finding `R3-3` from Stage 3 was deferred to, and it is tested here rather than dropped.

The failure mode is *"Two sources of truth."* The distinction that decides every instance: a requirement that
**cites** a foreign rule and adds a *verification obligation* creates no second truth; one that **redefines** the
foreign rule does.

| Candidate | Text | Verdict |
|---|---|---|
| `SECP-BR-002` | *"the outcome **MUST** be denial. **(Cites `AUTH-2.26`**; stated here because privileged paths are where the ambiguity is most consequential.)"* | ✅ **Citation + stated reason for restating scope.** Not a redefinition |
| `SECP-BR-003` | *"matching `tool/module_dependencies.yaml` L21 `default_decision: deny`"* | ✅ **Declared match with a citation.** The manifest is a code enforcement artefact, not a requirements register |
| `SECP-FR-010` | Part 2 annotates: *"**`SECP-FR-010` is `ADR-0003` applied to privilege, not a new rule**"* | ✅ **The document says so itself** |
| `SECP-BR-009` | *"**Restates no rule**; classifies a class of …"* | ✅ Self-disclosing |
| `SECP-BR-024` | *"**`PRD-023` owns ranges and this document proposes none**"* | ✅ Ownership disclaimed in the rule |

**`SECP-FR-084` is the load-bearing global answer to D5**, and it is normative rather than prefatory:

> `PRD-012a` **SHALL NOT** be read as claiming ownership of any aggregate, context, parameter, event, record or
> capability listed above. Where a reader finds a Part appearing to specify one, the correct reading is a **citation
> plus a verification obligation**, and any text that cannot be so read is a **defect to be raised**.

It is bound by `SECP-AC-128`, which requires all eleven ownership-deferral rows to be inspected and the count of
rows where a Part *specifies* rather than *cites* to be **zero**. D5 is therefore not merely asserted by this review —
it is a standing, re-runnable criterion inside the subject.

**Stage 3's `R3-3` is re-tested here and rejected again, on the additional ground that the manifest is not a PRD.**

---

## 7. D6 — Business rules do not contradict Rank 1 ✅ PASS · and the gate's conflict table

**Measured: zero contradictions between any `SECP-BR-*`/`SECP-FR-*` and Rank 1 `MASTER_PRD.md` v1.7.** Every Rank 1
citation runs downward: `MP-GBR-06`…`09`, `MP-NFR-05`/`09`/`10`/`12`, `MP-RSK-01`/`02`, `MP-CON-11` are cited as
authority *over* `PRD-012a`, never contradicted by it.

Part 8 §4.1 states the result independently: *"**No other Rank 1–3 requirement conflicts with a Part 1–8
requirement.**"* This review confirms it.

### 7.1 The gate deliverable — every conflict, with a reason and an owner

`PRD_LIFECYCLE.md` L119 requires conflicts *"closed or explicitly deferred **with a reason and an owner**."* Three
conflicts are open. **None is between `PRD-012a` and a ranked document — all three are between other documents,
surfaced by `PRD-012a`.**

| # | Conflict | Ranks in tension | Reason it is deferred rather than closed | **Owner** | Mechanism |
|---|---|---|---|---|---|
| **1** | `MP-RSK-01` cross-tenant leak **Critical** vs EA `Cross-Tenant Leak Tests` **V2** | **Rank 1** vs **Rank 6** | Closing it requires either amending the Rank 6 EA or a V1/V2 scope decision. `DOCUMENTATION_BASELINE.md` L253 forbids this document from choosing between ranked documents | **Architecture Owner** + **Product Owner** | ADR amending the EA, or a recorded PO scope decision. Raised as `SECP-GAP-023` |
| **2** | `AUTH-11.26`/`11.27`/`11.28` alertability vs EA `Alerting` **V2** | **Rank 3 FROZEN** vs **Rank 6** | The EA is *Descriptive* and therefore the probable wrong document — but *probable is not a decision*, and amending a Rank 1–5 document requires an ADR **first** (baseline §7 rule 1) | **Architecture Owner** | `SECP-ADR-002`; tracked as dependency `SECP-DEP-001`. Raised as `SECP-GAP-031` |
| **3** | `platform/security` has no manifest block while `default_decision: deny` stands | **Rank 4-governed** enforcement artefact | Editing `tool/module_dependencies.yaml` is an architecture change. A Stage 3/4 reviewer may *require* an ADR, not perform the change it would authorise | **Architecture Owner** | `SECP-ADR-004`. Raised as `SECP-GAP-042`, confirmed independently as Stage 3 finding `A3-1` |

**All three are explicitly deferred, each with a stated reason and a named owner. The gate is satisfied.**

### 7.2 The remaining 41 gaps

`PRD-012a` carries **44 `SECP-GAP-*`**; three are the conflicts above. The other **41** are open questions and
deferred decisions with named owners — the ordinary content of a gap ledger. Every frozen PRD in this repository was
admitted carrying open gaps (`PRD-013` 4, `PRD-016` 5, `PRD-008` 17, `PRD-006` 18). They are **neither cured nor
ratified** by this record, and `FROZEN` would not be `VERIFIED` even if freeze were available.

---

## 8. Additional quality checks and tool results

### 8.1 Unsupported security claims — the check this document exists to survive

The user instruction requires *"no unsupported 'hack-proof/unhackable' claims."* Measured across all eight Parts for
*hack-proof*, *unhackable*, *unbreakable*, *100% secure*, *cannot be hacked*, *cannot be breached*: **9 occurrences,
and every one is a negation or a prohibition.** Not one is a claim.

| Location | Text |
|---|---|
| Part 1 L196 | *"**The platform is not, and will not be described as, "hack-proof", "unhackable" or "100% secure."**"* |
| Part 1 L198 | *"…and *"the system cannot be hacked"* fails the same test more…"* — an explicit analogy to the lifecycle's own *"should be fast"* example |
| Part 1 L204 | *"a document that claimed OTP was unbreakable could not have produced that control…"* |
| Part 8 L284 | The prohibited-vocabulary list itself (*hack-proof*, *unhackable*, *100% secure*, *fully secure*, *cannot be breached*) |

Part 1 L198's reasoning is the strongest evidence of D1 compliance in the document: it identifies *"the system cannot
be hacked"* as failing **the same testability test** the lifecycle applies to *"the system should be fast"* —
the subject applying the Stage 4 criterion to itself before Stage 4 ran.

### 8.2 Scope discipline — no V2/V3 promotion

Part 8 §4 tabulates **18 EA capability groups** above V1 and names the hold-out mechanism for each. Verified:
`SECP-XC-020` (Zero Trust V3), `SECP-XC-021` (secrets/crypto V2/V3), `SECP-XC-023` (WAF/DDoS), `SECP-XC-024` (privacy
V2/V3), `SECP-XC-027` (anomaly/SIEM), `SECP-XC-030`/`031` (workflow/IR), `SECP-XC-034`/`035` (vuln/pentest),
`SECP-XC-036`/`037` (infra/DR). **No V1 requirement in Parts 1–8 is satisfiable only by a V2, V3 or Future
capability.**

### 8.3 Repository validation tools

| Tool | Result | Interpretation |
|---|---|---|
| `tool/docs_check/*.py` (all) | **TOTAL NONZERO = 5** | **Baseline is 5.** No regression. The five are `alignment_record_freshness.py`, `prd004_traceability.py`, `prd005_traceability.py`, `prd006_traceability.py`, `prd007_traceability.py` — all pre-existing, none concerning `PRD-012a` |
| `flutter analyze lib/ test/ packages/` | **No issues found!** | Zero code touched this pass; run to prove it |
| `dart run tool/check_module_boundaries.dart` | **not run — deliberately** | Known `FAIL — 9 violation(s)`, **by design** under `ADR-0012`. Part 7 §9 expressly does not require exit 0. Running it would add a known-failing result with no diagnostic value |
| Fenced code blocks in the subject | **0** in all 8 Parts | No implementation code, no SQL, no migrations |
| `SECP-*` tokens outside `docs/30-product/security/` | **0 files** | No leakage into other modules' namespaces |

⚠ **`alignment_record_freshness.py` is nonzero and this pass adds an alignment record.** The checker's nonzero status
is pre-existing (it is one of the five baseline failures) and concerns other modules' stale records. This review
deliberately does **not** attempt to bring it to zero: doing so would mean editing other modules' alignment records,
which is out of scope and forbidden by the standing instruction not to modify unrelated PRDs.

### 8.4 ⚠ Instrument defects found in this review's own tooling — all three would have accused the subject falsely

This section exists because a review that reports only its conclusions hides the more useful information: **how close
it came to being wrong.** Three of this pass's own instruments were defective, and **all three failed in the
direction of accusing the subject.**

| # | Instrument | False result | Real cause | How caught |
|---|---|---|---|---|
| **`I-1`** | Testability regex | **44 requirements** "lack a normative keyword" | Recognised only ``**`ID`**`` bold form; missed the `` `ID` — `` prose form used throughout Parts 3–7 | Spot-checked `SECP-FR-019` and `SECP-XC-020`; both carried **SHALL**/**MUST NOT** |
| **`I-2`** | Line-scoped coverage check | `SECP-BR-002`, `SECP-BR-003` "uncovered" | Criteria wrap onto continuation lines | Part 8 §5 had **already documented this exact false-negative class** |
| **`I-3`** | Definition locator | `SECP-BR-004` "has no definition" | Defined as a *"**Closure rule — `SECP-BR-004`:**"* at Part 2 L222 — a legitimate variant heading form | Direct token search |

**In all three cases the instrument was corrected and the subject was left untouched.** Had any been trusted, this
record would have "corrected" 44 requirements that were already correct, added two unnecessary acceptance criteria,
and reported a defined business rule as undefined.

This is the third consecutive `PRD-012a` pass in which the measuring instrument, not the document, was the defective
party. The pattern is now strong enough to state as a working rule: **when a broad automated check accuses a document
this heavily reviewed, verify the instrument before editing the subject.**

---

## 9. Findings

### 9.1 Accepted — 2 LOW, both carried

| # | Severity | Finding | Disposition |
|---|---|---|---|
| **`L4-1`** | **LOW** | Six business rules (`SECP-BR-001`, `003`, `009`, `011`, `014`, `024`) state their rule **definitionally** rather than modally. All six are falsifiable and bound by criteria | ⛔ **CARRIED, NOT CHANGED.** Rewriting them into modal form would alter requirement wording for stylistic uniformity, and the standing instruction is *"Do not silently change requirements."* A definitional rule that names its own falsifier is not a D1 failure |
| **`L4-2`** | **LOW** | Requirement definitions use **three** syntactic forms (bold-table, prose em-dash, "Closure rule" heading), which is what defeated instruments `I-1` and `I-3` | ⛔ **CARRIED.** A style-only normalisation across eight Parts would touch every register for no change in meaning, and would invalidate the Stage 3 hash measurements. Recorded so the next reviewer's instrument accounts for all three forms |

**Both LOW findings are about form, not content. Neither blocks the gate. Neither was corrected, because neither is a
defect the lifecycle permits correcting at this stage.**

### 9.2 Rejected candidate findings — recorded as rejected, with reasons

`PRD_LIFECYCLE.md` L104–106's rule applies to every review stage: *"A review that records only accepted findings is
indistinguishable from a review that found nothing."*

| # | Candidate finding | Why rejected |
|---|---|---|
| **`R4-1`** | *"44 requirements are untestable — they carry no normative keyword"* | **Instrument defect `I-1`.** The regex missed the prose definition form. Spot-checks proved the keywords present. **Population re-measured: 103 modal + 6 definitional = 109, all testable** |
| **`R4-2`** | *"`SECP-BR-002` and `SECP-BR-003` are uncovered — D4 fails"* | **Instrument defect `I-2`.** Line-scoped check; criteria wrap onto continuation lines. Paragraph-aware measurement returns **0 uncovered** — and Part 8 §5 had already documented this false-negative class |
| **`R4-3`** | *"`PRD-012a` fails D3 — it declares no configurable at all"* | D3's failure is *"unbounded configuration"*. **Zero** configurables cannot be unbounded. The register is empty **with a published reason** (`SECP-XC-014`), on the `PRD-016`/`ADR-0051` §2.4 precedent where inventing a default would have been *"a legal determination by a document with no standing to make one"* |
| **`R4-4`** | *"`SECP-BR-003` restates the manifest, creating two sources of truth (D5)"* | Deferred here from Stage 3 `R3-3` and **rejected again on a further ground**: `tool/module_dependencies.yaml` is a **code enforcement artefact**, not a PRD, so D5's *"another PRD's"* does not reach it. The rule declares a **match with a citation**, which is alignment evidence |

---

## 10. Verdict

✅ **STAGE 4 GATE SATISFIED — PASS, 6 of 6 checks.**

| Check | Result |
|---|---|
| D1 Every requirement testable | ✅ **109 of 109** |
| D2 Every exclusion states an impossibility | ✅ **37 of 37** |
| D3 Every configurable has a default and range | ✅ **Vacuous, with a published reason** |
| D4 Every AC maps to a requirement | ✅ **109 forward / 128 reverse, 0 orphans, 0 uncovered** |
| D5 No requirement restates another PRD's | ✅ **`SECP-FR-084` + `SECP-AC-128` make it a standing criterion** |
| D6 Business rules do not contradict Rank 1 | ✅ **0 contradictions** |

**0 CRITICAL · 0 HIGH · 0 MEDIUM · 2 LOW.** Three conflicts explicitly deferred, each with a reason and a named
owner — the gate's actual requirement. **0 bytes of the subject modified. 0 requirements reworded. 0 identifiers
renumbered. 0 approvals claimed. 0 conflicts resolved by this record.**

The most instructive result of this stage is not in the subject at all: **three of this review's own instruments were
defective, and every one failed by accusing the document.** The subject survived Stage 4 unchanged not because the
review was gentle, but because each accusation was checked before it was acted on.

**Next stage:** 5 — Traceability. Gate: prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges,
verified **mechanically**, zero collisions.

---

## 11. Change history

| Version | Date | Change |
|---|---|---|
| v1.0 | 2026-08-21 | Created. Stage 4 requirements review of `PRD-012a` Parts 1–8 at v0.8. Verdict PASS 6/6. 2 LOW findings carried, 4 candidate findings rejected with reasons, 3 instrument defects disclosed. 3 conflicts deferred with reasons and owners. Subject unmodified. |
