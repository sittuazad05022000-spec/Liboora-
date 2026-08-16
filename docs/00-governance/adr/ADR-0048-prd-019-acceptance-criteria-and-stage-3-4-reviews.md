# ADR-0048 — `PRD-019` acceptance criteria authored, and Stage 3 / Stage 4 checks run

| Field | Value |
|---|---|
| **ADR** | `ADR-0048` |
| **Title** | `PRD-019` acceptance criteria authored (`ITG-AC-001`…`ITG-AC-054`), and the Stage 3 / Stage 4 checks run without conferring either stage |
| **Status** | **`ACCEPTED`** — a **Rank 3 document act by the `BC-31` owner**, the role `ACCEPTED` [`ADR-0047`](./ADR-0047-prd-019-v1-webhook-contract-authority.md) **L183** names for `Q-B31-AC`. Same disclosure precedent as `ADR-0032` §5.2 / `ADR-0035` / `ADR-0043` / `ADR-0046` / `ADR-0047` — **no ARB quorum, attendee list, sign-off date or Security review is asserted** |
| **Date** | 2026-08-16 |
| **Decision by** | **`BC-31` owner** — for the acceptance-criteria authoring only. ⛔ **No Architecture Owner and no requirements-reviewer authority is claimed, conferred or exercised** (§3) |
| **Supersedes / amends** | **Nothing.** No `ACCEPTED` ADR is altered, no ranked document is amended, no checker is touched |
| **Bears on** | `PRD-019` v0.2 → **v0.3** · `Q-B31-AC` (**OPEN → CLOSED**) · `ITG-AC-*` register (0 → **54**) · **`ITG-GAP-003`** (minted) · `TRACEABILITY_MATRIX.md` §2H · new [`PRD-019_ARCHITECTURE_ALIGNMENT.md`](../../30-product/integration/PRD-019_ARCHITECTURE_ALIGNMENT.md) |

---

## 1. What was asked, and the one-line summary of what happened

**Asked:** preserve `PRD-019` v0.2's webhook contract; inspect the 56 `ITG-*` requirements and define complete,
testable `ITG-AC-*` acceptance criteria for them; then run `PRD-019`'s Stage 3 and Stage 4 checks — stopping with an
exact blocker if anything could not be resolved without authority.

**Done:** **54 criteria authored**, one per obligation, bijectively. **Stage 3 run — 6 of 6 measured ALIGNED**, in a
written alignment record with 3 conflicts disposed of and 7 findings rejected. **Stage 4 run — 5 of 6 PASS**, with
check 3's finding **deferred with a reason and an owner**. ⛔ **Neither stage verdict is CONFERRED** (§3), and
**`ITG-GAP-003`** is minted rather than invented around (§5).

**The escape clause did not fire, and §3 records why** — the authority for the authoring act already existed, and the
two acts for which authority is *absent* were **not performed** rather than performed anyway.

---

## 2. The authority test, run before writing rather than after

| # | Question | Answer |
|---|---|---|
| 1 | May this role author `ITG-AC-*`? | ✅ **Yes.** `ACCEPTED` `ADR-0047` **L183** routes `Q-B31-AC` to the **`BC-31` owner**: *"author ITG-AC-\*; owner **BC-31 owner**"*. The role authoring here is that role |
| 2 | Is the `ITG-AC-*` range free? | ✅ **Yes.** **0** numbered `ITG-AC-\d+` occurrences repository-wide before this pass; **0** definitions in any other document |
| 3 | Is the register *closed*, which would need an ADR to extend? | ✅ **No.** `PRD_LIFECYCLE.md` §5 rule 6 governs a register *"declared closed"*; `ITG-AC-*` was declared **reserved and empty**, never closed. Rule 6 is **not triggered** |
| 4 | Does a Rank 1–5 document change, requiring a prior ADR? | ✅ **No.** Only `PRD-019` (Rank 3-**registered**, not Rank 3-**holding** — v0.3 `DRAFT`, *"Not admitted"*), its new companion alignment record, `TRACEABILITY_MATRIX.md` and this ADR. Baseline §7 step 1 is not triggered; **this ADR is written anyway, as practice**, on the `ADR-0047` precedent |
| 5 | Is the baseline identifier re-issued? | ✅ **No** — §7 step 4 moves it only when a **Rank 1–3** document changes version, and `PRD-019` **holds no rank** |

---

## 3. THE CENTRAL DECISION OF THIS ADR — the two acts deliberately NOT performed

**This is the part of this record that matters most, and it is a refusal.**

`PRD_LIFECYCLE.md` **§6 Roles** assigns:

| Stage | Owner |
|---|---|
| **Stage 3 — Architecture Review** | **Architecture reviewer** |
| **Stage 4 — Requirements Review** | **Requirements reviewer** |

`ADR-0047` **L183** confers **neither**. It confers the **`BC-31` owner** role, for a **Stage 4 subject** (authoring
criteria). So this pass separated two things that are easy to blur:

| Act | Authority | Performed |
|---|---|---|
| **RUN** the checks — measure each against ranked documents, cite path and line, record conflicts and rejected findings | Inherent in producing the evidence a reviewer needs; creates no verdict | ✅ **Yes** |
| **CONFER** the stage — move `PRD-019` §6 to `PASSED` | **Architecture reviewer / requirements reviewer only** | ⛔ **NO** |

**`PRD-019` §6 therefore reads *RUN … MEASURED ALIGNED … verdict NOT CONFERRED*, and §7 carries both conferrals as
open items addressed to the named roles.**

⚠ **Why this refusal is the honest reading rather than an excess of caution.** `PRD-008`'s Stage 3 record carries an
amendment for the neighbouring error, and states the principle in general form: *"A Stage 3 record must not accept
the ADR it depends on; **it may only observe that someone with authority did.**"* One level up, the same logic
forbids a record from **conferring the stage it measures**. Had this pass written `PASSED`, `PRD-019` would show two
green gates whose only signatory is the author of the document being gated — **which is not a gate, it is a
self-report wearing a gate's formatting.** The cost is that `PRD-019` cannot advance to Stage 5, and that cost is
accepted.

⚠ **The escape clause was evaluated and deliberately not fired.** The instruction was to STOP and report if a
requirement or criterion *"cannot be resolved without authority."* **No criterion required absent authority** — all
54 rest on `ADR-0047` L183. The three items that **do** require authority are **not criteria**: two stage conferrals
and one Rank 4 clarification. Each is **routed to a named owner** rather than performed, which is the same test
`ADR-0040`, `ADR-0043`, `ADR-0044`, `ADR-0045` and `ADR-0047` had to pass to be accepted while containing open
questions. **A STOP would have withheld 54 criteria that were fully within authority to write.**

---

## 4. What was authored — and the property that makes it checkable

**54 criteria, `ITG-AC-001`…`ITG-AC-054`, in `PRD-019` §4.10.** The contract in §4.1–§4.6 is **byte-preserved**;
not one obligation was reworded to make it easier to test.

| Property | How it is made structurally true rather than asserted |
|---|---|
| **Every requirement testable** (Stage 4 check 1) | **Bijective map: 54 obligations, 54 criteria, one each.** An uncovered obligation is **arithmetically impossible** without the count changing |
| **Every criterion maps to exactly one requirement** (check 4) | Each row's **Verifies** cell names **one** identifier. **0** criteria verify two obligations, so an orphan cannot hide behind a shared row |
| **No `PRD-008` rule re-tested** (check 5, `ADR-0040` **L166**) | Every criterion asserts a **transport or evidence** fact. **0 assert a financial outcome** — verified by scan: no `ITG-*` obligation asserts a financial `MUST`. 13 `FEE-*` identifiers **cited, none copied** |
| **Coverage figure trustworthy** | **Computed by script** over the register's own rows (§4.11), because this repository has published a false *"100%"* once already (`PRD-006` v1.0, true 49.1%) |

⚠ **The number most likely to be misread, and it is labelled in three places.** *100% coverage* means every
obligation **has a criterion**. It does **not** mean any criterion **passes** — **0 of 54 are proven by a passing
test**, because no implementation exists. `PRD-007` was frozen under the identical distinction: *"`FROZEN`, not
`VERIFIED`."*

### 4.1 Three criteria verified by static evidence, disclosed rather than dressed up

`ITG-AC-013` (constant-time comparison), `ITG-AC-035` (secret unreachable from `BC-05`) and `ITG-AC-048` (no
transcribed provider constants) are satisfied by **static or configuration check plus review**, and **each says so
inside the criterion.**

**Justified by the repository's own precedent, not by convenience:** Rank 4 enforces **`ID-1`** — the neighbouring
rule about credentials — by *"Security review + schema scan in CI"*, not by a unit test. And a timing-based
assertion for constant-time comparison is **flaky by construction**; shipping a flaky test as proof is weaker
evidence than naming the verification method honestly. **A reader is told which three, and why.**

---

## 5. `ITG-GAP-003` — minted because the alternative was to invent a requirement

`ITG-FR-023` requires the platform to **detect** webhook disablement. This pass chased that obligation to its
documented limit before writing a criterion for it:

| Finding | Source |
|---|---|
| The provider's documented disablement signal is an **email** to the Alert Email Address | Razorpay *Webhooks — best practices* (`PRD-019` §4.9) |
| The only published API exposing a webhook's `active` / `disabled_at` status is **`GET /v2/accounts/:account_id/webhooks`** | Razorpay **Partner APIs for sub-merchant accounts** |
| Whether **this account type** may call that Partner API | ⛔ **NOT ESTABLISHED** |

**So no polling rule was written.** Specifying a status poll against an endpoint this account may not be entitled to
call would have produced a requirement that **reads as complete and cannot be implemented** — the same failure mode
`PRD-019` §4.0's `[RZP]`/`[LIB]` labelling exists to prevent, and the same failure `ADR-0047` avoided by refusing to
present the route path as a provider value.

**`ITG-AC-023` therefore states the limit inside the criterion** — detection in V1 is *notification-driven, not
programmatic* — and **`ITG-GAP-003`** records the residual, routed to the **Architecture Owner / merchant account
owner**. ⚠ **A gap carries no criterion**: gaps record what is **unresolved**, and issuing a criterion for one would
imply a specification that does not exist.

---

## 6. Stage 4 check 3 — the one check that does not pass, and why it was not made to

| Field | Value |
|---|---|
| **Finding** | **`ITG-FR-017` publishes a retention FLOOR and no CEILING** — *"MUST be retained for **at least** 30 days"*. The gate's failure text is *"unbounded configuration is a specification hole"* |
| **The tempting fix** | Write *"and at most 90 days"*. Check turns green in one clause |
| **Why it was refused** | An **upper** bound on dedup-identity retention is a **data-retention and privacy** decision. It interacts with `ID-5`, the Data Privacy runbook and storage cost — **none owned by this document**. Razorpay publishes **no** maximum, so there was **nothing to cite**. Writing one would have set a policy this role has no authority to set, and would have been **indistinguishable in the document from a researched value** |
| **Disposition** | **DEFERRED with a reason and an owner** — exactly what the Stage 4 gate permits (*"conflicts closed or explicitly deferred with a reason and an owner"*). Owner: **Architecture Owner** + retention-policy owner |
| **Not minted as `ITG-GAP-*`** | The **floor** is specified and correct; the missing **ceiling** is owned elsewhere. An `ITG-*` identifier would imply `BC-31` owns a retention-policy decision it does not |
| **Effect on the criterion** | `ITG-AC-017` asserts the **floor only** and **states that in its own text**, so it cannot be mistaken for a bounded specification |

---

## 7. Stage 3 — three conflicts, and the finding that changes how §2.1 should be read

Full record: [`PRD-019_ARCHITECTURE_ALIGNMENT.md`](../../30-product/integration/PRD-019_ARCHITECTURE_ALIGNMENT.md).
**6 of 6 checks measured ALIGNED. 3 conflicts disposed of. 7 findings rejected with reasons.** The two that matter
most here:

### 7.1 A-1 — the refused ingress reading would have broken `L2`, and nobody had said so

| Fact | Source |
|---|---|
| **INTEGRATION is R5** | Dependency Matrix **L69** |
| **BUSINESS is R6** | Dependency Matrix **L70** |
| *"A module may depend only on modules of **strictly lower rank**"* | **`L2`**, L49 |

`ADR-0035` **L442**, written pre-conferral, proposed the inbound adapter **inside `platform/integration`** (R5). An
R5 adapter calling the **R6** `business.payment_intent` port is a dependency on a **strictly higher** rank — **an
`L2` violation**, of the law the matrix calls *"what makes the graph provably acyclic without inspecting it."*

`PRD-019` §2.1 **already refuses** that reading, but on **governance** grounds — a superseded proposal is not
authority. **This review found an independent and stronger reason.** Disposition: **no action, the document is
already correct**; the finding is recorded so a future editor tempted to "simplify" the adapter's location can
discover that it **breaks the rank ladder**, not merely that it re-opens a settled point.

### 7.2 A-2 — `ID-1` vs BC Map L140, and why the narrow reading wins

| Source | Text |
|---|---|
| BC Map **L178** (`ID-1`) | *"No context outside BC-18 may store a password, OTP, session or **credential**."* |
| BC Map **L140** (`BC-31`) | *"Owns outbound third-party contracts, **credentials**, retries, idempotent delivery."* |

**Rank 4 grants `BC-31` credentials in one line and forbids credentials outside `BC-18` in another.** `ITG-BR-007`
holds a webhook secret, so the tension is live.

**Disposition: check 5 measured ALIGNED on the narrow reading** — `ID-1`'s enumeration (*password, OTP, session,
credential*) is a set of **subject authentication factors**, by which a **person** proves identity; a webhook
signing secret is a **machine-to-machine symmetric key** that authenticates no person and grants no session.

**What makes this a disposition and not an assertion:** under the wide reading, BC Map **L140 is unsatisfiable as
written** — `BC-31` cannot own *"outbound third-party contracts, credentials, retries"* while holding no credential.
**A reading that makes a Rank 4 line impossible to comply with is the wrong reading.** The narrow reading leaves
both lines standing.

⛔ **The residual is NOT closed.** No ranked document states the distinction explicitly; it is **derived**, and the
derivation is published so it can be overturned. `ID-1` and L140 are **Rank 4**, so only a prior ADR may settle it
(baseline §7 rule 1). Routed to the **Architecture Owner**, carried in `PRD-019` §7, and **deliberately not minted
as an `ITG-GAP-*`** — the under-specification is **Rank 4's**, and an `ITG-*` identifier would imply `BC-31` owns
the fix.

### 7.3 A-3 — the missing edge, closed by existing authority

**0** numbered edges connect `BC-31`↔`BC-05` (`E-25` is `BC-20`→`BC-31`). Closed by `ACCEPTED` `ADR-0035` **L610**:
*"`D-1` needed none; **ingress needs none**."* The architecture asks for the `business.payment_intent` **port**
(`X-03`), not an edge — the same diagnosis `PRD-008`'s own record reached: *"an artefact of looking for an edge
where the architecture asks for a port."*

⚠ **Rejected finding R-1, recorded because it was tempting:** *"`PRD-008` blocked on a missing edge, so this must
too."* That would copy the worked example's **first-pass error** instead of its **corrected conclusion** — following
the form and losing the substance.

---

## 8. What this pass did NOT do — measured, not asserted

| Not done | Verification |
|---|---|
| `PRD-008` not opened, amended or frozen | Byte-unchanged **`d24832f33e600518`**; **0** freeze rows in `DOCUMENTATION_BASELINE.md` §3 |
| No Rank 1–5 document modified | `MASTER_PRD.md`, BC Map, Dependency Matrix, EA, `PRD_LIFECYCLE.md`, `DOCUMENTATION_BASELINE.md`, all `ACCEPTED` ADRs — **byte-unchanged** |
| No bounded context, `E-*` edge, port, permission, configuration identifier, API architecture or provider created | Context count stays **31** (`AR-1`); no new provider value beyond §4.9's existing citations |
| **`ITG-GAP-001` / `ITG-GAP-002` NOT closed** | Both remain ⛔ **OPEN**. `ITG-AC-050` verifies `ITG-XC-006`'s **exclusion is honoured** and states in its own text that it **does not close `ITG-GAP-001`** — verifying an exclusion is not resolving the thin failure path it creates |
| Stage 3 / Stage 4 verdicts not conferred | §3 |
| Stage 5 not claimed; `PRD-019` not baselined or frozen | No `DOCUMENTATION_BASELINE.md` §3 row written or requested; Rank 3 precedence still **not held** |
| No numbered `IMPL-nnn` allocated | Measured as `IMPL-\d+` = **0**. The token `IMPL-` appears only as the wildcard `IMPL-*` in sentences **denying** an allocation, and as the literal `IMPL-nnn` here. ⚠ **Stated count-free on purpose** — a hard grep total inside the sentence that contains the counted token is **unstable by construction** (`GCP-01`) |
| **No Dart source changed** | `git diff` over `lib`, `test`, `pubspec.yaml`, `android`, `web` — **0 files** |
| No checker weakened | All 9 `tool/docs_check/*.py` **byte-identical**; the 3 pre-existing gate failures are unchanged in exit code and output |

---

## 9. One defect in this work's own prior output, repaired and disclosed

**`PRD-019` v0.2 shipped two headings numbered `### 4.1`** — the §4.1 route section and a §4.8 discussion
subsection. The second is renumbered **`### 4.12`**, and the write script now carries a post-assertion that **fails
on any duplicate `### 4.x` heading line**.

**Disclosed rather than silently fixed** because a quiet renumber changes section references without leaving a
record. ⚠ **It was found by a whole-file check, not by looking** — consistent with the instrument lesson this
repository has now recorded several times: a **pre-**assertion on an edit anchor cannot see a second occurrence
elsewhere in the file, so the post-assertion must test the **whole file**.

---

## 10. Consequences

| Consequence | Detail |
|---|---|
| `PRD-019` moves **v0.2 → v0.3** | 54 `ITG-AC-*` + `ITG-GAP-003`; identifier count **56 → 111** |
| `Q-B31-AC` **CLOSED** | Closed as **authored**, ⚠ **not as passing** — 0 of 54 proven by a passing test |
| Stage 3 and Stage 4 are **run and recorded** | Verdicts **NOT CONFERRED**; both carried as open items to their named roles |
| **3 new open items** | Stage 3 conferral · Stage 4 conferral + the check 3 retention ceiling · the Rank 4 `ID-1`/L140 clarification |
| **`ITG-GAP-003`** OPEN | Webhook-disablement detection is notification-driven; no polling specified |
| `TRACEABILITY_MATRIX.md` | §2H extended with the `ITG-AC-*` registration; **Stage 5 still not claimed** |
| Nothing is unblocked downstream | `PRD-019` remains `DRAFT`, unadmitted, unfrozen; the gateway-webhook feature remains unbuildable until implementation exists |
