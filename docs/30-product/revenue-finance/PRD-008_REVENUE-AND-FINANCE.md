# PRD-008 — REVENUE & FINANCE (V1)

| Field | Value |
|---|---|
| **Document** | `PRD-008_REVENUE-AND-FINANCE.md` |
| **Module** | Revenue & Finance |
| **Bounded Context** | **`BC-05` Fee & Collection** |
| **Classification** | `[CORE]` — Library Management cluster |
| **Release** | **V1** |
| **Version** | **v1.7 — DRAFT** *(still DRAFT, and **still NOT frozen** — read that before the count. **What moved: Freeze blockers 6 → 0.** **What did NOT move: the obligation count (§0.2 Total **249**, obligation-bearing **134**, `FEE-XC-*` **23**), membership of the 17-gap register, and NOT ONE `FEE-*` identifier was minted, renumbered or deleted.** ✅ **The mechanism, stated so the flattering reading is unavailable: v1.7 decides nothing itself.** Six conferred decisions are recorded in **`ADR-0043`**, and each gap stops blocking for a reason that can be checked against a document other than this one. **`FEE-GAP-002`** — the *owner* of the webhook wire contract now exists (`PRD-019_INTEGRATION.md` v0.1 `DRAFT`), and the contract is **NOT** duplicated here; the wire is **still unwritten** and the gateway **feature** is still unbuildable. **`FEE-GAP-003`** — bank transfer is **not** V1 and out-of-band money **cannot self-confirm**, which obligations this PRD **already carried** (`FEE-FR-061`, `FEE-XC-022`, `FEE-AC-081`/`082`, `ADR-0037`) already determine, so **nothing was written**. **`FEE-GAP-007`** — the `owner` is the sole approver by default, `manager` has **none**, grantable only through Master PRD **§6.1**’s existing scope-bearing mechanism; **no permission ID was invented**. **`FEE-GAP-009`** — §29.3’s second state machine is **corrected** to a projection of §29.1. **`FEE-GAP-011`** — **no retention period was invented**; the policy is routed to Product + Security/Compliance and V1 behaviour is already determined by `FEE-XC-011` (nothing is purged). **`FEE-GAP-012`** — (a) registry status moved by the Governance Owner on the register’s **own** test and **own** twice-executed precedent; (c) the report tier is **Rank 6 internal** and cannot bind `BC-05`. ⛔ **WHAT DID NOT HAPPEN, STATED BECAUSE EVERY INCENTIVE RUNS THE OTHER WAY: THIS PRD IS NOT FROZEN.** Freeze is *conferred* by a row in `DOCUMENTATION_BASELINE.md` §3 — **no such row was written or requested** — and **Stage 5 (traceability document) and Stage 6 (implementation tasks) have never been performed**: `docs/40-implementation/revenue-finance/` **does not exist**. A Freeze-blocker count of **0** means *no gap blocks*; it does **not** mean the lifecycle reached Stage 7. **`GCP-14` stays OPEN**, **`Q-A7` is newly raised**, `Q-B31`/`Q-S1` stay open, the **undeclared `FEE-RSK-*` register stays reported**, and **no new edge, endpoint, schema, signature algorithm, replay window, retry policy, provider, role, permission, ceiling, retention period, state value, aggregate or configuration identifier was invented.** **No frozen document, no `ACCEPTED` ADR, no Rank 1 MASTER_PRD line, no EA line, no BC Map line and no Dart source was touched; no checker was weakened.* *Superseded Version text retained verbatim:* **v1.6 — DRAFT** *(still DRAFT. **What moved: Freeze blockers 10 → 6.** **What did NOT move: the obligation count (§0.2 Total **249**, obligation-bearing **134**), membership of the 17-gap register, and NOT ONE gap is marked `RESOLVED`.** ✅ **The mechanism, stated so the flattering reading is unavailable:** v1.6 does not decide anything itself. **Four gaps stop blocking because the ADR carrying their decisions was ACCEPTED and one Rank 6 contradiction was corrected** — `ADR-0039` moved `PROPOSED` → `ACCEPTED` (so `FEE-GAP-004`/`005`/`006` now rest on binding authority) and EA **L823** was corrected `Refunds (V2)` → `Refunds (V1)` under `MP-CON-08` (so `FEE-GAP-001`’s single named remedy is performed). ⛔ **Six gaps still block, each now carrying ONE named residual and ONE named owner** — `FEE-GAP-002` (webhook wire contract: `Q-G2`/`Q-B31`), `003` (out-of-band bank credit handling: `Q-P1`), `007` (is `manager` an approver: `Q-P2`), `009` (§29.3 still prints a second state table: `Q-G1`), `011` (retention position: `Q-S1`), `012`(a)+(c) (registry status; report tier: Governance Owner / `Q-P3`). ⚠ **TWO CONFERRED INSTRUCTIONS WERE MEASURED UNEXECUTABLE AND ARE REPORTED, NOT WORKED AROUND:** authoring the `PRD-019` webhook contract collides with the same instruction’s *"do not invent … APIs, schemas, providers"* rule (`ADR-0040` §4 **L165**/**L166**; `PRD-019` files on disk = **0**), and excluding discounts from V1 would subordinate Rank 4 BC Map **L100**/**L374** to a V1 scope note. **No new `FEE-*` identifier was minted, no permission, ceiling, retention period, edge, schema, endpoint, provider or role was invented, no frozen document was touched, no checker was weakened, and this PRD is NOT frozen.** All ten dispositions are recorded in `ACCEPTED` `ADR-0042`. *Superseded Version text retained verbatim:* **v1.5 — DRAFT** — still DRAFT — **and this is the first version at which the Stage 4 gate was actually RUN, and PASSED on all six of its checks.** Read the next two sentences together or this row will be misread. **What moved: Stage-4 blockers 5 → 0.** **What did NOT move: Freeze blockers 10 → 10, membership identical, and NOT ONE of the 17 gaps is marked RESOLVED.** ✅ **THE LOAD-BEARING MECHANISM, because the flattering reading would be that v1.5 simply declared the blockers gone:** v1.4 recorded four Product-Owner decisions and correctly refused to decrement anything, on the stated principle that **a decision is not a specification**. v1.5 performs the missing half — it **converts those four recorded decisions into requirement text and acceptance criteria**, which is the act `PRD_LIFECYCLE.md` **L108–L120** check 1 actually tests. Four obligations that carried **⛔ no acceptance criterion** at v1.4 — **`FEE-FR-028`**, **`FEE-FR-042`**, **`FEE-BR-007`**, **`FEE-BR-019`** — now carry criteria; **`FEE-EVT-003`** has its behaviour specified while its **payload remains expressly unspecified**, labelled a deliberate partial rather than passed off as complete. **`FEE-AC-085`…`FEE-AC-098` (14 new criteria) were added; the obligation count is UNCHANGED at 134 — no new requirement, business rule, invariant, event, exclusion, permission, state value, enum or configuration identifier was created.** Registers: acceptance criteria **84 → 98**, register total **235 → 249**, traceability **134/134 = 100%**. ✅ **THE `FEE-GAP-002` OWNERSHIP CONFLICT REPORTED AT v1.4 IS NOW AUTHORITATIVELY CLOSED — BY DETERMINATION, NOT BY SUBSTITUTION.** It was routed to the **Architecture Owner**, who **UPHELD `ACCEPTED` `ADR-0035` §5.5b UNCHANGED**: inbound webhook ingress is owned by **`platform/business`**. Recorded in **`ACCEPTED` `ADR-0040` §1**. **The `platform/integration` reading offered at v1.4 is NOT adopted**, and the evidence that favoured it is preserved rather than buried — `ADR-0035` **L442** did propose an inbound adapter within `platform/integration`, but §5.5b **superseded** L442 and **a superseded proposal is not authority**. §5.5b’s reasoning was **re-tested against the manifest rather than taken on trust**: **L406** declares `platform/business` at rank 6 and **L409** declares `ports: [platform/integration:payment_gateway]`, a **caller → callee** relation. **`tool/module_dependencies.yaml` is byte-unchanged; no `BC-32`; no `E-*` edge; no `provides_ports:` entry.** ✅ **A FINDING WAS REQUIRED, NOT MERELY A DECISION, AND IT IS THE REASON `FEE-FR-028` COULD BECOME TESTABLE AT ALL.** `ADR-0040` §2 established **by measurement** that **no document may currently author the webhook wire contract**: `PRD-022`’s own **`SAAS-XC-006`** (L157-158) bars **`BC-20`** from naming a *“webhook schema”*; **`PRD-019`** — `BC-31`’s PRD — is **`PLANNED` and does not exist** (`PRD_REGISTRY.md` **L309**); this document forbids itself the same at **§14.1**; and §5.5b forbids *“invent[ing] an endpoint/schema”*. **Four candidate authors, all barred.** So `FEE-FR-028`’s criteria test **`BC-05`’s OWN verification obligation**, which §5.5b expressly left with `BC-05`, in the **already-established shape of `FEE-AC-032`/`033`/`034`** — and **not one of `FEE-AC-085`…`089` names an endpoint, URL, payload field, signature algorithm, header, replay window, retry policy or provider.** ⚠ **A DEFECT OF THIS DOCUMENT’S OWN, FOUND AT v1.5 AND DISCLOSED RATHER THAN QUIETLY REPAIRED.** Stage 4 check 4 — *“every acceptance criterion maps to a requirement”* — runs **criterion → requirement**, the opposite direction from check 1, and **had never once been measured in this document’s history**. It found **three genuine orphan criteria**: **`FEE-AC-022`**, **`FEE-AC-023`** and **`FEE-AC-074`**. They are now mapped, each to an obligation that **already** asserted the rule the criterion tests, so **no requirement was invented and no criterion was reworded to fit**. The first orphan probe run was itself **wrong** — it reported 204 traceability rows against 134 obligations because its pattern swept unrelated tables — and **both the error and its correction are recorded in §36.1a** rather than presented as a clean result. ⛔ **WHAT DID *NOT* HAPPEN, STATED BECAUSE EVERY INCENTIVE RUNS THE OTHER WAY:** **no gap is marked RESOLVED**; **the Freeze count does not move**; **`FEE-GAP-002`’s wire contract is still unwritten**; and `FEE-GAP-004`’s decided fee-type taxonomy is **deliberately NOT written as an enumeration**, because `FEE-FR-006` requires a configurable value through `E-19` and a hard-coded list would **contradict this PRD’s own requirement**. Stage 4 clears for the contract limb only because its gate permits a conflict to be *“explicitly deferred **with a reason and an owner**”*, and that limb now has both — owner: the **`BC-31` owner once `PRD-019` exists**; reason: `ADR-0040` §2. **Freeze has no such clause, which is precisely why Freeze still blocks at 10.** The Freeze set was re-derived by reading all 17 blocks’ own fields and taking each field’s **leading declared verdict**; a naive pattern match returns **13** because `FEE-GAP-013`/`014`/`017` each say *“BLOCKS the … **feature**, not this PRD”* — **10 is right and the pattern is wrong**, re-checked at v1.5 rather than inherited. ⚠ **`FEE-GAP-002`(c) and `ADR-0037` were NOT reopened**: physical cash may be received offline, but financial recording remains online and server-authoritative with **no offline write, queue or sync**. ⚠ **The pre-existing §41 changelog defect disclosed at v1.4 is STILL NOT fabricated:** §41’s table ends at **v1.0** and has no v1.1–v1.5 row. **v1.5 does not invent five rows of history it did not perform.** **Nothing was closed, deleted, renumbered or inflated; no frozen document was modified; no `ACCEPTED` ADR was altered; no checker was weakened; no `BC-32`, edge, endpoint, schema, signature algorithm, provider, role, permission or configuration identifier was invented; no Dart source was touched.*) *Superseded Version text retained verbatim below:* **v1.4 — DRAFT** *(still DRAFT, and **Stage 4 was NOT run — for the fourth consecutive version**. At v1.4 **four Product-Owner decisions arrived and NOT ONE COUNT MOVED**: `FEE-GAP-001` V1 refund scope (confirmed-only, immutable original, separate operation, **full refund only**, cash server-recorded), `FEE-GAP-004` V1 fee types (four revenue types plus **Security Deposit as a refundable liability, NOT revenue**), `FEE-GAP-005` **append-only** financial correction, and `FEE-GAP-006` **due-date offset = 0 days**. All four are recorded in **`ADR-0039`**, which is **`PROPOSED` and deliberately NOT self-accepted**. **The counts stand at 5 Stage-4 blockers and 10 Freeze blockers**, re-derived at v1.4 by reading every one of the 17 gap blocks’ own `Stage 4` and `Freeze` field — not carried forward. ⛔ **THE LOAD-BEARING SENTENCE OF THIS ROW: A DECISION IS NOT A SPECIFICATION.** Four obligations — **`FEE-FR-028`** (L1717), **`FEE-FR-042`** (L1731), **`FEE-BR-007`** (L1754) and **`FEE-BR-019`** (L1766) — still carry **⛔ no acceptance criterion**, so `PRD_LIFECYCLE.md` **L108–L120** check 1 still fails. Deciding a policy does not make the requirement that must express it testable, and **no `FEE-*` requirement text, state value, event, enum, permission or configuration row was written at v1.4**. ⛔ **ONE OFFERED DECISION WAS REFUSED AND REPORTED AS A CONFLICT, NOT APPLIED.** A webhook contract routing *“Payment Gateway → existing **`platform/integration`** capability → verification → `BC-05`”* was offered for `FEE-GAP-002`. **Four of its five clauses match what is already decided** (no `BC-32`; transport/evidence only; `BC-05` remains financial source of truth; verification precedes recording) and are recorded as confirmations. **The fifth — the routing owner — contradicts `ACCEPTED` `ADR-0035` §5.5b (L536)**, which binds *“inbound payment webhook = existing **Business Platform** capability”* (`platform/business`, rank 6). `tool/module_dependencies.yaml` **L406**/**L409** show these are **distinct modules in a caller → callee relation**, not synonyms. Per the standing rule that *“a conflict is a defect — do not choose, raise it”*, it is **escalated to the Architecture Owner and NOT worked around**; `tool/module_dependencies.yaml` is **byte-unchanged**. ⚠ **A pre-existing defect disclosed rather than silently repaired:** §41’s changelog table ends at **v1.0** and has **no v1.1, v1.2, v1.3 or v1.4 row** — those versions recorded their narrative in this Version row instead. **This pass does not fabricate the three missing rows**, because writing changelog history for versions it did not perform would invent a record. The omission is logged here for the document owner. **Nothing was closed, deleted, renumbered or inflated; no gap is marked RESOLVED; no frozen document was modified; no `ACCEPTED` ADR was altered; no `BC-32`, edge, endpoint, schema, provider, role, permission or configuration identifier was invented; no gate was weakened; no Dart source was touched.** *Superseded Version text retained verbatim below:* **v1.3 — DRAFT** *(still DRAFT, and **Stage 4 was NOT run**. At v1.3 exactly one thing changed and it was **not** a blocker: `ADR-0035` `D-3`, already recorded **✅ Authorised / ❌ not executed** in that ADR's own acceptance table, was **executed** — a false `E-25` citation was removed from Rank 5 `PRD_DEPENDENCY_GRAPH.md`. **Removing a false citation is not resolving a gap.** **The counts therefore do NOT move: 5 gaps still block Stage 4 and 10 still block Freeze**, re-derived at v1.3 by reading every one of the 17 gap blocks' own `Stage 4` and `Freeze` fields, not carried forward. The four remaining Stage-4 blockers (`FEE-GAP-001`, `004`, `005`, `006`) and `FEE-GAP-002` lack a **product decision**, not evidence, and are routed by **`ADR-0038`** (`PROPOSED`) to the Product Owner and the Architecture Owner. **`ADR-0038` is deliberately not self-accepted.** ⛔ **Stage 4 was not run, and the reason is measured:** `PRD_LIFECYCLE.md` **L108–L120** check 1 requires every requirement be testable, and **four obligations — `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-019`, `FEE-BR-007` — carry `⛔ none` acceptance criteria**. The gate's *“explicitly deferred with a reason and an owner”* clause does **not** rescue them, because this PRD **asserts** those obligations while marking them `⛔ BLOCKED` — a PRD cannot assert an obligation and defer its testability in the same breath. **Nothing was closed by documentation alone.** *Superseded text retained verbatim below:* **v1.2 — DRAFT** *(still DRAFT. At v1.2 this PRD's Stage 3 alignment record reaches ✅ **ALIGNED 6/6** for the first time — and **Stage 3 is not Stage 4, and alignment is not a freeze**. **5 gaps still block Stage 4** and **10 still block Freeze**, so the lifecycle stage does not advance. Superseded: v1.1 read "the conferral resolved one gap, it did not complete a lifecycle stage" — still true, and now true of a second conferral)* |
| **Status** | **`DRAFT`** — Stage 2 of [`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md). **NOT frozen. NOT approved. NOT architecture-reviewed.** Status is *conferred* by admission to the baseline, never claimed by a document about itself; [`PRD_REGISTRY.md`](../../00-governance/prd-ecosystem/PRD_REGISTRY.md) §4.1 records `PRD-008` as **`DRAFT`** at **v1.7** — moved by the **Governance Owner** under `ADR-0043` §8.2, on the register’s **own** §2.1 **L42** evidence test and its **own** twice-executed `PRD-004` v1.4 / `PRD-022` v1.9 precedent. **This document did not move its own row**, and `DRAFT` is **not** `FROZEN`: the Freeze gate is a row in `DOCUMENTATION_BASELINE.md` §3, and **there is none**. |
| **Baseline** | Written **against** `BASELINE-2026-08-05-A`. **Not admitted to it.** |
| **Precedence rank if admitted** | Rank 3 (module PRD), the rank `PRD-004`…`PRD-007` hold |
| **Owns** | `FeeLedger` *(per student)* — BC Map §8 L374 |
| **Consumes** | `BC-06` Library Policy (`E-06`) · `BC-02` Membership (`E-07`) · `BC-01` Enrollment (`E-09`) · `BC-21` Entitlement (`E-17`) · `BC-19` Tenancy (`E-18`) · `BC-25` Configuration (`E-19`) |
| **Publishes to** | `BC-02` Membership (`E-10`) · `BC-24` Audit Trail (`E-20`) · `BC-22` Notification Delivery (`E-23`) |
| **Authorities applied** | Master PRD v1.7 (Rank 1) · `ADR-0015` **Accepted** (Rank 2) · `PRD-004` v1.2 **FROZEN**, `PRD-005` v1.4 **FROZEN**, Library PRD v1.1 **FROZEN** (Rank 3) · **BC Map v1.7**, Module Dependency Matrix v1.3 (Rank 4) · Enterprise Architecture v2.1 (Rank 6, **descriptive only**) |
| **Blocking governance gaps** | **17 gaps — re-derived at v1.7: 0 block Stage 4 and 0 block Freeze.** ⚠ **A count reaching zero is the single most flattering number this document can print, so it is stated with its membership, its cause and its limits.** **Leaving the Freeze set, six:** `FEE-GAP-002` (owner of the wire contract now exists — `PRD-019` v0.1; contract still unwritten, `Q-B31` OPEN), `003` (out-of-band money cannot self-confirm — by obligations **already** present), `007` (`owner` sole approver by default; `manager` none; existing §6.1 grant mechanism), `009` (§29.3 corrected to a projection), `011` (no period invented; `FEE-XC-011` already forbids purging; policy routed), `012` (a: registry moved by the Governance Owner; c: Rank 6 cannot bind `BC-05`). **Membership of the 17-gap register itself is unchanged.** ⛔ **`FEE-GAP-011` is the one closure resting on a decision NOT to decide** — the retention *policy* remains **OPEN** against Product + Security/Compliance (`Q-S1`); what closes is the demand that this PRD invent a period. ⛔ **Zero Freeze blockers does NOT mean frozen.** No `DOCUMENTATION_BASELINE.md` §3 row exists, and **Stage 5 and Stage 6 have never been performed**. **Re-derived mechanically** by `tool/docs_check/prd008_traceability.py` from every gap block’s own `Stage 4`/`Freeze` leading verdict — not by subtracting six from six. *Superseded text retained verbatim:* **17 gaps — re-derived at v1.6: 0 block Stage 4 and 6 block Freeze.** ⚠ **The Freeze total moves for the first time — 10 → 6 — so it is stated with its membership and its cause, because a falling count is the one most in need of checking.** **Leaving the Freeze set:** `FEE-GAP-001` (EA **L823** corrected under `MP-CON-08`), `004`, `005`, `006` (their decisions now **bind**, `ADR-0039` having been `ACCEPTED`). **Remaining in it, six:** `FEE-GAP-002`, `003`, `007`, `009`, `011`, `012`. **Membership of the 17-gap register itself is unchanged and NOT ONE gap is marked `RESOLVED`** — `002`, `003`, `007`, `009`, `012` each record a **decision plus a named residual**, which is not the same as closure. **Re-derived mechanically** by `tool/docs_check/prd008_traceability.py` from every gap block’s own `Stage 4`/`Freeze` leading verdict — not by subtracting four from ten. *Superseded text retained verbatim:* **17 gaps — re-derived again at v1.2, and the totals do NOT move: still 5 block Stage 4 and 10 block Freeze.** `FEE-GAP-002`(c) was closed by `ADR-0037` **for Stage 3 only**, and its own **`Stage 4` field was deliberately left at `BLOCKS`** — so the Stage-4 set is unchanged at **`FEE-GAP-001`, `002`, `004`, `005`, `006`** and the Freeze set unchanged at **ten** (all except `FEE-GAP-008`, `010`, `013`, `014`, `015`, `016`). **This is the row most at risk of a flattering error, and it was checked for exactly that.** A gap closing for one gate does **not** leave the other gate's set; at v1.1 the opposite mistake was made and recorded in this very document — a draft asserted the Stage-4 count *"stays at **6**"* when `FEE-GAP-016` had in fact left, making it **5**. Here the temptation runs the other way: `FEE-GAP-002` is now *“resolved”* in its heading, and decrementing the Stage-4 count on that basis would be wrong, because **no decision was given on its Stage-4 concerns**. *A naive re-derivation of the Freeze set returned **13**; reading every `Freeze` field verbatim shows `FEE-GAP-013`/`014`/`017` each say “**BLOCKS the … feature, not this PRD**”. The ledger's **10** is right and the pattern was wrong.* *Superseded text retained:* **6 block Stage 4** (`FEE-GAP-001`, `002`, `004`, `005`, `006`, `016`) · **11 block Freeze** (all except `FEE-GAP-008`, `010`, `013`, `014`, `015`) — **both counts re-derived mechanically from the §39 table at v0.7, and again at **v1.1** after the conferral — see the v1.1 note at the end of this row; never carried forward**. *(The previous parenthetical — "all except `008`, `010`, `013`" — was a **pre-existing defect**: that set is twelve, not ten, and it omitted `014`/`015`, which were added at v0.4 and block neither. Corrected here by measurement.)* **`FEE-GAP-013` is PARTLY RESOLVED at v0.3** — its ownership question (a1) and duration-guarantee question (e) are **closed by measurement**; its remaining parts, including the **new term-deduction conflict (f)**, block the requested *renewal-protection feature*, **not** this PRD. **Two gaps were added at v0.4** — `FEE-GAP-014` (platform commission / settlement has no owning document; it is `BC-20`'s money, not `BC-05`'s) and `FEE-GAP-015` (platform-configuration authority). **Neither blocks Stage 4 nor Freeze of this PRD**, because `BC-05` owns neither subject; both block the *features* that need them. **At v0.5 two gaps moved to PARTLY RESOLVED by measurement, and no count changed:** `FEE-GAP-015`'s role question is **closed** — **`PR-1` Platform Administrator already carries *"manage platform configuration"* in its Purpose and Scope**, so no new role is needed and none is proposed; only a named permission and a parameter row remain open. `FEE-GAP-006`'s **three-concept ambiguity** (membership term end date vs fee-obligation due date vs renewal-protection window) is **closed**; the offset value remains open and still blocks. **At v0.6 `FEE-GAP-002` moved to PARTLY RESOLVED and the count again did not change:** its *transport* half is **closed by measurement** — `business.payment_intent` is an **already-declared port** in the Dependency Matrix's own normative section (L196), prescribed by name in `X-03` (L352) and already tabulated as a declared port by Accepted `ADR-0012` (L86), so **no `E-*` edge is missing and none was invented**; its *counterparty* half — which context executes a **student→library** payment, given `MP-GBR-24` bars `BC-20` — was then still **OPEN**. **At v0.7 that counterparty half is RESOLVED and one new gap is opened, so the counts genuinely move 15 → 16 gaps, 5 → 6 Stage-4 blockers and 10 → 11 Freeze blockers.** `ADR-0035` `D-2` selects **`O-3`** — student→library **payment execution is a capability of the Business Platform**, **not** a new bounded context — passing the architecture's own **`AR-1`** test on all four criteria; the context count stays **31** and **no `BC-32` is created**. `FEE-GAP-002` nevertheless **still blocks**, because its **part (c), the offline-sync path, was never resolved** and `E-24` remains `BC-03` → `BC-30` only. **A retraction is recorded here:** an earlier draft of this pass asserted that the Stage-4 blocker count *"stays at 5"* on the reasoning that `FEE-GAP-016` merely replaced `FEE-GAP-002` in the blocking set. **That was wrong, and it was wrong in the direction that flattered the document.** Re-derived mechanically from the §39 table, the blocking set is **six**, because `FEE-GAP-002` did not leave it. `ADR-0035` remains **`PROPOSED` — not accepted, and not self-accepted**, so `D-2` is **recorded, not in force**. Measured from §39, not asserted. **✅ AT v1.1 THE COUNTS GENUINELY FALL, 6 → 5 STAGE-4 AND 11 → 10 FREEZE, AND EXACTLY ONE GAP IS THE REASON.** `ADR-0035` is now **`ACCEPTED`** — *"In force. Binding on all implementation"* — **by direct conferral of Architecture Owner authority by the human principal**, on the same disclosed basis as `ADR-0032` §5.2 and `ADR-0033`: **no ARB quorum, attendee list, sign-off date or Security review is asserted.** Its **`D-4`** is answered in new **§5.5b**: the **inbound payment webhook is an existing Business Platform capability**, the return leg of the outbound call `O-3` already authorises. It passes `AR-1` on all four criteria, so **the context count remains 31 and `BC-32` is NOT created.** **`FEE-GAP-016` is therefore RESOLVED** and leaves both blocking sets. **`D-1` and `D-2` also now bind** rather than merely being recorded, so `FEE-GAP-002`(a) and (b) are **in force**. **⛔ `FEE-GAP-002` NEVERTHELESS STILL BLOCKS BOTH GATES, AND THIS IS THE LOAD-BEARING SENTENCE OF THIS ROW:** its **part (c)**, offline financial capture through `BC-30`, **was not among the decisions given**. `E-24` is `BC-03` → `BC-30` only; edges `BC-05` → `BC-30` = **0**. **Nothing here is a decrement.** Both counts were re-derived by reading every one of the 17 gap blocks' own `Stage 4`/`Freeze`/`Blocks` fields (§39.1). **A first draft of this pass asserted the Stage-4 count "stays at 6" because `FEE-GAP-002` had not left the set; that was wrong — `FEE-GAP-016` left — and the error is recorded in `FEE-GAP-002`'s Status row rather than quietly fixed.** **Not resolved, and no decision was given on any of them:** `FEE-GAP-001`, `003`, `004`, `005`, `006`, `007`, `009`, `011`, `012` · `FEE-GAP-013`'s six blocked parts · `FEE-GAP-014`, `015`, `017`, which remain routed to the `BC-20` owner, the Authorization owner, `PRD-022` and the Product Owner. **This PRD is NOT re-statused, NOT frozen, and NOT declared Stage-3 aligned by this row** |
| **Recommendation** | **REQUIRES CORRECTIONS — GOVERNANCE BLOCKED.** See §K of the covering report |

> ### ⚠️ Read this before treating any statement here as settled
>
> This document is a **Stage 2 draft**. It has **not** passed Stage 3 (Architecture Review) or Stage 4
> (Requirements Review). Nothing in it is approved.
>
> **Six governance gaps block progress**, and they are not stylistic. Two of them — `FEE-GAP-001` (is
> Refund V1 or V2?) and `FEE-GAP-002` (BC-05 has **no** declared architectural path to a payment
> gateway) — mean that **the online-payment and refund portions of this module cannot be specified
> without a decision from a named authority**. This draft therefore **states the conflict and stops**,
> rather than choosing a side and calling it a requirement.
>
> **Normative language.** **MUST** / **MUST NOT** = absolute obligation. **SHOULD** = strong
> recommendation, deviation requires recorded justification. **MAY** = genuinely optional.
> **⛔ BLOCKED** = cannot be specified until a gap is resolved.

---

## 0. Identifier registers — declared up front

`PRD_LIFECYCLE.md` §2 Stage 2 requires registers *"declared **up front** with ranges — publishing the ranges
as a promise"*. §5 requires prefixes checked against every existing register **before** writing.

### 0.1 Prefix collision check — performed, not assumed

| Candidate prefix | Occurrences found across `docs/` before this document | Verdict |
|---|---|---|
| `FEE-*` | **0** | ✅ **free — adopted** |

Measured by `grep -rhoE "\bFEE-[A-Z]+-[0-9]+" docs/ | sort -u | wc -l` → `0`. No collision with `MP-*`,
`AUTH-*`, `LIB-*`, `SID-*`, `SM-*`, `MM-*`, `ATT-*` or `SEAT-*`.

### 0.2 The registers

| Register | Meaning | Count | Range |
|---|---|---|---|
| `FEE-FR-*` | Functional requirement | **62** | `FEE-FR-001` … `FEE-FR-062` |
| `FEE-BR-*` | Business rule | **28** | `FEE-BR-001` … `FEE-BR-028` |
| `FEE-INV-*` | Invariant | **10** | `FEE-INV-001` … `FEE-INV-010` |
| `FEE-EVT-*` | Domain event published by `BC-05` | **3** | `FEE-EVT-001` … `FEE-EVT-003` |
| `FEE-XC-*` | Explicit exclusion — what this module MUST NOT do | **23** | `FEE-XC-001` … `FEE-XC-023` |
| `FEE-PO-*` | Port / integration obligation | **8** | `FEE-PO-001` … `FEE-PO-008` |
| `FEE-AC-*` | Acceptance criterion | **98** | `FEE-AC-001` … `FEE-AC-098` | *(was **84** / `…FEE-AC-084` before v1.5 added `FEE-AC-085`…`098`; the range is **contiguous** and was re-derived by reading the declared rows, not by adding 14)*
| `FEE-GAP-*` | Governance gap / open question — **not a requirement** | **17** | `FEE-GAP-001` … `FEE-GAP-017` |
| **Total** | | **249** | | *(was **235**; **+14** acceptance criteria at v1.5 and **no** new obligation — see the note below, which is the load-bearing part of this table)*

> **⚠ THE OBLIGATION COUNT DID NOT MOVE AT v1.5, AND THAT IS THE POINT.** v1.5 converted four already-recorded
> decisions into **testable requirement text** and added **14 acceptance criteria** — it added **no new
> functional requirement, business rule, invariant, event, exclusion or port**, and **no new configurable**.
> `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-007`, `FEE-BR-019` and `FEE-EVT-003` **already existed**; what changed is
> that they now say something a test can execute. **Inventing new obligations to look thorough would have been
> the failure mode**, since the instruction was explicit: *"Do not invent additional business rules."*

**Obligation-bearing** = 62 + 28 + 10 + 3 + 23 + 8 = **134**. `FEE-AC-*` are *verified by* tests and
`FEE-GAP-*` are *open questions*; neither is an obligation, exactly as `PRD-006` §0.3 treats `ATT-AC-*`
and `ATT-GAP-*`.

> **⚠ CORRECTION OF MY OWN ERROR (v0.8).** This table's `FEE-GAP-*` row read **15 / total 231**
> until v0.8, even though **`FEE-GAP-016` was added at v0.7**. §37 and §39 were updated at v0.7 and
> this table was not, so the document disagreed with itself for one version. **That was an error in
> the v0.7 pass — mine — not a pre-existing defect inherited from an earlier draft**, and it ran in
> the flattering direction: a smaller gap count makes the module look closer to Freeze than it is.
> Corrected here to **17 / 235**, and `/tmp/verify008.py` now cross-checks §0.2's own numbers against
> the identifiers actually allocated in the body, so the two cannot drift again.

> **No configuration register is declared.** `PRD-006` §10A.7a refused to register a configurable for
> which *"no allowed range has been approved"*. The same restraint applies here: **no `FEE-CFG-*`
> register exists**, because no source document approves a single default, range or authority for any
> finance configurable. Creating one would be inventing configuration ranges. See `FEE-GAP-007`.
>
> **This restraint is re-applied at v0.4 to the platform commission rate.** A **3% default** is a
> product decision, but it is a **`BC-20`** value (money *library → LIBOORA*), and the only closed
> configuration register available — frozen `PRD-002` §16.1 `LCFG-1`…`LCFG-10` — is *library*-scoped
> and contains no percentage row. **No `FEE-CFG-*` row was added and no range was invented.**
> See §42 and `FEE-GAP-014`.

---

## 1. Document Control

> **⚠ TERMINOLOGY — the approved product term is `LIBOORA PLATFORM CHARGE`, and this document is not the place it
> is defined.** The library → LIBOORA obligation that earlier revisions of this document call a *"commission"* is
> named **Platform Charge** from 2026-08-05 onward, default **3%** (₹500 collected → ₹15 charged). It is
> **defined and owned by [`PRD-022_SAAS-BILLING.md`](../saas-billing/PRD-022_SAAS-BILLING.md) `SAAS-BR-001`**, which
> became a `DRAFT` on the same day. **The transition is forward-only.** New requirements, UI strings and product
> documentation use *Platform Charge*; the v0.4–v0.8 changelog rows, `FEE-GAP-014`, `FEE-GAP-017` and `ADR-0035`
> keep their original wording, because **retroactively editing the vocabulary of a decision record destroys the
> ability to audit what was known when**. No frozen document is affected — the financial sense of *commission*
> was measured in exactly **three non-frozen** documents (this one, its alignment record, and `ADR-0035`), every
> other occurrence in the repository being the English verb.
>
> **This changes no obligation in this document, and deliberately adds no identifier.** `MP-GBR-24` still forbids
> `BC-05` from holding the charge at all — see **`FEE-XC-023`** — so renaming it here would grant this module a
> vocabulary for money it may not touch. **The term is introduced through the new PRD, which is the route the
> instruction requires, not by rewriting this one.**


| Item | Value |
|---|---|
| **Product Owner** | Product Owner — Library Domain ([`PRD_OWNERSHIP_MODEL.md`](../../00-governance/prd-ecosystem/PRD_OWNERSHIP_MODEL.md) L165) |
| **Architecture authority** | ARB / Architecture Owner (same row) |
| **Implementation owner** | Platform Engineering (same row) |
| **Roadmap position** | Wave **2.5**, after `PRD-005` and `PRD-004` ([`PRODUCT_IMPLEMENTATION_ROADMAP.md`](../../00-governance/prd-ecosystem/PRODUCT_IMPLEMENTATION_ROADMAP.md) L131), edges `E-07`, `E-09`, `E-10` |
| **Stage 3 status** | **NOT PERFORMED** |
| **Stage 4 status** | **NOT PERFORMED** |
| **Stage 5/6/7** | **NOT PERFORMED.** No traceability gate, no task file, no freeze |

---

## 2. Executive Summary

`BC-05` Fee & Collection owns one thing: **money owed by a student to the library**, and the record of
whether it was paid. Rank 4 states its scope in a single sentence — *"Owns money owed by a **student to
the library**: fee structures, dues, receipts, discounts, refunds, cash reconciliation"* (BC Map L100).

V1 is a **fee-collection and financial-record module**, not an accounting system. It has one aggregate,
`FeeLedger`, one balance rule, and an immutability guarantee inherited from Rank 1.

What makes this module unusual is not its features but its **prohibitions**. It is the only context
permitted to hold a monetary ledger; the frozen Membership PRD is explicitly forbidden from holding a
second one (`MM-XC-004`). Financial records may never be rewritten (`MP-GBR-12`). A student may never be
charged twice (BC Map L478). And the money a *student owes a library* may never share a model, table or
metric with the money a *library owes LIBOORA* (`MP-GBR-24`).

**This draft is blocked.** BC-05 has exactly **four** declared architectural edges, and **none of them
reaches a payment gateway, an offline queue, or the analytics read model.** Online payment, offline cash
capture and refunds therefore cannot be specified without governance decisions. Those are recorded as
gaps, not resolved by assumption.

---

## 3. Vision

A library owner in India should be able to state what a student owes, take the money in whatever form the
student actually has — cash at the desk, UPI on a phone — hand over a receipt that cannot later be
altered, and see at any moment who has paid and who has not, without those figures ever disagreeing with
each other or leaking to another library.

---

## 4. Goals

| ID | Goal | Source |
|---|---|---|
| `G-1` | One authoritative financial record per student per tenant | BC Map L374 `FeeLedger` *(per student)* |
| `G-2` | Fee obligations arise from membership facts, never invented locally | `E-07`, `MM-BR-003` |
| `G-3` | Collection at reception in the forms Indian students actually use | EA L1395–1398 Cash/UPI/Card (V1) |
| `G-4` | A receipt that is immutable once issued | `MP-GBR-12` |
| `G-5` | No student ever charged twice | BC Map L478, `MP-GBR-18` |
| `G-6` | Outstanding and overdue dues visible without a second ledger | BC Map L374 balance rule |
| `G-7` | Every financially sensitive act auditable | `E-20` |
| `G-8` | Absolute tenant isolation of financial data | `E-18`, `MP-GBR-24` |

---

## 5. Non-Goals (V1)

| ID | Not in V1 | Authority |
|---|---|---|
| `NG-1` | Expenses, Profit & Loss, Cash Flow | EA L824–826 **(V2)** |
| `NG-2` | Tax reports, GST, tax engine | EA L828–829 **(V3)** |
| `NG-3` | Financial forecasting | EA L830 **(Future)** |
| `NG-4` | Partial payments | EA L1400 **(V2)** — see §13.6 |
| `NG-5` | Split payments | EA L1401 **(V3)** |
| `NG-6` | Proration engine, dunning, credit/debit notes | EA L1415–1419 **(V2)** |
| `NG-7` | Revenue recognition | EA L1417 **(V3)** |
| `NG-8` | Cash reconciliation *as a reconciliation feature* | EA L827 **(V2)** — see the `NG-4`/`NG-8` note below, and §34 |
| `NG-9` | Payment retry, multiple gateways | EA L1409–1410 **(V2/V3)** |
| `NG-10` | SaaS subscription revenue | `BC-20` owns it — `MP-GBR-24` |
| `NG-11` | A general ledger, chart of accounts, journal entries, double-entry bookkeeping | **No source document contains any of these.** Inventing them would be ERP bloat |

> **`NG-4` and `NG-8` are recorded against a Rank 6 document.** EA is *descriptive only* (`MP-CON-08`).
> Where Rank 6 disagrees with Ranks 1–4, the higher rank wins. For Partial Payments and Cash
> Reconciliation **no higher-ranked document says anything at all**, so EA's tiering is the only
> evidence available and is followed. This is recorded as `FEE-GAP-008` so that the Product Owner can
> confirm rather than inherit it silently.

---

## 6. V1 Scope

### 6.1 In scope — each traced to a source

| Capability | Source | Tier |
|---|---|---|
| Fee structures | EA L822 `Fee Structures (V1)` · BC Map L100 | V1 |
| Fee obligations (`FeeDue`) | BC Map L374 · `E-07` | V1 |
| Fee collection | EA L821 `Fee Collection (V1)` | V1 |
| Cash payment | EA L1396 · BC Map L202 *"cash/UPI collected from a student at reception"* | V1 |
| UPI payment | EA L1397 · BC Map L202 | V1 |
| Card payment | EA L1398 | V1 |
| Online payment | EA L1395 | V1 — ✅ **verification obligation specified at v1.5** (`FEE-FR-028`); wire contract still open |
| Payment idempotency | EA L1399 · `MP-GBR-18` · BC Map L478 | V1 |
| Payment verification | EA L1407 | V1 — ✅ **specified at v1.5** (`FEE-FR-028`, `FEE-AC-085`…`089`) |
| Webhook reconciliation | EA L1408 | V1 — ⚠ **partly specified at v1.5**: `BC-05`'s **verification and reconciliation behaviour** is specified (`FEE-FR-028`, `FEE-AC-085`…`089`); the **wire contract** is still open and owned by the **`BC-31` owner once `PRD-019` exists** (`ADR-0040` §2/§4) |
| Invoice generation | EA L1413 | V1 |
| Receipt generation | EA L1414 | V1 |
| Discounts | EA L823 · BC Map L374 *"discount requires an authorised approver role"* | V1 |
| Financial history | BC Map L100 (implied by ledger) | V1 |
| Outstanding / overdue dues | BC Map L374 balance rule | V1 |
| Financial reports | EA L1424 `Financial Reports (V1)` | V1 — as **read models**, §22 |
| Refunds | **CONFLICT** — BC Map L100/L374/L422 vs EA L823 | V1 — ✅ **specified at v1.5, full refund only** (`FEE-FR-042`, `FEE-BR-019`, `FEE-AC-090`…`095`). ⚠ **The Rank 6 EA still reads V2 and is NOT edited here** — `MP-CON-08` makes that an **Architecture Owner** correction |
| Bank transfer | **NOT a V1 method** — Product Owner, `ADR-0043` §4 | ✅ **Out of V1 scope, decided.** Money arriving outside a supported flow **cannot become a confirmed payment** (`FEE-FR-061`, `FEE-XC-022`). *Was:* **NO SOURCE** / **⛔ BLOCKED, `FEE-GAP-003`** |

### 6.2 Requested in the brief but absent from every source

The brief asks this PRD to cover **admission fee, membership fee, renewal fee, joining/registration fee,
deposit, other approved charges**, and to check whether they are *"already approved"*.

**Measured answer: none of them is named in any source document.**

```
grep -rniE "admission fee|joining fee|registration fee|security deposit|deposit" \
     docs/30-product/ docs/10-architecture/   →  0 matches
```

What the sources *do* provide is a generic mechanism: a **fee structure** (EA L822) that raises a
**`FeeDue`** (BC Map L374) from a membership price snapshot (`MM-EVT-001` `priceSnapshot`). There is no
approved taxonomy of fee *types*.

Therefore this PRD specifies a **fee-type mechanism that is open by configuration** (§10) and **does
not enumerate admission/joining/deposit as named V1 fee types**, because doing so would be inventing
requirements. Recorded as **`FEE-GAP-004`** for the Product Owner.

> **This is a scope-preservation finding, not a scope reduction.** Nothing previously approved is being
> removed — there was never an approved fee-type list to remove. §C of the covering report states this
> explicitly.

---

## 7. Domain Ownership

### 7.1 What `BC-05` owns

| Owns | Authority |
|---|---|
| Fee structures | BC Map L100 |
| Fee obligations / dues (`FeeDue`) | BC Map L374 |
| Payments (`FeePayment`) | BC Map L202 |
| Receipts (`Receipt`) | BC Map L374 |
| Discounts (`Discount`) | BC Map L374 |
| Refund records (`RefundRecord`) | BC Map L374 — *tier disputed, `FEE-GAP-001`* |
| `Money` value object | BC Map L374 |
| Outstanding financial balance (**derived, never stored**) | BC Map L374 |
| Financial history | BC Map L100 |

### 7.2 What `BC-05` MUST NOT own

| Not owned | Owner | Edge |
|---|---|---|
| Student identity, profile, enrollment | `BC-01` (`PRD-004`, FROZEN) | `E-09` |
| Membership lifecycle, plans, entitlement conferred | `BC-02` (`PRD-005`, FROZEN) | `E-07` / `E-10` |
| Attendance and presence | `BC-03` (`PRD-006`, FROZEN) | none |
| Seat allocation and occupancy | `BC-04` (`PRD-007`, FROZEN) | none |
| Holiday calendar / branch policy | `BC-06` | `E-06` |
| Tenant record and context | `BC-19` | `E-18` |
| Entitlement checks | `BC-21` | `E-17` |
| Notification channel, template, dispatch | `BC-22` | `E-23` |
| Audit store | `BC-24` | `E-20` |
| Typed configuration values | `BC-25` | `E-19` |
| Metric definitions, read models, reports | `BC-26` | **no numbered edge** — §27 |
| Gateway credentials, vendor contracts | `BC-31` via `BC-20` | **not BC-05** — `FEE-GAP-002` |
| **LIBOORA SaaS subscription revenue** | **`BC-20`** | §9.3 |

---

## 8. Bounded Context

`BC-05` Fee & Collection · `[CORE]` · Library Management cluster · V1 · BC Map L100.

Member of the **Core Library cluster** with `BC-01`, `BC-02`, `BC-03`, `BC-04`, `BC-06`. Rank 4
[`LIBOORA_MODULE_DEPENDENCY_MATRIX.md`](../../10-architecture/LIBOORA_MODULE_DEPENDENCY_MATRIX.md) L89:
*"Only the edges `E-01`…`E-10` listed in the context map. **Enforced as an explicit allow-list, not
'anything within the cluster'**."*

Master PRD L253 explains why the cluster is not split: *"Splitting Enrollment from Membership from Fee
introduces distributed transactions across invariants that genuinely need strong consistency. **They stay
together.**"*

`FEE-BR-001` — This module **MUST NOT** create, propose or rely on any intra-cluster edge outside
`E-01`…`E-10`. *(This is the exact rule that forced `E-27`'s withdrawal under `ADR-0033`.)*

---

## 9. Architecture Boundaries

### 9.1 The four declared edges — measured, complete

```
grep -E "^\| E-[0-9]+ \|" LIBOORA_BOUNDED_CONTEXT_MAP.md | grep "BC-05"   →  4 rows
```

| Edge | Direction | Mode | Mechanism | Contract (verbatim) |
|---|---|---|---|---|
| `E-06` | `BC-06` → **`BC-05`** | `CF` | Sync port | `HolidayCalendar` for proration and freeze-day computation |
| `E-07` | `BC-02` → **`BC-05`** | `C/S` | Event | `MembershipCreated/Renewed/Upgraded/Frozen` → generates or adjusts `FeeDue` |
| `E-09` | `BC-01` → **`BC-05`** | `C/S` | Event | `StudentArchived` → Fee context asserts no outstanding dues, else blocks with a domain error |
| `E-10` | **`BC-05`** → `BC-02` | `C/S` | Event | `FeePaymentReceived` → may activate a pending membership (saga in V2, direct handler in V1) |

### 9.2 The generic capability edges — available without invention

BC Map L326–332 declare these with source *"All contexts"* or *"All write paths"*, so `BC-05` may use
them without a new numbered edge:

| Edge | Target | Use here |
|---|---|---|
| `E-17` | `BC-21` Entitlement | `check()` **before** the aggregate mutates |
| `E-18` | `BC-19` Tenancy | Ambient `TenantContext` — *"propagated, never passed as a parameter through domain methods"* |
| `E-19` | `BC-25` Configuration | Typed config accessors, *"no raw string lookups in domain code"* |
| `E-20` | `BC-24` Audit Trail | Event, *"fire-and-forget, outbox-backed"*; *"domain never calls audit synchronously"* |
| `E-23` | `BC-22` Notification | *"Domain emits **facts** … never 'send an SMS'"* |

### 9.3 `BC-05` ≠ `BC-20` — the load-bearing separation

`MP-GBR-24` (Rank 1): *"Money owed by a **student to the library** (`BC-05`) is a different concept from
money owed by a **library to LIBOORA** (`BC-20`). **They must never share a model, a table or a
metric.**"*

BC Map L202–204 makes the vocabulary collision explicit:

| Term | In `BC-05` | In `BC-20` | Distinct names |
|---|---|---|---|
| **Payment** | cash/UPI collected from a student at reception | a card charge from a library owner to LIBOORA | `FeePayment` vs `SubscriptionCharge` |
| **Plan** | (`BC-02`) a library's membership offering | LIBOORA's SaaS tier | `MembershipPlan` vs `SubscriptionPlan` |
| **Invoice** | a fee demand issued to a student | a tax invoice issued to a library | `FeeDue` vs `SubscriptionInvoice` |

`ADR-0015` (**Accepted**) exists solely because three Library PRD rows collapsed these two contexts into
one citation; it records that *"a single citation collapsing both into one range is therefore not merely
wrong, it **erases a distinction the map treats as load-bearing**."*

`FEE-BR-002` — `BC-05` **MUST** name its aggregate members `FeePayment`, `FeeDue` and `Receipt`. It
**MUST NOT** use the bare terms `Payment`, `Plan` or `Invoice` as storage or API identifiers.
`FEE-BR-003` — No table, model, projection or metric **MAY** contain both `BC-05` and `BC-20` money.
`FEE-XC-001` — Reading, writing or aggregating `BC-20` subscription revenue.
`FEE-XC-002` — Reporting a figure named "revenue" that mixes student fees and SaaS revenue
(`MP-SM-06` requires every revenue metric to state which it means).

---

## 10. Fee Structure

A **Fee Structure** is the library's definition of *what a thing costs*. It is a **template**, not a debt.

`FEE-FR-001` — A tenant **MUST** be able to define one or more fee structures.
`FEE-FR-002` — A fee structure **MUST** carry: a tenant scope, a name, a `Money` amount, a currency, an
active flag, and effective dating.
`FEE-FR-003` — A fee structure **MUST** be scoped to exactly one tenant (`E-18`).
`FEE-FR-004` — Creating, amending, activating or deactivating a fee structure **MUST** emit an audit fact
via `E-20`.
`FEE-FR-005` — A fee structure **MUST** be effective-dated. `BC-06` propagates policy change by
`policy.BranchPolicyChanged` with the note *"**effective-dated rule propagation**"* (BC Map L423), so
effective dating is the architecture's stated mechanism, not a preference.
`FEE-FR-006` — Fee-type classification **MUST** be a configurable value obtained through `E-19`, not a
hard-coded enumeration. *(Because no source approves a fee-type list — §6.2, `FEE-GAP-004`.)*

`FEE-BR-004` — A fee structure **MUST NOT** be a financial record. It creates no debt and appears in no
balance.
`FEE-INV-001` — A fee structure amount **MUST** be a non-negative `Money` in the tenant's currency.

### 10.1 Fee structure change after an obligation exists — the mutation rule

The brief asks this to be decided explicitly. It **is** decidable from Rank 1 and Rank 3 without invention.

| Evidence | Statement |
|---|---|
| `MP-GBR-12` (Rank 1) | *"Financial records are immutable."* |
| `MM-FR-027` (Rank 3, FROZEN) | *"makes the **price snapshot immutable**"* (`PRD-005` L695) |
| `MM-EVT-001` payload (Rank 3, FROZEN) | carries `priceSnapshot` — the amount is **captured at the event**, not looked up later |

`FEE-BR-005` — **A fee structure change MUST NOT alter any existing `FeeDue`.** An obligation is created
from a **snapshot** of the amount at the moment it arises and is thereafter immutable.
`FEE-BR-006` — A fee structure change **MUST** apply only to obligations raised **after** its effective
date.
`FEE-INV-002` — For any `FeeDue`, the amount **MUST** equal the snapshot taken at creation, for the whole
life of the obligation.

> **Why this is not a guess.** The frozen Membership PRD already makes the price snapshot immutable and
> already ships that snapshot inside the very event (`E-07`) that causes a `FeeDue`. A mutable
> obligation would contradict a frozen Rank 3 requirement *and* `MP-GBR-12`. There is no ambiguity to
> defer here — so no gap is raised for the **rule**. A gap **is** raised for the *correction* path a
> library needs when a genuine pricing mistake was made: see `FEE-GAP-005`.

---

## 11. Fee Obligations

A **Fee Obligation** (`FeeDue`) is *what a specific student owes*. It is a financial record.

`FEE-FR-007` — A `FeeDue` **MUST** be raised on receipt of `membership.MembershipCreated`,
`MembershipRenewed`, `MembershipUpgraded` or `MembershipFrozen` via `E-07`.
`FEE-FR-008` — A `FeeDue` **MUST** carry: `StudentRecordId` reference, tenant, `Money` amount snapshot,
currency, a due date, a status (§29.1), and the originating event reference.
`FEE-FR-009` — A `FeeDue` **MUST** be idempotent on the originating `eventId`. BC Map L449: *"Delivery:
At-least-once. Therefore **every consumer must be idempotent** — keyed on `eventId`."*
`FEE-FR-010` — On `membership.MembershipUpgraded`, dues **MUST** be **adjusted** using
`priceDifference` from the event payload, which `PRD-005` `MM-EVT-004` already supplies.
`FEE-FR-011` — This module **MUST NOT** create a `FeeDue` from its own initiative for a membership
event it did not receive. `MM-BR-003`: *"It **MUST NOT** create the `FeeDue` itself"* is the mirror
obligation on `BC-02`; the pair means `FeeDue` creation is **caused by** `E-07` and **performed by**
`BC-05`.
`FEE-FR-012` — Manual creation of a `FeeDue` by an authorised staff role **MAY** be supported for
charges that arise outside a membership event, and if supported **MUST** be audited with actor and
reason via `E-20`. **⛔ Scope of "other approved charges" is `FEE-GAP-004`.**

`FEE-XC-003` — Deriving a fee obligation from attendance, presence or seat occupancy.
`FEE-INV-003` — A `FeeDue` **MUST** belong to exactly one tenant and one student record.

### 11.1 Due dates

`FEE-FR-013` — A `FeeDue` **MUST** carry a due date.
`FEE-FR-014` — Due-date computation **MUST** consult `BC-06`'s `HolidayCalendar` through `E-06`, whose
declared purpose is *"proration and freeze-day computation"*.
`FEE-BR-007` — **✅ SPECIFIED at v1.5. The V1 due-date offset is `0` days.** The due date carried by a
`FeeDue` (`FEE-FR-013`) **is** the due date used by every rule and read model in this module; this module
**MUST NOT** apply any offset, grace period or additional calendar arithmetic to it, and **MUST NOT** derive
a due date by adding or subtracting days from the configured value. A non-zero offset or any grace period is
**out of V1 scope** and requires a **separately governed decision** before it may exist.

> **`0` chosen explicitly is not `0` defaulted silently, and that distinction is the whole reason this is
> lawful.** `PRD-006` §10A.4 requires a temporal rule to be *"not derived, inferred, or defaulted"*. The
> superseded text of this rule read verbatim: *"The due-date **rule** (offset, grace, calendar arithmetic) is
> **not specified in any source document** and **MUST NOT** be invented here. See **`FEE-GAP-006`**."* — and
> it was correct while no value had been decided. The value is now decided (`ADR-0039` §6), so the refusal is
> replaced by the stated value rather than left standing as a stale blocker.
>
> **`MP-GBR-24` holds, and this is the subtle part.** Offset `0` imports **no value** from `PRD-022`'s
> ratified **15th** settlement due day. That governs **library → LIBOORA** money (`BC-20`); this governs
> **student → library** money (`BC-05`), and Rank 1 holds the two *"must never share a model, a table or a
> metric"*. Had this rule read *"due on the 15th"* it would have been a Rank 1 violation. **It does not.**
> `PRD-022`'s 15th is **untouched**.
>
> **No configurable is created.** Because the offset is fixed at `0` and not tenant-configurable, **no
> `FEE-CFG-*` row is opened and no range is invented** — which also means Stage 4's *"every configurable has
> a default and a range"* check acquires **no new obligation** here. `FEE-GAP-007` stands unchanged.

### 11.2 Enrollment archival interaction

`FEE-FR-015` — On `StudentArchived` via `E-09`, this module **MUST** assert that the student has no
outstanding dues, and **MUST** block the archival with a **domain error** if any remain. This is the
verbatim `E-09` contract.
`FEE-INV-004` — A student **MUST NOT** be archivable while `outstanding balance > 0`.

### 11.3 Renewal protection — governance resolution, ownership, and the cross-library indicator

> **⛔ RESOLUTION RECORDED — `FEE-GAP-013` is now PARTLY RESOLVED and PARTLY BLOCKED.**
> This subsection was rewritten at **v0.3** to answer the fourteen questions put by the Governance
> Resolution request. Four of them are answered by **measurement against existing authority**, and the
> answers are binding here. The remainder are **blocked**, and the blockers are named with the exact
> authority required. **Nothing in this subsection creates a bounded context, an event, an edge, an API,
> a schema or a configuration range.** Where the honest answer is *"this cannot lawfully exist in V1"*,
> that is what is written.

#### 11.3.1 What the sources actually say — measured, not assumed

| Probe | Result |
|---|---|
| `grep -rniE "renewal.protect\|protection period\|protection window"` over `docs/` | **0 occurrences** — the concept is **unsourced** |
| Nearest existing concept | **Grace period** — BC Map L101: `BC-06` Library Policy owns *"working hours, holidays, attendance rules, seat rules, **grace periods**. The rule **source**; other contexts are rule **consumers**"* |
| Is its length decided? | **No.** `Q-01` / `MM-GAP-001` **OPEN**. Master PRD L673 *"Open — recommendation: configurable, default 24h"*. BC Map L540 scopes it to *"`BC-02`→`BC-04` event handler semantics"* and recommends *"Configurable per tenant (BC-25), default 24h grace"* |
| Frozen `PRD-005` `MM-FR-111` | *"V1 **MUST NOT** implement a grace period that extends entitlement beyond `endDate`"*; §7.4 adds *"A recommendation inside an open question is not a decision"* |
| EA L1368 `Grace Periods (V2)` | Sits under **Entitlement Service** (`BC-21`, SaaS quota) — **a different concept**, not student membership. EA is **Rank 6, descriptive only** |
| Cross-library membership tier | `Multiple Library Memberships` **V2** (EA L911); `Cross Library Membership` **Future** (EA L735); `Membership History` **V2** (EA L734) |
| Cross-tenant read edge for membership status | **None exists.** `E-13` (`BC-01`→`BC-10`, `ACL`) is *"**the only bridge between the two worlds**"* and carries *identity core fields*. `BC-10` *"stores **no** `StudentRecordId` and **no** `tenantId`"* |

#### 11.3.2 Requirement 1 — ownership of the policy. **RESOLVED by measurement.**

The request asked whether the policy belongs to `BC-06`, `BC-02`, or another existing context. It is
**not one owner — it is three, split by the kind of thing being owned**, and every one of the three is an
*existing* context. No new context is proposed.

| Concern | Owner | Basis (measured) |
|---|---|---|
| **Does a protection window exist, and how long is it?** — the *rule* | **`BC-06` Library Policy** | BC Map L101 — `BC-06` owns grace periods and is *"the rule **source**"* |
| **The document that specifies `BC-06`** | **`PRD-002` Library Management**, `FROZEN` v1.1 | `PRD_REGISTRY.md` **L422**: `` | `BC-06` | `PRD-002` | No | `` — uncontested |
| **Membership term arithmetic** — applying any window to a term | **`BC-02` Membership** *(`PRD-005`, `FROZEN` v1.4)* | BC Map L97 — *"the commercial right-to-use: which plan a student holds, **for what term**"* |
| **Seat consequences of expiry** | **`BC-04` Seating** | `MM-FR-112`; `SEAT-FR-155`; `ADR-0019` L310 assigns `Q-01` to *"Architecture + `BC-04` owner"* |
| **Money** — obligations, receipts, ledger | **`BC-05`** — this PRD | BC Map L100 |
| **Protection *usage history*** | **`BC-02`** | It is a membership-lifecycle fact; `MM-FR-084` already records `renewedFromMembershipId` on the membership |
| **Cross-library read projection** | **⛔ UNOWNED — no context, no edge, no PRD** | `FEE-GAP-013(c)` |

**Therefore `BC-05` is not the owner of any part of the renewal-protection policy.** It is a *consumer* of
whatever `BC-02` decides. `FEE-XC-018` and `FEE-XC-020` make that refusal explicit rather than implied.

> **Why this is a resolution and not a deferral.** The request's own phrasing — *"BC-06, BC-02, or another
> existing bounded context"* — presumes a single owner. The measured architecture already splits *rule
> source* from *rule consumer* at BC Map L101, and that split is the answer: `BC-06` owns whether a window
> exists and how long it is; `BC-02` owns what a window does to a term. Naming one owner for both would
> collapse a separation the BC Map states explicitly.

#### 11.3.3 Requirement 2 — the exact V1 rule. **CANNOT BE ISSUED FROM THIS PRD.**

The request asks for: *protection window = 3 days by default*; *configurable by the policy owner only if
existing architecture permits*; *example due date 5 Aug → protection until 8 Aug*.

**`BC-05` cannot issue this rule, and no existing authority supplies it.** The measured position:

| Element of the requested rule | Measured status |
|---|---|
| A protection window exists at all | **⛔ Unsourced** — 0 occurrences repo-wide. The nearest concept's existence question, `Q-01`, is **OPEN** |
| Default = **3 days** | **⛔ Conflicts with the only recorded recommendation.** BC Map L540 and Master PRD L673 both recommend **24h**, not 3 days — and even that is *"Open"*, and `PRD-005` §7.4 states a recommendation inside an open question *"is not a decision"* |
| It extends entitlement past `endDate` | **⛔ Directly forbidden in V1** by frozen `MM-FR-111` |
| Configurable by the policy owner | **⛔ No register permits it.** `BC-06`'s configurables are `PRD-002` §16.1 `LCFG-1`…`LCFG-10` — an exactly-enumerated table stating *"Values are configurable; their **ranges and invariants are not**"*. **There is no protection-window row, and `PRD-002` is `FROZEN`.** `BC-25`/`E-19` supply the *typed accessor mechanism*, not permission to invent a value |
| Example *"5 Aug → 8 Aug"* | Cannot be normative here — it presupposes every row above |

**`E-19` does not help.** BC Map L328: `E-19` gives *"Typed config accessors; no raw string lookups in
domain code."* That is **how** a configured value is read, not authority that a given value **exists**.
Adding a `FEE-CFG-*` row for a protection window would be *"creating a configuration range without
authoritative support"* — exactly what requirement 11 forbids, and the same restraint §0.2 already applies
in refusing to open a `FEE-CFG-*` register at all.

> **The worked example is the clearest demonstration of the blocker.** *"Due date 5 Aug → protection until
> 8 Aug"* means entitlement, or seat, or both, survive past 5 Aug. Under frozen `MM-FR-111` a V1 membership
> confers nothing after `endDate`; under `MM-BR-032` an `Expired` membership *"**MUST NOT** be treated as
> active entitlement."* So the example cannot be implemented in V1 by any module — not by `BC-02`, and
> certainly not by `BC-05`. Writing it here as a normative rule would create a specification that frozen
> Rank 3 text forbids. Routed as **`FEE-GAP-013(a)`**.

#### 11.3.4 Requirement 3 — deducting the 3 protected days. **⛔ BLOCKED — frozen Rank 3 conflict.**

The request states the protected days *"are deducted from the NEW membership duration, according to the
approved membership policy."* **Measured: there is no approved membership policy that permits this, and
three frozen requirements forbid it.** This is the single hardest finding in this resolution, and it is
reported as a conflict rather than absorbed.

| Frozen authority (`PRD-005` v1.4, Rank 3) | Exact text | Effect on requirement 3 |
|---|---|---|
| **`MM-FR-086`** | *"The new `endDate` **MUST** be computed from the new `startDate` by §4.3, using the **target plan's current** `durationDays`."* | A renewal term is the plan's **full** duration. There is no subtrahend |
| **`MM-FR-057`** | *"`endDate` **MUST** be computed as `startDate + (durationDays − 1)` days"* | The formula is closed. `− 3` is not in it |
| **`MM-FR-058`** | *"The computation **MUST** be a **pure function** of (`startDate`, `durationDays`, tenant timezone). It **MUST NOT** depend on the current clock, on holidays, or on the working calendar."* | A deduction derived from *when* the student renewed makes `endDate` depend on the clock and on prior history — **which this requirement forbids** |
| **`MM-FR-057a`** | *"**The single permitted re-derivation, and the only one.**"* — delayed-payment activation, `MM-CFG-009`, and even then *"the computation itself **MUST** remain the pure function `MM-FR-058` requires"* | Enumerates **one** exception, and this is not it. *"Moving `endDate` while holding `startDate` fixed **MUST** be impossible"* |
| **`MM-XC-012`** | *"Proration arithmetic executed as money (**V2**; and `Q-06` is open — see `MM-GAP-002`)"* | Reducing a term by days already consumed **is** proration. It is **V2**, and its ownership question `Q-06` is **OPEN** |
| **`MM-FR-100`** | *"This module **MUST NOT** compute a prorated monetary credit for the source membership's unused days"* | The mirror-image arithmetic is already prohibited |

**Conclusion.** Requirement 3's deduction is a **term-shortening proration rule**. It is (i) not present in
the approved membership policy, (ii) contradicted by `MM-FR-086` and `MM-FR-058`, and (iii) classified
**V2** with an **open** ownership question (`Q-06` / `MM-GAP-002`). Under `MP-CON-08` a disagreement with a
higher-ranked document is *"a **defect to be raised**, not a choice to be made."* `PRD-008` therefore
**raises it** and does not specify it. Routed as **`FEE-GAP-013(f)`**, owner **`BC-02` owner + Product
Owner + Architecture Owner**, authority **REQUIRES AN ADR AMENDING FROZEN `PRD-005`**.

`FEE-XC-020` already forbids `BC-05` from determining, shortening or extending a membership's duration, so
**no `FEE-*` requirement changes as a result of requirement 3.** What changes is that the conflict is now
recorded with its exact citations instead of being silently unaddressed.

> **Why `BC-05` must not "help" here.** A tempting shortcut is to leave the term alone and instead charge
> 3 days less — the student experiences the same net effect. That is forbidden twice over: `FEE-FR-059`
> requires the amount to come solely from the originating `E-07` `priceSnapshot`, and frozen `MM-FR-088`
> requires the renewal amount to be *"the target plan's **current** price … **MUST NOT** be copied from the
> source membership's snapshot."* Simulating a duration change through money would put term policy in the
> finance module — precisely the confusion `FEE-XC-020` exists to prevent.

#### 11.3.5 Requirement 4 — non-renewal. **RESOLVED on the financial side.**

Requirement 4 — protection expires, no permanent penalty, a future membership gets its full configured
duration, and *"the old 3-day usage must never automatically deduct from a membership months later"* — is
**already fully satisfied** by frozen authority plus this PRD's prohibitions, and needs no new rule:

- **Full future duration** is guaranteed by `MM-FR-086` (target plan's **current** `durationDays`) and
  `MM-FR-081` (renewal from `Expired` permitted *"without limit of elapsed time"*). It is `BC-02`'s
  guarantee, not `BC-05`'s (`FEE-XC-020`).
- **No months-later deduction** is guaranteed financially by `FEE-FR-059` + `FEE-BR-026`, and verified by
  `FEE-AC-078`, which requires the later amount to be **bit-identical** to the amount computed with no
  prior usage at all.
- **No permanent penalty** is guaranteed by `FEE-BR-026` and `FEE-XC-021`.

**Requirements 3 and 4 are mutually consistent only because requirement 3 is blocked.** Were requirement 3
implemented as written, a *"deducted"* term and requirement 4's *"full configured duration"* would be two
different arithmetic rules distinguished only by elapsed time — which is exactly the clock dependency
`MM-FR-058` forbids. This is recorded in `FEE-GAP-013(f)` as a reason the deduction needs an ADR rather
than an implementation.

#### 11.3.6 Requirement 5 — voluntary departure vs. remaining. **PARTLY RESOLVED.**

The distinction the request asks to preserve is **already the frozen model**, for the leaving case:

| Case | Existing authority | Financial consequence in `BC-05` |
|---|---|---|
| Student **voluntarily leaves before** the due date | `MM-FR-079` — voiding *"**MUST NOT** be extended to an `Active` membership"*; Membership Cancellation with refund is **V2** (`MM-XC-011`). The term therefore runs to `endDate` and expires normally via `MM-EVT-005` | **Obligations already raised stand.** `MP-GBR-12` — financial records are immutable; a reversal is a compensating entry, never a mutation. Refund is `FEE-GAP-001` |
| Student **remains and requests** renewal protection | **⛔ No authority exists** — the request path, the approval, and the window are all unsourced (§11.3.1) | Nothing to specify: no `FeeDue` amount changes either way (`FEE-FR-059`) |
| Seat consequence, either case | `MM-FR-112` + `SEAT-FR-155` — the allocation is **flagged**, not auto-released, and release timing *"awaits the `Q-01` grace decision"* | Out of scope — `FEE-XC-004` |

**So half of requirement 5 is already true and needs no new rule; the other half is blocked because the
"requests protection" path does not exist.** Note that `PRD-007` L846 independently records that its
two-valued field *"cannot represent a student who is inside an approved grace period"* — a second module
confirming that no approved grace state exists to represent. Routed as **`FEE-GAP-013(g)`**.

#### 11.3.7 Requirements 6, 7 and 8 — the cross-library indicator. **⛔ BLOCKED. RECOMMENDATION: NOT V1.**

The request asks me to resolve the `ID-2` / `ID-3` conflict explicitly, to prefer a minimal `PersonId`-based
status projection *"if and only if governance approves it"*, and — if no lawful path exists — to say so and
recommend V1, V2 or removal. **The measured answer is that no lawful path exists in V1, and the blocker is
stronger than `ID-2`/`ID-3` alone.**

**The four barriers, in ascending order of severity:**

**1. `ID-2` — and it is CI-enforced, not merely written.**
> *"`StudentRecordId` **never** leaves its tenant. It must not appear in any Global Student context, event
> or index."*

Enforcement is a *"Cross-tenant leak test suite"*, and `tool/module_dependencies.yaml` L216–218 bans the
literal symbol in `domain/person` with the comment *"Rule ID-2 — a tenant identifier must never enter a
global context."* A `StudentRecordId`-keyed projection is therefore rejected by a **gate that already
exists**, not by a reviewer's opinion. **`ID-2` is respected in full: nothing proposed here carries a
`StudentRecordId`.**

**2. `ID-3` — the previous-library name is precisely the forbidden field.**
> *"Global and social contexts (BC-10→17) key exclusively on `PersonId`. They **must not be able to resolve
> which library a person attends** unless the person explicitly published it."*

The requested indicator's example includes *"Previous library"*. That field **is** the resolution `ID-3`
forbids. The request itself says *"unless an authoritative privacy rule explicitly permits it"* — **measured
answer: no source permits it, and one source forbids it in the strongest available form.**

**3. `SID-4.19` — a *capability* prohibition, which the `PersonId` proposal cannot satisfy.** This is the
decisive finding, and it is stronger than `ID-3`:
> `SID-4.19` — *"This module **SHALL NOT** answer, and **SHALL NOT** be capable of answering, 'which
> libraries does this person attend?'"*

`SID-INV-8` and `SID-1.38` make the reference direction **downward only** — the identity *"holds no
collection"* of Student Records. `SID-INT-12` lists *"Holding a collection of organisations or Student
Records"* as an integrity violation. **A `PersonId`-keyed membership-status projection is a
`PersonId → {membership status at some library}` map. Even with the library name omitted and no
`StudentRecordId` present, a non-empty result discloses that this person is enrolled *somewhere*, and a
result readable by Library B while Library B has no enrollment discloses enrollment *elsewhere*.** That
makes `BC-10` *capable of answering* the forbidden question — which `SID-4.19` prohibits as a **capability**,
not merely as an exposed field. The request's preferred option is therefore **not lawful as stated**, and
saying so is the honest answer rather than proposing it and hoping review catches the flaw.

Reinforcing this, `SID-4.22` forbids `BC-10` from *"stor[ing], mirror[ing], summaris[ing] or becom[ing] the
authority for **membership plan or status**"*; `SID-5.8` lists **`membership state`** among fields that
*"**SHALL NEVER** exist as a stored field of this module"*; `SID-4.23` forbids re-keying `BC-02`…`BC-05` on
`PersonId` and forbids `BC-10` from *"request[ing] that they be"*; and `SXC-6`/`SID-INV-7` place membership
state outside `BC-10` entirely.

**4. No registered edge — and inventing one is the highest-severity failure mode named in the architecture.**
BC Map §7 governs: *"If an edge is not in this table, it does not exist"* — needs an ADR. There is **no**
`BC-02`→`BC-10` edge and **no** cross-tenant membership read edge; `BC-05`'s only edges are `E-06`, `E-07`,
`E-09`, `E-10`. BC Map L510 calls a cross-tenant leak via a capability context *"**the single
highest-severity failure mode in the entire architecture**."* Tier evidence agrees: `Multiple Library
Memberships` **V2**, `Cross Library Membership` **Future**.

**Resolution of the `ID-2`/`ID-3` conflict, stated explicitly as requirement 7 asks:**

| Option | Verdict | Reason |
|---|---|---|
| Key the indicator on `StudentRecordId` | **⛔ REJECTED — unlawful** | `ID-2`, CI-enforced by `banned_symbols` |
| Key it on `PersonId`, include previous-library name | **⛔ REJECTED — unlawful** | `ID-3` + `SID-4.19` + `SID-5.8` |
| Key it on `PersonId`, **omit** library name, minimum disclosure | **⛔ NOT APPROVABLE AS DESIGNED** | Still makes `BC-10` *capable* of answering the forbidden question — `SID-4.19`, `SID-INV-8`, `SID-INT-12`, `SID-4.22`. Also still requires an unregistered edge |
| Build nothing cross-library in V1 | ✅ **RECOMMENDED** | Costs no capability `BC-05` owns, and preserves tenant isolation |

**Recommendation, as requirement 8 demands a choice: the cross-library indicator is NOT V1.** It is a
**V2 candidate**, consistent with the tier the Enterprise Architecture already records for `Multiple
Library Memberships` (V2) and `Membership History` (V2). It **should not be silently removed** either,
because the underlying product need is legitimate; it should be **registered as V2 and specified only after
an ADR** by the authorities named in `FEE-GAP-013`. If a V2 design is pursued, the measured constraint is
that the projection cannot live in `BC-10` as `PRD-003` is written — so the ADR must either place it in a
**new authorised context with explicit person consent** (the `ID-3` *"unless the person explicitly
published it"* carve-out is the only lawful door in the current text) or amend `SID-4.19`, which is a
privacy-critical requirement of an `IMPLEMENTING` PRD and therefore a Security decision, not an
architecture convenience.

> **Why "explicit person consent" is named as the only door, and is still not a design.** `ID-3` contains
> exactly one exception — *"unless the person explicitly published it."* That makes consent the only
> mechanism in the current text under which any library-attendance fact may cross a boundary. Naming the
> door is not the same as opening it: a consent-based disclosure needs a consent record owner (`BC-18` per
> `ID-6`), a lawful basis, a revocation path, and a registered edge — **none of which exist**, and none of
> which this PRD may create. It is recorded so the V2 discussion starts from the one lawful option rather
> than re-deriving it.

#### 11.3.8 What `BC-05` does specify — unchanged at v0.3, and re-verified

The financial rules below were introduced at v0.2 and are **re-affirmed unchanged** by this resolution:
`FEE-FR-059` (a new obligation is priced solely from its own `E-07` `priceSnapshot`), `FEE-BR-026` (no
financial penalty persists beyond the membership it arose on), `FEE-BR-027` (a renewal inside a window
carries no adverse marker), `FEE-XC-018` (not the system of record for protection history), `FEE-XC-019`
(no cross-tenant financial disclosure, **unconditional**), `FEE-XC-020` (no duration authority) and
`FEE-XC-021` (**no risk score, fraud score, trust score, blacklist, watchlist, cross-library punishment, or
*cheater*/*fraud*/*abuser*/*high risk* label**).

**Requirement 6's prohibitions are satisfied without approval and hold regardless of how `FEE-GAP-013`
is later decided.** `FEE-XC-019` is explicitly unconditional: it holds *even if* a cross-library
membership-status read is one day authorised. `FEE-XC-021` is likewise unconditional, and note that
`BC-13` **Trust & Safety** already exists for abuse handling — so even a legitimate future need would not
land in `BC-05`.

`FEE-FR-059` — *(text unchanged; see the register in §29)* — is re-verified against `MM-FR-088`,
`MM-FR-084` and `MM-FR-081`, all of which remain in force at `PRD-005` v1.4.

#### 11.3.9 Disposition of all fourteen requirements

| # | Requirement | Disposition | Where |
|---|---|---|---|
| 1 | Which BC owns the policy | ✅ **RESOLVED** — `BC-06` owns the rule (via `FROZEN` `PRD-002`, registry L422); `BC-02` owns term effect; `BC-04` owns seat effect; `BC-05` owns none of it | §11.3.2 |
| 2 | Exact V1 rule, 3-day default, configurable | ⛔ **BLOCKED** — unsourced; conflicts with the recorded 24h recommendation, which is itself open; `MM-FR-111` forbids V1 entitlement extension; no configurable row exists and `PRD-002` §16.1 is `FROZEN` | §11.3.3, `FEE-GAP-013(a)` |
| 3 | Deduct 3 protected days from the new term | ⛔ **BLOCKED — frozen conflict** — `MM-FR-086`, `MM-FR-057`, `MM-FR-058`, `MM-FR-057a`, `MM-XC-012` (**V2**, `Q-06` open) | §11.3.4, `FEE-GAP-013(f)` |
| 4 | Non-renewal: no penalty, full future duration | ✅ **RESOLVED** — financially by `FEE-FR-059`, `FEE-BR-026`, `FEE-AC-078`; duration by `MM-FR-086`/`MM-FR-081` at `BC-02` | §11.3.5 |
| 5 | Voluntary-leave vs. remain distinction | ⚠️ **PARTLY RESOLVED** — the leaving case is the frozen model (`MM-FR-079`, `MM-XC-011`); the *"requests protection"* path is unsourced | §11.3.6, `FEE-GAP-013(g)` |
| 6 | Minimum indicator; never expose payments/notes; no fraud score | ✅ **SPECIFIED AS PROHIBITIONS** — `FEE-XC-019`, `FEE-XC-021`, both unconditional | §11.3.8 |
| 7 | Resolve `ID-2`/`ID-3`; prefer `PersonId` projection iff approved | ✅ **RESOLVED AS "NOT APPROVABLE AS DESIGNED"** — `ID-2` CI-enforced; `ID-3` forbids the library name; **`SID-4.19` forbids the *capability***, which the `PersonId` option cannot satisfy | §11.3.7 |
| 8 | If no lawful path, record blocker + authority + V1/V2/removed | ✅ **RESOLVED** — blocker recorded; **recommendation: V2, not V1, not removed** | §11.3.7, `FEE-GAP-013` |
| 9 | No silent frozen edits | ✅ **HONOURED** — 0 files changed under `membership-management/`, `library/`, `student-identity/`, `seat-management/`, `10-architecture/`, `00-governance/` | §41 |
| 10 | No ADR without authority | ✅ **HONOURED** — no ADR authored; four are *required* and named | `FEE-GAP-013` |
| 11 | No new events/edges/APIs/schemas/config ranges | ✅ **HONOURED** — 3 `fee.*` events unchanged; 4 edges unchanged; **no `FEE-CFG-*` register**, and §11.3.3 explains why one was refused | §0.2, §9.1, §26 |
| 12 | Update only genuinely supported decisions | ✅ **HONOURED** — the two resolutions added (§11.3.2, §11.3.5) rest on `PRD_REGISTRY.md` L422, BC Map L101 and frozen `MM-FR-086`/`MM-FR-081`; **no `FEE-*` requirement was added or altered at v0.3** | §41 |
| 13 | Re-run gates and traceability | ✅ **DONE** — see the covering report | — |
| 14 | Report Stage 3 eligibility | ✅ **REPORTED** — see the covering report §K | — |

#### 11.3.10 What remains blocked, and to whom it is routed

| Blocked item | Exact blocker | Authority required |
|---|---|---|
| A protection window exists; its length; its configurability | `Q-01`/`MM-GAP-001` **OPEN**; `MM-FR-111`; `PRD-002` §16.1 `LCFG-1`…`10` is a closed table in a `FROZEN` PRD | **Product Owner** + **`BC-06` owner (`PRD-002`)** — an ADR amending `FROZEN` `PRD-002` |
| Deducting protected days from a new term | `MM-FR-086`, `MM-FR-058`, `MM-FR-057a`; `MM-XC-012` **V2**; `Q-06`/`MM-GAP-002` **OPEN** | **`BC-02` owner** + Product Owner + Architecture Owner — an ADR amending `FROZEN` `PRD-005` |
| Storing protection-usage history | `BC-02` `FROZEN` v1.4 with no such field; `Membership History` EA-**V2** | **`BC-02` owner** — post-freeze ADR |
| Library B reads any status signal | No registered edge (BC Map §7 *"if an edge is not in this table, it does not exist"*); BC Map L510 | **Architecture Owner** |
| Indicator keyed on `PersonId`, name omitted | **`SID-4.19`** capability prohibition; `SID-INV-8`, `SID-INT-12`, `SID-4.22`, `SID-5.8`, `SID-4.23` | **Security + Privacy** + **`BC-10` owner (`PRD-003`)** |
| Indicator naming the previous library | **`ID-3`**, whose only exception is explicit publication by the person | **Security + Privacy**; consent record owner is `BC-18` (`ID-6`) |
| *"Full configured duration"* as a guarantee | Not `BC-05`'s (`FEE-XC-020`); it is `MM-FR-086`'s | **`BC-02` owner** — already satisfied, recorded for completeness |

**No frozen document was modified.** `PRD-002` v1.1 (`BC-06`), `PRD-005` v1.4 (`BC-02`), `PRD-004` v1.2
(`BC-01`) and `PRD-007` v1.1 (`BC-04`) are `FROZEN`; `PRD-003` (`BC-10`) is `IMPLEMENTING` and Rank 3
frozen. Four distinct ADRs by four distinct owners would be required to build the feature as requested,
and **none has been authored here**, because requirement 10 forbids accepting an ADR without its authority.

---

## 12. Invoices

`FEE-FR-016` — An invoice **MUST** represent a **demand for payment issued to a student**. BC Map L204
names this concept `FeeDue` in `BC-05`.
`FEE-FR-017` — An invoice **MUST** be immutable once issued (`MP-GBR-12`).
`FEE-FR-018` — Cancelling an invoice **MUST** be recorded as a state transition (§29.3), never as a
deletion.
`FEE-BR-008` — **Invoice ≠ Payment.** An issued invoice moves no money and **MUST NOT** change the
ledger balance except as a due.

> **Terminology caution, recorded rather than resolved.** BC Map L204 treats *"Invoice"* in `BC-05` as
> **`FeeDue`** — i.e. the demand *is* the obligation. EA L1413 lists *"Invoice Generation (V1)"* as a
> separate capability from receipts. This draft treats the invoice as the **issued representation of a
> `FeeDue`** and does **not** create a second aggregate, because BC Map §8 L374 lists exactly five
> members of `FeeLedger` and *"Invoice"* is **not** among them. Recorded as **`FEE-GAP-009`**.

---

## 13. Payments

A **Payment** (`FeePayment`) is *money actually received*.

`FEE-FR-019` — A payment **MUST** carry: tenant, `StudentRecordId` reference, `Money` amount, currency,
method, an idempotency key, a status (§29.2), the recording actor, and a timestamp.
`FEE-FR-020` — A payment **MUST** be linked to the obligation(s) it settles.
`FEE-FR-021` — A payment **MUST NOT** be editable after it reaches a confirmed state (`MP-GBR-12`).
`FEE-BR-009` — **Payment ≠ Receipt.** The payment is the money event; the receipt is the issued proof
(§16).

### 13.1 Cash

`FEE-FR-022` — Cash payment **MUST** be recordable by an authorised staff role at reception (BC Map L202).
`FEE-FR-023` — A cash payment **MUST** record the collecting actor identity.
`FEE-BR-010` — A cash payment is **verified at the moment of recording** — there is no external
authority to confirm it. Its trustworthiness rests on the actor identity and the audit record, not on a
verification callback.

### 13.2 UPI

`FEE-FR-024` — UPI payment **MUST** be supported (EA L1397, BC Map L202).
`FEE-BR-011` — Where UPI is collected **out of band** (student pays to a library UPI handle and staff
records it), the record is a **staff-attested** payment and **MUST** be treated as `FEE-BR-010` does for
cash, including the actor identity and audit fact. Where UPI is collected **through the platform**, it is
an online payment and §14 applies. **⛔ Which of the two V1 supports is `FEE-GAP-002`.**

### 13.3 Card

`FEE-FR-025` — Card payment **MUST** be supported (EA L1398).
`FEE-BR-012` — A card payment executed through a gateway is an online payment; §14 applies.
**⛔ `FEE-GAP-002`.**

### 13.4 Bank transfer

✅ **DECIDED — bank transfer is NOT a V1 payment method** (Product Owner, `ADR-0043` §4). It is
**explicitly out of V1 scope**, and this section specifies **nothing** for it.

**What happens when money arrives anyway is already answered, by obligations this PRD carries — no new
rule was written for it.** A NEFT/IMPS credit landing in the library’s bank account is **out-of-band
money**. It **cannot automatically become a confirmed payment**: financial confirmation is
**server-authoritative** (**`FEE-FR-061`**, **`FEE-XC-022`**), staff-attested recording is governed by
`FEE-BR-011`/`FEE-BR-014` and tested by **`FEE-AC-081`**/**`FEE-AC-082`**, and `ACCEPTED` **`ADR-0037`**
bars any offline financial write. **So the lawful V1 behaviour is determined: such a credit is not a
payment, and no supported flow lets staff make it one.**

⚠ **No `FEE-XC-*` exclusion was minted for this, and that restraint is deliberate** — a twenty-fourth
`FEE-XC-*` would change §0.2’s declared register and the checker’s arithmetic to record a scope decision
that the existing obligations already enforce.

*(Superseded text retained verbatim: **⛔ BLOCKED.** Bank transfer is named in **no** source document — not
the BC Map, not the Master PRD, not the EA capability tree, not any frozen PRD. The brief lists it among
features to check as *"already approved"*; measurement says it is **not**. Specifying it would be inventing
a requirement. Recorded as **`FEE-GAP-003`**.)*

### 13.5 Online payment

See §14 and §15. **⛔ partly BLOCKED by `FEE-GAP-002`.**

### 13.6 Partial payments — V2, and therefore absent

EA L1400 tiers *"Partial Payments"* at **(V2)**. No higher-ranked document mentions them at all.

`FEE-XC-004` — Accepting, modelling, storing or displaying a partial settlement of a `FeeDue` in V1.
`FEE-BR-013` — In V1 a `FeeDue` is settled **in full or not at all**. There is **no** `PARTIALLY_PAID`
status, and §29.1 deliberately does not contain one.

> The brief instructs: *"If Partial Payment is V2, do NOT create V1 partial-payment semantics."* That is
> exactly what is done. Note the consequence, stated plainly rather than hidden: **a library that takes
> ₹500 against a ₹2000 due has no V1-legal way to record it.** That is a real product limitation
> flowing from a Rank 6 tiering; it is surfaced in `FEE-GAP-008` so the Product Owner can decide with
> full sight of the cost.

---

## 14. Payment Verification

`FEE-FR-026` — A payment **MUST NOT** be treated as financially successful on the strength of a
client-side success signal alone.
`FEE-BR-014` — Client-side success is a **hint**, never a financial fact. The authoritative confirmation
**MUST** come from the payment rails.
`FEE-FR-027` — Until confirmation arrives, a payment **MUST** remain in `PENDING` (§29.2) and **MUST NOT**
settle a `FeeDue`, generate a receipt, or emit `FEE-EVT-002`.

`FEE-BR-015` — A **visible reconciliation queue MUST exist** for payments whose rail state and ledger
state disagree. This is not invention: BC Map L465 mandates for the V1 fee/membership flow *"a **visible
reconciliation queue for failures** — deliberately not hidden behind a fake atomic button"*, and frozen
`MM-BR-004` requires the same queue on the membership side.

### 14.1 ⚠ Webhook / gateway reconciliation — `BC-05`'s obligation SPECIFIED at v1.5; the wire contract remains open *(heading superseded, retained verbatim: it read "⛔ Webhook / gateway reconciliation — BLOCKED")*

EA L1408 lists *"Webhook Reconciliation (V1)"*. **The architecture gives `BC-05` a lawful *route* to
gateway capability, but names no context at the far end of it.** Re-measured at v0.6 — the two
halves are separated below, because conflating them produced the wrong verdict twice:

| Fact | Measurement |
|---|---|
| `E-25` Integration edge | `BC-20` Billing → `BC-31` Integration — **source is `BC-20`, not `BC-05`** (BC Map L334) |
| Edges from `BC-05` to `BC-31` | **0** |
| `D-14` in `PRD_DEPENDENCY_GRAPH.md` L116 | *"`PRD-008`/`PRD-020` → `PRD-019` `BC-31` Integration, `API`, **`E-25`**"* — asserts `PRD-008` uses `E-25` |
| Rank 4 Dependency Matrix L167 | `LIBRARY MANAGEMENT → INTEGRATION` = **`✖`** — *"The domain must not know that Razorpay … exist. Integration is reached only via BUSINESS (payments) or COMMUNICATION"* |
| Rank 4 violation `X-03` L352 | *"Just call Razorpay from the payment service"* → *"Call `business.payment_intent` port"* |

**(a) The transport is authorised — this is settled.** Dependency Matrix **§6** is *"the **normative
form** — what the lint rule checks"*, and **L196** declares `business.payment_intent` in
`library_management`'s `may_use_ports`. `BC-05` **is** a `library_management` context (BC Map L100).
**L167** forbids the direct route and names this one; `X-03` **L352** prescribes it by name; the matrix
cell `LIB → BUS` is **`◇` (port, permitted)** against `→ INT` = `✖`, verified by mechanical 19/19 column
alignment; and Accepted **`ADR-0012` L86** already tabulates this dependency as *"Already a declared
port? **Yes — `:entitlement`, `:payment_intent`**"*.

**The absence of a numbered edge is not a defect here.** Accepted **`ADR-0033`** held that BC Map L292
*"**governs edges**… It does **not** state that every cross-context read must be an edge."* Measured:
**14 of `library_management`'s 17 declared ports have no usable numbered edge** — including
`identity.policy_decision`, the authorisation port every context must call, and
`platform_services.files` / `search.indexer`, whose edges `E-22` / `E-21` exist but **do not list
`BC-05`** among their consumers. Requiring one here would invalidate thirteen other lawful dependencies.

**(b) The counterparty is undeclared — this still blocks.** The port has an **approved caller and no
declared callee**. `platform/business` holds exactly `BC-20` and `BC-21`; `BC-21` owns only limits and
gates; and **`MP-GBR-24` (Rank 1)** bars `BC-20` — *"money owed by a **library to LIBOORA**"* — from
student money, the exact conflation Accepted `ADR-0015` was written to correct. `PaymentIntent` appears
**0 times** in the whole of `docs/`. **No context owns student-payment execution.**

**(c) `D-14` mis-attributes `E-25`.** `E-25` is `BC-20` → `BC-31`; `PRD-008` owns `BC-05`, so it cannot
be a party to it. `PRD_DEPENDENCY_GRAPH.md`'s own header calls it *"**Derived. Non-normative.** … This
document **adds no edge of its own**"* — so the citation is **stale, not authoritative**. Correction is
recommended in `ADR-0035` `D-3` and **not executed here**.

All three are recorded in **`ADR-0035`, which is `PROPOSED` and binds nothing.**

`FEE-PO-001` — Online payment execution **MUST** be reached through a port to the Business Platform, and
**MUST NOT** call a gateway or hold a gateway credential.
`FEE-XC-005` — Holding, reading or transmitting a payment-gateway credential.
`FEE-XC-006` — Naming a payment vendor in domain code, an event payload, a table or an API contract.
`FEE-FR-028` — **✅ SPECIFIED at v1.5 — as `BC-05`'s verification obligation, NOT as a wire contract.**
On receipt of any inbound payment notification, this module **MUST** treat it as **evidence to be verified,
never as an instruction to be obeyed** (`FEE-BR-014`), and **MUST**:
(a) leave the payment in `PENDING` until **this module's own server-side verification** succeeds
(`FEE-BR-016`);
(b) settle **no** obligation, issue **no** receipt and publish **no** `fee.FeePaymentReceived` on the
strength of the inbound message alone (`FEE-FR-027`, `FEE-EVT-002`);
(c) yield **exactly one** confirmed payment however many times the same notification is delivered, enforced
by the existing idempotency and gateway-reference uniqueness invariant (`FEE-INV-005`);
(d) create **nothing** for a notification that matches no known payment, and instead surface it in the
**reconciliation queue** (`FEE-FR-032`, `FEE-BR-015`).
Ingress is owned by **`platform/business`** per **`ACCEPTED` `ADR-0035` §5.5b**, **upheld** by
**`ACCEPTED` `ADR-0040` §1**.

> **⛔ WHAT THIS REQUIREMENT STILL DOES NOT SPECIFY, AND WHY THAT IS CORRECT RATHER THAN INCOMPLETE.**
> It names **no endpoint, URL or route · no payload schema or field name · no signature algorithm or header ·
> no replay window · no retry policy · no provider.** `ADR-0040` §2 established **by measurement** that
> **no document may currently author them**: `PRD-022`'s own **`SAAS-XC-006`** (L157-158) excludes `BC-20`
> from *"naming a payment provider, endpoint, **webhook schema**, signature algorithm, retry policy"*;
> **`PRD-019`**, the PRD of `BC-31` which `SAAS-XC-006` names as the owner of vendor knowledge, is
> **`PLANNED` and does not exist** (`PRD_REGISTRY.md` L309); this document forbids itself the same at
> **§14.1**; and `ADR-0035` §5.5b forbids *"invent[ing] an endpoint/schema"*. **What is specified above is
> `BC-05`'s own behaviour, which `ADR-0035` §5.5b expressly left with `BC-05`** — *"`BC-05` keeps payment
> intent, the **verification obligation** and student financial truth"*. The wire contract remains open,
> owned by the **`BC-31` owner once `PRD-019` exists** (`FEE-GAP-002`, contract limb).

> **No webhook schema, no provider contract and no endpoint is written in this document**, because the
> brief forbids inventing them and no source supplies them. EA L1405 names *"Razorpay (V1)"* — but only
> inside the **BUSINESS PLATFORM** capability tree, and Master PRD L232 records Payments as *"`BC-20` via
> `BC-31`"* with the gateway *"**Not named in EA** — candidate only"*. Two Rank 6/Rank 1 statements
> disagree about whether a vendor is chosen. `FEE-GAP-010` records it; this PRD names no vendor.

---

## 15. Payment Idempotency

This is one of the few areas where the sources are complete and unambiguous.

| Authority | Statement |
|---|---|
| `MP-GBR-18` (Rank 1) | *"Payment capture is **idempotent by gateway reference**."* |
| BC Map L478 (Rank 4) | Risk *"Duplicate payment capture"* — *"**Charging a student twice is unrecoverable trust damage**"* → control: *"**Idempotency key at API edge + gateway reference uniqueness + reconciliation job**"* |
| `MP-RSK-04` (Rank 1) | *"DB constraints, pessimistic locks, idempotency keys, reconciliation"* |
| `MM-BR-005` (Rank 3, FROZEN) | *"Duplicate payment capture protection **MUST** rely on the gateway reference uniqueness and idempotency key … **Enforcement of the payment side is `BC-05`'s**"* |

`FEE-FR-029` — Every payment-recording operation **MUST** accept an idempotency key at the API edge.
`FEE-FR-030` — A repeated request with the same idempotency key **MUST** return the original result and
**MUST NOT** create a second payment, a second receipt or a second `FEE-EVT-002`.
`FEE-FR-031` — For rail-executed payments, the **gateway reference MUST be unique** and enforced as such.
`FEE-FR-032` — A reconciliation job **MUST** exist to detect and surface duplicate or orphaned captures.
`FEE-INV-005` — For a given tenant, **no two confirmed payments MAY share an idempotency key**; and no
two **MAY** share a gateway reference.
`FEE-BR-016` — Enforcement of payment-side duplicate protection is **this module's responsibility**, as
frozen `MM-BR-005` explicitly assigns it here.

### 15.1 Snapshot immutability of a confirmed payment *(added v0.4)*

`FEE-FR-060` — When a payment is recorded `CONFIRMED`, the financial record **MUST** preserve, as an
**immutable snapshot**, the gross amount, the transaction reference, the confirming actor, the payment
method and the confirmation timestamp. These values **MUST NOT** be recomputed from inputs that may
later change.
`FEE-INV-010` — A `CONFIRMED` financial record's snapshot fields **MUST NOT** change for any reason,
including a later change to any configuration value, at platform level or library level.
`FEE-BR-028` — A configuration change **MUST** apply only to transactions confirmed **after** it takes
effect. Retroactive application to an already-confirmed transaction is prohibited.

> **These three extend a principle this module already holds**, rather than introducing a new one:
> `FEE-INV-002` already fixes a `FeeDue` amount to its creation snapshot *"for life"* and `FEE-INV-006`
> already forbids an issued receipt from changing. `FEE-FR-060` states the same discipline for the
> **payment** record, and `FEE-BR-028` states the *non-retroactivity* that the Master Product decision
> requires of a rate change.
>
> **What `FEE-FR-060` deliberately does NOT include: a commission rate, a gateway charge or a tax
> line.** All three are money *library → LIBOORA* or a V3 concern, and `MP-GBR-24` (**Rank 1**) forbids
> `BC-05` and `BC-20` sharing *"a model, a table or a metric"*. Adding a commission column to a
> `BC-05` record would perform that merger **in the schema**, which is where it matters, not merely in a
> report. See §42 and `FEE-GAP-014`.

---

## 16. Receipts

`FEE-FR-033` — A receipt **MUST** be generated for a confirmed payment (EA L1414).
`FEE-FR-034` — A receipt **MUST** be **immutable once issued**. This is `MP-GBR-12` *and* the BC Map
`FeeLedger` invariant *"receipt is immutable once issued"* — stated twice, at Rank 1 and Rank 4.
`FEE-FR-035` — A receipt **MUST** identify: tenant, student record, amount, currency, method, payment
reference, issue timestamp, and issuing actor.
`FEE-FR-036` — A receipt **MUST NOT** be issued for a `PENDING` payment.
`FEE-FR-037` — Correction of an issued receipt **MUST** be effected by a **compensating record**, never
by editing or deleting (`MP-GBR-12`).
`FEE-INV-006` — A receipt, once issued, **MUST NOT** change in any field, ever.
`FEE-XC-007` — Updating or deleting an issued receipt.

### 16.1 Receipt states

Per the brief: *"define only states supported by authoritative sources."* The sources support exactly one
positive state and no lifecycle beyond it — see §29.4.

---

### 16.1 Unbundled student-facing breakdown *(added v0.4)*

`FEE-FR-062` — Where a payment breakdown is shown to a student, **each component this module owns**
— the membership/fee amount, any discount applied, and the amount paid — **MUST** be itemised
separately and **MUST NOT** be collapsed into a single undifferentiated charge.

> **Scope limit, stated rather than left implicit.** `BC-05` may itemise only the components it owns.
> A **platform commission** line, a **gateway/provider charge** line and a **tax/GST** line are
> **not** among them: the first two are `BC-20`'s (BC Map L129 gives `BC-20` the gateway) and tax is
> **V3** (`NG-2`, EA L828–829). This module therefore **MUST NOT** display, compute or store them,
> and `FEE-AC-083` verifies their **absence**. No percentage, rate or formula is invented here.

---

## 17. Discounts

`FEE-FR-038` — A discount **MUST** be applicable to a `FeeDue` before settlement.
`FEE-FR-039` — A discount **MUST** require an **authorised approver role**. BC Map L374 states it as a
`FeeLedger` invariant: *"discount requires an authorised approver role"*.
`FEE-FR-040` — A discount **MUST** record: the approver identity, the reason, the original amount, the
discount amount, and the resulting payable.
`FEE-FR-041` — Applying a discount **MUST** emit an audit fact via `E-20`.
`FEE-INV-007` — A discount **MUST NOT** exceed the original amount, and the final payable **MUST NOT**
be negative.

### 17.1 The discount arithmetic — stated, not invented

```
Original Amount  −  Discount  =  Final Payable  →  Payment settles Final Payable
```

`FEE-BR-017` — The discount **MUST NOT** mutate the original `FeeDue` amount. The original amount, the
discount and the payable **MUST** all remain independently visible, because `MP-GBR-12` forbids rewriting
a financial record and an audit trail that cannot show *what changed* is not an audit trail.

`FEE-BR-018` — **No maximum discount percentage, ceiling or range is specified**, because no source
document approves one. Inventing one is explicitly forbidden by the brief and by the `PRD-006`
precedent. The **authorised approver role** is the control the architecture actually names. Recorded as
**`FEE-GAP-007`**.

---

## 18. Refunds / Corrections

### 18.1 ✅ Refund tier — DECIDED V1 and SPECIFIED at v1.5 *(heading superseded, retained verbatim: it read "⛔ Refund tier — BLOCKED, `FEE-GAP-001`")*

**The sources conflict, and this PRD does not choose.**

| Rank | Document | Line | Says |
|---|---|---|---|
| **1** | Master PRD `MP-GBR-12` | L353 | *"a refund is a **compensating entry, never a mutation**"* — defines refund semantics as a **global rule** |
| **4** | BC Map — context | L100 | `BC-05` *"Owns … refunds"*, in a row whose Release column reads **V1** |
| **4** | BC Map — aggregate | L374 | `FeeLedger` members include **`RefundRecord`**; invariant *"**refund ≤ received**"* |
| **4** | BC Map — events | L422 | `BC-05` publishes **`fee.RefundIssued`** → `BC-26`, `BC-24` |
| **3** | `PRD-005` FROZEN | L942 | *"surfaced in the reconciliation queue **for a refund decision by `BC-05`**"* — a frozen PRD depends on BC-05 making refund decisions |
| **6** | EA capability tree | L823 | **`Refunds (V2)`** |
| **6** | EA capability tree | L1409 | **`Refund Management (V2)`** |

**Impact if resolved as V1:** three requirements and a state transition must be written, plus
`FEE-EVT-003`.
**Impact if resolved as V2:** `fee.RefundIssued` must be marked V2 in the BC Map's own event table, and
frozen `PRD-005` L942's expectation of *"a refund decision by `BC-05`"* has **no V1 counterpart** —
which is a cross-PRD hole, not a tidy deferral.

**Authority: Product Owner (tier) — ✅ GIVEN, recorded in `ADR-0039` §3. Architecture Owner (EA correction)
— ⛔ STILL REQUIRED.** *Superseded text retained verbatim:* **"Authority required: Product Owner (tier) +
Architecture Owner (BC Map event table). Blocks Stage 4. Blocks Freeze."*

⚠ **A correction to that superseded line, made rather than inherited:** it named the *"BC Map event table"* as
the artefact needing an Architecture Owner. **Re-measured, the BC Map is already correct** — **L422** publishes
`fee.RefundIssued` and **L374** carries `RefundRecord` with *"refund ≤ received"*, both consistent with V1. **It
is the Rank 6 EA (L823/L1409) that disagrees**, and `MP-CON-08` requires the **EA** to be corrected to match
the higher rank, *"never the reverse"*. **No BC Map amendment is required or requested; the BC Map is
byte-unchanged.**

Accordingly:

`FEE-FR-042` — **✅ SPECIFIED at v1.5.** A refund **MUST** be recorded as a **separate financial
operation** against a **`CONFIRMED`** payment only, and **MUST** be **full** — equal to the confirmed
amount received. This module **MUST NOT** record a refund against a `PENDING`, `FAILED` or `CANCELLED`
payment, **MUST NOT** alter the original payment or receipt in any way, and **MUST** record actor, reason
and timestamp. A **cash** refund is recorded by the **same server-authoritative path** as any other; there
is **no** offline refund write, queue or sync (`ACCEPTED` `ADR-0037`; `FEE-FR-061`, `FEE-XC-022`).
`FEE-BR-019` — **A refund MUST be a compensating entry, never a mutation** (`MP-GBR-12`), and **MUST NOT**
exceed the amount received (`refund ≤ received`, BC Map L374). **V1 supports full refund only:** a refund
amount **MUST** equal the confirmed payment amount, and any lesser amount **MUST** be rejected.

> **This rule was stated *conditionally* until v1.4 and is now unconditional.** The superseded text read
> verbatim: *"**If** refunds are V1, a refund **MUST** be a **compensating entry, never a mutation**
> (`MP-GBR-12`), and **MUST NOT** exceed the amount received (`refund ≤ received`, BC Map L374). *This rule
> is stated conditionally so that no reader mistakes it for an approved V1 obligation.*"* The condition is
> discharged because the **tier is decided** (`ADR-0039` §3, upheld as product scope), so the hedge that
> protected the reader from mistaking a conditional for an obligation now **obscures** an obligation instead.
>
> **Why "full refund only" is a restriction and not a gap.** Partial refund is **proration arithmetic**, and
> frozen **`MM-XC-012`** places proration at **V2**. Rejecting a lesser amount therefore **avoids colliding
> with a frozen V2 boundary** rather than deferring a decision — and `FEE-XC-008` already forbids
> implementing refund as an edit or deletion *"under any tier"*.
>
> ⚠ **The Rank 6 EA still reads `Refunds (V2)` at L823/L1409, and that disagreement is NOT resolved here.**
> `MP-CON-08` requires **the EA** to be corrected to match the higher-ranked BC Map, *"never the reverse"* —
> an **Architecture Owner** act. This PRD states the Rank 4 position it is bound by and **raises** the
> defect; it does not edit the EA. See `FEE-GAP-001`, whose Architecture-Owner limb remains open.
`FEE-XC-008` — Implementing refund as an edit or deletion of a payment or receipt, under any tier.

### 18.2 Corrections and adjustments

`FEE-FR-043` — A correction to a financial record **MUST** be an **append-only compensating record**
carrying actor, timestamp and reason.
`FEE-FR-044` — A correction **MUST NOT** alter or remove the record it corrects.
`FEE-BR-020` — The correction model is the one the architecture already uses: `BC-03`'s aggregate row
(BC Map L372) specifies *"corrections are append-only with actor + reason"*, and `MP-GBR-12` forbids
in-place edits — its own changelog notes that v1.0's *"except through approved workflows"* was *"a
loophole that permits in-place edits"* and was **removed**.
`FEE-INV-008` — The financial history of a student **MUST** be append-only.

> **A pricing-mistake correction path is NOT specified.** §10.1 makes obligations immutable; a library
> that entered ₹2000 instead of ₹1200 needs *some* legal route. Cancel-and-reissue is the obvious
> candidate but **no source document authorises it**, so it is recorded as **`FEE-GAP-005`** rather than
> invented.

---

## 19. Student Financial Profile

`FEE-FR-045` — A student's financial profile **MUST** be composed at read time from the `FeeLedger`.
`FEE-FR-046` — It **MUST** expose: obligations with status, payments with status, receipts, discounts,
and the derived outstanding balance.
`FEE-BR-021` — The profile **MUST NOT** be a stored aggregate of balances. BC Map L374: the balance is
*"**never stored independently**"*.
`FEE-XC-009` — Storing a materialised per-student balance as authoritative state.
`FEE-XC-010` — Holding student identity attributes. Identity is `BC-01`'s (`PRD-004`, FROZEN); this
module holds a **`StudentRecordId` reference only**, the same discipline `PRD-006` §19 applies.

---

## 20. Outstanding Dues

`FEE-FR-047` — Outstanding balance **MUST** be **derived** as `Σ dues − Σ receipts`.
`FEE-INV-009` — `balance = Σ dues − Σ receipts`, and it **MUST NOT** be stored independently. *(BC Map
L374, verbatim; also the reason `MM-XC-004` forbids `BC-02` from holding a second ledger.)*
`FEE-FR-048` — Overdue **MUST** be determined by comparing a `DUE` obligation's due date to the current
date — a **predicate over recorded facts**, not a stored flag written by a timer.
`FEE-BR-022` — No scheduled job **MAY** be the authority for overdue status. *(This mirrors the frozen
`PRD-006` §10A.4 discipline: *"**No server timer implements this rule**"* — the state is a predicate over
observations. Applying the same principle here keeps the ledger recomputable.)*

> Whether `OVERDUE` is additionally **persisted** as a status value for query performance is an
> implementation choice; §29.1 lists it as a status because the brief names it, and `FEE-FR-048` fixes
> its **meaning** as derived. If persistence is chosen it **MUST** be recomputable and **MUST NOT**
> disagree with the predicate.

---

## 21. Financial History

`FEE-FR-049` — A complete, append-only financial history **MUST** be available per student per tenant.
`FEE-FR-050` — History **MUST** show obligations, payments, receipts, discounts and corrections with
actor and timestamp.
`FEE-FR-051` — History **MUST NOT** be editable or deletable.
`FEE-XC-011` — Purging or rewriting financial history. **Retention is not defined by any source
document** and **MUST NOT** be invented — recorded as **`FEE-GAP-011`**.

---

## 22. Revenue Dashboard / Reports

`FEE-FR-052` — `BC-05` **MUST** expose financial **facts**. It **MUST NOT** own metric definitions.
`FEE-BR-023` — `MP-GBR-36` (Rank 1): *"**No dashboard may define its own metric formula.** All metrics
come from the Metric (Semantic) Layer as Certified Metrics."* `BC-26` owns *"the metric/semantic layer,
read-model store, projections, reports, exports"* (BC Map L135).
`FEE-XC-012` — Defining, computing or publishing a certified metric.
`FEE-XC-013` — Building a reporting store inside `BC-05`.

### 22.1 The V1 reports the brief asks about — and where each belongs

| Report | Facts owned by `BC-05` | Metric/read model |
|---|---|---|
| Today's collection | payments with timestamps | `BC-26` |
| Date-range collection | payments with timestamps | `BC-26` |
| Collection by payment method | payment `method` field | `BC-26` |
| Collection by fee type | obligation fee-type value | `BC-26` |
| Outstanding dues | dues − receipts (derived) | `BC-26` |
| Overdue dues | due-date predicate | `BC-26` |
| Student financial history | **`BC-05` — owned directly** (§21) | not a metric |

`FEE-BR-024` — Any report named "revenue" **MUST** state whether it means `BC-05` student fees or
`BC-20` SaaS revenue (`MP-SM-06`, `MP-GBR-24`).

> ✅ **The `Financial Reports` tier conflict is Rank 6 INTERNAL and is not a `BC-05` question — resolved
> one rank above the conflict, not arbitrated inside it** (`ADR-0043` §8.3). The EA disagrees with itself:
> **L814** `Financial Reports (V2)` under the Owner Dashboard, **L1423** `Financial Reports (V1)` at LAYER
> 4. **Both lines are Rank 6**, so `MP-CON-08` has no ranks to compare — which is why `ADR-0042` called it
> structurally unarbitrable. **The rule that settles it is one rank up:** Rank 6 is **descriptive only**
> (`MP-CON-08`, Rank 1 MASTER_PRD **L519**; `DOCUMENTATION_BASELINE.md` §4 **L221**), so **a Rank 6 tier
> label cannot create a deliverable for anyone**. And **no Rank 1– 5 document gives `BC-05` a report
> deliverable at all**: BC Map **L135** gives `BC-26` *"the metric/semantic layer, read-model store,
> projections, **reports**, exports"*; BC Map **L100** gives `BC-05` fee structures, dues, receipts,
> discounts, refunds and cash reconciliation — **no reports**. **This draft therefore claims no report as a
> V1 deliverable of `BC-05`; it delivers facts** — unchanged, and now on a stated rule rather than a
> preference. ⚠ **The EA is byte-unchanged and no tier was chosen for the dashboard owner.** The Rank 6
> self-disagreement is a **defect**, raised per `DOCUMENTATION_BASELINE.md` **L224** (*"a conflict is a
> defect … do not choose — raise it"*) as **`Q-A7`** against the Architecture Owner. ⚠ **A citation defect
> of this document is disclosed rather than quietly repaired:** the superseded text below read *"L1424"*;
> the node is at **L1423**. *Superseded text retained verbatim:* **`Financial Reports` is tiered twice in
> EA and the two disagree** — L814 `Financial Reports (V2)` under Dashboards, L1424 `Financial Reports
> (V1)` under Business Platform. This draft claims **no report as a V1 deliverable of `BC-05`**; it
> delivers **facts**. The tier conflict belongs to whoever owns the dashboard, and is recorded as
> **`FEE-GAP-012`**.

---

## 23. Roles & Permissions

The role vocabulary is **fixed** by Master PRD §6 L105–111 and **MUST NOT** be extended
(`ATT-FR-118` set this precedent for `BC-03`).

| Role | Enum | Master PRD description (verbatim, L107–111) |
|---|---|---|
| Library Owner | `owner` | *"Complete business control."* |
| Manager | `manager` | *"Daily operations management."* |
| Reception Staff | `reception` | *"Student onboarding, attendance, memberships, seat allocation and support."* |
| Student | `student` | *"Attendance, membership, profile, AI assistant, notifications and self-service."* |
| Parent | `parent` | *"Attendance visibility, **fee updates** and important notifications."* |

### 23.1 Financial permissions — least privilege

| Operation | Role(s) | Basis |
|---|---|---|
| Define / amend fee structure | `owner` | *"Complete business control"*; pricing is a business act |
| Approve discount | **`owner` — sole approver by default.** `manager` has **NO approval access by default**; the `owner` may **explicitly grant** it, per-library, through the **existing** scope-bearing grant mechanism. **No new permission identifier, and no new role.** | BC Map L374 *"authorised approver role"*; Master PRD **§6.1** — `MP-GBR-20` (grants are scope-bearing), `MP-GBR-21` (scope register **closed**: `self` · `guardianOf` · `tenantWide`), `MP-GBR-23` (independent per-library grants); `ADR-0043` §5 |
| Record cash / UPI / card payment at desk | `reception`, `manager` | Reception's stated duties incl. memberships and support |
| Issue receipt | `reception`, `manager` | Follows from recording |
| Record correction / adjustment | `owner`, `manager` — **⛔ `FEE-GAP-005`** | Correction is a supervisory act |
| Refund decision | **⛔ BLOCKED — `FEE-GAP-001`** | `PRD-005` L942 assigns the *decision* to `BC-05` |
| View own financial history | `student` (self only) | *"self-service"* |
| View guarded student's fee updates | `parent` (scoped to guarded students) | L111 verbatim, incl. *"fee updates"* |
| View tenant financial facts | `owner`, `manager` | Operations |

`FEE-FR-053` — Every financial write **MUST** be authorised against the acting role **and** tenant scope.
`FEE-FR-054` — A `student` **MUST NOT** be able to record, confirm, discount, correct or refund any
payment. Self-service is **read**, plus initiating an online payment **if** `FEE-GAP-002` permits one.
`FEE-FR-055` — A `parent`'s access **MUST** be limited to **fee updates for guarded students only**, per
`guardianOf` scoping.
`FEE-XC-014` — Creating any new role, or granting a financial capability by dashboard visibility.

> **Dashboard access ≠ financial permission**, as the brief requires. Master PRD L113 states RBAC is
> *"extended with attribute-based scoping"*; visibility of a screen confers nothing.

---

## 24. Audit

`FEE-FR-056` — Financially sensitive acts **MUST** emit an audit fact via `E-20` — *"Event
(fire-and-forget, outbox-backed)"*, and *"Domain never calls audit synchronously"* (BC Map L329).

Auditable acts: fee-structure create/amend/activate/deactivate · obligation raise/adjust/cancel ·
discount approval · payment record · payment confirmation · payment failure · receipt issue · correction ·
refund *(if V1)* · any permission-sensitive financial action.

`FEE-PO-002` — `E-20` to `BC-24`. `BC-05` **MUST NOT** hold an audit store.
`FEE-XC-015` — Storing audit records locally, or making an audit write synchronous or blocking.

> `PRD_DEPENDENCY_GRAPH.md` L109 records `D-09` as **Unsatisfied** with *"`X-10` audit-mutation check
> **not implemented**"*. So audit obligations here are **specified but not yet enforceable** — stated
> rather than assumed, per `SID-4.56`: *"a rule that cannot be checked SHALL be treated as unmet."*

---

## 25. Security & Tenant Isolation

`FEE-FR-057` — Every financial record **MUST** carry `tenantId`, obtained from ambient `TenantContext`
via `E-18` — *"propagated, never passed as a parameter through domain methods"* (BC Map L327).
`FEE-INV-003` *(restated)* — one tenant, one student record, per obligation.
`FEE-FR-058` — A query, projection, export or report **MUST NOT** return financial data across tenants.
`FEE-PO-003` — `E-18` ambient tenancy. A consumer processing an event *"without establishing tenant
context must **fail loudly, not default**"* (BC Map L451).
`FEE-XC-016` — Any cross-tenant financial read, write, aggregate or export.

**No cryptographic implementation detail is specified** — no algorithm, key length, token format or
hashing scheme — because no source document supplies one for this context and the brief forbids
inventing them.

---

## 26. Notifications

`FEE-PO-004` — `E-23` to `BC-22`: *"Domain emits **facts** … never 'send an SMS'"*.

Financial facts available for consumption, **each traced to the BC Map's own event table**:

| ID | Fact | Event | BC Map consumers (L420–422) |
|---|---|---|---|
| `FEE-EVT-001` | A due was raised | `fee.FeeDueRaised` | `BC-22`, `BC-26`, `BC-28` — *"Reminder + revenue analytics"* |
| `FEE-EVT-002` | A payment was received | `fee.FeePaymentReceived` | `BC-02`, `BC-26`, `BC-24`, `BC-22` |
| `FEE-EVT-003` | A refund was issued | `fee.RefundIssued` | `BC-26`, `BC-24` — **⛔ tier disputed, `FEE-GAP-001`** |

The three events are **normative register entries**, not prose:

`FEE-EVT-001` — `BC-05` **MUST** publish `fee.FeeDueRaised` when an obligation is created, through the
transactional outbox (`FEE-PO-008`), carrying tenant, student reference, amount and due date. Verified by
`FEE-AC-062`, `FEE-AC-065`.

`FEE-EVT-002` — `BC-05` **MUST** publish `fee.FeePaymentReceived` **only** when a payment reaches
`CONFIRMED` (§29.2). It **MUST NOT** be published for a `PENDING` payment (`FEE-AC-034`) and **MUST NOT**
be published twice for one idempotency key (`FEE-AC-039`). This is the event `E-10` carries to `BC-02`.
Verified by `FEE-AC-034`, `FEE-AC-039`, `FEE-AC-062`.

`FEE-EVT-003` — **✅ BEHAVIOUR SPECIFIED at v1.5; payload still NOT specified.** `fee.RefundIssued`
**MUST** be published **only** after a refund has been recorded per `FEE-FR-042`, **MUST NOT** be published
for a refund that was rejected or never recorded, and **MUST NOT** be published more than once for one
recorded refund. It is published to **`BC-26`, `BC-24`** exactly as BC Map **L422** already declares — **no
new consumer, edge or event is introduced.**

> **Its payload remains unspecified, deliberately.** The superseded text read verbatim: *"**⛔ BLOCKED.**
> `fee.RefundIssued` appears in the BC Map's `BC-05` row (L422), but its release tier is disputed
> (`FEE-GAP-001`). Its payload is **not** specified here. Verified by `FEE-AC-062` only (the count
> constraint), deliberately not by a behavioural criterion."* **The tier half is discharged** — refund is V1
> product scope (`ADR-0039` §3) — so a **behavioural** criterion is now honest where before it would have
> been fabricated. **The payload half is not discharged:** no source specifies event field lists for
> `BC-05`'s events, and inventing one would be exactly the schema invention this document refuses at §14.1.
> **This is a deliberate partial specification, and it is labelled as one rather than presented as
> complete.**

`FEE-BR-025`*(reserved — see note)* — **not allocated.** *Due reminder* and *overdue* notifications, and
a *payment failed* notification, are **not** backed by any event in the BC Map's `BC-05` row. The brief
lists them as candidates *"only if supported by authoritative sources"*; they are **not**. No fourth,
fifth or sixth `fee.*` event is created here.

> **Exactly three `fee.*` events exist.** This mirrors the frozen `PRD-006` discipline of *"exactly four
> attendance events … no fifth event"*. A *"payment failed"* notification would require a new event and
> therefore an ADR and a BC Map amendment — neither exists.

`FEE-XC-017` — Publishing a fourth `fee.*` event. *(Allocated in v0.2; was reserved at v0.1.)*

---

## 27. Analytics Boundary

`FEE-PO-005` — Analytics consumes `fee.*` events. **There is no numbered edge from `BC-05` to `BC-26`** —
measured: `grep "^| E-[0-9]* |" | grep BC-26` returns only `E-26` (`BC-27` AI → `BC-26`).

`BC-26` appears as a **consumer** in BC Map §9's event table (L420–422) but has no `E-*` edge from
`BC-05` in §7. Frozen `PRD-005` hit exactly this and refused to paper over it: its header says
*"**`BC-26` Analytics is deliberately not listed**; see `MM-BR-035` and `MM-GAP-010`"*.

This PRD follows that precedent: `BC-26` is **not** listed in the *Publishes to* header row, and the
tension is recorded as part of **`FEE-GAP-012`** for the Architecture Owner. No edge is invented.

---

## 28. Offline / Reliability

### 28.1 ⛔ Offline financial write — BLOCKED, `FEE-GAP-002`(b)

| Fact | Measurement |
|---|---|
| `E-24` Offline Sync edge | **`BC-03` Attendance** → `BC-30` (BC Map L333) — *"Attendance defines the conflict-resolution policy; Sync executes it"* |
| Edges from `BC-05` to `BC-30` | **0** |
| `D-13` dependency row | `PRD-006` → `PRD-018` `BC-30`, *"Both unwritten"* |

`BC-05` has **no declared offline write path**. The brief is explicit: *"Do NOT invent an offline
financial write strategy."*

*(`FEE-FR-059` and `FEE-BR-026` were placeholders in v0.1; both are allocated in v0.2 — see §11.3.)*

Instead, two obligations that need **no** new architecture:

`FEE-FR-061` — A **cash** payment **MUST NOT** reach `CONFIRMED` except by a **server-side** recording of
an authorised staff action. Where connectivity is absent, the collection attempt **MUST** yield **no**
confirmed financial record, **no** receipt and **no** membership activation.
`FEE-XC-022` — Creating, queueing, mirroring or synchronising **any** financial write while offline.
`FEE-XC-023` — Recording, holding, reducing or reconciling a **library → LIBOORA commission
settlement** in any `BC-05` model, table, projection, receipt or metric — including netting one
against a `FeeDue`, a `FeePayment`, a `Receipt` amount, the `FeeLedger` balance or any
student-revenue figure.

> **`FEE-XC-023` is the reconciliation rule stated as a prohibition, which is the only form `BC-05` may
> lawfully state it in.** A settlement of the platform's commission **reduces the library's `BC-20`
> obligation and nothing else.** It **MUST NOT** reduce a student's fee obligation, a student's payment
> amount, a receipt amount, the library's student-revenue figure or the `FeeLedger` balance — because a
> student who paid ₹500 in cash paid the **library** ₹500, and the library's later remittance of ₹15 to
> LIBOORA changes nothing about that student's money. Stating this as an **exclusion** rather than a
> requirement is deliberate: a requirement would make `BC-05` a **participant** in settlement
> reconciliation, which `MP-GBR-24` forbids. `BC-05`'s whole duty here is to **stay out**, and to keep
> emitting the confirmed-payment fact (`fee.FeePaymentReceived`) that a settlement may be computed *from*.
> **The 3% never enters `FeePayment`** — `FEE-FR-060` carries no commission field and `FEE-AC-083`
> verifies its absence.

> `FEE-FR-061` makes explicit, for cash, what `FEE-BR-010` already implies by verifying a cash payment
> *"at the moment of recording"*, and it is stated as an **exclusion** (`FEE-XC-022`) rather than a
> configurable so that an offline mode cannot be switched on later without amending this register.
> It is consistent with the architecture rather than merely with intent: **`E-24` grants the
> offline-sync edge to `BC-03` Attendance only** (BC Map L333), and `BC-05` has no such edge
> (`FEE-GAP-002`(b)).

`FEE-PO-006` — Online payment **MUST NOT** be treated as successful because the device is offline or the
confirmation could not be fetched. Absence of confirmation is **not** confirmation. *(This is the direct
analogue of frozen `PRD-006`'s rule that absence of observation is never evidence of an exit.)*
`FEE-PO-007` — Where a payment's outcome is unknown, it **MUST** remain `PENDING` and **MUST** appear in
the reconciliation queue (`FEE-BR-015`).

**Offline cash collection is recorded as an open gap, routed to the Architecture Owner** — the brief's
instruction for precisely this case.

---

## 29. Financial State Machines

Canonical. Each state is listed **only** where a source supports it.

### 29.1 `FeeDue` (Fee Obligation)

| State | Meaning | Entered from | Source |
|---|---|---|---|
| `DUE` | Owed, not yet past due date | creation via `E-07` | Brief; BC Map `FeeDue` |
| `OVERDUE` | `DUE` and due date has passed | `DUE` | Brief; derived per `FEE-FR-048` |
| `PAID` | Settled in full | `DUE`, `OVERDUE` | Brief; balance rule |
| `CANCELLED` | Withdrawn without payment | `DUE`, `OVERDUE` | Brief |

**Transitions:** `DUE → OVERDUE` (date predicate) · `DUE → PAID` · `OVERDUE → PAID` · `DUE → CANCELLED` ·
`OVERDUE → CANCELLED`.
**Forbidden:** `PAID → DUE` · `PAID → OVERDUE` · `PAID → CANCELLED` · `CANCELLED → *` · any transition
that rewrites the amount (`FEE-INV-002`).
**No `PARTIALLY_PAID` state exists** (§13.6).

### 29.2 `FeePayment`

| State | Meaning | Source |
|---|---|---|
| `PENDING` | Recorded, not yet financially confirmed | Brief; `FEE-FR-027` |
| `CONFIRMED` | Financially authoritative | Brief |
| `FAILED` | Rail or process declined it | Brief |
| `CANCELLED` | Abandoned before confirmation | Brief |

**Transitions:** `PENDING → CONFIRMED` · `PENDING → FAILED` · `PENDING → CANCELLED`.
**Forbidden:** `CONFIRMED → *` (immutability, `MP-GBR-12`) · `FAILED → CONFIRMED` (a new payment is
required) · any edit of a `CONFIRMED` payment.
**Cash note:** a cash payment enters `CONFIRMED` directly at recording (`FEE-BR-010`); it has no external
rail to wait for.

### 29.3 Invoice — a document projection, NOT a state machine

✅ **Invoice has NO state machine of its own** (Architecture Owner, `ADR-0043` §6). The invoice is the
**issued/document representation of a `FeeDue`** — not a distinct aggregate, not a sixth `FeeLedger` member,
and **not a second financial state machine**. **Financial truth lives in §29.1’s `FeeDue` machine plus
confirmed payments, and nowhere else.**

**The three labels below are therefore a *projection* of §29.1, not states.** They are what a reader of an
issued document sees; the authoritative value is always the underlying `FeeDue` state:

| Document label | Projected from the authoritative `FeeDue` state (§29.1) | Source |
|---|---|---|
| `ISSUED` | **`DUE`** — or **`OVERDUE`** once the due date passes. **Both project to `ISSUED`; the label
does not distinguish them, and `OVERDUE` is not lost — it is read from the `FeeDue`.** | Projection of
§29.1; BC Map **L204** (*Invoice ≡ `FeeDue`*) |
| `PAID` | **`PAID`** | Projection of §29.1 |
| `CANCELLED` | **`CANCELLED`** | Projection of §29.1; `FEE-FR-018` |

**No transition is defined here.** A document projection cannot transition: **every** state change happens on
the `FeeDue` in §29.1, under that section’s transitions, its forbidden list and **`FEE-INV-002`**. **There is
no `PARTIALLY_PAID` label**, because §29.1 has no such state (**L1392**).

**Document-integrity rules, re-attributed rather than deleted.** Editing an `ISSUED` invoice, deleting any
invoice, and `PAID → ISSUED` all remain **forbidden** — but as **document-integrity consequences of §29.1’s
forbidden transitions and the immutability of financial records**, *not* as a rule set belonging to an
independent Invoice machine. **`PAID → ISSUED` is impossible because §29.1 forbids leaving `PAID`**, not
because a second machine also says so.

> ⚠ **What this correction did and did not do** (`ADR-0043` §6). It **removed a second state machine from
the page** — the defect `FEE-GAP-009`’s `Freeze` field actually named. It **did not** create, delete,
rename or renumber any identifier: **no state value, aggregate, requirement, invariant or exclusion moved**,
and §0.2’s registers are unchanged. `FeeLedger` still has **five** members (BC Map **L374**), and Invoice is
still **not** one of them. ⚠ **A citation defect is disclosed rather than quietly repaired:** the superseded
text cited *"EA L1413"* for `ISSUED`; **EA is Rank 6 and descriptive**, so it could not have been the source
of a state in any case — the authority is Rank 4 BC Map **L204** and §29.1 above. The stale citation is
reported to the document owner, not silently corrected in place.

*(Superseded text retained verbatim: **| `ISSUED` | Demand issued to the student | Brief; EA L1413 | `PAID` |
Settled | Brief | `CANCELLED` | Withdrawn | Brief; `FEE-FR-018` |** — **Forbidden:** editing an `ISSUED`
invoice; deleting any invoice; `PAID → ISSUED`. *(See §12's note: the invoice is the issued representation
of a `FeeDue`, not a sixth `FeeLedger` member — `FEE-GAP-009`.)*)*

### 29.4 Receipt — deliberately minimal

| State | Meaning | Source |
|---|---|---|
| `ISSUED` | Proof of a confirmed payment exists | EA L1414; `MP-GBR-12` |

**There is no second receipt state.** No source document defines a receipt lifecycle, and
`MP-GBR-12` plus BC Map L374 make a receipt *immutable once issued* — a `VOID` or `CANCELLED` receipt
state would contradict both. A wrongly issued receipt is addressed by a **compensating record**
(`FEE-FR-037`), not by a state change. The brief's instruction — *"define only states supported by
authoritative sources"* — is followed literally.

### 29.5 Refund — ✅ V1 scope decided; **still no state table, and that is deliberate**

*Superseded text retained verbatim:* **"### 29.5 Refund — ⛔ BLOCKED / No state table is written. Tier
unresolved (`FEE-GAP-001`)."*

**The tier is now decided (V1) and refund behaviour is specified at §18.1 — yet no refund state machine is
written, because V1 refund has no lifecycle to model.** A refund is **recorded or rejected**: `FEE-FR-042`
makes it a **single append-only compensating record** against a `CONFIRMED` payment, for the **full** amount,
and `FEE-BR-019` forbids any lesser amount. There is therefore **no `PARTIALLY_REFUNDED`, no `REFUND_PENDING`
and no `REFUND_REVERSED`** — each would require either partial arithmetic (**proration**, which frozen
`MM-XC-012` places at **V2**) or a mutation of a financial record (**forbidden by Rank 1 `MP-GBR-12`**).

**This follows §29.4's own precedent verbatim** — *"There is no second receipt state… a `VOID` or `CANCELLED`
receipt state would contradict both"* — and the brief's instruction to *"define only states supported by
authoritative sources"*. **A state table invented here would be a specification hole dressed as
completeness.**

---

## 30. Business Rules

`FEE-BR-001` … `FEE-BR-024` are stated inline at their point of use. Index:

| Rule | Subject | § |
|---|---|---|
| `FEE-BR-001` | No intra-cluster edge outside `E-01`…`E-10` | 8 |
| `FEE-BR-002` | `FeePayment`/`FeeDue`/`Receipt` naming | 9.3 |
| `FEE-BR-003` | No `BC-05`+`BC-20` shared model/table/metric | 9.3 |
| `FEE-BR-004` | Fee structure is not a financial record | 10 |
| `FEE-BR-005` | Structure change never mutates an existing obligation | 10.1 |
| `FEE-BR-006` | Change applies only after effective date | 10.1 |
| `FEE-BR-007` | Due-date rule not invented | 11.1 |
| `FEE-BR-008` | Invoice ≠ Payment | 12 |
| `FEE-BR-009` | Payment ≠ Receipt | 13 |
| `FEE-BR-010` | Cash is verified at recording | 13.1 |
| `FEE-BR-011` | Out-of-band UPI is staff-attested | 13.2 |
| `FEE-BR-012` | Gateway card payment is an online payment | 13.3 |
| `FEE-BR-013` | Full settlement only in V1 | 13.6 |
| `FEE-BR-014` | Client success is a hint, never a fact | 14 |
| `FEE-BR-015` | Visible reconciliation queue MUST exist | 14 |
| `FEE-BR-016` | Payment-side duplicate protection is BC-05's | 15 |
| `FEE-BR-017` | Discount never mutates the original amount | 17.1 |
| `FEE-BR-018` | No discount ceiling invented | 17.1 |
| `FEE-BR-019` | *(conditional)* refund = compensating entry, ≤ received | 18.1 |
| `FEE-BR-020` | Corrections append-only with actor + reason | 18.2 |
| `FEE-BR-021` | No stored balance aggregate | 19 |
| `FEE-BR-022` | No timer owns overdue status | 20 |
| `FEE-BR-023` | No self-defined metric formula | 22 |
| `FEE-BR-024` | "Revenue" must state which money it means | 22.1 |
| `FEE-BR-025` | No notification event beyond the three `fee.*` facts | 26 |
| `FEE-BR-026` | No financial penalty persists beyond its own membership | 11.3.3 |
| `FEE-BR-027` | A renewal inside a protection window carries no adverse marker | 11.3.3 |
| `FEE-BR-028` | A configuration change is never retroactive to a confirmed transaction | 15.1 |

---

## 31. Invariants

| ID | Invariant | Source |
|---|---|---|
| `FEE-INV-001` | Fee structure amount is non-negative `Money` in tenant currency | Derived from `Money` VO |
| `FEE-INV-002` | A `FeeDue` amount equals its creation snapshot, for life | `MP-GBR-12`, `MM-FR-027` |
| `FEE-INV-003` | Every financial record belongs to exactly one tenant and one student record | `E-18`, BC Map L374 |
| `FEE-INV-004` | A student is not archivable while outstanding > 0 | `E-09` verbatim |
| `FEE-INV-005` | No two confirmed payments share an idempotency key or gateway reference | `MP-GBR-18`, BC Map L478 |
| `FEE-INV-006` | An issued receipt never changes | `MP-GBR-12`, BC Map L374 |
| `FEE-INV-007` | Discount ≤ original; payable ≥ 0 | BC Map L374 |
| `FEE-INV-008` | Financial history is append-only | `MP-GBR-12` |
| `FEE-INV-009` | `balance = Σ dues − Σ receipts`, never stored independently | BC Map L374 verbatim |
| `FEE-INV-010` | A `CONFIRMED` record's snapshot fields never change, including under a config change | `MP-GBR-12`; §15.1 |

---

## 32. Explicit Exclusions

| ID | This module MUST NOT |
|---|---|
| `FEE-XC-001` | Read, write or aggregate `BC-20` subscription revenue |
| `FEE-XC-002` | Report "revenue" mixing student fees and SaaS revenue |
| `FEE-XC-003` | Derive a fee obligation from attendance, presence or seat occupancy |
| `FEE-XC-004` | Accept or model a partial settlement in V1 |
| `FEE-XC-005` | Hold, read or transmit a payment-gateway credential |
| `FEE-XC-006` | Name a payment vendor in code, event, table or contract |
| `FEE-XC-007` | Update or delete an issued receipt |
| `FEE-XC-008` | Implement refund as an edit or deletion |
| `FEE-XC-009` | Store a materialised balance as authoritative state |
| `FEE-XC-010` | Hold student identity attributes beyond a `StudentRecordId` reference |
| `FEE-XC-011` | Purge or rewrite financial history |
| `FEE-XC-012` | Define, compute or publish a certified metric |
| `FEE-XC-013` | Build a reporting store inside `BC-05` |
| `FEE-XC-014` | Create a new role, or infer permission from dashboard visibility |
| `FEE-XC-015` | Store audit records locally or make audit synchronous |
| `FEE-XC-016` | Perform any cross-tenant financial read, write, aggregate or export |

**Also excluded by Rank 4 Dependency Matrix L167** (`LIBRARY MANAGEMENT → INTEGRATION` = `✖`): direct
integration access. And by `MM-XC-004`'s mirror: this module is the **only** ledger holder, so it must
not tolerate a second ledger elsewhere either.

**Renewal-protection exclusions** — added in v0.2, specified in §11.3.3:

| ID | This module MUST NOT… |
|---|---|
| `FEE-XC-017` | Publish a fourth `fee.*` event *(allocated in v0.2; was reserved)* |
| `FEE-XC-018` | Own or be the system of record for renewal-protection usage history *(owner: `BC-02`; policy: `BC-06`)* |
| `FEE-XC-019` | Expose this tenant's financial records — transactions, payment details, receipts, discounts, balances, staff notes, reasons for leaving — to any other library or tenant |
| `FEE-XC-020` | Determine, shorten or extend a membership's duration |
| `FEE-XC-021` | Compute, store, consume or publish any risk score, fraud score, trust score, blacklist, watchlist or cross-library punishment; or label a student *cheater*, *fraud*, *abuser* or *high risk* |

**Platform-commission exclusions** — added in v0.4, specified in §42:

| ID | This module MUST NOT… |
|---|---|
| `FEE-XC-022` | Create, queue, mirror or synchronise **any** financial write while offline |
| `FEE-XC-023` | Record, hold, reduce or reconcile a **library → LIBOORA commission settlement** in any `BC-05` model, table, projection, receipt or metric |
| — | *(Also already excluded: `FEE-XC-001` bars reading, writing or aggregating `BC-20` revenue, and `FEE-XC-002` bars reporting "revenue" that mixes the two. A platform commission, a settlement balance, a net-off and a gateway charge are all `BC-20`'s — no new exclusion is needed to keep them out, and none was invented.)* |

---

## 33. Cross-Module Dependencies

| Edge | Counterpart | Status of counterpart | Risk |
|---|---|---|---|
| `E-07` | `BC-02` (`PRD-005` v1.4 **FROZEN**) | ✅ contract settled | Low |
| `E-10` | `BC-02` (**FROZEN**) | ✅ settled; V1 = *direct handler*, saga is V2 | Low |
| `E-09` | `BC-01` (`PRD-004` v1.2 **FROZEN**) | ✅ settled | Low |
| `E-06` | `BC-06` Library Policy (`PRD-002`) | ⚠ policy PRD not frozen | Medium — due-date arithmetic depends on it (`FEE-GAP-006`) |
| `E-17` | `BC-21` Entitlement | ❌ `D-08` *"Unsatisfied — no specification"* | Medium |
| `E-18` | `BC-19` Tenancy | ⚠ specification maturity unverified | High if absent — tenancy is mandatory |
| `E-19` | `BC-25` Configuration | ⚠ | Medium |
| `E-20` | `BC-24` Audit | ❌ `D-09` *"Unsatisfied"*, `X-10` not implemented | Medium |
| `E-23` | `BC-22` Notification | ❌ `D-12` *"Unsatisfied"* | Low for V1 facts |
| **gateway** | `BC-20`/`BC-31` | ❌ **no edge from `BC-05`**; `D-14` *"Both unwritten"* | **BLOCKING — `FEE-GAP-002`** |
| **offline** | `BC-30` | ❌ **no edge from `BC-05`**; `D-13` *"Both unwritten"* | **BLOCKING — `FEE-GAP-002`(b)** |
| **analytics** | `BC-26` | ⚠ consumer in §9, no `E-*` in §7 | Medium — `FEE-GAP-012` |

Cycle note: Dependency Matrix L382 — *"This resolves `E-07` / `E-10` in the context map, which would
otherwise be a cycle between `BC-02` and `BC-05`"* — the **transactional outbox** is what breaks it.
`FEE-PO-008` — `E-10` **MUST** be published through the transactional outbox in the same DB transaction
as the ledger mutation, *"never published from application code after commit"* (BC Map L446).

---

## 34. Edge Cases

Deterministic outcomes. Rows marked ⛔ cannot be resolved without a gap decision.

| Scenario | Required outcome |
|---|---|
| Payment confirmed, membership activation fails | Payment **stands**; `BC-05`'s ledger is authoritative. Membership stays `PendingPayment` and appears in the reconciliation queue. **Payment MUST NOT be reversed.** *(frozen `PRD-005` L937, verbatim obligation)* |
| Payment received for a voided membership | Activation refused by `BC-02`; event recorded and surfaced for a **refund decision by `BC-05`** ⛔ `FEE-GAP-001` |
| Duplicate payment callback | Second callback produces **no** second payment, receipt or event (`FEE-FR-030`) |
| Client shows success, rail never confirms | Payment stays `PENDING`; no receipt; reconciliation queue |
| Device offline at collection | ⛔ `FEE-GAP-002`(b). Online payment **MUST NOT** succeed by default (`FEE-PO-006`) |
| Fee structure changed after obligation raised | Existing obligation **unchanged** (`FEE-BR-005`) |
| Wrong amount entered on an obligation | ⛔ `FEE-GAP-005` — no authorised correction path exists |
| Student archived with outstanding dues | Archival **blocked with a domain error** (`E-09`, `FEE-INV-004`) |
| Discount exceeds original amount | Rejected (`FEE-INV-007`) |
| Two staff record the same cash payment | Idempotency key at API edge (`FEE-FR-029`); duplicate surfaced by reconciliation (`FEE-FR-032`) |
| Student pays ₹500 of a ₹2000 due | **No V1-legal representation** (`FEE-XC-004`, `FEE-GAP-008`) |
| Cash drawer count disagrees with ledger | **Out of V1 scope** — Cash Reconciliation is EA (V2) `NG-8`. The ledger remains authoritative |
| Event arrives twice from `E-07` | Idempotent on `eventId` (`FEE-FR-009`) |
| Event arrives with no tenant context | **Fail loudly, never default** (BC Map L451, `FEE-PO-003`) |

---

## 35. Acceptance Criteria

**84 criteria, `FEE-AC-001` … `FEE-AC-084`.** Each is *verified by* a test; none is an obligation.
**None is proven** — no test exists, no task file exists. Per `SID-4.56`, every one **is currently unmet**.

### 35.1 Fee structure (`FEE-AC-001`…`006`)
| ID | Criterion |
|---|---|
| `FEE-AC-001` | A fee structure can be created with tenant, name, amount, currency, active flag, effective date |
| `FEE-AC-002` | A fee structure created in tenant A is invisible in tenant B |
| `FEE-AC-003` | Creating a fee structure emits an audit fact |
| `FEE-AC-004` | Amending a fee structure emits an audit fact |
| `FEE-AC-005` | A fee structure with a negative amount is rejected |
| `FEE-AC-006` | A fee structure carries no balance and appears in no ledger total |

### 35.2 Fee applicability & structure change (`FEE-AC-007`…`011`)
| ID | Criterion |
|---|---|
| `FEE-AC-007` | Changing a fee structure leaves every existing `FeeDue` amount unchanged |
| `FEE-AC-008` | An obligation raised after the effective date uses the new amount |
| `FEE-AC-009` | An obligation raised before the effective date keeps the old amount |
| `FEE-AC-010` | A `FeeDue` amount cannot be edited by any API path |
| `FEE-AC-011` | Fee type is read through configuration, not a hard-coded enum |

### 35.3 Obligation creation (`FEE-AC-012`…`018`)
| ID | Criterion |
|---|---|
| `FEE-AC-012` | `membership.MembershipCreated` raises a `FeeDue` with the event's `priceSnapshot` |
| `FEE-AC-013` | `membership.MembershipRenewed` raises or adjusts a `FeeDue` |
| `FEE-AC-014` | `membership.MembershipUpgraded` adjusts dues using `priceDifference` |
| `FEE-AC-015` | The same membership event delivered twice raises exactly **one** `FeeDue` |
| `FEE-AC-016` | `BC-05` never creates a `FeeDue` for a membership event it did not receive |
| `FEE-AC-017` | A `FeeDue` references a `StudentRecordId` and stores no identity attributes |
| `FEE-AC-018` | An event without tenant context fails loudly and creates nothing |

### 35.4 Due / overdue transitions (`FEE-AC-019`…`024`)
| ID | Criterion |
|---|---|
| `FEE-AC-019` | A new obligation is `DUE` |
| `FEE-AC-020` | An obligation past its due date reports `OVERDUE` |
| `FEE-AC-021` | `OVERDUE` is reproducible from recorded facts with no scheduled job having run |
| `FEE-AC-022` | `PAID` never returns to `DUE` or `OVERDUE` |
| `FEE-AC-023` | `CANCELLED` has no outgoing transition |
| `FEE-AC-024` | No state named `PARTIALLY_PAID` exists anywhere in the model |

### 35.5 Payment recording (`FEE-AC-025`…`031`)
| ID | Criterion |
|---|---|
| `FEE-AC-025` | A cash payment recorded at reception is `CONFIRMED` and records the collecting actor |
| `FEE-AC-026` | A UPI payment can be recorded with method `UPI` |
| `FEE-AC-027` | A card payment can be recorded with method `CARD` |
| `FEE-AC-028` | A payment stores tenant, student reference, amount, currency, method, idempotency key, actor, timestamp |
| `FEE-AC-029` | A `CONFIRMED` payment cannot be edited by any API path |
| `FEE-AC-030` | Recording a payment emits an audit fact |
| `FEE-AC-031` | A `student` role cannot record or confirm a payment |

### 35.6 Payment verification (`FEE-AC-032`…`036`)
| ID | Criterion |
|---|---|
| `FEE-AC-032` | A client-side success signal alone does not move a payment out of `PENDING` |
| `FEE-AC-033` | A `PENDING` payment settles no obligation and generates no receipt |
| `FEE-AC-034` | A `PENDING` payment emits no `fee.FeePaymentReceived` |
| `FEE-AC-035` | A payment with an unknown outcome appears in the reconciliation queue |
| `FEE-AC-036` | An offline device cannot cause an online payment to be recorded `CONFIRMED` |

### 35.7 Duplicate prevention (`FEE-AC-037`…`041`)
| ID | Criterion |
|---|---|
| `FEE-AC-037` | The same idempotency key returns the original result and creates no second payment |
| `FEE-AC-038` | The same idempotency key creates no second receipt |
| `FEE-AC-039` | The same idempotency key emits no second `fee.FeePaymentReceived` |
| `FEE-AC-040` | Two confirmed payments cannot share a gateway reference |
| `FEE-AC-041` | A reconciliation routine surfaces duplicate or orphaned captures |

### 35.8 Invoice & receipt (`FEE-AC-042`…`048`)
| ID | Criterion |
|---|---|
| `FEE-AC-042` | An issued invoice cannot be edited |
| `FEE-AC-043` | An invoice is cancelled by state transition, never deleted |
| `FEE-AC-044` | Issuing an invoice moves no money and creates no receipt |
| `FEE-AC-045` | A receipt is generated for a `CONFIRMED` payment |
| `FEE-AC-046` | No receipt is generated for a `PENDING` payment |
| `FEE-AC-047` | An issued receipt cannot be updated or deleted through any path |
| `FEE-AC-048` | A receipt correction appears as a new compensating record, leaving the original intact |

### 35.9 Discounts (`FEE-AC-049`…`052`)
| ID | Criterion |
|---|---|
| `FEE-AC-049` | A discount without an authorised approver is rejected |
| `FEE-AC-050` | A discount records approver, reason, original amount, discount and payable |
| `FEE-AC-051` | A discount greater than the original amount is rejected |
| `FEE-AC-052` | After a discount, the original amount remains independently visible |

### 35.10 History & outstanding (`FEE-AC-053`…`057`)
| ID | Criterion |
|---|---|
| `FEE-AC-053` | Outstanding balance equals `Σ dues − Σ receipts` computed at read time |
| `FEE-AC-054` | No stored field is the authority for a student's balance |
| `FEE-AC-055` | Financial history is append-only — no path edits or deletes an entry |
| `FEE-AC-056` | History shows actor and timestamp for every entry |
| `FEE-AC-057` | Archiving a student with outstanding dues fails with a domain error |

### 35.11 Roles & tenancy (`FEE-AC-058`…`061`)
| ID | Criterion |
|---|---|
| `FEE-AC-058` | A `parent` sees fee updates only for guarded students |
| `FEE-AC-059` | A `student` sees only their own financial history |
| `FEE-AC-060` | No financial query returns data from another tenant |
| `FEE-AC-061` | Dashboard visibility alone grants no financial write capability |

### 35.12 Events, reporting & BC separation (`FEE-AC-062`…`064`)
| ID | Criterion |
|---|---|
| `FEE-AC-062` | Exactly **three** `fee.*` events exist; no fourth is published |
| `FEE-AC-063` | No table, projection or metric contains both `BC-05` and `BC-20` money |
| `FEE-AC-064` | `BC-05` publishes financial facts and defines no metric formula |

### 35.13 Ports, outbox & boundary enforcement (`FEE-AC-065`…`070`)

*Added during the adversarial self-review. §36.1 previously asserted coverage that the criteria did not
supply; these six close the arithmetic honestly rather than by re-wording the claim.*

| ID | Criterion |
|---|---|
| `FEE-AC-065` | Every `fee.*` event is written to the outbox **inside** the same DB transaction as the state change, and is never published from application code after commit |
| `FEE-AC-066` | A `fee.*` event redelivered with the same `eventId` causes no second state change in any consumer path owned here |
| `FEE-AC-067` | No code path in `BC-05` references a payment-vendor name, credential or SDK symbol |
| `FEE-AC-068` | Online payment execution is reachable only through the Business Platform port; no direct `BC-31` call exists |
| `FEE-AC-069` | A due date is computed only via the `E-06` `HolidayCalendar` port; no local calendar table exists |
| `FEE-AC-070` | A manually created `FeeDue` records actor and reason and emits an audit fact |

### 35.14 Renewal-protection history — financial side only (`FEE-AC-071`…`078`)

*Maps the eight requested scenarios A–H. Each row states **which** of them `BC-05` can actually verify.
Where a scenario is not `BC-05`'s, that is stated rather than covered by a criterion this module could not
honestly execute. See §11.3 and `FEE-GAP-013`.*

| ID | Scenario | Criterion | `BC-05`-testable? |
|---|---|---|---|
| `FEE-AC-071` | **A** — used protection, then renewed | The renewal produces an ordinary `FeeDue` and, once paid, an ordinary receipt, with **no** adverse marker, flag or derived negative field on any financial record | **Yes** |
| `FEE-AC-072` | **B** — used protection, did not renew | `BC-05`'s financial history for the lapsed membership remains intact and append-only; **no** financial penalty record is created by the lapse | **Yes** — but the *protection* history record itself is `BC-02`'s (⛔) |
| `FEE-AC-073` | **C** — joins another library a month later | The new `FeeDue` equals the `priceSnapshot` on that library's own `E-07` event, with **no** deduction, surcharge or proration referencing any earlier protection usage | **Yes** for the amount. **Membership *duration* is `BC-02`'s** (⛔ `FEE-XC-020`) |
| `FEE-AC-074` | **D** — Library B sees only the authorized indicator | ⛔ **Cannot be verified here** — no cross-tenant read exists to test. `BC-05` exposes **nothing**; asserted negatively by `FEE-AC-076` | **No** — Architecture Owner |
| `FEE-AC-075` | **E** — Library B cannot see Library A's financial details | A query executed in tenant B returns **no** transaction, payment, receipt, discount, balance or note belonging to tenant A, for **every** financial read path | **Yes** — this is the strongest guarantee in the section |
| `FEE-AC-076` | **F** — never labelled | **No** field, enum, projection, event payload, report or API response produced by `BC-05` contains a risk score, fraud flag, blacklist membership, or the terms *cheater*, *fraud*, *abuser* or *high risk*; and none is derivable from protection usage | **Yes** |
| `FEE-AC-077` | **G** — record auditable after the window expires | `BC-05`'s financial entries for the affected membership remain readable and unmodified after expiry; no purge path exists (`FEE-XC-011`) | **Yes** for financial entries; protection record is `BC-02`'s (⛔) |
| `FEE-AC-078` | **H** — old protection event cannot affect a future membership | Given any prior protection usage, the amount of a later membership's `FeeDue` is **bit-identical** to the amount computed with no prior usage at all | **Yes** |

> **`FEE-AC-074` is deliberately recorded as not-verifiable-here.** Writing a passing criterion for a
> cross-library read that has no registered edge would be exactly the fabricated verification this document
> refuses elsewhere. What `BC-05` *can* guarantee is the negative: it discloses nothing (`FEE-AC-075`,
> `FEE-AC-076`).

### 35.15 Commission boundary, snapshot immutability & offline cash (`FEE-AC-079`…`083`) *(added v0.4)*

*Verifies the parts of the Master Product decision that are lawfully `BC-05`'s. Three of the five are
**negative** criteria — they assert that something does **not** appear — which is the only honest way to
verify a boundary this module must not cross.*

| ID | Criterion |
|---|---|
| `FEE-AC-079` | A `CONFIRMED` financial record's gross amount, transaction reference, confirming actor, payment method and timestamp are unchanged after any configuration value is altered |
| `FEE-AC-080` | A configuration change applies to a transaction confirmed after it takes effect, and to no transaction confirmed before |
| `FEE-AC-081` | With no connectivity, a staff cash-collection attempt produces no `CONFIRMED` record, no receipt and no membership activation |
| `FEE-AC-082` | No financial write is queued, mirrored or synchronised while offline; a repeated cash submission with the same idempotency key yields one confirmed payment |
| `FEE-AC-083` | A student-facing breakdown itemises membership/fee amount, discounts and amount paid separately, and shows no platform-commission, gateway or tax line |
| `FEE-AC-084` | A completed library → LIBOORA commission settlement leaves every `BC-05` figure **byte-identical**: the student's `FeeDue`, the `FeePayment` amount, the `Receipt` amount, the `FeeLedger` balance and the library's student-revenue total are unchanged, and no `BC-05` table gains a settlement row |

> **`FEE-AC-083` is deliberately a negative criterion.** It requires the **absence** of a commission,
> gateway and tax line, because those three belong to `BC-20` and V3. A criterion asserting their
> presence would need a rate this repository does not contain — see `FEE-GAP-014`.

### 35.16 Inbound-notification verification, refunds, due-date offset and correction (`FEE-AC-085`…`FEE-AC-098`) *(added v1.5)*

> **Every criterion below tests behaviour this module OWNS.** None names an endpoint, URL, payload field,
> signature algorithm, header, replay window, retry policy or provider — because `ADR-0040` §2 established
> that **no document may currently author them**. The shape is the one already used by `FEE-AC-032`/`033`/
> `034` for the client-side-hint case: **the same rule — *evidence, never instruction* — applied to the
> server-side inbound case.**

**Inbound payment notification — `FEE-FR-028` (`ADR-0040` §2.2/§2.4)**

| ID | Criterion |
|---|---|
| `FEE-AC-085` | An inbound payment notification **alone** does not move a payment out of `PENDING`; the payment leaves `PENDING` only after this module's own server-side verification succeeds |
| `FEE-AC-086` | A payment whose inbound notification has not been verified settles **no** obligation and generates **no** receipt |
| `FEE-AC-087` | A payment whose inbound notification has not been verified emits **no** `fee.FeePaymentReceived` |
| `FEE-AC-088` | Delivering the **same** inbound notification any number of times yields **exactly one** confirmed payment, one receipt and one `fee.FeePaymentReceived` |
| `FEE-AC-089` | An inbound notification that matches **no** known payment creates no payment, no receipt and no obligation settlement, and is surfaced in the reconciliation queue |

**Refunds — `FEE-FR-042`, `FEE-BR-019`, `FEE-EVT-003` (`ADR-0039` §3)**

| ID | Criterion |
|---|---|
| `FEE-AC-090` | A refund can be recorded against a `CONFIRMED` payment and appears as a **separate** financial record carrying actor, reason and timestamp |
| `FEE-AC-091` | After a refund is recorded, the original payment and the original receipt are **byte-identical** to their pre-refund state — no field, amount, state or timestamp differs |
| `FEE-AC-092` | A refund against a `PENDING`, `FAILED` or `CANCELLED` payment is **rejected** and creates no record |
| `FEE-AC-093` | A refund for an amount **less than** the confirmed payment amount is **rejected**; a refund exceeding the amount received is **rejected** |
| `FEE-AC-094` | Recording a refund publishes `fee.RefundIssued` exactly **once**; a rejected refund publishes **nothing** |
| `FEE-AC-095` | A **cash** refund follows the same server-authoritative path: nothing is written, queued, mirrored or synchronised while offline |

**Due-date offset — `FEE-BR-007` (`ADR-0039` §6)**

| ID | Criterion |
|---|---|
| `FEE-AC-096` | An obligation's effective due date **equals** the due date recorded on the `FeeDue`, with **no** offset, grace period or added days applied by this module |
| `FEE-AC-097` | `OVERDUE` is reported for an obligation whose recorded due date has passed, computed with offset `0`, reproducibly and with no scheduled job having run |

**Append-only correction — `FEE-FR-043` (`ADR-0039` §5)**

| ID | Criterion |
|---|---|
| `FEE-AC-098` | A correction to a financial record creates a **new** compensating record carrying actor, reason, timestamp and corrected state, and **no** API path edits or deletes the original |

> **`FEE-AC-088` is the criterion that does the most work with the least invention.** It tests replay
> protection — the property a webhook most needs — using **only** `FEE-INV-005`'s existing idempotency and
> gateway-reference uniqueness invariant. It needs **no replay window, no signature and no schema**, because
> *"the same notification delivered twice yields one payment"* is a statement about **`BC-05`'s own
> behaviour**, which is exactly what `ADR-0035` §5.5b left with `BC-05`.

> **`FEE-AC-091` is deliberately a byte-identity criterion rather than a prose one.** *"The original is
> unchanged"* is verifiable only if it is stated as exact identity; **Rank 1 `MP-GBR-12`** requires a refund
> to be *"a **compensating entry, never a mutation**"*, and a criterion weaker than byte-identity would let a
> silent field update pass. The same technique is already used by `FEE-AC-084`.

**Not covered by any criterion, deliberately:** the webhook **wire contract** — endpoint, payload schema,
signature algorithm, header, replay window, retry policy, provider (⛔ `FEE-GAP-002`, contract limb; owner:
**`BC-31` owner once `PRD-019` exists**), the **payload** of `fee.RefundIssued` (⛔ no source specifies event
field lists), bank transfer (⛔ `FEE-GAP-003`), and cross-library protection disclosure
(⛔ `FEE-GAP-013`, `FEE-AC-074`). **Writing criteria for undecided behaviour would be fabricating
verification.**

> *Superseded text retained verbatim, so the movement is legible:* **"Not covered by any criterion,
> deliberately: refunds (⛔ `FEE-GAP-001`), webhook reconciliation (⛔ `FEE-GAP-002`), offline cash capture
> (⛔ `FEE-GAP-002`(b)), bank transfer (⛔ `FEE-GAP-003`), due-date arithmetic (⛔ `FEE-GAP-006`)."*
> **Three of those five are now covered** — refunds, inbound-notification verification and due-date
> arithmetic. **Offline cash capture is not "now covered"; it was DISSOLVED** by `ACCEPTED` `ADR-0037`, and
> `FEE-AC-081`/`082` already assert the prohibition — a distinction worth keeping, because a dissolved
> question and a satisfied one are not the same thing.

---

## 36. Traceability

### 36.1 Coverage

> **Self-review correction.** The first draft of this section asserted *"113 = 95.8%"* while the criteria
> tables in §35 contained **no requirement back-links at all** — the figure was therefore not measurable
> and not true. It is replaced below by an explicit per-identifier mapping. The defect and its correction
> are recorded in the changelog (§41) and in finding **J-2** of the covering report.

**Forward trace — every obligation-bearing identifier to its verifying criterion:**

*One row per identifier — deliberately not collapsed into ranges, so that a future `prd008_traceability.py` can verify it mechanically.*

| Requirement | Verified by | Note |
|---|---|---|
| `FEE-FR-001` | `FEE-AC-001` |  |
| `FEE-FR-002` | `FEE-AC-001`, `FEE-AC-005` |  |
| `FEE-FR-003` | `FEE-AC-002` |  |
| `FEE-FR-004` | `FEE-AC-003`, `FEE-AC-004` |  |
| `FEE-FR-005` | `FEE-AC-008`, `FEE-AC-009` |  |
| `FEE-FR-006` | `FEE-AC-011` |  |
| `FEE-FR-007` | `FEE-AC-012`, `FEE-AC-013` |  |
| `FEE-FR-008` | `FEE-AC-017`, `FEE-AC-028` |  |
| `FEE-FR-009` | `FEE-AC-015` |  |
| `FEE-FR-010` | `FEE-AC-014` |  |
| `FEE-FR-011` | `FEE-AC-016` |  |
| `FEE-FR-012` | `FEE-AC-070` |  |
| `FEE-FR-013` | `FEE-AC-019` |  |
| `FEE-FR-014` | `FEE-AC-069` |  |
| `FEE-FR-015` | `FEE-AC-057` |  |
| `FEE-FR-016` | `FEE-AC-044` |  |
| `FEE-FR-017` | `FEE-AC-042` |  |
| `FEE-FR-018` | `FEE-AC-043` |  |
| `FEE-FR-019` | `FEE-AC-028` |  |
| `FEE-FR-020` | `FEE-AC-033`, `FEE-AC-053` |  |
| `FEE-FR-021` | `FEE-AC-029` |  |
| `FEE-FR-022` | `FEE-AC-025` |  |
| `FEE-FR-023` | `FEE-AC-025` |  |
| `FEE-FR-024` | `FEE-AC-026` |  |
| `FEE-FR-025` | `FEE-AC-027` |  |
| `FEE-FR-026` | `FEE-AC-032` |  |
| `FEE-FR-027` | `FEE-AC-033`, `FEE-AC-034` |  |
| `FEE-FR-028` | `FEE-AC-085`, `FEE-AC-086`, `FEE-AC-087`, `FEE-AC-088`, `FEE-AC-089` | added v1.5 — `BC-05` verification obligation (`ADR-0040`); **wire contract still open** |
| `FEE-FR-029` | `FEE-AC-037` |  |
| `FEE-FR-030` | `FEE-AC-037`, `FEE-AC-038` |  |
| `FEE-FR-031` | `FEE-AC-040` |  |
| `FEE-FR-032` | `FEE-AC-041` |  |
| `FEE-FR-033` | `FEE-AC-045` |  |
| `FEE-FR-034` | `FEE-AC-047` |  |
| `FEE-FR-035` | `FEE-AC-050`, `FEE-AC-056` |  |
| `FEE-FR-036` | `FEE-AC-046` |  |
| `FEE-FR-037` | `FEE-AC-048` |  |
| `FEE-FR-038` | `FEE-AC-049` |  |
| `FEE-FR-039` | `FEE-AC-049` |  |
| `FEE-FR-040` | `FEE-AC-050` |  |
| `FEE-FR-041` | `FEE-AC-030` |  |
| `FEE-FR-042` | `FEE-AC-090`, `FEE-AC-091`, `FEE-AC-092`, `FEE-AC-093`, `FEE-AC-095` | added v1.5 |
| `FEE-FR-043` | `FEE-AC-048`, `FEE-AC-098` | `FEE-AC-098` added v1.5 — append-only correction |
| `FEE-FR-044` | `FEE-AC-055` |  |
| `FEE-FR-045` | `FEE-AC-053`, `FEE-AC-054` |  |
| `FEE-FR-046` | `FEE-AC-059` |  |
| `FEE-FR-047` | `FEE-AC-053` |  |
| `FEE-FR-048` | `FEE-AC-020`, `FEE-AC-021` |  |
| `FEE-FR-049` | `FEE-AC-055` |  |
| `FEE-FR-050` | `FEE-AC-056` |  |
| `FEE-FR-051` | `FEE-AC-055` |  |
| `FEE-FR-052` | `FEE-AC-064` |  |
| `FEE-FR-053` | `FEE-AC-031`, `FEE-AC-060` |  |
| `FEE-FR-054` | `FEE-AC-031` |  |
| `FEE-FR-055` | `FEE-AC-058` |  |
| `FEE-FR-056` | `FEE-AC-030` |  |
| `FEE-FR-057` | `FEE-AC-060` |  |
| `FEE-FR-058` | `FEE-AC-060` |  |
| `FEE-BR-001` | `FEE-AC-068` |  |
| `FEE-BR-002` | `FEE-AC-063` |  |
| `FEE-BR-003` | `FEE-AC-063` |  |
| `FEE-BR-004` | `FEE-AC-006` |  |
| `FEE-BR-005` | `FEE-AC-007`, `FEE-AC-010` |  |
| `FEE-BR-006` | `FEE-AC-008`, `FEE-AC-009` |  |
| `FEE-BR-007` | `FEE-AC-096`, `FEE-AC-097` | added v1.5 — offset `0` |
| `FEE-BR-008` | `FEE-AC-044` |  |
| `FEE-BR-009` | `FEE-AC-045`, `FEE-AC-046` |  |
| `FEE-BR-010` | `FEE-AC-025` |  |
| `FEE-BR-011` | `FEE-AC-026` |  |
| `FEE-BR-012` | `FEE-AC-027`, `FEE-AC-032` |  |
| `FEE-BR-013` | `FEE-AC-022`, `FEE-AC-023`, `FEE-AC-024` | `FEE-AC-022`/`023` mapped v1.5 — see §36.1a |
| `FEE-BR-014` | `FEE-AC-032` |  |
| `FEE-BR-015` | `FEE-AC-035` |  |
| `FEE-BR-016` | `FEE-AC-040`, `FEE-AC-041` |  |
| `FEE-BR-017` | `FEE-AC-052` |  |
| `FEE-BR-018` | `FEE-AC-051` |  |
| `FEE-BR-019` | `FEE-AC-091`, `FEE-AC-093` | added v1.5 — unconditional |
| `FEE-BR-020` | `FEE-AC-048` |  |
| `FEE-BR-021` | `FEE-AC-054` |  |
| `FEE-BR-022` | `FEE-AC-021` |  |
| `FEE-BR-023` | `FEE-AC-064` |  |
| `FEE-BR-024` | `FEE-AC-063` |  |
| `FEE-INV-001` | `FEE-AC-005` |  |
| `FEE-INV-002` | `FEE-AC-007`, `FEE-AC-010` |  |
| `FEE-INV-003` | `FEE-AC-002`, `FEE-AC-017` |  |
| `FEE-INV-004` | `FEE-AC-057` |  |
| `FEE-INV-005` | `FEE-AC-037`, `FEE-AC-040` |  |
| `FEE-INV-006` | `FEE-AC-047` |  |
| `FEE-INV-007` | `FEE-AC-051` |  |
| `FEE-INV-008` | `FEE-AC-055` |  |
| `FEE-INV-009` | `FEE-AC-053`, `FEE-AC-054` |  |
| `FEE-EVT-001` | `FEE-AC-062`, `FEE-AC-065` |  |
| `FEE-EVT-002` | `FEE-AC-034`, `FEE-AC-039`, `FEE-AC-066` |  |
| `FEE-EVT-003` | `FEE-AC-062`, `FEE-AC-094` | behaviour added v1.5; **payload still unspecified** |
| `FEE-XC-001` | `FEE-AC-063` |  |
| `FEE-XC-002` | `FEE-AC-063` |  |
| `FEE-XC-003` | `FEE-AC-012`, `FEE-AC-016` |  |
| `FEE-XC-004` | `FEE-AC-024` |  |
| `FEE-XC-005` | `FEE-AC-067` |  |
| `FEE-XC-006` | `FEE-AC-067` |  |
| `FEE-XC-007` | `FEE-AC-047` |  |
| `FEE-XC-008` | `FEE-AC-047`, `FEE-AC-048` |  |
| `FEE-XC-009` | `FEE-AC-054` |  |
| `FEE-XC-010` | `FEE-AC-017` |  |
| `FEE-XC-011` | `FEE-AC-055` |  |
| `FEE-XC-012` | `FEE-AC-064` |  |
| `FEE-XC-013` | `FEE-AC-064` |  |
| `FEE-XC-014` | `FEE-AC-061` |  |
| `FEE-XC-015` | `FEE-AC-030` |  |
| `FEE-XC-016` | `FEE-AC-060` |  |
| `FEE-PO-001` | `FEE-AC-068` |  |
| `FEE-PO-002` | `FEE-AC-030` |  |
| `FEE-PO-003` | `FEE-AC-018`, `FEE-AC-060` |  |
| `FEE-PO-004` | `FEE-AC-062` |  |
| `FEE-PO-005` | `FEE-AC-064` |  |
| `FEE-PO-006` | `FEE-AC-036` |  |
| `FEE-PO-007` | `FEE-AC-035` |  |
| `FEE-PO-008` | `FEE-AC-065`, `FEE-AC-066` |  |
| `FEE-FR-059` | `FEE-AC-073`, `FEE-AC-078` |  |
| `FEE-BR-025` | `FEE-AC-062` | reserved-then-allocated: notification restraint |
| `FEE-BR-026` | `FEE-AC-073`, `FEE-AC-078` |  |
| `FEE-BR-027` | `FEE-AC-071` |  |
| `FEE-XC-017` | `FEE-AC-062` | reserved-then-allocated: no fourth event |
| `FEE-XC-018` | `FEE-AC-072`, `FEE-AC-077` |  |
| `FEE-XC-019` | `FEE-AC-074`, `FEE-AC-075` | `FEE-AC-074` mapped v1.5 — negative-assertion criterion, see §36.1a |
| `FEE-XC-020` | `FEE-AC-073` |  |
| `FEE-XC-021` | `FEE-AC-076` |  |
| `FEE-FR-060` | `FEE-AC-079` | added v0.4 |
| `FEE-FR-061` | `FEE-AC-081` | added v0.4 |
| `FEE-FR-062` | `FEE-AC-083` | added v0.4 |
| `FEE-INV-010` | `FEE-AC-079` | added v0.4 |
| `FEE-BR-028` | `FEE-AC-080` | added v0.4 |
| `FEE-XC-022` | `FEE-AC-081`, `FEE-AC-082` | added v0.4 |
| `FEE-XC-023` | `FEE-AC-084` | added v0.8 |

**Measured coverage:**

| Register | Allocated | Traced | Untraced |
|---|---|---|---|
| `FEE-FR-*` | 62 | **62** | — *(was: `FEE-FR-028`, `FEE-FR-042`)* |
| `FEE-BR-*` | 28 | **28** | — *(was: `FEE-BR-007`, `FEE-BR-019`)* |
| `FEE-INV-*` | 10 | 10 | — |
| `FEE-EVT-*` | 3 | 3 | — *(`FEE-EVT-003` now behavioural, **payload still unspecified**)* |
| `FEE-XC-*` | 23 | 23 | — |
| `FEE-PO-*` | 8 | 8 | — |
| **Total** | **134** | **134** | **0 = 100.0%** |

*Superseded coverage table retained verbatim, so the movement is legible rather than asserted:*

| Register | Allocated | Traced | Untraced (all ⛔ BLOCKED) |
|---|---|---|---|
| `FEE-FR-*` | 62 | 60 | `FEE-FR-028`, `FEE-FR-042` |
| `FEE-BR-*` | 28 | 26 | `FEE-BR-007`, `FEE-BR-019` |
| `FEE-INV-*` | 10 | 10 | — |
| `FEE-EVT-*` | 3 | 3 | — *(`FEE-EVT-003` count-only)* |
| `FEE-XC-*` | 23 | 23 | — |
| `FEE-PO-*` | 8 | 8 | — |
| **Total** | **134** | **130** | **4 = 97.0%** |

### 36.1a Three ORPHAN acceptance criteria found at v1.5 — a defect this document had not previously recorded

**This was discovered by measurement during the v1.5 pass and is disclosed rather than quietly repaired.**
`PRD_LIFECYCLE.md` Stage 4 check **4** requires *"every acceptance criterion maps to a requirement"*, with the
failure named *"Orphan criterion"*. Measured mechanically over §36.1 alone — 134 obligation rows, 84 declared
criteria — **81 criteria were cited and 3 were not**:

| Orphan | Text | Now mapped to | Why that obligation and not a new one |
|---|---|---|---|
| `FEE-AC-022` | *`PAID` never returns to `DUE` or `OVERDUE`* | **`FEE-BR-013`** | `FEE-BR-013` states a `FeeDue` is *"settled **in full or not at all**"*; §29.1 lists `PAID → DUE` and `PAID → OVERDUE` under **Forbidden**. The criterion verifies exactly that settlement is terminal |
| `FEE-AC-023` | *`CANCELLED` has no outgoing transition* | **`FEE-BR-013`** | Same rule and the same §29.1 **Forbidden** list (`CANCELLED → *`) |
| `FEE-AC-074` | *Library B sees only the authorized indicator* — recorded **⛔ not verifiable in `BC-05`** | **`FEE-XC-019`** | `FEE-XC-019` forbids cross-tenant financial disclosure **unconditionally**; `FEE-AC-074`'s own row says it is *"asserted negatively by `FEE-AC-076`"*. Mapping it to the **exclusion** it negatively asserts is the honest mapping |

⚠ **`FEE-AC-074` is still recorded as not-verifiable-in-`BC-05`, and mapping it changes nothing about that.**
Its §35.14 row and the note beneath it are **unchanged**. What changes is only that it is no longer an
**orphan** — it now maps to the exclusion it evidences. **No requirement was invented to adopt these three,
and no criterion text was reworded**; each was mapped to an obligation that **already** asserted the rule it
tests.

**Why the earlier passes missed it.** Every prior pass measured the **untraced obligation** direction
(*requirement → criterion*) and reported **4**. **Check 4 runs in the opposite direction**
(*criterion → requirement*), and it had **never been measured**. A first attempt at measuring it returned
**204 rows**, which was wrong — the pattern swept in the §35.x and §37 tables as well as §36.1; scoping the
probe to §36.1's line range returned **exactly 134**, matching the declared obligation count. **The wrong
answer was discarded rather than reconciled.**

*The v0.4 additions moved the ratio from 123/127 to **129/133** — the six new obligations each carry a
criterion, so the **untraced set is unchanged at exactly four**. The percentage rose because the
denominator grew with fully-traced rows, not because anything previously untraced was closed.*

*v0.8 adds exactly **one** obligation, `FEE-XC-023`, traced by `FEE-AC-084`: **134 obligations, 130
traced, 130/134 = 97.0%**. The **untraced set is still exactly the same four** — `FEE-FR-028`,
`FEE-FR-042`, `FEE-BR-007`, `FEE-BR-019` — and **nothing untraced was closed at v0.8**. The ratio is
flat to one decimal place; it is reported as unchanged rather than rounded upward. `FEE-GAP-017` adds
**no** obligation and therefore **no** traceability row, which is correct: a governance gap is an open
question, and counting it would inflate the denominator with something no test can verify.*

**This does not meet the 100% bar** that `PRD-006` cleared (285/285). The shortfall is **exactly** the four
requirements whose behaviour is governed by an unresolved gap. Writing criteria for undecided behaviour
would be fabricating verification, so the shortfall is reported, not closed.

**Renewal-protection note.** `FEE-AC-074` (scenario D — *Library B sees the authorized indicator*) is
recorded in §35.14 as **not verifiable in `BC-05`**, because no cross-tenant read edge exists to exercise.
It is therefore **not** counted as coverage of any `BC-05` obligation — the obligations it would have
covered are `FEE-XC-018`…`021`, which are instead verified by the *negative* criteria `FEE-AC-075` and
`FEE-AC-076`. See `FEE-GAP-013`.

### 36.2 Upstream traceability

| Requirement group | Traces to |
|---|---|
| Ledger, balance, immutability | `MP-GBR-12`, BC Map L374 |
| Idempotency | `MP-GBR-18`, `MP-RSK-04`, BC Map L478, `MM-BR-005` |
| `BC-05`/`BC-20` separation | `MP-GBR-24`, BC Map L202–204, `ADR-0015` |
| Metric boundary | `MP-GBR-36`, `MP-SM-06` |
| Obligation creation | `E-07`, `MM-BR-003`, `MM-EVT-001`/`003`/`004` |
| Payment outcome → membership | `E-10`, `MM-BR-002` |
| Archival block | `E-09` |
| Holiday calendar | `E-06` |
| Reconciliation queue | BC Map L465, `MM-BR-004` |
| Roles | Master PRD L105–111 |
| Cluster edge law | Dependency Matrix L89 |
| Capability ports | `E-17`…`E-23` |

### 36.3 No gate exists

`PRD-006` has `tool/docs_check/prd006_traceability.py` and `prd006_task_coverage.py`. **No equivalent
`prd008_*` gate has been written**, so every count in §36.1 is **hand-measured and unverified by
machine**. Recorded as part of `FEE-GAP-012`. No gate was weakened — none exists to weaken.

---

## 37. Governance Gap Ledger

**17 gaps. 0 block Stage 4. 10 block Freeze — re-derived at v1.5 by reading every one of the 17 blocks' own `Stage 4` and `Freeze` field, taking the LEADING declared verdict of each field rather than searching for the word "BLOCKS" anywhere inside it.** The Stage-4 set is now **empty**; the Freeze set is **`FEE-GAP-001`, `002`, `003`, `004`, `005`, `006`, `007`, `009`, `011`, `012`** = **ten**, unchanged in membership from v1.4.

⚠ **THE STAGE-4 COUNT FELL 5 → 0 AT v1.5, AND THAT IS EXACTLY THE KIND OF MOVEMENT THIS DOCUMENT HAS TWICE HAD TO RETRACT — SO IT WAS DERIVED TWICE, BY TWO DIFFERENT METHODS, AND BOTH ARE REPORTED.** *Method 1 — gap fields:* each block's own `Stage 4` field, leading token only → **0**. *Method 2 — the underlying gate:* `PRD_LIFECYCLE.md` **L108–L120** check 1 requires every requirement testable; measured over §36.1's **134** obligation rows, **untraced = 0**, and check 4 (*every criterion maps to a requirement*) measured over the **98** declared criteria gives **orphans = 0**. **The two methods agree.**

⛔ **WHAT DID *NOT* HAPPEN, STATED BECAUSE THE FLATTERING READING WOULD BE THAT IT DID:** **no gap is marked RESOLVED**, **the Freeze count does not move**, and **`FEE-GAP-002`'s wire contract is still unwritten**. Stage 4 clears because its gate permits a conflict to be *"explicitly deferred **with a reason and an owner**"*, and the contract limb now has both — owner: the **`BC-31` owner once `PRD-019` exists**; reason: `ADR-0040` §2 proves **no document may author it today**. **Freeze has no such clause, so Freeze still blocks.** *(A naive re-derivation of the Freeze set by pattern returns **13**; reading every `Freeze` field verbatim shows `FEE-GAP-013`/`014`/`017` each say "**BLOCKS the … feature, not this PRD**". **10 is right and the pattern is wrong** — the same trap this ledger recorded at v1.4, re-checked rather than inherited.)*

*Superseded header text retained verbatim:* **17 gaps. 5 block Stage 4. 10 block Freeze — re-derived at v1.4 by reading every one of the 17 blocks’ own `Stage 4` and `Freeze` field, and the counts do NOT move even though four decisions arrived.** The Stage-4 set is **`FEE-GAP-001`, `002`, `004`, `005`, `006`** = **five**; the Freeze set is those five plus `003`, `007`, `009`, `011`, `012` = **ten**. **Four Product-Owner decisions were recorded at v1.4** (`FEE-GAP-001` refund scope, `004` fee types, `005` append-only correction, `006` offset = 0) and **not one count decrements**, because **a decision is not a specification**: `FEE-FR-028`, `FEE-FR-042`, `FEE-BR-007` and `FEE-BR-019` all still carry **⛔ no acceptance criterion**, so `PRD_LIFECYCLE.md` **L108–L120** check 1 still fails. **This is the row most likely to be decremented in error, and it was checked for exactly that** — twice before, this document decremented or held a count for a flattering reason and had to retract it. *(A naive re-derivation of the Freeze set by pattern returns **13**; reading every `Freeze` field verbatim shows `FEE-GAP-013`/`014`/`017` each say “**BLOCKS the … feature, not this PRD**”. **10** is right and the pattern is wrong.)* *Superseded header text retained verbatim:* **17 gaps. 6 block Stage 4. 11 block Freeze** *(`FEE-GAP-013` is **partly resolved** at v0.3 and blocks the requested feature,
not this PRD — see its Freeze row)*. None is resolved by assumption. *(These two counts were
stated inconsistently in the first draft — `6/6` here and `6/9` in §39. Both were wrong; the values below
are derived by reading the `Stage 4` and `Freeze` row of every gap block. Self-review finding **J-3**.)*

*`FEE-GAP-014` and `FEE-GAP-015` were added at v0.4. **Neither changes the two counts above**, because
`BC-05` owns neither subject: each blocks the feature that needs it, not this PRD.*

### `FEE-GAP-001` — Is Refund V1 or V2?
| Field | Value |
|---|---|
| **Question** | Is refund functionality in scope for `BC-05` V1? |
| **Conflict** | **Rank 4** BC Map L100 (`BC-05` owns refunds, row Release = V1), L374 (`RefundRecord` in `FeeLedger`, invariant `refund ≤ received`), L422 (`fee.RefundIssued` published) · **Rank 3 FROZEN** `PRD-005` L942 (*"a refund decision by `BC-05`"*) **vs Rank 6** EA L823 `Refunds (V2)`, L1409 `Refund Management (V2)` |
| **Impact** | If V1: 3+ requirements, a state table and `FEE-EVT-003` must be written. If V2: the BC Map's own event table must mark `fee.RefundIssued` V2, and frozen `PRD-005` L942 is left depending on a capability that does not exist in V1 |
| **Owner** | Product Owner — Library Domain |
| **Authority** | **Product Owner** (tier) **+ Architecture Owner** (BC Map event table) |
| **Status** | ✅ **PRODUCT SCOPE DECIDED at v1.4 — RECORDED IN `ADR-0039` §3, NOT SELF-ACCEPTED. ⛔ STILL BLOCKS STAGE 4 AND FREEZE.** The Product Owner has decided V1 refund scope: **only `confirmed` payments are refundable**; the original financial record is **immutable**; the refund is a **separate financial operation**; **V1 is full refund only**; and a **cash** refund must also be **server-recorded**. **Four of those five clauses are not new** — immutability and *“compensating entry, never a mutation”* are **Rank 1 `MP-GBR-12`** (`MASTER_PRD.md` **L353**), and server-recorded cash is already `ACCEPTED` **`ADR-0037`**; only *“full refund only”* is a genuinely new product choice. **The instruction’s own escape clause was tested, not assumed:** it permitted partial refund *“only if an existing authoritative source requires it”*, and `grep -rln "partial refund" docs/` returns **0** authoritative requirements — the only two hits are `ADR-0038` and this PRD’s own **recommendation** text, which is *“not a decision”* (`PRD-005` §7.4). The condition is therefore **measurably not triggered**, and full-refund-only additionally **avoids** proration, which frozen `MM-XC-012` places at **V2**. ⛔ **WHY THIS DOES NOT UNBLOCK EITHER GATE, stated plainly rather than left to inference:** (i) **a decision is not a specification** — `FEE-FR-042` (L1731) and `FEE-BR-019` (L1766) still carry **⛔ no acceptance criterion**, so `PRD_LIFECYCLE.md` **L108–L120** check 1 still fails; (ii) no `FEE-*` requirement, refund state table or `FEE-EVT-003` is written by this row, because writing them from a **`PROPOSED`** ADR would create a second divergable source of truth; (iii) the **Architecture Owner** half is untouched — the Rank 6 EA still reads `Refunds (V2)` at **L823**/**L1409** and `MP-CON-08` requires **the EA** to be corrected to match Rank 4, *“never the reverse”*. *Superseded Status text retained verbatim:* **OPEN — REQUIRES PRODUCT OWNER + REQUIRES ARCHITECTURE OWNER** |
| **Stage 4** | ✅ **DOES NOT BLOCK from v1.5.** The Stage-4 concern was `PRD_LIFECYCLE.md` check 1 — *"every requirement testable"* — and it is now satisfied by measurement: **`FEE-FR-042`** carries `FEE-AC-090`/`091`/`092`/`093`/`095`, **`FEE-BR-019`** carries `FEE-AC-091`/`093`, and **`FEE-EVT-003`** carries `FEE-AC-094`. `FEE-BR-019` is **no longer conditional** — the *"**If** refunds are V1"* hedge is removed and the superseded text is retained verbatim at §18.1. *Superseded field retained verbatim:* **BLOCKS** |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.6 — the Rank 6 contradiction is CORRECTED, not argued away.** The single act this field demanded has been performed by the **Architecture Owner** under `ACCEPTED` `ADR-0042` §4: EA **L823** now reads **`Refunds (V1)`**, the EA header moved **v2.1 → v2.2** with a §11 changelog entry, and `DOCUMENTATION_BASELINE.md` §3.2 was updated in the same commit per its own §7 step 3. **The correction ran in the direction `MP-CON-08` mandates** — the Rank 6 document was updated to match Rank 4 BC Map **L100**/**L374**/**L422** and frozen Rank 3 `PRD-005` **L942**, *"never the reverse"*. Measured after the edit: `Refunds (V2)` in the EA capability tree = **0**. ⚠ **TWO THINGS THIS FIELD NO LONGER CLAIMS, AND ONE IT NOW DISCLOSES.** **(i) EA L1408 `Refund Management (V2)` is deliberately NOT changed, and its survival is NOT a residual of this gap.** An indentation-parent probe measures **L823**’s parent as `Revenue & Finance (V1)` (EA L818, LAYER 2 — the library’s own fee capability, which is what this gap asked about) and **L1408**’s parent as `Payment Gateway (V1)` (EA L1403, LAYER 4, whose sibling children are the gateway-integration nodes at EA L1405 and L1407 — **named here by line number rather than by vendor, because §14.1 forbids this document to name a payment provider**). **Gateway-executed refund is a different proposition from "may a library refund a fee in V1", and no Rank 1–4 document places it in V1** — BC Map L422 publishes `fee.RefundIssued` without stating the rail. Changing it would have been **inventing a V1 gateway capability**, so it is routed to the **Architecture Owner** as **`Q-A6`’s sibling `Q-A5`** (`ADR-0042` §8) rather than performed. **(ii) ⚠ This block’s own citation is defective and is disclosed rather than silently repaired:** the `Conflict`, `Status` and superseded `Freeze` text above cite *"EA L1409"* for the refund node, but **L1409 is `Payment Retry (V2)`**; the refund node is **L1408**, as the `Precedence determination` row correctly says. **The defect belongs to this document’s owner**, not to an ADR, and correcting a citation inside four superseded passages would rewrite retained evidence. *Superseded field retained verbatim:* ⛔ **STILL BLOCKS.** **This is not the same question as Stage 4 and is not decremented with it.** The Rank 6 EA still reads **`Refunds (V2)`** at **L823**/**L1409** while Rank 4 BC Map **L100**/**L374**/**L422** reads V1, and **`MP-CON-08`** requires the **EA** to be corrected to match the higher rank, *"never the reverse"*. That is an **Architecture Owner** act, **not performed here** — this PRD does not edit a Rank 6 document. **A PRD may be internally testable while an inter-document contradiction remains outstanding**, and freezing over one would freeze the contradiction in. *Superseded field retained verbatim:* **BLOCKS** |
| **Precedence determination** *(mechanical, not a decision)* | **The conflict is not symmetrical, and it must not be settled by downgrading the higher rank.** `DOCUMENTATION_BASELINE.md` §4 places the **Bounded Context Map at Rank 4** and the **Enterprise Architecture at Rank 6**, marked *"**Descriptive only.** Update it to match 1–5; never the reverse"*; `MP-CON-08` (**Rank 1**) repeats it: *"the higher-ranked document wins and the Enterprise Architecture is updated to match — never the reverse. A disagreement is a **defect to be raised**, not a choice to be made."* Re-measured at HEAD: BC Map **L100** (`BC-05` *"owns … refunds"*, Release **V1**), **L374** (`RefundRecord` in the `FeeLedger` aggregate, invariant *"refund ≤ received"*), **L422** (`fee.RefundIssued` published to `BC-26`, `BC-24`) — versus EA **L823**/**L1408** only. Additionally **FROZEN Rank 3** `PRD-005` **L942** routes a real V1 flow into it: a payment received for a voided membership *"**MUST** be recorded and surfaced in the reconciliation queue for a refund decision by `BC-05`"*. **Therefore: recording refund as V2 in this PRD would (i) subordinate Rank 4 and Rank 1 to Rank 6, which `MP-CON-08` forbids, and (ii) leave a frozen Rank 3 requirement depending on a capability declared not to exist. This PRD does not make that downgrade.** |
| **Recommended** | **Confirm refund IS V1** — the precedence determination above is mechanical; what requires the Product Owner is only the *scope* of V1 refund. Recommended minimum: owner-approved, compensating-entry-only (`MP-GBR-12` — financial records are immutable), `refund ≤ received` per BC Map L374, **no** partial-refund arithmetic (that is proration, and `MM-XC-012` places proration at V2). The **Architecture Owner** then corrects the EA to match per `MP-CON-08`. **No `FEE-*` requirement, state or event is written here on the strength of this recommendation** — `FEE-EVT-003` and the refund state table remain unwritten until the Product Owner decides, because a recommendation inside an open question *"is not a decision"* (`PRD-005` §7.4) |

### `FEE-GAP-002` — `BC-05`'s gateway path — ✅ **ALL FOUR LIMBS CLOSED at v1.2** *(heading superseded, retained: it read "the **transport is authorised**; the **counterparty is not** *(offline sync remains wholly open)*")*
| Field | Value |
|---|---|
| **Question** | Through which declared architectural edge does `BC-05` execute and reconcile an online payment? And through which does it queue an offline financial write? |
| **Conflict** | `E-25` is **`BC-20` → `BC-31`** (BC Map L334) · edges `BC-05`→`BC-31` = **0** · `E-24` is **`BC-03` → `BC-30`** (L333) · edges `BC-05`→`BC-30` = **0** · **but** `PRD_DEPENDENCY_GRAPH.md` L116 `D-14` asserts *"`PRD-008` … `E-25`"* · **and** Rank 4 Dependency Matrix L167 sets `LIBRARY MANAGEMENT → INTEGRATION` = **`✖`**, routing payments *"only via BUSINESS"*, with `X-03` naming the port `business.payment_intent` — which has **no numbered edge** from `BC-05` |
| **✅ Resolved by measurement — the *transport* is an already-authorised port, not a missing edge** | Re-measured at HEAD. **(i)** Rank 4 Dependency Matrix **§6** is declared by the document itself to be *"the **normative form** — what the lint rule checks"*, and **L196** lists `business.payment_intent` inside `library_management`'s `may_use_ports`. **`BC-05` is a `library_management` context** (BC Map L100), so **the port is already declared for the module that owns it**. **(ii)** **L167** forbids `LIBRARY MANAGEMENT → INTEGRATION` (`✖`) and *names the lawful alternative*: *"Integration is reached **only via BUSINESS (payments)**"*. **(iii)** `X-03` **L352** gives the remedy as an instruction: *"Call `business.payment_intent` port"*. **(iv)** The matrix cell `LIBRARY MANAGEMENT → BUS` is **`◇` (port, permitted)** while `→ INT` is `✖` — verified by **mechanical column alignment, 19 cells against 19 headers**, not read by eye. **(v)** Accepted **`ADR-0012` L86** already tabulates `domain/library → platform/business` as *"Already a declared port? **Yes — `:entitlement`, `:payment_intent`**"*. **Therefore no `E-*` edge is missing and none may be invented.** Accepted **`ADR-0033`** settled that BC Map L292 *"**governs edges**… It does **not** state that every cross-context read must be an edge"*; measured, **14 of `library_management`'s 17 declared ports have no usable numbered edge** (including `identity.policy_decision`, the authorisation port every context must call), so requiring one here would invalidate thirteen other lawful dependencies. Recorded in **`ADR-0035` `D-1`** |
| **✅ RESOLVED at v0.7 — the *counterparty* is decided** | **`ADR-0035` `D-2` selects `O-3`:** student→library **payment execution is a capability of the Business Platform** (`platform/business`, rank 6), **not** a bounded context. It receives **no `BC-` identifier** and the context count stays **31**. The decision passes the architecture's own `AR-1` test on all four criteria — payment execution owns **no aggregate** (`FeeLedger` is `BC-05`'s, BC Map L374), **no invariant** (`FEE-INV-005`/`FEE-BR-016`/frozen `MM-BR-005`), **no business state**, and **delegates** every domain operation — which is precisely the profile `AR-1` says must **not** become a context. Home confirmed by four ranked sources: Matrix **L167** (*"Integration is reached only via BUSINESS (payments)"*), **L196**, `X-03` **L352**, and frozen Rank 3 `PRD-005` **L164** (*"`BC-05` / **Business Platform**"* — the platform, not `BC-20`). `O-2` refused on Rank 1 `MP-GBR-24`, now also **CI-enforced** by the rank-0 shared kernel's `banned_symbols` (`class Payment ` → *"FeePayment (BC-05) or SubscriptionCharge (BC-20)"*); `O-1` refused on the `AR-1` test and the `PRD_REGISTRY.md` L355 precedent that created **no `BC-32`**. **No edge added, no Matrix change, no aggregate moved.** `ADR-0035` is **`PROPOSED`** pending recorded approval |
| **⛔ Superseded note — what was OPEN before v0.7** | The port has an **approved caller and no declared callee**. `platform/business` contains **exactly two** contexts — `BC-20` Subscription & Billing and `BC-21` Entitlement (BC Map L129–L130). `BC-21` owns only limits and gates. `BC-20` owns *"money owed by a **library to LIBOORA**"* — and **`MP-GBR-24` (Rank 1)** holds that student→library money *"**must never share a model, a table or a metric**"* with it, the very conflation Accepted `ADR-0015` was written to correct. Measured: `grep -rn "PaymentIntent" docs/` → **0 occurrences repository-wide**; `payment_intent` in the BC Map → **0**. **No context owns student-payment execution.** Recorded in **`ADR-0035` `D-2`**, with three options presented and **none recommended** |
| **⚠ Rank 1 internal tension — raised, not chosen** | `MASTER_PRD.md` **L232** routes *"Payments"* via *"`BC-20` via `BC-31`"*, while **L362** `MP-GBR-24` bars `BC-20` from student money. If L232 covers **student** payments the two Rank 1 statements contradict; if it covers only **SaaS** payments — consistent with `MP-DEP-04`'s *"SaaS Billing, fee collection"* — they agree and the counterparty is simply unassigned. Per `DOCUMENTATION_BASELINE.md` §4, *"a conflict is a defect — do not choose, raise it."* **This PRD does not choose** |
| **Impact** | ✅ **REMOVED for Stage 3 at v1.2.** All four limbs are closed, so this gap no longer blocks Stage 3 check 2 — the **last** gap that did. *Superseded text retained:* **Reduced again at v1.1, and still not removed.** The *route* is settled, so `FEE-PO-001` and `FEE-XC-005`/`FEE-XC-006` have a positive counterpart. *Superseded clause, retained so the change is legible:* the v0.7 text said payment execution, server-side verification and webhook reconciliation *"still cannot be specified, because no context is declared to implement the far end"* — **that obstacle is gone**: `D-2` (outbound) and `D-4` (inbound, `FEE-GAP-016`) are both **in force**, so **both ends are now declared** and `FEE-FR-026`/`027`/`028` have named counterparties. **What remains is exactly one thing:** offline financial capture (`BC-30`) is **wholly** unresolved — `E-24` is `BC-03` → `BC-30` only, edges `BC-05`→`BC-30` = **0**, and **no decision was given on it** |
| **Owner** | Architecture Owner *(for the Stage-4 remainder). **Limb (c) was closed by the PRODUCT OWNER, and the routing change is disclosed rather than quietly re-labelled.** Every prior pass routed (c) to the **Architecture Owner**, and that was **correct while the question was architectural** — it asked for an edge. The conferred decision changed the **kind** of question: *“through which edge does `BC-05` queue an offline write?”* is architectural, but *“does `BC-05` perform one at all?”* is **product scope**. Answering the second **removes** the first. `PRD_OWNERSHIP_MODEL.md` §2.2 gives the Architecture Owner authority over edges and boundaries; **there is no edge to rule on**, because the decision creates no traffic to carry.* |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** — to ratify `ADR-0035` `D-1` (transport, recognition of existing authority) and to decide `D-2` (counterparty). **A BC Map §7 amendment is *not* required and is *not* requested** |
| **Status** | ✅ **CLOSED at v1.7 — THE OWNER OF THE WIRE CONTRACT NOW EXISTS, AND THE CONTRACT IS STILL UNWRITTEN. Both halves of that sentence are load-bearing** (`ADR-0043` §3). `PRD-019_INTEGRATION.md` **v0.1 `DRAFT`** was created and assigns `ADR-0040` §4 **L165**’s five wire elements — endpoint, payload schema, signature algorithm, replay window, retry policy — to **`BC-31`**. **`PRD-008` keeps only webhook *verification* and financial truth, and the contract is NOT duplicated here.** ⚠ **The v1.5/v1.6 refusal to author the contract is UPHELD, not retracted:** of `ADR-0040` §2’s four barred authors, **three bars are substantive** (`SAAS-XC-006` bars `BC-20`; §14.1 bars this PRD; `ADR-0035` §5.5b bars inventing an endpoint/schema) **and only the procedural one — *"`PRD-019` does not exist"* — is removed by creating it.** ⛔ **What is therefore NOT closed: the gateway webhook FEATURE remains unbuildable**, because the five elements are **unspecified** — raised as **`Q-B31`** against the `BC-31` owner. **Creating an owner is not authoring a contract**, and this gap asked the *ownership* question. **No endpoint, schema, signature algorithm, replay window, retry policy or provider was invented anywhere in this pass.** *Superseded Status retained verbatim:* ✅ **RESOLVED for Stage 3 at v1.2 — (a) transport CLOSED by measurement (`ADR-0035` `D-1`); (b) counterparty CLOSED and IN FORCE (`ADR-0035` `D-2` = `O-3`); (c) offline-sync path **CLOSED — DISSOLVED, not routed** (`ADR-0037`, `ACCEPTED` by conferral of **Product Owner** authority).** **(c) is closed by denying its premise, not by declaring an edge.** The limb asked *through which declared edge `BC-05` **queues an offline financial write***. The conferred decision is that **`BC-05` never performs one**: cash payment is supported, but financial recording **MUST remain online/server-authoritative**, and the app **MUST NOT** perform an offline financial write, queue, local financial ledger or later sync. **A question of the form “which edge carries X?” is lawfully closed either by declaring the edge or by establishing that X does not occur** — this is the second, and it is the same shape as `ADR-0033`, which closed an edge conflict by **withdrawing `E-27`** rather than adding it to an allow-list. **No `BC-05` → `BC-30` edge was created and no `BC-32` was created**; `E-24` remains `BC-03` → `BC-30` only and the BC Map is byte-unchanged. **Nothing was specified to achieve this**: `FEE-FR-061` (server-side recording only; nothing confirmed offline) and `FEE-XC-022` (no offline write, queue, mirror or sync) **already said it**, verified by `FEE-AC-081`/`FEE-AC-082`, and neither is reworded. `MP-GBR-24` holds; idempotency is **strengthened**, because `FEE-FR-029` places the key at the **API edge** and removing the replay queue removes the failure mode `FEE-AC-082` guards. *Superseded Status text, retained so the movement is legible:* it read *"**PARTLY RESOLVED** … (c) offline-sync path **OPEN and BLOCKING**"*, and *"**(c) alone is now the whole reason this gap still blocks**"*. ⛔ **This closes the gap for Stage 3 ONLY.** The `Stage 4` field below is **deliberately left at BLOCKS** — closing a gap for one gate does not close it for another, and no decision was given on the Stage-4 concerns recorded in this block.** **(c) alone is now the whole reason this gap still blocks** — stated explicitly so the remaining blocker is not mistaken for the settled gateway question. `E-24` is `BC-03` → `BC-30` only; **no edge was added and none may be invented.** ⚠ **The acceptance of `ADR-0035` did NOT resolve (c), and nothing in the conferral addressed it.** The decisions given concerned payment execution, the inbound webhook, intent/verification ownership, gateway integration, settlement, rates, due days, cash-only settlement, trial length and renewal protection — **offline financial capture through `BC-30` was not among them.** This gap therefore **still BLOCKS Stage 4 and Freeze**. ⚠ **A correction made during this very pass, recorded rather than silently fixed:** a first draft of this row asserted *"the Stage-4 blocker count stays at **6**"* on the reasoning that `FEE-GAP-002` had not left the blocking set. **That was wrong.** `FEE-GAP-002` staying does not hold the count still — **`FEE-GAP-016` left**, so the count falls **6 → 5**. Re-derived mechanically from every gap block's own `Stage 4`/`Freeze`/`Blocks` field, the set is **`FEE-GAP-001`, `002`, `004`, `005`, `006`** = **five**. This is the exact mirror of the v0.7 defect this document already retracted, where a count was held still for the same kind of reason; **it is recorded here because a count that moves in the direction that flatters the document is the one that most needs checking** |
| **Stage 4** | ✅ **DOES NOT BLOCK from v1.5 — ownership limb CLOSED by determination; contract limb EXPLICITLY DEFERRED with a reason and an owner.** *The leading verdict of this field was **BLOCKS** through v1.4 and is superseded here; the whole of that text is retained verbatim below, beginning with the v1.3 cause:* **BLOCKS** — *and at v1.3 the remaining cause is named, not merely asserted:* **`FEE-FR-028`**, the webhook/reconciliation contract, carries **⛔ no acceptance criterion**, so Stage 4’s *“every requirement testable”* check cannot pass. `ADR-0035` §5.5b decided **who** owns the inbound webhook and explicitly decided **no** *“endpoint, URL, payload schema, field list, signature algorithm, header, replay window, retry policy or gateway provider”*. **An owner is not a contract.** Authority: **Architecture Owner** (`ADR-0038` §5 item 6). *This field is **unchanged in verdict** from v1.2; only its stated cause is now measured rather than inherited.* ⛔ **AT v1.4 A CONFLICT IS REPORTED HERE, AND IT IS NOT RESOLVED — THIS IS THE MOST IMPORTANT ADDITION TO THIS BLOCK.** A webhook contract was **offered** by the Product Owner in the form *“Payment Gateway → existing **`platform/integration`** capability → verification → `BC-05`”*. **Four of its five clauses agree with what is already decided** and are recorded as confirmations, not new decisions: **no `BC-32`** is created; the webhook is **transport/evidence only**; **`BC-05` remains the financial source of truth**; and **verification precedes recording**. ⛔ **The fifth clause — the routing owner — contradicts an `ACCEPTED` ADR, and is therefore reported rather than applied.** **`ADR-0035` §5.5b (L536)**, whose Status row reads *“**ACCEPTED** … In force. Binding on all implementation”*, states that the *“inbound payment webhook = existing **Business Platform** capability”* — that is **`platform/business`, rank 6**, **not** `platform/integration`. **These are distinct declared modules, not synonyms:** `tool/module_dependencies.yaml` **L406** declares `platform/business` at rank 6 and **L409** declares `ports: [platform/integration:payment_gateway]` — a **caller → callee** relation, which is precisely why one cannot be substituted for the other. §5.5b’s own reasoning was *“it places ingress with execution … splitting the outbound request from the inbound confirmation across two owners would have been the architecturally worse answer”*. ⚠ **A nuance recorded because it cuts against this document’s own convenience:** `ADR-0035` **L442**, written **pre-conferral**, itself proposed *“a capability declaration naming an inbound-adapter owner within **`platform/integration`**”* — matching the offered clause exactly. But **§5.5b superseded L442**, and **a superseded proposal is not authority**; resurrecting it to make the instruction fit would be inventing a workaround. **No routing change is made, no module is re-declared, no `provides_ports:` entry is written, and `tool/module_dependencies.yaml` is byte-unchanged.** Escalated to the **Architecture Owner** as the only party who may reconcile the two, and recorded in **`ADR-0039` §2**. ⛔ **Even if the routing were settled today, this field would still read BLOCKS**, because §5.5b decided **who** owns ingress and expressly decided **no** *“endpoint, URL, payload schema, field list, signature algorithm, header, replay window, retry policy or gateway provider”* — so `FEE-FR-028` would still carry **⛔ no acceptance criterion**. **An owner is not a contract, and a conflict about the owner is not a contract either.** ✅ **AT v1.5 THE OWNERSHIP CONFLICT IS AUTHORITATIVELY RESOLVED, AND THIS FIELD NOW READS DOES-NOT-BLOCK. BOTH HALVES OF THAT SENTENCE ARE LOAD-BEARING.** **(1) The conflict is closed by DETERMINATION, not by substitution.** It was routed to the **Architecture Owner**, who **UPHELD `ACCEPTED` `ADR-0035` §5.5b UNCHANGED**: ingress is owned by **`platform/business`**, recorded in **`ACCEPTED` `ADR-0040` §1**. **The `platform/integration` reading is NOT adopted and NOT recorded as a decision** — and the evidence that favoured it is preserved rather than buried: `ADR-0035` **L442**, written pre-conferral, itself proposed an inbound adapter *within* `platform/integration`, but §5.5b **superseded** L442 and **a superseded proposal is not authority** (`ADR-0040` §1.2). §5.5b's reasoning was **re-tested against the manifest, not taken on trust**: **L406** declares `platform/business` at rank 6 and **L409** declares `ports: [platform/integration:payment_gateway]`, a **caller → callee** relation — so naming the callee as the owner of the **return leg** of a call it does not initiate is exactly the split §5.5b rejected. **`tool/module_dependencies.yaml` is byte-unchanged; no `BC-32`; no `E-*` edge; no `provides_ports:` entry.** **(2) The Stage-4 concern is discharged WITHOUT a wire contract, which is the part that required a finding rather than a decision.** `ADR-0040` §2 established **by measurement** that **no document may currently author that contract**: `PRD-022`'s own **`SAAS-XC-006`** (L157-158) bars **`BC-20`** from *“naming a payment provider, endpoint, **webhook schema**, signature algorithm, retry policy”* and assigns vendor knowledge to **`BC-31`**; **`PRD-019`**, `BC-31`'s PRD, is **`PLANNED` and does not exist** (`PRD_REGISTRY.md` **L309**); this document forbids itself the same at **§14.1**; and §5.5b forbids *“invent[ing] an endpoint/schema”*. **Four candidate authors, all barred — so waiting for a contract before making `FEE-FR-028` testable would have meant waiting on a document that cannot yet be written.** **The resolution is that `FEE-FR-028` tests `BC-05`'s OWN verification obligation**, which §5.5b **expressly left with `BC-05`**: *“`BC-05` keeps payment intent, the **verification obligation** and student financial truth”*. `FEE-AC-085`…`089` now assert that an inbound notification alone does not leave `PENDING`, settles nothing, issues no receipt, emits no event, yields **exactly one** confirmed payment on replay (`FEE-INV-005`), and is **surfaced not applied** when it matches nothing. **Not one of them names an endpoint, URL, payload field, signature algorithm, header, replay window, retry policy or provider** — and the shape is **not invented**: `FEE-AC-032`/`033`/`034` already test the identical *evidence-never-instruction* rule (`FEE-BR-014`) for the **client-side-hint** case, so v1.5 **extends an established pattern to its sibling case**. ⚠ **WHAT IS STILL OPEN, STATED SO IT CANNOT BE MISREAD AS CLOSED:** the **wire contract** — endpoint, payload schema, signature algorithm, header, replay window, retry policy, provider — **remains unspecified**, owned by the **`BC-31` owner once `PRD-019` exists**. **This gap is therefore NOT marked RESOLVED**; its **ownership limb** is closed and its **contract limb** is **explicitly deferred with a reason and an owner**, which is the disposition `PRD_LIFECYCLE.md`'s Stage-4 gate permits. **Claiming full resolution because `ADR-0040` exists would be the precise defect the principal forbade.** *Superseded field retained verbatim below, so that the movement from BLOCKS to DOES-NOT-BLOCK is auditable rather than asserted:* |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — the OWNERSHIP question this gap asked is answered, and the unwritten contract is carried as `Q-B31` against a NAMED owner rather than as a `PRD-008` defect.** `PRD-019` exists (**v0.1 `DRAFT`**) and owns the wire; this PRD owns verification and financial truth and **duplicates nothing** (`ADR-0043` §3). ⛔ **The gateway FEATURE is still unbuildable** — that is `Q-B31`’s burden, and it follows the **existing precedent** used by `FEE-GAP-013`/`014`/`017`: a question **blocks the feature, not this PRD**, once it has a lawful owner elsewhere. ⚠ **The v1.6 report that the instruction was UNEXECUTABLE is NOT withdrawn** — it was correct about *authoring* the contract, which still has not happened; the new instruction asked only for the **owner**. *Superseded verdict retained verbatim:* ⛔ **STILL BLOCKS — and the instruction to close it was measured UNEXECUTABLE, which is reported here rather than worked around.** The conferred decision was to *"create/define the required `PRD-019` webhook contract; `PRD-008` owns verification and financial truth only."* **The second half is already true and is confirmed** — this PRD claims verification and financial truth and nothing else, tested by `FEE-AC-085`…`089` without naming a single wire element. ⛔ **The first half cannot be performed by this pass, and the reason is a direct collision with the same instruction’s Rule 2 — "do not invent permissions, APIs, schemas, providers, edges or financial rules."** `ACCEPTED` `ADR-0040` **§4 L165** defines the outstanding contract as *"endpoint, schema, signature, replay window, retry policy"* — **item for item the things Rule 2 forbids inventing** — and **L166** states that writing another PRD’s content here *"would create a **second source of truth**"*. Re-measured at HEAD: files matching `PRD-019` = **0**, and all four candidate authors remain barred (`ADR-0040` §2 **L77–L83**: `PRD-022`’s `SAAS-XC-006` bars `BC-20`; `BC-31`’s `PRD-019` is `PLANNED` and does not exist per `PRD_REGISTRY.md` **L309**; this PRD’s own §14.1 bars itself; `ADR-0035` §5.5b bars invention). **A contract cannot be authored into a document that does not exist, and authoring it here is the one thing every ranked source forbids.** ✅ **What was done instead of pretending:** the work is split and each half given a named owner in `ADR-0042` §7.1 — **`Q-G2`: create `PRD-019` (or authorise another home) — **Governance Owner**; **`Q-B31`: author the webhook wire contract once it exists — **`BC-31` owner**. **No endpoint, schema, signature algorithm, header, replay window, retry policy or provider is named anywhere in this document**, and `tool/module_dependencies.yaml` is byte-unchanged. *Superseded field retained verbatim:* ⛔ **STILL BLOCKS — and this is NOT decremented alongside Stage 4, deliberately.** Stage 4 asks whether this PRD's own requirements are **testable**; Freeze asks whether the specification is **complete**. The **webhook wire contract is still unwritten** and cannot be written by any existing document (`ADR-0040` §2/§4), so freezing `PRD-008` now would freeze a **named, owned hole** into a baseline. **The owner is identified and the reason is stated — which satisfies Stage 4's deferral clause and fails Freeze's completeness bar, and those two verdicts are not in tension.** *Superseded field retained verbatim:* **BLOCKS** |
| **Recommended** | **1.** Ratify **`ADR-0035` `D-1`** — this *recognises* an authorisation four ranked documents already grant; it grants nothing new. **2.** Decide **`D-2`** from the three options in `ADR-0035` §6 (`O-1` new context · `O-2` `BC-20` executes the rail but models no student money · `O-3` a platform capability owning no aggregate). **This PRD recommends none of the three** — each carries a real cost and `MP-GBR-24` is a Rank 1 rule whose interpretation is not this document's to settle. **3.** State who owns **webhook/verification receipt** under the chosen option; without it server-side confirmation cannot be specified. **4.** ~~Authorise the `D-14` correction (`ADR-0035` `D-3`).~~ ✅ **DONE at v1.3 — authorised 2026-08-05, EXECUTED 2026-08-15** by `ADR-0038` §2.1. `PRD_DEPENDENCY_GRAPH.md` L116’s false `E-25` citation is removed; measurement additionally showed the **`PRD-020` half is mis-cited on the same evidence** (`BC-13`’s only edge is `E-14`), disclosed rather than silently widened, and **no replacement edge is asserted** for `PRD-020`. `BC-05`’s route is the already-declared **port** `business.payment_intent`, not an edge. ⚠ **This removed a false citation, NOT a blocker** — see the `Stage 4` field, which is **unchanged at BLOCKS**. **Do not** widen the Core-cluster allow-list and **do not** add an `E-*` edge — `ADR-0033` refused exactly that, and §L196 makes it unnecessary |

### `FEE-GAP-003` — Bank transfer has no source
| Field | Value |
|---|---|
| **Question** | Is bank transfer a V1 payment method? |
| **Absence** | Named in **no** source: not BC Map L202 (*"cash/UPI"*), not EA L1395–1401 (Online/Cash/UPI/Card), not the Master PRD, not any frozen PRD |
| **Impact** | Indian libraries do receive NEFT/IMPS. If omitted, staff will record it as cash and corrupt method-based reporting |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **CLOSED at v1.7 — the scope decision STANDS and the operational residual is ANSWERED BY OBLIGATIONS THIS PRD ALREADY CARRIED, so nothing new was written** (`ADR-0043` §4). Bank transfer is **not** a V1 payment method. The residual v1.6 named — *what happens when a NEFT credit appears anyway* — is determined without a new rule: **out-of-band money cannot automatically become a confirmed payment** because financial confirmation is **server-authoritative** (**`FEE-FR-061`**, **`FEE-XC-022`**), attested recording is bounded by `FEE-BR-011`/`FEE-BR-014` and tested by **`FEE-AC-081`**/**`FEE-AC-082`**, and `ACCEPTED` **`ADR-0037`** bars any offline financial write. **§13.4 and the §13 method table now say so, citing only existing identifiers.** ⚠ **No `FEE-XC-*` exclusion was minted** — a twenty-fourth would move §0.2’s declared register to record a rule already enforced. *Superseded Status retained verbatim:* ⚠ **DECIDED IN THE NEGATIVE at v1.6 — bank transfer is NOT V1 — RECORDED IN `ACCEPTED` `ADR-0042` §6.3. ⛔ STILL BLOCKS FREEZE, and the reason is narrower than the decision.** The **Product Owner** has decided that bank transfer is **not a V1 payment method** and is **explicitly deferred/excluded**. **This answers the exact question this block asked** — *"Is bank transfer a V1 payment method?"* — with a **No**, which is a lawful and complete answer to it. ⚠ **NO `FEE-XC-*` EXCLUSION WAS MINTED, and that restraint is deliberate rather than an omission.** A twenty-fourth `FEE-XC-*` entry would move §0.2’s exclusion register **23 → 24** and its Total **249 → 250**, which this document’s own **L66–L71** note and §32’s closing note at **L1547** both exist to prevent — L1547 records that a prior pass added no exclusion precisely because the matter was *"already excluded"* in substance. **Bank transfer is already unrepresentable: `FEE-BR-011` enumerates the staff-attested methods and it is not among them**, so an exclusion identifier would record the same fact twice and inflate the obligation count without adding an obligation. *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | Does not block *(clean omission)* |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — the residual this field itself named is answered, and it is answered by obligations that were already here.** This field required a product rule for staff facing an out-of-band bank credit. **That rule exists and always did:** such a credit **is not a payment**, and **no supported V1 flow lets staff make it one** — `FEE-FR-061` (server-authoritative confirmation), `FEE-XC-022`, `FEE-AC-081`/`082`, `ADR-0037`. **Financial confirmation stays server-authoritative**, which is precisely what the conferred decision required. *Superseded verdict retained verbatim:* **BLOCKS** — **and the surviving residual is NOT the scope question, which is now answered, but the operational consequence this block’s own `Impact` row named.** That row states: *"Indian libraries do receive NEFT/IMPS. If omitted, staff will record it as cash and corrupt method-based reporting."* **Deciding that the method is out of scope does not tell a member of staff what to do when a NEFT credit appears in the library’s bank account** — and the two lawful answers (refuse to record it, or record it under an existing attested method) are **different product rules with different reporting consequences**, neither of which is stated by any source. Writing either would be inventing a financial rule (Rule 2). Routed as **`Q-P1` — Product Owner** (`ADR-0042` §8): *state what staff do when an out-of-band bank credit is received in V1.* **The `Recommended` row below is now superseded in substance** — it proposed approving bank transfer as a staff-attested method, and the conferred decision went the other way; it is retained because it is the record of what was recommended and refused. *Superseded field retained verbatim:* **BLOCKS** — a method used in practice but unrepresentable is a V1 defect |
| **Recommended** | Approve bank transfer as a **staff-attested** method (same class as out-of-band UPI, `FEE-BR-011`), needing no gateway and therefore not entangled with `FEE-GAP-002` |

### `FEE-GAP-004` — No approved fee-type taxonomy
| Field | Value |
|---|---|
| **Question** | Which fee types are V1: admission, membership, renewal, joining/registration, deposit, "other charges"? |
| **Absence** | `grep` for these terms across `docs/30-product/` and `docs/10-architecture/` = **0 matches**. Sources provide only a generic fee structure (EA L822) and `FeeDue` |
| **Impact** | Fee-type reporting (§22.1) has no defined domain. Deposits especially: a refundable deposit is a **liability**, not revenue, and would change the ledger model |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **DECIDED at v1.4 — RECORDED IN `ADR-0039` §4, NOT SELF-ACCEPTED. ⛔ STILL BLOCKS STAGE 4 AND FREEZE.** V1 fee types are **Membership Fee**, **Renewal Fee**, **Registration / Admission Fee**, **Other approved library fee** — all revenue — and **Security Deposit**, which is ⛔ **NOT revenue** but a **refundable liability**. **This answers the exact question this block asked**, including the *“Decide `deposit` separately”* instruction in the `Recommended` row: the deposit is ruled a liability, which is what the `Impact` row said *“would change the ledger model”*. ✅ **It also discharges a cross-PRD dependency without closing another PRD’s gap** — `PRD-022` **L802** `SAAS-GAP-001` asks *“3% of what? … A rate without a base computes nothing”*, and a fee-type taxonomy that separates revenue from refundable liability supplies the missing **base**. `SAAS-GAP-001` is nevertheless **left OPEN**, because it is `PRD-022`’s to close and `FEE-XC-023` forbids this module from holding the Platform Charge at all; closing it here would be the precise ownership violation `FEE-XC-023` exists to prevent. **No `FEE-*` identifier, enum, configuration row or ledger account is created by this row** — measured: *“security deposit”* appears **2** times in `docs/`, neither as a `FEE-*` identifier. ⛔ **§22.1’s report still has no testable criterion**, so the `Stage 4` verdict below is **unchanged**: a dimension being *decided* is not the same as the report over it being *specified*. *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | ✅ **DOES NOT BLOCK from v1.5 — and the reason is narrower than it looks, so it is stated precisely.** The Stage-4 concern was that §22.1 cites *"Collection by fee type"*, a report **over a dimension this PRD does not define**. Re-measured at v1.5: **§22.1 assigns every one of those reports to `BC-26`**, and this PRD *"claims **no** report as a V1 deliverable of `BC-05`; it delivers **facts**"*. The **fact** `BC-05` owns is the obligation's fee-type value, already required by **`FEE-FR-006`** (*"a configurable value obtained through `E-19`, not a hard-coded enumeration"*) and traced by `FEE-AC-013`. **No `BC-05` requirement is left untestable by the report's absence**, because the report is not `BC-05`'s. ⚠ **What is NOT claimed:** the fee-type **taxonomy** decided in `ADR-0039` §4 (four revenue types + Security Deposit as a refundable **liability**) is **NOT written into this PRD as an enumeration**, deliberately — `FEE-FR-006` forbids a hard-coded list, so writing one would **contradict this PRD's own requirement**. The taxonomy is a **configuration value** supplied through `E-19`, and **no `FEE-CFG-*` register is opened** (`FEE-GAP-007`). *Superseded field retained verbatim:* **BLOCKS — §22.1 cites a report over an undefined dimension. *Verdict unchanged at v1.4: the dimension is now **decided** (`ADR-0039` §4) but §22.1’s report is still **unspecified**, and `ADR-0039` is **`PROPOSED`**.*** |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.6 — the decided taxonomy now BINDS, because the ADR that carried it has been ACCEPTED.** This field’s cause was never the absence of a decision; it was that the decision sat in a **`PROPOSED`** ADR and *"a decision recorded in a `Proposed` ADR does not bind"*. **`ADR-0039` was promoted `PROPOSED` → `ACCEPTED` on 2026-08-15** by the **Architecture Owner** (`PRD_OWNERSHIP_MODEL.md` **L85**), so its **§4** fee taxonomy — Membership Fee, Renewal Fee, Registration/Admission Fee, Other approved library fee (all revenue) and **Security Deposit as a refundable liability, NOT revenue** — is now in force. ⚠ **The acceptance is SCOPED, and the scope matters to this gap:** §3–§6 bind (§4 is the taxonomy this gap needed), §2 is accepted as a **report** only, and **§7 is marked SUPERSEDED BY MEASUREMENT and retained verbatim** — its claim that four obligations still carry `⛔ none` was re-measured as **false** (`FEE-FR-028` L1882, `FEE-FR-042` L1896, `FEE-BR-007` L1919, `FEE-BR-019` L1931 all carry criteria; rows with `⛔ none` = **0**). ✅ **Still NOT done, and still deliberately:** the taxonomy is **not** written into this PRD as an enumeration, because `FEE-FR-006` requires the fee type to be *"a configurable value obtained through `E-19`, not a hard-coded enumeration"* — writing the list here would contradict this PRD’s own requirement. **No `FEE-*` identifier, enum, `FEE-CFG-*` row or ledger account is created**, and `PRD-022`’s `SAAS-GAP-001` stays **OPEN** because `FEE-XC-023` forbids this module from holding the Platform Charge. Recorded in `ADR-0042` §3. *Superseded field retained verbatim:* **BLOCKS** |
| **Recommended** | Approve a minimal V1 list. **Decide `deposit` separately** — if refundable it is not revenue and interacts with `FEE-GAP-001` |

### `FEE-GAP-005` — No authorised correction path for a mis-entered obligation
| Field | Value |
|---|---|
| **Question** | How is a genuinely wrong `FeeDue` amount corrected, given `FEE-BR-005`/`FEE-INV-002` immutability? |
| **Absence** | `MP-GBR-12` forbids in-place edits and **deliberately removed** the *"except through approved workflows"* loophole. No source authorises cancel-and-reissue |
| **Impact** | Staff face an uncorrectable error, and will work around it — the classic driver of shadow ledgers |
| **Owner** | Product Owner + Architecture Owner |
| **Authority** | **REQUIRES PRODUCT OWNER + REQUIRES ARCHITECTURE OWNER** |
| **Status** | ✅ **DECIDED at v1.4 — RECORDED IN `ADR-0039` §5, NOT SELF-ACCEPTED. ⛔ STILL BLOCKS STAGE 4 AND FREEZE.** Financial corrections are **append-only**: the original record is **immutable**, and a correction or reversal **references the original** and records **actor, reason, timestamp and corrected state**. There is **no edit and no delete** of historical financial truth. ✅ **This rests on Rank 1 directly, and deliberately NOT on the analogy this block’s own `Recommended` row offered.** `MP-GBR-12` (`MASTER_PRD.md` **L353**) already states that *“a refund is a **compensating entry, never a mutation**”*, so append-only correction is a **restatement of Rank 1**, not a new rule. The `Recommended` row cited *“`BC-03`’s append-only correction model”* as support; `ADR-0038` measured that citation and warned it risks **re-inserting the *“except through approved workflows”* loophole that Rank 1 deliberately deleted** — recorded in this block’s own `Absence` row. **The decision therefore leans on `MP-GBR-12` and not on the analogy**, and the `CANCELLED`-plus-reissue shape the `Recommended` row proposed is **neither adopted nor rejected here**, because a state value is a `PRD-008` specification act. ⛔ **Why both gates still block:** `FEE-BR-007` (L1754) still carries **⛔ no acceptance criterion**; **no** `FEE-*` requirement, state value, permission or audit-field list is written by this row; and the **Architecture Owner** half of the `Authority` row — how an append-only correction is modelled against `FEE-BR-005`/`FEE-INV-002` immutability — is **not** answered by a product decision. *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | ✅ **DOES NOT BLOCK from v1.5.** The named cause is discharged: the append-only correction obligation **`FEE-FR-043`** now carries **`FEE-AC-098`** (a correction creates a **new** compensating record with actor, reason, timestamp and corrected state, and **no** API path edits or deletes the original), and **`FEE-BR-007`** — cited in the superseded field below — carries `FEE-AC-096`/`097`. ✅ **The trap this block set for itself is still avoided:** `FEE-AC-098` rests on **`MP-GBR-12`** directly (*"a compensating entry, never a mutation"*) and **not** on the `BC-03` analogy `ADR-0038` warned would re-insert the *"except through approved workflows"* loophole Rank 1 deliberately deleted. **No `CANCELLED`-plus-reissue state value is created**, because `FEE-FR-043` already expresses the rule without one. *Superseded field retained verbatim:* **BLOCKS — *verdict unchanged at v1.4; the cause is now named rather than inherited:* **`FEE-BR-007`** carries **⛔ no acceptance criterion**, so `PRD_LIFECYCLE.md` **L108–L120** check 1 cannot pass. The **policy** is decided (`ADR-0039` §5); the **obligation** is still untestable.** |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.6.** The **Product Owner** decision that financial corrections are **append-only** is confirmed and now **binds**, because `ADR-0039` — which recorded it at §5 — is **`ACCEPTED`** as of 2026-08-15. Both halves this field required are therefore present: the **policy** (append-only; the original is immutable; a correction references the original and records actor, reason, timestamp and corrected state; **no edit and no delete**) and the **specification** that expresses it — `FEE-FR-043` with `FEE-AC-098`, and `FEE-BR-007` with `FEE-AC-096`/`097`. ✅ **The trap this block set for itself remains avoided:** the rule rests on **Rank 1 `MP-GBR-12`** (*"a compensating entry, never a mutation"*, `MASTER_PRD.md` **L353**) and **not** on the `BC-03` analogy the `Recommended` row below offered, which `ADR-0038` measured as risking re-insertion of the *"except through approved workflows"* loophole Rank 1 deliberately deleted. **No `CANCELLED`-plus-reissue state value was created**, no permission was invented and no audit-field list was added — `FEE-FR-043` already expresses the rule without them. Recorded in `ADR-0042` §5. *Superseded field retained verbatim:* **BLOCKS** |
| **Recommended** | Authorise `CANCELLED` + new obligation, both audited with actor and reason, as a **compensating pair** — consistent with `MP-GBR-12` and with `BC-03`'s append-only correction model |

### `FEE-GAP-006` — Due-date computation rule undefined *(the three-concept ambiguity is now CLOSED; the offset is not)*
| Field | Value |
|---|---|
| **Question** | How is a `FeeDue`'s due date computed, and what grace applies before `OVERDUE`? |
| **✅ Resolved by measurement — the three concepts are distinct and must not be conflated** | Three different dates were being discussed as if they were one. Measured at HEAD: **(i) Membership term end date — `endDate`, owned by `BC-02`, FROZEN.** `MM-FR-057`: *"`endDate` **MUST** be computed as `startDate + (durationDays − 1)` days, using calendar-date arithmetic in the tenant's timezone"*, and `MM-FR-058` makes it a **pure function** that *"**MUST NOT** depend on the current clock"*. `BC-05` **MUST NOT** compute, re-derive or override it (`FEE-XC-020`). **(ii) Fee-obligation due date — `BC-05`'s own field.** `FEE-FR-013` requires a `FeeDue` to carry one and `FEE-FR-048` derives `OVERDUE` from it. Measured: `grep -ni 'due date\|dueDate'` over FROZEN `PRD-005` → **0 occurrences**, so no frozen document defines, constrains or supplies this date — **it is unambiguously `BC-05`'s to specify**, and it is *not* `endDate` under another name. **(iii) Renewal-protection window — neither of the above.** Product intent places it *after* entitlement ends; it is unsourced and carried by `FEE-GAP-013`(a2). **Consequence:** the ambiguity is closed, but **no offset, grace period or arithmetic is created here**. `MM-FR-111` forbids a V1 grace period *"that extends entitlement beyond `endDate`"*, and a fee-collection due date is **not** an entitlement extension — conflating the two would accidentally invent the grace period `MM-GAP-001`/`Q-01` leaves open. **The renewal-protection window is a separate product rule and MUST NOT be described as a generic "grace period"** |
| **Absence** *(what genuinely remains)* | The **offset itself**. `E-06` supplies a `HolidayCalendar` *"for proration and freeze-day computation"* but **no offset, grace or arithmetic** is specified anywhere, and no configuration register holds one — `CONFIGURATION_GUIDE.md` v1.1 governs 35 parameters (`CFG-*`, `LCFG-*`, `ICFG-*`) and **none is a payment-due offset**; its §5 requires *"a PRD amendment"* to add one. **No default, minimum, maximum or range is invented here** |
| **Impact** | `OVERDUE` (§29.1) has no computable boundary; `FEE-AC-020`/`021` cannot be implemented deterministically |
| **Owner** | Product Owner *(policy)* + `BC-06` owner *(calendar semantics)* |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **OFFSET VALUE NOW DECIDED at v1.4 — RECORDED IN `ADR-0039` §6, NOT SELF-ACCEPTED. ⛔ STILL BLOCKS STAGE 4 AND FREEZE.** **V1 due-date offset = 0 days.** The configured settlement due date **is** the actual due date; there is **no hidden `+N`-day calculation**. A future grace period or non-zero offset requires a **separately governed decision**. **This closes exactly the part this Status row left open — the value — and nothing else.** ✅ **The two traps this block set for itself were both measured, not stepped in.** (i) `PRD-006` §10A.4’s precedent requires a temporal rule to be *“not derived, inferred, or defaulted”*: **0 chosen explicitly is not 0 defaulted silently**, and the value is stated, not inherited. (ii) **`MP-GBR-24` holds.** Offset **0** imports **no value** from `PRD-022`’s ratified **15th** settlement due day — that governs **library → LIBOORA** money (`BC-20`), this governs **student → library** money (`BC-05`), and the two *“must never share a model, a table or a metric”*. Had the decision read *“due on the 15th”* it would have been a Rank 1 violation; **it does not, and that distinction is the whole reason this is safe**. `PRD-022`’s 15th is **preserved, untouched**. ⛔ **Why both gates still block:** no `FEE-*` requirement text is written, **no `CFG-*`/`FEE-CFG-*` configuration row is created** (`CONFIGURATION_GUIDE.md` §5 requires *“a PRD amendment”* to add one, and none is made here), and `FEE-AC-020`/`FEE-AC-021` therefore **remain non-deterministic** until `PRD-008` records the rule as a requirement. *Superseded Status text retained verbatim:* **PARTLY RESOLVED — the three-concept ambiguity is CLOSED by measurement; the offset value remains OPEN** |
| **Stage 4** | ✅ **DOES NOT BLOCK from v1.5.** The named cause is discharged: **`FEE-BR-007`** now **states the value** — the V1 due-date offset is **`0` days**, the recorded due date **is** the effective due date, and this module **MUST NOT** apply any offset, grace period or added calendar arithmetic. `FEE-AC-096` tests exactly that equality and `FEE-AC-097` tests that `OVERDUE` is reproducible with offset `0` and no scheduled job — so **`FEE-AC-020`/`021` are now deterministically implementable**, which was the precise obstacle. ✅ **Both traps re-checked at v1.5, not assumed:** (i) **`0` is stated, not defaulted**, satisfying `PRD-006` §10A.4's *"not derived, inferred, or defaulted"*; (ii) **`MP-GBR-24` holds** — offset `0` imports **no value** from `PRD-022`'s ratified **15th**, which governs library → LIBOORA money, and `PRD-022` is **byte-unchanged**. **No configurable is created**, so Stage 4's *"every configurable has a default and a range"* check gains **no new obligation**. *Superseded field retained verbatim:* **BLOCKS — `FEE-AC-020`/`021` are still not deterministically implementable. *Verdict unchanged at v1.4: the **offset value** is decided (`ADR-0039` §6) but no requirement expresses it, so the acceptance criteria remain unimplementable. **A decided policy that no requirement states is not a testable requirement.**** |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.6.** The **Product Owner** decision that the V1 due-date offset is **0 days** now **binds**, `ADR-0039` §6 having been **`ACCEPTED`** on 2026-08-15, and the requirement that states it is already written and tested: **`FEE-BR-007`** carries the value (the recorded due date **is** the effective due date; this module **MUST NOT** apply any offset, grace period or added calendar arithmetic), with `FEE-AC-096` testing the equality and `FEE-AC-097` testing that `OVERDUE` is reproducible at offset `0` with no scheduled job. ✅ **Both traps re-checked, not assumed:** (i) **`0` is stated, not defaulted**, satisfying `PRD-006` §10A.4’s *"not derived, inferred, or defaulted"*; (ii) **`MP-GBR-24` holds** — offset `0` imports **no value** from `PRD-022`’s ratified **15th** settlement day, which governs library → LIBOORA money, and `PRD-022` is byte-unchanged at `d7138c5d8a24e19d`. ✅ **No configuration row was created** — no `CFG-*`, no `LCFG-*`, no `FEE-CFG-*` — so `CONFIGURATION_GUIDE.md` §5 is not engaged and Stage 4’s *"every configurable has a default and a range"* check gains no new obligation. **A future non-zero offset or grace period requires a separately governed decision**, which is a new question and not this gap. Recorded in `ADR-0042` §5. *Superseded field retained verbatim:* **BLOCKS** |
| **Recommended** | Approve an explicit rule with a stated range, expressed as an offset from an **`BC-05`-owned** anchor — **not** as an adjustment to `endDate`, which `MM-FR-058` makes a clock-independent pure function that this module may not touch. **Do not** default it silently — `PRD-006` §10A.4 set the precedent that a temporal rule must be *"not derived, inferred, or defaulted"*, and `ADR-0031` set the precedent that a configuration row is **refused rather than invented** when no owner has approved a range |

### `FEE-GAP-007` — No approved discount authority set or ceiling; no config register
| Field | Value |
|---|---|
| **Question** | Which roles are "authorised approvers" for discounts, and is there a maximum? |
| **Absence** | BC Map L374 says *"an authorised approver role"* without naming it. No source approves a percentage, ceiling or range |
| **Impact** | §23.1's discount row is partly unresolved; no `FEE-CFG-*` register can be opened |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **BOTH LIMBS CLOSED at v1.7 — the APPROVER SET is now named, using the EXISTING access-control mechanism and inventing nothing** (`ADR-0043` §5). **The Library `owner` is the ultimate authority and the sole approver by default; `manager` has NO approval access by default.** The `owner` may **explicitly grant** approval access through Master PRD **§6.1**’s existing mechanism: `MP-GBR-20` (grants are **scope-bearing**), `MP-GBR-21` (the scope register is **closed** — `self` · `guardianOf` · `tenantWide`, and **no fourth scope was added**), `MP-GBR-23` (one global account, **independent per-library grants**). ⚠ **NO new permission identifier was invented** — no `FEE-CFG-*` and no `FEE-PERM-*` register was opened — and **no new role was created**, so **`FEE-XC-014`’s bar is honoured rather than circumvented**. **`MP-GBR-28` puts full ABAC at V3**, so V1 relies on the closed scope set already in force. §23.1’s discount row is corrected accordingly. *Superseded Status retained verbatim:* ⚠ **PARTLY DECIDED at v1.6 — the CEILING limb is CLOSED by a decision not to have one; the APPROVER-SET limb is STILL OPEN — RECORDED IN `ACCEPTED` `ADR-0042` §7.2.** ✅ **Ceiling — CLOSED, and closed by restraint.** The conferred instruction was *"do not invent a discount ceiling"*, and it was followed **exactly**: no percentage, no maximum, no minimum, no range and **no `FEE-CFG-*` register** exists anywhere in this document. This matches the `PRD-006` precedent the `Recommended` row cites and the `ADR-0031` precedent that a configuration row is *"refused rather than invented"*. ⛔ **The second limb of that instruction — *"if not required for V1, defer/exclude discounts"* — was NOT executed, because its precondition was MEASURED FALSE, and that measurement is reported rather than overridden.** Discounts **are** required for V1, on four independent sources: **(i)** Rank 4 BC Map **L100** lists *"discounts"* among what `BC-05` owns, with Release = **V1**; **(ii)** Rank 4 BC Map **L374** makes `Discount` one of the **five declared `FeeLedger` members** and attaches the invariant *"discount requires an authorised approver role"*; **(iii)** this PRD **already specifies** them — `FEE-FR-038`, **`FEE-FR-039` (L1001)**, `FEE-FR-040`, `FEE-FR-041` and `FEE-INV-007`; **(iv)** they are **already testable** — `FEE-FR-039` carries **`FEE-AC-049` (L1893)**. **Excluding them would delete a Rank 4 aggregate member and its invariant on the strength of a V1 scope note — the exact rank inversion `MP-CON-08` forbids** (*"the higher-ranked document wins … never the reverse. A disagreement is a defect to be raised, not a choice to be made."*). Per `DOCUMENTATION_BASELINE.md` §4 **L224**, this is raised, not chosen. *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | Does not block — the **approver-role requirement** is specified (`FEE-FR-039`); only its membership and any ceiling are open |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — the one thing this field named as keeping it blocking, the membership of the approver set, is now decided.** **`owner` by default; `manager` none; grantable by the `owner` through the existing §6.1 scope-bearing mechanism.** **No permission ID, role or scope value was invented**, and the ceiling limb was already closed by a decision not to have one. *Superseded verdict retained verbatim:* **BLOCKS** — **and exactly ONE thing now keeps it blocking: the membership of the approver set.** The ceiling limb is closed (see `Status`) and the discount requirements are specified and testable, but **§23.1 L1198 still carries a live unresolved marker** — *"Approve discount | `owner` — ⛔ whether `manager` also, `FEE-GAP-007`"* — and BC Map **L374** names *"an authorised approver role"* **without naming it**. **Naming `manager` would be inventing a permission (Rule 2); removing `manager` from consideration would be deciding a product question this PRD does not own.** Routed as **`Q-P2` — Product Owner** (`ADR-0042` §8): *is `manager` also an authorised discount approver in V1, or is `owner` the sole approver?* **A single word from the Product Owner closes this gap in full**; nothing else about it remains. *Superseded field retained verbatim:* **BLOCKS** |
| **Recommended** | Name the roles explicitly. Add a ceiling **only** if the Product Owner approves a range; otherwise rely on the approver control, as `PRD-006` did when it refused an unapproved configurable |

### `FEE-GAP-008` — Partial payments V2 has a real V1 cost
| Field | Value |
|---|---|
| **Question** | Confirm partial payments are excluded from V1, knowing Indian libraries routinely take part payment |
| **Evidence** | **Only** EA L1400 `Partial Payments (V2)` — a **Rank 6 descriptive** document. No Rank 1–4 statement exists |
| **Impact** | A ₹500 payment against a ₹2000 due is **unrepresentable** (`FEE-XC-004`). Staff will under-record or fabricate a second structure |
| **Owner** | Product Owner |
| **Authority** | **REQUIRES PRODUCT OWNER** |
| **Status** | **OPEN — VALIDLY DEFERRED pending confirmation** |
| **Stage 4** | Does not block — exclusion is coherent and stated |
| **Freeze** | Does not block *(if consciously confirmed)* |
| **Recommended** | Confirm explicitly, with the cost on the record. This draft follows EA because nothing higher speaks — but a Rank 6 document should not silently decide a core collection behaviour |

### `FEE-GAP-009` — Is Invoice a distinct aggregate or the issued form of `FeeDue`?
| Field | Value |
|---|---|
| **Conflict** | BC Map L204 equates `BC-05`'s *"Invoice"* with **`FeeDue`**; BC Map L374 lists **five** `FeeLedger` members and *Invoice* is **not** one — **but** EA L1413 lists *"Invoice Generation (V1)"* as a capability separate from receipts |
| **Impact** | Determines whether §29.3 is a real state machine or a projection of §29.1 |
| **Owner** | Architecture Owner |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** |
| **Status** | ✅ **CLOSED at v1.7 — the ratified reading is now what the page actually says** (`ADR-0043` §6). **Invoice is an issued/document representation of `FeeDue`, not a separate financial state machine**; financial truth stays in the **existing `FeeDue` + confirmed-payment model** (§29.1). **§29.3 is rewritten as a projection**: `ISSUED` projects **`DUE`/`OVERDUE`**, `PAID` projects **`PAID`**, `CANCELLED` projects **`CANCELLED`**; **no transitions are defined there**, and the document-integrity rules are **re-attributed** to §29.1’s forbidden list rather than deleted. ⚠ **No identifier moved**: no state value, aggregate, requirement, invariant or exclusion was created, renamed or removed, `FeeLedger` still has **five** members (BC Map **L374**), and Invoice is still **not** one. *Superseded Status retained verbatim:* ✅ **THE READING IS RATIFIED at v1.6 — RECORDED IN `ACCEPTED` `ADR-0042` §6.1. ⛔ STILL BLOCKS FREEZE on a narrower and now precisely-named ground.** The **Architecture Owner** has confirmed the Rank 4 reading: **Invoice is the issued representation of a `FeeDue`, not a distinct aggregate**, and **no second financial state machine is created**. ✅ **The conferred condition — *"unless authoritative architecture proves otherwise"* — was TESTED rather than assumed.** The only counter-evidence this block ever cited is EA **L1413** *"Invoice Generation (V1)"*, and an indentation-parent probe places it under **`Billing & Invoicing (V1)` (EA L1412)** — a **Rank 6** Business-Platform **capability** listing, which `DOCUMENTATION_BASELINE.md` §4 **L221** marks *"Descriptive only"*. **A capability named in a Rank 6 tree is not authoritative architecture against Rank 4 BC Map L204 and L374**, so the condition is **not** met and the Rank 4 reading stands. **No sixth `FeeLedger` member is added and BC Map L374’s five members are untouched.** *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | Does not block — this draft takes the Rank 4 reading and says so |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — the document defect this field named is CORRECTED, which is the one remedy it asked for.** §29.3 no longer prints a second state machine: it presents the three labels as a **projection of §29.1** with **no transitions of its own**, so *"two state machines for one concept"* is no longer true of the page. *Superseded verdict retained verbatim:* **BLOCKS** — **and the residual is a DOCUMENT DEFECT IN THIS PRD, not an open architectural question.** The ratified reading settles *what Invoice is*; this field’s stated cause is *"two state machines for one concept"*, and **§29.3 (L1409–L1419) still prints a three-state Invoice table (`ISSUED` / `PAID` / `CANCELLED`) with its own Forbidden row** — a second state machine on the page, whatever the model says. Its own **L1418–L1419** already state the correct reading, so the document **contradicts itself in adjacent lines**. ⚠ **The repair is deliberately NOT performed by `ADR-0042`.** Restructuring §29.3 into a projection of §29.1 is a **`PRD-008` specification act**, and `ADR-0039` §7.2 lays down the rule this pass is bound by — an ADR *"deliberately writes no requirement text"*; an ADR that rewrote a PRD’s state table would be the second source of truth `ADR-0040` **L166** forbids. Routed as **`Q-G1` — this document’s owner** (`ADR-0042` §8): *restate §29.3 as a projection of the `FeeDue` state machine, or state that the three values are presentation labels rather than states.* **No requirement, state value or identifier was added or removed here.** *Superseded field retained verbatim:* **BLOCKS** — two state machines for one concept is a modelling defect |
| **Recommended** | Confirm the Rank 4 reading: invoice = issued representation of `FeeDue`, **no sixth aggregate member** |

### `FEE-GAP-010` — Is a payment vendor chosen?
| Field | Value |
|---|---|
| **Conflict** | EA L1405 lists **`Razorpay (V1)`** and L79 calls it *"Single gateway (Razorpay) = vendor lock-in"* · **Master PRD L232** records Payments as *"`BC-20` via `BC-31`"* with gateway *"**Not named in EA** — candidate only"* |
| **Impact** | None for this PRD's text — `FEE-XC-006` forbids naming a vendor regardless — but it blocks `FEE-GAP-002`'s resolution |
| **Owner** | Architecture Owner |
| **Authority** | **REQUIRES ARCHITECTURE OWNER** |
| **Status** | **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | Does not block **this** PRD — the vendor lives behind `BC-20`/`BC-31` |
| **Recommended** | Resolve inside `BC-20`'s PRD. `BC-05` **MUST** stay vendor-blind either way (Dependency Matrix L167) |

### `FEE-GAP-011` — Financial retention undefined
| Field | Value |
|---|---|
| **Question** | How long must financial records be retained, and may anything ever be purged? |
| **Absence** | No source document states a retention period for `BC-05`. `FEE-XC-011` therefore forbids purging entirely |
| **Impact** | Indian statutory retention may apply; an absolute never-purge rule may itself be non-compliant |
| **Owner** | Product Owner + Security/Compliance |
| **Authority** | **REQUIRES PRODUCT OWNER + REQUIRES SECURITY** |
| **Status** | ⚠ **RETENTION POLICY REMAINS OPEN AND IS NOT INVENTED — and at v1.7 that is recorded as the REQUIRED outcome rather than an unfinished one** (`ADR-0043` §7). The conferred decision was explicit: **do not invent a retention period.** ✅ **None was invented — no number, unit, range or `FEE-CFG-*` row exists.** **Retention/purge policy REQUIRES Product + Security/Compliance approval and must follow the approved legal/compliance policy**; it is carried as **`Q-S1`** against those owners. ✅ **V1 behaviour is nevertheless determined, and not by this pass:** **`FEE-XC-011`** already excludes purging or deleting any financial record, so **nothing is deleted in V1** and there is no undefined behaviour to implement against. **The absence of a period is a policy decision pending, not a specification hole.** *Superseded Status retained verbatim:* ⚠ **OPEN — ROUTED EXACTLY AS INSTRUCTED at v1.6, and deliberately NOT answered — RECORDED IN `ACCEPTED` `ADR-0042` §7.3.** The conferred instruction was *"do not invent statutory retention; route it to Product + Security/Compliance with an explicit V1 decision required."* **That instruction has been executed in full, and executing it leaves this gap open by design.** ✅ **No retention period, no purge rule, no minimum and no maximum was invented**, and `FEE-XC-011` is unchanged — it continues to forbid purging entirely, which is a **statement of this module’s current position**, not a compliance finding. ⚠ **The `Impact` row’s warning is preserved rather than softened:** *"Indian statutory retention may apply; an absolute never-purge rule may itself be non-compliant."* **This PRD is not competent to say whether it does** — that is a legal determination, and the word *"may"* is the honest form. Routed as **`Q-S1` — Product Owner + Security/Compliance, jointly** (`ADR-0042` §8): *state the V1 financial-record retention position for `BC-05` — a period, or an explicit decision that never-purge is compliant.* **An explicit V1 decision is required; silence is not assent.** *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — and the reason is that the module DOES have a V1 retention position; what it lacks is a long-term policy, which is expressly not this PRD’s to write.** This field’s stated cause was *"no retention position"*. **`FEE-XC-011` is a position**: nothing is purged or deleted in V1 — the conservative direction, and the only one available without inventing a period. The retention/purge **policy** requires **Product + Security/Compliance** approval per the approved legal/compliance policy and stays **OPEN as `Q-S1`**. ⚠ **This is the one closure resting on a decision NOT to decide, and it is labelled as such rather than presented as resolution.** *Superseded verdict retained verbatim:* **BLOCKS** — a financial module frozen with no retention position is not production-safe. **This verdict is UNCHANGED at v1.6 and that is the correct outcome of the instruction, not a failure to carry it out.** The instruction said *route it*, not *resolve it*; a routed question with a named owner is still an unanswered question, and `PRD_LIFECYCLE.md`’s Freeze bar is **completeness**. The `Recommended` row below — *"obtain a compliance position before freeze"* — is re-affirmed verbatim, and the `PRD-006` precedent it cites (retention left explicitly undefined for the same reason) is the precedent being followed |
| **Recommended** | Obtain a compliance position before freeze. *(`PRD-006` left retention explicitly undefined for the same reason.)* |

### `FEE-GAP-012` — Registry status, analytics edge, report tier, and the missing gate
| Field | Value |
|---|---|
| **Questions** | (a) `PRD_REGISTRY.md` records `PRD-008` **`PLANNED`**; who moves it to `DRAFT`? (b) `BC-26` is a `fee.*` **consumer** in BC Map §9 but has **no `E-*` edge** in §7 — same defect class as `MM-GAP-010`. (c) `Financial Reports` is **(V2)** at EA L814 and **(V1)** at EA L1424. (d) No `prd008_traceability` gate exists, so §36.1's counts are hand-measured |
| **Impact** | (a) status legitimacy · (b) an undeclared transport · (c) unclear deliverable · (d) unverified traceability |
| **Owner** | Governance Owner (a, d) · Architecture Owner (b) · Product Owner (c) |
| **Authority** | **REQUIRES GOVERNANCE + REQUIRES ARCHITECTURE OWNER + REQUIRES PRODUCT OWNER** |
| **Status** | ✅ **ALL FOUR LIMBS CLOSED at v1.7, each by an existing authority or precedent — no new edge and no new architecture** (`ADR-0043` §8). ✅ **(b) and (d) re-verified, not re-decided** — the gate runs at exit 0, and `BC-26` follows the `ACCEPTED` `ADR-0019` §3.1 `MM-GAP-010` precedent: **`BC-26` is NOT a publish target (L1314) and no `E-*` edge was invented.** ✅ **(a) CLOSED — the Governance Owner moved `PRD_REGISTRY.md` `PLANNED` → `DRAFT`** on the register’s **own** §2.1 **L42** evidence test and its **own** twice-executed precedent (`PRD-004` v1.4, `PRD-022` v1.9); the register’s `GCP-14` **L343–L346** already records that reconciliation and **L351** already names that authority. ⚠ **`GCP-14`’s wording defect is NOT closed and remains OPEN**, and the direction of travel is disclosed: this is the *convenient* direction, lawful only because the authority was conferred explicitly and the evidence test is met on measured facts. ✅ **(c) CLOSED — resolved one rank ABOVE the conflict, not arbitrated inside it.** Both `Financial Reports` lines are **Rank 6**, which is why `ADR-0042` called it unarbitrable; **Rank 6 is descriptive only** (`MP-CON-08` L519; baseline §4 **L221**), and **no Rank 1– 5 document gives `BC-05` a report deliverable at all** (BC Map **L135** gives reports to `BC-26`; **L100** gives `BC-05` none). **The tier cannot bind `BC-05`; the EA is byte-unchanged and no tier was chosen for the dashboard owner**; the Rank 6 self-disagreement is raised as **`Q-A7`** per baseline **L224**. *Superseded Status retained verbatim:* ⚠ **TWO OF FOUR LIMBS CLOSED at v1.6 — RECORDED IN `ACCEPTED` `ADR-0042` §6.2. ⛔ STILL BLOCKS on (a) and (c).** ✅ **(d) CLOSED — the gate exists.** `tool/docs_check/prd008_traceability.py` was written and runs at **exit 0**; §36.1’s counts are machine-verified, not hand-measured, and the gate additionally reports one outstanding finding rather than suppressing it. **The checker has not been weakened at any point in this pass.** ✅ **(b) CLOSED by precedent, which is what the instruction asked for.** `BC-26` is a `fee.*` consumer in BC Map §9 with no `E-*` edge in §7 — and the governing precedent is `ACCEPTED` **`ADR-0019` §3.1**, which classified the identical `MM-GAP-010` situation as **systemic across the BC Map**, not a `PRD-008` defect. The precedent’s own remedy is followed here: **`BC-26` is NOT listed as a publish target** (this PRD’s **L1314** already says so) and **no `E-*` edge is invented**. ⛔ **(a) STILL OPEN — and it is blocked by an existing governance finding, not by inattention.** `PRD_REGISTRY.md` **L245** still records `PRD-008` as **`PLANNED`**. The registry’s **own** §7 summary and v2.0 change history explain why it was left there: advancing it *"would have resolved `GCP-14` by fiat in the direction that happens to be convenient."* Routed as **`Q-G1`’s companion — Governance Owner** (`ADR-0042` §8). ⛔ **(c) STILL OPEN — and it is STRUCTURALLY UNARBITRABLE, which is a finding, not an excuse.** This block cites *"(V2) at EA L814 and (V1) at EA L1424"*; re-measured at HEAD the second is **L1423**, and — the decisive fact — **BOTH lines are Rank 6**: L814 `Financial Reports (V2)` sits under `Owner Dashboard (V1)` (L807), L1423 `Financial Reports (V1)` is a top-level LAYER 4 node. **`MP-CON-08` resolves conflicts by comparing RANKS; with both at rank 6 it has nothing to compare**, and no Rank 1–5 document states the tier. Routed as **`Q-P3` — Product Owner** (`ADR-0042` §8): *is Financial Reports a V1 or V2 deliverable?* *Superseded Status text retained verbatim:* **OPEN** |
| **Stage 4** | Does not block |
| **Freeze** | ✅ **DOES NOT BLOCK from v1.7 — all four limbs are closed, and neither of the two that survived v1.6 was self-served.** **(a)** was moved by the **Governance Owner** under conferred authority, on the register’s own test and own precedent — **not** by this PRD editing its own status row; **(c)** was resolved by an **existing** Rank 1 / baseline rule showing a Rank 6 label cannot bind `BC-05` — **not** by choosing a tier. **No `E-*` edge, bounded context or architecture was invented; the EA is byte-unchanged.** *Superseded verdict retained verbatim:* **BLOCKS** — `PRD-006` could not freeze without gates at exit 0. ⚠ **That stated cause is now SATISFIED and is superseded as a reason, while the verdict stands on the two surviving limbs.** The gate exists and runs at exit 0, so limb (d) no longer contributes; **(a)** registry status and **(c)** the report tier do, each with a named owner above. **Neither may be self-served:** editing `PRD_REGISTRY.md` from inside the PRD whose status is in question is the *"by fiat"* move the registry itself refused, and choosing a report tier between two Rank 6 lines is a product decision. **`PRD_REGISTRY.md` and the EA report lines are byte-unchanged** |
| **Recommended** | Registry update by the Governance Owner; write `prd008_traceability.py` before Stage 5; follow the `MM-GAP-010` precedent for `BC-26` — **do not list it as a publish target** until an edge exists |

### `FEE-GAP-013` — Renewal protection: policy, term arithmetic, and cross-library status disclosure

**Status at v0.3: PARTLY RESOLVED.** Sub-questions **(a1)** and **(e)** are **CLOSED by measurement** — see
§11.3.2 and §11.3.5. Sub-questions **(a2)**, **(b)**, **(c)**, **(d)**, **(f)** and **(g)** remain
**BLOCKED**, each with a named authority. The resolution added **no** `FEE-*` requirement, **no** event,
**no** edge and **no** configurable.

| Field | Value |
|---|---|
| **Questions** | **(a1) Which existing bounded context owns the renewal-protection policy? — ✅ CLOSED.** `BC-06` Library Policy owns the *rule* (BC Map L101, *"the rule **source**"*), specified by **`PRD-002`**, `FROZEN` v1.1 (`PRD_REGISTRY.md` **L422**, uncontested); `BC-02` owns the *term effect*; `BC-04` owns the *seat effect*; **`BC-05` owns none of it**. **(a2) Does a protection window exist at all, how long is it, and may it be configured? — ⛔ BLOCKED.** **(b)** Where is protection-usage history stored, given `BC-02` is `FROZEN` with no such field and `Membership History` is EA-**V2**? **(c)** By what **registered edge** may Library B read a membership-status signal owned by Library A's tenant? **(d)** May the indicator name the **previous library**, given `ID-3`? **(e) Who guarantees the *"full configured duration"* at Library B? — ✅ CLOSED:** `BC-02`, by frozen `MM-FR-086` (target plan's **current** `durationDays`) and `MM-FR-081` (renewal from `Expired` *"without limit of elapsed time"*); not `BC-05` (`FEE-XC-020`). **(f) NEW — may the protected days be *deducted* from the new membership's duration? — ⛔ BLOCKED, and it is a frozen-document conflict.** **(g) NEW — is there an approved path by which a student who remains *"requests renewal protection"*? — ⛔ BLOCKED (unsourced).** |
| **Conflict or absence** | **Absence, then conflict, in that order.** *Absence:* `grep -rniE "renewal.protect\|protection period\|protection window"` over `docs/` = **0 occurrences** — the concept is unsourced, so **(a2)** and **(g)** have no source to interpret. *Conflict on (a2):* the nearest concept, **grace period**, is `BC-06`'s (BC Map L101) but its decision `Q-01`/`MM-GAP-001` is **OPEN**; the only recorded recommendation is **24h** (Master PRD L673, BC Map L540) — **not 3 days** — and `PRD-005` §7.4 states a recommendation inside an open question *"is not a decision"*; frozen `MM-FR-111` forbids a V1 grace period *"that extends entitlement beyond `endDate`"*; and configurability has no register — `BC-06`'s configurables are the closed table `PRD-002` §16.1 `LCFG-1`…`LCFG-10` (*"Values are configurable; their **ranges and invariants are not**"*) in a **`FROZEN`** document, with no protection-window row. `E-19` supplies typed accessors, **not** authority that a value exists. *Conflict on (f) — the sharpest in this gap:* the requested deduction is contradicted by **five** frozen `PRD-005` requirements — `MM-FR-086` (new `endDate` from the target plan's **current** `durationDays`), `MM-FR-057` (`startDate + (durationDays − 1)`, a closed formula), `MM-FR-058` (a **pure function** that *"**MUST NOT** depend on the current clock"*), `MM-FR-057a` (*"**The single permitted re-derivation, and the only one**"*, which this is not) — and it **is** proration, classified `MM-XC-012` **V2** with ownership question `Q-06`/`MM-GAP-002` still **OPEN**. *Conflict on (c)/(d):* `ID-2` *"`StudentRecordId` **never** leaves its tenant"* — **CI-enforced** by `banned_symbols` in `tool/module_dependencies.yaml` L216–218; `ID-3` global contexts *"must not be able to resolve which library a person attends unless the person explicitly published it"*; and decisively **`SID-4.19`** — `BC-10` *"**SHALL NOT** answer, and **SHALL NOT** be capable of answering, 'which libraries does this person attend?'"*, reinforced by `SID-INV-8`, `SID-INT-12`, `SID-4.22`, `SID-4.23` and `SID-5.8` (which names **`membership state`** as a field that *"**SHALL NEVER** exist"* in `BC-10`). `E-13` is *"the only bridge between the two worlds"* and carries identity core fields; `Multiple Library Memberships` is EA-**V2**, `Cross Library Membership` **Future** |
| **Impact** | **The feature as requested is not implementable in V1, and three of its four parts would each require amending a different frozen document.** Sub-question **(f)** is the most consequential discovery of this resolution: the deduction rule was presented as following *"the approved membership policy"*, but **no such approved policy exists** and the approved policy says the opposite. Implementing it would make `endDate` a function of elapsed time, contradicting `MM-FR-058`, and would execute V2 proration under an open ownership question. Sub-questions **(c)**/**(d)** cannot be satisfied even by the request's own preferred design — a minimal `PersonId`-keyed projection with the library name omitted — because `SID-4.19` prohibits the **capability**, not merely the field, and any non-empty result still discloses enrollment elsewhere. Creating the read anyway would be an unregistered cross-tenant path, which BC Map L510 calls *"**the single highest-severity failure mode in the entire architecture**."* **`BC-05` is unaffected either way**: it owns none of the blocked parts, and its own obligations are complete |
| **Owner** | **(a2)** **Product Owner** + **`BC-06` owner (`PRD-002`)** · **(b)** **`BC-02` owner** · **(c)** **Architecture Owner** · **(d)** **Security + Privacy** (consent record owner is `BC-18`, `ID-6`) + **`BC-10` owner (`PRD-003`)** · **(f)** **`BC-02` owner + Product Owner + Architecture Owner** · **(g)** **Product Owner** |
| **Authority** | **REQUIRES PRODUCT OWNER + REQUIRES ARCHITECTURE OWNER + REQUIRES SECURITY, and — for (a2) and (f) — REQUIRES AN ADR AMENDING A FROZEN RANK-3 PRD.** Four distinct ADRs by four distinct owners would be needed to build the feature as requested: amending `PRD-002` (window + configurable), amending `PRD-005` (usage history + term deduction), registering a new cross-tenant edge in the BC Map, and amending or carving out `SID-4.19` in `PRD-003`. **None has been authored here** — requirement 10 forbids accepting an ADR without its authority |
| **Status** | **PARTLY RESOLVED — (a1) and (e) CLOSED by measurement; (a2) and (f) ANSWERED at v1.1 by conferral (`ADR-0036`, `PARTLY ACCEPTED`); (b), (c), (d), (g) still BLOCKED.** **(a2):** the window is **3 calendar days, mandatory V1, FIXED and not configurable** — so the configurability half needs **no** register amendment and **no** `CFG-*`/`LCFG-*`/`ICFG-*` identifier was allocated. **(f):** answered **NO** — the protected days **MUST NOT** be deducted from the new term, which is **what the five frozen `PRD-005` requirements already required**, so the frozen-document conflict is **dissolved rather than overridden** and `PRD-002`/`PRD-005` are **not amended**. ⚠ **A residue of (a2) remains open and is not folded into the answer:** *"3-day"* does not fix the window's **first day**, a **customer-visible** boundary belonging to the **Product Owner** (`ADR-0036` §8.2). **(b), (c), (d), (g) are untouched by the conferral** — `SID-4.19`, `ID-2`, `ID-3` and `MP-GBR-24` stand, and the cross-library indicator is **still forbidden in V1** |
| **Stage 4** | **Does not block this PRD.** `BC-05`'s own obligations (`FEE-FR-059`, `FEE-BR-026`, `FEE-BR-027`, `FEE-XC-018`…`021`) are fully specified and testable without any blocked answer, and the resolution added no new requirement to review |
| **Freeze** | **BLOCKS the requested *feature*, not this PRD** — because `BC-05` correctly owns none of the blocked parts. Freezing `PRD-008` with the prohibitions in place is coherent; shipping the indicator or the deduction is not |
| **Recommended** | **1. The cross-library indicator is NOT V1 — register it as a V2 candidate; do not remove it and do not build it.** V2 matches the tier the EA already records for `Multiple Library Memberships` and `Membership History`. **2. Do not implement the 3-day deduction (f) in any module.** It is V2 proration under an open ownership question; if pursued, it needs an ADR amending frozen `PRD-005` and should be decided together with `Q-06`, not separately. **3. Route (a2) to the Product Owner with `BC-06` as policy owner**, and settle it together with `Q-01` — deciding a 3-day protection window while `Q-01`'s 24h grace question is open would create two competing post-expiry concepts. **4. For any future V2 design of (c)/(d):** the measured constraint is that the projection **cannot live in `BC-10`** as `PRD-003` is written; the only lawful door in the current text is `ID-3`'s *"unless the person explicitly published it"* — i.e. **explicit person consent**, which requires a consent owner (`BC-18`), a lawful basis, a revocation path and a registered edge, none of which exist. **5. Meanwhile the prohibitions in §11.3.8 stand and require no approval to honour** — `FEE-XC-019` and `FEE-XC-021` are unconditional and hold however this gap is decided |

---

### `FEE-GAP-014` — Platform commission, settlement and platform revenue have no owning document

| Field | Value |
|---|---|
| **Question** | Which document specifies the **3% default platform commission**, its per-transaction application, the library **settlement balance**, **net-off** against future collections, and the Owner/Manager settlement view — given that all five are money **library → LIBOORA** and therefore `BC-20`'s, and that `BC-20`'s PRD (`PRD-022`) is `PLANNED` and does not exist? |
| **Conflict or absence** | **Absence, not conflict.** Measured: `commission` = **13 occurrences, 0 financial** (all the English verb); `platform fee`, `revenue share`, `payout`, `net settlement` = **0 each**; an approved `3%` default = **0**. No source approves a commission rate, a settlement aggregate, a net-off rule or a payout rail. Separately, **no `BC-05` ↔ `BC-20` edge exists** — `BC-05` has exactly `E-06`, `E-07`, `E-09`, `E-10` — and BC Map §7 L292 holds that *"if an edge is not in this table, it does not exist"* |
| **Impact** | The commission model **cannot be specified in this PRD at all**, and not because of a missing detail: `MP-GBR-24` (**Rank 1**) forbids `BC-05` and `BC-20` sharing *"a model, a table or a metric"*. Specifying it here would merge LIBOORA's revenue into a library's fee ledger — the precise failure `PRD_REGISTRY.md` L341 describes as collapsing *"`FeePayment` into `SubscriptionCharge`"*. The **immutable-snapshot**, **server-confirmed-cash**, **no-offline-write** and **unbundled-breakdown** parts of the decision ARE specified here (§34.4), because those are `BC-05`'s own |
| **Owner** | **`BC-20` owner** (settlement model, commission arithmetic, revenue recognition) · **Architecture Owner** (any `BC-05` ↔ `BC-20` edge, and the gateway-charge path through `E-25`) · **Governance Owner** (opening `PRD-022`) · **Product Owner** (whether a commission line may appear in a student-facing breakdown at all) |
| **Authority** | **REQUIRES THE `BC-20` OWNER + REQUIRES ARCHITECTURE OWNER + REQUIRES GOVERNANCE OWNER.** An ADR is required for the edge. **No ADR is authored here.** `PGA-05` already records `PRD-022` as one of the *"nine module PRDs named in v1.0 and never written"* |
| **Status** | **PARTLY RESOLVED at v1.1 — the *values and the owner* are decided; the *model* still has no home.** ✅ **DECIDED by conferral:** the Platform Charge default is **3%**; Owner/Admin changes take effect on **FUTURE transactions only** and **historical charges are immutable**; the settlement due day default is the **15th**, changeable among **10 / 15 / 25** for **future** periods with **existing obligations never moving**; and **`BC-20`/`PRD-022` owns the Library → LIBOORA Platform Charge and the whole settlement lifecycle**. ⛔ **What that does NOT do:** it does **not** create the `CommissionReceivable` aggregate, the settlement obligation, the accrual rule or the `BC-05` → `BC-20` basis-fact path — all four are **`PRD-022`'s to specify**, and `PRD-022` is `DRAFT` with **7** of its own gaps. It also allocates **no `CFG-*`/`LCFG-*`/`ICFG-*` parameter identifier** and **no permission**, so the *rate* and *due day* are recorded here as **decided values, not as configuration**. **`MP-GBR-24` still bars this PRD from specifying any of it**, so the gap stays **OPEN as to this document's ability to close it** |
| **Stage 4** | **Does not block this PRD.** `BC-05` owns none of the blocked parts, and the six obligations it does own (`FEE-FR-060`…`062`, `FEE-INV-010`, `FEE-BR-028`, `FEE-XC-022`) are fully specified and carry `FEE-AC-079`…`083` |
| **Freeze** | **BLOCKS the commission *feature*, not this PRD.** Freezing `PRD-008` would not make the feature buildable; only `PRD-022` can |
| **Recommended** | **1.** Open `PRD-022` (SaaS Billing, `BC-20`) and specify commission, settlement, net-off and payout there, with the 3% default recorded as the Product Owner's decision. **2.** Route the `BC-05` → `BC-20` transaction-fact path through an ADR **before** either PRD depends on it; do not assume a direct edge, since `E-25` shows `BC-20` reaching external rails through `BC-31`. **3.** Keep gateway charges on `BC-20`'s side of that boundary. **4.** Do NOT add a commission field to any `BC-05` aggregate in the interim |

### `FEE-GAP-015` — Platform-configuration authority: `PR-1` exists; the permission and the register do not

| Field | Value |
|---|---|
| **Question** | Which registered role may change a **platform-level** configuration value — such as the commission rate or the renewal-protection window — and by which **named permission**, in which **register**? |
| **Conflict or absence** | **Absence, not conflict — and the role half is now CLOSED.** **(a) ✅ CLOSED — the role exists.** `PRD-001` Authentication v2 (**PRODUCTION-READY — AUTHORITATIVE**, Rank 3), `prd-v2/02` **L123-127** defines **`PR-1` Platform Administrator** with Purpose *"Operate and secure the platform: provision and suspend tenants, **manage platform configuration**, administer platform-level security"* and Scope *"Platform-wide, for **platform-level objects only** — tenants as entities, **platform configuration**, platform role assignments"*. **Changing a platform-level configuration value is therefore already inside `PR-1`'s defined scope; no new role is required and none is proposed.** `AUTH-2.6` (assignment only by another Platform Administrator), `AUTH-7.49` (invite-only, *"no self-service path may exist"*) and `AUTH-2.7` (every assignment emits an event) supply the provisioning and audit path the product intent asks for. **(b) ⛔ OPEN — the permission is not enumerated.** `AUTH-7.22` *"The permission catalogue **MUST** be closed. A permission not declared in it cannot be granted, requested or evaluated"*, `AUTH-7.67` and `AP-3` (*"absence of an explicit grant is refusal"*). Measured: chapter 7 declares the catalogue closed and gives **categories** (`Platform` — *"Provisioning a tenant; platform configuration"*) and **scope classes**, but **enumerates no permission identifier anywhere in `docs/`**. So the *capability* is in scope for `PR-1` while the *named grant* that `AUTH-7.4`/`AUTH-7.32` require does not yet exist. **(c) ⛔ OPEN — no register holds the value.** The authoritative configuration registry is `CONFIGURATION_GUIDE.md` v1.1 (Rank 7), governing exactly `CFG-1`…`CFG-12` (Authentication), `LCFG-1`…`LCFG-13` (Library) and `ICFG-1`…`ICFG-10` (Invitation) — **35 parameters, none a commission rate, none a protection window, none platform-scoped-commercial**; measured `grep -ni 'commission\|percent\|renewal'` over that guide → **0 parameter rows**. Its §5 is decisive: *"Adding a parameter — **A PRD amendment**; the specification declares what is configurable, this guide does not"*, and it *"cannot change the envelope"*. **(d) ⚠ CONSTRAINT — `AUTH-7.64`**: *"No role **MAY** grant the ability to modify the policy that constrains it"*, so the grant must be enumerated as configuration authority, not as policy authority |
| **Impact** | **Reduced from the v0.4 statement, which was wrong on the role.** The product intent — *"`PR-1` / authorized platform authority CAN change it; Owner, Manager, Reception and Student CANNOT"* — is **already expressible** in the existing role model: `PR-1` holds platform configuration in scope, and `AUTH-7.13` plus `AUTH-7.61` already bar every **tenant** role (`TR-1` Owner, `TR-2` Manager, `TR-3` Reception, `TR-4` Student, `TR-5` Parent) from platform-level objects, so the four prohibitions need **no new rule at all** — they are consequences of `AUTH-7.14` scoping a library role to exactly one library. What is missing is narrower than v0.4 claimed: a **named permission** in the closed catalogue and a **parameter row** in a register. **No `BC-05` requirement depends on either** — `FEE-XC-014` forbids this module from creating a role or inferring permission from dashboard visibility, `FEE-FR-053` requires every financial write to be authorised against acting role and tenant scope, and BC Map L127 places roles, permissions and policy decisions in `BC-18` — so this PRD is unaffected; but the configuration-authority questions in `FEE-GAP-007` and `FEE-GAP-013`(a2) still cannot close until (b) and (c) are answered |
| **Owner** | **(b) `BC-18` owner / `PRD-001` owner** — enumerating a permission in the closed catalogue · **(c) `BC-25` owner / `PRD-023`** *(`PRD_REGISTRY.md` L327, L424 — `PLANNED`, unwritten)* **+ the owner of the PRD that declares the parameter**, since `CONFIGURATION_GUIDE.md` §5 requires *a PRD amendment* to add one · **Product Owner** for the 3% and 3-day values themselves |
| **Authority** | **(a) NONE REQUIRED — resolved by measurement against the existing model.** **(b) REQUIRES THE `BC-18` / `PRD-001` OWNER** — adding to a catalogue an authoritative Rank 3 document declares closed is an amendment to that document. **(c) REQUIRES A PRD AMENDMENT** per `CONFIGURATION_GUIDE.md` §5, plus an ADR if any range is to be stated. **No ADR is authored here; `PRD-001` and `CONFIGURATION_GUIDE.md` are not modified; no permission identifier, parameter identifier, minimum, maximum or range is invented** |
| **Status** | **PARTLY RESOLVED — (a) CLOSED by measurement; (b), (c) still OPEN at v1.1; (d) is a standing constraint.** ✅ **The v1.1 conferral decided the *values*** — **3%** and the **15th** (`FEE-GAP-014`), and a **FIXED, non-configurable 3-day** renewal window (`FEE-GAP-013`, `ADR-0036` question 3) — and it named **Platform Owner/Admin** as the changer of the first two. ⛔ **It did not answer (b) or (c), and this is the sharpest remaining point in this gap:** **no permission identifier is enumerated anywhere in the repository** (`grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` → **0**), `AUTH-7.22` holds the catalogue **closed**, and `AP-9`/`AUTH-7.12` **fail closed** — so **a rate change would today be DENIED even to `PR-1`**, the very role the decision names. **Naming who may act does not enumerate the grant that lets them.** (c) is likewise untouched: **no register holds either value**, and `CONFIGURATION_GUIDE.md` §5 requires *a PRD amendment* to add one. ✅ **One part of (c) got smaller rather than larger:** because the renewal window is **FIXED**, it needs **no parameter row at all** — so of the two parameters this gap was chasing, **one is no longer required**. **No permission identifier, parameter identifier, range, minimum or maximum is invented here, and `PRD-001` and `CONFIGURATION_GUIDE.md` are not modified** |
| **Stage 4** | Does not block — no `FEE-*` identifier references a platform role or a platform configurable |
| **Freeze** | **Does not block this PRD**; blocks any platform-level configurable, including the commission rate and the renewal-protection window |
| **Recommended** | **1. Do NOT create a third platform role.** *"Two, closed"* stands; `PR-1`'s own Purpose and Scope already cover platform configuration, and `AUTH-7.10` means a new role would inherit nothing and have to be enumerated anyway — strictly more work for no capability. Any *"Platform Owner / Founder"* concept should be modelled as **governance authority over `PR-1` assignment** (which `AUTH-2.6` already vests in another Platform Administrator), not as an authentication role. **2.** Enumerate one **named permission** in the closed catalogue at **Platform** scope — e.g. update of a platform configuration value — granted to `PR-1` and to no tenant role, honouring `AUTH-7.24` (actions granted independently) and `AUTH-7.64`. **3.** Add the two parameters by **PRD amendment** to whichever PRD declares them (`PRD-023` for `BC-25`, or the owning module PRD), each with a default and a range, then record the values in `CONFIGURATION_GUIDE.md`. **The product intent — default 3% and default 3 days — is preserved here as intent, not enacted as configuration**; `PRD-006`'s `ADR-0031` precedent applies, where *"a twenty-fifth configuration row was refused rather than invented"*. **4.** Audit is already required — `AUTH-7.71` (*every policy change emits an event*) and `AUTH-7.40` (*auditable, attributable, reversible*) — so item M of the product intent needs no new rule |

### `FEE-GAP-017` — A cash-only library has **no lawful way to pay its LIBOORA commission** *(added v0.8)*

| Field | Value |
|---|---|
| **Question** | A library collects **100 cash memberships × ₹500 = ₹50,000** from students and takes **zero** online student payments. A **3%** platform commission would make **₹1,500** owed **library → LIBOORA**. **Which context owns that receivable, which capability executes the library's outbound settlement of it, and which role may initiate it — when there is no future online student collection to net it off against?** |
| **Why this is NOT `FEE-GAP-014`** | `FEE-GAP-014` asks *who specifies the commission model*. This asks a **narrower and structurally different** question that `FEE-GAP-014` never poses: **the direction of money reverses.** Every payment path this architecture has ever described is **inbound to a library** (student → library) or **inbound to LIBOORA** (library → LIBOORA **by card, pulled by LIBOORA** — `BC-20`'s `PaymentAttempt`/`DunningState`, BC Map **L382**). A cash-only settlement is **library-initiated outbound remittance**, which appears **nowhere**. `FEE-GAP-014`'s recommendation *"net-off against future collections"* **presupposes future online collections exist**; this gap is the case where they provably do not |
| **Absence — measured at `a1afbd5`, not asserted** | `grep -rni "commission" docs/` = **63 hits, 0 financial outside this PRD and `ADR-0035`** (every other is the English verb — *"commissioned an analysis"*, `SeatDecommissioned`) · `settlement`, `payout`, `net-off`, `revenue share`, `take rate` outside this PRD/`ADR-0035` = **0 each** · **`receivable` = 0 repository-wide** · an approved `3%` = **0** · `BC-20`'s aggregate list (BC Map **L382**) is `Subscription` · `SubscriptionInvoice` · `SubscriptionPlan`, `PaymentAttempt`, `DunningState` — **no commission, receivable or settlement aggregate exists** · `PRD-022`, `BC-20`'s own PRD, is **`PLANNED` and does not exist** (`PRD_REGISTRY.md` L326; `PGA-05`) |
| **What IS already lawful — three findings that narrow the gap** | **(i) The owner is determinate.** BC Map **L129**: `BC-20` *"Owns money owed by a **library to LIBOORA**"*. A commission receivable is exactly that, so **`BC-20` owns it** and **`BC-05` must not**. No decision is needed on ownership. **(ii) An outbound rail already exists.** **`E-25`** (`BC-20` → `BC-31`, BC Map **L334**, *"Gateway abstraction; Billing knows no vendor names"*) already carries `BC-20`'s money movement, and `platform/business` declares `platform/integration:payment_gateway` (manifest **L409**). **A settlement therefore needs no new edge and no new vendor** — and none is invented here. **(iii) `ADR-0035` `D-2`'s `O-3` applies unchanged**: execution is a Business Platform capability. **What is missing is not transport — it is the receivable aggregate, the settlement obligation and the authority to initiate one** |
| **Authorization — resolved for Owner, GENUINELY OPEN for Manager** | **`TR-1` Owner: supported in principle.** `prd-v2/02` **L159** grants *"Complete operational authority within the library: configuration … **financial and revenue visibility** …"*. **`TR-2` Manager: NOT supported, and this is a real bar, not an omission.** `prd-v2/02` **L169** — *"**Cannot alter library-level commercial configuration**"* — and **L200** scopes `TR-2` to *"Operational only … **excluding commercial configuration**"*. **The decisive point is that neither role is enough,** because `AUTH-7.22` holds *"the permission catalogue **MUST** be closed. A permission not declared in it cannot be granted, requested or evaluated"*, and **`grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` returns 0** — **no permission identifier is enumerated anywhere in the repository**. With `AP-9`/`AUTH-7.12` *"fail closed — where any input to a decision is unavailable … the decision is refusal"*, **a settlement action would today be DENIED for `TR-1` as well as `TR-2`.** Note also that the permission category *"**Financial** — Revenue, fees, commercial data"* (`prd-v2/07` **L136**) is exemplified by *"Viewing revenue; recording a payment"* — both **inbound**; it does **not** evidently reach an **outbound remittance to the platform**. **No role and no permission identifier is invented here** |
| **Impact** | **A cash-only library cannot pay LIBOORA, and LIBOORA cannot collect.** This is the commercially load-bearing case for the Indian market this product targets, where cash is normal — not an edge case. But specifying it **inside `PRD-008` would breach Rank 1 `MP-GBR-24`**: a commission receivable and a settlement are money *library → LIBOORA*, which *"must never share a model, a table or a metric"* with student money. Building it here would put LIBOORA's revenue inside a library's fee ledger — the exact collapse `PRD_REGISTRY.md` L341 describes |
| **Owner** | **`BC-20` owner** (the receivable aggregate, settlement obligation, commission arithmetic, historical-rate snapshot) · **Architecture Owner** (whether the `BC-05` → `BC-20` commission-basis fact travels by event or port; whether `O-3` execution covers **outbound library-initiated** movement) · **`PRD-001` owner + `BC-18`** (whether `TR-1`, and separately `TR-2`, may initiate a settlement, and the named permission that would express it) · **Governance Owner** (opening `PRD-022`) · **Product Owner** (the 3% value and whether `TR-2` should be able to settle at all) |
| **Authority** | **REQUIRES THE `BC-20` OWNER + ARCHITECTURE OWNER + `PRD-001` OWNER + GOVERNANCE OWNER + PRODUCT OWNER.** Five authorities, because the question spans a receivable, an edge, a permission, a missing PRD and a rate. **No ADR is authored here and no authority is claimed** |
| **Status** | **PARTLY RESOLVED at v1.1 — the *requirement* is decided; the *mechanism, the permission and the aggregate* are not.** ✅ **DECIDED by conferral, and it is a direct answer to this gap's own recommendation 5:** **a cash-only library MUST have an independent settlement method — online net-off cannot be the only method.** That is the fifth `Recommended` item of this block and the fifth of `SAAS-FR-009`'s, **specified twice, in two documents, in the same direction**, and now decided. The **owner** is also settled: **`BC-20`/`PRD-022`** owns the Platform Charge and settlement lifecycle. ⛔ **What remains OPEN, and none of it was decided:** **(i)** the **`CommissionReceivable` aggregate**, the settlement obligation and the accrual-from-confirmed-cash rule — `PRD-022`'s to specify · **(ii)** whether `E-25` → `BC-31` can carry a **library-initiated outbound** remittance, when every described flow is LIBOORA **pulling** (`SAAS-GAP-003`, **Architecture Owner**) — **the conferral said payment execution and inbound webhook are Business Platform capabilities; it did not address outbound library-initiated push** · **(iii)** the **named permission**, without which the action **fails closed for `TR-1` as well as `TR-2`** (`SAAS-GAP-004`) · **(iv)** whether `TR-2` Manager may settle at all, which `prd-v2/02` **L169**/**L200** currently bar. **A requirement to have an independent method is not a specification of one**, and **no rail, provider, bank-account structure, UPI flow, endpoint, permission or aggregate is invented here** |
| **Stage 4** | **Does not block this PRD.** `BC-05` owns **none** of the blocked parts. What `BC-05` does owe the settlement — a confirmed, immutably-snapshotted cash payment fact — **already exists** as `FEE-FR-060`/`FEE-INV-010`/`FEE-BR-028` and `FEE-FR-061`/`FEE-XC-022`, all traced |
| **Freeze** | **BLOCKS the settlement *feature*, not this PRD.** Freezing `PRD-008` would not make it buildable; only `PRD-022` plus a permission decision can |
| **Recommended** | **1.** Open **`PRD-022`** and specify there: a `CommissionReceivable` (or equivalently-named) aggregate owned by `BC-20`, its accrual from a confirmed-cash **fact**, an outbound settlement obligation, and settlement status. **2.** Decide the `BC-05` → `BC-20` **basis-fact** path by ADR — `BC-05` already emits **`fee.FeePaymentReceived`**, so a **subscribe-to-the-existing-event** route may need no new edge at all; **verify that before creating one**. **3.** Ask the `PRD-001` owner for the named permission, and decide `TR-2` explicitly — `L169`/`L200` currently bar it. **4.** Keep the settlement **out of `FeePayment` and out of `FeeLedger`** — `FEE-XC-001`, `FEE-XC-002`, `FEE-XC-023` and `FEE-FR-060`'s deliberate omission of any commission field already guarantee this. **5.** Do **not** make net-off the only mechanism; this gap exists precisely because a library may have nothing to net against |

### `FEE-GAP-016` — Inbound webhook transport has no declared owner *(added v0.7)* — ✅ **RESOLVED at v1.1**

| Field | Content |
|---|---|
| **Question** | Which authorised capability **receives** an inbound payment-result callback from a provider, before `BC-05` verifies it? |
| **Why it is new** | `FEE-GAP-002` asked who *executes*. Executing is **outbound**; a webhook is **inbound**. Resolving execution (`ADR-0035` `D-2`) exposed that the **return path** has no owner either — and that is the path financial truth actually depends on |
| **Measurement** | `grep -c "webhook\|Webhook"` over the Rank 4 BC Map → **0**. `grep -c "inbound"` → **0**. `BC-31`, BC Map **L140**, owns *"**outbound** third-party contracts, credentials, retries, idempotent delivery"* — outbound only, by its own definition. EA **L165** nominates *"API Platform = **inbound** adapters"*, but `API Platform` **holds no `BC-` identifier** — it appears only as a diagram band (BC Map L223) and as the single Open Host Service (L358), and is **not** one of the 31 contexts. EA **L1407** does list *"Webhook Reconciliation (V1)"*, but `DOCUMENTATION_BASELINE.md` **L139** marks the EA *"Descriptive — must follow the PRDs, never lead them"*, so it records intent and **confers no ownership** |
| **Why `BC-31` is not simply assumed** | It would extend an Accepted Rank 4 definition from *outbound* to *inbound* by silent reading. That is a boundary change, and `ADR-INDEX` process step 1 requires an ADR **before** it. **Not done here** |
| **Minimum amendment required** | A **capability declaration naming an inbound-adapter owner within `platform/integration`** — the same shape as `platform/business`'s existing `ports: [platform/integration:payment_gateway]` (`tool/module_dependencies.yaml` L409). An existing platform capability is **preferred over any new bounded context**, consistent with `AR-1`: a receiver that validates and forwards owns no aggregate, no invariant and no business state. **No new `BC-` is needed and none is proposed** |
| **NOT invented here** | No endpoint, URL, payload, schema, signature scheme, retry policy, provider callback behaviour, permission identifier, configuration identifier or edge ID. The owner is not guessed |
| **What is already settled and needs no decision** | A webhook is **transport**, so it **MUST NOT** write financial truth. `FEE-BR-014` (client-side success is never financial truth), `FEE-INV-005` (idempotency key + gateway-reference uniqueness), `FEE-BR-016` and frozen `MM-BR-005` (*"Enforcement of the payment side is `BC-05`'s"*) already require server-side verification inside `BC-05`. **An inbound message is evidence to be verified, never an instruction to be obeyed** |
| **Blocks** | ✅ **NO LONGER BLOCKS — resolved at v1.1.** *Superseded text, retained so the record of what it blocked stays readable:* ⛔ **Stage 4 and Freeze.** `FEE-FR-028` (webhook/reconciliation contract) and the server-side confirmation *mechanism* cannot be specified until the receiver is declared |
| **Authority** | **Architecture Owner** (as ARB) — a boundary/capability declaration |
| **Recorded in** | `ADR-0035` §5.5 (`D-4`). **The ADR is now `ACCEPTED`** — *"In force. Binding on all implementation"* |
| ✅ **RESOLVED at v1.1 — the inbound owner is declared** | **`ADR-0035` §5.5b** records the answer to `D-4`, **given by direct conferral of Architecture Owner authority by the human principal**: **the inbound payment webhook is an existing Business Platform capability.** It is the **return leg of the very call `O-3` already makes outbound**, so it needs **no new bounded context** — the context count stays **31** and **no `BC-32` is created**, consistent with `AR-1`, which the receiver passes on all four criteria exactly as `O-3` does (owns no aggregate, no invariant, no business state; orchestrates only and delegates every domain operation). **What was already settled needs no change:** a webhook remains **transport**, so `FEE-BR-014`, `FEE-INV-005`, `FEE-BR-016` and frozen `MM-BR-005` continue to require server-side verification inside `BC-05`; **an inbound message is evidence to be verified, never an instruction to be obeyed.** **Still NOT invented, and the conferral did not supply any of them:** no endpoint, URL or route · no payload schema · no signature algorithm, header name or replay window · no retry policy · no provider · no permission or configuration identifier · no new `E-*` edge · no change to `BC-31`'s **outbound** scope. `FEE-FR-028` may now name its counterparty; **its wire contract is a Stage 4 concern and is not written here** |

---

## 38. Risks

| ID | Risk | Severity | Mitigation |
|---|---|---|---|
| `FEE-RSK-01` | Duplicate payment capture — *"unrecoverable trust damage"* | **Critical** | `FEE-FR-029`…`032`, `FEE-INV-005` (`MP-RSK-04`) |
| `FEE-RSK-02` | A second ledger appears in another module | High | `FEE-INV-009`, `MM-XC-004` mirror |
| `FEE-RSK-03` | `BC-05` and `BC-20` money mixed in a report | High | `FEE-BR-003`, `FEE-XC-001`/`002`, `MP-GBR-24` |
| `FEE-RSK-04` | Online payment accepted on a client-side signal | High | `FEE-BR-014`, `FEE-FR-026`/`027` |
| `FEE-RSK-05` | Staff workaround because partial payment is unrepresentable | High | `FEE-GAP-008` — surfaced, not hidden |
| `FEE-RSK-06` | Uncorrectable data-entry error drives a shadow ledger | High | `FEE-GAP-005` |
| `FEE-RSK-07` | Cross-tenant financial leakage | **Critical** | `FEE-FR-057`/`058`, `FEE-XC-016`, fail-loud tenancy |
| `FEE-RSK-08` | Gateway vendor leaks into domain code | Medium | `FEE-XC-005`/`006`, Dependency Matrix `X-03` |
| `FEE-RSK-09` | Audit obligations unenforceable (`X-10` not implemented) | Medium | Disclosed in §24; `D-09` |
| `FEE-RSK-10` | Building to this draft as if approved | **Critical** | This header; **5** Stage-4-blocking gaps — *re-derived at v1.1 (§39.1). This cell read "5" while the header read "6" from v0.7 to v1.0: a **pre-existing stale count**, now correct by coincidence rather than by maintenance, and flagged so it is not mistaken for having been right all along* |

---

## 39. Open Decisions

| Gap | Decision needed | Owner | Blocks Stage 4 | Blocks Freeze |
|---|---|---|---|---|
| `FEE-GAP-001` | Refund V1 or V2 — **product scope DECIDED** (`ADR-0039` §3: confirmed-only, immutable original, separate operation, **full refund only**, cash server-recorded); the **Architecture Owner** half (Rank 6 EA still says `Refunds (V2)`) is untouched | Product Owner + Architecture Owner | ✅ | ✅ |
| `FEE-GAP-002` | Gateway path + offline path — ✅ **OWNERSHIP CONFLICT RESOLVED at v1.5 by DETERMINATION** (`ACCEPTED` `ADR-0040` §1): **`ADR-0035` §5.5b is UPHELD UNCHANGED** — ingress is **`platform/business`**; the `platform/integration` reading is **not adopted**. `FEE-FR-028` now carries `FEE-AC-085`…`089`, testing **`BC-05`'s own verification obligation** with **no** endpoint, schema, signature, provider or retry policy. ⚠ **The wire contract remains open** — owner: **`BC-31` owner once `PRD-019` exists** (`ADR-0040` §2/§4). *Superseded row text retained verbatim:* ⛔ **CONFLICT REPORTED, NOT RESOLVED** (`ADR-0039` §2): the offered routing names `platform/integration`, `ACCEPTED` `ADR-0035` §5.5b names `platform/business`. **Escalated, not worked around.** `FEE-FR-028` still has **⛔ no acceptance criterion** | Architecture Owner | — | ✅ |
| `FEE-GAP-003` | Bank transfer | Product Owner | — | ✅ |
| `FEE-GAP-004` | Fee-type taxonomy (incl. deposit) — **DECIDED** (`ADR-0039` §4: membership, renewal, registration/admission, other approved fee = revenue; **Security Deposit = refundable liability, NOT revenue**). Supplies the **base** `PRD-022` `SAAS-GAP-001` needs, **without closing that gap** | Product Owner | ✅ | ✅ |
| `FEE-GAP-005` | Obligation correction path — **DECIDED** (`ADR-0039` §5: **append-only**; original immutable; correction references the original with actor, reason, timestamp, corrected state). Rests on Rank 1 `MP-GBR-12`, **not** the `BC-03` analogy | Product Owner + Architecture Owner | ✅ | ✅ |
| `FEE-GAP-006` | Due-date rule and grace — **OFFSET DECIDED = 0 days** (`ADR-0039` §6: configured due date **is** the due date; no hidden `+N`). Imports **no** value from `PRD-022`’s 15th, so `MP-GBR-24` holds | Product Owner | ✅ | ✅ |
| `FEE-GAP-007` | Discount approvers / ceiling | Product Owner | — | ✅ |
| `FEE-GAP-008` | Confirm partial payments V2 | Product Owner | — | — |
| `FEE-GAP-009` | Invoice aggregate or projection | Architecture Owner | — | ✅ |
| `FEE-GAP-010` | Vendor named or not | Architecture Owner | — | — |
| `FEE-GAP-011` | Retention | Product Owner + Security | — | ✅ |
| `FEE-GAP-012` | Registry / `BC-26` / report tier / gate | Governance + Architecture + Product | — | ✅ |
| `FEE-GAP-013` | **Partly resolved.** Remaining: protection window + configurability; usage-history store; **term deduction (f)**; cross-tenant read edge; previous-library disclosure | Product Owner + `BC-02`/`BC-06`/`BC-10` owners + Architecture + Security | — | — |
| `FEE-GAP-014` | Platform commission %, settlement balance, net-off, gateway charge, settlement view — **all `BC-20`**. **`PRD-022` now EXISTS** (`DRAFT` v0.1, 2026-08-05) and is the named home; the subject matter is specified there as *Platform Charge*. **STILL OPEN** — `PRD-022` records **6 of 6 blocking gaps** of its own, so the questions were *relocated to a lawful owner, not answered* | `BC-20` owner + Architecture + Governance + Product | — | — |
| `FEE-GAP-015` | Is `Platform Owner / Super Admin` a third platform role, or a permission set on a `PR-1`? Platform-config authority | `PRD-001` owner + `BC-18` + `BC-25` | — | — |
| `FEE-GAP-016` | **Inbound webhook transport owner** — who receives a provider callback before `BC-05` verifies it | Architecture Owner | ✅ | ✅ |
| `FEE-GAP-017` | **Cash-only commission settlement** — a library with 100%% cash collections and **zero** online payments has no lawful, auditable way to remit its LIBOORA commission: no receivable aggregate, no outbound settlement obligation, and **no enumerated permission** for any role to initiate one. **`PRD-022` now EXISTS** and is the home: cash-only settlement is a **first-class V1 requirement** there (`SAAS-FR-009`), with net-off explicitly **not** the only mechanism (`SAAS-BR-005`). **STILL OPEN** — `PRD-022` `SAAS-GAP-003` records that the outbound remittance has **no described shape**, and `SAAS-GAP-004` that **no enumerated permission exists for any role**, including `TR-1` Owner | `BC-20` owner + Architecture + `PRD-001` + Governance + Product | — | — |

**5 block Stage 4. 10 block Freeze — re-derived again at v1.4, and unchanged by the four decisions recorded that version.** Stage-4 set = `FEE-GAP-001`, `002`, `004`, `005`, `006`; Freeze set = those five plus `003`, `007`, `009`, `011`, `012`. **The ✅ marks in the table below record that a gap *blocks*, not that it is *undecided*** — `FEE-GAP-001`, `004`, `005` and `006` now carry recorded product decisions (`ADR-0039`) and **still block**, because the obligations they govern remain untestable. **`FEE-GAP-002` additionally carries a ⛔ reported, unresolved conflict** over inbound-webhook routing. *Superseded count line retained verbatim:* **6 block Stage 4. 11 block Freeze.** *(Both re-derived mechanically from the table above at v0.8 — not carried forward. See §37.)*

### 39.1 Gap reconciliation — all 17 re-measured at v0.9, then again at v1.1 after the conferral

**Every gap was re-measured against the repository, not read off the previous report.** Classification uses the
nine categories the governance instruction names. **Nothing is closed, deleted, renumbered or downgraded**, and
**no traceability figure moves** — this section adds no identifier.

| Gap | Classification at v0.9 | Evidence measured, and why it is not closed |
|---|---|---|
| `FEE-GAP-001` | **REQUIRES PRODUCT OWNER** | Refund V1-or-V2 scope. Unchanged; no product ruling exists |
| `FEE-GAP-002` | **PARTLY RESOLVED — (a)(b) IN FORCE; (c) REQUIRES ARCHITECTURE OWNER** | *Superseded at v1.1, retained:* *"`ADR-0035` `D-2` **DECIDED `O-3`** — but the ADR is **`PROPOSED`**, and 'a decision recorded in a `Proposed` ADR does not bind' (`ADR-INDEX.md` L9). Not resolved"*. **At v1.1 `ADR-0035` is `ACCEPTED`, so `D-1` and `D-2` now bind.** The gap **still blocks** on **(c)** offline financial capture — `E-24` is `BC-03` → `BC-30` only and **no decision was given on it** |
| `FEE-GAP-003` | **REQUIRES PRODUCT OWNER** | Bank transfer as a V1 method. Unchanged |
| `FEE-GAP-004` | **REQUIRES PRODUCT OWNER** | Fee-type taxonomy. **Now also blocks `PRD-022`** — `SAAS-GAP-001` (which collections accrue a Platform Charge) depends on this taxonomy, so one open product question now blocks **two** modules |
| `FEE-GAP-005` | **REQUIRES PRODUCT OWNER** + **REQUIRES ARCHITECTURE OWNER** | Obligation-correction path. Unchanged |
| `FEE-GAP-006` | **REQUIRES PRODUCT OWNER** | Due-date rule and grace. Interacts with `Q-01` (BC Map **L540**), which is **still open** |
| `FEE-GAP-007` | **REQUIRES PRODUCT OWNER** | Discount approvers and ceiling. Unchanged |
| `FEE-GAP-008` | **VALIDLY DEFERRED** | Partial payments are V2 by exclusion. Blocks neither gate — the one gap where "not blocking" is the measured truth rather than an omission |
| `FEE-GAP-009` | **REQUIRES ARCHITECTURE OWNER** | Invoice aggregate vs projection. Unchanged |
| `FEE-GAP-010` | **VALIDLY DEFERRED** | Whether to name a vendor. Deliberately unanswered: naming one is exactly what this pass must not do |
| `FEE-GAP-011` | **REQUIRES SECURITY-PRIVACY** | Financial-record retention. Unchanged |
| `FEE-GAP-012` | **REQUIRES PRD-022** *(partly)* + **REQUIRES ARCHITECTURE OWNER** | Registry / `BC-26` / report tier / gate. The **registry half is now discharged**: `PRD-022` is registered `DRAFT` (`PRD_REGISTRY.md` v1.9). The `BC-26` and gate halves are untouched, so the gap **stays OPEN** |
| `FEE-GAP-013` | **OPEN — REQUIRES PRODUCT OWNER** + **ARCHITECTURE OWNER** + **SECURITY-PRIVACY** | Renewal protection. **See §39.2: one of its six parts is now measured as *forbidden*, not merely undecided** — which narrows it without closing it |
| `FEE-GAP-014` | **REQUIRES PRD-022** → **home exists, question OPEN** | `PRD-022` `DRAFT` v0.1 is the named owner. Its own `SAAS-GAP-001`…`006` all block Stage 4 and Freeze |
| `FEE-GAP-015` | **REQUIRES AUTHORIZATION OWNER** | Is `Platform Owner / Super Admin` a third platform role or a `PR-1` permission set? **Re-measured and now harder**: `PRD-022` uses **`PR-1` only**, mints no third platform role, and `AUTH-7.22` closes the permission catalogue with **0** `PERM-*` identifiers repo-wide |
| `FEE-GAP-016` | ✅ **RESOLVED at v1.1 — no authority outstanding** | Inbound webhook owner. **`ADR-0035` §5.5b**, `ACCEPTED` by conferral: the inbound payment webhook is an **existing Business Platform capability** — the return leg of `O-3`'s outbound call. **No `BC-32`**, count stays **31**. *Superseded text, retained so the reasoning that kept it open stays readable:* *"Re-measured at v0.9 and unchanged — `ADR-0035` **§5.5a** records that the EA **L1407** `Webhook Reconciliation (V1)` entry … had **already** been measured and disposed of in that ADR's §3.4: the EA is Rank 6 'descriptive only' and **cannot confer ownership**"*. **That remains true**: §5.5a's finding is **vindicated, not contradicted** — the EA still confers nothing, and what changed is not the evidence but **the existence of a decision** |
| `FEE-GAP-017` | **REQUIRES PRD-022** + **REQUIRES AUTHORIZATION OWNER** | Cash-only settlement. Home exists (`SAAS-FR-009`). **The authorisation half is the hardest finding in this pass**: no enumerated permission lets **any** role settle, `TR-1` Owner included (`SAAS-GAP-004`) |

**Counts after the v0.9 reconciliation: 17 gaps, 6 block Stage 4, 11 block Freeze — unchanged at that version.** **Counts after the v1.1 conferral, re-derived mechanically from each gap block's own `Stage 4`/`Freeze`/`Blocks` field — not decremented: 17 gaps (none deleted, one now RESOLVED), 5 block Stage 4, 10 block Freeze.** Stage 4 blockers = `FEE-GAP-001`, `002`, `004`, `005`, `006`. Freeze blockers = those five plus `003`, `007`, `009`, `011`, `012`. **Exactly one gap left both sets** — `FEE-GAP-016` — and **`FEE-GAP-002` did not**, because its part (c) was never decided. **The gap total stays 17 on purpose:** a resolved gap is marked resolved, **not removed**, so the ledger keeps its own history. Two gaps gained a named
home and **neither closed**; one gap (`FEE-GAP-013`) had one part reclassified from *undecided* to *forbidden by a
frozen rule*, which is a narrowing, not a resolution. **`FEE-GAP-004` is now measurably worse than before**: it
blocks a second module. Recording a lower blocker count on the strength of `PRD-022`'s existence would confuse
*having somewhere to ask the question* with *having the answer*.

### 39.2 Renewal protection — what the frozen rules constrain, and the finding this section got wrong (`FEE-GAP-013`)

Measured against **frozen Rank 3** documents. These findings **constrain** `FEE-GAP-013`; none closes it.

> **⚠ CORRECTION AT v1.0 — declared, not quietly rewritten.** At **v0.9** this section was titled *"what the
> frozen rules already **forbid**"* and was read as establishing that 3-day renewal protection **cannot** be a V1
> behaviour. **That reading was wrong, and it was wrong in the direction that made the requirement look
> impossible rather than merely blocked.** It conflated three separate things:
>
> | Thing | Frozen status | Does it block a protection window? |
> |---|---|---|
> | **Money arithmetic** — proration, refund, term deduction | ⛔ V1-forbidden (`MM-XC-012`, `MM-FR-100`) | **No.** A protection window computes no money |
> | **Entitlement extension** beyond `endDate` | ⛔ V1-forbidden (`MM-FR-111`) | **No**, if the window confers no entitlement |
> | **Seat-release timing after expiry** | ❓ **OPEN — `Q-01`** | **YES — this is the actual blocker** |
>
> Frozen `PRD-005` **L820-823** draws the distinction itself: `Q-01` *"is about **seat release** timing …, **not**
> about extending membership validity."* `MM-FR-112` **defers** seat reclamation to `BC-04` rather than
> prohibiting it. And frozen `PRD-007` **L1166-1172** states that PRD is *"written to be correct under any
> resolution"* of `Q-01`, *"because the release action becomes a policy-driven trigger over an already-flagged
> allocation rather than a redesign."*
>
> **The corrected position, recorded in full by [`ADR-0036`](../../00-governance/adr/ADR-0036-three-day-renewal-protection-q01.md)
> — at v1.1 `PARTLY ACCEPTED`, on its questions 1 and 3 only:** 3-day renewal protection is a **V1 product requirement**
> that was **blocked on `Q-01`**, an open question with named owners — **not** a behaviour forbidden by frozen rule.
>
> **✅ AT v1.1 THE PRODUCT QUESTION IS ANSWERED, AND THE PROHIBITIONS IN THE TABLE BELOW ARE CONFIRMED, NOT LIFTED.**
> By **direct conferral of Architecture Owner authority by the human principal** — **no ARB quorum, attendee list,
> sign-off date or Security review asserted** — the decision given is: ***3-day renewal protection is mandatory in V1,
> with no membership extension, no penalty, no proration and no term deduction.***
>
> | Part of the decision | Effect on this section |
> |---|---|
> | **3 days, mandatory, V1** | Answers `ADR-0036` question 1 and `FEE-GAP-013`(a2)'s *duration* half. The competing **24h** *recommendation* at Master PRD L673 / BC Map L540 is **overridden by the authority entitled to override it** — and `PRD-005` §7.4 already held that a recommendation inside an open question *"is not a decision"*, so **nothing is reversed** |
> | **No term deduction** | **Confirms row 1 of the table below rather than contradicting it.** The frozen rules said the deduction **MUST NOT** be implemented in V1; the conferral says the same thing. `MM-XC-012`, `MM-FR-100`, `MM-FR-086`, `MM-FR-057`, `MM-FR-057a` and `MM-FR-058` are **untouched**, and `FEE-GAP-013`(f) is answered **in the direction the frozen documents already required** |
> | **No extension** | Confirms frozen `MM-FR-111`. A protection window confers **no entitlement** beyond `endDate` |
> | **No penalty, no proration** | Confirms `MM-XC-012`/`MM-FR-100`. **No money is computed by a protection window**, so no `FEE-*` requirement is added |
> | **Not configurable** (`ADR-0036` question 3) | The window is **FIXED**. So **no `CFG-*`/`LCFG-*`/`ICFG-*` identifier is needed and none is allocated**, and row 4 of the table below — *"May the window duration be a configurable parameter?"* — is answered **NO**, which is why no register amendment follows |
>
> **⛔ WHAT THE CONFERRAL DID NOT ANSWER, stated so the answer is not read wider than it is:**
> **(1) The window boundary.** *"3-day"* does not decide whether the window begins **on** `endDate` or **the day after**
> — 5 Aug → 8 Aug is four inclusive days; 6/7/8 Aug is three. This is **customer-visible** and belongs to the
> **Product Owner**; `ADR-0036` §8.2 keeps it open and §8.3 explains why it deliberately carries **no new `MM-GAP-*`
> identifier**. **(2) `Q-01` itself.** Seat-release timing is `BC-04`/`BC-06`/`BC-25` business and row 3 below still
> stands as an **open architectural question**; the conferral set a protection duration, it did not resolve when an
> expired membership releases a seat. **(3) `FEE-GAP-013`(b), (c), (d), (g)** — usage-history storage, the cross-tenant
> read, previous-library disclosure and the student request path. **`SID-4.19`, `ID-2`, `ID-3` and `MP-GBR-24` are
> untouched, and the cross-library indicator remains forbidden in V1.** The rows below are retained because
> **two of the three were correct**; the third is corrected in place and marked.
>
> **`FEE-GAP-013` remains OPEN and its blocking status is unchanged.** This correction changes what is *true*,
> not what is *closed*, and no count in §39.1 or §39 moves.

| Question | Measured | Consequence |
|---|---|---|
| May the next membership term be shortened by the days used during a protection window? | Frozen `PRD-005` **L191** `MM-XC-012` — *"Proration arithmetic executed as money (**V2**…)"*; **L759** `MM-FR-100` — the module **MUST NOT** compute a prorated monetary credit; **L814** `MM-FR-111` — V1 **MUST NOT** implement a grace period extending entitlement beyond `endDate`; **L1505** Proration Rules **V2** | **The previously requested *"subtract 3 days from the next membership"* behaviour MUST NOT be implemented in V1.** It is term deduction, which frozen architecture defers to V2. Changing this requires an **amendment or ADR first** — it cannot be specified here |
| Is there an aggregate that can hold a seat without allocating it? | Frozen `PRD-007` **L8** — *"Aggregates owned: `SeatAllocation` · `SeatLayout`"*. `grep -rn "SeatHold\|SeatReservation" docs` → **0** | **⚠ CORRECTED at v1.0. The measurement stands; the conclusion drawn from it did not.** No `SeatHold` aggregate exists — but **none is needed**, because the seat is **not** unallocated during protection. Frozen `SEAT-BR-024` **retains** the existing allocation on expiry (*"MUST NOT be automatically released, truncated or moved … MUST be flagged for human resolution"*), `SEAT-FR-155` flags it, and `SeatState` derivation rule 2 makes it **`Occupied`**, never `Available`. The v0.9 conclusion assumed protection required a *protected-but-unallocated* seat; it does not. See `ADR-0036` §4.1 |
| When does an expired membership release a seat? | BC Map **L540** `Q-01` — *"immediately, at end-of-day, or after a grace period?"*, recommendation *"Configurable per tenant (BC-25), default 24h grace"* | **Still an open architectural question.** A 3-day protection window cannot be specified on top of an unresolved release rule |
| May the window duration be a configurable parameter? | `CONFIGURATION_GUIDE.md` §5 — *"Adding a parameter → **a PRD amendment**"*; the guide governs **35** parameters and holds **no** renewal-protection window | Configurability must be **declared by a PRD**, and the identifier allocated by `BC-25`/`PRD-023`. **No `CFG-*`/`LCFG-*`/`ICFG-*` identifier is invented here**, and a tenant policy is **not** given to a platform role |
| May a student be labelled across libraries? | No authority permits it; Student Identity isolation and `MP-GBR-24` both bear on it | **Forbidden.** No *cheater*, *fraud*, *abuser*, *high-risk*, *blacklist* or *watchlist* label; **no cross-tenant financial read**; no disclosure of a previous library, its financials, receipts, staff notes or reasons for leaving. If such a signal is ever wanted it is **V2 and a separate authority**, not an inference from this document |

> **What is *not* forbidden, and is already lawful to state as intent:** during a protection window the seat is not
> offered to another student, and the membership's status is visible to the library. Both are statements about
> **allocation and display**, not about money or entitlement arithmetic. **A voluntary leave gets the normal
> expiry path; there is no permanent penalty of any kind.**
>
> **⚠ The v0.9 text continued *"neither can be specified until the owning aggregate (`SeatHold`, which does not
> exist) and `Q-01` are settled"*. The `SeatHold` half of that sentence is withdrawn** — it repeated the error
> corrected in the row above. **Only the `Q-01` half survives**, and it is the whole of the blocker: the seat is
> already retained by `SEAT-BR-024`, and what is missing is the **named, bounded 3-day policy** deciding when the
> already-flagged allocation is released. `ADR-0036` §5 states the decision and §8 names its owners.



> **At v0.7 the counts move: 15 → 16 gaps, 5 → 6 Stage-4 blockers, 10 → 11 Freeze blockers.**
> **At v0.8 the gap count moves 16 → 17, and the blocker counts DO NOT MOVE — they stay 6 and 11.**
> `FEE-GAP-017` blocks **neither** Stage 4 **nor** Freeze *of this PRD*, because **`BC-05` owns none of
> what it describes**: a library → LIBOORA commission settlement is `BC-20` money (`MP-GBR-24`, BC Map
> **L129**) and belongs to the unwritten **`PRD-022`**. It is recorded here because this PRD is where
> the confirmed-cash **fact** that a settlement would be computed from is produced, and because a
> reader of this PRD must be told where the commission goes and that it never comes back. **It is a
> blocker for `PRD-022` and for the product feature, not for `BC-05`** — and that distinction is the
> reason the blocker counts are honestly unchanged rather than inflated to look thorough.
> `FEE-GAP-002`'s *counterparty* half — **who executes** — is **RESOLVED** by `ADR-0035` `D-2` (`O-3`: a Business
> Platform **capability**, no new context, context count stays **31**). `FEE-GAP-016` is opened for the narrower
> **inbound-transport** question that resolving execution exposed.
>
> **⚠ RETRACTION — recorded rather than quietly corrected.** An earlier draft of this pass claimed the Stage-4
> blocker count *"stays at 5"*, reasoning that `FEE-GAP-016` simply **replaced** `FEE-GAP-002` in the blocking set.
> **That claim is false.** `FEE-GAP-002` has **three** parts, and part **(c) — the offline financial-write path
> (`BC-30`) — was never resolved**: `E-24` is `BC-03` → `BC-30` only, and nothing in this pass touched it. So
> `FEE-GAP-002` **remains** a Stage-4 and Freeze blocker, `FEE-GAP-016` is **additive**, and the true counts are
> **6** and **11**. Both are now derived by mechanically parsing the §39 table's own `Blocks Stage 4` / `Blocks
> Freeze` columns — the same method that caught the error — rather than reasoned about in prose.
>
> **This is stated plainly because the error ran in the self-flattering direction:** it made the document look as
> though closing an architectural question cost it nothing. It cost it one net blocker.

`FEE-GAP-013`, `FEE-GAP-014` and `FEE-GAP-015` block **neither** Stage 4 nor Freeze of *this* PRD, because
`BC-05` owns none of their blocked parts. They block the **features**. Building the renewal-protection window, the term deduction, or the
cross-library indicator requires **four ADRs by four owners** — see §37.

---

## 40. V1 Success Criteria

`PRD-008` V1 is successful when **all** hold:

1. Every `FeeDue` traces to a membership event or an audited manual act — none invented.
2. Balance is always `Σ dues − Σ receipts`, computed, never stored.
3. No student is charged twice, under retry, duplicate callback or double staff entry.
4. No issued receipt has ever changed.
5. No financial record was edited or deleted; every correction is a compensating entry.
6. No financial datum crossed a tenant boundary.
7. No report mixes `BC-05` and `BC-20` money.
8. Every financially sensitive act has an audit fact.
9. No online payment succeeded on a client signal alone.
10. `BC-05` defined no metric formula and holds no reporting store.
11. Exactly **three** `fee.*` events exist.
12. **All fifteen gaps are closed by their named authority** — five before Stage 4.
13. No `BC-05` record, report or breakdown ever carried a platform-commission, settlement or gateway
    field — the `MP-GBR-24` boundary held in the **schema**, not only in the UI.

**None is currently met.** No implementation exists; `FROZEN`/`VERIFIED` are not claimed.

---

## 41. Changelog

| Version | Date | Change |
|---|---|---|
| **v1.7** | 2026-08-16 | **THE LAST SIX FREEZE BLOCKERS CLOSED — 6 → 0 — AND THIS PRD IS STILL NOT FROZEN.** Read those two clauses together or this row will be misread. **Six conferred decisions are recorded in `ADR-0043`**, and each gap stops blocking for a reason checkable outside this document. **`FEE-GAP-002`:** `PRD-019_INTEGRATION.md` **v0.1 `DRAFT`** was created as the **owner** of the payment webhook wire contract, assigning `ADR-0040` §4 **L165**’s five elements (endpoint, payload schema, signature algorithm, replay window, retry policy) to **`BC-31`**. ⛔ **The contract itself is still UNWRITTEN and the gateway feature is still UNBUILDABLE** (`Q-B31`); what closed is the *ownership* question this gap asked. **The contract is NOT duplicated in this PRD**, which keeps only webhook **verification** and financial truth — so the v1.5/v1.6 refusal to author it is **upheld, not retracted**: of `ADR-0040` §2’s four barred authors, **three bars are substantive and only the procedural one** (*"`PRD-019` does not exist"*) **is removed. `FEE-GAP-003`:** bank transfer is **not** a V1 method, and money arriving outside a supported flow **cannot self-confirm** — determined by obligations this PRD **already carried** (`FEE-FR-061`, `FEE-XC-022`, `FEE-BR-011`/`014`, `FEE-AC-081`/`082`, `ACCEPTED` `ADR-0037`), so **no rule, exclusion or identifier was written**. **`FEE-GAP-007`:** the `owner` is the **sole approver by default**, `manager` has **none**, and the `owner` may grant it through Master PRD **§6.1**’s existing scope-bearing mechanism (`MP-GBR-20`/`21`/`23`) — **no permission ID, no role and no scope value invented**, and `FEE-XC-014`’s bar is honoured. **`FEE-GAP-009`:** §29.3’s three-state Invoice table — the defect that gap’s own `Freeze` field named — is **corrected to a projection** of §29.1; **no state value or aggregate moved**. **`FEE-GAP-011`:** **no retention period was invented**; the policy is routed to **Product + Security/Compliance** (`Q-S1`, still OPEN) and V1 behaviour is already fixed by `FEE-XC-011` — nothing is purged. **`FEE-GAP-012`:** (a) the **Governance Owner** moved `PRD_REGISTRY.md` **L245** `PLANNED` → `DRAFT` on the register’s **own** §2.1 **L42** test and its **own** twice-executed `PRD-004`/`PRD-022` precedent — **`GCP-14`’s wording defect stays OPEN** and the fact that this is the *convenient* direction is disclosed; (c) the `Financial Reports` tier is **Rank 6 internal** and cannot bind `BC-05`, raised as new **`Q-A7`** — **the EA is byte-unchanged**. **`Q-A6` was resolved by determination with Rank 1 `MASTER_PRD.md` BYTE-UNCHANGED.** ⛔ **WHAT DID NOT HAPPEN:** **this PRD is NOT frozen.** Freeze is conferred by a row in `DOCUMENTATION_BASELINE.md` §3 — **none was written or requested** — and **Stage 5 and Stage 6 have never been performed** (`docs/40-implementation/revenue-finance/` **does not exist**). **Zero Freeze blockers is not Stage 7.** **§0.2 is unchanged: Total 249, obligation-bearing 134, `FEE-XC-*` 23, `FEE-AC-*` 98/98**; **not one `FEE-*` identifier was minted, renumbered or deleted**; the 17-gap register keeps its membership; the **undeclared `FEE-RSK-*` register remains reported, not silenced**; and **no edge, endpoint, schema, signature algorithm, replay window, retry policy, provider, role, permission, ceiling, retention period, state value, aggregate or configuration identifier was invented**. **No frozen document, no `ACCEPTED` ADR, no Rank 1 line, no EA line, no BC Map line and no Dart source was touched; no checker was weakened.** ⚠ **The pre-existing §41 defect is STILL not fabricated:** this table has no v1.1–v1.5 rows, and v1.7 does **not** invent five rows of history it did not perform. |
| **v1.6** | 2026-08-15 | **FOUR FREEZE BLOCKERS CLOSED, SIX STILL BLOCK WITH ONE NAMED RESIDUAL AND ONE NAMED OWNER EACH, AND TWO CONFERRED INSTRUCTIONS REPORTED AS UNEXECUTABLE.** **Freeze blockers 10 → 6.** **No identifier was minted, so every register total in §0.2 is unchanged — Total **249**, obligation-bearing **134**, exclusions **23**.** ✅ **`FEE-GAP-001` closed** — the one act its `Freeze` field demanded was performed by the **Architecture Owner**: EA **L823** `Refunds (V2)` → **`Refunds (V1)`**, EA **v2.1 → v2.2** with a §11 changelog entry, and `DOCUMENTATION_BASELINE.md` §3.2 updated in the same commit per its §7 step 3. The correction ran **forwards** under `MP-CON-08` — Rank 6 updated to match Rank 4 BC Map **L100**/**L374**/**L422**, *"never the reverse"*. **EA L1408 `Refund Management (V2)` was deliberately NOT changed** (its parent is `Payment Gateway (V1)`, LAYER 4, not the library’s fee capability; routed as `Q-A5`), and this block’s own *"EA L1409"* citation is **disclosed as defective** — L1409 is `Payment Retry (V2)`. ✅ **`FEE-GAP-004`/`005`/`006` closed** — not by new decisions but because **`ADR-0039` was promoted `PROPOSED` → `ACCEPTED`**, so the fee taxonomy, the append-only correction rule and the **0-day** due-date offset now **bind**; the acceptance is **scoped** (§3–§6 bind, §2 is a report, **§7 superseded by measurement and retained verbatim**). ⛔ **Six still block, each reduced to one residual:** `002` — the webhook **wire contract** (`Q-G2` create `PRD-019`, Governance Owner; `Q-B31` author it, `BC-31` owner); `003` — bank transfer **decided NOT V1**, residual is what staff do with an out-of-band bank credit (`Q-P1`); `007` — ceiling limb closed by **inventing none**, residual is whether `manager` is also an approver (`Q-P2`); `009` — Rank 4 reading **ratified**, residual is that **§29.3 still prints a three-state Invoice table** (`Q-G1`); `011` — **routed exactly as instructed**, no retention period invented (`Q-S1`); `012` — limbs **(b)** and **(d)** closed, **(a)** registry status held by `GCP-14` and **(c)** report tier structurally unarbitrable because **both** EA lines are Rank 6 (`Q-P3`). ⚠ **TWO CONFERRED INSTRUCTIONS COULD NOT LAWFULLY BE CARRIED OUT, AND ARE REPORTED RATHER THAN APPROXIMATED — this is the most important sentence in this row.** **(i)** *"Create/define the required `PRD-019` webhook contract"* collides with the same instruction’s Rule 2: `ACCEPTED` `ADR-0040` **§4 L165** defines that contract as *endpoint, schema, signature, replay window, retry policy* — the barred list itself — **L166** forbids holding another PRD’s content as a second source of truth, `PRD-019` files on disk = **0**, and all four candidate authors remain barred (`ADR-0040` §2 **L77–L83**). **(ii)** *"If not required for V1, defer/exclude discounts"* — the precondition is **measured FALSE**: `FEE-FR-039` is already specified at **L1001** and already testable via **`FEE-AC-049`** (L1893), and Rank 4 BC Map **L100**/**L374** place `Discount` in V1 as an aggregate member with an approver invariant. **Excluding it would subordinate Rank 4 to a V1 scope note**, the inversion `MP-CON-08` forbids and `DOCUMENTATION_BASELINE.md` §4 **L224** requires be raised. **Nothing was invented:** no twenty-fourth `FEE-XC-*` exclusion for the bank-transfer deferral (§32 **L1547** and the **L66–L71** note are the precedent), no discount ceiling, no `FEE-CFG-*` register, no retention period, no permission, no `E-*` edge, no endpoint, schema or provider, no state value. **Nothing was self-served:** `PRD_REGISTRY.md`, the BC Map, `MASTER_PRD.md`, `PRD-022`, `tool/module_dependencies.yaml` and every frozen PRD are **byte-unchanged**, and `tool/docs_check/prd008_traceability.py` was **not weakened**. ⚠ **A NEW DRIFT CREATED BY THIS WORK IS DISCLOSED, NOT REPAIRED:** the EA bump to **v2.2** makes `MP-CON-08`’s literal *"v2.1"* stale inside **Rank 1** `MASTER_PRD.md` (7 occurrences) — the seventh instance of the `GCP-01`/`07`/`08`/`11`/`12`/`13` class. Editing Rank 1 as a side effect of a Rank 6 bump is the silent amendment `DOCUMENTATION_BASELINE.md` §7 step 1 and `PRD_LIFECYCLE.md` **L177** forbid; routed as **`Q-A6`** to the **Architecture Owner**. ⛔ **THIS PRD IS NOT FROZEN**, and six blockers with named owners is the reason. Full record: `ACCEPTED` `ADR-0042`. ⚠ **Outstanding defects belonging to this document’s owner, listed rather than quietly fixed:** `FEE-RSK-*` is undeclared in §0.2; three duplicate `FEE-AC-*` citations in §36.1; **this changelog has no v1.1–v1.5 rows** — a pre-existing omission that is **NOT back-filled**, because fabricating five historical entries would be worse than the gap; L2382 reads `100%%`; and the *"EA L1408/L1409"* citations at L799 and in the `FEE-GAP-001` block are wrong |
| **v1.0** | 2026-08-05 | **A finding this document asserted at v0.9 is RETRACTED and corrected: 3-day renewal protection is NOT forbidden by frozen rule.** **No identifier was added, so every register count is unchanged** — FR 62 · BR 28 · INV 10 · EVT 3 · XC 23 · PO 8 · AC 84 · GAP 17 = **235**, obligation-bearing **134**, traced **130/134 = 97.0%**, **6 block Stage 4 / 11 block Freeze**. **What was wrong:** §39.2 at v0.9 was titled *"what the frozen rules already **forbid**"* and concluded that the behaviour *"MUST NOT be implemented in V1"* and that a protected seat *"has no owning model"*. Re-measured **with the surrounding prose rather than the identifier lines alone**, that conflated **money arithmetic** (⛔ V1-forbidden by `MM-XC-012`/`MM-FR-100`, and **not needed** — a protection window computes none), **entitlement extension** (⛔ V1-forbidden by `MM-FR-111`, and **not conferred**), and **seat-release timing** (❓ **`Q-01`, OPEN** — the actual blocker). Frozen `PRD-005` **L820-823** makes that separation itself; `MM-FR-112` **defers** seat reclamation to `BC-04`; frozen `PRD-007` **L1166-1172** says that PRD is *"written to be correct under any resolution"* of `Q-01` because *"the release action becomes a policy-driven trigger over an already-flagged allocation rather than a redesign"*. **The `SeatHold` conclusion is corrected in place:** no such aggregate exists, but **none is needed** — `SEAT-BR-024` **retains** the allocation on expiry, `SEAT-FR-155` flags it, and `SeatState` rule 2 renders it **`Occupied`**, never `Available`. **Two of §39.2's three rows were correct and are preserved verbatim**, including the term-deduction prohibition, which remains fully in force. **The correction is declared, not quietly rewritten** — the v0.9 wording is quoted inside each corrective block so a reader can audit what this document claimed and when, on the same principle that kept the v0.8 retraction visible. **`FEE-GAP-013` remains OPEN, and no blocker count moves** — the correction changes what is *true*, not what is *closed*. The corrected position is recorded in full by **`ADR-0036`** (`PROPOSED`, not accepted), which **modifies no frozen document**, closes **no** gap, invents **no** state value, aggregate, requirement, configuration or permission identifier, and preserves 3-day protection as a **V1** requirement **blocked on `Q-01`** rather than downgraded to V2. **Nothing here was closed, deleted, renumbered or inflated; no frozen document was modified; no ADR was accepted; no Dart source was touched.** |
| **v0.9** | 2026-08-05 | **Terminology transition recorded, two gaps given a lawful home without being closed, all 17 gaps reconciled, and one requested behaviour measured as forbidden.** **No identifier was added, so every register count is unchanged** — FR 62 · BR 28 · INV 10 · EVT 3 · XC 23 · PO 8 · AC 84 · GAP 17 = **235**, obligation-bearing **134**, traced **130/134 = 97.0%**, **6 block Stage 4 / 11 block Freeze**. **§1 gains a terminology note:** the library → LIBOORA obligation is **`LIBOORA PLATFORM CHARGE`**, default **3%** (₹500 → ₹15), **defined and owned by `PRD-022` `SAAS-BR-001`**, not here — `FEE-XC-023` still forbids `BC-05` from holding it at all, so introducing the vocabulary here would give this module words for money it may not touch. **The transition is forward-only:** no changelog row, gap entry or `PROPOSED` ADR was reworded, because *editing the vocabulary of a decision record destroys the ability to audit what was known when*, and **no frozen document uses the financial sense at all**. **`FEE-GAP-014` and `FEE-GAP-017` record that `PRD-022` now EXISTS** (`DRAFT` v0.1) as their named home and **both remain OPEN** — `PRD-022` carries **6 of 6 blocking gaps**, so the questions were relocated to a lawful owner, **not answered**. **New §39.1** reconciles all **17** gaps into the nine required categories, re-measured rather than copied: `FEE-GAP-012`'s registry half is discharged but the gap stays open; **`FEE-GAP-004` is now measurably worse**, blocking `PRD-022` `SAAS-GAP-001` as well; `FEE-GAP-016` is **unchanged**, and §39.1 records that the EA **L1407** entry which looked like a new candidate had **already** been measured and rejected in `ADR-0035` §3.4 as Rank 6 descriptive. **New §39.2** records what frozen Rank 3 rules already forbid: `MM-XC-012` (V2), `MM-FR-100` and `MM-FR-111` mean the requested **"subtract 3 days from the next membership" behaviour MUST NOT be implemented in V1** — it is term deduction, and changing that needs an amendment or ADR **first**; **no `SeatHold` aggregate exists** in frozen `PRD-007` (measured **0** repo-wide); `Q-01` is **still open**; and **no cross-library label and no cross-tenant financial read** is permitted. **Nothing was closed, deleted, renumbered or inflated; no frozen document was modified; no ADR was accepted; no permission, role, bounded context, edge, endpoint, schema, provider, rail or configuration identifier was invented; no Dart source was touched.** |
| **v0.8** | *(this draft)* | **CASH-ONLY COMMISSION SETTLEMENT — the settlement mechanism is REFUSED and ROUTED, because measurement shows this PRD may not lawfully specify it and no role can currently perform it.** **The product problem is real and is recorded in full:** a library may take **100 cash memberships × ₹500 = ₹50,000** with **zero** online student payments, leaving LIBOORA a **3% = ₹1,500** commission receivable and **nothing to net it against**. `FEE-GAP-014`'s standing recommendation — *"net-off against future collections"* — **presupposes future online collections exist**, and in this scenario they provably do not, so net-off **cannot be the only mechanism**. **Measured, not assumed — four findings, of which two are determinate and two are absences:** **(1) ownership is already decided and needed no decision from me.** BC Map **L129** gives **`BC-20` Subscription & Billing** *"money owed by a **library to LIBOORA**"* — a commission receivable is exactly that, so **no new context, no `BC-32`, and no ownership ADR is required.** **(2) the outbound rail already exists**, so no edge was invented: BC Map **L334** `E-25` `BC-20 → BC-31` *"Gateway abstraction; Billing knows no vendor names"*, and `platform/business` already declares `ports: [platform/integration:payment_gateway]` (manifest **L409**). **(3) but `BC-20` has no aggregate for it** — BC Map **L382** lists `Subscription`, `SubscriptionInvoice`, `SubscriptionPlan`, `PaymentAttempt`, `DunningState` and **nothing commission-, receivable- or settlement-shaped**; `receivable` = **0 occurrences repository-wide**; `settlement`/`payout`/`net-off`/`revenue share`/`take rate` outside this PRD and `ADR-0035` = **0 each**; and **`PRD-022`, `BC-20`'s own PRD, does not exist** (`PRD_REGISTRY.md` **L326** `PLANNED` — one of `PGA-05`'s *"nine module PRDs named in v1.0 and never written"*). **(4) the decisive finding is the authorisation one, and it is worse than the request assumed.** The request asked whether **`TR-2` Manager** may settle; measurement says **neither role may, today — not even `TR-1` Owner.** `TR-1` has *"financial and revenue visibility"* and commercial authority (`prd-v2/02` **L159**), so Owner settlement is supportable **in principle**; `TR-2` is explicitly barred from *"library-level commercial configuration"* (**L169**) and is *"Operational only … excluding commercial configuration"* (**L200**). **But `AUTH-7.22` (`prd-v2/07` L124) declares the permission catalogue *"closed"* — *"A permission not declared in it cannot be granted, requested or evaluated"* — and `grep -rnoE '`PERM-[A-Z0-9_.-]+`' docs/` returns **0**.** With `AP-9` **L57** *"Fail closed … the decision is refusal"*, a settlement action would be **DENIED for `TR-1` as well**. Further, the **Financial** permission category (**L136**) is illustrated *"Viewing revenue; recording a payment"* — both **inbound** — and does not evidently reach an **outbound remittance to the platform**. **Therefore — `FEE-GAP-017` was recorded instead of an architecture**, exactly as the instruction *"create a precise governance GAP rather than inventing architecture"* requires. **Nothing was invented: no provider, endpoint, webhook schema, bank-account structure, UPI flow, settlement mechanism, aggregate name, permission identifier, role — the tenant register stays *"Five, closed"* and the platform register *"Two, closed"*, and **this document mints no sixth tenant role and no third platform role** — commission rate or audit schema.** The gap names five authorities, records the `E-25`/L409 rail as **already lawful so that no future pass invents one**, and notes that `BC-05` already emits **`fee.FeePaymentReceived`**, so a **subscribe-to-the-existing-event** basis-fact route **may need no new edge at all — to be verified before one is created.** **Why this is not a duplicate of `FEE-GAP-014`:** `FEE-GAP-014` asks *who specifies the commission model*; `FEE-GAP-017` asks a question in which **the direction of money reverses** — every payment path the architecture describes is **inbound** (student → library, or LIBOORA **pulling** via `PaymentAttempt`/`DunningState`), whereas a cash-only settlement is **library-initiated outbound remittance**, which appears **nowhere**. **Exactly one obligation was added, and it is a prohibition:** `FEE-XC-023` bars recording, holding, reducing or reconciling a settlement in any `BC-05` model, table, projection, receipt or metric — including netting it against a `FeeDue`, `FeePayment`, `Receipt` amount, `FeeLedger` balance or student-revenue figure — verified by `FEE-AC-084` (**every `BC-05` figure byte-identical** after a completed settlement). **The requested reconciliation rules are stated as an exclusion rather than a requirement deliberately:** a requirement would make `BC-05` a **participant** in settlement reconciliation, which `MP-GBR-24` forbids. **The historical-rate rule needed no new identifier** — `FEE-FR-060` + `FEE-INV-010` + `FEE-BR-028` already make the confirmed-payment snapshot immutable and a configuration change never retroactive, so a 3% transaction stays 3% when the rate becomes 2.5%; creating an identifier to restate that would have inflated traceability. **The offline prohibition needed none either** — `FEE-FR-061`, `FEE-XC-022` and `FEE-PO-006` already forbid every offline financial write. **`PR-1` needs no new authority** — v0.5 established that platform configuration is already inside `PR-1`'s scope, and `FEE-BR-028` already bars rewriting history. **One defect of my own is corrected, not hidden:** §0.2's `FEE-GAP-*` row still read **15 / total 231** after **v0.7 added `FEE-GAP-016`** — my v0.7 pass updated §37 and §39 and forgot §0.2, so the document disagreed with itself for a version, **in the flattering direction**. Now **17 / 235**, with a new checker cross-check so the two cannot drift again. **Counts, honestly:** 62 FR / 28 BR / 10 INV / 3 EVT / **23** XC / 8 PO / **84** AC / **17** GAP = **235**; obligation-bearing **134**; traceability **130/134 = 97.0%** — **flat**, and reported flat rather than rounded up; the **untraced set is unchanged at exactly the same four** (`FEE-FR-028`, `FEE-FR-042`, `FEE-BR-007`, `FEE-BR-019`) and **nothing untraced was closed**. **The blocker counts DO NOT MOVE — still 6 Stage-4 and 11 Freeze** — because `FEE-GAP-017` blocks `PRD-022` and the product feature, **not `BC-05`**; inflating them would have looked more rigorous and been false. **Stage 3 remains ⛔ NOT ALIGNED (5/6) and Stage 4 was NOT run. This PRD was NOT frozen. No ADR was authored or accepted — `ADR-0035` stays `PROPOSED`. No frozen document, BC Map, Dependency Matrix, Traceability Matrix or module manifest was modified; `PRD_REGISTRY.md`'s `PLANNED` row is unchanged; no edge was added (26); no Dart source was touched; no gate was weakened.** |
| **v0.7** | *(this draft)* | **PAYMENT EXECUTION OWNERSHIP DECIDED — recorded, not enacted; and one of this pass's own claims is RETRACTED.** Acting under conferred **Architecture Owner** authority (`PRD_OWNERSHIP_MODEL.md` §2.2: *"Boundaries, ranks, permitted edges, precedence … ADR approval"*), `ADR-0035` `D-2` is **decided as `O-3`: student→library payment execution is a capability of the Business Platform (`platform/business`, rank 6), not a new bounded context.** **The decision was tested before it was taken, not after.** The obvious supporting precedent was Accepted `ADR-0013` (*capability contexts are owned by their platform*) — measured, and **rejected as the authority**: its Decision (L94–128) only ever resolves ownership for `BC-19`/`BC-25`/`BC-29`, contexts that **already hold `BC-` identifiers**, and `grep -iE 'no bounded context|owns no aggregate|without a bounded context'` over it returns **0 matches**. It never contemplates a capability with **no** context, and that limit is now recorded in the ADR so a future reader cannot over-read it. **The real authority is `AR-1`** (`ARCHITECTURE_RULINGS.md` L23–37, BC Map **L86**/**L558**): a capability is not a context when it owns *"no aggregate, no invariant and no business state"* and *"delegates every domain operation."* **All four criteria were measured and all four pass** — no aggregate (`FeeLedger` is `BC-05`'s, BC Map **L374**), no invariant (`FEE-INV-005`, `FEE-BR-016`, frozen `MM-BR-005`), no business state (`MP-GBR-24`, L202), and full delegation (intent ← `BC-05`, vendor → `BC-31`, confirmation → `BC-05`). Precedent for the *outcome* is `PRD_REGISTRY.md` **L355**, where the same test produced *"no `BC-32` … the context count remains 31."* **`O-2` refused** on Rank 1 `MP-GBR-24`, now also **CI-enforced** by the rank-0 shared kernel's `banned_symbols` (`class Payment ` → *"FeePayment (BC-05) or SubscriptionCharge (BC-20)"*). **`O-1` refused** on the `AR-1` test. **The Rank 1 tension is dissolved by scope, and neither Rank 1 statement is amended, weakened or reinterpreted:** `MASTER_PRD.md` **L232** sits inside **§10 Technology Stack**, whose own preamble declares its subject to be *"capabilities with abstractions, with vendors recorded as candidate implementations behind ports"* and whose columns are *Capability / Architectural owner / Abstraction / Candidate implementation / Approved in EA v2.1?* — it is a **vendor-abstraction** table, while **L362** `MP-GBR-24` governs the **financial model**. Read to their own declared scopes they do not collide. **Webhook ingress is NOT resolved, and is not pretended to be.** No source at any rank names an inbound owner: BC Map `webhook` = **0**, `inbound` = **0**; `BC-31` **L140** is explicitly *"**outbound** third-party contracts"*; the EA **L165** assigns inbound adapters to *"API Platform"*, but that band **holds no `BC-` identifier**, and `DOCUMENTATION_BASELINE.md` **L139** marks the EA *"Descriptive — must follow the PRDs, never lead them"*, so it **cannot confer** the ownership it describes. Recorded as new **`FEE-GAP-016`** with only the *minimum shape* of the required amendment — a `provides_ports:` declaration on an **existing** `platform/integration` capability, **preferred over a new context** — and **no endpoint, payload, signature scheme, retry policy or configuration identifier was invented**. **A RETRACTION, in the pass's own disadvantage:** an earlier draft of v0.7 asserted the Stage-4 blocker count *"stays at 5"* because `FEE-GAP-016` replaced `FEE-GAP-002`. **False.** `FEE-GAP-002` has three parts and **(c), the offline financial-write path, was never resolved** (`E-24` is `BC-03` → `BC-30` only), so it **remains** blocking and `FEE-GAP-016` is **additive**. Counts re-derived by mechanically parsing §39's own columns: **16 gaps, 6 block Stage 4, 11 block Freeze**. The stale parenthetical *"all except `008`, `010`, `013`"* is also corrected — a **pre-existing** v0.3 defect describing a set of twelve as ten. **One `FEE-GAP-*` identifier added, so the registers move 231 → 232**; the **obligation-bearing count is unchanged at 133** and traceability is unchanged at **129/133 = 97.0%**, because a governance gap bears no obligation. **What this version does NOT do:** it does **not** accept `ADR-0035` — self-acceptance was expressly forbidden and the status remains **`PROPOSED`**, so `D-2` is **recorded, not in force**; it creates **no** bounded context, **no** `E-*` edge, **no** aggregate and **no** endpoint; it does **not** modify `tool/module_dependencies.yaml` (applying a `provides_ports:` entry is an **implementation act that requires acceptance first**, so the declaration is written into the ADR **as a proposal only**); it moves the **3% commission** no closer to `FeePayment`, which still carries **no** commission, gateway or tax field (`FEE-FR-060`); and it preserves every protected invariant — no offline financial write, idempotency, server-side confirmation, historical-rate immutability, tenant isolation and no cross-library disclosure. **Stage 3 therefore remains ⛔ NOT ALIGNED**, and **Stage 4 cannot start**: check 2 is still blocked, now solely by `FEE-GAP-016` plus the fact that the deciding ADR is not in force. **No frozen document, no ranked document, no Matrix, no BC Map and no Dart source was modified. No gate was weakened.** |
| **v0.6** | *(this draft)* | **GATEWAY ARCHITECTURE RE-MEASURED AT HEAD — `FEE-GAP-002` splits in two, and only half of it was ever a real blocker.** Previous passes asked *"does `BC-05` have a path to the gateway?"* as **one** question, searched for a numbered `E-` edge, found none, and reported **BLOCKED**. Re-measured, it is **two questions with two different answers**. **(a) The transport was already authorised, and this was measurable all along.** `LIBOORA_MODULE_DEPENDENCY_MATRIX.md` **§6** is declared by the document itself to be *"the **normative form** — what the lint rule checks"*, and **L196** lists `business.payment_intent` inside `library_management`'s `may_use_ports`; **`BC-05` is a `library_management` context** (BC Map L100), so the port was **already declared for the module that owns it**. **L167** forbids `LIBRARY MANAGEMENT → INTEGRATION` and *names* the lawful alternative — *"Integration is reached **only via BUSINESS (payments)**"* — and `X-03` **L352** states the remedy as an instruction: *"Call `business.payment_intent` port"*. The matrix cell `LIB → BUS` is **`◇` (port, permitted)** while `→ INT` is `✖`, **verified by mechanical column alignment — 19 data cells against 19 headers — rather than read by eye**, because a mis-count in fixed-width ASCII would be invisible. Accepted **`ADR-0012` L86** already tabulates `domain/library → platform/business` as *"Already a declared port? **Yes — `:entitlement`, `:payment_intent`**"*. **The decisive general finding: 14 of `library_management`'s 17 declared ports have no usable numbered edge** — including `identity.policy_decision`, the authorisation port every context must call, and `platform_services.files`/`search.indexer`, whose edges `E-22`/`E-21` exist but **do not list `BC-05` as a consumer**. Requiring an edge here would therefore invalidate thirteen other lawful dependencies. This is exactly what Accepted **`ADR-0033`** held: BC Map L292 *"**governs edges**… It does **not** state that every cross-context read must be an edge."* **So no edge was missing, and none was invented.** **(b) The counterparty is genuinely undeclared, and that half stays blocking.** The port has an **approved caller and no declared callee**: `platform/business` holds **exactly two** contexts, `BC-21` (limits and gates only) and `BC-20` — and **`MP-GBR-24` (Rank 1)** bars `BC-20` from student money, the very conflation Accepted `ADR-0015` exists to prevent. `grep -rn "PaymentIntent" docs/` returns **0 occurrences repository-wide**. **Three options are presented in `ADR-0035` §6 and none is recommended**, because `MP-GBR-24` is a Rank 1 rule whose interpretation is not this document's to settle. **A Rank 1 internal tension is raised, not chosen:** `MASTER_PRD.md` **L232** routes *"Payments"* via *"`BC-20` via `BC-31`"* while **L362** bars `BC-20` from student money — per `DOCUMENTATION_BASELINE.md` §4, *"a conflict is a defect — do not choose, raise it."* **`ADR-0035` was created and left `PROPOSED`.** It is **not self-accepted**: no conferral of Architecture Owner authority was given, and its `D-2` is a question only that authority can answer. It **amends no ranked document**, adds **no edge**, widens **no allow-list**, creates **no context**, and defines **no aggregate, contract, webhook schema, endpoint or table**. It recommends correcting `D-14`'s mis-attribution of `E-25` — a citation defect of the class `ADR-0015` fixed, in a document whose own header calls it *"**Derived. Non-normative.**"* — but **does not execute it**, because the correct replacement text depends on the unresolved `D-2`. **Stage 3 is re-run and remains ⛔ NOT ALIGNED at 5 of 6.** Check 2 is still blocked, now by a **narrower and better-specified** question than at v0.5. **`FEE-GAP-002` is PARTLY RESOLVED, not RESOLVED** — closing it outright would make this document look complete while leaving payment execution unspecifiable. **No new `FEE-*` identifier was created at v0.6**, so the registers stand unchanged at **231 identifiers**, 133 obligation-bearing, **129/133 = 97.0%**. **No frozen document was modified. No ranked document was modified. No ADR was accepted. No gate was weakened. No Dart source was touched.** |
| **v0.5** | *(this draft)* | **GOVERNANCE RE-AUDIT AT HEAD — one of this document's own v0.4 findings is RETRACTED, because it was written without measuring the authoritative source.** **The retraction is the most important entry here.** v0.4's §42.5 was headed *"`Platform Owner` is not a registered role"* and `FEE-GAP-015` asserted that the commission and renewal-protection authority questions *"cannot close until the role exists"*. **That framing was wrong in its emphasis.** It measured `grep -rniE 'Platform Owner|Super Admin'` → 0 hits and stopped there, without reading the `PR-1` definition it was implicitly ruling on. Re-measured at HEAD: `PRD-001` Authentication v2 (**PRODUCTION-READY — AUTHORITATIVE**, Rank 3), `prd-v2/02` **L123-127**, defines **`PR-1` Platform Administrator** with Purpose *"…**manage platform configuration**…"* and Scope *"platform-level objects only — tenants as entities, **platform configuration**, platform role assignments"*. **Changing a platform-level configuration value is already inside `PR-1`'s scope.** The correct finding is therefore the opposite of a closed-register conflict: **no new role is required, none is proposed, *"Two, closed"* stands untouched, and any "Platform Owner / Founder" concept should be modelled as governance authority over `PR-1` assignment — which `AUTH-2.6` already vests in another Platform Administrator — not as a new authentication role.** The four prohibitions the product intent asks for (*Owner, Manager, Reception, Student MUST NOT change it*) **need no new rule at all**: `AUTH-7.14` scopes every library role to exactly one library, so a tenant role cannot reach a platform-level object, and `AUTH-7.13`/`AUTH-7.61` bar the converse. **What genuinely remains is narrower than v0.4 claimed, and it is two things, not a role:** (b) the closed permission catalogue (`AUTH-7.22`, `AUTH-7.67`, `AP-3`) declares itself closed but **enumerates no permission identifier anywhere in `docs/`**, so the named grant `AUTH-7.32` requires does not exist; and (c) the authoritative configuration registry — **`CONFIGURATION_GUIDE.md` v1.1**, measured this pass and **never examined in any previous pass** — governs exactly **35** parameters (`CFG-1`…`CFG-12`, `LCFG-1`…`LCFG-13`, `ICFG-1`…`ICFG-10`) and holds **no** commission rate and **no** protection window, with §5 requiring *"a PRD amendment"* to add one. `AUTH-7.64` is recorded as a standing constraint on any eventual grant. **`FEE-GAP-015` is now PARTLY RESOLVED, resolved as far as the existing role/permission model lawfully allows and no further.** **Second resolution — the due-date ambiguity (`FEE-GAP-006`), closed by measurement.** Three dates were being discussed as one: (i) the **membership term end date**, `endDate`, owned by FROZEN `BC-02` — `MM-FR-057` `startDate + (durationDays − 1)`, made clock-independent by `MM-FR-058`, untouchable by this module (`FEE-XC-020`); (ii) the **fee-obligation due date**, `BC-05`'s own field (`FEE-FR-013`, `FEE-FR-048`) — measured: `grep -ni 'due date|dueDate'` over FROZEN `PRD-005` returns **0 occurrences**, so no frozen document supplies it and it is unambiguously this module's to specify; and (iii) the **renewal-protection window**, neither of the above. **The offset itself is still not invented** — no default, minimum, maximum or range is created, `FEE-GAP-006` still **BLOCKS Stage 4 and Freeze**, and the resolution records explicitly that a fee-collection due date is **not** an entitlement extension, so that settling it cannot accidentally invent the V1 grace period `MM-FR-111` forbids and `MM-GAP-001`/`Q-01` leaves open. **The renewal-protection window MUST NOT be called a generic "grace period"** — the architecture treats them differently. **Third — refund (`FEE-GAP-001`): a precedence determination is recorded, and the higher rank is NOT silently downgraded.** `DOCUMENTATION_BASELINE.md` §4 places the BC Map at **Rank 4** and the Enterprise Architecture at **Rank 6** *"descriptive only … never the reverse"*, and **Rank 1** `MP-CON-08` says a disagreement is *"a defect to be raised, not a choice to be made"*. BC Map L100/L374/L422 put refund in `BC-05` at **V1**, and **FROZEN Rank 3** `PRD-005` L942 routes a live flow into *"a refund decision by `BC-05`"*. Recording refund as V2 would subordinate Ranks 1 and 4 to Rank 6 and strand a frozen requirement — **this PRD does not make that downgrade**. The *scope* of V1 refund still requires the Product Owner, so **no requirement, state table or event was written**. **Nothing was added to make the document look complete:** no new `FEE-*` identifier was created at v0.5, so the registers stand unchanged at **231 identifiers**, 133 obligation-bearing, **129/133 = 97.0%**, with the untraced set unchanged at exactly four. **No frozen document was modified; `CONFIGURATION_GUIDE.md` and `PRD-001` were read only. No ADR was authored or accepted. No role, permission identifier, parameter identifier, configuration range, edge, endpoint, schema or gateway contract was invented. No gate was weakened. `PRD_REGISTRY.md`'s `PLANNED` row is unchanged.** |
| **v0.4** | *(this draft)* | **MASTER PRODUCT + APP ARCHITECTURE DECISION APPLIED — the part `BC-05` owns is specified; the platform-commission model is REFUSED and routed, because it is `BC-20`'s money.** **Measured first, as always:** `commission` across `docs/` = **13 occurrences, 0 financial** (every one the English verb — *"commissioned an analysis"*, `SeatDecommissioned`); `platform fee`, `revenue share`, `payout`, `net settlement`, `take rate` = **0 each**; an approved `3%` default = **0**; `settlement` = 4 hits, all this document's own *"partial settlement"* (`FEE-XC-004`, excluded). **Decisive authority:** `MP-GBR-24` (Master PRD **L362**, **Rank 1**) — *"Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by a **library to LIBOORA** (`BC-20`). They **must never share a model, a table or a metric**"* — reinforced by BC Map L100/L129, `PRD_REGISTRY.md` L341 (merging *"would collapse `FeePayment` into `SubscriptionCharge`"*) and `MP-SM-06`. A platform commission is money *library → LIBOORA*; therefore **seven of the twelve requested elements** (the 3% rate, its configuration authority, the settlement balance, the net-off, the settlement dashboard, the gateway-charge line, the tax line) are **routed to `BC-20`/`PRD-022`/V3 by `FEE-GAP-014`, not specified here**. Also measured: **no `BC-05` ↔ `BC-20` edge exists** (`BC-05` has exactly `E-06`, `E-07`, `E-09`, `E-10`; BC Map §7 L292 — *"if an edge is not in this table, it does not exist"*) and **`PRD-022` does not exist** (`PGA-05`: one of *"nine module PRDs named in v1.0 and never written"*). **Six obligations added — only what this module lawfully owns:** `FEE-FR-060` + `FEE-INV-010` + `FEE-BR-028` (§15.1 — immutable confirmed-payment snapshot; a config change is **never retroactive**), `FEE-FR-061` + `FEE-XC-022` (§28.1 — cash confirmed **only** by server-side recording; **no offline financial write**, consistent with `E-24` granting offline sync to `BC-03` **only**), and `FEE-FR-062` (§16.1 — unbundled student-facing breakdown of the components `BC-05` owns). **`FEE-FR-060` deliberately carries no commission, gateway or tax field**: adding one would perform the `MP-GBR-24` merger **in the schema**, which is where it counts. **Four requested behaviours were NOT given new identifiers because they already exist** — client-side success is never financial truth (`FEE-BR-014`, `FEE-AC-032`), idempotent cash submission (`FEE-FR-029`/`030`, `FEE-INV-005`), offline blocked (`FEE-PO-006`, §28.1), collecting actor recorded (`FEE-FR-022`/`023`). Creating IDs to restate them would have inflated traceability, which the decision's own §18 forbids. **Second conflict found, with an authoritative document:** the decision makes **Platform Owner / Super Admin** the highest authority, but `PRD-001` Authentication v2 (**PRODUCTION-READY — AUTHORITATIVE**), `prd-v2/07` **L79**, declares platform roles *"**Two, closed:** `PR-1` Platform Administrator and `PR-2` Platform Support"* and `grep -rniE 'Platform Owner|Super Admin' docs/30-product/authentication/` returns **0 hits** — recorded as **`FEE-GAP-015`**, which recommends the cheaper resolution (an enumerated permission set on a `PR-1` account, needing no register change) alongside the ADR route. **Renewal protection at V1:** §42.6 records that the decision resolves the configuration *level* as platform-level, but frozen `PRD-002` §16.1 `LCFG-1`…`LCFG-10` is **library**-scoped with no percentage or window row, so the value still has no home — `FEE-GAP-013`(a2) stands, now also routed to the `BC-25` owner. **No `FEE-CFG-*` register was opened and no range, maximum or default was invented**, exactly as the decision's §10 instructs. The term-deduction prohibition (five frozen `MM-FR-*` + `MM-XC-012` **V2**), the seat-ownership boundary (`BC-04`) and the cross-library prohibition (`SID-4.19`'s **capability** bar) are all **unchanged and now explicitly confirmed by the decision itself**. **Three PRE-EXISTING defects fixed** while verifying anchors, none of them introduced here: (i) `NG-8` pointed at *"§42 note in §34"* — **§42 did not exist** at the time (the file ended at §41); (ii) §35's preamble still claimed *"70 criteria … `FEE-AC-070`"* though the register held **78**; (iii) §26 still described `FEE-XC-017` as *"reserved — not allocated"* though v0.2 allocated it. **The new section is numbered §42, not §34**, because `## 34. Edge Cases` already existed — verified by reading the heading list before writing, not after. Registers now 62 FR / 28 BR / 10 INV / 3 EVT / 22 XC / 8 PO / 83 AC / 15 GAP = **231 identifiers**, 133 obligation-bearing, traceability **129/133 = 97.0%** — the **untraced set is unchanged at exactly four**; the ratio rose only because six fully-traced obligations were added. **No frozen document was modified. No ADR was authored or accepted. No edge, endpoint, schema, gateway contract, tax rate, gateway percentage, commission rate or configuration range was invented. `PRD_REGISTRY.md`'s `PLANNED` row for `PRD-008` is unchanged.** |
| **v0.3** | *(this draft)* | **`FEE-GAP-013` GOVERNANCE RESOLUTION — two questions closed by measurement, six left blocked with named authorities, and one new frozen-document conflict discovered. No `FEE-*` requirement was added, altered or removed; no event, edge, API, schema or configuration range was created.** §11.3 was rewritten (§11.3.1–§11.3.10) and `FEE-GAP-013` restructured into sub-questions (a1), (a2), (b)–(g). **Resolved:** *(a1)* the policy owner is **`BC-06` Library Policy** — BC Map L101 makes it *"the rule **source**"* and `PRD_REGISTRY.md` **L422** maps `BC-06` → **`PRD-002`** (`FROZEN` v1.1, uncontested); the ownership is a **three-way split already in the architecture** — `BC-06` owns the rule, `BC-02` the term effect (BC Map L97), `BC-04` the seat effect (`MM-FR-112`, `SEAT-FR-155`) — and **`BC-05` owns none of it**. *(e)* the *"full configured duration"* guarantee is **`BC-02`'s**, already given by frozen `MM-FR-086` (target plan's **current** `durationDays`) and `MM-FR-081` (renewal from `Expired` *"without limit of elapsed time"*), not `BC-05`'s (`FEE-XC-020`). **Blocked, with the blocker quoted:** *(a2)* the 3-day window is unsourced (0 occurrences repo-wide), **conflicts with the only recorded recommendation of 24h** (Master PRD L673, BC Map L540 — itself *"Open"*, and `PRD-005` §7.4 holds that a recommendation inside an open question *"is not a decision"*), and is forbidden from extending entitlement by frozen `MM-FR-111`; **configurability has no register** — `BC-06`'s configurables are the closed table `PRD-002` §16.1 `LCFG-1`…`LCFG-10` in a **`FROZEN`** document with no protection-window row, and `E-19` supplies typed accessors, not authority that a value exists, so **no `FEE-CFG-*` register was opened** (requirement 11). *(f) — the new requirement, and the sharpest finding:* the instruction to **deduct the 3 protected days from the new membership duration** *"according to the approved membership policy"* is **contradicted by the approved policy**. Five frozen `PRD-005` requirements forbid it — `MM-FR-086`, `MM-FR-057` (a closed formula), **`MM-FR-058`** (a **pure function** that *"**MUST NOT** depend on the current clock"*), `MM-FR-057a` (*"**The single permitted re-derivation, and the only one**"*) — and it **is** proration, classified `MM-XC-012` **V2** with ownership question `Q-06` / `MM-GAP-002` still **OPEN**. Under `MP-CON-08` this is *"a **defect to be raised**, not a choice to be made"*, so it is raised, not specified. *(c)/(d)* the cross-library indicator has **no lawful V1 form**: `ID-2` is **CI-enforced** (`banned_symbols`, `tool/module_dependencies.yaml` L216–218), `ID-3` forbids resolving which library a person attends, and — decisively — **`SID-4.19`** forbids `BC-10` from being *"**capable** of answering"* that question, reinforced by `SID-INV-8`, `SID-INT-12`, `SID-4.22`, `SID-4.23` and `SID-5.8` (**`membership state`** *"**SHALL NEVER** exist"* in `BC-10`). **This defeats even the request's own preferred design** — a minimal `PersonId`-keyed projection with the library name omitted — because a non-empty result still discloses enrollment elsewhere, and the prohibition is on the **capability**, not the field. **Recommendation: the cross-library indicator is V2, not V1 and not removed**, matching the EA tier for `Multiple Library Memberships`; the only lawful door for a future design is `ID-3`'s *"unless the person explicitly published it"* — explicit consent — which needs a consent owner (`BC-18`), a lawful basis, a revocation path and a registered edge, **none of which exist and none of which this PRD may create**. *(g)* the *"student remains and requests protection"* path is unsourced; the **voluntary-departure** half of requirement 5 is already the frozen model (`MM-FR-079`, `MM-XC-011` **V2**). **Four distinct ADRs by four distinct owners** would be required to build the feature; **none was authored** (requirement 10). Registers **unchanged** at 59 FR / 27 BR / 9 INV / 3 EVT / 21 XC / 8 PO / 78 AC / 13 GAP = **218 identifiers**, 127 obligation-bearing, traceability **123/127 = 96.9%** — because the resolution added governance findings, not requirements. **No frozen document was modified:** `PRD-002`, `PRD-004`, `PRD-005`, `PRD-007` remain `FROZEN` and `PRD-003` untouched; `PRD_REGISTRY.md`'s `PLANNED` row for `PRD-008` is unchanged. **No fraud system, risk score, blacklist, watchlist or cross-library punishment was created**, and `FEE-XC-019` / `FEE-XC-021` remain **unconditional**. |
| **v0.2** | *(this draft)* | **Cross-library renewal-protection history added — as prohibitions plus a blocker, not as a feature.** Measured first: `grep -rniE "renewal.protect|protection period|protection window"` over `docs/` returns **0 occurrences**, so the concept is **unsourced**. The nearest concept, *grace period*, is owned by **`BC-06`** (BC Map L101) with its decision `Q-01`/`MM-GAP-001` still **OPEN**, and frozen `PRD-005` `MM-FR-111` forbids a V1 grace period extending entitlement. EA L1368 `Grace Periods (V2)` is a **different** concept (Entitlement Service, `BC-21`). Cross-library read is barred by **`ID-2`** (`StudentRecordId` never leaves its tenant) and **`ID-3`** (global contexts must not resolve which library a person attends), with `Multiple Library Memberships` at **V2** and `Cross Library Membership` **Future**. Therefore: specified only what is lawfully `BC-05`'s — `FEE-FR-059` (new obligation priced solely from its own `E-07` `priceSnapshot`), `FEE-BR-026` (no penalty persists beyond its membership), `FEE-BR-027` (renewal inside a window carries no adverse marker), and `FEE-XC-018`…`021` (no ownership of protection history, no cross-tenant financial disclosure, no duration authority, **no risk score / fraud label / blacklist / cross-library punishment**). Added `FEE-AC-071`…`078` for scenarios A–H, with **`FEE-AC-074` explicitly recorded as not verifiable in `BC-05`** rather than given a criterion this module could not execute. Added **`FEE-GAP-013`** routing the blocked parts to the Architecture Owner, Product Owner, Security and the `BC-02` owner. Also allocated the four v0.1 reserved placeholders (`FEE-FR-059`, `FEE-BR-025`/`026`, `FEE-XC-017`). Registers now 59 FR / 27 BR / 9 INV / 3 EVT / 21 XC / 8 PO / 78 AC / 13 GAP = **218 identifiers**, 127 obligation-bearing, traceability **123/127 = 96.9%**. **No frozen document was modified**; `PRD-005` and `PRD-004` remain FROZEN and any protection-history field there requires an ADR by their owners. **No fraud system, risk score, blacklist or cross-library punishment was created.** |
| **v0.1** | *(this draft)* | **First draft. Stage 2 only.** Created from Rank 1–6 sources: Master PRD v1.7, `ADR-0015` (**Accepted**), BC Map v1.7, Module Dependency Matrix v1.3, frozen `PRD-004` v1.2 / `PRD-005` v1.4 / Library PRD v1.1, `PRD_REGISTRY.md`, `PRD_OWNERSHIP_MODEL.md`, `PRD_LIFECYCLE.md`, `PRD_DEPENDENCY_GRAPH.md`, `PRODUCT_IMPLEMENTATION_ROADMAP.md`, `PRD_GAP_ANALYSIS.md`, Enterprise Architecture v2.1 (Rank 6, descriptive). Registers `FEE-*` opened after a measured collision check (0 pre-existing occurrences): 58 FR, 24 BR, 9 INV, 3 EVT, 16 XC, 8 PO, 70 AC, 12 GAP = **200 identifiers**, 118 obligation-bearing. During the mandatory adversarial self-review two defects in this draft were found and corrected before issue: (a) §36.1 claimed *"113 = 95.8%"* traceability while the §35 criteria carried no requirement back-links — replaced with a measured per-identifier matrix showing **114/118 = 96.6%**; (b) `FEE-EVT-001`/`002`/`003` were declared in §0.2 but never defined normatively — now defined in §26. Six criteria (`FEE-AC-065`…`070`) were added to close coverage that the earlier percentage had merely asserted. **No `FEE-CFG-*` register opened** — no source approves any range. **No requirement, event, edge, endpoint, table, schema, vendor contract or configuration range was invented.** **12 governance gaps recorded; 5 block Stage 4, 10 block Freeze** (measured from the ledger rows; the first draft stated these inconsistently). `PRD_REGISTRY.md`'s `PLANNED` row for `PRD-008` is **unchanged** by this document. No other PRD, ADR, ranked document or source file was modified. |

---

---

## 42. Platform Commission & Settlement — ⛔ NOT `BC-05`'s TO OWN

> **This section records a V1 product decision and refuses to implement the part of it that
> `BC-05` does not own.** The Master Product + App Architecture Decision sets a **3% default
> platform commission**, configurable by **Platform Owner / Platform Admin**, with an
> **immutable per-transaction rate snapshot**, plus **server-confirmed-only cash** and a
> **transparent unbundled breakdown**. Its §5 also states the boundary itself:
> *"Platform commission, platform settlement and LIBOORA platform revenue belong to the platform
> billing/financial context, not the student fee ledger."* This section holds that line.

### 42.1 The Rank 1 rule that decides ownership

`MP-GBR-24` (Master PRD L362, **Rank 1**) is exact:

> *"Money owed by a **student to the library** (`BC-05`) is a different concept from money owed by
> a **library to LIBOORA** (`BC-20`). They **must never share a model, a table or a metric**."*

Reinforced at four further sites, none of them this document's to amend:

| Source | Rank | What it says |
|---|---|---|
| BC Map **L100** | 4 | `BC-05` Fee & Collection owns *"money owed by a **student to the library**"* |
| BC Map **L129** | 4 | `BC-20` Subscription & Billing owns *"money owed by a **library to LIBOORA**: plans, subscriptions, invoices, **gateway**, dunning, revenue recognition"* |
| `PRD_REGISTRY.md` **L341** | 2 | *"`BC-05` is money **student → library**; `BC-20` is money **library → LIBOORA**. Merging them would collapse `FeePayment` into `SubscriptionCharge` and put a library's revenue in the same aggregate as LIBOORA's"* |
| `PRD_REGISTRY.md` **L427** | 2 | `BC-20` → **`PRD-022`**, uncontested |
| `MP-SM-06` (L658) | 1 | A revenue metric *"**must state whether it means `BC-05` student fees or `BC-20` SaaS revenue**"* |

A platform commission is money **library → LIBOORA**. Therefore **every commission, settlement and
platform-revenue obligation in the decision belongs to `BC-20` / `PRD-022`, not to this PRD.**

### 42.2 What was measured before anything was written

| Search | Result |
|---|---|
| `commission` across `docs/` | **13 hits, 0 financial.** Every one is the English verb — *"commissioned an analysis"*, *"whoever the owner commissions"*, `SeatDecommissioned`. **No commission rule exists anywhere in the repository** |
| `platform fee` · `revenue share` · `payout` · `net settlement` · `take rate` | **0 occurrences each** |
| `settlement` | **4 hits, all this document's own** *"partial settlement"* — `FEE-XC-004` **excludes** it from V1 |
| `3%` as an approved default | **0** |
| A `BC-05` ↔ `BC-20` edge in BC Map §7 | **NONE.** `BC-05` has exactly four edges — `E-06`, `E-07`, `E-09`, `E-10` — and none touches `BC-20` |
| Gateway ownership | **`BC-20`**, reaching vendors through **`E-25` → `BC-31`**. `BC-05` has no gateway path at all (`FEE-GAP-002`) |
| Commission configuration range | **Not approved.** `LCFG-1`…`LCFG-10` (frozen `PRD-002` §16.1) contains no percentage row; §0.2 declares **no `FEE-CFG-*` register** |
| Tax / GST rate | **V3.** EA L828–829, L1427–1429; `NG-2` already excludes it |

BC Map §7 L292 governs the missing edge: *"**If an edge is not in this table, it does not exist** and
adding it requires an ADR."*

### 42.3 Disposition — three destinations, none of them invention

| # | Decision element | Destination | Why |
|---|---|---|---|
| 1 | 3% default commission rate | ⛔ **`BC-20` / `PRD-022`** — `FEE-GAP-014` | `MP-GBR-24`; `PRD-022` is `PLANNED` and **does not exist** (verified: no file) |
| 2 | Platform Owner / Platform Admin configures it | ⛔ **`BC-20` + `BC-18` + `BC-25`** — `FEE-GAP-014`, `FEE-GAP-015` | Configuration authority is not `BC-05`'s; and **`Platform Owner` is not a registered role** (§42.5) |
| 3 | Commission recorded against a library settlement balance | ⛔ **`BC-20`** — `FEE-GAP-014` | Would be a **new financial aggregate** in the wrong context |
| 4 | Net-off of outstanding commission against future collections | ⛔ **`BC-20`** — `FEE-GAP-014` | Requires a settlement mechanism **no source approves**; would also need the absent `BC-05`↔`BC-20` edge |
| 5 | Owner/Manager settlement dashboard (gross · commission · gateway · net · outstanding) | ⛔ **`BC-20`**, surfaced via `BC-26` — `FEE-GAP-014` | Mixed-context read model. `MP-GBR-36`: *"No dashboard may define its own metric formula"* |
| 6 | Gateway/provider charges shown separately | ⛔ **`BC-20` via `E-25`** — `FEE-GAP-014` | Gateway is `BC-20`'s by BC Map L129 |
| 7 | Tax / GST line | ⛔ **V3** — already excluded by `NG-2` | No rate invented |
| 8 | **Immutable rate snapshot on a confirmed transaction** | ✅ **specified here** — `FEE-FR-060`, `FEE-INV-010`, `FEE-BR-028` | The *immutability principle* over a financial record `BC-05` already owns |
| 9 | **No offline financial write; cash confirmed server-side only** | ✅ **specified here** — `FEE-FR-061`, `FEE-XC-022` | Strengthens `FEE-BR-010`/`FEE-PO-006`, which exist |
| 10 | **Client-side success is never financial truth** | ✅ **already specified** — `FEE-BR-014`, `FEE-FR-026`/`027`, `FEE-AC-032` | No new identifier needed |
| 11 | **Idempotent cash submission** | ✅ **already specified** — `FEE-FR-029`/`030`, `FEE-INV-005` | No new identifier needed |
| 12 | **Unbundled student-facing breakdown** | ✅ **partly here** — `FEE-FR-062`; commission line ⛔ `FEE-GAP-014` | `BC-05` may render its **own** components; it may not render `BC-20`'s |

Items 10 and 11 are recorded as **already satisfied**. No identifier was created to restate them —
`FEE-GAP-012` warns against exactly that, and the decision's §12 requires *"do not create IDs merely
to make traceability appear complete"*.

### 42.4 What `BC-05` does specify — six new obligations, and only six

**The six obligations are defined once, at their register's own site — not restated here.** Restating a
normative requirement would create a second definition of the same identifier, which is precisely the
collision discipline this PRD enforces elsewhere. This is the index:

| ID | Register | Defined at | Verified by |
|---|---|---|---|
| `FEE-FR-060` | Functional | **§15.1** — immutable confirmed-payment snapshot | `FEE-AC-079` |
| `FEE-INV-010` | Invariant | **§15.1** — snapshot fields never change | `FEE-AC-079` |
| `FEE-BR-028` | Business rule | **§15.1** — a config change is never retroactive | `FEE-AC-080` |
| `FEE-FR-061` | Functional | **§28.1** — cash confirmed only server-side | `FEE-AC-081` |
| `FEE-XC-022` | Exclusion | **§28.1** — no offline financial write of any kind | `FEE-AC-081`, `FEE-AC-082` |
| `FEE-FR-062` | Functional | **§16.1** — unbundled student-facing breakdown | `FEE-AC-083` |

> **`FEE-FR-060` deliberately does not name a commission rate, a gateway charge or a tax line.**
> Those three components are `BC-20`'s. A snapshot field for a value this context may not compute
> would be the *"shared model"* `MP-GBR-24` forbids — the merger happens in the schema, not in the UI.
> `FEE-XC-022` is stated as an exclusion rather than a configurable so that no offline mode can be
> switched on later without amending this register. It is consistent with `E-24`, which grants the
> offline-sync edge to **`BC-03` Attendance only** (BC Map L333) — the decision's §7 *"NO OFFLINE
> FINANCIAL WRITE in V1"* and its instruction not to mix offline attendance with offline finance are
> therefore both honoured by architecture, not merely by intent.

### 42.5 Platform-configuration authority — `PR-1` is the registered role, and it already covers this

> **Correction to v0.4.** The v0.4 text of this subsection was headed *"`Platform Owner` is not a registered
> role"* and framed the whole question as a conflict with a closed register. **That framing was wrong in its
> emphasis and is withdrawn.** The operative question was never *"does a Platform Owner exist?"* but *"which
> **registered** role may change a platform configuration value?"* — and that question has an answer in an
> authoritative document, which v0.4 did not measure. The corrected finding is below; the changelog records the
> retraction rather than hiding it.

Measured against `PRD-001` Authentication v2 (**PRODUCTION-READY — AUTHORITATIVE**, Rank 3), `prd-v2/02`
**L123-127**, the `PR-1` Platform Administrator definition:

> | **Purpose** | Operate and secure the platform: provision and suspend tenants, **manage platform
> configuration**, administer platform-level security |
> | **Scope** | Platform-wide, for **platform-level objects only** — tenants as entities, **platform
> configuration**, platform role assignments |

**Managing platform configuration is inside `PR-1`'s defined purpose and its defined scope.** No new role is
needed, none is proposed, and *"Two, closed"* (`prd-v2/07` L79) stands untouched.

| Product-intent actor | Registered as | May change a platform configuration value? | Authority |
|---|---|---|---|
| Platform Administrator | ✅ **`PR-1`** | **Yes — already in scope** | `prd-v2/02` L123-127 |
| Platform Support | ✅ **`PR-2`** | No — read-only metadata, no standing tenant access | `prd-v2/02` L131-135 |
| Library Owner | ✅ `TR-1` | **No** | `AUTH-7.14` — scoped to exactly one library |
| Library Manager | ✅ `TR-2` | **No** | `AUTH-7.14`; *"cannot alter library-level commercial configuration"* |
| Reception | ✅ `TR-3` | **No** | `AUTH-7.14`; financial visibility **None** (`prd-v2/02` §2.4.1) |
| Student | ✅ `TR-4` | **No** | `AUTH-7.14`; own records only |
| Parent | ✅ `TR-5` | **No** | `AUTH-7.14`; read-only, linked students only |

**The four prohibitions the product intent asks for require no new rule.** `AUTH-7.13` and `AUTH-7.61` bar
platform authority from tenant data and, symmetrically, `AUTH-7.14` scopes every library role to one library —
a tenant role therefore cannot reach a platform-level object at all. *"Owner / Manager / Reception / Student
MUST NOT change it"* is already a consequence of the frozen model.

**What is genuinely missing is narrower, and it is two things, not a role.**

| # | Missing | Source that makes it missing | Owner |
|---|---|---|---|
| **(b)** | A **named permission** in the closed catalogue | `AUTH-7.22` *"a permission not declared in it cannot be granted, requested or evaluated"*; `AP-3` deny-by-default. Chapter 7 gives categories and scopes but **enumerates no permission identifier** | `BC-18` / `PRD-001` owner |
| **(c)** | A **parameter row** for the rate and the window | `CONFIGURATION_GUIDE.md` v1.1 governs 35 parameters (`CFG-1`…`CFG-12`, `LCFG-1`…`LCFG-13`, `ICFG-1`…`ICFG-10`); **none is a commission rate or a protection window**, and §5 requires *"a PRD amendment"* to add one | `BC-25` / `PRD-023` owner + the declaring PRD's owner |

One further rule constrains any eventual grant, and is recorded so it is not discovered late:

* `AUTH-7.64` — *"No role **MAY** grant the ability to modify the policy that constrains it."* The grant must
  be enumerated as **configuration** authority, never as authority over the permission model itself.

**Consequence for this PRD: none, and that is the point.** Both values sit outside `BC-05`. `FEE-XC-014`
forbids this module from creating a role or inferring permission from dashboard visibility, and `FEE-FR-053`
requires every financial write to be authorised against the acting role **and** tenant scope — so the product
intent's *"never trust the client for role, permissions, commission configuration; UI hiding alone is NOT
security"* is satisfied for this module by an existing exclusion rather than a new requirement. `FEE-GAP-015`
carries (b) and (c) to their owners with the role question **closed**.

`BC-05`'s own position is already correct and is re-affirmed, not changed: `FEE-XC-014` forbids this module from creating a role or
inferring permission from dashboard visibility, and `FEE-FR-053` requires every financial write to be
authorised against the acting role **and** tenant scope, so the decision's §17 *"Never trust the client for role,
permissions, commission configuration … UI hiding alone is NOT security"* is satisfied for this
module by an existing exclusion rather than a new requirement.

### 42.6 Renewal protection at V1 — what changes, and what still cannot

The decision makes renewal protection **V1** and sets the window at **3 days, Platform-level**,
changing two things relative to v0.3's analysis and leaving the rest exactly as measured:

| Element | v0.3 finding | Effect of this decision |
|---|---|---|
| Configuration **level** | Unresolved between library and platform | **Resolved as a product decision: platform-level.** But `PRD-002` §16.1 `LCFG-*` is a *library* register, so the value has **no home**; the decision's §10 anticipates this and forbids silently adding a row → **`FEE-GAP-013`(a2)** stands, now routed additionally to the `BC-25` configuration owner |
| **Seat** protection during the window | `BC-04`'s (`SEAT-FR-155`) | **Unchanged.** Decision §14 confirms it: *"`BC-05` must not create its own seat allocation system"* — held by `FEE-XC-020` and by `BC-05` having no seat edge |
| **Term deduction** for protection days used | ⛔ Forbidden by five frozen `MM-FR-*`; **is** proration (`MM-XC-012`, V2) | **Unchanged and now explicitly accepted by the decision** — §11: *"Do NOT silently implement this as membership-term subtraction if existing frozen `BC-02` rules classify such behaviour as proration"* → `FEE-GAP-013`(f) stands, ADR required |
| **Cross-library** indicator | ⛔ `SID-4.19` capability bar; recommended V2 | **Unchanged and confirmed by the decision** — §13: *"If the architecture does not authorize a cross-library indicator: do NOT build it, record it as a governance/V2 dependency"* |
| **No punishment / no scoring** | `FEE-XC-021`, `FEE-BR-027` | **Unchanged.** Decision §9 and §13 restate the same prohibition in the same terms |

**Net effect on this PRD: none of the five moves into `BC-05`.** The window's *value* is `BC-06`/`BC-25`
configuration, its *seat* effect is `BC-04`'s, its *term* effect is `BC-02`'s, and its *history* is
`BC-02`'s (`FEE-XC-018`). What `BC-05` owes — that non-renewal creates no financial penalty and no
retroactive charge — is already carried by `FEE-FR-059`, `FEE-BR-026` and `FEE-AC-078`.

### 42.7 One app, six UIs — no effect on this register, recorded so the absence is deliberate

The decision's §1, §2, §15 and §16 fix **one Flutter application** with role-scoped UI and
extraction-ready feature modules. This is a **client-architecture** decision. It creates no
`BC-05` obligation, and this PRD adds none: `PRD-008` specifies financial *facts*, and
`FEE-XC-014` already forbids this module from creating a role or inferring permission from visibility. The single
consequence worth recording is a **prohibition already in force** — `FEE-XC-016` forbids any
cross-tenant financial read, write, aggregate or export, so a Platform Admin UI compiled into the
same binary as the Reception UI still cannot reach another tenant's financial records. Bundle-size
and deferred-loading targets belong to the implementation task register, not to a requirements PRD.

---

*End of `PRD-008_REVENUE-AND-FINANCE.md` **v1.0 — DRAFT**. Not frozen. Not approved. Not architecture-reviewed.*
