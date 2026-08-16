# ADR-0047 — `PRD-019` §4 authored: the V1 payment webhook contract, and `Q-B31` CLOSED

| Field | Value |
|---|---|
| **ADR** | `ADR-0047` |
| **Title** | `PRD-019` §4 authored — the V1 payment webhook contract, and `Q-B31` CLOSED |
| **Date** | 2026-08-15 |
| **Status** | **`ACCEPTED`** — the authoring act is a **Rank 3 document act by the `BC-31` owner**, which `ACCEPTED` `ADR-0040` **§4 L165** already assigns; the **Architecture Owner** conferral recorded in `ADR-0046` supplied the provider prerequisite. Same disclosure as `ADR-0032` §5.2, `ADR-0035`, `ADR-0043` and `ADR-0046`: **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *a conferral for one act is not a standing licence* (`ADR-0033` §7.1) |
| **Supersedes** | **Nothing** |
| **Amends** | **Nothing.** `PRD-019` moves **v0.1 → v0.2** by its own owner's act, which is a version movement of a **`DRAFT` never admitted to the baseline** — see §2 |
| **Does NOT amend** | **`MASTER_PRD.md`** (Rank 1) · **the EA** (Rank 6) · **BC Map** (Rank 4) · **Dependency Matrix** (Rank 4) · **`AR-1/3/4`** (Rank 5) · **any frozen PRD** · **any `ACCEPTED` ADR** · **`PRD-008`** · **`PRD-022`** · **`tool/module_dependencies.yaml`** · **any gate under `tool/`** |
| **Affects** | `PRD-019` (v0.1 → v0.2) · `Q-B31` (**OPEN → CLOSED**) · `TRACEABILITY_MATRIX.md` (`ITG-*` registration) · `ADR-INDEX.md` (registration) |
| **Outcome** | ✅ **`Q-B31` CLOSED.** The V1 webhook contract exists in **`PRD-019` §4 only**. ⛔ **`PRD-008` byte-unchanged and NOT frozen.** ⛔ **`PRD-019` Stage 3/4 still not performed**; `ITG-AC-*` empty |

---

## §1 The decision

**`PRD-019` §4 now contains the minimum V1 payment-webhook contract, and `Q-B31` is closed.**

Six element groups are specified — route/transport, payload schema, signature verification, replay protection and
idempotency, retry/failure handling, and the required event set — as **56 `ITG-*` identifiers** with five contiguous
published ranges. **Nothing else was specified, and nothing was specified anywhere else.**

---

## §2 The authority test — performed before writing, not justified after

Three distinct questions had to be answered affirmatively. Each is measured.

### 2.1 May the `BC-31` owner author these elements at all?

| Measurement | Result |
|---|---|
| `ACCEPTED` `ADR-0040` **§4 L165** | Enumerates the five wire elements and assigns them to *"the **`BC-31` owner**, once `PRD-019` exists"* |
| Does `PRD-019` exist? | ✅ Yes — created by `ACCEPTED` `ADR-0043`, registered `DRAFT` at `PRD_REGISTRY.md` **L309** |
| Does `PRD-019` claim the ownership? | ✅ Yes — its **§2** assigns all five to `BC-31`, *"recognising"* BC Map **L140**, `PRD_REGISTRY.md` L309, `SAAS-XC-006` and Matrix `X-03` |
| Where must it be written? | **`PRD-019` §4 and nowhere else** — `ADR-0045` §5.2, and `ADR-0040` **L166**'s second-source-of-truth bar |

### 2.2 Does `ADR-0035` §5.5b still forbid it? — **No, and this is the load-bearing reading**

`ADR-0035` §5.5b (**L596–L616**) lists *"No endpoint, URL, path or route"*, *"No webhook payload schema…"*, *"No
signature algorithm, header name, secret-rotation or replay-window value"* and *"No retry policy, timeout, or
dead-letter behaviour"*. Read as free-standing sentences these forbid precisely what §4 now does. **They are not
free-standing**, and the same reading `ADR-0046` §3 established governs here:

| Measurement | Result |
|---|---|
| The heading that governs the table | **"What `D-4` does NOT do — the boundary of the conferral, stated as constraints on future authors"** |
| The reason column on the provider row | *"None appears in **this ADR**"* — a statement about ADR-0035's own content |
| The reason column on the retry row | *"**Not conferred**"* — i.e. not conferred **by that ADR** |
| `ADR-0035` **L776–L779** | *"It is **not** a standing grant… Any further decision on the payment surface… **requires its own conferral.**"* |

So §5.5b **withheld** these values from its own conferral and specified the mechanism for supplying them later: a
further conferral. Reading it as a permanent bar would make **L776–L779 meaningless**, since nothing could ever be
conferred. `ADR-0035` is therefore **honoured, not overridden**, and is **byte-unchanged** (`6b10eddf3367f5f1`).

> ⚠ **The one place this ADR departs from an earlier reading of mine, stated plainly rather than left for a reader
> to notice.** `ADR-0044` **§3.5** framed act two as requiring *"the **`BC-31` owner**, with **Architecture Owner**
> to lift §5.5b's prohibitions"*. The later `ACCEPTED` `ADR-0045` **§5.2** named the owner as the **`BC-31` owner**
> and the missing inputs as *"(a) the provider from 5.1; (b) that provider's own published webhook documentation"* —
> **no separate prohibition-lift**. `ADR-0045` is the later and more precise statement, `ADR-0046` §3 supplied the
> reasoning for why no lift is needed (the prohibitions bound ADR-0035's own grant), and the provider decision was
> made by the Architecture Owner in any event. **`ADR-0044`'s wording is not withdrawn and remains on the record as
> the more cautious reading.**

### 2.3 Does authoring a Rank 3 document require an ADR *before* the change?

`DOCUMENTATION_BASELINE.md` **§7 step 1** requires an ADR before a **Rank 1–5** change. The precedent that resolves
this is `ADR-0043`'s own *Amends* row: a `DRAFT` PRD *"never admitted to the baseline"* is **Rank 3-registered, not
Rank 3-holding**. `PRD-019`'s header states it directly — *"Written **against** `BASELINE-2026-08-05-A`. **Not
admitted to it**"* and *"Precedence rank if admitted | Rank 3 — **not held today**"*.

So §7 step 1 is **not** triggered. **This ADR was nonetheless written, because that is the established practice**,
and §7 steps 2 and 3 *are* satisfied: the version bump and changelog are in the **same commit**, and this
declaration is in that commit too. **§7 step 4 is deliberately NOT performed** — the baseline identifier moves only
*"when a Rank 1–3 document changes version"*, and `PRD-019` holds no rank.

---

## §3 The provider values — verified, and labelled by origin

The instruction required Razorpay's official documentation as the authoritative source and forbade inventing any
provider-specific value. **§4.9 of `PRD-019` carries 26 citation rows**; this section records the *method*.

| Discipline applied | Why it mattered |
|---|---|
| **Primary sources only.** Razorpay's own published pages were read: About Webhooks, Validate & Test, Best Practices, Webhooks FAQs, Payments Payloads, Payment Capture Settings | An initial search surfaced third-party retry claims (webhook-tooling vendors) and a partner-OAuth page. **All were discarded** — a secondary source restating a retry policy is not the provider's policy |
| **Event names read from the rendered tables, not inferred from prose** | The payload pages' event tables are JS-driven and render **empty** to a plain fetch. They were re-fetched with rendering enabled. **Inferring `payment.captured` from surrounding prose would have been a guess that happened to be right, which is still a guess** |
| **Every value labelled `[RZP]` or `[LIB]`** | See §3.1 |

### 3.1 ⚠ The distinction that prevents a false citation

**Razorpay publishes no route path.** It requires a *merchant-configured* URL meeting published constraints
(public, ports 80/443 only, TLS 1.2+, not on the blacklisted-domain list, webhook IPs reachable). Therefore:

| Value | Label | Reason |
|---|---|---|
| Route path `POST /webhooks/payments/gateway` | **`[LIB]`** | A **LIBOORA** value *constrained by* the provider. Labelling it `[RZP]` would be **a false citation dressed as compliance** |
| Constant-time signature comparison | **`[LIB]`** | A general security obligation; the provider publishes no comparison rule |
| 30-day dedup retention | **`[LIB]`, derived** | The smallest value exceeding **both** published windows — 24-hour retry and 15-day support replay. **The derivation is shown in `PRD-019` `ITG-FR-017` so it can be checked, not trusted** |
| Port 443 only | **`[LIB]`, narrowing** | The provider permits 80 or 443; V1 takes 443 only. A **narrowing** of a provider allow-list cannot conflict with it |
| Everything else in §4.1–§4.6 | **`[RZP]`** | Transcribed from the cited page |

### 3.2 ⚠ The element answered in a different shape than its name implies

`ADR-0040` §4 L165 names *"replay window"*. **Razorpay sends no signed timestamp**, so there is no timestamp to
bound. Its documented replay defence is **`x-razorpay-event-id` dedup**, which `PRD-019` §4.4 implements.

**The element is answered; the shape is different; and the difference is disclosed in the PRD itself** rather than
papered over with a plausible-looking tolerance value. Inventing a signed-timestamp window *"would have looked more
complete and been false"*.

---

## §4 Boundaries preserved — measured, not asserted

| Boundary | Authority | Still in force |
|---|---|---|
| **`BC-05` is the financial source of truth** | §3 of `PRD-019`; BC Map L374; `MP-GBR-24` | ✅ **Yes.** §4 asserts **no** financial rule. `FEE-BR-014`, `FEE-BR-016`, `FEE-FR-028`, `FEE-INV-005`, `FEE-FR-032`, `FEE-AC-085`…`089` are **cited, never copied** |
| **A webhook is evidence, never an instruction** | `PRD-008` `FEE-BR-014` | ✅ **Yes** — `ITG-BR-010` permits the adapter only to *hand verified evidence to `BC-05`*; `ITG-BR-011` bars the wire layer from deciding capture |
| **Verification before recording** | `FEE-FR-028`; `ADR-0035` §5.5b | ✅ **Yes** — `ITG-BR-006` and `ITG-INV-002` state the **transport half**, deliberately narrower than the financial half, which stays `PRD-008`'s |
| **Payment-side duplicate protection is `BC-05`'s** | `FEE-BR-016` | ✅ **Yes** — `ITG-BR-008` states transport dedup is *"not a substitute"*: **two layers, two owners, deliberately not merged** |
| **Tenant isolation** | `ITG-FR-018`, `ITG-INV-004` | ✅ **Yes** — dedup, evidence and audit records are tenant-partitioned; an unresolvable tenant is rejected, never defaulted |
| **Vendor name stays out of code, events, tables, API contracts** | `FEE-XC-006`; Matrix **L167** | ✅ **Yes** — `ITG-XC-001`; the route path is provider-neutral by construction |
| **The gateway credential stays out of `BC-05`** | `FEE-XC-005` | ✅ **Yes** — `ITG-BR-007` |
| **The forbidden direct-call edge stays forbidden** | Matrix **L352** row `X-03` | ✅ **Yes** — `ITG-BR-010` routes through the **existing** `business.payment_intent` port |
| **Inbound ingress is a `platform/business` capability** | `ADR-0035` §5.5b; `ADR-0040` §1 | ✅ **Yes** — `PRD-019` §2.1 unchanged; **owning the contract is not owning the ingress** |
| **`BC-31` stays outbound in scope** | BC Map **L140** | ✅ **Yes** — L140 is unextended; §4 is the inbound *wire contract* `ADR-0040` assigned, not a scope change |
| **Context count** | `AR-1` | ✅ **31 (23 in V1)** |
| **Provider sits behind the abstraction** | EA L1404; `MASTER_PRD.md` §10 preamble | ✅ **Yes** |

---

## §5 What this ADR and this pass deliberately did NOT do

1. **Did not duplicate the contract in `PRD-008`** (rule 1). `PRD-008` is **byte-unchanged** —
   `d24832f33e600518` before and after.
2. **Did not freeze `PRD-008`** (rule 10). `DOCUMENTATION_BASELINE.md` §3 contains **0** rows naming a `PRD-008`
   file; it stays **v1.7 `DRAFT`**.
3. **Did not author the contract in this ADR.** `ADR-0040` **L166** and `ADR-0039` §7.2 bar an ADR from holding a
   PRD's content. This ADR records **why** and **under what authority**; the contract lives only in `PRD-019` §4.
4. **Created no** bounded context (**31**), `E-*` edge, port, permission, configuration identifier, provider, API
   architecture or duplicated financial rule (rule 7).
5. **Allocated no numbered `IMPL-nnn` identifier and created no task document.** Stage 6 **not**
   performed. ⚠ Stated as an **allocation** count, not a token count: this ADR and `PRD-019` both
   *mention* the wildcard `IMPL-*` in sentences denying an allocation, so a `grep` for the bare
   string is non-zero in both. **The looser wording *"allocated no `IMPL-*` range"* was in this
   ADR's own first draft and is corrected here by measurement** — the `GCP-01`
   self-falsifying-statement class this repository tracks, caught in the same pass that caught it
   in `PRD-019` §6.
6. **Did not amend `MASTER_PRD.md` L232**, the EA, the BC Map, the Dependency Matrix or any `ACCEPTED` ADR.
7. **Did not transcribe `FEE-GAP-010`'s Status.** That remains a `PRD-008` document-owner act (`ADR-0046` §6.2).
8. **Weakened no checker.** No file under `tool/` is modified.
9. **Claimed no lifecycle stage that was not met.** Only **Stage 2** moves (PARTIAL → PASSED), and only because its
   exact stated deficiency — unpublished ranges — was removed.
10. **Did not re-issue the baseline identifier** — §7 step 4; `PRD-019` holds no rank.
11. **Touched no Dart source.**

---

## §6 The honest shortfalls

Recorded here as well as in `PRD-019`, because an ADR that reports only success is not a record.

| # | Shortfall |
|---|---|
| 1 | **`ITG-AC-*` is EMPTY — coverage `0/54`.** No obligation in §4 is *verified* in the sense `PRD-008` §0.2 requires (*"prose never counts"*). Successor item **`Q-B31-AC`** is opened in `PRD-019` §7 |
| 2 | **Stage 3 was not performed and Stage 4 was not run.** `Q-B31`'s Stage 4 blocker **changed identity** — from *"no requirement to test"* to *"no criterion to test with"* |
| 3 | **`ITG-GAP-001`** — V1 has **no** dead-letter queue, replay console or platform-side re-delivery. After the provider's 24-hour retry the webhook is **disabled**; recovery falls to a ≤15-day support replay or `FEE-FR-032` reconciliation. **A thin failure path, stated as thin** |
| 4 | **`ITG-GAP-002`** — the contract **depends on** the provider's Payment Capture setting, which it does not control; uncaptured authorised payments are auto-refunded by the provider |
| 5 | **Stage 5 is NOT claimed.** `ITG-*` is registered in `TRACEABILITY_MATRIX.md` so 56 identifiers are not left registered nowhere, but the stage also needs the coverage `ITG-AC-*` cannot yet supply |
| 6 | **Three defects in this pass's own first draft** were caught by its own counting script and repaired: a claimed *"52 identifiers"* against a measured **56**; `ITG-GAP-001`/`002` referenced while **undefined**; `ITG-XC-004` emitted as a **stray table row with no header**. The `SR-01` class — which is why the count is computed, not asserted |
| 7 | **A neutral route cannot self-identify its sender.** Harmless at one provider; a real design question if a second is added (EA lists `Multiple Gateways (V3)`). Recorded in `PRD-019` §4.1 **in the paragraph that created the debt** |

---

## §7 Status of the questions this pass touched

| Question | State |
|---|---|
| **`Q-B31`** | ✅ **CLOSED** — `PRD-019` §4.8 |
| **`Q-B31-AC`** | ⛔ **OPEN** (new) — author `ITG-AC-*`; owner **`BC-31` owner** |
| **`ITG-GAP-001`** | ⛔ **OPEN** (new) — accepted V1 risk |
| **`ITG-GAP-002`** | ⛔ **OPEN** (new) — provider configuration dependency |
| **`FEE-GAP-010`** | **Decided** by `ADR-0046`; its **Status field in `PRD-008` is still `OPEN`** and its transcription remains the `PRD-008` owner's act |
| **`FEE-GAP-002`** | Unchanged by this pass — `PRD-008`'s own gap, byte-unchanged |
| **`GCP-14`**, `Q-A6`, `Q-A7`, `Q-S1` | Unchanged |

---

## §8 Verification

| # | Check | Result |
|---|---|---|
| 1 | `PRD-019` §4 specifies all five `ADR-0040` L165 elements + events | ✅ §4.1–§4.6 |
| 2 | `ITG-*` identifiers defined | ✅ **56**, computed by script |
| 3 | Every range contiguous from 001 | ✅ FR 28, BR 11, INV 5, XC 10, GAP 2 |
| 4 | Dangling `ITG-*` references | ✅ **0** |
| 5 | Stray table rows | ✅ **0** |
| 6 | Every `[RZP]` value cited in §4.9 | ✅ **26** rows |
| 7 | Route labelled `[LIB]`, not `[RZP]` | ✅ §4.0, §4.9 closing note |
| 8 | `PRD-008` byte-unchanged | ✅ `d24832f33e600518` |
| 9 | `MASTER_PRD.md` byte-unchanged | ✅ `5c31a3363d99a5f6` |
| 10 | EA byte-unchanged | ✅ `bb07d1e7bf8fd016` |
| 11 | Dependency Matrix byte-unchanged | ✅ `9895d244494372af` |
| 12 | BC Map byte-unchanged | ✅ `81518f1bb251218b` |
| 13 | `DOCUMENTATION_BASELINE.md` byte-unchanged | ✅ `c72cc96daf53ee08` |
| 14 | `ADR-0035` byte-unchanged | ✅ `6b10eddf3367f5f1` |
| 15 | `PRD_LIFECYCLE.md` byte-unchanged | ✅ `5031fcc97a95980e` |
| 16 | `PRD-008` freeze rows in baseline §3 | ✅ **0** |
| 17 | New `BC-` identifiers | ✅ **0** |
| 18 | New `E-*` edges | ✅ **0** |
| 19 | New permission / config identifiers | ✅ **0** |
| 20 | Numbered `IMPL-nnn` identifiers allocated | ✅ **0** — measured as `IMPL-\d+`. The bare token `IMPL-` **is** present (wildcard `IMPL-*`, in sentences denying an allocation), so a bare-prefix count is the **wrong instrument** and is not the claim made. Same correction applied at §5 item 5, `PRD-019` §6 and Matrix §2H.2 |
| 21 | Files under `tool/` modified | ✅ **0** |
| 22 | Dart source modified | ✅ **0** |
| 23 | `PRD-019` version + changelog in same commit | ✅ §7 step 2 |
| 24 | Baseline identifier re-issued | ✅ **No** — correctly, §2.3 |
| 25 | Contract text present in `PRD-008` | ✅ **None** |
| 26 | Contract text present in this ADR | ✅ **None** — §5 item 3 |

---

## §9 Self-objections

**1. "You wrote the contract you earlier said could not be written."**
Correct, and the reason it is not a reversal is on the record. `ADR-0045` §5.2 named the two missing inputs: the
provider, and *"that provider's own published webhook documentation, **which this repository does not contain**"*.
The provider arrived via `ADR-0046`. The documentation became readable in this pass. **A STOP whose stated
precondition is satisfied is supposed to be lifted** — continuing to refuse would be treating a measurement as a
policy.

**2. "The 30-day retention is invented."**
It is **derived and labelled `[LIB]`**, with both inputs cited (24-hour retry, 15-day replay) and the derivation
shown in the requirement itself. The alternative — publishing no retention at all — would leave `ITG-INV-003`
unenforceable. What was **refused** is inventing a *provider* value: see §3.2.

**3. "A route path is exactly what `ADR-0035` §5.5b forbids."**
It forbids `D-4`'s conferral from supplying one (§2.2). `ADR-0040` §4 L165 then assigns it to the `BC-31` owner by
name. **§4 does not create ingress**, which remains `platform/business`.

**4. "Subscribing to three events is not minimal — two would do."**
Each of the three is defended at its row, and `order.paid` was **refused** precisely on minimality grounds
(duplicate evidence path). `payment.authorized` is included because the provider documents it as the remedy for the
lost-client-response case, which is `FEE-BR-014`'s exact scenario. Dropping it would leave real payments stranded.

**5. "Stage 2 PASSED is self-serving."**
It is the only verdict upgraded, and it moved because the **specific deficiency §6 named** — *"§5 publishes no
ranges"* — no longer exists. Stages 3, 4, 5, 6 and Freeze are all left **unmet**, and `ITG-AC-*` empty is reported
as the largest outstanding item rather than hidden behind the Stage 2 tick.

**6. "`ADR-0044` §3.5 required an Architecture Owner prohibition-lift you never obtained."**
Addressed openly in §2.2's callout: `ADR-0045` §5.2 is the later, more precise routing, `ADR-0046` §3 supplied the
reasoning, and `ADR-0044`'s more cautious wording is **left standing rather than edited to agree with me**.

---

## §10 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | Created and **`ACCEPTED`**. Records the authority under which **`PRD-019` §4** was authored — the V1 payment webhook contract, **56 `ITG-*` identifiers**, five contiguous ranges — and **closes `Q-B31`**. §2 performs the three-part authority test **before** the edit: `ADR-0040` §4 L165 assigns the act to the `BC-31` owner; `ADR-0035` §5.5b's prohibitions bound **its own** conferral (measured against its governing heading and L776–L779), so no lift is required; and `PRD-019` is **Rank 3-registered, not Rank 3-holding**, so baseline §7 step 1 is not triggered — this ADR being written anyway, as practice. **§2.2 discloses a departure from `ADR-0044` §3.5's more cautious routing and leaves that wording standing.** §3 records the verification method: **primary Razorpay sources only** (third-party retry claims discarded), **event names read from rendered tables rather than inferred from prose**, and every value labelled **`[RZP]`** or **`[LIB]`** — with the **route path labelled `[LIB]`**, because Razorpay publishes constraints and no path, and calling it a provider value would be *a false citation dressed as compliance*. §3.2 discloses that *"replay window"* is answered by **event-id dedup**, since the provider sends **no signed timestamp** to bound. §4 measures twelve preserved boundaries: **`BC-05` remains the financial source of truth**, the webhook is **evidence never an instruction**, verification-before-recording is stated only in its **transport half**, `FEE-BR-016`'s duplicate protection stays `BC-05`'s, tenant isolation is explicit, and the vendor name and credential stay out of code, events, tables, contracts and `BC-05`. §5 lists eleven things not done — **`PRD-008` byte-unchanged and NOT frozen**, no contract text in this ADR, no BC/edge/port/permission/config ID/API/provider created, no `IMPL-*` allocated, no checker weakened. §6 records **seven honest shortfalls**, including **`ITG-AC-*` empty (coverage 0/54)**, Stage 3/4 not performed, two newly minted residual gaps, and **three defects in this pass's own first draft** that its counting script caught and repaired. §8 carries 26 verification rows; §9 answers six self-objections. |
