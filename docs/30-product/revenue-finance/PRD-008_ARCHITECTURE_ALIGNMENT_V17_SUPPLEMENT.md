# `PRD-008` Revenue & Finance v1.7 — Stage 3 Architecture Alignment **RE-RUN** (Supplement)

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review, RE-RUN** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3, lines **88–106**) |
| **Subject** | [`PRD-008_REVENUE-AND-FINANCE.md`](PRD-008_REVENUE-AND-FINANCE.md) — `PRD-008`, `BC-05` Fee & Collection, **v1.7 `DRAFT`** |
| **Supplements** | [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT.md) — the **v1.2** record, `c9f47cc1d42917ff`, 983 lines, **byte-unchanged by this document** |
| **Why a supplement and not a rewrite** | The v1.2 record is an **unranked, dated validation artefact** that states its own subject version, its own commit and its own PRD hash. Overwriting it would destroy the evidence that the earlier review was correct **for what it examined**, and would leave a later reader unable to see that a measurement was re-opened. **A stale review is corrected by a dated re-run beside it, not by editing what it concluded.** This is verbatim the mechanism the **baselined** [`PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md`](../attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md) **L8** records for the identical situation, and `DOCUMENTATION_BASELINE.md` **§3.3 L171** admits that supplement as a validation record with its superseded verdict *"retained inside the document beside the new one rather than overwritten"* |
| **Gate addressed by** | This document, **jointly with** the v1.2 record — *"a written alignment record naming every conflict and its disposition"* (`PRD_LIFECYCLE.md` **L102**) |
| **Reviewed at** | `717dba0` |
| **PRD hash at review** | `d24832f33e600518415d47a58e6112b408c9ae0dce19c6fcd3c8b38e1d5057e5` — measured at **v1.7, 2,808 lines, 369,405 characters**. *(Python byte-level `sha256` and `len()`; `wc -m` reports **bytes** under this locale and must not be used for a character count — the same instrument note the v1.2 record carries.)* |
| **Date** | 2026-08-16 |
| **Status** | **Unranked.** A review record is a validation artefact, not a specification. It claims no authority and confers no status |
| **Mandate** | **Stage 3 measurement only.** No PRD requirement added, removed or reworded · no ranked document touched · no ADR accepted · no registry or baseline update · **no freeze** · **no conferral** · no checker weakened · 0 Dart files touched |
| **Verdict (measured)** | ✅ **6 of 6 Stage 3 checks PASS, 0 FAILURES, re-measured against v1.7.** The v1.2 record's ✅ ALIGNED conclusion is **re-confirmed on the current bytes** |
| ⛔ **What this verdict is NOT** | **It is not a conferral, and Stage 3 is therefore NOT satisfied by this document alone.** `PRD_LIFECYCLE.md` **§6** assigns Stage 3 to the **Architecture Reviewer**. A measurement performed by the same pass that prepares the freeze is evidence *for* that role, never a substitute for it. See **§4** |

---

## 1. Why this re-run was necessary — the defect, stated before the result

The v1.2 record concludes ✅ **ALIGNED — 6 of 6 checks PASS**. That conclusion was correct for what it examined.
What it examined is no longer what is on disk.

| Fact | v1.2 record states | `PRD-008` at `717dba0` | Δ |
|---|---|---|---|
| Version | **v1.2** | **v1.7** | 5 versions |
| Lines | 2,536 | **2,808** | **+272** |
| Characters | 263,566 | **369,405** | **+105,839** |
| `sha256` | `0b1a32b6…` | **`d24832f3…`** | ≠ |

**A stage verdict is a statement about a specific revision.** Conferring Stage 3 on the strength of the v1.2
record would confer a verdict about a document that no longer exists — the drift class the governance ledger
already records four times (`GCP-01`, `GCP-07`, `GCP-08`, `GCP-11`), and which `GCP-11` says should be caught by
*"a gate that does not yet exist rather than… a promise to be more careful."*

### 1.1 A second, independent provenance defect in the v1.2 record

Measured, not inferred — `git show` against real history:

| The record's claim | Measurement |
|---|---|
| *"Reviewed at `36bd461` — EIGHTH PASS (v1.2)"* | `PRD-008` at `36bd461` is **v1.1**, hashing to `8972eed9…` — the value **this same record labels *superseded*** |
| — | The blob hashing to the record's own stated v1.2 value `0b1a32b6…` is at **`334d899`** |

So the record's *"Reviewed at"* commit and its *"PRD hash at review"* row **disagree with each other**. Neither is
fabricated; the commit reference is simply one revision behind the hash it is paired with. **Both rows are left
standing in the v1.2 record**, because a superseded provenance row is evidence, and correcting it in place would
erase the discrepancy instead of recording it.

---

## 2. What changed between v1.2 and v1.7, and why no Stage 3 check could move

The re-run is not an act of faith in the delta — the delta was measured first, so a reader can judge whether the
re-confirmation is plausible before reading it.

| Measure | v1.2 | v1.7 | Change |
|---|---|---|---|
| Total identifiers | 235 | **249** | **+14 — all `FEE-AC-085` … `FEE-AC-098`, acceptance criteria** |
| Identifiers **removed** | — | — | **0** |
| Obligation-bearing (`FR`+`BR`+`INV`+`EVT`+`XC`+`PO`) | 134 | **134** | **0** |
| Gap register membership | 17 | **17** | **0** |

**The Stage 3 subjects specifically:**

| Stage 3 token | v1.2 | v1.7 | Moved? |
|---|---|---|---|
| `ID-1` (credential prohibition) | 0 | 0 | no |
| `X-13` (authorisation prohibition) | 0 | 0 | no |
| `MP-GBR-08` (tenant scoping) | 0 | 0 | no |
| `AR-1` (context-creation test) | 9 | 9 | no |
| `BC-nn` mentions | 609 | 695 | prose only |
| `E-nn` mentions | 145 | 152 | prose only |

> **The load-bearing observation.** The v1.2 → v1.7 delta is **fourteen acceptance criteria and no obligation**.
> Stage 3 asks six questions about *boundaries, edges, rank direction, authorisation, credentials and tenancy*.
> **An acceptance criterion added to an obligation that already existed cannot change the answer to any of them** —
> which is why the six checks are nevertheless **re-run below rather than reasoned about**, per the Stage 5
> principle that *"mechanical means counted by a tool, not by reading."*

---

## 3. The six checks, re-measured against v1.7

Instrument: `/tmp/fp/stage3_008.py` — exit **0**, FAILURES **0**. Every count below is reproduced from the
current bytes of `PRD-008` at `d24832f33e600518`.

| # | Check (`PRD_LIFECYCLE.md` L92–99) | Authority | Measurement at v1.7 | Verdict |
|---|---|---|---|---|
| **1** | Context ownership is exclusive | BC Map §3 | Header declares **only `BC-05`**; rival PRDs claiming `BC-05` = **0** | ✅ PASS |
| **2** | Every integration edge exists in §7 | BC Map §7 | **18** `E-*` cited · **17** declared **and** relied on · **`E-27` cited only to record its ABSENCE** (see §3.1) | ✅ PASS |
| **3** | Rank direction is downward | Dep. Matrix `L2` | Explicit upward-dependency statements = **0** | ✅ PASS |
| **4** | No authorisation decided outside `BC-18` | `X-13` | Permission identifiers **defined** by `PRD-008` = **0**; role identifiers defined = **0** | ✅ PASS |
| **5** | No credential, OTP or session outside `BC-18` | `ID-1` | *"`BC-05` stores <credential>"* assertions = **0**; *"secret"* = **0** occurrences; *"credential"* = **6**, every one a citation or a prohibition | ✅ PASS |
| **6** | Tenant scoping correct | `MP-GBR-08`, `X-13` | Tenant-scoping mentions = **90**; library-scoping violations = **0** | ✅ PASS |

> ⚠ **Check 3 is honest about its own reach.** The PRD-level measurement tests *declared direction in text*. The
> binding enforcement of rank direction is `tool/check_module_boundaries.dart` at the **source** level (Dependency
> Matrix §10.4 gate 3, *"blocks merge"*), and there is no `BC-05` source to enforce it against yet. This is
> recorded as a **limit of the measurement**, not as a stronger pass than was earned.
>
> ⚠ **Check 6 inherits the v1.2 record's standing re-review condition** (its §7.2) and does **not** discharge it.

### 3.1 Check 2 — the `E-27` finding this re-run *rejected*, and why

The first run of the re-measurement **reported a Check 2 failure**: `E-27` cited by `PRD-008` but absent from the
BC Map edge table. **That finding is rejected**, and it is recorded here rather than silently dropped, because
`PRD_LIFECYCLE.md` **L104** requires it:

> *"A rejected finding must be recorded as rejected, with its reason… A review that records only accepted findings
> is indistinguishable from a review that found nothing."*

| Field | Value |
|---|---|
| **The finding, as first produced** | A set-difference of *edges cited* minus *edges declared* returned `E-27`, which BC Map §7 does not list — apparently the exact Check 2 failure whose remedy is *"needs an ADR"* |
| **Why it was rejected** | Both `PRD-008` occurrences (**L300**, **L2189**) cite `E-27` **to record its withdrawal**, not to rely on it. Rank 4 `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L605** agrees in its own words: *"Edge `E-27` was added by `ADR-0032` and **withdrawn again by `ADR-0033`**… The edge set is once more `E-01`…`E-26`."* |
| **The instrument defect** | A bare set-difference cannot distinguish **affirmative reliance** on an identifier from **recording its absence**. The two are opposite claims that produce identical tokens |
| **Disposition** | The classifier now splits `WITHDRAWN`-context citations from affirmative ones. **The fix was mutation-tested rather than trusted:** injecting a genuine affirmative citation of an undeclared edge still trips the check (`FAIL CHECK2: PRD-008 relies on undeclared edges [('E-31', [1576])]`). A false-alarm suppressor that also suppresses true alarms would be worse than the false alarm |
| **What it did NOT change** | No PRD text · no BC Map line · no ADR · no verdict of the v1.2 record |

---

## 4. ⛔ What this document does not do — the boundary, stated in full

**This is a measurement. Stage 3 is not satisfied by it.**

| | |
|---|---|
| **Who may confer Stage 3** | The **Architecture Reviewer** — `PRD_LIFECYCLE.md` **§6**: *"Architecture reviewer \| Stage 3; authority to require an ADR"* |
| **Why this document does not** | Two independent reasons. **(i)** The role is not held by the author of this pass, and the repository's convention for exercising a role is an explicit act — *"by **direct conferral of the human principal**"* (`ADR-0033` §7.2, `ADR-0034`, `ADR-0035`, `ADR-0043`), which has **not** occurred for Stage 3 of `PRD-008`. **(ii)** Even with the role, a measurement produced by the pass preparing the freeze is not an independent review of it |
| **The precedent this follows** | The v1.2 record's own **Mandate** row already draws exactly this line for ADRs: *"A Stage 3 record must not accept the ADR it depends on; **it may only observe that someone with authority did.**"* The same separation applies one level up — a Stage 3 record may **measure**, and only a reviewer may **confer** |
| **Consequence** | `PRD-008` stays **`DRAFT`**. `PRD_REGISTRY.md` is unchanged. `DOCUMENTATION_BASELINE.md` is unchanged. **Stage 4 conferral, Stage 6 and Stage 7 remain unreached** |

### 4.1 The exact act required of the Architecture Reviewer

1. Re-measure the six checks against **`PRD-008` v1.7 / 2,808 lines / `d24832f33e600518`** — or adopt §3 of this
   document as the measurement, on the reviewer's own responsibility.
2. Adjudicate the rejected `E-27` finding in **§3.1** — accept the rejection, or reinstate the finding.
3. Note the two provenance defects in **§1.1** of the v1.2 record (`36bd461` carries v1.1; the v1.2 blob is at
   `334d899`), and decide their disposition. **They are not corrected in place by this document.**
4. **Confer Stage 3**, or withhold it. Until that act exists, Stage 3 is **NOT CONFERRED** whatever the
   measurement says.

---

## 5. FINDING A-2 is preserved, not resolved

`PRD-019_ARCHITECTURE_ALIGNMENT.md` **L187** records that *"the `ID-1` / L140 boundary is under-specified at
Rank 4, and only the Architecture Owner may specify it"*, and **L190** that *"`PRD-019` cannot fix this."*

| Question | Answer, measured |
|---|---|
| **Can existing authority RESOLVE A-2?** | ⛔ **NO.** `ADR-0048` §7.2 puts the *narrow reading* in force for measurement purposes — because under the wide reading *"BC Map **L140** is unsatisfiable as written… A reading that makes a Rank 4 line impossible to comply with is the wrong reading"* — and then states plainly: *"The residual is **NOT closed**… only a prior ADR may settle it (baseline §7 rule 1). Routed to the **Architecture Owner**."* **A reading in force is not a resolution.** |
| **Does A-2 block `PRD-008` Stage 3?** | ✅ **NO.** `PRD-008` makes **0** secret-custody assertions, and **`FEE-XC-005`** (**L1575**) is an *exclusion*: *"Hold, read or transmit a payment-gateway credential."* `ITG-BR-007` / `ITG-AC-035` fence the secret out of `BC-05` from the `PRD-019` side. Under the narrow reading `BC-31` keeps the credential; under the wide reading it moves to `BC-18`; **in neither case does it land in `BC-05`** |

**Therefore Check 5 passes for `PRD-008` on a ground independent of A-2's outcome**, and A-2 is **routed, not
decided**. No Rank 1 or Rank 4 document is touched by this record; no ADR is written; no resolution is invented.

---

## 6. What this document did not touch — verified, not asserted

| Artefact | State |
|---|---|
| `PRD-008_REVENUE-AND-FINANCE.md` | **byte-unchanged** — `d24832f33e600518`, 2,808 lines, v1.7 `DRAFT` |
| `PRD-008_ARCHITECTURE_ALIGNMENT.md` (v1.2) | **byte-unchanged** — `c9f47cc1d42917ff`, 983 lines |
| `MASTER_PRD.md` · BC Map · Dependency Matrix · `module_dependencies.yaml` | **byte-unchanged** |
| `DOCUMENTATION_BASELINE.md` · `PRD_REGISTRY.md` · `TRACEABILITY_MATRIX.md` | **byte-unchanged** |
| Accepted ADRs | **none written, none amended, none accepted** |
| `PRD-019_INTEGRATION.md` · its alignment record | **byte-unchanged** |
| `tool/docs_check/*` | **no checker weakened**; the 10 pre-existing gates keep their exact prior verdicts |
| `lib/` · `test/` · `pubspec.yaml` · `android/` · `web/` | **0 files changed** |

---

## 7. References

[`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) §3 (L88–106), §6, §7 ·
[`PRD-008_ARCHITECTURE_ALIGNMENT.md`](PRD-008_ARCHITECTURE_ALIGNMENT.md) — the v1.2 record ·
[`PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md`](../attendance-management/PRD-006_ARCHITECTURE_ALIGNMENT_V19_SUPPLEMENT.md) — the supplement precedent ·
[`DOCUMENTATION_BASELINE.md`](../../00-governance/DOCUMENTATION_BASELINE.md) §3.3 L171, §6 `GCP-11`, §7 ·
[`LIBOORA_BOUNDED_CONTEXT_MAP.md`](../../10-architecture/LIBOORA_BOUNDED_CONTEXT_MAP.md) L140, L178, L605 ·
[`ADR-0048`](../../00-governance/adr/ADR-0048-prd-019-acceptance-criteria-and-stage-3-4-reviews.md) §7.2 — A-2 ·
`tool/docs_check/alignment_record_freshness.py` — the mechanical drift gate

---

*End of `PRD-008_ARCHITECTURE_ALIGNMENT_V17_SUPPLEMENT.md` — Stage 3 **measurement** for `PRD-008` **v1.7 `DRAFT`**
at `717dba0`. **6 of 6 checks PASS. NOT A CONFERRAL. NOT AN APPROVAL. NOT A FREEZE.***
