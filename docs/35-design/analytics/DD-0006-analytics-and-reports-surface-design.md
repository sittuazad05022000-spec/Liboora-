<!-- LIBOORA Design Doc | DD-0006 | BC-26 Analytics Read Model -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, metrics, data
> sources or backend contracts.

# `DD-0006` — Analytics & Reports surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0006` |
| **Version** | **v0.1** |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-26` Analytics Read Model** — `[GENERIC]`, capability tier `BC-19→31`, tenant-aware, **V1** |
| **Subject PRD** | `PRD-009` Analytics & Reports — **`FROZEN` v0.6**, Rank 3, admitted by `Accepted` `ADR-0113` on 2026-09-05 |
| ⭐⭐ **Governing metric authority** | **`ADR-0097`** (Rank 2, **Accepted**) — the **only** `CertifiedMetric` defined anywhere in this repository is **`ProfileViews`**; **`UniqueViewers` is expressly NOT certified and MUST NOT be rendered.** See §10 |
| **Preceded by** | ⭐ The **BC-26 Analytics & Reports Design Readiness Audit**, verdict **REQUIRED WITH EXPLICIT DESIGN GAPS**, followed by an accepted **design-scope expansion** governance check (verdict **SCOPE EXPANSION AUTHORIZED**) |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Purpose** | Specify the `BC-26` surfaces precisely enough that a Figma prototype could be built **without inventing UX, metrics or data sources** |
| **Verdict** | ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS** — §24. ⛔ **The Figma gate is NOT OPEN** (§23) |

---

## 1. Document Identity

### 1.1 What this document does

It specifies the **presentation and interaction behaviour** of the surfaces
`PRD-009` requires, at the fidelity a Figma author or a Flutter implementer
needs in order to build **without guessing**.

### 1.2 ⛔⛔ What this document does NOT do

| ⛔ Not done | Why |
|---|---|
| ⛔ Create a metric | ⭐⭐ **`BC-26` is the sole metric authority** (BC Map **L135**, **L385**); a Design Doc is UNRANKED. §10 records **1** certified metric and **13** uncertified candidates — ⛔ it certifies none |
| ⛔ Create a metric **formula** | ⛔⛔ Rank 1 **`MP-GBR-36`** and manifest assertion **`AN-2`** |
| ⛔ Create a data source | ⛔ **`ANL-XC-011`**; the 24 routed events are the closed input set (§15.4) |
| ⛔ Create a permission or role | ⛔ `ANL-BR-004`; the scope register is closed by `MP-GBR-21` |
| ⛔ Expand V1 | ⛔ `PRD-009` §43 governs phasing; ⛔ nothing here promotes a V2/V3 item |
| ⛔ Resolve a conflict or gap | ⛔ §19 preserves **25** gaps; §20 preserves **2** conflicts and **9** open decisions |
| ⛔ Modify a PRD or ADR | **0 bytes** of either changed |
| ⛔ Change BC ownership | ⛔ Dashboards stay **compositions**; `BC-22` keeps delivery; `BC-05` keeps financial facts |
| ⛔ Fix implementation deviations | §18 records **7**, fixes **0** |
| ⛔ Create a Figma artifact | ⛔ §23 — the gate is **BLOCKED** |

### 1.3 ⭐⭐ Why `BC-26` needs a Design Doc — and why this is the FIRST context added since the README's original six

⛔ `docs/35-design/README.md` §2 declared six context directories and **no
`analytics/`**. ⭐ That was not a prohibition. §2 states the rule directly:

> *"**New contexts get a new subdirectory when a Design Doc for them is actually
> written** — not pre-emptively."*

⭐ The directory `docs/35-design/analytics/` was therefore created **at the
moment this document was written**, which is precisely what §2 prescribes. ⭐
README §2B.7 independently confirms the design rules apply to *"**ALL** future
Design Docs"*, not only the five already written.

⚠️ **A correction to my own earlier advice is recorded here rather than
quietly dropped.** The BC-26 readiness audit recommended obtaining a
Product-Owner authorisation before adding a seventh context directory.
⛔ **Measured against §2, §2B.7 and §2A.2 rule 1, that advice was wrong** — no
rule restricts the context set, and a search for restriction language
(`closed list`, `only these`, `six context`, `may not add`, `must not add`)
returned **0 matches**. The prior recommendation is withdrawn, not defended.

### 1.4 ⭐ Skill disposition — 20 mandated perspectives

Each expert below produced a **finding**, recorded in §3 and cross-referenced
into the section that carries it. ⛔ None was decorative. ⭐ **Five refusals are
recorded**, because an expert who never declines is not being consulted.

| # | Perspective | Disposition |
|---|---|---|
| 1 | Product Manager | ⭐ APPLIED — §5, §9 |
| 2 | Business Analyst | ⭐ APPLIED — §9, §21 |
| 3 | Senior UI/UX Designer | ⭐ APPLIED — §9, §14 |
| 4 | UX Researcher | ⚠️ **PARTLY REFUSED** — ⛔ no user research exists in this repository; `ANL-GAP-008`/`-009` are marked **`[EXPERIMENT REQUIRED]`** by the PRD itself |
| 5 | Student / User Experience | ⭐ APPLIED — §9.1, §13 |
| 6 | **Psychologist** | ⭐ APPLIED — §13 |
| 7 | Behavioural Science / Behavioural UX | ⭐ APPLIED — §13.6 |
| 8 | Indian User & Cultural UX | ⚠️ **PARTLY REFUSED** — ⛔ `ANL-GAP-014` records the PRD *declining to assume Indian users want PDFs*; I do not overturn that. §6 |
| 9 | Indian Market / SaaS | ⚠️ **PARTLY REFUSED** — market claims marked **hypothesis**, never requirement. §6.3 |
| 10 | **Data Visualization** | ⭐ APPLIED — §14 |
| 11 | Information Architecture | ⭐ APPLIED — §9.5 |
| 12 | Accessibility | ⚠️ **PARTLY REFUSED** — ⛔ `ANL-GAP-017`: *"no repository accessibility standard exists"*. §16 classifies, ⛔ does not ratify |
| 13 | Interaction Design | ⭐ APPLIED — §12, §14.4 |
| 14 | Mobile Design | ⭐ APPLIED — §6.1, §14.3 |
| 15 | Data / Financial Trust UX | ⭐ APPLIED — §11 |
| 16 | RBAC & Security | ⭐ APPLIED — §8, §7 |
| 17 | Multi-Tenant SaaS | ⭐ APPLIED — §8.4 |
| 18 | Analytics / Data Architecture | ⭐ APPLIED — §10, §17 |
| 19 | QA / Testability | ⭐ APPLIED — §21.3, §18 |
| 20 | Customer Success / Library Operations | ⭐ APPLIED — §9.2, §13.5 |

---

## 2. Authority & Source Order

⭐ Applied in this order. ⛔ A lower rank never overrides a higher one.

| Rank | Source | Applied as |
|---|---|---|
| **1** | `MASTER_PRD.md` — **`MP-GBR-36`** *(no dashboard defines its own formula)*, **`MP-GBR-37`** *(no domain-table read; rebuildable)*, **`MP-GBR-38`** *(no projection is a system of record)*, **`MP-GBR-21`** *(closed 3-scope register)*, **`MP-GBR-24`** *(student fees ≠ SaaS revenue)*, §6 **L105–111** roles | ⛔⛔ **Binding on every metric and every surface** |
| **2** | ⭐⭐ **`ADR-0097`** Accepted — `ProfileViews` **CERTIFIED**, `UniqueViewers` **NOT** | ⛔⛔ **GOVERNS** every metric-rendering decision — §10, §14.6 |
| **2** | `ADR-0096` Accepted — edge **`E-30`**, event `tenancy.LibraryProfileViewed`, payload boundary | Provenance and the reason `UniqueViewers` is uncomputable |
| **2** | `ADR-0113` Accepted — `PRD-009` v0.6 admitted at **Rank 3** | Freeze authority |
| **2** | `ADR-0112` Accepted — Architecture reviewer, Stage-3 **only** | ⚠️ Scope note; confers nothing here |
| **3** | **`PRD-009` FROZEN v0.6** — 58 FR · 6 BR · 9 INV · 12 XC · 17 AC · 8 CFG · 25 GAP · 9 OBD | ⭐ **Every surface requirement in this document** |
| **4** | BC Map v1.11 — **L135** ownership · **L385** aggregate/invariants · **L405–438** events · **L453** replay · **L490** tenant partitioning · **§17** `E-30` | Ownership, aggregate, event inputs |
| **4** | `tool/module_dependencies.yaml` **L303–329** — `rank: 7`, 5 downward ports, `excluded_events: ["iam.*"]`, `AN-1`/`AN-2`/`AN-3` | ⛔ Mechanical constraints; ⛔ **no amendment requested** |
| **6** | Enterprise Architecture | ⚠️ **DESCRIPTIVE ONLY** (`MP-CON-08`) |
| — | `DD-0001`…`DD-0005` | ⚠️ UNRANKED peers — consistency only (§19.4, §17.5) |
| — | UI/UX Pro Max @ `15de38f` | ⚠️ Methodology only — §7 |

### 2.1 ⚠️ Status nuance, resolved by rule — not by preference

`PRD-009`'s own header reads **`Status | DRAFT` — *"not ranked, not baselined,
not frozen"*** and **`Authority claimed | NONE`**.

⭐ **`PRD_REGISTRY.md` §2.1 governs:** *"No PRD in this repository declares
itself frozen… Freeze is therefore **not self-declared**"* — it is conferred
externally by admission to the baseline.

| Measurement | Value |
|---|---|
| `ADR-0113` status | ⭐ **Accepted**, 2026-09-05 |
| `DOCUMENTATION_BASELINE.md` **L217** | ⭐ *"**Authoritative** — the Analytics & Reports baseline"* |
| `PRD_REGISTRY.md` **L246** | ⭐ **`FROZEN`**, Rank 3 |

⭐ **It IS FROZEN at Rank 3.** ⛔ Not a conflict. ⚠️ This is the **second**
occurrence of this exact pattern — `PRD-008` carried it too (`DD-0005` §2) —
so it is resolved the same way, by the same rule.

⚠️⚠️ **But freeze confers AUTHORITY, not completeness**, and the baseline row
says so in terms: **25/25** `ANL-GAP-*` OPEN · **F-1**, **F-2**, **F-3**,
`ANL-AL-B1` OPEN · **0 of 17** acceptance criteria proven · **8 of 32**
Stage-6 tasks BLOCKED. ⛔ *"A frozen specification, not a shippable
capability."* **This document designs against the specification and inherits
every one of those openings.**

### 2.2 ⛔ Excluded as authority

| Excluded | Why |
|---|---|
| ⛔ `PRD-009` §44.3, §44.6 | ⚠️ Marked **SUPERSEDED, retained verbatim** by the PRD itself — ⛔ not operative |
| ⛔ `lib/platform/analytics/analytics.dart` | ⛔⛔ **CODE IS NOT PRODUCT AUTHORITY** — §18 |
| ⛔ BC Map **L434** (`iam.*` → `BC-26`) | ⚠️ **CONTESTED** — §20.1; the safe side is `ANL-XC-012` |
| ⛔ `PRD-009` §46 traceability specimen | ⚠️ Self-described *"specimen"*; Stage 5 registration is separate |
| ⛔ Readiness-audit surface **categories** | ⛔ §9 **recalculates** the inventory from `PRD-009`; §22 reconciles the difference |

---

## 3. 20-Expert Review Panel — findings, with evidence separated from opinion

⭐ Each row states a **finding**, its **class**, and where it is carried.
⛔ **No expert created a product requirement.** Classes: **A** = PRD/ADR
requirement · **B** = existing GAP/TBD · **C** = design guidance ·
**D** = unsupported ⇒ refused or routed.

| # | Expert | Finding | Class | Carried |
|---|---|---|---|---|
| 1 | Product Manager | ⭐⭐ **The product's most valuable analytics surface is the one with the least data**: `PRD-009` §12.2 measures **0** learning-outcome events. Student analytics can honestly report **presence and consistency** only | **A** | §9.1, §19 **F-2** |
| 2 | Business Analyst | ⭐ **13 candidate metrics are named across §12.1 and §18–21; exactly 1 is certified.** A surface cannot be declared buildable on an uncertified number | **A** | §10 |
| 3 | Senior UI/UX Designer | ⭐ `ANL-FR-035` inverts the usual dashboard grammar: *"Every screen **MUST** lead with a plain-language summary **before any chart**"* — prose is the primary element, the chart is secondary | **A** | §14.1 |
| 4 | UX Researcher | ⚠️ **REFUSED to supply preference evidence.** `ANL-GAP-008` (notification frequency) and `ANL-GAP-009` (guardian-visible progress) are marked **`[EXPERIMENT REQUIRED]`** and ⛔ *"must not be assumed"* | **B** | §13.7 |
| 5 | Student Experience | ⭐ `ANL-FR-024` — *"Analytics **MUST NOT** be mandatory to use the app"*. ⇒ ⛔ No analytics surface may be a forced interstitial, onboarding step or dismissal-blocking modal | **A** | §12.4 |
| 6 | **Psychologist** | ⭐⭐ `ANL-FR-018` forbids the single most common analytics defect: *"never a zero presented as a score"*. ⭐ A new student's screen is a **design problem, not a data problem** | **A** | §13.2 |
| 7 | Behavioural UX | ⭐ `ANL-FR-021` — a broken streak **MUST NOT** be loss-framed **and MUST NOT be the primary progress signal**. ⇒ ⛔ streak cannot be the hero element | **A** | §13.3 |
| 8 | Indian Cultural UX | ⚠️ **PARTLY REFUSED.** `ANL-GAP-014` records the PRD *"declining to assume Indian users want PDFs"*. ⛔ I do not overturn a deliberate refusal to reach a conclusion | **B** | §6.2 |
| 9 | Indian Market / SaaS | ⚠️ **PARTLY REFUSED.** `ANL-GAP-019` — Liboora School/College/Coaching *"do not exist in the repository"*. ⭐ V1 must **avoid blocking** them, not design for them | **B** | §6.3 |
| 10 | **Data Visualization** | ⭐⭐ `ANL-FR-042` — *"Every chart **MUST** have a text or table equivalent"* — makes the table the **accessible source of truth**, not a fallback. ⭐ Aligns with UI/UX Pro Max `charts.csv` A11y-fallback column | **A** | §14.2 |
| 11 | Information Architecture | ⭐ Two mandated information orders exist and they differ: **`Today → Progress → Motivation → Detail`** (§15, student) and **`Status → Attention → Action → Analysis`** (`ANL-FR-027`, staff). ⛔ They must not be merged | **A** | §9.5 |
| 12 | Accessibility | ⚠️ **PARTLY REFUSED.** `ANL-FR-041`/`-042`/`-043` are binding, but `ANL-GAP-017` measures *"no repository accessibility standard exists"* for **contrast and type scale**. ⛔ I classify; ⛔ I do not ratify a number | **A** + **B** | §16 |
| 13 | Interaction Design | ⭐ `ANL-FR-028` requires every *attention* item to name **metric + threshold crossed + drill-down path**. ⚠️ The drill-down **destination** is nowhere specified | **A** + **B** | §9.3 `B4`, §21.2 |
| 14 | Mobile Design | ⭐ `ANL-FR-034` — readable on a small screen *"**without horizontal scroll**"*. ⇒ ⛔ no wide data grid, ⛔ no pinch-zoom chart as the only affordance | **A** | §6.1 |
| 15 | Data / Trust UX | ⭐⭐ `ANL-INV-008`/`-009` + `ANL-FR-056`: freshness is **not** an optional badge — *"no analytic output presents stale data as current"* and *"every output carries the freshness of its underlying projection"* | **A** | §11 |
| 16 | RBAC & Security | ⛔⛔ **`ANL-OBD-003` — the exact per-role metric visibility matrix is OPEN and OWED** to Product Owner + `BC-18`. ⇒ §8's matrix is **structural**, ⛔ not a permission grant | **B** | §8.2 |
| 17 | Multi-Tenant SaaS | ⛔⛔ **Measured code defect:** `_feed` and `_attendanceDays` are **not tenant-partitioned**, against `ANL-INV-006` and BC Map **L490**. ⛔ Recorded as evidence; ⛔ not fixed | **A** vs code | §18 `AIV-A02` |
| 18 | Analytics Architecture | ⛔⛔ **F-1 stands: there is no semantic layer.** ⇒ ⭐ **This document MUST NOT depict a completed semantic layer**, and §10 does not | **A** | §10.1, §19 **F-1** |
| 19 | QA / Testability | ⛔ **0 of 17** `ANL-AC-*` proven; ⛔ **0** surface tests exist for `BC-26`. ⭐ `every_projection_rebuildable_test.dart` proves *rebuild*, ⛔ not any surface | **A** | §21.3 |
| 20 | Customer Success / Ops | ⭐ Reception's need is *"immediate actionable context"* (§21) — ⛔ `ANL-XC-005` makes aggregate financial analytics **impossible** for that role, so the surface is narrow **by design** | **A** | §9.2 `B1` |

### 3.1 ⭐ Five refusals, stated plainly

⛔ Experts **4, 8, 9, 12** and **the Data Visualization expert's forecast
recommendation** declined to supply an answer the repository does not contain:

| Refusal | What was declined | Why |
|---|---|---|
| **R-1** | User-preference evidence for streaks / guardian visibility | ⛔ `ANL-GAP-008`, `ANL-GAP-009` — **`[EXPERIMENT REQUIRED]`** |
| **R-2** | *"Indian users prefer PDF exports"* | ⛔ `ANL-GAP-014` — the PRD expressly declines this |
| **R-3** | Multi-product (School/College) surface design | ⛔ `ANL-GAP-019` — those products do not exist |
| **R-4** | A contrast ratio and type scale | ⛔ `ANL-GAP-017` — no ratified standard |
| **R-5** | ⭐ A **forecast / predictive trend** visualization | ⛔ `PRD-009` §50 lists *predictive/ML forecasting* as an **explicit non-requirement**; UI/UX Pro Max `charts.csv` **#9** *(Line with Confidence Band)* is therefore **REJECTED** — §7 |

---

## 4. Scope / Non-Scope

### 4.1 ⭐ In scope

⭐ Derived from `PRD-009` §7 *"In scope"* and §43's **V1** row, **restricted to
what has a surface**. See §9.

| `BC-26` V1 capability | Has a surface? | Where |
|---|---|---|
| Reception / Manager / Owner decision surfaces | ⭐ **YES** | `B1`, `B2`, `B3` |
| Student presence & consistency (`self`) | ⭐ **YES** | `A1`, `A2`, `A4` |
| `AnalyticalReport` | ⚠️ **PARTIAL** | `B5` |
| Authorized export + audit fact | ⚠️ **PARTIAL** | `B6` |
| Freshness & partial-data disclosure | ⭐ **YES** — cross-cutting | §11, §12 |
| Semantic layer + Certified Metric registry | ⛔ **NO SURFACE** | ⭐ Backend capability; §10.1 |
| Projections over the 24 events | ⛔ **NO SURFACE** | ⭐ Backend capability |
| Permission-aware query port | ⛔ **NO SURFACE** | ⭐ An API, consumed by dashboards |

⭐⭐ **Four of nine V1 capabilities have NO user surface at all.** ⛔ That is not
an omission — a semantic layer, a projection and a query port are backend
capabilities. ⚠️ **This is the single most important reason the surface count in
§9 is smaller than a reader of the V1 row might expect**, and §22 reconciles it.

### 4.2 ⛔ Out of scope — each with its authority

| # | Excluded | Authority | ⛔ Not invented by me |
|---|---|---|---|
| 1 | ⛔⛔ **Learning / mastery / academic analytics** | ⛔⛔ **F-2** + `ANL-XC-001` + `ANL-GAP-003`…`-006` | Frozen PRD |
| 2 | ⛔⛔ **Leaderboards, peer ranking, peer comparison** | ⛔⛔ **F-3** + `ANL-XC-004` — **impossible** under `MP-GBR-21` | Rank 1 |
| 3 | ⛔⛔ **Dashboard composition** (modules 10–12) | ⛔⛔ BC Map **L84** — *"**not contexts**… presentation compositions"*; `PRD-009` **NG-2**, §22 | Rank 4 + Rank 3 |
| 4 | ⛔⛔ **Dashboard-owned calculations** | ⛔⛔ `MP-GBR-36` + `ANL-BR-003` + `ANL-FR-029` — *"dashboards… **MUST NOT** compute their own values"* | Rank 1 |
| 5 | ⛔⛔ **`iam.*`-derived metrics** | ⛔⛔ `ANL-XC-012` + manifest `AN-3`; `ANL-AL-B1` **OPEN** | Rank 3 + Rank 4 |
| 6 | ⛔ Platform analytics · APP 3 surfaces | ⛔ `ANL-INV-006` + `AUTH-2.5` — §5.1 | Rank 1 + Rank 3 |
| 7 | ⛔ Cross-tenant analytics / benchmarking | ⛔ `ANL-INV-006` — *"a cross-tenant read is **impossible**"*; §50 | Frozen PRD |
| 8 | ⛔⛔ **Parent / guardian analytics** | ⛔⛔ `ANL-OBD-004` **HIGH RISK, OPEN** — *"**DECISION REQUIRED before any guardian-facing analytic ships**"* | Frozen PRD |
| 9 | ⛔ New metric formulas | ⛔ `MP-GBR-36`, `AN-2` | Rank 1 |
| 10 | ⛔ New data sources | ⛔ `ANL-XC-011`; the 24 routed events are closed | Frozen PRD |
| 11 | ⛔ New permissions / roles | ⛔ `ANL-BR-004`; `ANL-OBD-003` **OPEN** | Frozen PRD |
| 12 | ⛔ Notification delivery & scheduled reports | ⛔ `ANL-XC-007`, `ANL-XC-009` — **unconstructable**: ⭐ the manifest declares **no** communication port | Rank 4 |
| 13 | ⛔ Anonymised cohort bands | ⛔ **BLOCKED** on `ANL-OBD-002` + `ANL-GAP-010` | Frozen PRD |
| 14 | ⛔ Filters · drill-down · saved views | ⛔ **V2** — `PRD-009` §44.4; `ANL-OBD-009` OPEN | Frozen PRD |
| 15 | ⛔ Branch / campus hierarchy analytics | ⛔ `ANL-GAP-025` — ⭐ no sub-tenant unit exists in the BC Map | Frozen PRD |
| 16 | ⛔ AI narrative summaries / NL query | ⛔ **V3**; bounded by `ANL-XC-010` | Frozen PRD |
| 17 | ⛔ Real-time streaming analytics | ⛔ §50 explicit non-requirement | Frozen PRD |
| 18 | ⛔ Predictive / ML forecasting | ⛔ §50 explicit non-requirement — ⭐ **R-5** | Frozen PRD |
| 19 | ⛔ Custom report builder · data-warehouse export | ⛔ §50 explicit non-requirements | Frozen PRD |
| 20 | ⛔ External platform ingestion | ⛔ `ANL-XC-011` — scraping/surveillance **impossible** | Frozen PRD |
| 21 | ⛔ Activity feed as a certified surface | ⚠️ `ANL-OBD-007` **OPEN** — ⭐ is `feed()` a metric at all? §9.4 |

### 4.3 ⭐⭐ The dashboard test — applied, not asserted

⛔ The brief warns: *"If a proposed screen behaves like a dashboard, classify it
as dashboard scope rather than renaming it Analytics."* ⭐ **That test was
applied to every staff surface**, using a two-question instrument:

| Question | If YES ⇒ |
|---|---|
| **Q1** — Does the surface **compute** any displayed value itself? | ⛔ **Dashboard-owned calculation — PROHIBITED** (`ANL-FR-029`) |
| **Q2** — Does the surface exist only to **compose tiles** from several contexts for situational awareness? | ⛔ **Dashboard scope — modules 10–12, NOT `BC-26`** |

| Candidate surface | Q1 | Q2 | Classification |
|---|---|---|---|
| Reception "who is inside now" readout | ⛔ NO — reads certified values | ⚠️ **YES** | ⛔⛔ **DASHBOARD SCOPE** — see `B1` note |
| Manager attention queue | ⛔ NO | ⛔ **NO** — it is an *analysis* surface with drill-down (`ANL-FR-028`) | ⭐ **`BC-26`** |
| Owner trend surface | ⛔ NO | ⛔ **NO** — trend analysis over periods | ⭐ **`BC-26`** |
| Student Today | ⛔ NO | ⚠️ **PARTLY** | ⚠️ **`BC-26` read surface** — §9.1 |
| `AnalyticalReport` | ⛔ NO | ⛔ NO | ⭐ **`BC-26`** (`ANL-FR-030`) |

⭐⭐ **The result changed the inventory.** `B1` Reception is retained but
explicitly marked ⚠️ **DASHBOARD-ADJACENT**: `insideNow` and `seatsOccupied` are
tiles for *situational awareness*, which BC Map **L84** assigns to a
**composition**, not a context. ⛔ Renaming a dashboard "Reception Analytics"
would be the exact defect the brief names. → `DD6-TBD-006`.

---

## 5. App Boundary

⭐ Per README §2B.3, all five declarations are stated.

| # | Declaration | Value |
|---|---|---|
| **1** | **Target App** | ⭐ **APP 1** (Student App) **+ APP 2** (Library App). ⛔⛔ **APP 3 = 0 surfaces** |
| **2** | **Target Roles** | ⭐ APP 1: `TR-4` Student · ⛔ `TR-5` Parent **EXCLUDED** (§5.2). ⭐ APP 2: `TR-1` Owner · `TR-2` Manager · `TR-3` Reception |
| **3** | **Permission Scope** | ⚠️ **`PRD-009` §18–21 role table + `ANL-XC-005`** — ⛔⛔ **the exact matrix is `ANL-OBD-003`, OPEN and OWED**. §8 is structural only |
| **4** | **Tenant scope** | ⭐ **Tenant-scoped throughout** — `ANL-INV-006`; `MP-GBR-21` scopes `self` / `tenantWide` only in V1 |
| **5** | **Cross-app dependencies** | ⭐ **One, read-only and one-directional** — §5.3 |

| App | In scope? | Roles | Code home |
|---|---|---|---|
| ⭐ **APP 1 — Student App** | ⚠️ **PARTIAL** | ⭐ `TR-4` Student **only** | `lib/app/student/student/` |
| ⭐ **APP 2 — Library App** | ⭐ **YES** | `TR-1` Owner · `TR-2` Manager · `TR-3` Reception | `lib/app/staff/{owner,manager,reception}/` |
| ⛔⛔ **APP 3 — Platform Admin** | ⛔⛔ **NO — 0 surfaces** | — | — |

### 5.1 ⭐⭐ Why APP 3 = 0 — four independent sources

| # | Source | Text |
|---|---|---|
| 1 | ⭐⭐ **`ANL-INV-006`** | *"Every projection, metric, report and export is tenant-scoped; **a cross-tenant read is impossible**"* |
| 2 | ⭐ **`ANL-INV-007`** | Visibility confined to **`self`, `guardianOf`, `tenantWide`** — ⛔ **no platform scope exists in the register** |
| 3 | ⭐ **`AUTH-2.5`** (`PRD-001`) | *"Platform roles **MUST NOT** grant access to tenant business data"* |
| 4 | ⭐ `ANL-XC-008` | *"Analytics **MUST NOT** be a route to data the actor cannot access operationally"* |

⛔⛔ **Library Owner ≠ Platform Owner.** `TR-1` Owner holds *"complete business
control"* of **one tenant** (`MASTER_PRD.md` **L107**). ⭐ Every `BC-26` metric
is tenant-partitioned by BC Map **L490**, so a platform-level analytics view has
**no `BC-26` surface** — ⛔ and `ANL-INV-006` makes one **impossible**, not
merely unbuilt.

⚠️ **Noted and NOT designed:** `billing.*` and `ai.*` events (SaaS activations,
AI cost) *are* routed to `BC-26`. ⛔ Their natural audience is platform-level,
but `ANL-INV-006` confines every output to a tenant, and `ANL-BR-002` +
`MP-GBR-24` forbid mixing SaaS revenue with student fees. ⭐ **AI cost per
tenant** (`ANL-FR-048`) is lawful as a **tenant-scoped** figure only.
→ `DD6-TBD-007`.

### 5.2 ⛔⛔ Why `TR-5` Parent is EXCLUDED — and why this differs from `DD-0003`/`DD-0005`

⛔⛔ **This is a deliberate divergence from three sibling Design Docs**, and the
reason is a **frozen open decision**, not a design preference.

| Sibling | Parent treated as | Basis |
|---|---|---|
| `DD-0003` Attendance | ⭐ **IN scope** — 2 surfaces | `PRD-006` grants explicit parent read surfaces |
| `DD-0005` Fees | ⭐ **IN scope** — read-only | `FEE-FR-055` grants *"fee updates for guarded students only"* |
| ⛔⛔ **`DD-0006` Analytics** | ⛔⛔ **EXCLUDED — 0 surfaces** | ⛔⛔ **`ANL-OBD-004`** |

⭐ **`ANL-OBD-004`, verbatim, flagged HIGH RISK by the PRD itself:**

> *"The `parent` role is 'Attendance visibility, fee updates and important
> notifications'. ⭐ **That does not obviously extend to analytical aggregates or
> trend reports about a minor.** Whether `guardianOf` covers *derived analytics*
> is undecided. `[OWED — Privacy + BC-18]`. **DECISION REQUIRED before any
> guardian-facing analytic ships.**"*

⭐⭐ **The distinction is precise and it is the PRD's, not mine:** a parent may
lawfully see the **fact** that their child attended (`BC-03`) and the **fact** of
a fee due (`BC-05`). ⛔ Whether they may see a **derived trend** about a minor is
**undecided**. `PRD-009` §44.4 classifies guardian-facing analytics as **V2,
BLOCKED**; `ANL-RSK-03` rates the risk **HIGH** — *"guardian analytics
increasing pressure on a minor"*.

⛔ **Designing a parent analytics surface would resolve `ANL-OBD-004` by
implementation.** ⭐ That is the failure mode this document exists to avoid.

### 5.3 ⭐ Cross-app dependency — one, read-only

⭐ **APP 1 `TR-4` and APP 2 staff read from the same certified metrics.** ⛔ They
**MUST NOT** share a surface component.

⛔⛔ **Why:** `ANL-FR-016` confines the student to scope `self`; staff surfaces
are `tenantWide`. ⭐ A shared widget is how a tenant-wide figure eventually
renders on a student's screen — the `ANL-XC-008` defect. ⭐ `DD-0005` §3.3
reached the identical conclusion for `BC-05`, and the convention is reused.

### 5.4 ⭐ App-Boundary QA — the 13 checks (README §2B.5)

| # | Check | Result |
|---|---|---|
| 1 | Every surface assigned to exactly one app | ⭐ **PASS** — §9.6 |
| 2 | Every surface assigned to named roles | ⭐ **PASS** — §8.1 |
| 3 | No role invented | ⭐ **PASS** — 5 tenant roles; ⛔ 0 created |
| 4 | Parent inside APP 1, not separate | ⭐ **PASS** *(vacuously — Parent has **0** surfaces, §5.2)* |
| 5 | Student data scoped to self | ⭐ **PASS** — `ANL-FR-016`, `ANL-XC-002` |
| 6 | `TR-1`/`TR-2`/`TR-3` differences respected | ⚠️ **GAP** — ⛔⛔ `ANL-OBD-003` is **OPEN**; §8.2 is structural, ⛔ not a grant |
| 7 | Platform roles separated (`AUTH-2.5`) | ⭐ **PASS** — APP 3 = 0, four sources |
| 8 | Figma preserves boundaries | ⭐ **PASS by construction** — ⛔ gate is **BLOCKED** (§23) |
| 9 | No mixed-role shell | ⭐ **PASS** — §5.3 |
| 10 | Tenant scope explicit | ⭐ **PASS** — `ANL-INV-006` |
| 11 | Cross-app dependency named | ⭐ **PASS** — §5.3 |
| 12 | No permission inferred from visibility | ⭐ **PASS** — `ANL-BR-004` |
| 13 | Evidence cited per declaration | ⭐ **PASS** |

⭐ **12 of 13 PASS · 1 GAP** *(check 6, `ANL-OBD-003`)*.

⚠️⚠️ **The GAP is disclosed rather than rounded to a PASS.** ⛔ `DD-0003`,
`DD-0004` and `DD-0005` each recorded **13 of 13** because their PRDs carry a
**closed permission matrix** (`PRD-006`, `PRD-007` §28.2's 24 rows, `PRD-008`
§23's 10 rows). ⛔⛔ **`PRD-009` carries none** — it routes the matrix to
`ANL-OBD-003` as **DECISION REQUIRED**. ⭐ Claiming 13/13 here would mean
inventing the matrix.

---

## 6. Indian User, Market & Visual Review

### 6.1 ⭐ Mobile / Android-first — the binding requirements

| ID | Requirement | ⭐ Design consequence |
|---|---|---|
| ⭐⭐ **`ANL-FR-034`** | Readable on a small mobile screen *"**without horizontal scroll**"* | ⛔⛔ **No wide data grid.** A table with >3 columns becomes a **stacked list of labelled rows** (§14.2). ⛔ No pinch-zoom-only chart |
| ⭐⭐ **`ANL-FR-035`** | *"Every screen **MUST** lead with a plain-language summary **before any chart**"* | ⭐ **The summary sentence is element 1** on every surface. ⛔ A chart-first layout is a defect |
| ⭐ **`ANL-FR-036`** | Every label localizable — ⛔ *"no concatenated sentence fragments"* | ⛔⛔ **No string built by concatenation.** ⭐ Each label is one complete localizable unit (§14.5) |
| ⭐ **`ANL-FR-037`** | Currency **INR**-formatted; timestamps **IST** (`MP-CON-12`) | ⭐ §11.3 |

### 6.2 ⚠️ Indian-number presentation — a real design question, and its honest answer

⚠️ `ANL-FR-037` mandates *"INR-formatted"*. ⛔ It does **not** say whether that
means the **Indian digit grouping** convention (`₹1,20,000` — lakh/crore) or the
international convention (`₹120,000`).

| Option | Argument |
|---|---|
| Indian grouping `₹1,20,000` | ⭐ Familiar to Indian library owners; the convention in Indian financial documents |
| International `₹120,000` | ⭐ Dart's `NumberFormat` default for many locales; fewer localisation edge cases |

⛔⛔ **I decline to choose.** Measured: **0** occurrences of *lakh*, *crore* or
any digit-grouping rule in `PRD-009`, `MASTER_PRD.md` or the BC Map; ⭐ and
`ANL-GAP-013` already routes locale readiness to **`BC-25`**, stating
`BC-26` *"**consumes** locale and **MUST NOT** define it"*.
→ **`DD6-TBD-001`**, `[OWED — BC-25 + Product Owner]`.

⚠️ **And `ANL-GAP-014` is preserved, not overturned:** the PRD states ⛔ *"I
decline to assume Indian users want PDFs — that would be an unsupported cultural
assumption"*. ⭐ §15 therefore specifies export **behaviour** without a format.

### 6.3 ⚠️ Market observations — labelled hypothesis, never requirement

| Observation | Class | ⛔ Consequence |
|---|---|---|
| Library owners in small Indian libraries operate from a phone, not a desk | ⚠️ **HYPOTHESIS** | ⛔ Creates no requirement; ⭐ `ANL-FR-034` already mandates mobile readability independently |
| Owners distrust numbers they cannot trace to a source | ⚠️ **HYPOTHESIS** | ⭐ Already required by `ANL-FR-006` / `ANL-INV-009` — ⛔ the hypothesis adds nothing |
| Network is intermittent | ⚠️ **HYPOTHESIS** | ⭐ `ANL-FR-056` (stale disclosure) and `ANL-FR-054` (partial marking) already cover the **visible** behaviour. ⛔ **No offline analytics store is proposed** |
| Multi-product readiness (School/College/Coaching) | ⛔ **REFUSED — R-3** | ⛔ `ANL-GAP-019` — those products do not exist |

### 6.4 ⭐ Human-eye-catching through comprehension — the applied standard

⭐ Attention is earned by **comprehension**, ⛔ never decoration.

| ⭐ Required | ⛔ Prohibited, with authority |
|---|---|
| ⭐ Strong hierarchy — plain-language summary is the focal point | ⛔ Chart-first layout (`ANL-FR-035`) |
| ⭐ One clear focal point per surface | ⛔ A chart wall (`ANL-FR-027`) |
| ⭐ Readable typography; readable numbers | ⛔ Dense multi-column grids (`ANL-FR-034`) |
| ⭐ Useful whitespace | ⛔ Tile density for its own sake |
| ⭐ Meaningful visualization | ⛔⛔ **Decorative charts** (§14.1) |
| ⭐ Clear status/action hierarchy | ⛔ Undifferentiated metric lists (`ANL-FR-027`) |
| — | ⛔⛔ **Gamification** — `ANL-XC-003`, `ANL-FR-021`; §13.4 |
| — | ⛔⛔ **Decorative 3D** — §14.7 allocates **0** |
| — | ⛔ Excessive colour / gradient — ⭐ `ANL-FR-041` forbids colour-only meaning |
| — | ⛔ Animation implying live data — `ANL-INV-008`; §50 bars streaming |

---

## 7. ⭐ UI/UX Pro Max Review

⚠️ Reference only, `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT.
⛔⛔ **No adopted principle becomes a product requirement.** ⛔ Framework rows
targeting newer Flutter are not applicable (Liboora is **3.35.4**); ⛔ its
Riverpod guidance is **REJECTED** (measured dependency: **Provider 6.1.5+1**);
⛔ **no token, breakpoint or library recommendation is adopted**.

| Principle | `BC-26` relevance | Decision | Reason |
|---|---|---|---|
| ⭐⭐ `charts.csv` **A11y Fallback** column — *"Visible data table plus concise summary"* | ⭐⭐ Every chart | ⭐⭐ **ADOPT** | ⭐ Independently **already mandatory** — `ANL-FR-042` + `ANL-FR-035`. ⛔ Adopted as **method**, not as authority |
| `charts.csv` **#1** Trend over time → **Line chart** | `A2` Progress, `B3` Owner trend | ⭐ **ADOPT** | ⭐ Matches §3.5 `T1`'s certified rolling 7-day comparison |
| `charts.csv` **#1** *"Fewer than 4 data points ⇒ use a stat card"* | ⭐⭐ A new student has **0–2** days | ⭐⭐ **ADOPT** | ⭐⭐ Converges with `ANL-FR-018` from a different direction — §13.2 |
| `charts.csv` **#2** Compare categories → Bar, *"sort descending"* | `B2` attention queue | ⭐ **ADAPT** | ⚠️ Sort order must follow **threshold severity** (`ANL-FR-028`), ⛔ not magnitude |
| `charts.csv` **#3** Pie / donut — `risk:high` | Part-to-whole | ⛔⛔ **REJECT** | ⛔ *"accessibility-first context"* is a listed **When NOT to Use**; ⛔ `ANL-FR-041` forbids colour-only slices |
| `charts.csv` **#5** Heatmap *(activity by hour × day)* | Consistency over 30 days | ⚠️ **TBD** | ⚠️ Tempting for a study-consistency calendar, ⛔ but `risk:conditional` and **0** certified metric supports it — `DD6-TBD-002` |
| `charts.csv` **#8** Gauge — performance vs **target** | Student progress | ⛔⛔ **REJECT** | ⛔⛔ *"No target or benchmark exists"* is its own **When NOT to Use** — ⭐ and a target would be an invented goal (§13.4) |
| `charts.csv` **#9** Forecast with confidence band | — | ⛔⛔ **REJECT** | ⛔⛔ **R-5** — §50 bars predictive forecasting |
| `charts.csv` **#10** Anomaly detection with highlights | `B2` *"attendance anomalies"* (§20) | ⚠️ **TBD** | ⚠️ The PRD names *anomalies* but ⛔ defines **no** anomaly rule — `DD6-TBD-003` |
| `charts.csv` **#22** 3D spatial | — | ⛔⛔ **REJECT** | ⛔ *"standard business dashboards"* and *"mobile context"* are listed **When NOT to Use**; §14.7 = **0** |
| `charts.csv` **#23** Real-time streaming | — | ⛔⛔ **REJECT** | ⛔ §50 bars real-time streaming analytics |
| **#36** Contrast ≥ 4.5:1 | All metric text | ⚠️ **TBD** | ⛔⛔ `ANL-GAP-017` — **no ratified standard**; **R-4** |
| ⭐⭐ **#37** Never convey meaning by colour alone | ⭐⭐ Every state, every chart series | ⭐⭐ **ADOPT as methodology** | ⭐ **`ANL-FR-041` already mandates this** — the skill supplies *technique* (icon + text + line style), ⛔ not the rule |
| **#40** ARIA / accessible names for icon-only controls | Icon-only drill-down affordances | ⭐ **ADOPT** | ⭐ Supports `ANL-FR-043` |
| **#42** Content must make sense read aloud | ⭐ Screen-reader metric announcement | ⭐ **ADOPT** | ⭐ Directly serves `ANL-FR-043` *(name + value + freshness)* |
| **#44** Errors announced via live region | `E` error state | ⭐ **ADOPT** | ⭐ Presentation of an existing rule |
| **#78** Loading feedback matched to expected wait | `L` loading state | ⚠️ **TBD** | ⛔ No latency target exists — `ANL-GAP-021`, `ANL-NFR-04` |
| ⭐⭐ **#79** Empty states — *"guide users when no content exists"* | ⭐⭐ `A1`, `A2`, `A4`, `B5` | ⭐⭐ **ADOPT** | ⭐⭐ `ANL-FR-018` is **stronger** — ⛔ *"never a zero presented as a score"*. Skill = technique; PRD = rule |
| **#80** Error recovery — provide next steps | `E` state | ⭐ **ADOPT** | ⭐ Complements *"fail visibly"* (§41–42) |
| **#103** Dragging needs a single-pointer alternative | Chart brush / pan | ⭐ **ADOPT** | ⭐ Reinforces `ANL-FR-042`'s table equivalent |
| **#104** Target size ≥ 24 CSS px | Drill-down targets | ⚠️ **TBD** | ⛔ No ratified minimum — `DD6-TBD-004` |
| **#112** Text reflow at narrow widths | ⭐ `ANL-FR-034` | ⭐ **ADOPT** | ⭐ Mechanism for an existing requirement |
| **#99** Honour `prefers-reduced-motion` | Chart entry animation | ⭐ **ADAPT** | ⭐ Maps to Flutter `MediaQuery.disableAnimations`; ⛔ not the web API |
| **#46–#53** Web performance *(bundles, lazy-load, caching)* | — | ⛔ **REJECT** | ⛔ Web-only; Liboora is Android-first |
| **#6** Breadcrumbs | — | ⛔ **REJECT** | ⛔ Web pattern; mobile-first |
| **#7/#8** Riverpod state management | — | ⛔⛔ **REJECT** | ⛔ Contradicts measured **Provider 6.1.5+1** |
| Library recommendations *(Chart.js, D3, Recharts, ApexCharts)* | — | ⛔⛔ **REJECT — all** | ⛔⛔ **Every one is a JavaScript library.** ⭐ Liboora is Flutter; ⛔ and **no charting dependency exists** in `pubspec.yaml` — §17.3 |

⭐ **10 ADOPT · 3 ADAPT · 9 REJECT · 5 TBD.**

⭐⭐ **The most useful convergence, and it is recorded as convergence rather than
as authority:** `charts.csv` **#1** independently advises a **stat card** below
4 data points, and `ANL-FR-018` independently forbids *"a zero presented as a
score"*. ⭐ Two unrelated sources reach the same conclusion about a new
student's first screen. ⛔ The **rule** is `ANL-FR-018`'s; the skill only
confirms the technique is ordinary good practice.

---

## 8. Role × Surface × Permission Matrix

### 8.1 ⭐ The structural matrix — 11 surfaces × 5 roles

⛔⛔ **THIS MATRIX IS STRUCTURAL, NOT A PERMISSION GRANT.** ⭐ It records what
each surface *is for*, derived from `PRD-009` §15–§21. ⛔⛔ **The authoritative
per-role metric visibility matrix is `ANL-OBD-003` — OPEN and OWED to Product
Owner + `BC-18`.** ⛔ Nothing here grants, widens or infers a permission
(`ANL-BR-004`: *"a management **role MUST NOT** by itself grant data
visibility"*).

| Surface | `TR-4` Student | `TR-5` Parent | `TR-3` Reception | `TR-2` Manager | `TR-1` Owner | Scope |
|---|---|---|---|---|---|---|
| **`A1`** Student Today | ⭐ **self** | ⛔ **NO** | ⛔ NO | ⛔ NO | ⛔ NO | `self` |
| **`A2`** Student Progress | ⭐ **self** | ⛔ **NO** | ⛔ NO | ⛔ NO | ⛔ NO | `self` |
| **`A3`** Student Motivation | ⚠️ **self** | ⛔ **NO** | ⛔ NO | ⛔ NO | ⛔ NO | `self` |
| **`A4`** Student Detail *(own history + own dues)* | ⭐ **self** | ⛔ **NO** | ⛔ NO | ⛔ NO | ⛔ NO | `self` |
| **`B1`** Reception Now ⚠️ *dashboard-adjacent* | ⛔ NO | ⛔ NO | ⭐ **YES** | ⭐ YES | ⭐ YES | `tenantWide` |
| **`B2`** Manager Attention | ⛔ NO | ⛔ NO | ⛔⛔ **NO** | ⭐ **YES** | ⭐ YES | `tenantWide` |
| **`B3`** Owner Trends | ⛔ NO | ⛔ NO | ⛔⛔ **NO** | ⚠️ **TBD** | ⭐ **YES** | `tenantWide` |
| **`B4`** Metric Detail / drill-down | ⛔ NO | ⛔ NO | ⛔ NO | ⭐ YES | ⭐ YES | `tenantWide` |
| **`B5`** `AnalyticalReport` | ⛔ NO | ⛔ NO | ⚠️ **TBD** | ⭐ YES | ⭐ YES | `tenantWide` |
| **`B6`** Export | ⛔ NO | ⛔ NO | ⚠️ **TBD** | ⚠️ **TBD** | ⭐ YES | `tenantWide` |
| **`B7`** Profile Views readout | ⛔ NO | ⛔ NO | ⛔ NO | ⚠️ **TBD** | ⭐⭐ **YES — owner only** | `tenantWide` |

⭐ **55 cells. 11 marked ⚠️ TBD — ⛔ deliberately unresolved**, because
`ANL-OBD-003` owns them.

### 8.2 ⭐⭐ The three cells that are NOT TBD, and why

⭐ Three prohibitions are **certain**, because a frozen exclusion or a Rank-2
ADR fixes them:

| Cell | Value | ⭐ Authority — not inference |
|---|---|---|
| `B2`/`B3` × `TR-3` Reception | ⛔⛔ **NO** | ⭐⭐ **`ANL-XC-005`** — *"Reception **MUST NOT** be able to see aggregate financial or business-performance analytics; least privilege makes it **impossible**, not merely hidden"* |
| `A1`…`A4` × any staff role | ⛔⛔ **NO** | ⭐⭐ **`ANL-XC-002`** — peer-identified visibility **impossible**; ⭐ `ANL-FR-016` confines the student surface to `self`. ⚠️ *(Staff may see a student's **operational** record via `BC-01`/`BC-03` — ⛔ that is not this analytics surface)* |
| `B7` × non-owner | ⛔ **NO** | ⭐⭐ **`ADR-0097`** §3.1 — *"⛔ **Owner/admin only, never public**"*; §4.4 — for every other caller *"the summary and its CTA are **absent** — not disabled-with-explanation, not present-and-refusing"* |

⭐⭐ **`ADR-0097` §4.4 fixes a presentation rule most permission matrices get
wrong.** ⛔ An unauthorised viewer sees **absence**, not a greyed control.
⇒ §12.3.

### 8.3 ⛔ Permission-restricted state — how a refusal renders

| Situation | ⭐ Required treatment | Authority |
|---|---|---|
| Caller lacks `B7` authority | ⛔⛔ **Surface and its CTA are ABSENT** | ⭐ `ADR-0097` §4.4 |
| Caller lacks a metric's `accessScope` | ⭐ The metric is **omitted** from the response set | ⭐ `ANL-FR-038`, `ANL-XC-008` |
| Export field outside caller's visibility | ⭐ **Field omitted**; ⛔ attempt **audited** | ⭐ `ANL-AC-013`, `ANL-XC-006` |
| Unauthorized export attempt | ⛔ **Refused AND audited** | ⭐ §41–42, `ANL-FR-033` |
| Query without `tenantId` | ⛔⛔ **Fails loudly; processes nothing** | ⭐ `ANL-FR-004`, `ANL-AC-004` |

⛔⛔ **A greyed, blurred, locked, teased or upsell-styled analytics element is
PROHIBITED**, and the prohibition is explicit rather than stylistic:
`ADR-0097` **U5** bars exactly that treatment for an uncertified metric.

### 8.4 ⭐ Tenant scope — the multi-tenant rule applied

| Rule | Statement |
|---|---|
| `ANL-INV-006` | ⭐ Every projection, metric, report, export tenant-scoped; ⛔ cross-tenant read **impossible** |
| `ANL-FR-038` | ⭐ **Every** query carries `tenantId` **and** actor permissions |
| `ANL-FR-004` | ⛔ Missing tenant context ⇒ **fail loudly, never default** |
| BC Map **L490** | ⭐ Projections *"are **all** tenant-partitioned"* |
| `ADR-0097` **P6** | ⭐ `ProfileViews` is *"Tenant Operational Data"*, ⛔ never on the public discovery-index path |

⚠️⚠️ **A measured code contradiction is disclosed here and NOT fixed** — §18
`AIV-A02`: `_feed` and `_attendanceDays` are **global**, not per-tenant.
⛔ **The design specifies tenant-partitioned surfaces because the requirement
says so; the code is the defect.**

---

## 9. Surface Inventory — recalculated from `PRD-009`

⭐ IDs `A1`…`A4` (APP 1) and `B1`…`B7` (APP 2) are **local to this document**.
⛔ They are **not** requirement identifiers and create nothing.

⛔⛔ **This inventory is recalculated from `PRD-009`, NOT copied from the
readiness audit's categories.** ⭐ The brief requires that distinction, and §22
reconciles the two numbers rather than hiding the difference.

⭐⭐ **Four inventories are maintained separately**, because a surface is not a
metric, a metric is not a chart, and none of them is a report:

| Inventory | Count | Section |
|---|---|---|
| **Surfaces** | **11** | §9 |
| **Metrics** | ⭐ **1 certified** + ⚠️ 13 uncertified candidates | §10 |
| **Reports** | ⚠️ **0 defined** *(a 14-field contract, no instance)* | §9.3, §15.1 |
| **Visualizations** | **6** | §14 |
| **States** | **11** | §12 |

### 9.1 ⭐ APP 1 — Student surfaces, `TR-4` only

⭐ Source: `PRD-009` **§15**, a **4-row table** naming the screens
`Today → Progress → Motivation → Detail`. ⭐⭐ **This is the strongest surface
prescription in the PRD** — it names screens, content and source per row.

| ID | Surface | Status | Content *(PRD §15, verbatim columns)* | Source events |
|---|---|---|---|---|
| **`A1`** | **Today** | ⚠️ **PARTIALLY DESIGNABLE** | *"Currently inside? · today's presence duration · seat"* | `attendance.*`, `seating.*` |
| **`A2`** | **Progress** | ⚠️ **PARTIALLY DESIGNABLE** | *"Presence over 7/30 days · personal trend · personal-best consistency"* | `attendance.*` |
| **`A3`** | **Motivation** | ⛔⛔ **BLOCKED** | *"Personal milestones · consistency goals"* — ⛔ source column reads **"derived"** | ⛔ **§9.1.1** |
| **`A4`** | **Detail** | ⚠️ **PARTIALLY DESIGNABLE** | *"Own history · own dues and receipts"* | `attendance.*`, `fee.*` |

#### 9.1.1 ⛔⛔ Why `A3` Motivation is BLOCKED — the source column says *"derived"*

⭐⭐ **§15's source column is the finding.** Three rows name concrete event
families; `A3`'s reads simply **"derived"** — ⛔ derived *from what*, by *what
rule*, is never stated.

| `A3` element | What is needed | Measured |
|---|---|---|
| *"Personal milestones"* | A milestone **definition** — threshold, unit, period | ⛔ **0** milestone definition exists in `PRD-009` |
| *"Consistency goals"* | A **goal value** | ⛔⛔ **0** goal, target or benchmark exists |

⛔⛔ **A goal is a number, and inventing it would be inventing a requirement.**
⭐ `MP-GBR-36` + `AN-2` forbid a surface defining its own metric; a milestone
threshold **is** a metric definition. ⭐ And `charts.csv` **#8** independently
rejects a gauge where *"no target or benchmark exists"*.

⭐ **What IS designable for `A3`, and it is very little:** a container and an
empty state. → **`DD6-GAP-001`**, `[OWED — Product Owner]`, ⛔ **BLOCKING for
`A3` only**.

⚠️⚠️ **Note the psychological trap avoided.** `A3` is the surface a designer is
most tempted to fill with streaks, badges and confetti. ⛔ `ANL-FR-021` bars the
streak from being *"the primary progress signal"*, and `ANL-XC-003` bars
fear/urgency mechanics. ⭐ **A blocked `A3` is the correct outcome, not a
shortfall.**

#### 9.1.2 ⭐ Why `A1`, `A2`, `A4` are PARTIAL, not designable-now

⭐ Their **layout, order, states and labels** are fully specifiable. ⛔ Their
**values** are not certified: `PRD-009` §8.3 measures the semantic layer as
⛔ **NONE** (F-1), so ⭐ *"Presence over 7/30 days"* has **no certified
definition** — no `timeSemantics`, no `freshnessExpectation`, no boundary rule.

⭐ `ANL-FR-008` requires **nine fields** per metric; ⭐ `ANL-FR-009` requires a
metric missing any of them to be **rejected at registration, not published with
blanks**. ⛔⛔ **A surface rendering an unregistered metric would publish the
blank the PRD forbids.**

### 9.2 ⭐ APP 2 — Staff surfaces

⭐ Source: `PRD-009` **§18–21**, whose role table names each role's V1 metric
set, governed by `ANL-FR-027`'s mandated order **Status → Attention → Action →
Analysis**.

| ID | Surface | Role focus | Status | Content *(PRD §18–21)* |
|---|---|---|---|---|
| **`B1`** | **Reception Now** ⚠️ *dashboard-adjacent* | `TR-3` | ⚠️ **PARTIALLY DESIGNABLE** | *"Who is inside now · seats free · today's check-ins · dues-on-arrival flag"* |
| **`B2`** | **Manager Attention** | `TR-2` | ⚠️ **PARTIALLY DESIGNABLE** | *"Today's occupancy · threshold breaches · expiring memberships · overdue dues · attendance anomalies"* |
| **`B3`** | **Owner Trends** | `TR-1` | ⚠️ **PARTIALLY DESIGNABLE** | *"Occupancy trend · student-fee collections vs dues · membership growth/expiry · enrolment trend · AI cost"* |
| **`B4`** | **Metric Detail / drill-down** | `TR-2`, `TR-1` | ⛔⛔ **BLOCKED** | ⭐ Required by `ANL-FR-028` — *"name the metric, the threshold crossed **and the drill-down path**"* |
| **`B5`** | **`AnalyticalReport`** | `TR-2`, `TR-1` | ⛔⛔ **BLOCKED** | ⭐ `ANL-FR-030`'s **14-field** contract |
| **`B6`** | **Export** | `TR-1` | ⚠️ **PARTIALLY DESIGNABLE** | ⭐ `ANL-FR-032`/`-033`; §15 |
| **`B7`** | **Profile Views readout** | `TR-1` **only** | ⭐⭐ **DESIGNABLE NOW** | ⭐⭐ `ADR-0097` §3 — ⭐ **the ONLY fully certified surface** |

#### 9.2.1 ⭐⭐ `B7` is the only DESIGNABLE-NOW surface, and that is a measurement

⭐⭐ **`B7` is designable because `ADR-0097` supplies every property
`ANL-FR-008` demands** — definition, sole input, counting rule, duplicate
handling, bot handling, trend period, suppression, audience and **labelling
obligation**. ⛔ No other metric in the repository has any of them.

⭐ **`ADR-0097` even fixes the failure modes**, which is why `B7` needs no TBD:

| Situation | ⭐ Mandated treatment |
|---|---|
| `BC-26` unavailable | ⭐ *"temporarily unavailable"*; ⛔ **not** zero, ⛔ not a stale value of unknown age, ⛔ must not fail the host surface (§4.2) |
| Prior window insufficient | ⛔⛔ **Trend OMITTED** — ⛔ not `0%`, ⛔ not `—`, ⛔ not *"no change"*, ⛔ not *"new"*, ⛔ not *"coming soon"* (**T4**). ⭐ The count still renders |
| Value small enough to re-identify | ⭐ **Suppressed**; ⛔ **not zero**; ⛔ not inferable from response shape, size, ordering or timing (**P2**, **P3**) |
| Label | ⛔⛔ **MUST read "views"** — ⛔ never *visitors, people, unique visitors, users, viewers, reach, audience* (**§4.3**) |
| Deeper analysis requested | ⭐ **Hand off** — ⛔ never expand inline (**T5**, **§4.5**) |

#### 9.2.2 ⛔⛔ Why `B4` and `B5` are BLOCKED

| Surface | ⛔ Blocker |
|---|---|
| **`B4`** | ⭐ `ANL-FR-028` **mandates a drill-down path**, but ⛔ **no drill-down destination, depth or breakdown dimension is specified anywhere**. ⚠️ Filters and drill-down are classified **V2** (§44.4) and `ANL-OBD-009` owns the customization boundary. ⛔⛔ **A V1 requirement points at a V2 capability** → **`DD6-GAP-002`** |
| **`B5`** | ⭐ `ANL-FR-030` requires **14 declared fields** and ⭐ `ANL-FR-031` makes a report *"**MUST NOT** be publishable"* without all 14. ⛔⛔ **Measured: 0 `AnalyticalReport` instances are defined.** ⭐ The **contract** is designable; ⛔ **no report is** → **`DD6-GAP-003`** |

⭐⭐ **`B5`'s blocker has the same shape as `ADR-0097`'s gap:** an authority
names a class and no instance exists. ⭐ `ADR-0097` closed that for *one*
metric; ⛔ nothing has closed it for *any* report.

### 9.3 ⭐ The report inventory — deliberately EMPTY

| Inventory | Count | Evidence |
|---|---|---|
| `AnalyticalReport` **contract** | ⭐ **1** — `ANL-FR-030`'s 14 fields | ⭐ Designable |
| `AnalyticalReport` **instances** | ⛔⛔ **0** | ⛔ `DD6-GAP-003` |

⛔ **An empty inventory is published rather than omitted**, on the same
discipline `PRD-009` §0 applied to `ANL-EVT-*`: *"The empty register is
published rather than omitted so a future reader knows the question was asked
and answered."*

### 9.4 ⚠️ Two outputs that exist in code and are NOT given a surface

⚠️ `PRD-009` §8.3 inventories two extra outputs of the live projection.
⛔ **Neither receives a surface here**, and the reasons are recorded:

| Output | ⛔ Why no surface |
|---|---|
| `feed()` → `List<ActivityItem>` | ⛔⛔ **`ANL-OBD-007` is OPEN** — *"is a per-event activity feed a Certified Metric at all, or a separate read-model class with its own access rules?"* ⭐ And `ANL-XC-008` forbids analytics being a route to data the actor could not see operationally. ⛔ An activity feed is *"nearer to an operational log than to an aggregate"* |
| `distinctAttendanceDays()` | ⭐ **This one is different and is disclosed as such:** §8.3 calls it *"exactly the honest consistency signal §12.2 argues for, and **it already exists**"*. ⛔ **But it is still not a `CertifiedMetric`** — no nine fields, no version, no owner. ⭐ It supports `A2`'s **designability**, ⛔ not its **values** |

⭐⭐ **`distinctAttendanceDays()` is the strongest evidence in the repository
that the presence/consistency framing is buildable** — ⛔ and it is *still* not
enough to render a number, because `ANL-FR-001` requires every output to
resolve to a Certified Metric.

### 9.5 ⭐ Information Architecture — two orders, never merged

⛔⛔ **The two mandated orders are different, and merging them would breach a
requirement.**

```
APP 1 — Student (PRD §15)              APP 2 — Staff (ANL-FR-027)
─────────────────────────              ──────────────────────────
Analytics (TR-4, self)                 Analytics (tenantWide)
├── A1  Today                          ├── STATUS      → B1 / B3 headline
├── A2  Progress                       ├── ATTENTION   → B2 queue
├── A3  Motivation      ⛔ BLOCKED      ├── ACTION      → B2 item → B4  ⛔ BLOCKED
└── A4  Detail                         └── ANALYSIS    → B3 trends
                                           ├── B5  Report   ⛔ BLOCKED
                                           ├── B6  Export
                                           └── B7  Profile Views  ⭐ certified
```

| Order | Authority | ⛔ Consequence |
|---|---|---|
| `Today → Progress → Motivation → Detail` | ⭐ `PRD-009` §15 heading | ⛔ Student navigation order is **fixed** |
| `Status → Attention → Action → Analysis` | ⭐⭐ `ANL-FR-027` — *"**not a chart wall**"* | ⛔ Staff surfaces **MUST NOT** open on a chart grid |

⛔ **Every surface leads with a plain-language summary** (`ANL-FR-035`) —
⭐ in **both** orders, without exception.

### 9.6 ⭐ Surface → App assignment (QA check 1)

| App | Surfaces | Count |
|---|---|---|
| ⭐ **APP 1** | `A1`, `A2`, `A3`, `A4` | **4** |
| ⭐ **APP 2** | `B1`, `B2`, `B3`, `B4`, `B5`, `B6`, `B7` | **7** |
| ⛔⛔ **APP 3** | ⛔ none | **0** |

⭐ **11 surfaces · 11 assigned · 0 unassigned.**

### 9.7 ⭐ Designability summary

| Class | Count | Surfaces |
|---|---|---|
| ⭐⭐ **DESIGNABLE NOW** | **1** | `B7` |
| ⚠️ **PARTIALLY DESIGNABLE** *(layout/states yes, values no)* | **7** | `A1`, `A2`, `A4`, `B1`, `B2`, `B3`, `B6` |
| ⛔⛔ **BLOCKED** | **3** | `A3`, `B4`, `B5` |

⭐⭐ **1 of 11 fully designable.** ⛔ That figure is low, and it is the honest
consequence of **F-1** — ⛔ *no semantic layer exists*, so 7 surfaces can be
drawn but not populated.

---

## 10. Metric Authority

### 10.1 ⛔⛔ The governing measurement — 1 certified metric repository-wide

⭐ `ANL-FR-008` requires **nine fields** on every Certified Metric:
`metricId` · `name` · `definition` · `sourceEvents[]` · `calculation` ·
`owningContext` · `timeSemantics` · `freshnessExpectation` · `accessScope`.

⭐ `ANL-FR-009`: *"A metric missing any of the nine **MUST** be rejected at
registration, **not published with blanks**."*

| Measurement | Value |
|---|---|
| `CertifiedMetric` **class** defined | ⭐ **YES** — BC Map **L385**, Rank 4 |
| `CertifiedMetric` **instances** defined | ⭐⭐ **1** — `ProfileViews` (`ADR-0097`) |
| Semantic layer in code | ⛔⛔ **NONE** — `PRD-009` §8.3, **F-1** |
| `CertifiedMetric` type in code | ⛔ **Absent**, though a Rank-4 value object |
| Uncertified candidate metrics named in `PRD-009` | ⚠️ **13** |

⭐⭐ **`ADR-0097` states the position that governs this whole section:**
*"`ProfileViews` is the **FIRST** `CertifiedMetric` named anywhere in the
repository. Before this ADR, **L385** established the *class*… but **no instance
of it had ever been defined**."*

⛔⛔ **THIS DOCUMENT MUST NOT DEPICT A COMPLETED SEMANTIC LAYER, AND DOES NOT.**
⭐ Exactly **one** surface (`B7`) renders a certified value. ⛔ The other ten
render values whose definitions are owed.

### 10.2 ⭐⭐ The one certified metric — all nine fields present

| `ANL-FR-008` field | ⭐ `ProfileViews` value | Source |
|---|---|---|
| `metricId` | ⭐ `ProfileViews` | `ADR-0097` §3.1 |
| `name` | ⭐ `ProfileViews` | §3.1 |
| `definition` | ⭐ *"the count of `tenancy.LibraryProfileViewed` facts attributed to a single library, over a single `BC-26`-defined period, after the §3.3/§3.4 exclusions"* | §3.1 |
| `sourceEvents[]` | ⭐ **Sole input** — `tenancy.LibraryProfileViewed` over **`E-30`** | §3.1, `ADR-0096` |
| `calculation` | ⭐ *"One qualifying fact increments by exactly one"*; ⛔ **no viewer-level dedup**; ⛔ transport duplicates excluded; ⛔ non-render requests excluded; ⛔ bots excluded where identifiable; ⭐ owner's own visits **counted** (`B5`) | §3.2–3.4 |
| `owningContext` | ⭐ **`BC-26`** — sole definitional authority | §3.1 |
| `timeSemantics` | ⭐ **Rolling 7-day window vs immediately preceding non-overlapping 7-day window** — ⛔ *"the **only** certified comparison"*; ⛔ daily/monthly/quarterly/all-time/YoY/custom **NOT certified** | §3.5 `T1`, `T5` |
| `freshnessExpectation` | ⚠️ **Not numerically stated** — ⭐ but §4.2 fixes the *behaviour*: unavailable ⇒ *"temporarily unavailable"*, ⛔ never a stale value of unknown age | §4.2; ⚠️ `ANL-CFG-003` owed |
| `accessScope` | ⭐⭐ **Owner/admin only, never public** — `tenantWide`, tenant context **required** and refused if absent/mismatched | §3.1, `P5`, `P6` |

⭐ **9 of 9 present** *(the freshness field behaviourally, not numerically)*.

### 10.3 ⚠️ The 13 uncertified candidates — recorded, ⛔ NOT certified

⛔⛔ **For every row below, at least one of the nine fields is UNDEFINED.**
⭐ `ANL-FR-009` therefore bars publication. ⛔ **I do not invent the missing
fields**; each is routed.

| # | Candidate | Named at | ⛔ Missing |
|---|---|---|---|
| 1 | Presence / currently-inside | §12.1, §15 `A1` | ⛔ `calculation`, `timeSemantics` *(is "inside" a point-in-time or a duration?)*, `freshnessExpectation` |
| 2 | Presence duration | §12.1, `A1` | ⛔ `calculation` *(gross? net of exits?)*, boundary rule |
| 3 | ⭐ Study **consistency** | §12.2 *(✅ "Supported")* | ⛔ `calculation` — ⚠️ `distinctAttendanceDays()` exists in code but is **not** a registered definition |
| 4 | Personal-best consistency | §15 `A2` | ⛔ `calculation`, `timeSemantics` |
| 5 | Occupancy | §12.1, `B1`/`B2` | ⛔ `calculation` — ⚠️ code derives `seatsAssigned − seatsReleased`; ⛔ that is **not** a registered definition |
| 6 | Threshold breaches | `B2` | ⛔⛔ **`threshold` value itself** — ⚠️ produced by `seating.OccupancyThresholdCrossed` (`BC-04`), ⛔ so the threshold is **not `BC-26`'s** |
| 7 | Student-fee collections vs dues | `B3` | ⛔ `timeSemantics`, period boundary. ⭐ `ANL-BR-002` requires it to **never** share a model with SaaS revenue |
| 8 | Overdue dues | `B2` | ⛔ `calculation` — ⚠️ *"overdue"* needs a due-date rule owned by **`BC-05`** |
| 9 | Membership growth / expiry | `B2`/`B3` | ⛔ `timeSemantics` |
| 10 | Enrolment trend | `B3` | ⛔ `timeSemantics`, comparison window |
| 11 | AI cost attribution | `B3` | ⛔ `calculation`, currency unit. ⭐ `ANL-FR-048` requires per-tenant attribution |
| 12 | ⚠️ **Attendance anomalies** | `B2` | ⛔⛔ **Everything** — ⛔ no anomaly rule, threshold or definition exists anywhere → `DD6-TBD-003` |
| 13 | Dues-on-arrival flag | `B1` | ⛔ `calculation` — ⚠️ a **join** of `attendance.*` and `fee.*`; ⛔ no joint definition exists |

⭐⭐ **13 candidates · 0 certified · 13 with at least one undefined field.**
→ **`DD6-GAP-004`**, `[OWED — Architecture Owner + Product Owner]` per
`ANL-OBD-001` *(who owns a metric definition is **itself** undecided)*.

⚠️⚠️ **Candidate 6 is the sharpest boundary case and is recorded rather than
smoothed over.** The threshold that `B2` must *"name"* per `ANL-FR-028` is
carried by a `BC-04` event. ⛔ `BC-26` may **display** it; ⛔ it **MUST NOT**
define it — `BC-26` *"owns no domain fact"* (§9). ⭐ The surface shows a
threshold it does not own.

### 10.4 ⛔⛔ `UniqueViewers` — the mandatory absence

⭐ `ADR-0097` §5 rules `UniqueViewers` **NOT certified** and fixes **8**
treatment rules. ⛔ **Design consequence, stated as prohibitions:**

| Rule | ⛔ `B7` MUST NOT |
|---|---|
| `U1` | ⭐ The field is **OMITTED** |
| `U2` | ⛔ render as **zero** |
| `U3` | ⛔ render as *unknown*, `—`, `n/a`, or blank-with-label |
| `U4` | ⛔ render as *"coming soon"* or any forward promise |
| `U5` | ⛔⛔ render as **disabled, greyed, blurred, locked, teaser or upsell** |
| `U6` | ⛔ be approximated, estimated, modelled or inferred from `ProfileViews` |
| `U7` | ⛔ compute uniqueness, deduplicate, fingerprint or infer distinctness |
| `U8` | ⚠️ It remains **CONDITIONAL, not forbidden forever** — ⛔ this document does not predict a future definition |

⭐⭐ **`ADR-0097` explains why `U5`/`U6` matter commercially, and it is worth
preserving verbatim:** *"A blurred or teased 'Unique Viewers' is the most likely
way this ruling would be violated in practice — it looks like a product decision
rather than a metric definition."* ⛔ **A locked-metric upsell pattern is
therefore PROHIBITED on this surface.**

---

## 11. Data Provenance & Trust

### 11.1 ⭐ What the UI must be able to say about every number

⭐ `ANL-INV-009`: *"Every output carries the freshness of its underlying
projection."* ⭐ `ANL-FR-043`: every metric screen-reader labelled with **name,
value and freshness**.

| Question | ⭐ Can the UI answer it? | Authority |
|---|---|---|
| **What does this number mean?** | ⭐ **YES** — the metric `definition` | `ANL-FR-008` |
| **What is it derived from?** | ⭐⭐ **YES, and it is MANDATORY on student surfaces** — *"e.g. 'based on your check-ins'"* | ⭐ `ANL-FR-006` |
| **Which metric version?** | ⭐ **YES** — *"Any output built on a metric version **MUST** state which version it used"* | `ANL-FR-011` |
| **How fresh is it?** | ⭐ **YES** — last-updated **MUST** show when stale | `ANL-FR-056`, `ANL-INV-008` |
| **Is it partial?** | ⭐ **YES** — *"**MUST** mark partial, not silently under-report"* | ⭐ `ANL-FR-054` |
| **Is it real-time?** | ⛔⛔ **It MUST NOT claim to be** | `ANL-FR-056` |
| **What period does it cover?** | ⚠️ **Only where declared** — per-metric `timeSemantics` | `ANL-FR-055` |
| **How often does it refresh?** | ⛔⛔ **NO — and no interval may be invented** | ⛔ `ANL-GAP-020`, `ANL-CFG-003` |

### 11.2 ⛔⛔ The trust rule that constrains every layout

⭐⭐ `PRD-009` §41–42's failure principle is the design constraint:

> ⭐ **"Fail visibly. A wrong number that looks right is worse than a missing
> one."**

| ⭐ Required | ⛔ Prohibited |
|---|---|
| ⭐ Freshness travels **with** the value, never in a distant footer | ⛔ A number without its freshness |
| ⭐ A partial figure is **marked partial** | ⛔⛔ Silent under-reporting |
| ⭐ A stale figure shows **last-updated** | ⛔ Implying currency |
| ⭐ An unavailable figure is **absent or marked unavailable** | ⛔⛔ Rendering **zero** for missing data |
| ⭐ A metric version is stated | ⛔ Mixing versions silently |
| ⭐ A suppressed figure reads **suppressed** | ⛔ Rendering zero (`ADR-0097` `P3`) |

⛔⛔ **"Zero" is the single most dangerous value on an analytics surface**, and
**three independent authorities** forbid it in three different situations:
⭐ `ANL-FR-018` *(no history ⇒ never a zero as a score)* · ⭐ `ADR-0097` `P3`
*(suppressed ⇒ never zero)* · ⭐ `ADR-0097` **U2** *(uncertified ⇒ never zero)*.

### 11.3 ⭐ Time, currency and locale presentation

| Element | ⭐ Rule | Authority |
|---|---|---|
| Timestamps | ⭐ **IST** | `ANL-FR-037`, `MP-CON-12` |
| Currency | ⭐ **INR** | `ANL-FR-037` |
| ⚠️ Digit grouping | ⛔ **UNDECIDED** | ⚠️ `DD6-TBD-001` |
| Labels | ⛔ **No concatenation** — one localizable unit each | `ANL-FR-036` |
| Locale | ⭐ **Consumed from `BC-25`**; ⛔ `BC-26` **MUST NOT** define it | `ANL-GAP-013` |

---

## 12. Time, Restatement & State Model

### 12.1 ⭐⭐ Restatement — the case the PRD singles out, and it is BLOCKED today

⭐ `ANL-FR-053`: *"Correction (`AttendanceCorrected`) ⇒ Metric **MUST**
restate."* ⭐ `ANL-AC-007` makes it testable. ⭐ BC Map **L416** assigns that
event the purpose *"Audit + **restated metrics**"*.

⛔⛔ **Measured: `attendance.AttendanceCorrected` is NOT consumed by the live
projection.** ⭐ I verified this independently — the `register()` method
subscribes to **8** event types and `AttendanceCorrected` is not among them.
⇒ **`ANL-GAP-002`**, OPEN.

⚠️⚠️ **Design consequence, stated plainly:** ⛔ **attendance figures cannot
restate today.** ⭐ The **restatement UI is specifiable** — a restated value with
a visible marker — ⛔ but it **cannot be exercised**, because no upstream
correction reaches the projection.

| What | Status |
|---|---|
| Restatement **requirement** | ⭐ Exists — `ANL-FR-053` |
| Restatement **UI treatment** | ⭐ **Specifiable** — §12.2 state `R` |
| Restatement **capability** | ⛔⛔ **ABSENT** — `ANL-GAP-002` |
| Restatement **visual vocabulary** | ⛔ **UNDEFINED** → `DD6-TBD-005` |

⛔⛔ **`ANL-FR-052` requires that *"restatement [be] visible"* but ⛔ defines NO
visual treatment**, and no other source supplies one. ⭐ I decline to invent a
badge, colour or icon for a restated number. → **`DD6-TBD-005`**.

### 12.2 ⭐ The 11 states — every surface, every state

⭐ Each state is required by a named source. ⛔ No state is invented.

| # | State | ⭐ Required treatment | Authority |
|---|---|---|---|
| **`L`** | **Loading** | ⚠️ Non-blocking indicator; ⛔ **layout-preserving** *(no content jump)*. ⚠️ **Duration/threshold TBD** | ⚠️ `ANL-GAP-021`; Pro Max #78 |
| **`EM`** | **Empty — no history** | ⭐⭐ *"explanatory empty state, **never a zero presented as a score**"* | ⭐⭐ `ANL-FR-018` |
| **`ND`** | **No data for the period** | ⭐ Distinguished from `EM`; ⛔ **not zero** | `ANL-FR-018` + `ANL-FR-054` |
| **`IN`** | **Insufficient data** | ⭐⭐ Trend **OMITTED**; ⛔ not `0%`, ⛔ not *"—"*, ⛔ not *"new"*, ⛔ not *"no change"* | ⭐⭐ `ADR-0097` **T4** |
| **`PA`** | **Partial data** | ⭐ **Marked partial**; ⛔ *"not silently under-report"* | ⭐ `ANL-FR-054` |
| **`ST`** | **Stale** | ⭐ **last-updated shown**; ⛔ **no real-time claim** | ⭐ `ANL-FR-056`, `ANL-INV-008` |
| **`UN`** | **Unavailable** | ⭐ *"temporarily unavailable"*; ⛔ not zero, ⛔ not a stale value of unknown age; ⛔ **MUST NOT fail the host surface** | ⭐ `ADR-0097` §4.2 |
| **`SU`** | **Suppressed** *(privacy)* | ⭐ Rendered **suppressed or omitted**; ⛔ not zero; ⛔ not inferable from shape/size/order/timing | ⭐⭐ `ADR-0097` `P2`, `P3` |
| **`E`** | **Error** | ⭐ Explicit failure; ⛔ *"never a partial passed off as complete"*; ⭐ recovery path offered | ⭐ §41–42; Pro Max #80 |
| **`PR`** | **Permission-restricted** | ⭐⭐ **ABSENT** — ⛔ not disabled-with-explanation, ⛔ not present-and-refusing | ⭐⭐ `ADR-0097` §4.4 |
| **`R`** | **Restated** | ⭐ Restatement **visible** | ⭐ `ANL-FR-052`; ⚠️ treatment `DD6-TBD-005` |

⭐⭐ **11 states. `EM`, `ND`, `IN`, `PA`, `ST`, `UN` and `SU` are SEVEN
distinguishable non-value states** — and ⛔ **not one of them may render as
zero**. ⭐ That is the defining characteristic of this context's state model and
it has no parallel in `DD-0001`…`DD-0005`.

### 12.3 ⭐ State × Surface applicability

| Surface | `L` | `EM` | `ND` | `IN` | `PA` | `ST` | `UN` | `SU` | `E` | `PR` | `R` |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `A1` Today | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `A2` Progress | ⭐ | ⭐⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `A3` Motivation ⛔ | ⭐ | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | — | ⭐ | ⭐ | — |
| `A4` Detail | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `B1` Reception Now | ⭐ | — | ⭐ | — | ⭐ | ⭐⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `B2` Attention | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `B3` Trends | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `B4` Drill-down ⛔ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | ⭐ |
| `B5` Report ⛔ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | ⭐ | — | ⭐⭐ | ⭐ | ⭐ |
| `B6` Export | ⭐ | ⭐ | — | — | ⭐ | ⭐ | ⭐ | — | ⭐ | ⭐ | — |
| `B7` Profile Views | ⭐ | — | ⭐ | ⭐⭐ | — | ⭐ | ⭐⭐ | ⭐⭐ | ⭐ | ⭐⭐ | — |

⭐⭐ **`SU` Suppressed applies to `B7` alone**, because `ADR-0097` `P2` is the
**only** suppression rule in the repository. ⛔ No other metric has a
suppression threshold, so ⛔ none may claim one.

### 12.4 ⛔ Analytics is never mandatory

⭐ `ANL-FR-024`: *"Analytics **MUST NOT** be mandatory to use the app."*

| ⛔ Prohibited pattern |
|---|
| ⛔ Analytics as a forced onboarding step |
| ⛔ A dismissal-blocking analytics modal |
| ⛔ Analytics as an unavoidable app-launch interstitial |
| ⛔ Gating any operational task behind viewing analytics |

### 12.5 ⚠️ Time semantics not defined — and not invented

| Question | Status |
|---|---|
| Month / year boundary | ⚠️ *"Declared `timeSemantics`"* per metric — ⛔ **13 of 14 metrics have none** |
| Period for non-`ProfileViews` metrics | ⛔ **UNDEFINED** — `DD6-GAP-004` |
| Refresh interval | ⛔⛔ **MUST NOT be invented** — `ANL-GAP-020` |
| Late-arrival window | ⛔ **UNDEFINED** — ⭐ `ANL-FR-052` requires restatement but fixes no window |
| Out-of-order events | ⭐ Rule exists: ⛔ *"no cross-aggregate ordering assumption"* (`ANL-FR-051`) |
| ⭐ `ProfileViews` period | ⭐⭐ **DEFINED** — rolling 7-day vs preceding 7-day, and ⛔ **only** that |

---

## 13. Psychology & Behavioural Science Review

⚠️⚠️ **Discipline applied, copied from `PRD-009` §16 rather than invented:**
every item is **labelled by evidence class**. ⛔ **I cite no external studies**,
because this repository contains no research corpus. ⭐ Items marked
`[EVIDENCE — not repo-verified]` are widely-held design principles, and ⛔ I flag
that they are **not** repository-verified.

⭐⭐ **Where a psychological finding is backed by a requirement it is BINDING;
where it is not, it is design guidance only.** ⭐ That separation is the whole
point of this section.

### 13.1 ⭐ The ten mandated dimensions — per role

| Dimension | `TR-4` Student | `TR-3` Reception | `TR-2` Manager | `TR-1` Owner |
|---|---|---|---|---|
| **Cognitive load** | ⭐ High risk — a trend is abstract. ⭐ `ANL-FR-035` mandates prose first | ⭐ Low — 4 facts | ⚠️ Medium — 5 metrics | ⚠️ **Highest** — 5 trends |
| **Attention** | ⭐ One focal point: today's state | ⭐ Focal: who is inside | ⭐ Focal: **attention queue** | ⭐ Focal: headline summary |
| **Information overload** | ⛔ `ANL-FR-034` no horizontal scroll | ⛔ No aggregate finance (`ANL-XC-005`) | ⛔ `ANL-FR-027` **not a chart wall** | ⛔ Same |
| **Motivation** | ⚠️⚠️ **`A3` BLOCKED** — ⛔ no goal exists to motivate toward | ⛔ n/a | ⛔ n/a | ⛔ n/a |
| **Progress interpretation** | ⭐⭐ **The core risk** — §13.2 | ⛔ n/a | ⚠️ Threshold must be named (`ANL-FR-028`) | ⚠️ Trend period must be stated |
| **Anxiety** | ⭐⭐ **High** — §13.3 | ⚠️ Overdue-dues flag on arrival — §13.5 | ⚠️ A red queue reads as blame | ⚠️ Revenue trend anxiety |
| **Comparison pressure** | ⛔⛔ **ELIMINATED architecturally** — `ANL-XC-002`/`-004` | ⛔ n/a | ⛔ No staff ranking exists | ⛔ No cross-tenant benchmark (`ANL-INV-006`) |
| **Trust** | ⭐ `ANL-FR-006` — *"based on your check-ins"* | ⭐⭐ Freshness is critical — §13.5 | ⭐ Named threshold | ⭐ Named metric version |
| **Uncertainty** | ⭐ `IN`/`PA` states, ⛔ never zero | ⭐ `ST` staleness visible | ⭐ Same | ⭐ Same |
| **Privacy / dignity / shame** | ⭐⭐ §13.4 | ⚠️ §13.5 — ⛔ **do not shame in front of a queue** | ⭐ `ANL-XC-003` | ⭐ `ANL-XC-003` |

### 13.2 ⭐⭐ Progress interpretation — the single highest-risk design decision

⭐⭐ **`ANL-FR-018` is the most psychologically loaded requirement in the PRD:**

> *"A student with **no history MUST** see an explanatory empty state, **never a
> zero presented as a score**."*

⭐ **Why this is a psychology requirement and not a data requirement:** a new
student's true consistency *is* zero. ⛔ Rendering `0%` is **numerically
correct and psychologically wrong** — it presents the absence of history as a
failing grade.

| ⭐ Required `EM` treatment | ⛔ Prohibited |
|---|---|
| ⭐ An **explanation** of what the surface will show once data exists | ⛔⛔ `0%`, `0 days`, `0/7`, an empty progress ring |
| ⭐ Neutral, forward-looking language | ⛔ *"No progress"*, *"Nothing achieved"* |
| ⭐ A **stat card**, not a chart *(Pro Max #1, <4 points)* | ⛔ An empty chart axis |

⛔⛔ **An empty progress ring is the exact defect `ANL-FR-018` names**, because a
ring at 0% is a **score**, not an absence.

⭐ **`ND` No-data-for-period is distinguished from `EM`**, and the distinction is
psychological: ⭐ *"you have no history yet"* is neutral, ⚠️ *"you were absent
this period"* is a judgement. ⛔ `ANL-FR-020` requires every student analytic to
be *"expressible without a negative value judgement"*, so ⭐ `ND` states the
**period**, ⛔ not the absence.

### 13.3 ⭐⭐ Anxiety and the streak — the requirement that constrains the hero element

⭐⭐ `ANL-FR-021`, in two clauses, both binding:

> *"A broken streak **MUST NOT** be presented as failure or loss; recovery
> framing is required **and the streak MUST NOT be the primary progress
> signal**."*

| Clause | ⛔ Design consequence |
|---|---|
| ⛔ Not failure or loss | ⛔⛔ **No "streak lost"**, no broken-flame icon, no red counter reset, no *"you lost N days"* |
| ⭐ Recovery framing required | ⭐ The surface shows the **path forward**, not the break |
| ⛔⛔ **Not the primary signal** | ⛔⛔ **The streak MUST NOT be the hero element of `A2`.** ⭐ Presence over 7/30 days is primary; a streak is at most secondary |

⚠️ **Evidence class disclosed:** `PRD-009` §16 classifies *"streaks motivate
some, discourage others on break"* as **`[HYPOTHESIS]`** — ⛔ not verified.
⭐ **But `ANL-FR-021` is a requirement regardless of the hypothesis's status**,
so the design obeys the requirement, not the hypothesis.

### 13.4 ⛔⛔ Five patterns PROHIBITED on student analytics

⛔ Each is barred by a named requirement — ⛔ **none is my preference**:

| # | ⛔ Prohibited | Authority |
|---|---|---|
| 1 | ⛔⛔ **Ranking / leaderboard / peer comparison** | ⭐⭐ `ANL-XC-004` — **impossible** under `MP-GBR-21`'s closed register; `ANL-XC-002`; `ANL-AC-011` |
| 2 | ⛔⛔ **Shame-based scoring / failure labels** | ⭐ `ANL-XC-003` — ⛔ *"labels a student as failing/weak/bad"*; `ANL-FR-020` |
| 3 | ⛔⛔ **Unsupported performance judgement** | ⭐⭐ `ANL-XC-001` — ⛔ **impossible** to label a metric as measuring learning, mastery, performance, intelligence or ability |
| 4 | ⛔⛔ **Gamification** *(badges, points, levels, confetti, celebration)* | ⭐ `ANL-XC-003` bars fear/urgency mechanics; ⭐ `ANL-FR-021` demotes the streak; ⭐ **`A3` is BLOCKED** because no goal exists to gamify |
| 5 | ⛔⛔ **Manipulative emphasis / dark patterns** | ⭐ `ANL-XC-003` — ⛔ *"uses fear or urgency to drive behaviour"*; ⭐ `ANL-FR-024` — analytics never mandatory; ⭐ `ADR-0097` `U5` — ⛔ no teaser/upsell element |

⭐⭐ **`ANL-XC-001` deserves emphasis because it protects against the most
plausible product mistake.** ⛔ A designer could label `A2` *"Your study
performance"*. ⭐ That single word would be a **false claim** — ⛔ there is no
learning-outcome fact anywhere in the 24 events (**F-2**). ⭐ `ANL-FR-023` makes
the honest framing explicit: *"A metric whose only lever is attendance **MUST**
be labelled as attendance, so that gaming it gains nothing but honesty."*

### 13.5 ⚠️⚠️ The dignity case the PRD does not name, and I will not resolve

⚠️ `B1` Reception includes a **"dues-on-arrival flag"** (`PRD-009` §21).

⛔⛔ **Reception is a physical counter, and a student checking in is standing in
front of it, possibly in a queue.** ⚠️ An overdue-dues flag rendered
prominently at that moment is a **dignity and shame risk** in a way the same
fact on a private screen is not.

| What is certain | What is NOT |
|---|---|
| ⭐ `ANL-XC-003` bars output that *"labels a student as failing/weak/bad"* | ⚠️ ⛔ **`ANL-XC-003` is written about *student-facing* output** — ⭐ the flag here is **staff-facing** |
| ⭐ The **operational need is legitimate** — Reception must know | ⛔ **No requirement governs the *prominence* or *discretion* of a staff-facing financial flag** |

⛔⛔ **I decline to resolve this.** ⭐ Recording it is within a Design Doc's
remit; ⛔ deciding that a financial flag must be visually de-emphasised at a
public counter would be creating a requirement no authority set.
→ **`DD6-TBD-008`**, `[OWED — Product Owner + Privacy]`.

⭐ **Related but distinct, and already governed:** `FEE-XC-019` (`PRD-008`) bars
exposing staff notes and reasons across the student boundary. ⭐ `DD-0005` §3.3
applied it. ⛔ It does **not** reach the prominence question.

### 13.6 ⭐ Behavioural UX — unhealthy engagement pressure

| Risk | ⭐ Mitigation | Authority |
|---|---|---|
| Repeatedly checking rank | ⛔ **No rank exists in V1** | ⭐ `ANL-XC-004` |
| Compulsive streak checking | ⭐ Streak demoted from primary | ⭐ `ANL-FR-021` |
| Notification-driven re-engagement | ⭐ `BC-26` **cannot notify** — ⛔ *unconstructable*, no communication port | ⭐⭐ `ANL-XC-009` |
| Trigger fatigue | ⭐ Analytics-originated triggers **rate-limited** | ⭐ `ANL-FR-025` |
| Guardian pressure on a minor | ⛔⛔ **Parent surfaces EXCLUDED** — §5.2 | ⭐⭐ `ANL-OBD-004`, `ANL-RSK-03` |
| Gaming the metric | ⭐ Honest labelling makes gaming pointless | ⭐ `ANL-FR-023` |
| Avoiding analytics entirely | ⭐ **Permitted** — analytics is never mandatory | ⭐ `ANL-FR-024` |

⭐⭐ **`ANL-XC-009` is the strongest anti-engagement-pressure control in the
repository, and it is structural rather than editorial:** `BC-26` holds **no
communication port** in `tool/module_dependencies.yaml` **L307–311**, so
⛔ **an analytics-driven re-engagement notification is unconstructable** — not
merely discouraged.

### 13.7 ⚠️ Two questions marked `[EXPERIMENT REQUIRED]` — preserved, not answered

| Question | ID | ⛔ Why I do not answer it |
|---|---|---|
| Optimal notification frequency | `ANL-GAP-008` | ⛔ **`[EXPERIMENT REQUIRED]`** — `[OWED — Product Owner]` |
| ⚠️⚠️ Whether Indian teen students prefer guardian-visible progress | `ANL-GAP-009` | ⛔⛔ The PRD states it *"**must not be assumed**"*. ⭐ **R-1** |

⭐⭐ **`ANL-GAP-009` interacts with §5.2 and the interaction is worth stating:**
even if `ANL-OBD-004` were resolved in favour of guardian analytics,
⛔ `ANL-GAP-009` would still be open on whether students *want* it. ⭐ **Two
independent unknowns guard the same door.**

### 13.8 ⚠️ `ANL-GAP-015` — no minor status exists, so no teen protections can be specified

⚠️ `ANL-GAP-015`: *"the repository establishes **no student age bands or minor
status**, so teen-specific protections cannot be specified on evidence."*
`[OWED — Product Owner + Legal]`.

⛔⛔ **Consequence, stated rather than worked around:** this document
**cannot** specify age-differentiated analytics treatment. ⭐ It applies the
**same** protections to every student — which is the conservative choice, ⛔ not
a solution to `ANL-GAP-015`.

---

## 14. Data Visualization Review

### 14.1 ⛔⛔ The governing rule — prose before chart, and no decorative chart

⭐⭐ `ANL-FR-035`: *"Every screen **MUST** lead with a **plain-language summary
before any chart**."*

⛔⛔ **This inverts the conventional dashboard grammar.** ⭐ The sentence is
**element 1**; the chart is **element 2 or lower**. ⛔ A chart-first layout is a
requirement breach, not a style choice.

⭐ **Every visualization below must pass a purpose test**, and any chart that
fails it is removed rather than decorated:

| Test | Requirement |
|---|---|
| **Purpose** | ⭐ Names a question the reader has |
| **Source metric** | ⭐ Resolves to a Certified Metric (`ANL-FR-001`) |
| **Interpretation** | ⭐ A plain-language summary precedes it (`ANL-FR-035`) |
| **Mobile** | ⭐ Readable without horizontal scroll (`ANL-FR-034`) |
| **Accessibility** | ⭐ Text or table equivalent (`ANL-FR-042`); ⛔ never colour alone (`ANL-FR-041`) |
| **Numerical clarity** | ⭐ Values legible, ⛔ not estimated from pixels |

⛔⛔ **A chart that fails any row is DECORATIVE and is PROHIBITED.**

### 14.2 ⭐ The 6 visualizations — each with purpose, source and mobile behaviour

⛔ **6, not more.** ⭐ Each is the **minimum** form that answers its question.

| # | Visualization | Surface | Purpose | Source metric | Mobile behaviour | ⭐ Accessible equivalent |
|---|---|---|---|---|---|---|
| **`V1`** | ⭐ **Stat card** *(single value + freshness)* | `A1`, `B1`, `B7` | *"What is true right now?"* | ⚠️ 1 per card | ⭐ Full width; stacks | ⭐ **Native** — it **is** text |
| **`V2`** | ⭐ **Line chart** — presence over 7/30 days | `A2`, `B3` | *"Is the trend rising or falling?"* | ⚠️ Uncertified *(cand. 1–4)* | ⭐ Full width, fixed height; ⛔ no pinch-zoom-only | ⭐⭐ **Data table** (`ANL-FR-042`) |
| **`V3`** | ⭐ **Horizontal bar** — attention items by severity | `B2` | *"What needs attention first?"* | ⚠️ Uncertified *(cand. 5–9, 12)* | ⭐ Horizontal bars stack vertically — ⭐ the mobile-correct orientation | ⭐ **Ordered list** with values |
| **`V4`** | ⭐ **Delta indicator** *(value + signed change + period label)* | `B3`, `B7` | *"Better or worse than last period?"* | ⭐⭐ `ProfileViews` **certified** for `B7` | ⭐ Inline with the value | ⭐ Signed text + **named period** |
| **`V5`** | ⭐ **Stacked list row** *(replaces any wide table)* | `A4`, `B2`, `B5` | *"Show me the items"* | ⚠️ Varies | ⭐⭐ **The mobile substitute for a data grid** — `ANL-FR-034` | ⭐ **Native** — it is a list |
| **`V6`** | ⭐ **Sparkline** *(inline micro-trend, no axes)* | `B3` | *"Trend shape at a glance"* | ⚠️ Uncertified | ⭐ Inline, ⛔ never the only trend affordance | ⭐⭐ **MUST** be paired with `V4`'s signed text |

⭐ **6 visualizations · 1 has a certified source · 5 do not** — ⛔ which is why
§9.7 marks only `B7` designable-now.

⛔⛔ **`V6` Sparkline carries a hard condition:** it has **no axes and no
labels**, so alone it would convey meaning by **shape** only. ⭐ `ANL-FR-041`
*(never colour alone)* and `ANL-FR-042` *(text equivalent)* together require it
to be **paired with `V4`**. ⛔ A bare sparkline is PROHIBITED.

### 14.3 ⛔ Charts REJECTED, with authority

| ⛔ Rejected | Why |
|---|---|
| ⛔⛔ **Pie / donut** | ⛔ `risk:high`; ⛔ *"accessibility-first context"* is its own contra-indication; ⛔ `ANL-FR-041` |
| ⛔⛔ **Gauge / progress ring** | ⛔⛔ Requires a **target**; ⛔ **no target exists** (§9.1.1). ⭐ **And a ring at 0% is the `ANL-FR-018` defect** |
| ⛔⛔ **Forecast / confidence band** | ⛔ §50 — predictive forecasting is an explicit non-requirement (**R-5**) |
| ⛔⛔ **3D anything** | ⛔ §14.7 |
| ⛔ **Streaming / live ticker** | ⛔ §50 bars real-time streaming; ⛔ `ANL-INV-008` bars implying currency |
| ⛔ **Treemap / sunburst / network** | ⛔ `risk:high`; ⛔ no hierarchy exists — `ANL-GAP-025` measures **no** branch/campus concept |
| ⛔ **Heatmap calendar** | ⚠️ **TBD not rejected** — ⛔ no certified metric supports it → `DD6-TBD-002` |
| ⛔ **Wide data grid** | ⛔⛔ `ANL-FR-034` — no horizontal scroll. ⭐ Replaced by `V5` |

### 14.4 ⭐ Colour, and the rule that colour is never the carrier

⭐ `ANL-FR-041`: *"No analytic **MUST** convey meaning by colour alone."*

| Meaning | ⭐ Primary carrier | Colour's role |
|---|---|---|
| Severity in `B2` | ⭐ **Text label + order** | ⚠️ Reinforcement only |
| Direction in `V4` | ⭐⭐ **Signed value + word** *(e.g. "up", "down")* | ⚠️ Reinforcement only |
| Series identity in `V2` | ⭐ **Direct label + line style** *(solid / dashed)* | ⚠️ Reinforcement only |
| Staleness `ST` | ⭐ **"Last updated" text** | ⚠️ Reinforcement only |
| Partial `PA` | ⭐ **"Partial" text** | ⚠️ Reinforcement only |

⛔⛔ **A red/green-only revenue indicator is PROHIBITED**, and it is worth naming
because it is the most common analytics accessibility defect.

### 14.5 ⭐ Label construction — the localisation rule with a visible consequence

⭐ `ANL-FR-036`: every metric label localizable — ⛔ *"no concatenated sentence
fragments"*.

| ⛔ Prohibited | ⭐ Required |
|---|---|
| ⛔ `"Present " + days + " of last 7 days"` | ⭐ One parameterised, localizable unit |
| ⛔ `"+" + pct + "% this week"` | ⭐ One unit with the period **named** (`ADR-0097` `T3`) |
| ⛔ `"Based on your " + source` | ⭐ One unit per source type (`ANL-FR-006`) |

⭐⭐ **`ADR-0097` `T3` makes this structural, not stylistic:** *"The period
**MUST** be labelled explicitly wherever the trend is rendered. ⛔ **A trend
without a stated period MUST NOT be rendered.**"* ⇒ ⛔ **`V4` and `V6` cannot
exist without their period label.**

### 14.6 ⭐⭐ The `B7` label prohibition — a vocabulary list, not a guideline

⭐ `ADR-0097` §4.3 fixes the label and **names the forbidden words**:

| ⭐ MUST read | ⛔ MUST NOT read |
|---|---|
| ⭐⭐ **"views"** | ⛔ visitors · ⛔ people · ⛔ unique visitors · ⛔ users · ⛔ viewers · ⛔ reach · ⛔ audience |

⭐ **Why:** §3.3 makes `ProfileViews` an **impression count** with ⛔ *no
viewer-level deduplication*, and §3.4 `B5` **counts the owner's own visits**.
⛔ Labelling it *"visitors"* would be a false claim about an inflated number.

### 14.7 ⭐ 2D / 2.5D / 3D allocation

| Treatment | Use | Count |
|---|---|---|
| ⭐ **2D** | ⭐ All 6 visualizations and all 11 surfaces | **6 / 11** |
| ⭐ **2.5D** | ⚠️ **Modest elevation on `B5` `AnalyticalReport` only** — ⭐ so a report reads as a **document**, matching `DD-0005`'s `F4`/`F5` precedent | **1** *(⛔ blocked surface)* |
| ⛔⛔ **3D** | ⛔⛔ **NONE** | **0** |

⛔⛔ **3D has no use case in analytics**, and the reason is a requirement, not
taste: ⭐ `ANL-FR-034` demands small-screen readability and ⭐ `ANL-FR-042`
demands a text equivalent. ⛔ A 3D chart degrades the first and cannot satisfy
the second — ⭐ `charts.csv` **#22** independently lists *"accessibility-required
environments"* and *"standard business dashboards"* as contra-indications.

⭐ **Consistent with `DD-0005`** *(14 × 2D, 2 × 2.5D, **0** × 3D)* and
⭐ `DD-0004`. ⛔ **No sibling Design Doc allocates any 3D.**

---

## 15. Export Review

⭐ Source: `ANL-FR-032`, `ANL-FR-033`, `ANL-FR-058`, `ANL-XC-006`,
`ANL-AC-013`, §41–42.

### 15.1 ⭐ What IS specified — and it is the behaviour, not the artefact

| Aspect | ⭐ Specified rule | Authority |
|---|---|---|
| **Initiation** | ⭐ Per-export **authorisation** — ⛔ not a standing permission | ⭐ `ANL-FR-032` |
| **Permission** | ⭐ Actor's in-app visibility governs the field set | ⭐⭐ `ANL-XC-006` |
| **Scope** | ⭐ Records actor, tenant, scope, **metric versions** and **freshness at generation time** | ⭐ `ANL-FR-032` |
| **Audit** | ⭐⭐ Every export **MUST** emit an audit fact to **`BC-24`** | ⭐ `ANL-FR-033` |
| **Background** | ⭐ *"**MUST** run as background work that cannot block an operational transaction"* | ⭐ `ANL-FR-058` |
| **Failure** | ⭐⭐ *"Explicit failure state, **never a partial passed off as complete**"* | ⭐ §41–42 |
| **Large export** | ⭐ Background + **pagination** | ⭐ §41–42 |
| **Unauthorized** | ⭐⭐ **Refused AND audited** | ⭐ §41–42, `ANL-AC-013` |
| **Field widening** | ⛔⛔ **UNCONSTRUCTABLE** — ⭐ *"there **MUST NOT** exist an export path that widens the field set. An export that could add a field is a **defect, not a setting**"* | ⭐⭐ `ANL-XC-006` |

⭐⭐ **`ANL-XC-006`'s impossibility form has a direct design consequence:** ⛔ the
export UI **MUST NOT** offer a field picker that could include a field absent
from the in-app view. ⭐ **The export's field set is the in-app field set** —
⛔ it is not a configurable.

### 15.2 ⛔⛔ What is NOT specified — and I invent none of it

| ⛔ Undefined | Authority for not inventing |
|---|---|
| ⛔⛔ **File format** *(PDF / CSV / XLSX)* | ⭐⭐ `ANL-GAP-011` — *"each must be **justified per report**, not adopted by default"*; ⭐ `ANL-GAP-014` — ⛔ the PRD **declines** to assume PDF |
| ⛔ Row / size limits | ⭐⭐ **REASSIGNED to `BC-21` Entitlement** — `ANL-CFG-002`; ⛔ **not `BC-26`'s** |
| ⛔ File naming convention | ⛔ **0** rule exists |
| ⛔ Delivery mechanism | ⭐⭐ **`ANL-XC-007`** — ⛔ *"Analytics **MUST NOT** deliver reports"*; ⭐ **unconstructable** — no communication port |
| ⛔ Progress-indicator granularity | ⛔ No latency or progress standard — `ANL-GAP-021` |
| ⛔ Retention of the artefact | ⭐ `ANL-GAP-012` — `[OWED — Privacy + BC-29]` |
| ⛔ Printability | ⭐ `ANL-GAP-014` — `[OWED — Product Owner]` |

⭐⭐ **`ANL-XC-007` settles the completion UX by removing an option.** ⛔ Since
`BC-26` cannot deliver, ⭐ a completed export **MUST** resolve **in-app** —
⛔ there is no "emailed to you" path, and one must not be drawn.
⚠️ **But the in-app retrieval mechanism itself is unspecified** →
**`DD6-GAP-005`**.

### 15.3 ⭐ Export states

| State | ⭐ Treatment | Authority |
|---|---|---|
| Initiating | ⭐ Authorisation checked **per export** | `ANL-FR-032` |
| In progress | ⭐ Background; ⛔ **MUST NOT block** an operational task | `ANL-FR-058` |
| Success | ⚠️ In-app resolution — ⛔ **mechanism `DD6-GAP-005`** | `ANL-XC-007` |
| Empty export | ⚠️ ⛔ **UNDEFINED** — ⚠️ is a 0-row export a success or an error? → `DD6-TBD-009` |
| Failure | ⭐⭐ Explicit; ⛔ **never a partial passed off as complete** | §41–42 |
| Unauthorized | ⭐ Refused **and audited** | `ANL-AC-013` |
| Data unavailable | ⭐ `UN` state; ⛔ ⛔ **MUST NOT export zeros** | `ANL-INV-008` |

⚠️ **`DD6-TBD-009` is a genuine design question I decline to settle:** an export
returning **0 rows** could be a legitimate result or a failure. ⭐ §41–42
requires failing *visibly*; ⛔ but it does not classify an empty result, and
guessing would create a behaviour no authority set.

---

## 16. Accessibility Review

⚠️⚠️ **PARTLY REFUSED — and the refusal is the honest position.**
⭐ `ANL-GAP-017` measures: *"contrast and type-scale targets: **no repository
accessibility standard exists**"*. `[OWED — Design]` · **NFR DECISION
REQUIRED** (`ANL-NFR-05`).

⛔⛔ **I classify. I do not ratify a standard**, and ⛔ I do not cite WCAG as
though the repository had adopted it.

### 16.1 ⭐ What IS binding — three requirements, and they are strong

| ID | Requirement | ⭐ Design consequence |
|---|---|---|
| ⭐⭐ **`ANL-FR-041`** | ⛔ No analytic conveys meaning by **colour alone** | ⭐ §14.4 — colour is **always** reinforcement |
| ⭐⭐ **`ANL-FR-042`** | ⭐ **Every chart MUST have a text or table equivalent** | ⭐⭐ §14.2 — every visualization carries one; ⭐ the table is the **accessible source of truth**, ⛔ not a fallback |
| ⭐⭐ **`ANL-FR-043`** | ⭐ Every metric screen-reader labelled with **name, value AND freshness** | ⭐ §16.2 |

⭐⭐ **`ANL-FR-042` is unusually strong for this repository** — ⛔ `PRD-007` and
`PRD-008` ratify **no** accessibility requirement at all (`DD-0004` §16,
`DD-0005` §14). ⭐ `PRD-009` ratifies **three**. ⭐ That is a real difference and
it is recorded as one.

### 16.2 ⭐ Screen-reader announcement — the three mandated elements

⭐ `ANL-FR-043` fixes **what** is announced; ⛔ it does not fix the order.

| Element | ⭐ Required |
|---|---|
| **Name** | ⭐ The metric's name |
| **Value** | ⭐ The value, or its **state** where there is no value |
| **Freshness** | ⭐⭐ Freshness — ⛔ **not optional** |

⭐ **A non-value state announces the state, not a number** — ⛔ *"zero"* must
never be announced for `EM`, `ND`, `IN`, `UN` or `SU`. ⚠️ Announcement **order**
and phrasing → `DD6-TBD-010`.

### 16.3 ⚠️ What is NOT ratified — and is left TBD, not invented

| Aspect | Status |
|---|---|
| ⛔ Contrast ratio | ⚠️ **`DD6-TBD-002`** *(shared)* — `ANL-GAP-017`; **R-4** |
| ⛔ Type scale | ⚠️ Same |
| ⛔ Touch-target minimum | ⚠️ **`DD6-TBD-004`** |
| ⛔ Text-scaling ceiling | ⚠️ ⛔ No standard; ⭐ `ANL-FR-034` requires reflow **without horizontal scroll** at any size |
| ⛔ Reduced-motion behaviour | ⚠️ ⛔ No standard; ⭐ Pro Max #99 **ADAPTED** as guidance only |
| ⭐ Cognitive accessibility | ⭐⭐ **Partly ratified** — `ANL-FR-035`'s plain-language-first rule **is** a cognitive-accessibility requirement |

⭐⭐ **`ANL-FR-035` is the repository's only ratified cognitive-accessibility
requirement, and it lives in this PRD.** ⭐ Worth naming, because it is
ordinarily the dimension most often omitted.

---

## 17. Cross-Context Ownership

### 17.1 ⭐ Ownership verification — 8 contexts + dashboards

⭐ `BC-26` owns *"the metric/semantic layer, read-model store, projections,
reports, exports"* (BC Map **L135**) and ⛔⛔ **owns NO domain fact** (`PRD-009`
§9).

| Context | Owns | ⛔ `BC-26` MUST NOT | Authority |
|---|---|---|---|
| **`BC-02`** Membership | ⭐ Membership facts, lifecycle | ⛔ Define membership validity | BC Map L409–413 |
| **`BC-03`** Attendance | ⭐⭐ Attendance facts **and corrections** | ⛔⛔ Correct attendance — ⭐ it **restates a metric**, ⛔ never the record | ⭐ `PRD-009` §10; BC Map L416 |
| **`BC-04`** Seating | ⭐ Seat facts, occupancy events, ⭐⭐ **the threshold** | ⛔⛔ Define an occupancy threshold — §10.3 cand. 6 | BC Map L418–419 |
| **`BC-05`** Fee & Finance | ⭐⭐ Financial facts — dues, payments, receipts, refunds | ⛔⛔ Own any financial fact; ⛔ define *"overdue"* | ⭐ `FEE-XC-012`/`013` disown metrics **to** `BC-26` |
| **`BC-18`** IAM | ⭐ Authorization **decisions** | ⛔⛔ Decide authorization; ⛔⛔ **derive any metric from `iam.*`** | ⭐⭐ `ANL-XC-012`, `AN-3`; §20.1 |
| **`BC-21`** Entitlement | ⭐⭐ **Limits and gates** | ⛔ Define an export row cap | ⭐ `ANL-CFG-002` **REASSIGNED**; BC Map L130 |
| **`BC-22`** Notifications | ⭐⭐ Delivery, rate rules | ⛔⛔ Send or schedule anything — ⭐ **unconstructable** | ⭐⭐ `ANL-XC-007`, `ANL-XC-009` |
| **`BC-24`** Audit | ⭐ The audit record | ⛔ Be an audit substitute | ⭐ `ANL-FR-033` emits **to** `BC-24` |
| **`BC-19`** Tenancy | ⭐ The tenant record; ⭐ produces `LibraryProfileViewed` | ⛔ n/a — ⭐ `BC-19` gains **no** analytics capability | ⭐ `ADR-0096`; BC Map §17 |
| ⛔⛔ **Dashboards 10–12** | ⛔⛔ **NOT A CONTEXT** — presentation composition | ⭐⭐ `BC-26` **exposes** metrics; ⛔ dashboards **MUST NOT** compute their own values | ⭐⭐ BC Map **L84**; `ANL-FR-029`; `MP-GBR-36` |

⭐ **10 rows · 0 duplicate ownership · 0 ownership change.**

### 17.2 ⭐⭐ The `BC-05` ↔ `BC-26` boundary — verified in both directions

⭐⭐ **This boundary is unusually well-evidenced, because both sides disown the
same thing:**

| Direction | Statement |
|---|---|
| ⭐ From `BC-05` | `FEE-XC-012`/`FEE-XC-013` **disown** metric definition and the reporting store **to `BC-26`**; ⭐ `PRD-008` §22 — *"This draft claims **no report** as a V1 deliverable of `BC-05`; **it delivers facts**"* |
| ⭐ From `BC-26` | `PRD-009` §9 — ⛔ *"**Does not own:** any domain fact. Every number derives from another context's event"* |
| ⭐ `DD-0005` §16 | ⛔ *"`DD-0005` therefore contains **NO** dashboard, **NO** report and **NO** export surface"* |

⭐⭐ **The two Design Docs are complementary, not overlapping:** ⛔ `DD-0005`
contains **0** report/export surfaces; ⭐ `DD-0006` contains **`B5`** and
**`B6`**. ⭐ **No surface appears in both.**

### 17.3 ⭐ `ANL-XC` constraints — all 12 preserved

| ID | Constraint | ⭐ Preserved by |
|---|---|---|
| `ANL-XC-001` | ⛔ No learning/mastery/performance claim | ⭐ §4.2 #1, §13.4 #3 |
| `ANL-XC-002` | ⛔ No peer-identified student visibility | ⭐ §8.2 |
| `ANL-XC-003` | ⛔ No rank / failure label / fear / negative peer comparison | ⭐ §13.4 |
| `ANL-XC-004` | ⛔ No leaderboard *(**impossible** — `MP-GBR-21`)* | ⭐ §4.2 #2 |
| `ANL-XC-005` | ⛔ Reception cannot see aggregate financial analytics | ⭐ §8.2 |
| `ANL-XC-006` | ⛔ No export field outside in-app visibility | ⭐ §15.1 |
| `ANL-XC-007` | ⛔ No report delivery | ⭐ §15.2 |
| `ANL-XC-008` | ⛔ Analytics is not a route to inaccessible data | ⭐ §5.3, §9.4 |
| `ANL-XC-009` | ⛔ No notification sent | ⭐ §13.6 |
| `ANL-XC-010` | ⛔ No AI figure untraceable to a Certified Metric | ⭐ §17.4 |
| `ANL-XC-011` | ⛔ No unauthorised external ingestion | ⭐ §4.2 #20 |
| `ANL-XC-012` | ⛔⛔ No `iam.*`-derived metric | ⭐ §4.2 #5, §20.1 |

⭐ **12 of 12 preserved. 0 weakened.**

### 17.4 ⭐ The AI boundary — no surface, but a constraint on every surface

⭐ `E-26`: AI retrieves *"through permission-aware ports only — never direct
index or table access"*.

| Rule | ⭐ Design consequence |
|---|---|
| `ANL-FR-045` | ⛔ AI **MUST NOT** redefine, recompute or override a Certified Metric |
| `ANL-FR-046` | ⭐ Every AI analytic statement **cites metric IDs and versions** |
| `ANL-FR-047` | ⭐ AI represents uncertainty; ⛔ **MUST NOT** state a number absent from a certified metric |
| `ANL-XC-010` | ⛔⛔ Hallucinated analytics **structurally impossible**, ⛔ not merely discouraged |

⛔⛔ **No AI surface is designed here** — `PRD-009` §44.4 classifies AI narrative
summaries as **V3**. ⭐ The constraint is recorded because an AI-rendered figure
would otherwise bypass every rule in §10.

---

## 18. Design-System Dependencies & Implementation Deviations

### 18.1 ⭐ Tokens — consumed, ⛔ never invented

⭐ `LiblColors` and `LiblSpace` (`lib/app/shared/theme.dart`) are the only token
sources. ⚠️ **Their values are unratified** — ⭐ `FIGMA_FOUNDATION.md` **L30**
states token names and values are **`TO BE DECIDED`**. ⛔ **No new token is
defined here.** ⭐ Same `DBT-001` substitution carried by `DD-0001`…`DD-0005`.

### 18.2 ⭐ Components — existing, proposed, prohibited

| Component | Use | Status |
|---|---|---|
| `PanelCard`, `SectionHeader`, `Pill`, `EmptyState`, `MetricTile` | ⭐ Reusable | ⭐ **EXISTS** (`lib/app/shared/widgets/common.dart`) |
| ⭐⭐ **`MetricTile`** | ⭐ `V1` stat card | ⭐⭐ **EXISTS and is directly applicable** — ⭐ the most reusable component for this context |
| ⭐⭐ **`EmptyState`** | ⭐⭐ `EM` state — `ANL-FR-018` | ⭐⭐ **EXISTS** — ⛔ but ⚠️ must be verified to render **no zero** |
| ⛔⛔ **`MeterBar`** | ⛔⛔ **PROHIBITED** | ⛔⛔ It renders a **fraction of a whole**, which requires a **denominator/target**. ⛔ **No target exists** (§9.1.1), and ⭐ a bar at 0% is the `ANL-FR-018` defect. ⭐ **Same prohibition `DD-0004` and `DD-0005` applied**, for different reasons each time |

⭐ **5 new components PROPOSED** *(⛔ design-level only, ⛔ no product effect,
⛔ 0 created in code)*:

| Proposed | Purpose | ⭐ Why it cannot be an existing component |
|---|---|---|
| `SummaryLead` | ⭐⭐ The mandatory plain-language sentence | ⭐ `ANL-FR-035` makes it **element 1** on every surface; no component holds that role |
| `FreshnessLabel` | ⭐⭐ Value + freshness, inseparably | ⭐ `ANL-INV-009` requires freshness to travel **with** the value |
| `TrendDelta` | ⭐ `V4` — signed change **+ named period** | ⭐⭐ `ADR-0097` `T3` — ⛔ a trend without a period **MUST NOT** render |
| `MetricStateBlock` | ⭐ Renders one of the 7 non-value states | ⭐⭐ ⛔ **Must be structurally incapable of rendering zero** |
| `DataTableEquivalent` | ⭐ `ANL-FR-042`'s chart equivalent | ⭐ The **accessible source of truth**, ⛔ not a fallback |

⛔⛔ **`MetricStateBlock` is the most important proposal in this document**, and
it is deliberately defined by what it **cannot** do: ⛔ a component that
*cannot* render zero makes the `ANL-FR-018` / `ADR-0097` `P3` / `U2` family of
defects structurally impossible rather than merely prohibited.

### 18.3 ⛔⛔ No charting dependency exists — and none is chosen

| Measurement | Value |
|---|---|
| Chart libraries in `pubspec.yaml` | ⛔⛔ **0** |
| `CustomPaint` / chart widgets in `lib/app/` | ⛔⛔ **0** — measured |
| UI/UX Pro Max library recommendations | ⛔⛔ **All JavaScript** — REJECTED (§7) |

⛔⛔ **I decline to select a charting approach.** ⭐ Choosing between a Flutter
package and hand-rolled `CustomPaint` is a **technical-specification decision**
(`TS-*`, Stage 6A, `ADR-0131`), ⛔ not a Design Doc's. → **`DD6-TBD-011`**.

### 18.4 ⛔⛔ Implementation deviations — 7 recorded, 0 fixed

⛔⛔ **CODE IS NOT PRODUCT AUTHORITY.** ⭐ Recorded as **evidence**; ⛔ **none is
fixed here**, and ⛔ **none becomes a requirement**.

| ID | Location | Deviation | ⛔ Violates |
|---|---|---|---|
| ⛔⛔ **`AIV-A01`** | `analytics.dart` **L1–2** | ⛔ Header reads *"**Analytics Platform — R5** (**BC-22** Insights)"* | ⛔⛔ **Two errors in one line:** the manifest declares **`rank: 7`**, not R5; and **`BC-22` is Notification Delivery**, not analytics. ⭐ `BC-26` is the owner (BC Map **L135**) |
| ⛔⛔ **`AIV-A02`** | `analytics.dart` **L65, L68** | ⛔ `_feed` and `_attendanceDays` are **global**, ⛔ not keyed by tenant — while `_byTenant` (**L64**) is correctly partitioned | ⛔⛔ **`ANL-INV-006`** *(cross-tenant read impossible)* + **BC Map L490** *(projections are **all** tenant-partitioned)*. ⛔⛔ `distinctAttendanceDays()` therefore returns a **cross-tenant** count |
| ⛔⛔ **`AIV-A03`** | `analytics.dart` | ⛔ **No semantic layer**; ⛔ metrics are **inline field increments** with no definition, owner, version or source record | ⛔⛔ **F-1** — Rank 1 `MP-GBR-36` **and** manifest assertion **`AN-2`**; `ANL-GAP-001` **HIGH RISK** |
| ⛔ **`AIV-A04`** | `analytics.dart` `register()` | ⛔ **8 of 24** routed events consumed — ⛔ `AttendanceCorrected` **not** among them | ⛔ **`ANL-GAP-002`** — ⭐ BC Map **L416** assigns it *"restated metrics"*; ⛔ `ANL-FR-053` cannot be satisfied. ⭐ `ANL-GAP-024` asks which of the 16 unconsumed are V1 |
| ⛔ **`AIV-A05`** | `analytics.dart` **L36–48** | ⛔ `DashboardMetrics` names 8 counters + 2 derived getters — ⛔ **none is a `CertifiedMetric`** | ⛔ `ANL-FR-008` *(nine fields)*, `ANL-FR-009` *(reject, don't blank)* |
| ⚠️ **`AIV-A06`** | `analytics.dart` **L76** | ⚠️ `feed({int limit = 20})` returns raw `ActivityItem`s — ⛔ a per-event output with no access rules | ⚠️ **`ANL-OBD-007` OPEN**; ⛔ `ANL-XC-008` risk |
| ⚠️ **`AIV-A07`** | `analytics.dart` **L46** | ⭐ Money kept as minor-unit `int`, ⛔ deliberately **not** `Money` | ⭐⭐ **NOT a defect** — ⭐ `PRD-009` §8.3 **endorses** it: *"Analytics must not depend on domain arithmetic rules, only on reported amounts"*. ⭐ Recorded to show the inventory is not one-sided |

⚠️ **Design consequence:** these surfaces are specified against **`PRD-009` as
governed by `ADR-0097`**, ⛔ **not** against the current code. ⭐ An implementer
will find the code exposes **10** uncertified counters where the design exposes
**1** certified metric — ⭐ **the design is right and the code is the defect.**

⛔ **Test status stated plainly:** `flutter test` was **NOT run** for this
document; it was written by **inspection**. ⛔ **0** surface tests exist for
`BC-26`. ⭐ `test/architecture/every_projection_rebuildable_test.dart` proves
**rebuild** *(`AN-1`)*, ⛔ **not** any surface, metric definition or state.

---

## 19. Gaps

### 19.1 ⛔⛔ Inherited — all 25 `ANL-GAP-*` PRESERVED OPEN

⛔⛔ **This document closes NONE of them.** ⭐ Listed so no reader mistakes
silence for closure:

`-001` no semantic layer *(**HIGH**, also breaches `AN-2`)* · `-002`
`AttendanceCorrected` unconsumed · `-003`…`-006` no learning/mastery/effort/
academic source *(**BLOCKER**)* · `-007` quarterly rebuild schedule · `-008`
notification frequency *(**EXPERIMENT**)* · `-009` guardian-visibility
preference *(**EXPERIMENT**)* · `-010` minimum cohort size · `-011` export
formats · `-012` export retention · `-013` locale readiness · `-014`
printability · `-015` student age / minor status · `-016` DPDP for derived
analytics · `-017` accessibility targets · `-018` analytics→`BC-22` edge ·
`-019` multi-product compatibility · `-020` freshness targets · `-021`
performance targets · `-022` DLQ thresholds · `-023` tenant migration /
transfer · `-024` which of the 16 unconsumed events are V1 · `-025` no
branch/campus hierarchy concept.

⭐ **25 of 25 OPEN. 0 closed. 0 downgraded.**

### 19.2 ⛔⛔ The three findings — PRESERVED

| ID | Finding | ⭐ Status here |
|---|---|---|
| ⛔⛔ **F-1** | ⭐ No semantic layer exists, though `MP-GBR-36` requires one | ⛔⛔ **PRESERVED OPEN** — ⭐ §10.1 states it; ⛔ **this document does NOT depict a completed semantic layer** |
| ⛔⛔ **F-2** | ⭐ No learning-outcome data source | ⛔⛔ **PRESERVED OPEN** — ⭐ §4.2 #1 excludes learning analytics entirely |
| ⛔⛔ **F-3** | ⭐ A peer leaderboard is unlawful under `MP-GBR-21` | ⛔⛔ **PRESERVED OPEN** — ⭐ §4.2 #2, §13.4 #1 |

### 19.3 ⭐ New design gaps — `DD6-GAP-001` … `DD6-GAP-005`

⭐ IDs are **local to this document** and ⛔ create no requirement.

| ID | Gap | Blocking? | Owner |
|---|---|---|---|
| ⛔⛔ **`DD6-GAP-001`** | ⛔ `A3` Motivation has **no milestone definition and no goal value** — §15's source column reads *"derived"* | ⛔⛔ **BLOCKING `A3` only** | Product Owner |
| ⛔⛔ **`DD6-GAP-002`** | ⛔ `ANL-FR-028` mandates a **drill-down path**; ⛔ **no destination, depth or dimension is specified** — and drill-down is classified **V2** | ⛔⛔ **BLOCKING `B4` only** | Product Owner + Architecture Owner |
| ⛔⛔ **`DD6-GAP-003`** | ⛔ **0 `AnalyticalReport` instances defined** — ⭐ the 14-field contract exists, ⛔ no report does | ⛔⛔ **BLOCKING `B5` only** | Product Owner |
| ⛔⛔ **`DD6-GAP-004`** | ⛔⛔ **13 candidate metrics, each missing at least one of the nine `ANL-FR-008` fields** | ⛔⛔ **BLOCKING the VALUES of 7 partial surfaces** *(⛔ not their layout)* | Architecture Owner + Product Owner *(per `ANL-OBD-001`)* |
| ⚠️ **`DD6-GAP-005`** | ⛔ Export completion has **no in-app retrieval mechanism** — ⭐ `ANL-XC-007` removes delivery, ⛔ nothing replaces it | ⚠️ **Non-blocking** — `B6` remains partially designable | Product Owner |

⭐ **5 new gaps · 4 BLOCKING, each blocking only its named subset · 1
non-blocking.**

⭐⭐ **`DD6-GAP-004` is the one that matters most**, and its scope is precise:
⛔ it blocks the **values** of `A1`, `A2`, `A4`, `B1`, `B2`, `B3`, `B6` —
⭐ **not their layout, states, labels or information order**, all of which are
specified here.

### 19.4 ⭐ Consistency with `DD-0001`…`DD-0005`

⭐ Conventions **reused** where compatible:

| Convention | Source | ⭐ Applied |
|---|---|---|
| App + Role Boundary section with 5 declarations | `DD-0003` §3 *(first)* | ⭐ §5 |
| 13-check App-Boundary QA | `DD-0003` §4 | ⭐ §5.4 — ⚠️ **12/13**, 1 GAP disclosed |
| Local surface IDs, non-requirement | `DD-0004`, `DD-0005` | ⭐ §9 |
| Traceability table PRD → treatment → status | `DD-0002` §19, `DD-0005` §8 | ⭐ §21 |
| Conflicts preserved, ⛔ never resolved | `DD-0004` §22, `DD-0005` §20 | ⭐ §20 |
| ⛔ `MeterBar` prohibited | `DD-0004`, `DD-0005` §17.2 | ⭐ §18.2 — ⭐ **third consecutive prohibition**, ⭐ third distinct reason |
| 2D / 2.5D / 3D allocation with **0** 3D | `DD-0003` §26, `DD-0004` §18, `DD-0005` §17.4 | ⭐ §14.7 |
| UI/UX Pro Max ADOPT/ADAPT/REJECT/TBD table | `DD-0005` §17.3 | ⭐ §7 |
| Implementation deviations recorded, ⛔ 0 fixed | `DD-0005` §18 | ⭐ §18.4 |
| Expert findings with **refusals recorded** | `DD-0005` §1.4 | ⭐ §3, §3.1 |

⚠️⚠️ **Three documented divergences** — ⭐ each with a reason, ⛔ none silent:

| # | Divergence | ⭐ Reason |
|---|---|---|
| **1** | ⛔⛔ **`TR-5` Parent EXCLUDED** *(`DD-0003`/`DD-0005` include it)* | ⭐⭐ **`ANL-OBD-004`** — ⛔ *"DECISION REQUIRED before any guardian-facing analytic ships"*. §5.2 |
| **2** | ⚠️ **App-Boundary QA is 12/13, not 13/13** | ⭐⭐ **`PRD-009` carries no closed permission matrix**; `ANL-OBD-003` owns it. ⛔ Claiming 13/13 would mean inventing it. §5.4 |
| **3** | ⭐⭐ **A state model dominated by NON-value states** *(7 of 11)* | ⭐ No sibling context has this shape — ⭐ an analytics surface's hardest problem is **the absence of a number**, not its value. §12.2 |

---

## 20. Conflicts & Open Decisions

### 20.1 ⛔⛔ `ANL-AL-B1` — a live Rank-4 vs Rank-4 conflict, PRESERVED

⛔⛔ **PRESERVED UNRESOLVED**, in the mandated four-part structure.

| Part | Content |
|---|---|
| ⭐ **1. GOVERNING V1 RULE** | ⭐⭐ **`ANL-XC-012`** *(Rank 3, FROZEN)*: `BC-26` **MUST NOT** derive any projection, metric or dimension from an `iam.*` event. ⭐ **Impossibility form:** `tool/module_dependencies.yaml` **L315–316** declares `excluded_events: ["iam.*"]`, so a compliant subscription list **cannot contain** an `iam.*` topic; assertion **`AN-3`** is the mechanical test |
| ⛔ **2. CONFLICTING LOWER-RANKED REQUIREMENT** | ⚠️⚠️ ⛔ **Neither side is lower-ranked — that is the whole difficulty.** **BC Map L434** *(Rank 4)* routes `iam.AccountCreated` / `SessionRevoked` / `ConsentGranted` to **`BC-26`**, purpose *"Security **audit**"*. ⛔ `tool/module_dependencies.yaml` **L315–316** *(also Rank 4)* **excludes** `iam.*`, closing `CFL-28` via amendment **`A-6`**. ⛔⛔ **Both are Rank 4, so precedence cannot break the tie** |
| ⭐ **3. DESIGN CONSEQUENCE** | ⭐⭐ **0 surfaces in this document render any `iam.*`-derived value.** ⛔ No account-creation metric, ⛔ no session metric, ⛔ no consent metric appears in §9's inventory or §10's candidate list. ⭐ The **safe side** is taken, exactly as `ANL-XC-012` directs. ⭐ Disclosed: the live code subscribes to **no** `iam.*` event, so the implementation **already complies** and the conflict is **documentary, not a live code defect** |
| ⛔ **4. UNRESOLVED GOVERNANCE REPAIR** | ⛔⛔ **`ANL-OBD-008` is OPEN and routed to the Architecture Owner.** ⛔ **Nothing in this Design Doc resolves it.** ⭐ `ANL-AC-017` makes the safe side testable. ⚠️ Should the Architecture Owner later rule that **L434** governs, ⭐ `ANL-XC-012` *"is relaxed by ADR"* — ⛔ **not** by a Design Doc |

### 20.2 ⚠️⚠️ `GAP-BCMAP-BC26-EDGES` — a second pre-existing anomaly, PRESERVED

| Part | Content |
|---|---|
| ⭐ **1. GOVERNING V1 RULE** | ⭐⭐ **BC Map §7 L292** *(Rank 4)*: *"**If an edge is not in this table, it does not exist.**"* |
| ⛔ **2. CONFLICTING LOWER-RANKED REQUIREMENT** | ⚠️⚠️ ⛔ **Again a same-rank internal inconsistency.** BC Map **§9** records `BC-26` as *"Primary consumer"* in roughly **twenty** event rows *(e.g. **L405** `enrollment.StudentEnrolled`)*, ⛔ **while §7 declares no edge into `BC-26` other than `E-26`** *(AI retrieval)* and **`E-30`** *(added by `ADR-0096`)*. ⭐ Measured and recorded by the BC Map itself at **§17.4** |
| ⭐ **3. DESIGN CONSEQUENCE** | ⚠️⚠️ ⛔ **Every surface except `B7` depends on an event whose edge §7 does not declare.** ⭐ `B7` is the **only** surface resting on a declared edge — **`E-30`**. ⭐⭐ **This is a second, independent reason `B7` is the only DESIGNABLE-NOW surface** (§9.2.1), and it was not anticipated when that classification was made on metric grounds |
| ⛔ **4. UNRESOLVED GOVERNANCE REPAIR** | ⛔⛔ **Routed to the Architecture Owner as a separate question** by BC Map §17.4. ⭐ `ADR-0096` §1.2 **expressly refused** to use the anomaly as its authority, because that *"would resolve a pre-existing, unrelated inconsistency as a side effect"*. ⛔ **This Design Doc refuses for the same reason** — ⛔ it is not mine to resolve, and ⛔ I do not treat ~20 undeclared edges as existing merely because surfaces depend on them |

⭐⭐ **§20.2 is the most consequential discovery of this authoring pass.** ⛔ It
means the designability of 10 of 11 surfaces rests on an architectural question
that is **open at Rank 4** — ⭐ and it strengthens, rather than weakens, the
`B7`-only verdict reached independently in §9.

### 20.3 ⭐ All 9 `ANL-OBD-*` open decisions — PRESERVED

| ID | Decision | Owner | ⭐ Effect here |
|---|---|---|---|
| `ANL-OBD-001` | Who owns a Certified Metric definition | Arch + PO | ⛔ `DD6-GAP-004` cannot be routed to a single owner |
| `ANL-OBD-002` | Is a cohort band `self` or a fourth scope | Arch + Privacy | ⛔ Cohort bands excluded — §4.2 #13 |
| ⛔⛔ `ANL-OBD-003` | **Per-role metric visibility matrix** | PO + `BC-18` | ⛔⛔ §8 is **structural only**; ⚠️ QA check 6 = **GAP** |
| ⛔⛔ `ANL-OBD-004` | Does `guardianOf` extend to derived analytics | Privacy + `BC-18` | ⛔⛔ **`TR-5` Parent EXCLUDED** — §5.2 |
| `ANL-OBD-005` | Does `BC-26` ever emit an event | Arch | ⛔ No analytics-originated notice designed |
| `ANL-OBD-006` | Retention of projections | Arch + Legal | ⛔ No history-depth control designed |
| `ANL-OBD-007` | `Projection` granularity; ⭐ is `feed()` a metric? | Arch | ⛔ **No activity-feed surface** — §9.4 |
| ⛔⛔ `ANL-OBD-008` | **The Rank-4 `iam.*` conflict** | Arch | ⛔⛔ §20.1 |
| `ANL-OBD-009` | Enterprise customization boundary | PO + Arch | ⛔ No filters / saved views designed — §4.2 #14 |

⭐ **9 of 9 PRESERVED. 0 resolved.**

### 20.4 ⭐ New design TBDs — `DD6-TBD-001` … `DD6-TBD-011`

⭐ Each names a **named authority**. ⛔ None is answered here.

| ID | Question | Owner |
|---|---|---|
| `DD6-TBD-001` | ⚠️ Indian digit grouping *(`₹1,20,000` vs `₹120,000`)* | `BC-25` + Product Owner |
| `DD6-TBD-002` | ⛔ Contrast ratio + type scale *(`ANL-GAP-017`)* | Design |
| `DD6-TBD-003` | ⚠️ What is an *"attendance anomaly"*? | Product Owner |
| `DD6-TBD-004` | ⛔ Touch-target minimum | Design |
| `DD6-TBD-005` | ⚠️⚠️ **Visual treatment of a restated value** *(`ANL-FR-052` requires visibility, ⛔ defines none)* | Design + Product Owner |
| `DD6-TBD-006` | ⚠️⚠️ **Is `B1` Reception a `BC-26` surface or dashboard scope?** | Product Owner + Architecture Owner |
| `DD6-TBD-007` | ⚠️ Is tenant-scoped AI cost an Owner-visible metric? | Product Owner |
| `DD6-TBD-008` | ⚠️⚠️ **Prominence/discretion of a dues flag at a public counter** | Product Owner + Privacy |
| `DD6-TBD-009` | ⚠️ Is a 0-row export a success or an error? | Product Owner |
| `DD6-TBD-010` | ⚠️ Screen-reader announcement order | Design |
| `DD6-TBD-011` | ⚠️ Charting approach *(Flutter package vs `CustomPaint`)* | ⭐ **`TS-*` / Stage 6A** — ⛔ not a Design Doc decision |

⭐ **11 TBDs, each with a named owner.**

---

## 21. Traceability

### 21.1 ⭐ Requirement → treatment

| PRD/ADR/GAP ID | Requirement / Issue | ⭐ `DD-0006` treatment | Status |
|---|---|---|---|
| `MP-GBR-36` | No surface defines its own formula | ⭐ §10 — ⛔ 0 metrics defined | ⭐ **SUPPORTED** |
| `MP-GBR-21` | Closed 3-scope register | ⭐ §8.1 — `self` / `tenantWide` only | ⭐ **SUPPORTED** |
| `MP-GBR-24` | Student fees ≠ SaaS revenue | ⭐ §5.1, §10.3 cand. 7 | ⭐ **SUPPORTED** |
| ⭐⭐ `ADR-0097` §3 | `ProfileViews` certified, 9 fields | ⭐⭐ §10.2, `B7` | ⭐⭐ **SUPPORTED** |
| ⭐⭐ `ADR-0097` §5 | `UniqueViewers` NOT certified, 8 rules | ⭐ §10.4 | ⭐⭐ **SUPPORTED** |
| `ADR-0097` §4.3 | Label MUST read *"views"* | ⭐ §14.6 | ⭐ **SUPPORTED** |
| `ADR-0097` §4.4 | Unauthorised ⇒ **absent** | ⭐ §8.3, state `PR` | ⭐ **SUPPORTED** |
| `ADR-0097` `T3`/`T4` | Period named; trend omitted when insufficient | ⭐ §12.2 `IN`, §14.5 | ⭐ **SUPPORTED** |
| `ADR-0097` `P2`/`P3` | Suppression, ⛔ never zero | ⭐ §12.2 `SU` | ⭐ **SUPPORTED** |
| `ADR-0096` §17.2.1 | Payload carries no viewer identity | ⭐ §10.2, §10.4 | ⭐ **SUPPORTED** |
| `ANL-FR-001` | Every output resolves to a Certified Metric | ⚠️ §10.3 — ⛔ 13 candidates cannot | ⛔ **GAP** — `DD6-GAP-004` |
| `ANL-FR-006` | Student metric states its derivation | ⭐ §11.1 | ⭐ **SUPPORTED** |
| `ANL-FR-008`/`-009` | 9 fields; reject rather than blank | ⭐ §10.1–10.3 | ⭐ **SUPPORTED** |
| `ANL-FR-011` | Output states metric version | ⭐ §11.1 | ⭐ **SUPPORTED** |
| ⭐ `ANL-FR-016` | Student sees only own analytics | ⭐ §8.1, §5.3 | ⭐ **SUPPORTED** |
| `ANL-FR-017` | Personal-progress framing, not comparison | ⭐ §13.4 | ⭐ **SUPPORTED** |
| ⭐⭐ `ANL-FR-018` | ⛔ Never a zero as a score | ⭐⭐ §12.2 `EM`, §13.2, `MetricStateBlock` | ⭐⭐ **SUPPORTED** |
| `ANL-FR-019` | Student sees own dues/history | ⭐ `A4` | ⭐ **SUPPORTED** |
| `ANL-FR-020` | No negative value judgement | ⭐ §13.2, §13.4 | ⭐ **SUPPORTED** |
| ⭐ `ANL-FR-021` | Streak not loss-framed, ⛔ not primary | ⭐ §13.3 | ⭐ **SUPPORTED** |
| `ANL-FR-023` | Attendance-lever metric labelled as attendance | ⭐ §13.4 | ⭐ **SUPPORTED** |
| `ANL-FR-024` | Analytics never mandatory | ⭐ §12.4 | ⭐ **SUPPORTED** |
| ⭐ `ANL-FR-027` | `Status → Attention → Action → Analysis` | ⭐ §9.5 | ⭐ **SUPPORTED** |
| ⚠️ `ANL-FR-028` | Name metric + threshold + **drill-down path** | ⛔ `B4` **BLOCKED** | ⛔ **GAP** — `DD6-GAP-002` |
| ⭐ `ANL-FR-029` | Dashboards compose; ⛔ never compute | ⭐ §4.3, §17.1 | ⭐ **SUPPORTED** |
| ⚠️ `ANL-FR-030`/`-031` | 14-field report contract | ⛔ `B5` **BLOCKED** | ⛔ **GAP** — `DD6-GAP-003` |
| `ANL-FR-032`/`-033` | Export authorised + audited | ⭐ §15.1 | ⭐ **SUPPORTED** |
| ⭐ `ANL-FR-034` | No horizontal scroll | ⭐ §6.1, `V5` | ⭐ **SUPPORTED** |
| ⭐⭐ `ANL-FR-035` | Plain-language summary **before any chart** | ⭐⭐ §14.1, `SummaryLead` | ⭐⭐ **SUPPORTED** |
| `ANL-FR-036` | Labels localizable, ⛔ no concatenation | ⭐ §14.5 | ⭐ **SUPPORTED** |
| `ANL-FR-037` | INR + IST | ⚠️ §11.3 | ⚠️ **TBD** — `DD6-TBD-001` |
| `ANL-FR-038` | Query carries tenant + permissions | ⭐ §8.4 | ⭐ **SUPPORTED** |
| `ANL-FR-039`/`-040` | Anonymisation / privacy mode honoured | ⭐ §21.2 | ⭐ **SUPPORTED** |
| `ANL-FR-041` | ⛔ Never colour alone | ⭐ §14.4 | ⭐ **SUPPORTED** |
| ⭐⭐ `ANL-FR-042` | Every chart has a text/table equivalent | ⭐⭐ §14.2, `DataTableEquivalent` | ⭐⭐ **SUPPORTED** |
| `ANL-FR-043` | Screen-reader: name + value + freshness | ⭐ §16.2 | ⭐ **SUPPORTED** |
| `ANL-FR-052`/`-053` | Restatement visible | ⚠️ §12.1 — state `R` | ⚠️ **TBD** — `DD6-TBD-005` |
| `ANL-FR-054` | Partial marked, ⛔ not under-reported | ⭐ §12.2 `PA` | ⭐ **SUPPORTED** |
| `ANL-FR-056` | Stale shows last-updated | ⭐ §12.2 `ST` | ⭐ **SUPPORTED** |
| `ANL-FR-057` | Freshness expectation; breach visible | ⚠️ §11.1 — ⛔ number owed | ⚠️ **GAP** — `ANL-CFG-003` |
| `ANL-FR-058` | Export is background work | ⭐ §15.1 | ⭐ **SUPPORTED** |
| `ANL-BR-004` | Role alone grants no visibility | ⭐ §8.1 | ⭐ **SUPPORTED** |
| `ANL-INV-006`/`-007` | Tenant-scoped; 3 scopes | ⭐ §5.1, §8.4 | ⭐ **SUPPORTED** |
| `ANL-INV-008`/`-009` | ⛔ Stale never current; freshness carried | ⭐ §11.2 | ⭐ **SUPPORTED** |
| `ANL-XC-001`…`-012` | 12 exclusions | ⭐ §17.3 — **12/12** | ⭐ **SUPPORTED** |
| ⛔⛔ **F-1** | No semantic layer | ⭐ §10.1, §19.2 | ⛔ **PRESERVED OPEN** |
| ⛔⛔ **F-2** | No learning data | ⭐ §4.2 #1, §19.2 | ⛔ **PRESERVED OPEN** |
| ⛔⛔ **F-3** | No lawful leaderboard | ⭐ §4.2 #2, §19.2 | ⛔ **PRESERVED OPEN** |
| ⛔⛔ `ANL-AL-B1` | Rank-4 `iam.*` conflict | ⭐ §20.1 | ⛔ **PRESERVED OPEN** |
| ⛔ `GAP-BCMAP-BC26-EDGES` | ~20 undeclared consumer edges | ⭐ §20.2 | ⛔ **PRESERVED OPEN** |
| `ANL-GAP-001`…`-025` | 25 gaps | ⭐ §19.1 | ⛔ **25/25 PRESERVED OPEN** |
| `ANL-OBD-001`…`-009` | 9 open decisions | ⭐ §20.3 | ⛔ **9/9 PRESERVED OPEN** |

### 21.2 ⭐ Privacy requirements — surface treatment

| ID | Requirement | ⭐ Treatment |
|---|---|---|
| `ANL-FR-039` | `PersonAnonymised` removes the person from identifiable output | ⭐ The subject **disappears** from `V5` lists and `A*` surfaces; ⛔ **no tombstone, no "deleted user" row** |
| `ANL-FR-040` | `PersonPrivacyModeChanged` honoured with **no propagation window** | ⭐ ⛔ **No "updating…" interstitial** — ⭐ the change is immediate by requirement (`SEV-9`) |
| `ANL-XC-008` | Analytics is not a route to inaccessible data | ⭐ §5.3, §9.4 |
| `ANL-GAP-016` | ⚠️ DPDP applicability to **derived** analytics | ⛔ **OPEN** — ⛔ no treatment invented |

### 21.3 ⚠️ Testability — measured, and it is zero

| Measurement | Value |
|---|---|
| `ANL-AC-*` proven by a test | ⛔⛔ **0 of 17** |
| Surface tests for `BC-26` | ⛔⛔ **0** |
| ⭐ Architecture tests that **do** exist | ⭐ `every_projection_rebuildable_test.dart` *(proves `AN-1` rebuild — ⛔ not any surface)*; ⭐ `tenant_isolation_test.dart` *(⚠️ measured: **0** analytics assertions)* |
| `flutter test` run for this document | ⛔ **NO** — written by inspection |

⚠️⚠️ **`tenant_isolation_test.dart` contains no analytics assertion** — I
measured this rather than assuming the named test covered `BC-26`. ⭐ Combined
with `AIV-A02`'s un-partitioned state, ⛔ **the tenant-isolation property this
document depends on is neither implemented nor tested for analytics.**

---

## 22. Quantitative Reconciliation

⛔⛔ **The readiness audit's categories are NOT forced into screen counts.**
⭐ The two instruments counted **different things**, and the difference is
reported rather than reconciled away.

| Category | Readiness Audit | `DD-0006` | Match? |
|---|---|---|---|
| **Surfaces classified** | **15** | **11** | ⛔ **NO** — §22.1 |
| **Designable now** | 6 | ⭐ **1** | ⛔ **NO** — §22.2 |
| **Partial** | 4 | **7** | ⛔ **NO** — §22.1 |
| **Blocked** | 2 | **3** | ⛔ **NO** — §22.1 |
| **Not required / no surface** | 3 | ⭐ **4 backend capabilities** | ⚠️ **Re-framed** — §4.1 |
| ⭐ **Gaps preserved** | 25 | ⭐ **25** | ⭐⭐ **YES** |
| ⭐ **Findings preserved** | F-1, F-2, F-3 | ⭐ **3** | ⭐⭐ **YES** |
| ⭐ **`ANL-AL-B1` preserved** | 1 | ⭐ **1** | ⭐⭐ **YES** |
| ⭐ **Open decisions preserved** | 9 | ⭐ **9** | ⭐⭐ **YES** |
| ⭐ **Exclusions preserved** | 12 | ⭐ **12 of 12** | ⭐⭐ **YES** |
| **New design gaps** | — | **5** | n/a |
| **New TBDs** | — | **11** | n/a |
| **Conflicts** | 1 | ⭐ **2** | ⛔ **NO** — §22.3 |

### 22.1 ⭐ Why 15 became 11 — a counting-unit difference, stated precisely

| Cause | Effect |
|---|---|
| ⭐ The audit counted **candidate** surfaces, including several that §4.3's **dashboard test** then reclassified | ⛔ −0 *(only `B1` flagged, ⭐ retained with a TBD)* |
| ⭐⭐ **Backend capabilities were counted as surfaces** — the semantic layer, projections and the query port have **no UI** | ⛔ **−3** |
| ⭐⭐ **Parent surfaces were counted** — ⛔ now **EXCLUDED** by `ANL-OBD-004` | ⛔ **−1** |

⛔⛔ **11 is the recalculated figure and it governs.** ⭐ The audit's 15 was a
*candidate* count; ⭐ this is a *specified* count.

### 22.2 ⭐⭐ Why "6 designable" became "1" — the most important disagreement

⛔⛔ **This is the largest divergence and it is not a rounding difference.**

⭐ The readiness audit judged designability by **whether a surface's layout could
be specified**. ⭐ This document applies a **stricter test** drawn from the
requirements themselves: ⭐ `ANL-FR-001` *(every output resolves to a Certified
Metric)* + ⭐ `ANL-FR-009` *(a metric missing any of nine fields **MUST** be
rejected, not published with blanks)*.

| Test | Result |
|---|---|
| ⭐ Can the **layout** be specified? | ⭐ **8 surfaces — YES** |
| ⛔⛔ Can the surface render a **certified value**? | ⛔⛔ **1 surface — `B7` only** |

⭐⭐ **Both statements are true, and the stricter one is reported as the
headline** — because a surface that can be drawn but not populated is ⚠️
**PARTIALLY DESIGNABLE**, not designable. ⭐ §20.2 then supplied an *independent*
second reason for the same conclusion: `B7` is also the only surface resting on
a **declared edge**.

⛔ **The audit's figure is not withdrawn as wrong** — it answered a different
question. ⭐ It is superseded for this document's purpose and the reason is
recorded.

### 22.3 ⭐ Why 1 conflict became 2

⭐ The readiness audit carried **`ANL-AL-B1`**. ⭐ This authoring pass
additionally measured **`GAP-BCMAP-BC26-EDGES`** (§20.2) — ⭐ recorded by the BC
Map at **§17.4** and **not** previously carried into the design layer.

⭐⭐ **It is disclosed rather than absorbed**, because it materially affects the
designability verdict for 10 of 11 surfaces.

---

## 23. Figma Gate

### 23.1 ⛔⛔ Verdict — the gate is **NOT OPEN**

⛔⛔ **No Figma artifact is created by this task**, and ⛔ **the gate would be
BLOCKED even if one were permitted.**

| # | Blocker | Class |
|---|---|---|
| ⛔⛔ **1** | **`DD6-GAP-004`** — ⛔ 13 of 14 metrics lack at least one of the nine `ANL-FR-008` fields. ⭐ A prototype would have to show **invented numbers** or **empty states everywhere** — ⛔ **both misrepresent the system** | ⛔⛔ **HARD** |
| ⛔⛔ **2** | **`ANL-GAP-017`** — ⛔ **`PRD-009` ratifies contrast and type-scale targets: NONE.** ⭐ `ANL-FR-041` forbids colour-only meaning, ⛔ but supplies no contrast floor | ⛔⛔ **HARD** |
| ⚪ **3** | **`DBT-001`** — ⛔ token **values** unratified (`FIGMA_FOUNDATION.md` **L30**: *"**TO BE DECIDED**"*) | ⚪ **SUBSTITUTION** |
| ⛔⛔ **4** | **`DD6-TBD-005`** — ⛔ **no visual vocabulary for a restated value**, while `ANL-FR-052` requires restatement to be *visible*. ⭐ A prototype must either **invent a treatment** or **omit a required behaviour** — ⛔ **both wrong** | ⛔⛔ **HARD** |
| ⛔⛔ **5** | **`GAP-BCMAP-BC26-EDGES`** (§20.2) — ⛔ 10 of 11 surfaces depend on events whose edges §7 does not declare | ⛔⛔ **HARD** |
| ⛔ **6** | **`DD6-TBD-011`** — ⛔ no charting approach exists; ⛔ **0** chart widgets and **0** chart dependencies measured | ⛔ **BLOCKING for `V2`/`V6`** |

⭐ **5 hard blockers + 1 substitution.** ⛔ **The gate is NOT OPEN.**

### 23.2 ⭐⭐ What COULD be prototyped, if the gate were opened for one surface

⭐ **`B7` Profile Views alone** clears blockers 1 and 5: ⭐ `ADR-0097` supplies
all nine metric fields, and **`E-30`** is a **declared** edge. ⚠️ ⛔ Blockers 2
and 3 *(accessibility, tokens)* would still require **labelled substitutions**,
on the `DD-0001` §19.1 precedent.

⛔⛔ **I do not open the gate**, ⛔ do not create the artifact, and ⛔ do not
treat *"one surface is prototypable"* as the gate being open.

### 23.3 ⛔ Figma cannot resolve a PRD/ADR/GAP conflict

⛔⛔ **Stated because it is the likeliest misuse of §23.2.** ⭐ A prototype
showing a plausible number for *"study consistency"* would not define the
metric — ⛔ it would **create the appearance** of a definition that
`MP-GBR-36` and `AN-2` reserve to the semantic layer. ⭐ `DESIGN_GOVERNANCE.md`
rule 2 is explicit: ⛔ *"A design artifact cannot grant a permission, create a
role, name a backend, add a bounded context, or change BC ownership."*

---

## 24. Readiness Classification

### 24.1 ⭐ Verdict — **DESIGNED WITH EXPLICIT BLOCKERS**

| Dimension | Verdict |
|---|---|
| Surface inventory | ⭐ **COMPLETE** — 11 surfaces, ⭐ recalculated from `PRD-009`, ⭐ 11/11 assigned to an app and roles |
| Information architecture | ⭐ **COMPLETE** — 2 mandated orders, ⛔ never merged |
| State model | ⭐⭐ **COMPLETE** — 11 states, ⭐ 7 of them non-value, ⛔ none renders zero |
| Role & permission model | ⚠️ **STRUCTURAL ONLY** — ⛔⛔ `ANL-OBD-003` **OPEN** |
| Metric authority | ⛔⛔ **1 of 14 certified** — `DD6-GAP-004` |
| Data provenance | ⭐ **COMPLETE** — 8 provenance questions answered or explicitly refused |
| Psychology | ⭐⭐ **COMPLETE** — 10 dimensions × 4 roles; ⛔ 5 patterns prohibited with authority |
| Accessibility | ⚠️ **3 requirements binding · targets UNRATIFIED** — `ANL-GAP-017` |
| Visualization | ⭐ **COMPLETE** — 6 defined, 8 rejected with authority, ⛔ 0 decorative, ⛔ 0 3D |
| Export | ⚠️ **BEHAVIOUR specified · ARTEFACT undefined** — `ANL-GAP-011` |
| Cross-context ownership | ⭐⭐ **VERIFIED** — 10 rows, ⛔ 0 duplicate ownership, ⛔ 0 change |
| Design-system | ⚠️ **TOKENS UNRATIFIED** · ⛔ **no charting approach** |
| Testability | ⛔⛔ **0 of 17 criteria proven · 0 surface tests** |
| Figma gate | ⛔⛔ **NOT OPEN** — 5 hard blockers |

### 24.2 ⭐ Why this verdict differs from `DD-0003`/`DD-0004`/`DD-0005`

⭐ Those three read **READY WITH EXPLICIT DESIGN GAPS** because ⭐ the **majority**
of their surfaces were designable now *(23/32, 28/29, 10/16)*.

⛔⛔ **Here it is 1 of 11**, and the cause is a single architectural fact:
⛔⛔ **F-1 — the semantic layer `MP-GBR-36` mandates does not exist.**

⭐⭐ **"DESIGNED WITH EXPLICIT BLOCKERS" is therefore the honest classification.**
⭐ The design work **is** complete — layout, order, states, psychology,
visualization, ownership and accessibility are all specified. ⛔ What is missing
is **not design**; it is **metric definitions this document is forbidden to
supply**.

### 24.3 ⛔ Zero-unsupported-decisions check

| Class | Count |
|---|---|
| ⭐ **A — PRD/ADR requirement** | **68** |
| ⭐ **B — existing GAP/TBD** | **41** |
| ⭐ **C — design guidance** *(labelled, ⛔ non-binding)* | **13** |
| ⛔⛔ **D — unsupported** | ⛔⛔ **0** |

⭐⭐ **0 unsupported decisions.** ⭐ Every design statement traces to a named
requirement, a named gap, or is **labelled as guidance/hypothesis**. ⭐ **5
refusals** (§3.1) and **11 TBDs** (§20.4) record the points where evidence ran
out, rather than filling them.

### 24.4 ⭐ Fabricated-identifier scan

| Identifier family | ⭐ Status |
|---|---|
| `ANL-FR-*`, `ANL-BR-*`, `ANL-INV-*`, `ANL-XC-*`, `ANL-AC-*`, `ANL-CFG-*`, `ANL-GAP-*`, `ANL-OBD-*`, `ANL-NFR-*`, `ANL-RSK-*`, `ANL-AL-B1` | ⭐ **All verified present in `PRD-009`** |
| `MP-GBR-21`/`-24`/`-36`/`-37`/`-38`, `MP-CON-08`/`-12`, `MP-SM-06` | ⭐ **Verified in `MASTER_PRD.md`** |
| `ADR-0096`, `ADR-0097`, `ADR-0112`, `ADR-0113` | ⭐ **Verified Accepted** |
| `AN-1`, `AN-2`, `AN-3`, `A-6`, `X-01`, `E-26`, `E-30`, `CFL-28` | ⭐ **Verified** in the manifest / BC Map |
| `AUTH-2.5`, `TR-1`…`TR-5`, `PR-1`, `PR-2` | ⭐ **Verified** via `PRD-001` / README §2B.2 |
| `FEE-XC-012`, `FEE-XC-013`, `FEE-XC-019`, `FEE-FR-055` | ⭐ **Verified in `PRD-008`** |
| `GAP-BCMAP-BC26-EDGES`, `DBT-001` | ⭐ **Verified** — BC Map §17.4 / `DD-0001`…`DD-0005` |
| `A1`…`A4`, `B1`…`B7`, `V1`…`V6`, `L`/`EM`/`ND`/`IN`/`PA`/`ST`/`UN`/`SU`/`E`/`PR`/`R` | ⭐ **Local to this document** — ⛔ declared as such in §9, §12, §14 |
| `DD6-GAP-001`…`005`, `DD6-TBD-001`…`011`, `AIV-A01`…`A07`, `R-1`…`R-5` | ⭐ **Local to this document** — ⛔ declared as such |
| ⛔⛔ **Fabricated product identifiers** | ⛔⛔ **0** |

### 24.5 ⛔ What this document did NOT do

| ⛔ Not done | Verification |
|---|---|
| ⛔ Modify `PRD-009` | ⭐ **0 bytes** |
| ⛔ Modify any ADR | ⭐ **0 bytes** |
| ⛔ Modify architecture / BC Map / manifest | ⭐ **0 bytes** |
| ⛔ Modify `lib/` or `test/` | ⭐ **0 bytes** |
| ⛔ Create a Figma artifact | ⭐ **0** |
| ⛔ Create a requirement, permission, role, metric or data source | ⭐ **0** |
| ⛔ Expand V1 scope | ⭐ **0** — ⭐ §4.2 lists **21** exclusions |
| ⛔ Resolve a gap, conflict or TBD | ⭐ **0** — ⭐ 25 gaps, 2 conflicts, 9 OBDs **PRESERVED** |
| ⛔ Commit, push, amend or force-push | ⭐ **0** |

---

## 25. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.1** | 2026-09-15 | ⭐⭐ **Created** as the `BC-26` Analytics & Reports surface design, after the **BC-26 Design Readiness Audit** *(verdict **REQUIRED WITH EXPLICIT DESIGN GAPS**)* and an accepted **design-scope expansion** governance check. ⭐ **`analytics/` is the SEVENTH context directory** in `docs/35-design/`, created **at the moment this document was written** exactly as README §2 prescribes. ⭐⭐ **The governing discovery of this pass is `ADR-0097`** *(Rank 2, Accepted)*: **`ProfileViews` is the ONLY `CertifiedMetric` defined anywhere in the repository**, and **`UniqueViewers` is expressly NOT certified with 8 mandatory absence rules** — which makes **`B7` the only DESIGNABLE-NOW surface** of eleven. ⭐ **11 surfaces** `A1`…`A4` · `B1`…`B7` *(⭐ 1 designable · ⚠️ 7 partial · ⛔ 3 blocked)*, **11 states** *(⭐ **7** of them non-value, and ⛔ **not one may render zero**)*, **6 visualizations** *(⛔ 8 rejected with authority)*, **1 certified metric + 13 uncertified candidates**, **0 report instances**, an **11×5 structural** role matrix and **10** cross-context ownership rows. ⛔⛔ **`TR-5` Parent is EXCLUDED — 0 surfaces — a deliberate divergence from `DD-0003` and `DD-0005`**, because `ANL-OBD-004` states a decision is **REQUIRED before any guardian-facing analytic ships**. ⚠️ **App-Boundary QA is reported as 12 of 13 with 1 GAP, NOT rounded to 13/13**, because ⛔ `PRD-009` carries **no closed permission matrix** and `ANL-OBD-003` owns it. ⭐⭐ **A SECOND conflict was measured during authoring and is disclosed rather than absorbed: `GAP-BCMAP-BC26-EDGES`** — BC Map §9 records `BC-26` as consumer of ~**20** events for which §7 declares **no edge**, which independently confirms the `B7`-only verdict since `E-30` is the only declared inbound edge. ⛔⛔ **Both conflicts are PRESERVED in the four-part structure and NEITHER is resolved.** ⭐ **25 of 25 `ANL-GAP-*`, F-1/F-2/F-3, `ANL-AL-B1` and 9 of 9 `ANL-OBD-*` preserved OPEN; 12 of 12 `ANL-XC-*` preserved.** ⭐ **5 new gaps** `DD6-GAP-001`…`005` *(4 BLOCKING, each only its named subset)* and **11 TBDs** each with a named owner. ⭐ **All 20 expert perspectives reviewed, with 5 REFUSALS recorded** — including ⛔ declining to choose an Indian digit-grouping convention, ⛔ declining a contrast ratio, and ⛔ rejecting a forecast chart as an explicit non-requirement. ⭐ **UI/UX Pro Max @ `15de38f`: 10 ADOPT · 3 ADAPT · 9 REJECT · 5 TBD** — ⛔ every charting **library** recommendation rejected as JavaScript. ⭐ **7 implementation deviations recorded, 0 fixed** — including ⛔⛔ a stale *"R5 / BC-22"* module header and ⛔⛔ **`_feed`/`_attendanceDays` not tenant-partitioned** against `ANL-INV-006` and BC Map **L490**. ⭐ **2D 6 / 2.5D 1 / 3D 0.** ⛔⛔ **`MeterBar` PROHIBITED** — the third consecutive Design Doc to prohibit it, for a third distinct reason. ⛔⛔ **Figma gate NOT OPEN — 5 hard blockers.** ⭐ **0 unsupported decisions · 0 fabricated product identifiers.** ⛔ **0 bytes of any PRD, ADR, architecture document, manifest, `lib/` or `test/` file changed; no commit, no push.** ⭐ Verdict: ⚠️ **DESIGNED WITH EXPLICIT BLOCKERS** |
