# ADR-0134 — The `PRD-008` payment divergence: the **successor path is DETERMINED**, the frozen text is **PRESERVED**, and the divergence is **DISCLOSED AT THE ENTRY POINTS**

| Field | Value |
|---|---|
| **ADR** | `ADR-0134` |
| **Title** | `PRD-008` §6.1's five V1 payment rows: successor/amendment path determined; frozen text preserved; divergence disclosed in the baseline and the registry |
| **Date** | 2026-09-10 |
| **Status** | ⭐ **Accepted** — by direct, explicit conferral of the human principal of this engagement, jointly exercising **Product Owner**, **Architecture Owner** and **Governance Owner** authority, scoped to **this act only**. ⛔ All offices **revert on completion** (`ADR-0033` §7.1: *"a conferral for one act is not a standing appointment"*) |
| **Supersedes** | ⛔ **Nothing.** No ADR's decision text is altered |
| **Amends** | **`DOCUMENTATION_BASELINE.md`** (§3.3 `PRD-008` row **L175**, in place; §1 Authority; §8 changelog) · **`PRD_REGISTRY.md`** (new **§20**, appended) · **`ADR-INDEX.md`** (registration + `Count`) |
| **Does NOT amend** | ⛔⛔ **`PRD-008_REVENUE-AND-FINANCE.md` — NOT ONE BYTE** (see §4) · ⛔ **`ADR-0130`** · ⛔ **`ADR-0131`** · ⛔ **`ADR-0132`** · ⛔ **`ADR-0133`** · ⛔ `ADR-0035`, `ADR-0037`, `ADR-0043`, `ADR-0046`, `ADR-0047`, `ADR-0048`, `ADR-0049` · ⛔ `PRD-019_INTEGRATION.md` · ⛔ `PRD-022_SAAS-BILLING.md` · ⛔ `LIBOORA_ENTERPRISE_ARCHITECTURE.md` · ⛔ `LIBOORA_BOUNDED_CONTEXT_MAP.md` · ⛔ `MASTER_PRD.md` · ⛔ `PRD_LIFECYCLE.md` · ⛔ Authentication v2/v3 · ⛔ every frozen PRD |
| **Governs** | The **route** by which `PRD-008` §6.1's V1 payment-method scope is lawfully corrected, and **where the divergence must be visible until then** |
| **Outcome** | ⭐⭐ **The successor path is DETERMINED and NAMED — and deliberately NOT EXECUTED.** The lawful instrument is a **`PRD-008` v1.8 successor amendment** under `PRD_LIFECYCLE` §4's seven-step frozen-PRD route, requiring an ADR **before** the change. ⭐ Until it is executed, the divergence is **DISCLOSED at the two entry points a specification author actually reads** — the baseline declaration and the registry. ⛔ **No frozen requirement is rewritten, no V1 digital payment mechanism is introduced, and no V2 mechanism is invented** |

---

## 1. The exact conflict

⚠ **Measured verbatim in FROZEN `PRD-008_REVENUE-AND-FINANCE.md` v1.7, §6.1's in-scope table:**

| Line | Row as written | Release column | Status under `ADR-0130` |
|---|---|---|---|
| **L208** | `Cash payment` | **V1** | ✅ **CORRECT — remains V1.** ⛔ Must **not** be changed |
| **L209** | `UPI payment` | **V1** | ⛔ **CONTRADICTS `ADR-0130` §1.1 — is V2** |
| **L210** | `Card payment` | **V1** | ⛔ **CONTRADICTS — is V2** |
| **L211** | `Online payment` | **V1** — *"verification obligation specified at v1.5 (`FEE-FR-028`); wire contract still open"* | ⛔ **CONTRADICTS — is V2** |
| **L213** | `Payment verification` | **V1** — *"specified at v1.5 (`FEE-FR-028`, `FEE-AC-085`…`089`)"* | ⛔ **CONTRADICTS as to digital methods — is V2** |
| **L214** | `Webhook reconciliation` | **V1** — *"partly specified at v1.5"* | ⛔ **CONTRADICTS — is V2** |

⭐⭐ **The conflict is exactly five rows, and this act does not widen that finding by one line.** It is the same
set `ADR-0130` §7 recorded and §10A classified, re-verified line by line against the live file before this ADR was
written — ⛔ **not copied from the prior ADR on trust.**

### 1.1 ⭐ What the conflict is *not*

- ⛔ **It is not a defect in `PRD-008`.** The five rows were **correct when written** and were frozen lawfully by
  `ADR-0049`. A decision taken **later**, at a **higher rank**, changed the answer. ⭐ **A superseded-in-effect row is
  a governance consequence, not an error by its author.**
- ⛔ **It is not a `FEE-GAP-*`.** All **17** `FEE-GAP-001`…`FEE-GAP-017` are OPEN, and ⛔ **none of them is the V1
  payment-method scope** — `FEE-GAP-001` is *"is Refund V1 or V2?"* and `FEE-GAP-002` is *"`BC-05` has no declared
  architectural path to a payment gateway."* ⭐ **So this act mints no gap in a frozen document** — it could not,
  without editing it.
- ⛔ **It is not a freeze defect.** `PRD-008` remains **FROZEN, authoritative and fully valid** for its other **134
  obligations**, **98 acceptance criteria** and **10 invariants**.

---

## 2. Governing precedence — the conflict is already resolved *in effect*

⭐ **`DOCUMENTATION_BASELINE.md` §4 ranks Rank 2 Accepted ADRs above Rank 3 module PRDs.**

```
Rank 1  MASTER_PRD
Rank 2  Accepted ADRs        <-- ADR-0130 sits here
Rank 3  Module PRDs          <-- PRD-008 v1.7 sits here
Rank 4  BC Map + Dependency Matrix
Rank 5  Architecture Rulings
Rank 6  Enterprise Architecture (DESCRIPTIVE ONLY)
```

⭐⭐ **Therefore `ADR-0130` governs today, with no edit to any document.** The five rows are
**superseded in effect for the V1 payment-method scope**. `ADR-0130` §7 states this in terms, and this act
⛔ **does not re-decide it** — re-deciding a settled Rank 2 question would be the `ADR-0045` error.

⚠⚠ **BUT PRECEDENCE ALONE IS NOT DISCOVERABILITY, AND THAT IS THE WHOLE OF B-4'S REMAINING RISK.**
Precedence tells a reader **who wins** *once the reader knows both documents exist*. It does **nothing** for a reader
who opens `PRD-008` §6.1, sees `| UPI payment | … | V1 |` in a **FROZEN, baseline-authoritative** document, and never
learns `ADR-0130` exists. ⭐ **That is the failure mode B-4 must close, and it is a disclosure failure, not a
precedence failure.**

---

## 3. The successor / amendment decision

### 3.1 ⭐⭐ The instrument: a `PRD-008` **v1.8 successor amendment**, not a rewrite, not a re-baseline

⭐ **DETERMINED: the lawful instrument is an amendment to `PRD-008` producing v1.8**, executed through
`PRD_LIFECYCLE.md` **§4**'s frozen-PRD route, whose seven steps are quoted and adopted:

| Step | §4's requirement | Applied to `PRD-008` |
|---|---|---|
| 1 | *"Write an ADR — **BEFORE** the change"* | ⚠ **A FUTURE ADR, not this one** — see §3.3 |
| 2 | *"Accept the ADR"* | future |
| 3 | *"Increment the PRD version"* | **v1.7 → v1.8** |
| 4 | *"Update the PRD changelog — same commit"* | future |
| 5 | *"Update `DOCUMENTATION_BASELINE.md` — same commit"* | future (§3 row + identifier) |
| 6 | *"Update `TRACEABILITY_MATRIX.md` if identifiers changed"* | ⭐ **expected NOT to trigger** — see §3.2 |
| 7 | *"Update `PRD_REGISTRY.md`"* | future |

⭐ **§4's own gate question — *"Is it a business-rule change, new requirement, or ownership change?"* — answers
**YES** for this correction** (a release-scope change to five in-scope rows is a business-rule change), so the
seven-step ADR route applies and the *"changelog entry, version unchanged"* shortcut is ⛔ **not available.**

### 3.2 ⛔ Three instruments were tested and REJECTED, each on a measured ground

| Candidate | Verdict | Measured reason |
|---|---|---|
| **(a) Edit §6.1's five rows now, in this act** | ⛔ **REFUSED** | `PRD_LIFECYCLE` **L177**: *"**A frozen PRD is never silently modified.** Not for an obvious correction, and not for one that is certainly right."* ⭐ The rule anticipates **exactly** this temptation and forecloses it. **L178** cites `PGA-01`/`PGA-02` — two **confirmed** defects left standing in frozen PRDs rather than quietly fixed |
| **(b) A `PRD-008` v2 full re-baseline** | ⛔ **REJECTED as disproportionate** | The correction touches **5 of 249** catalogued items. A re-baseline would re-open **134 obligations**, **98 acceptance criteria**, **10 invariants** and **17 open `FEE-GAP-*`**, re-run Stages 3–7, and re-expose the **83 `IMPL-700`…`IMPL-799`** traces — ⭐ risk vastly exceeding the defect. `ADR-0011`, §4's own worked example, amended **in place at v1.6 → v1.7** rather than re-baselining |
| **(c) Supersede `PRD-008` with a new PRD identity** | ⛔ **REJECTED** | `PRD_LIFECYCLE` **L67**: *"Does another PRD already own the context? **It is an amendment to that PRD, not a new one.**"* `PRD-008` owns **`BC-05`** and the `FeeLedger` aggregate (BC Map **L374**); a second `BC-05` PRD would create two Rank 3 claimants on one context |

⭐⭐ **(a) is the one that had to be refused explicitly, because it is the intuitive act and it is unlawful.** The
brief itself instructs *"DO NOT directly rewrite its frozen requirements"* — and the repository's own lifecycle rule
says the same thing independently. ⭐ **Two authorities agreeing is why this is a determination and not a preference.**

### 3.3 ⚠⚠ WHY THIS ADR IS **NOT** §4 STEP 1, AND DOES **NOT** EXECUTE THE SUCCESSOR

⛔ **This ADR is NOT the "ADR before the change" that §4 step 1 requires, and it must not be mistaken for it.**

⭐ **The distinction is substantive, not formal.** §4 step 1's ADR must decide **what the amended text says** — which
rows change, to what release value, with what effect on `FEE-FR-028`, `FEE-AC-085`…`089`, and on the **V1 reading of
payment verification where the only V1 method is cash**. ⚠ **Those are drafting decisions inside a frozen Rank 3
requirement set, and they require the `BC-05` Domain Owner** (`PRD_OWNERSHIP_MODEL` **L84**: *"Correctness of the PRD
**within its bounded contexts**; ubiquitous language; invariants"*) — an office ⛔ **not conferred for this act**.

⭐⭐ **So this act determines the ROUTE and stops.** Determining that the lawful instrument is a v1.8 §4 amendment is a
**Governance Owner** act about process. Deciding the **content** of that amendment is a **Domain Owner + Product
Owner** act about requirements. ⛔ **Conflating them would be precisely the over-reach `ADR-0045` §2.1 forbids**, and
would let a governance act silently redraft a frozen requirement.

⚠ **This is also why no `PRD-008` v1.8 exists after this commit.** Its absence is ⭐ **the correct outcome**, not
incomplete work.

### 3.4 ⭐ The successor's mandate, fixed here so it cannot drift

⚠⚠ When the future §4 act is authorised, it is **bound** by the following — recorded now because an unbounded
successor mandate is how *"correct the V1 scope"* becomes *"design V2 payments":*

| # | The successor **MUST** | The successor **MUST NOT** |
|---|---|---|
| **S-1** | Re-scope **only** L209, L210, L211, L213, L214 | ⛔ Touch **L208 `Cash payment`**, which is **correct at V1** |
| **S-2** | Carry the prior text **verbatim** as superseded history (`ADR-INDEX` **L207**: *"An ADR supersedes; it does not delete"*) | ⛔ Delete or silently overwrite the prior rows |
| **S-3** | Cite `ADR-0130` as the governing authority | ⛔ Re-decide, reopen, weaken or re-interpret `ADR-0130` |
| **S-4** | Leave all **17** `FEE-GAP-*` exactly as they stand | ⛔ Close, merge, renumber or re-scope any gap |
| **S-5** | Preserve **`MP-GBR-24`** — `BC-05` and `BC-20` share no model, table or metric | ⛔ Introduce a settlement or platform-charge concept into `BC-05` |
| **S-6** | State that V1 payment verification operates **with cash as the only V1 method** | ⛔ **Invent** a V1 digital verification, gateway, webhook or reconciliation mechanism |
| **S-7** | Keep `FEE-FR-028`'s obligation **intact as a V2-scoped obligation** if it is re-scoped at all | ⛔ **Delete an obligation** to resolve a scope conflict — that would reduce the obligation count to win an argument |
| **S-8** | Move version, changelog, baseline and registry **in one commit** (§7 rules 2–3) | ⛔ Split them across commits |

⭐ **`S-6` and `S-7` are the load-bearing ones.** The temptation in a scope correction is to *delete* the inconvenient
obligation, or to *replace* it with a V2 design sketch. ⛔ **Both are forbidden: `ADR-0130`'s Outcome row states
"No settlement mechanism is invented"**, and this act adds nothing to that and takes nothing from it.

---

## 4. ⛔⛔ `PRD-008` IS BYTE-UNCHANGED, AND THE STALE SELF-STATUS IS AGAIN NOT REPAIRED

⛔ **`PRD-008_REVENUE-AND-FINANCE.md` is not edited by this act — not one byte**, verified by blob hash before and
after the write.

⚠ **Its L10/L11 self-description still reads *"v1.7 — DRAFT … still NOT frozen. NOT approved. NOT
architecture-reviewed."*** — while the registry **L245**, the baseline **L175** and `ADR-0049` all record **FROZEN**.
⛔ **This is NOT repaired here**, on the document's **own L11 rule**: *"Status is **conferred** by admission to the
baseline, **never claimed by a document about itself**."* ⭐ **A self-claim that is wrong is harmless precisely
because self-claims carry no authority** — and editing it would breach **L177** for a cosmetic gain. `ADR-0130` §7
reached the identical conclusion; ⭐ **this act is consistent with it rather than re-litigating it.**

---

## 5. ⭐⭐ What this act DOES change — the disclosure gap, measured

⚠⚠ **The Technical-Specification-level protection ALREADY EXISTS, and this act deliberately does NOT duplicate it.**
`ADR-0131` **§9** and `PRD_LIFECYCLE` **§7A.9** (**L403**) already bind **every** future Technical Specification with
the PAYMENT clause, and already **name this exact trap including all five line numbers**:

> *"⚠ **Named trap:** `PRD-008` **FROZEN v1.7 §6.1 L209/L210/L211/L213/L214 still say V1** and are **superseded IN
> EFFECT by rank** — authors apply `ADR-0130`, ⛔ **not** `PRD-008` §6.1"*

⭐ **So the brief's objective — "future Technical Specifications cannot accidentally treat UPI/card/online/webhook/
payment gateway as V1" — is already met for Technical Specifications.** ⛔ **Re-legislating it would be duplicate
governance**, and duplicate governance drifts.

### 5.1 ⚠ The gap that is **not** covered, measured

| # | Entry point | Measured state | Why it matters |
|---|---|---|---|
| **G1** | `DOCUMENTATION_BASELINE.md` **L175** — the Rank-authoritative `PRD-008` row | ⛔ **`grep` for `ADR-0130`, `cash only`, `UPI`, `V2` returns ZERO hits on that line.** It reads *"**Authoritative** — the Revenue & Finance baseline"* with **no divergence warning** | ⭐ §3 **is** the definition of what is authoritative. A reader who trusts it is led **straight into the superseded rows** |
| **G2** | `PRD_REGISTRY.md` | ⛔ **`ADR-0130` occurs ZERO times in the entire 1,777-line file.** The `PRD-008` row **L245** says `FROZEN` and is **silent on payment** | ⭐ The registry is the **index of record** for PRD status |

⭐⭐ **These two are precisely the documents a specification author is told to consult**, and they are the two that
carry no warning. ⛔ **`ADR-0131`'s clause protects the specification; nothing protected the register.**

### 5.2 ⚠ Three further propagation residues — DISCLOSED, ROUTED, and **NOT repaired here**

| # | Artifact | Measured | Owner | Why not here |
|---|---|---|---|---|
| **G3** | `PRD-019_INTEGRATION.md` | **39** `Razorpay` occurrences, ⛔ **0** `ADR-0130` references; §4's webhook contract is predicated on a **V1** gateway | Product + Architecture + `BC-31` Owner | `ADR-0130` §10 **item 8**. `PRD-019` is a **Rank 3 `DRAFT`** with its own `ADR-0047`/`ADR-0048` acceptance criteria — amending it is its own act |
| **G4** | `LIBOORA_ENTERPRISE_ARCHITECTURE.md` **L1395**, **L1397**, **L1398** | still read *Online / UPI / Card Payments (**V1**)*; ⛔ **0** `ADR-0130` references | Architecture Owner | `ADR-0130` §10 **item 9**. ⭐ **Rank 6, DESCRIPTIVE ONLY** — it **loses to `ADR-0130` by rank automatically**, so the risk is lowest of the five |
| **G5** | `LIBOORA_BOUNDED_CONTEXT_MAP.md` **L202** | *"BC-05: cash/UPI collected from a student at reception"* | Architecture Owner | `ADR-0130` §10 **item 10**, which already determines the **boundary is correct and unaffected — only the UPI example is now V2.** ⛔ A wording review, **not a defect** |

⛔ **All three remain OPEN and are not closed, repaired or re-owned by this act.** ⭐ **Naming them is the value;
fixing them would exceed a conferral scoped to the `PRD-008` conflict.**

---

## 6. Files amended, and the citation discipline

| File | Rank | Change | Authority |
|---|---|---|---|
| `DOCUMENTATION_BASELINE.md` | — | **L175 amended STRICTLY IN PLACE** to carry the divergence + governing authority + successor path; §1 Authority gains `ADR-0134`; §8 changelog row | §7 rule 3 — *"This declaration is updated in the same commit. A baseline that does not match the repository is worse than no baseline"* |
| `PRD_REGISTRY.md` | — | ⭐ **New §20 APPENDED at end of file** recording the `PRD-008` payment divergence, the determined successor path and `S-1`…`S-8` | `PRD_LIFECYCLE` §4 step 7 |
| `ADR-INDEX.md` | — | `ADR-0134` registered in the end-of-file addendum; `Count` cell corrected in place | `ADR-INDEX` Process rule 1 |

### 6.1 ⭐ Citation cost, measured **before** the write

| Target | Measurement | Treatment |
|---|---|---|
| `DOCUMENTATION_BASELINE.md` **L175** | ⚠⚠ **Line-cited by `Accepted` `ADR-0130` L186** — *"`DOCUMENTATION_BASELINE.md` **L175** records \"Authoritative — the Revenue & Finance baseline\""* — ⛔ **an Accepted ADR this act may not edit** (`ADR-INDEX` **L206**) | ⭐⭐ **Amended STRICTLY IN PLACE — a table cell, so it adds no line and shifts nothing; `ADR-0130` L186's citation still resolves to the same row, and the quoted phrase *"Authoritative — the Revenue & Finance baseline"* is RETAINED VERBATIM so the citation remains true word-for-word** |

⚠ **A drafting error in this ADR was caught before commit and is recorded rather than silently fixed:** an earlier
draft of the row above attributed L175's citation to `PRD-015_STAGE3_CLOSURE_ASSESSMENT.md` **L56**. ⛔ **That was
wrong** — L56 cites **`PRD_REGISTRY.md` L175**, a different file. The true citer is **`ADR-0130` L186**, which raised
the stakes: the cited text sits inside an **Accepted ADR's** evidence, so the amendment had to **preserve the quoted
phrase verbatim**, not merely stay on the same line.
| `DOCUMENTATION_BASELINE.md` §8 changelog | Highest live inbound citation **L383**; the changelog table's first row sits at **L391** | ⭐ Row inserted **newest-first at L391 — below every cited line** |
| `PRD_REGISTRY.md` | Highest live inbound citation **L1718**; file ends at **L1777** | ⭐ **§20 appended at END OF FILE — ZERO of the file's citations shifted** |
| `ADR-INDEX.md` | Highest live inbound citation **L890**; `Count` at **L9** | ⭐ **L9 in place; entry appended below L890** |

⭐ Per the `ADR-0079` §8.5 **append-not-insert** doctrine, reaffirmed by `ADR-0133` §8.4's corrected measurement.

### 6.2 ⚠ Baseline identifier — §7 rule 4's limb is **UNMET**

⭐ §7 rule 4: *"The baseline identifier changes only when a **Rank 1–3** document changes version."*

⚠⚠ **No Rank 1–3 document changes version in this act.** `PRD-008` is ⛔ **byte-unchanged at v1.7**; `MASTER_PRD`
stays **v1.10**; the BC Map stays **v1.15**. The amended files are the **unranked** declaration, registry and index.
⭐ **Therefore `BASELINE-2026-09-10-C` STANDS** — the precedent `ADR-0128`, `ADR-0131` and `ADR-0132` each set.

⭐⭐ **This is itself evidence the act is correctly scoped:** a determination about a **route** should not move the
baseline. ⚠ The **future** v1.8 successor **will** move it, because `PRD-008` is **Rank 3**.

---

## 7. ⛔ What this ADR does NOT do

- ⛔⛔ **Does NOT rewrite, edit, or reinterpret any frozen `PRD-008` requirement.** **0 bytes**; **0** of the 134
  obligations, 98 acceptance criteria, 10 invariants or 17 `FEE-GAP-*` altered
- ⛔⛔ **Does NOT execute the successor.** No `PRD-008` v1.8 exists; §4 step 1's ADR is ⛔ **not written here**
- ⛔⛔ **Introduces NO V1 digital payment mechanism.** V1 remains **cash only**; ⛔ no UPI, card, online, gateway,
  webhook or digital verification is admitted to V1 by this act
- ⛔⛔ **Invents NO V2 mechanism.** ⛔ No platform-charge model, no settlement instrument, no reconciliation design,
  ⛔ **no V2 gateway provider selected** (`Q-B31` stays OPEN)
- ⛔ **Amends, reopens or weakens NO ADR** — `ADR-0130`, `ADR-0131`, `ADR-0132`, `ADR-0133` are **byte-unchanged**
- ⛔ **Creates NO Technical Specification**, ⛔ **allocates NO `TS-001`**, ⛔ **creates no `docs/50-technical/` content**
- ⛔ **No API, endpoint, OpenAPI or wire contract; no database schema, migration or SQL; no code, test or tool file**
- ⛔ **Touches no permission identifier** — `AUTH-7.22` stays closed at **0** (`ADR-0132`)
- ⛔ **Does NOT resolve `Q-04`** — `B-3`'s residue stays **OPEN pending Legal counsel**, and the **V1 schema freeze
  remains BLOCKED**. ⛔ **Does NOT resolve `B-5` or `B-6`**
- ⛔ **Closes NO implementation blocker**; ⛔ mints or closes **no** `IMPL-*` or `FEE-GAP-*`
- ⛔ **Confers no lifecycle stage** and authorises no implementation. ⛔ **NOT pushed**

---

## 8. Consequences

⭐ **`B-4` is DISPOSED — by determination and disclosure, ⛔ not by repair.** The route is fixed, its mandate is
bounded by `S-1`…`S-8`, and the divergence is now visible at the baseline and the registry as well as in the
Technical Specification clause.

⚠⚠ **What `B-4` does NOT become:** ⛔ **it does not become "closed by correction".** `PRD-008` §6.1 still reads `V1`
on five rows, and will until a `BC-05` Domain Owner executes the v1.8 amendment. ⭐ **An honest disposition names the
remaining divergence instead of implying the text is fixed.**

| Blocker | Status after this act |
|---|---|
| **B-1** Technical Specification governance | ✅ **RESOLVED** — `ADR-0131` |
| **B-2** `AUTH-7.22` permission catalogue | ✅ **AUDITED AND DISPOSED** — `ADR-0132`, **0** permissions |
| **B-3** `MP-DEP-07` schema-freeze questions | ⚠ **PARTIALLY RESOLVED** — `ADR-0133`: `Q-01`/`Q-03`/`Q-06` resolved, ⛔ **`Q-04` OPEN pending Legal counsel; schema freeze BLOCKED** |
| **B-4** `PRD-008` payment divergence | ⭐ **DISPOSED — successor path DETERMINED, frozen text PRESERVED, divergence DISCLOSED.** ⚠ Text repair **outstanding** as a separate `BC-05` Domain Owner act |
| **B-5** API style / error taxonomy / versioning / idempotency transport | ⛔ **OPEN — untouched** |
| **B-6** `DEVELOPER_HANDOFF.md` + 6 implementation documents stale on authentication | ⛔ **OPEN — untouched** |

⛔ **The Technical Specification phase remains NOT ENTERABLE.**

---

## 9. Changelog

| Version | Date | Change |
|---|---|---|
| **1.0** | 2026-09-10 | ⭐⭐ **Created and `Accepted`. The `PRD-008` §6.1 payment divergence is AUDITED; the successor path is DETERMINED and the frozen text is PRESERVED.** ⭐ The conflict is re-verified line by line against the live file — **L209** UPI, **L210** card, **L211** online, **L213** verification, **L214** webhook, all `V1`, contradicting `ADR-0130` §1.1 — while ⭐ **L208 `Cash payment` is CORRECT at V1 and expressly protected** by **`S-1`**. ⭐⭐ **Precedence already resolves it without an edit** (`DOCUMENTATION_BASELINE` §4: Rank 2 Accepted ADR **>** Rank 3 module PRD), so ⛔ **`ADR-0130` is NOT re-decided**. ⚠⚠ **But precedence is not discoverability — and that is the whole of B-4's residual risk.** ⭐⭐ **DETERMINED: the lawful instrument is a `PRD-008` v1.8 successor amendment under `PRD_LIFECYCLE` §4's seven-step frozen-PRD route**, bounded by **`S-1`…`S-8`**. ⛔⛔ **THREE ALTERNATIVES WERE TESTED AND REJECTED ON MEASURED GROUNDS:** **(a)** editing the five rows now — ⛔ **refused on L177**, *"A frozen PRD is never silently modified. Not for an obvious correction, and not for one that is certainly right"*, the rule that anticipates this exact temptation, with **L178**'s `PGA-01`/`PGA-02` showing two **confirmed** defects deliberately left standing; **(b)** a v2 re-baseline — ⛔ disproportionate, **5 of 249** items against re-opening **134 obligations / 98 AC / 10 invariants / 17 open gaps / 83 `IMPL-*` traces**; **(c)** a new PRD identity — ⛔ barred by **L67**, *"It is an amendment to that PRD, not a new one"*, since `PRD-008` owns `BC-05`. ⭐⭐⭐ **THIS ADR IS DELIBERATELY *NOT* §4 STEP 1'S ADR, AND SAYS SO:** deciding **what the amended text says** requires the **`BC-05` Domain Owner** (`PRD_OWNERSHIP_MODEL` **L84**), an office ⛔ **not conferred here** — so the act determines the **route** and **stops**, and ⚠ **the absence of a v1.8 is the correct outcome, not incomplete work**. ⭐⭐ **THE TS-LEVEL PROTECTION ALREADY EXISTED AND IS DELIBERATELY NOT DUPLICATED:** `ADR-0131` §9 / `PRD_LIFECYCLE` **L403** §7A.9 already bind every Technical Specification and already **name this trap with all five line numbers** — ⛔ re-legislating it would be duplicate governance. ⭐⭐ **THE REAL, MEASURED GAP WAS ELSEWHERE, AND IS WHAT THIS ACT CLOSES:** **G1** `DOCUMENTATION_BASELINE` **L175**, the Rank-authoritative `PRD-008` row, contained **ZERO** mentions of `ADR-0130`/cash-only/UPI/V2 and read simply *"Authoritative"*; **G2** `PRD_REGISTRY.md` contained **ZERO** `ADR-0130` references in **1,777** lines. ⭐ **Those are exactly the two entry points a specification author consults**, and neither carried a warning. ⚠ **THREE FURTHER RESIDUES DISCLOSED AND ROUTED, NOT REPAIRED:** **G3** `PRD-019` (**39** Razorpay refs, **0** `ADR-0130`), **G4** EA **L1395**/**L1397**/**L1398** still *(V1)* — ⭐ lowest risk, **Rank 6 descriptive** and losing by rank automatically — and **G5** BC Map **L202**'s UPI example, ⭐ whose **boundary is correct and unaffected**. ⛔⛔ **`PRD-008` IS BYTE-UNCHANGED — verified by blob hash before and after** — and its stale *"v1.7 — DRAFT … NOT frozen"* self-claim is ⛔ **again NOT repaired**, on its **own L11** rule that status is *"**conferred** … never claimed by a document about itself"*. ⛔ **NO V1 DIGITAL PAYMENT MECHANISM INTRODUCED** and ⛔⛔ **NO V2 MECHANISM INVENTED** — no platform-charge model, no settlement instrument, no reconciliation design, no provider (`Q-B31` stays OPEN). ⛔ `ADR-0130`/`0131`/`0132`/`0133` **byte-unchanged**; ⛔ **0** Technical Specifications, `TS-001` **not allocated**; ⛔ **0** API/OpenAPI/schema/migration/SQL; ⛔ **0** code, test or tool files; ⛔ **0** permission identifiers; ⛔ **0** blockers closed; ⛔ **`Q-04`, `B-5`, `B-6` all untouched and OPEN**. §7 rule 1 satisfied (this ADR precedes its own amendments); ⭐ **rule 4's limb UNMET — no Rank 1–3 version changes — so `BASELINE-2026-09-10-C` STANDS**, itself evidence the act is correctly scoped. ⛔ **NOT pushed.** |
