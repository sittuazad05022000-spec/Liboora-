# ADR-0045 — `FEE-GAP-010`: the gateway provider CANNOT be ratified from the repository — a measured STOP

| Field | Value |
|---|---|
| **ADR** | `ADR-0045` |
| **Title** | `FEE-GAP-010` — gateway provider authority STOP, and why `Q-B31` stays unauthored |
| **Status** | `ACCEPTED` |
| **Decision by** | **Technical Owner** — `PRD_OWNERSHIP_MODEL.md` **L85** (*"Implementation, `IMPL-*` tasks, traceability from requirement to test, §10.4 gate health"*). **No Architecture Owner authority is claimed or exercised.** This ADR decides **nothing about the provider**; it records that the provider cannot be decided here, and by whom it must be. |
| **Date** | 2026-08-15 |
| **Supersedes / amends** | **Nothing.** No ADR is promoted, demoted, scoped or superseded. No frozen document, no Rank 1–6 document and no checker is modified. |
| **Baseline** | Written against `BASELINE-2026-08-05-A`. **Not admitted to it.** No baseline identifier is re-issued (`DOCUMENTATION_BASELINE.md` §7 step 4 — no Rank 1–3 document changed version). |
| **Relates to** | `FEE-GAP-010`, `FEE-GAP-002`, `Q-B31`, `PRD-019` §4, `ACCEPTED` `ADR-0035` §5.5b, `ACCEPTED` `ADR-0040` §4, `ADR-0044` §3 |

---

## §1 What was asked, and what was measured

The instruction was to *"resolve the gateway dependency using the cleanest lawful path"*, in seven steps.
Steps 3, 4, 5 and 6 are **expressly conditional** on step 2 — *"Once the provider is legitimately decided"* —
and step 2 itself carries its own escape condition, quoted verbatim:

> *"If the repository already contains sufficient authority to ratify Razorpay V1, record that decision;
> **otherwise STOP and report the exact authority action required.**"*

The condition was tested, not assumed. It is **not** met.

| Step | Instruction | Result |
|---|---|---|
| 1 | Treat Razorpay V1 as recommended direction, do NOT silently treat it as accepted | ✅ **Honoured.** Recorded as the recommended direction in §5; **not** treated as accepted, because measurement shows it is not |
| 2 | Ratify if the repository holds sufficient authority, **else STOP** | ⛔ **STOP.** Authority measured **absent** — §2. Exact action + owner in §5 |
| 3 | Make `PRD-019` sole owner of the wire contract | ✅ **Already true and unchanged** — §4. `ADR-0040` §4 assigned it; `PRD-019` §4 holds the open item. **Nothing to change, so nothing was changed** |
| 4 | Have `BC-31` define the minimum V1 contract in `PRD-019` | ⛔ **NOT DONE** — blocked by step 2. Writing it would require inventing provider-specific values, which step 6 forbids. §3 |
| 5 | Do NOT duplicate the contract in `PRD-008` | ✅ **Honoured** — `PRD-008` is **byte-unchanged**; zero wire elements added anywhere |
| 6 | Do NOT invent provider-specific values unless authorised by the accepted provider decision | ✅ **Honoured** — there is no accepted provider decision, therefore **nothing is authorised, therefore nothing was written** |
| 7 | Preserve accepted ADRs, frozen documents, boundaries; weaken no checker | ✅ **Honoured** — all protected hashes MATCH; no checker touched; a gate was re-run, none relaxed |

**The chain is load-bearing.** Step 6 makes step 4 impossible unless step 2 succeeds. Step 2 did not succeed.
Doing step 4 anyway would have satisfied the *letter* of four instructions by violating the *one* that guards them.

---

## §2 The finding: every Razorpay mention in the repository is descriptive, critical or prohibitive — none is a selection

`Razorpay` was located at **every** occurrence across `docs/` and `tool/` and each was read **in its column and
its enclosing structure**, not by keyword. There are six distinct authoritative sites. **Not one ratifies.**

| # | Site | Rank | What it actually is | Ratifies? |
|---|---|---|---|---|
| 1 | **EA L1405** — `│   ├── Razorpay (V1)` | **6** | A **leaf node in the descriptive capability tree**, under `Payment Gateway (V1)` → `Payment Gateway Abstraction (V1)`. Rank 6 is *"**Descriptive only.** Update it to match 1–5; **never the reverse**"* (`DOCUMENTATION_BASELINE.md` **L221**) | ❌ **No** |
| 2 | **EA L79** — *"Single gateway (Razorpay) = vendor lock-in"* | **6** | Measured to sit in the **`Gaps / Weaknesses` column of §2 "Platform-by-Platform Review & Scoring"**, row 11 `BUSINESS PLATFORM`, score 8.0. It is a **criticism of** single-gateway dependence, cited **against** itself | ❌ **No** — the opposite |
| 3 | **Dependency Matrix L167** — *"The domain must not know that Razorpay, Twilio or FCM exist"* | **4** | Measured inside **§5.1 "How to read three important cells"** — a **prohibition** on the domain knowing the vendor's name | ❌ **No** — a prohibition |
| 4 | **Dependency Matrix L352** — *"Just call Razorpay from the payment service"* | **4** | Measured inside the **forbidden-edge table** (`# / Forbidden edge / Why it's tempting / Why it's fatal / Do this instead`), row **`X-03`**. Razorpay appears as **the tempting mistake**, remedy *"Call `business.payment_intent` port"* | ❌ **No** — an anti-pattern |
| 5 | **`ACCEPTED` `ADR-0035` §5.5b** | **2** | Enumerates *"**No named gateway provider** \| None appears in this ADR"* among its prohibitions on future authors | ❌ **No** — explicitly withheld |
| 6 | **`MASTER_PRD.md` L232** | **1** | `\| Payments \| BC-20 via BC-31 \| Payment Gateway Abstraction \| Gateway \| **Not named in EA** — candidate only \|` | ❌ **No** — *"candidate only"* |

**The single most decisive line in the repository** is in `ACCEPTED` `ADR-0035`'s own
*"what acceptance does not license"* table, measured verbatim at **L774**:

> `| An endpoint, schema, signature scheme or provider is defined | ❌ **No.** Explicitly excluded by the decision (§5.5b) |`

An `ACCEPTED` Rank 2 ADR states, in its own words, that **no provider is defined by it**. That is not silence to
be read as assent — it is an express negative. And **L776–L779** forecloses the remaining escape:

> *"This conferral covers `D-1`, `D-2`, `D-3`'s authorisation and `D-4`. It is **not** a standing grant — `ADR-0033`
> §7.1's *"A conferral for one act is not a standing licence"* is quoted here deliberately, because it now applies
> to *this* ADR's future readers. Any further decision on the payment surface … **requires its own conferral.**"*

### 2.1 The tempting shortcut, named so the refusal is auditable

EA **L1405** says `Razorpay (V1)`. It would have been easy, and would have looked responsive, to read that as
"the architecture already says Razorpay, so V1 is settled — just record it." **Three measurements refuse that
reading**, and they are worth stating because each removes a different escape route:

1. **Rank.** The EA is **Rank 6**, the *lowest* substantive rank, and explicitly *"descriptive only"*. Rank 1
   `MASTER_PRD.md` **L232** says the gateway is **"Not named in EA — candidate only"**. When Rank 1 and Rank 6
   disagree, Rank 1 wins — and here Rank 1 says *the EA does not name it*, which is itself a statement about
   what the EA's mention means.
2. **`MP-CON-08` forbids resolving it by choice.** Rank 1 **L519**: the EA is *"descriptive, not prescriptive"*
   and a disagreement is *"a **defect to be raised**, not a choice to be made"*. `DOCUMENTATION_BASELINE.md`
   **L224** repeats it: *"A conflict is a defect. If you find one, do not choose — raise it."* Ratifying Razorpay
   from the EA would be **choosing**, which both Rank 1 and the baseline forbid.
3. **The direction of correction runs the other way.** `MP-CON-08` and baseline **L221** both say the EA is
   updated to match Ranks 1–5, *"never the reverse"*. So EA L1405 is not evidence that Razorpay is decided; it
   is a candidate awaiting a higher-ranked decision, and if that decision named a different provider, **L1405
   is the line that would change** — as `ADR-0042` §4 already demonstrated by amending EA L823 forwards.

There is a fourth reason, and it is the plainest: **there is no Razorpay documentation in this repository at
all.** A repository-wide search for any vendor artefact — a signature header, a signature field name, an API
host — returns **zero** matches. Step 6 permits provider-specific values *"authorised by the accepted provider
decision/documentation"*. **Neither the decision nor the documentation exists here**, so step 6 authorises
nothing, and every one of the five wire elements would have to be **invented**.

### 2.2 What "sufficient authority" would have looked like

So the STOP is falsifiable rather than merely asserted, this is the evidence that **would** have satisfied step 2:

- an **`ACCEPTED`** ADR whose `Decision by` field names the **Architecture Owner** and whose decision text
  selects a named provider for V1; **or**
- a Rank 1–4 document naming the provider in a **normative** position (not a tree leaf, not a risk column, not
  a forbidden-edge example); **or**
- a `FEE-GAP-010` block whose `Status` reads `RESOLVED` with a cited authority.

Measured today: `FEE-GAP-010` `Status` = **`OPEN`**, `Authority` = **`REQUIRES ARCHITECTURE OWNER`**,
`Owner` = **Architecture Owner**. The gap register agrees with this ADR.

---

## §3 Why the minimum V1 contract still cannot be written (step 4)

`Q-B31` needs five elements. Each was tested against existing authority **individually**, because a blanket
refusal would be lazy and might hide one element that *is* in fact decided. **None is.**

| Element | Nearest authority | Verdict |
|---|---|---|
| **Endpoint / URL / path** | `ADR-0035` §5.5b — *"No endpoint, URL, path or route"* | ⛔ Withheld by name |
| **Payload schema / fields** | `ADR-0035` §5.5b — *"No webhook payload schema, field list or content type"* | ⛔ Withheld by name |
| **Signature verification** | `ADR-0035` §5.5b — *"No signature algorithm, header name, secret-rotation or replay-window value"*. `FEE-BR-016` requires server-side confirmation; **how** is unspecified *"and stays so"* | ⛔ Withheld by name |
| **Replay protection** | same row — replay-window **value** expressly withheld | ⛔ Withheld by name |
| **Retry behaviour** | `ADR-0035` §5.5b — *"No retry policy, timeout, or dead-letter behaviour \| Not conferred"* | ⛔ Withheld by name |
| **Required provider details** | §2 of this ADR | ⛔ No provider decided; no vendor documentation exists |

Three further prohibitions concur independently, so the conclusion does not rest on `ADR-0035` alone:
`PRD-022` **`SAAS-XC-006`** bars `BC-20` from naming a webhook schema; **`PRD-008` L863** forbids itself the
same; and **`ADR-0040` L166** — *"Writing another PRD's content here would create a second source of truth"*.

**A provider-agnostic contract is not a lawful substitute.** All five elements are, by their nature,
provider-**specific**: a signature algorithm and header name are the gateway's, not ours; a replay window is
tuned to the gateway's retry schedule; a payload schema *is* the gateway's wire format. Writing a
"placeholder" contract would produce a document that looks implementable and is not — the precise failure mode
`PRD-019` §4 already warns of: *"A named hole is honest; an invented contract is not."*

---

## §4 Step 3 was already satisfied, and is confirmed rather than re-performed

`PRD-019` **is** the sole owner of the wire contract, and was before this pass:

- **`ACCEPTED` `ADR-0040` §4 L165** assigns the five wire elements to the **`BC-31` owner, once `PRD-019` exists**.
- **`PRD-019` §4** carries the `Q-B31` row with `Owner` = **`BC-31` owner *(this document's owner)*** and
  `Blocks` = ***"`PRD-019`'s own Stage 4 and Freeze. ⛔ NOT `PRD-008`'s"***.
- **`PRD-008` holds none of it** — measured **0** endpoints, **0** schemas, **0** algorithms, **0** replay
  windows, **0** retry counts, and it is **byte-unchanged** by this pass.

So sole ownership is **already correct**. Re-asserting it in a second document would create exactly the second
source of truth `ADR-0040` L166 forbids. **Confirmed, not duplicated.**

Step 5 is likewise satisfied by construction: `PRD-008` keeps only financial verification, recording,
reconciliation and financial invariants — `FEE-FR-028` is testable today via `FEE-AC-085`…`089`, **none of
which names a wire element**.

---

## §5 The exact authority action required, and by whom

This is the deliverable of the STOP. Two acts, in this order. **Neither is a Technical Owner act; neither is
performed here.**

### 5.1 Act one — the provider decision

| Field | Value |
|---|---|
| **Decision required** | Select the payment gateway **provider** for V1, or confirm that `Razorpay` is selected for V1 |
| **Owner** | **Architecture Owner** |
| **Authority basis** | `PRD_OWNERSHIP_MODEL.md` **L85** — *"Boundaries, ranks, permitted edges, precedence … ADR approval; any Rank 1–5 document change"* |
| **Instrument** | A **new `ACCEPTED` ADR**, or a conferral recorded in one. `ADR-0035` **L776–L779** requires *"its own conferral"* — the 2026-08-05 conferral does **not** reach this |
| **Why it cannot be delegated** | Rank 1 `MASTER_PRD.md` L232 and Rank 6 EA L1405 **disagree**. Under `MP-CON-08` a conflict is *"a defect to be raised, not a choice to be made"*, and only the Architecture Owner may settle precedence |
| **Consequential edits it authorises** | Resolve `FEE-GAP-010`; under `MP-CON-08` bring the **Rank 6 EA into line** with the decision (L1405 and the L79 risk note), *never the reverse*; update `MASTER_PRD.md` L232's *"candidate only"* cell — **a Rank 1 change, requiring an ADR first** (`DOCUMENTATION_BASELINE.md` §7 step 1) |
| **What it must NOT do** | Ratify by citing EA L1405 alone. That is the shortcut §2.1 refuses, and it would invert the Rank 6 rule |

### 5.2 Act two — the wire contract, only after 5.1

| Field | Value |
|---|---|
| **Decision required** | Author the minimum V1 webhook contract: endpoint, payload schema, signature verification, replay protection, retry behaviour, required provider details |
| **Owner** | **`BC-31` owner** |
| **Where** | **`PRD-019` §4**, replacing the `Q-B31` row. **Nowhere else** — not `PRD-008`, not an ADR (`ADR-0040` L166) |
| **Inputs it needs** | (a) the provider from 5.1; (b) **that provider's own published webhook documentation**, which this repository does not contain |
| **Then** | `Q-B31` closes · `PRD-019` becomes Stage-4-runnable · `ITG-*` identifiers get issued (currently **0**) · Stage 5 registration for `ITG-*` follows |

### 5.3 Recommended direction, recorded as a recommendation only (step 1)

**Razorpay V1 is the recommended direction.** Its basis is stated so its weight is not overstated: EA L1405
lists it as the V1 gateway leaf, and no competing provider is named anywhere in the repository. That is a
**reasonable recommendation and an insufficient ratification** — recorded here **as a recommendation**, exactly
as step 1 requires, and deliberately **not** written into any register, gap field, PRD or requirement, because
writing it there is what would make it look accepted.

---

## §6 What this ADR does NOT do

Listed because every incentive in the instruction ran the other way — four of its seven steps ask for work
that this ADR declines to perform.

1. **Does not ratify Razorpay** or any provider. `FEE-GAP-010` stays **OPEN**.
2. **Does not resolve `Q-B31`.** It stays open in `PRD-019` §4, unchanged.
3. **Writes no wire element** anywhere: 0 endpoints, 0 URLs, 0 paths, 0 payload fields, 0 schemas,
   0 signature algorithms, 0 header names, 0 replay windows, 0 retry counts, 0 timeouts, 0 backoff schedules.
4. **Does not modify `PRD-008`** — byte-unchanged; still **DRAFT v1.7**; **not frozen**; no baseline row.
5. **Does not modify `PRD-019`** — byte-unchanged. Its §4 hole is left open **on purpose**.
6. **Does not amend the EA.** L1405 and L79 are untouched: correcting them is a *consequence* of 5.1, not a
   precondition, and doing it first would be Rank 6 leading Rank 1.
7. **Does not amend `MASTER_PRD.md` L232** — Rank 1, requires an ADR **before** the change (§7 step 1) by the
   Architecture Owner.
8. **Promotes, demotes and supersedes nothing.** `ADR-0038` and `ADR-0041` stay `PROPOSED`;
   `ADR-0039` stays `ACCEPTED` in scope.
9. **Creates no `BC-*`, no `E-*` edge, no port, no permission, no config ID, no `IMPL-*` range, no task
   document.** Stage 6 is **not** performed.
10. **Weakens no checker.** No file under `tool/` is modified by this ADR.
11. **Adds no V1 product feature.**
12. **Does not re-issue the baseline identifier** — §7 step 4, no Rank 1–3 version changed.

---

## §7 Verification

Every row was executed, not asserted.

| # | Claim | Instrument | Result |
|---|---|---|---|
| 1 | `FEE-GAP-010` Status is OPEN | read the definition block, not the first prose hit | ✅ `OPEN` |
| 2 | `FEE-GAP-010` Owner is Architecture Owner | same block | ✅ Architecture Owner |
| 3 | `FEE-GAP-010` Authority requires Architecture Owner | same block | ✅ `REQUIRES ARCHITECTURE OWNER` |
| 4 | `ADR-0035` withholds a named provider | grep the §5.5b prohibition rows | ✅ all five phrases present |
| 5 | `ADR-0035` L774 denies a provider is defined | read L774 | ✅ *"❌ No. Explicitly excluded"* |
| 6 | The `ADR-0035` conferral is not standing | read L776–L779 | ✅ *"not a standing grant"* |
| 7 | EA L1405 is a tree leaf | read L1403–L1410 enclosing tree | ✅ under `Payment Gateway (V1)` |
| 8 | EA L79 is a criticism, in a gaps column | locate the §2 review table header | ✅ `Gaps / Weaknesses`, row 11 |
| 9 | Dep Matrix L167 is a prohibition | read §5.1 context | ✅ *"must not know"* |
| 10 | Dep Matrix L352 is an anti-pattern row | read the forbidden-edge table header | ✅ `X-03`, *"Why it's fatal"* |
| 11 | `MASTER_PRD` L232 says candidate only | read L232 | ✅ *"Not named in EA — candidate only"* |
| 12 | Rank 6 is descriptive only | baseline L221 | ✅ *"never the reverse"* |
| 13 | No Razorpay vendor documentation exists | repo-wide search for vendor artefacts | ✅ **0** matches |
| 14 | No accepted ADR ratifies a provider | scan every ADR mentioning Razorpay + its Status row | ✅ none; sole `RATIFIED` concerns invoices |
| 15 | `PRD-008` byte-unchanged | `git diff` vs `bd053ad` | ✅ 0 |
| 16 | `PRD-019` byte-unchanged | `git diff` vs `bd053ad` | ✅ 0 |
| 17 | Protected files unchanged | 8 × sha256 (16-char) | ✅ all MATCH |
| 18 | No checker modified | `git diff` on `tool/` | ✅ 0 |
| 19 | Stage 5 still passes | `prd008_stage5.py` | ✅ exit 0 |
| 20 | Freeze still 0 | `prd008_traceability.py` | ✅ 0 |
| 21 | Zero Dart touched | `git diff` vs `0fa4a8f` | ✅ 0 |

---

## §8 Self-objections

**"You were told to treat Razorpay V1 as the recommended direction — so ratify it."**
Step 1 says *"do NOT silently treat it as accepted"*, and step 2 supplies the escape condition explicitly.
Treating a recommendation as a ratification is precisely what step 1 prohibits. §5.3 records the
recommendation; §2 records why it is not yet authority.

**"Four of the seven steps went unperformed. That is a low completion rate."**
It is, and the count is the wrong measure. Steps 3–6 are conditional on step 2 by the instruction's own
wording (*"Once the provider is legitimately decided"*). Step 3 was **already** satisfied and is confirmed.
Steps 4 and 6 are in direct tension: the only way to perform 4 without 2 is to violate 6. The instruction is
internally consistent — it anticipated this outcome and told me what to do in it.

**"A provider-agnostic skeleton contract would have been progress."**
It would have been a document that reads as implementable and is not. All five elements are inherently
provider-specific (§3). `PRD-019` §4 already names this failure mode.

**"You could have amended EA L1405 to make the provider unambiguous."**
That inverts the rule. Rank 6 is updated **to match** Ranks 1–5, *never the reverse* — and Rank 1 currently
says the gateway is *"candidate only"*. Amending the EA to create the authority I lacked would manufacture
consent from the lowest-ranked document in the ladder.

**"`FEE-GAP-010` has been OPEN for several passes. Closing it would be progress."**
Closing it without an Architecture Owner decision would be **recording a decision nobody made** — worse than
an open gap, because an open gap is visible and a false resolution is not. `FEE-GAP-010`'s own `Authority`
field names the required owner; this ADR agrees with it rather than overriding it.

---

## §9 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | Created. **`ACCEPTED`** by **Technical Owner** authority. Records that `FEE-GAP-010` **cannot** be resolved from repository authority: all six Razorpay sites are Rank 6 descriptive, Rank 6 critical, or Rank 4 prohibitive/anti-pattern, and `ACCEPTED` `ADR-0035` **L774** states in its own words that **no provider is defined**, with **L776–L779** confirming its conferral is *"not a standing grant"*. Reports the two required acts and owners (§5): the **provider decision** (Architecture Owner, new `ACCEPTED` ADR) and then the **wire contract** (`BC-31` owner, into `PRD-019` §4). Confirms `PRD-019` is **already** sole owner (`ADR-0040` §4 L165) and changes nothing to say so. Razorpay V1 recorded as a **recommendation only** (§5.3), deliberately kept out of every register and gap field. **Nothing invented, nothing frozen, no ranked document amended, no checker weakened.** See [`ADR-0044`](./ADR-0044-prd-008-stage-5-traceability-and-q-b31-stop.md) for the Stage 5 registration this ADR leaves intact, and [`tool/docs_check/prd008_stage5.py`](../../../tool/docs_check/prd008_stage5.py) for the gate re-run at exit 0. |
