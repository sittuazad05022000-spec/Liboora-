# `PRD-010` — **Stage 4 Requirements Review**

| Field | Value |
|---|---|
| **Document** | Stage-4 requirements-review **measurement** record for `PRD-010 Notifications & Communication` (`BC-22`) |
| **Version** | v1.0 |
| **Date** | 2026-09-05 |
| **Subject** | `PRD-010_NOTIFICATIONS_AND_COMMUNICATION.md` **v0.2 `DRAFT`** — `sha256` `f0b61e0dee82e623deb521278f00d45618438cc161ece950c5bd8ad5d1944513`, ⛔ **byte-unchanged by this review** |
| **Entered because** | ⭐ Stage 3 is **ALIGNED — PASS 6/6**, `NTF-AL-B2` **DISCHARGED** — [`PRD-010_ARCHITECTURE_ALIGNMENT.md`](PRD-010_ARCHITECTURE_ALIGNMENT.md) §18 |
| **Reviewed at** | `e522eb5344fe024adf255c4762f3bee7efde7eac` |
| **Result** | 🚫 **ONE STAGE-4 CHECK FAILS — check 3, on 7 of 7 configurables** |
| **Verdict** | 🚫 **NOT READY** — ⛔ not `BLOCKED`, ⛔ not `PASS`; see §8 |
| **Conferral** | ⛔ **NOT CONFERRED, and not claimable here** — conferral belongs to the **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**), and no such conferral for `PRD-010` exists |
| **Mandate** | ⛔ **Review-only.** 0 requirements created, removed, merged, reworded, re-classified or renumbered · 0 gaps closed · 0 governance, ADR, registry, baseline, architecture or code files touched |
| **Worked precedent** | [`PRD-015_STAGE4_REQUIREMENTS_REVIEW.md`](../search/PRD-015_STAGE4_REQUIREMENTS_REVIEW.md) · [`PRD-016`](../audit/) · [`PRD-006_REQUIREMENTS_REVIEW.md`](../attendance-management/PRD-006_REQUIREMENTS_REVIEW.md) |

> ⭐ **Why this record exists.** Every PRD in this repository that reached Stage 4 has a persisted
> review record — **8 precedents measured**. Findings held only in conversation cannot be verified by
> a later Stage-5 reviewer. ⛔ **This record confers nothing.**

---

## 1. Baseline — measured, not inherited

| Register | Count |
|---|---|
| `NTF-FR-*` | **65** |
| `NTF-BR-*` | **3** |
| `NTF-INV-*` | **11** |
| `NTF-XC-*` | **6** |
| ⭐ **Obligation-bearing** | ⭐ **85** |
| `NTF-AC-*` | **9** |
| `NTF-GAP-*` | **23** |
| **Total** | **117** ✅ reconciles |

⭐ **AC coverage = `9 / 85 = 10.6%`.** ⚠ The earlier figure *"~84"* was an unmeasured estimate,
corrected at alignment supplement **v1.2 §20**; this record uses the exact figure.

---

## 2. The six Stage-4 checks — `PRD_LIFECYCLE.md`

| # | Check | Result | Measurement |
|---|---|---|---|
| 1 | Every requirement testable | ⚠ **PARTIAL** | **0 / 85** vague terms (`appropriate`, `reasonable`, `timely`, `sufficient`, `as needed`, `normally`, `adequate`…); ⚠ but **13** obligations defer to a gap — §4 |
| 2 | Every exclusion states what must be **impossible** | ⚠ **PARTIAL** | **15 / 15** non-scope rows present, **13 / 15** carry an owner or authority basis; ⚠ **4** Class-C rows sit in the `FR` register — §5 |
| 3 | **Every configurable has a default and a range** | 🚫 **FAIL** | ⭐⭐ **7 of 7** Class-A configurables carry **no default, no range, no unit** — §6 |
| 4 | Every acceptance criterion maps to a requirement | ⚠ **PARTIAL** | ⭐ **0 orphan criteria**; ⚠ **8 of 9** carry no explicit requirement ID — §7 |
| 5 | No requirement restates another PRD's | ✅ **PASS** | **15** rows name another `BC-*` under a `MUST`; ⭐ **all 15** constrain **`BC-22`'s own conduct**, not the other context's rules |
| 6 | Business rules do not contradict Rank 1 | ✅ **PASS** | V1 channels = *"exactly In-App and Push"* ⇒ ⭐ matches `MP-SCOPE-09` and `MASTER_PRD` §22 exactly |

**Gate:** *"conflicts closed or explicitly deferred **with a reason and an owner**."*
⇒ ✅ **GATE SATISFIED** — all **23** gaps carry a reason and a named owner.

---

## 3. ⭐ Requirement quality — atomicity, uniqueness, authority

| Property | Result | Measurement |
|---|---|---|
| **Atomicity** | ✅ **PASS** | **0 of 85** rows contain more than two `MUST` clauses; no row bundles independent obligations |
| **Uniqueness** | ✅ **PASS** | **0** duplicate definitions (row-start probe); repeated bold IDs are prose citations |
| **Authority** | ✅ **PASS** | `NTF-BR-001` bars Staff inheritance; `NTF-INV-004` + `NTF-BR-003` keep all authorization in `BC-18` |
| **Actor clarity** | ✅ **PASS** | Owner / Manager / **Reception Staff** — the authoritative names (`Library_PRD_v1.md` **L596**) |
| ⚠ **Dependency** | ⚠ **DISCLOSED** | `NTF-FR-031`, `NTF-XC-006` depend on `PRD-019` (**v0.4 `DRAFT`**, 111 `ITG-*`) — `NTF-GAP-021` |

### 3.1 ⚠ `S4-N3` — **16** obligations carry no `MUST`/`SHALL`, and **6 of them are fine**

A mechanical scan found 16 obligations without an explicit modal verb — **three more than the 13
gap-pointers**. Examined individually:

| Sub-class | Members | Assessment |
|---|---|---|
| ⭐ **Normative by prohibitive construction — testable, NO correction needed** | `NTF-INV-003` (*"No `BC-22` inbound event or outbound payload **may** contain a mobile number"*) · `NTF-BR-002` (*"**No** role … may address an audience outside its own tenant"*) · `NTF-FR-025` (*"⛔ **No** WhatsApp Business/Cloud API…"*) · `NTF-FR-047` (*"**Only** transient failures retry"*) · `NTF-INV-008` (*"**No** recipient set … may span two tenants"*) · `NTF-XC-004` (*"consumes over `E-23` **only**"*) | ✅ **6 — objectively falsifiable as written** |
| ⚠ Overlaps `S4-B1` (Class A) | `NTF-FR-017`, `-040`, `-044`, `-049`, `-054`, `-065` | ⚠ **6** — remedied by §6 |
| ⚠ Overlaps `S4-N2` (Class C) | `NTF-FR-021`, `-022`, `-029` | ⚠ **3** — remedied by §5 |
| ⚠ Class B | `NTF-FR-055` | ⚠ **1** — see §5 |

⇒ ⭐⭐ **A naive "add MUST to all 16" correction would have damaged six sound requirements.**
`"No X may Y"` is stronger than `"X MUST NOT Y"`, not weaker.

---

## 4. The 13 gap-pointer obligations — hypothesis tested

Mechanically located: obligation rows whose text defers to an `NTF-GAP-*`. **13**, not 7 — the
earlier figure understated by six (corrected at alignment **v1.2 §21**).

| Class | Members | Hypothesis | Measured |
|---|---|---|---|
| **A** — genuinely unspecified value | `NTF-FR-017`, `-037`, `-040`, `-044`, `-049`, `-054`, `-065` | 7 need default+range | ✅ **CONFIRMED — 7/7** |
| **B** — testable obligation citing a gap | `NTF-FR-041`, `NTF-FR-055` | no correction needed | ✅ **CONFIRMED**, with one nuance (§5) |
| **C** — scope disclaimer, not a requirement | `NTF-FR-021`, `-022`, `-028`, `-029` | all 4 disclaimers | ⚠ **REFUTED IN DETAIL** (§5) |

---

## 5. Class B and Class C — findings

### 5.1 Class B

| ID | Text (abridged) | Testable? | Correction required? |
|---|---|---|---|
| **`NTF-FR-041`** | *"Preference storage **MUST** use the `BC-25` settings hierarchy rather than a private store."* | ✅ **YES** — assert no private store exists | ⛔ **NONE.** ⭐ The `NTF-GAP-016` citation concerns **`BC-25` ownership** (recorded *contested*, `PRD_REGISTRY.md` **L148**), **not** the obligation |
| ⚠ **`NTF-FR-055`** | *"Platform-wide announcements are ⛔ **NOT V1** — `NTF-GAP-002`."* | ✅ **YES as an exclusion** | ⚠ **Non-blocking nuance:** it states the **deferral** clearly but not *what must be impossible*. Check 2 would prefer *"a platform-wide audience MUST NOT be constructible"* |

### 5.2 ⚠ Class C — **the hypothesis is refuted in detail**: they are **three different kinds**

| ID | Actually a… | States impossibility? | Stage-4 risk |
|---|---|---|---|
| `NTF-FR-021` | **Disclaimer** — *"no two-way surface is created here"* | ⚠ **Partially** — says what is not created, not what must be impossible | ⚠ Placement |
| `NTF-FR-022` | ⚠ **Conditional capability statement** — *"legitimate … **only if** `BC-12` emits a fact `BC-22` may consume"* | ⛔ **NO** — a condition, not an exclusion | ⚠ Placement |
| ⚠ `NTF-FR-028` | ⭐⭐ **An OPEN QUESTION, not a disclaimer at all** — *"Whether use of the redirect is itself an auditable event is `NTF-GAP-012`"* | ⛔ **NO** | ⚠⚠ **Highest of the four** — an interrogative in a requirement register |
| ⚠ `NTF-FR-029` | ⭐⭐ **An OWNERSHIP CAVEAT** — the redirect *"may belong to … `BC-01`"* (`NTF-GAP-013`) | ⛔ **NO** | ⚠⚠ Architectural, not functional |

⇒ ⭐⭐ **Only `NTF-FR-021` and `NTF-FR-022` are disclaimers.** `NTF-FR-028` is a **question** and
`NTF-FR-029` an **ownership caveat** — neither is an exclusion, so *"state what must be impossible"*
cannot be satisfied by rewording alone. ⛔ **Reported only; nothing re-classified.**

---

## 6. 🚫 `S4-B1` — the seven Class-A configurables (**the blocking finding**)

| Requirement | Missing element | Why it matters | Blocking? | Required correction |
|---|---|---|---|---|
| `NTF-FR-017` | **default · min · max · unit** (recipients per dispatch; rate/interval) | ⭐ Unbounded bulk send is the accidental-Send-to-All risk `R2` | 🚫 **YES** | **Product Owner** — `NTF-GAP-007` |
| `NTF-FR-037` | **allowed set** (languages/scripts) | Templates cannot be authored or validated | 🚫 **YES** | **Product Owner** — `NTF-GAP-014` |
| `NTF-FR-040` | **allowed set** (which entries are mandatory vs optional) | Opt-out is unimplementable without it | 🚫 **YES** | **Product Owner** — `NTF-GAP-015` |
| `NTF-FR-044` | **semantic definition** (what Push `delivered` means) | ⭐ A lifecycle state with no defined meaning cannot be asserted | 🚫 **YES** | **Architecture Owner** — `NTF-GAP-017` |
| `NTF-FR-049` | **default · min · max · unit** (retry count, backoff, dedup window) | ⭐ Interacts with `NTF-INV-007`; wrong window = duplicate notices | 🚫 **YES** | **Architecture Owner** — `NTF-GAP-018` |
| `NTF-FR-054` | **authority split** (platform vs tenant keys) | Config authority undefined ⇒ `NTF-FR-052` unenforceable | 🚫 **YES** | **Architecture Owner** — `NTF-GAP-019` |
| `NTF-FR-065` | **observable target** (SLO/SLI values) | No measurable objective | 🚫 **YES** | **SRE / Observability** — `NTF-GAP-020` |

⛔⛔ **No authoritative value exists in the repository for any of the seven.** Each was probed;
⭐ **each row explicitly refuses to invent one** (*"no number is proposed"*, *"no numbers invented"*,
*"no guarantee asserted"*, *"no classification asserted"*).

⇒ ⭐⭐ **This is a specification hole that requires authoring/product authority, not a review fix.**
⛔ **This record proposes no value.** ⚠ **`NTF-FR-065` additionally may not borrow `ADR-0102`'s
SRE office** — that conferral was `PRD-015`-only and `ADR-0033` §7.1 bars reuse.

---

## 7. Acceptance-criteria coverage — measured

| Question | Answer |
|---|---|
| Orphan criteria (**check 4**) | ✅ **0** — every AC traces to an obligation **by content** |
| ⚠ Explicit requirement IDs | ⚠ **1 of 9** (`NTF-AC-009` → `NTF-INV-011`); **8** are implicit |
| Do any cover multiple obligations? | ✅ **Yes** — `NTF-AC-001` covers `NTF-INV-007` **+** `NTF-FR-045`; `NTF-AC-007` covers `NTF-FR-019` **+** `NTF-FR-008` |
| Distinct obligations actually covered | ⭐ **≈11 of 85 (≈13%)** — higher than the raw `9/85` |
| Any AC too broad to be meaningful? | ⛔ **No** — all 9 are Given/When/Then with one observable assertion |
| Uncovered obligations | ⚠ **≈74** — including **all 6** `NTF-XC-*`, 2 of 3 `NTF-BR-*`, and the whole template/config/observability set |
| Blocking? | ⛔ **NON-BLOCKING at Stage 4** — check 4 tests **AC → requirement**, which passes. ⚠ **Material for Stage 5**, whose gate is bidirectional traceability |

⭐ **Quality note, volunteered:** the 9 criteria are unusually well-targeted — each attacks a named
risk (dedup, cross-tenant, staff escalation, guardian scope, WhatsApp history). **`NTF-AC-009`** is
exemplary: asserting *the emitting aggregate's post-state is unchanged* makes `CM-3` mechanically
testable rather than merely stated.

---

## 8. Verdict

> ## 🚫 **STAGE 4 — NOT READY**

| Result | Count |
|---|---|
| ✅ Checks PASS | **2** (5, 6) |
| ⚠ Checks PARTIAL | **3** (1, 2, 4) |
| 🚫 Checks FAIL | ⭐ **1 — check 3** |
| ✅ Gate (reason + owner) | **SATISFIED** — 23/23 |

**Why NOT READY, and not `BLOCKED`:** check 3 fails outright, and the lifecycle names that failure
*"a specification hole."* But ⛔ **nothing is unlawful**: no Rank-1 contradiction, no usurped
ownership, no invented event, no invented authorization scope, and every deferral carries a reason
and an owner. ⇒ **Seven values are missing, not wrong.**

**Why not `PASS`:** ⛔ check 3 cannot be waived by a reviewer, and ⛔ **no authoritative value exists
to fill it** — the remedy is a product/architecture decision.

⛔⛔ **Stage 4 is NOT CONFERRED, and this record cannot confer it** — conferral belongs to the
**Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**); no such conferral for `PRD-010` exists.
⭐ Precedent: `PRD-015_STAGE4_REQUIREMENTS_REVIEW.md` recorded *"MEASURED PASS — STAGE 4 NOT
CONFERRED"* on exactly this reasoning, and waited.

### 8.1 Required next actions

| Priority | Action | Owner |
|---|---|---|
| 🚫 **Must fix before Stage 5** | `S4-B1` — 7 configurables gain a **default + range**, or are withdrawn | **Product / Architecture / SRE** per §6 |
| ⚠ Should fix | `S4-N1` explicit AC→requirement IDs · `S4-N2` relocate `NTF-FR-021`/`-022` to non-scope and re-shape `-028`/`-029` · `S4-N4` owners for `N14`/`N15` | PRD-010 author |
| ⛔ Open decision | All **23** gaps — notably `NTF-GAP-002`, `005`, `006`, `011`, `021` | As recorded |
| ✅ No action | 6 prohibitive-form obligations · `NTF-FR-041` · atomicity · uniqueness · checks 5 & 6 · `NTF-INV-011` | — |

---

## 9. Governance integrity

| Statement | Verified |
|---|---|
| **Stage 3 remains PASS 6/6** | ✅ `NTF-AL-B2` **DISCHARGED**, `NTF-AL-F2` **OPEN** — untouched |
| No Stage-3 check re-opened or altered | ✅ |
| Subject modified | ⛔ **NO** — `sha256` `f0b61e0d…944513`, 117 identifiers |
| Alignment record modified | ⛔ **NO** — `sha256` `5344e3a6…ef7dbb` |
| Requirements created/removed/merged/reworded/re-classified/renumbered | ⛔ **0 · 0 · 0 · 0 · 0 · 0** |
| Gaps closed | ⛔ **0** — 23 remain OPEN |
| ADRs · registry · baseline · architecture · `module_dependencies.yaml` · code · `IMPL-*` | ⛔ **0 · `PLANNED` · 0 · 0 · 0 · 0 · 0** |
| Values invented | ⛔ **0** |

---

## 10. Change history

| Version | Date | Change |
|---|---|---|
| **v1.0** | 2026-09-05 | ⭐⭐ **Created as the Stage-4 requirements-review measurement record for `PRD-010` v0.2, following the 8 persisted Stage-4 precedents in this repository.** ⛔ **Verdict: NOT READY — one of six checks FAILS.** ⭐⭐ **Check 3 fails on 7 of 7 Class-A configurables**, none of which carries a default, range or unit, and for which ⛔ **no authoritative value exists anywhere in the repository** — each row explicitly refuses to invent one ⇒ the remedy is a **product/architecture/SRE decision**, and ⛔ **this record proposes no value**. ✅ **Checks 5 and 6 PASS cleanly**: the 15 rows naming other bounded contexts all constrain **`BC-22`'s own conduct** rather than restating another PRD's rules, and the V1 channel set (*"exactly In-App and Push"*) matches Rank-1 `MP-SCOPE-09` exactly. ⚠ **Checks 1, 2 and 4 PASS in substance with partials**: **0 / 85** vague terms, **0** orphan acceptance criteria, **0** duplicate definitions, **0** atomicity breaches. ⭐⭐⭐ **Two prior hypotheses were tested rather than assumed, and one was refuted**: Class A **confirmed 7/7**, but **Class C refuted in detail** — only `NTF-FR-021` and `NTF-FR-022` are disclaimers, while **`NTF-FR-028` is an open question** and **`NTF-FR-029` an ownership caveat**, so *"state what must be impossible"* cannot be met by rewording alone. ⭐⭐ **A new finding, `S4-N3`**: **16** obligations carry no `MUST`/`SHALL` — three more than the 13 gap-pointers — of which ⭐ **6 are properly normative by prohibitive construction** (*"No X may Y"*, *"Only transient failures retry"*) and need **no** correction; a naive *"add MUST to all 16"* fix would have damaged them. ⭐ **AC coverage measured at `9 / 85 = 10.6%` raw but ≈11 / 85 (≈13%) by content**, since two criteria each cover two obligations; ⚠ **8 of 9 carry no explicit requirement ID** — non-blocking at Stage 4 but **material for Stage 5's bidirectional gate**. ✅ **The Stage-4 gate itself — *"conflicts closed or explicitly deferred with a reason and an owner"* — is SATISFIED at 23/23**, which is why the verdict is **NOT READY rather than BLOCKED**: seven values are *missing*, not *wrong*. ⛔⛔ **Stage 4 is NOT CONFERRED and this record cannot confer it** — conferral belongs to the **Requirements Reviewer** (`PRD_LIFECYCLE.md` §6 **L278**), on the `PRD-015_STAGE4_REQUIREMENTS_REVIEW.md` precedent. ⛔ **0 subject bytes, 0 alignment bytes, 0 requirements touched, 0 gaps closed, 0 ADRs, 0 registry, 0 baseline, 0 architecture, 0 code, 0 values invented.** |

---

# SUPPLEMENT v1.1 — ⚠ CORRECTION: THE REMEDY MECHANISM I DESCRIBED WAS **INVERTED**

⛔ **The v1.0 record above is NOT rewritten.** Its verdict, its six check results and its seven
findings are unchanged. This supplement corrects **one procedural claim** I made about *how* the
`S4-B1` remedy must be executed.

| Field | Value |
|---|---|
| Trigger | ⭐ Reviewer self-audit of an unproven procedural assertion |
| Verdict impact | ⛔ **NONE** — Stage 4 remains 🚫 **NOT READY**; `S4-B1` still blocking |
| Subject bytes changed | ⛔ **0** — `sha256` `f0b61e0dee82e623deb521278f00d45618438cc161ece950c5bd8ad5d1944513` |
| Verified at | `83dbe6c` |

---

## 11. ⚠⚠ What I claimed, and why it was wrong

I reported the lawful remedy path as:

> *"an ADR carrying the human decision → a `CONFIGURATION_GUIDE` block → then the PRD requirement
> cites the slot"*

⛔⛔ **That ordering is inverted.** `CONFIGURATION_GUIDE.md` **L9** states its own standing:

> *"**Authority** | **Subordinate to the PRDs.** This guide sets values **within** the envelope they
> define; **it cannot change the envelope**"*

And **L451-455** records the actual `FIL-CFG-*` precedent verbatim:

> *"**Declared by** `PRD-017_FILE_AND_MEDIA.md` **§8.5, which publishes fifteen `FIL-CFG-*` slots.**
> This section supplies values for **ten** of them. **Authority:** `ADR-0057`, which closes
> `FIL-GAP-014` by **recording Product-Owner-supplied values rather than inventing them**."*

### 11.1 ⭐ The correct order — three steps, and the PRD moves **first**

| Step | Act | Owner | Evidence |
|---|---|---|---|
| **1** | ⭐ **The PRD declares the configurable *slots*** — e.g. an `NTF-CFG-*` register, each slot naming its requirement, and each requiring *"a declared default and range"* | **PRD-010 author** | `PRD-017` **§8.5**; `FIL-FR-074` |
| **2** | The **ADR** records the human-supplied **values** for those slots | **Product / Architecture / SRE Owner** | `ADR-0057` |
| **3** | `CONFIGURATION_GUIDE` **supplies the values into the declared slots**, each with `Slot`, `Owner`, `Provenance`, value+range, rationale | **Configuration Owner** | **L484-500** |

⇒ ⭐⭐ **The guide can only fill slots a PRD has already published.** My v1.0 description had the
guide leading and the PRD citing afterwards, which would have had a **subordinate** document define
an envelope it *"cannot change"*.

### 11.2 ⭐⭐ A material consequence I had missed

`NTF-CFG-*` count in `PRD-010` = **0**, and in `CONFIGURATION_GUIDE` = **0**.

⇒ ⚠⚠ **`S4-B1` therefore has an authoring limb as well as an authority limb**, and only the
authority limb was reported at v1.0:

| Limb | Owner | Blocked on |
|---|---|---|
| **(a)** Declare the `NTF-CFG-*` slots in `PRD-010` — ⭐ **step 1**, needs **no** external decision | **PRD-010 author** | ⭐ **Nothing** — this is authorable today |
| **(b)** Supply the seven **values** | Product / Architecture / SRE | ⛔ **Three human acts** |

⭐ **Step (a) is genuinely unblocked.** ⛔ **It was not performed here**, because the governing task
was authority resolution and §5 conditions all authoring on *"after all seven decisions are formally
recorded"* — which remains **0 of 7**. ⚠ It is recorded so the author does not wait on authority for
a step that does not require it.

### 11.3 ⭐ One precedent worth carrying into step (a)

`PRD-017` §8.5 publishes nine values and states plainly that **eight satisfy** the default-and-range
rule *"and one does not"* — `FIL-CFG-006` carries a range but no default — adding:

> *"The exception is named here rather than in a footnote, because a subsection that opens by
> claiming all nine comply and then discloses an exception is internally contradictory."*

⇒ ⭐⭐ **A Stage-4 check-3 register may lawfully contain a declared, reasoned exception.** That is a
materially easier target than *"all seven values must exist first"*, and it is the shape `PRD-010`'s
`NTF-CFG-*` register should take.

---

## 12. ⛔ What this supplement does NOT change

| Item | State |
|---|---|
| Stage-4 verdict | 🚫 **NOT READY — unchanged** |
| `S4-B1` | 🚫 **Blocking — unchanged**, now with limbs (a) and (b) separated |
| Checks 1–6 results | ⛔ **unchanged** (2 PASS · 3 PARTIAL · 1 FAIL) |
| `S4-N1`…`S4-N4` | ⛔ **unchanged** |
| Stage 3 | ✅ **PASS 6/6** — untouched |
| Subject · ACs · gaps | ⛔ **0 bytes · 9 · 23 OPEN** |
| ADRs · registry · baseline · code | ⛔ **94 · `PLANNED` · 0 · 0** |
| Values invented | ⛔ **0** |

---

## 13. Change history

| Version | Date | Change |
|---|---|---|
| **v1.1** | 2026-09-05 | ⚠⚠ **Reviewer self-audit: the procedural remedy path published at v1.0 was INVERTED, and is corrected here by append.** I had described the mechanism as *ADR → `CONFIGURATION_GUIDE` → PRD citation*; ⛔ **but `CONFIGURATION_GUIDE.md` L9 declares itself *"subordinate to the PRDs… it cannot change the envelope"***, and **L451-455** records the real `FIL-CFG-*` precedent: the values are *"**Declared by** `PRD-017` **§8.5, which publishes fifteen slots**"*, with `ADR-0057` then *"recording Product-Owner-supplied values rather than inventing them"*. ⇒ ⭐ **The correct order is: (1) the PRD declares the `*-CFG-*` slots, (2) an ADR records the human-supplied values, (3) the guide fills the declared slots** with `Slot`/`Owner`/`Provenance`/value+range/rationale (**L484-500**). ⭐⭐ **A material consequence v1.0 missed:** `NTF-CFG-*` = **0** in both `PRD-010` and the guide, so **`S4-B1` has an authoring limb as well as an authority limb** — limb **(a)**, declaring the slots, requires **no external decision and is authorable today**; limb **(b)**, the seven values, still needs **three human acts**. ⛔ **Limb (a) was NOT performed here**, because the governing task conditioned all authoring on all seven decisions being recorded, which remains **0 of 7** — it is recorded so the author does not wait on authority for a step that needs none. ⭐ **A further precedent is carried forward:** `PRD-017` §8.5 declares nine configurables and states that **eight comply with the default-and-range rule and one does not** (`FIL-CFG-006`), naming the exception in the text *"because a subsection that opens by claiming all nine comply and then discloses an exception is internally contradictory"* ⇒ **a check-3 register may lawfully carry a declared, reasoned exception**, a materially easier target than requiring all seven values up front. ⛔ **Verdict unchanged: Stage 4 NOT READY, `S4-B1` blocking, checks 2 PASS / 3 PARTIAL / 1 FAIL, Stage 3 PASS 6/6 untouched, 0 subject bytes, 0 ACs changed, 23 gaps OPEN, 0 ADRs, 0 registry, 0 baseline, 0 code, 0 values invented.** |

---
---

# Supplement v1.2 — the check-3 target was MIS-SIZED and MIS-SHAPED, and limb (a) is now performed

> ⛔ **Append-only.** §1-13 above are preserved byte-identical. This supplement corrects the reviewer's
> own classification and records the authoring act that v1.1 identified as unblocked but did not perform.

---

## 14. Why this supplement exists

v1.1 established that **`S4-B1` has two limbs**: limb **(a)**, declaring the `NTF-CFG-*` slots, needs no
external decision; limb **(b)**, the seven values, needs three human acts. Limb (a) was deliberately not
performed there because the then-governing task conditioned all authoring on all seven decisions being
recorded.

A subsequent instruction removed that condition, directing that a lawful solution be derived where one
exists and that proposals be labelled where authority is absent. Limb (a) is therefore **performed** —
`PRD-010` **v0.3 §20.1** — and performing it **falsified two of this record's own findings**.

---

## 15. ⚠⚠ Correction 1 — three of the "seven Class-A configurables" are NOT configurables

v1.0 §4 recorded check 3 as failing on **7 of 7** Class-A configurables. Writing the register exposed
that **three of the seven cannot carry a default and a range at all**, because they are not
configuration values. Calling them configurables was a **category error**, and it made the check-3
target look both larger and simpler than it is.

| Obligation | v1.0 class | ⭐ Corrected class | Decisive authority |
|---|---|---|---|
| **`NTF-FR-044`** — Push `delivered` semantics | Class A configurable, value owed | ⛔ **Provider-semantic definition** | Rank 1 `MASTER_PRD.md` **L229** already fixes the provider (*"**Firebase Cloud Messaging** — Yes — FCM (V1)"*). ⇒ the **provider** is not open; the **acknowledgement model** is that provider's published documentation, which this repository does not contain — the same condition `ADR-0045` made decisive for the payment gateway. **No configuration value can change what FCM acknowledges** |
| **`NTF-FR-054`** — platform vs tenant keys | Class A configurable, value owed | ⛔ **Configuration-platform resolution property** | `FIL-XC-009` (`PRD-017` **L302**): a module *"**MUST NOT** define a configuration value's default, range or **resolution order**."* `ADR-0017` **§2.5** assigns *"hierarchy, precedence and override semantics"* to `PRD-023`. ⇒ `PRD-010` publishing this slot would itself be a violation |
| **`NTF-FR-065`** — SLO / SLI targets | Class A configurable, value owed | ⛔ **NFR locus** | Rank 1 `MP-NFR-01` (`MASTER_PRD.md` **L495**) assigns availability *"targets with SLOs, SLIs and error budgets"* to **SRE / OBSERVABILITY**. ⭐ **An NFR target is ratified by an office, not tuned by an operator** — the repository has **never** published an availability target in a `*-CFG-*` register |

⇒ ⭐⭐ **Check 3's true target is SIX slots**, of which **one is satisfied by citation** and **five are
owed**. The three reclassified obligations leave check 3 and fall to **check 1 (testability)**, where
`NTF-FR-044` and `NTF-FR-065` remain **untestable as written** and `NTF-FR-054` remains a **disclosure
of contested ownership**. ⛔ **The reclassification is recorded, not applied as a renumbering** — no
identifier moved, no requirement was reworded, and `NTF-FR-044`/`-054`/`-065` are unchanged in the
subject.

---

## 16. ⚠ Correction 2 — one slot was already satisfied, and this record said no authority existed

v1.0 stated that for the seven configurables *"**NO** authoritative value exists anywhere in the
repository."* ⛔ **That was true of six and false of one.**

⭐ **`NTF-CFG-002`** (template language) resolves to **`LCFG-2`** — default **`en`**, range *"Supported
set"*, owner **Product**, rationale *"Only locale with complete strings at V1"* — declared at
`Library_PRD_v1.md` **L717** (**FROZEN, Rank 3**) and valued at `CONFIGURATION_GUIDE.md` **L352**.

⚠ **The reason this was missed is worth recording, because it is a trap.** `PRD-015` was refused this
exact citation **four times** (`SRCHCL-X3`, `SRCHGR-X4`, `SRCHGB-X4`, and `F5_OWNERSHIP_RULING` §4.3,
which named it *"a **false friend**"*). Inheriting that conclusion looked like rigour. But every one of
those refusals rests on a **single measured ground** — *"a **UI-string locale**, not a **script
inventory**"* — and that ground is **specific to search**. A notification template **is** a UI string.
⇒ ⭐ **The refusals do not transfer**, and treating them as if they did would have been a governance
error dressed as caution. §20.2 of the subject carries the full distinction.

⛔ **Still not claimed:** `ADR-0100` §3.7's closed **English + Hindi** inventory is search-scoped and
is **not** imported; `NTF-FR-037`'s prohibition on borrowing `SRCHPO-17` **stands unamended**.
⚠ **`NTF-GAP-024` minted** — whether a `BC-22` template may consume a **Library-scoped** `LCFG-*` slot
is unruled (**Architecture Owner**). The *value* is authoritative; its *cross-context consumption* is not.

---

## 17. ⭐ Two units are fixed by precedent even though the numbers are refused

Neither is an invented value; both are **constraints on any future value**, which makes them findings
rather than proposals.

| Slot | ⭐ Constraint the repository already imposes | Authority |
|---|---|---|
| **`NTF-CFG-004`** | ⭐⭐ **A retry bound counts TOTAL ATTEMPTS, not retries.** `FIL-CFG-014` reads *"**3** attempts **total** (initial + 2 retries)"*, unit *"attempts"*, and **`INV-21`** requires *"retry bound **≥ 1**"* because *"zero attempts means nothing is ever processed."* ⇒ any value expressed as *retries* with a floor of **0** contradicts `INV-21` under the repository's own unit | `CONFIGURATION_GUIDE.md` **§2C.6 L607-621**, **L757** |
| **`NTF-CFG-006`** | ⭐⭐ **The dedup window is bounded below by an invariant, not by taste.** `NTF-INV-007` forbids retry producing *"a second user-visible notification"*; a window expiring while a retry is in flight produces exactly that. ⇒ `NTF-CFG-004`, `-005` and `-006` are **not independently choosable** | `NTF-INV-007`; `NTF-GAP-018` carries all three |

⛔ **`FIL-CFG-014`'s NUMBER is not carried across.** Its rationale is a **storage** failure domain
(*"a worker eviction, a storage blip"*); a push-provider rejection is a different domain with a
different owner. Importing the number is the cross-PRD borrow `ADR-0033` **§7.1** forbids — the same
prohibition this record already applied to `ADR-0102`.

⛔ **`PRD-019`'s 30-day dedup retention is not applicable either.** `ITG-FR-017` retains an opaque
`(tenant, event-id)` **transport** key derived from a payment provider's published windows
(`ADR-0047` **L101**); `NTF-INV-007`'s key is `(eventId, recipientId, channel, templateId)`, a
**user-visibility** key.

---

## 18. ⛔ Availability — what the repository fixes, and why no SLO is published

| Element | Position | Authority |
|---|---|---|
| **Unit** | ⭐ **`% monthly`**. ⛔ *"rolling 30 d"* has **0** occurrences repository-wide | `authentication/prd-v2/11-NFR-Compliance-and-Final-Acceptance.md` **L67-69** |
| **Ceiling** | ⭐ A dependent sits **below** its dependency ⇒ `BC-22` **MUST NOT exceed 99.9%** | `ADR-0100` **§3.2**; `BC-18` at 99.95% |
| **Ordering** | ⭐⭐ **`NTF-INV-011`** makes notification the plane that must **never** fail a business operation ⇒ it is the **least** availability-critical plane and cannot carry a **tighter** outage bound than authentication | `NTF-INV-011`; auth NFR **L72-73** |
| **Numeric SLO** | ⛔ **NOT PUBLISHED** | `ADR-0102` ratified a **target** and left **`SRE-GAP-001` OPEN** on the SLO/SLI/error-budget limbs |

⭐⭐⭐ **The decisive measurement: the repository has never ratified an SLO for anything.** Publishing
one in `PRD-010` would be the **first**, asserting more authority than the single conferred SRE act
claimed for itself. ⇒ Refused. `NTF-GAP-020` requires a **fresh** conferral scoped to `PRD-010`.

---

## 19. ⚠⚠ Two NEW architecture findings — disclosed, not cured

| ID | Finding | Disposition |
|---|---|---|
| **`NTF-AL-F3`** | `platform/communication`'s manifest block (**L392-410**) declares ports `platform/integration:connector` and `platform/identity:notification_address` and **no** `platform/configuration:settings` — so `E-19`'s *"**All contexts** → `BC-25`"* grant (BC Map **L328**) and the module block **disagree** | ⚠ **DISCLOSED.** ⭐ `PRD-017` has the **identical** condition — there is **no** `platform/media` module block at all, yet §8.5 resolves nine slots through `E-19` — so §20.1 follows `E-19` exactly as the precedent does. ⛔ **Manifest NOT edited.** Owner: **Architecture Owner** |
| **`NTF-AL-F4`** | ⭐⭐ **`NTF-FR-049` presupposes a retry mechanism the manifest does not grant `BC-22`.** `platform/workflow` is the **only** module declaring `platform/services:job_runtime` (**L338**); `platform/communication` declares **no** job, scheduler or timer port. `FIL-XC-017` forbids a module scheduling its own retries | ⚠ **DISCLOSED and MATERIAL.** ⇒ a retry value would be *"configured and **not yet consumable**"* — the exact condition `FIL-GAP-015` records for `PRD-017`. ⭐ **This makes the `NTF-GAP-018` value question premature**, which is a stronger reason to withhold the numbers than the authority reason alone. Owner: **Architecture Owner** |

⛔ Neither is allowed to fail the subject: both are **pre-existing manifest conditions**, and no
`NTF-*` requirement depends on their lawfulness — the same disposition `NTF-AL-F2` received.

---

## 20. Verdict — restated, and unchanged where it matters

| Check | v1.0 | ⭐ v1.2 | Movement |
|---|---|---|---|
| 1 — Testable, unambiguous | PARTIAL | **PARTIAL** | ⚠ **Three obligations moved INTO this check** from check 3 (§15) |
| 2 — Exclusions state what is impossible | PARTIAL | **PARTIAL** | — |
| 3 — Every configurable has a default and a range | ⛔ **FAIL 0/7** | ⛔ **FAIL — 1 of 6 satisfied** | ⭐ Target re-sized **7 → 6**; **1 satisfied by citation**; **5 owed**; **slots now declared** |
| 4 — Every AC maps to a requirement | PARTIAL | **PARTIAL** | — |
| 5 — No restatement of another PRD | PASS | **PASS** | ⭐ Re-tested: `NTF-CFG-002` **consumes** `LCFG-2`, it does not restate it |
| 6 — No Rank-1 contradiction | PASS | **PASS** | ⭐ Re-tested against `MASTER_PRD` **L229** and **L495** |

⛔⛔ **STAGE 4 REMAINS NOT READY.** `S4-B1` limb **(a) DISCHARGED**; limb **(b) OPEN** on **five**
values (not seven), requiring **Product Owner** (`NTF-CFG-001`, `-003`), **Architecture Owner**
(`NTF-CFG-004`, `-005`, `-006`) and — for the reclassified `NTF-FR-065` — a **fresh SRE/Observability
conferral**.

⭐ **Why this is progress and not merely re-labelled failure:** the register now **exists**, so check 3
has a locus to be evaluated against; the authority requirement fell from **three offices over seven
values** to **two offices over five values**, plus one NFR act that was never a configuration act at
all; and **two units and one invariant coupling** now constrain those five values, so the eventual
decision is bounded rather than open.

⛔ **Stage 4 is NOT CONFERRED and this record cannot confer it** — `PRD_LIFECYCLE.md` §6 **L278**
assigns conferral to the **Requirements Reviewer**. Stage 3 remains **PASS 6/6**.

---

## 21. ⛔ What this supplement does NOT do

| ⛔ | Confirmation |
|---|---|
| Invent a value | **0.** No recipient ceiling, rate limit, retry count, backoff schedule, dedup window, percentage, SLO, SLI, error budget or mandatory/optional classification |
| Manufacture authority | **0.** No PO, AO, SRE, Governance Owner or Requirements Reviewer act is claimed or simulated |
| Reuse `ADR-0102` | ⛔ **Refused** — `ADR-0033` §7.1 |
| Borrow `SRCHPO-17` / `ADR-0100` §3.7 | ⛔ **Refused** — search-scoped |
| Close a gap | **0.** **24 OPEN**, one newly minted (`NTF-GAP-024`) |
| Renumber or reclassify in the subject | **0.** §15's reclassification is **recorded**, not applied |
| Confer a stage | **0.** Stage 4 NOT READY, NOT CONFERRED |
| Touch a frozen or ranked document | **0** `MASTER_PRD` · **0** BC Map · **0** matrix · **0** `module_dependencies.yaml` · **0** `CONFIGURATION_GUIDE.md` · **0** frozen PRDs · **0** baseline · **0** registry · **0** ADRs (94) |
| Modify §1-13 of this record | **0 bytes** — verified by `cmp` against a pre-edit snapshot |
| Touch application code | **0** lines; `lib/` unchanged |

---

## 22. Change history

| Version | Date | Change |
|---|---|---|
| **v1.2** | 2026-09-05 | ⭐⭐⭐ **Reviewer self-audit falsifies TWO of this record's own Stage-4 findings, and performs the limb v1.1 identified as unblocked.** **Correction 1 — the check-3 target was MIS-SHAPED:** three of the seven *"Class-A configurables"* are **not configurables at all** — `NTF-FR-044` is a **provider-semantic definition** (Rank 1 `MASTER_PRD.md` **L229** already fixes FCM as the V1 provider; the acknowledgement model is that vendor's absent documentation — the `ADR-0045` condition), `NTF-FR-054` is a **`BC-25` resolution property** whose publication by this PRD `FIL-XC-009` **forbids** and `ADR-0017` §2.5 assigns to `PRD-023`, and `NTF-FR-065` is an **NFR locus** owned by SRE/Observability under Rank 1 `MP-NFR-01` — *an NFR target is ratified by an office, not tuned by an operator*. ⇒ **check 3's target is 6, not 7**, and the three reclassified obligations move to **check 1**. **Correction 2 — v1.0's claim that NO authority exists for any of the seven was true of six and FALSE of one:** `NTF-CFG-002` resolves to **`LCFG-2`** (`en`, *"Supported set"*, Product; `Library_PRD_v1.md` **L717** FROZEN Rank 3). ⚠ The miss is recorded as a **trap**: `PRD-015` was refused this citation **four times**, but every refusal rests on the single ground *"a **UI-string locale**, not a **script inventory**"* — and a notification template **is** a UI string, so **the refusals do not transfer**; inheriting them would have been a governance error dressed as caution. ⭐ **Limb (a) of `S4-B1` is DISCHARGED** — `PRD-010` **v0.3 §20.1** declares six `NTF-CFG-*` slots on the `FIL-CFG-006` precedent that a slot is published *"even when no authority yet supplies a number"*; limb **(b) remains OPEN on FIVE values**, reducing the requirement from **three offices over seven** to **two offices over five** plus one NFR act. ⭐ **Two units are fixed by precedent without inventing numbers**: a repository retry bound counts **total attempts** (`FIL-CFG-014` + `INV-21` ≥ 1, so a *retries, floor 0* formulation would contradict `INV-21`), and the dedup window is **bounded below by `NTF-INV-007`**, making the three retry slots **not independently choosable**. ⭐ **Availability measured, not proposed**: unit is **`% monthly`** (⛔ *"rolling 30 d"* = **0** occurrences repository-wide), the ceiling is **≤ 99.9%** by the dependent-below-dependency rule, and ⭐⭐ **`NTF-INV-011` makes notification the LEAST availability-critical plane** so it cannot carry a tighter outage bound than authentication; ⛔ **no SLO published — the repository has never ratified one**, and `ADR-0102` left `SRE-GAP-001` OPEN. ⚠⚠ **`NTF-AL-F3`** (no `platform/configuration:settings` port on `platform/communication`, so `E-19` and the manifest disagree — ⭐ `PRD-017` has the identical condition, having **no** `platform/media` block at all) and ⚠⚠ **`NTF-AL-F4`** (⭐⭐ `NTF-FR-049` presupposes a retry scheduler the manifest does not grant `BC-22`; `platform/workflow` is the **only** `job_runtime` consumer — mirroring `FIL-GAP-015`, which makes the value question **premature**, a stronger ground for withholding than authority alone) are **DISCLOSED, NOT CURED**. ⭐ **`NTF-GAP-024` minted** — cross-context `LCFG-*` consumption is unruled. ⛔⛔ **Verdict UNCHANGED: Stage 4 NOT READY, NOT CONFERRED; `S4-B1` limb (b) blocking; Stage 3 PASS 6/6 untouched; 24 gaps OPEN.** ⛔ **0 values invented, 0 authority manufactured, 0 gaps closed, 0 identifiers renumbered, 0 ADRs (94), 0 registry, 0 baseline, 0 frozen docs, 0 `CONFIGURATION_GUIDE.md` bytes, 0 manifest bytes, 0 code.** §1-13 preserved byte-identical (`cmp` PASS). |

---
---

# Supplement v1.3 — the retry audit: `NTF-AL-F4` withdrawn as overstated, and the unit upgraded to authoritative

> ⛔ **Append-only.** §1-22 above are preserved byte-identical.

---

## 23. ⛔⛔ I published `NTF-AL-F4` without measuring an `Accepted` ADR that decides it

An independent audit of the retry question was directed. It falsified **my own v1.2 finding** on two
grounds. Both are recorded before anything favourable, because the favourable part is a consequence of
the error rather than a discovery on its own merits.

| # | What v1.2 published | ⛔ Why it was wrong |
|---|---|---|
| 1 | *"`FIL-XC-017` forbids a module scheduling its own retries"* — cited as if it bound `BC-22` | ⛔ **`FIL-XC-017` is a `PRD-017` exclusion binding `BC-29`.** `PRD-010`'s own register (`NTF-XC-001`…`-006`) contains **no** scheduling prohibition. Applying another PRD's **frozen exclusion** to this subject is the cross-PRD borrow this very record refuses elsewhere. ⇒ the condition is a **missing port**, not a violated prohibition |
| 2 | *"mirroring `FIL-GAP-015`"* | ⛔⛔ **`FIL-GAP-015` is CLOSED.** ⭐ **`ADR-0058`** (`Accepted`, 2026-08-20) closes it, and I compared the `BC-22` condition to a gap that had already been resolved — without opening the ADR that resolved it |

⭐ **`ADR-0058`'s holding is directly on point**, which is why missing it mattered: the gap was a
**port-vs-runtime conflation**, because *"every child of EA 'Job Runtime (V2)' … is scaled
**infrastructure**, and **none of them is the port**."*

---

## 24. ⭐⭐⭐ The mechanism `NTF-FR-049` needs already exists — measured, not assumed

| Element | Status | Exact evidence |
|---|---|---|
| `JobRuntime` port interface | ✅ **EXISTS** | `packages/liboora_contracts/lib/src/ports/job_runtime.dart` **L100**; exported `liboora_contracts.dart` **L27** |
| V1 adapter, registered | ✅ **EXISTS** | `InProcessJobRuntime` — `lib/platform/services/services.dart` **L100**; composition root `lib/bootstrap/di.dart` **L240-243** |
| Rank lawfulness of `BC-22` → port | ✅ **STRICTLY DOWNWARD** | `platform/services` **rank 3** vs `platform/communication` **rank 5** — manifest **L26-49** ⇒ **`L2` satisfied**, no exception, no cluster, no `ADR-0012` debt |
| Retry unit | ⭐⭐ **total attempts, including the first** | `job_runtime.dart` **L104-106**; `JobOutcome.attempts` **L82** |
| `≥ 1` floor | ✅ **EXECUTABLE**, cites `INV-21` by name | `services.dart` **L152-159** — `ArgumentError` on `retryBudget < 1` |
| Backoff in V1 adapter | ⛔ **NONE** | `services.dart` **L189-221** — deadline check, attempt, catch, loop; **no delay** |

⇒ ⭐ **`NTF-AL-F4` reduces to ONE narrow act**: add `platform/services:job_runtime` to
`platform/communication`'s `ports:` list — the **`A-3` shape** (`amendments_applied` **L715-721**), the
same mechanism by which this module gained `platform/identity:notification_address`. ⛔ Not an
exception, not a law waiver, not new infrastructure. **Architecture Owner.** ⛔ Manifest **not edited**.

---

## 25. ⭐ Check 3 movement — one unit becomes authoritative, one slot becomes premature

| Slot | v1.2 class | ⭐ v1.3 class | Basis |
|---|---|---|---|
| **`NTF-CFG-004`** unit | Precedent-supported (`FIL-CFG-014`) | ⭐⭐ **REPOSITORY-AUTHORITATIVE** | The **rank-0 shared-kernel port contract**, not another PRD's value. `FIL-CFG-014` was **weak authority** for `PRD-010`; the port signature is **binding on every consumer** |
| **`NTF-CFG-004`** value | OWED | ⛔ **OWED — unchanged** | See §26 |
| **`NTF-CFG-005`** backoff | OWED | ⛔ **OWED + genuinely PREMATURE** | **0** schedules at Rank 1–5; adapter implements none; EA places *"Retry & Backoff"* at **V2** (**L1808**) |

⚠ **v1.2's claim that the *attempt bound* was premature is WITHDRAWN.** The runtime exists, the unit is
contract-fixed, and the edge is one lawful downward port. **Only backoff is premature.**

---

## 26. ⛔ Why "3 attempts, range 1–5" is REFUSED for PRD-010 — on the merits, not only on authority

⭐⭐ **The decisive measurement is a domain inversion, and it is stronger than the authority objection.**

| Property | `PRD-017` media processing | `PRD-010` notification delivery |
|---|---|---|
| Recovery model | ⭐ `FIL-FR-057` — a derivative is **never the sole copy**; `FIL-FR-083` — **regenerable** | ⛔ **Not regenerable; no second copy.** A lost expiry notice is simply **not sent** |
| Failure domain | *"a worker eviction, a storage blip"* (`CONFIGURATION_GUIDE` **L617**) | External **push provider** rejection / FCM transport |
| Consequence of exhaustion | Object reprocessable later | ⛔ **User never informed** |

⇒ ⛔ **`3` is derived from an assumption that does not hold for `PRD-010`.** Importing it would be
wrong **on the merits**, independently of `ADR-0033` §7.1's prohibition on cross-PRD borrowing.
⚠ **Directionally, notification's non-regenerability argues for a bound at least as high as 3, not
lower** — but *"at least as high"* is not a number, and **no number is proposed here**.

---

## 27. ⚠⚠ `NTF-GAP-025` minted — a Rank-4 obligation this record had not tested

BC Map **L452** (Rank 4): *"Retry with backoff → **Dead Letter Queue**. DLQ depth is an SLO-monitored
signal, not a silent bin."* ⛔ **`PRD-010` contains 0 occurrences of DLQ or dead-letter**, and `BC-28`
— which **L137** says *"owns … DLQ"* — is **V2**.

⭐ **Why this is not automatically a contradiction:** L452 sits under BC Map §9.1 *Event Delivery
Contract*, *"owned by **EVENT PLATFORM**"*, governing **event consumption**. `BC-22`'s outbound
**channel** delivery is a different plane, which is why `NTF-FR-047`'s terminal `failed` does not
violate it. ⛔ **But whether the outbound plane needs a dead-letter path is UNRULED**, and it is **not
resolved in this record's favour**. Owner: **Architecture Owner**.

---

## 28. Verdict

⛔⛔ **STAGE 4 REMAINS NOT READY AND NOT CONFERRED.** Check 3: **1 of 6 satisfied** (`NTF-CFG-002`),
**1 unit authoritative with value owed** (`NTF-CFG-004`), **4 owed**. Stage 3 **PASS 6/6** untouched.
**25 gaps OPEN.**

⭐ **Net movement:** `NTF-CFG-004`'s unit rose from *precedent* to *authoritative*; `NTF-AL-F4` fell
from *blocking, premature* to *one narrow manifest amendment*; and the refusal of `3` is now supported
by a **domain-inversion measurement** rather than authority alone.

⛔ **0 values invented · 0 authority manufactured · 0 gaps closed · 0 identifiers renumbered · 0 ADRs
(94, `ADR-0058` cited never amended) · 0 manifest bytes · 0 BC Map · 0 `MASTER_PRD` · 0 frozen PRDs ·
0 `CONFIGURATION_GUIDE` · 0 baseline · 0 registry · 0 code (port and adapter read as evidence only).**

---

## 29. Change history

| Version | Date | Change |
|---|---|---|
| **v1.3** | 2026-09-05 | ⛔⛔ **`NTF-AL-F4` WITHDRAWN AS OVERSTATED on two independently sufficient grounds, both mine.** (1) v1.2 cited **`FIL-XC-017`** as though it bound `BC-22`; it is a **`PRD-017` exclusion binding `BC-29`**, and `PRD-010`'s register carries **no** scheduling prohibition — applying another PRD's frozen exclusion here is the cross-PRD borrow this record refuses elsewhere. (2) v1.2 called the condition *"mirroring `FIL-GAP-015`"* while **`FIL-GAP-015` is CLOSED by `ADR-0058`** (`Accepted`, 2026-08-20), an ADR I never opened before publishing the comparison. ⭐⭐⭐ **The mechanism `NTF-FR-049` needs ALREADY EXISTS:** `JobRuntime` port (`job_runtime.dart` **L100**), registered V1 adapter (`services.dart` **L100**, `di.dart` **L240-243**), and a **strictly downward** lawful edge (`platform/services` **rank 3** → `platform/communication` **rank 5** ⇒ **`L2` satisfied**, no exception needed). ⇒ **`NTF-AL-F4` reduces to ONE narrow manifest amendment** in the **`A-3` shape** (**L715-721**). ⭐⭐⭐ **`NTF-CFG-004`'s unit UPGRADED from precedent-supported to REPOSITORY-AUTHORITATIVE** — the authority is the **rank-0 shared-kernel port contract** (*"`retryBudget` is the **total** attempts permitted, **including the first**"*, **L104-106**), with the **≥ 1 floor enforced EXECUTABLY** (`services.dart` **L152-159**, quoting `INV-21`), not `FIL-CFG-014`, which was **weak authority** for this PRD. ⛔⛔ **The number `3` is REFUSED ON THE MERITS, not merely on authority:** `PRD-017`'s bound rests on `FIL-FR-057`/`FIL-FR-083` — a derivative is *"never the sole copy"* and is *"regenerable"* — whereas ⭐⭐ **a notification is NOT regenerable and has NO second copy**, so the domains have **inverted recovery models** and `3` is derived from an assumption that does not hold here. ⚠ Directionally this argues for a bound **at least as high as 3**, and ⛔ **no number is proposed**. ⭐ **`NTF-CFG-005` (backoff) isolated as the ONE genuinely premature slot** — **0** schedules at Rank 1–5 (all occurrences are refusals or a provider's own policy), the **V1 adapter implements none** (**L189-221** retries immediately), EA places *"Retry & Backoff"* at **V2** (**L1808**) ⇒ a value would have nothing to execute it; v1.2's claim that the **attempt bound** was premature is **withdrawn**. ⚠⚠ **`NTF-GAP-025` minted** — BC Map **L452** mandates *"Retry with backoff → **Dead Letter Queue**"*, `PRD-010` has **0** DLQ occurrences and `BC-28` is **V2**; ⭐ L452 governs the **event backbone** (EVENT PLATFORM, §9.1) not `BC-22`'s **outbound channel** plane, so `NTF-FR-047` does not contradict it — but the question is **unruled** and **not resolved in this record's favour**. ⛔⛔ **Verdict UNCHANGED: Stage 4 NOT READY, NOT CONFERRED; check 3 = 1 of 6 satisfied + 1 unit authoritative; Stage 3 PASS 6/6; 25 gaps OPEN.** ⛔ **0 values invented, 0 authority manufactured, 0 gaps closed, 0 renumbered, 0 ADRs (94), 0 manifest bytes, 0 BC Map, 0 MASTER_PRD, 0 frozen PRDs, 0 CONFIGURATION_GUIDE, 0 baseline, 0 registry, 0 code.** §1-22 preserved byte-identical (`cmp` PASS). |

---
---

# Supplement v1.4 — the retry-budget audit: my "non-regenerable" premise was false, and the number is still not derivable

> ⛔ **Append-only.** §1-29 above are preserved byte-identical.

---

## 30. ⛔⛔ I asserted a durability property of this domain without measuring the channel set

v1.3 refused `FIL-CFG-014`'s value of `3` **partly on the merits**, on the ground that *"a notification
is **not regenerable** and has **no second copy**"*, and concluded that `PRD-017` and `PRD-010` have
**inverted recovery models**. ⭐⭐⭐ **Both halves of the premise are false**, and the refuting evidence
was inside the subject document the whole time:

| Measurement | Result |
|---|---|
| §8 catalogue rows naming **In-App** | ⭐ **13 of 13** |
| Rows that are **Push-only** | ⭐⭐ **ZERO** (11 In-App + Push; 2 In-App only) |
| In-app inbox ownership | *"`FeedItem` … owned by **`BC-22`'s inbox projection**"* — BC Map **L205** |
| Projection durability | ⭐⭐ BC Map **L453** (Rank 4): *"every projection … **must be rebuildable from the log**. This is tested quarterly, not assumed"* |
| Event delivery | **At-least-once**, consumer idempotency mandatory — BC Map **L446-447** |

⇒ ⭐⭐⭐ **A failed Push is not a lost notification.** For every catalogue entry the In-App inbox carries
the same fact; the inbox is a **rebuildable projection**; the source event persists.

⇒ ⚠⚠ **The correction runs AGAINST my own earlier position and is recorded for that reason.** The two
domains are **not** inverted — both have a surviving copy and a regeneration path — so the *reasoning
shape* behind `FIL-CFG-014` (a small bound absorbing transient faults without masking deterministic
failure, **because** a durable fallback exists) **does** transfer to `PRD-010`. **`3` is more
defensible than v1.3 said.**

⛔ **The verdict is nonetheless unchanged, because the surviving objection is authority, not merit.**
`FIL-CFG-014` is a **`PRD-017`-scoped value** owned by that PRD's scope owner; `ADR-0033` **§7.1**
forbids importing it. ⭐ **What changed is the argument, not the outcome** — and a reviewer who reads
only v1.3 would have the right verdict for the wrong reason.

---

## 31. ⭐ What IS derivable — two constraints, recorded as constraints

| Bound | Value | Derivation |
|---|---|---|
| **Floor** | ⭐ **≥ 1 total attempt** | ⛔ **Not a proposal — already binding.** `INV-21`; and **executably** at `services.dart` **L152-159**, which throws `ArgumentError` on `retryBudget < 1` |
| **Ceiling constraint** | ⭐⭐ *attempts × per-attempt duration MUST fit inside the job `deadline`* | `job_runtime.dart` **L107-110** (*"`deadline` bounds the whole job"*) + `services.dart` **L190-201** (deadline re-checked **before each attempt**) ⇒ an over-large budget is **partly unreachable**, the defect class `INV-18`/`INV-20` guard elsewhere |

---

## 32. ⛔⛔ Why the exact number is NOT derivable — a specific reason, not a procedural one

⭐⭐⭐ **The ceiling constraint is a function of two quantities that do not exist in this repository:**

1. ⛔ **A notification job deadline.** **0** occurrences at any rank. `NTF-CFG-*` declared none until
   this pass.
2. ⛔ **The provider's acknowledgement and retry behaviour** — `NTF-GAP-017`, unresolvable because the
   repository does not contain FCM's documentation (the `ADR-0045` condition).

⭐⭐ **The decisive asymmetry with `PRD-017`, which is the whole answer to "why not 3":**
`PRD-017` could derive **3** only because `ADR-0057` had **already fixed its companion timeout at
120 s** (`FIL-CFG-015`), making *attempts × duration ≤ deadline* a solvable inequality. **`PRD-010` has
no companion deadline**, so the same derivation is **structurally unavailable** — not merely
unauthorised.

⇒ ⛔ **Any specific number — 3, 4 or 5 — would be picked, not derived.** ⚠ **`4` and `5` were tested
and rejected as candidates**: nothing in the repository distinguishes them from `3` on evidence, and
selecting the larger merely because notification is *"important"* would be a preference presented as a
derivation. ⛔ **The adversarial `5` (`AUTH-3.9`, 5 verification attempts) is NOT a candidate at all** —
it bounds an **attacker's guesses**, not transient faults, and `CONFIGURATION_GUIDE` **L41** lists it
among values that are *"**not configurable**"*.

---

## 33. ⭐⭐ `NTF-CFG-007` minted — the audit exposed a missing obligation

Published on the **`FIL-CFG-015` precedent** — that configurable was *"added at v0.2 **because writing
the configurable exposed that the obligation was missing**"*.

⭐ **The `JobRuntime` contract REQUIRES a `deadline` on every submission** (`job_runtime.dart`
**L107-110**). ⇒ `BC-22` **cannot lawfully submit** delivery work without one, and without it
`NTF-CFG-004`'s attempt count is **unbounded in time** — a delivery could remain non-terminal
indefinitely, which `NTF-FR-042`'s monotonic lifecycle cannot then guarantee reaches a terminal state.

⇒ **`NTF-GAP-026`** carries it, and records that it is the **blocking companion** for
`NTF-CFG-004`'s upper bound. ⛔ **No duration proposed.**

---

## 34. Answers to the four subsidiary questions

| Question | Answer |
|---|---|
| **Is a range appropriate?** | ✅ **YES — a range is the correct shape.** Every comparable slot publishes one (`LCFG-6` *0–300 s*, `LCFG-12` *5–50*, `FIL-CFG-014` *1–5*). ⭐ Its **floor is already fixed at 1**; its **upper bound is owed** |
| **Should backoff remain OWED?** | ✅ **YES — unchanged.** **0** schedules at Rank 1–5; the V1 adapter implements **none** (`services.dart` **L189-221** retries immediately); EA places *"Retry & Backoff"* at **V2** (**L1808**) |
| **Should DLQ apply to outbound delivery?** | ⚠ **UNRULED — `NTF-GAP-025` stays OPEN.** BC Map **L452** binds the **event backbone** (EVENT PLATFORM, §9.1), not `BC-22`'s outbound channel plane; `BC-28`, which *"owns … DLQ"* (**L137**), is **V2**. ⛔ Not resolved in this record's favour |
| **Minimum `job_runtime` amendment?** | ⭐ **One line**: add `platform/services:job_runtime` to `platform/communication`'s `ports:` list, in the **`A-3` shape** (`amendments_applied` **L715-721**). ⛔ **Not** an exception — `platform/services` **rank 3** → `platform/communication` **rank 5** is **strictly downward**, so **`L2` holds with no waiver** |

---

## 35. Verdict

⛔⛔ **Exact retry budget remains OWED; repository evidence establishes the unit and minimum floor but
does not authorize the numeric value.**

Check 3 status: **1 of 7 satisfied** (`NTF-CFG-002`) · **1 unit + floor authoritative, value owed**
(`NTF-CFG-004`) · **5 owed**. Stage 3 **PASS 6/6**. **26 gaps OPEN.** Stage 4 **NOT READY, NOT
CONFERRED**.

⭐ **Net movement this pass:** a false merits argument was **withdrawn**; two real constraints were
**derived** (floor already binding, ceiling inequality); the **structural** reason the number is
underivable was identified; and a **missing obligation** (`NTF-CFG-007`) was exposed by the audit
itself.

⛔ **0 values invented · 0 authority manufactured · 0 gaps closed · 0 renumbered · 0 ADRs (94) ·
0 manifest · 0 BC Map · 0 `MASTER_PRD` · 0 frozen PRDs · 0 `CONFIGURATION_GUIDE` · 0 baseline ·
0 registry · 0 code.**

---

## 36. Change history

| Version | Date | Change |
|---|---|---|
| **v1.4** | 2026-09-05 | ⛔⛔ **MY OWN v1.3 MERITS ARGUMENT IS FALSIFIED AND WITHDRAWN — I asserted that a notification is *"not regenerable"* with *"no second copy"* without measuring the channel set.** The refuting evidence was inside the subject: **13 of 13** §8 catalogue rows name **In-App** and **ZERO** are Push-only; BC Map **L205** makes the inbox `FeedItem` *"owned by `BC-22`'s inbox projection"*; and BC Map **L453** (Rank 4) requires *"every projection … must be **rebuildable from the log**"* under the **at-least-once** contract at **L446-447**. ⇒ ⭐⭐⭐ **a failed Push is NOT a lost notification.** ⇒ The domains are **NOT inverted** — both have a surviving copy and a regeneration path — so `FIL-CFG-014`'s reasoning **shape** does transfer and **`3` is MORE defensible than v1.3 said**. ⚠ Recorded although it weakens my earlier position; ⛔ **verdict unchanged**, because the surviving objection is **authority (`ADR-0033` §7.1), not merit**. ⭐⭐ **TWO REAL CONSTRAINTS DERIVED and recorded as constraints, not values:** floor **≥ 1 total attempt** (already binding via `INV-21` and the **executable** `ArgumentError` at `services.dart` **L152-159**), and a **ceiling inequality** — *attempts × per-attempt duration ≤ job `deadline`* (`job_runtime.dart` **L107-110**; `services.dart` **L190-201** re-checks before each attempt) ⇒ an over-large budget is **partly unreachable**. ⛔⛔ **THE NUMBER IS NOT DERIVABLE FOR A STRUCTURAL REASON:** the inequality needs two quantities that do not exist — a notification **job deadline** (0 at any rank) and the **provider's** acknowledgement behaviour (`NTF-GAP-017`, blocked by absent FCM documentation, the `ADR-0045` condition). ⭐⭐ **`PRD-017` could derive `3` ONLY because `ADR-0057` had already fixed `FIL-CFG-015` at 120 s**, making the inequality solvable; `PRD-010` has **no companion deadline**, so the derivation is **structurally unavailable**, not merely unauthorised. ⚠ **`4` and `5` were tested and rejected** — nothing distinguishes them from `3` on evidence, and choosing the larger because notification *feels* important would be a preference presented as a derivation; ⛔ the adversarial **5** (`AUTH-3.9`) is **not a candidate**, bounding an attacker's guesses and listed at `CONFIGURATION_GUIDE` **L41** among values *"not configurable"*. ⭐⭐ **`NTF-CFG-007` MINTED (delivery job deadline)** on the **`FIL-CFG-015` precedent** — the `JobRuntime` contract **requires** a deadline per submission, so `BC-22` cannot lawfully submit without one and the attempt count is otherwise **unbounded in time**; ⭐ **`NTF-GAP-026` minted** as its carrier and as the **blocking companion** for `NTF-CFG-004`'s upper bound. ✅ **A RANGE is confirmed as the right shape** (floor fixed at **1**, upper bound owed); ✅ **backoff stays OWED**; ⚠ **DLQ stays UNRULED** (`NTF-GAP-025`); ⭐ the **minimum `job_runtime` amendment is ONE LINE** in the `A-3` shape, needing **no `L2` waiver** since rank 3 → rank 5 is strictly downward. ⛔⛔ **VERDICT: exact retry budget remains OWED; the unit and floor are established, the numeric value is not authorised.** Check 3 = **1 of 7 satisfied + 1 unit/floor authoritative + 5 owed**; Stage 4 **NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**; **26 gaps OPEN**. ⛔ **0 values invented, 0 authority manufactured, 0 gaps closed, 0 renumbered, 0 ADRs (94), 0 manifest, 0 BC Map, 0 MASTER_PRD, 0 frozen PRDs, 0 CONFIGURATION_GUIDE, 0 baseline, 0 registry, 0 code.** §1-29 preserved byte-identical (`cmp` PASS). |

---
---

# Supplement v1.5 — comparative 1–5 analysis: `3` recommended, and the reason it still cannot be fixed

> ⛔ **Append-only.** §1-36 above are preserved byte-identical.

---

## 37. ⭐⭐⭐ The measurement that decides the comparison

Prior passes reasoned about the retry budget from **documents**. This pass measured the **runtime**, and
found the governing fact:

| Probe | Result |
|---|---|
| `Future.delayed` · `sleep` · `Timer` in the **retry loop** | ⛔ **NONE** — `services.dart` **L196-221**: deadline check → `attempts++` → `await work()` → catch → **loop immediately** |
| Delay primitives in the **port contract** | ⛔ **NONE** — `job_runtime.dart`: 0 hits for `delay`, `Timer`, `interval` |
| The one `await Future.wait` | ⭐ **L124, inside `drain()`** — a shutdown/test join point, ⛔ **not** the attempt loop |

⇒ ⭐⭐⭐ **At V1 the whole budget is consumed in an immediate, tight burst.** This **inverts** the
intuitive argument that "more attempts = more resilient": with no spacing, a larger budget buys **N
near-simultaneous calls to the same failing provider**, not a wider recovery window.

---

## 38. Comparative assessment

| Budget | Verdict |
|---|---|
| **1** | ⛔ **Rejected.** Lawful (`services.dart` **L152-159**) and `FIL-CFG-014` itself calls 1 *"no retry, permitted for diagnostics"* — but it renders `NTF-FR-047`'s retry obligation **inoperative** |
| **2** | ⚠ **Defensible; the strongest rival.** Absorbs a single dropped packet. ⛔ But with zero spacing it addresses only the shortest fault, and **nothing in the repository favours 2 over 3** |
| **3** | ⭐ **Best available V1 choice.** The **reasoning** transfers (not the number): *"three attempts absorb transient faults … without masking a deterministic failure"* — valid **because** a durable fallback exists, which §30 established `PRD-010` has |
| **4** | ⛔ **Rejected.** No evidence distinguishes it from 3; with no backoff the 4th immediate attempt adds provider load without a materially different time window |
| **5** | ⛔⛔ **Rejected twice over.** As 4, amplified — **and** ⭐ the repository's only `5` is **adversarial**: `AUTH-3.9` bounds an **attacker's guesses** and `CONFIGURATION_GUIDE` **L41** lists it among values *"**not configurable**"*. Borrowing it would import a security-throttle rationale into a fault-tolerance slot |

⇒ ⭐⭐ **`[RECOMMENDED — NOT AUTHORITATIVE]` 3 total attempts, range 1–5.** ⚠ **`5` is acceptable as a
range ceiling although rejected as a default** — a range bounds what an operator may set; it does not
endorse the extreme.

---

## 39. ⛔⛔ Why it still cannot be fixed — substantive, not procedural

⭐ **With no inter-attempt delay, the budget consumes ≈ 3 × (provider timeout). Neither factor exists:**

| Missing factor | Status |
|---|---|
| Notification job **deadline** | ⛔ **OWED** — `NTF-CFG-007` / `NTF-GAP-026` |
| Provider **timeout / ack model** | ⛔ **`NTF-GAP-017`** — blocked by absent FCM documentation (`ADR-0045` condition) |

⇒ ⭐⭐ **A budget fixed now could be PARTLY UNREACHABLE the instant a deadline is chosen.** If the
deadline is shorter than 3 × timeout, the 2nd or 3rd attempt is **never tried** and the configured
value is a fiction — **exactly the defect class `INV-18` and `INV-20` exist to prevent**.

⇒ ⭐⭐⭐ **Ordering is substantive: `NTF-CFG-007` must be decided BEFORE or WITH `NTF-CFG-004`.** They
are **one decision with two limbs**, and `PRD-017` is the proof — `ADR-0057` set the **120 s** timeout
and the **3**-attempt bound **in the same act**.

---

## 40. ⚠⚠ Two self-limiting disclosures

**1 — The executing test is NOT authority.** `test/architecture/job_runtime_port_test.dart` **L43**
declares `const int _retryBound = 3`, and a careless reading would present that as ratification. Its
own comment names it *"the recorded **`FIL-CFG-014`** default"* ⇒ ⛔ a **`PRD-017` test fixture**.
Citing an executing test as authority for a different bounded context is manufacturing authority from
a fixture.

**2 — The In-App fallback is specified but not yet executably proven for `BC-22`.** §30 rested the
`3` recommendation on BC Map **L453** rebuildability. That rule is Rank 4 and binding, but
`every_projection_rebuildable_test.dart` covers **Analytics only** (**0** hits for `BC-22`, `inbox`,
`FeedItem`) and `lib/platform/` contains **no `communication` module**. ⇒ The recommendation rests on
the **specification**, and the distinction is stated rather than blurred.

---

## 41. Confirmations requested

| Item | Status |
|---|---|
| **`NTF-FR-047`** | ✅ **CONFIRMED, unchanged** — *"Only **transient** failures retry; permanent failures terminate as `failed`."* (subject **L450**) |
| **`NTF-INV-011` / `CM-3` / `EBR-1030`** | ✅ **CONFIRMED, unchanged** — `module_dependencies.yaml` **L409-410**: *"an unresolvable address fails the delivery only; it never fails the emitting operation."* |
| **Backoff** | ⛔ **OWED** — 0 schedules at Rank 1–5; adapter implements none; EA places *"Retry & Backoff"* at **V2** |
| **`NTF-GAP-025` (DLQ)** | ⚠ **OPEN but NON-BLOCKING** for the budget — it governs what happens **after** exhaustion, not how many attempts occur |

---

## 42. Verdict

⛔⛔ **The exact retry budget remains OWED.** ⭐ **But this pass changes its status**: it is no longer
*"no defensible value"* — it is **one recommended value (`3`, range `1–5`) with a stated technical
derivation, awaiting joint ratification with the deadline.**

Check 3: **1 of 7 satisfied** · **1 unit+floor authoritative with a labelled recommendation** ·
**5 owed**. Stage 3 **PASS 6/6**. **26 gaps OPEN.** Stage 4 **NOT READY, NOT CONFERRED**.

⛔ **0 values made authoritative · 0 gaps closed · 0 identifiers minted or renumbered · 0 ADRs (94) ·
0 manifest · 0 BC Map · 0 `MASTER_PRD` · 0 frozen PRDs · 0 `CONFIGURATION_GUIDE` · 0 baseline ·
0 registry · 0 code · 0 test code.**

---

## 43. Change history

| Version | Date | Change |
|---|---|---|
| **v1.5** | 2026-09-05 | ⭐⭐⭐ **Comparative 1 · 2 · 3 · 4 · 5 analysis performed against the MEASURED runtime rather than against documents, and one fact decides it: THE V1 RETRY LOOP HAS NO DELAY BETWEEN ATTEMPTS** — 0 hits for `Future.delayed`/`sleep`/`Timer` in `services.dart` **L196-221** and 0 delay primitives in `job_runtime.dart`; the single `await Future.wait` (**L124**) is inside **`drain()`**, not the loop. ⇒ ⭐⭐⭐ **the budget is consumed in an immediate burst, which INVERTS the "more attempts = more resilient" intuition**: without spacing, a larger budget buys **N near-simultaneous calls to the same failing provider**. ⭐ **On that measurement: `1` rejected** (renders `NTF-FR-047`'s retry obligation inoperative, and `FIL-CFG-014` itself calls 1 *"no retry, permitted for diagnostics"*); **`2` defensible and the strongest rival** but addresses only the shortest fault with nothing favouring it over 3; **`4` rejected** (no evidence distinguishes it from 3; the 4th immediate attempt adds load, not a wider window); ⛔⛔ **`5` rejected twice over** — as 4 amplified, **and** because ⭐ the repository's only `5` is **ADVERSARIAL** (`AUTH-3.9`, bounding an **attacker's guesses**, listed at `CONFIGURATION_GUIDE` **L41** among values *"not configurable"*), so borrowing it would import a security-throttle rationale into a fault-tolerance slot. ⇒ ⭐⭐ **`[RECOMMENDED — NOT AUTHORITATIVE]` 3 total attempts, range 1–5**, with `5` acceptable as a range **ceiling** though rejected as a **default**. ⛔⛔ **STILL NOT FIXABLE, for a SUBSTANTIVE reason:** with no delay the budget consumes ≈ 3 × (provider timeout) and **neither factor exists** — `NTF-CFG-007` is OWED (`NTF-GAP-026`) and the provider timeout is `NTF-GAP-017` (absent FCM documentation, `ADR-0045` condition) ⇒ ⭐⭐ **a value fixed now could be PARTLY UNREACHABLE once a deadline is chosen** (2nd/3rd attempt never tried), **exactly the defect class `INV-18`/`INV-20` prevent**. ⇒ ⭐⭐⭐ **ORDERING IS SUBSTANTIVE: `NTF-CFG-007` before or with `NTF-CFG-004`** — one decision, two limbs, proven by `ADR-0057` setting `FIL-CFG-015` (120 s) and `FIL-CFG-014` (3) **in the same act**. ⚠⚠ **TWO SELF-LIMITING DISCLOSURES rather than leaving them for a reader:** (1) `job_runtime_port_test.dart` **L43**'s `const int _retryBound = 3` is, by its own comment, *"the recorded **`FIL-CFG-014`** default"* ⇒ ⛔ a **`PRD-017` fixture, NOT `PRD-010` authority** — citing an executing test as ratification for another context manufactures authority from a fixture; (2) BC Map **L453** rebuildability is binding, but `every_projection_rebuildable_test.dart` covers **Analytics only** (0 hits for `BC-22`/`inbox`/`FeedItem`) and `lib/platform/` has **no `communication` module** ⇒ the In-App fallback underpinning the `3` recommendation is **specified but NOT YET EXECUTABLY PROVEN** for `BC-22`. ✅ **`NTF-FR-047` CONFIRMED unchanged**; ✅ **`NTF-INV-011`/`CM-3`/`EBR-1030` CONFIRMED unchanged** (`module_dependencies.yaml` **L409-410**); ⛔ **backoff stays OWED**; ⚠ **`NTF-GAP-025` recorded NON-BLOCKING** for the budget (it governs post-exhaustion behaviour, not attempt count). ⛔⛔ **Verdict: exact retry budget remains OWED — but its status improves from "no defensible value" to "one recommended value with a stated derivation, awaiting joint ratification with the deadline".** Check 3 = 1 of 7 satisfied + 1 unit/floor authoritative with a labelled recommendation + 5 owed; Stage 4 **NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**; **26 gaps OPEN**. ⛔ **0 values made authoritative, 0 gaps closed, 0 identifiers minted or renumbered, 0 ADRs (94), 0 manifest, 0 BC Map, 0 MASTER_PRD, 0 frozen PRDs, 0 CONFIGURATION_GUIDE, 0 baseline, 0 registry, 0 application code, 0 test code.** §1-36 preserved byte-identical (`cmp` PASS). |

---
---

# Supplement v1.6 — adversarial loop: STOP CONDITION B reached, and the blocker is categorical

> ⛔ **Append-only.** §1-43 above are preserved byte-identical.

---

## 44. The loop, and what it disproved

| Iteration | Proposal | Outcome |
|---|---|---|
| **1** | `3` total attempts, range `1–5`, pending a single `NTF-CFG-007` deadline (my v0.6 position) | ⛔ **DISPROVED as to completeness** — three coupled structural defects, below |
| **2** | Revised: the clock is **two** bounds, the terminals need a **declared mapping**, and quiet hours are **unslotted** | ✅ **Survives** — but yields **STOP CONDITION B**, not a value |

⭐ **The number survived; the framing did not.** `3`, range `1–5`, unit *total attempts including the
first*, floor `≥ 1`, and the retry-storm finding are all **unchanged**.

---

## 45. ⛔⛔ DISPROOF 1 — a single deadline cannot express a deferrable notification

| Fact | Source |
|---|---|
| *"Quiet hours **MUST defer, never drop**, a deferrable notification."* | `NTF-FR-039` — subject **L423** |
| *"`deadline` bounds the **whole job**; on expiry the runtime moves it to `JobState.failed`"* | `job_runtime.dart` **L107-110** |
| Deadline re-checked **before every attempt**; on expiry → terminal `failed`, `reasonCode: deadline_exceeded` | `services.dart` **L190-201** |

⇒ ⭐⭐⭐ **A notification deferred overnight by quiet hours would exceed any delivery-sized deadline and
terminate `failed` — converting a "defer, never drop" obligation into a DROP.**

⇒ ⛔ **The transport clock and the notification's validity clock CANNOT be the same value.**
`NTF-CFG-007`, as I framed it at v0.5 (*"the whole-job bound"*), is **not one parameter**:

1. **Attempt/transport budget** — how long one delivery pipeline may run. *This* is what bounds
   `NTF-CFG-004`.
2. **Notification validity horizon** — how long a deferred-but-still-wanted notification remains worth
   sending. *This* is what `NTF-FR-039` and the `expired` state require.

⛔ **Neither is invented here.** The finding is that **the slot was under-specified by its own author**,
and a value chosen against the old framing would have silently broken a stated requirement.

---

## 46. ⛔ DISPROOF 2 — four lifecycle terminals, two runtime terminals

§18 declares `delivered | failed | expired | cancelled`. `JobState` has **two** terminal members, and
`failed` **conflates two causes**: *"Attempts exhausted, **or the deadline expired**"*
(`job_runtime.dart` **L62-63**).

⇒ ⛔ `expired` and `cancelled` have **no runtime representation**, yet **`NTF-FR-042`** (monotonicity)
and **`NTF-FR-064`** (observability of retry counts and failures) both require the distinction — the
same distinction `CONFIGURATION_GUIDE` **L892** insists on for `PRD-017`: *"objects moved to `FAILED`
**by timeout**, distinct from failure by error … a timeout failure is invisible to the student as a
**cause**."*

⭐ `JobOutcome.reasonCode` is the available carrier (`deadline_exceeded` vs `retries_exhausted`,
`services.dart` **L197** / **L226**) — but **the 2 → 4 mapping is an unmade architecture decision**,
not a value.

---

## 47. ⚠ DISPROOF 3 — quiet hours have no slot, and a Rank-1 / Rank-6 disagreement

| Measurement | Result |
|---|---|
| Quiet-hours parameters in §20.1 | ⛔ **ZERO** (0 occurrences of *"quiet"*) |
| Rank 1 | **`MP-GBR-35`**: quiet hours *"are owned by `BC-22` and apply to **every channel**"* |
| Rank 4 | BC Map **L131**: `BC-22` *"Owns … quiet hours"* |
| Rank 6 | EA **L1447**: *"Quiet Hours & DND **(V2)**"* |

⇒ ⭐ **`MP-CON-08`** governs: the EA is *"descriptive, not prescriptive"* and a disagreement is
*"**a defect to be raised, not a choice to be made**."* ⇒ **RAISED, not resolved.** ⛔ **No quiet
window invented; no slot minted** — minting one would presuppose the V1/V2 answer that `MP-CON-08`
reserves.

---

## 48. ⭐⭐⭐ Why this is STOP CONDITION B and not procedural caution

v1.5 said the number was blocked on two **unknown quantities** (deadline, provider timeout). That was
true but **incomplete**. The loop shows the real blocker is **categorical**:

> ⛔ **No arithmetic over any repository value can decide whether the delivery clock is ONE bound or
> TWO, or how four lifecycle terminals map onto two runtime terminals.** These are **classification**
> decisions, not measurements. A number supplied now would be attached to a parameter whose **meaning
> is not yet fixed**.

⭐ **This is a stronger and more useful result than "the value is owed"**: it identifies *why* no
further investigation can close it, and it names the **minimum** decision that unblocks everything.

---

## 49. The exact missing decisions — minimum set, in dependency order

| # | Decision | Owner | Unblocks |
|---|---|---|---|
| **1** | ⭐⭐ **Is the delivery clock ONE bound or TWO?** If two, split `NTF-CFG-007` into a transport budget and a validity horizon | **Architecture Owner** | `NTF-CFG-004`, `NTF-CFG-007`, `NTF-FR-039` |
| **2** | ⭐ **Map `JobState`'s 2 terminals onto §18's 4** (`reasonCode` is the available carrier) | **Architecture Owner** | `NTF-FR-042`, `NTF-FR-064`, `expired`/`cancelled` |
| **3** | **Transport budget value**, then `NTF-CFG-004` = **3** (range `1–5`) — ratified **in the same act**, on the `ADR-0057` precedent | **Architecture Owner** | Stage-4 check 3 |
| **4** | Quiet hours **V1 or V2** — the `MP-GBR-35` / EA **L1447** disagreement | **Architecture Owner** + **Product Owner** | `NTF-FR-039`, any quiet slot |
| **5** | Manifest: add `platform/services:job_runtime` to `platform/communication` — **`A-3` shape, no `L2` waiver** (rank 3 → rank 5 is downward) | **Architecture Owner** | Consumability |

⚠ **Decisions 1 and 2 are prerequisites for 3.** Supplying a number before them would fix a value
against an undefined parameter.

---

## 50. Unchanged confirmations

| Item | Status |
|---|---|
| **Retry unit** | ✅ **Total attempts including the first** — `job_runtime.dart` **L104-106** (rank 0) |
| **Floor** | ✅ **`≥ 1`**, executable — `services.dart` **L152-159**, citing `INV-21` |
| **`NTF-FR-047`** | ✅ **CONFIRMED** — transient retry; permanent terminates `failed` |
| **`NTF-INV-011` / `CM-3` / `EBR-1030`** | ✅ **CONFIRMED** — `module_dependencies.yaml` **L409-410**; isolation preserved |
| **Idempotency** | ✅ Duplicate `JobKey` runs work **exactly once** — `services.dart` **L163-165**; pinned by executing test |
| **Backoff** | ⛔ **OWED** — 0 schedules at Rank 1–5; adapter implements none; EA **L1808** places it at **V2** |
| **`NTF-GAP-025` (DLQ)** | ⚠ **OPEN, NON-BLOCKING** — post-exhaustion handling only, does not change attempt count |
| **Recommendation** | ⭐ **`3`, range `1–5`** — survives, `[RECOMMENDED — NOT AUTHORITATIVE]` |

---

## 51. Verdict

⛔⛔ **STOP CONDITION B — PROVEN INSUFFICIENCY.** The exact deadline **cannot** be derived, and the
retry budget **cannot** be finalised, because `NTF-CFG-007`'s **meaning** is undecided — not because
its number is unknown.

Check 3: **1 of 7 satisfied** · **1 unit+floor authoritative with a surviving recommendation** ·
**5 owed**. Stage 3 **PASS 6/6**. **27 gaps OPEN.** Stage 4 **NOT READY, NOT CONFERRED**.

⛔ **0 values invented · 0 slots minted · 0 gaps closed · 0 renumbered · 0 ADRs (94) · 0 manifest ·
0 BC Map · 0 `MASTER_PRD` · 0 EA · 0 frozen PRDs · 0 `CONFIGURATION_GUIDE` · 0 baseline · 0 registry ·
0 application code · 0 test code.**

---

## 52. Change history

| Version | Date | Change |
|---|---|---|
| **v1.6** | 2026-09-05 | ⛔⛔ **ADVERSARIAL LOOP RUN AGAINST MY OWN v1.5 POSITION — THE NUMBER SURVIVES, THE FRAMING IS DISPROVED, AND THE RESULT IS STOP CONDITION B.** Confirmed unchanged: unit (**total attempts incl. first**), floor (**`≥ 1`**, executable), the **`3` / range `1–5`** recommendation, and the retry-storm finding. ⛔ **Three coupled structural defects found that v1.5 never contemplated.** ⭐⭐⭐ **DISPROOF 1 — a single `JobRuntime` deadline CANNOT express a deferrable notification:** `NTF-FR-039` demands quiet hours *"**defer, never drop**"* and quiet hours are **hours**, while the runtime deadline *"bounds the **whole job**; on expiry … `JobState.failed`"* (`job_runtime.dart` **L107-110**, re-checked per attempt at `services.dart` **L190-201**) ⇒ a notification deferred overnight would terminate `failed`, **converting a defer obligation into a DROP** ⇒ ⛔ **the transport clock and the validity clock cannot be one value**, so **`NTF-CFG-007` was UNDER-SPECIFIED BY ITS OWN AUTHOR at v0.5** and must be split into an **attempt/transport budget** and a **notification validity horizon**; ⛔ neither invented. ⭐⭐ **DISPROOF 2 — four lifecycle terminals, two runtime terminals:** §18 declares `delivered`/`failed`/`expired`/`cancelled` but `JobState` has **two**, and `failed` **conflates** *"attempts exhausted, **or the deadline expired**"* (**L62-63**) ⇒ `expired` and `cancelled` have **no runtime representation** although `NTF-FR-042` and `NTF-FR-064` require the distinction — the same one `CONFIGURATION_GUIDE` **L892** insists on for `PRD-017` (*"by timeout, distinct from failure by error"*); ⭐ `JobOutcome.reasonCode` is the available carrier but **the 2→4 mapping is an unmade architecture decision**. ⚠ **DISPROOF 3 — quiet hours have ZERO slots** (measured 0 occurrences of *"quiet"* in §20.1) although **Rank-1 `MP-GBR-35`** and **BC Map L131** assign them to `BC-22`, while **EA L1447** places them at **V2**; **`MP-CON-08`** makes that *"a defect to be **raised**, not a choice to be made"* ⇒ **raised, not resolved**, ⛔ **no window invented, no slot minted** (minting would presuppose the V1/V2 answer). ⇒ ⭐⭐⭐ **STOP CONDITION B, and stronger than v1.5's result:** v1.5 blamed two **unknown quantities**; the loop shows the blocker is **CATEGORICAL** — *no arithmetic over any repository value can decide whether the clock is one bound or two, or how four terminals map onto two*. A number supplied now would attach to a parameter **whose meaning is not yet fixed**. ⭐ **`NTF-GAP-027` minted** carrying all three defects; **five minimum Architecture Owner decisions** published in dependency order, with **1 and 2 as prerequisites for 3**. ✅ Confirmed unchanged: `NTF-FR-047`, `NTF-INV-011`/`CM-3`/`EBR-1030` (isolation preserved), idempotent `JobKey` (`services.dart` **L163-165**, test-pinned); ⛔ **backoff stays OWED**; ⚠ **`NTF-GAP-025` NON-BLOCKING**; ⭐ manifest amendment is **one line, `A-3` shape, NO `L2` waiver** (rank 3 → rank 5 downward). ⛔⛔ **0 values invented, 0 slots minted (CFG stays 7), 0 gaps closed (27 OPEN), 0 identifiers renumbered, 0 requirements reworded, 0 ACs changed, 0 lifecycle states altered, 0 ADRs (94), 0 manifest, 0 BC Map, 0 MASTER_PRD, 0 EA, 0 frozen PRDs, 0 CONFIGURATION_GUIDE, 0 baseline, 0 registry, 0 application code, 0 test code.** Stage 4 **NOT READY, NOT CONFERRED**; Stage 3 **PASS 6/6**. §1-43 preserved byte-identical (`cmp` PASS). |
