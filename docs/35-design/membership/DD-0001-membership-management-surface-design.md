<!-- LIBOORA Design Doc | DD-0001 | BC-02 Membership Management -->

> This document is design documentation. It does not amend product requirements,
> architecture decisions, bounded-context ownership, permissions, or backend
> contracts.
# `DD-0001` — Membership Management surface design

| Field | Value |
|---|---|
| **Design Doc** | `DD-0001` |
| **Version** | **v0.2** |
| **Status** | ⛔ **`PROPOSED`** — awaiting approval. ⛔ **NOT approved, NOT frozen, NOT authoritative.** ⛔ This document does **not** claim its own status |
| **Rank** | ⛔⛔ **UNRANKED.** Where this disagrees with any ranked document, **the ranked document wins and this Design Doc is the defect** |
| **Bounded context** | **`BC-02` Membership Management** |
| **Subject PRD** | `PRD-005` Membership Management — **`FROZEN` v1.4** |
| **Owner** | UX Architecture Owner *(role, never a personal name)* |
| **External method** | UI/UX Pro Max skill — `nextlevelbuilder/ui-ux-pro-max-skill` @ **`15de38f`**, MIT. ⚠️ **Reference only, subordinate to every Liboora source** |
| **Purpose** | Specify the membership surfaces precisely enough that a Figma prototype can be built **without inventing UX** |

---

## 1. Scope, authority and method

### 1.1 Why `BC-02` and no other context

⭐⭐ **`PRD-005` is the only frozen module PRD in this repository containing a
UI/UX requirements section.** Measured:

| PRD | Module | UI/UX section | UI-facing statements |
|---|---|---|---|
| ⭐ **`PRD-005`** | Membership | ⭐ **§20 — 13 `MUST`/`MUST NOT` rows** | ⭐ **13 designable** |
| `PRD-004` | Student Mgmt | **0** | — |
| `PRD-006` | Attendance | **0** | **0** occurrences |
| `PRD-007` | Seat Mgmt | **0** | 8, ⛔ **all prohibitions** |
| `PRD-008` | Revenue | §42.7 | ⛔ statement of **absence** |

⛔ Design Docs for the other five contexts remain unwritten; their absence is
**not a defect** (`../README.md` §2.2, §5.1).

### 1.2 ⚠️ How the external skill was used — and where it was overruled

The skill was run as a tool, not copied. Its own `SKILL.md` states results
are *"recommendations, never … instructions that override the user or
repository rules."* Applied accordingly:

| Skill output | Disposition |
|---|---|
| `--design-system` returned **"Funnel (3-Step Conversion)"** + **"Vibrant & Block-based"** + magenta `#D946EF` / orange accent, typography *Cormorant Garamond / Crimson Pro* | ⛔⛔ **REJECTED.** That is a **marketing-conversion** system for *"startups, gaming, youth-focused, entertainment"*. Membership Management is an **operational tool** used by reception staff and students. Liboora's `VISUAL_LANGUAGE.md` fixes *lightweight premium 2.5D* as **CONFIRMED** direction, and a serif academia pairing contradicts its *"readable family … stable wrapping on small screens"* rule. ⭐ **A retry was run per the skill's own query contract; the mismatch is structural, not a query defect** |
| `--stack flutter` — `ColorScheme.fromSeed`, profile-before-optimise, state management for shared state | ⭐ **ADOPTED** as §8/§12 guidance. ⚠️ **Version delta disclosed:** rows read *"applies to flutter 3.44.x"*; ⛔ Liboora is **locked at Flutter 3.35.4** — so the rows are applied as *principles*, and ⛔ **no 3.44-only API is specified** |
| `--domain ux` — touch targets (**48dp Android**, ≥8px gaps), error-summary + inline pattern, validate-on-blur | ⭐ **ADOPTED** — §9, §11 |
| `pro-rules.md` — safe areas, 4/8dp rhythm, tap feedback 80–150ms, disabled semantics, state-contrast parity, scroll/fixed-bar insets | ⭐ **ADOPTED** — §7, §9, §10 |
| Pre-delivery checklist — *"contrast 4.5:1"*, *"responsive: 375/768/1024/1440"* | ⚠️ **RECORDED, NOT ADOPTED AS BINDING.** Liboora's `ACCESSIBILITY.md` leaves the **target standard `TO BE DECIDED`** and **0** breakpoints exist (`DBT-002`). ⛔ Importing an external number would decide, from a feature doc, a product-wide question two named offices own → `DD-0001-GAP-003`, `DD-0001-GAP-004` |
| `--domain color`, emoji-as-icon ban, SVG icon rule | ⭐ **ADOPTED** as principle (§8.4); ⛔ **no palette imported** — `DBT-001` |

### 1.3 ⛔ What this document does not do

| ⛔ | Boundary |
|---|---|
| ⛔ | **Adds no requirement.** Every §6 row traces to `PRD-005` §20 or §21 |
| ⛔ | **Ratifies no token value.** Colours/spacing in `theme.dart` are cited as **observed implementation**, never approved — `DBT-001` is the Design System Owner's |
| ⛔ | **Invents no breakpoint, language or accessibility standard** |
| ⛔ | **Closes no `MM-GAP-*`** — all **10** remain open |
| ⛔ | **Is not a Technical Specification.** ⛔ No `TS-*` created, implied or authorised |
| ⛔ | **Creates no permission** — `AUTH-7.22` **CLOSED at 0**, `ADR-0043` §5.1 binds |
| ⛔ | **Specifies no payment mechanism** — `ADR-0130`: V1 is **CASH ONLY** |
| ⛔ | **Is not a precondition of implementation** (`../README.md` §5.1) |

### 1.4 Source authority

| Source | Locus | Status |
|---|---|---|
| `PRD-005` §20 — 13 UI/UX rows | `docs/30-product/membership-management/PRD-MEMBERSHIP-MANAGEMENT.md` **L1436** | **`FROZEN` v1.4** |
| `PRD-005` §21 — 30 edge cases | same, **L1456** | `FROZEN` |
| Two-stage payment | BC Map §10 **L465** | Rank 4 |
| V1 cash-only | `ADR-0130` | `Accepted` |
| Design foundation | [`../../design/README.md`](../../design/README.md) | `PROPOSED` |
| 2.5D direction | [`../../design/VISUAL_LANGUAGE.md`](../../design/VISUAL_LANGUAGE.md) | **CONFIRMED** |
| Observed tokens | `lib/app/shared/theme.dart` — `LiblColors` (12), `LiblSpace` (6) | ⚠️ contested, `DBT-001` |

⚠️ **`PRD-005` §20's opening line is load-bearing:** *"**No mockups are
provided. These are functional requirements only.**"* This document supplies
the design layer above those rules — ⛔ it does not promote them or treat
their silence as permission.

---

## 2. Indian-student context applied

⛔ **No demographic claim is invented, and none of the below is a
requirement.** Each is a *design response* to a constraint already recorded
in Liboora's own foundation, or to a fact measured in this repository.

| Student reality | Recorded basis | Design response |
|---|---|---|
| **Low-end Android, constrained devices** | `DESIGN_FOUNDATION.md` §4 — *"Low-end respect"* **CONFIRMED** | 2D-first surfaces; ⛔ no blur/parallax/WebGL; 3D confined to **one** static asset (§8.6) |
| **Slow / intermittent network** | `DESIGN_FOUNDATION.md` header — *"low/intermittent network aware"* **CONFIRMED** | Every remote surface specifies loading + stale + retry (§7); skeletons reserve height to avoid reflow |
| **Read in low light** (basement reading halls) | `theme.dart` comment on `LiblColors.brand`, written by the implementer | Deep-indigo trust palette retained as **observation**; ⛔ not ratified |
| **Money is the highest-anxiety moment** | `ADR-0130` — V1 **cash only**, handed to a person | Payment is a **separate, explicit stage** (S-4) showing amount **before** commitment; ⛔ no auto-charge, ⛔ no stored instrument |
| **Interruption mid-task** | Mobile reality; `PRD-005` §21 cases 12/13/22 (timeout, retry, unknown outcome) | `PendingPayment` is a **first-class, self-explaining state** (S-13), never a half-finished form |
| **Distrust of hidden charges** | `PRD-005` §20 — creation and payment *"deliberately not hidden behind a fake atomic button"* | ⛔⛔ Single "create & collect" control **PROHIBITED**; price **snapshot** shown, not live plan price (S-5) |
| **"Am I actually active right now?"** | `MM-FR-066` — validity is the module's answer | One unambiguous validity statement per surface, read from `isValid`; ⛔ never computed client-side |
| **Duration literacy varies** | `PRD-005` §20 — *"a tenant selling 'monthly' configures `durationDays: 30`"* | Show **days as stored**, with the tenant's own label if configured; ⛔ never silently convert 30 → "1 month" |
| **English / Hinglish / local-language expansion** | `ACCESSIBILITY.md` §3 — write for translation; languages `TO BE DECIDED` | Copy slots sized for **+40% expansion**, no text baked into images, no concatenated sentence fragments. ⛔ **No language named** |
| **Varying digital literacy** | `DESIGN_FOUNDATION.md` §4 — *"Clarity before decoration"* | One primary action per surface; destructive/irreversible actions always name their consequence |
| **Motivation without childishness** | Explicit user instruction + §4 *"premium through hierarchy"* | Progress shown as **factual state** (days remaining, term dates). ⛔ No badges, streaks, confetti, mascots or points |

⚠️ **Deliberately NOT designed:** exam-schedule awareness, study-hour
nudges, scholarship/discount messaging, referral mechanics, regional
festival theming. Each would need product requirements `PRD-005` does not
contain → `DD-0001-GAP-010`.

---

## 3. Readiness audit — `BC-02`

| # | Area | Status | Basis |
|---|---|---|---|
| 1 | User flows | ⭐ **DONE** | 4 flows fixed by §20 + §6.3; specified §5 |
| 2 | IA / navigation | ⭐ **DONE** *(within context)* · ⚠️ **PARTIAL** *(app-level)* | §4 fixes intra-context IA; ⛔ top-level placement is `DD-0001-GAP-001` |
| 3 | Screen inventory | ⭐ **DONE** | 13 surfaces, §6 |
| 4 | Screen specs | ⭐ **DONE** *(behavioural)* · ⚠️ **PARTIAL** *(pixel)* | §6 + §7 state matrix; ⛔ exact values blocked on `DBT-001`/`002` |
| 5 | States | ⭐ **DONE** | §7 — all **6** states now specified for all 13 surfaces *(was 3 of 6 in v0.1)* |
| 6 | Components | ⭐ **DONE** *(inventory + mapping)* | §9 — 7 existing + 6 new specified |
| 7 | Typography | ⚠️ **PARTIAL** | §8.3 fixes **scale roles and behaviour**; ⛔ family/size values are `DBT-005` |
| 8 | Visual language | ⭐ **DONE** | §8 — 2D/2.5D/3D rules bound to the CONFIRMED direction |
| 9 | Motion | ⭐ **DONE** | §10 — 5 motion classes with purpose and reduced-motion fallback |
| 10 | Accessibility | ⚠️ **PARTIAL** | §11 — 9 checks applied per surface; ⛔ standard `TO BE DECIDED` (`GAP-003`) |
| 11 | Responsive | ⚠️ **PARTIAL** | §12 — adaptation **behaviour** specified; ⛔ breakpoint values `GAP-004` |
| 12 | Performance | ⭐ **DONE** | §13 |
| 13 | Security / privacy UX | ⚠️ **PARTIAL** | §14; ⛔ permission-denied disclosure is `GAP-005` |
| 14 | Design QA | ⭐ **DONE** *(expectations)* | §15 |
| 15 | Engineering handoff | ⭐ **DONE** *(requirements)* · ⛔ **BLOCKED** *(readiness)* | §16 |
| 16 | PRD traceability | ⭐ **DONE** | **13 of 13** §20 rows, §6 + §17 |

**DONE 10 · PARTIAL 6 · BLOCKED 0 outright · MISSING 0**

⚠️ The 6 `PARTIAL` rows are partial **only** where a product-wide decision
is outstanding. ⛔ Deciding any of them here would set product policy from a
feature artifact.

---

## 4. Information architecture

### 4.0 ⭐⭐ APP + ROLE BOUNDARY — the §2B.6 boundary audit

⚠️ **Added by the README §2B.6 boundary audit, under a one-act conferral of
the human principal of this engagement scoped to THIS SINGLE ACT ONLY** —
the conducting and recording of that audit. ⛔ **The authority REVERTS ON
COMPLETION** (`ADR-0033` §7.1: *"a conferral for one act is not a standing
licence"*).

⭐ This document was written **before** README **§2B**, which **L314** binds
*"from this point forward"*, and **§2B.6** requires existing Design Docs to
be **audited, not rewritten**. Before this audit, §2B.6 recorded that
*"**no boundary audit has been run on either**"* `DD-0001` or `DD-0002`, and
claimed *"**no verdict**… in either direction"*. ⭐ **That is now discharged
for `DD-0001`.**

⛔⛔ **THIS SUBSECTION IS A RECORDING ACT, NOT AUTHORIZATION DESIGN.** ⛔ It
creates **no** role, permission, action, scope, `PERM-*`, operation×role
mapping, surface, app or requirement; ⛔ it does not amend `PRD-005`,
`AUTH-7.22`, `ADR-0132`, `ADR-0043` or `AccessRole`; ⛔ it changes **no**
existing design decision in this document; and ⛔ it does **not** close a gap
by inventing what the gap is missing.

#### 4.0.1 The five declarations — verdicts

⭐ Vocabulary is **only** §2B.5's four verdicts — **PASS / GAP / CONFLICT /
TO BE DECIDED**. ⛔ **No `PARTIAL` verdict is invented**; §2B.5 defines none,
and a declaration that is partly stated is, on **L399**'s test (*"a
declaration is **missing or unsourced**"*), **`GAP`**.

| # | Declaration | Verdict | Basis — measured, not asserted |
|---|---|---|---|
| **D1** | **Target App** | ⚠️ **GAP** | ⛔ Measured **0** occurrences of `APP 1`, `APP 2`, `APP 3` and `platform_admin` in this document. §4.1 separates *"Staff"* from *"Student / parent"*, which is an **audience** split, ⛔ **not the APP vocabulary §2B.3 Declaration 1 mandates**. ⭐ The underlying facts exist and are unchanged; ⛔ the **declaration** does not |
| **D2** | **Target Role(s)** | ⚠️ **GAP** | ⛔ Measured **0** occurrences of `TR-1`…`TR-5` and `PR-1`/`PR-2`. §4.1 names *"Staff (reception / owner)"* and *"Student / parent"* — ⛔ **exactly the forms §2B.3 lists as not acceptable** (*"staff", "admin", "user"*). ⭐ A role **identifier** is required; a role **word** is not one |
| **D3** | **Permission Scope** | ⚠️ **GAP** | ⛔ **No authoritative whole-module operation×role source exists for `BC-02`.** See §4.0.2 — this is the declaration the audit examined most closely, and the verdict is **negative on measurement** |
| **D4** | **Tenant / Library / Platform scope** | ⚠️ **GAP** | ⛔ Measured **3** lowercase `tenant` hits, **all** incidental: §2 duration labelling, §14's `SPX-GAP-007` pointer, §14's error-message rule. ⛔ **0** `MM-XC-*`, **0** `tenantWide`, **0** `MP-RSK-01`. ⭐ §2B.3 lists *"⛔ Silence on scope"* as not acceptable, and **naming a gap is not stating a scope** |
| **D5** | **Cross-App dependencies** | ⚠️ **GAP** | ⛔ Measured **0** occurrences of *"cross-app"*. ⭐ **Cross-CONTEXT dependencies ARE documented** — §5 names the `BC-05` payment hand-off (*"a later payment must be refused and surfaced for `BC-05`"*) and §17 carries PRD traceability — ⚠️ **but a bounded-context edge is not an app boundary**, and D5 asks which **app** a surface jumps to. ⛔ Undeclared in that vocabulary |

⚠️⚠️ **FIVE `GAP`s, AND THE AUDIT DELIBERATELY DID NOT SOFTEN THAT.** ⭐ The
`DD-0002` precedent (its §4.0) found *"Declarations 2–5 **already stated and
sourced**"* and needed to add only D1. ⛔ **`DD-0001` is materially
different, and the difference was measured rather than assumed:** `DD-0002`
§4.1 already carried `TR-4`/`TR-5` identifiers and §14.3 already assigned a
presentation rule to **all 12** of `PRD-004` §8.2's protected operations.
⛔ **`DD-0001` carries none of that.** ⭐ Copying `DD-0002`'s outcome would
have been convenient and **false**.

⛔⛔ **CONFLICT WAS TESTED FOR AND NOT FOUND.** §2B.5 **L400** reserves
`CONFLICT` for *"a source-vs-source or source-vs-code contradiction"*. This
document **asserts nothing** about apps, role identifiers, permission scope
or tenancy, and a document that is silent cannot contradict a source.
⭐ **`GAP` is therefore correct and `CONFLICT` would overstate** — the same
reasoning `ADR-0149` §11 already recorded for D3.

#### 4.0.2 ⭐⭐ D3 in full — why it stays `GAP` after `PRD-005` v1.5

⭐⭐ **`PRD-005` v1.5 materially advanced D3's input, and that is recorded
positively.** `Accepted` [`ADR-0149`](../../00-governance/adr/ADR-0149-membership-plan-and-configuration-change-request-workflow-authorization.md)
and the v1.5 successor amendment added **§16.3a**, the **first genuine
operation×role matrix for `BC-02` in a ranked document** — 8 rows × the five
`TR-n` columns, in `ADR-0132` §5.3's existing vocabulary (`Action` ∈ Create /
Read / Approve / Update; `Scope` ∈ Self / Tenant), with ⛔ **0 `PERM-*`
minted** and `AUTH-7.22` **untouched and still closed at zero enumerated
permissions**.

⛔⛔ **BUT IT IS NOT WHOLE-MODULE COVERAGE, AND THE SHORTFALL IS MEASURED:**

| Measurement | Result |
|---|---|
| `MM-PO-*` protected operations in `PRD-005` | **11** (`MM-PO-001` … `MM-PO-011`, a **closed list**, unchanged at v1.5) |
| Of those, carried in §16.3a's role-column matrix | ⛔ **2** — `MM-PO-002` and `MM-PO-011` **only** |
| Remaining with no ranked operation×role source | ⛔ **9** — `MM-PO-001`, `003`, `004`, `005`, `006`, `007`, `008`, `009`, `010` |

⚠️ **A near-miss was checked rather than counted.** A bare search appears to
show `MM-PO-003` and `MM-PO-004` inside §16.3a — ⛔ **they are not matrix
rows.** They occur in one **prose** sentence citing `MM-NFR-008`'s existing
separation discipline. ⭐ **Inspected at the line rather than counted as a
hit**, which is the §2D.1 principle this repository applies to substring
near-misses.

⭐⭐ **The nine remaining operations are still governed only by the informal
`"class"` language of §16.3** — *"Owner/Manager class"*, *"Reception class
and above"*, *"Owner class"* — which is precisely what `Accepted`
[`ADR-0019`](../../00-governance/adr/ADR-0019-membership-management-prd-v1.4-baseline.md)
**L103** describes as naming the protected operations *"**without modelling a
role**"*. ⛔ **A class noun is not a `TR-n` identifier**, and D3 requires an
*operation×role* source.

⛔⛔ **THIS IS THE STRUCTURAL DIFFERENCE FROM `DD-0002`, AND IT IS NOT
CURABLE HERE.** `DD-0002` D3 resolves to its §14.3, derived *"only from
`PRD-004` §8.2's **closed matrix**"* of 12 protected operations — ⭐ **a
whole-module source that already existed**. ⛔ **`PRD-005` has no
equivalent.** Constructing one — assigning the nine uncovered operations to
roles — would be **inventing an operation×role mapping**, which README
§2B.4 rule 4 forbids (*"Permissions come from PRD / ADR / Auth sources
only"*), which `ADR-0043` **L177** forbids in terms (*"**Do not invent a new
permission ID**"*), and which this audit's conferral **expressly excludes**.
⭐ **The gap is therefore recorded, not closed.**

⛔ **`ADR-0132` §7's seven prerequisites are NOT engaged by this finding.**
That gate governs **minting a permission identifier**, and ⭐ **D3 requires
none** — it requires only that an existing authoritative source be **cited**.
⛔ **Prerequisite 7's hard gate on `ADR-0043` §5.1 is neither reached nor
weakened**, and ⛔ **`ADR-0132` and `ADR-0043` are byte-unchanged.**

#### 4.0.2a ⭐⭐ D3 — the four lawful authorization routes were EXHAUSTED, not assumed closed

⭐ Before `GAP` was retained, each existing route to authoritative
whole-module coverage for the **nine** uncovered operations — `MM-PO-001`,
`003`, `004`, `005`, `006`, `007`, `008`, `009`, `010` — was tested against
the repository. ⛔ **All four close, and each closes for a different,
measured reason.**

| Route | Question | Measured result |
|---|---|---|
| **(a)** `BC-18` / `PRD-001` already holds an operation×role source | Does the authorization context own this allocation? | ⛔ **NO — ZERO.** `grep -rc "MM-PO-" docs/30-product/authentication/` returns **0** across the entire corpus, and **0** `prd-v2/*` file mentions a membership operation. ⭐ `BC-18` owns the **mechanism**, not each module's allocation |
| **(b)** `ADR-0132` §5.3 derived capabilities can express it | Is the mechanism sufficient *in kind*? | ⭐ **YES in kind — but it does not say WHERE.** Measured: the **253** `LCF-/LCM-/LCO-AUTH-*` precedents live in **`PRD-021A` A1**, the **module's own PRD**, ⛔ **not** in `BC-18`. For `BC-02` that document is **`PRD-005`** |
| **(c)** An existing instrument already authorizes extending coverage | Does `ADR-0149` reach these nine? | ⛔ **NO — excluded in terms.** Its §5 states it does **not** amend `PRD-005` beyond its own subject and does **not** mark D3 `PASS` (§11). Its §16.3a matrix is confined to `MM-PO-002` and `MM-PO-011` |
| **(d)** A PO + Authorization Owner route exists | Is there a lawful path at all? | ⭐ **YES — and it is `PRD_LIFECYCLE.md` §4**, the frozen-PRD amendment route. ⛔ **But its destination is `PRD-005` itself** |

⭐⭐ **All four routes converge on one destination: a `PRD-005` amendment.**
⛔ **That is exactly what this act may not do** — and the proof is this
repository's own most recent precedent rather than an argument. Coverage for
`MM-PO-002`/`MM-PO-011` did **not** appear by derivation, inference or design
note: it required **new ranked requirements** — **`MM-FR-133`**…**`MM-FR-137`**
— authored into `PRD-005` **§16.3a** under `Accepted`
[`ADR-0149`](../../00-governance/adr/ADR-0149-membership-plan-and-configuration-change-request-workflow-authorization.md)
through the full **§4 seven-step route**. ⭐ **The nine remaining operations
would require the identical treatment: a new ADR, then a `PRD-005` v1.6.**

⛔⛔ **NEITHER IS AVAILABLE TO A DESIGN-DOC BOUNDARY AUDIT.** A Design Doc is
**UNRANKED** and *"never authority"*; ⛔ it cannot create a ranked
requirement, and ⛔ recording an allocation **here** would place authority in
the one document class that may not hold it — the precise error §2B.4 rule 4
and `ADR-0043` **L177** exist to prevent.

⭐ **The gap is therefore GENUINE, not procedural.** ⛔ It is **not** that the
answer exists somewhere unread; measured, **the answer does not exist in any
ranked document**. ⭐ **Recording `GAP` is the accurate finding, and
manufacturing coverage would have been the defect.**

⛔ **`ADR-0132` §7 remains NOT ENGAGED** — that gate governs **minting a
permission identifier**, and ⭐ this shortfall needs **none**: the nine
operations need an **allocation expressed in the existing derived-capability
vocabulary**, not a `PERM-*`. ⛔ **Prerequisite 7's hard gate over
`ADR-0043` §5.1 is neither reached, tested nor weakened.**

⭐ **Smallest lawful next action, routed and NOT performed here:** a **Product
Owner + Authorization (`BC-18`) Owner** one-act conferral to author an ADR
allocating the nine operations across `TR-1`…`TR-5` in the existing
`Action` × `Scope` vocabulary, executed as a `PRD-005` **v1.6** §4 successor
amendment. ⛔ **No part of that act is begun, pre-approved, drafted or
implied by this audit.**

#### 4.0.2b ⭐ D1, D2, D4 and D5 re-evaluated against existing evidence

⭐ Each was re-tested **independently** against ranked sources, to establish
whether its `GAP` is *"the fact does not exist"* or *"the fact exists but
this document has not declared it."* ⛔ **The distinction changes the owner
of the remedy; it does NOT change the verdict** — §2B.5 **L399** makes a
declaration that is *"missing **or** unsourced"* a `GAP`, and all four remain
undeclared **in this document**.

| # | Verdict | Do the underlying facts exist in a ranked source? | Why the verdict still stands |
|---|---|---|---|
| **D1** | ⚠️ **GAP** | ⭐ **Partly.** README §2B.1 fixes the three apps and their code homes, and `lib/app/{student,staff,platform_admin}/` exists | ⛔ The **mapping of these 13 surfaces onto APP 1 / APP 2** is a **design** statement only this document can make. ⛔ Measured **0** `APP n` tokens |
| **D2** | ⚠️ **GAP** | ⭐ **Yes, for the role set** — `PRD-001` §2.4 closes `TR-1`…`TR-5`; `PRD-005` **`MM-FR-137`** now names `TR-4`/`TR-5` explicitly | ⛔ This document still measures **0** `TR-n`. ⭐ Rewriting §4.1's *"Staff (reception / owner)"* into identifiers is **design authorship**, ⛔ not audit recording — and §2B.6 authorises *"audited, **not rewritten**"* |
| **D4** | ⚠️ **GAP** | ⭐⭐ **YES — decisively, and this is the strongest of the four.** **`MM-XC-014`** excludes *"**Reading or writing another tenant's membership under any circumstance**"*; **`MM-XC-013`** excludes cross-tenant membership; **`MM-AC-094`** verifies that *"no cross-tenant or cross-library membership is representable"* | ⛔ **But the source existing is not the declaration being made.** This document cites **none** of them — measured **0** `MM-XC-*`. ⭐ `DD-0002` reached `PASS` on D4 because **its §14.1 states the scope and cites `SM-8.1`–`SM-8.3`**; ⛔ `DD-0001` has no equivalent subsection |
| **D5** | ⚠️ **GAP** | ⭐ **Partly** — §5 documents the `BC-05` payment hand-off, a **bounded-context** edge | ⛔ A context edge is **not** an app boundary. ⭐ **S-4 Payment is assigned to the Staff audience**, so on the ranked evidence it is an intra-APP-2 step, ⛔ **but this document nowhere states that in app vocabulary** |

⭐⭐ **D4 IS THE CLEAREST CASE FOR THE DISTINCTION THIS AUDIT REFUSES TO
BLUR.** ⛔ Its authoritative source is **frozen, ranked and unambiguous** —
so it would have been easy, and wrong, to mark it `PASS`. ⭐ **`PASS` under
§2B.5 requires the scope be *"declared and sourced"*, and this document
declares nothing.** ⛔ Marking `PASS` would record a declaration that a
reader could not find — the defect §2B.5 exists to expose.

⛔⛔ **WHY THE AUDIT DOES NOT SIMPLY WRITE THE MISSING DECLARATIONS.** ⭐ All
four are closable by a **recording** act, and `DD-0002` §4.0 is the
precedent — ⚠️ **but that precedent added only Declaration 1**, because
`DD-0002` **already carried** D2–D5 in its own §4.1/§14.1/§14.3/§6.3.
⛔ **`DD-0001` carries none of the four**, so supplying them is **authoring
four new declarations**, not restating existing ones — ⭐ exactly what
§2B.6's *"audited, not rewritten"* withholds from an audit act, and the
**UX Architecture Owner**'s to author.

⭐ **Routed, NOT performed:** a **UX Architecture Owner** act may close
**D1, D2, D4 and D5** purely by recording facts that already exist in
ranked sources — ⛔ **no new governance, no PO or Authorization Owner act,
and no `PRD-005` amendment is required for those four**. ⚠️⚠️ **`D3` is
different in kind and is NOT closable that way** (§4.0.2a): its fact
**does not exist in any ranked document**, which **`MM-XC-016`** states
positively — *"Defining a role, permission or authorisation model"* is
**excluded from `BC-02`**, and `BC-18` holds **zero** `MM-PO-*`.
⭐ **So `PRD-005` is barred from defining it and `BC-18` has not: that is the
gap, and it is real.**

#### 4.0.3 What the audit did NOT do

⛔ **No declaration was upgraded to `PASS` to make this document look
design-ready.** ⭐ Under §2B.5, `DD-0001` is therefore ⛔ **NOT design-ready**
— a conclusion this document's own §19 readiness verdict and §18 gap register
already reach on independent grounds, and which this audit **corroborates
rather than contradicts**.

⛔ **No `DD-0001-GAP-*` identifier is minted for these five verdicts.** They
are recorded **here**, in the audit subsection §2B.6 calls for; ⭐ the §18
register's **12** existing entries are **unchanged**, and ⛔ **none is closed,
reopened, renumbered or reworded.**

⛔ **The version and status cells are NOT advanced** — this document remains
**v0.2**, ⛔ **`PROPOSED`**, ⛔ **UNRANKED**. ⭐ That follows the `DD-0002`
precedent exactly: its §4.0 boundary audit added a subsection and ⛔ **did not
bump its version or status**, because §2B.6 authorises an **audit**, and
recording a verdict is not approving a document. ⛔ **This subsection confers
nothing.**

### 4.1 Two audiences, one context

`PRD-005` addresses two distinct readers; the IA separates them:

| Audience | Needs | Surfaces |
|---|---|---|
| **Staff** (reception / owner) | Create, renew, upgrade, collect, reconcile, monitor | S-1, S-2, S-3, S-4, S-5, S-8, S-9, S-10, S-11, S-12 |
| **Student / parent** | *"Am I active? Until when? What do I owe?"* | S-6, S-7, S-13 (read-only) |

⛔ **The student never sees staff operational surfaces**, and that is an
authorisation outcome asked of `BC-18` — ⛔ **never inferred from
visibility** (`PRD-008` `FEE-XC-014`: *"visibility of a screen confers
nothing"*).

### 4.2 Hierarchy within the context

```
Membership (context root)
├── Plans                     S-1 list → S-2 create/edit
├── Memberships
│   ├── Create                S-3 → S-4 payment  (two explicit stages)
│   ├── Detail                S-5 → S-8 renew | S-9 upgrade
│   └── Lists                 S-10 expiring | expired
├── Reconciliation queue      S-11
└── Student view              S-6 status · S-7 validity · S-13 pending
```

**Depth ≤ 3 taps** from context root to any action.

### 4.3 The one question each surface answers

Per the instruction that every screen answer *where am I / what can I do /
what happened / what next*:

| Surface | Primary question |
|---|---|
| S-1 | *Which plans can I sell?* |
| S-3 | *Is this the right student, plan and end date?* |
| S-4 | *How much, and has it been collected?* |
| S-5 | *What exactly does this student hold?* |
| S-6/S-7 | *Am I active, and until when?* |
| S-8/S-9 | *What will change if I confirm?* |
| S-10 | *Who needs attention?* |
| S-11 | *What is stuck?* |
| S-13 | *Why don't I have access yet?* |

---

## 5. User flows

⭐ All four are fixed by `PRD-005`; ⛔ none is invented.

### 5.1 Creation → payment *(§20 rows 3–4, BC Map §10 L465)*

```
S-1 Plan list
  → select plan
S-3 Creation
  → select student  (explicit, required)
  → select plan     (explicit, required)
  → REVIEW: computed endDate + amount        ← MUST precede submit
  → submit
      ├─ success → membership PendingPayment → S-4
      └─ typed error → inline at field (§7.4)
S-4 Payment  (SEPARATE STAGE — never merged)
  → amount shown
  → cash collected by staff                   (ADR-0130: V1 cash only)
  → confirm collection
      ├─ success → Active → S-5
      ├─ failure → stays PendingPayment, correctable (§21 case 12)
      └─ timeout → stays PendingPayment, activates on arrival (§21 case 13)
```

⛔⛔ **A single "create & collect" button is PROHIBITED** — BC Map §10 L465
calls it a *"fake atomic button"*. ⚠️ The two stages must be
**independently recoverable**: a student interrupted after stage 1 must find
a coherent `PendingPayment` record, not a lost form.

### 5.2 Renewal *(§20 row 8, §6.3, §21 cases 6/7/8/9)*

```
S-5 Detail → Renew
  → REVIEW: new term + WHICH §6.3 CASE APPLIES   ← MUST precede confirm
      · before expiry      → starts endDate + 1
      · exactly at expiry  → starts endDate + 1   (today == endDate)
      · after expiry       → starts TODAY
  → confirm
      ├─ success → new term; source Superseded
      └─ duplicate → suppressed by idempotencyKey, or names existing successor
```

⭐ Naming the case is a **`PRD-005` requirement**, not a nicety — staff
otherwise cannot tell a gap-free renewal from a lapsed one.

### 5.3 Upgrade *(§20 row 9, §21 cases 10/11)*

```
S-5 Detail → Upgrade
  → REVIEW 4 facts: current plan · target plan · price difference · remaining days on source
  → confirm
      ├─ Active source   → new term today; source Superseded;
      │                    remaining days PUBLISHED, ⛔ NOT REFUNDED
      └─ PendingPayment  → REFUSED; correct path is void-and-recreate (MM-FR-102)
```

⚠️ The surface **must not imply a refund**. The honest phrasing is that
remaining days are accounted for, ⛔ not returned as money.

### 5.4 Void before activation *(`MM-FR-078`/`079`)*

```
S-5 (PendingPayment only) → Void
  → reason REQUIRED  (voidReason, voidedBy)
  → confirm
      → Voided. ⛔ Not a cancellation of an active membership — a
        different act with different consequences (§21 case 25:
        a later payment must be refused and surfaced for BC-05)
```

---

## 6. Surface design — 13 surfaces, traced

⭐ Every row cites its `PRD-005` §20 source. ⛔ **0 requirements invented.**

| # | Surface | §20 requirement | Design | Depth |
|---|---|---|---|---|
| **S-1** | Plan list | name, duration **in days**, price + currency, availability, active state; filter by active | 2.5D plan cards in a single column; duration as stored; filter as segmented control (Active / All) | 2.5D |
| **S-2** | Create / edit plan | disable-or-mark immutable fields (§2.5); **explain why**, never fail silently on submit | 2D form. Immutable fields disclosed **at the field, pre-submit**, with reason inline. ⛔ A disabled control with no reason is non-compliant | 2D |
| **S-3** | Membership creation | explicit student **and** plan selection; computed `endDate` **before** submit; amount shown | 2D form, 2.5D review card before submit showing `endDate` + amount. ⛔ `endDate` read from module, never client-computed | 2D + 2.5D review |
| **S-4** | Payment step | explicit **two-stage** flow (BC Map L465) | Distinct stage with own confirm. Amount is the visual anchor. ⚠️ V1 **cash only** — ⛔ no digital method drawn | 2.5D |
| **S-5** | Membership detail | term, status, plan, **price snapshot**, renewal/upgrade lineage | 2.5D summary card + 2D lineage list. Snapshot price, ⛔ not current plan price (§21 case 4) | 2.5D + 2D |
| **S-6** | Status presentation | `MembershipStatus` **and** `EnrollmentStatus` as **separate** fields, never merged (`MM-FR-076`) | ⛔⛔ **Two distinct labelled fields.** A composite "status" chip is **PROHIBITED** — §21 case 27 depends on it | 2D |
| **S-7** | Validity | module's answer (`isValid` + status); ⛔ **MUST NOT** re-derive from dates (`MM-FR-066`) | Single validity statement from `isValid`. ⛔ Client-side date comparison **PROHIBITED** — also a security property (§14) | 2.5D |
| **S-8** | Renewal | computed new term **before** confirm, **including §6.3 case** | 2.5D pre-confirmation card naming the case in words | 2.5D |
| **S-9** | Upgrade | current plan, target plan, price difference, remaining days — **before** confirm | 2.5D comparison card, source vs target side by side | 2.5D |
| **S-10** | Expiring / expired lists | available, filterable by plan + date range, **paginated** | 2D dense list, sticky filter bar, pagination. Highest information density in the context | 2D |
| **S-11** | Reconciliation queue | visible to authorised staff (`MM-BR-004`) | 2D list; each row states what is stuck and the next safe action. ⚠️ Authorisation asked of `BC-18` | 2D |
| **S-12** | Validation / errors | typed error's **field and reason**; ⛔ **MUST NOT** show generic failure | Field-level errors + summary (§7.4). ⛔ *"Something went wrong"* non-compliant. ⛔ No internal identifiers | 2D |
| **S-13** | `PendingPayment` | make clear it confers **no** entitlement yet | 2.5D card stating plainly that nothing is granted yet, with what to do. ⛔ Never styled as success | 2.5D |

⭐ **13 of 13** §20 rows treated; ⛔ **0** surfaces beyond them.

---

## 7. Screen states — all six, all surfaces

⚠️ **v0.1 specified 3 of 6.** The remaining three are specified here as
**design** behaviour, ⛔ inventing no product rule.

### 7.1 State matrix

| Surface | Loading | Empty | Error | Success | Permission | Offline/stale |
|---|---|---|---|---|---|---|
| S-1 Plan list | skeleton ×3 | ⭐ two distinct | typed + retry | — | `GAP-005` | stale banner |
| S-2 Plan form | field disable | n/a | inline + summary | confirm + return | `GAP-005` | ⛔ block submit |
| S-3 Creation | stepwise | student/plan not found | inline at field | → S-4 | `GAP-005` | ⛔ block submit |
| S-4 Payment | ⚠️ **non-cancellable** | n/a | stays Pending | → Active | `GAP-005` | ⚠️ see §7.5 |
| S-5 Detail | skeleton card | n/a | typed + retry | — | `GAP-005` | stale banner |
| S-6/S-7 | skeleton | no membership | typed + retry | — | own data | ⭐ **last-known + timestamp** |
| S-8/S-9 | compute term | n/a | inline | new term + return | `GAP-005` | ⛔ block confirm |
| S-10 lists | skeleton ×5 | ⭐ two distinct | typed + retry | — | `GAP-005` | stale banner |
| S-11 queue | skeleton | ⭐ **positive empty** | typed + retry | item cleared | `GAP-005` | stale banner |
| S-13 Pending | skeleton | n/a | typed | → Active | own data | stale banner |

### 7.2 Loading — three tiers by expected wait

| Tier | Treatment | Why |
|---|---|---|
| **< 300 ms** | ⛔ **nothing** | A flashed spinner reads as jank on a slow device |
| **0.3–3 s** | skeleton matching final layout | Reserves height; ⛔ no layout shift *(Pro Max: reserve space / CLS)* |
| **> 3 s, or user-initiated write** | skeleton + progress text | On a slow network, silence reads as failure |

⛔ **No indeterminate spinner over a whole screen** where a skeleton can
show the shape of what is coming.

### 7.3 Empty — the distinction that matters

⭐ **"Nothing exists" and "nothing matches your filter" are different facts
and MUST NOT share one treatment.**

| Surface | Genuinely empty | Filtered to nothing |
|---|---|---|
| S-1 | *No plans yet* + primary action to create | *No active plans* + clear-filter action |
| S-10 | *No memberships expiring* — neutral | *No results in this range* + widen-range action |
| S-11 | ⭐ *Nothing needs reconciliation* — **positively framed**; an empty queue is **good news** | *No items match* + clear filter |

⛔ **No illustration on staff operational empties** — they recur daily and
an illustration becomes noise. ⭐ 3D is permitted on the **student** empty
(§8.6) where it is seen rarely.

### 7.4 Error — two-layer, per Pro Max + `PRD-005`

Pro Max (`--domain ux`) and §20 row 12 agree:

1. **Inline, at the field** — the typed error's field and reason
2. **Summary at top of form** on failed submit, focus moved to it, each item linked to its field
3. ⛔ **Never replace inline with summary-only**, and ⛔ never the reverse
4. **Validate on blur** for most fields; ⛔ not only on submit
5. ⛔ **No internal identifiers** in any message (`ACCESSIBILITY.md` §2)

| Class | Treatment |
|---|---|
| Field validation | inline, on blur, specific *(`API-6` permits specificity here)* |
| Domain rejection (inactive plan, wrong enrollment state) | inline naming the state, per §21 cases 2/3 |
| Conflict (duplicate renewal) | names the existing successor, offers to open it |
| Infrastructure / timeout | retry + *"no charge was recorded"* reassurance where true |
| ⛔ Authorization / existence | ⛔⛔ **MUST NOT disclose** — see §14 |

### 7.5 ⚠️ Offline — the money boundary

| Situation | Behaviour |
|---|---|
| **Reads** (S-1, S-5, S-6, S-7, S-10) | Show last-known data with an explicit **stale** marker + timestamp. ⛔ Never present stale as fresh |
| **Writes** (S-2, S-3, S-8, S-9) | ⛔⛔ **BLOCK with a clear reason.** ⛔ No offline queue, ⛔ no optimistic membership |
| **S-4 payment confirm** | ⛔⛔ **HARD BLOCK.** ⚠️ Cash has changed hands physically; an optimistic local "collected" that never reaches the server creates a **financial discrepancy**, and §21 case 24 routes exactly that to reconciliation. ⭐ Blocking is the safe design |

⛔ **Design invents no cache semantics or offline writes**
(`PERFORMANCE.md` §3).

### 7.6 Success — proportionate

| Weight | Treatment |
|---|---|
| Low (filter applied) | state change only, ⛔ no toast |
| Medium (plan edited) | inline confirmation, auto-dismiss |
| **High (membership Active after payment)** | persistent confirmation on S-5 naming term + amount. ⛔ **No confetti, no celebratory animation** — a financial receipt moment must read as *trustworthy*, not playful |

---

## 8. Visual language — 2D / 2.5D / 3D

### 8.1 The governing rule

`VISUAL_LANGUAGE.md` fixes the ratio as **CONFIRMED**: ~70% clean 2D, ~20%
subtle depth, ~10% premium 3D illustration. ⛔ This document **applies** that
ratio; it does not restate or amend it.

### 8.2 Allocation across the 13 surfaces

| Dimension | Surfaces | Count | Why |
|---|---|---|---|
| **2D** | S-2, S-6, S-10, S-11, S-12 + forms in S-3 | **5 primary** | Forms, dense lists, status fields, errors. ⭐ **Clarity and scan speed dominate** — depth on a 50-row expiring list is cost with no comprehension gain |
| **2.5D** | S-1, S-4, S-5, S-7, S-8, S-9, S-13 + S-3 review | **7 primary** | ⭐ **Decision and consequence moments.** Elevation groups *"what you are about to commit to"* and separates it from the form beneath — hierarchy, not decoration |
| **3D** | **1 asset only** — student empty state (§8.6) | **1** | Rare, emotional, explanatory |

### 8.3 Typography — roles, not values

⛔ **No family, size or weight is specified** — `DESIGN_SYSTEM.md` §2 leaves
these `TO BE DECIDED` and `DBT-005` records no type token class exists.

| Role | Behaviour required |
|---|---|
| **Amount / money** | Highest weight on S-4; tabular figures so digits align; ⛔ never smaller than the label beside it |
| **Dates / term** | Tabular figures; ⛔ never truncated — a clipped end date is a trust failure |
| **Status labels** | Two separate fields (S-6); equal visual weight so neither reads as subordinate |
| **Body** | Must wrap, ⛔ never truncate mid-word; sized for **+40%** translation expansion |
| **Plan duration** | Number and unit inseparable — ⛔ *"30"* alone is meaningless |

⭐ **Anti-pattern adopted from Pro Max:** ⛔ no body text below the legible
floor, ⛔ no gray-on-gray. ⚠️ Exact minimum is `TO BE DECIDED` with the
standard (`GAP-003`).

### 8.4 Colour — semantic roles only

⛔ **No hex value is specified or ratified here.** `theme.dart` already
defines 12 colours; whether they are the design system is **`DBT-001`**, the
Design System Owner's call.

| Role | Requirement |
|---|---|
| Money / amount | ⛔ **Not** semantic-success green. Money is neutral until collected; green implies "done" |
| `Active` | success role |
| `PendingPayment` | ⚠️ **warning role, never success** — it confers nothing |
| `Expired` / `Voided` | muted/neutral, ⛔ not danger — expiry is normal, not an error |
| Validation error | danger role, **+ icon + text** |
| ⛔⛔ **Every state** | ⛔ **Colour is NEVER the only carrier** (`ACCESSIBILITY.md` §2). Each state carries **icon + text + colour** |

### 8.5 Depth rules for 2.5D

| Rule | Value |
|---|---|
| Elevation levels | **Exactly 3** — base surface, raised card, modal/sheet. ⛔ No fourth |
| Purpose | Grouping and priority only. ⛔ Never decoration |
| ⛔ Prohibited | Blur, backdrop filter, glass, gradient overlays that reduce contrast, floating decorative objects |
| Shadow | Must not soften the card edge — ⛔ a lost edge is a lost boundary |

### 8.6 3D — exactly one asset, and its conditions

⭐ **Permitted:** the **student-facing "no membership yet" empty state**
(S-6 for a student with no record).

**Why this and nothing else:**
- Seen **rarely** and usually **once** — so its cost amortises against a genuine first-run moment
- Student-facing, where comprehension and reassurance matter more than scan speed
- ⛔ **Not** on any staff operational surface — those recur daily

**Binding conditions:**

| Condition | Requirement |
|---|---|
| Format | **Static pre-rendered raster**. ⛔ No WebGL, ⛔ no runtime 3D, ⛔ no animation |
| Loading | Lazy-loaded, ⛔ **never blocking**; the explanatory text renders and is complete without it |
| Failure | Surface fully usable if the asset never loads |
| Placeholder | Fixed reserved height — ⛔ no layout shift |
| Accessibility | Decorative; ⛔ carries no information not present in text |

⛔⛔ **3D appears nowhere else in `BC-02`.** Extending it needs the
UI/Visual Design Owner → `DD-0001-GAP-011`.

---

## 9. Components

### 9.1 Existing — reuse before extension

`DESIGN_SYSTEM.md` §5: prefer existing; extension requires the Design System
Owner to record why composition is insufficient.

| Component | Observed at | Use in `BC-02` |
|---|---|---|
| `PanelCard` | `lib/app/shared/widgets/common.dart` | 2.5D container for S-1, S-4, S-5, S-8, S-9, S-13 |
| `SectionHeader` | same | Section titles on all surfaces |
| `Pill` | same | Status labels S-6 *(two pills, never one)* |
| `EmptyState` | same | §7.3 empties |
| `MetricTile` | same | Days-remaining, amount-due |
| `MeterBar` | same | Term progress on S-7 |
| `Monogram` | same | Student identity on S-3, S-5 |

⛔ **Citing these is not approving them** — they were built without a design
artifact (`DD-0001-GAP-009`).

### 9.2 New components — 6, each justified

| Component | Purpose | Why composition is insufficient | States |
|---|---|---|---|
| `ReviewCard` | Pre-confirmation disclosure (S-3, S-8, S-9) | ⭐ `PRD-005` requires computed values shown **before** submit in 3 flows; a shared component is the only way the rule cannot be forgotten on one of them | loading(computing) · ready · error |
| `DualStatusRow` | `MembershipStatus` + `EnrollmentStatus` (S-6) | ⭐ `MM-FR-076` forbids merging. A dedicated component makes the prohibition **structural** rather than a convention a future dev may breach | both-known · one-unknown · loading |
| `ValidityStatement` | Single validity answer (S-7) | ⭐ `MM-FR-066` forbids client re-derivation. Encapsulating it means no screen can accidentally compute validity from dates | valid · invalid · unknown · stale |
| `AmountBlock` | Money display (S-4, S-5, S-9) | Tabular figures, currency inseparable, snapshot-vs-current distinction. Cannot be a plain text style | amount · zero · unavailable |
| `TwoStageProgress` | Creation → payment (S-3, S-4) | ⭐ BC Map L465's two-stage rule needs a visible structure; a generic stepper would allow collapsing to one step | stage1 · stage1-done · stage2 · complete |
| `StaleDataBanner` | Offline/stale reads (§7.5) | Must state *what* is stale and *when* last fetched; no existing component carries both | stale · reconnecting · fresh(hidden) |

⛔ **Every new component needs Design System Owner approval**
(`DESIGN_SYSTEM.md` §5) — ⛔ this document does not grant it.

### 9.3 Component contract

All 6 must satisfy `DESIGN_SYSTEM.md` §3's eleven items, using
[`../../design/templates/COMPONENT_SPEC_TEMPLATE.md`](../../design/templates/COMPONENT_SPEC_TEMPLATE.md).
⚠️ Their token sections cannot be completed until `DBT-001` is decided.

---

## 10. Interaction and motion

### 10.1 Five motion classes — purpose, not polish

⚠️ Pro Max's *"one duration for every transition"* anti-pattern is adopted:
timing follows distance and context.

| Class | Applies to | Purpose | Reduced-motion |
|---|---|---|---|
| **Tap feedback** | every control | Confirm the tap registered — Pro Max: pressed feedback within **80–150 ms** | ⭐ **Retained** — it is feedback, not decoration |
| **Stage transition** | S-3 → S-4 | Spatial continuity; forward motion means progress | Cross-fade |
| **State change** | status/validity updates | Draw the eye to what changed | Instant swap |
| **Skeleton → content** | all loading | Soften arrival, ⛔ no layout shift | Instant |
| **Sheet / modal** | confirmations | Establish layer above | Instant appear |

⛔ **Prohibited:** parallax, continuous/looping animation, spring overshoot
on financial confirmations *(bouncy money reads as unserious)*, animated
progress on the payment stage *(implies processing we do not do — V1 is
cash)*, celebratory motion.

⭐⭐ **Binding:** ⛔ **No essential state may depend on animation**
(`VISUAL_LANGUAGE.md` §7). Every state is legible in a static screenshot —
which is also the Figma-prototype test.

### 10.2 Interaction rules

| Rule | Requirement |
|---|---|
| Touch target | ⭐ **≥48×48dp** (Pro Max: 48dp Android / 44pt iOS; ⛔ *"treat one unit as universal"* is the anti-pattern). Expand hit area when the icon is smaller |
| Target spacing | **≥8 px** between adjacent targets |
| One primary gesture per region | ⛔ No nested tap/drag conflict |
| Disabled | Real disabled semantics + reduced emphasis + **no tap action**. ⛔ Never looks tappable |
| Destructive (void) | Requires reason entry; ⛔ not a bare confirm |
| Back | ⭐ Predictable. Leaving S-4 must **not** silently discard the `PendingPayment` record — it exists server-side and the user must be told where it went |
| ⛔ Hover | ⛔ **Never** the only affordance |

---

## 11. Accessibility

⚠️ **Standard is `TO BE DECIDED`** (`ACCESSIBILITY.md` header). The **9
required checks** are applied per surface; ⛔ **no numeric threshold is
asserted** — importing Pro Max's `4.5:1` would decide `GAP-003` from a
feature doc.

| # | Check | `BC-02` application |
|---|---|---|
| 1 | Keyboard / switch / screen-reader path | Every action reachable; S-3 → S-4 traversable without gestures |
| 2 | Focus visible, ordered, survives state change | ⭐ Focus moves to the **error summary** on failed submit (§7.4); ⛔ not trapped |
| 3 | Increased text size | Amounts and dates ⛔ **must never truncate**; cards grow vertically |
| 4 | ⛔ Colour never sole carrier | All 6 state groups carry **icon + text + colour** (§8.4) |
| 5 | Accessible names | Every icon-only control named; ⛔ `Pill` colour alone insufficient |
| 6 | Errors identify problem + recovery | §7.4; ⛔ no internal identifiers |
| 7 | States perceivable without motion | §10.1 |
| 8 | Reduced motion | Tap feedback retained; all else reduced (§10.1) |
| 9 | Touch targets | ≥48×48dp, ≥8 px apart (§10.2) |

⭐ **Screen-reader priority on S-6/S-7:** validity and status are announced
**before** decorative or secondary content — a student using a screen reader
should learn *"active until 30 April"* first, not last.

⚠️ **Measured baseline:** **0** occurrences of `Semantics`,
`semanticsLabel`, `meetsGuideline` or `textScaleFactor` under `lib/`, and
**0** accessibility assertions under `test/` (`DIT-007`). ⭐ These checks are
therefore **design requirements against an unimplemented baseline** — stated
plainly rather than implied as satisfied.

---

## 12. Responsive behaviour

⛔ **No breakpoint values** — `DBT-002` records that none exist and the
Responsive Design Owner owns them. ⭐ **Adaptation behaviour** is specified,
which is what a prototype needs.

| Width class | Behaviour |
|---|---|
| **Narrow phone** *(reference)* | Single column. Sticky bottom CTA bar for primary action, respecting **safe area** (Pro Max: safe-area compliance). Lists get bottom inset so content is never hidden behind fixed bars |
| **Wider phone** | Same single column; ⭐ gutters increase, ⛔ content measure does **not** grow unbounded |
| **Tablet / large** | Two-pane permitted for **S-10 list → S-5 detail**. ⛔ Long-form text never edge-to-edge |
| **Landscape** | ⛔ Payment confirm (S-4) must remain fully visible without scrolling the amount off-screen |

**Binding rules:**
- ⛔ **No horizontal scroll** at any width *(Pro Max anti-pattern)*
- ⛔ **No fixed pixel container widths**
- ⛔ **Zoom never disabled**
- **4/8 dp spacing rhythm**; vertical hierarchy tiers, ⛔ not random increments
- S-10's dense table **must reflow to cards** on narrow widths, ⛔ never horizontally scroll a financial table

---

## 13. Performance

Per `PERFORMANCE.md`; ⛔ numeric budgets are `TO BE DECIDED` and ⛔ none is
invented.

| Rule | Application |
|---|---|
| Useful before every asset | ⭐ All 13 surfaces fully functional with **0** images loaded. The single 3D asset is lazy and non-blocking (§8.6) |
| Reserve space | Skeletons match final layout height — ⛔ no layout shift |
| Pagination, not infinite scroll | S-10 — ⭐ `PRD-005` §20 **requires** pagination; also bounds memory on low-end devices |
| Transform/opacity only | §10.1 motion; ⛔ never animate width/height *(Pro Max anti-pattern)* |
| ⛔ Prohibited | Full-screen video, WebGL, heavy 3D, large decorative backgrounds, blur layers |
| Icons as SVG/vector | ⛔ **Never emoji as icons** *(Pro Max)* |
| ⚠️ Rendering-cache caution | Pre-compute list state; ⛔ avoid per-frame O(n) recomputation in scrolling lists — a measured Android artifact class in this repository |
| Profile before optimising | *(Pro Max Flutter row)* — ⛔ no optimisation asserted without measurement |

---

## 14. Security and privacy UX

⛔ **No security or privacy behaviour is invented.** Where `PRD-005` is
silent, the gap is cited.

| Concern | Position |
|---|---|
| ⭐ **Client-side validity** | ⛔⛔ **PROHIBITED** (`MM-FR-066`). ⭐ Also a **security** property: a client that computes validity can be manipulated into granting entitlement. The surface displays the module's answer |
| ⭐ **Status merging** | ⛔ **PROHIBITED** (`MM-FR-076`). Merging hides that a suspended student retains a membership record — §21 case 27 |
| **`PendingPayment` disclosure** | ⛔ **MUST** state no entitlement is conferred. ⚠️ Presenting it as provisional access would be a false security claim |
| **Authorisation** | ⭐ Asked of `BC-18`; ⛔ **never inferred from visibility**. ⛔ **0** permission identifiers created |
| ⛔ **Denial disclosure** | ⛔⛔ *"exists but forbidden"* and *"does not exist"* **MUST be indistinguishable** (`API-4`, `ADR-0010` *"enumeration oracle"*). ⛔ A denial must not name the failing rule, role or another principal's state (`API-5`) |
| **PII on screen** | ⚠️ Student name/contact appear on S-3/S-5. ⛔ Which fields, to which role, and masking rules are **undecided** → `SPX-GAP-003` |
| **Permission-denied presentation** | ⚠️ Hidden vs visible-and-disabled **discloses different information** → `GAP-005`/`SPX-GAP-006` |
| **Tenant identification** | ⚠️ Staff acting in the wrong tenant is a cross-tenant event → `SPX-GAP-007` |
| **Error messages** | ⛔ No internal identifiers, no stack detail, no tenant/actor ids |

---

## 15. Design QA expectations

Per `DESIGN_QA.md`, using
[`../../design/templates/DESIGN_QA_EVIDENCE_TEMPLATE.md`](../../design/templates/DESIGN_QA_EVIDENCE_TEMPLATE.md).

**`BC-02`-specific blocking conditions** — QA **must** return the work if:

1. ⛔ Creation and payment appear as **one** action *(BC Map L465)*
2. ⛔ `MembershipStatus` and `EnrollmentStatus` appear **merged** *(`MM-FR-076`)*
3. ⛔ Validity is **computed in the client** *(`MM-FR-066`)*
4. ⛔ A generic failure message appears anywhere *(§20 row 12)*
5. ⛔ `PendingPayment` is styled as **success**
6. ⛔ A renewal confirm **omits the §6.3 case**
7. ⛔ An upgrade **implies a refund** of remaining days
8. ⛔ Any state is conveyed by **colour alone**
9. ⛔ A digital payment method is depicted *(`ADR-0130`: V1 cash only)*
10. ⛔ A single-day plan is depicted *(blocked by `MM-GAP-008`, §21 case 29)*
11. ⛔ A denial discloses existence or reason *(`API-4`/`API-5`)*

⚠️ **Evidence limitation:** **1** `testWidgets` assertion exists
repository-wide (`DBT-004`), so automated UI evidence is `NONE OBSERVED` for
all 13 surfaces. ⛔ The **819**-test suite is **not** UI evidence.

---

## 16. Engineering handoff

### 16.1 Handoff package requirements

`DESIGN_ENGINEERING_HANDOFF.md` §1, applied:

| Item | State |
|---|---|
| Screen inventory | ⭐ 13 surfaces, §6 |
| Interaction states | ⭐ 6 per surface, §7 |
| Responsive variants | ⚠️ behaviour §12; ⛔ values blocked `GAP-004` |
| Content / localization notes | ⭐ §2 — +40% expansion, no baked text, no concatenation |
| Accessibility annotations | ⚠️ 9 checks §11; ⛔ standard `GAP-003` |
| Asset rules | ⭐ §8.6, §13 |
| Performance notes | ⭐ §13 |
| PRD traceability | ⭐ §17 |
| Unresolved questions | ⭐ §18 — 11 gaps |
| Approval evidence | ⛔ **NONE** — `PROPOSED` |
| Figma link | ⛔ **NONE** — not yet built |

### 16.2 ⛔ Not handoff-ready — and why

`DESIGN_ENGINEERING_HANDOFF.md` §2 requires Design QA state coverage,
Accessibility Owner confirmation, Design Performance Owner sign-off and a
complete traceability row. Measured: accessibility standard undecided,
breakpoints undecided, **0** QA records, **0** approvals.

### 16.3 Flutter-specific notes

⚠️ Liboora is locked at **Flutter 3.35.4**; ⛔ Pro Max's Flutter rows target
3.44.x. Applied as principles only:

| Note | Source |
|---|---|
| Theme via `ColorScheme` semantic roles, ⛔ not individual colour properties | Pro Max Flutter *(Theming)* |
| Shared state via the app's existing state management, ⛔ not `setState` for global state | Pro Max Flutter *(State)* |
| Profile with DevTools before optimising | Pro Max Flutter *(Performance)* |
| Use Flutter 3.35.4 theme data classes (`CardThemeData` etc.) | Liboora environment lock |
| ⛔⛔ **`app` may not import `domain/library`** | §17.1 — the binding constraint |

---

## 17. PRD traceability

| Surface | `PRD-005` | `IMPL-*` | Code | Test evidence | Status |
|---|---|---|---|---|---|
| S-1, S-2 | `MM-FR-029`…`032`, `MM-BR-009`, §2.5 | ⚠️ `IMPL-409` *(`app`)* | `NONE OBSERVED` | `membership_plan_lifecycle_test.dart` *(domain)* | ⛔ BLOCKED |
| S-3, S-4 | `MM-FR-050`/`051`, BC Map L465 | `IMPL-414`…`416` *(domain)* | `reception_desk.dart` ⚠️ unverified vs §20 | `membership_creation_gate_test.dart`, `…_preconditions_test.dart` | ⚠️ PARTIAL |
| S-5, S-6, S-7 | `MM-FR-066`, `MM-FR-076` | ⚠️ `IMPL-432` *(`app`)* | `NONE OBSERVED` | `membership_validity_void_test.dart` | ⛔ BLOCKED |
| S-8 | §6.3, `MM-FR-062` | `NONE OBSERVED` | `NONE OBSERVED` | `membership_renewal_test.dart`, `…_term_calculus_test.dart` | NOT STARTED |
| S-9 | `MM-FR-099`, `MM-FR-102` | `NONE OBSERVED` | `NONE OBSERVED` | `membership_upgrade_test.dart` | NOT STARTED |
| S-10, S-11 | `MM-FR-115`…`117`, `MM-BR-004` | ⚠️ `IMPL-433` *(`app`)* | `NONE OBSERVED` | `membership_reconciliation_isolation_test.dart` | ⛔ BLOCKED |
| S-12 | typed errors | `NONE OBSERVED` | `NONE OBSERVED` | `NONE OBSERVED` | NOT STARTED |
| S-13 | `MM-CFG-007`, §10.2 | ⚠️ `IMPL-434` *(`app`)* | `student_dashboard.dart` ⚠️ unverified | `membership_expiry_test.dart` | ⛔ BLOCKED |

### 17.1 ⭐⭐ The measured blocker

⭐ **Every `app`-module task in `PRD-005`'s register is one of the five
`ADR-0012` §3.4-blocked tasks** — `IMPL-409`, `432`, `433`, `434`, `436`,
measured as **the only 5** rows whose module column reads `app`.

Cause is architectural: `app` declares `domain/library` under `ports:`, not
`imports:`; the boundary checker reports **9** pre-existing violations that
`DOCUMENTATION_BASELINE.md` records as *"exits 1 by design"* and *"must not
be silenced."*

⛔ **Design cannot resolve this.** It is an **Architecture Owner** seam
question. ⭐ Design remains useful now because it is **not on the blocked
path** — surfaces can be specified and prototyped while the seam is resolved.

---

## 18. Gap register

⛔ **None closed to make this document look complete.**

| ID | Gap | Owning office | Status |
|---|---|---|---|
| `DD-0001-GAP-001` | App-level navigation placement of the context root | Information Architecture Owner → Founder/Product Authority | ⛔ OPEN |
| `DD-0001-GAP-002` | ⭐ **Loading/empty patterns now specified as design (§7.2/§7.3)**; ⛔ product copy for each empty state undecided | UX Architecture Owner | ⚠️ **PARTIALLY ADDRESSED** — copy open |
| `DD-0001-GAP-003` | Accessibility target standard `TO BE DECIDED` — blocks all numeric thresholds | Accessibility Owner → Founder/Product Authority | ⛔ **BLOCKED** upstream |
| `DD-0001-GAP-004` | ⛔ **0 breakpoints exist** (`DBT-002`) | Responsive Design Owner | ⛔ **BLOCKED** upstream |
| `DD-0001-GAP-005` | Permission-denied: hidden vs visible-and-disabled — **security-relevant** | Security Platform + UX Architecture Owner | ⛔ OPEN |
| `DD-0001-GAP-006` | Token authority contested (`DBT-001`); no radius/elevation/type class (`DBT-005`) | Design System Owner | ⛔ OPEN |
| `DD-0001-GAP-007` | All 5 `BC-02` surface tasks blocked (§17.1) | Architecture Owner | ⛔ OPEN |
| `DD-0001-GAP-008` | **10 `MM-GAP-*` open**, incl. `MM-GAP-008` (single-day plans **blocking**) | Product Owner | ⛔ OPEN — carried |
| `DD-0001-GAP-009` | `reception_desk.dart` / `student_dashboard.dart` render membership data but were built with no design artifact; ⛔ §20 conformance **not asserted** | Design QA Owner | ⛔ OPEN |
| ⭐ `DD-0001-GAP-010` | Student-motivation features (exam-schedule awareness, study nudges, discounts, referrals) — ⛔ **no `PRD-005` requirement exists**; ⛔ not designed | Product Owner | ⛔ OPEN |
| ⭐ `DD-0001-GAP-011` | Whether 3D may extend beyond the single §8.6 asset | UI/Visual Design Owner | ⛔ OPEN |
| ⭐ `DD-0001-GAP-012` | **6 new components (§9.2) require Design System Owner approval** — ⛔ not granted here | Design System Owner | ⛔ OPEN |

**12 gaps · 0 resolved · 2 blocked upstream · 1 partially addressed**

---

## 19. Readiness verdict

⚠️ Judged against usability, psychology, accessibility, performance,
consistency, requirements and feasibility — ⛔ **not** against attractiveness.

### 19.1 Figma prototyping — ⭐ **READY, with two stated substitutions**

A prototype can be built without inventing UX: **13** surfaces, **6** states
each, **4** flows with branch conditions, **13** component mappings, motion
classes with purpose, and 2D/2.5D/3D allocation.

⚠️ **Two substitutions the prototyper must make explicitly, not silently:**

| Missing | Instruction |
|---|---|
| Token values (`GAP-006`) | ⭐ Use `theme.dart`'s **observed** values as a **labelled placeholder**. ⛔ Do **not** present them as approved tokens |
| Breakpoints (`GAP-004`) | ⭐ Prototype at **one** narrow phone width and label it *reference width*. ⛔ Do **not** invent a tablet breakpoint |

⛔ **Prototype nothing from `GAP-005`, `GAP-008`, `GAP-010`** — permission-denied
presentation, single-day plans, motivation features.

### 19.2 Technical Specification — ⚠️ **NOT READY, and a TS is not blocked by this**

A `TS-*` for `BC-02` would satisfy `E-1` (PRD frozen), `E-2` (Stage 3
passed), `E-3` (ADRs identifiable) and `E-4`'s second limb (10 `MM-GAP-*`
registered with owners). ⛔ **But this Design Doc confers nothing toward it**:
Stage `6A` requires an **ADR-borne conferral**, and a Design Doc is
⛔ **UNRANKED input, never authority**. ⛔ **No `TS-003` is created, implied
or authorised.**

### 19.3 Honest weaknesses

1. ⛔ **Unvalidated with real students.** No usability testing, no research artifact. Every §2 row is a *reasoned response to a recorded constraint*, ⛔ **not** a validated finding.
2. ⛔ **Accessibility unverifiable** while the standard is undecided — and the codebase baseline is measurably **zero**.
3. ⛔ **Not implementable today** — all 5 surface tasks blocked (§17.1).
4. ⚠️ **The external skill's visual system was rejected wholesale.** Its data is strongest on interaction/accessibility/performance mechanics and weakest here, where it optimised for conversion rather than operational trust.
5. ⚠️ **Two existing screens already render membership data** and may contradict this design (`GAP-009`); reconciling them is a QA act not performed here.

---

## 20. Review triggers

| Trigger | Consequence |
|---|---|
| `PRD-005` amended | Re-verify all 13 §6 rows |
| Accessibility standard selected | `GAP-003` actionable; §11 gains thresholds |
| Breakpoints defined | `GAP-004` actionable; §12 gains values |
| `DBT-001` decided | `GAP-006` actionable; §8.4/§9.3 completable |
| `ADR-0012` §3.4 seam resolved | `GAP-007`; 5 surface tasks unblock |
| `MM-GAP-008` settled | Single-day plans become designable |
| Design System Owner reviews §9.2 | `GAP-012` |
| A `TS-*` proposed for `BC-02` | ⛔ This is **input, not authority**; `E-1`…`E-4` still apply |

## 21. Changelog

| Version | Date | Change |
|---|---|---|
| **v0.2** | 2026-09-11 | ⭐⭐ **Expanded to full implementation-handoff depth** using UI/UX Pro Max `15de38f` as **subordinate** method. Added: §2 Indian-student context (11 rows, each tied to a recorded basis) · §4 IA · §5 four flows with branches · §7 **all 6 states × 13 surfaces** *(was 3 of 6)* · §8 2D/2.5D/3D allocation with reasons · §9 **6 new components, each justified** · §10 five motion classes · §11 nine a11y checks per surface · §12 responsive behaviour · §13 performance · §14 security/privacy UX · §15 **11 QA blocking conditions** · §16 handoff · §19 readiness verdict. ⭐⭐ **The skill's `--design-system` output was REJECTED with reasons** (funnel/vibrant/magenta/serif vs CONFIRMED 2.5D operational direction); its interaction, accessibility, layout and performance mechanics were adopted. ⚠️ **Flutter version delta disclosed** (skill 3.44.x vs locked 3.35.4). ⛔ **0** requirements invented · ⛔ **0** tokens ratified · ⛔ **0** breakpoints, languages or a11y standards decided · ⛔ **0** `MM-GAP-*` closed · ⛔ **0** permissions · ⛔ no `TS-*` · ⛔ no PRD/ADR/architecture/code touched. Gaps **9 → 12** |
| **v0.1** | 2026-09-11 | ⭐ Created as `PROPOSED`. First `DD-*` in this repository. 13 surfaces traced to `PRD-005` §20; 9 gaps registered |
