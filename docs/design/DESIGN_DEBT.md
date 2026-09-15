<!-- LIBOORA Design Documentation Foundation | design debt and deprecation register -->

> This document is design governance and documentation. It does not amend product requirements, architecture decisions, bounded-context ownership, permissions, or backend contracts.
# LIBOORA Design Debt & Deprecation Register

| Field | Value |
|---|---|
| Status | ⚠️ **DEBT REGISTER** — records measured debt. ⛔ It resolves none of it |
| Owner | Design Governance Owner *(register)*; each row names its own deciding office |
| Rank | **UNRANKED.** Carries no precedence over any ranked document |
| Rule | A row states what is **measured**, who owns it, and what would trigger review. ⛔ It does not prescribe the fix |

## 1. Purpose

[`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) governs how
design *changes*. Nothing governed how design **decays** — measured across
the sixteen foundation documents, the terms *debt*, *deprecated*, *sunset*
and *retire* occur **0** times. A design system without a deprecation record
accumulates components nobody may delete because nobody recorded that they
were superseded.

This register carries two kinds of entry:

* **Debt** — a known divergence between documented intent and observed
  reality.
* **Deprecation** — a design artifact, token or component deliberately
  superseded, retained so readers know it is no longer current.

⛔ **Recording debt is not authorising its repair.** Several rows below
require a Design System Owner or Founder/Product Authority decision, and
this document takes none of them.

## 2. Register

| ID | Class | Finding *(measured)* | Impact | Owning office | Review trigger | Status |
|---|---|---|---|---|---|---|
| `DBT-001` | **Debt — documentation vs code** | ⭐ **[`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 records colour and spacing token values as `TO BE DECIDED`, while `lib/app/shared/theme.dart` already defines them**: `LiblColors` with **12** colour constants (brand, brandDark, accent, success, warning, danger, info, surface, card, border, textPrimary, textMuted) and `LiblSpace` with **6** steps (`xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`). Dates: `theme.dart` **2026-09-07**, design foundation **2026-09-09** — ⚠️ **the documentation is the later artifact and still describes the decision as unmade** | Design documentation describes as open a decision engineering has already shipped. Any new surface built from the document will diverge from every existing surface | **Design System Owner** | A token change in either direction, or approval of the design system foundation | ⛔ **OPEN** |
| `DBT-002` | **Debt — no owning document** | **Responsive behaviour has an owner but no artifact.** [`DESIGN_OWNERSHIP.md`](DESIGN_OWNERSHIP.md) §1 constitutes a *Responsive Design Owner* who "owns breakpoint behaviour, layout adaptation, and device-mode rules", but responsive guidance is scattered as **10** incidental mentions across **5** documents with ⛔ **no breakpoints, no device modes and no layout-adaptation rules anywhere** | The `G3` handoff gate and [`DESIGN_QA.md`](DESIGN_QA.md) §1 both require responsive evidence against no specification, so the gate cannot be evaluated consistently | **Responsive Design Owner** | Any multi-width surface entering handoff | ⛔ **OPEN** — ⚠️ breakpoints are a **design decision**, deliberately not invented here |
| `DBT-003` | **Debt — partial coverage** | **Localization is one paragraph and unimplemented.** [`ACCESSIBILITY.md`](ACCESSIBILITY.md) §3 requires writing "for translation" and leaves supported languages `TO BE DECIDED`; measured: **0** occurrences of `flutter_localizations`, `intl` or `AppLocalizations` in `pubspec.yaml` or `lib/`. ⛔ No pluralisation, date/number, text-expansion or bidirectional rule exists | A translation obligation is stated, no mechanism exists, and no artifact defines what "written for translation" requires | Product Owner *(language scope)*, then **Design System Owner** *(text-expansion rules)* | Approval of any second language | ⛔ **OPEN** |
| `DBT-004` | **Debt — thin evidence base** | **The QA gate outweighs its evidence.** [`DESIGN_QA.md`](DESIGN_QA.md) §1 specifies **6** check categories; measured: **1** `testWidgets` assertion exists in the entire repository (`test/widget_test.dart`, *"app renders the login screen on first frame"*), against **819** passing tests overall — i.e. ⛔ **the test suite is strong on domain rules and near-silent on UI behaviour** | A `G4` pass would rest on review judgement alone for every surface but one | **Design QA Owner**, with the engineering counterpart | Any surface entering `G4` | ⛔ **OPEN** |
| `DBT-005` | **Debt — untokenised values** | **Radius is used but not tokenised.** `theme.dart` contains **7** `BorderRadius.circular(...)` calls across **3** distinct values (`12`, `14`, `18`) with ⛔ **no `LiblRadius` class**, while [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) §2 names radius a foundation and [`FIGMA_FOUNDATION.md`](FIGMA_FOUNDATION.md) §5 requires semantic variables for it. ⚠️ Elevation and typography are in the same position: no token class exists for either | Three unexplained radii will be copied forward as precedent; a Figma variable has nothing to map to | **Design System Owner** | Introduction of a radius, elevation or type token set | ⛔ **OPEN** |
| `DBT-006` | **Debt — design/implementation divergence** | **The designed screen set and the built screen set do not intersect.** [`SCREEN_ARCHITECTURE.md`](SCREEN_ARCHITECTURE.md) §1 specifies **7** screen families centred on discovery → profile → availability → seat → booking; `lib/app/` implements **11** staff/student operational screens. ⛔ **5** designed families have no implementation and the implemented screens have no design artifact — recorded as `DIT-008` and `DIT-005` in [`DESIGN_IMPLEMENTATION_TRACEABILITY.md`](DESIGN_IMPLEMENTATION_TRACEABILITY.md) | The design foundation does not describe the shipped product, so neither can be used to review the other | **Founder/Product Authority**, with UX Architecture Owner | Either set changing | ⛔ **OPEN** — ⚠️ a **product scope** question, not a documentation defect |
| `DBT-007` | **Debt — structural duplication** | **Two design directories exist.** `docs/design/` holds the foundation; [`../35-design/`](../35-design/README.md) holds per-feature Design Docs and contains **6** empty context directories and **0** Design Docs. Its own README §6 records the split as deliberate and explains that consolidating would break **16** documents' relative sibling links | A reader must know both exist. ⚠️ The risk is *low while documented and rising if undocumented* — which is why this row exists | **Design Documentation Owner** | Either directory gaining a document that plainly belongs in the other | ⚠️ **ACCEPTED, DOCUMENTED** — ⛔ not scheduled for repair |
| `DBT-008` | **Debt — status plateau** | **Nothing in this directory is approved.** All **16** foundation documents read `PROPOSED` or `RECOMMENDED`, and [`design-decisions/README.md`](design-decisions/README.md) §3 states that **0** design decisions have been marked `APPROVED`. Gates `G0`–`G5` exist and ⛔ **none has been recorded as passed** | The foundation is complete in form and carries no approved authority; `DESIGN_FOUNDATION.md` §8's completion rule is unmet | **Founder/Product Authority** | A design approval act | ⛔ **OPEN** |

### 2.1 Register measures

| Measure | Value |
|---|---|
| Rows | **8** |
| `OPEN` | **7** |
| `ACCEPTED, DOCUMENTED` | **1** (`DBT-007`) |
| Resolved | **0** |
| Deprecations recorded | **0** — ⚠️ nothing has been superseded yet, which is expected for a foundation with **0** approvals |
| Owned by Design System Owner | **3** (`001`, `003` in part, `005`) |
| Requiring Founder/Product Authority | **2** (`006`, `008`) |

## 3. Deprecation procedure

⛔ **No artifact is deprecated by deletion.** To deprecate:

1. Add a row here with class **Deprecation**, naming the superseding
   artifact. A deprecation that names no successor is an unexplained
   removal.
2. Mark the artifact `SUPERSEDED` using the
   [`DESIGN_GOVERNANCE.md`](DESIGN_GOVERNANCE.md) §2 vocabulary, ⛔ not a
   second competing set.
3. Leave it readable. It records why current work looks as it does — the
   rule [`../35-design/README.md`](../35-design/README.md) §4 already states.
4. Record the change under
   [`DESIGN_CHANGE_MANAGEMENT.md`](DESIGN_CHANGE_MANAGEMENT.md) §4.
5. ⛔ **Never reuse the retired identifier.**

## 4. Filing rules

1. **A row states a measurement, not an opinion.** "The spacing feels
   inconsistent" is not a row; "`6` spacing steps defined in code, `0` in
   the design system document" is.
2. **Every row names an owning office** — a **role**, never a personal name.
3. **Every row carries a review trigger.** Debt with no trigger is never
   revisited.
4. **`DBT-*` identifiers are never reused or reassigned.**
5. **⛔ A row is never closed by editing the document it indicts** unless the
   owning office decided it. Silently "fixing" `DBT-001` by writing the
   code's token values into [`DESIGN_SYSTEM.md`](DESIGN_SYSTEM.md) would
   convert an engineering default into design authority without the Design
   System Owner's act — which is precisely the ratification this register
   must not perform.
