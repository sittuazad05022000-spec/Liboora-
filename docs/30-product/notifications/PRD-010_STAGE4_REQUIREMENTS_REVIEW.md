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
