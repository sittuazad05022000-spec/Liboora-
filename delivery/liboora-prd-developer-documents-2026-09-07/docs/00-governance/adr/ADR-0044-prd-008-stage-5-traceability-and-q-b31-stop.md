# ADR-0044 — `PRD-008` Stage 5 traceability registration, and `Q-B31` reported as UNAUTHORABLE

| Field | Value |
|---|---|
| **Status** | **`ACCEPTED`** |
| **Date** | 2026-08-15 |
| **Decision by** | **Technical Owner** for the Stage 5 registration and the new gate script (`PRD_OWNERSHIP_MODEL.md` **L85** — *"Implementation, `IMPL-*` tasks, traceability from requirement to test, §10.4 gate health"*). **No Architecture Owner authority is claimed or exercised**, because nothing ranked is changed |
| **Supersedes / amends** | **Nothing.** No Rank 1–7 document is amended. `PRD-008`, `PRD-019`, `MASTER_PRD.md`, the BC Map, the Dependency Matrix, the EA, `DOCUMENTATION_BASELINE.md` and `PRD_REGISTRY.md` are all **byte-unchanged** |
| **Affects** | `PRD-008` Stage 5 · `TRACEABILITY_MATRIX.md` §2G · `Q-B31` · `FEE-RSK-*` declaration · `Q-A6`/`Q-A7`/`Q-S1`/`GCP-14` |
| **Outcome** | ⛔ **Stage 5 was UNMET and is now MET.** ⛔ **`Q-B31` is NOT resolved — it is reported as requiring two authority decisions that do not exist.** ⛔ **`PRD-008` is NOT frozen.** **0 Dart files touched** |

---

## §1 Context — what was asked, and the one thing that could not be delivered

The instruction was to prepare the repository for Stage 5 and to *"resolve `Q-B31`"* — the payment-gateway webhook
contract assigned to `PRD-019` but unauthored — subject to a constraint that governs the whole of this pass:

> *"Define only the minimum contract required for V1 … **but ONLY if the existing authoritative
> architecture/provider decisions already support those values.** Do NOT invent a provider, endpoint, algorithm,
> replay window, retry count, permission, schema, or financial rule. **If any value requires an authority decision,
> STOP and report the exact decision and owner.**"*

**Both halves were executed. The first succeeded; the second terminated in a STOP, and this ADR is that report.**

| Instruction | Result |
|---|---|
| Inspect the Stage 5 lifecycle requirement first | ✅ Done — §2 |
| Resolve `Q-B31` | ⛔ **STOP.** Measured unauthorable on **existing** authority — §3 |
| `PRD-019` sole owner, not duplicated in `PRD-008` | ✅ Upheld — **neither file changed**, §3.5 |
| Minimum contract *only if* authority supports the values | ⛔ **It does not.** Every one of the five is expressly *withheld* by an `ACCEPTED` ADR — §3.2 |
| Invent nothing; STOP and report | ✅ **Nothing invented.** Verified: 0 URLs, 0 algorithms, 0 durations, 0 retry counts, 0 provider names — §7 row 12 |
| Inspect `Q-A6`, `Q-A7`, `Q-S1`, `GCP-14`, `FEE-RSK`, stale EA citations | ✅ Done — §5. **One acted on, five deliberately not** |
| Do not freeze `PRD-008`; do not weaken a checker; add no V1 feature | ✅ §6 |

---

## §2 Stage 5 — the gate was UNMET, and that was the finding that mattered

`PRD_LIFECYCLE.md` **L121–L133** states the gate:

> *"the PRD's prefixes registered in `TRACEABILITY_MATRIX.md` §2 with counts and ranges, verified mechanically,
> **zero collisions**. Mechanical means counted by a tool, not by reading."*

**The first measurement decided the shape of this entire pass:**

```
$ grep -c 'FEE-' docs/40-implementation/TRACEABILITY_MATRIX.md
0
```

**Not one `FEE-*` prefix was registered anywhere.** Stage 5 was therefore not "nearly passing" or "passing with
findings" — it **could not pass**, because the artefact its gate names did not mention the module. Stage 4 being
complete and Freeze blockers standing at 0 had no bearing on this: the stages test different things, and a document
can clear Stage 4 while being wholly absent from the traceability matrix.

### 2.1 What was written, and why it is a registration rather than a claim

`TRACEABILITY_MATRIX.md` §2G registers nine registers, following the §2D/§2E/§2F precedent exactly (an inventory
table, a `.1` collision record, a `.2` exit gate). Every figure is **computed from `PRD-008`'s body**, not copied
from its §0.2:

| Register | Count | Range | Contiguous |
|---|---:|---|---|
| `FEE-FR-*` | **62** | `001`…`062` | ✅ |
| `FEE-BR-*` | **28** | `001`…`028` | ✅ |
| `FEE-INV-*` | **10** | `001`…`010` | ✅ |
| `FEE-EVT-*` | **3** | `001`…`003` | ✅ |
| `FEE-XC-*` | **23** | `001`…`023` | ✅ |
| `FEE-PO-*` | **8** | `001`…`008` | ✅ |
| `FEE-AC-*` | **98** | `001`…`098` | ✅ |
| `FEE-GAP-*` | **17** | `001`…`017` | ✅ |
| `FEE-RSK-*` | **10** | `001`…`010` | ✅ — **but undeclared in §0.2**, §5.1 |

**Obligation-bearing = 134** (62+28+10+3+23+8). **Total = 259.** Both figures reproduce `PRD-008` §0.2 and the
pre-existing gate's output exactly.

### 2.2 The new gate ADDS a check and weakens none — which is the load-bearing claim of this section

`prd008_traceability.py` checks `PRD-008` **against itself**. Measured: it contains **zero** references to
`TRACEABILITY_MATRIX.md` and never opens the file. **So Stage 5 had no mechanical enforcement for this module at
all** — §2G could have been written with any numbers in it and no gate would have objected. The precedent scripts
for the four modules that reached Stage 5 earlier each carry a matrix block for precisely this reason.

`tool/docs_check/prd008_stage5.py` is that missing block. It is a **new file**:

- `prd008_traceability.py` is **byte-unchanged** (sha256 `9ceaf1825764dbbe`) and must still pass independently.
- The new script's definition rule is **deliberately identical** to the old one's, so the two gates cannot disagree
  about what a definition is.
- **It was run BEFORE §2G existed and correctly failed**, printing *"TRACEABILITY_MATRIX.md has no section 2G —
  `PRD-008`'s Stage 5 registration is MISSING, which IS the Stage 5 failure"* and exiting 1. A gate that only ever
  passes has demonstrated nothing.

### 2.3 The `PO-`/`SPO-` collision class — tested, because this is where Stage 5 says it recurs

Stage 5's own text names its reason for existing: citing `PO-3` when `SPO-3` was meant *"would move a requirement
from one bounded context to another … which no amount of careful reading reliably catches."* **`PRD-008` owns
`FEE-PO-001`…`FEE-PO-008`, so the `PO-` substring is present in this register** — and three meanings now share it:

| Identifier | Meaning | Context | Surface |
|---|---|---|---|
| `PO-1`…`PO-12` | Protected operation | Library Management | Anonymous **read** |
| `SPO-1`…`SPO-9` | Protected operation | Student Identity | Authenticated **write** |
| **`FEE-PO-001`…`008`** | **Port / integration obligation** | **`BC-05`** | Neither — an outbound dependency |

**Measured, not reasoned about:**

| Direction | Result |
|---|---|
| Tokenisation: does a search for `PO-n` reach `FEE-PO-n`? | **No** — `'FEE-PO-003'` → `['FEE-PO']`. **Asserted in the script**, so it fails if the rule ever changes |
| Reverse: bare `PO-n`/`SPO-n` token anywhere in `PRD-008`? | **0 hits** — the document never cites those registers, so the error cannot occur in it |
| Inward foreign prefixes cited by `PRD-008` | **52**, every one a correct foreign citation (`BC-nn` 695, `PRD-nnn` 261, `ADR-nnnn` 206) |
| Outward: `FEE-*` **definitions** outside the module | **0** |

### 2.4 ⚠ A naive probe of my own, corrected by inspection rather than trusted

My first outward check reported **16 hits** and looked like sixteen collisions. **Each was resolved against the 259
identifiers `PRD-008` actually defines, and all 16 matched** — they are table rows in `ACCEPTED`
`ADR-0035`/`0037`/`0039`/`0040`/`0041`/`0042` citing `FEE-GAP-002`, `FEE-XC-022`, `FEE-FR-028`, `FEE-FR-042`,
`FEE-BR-007`, `FEE-BR-019`, `FEE-AC-032`/`033`/`034` and `FEE-GAP-001`. **A citation is not a collision.**

The gate therefore **resolves** each hit against the defined set rather than allow-listing files, so a genuinely
**new** `FEE-*` definition in any of those same ADRs would still fail the run.

⚠ **And the figure then went stale by my own hand.** Writing §2G added **2** further line-start occurrences — in the
matrix itself — making the true count **18**, not 16. §2G.1 was corrected and **the drift is disclosed in the
section and in the changelog** rather than quietly overwritten; it is the same `GCP-01`/`07`/`08` derived-statement
class this repository already tracks. Note also that the gate grants the matrix **no self-exemption**: §2F's
convention is that *"this section's own citations are not counted as outward hits"*, but this gate counts them
anyway and then resolves them, so the matrix earns nothing a governance document is denied.

---

## §3 `Q-B31` — ⛔ **STOP.** The contract cannot be authored on existing authority

**This is the section the instruction's clause 5 was written for.** The answer is not "the contract is hard to
write" or "it needs more analysis." It is that **an `ACCEPTED` ADR expressly withholds each of the five values, and
a second `ACCEPTED` ADR forbids inventing them.**

### 3.1 What `Q-B31` requires

`ADR-0040` **§4 L165** defines the wire contract as five elements — **endpoint, schema, signature, replay window,
retry policy** — and assigns them to the **`BC-31` owner, once `PRD-019` exists**. `PRD-019` now exists (created at
`ADR-0043`). So the procedural bar that blocked the previous pass is **gone**. The remaining bar is substantive.

### 3.2 Each of the five values, measured against existing authority

`ADR-0035` **§5.5b** is `ACCEPTED`. It records the conferred decision *"Inbound payment webhook = existing Business
Platform capability. **Do not create a new BC or invent an endpoint/schema**"* — and then enumerates, as
**prohibitions on future authors**, exactly what was *not* conferred:

| Value required by `Q-B31` | Does existing authority supply it? | Evidence |
|---|---|---|
| **Endpoint** (URL / path / route) | ⛔ **NO — expressly withheld** | `ADR-0035` §5.5b: *"**No endpoint, URL, path or route** — Explicitly excluded by the decision"* |
| **Payload schema** (field list, content type) | ⛔ **NO — expressly withheld** | §5.5b: *"**No webhook payload schema, field list or content type** — Same"* |
| **Signature verification** (algorithm, header) | ⛔ **NO — expressly withheld** | §5.5b: *"**No signature algorithm, header name, secret-rotation or replay-window value** — Same. `FEE-BR-016` requires server-side confirmation; **how** is unspecified and stays so"* |
| **Replay protection** (window duration) | ⛔ **NO — expressly withheld** | Same row as above |
| **Retry behaviour** (count, backoff, dead-letter) | ⛔ **NO — expressly withheld** | §5.5b: *"**No retry policy, timeout, or dead-letter behaviour** — Not conferred"* |
| **Provider** (prerequisite to all five) | ⛔ **NO — no decision exists** | §5.5b: *"**No named gateway provider** — None appears in this ADR"* |

**Five for five, withheld by name, by an `ACCEPTED` ADR.** This is not an absence of evidence that further searching
might fill. `ADR-0035` §5.5 states the point in terms this ADR will not weaken: *"**No amount of further measurement
will produce this answer** — it does not exist in the repository, and inventing it is precisely what this ADR must
not do."*

### 3.3 The provider question is the root, and it is a live Rank 1 / Rank 6 conflict

Every one of the five values is a **property of a chosen provider's wire format**. A repository-wide search finds
**18** provider mentions, and **not one is a decision**:

| Source | Rank | What it says |
|---|---|---|
| EA **L1405** | **6** | `Razorpay (V1)` — inside the `BUSINESS PLATFORM` capability tree |
| EA **L79** | **6** | *"Single gateway (Razorpay) = vendor lock-in"* — a **risk note**, not a selection |
| **`MASTER_PRD.md` L232** | **1** | Payments = *"`BC-20` via `BC-31`"*, gateway *"**Not named in EA** — candidate only"* |

**Rank 1 says no vendor is chosen; Rank 6 names one.** `MP-CON-08` (MASTER_PRD **L519**) governs exactly this:
the EA is descriptive, higher rank wins, and *"a disagreement is a **defect to be raised**, not a choice to be
made."* `DOCUMENTATION_BASELINE.md` **L224**: *"A conflict is a defect. If you find one, do not choose — raise it."*

**It is already raised.** `PRD-008` `FEE-GAP-010` records this exact conflict, with **Owner: Architecture Owner**
and **Authority: REQUIRES ARCHITECTURE OWNER**, and its `Impact` row states the consequence plainly: *"it blocks
`FEE-GAP-002`'s resolution."* **This ADR adds nothing to that and resolves nothing about it** — choosing a vendor
here would be picking a side in a Rank 1/Rank 6 conflict, which is the precise act both rules forbid.

### 3.4 Two further live prohibitions, so the bar is not understated

| Constraint | Source | Effect on `Q-B31` |
|---|---|---|
| `BC-20` may not name a webhook schema | **`PRD-022` `SAAS-XC-006`** (L157–158) | The sibling billing PRD is barred from the same act |
| `PRD-008` forbids itself the same | **`PRD-008` L863**, `FEE-XC-006` | The consuming PRD is barred |
| Writing another PRD's content in an ADR creates a second source of truth | **`ADR-0040` L166** | **This ADR may not author it either** |

The last row is why this section is a *report* and not a specification. `ADR-0040` L166 bars an ADR from holding
another document's contract, and `ADR-0039` §7.2 bars an ADR from performing a PRD specification act.

### 3.5 ⛔ **The exact decisions required, and their exact owners**

Per clause 5, stated so they can be acted on without re-derivation:

| # | Decision required — exact wording | Owner | Blocked artefact |
|---|---|---|---|
| **1** | **Select the V1 payment gateway provider for student → library payments, and resolve the Rank 1 / Rank 6 conflict between `MASTER_PRD.md` L232 (*"Not named in EA — candidate only"*) and EA L1405 (`Razorpay (V1)`) — by amending the EA forwards under `MP-CON-08`, or by ruling that L1405 is descriptive of a candidate only.** This is `FEE-GAP-010`, already open | **Architecture Owner** (`PRD_OWNERSHIP_MODEL.md` **L85**) | **Prerequisite to all five wire values** |
| **2** | **Author the five wire elements in `PRD-019` §4 — endpoint, payload schema, signature algorithm + header, replay-window duration, retry policy + backoff — against the provider selected in decision 1.** `ADR-0035` §5.5b's six prohibitions must be lifted or superseded by the same authority that imposed them, since it withheld each element by name | **`BC-31` owner**, with **Architecture Owner** to lift §5.5b's prohibitions | **`PRD-019` Stage 2/4; the end-to-end gateway-payment feature** |

**Ordering is not a preference.** Decision 2 is unanswerable before decision 1: an endpoint, a signature algorithm
and a replay window are all provider-specific facts.

### 3.6 What `Q-B31`'s remaining open state does and does not block

| Blocked | Not blocked |
|---|---|
| ⛔ The **feature** — an end-to-end gateway payment confirmed by webhook — **cannot be built** | ✅ **`PRD-008` Stage 5** — no `FEE-*` identifier names a wire element |
| ⛔ **`PRD-019`'s own** Stage 2 (registers empty) and Stage 4 | ✅ **`PRD-008` Freeze blockers stay 0** — verified by the unmodified gate |

This is `PRD-019` §4.1's already-recorded disposition — *"BLOCKS the **feature**, not this PRD"* — the established
`PRD-008` pattern at `FEE-GAP-013`/`014`/`017`. **`PRD-019` and `PRD-008` are both byte-unchanged by this pass**, so
the wire contract is duplicated nowhere and `PRD-019` remains its sole owner.

---

## §4 The honest statement of what Stage 5 passing does and does not mean

**Stage 5 asks a narrow question and it is now answered affirmatively.** It asks whether the registers are
registered with correct counts and ranges and zero collisions. They are, mechanically.

⚠ **It does not make the Revenue & Finance scope end-to-end implementable, and this ADR will not imply that it
does.** The instruction's stated goal was to *"make the existing Revenue & Finance scope genuinely
implementation-ready."* The accurate answer:

| Question | Answer |
|---|---|
| Is every `PRD-008` obligation identified, ranged, collision-free and traceable to a test? | ✅ **Yes** — 134/134, 98 criteria, zero orphans either direction |
| Can a developer start on `PRD-008`'s own scope? | ✅ **Yes for Stage 5's purposes** — though Stage 6 has not run, so no `IMPL-*` task exists |
| Can the **gateway-webhook payment feature** be built? | ⛔ **No** — `Q-B31`, blocked on two authority decisions (§3.5) |
| Is `PRD-008`'s architecture review passed? | ⛔ **No** — Stage 3 remains **NOT ALIGNED 5/6**, and §2G does not upgrade it |

**Stages 3 and 5 are independent, and passing the later one does not repair the earlier.** Saying otherwise would be
the "gate green on a decision nobody made" failure `ADR-0035`'s acceptance record names.

---

## §5 The six items inspected under clause 6 — one acted on, five deliberately not

Clause 6 required inspection, and resolution **only** where Stage 5 requires it **and** existing authority suffices.

### 5.1 `FEE-RSK-*` register declaration — ✅ **inspected and acted on, because Stage 5 requires it**

`FEE-RSK-01`…`10` are defined in `PRD-008` §38, contiguous and well formed, but **absent from §0.2**, which §0.1
requires (*"declared up front with ranges"*). This is a **pre-existing Stage 2 defect**.

**Two readings were available and the flattering one was refused:**

| Option | Consequence |
|---|---|
| **Omit `FEE-RSK-*` from §2G** | A tidy eight-register section matching §0.2 exactly, passing with no footnote — while **ten identifiers exist in a Rank 3 document and in no register anywhere**, the exact condition Stage 5 prevents |
| ✅ **Register it, and disclose the §0.2 omission** | Stage 5's question is answered truthfully, and the defect stays visible. **The gate prints the finding on every run** and cannot be silenced without editing the script |

**Registering a prefix in the matrix does not repair `PRD-008` §0.2.** Adding that row is a **document-owner act on
`PRD-008`**, which this pass does not perform — `PRD-008` is byte-unchanged. **Outstanding, for the `PRD-008`
document owner: add a `FEE-RSK-*` row to §0.2 with count 10 and range `001`…`010`.**

### 5.2 `Q-A6` — ⛔ **not resolved. Rank 1 remains byte-unchanged**

`Q-A6` is the stale *"v2.1"* EA citation inside **Rank 1** `MASTER_PRD.md` after the EA moved to v2.2. **Stage 5
does not require it**: it concerns a version citation, not a register. Editing Rank 1 requires **Architecture
Owner** authority and an ADR *before* the change (`DOCUMENTATION_BASELINE.md` §7 step 1). `MASTER_PRD.md` is
verified byte-unchanged at sha256 `5c31a3363d99a5f6`. **Still open, Architecture Owner.**

### 5.3 `Q-A7` — ⛔ **not resolved.** The Rank 6 report-tier question raised by `ADR-0043` §11. Not required for Stage 5; **Architecture Owner**.

### 5.4 `Q-S1` — ⛔ **not resolved.** Financial-record retention, **Product Owner + Security/Compliance jointly**. Not required for Stage 5, and inventing a retention period is expressly barred. `FEE-XC-011` already determines V1 behaviour (nothing is purged), so there is no undefined behaviour to implement against.

### 5.5 `GCP-14` — ⛔ **not resolved, and deliberately left open**

The registry's two incompatible `DRAFT` tests. `ADR-0043` §8.2 answered it *for the purpose of that pass* on four
grounds while explicitly declining to rewrite the register, because the wording defect belongs to the **governance
owner of `PRD_REGISTRY.md` + `PRD_LIFECYCLE.md`** (`PRD_REGISTRY.md` **L351**). **Stage 5 does not require it** —
Stage 5's gate is the matrix, not the registry's status vocabulary. `PRD_REGISTRY.md` is byte-unchanged.

### 5.6 Stale EA citations — ⛔ **inspected, NOT corrected, and the reason is not convenience**

| Location | Cites | Actual | Verified |
|---|---|---|---|
| `PRD-008` §22.1 | *"EA L1424"* `Financial Reports (V1)` | **L1423** | ✅ L1423 is `Financial Reports (V1)`; L1424 is `AdMob Monetization (V2)` |
| `PRD-008` §29.3 | *"EA L1413"* | L1413 = `Invoice Generation (V1)` | ✅ correct as a line, contested as support |
| `PRD-008` L799 | *"EA L1408"* `Webhook Reconciliation (V1)` | **L1407** | ✅ L1407 is `Webhook Reconciliation`; L1408 is `Refund Management (V2)` |
| `PRD-008` L2112 | *"L1409"* for the refund node | **L1408** | ✅ L1409 is `Payment Retry (V2)` |

**All four are real defects and all four are left in place.** Three reasons, in order of force:

1. **Stage 5 does not require them.** A line-number citation is not a register, a count, a range or a collision.
   Fixing them would be scope this pass was told not to take (*"Resolve only issues required for Stage 5"*).
2. **Every one is an edit to `PRD-008`**, and this pass keeps `PRD-008` byte-unchanged — a claim worth more than
   four corrected line numbers, because it is what makes "Stage 5 changed nothing about the requirements" checkable.
3. **`ADR-0035` set the precedent explicitly** for this same class, refusing to fix `PRD-008` L799 mid-decision:
   *"editing its evidence mid-decision is precisely the move this document refuses elsewhere."*

⚠ **They are already disclosed** in `PRD-008` §22.1/§29.3, `ADR-0035`, `ADR-0041` and `ADR-0042`. **Outstanding, for
the `PRD-008` document owner: correct L1424 → L1423, L1408 → L1407, L1409 → L1408.** None changes a verdict.

---

## §6 What this ADR deliberately does NOT do

| Not done | Why |
|---|---|
| **No endpoint, URL, route, payload field, schema, signature algorithm, header, replay window, retry count, backoff or dead-letter behaviour** | §3.2 — each expressly withheld by `ACCEPTED` `ADR-0035` §5.5b |
| **No payment provider named as chosen** | §3.3 — a live Rank 1/Rank 6 conflict; `FEE-GAP-010`, Architecture Owner |
| **`PRD-008` NOT frozen** | Stage 7's gate is a row in `DOCUMENTATION_BASELINE.md` §3. **No row written**; the file is byte-unchanged. *"Freeze is conferred, not claimed"* |
| **No `IMPL-*` range allocated** | That is **Stage 6**. `docs/40-implementation/` has no `revenue-finance/` subdirectory and `PRD-008` contains **0** `IMPL-` tokens |
| **No checker weakened** | `prd008_stage5.py` is **new**; the other eight gates are byte-unchanged. The new gate was **proved to fail** before §2G existed |
| **No Rank 1–7 document changed** | 7 protected sha256 hashes re-verified — §7 |
| **`PRD-008` and `PRD-019` byte-unchanged** | The wire contract is duplicated nowhere; `PRD-019` remains sole owner |
| **No new `FEE-*`, `ITG-*`, `BC-*`, `E-*`, permission, config or financial rule** | §0.2 stays **249 / 134**; `FEE-*` distinct identifiers stay **259** |
| **No baseline identifier change** | §7 step 4 moves it only when a Rank 1–3 document changes version. None did |
| **No gap marked `RESOLVED`** | `FEE-GAP-002`'s contract limb and `FEE-GAP-010` both stay **OPEN** |
| **No new V1 product feature** | Nothing user-facing was added |
| **`Q-A6`, `Q-A7`, `Q-S1`, `GCP-14` left open** | §5 — none required for Stage 5, each needs an authority this pass does not hold |

---

## §7 Verification — measured, not asserted

| # | Check | Result |
|---|---|---|
| 1 | `python3 tool/docs_check/prd008_stage5.py` | **exit 0 — PASS.** Stage 5 gate satisfied |
| 2 | Same script run **before** §2G existed | **exit 1**, reporting the missing section as the Stage 5 failure |
| 3 | `python3 tool/docs_check/prd008_traceability.py` | **exit 0 — PASS.** 134 obligations, AC 98/98, Stage 4 **0**, **Freeze 0** |
| 4 | `prd008_traceability.py` sha256 | **`9ceaf1825764dbbe`** — byte-unchanged. Not weakened |
| 5 | Eight `docs_check` gates | **`1/0/1/0/0/0/1/0`** — identical to baseline |
| 6 | `grep -c 'FEE-' TRACEABILITY_MATRIX.md` before / after | **0 → non-zero.** The gate was genuinely unmet |
| 7 | All nine ranges contiguous 1..max | ✅ computed from the body |
| 8 | Obligation total recomputed | **134** = 62+28+10+3+23+8 |
| 9 | `FEE-*` definitions outside the module | **0** (18 line-start hits, all resolved to defined identifiers) |
| 10 | Bare `PO-n`/`SPO-n` tokens in `PRD-008` | **0** |
| 11 | Prefix tokenisation `'FEE-PO-003'` | **`['FEE-PO']`** — asserted inside the gate |
| 12 | Wire **values** in this ADR, `PRD-008`, `PRD-019` | **0** URLs · **0** named algorithms · **0** replay durations · **0** retry counts · **0** providers chosen |
| 13 | `PRD-008` sha256 | **unchanged** — not one byte |
| 14 | `PRD-019` sha256 | **unchanged** — not one byte |
| 15 | `MASTER_PRD.md` sha256 | **`5c31a3363d99a5f6`** unchanged (`Q-A6` respected) |
| 16 | BC Map / Dep Matrix / manifest / EA / baseline sha256 | **all unchanged** |
| 17 | `DOCUMENTATION_BASELINE.md` §3 rows for `PRD-008` | **0** — not frozen |
| 18 | Dart files changed | **0** under `lib/ test/ pubspec.yaml android/ web/` |
| 19 | `docs/40-implementation/revenue-finance/` | **does not exist** — Stage 6 not performed |

---

## §8 Objections to this ADR, stated before they are raised

**"You could have written the contract from EA L1405 — it says `Razorpay (V1)`."**
That is the §5.5a error, and `ADR-0035` §5.5b already recorded why it fails: the EA is *"Descriptive — must follow
the PRDs, never lead them"* (`DOCUMENTATION_BASELINE.md` **L139**) and therefore **cannot confer** a selection. A
prior pass offered an EA line as authority and was **overturned**. Rank 1 `MASTER_PRD.md` L232 says the gateway is
*"candidate only"*, and it outranks L1405. Reading a provider out of L1405 would be choosing a side in a conflict
`MP-CON-08` says must be raised.

**"Stage 5 passing while `Q-B31` is open makes the pass hollow."**
It would be hollow if Stage 5 were claimed to mean more than it does — hence §4, which states plainly that the
feature is unbuildable. What Stage 5 verifies is real and was genuinely absent: 259 identifiers had no register.

**"Adding your own gate and then passing it is circular."**
It would be if the gate had been written to fit. It was written **first**, run against the unmodified matrix, and
**failed** (§7 row 2). It also fails on conditions §2G could easily have violated — a wrong count, a range hole, a
foreign definition, an unknown register, an ambiguous prefix.

**"You registered `FEE-RSK-*` in the matrix but not in `PRD-008` §0.2 — that is half a fix."**
Correct, and deliberate. The other half is an edit to `PRD-008`, which this pass keeps byte-unchanged; it is named
as outstanding in §5.1 and printed by the gate on every run.

**"Leaving four wrong line numbers in place is laziness dressed as discipline."**
The test is whether the omission is *disclosed and attributed*. All four are named with their correct values in
§5.6, and `ADR-0035` set this exact precedent for this exact citation.

---

## §9 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | **Created `ACCEPTED`. `PRD-008` Stage 5 traceability registration — the gate was measured UNMET (`FEE-` count in `TRACEABILITY_MATRIX.md` = **0**) and is now MET.** Registers nine `FEE-*` registers in new **§2G** (259 identifiers, **134** obligation-bearing, all ranges contiguous, **zero collisions in both directions**) with counts **computed** by the new [`tool/docs_check/prd008_stage5.py`](../../../tool/docs_check/prd008_stage5.py), which **adds** a gate and weakens none — `prd008_traceability.py` is byte-unchanged at `9ceaf1825764dbbe` and was proved to fail before §2G existed. **§2.3 tests the `PO-`/`SPO-` collision class Stage 5 exists for**, the sharpest instance in the repository: `FEE-PO-*` is a **port**, `PO-n` a Library protected operation and `SPO-n` a Student Identity one — three meanings, three contexts — with tokenisation **asserted inside the script** and **0** bare `PO-n` tokens in `PRD-008`. **§2.4 discloses two naive probes of my own**: 16 outward "collisions" were all citations resolving to defined identifiers, and the figure then went stale at **18** because §2G itself added two — corrected and disclosed, not overwritten. ⛔ **§3 reports `Q-B31` as UNAUTHORABLE on existing authority and STOPS, as clause 5 requires:** all five wire elements — endpoint, schema, signature, replay window, retry policy — plus the provider are **each expressly withheld by name** in `ACCEPTED` `ADR-0035` §5.5b, and the provider question is a live **Rank 1 / Rank 6 conflict** (`MASTER_PRD.md` L232 *"candidate only"* vs EA L1405 `Razorpay (V1)`) already recorded as `FEE-GAP-010`. **§3.5 names the two exact decisions and owners:** (1) select the V1 gateway and resolve the Rank 1/Rank 6 conflict — **Architecture Owner**; (2) author the five elements in `PRD-019` against that provider, which also requires §5.5b's prohibitions to be lifted — **`BC-31` owner with Architecture Owner**. Ordering is not a preference: all five values are provider-specific facts. **§4 states plainly that Stage 5 passing does NOT make the feature buildable** and does not upgrade Stage 3, which remains **NOT ALIGNED 5/6**. **§5 inspects all six clause-6 items: `FEE-RSK-*` acted on** (registered **with** a standing disclosure, refusing the tidier eight-register section that would have left ten identifiers in no register anywhere), and **`Q-A6`, `Q-A7`, `Q-S1`, `GCP-14` and four stale EA citations deliberately left**, each with its authority named — the EA citations on `ADR-0035`'s own precedent against editing a document's evidence mid-decision. Creates **no** endpoint, schema, signature algorithm, replay window, retry count, provider, permission, config identifier, financial rule, `FEE-*`, `ITG-*`, `BC-*` or `E-*` edge. **`PRD-008` and `PRD-019` byte-unchanged — not one byte**; no Rank 1–7 document changed; no baseline row written; **`PRD-008` NOT frozen**; no gap marked `RESOLVED`; no checker weakened; no new V1 feature; **0 Dart files touched**. |
