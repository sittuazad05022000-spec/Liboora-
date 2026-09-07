# `PRD-019` Integration v0.3 — Stage 3 Architecture Alignment Record

| Field | Value |
|---|---|
| **Stage** | **Stage 3 — Architecture Review** ([`PRD_LIFECYCLE.md`](../../00-governance/prd-ecosystem/PRD_LIFECYCLE.md) Stage 3) |
| **Subject** | [`PRD-019_INTEGRATION.md`](PRD-019_INTEGRATION.md) — `PRD-019`, **`BC-31` Integration**, **v0.3 `DRAFT`** |
| **Gate addressed by** | This document — *"a written alignment record naming every conflict and its disposition"* |
| **Worked example followed** | [`PRD-008_ARCHITECTURE_ALIGNMENT.md`](../revenue-finance/PRD-008_ARCHITECTURE_ALIGNMENT.md) — header shape, the `ADR-0034` verdict-retention pattern, and its refusal to pass a check on a decision nobody made |
| **Reviewed at** | **First pass.** Measured after `PRD-019` v0.3 authored `ITG-AC-001`…`ITG-AC-054` (§4.10), closing `Q-B31-AC` |
| **Companion ADR** | [`ADR-0048`](../../00-governance/adr/ADR-0048-prd-019-acceptance-criteria-and-stage-3-4-reviews.md) |
| **Mandate** | **Stage 3 measurement only.** No requirement added or changed by this record, no ranked document touched, no registry or baseline update, **no freeze** |
| **Verdict** | ⚠ **6 of 6 checks MEASURED as ALIGNED — and the Stage 3 stage verdict is NOT CONFERRED by this record.** See §0 |

---

## 0. The one thing this record does not do, stated first because it is the most important limit on it

**`PRD_LIFECYCLE.md` §6 assigns Stage 3 to the *architecture reviewer*.** This record was authored by the **`BC-31`
owner** — the role `ACCEPTED` [`ADR-0047`](../../00-governance/adr/ADR-0047-prd-019-v1-webhook-contract-authority.md)
**L183** names for `Q-B31-AC`, which is a **Stage 4** subject. **No conferral of Architecture Owner authority was
given for this pass, and none is assumed.**

So the distinction this record holds to, and the reason it is worth holding:

| Act | Performed here? |
|---|---|
| **Run** the six Stage 3 checks against the ranked documents, by measurement, citing path and line | ✅ **Yes** — that is §1–§6, and it is what was asked for |
| **Record** every conflict found, with its disposition, and every finding rejected, with its reason | ✅ **Yes** — §7 and §8 |
| **Confer** the Stage 3 verdict, moving `PRD-019` §6 from *NOT PERFORMED* to *PASSED* | ⛔ **No** — that is the architecture reviewer's act |

⚠ **Why this is not pedantry.** `PRD-008`'s record was re-run **eight times** and its §Mandate row carries an
amendment for exactly this class of error: *"A Stage 3 record must not accept the ADR it depends on; it may only
observe that someone with authority did."* The same logic applies one level up — **a record must not confer the
stage it measures.** `PRD-019` §6 therefore reads **MEASURED ALIGNED 6/6, verdict NOT CONFERRED**, and the open item
in §7 names the Architecture Owner. A green gate signed by the author of the thing being gated is not a gate.

---

## 1. Check 1 — Context ownership is exclusive (BC Map §3)

**Measured.** ✅ **ALIGNED.**

| Evidence | Source | Finding |
|---|---|---|
| `BC-31` is a declared context | BC Map **L140** | *"Owns outbound third-party contracts, credentials, retries, idempotent delivery."* |
| Only `PRD-019` claims `BC-31` | `PRD_REGISTRY.md` **L309** | One row, `PRD-019` → `BC-31`. No competing claim |
| No second context claims the wire contract | `ADR-0040` **§4 L165** | Assigns it to *"the `BC-31` owner, once `PRD-019` exists"* |
| Context count unchanged | `PRD-019` §4.7 | **31**, `AR-1` untouched. §4.10 mints **no** context, edge, port, permission or config identifier |

**`ITG-AC-*` creates no ownership question.** All 54 criteria verify obligations already owned by `BC-31` at v0.2.
Ten of them **cite** `PRD-008` identifiers (`FEE-AC-085`…`089`, `FEE-XC-005`, `FEE-BR-016`, `FEE-FR-032`,
`FEE-XC-006`) and **not one copies or re-tests** a `PRD-008` rule — see §8 finding R-3.

---

## 2. Check 2 — Every integration edge exists in BC Map §7

**Measured.** ✅ **ALIGNED — and this is the check that looked like it would fail.**

**The measurement, run first and reported as found:**

```
numbered E-* edges in BC Map §7 touching BC-31 : E-25 only
E-25                                           : BC-20 Billing → BC-31 Integration
numbered edges BC-31 ↔ BC-05                   : 0
```

**So there is no `BC-31`↔`BC-05` edge, and `PRD-019` §4 describes a `BC-31`→`BC-05` evidence handoff.** On the
`PRD-008` first-pass reasoning that would be BLOCKED. **It is not, and the disposition is not mine to invent — it
is already on record:**

> `ACCEPTED` `ADR-0035` **L610**, in the prohibitions table under *"the boundary of the conferral"*:
> *"No new numbered edge, and no widening of the `E-01`…`E-10` allow-list | **`D-1` needed none; ingress needs none**"*

**The architecture asks for a port here, not an edge.** `ITG-BR-010` routes every money-touching action through the
**existing** `business.payment_intent` port — Dependency Matrix **`X-03`**, whose remedy column names that port
verbatim. `PRD-008`'s own record found the identical thing and stated it exactly: *"Half of `FEE-GAP-002` never
existed — it was an artefact of looking for an edge where the architecture asks for a port."*

⚠ **This check therefore passes because a search for an edge was the wrong instrument, not because the missing edge
was waived.** Had `PRD-019` §4 declared a new numbered edge, it would have violated `ADR-0035` L610 and this check
would be BLOCKED. It declares none (§4.7).

---

## 3. Check 3 — Rank direction is downward (Dependency Matrix `L2`)

**Measured.** ✅ **ALIGNED — and this check produced the one finding of this review that changes how a reader should
read §2.1.**

**The ranks, read from Dependency Matrix §3:**

| Rank | Platforms | Line |
|---|---|---|
| **R5** | AUDIT · SEARCH · COMMUNICATION · **INTEGRATION** | **L69** |
| **R6** | **BUSINESS** *(Subscription + Entitlement)* · WORKFLOW · AI | **L70** |

**`L2` (L49):** *"A module may depend only on modules of **strictly lower rank**."*

**Now put the two facts together.** `business.payment_intent` is a **BUSINESS** platform port — **R6**. INTEGRATION
is **R5**. Therefore:

> ### ⚠ FINDING A-1 — had `PRD-019` adopted the ingress reading it refused, it would have created an `L2` violation
>
> `ADR-0035` **L442**, written pre-conferral, proposed the inbound webhook adapter **inside
> `platform/integration`** (R5). An R5 adapter calling the R6 `business.payment_intent` port is a dependency on a
> **strictly higher** rank — **precisely what `L2` forbids**, and `L2` is the law the matrix describes as *"what
> makes the graph provably acyclic without inspecting it."*
>
> `PRD-019` **§2.1 refuses that reading**, keeping ingress a **`platform/business`** (R6) capability per
> `ADR-0035` §5.5b as upheld by `ADR-0040` §1. The refusal was argued there on **governance** grounds — *"a
> superseded proposal is not authority"* and resurrecting it *"inside the very document that benefits from it would
> be the flattering direction."* **This review finds a second, independent and stronger reason: the refused reading
> would have broken `L2`.**
>
> **Disposition: no action. The document is already correct.** The finding is recorded because the *reason* stated
> in §2.1 is weaker than the reason that actually exists, and a future editor tempted to "simplify" by moving the
> adapter into `platform/integration` must be able to find out that it breaks the rank ladder — not merely that it
> re-opens a settled governance point.

**With ingress at R6 and the port at R6, the call is intra-platform and no cross-rank dependency is created at all.**
The `BC-31` ownership asserted by `PRD-019` is **documentary** — who authors and owns the contract — not a runtime
import. Ownership of a contract creates no module dependency, which is the whole content of §2.1's *"owning the wire
contract is not owning ingress."*

**`X-03` is satisfied in the direction it actually prohibits:** *"`domain → INTEGRATION`"* (R8 → R5). No criterion in
§4.10 asks a domain module to import integration; `ITG-AC-038` asserts the opposite at schema-permission level.

---

## 4. Check 4 — No authorisation decision outside `BC-18` (`X-13`)

**Measured.** ✅ **ALIGNED.**

`PRD-019` §4 makes **no** authorisation decision. Signature verification (§4.3) is **message authentication of a
machine-to-machine callback** — it establishes that a byte string was produced by a holder of a shared secret. It
issues no session, evaluates no permission, authenticates no principal and grants no capability.

| Criterion | Why it is not an authorisation decision |
|---|---|
| `ITG-AC-010`…`ITG-AC-014` | Header name, HMAC-SHA256, raw body, constant-time compare, secret rotation — all message authentication |
| `ITG-AC-034`, `ITG-AC-041` | Ordering and no-effect-before-verification — both **negative** assertions about effects |
| `ITG-AC-047` | Rejects IP-based trust. **Strengthens** the position by refusing a trust decision |

⚠ **The naming trap this check exists to catch, disclosed:** *"verify"* appears throughout §4.3, and *"verification"*
is also the word `ADR-0035` §5.5b uses for **`BC-05`'s financial** obligation. **Three different things share the
word** — transport message authentication (`BC-31`), financial confirmation (`BC-05`), and principal authentication
(`BC-18`). `PRD-019` §3 already separates the first two by owner. **This check finds the third is never claimed at
all**, and `ITG-INV-002`/`ITG-AC-041` are explicitly labelled the *"transport half."*

---

## 5. Check 5 — No credential, OTP or session stored outside `BC-18` (`ID-1`)

**Measured.** ⚠ **ALIGNED, with a tension recorded rather than dissolved. This is the closest this review came to a
BLOCKED check.**

**The tension, stated as two verbatim quotations that sit uneasily together:**

| Source | Text |
|---|---|
| BC Map **L178** (`ID-1`) | *"No context outside BC-18 may store a password, OTP, session or **credential**. \| Security review + schema scan in CI"* |
| BC Map **L140** (`BC-31`) | *"Owns outbound third-party contracts, **credentials**, retries, idempotent delivery."* |

**Rank 4 gives `BC-31` credentials in one line and forbids credentials outside `BC-18` in another, and both lines are
in the same document.** `PRD-019`'s `ITG-BR-007` holds a **webhook secret**, so the tension is live, not theoretical.

### 5.1 Disposition

**`ID-1` and L140 are not in conflict, because they govern different objects — and the distinguishing principle is
`ID-1`'s own enumeration, not a convenience invented here.**

`ID-1` lists *"a password, OTP, session or credential."* Read as a set, every member is a **subject
authentication factor** — something by which a **person** proves identity to this platform. `BC-18` owns them
because it owns identity. A **webhook signing secret** is none of those: it is a **shared symmetric key for
machine-to-machine message authentication** between this platform and a third party. It authenticates **no person**,
grants **no session**, and cannot be presented at any login surface.

**What makes this a disposition rather than an assertion:** if the wide reading were correct — every secret of any
kind belongs to `BC-18` — then BC Map **L140** would be **unsatisfiable as written**, because `BC-31` cannot own
*"outbound third-party contracts, credentials, retries"* without holding a credential. A reading that makes a
Rank 4 line impossible to comply with is the wrong reading. **The narrow reading leaves both lines standing; the
wide reading destroys one.**

### 5.2 The residual, and why it is not closed here

> ### ⚠ FINDING A-2 — the `ID-1` / L140 boundary is under-specified at Rank 4, and only the Architecture Owner may specify it
>
> This review found **no ranked document** that states the distinction in §5.1 **explicitly**. It is derived, and
> the derivation is shown so it can be checked and overturned. **`PRD-019` cannot fix this**: `ID-1` and L140 are
> **Rank 4** text, and `DOCUMENTATION_BASELINE.md` §7 rule 1 requires **a prior ADR** for a Rank 1–5 change. A
> Rank 3 draft amending Rank 4 by implication is precisely the inversion the ladder exists to prevent.
>
> **Disposition: check 5 is measured ALIGNED on the narrow reading, and the under-specification is recorded as an
> open item routed to the Architecture Owner.** It is **carried in `PRD-019` §7**, not minted as an `ITG-GAP-*`,
> because the defect is in **Rank 4's** text and an `ITG-*` identifier would imply `BC-31` owns the fix.

**What `PRD-019` does do, within its authority, is fence the secret:** `ITG-BR-007` keeps it out of `BC-05`
(`FEE-XC-005`), and `ITG-AC-035` verifies that by dependency and configuration scan — **the same enforcement `ID-1`
itself specifies** (*"Security review + schema scan in CI"*), not a weaker one. `ITG-AC-025` additionally asserts
**zero** secret and signature values on the audit surface.

---

## 6. Check 6 — Tenant scoping is correct (`MP-GBR-08`, `X-13`)

**Measured.** ✅ **ALIGNED — and §4.10 strengthens this materially over v0.2.**

| Authority | Text | Where satisfied |
|---|---|---|
| `MP-GBR-08` (Master PRD **L339**, Rank 1) | *"Every search index and vector namespace is tenant-partitioned."* | Not engaged — §4 creates no index or vector namespace |
| `X-13` (Matrix **L362**) | *"Cache/index/vector key without `tenantId` \| **Cross-tenant data leak — highest-severity failure class in the system**"* | `ITG-FR-018`, `ITG-INV-001`, `ITG-INV-004` |

**The dedup key is where a cross-tenant leak would actually originate**, and it is the reason this check needed care.
`x-razorpay-event-id` is unique **per event in the provider's namespace**, not in ours. A dedup cache keyed on that
value **alone** is exactly the `X-13` shape: a cache key without `tenantId`.

**§4.10 closes it with three criteria at three different levels, which is why this check strengthens:**

| Criterion | Level | Assertion |
|---|---|---|
| `ITG-AC-040` | **Schema** | Uniqueness constraint on **`(tenant, provider_event_id)`** *in the store* — asserted under **real concurrency**, because a check-then-write race is the failure the invariant exists to prevent |
| `ITG-AC-018` | **Behaviour** | The same event id under tenant A and tenant B is processed **twice**, once per tenant; A's record **never** suppresses B's. Written as a cross-tenant leak test, per `X-13`'s severity |
| `ITG-AC-043` | **Absence** | Every dedup, evidence and audit record carries a **non-null** resolved tenant; an unresolvable tenant is **rejected** and writes **no** record bearing a default or fallback tenant |

⚠ **The failure mode `ITG-AC-043` is aimed at, named because it is the plausible one:** not a missing column, but a
**fallback default** — `tenant = 'system'` or `tenant = null` on an unresolvable delivery, which silently creates a
shared partition. The criterion asserts a schema-level `NOT NULL` and rejection, so the fallback has nowhere to
write.

---

## 7. Conflicts found, and their dispositions — the gate's actual requirement

The gate asks for *"a written alignment record naming **every** conflict and its disposition."* **Three were found.
None is created by `PRD-019`; two are pre-existing Rank 4 conditions and one is a strengthening finding.**

| # | Conflict | Rank of defect | Disposition | Owner |
|---|---|---|---|---|
| **A-1** | The refused `platform/integration` ingress reading (`ADR-0035` L442) would place an **R5** adapter in dependency on an **R6** port — an **`L2` violation** | Rank 2, **already superseded** by §5.5b | ✅ **No action.** `PRD-019` §2.1 already refuses it. Recorded so the *rank* reason is discoverable, not only the governance one | — (recorded) |
| **A-2** | **`ID-1` (L178) vs `BC-31` L140** — Rank 4 forbids credentials outside `BC-18` and grants `BC-31` credentials, in one document | **Rank 4** | ⚠ **Check 5 measured ALIGNED on the narrow reading** (subject authentication factor ≠ machine-to-machine signing key), because the wide reading makes L140 unsatisfiable. **The under-specification is NOT closed** — routed to Architecture Owner, carried in `PRD-019` §7. **No `ITG-GAP-*` minted** (the defect is Rank 4's, not `BC-31`'s) | **Architecture Owner** |
| **A-3** | **No numbered `BC-31`↔`BC-05` edge** exists in BC Map §7 | Not a defect | ✅ **Closed by existing authority.** `ADR-0035` **L610**: *"`D-1` needed none; **ingress needs none**"*. The architecture asks for the `business.payment_intent` port (`X-03`), not an edge | — (closed) |

**Zero conflicts are created by `PRD-019` v0.3.** §4.10 mints no context, edge, port, permission, configuration
identifier, provider or API architecture, and changes no ranked document.

---

## 8. Findings rejected, with reasons — required by the gate

`PRD_LIFECYCLE.md` Stage 3: *"A rejected finding must be recorded as rejected, with its reason."*

| # | Candidate finding | Rejected because |
|---|---|---|
| **R-1** | *"Check 2 must be BLOCKED — `PRD-008`'s record blocked on a missing edge, so this one must too."* | **The precedent points the other way.** `PRD-008`'s own record later diagnosed that reasoning as *"an artefact of looking for an edge where the architecture asks for a port."* Copying the **first-pass error** of a worked example rather than its **corrected conclusion** would be following the form and losing the substance |
| **R-2** | *"Check 5 must be BLOCKED — the webhook secret is a credential and `ID-1` is unambiguous."* | **`ID-1` read that widely makes BC Map L140 unsatisfiable** — `BC-31` cannot own *"outbound third-party contracts, credentials, retries"* while holding no credential. A reading under which one Rank 4 line forbids another Rank 4 line's explicit grant is not the stricter reading; **it is the incoherent one.** The tension is real and is recorded as **A-2** rather than being resolved by fiat in either direction |
| **R-3** | *"The ten criteria citing `FEE-*` identifiers duplicate `PRD-008` and breach `ADR-0040` L166."* | **Measured false.** Each of those criteria asserts a **transport or evidence** fact and names the `FEE-*` identifier as the owner of the consequence it deliberately stops short of. `ITG-AC-036` is the clearest case: it tests that the interface *makes no duplicate-protection promise* and states in its own text that it **does not test `FEE-BR-016`**. **`PRD-008` is byte-unchanged** (`d24832f33e600518`) |
| **R-4** | *"`ITG-AC-013`, `ITG-AC-035` and `ITG-AC-048` are not testable — they are review items, so check 1 of Stage 4 fails."* | **Rejected on the repository's own precedent.** Rank 4 enforces **`ID-1` itself** by *"Security review + schema scan in CI"* — not by a unit test. A timing-based assertion for constant-time comparison is **flaky by construction**, and a flaky test presented as proof is weaker evidence than a named static check. Each of the three states its verification method **in the criterion**, so a reader is not misled |
| **R-5** | *"`PRD-019` should declare the `BC-31`→`BC-05` edge to make check 2 unambiguous."* | **This would be the violation.** `ADR-0035` **L610** prohibits *"No new numbered edge"*, edges are **Rank 4** content, and `DOCUMENTATION_BASELINE.md` §7 rule 1 requires a prior ADR. A Rank 3 **draft** creating a Rank 4 edge to make its own gate green inverts the precedence ladder |
| **R-6** | *"Check 4 fails — §4.3 performs authentication, and authentication belongs to `BC-18`."* | **Conflates three senses of one word.** `X-13`/`ID-1` govern **principal** authentication and session issuance. HMAC verification of a machine callback issues no session, evaluates no permission and authenticates no person. See §4 |
| **R-7** | *"Stage 3 can be marked PASSED, since all six checks measure ALIGNED."* | **Rejected — and this is the rejection that most constrains this pass.** `PRD_LIFECYCLE.md` §6 assigns Stage 3 to the **architecture reviewer**; `ADR-0047` L183 confers only the **`BC-31` owner** role, for a **Stage 4** item. Measuring six checks is not the same act as conferring the stage. See §0 |

---

## 9. What this record does not touch

| Not done | Why |
|---|---|
| No Rank 1–5 document modified | `DOCUMENTATION_BASELINE.md` §7 rule 1 — a prior ADR is required; BC Map hash `81518f1bb251218b` unchanged |
| No new numbered edge, context, port, permission or configuration identifier | `ADR-0035` L610; `AR-1` — context count stays **31** |
| `PRD-008` not opened, amended or frozen | Byte-unchanged `d24832f33e600518`; **0** freeze rows in `DOCUMENTATION_BASELINE.md` §3 |
| `ITG-GAP-001` / `ITG-GAP-002` not closed | Neither is a Stage 3 matter, and neither owner is this role. `ITG-AC-050` verifies `ITG-XC-006`'s **exclusion** and says in its own text that it **does not close `ITG-GAP-001`** |
| Stage 3 verdict not conferred; `PRD-019` not baselined or frozen | §0; freeze is conferred by a `DOCUMENTATION_BASELINE.md` §3 row, and none is written or requested |
| No implementation code, no `IMPL-nnn` allocation | Stage 6 not reached; `docs/40-implementation/integration/` does not exist |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-08-16 | **First Stage 3 architecture alignment record for `PRD-019`**, written against **v0.3** once §4.10 gave the document criteria to review. **All six checks MEASURED ALIGNED**, each against a cited path and line. **Three conflicts recorded with dispositions** (§7): **A-1**, the finding that the ingress reading `PRD-019` §2.1 refuses would have created an **`L2` rank violation** — R5 INTEGRATION depending on the R6 `business.payment_intent` port — which is a **stronger** reason for the refusal than the governance reason §2.1 states; **A-2**, the **Rank 4** tension between `ID-1` (L178, no credential outside `BC-18`) and `BC-31`'s L140 grant of *"credentials"*, disposed of on the narrow reading **because the wide reading makes L140 unsatisfiable**, with the under-specification routed to the **Architecture Owner** and deliberately **not** minted as an `ITG-GAP-*` since the defect is Rank 4's; and **A-3**, the absent `BC-31`↔`BC-05` numbered edge, **closed by existing authority** — `ADR-0035` **L610**, *"ingress needs none"* — the architecture asking for the `business.payment_intent` port (`X-03`) rather than an edge. **Seven findings rejected with reasons** (§8), including **R-1**, refusing to copy `PRD-008`'s **first-pass** edge error rather than its corrected conclusion, and **R-7**, refusing to mark Stage 3 **PASSED**. ⚠ **THE CENTRAL LIMIT, stated in §0 before any check:** this record **runs** the checks but does **NOT confer** the stage. `PRD_LIFECYCLE.md` §6 gives Stage 3 to the **architecture reviewer**; `ADR-0047` **L183** confers only the **`BC-31` owner** role and only for a **Stage 4** item. `PRD-019` §6 therefore reads **MEASURED ALIGNED 6/6 — verdict NOT CONFERRED**, and §7 carries the open item. **A green gate signed by the author of the thing being gated is not a gate** — the same principle `PRD-008`'s record states as *"a Stage 3 record must not accept the ADR it depends on."* **NOT reviewed, NOT approved, NOT baselined, NOT frozen.** No ranked document touched, no checker weakened, no Dart source written. |
