# ADR-0046 — The V1 payment gateway provider is **Razorpay**

| Field | Value |
|---|---|
| **ADR** | `ADR-0046` |
| **Title** | The V1 payment gateway provider is **Razorpay** |
| **Date** | 2026-08-15 |
| **Status** | **`ACCEPTED`** — by direct conferral of **Architecture Owner** authority by the human principal, this being the *"exact authority action"* that [`ADR-0045`](./ADR-0045-fee-gap-010-gateway-provider-authority-stop.md) §5.1 reported as the missing prerequisite. Same disclosure as `ADR-0032` §5.2, `ADR-0035`, `ADR-0037`, `ADR-0039`, `ADR-0042` and `ADR-0043`: **no ARB quorum, attendee list, sign-off date or Security review is asserted**, and *a conferral for one act is not a standing licence* (`ADR-0033` §7.1) |
| **Supersedes** | **Nothing** |
| **Amends** | **Nothing.** `FEE-GAP-010`'s Status field is **not** edited by this ADR — see §6.2 |
| **Does NOT amend** | **`MASTER_PRD.md`** (Rank 1) · **the EA** (Rank 6) · **BC Map** (Rank 4) · **Dependency Matrix** (Rank 4) · **`AR-1/3/4`** (Rank 5) · **any frozen PRD** · **any `ACCEPTED` ADR** · **`PRD-008`** · **`PRD-019`** · **`tool/module_dependencies.yaml`** · **any gate under `tool/`** |
| **Affects** | `FEE-GAP-010` (its Owner's decision is now supplied) · `BC-20`, `BC-31`, `BC-05` (none's scope changes) |
| **Outcome** | **The V1 payment gateway provider is `Razorpay`.** ⛔ **No wire contract is created.** `Q-B31` stays **OPEN** — see §7 |

---

## §1 The decision

**The V1 payment gateway provider is `Razorpay`.**

That sentence is the whole decision. It is recorded here, under the authority named in the Status row, because
`ADR-0045` §5.1 measured that the repository did **not** contain sufficient authority to reach it — and named the
act required. That act has now been performed.

Nothing else in this ADR adds to the decision. §2 records why, §3 records the authority test, §4 records what is
preserved, §5 records what stays open, §6 and §7 record what was deliberately **not** done.

---

## §2 Why the decision is being made

| # | Reason | Evidence, where the repository already holds it |
|---|---|---|
| 1 | **A provider is required before the payment webhook wire contract can exist at all.** Every one of the five wire elements is provider-specific: a signature algorithm and header name are the gateway's; a replay window is tuned to the gateway's retry schedule; a payload schema **is** the gateway's wire format | `ADR-0045` §3 tested all five individually |
| 2 | **The absence of a provider was the sole blocker on `FEE-GAP-010`, and `FEE-GAP-010` blocks `FEE-GAP-002`'s resolution** | `PRD-008` `FEE-GAP-010` *Impact*: *"it blocks `FEE-GAP-002`'s resolution"* |
| 3 | **Razorpay is the only gateway named anywhere in the repository.** No competing provider is proposed in any document, at any rank | measured: the six sites enumerated in `ADR-0045` §2; zero other providers |
| 4 | **It is the direction the descriptive architecture already records for V1**, so accepting it introduces no structural change — the EA needs no correction and no Rank 1–5 document needs amending | EA **L1403–L1409**: `Razorpay (V1)` sits as a leaf under `Payment Gateway (V1)`, beside `Payment Gateway Abstraction (V1)` |
| 5 | **Rank 1 already sanctions exactly this shape** — a *"vendor recorded as a candidate implementation behind a port"* — so naming one does not contradict the Technology Stack table; it populates it | `MASTER_PRD.md` **§10** preamble (L220–L222) |
| 6 | **The known cost is already on the record and is accepted, not discovered.** EA **L79** calls single-gateway dependence *"vendor lock-in"* | that is the price of a V1 decision; the abstraction in reason 4 is the mitigation, and it is **required to remain** (§4) |

### §2.1 The reason that is *not* offered

**Not offered:** *"the EA already says Razorpay, therefore it is decided."* That reading was measured and refused in
`ADR-0045` §2.1 and it is still refused here. The EA is **rank 6, descriptive only** — *"Update it to match 1–5;
never the reverse"* (`DOCUMENTATION_BASELINE.md` **L221**) — and under `MP-CON-08` a Rank 1-versus-Rank 6
disagreement is *"a defect to be raised, not a choice to be made."*

The EA's line is **corroboration, not grounds**. Reason 4 above uses it only to show the decision costs no
structural change; the decision's authority is the conferral in the Status row and nothing else. This distinction
is not invented here — it is the §5.5a/§5.5b precedent in `ADR-0035`, which recorded that a descriptive EA line
could *describe* a placement but never *confer* it, and that where the two coincide the coincidence *"is
corroboration, not grounds."*

---

## §3 The authority test

`ADR-0035` **L613** records *"No named gateway provider | None appears in this ADR."* Read carelessly that looks
like a standing prohibition which this ADR breaks. It is not, and the distinction is load-bearing enough to
record:

| Measurement | Result |
|---|---|
| The heading that governs L613 | **"What `D-4` does NOT do — the boundary of the conferral, stated as constraints on future authors"** |
| L613's own reason column | *"None appears in this ADR"* — a statement about **ADR-0035's own content** |
| The sibling row's reason (retry policy) | *"**Not conferred**"* — i.e. *not conferred by that ADR*, not *never conferrable* |
| `ADR-0035` **L776–L779** | *"It is **not** a standing grant… Any further decision on the payment surface… **requires its own conferral.**"* |

So `ADR-0035` does not forbid the provider decision; it **specifies the mechanism** by which it must be made — a
further, separate conferral. This ADR is that conferral. `ADR-0035` is therefore **honoured, not overridden**, and
its Status, text and bytes are untouched.

The constraints ADR-0035 placed on the *webhook surface* remain fully in force, and this ADR obeys every one of
them (§6.1).

---

## §4 Architecture boundaries — preserved, and required to remain

The decision names a provider. It changes no boundary, and the following remain in force **unweakened**:

| Boundary | Authority | Still in force |
|---|---|---|
| The domain must not know Razorpay exists | Dependency Matrix **L167** (Rank 4) | ✅ **Yes** — unchanged |
| `Just call Razorpay from the payment service` is a forbidden edge | Dependency Matrix **L352**, row `X-03` (Rank 4) | ✅ **Yes** — remedy is still *"call `business.payment_intent` port"* |
| Naming a payment vendor in domain code, an event payload, a table or an API contract is excluded | `PRD-008` **`FEE-XC-006`** | ✅ **Yes** — and this ADR is none of those four things |
| `BC-05` stays vendor-blind | `PRD-008` `FEE-GAP-010` *Recommended*; Dependency Matrix L167 | ✅ **Yes** |
| The provider sits **behind** `Payment Gateway Abstraction` | EA L1404; `MASTER_PRD.md` §10 preamble | ✅ **Yes** — and this is the mitigation for EA L79's lock-in criticism, so it is **not optional** |
| `BC-31` stays **outbound**; inbound ingress is a Business Platform capability | BC Map L140; `ADR-0035` §5.5b | ✅ **Yes** — unchanged |
| Context count | `AR-1`; `ADR-0035` | ✅ **31 (23 in V1)** — no context created |

**The provider is a fact about the adapter, not about the domain.** Naming it in a governance record is precisely
how it stays out of the places `FEE-XC-006` and L167 forbid.

---

## §5 What this ADR does not decide

`ADR-0035`'s conferral was *"not a standing grant"*, and neither is this one. This ADR decides **the provider and
nothing else**. Each item below still requires its own act by its own owner:

| Still open | Owner |
|---|---|
| The payment webhook **wire contract** — endpoint, payload schema, signature algorithm, replay window, retry policy (`Q-B31`) | **`BC-31` owner**, into `PRD-019` §4 |
| Offline financial capture / `BC-30` (`FEE-GAP-002`(c)) | as recorded in `ADR-0035` |
| Settlement execution | Architecture Owner |
| The payment permission catalogue | as recorded in `ADR-0035` L776–L779 |
| Whether a second gateway is ever added (EA lists `Multiple Gateways (V3)`) | Architecture Owner |

---

## §6 What was deliberately NOT done

### §6.1 The prohibited values — none appears in this document

Per the instruction *"Do NOT invent webhook details yet"* and `ADR-0035` §5.5b, which stays in force:

| Prohibited | Count in this ADR |
|---|---|
| Endpoint, URL, path or route | **0** |
| Webhook payload schema, field list, content type | **0** |
| Signature algorithm | **0** |
| Header name | **0** |
| Replay-window value | **0** |
| Retry policy, timeout, dead-letter behaviour | **0** |
| Secret-rotation policy | **0** |
| New `E-*` edge | **0** |
| New permission identifier | **0** |
| New configuration identifier | **0** |
| New API, port or `provides_ports:` entry | **0** |
| New `BC-` identifier | **0** |
| New `FEE-*`, `ITG-*` or any requirement identifier | **0** |
| Dart source touched | **0** |
| Razorpay SDK name, version, package, API version or credential | **0** |

The word `Razorpay` appears in this ADR **only** as the name of the selected provider. No product of theirs, no
API of theirs and no document of theirs is cited, because **this repository contains none** — a fact
`ADR-0045` §2.1 measured and which is unchanged.

### §6.2 `FEE-GAP-010`'s Status field was NOT edited — and why that is the correct outcome

It is tempting to open `PRD-008` and write `RESOLVED` into `FEE-GAP-010`. That was **not** done:

1. The instruction is explicit — *"Create the minimum governance record required for the Architecture Owner to
   formally accept this provider decision"*, then *"**stop**"*. Editing a PRD register is not part of the minimum
   governance record; the ADR **is** the record.
2. `PRD-008` is at **v1.7 DRAFT** and is its own document's responsibility. Its `FEE-GAP-010` block already routes
   the answer outward — *"Resolve inside `BC-20`'s PRD"* — and its *Impact* field already records that the gap
   costs `PRD-008` nothing textually, because `FEE-XC-006` bars naming a vendor there **regardless of this
   decision**. So the decision changes no `PRD-008` text.
3. Editing it would require a version increment and a changelog entry in the same commit
   (`DOCUMENTATION_BASELINE.md` §7 step 2) — a second act, beyond the one conferred.

**The gap is therefore *decided but not yet transcribed*, and this ADR says so plainly rather than leaving a
reader to assume either more or less than happened.** §7 states the status in exactly those terms.

### §6.3 Rank 1 `MASTER_PRD.md` L232 was NOT amended

L232 reads *"Payments | `BC-20` via `BC-31` | Payment Gateway Abstraction | Gateway | **Not named in EA** —
candidate only"*. It was measured **in its enclosing table** before being left alone:

- The fifth column's header is **"Approved in EA v2.1?"** — it records whether the **EA** approved the vendor,
  which is a question about the EA, not about this decision.
- The fourth column's header is **"Candidate implementation (V1)"**, and the §10 preamble states vendors are
  recorded *"as candidate implementations behind ports."*

So L232 is a statement about **EA v2.1's** approval status, and this ADR does not change EA v2.1. Whether L232's
cells should now be refreshed to read like the `FCM (V1)` and `Crashlytics (V1)` rows is a **Rank 1 edit**, which
`DOCUMENTATION_BASELINE.md` §7 step 1 says *"requires an ADR **before** the change"* — and the instruction forbids
modifying `MASTER_PRD` here. It is left as a **named follow-up for the Architecture Owner** (§7), not performed
and not smuggled in.

### §6.4 The EA was NOT amended

EA **L1405** already reads `Razorpay (V1)`, so there is nothing to correct — and correcting a Rank 6 document to
create authority is what `ADR-0045` §2.1 refused. EA **L79**'s lock-in criticism is **not** deleted: it is a true
statement about the cost of this decision, and §4 records the abstraction that mitigates it. Deleting a criticism
because a decision was taken would destroy the record of what the decision cost.

### §6.5 No document was frozen

`PRD-008` remains **v1.7 DRAFT** with **0** rows in `DOCUMENTATION_BASELINE.md` §3 naming a PRD-008 file.
`PRD-019` remains **v0.1 DRAFT**. *"Freeze is conferred, not claimed"* (`PRD_LIFECYCLE.md` L155).

---

## §7 Status after this ADR

| Item | Status |
|---|---|
| **V1 payment gateway provider** | ✅ **`Razorpay` — DECIDED and `ACCEPTED`** |
| **`FEE-GAP-010`** | ✅ **DECIDED by its named Owner.** Its `PRD-008` *Status* field still reads `OPEN` — **deliberately untranscribed** (§6.2). The blocker is removed; the register entry awaits its document owner's own edit |
| **`Q-B31`** | ⛔ **OPEN — unchanged.** Owner: **`BC-31` owner**. Now *unblocked* by this decision, but **not performed**: the instruction says *"Do not create the webhook contract yet"* |
| **`PRD-019` §4** | Unchanged — the wire contract is still a **named hole**; `ITG-*` identifiers issued: **0** |
| **`PRD-008`** | Unchanged, **byte-for-byte**; still v1.7 DRAFT; **not frozen** |
| **Ranked documents** | Rank 1, 4, 5, 6 all **byte-unchanged** |
| **Follow-up for the Architecture Owner** | Refresh `MASTER_PRD.md` L232's *"candidate only"* cells (needs its own prior ADR, §6.3) · then the `BC-31` owner may author `Q-B31` |

---

## §8 Verification

Every row was executed, not asserted.

| # | Claim | Instrument | Result |
|---|---|---|---|
| 1 | This ADR names Razorpay as the V1 provider | read §1 | ✅ present |
| 2 | Authority is recorded, not assumed | read the Status row | ✅ Architecture Owner, by conferral |
| 3 | `ADR-0035` L613 is a scope statement, not a standing bar | read the governing heading + reason column | ✅ *"boundary of the conferral"* / *"None appears in this ADR"* |
| 4 | `ADR-0035` requires a fresh conferral for a further payment decision | read L776–L779 | ✅ *"requires its own conferral"* |
| 5 | No endpoint / URL / route | grep this file | ✅ **0** |
| 6 | No payload schema or field list | grep this file | ✅ **0** |
| 7 | No signature algorithm | grep this file | ✅ **0** |
| 8 | No header name | grep this file | ✅ **0** |
| 9 | No replay window value | grep this file | ✅ **0** |
| 10 | No retry policy or timeout | grep this file | ✅ **0** |
| 11 | No new `E-*` edge | grep this file | ✅ **0** |
| 12 | No new permission identifier | grep this file | ✅ **0** |
| 13 | No new configuration identifier | grep this file | ✅ **0** |
| 14 | No new API / port / `provides_ports:` | grep this file | ✅ **0** |
| 15 | `MASTER_PRD.md` byte-unchanged | sha256 (16-char) | ✅ `5c31a3363d99a5f6` |
| 16 | EA byte-unchanged | sha256 | ✅ `bb07d1e7bf8fd016` |
| 17 | BC Map byte-unchanged | sha256 | ✅ `81518f1bb251218b` |
| 18 | Dependency Matrix byte-unchanged | sha256 | ✅ `9895d244494372af` |
| 19 | `DOCUMENTATION_BASELINE.md` byte-unchanged | sha256 | ✅ `c72cc96daf53ee08` |
| 20 | `module_dependencies.yaml` byte-unchanged | sha256 | ✅ `22e40ac3fe080387` |
| 21 | `PRD-008` byte-unchanged | `git diff` | ✅ 0 |
| 22 | `PRD-019` byte-unchanged | `git diff` | ✅ 0 |
| 23 | No checker modified or weakened | `git diff` on `tool/` | ✅ 0 |
| 24 | No `ACCEPTED` ADR altered | `git diff` on `docs/00-governance/adr/` minus new+index | ✅ 0 |
| 25 | Stage 5 still passes | `prd008_stage5.py` | ✅ exit 0 |
| 26 | Freeze blockers still 0 | `prd008_traceability.py` | ✅ 0 |
| 27 | `docs_check` unchanged vs `c334bdf` | 9 gates, exit codes + full finding sets | ✅ identical |
| 28 | Boundary checker at baseline | `check_module_boundaries.dart` | ✅ rc=1, exactly 12 `ADR-0012` findings |
| 29 | Zero Dart touched | `git diff` vs `0fa4a8f` | ✅ 0 |
| 30 | `PRD-008` not frozen | rows in baseline §3 naming a PRD-008 file | ✅ **0** |

---

## §9 Self-objections

**"You refused to ratify Razorpay in `ADR-0045`, and now you have. One of the two is wrong."**
Neither is. `ADR-0045` measured that the **repository** held no authority to ratify, and reported the exact act
required: an Architecture Owner conferral recorded in a new `ACCEPTED` ADR. That act has now occurred, from outside
the repository, which is the only place it could ever have come from. `ADR-0045` is not superseded — it is the
document that specified this one's precondition, and it is cited, not retracted.

**"`ADR-0035` says 'no named gateway provider'. You just named one."**
§3 measures the sentence in its governing heading — *"What `D-4` does **NOT** do — the boundary of the
conferral"* — and beside its sibling row whose reason is *"Not conferred"*. It bounds ADR-0035's own grant.
L776–L779 then states that a further decision *"requires its own conferral"*. Reading L613 as permanent would make
L776–L779 meaningless, because no further conferral could ever act.

**"If the EA already said Razorpay, this ADR is ceremony."**
It is the opposite of ceremony: it is the difference between a **descriptive rank 6 line** and an **authority**.
`MASTER_PRD.md` L232 said *"candidate only"* and `MP-CON-08` forbids resolving a Rank 1/Rank 6 disagreement by
choosing. Until this conferral, the repository contained a conflict; now it contains a decision. §2.1 records that
the EA line is corroboration, not grounds.

**"You should have written `RESOLVED` into `FEE-GAP-010` — otherwise nothing visibly changed."**
§6.2 gives three reasons, the first being the instruction's own *"stop"*. Visibility is served by stating the split
explicitly — **decided, not yet transcribed** — rather than by performing an unconferred second act inside a
DRAFT PRD. A reader who greps `PRD-008` will find `OPEN`; §7 tells them exactly why, and who closes it.

**"You should now write the webhook contract — the provider exists."**
The instruction says *"Do not create the webhook contract yet"* and *"After the provider decision is legitimately
ACCEPTED, stop."* Beyond that, the contract needs the provider's **own published documentation**, which this
repository does not contain (§6.1). Writing it from the provider's name alone would be invention wearing a
decision's clothes.

---

## §10 Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-15 | Created and **`ACCEPTED`** by direct conferral of **Architecture Owner** authority. **Decides one thing: the V1 payment gateway provider is `Razorpay`.** This is the act [`ADR-0045`](./ADR-0045-fee-gap-010-gateway-provider-authority-stop.md) §5.1 reported as the missing prerequisite for `FEE-GAP-010`, now supplied from outside the repository — the only place it could come from. §3 records the authority test: `ADR-0035` **L613**'s *"no named gateway provider"* is measured **in its governing heading** (*"What `D-4` does NOT do — the boundary of the conferral"*) and beside its sibling row's reason (*"Not conferred"*), establishing that it bounds ADR-0035's **own** grant rather than barring future ADRs — confirmed by **L776–L779**, *"requires its own conferral"*. `ADR-0035` is therefore **honoured, not overridden**, and stays byte-unchanged. §2 gives six recorded reasons and §2.1 **refuses** the tempting one (*"the EA already says Razorpay"*), because Rank 6 is descriptive only (baseline **L221**) and `MP-CON-08` forbids resolving a rank conflict by choosing; the EA line is **corroboration, not grounds**, on the `ADR-0035` §5.5a/§5.5b precedent. §4 preserves every boundary — Dependency Matrix **L167** and row **`X-03`** stand, `FEE-XC-006` stands, `BC-05` stays vendor-blind, `BC-31` stays outbound, the provider sits **behind** the abstraction (which is EA **L79**'s lock-in mitigation and is **not optional**), context count stays **31**. **Nothing invented:** 0 endpoints, 0 schemas, 0 signature algorithms, 0 header names, 0 replay windows, 0 retry policies, 0 edges, 0 permissions, 0 config identifiers, 0 APIs, 0 `BC-` ids, 0 requirement identifiers, 0 SDK or credential references. **Nothing amended:** Rank 1 `MASTER_PRD.md`, Rank 4 BC Map and Dependency Matrix, Rank 5 rulings, Rank 6 EA, every frozen PRD, every `ACCEPTED` ADR, `PRD-008`, `PRD-019`, `tool/module_dependencies.yaml` and every gate are **byte-unchanged**. **`FEE-GAP-010` is DECIDED but deliberately NOT transcribed** (§6.2) — its `PRD-008` *Status* still reads `OPEN`, because editing a register is a second act beyond the one conferred and would require a version bump under baseline §7 step 2; the split is stated plainly rather than left to inference. **Rank 1 L232 deliberately NOT amended** (§6.3) — its fifth column asks *"Approved in EA v2.1?"*, a question about the EA, and refreshing it is a Rank 1 edit needing its own prior ADR; recorded as a named follow-up. **EA L79's criticism deliberately NOT deleted** (§6.4) — a decision's cost stays on the record. **`Q-B31` stays OPEN and the webhook contract is NOT written** (§7), per the instruction and because the provider's own published documentation is absent from this repository. **No document frozen** — `PRD-008` still v1.7 DRAFT, **0** baseline §3 rows name it. |
